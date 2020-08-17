/*
 * =======================================================================================
 *
 *      Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *      Copyright (c) 2019 RRZE, University Erlangen-Nuremberg
 *
 *      Permission is hereby granted, free of charge, to any person obtaining a copy
 *      of this software and associated documentation files (the "Software"), to deal
 *      in the Software without restriction, including without limitation the rights
 *      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *      copies of the Software, and to permit persons to whom the Software is
 *      furnished to do so, subject to the following conditions:
 *
 *      The above copyright notice and this permission notice shall be included in all
 *      copies or substantial portions of the Software.
 *
 *      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *      SOFTWARE.
 *
 * =======================================================================================
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <math.h>
#include <float.h>

#define HLINE "----------------------------------------------------------------------------\n"

#define FACTOR 0.999
#define SMALL 1.0e-6
#define DELTA 20000

#ifndef MIN
#define MIN(x,y) ((x)<(y)?(x):(y))
#endif
#ifndef MAX
#define MAX(x,y) ((x)>(y)?(x):(y))
#endif
#ifndef ABS
#define ABS(a) ((a) >= 0 ? (a) : -(a))
#endif

static int Natoms, Nlocal, Nghost, Nmax;
static double Cutneigh;                 // neighbor cutoff
static double xprd, yprd, zprd;
static double xlo, xhi;
static double ylo, yhi;
static double zlo, zhi;
static double *x, *y, *z;
static double *vx, *vy, *vz;
static double *fx, *fy, *fz;
static double eng_vdwl;
static double virial;

static int NmaxGhost;
static int *BorderMap;
static int *PBCx, *PBCy, *PBCz;

typedef struct {
    int* numneigh;
    int* neighbors;
    int maxneighs;
    int nbinx, nbiny, nbinz;
    /* double cutneigh;                 // neighbor cutoff */
    double cutneighsq;               // neighbor cutoff squared
    int every;
    int ncalls;
    int max_totalneigh;
    int *bincount;
    int *bins;
    int nmax;
    int nstencil;                    // # of bins in stencil
    int* stencil;                    // stencil list of bin offsets
    int mbins; //total number of bins
    int atoms_per_bin;  // max atoms per bin
    int mbinx, mbiny, mbinz; // n bins in x, y, z
    int mbinxlo, mbinylo, mbinzlo;
    double binsizex, binsizey, binsizez;
    double bininvx, bininvy, bininvz;
} Neighbor;

typedef struct {
    double epsilon;
    double sigma6;
    double temp;
    double rho;
    double mass;
    int ntimes;
    int nstat;
    double dt;
    double dtforce;
    double cutforce;
    int nx, ny, nz;
} Parameter;

typedef struct {
    int *steparr;
    double *tmparr;
    double *engarr;
    double *prsarr;
    double mvv2e;
    int dof_boltz;
    double t_scale;
    double p_scale;
    double e_scale;
    double t_act;
    double p_act;
    double e_act;
    int mstat;
    int nstat;
} Thermo;

/* Park/Miller RNG w/out MASKING, so as to be like f90s version */
#define IA 16807
#define IM 2147483647
#define AM (1.0/IM)
#define IQ 127773
#define IR 2836
#define MASK 123459876

double myrandom(int* idum)
{
    int k;
    double ans;

    k = (*idum) / IQ;
    *idum = IA * (*idum - k * IQ) - IR * k;

    if(*idum < 0) *idum += IM;

    ans = AM * (*idum);
    return ans;
}

// Neighbor list related subroutines

// convert atom coordinates in bin index
int coord2bin(Neighbor* neighbor, double xin, double yin, double zin)
{
    int ix, iy, iz;
    double bininvx = neighbor->bininvx;
    double bininvy = neighbor->bininvy;
    double bininvz = neighbor->bininvz;
    int mbinxlo = neighbor->mbinxlo;
    int mbinylo = neighbor->mbinylo;
    int mbinzlo = neighbor->mbinzlo;

    if(xin >= xprd) {
        ix = (int)((xin - xprd) * bininvx) + neighbor->nbinx - mbinxlo;
    } else if(xin >= 0.0) {
        ix = (int)(xin * bininvx) - mbinxlo;
    } else {
        ix = (int)(xin * bininvx) - mbinxlo - 1;
    }

    if(yin >= yprd) {
        iy = (int)((yin - yprd) * bininvy) + neighbor->nbiny - mbinylo;
    } else if(yin >= 0.0) {
        iy = (int)(yin * bininvy) - mbinylo;
    } else {
        iy = (int)(yin * bininvy) - mbinylo - 1;
    }

    if(zin >= zprd) {
        iz = (int)((zin - zprd) * bininvz) + neighbor->nbinz - mbinzlo;
    } else if(zin >= 0.0) {
        iz = (int)(zin * bininvz) - mbinzlo;
    } else {
        iz = (int)(zin * bininvz) - mbinzlo - 1;
    }

    return (iz * neighbor->mbiny * neighbor->mbinx + iy * neighbor->mbinx + ix + 1);
}


