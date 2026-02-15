#include <menu/stageClearEx.h>
#include <game/system/sysEvent.h>
#include <game/audio/audioSystem.h>
#include <game/audio/sysSound.h>
#include <game/graphics/screenShake.h>
#include <game/graphics/drawState.h>
#include <game/graphics/spriteUnknown.h>
#include <game/input/padInput.h>
#include <game/save/saveGame.h>
#include <game/stage/gameSystem.h>
#include <game/file/archiveFile.h>

// resources
#include <resources/narc/cldm_ex_lz7.h>
#include <resources/narc/pldm_67_00_lz7.h>

#include <nitro/code16.h>

// --------------------
// CONSTANTS
// --------------------

#define STAGECLEAREX_RANK_THRESHOLD_S (50000)
#define STAGECLEAREX_RANK_THRESHOLD_A (40000)
#define STAGECLEAREX_RANK_THRESHOLD_B (20000)
#define STAGECLEAREX_RANK_THRESHOLD_C (00000)

// --------------------
// ENUMS
// --------------------

enum StageClearExAnimID
{
    STAGECLEAREX_ANI_DIGIT_0,
    STAGECLEAREX_ANI_DIGIT_1,
    STAGECLEAREX_ANI_DIGIT_2,
    STAGECLEAREX_ANI_DIGIT_3,
    STAGECLEAREX_ANI_DIGIT_4,
    STAGECLEAREX_ANI_DIGIT_5,
    STAGECLEAREX_ANI_DIGIT_6,
    STAGECLEAREX_ANI_DIGIT_7,
    STAGECLEAREX_ANI_DIGIT_8,
    STAGECLEAREX_ANI_DIGIT_9,
    STAGECLEAREX_ANI_SCOREBONUSPLATE,
    STAGECLEAREX_ANI_SCORETOTALPLATE,
    STAGECLEAREX_ANI_NAMEBACKDROP,
    STAGECLEAREX_ANI_RANKBORDER,
    STAGECLEAREX_ANI_SONICNAME,   // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_BLAZENAME,   // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_ACT1CLEAR,   // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_ACT2CLEAR,   // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_BOSSCLEAR,   // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_ACTCLEAR,    // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_COMMA,       // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_DOUBLECOMMA, // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_DASH,        // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_RINGBONUSTEXT,
    STAGECLEAREX_ANI_TRICKBONUSTEXT, // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_TIMEBONUSTEXT,
    STAGECLEAREX_ANI_SPEEDBONUSTEXT, // unused, leftover from regular StageClear.
    STAGECLEAREX_ANI_TOTALTEXT,
    STAGECLEAREX_ANI_RANK_S,
    STAGECLEAREX_ANI_RANK_A,
    STAGECLEAREX_ANI_RANK_B,
    STAGECLEAREX_ANI_RANK_C,
    STAGECLEAREX_ANI_ZONENAME,
    STAGECLEAREX_ANI_PLAYERNAME,

    STAGECLEAREX_ANI_COUNT,
};

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _u32_div_f(void);

// --------------------
// VARIABLES
// --------------------

static Task *singleton;

static const u8 timeBonusThreshold[8] = { 190, 180, 170, 160, 150, 140, 130, 120 };
static const u8 ringBonusThreshold[8] = { 15, 20, 25, 30, 35, 40, 45, 50 };
static const u32 timeBonusScore[9]    = { 10000, 15000, 20000, 25000, 30000, 34000, 38000, 42000, 45000 };
static const u32 ringBonusScore[9]    = { 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000 };

// --------------------
// FUNCTION DECLS
// --------------------

static void StageClearEx_Destructor(Task *task);
static void SetStageClearExState(StageClearEx *work, void (*state)(StageClearEx *work));
static void CreateStageClearExAnimationManager(StageClearEx *parent);
static void CreateStageClearExDrawManager(StageClearEx *parent);

static void InitStageClearEx(StageClearEx *work);
static void DestroyStageClearEx(StageClearEx *work);
static void InitStageClearExAssets(StageClearExAssets *work);
static void ReleaseStageClearExAssets(StageClearExAssets *work);
static void InitStageClearExGraphics3D(StageClearExGraphics3D *work, StageClearExAssets *assets);
static void ReleaseStageClearExGraphics3D(StageClearExGraphics3D *work);
static void InitStageClearExGraphics2D(StageClearExGraphics2D *work, StageClearExAssets *assets);
static void ReleaseStageClearExGraphics2D(StageClearExGraphics2D *work);

static void HandleStageClearExAnimations(StageClearEx *work);
static void HandleStageClearExDrawing(StageClearEx *work);

static void StageClearEx_State_Init(StageClearEx *work);
static void StageClearEx_State_FadeIn(StageClearEx *work);
static void StageClearEx_State_IntroDelay(StageClearEx *work);
static void StageClearEx_State_InitText(StageClearEx *work);
static void StageClearEx_State_DisplayText(StageClearEx *work);
static void StageClearEx_State_InitScore(StageClearEx *work);
static void StageClearEx_State_EnterScores(StageClearEx *work);
static void StageClearEx_State_RevealTotalScore(StageClearEx *work);
static void StageClearEx_State_ShowTotalScore(StageClearEx *work);
static void StageClearEx_State_InitRank(StageClearEx *work);
static void StageClearEx_State_RankAppear(StageClearEx *work);
static void StageClearEx_State_RankGet(StageClearEx *work);
static void StageClearEx_State_ShowRank(StageClearEx *work);
static void StageClearEx_State_DisplayResults(StageClearEx *work);
static void StageClearEx_State_FadeOut(StageClearEx *work);

