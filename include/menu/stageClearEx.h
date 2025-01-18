#ifndef RUSH_STAGECLEAREX_H
#define RUSH_STAGECLEAREX_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/drawReqTask.h>
#include <game/util/unknown204BE48.h>

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
    void *mdlCharacters;
    void *jntAniCharacters;
    void *texAniCharacters;

    // allow each array index to be named
    union
    {
        struct
        {
            AnimatorMDL aniSonic;
            AnimatorMDL aniBlaze;
            AnimatorMDL aniTails;
            AnimatorMDL aniMarine;
            AnimatorMDL aniStage;
            AnimatorMDL aniPillar;
            AnimatorMDL aniSmokeCloud;
        };

        AnimatorMDL aniModels[7];
    };

    Camera3D cameraConfig;
    fx32 projectionY;
} StageClearExGraphics3D;

typedef struct StageClearExGraphics2D_
{
    s32 field_0;
    NNSSndHandle *seqPlayer;
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
    fx32 nameMoveSpeed;
    AnimatorSprite aniRankBorder;
    AnimatorSprite aniRank;
    fx32 rankScale;
    Vec2Fx16 rankPos;
    s32 field_7FC;
    s32 field_800;
    s32 field_804;
    u32 ringBonus;
    u32 timeBonus;
    u32 totalScore;
    s32 scoreRandDisplay;
    u16 scoreRandDigitCount;
    BOOL showAllScoreDigits;
} StageClearExGraphics2D;

typedef struct StageClearEx_
{
    Task *taskAnimationManager;
    Task *taskDrawManager;
    void (*state)(struct StageClearEx_ *work);
    u32 timer;
    BOOL isActive;
    StageClearExAssets assets;
    StageClearExGraphics3D graphics3D;
    StageClearExGraphics2D graphics2D;
} StageClearEx;

// --------------------
// FUNCTIONS
// --------------------

void CreateStageClearEx(void);

void LoadAssetsForStageClearEx(void *archive, ...);

#endif // RUSH_STAGECLEAREX_H