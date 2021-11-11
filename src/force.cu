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
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

extern "C" {
    #include <likwid-marker.h>

    #include <timing.h>
    #include <neighbor.h>
    #include <parameter.h>
    #include <atom.h>
}

// cuda kernel
__global__ void calc_force(
    Atom a,
    MD_FLOAT xtmp, MD_FLOAT ytmp, MD_FLOAT ztmp,
    MD_FLOAT *fix, MD_FLOAT *fiy, MD_FLOAT *fiz,
    int i, int numneighs, int *neighs) {

    // Calculate idx k from thread information
    const long long k = blockIdx.x * blockDim.x + threadIdx.x;
    if( k >= numneighs ) {
        return;
    }

    Atom *atom = &a;

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
        fix[j] = delx * force;
        fiy[j] = dely * force;
        fiz[j] = delz * force;
    }
}

extern "C" {

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

#ifdef EXPLICIT_TYPES
        const int type_i = atom->type[i];
#endif

        Atom c_atom;
        memcpy(&c_atom, atom, sizeof(Atom));

        cudaMalloc((void**)&(&c_atom)->x, sizeof(MD_FLOAT) * atom->Nmax * 3);
        cudaMemcpy(c_atom.x, atom->x, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&(&c_atom)->y, sizeof(MD_FLOAT) * atom->Nmax * 3);
        cudaMemcpy(c_atom.y, atom->y, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&(&c_atom)->z, sizeof(MD_FLOAT) * atom->Nmax * 3);
        cudaMemcpy(c_atom.z, atom->z, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&(&c_atom)->type, sizeof(int) * atom->Nmax);
        cudaMemcpy(c_atom.type, atom->type, sizeof(int) * atom->Nmax, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&(&c_atom)->epsilon, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
        cudaMemcpy(c_atom.epsilon, atom->epsilon, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&(&c_atom)->sigma6, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
        cudaMemcpy(c_atom.sigma6, atom->sigma6, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice);

        cudaMalloc((void**)&(&c_atom)->cutforcesq, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
        cudaMemcpy(c_atom.cutforcesq, atom->cutforcesq, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice);

        int *c_neighs;
        cudaMalloc((void**)&c_neighs, sizeof(int) * numneighs);
        cudaMemcpy(c_neighs, neighs, sizeof(int) * numneighs, cudaMemcpyHostToDevice);

        MD_FLOAT *c_fix, *c_fiy, *c_fiz;
        cudaMalloc((void**)&c_fix, sizeof(MD_FLOAT) * numneighs);
        cudaMalloc((void**)&c_fiy, sizeof(MD_FLOAT) * numneighs);
        cudaMalloc((void**)&c_fiz, sizeof(MD_FLOAT) * numneighs);

        const int num_blocks = 64;
        const int num_threads_per_block = ceil((float)numneighs / (float)num_blocks);
        // printf("numneighs: %d => num-blocks: %d, num_threads_per_block => %d\r\n", numneighs, num_blocks, num_threads_per_block);

        // launch cuda kernel
        calc_force <<< num_blocks, num_threads_per_block >>> (c_atom, xtmp, ytmp, ztmp, c_fix, c_fiy, c_fiz, i, numneighs, c_neighs);
        cudaDeviceSynchronize();

        // sum result
        MD_FLOAT *d_fix, *d_fiy, *d_fiz;
        d_fix = (MD_FLOAT*)malloc(sizeof(MD_FLOAT) * numneighs);
        d_fiy = (MD_FLOAT*)malloc(sizeof(MD_FLOAT) * numneighs);
        d_fiz = (MD_FLOAT*)malloc(sizeof(MD_FLOAT) * numneighs);
        cudaMemcpy((void**)&d_fix, c_fix, sizeof(MD_FLOAT) * numneighs, cudaMemcpyDeviceToHost);
        cudaMemcpy((void**)&d_fiy, c_fiy, sizeof(MD_FLOAT) * numneighs, cudaMemcpyDeviceToHost);
        cudaMemcpy((void**)&d_fiz, c_fiz, sizeof(MD_FLOAT) * numneighs, cudaMemcpyDeviceToHost);

        for(int k = 0; k < numneighs; k++) {
            fx[i] += d_fix[k];
            fy[i] += d_fiy[k];
            fz[i] += d_fiz[k];
        }

        cudaFree(c_fix); cudaFree(c_fiy); cudaFree(c_fiz); cudaFree(c_neighs);
        cudaFree(c_atom.x); cudaFree(c_atom.y); cudaFree(c_atom.z); cudaFree(c_atom.type);
        cudaFree(c_atom.epsilon); cudaFree(c_atom.sigma6); cudaFree(c_atom.cutforcesq);

        free(d_fix); free(d_fiy); free(d_fiz);
    }

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();

    return E-S;
}
}