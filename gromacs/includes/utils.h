/*
 * Temporal functions for debugging, remove before proceeding with pull request
 */

#ifndef MD_BENCH_UTILS_H
#define MD_BENCH_UTILS_H

#include <atom.h>

#ifdef USE_SUPER_CLUSTERS
void verifyClusters(Atom *atom);
void verifyLayout(Atom *atom);
void checkAlignment(Atom *atom);
void showSuperclusters(Atom *atom);
#endif //USE_SUPER_CLUSTERS

#endif //MD_BENCH_UTILS_H
