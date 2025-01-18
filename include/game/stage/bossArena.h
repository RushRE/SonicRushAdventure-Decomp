#ifndef RUSH_BOSSARENA_H
#define RUSH_BOSSARENA_H

#include <global.h>
#include <game/graphics/sprite.h>
#include <game/graphics/mappingsQueue.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct BossArenaPositionTracker_
{
    VecFx32 targetTrackPos;
    VecFx32 targetPos;
    s16 speed;
    s32 moveSpeed;
    s32 moveVelocity;
    BOOL useObj3D;
    StageTask *workX;
    StageTask *workY;
    StageTask *workZ;
    VecFx32 targetOffset;
} BossArenaPositionTracker;

typedef struct BossArenaAmplitudeTracker_
{
    fx32 target;
    fx32 value;
    s16 speed;
    fx32 offset;
    fx32 offsetVelocity;
} BossArenaAmplitudeTracker;

typedef struct BossArenaAngleTracker_
{
    s16 target;
    s16 value;
    s16 speed;
} BossArenaAngleTracker;

typedef struct BossArenaCamera_
{
    s32 type;
    Camera3D camera;
    VecFx32 lookAtUp;
    VecFx32 nextPosition;
    BossArenaPositionTracker tracker1;
    BossArenaPositionTracker tracker2;
    BossArenaAmplitudeTracker amplitudeXZTracker;
    BossArenaAmplitudeTracker amplitudeYTracker;
    BossArenaAngleTracker angleTracker;
} BossArenaCamera;

typedef struct BossArenaBackground_
{
    s32 type;
    AnimatorMDL animator;
    s32 field_148;
    void *background;
    s32 field_150;
    s32 field_154;
    s32 field_158;
    u8 backgroundID;
    u8 field_15D;
    s16 field_15E;
    s32 field_160;
    s32 field_164;
    s32 field_168;
    s32 field_16C;
    MappingsMode mappingsMode;
    u16 screenBaseA;
    u16 screenBaseBlock;
    u16 field_178;
    u16 field_17A;
    u16 field_17C;
    u16 field_17E;
    s32 field_180;
    s32 field_184;
    s32 field_188;
    s32 field_18C;
    u16 *mappingsPtr;
    s16 field_194;
    s16 field_196;
    u16 field_198;
    u16 field_19A;
} BossArenaBackground;

typedef struct BossArena_
{
    s32 type;
    BossArenaCamera camera[3];
    s32 field_358;
    s16 field_35C;
    s16 field_35E;
    BossArenaBackground background;
} BossArena;

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED u32 BossArena__explosionFXSpawnTime[3];

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void BossArena__Create(s32 type, u32 priority);
NOT_DECOMPILED void BossArena__Destroy(void);
NOT_DECOMPILED void BossArena__Func_20397E4(void);
NOT_DECOMPILED void BossArena__SetType(s32 type);
NOT_DECOMPILED s32 BossArena__GetType(void);

