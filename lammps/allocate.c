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
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <util.h>

void *allocate(int alignment, size_t bytesize) {
    int errorCode;
    void* ptr;

    errorCode = posix_memalign(&ptr, alignment, bytesize);
    if(errorCode == EINVAL) {
        fprintf(stderr, "Error: Alignment parameter is not a power of two\n");
        exit(EXIT_FAILURE);
    }

    if(errorCode == ENOMEM) {
        fprintf(stderr, "Error: Insufficient memory to fulfill the request\n");
        exit(EXIT_FAILURE);
    }

    if(ptr == NULL) {
        fprintf(stderr, "Error: posix_memalign failed!\n");
        exit(EXIT_FAILURE);
    }

    return ptr;
}

void *reallocate(void* ptr, int alignment, size_t new_bytesize, size_t old_bytesize) {
    void *newarray = allocate(alignment, new_bytesize);
    if(ptr != NULL) {
        memcpy(newarray, ptr, old_bytesize);
        free(ptr);
    }

    return newarray;
}

#ifndef CUDA_TARGET
void *allocateGPU(size_t bytesize) { return NULL; }
void *reallocateGPU(void *ptr, size_t new_bytesize) { return NULL; }
void memcpyToGPU(void *d_ptr, void *h_ptr, size_t bytesize) {}
void memcpyFromGPU(void *h_ptr, void *d_ptr, size_t bytesize) {}
void memsetGPU(void *d_ptr, int value, size_t bytesize) {}
#else
#include <cuda_runtime.h>
#include <cuda_atom.h>
void *allocateGPU(size_t bytesize) {
    void *ptr;
    #ifdef CUDA_HOST_MEMORY
    cuda_assert("allocateGPU", cudaMallocHost((void **) &ptr, bytesize));
    #else
    cuda_assert("allocateGPU", cudaMalloc((void **) &ptr, bytesize));
    #endif
    return ptr;
}

// Data is not preserved
void *reallocateGPU(void *ptr, size_t new_bytesize) {
    if(ptr != NULL) {
        #ifdef CUDA_HOST_MEMORY
        cudaFreeHost(ptr);
        #else
        cudaFree(ptr);
        #endif
    }

    return allocateGPU(new_bytesize);
}

void memcpyToGPU(void *d_ptr, void *h_ptr, size_t bytesize) {
    #ifndef CUDA_HOST_MEMORY
    cuda_assert("memcpyToGPU", cudaMemcpy(d_ptr, h_ptr, bytesize, cudaMemcpyHostToDevice));
    #endif
}

void memcpyFromGPU(void *h_ptr, void *d_ptr, size_t bytesize) {
    #ifndef CUDA_HOST_MEMORY
    cuda_assert("memcpyFromGPU", cudaMemcpy(h_ptr, d_ptr, bytesize, cudaMemcpyDeviceToHost));
    #endif
}

void memsetGPU(void *d_ptr, int value, size_t bytesize) {
    cuda_assert("memsetGPU", cudaMemset(d_ptr, value, bytesize));
}
#endif
