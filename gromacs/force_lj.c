/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *   Copyright (c) 2021 RRZE, University Erlangen-Nuremberg
 *
 *   This file is part of MD-Bench.
 *
 *   MD-Bench is free software: you can redistribute it and/or modify it
 *   under the terms of the GNU Lesser General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   MD-Bench is distributed in the hope that it will be useful, but WITHOUT ANY
 *   WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 *   PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
 *   details.
 *
 *   You should have received a copy of the GNU Lesser General Public License along
 *   with MD-Bench.  If not, see <https://www.gnu.org/licenses/>.
 * =======================================================================================
 */
#include <stdio.h>

#include <likwid-marker.h>
#include <timing.h>
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>
#include <stats.h>
#include <util.h>
#include <simd.h>


double computeForceLJ_ref(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    DEBUG_MESSAGE("computeForceLJ begin\n");
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;

    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        MD_FLOAT *fptr = cluster_force_ptr(ci);
        for(int cii = 0; cii < atom->clusters[ci].natoms; cii++) {
            cluster_x(fptr, cii) = 0.0;
            cluster_y(fptr, cii) = 0.0;
            cluster_z(fptr, cii) = 0.0;
        }
    }

    double S = getTimeStamp();
    LIKWID_MARKER_START("force");

    #pragma omp parallel for
    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        MD_FLOAT *ciptr = cluster_pos_ptr(ci);
        MD_FLOAT *cifptr = cluster_force_ptr(ci);
        neighs = &neighbor->neighbors[ci * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[ci];

        for(int k = 0; k < numneighs; k++) {
            int cj = neighs[k];
            MD_FLOAT *cjptr = cluster_pos_ptr(cj);
            for(int cii = 0; cii < CLUSTER_DIM_M; cii++) {
                MD_FLOAT xtmp = cluster_x(ciptr, cii);
                MD_FLOAT ytmp = cluster_y(ciptr, cii);
                MD_FLOAT ztmp = cluster_z(ciptr, cii);
                MD_FLOAT fix = 0;
                MD_FLOAT fiy = 0;
                MD_FLOAT fiz = 0;

                for(int cjj = 0; cjj < CLUSTER_DIM_M; cjj++) {
                    if(ci != cj || cii != cjj) {
                        MD_FLOAT delx = xtmp - cluster_x(cjptr, cjj);
                        MD_FLOAT dely = ytmp - cluster_y(cjptr, cjj);
                        MD_FLOAT delz = ztmp - cluster_z(cjptr, cjj);
                        MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;
                        if(rsq < cutforcesq) {
                            MD_FLOAT sr2 = 1.0 / rsq;
                            MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
                            MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;
                            fix += delx * force;
                            fiy += dely * force;
                            fiz += delz * force;
                        }
                    }
                }

                cluster_x(cifptr, cii) += fix;
                cluster_y(cifptr, cii) += fiy;
                cluster_z(cifptr, cii) += fiz;
            }
        }

        addStat(stats->total_force_neighs, numneighs);
        addStat(stats->total_force_iters, (numneighs + VECTOR_WIDTH - 1) / VECTOR_WIDTH);
    }

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();
    DEBUG_MESSAGE("computeForceLJ end\n");
    return E-S;
}


