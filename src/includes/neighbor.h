/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *   Copyright (c) 2020 RRZE, University Erlangen-Nuremberg
 *
 *   This file is part of MD-Bench.
 *
 *   MD-Bench is free software: you can redistribute it and/or modify it
 *   under the terms of the GNU Lesser General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   MD-Bench is distributed in the hope that it will be useful, but WITHOUT ANY
 *   WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 *   PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
 *   details.
 *
 *   You should have received a copy of the GNU Lesser General Public License along
 *   with MD-Bench.  If not, see <https://www.gnu.org/licenses/>.
 * =======================================================================================
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
extern void setupNeighbor();
extern void binatoms(Atom*);
extern void buildNeighbor(Atom*, Neighbor*);
extern void sortAtom(Atom*);
extern void binatoms_cuda(Atom*, Binning*, int**, Neighbor_params*, const int);
extern void buildNeighbor_cuda(Atom*, Neighbor*, Atom*, Neighbor*, const int);
#endif
