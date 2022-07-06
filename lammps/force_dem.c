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
#include <math.h>
#include <likwid-marker.h>

#include <timing.h>
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>
#include <stats.h>

// TODO: Joint common files for gromacs and lammps variants
#include "../gromacs/includes/simd.h"

double computeForceDemFullNeigh(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT k_s = param->k_s;
    MD_FLOAT k_dn = param->k_dn;
#ifndef EXPLICIT_TYPES
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
#endif

    for(int i = 0; i < Nlocal; i++) {
        atom_fx(i) = 0.0;
        atom_fy(i) = 0.0;
        atom_fz(i) = 0.0;
    }

    double S = getTimeStamp();
    LIKWID_MARKER_START("force");

#pragma omp parallel for
    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MD_FLOAT irad = atom->radius[i];
        MD_FLOAT xtmp = atom_x(i);
        MD_FLOAT ytmp = atom_y(i);
        MD_FLOAT ztmp = atom_z(i);
        MD_FLOAT fix = 0;
        MD_FLOAT fiy = 0;
        MD_FLOAT fiz = 0;

#ifdef EXPLICIT_TYPES
        const int type_i = atom->type[i];
#endif

        for(int k = 0; k < numneighs; k++) {
            int j = neighs[k];
            MD_FLOAT jrad = atom->radius[j];
            MD_FLOAT xj = atom_x(j);
            MD_FLOAT yj = atom_y(j);
            MD_FLOAT zj = atom_z(j);
            MD_FLOAT delx = xtmp - xj;
            MD_FLOAT dely = ytmp - yj;
            MD_FLOAT delz = ztmp - zj;
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

#ifdef EXPLICIT_TYPES
            const int type_j = atom->type[j];
            const int type_ij = type_i * atom->ntypes + type_j;
            const MD_FLOAT cutforcesq = atom->cutforcesq[type_ij];
#endif

            if(rsq < cutforcesq) {
                MD_FLOAT r = sqrt(rsq);
                // penetration depth
                MD_FLOAT p = irad + jrad - r;
                if(p >= 0) {
                    // contact position
                    //MD_FLOAT cterm = jrad / (irad + jrad);
                    //MD_FLOAT cx = xj + cterm * delx;
                    //MD_FLOAT cy = yj + cterm * dely;
                    //MD_FLOAT cz = zj + cterm * delz;

                    // delta contact and particle position
                    //MD_FLOAT delcx = cx - xtmp;
                    //MD_FLOAT delcy = cy - ytmp;
                    //MD_FLOAT delcz = cz - ztmp;

                    // contact velocity
                    //MD_FLOAT cvx = (atom_vx(i) + atom_avx(i) * delcx) - (atom_vx(j) + atom_avx(j) * (cx - xj));
                    //MD_FLOAT cvy = (atom_vy(i) + atom_avy(i) * delcy) - (atom_vy(j) + atom_avy(j) * (cy - yj));
                    //MD_FLOAT cvz = (atom_vz(i) + atom_avz(i) * delcz) - (atom_vz(j) + atom_avz(j) * (cz - zj));
                    MD_FLOAT delvx = atom_vx(i) - atom_vx(j);
                    MD_FLOAT delvy = atom_vy(i) - atom_vy(j);
                    MD_FLOAT delvz = atom_vz(i) - atom_vz(j);
                    MD_FLOAT vr = sqrt(delvx * delvx + delvy * delvy + delvz * delvz);

                    // normal distance
                    MD_FLOAT nx = delx / r;
                    MD_FLOAT ny = dely / r;
                    MD_FLOAT nz = delz / r;

                    // normal contact velocity
                    MD_FLOAT nvx = delvx / vr;
                    MD_FLOAT nvy = delvy / vr;
                    MD_FLOAT nvz = delvz / vr;

                    // forces
                    fix += k_s * p * nx - k_dn * nvx;
                    fiy += k_s * p * ny - k_dn * nvy;
                    fiz += k_s * p * nz - k_dn * nvz;

                    // tangential force
                    //fix += MIN(kdt * vtsq, kf * fnx) * tx;
                    //fiy += MIN(kdt * vtsq, kf * fny) * ty;
                    //fiz += MIN(kdt * vtsq, kf * fnz) * tz;
                    // torque
                    //MD_FLOAT taux = delcx * ftx;
                    //MD_FLOAT tauy = delcy * fty;
                    //MD_FLOAT tauz = delcz * ftz;
                }
#ifdef USE_REFERENCE_VERSION
                addStat(stats->atoms_within_cutoff, 1);
            } else {
                addStat(stats->atoms_outside_cutoff, 1);
#endif
            }
        }

        atom_fx(i) += fix;
        atom_fy(i) += fiy;
        atom_fz(i) += fiz;

        addStat(stats->total_force_neighs, numneighs);
        addStat(stats->total_force_iters, (numneighs + VECTOR_WIDTH - 1) / VECTOR_WIDTH);
    }

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();
    return E-S;
}

double computeForceDemHalfNeigh(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    int Nlocal = atom->Nlocal;
    int* neighs;
#ifndef EXPLICIT_TYPES
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;
#endif

    for(int i = 0; i < Nlocal; i++) {
        atom_fx(i) = 0.0;
        atom_fy(i) = 0.0;
        atom_fz(i) = 0.0;
    }

    double S = getTimeStamp();
    LIKWID_MARKER_START("forceLJ-halfneigh");

    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MD_FLOAT xtmp = atom_x(i);
        MD_FLOAT ytmp = atom_y(i);
        MD_FLOAT ztmp = atom_z(i);
        MD_FLOAT fix = 0;
        MD_FLOAT fiy = 0;
        MD_FLOAT fiz = 0;

#ifdef EXPLICIT_TYPES
        const int type_i = atom->type[i];
#endif

        // Pragma required to vectorize the inner loop
#ifdef ENABLE_OMP_SIMD
        #pragma omp simd reduction(+: fix,fiy,fiz)
#endif
        for(int k = 0; k < numneighs; k++) {
            int j = neighs[k];
            MD_FLOAT delx = xtmp - atom_x(j);
            MD_FLOAT dely = ytmp - atom_y(j);
            MD_FLOAT delz = ztmp - atom_z(j);
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

#ifdef EXPLICIT_TYPES
            const int type_j = atom->type[j];
            const int type_ij = type_i * atom->ntypes + type_j;
            const MD_FLOAT cutforcesq = atom->cutforcesq[type_ij];
            const MD_FLOAT sigma6 = atom->sigma6[type_ij];
            const MD_FLOAT epsilon = atom->epsilon[type_ij];
#endif

            if(rsq < cutforcesq) {
                MD_FLOAT sr2 = 1.0 / rsq;
                MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
                MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;
                fix += delx * force;
                fiy += dely * force;
                fiz += delz * force;

                // We do not need to update forces for ghost atoms
                if(j < Nlocal) {
                    atom_fx(j) -= delx * force;
                    atom_fy(j) -= dely * force;
                    atom_fz(j) -= delz * force;
                }
            }
        }

        atom_fx(i) += fix;
        atom_fy(i) += fiy;
        atom_fz(i) += fiz;

        addStat(stats->total_force_neighs, numneighs);
        addStat(stats->total_force_iters, (numneighs + VECTOR_WIDTH - 1) / VECTOR_WIDTH);
    }

    LIKWID_MARKER_STOP("forceLJ-halfneigh");
    double E = getTimeStamp();
    return E-S;
}
