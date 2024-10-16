#include <menu/titleScreen.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/graphics/drawState.h>
#include <game/file/fileUnknown.h>
#include <game/file/fsRequest.h>
#include <game/audio/sysSound.h>
#include <game/system/sysEvent.h>
#include <game/math/mtMath.h>
#include <game/save/saveGame.h>

// resources
#include <resources/narc/dmti_lz7.h>
#include <resources/narc/dmop_pldm_lz7.h>

// --------------------
// CONSTANTS
// --------------------

#define TITLESCREEN_MAT_CAMERA_NODE 30
#define TITLESCREEN_MAT_TARGET_NODE 29

#define TITLESCREEN_IDLE_TIME SECONDS_TO_FRAMES(20.0)

// --------------------
// ENUMS
// --------------------

enum TitleScreenNextEvent_
{
    TITLESCREEN_NEXTEVENT_DEMO,
    TITLESCREEN_NEXTEVENT_HUB,
};
typedef u32 TitleScreenNextEvent;

enum TitleScreenPressStartAnimID
{
    TITLESCREENPRESSSTART_ANI_WAITING,
    TITLESCREENPRESSSTART_ANI_PRESSED,
};

// --------------------
// STRUCTS
// --------------------

typedef struct TitleScreenRenderCallbackConfig_
{
    void *resMdl;
    u16 nodeDesc;
    u16 mtxStore;
    void (*func)(NNSG3dRS *context, void *userData);
    void *userData;
} TitleScreenRenderCallbackConfig;

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED TitleScreenRenderCallbackConfig TitleScreenRenderCallbackList[16];
NOT_DECOMPILED u16 TitleScreenRenderCallbackCount;

// --------------------
// FUNCTION DECLS
// --------------------

// Helpers
void CreateTitleScreen(void);
void SetupDisplayForTitleScreen(void);
void InitTitleScreenAssets(TitleScreen *work);
void ReleaseTitleScreenAssets(TitleScreen *work);
void InitTitleScreenAnimators(TitleScreen *work);
void ReleaseTitleScreenAnimators(TitleScreen *work);
void InitTitleScreenBackgrounds(TitleScreen *work);
void ReleaseTitleScreenBackgrounds(TitleScreen *work);
void ClearTitleScreenTasks(void);
void ChangeEventForTitleScreen(TitleScreenNextEvent id);
void SetTitleScreenBrightness(fx32 brightness);
BOOL CheckTitleScreenConfirmPress(TitleScreen *work);
void SetTitleScreenAnimation3D(AnimatorMDL *animator, u32 type, NNSG3dResFileHeader *resource, s32 animID, const void *texResource, BOOL canLoop);
void TitleScreenRenderCallback(NNSG3dRS *rs);
void AddTitleScreenRenderCallback(NNSG3dResMdl *resMdl, const char *name, s16 mtxStore, void (*callback)(NNSG3dRS *context, void *userData), void *userData);
s32 GetTitleScreenNodeDesc(NNSG3dResMdl *resMdl, const char *name);
void GetTitleScreenMatrix(s32 id, MtxFx43 *dest);

// TitleScreen
void TitleScreen_Destructor(Task *task);
void TitleScreen_Main_Init(void);
void TitleScreen_Main_FadeIn(void);
void TitleScreen_Main_Active(void);
void TitleScreen_Main_InitFadeOut(void);
void TitleScreen_Main_FadeOut(void);
void TitleScreen_Main_ChangeEvent(void);

// TitleScreenBackgroundView
void CreateTitleScreenBackgroundView(TitleScreen *parent);
void TitleScreenBackgroundView_Destructor(Task *task);
void TitleScreenBackgroundView_Main_Init(void);
void TitleScreenBackgroundView_Main_Active(void);

// TitleScreenCopyrightIcon
void CreateTitleScreenCopyrightIcon(TitleScreen *parent);
void TitleScreenCopyrightIcon_Destructor(Task *task);
void TitleScreenCopyrightIcon_Main_Init(void);
void TitleScreenCopyrightIcon_Main_Active(void);
void TitleScreenCopyrightIcon_Main_Idle(void);

// TitleScreenPressStart
void CreateTitleScreenPressStart(TitleScreen *parent);
void TitleScreenPressStart_Destructor(Task *task);
void TitleScreenPressStart_Main_Init(void);
void TitleScreenPressStart_Main_AwaitPress(void);
void TitleScreenPressStart_Main_Pressed(void);
void TitleScreenPressStart_Main_Idle(void);