NOT_DECOMPILED BossArenaCamera *BossArena__GetCamera(s32 id);
NOT_DECOMPILED void BossArena__SetField358(s32 value);
NOT_DECOMPILED void BossArena__SetField35C(s32 value);
NOT_DECOMPILED void BossArena__SetCameraType(BossArenaCamera *camera, s32 type);
NOT_DECOMPILED Camera3D *BossArena__GetCameraConfig2(BossArenaCamera *camera);
NOT_DECOMPILED Camera3D *BossArena__GetCameraConfig(BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__SetCameraConfig(BossArenaCamera *camera, CameraConfig *config);
NOT_DECOMPILED void BossArena__SetUpVector(BossArenaCamera *camera, VecFx32 *up);
NOT_DECOMPILED void BossArena__SetNextPos(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z);

NOT_DECOMPILED void BossArena__SetTracker1TargetPos(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z);
NOT_DECOMPILED void BossArena__GetTracker1TargetPos(BossArenaCamera *camera, fx32 *x, fx32 *y, fx32 *z);
NOT_DECOMPILED void BossArena__SetTracker1TargetOffset(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z);
NOT_DECOMPILED void BossArena__UpdateTracker1TargetPos(BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__SetTracker1TargetWork(BossArenaCamera *camera, StageTask *x, StageTask *y, StageTask *z);
NOT_DECOMPILED void BossArena__SetTracker1UseObj3D(BossArenaCamera *camera, BOOL value);
NOT_DECOMPILED void BossArena__SetTracker1Speed(BossArenaCamera *camera, s16 speed, fx32 velocity);

NOT_DECOMPILED void BossArena__SetTracker0TargetPos(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z);
NOT_DECOMPILED void BossArena__GetTracker0TargetPos(BossArenaCamera *camera, fx32 *x, fx32 *y, fx32 *z);
NOT_DECOMPILED void BossArena__UpdateTracker0TargetPos(BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__SetTracker0TargetWork(BossArenaCamera *camera, StageTask *x, StageTask *y, StageTask *z);
NOT_DECOMPILED void BossArena__SetTracker0Speed(BossArenaCamera *camera, s16 speed, fx32 velocity);

NOT_DECOMPILED void BossArena__SetAmplitudeXZTarget(BossArenaCamera *camera, s32 target);
NOT_DECOMPILED void BossArena__ApplyAmplitudeXZTarget(BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__SetAmplitudeXZSpeed(BossArenaCamera *camera, s16 soeed);
NOT_DECOMPILED void BossArena__SetAmplitudeYTarget(BossArenaCamera *camera, s32 target);
NOT_DECOMPILED void BossArena__ApplyAmplitudeYTarget(BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__SetAmplitudeYSpeed(BossArenaCamera *camera, s16 soeed);
NOT_DECOMPILED void BossArena__SetAngleTarget(BossArenaCamera *camera, u16 target);
NOT_DECOMPILED u16 BossArena__GetAngleTarget(BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__ApplyAngleTarget(BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__SetAngleSpeed(BossArenaCamera *camera, s16 soeed);

NOT_DECOMPILED void BossArena__SetUnknown2Type(s32 type);
NOT_DECOMPILED AnimatorMDL *BossArena__GetUnknown2Animator(void);
NOT_DECOMPILED void *BossArena__GetField4A8(void);
NOT_DECOMPILED void BossArena__Func_2039A94(s16 a1, s16 a2);
NOT_DECOMPILED void BossArena__Func_2039AB4(s16 a1, s16 a2);
NOT_DECOMPILED void BossArena__Func_2039AD4(VecFx32 *a1, VecFx32 *a2, VecFx32 *a3, s32 a4, u16 a5, VecFx32 *a6, VecFx32 *a7, s32 *a8, VecFx32 *a9, VecFx32 *a10, s32 *a11);
NOT_DECOMPILED void BossArena__Func_2039CA4(s16 *xz, s16 *y, VecFx32 *a3, VecFx32 *a4, u16 a5, u16 a6, s16 a7, s16 a8);
NOT_DECOMPILED BossArena *BossArena__GetWork(void);
NOT_DECOMPILED void BossArena__InitUnknown(BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__Func_2039E38(BossArenaPositionTracker *tracker);
NOT_DECOMPILED void BossArena__Func_2039FA8(BossArenaPositionTracker *tracker);
NOT_DECOMPILED void BossArena__Func_203A000(void *a1);
NOT_DECOMPILED void BossArena__Func_203A024(VecFx32 *dest, VecFx32 *src, s32 amplitudeXZ, s32 amplitudeY, u16 angle);
NOT_DECOMPILED s32 BossArena__Func_203A0A0(BossArenaBackground *background);
NOT_DECOMPILED s32 BossArena__Func_203A0AC(BossArenaBackground *background);

NOT_DECOMPILED void BossArena__Main(void);
NOT_DECOMPILED void BossArena__Destructor(Task *task);

NOT_DECOMPILED void BossArena__CallFunction2(BossArena *work);
NOT_DECOMPILED void BossArena__FuncTable2_203A148(BossArena *work);
NOT_DECOMPILED void BossArena__FuncTable2_203A1C8(BossArena *work);
NOT_DECOMPILED void BossArena__FuncTable2_203A1F0(BossArena *work);
NOT_DECOMPILED void BossArena__FuncTable2_203A230(BossArena *work);
NOT_DECOMPILED void BossArena__FuncTable2_203A37C(BossArena *work);

NOT_DECOMPILED void BossArena__DrawBackground(BossArenaBackground *background, BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__DrawBackground3D(BossArenaBackground *background, BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__DrawBackground2D(BossArenaBackground *background, BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__AllocMappings(BossArenaBackground *background);
NOT_DECOMPILED void BossArena__FreeMappings(BossArenaBackground *background);
NOT_DECOMPILED void BossArena__TrackTarget1(BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__TrackTarget2(BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__CallFunction1(BossArena *work, BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__FuncTable1_203A860(BossArena *work, BossArenaCamera *camera);
NOT_DECOMPILED void BossArena__FuncTable1_203A8AC(BossArena *work, BossArenaCamera *camera);

#endif // ! RUSH_BOSSARENA_H