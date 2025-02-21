#include <stage/core/hud.h>
#include <stage/player/player.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/stage/mapSys.h>
#include <game/object/objectManager.h>
#include <game/util/akUtil.h>
#include <game/graphics/drawReqTask.h>
#include <game/audio/audioSystem.h>
#include <network/wirelessManager.h>

// --------------------
// STRUCTS
// --------------------

struct HUDDigitVRAMPixels
{
    VRAMPixelKey engineA;
    VRAMPixelKey engineB;
};

// --------------------
// VARIABLES
// --------------------

static CheckpointTimeHUD *checkpointTime;
static HUD *hudWorkSingleton;
static s32 lapID;
static LapTimeHUD *lapTimes;

NOT_DECOMPILED u16 bossGaugeNameAnimIDs[3];
NOT_DECOMPILED u16 tensionGaugeColors[5];
NOT_DECOMPILED u32 bossGaugeNameVRAMPixels[3];
NOT_DECOMPILED void *HUD__ringDigitTable;
NOT_DECOMPILED void *HUD__uiElementAnimID;
NOT_DECOMPILED void *HUD__uiElementPaletteRow;
NOT_DECOMPILED const u16 bossGaugeAnimIDs[13];

NOT_DECOMPILED const char *aAcFixBac;
NOT_DECOMPILED const char *aAcFixContBac_0;

// static const u16 bossGaugeNameAnimIDs[3] = { 10, 11, 12 };
// static const u16 bossGaugeNameVRAMPixels[3] = { 10, 11, 12 };
// static const GXRgb tensionGaugeColors[] = { GX_RGB_888(0xF8, 0xF8, 0xF8), GX_RGB_888(0x00, 0xA0, 0xF8), GX_RGB_888(0xF8, 0xA0, 0x00), GX_RGB_888(0xF8, 0x00, 0x00),
// GX_RGB_888(0xF8, 0xD0, 0x00) };

// static const u16 bossGaugeAnimIDs[13] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };

// --------------------
// FUNCTION DECLS
// --------------------

// HUD
static void HUD_Destructor(Task *task);
static void HUD_Main(void);
static fx32 GetNextHUDTensionScale(s16 distance);
static void UpdateTensionGaugeHUDState(HUD *work);
static void DrawTensionGaugeHUD(HUD *work);

// BossGaugeHUD
static void CreateBossGaugeHUD(BossGaugeHUD *work);
static void LoadBossGaugeAssets(BossGaugeHUD *work);
static void BossGaugeHUD_Destructor(BossGaugeHUD *work);
static void BossGaugeHUD_Main(BossGaugeHUD *work);
static void BossGaugeHUD_Draw(BossGaugeHUD *work);
static void CalculateBossGaugeSegmentFrames(BossGaugeHUD *work, s32 health, u32 *segmentAnimID, s32 count);

// CheckpointTimeHUD
static void CheckpointTimeHUD_Destructor(Task *task);
static void CheckpointTimeHUD_Main(void);

// LapTimeHUD
static void LapTimeHUD_Destructor(Task *task);
static void LapTimeHUD_Main(void);

// ConnectionStatusHUD
static void ConnectionStatusHUD_Destructor(Task *task);
static void ConnectionStatusHUD_Main(void);

// TargetIndicatorHUD
static void TargetIndicatorHUD_Destructor(Task *task);
static void TargetIndicatorHUD_Main(void);

// RaceProgressHUD
static void RaceProgressHUD_Destructor(Task *task);
static void RaceProgressHUD_Main(void);

// PassFlagMissionHUD
static void CreatePassFlagMissionHUD(void);
static void PassFlagMissionHUD_Destructor(Task *task);
static void PassFlagMissionHUD_Main(void);

// CollectRingsMissionHUD
static void CreateCollectRingsMissionHUD(void);
static void CollectRingsMissionHUD_Destructor(Task *task);
static void CollectRingsMissionHUD_Main(void);

// GenericQuotaMissionHUD
static void CreateGenericQuotaMissionHUD(void);
static void GenericQuotaMissionHUD_Destructor(Task *task);
static void GenericQuotaMissionHUD_Main(void);

// TimeAttackReplayHUD
static void CreateTimeAttackReplayHUD(void);
static void TimeAttackReplayHUD_Destructor(Task *task);
static void TimeAttackReplayHUD_Main(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE BOOL CheckHUDVisible(void)
{
    HUD *hud = hudWorkSingleton;
    return hud == NULL || (hud->flags & HUD_FLAG_VISIBLE) == 0;
}

RUSH_INLINE AnimatorSpriteDS *GetHUDAnimator(HUD *work, s32 id)
{
    return &work->animators[id];
}

// --------------------
// FUNCTIONS
// --------------------

// HUD
void CreateHUD(BOOL forStage)
{
    HUD *work;
    GameState *state = GetGameState();

    Task *task = TaskCreate(HUD_Main, HUD_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3), HUD);
    if (task == HeapNull)
        return;

    work = TaskGetWork(task, HUD);
    TaskInitWork16(work);

    hudWorkSingleton = work;

    for (s32 i = 0; i < 4; i++)
    {
        work->tensionScale[i] = FLOAT_TO_FX32(1.0);
    }

    if (state->gameMode == GAMEMODE_TIMEATTACK)
    {
        work->flags = HUD_FLAG_TENSION_GAUGE_VISIBLE;
    }
    else if (state->gameMode == GAMEMODE_VS_BATTLE)
    {
        work->flags = HUD_FLAG_TENSION_GAUGE_VISIBLE;
    }
    else if (state->gameMode == GAMEMODE_MISSION)
    {
        work->flags = HUD_FLAG_TENSION_GAUGE_VISIBLE;
    }
    else
    {
        work->flags = HUD_FLAG_4 | HUD_FLAG_TENSION_GAUGE_VISIBLE;
    }

    if (IsBossStage())
        CreateBossGaugeHUD(&work->bossManager);

    if (forStage)
        LoadHUDAssets();

    if (state->gameMode == GAMEMODE_MISSION)
    {
        if (state->missionType == MISSION_TYPE_PASS_FLAGS)
        {
            CreatePassFlagMissionHUD();
        }
        else if (state->missionType == MISSION_TYPE_COLLECT_RINGS)
        {
            CreateCollectRingsMissionHUD();
        }
        else if (state->missionType == MISSION_TYPE_DEFEAT_ENEMIES || state->missionType == MISSION_TYPE_PERFORM_TRICKS)
        {
            CreateGenericQuotaMissionHUD();
        }
    }
    else
    {
        if (gmCheckRaceStage() && !gmCheckRingBattle())
        {
            CreateGenericQuotaMissionHUD();
        }
        else
        {
            if (gmCheckReplayActive())
                CreateTimeAttackReplayHUD();
        }
    }
}

