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

#define MD_SIMD_FLOAT       __m512
#define MD_SIMD_MASK        __mmask16

static inline MD_SIMD_FLOAT simd_broadcast(float scalar) { return _mm512_set1_ps(scalar); }
static inline MD_SIMD_FLOAT simd_zero() { return _mm512_set1_ps(0.0f); }
static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm512_add_ps(a, b); }
static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm512_sub_ps(a, b); }
static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm512_mul_ps(a, b); }
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c) { return _mm512_fmadd_ps(a, b, c); }
static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a) { return _mm512_rcp14_ps(a); }
static inline MD_SIMD_FLOAT simd_masked_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m) { return _mm512_mask_add_ps(a, m, a, b); }
static inline MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b) { return _kand_mask16(a, b); }
static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm512_cmp_ps_mask(a, b, _CMP_LT_OQ); }
static inline MD_SIMD_MASK simd_mask_from_u32(unsigned int a) { return _cvtu32_mask16(a); }
static inline unsigned int simd_mask_to_u32(MD_SIMD_MASK a) { return _cvtmask16_u32(a); }
static inline MD_SIMD_FLOAT simd_load(MD_FLOAT *p) { return _mm512_load_ps(p); }
static inline MD_FLOAT simd_h_reduce_sum(MD_SIMD_FLOAT a) {
    // This would only be called in a Mx16 configuration, which is not valid in GROMACS
    fprintf(stderr, "simd_h_reduce_sum(): Called with AVX512 intrinsics and single-precision which is not valid!\n");
    exit(-1);
    return 0.0;
}

static inline MD_FLOAT simd_incr_reduced_sum(MD_FLOAT *m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1, MD_SIMD_FLOAT v2, MD_SIMD_FLOAT v3) {
    // This would only be called in a Mx16 configuration, which is not valid in GROMACS
    fprintf(stderr, "simd_h_reduce_sum(): Called with AVX512 intrinsics and single-precision which is not valid!\n");
    exit(-1);
    return 0.0;
}

static inline MD_SIMD_FLOAT simd_load_h_duplicate(const float* m) {
    return _mm512_castpd_ps(_mm512_broadcast_f64x4(_mm256_load_pd((const double *)(m))));
}

static inline MD_SIMD_FLOAT simd_load_h_dual(const float* m) {
    return _mm512_shuffle_f32x4(_mm512_broadcastss_ps(_mm_load_ss(m)), _mm512_broadcastss_ps(_mm_load_ss(m + 1)), 0x44);
}

static inline MD_FLOAT simd_h_dual_incr_reduced_sum(float* m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1) {
    __m512 t0, t1;
    __m128 t2, t3;

    t0 = _mm512_shuffle_f32x4(v0, v1, 0x88);
    t1 = _mm512_shuffle_f32x4(v0, v1, 0xdd);
    t0 = _mm512_add_ps(t0, t1);
    t0 = _mm512_add_ps(t0, _mm512_permute_ps(t0, 0x4e));
    t0 = _mm512_add_ps(t0, _mm512_permute_ps(t0, 0xb1));
    t0 = _mm512_maskz_compress_ps(simd_mask_from_u32(0x1111ul), t0);
    t3 = _mm512_castps512_ps128(t0);
    t2 = _mm_load_ps(m);
    t2 = _mm_add_ps(t2, t3);
    _mm_store_ps(m, t2);

    t3 = _mm_add_ps(t3, _mm_permute_ps(t3, 0x4e));
    t3 = _mm_add_ps(t3, _mm_permute_ps(t3, 0xb1));
    return _mm_cvtss_f32(t3);
}
