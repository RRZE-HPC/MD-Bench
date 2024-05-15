/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <parameter.h>
#include <atom.h>

#ifndef __THERMO_H_
#define __THERMO_H_
extern void setupThermo(Parameter*, int);
extern void computeThermo(int, Parameter*, Atom*);
extern void adjustThermo(Parameter*, Atom*);
#endif
