/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *   Copyright (c) 2021 RRZE, University Erlangen-Nuremberg
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
#include <parameter.h>

#ifndef __ATOM_H_
#define __ATOM_H_

#define DELTA 20000

#define CLUSTER_DIM_M       4
#define CLUSTER_DIM_N       VECTOR_WIDTH

typedef struct {
    int bin;
    int natoms;
    int type[CLUSTER_DIM_M];
    MD_FLOAT bbminx, bbmaxx;
    MD_FLOAT bbminy, bbmaxy;
    MD_FLOAT bbminz, bbmaxz;
} Cluster;

typedef struct {
    int Natoms, Nlocal, Nghost, Nmax;
    int Nclusters, Nclusters_local, Nclusters_ghost, Nclusters_max;
    MD_FLOAT *x, *y, *z;
    MD_FLOAT *vx, *vy, *vz;
    MD_FLOAT *cl_x;
    MD_FLOAT *cl_v;
    MD_FLOAT *cl_f;
    int *border_map;
    int *type;
    int ntypes;
    MD_FLOAT *epsilon;
    MD_FLOAT *sigma6;
    MD_FLOAT *cutforcesq;
    MD_FLOAT *cutneighsq;
    Cluster *clusters;
    int *PBCx, *PBCy, *PBCz;
} Atom;

extern void initAtom(Atom*);
extern void createAtom(Atom*, Parameter*);
extern int readAtom(Atom*, Parameter*);
extern int readAtom_pdb(Atom*, Parameter*);
extern int readAtom_gro(Atom*, Parameter*);
extern int readAtom_dmp(Atom*, Parameter*);
extern void growAtom(Atom*);
extern void growClusters(Atom*);

#define cluster_pos_ptr(ci)       &(atom->cl_x[(ci) * CLUSTER_DIM_M * 3])
#define cluster_velocity_ptr(ci)  &(atom->cl_v[(ci) * CLUSTER_DIM_M * 3])
#define cluster_force_ptr(ci)     &(atom->cl_f[(ci) * CLUSTER_DIM_M * 3])

#ifdef AOS
#define POS_DATA_LAYOUT     "AoS"
#define atom_x(i)           atom->x[(i) * 3 + 0]
#define atom_y(i)           atom->x[(i) * 3 + 1]
#define atom_z(i)           atom->x[(i) * 3 + 2]
#else
#define POS_DATA_LAYOUT     "SoA"
#define atom_x(i)           atom->x[i]
#define atom_y(i)           atom->y[i]
#define atom_z(i)           atom->z[i]
#endif

#ifdef CLUSTER_AOS
#define cluster_x(cptr, i)  cptr[(i) * 3 + 0]
#define cluster_y(cptr, i)  cptr[(i) * 3 + 1]
#define cluster_z(cptr, i)  cptr[(i) * 3 + 2]
#else
#define cluster_x(cptr, i)  cptr[0 * CLUSTER_DIM_M + (i)]
#define cluster_y(cptr, i)  cptr[1 * CLUSTER_DIM_M + (i)]
#define cluster_z(cptr, i)  cptr[2 * CLUSTER_DIM_M + (i)]
#endif

#endif