// Sort atoms in bins. All bins can hold the same number of max atoms
// If one bin is exceeded reallocate and start over.
void binatoms(Neighbor *neighbor)
{
    int* bincount = neighbor->bincount;
    int mbins = neighbor->mbins;
    int nall = Nlocal + Nghost;
    int resize = 1;

    while(resize > 0) {
        resize = 0;

        for(int i = 0; i < mbins; i++) {
            bincount[i] = 0;
        }

        for(int i = 0; i < nall; i++) {
            int ibin = coord2bin(neighbor, x[i], y[i], z[i]);

            if(bincount[ibin] < neighbor->atoms_per_bin) {
                int ac = neighbor->bincount[ibin]++;
                neighbor->bins[ibin * neighbor->atoms_per_bin + ac] = i;
            } else {
                resize = 1;
            }
        }

        if(resize) {
            free(neighbor->bins);
            neighbor->atoms_per_bin *= 2;
            neighbor->bins = (int*) malloc(mbins * neighbor->atoms_per_bin * sizeof(int));
        }
    }
}

/* compute closest distance between central bin (0,0,0) and bin (i,j,k) */
double bindist(Neighbor *neighbor, int i, int j, int k)
{
    double delx, dely, delz;

    if(i > 0) {
        delx = (i - 1) * neighbor->binsizex;
    } else if(i == 0) {
        delx = 0.0;
    } else {
        delx = (i + 1) * neighbor->binsizex;
    }

    if(j > 0) {
        dely = (j - 1) * neighbor->binsizey;
    } else if(j == 0) {
        dely = 0.0;
    } else {
        dely = (j + 1) * neighbor->binsizey;
    }

    if(k > 0) {
        delz = (k - 1) * neighbor->binsizez;
    } else if(k == 0) {
        delz = 0.0;
    } else {
        delz = (k + 1) * neighbor->binsizez;
    }

    return (delx * delx + dely * dely + delz * delz);
}

void buildNeighborlist(Neighbor *neighbor)
{
    neighbor->ncalls++;
    int nall = Nlocal + Nghost;

    /* extend atom arrays if necessary */
    if(nall > neighbor->nmax) {
        neighbor->nmax = nall;
        if(neighbor->numneigh) free(neighbor->numneigh);
        if(neighbor->neighbors) free(neighbor->neighbors);
        neighbor->numneigh = (int*) malloc(neighbor->nmax * sizeof(int));
        neighbor->neighbors = (int*) malloc(neighbor->nmax * neighbor->maxneighs * sizeof(int*));
    }

    /* bin local & ghost atoms */
    binatoms(neighbor);
    int resize = 1;

    /* loop over each atom, storing neighbors */
    while(resize) {
        int new_maxneighs = neighbor->maxneighs;
        resize = 0;

        for(int i = 0; i < Nlocal; i++) {
            int* neighptr = &neighbor->neighbors[i * neighbor->maxneighs];
            int n = 0;
            double xtmp = x[i];
            double ytmp = y[i];
            double ztmp = z[i];
            int ibin = coord2bin(neighbor, xtmp, ytmp, ztmp);

            for(int k = 0; k < neighbor->nstencil; k++) {
                int jbin = ibin + neighbor->stencil[k];
                int* loc_bin = &neighbor->bins[jbin * neighbor->atoms_per_bin];

                for(int m = 0; m < neighbor->bincount[jbin]; m++) {
                    int j = loc_bin[m];

                    if ( j == i ){
                        continue;
                    }

                    double delx = xtmp - x[j];
                    double dely = ytmp - y[j];
                    double delz = ztmp - z[j];
                    double rsq = delx * delx + dely * dely + delz * delz;

                    if( rsq <= neighbor->cutneighsq ) {
                        neighptr[n++] = j;
                    }
                }
            }

            neighbor->numneigh[i] = n;

            if(n >= neighbor->maxneighs) {
                resize = 1;

                if(n >= new_maxneighs) {
                    new_maxneighs = n;
                }
            }
        }

        if(resize) {
            neighbor->maxneighs = new_maxneighs * 1.2;
            free(neighbor->neighbors);
            neighbor->neighbors = (int*) malloc(Nmax* neighbor->maxneighs * sizeof(int));
        }
    }
}

