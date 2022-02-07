#include <stdio.h>

#include <atom.h>
#include <parameter.h>
#include <stats.h>
#include <timers.h>

void initStats(Stats *s) {
    s->calculated_forces = 0;
    s->num_neighs = 0;
    s->force_iters = 0;
}

void displayStatistics(Atom *atom, Parameter *param, Stats *stats, double *timer) {
#ifdef COMPUTE_STATS
    const int MxN = CLUSTER_DIM_M * CLUSTER_DIM_N;
    double force_useful_volume = 1e-9 * ( (double)(atom->Nlocal * (param->ntimes + 1)) * (sizeof(MD_FLOAT) * 6 + sizeof(int)) +
                                          (double)(stats->num_neighs) * (sizeof(MD_FLOAT) * 3 + sizeof(int)) );
    double avg_neigh_atom = (stats->num_neighs * CLUSTER_DIM_N) / (double)(atom->Nlocal * (param->ntimes + 1));
    double avg_neigh_cluster = (double)(stats->num_neighs) / (double)(stats->calculated_forces);
    double avg_simd = stats->force_iters / (double)(atom->Nlocal * (param->ntimes + 1));
#ifdef EXPLICIT_TYPES
    force_useful_volume += 1e-9 * (double)((atom->Nlocal * (param->ntimes + 1)) + stats->num_neighs) * sizeof(int);
#endif
    printf("Statistics:\n");
    printf("\tVector width: %d, Processor frequency: %.4f GHz\n", VECTOR_WIDTH, param->proc_freq);
    printf("\tAverage neighbors per atom: %.4f\n", avg_neigh_atom);
    printf("\tAverage neighbors per cluster: %.4f\n", avg_neigh_cluster);
    printf("\tAverage SIMD iterations per atom: %.4f\n", avg_simd);
    printf("\tTotal number of computed pair interactions: %lld\n", stats->num_neighs * MxN);
    printf("\tTotal number of SIMD iterations: %lld\n", stats->force_iters);
    printf("\tUseful read data volume for force computation: %.2fGB\n", force_useful_volume);
    printf("\tCycles/SIMD iteration: %.4f\n", timer[FORCE] * param->proc_freq * 1e9 / stats->force_iters);
#endif
}
