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
// Interaction masks from GROMACS, things to remember (maybe these confused just me):
//   1. These are not "exclusion" masks as the name suggests in GROMACS, but rather
//      interaction masks (1 = interaction, 0 = no interaction)
//   2. These are inverted (maybe because that is how you use in AVX2/AVX512 masking),
//      so read them from right to left (least significant to most significant bit)
// All interaction mask is the same for all kernels
#define NBNXN_INTERACTION_MASK_ALL 0xffffffffU
// 4x4 kernel diagonal mask
#define NBNXN_INTERACTION_MASK_DIAG 0x08ceU
// 4x2 kernel diagonal masks
#define NBNXN_INTERACTION_MASK_DIAG_J2_0 0x0002U
#define NBNXN_INTERACTION_MASK_DIAG_J2_1 0x002fU
// 4x8 kernel diagonal masks
#define NBNXN_INTERACTION_MASK_DIAG_J8_0 0xf0f8fcfeU
#define NBNXN_INTERACTION_MASK_DIAG_J8_1 0x0080c0e0U

typedef struct {
    int every;
    int ncalls;
    int maxneighs;
    int* numneigh;
    int* numneigh_masked;
    int half_neigh;
    int* neighbors;
    unsigned int* neighbors_imask;
} Neighbor;

extern void initNeighbor(Neighbor*, Parameter*);
extern void setupNeighbor(Parameter*, Atom*);
extern void binatoms(Atom*);
extern void buildNeighbor(Atom*, Neighbor*);
extern void pruneNeighbor(Parameter*, Atom*, Neighbor*);
extern void sortAtom(Atom*);
extern void buildClusters(Atom*);
extern void defineJClusters(Atom*);
extern void binClusters(Atom*);
extern void updateSingleAtoms(Atom*);
#endif
