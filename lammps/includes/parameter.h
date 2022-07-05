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
#ifndef __PARAMETER_H_
#define __PARAMETER_H_

#if PRECISION == 1
#define MD_FLOAT float
#else
#define MD_FLOAT double
#endif

typedef struct {
    int force_field;
    char* param_file;
    char* input_file;
    char* vtk_file;
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
    int x_out_every;
    int v_out_every;
    int half_neigh;
    MD_FLOAT dt;
    MD_FLOAT dtforce;
    MD_FLOAT skin;
    MD_FLOAT cutforce;
    MD_FLOAT cutneigh;
    int nx, ny, nz;
    MD_FLOAT lattice;
    MD_FLOAT xlo, xhi, ylo, yhi, zlo, zhi;
    MD_FLOAT xprd, yprd, zprd;
    double proc_freq;
    char* eam_file;
    // DEM
    MD_FLOAT k_s;
    MD_FLOAT k_dn;
    MD_FLOAT gx, gy, gz;
} Parameter;

void initParameter(Parameter*);
void readParameter(Parameter*, const char*);
void printParameter(Parameter*);

#endif
