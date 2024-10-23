/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include "parameter.h"
#include <force.h>
#include <stdlib.h>

ComputeForceFunction computeForce;

void initForce(Parameter* param)
{
    switch (param->force_field) {
    case FF_EAM:
        computeForce = computeForceEam;
        break;
    case FF_LJ:
#ifdef CUDA_TARGET
        computeForce = computeForceLJCUDA;
#else
        if (param->half_neigh) {
            computeForce = computeForceLJHalfNeigh;
        } else {
            computeForce = computeForceLJFullNeigh;
        }
#endif
        break;
    default:
        fprintf(stderr, "Error: Unknown force field!\n");
        exit(EXIT_FAILURE);
    }
}
