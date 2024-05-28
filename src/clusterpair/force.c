/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <force.h>
#include <parameter.h>
#include <stdlib.h>

ComputeForceFunction computeForce;

void initForce(Parameter* param)
{
    switch (param->force_field) {
    case FF_EAM:
        computeForce = computeForceEam;
        break;
    case FF_LJ:
        if (param->half_neigh) {
            computeForce = computeForceLJ4xnHalfNeigh;
        } else {
#ifdef CUDA_TARGET
            computeForce = computeForceLJFullNeighCUDA;
#else
// Simd2xNN (here used for single-precision)
#if VECTOR_WIDTH > CLUSTER_M * 2
#define KERNEL_NAME    "Simd2xNN"
#define CLUSTER_N      (VECTOR_WIDTH / 2)
#define UNROLL_I       4
#define UNROLL_J       2
#define computeForceLJ computeForceLJ_2xnn
            computeForce = computeForceLJ2xnnFullNeigh;
#else
// Simd4xN
#define KERNEL_NAME "Simd4xN"
#define CLUSTER_N   VECTOR_WIDTH
#define UNROLL_I    4
#define UNROLL_J    1
            computeForce = computeForceLJ4xnFullNeigh;
#endif
#endif
        }
    }
}
