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
#include <string.h>
#include <unistd.h>
#include <x86intrin.h>
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

#ifdef ISA_avx512
#define _VL_  8
#define ISA_STRING "avx512"
#else
#define _VL_  4
#define ISA_STRING "avx2"
#endif

#ifdef AOS
#define GATHER gather_md_aos
#define LOAD(a, i, d, n) load_aos(&a[i * d])
#define LAYOUT_STRING "AoS"
#else
#define GATHER gather_md_soa
#define LOAD(a, i, d, n) load_soa(a, i, n)
#define LAYOUT_STRING "SoA"
#endif

#if defined(PADDING) && defined(AOS)
#define PADDING_BYTES 1
#else
#define PADDING_BYTES 0
#endif

#ifdef MEM_TRACER
#   define MEM_TRACER_INIT(trace_file)    FILE *mem_tracer_fp = fopen(get_mem_tracer_filename(trace_file), "w");
#   define MEM_TRACER_END                 fclose(mem_tracer_fp);
#   define MEM_TRACE(addr, op)            fprintf(mem_tracer_fp, "%c: %p\n", op, (void *)(&(addr)));
#else
#   define MEM_TRACER_INIT
#   define MEM_TRACER_END
#   define MEM_TRACE(addr, op)
#endif

int gather_md_aos(double*, int*, int, double*, int);
int gather_md_soa(double*, int*, int, double*, int);
void load_aos(double*);
void load_soa(double*, int, int);

