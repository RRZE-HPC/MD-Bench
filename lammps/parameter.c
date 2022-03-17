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
#include <stdlib.h>
#include <string.h>
//---
#include <parameter.h>
#include <util.h>

void initParameter(Parameter *param) {
    param->input_file = NULL;
    param->vtk_file = NULL;
    param->eam_file = NULL;
    param->force_field = FF_LJ;
    param->epsilon = 1.0;
    param->sigma = 1.0;
    param->sigma6 = 1.0;
    param->rho = 0.8442;
    param->ntypes = 4;
    param->ntimes = 200;
    param->dt = 0.005;
    param->nx = 32;
    param->ny = 32;
    param->nz = 32;
    param->cutforce = 2.5;
    param->skin = 0.3;
    param->cutneigh = param->cutforce + param->skin;
    param->temp = 1.44;
    param->nstat = 100;
    param->mass = 1.0;
    param->dtforce = 0.5 * param->dt;
    param->reneigh_every = 20;
    param->x_out_every = 20;
    param->v_out_every = 5;
    param->half_neigh = 1;
    param->proc_freq = 2.4;
}

void readParameter(Parameter *param, const char *filename) {
    FILE *fp = fopen(filename, "r");
    char line[MAXLINE];
    int i;

    if(!fp) {
        fprintf(stderr, "Could not open parameter file: %s\n", filename);
        exit(-1);
    }

    while(!feof(fp)) {
        line[0] = '\0';
        fgets(line, MAXLINE, fp);
        for(i = 0; line[i] != '\0' && line[i] != '#'; i++);
        line[i] = '\0';

        char *tok = strtok(line, " ");
        char *val = strtok(NULL, " ");

        #define PARSE_PARAM(p,f)   if(strncmp(tok, #p, sizeof(#p) / sizeof(#p[0]) - 1) == 0) { param->p = f(val); }
        #define PARSE_STRING(p)    PARSE_PARAM(p, strdup)
        #define PARSE_INT(p)       PARSE_PARAM(p, atoi)
        #define PARSE_REAL(p)      PARSE_PARAM(p, atof)

        if(tok != NULL && val != NULL) {
            PARSE_PARAM(force_field, str2ff);
            PARSE_STRING(input_file);
            PARSE_STRING(eam_file);
            PARSE_STRING(vtk_file);
            PARSE_REAL(epsilon);
            PARSE_REAL(sigma);
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
            PARSE_INT(nstat);
            PARSE_INT(reneigh_every);
            PARSE_INT(x_out_every);
            PARSE_INT(v_out_every);
            PARSE_INT(half_neigh);
        }
    }

    // Update sigma6 parameter
    MD_FLOAT s2 = param->sigma * param->sigma;
    param->sigma6 = s2 * s2 * s2;
    fclose(fp);
}

void printParameter(Parameter *param) {
    printf("Parameters:\n");
    if(param->input_file != NULL) {
        printf("Input file: %s\n", param->input_file);
    }

    if(param->vtk_file != NULL) {
        printf("VTK file: %s\n", param->vtk_file);
    }

    if(param->eam_file != NULL) {
        printf("EAM file: %s\n", param->eam_file);
    }

    printf("\tForce field: %s\n", ff2str(param->force_field));
    printf("\tUnit cells (nx, ny, nz): %d, %d, %d\n", param->nx, param->ny, param->nz);
    printf("\tDomain box sizes (x, y, z): %e, %e, %e\n", param->xprd, param->yprd, param->zprd);
    printf("\tLattice size: %e\n", param->lattice);
    printf("\tEpsilon: %e\n", param->epsilon);
    printf("\tSigma: %e\n", param->sigma);
    printf("\tTemperature: %e\n", param->temp);
    printf("\tRHO: %e\n", param->rho);
    printf("\tMass: %e\n", param->mass);
    printf("\tNumber of types: %d\n", param->ntypes);
    printf("\tNumber of timesteps: %d\n", param->ntimes);
    printf("\tReport stats every (timesteps): %d\n", param->nstat);
    printf("\tReneighbor every (timesteps): %d\n", param->reneigh_every);
    printf("\tOutput positions every (timesteps): %d\n", param->x_out_every);
    printf("\tOutput velocities every (timesteps): %d\n", param->v_out_every);
    printf("\tDelta time (dt): %e\n", param->dt);
    printf("\tCutoff radius: %e\n", param->cutforce);
    printf("\tSkin: %e\n", param->skin);
    printf("\tHalf neighbor lists: %d\n", param->half_neigh);
    printf("\tProcessor frequency (GHz): %.4f\n\n", param->proc_freq);
}