NONMATCH_FUNC BOOL LoadHUDAssets(void)
{
    // https://decomp.me/scratch/uWh12 -> 98.80%
#ifdef NON_MATCHING
    HUD *work = hudWorkSingleton;

    VRAMPixelKey vramPixelsA;
    VRAMPixelKey vramPixelsB;

    void *spriteFile;
    AnimatorSpriteDS *animator;
    u32 spriteSize;

    s32 i;

    void *contSpriteFile = NULL;
    s32 new_var;
    u32 screenFlags;

    u16 HUD__uiElementAnimID[HUD_ANIMATOR_COUNT_MAIN]     = { HUD_ANI_1, HUD_ANI_2, HUD_ANI_30, HUD_ANI_34, HUD_ANI_35, HUD_ANI_36, HUD_ANI_37, HUD_ANI_38, HUD_ANI_3, HUD_ANI_4 };
    u16 HUD__uiElementPaletteRow[HUD_ANIMATOR_COUNT_MAIN] = { 1, 0, 1, 0, 0, 0, 0, 0, 0, 0 };

    spriteFile = ObjDataLoad(NULL, "/ac_fix.bac", gameArchiveCommon);

    if (!IsBossStage() && gmCheckGameMode(GAMEMODE_VS_BATTLE))
        contSpriteFile = ObjDataLoad(NULL, "/ac_fix_cont.bac", gameArchiveCommon);

    s32 numberCount;
    if (gmCheckGameMode(GAMEMODE_VS_BATTLE) || gmCheckGameMode(GAMEMODE_MISSION))
        numberCount = 10;
    else
        numberCount = 21;

    // load all 10 digit sprites
    struct HUDDigitVRAMPixels *vramPixels = (struct HUDDigitVRAMPixels *)work->vramPixels;
    for (i = 0; i < numberCount; i++, vramPixels++)
    {
        AnimatorSpriteDS animator;

        spriteSize          = Sprite__GetSpriteSize2FromAnim(spriteFile, i + 5);
        vramPixels->engineA = VRAMSystem__AllocSpriteVram(FALSE, spriteSize);
        MI_CpuClear32(vramPixels->engineA, spriteSize << 6);

        if (IsBossStage())
        {
            screenFlags = SCREEN_DRAW_B;
        }
        else
        {
            vramPixels->engineB = VRAMSystem__AllocSpriteVram(TRUE, spriteSize);
            MI_CpuClear32(vramPixels->engineB, spriteSize << 6);

            screenFlags = SCREEN_DRAW_NONE;
        }

        AnimatorSpriteDS__Init(&animator, spriteFile, (i + HUD_ANI_5), screenFlags, ANIMATOR_FLAG_DISABLE_PALETTES, PIXEL_MODE_SPRITE, vramPixels->engineA, PALETTE_MODE_SPRITE,
                               VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, vramPixels->engineB, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        AnimatorSpriteDS__ProcessAnimationFast(&animator);
    }

    // load all 10 digit sprites
    for (i = 0; i < 10; i++)
    {
        animator = GetHUDAnimator(work, i);

        spriteSize = Sprite__GetSpriteSize2FromAnim(spriteFile, HUD__uiElementAnimID[i]);

        vramPixelsA = VRAMSystem__AllocSpriteVram(FALSE, spriteSize);

        if (IsBossStage())
        {
            vramPixelsB = NULL;
            screenFlags = SCREEN_DRAW_B;
        }
        else
        {
            vramPixelsB = VRAMSystem__AllocSpriteVram(TRUE, spriteSize);
            screenFlags = SCREEN_DRAW_NONE;
        }
        AnimatorSpriteDS__Init(animator, spriteFile, HUD__uiElementAnimID[i], screenFlags, 0, PIXEL_MODE_SPRITE, vramPixelsA, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE,
                               vramPixelsB, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_6);

        animator->cParam[0].palette = HUD__uiElementPaletteRow[i];
        animator->cParam[1].palette = HUD__uiElementPaletteRow[i];

        AnimatorSpriteDS__ProcessAnimationFast(animator);
        animator->screensToDraw |= SCREEN_DRAW_B;
    }

    // prepare digits animator
    AnimatorSpriteDS *userDigitsAnimator = &work->digitsAnimator;
    AnimatorSpriteDS__Init(userDigitsAnimator, spriteFile, HUD_ANI_5, 0, ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS, PIXEL_MODE_SPRITE,
                           work->vramPixels[0][0], PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, work->vramPixels[0][1], PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                           SPRITE_PRIORITY_0, SPRITE_ORDER_6);
    userDigitsAnimator->cParam[0].palette = PALETTE_ROW_0;
    userDigitsAnimator->cParam[1].palette = PALETTE_ROW_0;
    AnimatorSpriteDS__ProcessAnimationFast(userDigitsAnimator);

    // life count
    u16 playerBorderAniA;
    u16 playerBorderAniB;
    if (!gmCheckGameMode(GAMEMODE_VS_BATTLE) && !gmCheckGameMode(GAMEMODE_MISSION))
    {
        animator = &work->lifeNumAnimator;

        AnimatorSpriteDS__Init(animator, spriteFile, HUD_ANI_15, 0, ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_SPRITE_PARTS, PIXEL_MODE_SPRITE, work->vramPixels[10][0],
                               PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, work->vramPixels[10][1], PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0,
                               SPRITE_ORDER_6);
        animator->cParam[0].palette = PALETTE_ROW_0;
        animator->cParam[1].palette = PALETTE_ROW_0;
        AnimatorSpriteDS__ProcessAnimationFast(animator);
    }

    // Life icon
    s32 lifeIconAnim;
    u16 lifeIconAnim2;

    animator = GetHUDAnimator(work, HUD_ANIMATOR_PLAYER_ICON);

    if (gPlayer->characterID != CHARACTER_SONIC)
    {
        lifeIconAnim = HUD_ANI_29;
    }
    else
    {
        lifeIconAnim = HUD_ANI_28;
    }
    lifeIconAnim2 = lifeIconAnim;

    spriteSize  = Sprite__GetSpriteSize2FromAnim(spriteFile, lifeIconAnim2);
    vramPixelsA = VRAMSystem__AllocSpriteVram(FALSE, spriteSize);

    if (IsBossStage())
    {
        vramPixelsB = NULL;
        screenFlags = SCREEN_DRAW_B;
    }
    else
    {
        vramPixelsB = VRAMSystem__AllocSpriteVram(TRUE, spriteSize);
        screenFlags = SCREEN_DRAW_NONE;
    }

    AnimatorSpriteDS__Init(animator, spriteFile, lifeIconAnim2, screenFlags, 0, PIXEL_MODE_SPRITE, vramPixelsA, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, vramPixelsB,
                           PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_6);
    animator->cParam[0].palette = PALETTE_ROW_0;
    animator->cParam[1].palette = PALETTE_ROW_0;
    AnimatorSpriteDS__ProcessAnimationFast(animator);
    animator->screensToDraw = SCREEN_DRAW_B;

    // load ring display
    spriteSize = 16;
    if (!gmCheckRingBattle())
    {
        animator = GetHUDAnimator(work, HUD_ANIMATOR_RING_PANEL);

        vramPixelsA = VRAMSystem__AllocSpriteVram(FALSE, spriteSize);

        if (IsBossStage())
        {
            vramPixelsB = NULL;
            screenFlags = SCREEN_DRAW_B;
        }
        else
        {
            vramPixelsB = VRAMSystem__AllocSpriteVram(TRUE, spriteSize);
            screenFlags = SCREEN_DRAW_NONE;
        }

        AnimatorSpriteDS__Init(animator, spriteFile, HUD_ANI_0, screenFlags, 0, PIXEL_MODE_SPRITE, vramPixelsA, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, vramPixelsB,
                               PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_6);
        animator->cParam[0].palette = PALETTE_ROW_2;
        animator->cParam[1].palette = PALETTE_ROW_2;
        AnimatorSpriteDS__ProcessAnimationFast(animator);
        animator->screensToDraw = SCREEN_DRAW_B;
    }
    else
    {
        animator = GetHUDAnimator(work, HUD_ANIMATOR_PLAYER_BORDER);

        if (gPlayer->characterID == CHARACTER_SONIC)
        {
            playerBorderAniA = HUD_CONTANI_2;
            playerBorderAniB = HUD_CONTANI_3;
        }
        else
        {
            playerBorderAniA = HUD_CONTANI_3;
            playerBorderAniB = HUD_CONTANI_2;
        }

        new_var = PIXEL_MODE_SPRITE;
        work->animators[0].screensToDraw &= ~SCREEN_DRAW_B;
        vramPixelsA = VRAMSystem__AllocSpriteVram(FALSE, spriteSize);
        AnimatorSpriteDS__Init(animator, contSpriteFile, playerBorderAniA, SCREEN_DRAW_B, ANIMATOR_FLAG_DISABLE_PALETTES, new_var, vramPixelsA, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                               new_var, 0, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_6);
        animator->cParam[0].palette = PALETTE_ROW_0;
        animator->cParam[1].palette = PALETTE_ROW_0;
        AnimatorSpriteDS__ProcessAnimationFast(animator);

        AnimatorSpriteDS *playerBorderAnimatorB = GetHUDAnimator(work, HUD_ANIMATOR_PLAYER_BORDER2);
        vramPixelsB                             = VRAMSystem__AllocSpriteVram(TRUE, spriteSize);
        AnimatorSpriteDS__Init(playerBorderAnimatorB, contSpriteFile, playerBorderAniB, SCREEN_DRAW_A, ANIMATOR_FLAG_DISABLE_PALETTES, new_var, 0, PALETTE_MODE_SPRITE,
                               VRAM_OBJ_PLTT, new_var, vramPixelsB, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_6);
        playerBorderAnimatorB->cParam[0].palette = PALETTE_ROW_0;
        playerBorderAnimatorB->cParam[1].palette = PALETTE_ROW_0;
        AnimatorSpriteDS__ProcessAnimationFast(playerBorderAnimatorB);
    }

    // load race position sprites
    spriteSize = 4;
    if (gmCheckGameMode(GAMEMODE_VS_BATTLE))
    {
        animator = GetHUDAnimator(work, HUD_ANIMATOR_VS_POSITION);

        vramPixelsA = VRAMSystem__AllocSpriteVram(FALSE, spriteSize);

        if (IsBossStage())
        {
            vramPixelsB = NULL;
            screenFlags = SCREEN_DRAW_B;
        }
        else
        {
            vramPixelsB = VRAMSystem__AllocSpriteVram(TRUE, spriteSize);
            screenFlags = SCREEN_DRAW_NONE;
        }

        AnimatorSpriteDS__Init(animator, contSpriteFile, HUD_CONTANI_7, screenFlags, ANIMATOR_FLAG_DISABLE_PALETTES, new_var, vramPixelsA, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                               new_var, vramPixelsB, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_6);
        animator->cParam[0].palette = PALETTE_ROW_1;
        animator->cParam[1].palette = PALETTE_ROW_1;
        AnimatorSpriteDS__ProcessAnimationFast(animator);
        animator->screensToDraw = SCREEN_DRAW_B;
    }

    // load boss sprites
    if (IsBossStage())
        LoadBossGaugeAssets(&work->bossManager);

    work->loadedSprites = TRUE;
    return TRUE;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x104
	ldr r0, =lapID
	ldr r4, =HUD__uiElementAnimID
	ldr r5, [r0, #8]
	mov r0, #0
	add r3, sp, #0x4c
	str r0, [sp, #0x2c]
	mov r2, #5
_02034468:
	ldrh r1, [r4, #0]
	ldrh r0, [r4, #2]
	add r4, r4, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _02034468
	ldr r4, =HUD__uiElementPaletteRow
	add r3, sp, #0x38
	mov r2, #5
_02034494:
	ldrh r1, [r4, #0]
	ldrh r0, [r4, #2]
	add r4, r4, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _02034494
	ldr r0, =gameArchiveCommon
	ldr r1, =aAcFixBac
	ldr r2, [r0, #0]
	mov r0, #0
	bl ObjDataLoad
	mov r7, r0
	bl IsBossStage
	cmp r0, #0
	ldreq r0, =gameState
	ldreq r0, [r0, #0x14]
	cmpeq r0, #1
	bne _020344FC
	ldr r0, =gameArchiveCommon
	ldr r1, =0x02119530 // aAcFixContBac_0
	ldr r2, [r0, #0]
	mov r0, #0
	bl ObjDataLoad
	str r0, [sp, #0x2c]
_020344FC:
	ldr r0, =gameState
	mov r8, #0
	ldr r0, [r0, #0x14]
	cmp r0, #1
	cmpne r0, #3
	moveq r11, #0xa
	movne r11, #0x15
	add r0, r5, #0x2ec
	cmp r11, #0
	add r9, r0, #0x800
	ble _0203461C
	ldr r0, =0x05000200
	mov r4, r8
	add r0, r0, #0x400
	str r0, [sp, #0x30]
_02034538:
	add r1, r8, #5
	mov r1, r1, lsl #0x10
	mov r0, r7
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize2FromAnim
	mov r6, r0
	mov r0, #0
	mov r1, r6
	bl VRAMSystem__AllocSpriteVram
	str r0, [r9]
	mov r10, r6, lsl #6
	ldr r1, [r9, #0]
	mov r0, #0
	mov r2, r10
	bl MIi_CpuClear32
	bl IsBossStage
	cmp r0, #0
	movne r3, #2
	bne _020345A8
	mov r1, r6
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	str r0, [r9, #4]
	ldr r1, [r9, #4]
	mov r2, r10
	mov r0, #0
	bl MIi_CpuClear32
	mov r3, #0
_020345A8:
	mov r0, #0x10
	stmia sp, {r0, r4}
	ldr r1, [r9, #0]
	add r0, sp, #0x60
	str r1, [sp, #8]
	ldr r1, =0x05000200
	str r4, [sp, #0xc]
	str r1, [sp, #0x10]
	str r4, [sp, #0x14]
	ldr r2, [r9, #4]
	mov r1, r7
	str r2, [sp, #0x18]
	ldr r2, [sp, #0x30]
	str r4, [sp, #0x1c]
	str r2, [sp, #0x20]
	add r2, r8, #5
	mov r2, r2, lsl #0x10
	str r4, [sp, #0x24]
	mov r2, r2, lsr #0x10
	str r4, [sp, #0x28]
	bl AnimatorSpriteDS__Init
	mov r1, #0
	add r0, sp, #0x60
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	add r8, r8, #1
	cmp r8, r11
	add r9, r9, #8
	blt _02034538
_0203461C:
	ldr r0, =0x05000200
	mov r10, #0
	add r0, r0, #0x400
	add r8, r5, #8
	str r0, [sp, #0x34]
	mov r4, r10
_02034634:
	mov r1, r10, lsl #1
	add r0, sp, #0x4c
	ldrh r9, [r0, r1]
	mov r0, r7
	mov r1, r9
	bl Sprite__GetSpriteSize2FromAnim
	mov r11, r0
	mov r0, #0
	mov r1, r11
	bl VRAMSystem__AllocSpriteVram
	mov r6, r0
	bl IsBossStage
	cmp r0, #0
	movne r0, #0
	movne r3, #2
	bne _02034684
	mov r1, r11
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
_02034684:
	str r4, [sp]
	stmib sp, {r4, r6}
	ldr r1, =0x05000200
	str r4, [sp, #0xc]
	str r1, [sp, #0x10]
	str r4, [sp, #0x14]
	str r0, [sp, #0x18]
	ldr r0, [sp, #0x34]
	str r4, [sp, #0x1c]
	str r0, [sp, #0x20]
	str r4, [sp, #0x24]
	mov r0, #6
	str r0, [sp, #0x28]
	mov r2, r9
	mov r0, r8
	mov r1, r7
	bl AnimatorSpriteDS__Init
	mov r1, r10, lsl #1
	add r0, sp, #0x38
	ldrh r2, [r0, r1]
	mov r1, #0
	mov r0, r8
	strh r2, [r8, #0x90]
	strh r2, [r8, #0x92]
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	ldr r0, [r8, #0x64]
	add r10, r10, #1
	orr r0, r0, #2
	str r0, [r8, #0x64]
	cmp r10, #0xa
	add r8, r8, #0xa4
	blt _02034634
	mov r0, #0x18
	str r0, [sp]
	mov r3, #0
	str r3, [sp, #4]
	ldr r0, [r5, #0xaec]
	ldr r2, =0x05000200
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	ldr r1, [r5, #0xaf0]
	add r0, r5, #0x1a4
	str r1, [sp, #0x18]
	add r6, r0, #0x800
	add r0, r2, #0x400
	str r3, [sp, #0x1c]
	str r0, [sp, #0x20]
	mov r0, r6
	mov r1, r7
	str r3, [sp, #0x24]
	mov r4, #6
	mov r2, #5
	str r4, [sp, #0x28]
	bl AnimatorSpriteDS__Init
	mov r1, #0
	strh r1, [r6, #0x90]
	mov r0, r6
	mov r2, r1
	strh r1, [r6, #0x92]
	bl AnimatorSpriteDS__ProcessAnimation
	ldr r0, =gameState
	ldr r0, [r0, #0x14]
	cmp r0, #1
	cmpne r0, #3
	beq _02034808
	mov r0, #0x18
	str r0, [sp]
	mov r3, #0
	str r3, [sp, #4]
	ldr r0, [r5, #0xb3c]
	ldr r2, =0x05000200
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	ldr r1, [r5, #0xb40]
	add r0, r5, #0x248
	str r1, [sp, #0x18]
	add r6, r0, #0x800
	add r0, r2, #0x400
	str r3, [sp, #0x1c]
	str r0, [sp, #0x20]
	str r3, [sp, #0x24]
	mov r0, r6
	mov r1, r7
	mov r2, #0xf
	str r4, [sp, #0x28]
	bl AnimatorSpriteDS__Init
	mov r1, #0
	strh r1, [r6, #0x90]
	mov r0, r6
	mov r2, r1
	strh r1, [r6, #0x92]
	bl AnimatorSpriteDS__ProcessAnimation
_02034808:
	ldr r0, =gPlayer
	add r8, r5, #0x670
	ldr r0, [r0, #0]
	ldrb r0, [r0, #0x5d0]
	cmp r0, #0
	movne r0, #0x1d
	moveq r0, #0x1c
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	mov r0, r7
	mov r1, r4
	bl Sprite__GetSpriteSize2FromAnim
	mov r6, r0
	mov r1, r6
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r9, r0
	bl IsBossStage
	cmp r0, #0
	movne r0, #0
	movne r3, #2
	bne _02034870
	mov r1, r6
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
_02034870:
	mov r6, #0
	str r6, [sp]
	stmib sp, {r6, r9}
	ldr r1, =0x05000200
	str r6, [sp, #0xc]
	str r1, [sp, #0x10]
	str r6, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r1, #0x400
	str r6, [sp, #0x1c]
	str r0, [sp, #0x20]
	mov r2, r4
	mov r0, r8
	mov r1, r7
	str r6, [sp, #0x24]
	mov r4, #6
	str r4, [sp, #0x28]
	bl AnimatorSpriteDS__Init
	mov r1, r6
	strh r1, [r8, #0x90]
	mov r0, r8
	mov r2, r1
	strh r1, [r8, #0x92]
	bl AnimatorSpriteDS__ProcessAnimation
	mov r6, #2
	ldr r0, =gameState
	str r6, [r8, #0x64]
	ldr r1, [r0, #0x14]
	cmp r1, #1
	ldreq r0, [r0, #0x20]
	mov r1, #0x10
	cmpeq r0, #1
	beq _02034998
	add r2, r5, #0x314
	mov r0, #0
	add r4, r2, #0x400
	bl VRAMSystem__AllocSpriteVram
	mov r6, r0
	bl IsBossStage
	cmp r0, #0
	movne r0, #0
	movne r3, #2
	bne _0203492C
	mov r0, #1
	mov r1, #0x10
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
_0203492C:
	mov r2, #0
	str r2, [sp]
	stmib sp, {r2, r6}
	ldr r1, =0x05000200
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r1, #0x400
	str r2, [sp, #0x1c]
	str r0, [sp, #0x20]
	mov r0, r4
	mov r1, r7
	str r2, [sp, #0x24]
	mov r6, #6
	str r6, [sp, #0x28]
	bl AnimatorSpriteDS__Init
	mov r3, #2
	mov r1, #0
	strh r3, [r4, #0x90]
	mov r0, r4
	mov r2, r1
	strh r3, [r4, #0x92]
	bl AnimatorSpriteDS__ProcessAnimation
	mov r0, #2
	str r0, [r4, #0x64]
	b _02034ABC
_02034998:
	ldr r0, =gPlayer
	add r2, r5, #0x3b8
	ldr r0, [r0, #0]
	add r7, r2, #0x400
	ldrb r0, [r0, #0x5d0]
	cmp r0, #0
	ldr r0, [r5, #0x6c]
	moveq r4, r6
	bic r3, r0, #2
	mov r0, #0
	moveq r6, #3
	movne r4, #3
	str r3, [r5, #0x6c]
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0x10
	str r2, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r1, =0x05000200
	str r3, [sp, #0xc]
	str r1, [sp, #0x10]
	str r3, [sp, #0x14]
	str r3, [sp, #0x18]
	add r0, r1, #0x400
	str r3, [sp, #0x1c]
	str r0, [sp, #0x20]
	mov r2, r4
	str r3, [sp, #0x24]
	mov r4, #6
	ldr r1, [sp, #0x2c]
	mov r0, r7
	mov r3, #2
	str r4, [sp, #0x28]
	bl AnimatorSpriteDS__Init
	mov r1, #0
	strh r1, [r7, #0x90]
	mov r0, r7
	mov r2, r1
	strh r1, [r7, #0x92]
	bl AnimatorSpriteDS__ProcessAnimation
	add r0, r5, #0x5c
	add r4, r0, #0x800
	mov r0, #1
	mov r1, #0x10
	bl VRAMSystem__AllocSpriteVram
	mov r1, #0x10
	mov r2, r6
	str r1, [sp]
	mov r6, #0
	str r6, [sp, #4]
	str r6, [sp, #8]
	ldr r3, =0x05000200
	str r6, [sp, #0xc]
	str r3, [sp, #0x10]
	str r6, [sp, #0x14]
	str r0, [sp, #0x18]
	add r3, r3, #0x400
	str r6, [sp, #0x1c]
	str r3, [sp, #0x20]
	mov r1, #6
	str r6, [sp, #0x24]
	str r1, [sp, #0x28]
	ldr r1, [sp, #0x2c]
	mov r0, r4
	mov r3, #1
	bl AnimatorSpriteDS__Init
	mov r1, r6
	strh r1, [r4, #0x90]
	mov r0, r4
	mov r2, r1
	strh r1, [r4, #0x92]
	bl AnimatorSpriteDS__ProcessAnimation
_02034ABC:
	ldr r0, =gameState
	ldr r0, [r0, #0x14]
	cmp r0, #1
	bne _02034B74
	mov r0, #0
	mov r1, #4
	add r4, r5, #0x900
	bl VRAMSystem__AllocSpriteVram
	mov r6, r0
	bl IsBossStage
	cmp r0, #0
	movne r0, #0
	movne r3, #2
	bne _02034B04
	mov r0, #1
	mov r1, #4
	bl VRAMSystem__AllocSpriteVram
	mov r3, #0
_02034B04:
	mov r1, #0x10
	str r1, [sp]
	mov r2, #0
	stmib sp, {r2, r6}
	ldr r1, =0x05000200
	str r2, [sp, #0xc]
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	add r0, r1, #0x400
	str r2, [sp, #0x1c]
	str r0, [sp, #0x20]
	str r2, [sp, #0x24]
	mov r6, #6
	ldr r1, [sp, #0x2c]
	mov r0, r4
	mov r2, #7
	str r6, [sp, #0x28]
	bl AnimatorSpriteDS__Init
	mov r3, #1
	mov r1, #0
	strh r3, [r4, #0x90]
	mov r0, r4
	mov r2, r1
	strh r3, [r4, #0x92]
	bl AnimatorSpriteDS__ProcessAnimation
	mov r0, #2
	str r0, [r4, #0x64]
_02034B74:
	bl IsBossStage
	cmp r0, #0
	beq _02034B8C
	add r0, r5, #0x3bc
	add r0, r0, #0x800
	bl LoadBossGaugeAssets
_02034B8C:
	mov r0, #1
	str r0, [r5]
	add sp, sp, #0x104
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void SetHUDVisible(BOOL enabled)
{
    if (enabled)
        hudWorkSingleton->flags |= HUD_FLAG_VISIBLE;
    else
        hudWorkSingleton->flags &= ~HUD_FLAG_VISIBLE;
}

AnimatorSpriteDS *GetHUDTimeNumAnimator(u16 num, BOOL useAltPalette)
{
    if (hudWorkSingleton == NULL || !hudWorkSingleton->loadedSprites)
        return NULL;

    AnimatorSpriteDS *digitAnimator;
    if (num < 10)
    {
        digitAnimator = &hudWorkSingleton->digitsAnimator;

        digitAnimator->vramPixels[0] = hudWorkSingleton->vramPixels[num][0];
        digitAnimator->vramPixels[1] = hudWorkSingleton->vramPixels[num][1];
    }
    else
    {
        digitAnimator = &hudWorkSingleton->animators[num - 2];
    }

    if (useAltPalette == FALSE)
    {
        digitAnimator->cParam[0].palette = PALETTE_ROW_0;
        digitAnimator->cParam[1].palette = PALETTE_ROW_0;
    }
    else
    {
        digitAnimator->cParam[0].palette = PALETTE_ROW_1;
        digitAnimator->cParam[1].palette = PALETTE_ROW_1;
    }

    digitAnimator->work.flags &= ~(ANIMATOR_FLAG_DISABLE_DRAW | ANIMATOR_FLAG_FLIP_X | ANIMATOR_FLAG_FLIP_Y | ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_ENABLE_MOSAIC
                                   | ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_FORCE_AFFINE);
    return digitAnimator;
}

AnimatorSpriteDS *GetHUDLifeNumAnimator(u16 num, BOOL useAltPalette)
{
    if (hudWorkSingleton == NULL || !hudWorkSingleton->loadedSprites || gmCheckGameMode(GAMEMODE_VS_BATTLE) || gmCheckGameMode(GAMEMODE_MISSION))
        return NULL;

    AnimatorSpriteDS *digitAnimator = &hudWorkSingleton->lifeNumAnimator;

    digitAnimator->vramPixels[0] = hudWorkSingleton->vramPixels[num + 10][0];
    digitAnimator->vramPixels[1] = hudWorkSingleton->vramPixels[num + 10][1];

    if (useAltPalette == FALSE)
    {
        digitAnimator->cParam[0].palette = PALETTE_ROW_0;
        digitAnimator->cParam[1].palette = PALETTE_ROW_0;
    }
    else
    {
        digitAnimator->cParam[0].palette = PALETTE_ROW_1;
        digitAnimator->cParam[1].palette = PALETTE_ROW_1;
    }

    digitAnimator->work.flags &= ~(ANIMATOR_FLAG_DISABLE_DRAW | ANIMATOR_FLAG_FLIP_X | ANIMATOR_FLAG_FLIP_Y | ANIMATOR_FLAG_ENABLE_SCALE | ANIMATOR_FLAG_ENABLE_MOSAIC
                                   | ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_FORCE_AFFINE);
    return digitAnimator;
}

void UpdateTensionGaugeHUD(s32 tension, BOOL calledFromPlayer)
{
    HUD *work         = hudWorkSingleton;
    s32 cappedTension = tension;
    if (work == NULL)
        return;

    if (tension < 0)
        cappedTension = 0;

    if (work->targetTension < work->currentTension)
    {
        if (cappedTension > work->targetTension)
        {
            work->currentTension     = work->targetTension;
            work->targetTension      = cappedTension;
            work->tensionChangeTimer = 0;
            work->nextTensionScale   = GetNextHUDTensionScale((cappedTension - work->targetTension));
        }
        else
        {
            work->targetTension = cappedTension;
        }
    }
    else
    {
        if (work->targetTension > work->currentTension)
        {
            if (cappedTension >= work->targetTension)
            {
                s32 nextTensionScale = GetNextHUDTensionScale((cappedTension - work->targetTension));
                work->targetTension  = cappedTension;
                if (nextTensionScale > work->nextTensionScale)
                    work->nextTensionScale = nextTensionScale;
            }
            else
            {
                if (calledFromPlayer == TRUE)
                {
                    work->tensionGaugeShakeDuration = 40;
                    work->tensionGaugeShakeTimer    = 40;
                    work->currentTension            = work->targetTension;
                    work->targetTension             = cappedTension;
                    work->tensionChangeTimer        = 0;
                    work->nextTensionScale          = 0;
                    for (s32 t = 0; t < 4; t++)
                    {
                        work->tensionScale[t] = FLOAT_TO_FX32(1.0);
                    }
                }
                else
                {
                    work->targetTension      = cappedTension;
                    work->tensionChangeTimer = 0;
                }
            }
        }
        else
        {
            if (cappedTension < work->targetTension)
            {
                if (calledFromPlayer == TRUE)
                {
                    work->tensionGaugeShakeDuration = 40;
                    work->tensionGaugeShakeTimer    = 40;
                }

                work->nextTensionScale = FLOAT_TO_FX32(0.0);
                for (s32 t = 0; t < 4; t++)
                {
                    work->tensionScale[t] = FLOAT_TO_FX32(1.0);
                }
                work->tensionChangeTimer = 0;
            }
            else
            {
                if (cappedTension > work->targetTension)
                {
                    work->nextTensionScale   = GetNextHUDTensionScale((cappedTension - work->targetTension));
                    work->tensionChangeTimer = 0;
                }
            }

            work->targetTension = cappedTension;
        }
    }
}

void EnableHUDTensionMaxEffect(BOOL enabled)
{
    HUD *work = hudWorkSingleton;
    if (work == NULL)
        return;

    if (enabled)
        work->flags |= HUD_FLAG_TENSION_MAX_ENABLED;
    else
        work->flags &= ~HUD_FLAG_TENSION_MAX_ENABLED;
}

void SetHUDActiveScreen(GraphicsEngine engine)
{
    if (engine == GRAPHICS_ENGINE_A)
        hudWorkSingleton->flags |= HUD_FLAG_USE_SCREEN_B;
    else
        hudWorkSingleton->flags &= ~HUD_FLAG_USE_SCREEN_B;
}

GraphicsEngine GetHUDActiveScreen(void)
{
    HUD *work = hudWorkSingleton;

    GraphicsEngine result;
    if (work != NULL)
    {
        result = (work->flags & HUD_FLAG_USE_SCREEN_B) != 0 ? GRAPHICS_ENGINE_A : GRAPHICS_ENGINE_B;
    }
    else
    {
        result = GRAPHICS_ENGINE_B;
    }

    return result;
}

void UpdateBossHealthHUD(s32 health)
{
    hudWorkSingleton->bossManager.targetHealth = MTM_MATH_CLIP(health, HUD_BOSS_HEALTH_MIN, HUD_BOSS_HEALTH_MAX);
}

void SetBossHealthbarPosition(fx16 x, fx16 y)
{
    hudWorkSingleton->bossManager.position.x = x;
    hudWorkSingleton->bossManager.position.y = y;
}

void SetActiveBossHealthbar(s32 id)
{
    if (hudWorkSingleton->bossManager.activeHealthbar != id)
    {
        hudWorkSingleton->bossManager.displayHealth[hudWorkSingleton->bossManager.activeHealthbar] = hudWorkSingleton->bossManager.targetHealth;
        hudWorkSingleton->bossManager.targetHealth    = MTM_MATH_CLIP(hudWorkSingleton->bossManager.displayHealth[id], HUD_BOSS_HEALTH_MIN, HUD_BOSS_HEALTH_MAX);
        hudWorkSingleton->bossManager.activeHealthbar = id;
    }
}

void CreateCheckpointTimeHUD(u32 time)
{
    if (hudWorkSingleton == NULL)
        return;

    if (checkpointTime == NULL)
    {
        Task *task = TaskCreate(CheckpointTimeHUD_Main, CheckpointTimeHUD_Destructor, TASK_FLAG_NONE, 0, 0x4800u, TASK_GROUP(3), CheckpointTimeHUD);
        if (task == HeapNull)
            return;

        CheckpointTimeHUD *work = TaskGetWork(task, CheckpointTimeHUD);
        checkpointTime          = work;
        TaskInitWork16(work);
    }

    checkpointTime->timer = 180;
    checkpointTime->time  = time;
    AkUtilFrameToTime(time, &checkpointTime->minutes, &checkpointTime->seconds, &checkpointTime->centiseconds);
}

void CreateLapTimeHUD(void)
{
    if (hudWorkSingleton == NULL)
        return;

    lapID = 0;

    if (!gmCheckGameMode(GAMEMODE_TIMEATTACK) || lapTimes != NULL)
        return;

    Task *task = TaskCreate(LapTimeHUD_Main, LapTimeHUD_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3), LapTimeHUD);
    if (task == HeapNull)
        return;

    LapTimeHUD *work = TaskGetWork(task, LapTimeHUD);
    lapTimes         = work;
    TaskInitWork16(work);
}

void AddLapTimeToHUD(u32 id, u32 time)
{
    lapID = id + 1;
    if (lapTimes == NULL)
        return;

    if (id < 5)
        AkUtilFrameToTime(time, &lapTimes->minutes[id], &lapTimes->seconds[id], &lapTimes->milliseconds[id]);
}

void CreateConnectionStatusHUD(BOOL useDWC)
{
    Task *task =
        TaskCreate(ConnectionStatusHUD_Main, ConnectionStatusHUD_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3), ConnectionStatusHUD);
    if (task == HeapNull)
        return;

    ConnectionStatusHUD *work = TaskGetWork(task, ConnectionStatusHUD);
    TaskInitWork16(work);

    work->useDWC = useDWC;

    if (!useDWC)
    {
        work->animID        = HUD_CONTANI_24;
        work->lastLinkLevel = WirelessManager__GetLinkLevel();
    }
    else
    {
        work->animID        = HUD_CONTANI_29;
        work->lastLinkLevel = DWC_GetLinkLevel();
    }

    void *spriteFile = ObjDataLoad(NULL, "/ac_fix_cont.bac", gameArchiveCommon);

    AnimatorSpriteDS *ani;
    u16 i;
    u16 animID     = work->lastLinkLevel;
    u16 paletteRow = 1;
    for (i = 0; i < 2; i++)
    {
        ani = &work->animators[i];

        AnimatorSpriteDS__Init(ani, spriteFile, work->animID + animID, SCREEN_DRAW_A, ANIMATOR_FLAG_DISABLE_PALETTES, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, 2),
                               PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(TRUE, 2), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT,
                               SPRITE_PRIORITY_0, SPRITE_ORDER_1);
        ani->work.cParam.palette = paletteRow;
        ani->cParam[0].palette = ani->cParam[1].palette = ani->work.cParam.palette;

        AnimatorSpriteDS__ProcessAnimationFast(ani);

        ani->position[1].x = 246;

        animID     = HUD_CONTANI_28 - HUD_CONTANI_24;
        paletteRow = 2;

        if (renderCurrentDisplay == GX_DISP_SELECT_MAIN_SUB)
            ani->position[1].y = 10;
        else
            ani->position[1].y = 182;
    }
}

void CreateTargetIndicatorHUD(StageTask *target)
{
    Task *task = TaskCreate(TargetIndicatorHUD_Main, TargetIndicatorHUD_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3), TargetIndicatorHUD);
    if (task == HeapNull)
        return;

    TargetIndicatorHUD *work = TaskGetWork(task, TargetIndicatorHUD);
    TaskInitWork16(work);

    void *spriteFile = ObjDataLoad(NULL, "/ac_fix_cont.bac", gameArchiveCommon);

    AnimatorSprite__Init(&work->animator, spriteFile, HUD_CONTANI_11, ANIMATOR_FLAG_DISABLE_PALETTES | ANIMATOR_FLAG_DISABLE_LOOPING, FALSE, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(FALSE, 8), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    work->animator.cParam.palette = PALETTE_ROW_0;
    work->target                  = target;
}

void CreateRaceProgressHUD(s32 characterID)
{
    u8 animIDs[RACEPROGRESSHUD_ANIMATOR_COUNT] = { HUD_CONTANI_19, HUD_CONTANI_20, HUD_CONTANI_21, HUD_CONTANI_22, HUD_CONTANI_23 };

    s32 i;
    Task *task = TaskCreate(RaceProgressHUD_Main, RaceProgressHUD_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3), RaceProgressHUD);
    if (task == HeapNull)
        return;

    RaceProgressHUD *work = TaskGetWork(task, RaceProgressHUD);
    TaskInitWork16(work);

    void *spriteFile = ObjDataLoad(NULL, "/ac_fix_cont.bac", gameArchiveCommon);

    if (characterID == CHARACTER_BLAZE)
    {
        animIDs[3] = HUD_CONTANI_23;
        animIDs[4] = HUD_CONTANI_22;
    }

    AnimatorSprite *ani = &work->animators[0];
    for (i = 0; i < RACEPROGRESSHUD_ANIMATOR_COUNT;)
    {
        AnimatorSprite__Init(ani, spriteFile, animIDs[i], ANIMATOR_FLAG_DISABLE_PALETTES, TRUE, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(TRUE, Sprite__GetSpriteSize2FromAnim(spriteFile, animIDs[i])), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0,
                             SPRITE_ORDER_1);

        if (i >= 3)
            ani->cParam.palette = PALETTE_ROW_0;
        else
            ani->cParam.palette = PALETTE_ROW_1;

        AnimatorSprite__ProcessAnimationFast(ani);

        i++;
        ani++;
    }
}

void HUD_Destructor(Task *task)
{
    s32 i;

    HUD *work = TaskGetWork(task, HUD);

    s32 numberCount;
    if (gmCheckGameMode(GAMEMODE_VS_BATTLE) || gmCheckGameMode(GAMEMODE_MISSION))
        numberCount = 10;
    else
        numberCount = 21;

    if (IsBossStage() == FALSE)
    {
        for (i = 0; i < numberCount; i++)
        {
            VRAMSystem__FreeSpriteVram(FALSE, work->vramPixels[i][0]);
            VRAMSystem__FreeSpriteVram(TRUE, work->vramPixels[i][1]);
        }
    }
    else
    {
        for (i = 0; i < 21; i++)
        {
            if (work->vramPixels[i][0] != NULL)
                VRAMSystem__FreeSpriteVram(FALSE, work->vramPixels[i][0]);
        }
    }

    for (i = 0; i < HUD_ANIMATOR_COUNT_TOTAL; i++)
    {
        AnimatorSpriteDS__Release(&work->animators[i]);
    }

    BossGaugeHUD_Destructor(&work->bossManager);

    hudWorkSingleton = NULL;
}

NONMATCH_FUNC void HUD_Main(void)
{
    // matches, just waiting on HUD__ringDigitTable to be decompiled before it's done!
#ifdef NON_MATCHING
    HUD *work = TaskGetWorkCurrent(HUD);

    BOOL isVisible = TRUE;
    if (!work->loadedSprites || (work->flags & HUD_FLAG_VISIBLE) != 0)
        isVisible = FALSE;

    if (IsBossStage() && (Camera3D__UseEngineA() && (work->flags & HUD_FLAG_USE_SCREEN_B) == 0 || !Camera3D__UseEngineA() && (work->flags & HUD_FLAG_USE_SCREEN_B) != 0))
    {
        isVisible = FALSE;
    }

    if (isVisible)
    {
        u32 ringDivideTable[] = { 100, 10, 1 };

        s32 d;

        BOOL useAltRingPalette = FALSE;
        s32 ringCount          = gPlayer->rings;
        if (ringCount == 0 && (playerGameStatus.stageTimer & 8) != 0)
            useAltRingPalette = TRUE;

        fx32 ringDigitX;
        for (d = 0, ringDigitX = 23; d < 3; d++)
        {
            u16 digit = FX_DivS32(ringCount, ringDivideTable[d]);
            ringCount -= digit * ringDivideTable[d];

            AnimatorSpriteDS *aniRingDigit = GetHUDTimeNumAnimator(digit, useAltRingPalette);
            aniRingDigit->position[0].x    = ringDigitX;
            aniRingDigit->position[0].y    = 16;
            aniRingDigit->screensToDraw    = SCREEN_DRAW_B;
            AnimatorSpriteDS__DrawFrame(aniRingDigit);

            ringDigitX += 10;
        }

        if (!gmCheckRingBattle())
        {
            AnimatorSpriteDS__DrawFrame(&work->animators[HUD_ANIMATOR_RINGICON]);
            AnimatorSpriteDS__DrawFrame(&work->animators[HUD_ANIMATOR_RING_PANEL]);
        }
        else
        {

            ringCount = gPlayerList[1]->rings;

            useAltRingPalette = FALSE;
            if (ringCount == 0 && (playerGameStatus.stageTimer & 8) != 0)
                useAltRingPalette = TRUE;

            fx32 ringDigitX;
            for (d = 0, ringDigitX = 23; d < 3; d++)
            {
                u16 digit = FX_DivS32(ringCount, ringDivideTable[d]);
                ringCount -= digit * ringDivideTable[d];

                AnimatorSpriteDS *aniRingDigit = GetHUDTimeNumAnimator(digit, useAltRingPalette);
                aniRingDigit->position[1].x    = ringDigitX;
                aniRingDigit->position[1].y    = 16;
                aniRingDigit->screensToDraw    = SCREEN_DRAW_A;
                AnimatorSpriteDS__DrawFrame(aniRingDigit);

                ringDigitX += 10;
            }

            AnimatorSpriteDS__DrawFrame(work->animators);
            AnimatorSpriteDS__DrawFrame(&work->animators[HUD_ANIMATOR_PLAYER_BORDER]);
            AnimatorSpriteDS__DrawFrame(&work->animators[HUD_ANIMATOR_PLAYER_BORDER2]);
        }

        s32 timeDrawX = 0;
        if (gameState.gameMode == GAMEMODE_VS_BATTLE)
            timeDrawX = -36;

        u32 stageTimer = playerGameStatus.stageTimer;

        BOOL useAltTimePalette = FALSE;

        if (gmCheckRingBattle())
        {
            if (stageTimer >= AKUTIL_TIME_TO_FRAMES(1, 40, 00) && (stageTimer & 8) != 0)
                useAltTimePalette = TRUE;

            if (stageTimer >= AKUTIL_TIME_TO_FRAMES(2, 00, 00))
                stageTimer = 0;
            else
                stageTimer = AKUTIL_TIME_TO_FRAMES(2, 00, 00) - stageTimer;
        }
        else if (gameState.gameMode == GAMEMODE_MISSION && playerGameStatus.missionStatus.stageTimeLimit != 0)
        {
            if (stageTimer >= playerGameStatus.missionStatus.stageTimeLimit)
                stageTimer = 0;
            else
                stageTimer = playerGameStatus.missionStatus.stageTimeLimit - stageTimer;

            if (stageTimer < AKUTIL_TIME_TO_FRAMES(0, 10, 00) && (stageTimer & 8) != 0)
                useAltTimePalette = TRUE;
        }
        else if (gameState.stageID == STAGE_TUTORIAL)
        {
            stageTimer = 0;
        }
        else if (stageTimer >= AKUTIL_TIME_TO_FRAMES(9, 39, 99) && (stageTimer & 8) != 0)
        {
            useAltTimePalette = TRUE;
        }

        if (stageTimer > AKUTIL_TIME_TO_FRAMES(9, 59, 99))
            stageTimer = AKUTIL_TIME_TO_FRAMES(9, 59, 99);

        u16 minutes, seconds, centiseconds;
        AkUtilFrameToTime(stageTimer, &minutes, &seconds, &centiseconds);

        AnimatorSpriteDS *aniTimeDigit = GetHUDTimeNumAnimator(minutes, useAltTimePalette);
        aniTimeDigit->position[0].x    = timeDrawX + 180;
        aniTimeDigit->position[0].y    = 13;
        aniTimeDigit->screensToDraw    = 2;
        AnimatorSpriteDS__DrawFrame(aniTimeDigit);

        u16 secs                    = FX_DivS32(seconds, 10);
        aniTimeDigit                = GetHUDTimeNumAnimator(secs, useAltTimePalette);
        aniTimeDigit->position[0].x = timeDrawX + 200;
        AnimatorSpriteDS__DrawFrame(aniTimeDigit);

        aniTimeDigit                = GetHUDTimeNumAnimator(seconds - 10 * secs, useAltTimePalette);
        aniTimeDigit->position[0].x = timeDrawX + 212;
        AnimatorSpriteDS__DrawFrame(aniTimeDigit);

        u16 centisecs               = FX_DivS32(centiseconds, 10);
        aniTimeDigit                = GetHUDTimeNumAnimator(centisecs, useAltTimePalette);
        aniTimeDigit->position[0].x = timeDrawX + 232;
        AnimatorSpriteDS__DrawFrame(aniTimeDigit);

        aniTimeDigit                = GetHUDTimeNumAnimator(centiseconds - 10 * centisecs, useAltTimePalette);
        aniTimeDigit->position[0].x = timeDrawX + 244;
        AnimatorSpriteDS__DrawFrame(aniTimeDigit);

        aniTimeDigit                = GetHUDTimeNumAnimator(HUD_DIGIT_COLON, useAltTimePalette);
        aniTimeDigit->position[0].x = timeDrawX + 187;
        aniTimeDigit->position[0].y = 5;
        aniTimeDigit->screensToDraw = 2;
        AnimatorSpriteDS__DrawFrame(aniTimeDigit);

        aniTimeDigit                = GetHUDTimeNumAnimator(HUD_DIGIT_COLON2, useAltTimePalette);
        aniTimeDigit->position[0].x = timeDrawX + 219;
        aniTimeDigit->position[0].y = 5;
        aniTimeDigit->screensToDraw = 2;
        AnimatorSpriteDS__DrawFrame(aniTimeDigit);

        work->animators[1].position[0].x = timeDrawX;
        AnimatorSpriteDS__DrawFrame(&work->animators[HUD_ANIMATOR_TIME_TEXT]);

        if (!IsBossStage() && (work->flags & HUD_FLAG_TENSION_GAUGE_VISIBLE) != 0)
        {
            UpdateTensionGaugeHUDState(work);
            DrawTensionGaugeHUD(work);
        }

        if (((work->flags & HUD_FLAG_4) != 0) && !gmCheckGameMode(GAMEMODE_VS_BATTLE) && !gmCheckGameMode(GAMEMODE_MISSION))
        {
            s32 lives      = playerGameStatus.lives;
            u16 lifeDigit0 = FX_DivS32(lives, 10);

            AnimatorSpriteDS *aniLifeNum = GetHUDLifeNumAnimator(lifeDigit0, FALSE);
            aniLifeNum->position[0].x    = 22;
            aniLifeNum->position[0].y    = 170;
            aniLifeNum->screensToDraw    = SCREEN_DRAW_B;
            AnimatorSpriteDS__DrawFrame(aniLifeNum);

            aniLifeNum                = GetHUDLifeNumAnimator(lives - 10 * lifeDigit0, FALSE);
            aniLifeNum->position[0].x = 29;
            aniLifeNum->position[0].y = 170;
            AnimatorSpriteDS__DrawFrame(aniLifeNum);

            aniLifeNum                = GetHUDLifeNumAnimator(10, FALSE);
            aniLifeNum->position[0].x = 15;
            aniLifeNum->position[0].y = 178;
            AnimatorSpriteDS__DrawFrame(aniLifeNum);
        }

        work->animators[HUD_ANIMATOR_PLAYER_ICON].position[0].x = work->tensionGaugeX;
        work->animators[HUD_ANIMATOR_PLAYER_ICON].position[0].y = work->tensionGaugeY;
        AnimatorSpriteDS__DrawFrame(&work->animators[HUD_ANIMATOR_PLAYER_ICON]);

        if (gmCheckGameMode(GAMEMODE_VS_BATTLE))
        {
            AnimatorSpriteDS *aniVsPosition = &work->animators[HUD_ANIMATOR_VS_POSITION];

            s32 rank = GetVSBattlePosition(gPlayer);
            if (rank == -1)
                rank = 1;

            if (aniVsPosition->work.animID != rank + HUD_CONTANI_7 && (rank += HUD_CONTANI_9, aniVsPosition->work.animID != rank))
                AnimatorSpriteDS__SetAnimation(aniVsPosition, rank);

            if (aniVsPosition->work.animID == HUD_CONTANI_9 || aniVsPosition->work.animID == HUD_CONTANI_10)
            {
                if ((aniVsPosition->work.flags & ANIMATOR_FLAG_DID_FINISH) != 0)
                    AnimatorSpriteDS__SetAnimation(aniVsPosition, aniVsPosition->work.animID - 2);

                AnimatorSpriteDS__ProcessAnimationFast(aniVsPosition);
            }
            AnimatorSpriteDS__DrawFrame(aniVsPosition);
        }
    }

    if (IsBossStage())
    {
        if ((work->flags & HUD_FLAG_VISIBLE) == 0)
            BossGaugeHUD_Main(&work->bossManager);

        if (work->bossManager.visible && isVisible)
            BossGaugeHUD_Draw(&work->bossManager);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r1, [r5, #0]
	mov r0, #1
	str r0, [sp]
	cmp r1, #0
	beq _020356FC
	ldr r0, [r5, #4]
	tst r0, #1
	beq _02035704
_020356FC:
	mov r0, #0
	str r0, [sp]
_02035704:
	bl IsBossStage
	cmp r0, #0
	beq _02035748
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02035728
	ldr r0, [r5, #4]
	tst r0, #0x100
	beq _02035740
_02035728:
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02035748
	ldr r0, [r5, #4]
	tst r0, #0x100
	beq _02035748
_02035740:
	mov r0, #0
	str r0, [sp]
_02035748:
	ldr r0, [sp]
	cmp r0, #0
	beq _02035C74
	ldr r0, =HUD__ringDigitTable
	ldr r3, =gPlayer
	add r4, sp, #0xc
	ldmia r0, {r0, r1, r2}
	ldr r3, [r3, #0]
	stmia r4, {r0, r1, r2}
	add r0, r3, #0x600
	ldrsh r8, [r0, #0x7e]
	mov r7, #0
	cmp r8, #0
	bne _02035790
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #8
	movne r7, #1
_02035790:
	mov r6, #0
	mov r9, #0x17
	add r4, sp, #0xc
	mov r11, #0x10
_020357A0:
	ldr r10, [r4, r6, lsl #2]
	mov r0, r8
	mov r1, r10
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mul r2, r0, r10
	mov r1, r7
	sub r8, r8, r2
	bl GetHUDTimeNumAnimator
	strh r9, [r0, #0x68]
	strh r11, [r0, #0x6a]
	mov r1, #2
	str r1, [r0, #0x64]
	bl AnimatorSpriteDS__DrawFrame
	add r6, r6, #1
	cmp r6, #3
	add r9, r9, #0xa
	blt _020357A0
	ldr r0, =gameState
	ldr r1, [r0, #0x14]
	cmp r1, #1
	ldreq r0, [r0, #0x20]
	cmpeq r0, #1
	beq _0203581C
	add r0, r5, #8
	bl AnimatorSpriteDS__DrawFrame
	add r0, r5, #0x314
	add r0, r0, #0x400
	bl AnimatorSpriteDS__DrawFrame
	b _020358C4
_0203581C:
	ldr r0, =gPlayerList
	mov r8, #0
	ldr r0, [r0, #4]
	add r0, r0, #0x600
	ldrsh r9, [r0, #0x7e]
	cmp r9, #0
	bne _02035848
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #8
	movne r8, #1
_02035848:
	mov r10, #0
	mov r6, #0x17
	add r4, sp, #0xc
	mov r11, #0x10
_02035858:
	ldr r7, [r4, r10, lsl #2]
	mov r0, r9
	mov r1, r7
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mul r2, r0, r7
	mov r1, r8
	sub r9, r9, r2
	bl GetHUDTimeNumAnimator
	strh r6, [r0, #0x6c]
	strh r11, [r0, #0x6e]
	mov r1, #1
	str r1, [r0, #0x64]
	bl AnimatorSpriteDS__DrawFrame
	add r10, r10, #1
	cmp r10, #3
	add r6, r6, #0xa
	blt _02035858
	add r0, r5, #8
	bl AnimatorSpriteDS__DrawFrame
	add r0, r5, #0x3b8
	add r0, r0, #0x400
	bl AnimatorSpriteDS__DrawFrame
	add r0, r5, #0x5c
	add r0, r0, #0x800
	bl AnimatorSpriteDS__DrawFrame
_020358C4:
	ldr r0, =gameState
	mov r4, #0
	ldr r2, [r0, #0x14]
	ldr r0, =playerGameStatus
	cmp r2, #1
	subeq r4, r4, #0x24
	cmp r2, #1
	ldreq r1, =gameState
	ldr r0, [r0, #0xc]
	ldreq r1, [r1, #0x20]
	mov r6, #0
	cmpeq r1, #1
	bne _02035920
	ldr r1, =0x00001770
	cmp r0, r1
	blo _0203590C
	tst r0, #8
	movne r6, #1
_0203590C:
	ldr r1, =0x00001C20
	cmp r0, r1
	movhs r0, #0
	sublo r0, r1, r0
	b _02035980
_02035920:
	cmp r2, #3
	bne _02035958
	ldr r1, =playerGameStatus
	ldr r1, [r1, #0xbc]
	cmp r1, #0
	beq _02035958
	cmp r0, r1
	movhs r0, #0
	sublo r0, r1, r0
	cmp r0, #0x258
	bhs _02035980
	tst r0, #8
	movne r6, #1
	b _02035980
_02035958:
	ldr r1, =gameState
	ldrh r1, [r1, #0x28]
	cmp r1, #2
	moveq r0, #0
	beq _02035980
	ldr r1, =0x000087EF
	cmp r0, r1
	blo _02035980
	tst r0, #8
	movne r6, #1
_02035980:
	ldr r1, =0x00008C9F
	add r2, sp, #6
	cmp r0, r1
	movhi r0, r1
	add r1, sp, #8
	add r3, sp, #4
	bl AkUtilFrameToTime
	ldrh r0, [sp, #8]
	mov r1, r6
	bl GetHUDTimeNumAnimator
	add r1, r4, #0xb4
	strh r1, [r0, #0x68]
	mov r1, #0xd
	strh r1, [r0, #0x6a]
	mov r1, #2
	str r1, [r0, #0x64]
	bl AnimatorSpriteDS__DrawFrame
	ldrh r0, [sp, #6]
	mov r1, #0xa
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, r7
	mov r1, r6
	bl GetHUDTimeNumAnimator
	add r1, r4, #0xc8
	strh r1, [r0, #0x68]
	bl AnimatorSpriteDS__DrawFrame
	mov r0, #0xa
	mul r0, r7, r0
	ldrh r1, [sp, #6]
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r6
	bl GetHUDTimeNumAnimator
	add r1, r4, #0xd4
	strh r1, [r0, #0x68]
	bl AnimatorSpriteDS__DrawFrame
	ldrh r0, [sp, #4]
	mov r1, #0xa
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, r7
	mov r1, r6
	bl GetHUDTimeNumAnimator
	add r1, r4, #0xe8
	strh r1, [r0, #0x68]
	bl AnimatorSpriteDS__DrawFrame
	mov r0, #0xa
	mul r0, r7, r0
	ldrh r1, [sp, #4]
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r6
	bl GetHUDTimeNumAnimator
	add r1, r4, #0xf4
	strh r1, [r0, #0x68]
	bl AnimatorSpriteDS__DrawFrame
	mov r0, #0xa
	mov r1, r6
	bl GetHUDTimeNumAnimator
	add r1, r4, #0xbb
	strh r1, [r0, #0x68]
	mov r1, #5
	strh r1, [r0, #0x6a]
	mov r1, #2
	str r1, [r0, #0x64]
	bl AnimatorSpriteDS__DrawFrame
	mov r1, r6
	mov r0, #0xb
	bl GetHUDTimeNumAnimator
	add r1, r4, #0xdb
	strh r1, [r0, #0x68]
	mov r1, #5
	strh r1, [r0, #0x6a]
	mov r1, #2
	str r1, [r0, #0x64]
	bl AnimatorSpriteDS__DrawFrame
	add r1, r5, #0x100
	add r0, r5, #0xac
	strh r4, [r1, #0x14]
	bl AnimatorSpriteDS__DrawFrame
	bl IsBossStage
	cmp r0, #0
	bne _02035AFC
	ldr r0, [r5, #4]
	tst r0, #2
	beq _02035AFC
	mov r0, r5
	bl UpdateTensionGaugeHUDState
	mov r0, r5
	bl DrawTensionGaugeHUD
_02035AFC:
	ldr r0, [r5, #4]
	tst r0, #4
	ldrne r0, =gameState
	ldrne r0, [r0, #0x14]
	cmpne r0, #1
	cmpne r0, #3
	beq _02035BAC
	ldr r0, =playerGameStatus
	mov r1, #0xa
	ldrb r4, [r0, #0x24]
	mov r0, r4
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	mov r0, r6
	mov r1, #0
	bl GetHUDLifeNumAnimator
	mov r1, #0x16
	strh r1, [r0, #0x68]
	mov r1, #0xaa
	strh r1, [r0, #0x6a]
	mov r1, #2
	str r1, [r0, #0x64]
	bl AnimatorSpriteDS__DrawFrame
	mov r0, #0xa
	mul r0, r6, r0
	sub r0, r4, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl GetHUDLifeNumAnimator
	mov r1, #0x1d
	strh r1, [r0, #0x68]
	mov r1, #0xaa
	strh r1, [r0, #0x6a]
	bl AnimatorSpriteDS__DrawFrame
	mov r0, #0xa
	mov r1, #0
	bl GetHUDLifeNumAnimator
	mov r1, #0xf
	strh r1, [r0, #0x68]
	mov r1, #0xb2
	strh r1, [r0, #0x6a]
	bl AnimatorSpriteDS__DrawFrame
_02035BAC:
	add r1, r5, #0xb00
	ldrsh r3, [r1, #0xb8]
	add r2, r5, #0x600
	add r0, r5, #0x670
	strh r3, [r2, #0xd8]
	ldrsh r1, [r1, #0xba]
	strh r1, [r2, #0xda]
	bl AnimatorSpriteDS__DrawFrame
	ldr r0, =gameState
	ldr r0, [r0, #0x14]
	cmp r0, #1
	bne _02035C74
	ldr r0, =gPlayer
	add r4, r5, #0x900
	ldr r0, [r0, #0]
	bl GetVSBattlePosition
	mvn r1, #0
	cmp r0, r1
	moveq r0, #1
	ldrh r2, [r4, #0xc]
	add r1, r0, #7
	cmp r2, r1
	addne r0, r0, #9
	cmpne r2, r0
	beq _02035C20
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl AnimatorSpriteDS__SetAnimation
_02035C20:
	ldrh r1, [r4, #0xc]
	add r0, r1, #0xf7
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _02035C6C
	ldr r0, [r4, #0x3c]
	tst r0, #0x40000000
	beq _02035C5C
	sub r0, r1, #2
	mov r1, r0, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl AnimatorSpriteDS__SetAnimation
_02035C5C:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
_02035C6C:
	mov r0, r4
	bl AnimatorSpriteDS__DrawFrame
_02035C74:
	bl IsBossStage
	cmp r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r5, #4]
	tst r0, #1
	bne _02035C9C
	add r0, r5, #0x3bc
	add r0, r0, #0x800
	bl BossGaugeHUD_Main
_02035C9C:
	ldr r0, [r5, #0xbc0]
	cmp r0, #0
	ldrne r0, [sp]
	cmpne r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r5, #0x3bc
	add r0, r0, #0x800
	bl BossGaugeHUD_Draw
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

fx32 GetNextHUDTensionScale(s16 distance)
{
    distance = MTM_MATH_CLIP(distance, 0, 50);

    return (FX32_FROM_WHOLE(distance) / 100) + FLOAT_TO_FX32(1.7);
}

void UpdateTensionGaugeHUDState(HUD *work)
{
    if (work->tensionGaugeShakeTimer != 0)
    {
        work->tensionGaugeShakeTimer--;
        if ((playerGameStatus.stageTimer & 1) != 0)
        {
            s32 shift = (work->tensionGaugeShakeDuration - work->tensionGaugeShakeTimer) >> 4;

            work->tensionGaugeX = (4 - (mtMathRand() & 7)) >> shift;
            work->tensionGaugeY = (4 - (mtMathRand() & 7)) >> shift;
        }
    }

    work->lastTensionPos = work->currentTensionPos;

    if (work->currentTension > work->targetTension)
    {
        work->tensionChangeTimer--;
        if (work->tensionChangeTimer <= 0)
        {
            work->currentTension--;
            if (work->currentTension <= work->targetTension)
                work->currentTension = work->targetTension;
            else
                work->tensionChangeTimer = 1;
        }

        work->currentTensionPos = FX_DivS32(work->currentTension, 5);
    }
    else
    {
        if (work->currentTension < work->targetTension)
        {
            work->tensionChangeTimer--;
            if (work->tensionChangeTimer <= 0)
            {
                work->currentTension += 2;

                if (work->currentTension >= work->targetTension)
                    work->currentTension = work->targetTension;
                else
                    work->tensionChangeTimer = 1;
            }

            work->currentTensionPos = FX_DivS32(work->currentTension, 5);

            if (work->currentTensionPos != work->lastTensionPos)
            {
                for (s32 i = 3; i > 0; i--)
                {
                    work->tensionScale[i] = work->tensionScale[i - 1];
                }
                work->tensionScale[0] = work->nextTensionScale;
            }
        }
        else
        {
            work->currentTensionPos = FX_DivS32(work->currentTension, 5);
        }

        for (s32 i = 0; i < 4; i++)
        {
            if (work->tensionScale[i] > FLOAT_TO_FX32(1.0))
            {
                work->tensionScale[i] -= FLOAT_TO_FX32(0.2);
                if (work->tensionScale[i] < FLOAT_TO_FX32(1.0))
                    work->tensionScale[i] = FLOAT_TO_FX32(1.0);
            }
        }
    }

    fx32 starAnim = FX_DivS32(work->currentTensionPos, 20);
    if (starAnim != FX_DivS32(work->lastTensionPos, 20))
        AnimatorSpriteDS__SetAnimation(&work->animators[HUD_ANIMATOR_TENSION_STAR], starAnim + HUD_ANI_30);
}

NONMATCH_FUNC void DrawTensionGaugeHUD(HUD *work)
{
    // https://decomp.me/scratch/9KKIt -> 98.46%
#ifdef NON_MATCHING
    s32 tensionCountUnknown;
    s32 tensionCountHigh;
    s32 currentTension = work->currentTension;
    s32 tensionGaugeX  = work->tensionGaugeX;
    s16 tensionGaugeY  = work->tensionGaugeY;

    fx32 tensionX;

    s16 tensionLevelHigh = 0;
    s16 tensionLevelLow;

    s16 currentTensionLevel = FX_ModS32(currentTension, 100);
    if ((work->flags & HUD_FLAG_TENSION_MAX_ENABLED) != 0 && work->currentTension >= 300)
        work->flags |= HUD_FLAG_TENSION_MAX_ACTIVE;

    if ((work->flags & HUD_FLAG_TENSION_MAX_ACTIVE) != 0)
    {
        // max tension timer is active! flash the tension gauge!
        if ((playerGameStatus.stageTimer & 4) != 0)
        {
            tensionLevelHigh = 3;
            tensionLevelLow  = 3;
        }
        else
        {
            tensionLevelHigh = 4;
            tensionLevelLow  = 4;

            if ((work->flags & HUD_FLAG_TENSION_MAX_ENABLED) == 0)
                work->flags &= ~HUD_FLAG_TENSION_MAX_ACTIVE;
        }
    }
    else
    {
        // max tension is NOT active, get lower tension level by dividing current tension by 100 then the higher level is the next oneup
        tensionLevelLow = FX_DivS32(currentTension, 100);
        if (currentTensionLevel != 0)
            tensionLevelHigh = tensionLevelLow + 1;
    }

    // Set palette color for the lower tension level
    GXRgb *tensionColorLow = &tensionGaugeColors[tensionLevelLow];
    QueueUncompressedPalette(tensionColorLow, 1, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((u16 *)VRAM_OBJ_PLTT)[1]));
    QueueUncompressedPalette(tensionColorLow, 1, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((u16 *)VRAM_DB_OBJ_PLTT)[1]));

    // Set palette color for the higher tension level
    GXRgb *tensionColorHigh = &tensionGaugeColors[tensionLevelHigh];
    QueueUncompressedPalette(tensionColorHigh, 1, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((u16 *)VRAM_OBJ_PLTT)[2]));
    QueueUncompressedPalette(tensionColorHigh, 1, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(&((u16 *)VRAM_DB_OBJ_PLTT)[2]));

    tensionCountHigh       = 0;
    s32 tensionX4CountLow  = currentTensionLevel / 20;
    tensionCountUnknown    = currentTensionLevel / 5;
    s32 tensionCountLow    = tensionCountUnknown - 4 * tensionX4CountLow;
    s32 tensionX4CountHigh = 5 - tensionX4CountLow;

    if (currentTension >= 100 && 4 - tensionCountUnknown > 0 && work->tensionScale[tensionCountUnknown] != FLOAT_TO_FX32(1.0))
    {
        tensionX4CountHigh--;
        tensionCountHigh = 4;
    }

    if (tensionX4CountLow != 0 && work->tensionScale[tensionCountLow] != FLOAT_TO_FX32(1.0))
    {
        tensionX4CountLow--;
        tensionCountLow += 4;
    }

    // Draw lower tension gauge level sprites
    AnimatorSpriteDS *aniTensionLowX4 = &work->animators[HUD_ANIMATOR_TENSION_x4_LOW];
    tensionX                          = tensionGaugeX + 16;
    aniTensionLowX4->position[0].x    = tensionX;

    // Draw static tension gauge sprites (in sets of 4)
    s16 tensionDrawLowY = 163;
    s32 i = 0;
    for (i = 0; i < tensionX4CountLow; i++)
    {
        aniTensionLowX4->position[0].y = tensionDrawLowY + tensionGaugeY;
        AnimatorSpriteDS__DrawFrame(aniTensionLowX4);
        tensionDrawLowY -= 20;
    }

    // Draw dynamic tension gauge sprites (one by one)
    AnimatorSpriteDS *aniTensionLowX1 = &work->animators[HUD_ANIMATOR_TENSION_x1_LOW];
    aniTensionLowX1->position[0].x    = tensionX;

    if (tensionCountLow != 0)
    {
        // Draw dynamic tension gauge sprites that aren't scaled atm
        aniTensionLowX1->work.flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;

        for (i = tensionCountLow - 4; i > 0; i--)
        {
            aniTensionLowX1->position[0].y = tensionDrawLowY + tensionGaugeY;
            AnimatorSpriteDS__DrawFrame(aniTensionLowX1);
            tensionDrawLowY -= 5;
        }

        // Draw dynamic tension gauge sprites that ARE scaling
        aniTensionLowX1->work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;

        if (tensionCountLow - 4 >= 0)
            tensionCountLow = 4;

        for (i = tensionCountLow - 1; i >= 0; i--)
        {
            aniTensionLowX1->position[0].y = tensionDrawLowY + tensionGaugeY;

            if (work->tensionScale[i] == FLOAT_TO_FX32(1.0))
                AnimatorSpriteDS__DrawFrame(aniTensionLowX1);
            else
                AnimatorSpriteDS__DrawFrameRotoZoom(aniTensionLowX1, work->tensionScale[i], work->tensionScale[i], FLOAT_DEG_TO_IDX(0.0));

            tensionDrawLowY -= 5;
        }
    }

    // Draw higher tension gauge level sprites
    AnimatorSpriteDS *aniTensionHighX4 = &work->animators[HUD_ANIMATOR_TENSION_x4_HIGH];
    aniTensionHighX4->position[0].x    = tensionX;

    // Draw static tension gauge sprites (in sets of 4)
    s16 tensionDrawY = (5 * tensionCountHigh) + (163 - (20 * (5 - tensionX4CountHigh)));
    for (; tensionX4CountHigh > 0; tensionX4CountHigh--)
    {
        aniTensionHighX4->position[0].y = tensionDrawY + tensionGaugeY;
        AnimatorSpriteDS__DrawFrame(aniTensionHighX4);
        tensionDrawY -= 20;
    }

    // Draw dynamic tension gauge sprites (one by one)
    AnimatorSpriteDS *aniTensionHighX1 = &work->animators[HUD_ANIMATOR_TENSION_x1_HIGH];
    aniTensionHighX1->position[0].x    = tensionX;
    if (tensionCountHigh != 0)
    {
        // Draw dynamic tension gauge sprites that aren't scaled atm
        aniTensionHighX1->work.flags &= ~ANIMATOR_FLAG_ENABLE_SCALE;

        for (i = tensionCountHigh - (4 - tensionCountUnknown); i > 0; i--)
        {
            aniTensionHighX1->position[0].y = tensionDrawY + tensionGaugeY;
            AnimatorSpriteDS__DrawFrame(aniTensionHighX1);

            tensionDrawY -= 5;
        }

        // Draw dynamic tension gauge sprites that ARE scaling
        aniTensionHighX1->work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;

        for (i = (3 - tensionCountUnknown); i >= 0; i--)
        {
            aniTensionHighX1->position[0].y = tensionDrawY + tensionGaugeY;

            if (work->tensionScale[tensionCountUnknown + i] == FLOAT_TO_FX32(1.0))
                AnimatorSpriteDS__DrawFrame(aniTensionHighX1);
            else
                AnimatorSpriteDS__DrawFrameRotoZoom(aniTensionHighX1, work->tensionScale[tensionCountUnknown + i], work->tensionScale[tensionCountUnknown + i],
                                                    FLOAT_DEG_TO_IDX(0.0));

            tensionDrawY -= 5;
        }
    }

    // Draw tension gauge star icon
    AnimatorSpriteDS *aniStar = &work->animators[HUD_ANIMATOR_TENSION_STAR];
    aniStar->position[0].x    = tensionGaugeX;
    aniStar->position[0].y    = tensionGaugeY;

    if (aniStar->work.animID == HUD_ANI_33)
    {
        // handle star spinning logic
        if (gPlayer->tensionMaxTimer > 0)
        {
            // animAdvance = (gPlayer->tensionMaxTimer * 0.25)
            aniStar->work.animAdvance = gPlayer->tensionMaxTimer << 6;

            if (aniStar->work.animAdvance < FLOAT_TO_FX32(0.5))
                aniStar->work.animAdvance = FLOAT_TO_FX32(0.5);

            aniStar->work.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
        }
        else
        {
            if ((aniStar->work.flags & ANIMATOR_FLAG_DISABLE_LOOPING) != 0)
            {
                aniStar->work.flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;
            }
            else if ((aniStar->work.flags & ANIMATOR_FLAG_DID_FINISH) != 0)
            {
                AnimatorSpriteDS__SetAnimation(aniStar, HUD_ANI_33);
                aniStar->work.animAdvance = FLOAT_TO_FX32(0.0);
            }
        }
    }
    else
    {
        // animate normally
        aniStar->work.animAdvance = FLOAT_TO_FX32(1.0);
        aniStar->work.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
    }

    AnimatorSpriteDS__ProcessAnimationFast(aniStar);
    AnimatorSpriteDS__DrawFrame(aniStar);

    // Draw star pedestal
    AnimatorSpriteDS *aniPedestal = &work->animators[HUD_ANIMATOR_TENSION_PEDESTAL];
    aniPedestal->position[0].x    = tensionGaugeX;
    aniPedestal->position[0].y    = tensionGaugeY + 50;
    AnimatorSpriteDS__DrawFrame(aniPedestal);
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r10, r0
	add r2, r10, #0xb00
	ldrsh r0, [r2, #0xb8]
	ldrsh r6, [r2, #0x96]
	mov r1, #0x64
	str r0, [sp, #8]
	mov r0, r6
	ldrsh r11, [r2, #0xba]
	mov r5, #0
	bl FX_ModS32
	ldr r1, [r10, #4]
	mov r0, r0, lsl #0x10
	tst r1, #8
	mov r4, r0, asr #0x10
	beq _02035FC0
	add r0, r10, #0xb00
	ldrsh r0, [r0, #0x96]
	cmp r0, #0x12c
	orrge r0, r1, #0x10
	strge r0, [r10, #4]
_02035FC0:
	ldr r1, [r10, #4]
	tst r1, #0x10
	beq _02035FFC
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #4
	movne r5, #3
	movne r2, r5
	bne _02036020
	mov r5, #4
	tst r1, #8
	biceq r0, r1, #0x10
	mov r2, r5
	streq r0, [r10, #4]
	b _02036020
_02035FFC:
	mov r0, r6
	mov r1, #0x64
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	cmp r4, #0
	addne r0, r2, #1
	movne r0, r0, lsl #0x10
	movne r5, r0, asr #0x10
_02036020:
	ldr r0, =tensionGaugeColors
	ldr r3, =0x05000202
	add r7, r0, r2, lsl #1
	mov r0, r7
	mov r1, #1
	mov r2, #0
	bl QueueUncompressedPalette
	ldr r3, =0x05000602
	mov r0, r7
	mov r1, #1
	mov r2, #0
	bl QueueUncompressedPalette
	ldr r0, =tensionGaugeColors
	ldr r3, =0x05000204
	add r5, r0, r5, lsl #1
	mov r1, #1
	mov r0, r5
	mov r2, #0
	bl QueueUncompressedPalette
	ldr r3, =0x05000604
	mov r0, r5
	mov r1, #1
	mov r2, #0
	bl QueueUncompressedPalette
	mov r0, #0
	ldr r3, =0x66666667
	cmp r6, #0x64
	str r0, [sp, #0xc]
	smull r0, r6, r3, r4
	mov r1, r4, lsr #0x1f
	smull r2, r0, r3, r4
	add r6, r1, r6, asr #3
	add r0, r1, r0, asr #1
	str r0, [sp, #0x10]
	sub r0, r0, r6, lsl #2
	str r0, [sp]
	rsb r9, r6, #5
	blt _020360E4
	ldr r0, [sp, #0x10]
	rsb r0, r0, #4
	cmp r0, #0
	ble _020360E4
	ldr r0, [sp, #0x10]
	add r0, r10, r0, lsl #2
	ldr r0, [r0, #0xba4]
	cmp r0, #0x1000
	movne r0, #4
	subne r9, r9, #1
	strne r0, [sp, #0xc]
_020360E4:
	cmp r6, #0
	beq _02036110
	ldr r0, [sp]
	add r0, r10, r0, lsl #2
	ldr r0, [r0, #0xba4]
	cmp r0, #0x1000
	beq _02036110
	ldr r0, [sp]
	sub r6, r6, #1
	add r0, r0, #4
	str r0, [sp]
_02036110:
	ldr r0, [sp, #8]
	add r5, r10, #0x33c
	add r0, r0, #0x10
	str r0, [sp, #4]
	strh r0, [r5, #0x68]
	cmp r6, #0
	mov r7, #0xa3
	mov r4, #0
	ble _02036160
	add r8, r11, #0xa3
_02036138:
	mov r0, r5
	strh r8, [r5, #0x6a]
	bl AnimatorSpriteDS__DrawFrame
	sub r0, r7, #0x14
	mov r0, r0, lsl #0x10
	mov r7, r0, asr #0x10
	sub r8, r8, #0x14
	add r4, r4, #1
	cmp r4, r6
	blt _02036138
_02036160:
	add r0, r10, #0x84
	add r5, r0, #0x400
	ldr r0, [sp, #4]
	strh r0, [r5, #0x68]
	ldr r0, [sp]
	cmp r0, #0
	beq _02036234
	ldr r1, [r5, #0x3c]
	sub r6, r0, #4
	bic r0, r1, #0x200
	str r0, [r5, #0x3c]
	cmp r6, #0
	ble _020361C0
	add r4, r7, r11
_02036198:
	mov r0, r5
	strh r4, [r5, #0x6a]
	bl AnimatorSpriteDS__DrawFrame
	sub r0, r7, #5
	mov r0, r0, lsl #0x10
	sub r6, r6, #1
	mov r7, r0, asr #0x10
	cmp r6, #0
	sub r4, r4, #5
	bgt _02036198
_020361C0:
	ldr r0, [sp]
	ldr r1, [r5, #0x3c]
	subs r0, r0, #4
	orr r0, r1, #0x200
	str r0, [r5, #0x3c]
	movpl r0, #4
	strpl r0, [sp]
	ldr r0, [sp]
	subs r6, r0, #1
	bmi _02036234
	add r4, r7, r11
	mov r8, #0
_020361F0:
	strh r4, [r5, #0x6a]
	add r0, r10, r6, lsl #2
	ldr r1, [r0, #0xba4]
	mov r0, r5
	cmp r1, #0x1000
	bne _02036210
	bl AnimatorSpriteDS__DrawFrame
	b _0203621C
_02036210:
	mov r2, r1
	mov r3, r8
	bl AnimatorSpriteDS__DrawFrameRotoZoom
_0203621C:
	sub r0, r7, #5
	mov r0, r0, lsl #0x10
	sub r4, r4, #5
	mov r7, r0, asr #0x10
	subs r6, r6, #1
	bpl _020361F0
_02036234:
	rsb r1, r9, #5
	mov r0, #0x14
	mul r2, r1, r0
	ldr r0, [sp, #0xc]
	add r5, r10, #0x298
	add r1, r0, r0, lsl #2
	rsb r0, r2, #0xa3
	add r0, r1, r0
	mov r1, r0, lsl #0x10
	ldr r0, [sp, #4]
	cmp r9, #0
	strh r0, [r5, #0x68]
	mov r6, r1, asr #0x10
	ble _02036298
	add r4, r6, r11
_02036270:
	mov r0, r5
	strh r4, [r5, #0x6a]
	bl AnimatorSpriteDS__DrawFrame
	sub r0, r6, #0x14
	mov r0, r0, lsl #0x10
	sub r9, r9, #1
	cmp r9, #0
	sub r4, r4, #0x14
	mov r6, r0, asr #0x10
	bgt _02036270
_02036298:
	ldr r0, [sp, #4]
	add r7, r10, #0x3e0
	strh r0, [r7, #0x68]
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _0203636C
	ldr r0, [sp, #0x10]
	ldr r2, [r7, #0x3c]
	rsb r1, r0, #4
	ldr r0, [sp, #0xc]
	bic r2, r2, #0x200
	sub r5, r0, r1
	str r2, [r7, #0x3c]
	cmp r5, #0
	ble _02036300
	add r4, r6, r11
_020362D8:
	mov r0, r7
	strh r4, [r7, #0x6a]
	bl AnimatorSpriteDS__DrawFrame
	sub r0, r6, #5
	mov r0, r0, lsl #0x10
	sub r5, r5, #1
	cmp r5, #0
	sub r4, r4, #5
	mov r6, r0, asr #0x10
	bgt _020362D8
_02036300:
	ldr r0, [sp, #0x10]
	ldr r1, [r7, #0x3c]
	rsbs r8, r0, #3
	orr r0, r1, #0x200
	str r0, [r7, #0x3c]
	bmi _0203636C
	ldr r0, [sp, #0x10]
	add r5, r6, r11
	add r4, r10, r0, lsl #2
	mov r9, #0
_02036328:
	strh r5, [r7, #0x6a]
	add r0, r4, r8, lsl #2
	ldr r1, [r0, #0xba4]
	mov r0, r7
	cmp r1, #0x1000
	bne _02036348
	bl AnimatorSpriteDS__DrawFrame
	b _02036354
_02036348:
	mov r2, r1
	mov r3, r9
	bl AnimatorSpriteDS__DrawFrameRotoZoom
_02036354:
	sub r0, r6, #5
	mov r0, r0, lsl #0x10
	sub r5, r5, #5
	mov r6, r0, asr #0x10
	subs r8, r8, #1
	bpl _02036328
_0203636C:
	ldr r0, [sp, #8]
	add r4, r10, #0x150
	strh r0, [r4, #0x68]
	strh r11, [r4, #0x6a]
	ldrh r0, [r4, #0xc]
	cmp r0, #0x21
	bne _020363F8
	ldr r0, =gPlayer
	ldr r0, [r0, #0]
	add r0, r0, #0x600
	ldrsh r0, [r0, #0x86]
	cmp r0, #0
	ble _020363C4
	mov r0, r0, lsl #6
	str r0, [r4, #0x38]
	cmp r0, #0x800
	movlt r0, #0x800
	strlt r0, [r4, #0x38]
	ldr r0, [r4, #0x3c]
	orr r0, r0, #4
	str r0, [r4, #0x3c]
	b _0203640C
_020363C4:
	ldr r0, [r4, #0x3c]
	tst r0, #4
	bicne r0, r0, #4
	strne r0, [r4, #0x3c]
	bne _0203640C
	tst r0, #0x40000000
	beq _0203640C
	mov r0, r4
	mov r1, #0x21
	bl AnimatorSpriteDS__SetAnimation
	mov r0, #0
	str r0, [r4, #0x38]
	b _0203640C
_020363F8:
	mov r0, #0x1000
	str r0, [r4, #0x38]
	ldr r0, [r4, #0x3c]
	orr r0, r0, #4
	str r0, [r4, #0x3c]
_0203640C:
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	mov r0, r4
	bl AnimatorSpriteDS__DrawFrame
	ldr r1, [sp, #8]
	add r0, r10, #0x1f4
	strh r1, [r0, #0x68]
	add r1, r11, #0x32
	strh r1, [r0, #0x6a]
	bl AnimatorSpriteDS__DrawFrame
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

// BossGaugeHUD
void CreateBossGaugeHUD(BossGaugeHUD *work)
{
    MI_CpuClear16(work, sizeof(BossGaugeHUD));
    work->spritePtr = ObjDataLoad(NULL, "/ac_fix_boss.bac", gameArchiveCommon);
    SetBossHealthbarPosition(32, 180);
    work->loaded = TRUE;
}

void LoadBossGaugeAssets(BossGaugeHUD *work)
{
    AnimatorSprite__Init(&work->animator, work->spritePtr, 0, ANIMATOR_FLAG_DISABLE_PALETTES, 0, PIXEL_MODE_SPRITE, 0, PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0,
                         SPRITE_ORDER_1);
    work->animator.cParam.palette = ObjDrawAllocSpritePalette(work->spritePtr, 0, 0x75);

    for (s32 i = 0; i < 13; i++)
    {
        u16 aniID           = bossGaugeAnimIDs[i];
        work->vramPixels[i] = VRAMSystem__AllocSpriteVram(0, Sprite__GetSpriteSize2FromAnim(work->spritePtr, aniID));
        AnimatorSprite__SetAnimation(&work->animator, aniID);
        work->animator.vramPixels = work->vramPixels[i];
        AnimatorSprite__ProcessAnimationFast(&work->animator);
    }

    work->animator.flags |= ANIMATOR_FLAG_DISABLE_SPRITE_PARTS;
    work->visible = TRUE;
}

void BossGaugeHUD_Destructor(BossGaugeHUD *work)
{
    if (work->loaded && work->visible)
    {
        ObjDrawReleaseSprite(117);
        for (s32 i = 0; i < 13; i++)
        {
            VRAMSystem__FreeSpriteVram(FALSE, work->vramPixels[i]);
        }
        MI_CpuClear16(work, sizeof(*work));

        work->visible = FALSE;
        work->loaded  = FALSE;
    }
}

void BossGaugeHUD_Main(BossGaugeHUD *work)
{
    s32 id = work->activeHealthbar;

    if (work->targetHealth == work->displayHealth[id])
        return; // nothing to be done

    if (work->displayHealth[id] < work->targetHealth)
    {
        // slowly fill up boss health
        work->displayHealth[id] += 4;

        if (work->displayHealth[id] > work->targetHealth)
            work->displayHealth[id] = work->targetHealth;
    }
    else
    {
        if (work->displayHealth[id] > work->targetHealth)
        {
            fx32 change = FX32_TO_WHOLE((work->displayHealth[id] - work->targetHealth) * FLOAT_TO_FX32(0.1));
            if (change <= 0)
                change = 1;

            work->displayHealth[id] -= change;
            if (work->displayHealth[id] < work->targetHealth)
                work->displayHealth[id] = work->targetHealth;
        }
    }

    CalculateBossGaugeSegmentFrames(work, work->displayHealth[id], work->segmentAnimID, 26);
    work->prevDisplayHealth[id] = work->displayHealth[id];
}

void BossGaugeHUD_Draw(BossGaugeHUD *work)
{
    // boss name sprite
    AnimatorSprite__SetAnimation(&work->animator, bossGaugeNameAnimIDs[work->activeHealthbar]);
    work->animator.vramPixels = work->vramPixels[bossGaugeNameVRAMPixels[work->activeHealthbar]];
    work->animator.flags &= ~ANIMATOR_FLAG_FLIP_X;
    work->animator.pos.x = work->position.x;
    work->animator.pos.y = work->position.y;
    AnimatorSprite__ProcessAnimationFast(&work->animator);
    AnimatorSprite__DrawFrame(&work->animator);

    // bar edge L
    AnimatorSprite__SetAnimation(&work->animator, 9);
    work->animator.vramPixels = work->vramPixels[9];
    work->animator.flags &= ~ANIMATOR_FLAG_FLIP_X;
    work->animator.pos.x = work->position.x;
    work->animator.pos.y = work->position.y;
    AnimatorSprite__ProcessAnimationFast(&work->animator);
    AnimatorSprite__DrawFrame(&work->animator);

    // life gauge
    for (s32 i = 0; i < 26; i++)
    {
        u16 anim = bossGaugeAnimIDs[work->segmentAnimID[i]];
        AnimatorSprite__SetAnimation(&work->animator, anim);
        work->animator.vramPixels = work->vramPixels[anim];
        work->animator.pos.x += 8;
        AnimatorSprite__ProcessAnimationFast(&work->animator);
        AnimatorSprite__DrawFrame(&work->animator);
    }

    // bar edge R
    AnimatorSprite__SetAnimation(&work->animator, 9);
    work->animator.vramPixels = work->vramPixels[9];
    work->animator.flags |= ANIMATOR_FLAG_FLIP_X;
    work->animator.pos.x += 16;
    AnimatorSprite__ProcessAnimationFast(&work->animator);
    AnimatorSprite__DrawFrame(&work->animator);
}

void CalculateBossGaugeSegmentFrames(BossGaugeHUD *work, s32 health, u32 *segmentAnimID, s32 count)
{
    if (health <= HUD_BOSS_HEALTH_MIN)
    {
        for (s32 i = 0; i < count; i++)
        {
            segmentAnimID[i] = 0;
        }
    }
    else if (health >= HUD_BOSS_HEALTH_MAX)
    {
        for (s32 i = 0; i < count; i++)
        {
            segmentAnimID[i] = 8;
        }
    }
    else
    {
        s32 healthPerSegment    = FX_DivS32(HUD_BOSS_HEALTH_MAX, count);
        s32 visibleSegmentCount = FX_DivS32(health, healthPerSegment);
        s32 frame               = FX_DivS32(8 * (health - healthPerSegment * visibleSegmentCount), healthPerSegment);

        if (visibleSegmentCount == 0 && frame == 0)
            frame = 1;

        s32 i;
        for (i = 0; i < visibleSegmentCount; i++)
        {
            segmentAnimID[i] = 8;
        }

        segmentAnimID[i++] = frame;

        for (; i < count; i++)
        {
            segmentAnimID[i] = 0;
        }
    }
}

// CheckpointTimeHUD
void CheckpointTimeHUD_Destructor(Task *task)
{
    checkpointTime = NULL;
}

void CheckpointTimeHUD_Main(void)
{
    BOOL isFlashing;

    checkpointTime->timer--;

    isFlashing = FALSE;
    if ((checkpointTime->timer & 4) != 0)
        isFlashing = TRUE;

    AnimatorSpriteDS *digitAnimator = GetHUDTimeNumAnimator(checkpointTime->minutes, isFlashing);
    digitAnimator->position[0].x    = 180;
    digitAnimator->position[0].y    = 29;
    digitAnimator->screensToDraw    = SCREEN_DRAW_B;
    AnimatorSpriteDS__DrawFrame(digitAnimator);

    u16 secs                     = FX_DivS32(checkpointTime->seconds, 10);
    digitAnimator                = GetHUDTimeNumAnimator(secs, isFlashing);
    digitAnimator->position[0].x = 200;
    AnimatorSpriteDS__DrawFrame(digitAnimator);

    secs                         = checkpointTime->seconds - 10 * secs;
    digitAnimator                = GetHUDTimeNumAnimator(secs, isFlashing);
    digitAnimator->position[0].x = 212;
    AnimatorSpriteDS__DrawFrame(digitAnimator);

    u16 centisecs                = FX_DivS32(checkpointTime->centiseconds, 10);
    digitAnimator                = GetHUDTimeNumAnimator(centisecs, isFlashing);
    digitAnimator->position[0].x = 232;
    AnimatorSpriteDS__DrawFrame(digitAnimator);

    centisecs                    = checkpointTime->centiseconds - 10 * centisecs;
    digitAnimator                = GetHUDTimeNumAnimator(centisecs, isFlashing);
    digitAnimator->position[0].x = 244;
    AnimatorSpriteDS__DrawFrame(digitAnimator);

    digitAnimator                = GetHUDTimeNumAnimator(HUD_DIGIT_COLON, isFlashing);
    digitAnimator->position[0].x = 187;
    digitAnimator->position[0].y = 21;
    digitAnimator->screensToDraw = SCREEN_DRAW_B;
    AnimatorSpriteDS__DrawFrame(digitAnimator);

    digitAnimator                = GetHUDTimeNumAnimator(HUD_DIGIT_COLON2, isFlashing);
    digitAnimator->position[0].x = 219;
    digitAnimator->position[0].y = 21;
    digitAnimator->screensToDraw = SCREEN_DRAW_B;
    AnimatorSpriteDS__DrawFrame(digitAnimator);

    if (checkpointTime->timer <= 0)
        DestroyCurrentTask();
}

// LapTimeHUD
void LapTimeHUD_Destructor(Task *task)
{
    lapTimes = NULL;
}

void LapTimeHUD_Main(void)
{
    s32 i;
    s32 colonY;
    s16 timeY = 112;

    for (i = 0; i < 5; i++, timeY += 16)
    {
        AnimatorSpriteDS *digitAnimator = GetHUDTimeNumAnimator(i + 1, FALSE);
        digitAnimator->position[1].x    = 8;
        digitAnimator->position[1].y    = timeY;
        digitAnimator->screensToDraw    = SCREEN_DRAW_A;
        AnimatorSpriteDS__DrawFrame(digitAnimator);

        digitAnimator                = GetHUDTimeNumAnimator(lapTimes->minutes[i], FALSE);
        digitAnimator->position[1].x = 32;
        AnimatorSpriteDS__DrawFrame(digitAnimator);

        u16 secs                     = FX_DivS32(lapTimes->seconds[i], 10);
        digitAnimator                = GetHUDTimeNumAnimator(secs, FALSE);
        digitAnimator->position[1].x = 52;
        AnimatorSpriteDS__DrawFrame(digitAnimator);

        secs                         = lapTimes->seconds[i] - 10 * secs;
        digitAnimator                = GetHUDTimeNumAnimator(secs, FALSE);
        digitAnimator->position[1].x = 64;
        AnimatorSpriteDS__DrawFrame(digitAnimator);

        u16 centisecs                = FX_DivS32(lapTimes->milliseconds[i], 10);
        digitAnimator                = GetHUDTimeNumAnimator(centisecs, FALSE);
        digitAnimator->position[1].x = 84;
        AnimatorSpriteDS__DrawFrame(digitAnimator);

        centisecs                    = lapTimes->milliseconds[i] - 10 * centisecs;
        digitAnimator                = GetHUDTimeNumAnimator(centisecs, FALSE);
        digitAnimator->position[1].x = 96;
        AnimatorSpriteDS__DrawFrame(digitAnimator);

        digitAnimator                = GetHUDTimeNumAnimator(HUD_DIGIT_COLON, FALSE);
        digitAnimator->position[1].x = 39;
        colonY                       = timeY - 8;
        digitAnimator->position[1].y = colonY;
        digitAnimator->screensToDraw = SCREEN_DRAW_A;
        AnimatorSpriteDS__DrawFrame(digitAnimator);

        digitAnimator                = GetHUDTimeNumAnimator(HUD_DIGIT_COLON2, FALSE);
        digitAnimator->position[1].x = 71;
        digitAnimator->position[1].y = colonY;
        digitAnimator->screensToDraw = SCREEN_DRAW_A;
        AnimatorSpriteDS__DrawFrame(digitAnimator);
    }
}

// ConnectionStatusHUD
void ConnectionStatusHUD_Destructor(Task *task)
{
    ConnectionStatusHUD *work = TaskGetWork(task, ConnectionStatusHUD);

    AnimatorSpriteDS__Release(&work->animators[WIFISTATUSHUD_ANIMATOR_LINKLEVEL]);
    AnimatorSpriteDS__Release(&work->animators[WIFISTATUSHUD_ANIMATOR_BORDER]);
}

void ConnectionStatusHUD_Main(void)
{
    ConnectionStatusHUD *work = TaskGetWorkCurrent(ConnectionStatusHUD);

    WMLinkLevel linkLevel;
    if (work->useDWC == FALSE)
        linkLevel = WirelessManager__GetLinkLevel();
    else
        linkLevel = DWC_GetLinkLevel();

    if (linkLevel != work->lastLinkLevel)
    {
        AnimatorSpriteDS__SetAnimation(&work->animators[WIFISTATUSHUD_ANIMATOR_LINKLEVEL], work->animID + linkLevel);
        AnimatorSpriteDS__ProcessAnimationFast(&work->animators[WIFISTATUSHUD_ANIMATOR_LINKLEVEL]);
        work->lastLinkLevel = linkLevel;
    }

    if (renderCurrentDisplay == GX_DISP_SELECT_MAIN_SUB)
    {
        work->animators[WIFISTATUSHUD_ANIMATOR_LINKLEVEL].position[1].y = 10;
        work->animators[WIFISTATUSHUD_ANIMATOR_BORDER].position[1].y    = 10;
    }
    else
    {
        work->animators[WIFISTATUSHUD_ANIMATOR_LINKLEVEL].position[1].y = 182;
        work->animators[WIFISTATUSHUD_ANIMATOR_BORDER].position[1].y    = 182;
    }

    AnimatorSpriteDS__DrawFrame(&work->animators[WIFISTATUSHUD_ANIMATOR_LINKLEVEL]);
    AnimatorSpriteDS__DrawFrame(&work->animators[WIFISTATUSHUD_ANIMATOR_BORDER]);
}

// TargetIndicatorHUD
void TargetIndicatorHUD_Destructor(Task *task)
{
    TargetIndicatorHUD *work = TaskGetWork(task, TargetIndicatorHUD);

    AnimatorSprite__Release(&work->animator);
}

void TargetIndicatorHUD_Main(void)
{
    Player *player;

    TargetIndicatorHUD *work = TaskGetWorkCurrent(TargetIndicatorHUD);
    StageTask *target        = work->target;

    if ((target->flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) != 0)
    {
        DestroyCurrentTask();
        return;
    }

    if (CheckHUDVisible())
    {
        MapSysCamera *camera = &mapCamera.camera[0];
        player               = gPlayer;

        fx32 originY;
        if ((mapCamera.camControl.flags & MAPSYS_CAMERACTRL_FLAG_USE_TWO_SCREENS) != 0)
        {
            camera  = MapSys__GetCameraA();
            originY = FLOAT_TO_FX32(464.0);
        }
        else
        {
            originY = FLOAT_TO_FX32(192.0);
        }

        if ((camera->disp_pos.x - FLOAT_TO_FX32(16.0) > target->position.x || target->position.x > camera->disp_pos.x + FLOAT_TO_FX32(BOTTOM_SCREEN_CAMERA_OFFSET))
            || (camera->disp_pos.y - FLOAT_TO_FX32(16.0) > target->position.y || target->position.y > camera->disp_pos.y + originY + FLOAT_TO_FX32(16.0)))
        {
            fx32 distX = target->position.x - player->objWork.position.x;
            fx32 distY = target->position.y - player->objWork.position.y;
            u16 angle  = FX_Atan2Idx(distY, distX);

            u16 anim = ((s32)((u16)(angle + FLOAT_DEG_TO_IDX(112.5))) >> 13) + 11;
            if (work->animator.animID != anim)
                AnimatorSprite__SetAnimation(&work->animator, anim);

            if (MATH_ABS(distX) <= FLOAT_TO_FX32(512.0) && MATH_ABS(distY) <= FLOAT_TO_FX32(512.0))
            {
                work->animator.animAdvance = FLOAT_TO_FX32(1.0);
            }
            else if (MATH_ABS(distX) <= FLOAT_TO_FX32(1536.0) && MATH_ABS(distY) <= FLOAT_TO_FX32(1536.0))
            {
                work->animator.animAdvance = FLOAT_TO_FX32(0.5);
            }
            else
            {
                work->animator.animAdvance = FLOAT_TO_FX32(0.3333);
            }

            fx32 drawX = FX32_TO_WHOLE((CosFX((s32)angle) << 8) + FLOAT_TO_FX32(128.0));
            fx32 drawY = FX32_TO_WHOLE((SinFX((s32)angle) << 8) + FLOAT_TO_FX32(96.0));

            work->animator.pos.x = MTM_MATH_CLIP(drawX, 12, 244);
            work->animator.pos.y = MTM_MATH_CLIP(drawY, 12, 180);
            AnimatorSprite__ProcessAnimationFast(&work->animator);
            AnimatorSprite__DrawFrame(&work->animator);
        }
    }
}

// RaceProgressHUD
void RaceProgressHUD_Destructor(Task *task)
{
    RaceProgressHUD *work = TaskGetWork(task, RaceProgressHUD);

    for (s32 i = 0; i < 5; i++)
    {
        AnimatorSprite__Release(&work->animators[i]);
    }
}

void RaceProgressHUD_Main(void)
{
    RaceProgressHUD *work = TaskGetWorkCurrent(RaceProgressHUD);

    s32 end = FX32_FROM_WHOLE(mapCamera.camControl.width);

    if (CheckHUDVisible())
    {
        if (gPlayerList[1] != NULL)
        {
            fx32 player1X = FX_Div(gPlayer->objWork.position.x, end);
            fx32 player2X = FX_Div(gPlayerList[1]->objWork.position.x, end);

            work->animators[RACEPROGRESSHUD_ANIMATOR_P1_ICON].pos.x = MultiplyFX(184, player1X) + 36;
            AnimatorSprite__DrawFrame(&work->animators[RACEPROGRESSHUD_ANIMATOR_P1_ICON]);

            work->animators[RACEPROGRESSHUD_ANIMATOR_P2_ICON].pos.x = MultiplyFX(184, player2X) + 36;
            AnimatorSprite__DrawFrame(&work->animators[RACEPROGRESSHUD_ANIMATOR_P2_ICON]);

            AnimatorSprite__DrawFrame(&work->animators[RACEPROGRESSHUD_ANIMATOR_START]);
            AnimatorSprite__DrawFrame(&work->animators[RACEPROGRESSHUD_ANIMATOR_GOAL]);

            work->animators[RACEPROGRESSHUD_ANIMATOR_COURSE].pos.x = 48;
            for (s32 i = 0; i < 5; i++)
            {
                AnimatorSprite__DrawFrame(&work->animators[2]);
                work->animators[RACEPROGRESSHUD_ANIMATOR_COURSE].pos.x += 32;
            }
        }
    }
}

// PassFlagMissionHUD
void CreatePassFlagMissionHUD(void)
{
    static const u8 spriteSize[] = { 1, 2 };

    Task *task = TaskCreate(PassFlagMissionHUD_Main, PassFlagMissionHUD_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3), PassFlagMissionHUD);
    if (task == HeapNull)
        return;

    PassFlagMissionHUD *work = TaskGetWork(task, PassFlagMissionHUD);
    TaskInitWork16(work);

    s32 i;
    void *spriteFile = ObjDataLoad(GetObjectFileWork(OBJDATAWORK_2), "/ac_fix_msn.bac", gameArchiveCommon);
    for (i = 0; i < PASSFLAGSHUD_ANIMATOR_COUNT; i++)
    {
        AnimatorSpriteDS *animator = &work->animators[i];

        AnimatorSpriteDS__Init(animator, spriteFile, i, SCREEN_DRAW_B, ANIMATOR_FLAG_DISABLE_PALETTES, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, spriteSize[i]),
                               PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, 0, PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
        animator->work.cParam.palette = PALETTE_ROW_0;
        animator->cParam[0].palette = animator->cParam[1].palette = animator->work.cParam.palette;
        AnimatorSpriteDS__ProcessAnimationFast(animator);
    }

    work->animators[PASSFLAGSHUD_ANIMATOR_SLASH].position[0].x = 109;
    work->animators[PASSFLAGSHUD_ANIMATOR_SLASH].position[0].y = 9;

    work->animators[PASSFLAGSHUD_ANIMATOR_FLAG].position[0].x = 78;
    work->animators[PASSFLAGSHUD_ANIMATOR_FLAG].position[0].y = 17;
}

void PassFlagMissionHUD_Destructor(Task *task)
{
    PassFlagMissionHUD *work = TaskGetWork(task, PassFlagMissionHUD);

    AnimatorSpriteDS__Release(&work->animators[PASSFLAGSHUD_ANIMATOR_SLASH]);
    AnimatorSpriteDS__Release(&work->animators[PASSFLAGSHUD_ANIMATOR_FLAG]);

    ObjDataRelease(GetObjectFileWork(OBJDATAWORK_2));
}

void PassFlagMissionHUD_Main(void)
{
    PassFlagMissionHUD *work = TaskGetWorkCurrent(PassFlagMissionHUD);

    if (CheckHUDVisible())
    {
        AnimatorSpriteDS *aniDigit;

        // Draw current flag id
        u16 digit1 = FX_DivS32(playerGameStatus.missionStatus.passedFlagID, 10);
        u16 digit2 = digit1;
        if (digit1 != 0)
        {
            aniDigit                = GetHUDTimeNumAnimator(digit1, FALSE);
            aniDigit->position[0].x = 93;
            aniDigit->position[0].y = 17;
            aniDigit->screensToDraw = SCREEN_DRAW_B;
            AnimatorSpriteDS__DrawFrame(aniDigit);
        }

        aniDigit                = GetHUDTimeNumAnimator(playerGameStatus.missionStatus.passedFlagID - 10 * digit2, FALSE);
        aniDigit->position[0].x = 103;
        aniDigit->position[0].y = 17;
        aniDigit->screensToDraw = SCREEN_DRAW_B;
        AnimatorSpriteDS__DrawFrame(aniDigit);

        // Draw total flag count
        digit1 = FX_DivS32(playerGameStatus.missionStatus.quota, 10);
        digit2 = digit1;
        if (digit1 != 0)
        {
            aniDigit                = GetHUDTimeNumAnimator(digit1, 0);
            aniDigit->position[0].x = 123;
            aniDigit->position[0].y = 17;
            aniDigit->screensToDraw = SCREEN_DRAW_B;
            AnimatorSpriteDS__DrawFrame(aniDigit);
        }

        aniDigit                = GetHUDTimeNumAnimator(playerGameStatus.missionStatus.quota - 10 * digit2, FALSE);
        aniDigit->position[0].x = 133;
        aniDigit->position[0].y = 17;
        aniDigit->screensToDraw = SCREEN_DRAW_B;
        AnimatorSpriteDS__DrawFrame(aniDigit);

        // Draw icons
        AnimatorSpriteDS__DrawFrame(&work->animators[PASSFLAGSHUD_ANIMATOR_SLASH]);
        AnimatorSpriteDS__DrawFrame(&work->animators[PASSFLAGSHUD_ANIMATOR_FLAG]);
    }
}

// CollectRingsMissionHUD
void CreateCollectRingsMissionHUD(void)
{
    Task *task = TaskCreate(CollectRingsMissionHUD_Main, CollectRingsMissionHUD_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3),
                            CollectRingsMissionHUD);
    if (task == HeapNull)
        return;

    CollectRingsMissionHUD *work = TaskGetWork(task, CollectRingsMissionHUD);
    TaskInitWork16(work);

    AnimatorSpriteDS__Init(&work->animator, ObjDataLoad(GetObjectFileWork(OBJDATAWORK_2), "/ac_fix_msn.bac", gameArchiveCommon), HUD_MSNANI_RING_ICON, SCREEN_DRAW_B,
                           ANIMATOR_FLAG_DISABLE_PALETTES, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, 2), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, 0,
                           PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    work->animator.work.cParam.palette = PALETTE_ROW_2;
    work->animator.cParam[0].palette = work->animator.cParam[1].palette = PALETTE_ROW_2;
    AnimatorSpriteDS__ProcessAnimationFast(&work->animator);

    work->animator.position[0].x = 88;
    work->animator.position[0].y = 17;
}

void CollectRingsMissionHUD_Destructor(Task *task)
{
    CollectRingsMissionHUD *work = TaskGetWork(task, CollectRingsMissionHUD);

    AnimatorSpriteDS__Release(&work->animator);

    ObjDataRelease(GetObjectFileWork(OBJDATAWORK_2));
}

void CollectRingsMissionHUD_Main(void)
{
    CollectRingsMissionHUD *work = TaskGetWorkCurrent(CollectRingsMissionHUD);

    s16 digitBase[] = { 100, 10, 1 };
    if (CheckHUDVisible())
    {
        s32 i;
        u32 quota  = playerGameStatus.missionStatus.quota;
        s32 digitX = 103;

        for (i = 0; i < 3; i++)
        {
            u16 digit = FX_DivS32(quota, digitBase[i]);
            quota -= digit * digitBase[i];

            AnimatorSpriteDS *aniDigit = GetHUDTimeNumAnimator(digit, FALSE);
            aniDigit->position[0].x    = digitX;
            aniDigit->position[0].y    = 17;
            aniDigit->screensToDraw    = SCREEN_DRAW_B;
            AnimatorSpriteDS__DrawFrame(aniDigit);

            digitX += 10;
        }

        AnimatorSpriteDS__DrawFrame(&work->animator);
    }
}

// GenericQuotaMissionHUD
void CreateGenericQuotaMissionHUD(void)
{
    Task *task = TaskCreate(GenericQuotaMissionHUD_Main, GenericQuotaMissionHUD_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4800, TASK_GROUP(3),
                            GenericQuotaMissionHUD);
    if (task == HeapNull)
        return;

    GenericQuotaMissionHUD *work = TaskGetWork(task, GenericQuotaMissionHUD);
    TaskInitWork16(work);

    AnimatorSpriteDS__Init(&work->animator, ObjDataLoad(GetObjectFileWork(OBJDATAWORK_2), "/ac_fix_msn.bac", gameArchiveCommon), HUD_MSNANI_SLASH, SCREEN_DRAW_B,
                           ANIMATOR_FLAG_DISABLE_PALETTES, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, 1), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, PIXEL_MODE_SPRITE, 0,
                           PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    work->animator.work.cParam.palette = PALETTE_ROW_0;
    work->animator.cParam[0].palette = work->animator.cParam[1].palette = PALETTE_ROW_0;
    AnimatorSpriteDS__ProcessAnimationFast(&work->animator);

    if (gmCheckGameMode(GAMEMODE_VS_BATTLE))
    {
        work->animator.position[0].x = 82;
        work->animator.position[0].y = 5;
    }
    else
    {
        work->animator.position[0].x = 101;
        work->animator.position[0].y = 9;
    }
}

void GenericQuotaMissionHUD_Destructor(Task *task)
{
    GenericQuotaMissionHUD *work = TaskGetWork(task, GenericQuotaMissionHUD);

    AnimatorSpriteDS__Release(&work->animator);

    ObjDataRelease(GetObjectFileWork(OBJDATAWORK_2));
}

void GenericQuotaMissionHUD_Main(void)
{
    GenericQuotaMissionHUD *work = TaskGetWorkCurrent(GenericQuotaMissionHUD);

    if (CheckHUDVisible())
    {
        u32 current;
        u32 total;

        if (gmCheckGameMode(GAMEMODE_MISSION))
        {
            if (gameState.missionType == MISSION_TYPE_DEFEAT_ENEMIES || gameState.missionType != MISSION_TYPE_PERFORM_TRICKS)
                current = playerGameStatus.missionStatus.enemyDefeatCount;
            else
                current = playerGameStatus.missionStatus.totalStarCount;

            total = playerGameStatus.missionStatus.quota;
        }
        else
        {
            total   = 5;
            current = lapID;
        }

        if (current > 99)
            current = 99;

        if (total > 99)
            total = 99;

        u16 digit1;
        u16 digit2;
        s16 digitY;
        s16 currentDigitX;
        s16 totalDigitX;
        if (gmCheckGameMode(GAMEMODE_VS_BATTLE))
        {
            digitY        = 13;
            currentDigitX = 66;
            totalDigitX   = 86;
        }
        else
        {
            digitY        = 17;
            currentDigitX = 85;
            totalDigitX   = 115;
        }

        // Draw current count
        digit1 = FX_DivS32(current, 10);
        digit2 = digit1;
        if (digit1 != 0)
        {
            AnimatorSpriteDS *aniDigit = GetHUDTimeNumAnimator(digit1, FALSE);
            aniDigit->position[0].x    = currentDigitX;
            aniDigit->position[0].y    = digitY;
            aniDigit->screensToDraw    = SCREEN_DRAW_B;
            AnimatorSpriteDS__DrawFrame(aniDigit);
        }

        AnimatorSpriteDS *aniDigit = GetHUDTimeNumAnimator(current - 10 * digit2, FALSE);
        aniDigit->position[0].x    = currentDigitX + 10;
        aniDigit->position[0].y    = digitY;
        aniDigit->screensToDraw    = SCREEN_DRAW_B;
        AnimatorSpriteDS__DrawFrame(aniDigit);

        // Draw total count
        digit1 = FX_DivS32(total, 10);
        digit2 = digit1;
        if (digit1 != 0)
        {
            aniDigit                = GetHUDTimeNumAnimator(digit1, FALSE);
            aniDigit->position[0].x = totalDigitX;
            aniDigit->position[0].y = digitY;
            AnimatorSpriteDS__DrawFrame(aniDigit);
        }

        aniDigit                = GetHUDTimeNumAnimator(total - 10 * digit2, FALSE);
        aniDigit->position[0].x = totalDigitX + 10;
        aniDigit->position[0].y = digitY;
        AnimatorSpriteDS__DrawFrame(aniDigit);
        AnimatorSpriteDS__DrawFrame(&work->animator);
    }
}

// TimeAttackReplayHUD
void CreateTimeAttackReplayHUD(void)
{
    Task *task = TaskCreate(TimeAttackReplayHUD_Main, TimeAttackReplayHUD_Destructor, TASK_FLAG_NONE, 0, 0x4800, TASK_GROUP(3), TimeAttackReplayHUD);
    if (task == HeapNull)
        return;

    TimeAttackReplayHUD *work = TaskGetWork(task, TimeAttackReplayHUD);
    TaskInitWork16(work);

    GraphicsEngine engine = IsBossStage() ? GRAPHICS_ENGINE_A : GRAPHICS_ENGINE_B;

    void *spriteFile = ObjDataLoad(NULL, "/act/ac_fix_replay.bac", gameArchiveMission);
    AnimatorSprite__Init(&work->animator, spriteFile, 0, ANIMATOR_FLAG_DISABLE_LOOPING, engine, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(engine, 8), PALETTE_MODE_SPRITE,
                         VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    work->animator.cParam.palette = PALETTE_ROW_0;
    work->animator.pos.x          = 240;
}

void TimeAttackReplayHUD_Destructor(Task *task)
{
    TimeAttackReplayHUD *work = TaskGetWork(task, TimeAttackReplayHUD);
    AnimatorSprite__Release(&work->animator);
}

void TimeAttackReplayHUD_Main(void)
{
    TimeAttackReplayHUD *work = TaskGetWorkCurrent(TimeAttackReplayHUD);

    if (hudWorkSingleton != NULL && hudWorkSingleton->loadedSprites)
    {
        if (IsBossStage())
        {
            if (Camera3D__UseEngineA() && (hudWorkSingleton->flags & HUD_FLAG_USE_SCREEN_B) == 0)
            {
                work->animator.pos.y = 184;
            }
            else if (!Camera3D__UseEngineA() && (hudWorkSingleton->flags & HUD_FLAG_USE_SCREEN_B) != 0)
            {
                work->animator.pos.y = 8;
            }
            else
            {
                return;
            }
        }
        else
        {
            if (renderCurrentDisplay == GX_DISP_SELECT_MAIN_SUB)
                work->animator.pos.y = 8;
            else
                work->animator.pos.y = 184;
        }

        AnimatorSprite__ProcessAnimationFast(&work->animator);
        AnimatorSprite__DrawFrame(&work->animator);
    }
}
