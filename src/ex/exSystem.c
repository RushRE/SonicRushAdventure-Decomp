#include <ex/system/exSystem.h>
#include <ex/system/exGameSystem.h>
#include <ex/system/exStage.h>
#include <ex/system/exDrawFade.h>
#include <ex/system/exHitCheck.h>
#include <ex/core/exHUD.h>
#include <ex/core/exPauseMenu.h>
#include <ex/core/exTitleCard.h>
#include <ex/system/exSave.h>
#include <game/audio/audioSystem.h>
#include <game/save/saveGame.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/drawState.h>
#include <game/file/fsRequest.h>
#include <game/file/binaryBundle.h>
#include <game/input/padInput.h>

// resources
#include <resources/extra/ex.h>
#include <resources/extra/ex/ex_com.h>

// --------------------
// VARIABLES
// --------------------

struct TEMP_STATIC_VARS
{
    u8 exSysTask__lives;

    exSysTask *exSysTask__Singleton;
    Task *exSysTask__TaskSingleton;

    BOOL exStageFinished;
    BOOL exStageWillExit;
    exSysTaskStatus exSysTaskStatus;
};

NOT_DECOMPILED struct TEMP_STATIC_VARS exSysTask__sVars;

// NOT_DECOMPILED u8 exSysTask__lives;

// NOT_DECOMPILED exSysTask *exSysTask__Singleton;
// NOT_DECOMPILED Task *exSysTask__TaskSingleton;

// NOT_DECOMPILED BOOL exStageFinished;
// NOT_DECOMPILED BOOL exStageWillExit;
// NOT_DECOMPILED exSysTaskStatus exSysTaskStatus;

// --------------------
// FUNCTION DECLS
// --------------------

static void ExSystem_Main_Init(void);
static void ExSystem_TaskUnknown(void);
static void ExSystem_Destructor(void);
static void ExSystem_Main_WaitForStageStarted(void);
static void ExSystem_Action_Resume(void);
static void ExSystem_Main_Active(void);
static void ExSystem_Action_Pause(void);
static void ExSystem_Main_WaitingForPauseMenu(void);
static void ExSystem_Main_ExitSelected(void);
static void ExSystem_Action_BeginExitFadeOut(void);
static void ExSystem_Main_ExitFadeOut(void);
static void ExSystem_Action_StageCleared(void);
static void ExSystem_Main_StageCleared(void);
static void ExSystem_Action_BeginDeathFadeOut(void);
static void ExSystem_Main_DeathFadeOut(void);
static void ExSystem_Main_StageRestartDelay(void);
static void ExSystem_Main_DoStageRestart(void);
static void ExSystem_Main_DoStageExit(void);
static void ExSystem_Main_EndStage(void);

static void LoadExSystemAssets(exSysTask *work);
static void SetupExSystemDisplay(exSysTask *work);

// --------------------
// FUNCTIONS
// --------------------

s32 GetExSystemLifeCount(void)
{
    return exSysTask__sVars.exSysTask__lives;
}

void LoseExSystemLife(void)
{
    exSysTask__sVars.exSysTask__lives--;
}

