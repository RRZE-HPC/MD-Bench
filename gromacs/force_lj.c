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


double computeForceLJ(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
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
            for(int cii = 0; cii < atom->clusters[ci].natoms; cii++) {
                MD_FLOAT xtmp = cluster_x(ciptr, cii);
                MD_FLOAT ytmp = cluster_y(ciptr, cii);
                MD_FLOAT ztmp = cluster_z(ciptr, cii);
                MD_FLOAT fix = 0;
                MD_FLOAT fiy = 0;
                MD_FLOAT fiz = 0;

                for(int cjj = 0; cjj < atom->clusters[cj].natoms; cjj++) {
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