void init(Neighbor *neighbor, Parameter *param)
{
    x = NULL; y = NULL; z = NULL;
    vx = NULL; vy = NULL; vz = NULL;
    fx = NULL; fy = NULL; fz = NULL;

    NmaxGhost = 0;
    BorderMap = NULL;
    PBCx = NULL; PBCy = NULL; PBCz = NULL;

    param->epsilon = 1.0;
    param->sigma6 = 1.0;
    param->rho = 0.8442;
    param->ntimes = 200;
    param->dt = 0.005;
    param->nx = 32;
    param->ny = 32;
    param->nz = 32;
    param->cutforce = 2.5;
    param->temp = 1.44;
    param->nstat = 100;
    param->mass = 1.0;
    param->dtforce = 0.5 * param->dt;

    Cutneigh = param->cutforce + 0.30;
    double neighscale = 5.0 / 6.0;
    neighbor->nbinx = neighscale * param->nx;
    neighbor->nbiny = neighscale * param->ny;
    neighbor->nbinz = neighscale * param->nz;
    neighbor->every = 20;
    neighbor->ncalls = 0;
    neighbor->nmax = 0;
    neighbor->atoms_per_bin = 8;
    neighbor->maxneighs = 100;
    /* neighbor->cutneigh = param->cutforce + 0.30; */
    neighbor->numneigh = NULL;
    neighbor->neighbors = NULL;
    neighbor->stencil = NULL;
    neighbor->bins = NULL;
    neighbor->bincount = NULL;
}

void setup(Neighbor *neighbor, Parameter *param)
{
    double lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    double coord;
    int mbinxhi, mbinyhi, mbinzhi;
    int nextx, nexty, nextz;

    xprd = param->nx * lattice;
    yprd = param->ny * lattice;
    zprd = param->nz * lattice;

    xlo = 0.0; xhi = xprd;
    ylo = 0.0; yhi = yprd;
    zlo = 0.0; zhi = zprd;

    neighbor->cutneighsq = Cutneigh * Cutneigh;
    neighbor->binsizex = xprd / neighbor->nbinx;
    neighbor->binsizey = yprd / neighbor->nbiny;
    neighbor->binsizez = zprd / neighbor->nbinz;

    neighbor->bininvx = 1.0 / neighbor->binsizex;
    neighbor->bininvy = 1.0 / neighbor->binsizey;
    neighbor->bininvz = 1.0 / neighbor->binsizez;

    // x coordinate
    coord = xlo - Cutneigh - SMALL * xprd;
    neighbor->mbinxlo = (int) (coord * neighbor->bininvx);

    if (coord < 0.0) {
        neighbor->mbinxlo = neighbor->mbinxlo - 1;
    }

    coord = xhi + Cutneigh + SMALL * xprd;
    mbinxhi = (int) (coord * neighbor->bininvx);

    // y coordinate
    coord = ylo - Cutneigh - SMALL * yprd;
    neighbor->mbinylo = (int) (coord * neighbor->bininvy);

    if (coord < 0.0) {
        neighbor->mbinylo = neighbor->mbinylo - 1;
    }

    coord = yhi + Cutneigh + SMALL * yprd;
    mbinyhi = (int) (coord * neighbor->bininvy);

    // z coordinate
    coord = zlo - Cutneigh - SMALL * zprd;
    neighbor->mbinzlo = (int) (coord * neighbor->bininvz);

    if (coord < 0.0) {
        neighbor->mbinzlo = neighbor->mbinzlo - 1;
    }

    coord = zhi + Cutneigh + SMALL * zprd;
    mbinzhi = (int) (coord * neighbor->bininvz);


    neighbor->mbinxlo = neighbor->mbinxlo - 1;
    mbinxhi = mbinxhi + 1;
    neighbor->mbinx = mbinxhi - neighbor->mbinxlo + 1;

    neighbor->mbinylo = neighbor->mbinylo - 1;
    mbinyhi = mbinyhi + 1;
    neighbor->mbiny = mbinyhi - neighbor->mbinylo + 1;

    neighbor->mbinzlo = neighbor->mbinzlo - 1;
    mbinzhi = mbinzhi + 1;
    neighbor->mbinz = mbinzhi - neighbor->mbinzlo + 1;

    nextx = (int) (Cutneigh * neighbor->bininvx);
    if(nextx * neighbor->binsizex < FACTOR * Cutneigh) nextx++;

    nexty = (int) (Cutneigh * neighbor->bininvy);
    if(nexty * neighbor->binsizey < FACTOR * Cutneigh) nexty++;

    nextz = (int) (Cutneigh * neighbor->bininvz);
    if(nextz * neighbor->binsizez < FACTOR * Cutneigh) nextz++;

    if (neighbor->stencil) {
        free(neighbor->stencil);
    }

    neighbor->stencil = (int*) malloc(
            (2 * nextz + 1) * (2 * nexty + 1) * (2 * nextx + 1) * sizeof(int));

    neighbor->nstencil = 0;
    int kstart = -nextz;

    for(int k = kstart; k <= nextz; k++) {
        for(int j = -nexty; j <= nexty; j++) {
            for(int i = -nextx; i <= nextx; i++) {
                if(bindist(neighbor, i, j, k) < neighbor->cutneighsq) {
                    neighbor->stencil[neighbor->nstencil++] =
                        k * neighbor->mbiny * neighbor->mbinx + j * neighbor->mbinx + i;
                }
            }
        }
    }

/*     printf("STENCIL %d \n", neighbor->nstencil); */
/*     for (int i=0; i<neighbor->nstencil; i++) { */
/*         printf("%d ", neighbor->stencil[i]); */
/*     } */
/*     printf("\n"); */

    neighbor->mbins = neighbor->mbinx * neighbor->mbiny * neighbor->mbinz;

    if (neighbor->bincount) {
        free(neighbor->bincount);
    }
    neighbor->bincount = (int*) malloc(neighbor->mbins * sizeof(int));

    if (neighbor->bins) {
        free(neighbor->bins);
    }
    neighbor->bins = (int*) malloc(neighbor->mbins * neighbor->atoms_per_bin * sizeof(int));
}

