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
    Camera3D__Destroy();
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
    GetDrawStateCameraProjection(drawState, &cameraConfig->config);

    work->projectionY = cameraConfig->config.projScaleW + MultiplyFX(cameraConfig->config.projScaleW, 260);

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

NONMATCH_FUNC void InitStageClearExGraphics2D(StageClearExGraphics2D *work, StageClearExAssets *assets)
{
    // https://decomp.me/scratch/s8dpa -> 91.41%
#ifdef NON_MATCHING
    AnimatorSprite *animator;
    void *sprHUD;

    work->ringBonus  = StageClearEx__CalcRingBonus(playerGameStatus.ringBonus);
    work->timeBonus  = StageClearEx__CalcTimeBonus(playerGameStatus.stageTimer);
    work->totalScore = work->ringBonus + work->timeBonus;

    StageClearEx__LoadAssets(assets->archiveCldmEx, &sprHUD, ARCHIVE_CLDM_EX_LZ7_FILE_CLDM_EX_BAC, NULL);

    animator = &work->aniScorePlates[0];
    SpriteUnknown__Func_204C90C(animator, sprHUD, 10, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, FALSE,
                                SpriteUnknown__Func_204C3CC(sprHUD, FALSE, 10), PALETTE_ROW_1, SPRITE_PRIORITY_0, SPRITE_ORDER_14);

    animator = &work->aniScorePlates[1];
    SpriteUnknown__Func_204C90C(animator, sprHUD, 11, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, FALSE,
                                SpriteUnknown__Func_204C3CC(sprHUD, FALSE, 11), PALETTE_ROW_1, SPRITE_PRIORITY_0, SPRITE_ORDER_14);

    animator = &work->aniScoreBonusText[0];
    SpriteUnknown__Func_204C90C(animator, sprHUD, 23, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, FALSE,
                                SpriteUnknown__Func_204C3CC(sprHUD, FALSE, 23), PALETTE_ROW_4, SPRITE_PRIORITY_0, SPRITE_ORDER_10);
    animator->pos.x = -160;
    animator->pos.y = 132;

    animator = &work->aniScoreBonusText[1];
    SpriteUnknown__Func_204C90C(animator, sprHUD, 25, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, FALSE,
                                SpriteUnknown__Func_204C3CC(sprHUD, FALSE, 25), PALETTE_ROW_4, SPRITE_PRIORITY_0, SPRITE_ORDER_10);
    animator->pos.x = -160;
    animator->pos.y = 152;

    animator = &work->aniScoreBonusText[2];
    SpriteUnknown__Func_204C90C(animator, sprHUD, 27, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, FALSE,
                                SpriteUnknown__Func_204C3CC(sprHUD, FALSE, 27), PALETTE_ROW_4, SPRITE_PRIORITY_0, SPRITE_ORDER_10);
    work->scoreTotalPos.x = -160;
    work->scoreTotalPos.y = 172;

    work->showAllScoreDigits = TRUE;
    animator                 = &work->aniNumbers[0];
    for (u32 i = 0; i < 10; i++)
    {
        SpriteUnknown__Func_204C90C(animator, sprHUD, i, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, FALSE,
                                    SpriteUnknown__Func_204C3CC(sprHUD, FALSE, i), PALETTE_ROW_5, SPRITE_PRIORITY_0, SPRITE_ORDER_12);

        animator++;
    }

    animator = &work->aniNameBackdrop;
    SpriteUnknown__Func_204C90C(animator, sprHUD, 12, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, FALSE,
                                SpriteUnknown__Func_204C3CC(sprHUD, FALSE, 12), PALETTE_ROW_6, SPRITE_PRIORITY_0, SPRITE_ORDER_6);

    animator = &work->aniPlayerName;
    SpriteUnknown__Func_204C90C(animator, sprHUD, 33, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, FALSE,
                                SpriteUnknown__Func_204C3CC(sprHUD, FALSE, 33), PALETTE_ROW_1, SPRITE_PRIORITY_0, SPRITE_ORDER_4);

    animator = &work->aniZoneName;
    SpriteUnknown__Func_204C90C(animator, sprHUD, 32, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, FALSE,
                                SpriteUnknown__Func_204C3CC(sprHUD, FALSE, 32), PALETTE_ROW_1, SPRITE_PRIORITY_0, SPRITE_ORDER_4);
    work->namePos.x = 0;
    work->namePos.y = -0x16000;

    animator = &work->aniRankBorder;
    SpriteUnknown__Func_204C90C(animator, sprHUD, 13, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_DRAW, FALSE,
                                SpriteUnknown__Func_204C3CC(sprHUD, FALSE, 13), PALETTE_ROW_2, SPRITE_PRIORITY_0, SPRITE_ORDER_12);
    animator->pos.x = 192;
    animator->pos.y = 96;

    u16 rankAnim;
    if (work->totalScore >= 50000)
    {
        rankAnim = 28;
    }
    else if (work->totalScore >= 40000)
    {
        rankAnim = 29;
    }
    else if (work->totalScore >= 20000)
    {
        rankAnim = 30;
    }
    else
    {
        rankAnim = 31;
    }

    animator = &work->aniRank;
    SpriteUnknown__Func_204C90C(animator, sprHUD, rankAnim,
                                ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_DRAW, FALSE,
                                SpriteUnknown__Func_204C3CC(sprHUD, FALSE, rankAnim), PALETTE_ROW_3, SPRITE_PRIORITY_0, SPRITE_ORDER_10);
    animator->pos.x = 192;
    animator->pos.y = 96;

    work->seqPlayer = AllocSndHandle();

    SaveGame__UpdateStageRecord(22, work->totalScore, rankAnim - 28);
#else
    // clang-format off
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	mov r5, r0
	ldr r0, =playerGameStatus
	mov r4, r1
	ldr r0, [r0, #0x1c]
	bl CalcStageClearExRingBonus
	ldr r1, =0x00000808
	str r0, [r5, r1]
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	bl CalcStageClearExTimeBonus
	ldr r1, =0x0000080C
	str r0, [r5, r1]
	sub r0, r1, #4
	ldr r2, [r5, r0]
	ldr r0, [r5, r1]
	add r2, r2, r0
	add r0, r1, #4
	str r2, [r5, r0]
	mov r2, #0
	ldr r0, [r4, #4]
	add r1, sp, #0x14
	mov r3, r2
	bl LoadAssetsForStageClearEx
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0xa
	ldr r4, =0x00000528
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xe
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0xa
	bl SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0xb
	add r4, #0x64
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xe
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0xb
	bl SpriteUnknown__Func_204C90C
	mov r4, #0x3f
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x17
	lsl r4, r4, #4
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0x17
	bl SpriteUnknown__Func_204C90C
	ldr r4, =0x0000051C
	mov r0, #0x9f
	add r1, r5, r4
	mvn r0, r0
	strh r0, [r1]
	mov r0, #0x84
	strh r0, [r1, #2]
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x19
	sub r4, #0xc8
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0x19
	bl SpriteUnknown__Func_204C90C
	mov r0, #0x52
	lsl r0, r0, #4
	add r1, r5, r0
	mov r0, #0x9f
	mvn r0, r0
	strh r0, [r1]
	mov r0, #0x98
	strh r0, [r1, #2]
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x1b
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #4
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r0, =0x000004B8
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r0
	mov r2, #0x1b
	bl SpriteUnknown__Func_204C90C
	ldr r0, =0x00000524
	mov r6, r5
	add r1, r5, r0
	mov r0, #0x9f
	mvn r0, r0
	strh r0, [r1]
	mov r0, #0xac
	strh r0, [r1, #2]
	ldr r0, =0x0000081C
	mov r1, #1
	str r1, [r5, r0]
	mov r4, #0
	add r6, #8
_02154252:
	lsl r0, r4, #0x10
	lsr r7, r0, #0x10
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, r7
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #5
	str r0, [sp, #8]
	mov r0, r1
	str r0, [sp, #0xc]
	mov r0, #0xc
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	mov r0, r6
	mov r2, r7
	bl SpriteUnknown__Func_204C90C
	add r4, r4, #1
	add r6, #0x64
	cmp r4, #0xa
	blo _02154252
	ldr r0, [sp, #0x14]
	mov r4, #0x5f
	mov r1, #0
	mov r2, #0xc
	lsl r4, r4, #4
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #6
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0xc
	bl SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x21
	add r4, #0x64
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #4
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0x21
	bl SpriteUnknown__Func_204C90C
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, #0x20
	ldr r4, =0x000006B8
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #1
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #4
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000804
	add r0, r5, r4
	mov r2, #0x20
	bl SpriteUnknown__Func_204C90C
	mov r2, r4
	add r2, #0x68
	mov r1, #0
	ldr r3, =0xFFFEA000
	str r1, [r5, r2]
	add r0, r2, #4
	str r3, [r5, r0]
	add r2, #0xc
	add r4, r5, r2
	ldr r0, [sp, #0x14]
	mov r2, #0xd
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #2
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xc
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000805
	mov r0, r4
	mov r2, #0xd
	bl SpriteUnknown__Func_204C90C
	mov r0, #0xc0
	strh r0, [r4, #8]
	mov r0, #0x60
	strh r0, [r4, #0xa]
	mov r0, #0x81
	lsl r0, r0, #4
	ldr r1, [r5, r0]
	ldr r0, =0x0000C350
	cmp r1, r0
	blo _0215434C
	mov r4, #0x1c
	b _02154362
_0215434C:
	ldr r0, =0x00009C40
	cmp r1, r0
	blo _02154356
	mov r4, #0x1d
	b _02154362
_02154356:
	lsr r0, r0, #1
	cmp r1, r0
	blo _02154360
	mov r4, #0x1e
	b _02154362
_02154360:
	mov r4, #0x1f
_02154362:
	mov r0, #0x79
	lsl r0, r0, #4
	add r6, r5, r0
	ldr r0, [sp, #0x14]
	mov r1, #0
	mov r2, r4
	bl SpriteUnknown__Func_204C3CC
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #3
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	mov r0, #0xa
	str r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	ldr r3, =0x00000A05
	mov r0, r6
	mov r2, r4
	bl SpriteUnknown__Func_204C90C
	mov r0, #0xc0
	strh r0, [r6, #8]
	mov r0, #0x60
	strh r0, [r6, #0xa]
	bl AllocSndHandle
	mov r1, #0x81
	str r0, [r5, #4]
	lsl r1, r1, #4
	sub r4, #0x1c
	ldr r1, [r5, r1]
	mov r0, #0x16
	mov r2, r4
	bl SaveGame__UpdateStageRecord
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void ReleaseStageClearExGraphics2D(StageClearExGraphics2D *work)
{
    FreeSndHandle(work->seqPlayer);

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

NONMATCH_FUNC void HandleStageClearExDrawing(StageClearEx *work)
{
    // https://decomp.me/scratch/3JkJ6 -> 94.68%
#ifdef NON_MATCHING
    StageClearExGraphics3D *graphics3D = &work->graphics3D;

    Camera3D *camera = &graphics3D->cameraConfig;
    if (Camera3D__UseEngineA())
    {
        camera->config.matProjPosition.y = -graphics3D->projectionY;
        Camera3D__LoadState(&graphics3D->cameraConfig);
    }
    else
    {
        camera->config.matProjPosition.y = graphics3D->projectionY;
        Camera3D__LoadState(&graphics3D->cameraConfig);
    }

    for (AnimatorMDL *ani = &graphics3D->aniModels[0]; ani != &graphics3D->aniModels[7]; ani++)
    {
        AnimatorMDL__Draw(ani);
    }

    StageClearExGraphics2D *graphics2D = &work->graphics2D;
    if (Camera3D__UseEngineA())
    {
        AnimatorSprite *aniNameBackdrop = &graphics2D->aniNameBackdrop;
        aniNameBackdrop->pos.x          = FX32_TO_WHOLE(graphics2D->namePos.x);
        aniNameBackdrop->pos.y          = FX32_TO_WHOLE(graphics2D->namePos.y);
        AnimatorSprite__DrawFrame(aniNameBackdrop);

        AnimatorSprite *aniZoneName = &graphics2D->aniZoneName;
        aniZoneName->pos32          = aniNameBackdrop->pos32;
        if (graphics2D->showPlayerName)
            AnimatorSprite__DrawFrame(aniZoneName);

        aniNameBackdrop->pos.x -= HW_LCD_WIDTH;
        AnimatorSprite__DrawFrame(aniNameBackdrop);

        aniZoneName->pos.x -= HW_LCD_WIDTH;
        AnimatorSprite__DrawFrame(aniZoneName);

        AnimatorSprite *aniScoreBonusPlate = &graphics2D->aniScoreBonusPlate;
        Vec2Fx16 *scoreBonusPos            = &graphics2D->scoreBonusPos[0];
        aniScoreBonusPlate->pos.x          = scoreBonusPos->x + 8;
        aniScoreBonusPlate->pos.y          = scoreBonusPos->y;
        AnimatorSprite__DrawFrame(aniScoreBonusPlate);

        AnimatorSprite *aniTimeBonus = &graphics2D->aniScoreBonusText[0];
        aniTimeBonus->pos.x          = scoreBonusPos->x;
        aniTimeBonus->pos.y          = scoreBonusPos->y - 8;
        AnimatorSprite__DrawFrame(graphics2D->aniScoreBonusText);

        DrawNumberForStageClearEx(graphics2D->aniNumbers, scoreBonusPos->x + 88, scoreBonusPos->y - 2, 8, 6u, 0, graphics2D->ringBonus);

        scoreBonusPos             = &graphics2D->scoreBonusPos[1];
        aniScoreBonusPlate->pos.x = scoreBonusPos->x + 8;
        aniScoreBonusPlate->pos.y = scoreBonusPos->y;
        AnimatorSprite__DrawFrame(aniScoreBonusPlate);

        AnimatorSprite *aniRingBonus = &graphics2D->aniScoreBonusText[1];
        aniRingBonus->pos.x          = scoreBonusPos->x;
        aniRingBonus->pos.y          = scoreBonusPos->y - 48;
        AnimatorSprite__DrawFrame(&graphics2D->aniScoreBonusText[1]);

        DrawNumberForStageClearEx(graphics2D->aniNumbers, scoreBonusPos->x + 88, scoreBonusPos->y - 2, 8, 6u, 0, graphics2D->timeBonus);

        u32 i;
        u32 hiddenDigitCount = graphics2D->scoreRandDigitCount;
        u32 hiddenDigitBase  = 1;
        i                    = 0;
        while (i < hiddenDigitCount)
        {
            i++;
            hiddenDigitBase *= 10;
        }

        u32 trueScore = graphics2D->totalScore;
        u32 scoreMask = graphics2D->scoreRandDisplay;
        s32 score     = (trueScore / hiddenDigitBase);
        score += (scoreMask / hiddenDigitBase) * hiddenDigitBase;

        AnimatorSprite *aniScoreTotalPlate = &graphics2D->aniScoreTotalPlate;
        Vec2Fx16 *scoreTotalPos            = &graphics2D->scoreTotalPos;
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
        aniPlayerName->pos32          = aniNameBackdrop->pos32;
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
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r7, r0
	mov r4, r7
	ldr r0, =0x000008E8
	add r4, #0x1c
	add r5, r4, r0
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldr r0, =0x00000938
	beq _021545A8
	ldr r1, [r4, r0]
	sub r0, #0x50
	neg r1, r1
	add r0, r4, r0
	str r1, [r5, #0x18]
	bl Camera3D__LoadState
	b _021545B4
_021545A8:
	ldr r1, [r4, r0]
	sub r0, #0x50
	add r0, r4, r0
	str r1, [r5, #0x18]
	bl Camera3D__LoadState
_021545B4:
	ldr r0, =0x000008E8
	mov r5, r4
	add r5, #0xc
	add r4, r4, r0
	cmp r5, r4
	beq _021545D0
	mov r6, #0x51
	lsl r6, r6, #2
_021545C4:
	mov r0, r5
	bl AnimatorMDL__Draw
	add r5, r5, r6
	cmp r5, r4
	bne _021545C4
_021545D0:
	ldr r0, =0x00000958
	add r4, r7, r0
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _021545DE
	b _0215477E
_021545DE:
	mov r0, #0x5f
	lsl r0, r0, #4
	add r5, r4, r0
	mov r0, #0x72
	lsl r0, r0, #4
	ldr r1, [r4, r0]
	add r0, r0, #4
	asr r1, r1, #0xc
	strh r1, [r5, #8]
	ldr r0, [r4, r0]
	asr r0, r0, #0xc
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, =0x000006B8
	ldr r1, [r5, #8]
	add r6, r4, r0
	str r1, [r6, #8]
	add r0, #0x64
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _02154612
	mov r0, r6
	bl AnimatorSprite__DrawFrame
_02154612:
	mov r0, #8
	ldrsh r1, [r5, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r5, #8]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r1, [r6, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r6, #8]
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x0000051C
	mov r0, r1
	add r0, #0xc
	add r5, r4, r0
	ldrsh r0, [r4, r1]
	add r6, r4, r1
	add r0, #8
	strh r0, [r5, #8]
	mov r0, #2
	ldrsh r0, [r6, r0]
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x0000051C
	mov r0, #0x3f
	lsl r0, r0, #4
	ldrsh r1, [r4, r1]
	add r0, r4, r0
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	sub r1, #8
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, #6
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldr r0, =0x00000808
	ldr r1, =0x0000051C
	ldr r0, [r4, r0]
	mov r2, #2
	str r0, [sp, #8]
	ldrsh r1, [r4, r1]
	ldrsh r2, [r6, r2]
	mov r0, r4
	add r1, #0x58
	sub r2, r2, #2
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	add r0, #8
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	mov r3, #8
	bl DrawNumberForStageClearEx
	mov r0, #0x52
	lsl r0, r0, #4
	add r6, r4, r0
	ldrsh r0, [r4, r0]
	add r0, #8
	strh r0, [r5, #8]
	mov r0, #2
	ldrsh r0, [r6, r0]
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x00000454
	add r0, r4, r1
	add r1, #0xcc
	ldrsh r1, [r4, r1]
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r6, r1]
	sub r1, #0x30
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, #6
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	ldr r0, =0x0000080C
	mov r1, #0x52
	ldr r0, [r4, r0]
	lsl r1, r1, #4
	str r0, [sp, #8]
	mov r2, #2
	ldrsh r1, [r4, r1]
	ldrsh r2, [r6, r2]
	mov r0, r4
	add r1, #0x58
	sub r2, r2, #2
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	add r0, #8
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	mov r3, #8
	bl DrawNumberForStageClearEx
	ldr r0, =0x00000818
	mov r5, #1
	ldrh r2, [r4, r0]
	mov r1, #0
	cmp r2, #0
	bls _02154704
	mov r0, #0xa
_021546FC:
	add r1, r1, #1
	mul r5, r0
	cmp r1, r2
	blo _021546FC
_02154704:
	mov r0, #0x81
	lsl r0, r0, #4
	ldr r0, [r4, r0]
	mov r1, r5
	bl _u32_div_f
	ldr r0, =0x00000814
	mov r6, r1
	ldr r0, [r4, r0]
	mov r1, r5
	bl _u32_div_f
	mul r0, r5
	ldr r1, =0x00000524
	add r6, r6, r0
	mov r0, r1
	add r5, r4, r1
	ldrsh r1, [r4, r1]
	add r0, #0x68
	add r0, r4, r0
	add r1, #8
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r5, r1]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x000004B8
	add r0, r4, r1
	add r1, #0x6c
	ldrsh r1, [r4, r1]
	strh r1, [r0, #8]
	mov r1, #2
	ldrsh r1, [r5, r1]
	sub r1, #0x58
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	mov r0, #6
	str r0, [sp]
	ldr r0, =0x0000081C
	ldr r1, =0x00000524
	ldr r0, [r4, r0]
	mov r2, #2
	str r0, [sp, #4]
	str r6, [sp, #8]
	ldrsh r1, [r4, r1]
	ldrsh r2, [r5, r2]
	mov r0, r4
	add r1, #0x58
	sub r2, r2, #2
	lsl r1, r1, #0x10
	lsl r2, r2, #0x10
	add r0, #8
	asr r1, r1, #0x10
	asr r2, r2, #0x10
	mov r3, #8
	bl DrawNumberForStageClearEx
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_0215477E:
	mov r0, #0x5f
	lsl r0, r0, #4
	add r5, r4, r0
	mov r0, #0x72
	lsl r0, r0, #4
	ldr r1, [r4, r0]
	add r0, r0, #4
	asr r2, r1, #0xc
	mov r1, #1
	lsl r1, r1, #8
	sub r1, r1, r2
	strh r1, [r5, #8]
	ldr r0, [r4, r0]
	asr r1, r0, #0xc
	mov r0, #0xc0
	sub r0, r0, r1
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, =0x00000654
	add r6, r4, r0
	ldr r0, [r5, #8]
	str r0, [r6, #8]
	mov r0, r6
	bl AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r1, [r5, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r5, #8]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r0, =0x0000071C
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _021547DC
	mov r0, #8
	ldrsh r1, [r6, r0]
	add r0, #0xf8
	sub r0, r1, r0
	strh r0, [r6, #8]
	mov r0, r6
	bl AnimatorSprite__DrawFrame
_021547DC:
	ldr r1, =0x000007F4
	mov r0, #1
	ldr r2, [r4, r1]
	lsl r0, r0, #0xc
	cmp r2, r0
	beq _02154804
	sub r1, #0xc8
	add r0, r4, r1
	bl AnimatorSprite__DrawFrame
	ldr r0, =0x000007F4
	mov r3, #0
	ldr r1, [r4, r0]
	sub r0, #0x64
	add r0, r4, r0
	mov r2, r1
	bl AnimatorSprite__DrawFrameRotoZoom
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
_02154804:
	mov r0, r1
	sub r0, #0xc8
	add r5, r4, r0
	mov r0, #8
	ldrsh r2, [r5, r0]
	add r0, r1, #4
	ldrsh r0, [r4, r0]
	add r0, r2, r0
	strh r0, [r5, #8]
	mov r0, #0xa
	ldrsh r2, [r5, r0]
	add r0, r1, #6
	ldrsh r0, [r4, r0]
	add r0, r2, r0
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	ldr r1, =0x000007F8
	mov r0, #8
	ldrsh r3, [r5, r0]
	ldrsh r2, [r4, r1]
	add r6, r1, #2
	sub r2, r3, r2
	strh r2, [r5, #8]
	mov r2, #0xa
	ldrsh r3, [r5, r2]
	ldrsh r6, [r4, r6]
	sub r3, r3, r6
	strh r3, [r5, #0xa]
	mov r3, r1
	sub r3, #0x68
	add r5, r4, r3
	ldrsh r3, [r5, r0]
	ldrsh r0, [r4, r1]
	sub r0, r3, r0
	strh r0, [r5, #8]
	add r0, r1, #2
	ldrsh r2, [r5, r2]
	ldrsh r0, [r4, r0]
	sub r0, r2, r0
	strh r0, [r5, #0xa]
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	mov r0, #8
	ldrsh r2, [r5, r0]
	ldr r0, =0x000007F8
	ldrsh r1, [r4, r0]
	add r0, r0, #2
	add r1, r2, r1
	strh r1, [r5, #8]
	mov r1, #0xa
	ldrsh r1, [r5, r1]
	ldrsh r0, [r4, r0]
	add r0, r1, r0
	strh r0, [r5, #0xa]
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop

// clang-format on
#endif
}

void StageClearEx_State_Init(StageClearEx *work)
{
    Camera3D__Create();

    Camera3DTask *camera3D             = Camera3D__GetWork();
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
    Camera3DTask *camera             = Camera3D__GetWork();
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
    if (work->timer > 180)
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
    if (work->timer > 120)
    {
        SetStageClearExState(work, StageClearEx_State_InitScore);
    }
}

NONMATCH_FUNC void StageClearEx_State_InitScore(StageClearEx *work)
{
    // https://decomp.me/scratch/brIFL -> 84.87%
#ifdef NON_MATCHING
    StageClearExGraphics2D *graphics2D = &work->graphics2D;

    graphics2D->scoreRandDigitCount = 0;

    u32 value                    = (mtMathRand() & 0xF);
    u32 value2                   = (mtMathRand());
    graphics2D->scoreRandDisplay = value2 | value;

    Task__Unknown204BE48__Create(&graphics2D->scoreBonusPos[0], 2, -160, 0, 0, 16, Task__Unknown204BE48__LerpValue, -FLOAT_TO_FX32(1.0), Lerp_StageClearExScoreBonus, work, 0,
                                 TASK_PRIORITY_UPDATE_LIST_START + 0x62, TASK_GROUP(0));
    Task__Unknown204BE48__Create(&graphics2D->scoreBonusPos[1], 2, -160, 0, 16, 16, Task__Unknown204BE48__LerpValue, -FLOAT_TO_FX32(1.0), Lerp_StageClearExScoreBonus, work, 0,
                                 TASK_PRIORITY_UPDATE_LIST_START + 0x62, TASK_GROUP(0));
    Task__Unknown204BE48__Create(&graphics2D->scoreTotalPos, 2, -160, 0, 32, 16, Task__Unknown204BE48__LerpValue, -FLOAT_TO_FX32(1.0), Lerp_StageClearExScoreTotal, work, 0,
                                 TASK_PRIORITY_UPDATE_LIST_START + 0x62, TASK_GROUP(0));

    SetStageClearExState(work, StageClearEx_State_EnterScores);
#else
    // clang-format off
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	mov r5, r0
	ldr r0, =0x00000958
	mov r3, #0
	add r4, r5, r0
	ldr r0, =0x00000818
	ldr r6, =_mt_math_rand
	strh r3, [r4, r0]
	ldr r1, [r6, #0]
	ldr r0, =0x00196225
	ldr r7, =0x3C6EF35F
	mul r0, r1
	add r1, r0, r7
	ldr r2, =0x00196225
	lsr r0, r1, #0x10
	mul r2, r1
	add r1, r2, r7
	str r1, [r6, #0]
	lsr r1, r1, #0x10
	lsl r0, r0, #0x10
	lsl r1, r1, #0x10
	lsr r2, r1, #0xc
	lsr r0, r0, #0x10
	mov r1, #0xf
	and r0, r1
	mov r1, r2
	orr r1, r0
	ldr r0, =0x00000818
	sub r0, r0, #4
	str r1, [r4, r0]
	mov r1, #2
	mov r2, r1
	str r3, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	ldr r0, =Task__Unknown204BE48__LerpValue
	sub r2, #0xa2
	str r0, [sp, #8]
	ldr r0, =0xFFFFF000
	str r0, [sp, #0xc]
	ldr r0, =Lerp_StageClearExScoreBonus
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x62
	str r0, [sp, #0x1c]
	ldr r0, =0x0000051C
	str r3, [sp, #0x20]
	add r0, r4, r0
	bl Task__Unknown204BE48__Create
	mov r0, #0x10
	str r0, [sp]
	str r0, [sp, #4]
	ldr r0, =Task__Unknown204BE48__LerpValue
	mov r1, #2
	str r0, [sp, #8]
	ldr r0, =0xFFFFF000
	mov r2, r1
	str r0, [sp, #0xc]
	ldr r0, =Lerp_StageClearExScoreBonus
	mov r3, #0
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x62
	str r0, [sp, #0x1c]
	mov r0, #0x52
	lsl r0, r0, #4
	add r0, r4, r0
	sub r2, #0xa2
	str r3, [sp, #0x20]
	bl Task__Unknown204BE48__Create
	mov r0, #0x20
	str r0, [sp]
	mov r0, #0x10
	str r0, [sp, #4]
	ldr r0, =Task__Unknown204BE48__LerpValue
	mov r1, #2
	str r0, [sp, #8]
	ldr r0, =0xFFFFF000
	mov r2, r1
	str r0, [sp, #0xc]
	ldr r0, =Lerp_StageClearExScoreTotal
	mov r3, #0
	str r0, [sp, #0x10]
	str r5, [sp, #0x14]
	str r3, [sp, #0x18]
	mov r0, #0x62
	str r0, [sp, #0x1c]
	ldr r0, =0x00000524
	sub r2, #0xa2
	add r0, r4, r0
	str r3, [sp, #0x20]
	bl Task__Unknown204BE48__Create
	ldr r1, =StageClearEx_State_EnterScores
	mov r0, r5
	bl SetStageClearExState
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}

// clang-format on
#endif
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
        StopStageSfx(graphics2D->seqPlayer);
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
    if (work->timer > 30)
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
        ShakeScreen(SCREENSHAKE_A_LONG);
        SetStageClearExState(work, StageClearEx_State_RankGet);
    }
}

void StageClearEx_State_RankGet(StageClearEx *work)
{
    StageClearExGraphics2D *graphics2D = &work->graphics2D;

    graphics2D->rankPos.x = FX32_TO_WHOLE(GetScreenShakeOffsetX());
    graphics2D->rankPos.y = FX32_TO_WHOLE(GetScreenShakeOffsetY());

    if (!ShakeScreen(SCREENSHAKE_CUSTOM))
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

    if (work->timer > 120)
    {
        SetStageClearExState(work, StageClearEx_State_FadeOut);
        return;
    }
}

void StageClearEx_State_FadeOut(StageClearEx *work)
{
    Camera3DTask *camera             = Camera3D__GetWork();
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
    for (u32 i = 0; i < 8; i++)
    {
        if (60 * timeBonusThreshold[i] <= time)
            return timeBonusScore[i];
    }

    return 45000;
}

u32 CalcStageClearExRingBonus(u32 rings)
{
    for (u32 i = 0; i < 8; i++)
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
        PlayHandleSystemSfx(stageClear->graphics2D.seqPlayer, SND_SYS_SEQARC_ARC_CLEAR_E, SND_SYS_SEQARC_ARC_CLEAR_E_SEQ_SE_SCORE_INDICATION);
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