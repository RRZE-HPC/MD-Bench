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

#include <immintrin.h>
#include <zmmintrin.h>

#define MD_SIMD_FLOAT   __m256
#define MD_SIMD_MASK    __mmask8

static inline MD_SIMD_FLOAT simd_broadcast(MD_FLOAT scalar) { return _mm256_set1_ps(scalar); }
static inline MD_SIMD_FLOAT simd_zero() { return _mm256_set1_ps(0.0); }
static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_add_ps(a, b); }
static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_sub_ps(a, b); }
static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_mul_ps(a, b); }
static inline MD_SIMD_FLOAT simd_load(MD_FLOAT *p) { return _mm256_load_ps(p); }
static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a) { return _mm256_rcp14_ps(a); }
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c) { return _mm256_fmadd_ps(a, b, c); }
static inline MD_SIMD_FLOAT simd_masked_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m) { return _mm256_mask_add_ps(a, m, a, b); }
static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_cmp_ps_mask(a, b, _CMP_LT_OQ); }
static inline MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b) { return _kand_mask8(a, b); }
static inline MD_SIMD_MASK simd_mask_from_u32(unsigned int a) { return _cvtu32_mask8(a); }
static inline unsigned int simd_mask_to_u32(MD_SIMD_MASK a) { return _cvtmask8_u32(a); }
static inline MD_FLOAT simd_h_reduce_sum(MD_SIMD_FLOAT a) {
    __m128 t0;
    t0 = _mm_add_ps(_mm256_castps256_ps128(a), _mm256_extractf128_ps(a, 0x1));
    t0 = _mm_add_ps(t0, _mm_permute_ps(t0, _MM_SHUFFLE(1, 0, 3, 2)));
    t0 = _mm_add_ss(t0, _mm_permute_ps(t0, _MM_SHUFFLE(0, 3, 2, 1)));
    return *((MD_FLOAT *) &t0);
}

static inline MD_FLOAT simd_incr_reduced_sum(MD_FLOAT *m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1, MD_SIMD_FLOAT v2, MD_SIMD_FLOAT v3) {
    __m128 t0, t2;
    v0 = _mm256_hadd_ps(v0, v1);
    v2 = _mm256_hadd_ps(v2, v3);
    v0 = _mm256_hadd_ps(v0, v2);
    t0 = _mm_add_ps(_mm256_castps256_ps128(v0), _mm256_extractf128_ps(v0, 0x1));
    t2 = _mm_add_ps(t0, _mm_load_ps(m));
    _mm_store_ps(m, t2);

    t0 = _mm_add_ps(t0, _mm_permute_ps(t0, _MM_SHUFFLE(1, 0, 3, 2)));
    t0 = _mm_add_ss(t0, _mm_permute_ps(t0, _MM_SHUFFLE(0, 3, 2, 1)));
    return *((MD_FLOAT *) &t0);
}

static inline MD_SIMD_FLOAT simd_load_h_duplicate(const MD_FLOAT *m) {
    return _mm256_broadcast_ps((const __m128 *)(m));
}

static inline MD_SIMD_FLOAT simd_load_h_dual(const MD_FLOAT *m) {
    __m128 t0, t1;
    t0 = _mm_broadcast_ss(m);
    t1 = _mm_broadcast_ss(m + 1);
    return _mm256_insertf128_ps(_mm256_castps128_ps256(t0), t1, 0x1);
}

static inline MD_FLOAT simd_h_dual_incr_reduced_sum(MD_FLOAT *m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1) {
    __m128 t0, t1;
    v0 = _mm256_hadd_ps(v0, v1);
    t0 = _mm256_extractf128_ps(v0, 0x1);
    t0 = _mm_hadd_ps(_mm256_castps256_ps128(v0), t0);
    t0 = _mm_permute_ps(t0, _MM_SHUFFLE(3, 1, 2, 0));
    t1 = _mm_add_ps(t0, _mm_load_ps(m));
    _mm_store_ps(m, t1);

    t0 = _mm_add_ps(t0, _mm_permute_ps(t0, _MM_SHUFFLE(1, 0, 3, 2)));
    t0 = _mm_add_ss(t0, _mm_permute_ps(t0, _MM_SHUFFLE(0, 3, 2, 1)));
    return *((MD_FLOAT *) &t0);
}