static void DrawNumberForStageClearEx(AnimatorSprite *aniNumbers, s16 x, s16 y, u16 spacing, u16 digitCount, BOOL showAll, u32 number);
static u32 CalcStageClearExTimeBonus(u32 time);
static u32 CalcStageClearExRingBonus(u32 rings);
static void Lerp_StageClearExScoreBonus(s32 type, TaskUnknown204BE48 *work, void *arg);
static void Lerp_StageClearExScoreTotal(s32 type, TaskUnknown204BE48 *work, void *arg);

static void StageClearEx_Main_Core(void);
static void StageClearEx_Main_AnimationManager(void);
static void StageClearEx_Main_DrawManager(void);

// --------------------
// FUNCTIONS
// --------------------

void CreateStageClearEx(void)
{
    singleton = TaskCreate(StageClearEx_Main_Core, StageClearEx_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 1, TASK_GROUP(0), StageClearEx);

    StageClearEx *work = TaskGetWork(singleton, StageClearEx);
    InitStageClearEx(work);
}

void StageClearEx_Destructor(Task *task)
{
    singleton = NULL;
}

void SetStageClearExState(StageClearEx *work, void (*state)(StageClearEx *work))
{
    work->timer = 0;
    work->state = state;
}

void CreateStageClearExAnimationManager(StageClearEx *parent)
{
    // BUG/OVERSIGHT:
    // this uses 'StageClearEx' work struct instead of allocating nothing (since it doesn't use it's own work struct)
    // causing slightly more memory to be allocated than needed!

    parent->taskAnimationManager = TaskCreate(StageClearEx_Main_AnimationManager, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x61, TASK_GROUP(0), StageClearEx);
}

void CreateStageClearExDrawManager(StageClearEx *parent)
{
    // BUG/OVERSIGHT:
    // this uses 'StageClearEx' work struct instead of allocating nothing (since it doesn't use it's own work struct)
    // causing slightly more memory to be allocated than needed!

    parent->taskDrawManager = TaskCreate(StageClearEx_Main_DrawManager, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x81, TASK_GROUP(0), StageClearEx);
}

void InitStageClearEx(StageClearEx *work)
{
    TaskInitWork32(work);

    GX_SetVisiblePlane(GX_PLANEMASK_NONE);
    GXS_SetVisiblePlane(GX_PLANEMASK_NONE);

    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_3D);
    GXS_SetGraphicsMode(GX_BGMODE_0);

    VRAMSystem__Reset();
    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_01_AB);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0_G);
    VRAMSystem__SetupBGBank(GX_VRAM_BG_16_F);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_64_E, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);

    StageClearExAssets *assets = &work->assets;
    InitStageClearExAssets(assets);

    ReleaseAudioSystem();
    LoadSysSound(SYSSOUND_GROUP_CLEAR_E);

    InitStageClearExGraphics3D(&work->graphics3D, assets);
    InitStageClearExGraphics2D(&work->graphics2D, assets);
    work->isActive = TRUE;

    CreateStageClearExAnimationManager(work);
    SetStageClearExState(work, StageClearEx_State_Init);
}

void DestroyStageClearEx(StageClearEx *work)
{
    if (work->taskAnimationManager != NULL)
        DestroyTask(work->taskAnimationManager);

    if (work->taskDrawManager != NULL)
        DestroyTask(work->taskDrawManager);

    work->isActive = FALSE;
    DestroySwapBuffer3D();
    ReleaseStageClearExGraphics2D(&work->graphics2D);
    ReleaseStageClearExGraphics3D(&work->graphics3D);
    ReleaseSysSound();

    ReleaseStageClearExAssets(&work->assets);

    DestroyCurrentTask();
}

void InitStageClearExAssets(StageClearExAssets *work)
{
    work->archivePldm6700 = ArchiveFile__Load("/narc/pldm_67_00_lz7.narc", ARCHIVEFILE_ID_NONE, ARCHIVEFILE_AUTO_ALLOC_HEAD_USER, ARCHIVEFILE_FLAG_IS_COMPRESSED, NULL);
    work->archiveCldmEx   = ArchiveFile__Load("/narc/cldm_ex_lz7.narc", ARCHIVEFILE_ID_NONE, ARCHIVEFILE_AUTO_ALLOC_HEAD_USER, ARCHIVEFILE_FLAG_IS_COMPRESSED, NULL);
}

void ReleaseStageClearExAssets(StageClearExAssets *work)
{
    HeapFree(HEAP_USER, work->archiveCldmEx);
    HeapFree(HEAP_USER, work->archivePldm6700);
}

