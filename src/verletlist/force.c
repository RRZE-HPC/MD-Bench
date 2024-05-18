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
    case FF_DEM:
        if (param->half_neigh) {
            fprintf(stderr, "Error: DEM cannot use half neighbor-lists!\n");
            exit(EXIT_FAILURE);
        }
        computeForce = computeForceDemFullNeigh;
        break;
    case FF_LJ:
        if (param->half_neigh) {
            computeForce = computeForceLJHalfNeigh;
        } else {
#ifdef CUDA_TARGET
            computeForce = computeForceLJFullNeighCUDA;
#else
            computeForce = computeForceLJFullNeigh;
#endif
        }
    }
}
