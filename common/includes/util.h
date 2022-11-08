/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
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
extern void readline(char *line, FILE *fp);

#endif
