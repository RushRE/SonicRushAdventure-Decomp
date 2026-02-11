#ifndef RUSH_AKMATH_H
#define RUSH_AKMATH_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

BOOL AkMath__Func_2002C40(NNSG3dRS *rs, s32 num, const NNSG3dResName *name);
void AkMath__Func_2002C98(s32 radiusX, s32 radiusY, fx32 *x, fx32 *y, u16 angle);
u16 AkMath__Func_2002D28(u16 angle, u16 targetAngle, s16 percent);
void AkMath__BlendColors(GXRgb *colorPtr, GXRgb inputColor0, GXRgb inputColor1, s32 count, s32 id);

#ifdef __cplusplus
}
#endif

#endif // RUSH_AKMATH_H
