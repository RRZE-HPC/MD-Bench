/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>

#include <atom.h>
#include <parameter.h>
#include <stats.h>
#include <timers.h>

void initStats(Stats *s) {
    s->calculated_forces = 0;
    s->num_neighs = 0;
    s->force_iters = 0;
    s->atoms_within_cutoff = 0;
    s->atoms_outside_cutoff = 0;
    s->clusters_within_cutoff = 0;
    s->clusters_outside_cutoff = 0;
}

void displayStatistics(Atom *atom, Parameter *param, Stats *stats, double *timer) {
#ifdef COMPUTE_STATS

    const int MxN = CLUSTER_M * CLUSTER_N;
    double avg_atoms_cluster = (double)(atom->Nlocal) / (double)(atom->Nclusters_local);
    double force_useful_volume = 1e-9 * ( (double)(atom->Nlocal * (param->ntimes + 1)) * (sizeof(MD_FLOAT) * 6 + sizeof(int)) +
                                          (double)(stats->num_neighs) * (sizeof(MD_FLOAT) * 3 + sizeof(int)) );
    double avg_neigh_atom = (stats->num_neighs * CLUSTER_N) / (double)(atom->Nlocal * (param->ntimes + 1));
    double avg_neigh_cluster = (double)(stats->num_neighs) / (double)(stats->calculated_forces);
    double avg_simd = stats->force_iters / (double)(atom->Nlocal * (param->ntimes + 1));

    #ifdef EXPLICIT_TYPES
    force_useful_volume += 1e-9 * (double)((atom->Nlocal * (param->ntimes + 1)) + stats->num_neighs) * sizeof(int);
    #endif

    printf("Statistics:\n");
    printf("\tVector width: %d, Processor frequency: %.4f GHz\n", VECTOR_WIDTH, param->proc_freq);
    printf("\tAverage atoms per cluster: %.4f\n", avg_atoms_cluster);
    printf("\tAverage neighbors per atom: %.4f\n", avg_neigh_atom);
    printf("\tAverage neighbors per cluster: %.4f\n", avg_neigh_cluster);
    printf("\tAverage SIMD iterations per atom: %.4f\n", avg_simd);
    printf("\tTotal number of computed pair interactions: %lld\n", stats->num_neighs * MxN);
    printf("\tTotal number of SIMD iterations: %lld\n", stats->force_iters);
    printf("\tUseful read data volume for force computation: %.2fGB\n", force_useful_volume);
    printf("\tCycles/SIMD iteration: %.4f\n", timer[FORCE] * param->proc_freq * 1e9 / stats->force_iters);

    #ifdef USE_REFERENCE_VERSION
    const double atoms_eff = (double)stats->atoms_within_cutoff / (double)(stats->atoms_within_cutoff + stats->atoms_outside_cutoff) * 100.0;
    printf("\tAtoms within/outside cutoff radius: %lld/%lld (%.2f%%)\n", stats->atoms_within_cutoff, stats->atoms_outside_cutoff, atoms_eff);
    const double clusters_eff = (double)stats->clusters_within_cutoff / (double)(stats->clusters_within_cutoff + stats->clusters_outside_cutoff) * 100.0;
    printf("\tClusters within/outside cutoff radius: %lld/%lld (%.2f%%)\n", stats->clusters_within_cutoff, stats->clusters_outside_cutoff, clusters_eff);
    #endif

#endif
}
