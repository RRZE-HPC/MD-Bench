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

extern "C" {

#include <pbc.h>
#include <atom.h>
#include <allocate.h>

#define DELTA 20000

}

__global__ void computePbcUpdate(Atom a, int* PBCx, int* PBCy, int* PBCz, MD_FLOAT xprd, MD_FLOAT yprd, MD_FLOAT zprd){
    const int i = blockIdx.x * blockDim.x + threadIdx.x;
    const int Nghost = a.Nghost;
    if( i >= Nghost ) {
        return;
    }
    Atom* atom = &a;
    int *border_map = atom->border_map;
    int nlocal = atom->Nlocal;

    atom_x(nlocal + i) = atom_x(border_map[i]) + PBCx[i] * xprd;
    atom_y(nlocal + i) = atom_y(border_map[i]) + PBCy[i] * yprd;
    atom_z(nlocal + i) = atom_z(border_map[i]) + PBCz[i] * zprd;
}

extern "C"{

static int NmaxGhost;
static int *PBCx, *PBCy, *PBCz;

static int c_NmaxGhost = 0;
static int *c_PBCx = NULL, *c_PBCy = NULL, *c_PBCz = NULL;

static void growPbc(Atom *);

/* exported subroutines */
void initPbc(Atom *atom) {
    NmaxGhost = 0;
    atom->border_map = NULL;
    PBCx = NULL;
    PBCy = NULL;
    PBCz = NULL;
}

/* update coordinates of ghost atoms */
/* uses mapping created in setupPbc */
void updatePbc(Atom *atom, Parameter *param) {
    int *border_map = atom->border_map;
    int nlocal = atom->Nlocal;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for (int i = 0; i < atom->Nghost; i++) {
        atom_x(nlocal + i) = atom_x(border_map[i]) + PBCx[i] * xprd;
        atom_y(nlocal + i) = atom_y(border_map[i]) + PBCy[i] * yprd;
        atom_z(nlocal + i) = atom_z(border_map[i]) + PBCz[i] * zprd;
    }
}

/* update coordinates of ghost atoms */
/* uses mapping created in setupPbc */
void updatePbc_cuda(Atom *atom, Parameter *param, Atom *c_atom, bool doReneighbor, const int num_threads_per_block) {
    if (doReneighbor){
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

    int nlocal = atom->Nlocal;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    const int num_blocks = ceil((float)atom->Nghost / (float)num_threads_per_block);

    /*__global__ void computePbcUpdate(Atom a, int* PBCx, int* PBCy, int* PBCz,
     *                                                          MD_FLOAT xprd, MD_FLOAT yprd, MD_FLOAT zprd)
     * */
    computePbcUpdate<<<num_blocks, num_threads_per_block>>>(*c_atom, c_PBCx, c_PBCy, c_PBCz, xprd, yprd, zprd);
    if(doReneighbor){
    	checkCUDAError( "updatePbc atom->x memcpy back", cudaMemcpy(atom->x, c_atom->x, atom->Nmax * sizeof(MD_FLOAT) * 3, cudaMemcpyDeviceToHost) );
    }
}

/* relocate atoms that have left domain according
 * to periodic boundary conditions */
void updateAtomsPbc(Atom *atom, Parameter *param) {
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for (int i = 0; i < atom->Nlocal; i++) {

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
}

/* setup periodic boundary conditions by
 * defining ghost atoms around domain
 * only creates mapping and coordinate corrections
 * that are then enforced in updatePbc */
#define ADDGHOST(dx, dy, dz)                              \
    Nghost++;                                           \
    border_map[Nghost] = i;                             \
    PBCx[Nghost] = dx;                                  \
    PBCy[Nghost] = dy;                                  \
    PBCz[Nghost] = dz;                                  \
    atom->type[atom->Nlocal + Nghost] = atom->type[i]

void setupPbc(Atom *atom, Parameter *param) {
    int *border_map = atom->border_map;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;
    MD_FLOAT Cutneigh = param->cutneigh;
    int Nghost = -1;

    for (int i = 0; i < atom->Nlocal; i++) {

        if (atom->Nlocal + Nghost + 7 >= atom->Nmax) {
            growAtom(atom);
        }
        if (Nghost + 7 >= NmaxGhost) {
            growPbc(atom);
            border_map = atom->border_map;
        }

        MD_FLOAT x = atom_x(i);
        MD_FLOAT y = atom_y(i);
        MD_FLOAT z = atom_z(i);

        /* Setup ghost atoms */
        /* 6 planes */
        if (x < Cutneigh) { ADDGHOST(+1, 0, 0); }
        if (x >= (xprd - Cutneigh)) { ADDGHOST(-1, 0, 0); }
        if (y < Cutneigh) { ADDGHOST(0, +1, 0); }
        if (y >= (yprd - Cutneigh)) { ADDGHOST(0, -1, 0); }
        if (z < Cutneigh) { ADDGHOST(0, 0, +1); }
        if (z >= (zprd - Cutneigh)) { ADDGHOST(0, 0, -1); }
        /* 8 corners */
        if (x < Cutneigh && y < Cutneigh && z < Cutneigh) { ADDGHOST(+1, +1, +1); }
        if (x < Cutneigh && y >= (yprd - Cutneigh) && z < Cutneigh) { ADDGHOST(+1, -1, +1); }
        if (x < Cutneigh && y >= Cutneigh && z >= (zprd - Cutneigh)) { ADDGHOST(+1, +1, -1); }
        if (x < Cutneigh && y >= (yprd - Cutneigh) && z >= (zprd - Cutneigh)) { ADDGHOST(+1, -1, -1); }
        if (x >= (xprd - Cutneigh) && y < Cutneigh && z < Cutneigh) { ADDGHOST(-1, +1, +1); }
        if (x >= (xprd - Cutneigh) && y >= (yprd - Cutneigh) && z < Cutneigh) { ADDGHOST(-1, -1, +1); }
        if (x >= (xprd - Cutneigh) && y < Cutneigh && z >= (zprd - Cutneigh)) { ADDGHOST(-1, +1, -1); }
        if (x >= (xprd - Cutneigh) && y >= (yprd - Cutneigh) && z >= (zprd - Cutneigh)) { ADDGHOST(-1, -1, -1); }
        /* 12 edges */
        if (x < Cutneigh && z < Cutneigh) { ADDGHOST(+1, 0, +1); }
        if (x < Cutneigh && z >= (zprd - Cutneigh)) { ADDGHOST(+1, 0, -1); }
        if (x >= (xprd - Cutneigh) && z < Cutneigh) { ADDGHOST(-1, 0, +1); }
        if (x >= (xprd - Cutneigh) && z >= (zprd - Cutneigh)) { ADDGHOST(-1, 0, -1); }
        if (y < Cutneigh && z < Cutneigh) { ADDGHOST(0, +1, +1); }
        if (y < Cutneigh && z >= (zprd - Cutneigh)) { ADDGHOST(0, +1, -1); }
        if (y >= (yprd - Cutneigh) && z < Cutneigh) { ADDGHOST(0, -1, +1); }
        if (y >= (yprd - Cutneigh) && z >= (zprd - Cutneigh)) { ADDGHOST(0, -1, -1); }
        if (y < Cutneigh && x < Cutneigh) { ADDGHOST(+1, +1, 0); }
        if (y < Cutneigh && x >= (xprd - Cutneigh)) { ADDGHOST(-1, +1, 0); }
        if (y >= (yprd - Cutneigh) && x < Cutneigh) { ADDGHOST(+1, -1, 0); }
        if (y >= (yprd - Cutneigh) && x >= (xprd - Cutneigh)) { ADDGHOST(-1, -1, 0); }
    }
    // increase by one to make it the ghost atom count
    atom->Nghost = Nghost + 1;
}

/* internal subroutines */
void growPbc(Atom *atom) {
    int nold = NmaxGhost;
    NmaxGhost += DELTA;

    atom->border_map = (int *) reallocate(atom->border_map, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    PBCx = (int *) reallocate(PBCx, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    PBCy = (int *) reallocate(PBCy, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    PBCz = (int *) reallocate(PBCz, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
}
}