void InitStageClearExGraphics3D(StageClearExGraphics3D *work, StageClearExAssets *assets)
{
    AnimatorMDL *aniSonic;
    void *drawState;

    LoadAssetsForStageClearEx(assets->archivePldm6700, &work->mdlCharacters, ARCHIVE_PLDM_67_00_LZ7_FILE_MD, &work->jntAniCharacters, ARCHIVE_PLDM_67_00_LZ7_FILE_CA,
                              &work->texAniCharacters, ARCHIVE_PLDM_67_00_LZ7_FILE_TA, &drawState, ARCHIVE_PLDM_67_00_LZ7_FILE_SD7, NULL);

    LoadDrawState(drawState, DRAWSTATE_ALL);

    Camera3D *cameraConfig = &work->cameraConfig;
    GetDrawStateCameraView(drawState, cameraConfig);
    GetDrawStateCameraProjection(drawState, &cameraConfig->projection);

    work->projectionY = cameraConfig->projection.scaleW + MultiplyFX(cameraConfig->projection.scaleW, 260);

    void *mdlCharacters    = work->mdlCharacters;
    void *texAniCharacters = work->texAniCharacters;
    void *jntAniCharacters = work->jntAniCharacters;
    NNS_G3dResDefaultSetup(work->mdlCharacters);

    aniSonic = &work->aniSonic;
    AnimatorMDL__Init(aniSonic, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniSonic, mdlCharacters, 1, FALSE, FALSE);
    AnimatorMDL__SetAnimation(aniSonic, B3D_ANIM_JOINT_ANIM, jntAniCharacters, 38, NULL);
    aniSonic->animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_CAN_LOOP;

    AnimatorMDL *aniBlaze = &work->aniBlaze;
    AnimatorMDL__Init(aniBlaze, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniBlaze, mdlCharacters, 2, FALSE, FALSE);
    AnimatorMDL__SetAnimation(aniBlaze, B3D_ANIM_JOINT_ANIM, jntAniCharacters, 39, NULL);
    aniBlaze->animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_CAN_LOOP;

    AnimatorMDL *aniTails = &work->aniTails;
    AnimatorMDL__Init(aniTails, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniTails, mdlCharacters, 16, FALSE, FALSE);
    AnimatorMDL__SetAnimation(aniTails, B3D_ANIM_JOINT_ANIM, jntAniCharacters, 41, NULL);
    aniTails->animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_CAN_LOOP;

    AnimatorMDL *aniMarine = &work->aniMarine;
    AnimatorMDL__Init(aniMarine, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniMarine, mdlCharacters, 7, FALSE, FALSE);
    AnimatorMDL__SetAnimation(aniMarine, B3D_ANIM_JOINT_ANIM, jntAniCharacters, 40, NULL);
    aniMarine->animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_CAN_LOOP;

    AnimatorMDL *aniStage = &work->aniStage;
    AnimatorMDL__Init(aniStage, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniStage, mdlCharacters, 0, FALSE, FALSE);
    AnimatorMDL__SetAnimation(aniStage, B3D_ANIM_JOINT_ANIM, jntAniCharacters, 37, NULL);
    AnimatorMDL__SetAnimation(aniStage, B3D_ANIM_TEX_ANIM, texAniCharacters, 12, NULL);
    aniStage->animFlags[B3D_ANIM_JOINT_ANIM] |= ANIMATORMDL_FLAG_CAN_LOOP;
    aniStage->animFlags[B3D_ANIM_TEX_ANIM] |= ANIMATORMDL_FLAG_CAN_LOOP;

    AnimatorMDL *aniPillar = &work->aniPillar;
    AnimatorMDL__Init(aniPillar, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniPillar, mdlCharacters, 6, FALSE, FALSE);
    AnimatorMDL__SetAnimation(aniPillar, B3D_ANIM_JOINT_ANIM, jntAniCharacters, 42, NULL);

    AnimatorMDL *aniSmokeCloud = &work->aniSmokeCloud;
    AnimatorMDL__Init(aniSmokeCloud, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniSmokeCloud, mdlCharacters, 17, FALSE, FALSE);
    AnimatorMDL__SetAnimation(aniSmokeCloud, B3D_ANIM_JOINT_ANIM, jntAniCharacters, 43, NULL);
}

void LoadAssetsForStageClearEx(void *archive, ...)
{
    va_list assetList;

    va_start(assetList, archive);
    ArchiveFile__LoadFiles(archive, assetList);
	va_end(assetList);
}

void ReleaseStageClearExGraphics3D(StageClearExGraphics3D *work)
{
    AnimatorMDL__Release(&work->aniSonic);
    AnimatorMDL__Release(&work->aniBlaze);
    AnimatorMDL__Release(&work->aniTails);
    AnimatorMDL__Release(&work->aniMarine);
    AnimatorMDL__Release(&work->aniStage);
    AnimatorMDL__Release(&work->aniPillar);
    AnimatorMDL__Release(&work->aniSmokeCloud);

    NNS_G3dResDefaultRelease(work->mdlCharacters);
}