const char *get_mem_tracer_filename(const char *trace_file) {
    static char fname[64];
    snprintf(fname, sizeof fname, "mem_tracer_%s.txt", trace_file);
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
    char *trace_file = NULL;
    int cl_size = 64;
    int ntimesteps = 200;
    int reneigh_every = 20;
    int opt = 0;
    double freq = 2.5;
    struct option long_opts[] = {
        {"trace" ,      required_argument,   NULL,   't'},
        {"freq",        required_argument,   NULL,   'f'},
        {"line",        required_argument,   NULL,   'l'},
        {"timesteps",   required_argument,   NULL,   'n'},
        {"reneigh",     required_argument,   NULL,   'r'},
        {"help",        required_argument,   NULL,   'h'}
    };

    while((opt = getopt_long(argc, argv, "t:f:l:n:r:h", long_opts, NULL)) != -1) {
        switch(opt) {
            case 't':
                trace_file = strdup(optarg);
                break;

            case 'f':
                freq = atof(optarg);
                break;

            case 'l':
                cl_size = atoi(optarg);
                break;

            case 'n':
                ntimesteps = atoi(optarg);
                break;

            case 'r':
                reneigh_every = atoi(optarg);
                break;

            case 'h':
            case '?':
            default:
                printf("Usage: %s [OPTION]...\n", argv[0]);
                printf("MD variant for gather benchmark.\n\n");
                printf("Mandatory arguments to long options are also mandatory for short options.\n");
                printf("\t-t, --trace=STRING        input file with traced indexes from MD-Bench.\n");
                printf("\t-f, --freq=REAL           CPU frequency in GHz (default 2.5).\n");
                printf("\t-l, --line=NUMBER         cache line size in bytes (default 64).\n");
                printf("\t-n, --timesteps=NUMBER    number of timesteps to simulate (default 200).\n");
                printf("\t-r, --reneigh=NUMBER      reneighboring frequency in timesteps (default 20).\n");
                printf("\t-h, --help                display this help message.\n");
                printf("\n\n");
                return EXIT_FAILURE;
        }
    }

    if(trace_file == NULL) {
        fprintf(stderr, "Trace file not specified!\n");
        return EXIT_FAILURE;
    }

    FILE *fp;
    char *line = NULL;
    int *neighborlists = NULL;
    int *numneighs = NULL;
    int atom = -1;
    int nlocal, nghost, maxneighs;
    int nall = 0;
    int N_alloc = 0;
    size_t ntest = 0;
    size_t llen;
    ssize_t read;
    double *a = NULL;
    double *f = NULL;
    double *t = NULL;
    double time = 0.0;
    double E, S;
    const int dims = 3;
    const int snbytes = dims + PADDING_BYTES; // bytes per element (struct), includes padding
    long long int niters = 0;
    long long int ngathered = 0;

    printf("ISA,Layout,Dims,Frequency (GHz),Cache Line Size (B),Vector Width (e)\n");
    printf("%s,%s,%d,%f,%d,%d\n\n", ISA_STRING, LAYOUT_STRING, dims, freq, cl_size, _VL_);
    freq = freq * 1e9;

    #ifdef ONLY_FIRST_DIMENSION
    const int gathered_dims = 1;
    #else
    const int gathered_dims = dims;
    #endif

    for(int ts = -1; ts < ntimesteps; ts++) {
        if(!((ts + 1) % reneigh_every)) {
            char ts_trace_file[128];
            snprintf(ts_trace_file, sizeof ts_trace_file, "%s_%d.out", trace_file, ts + 1);
            if((fp = fopen(ts_trace_file, "r")) == NULL) {
                fprintf(stderr, "Error: could not open trace file!\n");
                return EXIT_FAILURE;
            }

            while((read = getline(&line, &llen, fp)) != -1) {
                int i = 2;
                if(strncmp(line, "N:", 2) == 0) {
                    while(line[i] == ' ') { i++; }
                    nlocal = atoi(strtok(&line[i], " "));
                    nghost = atoi(strtok(NULL, " "));
                    nall = nlocal + nghost;
                    maxneighs = atoi(strtok(NULL, " "));

                    if(nlocal <= 0 || maxneighs <= 0) {
                        fprintf(stderr, "Number of local atoms and neighbor lists capacity cannot be less or equal than zero!\n");
                        return EXIT_FAILURE;
                    }

                    if(neighborlists == NULL) {
                        neighborlists = (int *) allocate( ARRAY_ALIGNMENT, nlocal * maxneighs * sizeof(int) );
                        numneighs = (int *) allocate( ARRAY_ALIGNMENT, nlocal * sizeof(int) );
                    }
                }

                if(strncmp(line, "A:", 2) == 0) {
                    while(line[i] == ' ') { i++; }
                    atom = atoi(strtok(&line[i], " "));
                    numneighs[atom] = 0;
                }

                if(strncmp(line, "I:", 2) == 0) {
                    while(line[i] == ' ') { i++; }
                    char *neigh_idx = strtok(&line[i], " ");

                    while(neigh_idx != NULL && *neigh_idx != '\n') {
                        int j = numneighs[atom];
                        neighborlists[atom * maxneighs + j] = atoi(neigh_idx);
                        numneighs[atom]++;
                        ntest++;
                        neigh_idx = strtok(NULL, " ");
                    }
                }
            }

            fclose(fp);
        }

        if(N_alloc == 0) {
            N_alloc = nall * 2;
            a = (double*) allocate( ARRAY_ALIGNMENT, N_alloc * snbytes * sizeof(double) );
            f = (double*) allocate( ARRAY_ALIGNMENT, N_alloc * dims * sizeof(double) );
        }

        #ifdef TEST
        if(t != NULL) { free(t); }
        ntest += 100;
        t = (double*) allocate( ARRAY_ALIGNMENT, ntest * dims * sizeof(double) );
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
            f[i * dims + 0] = 0.0;
            f[i * dims + 1] = 0.0;
            f[i * dims + 2] = 0.0;
        }

        int t_idx = 0;
        S = getTimeStamp();
        LIKWID_MARKER_START("gather");
        for(int i = 0; i < nlocal; i++) {
            int *neighbors = &neighborlists[i * maxneighs];
            // We inline the assembly for AVX512 with AoS layout to evaluate the impact
            // of calling external assembly procedures in the overall runtime
            #ifdef ISA_avx512
            __m256i ymm_reg_mask = _mm256_setr_epi32(0, 1, 2, 3, 4, 5, 6, 7);
            __asm__ __volatile__(   "vmovsd 0(%0), %%xmm3;"
                                    "vmovsd 8(%0), %%xmm4;"
                                    "vmovsd 16(%0), %%xmm5;"
                                    "vbroadcastsd %%xmm3, %%zmm0;"
                                    "vbroadcastsd %%xmm4, %%zmm1;"
                                    "vbroadcastsd %%xmm5, %%zmm2;"
                                    :
                                    : "r" (&a[i * snbytes])
                                    : "%xmm3", "%xmm4", "%xmm5", "%zmm0", "%zmm1", "%zmm2"  );

            __asm__ __volatile__(   "xor %%rax, %%rax;"
                                    "movq %%rdx, %%r15;"
                                    "1: vmovdqu (%1,%%rax,4), %%ymm3;"
                                    "vpaddd %%ymm3, %%ymm3, %%ymm4;"
                                    #ifdef PADDING
                                    "vpaddd %%ymm4, %%ymm4, %%ymm3;"
                                    #else
                                    "vpaddd %%ymm3, %%ymm4, %%ymm3;"
                                    #endif
                                    "vpcmpeqb %%xmm5, %%xmm5, %%k1;"
                                    "vpcmpeqb %%xmm5, %%xmm5, %%k2;"
                                    "vpcmpeqb %%xmm5, %%xmm5, %%k3;"
                                    "vpxord %%zmm0, %%zmm0, %%zmm0;"
                                    "vpxord %%zmm1, %%zmm1, %%zmm1;"
                                    "vpxord %%zmm2, %%zmm2, %%zmm2;"
                                    "vgatherdpd (%3, %%ymm3, 8), %%zmm0{{%%k1}};"
                                    "vgatherdpd 8(%3, %%ymm3, 8), %%zmm1{{%%k2}};"
                                    "vgatherdpd 16(%3, %%ymm3, 8), %%zmm2{{%%k3}};"
                                    "addq $8, %%rax;"
                                    "subq $8, %%r15;"
                                    "cmpq $8, %%r15;"
                                    "jge 1b;"
                                    "cmpq $0, %%r15;"
                                    "jle 2;"
                                    "vpbroadcastd %%r15d, %%ymm5;"
                                    "vpcmpgtd %%ymm5, %2, %%k1;"
                                    "vmovdqu32 (%1,%%rax,4), %%ymm3{{%%k1}}{{z}};"
                                    "vpaddd %%ymm3, %%ymm3, %%ymm4;"
                                    #ifdef PADDING
                                    "vpaddd %%ymm4, %%ymm4, %%ymm3;"
                                    #else
                                    "vpaddd %%ymm3, %%ymm4, %%ymm3;"
                                    #endif
                                    "vpxord %%zmm0, %%zmm0, %%zmm0;"
                                    "kmovw %%k1, %%k2;"
                                    "kmovw %%k1, %%k3;"
                                    "vpxord %%zmm1, %%zmm1, %%zmm1;"
                                    "vpxord %%zmm2, %%zmm2, %%zmm2;"
                                    "vgatherdpd (%3, %%ymm3, 8), %%zmm0{{%%k1}};"
                                    "vgatherdpd 8(%3, %%ymm3, 8), %%zmm1{{%%k2}};"
                                    "vgatherdpd 16(%3, %%ymm3, 8), %%zmm2{{%%k3}};"
                                    "addq %%r15, %%rax;"
                                    "2:;"
                                    :
                                    : "d" (numneighs[i]), "r" (neighbors), "x" (ymm_reg_mask), "r" (a)
                                    : "%rax", "%r15", "%ymm3", "%ymm4", "%ymm5", "%k1", "%k2", "%k3", "%zmm0", "%zmm1", "%zmm2" );
            #else
            LOAD(a, i, snbytes, N_alloc);
            t_idx += GATHER(a, neighbors, numneighs[i], &t[t_idx], ntest);
            #endif
            f[i * dims + 0] += i;
            f[i * dims + 1] += i;
            f[i * dims + 2] += i;
        }
        LIKWID_MARKER_STOP("gather");
        E = getTimeStamp();
        time += E - S;

        #ifdef MEM_TRACER
        MEM_TRACER_INIT(trace_file);
        for(int i = 0; i < nlocal; i++) {
            int *neighbors = &neighborlists[i * maxneighs];

            for(int d = 0; d < gathered_dims; d++) {
                #ifdef AOS
                MEM_TRACE('R', a[i * snbytes + d])
                #else
                MEM_TRACE('R', a[d * N + i])
                #endif
            }

            for(int j = 0; j < numneighs[i]; j += _VL_) {
                for(int jj = j; jj < MIN(j + _VL_, numneighs[i]); j++) {
                    int k = neighbors[jj];
                    for(int d = 0; d < gathered_dims; d++) {
                        #ifdef AOS
                        MEM_TRACE('R', a[k * snbytes + d])
                        #else
                        MEM_TRACE('R', a[d * N + k])
                        #endif
                    }
                }
            }
        }
        MEM_TRACER_END;
        #endif

        #ifdef TEST
        int test_failed = 0;
        t_idx = 0;
        for(int i = 0; i < nlocal; ++i) {
            int *neighbors = &neighborlists[i * maxneighs];
            for(int j = 0; j < numneighs[i]; ++j) {
                int k = neighbors[j];
                for(int d = 0; d < dims; ++d) {
                    #ifdef AOS
                    if(t[d * ntest + t_idx] != k * dims + d) {
                    #else
                    if(t[d * ntest + t_idx] != d * N + k) {
                    #endif
                        test_failed = 1;
                        break;
                    }
                }

                t_idx++;
            }
        }

        if(test_failed) {
            printf("Test failed!\n");
            return EXIT_FAILURE;
        }
        #endif

        for(int i = 0; i < nlocal; i++) {
            niters += (numneighs[i] / _VL_) + ((numneighs[i] % _VL_ == 0) ? 0 : 1);
            ngathered += numneighs[i];
        }
    }

    printf("%14s,%14s,%14s,%14s,%14s,%14s", "tot. time(s)", "time/step(ms)", "time/iter(us)", "cy/it", "cy/gather", "cy/elem");
    printf("\n");
    const double time_per_step = time * 1e3 / ((double) ntimesteps);
    const double time_per_it = time * 1e6 / ((double) niters);
    const double cy_per_it = time * freq * _VL_ / ((double) niters);
    const double cy_per_gather = time * freq * _VL_ / ((double) niters * gathered_dims);
    const double cy_per_elem = time * freq / ((double) ngathered * gathered_dims);
    printf("%14.6f,%14.6f,%14.6f,%14.6f,%14.6f,%14.6f\n", time, time_per_step, time_per_it, cy_per_it, cy_per_gather, cy_per_elem);

    #ifdef TEST
    printf("Test passed!\n");
    #endif

    LIKWID_MARKER_CLOSE;
    return EXIT_SUCCESS;
}
