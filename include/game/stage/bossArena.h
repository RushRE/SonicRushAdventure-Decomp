#ifndef RUSH_BOSSARENA_H
#define RUSH_BOSSARENA_H

#include <global.h>
#include <game/graphics/sprite.h>
#include <game/graphics/mappingsQueue.h>
#include <game/graphics/swapBuffer3D.h>
#include <stage/stageTask.h>

// --------------------
// CONSTANTS
// --------------------

#define BOSSARENA_BACKGROUND_TILE_WIDTH  33
#define BOSSARENA_BACKGROUND_TILE_HEIGHT 25

// --------------------
// ENUMS
// --------------------

enum BossArenaType_
{
    BOSSARENA_TYPE_0,
    BOSSARENA_TYPE_1,
    BOSSARENA_TYPE_2,
    BOSSARENA_TYPE_3,
    BOSSARENA_TYPE_4,

    BOSSARENA_TYPE_COUNT,
};
typedef u32 BossArenaType;

enum BossArenaCameraType_
{
    BOSSARENACAMERA_TYPE_0,
    BOSSARENACAMERA_TYPE_1,

    BOSSARENACAMERA_TYPE_COUNT,
};
typedef u32 BossArenaCameraType;

enum BossArenaBackgroundType_
{
    BOSSARENABACKGROUND_TYPE_NONE,
    BOSSARENABACKGROUND_TYPE_2D,
    BOSSARENABACKGROUND_TYPE_3D,
};
typedef u32 BossArenaBackgroundType;

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
    u16 target;
    u16 value;
    s16 speed;
} BossArenaAngleTracker;

typedef struct BossArenaCamera_
{
    s32 type;
    Camera3D camera;
    VecFx32 upDir;
    VecFx32 nextPosition;
    BossArenaPositionTracker positionTracker[2];
    BossArenaAmplitudeTracker amplitudeXZTracker;
    BossArenaAmplitudeTracker amplitudeYTracker;
    BossArenaAngleTracker angleTracker;
} BossArenaCamera;

typedef struct BossArenaUnknown4A8_
{
    s32 field_0;
    void *background;
    s32 field_8;
    s32 field_C;
    s32 field_10;
    u8 backgroundID;
    s32 field_18;
    s32 field_1C;
    s32 field_20;
    s32 field_24;
    MappingsMode mappingsMode;
    u16 screenBaseA;
    u16 screenBaseBlock;
    u16 offsetX;
    u16 offsetY;
    u16 displayWidth;
    u16 displayHeight;
} BossArenaUnknown4A8;

typedef struct BossArena2DBGTiles_
{
    GXScrFmtText scr[BOSSARENA_BACKGROUND_TILE_HEIGHT][BOSSARENA_BACKGROUND_TILE_WIDTH];
} BossArena2DBGTiles;

typedef struct BossArenaBackground_
{
    s32 type;
    AnimatorMDL animator;
    BossArenaUnknown4A8 field_148;
    s32 field_180;
    s32 field_184;
    s32 field_188;
    s32 field_18C;
    BossArena2DBGTiles *mappingsPtr;
    u16 left;
    u16 right;
    u16 top;
    u16 bottom;
} BossArenaBackground;

typedef struct BossArena_
{
    BossArenaType type;
    BossArenaCamera camera[3];
    s32 field_358;
    s16 field_35C;
    s16 field_35E;
    BossArenaBackground background;
} BossArena;

// --------------------
// VARIABLES
// --------------------

extern const u32 BossArena__explosionFXSpawnTime[3];

// --------------------
// FUNCTIONS
// --------------------

void BossArena__Create(BossArenaType type, u32 priority);
void BossArena__Destroy(void);
void BossArena__DoProcess(void);
void BossArena__SetType(BossArenaType type);
BossArenaType BossArena__GetType(void);

BossArenaCamera *BossArena__GetCamera(s32 id);
void BossArena__SetField358(s32 value);
void BossArena__SetField35C(s32 value);
void BossArena__SetCameraType(BossArenaCamera *camera, BossArenaCameraType type);
Camera3D *BossArena__GetCameraConfig2(BossArenaCamera *camera);
Camera3D *BossArena__GetCameraConfig(BossArenaCamera *camera);
void BossArena__SetCameraConfig(BossArenaCamera *camera, ProjectionDisplayConfig *config);
void BossArena__SetUpVector(BossArenaCamera *camera, VecFx32 *up);
void BossArena__SetNextPos(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z);

