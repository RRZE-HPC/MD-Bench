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
#include <stdbool.h>
//---
#include <parameter.h>
#include <atom.h>

void initialIntegrate_cpu(bool reneigh, Parameter *param, Atom *atom) {
    for(int i = 0; i < atom->Nlocal; i++) {
        atom_vx(i) += param->dtforce * atom_fx(i);
        atom_vy(i) += param->dtforce * atom_fy(i);
        atom_vz(i) += param->dtforce * atom_fz(i);
        atom_x(i) = atom_x(i) + param->dt * atom_vx(i);
        atom_y(i) = atom_y(i) + param->dt * atom_vy(i);
        atom_z(i) = atom_z(i) + param->dt * atom_vz(i);
    }
}

void finalIntegrate_cpu(bool reneigh, Parameter *param, Atom *atom) {
    for(int i = 0; i < atom->Nlocal; i++) {
        atom_vx(i) += param->dtforce * atom_fx(i);
        atom_vy(i) += param->dtforce * atom_fy(i);
        atom_vz(i) += param->dtforce * atom_fz(i);
    }
}

#ifdef CUDA_TARGET
void initialIntegrate_cuda(bool, Parameter*, Atom*);
void finalIntegrate_cuda(bool, Parameter*, Atom*);
#endif
