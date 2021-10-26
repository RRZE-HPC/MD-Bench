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
#include <stats.h>

#if defined(MEM_TRACER) || defined(INDEX_TRACER)
#include <stdio.h>
#include <stdlib.h>
#endif

#ifndef VECTOR_WIDTH
#   define VECTOR_WIDTH                 8
#endif

#ifndef TRACER_CONDITION
#   define TRACER_CONDITION                 (!(timestep % param->every))
#endif

#ifdef MEM_TRACER
#   define MEM_TRACER_INIT                  FILE *mem_tracer_fp; \
                                            if(TRACER_CONDITION) { \
                                                char mem_tracer_fn[128]; \
                                                snprintf(mem_tracer_fn, sizeof mem_tracer_fn, "mem_tracer_%d.out", timestep); \
                                                mem_tracer_fp = fopen(mem_tracer_fn, "w");
                                            }

#   define MEM_TRACER_END                   if(TRACER_CONDITION) { fclose(mem_tracer_fp); }
#   define MEM_TRACE(addr, op)              if(TRACER_CONDITION) { fprintf(mem_tracer_fp, "%c: %p\n", op, (void *)(&(addr))); }
#else
#   define MEM_TRACER_INIT
#   define MEM_TRACER_END
#   define MEM_TRACE(addr, op)
#endif

#ifdef INDEX_TRACER
#   define INDEX_TRACER_INIT                FILE *index_tracer_fp; \
                                            if(TRACER_CONDITION) { \
                                                char index_tracer_fn[128]; \
                                                snprintf(index_tracer_fn, sizeof index_tracer_fn, "index_tracer_%d.out", timestep); \
                                                index_tracer_fp = fopen(index_tracer_fn, "w"); \
                                            }

#   define INDEX_TRACER_END                 if(TRACER_CONDITION) { fclose(index_tracer_fp); }
#   define INDEX_TRACE_NATOMS(nl, ng, mn)   if(TRACER_CONDITION) { fprintf(index_tracer_fp, "N: %d %d %d\n", nl, ng, mn); }
#   define INDEX_TRACE_ATOM(a)              if(TRACER_CONDITION) { fprintf(index_tracer_fp, "A: %d\n", a); }
#   define INDEX_TRACE(l, e)                if(TRACER_CONDITION) { \
                                                for(int __i = 0; __i < (e); __i += VECTOR_WIDTH) { \
                                                    int __e = (((e) - __i) < VECTOR_WIDTH) ? ((e) - __i) : VECTOR_WIDTH; \
                                                    fprintf(index_tracer_fp, "I: "); \
                                                    for(int __j = 0; __j < __e; ++__j) { \
                                                        fprintf(index_tracer_fp, "%d ", l[__i + __j]); \
                                                    } \
                                                    fprintf(index_tracer_fp, "\n"); \
                                                } \
                                            }

#   define DIST_TRACE_SORT(l, e)            if(TRACER_CONDITION) { \
                                                for(int __i = 0; __i < (e); __i += VECTOR_WIDTH) { \
                                                    int __e = (((e) - __i) < VECTOR_WIDTH) ? ((e) - __i) : VECTOR_WIDTH; \
                                                    if(__e > 1) { \
                                                        for(int __j = __i; __j < __i + __e - 1; ++__j) { \
                                                            for(int __k = __i; __k < __i + __e - (__j - __i) - 1; ++__k) { \
                                                                if(l[__k] > l[__k + 1]) { \
                                                                    int __t = l[__k]; \
                                                                    l[__k] = l[__k + 1]; \
                                                                    l[__k + 1] = __t; \
                                                                } \
                                                            } \
                                                        } \
                                                    } \
                                                } \
                                            }