NONMATCH_FUNC void InitExSystemStatus(void)
{
    // https://decomp.me/scratch/BA0pP -> 68.79%
#ifdef NON_MATCHING
    exSysTask__sVars.exSysTaskStatus.finishMode    = EXFINISHMODE_RUNNING;
    exSysTask__sVars.exSysTaskStatus.state         = EXSYSTASK_STATE_STARTED;
    exSysTask__sVars.exSysTaskStatus.rings         = 50;
    exSysTask__sVars.exSysTaskStatus.difficulty    = saveGame.stage.status.difficulty != DIFFICULTY_EASY ? EXSYS_DIFFICULTY_NORMAL : EXSYS_DIFFICULTY_EASY;
    exSysTask__sVars.exSysTaskStatus.timeLimitMode = saveGame.stage.status.timeLimit != FALSE ? EXSYS_TIMELIMIT_ON : EXSYS_TIMELIMIT_OFF;

    exSysTask__sVars.exSysTaskStatus.lives = GetExSystemLifeCount();
    MI_CpuClear8(&exSysTask__sVars.exSysTaskStatus.time, sizeof(exSysTask__sVars.exSysTaskStatus.time));
#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =saveGame
	ldr r1, =exSysTask__sVars
	ldr r0, [r0, #0x1c0]
	mov r3, #1
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	ldr r0, =saveGame
	strb r3, [r1, #0x15]
	ldr r0, [r0, #0x1c0]
	strb r3, [r1, #0x17]
	mov r2, #0x32
	strh r2, [r1, #0x1a]
	ldr r1, =exSysTask__sVars
	moveq r3, #2
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	strb r3, [r1, #0x14]
	movne r1, #1
	ldr r0, =exSysTask__sVars
	moveq r1, #2
	strb r1, [r0, #0x16]
	bl GetExSystemLifeCount
	ldr r2, =exSysTask__sVars
	mov r1, #0
	strb r0, [r2, #0x18]
	ldr r0, =0x2178658+0x8
	mov r2, #0xc
	bl MI_CpuFill8
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

exSysTaskStatus *GetExSystemStatus(void)
{
    return &exSysTask__sVars.exSysTaskStatus;
}

BOOL CheckExStageFinished(void)
{
    return exSysTask__sVars.exStageFinished;
}

void ExSystem_Main_Init(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    exSysTask__sVars.exSysTask__lives         = saveGame.stage.status.lives;
    exSysTask__sVars.exSysTask__TaskSingleton = GetCurrentTask();

    LoadExSystemAssets(work);
    SetupExSystemDisplay(work);
    Camera3D__Create();

    Camera3DTask *cameraA = Camera3D__GetWork();
    Camera3DTask *cameraB = Camera3D__GetWork();

    cameraA->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.value = cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.value = 0;

    cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane1_BG0 = TRUE;
    cameraA->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.plane1_BG0 = cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane1_BG0;

    cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane2_BG1 = TRUE;
    cameraA->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.plane2_BG1 = cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane2_BG1;

    cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane2_BG2 = TRUE;
    cameraA->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.plane2_BG2 = cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane2_BG2;

    cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane2_BG3 = TRUE;
    cameraA->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.plane2_BG3 = cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane2_BG3;

    cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane2_OBJ = TRUE;
    cameraA->gfxControl[GRAPHICS_ENGINE_A].blendManager.blendControl.plane2_OBJ = cameraB->gfxControl[GRAPHICS_ENGINE_B].blendManager.blendControl.plane2_OBJ;

    Camera3DTask *camera = Camera3D__GetWork();
    RenderCore_SetBlendBrightnessExt(VOID_TO_INT(&camera->gfxControl[1].blendManager), 16, 1, 31, 31, 0);
    InitExSystemStatus();
    LoadExDrawConfig(EXDRAW_CAMERACONFIG_1, EXDRAWREQ_LIGHT_BLUE);
    CreateExDrawReqTask();
    exHitCheckTask_Create();
    CreateExGameSystem();
    CreateExHUD();

    GetExSystemStatus()->state = EXSYSTASK_STATE_INTRO;

    CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_DEFAULT, 32, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_A);
    CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_DEFAULT, 32, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_B);

    SetCurrentExTaskMainEvent(ExSystem_Main_WaitForStageStarted);
}

void ExSystem_TaskUnknown(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);
    UNUSED(work);
}

void ExSystem_Destructor(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    DestroyExHUD();
    DestroyExGameSystem();
    HeapFree(HEAP_USER, work->drawState);
    HeapFree(HEAP_USER, work->archiveCommon);
    NNS_SndStopSoundAll();
    ReleaseAudioSystem();
    NNS_G3dGeUseFastDma(FALSE);

    exSysTask__sVars.exSysTask__TaskSingleton = NULL;
    exSysTask__sVars.exSysTask__Singleton     = NULL;
}

void ExSystem_Main_WaitForStageStarted(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    if (GetExSystemStatus()->state != EXSYSTASK_STATE_INTRO)
    {
        GetExSystemStatus()->state = EXSYSTASK_STATE_BOSS_ACTIVE;
        ExSystem_Action_Resume();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExSystem_Action_Resume(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);
    UNUSED(work);

    SetCurrentExTaskMainEvent(ExSystem_Main_Active);
    ExSystem_Main_Active();

    RunCurrentExTaskUnknownEvent();
}

void ExSystem_Main_Active(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);
    UNUSED(work);

    if (GetExSystemStatus()->state != EXSYSTASK_STATE_STAGE_FINISHED && GetExSystemStatus()->state != EXSYSTASK_STATE_BOSS_HEAL_PHASE2_STARTED
        && GetExSystemStatus()->state != EXSYSTASK_STATE_BOSS_HEAL_PHASE3_STARTED && GetExTitleCardTaskSingleton() == NULL && (padInput.btnPress & PAD_BUTTON_START) != 0)
    {
        ExSystem_Action_Pause();
    }
    else
    {
        if (GetExSystemStatus()->finishMode == EXFINISHMODE_PLAYER_DEATH)
        {
            GetExSystemStatus()->state = EXSYSTASK_STATE_STAGE_FINISHED;
            ExSystem_Action_BeginDeathFadeOut();
        }
        else if (GetExSystemStatus()->finishMode == EXFINISHMODE_BOSS_DEFEATED)
        {
            ExSystem_Action_StageCleared();
        }
        else
        {
            exHitCheckTask_DecPauseLevel();

            RunCurrentExTaskUnknownEvent();
        }
    }
}

void ExSystem_Action_Pause(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);
    UNUSED(work);

    exHitCheckTask_SetPauseLevel(1);
    GetExSystemStatus()->finishMode = EXFINISHMODE_PAUSED;
    CreateExPauseMenu();
    SetCurrentExTaskMainEvent(ExSystem_Main_WaitingForPauseMenu);
}

void ExSystem_Main_WaitingForPauseMenu(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    if (GetExPauseMenuSelectedAction() == EXPAUSEMENU_ACTION_CONTINUE)
    {
        GetExSystemStatus()->finishMode = EXFINISHMODE_RUNNING;
        SetCurrentExTaskMainEvent(ExSystem_Action_Resume);
    }
    else if (GetExPauseMenuSelectedAction() == EXPAUSEMENU_ACTION_BACK)
    {
        work->timer                = 10;
        GetExSystemStatus()->state = EXSYSTASK_STATE_STAGE_FINISHED;
        SetCurrentExTaskMainEvent(ExSystem_Main_ExitSelected);
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExSystem_Main_ExitSelected(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    if (work->timer-- <= 0)
    {
        ExSystem_Action_BeginExitFadeOut();
    }
    else
    {
        exHitCheckTask_DecPauseLevel();

        RunCurrentExTaskUnknownEvent();
    }
}

void ExSystem_Action_BeginExitFadeOut(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    GetExSystemStatus()->finishMode = EXFINISHMODE_USER_QUIT;
    CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_BLACK, 64, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_A);
    CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_BLACK, 64, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_B);

    work->timer = 64;

    SetCurrentExTaskMainEvent(ExSystem_Main_ExitFadeOut);
}

void ExSystem_Main_ExitFadeOut(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    if (work->timer-- <= 0)
    {
        exSysTask__sVars.exStageFinished = TRUE;
        work->timer                      = 5;

        SetCurrentExTaskMainEvent(ExSystem_Main_DoStageExit);
        ExSystem_Main_DoStageExit();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExSystem_Action_StageCleared(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    GetExSystemStatus()->finishMode = EXFINISHMODE_STAGE_CLEARED;
    CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_BLACK, 64, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_A);
    CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_BLACK, 64, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_B);

    work->timer = 64;

    SetCurrentExTaskMainEvent(ExSystem_Main_StageCleared);
}

void ExSystem_Main_StageCleared(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    if (work->timer-- <= 0)
    {
        exSysTask__sVars.exStageFinished = TRUE;
        work->timer                      = 5;

        SetCurrentExTaskMainEvent(ExSystem_Main_DoStageExit);
        ExSystem_Main_DoStageExit();
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExSystem_Action_BeginDeathFadeOut(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    if (GetExSystemLifeCount() == 0)
        GetExSystemStatus()->finishMode = EXFINISHMODE_GAME_OVER;
    else
        LoseExSystemLife();

    CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_BLACK, 64, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_A);
    CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_DEFAULT, RENDERCORE_BRIGHTNESS_BLACK, 64, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_B);

    work->timer = 64;

    SetCurrentExTaskMainEvent(ExSystem_Main_DeathFadeOut);
}

void ExSystem_Main_DeathFadeOut(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    if (work->timer-- <= 0)
    {
        exSysTask__sVars.exStageFinished = TRUE;

        if (GetExSystemStatus()->finishMode == EXFINISHMODE_GAME_OVER)
        {
            work->timer = 5;
            SetCurrentExTaskMainEvent(ExSystem_Main_DoStageExit);
            ExSystem_Main_DoStageExit();
        }
        else
        {
            work->timer = 5;
            SetCurrentExTaskMainEvent(ExSystem_Main_StageRestartDelay);
        }
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExSystem_Main_StageRestartDelay(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    if (work->timer-- <= 0)
    {
        DestroyExHUD();
        DestroyExGameSystem();
        exSysTask__sVars.exStageFinished = FALSE;
        work->timer                      = 15;

        SetCurrentExTaskMainEvent(ExSystem_Main_DoStageRestart);
    }

    RunCurrentExTaskUnknownEvent();
}

void ExSystem_Main_DoStageRestart(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    if (work->timer-- <= 0)
    {
        exSysTask__sVars.exStageWillExit = FALSE;

        InitExSystemStatus();
        CreateExDrawReqTask();
        exHitCheckTask_Create();
        CreateExGameSystem();
        CreateExHUD();

        CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_DEFAULT, 32, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_A);
        CreateExDrawFadeTask(RENDERCORE_BRIGHTNESS_BLACK, RENDERCORE_BRIGHTNESS_DEFAULT, 32, 0, EXDRAWFADETASK_FLAG_ON_ENGINE_B);
        GetExSystemStatus()->state = EXSYSTASK_STATE_INTRO;

        SetCurrentExTaskMainEvent(ExSystem_Main_WaitForStageStarted);
    }
    else
    {
        RunCurrentExTaskUnknownEvent();
    }
}

void ExSystem_Main_DoStageExit(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);

    if (work->timer-- <= 0)
    {
        DestroyExHUD();
        DestroyExGameSystem();
        exSysTask__sVars.exStageWillExit = TRUE;
        SetCurrentExTaskMainEvent(ExSystem_Main_EndStage);

        RunCurrentExTaskUnknownEvent();
    }
}

void ExSystem_Main_EndStage(void)
{
    exSysTask *work = ExTaskGetWorkCurrent(exSysTask);
    UNUSED(work);

    CloseTaskSystem();
    Camera3D__Destroy();
    EndExBossStage(GetExSystemStatus()->finishMode);
}

void CreateExSystem(void)
{
    Task *task = ExTaskCreate(ExSystem_Main_Init, ExSystem_Destructor, TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(1), 0, EXTASK_TYPE_ALWAYSUPDATE, exSysTask);

    exSysTask__sVars.exSysTask__Singleton = ExTaskGetWork(task, exSysTask);
    TaskInitWork8(exSysTask__sVars.exSysTask__Singleton);

    SetExTaskUnknownEvent(task, ExSystem_TaskUnknown);
}

void *LoadExSystemFile(u16 id)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "ex", exSysTask__sVars.exSysTask__Singleton->archiveCommon);
    void *memory = NNS_FndGetArchiveFileByIndex(&arc, id);
    NNS_FndUnmountArchive(&arc);

    return memory;
}

void *GetExSystemDrawState(void)
{
    return exSysTask__sVars.exSysTask__Singleton->drawState;
}

void LoadExSystemAssets(exSysTask *work)
{
    work->drawState = ReadFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_BSD_BSD, BINARYBUNDLE_AUTO_ALLOC_HEAD);

    void *memory = ReadFileFromBundle("/extra/ex.bb", BUNDLE_EX_FILE_RESOURCES_EXTRA_EX_EX_COM_NARC, BINARYBUNDLE_AUTO_ALLOC_TAIL);
    switch ((u32)MI_GetCompressionType(memory))
    {
        case MI_COMPRESSION_LZ:
            work->archiveCommon = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(memory));
            RenderCore_CPUCopyCompressed(memory, work->archiveCommon);
            HeapFree(HEAP_USER, memory);
            break;

        case MI_COMPRESSION_HUFFMAN:
        case MI_COMPRESSION_RL:
        case MI_COMPRESSION_DIFF:
            break;
    }

    work->sndArc = NNS_SndHeapAlloc(audioManagerSndHeap, 0x57800, NULL, 0, 0);
    FSRequestFileSync("/extra/sound_data.sdat", work->sndArc);
    InitAudioSystemForStage(work->sndArc);
}

NONMATCH_FUNC void SetupExSystemDisplay(exSysTask *work)
{
    // https://decomp.me/scratch/CHkye -> 84.26%
#ifdef NON_MATCHING
    VRAMSystem__Reset();
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_64_E, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);
    VRAMSystem__InitSpriteBuffer(GRAPHICS_ENGINE_A);
    VRAMSystem__SetupBGBank(GX_VRAM_BG_16_G);
    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_01_AB);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0_F);
    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_3D);
    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);

    renderCoreSwapBuffer.sortMode   = GX_SORTMODE_AUTO;
    renderCoreSwapBuffer.bufferMode = GX_BUFFERMODE_W;

    G2_SetBG0Priority(0);
    G2_SetBG1Priority(1);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(3);

    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_OBJ);
    RenderCore_DisableBlending(&renderCoreGFXControlA.blendManager);
    renderCoreGFXControlA.windowManager.visible = GX_WNDMASK_NONE;

    GXS_SetVisiblePlane(GX_PLANEMASK_NONE);
    RenderCore_DisableBlending(&renderCoreGFXControlB.blendManager);
    renderCoreGFXControlB.windowManager.visible = GX_WNDMASK_NONE;

    GX_SetPower(GX_POWER_ALL);
    G3_ViewPort(0, 0, HW_LCD_WIDTH - 1, HW_LCD_HEIGHT - 1);
    LoadDrawState(work->drawState, DRAWSTATE_ALL & ~(DRAWSTATE_LOOKAT | DRAWSTATE_PROJECTION | DRAWSTATE_SWAPBUFFERMODE));
    ReleaseAudioSystem();
    NNS_G3dGeUseFastDma(1);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r5, #0
	bl VRAMSystem__Reset
	mov r0, #0x10
	mov ip, #0x400
	add r1, r0, #0x100000
	mov r2, #0x40
	mov r3, r5
	str ip, [sp]
	bl VRAMSystem__SetupOBJBank
	mov r0, r5
	bl VRAMSystem__InitSpriteBuffer
	mov r0, #0x40
	bl VRAMSystem__SetupBGBank
	mov r0, #3
	bl VRAMSystem__SetupTextureBank
	mov r0, #0x20
	bl VRAMSystem__SetupTexturePalBank
	mov r0, #1
	mov r1, r5
	mov r2, r0
	bl GX_SetGraphicsMode
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	mov r2, r5
	bic r0, r0, #0x38000000
	str r0, [r1]
	ldr ip, [r1]
	ldr r0, =renderCoreSwapBuffer
	bic ip, ip, #0x7000000
	str ip, [r1]
	str r2, [r0, #4]
	mov r2, #1
	str r2, [r0, #8]
	ldrh r2, [r1, #8]
	orr r3, r5, #0x11
	ldr r0, =renderCoreGFXControlA+0x00000020
	bic r2, r2, #3
	strh r2, [r1, #8]
	ldrh r2, [r1, #0xa]
	bic r2, r2, #3
	orr r2, r2, #1
	strh r2, [r1, #0xa]
	ldrh r2, [r1, #0xc]
	bic r2, r2, #3
	orr r2, r2, #2
	strh r2, [r1, #0xc]
	ldrh r2, [r1, #0xe]
	bic r2, r2, #3
	orr r2, r2, #3
	strh r2, [r1, #0xe]
	ldr r2, [r1, #0]
	bic r2, r2, #0x1f00
	orr r2, r2, r3, lsl #8
	str r2, [r1]
	bl RenderCore_DisableBlending
	ldr r0, =renderCoreGFXControlA
	mov r1, r5
	str r1, [r0, #0x1c]
	ldr r2, =0x04001000
	ldr r0, =renderCoreGFXControlB+0x00000020
	ldr r1, [r2, #0]
	bic r1, r1, #0x1f00
	str r1, [r2]
	bl RenderCore_DisableBlending
	ldr r0, =renderCoreGFXControlB
	mov r1, r5
	str r1, [r0, #0x1c]
	ldr r3, =0x04000304
	ldr r0, =0xFFFFFDF1
	ldrh r2, [r3, #0]
	ldr r1, =0xBFFF0000
	and r0, r2, r0
	orr r0, r0, #0xe
	orr r0, r0, #0x200
	strh r0, [r3]
	str r1, [r3, #0x27c]
	ldr r0, [r4, #0]
	ldr r1, =0x001FFFF8
	bl LoadDrawState
	bl ReleaseAudioSystem
	mov r0, #1
	bl NNS_G3dGeUseFastDma
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}
