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
#include <string.h>
#include <unistd.h>
#include <limits.h>
#include <math.h>
#include <float.h>

#include <likwid-marker.h>

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
}

double setup(
        Parameter *param,
        Atom *atom,
        Neighbor *neighbor)
{
    double S, E;
    double lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    param->xprd = param->nx * lattice;
    param->yprd = param->ny * lattice;
    param->zprd = param->nz * lattice;

    S = getTimeStamp();
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
    E = getTimeStamp();

    return E-S;
}

double reneighbour(
        Parameter *param,
        Atom *atom,
        Neighbor *neighbor)
{
    double S, E;

    S = getTimeStamp();
    LIKWID_MARKER_START("reneighbour");
    updateAtomsPbc(atom, param);
    setupPbc(atom, param);
    updatePbc(atom, param);
    /* sortAtom(); */
    buildNeighbor(atom, neighbor);
    LIKWID_MARKER_STOP("reneighbour");
    E = getTimeStamp();

    return E-S;
}

void initialIntegrate(Parameter *param, Atom *atom)
{
    MD_FLOAT* x = atom->x; MD_FLOAT* y = atom->y; MD_FLOAT* z = atom->z;
    MD_FLOAT* fx = atom->fx; MD_FLOAT* fy = atom->fy; MD_FLOAT* fz = atom->fz;
    MD_FLOAT* vx = atom->vx; MD_FLOAT* vy = atom->vy; MD_FLOAT* vz = atom->vz;

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
    MD_FLOAT* fx = atom->fx; MD_FLOAT* fy = atom->fy; MD_FLOAT* fz = atom->fz;
    MD_FLOAT* vx = atom->vx; MD_FLOAT* vy = atom->vy; MD_FLOAT* vz = atom->vz;

    for(int i = 0; i < atom->Nlocal; i++) {
        vx[i] += param->dtforce * fx[i];
        vy[i] += param->dtforce * fy[i];
        vz[i] += param->dtforce * fz[i];
    }
}

double computeForce(Parameter *param, Atom *atom, Neighbor *neighbor)
{
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;
    MD_FLOAT* x = atom->x; MD_FLOAT* y = atom->y; MD_FLOAT* z = atom->z;
    MD_FLOAT* fx = atom->fx; MD_FLOAT* fy = atom->fy; MD_FLOAT* fz = atom->fz;
    MD_FLOAT S, E;

    S = getTimeStamp();
    for(int i = 0; i < Nlocal; i++) {
        fx[i] = 0.0;
        fy[i] = 0.0;
        fz[i] = 0.0;
    }

    LIKWID_MARKER_START("force");

#pragma omp parallel for
    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MD_FLOAT xtmp = x[i];
        MD_FLOAT ytmp = y[i];
        MD_FLOAT ztmp = z[i];

        MD_FLOAT fix = 0;
        MD_FLOAT fiy = 0;
        MD_FLOAT fiz = 0;

        for(int k = 0; k < numneighs; k++) {
            int j = neighs[k];
            MD_FLOAT delx = xtmp - x[j];
            MD_FLOAT dely = ytmp - y[j];
            MD_FLOAT delz = ztmp - z[j];
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

            if(rsq < cutforcesq) {
                MD_FLOAT sr2 = 1.0 / rsq;
                MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
                MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;
                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force;
            }
        }

        fx[i] += fix;
        fy[i] += fiy;
        fz[i] += fiz;
    }
    LIKWID_MARKER_STOP("force");
    E = getTimeStamp();

    return E-S;
}


void printAtomState(Atom *atom)
{
    printf("Atom counts: Natoms=%d Nlocal=%d Nghost=%d Nmax=%d\n",
            atom->Natoms, atom->Nlocal, atom->Nghost, atom->Nmax);

/*     int nall = atom->Nlocal + atom->Nghost; */

/*     for (int i=0; i<nall; i++) { */
/*         printf("%d  %f %f %f\n", i, atom->x[i], atom->y[i], atom->z[i]); */
/*     } */
}

int main (int argc, char** argv)
{
    double timer[NUMTIMER];
    Atom atom;
    Neighbor neighbor;
    Parameter param;

    LIKWID_MARKER_INIT;
#pragma omp parallel
    {
        LIKWID_MARKER_REGISTER("force");
        LIKWID_MARKER_REGISTER("reneighbour");
        LIKWID_MARKER_REGISTER("pbc");
    }
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
            printf("-n / --nsteps <int>:  set number of timesteps for simulation\n");
            printf("-nx/-ny/-nz <int>:    set linear dimension of systembox in x/y/z direction\n");
            printf(HLINE);
            exit(EXIT_SUCCESS);
        }
    }

    setup(&param, &atom, &neighbor);
    computeThermo(0, &param, &atom);
    computeForce(&param, &atom, &neighbor);

    timer[FORCE] = 0.0;
    timer[NEIGH] = 0.0;
    timer[TOTAL] = getTimeStamp();

    for(int n = 0; n < param.ntimes; n++) {

        initialIntegrate(&param, &atom);

        if((n + 1) % param.every) {
            updatePbc(&atom, &param);
        } else {
            timer[NEIGH] += reneighbour(&param, &atom, &neighbor);
        }

        timer[FORCE] += computeForce(&param, &atom, &neighbor);
        finalIntegrate(&param, &atom);

        if(!((n + 1) % param.nstat) && (n+1) < param.ntimes) {
            computeThermo(n + 1, &param, &atom);
        }
    }

    timer[TOTAL] = getTimeStamp() - timer[TOTAL];
    computeThermo(-1, &param, &atom);

    printf(HLINE);
#if PRECISION == 1
    printf("Using single precision floating point.\n");
#else
    printf("Using double precision floating point.\n");
#endif
    printf(HLINE);
    printf("System: %d atoms %d ghost atoms, Steps: %d\n", atom.Natoms, atom.Nghost, param.ntimes);
    printf("TOTAL %.2fs FORCE %.2fs NEIGH %.2fs REST %.2fs\n",
            timer[TOTAL], timer[FORCE], timer[NEIGH], timer[TOTAL]-timer[FORCE]-timer[NEIGH]);
    printf(HLINE);
    printf("Performance: %.2f million atom updates per second\n",
            1e-6 * (double) atom.Natoms * param.ntimes / timer[TOTAL]);

    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
