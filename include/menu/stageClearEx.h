#ifndef RUSH2_STAGECLEAREX_H
#define RUSH2_STAGECLEAREX_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// STRUCTS
// --------------------

typedef struct StageClearExAssets_
{
    void *archivePldm6700;
    void *archiveCldmEx;
} StageClearExAssets;

typedef struct StageClearExGraphics3D_
{
    NNSG3dResFileHeader *mdlCharacters;
    NNSG3dResFileHeader *jntAniCharacters;
    NNSG3dResFileHeader *texAniCharacters;
    AnimatorMDL aniSonic;
    AnimatorMDL aniBlaze;
    AnimatorMDL aniTails;
    AnimatorMDL aniMarine;
    AnimatorMDL aniStage;
    AnimatorMDL aniPillar;
    AnimatorMDL aniSmokeCloud;
    Camera3D cameraConfig;
    fx32 projectionY;
} StageClearExGraphics3D;

typedef struct StageClearExGraphics2D_
{
    s32 field_0;
    NNSSndSeqPlayer *seqPlayer;
    AnimatorSprite aniNumbers[10];
    AnimatorSprite aniScoreBonusText[3];
    Vec2Fx16 scoreBonusPos[2];
    Vec2Fx16 scoreTotalPos;
    AnimatorSprite aniScoreBonusPlate;
    AnimatorSprite aniScoreTotalPlate;
    AnimatorSprite aniNameBackdrop;
    AnimatorSprite aniPlayerName;
    AnimatorSprite aniZoneName;
    BOOL showPlayerName;
    Vec2Fx32 namePos;
    s32 field_728;
    AnimatorSprite aniRankBorder;
    AnimatorSprite aniRank;
    fx32 rankScale;
    Vec2Fx16 rankPos;
    s32 field_7FC;
    s32 field_800;
    s32 field_804;
    s32 ringBonus;
    s32 timeBonus;
    s32 totalScore;
    s32 field_814;
    u16 field_818;
    u16 field_81A;
    s32 dword81C;
} StageClearExGraphics2D;

typedef struct StageClearEx_
{
    Task *taskAnimationManager;
    Task *taskDrawManager;
    void (*state)(struct StageClearEx_ *work);
    u32 timer;
    s32 dword10;
    StageClearExAssets assets;
    StageClearExGraphics3D graphics3D;
    StageClearExGraphics2D graphics2D;
} StageClearEx;

// --------------------
// FUNCTIONS
// --------------------

void StageClearEx__Create(void);
void StageClearEx__Destructor(Task *task);
void StageClearEx__SetState(StageClearEx *work, void (*state)(StageClearEx *work));
void StageClearEx__CreateAnimationManager(StageClearEx *parent);
void StageClearEx__CreateDrawManager(StageClearEx *parent);
void StageClearEx__Init(StageClearEx *work);
void StageClearEx__Destroy(StageClearEx *work);
void StageClearEx__LoadArchives(StageClearExAssets *work);
void StageClearEx__ReleaseAssets(StageClearEx *work);
void StageClearEx__InitGraphics3D(StageClearExGraphics3D *work, StageClearExAssets *assets);
void StageClearEx__LoadAssets(void *archive, ...);
void StageClearEx__ReleaseGraphics3D(StageClearExGraphics3D *work);
void StageClearEx__InitGraphics2D(StageClearExGraphics2D *work, StageClearExAssets *assets);
void StageClearEx__ReleaseGraphics2D(StageClearExGraphics2D *work);
void StageClearEx__HandleAnimations(StageClearEx *work);
void StageClearEx__HandleDrawing(StageClearEx *work);
void StageClearEx__State_21548C0(StageClearEx *work);
void StageClearEx__State_FadeIn(StageClearEx *work);
void StageClearEx__State_2154998(StageClearEx *work);
void StageClearEx__State_21549B8(StageClearEx *work);
void StageClearEx__State_2154A14(StageClearEx *work);
void StageClearEx__State_2154A28(StageClearEx *work);
void StageClearEx__State_2154B28(StageClearEx *work);
void StageClearEx__State_2154B68(StageClearEx *work);
void StageClearEx__State_2154BDC(StageClearEx *work);
void StageClearEx__State_2154BFC(StageClearEx *work);
void StageClearEx__State_2154C30(StageClearEx *work);
void StageClearEx__State_2154C94(StageClearEx *work);
void StageClearEx__State_2154CD4(StageClearEx *work);
void StageClearEx__State_2154CE8(StageClearEx *work);
void StageClearEx__State_FadeOut(StageClearEx *work);
void StageClearEx__DrawNumber(AnimatorSprite *aniNumbers, s16 x, s16 y, s32 spacing, u16 digitCount, BOOL showAll, s32 value);
u32 StageClearEx__CalcTimeBonus(u32 time);
u32 StageClearEx__CalcRingBonus(u32 rings);
void StageClearEx__LerpCB_ScoreBonus(s32 a1, void *a2, StageClearEx *work);
void StageClearEx__LerpCB_ScoreTotal(s32 a1, void *a2, StageClearEx *work);
void StageClearEx__Main_Core(void);
void StageClearEx__Main_AnimationManager(void);
void StageClearEx__Main_DrawManager(void);

#endif // RUSH2_STAGECLEAREX_H