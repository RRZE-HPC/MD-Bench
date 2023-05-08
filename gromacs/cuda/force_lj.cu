/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
extern "C" {

#include <stdio.h>
//---
#include <cuda.h>
#include <driver_types.h>
//---
#include <likwid-marker.h>
//---
#include <atom.h>
#include <device.h>
#include <neighbor.h>
#include <parameter.h>
#include <stats.h>
#include <timing.h>
#include <util.h>

}

extern "C" {
    MD_FLOAT *cuda_cl_x;
    MD_FLOAT *cuda_cl_v;
    MD_FLOAT *cuda_cl_f;
    int *cuda_neighbors;
    int *cuda_numneigh;
    int *cuda_natoms;
    int *natoms;
    int *ngatoms;
    int *cuda_border_map;
    int *cuda_jclusters_natoms;
    MD_FLOAT *cuda_bbminx, *cuda_bbmaxx;
    MD_FLOAT *cuda_bbminy, *cuda_bbmaxy;
    MD_FLOAT *cuda_bbminz, *cuda_bbmaxz;
    int *cuda_PBCx, *cuda_PBCy, *cuda_PBCz;
    int isReneighboured;

    int *cuda_iclusters;
    int *cuda_nclusters;

    int cuda_max_scl;
    MD_FLOAT *cuda_scl_x;
    MD_FLOAT *cuda_scl_v;
    MD_FLOAT *cuda_scl_f;

    extern void alignDataToSuperclusters(Atom *atom);
    extern void alignDataFromSuperclusters(Atom *atom);
    extern double computeForceLJSup_cuda(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats);
}

extern __global__ void cudaInitialIntegrateSup_warp(MD_FLOAT *cuda_cl_x, MD_FLOAT *cuda_cl_v, MD_FLOAT *cuda_cl_f,
                                                    int *cuda_nclusters,
                                                    int *cuda_natoms,
                                                    int Nsclusters_local, MD_FLOAT dtforce, MD_FLOAT dt);

extern __global__ void cudaFinalIntegrateSup_warp(MD_FLOAT *cuda_cl_v, MD_FLOAT *cuda_cl_f,
                                                  int *cuda_nclusters, int *cuda_natoms,
                                                  int Nsclusters_local, MD_FLOAT dtforce);

extern "C"
void initDevice(Atom *atom, Neighbor *neighbor) {
    cuda_assert("cudaDeviceSetup", cudaDeviceReset());
    cuda_assert("cudaDeviceSetup", cudaSetDevice(0));
    cuda_cl_x               =   (MD_FLOAT *) allocateGPU(atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    cuda_cl_v               =   (MD_FLOAT *) allocateGPU(atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    cuda_cl_f               =   (MD_FLOAT *) allocateGPU(atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    cuda_natoms             =   (int *) allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_jclusters_natoms   =   (int *) allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_border_map         =   (int *) allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_PBCx               =   (int *) allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_PBCy               =   (int *) allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_PBCz               =   (int *) allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_numneigh           =   (int *) allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_neighbors          =   (int *) allocateGPU(atom->Nclusters_max * neighbor->maxneighs * sizeof(int));
    natoms                  =   (int *) malloc(atom->Nclusters_max * sizeof(int));
    ngatoms                 =   (int *) malloc(atom->Nclusters_max * sizeof(int));
    isReneighboured = 1;

#ifdef USE_SUPER_CLUSTERS
    cuda_max_scl            =   atom->Nsclusters_max;
    cuda_iclusters          =   (int *) allocateGPU(atom->Nsclusters_max * SCLUSTER_SIZE * sizeof(int));
    cuda_nclusters          =   (int *) allocateGPU(atom->Nsclusters_max * sizeof(int));

    cuda_scl_x              =   (MD_FLOAT *) allocateGPU(atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));
    cuda_scl_v              =   (MD_FLOAT *) allocateGPU(atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));
    cuda_scl_f              =   (MD_FLOAT *) allocateGPU(atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));

#endif //USE_SUPER_CLUSTERS
}