void BossArena__SetTracker1TargetPos(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z);
void BossArena__GetTracker1TargetPos(BossArenaCamera *camera, fx32 *x, fx32 *y, fx32 *z);
void BossArena__SetTracker1TargetOffset(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z);
void BossArena__UpdateTracker1TargetPos(BossArenaCamera *camera);
void BossArena__SetTracker1TargetWork(BossArenaCamera *camera, StageTask *x, StageTask *y, StageTask *z);
void BossArena__SetTracker1UseObj3D(BossArenaCamera *camera, BOOL enabled);
void BossArena__SetTracker1Speed(BossArenaCamera *camera, s16 speed, fx32 velocity);

void BossArena__SetTracker0TargetPos(BossArenaCamera *camera, fx32 x, fx32 y, fx32 z);
void BossArena__GetTracker0TargetPos(BossArenaCamera *camera, fx32 *x, fx32 *y, fx32 *z);
void BossArena__UpdateTracker0TargetPos(BossArenaCamera *camera);
void BossArena__SetTracker0TargetWork(BossArenaCamera *camera, StageTask *x, StageTask *y, StageTask *z);
void BossArena__SetTracker0Speed(BossArenaCamera *camera, s16 speed, fx32 velocity);

void BossArena__SetAmplitudeXZTarget(BossArenaCamera *camera, s32 target);
void BossArena__ApplyAmplitudeXZTarget(BossArenaCamera *camera);
void BossArena__SetAmplitudeXZSpeed(BossArenaCamera *camera, s16 speed);
void BossArena__SetAmplitudeYTarget(BossArenaCamera *camera, s32 target);
void BossArena__ApplyAmplitudeYTarget(BossArenaCamera *camera);
void BossArena__SetAmplitudeYSpeed(BossArenaCamera *camera, s16 speed);
void BossArena__SetAngleTarget(BossArenaCamera *camera, u16 target);
u16 BossArena__GetAngleTarget(BossArenaCamera *camera);
void BossArena__ApplyAngleTarget(BossArenaCamera *camera);
void BossArena__SetAngleSpeed(BossArenaCamera *camera, s16 speed);

void BossArena__SetBackgroundType(BossArenaBackgroundType type);
AnimatorMDL *BossArena__GetBackgroundAnimator(void);
BossArenaUnknown4A8 *BossArena__GetField4A8(void);
void BossArena__SetBoundsX(s16 left, s16 right);
void BossArena__SetBoundsY(s16 top, s16 bottom);
void BossArena__Func_2039AD4(VecFx32 *camPos, VecFx32 *camTarget, VecFx32 *camUp, fx32 targetDist, u16 aspectRatio, VecFx32 *cam1Target0, VecFx32 *cam1Target1, VecFx32 *outCam1Up, VecFx32 *cam2Target0, VecFx32 *cam2Target1, VecFx32 *outCam2Up);
void BossArena__Func_2039CA4(s16 *xz, s16 *y, VecFx32 *a3, VecFx32 *a4, u16 a5, u16 a6, s16 a7, s16 a8);
BossArena *BossArena__GetWork(void);
void BossArena__InitCamera(BossArenaCamera *camera);
void BossArena__ProcessPositionTracker(BossArenaPositionTracker *tracker);
void BossArena__ProcessAmplitudeTracker(BossArenaAmplitudeTracker *tracker);
void BossArena__ProcessAngleTracker(BossArenaAngleTracker *tracker);
void BossArena__SetTrackPos(VecFx32 *trackPos, VecFx32 *targetPos, s32 amplitudeXZ, s32 amplitudeY, u16 angle);
u16 BossArena__GetBackgroundTop(BossArenaBackground *background);
u16 BossArena__GetBackgroundBottom(BossArenaBackground *background);

void BossArena__Main(void);
void BossArena__Destructor(Task *task);

void BossArena__Process(BossArena *work);
void BossArena__MainFunc_Type0(BossArena *work);
void BossArena__MainFunc_Type1(BossArena *work);
void BossArena__MainFunc_Type2(BossArena *work);
void BossArena__MainFunc_Type3(BossArena *work);
void BossArena__MainFunc_Type4(BossArena *work);

void BossArena__DrawBackground(BossArenaBackground *background, BossArenaCamera *camera);
void BossArena__DrawBackground3D(BossArenaBackground *background, BossArenaCamera *camera);
void BossArena__DrawBackground2D(BossArenaBackground *background, BossArenaCamera *camera);
void BossArena__AllocMappings(BossArenaBackground *background);
void BossArena__FreeMappings(BossArenaBackground *background);
void BossArena__TrackTarget1(BossArenaCamera *camera);
void BossArena__TrackTarget2(BossArenaCamera *camera);
void BossArena__ProcessCamera(BossArena *work, BossArenaCamera *camera);
void BossArena__CamFunc_Type0(BossArena *work, BossArenaCamera *camera);
void BossArena__CamFunc_Type1(BossArena *work, BossArenaCamera *camera);

#endif // ! RUSH_BOSSARENA_H