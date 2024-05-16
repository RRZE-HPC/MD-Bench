/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <atom.h>

#ifndef __XTC_H_
#define __XTC_H_

#ifdef XTC_OUTPUT
void xtc_init(const char*, Atom*, int);
void xtc_write(Atom*, int, int, int);
void xtc_end();
#else
#define xtc_init(a, b, c)
#define xtc_write(a, b, c, d)
#define xtc_end()
#endif
#endif
