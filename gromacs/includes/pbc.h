/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <atom.h>
#include <parameter.h>

#ifndef __PBC_H_
#define __PBC_H_
extern void initPbc();
extern void cpuUpdatePbc(Atom*, Parameter*, int);
extern void updateAtomsPbc(Atom*, Parameter*);
extern void setupPbc(Atom*, Parameter*);

#ifdef CUDA_TARGET
extern void cudaUpdatePbc(Atom*, Parameter*, int);
#if defined(USE_SUPER_CLUSTERS)
extern void setupPbcGPU(Atom*, Parameter*);
#endif //defined(USE_SUPER_CLUSTERS)
#endif
#endif
