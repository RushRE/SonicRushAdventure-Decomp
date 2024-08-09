#include <nitro.h>

#ifdef SDK_ARM9

// --------------------
// CONSTANTS
// --------------------

#define FX_DIV_SHIFT (32 - FX32_SHIFT)
#define FX_DIV_1_2   (1 << (FX_DIV_SHIFT - 1))

#define FX_SQRT_SHIFT ((32 + FX32_SHIFT) / 2 - FX32_SHIFT)
#define FX_SQRT_1_2   (1 << (FX_SQRT_SHIFT - 1))

#define FX_INVSQRT_SHIFT (FX64C_SHIFT + ((32 + FX32_SHIFT) / 2 - FX32_SHIFT))
#define FX_INVSQRT_1_2   (1LL << (FX_INVSQRT_SHIFT - 1))

// --------------------
// FUNCTIONS
// --------------------

fx32 FX_Div(fx32 numer, fx32 denom)
{
    FX_DivAsync(numer, denom);
    return FX_GetDivResult();
}

fx32 FX_Inv(fx32 denom)
{
    FX_InvAsync(denom);
    return FX_GetDivResult();
}

fx64c FX_InvFx64c(fx32 denom)
{
    FX_InvAsync(denom);
    return (fx64c)CP_GetDivResult64();
}

fx32 FX_Sqrt(fx32 x)
{
    if (x > 0)
    {
        CP_SetSqrt64((u64)x << 32);
        return FX_GetSqrtResult();
    }
    else
    {
        return 0;
    }
}

fx64c FX_GetDivResultFx64c(void)
{
    return (fx64c)CP_GetDivResult64();
}

fx32 FX_GetDivResult(void)
{
    return (fx32)((CP_GetDivResult64() + FX_DIV_1_2) >> FX_DIV_SHIFT);
}

void FX_InvAsync(fx32 denom)
{
    CP_SetDiv64_32((u64)FX32_ONE << 32, (u32)denom);
}

fx32 FX_GetSqrtResult(void)
{
    return (fx32)((CP_GetSqrtResult32() + FX_SQRT_1_2) >> FX_SQRT_SHIFT);
}

void FX_DivAsync(fx32 numer, fx32 denom)
{
    CP_SetDiv64_32((u64)numer << 32, (u32)denom);
}

s32 FX_DivS32(s32 a, s32 b)
{
    CP_SetDiv32_32((u32)a, (u32)b);
    return CP_GetDivResult32();
}

s32 FX_ModS32(s32 a, s32 b)
{
    CP_SetDiv32_32((u32)a, (u32)b);
    return CP_GetDivRemainder32();
}

#endif