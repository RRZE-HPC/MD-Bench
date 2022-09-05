/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <math.h>
//---
#include <atom.h>
#include <likwid-marker.h>
#include <neighbor.h>
#include <parameter.h>
#include <stats.h>
#include <timing.h>


double computeForceDemFullNeigh(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats) {
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT k_s = param->k_s;
    MD_FLOAT k_dn = param->k_dn;
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;

    for(int i = 0; i < Nlocal; i++) {
        atom_fx(i) = 0.0;
        atom_fy(i) = 0.0;
        atom_fz(i) = 0.0;
    }

    double S = getTimeStamp();
    LIKWID_MARKER_START("force");

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

            if(rsq < cutforcesq) {
                MD_FLOAT r = sqrt(rsq);
                MD_FLOAT p = irad + jrad - r;

                if(p > 0) {
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
                    atom_fx(i) += k_s * p * nx - k_dn * nvx;
                    atom_fy(i) += k_s * p * ny - k_dn * nvy;
                    atom_fz(i) += k_s * p * nz - k_dn * nvz;
                    atom_fx(j) += -k_s * p * nx - k_dn * nvx;
                    atom_fy(j) += -k_s * p * ny - k_dn * nvy;
                    atom_fz(j) += -k_s * p * nz - k_dn * nvz;

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

        addStat(stats->total_force_neighs, numneighs);
        addStat(stats->total_force_iters, (numneighs + VECTOR_WIDTH - 1) / VECTOR_WIDTH);
    }

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();
    return E-S;
}
