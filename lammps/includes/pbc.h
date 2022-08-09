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
#include <atom.h>
#include <parameter.h>

#ifndef __PBC_H_
#define __PBC_H_
extern void initPbc();
extern void updatePbc_cpu(Atom*, Atom*, Parameter*, bool);
extern void updateAtomsPbc_cpu(Atom*, Atom*, Parameter*);
extern void setupPbc(Atom*, Parameter*);

#ifdef CUDA_TARGET
extern void updatePbc_cuda(Atom*, Atom*, Parameter*, bool);
extern void updateAtomsPbc_cuda(Atom*, Atom*, Parameter*);
#endif

#endif
