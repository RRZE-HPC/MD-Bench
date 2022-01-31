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
#include <eam.h>
#include <vtk.h>
#include <util.h>

#define HLINE "----------------------------------------------------------------------------\n"

extern double computeForceLJ(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceEam(Eam*, Parameter*, Atom*, Neighbor*, Stats*);

void init(Parameter *param) {
    param->input_file = NULL;
    param->vtk_file = NULL;
    param->force_field = FF_LJ;
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

double setup(Parameter *param, Eam *eam, Atom *atom, Neighbor *neighbor, Stats *stats) {
    if(param->force_field == FF_EAM) { initEam(eam, param); }
    double S, E;
    param->lattice = pow((4.0 / param->rho), (1.0 / 3.0));
    param->xprd = param->nx * param->lattice;
    param->yprd = param->ny * param->lattice;
    param->zprd = param->nz * param->lattice;

    S = getTimeStamp();
    initAtom(atom);
    initPbc(atom);
    initStats(stats);
    initNeighbor(neighbor, param);

    if(param->input_file == NULL) {
        createAtom(atom, param);
    } else {
        readAtom(atom, param);
    }

    setupNeighbor(param, atom);
    setupThermo(param, atom->Natoms);
    if(param->input_file == NULL) { adjustThermo(param, atom); }
    buildClusters(atom);
    setupPbc(atom, param);
    binClusters(atom);
    buildNeighbor(atom, neighbor);
    E = getTimeStamp();
    return E-S;
}

double reneighbour(Parameter *param, Atom *atom, Neighbor *neighbor) {
    double S, E;
    S = getTimeStamp();
    LIKWID_MARKER_START("reneighbour");
    updateSingleAtoms(atom);
    updateAtomsPbc(atom, param);
    buildClusters(atom);
    setupPbc(atom, param);
    binClusters(atom);
    buildNeighbor(atom, neighbor);
    LIKWID_MARKER_STOP("reneighbour");
    E = getTimeStamp();
    return E-S;
}

void initialIntegrate(Parameter *param, Atom *atom) {
    fprintf(stdout, "initialIntegrate start\n");
    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        MD_FLOAT *ciptr = cluster_pos_ptr(ci);
        MD_FLOAT *civptr = cluster_velocity_ptr(ci);
        MD_FLOAT *cifptr = cluster_force_ptr(ci);

        for(int cii = 0; cii < atom->clusters[ci].natoms; cii++) {
            cluster_x(civptr, cii) += param->dtforce * cluster_x(cifptr, cii);
            cluster_y(civptr, cii) += param->dtforce * cluster_y(cifptr, cii);
            cluster_z(civptr, cii) += param->dtforce * cluster_z(cifptr, cii);
            cluster_x(ciptr, cii) += param->dt * cluster_x(civptr, cii);
            cluster_y(ciptr, cii) += param->dt * cluster_y(civptr, cii);
            cluster_z(ciptr, cii) += param->dt * cluster_z(civptr, cii);
        }
    }
    fprintf(stdout, "initialIntegrate end\n");
}

void finalIntegrate(Parameter *param, Atom *atom) {
    fprintf(stdout, "finalIntegrate start\n");
    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        MD_FLOAT *civptr = cluster_velocity_ptr(ci);
        MD_FLOAT *cifptr = cluster_force_ptr(ci);

        for(int cii = 0; cii < atom->clusters[ci].natoms; cii++) {
            cluster_x(civptr, cii) += param->dtforce * cluster_x(cifptr, cii);
            cluster_y(civptr, cii) += param->dtforce * cluster_y(cifptr, cii);
            cluster_z(civptr, cii) += param->dtforce * cluster_z(cifptr, cii);
        }
    }
    fprintf(stdout, "finalIntegrate end\n");
}

