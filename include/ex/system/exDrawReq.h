#ifndef RUSH_EXDRAWREQ_H
#define RUSH_EXDRAWREQ_H

#include <ex/system/exTask.h>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/drawReqTask.h>
#include <ex/system/exHitCheck.h>

// --------------------
// ENUMS
// --------------------

enum exDrawReqTaskType_
{
    EXDRAWREQTASK_TYPE_NONE,
    EXDRAWREQTASK_TYPE_MODEL,
    EXDRAWREQTASK_TYPE_SPRITE2D,
    EXDRAWREQTASK_TYPE_SPRITE3D,
    EXDRAWREQTASK_TYPE_TRAIL,
};
typedef u16 exDrawReqTaskType;

// --------------------
// STRUCTS
// --------------------

typedef struct exDrawReqTaskConfig_
{
    union
    {
        struct
        {
            u8 value_1 : 2;
            u8 value_4 : 1;
            u8 value_8 : 1;
            u8 value_10 : 4;
        };
        u8 field;
    } field_0;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 3;
    } flags;
    struct
    {
        u8 value_1 : 1;
        u8 value_2 : 1;
        u8 value_4 : 1;
        u8 value_8 : 1;
        u8 value_10 : 1;
        u8 value_20 : 1;
        u8 value_40 : 1;
        u8 value_80 : 1;
    } field_2;
    u16 priority;
} exDrawReqTaskConfig;

typedef struct exDrawFadeUnknown_
{
    Camera3D camera;
    Camera3D camera2;
    u16 useEngineB;
    u16 field_A2;
} exDrawFadeUnknown;

typedef struct ExGraphicsSprite2D_
{
    u16 anim;
    u16 paletteRow;
    AnimatorSprite animator;
    Vec2Fx16 pos;
    Vec2Fx32 scale;
    u16 rotation;
    s32 field_78;
    s32 field_7C;
} ExGraphicsSprite2D;

typedef struct ExGraphicsSprite3D_
{
    u16 anim;
    u16 field_2;
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
    VecFx32 translation3;
    VecFx32 scale;
    VecFx32 translation2;
    VecFx32 field_364;
} ExGraphicsModel;

typedef struct ExGraphicsTrail_
{
    u16 field_0;
    u16 field_2;
    u16 angle;
    u16 field_22;
    VecFx32 position[30];
    GXRgb color[30];
    s32 alpha[30];
    VecFx32 translation;
    VecFx32 field_24C;
    s32 field_258;
    s32 field_25C;
    s32 field_260;
    u16 type;
    u16 field_266;
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
    exDrawFadeUnknown field_158[2];
} EX_ACTION_BAC3D_WORK;

typedef struct EX_ACTION_NN_WORK_
{
    exHitCheck hitChecker;
    ExGraphicsModel model;
    exDrawReqTaskConfig config;
    exDrawFadeUnknown field_394[2];
} EX_ACTION_NN_WORK;

typedef struct EX_ACTION_TRAIL_WORK_
{
    exHitCheck hitChecker;
    ExGraphicsTrail trail;
    exDrawReqTaskConfig config;
    exDrawFadeUnknown field_274[2];
} EX_ACTION_TRAIL_WORK;

typedef struct exDrawReqTaskLightConfig_
{
    DirLight light;
    DirLight light2;
    u8 type;
} exDrawReqTaskLightConfig;

// --------------------
// FUNCTIONS
// --------------------

