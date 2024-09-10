/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>

#include <atom.h>
#include <force.h>
#include <likwid-marker.h>
#include <math.h>
#include <neighbor.h>
#include <parameter.h>
#include <simd.h>
#include <stats.h>
#include <timing.h>
#include <util.h>

void computeForceGhostShell(Parameter*, Atom*, Neighbor*);
/*
static inline void gmx_load_simd_2xnn_interactions(
    int excl,
    MD_SIMD_BITMASK filter0, MD_SIMD_BITMASK filter2,
    MD_SIMD_MASK *interact0, MD_SIMD_MASK *interact2) {

    //SimdInt32 mask_pr_S(excl);
    MD_SIMD_INT32 mask_pr_S = simd_int32_broadcast(excl);
    *interact0 = cvtIB2B(simd_test_bits(mask_pr_S & filter0));
    *interact2 = cvtIB2B(simd_test_bits(mask_pr_S & filter2));
}

static inline void gmx_load_simd_4xn_interactions(
    int excl,
    MD_SIMD_BITMASK filter0, MD_SIMD_BITMASK filter1, MD_SIMD_BITMASK filter2,
MD_SIMD_BITMASK filter3, MD_SIMD_MASK *interact0, MD_SIMD_MASK *interact1, MD_SIMD_MASK
*interact2, MD_SIMD_MASK *interact3) {

    //SimdInt32 mask_pr_S(excl);
    MD_SIMD_INT32 mask_pr_S = simd_int32_broadcast(excl);
    *interact0 = cvtIB2B(simd_test_bits(mask_pr_S & filter0));
    *interact1 = cvtIB2B(simd_test_bits(mask_pr_S & filter1));
    *interact2 = cvtIB2B(simd_test_bits(mask_pr_S & filter2));
    *interact3 = cvtIB2B(simd_test_bits(mask_pr_S & filter3));
}
*/
#ifdef USE_REFERENCE_VERSION
double computeForceLJRef(Parameter* param, Atom* atom, Neighbor* neighbor, Stats* stats)
{
    DEBUG_MESSAGE("computeForceLJ begin\n");
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6     = param->sigma6;
    MD_FLOAT epsilon    = param->epsilon;
    for (int ci = 0; ci < atom->Nclusters_local; ci++) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ci_f  = &atom->cl_f[ci_vec_base];
        for (int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
            ci_f[CL_X_OFFSET + cii] = 0.0;
            ci_f[CL_Y_OFFSET + cii] = 0.0;
            ci_f[CL_Z_OFFSET + cii] = 0.0;
        }
    }

    for (int cg = atom->ncj; cg < atom->ncj + atom->Nclusters_ghost; cg++) {
        int cj_vec_base = CJ_VECTOR_BASE_INDEX(cg);
        MD_FLOAT* cj_f  = &atom->cl_f[cj_vec_base];
        for (int cjj = 0; cjj < atom->jclusters[cg].natoms; cjj++) {
            cj_f[CL_X_OFFSET + cjj] = 0.0;
            cj_f[CL_Y_OFFSET + cjj] = 0.0;
            cj_f[CL_Z_OFFSET + cjj] = 0.0;
        }
    }

    double S = getTimeStamp();

#pragma omp parallel
    {
        LIKWID_MARKER_START("force");

#pragma omp for schedule(runtime)
        for (int ci = 0; ci < atom->Nclusters_local; ci++) {
            int ci_cj0      = CJ0_FROM_CI(ci);
            int ci_cj1      = CJ1_FROM_CI(ci);
            int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
            MD_FLOAT* ci_x  = &atom->cl_x[ci_vec_base];
            MD_FLOAT* ci_f  = &atom->cl_f[ci_vec_base];
            neighs          = &neighbor->neighbors[ci * neighbor->maxneighs];
            int numneighs   = neighbor->numneigh[ci];

            for (int k = 0; k < numneighs; k++) {
                int cj          = neighs[k];
                int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
                int any         = 0;
                MD_FLOAT* cj_x  = &atom->cl_x[cj_vec_base];
                MD_FLOAT* cj_f  = &atom->cl_f[cj_vec_base];
                // if(ci>atom->Nclusters_local) printf("Ci is bigger k:%d ci:%d cj:%d
                // ncj:%d ghost:%d ghost+ncj:%d\n",k,ci,cj, atom->ncj,
                // atom->Nclusters_ghost,atom->ncj+atom->Nclusters_ghost);
                // if(cj>atom->ncj+atom->Nclusters_ghost) printf("Cj is bigger k:%d ci:%d
                // cj:%d ncj:%d ghost:%d ghost+ncj:%d\n",k,ci,cj, atom->ncj,
                // atom->Nclusters_ghost,atom->ncj+atom->Nclusters_ghost);
                for (int cii = 0; cii < CLUSTER_M; cii++) {
                    MD_FLOAT xtmp = ci_x[CL_X_OFFSET + cii];
                    MD_FLOAT ytmp = ci_x[CL_Y_OFFSET + cii];
                    MD_FLOAT ztmp = ci_x[CL_Z_OFFSET + cii];
                    MD_FLOAT fix  = 0;
                    MD_FLOAT fiy  = 0;
                    MD_FLOAT fiz  = 0;
                    for (int cjj = 0; cjj < CLUSTER_N; cjj++) {
                        int cond;
#if CLUSTER_M == CLUSTER_N
                        cond = neighbor->half_neigh ? (ci_cj0 != cj || cii < cjj)
                                                    : (ci_cj0 != cj || cii != cjj);
#elif CLUSTER_M < CLUSTER_N
                        cond = neighbor->half_neigh
                                   ? (ci_cj0 != cj || cii + CLUSTER_M * (ci & 0x1) < cjj)
                                   : (ci_cj0 != cj ||
                                         cii + CLUSTER_M * (ci & 0x1) != cjj);
#else
                        cond = neighbor->half_neigh
                                   ? (ci_cj0 != cj || cii < cjj) &&
                                         (ci_cj1 != cj || cii < cjj + CLUSTER_N)
                                   : (ci_cj0 != cj || cii != cjj) &&
                                         (ci_cj1 != cj || cii != cjj + CLUSTER_N);
#endif

                        if (cond) {
                            MD_FLOAT delx = xtmp - cj_x[CL_X_OFFSET + cjj];
                            MD_FLOAT dely = ytmp - cj_x[CL_Y_OFFSET + cjj];
                            MD_FLOAT delz = ztmp - cj_x[CL_Z_OFFSET + cjj];
                            MD_FLOAT rsq  = delx * delx + dely * dely + delz * delz;

                            if (rsq < cutforcesq) {
                                MD_FLOAT sr2   = 1.0 / rsq;
                                MD_FLOAT sr6   = sr2 * sr2 * sr2 * sigma6;
                                MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;

                                if (neighbor->half_neigh || param->method) {
                                    cj_f[CL_X_OFFSET + cjj] -= delx * force;
                                    cj_f[CL_Y_OFFSET + cjj] -= dely * force;
                                    cj_f[CL_Z_OFFSET + cjj] -= delz * force;
                                }

                                fix += delx * force;
                                fiy += dely * force;
                                fiz += delz * force;
                                any = 1;
                                addStat(stats->atoms_within_cutoff, 1);
                            } else {
                                addStat(stats->atoms_outside_cutoff, 1);
                            }
                        }
                    }
                    if (any != 0) {
                        addStat(stats->clusters_within_cutoff, 1);
                    } else {
                        addStat(stats->clusters_outside_cutoff, 1);
                    }
                    ci_f[CL_X_OFFSET + cii] += fix;
                    ci_f[CL_Y_OFFSET + cii] += fiy;
                    ci_f[CL_Z_OFFSET + cii] += fiz;
                }
            }

            addStat(stats->calculated_forces, 1);
            addStat(stats->num_neighs, numneighs);
            addStat(stats->force_iters,
                (long long int)((double)numneighs * CLUSTER_M / CLUSTER_N));
        }
        if (param->method == eightShell) {
            computeForceGhostShell(param, atom, neighbor);
        }
        LIKWID_MARKER_STOP("force");
    }

    double E = getTimeStamp();
    DEBUG_MESSAGE("computeForceLJ end\n");
    return E - S;
}
#else
double computeForceLJ2xnnHalfNeigh(
    Parameter* param, Atom* atom, Neighbor* neighbor, Stats* stats)
{
    DEBUG_MESSAGE("computeForceLJ_2xnn begin\n");
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT cutforcesq          = param->cutforce * param->cutforce;
    MD_FLOAT sigma6              = param->sigma6;
    MD_FLOAT epsilon             = param->epsilon;
    MD_SIMD_FLOAT cutforcesq_vec = simd_broadcast(cutforcesq);
    MD_SIMD_FLOAT sigma6_vec     = simd_broadcast(sigma6);
    MD_SIMD_FLOAT eps_vec        = simd_broadcast(epsilon);
    MD_SIMD_FLOAT c48_vec        = simd_broadcast(48.0);
    MD_SIMD_FLOAT c05_vec        = simd_broadcast(0.5);

    for (int ci = 0; ci < atom->Nclusters_local + atom->Nclusters_ghost; ci++) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ci_f  = &atom->cl_f[ci_vec_base];
        for (int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
            ci_f[CL_X_OFFSET + cii] = 0.0;
            ci_f[CL_Y_OFFSET + cii] = 0.0;
            ci_f[CL_Z_OFFSET + cii] = 0.0;
        }
    }

    for (int cg = atom->ncj; cg < atom->ncj + atom->Nclusters_ghost; cg++) {
        int cj_vec_base = CJ_VECTOR_BASE_INDEX(cg);
        MD_FLOAT* cj_f  = &atom->cl_f[cj_vec_base];
        for (int cjj = 0; cjj < atom->jclusters[cg].natoms; cjj++) {
            cj_f[CL_X_OFFSET + cjj] = 0.0;
            cj_f[CL_Y_OFFSET + cjj] = 0.0;
            cj_f[CL_Z_OFFSET + cjj] = 0.0;
        }
    }

    double S = getTimeStamp();