extern "C"
void copyDataToCUDADevice(Atom *atom) {
    DEBUG_MESSAGE("copyDataToCUDADevice start\r\n");

    memcpyToGPU(cuda_cl_x, atom->cl_x, atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    memcpyToGPU(cuda_cl_v, atom->cl_v, atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    memcpyToGPU(cuda_cl_f, atom->cl_f, atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));

    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        natoms[ci] = atom->iclusters[ci].natoms;
    }

    memcpyToGPU(cuda_natoms, natoms, atom->Nclusters_local * sizeof(int));

    int jfac = MAX(1, CLUSTER_N / CLUSTER_M);
    int ncj = atom->Nclusters_local / jfac;
    for(int cg = 0; cg < atom->Nclusters_ghost; cg++) {
        const int cj = ncj + cg;
        ngatoms[cg] = atom->jclusters[cj].natoms;
    }

    memcpyToGPU(cuda_jclusters_natoms, ngatoms, atom->Nclusters_ghost * sizeof(int));
    memcpyToGPU(cuda_border_map, atom->border_map, atom->Nclusters_ghost * sizeof(int));
    memcpyToGPU(cuda_PBCx, atom->PBCx, atom->Nclusters_ghost * sizeof(int));
    memcpyToGPU(cuda_PBCy, atom->PBCy, atom->Nclusters_ghost * sizeof(int));
    memcpyToGPU(cuda_PBCz, atom->PBCz, atom->Nclusters_ghost * sizeof(int));

#ifdef USE_SUPER_CLUSTERS
    alignDataToSuperclusters(atom);

    if (cuda_max_scl < atom->Nsclusters_max) {
        cuda_assert("cudaDeviceFree", cudaFree(cuda_scl_x));
        cuda_assert("cudaDeviceFree", cudaFree(cuda_scl_v));
        cuda_assert("cudaDeviceFree", cudaFree(cuda_scl_f));
        cuda_max_scl            =   atom->Nsclusters_max;

        cuda_iclusters          =   (int *) allocateGPU(atom->Nsclusters_max * SCLUSTER_SIZE * sizeof(int));
        cuda_nclusters          =   (int *) allocateGPU(atom->Nsclusters_max * sizeof(int));

        cuda_scl_x              =   (MD_FLOAT *) allocateGPU(atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));
        cuda_scl_v              =   (MD_FLOAT *) allocateGPU(atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));
        cuda_scl_f              =   (MD_FLOAT *) allocateGPU(atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));
    }
    memcpyToGPU(cuda_scl_x, atom->scl_x, atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));
    memcpyToGPU(cuda_scl_v, atom->scl_v, atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));
    memcpyToGPU(cuda_scl_f, atom->scl_f, atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));
#endif //USE_SUPER_CLUSTERS

    DEBUG_MESSAGE("copyDataToCUDADevice stop\r\n");

}

extern "C"
void copyDataFromCUDADevice(Atom *atom) {
    DEBUG_MESSAGE("copyDataFromCUDADevice start\r\n");

    memcpyFromGPU(atom->cl_x, cuda_cl_x, atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    memcpyFromGPU(atom->cl_v, cuda_cl_v, atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    memcpyFromGPU(atom->cl_f, cuda_cl_f, atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));

#ifdef USE_SUPER_CLUSTERS
    memcpyFromGPU(atom->scl_x, cuda_scl_x, atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));
    memcpyFromGPU(atom->scl_v, cuda_scl_v, atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));
    memcpyFromGPU(atom->scl_f, cuda_scl_f, atom->Nsclusters_max * SCLUSTER_M * 3 * sizeof(MD_FLOAT));

    alignDataFromSuperclusters(atom);
#endif //USE_SUPER_CLUSTERS

    DEBUG_MESSAGE("copyDataFromCUDADevice stop\r\n");
}

