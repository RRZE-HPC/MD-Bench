/*
 * Copyright (C) 2022 NHR@FAU, University Erlangen-Nuremberg.
 * All rights reserved. This file is part of MD-Bench.
 * Use of this source code is governed by a LGPL-3.0
 * license that can be found in the LICENSE file.
 */
#include <immintrin.h>
#ifndef NO_ZMM_INTRIN
#   include <zmmintrin.h>
#endif

#define MD_SIMD_FLOAT   __m512d
#define MD_SIMD_MASK    __mmask8
#define MD_SIMD_INT     __m256i

static inline MD_SIMD_FLOAT simd_broadcast(MD_FLOAT scalar) { return _mm512_set1_pd(scalar); }
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
static inline void simd_store(MD_FLOAT *p, MD_SIMD_FLOAT a) { _mm512_store_pd(p, a); }
static inline MD_SIMD_FLOAT select_by_mask(MD_SIMD_FLOAT a, MD_SIMD_MASK m) { return _mm512_mask_mov_pd(_mm512_setzero_pd(), m, a); }
static inline MD_FLOAT simd_h_reduce_sum(MD_SIMD_FLOAT a) {
    MD_SIMD_FLOAT x = _mm512_add_pd(a, _mm512_shuffle_f64x2(a, a, 0xee));
    x = _mm512_add_pd(x, _mm512_shuffle_f64x2(x, x, 0x11));
    x = _mm512_add_pd(x, _mm512_permute_pd(x, 0x01));
    return *((MD_FLOAT *) &x);
}

static inline MD_FLOAT simd_incr_reduced_sum(MD_FLOAT *m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1, MD_SIMD_FLOAT v2, MD_SIMD_FLOAT v3) {
    __m512d t0, t2;
    __m256d t3, t4;

    t0 = _mm512_add_pd(v0, _mm512_permute_pd(v0, 0x55));
    t2 = _mm512_add_pd(v2, _mm512_permute_pd(v2, 0x55));
    t0 = _mm512_mask_add_pd(t0, simd_mask_from_u32(0xaa), v1, _mm512_permute_pd(v1, 0x55));
    t2 = _mm512_mask_add_pd(t2, simd_mask_from_u32(0xaa), v3, _mm512_permute_pd(v3, 0x55));
    t0 = _mm512_add_pd(t0, _mm512_shuffle_f64x2(t0, t0, 0x4e));
    t0 = _mm512_mask_add_pd(t0, simd_mask_from_u32(0xF0), t2, _mm512_shuffle_f64x2(t2, t2, 0x4e));
    t0 = _mm512_add_pd(t0, _mm512_shuffle_f64x2(t0, t0, 0xb1));
    t0 = _mm512_mask_shuffle_f64x2(t0, simd_mask_from_u32(0x0C), t0, t0, 0xee);
    t3 = _mm512_castpd512_pd256(t0);
    t4 = _mm256_load_pd(m);
    t4 = _mm256_add_pd(t4, t3);
    _mm256_store_pd(m, t4);

    t0 = _mm512_add_pd(t0, _mm512_permutex_pd(t0, 0x4e));
    t0 = _mm512_add_pd(t0, _mm512_permutex_pd(t0, 0xb1));
    return _mm_cvtsd_f64(_mm512_castpd512_pd128(t0));
}

static inline MD_SIMD_FLOAT simd_load_h_duplicate(const MD_FLOAT *m) {
    return _mm512_broadcast_f64x4(_mm256_load_pd(m));
}

static inline MD_SIMD_FLOAT simd_load_h_dual(const MD_FLOAT *m) {
    return _mm512_insertf64x4(_mm512_broadcastsd_pd(_mm_load_sd(m)), _mm256_broadcastsd_pd(_mm_load_sd(m + 1)), 1);
}

static inline MD_FLOAT simd_h_dual_incr_reduced_sum(MD_FLOAT *m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1) {
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

inline void simd_h_decr(MD_FLOAT *m, MD_SIMD_FLOAT a) {
    __m256d t;
    a = _mm512_add_pd(a, _mm512_shuffle_f64x2(a, a, 0xee));
    t = _mm256_load_pd(m);
    t = _mm256_sub_pd(t, _mm512_castpd512_pd256(a));
    _mm256_store_pd(m, t);
}

static inline void simd_h_decr3(MD_FLOAT *m, MD_SIMD_FLOAT a0, MD_SIMD_FLOAT a1, MD_SIMD_FLOAT a2) {
    simd_h_decr(m, a0);
    simd_h_decr(m + CLUSTER_N, a1);
    simd_h_decr(m + CLUSTER_N * 2, a2);
}

// Functions used in LAMMPS kernel
static inline MD_SIMD_FLOAT simd_gather(MD_SIMD_INT vidx, const MD_FLOAT *m, int s) { return _mm512_i32gather_pd(vidx, m, s); }
static inline MD_SIMD_INT simd_int_broadcast(int scalar) { return _mm256_set1_epi32(scalar); }
static inline MD_SIMD_INT simd_int_zero() { return _mm256_setzero_si256(); }
static inline MD_SIMD_INT simd_int_seq() { return _mm256_set_epi32(7, 6, 5, 4, 3, 2, 1, 0); }
static inline MD_SIMD_INT simd_int_load(const int *m) { return _mm256_load_epi32(m); }
static inline MD_SIMD_INT simd_int_add(MD_SIMD_INT a, MD_SIMD_INT b) { return _mm256_add_epi32(a, b); }
static inline MD_SIMD_INT simd_int_mul(MD_SIMD_INT a, MD_SIMD_INT b) { return _mm256_mul_epi32(a, b); }
static inline MD_SIMD_INT simd_int_mask_load(const int *m, MD_SIMD_MASK k) { return _mm256_mask_load_epi32(simd_int_zero(), k, m); }
static inline MD_SIMD_MASK simd_mask_int_cond_lt(MD_SIMD_INT a, MD_SIMD_INT b) { return _mm256_cmp_epi32_mask(a, b, _MM_CMPINT_LT); }
