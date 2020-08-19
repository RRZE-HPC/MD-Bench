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
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <math.h>
#include <float.h>

#include <timing.h>
#include <allocate.h>
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>
#include <thermo.h>
#include <pbc.h>

#define HLINE "----------------------------------------------------------------------------\n"

typedef enum {
    TOTAL = 0,
    NEIGH,
    FORCE,
    NUMTIMER
} timertype;


void init(Parameter *param)
{
    param->epsilon = 1.0;
    param->sigma6 = 1.0;
    param->rho = 0.8442;
    param->ntimes = 200;
    param->dt = 0.005;
    param->nx = 32;
    param->ny = 32;
    param->nz = 32;
    param->cutforce = 2.5;
    param->cutneigh = param->cutforce + 0.30;
    param->temp = 1.44;
    param->nstat = 100;
    param->mass = 1.0;
    param->dtforce = 0.5 * param->dt;
    param->every = 20;
    double lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    param->xprd = param->nx * lattice;
    param->yprd = param->ny * lattice;
    param->zprd = param->nz * lattice;
}

void setup(Parameter *param, Atom *atom, Neighbor *neighbor){
    initAtom(atom);
    initNeighbor(neighbor, param);
    initPbc();
    setupNeighbor();
    createAtom(atom, param);
    setupThermo(param, atom->Natoms);
    adjustThermo(param, atom);
    setupPbc(atom, param);
    updatePbc(atom, param);
    buildNeighbor(atom, neighbor);
}

void initialIntegrate(Parameter *param, Atom *atom)
{
    double* x = atom->x; double* y = atom->y; double* z = atom->z;
    double* fx = atom->fx; double* fy = atom->fy; double* fz = atom->fz;
    double* vx = atom->vx; double* vy = atom->vy; double* vz = atom->vz;

    for(int i = 0; i < atom->Nlocal; i++) {
        vx[i] += param->dtforce * fx[i];
        vy[i] += param->dtforce * fy[i];
        vz[i] += param->dtforce * fz[i];
        x[i]  += param->dt * vx[i];
        y[i]  += param->dt * vy[i];
        z[i]  += param->dt * vz[i];
    }
}

void finalIntegrate(Parameter *param, Atom *atom)
{
    double* fx = atom->fx; double* fy = atom->fy; double* fz = atom->fz;
    double* vx = atom->vx; double* vy = atom->vy; double* vz = atom->vz;

    for(int i = 0; i < atom->Nlocal; i++) {
        vx[i] += param->dtforce * fx[i];
        vy[i] += param->dtforce * fy[i];
        vz[i] += param->dtforce * fz[i];
    }
}

void computeForce(Parameter *param, Atom *atom, Neighbor *neighbor)
{
    int Nlocal = atom->Natoms;
    int* neighs;
    double cutforcesq = param->cutforce * param->cutforce;
    double sigma6 = param->sigma6;
    double epsilon = param->epsilon;
    double* x = atom->x; double* y = atom->y; double* z = atom->z;
    double* fx = atom->fx; double* fy = atom->fy; double* fz = atom->fz;

    for(int i = 0; i < Nlocal; i++) {
        fx[i] = 0.0;
        fy[i] = 0.0;
        fz[i] = 0.0;
    }

    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        double xtmp = x[i];
        double ytmp = y[i];
        double ztmp = z[i];

        double fix = 0;
        double fiy = 0;
        double fiz = 0;

        for(int k = 0; k < numneighs; k++) {
            int j = neighs[k];
            double delx = xtmp - x[j];
            double dely = ytmp - y[j];
            double delz = ztmp - z[j];
            double rsq = delx * delx + dely * dely + delz * delz;

            if(rsq < cutforcesq) {
                double sr2 = 1.0 / rsq;
                double sr6 = sr2 * sr2 * sr2 * sigma6;
                double force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;
                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force;
            }
        }

        fx[i] += fix;
        fy[i] += fiy;
        fz[i] += fiz;
    }
}


void printAtomState(Atom *atom)
{
    printf("Atom counts: Natoms=%d Nlocal=%d Nghost=%d Nmax=%d\n",
            atom->Natoms, atom->Nlocal, atom->Nghost, atom->Nmax);

    int nall = atom->Nlocal + atom->Nghost;

    for (int i=0; i<nall; i++) {
        printf("%d  %f %f %f\n", i, atom->x[i], atom->y[i], atom->z[i]);
    }
}

int main (int argc, char** argv)
{
    double timer[NUMTIMER];
    double S;
    Atom atom;
    Neighbor neighbor;
    Parameter param;

    init(&param);

    for(int i = 0; i < argc; i++)
    {
        if((strcmp(argv[i], "-n") == 0) || (strcmp(argv[i], "--nsteps") == 0))
        {
            param.ntimes = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-nx") == 0))
        {
            param.nx = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-ny") == 0))
        {
            param.ny = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-nz") == 0))
        {
            param.nz = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0))
        {
            printf("MD Bench: A minimalistic re-implementation of miniMD\n");
            printf(HLINE);
            printf("-n / --nsteps <int>:    set number of timesteps for simulation\n");
            printf("-nx/-ny/-nz <int>:      set linear dimension of systembox in x/y/z direction\n");
            printf(HLINE);
            exit(EXIT_SUCCESS);
        }
    }

    setup(&param, &atom, &neighbor);
    computeThermo(0, &param, &atom);
    computeForce(&param, &atom, &neighbor);

    for(int n = 0; n < param.ntimes; n++) {

        initialIntegrate(&param, &atom);

        if((n + 1) % param.every) {
            updatePbc(&atom, &param);
        } else {
            updateAtomsPbc(&atom, &param);
            setupPbc(&atom, &param);
            updatePbc(&atom, &param);
            /* sortAtom(); */
            buildNeighbor(&atom, &neighbor);
        }

        computeForce(&param, &atom, &neighbor);
        finalIntegrate(&param, &atom);

        if(!((n + 1) % param.nstat) && (n+1) < param.ntimes) {
            computeThermo(n + 1, &param, &atom);
        }
    }

    computeThermo(-1, &param, &atom);

    return EXIT_SUCCESS;
}
