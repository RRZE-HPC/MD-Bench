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

    c_atom->x               =   (MD_FLOAT *) allocateGPU(sizeof(MD_FLOAT) * atom->Nmax * 3);
    c_atom->vx              =   (MD_FLOAT *) allocateGPU(sizeof(MD_FLOAT) * atom->Nmax * 3);
    c_atom->fx              =   (MD_FLOAT *) allocateGPU(sizeof(MD_FLOAT) * atom->Nmax * 3);
    c_atom->epsilon         =   (MD_FLOAT *) allocateGPU(sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    c_atom->sigma6          =   (MD_FLOAT *) allocateGPU(sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    c_atom->cutforcesq      =   (MD_FLOAT *) allocateGPU(sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    c_atom->type            =   (int *) allocateGPU(sizeof(int) * atom->Nmax * 3);
    c_neighbor->neighbors   =   (int *) allocateGPU(sizeof(int) * atom->Nmax * neighbor->maxneighs);
    c_neighbor->numneigh    =   (int *) allocateGPU(sizeof(int) * atom->Nmax);

    memcpyToGPU(c_atom->x,              atom->x,          sizeof(MD_FLOAT) * atom->Nmax * 3);
    memcpyToGPU(c_atom->vx,             atom->vx,         sizeof(MD_FLOAT) * atom->Nmax * 3);
    memcpyToGPU(c_atom->sigma6,         atom->sigma6,     sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    memcpyToGPU(c_atom->epsilon,        atom->epsilon,    sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    memcpyToGPU(c_atom->cutforcesq,     atom->cutforcesq, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    memcpyToGPU(c_atom->type,           atom->type,       sizeof(int) * atom->Nmax);
}

void cuda_assert(const char *label, cudaError_t err) {
    if (err != cudaSuccess) {
        printf("[CUDA Error]: %s: %s\r\n", label, cudaGetErrorString(err));
        exit(-1);
    }
}

}
