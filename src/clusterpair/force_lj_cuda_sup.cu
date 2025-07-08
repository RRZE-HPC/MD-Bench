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
extern int* cuda_nclusters;
}

__global__ void cudaInitialIntegrateSup_warp(MD_FLOAT* cuda_cl_x,
    MD_FLOAT* cuda_cl_v,
    MD_FLOAT* cuda_cl_f,
    int* cuda_nclusters,
    int* cuda_natoms,
    int Nclusters_local,
    MD_FLOAT dtforce,
    MD_FLOAT dt) {

    int sci = blockDim.x * blockIdx.x + threadIdx.x;
    int ci = threadIdx.y;
    int cii = threadIdx.z;

    if (sci >= Nclusters_local) {
        return;
    }

    int sci_vec_base = SCI_VECTOR_BASE_INDEX(sci);
    int i            = ci * CLUSTER_M + cii;
    MD_FLOAT* ci_x   = &cuda_cl_x[sci_vec_base];
    MD_FLOAT* ci_v   = &cuda_cl_v[sci_vec_base];
    MD_FLOAT* ci_f   = &cuda_cl_f[sci_vec_base];

    ci_v[SCL_X_OFFSET + i] += dtforce * ci_f[SCL_X_OFFSET + i];
    ci_v[SCL_Y_OFFSET + i] += dtforce * ci_f[SCL_Y_OFFSET + i];
    ci_v[SCL_Z_OFFSET + i] += dtforce * ci_f[SCL_Z_OFFSET + i];
    ci_x[SCL_X_OFFSET + i] += dt * ci_v[SCL_X_OFFSET + i];
    ci_x[SCL_Y_OFFSET + i] += dt * ci_v[SCL_Y_OFFSET + i];
    ci_x[SCL_Z_OFFSET + i] += dt * ci_v[SCL_Z_OFFSET + i];
}

__global__ void cudaFinalIntegrateSup_warp(MD_FLOAT* cuda_cl_v,
    MD_FLOAT* cuda_cl_f,
    int* cuda_nclusters,
    int* cuda_natoms,
    int Nclusters_local,
    MD_FLOAT dtforce) {

    int sci = blockDim.x * blockIdx.x + threadIdx.x;
    int ci = threadIdx.y;
    int cii = threadIdx.z;

    if (sci >= Nclusters_local) {
        return;
    }

    int sci_vec_base = SCI_VECTOR_BASE_INDEX(sci);
    int i            = ci * CLUSTER_M + cii;
    MD_FLOAT* ci_v   = &cuda_cl_v[sci_vec_base];
    MD_FLOAT* ci_f   = &cuda_cl_f[sci_vec_base];

    ci_v[SCL_X_OFFSET + i] += dtforce * ci_f[SCL_X_OFFSET + i];
    ci_v[SCL_Y_OFFSET + i] += dtforce * ci_f[SCL_Y_OFFSET + i];
    ci_v[SCL_Z_OFFSET + i] += dtforce * ci_f[SCL_Z_OFFSET + i];
}

__global__ void computeForceLJCudaSup_warp(MD_FLOAT* cuda_cl_x,
    MD_FLOAT* cuda_cl_f,
    int* cuda_nclusters,
    int Nclusters_local,
    int* cuda_numneigh,
    int* cuda_neighs,
    int half_neigh,
    int maxneighs,
    MD_FLOAT cutforcesq,
    MD_FLOAT sigma6,
    MD_FLOAT epsilon) {

    int sci = blockIdx.x;
    //int ci = sci * SCLUSTER_SIZE + threadIdx.y;
    int cii = threadIdx.x;
    int cjj = threadIdx.y;

    if ((sci >= Nclusters_local) || (cii >= CLUSTER_M) || (cjj >= CLUSTER_N)) {
        return;
    }

    int sci_vec_base = SCI_VECTOR_BASE_INDEX(sci);

    for (int k = 0; k < cuda_numneigh[sci]; k++) {
        int cj = cuda_neighs[sci * maxneighs + k];
        int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
        MD_FLOAT* cj_x  = &cuda_cl_x[cj_vec_base];
        MD_FLOAT* cj_f  = &cuda_cl_f[cj_vec_base];
        MD_FLOAT xjtmp = cj_x[SCL_X_OFFSET + cjj];
        MD_FLOAT yjtmp = cj_x[SCL_Y_OFFSET + cjj];
        MD_FLOAT zjtmp = cj_x[SCL_Z_OFFSET + cjj];

        for(int ci = 0; ci < cuda_nclusters[sci]; ci++) {
            int cond = cj / SCLUSTER_SIZE != sci ||
                    threadIdx.y != cj % SCLUSTER_SIZE ||
                    threadIdx.x != cjj;

            if (cond) {
                MD_FLOAT* ci_x  = &cuda_cl_x[sci_vec_base + ci * CLUSTER_M];
                MD_FLOAT* ci_f  = &cuda_cl_f[sci_vec_base + ci * CLUSTER_M];
                MD_FLOAT delx   = ci_x[SCL_X_OFFSET + cii] - xjtmp;
                MD_FLOAT dely   = ci_x[SCL_Y_OFFSET + cii] - yjtmp;
                MD_FLOAT delz   = ci_x[SCL_Z_OFFSET + cii] - zjtmp;
                MD_FLOAT rsq    = delx * delx + dely * dely + delz * delz;

                if (rsq < cutforcesq) {
                    MD_FLOAT sr2   = (MD_FLOAT)1.0 / rsq;
                    MD_FLOAT sr6   = sr2 * sr2 * sr2 * sigma6;
                    MD_FLOAT force = (MD_FLOAT)48.0 * sr6 * (sr6 - (MD_FLOAT)0.5) * sr2 * epsilon;

                    if (half_neigh) {
                        atomicAdd(&cj_f[SCL_X_OFFSET + cjj], -delx * force);
                        atomicAdd(&cj_f[SCL_Y_OFFSET + cjj], -dely * force);
                        atomicAdd(&cj_f[SCL_Z_OFFSET + cjj], -delz * force);
                    }

                    atomicAdd(&ci_f[SCL_X_OFFSET + cii], delx * force);
                    atomicAdd(&ci_f[SCL_Y_OFFSET + cii], dely * force);
                    atomicAdd(&ci_f[SCL_Z_OFFSET + cii], delz * force);
                }
            }
        }
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
    MD_FLOAT param_zprd)
{
    int cg = blockDim.x * blockIdx.x + threadIdx.x;
    if (cg >= Nclusters_ghost) return;

    // int jfac = MAX(1, CLUSTER_N / CLUSTER_M);
    int jfac      = SCLUSTER_SIZE / CLUSTER_M;
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
        cuda_nclusters,
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
    DEBUG_MESSAGE("computeForceCudaSup stop\r\n");
    return E - S;
}