// --------------------
// FUNCTIONS
// --------------------

void InitTitleScreen(void)
{
    CreateTitleScreen();
}

void CreateTitleScreen(void)
{
    SetupDisplayForTitleScreen();

    Task *task = TaskCreate(TitleScreen_Main_Init, TitleScreen_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_SCOPE_0, TitleScreen);

    TitleScreen *work = TaskGetWork(task, TitleScreen);
    TaskInitWork16(work);

    InitTitleScreenAssets(work);
    InitTitleScreenAnimators(work);
    InitTitleScreenBackgrounds(work);

    CreateTitleScreenBackgroundView(work);
    CreateTitleScreenCopyrightIcon(work);

    StartSamplingTouchInput(4);

    LoadSysSound(SYSSOUND_GROUP_TITLE_2);
}

void SetupDisplayForTitleScreen(void)
{
    VRAMSystem__Reset();
    VRAMSystem__SetupTextureBank(GX_VRAM_TEX_01_AB);
    VRAMSystem__SetupTexturePalBank(GX_VRAM_TEXPLTT_0_G);
    VRAMSystem__SetupBGBank(GX_VRAM_BG_64_E);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_16_F, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);

    GX_SetPower(GX_POWER_ALL);
    GX_SetDispSelect(GX_DISP_SELECT_MAIN_SUB);

    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    GX_SetMasterBrightness(renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_WHITE);

    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_3D);
    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);

    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0xc000, GX_BG_CHARBASE_0x00000);

    renderCoreGFXControlA.bgPosition[BACKGROUND_0].x = renderCoreGFXControlA.bgPosition[BACKGROUND_0].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].x = renderCoreGFXControlA.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].x = renderCoreGFXControlA.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 0;

    G2_SetBG0Priority(3);
    G2_SetBG1Priority(2);
    G2_SetBG2Priority(1);
    G2_SetBG3Priority(0);

    void *vramPtr = VRAMSystem__VRAM_BG[0];
    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG2 | GX_PLANEMASK_OBJ);
    MI_CpuClear16(vramPtr, 0x10000);

    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_WHITE);

    GXS_SetVisiblePlane(GX_PLANEMASK_NONE);
}

void InitTitleScreenAssets(TitleScreen *work)
{
    FSRequestArchive("/narc/dmti_lz7.narc", &work->archiveTitleScreen, FALSE);
    FSRequestArchive("/narc/dmop_pldm_lz7.narc", &work->archiveOpeningCutscene, FALSE);

    work->worldControl.mdlCutscene[0]    = FileUnknown__GetAOUFile(work->archiveOpeningCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_02_NSBMD);
    work->worldControl.mdlCutscene[1]    = FileUnknown__GetAOUFile(work->archiveOpeningCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_07_NSBMD);
    work->worldControl.jntAniCutscene    = FileUnknown__GetAOUFile(work->archiveOpeningCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_01_NSBCA);
    work->worldControl.matAniCutscene    = FileUnknown__GetAOUFile(work->archiveOpeningCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_01_NSBMA);
    work->worldControl.texAniCutscene    = FileUnknown__GetAOUFile(work->archiveOpeningCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_01_NSBTA);
    work->worldControl.visAniCutscene    = FileUnknown__GetAOUFile(work->archiveOpeningCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_01_NSBVA);
    work->worldControl.drawStateCutscene = FileUnknown__GetAOUFile(work->archiveOpeningCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_07_BSD);
}

void ReleaseTitleScreenAssets(TitleScreen *work)
{
    HeapFree(HEAP_USER, work->archiveTitleScreen);
    HeapFree(HEAP_USER, work->archiveOpeningCutscene);
}

