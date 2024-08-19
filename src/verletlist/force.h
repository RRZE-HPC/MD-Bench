/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <atom.h>
#include <eam.h>
#include <neighbor.h>
#include <parameter.h>
#include <stats.h>


#ifndef __FORCE_H_
#define __FORCE_H_

typedef double (*ComputeForceFunction)(Parameter*, Atom*, Neighbor*, Stats*);
extern ComputeForceFunction computeForce;

enum forcetype { FF_LJ = 0, FF_EAM };

extern void initForce(Parameter*);
extern double computeForceLJHalfNeigh(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceLJFullNeigh(Parameter*, Atom*, Neighbor*, Stats*);
extern double computeForceEam(Parameter*, Atom*, Neighbor*, Stats*);

#ifdef CUDA_TARGET
extern double computeForceLJFullNeighCUDA(Parameter*, Atom*, Neighbor*, Stats*);
#define KERNEL_NAME "CUDA"
#else
#ifdef USE_SIMD_KERNEL
#define KERNEL_NAME "SIMD"
#else
#define KERNEL_NAME "PLAIN"
#endif
#endif

#endif // __FORCE_H_
