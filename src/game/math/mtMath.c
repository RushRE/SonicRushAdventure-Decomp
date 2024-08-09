#include <game/math/mtMath.h>

// --------------------
// VARIABLES
// --------------------

u32 _mt_math_rand = 0;

// --------------------
// FUNCTIONS
// --------------------

void InitMtMath(void)
{
    RTCTime t;

    _mt_math_rand = 0;
    if (RTC_GetTime(&t) == RTC_RESULT_SUCCESS)
        _mt_math_rand = t.second | (t.minute << 6) | (t.hour << 12) | ((t.second | (t.minute << 6) | (t.hour << 12)) << 16);
}

s32 Math__Func_207B14C(s32 angle)
{
    if (angle == 0x1000)
        return FLOAT_DEG_TO_IDX(90.0);

    if (angle == -0x1000)
        return FLOAT_DEG_TO_IDX(270.0);

    fx32 sqrt = FX_Sqrt(0x1000 - MultiplyFX(angle, angle));
    fx32 div  = FX_Div(angle, sqrt);
    return FX_AtanIdx(div);
}

u16 Math__Func_207B1A4(s32 angle)
{
    if (angle == 0x1000)
        return 0;

    if (angle == -0x1000)
        return FLOAT_DEG_TO_IDX(180.0);

    fx32 sqrt = FX_Sqrt(0x1000 - MultiplyFX(angle, angle));
    fx32 div  = FX_Div(angle, sqrt);
    return (u16)(FLOAT_DEG_TO_IDX(90.0) + -FX_AtanIdx(div));
}