double* myrealloc(double *ptr, int n, int nold) {

    double* newarray;

    newarray = (double*) malloc(n * sizeof(double));

    if(nold) {
        memcpy(newarray, ptr, nold * sizeof(double));
    }

    if(ptr) {
        free(ptr);
    }

    return newarray;
}

int* myreallocInt(int *ptr, int n, int nold) {

    int* newarray;

    newarray = (int*) malloc(n * sizeof(int));

    if(nold) {
        memcpy(newarray, ptr, nold * sizeof(int));
    }

    if(ptr) {
        free(ptr);
    }

    return newarray;
}

void growBoundary()
{
    int nold = NmaxGhost;
    NmaxGhost += DELTA;

    BorderMap =  myreallocInt(BorderMap, NmaxGhost, nold);
    PBCx =  myreallocInt(PBCx, NmaxGhost, nold);
    PBCy =  myreallocInt(PBCy, NmaxGhost, nold);
    PBCz =  myreallocInt(PBCz, NmaxGhost, nold);

    if(BorderMap == NULL || PBCx == NULL || PBCy == NULL || PBCz == NULL ) {
        printf("ERROR: No memory for Boundary\n");
    }
}

void growarray()
{
    int nold = Nmax;
    Nmax += DELTA;

    x =  myrealloc(x, Nmax, nold);
    y =  myrealloc(y, Nmax, nold);
    z =  myrealloc(z, Nmax, nold);
    vx =  myrealloc(vx, Nmax, nold);
    vy =  myrealloc(vy, Nmax, nold);
    vz =  myrealloc(vz, Nmax, nold);
    fx =  myrealloc(fx, Nmax, nold);
    fy =  myrealloc(fy, Nmax, nold);
    fz =  myrealloc(fz, Nmax, nold);

    if(x == NULL || y == NULL || z == NULL ||
            vx == NULL || vy == NULL || vz == NULL ||
            fx == NULL || fy == NULL || fz == NULL ) {
        printf("ERROR: No memory for atoms\n");
    }
}

void updateBorders()
{
    for(int i = 0; i < Nghost; i++) {
        x[Nlocal + i] = x[BorderMap[i]] + PBCx[i] * xprd;
        y[Nlocal + i] = y[BorderMap[i]] + PBCy[i] * yprd;
        z[Nlocal + i] = z[BorderMap[i]] + PBCz[i] * zprd;
    }
}

void updateAtomLocations()
{
    for(int i = 0; i < Nlocal; i++) {

        /* Relocate atoms that have left the domain */
        if(x[i] < 0.0) {
            x[i] += xprd;
        } else if(x[i] >= xprd) {
            x[i] -= xprd;
        }

        if(y[i] < 0.0) {
            y[i] += yprd;
        } else if(y[i] >= yprd) {
            y[i] -= yprd;
        }

        if(z[i] < 0.0) {
            z[i] += zprd;
        } else if(z[i] >= zprd) {
            z[i] -= zprd;
        }
    }
}

void setupBordersNew()
{
    int lastidx = 0;
    int nghostprev = 0;
    Nghost = 0;

    for (int i = 0; i < Nlocal; i++) {

        if (Nlocal + Nghost + 1 >= Nmax) {
            growarray();
        }

        if (x[i] < Cutneigh) {
            Nghost++;
            x[i+lastidx] = x[i] + xprd;
            y[i+lastidx] = y[i];
            z[i+lastidx] = z[i];
            lastidx++;
        } else if (x[i] >= xprd - Cutneigh) {
            Nghost++;
            x[i+lastidx] = x[i] - xprd;
            y[i+lastidx] = y[i];
            z[i+lastidx] = z[i];
            lastidx++;
        }
    }

    nghostprev = Nghost+1;

    for (int i = 0; i < Nlocal + nghostprev ; i++) {

        if (Nlocal + Nghost + 1 >= Nmax) {
            growarray();
        }

        if (y[i] < Cutneigh) {
                Nghost++;
                x[i+lastidx] = x[i];
                y[i+lastidx] = y[i] + yprd;
                z[i+lastidx] = z[i];
            lastidx++;
        } else if (y[i] >= yprd - Cutneigh) {
                Nghost++;
                x[i+lastidx] = x[i];
                y[i+lastidx] = y[i] - yprd;
                z[i+lastidx] = z[i];
            lastidx++;
        }
    }

    nghostprev = Nghost+1;

    for (int i = 0; i < Nlocal + nghostprev; i++) {

        if (Nlocal + Nghost + 1 >= Nmax) {
            growarray();
        }

        if (z[i] < Cutneigh) {
                Nghost++;
                x[i+lastidx] = x[i];
                y[i+lastidx] = y[i];
                z[i+lastidx] = z[i] + zprd;
            lastidx++;
        } else if(z[i] >= zprd - Cutneigh) {
                Nghost++;
                x[i+lastidx] = x[i];
                y[i+lastidx] = y[i];
                z[i+lastidx] = z[i] - zprd;
            lastidx++;
        }
    }

    Nghost++;
}

