#ifndef RUSH_UNKNOWN2066510_H
#define RUSH_UNKNOWN2066510_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct Unknown2066510_
{
    VecFx32 a;
    VecFx32 b;
} Unknown2066510;

typedef struct Unknown206703C_
{
    VecFx32 pos;
    fx32 w;
} Unknown206703C;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED u16 Unknown2066510__LerpAngle(u16 start, u16 end, fx32 percent);
NOT_DECOMPILED void Unknown2066510__LerpAngle2(u16 start, u16 mid, u16 end);
NOT_DECOMPILED void Unknown2066510__LerpMtx43(FXMatrix43 *start, FXMatrix43 *end, fx32 percent, FXMatrix43 *dest);
NOT_DECOMPILED void Unknown2066510__NormalizeScale(FXMatrix33 *a1, FXMatrix33 *a2);
NOT_DECOMPILED void Unknown2066510__Func_2066724(FXMatrix43 *a1, VecFx32 *a2, FXMatrix43 *a3, VecFx32 *a4);
NOT_DECOMPILED void Unknown2066510__Func_20668A8(VecFx32 *lhs, u16 angle, VecFx32 *rhs, VecFx32 *dest);
NOT_DECOMPILED void Unknown2066510__LookAt(VecFx32 *from, VecFx32 *to, VecFx32 *up, FXMatrix43 *mtx);
NOT_DECOMPILED void Unknown2066510__Func_2066AC0(VecFx32 *a1, VecFx32 *a2, u16 a3, VecFx32 *a4);
NOT_DECOMPILED void Unknown2066510__Func_2066B94(VecFx32 *a, s32 angle, VecFx32 *b, VecFx32 *a4);
NOT_DECOMPILED void Unknown2066510__Func_2066C24(VecFx32 *a1, VecFx32 *a2, s32 color);
NOT_DECOMPILED void Unknown2066510__Func_2066D18(VecFx32 *lhs, u32 count, VecFx16 *rhs, FXMatrix43 *mtx);
NOT_DECOMPILED void Unknown2066510__Func_2066F88(const VecFx32 *a1, VecFx32 *a2, Unknown2066510 *dest);
NOT_DECOMPILED void Unknown2066510__Func_2066FD0(Unknown206703C *work, VecFx32 *a2, VecFx32 *a3, VecFx32 *a4);
NOT_DECOMPILED void Unknown2066510__Func_206703C(Unknown206703C *dest, VecFx32 *lhs, VecFx32 *rhs);
NOT_DECOMPILED s32 Unknown2066510__Func_20670B4(Unknown206703C *work, VecFx32 *a2);
NOT_DECOMPILED s16 Unknown2066510__Func_20670CC(VecFx32 *a1, VecFx32 *a2);
NOT_DECOMPILED void Unknown2066510__Func_20670F8(Unknown206703C *a3, Unknown2066510 *a2, VecFx32 *dest);

#ifdef __cplusplus
}
#endif

#endif // RUSH_UNKNOWN2066510_H
