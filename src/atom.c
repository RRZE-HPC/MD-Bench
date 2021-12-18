/*
 * =======================================================================================
 *
 *   Authors:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *              Rafael Ravedutti (rr), rafaelravedutti@gmail.com
 *
 *   Copyright (c) 2021 RRZE, University Erlangen-Nuremberg
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

#include <cuda_runtime.h>
#include <device_launch_parameters.h>

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
    atom->type = NULL;
    atom->ntypes = 0;
    atom->epsilon = NULL;
    atom->sigma6 = NULL;
    atom->cutforcesq = NULL;
    atom->cutneighsq = NULL;
}

void createAtom(Atom *atom, Parameter *param)
{
    MD_FLOAT xlo = 0.0; MD_FLOAT xhi = param->xprd;
    MD_FLOAT ylo = 0.0; MD_FLOAT yhi = param->yprd;
    MD_FLOAT zlo = 0.0; MD_FLOAT zhi = param->zprd;
    atom->Natoms = 4 * param->nx * param->ny * param->nz;
    atom->Nlocal = 0;
    atom->ntypes = param->ntypes;
    checkCUDAError( "atom->epsilon cudaMallocHost", cudaMallocHost((void**)&(atom->epsilon), atom->ntypes * atom->ntypes * sizeof(MD_FLOAT)) ); // atom->epsilon = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    checkCUDAError( "atom->sigma6 cudaMallocHost", cudaMallocHost((void**)&(atom->sigma6), atom->ntypes * atom->ntypes * sizeof(MD_FLOAT)) ); // atom->sigma6 = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    checkCUDAError( "atom->cutforcesq cudaMallocHost", cudaMallocHost((void**)&(atom->cutforcesq), atom->ntypes * atom->ntypes * sizeof(MD_FLOAT)) ); // atom->cutforcesq = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    checkCUDAError( "atom->cutneighsq cudaMallocHost", cudaMallocHost((void**)&(atom->cutneighsq), atom->ntypes * atom->ntypes * sizeof(MD_FLOAT)) ); // atom->cutneighsq = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    for(int i = 0; i < atom->ntypes * atom->ntypes; i++) {
        atom->epsilon[i] = param->epsilon;
        atom->sigma6[i] = param->sigma6;
        atom->cutneighsq[i] = param->cutneigh * param->cutneigh;
        atom->cutforcesq[i] = param->cutforce * param->cutforce;
    }

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

                atom_x(atom->Nlocal) = xtmp;
                atom_y(atom->Nlocal) = ytmp;
                atom_z(atom->Nlocal) = ztmp;
                atom->vx[atom->Nlocal] = vxtmp;
                atom->vy[atom->Nlocal] = vytmp;
                atom->vz[atom->Nlocal] = vztmp;
                atom->type[atom->Nlocal] = rand() % atom->ntypes;
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
    atom->type = (int *) reallocate(atom->type, ALIGNMENT, atom->Nmax * sizeof(int), nold * sizeof(int));
}
