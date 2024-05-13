/*
 * =======================================================================================
 *
 *      Author:   Jan Eitzinger (je), jan.eitzinger@fau.de
 *      Copyright (c)  RRZE, University Erlangen-Nuremberg
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
#include <float.h>
#include <getopt.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
//---
#include <likwid-marker.h>
//---
#include <allocate.h>
#include <timing.h>

#if !defined(ISA_avx2) && !defined (ISA_avx512)
#error "Invalid ISA macro, possible values are: avx2 and avx512"
#endif

#if defined(TEST) && defined(ONLY_FIRST_DIMENSION)
#error "TEST and ONLY_FIRST_DIMENSION options are mutually exclusive!"
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

#ifdef AOS
#define GATHER gather_aos
#define LAYOUT_STRING "AoS"
#else
#define GATHER gather_soa
#define LAYOUT_STRING "SoA"
#endif

#if defined(PADDING) && defined(AOS)
#define PADDING_BYTES 1
#else
#define PADDING_BYTES 0
#endif

#ifdef MEM_TRACER
#   define MEM_TRACER_INIT(stride, size)  FILE *mem_tracer_fp = fopen(get_mem_tracer_filename(stride, size), "w");
#   define MEM_TRACER_END                 fclose(mem_tracer_fp);
#   define MEM_TRACE(addr, op)            fprintf(mem_tracer_fp, "%c: %p\n", op, (void *)(&(addr)));
#else
#   define MEM_TRACER_INIT
#   define MEM_TRACER_END
#   define MEM_TRACE(addr, op)
#endif

extern void gather_aos(double*, int*, int, double*, long int*);
extern void gather_soa(double*, int*, int, double*, long int*);

const char *get_mem_tracer_filename(int stride, int size) {
    static char fname[64];
    snprintf(fname, sizeof fname, "mem_tracer_%d_%d.txt", stride, size);
    return fname;
}

int log2_uint(unsigned int x) {
    int ans = 0;
    while(x >>= 1) { ans++; }
    return ans;
}

int main (int argc, char** argv) {
    LIKWID_MARKER_INIT;
    LIKWID_MARKER_REGISTER("gather");
    int stride = 1;
    int cl_size = 64;
    int opt = 0;
    double freq = 2.5;
    struct option long_opts[] = {
        {"stride", required_argument,   NULL,   's'},
        {"freq",   required_argument,   NULL,   'f'},
        {"line",   required_argument,   NULL,   'l'},
        {"help",   required_argument,   NULL,   'h'}
    };

    while((opt = getopt_long(argc, argv, "s:f:l:h", long_opts, NULL)) != -1) {
        switch(opt) {
            case 's':
                stride = atoi(optarg);
                break;

            case 'f':
                freq = atof(optarg);
                break;

            case 'l':
                cl_size = atoi(optarg);
                break;

            case 'h':
            case '?':
            default:
                printf("Usage: %s [OPTION]...\n", argv[0]);
                printf("MD variant for gather benchmark.\n\n");
                printf("Mandatory arguments to long options are also mandatory for short options.\n");
                printf("\t-s, --stride=NUMBER   stride between two successive elements (default 1).\n");
                printf("\t-f, --freq=REAL       CPU frequency in GHz (default 2.5).\n");
                printf("\t-l, --line=NUMBER     cache line size in bytes (default 64).\n");
                printf("\t-h, --help            display this help message.\n");
                printf("\n\n");
                return EXIT_FAILURE;
        }
    }

    size_t bytesPerWord = sizeof(double);
    const int dims = 3;
    const int snbytes = dims + PADDING_BYTES; // bytes per element (struct), includes padding
    #ifdef AOS
    size_t cacheLinesPerGather = MIN(MAX(stride * _VL_ * snbytes / (cl_size / sizeof(double)), 1), _VL_);
    #else
    size_t cacheLinesPerGather = MIN(MAX(stride * _VL_ / (cl_size / sizeof(double)), 1), _VL_) * dims;
    #endif
    size_t N = SIZE;
    double E, S;

    printf("ISA,Layout,Stride,Dims,Frequency (GHz),Cache Line Size (B),Vector Width (e),Cache Lines/Gather\n");
    printf("%s,%s,%d,%d,%f,%d,%d,%lu\n\n", ISA_STRING, LAYOUT_STRING, stride, dims, freq, cl_size, _VL_, cacheLinesPerGather);
    printf("%14s,%14s,%14s,", "N", "Size(kB)", "cut CLs");

#ifndef MEASURE_GATHER_CYCLES
    printf("%14s,%14s,%14s,%14s,%14s", "tot. time", "time/LUP(ms)", "cy/it", "cy/gather", "cy/elem");
#else

#ifdef ONLY_FIRST_DIMENSION
    printf("%27s,%27s,%27s", "min/max/avg cy(x)", "min/max/avg cy(y)", "min/max/avg cy(z)");
#else
    printf("%27s", "min/max/avg cy(x)");
#endif

#endif

    printf("\n");
    freq = freq * 1e9;

    for(int N = 512; N < 80000000; N = 1.5 * N) {
        // Currently this only works when the array size (in elements) is multiple of the vector length (no preamble and prelude)
        if(N % _VL_ != 0) {
            N += _VL_ - (N % _VL_);
        }

        MEM_TRACER_INIT(stride, N);

        int N_gathers_per_dim = N / _VL_;
        int N_alloc = N * 2;
        int N_cycles_alloc = N_gathers_per_dim * 2;
        int cut_cl = 0;
        double* a = (double*) allocate( ARRAY_ALIGNMENT, N_alloc * snbytes * sizeof(double) );
        int* idx = (int*) allocate( ARRAY_ALIGNMENT, N_alloc * sizeof(int) );
        int rep;
        double time;

#ifdef TEST
        double* t = (double*) allocate( ARRAY_ALIGNMENT, N_alloc * dims * sizeof(double) );
#else
        double* t = (double*) NULL;
#endif

#ifdef MEASURE_GATHER_CYCLES
        long int* cycles = (long int*) allocate( ARRAY_ALIGNMENT, N_cycles_alloc * dims * sizeof(long int)) ;
#else
        long int* cycles = (long int*) NULL;
#endif

        for(int i = 0; i < N_alloc; ++i) {
#ifdef AOS
            a[i * snbytes + 0] = i * dims + 0;
            a[i * snbytes + 1] = i * dims + 1;
            a[i * snbytes + 2] = i * dims + 2;
#else
            a[N * 0 + i] = N * 0 + i;
            a[N * 1 + i] = N * 1 + i;
            a[N * 2 + i] = N * 2 + i;
#endif
            idx[i] = (i * stride) % N;
        }

#ifdef ONLY_FIRST_DIMENSION
        const int gathered_dims = 1;
#else
        const int gathered_dims = dims;
#endif

#ifdef MEM_TRACER
        for(int i = 0; i < N; i += _VL_) {
            for(int j = 0; j < _VL_; j++) {
                MEM_TRACE(idx[i + j], 'R');
            }

            for(int d = 0; d < gathered_dims; d++) {
                for(int j = 0; j < _VL_; j++) {
#ifdef AOS
                    MEM_TRACE(a[idx[i + j] * snbytes + d], 'R');
#else
                    MEM_TRACE(a[N * d + idx[i + j]], 'R');
#endif
                }
            }
        }
#endif

#ifdef AOS
        const int cl_shift = log2_uint((unsigned int) cl_size);
        for(int i = 0; i < N; i++) {
            const int first_cl = (idx[i] * snbytes * sizeof(double)) >> cl_shift;
            const int last_cl = ((idx[i] * snbytes + gathered_dims - 1) * sizeof(double)) >> cl_shift;
            if(first_cl != last_cl) {
                cut_cl++;
            }
        }
#endif

        S = getTimeStamp();
        for(int r = 0; r < 100; ++r) {
            GATHER(a, idx, N, t, cycles);
        }
        E = getTimeStamp();

#ifdef MEASURE_GATHER_CYCLES
        for(int i = 0; i < N_cycles_alloc; i++) {
            cycles[i * 3 + 0] = 0;
            cycles[i * 3 + 1] = 0;
            cycles[i * 3 + 2] = 0;
        }
#endif

        rep = 100 * (0.5 / (E - S));
        S = getTimeStamp();
        LIKWID_MARKER_START("gather");
        for(int r = 0; r < rep; ++r) {
            GATHER(a, idx, N, t, cycles);
        }
        LIKWID_MARKER_STOP("gather");
        E = getTimeStamp();

        time = E - S;

#ifdef TEST
        int test_failed = 0;
        for(int i = 0; i < N; ++i) {
            for(int d = 0; d < dims; ++d) {
#ifdef AOS
                if(t[d * N + i] != ((i * stride) % N) * dims + d) {
#else
                if(t[d * N + i] != d * N + ((i * stride) % N)) {
#endif
                    test_failed = 1;
                    break;
                }
            }
        }

        if(test_failed) {
            printf("Test failed!\n");
            return EXIT_FAILURE;
        } else {
            printf("Test passed!\n");
        }
#endif

        const double size = N * (dims * sizeof(double) + sizeof(int)) / 1000.0;
        printf("%14d,%14.2f,%14d,", N, size, cut_cl);

#ifndef MEASURE_GATHER_CYCLES
        const double time_per_it = time * 1e6 / ((double) N * rep);
        const double cy_per_it = time * freq * _VL_ / ((double) N * rep);
        const double cy_per_gather = time * freq * _VL_ / ((double) N * rep * gathered_dims);
        const double cy_per_elem = time * freq / ((double) N * rep * gathered_dims);
        printf("%14.10f,%14.10f,%14.6f,%14.6f,%14.6f", time, time_per_it, cy_per_it, cy_per_gather, cy_per_elem);
#else
        double cy_min[dims];
        double cy_max[dims];
        double cy_avg[dims];

        for(int d = 0; d < dims; d++) {
            cy_min[d] = 100000.0;
            cy_max[d] = 0.0;
            cy_avg[d] = 0.0;
        }

        for(int i = 0; i < N_gathers_per_dim; ++i) {
            for(int d = 0; d < gathered_dims; d++) {
                const double cy_d = (double)(cycles[i * 3 + d]);
                cy_min[d] = MIN(cy_min[d], cy_d);
                cy_max[d] = MAX(cy_max[d], cy_d);
                cy_avg[d] += cy_d;
            }
        }

        for(int d = 0; d < gathered_dims; d++) {
            char tmp_str[64];
            cy_avg[d] /= (double) N_gathers_per_dim;
            snprintf(tmp_str, sizeof tmp_str, "%4.4f/%4.4f/%4.4f", cy_min[d], cy_max[d], cy_avg[d]);
            printf("%27s%c", tmp_str, (d < gathered_dims - 1) ? ',' : ' ');
        }
#endif

        printf("\n");
        free(a);
        free(idx);

#ifdef TEST
        free(t);
#endif

#ifdef MEASURE_GATHER_CYCLES
        free(cycles);
#endif

        MEM_TRACER_END;
    }

    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