void InitStageClearExGraphics2D(StageClearExGraphics2D *work, StageClearExAssets *assets)
{
    AnimatorSprite *animator;
    void *sprHUD;

    work->ringBonus  = CalcStageClearExRingBonus(playerGameStatus.ringBonus);
    work->timeBonus  = CalcStageClearExTimeBonus(playerGameStatus.stageTimer);
    work->totalScore = work->ringBonus + work->timeBonus;

    LoadAssetsForStageClearEx(assets->archiveCldmEx, &sprHUD, ARCHIVE_CLDM_EX_LZ7_FILE_CLDM_EX_BAC, NULL);

    animator = &work->aniScoreBonusPlate;
    SpriteUnknown__InitAnimator(animator, sprHUD, STAGECLEAREX_ANI_SCOREBONUSPLATE, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                                SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, GRAPHICS_ENGINE_A, STAGECLEAREX_ANI_SCOREBONUSPLATE), PALETTE_ROW_1, SPRITE_PRIORITY_0, SPRITE_ORDER_14);

    animator = &work->aniScoreTotalPlate;
    SpriteUnknown__InitAnimator(animator, sprHUD, STAGECLEAREX_ANI_SCORETOTALPLATE, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                                SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, GRAPHICS_ENGINE_A, STAGECLEAREX_ANI_SCORETOTALPLATE), PALETTE_ROW_1, SPRITE_PRIORITY_0, SPRITE_ORDER_14);

    animator = &work->aniScoreBonusText[0];
    SpriteUnknown__InitAnimator(animator, sprHUD, STAGECLEAREX_ANI_RINGBONUSTEXT, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                                SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, GRAPHICS_ENGINE_A, STAGECLEAREX_ANI_RINGBONUSTEXT), PALETTE_ROW_4, SPRITE_PRIORITY_0, SPRITE_ORDER_10);
    Vec2Fx16 *ringBonusPos = &work->scoreBonusPos[0];
    ringBonusPos->x        = -160;
    ringBonusPos->y        = 132;

    animator = &work->aniScoreBonusText[1];
    SpriteUnknown__InitAnimator(animator, sprHUD, STAGECLEAREX_ANI_TIMEBONUSTEXT, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                                SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, GRAPHICS_ENGINE_A, STAGECLEAREX_ANI_TIMEBONUSTEXT), PALETTE_ROW_4, SPRITE_PRIORITY_0, SPRITE_ORDER_10);
    Vec2Fx16 *timeBonusPos = &work->scoreBonusPos[1];
    timeBonusPos->x        = -160;
    timeBonusPos->y        = 152;

    animator = &work->aniScoreBonusText[2];
    SpriteUnknown__InitAnimator(animator, sprHUD, STAGECLEAREX_ANI_TOTALTEXT, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                                SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, GRAPHICS_ENGINE_A, STAGECLEAREX_ANI_TOTALTEXT), PALETTE_ROW_4, SPRITE_PRIORITY_0, SPRITE_ORDER_10);
    Vec2Fx16 *scoreTotalPos = &work->scoreBonusPos[2];
    scoreTotalPos->x        = -160;
    scoreTotalPos->y        = 172;

    work->showAllScoreDigits = TRUE;
    for (u32 i = 0; i < ARRAY_COUNT(work->aniNumbers); i++)
    {
        u16 anim = STAGECLEAREX_ANI_DIGIT_0 + i;
        SpriteUnknown__InitAnimator(&work->aniNumbers[i], sprHUD, anim, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                                    SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, GRAPHICS_ENGINE_A, anim), PALETTE_ROW_5, SPRITE_PRIORITY_0, SPRITE_ORDER_12);
    }

    animator = &work->aniNameBackdrop;
    SpriteUnknown__InitAnimator(animator, sprHUD, STAGECLEAREX_ANI_NAMEBACKDROP, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                                SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, GRAPHICS_ENGINE_A, STAGECLEAREX_ANI_NAMEBACKDROP), PALETTE_ROW_6, SPRITE_PRIORITY_0, SPRITE_ORDER_6);

    animator = &work->aniPlayerName;
    SpriteUnknown__InitAnimator(animator, sprHUD, STAGECLEAREX_ANI_PLAYERNAME, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                                SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, GRAPHICS_ENGINE_A, STAGECLEAREX_ANI_PLAYERNAME), PALETTE_ROW_1, SPRITE_PRIORITY_0, SPRITE_ORDER_4);

    animator = &work->aniZoneName;
    SpriteUnknown__InitAnimator(animator, sprHUD, STAGECLEAREX_ANI_ZONENAME, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, GRAPHICS_ENGINE_A,
                                SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, GRAPHICS_ENGINE_A, STAGECLEAREX_ANI_ZONENAME), PALETTE_ROW_1, SPRITE_PRIORITY_0, SPRITE_ORDER_4);
    work->namePos.x = FLOAT_TO_FX32(0.0);
    work->namePos.y = -FLOAT_TO_FX32(22.0);

    animator = &work->aniRankBorder;
    SpriteUnknown__InitAnimator(animator, sprHUD, STAGECLEAREX_ANI_RANKBORDER,
                                ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_DRAW, GRAPHICS_ENGINE_A,
                                SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, GRAPHICS_ENGINE_A, STAGECLEAREX_ANI_RANKBORDER), PALETTE_ROW_2, SPRITE_PRIORITY_0, SPRITE_ORDER_12);
    animator->pos.x = 192;
    animator->pos.y = 96;

    u16 rankAnim;
    if (work->totalScore >= STAGECLEAREX_RANK_THRESHOLD_S)
    {
        rankAnim = STAGECLEAREX_ANI_RANK_S + SAVE_STAGE_RANK_S;
    }
    else if (work->totalScore >= STAGECLEAREX_RANK_THRESHOLD_A)
    {
        rankAnim = STAGECLEAREX_ANI_RANK_S + SAVE_STAGE_RANK_A;
    }
    else if (work->totalScore >= STAGECLEAREX_RANK_THRESHOLD_B)
    {
        rankAnim = STAGECLEAREX_ANI_RANK_S + SAVE_STAGE_RANK_B;
    }
    else
    {
        rankAnim = STAGECLEAREX_ANI_RANK_S + SAVE_STAGE_RANK_C;
    }

    animator = &work->aniRank;
    SpriteUnknown__InitAnimator(animator, sprHUD, rankAnim,
                                ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_DRAW, FALSE,
                                SpriteUnknown__GetSpriteSizeFromAnim(sprHUD, FALSE, rankAnim), PALETTE_ROW_3, SPRITE_PRIORITY_0, SPRITE_ORDER_10);
    animator->pos.x = 192;
    animator->pos.y = 96;

    work->sndHandle = AllocSndHandle();

    SaveGame__UpdateStageRecord(22, work->totalScore, rankAnim - STAGECLEAREX_ANI_RANK_S);
}

