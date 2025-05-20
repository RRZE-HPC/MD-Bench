/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <atom.h>
#include <parameter.h>
#include <util.h>

#ifndef __INTEGRATE_H_
#define __INTEGRATE_H_

typedef void (*IntegrationFunction)(Parameter*, Atom*);
extern IntegrationFunction initialIntegrate;
extern IntegrationFunction finalIntegrate;

extern void initialIntegrateCPU(Parameter*, Atom*);
extern void finalIntegrateCPU(Parameter*, Atom*);

#ifdef CUDA_TARGET
extern void initialIntegrateCUDA(Parameter*, Atom*);
extern void finalIntegrateCUDA(Parameter*, Atom*);
#endif
#endif //_INTEGRATE_H_
