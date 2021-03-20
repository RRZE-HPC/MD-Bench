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

#include <atom.h>
#include <allocate.h>
#include <util.h>

#define DELTA 20000

void initAtom(Atom *atom)
{
    atom->x  = NULL; atom->y  = NULL; atom->z  = NULL;
    atom->vx = NULL; atom->vy = NULL; atom->vz = NULL;
    atom->fx = NULL; atom->fy = NULL; atom->fz = NULL;
    atom->Natoms = 0;
    atom->Nlocal = 0;
    atom->Nghost = 0;
    atom->Nmax   = 0;
}

void createAtom(Atom *atom, Parameter *param)
{
    MD_FLOAT xlo = 0.0; MD_FLOAT xhi = param->xprd;
    MD_FLOAT ylo = 0.0; MD_FLOAT yhi = param->yprd;
    MD_FLOAT zlo = 0.0; MD_FLOAT zhi = param->zprd;
    atom->Natoms = 4 * param->nx * param->ny * param->nz;
    atom->Nlocal = 0;
    MD_FLOAT alat = pow((4.0 / param->rho), (1.0 / 3.0));
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

    MD_FLOAT xtmp, ytmp, ztmp, vxtmp, vytmp, vztmp;
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

                if(atom->Nlocal == atom->Nmax) {
                    growAtom(atom);
                }

                set_atom_x(atom, atom->Nlocal, xtmp);
                set_atom_y(atom, atom->Nlocal, ytmp);
                set_atom_z(atom, atom->Nlocal, ztmp);
                atom->vx[atom->Nlocal] = vxtmp;
                atom->vy[atom->Nlocal] = vytmp;
                atom->vz[atom->Nlocal] = vztmp;
                atom->Nlocal++;
            }
        }

        sx++;

        if(sx == subboxdim) { sx = 0; sy++; }
        if(sy == subboxdim) { sy = 0; sz++; }
        if(sz == subboxdim) { sz = 0; ox++; }
        if(ox * subboxdim > ihi) { ox = 0; oy++; }
        if(oy * subboxdim > jhi) { oy = 0; oz++; }
    }
}

void growAtom(Atom *atom)
{
    int nold = atom->Nmax;
    atom->Nmax += DELTA;

    #ifdef AOS
    atom->x  = (MD_FLOAT*) reallocate(atom->x,  ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT) * 3, nold * sizeof(MD_FLOAT) * 3);
    #else
    atom->x  = (MD_FLOAT*) reallocate(atom->x,  ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT), nold * sizeof(MD_FLOAT));
    atom->y  = (MD_FLOAT*) reallocate(atom->y,  ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT), nold * sizeof(MD_FLOAT));
    atom->z  = (MD_FLOAT*) reallocate(atom->z,  ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT), nold * sizeof(MD_FLOAT));
    #endif
    atom->vx = (MD_FLOAT*) reallocate(atom->vx, ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT), nold * sizeof(MD_FLOAT));
    atom->vy = (MD_FLOAT*) reallocate(atom->vy, ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT), nold * sizeof(MD_FLOAT));
    atom->vz = (MD_FLOAT*) reallocate(atom->vz, ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT), nold * sizeof(MD_FLOAT));
    atom->fx = (MD_FLOAT*) reallocate(atom->fx, ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT), nold * sizeof(MD_FLOAT));
    atom->fy = (MD_FLOAT*) reallocate(atom->fy, ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT), nold * sizeof(MD_FLOAT));
    atom->fz = (MD_FLOAT*) reallocate(atom->fz, ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT), nold * sizeof(MD_FLOAT));
}


/* void sortAtom() */
/* { */
/*     binatoms(neighbor); */
/*     int* binpos = neighbor->bincount; */
/*     int* bins = neighbor->bins; */

/*     int mbins = neighbor->mbins; */
/*     int atoms_per_bin = neighbor->atoms_per_bin; */

/*     for(int i=1; i<mbins; i++) { */
/*         binpos[i] += binpos[i-1]; */
/*     } */

/*     double* new_x = (double*) malloc(Nmax * sizeof(double)); */
/*     double* new_y = (double*) malloc(Nmax * sizeof(double)); */
/*     double* new_z = (double*) malloc(Nmax * sizeof(double)); */
/*     double* new_vx = (double*) malloc(Nmax * sizeof(double)); */
/*     double* new_vy = (double*) malloc(Nmax * sizeof(double)); */
/*     double* new_vz = (double*) malloc(Nmax * sizeof(double)); */

/*     double* old_x = x; double* old_y = y; double* old_z = z; */
/*     double* old_vx = vx; double* old_vy = vy; double* old_vz = vz; */

/*     for(int mybin = 0; mybin<mbins; mybin++) { */
/*         int start = mybin>0?binpos[mybin-1]:0; */
/*         int count = binpos[mybin] - start; */

/*         for(int k=0; k<count; k++) { */
/*             int new_i = start + k; */
/*             int old_i = bins[mybin * atoms_per_bin + k]; */
/*             new_x[new_i] = old_x[old_i]; */
/*             new_y[new_i] = old_y[old_i]; */
/*             new_z[new_i] = old_z[old_i]; */
/*             new_vx[new_i] = old_vx[old_i]; */
/*             new_vy[new_i] = old_vy[old_i]; */
/*             new_vz[new_i] = old_vz[old_i]; */
/*         } */
/*     } */

/*     free(x); free(y); free(z); */
/*     free(vx); free(vy); free(vz); */
/*     x = new_x; y = new_y; z = new_z; */
/*     vx = new_vx; vy = new_vy; vz = new_vz; */
/* } */
