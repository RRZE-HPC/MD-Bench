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

#define MD_SIMD_FLOAT       __m256d

#ifdef NO_AVX2
#define MD_SIMD_MASK        __m256d
#else
#define MD_SIMD_MASK        __mmask8
#endif

static inline MD_SIMD_FLOAT simd_broadcast(double scalar) { return _mm256_set1_pd(scalar); }
static inline MD_SIMD_FLOAT simd_zero() { return _mm256_set1_pd(0.0); }
static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_add_pd(a, b); }
static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_sub_pd(a, b); }
static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_mul_pd(a, b); }
static inline MD_SIMD_FLOAT simd_load(MD_FLOAT *p) { return _mm256_load_pd(p); }

#ifdef NO_AVX2

static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a) { return _mm256_cvtps_pd(_mm_rcp_ps(_mm256_cvtpd_ps(a))); }
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c) { return simd_add(simd_mul(a, b), c); }
static inline MD_SIMD_FLOAT simd_masked_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m) { return simd_add(a, _mm256_and_pd(b, m)); }
static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_cmp_pd(a, b, _CMP_LT_OQ); }
static inline MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b) { return _mm256_and_pd(a, b); }
// TODO: Initialize all diagonal cases and just select the proper one (all bits set or diagonal) based on cond0
static inline MD_SIMD_MASK simd_mask_from_u32(unsigned int a) {
    const unsigned long long int all = 0xFFFFFFFFFFFFFFFF;
    const unsigned long long int none = 0x0;
    return _mm256_castsi256_pd(_mm256_set_epi64x((a & 0x8) ? all : none, (a & 0x4) ? all : none, (a & 0x2) ? all : none, (a & 0x1) ? all : none));
}
// TODO: Implement this, althrough it is just required for debugging
static inline int simd_mask_to_u32(MD_SIMD_MASK a) { return 0; }
static inline MD_FLOAT simd_h_reduce_sum(MD_SIMD_FLOAT a) {
    __m128d a0, a1;
    a = _mm256_add_pd(a, _mm256_permute_pd(a, 0b0101));
    a0 = _mm256_castpd256_pd128(a);
    a1 = _mm256_extractf128_pd(a, 0x1);
    a0 = _mm_add_sd(a0, a1);
    return *((MD_FLOAT *) &a0);
}

#else // AVX2

static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a) { return _mm256_rcp14_pd(a); }
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c) { return _mm256_fmadd_pd(a, b, c); }
static inline MD_SIMD_FLOAT simd_masked_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m) { return _mm256_mask_add_pd(a, m, a, b); }
static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_cmp_pd_mask(a, b, _CMP_LT_OQ); }
static inline MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b) { return _kand_mask8(a, b); }
static inline MD_SIMD_MASK simd_mask_from_u32(unsigned int a) { return _cvtu32_mask8(a); }
static inline unsigned int simd_mask_to_u32(MD_SIMD_MASK a) { return _cvtmask8_u32(a); }
static inline MD_FLOAT simd_h_reduce_sum(MD_SIMD_FLOAT a) {
    __m128d a0, a1;
    // test with shuffle & add as an alternative to hadd later
    a = _mm256_hadd_pd(a, a);
    a0 = _mm256_castpd256_pd128(a);
    a1 = _mm256_extractf128_pd(a, 0x1);
    a0 = _mm_add_sd(a0, a1);
    return *((MD_FLOAT *) &a0);
}

#endif
