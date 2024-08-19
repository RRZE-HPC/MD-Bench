/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdbool.h>

#include <atom.h>
#include <parameter.h>

typedef void (*IntegrationFunction)(bool, Parameter*, Atom*);
extern IntegrationFunction initialIntegrate;
extern IntegrationFunction finalIntegrate;

extern void initialIntegrateCPU(bool reneigh, Parameter* param, Atom* atom); 
extern void finalIntegrateCPU(bool reneigh, Parameter* param, Atom* atom);

#ifdef CUDA_TARGET
extern void initialIntegrateCUDA(bool, Parameter*, Atom*);
extern void finalIntegrateCUDA(bool, Parameter*, Atom*);
#endif
