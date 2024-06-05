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
#ifdef USE_REFERENCE_VERSION
        computeForce = computeForceLJRef;
#else
        if (param->half_neigh) {
            computeForce = computeForceLJ4xnHalfNeigh;
        } else {
#ifdef CUDA_TARGET
            computeForce = computeForceLJCUDA;
#else
            // Simd2xNN (here used for single-precision)
#if VECTOR_WIDTH > CLUSTER_M * 2
            computeForce = computeForceLJ2xnnFullNeigh;
#else // Simd4xN
            computeForce = computeForceLJ4xnFullNeigh;
#endif
#endif
        }
#endif
    }
}