extern "C"
void cudaDeviceFree() {
    cuda_assert("cudaDeviceFree", cudaFree(cuda_cl_x));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_cl_v));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_cl_f));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_numneigh));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_neighbors));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_natoms));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_border_map));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_jclusters_natoms));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_PBCx));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_PBCy));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_PBCz));
    free(natoms);
    free(ngatoms);

#ifdef USE_SUPER_CLUSTERS
    cuda_assert("cudaDeviceFree", cudaFree(cuda_scl_x));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_scl_v));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_scl_f));
#endif //USE_SUPER_CLUSTERS
}

__global__ void cudaInitialIntegrate_warp(MD_FLOAT *cuda_cl_x, MD_FLOAT *cuda_cl_v, MD_FLOAT *cuda_cl_f,
                                         int *cuda_natoms,
                                         int Nclusters_local, MD_FLOAT dtforce, MD_FLOAT dt) {

    unsigned int ci_pos = blockDim.x * blockIdx.x + threadIdx.x;
    if (ci_pos >= Nclusters_local) return;

    int ci_vec_base = CI_VECTOR_BASE_INDEX(ci_pos);
    MD_FLOAT *ci_x = &cuda_cl_x[ci_vec_base];
    MD_FLOAT *ci_v = &cuda_cl_v[ci_vec_base];
    MD_FLOAT *ci_f = &cuda_cl_f[ci_vec_base];

    for (int cii = 0; cii < cuda_natoms[ci_pos]; cii++) {
        ci_v[CL_X_OFFSET + cii] += dtforce * ci_f[CL_X_OFFSET + cii];
        ci_v[CL_Y_OFFSET + cii] += dtforce * ci_f[CL_Y_OFFSET + cii];
        ci_v[CL_Z_OFFSET + cii] += dtforce * ci_f[CL_Z_OFFSET + cii];
        ci_x[CL_X_OFFSET + cii] += dt * ci_v[CL_X_OFFSET + cii];
        ci_x[CL_Y_OFFSET + cii] += dt * ci_v[CL_Y_OFFSET + cii];
        ci_x[CL_Z_OFFSET + cii] += dt * ci_v[CL_Z_OFFSET + cii];
    }
}

__global__ void cudaUpdatePbc_warp(MD_FLOAT *cuda_cl_x, int *cuda_border_map,
                                   int *cuda_jclusters_natoms,
                                   int *cuda_PBCx,
                                   int *cuda_PBCy,
                                   int *cuda_PBCz,
                                   int Nclusters_local,
                                   int Nclusters_ghost,
                                   MD_FLOAT param_xprd,
                                   MD_FLOAT param_yprd,
                                   MD_FLOAT param_zprd) {
    unsigned int cg = blockDim.x * blockIdx.x + threadIdx.x;
    if (cg >= Nclusters_ghost) return;

    int jfac = MAX(1, CLUSTER_N / CLUSTER_M);
    int ncj = Nclusters_local / jfac;
    MD_FLOAT xprd = param_xprd;
    MD_FLOAT yprd = param_yprd;
    MD_FLOAT zprd = param_zprd;

    const int cj = ncj + cg;
    int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
    int bmap_vec_base = CJ_VECTOR_BASE_INDEX(cuda_border_map[cg]);
    MD_FLOAT *cj_x = &cuda_cl_x[cj_vec_base];
    MD_FLOAT *bmap_x = &cuda_cl_x[bmap_vec_base];

    for(int cjj = 0; cjj < cuda_jclusters_natoms[cg]; cjj++) {
        cj_x[CL_X_OFFSET + cjj] = bmap_x[CL_X_OFFSET + cjj] + cuda_PBCx[cg] * xprd;
        cj_x[CL_Y_OFFSET + cjj] = bmap_x[CL_Y_OFFSET + cjj] + cuda_PBCy[cg] * yprd;
        cj_x[CL_Z_OFFSET + cjj] = bmap_x[CL_Z_OFFSET + cjj] + cuda_PBCz[cg] * zprd;
    }
}