#define ADDGHOST(dx,dy,dz) Nghost++; BorderMap[Nghost] = i; PBCx[Nghost] = dx; PBCy[Nghost] = dy; PBCz[Nghost] = dz;

/* Enforce periodic boundary conditions
 * Relocate atoms that have left domain for
 * 6 planes (and 8 corners (diagonal))
 * Setup ghost atoms at boundaries*/
void setupBorders()
{
    Nghost = -1;

    for(int i = 0; i < Nlocal; i++) {

        if (Nlocal + Nghost + 7 >= Nmax) {
            growarray();
        }

        if (Nghost + 7 >= NmaxGhost) {
            growBoundary();
        }

        /* Setup ghost atoms */
        /* 6 planes */
        if (x[i] < Cutneigh)         { ADDGHOST(+1,0,0); }
        if (x[i] >= (xprd-Cutneigh)) { ADDGHOST(-1,0,0); }
        if (y[i] < Cutneigh)         { ADDGHOST(0,+1,0); }
        if (y[i] >= (yprd-Cutneigh)) { ADDGHOST(0,-1,0); }
        if (z[i] < Cutneigh)         { ADDGHOST(0,0,+1); }
        if (z[i] >= (zprd-Cutneigh)) { ADDGHOST(0,0,-1); }
        /* 8 corners */
        if (x[i] < Cutneigh         && y[i] < Cutneigh         && z[i] < Cutneigh)         { ADDGHOST(+1,+1,+1); }
        if (x[i] < Cutneigh         && y[i] >= (yprd-Cutneigh) && z[i] < Cutneigh)         { ADDGHOST(+1,-1,+1); }
        if (x[i] < Cutneigh         && y[i] >= Cutneigh        && z[i] >= (zprd-Cutneigh)) { ADDGHOST(+1,+1,-1); }
        if (x[i] < Cutneigh         && y[i] >= (yprd-Cutneigh) && z[i] >= (zprd-Cutneigh)) { ADDGHOST(+1,-1,-1); }
        if (x[i] >= (xprd-Cutneigh) && y[i] < Cutneigh         && z[i] < Cutneigh)         { ADDGHOST(-1,+1,+1); }
        if (x[i] >= (xprd-Cutneigh) && y[i] >= (yprd-Cutneigh) && z[i] < Cutneigh)         { ADDGHOST(-1,-1,+1); }
        if (x[i] >= (xprd-Cutneigh) && y[i] < Cutneigh         && z[i] >= (zprd-Cutneigh)) { ADDGHOST(-1,+1,-1); }
        if (x[i] >= (xprd-Cutneigh) && y[i] >= (yprd-Cutneigh) && z[i] >= (zprd-Cutneigh)) { ADDGHOST(-1,-1,-1); }
        /* 12 edges */
        if (x[i] < Cutneigh         && z[i] < Cutneigh)         { ADDGHOST(+1,0,+1); }
        if (x[i] < Cutneigh         && z[i] >= (zprd-Cutneigh)) { ADDGHOST(+1,0,-1); }
        if (x[i] >= (xprd-Cutneigh) && z[i] < Cutneigh)         { ADDGHOST(-1,0,+1); }
        if (x[i] >= (xprd-Cutneigh) && z[i] >= (zprd-Cutneigh)) { ADDGHOST(-1,0,-1); }
        if (y[i] < Cutneigh         && z[i] < Cutneigh)         { ADDGHOST(0,+1,+1); }
        if (y[i] < Cutneigh         && z[i] >= (zprd-Cutneigh)) { ADDGHOST(0,+1,-1); }
        if (y[i] >= (yprd-Cutneigh) && z[i] < Cutneigh)         { ADDGHOST(0,-1,+1); }
        if (y[i] >= (yprd-Cutneigh) && z[i] >= (zprd-Cutneigh)) { ADDGHOST(0,-1,-1); }
        if (y[i] < Cutneigh         && x[i] < Cutneigh)         { ADDGHOST(+1,+1,0); }
        if (y[i] < Cutneigh         && x[i] >= (xprd-Cutneigh)) { ADDGHOST(-1,+1,0); }
        if (y[i] >= (yprd-Cutneigh) && x[i] < Cutneigh)         { ADDGHOST(+1,-1,0); }
        if (y[i] >= (yprd-Cutneigh) && x[i] >= (xprd-Cutneigh)) { ADDGHOST(-1,-1,0); }
    }

    // increase by one to make it the ghost atom count
    Nghost++;
}

