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
#include <neighbor.h>
#include <parameter.h>
#include <atom.h>

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

extern void traceAddresses(Parameter *param, Atom *atom, Neighbor *neighbor, int timestep);
