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

    const int numneighs = neigh_numneigh[i];

    MD_FLOAT xtmp = atom_x(i);
    MD_FLOAT ytmp = atom_y(i);
    MD_FLOAT ztmp = atom_z(i);

    MD_FLOAT fix = 0;
    MD_FLOAT fiy = 0;
    MD_FLOAT fiz = 0;

    for(int k = 0; k < numneighs; k++) {
        int j = neigh_neighbors[atom->Nlocal * k + i];
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

    atom_fx(i) = fix;
    atom_fy(i) = fiy;
    atom_fz(i) = fiz;
}

__global__ void kernel_initial_integrate(MD_FLOAT dtforce, MD_FLOAT dt, int Nlocal, Atom a) {

    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if( i >= Nlocal ) {
        return;
    }

    Atom *atom = &a;

    atom_vx(i) += dtforce * atom_fx(i);
    atom_vy(i) += dtforce * atom_fy(i);
    atom_vz(i) += dtforce * atom_fz(i);
    atom_x(i) = atom_x(i) + dt * atom_vx(i);
    atom_y(i) = atom_y(i) + dt * atom_vy(i);
    atom_z(i) = atom_z(i) + dt * atom_vz(i);
}

__global__ void kernel_final_integrate(MD_FLOAT dtforce, int Nlocal, Atom a) {

    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    if( i >= Nlocal ) {
        return;
    }

    Atom *atom = &a;

    atom_vx(i) += dtforce * atom_fx(i);
    atom_vy(i) += dtforce * atom_fy(i);
    atom_vz(i) += dtforce * atom_fz(i);
}

extern "C" {



int get_num_threads() {

    const char *num_threads_env = getenv("NUM_THREADS");
    int num_threads = 0;
    if(num_threads_env == nullptr)
        num_threads = 32;
    else {
        num_threads = atoi(num_threads_env);
    }

    return num_threads;
}

void cuda_final_integrate(bool doReneighbour, Parameter *param, Atom *atom, Atom *c_atom) {

    const int Nlocal = atom->Nlocal;
    const int num_threads = get_num_threads();

    const int num_threads_per_block = num_threads; // this should be multiple of 32 as operations are performed at the level of warps
    const int num_blocks = ceil((float)Nlocal / (float)num_threads_per_block);

    kernel_final_integrate <<< num_blocks, num_threads_per_block >>> (param->dtforce, Nlocal, *c_atom);

    checkCUDAError( "PeekAtLastError FinalIntegrate", cudaPeekAtLastError() );
    checkCUDAError( "DeviceSync FinalIntegrate", cudaDeviceSynchronize() );

    if(doReneighbour) {
        checkCUDAError( "FinalIntegrate: velocity memcpy", cudaMemcpy(atom->vx, c_atom->vx, sizeof(MD_FLOAT) * atom->Nlocal * 3, cudaMemcpyDeviceToHost) );
    }
}

void cuda_initial_integrate(bool doReneighbour, Parameter *param, Atom *atom, Atom *c_atom) {

    const int Nlocal = atom->Nlocal;
    const int num_threads = get_num_threads();

    const int num_threads_per_block = num_threads; // this should be multiple of 32 as operations are performed at the level of warps
    const int num_blocks = ceil((float)Nlocal / (float)num_threads_per_block);

    kernel_initial_integrate <<< num_blocks, num_threads_per_block >>> (param->dtforce, param->dt, Nlocal, *c_atom);

    checkCUDAError( "PeekAtLastError InitialIntegrate", cudaPeekAtLastError() );
    checkCUDAError( "DeviceSync InitialIntegrate", cudaDeviceSynchronize() );

    if(doReneighbour) {
        checkCUDAError( "InitialIntegrate: velocity memcpy", cudaMemcpy(atom->vx, c_atom->vx, sizeof(MD_FLOAT) * atom->Nlocal * 3, cudaMemcpyDeviceToHost) );
    }
    checkCUDAError( "InitialIntegrate: position memcpy", cudaMemcpy(atom->x, c_atom->x, sizeof(MD_FLOAT) * atom->Nlocal * 3, cudaMemcpyDeviceToHost) );
}

double computeForce(
        bool reneighbourHappenend,
        Parameter *param,
        Atom *atom,
        Neighbor *neighbor,
        Atom *c_atom,
        Neighbor *c_neighbor
        )
{
    int Nlocal = atom->Nlocal;
#ifndef EXPLICIT_TYPES
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;
#endif

    const int num_threads = get_num_threads();

    c_atom->Natoms = atom->Natoms;
    c_atom->Nlocal = atom->Nlocal;
    c_atom->Nghost = atom->Nghost;
    c_atom->Nmax = atom->Nmax;
    c_atom->ntypes = atom->ntypes;

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


    // HINT: Run with cuda-memcheck ./MDBench-NVCC in case of error

    // checkCUDAError( "c_atom->fx memset", cudaMemset(c_atom->fx, 0, sizeof(MD_FLOAT) * Nlocal * 3) );

    cudaProfilerStart();

    checkCUDAError( "c_atom->x memcpy", cudaMemcpy(c_atom->x, atom->x, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice) );

    if(reneighbourHappenend) {
        checkCUDAError( "c_neighbor->numneigh memcpy", cudaMemcpy(c_neighbor->numneigh, neighbor->numneigh, sizeof(int) * Nlocal, cudaMemcpyHostToDevice) );
        checkCUDAError( "c_neighbor->neighbors memcpy", cudaMemcpy(c_neighbor->neighbors, neighbor->neighbors, sizeof(int) * Nlocal * neighbor->maxneighs, cudaMemcpyHostToDevice) );
    }

    const int num_threads_per_block = num_threads; // this should be multiple of 32 as operations are performed at the level of warps
    const int num_blocks = ceil((float)Nlocal / (float)num_threads_per_block);

    double S = getTimeStamp();
    LIKWID_MARKER_START("force");

    calc_force <<< num_blocks, num_threads_per_block >>> (*c_atom, cutforcesq, sigma6, epsilon, Nlocal, neighbor->maxneighs, c_neighbor->neighbors, c_neighbor->numneigh);

    checkCUDAError( "PeekAtLastError ComputeForce", cudaPeekAtLastError() );
    checkCUDAError( "DeviceSync ComputeForce", cudaDeviceSynchronize() );

    cudaProfilerStop();

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();

    return E-S;
}
}