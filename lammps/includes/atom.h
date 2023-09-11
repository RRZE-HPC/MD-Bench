/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <parameter.h>
#include <comm.h>

#ifndef __ATOM_H_
#define __ATOM_H_

#ifdef CUDA_TARGET
#   define KERNEL_NAME                  "CUDA"
#   define computeForceLJFullNeigh      computeForceLJFullNeigh_cuda
#   define initialIntegrate             initialIntegrate_cuda
#   define finalIntegrate               finalIntegrate_cuda
#   define buildNeighbor                buildNeighbor_cuda
#   define updatePbc                    updatePbc_cuda
#   define updateAtomsPbc               updateAtomsPbc_cuda
#else
#   ifdef USE_SIMD_KERNEL
#       define KERNEL_NAME              "SIMD"
#       define computeForceLJFullNeigh  computeForceLJFullNeigh_simd
#   else
#       define KERNEL_NAME              "plain-C"
#       define computeForceLJFullNeigh  computeForceLJFullNeigh_plain_c
#   endif
#   define initialIntegrate             initialIntegrate_cpu
#   define finalIntegrate               finalIntegrate_cpu
#   define buildNeighbor                buildNeighbor_cpu
#   define updatePbc                    updatePbc_cpu
#   define updateAtomsPbc               updateAtomsPbc_cpu
#endif

typedef struct {
  int xprd, yprd, zprd;           //Domain Dimensions
  MD_FLOAT lo[3];               //smallest coordinate of my subdomain
  MD_FLOAT hi[3];               //Highest coordinate of my subdomain
  MD_FLOAT len[3];              //lenght subdomain in each dimmension
} Box;

typedef struct {
    MD_FLOAT *x, *y, *z;
    MD_FLOAT *vx, *vy, *vz;
    MD_FLOAT *fx, *fy, *fz;
    int *border_map;
    int *type;
    MD_FLOAT *epsilon;
    MD_FLOAT *sigma6;
    MD_FLOAT *cutforcesq;
    MD_FLOAT *cutneighsq;
} DeviceAtom;

typedef struct {
    int Natoms, Nlocal, Nghost, Nmax;
    MD_FLOAT *x, *y, *z;
    MD_FLOAT *vx, *vy, *vz;
    MD_FLOAT *fx, *fy, *fz;
    int *border_map;
    int *type;
    int ntypes;
    MD_FLOAT *epsilon;
    MD_FLOAT *sigma6;
    MD_FLOAT *cutforcesq;
    MD_FLOAT *cutneighsq;
    //TODO: insert the id number
    //MD_FLOAT *Atom_id;

    // DEM
    MD_FLOAT *radius;
    MD_FLOAT *av;
    MD_FLOAT *r;

    // Device data
    DeviceAtom d_atom;
     
    //Info Subdomain
    Box mybox;                //spatial representation of my processor box
} Atom;

extern void initAtom(Atom*);
extern void createAtom(Grid*, Atom*, Parameter*);
extern int readAtom(Grid*, Atom*, Parameter*);
extern int readAtom_pdb(Grid*, Atom*, Parameter*);
extern int readAtom_gro(Grid*, Atom*, Parameter*);
extern int readAtom_dmp(Grid*, Atom*, Parameter*);
extern int readAtom_in(Grid*, Atom*, Parameter*);
extern void growAtom(Atom*);
extern int packBorder(int, MD_FLOAT* , int* );
extern int unpackBorder(Atom*, int, MD_FLOAT*);
extern void packReverse(Atom* atom, int n, int first, MD_FLOAT* buf);
extern void unpackReverse(Atom*, int, int*, MD_FLOAT*);
extern int packExchange(Atom*, int, MD_FLOAT*);
extern int unpackExchange(Atom*, int, MD_FLOAT*);
extern void pbc(Atom*);
extern void copy(Atom*, int, int);

#ifdef AOS
#   define POS_DATA_LAYOUT     "AoS"
#   define atom_x(i)           atom->x[(i) * 3 + 0]
#   define atom_y(i)           atom->x[(i) * 3 + 1]
#   define atom_z(i)           atom->x[(i) * 3 + 2]
#   define atom_vx(i)          atom->vx[(i) * 3 + 0]
#   define atom_vy(i)          atom->vx[(i) * 3 + 1]
#   define atom_vz(i)          atom->vx[(i) * 3 + 2]
#   define atom_fx(i)          atom->fx[(i) * 3 + 0]
#   define atom_fy(i)          atom->fx[(i) * 3 + 1]
#   define atom_fz(i)          atom->fx[(i) * 3 + 2]
#else
#   define POS_DATA_LAYOUT     "SoA"
#   define atom_x(i)           atom->x[i]
#   define atom_y(i)           atom->y[i]
#   define atom_z(i)           atom->z[i]
#   define atom_vx(i)          atom->vx[i]
#   define atom_vy(i)          atom->vy[i]
#   define atom_vz(i)          atom->vz[i]
#   define atom_fx(i)          atom->fx[i]
#   define atom_fy(i)          atom->fy[i]
#   define atom_fz(i)          atom->fz[i]
#endif

#   define buf_x(i)  buf[3*(i)] 
#   define buf_y(i)  buf[3*(i)+1]
#   define buf_z(i)  buf[3*(i)+2]

#endif
