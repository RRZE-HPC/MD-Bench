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
#include <parameter.h>

#ifndef __ATOM_H_
#define __ATOM_H_

typedef struct {
    int Natoms, Nlocal, Nghost, Nmax;
    MD_FLOAT *x, *y, *z;
    MD_FLOAT *vx, *vy, *vz;
    MD_FLOAT *fx, *fy, *fz;
} Atom;

extern void initAtom(Atom*);
extern void createAtom(Atom*, Parameter*);
extern void growAtom(Atom*);

#ifdef AOS
#define POS_DATA_LAYOUT         "AoS"
/* FIXME: these macros are resulting in segfault
#define set_atom_x(atom, i, v)  (atom->x[i * 3 + 0] = v)
#define set_atom_y(atom, i, v)  (atom->x[i * 3 + 1] = v)
#define set_atom_z(atom, i, v)  (atom->x[i * 3 + 2] = v)
*/
inline void set_atom_x(Atom *atom, int i, MD_FLOAT x) { atom->x[i * 3 + 0] = x; }
inline void set_atom_y(Atom *atom, int i, MD_FLOAT y) { atom->x[i * 3 + 1] = y; }
inline void set_atom_z(Atom *atom, int i, MD_FLOAT z) { atom->x[i * 3 + 2] = z; }
#define get_atom_x(atom, i)     (atom->x[i * 3 + 0])
#define get_atom_y(atom, i)     (atom->x[i * 3 + 1])
#define get_atom_z(atom, i)     (atom->x[i * 3 + 2])
#else
#define POS_DATA_LAYOUT         "SoA"
#define set_atom_x(atom, i, v)  (atom->x[i] = v)
#define set_atom_y(atom, i, v)  (atom->y[i] = v)
#define set_atom_z(atom, i, v)  (atom->z[i] = v)
#define get_atom_x(atom, i)     (atom->x[i])
#define get_atom_y(atom, i)     (atom->y[i])
#define get_atom_z(atom, i)     (atom->z[i])
#endif

#endif
