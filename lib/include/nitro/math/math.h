#ifndef NITRO_MATH_MATH_H
#define NITRO_MATH_MATH_H

#include <nitro/misc.h>
#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// MACROS
// --------------------

#define MATH_ABS(a)              (((a) < 0) ? (-(a)) : (a))
#define MATH_CLAMP(x, low, high) (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))
#define MATH_MIN(a, b)           (((a) <= (b)) ? (a) : (b))
#define MATH_MAX(a, b)           (((a) >= (b)) ? (a) : (b))
#define MATH_ROUNDUP(x, base)    (((x) + ((base)-1)) & ~((base)-1))
#define MATH_ROUNDDOWN(x, base)  ((x) & ~((base)-1))
#define MATH_ROUNDUP32(x)        MATH_ROUNDUP(x, 32)
#define MATH_ROUNDDOWN32(x)      MATH_ROUNDDOWN(x, 32)

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE int MATH_IAbs(int a)
{
    return (a < 0) ? -a : a;
}

SDK_INLINE int MATH_IMin(int a, int b)
{
    return (a <= b) ? a : b;
}

SDK_INLINE int MATH_IMax(int a, int b)
{
    return (a >= b) ? a : b;
}

// --------------------
// FUNCTIONS
// --------------------

u8 MATH_CountPopulation(u32 x);

#ifdef __cplusplus
}
#endif

#endif // NITRO_MATH_MATH_H