/* place atoms in the same bin consecutive in memory */
void sortAtoms(Neighbor *neighbor)
{
    binatoms(neighbor);
    int* binpos = neighbor->bincount;
    int* bins = neighbor->bins;

    int mbins = neighbor->mbins;
    int atoms_per_bin = neighbor->atoms_per_bin;

    for(int i=1; i<mbins; i++) {
        binpos[i] += binpos[i-1];
    }

    double* new_x = (double*) malloc(Nmax * sizeof(double));
    double* new_y = (double*) malloc(Nmax * sizeof(double));
    double* new_z = (double*) malloc(Nmax * sizeof(double));
    double* new_vx = (double*) malloc(Nmax * sizeof(double));
    double* new_vy = (double*) malloc(Nmax * sizeof(double));
    double* new_vz = (double*) malloc(Nmax * sizeof(double));

    double* old_x = x;
    double* old_y = y;
    double* old_z = z;
    double* old_vx = vx;
    double* old_vy = vy;
    double* old_vz = vz;

    for(int mybin = 0; mybin<mbins; mybin++) {
        int start = mybin>0?binpos[mybin-1]:0;
        int count = binpos[mybin] - start;

        for(int k=0; k<count; k++) {
            int new_i = start + k;
            int old_i = bins[mybin * atoms_per_bin + k];
            new_x[new_i] = old_x[old_i];
            new_y[new_i] = old_y[old_i];
            new_z[new_i] = old_z[old_i];
            new_vx[new_i] = old_vx[old_i];
            new_vy[new_i] = old_vy[old_i];
            new_vz[new_i] = old_vz[old_i];
        }
    }

    free(x); free(y); free(z);
    free(vx); free(vy); free(vz);

    x = new_x;
    y = new_y;
    z = new_z;
    vx = new_vx;
    vy = new_vy;
    vz = new_vz;
}

void create_atoms(Parameter *param)
{
    /* total # of atoms */
    Natoms = 4 * param->nx * param->ny * param->nz;
    Nlocal = 0;

    /* determine loop bounds of lattice subsection that overlaps my sub-box
       insure loop bounds do not exceed nx,ny,nz */
    double alat = pow((4.0 / param->rho), (1.0 / 3.0));
    int ilo = (int) (xlo / (0.5 * alat) - 1);
    int ihi = (int) (xhi / (0.5 * alat) + 1);
    int jlo = (int) (ylo / (0.5 * alat) - 1);
    int jhi = (int) (yhi / (0.5 * alat) + 1);
    int klo = (int) (zlo / (0.5 * alat) - 1);
    int khi = (int) (zhi / (0.5 * alat) + 1);

    ilo = MAX(ilo, 0);
    ihi = MIN(ihi, 2 * param->nx - 1);
    jlo = MAX(jlo, 0);
    jhi = MIN(jhi, 2 * param->ny - 1);
    klo = MAX(klo, 0);
    khi = MIN(khi, 2 * param->nz - 1);

    /* printf("CA alat=%f ilo=%d ihi=%d jlo=%d jhi=%d klo=%d khi=%d\n", */
            /* alat, ilo, ihi, jlo, jhi, klo, khi); */

    double xtmp, ytmp, ztmp, vxtmp, vytmp, vztmp;
    int i, j, k, m, n;
    int sx = 0; int sy = 0; int sz = 0;
    int ox = 0; int oy = 0; int oz = 0;
    int subboxdim = 8;

    while(oz * subboxdim <= khi) {

        k = oz * subboxdim + sz;
        j = oy * subboxdim + sy;
        i = ox * subboxdim + sx;

        if(((i + j + k) % 2 == 0) &&
                (i >= ilo) && (i <= ihi) &&
                (j >= jlo) && (j <= jhi) &&
                (k >= klo) && (k <= khi)) {

            xtmp = 0.5 * alat * i;
            ytmp = 0.5 * alat * j;
            ztmp = 0.5 * alat * k;

            if( xtmp >= xlo && xtmp < xhi &&
                    ytmp >= ylo && ytmp < yhi &&
                    ztmp >= zlo && ztmp < zhi ) {

                n = k * (2 * param->ny) * (2 * param->nx) +
                    j * (2 * param->nx) +
                    i + 1;

                for(m = 0; m < 5; m++) {
                    myrandom(&n);
                }
                vxtmp = myrandom(&n);

                for(m = 0; m < 5; m++){
                    myrandom(&n);
                }
                vytmp = myrandom(&n);

                for(m = 0; m < 5; m++) {
                    myrandom(&n);
                }
                vztmp = myrandom(&n);

                if(Nlocal == Nmax) {
                    growarray();
                }

                /* printf("%d %f %f %f\n",Nlocal, xtmp, ytmp, ztmp); */

                x[Nlocal] = xtmp;
                y[Nlocal] = ytmp;
                z[Nlocal] = ztmp;
                vx[Nlocal] = vxtmp;
                vy[Nlocal] = vytmp;
                vz[Nlocal] = vztmp;

                Nlocal++;
            }
        }

        sx++;

        if(sx == subboxdim) {
            sx = 0;
            sy++;
        }

        if(sy == subboxdim) {
            sy = 0;
            sz++;
        }

        if(sz == subboxdim) {
            sz = 0;
            ox++;
        }

        if(ox * subboxdim > ihi) {
            ox = 0;
            oy++;
        }

        if(oy * subboxdim > jhi) {
            oy = 0;
            oz++;
        }
    }
}


