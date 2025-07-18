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
extern MD_FLOAT* cuda_cl_x;
extern MD_FLOAT* cuda_cl_v;
extern MD_FLOAT* cuda_cl_f;
extern int* cuda_neighbors;
extern int* cuda_numneigh;
extern int* cuda_natoms;
extern int* natoms;
extern int* ngatoms;
extern int* cuda_border_map;
extern int* cuda_jclusters_natoms;
extern MD_FLOAT *cuda_bbminx, *cuda_bbmaxx;
extern MD_FLOAT *cuda_bbminy, *cuda_bbmaxy;
extern MD_FLOAT *cuda_bbminz, *cuda_bbmaxz;
extern int *cuda_PBCx, *cuda_PBCy, *cuda_PBCz;
}

__global__ void cudaInitialIntegrateSup_warp(MD_FLOAT* cuda_cl_x,
    MD_FLOAT* cuda_cl_v,
    MD_FLOAT* cuda_cl_f,
    int Nclusters_local,
    MD_FLOAT dtforce,
    MD_FLOAT dt) {

    int sci = blockIdx.x;
    int ci = threadIdx.x;
    int cii = threadIdx.y;

    if (sci >= Nclusters_local) {
        return;
    }

    int sci_vec_base = SCI_VECTOR_BASE_INDEX(sci);
    int i            = ci * CLUSTER_M + cii;
    MD_FLOAT* ci_x   = &cuda_cl_x[sci_vec_base];
    MD_FLOAT* ci_v   = &cuda_cl_v[sci_vec_base];
    MD_FLOAT* ci_f   = &cuda_cl_f[sci_vec_base];

    ci_v[CL_X_OFFSET + i] += dtforce * ci_f[CL_X_OFFSET + i];
    ci_v[CL_Y_OFFSET + i] += dtforce * ci_f[CL_Y_OFFSET + i];
    ci_v[CL_Z_OFFSET + i] += dtforce * ci_f[CL_Z_OFFSET + i];
    ci_x[CL_X_OFFSET + i] += dt * ci_v[CL_X_OFFSET + i];
    ci_x[CL_Y_OFFSET + i] += dt * ci_v[CL_Y_OFFSET + i];
    ci_x[CL_Z_OFFSET + i] += dt * ci_v[CL_Z_OFFSET + i];
}

extern "C" void cudaInitialIntegrateSup(Parameter* param, Atom* atom) {
    dim3 block_size       = dim3(SCLUSTER_SIZE, CLUSTER_M, 1);
    dim3 grid_size        = dim3(atom->Nclusters_local, 1, 1);

    cudaInitialIntegrateSup_warp<<<grid_size, block_size>>>(cuda_cl_x,
        cuda_cl_v,
        cuda_cl_f,
        atom->Nclusters_local,
        param->dtforce,
        param->dt);

    cuda_assert("cudaInitialIntegrateSup", cudaPeekAtLastError());
    cuda_assert("cudaInitialIntegrateSup", cudaDeviceSynchronize());
}

__global__ void cudaFinalIntegrateSup_warp(MD_FLOAT* cuda_cl_v,
    MD_FLOAT* cuda_cl_f,
    int Nclusters_local,
    MD_FLOAT dtforce) {

    int sci = blockIdx.x;
    int ci = threadIdx.x;
    int cii = threadIdx.y;

    if (sci >= Nclusters_local) {
        return;
    }

    int sci_vec_base = SCI_VECTOR_BASE_INDEX(sci);
    int i            = ci * CLUSTER_M + cii;
    MD_FLOAT* ci_v   = &cuda_cl_v[sci_vec_base];
    MD_FLOAT* ci_f   = &cuda_cl_f[sci_vec_base];

    ci_v[CL_X_OFFSET + i] += dtforce * ci_f[CL_X_OFFSET + i];
    ci_v[CL_Y_OFFSET + i] += dtforce * ci_f[CL_Y_OFFSET + i];
    ci_v[CL_Z_OFFSET + i] += dtforce * ci_f[CL_Z_OFFSET + i];
}

extern "C" void cudaFinalIntegrateSup(Parameter* param, Atom* atom) {
    dim3 block_size       = dim3(SCLUSTER_SIZE, CLUSTER_M, 1);
    dim3 grid_size        = dim3(atom->Nclusters_local, 1, 1);

    cudaFinalIntegrateSup_warp<<<grid_size, block_size>>>(cuda_cl_v,
        cuda_cl_f,
        atom->Nclusters_local,
        param->dt);

    cuda_assert("cudaFinalIntegrateSup", cudaPeekAtLastError());
    cuda_assert("cudaFinalIntegrateSup", cudaDeviceSynchronize());
}