#   define DIST_TRACE(l, e)                 if(TRACER_CONDITION) { \
                                                for(int __i = 0; __i < (e); __i += VECTOR_WIDTH) { \
                                                    int __e = (((e) - __i) < VECTOR_WIDTH) ? ((e) - __i) : VECTOR_WIDTH; \
                                                    if(__e > 1) { \
                                                        fprintf(index_tracer_fp, "D: "); \
                                                        for(int __j = 0; __j < __e - 1; ++__j) { \
                                                            int __dist = abs(l[__i + __j + 1] - l[__i + __j]); \
                                                            fprintf(index_tracer_fp, "%d ", __dist); \
                                                        } \
                                                        fprintf(index_tracer_fp, "\n"); \
                                                    } \
                                                } \
                                            }
#else
#   define INDEX_TRACER_INIT
#   define INDEX_TRACER_END
#   define INDEX_TRACE_NATOMS(nl, ng, mn)
#   define INDEX_TRACE_ATOM(a)
#   define INDEX_TRACE(l, e)
#   define DIST_TRACE_SORT(l, e)
#   define DIST_TRACE(l, e)
#endif

double computeForceTracing(Parameter *param, Atom *atom, Neighbor *neighbor, Stats *stats, int first_exec, int timestep) {
    MEM_TRACER_INIT;
    INDEX_TRACER_INIT;
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

    INDEX_TRACE_NATOMS(Nlocal, atom->Nghost, neighbor->maxneighs);
    double S = getTimeStamp();
    LIKWID_MARKER_START("force");

    for(int na = 0; na < (first_exec ? 1 : ATOMS_LOOP_RUNS); na++) {
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

            MEM_TRACE(atom_x(i), 'R');
            MEM_TRACE(atom_y(i), 'R');
            MEM_TRACE(atom_z(i), 'R');
            INDEX_TRACE_ATOM(i);

            #ifdef EXPLICIT_TYPES
            const int type_i = atom->type[i];
            MEM_TRACE(atom->type(i), 'R');
            #endif

            #if defined(VARIANT) && VARIANT == stub && defined(NEIGHBORS_LOOP_RUNS) && NEIGHBORS_LOOP_RUNS > 1
            #define REPEAT_NEIGHBORS_LOOP
            int nmax = first_exec ? 1 : NEIGHBORS_LOOP_RUNS;
            for(int nn = 0; nn < (first_exec ? 1 : NEIGHBORS_LOOP_RUNS); nn++) {
            #endif

                //DIST_TRACE_SORT(neighs, numneighs);
                INDEX_TRACE(neighs, numneighs);
                //DIST_TRACE(neighs, numneighs);

                for(int k = 0; k < numneighs; k++) {
                    int j = neighs[k];
                    MD_FLOAT delx = xtmp - atom_x(j);
                    MD_FLOAT dely = ytmp - atom_y(j);
                    MD_FLOAT delz = ztmp - atom_z(j);
                    MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

                    MEM_TRACE(neighs[k], 'R');
                    MEM_TRACE(atom_x(j), 'R');
                    MEM_TRACE(atom_y(j), 'R');
                    MEM_TRACE(atom_z(j), 'R');

                    #ifdef EXPLICIT_TYPES
                    const int type_j = atom->type[j];
                    const int type_ij = type_i * atom->ntypes + type_j;
                    const MD_FLOAT cutforcesq = atom->cutforcesq[type_ij];
                    const MD_FLOAT sigma6 = atom->sigma6[type_ij];
                    const MD_FLOAT epsilon = atom->epsilon[type_ij];
                    MEM_TRACE(atom->type(j), 'R');
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

            addStat(stats->total_force_neighs, numneighs);
            addStat(stats->total_force_iters, (numneighs + VECTOR_WIDTH - 1) / VECTOR_WIDTH);
            MEM_TRACE(fx[i], 'R');
            MEM_TRACE(fx[i], 'W');
            MEM_TRACE(fy[i], 'R');
            MEM_TRACE(fy[i], 'W');
            MEM_TRACE(fz[i], 'R');
            MEM_TRACE(fz[i], 'W');
        }
    }

    LIKWID_MARKER_STOP("force");
    double E = getTimeStamp();

    INDEX_TRACER_END;
    MEM_TRACER_END;
    return E-S;
}