void adjustVelocity(Parameter *param, Thermo *thermo)
{
  /* zero center-of-mass motion */
  double vxtot = 0.0;
  double vytot = 0.0;
  double vztot = 0.0;

  for(int i = 0; i < Nlocal; i++) {
    vxtot += vx[i];
    vytot += vy[i];
    vztot += vz[i];
  }

  vxtot = vxtot / Natoms;
  vytot = vytot / Natoms;
  vztot = vztot / Natoms;

  for(int i = 0; i < Nlocal; i++) {
    vx[i] -= vxtot;
    vy[i] -= vytot;
    vz[i] -= vztot;
  }

  /* rescale velocities, including old ones */
  thermo->t_act = 0;
  double t = 0.0;

  for(int i = 0; i < Nlocal; i++) {
    t += (vx[i] * vx[i] + vy[i] * vy[i] + vz[i] * vz[i]) * param->mass;
  }

  t *= thermo->t_scale;
  double factor = sqrt(param->temp / t);

  for(int i = 0; i < Nlocal; i++) {
    vx[i] *= factor;
    vy[i] *= factor;
    vz[i] *= factor;
  }
}

void thermoSetup(Parameter *param, Thermo *thermo)
{
    int maxstat = param->ntimes / param->nstat + 2;

    thermo->steparr = (int*) malloc(maxstat * sizeof(int));
    thermo->tmparr = (double*) malloc(maxstat * sizeof(double));
    thermo->engarr = (double*) malloc(maxstat * sizeof(double));
    thermo->prsarr = (double*) malloc(maxstat * sizeof(double));

    thermo->mvv2e = 1.0;
    thermo->dof_boltz = (Natoms * 3 - 3);
    thermo->t_scale = thermo->mvv2e / thermo->dof_boltz;
    thermo->p_scale = 1.0 / 3 / xprd / yprd / zprd;
    thermo->e_scale = 0.5;

    eng_vdwl = 0.0;
    virial = 0.0;
}


void thermoCompute(int iflag, Parameter *param, Thermo *thermo)
{
    double t, eng, p;

    if(iflag > 0 && iflag % param->nstat){
        return;
    }

    if(iflag == -1 && param->nstat > 0 && param->ntimes % param->nstat == 0)
    {
        return;
    }

    t = 0.0;

    for(int i = 0; i < Nlocal; i++) {
        t += (vx[i] * vx[i] + vy[i] * vy[i] + vz[i] * vz[i]) * param->mass;
    }

    t = t * thermo->t_scale;
    eng = eng_vdwl * thermo->e_scale / Natoms;
    p = (t * thermo->dof_boltz) * thermo->p_scale;

    int istep = iflag;

    if(iflag == -1){
        istep = param->ntimes;
    }

    if(iflag == 0){
        thermo->mstat = 0;
    }

    thermo->steparr[thermo->mstat] = istep;
    thermo->tmparr[thermo->mstat] = t;
    thermo->engarr[thermo->mstat] = eng;
    thermo->prsarr[thermo->mstat] = p;

    thermo->mstat++;
    fprintf(stdout, "%i %e %e %e\n", istep, t, eng, p);
}


void initialIntegrate(Parameter *param)
{
    /* printf("dtforce %f dt %f\n",param->dtforce, param->dt); */

    for(int i = 0; i < Nlocal; i++) {
        vx[i] += param->dtforce * fx[i];
        vy[i] += param->dtforce * fy[i];
        vz[i] += param->dtforce * fz[i];
         /* if (i==129212) printf("f %f %f %f v %f %f %f\n",fx[i], fy[i], fz[i], vx[i], vy[i], vz[i] ); */
        x[i]  += param->dt * vx[i];
        y[i]  += param->dt * vy[i];
        z[i]  += param->dt * vz[i];
    }
        /* printf("C x = %f %f %f\n", x[129212], y[129212], z[129212]); */
}