__global__ void cudaUpdatePbcSup_warp(MD_FLOAT *cuda_cl_x, int *cuda_border_map,
                                   int *cuda_jclusters_natoms,
                                   int *cuda_PBCx,
                                   int *cuda_PBCy,
                                   int *cuda_PBCz,
                                   int Nsclusters_local,
                                   int Nclusters_ghost,
                                   MD_FLOAT param_xprd,
                                   MD_FLOAT param_yprd,
                                   MD_FLOAT param_zprd) {
    unsigned int cg = blockDim.x * blockIdx.x + threadIdx.x;
    if (cg >= Nclusters_ghost) return;

    //int jfac = MAX(1, CLUSTER_N / CLUSTER_M);
    int jfac = SCLUSTER_SIZE / CLUSTER_M;
    int ncj = Nsclusters_local / jfac;
    MD_FLOAT xprd = param_xprd;
    MD_FLOAT yprd = param_yprd;
    MD_FLOAT zprd = param_zprd;

    const int cj = ncj + cg;
    int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
    int bmap_vec_base = CJ_VECTOR_BASE_INDEX(cuda_border_map[cg]);
    MD_FLOAT *cj_x = &cuda_cl_x[cj_vec_base];
    MD_FLOAT *bmap_x = &cuda_cl_x[bmap_vec_base];

    for(int cjj = 0; cjj < cuda_jclusters_natoms[cg]; cjj++) {
        cj_x[CL_X_OFFSET + cjj] = bmap_x[CL_X_OFFSET + cjj] + cuda_PBCx[cg] * xprd;
        cj_x[CL_Y_OFFSET + cjj] = bmap_x[CL_Y_OFFSET + cjj] + cuda_PBCy[cg] * yprd;
        cj_x[CL_Z_OFFSET + cjj] = bmap_x[CL_Z_OFFSET + cjj] + cuda_PBCz[cg] * zprd;
    }
}

__global__ void computeForceLJ_cuda_warp(MD_FLOAT *cuda_cl_x, MD_FLOAT *cuda_cl_f,
                                         int Nclusters_local, int Nclusters_max,
                                         int *cuda_numneigh, int *cuda_neighs, int half_neigh, int maxneighs,
                                         MD_FLOAT cutforcesq, MD_FLOAT sigma6, MD_FLOAT epsilon) {

    unsigned int ci_pos = blockDim.x * blockIdx.x + threadIdx.x;
    unsigned int cii_pos = blockDim.y * blockIdx.y + threadIdx.y;
    unsigned int cjj_pos = blockDim.z * blockIdx.z + threadIdx.z;
    if ((ci_pos >= Nclusters_local) || (cii_pos >= CLUSTER_M) || (cjj_pos >= CLUSTER_N)) return;

    int ci_cj0 = CJ0_FROM_CI(ci_pos);
    int ci_vec_base = CI_VECTOR_BASE_INDEX(ci_pos);
    MD_FLOAT *ci_x = &cuda_cl_x[ci_vec_base];
    MD_FLOAT *ci_f = &cuda_cl_f[ci_vec_base];
    int numneighs = cuda_numneigh[ci_pos];
    for(int k = 0; k < numneighs; k++) {
        int cj = (&cuda_neighs[ci_pos * maxneighs])[k];
        int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
        MD_FLOAT *cj_x = &cuda_cl_x[cj_vec_base];
        MD_FLOAT *cj_f = &cuda_cl_f[cj_vec_base];

        MD_FLOAT xtmp = ci_x[CL_X_OFFSET + cii_pos];
        MD_FLOAT ytmp = ci_x[CL_Y_OFFSET + cii_pos];
        MD_FLOAT ztmp = ci_x[CL_Z_OFFSET + cii_pos];
        MD_FLOAT fix = 0;
        MD_FLOAT fiy = 0;
        MD_FLOAT fiz = 0;

        int cond;
#if CLUSTER_M == CLUSTER_N
        cond = half_neigh ? (ci_cj0 != cj || cii_pos < cjj_pos) :
                            (ci_cj0 != cj || cii_pos != cjj_pos);
#elif CLUSTER_M < CLUSTER_N
        cond = half_neigh ? (ci_cj0 != cj || cii_pos + CLUSTER_M * (ci_pos & 0x1) < cjj_pos) :
                            (ci_cj0 != cj || cii_pos + CLUSTER_M * (ci_pos & 0x1) != cjj_pos);
#endif
        if(cond) {
            MD_FLOAT delx = xtmp - cj_x[CL_X_OFFSET + cjj_pos];
            MD_FLOAT dely = ytmp - cj_x[CL_Y_OFFSET + cjj_pos];
            MD_FLOAT delz = ztmp - cj_x[CL_Z_OFFSET + cjj_pos];
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;
            if(rsq < cutforcesq) {
                MD_FLOAT sr2 = 1.0 / rsq;
                MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
                MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;

                if(half_neigh) {
                    atomicAdd(&cj_f[CL_X_OFFSET + cjj_pos], -delx * force);
                    atomicAdd(&cj_f[CL_Y_OFFSET + cjj_pos], -dely * force);
                    atomicAdd(&cj_f[CL_Z_OFFSET + cjj_pos], -delz * force);
                }

                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force;

                atomicAdd(&ci_f[CL_X_OFFSET + cii_pos], fix);
                atomicAdd(&ci_f[CL_Y_OFFSET + cii_pos], fiy);
                atomicAdd(&ci_f[CL_Z_OFFSET + cii_pos], fiz);
            }
        }
    }
}

