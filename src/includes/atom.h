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
#include <parameter.h>

#ifndef __ATOM_H_
#define __ATOM_H_

typedef struct {
    int Natoms, Nlocal, Nghost, Nmax;
    MD_FLOAT *x, *y, *z;
    MD_FLOAT *vx, *vy, *vz;
    MD_FLOAT *fx, *fy, *fz;
    int *border_map;
    int *type;
    int ntypes;
    MD_FLOAT *epsilon;
    MD_FLOAT *sigma6;
    MD_FLOAT *cutforcesq;
    MD_FLOAT *cutneighsq;
} Atom;

extern void initAtom(Atom*);
extern void createAtom(Atom*, Parameter*);
extern void growAtom(Atom*);

#ifdef AOS
#define POS_DATA_LAYOUT     "AoS"

#define atom_x(i)           atom->x[(i) * 3 + 0]
#define atom_y(i)           atom->x[(i) * 3 + 1]
#define atom_z(i)           atom->x[(i) * 3 + 2]

#define atom_fx(i)          atom->fx[(i) * 3 + 0]
#define atom_fy(i)          atom->fx[(i) * 3 + 1]
#define atom_fz(i)          atom->fx[(i) * 3 + 2]

#else
#define POS_DATA_LAYOUT     "SoA"

#define atom_x(i)           atom->x[i]
#define atom_y(i)           atom->y[i]
#define atom_z(i)           atom->z[i]

#define atom_fx(i)           atom->fx[i]
#define atom_fy(i)           atom->fy[i]
#define atom_fz(i)           atom->fz[i]

#endif

#endif
