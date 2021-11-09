/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
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
#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <likwid-marker.h>

#include <timing.h>
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>

double computeForce(
        Parameter *param,
        Atom *atom,
        Neighbor *neighbor
        )
{
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT* fx = atom->fx;
    MD_FLOAT* fy = atom->fy;
    MD_FLOAT* fz = atom->fz;
#ifndef EXPLICIT_TYPES
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;
#endif

    for(int i = 0; i < Nlocal; i++) {
        fx[i] = 0.0;
        fy[i] = 0.0;
        fz[i] = 0.0;
    }

    double S = getTimeStamp();
    LIKWID_MARKER_START("force");


#pragma omp parallel for
    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MD_FLOAT xtmp = atom_x(i);
        MD_FLOAT ytmp = atom_y(i);
        MD_FLOAT ztmp = atom_z(i);
        MD_FLOAT fix = 0;
        MD_FLOAT fiy = 0;
        MD_FLOAT fiz = 0;

#ifdef EXPLICIT_TYPES
        const int type_i = atom->type[i];
#endif

        /*
            atom->x  = (MD_FLOAT*) reallocate(atom->x,  ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT) * 3, nold * sizeof(MD_FLOAT) * 3);
            atom->epsilon = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
            atom->sigma6 = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
            atom->cutforcesq = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
            atom->cutneighsq = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
            atom->type = (int *) reallocate(atom->type, ALIGNMENT, atom->Nmax * sizeof(int), nold * sizeof(int));
        */

        Atom *c_atom;
        cudaMalloc((void**)&c_atom, sizeof(Atom));
        cudaMemcpy(c_atom, atom, sizeof(Atom), cudaMemcpyHostToDevice);

        cudaMalloc((void**)&c_atom->x, sizeof(MD_FLOAT) * atom->Nmax * 3);
        cudaMemcpy(c_atom->x, atom->x, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&c_atom->y, sizeof(MD_FLOAT) * atom->Nmax * 3);
        cudaMemcpy(c_atom->y, atom->y, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&c_atom->z, sizeof(MD_FLOAT) * atom->Nmax * 3);
        cudaMemcpy(c_atom->z, atom->z, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&c_atom->type, sizeof(int) * atom->Nmax);
        cudaMemcpy(c_atom->type, atom->type, sizeof(int) * atom->Nmax, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&c_atom->epsilon, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
        cudaMemcpy(c_atom->epsilon, atom->epsilon, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&c_atom->sigma6, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
        cudaMemcpy(c_atom->sigma6, atom->sigma6, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&c_atom->cutforcesq, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
        cudaMemcpy(c_atom->cutforcesq, atom->cutforcesq, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice);

        int *c_neighs;
        cudaMalloc((void**)&c_neighs, sizeof(int) * numneighs);
        cudaMemcpy(c_neighs, neighs, sizeof(int) * numneighs, cudaMemcpyHostToDevice);

        const int num_elems = numneighs;

        MD_FLOAT *c_fix, *c_fiy, *c_fiz;
        cudaMalloc((void**)&c_fix, sizeof(MD_FLOAT) * num_elems);
        cudaMalloc((void**)&c_fiy, sizeof(MD_FLOAT) * num_elems);
        cudaMalloc((void**)&c_fiz, sizeof(MD_FLOAT) * num_elems);

        for(int k = 0; k < numneighs; k++) {
            int j = neighs[k];
            MD_FLOAT delx = xtmp - atom_x(j);
            MD_FLOAT dely = ytmp - atom_y(j);
            MD_FLOAT delz = ztmp - atom_z(j);
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

#ifdef EXPLICIT_TYPES
            const int type_j = atom->type[j];
            const int type_ij = type_i * atom->ntypes + type_j;
            const MD_FLOAT cutforcesq = atom->cutforcesq[type_ij];
            const MD_FLOAT sigma6 = atom->sigma6[type_ij];
            const MD_FLOAT epsilon = atom->epsilon[type_ij];
#endif

            if(rsq < cutforcesq) {
                MD_FLOAT sr2 = 1.0 / rsq;
                MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
                MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;
                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force;
            }
        }

        fx[i] += fix;
        fy[i] += fiy;
        fz[i] += fiz;
    }

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();

    return E-S;
}

// cuda kernel
__global__ void calc_force(
    Atom *atom,
    MD_FLOAT xtmp, MD_FLOAT ytmp, MD_FLOAT ztmp,
    MD_FLOAT *fix, MD_FLOAT *fiy, MD_FLOAT *fiz,
    int i, int k, int *neighs) {

    int j = neighs[k];
    MD_FLOAT delx = xtmp - atom_x(j);
    MD_FLOAT dely = ytmp - atom_y(j);
    MD_FLOAT delz = ztmp - atom_z(j);
    MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

    const int type_i = atom->type[i];
    const int type_j = atom->type[j];
    const int type_ij = type_i * atom->ntypes + type_j;
    const MD_FLOAT cutforcesq = atom->cutforcesq[type_ij];
    const MD_FLOAT sigma6 = atom->sigma6[type_ij];
    const MD_FLOAT epsilon = atom->epsilon[type_ij];

    if(rsq < cutforcesq) {
        MD_FLOAT sr2 = 1.0 / rsq;
        MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
        MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;
        fix[j] += delx * force;
        fiy[j] += dely * force;
        fiz[j] += delz * force;
    }
}