__global__ void computeForceLJCudaSup_warp(MD_FLOAT* cuda_cl_x,
    MD_FLOAT* cuda_cl_f,
    int Nclusters_local,
    int* cuda_numneigh,
    int* cuda_neighs,
    int half_neigh,
    int maxneighs,
    MD_FLOAT cutforcesq,
    MD_FLOAT sigma6,
    MD_FLOAT epsilon) {

    __shared__ MD_FLOAT sh_sci_x[SCLUSTER_SIZE * CLUSTER_M * 3];
    int sci = blockIdx.x;
    int cii = threadIdx.x;
    int cjj = threadIdx.y;
    int sci_vec_base = SCI_VECTOR_BASE_INDEX(sci);
    MD_FLOAT* sci_x  = &cuda_cl_x[sci_vec_base];
    MD_FLOAT* sci_f  = &cuda_cl_f[sci_vec_base];
    int tid = cii * CLUSTER_N + cjj;
    int ncoords = SCLUSTER_SIZE * CLUSTER_M * 3;
    MD_FLOAT fx_acc[SCLUSTER_SIZE];
    MD_FLOAT fy_acc[SCLUSTER_SIZE];
    MD_FLOAT fz_acc[SCLUSTER_SIZE];

    #pragma unroll
    for(int i = 0; i < SCLUSTER_SIZE; i++) {
        fx_acc[i] = (MD_FLOAT)0.0;
        fy_acc[i] = (MD_FLOAT)0.0;
        fz_acc[i] = (MD_FLOAT)0.0;
    }

    for(int idx = tid; idx < ncoords; idx += blockDim.x * blockDim.y) {
        sh_sci_x[idx] = sci_x[idx];
    }

    __syncthreads();

    for(int k = 0; k < cuda_numneigh[sci]; k++) {
        int cj = cuda_neighs[sci * maxneighs + k];
        int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
        MD_FLOAT* cj_x  = &cuda_cl_x[cj_vec_base];
        MD_FLOAT* cj_f  = &cuda_cl_f[cj_vec_base];
        MD_FLOAT xjtmp = cj_x[CL_X_OFFSET + cjj];
        MD_FLOAT yjtmp = cj_x[CL_Y_OFFSET + cjj];
        MD_FLOAT zjtmp = cj_x[CL_Z_OFFSET + cjj];
        int cj_sc = cj / SCLUSTER_SIZE;
        int sci_cj = cj % SCLUSTER_SIZE;

        #pragma unroll
        for(int sci_ci = 0; sci_ci < SCLUSTER_SIZE; sci_ci++) {
            if(sci != cj_sc || sci_ci != sci_cj || cii != cjj) {
                int ai = sci_ci * CLUSTER_M + cii;
                MD_FLOAT delx = sh_sci_x[CL_X_OFFSET + ai] - xjtmp;
                MD_FLOAT dely = sh_sci_x[CL_Y_OFFSET + ai] - yjtmp;
                MD_FLOAT delz = sh_sci_x[CL_Z_OFFSET + ai] - zjtmp;
                MD_FLOAT rsq  = delx * delx + dely * dely + delz * delz;

                if(rsq < cutforcesq) {
                    MD_FLOAT sr2   = (MD_FLOAT)(1.0) / rsq;
                    MD_FLOAT sr6   = sr2 * sr2 * sr2 * sigma6;
                    MD_FLOAT force = (MD_FLOAT)(48.0) * sr6 * (sr6 - (MD_FLOAT)(0.5)) * sr2 *
                                 epsilon;
                    MD_FLOAT fx = delx * force;
                    MD_FLOAT fy = dely * force;
                    MD_FLOAT fz = delz * force;

                    fx_acc[sci_ci] += fx;
                    fy_acc[sci_ci] += fy;
                    fz_acc[sci_ci] += fz;

                    if (half_neigh) {
                        atomicAdd(&cj_f[CL_X_OFFSET + cjj], -fx);
                        atomicAdd(&cj_f[CL_Y_OFFSET + cjj], -fy);
                        atomicAdd(&cj_f[CL_Z_OFFSET + cjj], -fz);
                    }
                }
            }
        }
    }

    #pragma unroll
    for(int sci_ci = 0; sci_ci < SCLUSTER_SIZE; sci_ci++) {
        int ai = sci_ci * CLUSTER_M + cii;
        
        // If M is less than the warp size, we perform forces reduction via
        // warp shuffles instead of using atomics since it should be cheaper
        // It is very unlikely that M > 32, but we keep this check here to
        // avoid any issues in such situations
        #if false && CLUSTER_M <= 32
        MD_FLOAT fix  = fx_acc[sci_ci];
        MD_FLOAT fiy  = fy_acc[sci_ci];
        MD_FLOAT fiz  = fz_acc[sci_ci];
        unsigned mask = 0xffffffff;
        
        for (int offset = CLUSTER_N / 2; offset > 0; offset /= 2) {
            #ifdef CUDA_TARGET
            fix += __shfl_down_sync(mask, fix, offset);
            fiy += __shfl_down_sync(mask, fiy, offset);
            fiz += __shfl_down_sync(mask, fiz, offset);
            #else
            fix += __shfl_down(fix, offset);
            fiy += __shfl_down(fiy, offset);
            fiz += __shfl_down(fiz, offset);
            #endif
        }

        if (cii == 0) {
            sci_f[CL_X_OFFSET + ai] += fix;
            sci_f[CL_Y_OFFSET + ai] += fiy;
            sci_f[CL_Z_OFFSET + ai] += fiz;
        }
        #else
        atomicAdd(&sci_f[CL_X_OFFSET + ai], fx_acc[sci_ci]);
        atomicAdd(&sci_f[CL_Y_OFFSET + ai], fy_acc[sci_ci]);
        atomicAdd(&sci_f[CL_Z_OFFSET + ai], fz_acc[sci_ci]);
        #endif
    }
}

