/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#ifndef __PARAMETER_H_
#define __PARAMETER_H_

#if PRECISION == 1
#   define MD_FLOAT float
#   define MD_UINT  unsigned int
#else
#   define MD_FLOAT double
#   define MD_UINT  unsigned long long int
#endif

typedef struct {
    int force_field;
    char* param_file;
    char* input_file;
    char* vtk_file;
    char* xtc_file;
    MD_FLOAT epsilon;
    MD_FLOAT sigma;
    MD_FLOAT sigma6;
    MD_FLOAT temp;
    MD_FLOAT rho;
    MD_FLOAT mass;
    int ntypes;
    int ntimes;
    int nstat;
    int reneigh_every;
    int prune_every;
    int x_out_every;
    int v_out_every;
    int half_neigh;
    MD_FLOAT dt;
    MD_FLOAT dtforce;
    MD_FLOAT skin;
    MD_FLOAT cutforce;
    MD_FLOAT cutneigh;
    int nx, ny, nz;
    int pbc_x, pbc_y, pbc_z;
    MD_FLOAT lattice;
    MD_FLOAT xlo, xhi, ylo, yhi, zlo, zhi;
    MD_FLOAT xprd, yprd, zprd;
    double proc_freq;
    char* eam_file;
    // DEM
    MD_FLOAT k_s;
    MD_FLOAT k_dn;
    MD_FLOAT gx, gy, gz;
    MD_FLOAT reflect_x, reflect_y, reflect_z;
} Parameter;

void initParameter(Parameter*);
void readParameter(Parameter*, const char*);
void printParameter(Parameter*);

#endif
