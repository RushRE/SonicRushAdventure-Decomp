#ifndef RUSH2_AKMATH_H
#define RUSH2_AKMATH_H

#include <global.h>

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED BOOL AkMath__Func_2002C40(NNSG3dRS *rs, s32 num, const NNSG3dResName *name);
NOT_DECOMPILED void AkMath__Func_2002C98(s32 radiusX, s32 radiusY, fx32 *x, fx32 *y, u16 angle);
NOT_DECOMPILED s32 AkMath__Func_2002D28(s32 angle, s32 targetAngle, s32 percent);
NOT_DECOMPILED void AkMath__BlendColors(u16 *colorPtr, u16 inputColor1, u16 inputColor2, s32 id, s32 count);

#endif // RUSH2_AKMATH_H