void ReleaseStageClearExGraphics2D(StageClearExGraphics2D *work)
{
    FreeSndHandle(work->sndHandle);

    AnimatorSprite__Release(&work->aniRank);
    AnimatorSprite__Release(&work->aniRankBorder);
    AnimatorSprite__Release(&work->aniZoneName);
    AnimatorSprite__Release(&work->aniPlayerName);
    AnimatorSprite__Release(&work->aniNameBackdrop);

    for (AnimatorSprite *ani = &work->aniNumbers[0]; ani != &work->aniNumbers[10]; ani++)
    {
        AnimatorSprite__Release(ani);
    }

    for (AnimatorSprite *ani = &work->aniScoreBonusText[0]; ani != &work->aniScoreBonusText[3]; ani++)
    {
        AnimatorSprite__Release(ani);
    }

    AnimatorSprite__Release(&work->aniScoreTotalPlate);
    AnimatorSprite__Release(&work->aniScoreBonusPlate);
}

void HandleStageClearExAnimations(StageClearEx *work)
{
    StageClearExGraphics3D *graphics3D = &work->graphics3D;
    StageClearExGraphics2D *graphics2D = &work->graphics2D;

    for (AnimatorMDL *ani = &graphics3D->aniModels[0]; ani != &graphics3D->aniModels[7]; ani++)
    {
        AnimatorMDL__ProcessAnimation(ani);
    }

    AnimatorSprite__ProcessAnimationFast(&graphics2D->aniZoneName);
    AnimatorSprite__ProcessAnimationFast(&graphics2D->aniPlayerName);
    AnimatorSprite__ProcessAnimationFast(&graphics2D->aniNameBackdrop);

    graphics2D->namePos.x += graphics2D->nameMoveSpeed;
    if (graphics2D->namePos.x >= FLOAT_TO_FX32(HW_LCD_WIDTH))
    {
        graphics2D->namePos.x -= FLOAT_TO_FX32(HW_LCD_WIDTH);
        graphics2D->showPlayerName = TRUE;
    }

    for (AnimatorSprite *ani = &graphics2D->aniNumbers[0]; ani != &graphics2D->aniNumbers[10]; ani++)
    {
        AnimatorSprite__ProcessAnimationFast(ani);
    }

    for (AnimatorSprite *ani = &graphics2D->aniScoreBonusText[0]; ani != &graphics2D->aniScoreBonusText[3]; ani++)
    {
        AnimatorSprite__ProcessAnimationFast(ani);
    }

    AnimatorSprite__ProcessAnimationFast(&graphics2D->aniScoreTotalPlate);
    AnimatorSprite__ProcessAnimationFast(&graphics2D->aniScoreBonusPlate);
    AnimatorSprite__ProcessAnimationFast(&graphics2D->aniRank);
    AnimatorSprite__ProcessAnimationFast(&graphics2D->aniRankBorder);
}