void exDrawFadeUnknown__Init(exDrawFadeUnknown *work);
void exDrawReqTask__EntryUnknown2__InitLight(exDrawReqTaskLightConfig* work);
void exDrawFadeUnknown__Func_21610F0(exDrawFadeUnknown *work);
void exDrawReqTask__EntryUnknown2__SetLight(exDrawReqTaskLightConfig *light);
void exDrawFadeUnknown__Func_2161314(void);
void exDrawFadeUnknown__Func_21613A8(void);
void exDrawFadeUnknown__Func_216143C(void);
void exDrawFadeUnknown__Func_21614EC(void);
void exDrawFadeUnknown__Func_21615A4(s32 a1, s32 a2);
exDrawFadeUnknown *exDrawFadeTask__GetUnknownA(void);
exDrawFadeUnknown *exDrawFadeTask__GetUnknownB(void);
exDrawReqTaskLightConfig *exDrawReqTask__EntryUnknown2__GetLightConfig(void);
void exDrawReqTask__InitSprite2DWorker(ExGraphicsSprite2D *work);
void exDrawReqTask__InitSprite2DConfig(exDrawReqTaskConfig *work);
void exDrawReqTask__InitSprite2D(EX_ACTION_BAC2D_WORK *work);
void exDrawReqTask__Sprite2D__HandleTransform(EX_ACTION_BAC2D_WORK *work);
void exDrawReqTask__Sprite2D__HandleUnknown(EX_ACTION_BAC2D_WORK *work);
void exDrawReqTask__Sprite2D__Animate(EX_ACTION_BAC2D_WORK *work);
void exDrawReqTask__Sprite2D__HandleOamPriority(EX_ACTION_BAC2D_WORK *work);
void exDrawReqTask__Sprite2D__Draw(EX_ACTION_BAC2D_WORK *work);
void exDrawReqTask__Sprite2D__ProcessRequest(EX_ACTION_BAC2D_WORK *work);
void exDrawReqTask__Sprite2D__Func_2161B44(EX_ACTION_BAC2D_WORK *work);
void exDrawReqTask__Sprite2D__Func_2161B6C(EX_ACTION_BAC2D_WORK *work);
void exDrawReqTask__Sprite2D__Func_2161B80(EX_ACTION_BAC2D_WORK *work);
BOOL exDrawReqTask__Sprite2D__IsAnimFinished(EX_ACTION_BAC2D_WORK *work);
void exDrawReqTask__Model__InitWorker(EX_ACTION_NN_WORK *work);
void exDrawReqTask__Model__InitConfig(EX_ACTION_NN_WORK *work);
void exDrawReqTask__InitModel(EX_ACTION_NN_WORK *work);
void exDrawReqTask__Model__HandleTransform(EX_ACTION_NN_WORK *work);
void exDrawReqTask__Model__HandlePriority(EX_ACTION_NN_WORK *work);
void exDrawReqTask__Model__HandleUnknown(EX_ACTION_NN_WORK *work);
void exDrawReqTask__Model__Animate(EX_ACTION_NN_WORK *work);
void exDrawReqTask__Model__Draw(EX_ACTION_NN_WORK *work);
void exDrawReqTask__Model__HandleLighting(EX_ACTION_NN_WORK *work);
void exDrawReqTask__Model__ProcessRequest(EX_ACTION_NN_WORK *work);
BOOL exDrawReqTask__Model__IsAnimFinished(EX_ACTION_NN_WORK *work);
void exDrawReqTask__InitTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *position, u16 type);
void exDrawReqTask__Trail__HandleTrail6(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);
void exDrawReqTask__Trail__HandleTrail5(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos, s32 a3);
void exDrawReqTask__Trail__HandleTrail4(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);
void exDrawReqTask__Trail__HandleTrail3(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);
void exDrawReqTask__Trail__HandleTrail2(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos);
void exDrawReqTask__Trail__HandleTrail(EX_ACTION_TRAIL_WORK *work, VecFx32 *pos, u32 type, u32 color);
void exDrawReqTask__Trail__ProcessRequest(EX_ACTION_TRAIL_WORK *work);
void exDrawReqTask__Sprite3D__InitWorker(EX_ACTION_BAC3D_WORK *work);
void exDrawReqTask__Sprite3D__InitConfig(EX_ACTION_BAC3D_WORK *work);
void exDrawReqTask__InitSprite3D(EX_ACTION_BAC3D_WORK *work);
void exDrawReqTask__Sprite3D__HandleTransform(EX_ACTION_BAC3D_WORK *work);
void exDrawReqTask__Sprite3D__HandlePriority(EX_ACTION_BAC3D_WORK *work);
void exDrawReqTask__Sprite3D__HandleUnknown(EX_ACTION_BAC3D_WORK *work);
void exDrawReqTask__Sprite3D__Animate(EX_ACTION_BAC3D_WORK *work);
void exDrawReqTask__Sprite3D__Draw(EX_ACTION_BAC3D_WORK *work);
void exDrawReqTask__Sprite3D__ProcessRequest(EX_ACTION_BAC3D_WORK *work);
BOOL exDrawReqTask__Sprite3D__IsAnimFinished(EX_ACTION_BAC3D_WORK *work);

void exDrawReqTask__Main(void);
void exDrawReqTask__Func8(void);
void exDrawReqTask__Destructor(void);
void exDrawReqTask__Main_Process(void);
void exDrawReqTask__Create(void);
void exDrawReqTask__AddRequest(void *work, exDrawReqTaskConfig *config);
void exDrawReqTask__InitUnknown2(void);
void exDrawReqTask__InitRequest(void);
void exDrawReqTask__Func_21641C8(void);
void exDrawReqTask__SetConfigPriority(exDrawReqTaskConfig *work, u16 priority);
void exDrawReqTask__Func_21641F0(exDrawReqTaskConfig *config);
void exDrawReqTask__Func_2164218(exDrawReqTaskConfig *config);
void exDrawReqTask__Func_2164238(exDrawReqTaskConfig *config);
void exDrawReqTask__Func_2164260(exDrawReqTaskConfig *config);
void exDrawReqTask__InitUnknown3(exDrawReqTaskConfig *config);
void exDrawReqTask__Func_2164288(exDrawReqTaskConfig *config);
void exDrawReqTask__Func_21642BC(exDrawReqTaskConfig *config);
void exDrawReqTask__Func_21642F0(exDrawReqTaskConfig *config, s32 a2);

#endif // RUSH_EXDRAWREQ_H
