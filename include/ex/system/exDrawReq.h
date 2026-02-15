#ifndef RUSH_EXDRAWREQ_H
#define RUSH_EXDRAWREQ_H

#include <ex/system/exTask.h>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/swapBuffer3D.h>
#include <ex/system/exHitCheck.h>

// --------------------
// FORWARD DECLs
// --------------------

typedef u8 ExPlayerCharacter;

// --------------------
// CONSTANTS
// --------------------

#define EXDRAW_TRAIL_SEGMENT_COUNT 30

// --------------------
// ENUMS
// --------------------

enum ExDrawReqTaskType_
{
    EXDRAWREQTASK_TYPE_NONE,
    EXDRAWREQTASK_TYPE_MODEL,
    EXDRAWREQTASK_TYPE_SPRITE2D,
    EXDRAWREQTASK_TYPE_SPRITE3D,
    EXDRAWREQTASK_TYPE_TRAIL,
};
typedef u16 ExDrawReqTaskType;

enum ExDrawReqTaskTrailType_
{
    EXDRAWREQTASK_TRAIL_NONE,
    EXDRAWREQTASK_TRAIL_PLAYER,
    EXDRAWREQTASK_TRAIL_BOSS_FIRE_DRAGON,
    EXDRAWREQTASK_TRAIL_BOSS_HOMING_LASER,
};
typedef u16 ExDrawReqTaskTrailType;

enum ExDrawReqTaskHomingLaserTrailType_
{
    EXDRAWREQTASK_HOMINGLASER_TRAIL_0,
    EXDRAWREQTASK_HOMINGLASER_TRAIL_1,
    EXDRAWREQTASK_HOMINGLASER_TRAIL_2,
};
typedef s32 ExDrawReqTaskHomingLaserTrailType;

enum ExDrawReqTaskConfig_ActiveScreens_
{
    EXDRAWREQTASKCONFIG_SCREEN_BOTH,
    EXDRAWREQTASKCONFIG_SCREEN_A,
    EXDRAWREQTASKCONFIG_SCREEN_B,
};
typedef u8 ExDrawReqTaskConfig_ActiveScreens;

enum ExDrawReqLightType_
{
    EXDRAWREQ_LIGHT_NONE,
    EXDRAWREQ_LIGHT_BLUE,
    EXDRAWREQ_LIGHT_GREEN,
    EXDRAWREQ_LIGHT_CYAN,
    EXDRAWREQ_LIGHT_RED,
    EXDRAWREQ_LIGHT_MAGENTA,
    EXDRAWREQ_LIGHT_YELLOW,
    EXDRAWREQ_LIGHT_DEFAULT,
};
typedef u8 ExDrawReqLightType;

enum ExDrawReqTaskCameraConfigType_
{
    EXDRAW_CAMERACONFIG_NONE,
    EXDRAW_CAMERACONFIG_1,
    EXDRAW_CAMERACONFIG_2,
    EXDRAW_CAMERACONFIG_3,
    EXDRAW_CAMERACONFIG_4,
};
typedef u16 ExDrawReqTaskCameraConfigType;

enum ExDrawReqTaskPriority_
{
    EXDRAWREQTASK_PRIORITY_LOWEST = 0x0000,

    EXDRAWREQTASK_PRIORITY_DEFAULT = 0xA800,
    EXDRAWREQTASK_PRIORITY_HUD = 0xE000,

    EXDRAWREQTASK_PRIORITY_HIGHEST = 0xFFFF,
};
typedef u16 ExDrawReqTaskPriority;

// --------------------
// STRUCTS
// --------------------

typedef struct exDrawReqTaskConfig_
{
    union
    {
        struct
        {
            ExDrawReqTaskConfig_ActiveScreens activeScreens : 2;
            u8 isInvisible : 1;
            u8 useInstanceUnknown : 1;
            u8 timer : 4;
        };
        u8 field;
    } control;
    struct
    {
        u8 unknown : 1;
        u8 disableAnimation : 1;
        u8 canFinish : 1;
        u8 noStopOnFinish : 1;
        u8 forceStopAnimation : 1;
        u8 drawType : 3;
    } graphics;
    struct
    {
        u8 unused : 1;
        u8 unknown : 1;
        ExDrawReqLightType lightType : 3;
        u8 disableAffine : 1;
    } display;
    ExDrawReqTaskPriority priority;
} exDrawReqTaskConfig;

typedef struct ExDrawCameraConfig_
{
    Camera3D currentCamera;
    Camera3D nextCamera;
    u16 useEngineB;
    ExDrawReqTaskCameraConfigType type;
} ExDrawCameraConfig;

typedef struct ExGraphicsSprite2D_
{
    u16 anim;
    u16 paletteRow;
    AnimatorSprite animator;
    Vec2Fx16 pos;
    Vec2Fx32 scale;
    u16 rotation;
    s32 targetAlpha;
    s32 unknown;
} ExGraphicsSprite2D;

typedef struct ExGraphicsSprite3D_
{
    u16 anim;
    AnimatorSprite3D animator;
    VecU16 angle;
    VecFx32 translation;
    VecFx32 scale;
    VecFx32 translation2;
} ExGraphicsSprite3D;

