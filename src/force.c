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

#include <timing.h>
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>

#ifndef TRACER_PRINT
#   include <stdio.h>
#   ifdef MEM_TRACER
#       define TRACER_INIT              FILE *tracer_fp; \
                                        if(first_exec) { tracer_fp = fopen("mem_tracer.out", "w"); }
#       define TRACER_END               if(first_exec) { fclose(tracer_fp); }
#       define TRACER_PRINT(addr, op)   if(first_exec) { fprintf(tracer_fp, "%c: %p\n", op, (void *)(&(addr))); }
#   else
#       define TRACER_INIT
#       define TRACER_END
#       define TRACER_PRINT(addr, op)
#   endif
#endif

double computeForce(Parameter *param, Atom *atom, Neighbor *neighbor, int first_exec) {
    TRACER_INIT;
    double S = getTimeStamp();
    int Nlocal = atom->Nlocal;
    int* neighs;
    MD_FLOAT* fx = atom->fx; MD_FLOAT* fy = atom->fy; MD_FLOAT* fz = atom->fz;
    #ifndef EXPLICIT_TYPES
    MD_FLOAT cutforcesq = param->cutforce * param->cutforce;
    MD_FLOAT sigma6 = param->sigma6;
    MD_FLOAT epsilon = param->epsilon;
    #endif

    for(int i = 0; i < Nlocal; i++) {
        fx[i] = 0.0;
        fy[i] = 0.0;
        fz[i] = 0.0;
    }

    LIKWID_MARKER_START("force");
    #pragma omp parallel for
    for(int i = 0; i < Nlocal; i++) {
        neighs = &neighbor->neighbors[i * neighbor->maxneighs];
        int numneighs = neighbor->numneigh[i];
        MD_FLOAT xtmp = atom_x(i);
        MD_FLOAT ytmp = atom_y(i);
        MD_FLOAT ztmp = atom_z(i);
        MD_FLOAT fix = 0;
        MD_FLOAT fiy = 0;
        MD_FLOAT fiz = 0;

        TRACER_PRINT(atom_x(i), 'R');
        TRACER_PRINT(atom_y(i), 'R');
        TRACER_PRINT(atom_z(i), 'R');

        #ifdef EXPLICIT_TYPES
        const int type_i = atom->type[i];
        TRACER_PRINT(atom->type(i), 'R');
        #endif

        #if VARIANT == stub && defined(NEIGHBORS_LOOP_RUNS) && NEIGHBORS_LOOP_RUNS > 1
        #define REPEAT_NEIGHBORS_LOOP
        int nmax = first_exec ? 1 : NEIGHBORS_LOOP_RUNS;
        for(int n = 0; n < nmax; n++) {
        #endif

            for(int k = 0; k < numneighs; k++) {
                int j = neighs[k];
                MD_FLOAT delx = xtmp - atom_x(j);
                MD_FLOAT dely = ytmp - atom_y(j);
                MD_FLOAT delz = ztmp - atom_z(j);
                MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

                TRACER_PRINT(neighs[k], 'R');
                TRACER_PRINT(atom_x(j), 'R');
                TRACER_PRINT(atom_y(j), 'R');
                TRACER_PRINT(atom_z(j), 'R');

                #ifdef EXPLICIT_TYPES
                const int type_j = atom->type[j];
                const int type_ij = type_i * atom->ntypes + type_j;
                const MD_FLOAT cutforcesq = atom->cutforcesq[type_ij];
                const MD_FLOAT sigma6 = atom->sigma6[type_ij];
                const MD_FLOAT epsilon = atom->epsilon[type_ij];
                TRACER_PRINT(atom->type(j), 'R');
                #endif

                if(rsq < cutforcesq) {
                    MD_FLOAT sr2 = 1.0 / rsq;
                    MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
                    MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;
                    fix += delx * force;
                    fiy += dely * force;
                    fiz += delz * force;
                }
            }

        #ifdef REPEAT_NEIGHBORS_LOOP
        }
        #endif

        fx[i] += fix;
        fy[i] += fiy;
        fz[i] += fiz;

        TRACER_PRINT(fx[i], 'R');
        TRACER_PRINT(fx[i], 'W');
        TRACER_PRINT(fy[i], 'R');
        TRACER_PRINT(fy[i], 'W');
        TRACER_PRINT(fz[i], 'R');
        TRACER_PRINT(fz[i], 'W');
    }
    LIKWID_MARKER_STOP("force");

    double E = getTimeStamp();
    TRACER_END;
    return E-S;
}