void finalIntegrate(Parameter *param)
{
    for(int i = 0; i < Nlocal; i++) {
        vx[i] += param->dtforce * fx[i];
        vy[i] += param->dtforce * fy[i];
        vz[i] += param->dtforce * fz[i];
    }
}

void computeForce(Neighbor *neighbor, Parameter *param)
{
    int* neighs;
    double cutforcesq = param->cutforce * param->cutforce;
    double sigma6 = param->sigma6;
    double epsilon = param->epsilon;
    double t_eng_vdwl = 0.0;
    double t_virial = 0.0;

    for(int i = 0; i < Nlocal; i++) {
        fx[i] = 0.0;
        fy[i] = 0.0;
        fz[i] = 0.0;
    }

    // loop over all neighbors of my atoms
    // store force on atom i
    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        double xtmp = x[i];
        double ytmp = y[i];
        double ztmp = z[i];

        double fix = 0;
        double fiy = 0;
        double fiz = 0;
        /* printf("%d %d: ", i, numneighs); */

        for(int k = 0; k < numneighs; k++) {
            int j = neighs[k];
        /* printf("%d ", j); */
            double delx = xtmp - x[j];
            double dely = ytmp - y[j];
            double delz = ztmp - z[j];
            double rsq = delx * delx + dely * dely + delz * delz;


            if(rsq < cutforcesq) {
                double sr2 = 1.0 / rsq;
                double sr6 = sr2 * sr2 * sr2 * sigma6;
                double force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;

            /* if (i==129212){ */
            /*     printf("%d %f %f %f r %f",j, x[j],y[j],z[j],rsq); */
            /* } */
            /* if (i==129212){ */
            /*     printf("f %f", force); */
            /* } */
                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force;

                t_eng_vdwl += sr6 * (sr6 - 1.0) * epsilon;
                t_virial += (delx * delx + dely * dely + delz * delz) * force;
            /* if (i==129212){ */
            /*     printf("\n"); */
            /* } */
            }
        }
        /* printf("\n"); */

        fx[i] += fix;
        fy[i] += fiy;
        fz[i] += fiz;
    }

    eng_vdwl += (4.0 * t_eng_vdwl);
    virial += (0.5 * t_virial);
    /* exit(EXIT_SUCCESS); */
}

void printAtomState()
{
    printf("Atom counts: Natoms=%d Nlocal=%d Nghost=%d Nmax=%d\n",
            Natoms, Nlocal, Nghost, Nmax);

    int nall = Nlocal + Nghost;
    double min = -Cutneigh;
    double max = xprd + Cutneigh;

    /* for (int i=0; i<nall; i++) { */
    /*     printf("%d  %f %f %f\n", i, x[i], y[i], z[i]); */

    /*     if ( x[i] < min || x[i] > max || */
    /*             y[i] < min || y[i] > max || */
    /*             z[i] < min || z[i] > max) { */
    /*         printf("OOB!!\n"); */
    /*     } */
    /* } */
}

int main (int argc, char** argv)
{
    Neighbor neighbor;
    Parameter param;
    Thermo thermo;

    init(&neighbor, &param);
    setup(&neighbor, &param);
    create_atoms(&param);
    thermoSetup(&param, &thermo);
    adjustVelocity(&param, &thermo);
    setupBorders();
    updateBorders();
    /* printAtomState(); */
    /* exit(EXIT_SUCCESS); */
    buildNeighborlist(&neighbor);
    thermoCompute(0, &param, &thermo);
    computeForce(&neighbor, &param);

    for(int n = 0; n < param.ntimes; n++) {

        /* printf("A x = %f %f %f maps %d\n", x[176962], y[176962], z[176962], BorderMap[176962-Nlocal]); */
        /* printf("A x = %f %f %f\n", x[129212], y[129212], z[129212]); */
        initialIntegrate(&param);

        printf("x = %f %f %f\n", x[0], y[0], z[0]);
        if(!((n + 1) % neighbor.every)) {
            printf("Reneighbor at %d\n",n);
            updateAtomLocations();
            setupBorders();
            updateBorders();
            /* sortAtoms(&neighbor); */
            buildNeighborlist(&neighbor);
        } else {
            updateBorders();
        }
        /* printf("B x = %f %f %f\n", x[129212], y[129212], z[129212]); */
        /* printf("B x = %f %f %f\n", x[176962], y[176962], z[176962]); */

        computeForce(&neighbor, &param);
        finalIntegrate(&param);

        if(thermo.nstat) {
            thermoCompute(n + 1, &param, &thermo);
        }
    }

    thermoCompute(-1, &param, &thermo);

    return EXIT_SUCCESS;
}
