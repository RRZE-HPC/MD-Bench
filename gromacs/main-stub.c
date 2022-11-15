/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>
#include <string.h>
#include <math.h>
//---
#include <likwid-marker.h>
//---
#include <timing.h>
#include <allocate.h>
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>
#include <stats.h>
#include <thermo.h>
#include <eam.h>
#include <pbc.h>
#include <timers.h>
#include <util.h>

#define HLINE "----------------------------------------------------------------------------\n"

extern double computeForceLJ_ref(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceLJ_4xn(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceLJ_2xnn(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceEam(Eam*, Parameter*, Atom*, Neighbor*, Stats*);

// Patterns
#define P_SEQ   0
#define P_FIX   1
#define P_RAND  2

void init(Parameter *param) {
    param->input_file = NULL;
    param->force_field = FF_LJ;
    param->epsilon = 1.0;
    param->sigma6 = 1.0;
    param->rho = 0.8442;
    param->ntypes = 4;
    param->ntimes = 200;
    param->nx = 1;
    param->ny = 1;
    param->nz = 1;
    param->lattice = 1.0;
    param->cutforce = 1000000.0;
    param->cutneigh = param->cutforce;
    param->mass = 1.0;
    // Unused
    param->dt = 0.005;
    param->dtforce = 0.5 * param->dt;
    param->nstat = 100;
    param->temp = 1.44;
    param->reneigh_every = 20;
    param->proc_freq = 2.4;
    param->eam_file = NULL;
}

// Show debug messages
#define DEBUG(msg)  printf(msg)
// Do not show debug messages
//#define DEBUG(msg)


void createNeighbors(Atom *atom, Neighbor *neighbor, int pattern, int nneighs, int nreps) {
    const int maxneighs = nneighs * nreps;
    const int jfac = MAX(1, CLUSTER_N / CLUSTER_M);
    const int ncj = atom->Nclusters_local / jfac;
    neighbor->numneigh = (int*) malloc(atom->Nclusters_max * sizeof(int));
    neighbor->neighbors = (int*) malloc(atom->Nclusters_max * maxneighs * sizeof(int));

    if(pattern == P_RAND && ncj <= nneighs) {
        fprintf(stderr, "Error: P_RAND: Number of j-clusters should be higher than number of j-cluster neighbors per i-cluster!\n");
        exit(-1);
    }

    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        int *neighptr = &(neighbor->neighbors[ci * neighbor->maxneighs]);
        int j = (pattern == P_SEQ) ? CJ0_FROM_CI(ci) : 0;
        int m = (pattern == P_SEQ) ? ncj : nneighs;
        int k = 0;

        for(int k = 0; k < nneighs; k++) {
            if(pattern == P_RAND) {
                int found = 0;
                do {
                    int cj = rand() % ncj;
                    neighptr[k] = cj;
                    found = 0;
                    for(int l = 0; l < k; l++) {
                        if(neighptr[l] == cj) {
                            found = 1;
                        }
                    }
                } while(found == 1);
            } else {
                neighptr[k] = j;
                j = (j + 1) % m;
            }
        }

        for(int r = 1; r < nreps; r++) {
            for(int k = 0; k < nneighs; k++) {
                neighptr[r * nneighs + k] = neighptr[k];
            }
        }

        neighbor->numneigh[ci] = nneighs * nreps;
    }
}

int main(int argc, const char *argv[]) {
    Eam eam;
    Atom atom_data;
    Atom *atom = (Atom *)(&atom_data);
    Neighbor neighbor;
    Stats stats;
    Parameter param;
    char *pattern_str = NULL;
    int pattern = P_SEQ;
    int niclusters = 256;               // Number of local i-clusters
    int iclusters_natoms = CLUSTER_M;   // Number of valid atoms within i-clusters
    int nneighs = 9;                    // Number of j-cluster neighbors per i-cluster
    int nreps = 1;
    int csv = 0;

    LIKWID_MARKER_INIT;
    LIKWID_MARKER_REGISTER("force");
    DEBUG("Initializing parameters...\n");
    init(&param);

    for(int i = 0; i < argc; i++) {
        if((strcmp(argv[i], "-f") == 0)) {
            if((param.force_field = str2ff(argv[++i])) < 0) {
                fprintf(stderr, "Invalid force field!\n");
                exit(-1);
            }
            continue;
        }
        if((strcmp(argv[i], "-p") == 0)) {
            pattern_str = strdup(argv[++i]);
            if(strncmp(pattern_str, "seq", 3) == 0) { pattern = P_SEQ; }
            else if(strncmp(pattern_str, "fix", 3) == 0) { pattern = P_FIX; }
            else if(strncmp(pattern_str, "rand", 3) == 0) { pattern = P_RAND; }
            else {
                fprintf(stderr, "Invalid pattern!\n");
                exit(-1);
            }
            continue;
        }
        if((strcmp(argv[i], "-e") == 0)) {
            param.eam_file = strdup(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-n") == 0) || (strcmp(argv[i], "--nsteps") == 0)) {
            param.ntimes = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-ni") == 0)) {
            niclusters = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-na") == 0)) {
            iclusters_natoms = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-nn") == 0)) {
            nneighs = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "-nr") == 0)) {
            nreps = atoi(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "--freq") == 0)) {
            param.proc_freq = atof(argv[++i]);
            continue;
        }
        if((strcmp(argv[i], "--csv") == 0)) {
            csv = 1;
            continue;
        }
        if((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0)) {
            printf("MD Bench: A minimalistic re-implementation of miniMD\n");
            printf(HLINE);
            printf("-f <string>:          force field (lj or eam), default lj\n");
            printf("-p <string>:          pattern for data accesses (seq, fix or rand)\n");
            printf("-n / --nsteps <int>:  number of timesteps for simulation\n");
            printf("-ni <int>:            number of i-clusters (default 256)\n");
            printf("-na <int>:            number of atoms per i-cluster (default %d)\n", CLUSTER_M);
            printf("-nn <int>:            number of j-cluster neighbors per i-cluster (default 9)\n");
            printf("-nr <int>:            number of times neighbor lists should be replicated (default 1)\n");
            printf("--freq <real>:        set CPU frequency (GHz) and display average cycles per atom and neighbors\n");
            printf("--csv:                set output as CSV style\n");
            printf(HLINE);
            exit(EXIT_SUCCESS);
        }
    }

    if(pattern_str == NULL) {
        pattern_str = strdup("seq\0");
    }

    if(param.force_field == FF_EAM) {
        DEBUG("Initializing EAM parameters...\n");
        initEam(&eam, &param);
    }

    DEBUG("Initializing atoms...\n");
    initAtom(atom);
    initStats(&stats);

    atom->ntypes = param.ntypes;
    atom->epsilon = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->sigma6 = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->cutforcesq = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    atom->cutneighsq = allocate(ALIGNMENT, atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    for(int i = 0; i < atom->ntypes * atom->ntypes; i++) {
        atom->epsilon[i] = param.epsilon;
        atom->sigma6[i] = param.sigma6;
        atom->cutneighsq[i] = param.cutneigh * param.cutneigh;
        atom->cutforcesq[i] = param.cutforce * param.cutforce;
    }

    DEBUG("Creating atoms...\n");
    while(atom->Nmax < niclusters * iclusters_natoms) {
        growAtom(atom);
    }

    while(atom->Nclusters_max < niclusters) {
        growClusters(atom);
    }

    for(int ci = 0; ci < niclusters; ++ci) {
        int ci_sca_base = CI_SCALAR_BASE_INDEX(ci);
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT *ci_x = &atom->cl_x[ci_vec_base];
        MD_FLOAT *ci_v = &atom->cl_v[ci_vec_base];
        int *ci_type = &atom->cl_type[ci_sca_base];

        for(int cii = 0; cii < iclusters_natoms; ++cii) {
            ci_x[CL_X_OFFSET + cii] = (MD_FLOAT)(ci * iclusters_natoms + cii) * 0.00001;
            ci_x[CL_Y_OFFSET + cii] = (MD_FLOAT)(ci * iclusters_natoms + cii) * 0.00001;
            ci_x[CL_Z_OFFSET + cii] = (MD_FLOAT)(ci * iclusters_natoms + cii) * 0.00001;
            ci_v[CL_X_OFFSET + cii] = 0.0;
            ci_v[CL_Y_OFFSET + cii] = 0.0;
            ci_v[CL_Z_OFFSET + cii] = 0.0;
            ci_type[cii] = rand() % atom->ntypes;
            atom->Nlocal++;
        }

        for(int cii = iclusters_natoms; cii < CLUSTER_M; cii++) {
            ci_x[CL_X_OFFSET + cii] = INFINITY;
            ci_x[CL_Y_OFFSET + cii] = INFINITY;
            ci_x[CL_Z_OFFSET + cii] = INFINITY;
        }

        atom->iclusters[ci].natoms = iclusters_natoms;
        atom->Nclusters_local++;
    }

    const double estim_atom_volume = (double)(atom->Nlocal * 3 * sizeof(MD_FLOAT));
    const double estim_neighbors_volume = (double)(atom->Nlocal * (nneighs + 2) * sizeof(int));
    const double estim_volume = (double)(atom->Nlocal * 6 * sizeof(MD_FLOAT) + estim_neighbors_volume);

    if(!csv) {
        printf("Pattern: %s\n", pattern_str);
        printf("Number of timesteps: %d\n", param.ntimes);
        printf("Number of i-clusters: %d\n", niclusters);
        printf("Number of atoms per i-cluster: %d\n", iclusters_natoms);
        printf("Number of j-cluster neighbors per i-cluster: %d\n", nneighs);
        printf("Number of times to replicate neighbor lists: %d\n", nreps);
        printf("Estimated total data volume (kB): %.4f\n", estim_volume / 1000.0);
        printf("Estimated atom data volume (kB): %.4f\n", estim_atom_volume / 1000.0);
        printf("Estimated neighborlist data volume (kB): %.4f\n", estim_neighbors_volume / 1000.0);
    }

    DEBUG("Defining j-clusters...\n");
    defineJClusters(atom);
    DEBUG("Initializing neighbor lists...\n");
    initNeighbor(&neighbor, &param);
    DEBUG("Creating neighbor lists...\n");
    createNeighbors(atom, &neighbor, pattern, nneighs, nreps);
    DEBUG("Computing forces...\n");

    double T_accum = 0.0;
    for(int i = 0; i < param.ntimes; i++) {
        #if defined(MEM_TRACER) || defined(INDEX_TRACER)
        traceAddresses(&param, atom, &neighbor, i + 1);
        #endif

        if(param.force_field == FF_EAM) {
            T_accum += computeForceEam(&eam, &param, atom, &neighbor, &stats);
        } else {
            T_accum += computeForceLJ(&param, atom, &neighbor, &stats);
        }
    }

    double freq_hz = param.proc_freq * 1.e9;
    const double atoms_updates_per_sec = (double)(atom->Nlocal) / T_accum * (double)(param.ntimes);
    const double cycles_per_atom = T_accum / (double)(atom->Nlocal) / (double)(param.ntimes) * freq_hz;
    const double cycles_per_neigh = cycles_per_atom / (double)(nneighs);

    if(!csv) {
        printf("Total time: %.4f, Mega atom updates/s: %.4f\n", T_accum, atoms_updates_per_sec / 1.e6);
        if(param.proc_freq > 0.0) {
            printf("Cycles per atom: %.4f, Cycles per neighbor: %.4f\n", cycles_per_atom, cycles_per_neigh);
        }
    } else {
        printf("steps,pattern,niclusters,iclusters_natoms,nneighs,nreps,total vol.(kB),atoms vol.(kB),neigh vol.(kB),time(s),atom upds/s(M)");
        if(param.proc_freq > 0.0) {
            printf(",cy/atom,cy/neigh");
        }
        printf("\n");

        printf("%d,%s,%d,%d,%d,%d,%.4f,%.4f,%.4f,%.4f,%.4f",
            param.ntimes, pattern_str, niclusters, iclusters_natoms, nneighs, nreps,
            estim_volume / 1.e3, estim_atom_volume / 1.e3, estim_neighbors_volume / 1.e3, T_accum, atoms_updates_per_sec / 1.e6);

        if(param.proc_freq > 0.0) {
            printf(",%.4f,%.4f", cycles_per_atom, cycles_per_neigh);
        }
        printf("\n");
    }

    double timer[NUMTIMER];
    timer[FORCE] = T_accum;
    displayStatistics(atom, &param, &stats, timer);
    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
