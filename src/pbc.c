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
    MD_FLOAT* x = atom->x;
    MD_FLOAT* y = atom->y;
    MD_FLOAT* z = atom->z;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for(int i = 0; i < atom->Nghost; i++) {
        x[nlocal + i] = x[BorderMap[i]] + PBCx[i] * xprd;
        y[nlocal + i] = y[BorderMap[i]] + PBCy[i] * yprd;
        z[nlocal + i] = z[BorderMap[i]] + PBCz[i] * zprd;
    }
}

/* relocate atoms that have left domain according
 * to periodic boundary conditions */
void updateAtomsPbc(Atom *atom, Parameter *param)
{
    MD_FLOAT* x = atom->x;
    MD_FLOAT* y = atom->y;
    MD_FLOAT* z = atom->z;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;

    for(int i = 0; i < atom->Nlocal; i++) {

        if(x[i] < 0.0) {
            x[i] += xprd;
        } else if(x[i] >= xprd) {
            x[i] -= xprd;
        }

        if(y[i] < 0.0) {
            y[i] += yprd;
        } else if(y[i] >= yprd) {
            y[i] -= yprd;
        }

        if(z[i] < 0.0) {
            z[i] += zprd;
        } else if(z[i] >= zprd) {
            z[i] -= zprd;
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
    MD_FLOAT* x = atom->x; MD_FLOAT* y = atom->y; MD_FLOAT* z = atom->z;
    MD_FLOAT xprd = param->xprd;
    MD_FLOAT yprd = param->yprd;
    MD_FLOAT zprd = param->zprd;
    MD_FLOAT Cutneigh = param->cutneigh;
    int Nghost = -1;

    for(int i = 0; i < atom->Nlocal; i++) {

        if (atom->Nlocal + Nghost + 7 >= atom->Nmax) {
            growAtom(atom);
            x = atom->x;  y = atom->y;  z = atom->z;
        }
        if (Nghost + 7 >= NmaxGhost) {
            growPbc();
        }

        /* Setup ghost atoms */
        /* 6 planes */
        if (x[i] < Cutneigh)         { ADDGHOST(+1,0,0); }
        if (x[i] >= (xprd-Cutneigh)) { ADDGHOST(-1,0,0); }
        if (y[i] < Cutneigh)         { ADDGHOST(0,+1,0); }
        if (y[i] >= (yprd-Cutneigh)) { ADDGHOST(0,-1,0); }
        if (z[i] < Cutneigh)         { ADDGHOST(0,0,+1); }
        if (z[i] >= (zprd-Cutneigh)) { ADDGHOST(0,0,-1); }
        /* 8 corners */
        if (x[i] < Cutneigh         && y[i] < Cutneigh         && z[i] < Cutneigh)         { ADDGHOST(+1,+1,+1); }
        if (x[i] < Cutneigh         && y[i] >= (yprd-Cutneigh) && z[i] < Cutneigh)         { ADDGHOST(+1,-1,+1); }
        if (x[i] < Cutneigh         && y[i] >= Cutneigh        && z[i] >= (zprd-Cutneigh)) { ADDGHOST(+1,+1,-1); }
        if (x[i] < Cutneigh         && y[i] >= (yprd-Cutneigh) && z[i] >= (zprd-Cutneigh)) { ADDGHOST(+1,-1,-1); }
        if (x[i] >= (xprd-Cutneigh) && y[i] < Cutneigh         && z[i] < Cutneigh)         { ADDGHOST(-1,+1,+1); }
        if (x[i] >= (xprd-Cutneigh) && y[i] >= (yprd-Cutneigh) && z[i] < Cutneigh)         { ADDGHOST(-1,-1,+1); }
        if (x[i] >= (xprd-Cutneigh) && y[i] < Cutneigh         && z[i] >= (zprd-Cutneigh)) { ADDGHOST(-1,+1,-1); }
        if (x[i] >= (xprd-Cutneigh) && y[i] >= (yprd-Cutneigh) && z[i] >= (zprd-Cutneigh)) { ADDGHOST(-1,-1,-1); }
        /* 12 edges */
        if (x[i] < Cutneigh         && z[i] < Cutneigh)         { ADDGHOST(+1,0,+1); }
        if (x[i] < Cutneigh         && z[i] >= (zprd-Cutneigh)) { ADDGHOST(+1,0,-1); }
        if (x[i] >= (xprd-Cutneigh) && z[i] < Cutneigh)         { ADDGHOST(-1,0,+1); }
        if (x[i] >= (xprd-Cutneigh) && z[i] >= (zprd-Cutneigh)) { ADDGHOST(-1,0,-1); }
        if (y[i] < Cutneigh         && z[i] < Cutneigh)         { ADDGHOST(0,+1,+1); }
        if (y[i] < Cutneigh         && z[i] >= (zprd-Cutneigh)) { ADDGHOST(0,+1,-1); }
        if (y[i] >= (yprd-Cutneigh) && z[i] < Cutneigh)         { ADDGHOST(0,-1,+1); }
        if (y[i] >= (yprd-Cutneigh) && z[i] >= (zprd-Cutneigh)) { ADDGHOST(0,-1,-1); }
        if (y[i] < Cutneigh         && x[i] < Cutneigh)         { ADDGHOST(+1,+1,0); }
        if (y[i] < Cutneigh         && x[i] >= (xprd-Cutneigh)) { ADDGHOST(-1,+1,0); }
        if (y[i] >= (yprd-Cutneigh) && x[i] < Cutneigh)         { ADDGHOST(+1,-1,0); }
        if (y[i] >= (yprd-Cutneigh) && x[i] >= (xprd-Cutneigh)) { ADDGHOST(-1,-1,0); }
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
