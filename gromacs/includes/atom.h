/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <parameter.h>

#ifndef __ATOM_H_
#define __ATOM_H_

#define DELTA 20000

// Nbnxn layouts (as of GROMACS):
// Simd4xN: M=4, N=VECTOR_WIDTH
// Simd2xNN: M=4, N=(VECTOR_WIDTH/2)
// Cuda: M=8, N=VECTOR_WIDTH

#ifdef CUDA_TARGET
#   undef VECTOR_WIDTH
#   define VECTOR_WIDTH             8
#   define KERNEL_NAME              "CUDA"
#   define CLUSTER_M                8
#   define CLUSTER_N                VECTOR_WIDTH
#   define computeForceLJ           computeForceLJ_cuda
#   define initialIntegrate         cudaInitialIntegrate
#   define finalIntegrate           cudaFinalIntegrate
#   define updatePbc                cudaUpdatePbc
#else
#   define CLUSTER_M                4
// Simd2xNN (here used for single-precision)
#   if VECTOR_WIDTH > CLUSTER_M * 2
#       define KERNEL_NAME          "Simd2xNN"
#       define CLUSTER_N            (VECTOR_WIDTH / 2)
#       define computeForceLJ       computeForceLJ_2xnn
// Simd4xN
#   else
#       define KERNEL_NAME          "Simd4xN"
#       define CLUSTER_N            VECTOR_WIDTH
#       define computeForceLJ       computeForceLJ_4xn
#   endif
#   ifdef USE_REFERENCE_VERSION
#       undef KERNEL_NAME
#       undef computeForceLJ
#       define KERNEL_NAME          "Reference"
#       define computeForceLJ       computeForceLJ_ref
#   endif
#   define initialIntegrate         cpuInitialIntegrate
#   define finalIntegrate           cpuFinalIntegrate
#   define updatePbc                cpuUpdatePbc
#endif

#if CLUSTER_M == CLUSTER_N
#   define CJ0_FROM_CI(a)           (a)
#   define CJ1_FROM_CI(a)           (a)
#   define CI_BASE_INDEX(a,b)       ((a) * CLUSTER_N * (b))
#   define CJ_BASE_INDEX(a,b)       ((a) * CLUSTER_N * (b))
#elif CLUSTER_M == CLUSTER_N * 2 // M > N
#   define CJ0_FROM_CI(a)           ((a) << 1)
#   define CJ1_FROM_CI(a)           (((a) << 1) | 0x1)
#   define CI_BASE_INDEX(a,b)       ((a) * CLUSTER_M * (b))
#   define CJ_BASE_INDEX(a,b)       (((a) >> 1) * CLUSTER_M * (b) + ((a) & 0x1) * (CLUSTER_M >> 1))
#elif CLUSTER_M == CLUSTER_N / 2 // M < N
#   define CJ0_FROM_CI(a)           ((a) >> 1)
#   define CJ1_FROM_CI(a)           ((a) >> 1)
#   define CI_BASE_INDEX(a,b)       (((a) >> 1) * CLUSTER_N * (b) + ((a) & 0x1) * (CLUSTER_N >> 1))
#   define CJ_BASE_INDEX(a,b)       ((a) * CLUSTER_N * (b))
#else
#   error "Invalid cluster configuration!"
#endif

#if CLUSTER_N != 2 && CLUSTER_N != 4 && CLUSTER_N != 8
#   error "Cluster N dimension can be only 2, 4 and 8"
#endif

#define CI_SCALAR_BASE_INDEX(a)     (CI_BASE_INDEX(a, 1))
#define CI_VECTOR_BASE_INDEX(a)     (CI_BASE_INDEX(a, 3))
#define CJ_SCALAR_BASE_INDEX(a)     (CJ_BASE_INDEX(a, 1))
#define CJ_VECTOR_BASE_INDEX(a)     (CJ_BASE_INDEX(a, 3))

#if CLUSTER_M >= CLUSTER_N
#   define CL_X_OFFSET              (0 * CLUSTER_M)
#   define CL_Y_OFFSET              (1 * CLUSTER_M)
#   define CL_Z_OFFSET              (2 * CLUSTER_M)
#else
#   define CL_X_OFFSET              (0 * CLUSTER_N)
#   define CL_Y_OFFSET              (1 * CLUSTER_N)
#   define CL_Z_OFFSET              (2 * CLUSTER_N)
#endif

typedef struct {
    int natoms;
    MD_FLOAT bbminx, bbmaxx;
    MD_FLOAT bbminy, bbmaxy;
    MD_FLOAT bbminz, bbmaxz;
} Cluster;

typedef struct {
    int Natoms, Nlocal, Nghost, Nmax;
    int Nclusters, Nclusters_local, Nclusters_ghost, Nclusters_max;
    MD_FLOAT *x, *y, *z;
    MD_FLOAT *vx, *vy, *vz;
    int *border_map;
    int *type;
    int ntypes;
    MD_FLOAT *epsilon;
    MD_FLOAT *sigma6;
    MD_FLOAT *cutforcesq;
    MD_FLOAT *cutneighsq;
    int *PBCx, *PBCy, *PBCz;
    // Data in cluster format
    MD_FLOAT *cl_x;
    MD_FLOAT *cl_v;
    MD_FLOAT *cl_f;
    int *cl_type;
    Cluster *iclusters, *jclusters;
    int *icluster_bin;
    int dummy_cj;
} Atom;

extern void initAtom(Atom*);
extern void createAtom(Atom*, Parameter*);
extern int readAtom(Atom*, Parameter*);
extern int readAtom_pdb(Atom*, Parameter*);
extern int readAtom_gro(Atom*, Parameter*);
extern int readAtom_dmp(Atom*, Parameter*);
extern void growAtom(Atom*);
extern void growClusters(Atom*);

#ifdef AOS
#   define POS_DATA_LAYOUT     "AoS"
#   define atom_x(i)           atom->x[(i) * 3 + 0]
#   define atom_y(i)           atom->x[(i) * 3 + 1]
#   define atom_z(i)           atom->x[(i) * 3 + 2]
/*
#   define atom_vx(i)          atom->vx[(i) * 3 + 0]
#   define atom_vy(i)          atom->vx[(i) * 3 + 1]
#   define atom_vz(i)          atom->vx[(i) * 3 + 2]
#   define atom_fx(i)          atom->fx[(i) * 3 + 0]
#   define atom_fy(i)          atom->fx[(i) * 3 + 1]
#   define atom_fz(i)          atom->fx[(i) * 3 + 2]
*/
#else
#   define POS_DATA_LAYOUT     "SoA"
#   define atom_x(i)           atom->x[i]
#   define atom_y(i)           atom->y[i]
#   define atom_z(i)           atom->z[i]
#endif

// TODO: allow to switch velocites and forces to AoS
#   define atom_vx(i)          atom->vx[i]
#   define atom_vy(i)          atom->vy[i]
#   define atom_vz(i)          atom->vz[i]
#   define atom_fx(i)          atom->fx[i]
#   define atom_fy(i)          atom->fy[i]
#   define atom_fz(i)          atom->fz[i]

#endif
