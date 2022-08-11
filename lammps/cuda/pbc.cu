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
//---

extern "C" {

#include <allocate.h>
#include <atom.h>
#include <cuda_atom.h>
#include <pbc.h>
#include <util.h>

}

extern int NmaxGhost;
extern int *PBCx, *PBCy, *PBCz;
static int c_NmaxGhost;
static int *c_PBCx, *c_PBCy, *c_PBCz;

__global__ void computeAtomsPbcUpdate(Atom a, MD_FLOAT xprd, MD_FLOAT yprd, MD_FLOAT zprd){
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    Atom* atom = &a;
    if(i >= atom->Nlocal) {
        return;
    }

    if (atom_x(i) < 0.0) {
        atom_x(i) += xprd;
    } else if (atom_x(i) >= xprd) {
        atom_x(i) -= xprd;
    }

    if (atom_y(i) < 0.0) {
        atom_y(i) += yprd;
    } else if (atom_y(i) >= yprd) {
        atom_y(i) -= yprd;
    }

    if (atom_z(i) < 0.0) {
        atom_z(i) += zprd;
    } else if (atom_z(i) >= zprd) {
        atom_z(i) -= zprd;
    }
}

__global__ void computePbcUpdate(Atom a, int* PBCx, int* PBCy, int* PBCz, MD_FLOAT xprd, MD_FLOAT yprd, MD_FLOAT zprd){
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    const int Nghost = a.Nghost;
    if(i >= Nghost) {
        return;
    }

    Atom* atom = &a;
    int *border_map = atom->border_map;
    int nlocal = atom->Nlocal;

    atom_x(nlocal + i) = atom_x(border_map[i]) + PBCx[i] * xprd;
    atom_y(nlocal + i) = atom_y(border_map[i]) + PBCy[i] * yprd;
    atom_z(nlocal + i) = atom_z(border_map[i]) + PBCz[i] * zprd;
}

/* update coordinates of ghost atoms */
/* uses mapping created in setupPbc */
void updatePbc_cuda(Atom *atom, Atom *c_atom, Parameter *param, bool doReneighbor) {
    const int num_threads_per_block = get_num_threads();

    if (doReneighbor) {
        c_atom->Natoms = atom->Natoms;
        c_atom->Nlocal = atom->Nlocal;
        c_atom->Nghost = atom->Nghost;
        c_atom->ntypes = atom->ntypes;

        if (atom->Nmax > c_atom->Nmax){ // the number of ghost atoms has increased -> more space is needed
            c_atom->Nmax = atom->Nmax;
            if(c_atom->x != NULL){ cudaFree(c_atom->x); }
            if(c_atom->type != NULL){ cudaFree(c_atom->type); }
            checkCUDAError( "updatePbc c_atom->x malloc", cudaMalloc((void**)&(c_atom->x), sizeof(MD_FLOAT) * atom->Nmax * 3) );
            checkCUDAError( "updatePbc c_atom->type malloc", cudaMalloc((void**)&(c_atom->type), sizeof(int) * atom->Nmax) );
        }
        // TODO if the sort is reactivated the atom->vx needs to be copied to GPU as well
        checkCUDAError( "updatePbc c_atom->x memcpy", cudaMemcpy(c_atom->x, atom->x, sizeof(MD_FLOAT) * atom->Nmax * 3, cudaMemcpyHostToDevice) );
        checkCUDAError( "updatePbc c_atom->type memcpy", cudaMemcpy(c_atom->type, atom->type, sizeof(int) * atom->Nmax, cudaMemcpyHostToDevice) );

        if(c_NmaxGhost < NmaxGhost){
            c_NmaxGhost = NmaxGhost;
            if(c_PBCx != NULL){ cudaFree(c_PBCx); }
            if(c_PBCy != NULL){ cudaFree(c_PBCy); }
            if(c_PBCz != NULL){ cudaFree(c_PBCz); }
            if(c_atom->border_map != NULL){ cudaFree(c_atom->border_map); }
            checkCUDAError( "updatePbc c_PBCx malloc", cudaMalloc((void**)&c_PBCx, NmaxGhost * sizeof(int)) );
            checkCUDAError( "updatePbc c_PBCy malloc", cudaMalloc((void**)&c_PBCy, NmaxGhost * sizeof(int)) );
            checkCUDAError( "updatePbc c_PBCz malloc", cudaMalloc((void**)&c_PBCz, NmaxGhost * sizeof(int)) );
            checkCUDAError( "updatePbc c_atom->border_map malloc", cudaMalloc((void**)&(c_atom->border_map), NmaxGhost * sizeof(int)) );
        }
        checkCUDAError( "updatePbc c_PBCx memcpy", cudaMemcpy(c_PBCx, PBCx, NmaxGhost * sizeof(int), cudaMemcpyHostToDevice) );
        checkCUDAError( "updatePbc c_PBCy memcpy", cudaMemcpy(c_PBCy, PBCy, NmaxGhost * sizeof(int), cudaMemcpyHostToDevice) );
        checkCUDAError( "updatePbc c_PBCz memcpy", cudaMemcpy(c_PBCz, PBCz, NmaxGhost * sizeof(int), cudaMemcpyHostToDevice) );
        checkCUDAError( "updatePbc c_atom->border_map memcpy", cudaMemcpy(c_atom->border_map, atom->border_map, NmaxGhost * sizeof(int), cudaMemcpyHostToDevice) );
    }

    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    const int num_blocks = ceil((float)atom->Nghost / (float)num_threads_per_block);

    /*__global__ void computePbcUpdate(Atom a, int* PBCx, int* PBCy, int* PBCz,
     *                                                          MD_FLOAT xprd, MD_FLOAT yprd, MD_FLOAT zprd)
     * */
    computePbcUpdate<<<num_blocks, num_threads_per_block>>>(*c_atom, c_PBCx, c_PBCy, c_PBCz, xprd, yprd, zprd);
    checkCUDAError( "PeekAtLastError UpdatePbc", cudaPeekAtLastError() );
    checkCUDAError( "DeviceSync UpdatePbc", cudaDeviceSynchronize() );
}

void updateAtomsPbc_cuda(Atom* atom, Atom *c_atom, Parameter *param){
    const int num_threads_per_block = get_num_threads();
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    const int num_blocks = ceil((float)atom->Nlocal / (float)num_threads_per_block);
    /*void computeAtomsPbcUpdate(Atom a, MD_FLOAT xprd, MD_FLOAT yprd, MD_FLOAT zprd)*/
    computeAtomsPbcUpdate<<<num_blocks, num_threads_per_block>>>(*c_atom, xprd, yprd, zprd);

    checkCUDAError( "PeekAtLastError UpdateAtomsPbc", cudaPeekAtLastError() );
    checkCUDAError( "DeviceSync UpdateAtomsPbc", cudaDeviceSynchronize() );
    checkCUDAError( "updateAtomsPbc position memcpy back", cudaMemcpy(atom->x, c_atom->x, sizeof(MD_FLOAT) * atom->Nlocal * 3, cudaMemcpyDeviceToHost) );
}
