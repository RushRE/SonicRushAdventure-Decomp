#include <nitro/types.h>

#ifndef NITRO_MATH_RAND_H
#define NITRO_MATH_RAND_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u64 x;
    u64 mul;
    u64 add;
} MATHRandContext32;

typedef struct
{
    u32 x;
    u32 mul;
    u32 add;
} MATHRandContext16;

// --------------------
// INLINE FUNCTIONS
// --------------------

static inline void MATH_InitRand32(MATHRandContext32 *context, u64 seed)
{
    context->x   = seed;
    context->mul = (1566083941LL << 32) + 1812433253LL;
    context->add = 2531011;
}

static inline u32 MATH_Rand32(MATHRandContext32 *context, u32 max)
{
    context->x = context->mul * context->x + context->add;

    // If the "max" argument is a constant, optimized by compiler.
    if (max == 0)
    {
        return (u32)(context->x >> 32);
    }
    else
    {
        return (u32)(((context->x >> 32) * max) >> 32);
    }
}

static inline void MATH_InitRand16(MATHRandContext16 *context, u32 seed)
{
    context->x   = seed;
    context->mul = 1566083941LL;
    context->add = 2531011;
}

static inline u16 MATH_Rand16(MATHRandContext16 *context, u16 max)
{
    context->x = context->mul * context->x + context->add;

    if (max == 0)
    {
        return (u16)(context->x >> 16);
    }
    else
    {
        return (u16)(((context->x >> 16) * max) >> 16);
    }
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_MATH_RAND_H