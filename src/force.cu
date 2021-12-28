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
#include <cuda_profiler_api.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

extern "C" {
    #include <likwid-marker.h>

    #include <timing.h>
    #include <neighbor.h>
    #include <parameter.h>
    #include <atom.h>
    #include <allocate.h>
}

// cuda kernel
__global__ void calc_force(
    Atom a,
    MD_FLOAT cutforcesq, MD_FLOAT sigma6, MD_FLOAT epsilon,
    int Nlocal, int neigh_maxneighs, int *neigh_neighbors, int *neigh_numneigh) {

    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if( i >= Nlocal ) {
        return;
    }

    Atom *atom = &a;

    int *neighs = &neigh_neighbors[i * neigh_maxneighs];
    int numneighs = neigh_numneigh[i];

    MD_FLOAT xtmp = atom_x(i);
    MD_FLOAT ytmp = atom_y(i);
    MD_FLOAT ztmp = atom_z(i);

    MD_FLOAT *fx = atom->fx;
    MD_FLOAT *fy = atom->fy;
    MD_FLOAT *fz = atom->fz;

    MD_FLOAT fix = 0;
    MD_FLOAT fiy = 0;
    MD_FLOAT fiz = 0;

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

extern "C" {

bool initialized = false;
static Atom c_atom;
int *c_neighs;
int *c_neigh_numneigh;

double computeForce(
        bool reneighbourHappenend,
        Parameter *param,
        Atom *atom,
        Neighbor *neighbor
        )
{
    int Nlocal = atom->Nlocal;
#ifndef EXPLICIT_TYPES
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;
#endif

    cudaProfilerStart();

    const char *num_threads_env = getenv("NUM_THREADS");
    int num_threads = 0;
    if(num_threads_env == nullptr)
        num_threads = 32;
    else {
        num_threads = atoi(num_threads_env);
    }

    c_atom.Natoms = atom->Natoms;
    c_atom.Nlocal = atom->Nlocal;
    c_atom.Nghost = atom->Nghost;
    c_atom.Nmax = atom->Nmax;
    c_atom.ntypes = atom->ntypes;

    /*
    int nDevices;
    cudaGetDeviceCount(&nDevices);
    size_t free, total;
    for(int i = 0; i < nDevices; ++i) {
        cudaMemGetInfo( &free, &total );
        cudaDeviceProp prop;
        cudaGetDeviceProperties(&prop, i);
        printf("DEVICE %d/%d NAME: %s\r\n with %ld MB/%ld MB memory used", i + 1, nDevices, prop.name, free / 1024 / 1024, total / 1024 / 1024);
    }
    */

    // Choose GPU where you want to execute code on
    // It is possible to execute the same kernel on multiple GPUs but you have to copy the data multiple times
    // Executing `cudaSetDevice(N)` before cudaMalloc / cudaMemcpy / calc_force <<< >>> will set the GPU accordingly


    // HINT: Run with cuda-memcheck ./MDBench-NVCC in case of error
    // HINT: Only works for data layout = AOS!!!

    if(!initialized) {
        checkCUDAError( "c_atom.x malloc", cudaMalloc((void**)&(c_atom.x), sizeof(MD_FLOAT) * atom->Nmax * 3) );
        checkCUDAError( "c_atom.fx malloc", cudaMalloc((void**)&(c_atom.fx), sizeof(MD_FLOAT) * Nlocal) );
        checkCUDAError( "c_atom.fy malloc", cudaMalloc((void**)&(c_atom.fy), sizeof(MD_FLOAT) * Nlocal) );
        checkCUDAError( "c_atom.fz malloc", cudaMalloc((void**)&(c_atom.fz), sizeof(MD_FLOAT) * Nlocal) );
        checkCUDAError( "c_atom.type malloc", cudaMalloc((void**)&(c_atom.type), sizeof(int) * atom->Nmax) );
        checkCUDAError( "c_atom.epsilon malloc", cudaMalloc((void**)&(c_atom.epsilon), sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes) );
        checkCUDAError( "c_atom.sigma6 malloc", cudaMalloc((void**)&(c_atom.sigma6), sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes) );
        checkCUDAError( "c_atom.cutforcesq malloc", cudaMalloc((void**)&(c_atom.cutforcesq), sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes) );

        checkCUDAError( "c_neighs malloc", cudaMalloc((void**)&c_neighs, sizeof(int) * Nlocal * neighbor->maxneighs) );
        checkCUDAError( "c_neigh_numneigh malloc", cudaMalloc((void**)&c_neigh_numneigh, sizeof(int) * Nlocal) );

        checkCUDAError( "c_atom.type memcpy", cudaMemcpy(c_atom.type, atom->type, sizeof(int) * atom->Nmax, cudaMemcpyHostToDevice) );
        checkCUDAError( "c_atom.sigma6 memcpy", cudaMemcpy(c_atom.sigma6, atom->sigma6, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice) );
        checkCUDAError( "c_atom.epsilon memcpy", cudaMemcpy(c_atom.epsilon, atom->epsilon, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice) );

        checkCUDAError( "c_atom.cutforcesq memcpy", cudaMemcpy(c_atom.cutforcesq, atom->cutforcesq, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice) );
    }

    checkCUDAError( "c_atom.fx memset", cudaMemset(c_atom.fx, 0, sizeof(MD_FLOAT) * Nlocal) );
    checkCUDAError( "c_atom.fy memset", cudaMemset(c_atom.fy, 0, sizeof(MD_FLOAT) * Nlocal) );
    checkCUDAError( "c_atom.fz memset", cudaMemset(c_atom.fz, 0, sizeof(MD_FLOAT) * Nlocal) );

    checkCUDAError( "c_atom.x memcpy", cudaMemcpy(c_atom.x, atom->x, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice) );

    checkCUDAError( "c_neigh_numneigh memcpy", cudaMemcpy(c_neigh_numneigh, neighbor->numneigh, sizeof(int) * Nlocal, cudaMemcpyHostToDevice) );
    checkCUDAError( "c_neighs memcpy", cudaMemcpy(c_neighs, neighbor->neighbors, sizeof(int) * Nlocal * neighbor->maxneighs, cudaMemcpyHostToDevice) );

    const int num_threads_per_block = num_threads; // this should be multiple of 32 as operations are performed at the level of warps
    const int num_blocks = ceil((float)Nlocal / (float)num_threads_per_block);

    double S = getTimeStamp();
    LIKWID_MARKER_START("force");

    calc_force <<< num_blocks, num_threads_per_block >>> (c_atom, cutforcesq, sigma6, epsilon, Nlocal, neighbor->maxneighs, c_neighs, c_neigh_numneigh);

    checkCUDAError( "PeekAtLastError", cudaPeekAtLastError() );
    checkCUDAError( "DeviceSync", cudaDeviceSynchronize() );

    // copy results in c_atom.fx/fy/fz to atom->fx/fy/fz

    cudaMemcpy(atom->fx, c_atom.fx, sizeof(MD_FLOAT) * Nlocal, cudaMemcpyDeviceToHost);
    cudaMemcpy(atom->fy, c_atom.fy, sizeof(MD_FLOAT) * Nlocal, cudaMemcpyDeviceToHost);
    cudaMemcpy(atom->fz, c_atom.fz, sizeof(MD_FLOAT) * Nlocal, cudaMemcpyDeviceToHost);

    /*
    cudaFree(c_atom.x);
    cudaFree(c_atom.fx); cudaFree(c_atom.fy); cudaFree(c_atom.fz);
    cudaFree(c_atom.type);
    cudaFree(c_atom.epsilon);
    cudaFree(c_atom.sigma6);
    cudaFree(c_atom.cutforcesq);
    */

    // cudaFree(c_neighs); cudaFree(c_neigh_numneigh);

    cudaProfilerStop();

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();

    initialized = true;

    return E-S;
}
}