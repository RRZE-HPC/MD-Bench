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
void init_style(Eam* eam, Parameter *param);
void read_file(Funcfl* file, const char* filename);
void file2array(Eam* eam);
void array2spline(Eam* eam, Parameter* param);
void interpolate(int n, MD_FLOAT delta, MD_FLOAT* f, MD_FLOAT* spline);
void grab(FILE* fptr, int n, MD_FLOAT* list);
#endif
