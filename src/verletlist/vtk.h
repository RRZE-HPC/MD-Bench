/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <atom.h>
#include <comm.h>
#include <parameter.h>

#ifndef __VTK_H_
#define __VTK_H_
extern int write_atoms_to_vtk_file(const char* filename, Atom* atom, int timestep);
extern void printvtk(
    const char* filename, Comm* comm, Atom* atom, Parameter* param, int timestep);
#endif
