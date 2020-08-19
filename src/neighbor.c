/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *   Copyright (c) 2020 RRZE, University Erlangen-Nuremberg
 *
 *   This file is part of MD-Bench.
 *
 *   MD-Bench is free software: you can redistribute it and/or modify it
 *   under the terms of the GNU Lesser General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   MD-Bench is distributed in the hope that it will be useful, but WITHOUT ANY
 *   WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 *   PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
 *   details.
 *
 *   You should have received a copy of the GNU Lesser General Public License along
 *   with MD-Bench.  If not, see <https://www.gnu.org/licenses/>.
 * =======================================================================================
 */
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include <neighbor.h>
#include <parameter.h>
#include <atom.h>

#define SMALL 1.0e-6
#define FACTOR 0.999

static double xprd, yprd, zprd;
static double bininvx, bininvy, bininvz;
static int mbinxlo, mbinylo, mbinzlo;
static int nbinx, nbiny, nbinz;
static int mbinx, mbiny, mbinz; // n bins in x, y, z
static int *bincount;
static int *bins;
static int mbins; //total number of bins
static int atoms_per_bin;  // max atoms per bin
static double cutneigh;
static double cutneighsq;               // neighbor cutoff squared
static int nmax;
static int nstencil;                    // # of bins in stencil
static int* stencil;                    // stencil list of bin offsets
static double binsizex, binsizey, binsizez;

static int coord2bin(double, double , double);
static double bindist(int, int, int);

/* exported subroutines */
void initNeighbor(Neighbor *neighbor, Parameter *param)
{
    double lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    double neighscale = 5.0 / 6.0;
    xprd = param->nx * lattice;
    yprd = param->ny * lattice;
    zprd = param->nz * lattice;
    cutneigh = param->cutneigh;
    nbinx = neighscale * param->nx;
    nbiny = neighscale * param->ny;
    nbinz = neighscale * param->nz;
    nmax = 0;
    atoms_per_bin = 8;
    stencil = NULL;
    bins = NULL;
    bincount = NULL;
    neighbor->maxneighs = 100;
    neighbor->numneigh = NULL;
    neighbor->neighbors = NULL;
}

void setupNeighbor()
{
    double coord;
    int mbinxhi, mbinyhi, mbinzhi;
    int nextx, nexty, nextz;
    double xlo = 0.0; double xhi = xprd;
    double ylo = 0.0; double yhi = yprd;
    double zlo = 0.0; double zhi = zprd;

    cutneighsq = cutneigh * cutneigh;
    binsizex = xprd / nbinx;
    binsizey = yprd / nbiny;
    binsizez = zprd / nbinz;
    bininvx = 1.0 / binsizex;
    bininvy = 1.0 / binsizey;
    bininvz = 1.0 / binsizez;

    coord = xlo - cutneigh - SMALL * xprd;
    mbinxlo = (int) (coord * bininvx);
    if (coord < 0.0) {
        mbinxlo = mbinxlo - 1;
    }
    coord = xhi + cutneigh + SMALL * xprd;
    mbinxhi = (int) (coord * bininvx);

    coord = ylo - cutneigh - SMALL * yprd;
    mbinylo = (int) (coord * bininvy);
    if (coord < 0.0) {
        mbinylo = mbinylo - 1;
    }
    coord = yhi + cutneigh + SMALL * yprd;
    mbinyhi = (int) (coord * bininvy);

    coord = zlo - cutneigh - SMALL * zprd;
    mbinzlo = (int) (coord * bininvz);
    if (coord < 0.0) {
        mbinzlo = mbinzlo - 1;
    }
    coord = zhi + cutneigh + SMALL * zprd;
    mbinzhi = (int) (coord * bininvz);

    mbinxlo = mbinxlo - 1;
    mbinxhi = mbinxhi + 1;
    mbinx = mbinxhi - mbinxlo + 1;

    mbinylo = mbinylo - 1;
    mbinyhi = mbinyhi + 1;
    mbiny = mbinyhi - mbinylo + 1;

    mbinzlo = mbinzlo - 1;
    mbinzhi = mbinzhi + 1;
    mbinz = mbinzhi - mbinzlo + 1;

    nextx = (int) (cutneigh * bininvx);
    if(nextx * binsizex < FACTOR * cutneigh) nextx++;

    nexty = (int) (cutneigh * bininvy);
    if(nexty * binsizey < FACTOR * cutneigh) nexty++;

    nextz = (int) (cutneigh * bininvz);
    if(nextz * binsizez < FACTOR * cutneigh) nextz++;

    if (stencil) {
        free(stencil);
    }

    stencil = (int*) malloc(
            (2 * nextz + 1) * (2 * nexty + 1) * (2 * nextx + 1) * sizeof(int));

    nstencil = 0;
    int kstart = -nextz;

    for(int k = kstart; k <= nextz; k++) {
        for(int j = -nexty; j <= nexty; j++) {
            for(int i = -nextx; i <= nextx; i++) {
                if(bindist(i, j, k) < cutneighsq) {
                    stencil[nstencil++] =
                        k * mbiny * mbinx + j * mbinx + i;
                }
            }
        }
    }

    mbins = mbinx * mbiny * mbinz;

    if (bincount) {
        free(bincount);
    }
    bincount = (int*) malloc(mbins * sizeof(int));

    if (bins) {
        free(bins);
    }
    bins = (int*) malloc(mbins * atoms_per_bin * sizeof(int));
}

