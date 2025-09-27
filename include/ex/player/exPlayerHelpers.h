#ifndef RUSH_EXPLAYERHELPERS_H
#define RUSH_EXPLAYERHELPERS_H

#include <ex/system/exTask.h>
#include <ex/player/exPlayer.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct ExPlayerUnknown2152960_
{
    VecFx32 *positionList;
    s16 index;
    s16 field_6;
    VecFx32 field_8;
    s16 word14;
    s16 word16;
    VecFx32 field_18;
    VecFx32 dword24;
} ExPlayerUnknown2152960;

typedef struct ExPlayerUnknown2152FB0_
{
    VecFx32 progress;
    VecFx32 step;
    fx32 stepSize;
    fx32 duration;
} ExPlayerUnknown2152FB0;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED BOOL exPlayerHelpers__Func_2152960(ExPlayerUnknown2152960 *work, VecFx32 *positionList, s32 index, s16 a4);
NOT_DECOMPILED s32 exPlayerHelpers__Func_21529C4(s32 a1);
NOT_DECOMPILED BOOL exPlayerHelpers__Func_2152AB4(ExPlayerUnknown2152960 *work);
NOT_DECOMPILED void exPlayerHelpers__SetAnimationInternal(EX_ACTION_NN_WORK *work, void *resModel, void *resTexture, NNSG3dResFileHeader *resJointAnim, u16 animID);
NOT_DECOMPILED void exPlayerHelpers__Func_2152CB4(void);
NOT_DECOMPILED void exPlayerHelpers__Func_2152D28(VecU16 *angle, VecU16 *direction, VecU16 *velocity, s32 type);
NOT_DECOMPILED u16 exPlayerHelpers__Func_2152E28(fx32 y, fx32 x);
NOT_DECOMPILED u16 ovl09_2152EA8(fx32 y, fx32 x, VecU16 *rotation, u16 *angle, u16 a4);
NOT_DECOMPILED void exPlayerHelpers__Func_2152FB0(ExPlayerUnknown2152FB0 *work, VecFx32 *start, VecFx32 *target, float stepSize, float duration);
NOT_DECOMPILED BOOL exPlayerHelpers__Func_21530FC(ExPlayerUnknown2152FB0 *work, VecFx32 *position, BOOL useCurrentPositionZ);

#endif // RUSH_EXPLAYERHELPERS_H