void InitTitleScreenAnimators(TitleScreen *work)
{
    TitleScreenWorldControl *control = &work->worldControl;

    void *drawState = control->drawStateCutscene;
    LoadDrawState(drawState, DRAWSTATE_ALL & ~(DRAWSTATE_LOOKAT));
    GetDrawStateCameraView(drawState, &control->cameraConfig);
    GetDrawStateCameraProjection(drawState, &control->cameraConfig);
    control->matProjPositionY = control->cameraConfig.config.projScaleW + MultiplyFX(FLOAT_TO_FX32(0.3125), control->cameraConfig.config.projScaleW);

    void *mdlCutsceneOpening = control->mdlCutscene[0];
    NNS_G3dResDefaultSetup(mdlCutsceneOpening);

    AnimatorMDL *aniSea = &control->aniSea;
    AnimatorMDL__Init(aniSea, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniSea, mdlCutsceneOpening, 0, FALSE, FALSE);

    AnimatorMDL *aniSkybox = &control->aniSkybox;
    AnimatorMDL__Init(aniSkybox, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniSkybox, mdlCutsceneOpening, 1, FALSE, FALSE);

    void *mdlCutsceneTitle = control->mdlCutscene[1];
    NNS_G3dResDefaultSetup(mdlCutsceneTitle);

    AnimatorMDL *aniCamera = &control->aniCamera;
    AnimatorMDL__Init(aniCamera, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniCamera, mdlCutsceneTitle, 0, FALSE, FALSE);

    AnimatorMDL *aniIsland = &control->aniIsland;
    AnimatorMDL__Init(aniIsland, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniIsland, mdlCutsceneTitle, 1, FALSE, FALSE);

    AnimatorMDL *aniLensFlare = &control->aniLensFlare;
    AnimatorMDL__Init(aniLensFlare, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniLensFlare, mdlCutsceneTitle, 2, FALSE, FALSE);

    AnimatorMDL *aniSparkles = &control->aniSparkles;
    AnimatorMDL__Init(aniSparkles, ANIMATOR_FLAG_NONE);
    AnimatorMDL__SetResource(aniSparkles, mdlCutsceneTitle, 3, FALSE, FALSE);

    for (s32 i = 0; i < 6; i++)
    {
        SetTitleScreenAnimation3D(&control->animators[i], B3D_ANIM_JOINT_ANIM, control->jntAniCutscene, i + 49, NULL, TRUE);
    }
    SetTitleScreenAnimation3D(&control->aniSparkles, B3D_ANIM_MAT_ANIM, control->matAniCutscene, 5, NULL, TRUE);
    SetTitleScreenAnimation3D(&control->aniSea, B3D_ANIM_TEX_ANIM, control->texAniCutscene, 12, NULL, TRUE);
    SetTitleScreenAnimation3D(&control->aniSea, B3D_ANIM_VIS_ANIM, control->visAniCutscene, 17, NULL, TRUE);

    control->aniCamera.work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;

    NNS_G3dRenderObjSetCallBack(&control->aniCamera.renderObj, TitleScreenRenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);

    AddTitleScreenRenderCallback(control->aniCamera.renderObj.resMdl, "node_camera", TITLESCREEN_MAT_CAMERA_NODE, NULL, NULL);
    AddTitleScreenRenderCallback(control->aniCamera.renderObj.resMdl, "node_target", TITLESCREEN_MAT_TARGET_NODE, NULL, NULL);
}

void ReleaseTitleScreenAnimators(TitleScreen *work)
{
    s32 i;

    TitleScreenWorldControl *control = &work->worldControl;

    for (i = 0; i < 6; i++)
    {
        AnimatorMDL__Release(&control->animators[i]);
    }

    for (i = 0; i < 2; i++)
    {
        NNS_G3dResDefaultRelease(control->mdlCutscene[i]);
    }
}

void InitTitleScreenBackgrounds(TitleScreen *work)
{
    void *bgFile;
    switch (GetGameLanguage())
    {
        case OS_LANGUAGE_JAPANESE:
            bgFile = FileUnknown__GetAOUFile(work->archiveTitleScreen, ARCHIVE_DMTI_LZ7_FILE_TITLELOGO_JPN_BBG);
            break;

        case OS_LANGUAGE_ENGLISH:
        case OS_LANGUAGE_FRENCH:
        case OS_LANGUAGE_GERMAN:
        case OS_LANGUAGE_ITALIAN:
        case OS_LANGUAGE_SPANISH:
            bgFile = FileUnknown__GetAOUFile(work->archiveTitleScreen, ARCHIVE_DMTI_LZ7_FILE_TITLELOGO_ENG_BBG);
            break;
    }

    InitBackground(&work->worldControl.background, bgFile, BACKGROUND_FLAG_LOAD_MAPPINGS_PALETTE, FALSE, BACKGROUND_2, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&work->worldControl.background);
}

