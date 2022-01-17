#include <stdio.h>

#include <atom.h>
#include <parameter.h>
#include <stats.h>
#include <timers.h>

void initStats(Stats *s) {
    s->total_force_neighs = 0;
    s->total_force_iters = 0;
}

void displayStatistics(Atom *atom, Parameter *param, Stats *stats, double *timer) {
#ifdef COMPUTE_STATS
    double force_useful_volume = 1e-9 * ( (double)(atom->Nlocal * (param->ntimes + 1)) * (sizeof(MD_FLOAT) * 6 + sizeof(int)) +
                                          (double)(stats->total_force_neighs) * (sizeof(MD_FLOAT) * 3 + sizeof(int)) );
    double avg_neigh = stats->total_force_neighs / (double)(atom->Nlocal * (param->ntimes + 1));
    double avg_simd = stats->total_force_iters / (double)(atom->Nlocal * (param->ntimes + 1));
#ifdef EXPLICIT_TYPES
    force_useful_volume += 1e-9 * (double)((atom->Nlocal * (param->ntimes + 1)) + stats->total_force_neighs) * sizeof(int);
#endif
    printf("Statistics:\n");
    printf("\tVector width: %d, Processor frequency: %.4f GHz\n", VECTOR_WIDTH, param->proc_freq);
    printf("\tAverage neighbors per atom: %.4f\n", avg_neigh);
    printf("\tAverage SIMD iterations per atom: %.4f\n", avg_simd);
    printf("\tTotal number of computed pair interactions: %lld\n", stats->total_force_neighs);
    printf("\tTotal number of SIMD iterations: %lld\n", stats->total_force_iters);
    printf("\tUseful read data volume for force computation: %.2fGB\n", force_useful_volume);
    printf("\tCycles/SIMD iteration: %.4f\n", timer[FORCE] * param->proc_freq * 1e9 / stats->total_force_iters);
#endif
}
