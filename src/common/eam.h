/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>

#include <atom.h>
#include <parameter.h>

#ifndef __EAM_H_
#define __EAM_H_
typedef struct {
    int nrho, nr;
    MD_FLOAT drho, dr, cut, mass;
    MD_FLOAT *frho, *rhor, *zr;
} Funcfl;

typedef struct {
    MD_FLOAT* fp;
    int nmax;
    int nrho, nr;
    int nrho_tot, nr_tot;
    MD_FLOAT dr, rdr, drho, rdrho;
    MD_FLOAT *frho, *rhor, *z2r;
    MD_FLOAT *rhor_spline, *frho_spline, *z2r_spline;
    Funcfl file;
} Eam;

void initEam(Eam* eam, Parameter* param);
void coeff(Eam* eam, Parameter* param);
void init_style(Eam* eam, Parameter* param);
void read_eam_file(Funcfl* file, const char* filename);
void file2array(Eam* eam);
void array2spline(Eam* eam, Parameter* param);
void interpolate(int n, MD_FLOAT delta, MD_FLOAT* f, MD_FLOAT* spline);
void grab(FILE* fptr, int n, MD_FLOAT* list);
#endif
