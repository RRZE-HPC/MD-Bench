/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stddef.h>
//---
#include <atom.h>
#include <neighbor.h>

#ifndef __DEVICE_H_
#define __DEVICE_H_

#ifdef CUDA_TARGET
#include <cuda_runtime.h>
extern void cuda_assert(const char *msg, cudaError_t err);
#endif

extern void initDevice(Atom*, Neighbor*);
extern void *allocateGPU(size_t bytesize);
extern void *reallocateGPU(void *ptr, size_t new_bytesize);
extern void memcpyToGPU(void *d_ptr, void *h_ptr, size_t bytesize);
extern void memcpyFromGPU(void *h_ptr, void *d_ptr, size_t bytesize);
extern void memsetGPU(void *d_ptr, int value, size_t bytesize);
#endif