__global__ void cudaUpdatePbcSup_warp(MD_FLOAT* cuda_cl_x,
    int* cuda_border_map,
    int* cuda_jclusters_natoms,
    int* cuda_PBCx,
    int* cuda_PBCy,
    int* cuda_PBCz,
    int Nclusters_local,
    int Nclusters_ghost,
    MD_FLOAT param_xprd,
    MD_FLOAT param_yprd,
    MD_FLOAT param_zprd) {

    int cg = blockDim.x * blockIdx.x + threadIdx.x;
    if (cg >= Nclusters_ghost) {
        return;
    }

    int ncj             = Nclusters_local * SCLUSTER_SIZE;
    int cj              = ncj + cg;
    int cj_vec_base     = CJ_VECTOR_BASE_INDEX(cj);
    int bmap_vec_base   = CJ_VECTOR_BASE_INDEX(cuda_border_map[cg]);
    MD_FLOAT* cj_x      = &cuda_cl_x[cj_vec_base];
    MD_FLOAT* bmap_x    = &cuda_cl_x[bmap_vec_base];

    for (int cjj = 0; cjj < CLUSTER_N; cjj++) {
        cj_x[CL_X_OFFSET + cjj] = bmap_x[CL_X_OFFSET + cjj] + cuda_PBCx[cg] * param_xprd;
        cj_x[CL_Y_OFFSET + cjj] = bmap_x[CL_Y_OFFSET + cjj] + cuda_PBCy[cg] * param_yprd;
        cj_x[CL_Z_OFFSET + cjj] = bmap_x[CL_Z_OFFSET + cjj] + cuda_PBCz[cg] * param_zprd;
    }
}

extern "C" double computeForceLJCudaSup(Parameter* param, Atom* atom, Neighbor* neighbor, Stats* stats) {
    DEBUG_MESSAGE("computeForceLJCudaSup start\r\n");

    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6     = param->sigma6;
    MD_FLOAT epsilon    = param->epsilon;

    memsetGPU(cuda_cl_f, 0, atom->Nclusters_max * CLUSTER_M * SCLUSTER_SIZE * 3 * sizeof(MD_FLOAT));
    dim3 block_size       = dim3(CLUSTER_M, CLUSTER_N, 1);
    dim3 grid_size        = dim3(atom->Nclusters_local, 1, 1);
    double S              = getTimeStamp();
    LIKWID_MARKER_START("force");

    computeForceLJCudaSup_warp<<<grid_size, block_size>>>(cuda_cl_x,
        cuda_cl_f,
        atom->Nclusters_local,
        cuda_numneigh,
        cuda_neighbors,
        neighbor->half_neigh,
        neighbor->maxneighs,
        cutforcesq,
        sigma6,
        epsilon);

    cuda_assert("computeForceLJCudaSup", cudaPeekAtLastError());
    cuda_assert("computeForceLJCudaSup", cudaDeviceSynchronize());

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();
    DEBUG_MESSAGE("computeForceLJCudaSup stop\r\n");
    return E - S;
}