__global__ void cudaFinalIntegrate_warp(MD_FLOAT *cuda_cl_v, MD_FLOAT *cuda_cl_f,
                                          int *cuda_natoms,
                                          int Nclusters_local, MD_FLOAT dtforce) {

    unsigned int ci_pos = blockDim.x * blockIdx.x + threadIdx.x;
    if (ci_pos >= Nclusters_local) return;

    int ci_vec_base = CI_VECTOR_BASE_INDEX(ci_pos);
    MD_FLOAT *ci_v = &cuda_cl_v[ci_vec_base];
    MD_FLOAT *ci_f = &cuda_cl_f[ci_vec_base];

    for (int cii = 0; cii < cuda_natoms[ci_pos]; cii++) {
        ci_v[CL_X_OFFSET + cii] += dtforce * ci_f[CL_X_OFFSET + cii];
        ci_v[CL_Y_OFFSET + cii] += dtforce * ci_f[CL_Y_OFFSET + cii];
        ci_v[CL_Z_OFFSET + cii] += dtforce * ci_f[CL_Z_OFFSET + cii];
    }
}

extern "C"
void cudaInitialIntegrate(Parameter *param, Atom *atom) {
    const int threads_num = 16;
    dim3 block_size = dim3(threads_num, 1, 1);

    #ifdef USE_SUPER_CLUSTERS
    dim3 grid_size = dim3(atom->Nsclusters_local/(threads_num)+1, 1, 1);
    cudaInitialIntegrateSup_warp<<<grid_size, block_size>>>(cuda_scl_x, cuda_scl_v, cuda_scl_f,
                                                            cuda_nclusters,
                                                            cuda_natoms, atom->Nsclusters_local, param->dtforce, param->dt);
    #else
    dim3 grid_size = dim3(atom->Nclusters_local/(threads_num)+1, 1, 1);
    cudaInitialIntegrate_warp<<<grid_size, block_size>>>(cuda_cl_x, cuda_cl_v, cuda_cl_f,
                                                         cuda_natoms, atom->Nclusters_local, param->dtforce, param->dt);
    #endif //USE_SUPER_CLUSTERS
    cuda_assert("cudaInitialIntegrate", cudaPeekAtLastError());
    cuda_assert("cudaInitialIntegrate", cudaDeviceSynchronize());
}

