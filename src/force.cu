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

void checkError(const char *msg, cudaError_t err)
{
    if (err != cudaSuccess)
    {
        //print a human readable error message
        printf("[CUDA ERROR %s]: %s\r\n", msg, cudaGetErrorString(err));
        exit(-1);
    }
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

double computeForce(
        Parameter *param,
        Atom *atom,
        Neighbor *neighbor
        )
{
    int Nlocal = atom->Nlocal;
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

    const char *num_threads_env = getenv("NUM_THREADS");
    const int num_threads = atoi(num_threads_env);

    Atom c_atom;
    c_atom.Natoms = atom->Natoms;
    c_atom.Nlocal = atom->Nlocal;
    c_atom.Nghost = atom->Nghost;
    c_atom.Nmax = atom->Nmax;
    c_atom.ntypes = atom->ntypes;

    /*
    int nDevices;
    cudaGetDeviceCount(&nDevices);
    for(int i = 0; i < nDevices; ++i) {
        cudaDeviceProp prop;
        cudaGetDeviceProperties(&prop, i);
        printf("DEVICE NAME: %s\r\n", prop.name);
    }
    */

    // HINT: Run with cuda-memcheck ./MDBench-NVCC in case of error
    // HINT: Only works for data layout = AOS!!!

    checkError( "c_atom.x malloc", cudaMalloc((void**)&(c_atom.x), sizeof(MD_FLOAT) * atom->Nmax * 3) );
    checkError( "c_atom.x memcpy", cudaMemcpy(c_atom.x, atom->x, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice) );

    checkError( "c_atom.fx malloc", cudaMalloc((void**)&(c_atom.fx), sizeof(MD_FLOAT) * Nlocal) );
    checkError( "c_atom.fx memcpy", cudaMemcpy(c_atom.fx, fx, sizeof(MD_FLOAT) * Nlocal, cudaMemcpyHostToDevice) );

    checkError( "c_atom.fy malloc", cudaMalloc((void**)&(c_atom.fy), sizeof(MD_FLOAT) * Nlocal) );
    checkError( "c_atom.fy memcpy", cudaMemcpy(c_atom.fy, fy, sizeof(MD_FLOAT) * Nlocal, cudaMemcpyHostToDevice) );

    checkError( "c_atom.fz malloc", cudaMalloc((void**)&(c_atom.fz), sizeof(MD_FLOAT) * Nlocal) );
    checkError( "c_atom.fz memcpy", cudaMemcpy(c_atom.fz, fz, sizeof(MD_FLOAT) * Nlocal, cudaMemcpyHostToDevice) );

    checkError( "c_atom.type malloc", cudaMalloc((void**)&(c_atom.type), sizeof(int) * atom->Nmax) );
    checkError( "c_atom.type memcpy", cudaMemcpy(c_atom.type, atom->type, sizeof(int) * atom->Nmax, cudaMemcpyHostToDevice) );

    checkError( "c_atom.epsilon malloc", cudaMalloc((void**)&(c_atom.epsilon), sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes) );
    checkError( "c_atom.epsilon memcpy", cudaMemcpy(c_atom.epsilon, atom->epsilon, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice) );

    checkError( "c_atom.sigma6 malloc", cudaMalloc((void**)&(c_atom.sigma6), sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes) );
    checkError( "c_atom.sigma6 memcpy", cudaMemcpy(c_atom.sigma6, atom->sigma6, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice) );

    checkError( "c_atom.cutforcesq malloc", cudaMalloc((void**)&(c_atom.cutforcesq), sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes) );
    checkError( "c_atom.cutforcesq memcpy", cudaMemcpy(c_atom.cutforcesq, atom->cutforcesq, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice) );


    // double start_memory_bandwidth = getTimeStamp();

    int *c_neighs;
    checkError( "c_neighs malloc", cudaMalloc((void**)&c_neighs, sizeof(int) * Nlocal * neighbor->maxneighs) );
    checkError( "c_neighs memcpy", cudaMemcpy(c_neighs, neighbor->neighbors, sizeof(int) * Nlocal * neighbor->maxneighs, cudaMemcpyHostToDevice) );

    /*
    double end_memory_bandwidth = getTimeStamp();
    double memory_bandwith_time = (end_memory_bandwidth - start_memory_bandwidth);
    const unsigned long bytes =  sizeof(int) * Nlocal * neighbor->maxneighs;
    const double gb_per_second = ((double)bytes / memory_bandwith_time) / 1024.0 / 1024.0 / 1024.0;
    printf("Data transfer of %lu bytes took %fs => %f GB/s\r\n", bytes, memory_bandwith_time, gb_per_second);
    */

    int *c_neigh_numneigh;
    checkError( "c_neigh_numneigh malloc", cudaMalloc((void**)&c_neigh_numneigh, sizeof(int) * Nlocal) );
    checkError( "c_neigh_numneigh memcpy", cudaMemcpy(c_neigh_numneigh, neighbor->numneigh, sizeof(int) * Nlocal, cudaMemcpyHostToDevice) );

    const int num_threads_per_block = num_threads; // this should be multiple of 32 as operations are performed at the level of warps
    const int num_blocks = ceil((float)Nlocal / (float)num_threads_per_block);
    // printf("Distribution size: %d\r\n%d Blocks with each %d threads\r\n", Nlocal, num_blocks, num_threads_per_block);

    double S = getTimeStamp();
    LIKWID_MARKER_START("force");

    calc_force <<< num_blocks, num_threads_per_block >>> (c_atom, cutforcesq, sigma6, epsilon, Nlocal, neighbor->maxneighs, c_neighs, c_neigh_numneigh);

    checkError( "PeekAtLastError", cudaPeekAtLastError() );
    checkError( "DeviceSync", cudaDeviceSynchronize() );

    // copy results in c_atom.fx/fy/fz to atom->fx/fy/fz
    cudaMemcpy(atom->fx, c_atom.fx, sizeof(MD_FLOAT) * Nlocal, cudaMemcpyDeviceToHost);
    cudaMemcpy(atom->fy, c_atom.fy, sizeof(MD_FLOAT) * Nlocal, cudaMemcpyDeviceToHost);
    cudaMemcpy(atom->fz, c_atom.fz, sizeof(MD_FLOAT) * Nlocal, cudaMemcpyDeviceToHost);

    cudaFree(c_atom.x);
    cudaFree(c_atom.fx); cudaFree(c_atom.fy); cudaFree(c_atom.fz);
    cudaFree(c_atom.type);
    cudaFree(c_atom.epsilon);
    cudaFree(c_atom.sigma6);
    cudaFree(c_atom.cutforcesq);

    cudaFree(c_neighs); cudaFree(c_neigh_numneigh);

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();

    return E-S;
}
}