void HandleStageClearExDrawing(StageClearEx *work)
{
    StageClearExGraphics3D *graphics3D = &work->graphics3D;

    Camera3D *camera = &graphics3D->cameraConfig;
    if (SwapBuffer3D_GetPrimaryScreen() != SWAPBUFFER3D_PRIMARY_BOTTOM)
    {
        camera->projection.position.y = -graphics3D->projectionY;
        SwapBuffer3D_ApplyCameraState(&graphics3D->cameraConfig);
    }
    else
    {
        camera->projection.position.y = graphics3D->projectionY;
        SwapBuffer3D_ApplyCameraState(&graphics3D->cameraConfig);
    }

    AnimatorMDL *ani = &graphics3D->aniModels[0];
    for (; ani != &graphics3D->aniModels[7]; ani++)
    {
        AnimatorMDL__Draw(ani);
    }

    StageClearExGraphics2D *graphics2D = &work->graphics2D;
    if (SwapBuffer3D_GetPrimaryScreen() != SWAPBUFFER3D_PRIMARY_BOTTOM)
    {
        AnimatorSprite *aniNameBackdrop = &graphics2D->aniNameBackdrop;
        aniNameBackdrop->pos.x          = FX32_TO_WHOLE(graphics2D->namePos.x);
        aniNameBackdrop->pos.y          = FX32_TO_WHOLE(graphics2D->namePos.y);
        AnimatorSprite__DrawFrame(aniNameBackdrop);

        AnimatorSprite *aniZoneName = &graphics2D->aniZoneName;
        *(u32 *)&aniZoneName->pos   = *(u32 *)&aniNameBackdrop->pos;
        if (graphics2D->showPlayerName)
            AnimatorSprite__DrawFrame(aniZoneName);

        aniNameBackdrop->pos.x -= HW_LCD_WIDTH;
        AnimatorSprite__DrawFrame(aniNameBackdrop);

        aniZoneName->pos.x -= HW_LCD_WIDTH;
        AnimatorSprite__DrawFrame(aniZoneName);

        Vec2Fx16 *scoreBonusPos            = &graphics2D->scoreBonusPos[0];
        AnimatorSprite *aniScoreBonusPlate = &graphics2D->aniScoreBonusPlate;
        aniScoreBonusPlate->pos.x          = scoreBonusPos->x + 8;
        aniScoreBonusPlate->pos.y          = scoreBonusPos->y;
        AnimatorSprite__DrawFrame(aniScoreBonusPlate);

        AnimatorSprite *aniTimeBonus = &graphics2D->aniScoreBonusText[0];
        aniTimeBonus->pos.x          = scoreBonusPos->x;
        aniTimeBonus->pos.y          = scoreBonusPos->y - 8;
        AnimatorSprite__DrawFrame(graphics2D->aniScoreBonusText);

        DrawNumberForStageClearEx(graphics2D->aniNumbers, scoreBonusPos->x + 88, scoreBonusPos->y - 2, 8, 6, FALSE, graphics2D->ringBonus);

        scoreBonusPos             = &graphics2D->scoreBonusPos[1];
        aniScoreBonusPlate->pos.x = scoreBonusPos->x + 8;
        aniScoreBonusPlate->pos.y = scoreBonusPos->y;
        AnimatorSprite__DrawFrame(aniScoreBonusPlate);

        AnimatorSprite *aniRingBonus = &graphics2D->aniScoreBonusText[1];
        aniRingBonus->pos.x          = scoreBonusPos->x;
        aniRingBonus->pos.y          = scoreBonusPos->y - 48;
        AnimatorSprite__DrawFrame(&graphics2D->aniScoreBonusText[1]);

        DrawNumberForStageClearEx(graphics2D->aniNumbers, scoreBonusPos->x + 88, scoreBonusPos->y - 2, 8, 6, FALSE, graphics2D->timeBonus);

        u32 i;
        u32 hiddenDigitCount = graphics2D->scoreRandDigitCount;
        u32 hiddenDigitBase  = 1;
        i                    = 0;
        while (i < hiddenDigitCount)
        {
            i++;
            hiddenDigitBase *= 10;
        }

        s32 score = (graphics2D->totalScore % hiddenDigitBase) + (graphics2D->scoreRandDisplay / hiddenDigitBase) * hiddenDigitBase;

        Vec2Fx16 *scoreTotalPos            = &graphics2D->scoreTotalPos;
        AnimatorSprite *aniScoreTotalPlate = &graphics2D->aniScoreTotalPlate;
        aniScoreTotalPlate->pos.x          = scoreTotalPos->x + 8;
        aniScoreTotalPlate->pos.y          = scoreTotalPos->y;
        AnimatorSprite__DrawFrame(aniScoreTotalPlate);

        AnimatorSprite *aniScoreTotal = &graphics2D->aniScoreBonusText[2];
        aniScoreTotal->pos.x          = scoreTotalPos->x;
        aniScoreTotal->pos.y          = scoreTotalPos->y - 88;
        AnimatorSprite__DrawFrame(aniScoreTotal);

        DrawNumberForStageClearEx(graphics2D->aniNumbers, scoreTotalPos->x + 88, scoreTotalPos->y - 2, 8, 6, graphics2D->showAllScoreDigits, score);
    }
    else
    {
        AnimatorSprite *aniNameBackdrop = &graphics2D->aniNameBackdrop;

        aniNameBackdrop->pos.x = HW_LCD_WIDTH - FX32_TO_WHOLE(graphics2D->namePos.x);
        aniNameBackdrop->pos.y = HW_LCD_HEIGHT - FX32_TO_WHOLE(graphics2D->namePos.y);
        AnimatorSprite__DrawFrame(aniNameBackdrop);

        AnimatorSprite *aniPlayerName = &graphics2D->aniPlayerName;
        *(u32 *)&aniPlayerName->pos   = *(u32 *)&aniNameBackdrop->pos;
        AnimatorSprite__DrawFrame(aniPlayerName);

        aniNameBackdrop->pos.x -= HW_LCD_WIDTH;
        AnimatorSprite__DrawFrame(aniNameBackdrop);

        if (graphics2D->showPlayerName)
        {
            aniPlayerName->pos.x -= HW_LCD_WIDTH;
            AnimatorSprite__DrawFrame(aniPlayerName);
        }

        if (graphics2D->rankScale != FLOAT_TO_FX32(1.0))
        {
            AnimatorSprite *aniRankBorder = &graphics2D->aniRankBorder;
            AnimatorSprite__DrawFrame(aniRankBorder);

            AnimatorSprite *aniRank = &graphics2D->aniRank;
            AnimatorSprite__DrawFrameRotoZoom(aniRank, graphics2D->rankScale, graphics2D->rankScale, 0);
        }
        else
        {
            AnimatorSprite *aniRankBorder = &graphics2D->aniRankBorder;
            aniRankBorder->pos.x += graphics2D->rankPos.x;
            aniRankBorder->pos.y += graphics2D->rankPos.y;
            AnimatorSprite__DrawFrame(&graphics2D->aniRankBorder);
            aniRankBorder->pos.x -= graphics2D->rankPos.x;
            aniRankBorder->pos.y -= graphics2D->rankPos.y;

            AnimatorSprite *aniRank = &graphics2D->aniRank;
            aniRank->pos.x -= graphics2D->rankPos.x;
            aniRank->pos.y -= graphics2D->rankPos.y;
            AnimatorSprite__DrawFrame(&graphics2D->aniRank);
            aniRank->pos.x += graphics2D->rankPos.x;
            aniRank->pos.y += graphics2D->rankPos.y;
        }
    }
}

void StageClearEx_State_Init(StageClearEx *work)
{
    CreateSwapBuffer3D();

    SwapBuffer3D *camera3D             = GetSwapBuffer3DWork();
    camera3D->gfxControl[0].brightness = renderCoreGFXControlA.brightness;
    camera3D->gfxControl[1].brightness = renderCoreGFXControlB.brightness;

    CreateStageClearExDrawManager(work);

    G2_SetBG0Priority(0);
    G2_SetBG1Priority(1);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(3);

    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_OBJ);

    SetStageClearExState(work, StageClearEx_State_FadeIn);
}

