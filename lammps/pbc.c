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
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
//---
#include <pbc.h>
#include <atom.h>
#include <allocate.h>

#define DELTA 20000

int NmaxGhost;
int *PBCx, *PBCy, *PBCz;

static void growPbc(Atom*);

/* exported subroutines */
void initPbc(Atom* atom) {
    NmaxGhost = 0;
    atom->border_map = NULL;
    PBCx = NULL; PBCy = NULL; PBCz = NULL;
}

/* update coordinates of ghost atoms */
/* uses mapping created in setupPbc */
void updatePbc_cpu(Atom *atom, Atom *c_atom, Parameter *param, bool doReneighbor) {
    int *border_map = atom->border_map;
    int nlocal = atom->Nlocal;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for(int i = 0; i < atom->Nghost; i++) {
        atom_x(nlocal + i) = atom_x(border_map[i]) + PBCx[i] * xprd;
        atom_y(nlocal + i) = atom_y(border_map[i]) + PBCy[i] * yprd;
        atom_z(nlocal + i) = atom_z(border_map[i]) + PBCz[i] * zprd;
    }
}

/* relocate atoms that have left domain according
 * to periodic boundary conditions */
void updateAtomsPbc_cpu(Atom *atom, Atom *c_atom, Parameter *param) {
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for(int i = 0; i < atom->Nlocal; i++) {
        if(atom_x(i) < 0.0) {
            atom_x(i) += xprd;
        } else if(atom_x(i) >= xprd) {
            atom_x(i) -= xprd;
        }

        if(atom_y(i) < 0.0) {
            atom_y(i) += yprd;
        } else if(atom_y(i) >= yprd) {
            atom_y(i) -= yprd;
        }

        if(atom_z(i) < 0.0) {
            atom_z(i) += zprd;
        } else if(atom_z(i) >= zprd) {
            atom_z(i) -= zprd;
        }
    }
}

/* setup periodic boundary conditions by
 * defining ghost atoms around domain
 * only creates mapping and coordinate corrections
 * that are then enforced in updatePbc */
#define ADDGHOST(dx,dy,dz)                              \
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

    for(int i = 0; i < atom->Nlocal; i++) {
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
        if(param->pbc_x != 0) {
            if (x < Cutneigh)         { ADDGHOST(+1,0,0); }
            if (x >= (xprd-Cutneigh)) { ADDGHOST(-1,0,0); }
        }

        if(param->pbc_y != 0) {
            if (y < Cutneigh)         { ADDGHOST(0,+1,0); }
            if (y >= (yprd-Cutneigh)) { ADDGHOST(0,-1,0); }
        }

        if(param->pbc_z != 0) {
            if (z < Cutneigh)         { ADDGHOST(0,0,+1); }
            if (z >= (zprd-Cutneigh)) { ADDGHOST(0,0,-1); }
        }

        /* 8 corners */
        if(param->pbc_x != 0 && param->pbc_y != 0 && param->pbc_z != 0) {
            if (x < Cutneigh         && y < Cutneigh         && z < Cutneigh)         { ADDGHOST(+1,+1,+1); }
            if (x < Cutneigh         && y >= (yprd-Cutneigh) && z < Cutneigh)         { ADDGHOST(+1,-1,+1); }
            if (x < Cutneigh         && y >= Cutneigh        && z >= (zprd-Cutneigh)) { ADDGHOST(+1,+1,-1); }
            if (x < Cutneigh         && y >= (yprd-Cutneigh) && z >= (zprd-Cutneigh)) { ADDGHOST(+1,-1,-1); }
            if (x >= (xprd-Cutneigh) && y < Cutneigh         && z < Cutneigh)         { ADDGHOST(-1,+1,+1); }
            if (x >= (xprd-Cutneigh) && y >= (yprd-Cutneigh) && z < Cutneigh)         { ADDGHOST(-1,-1,+1); }
            if (x >= (xprd-Cutneigh) && y < Cutneigh         && z >= (zprd-Cutneigh)) { ADDGHOST(-1,+1,-1); }
            if (x >= (xprd-Cutneigh) && y >= (yprd-Cutneigh) && z >= (zprd-Cutneigh)) { ADDGHOST(-1,-1,-1); }
        }

        /* 12 edges */
        if(param->pbc_x != 0 && param->pbc_z != 0) {
            if (x < Cutneigh         && z < Cutneigh)         { ADDGHOST(+1,0,+1); }
            if (x < Cutneigh         && z >= (zprd-Cutneigh)) { ADDGHOST(+1,0,-1); }
            if (x >= (xprd-Cutneigh) && z < Cutneigh)         { ADDGHOST(-1,0,+1); }
            if (x >= (xprd-Cutneigh) && z >= (zprd-Cutneigh)) { ADDGHOST(-1,0,-1); }
        }

        if(param->pbc_y != 0 && param->pbc_z != 0) {
            if (y < Cutneigh         && z < Cutneigh)         { ADDGHOST(0,+1,+1); }
            if (y < Cutneigh         && z >= (zprd-Cutneigh)) { ADDGHOST(0,+1,-1); }
            if (y >= (yprd-Cutneigh) && z < Cutneigh)         { ADDGHOST(0,-1,+1); }
            if (y >= (yprd-Cutneigh) && z >= (zprd-Cutneigh)) { ADDGHOST(0,-1,-1); }
        }

        if(param->pbc_x != 0 && param->pbc_y != 0) {
            if (y < Cutneigh         && x < Cutneigh)         { ADDGHOST(+1,+1,0); }
            if (y < Cutneigh         && x >= (xprd-Cutneigh)) { ADDGHOST(-1,+1,0); }
            if (y >= (yprd-Cutneigh) && x < Cutneigh)         { ADDGHOST(+1,-1,0); }
            if (y >= (yprd-Cutneigh) && x >= (xprd-Cutneigh)) { ADDGHOST(-1,-1,0); }
        }
    }
    // increase by one to make it the ghost atom count
    atom->Nghost = Nghost + 1;
}

/* internal subroutines */
void growPbc(Atom* atom) {
    int nold = NmaxGhost;
    NmaxGhost += DELTA;

    atom->border_map = (int*) reallocate(atom->border_map, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    PBCx = (int*) reallocate(PBCx, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    PBCy = (int*) reallocate(PBCy, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    PBCz = (int*) reallocate(PBCz, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
}