#pragma omp parallel
    {
        LIKWID_MARKER_START("force");

        /*
        MD_SIMD_BITMASK filter0 = simd_load_bitmask((const int *)
        &atom->exclusion_filter[0 * (VECTOR_WIDTH / UNROLL_J)]); MD_SIMD_BITMASK filter2 =
        simd_load_bitmask((const int *) &atom->exclusion_filter[2 * (VECTOR_WIDTH /
        UNROLL_J)]);

        MD_SIMD_FLOAT diagonal_jmi_S = simd_load(atom->diagonal_2xnn_j_minus_i);
        MD_SIMD_FLOAT zero_S = simd_broadcast(0.0);
        MD_SIMD_FLOAT one_S = simd_broadcast(1.0);

        #if CLUSTER_M <= CLUSTER_N
        MD_SIMD_MASK diagonal_mask0, diagonal_mask2;
        diagonal_mask0 = simd_mask_cond_lt(zero_S, diagonal_jmi_S);
        diagonal_jmi_S = diagonal_jmi_S - one_S;
        diagonal_jmi_S = diagonal_jmi_S - one_S;
        diagonal_mask2 = simd_mask_cond_lt(zero_S, diagonal_jmi_S);
        #else
        MD_SIMD_MASK diagonal_mask00, diagonal_mask02, diagonal_mask10, diagonal_mask12;
        diagonal_mask00 = simd_mask_cond_lt(zero_S, diagonal_jmi_S);
        diagonal_jmi_S = diagonal_jmi_S - one_S;
        diagonal_jmi_S = diagonal_jmi_S - one_S;
        diagonal_mask02 = simd_mask_cond_lt(zero_S, diagonal_jmi_S);
        diagonal_jmi_S = diagonal_jmi_S - one_S;
        diagonal_jmi_S = diagonal_jmi_S - one_S;
        diagonal_mask10 = simd_mask_cond_lt(zero_S, diagonal_jmi_S);
        diagonal_jmi_S = diagonal_jmi_S - one_S;
        diagonal_jmi_S = diagonal_jmi_S - one_S;
        diagonal_mask12 = simd_mask_cond_lt(zero_S, diagonal_jmi_S);
        #endif
        */

#pragma omp for schedule(runtime)
        for (int ci = 0; ci < atom->Nclusters_local; ci++) {
            int ci_cj0 = CJ0_FROM_CI(ci);
#if CLUSTER_M > CLUSTER_N
            int ci_cj1 = CJ1_FROM_CI(ci);
#endif
            int ci_vec_base      = CI_VECTOR_BASE_INDEX(ci);
            MD_FLOAT* ci_x       = &atom->cl_x[ci_vec_base];
            MD_FLOAT* ci_f       = &atom->cl_f[ci_vec_base];
            neighs               = &neighbor->neighbors[ci * neighbor->maxneighs];
            int numneighs        = neighbor->numneigh[ci];
            int numneighs_masked = neighbor->numneigh_masked[ci];

            MD_SIMD_FLOAT xi0_tmp = simd_load_h_dual(&ci_x[CL_X_OFFSET + 0]);
            MD_SIMD_FLOAT xi2_tmp = simd_load_h_dual(&ci_x[CL_X_OFFSET + 2]);
            MD_SIMD_FLOAT yi0_tmp = simd_load_h_dual(&ci_x[CL_Y_OFFSET + 0]);
            MD_SIMD_FLOAT yi2_tmp = simd_load_h_dual(&ci_x[CL_Y_OFFSET + 2]);
            MD_SIMD_FLOAT zi0_tmp = simd_load_h_dual(&ci_x[CL_Z_OFFSET + 0]);
            MD_SIMD_FLOAT zi2_tmp = simd_load_h_dual(&ci_x[CL_Z_OFFSET + 2]);
            MD_SIMD_FLOAT fix0    = simd_zero();
            MD_SIMD_FLOAT fiy0    = simd_zero();
            MD_SIMD_FLOAT fiz0    = simd_zero();
            MD_SIMD_FLOAT fix2    = simd_zero();
            MD_SIMD_FLOAT fiy2    = simd_zero();
            MD_SIMD_FLOAT fiz2    = simd_zero();

            for (int k = 0; k < numneighs_masked; k++) {
                int cj          = neighs[k];
                int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
                // int imask = neighs_imask[k];
                MD_FLOAT* cj_x = &atom->cl_x[cj_vec_base];
                MD_FLOAT* cj_f = &atom->cl_f[cj_vec_base];
                // MD_SIMD_MASK interact0;
                // MD_SIMD_MASK interact2;

                // gmx_load_simd_2xnn_interactions((int)imask, filter0, filter2,
                // &interact0, &interact2);

                MD_SIMD_FLOAT xj_tmp = simd_load_h_duplicate(&cj_x[CL_X_OFFSET]);
                MD_SIMD_FLOAT yj_tmp = simd_load_h_duplicate(&cj_x[CL_Y_OFFSET]);
                MD_SIMD_FLOAT zj_tmp = simd_load_h_duplicate(&cj_x[CL_Z_OFFSET]);
                MD_SIMD_FLOAT delx0  = xi0_tmp - xj_tmp;
                MD_SIMD_FLOAT dely0  = yi0_tmp - yj_tmp;
                MD_SIMD_FLOAT delz0  = zi0_tmp - zj_tmp;
                MD_SIMD_FLOAT delx2  = xi2_tmp - xj_tmp;
                MD_SIMD_FLOAT dely2  = yi2_tmp - yj_tmp;
                MD_SIMD_FLOAT delz2  = zi2_tmp - zj_tmp;
                MD_SIMD_FLOAT rsq0   = simd_fma(delx0,
                    delx0,
                    simd_fma(dely0, dely0, delz0 * delz0));
                MD_SIMD_FLOAT rsq2   = simd_fma(delx2,
                    delx2,
                    simd_fma(dely2, dely2, delz2 * delz2));

#if CLUSTER_M == CLUSTER_N
                unsigned int cond0      = (unsigned int)(cj == ci_cj0);
                MD_SIMD_MASK excl_mask0 = simd_mask_from_u32(
                    atom->masks_2xnn_hn[cond0 * 2 + 0]);
                MD_SIMD_MASK excl_mask2 = simd_mask_from_u32(
                    atom->masks_2xnn_hn[cond0 * 2 + 1]);
#else
#if CLUSTER_M < CLUSTER_N
                unsigned int cond0 = (unsigned int)((cj << 1) + 0 == ci);
                unsigned int cond1 = (unsigned int)((cj << 1) + 1 == ci);
#else
                unsigned int cond0 = (unsigned int)(cj == ci_cj0);
                unsigned int cond1 = (unsigned int)(cj == ci_cj1);
#endif
                MD_SIMD_MASK excl_mask0 = simd_mask_from_u32(
                    atom->masks_2xnn_hn[cond0 * 4 + cond1 * 2 + 0]);
                MD_SIMD_MASK excl_mask2 = simd_mask_from_u32(
                    atom->masks_2xnn_hn[cond0 * 4 + cond1 * 2 + 1]);
#endif

                MD_SIMD_MASK cutoff_mask0 = simd_mask_cond_lt(rsq0, cutforcesq_vec);
                MD_SIMD_MASK cutoff_mask2 = simd_mask_cond_lt(rsq2, cutforcesq_vec);
                cutoff_mask0              = simd_mask_and(cutoff_mask0, excl_mask0);
                cutoff_mask2              = simd_mask_and(cutoff_mask2, excl_mask2);

                /*
                #if CLUSTER_M <= CLUSTER_N
                if(ci == ci_cj0) {
                    cutoff_mask0 = simd_mask_and(cutoff_mask0, diagonal_mask0);
                    cutoff_mask2 = simd_mask_and(cutoff_mask2, diagonal_mask2);
                }
                #else
                if(ci == ci_cj0) {
                    cutoff_mask0 = cutoff_mask0 && diagonal_mask00;
                    cutoff_mask2 = cutoff_mask2 && diagonal_mask02;
                } else if(ci == ci_cj1) {
                    cutoff_mask0 = cutoff_mask0 && diagonal_mask10;
                    cutoff_mask2 = cutoff_mask2 && diagonal_mask12;
                }
                #endif
                */

                MD_SIMD_FLOAT sr2_0  = simd_reciprocal(rsq0);
                MD_SIMD_FLOAT sr2_2  = simd_reciprocal(rsq2);
                MD_SIMD_FLOAT sr6_0  = sr2_0 * sr2_0 * sr2_0 * sigma6_vec;
                MD_SIMD_FLOAT sr6_2  = sr2_2 * sr2_2 * sr2_2 * sigma6_vec;
                MD_SIMD_FLOAT force0 = c48_vec * sr6_0 * (sr6_0 - c05_vec) * sr2_0 *
                                       eps_vec;
                MD_SIMD_FLOAT force2 = c48_vec * sr6_2 * (sr6_2 - c05_vec) * sr2_2 *
                                       eps_vec;

                MD_SIMD_FLOAT tx0 = select_by_mask(delx0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT ty0 = select_by_mask(dely0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT tz0 = select_by_mask(delz0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT tx2 = select_by_mask(delx2 * force2, cutoff_mask2);
                MD_SIMD_FLOAT ty2 = select_by_mask(dely2 * force2, cutoff_mask2);
                MD_SIMD_FLOAT tz2 = select_by_mask(delz2 * force2, cutoff_mask2);

                fix0 += tx0;
                fiy0 += ty0;
                fiz0 += tz0;
                fix2 += tx2;
                fiy2 += ty2;
                fiz2 += tz2;

#ifdef HALF_NEIGHBOR_LISTS_CHECK_CJ
                if (cj < CJ1_FROM_CI(atom->Nlocal) || param->method) {
                    simd_h_decr3(cj_f, tx0 + tx2, ty0 + ty2, tz0 + tz2);
                }
#else
                simd_h_decr3(cj_f, tx0 + tx2, ty0 + ty2, tz0 + tz2);
#endif
            }

            for (int k = numneighs_masked; k < numneighs; k++) {
                int cj          = neighs[k];
                int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
                MD_FLOAT* cj_x  = &atom->cl_x[cj_vec_base];
                MD_FLOAT* cj_f  = &atom->cl_f[cj_vec_base];

                MD_SIMD_FLOAT xj_tmp = simd_load_h_duplicate(&cj_x[CL_X_OFFSET]);
                MD_SIMD_FLOAT yj_tmp = simd_load_h_duplicate(&cj_x[CL_Y_OFFSET]);
                MD_SIMD_FLOAT zj_tmp = simd_load_h_duplicate(&cj_x[CL_Z_OFFSET]);
                MD_SIMD_FLOAT delx0  = xi0_tmp - xj_tmp;
                MD_SIMD_FLOAT dely0  = yi0_tmp - yj_tmp;
                MD_SIMD_FLOAT delz0  = zi0_tmp - zj_tmp;
                MD_SIMD_FLOAT delx2  = xi2_tmp - xj_tmp;
                MD_SIMD_FLOAT dely2  = yi2_tmp - yj_tmp;
                MD_SIMD_FLOAT delz2  = zi2_tmp - zj_tmp;
                MD_SIMD_FLOAT rsq0   = simd_fma(delx0,
                    delx0,
                    simd_fma(dely0, dely0, delz0 * delz0));
                MD_SIMD_FLOAT rsq2   = simd_fma(delx2,
                    delx2,
                    simd_fma(dely2, dely2, delz2 * delz2));

                MD_SIMD_MASK cutoff_mask0 = simd_mask_cond_lt(rsq0, cutforcesq_vec);
                MD_SIMD_MASK cutoff_mask2 = simd_mask_cond_lt(rsq2, cutforcesq_vec);

                MD_SIMD_FLOAT sr2_0  = simd_reciprocal(rsq0);
                MD_SIMD_FLOAT sr2_2  = simd_reciprocal(rsq2);
                MD_SIMD_FLOAT sr6_0  = sr2_0 * sr2_0 * sr2_0 * sigma6_vec;
                MD_SIMD_FLOAT sr6_2  = sr2_2 * sr2_2 * sr2_2 * sigma6_vec;
                MD_SIMD_FLOAT force0 = c48_vec * sr6_0 * (sr6_0 - c05_vec) * sr2_0 *
                                       eps_vec;
                MD_SIMD_FLOAT force2 = c48_vec * sr6_2 * (sr6_2 - c05_vec) * sr2_2 *
                                       eps_vec;

                MD_SIMD_FLOAT tx0 = select_by_mask(delx0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT ty0 = select_by_mask(dely0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT tz0 = select_by_mask(delz0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT tx2 = select_by_mask(delx2 * force2, cutoff_mask2);
                MD_SIMD_FLOAT ty2 = select_by_mask(dely2 * force2, cutoff_mask2);
                MD_SIMD_FLOAT tz2 = select_by_mask(delz2 * force2, cutoff_mask2);

                fix0 += tx0;
                fiy0 += ty0;
                fiz0 += tz0;
                fix2 += tx2;
                fiy2 += ty2;
                fiz2 += tz2;

#ifdef HALF_NEIGHBOR_LISTS_CHECK_CJ
                if (cj < CJ1_FROM_CI(atom->Nlocal) || param->method) {
                    simd_h_decr3(cj_f, tx0 + tx2, ty0 + ty2, tz0 + tz2);
                }
#else
                simd_h_decr3(cj_f, tx0 + tx2, ty0 + ty2, tz0 + tz2);
#endif
            }

            simd_h_dual_incr_reduced_sum(&ci_f[CL_X_OFFSET], fix0, fix2);
            simd_h_dual_incr_reduced_sum(&ci_f[CL_Y_OFFSET], fiy0, fiy2);
            simd_h_dual_incr_reduced_sum(&ci_f[CL_Z_OFFSET], fiz0, fiz2);

            addStat(stats->calculated_forces, 1);
            addStat(stats->num_neighs, numneighs);
            addStat(stats->force_iters,
                (long long int)((double)numneighs * CLUSTER_M / CLUSTER_N));
        }
        if (param->method == eightShell) {
            computeForceGhostShell(param, atom, neighbor);
        }
        LIKWID_MARKER_STOP("force");
    }

    double E = getTimeStamp();
    DEBUG_MESSAGE("computeForceLJ_2xnn end\n");
    return E - S;
}

double computeForceLJ2xnnFullNeigh(
    Parameter* param, Atom* atom, Neighbor* neighbor, Stats* stats)
{
    DEBUG_MESSAGE("computeForceLJ_2xnn begin\n");
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT cutforcesq          = param->cutforce * param->cutforce;
    MD_FLOAT sigma6              = param->sigma6;
    MD_FLOAT epsilon             = param->epsilon;
    MD_SIMD_FLOAT cutforcesq_vec = simd_broadcast(cutforcesq);
    MD_SIMD_FLOAT sigma6_vec     = simd_broadcast(sigma6);
    MD_SIMD_FLOAT eps_vec        = simd_broadcast(epsilon);
    MD_SIMD_FLOAT c48_vec        = simd_broadcast(48.0);
    MD_SIMD_FLOAT c05_vec        = simd_broadcast(0.5);

    for (int ci = 0; ci < atom->Nclusters_local; ci++) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ci_f  = &atom->cl_f[ci_vec_base];
        for (int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
            ci_f[CL_X_OFFSET + cii] = 0.0;
            ci_f[CL_Y_OFFSET + cii] = 0.0;
            ci_f[CL_Z_OFFSET + cii] = 0.0;
        }
    }
    double S = getTimeStamp();

#pragma omp parallel
    {
        LIKWID_MARKER_START("force");

#pragma omp for schedule(runtime)
        for (int ci = 0; ci < atom->Nclusters_local; ci++) {
            int ci_cj0 = CJ0_FROM_CI(ci);
#if CLUSTER_M > CLUSTER_N
            int ci_cj1 = CJ1_FROM_CI(ci);
#endif
            int ci_vec_base      = CI_VECTOR_BASE_INDEX(ci);
            MD_FLOAT* ci_x       = &atom->cl_x[ci_vec_base];
            MD_FLOAT* ci_f       = &atom->cl_f[ci_vec_base];
            neighs               = &neighbor->neighbors[ci * neighbor->maxneighs];
            int numneighs        = neighbor->numneigh[ci];
            int numneighs_masked = neighbor->numneigh_masked[ci];

            MD_SIMD_FLOAT xi0_tmp = simd_load_h_dual(&ci_x[CL_X_OFFSET + 0]);
            MD_SIMD_FLOAT xi2_tmp = simd_load_h_dual(&ci_x[CL_X_OFFSET + 2]);
            MD_SIMD_FLOAT yi0_tmp = simd_load_h_dual(&ci_x[CL_Y_OFFSET + 0]);
            MD_SIMD_FLOAT yi2_tmp = simd_load_h_dual(&ci_x[CL_Y_OFFSET + 2]);
            MD_SIMD_FLOAT zi0_tmp = simd_load_h_dual(&ci_x[CL_Z_OFFSET + 0]);
            MD_SIMD_FLOAT zi2_tmp = simd_load_h_dual(&ci_x[CL_Z_OFFSET + 2]);
            MD_SIMD_FLOAT fix0    = simd_zero();
            MD_SIMD_FLOAT fiy0    = simd_zero();
            MD_SIMD_FLOAT fiz0    = simd_zero();
            MD_SIMD_FLOAT fix2    = simd_zero();
            MD_SIMD_FLOAT fiy2    = simd_zero();
            MD_SIMD_FLOAT fiz2    = simd_zero();

            for (int k = 0; k < numneighs_masked; k++) {
                int cj          = neighs[k];
                int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
                MD_FLOAT* cj_x  = &atom->cl_x[cj_vec_base];
                unsigned int mask0, mask1, mask2, mask3;

                MD_SIMD_FLOAT xj_tmp = simd_load_h_duplicate(&cj_x[CL_X_OFFSET]);
                MD_SIMD_FLOAT yj_tmp = simd_load_h_duplicate(&cj_x[CL_Y_OFFSET]);
                MD_SIMD_FLOAT zj_tmp = simd_load_h_duplicate(&cj_x[CL_Z_OFFSET]);
                MD_SIMD_FLOAT delx0  = xi0_tmp - xj_tmp;
                MD_SIMD_FLOAT dely0  = yi0_tmp - yj_tmp;
                MD_SIMD_FLOAT delz0  = zi0_tmp - zj_tmp;
                MD_SIMD_FLOAT delx2  = xi2_tmp - xj_tmp;
                MD_SIMD_FLOAT dely2  = yi2_tmp - yj_tmp;
                MD_SIMD_FLOAT delz2  = zi2_tmp - zj_tmp;
                MD_SIMD_FLOAT rsq0   = simd_fma(delx0,
                    delx0,
                    simd_fma(dely0, dely0, delz0 * delz0));
                MD_SIMD_FLOAT rsq2   = simd_fma(delx2,
                    delx2,
                    simd_fma(dely2, dely2, delz2 * delz2));

#if CLUSTER_M == CLUSTER_N
                unsigned int cond0      = (unsigned int)(cj == ci_cj0);
                MD_SIMD_MASK excl_mask0 = simd_mask_from_u32(
                    atom->masks_2xnn_fn[cond0 * 2 + 0]);
                MD_SIMD_MASK excl_mask2 = simd_mask_from_u32(
                    atom->masks_2xnn_fn[cond0 * 2 + 1]);
#else
#if CLUSTER_M < CLUSTER_N
                unsigned int cond0 = (unsigned int)((cj << 1) + 0 == ci);
                unsigned int cond1 = (unsigned int)((cj << 1) + 1 == ci);
#else
                unsigned int cond0 = (unsigned int)(cj == ci_cj0);
                unsigned int cond1 = (unsigned int)(cj == ci_cj1);
#endif
                MD_SIMD_MASK excl_mask0 = simd_mask_from_u32(
                    atom->masks_2xnn_fn[cond0 * 4 + cond1 * 2 + 0]);
                MD_SIMD_MASK excl_mask2 = simd_mask_from_u32(
                    atom->masks_2xnn_fn[cond0 * 4 + cond1 * 2 + 1]);
#endif

                MD_SIMD_MASK cutoff_mask0 = simd_mask_and(excl_mask0,
                    simd_mask_cond_lt(rsq0, cutforcesq_vec));
                MD_SIMD_MASK cutoff_mask2 = simd_mask_and(excl_mask2,
                    simd_mask_cond_lt(rsq2, cutforcesq_vec));

                MD_SIMD_FLOAT sr2_0  = simd_reciprocal(rsq0);
                MD_SIMD_FLOAT sr2_2  = simd_reciprocal(rsq2);
                MD_SIMD_FLOAT sr6_0  = sr2_0 * sr2_0 * sr2_0 * sigma6_vec;
                MD_SIMD_FLOAT sr6_2  = sr2_2 * sr2_2 * sr2_2 * sigma6_vec;
                MD_SIMD_FLOAT force0 = c48_vec * sr6_0 * (sr6_0 - c05_vec) * sr2_0 *
                                       eps_vec;
                MD_SIMD_FLOAT force2 = c48_vec * sr6_2 * (sr6_2 - c05_vec) * sr2_2 *
                                       eps_vec;

                fix0 = simd_masked_add(fix0, simd_mul(delx0, force0), cutoff_mask0);
                fiy0 = simd_masked_add(fiy0, simd_mul(dely0, force0), cutoff_mask0);
                fiz0 = simd_masked_add(fiz0, simd_mul(delz0, force0), cutoff_mask0);
                fix2 = simd_masked_add(fix2, simd_mul(delx2, force2), cutoff_mask2);
                fiy2 = simd_masked_add(fiy2, simd_mul(dely2, force2), cutoff_mask2);
                fiz2 = simd_masked_add(fiz2, simd_mul(delz2, force2), cutoff_mask2);
            }

            for (int k = numneighs_masked; k < numneighs; k++) {
                int cj          = neighs[k];
                int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
                MD_FLOAT* cj_x  = &atom->cl_x[cj_vec_base];

                MD_SIMD_FLOAT xj_tmp = simd_load_h_duplicate(&cj_x[CL_X_OFFSET]);
                MD_SIMD_FLOAT yj_tmp = simd_load_h_duplicate(&cj_x[CL_Y_OFFSET]);
                MD_SIMD_FLOAT zj_tmp = simd_load_h_duplicate(&cj_x[CL_Z_OFFSET]);
                MD_SIMD_FLOAT delx0  = xi0_tmp - xj_tmp;
                MD_SIMD_FLOAT dely0  = yi0_tmp - yj_tmp;
                MD_SIMD_FLOAT delz0  = zi0_tmp - zj_tmp;
                MD_SIMD_FLOAT delx2  = xi2_tmp - xj_tmp;
                MD_SIMD_FLOAT dely2  = yi2_tmp - yj_tmp;
                MD_SIMD_FLOAT delz2  = zi2_tmp - zj_tmp;
                MD_SIMD_FLOAT rsq0   = simd_fma(delx0,
                    delx0,
                    simd_fma(dely0, dely0, delz0 * delz0));
                MD_SIMD_FLOAT rsq2   = simd_fma(delx2,
                    delx2,
                    simd_fma(dely2, dely2, delz2 * delz2));

                MD_SIMD_MASK cutoff_mask0 = simd_mask_cond_lt(rsq0, cutforcesq_vec);
                MD_SIMD_MASK cutoff_mask2 = simd_mask_cond_lt(rsq2, cutforcesq_vec);

                MD_SIMD_FLOAT sr2_0  = simd_reciprocal(rsq0);
                MD_SIMD_FLOAT sr2_2  = simd_reciprocal(rsq2);
                MD_SIMD_FLOAT sr6_0  = sr2_0 * sr2_0 * sr2_0 * sigma6_vec;
                MD_SIMD_FLOAT sr6_2  = sr2_2 * sr2_2 * sr2_2 * sigma6_vec;
                MD_SIMD_FLOAT force0 = c48_vec * sr6_0 * (sr6_0 - c05_vec) * sr2_0 *
                                       eps_vec;
                MD_SIMD_FLOAT force2 = c48_vec * sr6_2 * (sr6_2 - c05_vec) * sr2_2 *
                                       eps_vec;

                fix0 = simd_masked_add(fix0, simd_mul(delx0, force0), cutoff_mask0);
                fiy0 = simd_masked_add(fiy0, simd_mul(dely0, force0), cutoff_mask0);
                fiz0 = simd_masked_add(fiz0, simd_mul(delz0, force0), cutoff_mask0);
                fix2 = simd_masked_add(fix2, simd_mul(delx2, force2), cutoff_mask2);
                fiy2 = simd_masked_add(fiy2, simd_mul(dely2, force2), cutoff_mask2);
                fiz2 = simd_masked_add(fiz2, simd_mul(delz2, force2), cutoff_mask2);
            }

            simd_h_dual_incr_reduced_sum(&ci_f[CL_X_OFFSET], fix0, fix2);
            simd_h_dual_incr_reduced_sum(&ci_f[CL_Y_OFFSET], fiy0, fiy2);
            simd_h_dual_incr_reduced_sum(&ci_f[CL_Z_OFFSET], fiz0, fiz2);

            addStat(stats->calculated_forces, 1);
            addStat(stats->num_neighs, numneighs);
            addStat(stats->force_iters, (long long int)((double)numneighs));
            // addStat(stats->force_iters, (long long int)((double)numneighs * CLUSTER_M /
            // CLUSTER_N));
        }
        LIKWID_MARKER_STOP("force");
    }
    double E = getTimeStamp();
    DEBUG_MESSAGE("computeForceLJ_2xnn end\n");
    return E - S;
}

double computeForceLJ4xnHalfNeigh(
    Parameter* param, Atom* atom, Neighbor* neighbor, Stats* stats)
{
    DEBUG_MESSAGE("computeForceLJ_4xn begin\n");
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT cutforcesq          = param->cutforce * param->cutforce;
    MD_FLOAT sigma6              = param->sigma6;
    MD_FLOAT epsilon             = param->epsilon;
    MD_SIMD_FLOAT cutforcesq_vec = simd_broadcast(cutforcesq);
    MD_SIMD_FLOAT sigma6_vec     = simd_broadcast(sigma6);
    MD_SIMD_FLOAT eps_vec        = simd_broadcast(epsilon);
    MD_SIMD_FLOAT c48_vec        = simd_broadcast(48.0);
    MD_SIMD_FLOAT c05_vec        = simd_broadcast(0.5);

    for (int ci = 0; ci < atom->Nclusters_local; ci++) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ci_f  = &atom->cl_f[ci_vec_base];
        for (int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
            ci_f[CL_X_OFFSET + cii] = 0.0;
            ci_f[CL_Y_OFFSET + cii] = 0.0;
            ci_f[CL_Z_OFFSET + cii] = 0.0;
        }
    }

    for (int cg = atom->ncj; cg < atom->ncj + atom->Nclusters_ghost; cg++) {
        int cj_vec_base = CJ_VECTOR_BASE_INDEX(cg);
        MD_FLOAT* cj_f  = &atom->cl_f[cj_vec_base];
        for (int cjj = 0; cjj < atom->jclusters[cg].natoms; cjj++) {
            cj_f[CL_X_OFFSET + cjj] = 0.0;
            cj_f[CL_Y_OFFSET + cjj] = 0.0;
            cj_f[CL_Z_OFFSET + cjj] = 0.0;
        }
    }

    double S = getTimeStamp();

#pragma omp parallel
    {
        LIKWID_MARKER_START("force");

#pragma omp for schedule(runtime)
        for (int ci = 0; ci < atom->Nclusters_local; ci++) {
            int ci_cj0 = CJ0_FROM_CI(ci);
#if CLUSTER_M > CLUSTER_N
            int ci_cj1 = CJ1_FROM_CI(ci);
#endif
            int ci_vec_base      = CI_VECTOR_BASE_INDEX(ci);
            MD_FLOAT* ci_x       = &atom->cl_x[ci_vec_base];
            MD_FLOAT* ci_f       = &atom->cl_f[ci_vec_base];
            neighs               = &neighbor->neighbors[ci * neighbor->maxneighs];
            int numneighs        = neighbor->numneigh[ci];
            int numneighs_masked = neighbor->numneigh_masked[ci];

            MD_SIMD_FLOAT xi0_tmp = simd_broadcast(ci_x[CL_X_OFFSET + 0]);
            MD_SIMD_FLOAT xi1_tmp = simd_broadcast(ci_x[CL_X_OFFSET + 1]);
            MD_SIMD_FLOAT xi2_tmp = simd_broadcast(ci_x[CL_X_OFFSET + 2]);
            MD_SIMD_FLOAT xi3_tmp = simd_broadcast(ci_x[CL_X_OFFSET + 3]);
            MD_SIMD_FLOAT yi0_tmp = simd_broadcast(ci_x[CL_Y_OFFSET + 0]);
            MD_SIMD_FLOAT yi1_tmp = simd_broadcast(ci_x[CL_Y_OFFSET + 1]);
            MD_SIMD_FLOAT yi2_tmp = simd_broadcast(ci_x[CL_Y_OFFSET + 2]);
            MD_SIMD_FLOAT yi3_tmp = simd_broadcast(ci_x[CL_Y_OFFSET + 3]);
            MD_SIMD_FLOAT zi0_tmp = simd_broadcast(ci_x[CL_Z_OFFSET + 0]);
            MD_SIMD_FLOAT zi1_tmp = simd_broadcast(ci_x[CL_Z_OFFSET + 1]);
            MD_SIMD_FLOAT zi2_tmp = simd_broadcast(ci_x[CL_Z_OFFSET + 2]);
            MD_SIMD_FLOAT zi3_tmp = simd_broadcast(ci_x[CL_Z_OFFSET + 3]);
            MD_SIMD_FLOAT fix0    = simd_zero();
            MD_SIMD_FLOAT fiy0    = simd_zero();
            MD_SIMD_FLOAT fiz0    = simd_zero();
            MD_SIMD_FLOAT fix1    = simd_zero();
            MD_SIMD_FLOAT fiy1    = simd_zero();
            MD_SIMD_FLOAT fiz1    = simd_zero();
            MD_SIMD_FLOAT fix2    = simd_zero();
            MD_SIMD_FLOAT fiy2    = simd_zero();
            MD_SIMD_FLOAT fiz2    = simd_zero();
            MD_SIMD_FLOAT fix3    = simd_zero();
            MD_SIMD_FLOAT fiy3    = simd_zero();
            MD_SIMD_FLOAT fiz3    = simd_zero();

            for (int k = 0; k < numneighs_masked; k++) {
                int cj               = neighs[k];
                int cj_vec_base      = CJ_VECTOR_BASE_INDEX(cj);
                MD_FLOAT* cj_x       = &atom->cl_x[cj_vec_base];
                MD_FLOAT* cj_f       = &atom->cl_f[cj_vec_base];
                MD_SIMD_FLOAT xj_tmp = simd_load(&cj_x[CL_X_OFFSET]);
                MD_SIMD_FLOAT yj_tmp = simd_load(&cj_x[CL_Y_OFFSET]);
                MD_SIMD_FLOAT zj_tmp = simd_load(&cj_x[CL_Z_OFFSET]);
                MD_SIMD_FLOAT delx0  = xi0_tmp - xj_tmp;
                MD_SIMD_FLOAT dely0  = yi0_tmp - yj_tmp;
                MD_SIMD_FLOAT delz0  = zi0_tmp - zj_tmp;
                MD_SIMD_FLOAT delx1  = xi1_tmp - xj_tmp;
                MD_SIMD_FLOAT dely1  = yi1_tmp - yj_tmp;
                MD_SIMD_FLOAT delz1  = zi1_tmp - zj_tmp;
                MD_SIMD_FLOAT delx2  = xi2_tmp - xj_tmp;
                MD_SIMD_FLOAT dely2  = yi2_tmp - yj_tmp;
                MD_SIMD_FLOAT delz2  = zi2_tmp - zj_tmp;
                MD_SIMD_FLOAT delx3  = xi3_tmp - xj_tmp;
                MD_SIMD_FLOAT dely3  = yi3_tmp - yj_tmp;
                MD_SIMD_FLOAT delz3  = zi3_tmp - zj_tmp;

#if CLUSTER_M == CLUSTER_N
                unsigned int cond0      = (unsigned int)(cj == ci_cj0);
                MD_SIMD_MASK excl_mask0 = simd_mask_from_u32(
                    atom->masks_4xn_hn[cond0 * 4 + 0]);
                MD_SIMD_MASK excl_mask1 = simd_mask_from_u32(
                    atom->masks_4xn_hn[cond0 * 4 + 1]);
                MD_SIMD_MASK excl_mask2 = simd_mask_from_u32(
                    atom->masks_4xn_hn[cond0 * 4 + 2]);
                MD_SIMD_MASK excl_mask3 = simd_mask_from_u32(
                    atom->masks_4xn_hn[cond0 * 4 + 3]);
#else
#if CLUSTER_M < CLUSTER_N
                unsigned int cond0 = (unsigned int)((cj << 1) + 0 == ci);
                unsigned int cond1 = (unsigned int)((cj << 1) + 1 == ci);
#else
                unsigned int cond0 = (unsigned int)(cj == ci_cj0);
                unsigned int cond1 = (unsigned int)(cj == ci_cj1);
#endif
                MD_SIMD_MASK excl_mask0 = simd_mask_from_u32(
                    atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 0]);
                MD_SIMD_MASK excl_mask1 = simd_mask_from_u32(
                    atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 1]);
                MD_SIMD_MASK excl_mask2 = simd_mask_from_u32(
                    atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 2]);
                MD_SIMD_MASK excl_mask3 = simd_mask_from_u32(
                    atom->masks_4xn_hn[cond0 * 8 + cond1 * 4 + 3]);
#endif

                MD_SIMD_FLOAT rsq0 = simd_fma(delx0,
                    delx0,
                    simd_fma(dely0, dely0, delz0 * delz0));
                MD_SIMD_FLOAT rsq1 = simd_fma(delx1,
                    delx1,
                    simd_fma(dely1, dely1, delz1 * delz1));
                MD_SIMD_FLOAT rsq2 = simd_fma(delx2,
                    delx2,
                    simd_fma(dely2, dely2, delz2 * delz2));
                MD_SIMD_FLOAT rsq3 = simd_fma(delx3,
                    delx3,
                    simd_fma(dely3, dely3, delz3 * delz3));

                MD_SIMD_MASK cutoff_mask0 = simd_mask_and(excl_mask0,
                    simd_mask_cond_lt(rsq0, cutforcesq_vec));
                MD_SIMD_MASK cutoff_mask1 = simd_mask_and(excl_mask1,
                    simd_mask_cond_lt(rsq1, cutforcesq_vec));
                MD_SIMD_MASK cutoff_mask2 = simd_mask_and(excl_mask2,
                    simd_mask_cond_lt(rsq2, cutforcesq_vec));
                MD_SIMD_MASK cutoff_mask3 = simd_mask_and(excl_mask3,
                    simd_mask_cond_lt(rsq3, cutforcesq_vec));

                MD_SIMD_FLOAT sr2_0 = simd_reciprocal(rsq0);
                MD_SIMD_FLOAT sr2_1 = simd_reciprocal(rsq1);
                MD_SIMD_FLOAT sr2_2 = simd_reciprocal(rsq2);
                MD_SIMD_FLOAT sr2_3 = simd_reciprocal(rsq3);

                MD_SIMD_FLOAT sr6_0 = sr2_0 * sr2_0 * sr2_0 * sigma6_vec;
                MD_SIMD_FLOAT sr6_1 = sr2_1 * sr2_1 * sr2_1 * sigma6_vec;
                MD_SIMD_FLOAT sr6_2 = sr2_2 * sr2_2 * sr2_2 * sigma6_vec;
                MD_SIMD_FLOAT sr6_3 = sr2_3 * sr2_3 * sr2_3 * sigma6_vec;

                MD_SIMD_FLOAT force0 = c48_vec * sr6_0 * (sr6_0 - c05_vec) * sr2_0 *
                                       eps_vec;
                MD_SIMD_FLOAT force1 = c48_vec * sr6_1 * (sr6_1 - c05_vec) * sr2_1 *
                                       eps_vec;
                MD_SIMD_FLOAT force2 = c48_vec * sr6_2 * (sr6_2 - c05_vec) * sr2_2 *
                                       eps_vec;
                MD_SIMD_FLOAT force3 = c48_vec * sr6_3 * (sr6_3 - c05_vec) * sr2_3 *
                                       eps_vec;

                MD_SIMD_FLOAT tx0 = select_by_mask(delx0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT ty0 = select_by_mask(dely0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT tz0 = select_by_mask(delz0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT tx1 = select_by_mask(delx1 * force1, cutoff_mask1);
                MD_SIMD_FLOAT ty1 = select_by_mask(dely1 * force1, cutoff_mask1);
                MD_SIMD_FLOAT tz1 = select_by_mask(delz1 * force1, cutoff_mask1);
                MD_SIMD_FLOAT tx2 = select_by_mask(delx2 * force2, cutoff_mask2);
                MD_SIMD_FLOAT ty2 = select_by_mask(dely2 * force2, cutoff_mask2);
                MD_SIMD_FLOAT tz2 = select_by_mask(delz2 * force2, cutoff_mask2);
                MD_SIMD_FLOAT tx3 = select_by_mask(delx3 * force3, cutoff_mask3);
                MD_SIMD_FLOAT ty3 = select_by_mask(dely3 * force3, cutoff_mask3);
                MD_SIMD_FLOAT tz3 = select_by_mask(delz3 * force3, cutoff_mask3);

                fix0 = simd_add(fix0, tx0);
                fiy0 = simd_add(fiy0, ty0);
                fiz0 = simd_add(fiz0, tz0);
                fix1 = simd_add(fix1, tx1);
                fiy1 = simd_add(fiy1, ty1);
                fiz1 = simd_add(fiz1, tz1);
                fix2 = simd_add(fix2, tx2);
                fiy2 = simd_add(fiy2, ty2);
                fiz2 = simd_add(fiz2, tz2);
                fix3 = simd_add(fix3, tx3);
                fiy3 = simd_add(fiy3, ty3);
                fiz3 = simd_add(fiz3, tz3);

#ifdef HALF_NEIGHBOR_LISTS_CHECK_CJ
                if (cj < CJ1_FROM_CI(atom->Nlocal) || param->method) {
                    simd_store(&cj_f[CL_X_OFFSET],
                        simd_load(&cj_f[CL_X_OFFSET]) - (tx0 + tx1 + tx2 + tx3));
                    simd_store(&cj_f[CL_Y_OFFSET],
                        simd_load(&cj_f[CL_Y_OFFSET]) - (ty0 + ty1 + ty2 + ty3));
                    simd_store(&cj_f[CL_Z_OFFSET],
                        simd_load(&cj_f[CL_Z_OFFSET]) - (tz0 + tz1 + tz2 + tz3));
                }
#else
                simd_store(&cj_f[CL_X_OFFSET],
                    simd_load(&cj_f[CL_X_OFFSET]) - (tx0 + tx1 + tx2 + tx3));
                simd_store(&cj_f[CL_Y_OFFSET],
                    simd_load(&cj_f[CL_Y_OFFSET]) - (ty0 + ty1 + ty2 + ty3));
                simd_store(&cj_f[CL_Z_OFFSET],
                    simd_load(&cj_f[CL_Z_OFFSET]) - (tz0 + tz1 + tz2 + tz3));
#endif
            }

            for (int k = numneighs_masked; k < numneighs; k++) {
                int cj               = neighs[k];
                int cj_vec_base      = CJ_VECTOR_BASE_INDEX(cj);
                MD_FLOAT* cj_x       = &atom->cl_x[cj_vec_base];
                MD_FLOAT* cj_f       = &atom->cl_f[cj_vec_base];
                MD_SIMD_FLOAT xj_tmp = simd_load(&cj_x[CL_X_OFFSET]);
                MD_SIMD_FLOAT yj_tmp = simd_load(&cj_x[CL_Y_OFFSET]);
                MD_SIMD_FLOAT zj_tmp = simd_load(&cj_x[CL_Z_OFFSET]);
                MD_SIMD_FLOAT delx0  = xi0_tmp - xj_tmp;
                MD_SIMD_FLOAT dely0  = yi0_tmp - yj_tmp;
                MD_SIMD_FLOAT delz0  = zi0_tmp - zj_tmp;
                MD_SIMD_FLOAT delx1  = xi1_tmp - xj_tmp;
                MD_SIMD_FLOAT dely1  = yi1_tmp - yj_tmp;
                MD_SIMD_FLOAT delz1  = zi1_tmp - zj_tmp;
                MD_SIMD_FLOAT delx2  = xi2_tmp - xj_tmp;
                MD_SIMD_FLOAT dely2  = yi2_tmp - yj_tmp;
                MD_SIMD_FLOAT delz2  = zi2_tmp - zj_tmp;
                MD_SIMD_FLOAT delx3  = xi3_tmp - xj_tmp;
                MD_SIMD_FLOAT dely3  = yi3_tmp - yj_tmp;
                MD_SIMD_FLOAT delz3  = zi3_tmp - zj_tmp;

                MD_SIMD_FLOAT rsq0 = simd_fma(delx0,
                    delx0,
                    simd_fma(dely0, dely0, delz0 * delz0));
                MD_SIMD_FLOAT rsq1 = simd_fma(delx1,
                    delx1,
                    simd_fma(dely1, dely1, delz1 * delz1));
                MD_SIMD_FLOAT rsq2 = simd_fma(delx2,
                    delx2,
                    simd_fma(dely2, dely2, delz2 * delz2));
                MD_SIMD_FLOAT rsq3 = simd_fma(delx3,
                    delx3,
                    simd_fma(dely3, dely3, delz3 * delz3));

                MD_SIMD_MASK cutoff_mask0 = simd_mask_cond_lt(rsq0, cutforcesq_vec);
                MD_SIMD_MASK cutoff_mask1 = simd_mask_cond_lt(rsq1, cutforcesq_vec);
                MD_SIMD_MASK cutoff_mask2 = simd_mask_cond_lt(rsq2, cutforcesq_vec);
                MD_SIMD_MASK cutoff_mask3 = simd_mask_cond_lt(rsq3, cutforcesq_vec);

                MD_SIMD_FLOAT sr2_0 = simd_reciprocal(rsq0);
                MD_SIMD_FLOAT sr2_1 = simd_reciprocal(rsq1);
                MD_SIMD_FLOAT sr2_2 = simd_reciprocal(rsq2);
                MD_SIMD_FLOAT sr2_3 = simd_reciprocal(rsq3);

                MD_SIMD_FLOAT sr6_0 = sr2_0 * sr2_0 * sr2_0 * sigma6_vec;
                MD_SIMD_FLOAT sr6_1 = sr2_1 * sr2_1 * sr2_1 * sigma6_vec;
                MD_SIMD_FLOAT sr6_2 = sr2_2 * sr2_2 * sr2_2 * sigma6_vec;
                MD_SIMD_FLOAT sr6_3 = sr2_3 * sr2_3 * sr2_3 * sigma6_vec;

                MD_SIMD_FLOAT force0 = c48_vec * sr6_0 * (sr6_0 - c05_vec) * sr2_0 *
                                       eps_vec;
                MD_SIMD_FLOAT force1 = c48_vec * sr6_1 * (sr6_1 - c05_vec) * sr2_1 *
                                       eps_vec;
                MD_SIMD_FLOAT force2 = c48_vec * sr6_2 * (sr6_2 - c05_vec) * sr2_2 *
                                       eps_vec;
                MD_SIMD_FLOAT force3 = c48_vec * sr6_3 * (sr6_3 - c05_vec) * sr2_3 *
                                       eps_vec;

                MD_SIMD_FLOAT tx0 = select_by_mask(delx0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT ty0 = select_by_mask(dely0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT tz0 = select_by_mask(delz0 * force0, cutoff_mask0);
                MD_SIMD_FLOAT tx1 = select_by_mask(delx1 * force1, cutoff_mask1);
                MD_SIMD_FLOAT ty1 = select_by_mask(dely1 * force1, cutoff_mask1);
                MD_SIMD_FLOAT tz1 = select_by_mask(delz1 * force1, cutoff_mask1);
                MD_SIMD_FLOAT tx2 = select_by_mask(delx2 * force2, cutoff_mask2);
                MD_SIMD_FLOAT ty2 = select_by_mask(dely2 * force2, cutoff_mask2);
                MD_SIMD_FLOAT tz2 = select_by_mask(delz2 * force2, cutoff_mask2);
                MD_SIMD_FLOAT tx3 = select_by_mask(delx3 * force3, cutoff_mask3);
                MD_SIMD_FLOAT ty3 = select_by_mask(dely3 * force3, cutoff_mask3);
                MD_SIMD_FLOAT tz3 = select_by_mask(delz3 * force3, cutoff_mask3);

                fix0 = simd_add(fix0, tx0);
                fiy0 = simd_add(fiy0, ty0);
                fiz0 = simd_add(fiz0, tz0);
                fix1 = simd_add(fix1, tx1);
                fiy1 = simd_add(fiy1, ty1);
                fiz1 = simd_add(fiz1, tz1);
                fix2 = simd_add(fix2, tx2);
                fiy2 = simd_add(fiy2, ty2);
                fiz2 = simd_add(fiz2, tz2);
                fix3 = simd_add(fix3, tx3);
                fiy3 = simd_add(fiy3, ty3);
                fiz3 = simd_add(fiz3, tz3);

#ifdef HALF_NEIGHBOR_LISTS_CHECK_CJ
                if (cj < CJ1_FROM_CI(atom->Nlocal) || param->method) {
                    simd_store(&cj_f[CL_X_OFFSET],
                        simd_load(&cj_f[CL_X_OFFSET]) - (tx0 + tx1 + tx2 + tx3));
                    simd_store(&cj_f[CL_Y_OFFSET],
                        simd_load(&cj_f[CL_Y_OFFSET]) - (ty0 + ty1 + ty2 + ty3));
                    simd_store(&cj_f[CL_Z_OFFSET],
                        simd_load(&cj_f[CL_Z_OFFSET]) - (tz0 + tz1 + tz2 + tz3));
                }
#else
                simd_store(&cj_f[CL_X_OFFSET],
                    simd_load(&cj_f[CL_X_OFFSET]) - (tx0 + tx1 + tx2 + tx3));
                simd_store(&cj_f[CL_Y_OFFSET],
                    simd_load(&cj_f[CL_Y_OFFSET]) - (ty0 + ty1 + ty2 + ty3));
                simd_store(&cj_f[CL_Z_OFFSET],
                    simd_load(&cj_f[CL_Z_OFFSET]) - (tz0 + tz1 + tz2 + tz3));
#endif
            }

            simd_incr_reduced_sum(&ci_f[CL_X_OFFSET], fix0, fix1, fix2, fix3);
            simd_incr_reduced_sum(&ci_f[CL_Y_OFFSET], fiy0, fiy1, fiy2, fiy3);
            simd_incr_reduced_sum(&ci_f[CL_Z_OFFSET], fiz0, fiz1, fiz2, fiz3);

            addStat(stats->calculated_forces, 1);
            addStat(stats->num_neighs, numneighs);
            addStat(stats->force_iters,
                (long long int)((double)numneighs * CLUSTER_M / CLUSTER_N));
        }
        if (param->method == eightShell) computeForceGhostShell(param, atom, neighbor);
        LIKWID_MARKER_STOP("force");
    }

    double E = getTimeStamp();
    DEBUG_MESSAGE("computeForceLJ_4xn end\n");
    return E - S;
}

double computeForceLJ4xnFullNeigh(
    Parameter* param, Atom* atom, Neighbor* neighbor, Stats* stats)
{
    DEBUG_MESSAGE("computeForceLJ_4xn begin\n");
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT cutforcesq          = param->cutforce * param->cutforce;
    MD_FLOAT sigma6              = param->sigma6;
    MD_FLOAT epsilon             = param->epsilon;
    MD_SIMD_FLOAT cutforcesq_vec = simd_broadcast(cutforcesq);
    MD_SIMD_FLOAT sigma6_vec     = simd_broadcast(sigma6);
    MD_SIMD_FLOAT eps_vec        = simd_broadcast(epsilon);
    MD_SIMD_FLOAT c48_vec        = simd_broadcast(48.0);
    MD_SIMD_FLOAT c05_vec        = simd_broadcast(0.5);

    for (int ci = 0; ci < atom->Nclusters_local; ci++) {
        int ci_vec_base = CI_VECTOR_BASE_INDEX(ci);
        MD_FLOAT* ci_f  = &atom->cl_f[ci_vec_base];
        for (int cii = 0; cii < atom->iclusters[ci].natoms; cii++) {
            ci_f[CL_X_OFFSET + cii] = 0.0;
            ci_f[CL_Y_OFFSET + cii] = 0.0;
            ci_f[CL_Z_OFFSET + cii] = 0.0;
        }
    }

    double S = getTimeStamp();

#pragma omp parallel
    {
        LIKWID_MARKER_START("force");

#pragma omp for schedule(runtime)
        for (int ci = 0; ci < atom->Nclusters_local; ci++) {
            int ci_cj0 = CJ0_FROM_CI(ci);
#if CLUSTER_M > CLUSTER_N
            int ci_cj1 = CJ1_FROM_CI(ci);
#endif
            int ci_vec_base      = CI_VECTOR_BASE_INDEX(ci);
            MD_FLOAT* ci_x       = &atom->cl_x[ci_vec_base];
            MD_FLOAT* ci_f       = &atom->cl_f[ci_vec_base];
            neighs               = &neighbor->neighbors[ci * neighbor->maxneighs];
            int numneighs        = neighbor->numneigh[ci];
            int numneighs_masked = neighbor->numneigh_masked[ci];

            MD_SIMD_FLOAT xi0_tmp = simd_broadcast(ci_x[CL_X_OFFSET + 0]);
            MD_SIMD_FLOAT xi1_tmp = simd_broadcast(ci_x[CL_X_OFFSET + 1]);
            MD_SIMD_FLOAT xi2_tmp = simd_broadcast(ci_x[CL_X_OFFSET + 2]);
            MD_SIMD_FLOAT xi3_tmp = simd_broadcast(ci_x[CL_X_OFFSET + 3]);
            MD_SIMD_FLOAT yi0_tmp = simd_broadcast(ci_x[CL_Y_OFFSET + 0]);
            MD_SIMD_FLOAT yi1_tmp = simd_broadcast(ci_x[CL_Y_OFFSET + 1]);
            MD_SIMD_FLOAT yi2_tmp = simd_broadcast(ci_x[CL_Y_OFFSET + 2]);
            MD_SIMD_FLOAT yi3_tmp = simd_broadcast(ci_x[CL_Y_OFFSET + 3]);
            MD_SIMD_FLOAT zi0_tmp = simd_broadcast(ci_x[CL_Z_OFFSET + 0]);
            MD_SIMD_FLOAT zi1_tmp = simd_broadcast(ci_x[CL_Z_OFFSET + 1]);
            MD_SIMD_FLOAT zi2_tmp = simd_broadcast(ci_x[CL_Z_OFFSET + 2]);
            MD_SIMD_FLOAT zi3_tmp = simd_broadcast(ci_x[CL_Z_OFFSET + 3]);
            MD_SIMD_FLOAT fix0    = simd_zero();
            MD_SIMD_FLOAT fiy0    = simd_zero();
            MD_SIMD_FLOAT fiz0    = simd_zero();
            MD_SIMD_FLOAT fix1    = simd_zero();
            MD_SIMD_FLOAT fiy1    = simd_zero();
            MD_SIMD_FLOAT fiz1    = simd_zero();
            MD_SIMD_FLOAT fix2    = simd_zero();
            MD_SIMD_FLOAT fiy2    = simd_zero();
            MD_SIMD_FLOAT fiz2    = simd_zero();
            MD_SIMD_FLOAT fix3    = simd_zero();
            MD_SIMD_FLOAT fiy3    = simd_zero();
            MD_SIMD_FLOAT fiz3    = simd_zero();

            for (int k = 0; k < numneighs_masked; k++) {
                int cj               = neighs[k];
                int cj_vec_base      = CJ_VECTOR_BASE_INDEX(cj);
                MD_FLOAT* cj_x       = &atom->cl_x[cj_vec_base];
                MD_SIMD_FLOAT xj_tmp = simd_load(&cj_x[CL_X_OFFSET]);
                MD_SIMD_FLOAT yj_tmp = simd_load(&cj_x[CL_Y_OFFSET]);
                MD_SIMD_FLOAT zj_tmp = simd_load(&cj_x[CL_Z_OFFSET]);
                MD_SIMD_FLOAT delx0  = xi0_tmp - xj_tmp;
                MD_SIMD_FLOAT dely0  = yi0_tmp - yj_tmp;
                MD_SIMD_FLOAT delz0  = zi0_tmp - zj_tmp;
                MD_SIMD_FLOAT delx1  = xi1_tmp - xj_tmp;
                MD_SIMD_FLOAT dely1  = yi1_tmp - yj_tmp;
                MD_SIMD_FLOAT delz1  = zi1_tmp - zj_tmp;
                MD_SIMD_FLOAT delx2  = xi2_tmp - xj_tmp;
                MD_SIMD_FLOAT dely2  = yi2_tmp - yj_tmp;
                MD_SIMD_FLOAT delz2  = zi2_tmp - zj_tmp;
                MD_SIMD_FLOAT delx3  = xi3_tmp - xj_tmp;
                MD_SIMD_FLOAT dely3  = yi3_tmp - yj_tmp;
                MD_SIMD_FLOAT delz3  = zi3_tmp - zj_tmp;

#if CLUSTER_M == CLUSTER_N
                unsigned int cond0      = (unsigned int)(cj == ci_cj0);
                MD_SIMD_MASK excl_mask0 = simd_mask_from_u32(
                    atom->masks_4xn_fn[cond0 * 4 + 0]);
                MD_SIMD_MASK excl_mask1 = simd_mask_from_u32(
                    atom->masks_4xn_fn[cond0 * 4 + 1]);
                MD_SIMD_MASK excl_mask2 = simd_mask_from_u32(
                    atom->masks_4xn_fn[cond0 * 4 + 2]);
                MD_SIMD_MASK excl_mask3 = simd_mask_from_u32(
                    atom->masks_4xn_fn[cond0 * 4 + 3]);
#else
#if CLUSTER_M < CLUSTER_N
                unsigned int cond0 = (unsigned int)((cj << 1) + 0 == ci);
                unsigned int cond1 = (unsigned int)((cj << 1) + 1 == ci);
#else
                unsigned int cond0 = (unsigned int)(cj == ci_cj0);
                unsigned int cond1 = (unsigned int)(cj == ci_cj1);
#endif
                MD_SIMD_MASK excl_mask0 = simd_mask_from_u32(
                    atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 0]);
                MD_SIMD_MASK excl_mask1 = simd_mask_from_u32(
                    atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 1]);
                MD_SIMD_MASK excl_mask2 = simd_mask_from_u32(
                    atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 2]);
                MD_SIMD_MASK excl_mask3 = simd_mask_from_u32(
                    atom->masks_4xn_fn[cond0 * 8 + cond1 * 4 + 3]);
#endif

                MD_SIMD_FLOAT rsq0 = simd_fma(delx0,
                    delx0,
                    simd_fma(dely0, dely0, delz0 * delz0));
                MD_SIMD_FLOAT rsq1 = simd_fma(delx1,
                    delx1,
                    simd_fma(dely1, dely1, delz1 * delz1));
                MD_SIMD_FLOAT rsq2 = simd_fma(delx2,
                    delx2,
                    simd_fma(dely2, dely2, delz2 * delz2));
                MD_SIMD_FLOAT rsq3 = simd_fma(delx3,
                    delx3,
                    simd_fma(dely3, dely3, delz3 * delz3));

                MD_SIMD_MASK cutoff_mask0 = simd_mask_and(excl_mask0,
                    simd_mask_cond_lt(rsq0, cutforcesq_vec));
                MD_SIMD_MASK cutoff_mask1 = simd_mask_and(excl_mask1,
                    simd_mask_cond_lt(rsq1, cutforcesq_vec));
                MD_SIMD_MASK cutoff_mask2 = simd_mask_and(excl_mask2,
                    simd_mask_cond_lt(rsq2, cutforcesq_vec));
                MD_SIMD_MASK cutoff_mask3 = simd_mask_and(excl_mask3,
                    simd_mask_cond_lt(rsq3, cutforcesq_vec));

                MD_SIMD_FLOAT sr2_0 = simd_reciprocal(rsq0);
                MD_SIMD_FLOAT sr2_1 = simd_reciprocal(rsq1);
                MD_SIMD_FLOAT sr2_2 = simd_reciprocal(rsq2);
                MD_SIMD_FLOAT sr2_3 = simd_reciprocal(rsq3);

                MD_SIMD_FLOAT sr6_0 = sr2_0 * sr2_0 * sr2_0 * sigma6_vec;
                MD_SIMD_FLOAT sr6_1 = sr2_1 * sr2_1 * sr2_1 * sigma6_vec;
                MD_SIMD_FLOAT sr6_2 = sr2_2 * sr2_2 * sr2_2 * sigma6_vec;
                MD_SIMD_FLOAT sr6_3 = sr2_3 * sr2_3 * sr2_3 * sigma6_vec;

                MD_SIMD_FLOAT force0 = c48_vec * sr6_0 * (sr6_0 - c05_vec) * sr2_0 *
                                       eps_vec;
                MD_SIMD_FLOAT force1 = c48_vec * sr6_1 * (sr6_1 - c05_vec) * sr2_1 *
                                       eps_vec;
                MD_SIMD_FLOAT force2 = c48_vec * sr6_2 * (sr6_2 - c05_vec) * sr2_2 *
                                       eps_vec;
                MD_SIMD_FLOAT force3 = c48_vec * sr6_3 * (sr6_3 - c05_vec) * sr2_3 *
                                       eps_vec;

                fix0 = simd_masked_add(fix0, delx0 * force0, cutoff_mask0);
                fiy0 = simd_masked_add(fiy0, dely0 * force0, cutoff_mask0);
                fiz0 = simd_masked_add(fiz0, delz0 * force0, cutoff_mask0);
                fix1 = simd_masked_add(fix1, delx1 * force1, cutoff_mask1);
                fiy1 = simd_masked_add(fiy1, dely1 * force1, cutoff_mask1);
                fiz1 = simd_masked_add(fiz1, delz1 * force1, cutoff_mask1);
                fix2 = simd_masked_add(fix2, delx2 * force2, cutoff_mask2);
                fiy2 = simd_masked_add(fiy2, dely2 * force2, cutoff_mask2);
                fiz2 = simd_masked_add(fiz2, delz2 * force2, cutoff_mask2);
                fix3 = simd_masked_add(fix3, delx3 * force3, cutoff_mask3);
                fiy3 = simd_masked_add(fiy3, dely3 * force3, cutoff_mask3);
                fiz3 = simd_masked_add(fiz3, delz3 * force3, cutoff_mask3);
            }

            for (int k = numneighs_masked; k < numneighs; k++) {
                int cj               = neighs[k];
                int cj_vec_base      = CJ_VECTOR_BASE_INDEX(cj);
                MD_FLOAT* cj_x       = &atom->cl_x[cj_vec_base];
                MD_SIMD_FLOAT xj_tmp = simd_load(&cj_x[CL_X_OFFSET]);
                MD_SIMD_FLOAT yj_tmp = simd_load(&cj_x[CL_Y_OFFSET]);
                MD_SIMD_FLOAT zj_tmp = simd_load(&cj_x[CL_Z_OFFSET]);
                MD_SIMD_FLOAT delx0  = xi0_tmp - xj_tmp;
                MD_SIMD_FLOAT dely0  = yi0_tmp - yj_tmp;
                MD_SIMD_FLOAT delz0  = zi0_tmp - zj_tmp;
                MD_SIMD_FLOAT delx1  = xi1_tmp - xj_tmp;
                MD_SIMD_FLOAT dely1  = yi1_tmp - yj_tmp;
                MD_SIMD_FLOAT delz1  = zi1_tmp - zj_tmp;
                MD_SIMD_FLOAT delx2  = xi2_tmp - xj_tmp;
                MD_SIMD_FLOAT dely2  = yi2_tmp - yj_tmp;
                MD_SIMD_FLOAT delz2  = zi2_tmp - zj_tmp;
                MD_SIMD_FLOAT delx3  = xi3_tmp - xj_tmp;
                MD_SIMD_FLOAT dely3  = yi3_tmp - yj_tmp;
                MD_SIMD_FLOAT delz3  = zi3_tmp - zj_tmp;

                MD_SIMD_FLOAT rsq0 = simd_fma(delx0,
                    delx0,
                    simd_fma(dely0, dely0, delz0 * delz0));
                MD_SIMD_FLOAT rsq1 = simd_fma(delx1,
                    delx1,
                    simd_fma(dely1, dely1, delz1 * delz1));
                MD_SIMD_FLOAT rsq2 = simd_fma(delx2,
                    delx2,
                    simd_fma(dely2, dely2, delz2 * delz2));
                MD_SIMD_FLOAT rsq3 = simd_fma(delx3,
                    delx3,
                    simd_fma(dely3, dely3, delz3 * delz3));

                MD_SIMD_MASK cutoff_mask0 = simd_mask_cond_lt(rsq0, cutforcesq_vec);
                MD_SIMD_MASK cutoff_mask1 = simd_mask_cond_lt(rsq1, cutforcesq_vec);
                MD_SIMD_MASK cutoff_mask2 = simd_mask_cond_lt(rsq2, cutforcesq_vec);
                MD_SIMD_MASK cutoff_mask3 = simd_mask_cond_lt(rsq3, cutforcesq_vec);

                MD_SIMD_FLOAT sr2_0 = simd_reciprocal(rsq0);
                MD_SIMD_FLOAT sr2_1 = simd_reciprocal(rsq1);
                MD_SIMD_FLOAT sr2_2 = simd_reciprocal(rsq2);
                MD_SIMD_FLOAT sr2_3 = simd_reciprocal(rsq3);

                MD_SIMD_FLOAT sr6_0 = sr2_0 * sr2_0 * sr2_0 * sigma6_vec;
                MD_SIMD_FLOAT sr6_1 = sr2_1 * sr2_1 * sr2_1 * sigma6_vec;
                MD_SIMD_FLOAT sr6_2 = sr2_2 * sr2_2 * sr2_2 * sigma6_vec;
                MD_SIMD_FLOAT sr6_3 = sr2_3 * sr2_3 * sr2_3 * sigma6_vec;

                MD_SIMD_FLOAT force0 = c48_vec * sr6_0 * (sr6_0 - c05_vec) * sr2_0 *
                                       eps_vec;
                MD_SIMD_FLOAT force1 = c48_vec * sr6_1 * (sr6_1 - c05_vec) * sr2_1 *
                                       eps_vec;
                MD_SIMD_FLOAT force2 = c48_vec * sr6_2 * (sr6_2 - c05_vec) * sr2_2 *
                                       eps_vec;
                MD_SIMD_FLOAT force3 = c48_vec * sr6_3 * (sr6_3 - c05_vec) * sr2_3 *
                                       eps_vec;

                fix0 = simd_masked_add(fix0, delx0 * force0, cutoff_mask0);
                fiy0 = simd_masked_add(fiy0, dely0 * force0, cutoff_mask0);
                fiz0 = simd_masked_add(fiz0, delz0 * force0, cutoff_mask0);
                fix1 = simd_masked_add(fix1, delx1 * force1, cutoff_mask1);
                fiy1 = simd_masked_add(fiy1, dely1 * force1, cutoff_mask1);
                fiz1 = simd_masked_add(fiz1, delz1 * force1, cutoff_mask1);
                fix2 = simd_masked_add(fix2, delx2 * force2, cutoff_mask2);
                fiy2 = simd_masked_add(fiy2, dely2 * force2, cutoff_mask2);
                fiz2 = simd_masked_add(fiz2, delz2 * force2, cutoff_mask2);
                fix3 = simd_masked_add(fix3, delx3 * force3, cutoff_mask3);
                fiy3 = simd_masked_add(fiy3, dely3 * force3, cutoff_mask3);
                fiz3 = simd_masked_add(fiz3, delz3 * force3, cutoff_mask3);
            }

            simd_incr_reduced_sum(&ci_f[CL_X_OFFSET], fix0, fix1, fix2, fix3);
            simd_incr_reduced_sum(&ci_f[CL_Y_OFFSET], fiy0, fiy1, fiy2, fiy3);
            simd_incr_reduced_sum(&ci_f[CL_Z_OFFSET], fiz0, fiz1, fiz2, fiz3);

            addStat(stats->calculated_forces, 1);
            addStat(stats->num_neighs, numneighs);
            addStat(stats->force_iters, (long long int)((double)numneighs));
            // addStat(stats->force_iters, (long long int)((double)numneighs * CLUSTER_M /
            // CLUSTER_N));
        }

        LIKWID_MARKER_STOP("force");
    }

    double E = getTimeStamp();
    DEBUG_MESSAGE("computeForceLJ_4xn end\n");
    return E - S;
}
#endif

// Routine for eight shell method + MPI
void computeForceGhostShell(Parameter* param, Atom* atom, Neighbor* neighbor)
{
    DEBUG_MESSAGE("computeForceLJ begin\n");

    int Nshell = neighbor->Nshell;
    int* neighs;
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6     = param->sigma6;
    MD_FLOAT epsilon    = param->epsilon;

    for (int ci = 0; ci < Nshell; ci++) {
        neighs          = &neighbor->neighshell[ci * neighbor->maxneighs];
        int numneighs   = neighbor->numNeighShell[ci];
        int cs          = neighbor->listshell[ci];
        int cs_vec_base = CJ_VECTOR_BASE_INDEX(cs);
        MD_FLOAT* cs_x  = &atom->cl_x[cs_vec_base];
        MD_FLOAT* cs_f  = &atom->cl_f[cs_vec_base];

        for (int k = 0; k < numneighs; k++) {
            int cj          = neighs[k];
            int cj_vec_base = CJ_VECTOR_BASE_INDEX(cj);
            MD_FLOAT* cj_x  = &atom->cl_x[cj_vec_base];
            MD_FLOAT* cj_f  = &atom->cl_f[cj_vec_base];

            for (int css = 0; css < CLUSTER_N; css++) {
                MD_FLOAT x = cs_x[CL_X_OFFSET + css];
                MD_FLOAT y = cs_x[CL_Y_OFFSET + css];
                MD_FLOAT z = cs_x[CL_Z_OFFSET + css];

                MD_FLOAT fix = 0;
                MD_FLOAT fiy = 0;
                MD_FLOAT fiz = 0;

                for (int cjj = 0; cjj < CLUSTER_N; cjj++) {

                    MD_FLOAT delx = x - cj_x[CL_X_OFFSET + cjj];
                    MD_FLOAT dely = y - cj_x[CL_Y_OFFSET + cjj];
                    MD_FLOAT delz = z - cj_x[CL_Z_OFFSET + cjj];

                    MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;
                    if (rsq < cutforcesq) {
                        MD_FLOAT sr2   = 1.0 / rsq;
                        MD_FLOAT sr6   = sr2 * sr2 * sr2 * sigma6;
                        MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;

                        cj_f[CL_X_OFFSET + cjj] -= delx * force;
                        cj_f[CL_Y_OFFSET + cjj] -= dely * force;
                        cj_f[CL_Z_OFFSET + cjj] -= delz * force;

                        fix += delx * force;
                        fiy += dely * force;
                        fiz += delz * force;
                    }
                }

                cs_f[CL_X_OFFSET + css] += fix;
                cs_f[CL_Y_OFFSET + css] += fiy;
                cs_f[CL_Z_OFFSET + css] += fiz;
            }
        }
        // addStat(stats->calculated_forces, 1);
        // addStat(stats->num_neighs, numneighs);
        // addStat(stats->force_iters, (long long int)((double)numneighs));
    }
}