void printAtomState(Atom *atom) {
    printf("Atom counts: Natoms=%d Nlocal=%d Nghost=%d Nmax=%d\n",
            atom->Natoms, atom->Nlocal, atom->Nghost, atom->Nmax);

    /*     int nall = atom->Nlocal + atom->Nghost; */

    /*     for (int i=0; i<nall; i++) { */
    /*         printf("%d  %f %f %f\n", i, atom->x[i], atom->y[i], atom->z[i]); */
    /*     } */
}

int main(int argc, char** argv) {
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
        //LIKWID_MARKER_REGISTER("reneighbour");
        //LIKWID_MARKER_REGISTER("pbc");
    }
    init(&param);

    for(int i = 0; i < argc; i++)
    {
        if((strcmp(argv[i], "-f") == 0))
        {
            if((param.force_field = str2ff(argv[++i])) < 0) {
                fprintf(stderr, "Invalid force field!\n");
                exit(-1);
            }
            continue;
        }
        if((strcmp(argv[i], "-i") == 0))
        {
            param.input_file = strdup(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-e") == 0))
        {
            param.eam_file = strdup(argv[++i]);
            continue;
        }
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
        if((strcmp(argv[i], "--freq") == 0))
        {
            param.proc_freq = atof(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "--vtk") == 0))
        {
            param.vtk_file = strdup(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0))
        {
            printf("MD Bench: A minimalistic re-implementation of miniMD\n");
            printf(HLINE);
            printf("-f <string>:          force field (lj or eam), default lj\n");
            printf("-i <string>:          input file with atom positions (dump)\n");
            printf("-e <string>:          input file for EAM\n");
            printf("-n / --nsteps <int>:  set number of timesteps for simulation\n");
            printf("-nx/-ny/-nz <int>:    set linear dimension of systembox in x/y/z direction\n");
            printf("--freq <real>:        processor frequency (GHz)\n");
            printf("--vtk <string>:       VTK file for visualization\n");
            printf(HLINE);
            exit(EXIT_SUCCESS);
        }
    }

    setup(&param, &eam, &atom, &neighbor, &stats);
    computeThermo(0, &param, &atom);
#if defined(MEM_TRACER) || defined(INDEX_TRACER)
    traceAddresses(&param, &atom, &neighbor, n + 1);
#endif
    if(param.force_field == FF_EAM) {
        timer[FORCE] = computeForceEam(&eam, &param, &atom, &neighbor, &stats);
    } else {
        timer[FORCE] = computeForceLJ(&param, &atom, &neighbor, &stats);
    }

    timer[NEIGH] = 0.0;
    timer[TOTAL] = getTimeStamp();

    if(param.vtk_file != NULL) {
        write_atoms_to_vtk_file(param.vtk_file, &atom, 0);
    }

    for(int n = 0; n < param.ntimes; n++) {
        initialIntegrate(&param, &atom);

        if((n + 1) % param.every) {
            updatePbc(&atom, &param, 0);
        } else {
            timer[NEIGH] += reneighbour(&param, &atom, &neighbor);
        }

#if defined(MEM_TRACER) || defined(INDEX_TRACER)
        traceAddresses(&param, &atom, &neighbor, n + 1);
#endif

        if(param.force_field == FF_EAM) {
            timer[FORCE] += computeForceEam(&eam, &param, &atom, &neighbor, &stats);
        } else {
            timer[FORCE] += computeForceLJ(&param, &atom, &neighbor, &stats);
        }

        finalIntegrate(&param, &atom);

        if(!((n + 1) % param.nstat) && (n+1) < param.ntimes) {
            computeThermo(n + 1, &param, &atom);
        }

        if(param.vtk_file != NULL) {
            write_atoms_to_vtk_file(param.vtk_file, &atom, n + 1);
        }
    }

    timer[TOTAL] = getTimeStamp() - timer[TOTAL];
    computeThermo(-1, &param, &atom);

    printf(HLINE);
    printf("Force field: %s\n", ff2str(param.force_field));
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
#ifdef COMPUTE_STATS
    displayStatistics(&atom, &param, &stats, timer);
#endif
    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
