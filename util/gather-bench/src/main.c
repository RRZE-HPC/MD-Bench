/*
 * =======================================================================================
 *
 *      Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *      Copyright (c) 2021 RRZE, University Erlangen-Nuremberg
 *
 *      Permission is hereby granted, free of charge, to any person obtaining a copy
 *      of this software and associated documentation files (the "Software"), to deal
 *      in the Software without restriction, including without limitation the rights
 *      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *      copies of the Software, and to permit persons to whom the Software is
 *      furnished to do so, subject to the following conditions:
 *
 *      The above copyright notice and this permission notice shall be included in all
 *      copies or substantial portions of the Software.
 *
 *      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *      SOFTWARE.
 *
 * =======================================================================================
 */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <limits.h>
#include <float.h>
//---
#include <likwid-marker.h>
//---
#include <timing.h>
#include <allocate.h>

#if !defined(ISA_avx2) && !defined (ISA_avx512)
#error "Invalid ISA macro, possible values are: avx2 and avx512"
#endif

#define HLINE "----------------------------------------------------------------------------\n"

#ifndef MIN
#define MIN(x,y) ((x)<(y)?(x):(y))
#endif
#ifndef MAX
#define MAX(x,y) ((x)>(y)?(x):(y))
#endif
#ifndef ABS
#define ABS(a) ((a) >= 0 ? (a) : -(a))
#endif

#define ARRAY_ALIGNMENT  64
#define SIZE  20000

#ifdef ISA_avx512
#define _VL_  8
#define ISA_STRING "avx512"
#else
#define _VL_  4
#define ISA_STRING "avx2"
#endif

#ifdef TEST
extern void gather(double*, int*, int, double*);
#else
extern void gather(double*, int*, int);
#endif

int main (int argc, char** argv) {
    LIKWID_MARKER_INIT;
    LIKWID_MARKER_REGISTER("gather");

    if (argc < 3) {
        printf("Please provide stride and frequency\n");
        printf("%s <stride> <freq (GHz)> [cache line size (B)]\n", argv[0]);
        return -1;
    }

    int stride = atoi(argv[1]);
    double freq = atof(argv[2]);
    int cl_size = (argc == 3) ? 64 : atoi(argv[3]);
    size_t bytesPerWord = sizeof(double);
    size_t cacheLinesPerGather = MIN(MAX(stride * _VL_ / (cl_size / sizeof(double)), 1), _VL_);
    size_t N = SIZE;
    double E, S;

    printf("ISA,Stride (elems),Frequency (GHz),Cache Line Size (B),Vector Width (elems),Cache Lines/Gather\n");
    printf("%s,%d,%f,%d,%d,%lu\n\n", ISA_STRING, stride, freq, cl_size, _VL_, cacheLinesPerGather);
    printf("%14s,%14s,%14s,%14s,%14s,%14s\n", "N", "Size(kB)", "tot. time", "time/LUP(ms)", "cy/gather", "cy/elem");

    freq = freq * 1e9;
    for(int N = 1024; N < 400000; N = 1.5 * N) {
        int N_alloc = N * 2;
        double* a = (double*) allocate( ARRAY_ALIGNMENT, N_alloc * sizeof(double) );
        int* idx = (int*) allocate( ARRAY_ALIGNMENT, N_alloc * sizeof(int) );
        int rep;
        double time;

#ifdef TEST
        double* t = (double*) allocate( ARRAY_ALIGNMENT, N_alloc * sizeof(double) );
#endif

        for(int i = 0; i < N_alloc; ++i) {
            a[i] = i;
            idx[i] = (i * stride) % N;
        }

        S = getTimeStamp();
        for(int r = 0; r < 100; ++r) {
#ifdef TEST
            gather(a, idx, N, t);
#else
            gather(a, idx, N);
#endif
        }
        E = getTimeStamp();

        rep = 100 * (0.5 / (E - S));
        S = getTimeStamp();
        LIKWID_MARKER_START("gather");
        for(int r = 0; r < rep; ++r) {
#ifdef TEST
            gather(a, idx, N, t);
#else
            gather(a, idx, N);
#endif
        }
        LIKWID_MARKER_STOP("gather");
        E = getTimeStamp();

        time = E - S;

#ifdef TEST
        int test_failed = 0;
        for(int i = 0; i < N; ++i) {
            if(t[i] != i * stride % N) {
                test_failed = 1;
                break;
            }
        }

        if(test_failed) {
            printf("Test failed!\n");
            return EXIT_FAILURE;
        } else {
            printf("Test passed!\n");
        }
#endif

        const double size = N * (sizeof(double) + sizeof(int)) / 1000.0;
        const double time_per_it = time * 1e6 / ((double) N * rep);
        const double cy_per_gather = time * freq * _VL_ / ((double) N * rep);
        const double cy_per_elem = time * freq / ((double) N * rep);
        printf("%14d,%14.2f,%14.10f,%14.10f,%14.6f,%14.6f\n", N, size, time, time_per_it, cy_per_gather, cy_per_elem);
        free(a);
        free(idx);
#ifdef TEST
        free(t);
#endif
    }

    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
