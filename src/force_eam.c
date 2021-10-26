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
#include <likwid-marker.h>
#include <math.h>

#include <allocate.h>
#include <timing.h>
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>
#include <stats.h>
#include <eam.h>
#include <util.h>

double computeForceEam(Eam* eam, Atom *atom, Neighbor *neighbor, Stats *stats, int first_exec, int timestep) {
    if(eam->nmax < atom->Nmax) {
        eam->nmax = atom->Nmax;
        if(eam->fp != NULL) { free(eam->fp); }
        eam->fp = (MD_FLOAT *) allocate(ALIGNMENT, atom->Nmax * sizeof(MD_FLOAT));
    }

    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT* fx = atom->fx; MD_FLOAT* fy = atom->fy; MD_FLOAT* fz = atom->fz; int ntypes = atom->ntypes; MD_FLOAT* fp = eam->fp;
    MD_FLOAT* rhor_spline = eam->rhor_spline; MD_FLOAT* frho_spline = eam->frho_spline; MD_FLOAT* z2r_spline = eam->z2r_spline;
    int rdr = eam->rdr; int nr = eam->nr; int nr_tot = eam->nr_tot; int rdrho = eam->rdrho;
    int nrho = eam->nrho; int nrho_tot = eam->nrho_tot;
    double S = getTimeStamp();
    LIKWID_MARKER_START("force_eam_fp");

    #pragma omp parallel for
    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MD_FLOAT xtmp = atom_x(i);
        MD_FLOAT ytmp = atom_y(i);
        MD_FLOAT ztmp = atom_z(i);
        MD_FLOAT rhoi = 0;
        const int type_i = atom->type[i];

        #pragma ivdep
        for(int k = 0; k < numneighs; k++) {
            int j = neighs[k];
            MD_FLOAT delx = xtmp - atom_x(j);
            MD_FLOAT dely = ytmp - atom_y(j);
            MD_FLOAT delz = ztmp - atom_z(j);
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;
            const int type_j = atom->type[j];
            const int type_ij = type_i * ntypes + type_j;
            const MD_FLOAT cutforcesq = atom->cutforcesq[type_ij];

            if(rsq < cutforcesq) {
                MD_FLOAT p = sqrt(rsq) * rdr + 1.0;
                int m = (int)(p);
                m = m < nr - 1 ? m : nr - 1;
                p -= m;
                p = p < 1.0 ? p : 1.0;
                rhoi += ((rhor_spline[type_ij * nr_tot + m * 7 + 3] * p +
                          rhor_spline[type_ij * nr_tot + m * 7 + 4]) * p +
                          rhor_spline[type_ij * nr_tot + m * 7 + 5]) * p +
                          rhor_spline[type_ij * nr_tot + m * 7 + 6];
            }
        }

        const int type_ii = type_i * type_i;
        MD_FLOAT p = 1.0 * rhoi * rdrho + 1.0;
        int m = (int)(p);
        m = MAX(1, MIN(m, nrho - 1));
        p -= m;
        p = MIN(p, 1.0);
        fp[i] = (frho_spline[type_ii * nrho_tot + m * 7 + 0] * p +
                 frho_spline[type_ii * nrho_tot + m * 7 + 1]) * p +
                 frho_spline[type_ii * nrho_tot + m * 7 + 2];
    }
    LIKWID_MARKER_STOP("force_eam_fp");
    LIKWID_MARKER_START("force_eam");

    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MD_FLOAT xtmp = atom_x(i);
        MD_FLOAT ytmp = atom_y(i);
        MD_FLOAT ztmp = atom_z(i);
        MD_FLOAT fix = 0;
        MD_FLOAT fiy = 0;
        MD_FLOAT fiz = 0;
        const int type_i = atom->type[i];

        #pragma ivdep
        for(int k = 0; k < numneighs; k++) {
            int j = neighs[k];
            MD_FLOAT delx = xtmp - atom_x(j);
            MD_FLOAT dely = ytmp - atom_y(j);
            MD_FLOAT delz = ztmp - atom_z(j);
            MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;
            const int type_j = atom->type[j];
            const int type_ij = type_i * ntypes + type_j;
            const MD_FLOAT cutforcesq = atom->cutforcesq[type_ij];

            if(rsq < cutforcesq) {
                MD_FLOAT r = sqrt(rsq);
                MD_FLOAT p = r * rdr + 1.0;
                int m = (int)(p);
                m = m < nr - 1 ? m : nr - 1;
                p -= m;
                p = p < 1.0 ? p : 1.0;


                // rhoip = derivative of (density at atom j due to atom i)
                // rhojp = derivative of (density at atom i due to atom j)
                // phi = pair potential energy
                // phip = phi'
                // z2 = phi * r
                // z2p = (phi * r)' = (phi' r) + phi
                // psip needs both fp[i] and fp[j] terms since r_ij appears in two
                //   terms of embed eng: Fi(sum rho_ij) and Fj(sum rho_ji)
                //   hence embed' = Fi(sum rho_ij) rhojp + Fj(sum rho_ji) rhoip

                MD_FLOAT rhoip = (rhor_spline[type_ij * nr_tot + m * 7 + 0] * p +
                                  rhor_spline[type_ij * nr_tot + m * 7 + 1]) * p +
                                  rhor_spline[type_ij * nr_tot + m * 7 + 2];

                MD_FLOAT z2p = (z2r_spline[type_ij * nr_tot + m * 7 + 0] * p +
                                z2r_spline[type_ij * nr_tot + m * 7 + 1]) * p +
                                z2r_spline[type_ij * nr_tot + m * 7 + 2];

                MD_FLOAT z2 = ((z2r_spline[type_ij * nr_tot + m * 7 + 3] * p +
                                z2r_spline[type_ij * nr_tot + m * 7 + 4]) * p +
                                z2r_spline[type_ij * nr_tot + m * 7 + 5]) * p +
                                z2r_spline[type_ij * nr_tot + m * 7 + 6];

                MD_FLOAT recip = 1.0 / r;
                MD_FLOAT phi = z2 * recip;
                MD_FLOAT phip = z2p * recip - phi * recip;
                MD_FLOAT psip = fp[i] * rhoip + fp[j] * rhoip + phip;
                MD_FLOAT fpair = -psip * recip;

                fix += delx * fpair;
                fiy += dely * fpair;
                fiz += delz * fpair;
                //fpair *= 0.5;
            }
        }

        fx[i] = fix;
        fy[i] = fiy;
        fz[i] = fiz;
        addStat(stats->total_force_neighs, numneighs);
        addStat(stats->total_force_iters, (numneighs + VECTOR_WIDTH - 1) / VECTOR_WIDTH);
    }

    LIKWID_MARKER_STOP("force_eam");
    double E = getTimeStamp();
    return E-S;
}
