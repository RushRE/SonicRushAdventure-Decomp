#ifndef RUSH_EXDRAWREQ_H
#define RUSH_EXDRAWREQ_H

#include <ex/exTask.h>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>
#include <game/graphics/drawReqTask.h>
#include <ex/exHitCheck.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct exPlayerUnknown2161BC0_
{
    u16 animID;
    u16 field_2;
    AnimatorMDL animator;
    PaletteAnimator paletteAnimator[15];
    NNSG3dAnmObj *field_328;
    u16 field_32C;
    VecU16 angle;
    VecFx32 translation;
    VecFx32 translation3;
    VecFx32 scale;
    VecFx32 translation2;
    VecFx32 field_364;
} exPlayerUnknown2161BC0;

typedef struct exDrawReqTaskConfig_
{
    u8 field_0;
    u8 flags;
    u8 field_2;
    u8 field_3;
    u16 priority;
    u8 __padding1;
    u8 __padding2;
} exDrawReqTaskConfig;

typedef struct exDrawFadeUnknown_
{
    Camera3D camera;
    Camera3D camera2;
    u16 useEngineB;
    u16 field_A2;
} exDrawFadeUnknown;

typedef struct EX_ACTION_NN_WORK_
{
    exHitCheck hitChecker;
    exPlayerUnknown2161BC0 model;
    exDrawReqTaskConfig config;
    exDrawFadeUnknown field_394[2];
} EX_ACTION_NN_WORK;

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void exDrawFadeTask__BossMain_216078C(void);
NOT_DECOMPILED void sub_21607EC(void);
NOT_DECOMPILED void sub_216083C(void);
NOT_DECOMPILED void sub_2160874(void);
NOT_DECOMPILED void sub_21608C4(void);
NOT_DECOMPILED void sub_2160904(void);
NOT_DECOMPILED void sub_21609D8(void);
NOT_DECOMPILED void sub_2160A84(void);
NOT_DECOMPILED void sub_2160AD4(void);
NOT_DECOMPILED void sub_2160CBC(void);
NOT_DECOMPILED void sub_2160DD8(void);
NOT_DECOMPILED void sub_2160E04(void);
NOT_DECOMPILED void sub_2160E28(void);
NOT_DECOMPILED void sub_2160E50(void);
NOT_DECOMPILED void sub_2160E78(void);
NOT_DECOMPILED void sub_2160EB0(void);
NOT_DECOMPILED void sub_2160F8C(void);
NOT_DECOMPILED void exDrawFadeUnknown__Init(void);
NOT_DECOMPILED void exDrawReqTask__EntryUnknown2__InitLight(void);
NOT_DECOMPILED void exDrawFadeUnknown__Func_21610F0(void);
NOT_DECOMPILED void exDrawReqTask__EntryUnknown2__SetLight(void);
NOT_DECOMPILED void exDrawFadeUnknown__Func_2161314(void);
NOT_DECOMPILED void exDrawFadeUnknown__Func_21613A8(void);
NOT_DECOMPILED void exDrawFadeUnknown__Func_216143C(void);
NOT_DECOMPILED void exDrawFadeUnknown__Func_21614EC(void);
NOT_DECOMPILED void exDrawFadeUnknown__Func_21615A4(void);
NOT_DECOMPILED void exDrawFadeTask__GetUnknownA(void);
NOT_DECOMPILED void exDrawFadeTask__GetUnknownB(void);
NOT_DECOMPILED void exDrawReqTask__EntryUnknown2__GetLightConfig(void);
NOT_DECOMPILED void exDrawReqTask__InitSprite2DWorker(void);
NOT_DECOMPILED void exDrawReqTask__InitSprite2DConfig(void);
NOT_DECOMPILED void exDrawReqTask__InitSprite2D(void);
NOT_DECOMPILED void exDrawReqTask__Sprite2D__HandleTransform(void);
NOT_DECOMPILED void exDrawReqTask__Sprite2D__HandleUnknown(void);
NOT_DECOMPILED void exDrawReqTask__Sprite2D__Animate(void);
NOT_DECOMPILED void exDrawReqTask__Sprite2D__HandleOamPriority(void);
NOT_DECOMPILED void exDrawReqTask__Sprite2D__Draw(void);
NOT_DECOMPILED void exDrawReqTask__Sprite2D__ProcessRequest(void);
NOT_DECOMPILED void exDrawReqTask__Sprite2D__Func_2161B44(void);
NOT_DECOMPILED void exDrawReqTask__Sprite2D__Func_2161B6C(void);
NOT_DECOMPILED void exDrawReqTask__Sprite2D__Func_2161B80(void);
NOT_DECOMPILED void exDrawReqTask__Sprite2D__IsAnimFinished(void);
NOT_DECOMPILED void exDrawReqTask__Model__InitWorker(void);
NOT_DECOMPILED void exDrawReqTask__Model__InitConfig(void);
NOT_DECOMPILED void exDrawReqTask__InitModel(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED void exDrawReqTask__Model__HandleTransform(void);
NOT_DECOMPILED void exDrawReqTask__Model__HandlePriority(void);
NOT_DECOMPILED void exDrawReqTask__Model__HandleUnknown(void);
NOT_DECOMPILED void exDrawReqTask__Model__Animate(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED void exDrawReqTask__Model__Draw(EX_ACTION_NN_WORK *work);
NOT_DECOMPILED void exDrawReqTask__Model__HandleLighting(void);
NOT_DECOMPILED void exDrawReqTask__Model__ProcessRequest(void);
NOT_DECOMPILED void exDrawReqTask__Model__IsAnimFinished(void);
NOT_DECOMPILED void exDrawReqTask__InitTrail(void);
NOT_DECOMPILED void exDrawReqTask__Trail__HandleTrail6(void);
NOT_DECOMPILED void exDrawReqTask__Trail__HandleTrail5(void);
NOT_DECOMPILED void exDrawReqTask__Trail__HandleTrail4(void);
NOT_DECOMPILED void exDrawReqTask__Trail__HandleTrail3(void);
NOT_DECOMPILED void exDrawReqTask__Trail__HandleTrail2(void);
NOT_DECOMPILED void exDrawReqTask__Trail__HandleTrail(void);
NOT_DECOMPILED void exDrawReqTask__Trail__ProcessRequest(void);
NOT_DECOMPILED void exDrawReqTask__Sprite3D__InitWorker(void);
NOT_DECOMPILED void exDrawReqTask__Sprite3D__InitConfig(void);
NOT_DECOMPILED void exDrawReqTask__InitSprite3D(void);
NOT_DECOMPILED void exDrawReqTask__Sprite3D__HandleTransform(void);
NOT_DECOMPILED void exDrawReqTask__Sprite3D__HandlePriority(void);
NOT_DECOMPILED void exDrawReqTask__Sprite3D__HandleUnknown(void);
NOT_DECOMPILED void exDrawReqTask__Sprite3D__Animate(void);
NOT_DECOMPILED void exDrawReqTask__Sprite3D__Draw(void);
NOT_DECOMPILED void exDrawReqTask__Sprite3D__ProcessRequest(void);
NOT_DECOMPILED void exDrawReqTask__Sprite3D__IsAnimFinished(void);
NOT_DECOMPILED void exDrawFadeTask__Main(void);
NOT_DECOMPILED void exDrawFadeTask__Func8(void);
NOT_DECOMPILED void exDrawFadeTask__Destructor(void);
NOT_DECOMPILED void exDrawFadeTask__Main_2163C48(void);
NOT_DECOMPILED void exDrawFadeTask__Create(void);
NOT_DECOMPILED void exDrawReqTask__Main(void);
NOT_DECOMPILED void exDrawReqTask__Func8(void);
NOT_DECOMPILED void exDrawReqTask__Destructor(void);
NOT_DECOMPILED void exDrawReqTask__Main_Process(void);
NOT_DECOMPILED void exDrawReqTask__Create(void);
NOT_DECOMPILED void exDrawReqTask__AddRequest(exHitCheck *work, exDrawReqTaskConfig *config);
NOT_DECOMPILED void exDrawReqTask__InitUnknown2(void);
NOT_DECOMPILED void exDrawReqTask__InitRequest(void);
NOT_DECOMPILED void exDrawReqTask__Func_21641C8(void);
NOT_DECOMPILED void exDrawReqTask__SetConfigPriority(exDrawReqTaskConfig *work, u16 priority);
NOT_DECOMPILED void exDrawReqTask__Func_21641F0(void);
NOT_DECOMPILED void exDrawReqTask__Func_2164218(exDrawReqTaskConfig *config);
NOT_DECOMPILED void exDrawReqTask__Func_2164238(void);
NOT_DECOMPILED void exDrawReqTask__Func_2164260(void);
NOT_DECOMPILED void exDrawReqTask__InitUnknown3(void);
NOT_DECOMPILED void exDrawReqTask__Func_2164288(void);
NOT_DECOMPILED void exDrawReqTask__Func_21642BC(void);
NOT_DECOMPILED void exDrawReqTask__Func_21642F0(void);

#endif // RUSH_EXDRAWREQ_H