double computeForceLJ_4xn(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    DEBUG_MESSAGE("computeForceLJ_4xn begin\n");
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;
    MD_SIMD_FLOAT cutforcesq_vec = simd_broadcast(cutforcesq);
    MD_SIMD_FLOAT sigma6_vec = simd_broadcast(sigma6);
    MD_SIMD_FLOAT epsilon_vec = simd_broadcast(epsilon);
    MD_SIMD_FLOAT c48_vec = simd_broadcast(48.0);
    MD_SIMD_FLOAT c05_vec = simd_broadcast(0.5);
    const int unroll_j = CLUSTER_DIM_N / CLUSTER_DIM_M;

    double S = getTimeStamp();
    LIKWID_MARKER_START("force");

    #pragma omp parallel for
    for(int ci = 0; ci < atom->Nclusters_local; ci++) {
        MD_FLOAT *ciptr = cluster_pos_ptr(ci);
        MD_FLOAT *cifptr = cluster_force_ptr(ci);
        neighs = &neighbor->neighbors[ci * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[ci];

        MD_SIMD_FLOAT xi0_tmp = simd_broadcast(cluster_x(ciptr, 0));
        MD_SIMD_FLOAT yi0_tmp = simd_broadcast(cluster_y(ciptr, 0));
        MD_SIMD_FLOAT zi0_tmp = simd_broadcast(cluster_z(ciptr, 0));
        MD_SIMD_FLOAT xi1_tmp = simd_broadcast(cluster_x(ciptr, 1));
        MD_SIMD_FLOAT yi1_tmp = simd_broadcast(cluster_y(ciptr, 1));
        MD_SIMD_FLOAT zi1_tmp = simd_broadcast(cluster_z(ciptr, 1));
        MD_SIMD_FLOAT xi2_tmp = simd_broadcast(cluster_x(ciptr, 2));
        MD_SIMD_FLOAT yi2_tmp = simd_broadcast(cluster_y(ciptr, 2));
        MD_SIMD_FLOAT zi2_tmp = simd_broadcast(cluster_z(ciptr, 2));
        MD_SIMD_FLOAT xi3_tmp = simd_broadcast(cluster_x(ciptr, 3));
        MD_SIMD_FLOAT yi3_tmp = simd_broadcast(cluster_y(ciptr, 3));
        MD_SIMD_FLOAT zi3_tmp = simd_broadcast(cluster_z(ciptr, 3));
        MD_SIMD_FLOAT fix0 = simd_zero();
        MD_SIMD_FLOAT fiy0 = simd_zero();
        MD_SIMD_FLOAT fiz0 = simd_zero();
        MD_SIMD_FLOAT fix1 = simd_zero();
        MD_SIMD_FLOAT fiy1 = simd_zero();
        MD_SIMD_FLOAT fiz1 = simd_zero();
        MD_SIMD_FLOAT fix2 = simd_zero();
        MD_SIMD_FLOAT fiy2 = simd_zero();
        MD_SIMD_FLOAT fiz2 = simd_zero();
        MD_SIMD_FLOAT fix3 = simd_zero();
        MD_SIMD_FLOAT fiy3 = simd_zero();
        MD_SIMD_FLOAT fiz3 = simd_zero();

        for(int k = 0; k < numneighs; k += unroll_j) {
            int cj0 = neighs[k + 0];
            int cj1 = neighs[k + 1];
            unsigned int cond0 = (unsigned int)(ci == cj0);
            unsigned int cond1 = (unsigned int)(ci == cj1);
            MD_FLOAT *cj0_ptr = cluster_pos_ptr(cj0);
            MD_FLOAT *cj1_ptr = cluster_pos_ptr(cj1);
            MD_SIMD_FLOAT xj_tmp = simd_gather2(cj0_ptr, cj1_ptr, 0);
            MD_SIMD_FLOAT yj_tmp = simd_gather2(cj0_ptr, cj1_ptr, 1);
            MD_SIMD_FLOAT zj_tmp = simd_gather2(cj0_ptr, cj1_ptr, 2);

            MD_SIMD_FLOAT delx0 = simd_sub(xi0_tmp, xj_tmp);
            MD_SIMD_FLOAT dely0 = simd_sub(yi0_tmp, yj_tmp);
            MD_SIMD_FLOAT delz0 = simd_sub(zi0_tmp, zj_tmp);
            MD_SIMD_FLOAT delx1 = simd_sub(xi1_tmp, xj_tmp);
            MD_SIMD_FLOAT dely1 = simd_sub(yi1_tmp, yj_tmp);
            MD_SIMD_FLOAT delz1 = simd_sub(zi1_tmp, zj_tmp);
            MD_SIMD_FLOAT delx2 = simd_sub(xi2_tmp, xj_tmp);
            MD_SIMD_FLOAT dely2 = simd_sub(yi2_tmp, yj_tmp);
            MD_SIMD_FLOAT delz2 = simd_sub(zi2_tmp, zj_tmp);
            MD_SIMD_FLOAT delx3 = simd_sub(xi3_tmp, xj_tmp);
            MD_SIMD_FLOAT dely3 = simd_sub(yi3_tmp, yj_tmp);
            MD_SIMD_FLOAT delz3 = simd_sub(zi3_tmp, zj_tmp);

            MD_SIMD_MASK excl_mask0 = simd_mask_from_u32((unsigned int)(0xff - 0x1 * cond0 - 0x10 * cond1));
            MD_SIMD_MASK excl_mask1 = simd_mask_from_u32((unsigned int)(0xff - 0x2 * cond0 - 0x20 * cond1));
            MD_SIMD_MASK excl_mask2 = simd_mask_from_u32((unsigned int)(0xff - 0x4 * cond0 - 0x40 * cond1));
            MD_SIMD_MASK excl_mask3 = simd_mask_from_u32((unsigned int)(0xff - 0x8 * cond0 - 0x80 * cond1));

            MD_SIMD_FLOAT rsq0 = simd_fma(delx0, delx0, simd_fma(dely0, dely0, simd_mul(delz0, delz0)));
            MD_SIMD_FLOAT rsq1 = simd_fma(delx1, delx1, simd_fma(dely1, dely1, simd_mul(delz1, delz1)));
            MD_SIMD_FLOAT rsq2 = simd_fma(delx2, delx2, simd_fma(dely2, dely2, simd_mul(delz2, delz2)));
            MD_SIMD_FLOAT rsq3 = simd_fma(delx3, delx3, simd_fma(dely3, dely3, simd_mul(delz3, delz3)));

            MD_SIMD_MASK cutoff_mask0 = simd_mask_and(excl_mask0, simd_mask_cond_lt(rsq0, cutforcesq_vec));
            MD_SIMD_MASK cutoff_mask1 = simd_mask_and(excl_mask1, simd_mask_cond_lt(rsq1, cutforcesq_vec));
            MD_SIMD_MASK cutoff_mask2 = simd_mask_and(excl_mask2, simd_mask_cond_lt(rsq2, cutforcesq_vec));
            MD_SIMD_MASK cutoff_mask3 = simd_mask_and(excl_mask3, simd_mask_cond_lt(rsq3, cutforcesq_vec));

            MD_SIMD_FLOAT sr2_0 = simd_reciprocal(rsq0);
            MD_SIMD_FLOAT sr2_1 = simd_reciprocal(rsq1);
            MD_SIMD_FLOAT sr2_2 = simd_reciprocal(rsq2);
            MD_SIMD_FLOAT sr2_3 = simd_reciprocal(rsq3);

            MD_SIMD_FLOAT sr6_0 = simd_mul(sr2_0, simd_mul(sr2_0, simd_mul(sr2_0, sigma6_vec)));
            MD_SIMD_FLOAT sr6_1 = simd_mul(sr2_1, simd_mul(sr2_1, simd_mul(sr2_1, sigma6_vec)));
            MD_SIMD_FLOAT sr6_2 = simd_mul(sr2_2, simd_mul(sr2_2, simd_mul(sr2_2, sigma6_vec)));
            MD_SIMD_FLOAT sr6_3 = simd_mul(sr2_3, simd_mul(sr2_3, simd_mul(sr2_3, sigma6_vec)));

            MD_SIMD_FLOAT force0 = simd_mul(c48_vec, simd_mul(sr6_0, simd_mul(simd_sub(sr6_0, c05_vec), simd_mul(sr2_0, epsilon_vec))));
            MD_SIMD_FLOAT force1 = simd_mul(c48_vec, simd_mul(sr6_1, simd_mul(simd_sub(sr6_1, c05_vec), simd_mul(sr2_1, epsilon_vec))));
            MD_SIMD_FLOAT force2 = simd_mul(c48_vec, simd_mul(sr6_2, simd_mul(simd_sub(sr6_2, c05_vec), simd_mul(sr2_2, epsilon_vec))));
            MD_SIMD_FLOAT force3 = simd_mul(c48_vec, simd_mul(sr6_3, simd_mul(simd_sub(sr6_3, c05_vec), simd_mul(sr2_3, epsilon_vec))));

            fix0 = simd_masked_add(fix0, simd_mul(delx0, force0), cutoff_mask0);
            fiy0 = simd_masked_add(fiy0, simd_mul(dely0, force0), cutoff_mask0);
            fiz0 = simd_masked_add(fiz0, simd_mul(delz0, force0), cutoff_mask0);
            fix1 = simd_masked_add(fix1, simd_mul(delx1, force1), cutoff_mask1);
            fiy1 = simd_masked_add(fiy1, simd_mul(dely1, force1), cutoff_mask1);
            fiz1 = simd_masked_add(fiz1, simd_mul(delz1, force1), cutoff_mask1);
            fix2 = simd_masked_add(fix2, simd_mul(delx2, force2), cutoff_mask2);
            fiy2 = simd_masked_add(fiy2, simd_mul(dely2, force2), cutoff_mask2);
            fiz2 = simd_masked_add(fiz2, simd_mul(delz2, force2), cutoff_mask2);
            fix3 = simd_masked_add(fix3, simd_mul(delx3, force3), cutoff_mask3);
            fiy3 = simd_masked_add(fiy3, simd_mul(dely3, force3), cutoff_mask3);
            fiz3 = simd_masked_add(fiz3, simd_mul(delz3, force3), cutoff_mask3);
        }

        cluster_x(cifptr, 0) = simd_horizontal_sum(fix0);
        cluster_y(cifptr, 0) = simd_horizontal_sum(fiy0);
        cluster_z(cifptr, 0) = simd_horizontal_sum(fiz0);
        cluster_x(cifptr, 1) = simd_horizontal_sum(fix1);
        cluster_y(cifptr, 1) = simd_horizontal_sum(fiy1);
        cluster_z(cifptr, 1) = simd_horizontal_sum(fiz1);
        cluster_x(cifptr, 2) = simd_horizontal_sum(fix2);
        cluster_y(cifptr, 2) = simd_horizontal_sum(fiy2);
        cluster_z(cifptr, 2) = simd_horizontal_sum(fiz2);
        cluster_x(cifptr, 3) = simd_horizontal_sum(fix3);
        cluster_y(cifptr, 3) = simd_horizontal_sum(fiy3);
        cluster_z(cifptr, 3) = simd_horizontal_sum(fiz3);

        addStat(stats->total_force_neighs, numneighs * CLUSTER_DIM_M * CLUSTER_DIM_N);
        addStat(stats->total_force_iters, numneighs / 2);
    }

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();
    DEBUG_MESSAGE("computeForceLJ_4xn end\n");
    return E-S;
}
