/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdlib.h>

#ifndef __ALLOCATE_H_
#define __ALLOCATE_H_
extern void* allocate (int alignment, size_t bytesize);
extern void* reallocate (void* ptr, int alignment, size_t newBytesize, size_t oldBytesize);
#endif
