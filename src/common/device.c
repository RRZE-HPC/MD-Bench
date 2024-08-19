/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <stdio.h>
#include <stdlib.h>
//---
#include <device.h>

#ifdef CUDA_TARGET
#include <cuda_runtime.h>

void cuda_assert(const char* label, cudaError_t err) 
{
    if (err != cudaSuccess) {
        printf("[CUDA Error]: %s: %s\r\n", label, cudaGetErrorString(err));
        exit(-1);
    }
}

void* allocateGPU(size_t bytesize) 
{
    void* ptr;
    #ifdef CUDA_HOST_MEMORY
    cuda_assert("allocateGPU", cudaMallocHost((void**)&ptr, bytesize));
    #else
    cuda_assert("allocateGPU", cudaMalloc((void**)&ptr, bytesize));
    #endif
    return ptr;
}

// Data is not preserved
void* reallocateGPU(void* ptr, size_t new_bytesize) 
{
    if (ptr != NULL) {
        #ifdef CUDA_HOST_MEMORY
        cudaFreeHost(ptr);
        #else
        cudaFree(ptr);
        #endif
    }

    return allocateGPU(new_bytesize);
}

void memcpyToGPU(void* d_ptr, void* h_ptr, size_t bytesize) 
{
    #ifndef CUDA_HOST_MEMORY
    cuda_assert("memcpyToGPU", 
        cudaMemcpy(d_ptr, h_ptr, bytesize, cudaMemcpyHostToDevice));
    #endif
}

void memcpyFromGPU(void* h_ptr, void* d_ptr, size_t bytesize) 
{
    #ifndef CUDA_HOST_MEMORY
    cuda_assert("memcpyFromGPU", 
        cudaMemcpy(h_ptr, d_ptr, bytesize, cudaMemcpyDeviceToHost));
    #endif
}

void memsetGPU(void* d_ptr, int value, size_t bytesize) 
{
    cuda_assert("memsetGPU", cudaMemset(d_ptr, value, bytesize));
}

#else
void initDevice(Atom* atom, Neighbor* neighbor) {}
void* allocateGPU(size_t bytesize) { return NULL; }
void* reallocateGPU(void* ptr, size_t new_bytesize) { return NULL; }
void memcpyToGPU(void* d_ptr, void* h_ptr, size_t bytesize) {}
void memcpyFromGPU(void* h_ptr, void* d_ptr, size_t bytesize) {}
void memsetGPU(void* d_ptr, int value, size_t bytesize) {}
#endif
