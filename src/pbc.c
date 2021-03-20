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

#include <pbc.h>
#include <atom.h>
#include <allocate.h>

#define DELTA 20000

static int NmaxGhost;
static int *BorderMap;
static int *PBCx, *PBCy, *PBCz;

static void growPbc();

/* exported subroutines */
void initPbc()
{
    NmaxGhost = 0;
    BorderMap = NULL;
    PBCx = NULL; PBCy = NULL; PBCz = NULL;
}

/* update coordinates of ghost atoms */
/* uses mapping created in setupPbc */
void updatePbc(Atom *atom, Parameter *param)
{
    int nlocal = atom->Nlocal;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for(int i = 0; i < atom->Nghost; i++) {
        set_atom_x(atom, nlocal + i, get_atom_x(atom, BorderMap[i]) + PBCx[i] * xprd);
        set_atom_y(atom, nlocal + i, get_atom_y(atom, BorderMap[i]) + PBCy[i] * yprd);
        set_atom_z(atom, nlocal + i, get_atom_z(atom, BorderMap[i]) + PBCz[i] * zprd);
    }
}

/* relocate atoms that have left domain according
 * to periodic boundary conditions */
void updateAtomsPbc(Atom *atom, Parameter *param)
{
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for(int i = 0; i < atom->Nlocal; i++) {
        MD_FLOAT x = get_atom_x(atom, i);
        MD_FLOAT y = get_atom_y(atom, i);
        MD_FLOAT z = get_atom_z(atom, i);

        if(x < 0.0) {
            set_atom_x(atom, i, x + xprd);
        } else if(x >= xprd) {
            set_atom_x(atom, i, x - xprd);
        }

        if(y < 0.0) {
            set_atom_y(atom, i, y + yprd);
        } else if(y >= yprd) {
            set_atom_y(atom, i, y - yprd);
        }

        if(z < 0.0) {
            set_atom_z(atom, i, z + zprd);
        } else if(z >= zprd) {
            set_atom_z(atom, i, z - zprd);
        }
    }
}

/* setup periodic boundary conditions by
 * defining ghost atoms around domain
 * only creates mapping and coordinate corrections
 * that are then enforced in updatePbc */
#define ADDGHOST(dx,dy,dz) Nghost++; BorderMap[Nghost] = i; PBCx[Nghost] = dx; PBCy[Nghost] = dy; PBCz[Nghost] = dz;
void setupPbc(Atom *atom, Parameter *param)
{
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
            growPbc();
        }

        MD_FLOAT x = get_atom_x(atom, i);
        MD_FLOAT y = get_atom_y(atom, i);
        MD_FLOAT z = get_atom_z(atom, i);

        /* Setup ghost atoms */
        /* 6 planes */
        if (x < Cutneigh)         { ADDGHOST(+1,0,0); }
        if (x >= (xprd-Cutneigh)) { ADDGHOST(-1,0,0); }
        if (y < Cutneigh)         { ADDGHOST(0,+1,0); }
        if (y >= (yprd-Cutneigh)) { ADDGHOST(0,-1,0); }
        if (z < Cutneigh)         { ADDGHOST(0,0,+1); }
        if (z >= (zprd-Cutneigh)) { ADDGHOST(0,0,-1); }
        /* 8 corners */
        if (x < Cutneigh         && y < Cutneigh         && z < Cutneigh)         { ADDGHOST(+1,+1,+1); }
        if (x < Cutneigh         && y >= (yprd-Cutneigh) && z < Cutneigh)         { ADDGHOST(+1,-1,+1); }
        if (x < Cutneigh         && y >= Cutneigh        && z >= (zprd-Cutneigh)) { ADDGHOST(+1,+1,-1); }
        if (x < Cutneigh         && y >= (yprd-Cutneigh) && z >= (zprd-Cutneigh)) { ADDGHOST(+1,-1,-1); }
        if (x >= (xprd-Cutneigh) && y < Cutneigh         && z < Cutneigh)         { ADDGHOST(-1,+1,+1); }
        if (x >= (xprd-Cutneigh) && y >= (yprd-Cutneigh) && z < Cutneigh)         { ADDGHOST(-1,-1,+1); }
        if (x >= (xprd-Cutneigh) && y < Cutneigh         && z >= (zprd-Cutneigh)) { ADDGHOST(-1,+1,-1); }
        if (x >= (xprd-Cutneigh) && y >= (yprd-Cutneigh) && z >= (zprd-Cutneigh)) { ADDGHOST(-1,-1,-1); }
        /* 12 edges */
        if (x < Cutneigh         && z < Cutneigh)         { ADDGHOST(+1,0,+1); }
        if (x < Cutneigh         && z >= (zprd-Cutneigh)) { ADDGHOST(+1,0,-1); }
        if (x >= (xprd-Cutneigh) && z < Cutneigh)         { ADDGHOST(-1,0,+1); }
        if (x >= (xprd-Cutneigh) && z >= (zprd-Cutneigh)) { ADDGHOST(-1,0,-1); }
        if (y < Cutneigh         && z < Cutneigh)         { ADDGHOST(0,+1,+1); }
        if (y < Cutneigh         && z >= (zprd-Cutneigh)) { ADDGHOST(0,+1,-1); }
        if (y >= (yprd-Cutneigh) && z < Cutneigh)         { ADDGHOST(0,-1,+1); }
        if (y >= (yprd-Cutneigh) && z >= (zprd-Cutneigh)) { ADDGHOST(0,-1,-1); }
        if (y < Cutneigh         && x < Cutneigh)         { ADDGHOST(+1,+1,0); }
        if (y < Cutneigh         && x >= (xprd-Cutneigh)) { ADDGHOST(-1,+1,0); }
        if (y >= (yprd-Cutneigh) && x < Cutneigh)         { ADDGHOST(+1,-1,0); }
        if (y >= (yprd-Cutneigh) && x >= (xprd-Cutneigh)) { ADDGHOST(-1,-1,0); }
    }
    // increase by one to make it the ghost atom count
    atom->Nghost = Nghost + 1;
}

/* internal subroutines */
void growPbc()
{
    int nold = NmaxGhost;
    NmaxGhost += DELTA;

    BorderMap = (int*) reallocate(BorderMap, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    PBCx = (int*) reallocate(PBCx, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    PBCy = (int*) reallocate(PBCy, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
    PBCz = (int*) reallocate(PBCz, ALIGNMENT, NmaxGhost * sizeof(int), nold * sizeof(int));
}
