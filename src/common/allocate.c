/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <util.h>

void* allocate(int alignment, size_t bytesize) 
{
    void* ptr;
    int errorCode;

    errorCode = posix_memalign(&ptr, alignment, bytesize);
    if (errorCode == EINVAL) {
        fprintf(stderr, "Error: Alignment parameter is not a power of two\n");
        exit(EXIT_FAILURE);
    }

    if (errorCode == ENOMEM) {
        fprintf(stderr, "Error: Insufficient memory to fulfill the request\n");
        exit(EXIT_FAILURE);
    }

    if (ptr == NULL) {
        fprintf(stderr, "Error: posix_memalign failed!\n");
        exit(EXIT_FAILURE);
    }

    return ptr;
}

void* reallocate(void* ptr, int alignment, size_t new_bytesize, size_t old_bytesize) 
{
    void* newarray = allocate(alignment, new_bytesize);
    if (ptr != NULL) {
        memcpy(newarray, ptr, old_bytesize);
        free(ptr);
    }

    return newarray;
}