/* update coordinates of ghost atoms */
/* uses mapping created in setupPbc */
extern "C"
void cudaUpdatePbc(Atom *atom, Parameter *param) {
    const int threads_num = 512;
    dim3 block_size = dim3(threads_num, 1, 1);;
    dim3 grid_size = dim3(atom->Nclusters_ghost/(threads_num)+1, 1, 1);

#ifdef USE_SUPER_CLUSTERS
    cudaUpdatePbcSup_warp<<<grid_size, block_size>>>(cuda_scl_x, cuda_border_map,
                                       cuda_jclusters_natoms, cuda_PBCx, cuda_PBCy, cuda_PBCz,
                                       atom->Nclusters_local, atom->Nclusters_ghost,
                                       param->xprd, param->yprd, param->zprd);
#else
    cudaUpdatePbc_warp<<<grid_size, block_size>>>(cuda_cl_x, cuda_border_map,
                                                  cuda_jclusters_natoms, cuda_PBCx, cuda_PBCy, cuda_PBCz,
                                                  atom->Nclusters_local, atom->Nclusters_ghost,
                                                  param->xprd, param->yprd, param->zprd);
#endif //USE_SUPER_CLUSTERS
    cuda_assert("cudaUpdatePbc", cudaPeekAtLastError());
    cuda_assert("cudaUpdatePbc", cudaDeviceSynchronize());
}

extern "C"
double computeForceLJ_cuda(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;

    memsetGPU(cuda_cl_f, 0, atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    if (isReneighboured) {
        for(int ci = 0; ci < atom->Nclusters_local; ci++) {
            memcpyToGPU(&cuda_numneigh[ci], &neighbor->numneigh[ci], sizeof(int));
            memcpyToGPU(&cuda_neighbors[ci * neighbor->maxneighs], &neighbor->neighbors[ci * neighbor->maxneighs], neighbor->numneigh[ci] * sizeof(int));
        }

        isReneighboured = 0;
    }

    const int threads_num = 1;
    dim3 block_size = dim3(threads_num, CLUSTER_M, CLUSTER_N);
    dim3 grid_size = dim3(atom->Nclusters_local/threads_num+1, 1, 1);
    double S = getTimeStamp();
    LIKWID_MARKER_START("force");
    computeForceLJ_cuda_warp<<<grid_size, block_size>>>(cuda_cl_x, cuda_cl_f,
                                                        atom->Nclusters_local, atom->Nclusters_max,
                                                        cuda_numneigh, cuda_neighbors,
                                                        neighbor->half_neigh, neighbor->maxneighs, cutforcesq,
                                                        sigma6, epsilon);
    cuda_assert("computeForceLJ_cuda", cudaPeekAtLastError());
    cuda_assert("computeForceLJ_cuda", cudaDeviceSynchronize());
    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();
    return E-S;
}

extern "C"
void cudaFinalIntegrate(Parameter *param, Atom *atom) {
    const int threads_num = 16;
    dim3 block_size = dim3(threads_num, 1, 1);

    #ifdef USE_SUPER_CLUSTERS
    dim3 grid_size = dim3(atom->Nsclusters_local/(threads_num)+1, 1, 1);
    cudaFinalIntegrateSup_warp<<<grid_size, block_size>>>(cuda_scl_v, cuda_scl_f,
                                                          cuda_nclusters, cuda_natoms,
                                                          atom->Nsclusters_local, param->dt);
    #else
    dim3 grid_size = dim3(atom->Nclusters_local/(threads_num)+1, 1, 1);
    cudaFinalIntegrate_warp<<<grid_size, block_size>>>(cuda_cl_v, cuda_cl_f, cuda_natoms,
                                                          atom->Nclusters_local, param->dt);
    #endif //USE_SUPER_CLUSTERS
    cuda_assert("cudaFinalIntegrate", cudaPeekAtLastError());
    cuda_assert("cudaFinalIntegrate", cudaDeviceSynchronize());
}
