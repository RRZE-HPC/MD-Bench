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
#include <string.h>
#include <immintrin.h>
#include <zmmintrin.h>

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
static inline MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b) { return _kand_mask8(a, b); }
static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm512_cmp_pd_mask(a, b, _CMP_LT_OQ); }
static inline MD_SIMD_MASK simd_mask_from_u32(unsigned int a) { return _cvtu32_mask8(a); }
static inline unsigned int simd_mask_to_u32(MD_SIMD_MASK a) { return _cvtmask8_u32(a); }
static inline MD_SIMD_FLOAT simd_load(MD_FLOAT *p) { return _mm512_load_pd(p); }

static inline MD_FLOAT simd_h_reduce_sum(MD_SIMD_FLOAT a) {
    MD_SIMD_FLOAT x = _mm512_add_pd(a, _mm512_shuffle_f64x2(a, a, 0xee));
    x = _mm512_add_pd(x, _mm512_shuffle_f64x2(x, x, 0x11));
    x = _mm512_add_pd(x, _mm512_permute_pd(x, 0x01));
    return *((MD_FLOAT *) &x);
}

static inline MD_SIMD_FLOAT simd_load_h_duplicate(const double* m) {
    return _mm512_broadcast_f64x4(_mm256_load_pd(m));
}

static inline MD_SIMD_FLOAT simd_load_h_dual(const double* m) {
    return _mm512_insertf64x4(_mm512_broadcastsd_pd(_mm_load_sd(m)), _mm256_broadcastsd_pd(_mm_load_sd(m + 1)), 1);
}

static inline double simd_h_dual_reduce_sum(double* m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1) {
    __m512d t0;
    __m256d t2, t3;

    t0 = _mm512_add_pd(v0, _mm512_permutex_pd(v0, 0x4e));
    t0 = _mm512_mask_add_pd(t0, simd_mask_from_u32(0xccul), v1, _mm512_permutex_pd(v1, 0x4e));
    t0 = _mm512_add_pd(t0, _mm512_permutex_pd(t0, 0xb1));
    t0 = _mm512_mask_shuffle_f64x2(t0, simd_mask_from_u32(0xaaul), t0, t0, 0xee);
    t2 = _mm512_castpd512_pd256(t0);
    t3 = _mm256_load_pd(m);
    t3 = _mm256_add_pd(t3, t2);
    _mm256_store_pd(m, t3);

    t0 = _mm512_add_pd(t0, _mm512_permutex_pd(t0, 0x4e));
    t0 = _mm512_add_pd(t0, _mm512_permutex_pd(t0, 0xb1));
    return _mm_cvtsd_f64(_mm512_castpd512_pd128(t0));
}
