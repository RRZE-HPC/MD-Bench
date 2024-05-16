/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdbool.h>
//---
#include <atom.h>
#include <parameter.h>
#include <util.h>

void cpuInitialIntegrate(Parameter* param, Atom* atom)
{
    DEBUG_MESSAGE("cpuInitialIntegrate start\n");

    for (int ci = 0; ci < atom->Nclusters_local; ci++) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ci_x  = &atom->cl_x[ci_vec_base];
        MD_FLOAT* ci_v  = &atom->cl_v[ci_vec_base];
        MD_FLOAT* ci_f  = &atom->cl_f[ci_vec_base];

        for (int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
            ci_v[CL_X_OFFSET + cii] += param->dtforce * ci_f[CL_X_OFFSET + cii];
            ci_v[CL_Y_OFFSET + cii] += param->dtforce * ci_f[CL_Y_OFFSET + cii];
            ci_v[CL_Z_OFFSET + cii] += param->dtforce * ci_f[CL_Z_OFFSET + cii];
            ci_x[CL_X_OFFSET + cii] += param->dt * ci_v[CL_X_OFFSET + cii];
            ci_x[CL_Y_OFFSET + cii] += param->dt * ci_v[CL_Y_OFFSET + cii];
            ci_x[CL_Z_OFFSET + cii] += param->dt * ci_v[CL_Z_OFFSET + cii];
        }
    }

    DEBUG_MESSAGE("cpuInitialIntegrate end\n");
}

void cpuFinalIntegrate(Parameter* param, Atom* atom)
{
    DEBUG_MESSAGE("cpuFinalIntegrate start\n");

    for (int ci = 0; ci < atom->Nclusters_local; ci++) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ci_v  = &atom->cl_v[ci_vec_base];
        MD_FLOAT* ci_f  = &atom->cl_f[ci_vec_base];

        for (int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
            ci_v[CL_X_OFFSET + cii] += param->dtforce * ci_f[CL_X_OFFSET + cii];
            ci_v[CL_Y_OFFSET + cii] += param->dtforce * ci_f[CL_Y_OFFSET + cii];
            ci_v[CL_Z_OFFSET + cii] += param->dtforce * ci_f[CL_Z_OFFSET + cii];
        }
    }

    DEBUG_MESSAGE("cpuFinalIntegrate end\n");
}

#ifdef CUDA_TARGET
void cudaInitialIntegrate(Parameter*, Atom*);
void cudaFinalIntegrate(Parameter*, Atom*);
#endif
