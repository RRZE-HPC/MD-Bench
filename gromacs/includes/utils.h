/*
 * Temporal functions for debugging, remove before proceeding with pull request
 */

#ifndef MD_BENCH_UTILS_H
#define MD_BENCH_UTILS_H

#include <atom.h>
#include <neighbor.h>

#ifdef USE_SUPER_CLUSTERS
void verifyClusters(Atom *atom);
void verifyLayout(Atom *atom);
void checkAlignment(Atom *atom);
void showSuperclusters(Atom *atom);
void printNeighs(Atom *atom, Neighbor *neighbor);
#endif //USE_SUPER_CLUSTERS

#endif //MD_BENCH_UTILS_H
