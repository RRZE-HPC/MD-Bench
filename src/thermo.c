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
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include <thermo.h>

static int *steparr;
static MD_FLOAT *tmparr;
static MD_FLOAT *engarr;
static MD_FLOAT *prsarr;
static MD_FLOAT mvv2e;
static int dof_boltz;
static MD_FLOAT t_scale;
static MD_FLOAT p_scale;
static MD_FLOAT e_scale;
static MD_FLOAT t_act;
static MD_FLOAT p_act;
static MD_FLOAT e_act;
static int mstat;

/* exported subroutines */
void setupThermo(Parameter *param, int natoms)
{
    int maxstat = param->ntimes / param->nstat + 2;

    steparr = (int*) malloc(maxstat * sizeof(int));
    tmparr = (MD_FLOAT*) malloc(maxstat * sizeof(MD_FLOAT));
    engarr = (MD_FLOAT*) malloc(maxstat * sizeof(MD_FLOAT));
    prsarr = (MD_FLOAT*) malloc(maxstat * sizeof(MD_FLOAT));

    mvv2e = 1.0;
    dof_boltz = (natoms * 3 - 3);
    t_scale = mvv2e / dof_boltz;
    p_scale = 1.0 / 3 / param->xprd / param->yprd / param->zprd;
    e_scale = 0.5;

    printf("step\ttemp\t\tpressure\n");
}

void computeThermo(int iflag, Parameter *param, Atom *atom)
{
    MD_FLOAT t = 0.0, p;
    MD_FLOAT* vx = atom->vx;
    MD_FLOAT* vy = atom->vy;
    MD_FLOAT* vz = atom->vz;

    for(int i = 0; i < atom->Nlocal; i++) {
        t += (vx[i] * vx[i] + vy[i] * vy[i] + vz[i] * vz[i]) * param->mass;
    }

    t = t * t_scale;
    p = (t * dof_boltz) * p_scale;

    int istep = iflag;

    if(iflag == -1){
        istep = param->ntimes;
    }
    if(iflag == 0){
        mstat = 0;
    }

    steparr[mstat] = istep;
    tmparr[mstat] = t;
    prsarr[mstat] = p;
    mstat++;
    fprintf(stdout, "%i\t%e\t%e\n", istep, t, p);
}

void adjustThermo(Parameter *param, Atom *atom)
{
    /* zero center-of-mass motion */
    MD_FLOAT vxtot = 0.0; MD_FLOAT vytot = 0.0; MD_FLOAT vztot = 0.0;
    MD_FLOAT* vx = atom->vx; MD_FLOAT* vy = atom->vy; MD_FLOAT* vz = atom->vz;

    for(int i = 0; i < atom->Nlocal; i++) {
        vxtot += vx[i];
        vytot += vy[i];
        vztot += vz[i];
    }

    vxtot = vxtot / atom->Natoms;
    vytot = vytot / atom->Natoms;
    vztot = vztot / atom->Natoms;

    for(int i = 0; i < atom->Nlocal; i++) {
        vx[i] -= vxtot;
        vy[i] -= vytot;
        vz[i] -= vztot;
    }

    t_act = 0;
    MD_FLOAT t = 0.0;

    for(int i = 0; i < atom->Nlocal; i++) {
        t += (vx[i] * vx[i] + vy[i] * vy[i] + vz[i] * vz[i]) * param->mass;
    }

    t *= t_scale;
    MD_FLOAT factor = sqrt(param->temp / t);

    for(int i = 0; i < atom->Nlocal; i++) {
        vx[i] *= factor;
        vy[i] *= factor;
        vz[i] *= factor;
    }
}
