/*
 * Copyright (C)  NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <immintrin.h>
#include <stdlib.h>
#include <string.h>

#define MD_SIMD_FLOAT __m256d
#define MD_SIMD_INT   __m128i
#define MD_SIMD_MASK  __m256d

static inline int simd_test_any(MD_SIMD_MASK a)
{
    __m256i a_si256 = _mm256_castpd_si256(a);
    return _mm256_testz_si256(a_si256, a_si256) == 0;
}

static inline MD_SIMD_FLOAT simd_broadcast(MD_FLOAT scalar)
{
    return _mm256_set1_pd(scalar);
}
static inline MD_SIMD_FLOAT simd_zero() { return _mm256_set1_pd(0.0); }
static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    return _mm256_add_pd(a, b);
}
static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    return _mm256_sub_pd(a, b);
}
static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    return _mm256_mul_pd(a, b);
}
static inline MD_SIMD_FLOAT simd_load(MD_FLOAT* p) { return _mm256_load_pd(p); }
static inline void simd_store(MD_FLOAT* p, MD_SIMD_FLOAT a) { _mm256_store_pd(p, a); }
static inline MD_SIMD_FLOAT simd_load_h_duplicate(const MD_FLOAT* m)
{
    MD_SIMD_FLOAT ret;
    fprintf(stderr,
        "simd_load_h_duplicate(): Not implemented for AVX with double precision!");
    exit(-1);
    return ret;
}

static inline MD_SIMD_FLOAT simd_load_h_dual(const MD_FLOAT* m)
{
    MD_SIMD_FLOAT ret;
    fprintf(stderr, "simd_load_h_dual(): Not implemented for AVX with double precision!");
    exit(-1);
    return ret;
}

static inline MD_FLOAT simd_h_dual_incr_reduced_sum(
    MD_FLOAT* m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1)
{
    fprintf(stderr,
        "simd_h_dual_incr_reduced_sum(): Not implemented for AVX with double precision!");
    exit(-1);
    return 0.0;
}

static inline MD_FLOAT simd_incr_reduced_sum(
    MD_FLOAT* m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1, MD_SIMD_FLOAT v2, MD_SIMD_FLOAT v3)
{
    __m256d t0, t1, t2;
    __m128d a0, a1;

    t0 = _mm256_hadd_pd(v0, v1);
    t1 = _mm256_hadd_pd(v2, v3);
    t2 = _mm256_permute2f128_pd(t0, t1, 0x21);
    t0 = _mm256_add_pd(t0, t2);
    t1 = _mm256_add_pd(t1, t2);
    t0 = _mm256_blend_pd(t0, t1, 0b1100);
    t1 = _mm256_add_pd(t0, _mm256_load_pd(m));
    _mm256_store_pd(m, t1);

    t0 = _mm256_add_pd(t0, _mm256_permute_pd(t0, 0b0101));
    a0 = _mm256_castpd256_pd128(t0);
    a1 = _mm256_extractf128_pd(t0, 0x1);
    a0 = _mm_add_sd(a0, a1);
    return *((MD_FLOAT*)&a0);
}

static inline MD_SIMD_FLOAT select_by_mask(MD_SIMD_FLOAT a, MD_SIMD_MASK m)
{
    return _mm256_and_pd(a, m);
}
static inline MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a)
{
    return _mm256_cvtps_pd(_mm_rcp_ps(_mm256_cvtpd_ps(a)));
}
#ifdef __ISA_AVX_FMA__
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c)
{
    return _mm256_fmadd_pd(a, b, c);
}
#else
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c)
{
    return simd_add(simd_mul(a, b), c);
}
#endif
static inline MD_SIMD_FLOAT simd_masked_add(
    MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m)
{
    return simd_add(a, _mm256_and_pd(b, m));
}
static inline MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    return _mm256_cmp_pd(a, b, _CMP_LT_OQ);
}
static inline MD_SIMD_MASK simd_mask_int_cond_lt(MD_SIMD_INT a, MD_SIMD_INT b)
{
    return _mm256_cvtepi32_pd(_mm_cmplt_epi32(a, b));
}
static inline MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b)
{
    return _mm256_and_pd(a, b);
}
// TODO: Initialize all diagonal cases and just select the proper one (all bits set or
// diagonal) based on cond0
static inline MD_SIMD_MASK simd_mask_from_u32(unsigned int a)
{
    const unsigned long long int all  = 0xFFFFFFFFFFFFFFFF;
    const unsigned long long int none = 0x0;
    return _mm256_castsi256_pd(_mm256_set_epi64x((a & 0x8) ? all : none,
        (a & 0x4) ? all : none,
        (a & 0x2) ? all : none,
        (a & 0x1) ? all : none));
}
// TODO: Implement this, althrough it is just required for debugging
static inline int simd_mask_to_u32(MD_SIMD_MASK a) { return 0; }
static inline MD_FLOAT simd_h_reduce_sum(MD_SIMD_FLOAT a)
{
    __m128d a0, a1;
    a  = _mm256_add_pd(a, _mm256_permute_pd(a, 0b0101));
    a0 = _mm256_castpd256_pd128(a);
    a1 = _mm256_extractf128_pd(a, 0x1);
    a0 = _mm_add_sd(a0, a1);
    return *((MD_FLOAT*)&a0);
}

static inline void simd_h_decr3(
    MD_FLOAT* m, MD_SIMD_FLOAT a0, MD_SIMD_FLOAT a1, MD_SIMD_FLOAT a2)
{
    fprintf(stderr, "simd_h_decr3(): Not implemented for AVX with double precision!");
    exit(-1);
}

static inline MD_SIMD_INT simd_int_broadcast(int scalar)
{
    return _mm_set1_epi32(scalar);
}
static inline MD_SIMD_INT simd_int_zero() { return _mm_setzero_si128(); }
static inline MD_SIMD_INT simd_int_seq() { return _mm_set_epi32(3, 2, 1, 0); }
static inline MD_SIMD_INT simd_int_load(const int* m)
{
    return _mm_load_si128((__m128i const*)m);
}
static inline MD_SIMD_INT simd_int_add(MD_SIMD_INT a, MD_SIMD_INT b)
{
    return _mm_add_epi32(a, b);
}
static inline MD_SIMD_INT simd_int_mul(MD_SIMD_INT a, MD_SIMD_INT b)
{
    return _mm_mul_epi32(a, b);
}
static inline MD_SIMD_INT simd_int_mask_load(const int* m, MD_SIMD_MASK k)
{
    return simd_int_load(m) & _mm256_cvtpd_epi32(k);
}

static inline MD_SIMD_INT simd_int_load_h_duplicate(const int* m)
{
    MD_SIMD_INT ret;
    fprintf(stderr,
        "simd_int_load_h_duplicate(): Not implemented for AVX2 with double precision!");
    exit(-1);
    return ret;
}

static inline MD_SIMD_INT simd_int_load_h_dual_scaled(const int* m, int scale)
{
    MD_SIMD_INT ret;
    fprintf(stderr,
        "simd_int_load_h_dual_scaled(): Not implemented for AVX2 with double precision!");
    exit(-1);
    return ret;
}

static inline MD_SIMD_FLOAT simd_gather(MD_SIMD_INT vidx, MD_FLOAT* base, const int scale)
{
    __m128i scaled = vidx; // _mm_mullo_epi32(vidx, _mm_set1_epi32(scale));
    int i0         = _mm_extract_epi32(scaled, 0);
    int i1         = _mm_extract_epi32(scaled, 1);
    int i2         = _mm_extract_epi32(scaled, 2);
    int i3         = _mm_extract_epi32(scaled, 3);
    return _mm256_set_pd(base[i3], base[i2], base[i1], base[i0]);
}
