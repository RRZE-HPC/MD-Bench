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
    int *neighbors;
    int *numneigh;
} DeviceNeighbor;

typedef struct {
    int every;
    int ncalls;
    int maxneighs;
    int half_neigh;
    int half_stencil;
    int *neighbors;
    int *numneigh;
    //MPI
    int Nshell;         //# of atoms in listShell
    int *numNeighShell; //# of neighs for each atom in listShell
    int *neighshell;    //list of neighs for each atom in listShell
    int *listshell;     //Atoms to compute the force
    // Device data
    DeviceNeighbor d_neighbor;
} Neighbor;

typedef struct {
    MD_FLOAT xprd; MD_FLOAT yprd; MD_FLOAT zprd;
    MD_FLOAT bininvx; MD_FLOAT bininvy; MD_FLOAT bininvz;
    int mbinxlo; int mbinylo; int mbinzlo;
    int nbinx; int nbiny; int nbinz;
    int mbinx; int mbiny; int mbinz;
} Neighbor_params;

typedef struct {
    int* bincount;
    int* bins;
    int mbins;
    int atoms_per_bin;
} Binning;

extern void initNeighbor(Neighbor*, Parameter*);
extern void setupNeighbor(Parameter*);
extern void binatoms(Atom*);
extern void buildNeighbor_cpu(Atom*, Neighbor*);
extern void sortAtom(Atom*);

#ifdef CUDA_TARGET
extern void buildNeighbor_cuda(Atom*, Neighbor*);
#endif

#endif
