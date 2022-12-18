/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <atom.h>
#include <parameter.h>

#ifndef __NEIGHBOR_H_
#define __NEIGHBOR_H_
typedef struct {
    int every;
    int ncalls;
    int* neighbors;
    int maxneighs;
    int* numneigh;
    int half_neigh;
} Neighbor;

extern void initNeighbor(Neighbor*, Parameter*);
extern void setupNeighbor(Parameter*, Atom*);
extern void binatoms(Atom*);
extern void buildNeighbor(Atom*, Neighbor*);
extern void pruneNeighbor(Parameter*, Atom*, Neighbor*);
extern void sortAtom(Atom*);
extern void buildClusters(Atom*);
extern void buildClustersGPU(Atom*);
extern void defineJClusters(Atom*);
extern void binClusters(Atom*);
extern void updateSingleAtoms(Atom*);
#endif
