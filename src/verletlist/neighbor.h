/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <atom.h>
#include <parameter.h>

#ifndef __NEIGHBOR_H_
#define __NEIGHBOR_H_

typedef struct {
    int* neighbors;
    int* numneigh;
} DeviceNeighbor;

typedef struct {
    int every;
    int ncalls;
    int maxneighs;
    int half_neigh;
    int* neighbors;
    int* numneigh;

    // Device data
    DeviceNeighbor d_neighbor;
} Neighbor;

typedef struct {
    MD_FLOAT xprd;
    MD_FLOAT yprd;
    MD_FLOAT zprd;
    MD_FLOAT bininvx;
    MD_FLOAT bininvy;
    MD_FLOAT bininvz;
    int mbinxlo;
    int mbinylo;
    int mbinzlo;
    int nbinx;
    int nbiny;
    int nbinz;
    int mbinx;
    int mbiny;
    int mbinz;
} Neighbor_params;

typedef struct {
    int* bincount;
    int* bins;
    int mbins;
    int atoms_per_bin;
} Binning;

typedef void (*BuildNeighborFunction)(Atom*, Neighbor*);
extern BuildNeighborFunction buildNeighbor;

extern void initNeighbor(Neighbor*, Parameter*);
extern void setupNeighbor(Parameter*);
extern void binatoms(Atom*);
extern void sortAtom(Atom*);
extern void buildNeighborCPU(Atom*, Neighbor*);
#ifdef CUDA_TARGET
extern void buildNeighborCUDA(Atom*, Neighbor*);
#endif
#endif //__NEIGHBOR_H_
