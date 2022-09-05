/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdbool.h>
//---
#include <atom.h>
#include <parameter.h>

#ifndef __PBC_H_
#define __PBC_H_
extern void initPbc();
extern void updatePbc_cpu(Atom*, Parameter*, bool);
extern void updateAtomsPbc_cpu(Atom*, Parameter*);
extern void setupPbc(Atom*, Parameter*);

#ifdef CUDA_TARGET
extern void updatePbc_cuda(Atom*, Parameter*, bool);
extern void updateAtomsPbc_cuda(Atom*, Parameter*);
#endif

#endif