void ReleaseTitleScreenBackgrounds(TitleScreen *work)
{
    // nothing to release
}

void ClearTitleScreenTasks(void)
{
    ClearTaskScope(1);
    ClearTaskScope(0);
}

void ChangeEventForTitleScreen(TitleScreenNextEvent id)
{
    switch (id)
    {
        case TITLESCREEN_NEXTEVENT_HUB:
            gameState.talk.field_DC = 0;
            SaveGame__Func_205B9F0(0);
            // fallthrough

        case TITLESCREEN_NEXTEVENT_DEMO:
        default:
            RequestSysEventChange(id);
            NextSysEvent();
            break;
    }
}

void SetTitleScreenBrightness(fx32 brightness32)
{
    Camera3DTask *camA = Camera3D__GetWork();
    Camera3DTask *camB = Camera3D__GetWork();

    s32 brightness = FX32_TO_WHOLE(MTM_MATH_CLIP(brightness32, FX32_FROM_WHOLE(RENDERCORE_BRIGHTNESS_BLACK), FX32_FROM_WHOLE(RENDERCORE_BRIGHTNESS_WHITE)));

    camA->gfxControl[0].brightness = brightness;
    camB->gfxControl[1].brightness = brightness;
}

BOOL CheckTitleScreenConfirmPress(TitleScreen *work)
{
    if ((padInput.btnPress & (PAD_BUTTON_START | PAD_BUTTON_A)) != 0)
        return TRUE;

    if (work->worldControl.touchSkipDelay != 0)
    {
        work->worldControl.touchSkipDelay--;
    }
    else
    {
        if (IsTouchInputEnabled() && TOUCH_HAS_PUSH(touchInput.flags) != 0)
        {
            return TRUE;
        }
    }

    return FALSE;
}

void SetTitleScreenAnimation3D(AnimatorMDL *animator, u32 type, NNSG3dResFileHeader *resource, s32 animID, const void *texResource, BOOL canLoop)
{
    AnimatorMDL__SetAnimation(animator, type, resource, animID, texResource);

    if (canLoop)
        animator->animFlags[type] |= ANIMATORMDL_FLAG_CAN_LOOP;
    else
        animator->animFlags[type] &= ~ANIMATORMDL_FLAG_CAN_LOOP;

    animator->speed[type] = FLOAT_TO_FX32(1.0);
}

