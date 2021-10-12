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
#include <stats.h>
#include <thermo.h>
#include <pbc.h>
#include <timers.h>

#define HLINE "----------------------------------------------------------------------------\n"

extern double computeForce(Parameter*, Atom*, Neighbor*, Stats*, int, int);

void init(Parameter *param)
{
    param->epsilon = 1.0;
    param->sigma6 = 1.0;
    param->rho = 0.8442;
    param->ntypes = 4;
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
    param->proc_freq = 2.4;
}

double setup(
        Parameter *param,
        Atom *atom,
        Neighbor *neighbor,
        Stats *stats)
{
    double S, E;
    param->lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    param->xprd = param->nx * param->lattice;
    param->yprd = param->ny * param->lattice;
    param->zprd = param->nz * param->lattice;

    S = getTimeStamp();
    initAtom(atom);
    initNeighbor(neighbor, param);
    initPbc();
    initStats(stats);
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
    MD_FLOAT* fx = atom->fx; MD_FLOAT* fy = atom->fy; MD_FLOAT* fz = atom->fz;
    MD_FLOAT* vx = atom->vx; MD_FLOAT* vy = atom->vy; MD_FLOAT* vz = atom->vz;

    for(int i = 0; i < atom->Nlocal; i++) {
        vx[i] += param->dtforce * fx[i];
        vy[i] += param->dtforce * fy[i];
        vz[i] += param->dtforce * fz[i];
        atom_x(i) = atom_x(i) + param->dt * vx[i];
        atom_y(i) = atom_y(i) + param->dt * vy[i];
        atom_z(i) = atom_z(i) + param->dt * vz[i];
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
    Stats stats;
    Parameter param;

    LIKWID_MARKER_INIT;
#pragma omp parallel
    {
        LIKWID_MARKER_REGISTER("force");
        //LIKWID_MARKER_REGISTER("reneighbour");
        //LIKWID_MARKER_REGISTER("pbc");
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
        if((strcmp(argv[i], "-f") == 0))
        {
            param.proc_freq = atof(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0))
        {
            printf("MD Bench: A minimalistic re-implementation of miniMD\n");
            printf(HLINE);
            printf("-n / --nsteps <int>:  set number of timesteps for simulation\n");
            printf("-nx/-ny/-nz <int>:    set linear dimension of systembox in x/y/z direction\n");
            printf("-f <real>:            processor frequency (GHz)\n");
            printf(HLINE);
            exit(EXIT_SUCCESS);
        }
    }

    setup(&param, &atom, &neighbor, &stats);
    computeThermo(0, &param, &atom);
    computeForce(&param, &atom, &neighbor, &stats, 1, 0);

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

        timer[FORCE] += computeForce(&param, &atom, &neighbor, &stats, 0, n + 1);
        finalIntegrate(&param, &atom);

        if(!((n + 1) % param.nstat) && (n+1) < param.ntimes) {
            computeThermo(n + 1, &param, &atom);
        }
    }

    timer[TOTAL] = getTimeStamp() - timer[TOTAL];
    computeThermo(-1, &param, &atom);

    printf(HLINE);
    printf("Data layout for positions: %s\n", POS_DATA_LAYOUT);
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
    displayStatistics(&atom, &param, &stats, timer);
    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
