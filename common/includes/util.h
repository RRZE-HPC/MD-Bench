/*
 * =======================================================================================
 *
 *   Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *   Copyright (c) 2020 RRZE, University Erlangen-Nuremberg
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
#ifndef __UTIL_H_
#define __UTIL_H_

#ifndef MIN
#   define MIN(x,y) ((x)<(y)?(x):(y))
#endif

#ifndef MAX
#   define MAX(x,y) ((x)>(y)?(x):(y))
#endif

#ifndef ABS
#   define ABS(a) ((a) >= 0 ? (a) : -(a))
#endif

#ifdef DEBUG
#   define DEBUG_MESSAGE   printf
#else
#   define DEBUG_MESSAGE
#endif

#ifndef MAXLINE
#   define MAXLINE 4096
#endif

#define FF_LJ   0
#define FF_EAM  1
#define FF_DEM  2

#if PRECISION == 1
#   define PRECISION_STRING     "single"
#else
#   define PRECISION_STRING     "double"
#endif

extern double myrandom(int*);
extern void random_reset(int *seed, int ibase, double *coord);
extern int str2ff(const char *string);
extern const char* ff2str(int ff);
extern int get_num_threads();

#endif
