/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
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
