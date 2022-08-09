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

extern "C" {

#include <stdio.h>
#include <cuda_runtime.h>
//---
#include <allocate.h>
#include <atom.h>
#include <cuda_atom.h>
#include <neighbor.h>

void initCuda(Atom *atom, Neighbor *neighbor, Atom *c_atom, Neighbor *c_neighbor) {
    c_atom->Natoms = atom->Natoms;
    c_atom->Nlocal = atom->Nlocal;
    c_atom->Nghost = atom->Nghost;
    c_atom->Nmax = atom->Nmax;
    c_atom->ntypes = atom->ntypes;

    c_atom->border_map = NULL;

    const int Nlocal = atom->Nlocal;

    checkCUDAError( "c_atom->x malloc", cudaMalloc((void**)&(c_atom->x), sizeof(MD_FLOAT) * atom->Nmax * 3) );
    checkCUDAError( "c_atom->x memcpy", cudaMemcpy(c_atom->x, atom->x, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice) );

    checkCUDAError( "c_atom->fx malloc", cudaMalloc((void**)&(c_atom->fx), sizeof(MD_FLOAT) * Nlocal * 3) );

    checkCUDAError( "c_atom->vx malloc", cudaMalloc((void**)&(c_atom->vx), sizeof(MD_FLOAT) * Nlocal * 3) );
    checkCUDAError( "c_atom->vx memcpy", cudaMemcpy(c_atom->vx, atom->vx, sizeof(MD_FLOAT) * Nlocal * 3, cudaMemcpyHostToDevice) );

    checkCUDAError( "c_atom->type malloc", cudaMalloc((void**)&(c_atom->type), sizeof(int) * atom->Nmax) );
    checkCUDAError( "c_atom->epsilon malloc", cudaMalloc((void**)&(c_atom->epsilon), sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes) );
    checkCUDAError( "c_atom->sigma6 malloc", cudaMalloc((void**)&(c_atom->sigma6), sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes) );
    checkCUDAError( "c_atom->cutforcesq malloc", cudaMalloc((void**)&(c_atom->cutforcesq), sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes) );

    checkCUDAError( "c_neighbor->neighbors malloc", cudaMalloc((void**)&c_neighbor->neighbors, sizeof(int) * Nlocal * neighbor->maxneighs) );
    checkCUDAError( "c_neighbor->numneigh malloc", cudaMalloc((void**)&c_neighbor->numneigh, sizeof(int) * Nlocal) );

    checkCUDAError( "c_atom->type memcpy", cudaMemcpy(c_atom->type, atom->type, sizeof(int) * atom->Nmax, cudaMemcpyHostToDevice) );
    checkCUDAError( "c_atom->sigma6 memcpy", cudaMemcpy(c_atom->sigma6, atom->sigma6, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice) );
    checkCUDAError( "c_atom->epsilon memcpy", cudaMemcpy(c_atom->epsilon, atom->epsilon, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice) );

    checkCUDAError( "c_atom->cutforcesq memcpy", cudaMemcpy(c_atom->cutforcesq, atom->cutforcesq, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes, cudaMemcpyHostToDevice) );
}

void checkCUDAError(const char *msg, cudaError_t err) {
    if (err != cudaSuccess) {
        //print a human readable error message
        printf("[CUDA ERROR %s]: %s\r\n", msg, cudaGetErrorString(err));
        exit(-1);
    }
}

}
