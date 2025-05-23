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
    extern MD_FLOAT *cuda_cl_x;
    extern MD_FLOAT *cuda_cl_v;
    extern MD_FLOAT *cuda_cl_f;
    extern int *cuda_neighbors;
    extern int *cuda_numneigh;
    extern int *cuda_natoms;
    extern int *natoms;
    extern int *ngatoms;
    extern int *cuda_border_map;
    extern int *cuda_jclusters_natoms;
    extern MD_FLOAT *cuda_bbminx, *cuda_bbmaxx;
    extern MD_FLOAT *cuda_bbminy, *cuda_bbmaxy;
    extern MD_FLOAT *cuda_bbminz, *cuda_bbmaxz;
    extern int *cuda_PBCx, *cuda_PBCy, *cuda_PBCz;
    extern int isReneighboured;

    extern int *cuda_iclusters;
    extern int *cuda_nclusters;

    extern MD_FLOAT *cuda_scl_x;
    extern MD_FLOAT *cuda_scl_v;
    extern MD_FLOAT *cuda_scl_f;
}

extern "C"
void alignDataToSuperclusters(Atom *atom) {
    for (int sci = 0; sci < atom->Nsclusters_local; sci++) {
        const unsigned int scl_offset = sci * SCLUSTER_SIZE * 3 * CLUSTER_M;

        for (int ci = 0, scci = scl_offset; ci < atom->siclusters[sci].nclusters; ci++, scci += CLUSTER_M) {

            MD_FLOAT *ci_x = &atom->cl_x[CI_VECTOR_BASE_INDEX(atom->icluster_idx[SCLUSTER_SIZE * sci + ci])];
            MD_FLOAT *ci_v = &atom->cl_v[CI_VECTOR_BASE_INDEX(atom->icluster_idx[SCLUSTER_SIZE * sci + ci])];
            MD_FLOAT *ci_f = &atom->cl_f[CI_VECTOR_BASE_INDEX(atom->icluster_idx[SCLUSTER_SIZE * sci + ci])];

            /*
            MD_FLOAT *ci_x = &atom->cl_x[CI_VECTOR_BASE_INDEX(atom->siclusters[sci].iclusters[ci])];
            MD_FLOAT *ci_v = &atom->cl_v[CI_VECTOR_BASE_INDEX(atom->siclusters[sci].iclusters[ci])];
            MD_FLOAT *ci_f = &atom->cl_f[CI_VECTOR_BASE_INDEX(atom->siclusters[sci].iclusters[ci])];
             */

            memcpy(&atom->scl_x[scci], &ci_x[0], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&atom->scl_x[scci + SCLUSTER_SIZE * CLUSTER_M], &ci_x[0 + CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&atom->scl_x[scci + 2 * SCLUSTER_SIZE * CLUSTER_M], &ci_x[0 + 2 * CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));

            memcpy(&atom->scl_v[scci], &ci_v[0], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&atom->scl_v[scci + SCLUSTER_SIZE * CLUSTER_M], &ci_v[0 + CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&atom->scl_v[scci + 2 * SCLUSTER_SIZE * CLUSTER_M], &ci_v[0 + 2 * CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));

            memcpy(&atom->scl_f[scci], &ci_f[0], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&atom->scl_f[scci + SCLUSTER_SIZE * CLUSTER_M], &ci_f[0 + CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&atom->scl_f[scci + 2 * SCLUSTER_SIZE * CLUSTER_M], &ci_f[0 + 2 * CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));

        }
    }
}

extern "C"
void alignDataFromSuperclusters(Atom *atom) {
    for (int sci = 0; sci < atom->Nsclusters_local; sci++) {
        const unsigned int scl_offset = sci * SCLUSTER_SIZE * 3 * CLUSTER_M;

        for (int ci = 0, scci = scl_offset; ci < atom->siclusters[sci].nclusters; ci++, scci += CLUSTER_M) {


            MD_FLOAT *ci_x = &atom->cl_x[CI_VECTOR_BASE_INDEX(atom->icluster_idx[SCLUSTER_SIZE * sci + ci])];
            MD_FLOAT *ci_v = &atom->cl_v[CI_VECTOR_BASE_INDEX(atom->icluster_idx[SCLUSTER_SIZE * sci + ci])];
            MD_FLOAT *ci_f = &atom->cl_f[CI_VECTOR_BASE_INDEX(atom->icluster_idx[SCLUSTER_SIZE * sci + ci])];

            /*
            MD_FLOAT *ci_x = &atom->cl_x[CI_VECTOR_BASE_INDEX(atom->siclusters[sci].iclusters[ci])];
            MD_FLOAT *ci_v = &atom->cl_v[CI_VECTOR_BASE_INDEX(atom->siclusters[sci].iclusters[ci])];
            MD_FLOAT *ci_f = &atom->cl_f[CI_VECTOR_BASE_INDEX(atom->siclusters[sci].iclusters[ci])];
             */

            memcpy(&ci_x[0], &atom->scl_x[scci], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&ci_x[0 + CLUSTER_M], &atom->scl_x[scci + SCLUSTER_SIZE * CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&ci_x[0 + 2 * CLUSTER_M], &atom->scl_x[scci + 2 * SCLUSTER_SIZE * CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));

            memcpy(&ci_v[0], &atom->scl_v[scci], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&ci_v[0 + CLUSTER_M], &atom->scl_v[scci + SCLUSTER_SIZE * CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&ci_v[0 + 2 * CLUSTER_M], &atom->scl_v[scci + 2 * SCLUSTER_SIZE * CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));

            memcpy(&ci_f[0], &atom->scl_f[scci], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&ci_f[0 + CLUSTER_M], &atom->scl_f[scci + SCLUSTER_SIZE * CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));
            memcpy(&ci_f[0 + 2 * CLUSTER_M], &atom->scl_f[scci + 2 * SCLUSTER_SIZE * CLUSTER_M], CLUSTER_M * sizeof(MD_FLOAT));

        }
    }
}

__global__ void cudaInitialIntegrateSup_warp(MD_FLOAT *cuda_cl_x, MD_FLOAT *cuda_cl_v, MD_FLOAT *cuda_cl_f,
                                             int *cuda_nclusters,
                                             int *cuda_natoms,
                                             int Nsclusters_local, MD_FLOAT dtforce, MD_FLOAT dt) {

    unsigned int sci_pos = blockDim.x * blockIdx.x + threadIdx.x;
    //unsigned int cii_pos = blockDim.y * blockIdx.y + threadIdx.y;
    if (sci_pos >= Nsclusters_local) return;

    //unsigned int ci_pos = cii_pos / CLUSTER_M;
    //unsigned int scii_pos = cii_pos % CLUSTER_M;

    //if (ci_pos >= cuda_nclusters[sci_pos]) return;
    //if (scii_pos >= cuda_natoms[ci_pos]) return;

    int ci_vec_base = SCI_VECTOR_BASE_INDEX(sci_pos);
    MD_FLOAT *ci_x = &cuda_cl_x[ci_vec_base];
    MD_FLOAT *ci_v = &cuda_cl_v[ci_vec_base];
    MD_FLOAT *ci_f = &cuda_cl_f[ci_vec_base];

    for (int scii_pos = 0; scii_pos < SCLUSTER_M; scii_pos++) {
        ci_v[SCL_X_OFFSET + scii_pos] += dtforce * ci_f[SCL_X_OFFSET + scii_pos];
        ci_v[SCL_Y_OFFSET + scii_pos] += dtforce * ci_f[SCL_Y_OFFSET + scii_pos];
        ci_v[SCL_Z_OFFSET + scii_pos] += dtforce * ci_f[SCL_Z_OFFSET + scii_pos];
        ci_x[SCL_X_OFFSET + scii_pos] += dt * ci_v[SCL_X_OFFSET + scii_pos];
        ci_x[SCL_Y_OFFSET + scii_pos] += dt * ci_v[SCL_Y_OFFSET + scii_pos];
        ci_x[SCL_Z_OFFSET + scii_pos] += dt * ci_v[SCL_Z_OFFSET + scii_pos];
    }
}

__global__ void cudaFinalIntegrateSup_warp(MD_FLOAT *cuda_cl_v, MD_FLOAT *cuda_cl_f,
                                           int *cuda_nclusters, int *cuda_natoms,
                                           int Nsclusters_local, MD_FLOAT dtforce) {

    unsigned int sci_pos = blockDim.x * blockIdx.x + threadIdx.x;
    //unsigned int cii_pos = blockDim.y * blockIdx.y + threadIdx.y;
    if (sci_pos >= Nsclusters_local) return;

    //unsigned int ci_pos = cii_pos / CLUSTER_M;
    //unsigned int scii_pos = cii_pos % CLUSTER_M;

    //if (ci_pos >= cuda_nclusters[sci_pos]) return;
    //if (scii_pos >= cuda_natoms[ci_pos]) return;

    int ci_vec_base = SCI_VECTOR_BASE_INDEX(sci_pos);
    MD_FLOAT *ci_v = &cuda_cl_v[ci_vec_base];
    MD_FLOAT *ci_f = &cuda_cl_f[ci_vec_base];

    for (int scii_pos = 0; scii_pos < SCLUSTER_M; scii_pos++) {
        ci_v[SCL_X_OFFSET + scii_pos] += dtforce * ci_f[SCL_X_OFFSET + scii_pos];
        ci_v[SCL_Y_OFFSET + scii_pos] += dtforce * ci_f[SCL_Y_OFFSET + scii_pos];
        ci_v[SCL_Z_OFFSET + scii_pos] += dtforce * ci_f[SCL_Z_OFFSET + scii_pos];
    }

}

__global__ void computeForceLJSup_cuda_warp(MD_FLOAT *cuda_cl_x, MD_FLOAT *cuda_cl_f,
                                            int *cuda_nclusters, int *cuda_iclusters,
                                            int Nsclusters_local,
                                            int *cuda_numneigh, int *cuda_neighs, int half_neigh, int maxneighs,
                                            MD_FLOAT cutforcesq, MD_FLOAT sigma6, MD_FLOAT epsilon) {

    unsigned int sci_pos = blockDim.x * blockIdx.x + threadIdx.x;
    unsigned int scii_pos = blockDim.y * blockIdx.y + threadIdx.y;
    unsigned int cjj_pos = blockDim.z * blockIdx.z + threadIdx.z;
    if ((sci_pos >= Nsclusters_local) || (scii_pos >= SCLUSTER_M) || (cjj_pos >= CLUSTER_N)) return;

    unsigned int ci_pos = scii_pos / CLUSTER_M;
    unsigned int cii_pos = scii_pos % CLUSTER_M;

    if (ci_pos >= cuda_nclusters[sci_pos]) return;

    //int ci_cj0 = CJ0_FROM_CI(ci_pos);
    int ci_vec_base = SCI_VECTOR_BASE_INDEX(sci_pos);
    MD_FLOAT *ci_x = &cuda_cl_x[ci_vec_base];
    MD_FLOAT *ci_f = &cuda_cl_f[ci_vec_base];


    //int numneighs = cuda_numneigh[ci_pos];
    int numneighs = cuda_numneigh[cuda_iclusters[SCLUSTER_SIZE * sci_pos + ci_pos]];

    for(int k = 0; k < numneighs; k++) {
        int glob_j = (&cuda_neighs[cuda_iclusters[SCLUSTER_SIZE * sci_pos + ci_pos] * maxneighs])[k];
        int scj = glob_j / SCLUSTER_SIZE;
        // TODO Make cj accessible from super cluster data alignment (not reachable right now)
        int cj = SCJ_VECTOR_BASE_INDEX(scj) + CLUSTER_M * (glob_j % SCLUSTER_SIZE);
        int cj_vec_base = cj;
        MD_FLOAT *cj_x = &cuda_cl_x[cj_vec_base];
        MD_FLOAT *cj_f = &cuda_cl_f[cj_vec_base];

        MD_FLOAT xtmp = ci_x[SCL_CL_X_OFFSET(ci_pos) + cii_pos];
        MD_FLOAT ytmp = ci_x[SCL_CL_Y_OFFSET(ci_pos) + cii_pos];
        MD_FLOAT ztmp = ci_x[SCL_CL_Z_OFFSET(ci_pos) + cii_pos];
        MD_FLOAT fix = 0;
        MD_FLOAT fiy = 0;
        MD_FLOAT fiz = 0;


        //int cond = ci_cj0 != cj || cii_pos != cjj_pos || scj != sci_pos;
        int cond = (glob_j != cuda_iclusters[SCLUSTER_SIZE * sci_pos + ci_pos] && cii_pos != cjj_pos);

        if(cond) {
            MD_FLOAT delx = xtmp - cj_x[SCL_CL_X_OFFSET(ci_pos) + cjj_pos];
            MD_FLOAT dely = ytmp - cj_x[SCL_CL_Y_OFFSET(ci_pos) + cjj_pos];
            MD_FLOAT delz = ztmp - cj_x[SCL_CL_Z_OFFSET(ci_pos) + cjj_pos];
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;
            if(rsq < cutforcesq) {
                MD_FLOAT sr2 = 1.0 / rsq;
                MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
                MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;

                if(half_neigh) {
                    atomicAdd(&cj_f[SCL_CL_X_OFFSET(ci_pos) + cjj_pos], -delx * force);
                    atomicAdd(&cj_f[SCL_CL_Y_OFFSET(ci_pos) + cjj_pos], -dely * force);
                    atomicAdd(&cj_f[SCL_CL_Z_OFFSET(ci_pos) + cjj_pos], -delz * force);
                }

                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force;

                atomicAdd(&ci_f[SCL_CL_X_OFFSET(ci_pos) + cii_pos], fix);
                atomicAdd(&ci_f[SCL_CL_Y_OFFSET(ci_pos) + cii_pos], fiy);
                atomicAdd(&ci_f[SCL_CL_Z_OFFSET(ci_pos) + cii_pos], fiz);
            }
        }
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

extern "C"
double computeForceLJSup_cuda(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    DEBUG_MESSAGE("computeForceLJSup_cuda start\r\n");

    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;

    memsetGPU(cuda_cl_f, 0, atom->Nclusters_max * CLUSTER_M * 3 * sizeof(MD_FLOAT));
    if (isReneighboured) {

        for(int ci = 0; ci < atom->Nclusters_local; ci++) {
            memcpyToGPU(&cuda_numneigh[ci], &neighbor->numneigh[ci], sizeof(int));
            memcpyToGPU(&cuda_neighbors[ci * neighbor->maxneighs], &neighbor->neighbors[ci * neighbor->maxneighs], neighbor->numneigh[ci] * sizeof(int));
        }

        for(int sci = 0; sci < atom->Nsclusters_local; sci++) {
            memcpyToGPU(&cuda_nclusters[sci], &atom->siclusters[sci].nclusters, sizeof(int));
            //memcpyToGPU(&cuda_iclusters[sci * SCLUSTER_SIZE], &atom->siclusters[sci].iclusters, sizeof(int) * atom->siclusters[sci].nclusters);
        }

        memcpyToGPU(cuda_iclusters, atom->icluster_idx, atom->Nsclusters_max * SCLUSTER_SIZE * sizeof(int));

        isReneighboured = 0;
    }

    const int threads_num = 1;
    dim3 block_size = dim3(threads_num, SCLUSTER_M, CLUSTER_N);
    dim3 grid_size = dim3(atom->Nsclusters_local/threads_num+1, 1, 1);
    double S = getTimeStamp();
    LIKWID_MARKER_START("force");
    computeForceLJSup_cuda_warp<<<grid_size, block_size>>>(cuda_scl_x, cuda_scl_f,
                                                           cuda_nclusters, cuda_iclusters,
                                                           atom->Nsclusters_local,
                                                           cuda_numneigh, cuda_neighbors,
                                                           neighbor->half_neigh, neighbor->maxneighs, cutforcesq,
                                                           sigma6, epsilon);
    cuda_assert("computeForceLJ_cuda", cudaPeekAtLastError());
    cuda_assert("computeForceLJ_cuda", cudaDeviceSynchronize());
    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();
    DEBUG_MESSAGE("computeForceLJSup_cuda stop\r\n");
    return E-S;
}
