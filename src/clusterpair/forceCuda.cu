/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
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
#include <force.h>
#include <neighbor.h>
#include <parameter.h>
#include <stats.h>
#include <timing.h>
#include <util.h>
}

extern "C" {
MD_FLOAT* cuda_cl_x;
MD_FLOAT* cuda_cl_v;
MD_FLOAT* cuda_cl_f;
int* cuda_neighbors;
int* cuda_numneigh;
int* cuda_natoms;
int* natoms;
int* ngatoms;
int* cuda_border_map;
int* cuda_jclusters_natoms;
int *cuda_PBCx, *cuda_PBCy, *cuda_PBCz;

#ifndef ONE_ATOM_TYPE
int* cuda_cl_t;
MD_FLOAT* cuda_cutforcesq;
MD_FLOAT* cuda_sigma6;
MD_FLOAT* cuda_epsilon;
#endif
}

extern "C" void initDevice(Atom* atom, Neighbor* neighbor)
{
    cuda_assert("cudaDeviceSetup", cudaDeviceReset());
    cuda_assert("cudaDeviceSetup", cudaSetDevice(0));

    cuda_cl_x = (MD_FLOAT*)allocateGPU(
        atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    cuda_cl_v = (MD_FLOAT*)allocateGPU(
        atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    cuda_cl_f = (MD_FLOAT*)allocateGPU(
        atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
#ifndef ONE_ATOM_TYPE
    cuda_cl_t       = (int*)allocateGPU(atom->Nclusters_max * CLUSTER_M * sizeof(int));
    cuda_cutforcesq = (MD_FLOAT*)allocateGPU(
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    cuda_sigma6  = (MD_FLOAT*)allocateGPU(atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    cuda_epsilon = (MD_FLOAT*)allocateGPU(atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));

    memcpyToGPU(cuda_cutforcesq,
        atom->cutforcesq,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    memcpyToGPU(cuda_sigma6,
        atom->sigma6,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
    memcpyToGPU(cuda_epsilon,
        atom->epsilon,
        atom->ntypes * atom->ntypes * sizeof(MD_FLOAT));
#endif
    cuda_natoms           = (int*)allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_jclusters_natoms = (int*)allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_border_map       = (int*)allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_PBCx             = (int*)allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_PBCy             = (int*)allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_PBCz             = (int*)allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_numneigh         = (int*)allocateGPU(atom->Nclusters_max * sizeof(int));
    cuda_neighbors        = (int*)allocateGPU(
        atom->Nclusters_max * neighbor->maxneighs * sizeof(int));
    natoms          = (int*)malloc(atom->Nclusters_max * sizeof(int));
    ngatoms         = (int*)malloc(atom->Nclusters_max * sizeof(int));
}

extern "C" void copyDataToCUDADevice(Atom* atom, Neighbor* neighbor)
{
    memcpyToGPU(cuda_cl_x,
        atom->cl_x,
        atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    memcpyToGPU(cuda_cl_v,
        atom->cl_v,
        atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
#ifndef ONE_ATOM_TYPE
    memcpyToGPU(cuda_cl_t, atom->cl_t, atom->Nclusters_max * CLUSTER_M * sizeof(int));
#endif

    for (int ci = 0; ci < atom->Nclusters_local; ci++) {
        natoms[ci] = atom->iclusters[ci].natoms;
    }

    int jfac = MAX(1, CLUSTER_N / CLUSTER_M);
    int ncj  = atom->Nclusters_local / jfac;
    for (int cg = 0; cg < atom->Nclusters_ghost; cg++) {
        const int cj = ncj + cg;
        ngatoms[cg]  = atom->jclusters[cj].natoms;
    }

    memcpyToGPU(cuda_natoms, natoms, atom->Nclusters_local * sizeof(int));
    memcpyToGPU(cuda_jclusters_natoms, ngatoms, atom->Nclusters_ghost * sizeof(int));
    memcpyToGPU(cuda_border_map, atom->border_map, atom->Nclusters_ghost * sizeof(int));
    memcpyToGPU(cuda_PBCx, atom->PBCx, atom->Nclusters_ghost * sizeof(int));
    memcpyToGPU(cuda_PBCy, atom->PBCy, atom->Nclusters_ghost * sizeof(int));
    memcpyToGPU(cuda_PBCz, atom->PBCz, atom->Nclusters_ghost * sizeof(int));
    memcpyToGPU(cuda_numneigh, neighbor->numneigh, atom->Nclusters_local * sizeof(int));
    memcpyToGPU(cuda_neighbors,
        neighbor->neighbors,
        atom->Nclusters_local * neighbor->maxneighs * sizeof(int));
}

extern "C" void copyDataFromCUDADevice(Atom* atom)
{
    memcpyFromGPU(atom->cl_x,
        cuda_cl_x,
        atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    memcpyFromGPU(atom->cl_v,
        cuda_cl_v,
        atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
}

extern "C" void cudaDeviceFree(void)
{
    cuda_assert("cudaDeviceFree", cudaFree(cuda_cl_x));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_cl_v));
    cuda_assert("cudaDeviceFree", cudaFree(cuda_cl_f));
#ifndef ONE_ATOM_TYPE
    cuda_assert("cudaDeviceFree", cudaFree(cuda_cl_t));
#endif
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
}

__global__ void cudaInitialIntegrate_warp(MD_FLOAT* cuda_cl_x,
    MD_FLOAT* cuda_cl_v,
    MD_FLOAT* cuda_cl_f,
    int* cuda_natoms,
    int Nclusters_local,
    MD_FLOAT dtforce,
    MD_FLOAT dt)
{

    unsigned int ci = blockDim.x * blockIdx.x + threadIdx.x;
    if (ci >= Nclusters_local) return;

    int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
    MD_FLOAT* ci_x  = &cuda_cl_x[ci_vec_base];
    MD_FLOAT* ci_v  = &cuda_cl_v[ci_vec_base];
    MD_FLOAT* ci_f  = &cuda_cl_f[ci_vec_base];

    for (int cii = 0; cii < cuda_natoms[ci]; cii++) {
        ci_v[CL_X_OFFSET + cii] += dtforce * ci_f[CL_X_OFFSET + cii];
        ci_v[CL_Y_OFFSET + cii] += dtforce * ci_f[CL_Y_OFFSET + cii];
        ci_v[CL_Z_OFFSET + cii] += dtforce * ci_f[CL_Z_OFFSET + cii];
        ci_x[CL_X_OFFSET + cii] += dt * ci_v[CL_X_OFFSET + cii];
        ci_x[CL_Y_OFFSET + cii] += dt * ci_v[CL_Y_OFFSET + cii];
        ci_x[CL_Z_OFFSET + cii] += dt * ci_v[CL_Z_OFFSET + cii];
    }
}

__global__ void cudaUpdatePbc_warp(MD_FLOAT* cuda_cl_x,
    int* cuda_border_map,
    int* cuda_jclusters_natoms,
    int* cuda_PBCx,
    int* cuda_PBCy,
    int* cuda_PBCz,
    int Nclusters_local,
    int Nclusters_ghost,
    MD_FLOAT param_xprd,
    MD_FLOAT param_yprd,
    MD_FLOAT param_zprd)
{
    unsigned int cg = blockDim.x * blockIdx.x + threadIdx.x;
    if (cg >= Nclusters_ghost) return;

    int jfac      = MAX(1, CLUSTER_N / CLUSTER_M);
    int ncj       = Nclusters_local / jfac;
    MD_FLOAT xprd = param_xprd;
    MD_FLOAT yprd = param_yprd;
    MD_FLOAT zprd = param_zprd;

    const int cj      = ncj + cg;
    int cj_vec_base   = CJ_VECTOR_BASE_INDEX(cj);
    int bmap_vec_base = CJ_VECTOR_BASE_INDEX(cuda_border_map[cg]);
    MD_FLOAT* cj_x    = &cuda_cl_x[cj_vec_base];
    MD_FLOAT* bmap_x  = &cuda_cl_x[bmap_vec_base];

    for (int cjj = 0; cjj < cuda_jclusters_natoms[cg]; cjj++) {
        cj_x[CL_X_OFFSET + cjj] = bmap_x[CL_X_OFFSET + cjj] + cuda_PBCx[cg] * xprd;
        cj_x[CL_Y_OFFSET + cjj] = bmap_x[CL_Y_OFFSET + cjj] + cuda_PBCy[cg] * yprd;
        cj_x[CL_Z_OFFSET + cjj] = bmap_x[CL_Z_OFFSET + cjj] + cuda_PBCz[cg] * zprd;
    }
}

__global__ void computeForceLJCudaFullNeigh(
#ifdef ONE_ATOM_TYPE
    MD_FLOAT cutforcesq,
    MD_FLOAT sigma6,
    MD_FLOAT epsilon,
#else
    int* cuda_cl_t,
    MD_FLOAT* atom_cutforcesq,
    MD_FLOAT* atom_sigma6,
    MD_FLOAT* atom_epsilon,
    int ntypes,
#endif
    MD_FLOAT* cuda_cl_x,
    MD_FLOAT* cuda_cl_f,
    int Nclusters_local,
    int Nclusters_max,
    int* cuda_numneigh,
    int* cuda_neighs,
    int maxneighs)
{

    int ci = blockDim.x * blockIdx.x + threadIdx.x;
    if (ci >= Nclusters_local) return;

    int cii         = threadIdx.z;
    int cjj         = threadIdx.y;
    int ci_cj0      = CJ0_FROM_CI(ci);
    int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
    MD_FLOAT* ci_x  = &cuda_cl_x[ci_vec_base];
    MD_FLOAT* ci_f  = &cuda_cl_f[ci_vec_base];
    int* neighs     = &cuda_neighs[ci * maxneighs];
    int numneighs   = cuda_numneigh[ci];
    MD_FLOAT xtmp   = ci_x[CL_X_OFFSET + cii];
    MD_FLOAT ytmp   = ci_x[CL_Y_OFFSET + cii];
    MD_FLOAT ztmp   = ci_x[CL_Z_OFFSET + cii];
    MD_FLOAT fix    = 0;
    MD_FLOAT fiy    = 0;
    MD_FLOAT fiz    = 0;

#ifndef ONE_ATOM_TYPE
    int ci_sca_base = CI_SCALAR_BASE_INDEX(ci);
    int type_i      = cuda_cl_t[ci_sca_base + cii];
#endif

    for (int k = 0; k < numneighs; k++) {
        int cj          = neighs[k];
        int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
        MD_FLOAT* cj_x  = &cuda_cl_x[cj_vec_base];

        int cond;
#if CLUSTER_M == CLUSTER_N
        cond = ci_cj0 != cj || cii != cjj;
#elif CLUSTER_M < CLUSTER_N
        cond = ci_cj0 != cj || cii + CLUSTER_M * (ci & 0x1) != cjj;
#endif
        if (cond) {
            MD_FLOAT delx = xtmp - cj_x[CL_X_OFFSET + cjj];
            MD_FLOAT dely = ytmp - cj_x[CL_Y_OFFSET + cjj];
            MD_FLOAT delz = ztmp - cj_x[CL_Z_OFFSET + cjj];
            MD_FLOAT rsq  = delx * delx + dely * dely + delz * delz;

#ifndef ONE_ATOM_TYPE
            int cj_sca_base     = CJ_SCALAR_BASE_INDEX(cj);
            int type_j          = cuda_cl_t[cj_sca_base + cjj];
            int type_index      = type_i * ntypes + type_j;
            MD_FLOAT cutforcesq = atom_cutforcesq[type_index];
            MD_FLOAT sigma6     = atom_sigma6[type_index];
            MD_FLOAT epsilon    = atom_epsilon[type_index];
#endif

            if (rsq < cutforcesq) {
                MD_FLOAT sr2   = (MD_FLOAT)(1.0) / rsq;
                MD_FLOAT sr6   = sr2 * sr2 * sr2 * sigma6;
                MD_FLOAT force = (MD_FLOAT)(48.0) * sr6 * (sr6 - (MD_FLOAT)(0.5)) * sr2 * epsilon;

                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force;
            }
        }
    }

// If M is less than the warp size, we perform forces reduction via
// warp shuffles instead of using atomics since it should be cheaper
// It is very unlikely that M > 32, but we keep this check here to
// avoid any issues in such situations
#if CLUSTER_M <= 32
    unsigned mask = 0xffffffff;
    for (int offset = CLUSTER_M / 2; offset > 0; offset /= 2) {
        fix += __shfl_down_sync(mask, fix, offset);
        fiy += __shfl_down_sync(mask, fiy, offset);
        fiz += __shfl_down_sync(mask, fiz, offset);
    }

    if (threadIdx.x == 0) {
        ci_f[CL_X_OFFSET + cii] = fix;
        ci_f[CL_Y_OFFSET + cii] = fiy;
        ci_f[CL_Z_OFFSET + cii] = fiz;
    }
#else
    atomicAdd(&ci_f[CL_X_OFFSET + cii], fix);
    atomicAdd(&ci_f[CL_Y_OFFSET + cii], fiy);
    atomicAdd(&ci_f[CL_Z_OFFSET + cii], fiz);
#endif
}

__global__ void computeForceLJCudaHalfNeigh(
#ifdef ONE_ATOM_TYPE
    MD_FLOAT cutforcesq,
    MD_FLOAT sigma6,
    MD_FLOAT epsilon,
#else
    int* cuda_cl_t,
    MD_FLOAT* atom_cutforcesq,
    MD_FLOAT* atom_sigma6,
    MD_FLOAT* atom_epsilon,
    int ntypes,
#endif
    MD_FLOAT* cuda_cl_x,
    MD_FLOAT* cuda_cl_f,
    int Nclusters_local,
    int Nclusters_max,
    int* cuda_numneigh,
    int* cuda_neighs,
    int maxneighs)
{
    int ci = blockDim.x * blockIdx.x + threadIdx.x;
    if (ci >= Nclusters_local) return;

    int cii         = threadIdx.z;
    int cjj         = threadIdx.y;
    int ci_cj0      = CJ0_FROM_CI(ci);
    int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
    MD_FLOAT* ci_x  = &cuda_cl_x[ci_vec_base];
    MD_FLOAT* ci_f  = &cuda_cl_f[ci_vec_base];
    int* neighs     = &cuda_neighs[ci * maxneighs];
    int numneighs   = cuda_numneigh[ci];
    MD_FLOAT xtmp   = ci_x[CL_X_OFFSET + cii];
    MD_FLOAT ytmp   = ci_x[CL_Y_OFFSET + cii];
    MD_FLOAT ztmp   = ci_x[CL_Z_OFFSET + cii];
    MD_FLOAT fix    = 0;
    MD_FLOAT fiy    = 0;
    MD_FLOAT fiz    = 0;

#ifndef ONE_ATOM_TYPE
    int ci_sca_base = CI_SCALAR_BASE_INDEX(ci);
    int type_i      = cuda_cl_t[ci_sca_base + cii];
#endif

    for (int k = 0; k < numneighs; k++) {
        int cj          = neighs[k];
        int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
        MD_FLOAT* cj_x  = &cuda_cl_x[cj_vec_base];
        MD_FLOAT* cj_f  = &cuda_cl_f[cj_vec_base];

        int cond;
#if CLUSTER_M == CLUSTER_N
        cond = ci_cj0 != cj || cii < cjj;
#elif CLUSTER_M < CLUSTER_N
        cond = ci_cj0 != cj || cii + CLUSTER_M * (ci & 0x1) < cjj;
#endif
        if (cond) {
            MD_FLOAT delx = xtmp - cj_x[CL_X_OFFSET + cjj];
            MD_FLOAT dely = ytmp - cj_x[CL_Y_OFFSET + cjj];
            MD_FLOAT delz = ztmp - cj_x[CL_Z_OFFSET + cjj];
            MD_FLOAT rsq  = delx * delx + dely * dely + delz * delz;

#ifndef ONE_ATOM_TYPE
            int cj_sca_base     = CJ_SCALAR_BASE_INDEX(cj);
            int type_j          = cuda_cl_t[cj_sca_base + cjj];
            int type_index      = type_i * ntypes + type_j;
            MD_FLOAT cutforcesq = atom_cutforcesq[type_index];
            MD_FLOAT sigma6     = atom_sigma6[type_index];
            MD_FLOAT epsilon    = atom_epsilon[type_index];
#endif

            if (rsq < cutforcesq) {
                MD_FLOAT sr2             = 1.0 / rsq;
                MD_FLOAT sr6             = sr2 * sr2 * sr2 * sigma6;
                MD_FLOAT force           = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;
                MD_FLOAT partial_force_x = delx * force;
                MD_FLOAT partial_force_y = dely * force;
                MD_FLOAT partial_force_z = delz * force;

                atomicAdd(&cj_f[CL_X_OFFSET + cjj], -partial_force_x);
                atomicAdd(&cj_f[CL_Y_OFFSET + cjj], -partial_force_y);
                atomicAdd(&cj_f[CL_Z_OFFSET + cjj], -partial_force_z);

                fix += partial_force_x;
                fiy += partial_force_y;
                fiz += partial_force_z;
            }
        }
    }

    atomicAdd(&ci_f[CL_X_OFFSET + cii], fix);
    atomicAdd(&ci_f[CL_Y_OFFSET + cii], fiy);
    atomicAdd(&ci_f[CL_Z_OFFSET + cii], fiz);
}

__global__ void cudaFinalIntegrate_warp(MD_FLOAT* cuda_cl_v,
    MD_FLOAT* cuda_cl_f,
    int* cuda_natoms,
    int Nclusters_local,
    MD_FLOAT dtforce)
{

    unsigned int ci = blockDim.x * blockIdx.x + threadIdx.x;
    if (ci >= Nclusters_local) return;

    int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
    MD_FLOAT* ci_v  = &cuda_cl_v[ci_vec_base];
    MD_FLOAT* ci_f  = &cuda_cl_f[ci_vec_base];

    for (int cii = 0; cii < cuda_natoms[ci]; cii++) {
        ci_v[CL_X_OFFSET + cii] += dtforce * ci_f[CL_X_OFFSET + cii];
        ci_v[CL_Y_OFFSET + cii] += dtforce * ci_f[CL_Y_OFFSET + cii];
        ci_v[CL_Z_OFFSET + cii] += dtforce * ci_f[CL_Z_OFFSET + cii];
    }
}

extern "C" void initialIntegrateCUDA(Parameter* param, Atom* atom)
{
    const int threads_num = 64;
    dim3 block_size       = dim3(threads_num, 1, 1);
    dim3 grid_size = dim3((atom->Nclusters_local + threads_num - 1) / threads_num, 1, 1);

    cudaInitialIntegrate_warp<<<grid_size, block_size>>>(cuda_cl_x,
        cuda_cl_v,
        cuda_cl_f,
        cuda_natoms,
        atom->Nclusters_local,
        param->dtforce,
        param->dt);

    cuda_assert("cudaInitialIntegrate", cudaPeekAtLastError());
    cuda_assert("cudaInitialIntegrate", cudaDeviceSynchronize());
}

/* update coordinates of ghost atoms */
/* uses mapping created in setupPbc */
extern "C" void updatePbcCUDA(Atom* atom, Parameter* param)
{
    const int threads_num = 64;
    dim3 block_size       = dim3(threads_num, 1, 1);
    dim3 grid_size = dim3((atom->Nclusters_ghost + threads_num - 1) / threads_num, 1, 1);

    cudaUpdatePbc_warp<<<grid_size, block_size>>>(cuda_cl_x,
        cuda_border_map,
        cuda_jclusters_natoms,
        cuda_PBCx,
        cuda_PBCy,
        cuda_PBCz,
        atom->Nclusters_local,
        atom->Nclusters_ghost,
        param->xprd,
        param->yprd,
        param->zprd);

    cuda_assert("cudaUpdatePbc", cudaPeekAtLastError());
    cuda_assert("cudaUpdatePbc", cudaDeviceSynchronize());
}

extern "C" double computeForceLJCUDA(
    Parameter* param, Atom* atom, Neighbor* neighbor, Stats* stats)
{
#ifdef ONE_ATOM_TYPE
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6     = param->sigma6;
    MD_FLOAT epsilon    = param->epsilon;
#endif

    memsetGPU(cuda_cl_f, 0, atom->Nclusters_local * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    const int threads_num = 1;
    dim3 block_size       = dim3(threads_num, CLUSTER_N, CLUSTER_M);
    dim3 grid_size = dim3((atom->Nclusters_local + threads_num - 1) / threads_num, 1, 1);
    double S       = getTimeStamp();
    LIKWID_MARKER_START("force");

    if (neighbor->half_neigh) {
        computeForceLJCudaHalfNeigh<<<grid_size, block_size>>>(
#ifdef ONE_ATOM_TYPE
            cutforcesq,
            sigma6,
            epsilon,
#else
            cuda_cl_t,
            cuda_cutforcesq,
            cuda_sigma6,
            cuda_epsilon,
            atom->ntypes,
#endif
            cuda_cl_x,
            cuda_cl_f,
            atom->Nclusters_local,
            atom->Nclusters_max,
            cuda_numneigh,
            cuda_neighbors,
            neighbor->maxneighs);
    } else {
        computeForceLJCudaFullNeigh<<<grid_size, block_size>>>(
#ifdef ONE_ATOM_TYPE
            cutforcesq,
            sigma6,
            epsilon,
#else
            cuda_cl_t,
            cuda_cutforcesq,
            cuda_sigma6,
            cuda_epsilon,
            atom->ntypes,
#endif
            cuda_cl_x,
            cuda_cl_f,
            atom->Nclusters_local,
            atom->Nclusters_max,
            cuda_numneigh,
            cuda_neighbors,
            neighbor->maxneighs);
    }

    cuda_assert("computeForceLJ_cuda", cudaPeekAtLastError());
    cuda_assert("computeForceLJ_cuda", cudaDeviceSynchronize());
    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();
    return E - S;
}

extern "C" void finalIntegrateCUDA(Parameter* param, Atom* atom)
{
    const int threads_num = 64;
    dim3 block_size       = dim3(threads_num, 1, 1);
    dim3 grid_size = dim3((atom->Nclusters_local + threads_num - 1) / threads_num, 1, 1);

    cudaFinalIntegrate_warp<<<grid_size, block_size>>>(cuda_cl_v,
        cuda_cl_f,
        cuda_natoms,
        atom->Nclusters_local,
        param->dt);

    cuda_assert("cudaFinalIntegrate", cudaPeekAtLastError());
    cuda_assert("cudaFinalIntegrate", cudaDeviceSynchronize());
}
