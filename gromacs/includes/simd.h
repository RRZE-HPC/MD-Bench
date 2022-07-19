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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <immintrin.h>
#ifndef NO_ZMM_INTRIN
#   include <zmmintrin.h>
#endif

#ifndef CLUSTER_M
#   define CLUSTER_M 1
#endif

#ifndef CLUSTER_N
#   define CLUSTER_N 1
#endif

#ifdef AVX512
#   if PRECISION == 2
#       include "simd/avx512_double.h"
#   else
#       include "simd/avx512_float.h"
#   endif
#else
#   if PRECISION == 2
#       include "simd/avx_avx2_double.h"
#   else
#       include "simd/avx_avx2_float.h"
#   endif
#endif

#define SIMD_PRINT_REAL(a)  simd_print_real(#a, a);
#define SIMD_PRINT_MASK(a)  simd_print_mask(#a, a);

static inline void simd_print_real(const char *ref, MD_SIMD_FLOAT a) {
    double x[VECTOR_WIDTH];
    memcpy(x, &a, sizeof(x));

    fprintf(stdout, "%s: ", ref);
    for(int i = 0; i < VECTOR_WIDTH; i++) {
        fprintf(stdout, "%f ", x[i]);
    }

    fprintf(stdout, "\n");
}

static inline void simd_print_mask(const char *ref, MD_SIMD_MASK a) { fprintf(stdout, "%s: %x\n", ref, simd_mask_to_u32(a)); }