typedef struct ExGraphicsModel_
{
    u16 animID;
    AnimatorMDL animator;
    PaletteAnimator paletteAnimator[15];
    NNSG3dAnmObj *primaryAnimResource;
    u16 primaryAnimType;
    VecU16 angle;
    VecFx32 translation;
    VecFx32 bossChestPos;
    VecFx32 scale;
    VecFx32 translation2;
    VecFx32 bossStaffPos;
} ExGraphicsModel;

typedef struct ExGraphicsTrail_
{
    u32 unknownValue;
    u16 angle;
    VecFx32 position[EXDRAW_TRAIL_SEGMENT_COUNT];
    GXRgb color[EXDRAW_TRAIL_SEGMENT_COUNT];
    s32 alpha[EXDRAW_TRAIL_SEGMENT_COUNT];
    VecFx32 translation;
    VecFx32 unknown;
    VecFx32 trailOffset;
    ExDrawReqTaskTrailType type;
    s32 id;
} ExGraphicsTrail;

typedef struct EX_ACTION_BAC2D_WORK_
{
    ExGraphicsSprite2D sprite;
    exDrawReqTaskConfig config;
} EX_ACTION_BAC2D_WORK;

typedef struct EX_ACTION_BAC3D_WORK_
{
    exHitCheck hitChecker;
    ExGraphicsSprite3D sprite;
    exDrawReqTaskConfig config;
    ExDrawCameraConfig cameraConfig[GRAPHICS_ENGINE_COUNT];
} EX_ACTION_BAC3D_WORK;

typedef struct EX_ACTION_NN_WORK_
{
    exHitCheck hitChecker;
    ExGraphicsModel model;
    exDrawReqTaskConfig config;
    ExDrawCameraConfig cameraConfig[GRAPHICS_ENGINE_COUNT];
} EX_ACTION_NN_WORK;

typedef struct EX_ACTION_TRAIL_WORK_
{
    exHitCheck hitChecker;
    ExGraphicsTrail trail;
    exDrawReqTaskConfig config;
    ExDrawCameraConfig cameraConfig[GRAPHICS_ENGINE_COUNT];
} EX_ACTION_TRAIL_WORK;

typedef struct ExDrawLightConfig_
{
    DirLight curLight;
    DirLight nextLight;
    ExDrawReqLightType type;
} ExDrawLightConfig;

// --------------------
// FUNCTIONS
// --------------------

void LoadExDrawConfig(ExDrawReqTaskCameraConfigType cameraType, ExDrawReqLightType lightType);
ExDrawCameraConfig *GetExDrawCameraConfigA(void);
ExDrawCameraConfig *GetExDrawCameraConfigB(void);
ExDrawLightConfig *GetExDrawLightConfig(void);

void InitExDrawRequestSprite2D(EX_ACTION_BAC2D_WORK *work);
void Stop2DExDrawRequestAnimation(EX_ACTION_BAC2D_WORK *work);
void AnimateExDrawRequestSprite2D(EX_ACTION_BAC2D_WORK *work);
void SetExDrawRequestSprite2DOnlyEngineA(EX_ACTION_BAC2D_WORK *work);
void SetExDrawRequestSprite2DOnlyEngineB(EX_ACTION_BAC2D_WORK *work);
BOOL IsExDrawRequestSprite2DAnimFinished(EX_ACTION_BAC2D_WORK *work);

void InitExDrawRequestModel(EX_ACTION_NN_WORK *work);
BOOL AnimateExDrawRequestModel(EX_ACTION_NN_WORK *work);
BOOL IsExDrawRequestModelAnimFinished(EX_ACTION_NN_WORK *work);

void InitExDrawRequestTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *position, ExDrawReqTaskTrailType type);
void InitExDrawRequestBossHomingLaserTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);
void ProcessExDrawRequestBossHomingLaserTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos, ExDrawReqTaskHomingLaserTrailType type);
void InitExDrawRequestBossFireDragonTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);
void ProcessExDrawRequestBossFireDragonTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);
void InitExDrawRequestPlayerTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);
void ProcessExDrawRequestPlayerTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos, u32 type, ExPlayerCharacter character);

void InitExDrawRequestSprite3D(EX_ACTION_BAC3D_WORK *work);
void AnimateExDrawRequestSprite3D(EX_ACTION_BAC3D_WORK *work);
BOOL IsExDrawRequestSprite3DAnimFinished(EX_ACTION_BAC3D_WORK *work);

void CreateExDrawReqTask(void);
void AddExDrawRequest(void *work, exDrawReqTaskConfig *config);
void SetExDrawRequestPriority(exDrawReqTaskConfig *work, ExDrawReqTaskPriority priority);
void SetExDrawRequestAnimStopOnFinish(exDrawReqTaskConfig *config);
void SetExDrawRequestAnimAsOneShot(exDrawReqTaskConfig *config);
void Stop3DExDrawRequestAnimation(exDrawReqTaskConfig *config);
BOOL ProcessExDrawTimer(exDrawReqTaskConfig *config);
void SetExDrawLightType(exDrawReqTaskConfig *config, ExDrawReqLightType type);

#endif // RUSH_EXDRAWREQ_H
