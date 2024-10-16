/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdbool.h>

#include <atom.h>
#include <force.h>
#include <integrate.h>
#include <parameter.h>
#include <simd.h>
#include <util.h>

#ifdef CUDA_TARGET
IntegrationFunction initialIntegrate = initialIntegrateCUDA;
IntegrationFunction finalIntegrate   = finalIntegrateCUDA;
#else
IntegrationFunction initialIntegrate = initialIntegrateCPU;
IntegrationFunction finalIntegrate   = finalIntegrateCPU;
#endif

void initialIntegrateCPU(Parameter* param, Atom* atom)
{
    DEBUG_MESSAGE("cpuInitialIntegrate start\n");
    for (int ci = 0; ci < atom->Nclusters_local; ci++) {
        int ciVecBase = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ciX = &atom->cl_x[ciVecBase];
        MD_FLOAT* ciV = &atom->cl_v[ciVecBase];
        MD_FLOAT* ciF = &atom->cl_f[ciVecBase];

        for (int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
            ciV[CL_X_OFFSET + cii] += param->dtforce * ciF[CL_X_OFFSET + cii];
            ciV[CL_Y_OFFSET + cii] += param->dtforce * ciF[CL_Y_OFFSET + cii];
            ciV[CL_Z_OFFSET + cii] += param->dtforce * ciF[CL_Z_OFFSET + cii];
            ciX[CL_X_OFFSET + cii] += param->dt * ciV[CL_X_OFFSET + cii];
            ciX[CL_Y_OFFSET + cii] += param->dt * ciV[CL_Y_OFFSET + cii];
            ciX[CL_Z_OFFSET + cii] += param->dt * ciV[CL_Z_OFFSET + cii];
        }
    }

    DEBUG_MESSAGE("cpuInitialIntegrate end\n");
}

void finalIntegrateCPU(Parameter* param, Atom* atom)
{
    DEBUG_MESSAGE("cpuFinalIntegrate start\n");

    for (int ci = 0; ci < atom->Nclusters_local; ci++) {
        int ciVecBase = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ciV = &atom->cl_v[ciVecBase];
        MD_FLOAT* ciF = &atom->cl_f[ciVecBase];

        for (int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
            ciV[CL_X_OFFSET + cii] += param->dtforce * ciF[CL_X_OFFSET + cii];
            ciV[CL_Y_OFFSET + cii] += param->dtforce * ciF[CL_Y_OFFSET + cii];
            ciV[CL_Z_OFFSET + cii] += param->dtforce * ciF[CL_Z_OFFSET + cii];
        }
    }

    DEBUG_MESSAGE("cpuFinalIntegrate end\n");
}

/*
void initialIntegrateCPU(Parameter *param, Atom *atom) {

    DEBUG_MESSAGE("cpuInitialIntegrate start\n");
    for(int ci = 0; ci < atom->Nclusters_local; ci+=2) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT *ci_x = &atom->cl_x[ci_vec_base];
        MD_FLOAT *ci_v = &atom->cl_v[ci_vec_base];
        MD_FLOAT *ci_f = &atom->cl_f[ci_vec_base];

        MD_SIMD_FLOAT dtforce = simd_broadcast(param->dtforce);
        MD_SIMD_FLOAT dt = simd_broadcast(param->dt);

        MD_SIMD_FLOAT vx_vector = simd_fma(simd_load(&ci_f[CL_X_OFFSET]), dtforce,
simd_load(&ci_v[CL_X_OFFSET])); MD_SIMD_FLOAT vy_vector =
simd_fma(simd_load(&ci_f[CL_Y_OFFSET]), dtforce, simd_load(&ci_v[CL_Y_OFFSET]));
        MD_SIMD_FLOAT vz_vector = simd_fma(simd_load(&ci_f[CL_Z_OFFSET]), dtforce,
simd_load(&ci_v[CL_Z_OFFSET])); MD_SIMD_FLOAT x_vector = simd_fma(vx_vector, dt,
simd_load(&ci_x[CL_X_OFFSET])); MD_SIMD_FLOAT y_vector = simd_fma(vy_vector, dt,
simd_load(&ci_x[CL_Y_OFFSET])); MD_SIMD_FLOAT z_vector = simd_fma(vz_vector, dt,
simd_load(&ci_x[CL_Z_OFFSET]));

        simd_store(&ci_v[CL_X_OFFSET], vx_vector);
        simd_store(&ci_v[CL_Y_OFFSET], vy_vector);
        simd_store(&ci_v[CL_Z_OFFSET], vz_vector);
        simd_store(&ci_x[CL_X_OFFSET], x_vector);
        simd_store(&ci_x[CL_Y_OFFSET], y_vector);
        simd_store(&ci_x[CL_Z_OFFSET], z_vector);
    }

    DEBUG_MESSAGE("cpuInitialIntegrate end\n");
}

void  finalIntegrateCPU(Parameter *param, Atom *atom) {

    DEBUG_MESSAGE("cpuFinalIntegrate start\n");
    for(int ci = 0; ci < atom->Nclusters_local; ci+=2) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT *ci_v = &atom->cl_v[ci_vec_base];
        MD_FLOAT *ci_f = &atom->cl_f[ci_vec_base];

        MD_SIMD_FLOAT dtforce = simd_broadcast(param->dtforce);
        MD_SIMD_FLOAT vx_vector = simd_fma(simd_load(&ci_f[CL_X_OFFSET]), dtforce,
simd_load(&ci_v[CL_X_OFFSET])); MD_SIMD_FLOAT vy_vector =
simd_fma(simd_load(&ci_f[CL_Y_OFFSET]), dtforce, simd_load(&ci_v[CL_Y_OFFSET]));
        MD_SIMD_FLOAT vz_vector = simd_fma(simd_load(&ci_f[CL_Z_OFFSET]), dtforce,
simd_load(&ci_v[CL_Z_OFFSET])); simd_store(&ci_v[CL_X_OFFSET], vx_vector);
        simd_store(&ci_v[CL_Y_OFFSET], vy_vector);
        simd_store(&ci_v[CL_Z_OFFSET], vz_vector);
    }

    DEBUG_MESSAGE("cpuFinalIntegrate end\n");
}
*/