// #include <arm_neon.h>
#warning neon_float
// Typedefs for MD_SIMD_FLOAT and MD_SIMD_MASK
typedef float32x4_t MD_SIMD_FLOAT;
typedef uint32x4_t MD_SIMD_MASK;

// Broadcasting a scalar value to a SIMD vector
static inline MD_SIMD_FLOAT simd_broadcast(float value) { return vdupq_n_f32(value); }

// Zeroing a SIMD vector
static inline MD_SIMD_FLOAT simd_zero(void) { return vdupq_n_f32(0.0f); }

// Helper function to subtract two float64x2x2_t vectors
static inline MD_SIMD_FLOAT simd_sub(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b)
{
    MD_SIMD_FLOAT result;
    result = vsubq_f32(a, b);
    return result;
}

// Loading data into a SIMD vector
static inline MD_SIMD_FLOAT simd_load(const float* ptr) { return vld1q_f32(ptr); }

// Storing data from a SIMD vector
static inline void simd_store(MD_FLOAT* ptr, MD_SIMD_FLOAT vec) { vst1q_f32(ptr, vec); }

// Adding two SIMD vectors
static inline MD_SIMD_FLOAT simd_add(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return vaddq_f32(a, b); }

// Multiplying two SIMD vectors
static inline MD_SIMD_FLOAT simd_mul(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) { return vmulq_f32(a, b); }

// Fused multiply-add operation
static inline MD_SIMD_FLOAT simd_fma(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT c)
{
    return vfmaq_f32(c, a, b);
}

static inline MD_SIMD_FLOAT simd_mask_from_u32(uint32_t a)
{
    const uint32_t all  = 0xFFFFFFFF;
    const uint32_t none = 0x0;
    return vreinterpretq_f32_u32(vsetq_lane_u32((a & 0x8) ? all : none,
        vsetq_lane_u32((a & 0x4) ? all : none,
            vsetq_lane_u32((a & 0x2) ? all : none,
                vsetq_lane_u32((a & 0x1) ? all : none, vdupq_n_u32(0), 0),
                1),
            2),
        3));
}

static inline float32x4_t simd_mask_and(float32x4_t a, float32x4_t b) {
    return vreinterpretq_f32_u32(vandq_u32(vreinterpretq_u32_f32(a), vreinterpretq_u32_f32(b)));
}

static inline float32x4_t simd_mask_cond_lt(float32x4_t a, float32x4_t b) {
    return vreinterpretq_f32_u32(vcltq_f32(a, b));
}

static inline float32x4_t simd_reciprocal(float32x4_t a) {
    float32x4_t reciprocal = vrecpeq_f32(a);
    reciprocal = vmulq_f32(reciprocal, vrecpsq_f32(reciprocal, a));
    return reciprocal;
}

static inline float simd_incr_reduced_sum(float *m, float32x4_t v0, float32x4_t v1, float32x4_t v2, float32x4_t v3) {
    // Horizontal add pairs within each vector
    float32x4_t sum0 = vpaddq_f32(v0, v1); // Add pairs in v0 and v1
    float32x4_t sum1 = vpaddq_f32(v2, v3); // Add pairs in v2 and v3

    // Combine the two resulting vectors
    float32x4_t sum = vpaddq_f32(sum0, sum1); // Add pairs in sum0 and sum1

    // Load existing values from memory and add to the sum
    float32x4_t mem = vld1q_f32(m);
    sum = vaddq_f32(sum, mem);

    // Store the result back to memory
    vst1q_f32(m, sum);

    // Reduce the final vector to a single float
    float32x2_t sum_low = vget_low_f32(sum);
    float32x2_t sum_high = vget_high_f32(sum);
    sum_low = vadd_f32(sum_low, sum_high); // Add high and low parts

    sum_low = vpadd_f32(sum_low, sum_low); // Horizontal add
    return vget_lane_f32(sum_low, 0); // Extract the final sum
}

static inline float32x4_t simd_masked_add(float32x4_t a, float32x4_t b, uint32x4_t m) {
    // Perform bitwise AND operation on the mask and vector b
    float32x4_t masked_b = vreinterpretq_f32_u32(vandq_u32(vreinterpretq_u32_f32(b), m));
    // Add the result to vector a
    return vaddq_f32(a, masked_b);
}


// // Reciprocal approximation
// MD_SIMD_FLOAT simd_reciprocal(MD_SIMD_FLOAT a) {
//     return vrecpeq_f32(a);
// }

// // Mask for comparison (less than)
// MD_SIMD_MASK simd_mask_cond_lt(MD_SIMD_FLOAT a, MD_SIMD_FLOAT b) {
//     return vcltq_f32(a, b);
// }

// // Logical AND operation on masks
// MD_SIMD_MASK simd_mask_and(MD_SIMD_MASK a, MD_SIMD_MASK b) {
//     return vandq_u32(a, b);
// }

// Select elements based on mask
MD_SIMD_FLOAT select_by_mask(MD_SIMD_FLOAT a, MD_SIMD_MASK mask) {
    return vbslq_f32(mask, a, vdupq_n_f32(0.0f));
}

// // Mask creation from unsigned int
// MD_SIMD_MASK simd_mask_from_u32(unsigned int value) {
//     return vdupq_n_u32(value);
// }

// // Increment reduced sum
// void simd_incr_reduced_sum(float* ptr, MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_FLOAT
// c, MD_SIMD_FLOAT d) {
//     MD_SIMD_FLOAT sum = vaddq_f32(vaddq_f32(a, b), vaddq_f32(c, d));
//     float result[4];
//     vst1q_f32(result, sum);
//     for (int i = 0; i < 4; i++) {
//         ptr[i] += result[i];
//     }
// }
static inline MD_SIMD_FLOAT simd_load_h_dual(const MD_FLOAT* m)
{
    return vdupq_n_f32(0.0f);
}

static inline MD_SIMD_FLOAT simd_load_h_duplicate(const MD_FLOAT* m)
{
    return vdupq_n_f32(0.0f);
}

// static inline MD_SIMD_FLOAT simd_masked_add(
//     MD_SIMD_FLOAT a, MD_SIMD_FLOAT b, MD_SIMD_MASK m)
// {
//     return vdupq_n_f32(0.0f);
// }

static inline void simd_h_decr3(
    MD_FLOAT* m, MD_SIMD_FLOAT a0, MD_SIMD_FLOAT a1, MD_SIMD_FLOAT a2)
{
    return;
}

static inline MD_FLOAT simd_h_dual_incr_reduced_sum(
    MD_FLOAT* m, MD_SIMD_FLOAT v0, MD_SIMD_FLOAT v1)
{
    return 0.0f;
}