void buildNeighbor(Atom *atom, Neighbor *neighbor)
{
    int nall = atom->Nlocal + atom->Nghost;

    /* extend atom arrays if necessary */
    if(nall > nmax) {
        nmax = nall;
        if(neighbor->numneigh) free(neighbor->numneigh);
        if(neighbor->neighbors) free(neighbor->neighbors);
        neighbor->numneigh = (int*) malloc(nmax * sizeof(int));
        neighbor->neighbors = (int*) malloc(nmax * neighbor->maxneighs * sizeof(int*));
    }

    /* bin local & ghost atoms */
    binatoms(atom);
    int resize = 1;
    double* x = atom->x;
    double* y = atom->y;
    double* z = atom->z;

    /* loop over each atom, storing neighbors */
    while(resize) {
        int new_maxneighs = neighbor->maxneighs;
        resize = 0;

        for(int i = 0; i < atom->Nlocal; i++) {
            int* neighptr = &(neighbor->neighbors[i * neighbor->maxneighs]);
            int n = 0;
            double xtmp = x[i];
            double ytmp = y[i];
            double ztmp = z[i];
            int ibin = coord2bin(xtmp, ytmp, ztmp);

            for(int k = 0; k < nstencil; k++) {
                int jbin = ibin + stencil[k];
                int* loc_bin = &bins[jbin * atoms_per_bin];

                for(int m = 0; m < bincount[jbin]; m++) {
                    int j = loc_bin[m];

                    if ( j == i ){
                        continue;
                    }

                    double delx = xtmp - x[j];
                    double dely = ytmp - y[j];
                    double delz = ztmp - z[j];
                    double rsq = delx * delx + dely * dely + delz * delz;

                    if( rsq <= cutneighsq ) {
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
            printf("RESIZE %d\n", neighbor->maxneighs);
            neighbor->maxneighs = new_maxneighs * 1.2;
            free(neighbor->neighbors);
            neighbor->neighbors = (int*) malloc(atom->Nmax * neighbor->maxneighs * sizeof(int));
        }
    }
}

/* internal subroutines */
double bindist(int i, int j, int k)
{
    double delx, dely, delz;

    if(i > 0) {
        delx = (i - 1) * binsizex;
    } else if(i == 0) {
        delx = 0.0;
    } else {
        delx = (i + 1) * binsizex;
    }

    if(j > 0) {
        dely = (j - 1) * binsizey;
    } else if(j == 0) {
        dely = 0.0;
    } else {
        dely = (j + 1) * binsizey;
    }

    if(k > 0) {
        delz = (k - 1) * binsizez;
    } else if(k == 0) {
        delz = 0.0;
    } else {
        delz = (k + 1) * binsizez;
    }

    return (delx * delx + dely * dely + delz * delz);
}

int coord2bin(double xin, double yin, double zin)
{
    int ix, iy, iz;

    if(xin >= xprd) {
        ix = (int)((xin - xprd) * bininvx) + nbinx - mbinxlo;
    } else if(xin >= 0.0) {
        ix = (int)(xin * bininvx) - mbinxlo;
    } else {
        ix = (int)(xin * bininvx) - mbinxlo - 1;
    }

    if(yin >= yprd) {
        iy = (int)((yin - yprd) * bininvy) + nbiny - mbinylo;
    } else if(yin >= 0.0) {
        iy = (int)(yin * bininvy) - mbinylo;
    } else {
        iy = (int)(yin * bininvy) - mbinylo - 1;
    }

    if(zin >= zprd) {
        iz = (int)((zin - zprd) * bininvz) + nbinz - mbinzlo;
    } else if(zin >= 0.0) {
        iz = (int)(zin * bininvz) - mbinzlo;
    } else {
        iz = (int)(zin * bininvz) - mbinzlo - 1;
    }

    return (iz * mbiny * mbinx + iy * mbinx + ix + 1);
}

void binatoms(Atom *atom)
{
    int nall = atom->Nlocal + atom->Nghost;
    double* x = atom->x;
    double* y = atom->y;
    double* z = atom->z;
    int resize = 1;

    while(resize > 0) {
        resize = 0;

        for(int i = 0; i < mbins; i++) {
            bincount[i] = 0;
        }

        for(int i = 0; i < nall; i++) {
            int ibin = coord2bin(x[i], y[i], z[i]);

            if(bincount[ibin] < atoms_per_bin) {
                int ac = bincount[ibin]++;
                bins[ibin * atoms_per_bin + ac] = i;
            } else {
                resize = 1;
            }
        }

        if(resize) {
            free(bins);
            atoms_per_bin *= 2;
            bins = (int*) malloc(mbins * atoms_per_bin * sizeof(int));
        }
    }
}
