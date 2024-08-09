#ifndef RUSH2_BOSSHELPERS_H
#define RUSH2_BOSSHELPERS_H

#include <global.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct BossLight_
{
    DirLight lights[3];
    DirLight lights2[3];
    s16 brightness;
} BossLight;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void BossHelpers__Unknown2038AEC__Init(void);
NOT_DECOMPILED void BossHelpers__Unknown2038AEC__Func_2038B24(void);
NOT_DECOMPILED void BossHelpers__Unknown2038AEC__Func_2038B28(void);
NOT_DECOMPILED void BossHelpers__Unknown2038AEC__Func_2038B7C(void);

NOT_DECOMPILED void BossHelpers__Palette__Func_2038B84(PaletteAnimator *animator, u16 anim, BOOL canLoop);
NOT_DECOMPILED void BossHelpers__Palette__Func_2038BAC(PaletteAnimator *animators, u32 animatorCount, u16 anim, BOOL canLoop);

NOT_DECOMPILED void BossHelpers__Animation__Func_2038BF0(OBS_ACTION3D_NN_WORK *work, B3DAnimationTypes type, NNSG3dResFileHeader *resource, u16 animID, const NNSG3dResTex *texResource, BOOL canLoop);
NOT_DECOMPILED BOOL BossHelpers__Animation__Func_2038C44(OBS_ACTION3D_NN_WORK *work, B3DAnimationTypes type);
NOT_DECOMPILED void BossHelpers__Animation__Func_2038C58(OBS_ACTION3D_NN_WORK *work);

NOT_DECOMPILED s32 BossHelpers__Arena__WrapBounds(int x, int start, int end);
NOT_DECOMPILED void BossHelpers__Arena__Func_2038CDC(int center, int start, int end, int radius, s32 *x, s32 *z);
NOT_DECOMPILED void BossHelpers__Arena__Func_2038D24(void);
NOT_DECOMPILED void BossHelpers__Arena__Func_2038D88(void);
NOT_DECOMPILED void BossHelpers__Arena__Func_2038DCC(void);
NOT_DECOMPILED void BossHelpers__Arena__ATan2(void);
NOT_DECOMPILED void BossHelpers__Arena__Func_2038E00(void);
NOT_DECOMPILED void BossHelpers__Arena__Func_2038EBC(void);

NOT_DECOMPILED void BossHelpers__Model__InitSystem(void);
NOT_DECOMPILED void BossHelpers__Model__Init(void *resMdl, const char *jointName, u16 matrixID, void (*renderCallback)(s32 a1, void *context), void *context);
NOT_DECOMPILED void BossHelpers__Model__SetMatrixMode(s32 id, MtxFx43* mtx);
NOT_DECOMPILED void BossHelpers__Model__RenderCallback(NNSG3dRS *rs);

NOT_DECOMPILED void BossHelpers__Collision__Func_20390AC(OBS_RECT_WORK *rect, fx32 x, fx32 y, fx32 z);
NOT_DECOMPILED void BossHelpers__Collision__Func_2039120(void);
NOT_DECOMPILED void BossHelpers__Collision__Func_203919C(void);

NOT_DECOMPILED BOOL BossHelpers__Player__IsDead(Player *player);
NOT_DECOMPILED void BossHelpers__Player__LockControl(Player *player);
NOT_DECOMPILED void BossHelpers__Player__UnlockControl(Player *player);

NOT_DECOMPILED void BossHelpers__Math__Func_2039264(void);
NOT_DECOMPILED void BossHelpers__Math__Func_20392BC(void);
NOT_DECOMPILED void BossHelpers__Math__Func_2039360(void);

NOT_DECOMPILED void BossHelpers__Blend__Func_2039488(void);

NOT_DECOMPILED void BossHelpers__Light__Init(BossLight *config);
NOT_DECOMPILED void BossHelpers__Light__Func_203954C(BossLight *config);
NOT_DECOMPILED void BossHelpers__Light__SetLights1(BossLight *config);
NOT_DECOMPILED void BossHelpers__Light__SetLights2(BossLight *config);

NOT_DECOMPILED void BossHelpers__Model__FindJointByName(void);

#endif // ! RUSH2_BOSSHELPERS_H