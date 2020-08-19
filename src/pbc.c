/*
 * =======================================================================================
 *
 *      Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *      Copyright (c) 2020 RRZE, University Erlangen-Nuremberg
 *
 *      Permission is hereby granted, free of charge, to any person obtaining a copy
 *      of this software and associated documentation files (the "Software"), to deal
 *      in the Software without restriction, including without limitation the rights
 *      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *      copies of the Software, and to permit persons to whom the Software is
 *      furnished to do so, subject to the following conditions:
 *
 *      The above copyright notice and this permission notice shall be included in all
 *      copies or substantial portions of the Software.
 *
 *      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *      SOFTWARE.
 *
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
    double* x = atom->x;
    double* y = atom->y;
    double* z = atom->z;
    double xprd = param->xprd;
    double yprd = param->yprd;
    double zprd = param->zprd;

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
    double* x = atom->x;
    double* y = atom->y;
    double* z = atom->z;
    double xprd = param->xprd;
    double yprd = param->yprd;
    double zprd = param->zprd;

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
    double* x = atom->x; double* y = atom->y; double* z = atom->z;
    double xprd = param->xprd;
    double yprd = param->yprd;
    double zprd = param->zprd;
    double Cutneigh = param->cutneigh;
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
