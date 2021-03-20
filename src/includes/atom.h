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
inline const char *posDataLayout() { return "AoS"; }
inline void set_atom_x(Atom *atom, int i, MD_FLOAT x) { atom->x[i * 3 + 0] = x; }
inline void set_atom_y(Atom *atom, int i, MD_FLOAT y) { atom->x[i * 3 + 1] = y; }
inline void set_atom_z(Atom *atom, int i, MD_FLOAT z) { atom->x[i * 3 + 2] = z; }
inline MD_FLOAT get_atom_x(Atom *atom, int i) { return atom->x[i * 3 + 0]; }
inline MD_FLOAT get_atom_y(Atom *atom, int i) { return atom->x[i * 3 + 1]; }
inline MD_FLOAT get_atom_z(Atom *atom, int i) { return atom->x[i * 3 + 2]; }
#else
inline const char *posDataLayout() { return "SoA"; }
inline void set_atom_x(Atom *atom, int i, MD_FLOAT x) { atom->x[i] = x; }
inline void set_atom_y(Atom *atom, int i, MD_FLOAT y) { atom->y[i] = y; }
inline void set_atom_z(Atom *atom, int i, MD_FLOAT z) { atom->z[i] = z; }
inline MD_FLOAT get_atom_x(Atom *atom, int i) { return atom->x[i]; }
inline MD_FLOAT get_atom_y(Atom *atom, int i) { return atom->y[i]; }
inline MD_FLOAT get_atom_z(Atom *atom, int i) { return atom->z[i]; }
#endif

#endif
