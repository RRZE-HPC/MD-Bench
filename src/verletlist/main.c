/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <likwid-marker.h>
#include <omp.h>

#include <allocate.h>
#include <atom.h>
#include <device.h>
#include <eam.h>
#include <integrate.h>
#include <neighbor.h>
#include <parameter.h>
#include <pbc.h>
#include <stats.h>
#include <thermo.h>
#include <timers.h>
#include <timing.h>
#include <util.h>
#include <vtk.h>

#define HLINE "------------------------------------------------------------------\n"

extern double computeForceLJHalfNeigh(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceLJFullNeigh(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceEam(Eam*, Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceDemFullNeigh(Parameter*, Atom*, Neighbor*, Stats*);

#ifdef CUDA_TARGET
extern double computeForceLJFullNeigh_cuda(Parameter*, Atom*, Neighbor*);
#endif

double setup(Parameter* param, Eam* eam, Atom* atom, Neighbor* neighbor, Stats* stats)
{
    if (param->force_field == FF_EAM) {
        initEam(eam, param);
    }
    double timeStart, timeStop;
    param->lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    param->xprd    = param->nx * param->lattice;
    param->yprd    = param->ny * param->lattice;
    param->zprd    = param->nz * param->lattice;

    timeStart = getTimeStamp();
    initAtom(atom);
    initPbc(atom);
    initStats(stats);
    initNeighbor(neighbor, param);
    if (param->input_file == NULL) {
        createAtom(atom, param);
    } else {
        readAtom(atom, param);
    }

    setupNeighbor(param);
    setupThermo(param, atom->Natoms);
    if (param->input_file == NULL) {
        adjustThermo(param, atom);
    }
#ifdef SORT_ATOMS
    atom->Nghost = 0;
    sortAtom(atom);
#endif
    setupPbc(atom, param);
    initDevice(atom, neighbor);
    updatePbc(atom, param, true);
    buildNeighbor(atom, neighbor);
    timeStop = getTimeStamp();
    return timeStop - timeStart;
}

double reneighbour(Parameter* param, Atom* atom, Neighbor* neighbor)
{
    double timeStart, timeStop;
    timeStart = getTimeStamp();
    LIKWID_MARKER_START("reneighbour");
    updateAtomsPbc(atom, param);
#ifdef SORT_ATOMS
    atom->Nghost = 0;
    sortAtom(atom);
#endif
    setupPbc(atom, param);
    updatePbc(atom, param, true);
    buildNeighbor(atom, neighbor);
    LIKWID_MARKER_STOP("reneighbour");
    timeStop = getTimeStamp();
    return timeStop - timeStart;
}

void printAtomState(Atom* atom)
{
    printf("Atom counts: Natoms=%d Nlocal=%d Nghost=%d Nmax=%d\n",
        atom->Natoms,
        atom->Nlocal,
        atom->Nghost,
        atom->Nmax);
    // int nall = atom->Nlocal + atom->Nghost;
    // for (int i=0; i<nall; i++) {
    //     printf("%d  %f %f %f\n", i, atom->x[i], atom->y[i], atom->z[i]);
    // }
}

double computeForce(
    Eam* eam, Parameter* param, Atom* atom, Neighbor* neighbor, Stats* stats)
{
    if (param->force_field == FF_EAM) {
        return computeForceEam(eam, param, atom, neighbor, stats);
    } else if (param->force_field == FF_DEM) {
        if (param->half_neigh) {
            fprintf(stderr, "Error: DEM cannot use half neighbor-lists!\n");
            return 0.0;
        } else {
            return computeForceDemFullNeigh(param, atom, neighbor, stats);
        }
    }

    if (param->half_neigh) {
        return computeForceLJHalfNeigh(param, atom, neighbor, stats);
    }

#ifdef CUDA_TARGET
    return computeForceLJFullNeigh(param, atom, neighbor);
#else
    return computeForceLJFullNeigh(param, atom, neighbor, stats);
#endif
}

void writeInput(Parameter* param, Atom* atom)
{
    FILE* fpin = fopen("input.in", "w");
    fprintf(fpin, "0,%f,0,%f,0,%f\n", param->xprd, param->yprd, param->zprd);

    for (int i = 0; i < atom->Nlocal; i++) {
        fprintf(fpin,
            "1,%f,%f,%f,%f,%f,%f\n",
            atom_x(i),
            atom_y(i),
            atom_z(i),
            atom_vx(i),
            atom_vy(i),
            atom_vz(i));
    }

    fclose(fpin);
}

int main(int argc, char** argv)
{
    double timer[NUMTIMER];
    Eam eam;
    Atom atom;
    Neighbor neighbor;
    Stats stats;
    Parameter param;

    LIKWID_MARKER_INIT;
#pragma omp parallel
    {
        LIKWID_MARKER_REGISTER("force");
        // LIKWID_MARKER_REGISTER("reneighbour");
        // LIKWID_MARKER_REGISTER("pbc");
    }

    initParameter(&param);
    for (int i = 0; i < argc; i++) {
        if ((strcmp(argv[i], "-p") == 0) || strcmp(argv[i], "--params") == 0) {
            readParameter(&param, argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-f") == 0)) {
            if ((param.force_field = str2ff(argv[++i])) < 0) {
                fprintf(stderr, "Invalid force field!\n");
                exit(-1);
            }
            continue;
        }
        if ((strcmp(argv[i], "-i") == 0)) {
            param.input_file = strdup(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-e") == 0)) {
            param.eam_file = strdup(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-n") == 0) || (strcmp(argv[i], "--nsteps") == 0)) {
            param.ntimes = atoi(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-nx") == 0)) {
            param.nx = atoi(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-ny") == 0)) {
            param.ny = atoi(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-nz") == 0)) {
            param.nz = atoi(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-half") == 0)) {
            param.half_neigh = atoi(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-r") == 0) || (strcmp(argv[i], "--radius") == 0)) {
            param.cutforce = atof(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-s") == 0) || (strcmp(argv[i], "--skin") == 0)) {
            param.skin = atof(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "--freq") == 0)) {
            param.proc_freq = atof(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "--vtk") == 0)) {
            param.vtk_file = strdup(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-w") == 0)) {
            param.write_atom_file = strdup(argv[++i]);
            continue;
        }
        if ((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0)) {
            printf("MD Bench: A minimalistic re-implementation of miniMD\n");
            printf(HLINE);
            printf("-p / --params <string>:     file to read parameters from (can be "
                   "specified more than once)\n");
            printf("-f <string>:                force field (lj, eam or dem), "
                   "default lj\n");
            printf("-i <string>:                input file with atom positions "
                   "(dump)\n");
            printf("-e <string>:                input file for EAM\n");
            printf("-n / --nsteps <int>:        set number of timesteps for "
                   "simulation\n");
            printf("-nx/-ny/-nz <int>:          set linear dimension of systembox in "
                   "x/y/z direction\n");
            printf("-half <int>:                use half (1) or full (0) neighbor "
                   "lists\n");
            printf("-r / --radius <real>:       set cutoff radius\n");
            printf("-s / --skin <real>:         set skin (verlet buffer)\n");
            printf("-w <file>:                  write input atoms to file\n");
            printf("--freq <real>:              processor frequency (GHz)\n");
            printf("--vtk <string>:             VTK file for visualization\n");
            printf(HLINE);
            exit(EXIT_SUCCESS);
        }
    }

    param.cutneigh = param.cutforce + param.skin;
    setup(&param, &eam, &atom, &neighbor, &stats);
    printParameter(&param);
    printf(HLINE);

    printf("step\ttemp\t\tpressure\n");
    computeThermo(0, &param, &atom);
#if defined(MEM_TRACER) || defined(INDEX_TRACER)
    traceAddresses(&param, &atom, &neighbor, n + 1);
#endif

    if (param.write_atom_file != NULL) {
        writeAtom(&atom, &param);
    }

    // writeInput(&param, &atom);

    timer[FORCE] = computeForce(&eam, &param, &atom, &neighbor, &stats);
    timer[NEIGH] = 0.0;
    timer[TOTAL] = getTimeStamp();

    if (param.vtk_file != NULL) {
        write_atoms_to_vtk_file(param.vtk_file, &atom, 0);
    }

    for (int n = 0; n < param.ntimes; n++) {
        bool reneigh = (n + 1) % param.reneigh_every == 0;
        initialIntegrate(reneigh, &param, &atom);
        if ((n + 1) % param.reneigh_every) {
            updatePbc(&atom, &param, false);
        } else {
            timer[NEIGH] += reneighbour(&param, &atom, &neighbor);
        }

#if defined(MEM_TRACER) || defined(INDEX_TRACER)
        traceAddresses(&param, &atom, &neighbor, n + 1);
#endif

        timer[FORCE] += computeForce(&eam, &param, &atom, &neighbor, &stats);
        finalIntegrate(reneigh, &param, &atom);

        if (!((n + 1) % param.nstat) && (n + 1) < param.ntimes) {
#ifdef CUDA_TARGET
            memcpyFromGPU(atom.x, atom.d_atom.x, atom.Nmax * sizeof(MD_FLOAT) * 3);
#endif
            computeThermo(n + 1, &param, &atom);
        }

        if (param.vtk_file != NULL) {
            write_atoms_to_vtk_file(param.vtk_file, &atom, n + 1);
        }
    }

    timer[TOTAL] = getTimeStamp() - timer[TOTAL];
    computeThermo(-1, &param, &atom);

    printf(HLINE);
    printf("System: %d atoms %d ghost atoms, Steps: %d\n",
        atom.Natoms,
        atom.Nghost,
        param.ntimes);
    printf("TOTAL %.2fs FORCE %.2fs NEIGH %.2fs REST %.2fs\n",
        timer[TOTAL],
        timer[FORCE],
        timer[NEIGH],
        timer[TOTAL] - timer[FORCE] - timer[NEIGH]);
    printf(HLINE);

    int nthreads  = 0;
    int chunkSize = 0;
    omp_sched_t schedKind;
    char schedType[10];
#pragma omp parallel
#pragma omp master
    {
        omp_get_schedule(&schedKind, &chunkSize);

        switch (schedKind) {
        case omp_sched_static:
            strcpy(schedType, "static");
            break;
        case omp_sched_dynamic:
            strcpy(schedType, "dynamic");
            break;
        case omp_sched_guided:
            strcpy(schedType, "guided");
            break;
        case omp_sched_auto:
            strcpy(schedType, "auto");
            break;
        case omp_sched_monotonic:
            strcpy(schedType, "auto");
            break;
        }

        nthreads = omp_get_max_threads();
    }

    printf("Num threads: %d\n", nthreads);
    printf("Schedule: (%s,%d)\n", schedType, chunkSize);

    printf("Performance: %.2f million atom updates per second\n",
        1e-6 * (double)atom.Natoms * param.ntimes / timer[TOTAL]);
#ifdef COMPUTE_STATS
    displayStatistics(&atom, &param, &stats, timer);
#endif
    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
