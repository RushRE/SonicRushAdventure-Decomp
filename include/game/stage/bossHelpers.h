#ifndef RUSH_BOSSHELPERS_H
#define RUSH_BOSSHELPERS_H

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

NOT_DECOMPILED void BossHelpers__SetPaletteAnimation(PaletteAnimator *animator, u16 anim, BOOL canLoop);
NOT_DECOMPILED void BossHelpers__SetPaletteAnimations(PaletteAnimator *animators, u32 animatorCount, u16 anim, BOOL canLoop);

NOT_DECOMPILED void BossHelpers__SetAnimation(OBS_ACTION3D_NN_WORK *work, B3DAnimationTypes type, NNSG3dResFileHeader *resource, u16 animID, const NNSG3dResTex *texResource, BOOL canLoop);
NOT_DECOMPILED BOOL BossHelpers__IsAnimFinished(OBS_ACTION3D_NN_WORK *work, B3DAnimationTypes type);
NOT_DECOMPILED void BossHelpers__ReleaseAnimation(OBS_ACTION3D_NN_WORK *work);

NOT_DECOMPILED s32 BossHelpers__Arena__WrapBounds(fx32 x, fx32 start, fx32 end);
NOT_DECOMPILED void BossHelpers__Arena__GetDrawPosition(fx32 position, fx32 start, fx32 end, fx32 radius, s32 *x, s32 *z);
NOT_DECOMPILED void BossHelpers__Arena__GetXZPos(u16 angle, fx32 radius, fx32 *x, fx32 *z);
NOT_DECOMPILED void BossHelpers__Arena__GetPosition(fx32 *position, fx32 start, fx32 end, fx32 radius, fx32 x, fx32 z);
NOT_DECOMPILED u16 BossHelpers__Arena__GetAngle(fx32 position, fx32 start, fx32 end);
NOT_DECOMPILED u16 BossHelpers__Arena__ATan2(fx32 y, fx32 x);
NOT_DECOMPILED void BossHelpers__Arena__GetObjectDrawMtx(StageTask *work, AnimatorMDL *animator, fx32 start, fx32 end, fx32 radius);
NOT_DECOMPILED void BossHelpers__Arena__GetPlayerDrawMtx(Player *player, fx32 start, fx32 end, fx32 radius);

NOT_DECOMPILED void BossHelpers__Model__InitSystem(void);
NOT_DECOMPILED void BossHelpers__Model__Init(void *resMdl, const char *jointName, u16 matrixID, void (*renderCallback)(s32 a1, void *context), void *context);
NOT_DECOMPILED void BossHelpers__Model__SetMatrixMode(s32 id, MtxFx43* mtx);
NOT_DECOMPILED void BossHelpers__Model__RenderCallback(NNSG3dRS *rs);

NOT_DECOMPILED void BossHelpers__Collision__HandleColliderSimple(OBS_RECT_WORK *rect, fx32 x, fx32 y, fx32 z);
NOT_DECOMPILED void BossHelpers__Collision__InitArenaCollider(OBS_RECT_WORK *srcCollider, OBS_RECT_WORK *dstCollider, fx32 x, fx32 y, fx32 start, fx32 end);
NOT_DECOMPILED void BossHelpers__Collision__HandleArenaCollider(OBS_RECT_WORK *srcCollider, OBS_RECT_WORK *dstCollider, VecFx32 *translation, fx32 start, fx32 end, fx32 radius);

NOT_DECOMPILED BOOL BossHelpers__Player__IsAlive(Player *player);
NOT_DECOMPILED void BossHelpers__Player__LockControl(Player *player);
NOT_DECOMPILED void BossHelpers__Player__UnlockControl(Player *player);

NOT_DECOMPILED void BossHelpers__Math__Func_2039264(void);
NOT_DECOMPILED void BossHelpers__Math__Func_20392BC(void);
NOT_DECOMPILED void BossHelpers__Math__Func_2039360(void);

NOT_DECOMPILED void BossHelpers__InitBoss5Blending(BOOL useEngineB);

NOT_DECOMPILED void BossHelpers__InitLights(BossLight *config);
NOT_DECOMPILED void BossHelpers__ProcessLights(BossLight *config);
NOT_DECOMPILED void BossHelpers__ApplyModifiedLights(BossLight *config);
NOT_DECOMPILED void BossHelpers__RevertModifiedLights(BossLight *config);

NOT_DECOMPILED u32 BossHelpers__FindJointByName(NNSG3dResMdl *resMdl, char *jointName);

#endif // ! RUSH_BOSSHELPERS_H