#ifndef RUSH_MTMATH_H
#define RUSH_MTMATH_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// MACROS
// --------------------

#define FLOAT_DEG_TO_IDX(deg)      (u16)((deg) * (65536.0f / 360.0f)) // 0-360 -> 0-65535
#define FLOAT_IDX_TO_FX16_IDX(deg) (u16)((deg) * (65536.0f))          // 0-1 -> 0-65535

#define FLOAT_IDX_TO_DEG(idx) (u16)((idx) * (360.0f / 65536.0f))

#define FX32_TO_WHOLE(num)   ((num) >> FX32_SHIFT) // fx32 number to a whole number
#define FX32_FROM_WHOLE(num) ((num) << FX32_SHIFT) // whole number to an fx32 number

#define MATH_SQUARED(x) ((x) * (x))

#define MT_MATH_MIN(a, b) (((a) < (b)) ? (a) : (b))
#define MT_MATH_MAX(a, b) (((a) > (b)) ? (a) : (b))

#define VOID_TO_INT(x) (size_t)(void *)(x)
#define INT_TO_VOID(x) (void *)(size_t)(x)

// non-fx32 squared function
#define MT_SQUARED(x) ((x) * (x))

// --------------------
// STRUCTS
// --------------------

typedef struct Vec2Fx32_
{
    fx32 x;
    fx32 y;
} Vec2Fx32;

typedef struct Vec2Fx16_
{
    fx16 x;
    fx16 y;
} Vec2Fx16;

typedef struct Vec2U16_
{
    u16 x;
    u16 y;
} Vec2U16;

typedef struct VecU16_
{
    u16 x;
    u16 y;
    u16 z;
} VecU16;

// --------------------
// VARIABLES
// --------------------

extern u32 _mt_math_rand;

// --------------------
// FUNCTIONS
// --------------------

void InitMtMath(void);
s32 Math__Func_207B14C(s32 angle);
u16 Math__Func_207B1A4(s32 angle);

// --------------------
// INLINE FUNCTIONS
// --------------------

#define XOR_SWAP(a, b)                                                                                                                                                             \
    a ^= b;                                                                                                                                                                        \
    b ^= a;                                                                                                                                                                        \
    a = (a ^ b);

RUSH_INLINE void mtMathSetRandSeed(u32 seed)
{
    _mt_math_rand = seed;
}

RUSH_INLINE u32 mtMathGetRandSeed(void)
{
    return _mt_math_rand;
}

RUSH_INLINE u16 mtMathRand(void)
{
    _mt_math_rand = (u32)(1663525 * (s32)_mt_math_rand + 1013904223);
    return (u16)(_mt_math_rand >> 16);
}

RUSH_INLINE s32 ClampS32(s32 x, s32 low, s32 high)
{
    s32 result = x;

    if (result < low)
        result = low;
    else if (result > high)
        result = high;

    return result;
}

RUSH_INLINE void ClampSingleS32(s32 *value, s32 clampVal)
{
    if (*value >= 0)
    {
        if (*value > clampVal)
            *value = clampVal;
    }
    else 
    {
        if (*value < -clampVal)
            *value = -clampVal;
    }
}

RUSH_INLINE s32 MTM_MATH_CLIP(s32 a, s32 low, s32 high)
{
    if (a < low)
        return low;
    return a <= high ? a : high;
}

RUSH_INLINE u32 MTM_MATH_CLIP_U32(u32 a, u32 low, u32 high)
{
    if (a < low)
        return low;
    return a <= high ? a : high;
}

RUSH_INLINE s16 MTM_MATH_CLIP_S16(s16 a, s16 low, s16 high)
{
    if (a < low)
        return low;
    return a <= high ? a : high;
}

RUSH_INLINE u16 MTM_MATH_CLIP_U16(u16 a, u16 low, u16 high)
{
    if (a < low)
        return low;
    return a <= high ? a : high;
}

RUSH_INLINE s8 MTM_MATH_CLIP_S8(s8 a, s8 low, s8 high)
{
    if (a < low)
        return low;
    return a <= high ? a : high;
}

RUSH_INLINE u8 MTM_MATH_CLIP_U8(u8 a, u8 low, u8 high)
{
    if (a < low)
        return low;
    return a <= high ? a : high;
}

// alternate version of MTM_MATH_CLIP that matches for various funcs where MTM_MATH_CLIP doesn't
RUSH_INLINE s32 MTM_MATH_CLIP_2(s32 a, s32 low, s32 high)
{
    if (a < low)
        return low;

    return a > high ? high : a;
}

RUSH_INLINE s32 Abs(s32 x)
{
    return x < 0 ? (-x) : (x);
}

RUSH_INLINE s32 MultiplyFX(s32 v1, s32 v2)
{
    return FX32_CAST((s64)v1 * (s64)v2 + 0x800L >> FX32_SHIFT);
}

// fx32 squared function
RUSH_INLINE s32 SquaredFX(s32 v1)
{
    return MultiplyFX(v1, v1);
}

RUSH_INLINE fx16 SinFX(u16 idx)
{
    return FX_SinIdx(idx);
}

RUSH_INLINE fx16 CosFX(u16 idx)
{
    return FX_CosIdx(idx);
}

RUSH_INLINE void mtSwapS32(s32 *a, s32 *b)
{
    *a = *b ^ *a;
    *b ^= *a;
    *a ^= *b;
}

RUSH_INLINE void mtSwapU32(u32 *a, u32 *b)
{
    *a = *b ^ *a;
    *b ^= *a;
    *a ^= *b;
}

RUSH_INLINE void mtSwapS16(s16 *a, s16 *b)
{
    *a = *b ^ *a;
    *b ^= *a;
    *a ^= *b;
}

RUSH_INLINE void mtSwapU16(u16 *a, u16 *b)
{
    *a = *b ^ *a;
    *b ^= *a;
    *a ^= *b;
}

RUSH_INLINE fx32 mtLerp(s16 percent, fx32 start, fx32 target)
{
    s32 loopCount = 1;
    do
    {
        start += MultiplyFX((target - start), percent);
    } while (loopCount-- != 0);

    return start;
}

RUSH_INLINE fx32 mtLerpEx(s16 percent, fx32 start, fx32 target, s32 loopCount)
{
    do
    {
        start += MultiplyFX((target - start), percent);
    } while (loopCount-- != 0);

    return start;
}

RUSH_INLINE fx32 mtLerpEx2(s16 percent, fx32 start, fx32 target, s32 loopCount)
{
    do
    {
        target = start + MultiplyFX((target - start), percent);
    } while (loopCount-- != 0);

    return target;
}

RUSH_INLINE fx32 mtMoveTowards(fx32 speed, fx32 current, fx32 target)
{
    return MultiplyFX(speed, target - current);
}

RUSH_INLINE void VEC_SetSingle(VecFx32 *vec, fx32 value)
{
    vec->x = vec->y = vec->z = value;
}

RUSH_INLINE void VEC_SetFromArray(VecFx32 *vec, fx32 *values)
{
    *vec = *(VecFx32 *)values;
}

SDK_INLINE void VEC2_Set(Vec2Fx32 *a, fx32 x, fx32 y)
{
    a->x = x;
    a->y = y;
}

SDK_INLINE void VEC2_Fx16Set(Vec2Fx16 *a, fx16 x, fx16 y)
{
    a->x = x;
    a->y = y;
}

#ifdef __cplusplus
}
#endif

#endif // RUSH_MTMATH_H