NONMATCH_FUNC void TitleScreenRenderCallback(NNSG3dRS *rs)
{
    // https://decomp.me/scratch/c5bun -> 91.22%
    // (very similar to OpeningRenderCallback, if that's matched, this should be too!)
#ifdef NON_MATCHING
    u16 c;
    TitleScreenRenderCallbackConfig *callback;

    for (c = 0; c < TitleScreenRenderCallbackCount; c++)
    {
        callback = &TitleScreenRenderCallbackList[c];
        if (callback->resMdl == rs->pRenderObj->resMdl)
        {
            if (callback->nodeDesc == NNS_G3dRSGetCurrentNodeDescID(rs))
                break;
        }
    }

    if (c != TitleScreenRenderCallbackCount)
    {
        if (callback->func != NULL)
            callback->func(rs, callback->userData);

        NNS_G3dGeStoreMtx(callback->mtxStore);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	ldr r1, =TitleScreenRenderCallbackCount
	ldr r2, [r0, #4]
	ldrh r5, [r1, #0]
	ldr lr, [r2, #4]
	ldr r3, =TitleScreenRenderCallbackList
	cmp r5, #0
	mov ip, #0
	bls _02156978
	mvn r2, #0
_02156938:
	ldr r1, [r3, ip, lsl #4]
	add r4, r3, ip, lsl #4
	cmp r1, lr
	bne _02156964
	ldr r1, [r0, #8]
	tst r1, #0x10
	ldrneb r6, [r0, #0xae]
	ldrh r1, [r4, #4]
	moveq r6, r2
	cmp r1, r6
	beq _02156978
_02156964:
	add r1, ip, #1
	mov r1, r1, lsl #0x10
	cmp r5, r1, lsr #16
	mov ip, r1, lsr #0x10
	bhi _02156938
_02156978:
	cmp ip, r5
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r2, [r4, #8]
	cmp r2, #0
	beq _02156998
	ldr r1, [r4, #0xc]
	blx r2
_02156998:
	ldrh r3, [r4, #6]
	add r1, sp, #0
	mov r0, #0x13
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void AddTitleScreenRenderCallback(NNSG3dResMdl *resMdl, const char *name, s16 mtxStore, void (*func)(NNSG3dRS *context, void *userData), void *userData)
{
    // https://decomp.me/scratch/64MRR -> 86.75%
    // (very similar to AddOpeningRenderCallback, if that's matched, this should be too!)
#ifdef NON_MATCHING
    TitleScreenRenderCallbackConfig *callback = &TitleScreenRenderCallbackList[TitleScreenRenderCallbackCount++];

    s32 descID         = GetTitleScreenNodeDesc(resMdl, name);
    callback->resMdl   = resMdl;
    callback->nodeDesc = descID;
    callback->mtxStore = mtxStore;
    callback->func     = func;
    callback->userData = userData;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr ip, =TitleScreenRenderCallbackCount
	ldr r6, =TitleScreenRenderCallbackList
	ldrh r7, [ip]
	mov r5, r0
	mov r4, r2
	add r2, r7, #1
	strh r2, [ip]
	mov r9, r3
	add r8, r6, r7, lsl #4
	bl GetTitleScreenNodeDesc
	str r5, [r6, r7, lsl #4]
	strh r0, [r8, #4]
	strh r4, [r8, #6]
	ldr r0, [sp, #0x20]
	str r9, [r8, #8]
	str r0, [r8, #0xc]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

s32 GetTitleScreenNodeDesc(NNSG3dResMdl *resMdl, const char *name)
{
    NNSG3dResName resName;

    MI_CpuFill8(resName.name, 0, sizeof(resName));
    STD_CopyString(resName.name, name);
    return NNS_G3dGetResDictIdxByName(&resMdl->nodeInfo.dict, &resName);
}

void GetTitleScreenMatrix(s32 id, MtxFx43 *dest)
{
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGeRestoreMtx(id);
    NNS_G3dGetCurrentMtx(dest, NULL);
}

void TitleScreen_Destructor(Task *task)
{
    TitleScreen *work = TaskGetWork(task, TitleScreen);

    StopSysStream();
    ReleaseSysSound();
    StopSamplingTouchInput();

    ReleaseTitleScreenBackgrounds(work);
    ReleaseTitleScreenAnimators(work);
    ReleaseTitleScreenAssets(work);
}

void TitleScreen_Main_Init(void)
{
    TitleScreen *work = TaskGetWorkCurrent(TitleScreen);

    Camera3D__Create();

    SetTitleScreenBrightness(work->worldControl.brightness = FX32_FROM_WHOLE(RENDERCORE_BRIGHTNESS_WHITE));

    work->worldControl.touchSkipDelay = 5;
    PlaySysStream(SYSSOUND_GROUP_TITLE_2, TRUE);

    Camera3DTask *camera                                      = Camera3D__GetWork();
    camera->gfxControl[1].windowManager.registers.win0X1      = 0;
    camera->gfxControl[1].windowManager.registers.win0X2      = 0;
    camera->gfxControl[1].windowManager.registers.win0Y1      = 0;
    camera->gfxControl[1].windowManager.registers.win0Y2      = 0;
    camera->gfxControl[1].windowManager.registers.win0InPlane = GX_PLANEMASK_NONE;
    camera->gfxControl[1].windowManager.registers.winOutPlane = 59;
    camera->gfxControl[1].windowManager.visible               = TRUE;

    SetCurrentTaskMainEvent(TitleScreen_Main_FadeIn);
}

void TitleScreen_Main_FadeIn(void)
{
    TitleScreen *work = TaskGetWorkCurrent(TitleScreen);

    work->worldControl.brightness -= FLOAT_TO_FX32(0.25);
    if (work->worldControl.brightness <= FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT) || CheckTitleScreenConfirmPress(work))
    {
        work->worldControl.brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT);
        work->worldControl.flags |= TITLESCREEN_FLAG_USE_PRESS_START_TIMER;
        work->worldControl.timer = TITLESCREEN_IDLE_TIME;
        SetCurrentTaskMainEvent(TitleScreen_Main_Active);
    }

    SetTitleScreenBrightness(work->worldControl.brightness);
}

void TitleScreen_Main_Active(void)
{
    TitleScreen *work = TaskGetWorkCurrent(TitleScreen);

    if (work->worldControl.timer != 0)
    {
        work->worldControl.timer--;
    }
    else
    {
        if ((work->worldControl.flags & TITLESCREEN_FLAG_START_PRESSED) == 0)
        {
            work->worldControl.flags |= TITLESCREEN_FLAG_INIT_DEMO;
            work->worldControl.flags |= TITLESCREEN_FLAG_DISABLE_PRESS_START;
            SetCurrentTaskMainEvent(TitleScreen_Main_InitFadeOut);
        }
    }

    if ((work->worldControl.flags & TITLESCREEN_FLAG_BEGIN_FADE_OUT) != 0)
        SetCurrentTaskMainEvent(TitleScreen_Main_InitFadeOut);

    if ((work->worldControl.flags & TITLESCREEN_FLAG_CREATE_PRESS_START) != 0)
        CreateTitleScreenPressStart(work);
}

void TitleScreen_Main_InitFadeOut(void)
{
    TitleScreen *work = TaskGetWorkCurrent(TitleScreen);

    work->worldControl.brightness = RENDERCORE_BRIGHTNESS_DEFAULT;
    SetTitleScreenBrightness(RENDERCORE_BRIGHTNESS_DEFAULT);

    SetCurrentTaskMainEvent(TitleScreen_Main_FadeOut);
}

void TitleScreen_Main_FadeOut(void)
{
    TitleScreen *work = TaskGetWorkCurrent(TitleScreen);

    if ((work->worldControl.flags & TITLESCREEN_FLAG_INIT_DEMO) != 0)
        work->worldControl.brightness += FLOAT_TO_FX32(0.5);
    else
        work->worldControl.brightness -= FLOAT_TO_FX32(0.5);

    if (work->worldControl.brightness <= FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_BLACK) || work->worldControl.brightness >= FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE))
    {
        if ((work->worldControl.flags & TITLESCREEN_FLAG_INIT_DEMO) == 0)
            work->worldControl.brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_BLACK);
        else
            work->worldControl.brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE);

        SetCurrentTaskMainEvent(TitleScreen_Main_ChangeEvent);
    }

    SetTitleScreenBrightness(work->worldControl.brightness);
}

void TitleScreen_Main_ChangeEvent(void)
{
    TitleScreen *work = TaskGetWorkCurrent(TitleScreen);

    Camera3D__Destroy();

    if ((work->worldControl.flags & TITLESCREEN_FLAG_INIT_DEMO) != 0)
        ChangeEventForTitleScreen(TITLESCREEN_NEXTEVENT_DEMO);
    else
        ChangeEventForTitleScreen(TITLESCREEN_NEXTEVENT_HUB);

    ClearTitleScreenTasks();
}

void CreateTitleScreenBackgroundView(TitleScreen *parent)
{
    Task *task = TaskCreate(TitleScreenBackgroundView_Main_Init, TitleScreenBackgroundView_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000, TASK_SCOPE_1,
                            TitleScreenBackgroundView);

    TitleScreenBackgroundView *work = TaskGetWork(task, TitleScreenBackgroundView);
    TaskInitWork16(work);

    work->parent = parent;
}

void TitleScreenBackgroundView_Destructor(Task *task)
{
    // nothing
}

void TitleScreenBackgroundView_Main_Init(void)
{
    TitleScreenBackgroundView *work = TaskGetWorkCurrent(TitleScreenBackgroundView);

    SetCurrentTaskMainEvent(TitleScreenBackgroundView_Main_Active);
}

void TitleScreenBackgroundView_Main_Active(void)
{
    TitleScreenBackgroundView *work = TaskGetWorkCurrent(TitleScreenBackgroundView);
    TitleScreen *parent             = work->parent;

    AnimatorMDL__ProcessAnimation(&parent->worldControl.aniCamera);
    AnimatorMDL__Draw(&parent->worldControl.aniCamera);
    GetTitleScreenMatrix(TITLESCREEN_MAT_CAMERA_NODE, &parent->worldControl.mtxCamera);
    GetTitleScreenMatrix(TITLESCREEN_MAT_TARGET_NODE, &parent->worldControl.mtxTarget);

    Camera3D *camera = &parent->worldControl.cameraConfig;
    if (Camera3D__UseEngineA())
    {
        camera->config.matProjPosition.y = -parent->worldControl.matProjPositionY;

        VEC_SetFromArray(&camera->lookAtTo, &parent->worldControl.mtxCamera.m[3][0]);
        VEC_SetFromArray(&camera->lookAtFrom, &parent->worldControl.mtxTarget.m[3][0]);
    }
    else
    {
        camera->config.matProjPosition.y = parent->worldControl.matProjPositionY;

        VEC_SetFromArray(&camera->lookAtTo, &parent->worldControl.mtxCamera.m[3][0]);
        VEC_SetFromArray(&camera->lookAtFrom, &parent->worldControl.mtxTarget.m[3][0]);
    }

    Camera3D__LoadState(camera);

    s32 i                 = 1;
    AnimatorMDL *animator = &parent->worldControl.animators[i];
    for (; i < 6; i++)
    {
        if ((animator->work.flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0)
        {
            AnimatorMDL__ProcessAnimation(animator);
            AnimatorMDL__Draw(animator);
        }

        animator++;
    }
}

void CreateTitleScreenCopyrightIcon(TitleScreen *parent)
{
    Task *task = TaskCreate(TitleScreenCopyrightIcon_Main_Init, TitleScreenCopyrightIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000, TASK_SCOPE_1,
                            TitleScreenCopyrightIcon);

    TitleScreenCopyrightIcon *work = TaskGetWork(task, TitleScreenCopyrightIcon);
    TaskInitWork16(work);

    work->parent = parent;

    void *spriteFile = FileUnknown__GetAOUFile(parent->archiveTitleScreen, ARCHIVE_DMTI_LZ7_FILE_C_SEGA_BAC);
    AnimatorSprite__Init(&work->aniCopyright, spriteFile, 0, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, 0, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2(spriteFile)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    work->aniCopyright.palette = PALETTE_ROW_0;
    work->aniCopyright.pos.x   = 0;
    work->aniCopyright.pos.y   = 176;

    spriteFile = FileUnknown__GetAOUFile(parent->archiveTitleScreen, ARCHIVE_DMTI_LZ7_FILE_TM_BAC);
    AnimatorSprite__Init(&work->aniTrademark, spriteFile, 0, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, 0, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2(spriteFile)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    work->aniTrademark.palette = PALETTE_ROW_1;

    if (GetGameLanguage() == OS_LANGUAGE_JAPANESE)
    {
        work->aniTrademark.pos.x = 232;
        work->aniTrademark.pos.y = 103;
    }
    else
    {
        work->aniTrademark.pos.x = 230;
        work->aniTrademark.pos.y = 115;
    }
}

void TitleScreenCopyrightIcon_Destructor(Task *task)
{
    TitleScreenCopyrightIcon *work = TaskGetWork(task, TitleScreenCopyrightIcon);

    AnimatorSprite__Release(&work->aniCopyright);
    AnimatorSprite__Release(&work->aniTrademark);
}

void TitleScreenCopyrightIcon_Main_Init(void)
{
    TitleScreenCopyrightIcon *work = TaskGetWorkCurrent(TitleScreenCopyrightIcon);

    work->timer = 60;
    work->parent->worldControl.flags |= TITLESCREEN_FLAG_SHOW_COPYRIGHT;
    work->parent->worldControl.flags |= TITLESCREEN_FLAG_SHOW_TRADEMARK;
    SetCurrentTaskMainEvent(TitleScreenCopyrightIcon_Main_Active);
}

void TitleScreenCopyrightIcon_Main_Active(void)
{
    TitleScreenCopyrightIcon *work = TaskGetWorkCurrent(TitleScreenCopyrightIcon);

    if ((work->parent->worldControl.flags & TITLESCREEN_FLAG_SHOW_COPYRIGHT) != 0)
    {
        AnimatorSprite__ProcessAnimationFast(&work->aniCopyright);
        if (Camera3D__UseEngineA())
            AnimatorSprite__DrawFrame(&work->aniCopyright);
    }

    if ((work->parent->worldControl.flags & TITLESCREEN_FLAG_SHOW_TRADEMARK) != 0)
    {
        AnimatorSprite__ProcessAnimationFast(&work->aniTrademark);

        if (Camera3D__UseEngineA())
            AnimatorSprite__DrawFrame(&work->aniTrademark);
    }

    if ((work->parent->worldControl.flags & TITLESCREEN_FLAG_USE_PRESS_START_TIMER) != 0)
    {
        if (work->timer != 0)
        {
            work->timer--;
        }
        else
        {
            work->parent->worldControl.flags |= TITLESCREEN_FLAG_CREATE_PRESS_START;
            SetCurrentTaskMainEvent(TitleScreenCopyrightIcon_Main_Idle);
        }
    }
}

void TitleScreenCopyrightIcon_Main_Idle(void)
{
    TitleScreenCopyrightIcon *work = TaskGetWorkCurrent(TitleScreenCopyrightIcon);

    AnimatorSprite__ProcessAnimationFast(&work->aniCopyright);
    if (Camera3D__UseEngineA())
        AnimatorSprite__DrawFrame(&work->aniCopyright);

    AnimatorSprite__ProcessAnimationFast(&work->aniTrademark);
    if (Camera3D__UseEngineA())
        AnimatorSprite__DrawFrame(&work->aniTrademark);
}

void CreateTitleScreenPressStart(TitleScreen *parent)
{
    Task *task = TaskCreate(TitleScreenPressStart_Main_Init, TitleScreenPressStart_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000, TASK_SCOPE_1,
                            TitleScreenPressStart);

    TitleScreenPressStart *work = TaskGetWork(task, TitleScreenPressStart);
    TaskInitWork16(work);

    work->parent = parent;

    void *spriteFile = FileUnknown__GetAOUFile(parent->archiveTitleScreen, GetGameLanguage() + ARCHIVE_DMTI_LZ7_FILE_BUTTON_JPN_BAC);
    AnimatorSprite__Init(&work->aniButton, spriteFile, TITLESCREENPRESSSTART_ANI_WAITING, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_LOOPING, 0,
                         PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2(spriteFile)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0,
                         SPRITE_ORDER_0);
    work->aniButton.palette = PALETTE_ROW_2;
    work->aniButton.pos.x   = 128;
    work->aniButton.pos.y   = 88;

    parent->worldControl.flags &= ~TITLESCREEN_FLAG_CREATE_PRESS_START;
}

void TitleScreenPressStart_Destructor(Task *task)
{
    TitleScreenPressStart *work = TaskGetWork(task, TitleScreenPressStart);

    AnimatorSprite__Release(&work->aniButton);
}

void TitleScreenPressStart_Main_Init(void)
{
    SetCurrentTaskMainEvent(TitleScreenPressStart_Main_AwaitPress);
}

void TitleScreenPressStart_Main_AwaitPress(void)
{
    TitleScreenPressStart *work = TaskGetWorkCurrent(TitleScreenPressStart);

    AnimatorSprite__ProcessAnimationFast(&work->aniButton);

    if (!Camera3D__UseEngineA())
        AnimatorSprite__DrawFrame(&work->aniButton);

    if (CheckTitleScreenConfirmPress(work->parent))
    {
        if ((work->parent->worldControl.flags & TITLESCREEN_FLAG_DISABLE_PRESS_START) == 0)
        {
            AnimatorSprite__SetAnimation(&work->aniButton, TITLESCREENPRESSSTART_ANI_PRESSED);
            work->timer = 30;
            work->parent->worldControl.flags |= TITLESCREEN_FLAG_START_PRESSED;
            PlaySysSfx(SND_SYS_SEQARC_ARC_TITLE_SEQ_SE_T_DECIDE);
            FadeSysStream(60);
            SetCurrentTaskMainEvent(TitleScreenPressStart_Main_Pressed);
        }
    }
}

void TitleScreenPressStart_Main_Pressed(void)
{
    TitleScreenPressStart *work = TaskGetWorkCurrent(TitleScreenPressStart);

    AnimatorSprite__ProcessAnimationFast(&work->aniButton);

    if (!Camera3D__UseEngineA())
        AnimatorSprite__DrawFrame(&work->aniButton);

    if (work->timer != 0)
    {
        work->timer--;
    }
    else
    {
        work->parent->worldControl.flags |= TITLESCREEN_FLAG_BEGIN_FADE_OUT;
        SetCurrentTaskMainEvent(TitleScreenPressStart_Main_Idle);
    }
}

void TitleScreenPressStart_Main_Idle(void)
{
    TitleScreenPressStart *work = TaskGetWorkCurrent(TitleScreenPressStart);

    AnimatorSprite__ProcessAnimationFast(&work->aniButton);

    if (!Camera3D__UseEngineA())
        AnimatorSprite__DrawFrame(&work->aniButton);
}
