/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <parameter.h>
#include <box.h>

#ifndef __ATOM_H_
#define __ATOM_H_

#define DELTA 20000

#define CI_SCALAR_BASE_INDEX(a) (CI_BASE_INDEX(a, 1))
#define CI_VECTOR_BASE_INDEX(a) (CI_BASE_INDEX(a, 3))
#define CJ_SCALAR_BASE_INDEX(a) (CJ_BASE_INDEX(a, 1))
#define CJ_VECTOR_BASE_INDEX(a) (CJ_BASE_INDEX(a, 3))

typedef struct {
    int natoms;
    MD_FLOAT bbminx, bbmaxx;
    MD_FLOAT bbminy, bbmaxy;
    MD_FLOAT bbminz, bbmaxz;
} Cluster;

typedef struct {
    int Natoms, Nlocal, Nghost, Nmax;
    int Nclusters, Nclusters_local, Nclusters_ghost, Nclusters_max, NmaxGhost,ncj;
    MD_FLOAT *x, *y, *z;
    MD_FLOAT *vx, *vy, *vz;
    int* border_map;
    int* type;
    int ntypes;
    MD_FLOAT* epsilon;
    MD_FLOAT* sigma6;
    MD_FLOAT* cutforcesq;
    MD_FLOAT* cutneighsq;
    //track the movement of a particle along boundaries
    int *PBCx, *PBCy, *PBCz;
    // Data in cluster format
    MD_FLOAT* cl_x;
    MD_FLOAT* cl_v;
    MD_FLOAT* cl_f;
    int* cl_type;
    Cluster *iclusters, *jclusters;
    int* icluster_bin;
    int dummy_cj;
    MD_UINT* exclusion_filter;
    MD_FLOAT* diagonal_4xn_j_minus_i;
    MD_FLOAT* diagonal_2xnn_j_minus_i;
    unsigned int masks_2xnn_hn[8];
    unsigned int masks_2xnn_fn[8];
    unsigned int masks_4xn_hn[16];
    unsigned int masks_4xn_fn[16];
    //Info Subdomain
    Box mybox;   
} Atom;

extern void initAtom(Atom*);
extern void initMasks(Atom*);
extern void createAtom(Atom*, Parameter*);
extern int readAtom(Atom*, Parameter*);
extern int readAtomPdb(Atom*, Parameter*);
extern int readAtomGro(Atom*, Parameter*);
extern int readAtomDmp(Atom*, Parameter*);
extern void growAtom(Atom*);
extern void growClusters(Atom*);

int  packGhost(Atom*, int, MD_FLOAT* , int*);
int  unpackGhost(Atom*, int, MD_FLOAT*);
int  packExchange(Atom*, int, MD_FLOAT*);
int  unpackExchange(Atom*, int, MD_FLOAT*);
void packForward(Atom*, int, int*, MD_FLOAT*, int*); 
void unpackForward(Atom*, int, int, MD_FLOAT*);
void packReverse(Atom* , int , int , MD_FLOAT*);
void unpackReverse(Atom*, int, int*, MD_FLOAT*);
void pbc(Atom*);
void copy(Atom*, int, int);


#ifdef AOS
#define POS_DATA_LAYOUT "AoS"
#define atom_x(i)       atom->x[(i)*3 + 0]
#define atom_y(i)       atom->x[(i)*3 + 1]
#define atom_z(i)       atom->x[(i)*3 + 2]
/*
#   define atom_vx(i)          atom->vx[(i) * 3 + 0]
#   define atom_vy(i)          atom->vx[(i) * 3 + 1]
#   define atom_vz(i)          atom->vx[(i) * 3 + 2]
#   define atom_fx(i)          atom->fx[(i) * 3 + 0]
#   define atom_fy(i)          atom->fx[(i) * 3 + 1]
#   define atom_fz(i)          atom->fx[(i) * 3 + 2]
*/
#else
#define POS_DATA_LAYOUT "SoA"
#define atom_x(i)       atom->x[i]
#define atom_y(i)       atom->y[i]
#define atom_z(i)       atom->z[i]
#endif

// TODO: allow to switch velocites and forces to AoS
#define atom_vx(i) atom->vx[i]
#define atom_vy(i) atom->vy[i]
#define atom_vz(i) atom->vz[i]
#define atom_fx(i) atom->fx[i]
#define atom_fy(i) atom->fy[i]
#define atom_fz(i) atom->fz[i]

#endif
