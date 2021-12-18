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

#include <cuda_runtime.h>

void checkCUDAError(const char *msg, cudaError_t err)
{
    if (err != cudaSuccess)
    {
        //print a human readable error message
        printf("[CUDA ERROR %s]: %s\r\n", msg, cudaGetErrorString(err));
        exit(-1);
    }
}


void* allocate (int alignment, size_t bytesize)
{
    int errorCode;
    void* ptr;

    checkCUDAError( "allocate", cudaMallocHost((void**)&ptr, bytesize) );

    return ptr;

    /*
    errorCode =  posix_memalign(&ptr, alignment, bytesize);

    if (errorCode) {
        if (errorCode == EINVAL) {
            fprintf(stderr,
                    "Error: Alignment parameter is not a power of two\n");
            exit(EXIT_FAILURE);
        }
        if (errorCode == ENOMEM) {
            fprintf(stderr,
                    "Error: Insufficient memory to fulfill the request\n");
            exit(EXIT_FAILURE);
        }
    }

    if (ptr == NULL) {
        fprintf(stderr, "Error: posix_memalign failed!\n");
        exit(EXIT_FAILURE);
    }

    return ptr;
    */
}

void* reallocate (
        void* ptr,
        int alignment,
        size_t newBytesize,
        size_t oldBytesize)
{
    void* newarray =  allocate(alignment, newBytesize);

    if(ptr != NULL) {
        memcpy(newarray, ptr, oldBytesize);
        cudaFreeHost(ptr);
    }

    return newarray;
}
