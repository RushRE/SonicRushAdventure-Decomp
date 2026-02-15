#ifndef RUSH_BOSSHELPERS_H
#define RUSH_BOSSHELPERS_H

#include <global.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/swapBuffer3D.h>
#include <game/graphics/sprite.h>
#include <game/object/objAction.h>
#include <stage/stageTask.h>
#include <stage/player/player.h>

// --------------------
// STRUCTS
// --------------------

typedef struct BossLight_
{
    DirLight modifiedLights[3];
    DirLight initialLights[3];
    s16 brightness;
} BossLight;

typedef struct Unknown2038AEC_
{
    void *startPtr;
    void *curPtr;
    void *prevPtr;
    s32 id;
    u16 timer;
} Unknown2038AEC;

// --------------------
// FUNCTIONS
// --------------------

void BossHelpers__Unknown2038AEC__Init(Unknown2038AEC *work, void *ptr, s32 id);
void BossHelpers__Unknown2038AEC__Func_2038B24(Unknown2038AEC *work);
u32 BossHelpers__Unknown2038AEC__Func_2038B28(Unknown2038AEC *work);
void *BossHelpers__Unknown2038AEC__Func_2038B7C(Unknown2038AEC *work);

void BossHelpers__SetPaletteAnimation(PaletteAnimator *animator, u16 anim, BOOL canLoop);
void BossHelpers__SetPaletteAnimations(PaletteAnimator *animators, u32 animatorCount, u16 anim, BOOL canLoop);

void BossHelpers__SetAnimation(AnimatorMDL *work, B3DAnimationTypes type, NNSG3dResFileHeader *resource, u32 animID, const NNSG3dResTex *texResource, BOOL canLoop);
BOOL BossHelpers__IsAnimFinished(AnimatorMDL *work, B3DAnimationTypes type);
void BossHelpers__ReleaseAnimation(OBS_ACTION3D_NN_WORK *work);

s32 BossHelpers__Arena__WrapBounds(fx32 x, fx32 start, fx32 end);
u16 BossStage_GetCirclePos(fx32 position, fx32 start, fx32 end, fx32 radius, s32 *x, s32 *z);
void BossHelpers__Arena__GetXZPos(u16 angle, fx32 radius, fx32 *x, fx32 *z);
void BossHelpers__Arena__GetPosition(fx32 *position, fx32 start, fx32 end, fx32 radius, fx32 x, fx32 z);
u16 BossHelpers__Arena__GetAngle(fx32 position, fx32 start, fx32 end);
u16 BossHelpers__Arena__ATan2(fx32 y, fx32 x);
u16 BossHelpers__Arena__GetObjectDrawMtx(StageTask *work, AnimatorMDL *animator, fx32 start, fx32 end, fx32 radius);
u16 BossHelpers__Arena__GetPlayerDrawMtx(Player *player, fx32 start, fx32 end, fx32 radius);

void BossHelpers__Model__InitSystem(void);
void BossHelpers__Model__Init(void *resMdl, const char *jointName, u16 matrixID, void (*renderCallback)(NNSG3dRS *context, void *userData), void *context);
void BossHelpers__Model__SetMatrixMode(s32 id, FXMatrix43 *mtx);
void BossHelpers__Model__RenderCallback(NNSG3dRS *rs);

void BossHelpers__Collision__HandleColliderSimple(OBS_RECT_WORK *collider, fx32 x, fx32 y, fx32 z);
void BossHelpers__Collision__InitArenaCollider(OBS_RECT_WORK *srcCollider, OBS_RECT_WORK *dstCollider, fx32 x, fx32 y, fx32 start, fx32 end, fx32 radius);
void BossHelpers__Collision__HandleArenaCollider(OBS_RECT_WORK *srcCollider, OBS_RECT_WORK *dstCollider, VecFx32 *translation, fx32 start, fx32 end, fx32 radius);

BOOL BossHelpers__Player__IsAlive(Player *player);
void BossHelpers__Player__LockControl(Player *player);
void BossHelpers__Player__UnlockControl(Player *player);

u16 BossHelpers__Math__Func_2039264(u16 currentAngle, u16 targetAngle, u16 step);
s32 BossHelpers__Math__Func_20392BC(s32 position, s32 center, s32 angle, s32 angleStepSmall, s32 angleStepLarge, s32 angleRange, s32 largeStepThreshold);
s16 BossHelpers__Math__Func_2039360(s32 curPos, s32 targetPos, s16 angle, s16 angleStepSmall, s16 angleStepLarge, u16 angleRange, u16 largeStepThreshold);

void BossHelpers__InitBoss5Blending(GraphicsEngine useEngineB);

void BossHelpers__InitLights(BossLight *config);
void BossHelpers__ProcessLights(BossLight *config);
void BossHelpers__ApplyModifiedLights(BossLight *config);
void BossHelpers__RevertModifiedLights(BossLight *config);

u32 BossHelpers__FindJointByName(NNSG3dResMdl *resMdl, const char *jointName);

#endif // ! RUSH_BOSSHELPERS_H