void StageClearEx_State_FadeIn(StageClearEx *work)
{
    SwapBuffer3D *camera             = GetSwapBuffer3DWork();
    RenderCoreGFXControl *gfxControl = &camera->gfxControl[0];

    s32 startBrightness;
    if (renderCoreGFXControlA.brightness > 0)
    {
        startBrightness = RENDERCORE_BRIGHTNESS_WHITE;
    }
    else if (renderCoreGFXControlA.brightness < 0)
    {
        startBrightness = RENDERCORE_BRIGHTNESS_BLACK;
    }
    else
    {
        startBrightness = RENDERCORE_BRIGHTNESS_WHITE;
    }

    for (; gfxControl != &camera->gfxControl[2]; gfxControl++)
    {
        gfxControl->brightness = Task__Unknown204BE48__LerpValue(startBrightness, RENDERCORE_BRIGHTNESS_DEFAULT, (work->timer << 6), 0);
    }

    if (work->timer == 64)
    {
        SetStageClearExState(work, StageClearEx_State_IntroDelay);
    }
}

void StageClearEx_State_IntroDelay(StageClearEx *work)
{
    if (work->timer > SECONDS_TO_FRAMES(3.0))
    {
        PlaySysTrack(SND_SYS_SEQ_SEQ_EXTRA_CLEAR, TRUE);
        SetStageClearExState(work, StageClearEx_State_InitText);
    }
}

void StageClearEx_State_InitText(StageClearEx *work)
{
    StageClearExGraphics2D *graphics2D = &work->graphics2D;

    graphics2D->nameMoveSpeed = FLOAT_TO_FX32(1.5);
    Task__Unknown204BE48__Create(&graphics2D->namePos.y, 4, -FLOAT_TO_FX32(22.0), FLOAT_TO_FX32(22.0), 0, 16, Task__Unknown204BE48__LerpValue, 0, 0, 0, 0,
                                 TASK_PRIORITY_UPDATE_LIST_START + 0x62, TASK_GROUP(0));

    SetStageClearExState(work, StageClearEx_State_DisplayText);
}

void StageClearEx_State_DisplayText(StageClearEx *work)
{
    if (work->timer > SECONDS_TO_FRAMES(2.0))
    {
        SetStageClearExState(work, StageClearEx_State_InitScore);
    }
}

void StageClearEx_State_InitScore(StageClearEx *work)
{
    StageClearExGraphics2D *graphics2D = &work->graphics2D;

    graphics2D->scoreRandDigitCount = 0;

    u32 low                      = (mtMathRand() & 0xF);
    u32 high                     = (mtMathRand() << 4);
    graphics2D->scoreRandDisplay = high | low;

    Task__Unknown204BE48__Create(&graphics2D->scoreBonusPos[0], 2, -160, 0, 0, 16, Task__Unknown204BE48__LerpValue, -FLOAT_TO_FX32(1.0), Lerp_StageClearExScoreBonus, work, 0,
                                 TASK_PRIORITY_UPDATE_LIST_START + 0x62, TASK_GROUP(0));
    Task__Unknown204BE48__Create(&graphics2D->scoreBonusPos[1], 2, -160, 0, 16, 16, Task__Unknown204BE48__LerpValue, -FLOAT_TO_FX32(1.0), Lerp_StageClearExScoreBonus, work, 0,
                                 TASK_PRIORITY_UPDATE_LIST_START + 0x62, TASK_GROUP(0));
    Task__Unknown204BE48__Create(&graphics2D->scoreTotalPos, 2, -160, 0, 32, 16, Task__Unknown204BE48__LerpValue, -FLOAT_TO_FX32(1.0), Lerp_StageClearExScoreTotal, work, 0,
                                 TASK_PRIORITY_UPDATE_LIST_START + 0x62, TASK_GROUP(0));

    SetStageClearExState(work, StageClearEx_State_EnterScores);
}

void StageClearEx_State_EnterScores(StageClearEx *work)
{
    StageClearExGraphics2D *graphics2D = &work->graphics2D;

    if ((work->timer & 1) != 0)
    {
        graphics2D->scoreRandDisplay = Task__Unknown204BE48__Rand() % 1000000;
    }

    if (work->timer > 90)
    {
        SetStageClearExState(work, StageClearEx_State_RevealTotalScore);
    }
}

void StageClearEx_State_RevealTotalScore(StageClearEx *work)
{
    StageClearExGraphics2D *graphics2D = &work->graphics2D;

    if ((work->timer & 1) != 0)
    {
        graphics2D->scoreRandDisplay = Task__Unknown204BE48__Rand() % 1000000;
    }

    graphics2D->scoreRandDigitCount = work->timer >> 4;

    if (graphics2D->scoreRandDigitCount >= 6)
    {
        PlaySystemSfx(SND_SYS_SEQARC_ARC_CLEAR_E, SND_SYS_SEQARC_ARC_CLEAR_E_SEQ_SE_SUM_INDICATION);
        StopStageSfx(graphics2D->sndHandle);
        graphics2D->showAllScoreDigits = FALSE;

        SetStageClearExState(work, StageClearEx_State_ShowTotalScore);
    }
}

void StageClearEx_State_ShowTotalScore(StageClearEx *work)
{
    if (work->timer > 32)
    {
        StageClearExGraphics2D *graphics2D = &work->graphics2D;

        graphics2D->aniRankBorder.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
        SetStageClearExState(work, StageClearEx_State_InitRank);
    }
}

void StageClearEx_State_InitRank(StageClearEx *work)
{
    if (work->timer > SECONDS_TO_FRAMES(0.5))
    {
        StageClearExGraphics2D *graphics2D = &work->graphics2D;

        graphics2D->aniRank.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
        graphics2D->rankScale = FLOAT_TO_FX32(1.5);
        SetStageClearExState(work, StageClearEx_State_RankAppear);
    }
}

