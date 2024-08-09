#ifndef NITRO_FX_FX_CP_H
#define NITRO_FX_FX_CP_H

#include <nitro/types.h>
#include <nitro/fx/fx.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define CP_DIV_32_32BIT_MODE (0UL << REG_CP_DIVCNT_MODE_SHIFT)
#define CP_DIV_64_32BIT_MODE (1UL << REG_CP_DIVCNT_MODE_SHIFT)
#define CP_DIV_64_64BIT_MODE (2UL << REG_CP_DIVCNT_MODE_SHIFT)

#define CP_SQRT_32BIT_MODE (0UL << REG_CP_SQRTCNT_MODE_SHIFT)
#define CP_SQRT_64BIT_MODE (1UL << REG_CP_SQRTCNT_MODE_SHIFT)

// --------------------
// FUNCTIONS
// --------------------

fx32 FX_Div(fx32 numer, fx32 denom);
fx32 FX_Inv(fx32 denom);
fx64c FX_InvFx64c(fx32 denom);
fx32 FX_Sqrt(fx32 x);
fx64c FX_GetDivResultFx64c(void);
fx32 FX_GetDivResult(void);
void FX_InvAsync(fx32 denom);
fx32 FX_GetSqrtResult(void);
void FX_DivAsync(fx32 numer, fx32 denom);
s32 FX_DivS32(s32 a, s32 b);
s32 FX_ModS32(s32 a, s32 b);

// --------------------
// INLINE FUNCTIONS
// --------------------

static inline s32 CP_IsDivBusy(void)
{
    return (reg_CP_DIVCNT & REG_CP_DIVCNT_BUSY_MASK);
}

static inline s32 CP_IsSqrtBusy(void)
{
    return (reg_CP_SQRTCNT & REG_CP_SQRTCNT_BUSY_MASK);
}

static inline void CP_WaitDiv(void)
{
    while (CP_IsDivBusy())
    {
        // waiting...
    }
}

static inline void CP_WaitSqrt(void)
{
    while (CP_IsSqrtBusy())
    {
        // waiting...
    }
}

static inline s64 CP_GetDivResultImm64(void)
{
    return (s64)(*(REGType64 *)REG_DIV_RESULT_ADDR);
}

static inline void CP_SetDivImm32_32_NS_(u32 numer, u32 denom)
{
    *(REGType32 *)REG_DIV_NUMER_ADDR = numer;
    *(REGType64 *)REG_DIV_DENOM_ADDR = denom;
}

static inline void CP_SetDivImm64_32_NS_(u64 numer, u32 denom)
{
    *(REGType64 *)REG_DIV_NUMER_ADDR = numer;
    *(REGType64 *)REG_DIV_DENOM_ADDR = denom;
}

static inline void CP_SetDivImm64_64_NS_(u64 numer, u64 denom)
{
    *(REGType64 *)REG_DIV_NUMER_ADDR = numer;
    *(REGType64 *)REG_DIV_DENOM_ADDR = denom;
}

static inline void CP_SetDiv64_64(u64 numer, u64 denom)
{
    reg_CP_DIVCNT = CP_DIV_64_64BIT_MODE;
    CP_SetDivImm64_64_NS_(numer, denom);
}

static inline void CP_SetDiv64_32(u64 numer, u32 denom)
{
    reg_CP_DIVCNT = CP_DIV_64_32BIT_MODE;
    CP_SetDivImm64_32_NS_(numer, denom);
}

static inline void CP_SetDiv32_32(u32 numer, u32 denom)
{
    reg_CP_DIVCNT = CP_DIV_32_32BIT_MODE;
    CP_SetDivImm32_32_NS_(numer, denom);
}

static inline s32 CP_GetDivResultImm32()
{
    return (s32)(*(REGType32 *)REG_DIV_RESULT_ADDR);
}

static inline s32 CP_GetDivRemainderImm32()
{
    return (s32)(*(REGType32 *)REG_DIVREM_RESULT_ADDR);
}

static inline void CP_SetDivImm64_32(u64 numer, u32 denom)
{
    CP_SetDivImm64_32_NS_(numer, denom);
}

static inline void CP_SetSqrtImm64_NS_(u64 param)
{
    *((REGType64 *)REG_SQRT_PARAM_ADDR) = param;
}

static inline u32 CP_GetSqrtResultImm32(void)
{
    return (u32)(*((REGType32 *)REG_SQRT_RESULT_ADDR));
}

static inline s64 CP_GetDivResult64(void)
{
    CP_WaitDiv();
    return CP_GetDivResultImm64();
}

static inline s32 CP_GetDivResult32(void)
{
    CP_WaitDiv();
    return CP_GetDivResultImm32();
}

static inline s32 CP_GetDivRemainder32(void)
{
    CP_WaitDiv();
    return CP_GetDivRemainderImm32();
}

static inline void CP_SetSqrt64(u64 param)
{
    reg_CP_SQRTCNT = CP_SQRT_64BIT_MODE;
    CP_SetSqrtImm64_NS_(param);
}

static inline u32 CP_GetSqrtResult32(void)
{
    CP_WaitSqrt();
    return CP_GetSqrtResultImm32();
}

static inline void FX_InvAsyncImm(fx32 denom)
{
    CP_SetDivImm64_32((u64)FX32_ONE << 32, (u32)denom);
}

static inline fx64c FX_GetInvResultFx64c(void)
{
    return FX_GetDivResultFx64c();
}

static inline fx32 FX_GetInvResult(void)
{
    return FX_GetDivResult();
}

static inline void FX_DivAsyncImm(fx32 numer, fx32 denom)
{
    CP_SetDivImm64_32((u64)numer << 32, (u32)denom);
}

static inline fx32 FX_Mod(fx32 numer, fx32 denom)
{
    return (fx32)FX_ModS32(numer, denom);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_FX_FX_CP_H