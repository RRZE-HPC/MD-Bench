/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <atom.h>
#include <force.h>
#include <parameter.h>
#include <util.h>

void initParameter(Parameter* param)
{
    param->input_file      = NULL;
    param->vtk_file        = NULL;
    param->xtc_file        = NULL;
    param->eam_file        = NULL;
    param->write_atom_file = NULL;
    param->force_field     = FF_LJ;
    param->epsilon         = 1.0;
    param->sigma           = 1.0;
    param->sigma6          = 1.0;
    param->rho             = 0.8442;
    param->ntypes          = 4;
    param->ntimes          = 200;
    param->dt              = 0.005;
    param->nx              = 32;
    param->ny              = 32;
    param->nz              = 32;
    param->pbc_x           = 1;
    param->pbc_y           = 1;
    param->pbc_z           = 1;
    param->cutforce        = 2.5;
    param->skin            = 0.3;
    param->cutneigh        = param->cutforce + param->skin;
    param->temp            = 1.44;
    param->nstat           = 100;
    param->mass            = 1.0;
    param->dtforce         = 0.5 * param->dt;
    param->reneigh_every   = 20;
    param->prune_every     = 1000;
    param->x_out_every     = 20;
    param->v_out_every     = 5;
    param->half_neigh      = 0;
    param->proc_freq       = 2.4;
    // DEM
    param->k_s       = 1.0;
    param->k_dn      = 1.0;
    param->gx        = 0.0;
    param->gy        = 0.0;
    param->gz        = 0.0;
    param->reflect_x = 0.0;
    param->reflect_y = 0.0;
    param->reflect_z = 0.0;
}

void readParameter(Parameter* param, const char* filename)
{
    FILE* fp = fopen(filename, "r");
    char line[MAXLINE];
    int i;

    if (!fp) {
        fprintf(stderr, "Could not open parameter file: %s\n", filename);
        exit(-1);
    }

    while (!feof(fp)) {
        line[0] = '\0';
        readline(line, fp);
        for (i = 0; line[i] != '\0' && line[i] != '#'; i++)
            ;
        line[i] = '\0';

        char* tok = strtok(line, " ");
        char* val = strtok(NULL, " ");

#define PARSE_PARAM(p, f)                                                                \
    if (strncmp(tok, #p, sizeof(#p) / sizeof(#p[0]) - 1) == 0) {                         \
        param->p = f(val);                                                               \
    }
#define PARSE_STRING(p) PARSE_PARAM(p, strdup)
#define PARSE_INT(p)    PARSE_PARAM(p, atoi)
#define PARSE_REAL(p)   PARSE_PARAM(p, atof)

        if (tok != NULL && val != NULL) {
            PARSE_PARAM(force_field, str2ff);
            PARSE_STRING(input_file);
            PARSE_STRING(eam_file);
            PARSE_STRING(vtk_file);
            PARSE_STRING(xtc_file);
            PARSE_REAL(epsilon);
            PARSE_REAL(sigma);
            PARSE_REAL(k_s);
            PARSE_REAL(k_dn);
            PARSE_REAL(reflect_x);
            PARSE_REAL(reflect_y);
            PARSE_REAL(reflect_z);
            PARSE_REAL(gx);
            PARSE_REAL(gy);
            PARSE_REAL(gz);
            PARSE_REAL(rho);
            PARSE_REAL(dt);
            PARSE_REAL(cutforce);
            PARSE_REAL(skin);
            PARSE_REAL(temp);
            PARSE_REAL(mass);
            PARSE_REAL(proc_freq);
            PARSE_INT(ntypes);
            PARSE_INT(ntimes);
            PARSE_INT(nx);
            PARSE_INT(ny);
            PARSE_INT(nz);
            PARSE_INT(pbc_x);
            PARSE_INT(pbc_y);
            PARSE_INT(pbc_z);
            PARSE_INT(nstat);
            PARSE_INT(reneigh_every);
            PARSE_INT(prune_every);
            PARSE_INT(x_out_every);
            PARSE_INT(v_out_every);
            PARSE_INT(half_neigh);
        }
    }

    // Update dtforce
    param->dtforce = 0.5 * param->dt;

    // Update sigma6 parameter
    MD_FLOAT s2   = param->sigma * param->sigma;
    param->sigma6 = s2 * s2 * s2;
    fclose(fp);
}

void printParameter(Parameter* param)
{
    printf("Parameters:\n");
    if (param->input_file != NULL) {
        printf("\tInput file: %s\n", param->input_file);
    }

    if (param->vtk_file != NULL) {
        printf("\tVTK file: %s\n", param->vtk_file);
    }

    if (param->xtc_file != NULL) {
        printf("\tXTC file: %s\n", param->xtc_file);
    }

    if (param->eam_file != NULL) {
        printf("\tEAM file: %s\n", param->eam_file);
    }

    printf("\tForce field: %s\n", ff2str(param->force_field));
#ifdef CLUSTER_M
    printf("\tKernel: %s, MxN: %dx%d, Vector width: %d\n",
        KERNEL_NAME,
        CLUSTER_M,
        CLUSTER_N,
        VECTOR_WIDTH);
#else
    printf("\tKernel: %s\n", KERNEL_NAME);
#endif
    printf("\tData layout: %s\n", POS_DATA_LAYOUT);
    printf("\tFloating-point precision: %s\n", PRECISION_STRING);
    printf("\tUnit cells (nx, ny, nz): %d, %d, %d\n", param->nx, param->ny, param->nz);
    printf("\tDomain box sizes (x, y, z): %e, %e, %e\n",
        param->xprd,
        param->yprd,
        param->zprd);
    printf("\tPeriodic (x, y, z): %d, %d, %d\n",
        param->pbc_x,
        param->pbc_y,
        param->pbc_z);
    printf("\tLattice size: %e\n", param->lattice);
    printf("\tEpsilon: %e\n", param->epsilon);
    printf("\tSigma: %e\n", param->sigma);
    printf("\tSpring constant: %e\n", param->k_s);
    printf("\tDamping constant: %e\n", param->k_dn);
    printf("\tTemperature: %e\n", param->temp);
    printf("\tRHO: %e\n", param->rho);
    printf("\tMass: %e\n", param->mass);
    printf("\tNumber of types: %d\n", param->ntypes);
    printf("\tNumber of timesteps: %d\n", param->ntimes);
    printf("\tReport stats every (timesteps): %d\n", param->nstat);
    printf("\tReneighbor every (timesteps): %d\n", param->reneigh_every);
#ifdef SORT_ATOMS
    printf("\tSort atoms when reneighboring: yes\n");
#else
    printf("\tSort atoms when reneighboring: no\n");
#endif
    printf("\tPrune every (timesteps): %d\n", param->prune_every);
    printf("\tOutput positions every (timesteps): %d\n", param->x_out_every);
    printf("\tOutput velocities every (timesteps): %d\n", param->v_out_every);
    printf("\tDelta time (dt): %e\n", param->dt);
    printf("\tCutoff radius: %e\n", param->cutforce);
    printf("\tSkin: %e\n", param->skin);
    printf("\tHalf neighbor lists: %d\n", param->half_neigh);
    printf("\tProcessor frequency (GHz): %.4f\n", param->proc_freq);
}