void StageClearEx_State_RankAppear(StageClearEx *work)
{
    StageClearExGraphics2D *graphics2D = &work->graphics2D;

    graphics2D->rankScale = Task__Unknown204BE48__LerpValue(FLOAT_TO_FX32(1.5), FLOAT_TO_FX32(1.0), (work->timer << 7), -FLOAT_TO_FX32(3.0));
    if (work->timer > 32)
    {
        graphics2D->rankScale = FLOAT_TO_FX32(1.0);
        PlaySystemSfx(SND_SYS_SEQARC_ARC_CLEAR_E, SND_SYS_SEQARC_ARC_CLEAR_E_SEQ_SE_RANKING);
        ShakeScreen(SCREENSHAKE_TINY_MIDDLE);
        SetStageClearExState(work, StageClearEx_State_RankGet);
    }
}

void StageClearEx_State_RankGet(StageClearEx *work)
{
    StageClearExGraphics2D *graphics2D = &work->graphics2D;

    graphics2D->rankPos.x = FX32_TO_WHOLE(GetScreenShakeOffsetX());
    graphics2D->rankPos.y = FX32_TO_WHOLE(GetScreenShakeOffsetY());

    if (ShakeScreen(SCREENSHAKE_GET_ACTIVE) == NULL)
    {
        SetStageClearExState(work, StageClearEx_State_ShowRank);
    }
}

void StageClearEx_State_ShowRank(StageClearEx *work)
{
    if (work->timer > 16)
    {
        SetStageClearExState(work, StageClearEx_State_DisplayResults);
    }
}

void StageClearEx_State_DisplayResults(StageClearEx *work)
{
    if ((padInput.btnPress & (PAD_BUTTON_Y | PAD_BUTTON_X | PAD_BUTTON_START | PAD_BUTTON_B | PAD_BUTTON_A)) != 0)
    {
        SetStageClearExState(work, StageClearEx_State_FadeOut);
        return;
    }

    if (work->timer > SECONDS_TO_FRAMES(2.0))
    {
        SetStageClearExState(work, StageClearEx_State_FadeOut);
        return;
    }
}

void StageClearEx_State_FadeOut(StageClearEx *work)
{
    SwapBuffer3D *camera             = GetSwapBuffer3DWork();
    RenderCoreGFXControl *gfxControl = &camera->gfxControl[0];

    for (; gfxControl != &camera->gfxControl[2]; gfxControl++)
    {
        gfxControl->brightness = Task__Unknown204BE48__LerpValue(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_BLACK, (work->timer << 7), FLOAT_TO_FX32(0.0));
    }

    if (work->timer == 32)
    {
        SaveGame__SetProgressType(SAVE_PROGRESSTYPE_9);
        RequestSysEventChange(0); // SYSEVENT_UPDATE_PROGRESS
        NextSysEvent();
        DestroyStageClearEx(work);
    }
}

void DrawNumberForStageClearEx(AnimatorSprite *aniNumbers, s16 x, s16 y, u16 spacing, u16 digitCount, BOOL showAll, u32 number)
{
    u32 i;
    AnimatorSprite *aniDigit;

    x += (spacing * digitCount);

    for (i = 0; i < digitCount; i++)
    {
        aniDigit = &aniNumbers[number % 10];

        x -= spacing;

        aniDigit->pos.x = x;
        aniDigit->pos.y = y;
        AnimatorSprite__DrawFrame(aniDigit);

        number /= 10;
        if (!showAll && number == 0)
            break;
    }
}

u32 CalcStageClearExTimeBonus(u32 time)
{
    for (u32 i = 0; i < ARRAY_COUNT(timeBonusThreshold); i++)
    {
        if (60 * timeBonusThreshold[i] <= time)
            return timeBonusScore[i];
    }

    return 45000;
}

u32 CalcStageClearExRingBonus(u32 rings)
{
    for (u32 i = 0; i < ARRAY_COUNT(ringBonusThreshold); i++)
    {
        if (rings < ringBonusThreshold[i])
            return ringBonusScore[i];
    }

    return 5000;
}

void Lerp_StageClearExScoreBonus(s32 type, TaskUnknown204BE48 *work, void *arg)
{
    if (type == 4)
    {
        PlaySystemSfx(SND_SYS_SEQARC_ARC_CLEAR_E, SND_SYS_SEQARC_ARC_CLEAR_E_SEQ_SE_FLAME_INDICATION);
    }
}

void Lerp_StageClearExScoreTotal(s32 type, TaskUnknown204BE48 *work, void *arg)
{
    StageClearEx *stageClear = (StageClearEx *)arg;

    if (type == 4)
    {
        PlaySystemSfx(SND_SYS_SEQARC_ARC_CLEAR_E, SND_SYS_SEQARC_ARC_CLEAR_E_SEQ_SE_FLAME_INDICATION);
        PlayHandleSystemSfx(stageClear->graphics2D.sndHandle, SND_SYS_SEQARC_ARC_CLEAR_E, SND_SYS_SEQARC_ARC_CLEAR_E_SEQ_SE_SCORE_INDICATION);
    }
}

void StageClearEx_Main_Core(void)
{
    StageClearEx *work = TaskGetWorkCurrent(StageClearEx);

    work->timer++;

    if (work->state != NULL)
        work->state(work);
}

void StageClearEx_Main_AnimationManager(void)
{
    StageClearEx *work = TaskGetWork(singleton, StageClearEx);

    HandleStageClearExAnimations(work);
}

void StageClearEx_Main_DrawManager(void)
{
    StageClearEx *work = TaskGetWork(singleton, StageClearEx);

    HandleStageClearExDrawing(work);
}

#include <nitro/codereset.h>