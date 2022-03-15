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

#define SIMD_PRINT_REAL(a)  simd_print_real(#a, a);
#define SIMD_PRINT_MASK(a)  simd_print_mask(#a, a);

#ifdef AVX512

#if PRECISION == 2 // Double precision

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

#else // Single-precision

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

static inline MD_SIMD_FLOAT simd_load_h_duplicate(const float* m) {
    return _mm512_castpd_ps(_mm512_broadcast_f64x4(_mm256_load_pd((const double *)(m))));
}

static inline MD_SIMD_FLOAT simd_load_h_dual(const float* m) {
    return _mm512_shuffle_f32x4(_mm512_broadcastss_ps(_mm_load_ss(m)), _mm512_broadcastss_ps(_mm_load_ss(m + 1)), 0x44);
}

static inline MD_FLOAT simd_h_dual_reduce_sum(float* m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1) {
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

#endif // PRECISION

#else // AVX or AVX2

#if PRECISION == 2 // Double precision

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

#else // Single-precision

#define MD_SIMD_FLOAT       __m256

#ifdef NO_AVX2
#define MD_SIMD_MASK        __m256
#else
#define MD_SIMD_MASK        __mmask8
#endif

static inline MD_SIMD_FLOAT simd_broadcast(float scalar) { return _mm256_set1_ps(scalar); }
static inline MD_SIMD_FLOAT simd_zero() { return _mm256_set1_ps(0.0); }
static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_add_ps(a, b); }
static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_sub_ps(a, b); }
static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_mul_ps(a, b); }
static inline MD_SIMD_FLOAT simd_load(MD_FLOAT *p) { return _mm256_load_ps(p); }

#ifdef NO_AVX2

#error "AVX intrinsincs with single-precision not implemented!"

#else // AVX2

static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a) { return _mm256_rcp14_ps(a); }
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c) { return _mm256_fmadd_ps(a, b, c); }
static inline MD_SIMD_FLOAT simd_masked_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m) { return _mm256_mask_add_ps(a, m, a, b); }
static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return _mm256_cmp_pd_mask(a, b, _CMP_LT_OQ); }
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

#endif // NO_AVX2

#endif // PRECISION

#endif // AVX or AVX2

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
