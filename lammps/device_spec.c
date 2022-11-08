/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <device.h>

#ifdef CUDA_TARGET

void initDevice(Atom *atom, Neighbor *neighbor) {
    DeviceAtom *d_atom = &(atom->d_atom);
    DeviceNeighbor *d_neighbor = &(neighbor->d_neighbor);

    d_atom->epsilon         =   (MD_FLOAT *) allocateGPU(sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    d_atom->sigma6          =   (MD_FLOAT *) allocateGPU(sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    d_atom->cutforcesq      =   (MD_FLOAT *) allocateGPU(sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    d_neighbor->neighbors   =   (int *) allocateGPU(sizeof(int) * atom->Nmax * neighbor->maxneighs);
    d_neighbor->numneigh    =   (int *) allocateGPU(sizeof(int) * atom->Nmax);

    memcpyToGPU(d_atom->x,              atom->x,          sizeof(MD_FLOAT) * atom->Nmax * 3);
    memcpyToGPU(d_atom->vx,             atom->vx,         sizeof(MD_FLOAT) * atom->Nmax * 3);
    memcpyToGPU(d_atom->sigma6,         atom->sigma6,     sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    memcpyToGPU(d_atom->epsilon,        atom->epsilon,    sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    memcpyToGPU(d_atom->cutforcesq,     atom->cutforcesq, sizeof(MD_FLOAT) * atom->ntypes * atom->ntypes);
    memcpyToGPU(d_atom->type,           atom->type,       sizeof(int) * atom->Nmax);
}

#endif
