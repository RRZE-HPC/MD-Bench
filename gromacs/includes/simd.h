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

#include <string.h>
#include <immintrin.h>
#include <zmmintrin.h>

#define SIMD_PRINT_REAL(a)  simd_print_real(#a, a);
#define SIMD_PRINT_MASK(a)  simd_print_mask(#a, a);

#if VECTOR_WIDTH == 8 // AVX512

#define MD_SIMD_FLOAT       __m512d
#define MD_SIMD_MASK        __mmask8

static inline MD_SIMD_FLOAT simd_broadcast(double scalar) { return _mm512_set1_pd(scalar); }
static inline MD_SIMD_FLOAT simd_zero() { return _mm512_set1_pd(0.0); }
static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm512_add_pd(a, b); }
static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm512_sub_pd(a, b); }
static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm512_mul_pd(a, b); }
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c) { return _mm512_fmadd_pd(a, b, c); }
static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a) { return _mm512_rcp14_pd(a); }
static inline MD_SIMD_FLOAT simd_masked_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m) { return _mm512_mask_add_pd(a, m, a, b); }
static inline MD_SIMD_MASK simd_mask_from_u32(unsigned int a) { return _cvtu32_mask8(a); }
static inline MD_SIMD_MASK simd_mask_to_u32(unsigned int a) { return _cvtmask8_u32(a); }
static inline MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b) { return _kand_mask8(a, b); }
static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm512_cmp_pd_mask(a, b, _CMP_LT_OQ); }

static MD_SIMD_FLOAT simd_load2(MD_FLOAT *c0, MD_FLOAT *c1, int d) {
    MD_SIMD_FLOAT x;
#ifdef CLUSTER_AOS
    __m256i aos_gather_vindex = _mm256_set_epi32(9, 6, 3, 0, 9, 6, 3, 0);
    __m256i vindex = _mm256_add_epi32(aos_gather_vindex, _mm256_set1_epi32(d));
    x = _mm512_mask_i32gather_pd(simd_zero(), simd_mask_from_u32(0x0f), vindex, c0, sizeof(double));
    x = _mm512_mask_i32gather_pd(x, simd_mask_from_u32(0xf0), vindex, c1, sizeof(double));
#else
    x = _mm512_load_pd(&c0[d * CLUSTER_DIM_M]);
    x = _mm512_insertf64x4(x, _mm256_load_pd(&c1[d * CLUSTER_DIM_M]), 1);
#endif
    return x;
}

static inline MD_FLOAT simd_horizontal_sum(MD_SIMD_FLOAT a) {
    MD_SIMD_FLOAT x = _mm512_add_pd(a, _mm512_shuffle_f64x2(a, a, 0xee));
    x = _mm512_add_pd(x, _mm512_shuffle_f64x2(x, x, 0x11));
    x = _mm512_add_pd(x, _mm512_permute_pd(x, 0x01));
    return *((double *) &x);
}

#else // AVX2

#define MD_SIMD_FLOAT       __m256d
#define MD_SIMD_MASK        __mmask8

static inline MD_SIMD_FLOAT simd_broadcast(double scalar) { return _mm256_set1_pd(scalar); }
static inline MD_SIMD_FLOAT simd_zero() { return _mm256_set1_pd(0.0); }
static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_add_pd(a, b); }
static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_sub_pd(a, b); }
static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_mul_pd(a, b); }
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c) { return _mm256_fmadd_pd(a, b, c); }
static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a) { return _mm256_rcp14_pd(a); }
static inline MD_SIMD_FLOAT simd_masked_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m) { return _mm256_mask_add_pd(a, m, a, b); }
static inline MD_SIMD_MASK simd_mask_from_u32(unsigned int a) { return _cvtu32_mask8(a); }
static inline MD_SIMD_MASK simd_mask_to_u32(unsigned int a) { return _cvtmask8_u32(a); }
static inline MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b) { return _kand_mask8(a, b); }
static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_cmp_pd_mask(a, b, _CMP_LT_OQ); }

static MD_SIMD_FLOAT simd_load(MD_FLOAT *c0, int d) {
    MD_SIMD_FLOAT x;
#ifdef CLUSTER_AOS
    __m128i aos_gather_vindex = _mm128_set_epi32(9, 6, 3, 0);
    __m128i vindex = _mm128_add_epi32(aos_gather_vindex, _mm128_set1_epi32(d));
    x = _mm256_i32gather_pd(c0, vindex, sizeof(double));
#else
    x = _mm256_load_pd(&c0[d * CLUSTER_DIM_M]);
#endif
    return x;
}

static inline MD_FLOAT simd_horizontal_sum(MD_SIMD_FLOAT a) {
    __m128d a0, a1;
    // test with shuffle & add as an alternative to hadd later
    a = _mm256_hadd_pd(a, a);
    a0 = _mm256_castpd256_pd128(a);
    a1 = _mm256_extractf128_pd(a, 0x1);
    a0 = _mm_add_sd(a0, a1);
    return *((double *) &a0);
}

#endif

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
