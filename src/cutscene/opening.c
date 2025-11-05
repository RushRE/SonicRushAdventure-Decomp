#include <cutscene/opening.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/graphics/drawState.h>
#include <game/file/fileUnknown.h>
#include <game/file/fsRequest.h>
#include <game/audio/sysSound.h>
#include <game/system/sysEvent.h>
#include <game/math/mtMath.h>
#include <game/stage/mapSys.h>

// resources
#include <resources/narc/dmop_lz7.h>
#include <resources/narc/dmop_pldm_lz7.h>

// --------------------
// CONSTANTS
// --------------------

#define OPENING_MAT_CAMERA1_NODE (NNS_G3D_MTXSTACK_SYS - (2 * 0))
#define OPENING_MAT_TARGET1_NODE (NNS_G3D_MTXSTACK_USER - (2 * 0))
#define OPENING_MAT_CAMERA2_NODE (NNS_G3D_MTXSTACK_SYS - (2 * 1))
#define OPENING_MAT_TARGET2_NODE (NNS_G3D_MTXSTACK_USER - (2 * 1))

// --------------------
// MACROS
// --------------------

#define SetOpeningState(state, func)                                                                                                                                               \
    (state) = func;                                                                                                                                                                \
    if ((state) != NULL)                                                                                                                                                           \
        (state)(work);

// --------------------
// ENUMS
// --------------------

enum OpeningSceneType
{
    OPENING_SCENETYPE_ANIMATED,
    OPENING_SCENETYPE_CUTIN,

    OPENING_SCENETYPE_COUNT,
};

enum OpeningSceneID
{
    OPENING_SCENE_ANI_OPENING_OVERHEAD,
    OPENING_SCENE_ANI_JETSKI_RIDE,
    OPENING_SCENE_ANI_SONIC_BLAZE_GLANCE,
    OPENING_SCENE_ANI_TAILS_MARINE_WAVE,
    OPENING_SCENE_CUTIN_CHARACTER,
    OPENING_SCENE_ANI_TJETSKI_SKID,

    OPENING_SCENE_COUNT,
};

enum OpeningAnimatedSceneID
{
    OPENING_ANIMATED_SCENE_OPENING_OVERHEAD,
    OPENING_ANIMATED_SCENE_JETSKI_RIDE,
    OPENING_ANIMATED_SCENE_SONIC_BLAZE_GLANCE,
    OPENING_ANIMATED_SCENE_TAILS_MARINE_WAVE,
    OPENING_ANIMATED_SCENE_JETSKI_SKID,

    OPENING_ANIMATED_SCENE_COUNT,
};

enum OpeningCutInSceneID
{
    OPENING_CUTIN_SCENE_CHARACTER,

    OPENING_CUTIN_SCENE_COUNT,
};

enum OpeningNameAnimID
{
    OPENING_NAMEANI_SONIC_BIG_S,
    OPENING_NAMEANI_SONIC_BIG_O,
    OPENING_NAMEANI_SONIC_BIG_N,
    OPENING_NAMEANI_SONIC_BIG_I,
    OPENING_NAMEANI_SONIC_BIG_C,
    OPENING_NAMEANI_SONIC_SMALL_T,
    OPENING_NAMEANI_SONIC_SMALL_H,
    OPENING_NAMEANI_SONIC_SMALL_E,
    OPENING_NAMEANI_SONIC_SMALL_D,
    OPENING_NAMEANI_SONIC_SMALL_G,
    OPENING_NAMEANI_SONIC_SMALL_O,
    OPENING_NAMEANI_BLAZE_BIG_B,
    OPENING_NAMEANI_BLAZE_BIG_L,
    OPENING_NAMEANI_BLAZE_BIG_A,
    OPENING_NAMEANI_BLAZE_BIG_Z,
    OPENING_NAMEANI_BLAZE_BIG_E,
    OPENING_NAMEANI_BLAZE_SMALL_T,
    OPENING_NAMEANI_BLAZE_SMALL_H,
    OPENING_NAMEANI_BLAZE_SMALL_E,
    OPENING_NAMEANI_BLAZE_SMALL_C,
    OPENING_NAMEANI_BLAZE_SMALL_A,
};

// --------------------
// STRUCTS
// --------------------

typedef struct OpeningRenderCallbackConfig_
{
    void *resMdl;
    u16 nodeDesc;
    u16 mtxStore;
    void (*func)(NNSG3dRS *context, void *userData);
    void *userData;
} OpeningRenderCallbackConfig;

// --------------------
// FUNCTION DECLS
// --------------------

// Opening
static void SetupDisplayForOpening(void);
static void LoadOpeningAssets(Opening *work);
static void ReleaseOpeningArchives(Opening *work);
static void InitOpeningAnimators(Opening *work);
static void ReleaseOpeningAnimators(Opening *work);
static void LoadOpeningBackgrounds(Opening *work);
static void ReleaseOpeningPaletteAnimations(Opening *work);
static void ClearOpeningTasks(void);
static void ChangeEventForOpening(Opening *work);
static BOOL CheckOpeningSkip(Opening *work);
static void SetOpeningAnimation(AnimatorMDL *animator, B3DAnimationTypes type, NNSG3dResFileHeader *resource, s32 animID, const NNSG3dResTex *texResource, BOOL canLoop);
static void InitOpeningCameraForScene(Opening *work, s32 id);
static void OpeningRenderCallback(NNSG3dRS *rs);
static void AddOpeningRenderCallback(NNSG3dResMdl *resMdl, const char *name, s16 mtxStore, void (*callback)(NNSG3dRS *context, void *userData), void *userData);
static s32 GetOpeningNodeDesc(NNSG3dResMdl *resMdl, const char *name);
static void GetOpeningMatrix(s32 num, FXMatrix43 *mtx);
static void StartOpeningFade(OpeningFadeController *controller, OpeningFadeMode mode, fx32 fadeSpeed);
static void EndOpeningFade(OpeningFadeController *controller);
static BOOL ProcessOpeningFade(OpeningFadeController *controller);
static BOOL CheckOpeningAnimatorFinished(AnimatorMDL *animator);
static BOOL IsOpeningSceneCompleteFinished(Opening *work);
static void InitOpeningWindowConfig(void);
static void ConfigureOpeningWindowForSonic(fx32 y);
static void ConfigureOpeningWindowForBlaze(fx32 y);
static void ClearOpeningWindowConfig(void);
static void SetOpeningBackgroundPos(s32 id, fx32 x, fx32 y);
static void DrawOpeningSprite(AnimatorSprite *animator);

static void Opening_Destructor(Task *task);
static void Opening_Main_Init(void);
static void Opening_Main_Playback(void);
static void Opening_Main_Finished(void);

static s32 GetOpeningSceneType(s32 sceneID);
static BOOL CompleteOpeningScene(Opening *work);
static u32 GetOpeningSceneID(Opening *work);
static BOOL CompleteOpeningAnimatedScene(Opening *work);
static u32 GetOpeningAnimatedSceneID(Opening *work);
static BOOL CompleteOpeningCutInScene(Opening *work);

// Sequence controller
static void Opening_StateSequence_Init(Opening *work);
static void Opening_StateSequence_InitNextScene(Opening *work);
static void Opening_StateSequence_InitAnimatedScene(Opening *work);
static void Opening_StateSequence_WaitSceneCompleted(Opening *work);
static void Opening_StateSequence_InitCutInScene(Opening *work);
static void Opening_StateSequence_WaitCutInCompleted(Opening *work);
static void Opening_StateSequence_StartFadeOut(Opening *work);
static void Opening_StateSequence_ProcessFadeOut(Opening *work);

// Scene controller
static void Opening_StateScene_InitAnimatedScene(Opening *work);
static void Opening_StateScene_ProcessAnimatedScene(Opening *work);
static void Opening_StateScene_InitCutInScene(Opening *work);
static void Opening_StateScene_ProcessCutInScene(Opening *work);

// Init scene funcs
static void Opening_InitScene_OpeningOverhead(Opening *work);
static void Opening_InitScene_JetSkiRide(Opening *work);
static void Opening_InitScene_SonicBlazeGlance(Opening *work);
static void Opening_InitScene_TailsMarineWave(Opening *work);
static void Opening_InitScene_JetSkiSkid(Opening *work);

// OpeningBorderSprite
static void CreateOpeningBorderSprite(Opening *parent);
static void OpeningBorderSprite_Destructor(Task *task);
static void OpeningBorderSprite_Main_Init(void);
static void OpeningBorderSprite_Main_EnterDelay(void);
static void OpeningBorderSprite_Main_EnterBorder(void);
static void OpeningBorderSprite_Main_DisplayCharacters(void);
static void OpeningBorderSprite_Main_ExitBorder(void);
static void OpeningBorderSprite_Main_ExitDelay(void);
static void OpeningBorderSprite_Main_Finished(void);

// OpeningSonicNameSprite
static void CreateOpeningSonicNameSprite(Opening *parent);
static void OpeningSonicNameSprite_Destructor(Task *task);
static void OpeningSonicNameSprite_Main_Init(void);
static void OpeningSonicNameSprite_Main_EnterSprite(void);
static void OpeningSonicNameSprite_Main_ShowSprite(void);
static void OpeningSonicNameSprite_Main_ShowName(void);
static void OpeningSonicNameSprite_Main_BeginExitSprite(void);
static void OpeningSonicNameSprite_Main_ExitSprite(void);

// OpeningBlazeNameSprite
void CreateOpeningBlazeNameSprite(Opening *parent);
void OpeningBlazeNameSprite_Destructor(Task *task);
void OpeningBlazeNameSprite_Main_Init(void);
void OpeningBlazeNameSprite_Main_EnterSprite(void);
void OpeningBlazeNameSprite_Main_ShowSprite(void);
void OpeningBlazeNameSprite_Main_ShowName(void);
void OpeningBlazeNameSprite_Main_BeginExitSprite(void);
void OpeningBlazeNameSprite_Main_ExitSprite(void);

// --------------------
// VARIABLES
// --------------------

static OpeningRenderCallbackConfig Opening__RenderCallbackList[16];
NOT_DECOMPILED u16 Opening__RenderCallbackCount;

static const u16 blazeNameLetterAniList[11] = {
    OPENING_NAMEANI_BLAZE_BIG_B,   OPENING_NAMEANI_BLAZE_BIG_L,   OPENING_NAMEANI_BLAZE_BIG_A,   OPENING_NAMEANI_BLAZE_BIG_Z, OPENING_NAMEANI_BLAZE_BIG_E, // BLAZE
    OPENING_NAMEANI_BLAZE_SMALL_T, OPENING_NAMEANI_BLAZE_SMALL_H, OPENING_NAMEANI_BLAZE_SMALL_E,                                                           // THE
    OPENING_NAMEANI_BLAZE_SMALL_C, OPENING_NAMEANI_BLAZE_SMALL_A, OPENING_NAMEANI_BLAZE_SMALL_T                                                            // CAT
};

static const u32 animOffsetForScene[OPENING_SCENE_COUNT] = {
    [OPENING_SCENE_ANI_OPENING_OVERHEAD] = 0,   [OPENING_SCENE_ANI_JETSKI_RIDE] = 8,  [OPENING_SCENE_ANI_SONIC_BLAZE_GLANCE] = 16,
    [OPENING_SCENE_ANI_TAILS_MARINE_WAVE] = 25, [OPENING_SCENE_CUTIN_CHARACTER] = 40, [OPENING_SCENE_ANI_TJETSKI_SKID] = 49
};

static const s32 sceneTypeList[OPENING_SCENE_COUNT] = {
    [OPENING_SCENE_ANI_OPENING_OVERHEAD] = OPENING_SCENETYPE_ANIMATED,   [OPENING_SCENE_ANI_JETSKI_RIDE] = OPENING_SCENETYPE_ANIMATED,
    [OPENING_SCENE_ANI_SONIC_BLAZE_GLANCE] = OPENING_SCENETYPE_ANIMATED, [OPENING_SCENE_ANI_TAILS_MARINE_WAVE] = OPENING_SCENETYPE_ANIMATED,
    [OPENING_SCENE_CUTIN_CHARACTER] = OPENING_SCENETYPE_CUTIN,           [OPENING_SCENE_ANI_TJETSKI_SKID] = OPENING_SCENETYPE_ANIMATED
};

static const u16 sonicNameLetterAniList[16] = {
    OPENING_NAMEANI_SONIC_BIG_S,   OPENING_NAMEANI_SONIC_BIG_O,   OPENING_NAMEANI_SONIC_BIG_N,   OPENING_NAMEANI_SONIC_BIG_I,   OPENING_NAMEANI_SONIC_BIG_C, // SONIC
    OPENING_NAMEANI_SONIC_SMALL_T, OPENING_NAMEANI_SONIC_SMALL_H, OPENING_NAMEANI_SONIC_SMALL_E,                                                             // THE
    OPENING_NAMEANI_SONIC_SMALL_H, OPENING_NAMEANI_SONIC_SMALL_E, OPENING_NAMEANI_SONIC_SMALL_D, OPENING_NAMEANI_SONIC_SMALL_G, OPENING_NAMEANI_SONIC_SMALL_E,
    OPENING_NAMEANI_SONIC_SMALL_H, OPENING_NAMEANI_SONIC_SMALL_O, OPENING_NAMEANI_SONIC_SMALL_G // HEDGEHOG
};

static const Vec2Fx16 blazeNameLetterPositions[11] = {
    { 212, 200 }, // B
    { 212, 236 }, // L
    { 212, 272 }, // A
    { 212, 311 }, // Z
    { 212, 346 }, // E

    { 172, 283 }, // T
    { 172, 297 }, // H
    { 172, 312 }, // E

    { 172, 336 }, // C
    { 172, 352 }, // A
    { 172, 368 }, // T
};

static const Vec2Fx16 sonicNameLetterPositions[16] = {
    { 44, 180 }, // S
    { 44, 142 }, // O
    { 44, 103 }, // N
    { 44, 62 },  // I
    { 44, 44 },  // C

    { 84, 167 }, // T
    { 84, 154 }, // H
    { 84, 140 }, // E

    { 84, 120 }, // H
    { 84, 106 }, // E
    { 84, 95 },  // D
    { 84, 80 },  // H
    { 84, 65 },  // E
    { 84, 53 },  // H
    { 84, 40 },  // O
    { 84, 24 },  // G
};

static const u32 sceneAnimatorList[OPENING_ANIMATED_SCENE_COUNT][15] = {
    [OPENING_ANIMATED_SCENE_OPENING_OVERHEAD]   = { 0, 2, 3, 4, 5, 6, 7, 9, 0, 0, 0, 0, 0, 0, 0 },
    [OPENING_ANIMATED_SCENE_JETSKI_RIDE]        = { 0, 3, 4, 5, 6, 7, 9, 10, 0, 0, 0, 0, 0, 0, 0 },
    [OPENING_ANIMATED_SCENE_SONIC_BLAZE_GLANCE] = { 0, 1, 3, 4, 5, 6, 7, 9, 10, 0, 0, 0, 0, 0, 0 },
    [OPENING_ANIMATED_SCENE_TAILS_MARINE_WAVE]  = { 0, 1, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 16 },
    [OPENING_ANIMATED_SCENE_JETSKI_SKID]        = { 0, 3, 4, 5, 6, 7, 9, 10, 8, 0, 0, 0, 0, 0, 0 },
};

// --------------------
// FUNCTIONS
// --------------------

// Opening
void CreateOpening(void)
{
    SetupDisplayForOpening();

    Task *task = TaskCreate(Opening_Main_Init, Opening_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(0), Opening);

    Opening *work = TaskGetWork(task, Opening);
    TaskInitWork16(work);

    LoadOpeningAssets(work);
    InitOpeningAnimators(work);
    LoadOpeningBackgrounds(work);
    StartSamplingTouchInput(4);

    Camera3D__Create();

    Camera3DTask *camA             = Camera3D__GetWork();
    Camera3DTask *camB             = Camera3D__GetWork();
    camA->gfxControl[0].brightness = RENDERCORE_BRIGHTNESS_WHITE;
    camB->gfxControl[1].brightness = RENDERCORE_BRIGHTNESS_WHITE;

    FS_SetDefaultDMA(1);
    LoadSysSound(SYSSOUND_GROUP_TITLE_1);
}

void SetupDisplayForOpening(void)
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

    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x512, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0xc800, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_01);
    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x512, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0xd800, GX_BG_CHARBASE_0x04000);
    G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x512, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0xe800, GX_BG_CHARBASE_0x08000);

    renderCoreGFXControlA.bgPosition[BACKGROUND_0].x = renderCoreGFXControlA.bgPosition[BACKGROUND_0].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].x = renderCoreGFXControlA.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].x = renderCoreGFXControlA.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 0;

    G2_SetBG0Priority(3);
    G2_SetBG1Priority(2);
    void *vramPtr = VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_A];
    G2_SetBG2Priority(1);
    G2_SetBG3Priority(0);

    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1);
    MI_CpuClear16(vramPtr, 0x10000);

    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_WHITE);

    GX_SetVisiblePlane(GX_PLANEMASK_BG0);
}

void LoadOpeningAssets(Opening *work)
{
    FSRequestArchive("/narc/dmop_lz7.narc", &work->archiveSprites, FALSE);
    FSRequestArchive("/narc/dmop_pldm_lz7.narc", &work->archiveCutscene, FALSE);

    work->worldControl.mdlCutscene[0]       = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_01_NSBMD);
    work->worldControl.mdlCutscene[1]       = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_02_NSBMD);
    work->worldControl.jntAniCutscene       = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_01_NSBCA);
    work->worldControl.matAniCutscene       = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_01_NSBMA);
    work->worldControl.texAniCutscene       = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_01_NSBTA);
    work->worldControl.visAniCutscene       = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_01_NSBVA);
    work->worldControl.drawStateCutscene[0] = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_01_BSD);
    work->worldControl.drawStateCutscene[1] = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_02_BSD);
    work->worldControl.drawStateCutscene[2] = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_03_BSD);
    work->worldControl.drawStateCutscene[3] = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_04_BSD);
    work->worldControl.drawStateCutscene[4] = FileUnknown__GetAOUFile(work->archiveCutscene, ARCHIVE_DMOP_PLDM_LZ7_FILE_00_1_06_BSD);
}

void ReleaseOpeningArchives(Opening *work)
{
    HeapFree(HEAP_USER, work->archiveSprites);
    HeapFree(HEAP_USER, work->archiveCutscene);
}

void InitOpeningAnimators(Opening *work)
{
    s32 i;

    void *resource_01 = work->worldControl.mdlCutscene[0];
    NNS_G3dResDefaultSetup(resource_01);
    for (i = OPENING_ANIMATOR_CAMERA1; i <= OPENING_ANIMATOR_JETSKI_SPLASH2; i++)
    {
        AnimatorMDL__Init(&work->worldControl.animators[i], ANIMATOR_FLAG_DISABLE_DRAW);
        AnimatorMDL__SetResource(&work->worldControl.animators[i], resource_01, i, FALSE, FALSE);
    }

    void *resource_02 = work->worldControl.mdlCutscene[1];
    NNS_G3dResDefaultSetup(resource_02);

    for (i = OPENING_ANIMATOR_SEA; i < OPENING_ANIMATOR_COUNT; i++)
    {
        AnimatorMDL__Init(&work->worldControl.animators[i], ANIMATOR_FLAG_DISABLE_DRAW);
        AnimatorMDL__SetResource(&work->worldControl.animators[i], resource_02, i - OPENING_ANIMATOR_SEA, FALSE, FALSE);
    }

    for (i = OPENING_ANIMATOR_CAMERA1; i <= OPENING_ANIMATOR_CAMERA2; i++)
    {
        AnimatorMDL *animator = &work->worldControl.animators[i];

        AnimatorMDL__Init(animator, ANIMATOR_FLAG_DISABLE_DRAW);
        AnimatorMDL__SetResource(animator, resource_01, i, FALSE, FALSE);
        animator->work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
        NNS_G3dRenderObjSetCallBack(&animator->renderObj, OpeningRenderCallback, NULL, NNS_G3D_SBC_NODEDESC, NNS_G3D_SBC_CALLBACK_TIMING_C);

        switch (i)
        {
            case OPENING_ANIMATOR_CAMERA1:
                AddOpeningRenderCallback(animator->renderObj.resMdl, "node_camera", OPENING_MAT_CAMERA1_NODE, NULL, NULL);
                AddOpeningRenderCallback(animator->renderObj.resMdl, "node_target", OPENING_MAT_TARGET1_NODE, NULL, NULL);
                break;

            case OPENING_ANIMATOR_CAMERA2:
                AddOpeningRenderCallback(animator->renderObj.resMdl, "node_camera2", OPENING_MAT_CAMERA2_NODE, NULL, NULL);
                AddOpeningRenderCallback(animator->renderObj.resMdl, "node_target2", OPENING_MAT_TARGET2_NODE, NULL, NULL);
                break;
        }
    }
}

void ReleaseOpeningAnimators(Opening *work)
{
    s32 i;

    OpeningWorldControl *control = &work->worldControl;

    for (i = 0; i < OPENING_ANIMATOR_COUNT; i++)
    {
        AnimatorMDL__Release(&control->animators[i]);
    }

    for (i = 0; i < 2; i++)
    {
        NNS_G3dResDefaultRelease(control->mdlCutscene[i]);
    }
}

void LoadOpeningBackgrounds(Opening *work)
{
    InitBackground(&work->worldControl.bgBase, FileUnknown__GetAOUFile(work->archiveSprites, ARCHIVE_DMOP_LZ7_FILE_BASE_BBG), BACKGROUND_FLAG_LOAD_MAPPINGS_PALETTE, FALSE,
                   BACKGROUND_1, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_DOUBLE_HEIGHT);
    DrawBackground(&work->worldControl.bgBase);

    InitPaletteAnimator(&work->worldControl.aniPalette, FileUnknown__GetAOUFile(work->archiveSprites, ARCHIVE_DMOP_LZ7_FILE_BASE_BPA), 0, ANIMATORBPA_FLAG_CAN_LOOP, 0,
                        VRAM_BG_PLTT);

    InitBackground(&work->worldControl.bgSonic, FileUnknown__GetAOUFile(work->archiveSprites, ARCHIVE_DMOP_LZ7_FILE_SON_BBG), BACKGROUND_FLAG_DISABLE_PALETTE, FALSE, BACKGROUND_2,
                   BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_DOUBLE_HEIGHT);
    DrawBackground(&work->worldControl.bgSonic);
    work->worldControl.bgSonic.flags |= BACKGROUND_FLAG_DISABLE_PIXELS;

    InitBackground(&work->worldControl.bgBlaze, FileUnknown__GetAOUFile(work->archiveSprites, ARCHIVE_DMOP_LZ7_FILE_BLZ_BBG), BACKGROUND_FLAG_DISABLE_PALETTE, FALSE, BACKGROUND_3,
                   BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_DOUBLE_HEIGHT);
    DrawBackground(&work->worldControl.bgBlaze);
    work->worldControl.bgBlaze.flags |= BACKGROUND_FLAG_DISABLE_PIXELS;
}

void ReleaseOpeningPaletteAnimations(Opening *work)
{
    ReleasePaletteAnimator(&work->worldControl.aniPalette);
}

void ClearOpeningTasks(void)
{
    DestroyTaskGroup(TASK_GROUP(1));
    DestroyTaskGroup(TASK_GROUP(0));
}

void ChangeEventForOpening(Opening *work)
{
    RequestSysEventChange(0); // SYSEVENT_TITLE
    NextSysEvent();
}

BOOL CheckOpeningSkip(Opening *work)
{
    if ((padInput.btnPress & (PAD_BUTTON_START | PAD_BUTTON_A)) != 0)
        return TRUE;

    if (work->touchSkipDelay != 0)
    {
        work->touchSkipDelay--;
    }
    else if (IsTouchInputEnabled() && TouchInput__IsTouchPush(&touchInput))
    {
        return TRUE;
    }

    return FALSE;
}

void SetOpeningAnimation(AnimatorMDL *animator, B3DAnimationTypes type, NNSG3dResFileHeader *resource, s32 animID, const NNSG3dResTex *texResource, BOOL canLoop)
{
    AnimatorMDL__SetAnimation(animator, type, resource, animID, texResource);

    if (canLoop)
        animator->animFlags[type] |= ANIMATORMDL_FLAG_CAN_LOOP;
    else
        animator->animFlags[type] &= ~ANIMATORMDL_FLAG_CAN_LOOP;

    animator->speed[type] = FLOAT_TO_FX32(1.0);
}

void InitOpeningCameraForScene(Opening *work, s32 id)
{
    s32 i;

    OpeningWorldControl *control = &work->worldControl;

    void *drawState = control->drawStateCutscene[id];
    LoadDrawState(drawState, DRAWSTATE_ALL & ~(DRAWSTATE_LOOKAT));
    GetDrawStateCameraView(drawState, &control->camera);
    GetDrawStateCameraProjection(drawState, &control->camera.config);

    switch (id)
    {
        case 0:
        case 1:
        case 4:
            control->matProjPosY = control->camera.config.projScaleW + MultiplyFX(FLOAT_TO_FX32(0.416504), control->camera.config.projScaleW);
            break;

        case 2:
        case 3:
            control->matProjPosY = 0;
            break;

        default:
            break;
    }

    for (i = 0; i < OPENING_ANIMATOR_COUNT; i++)
    {
        control->animators[i].work.flags |= ANIMATOR_FLAG_DISABLE_DRAW;
    }

    s32 *animIDList    = sceneAnimatorList[id];
    s32 id2            = id;
    u32 animOffset     = animOffsetForScene[id2++];
    u32 nextAnimOffset = animOffsetForScene[id2];

    for (i = 0; i < 15; i++)
    {
        s32 animatorID = animIDList[i];
        control->animators[animatorID].work.flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
        if (i + animOffset < nextAnimOffset)
            SetOpeningAnimation(&control->animators[animatorID], B3D_ANIM_JOINT_ANIM, control->jntAniCutscene, i + animOffset, NULL, FALSE);
    }
}

NONMATCH_FUNC void OpeningRenderCallback(NNSG3dRS *rs)
{
    // https://decomp.me/scratch/TwBoK -> 95.89%
#ifdef NON_MATCHING
    u16 c;
    OpeningRenderCallbackConfig *callback;

    NNSG3dRenderObj *renderObj;
    renderObj = rs->pRenderObj;

    void *resMdl = renderObj->resMdl;
    for (c = 0; c < Opening__RenderCallbackCount; c++)
    {
        callback = &Opening__RenderCallbackList[c];
        if (callback->resMdl == resMdl)
        {
            if (callback->nodeDesc == NNS_G3dRSGetCurrentNodeDescID(rs))
                break;
        }
    }

    if (c != Opening__RenderCallbackCount)
    {
        if (callback->func != NULL)
            callback->func(rs, callback->userData);

        NNS_G3dGeStoreMtx(callback->mtxStore);
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	ldr r1, =Opening__RenderCallbackCount
	ldr r2, [r0, #4]
	ldrh r5, [r1, #0]
	ldr lr, [r2, #4]
	ldr r3, =Opening__RenderCallbackList
	cmp r5, #0
	mov ip, #0
	bls _0215A0B4
	mvn r2, #0
_0215A074:
	ldr r1, [r3, ip, lsl #4]
	add r4, r3, ip, lsl #4
	cmp r1, lr
	bne _0215A0A0
	ldr r1, [r0, #8]
	tst r1, #0x10
	ldrneb r6, [r0, #0xae]
	ldrh r1, [r4, #4]
	moveq r6, r2
	cmp r1, r6
	beq _0215A0B4
_0215A0A0:
	add r1, ip, #1
	mov r1, r1, lsl #0x10
	cmp r5, r1, lsr #16
	mov ip, r1, lsr #0x10
	bhi _0215A074
_0215A0B4:
	cmp ip, r5
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r2, [r4, #8]
	cmp r2, #0
	beq _0215A0D4
	ldr r1, [r4, #0xc]
	blx r2
_0215A0D4:
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

NONMATCH_FUNC void AddOpeningRenderCallback(NNSG3dResMdl *resMdl, const char *name, s16 mtxStore, void (*func)(NNSG3dRS *context, void *userData), void *userData)
{
    // https://decomp.me/scratch/LGGKH -> 85.75%
#ifdef NON_MATCHING
    OpeningRenderCallbackConfig *callback = &Opening__RenderCallbackList[Opening__RenderCallbackCount++];

    s32 descID         = GetOpeningNodeDesc(resMdl, name);
    callback->resMdl   = resMdl;
    callback->nodeDesc = descID;
    callback->mtxStore = mtxStore;
    callback->func     = func;
    callback->userData = userData;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr ip, =Opening__RenderCallbackCount
	ldr r6, =Opening__RenderCallbackList
	ldrh r7, [ip]
	mov r5, r0
	mov r4, r2
	add r2, r7, #1
	strh r2, [ip]
	mov r9, r3
	add r8, r6, r7, lsl #4
	bl GetOpeningNodeDesc
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

s32 GetOpeningNodeDesc(NNSG3dResMdl *resMdl, const char *name)
{
    NNSG3dResName resName;

    MI_CpuFill8(resName.name, 0, sizeof(resName));
    STD_CopyString(resName.name, name);
    return NNS_G3dGetResDictIdxByName(&resMdl->nodeInfo.dict, &resName);
}

void GetOpeningMatrix(s32 num, FXMatrix43 *mtx)
{
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
    NNS_G3dGeRestoreMtx(num);
    NNS_G3dGetCurrentMtx(mtx->nnMtx, NULL);
}

void StartOpeningFade(OpeningFadeController *controller, OpeningFadeMode mode, fx32 fadeSpeed)
{
    Camera3DTask *camB;
    Camera3DTask *camA;

    camA = Camera3D__GetWork();
    camB = Camera3D__GetWork();

    MI_CpuClear16(controller, sizeof(OpeningFadeController));
    controller->mode      = mode;
    controller->fadeSpeed = MTM_MATH_CLIP(fadeSpeed, FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT), FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE));

    switch (mode)
    {
        case OPENING_FADE_TO_BLACK:
        case OPENING_FADE_TO_WHITE:
            controller->brightness         = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT);
            camA->gfxControl[0].brightness = RENDERCORE_BRIGHTNESS_DEFAULT;
            camB->gfxControl[1].brightness = RENDERCORE_BRIGHTNESS_DEFAULT;
            break;

        case OPENING_FADE_FROM_BLACK:
            controller->brightness         = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_BLACK);
            camA->gfxControl[0].brightness = RENDERCORE_BRIGHTNESS_BLACK;
            camB->gfxControl[1].brightness = RENDERCORE_BRIGHTNESS_BLACK;
            break;

        case OPENING_FADE_FROM_WHITE:
            controller->brightness         = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE);
            camA->gfxControl[0].brightness = RENDERCORE_BRIGHTNESS_WHITE;
            camB->gfxControl[1].brightness = RENDERCORE_BRIGHTNESS_WHITE;
            break;

        default:
            break;
    }
}

void EndOpeningFade(OpeningFadeController *controller)
{
    Camera3DTask *camA = Camera3D__GetWork();
    Camera3DTask *camB = Camera3D__GetWork();

    switch (controller->mode)
    {
        case OPENING_FADE_FROM_BLACK:
        case OPENING_FADE_FROM_WHITE:
            controller->brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT);
            break;

        case OPENING_FADE_TO_BLACK:
            controller->brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_BLACK);
            break;

        case OPENING_FADE_TO_WHITE:
            controller->brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE);
            break;

        default:
            break;
    }

    camA->gfxControl[0].brightness = FX32_TO_WHOLE(controller->brightness);
    camB->gfxControl[1].brightness = FX32_TO_WHOLE(controller->brightness);
}

BOOL ProcessOpeningFade(OpeningFadeController *controller)
{
    Camera3DTask *camA = Camera3D__GetWork();
    Camera3DTask *camB = Camera3D__GetWork();

    BOOL finished  = FALSE;
    fx32 fadeSpeed = MTM_MATH_CLIP(controller->fadeSpeed, FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT), FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE));

    switch (controller->mode)
    {
        case OPENING_FADE_FROM_BLACK:
            controller->brightness += fadeSpeed;
            if (controller->brightness > FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT))
            {
                controller->brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT);
                finished               = TRUE;
            }
            break;

        case OPENING_FADE_TO_BLACK:
            controller->brightness -= fadeSpeed;
            if (controller->brightness < FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_BLACK))
            {
                controller->brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_BLACK);
                finished               = TRUE;
            }
            break;

        case OPENING_FADE_FROM_WHITE:
            controller->brightness -= fadeSpeed;
            if (controller->brightness < FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT))
            {
                controller->brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_DEFAULT);
                finished               = TRUE;
            }
            break;

        case OPENING_FADE_TO_WHITE:
            controller->brightness += fadeSpeed;
            if (controller->brightness > FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE))
            {
                controller->brightness = FLOAT_TO_FX32(RENDERCORE_BRIGHTNESS_WHITE);
                finished               = TRUE;
            }
            break;

        default:
            break;
    }

    camA->gfxControl[0].brightness = FX32_TO_WHOLE(controller->brightness);
    camB->gfxControl[1].brightness = FX32_TO_WHOLE(controller->brightness);

    return finished;
}

BOOL CheckOpeningAnimatorFinished(AnimatorMDL *animator)
{
    return animator->animFlags[0] & ANIMATORMDL_FLAG_FINISHED;
}

BOOL IsOpeningSceneCompleteFinished(Opening *work)
{
    return (work->flags & OPENING_FLAG_SCENE_COMPLETE) != 0;
}

void InitOpeningWindowConfig(void)
{
    Camera3DTask *camera3DWork = Camera3D__GetWork();

    // Engine A
    {
        camera3DWork->gfxControl[GRAPHICS_ENGINE_A].windowManager.visible = GX_WNDMASK_W0 | GX_WNDMASK_W1;

        RenderCore_SetWndOutsidePlane(&camera3DWork->gfxControl[GRAPHICS_ENGINE_A].windowManager, GX_WND_PLANEMASK_BG1 | GX_WND_PLANEMASK_OBJ, FALSE);
        RenderCore_SetWindow0Position(&camera3DWork->gfxControl[GRAPHICS_ENGINE_A].windowManager, 144, 0, 224, 0);

        RenderCore_SetWnd0InsidePlane(&camera3DWork->gfxControl[GRAPHICS_ENGINE_A].windowManager, GX_WND_PLANEMASK_BG2 | GX_WND_PLANEMASK_OBJ, FALSE);
        RenderCore_SetWindow1Position(&camera3DWork->gfxControl[GRAPHICS_ENGINE_A].windowManager, 32, 0, 112, 0);

        RenderCore_SetWnd1InsidePlane(&camera3DWork->gfxControl[GRAPHICS_ENGINE_A].windowManager, GX_WND_PLANEMASK_BG3 | GX_WND_PLANEMASK_OBJ, FALSE);
    }

    // Engine B
    {
        camera3DWork->gfxControl[GRAPHICS_ENGINE_B].windowManager.visible = GX_WNDMASK_W0 | GX_WNDMASK_W1;

        RenderCore_SetWndOutsidePlane(&camera3DWork->gfxControl[GRAPHICS_ENGINE_B].windowManager, GX_WND_PLANEMASK_BG1 | GX_WND_PLANEMASK_OBJ, FALSE);
        RenderCore_SetWindow0Position(&camera3DWork->gfxControl[GRAPHICS_ENGINE_B].windowManager, 144, 0, 224, FALSE);

        RenderCore_SetWnd0InsidePlane(&camera3DWork->gfxControl[GRAPHICS_ENGINE_B].windowManager, GX_WND_PLANEMASK_BG2 | GX_WND_PLANEMASK_OBJ, FALSE);
        RenderCore_SetWindow1Position(&camera3DWork->gfxControl[GRAPHICS_ENGINE_B].windowManager, 32, 0, 112, 0);

        RenderCore_SetWnd1InsidePlane(&camera3DWork->gfxControl[GRAPHICS_ENGINE_B].windowManager, GX_WND_PLANEMASK_BG3 | GX_WND_PLANEMASK_OBJ, FALSE);
    }
}

void ConfigureOpeningWindowForSonic(fx32 y)
{
    Camera3DTask *camera3DWork = Camera3D__GetWork();

    if (y > HW_LCD_HEIGHT)
    {
        RenderCore_SetWindow0Position(&camera3DWork->gfxControl[0].windowManager, 144, 0, 224, HW_LCD_HEIGHT);
        RenderCore_SetWindow0Position(&camera3DWork->gfxControl[1].windowManager, 144, 0, 224, MTM_MATH_CLIP(y - BOTTOM_SCREEN_CAMERA_OFFSET, 0, HW_LCD_HEIGHT));
    }
    else
    {
        RenderCore_SetWindow0Position(&camera3DWork->gfxControl[0].windowManager, 144, 0, 224, y);
        RenderCore_SetWindow0Position(&camera3DWork->gfxControl[1].windowManager, 144, 0, 224, 0);
    }
}

void ConfigureOpeningWindowForBlaze(fx32 y)
{
    Camera3DTask *camera3DWork = Camera3D__GetWork();

    if (y > HW_LCD_HEIGHT)
    {
        RenderCore_SetWindow1Position(&camera3DWork->gfxControl[0].windowManager, 32, MTM_MATH_CLIP(HW_LCD_HEIGHT - (y - BOTTOM_SCREEN_CAMERA_OFFSET), 0, HW_LCD_HEIGHT), 112,
                                      HW_LCD_HEIGHT);
        RenderCore_SetWindow1Position(&camera3DWork->gfxControl[1].windowManager, 32, 0, 112, HW_LCD_HEIGHT);
    }
    else
    {
        RenderCore_SetWindow1Position(&camera3DWork->gfxControl[0].windowManager, 32, 0, 112, 0);
        RenderCore_SetWindow1Position(&camera3DWork->gfxControl[1].windowManager, 32, HW_LCD_HEIGHT - y, 112, HW_LCD_HEIGHT);
    }
}

void ClearOpeningWindowConfig(void)
{
    Camera3DTask *camera3DWork = Camera3D__GetWork();

    MI_CpuClear16(&camera3DWork->gfxControl[GRAPHICS_ENGINE_A].windowManager, sizeof(camera3DWork->gfxControl[GRAPHICS_ENGINE_A].windowManager));
    MI_CpuClear16(&camera3DWork->gfxControl[GRAPHICS_ENGINE_B].windowManager, sizeof(camera3DWork->gfxControl[GRAPHICS_ENGINE_B].windowManager));
}

void SetOpeningBackgroundPos(s32 id, fx32 x, fx32 y)
{
    Camera3DTask *camera3DWork = Camera3D__GetWork();

    camera3DWork->gfxControl[GRAPHICS_ENGINE_A].bgPosition[id].x = FX32_TO_WHOLE(x);
    camera3DWork->gfxControl[GRAPHICS_ENGINE_A].bgPosition[id].y = MTM_MATH_CLIP_2(FX32_TO_WHOLE(y), -HW_LCD_WIDTH, HW_LCD_WIDTH);

    camera3DWork->gfxControl[GRAPHICS_ENGINE_B].bgPosition[id].x = FX32_TO_WHOLE(x);
    camera3DWork->gfxControl[GRAPHICS_ENGINE_B].bgPosition[id].y = MTM_MATH_CLIP_2(FX32_TO_WHOLE(y) + BOTTOM_SCREEN_CAMERA_OFFSET, -HW_LCD_WIDTH, HW_LCD_WIDTH);
}

void DrawOpeningSprite(AnimatorSprite *animator)
{
    if (Camera3D__UseEngineA())
    {
        AnimatorSprite__DrawFrame(animator);
    }
    else
    {
        fx32 y = animator->pos.y;

        animator->pos.y = y - BOTTOM_SCREEN_CAMERA_OFFSET;
        AnimatorSprite__DrawFrame(animator);

        animator->pos.y = y;
    }
}

void Opening_Destructor(Task *task)
{
    Opening *work = TaskGetWork(task, Opening);

    StopSysStream();
    ReleaseSysSound();
    StopSamplingTouchInput();
    ReleaseOpeningPaletteAnimations(work);
    ReleaseOpeningAnimators(work);
    ReleaseOpeningArchives(work);

    FS_SetDefaultDMA(FS_DMA_NOT_USE);
}

void Opening_Main_Init(void)
{
    Opening *work = TaskGetWorkCurrent(Opening);

    work->stateSequence  = Opening_StateSequence_Init;
    work->stateScene     = Opening_StateScene_InitAnimatedScene;
    work->touchSkipDelay = 5;

    PlaySysStream(0, TRUE);
    SetCurrentTaskMainEvent(Opening_Main_Playback);
}

void Opening_Main_Playback(void)
{
    Opening *work = TaskGetWorkCurrent(Opening);

    if (work->stateSequence != NULL)
        work->stateSequence(work);

    if (work->stateScene != NULL)
        work->stateScene(work);

    if ((work->flags & OPENING_FLAG_IS_FINISHED) != 0)
    {
        SetCurrentTaskMainEvent(Opening_Main_Finished);
    }
    else if (CheckOpeningSkip(work) && (work->flags & OPENING_FLAG_WAS_SKIPPED) == 0)
    {
        PlaySysSfx(0);
        FadeSysStream(15);
        work->flags |= OPENING_FLAG_WAS_SKIPPED;

        SetOpeningState(work->stateSequence, Opening_StateSequence_StartFadeOut);
    }
}

void Opening_Main_Finished(void)
{
    Opening *work = TaskGetWorkCurrent(Opening);

    Camera3D__Destroy();
    ChangeEventForOpening(work);
    ClearOpeningTasks();
}

s32 GetOpeningSceneType(s32 sceneID)
{
    return sceneTypeList[sceneID];
}

BOOL CompleteOpeningScene(Opening *work)
{
    work->sceneID++;
    if (work->sceneID > OPENING_SCENE_COUNT)
    {
        work->sceneID = OPENING_SCENE_COUNT;
        return TRUE;
    }

    return FALSE;
}

u32 GetOpeningSceneID(Opening *work)
{
    return work->sceneID;
}

BOOL CompleteOpeningAnimatedScene(Opening *work)
{
    work->animatedSceneID++;
    if (work->animatedSceneID > OPENING_ANIMATED_SCENE_COUNT)
    {
        work->animatedSceneID = OPENING_ANIMATED_SCENE_COUNT;
        return TRUE;
    }

    CompleteOpeningScene(work);
    return FALSE;
}

u32 GetOpeningAnimatedSceneID(Opening *work)
{
    return work->animatedSceneID;
}

BOOL CompleteOpeningCutInScene(Opening *work)
{
    work->cutInSceneID++;
    if (work->cutInSceneID > OPENING_CUTIN_SCENE_COUNT)
    {
        work->cutInSceneID = OPENING_CUTIN_SCENE_COUNT;
        return TRUE;
    }

    CompleteOpeningScene(work);
    return FALSE;
}

void Opening_StateSequence_Init(Opening *work)
{
    SetOpeningState(work->stateSequence, Opening_StateSequence_InitNextScene);
}

void Opening_StateSequence_InitNextScene(Opening *work)
{
    StopSysSfx();

    u32 sceneID = GetOpeningSceneID(work);
    if (sceneID < OPENING_SCENE_COUNT)
    {
        switch (GetOpeningSceneType(sceneID))
        {
            case OPENING_SCENETYPE_ANIMATED:
                SetOpeningState(work->stateSequence, Opening_StateSequence_InitAnimatedScene);
                break;

            case OPENING_SCENETYPE_CUTIN:
                SetOpeningState(work->stateSequence, Opening_StateSequence_InitCutInScene);
                break;
        }
    }
    else
    {
        work->flags |= OPENING_FLAG_IS_FINISHED;
        SetOpeningState(work->stateSequence, NULL);
    }
}

void Opening_StateSequence_InitAnimatedScene(Opening *work)
{
    SetOpeningState(work->stateScene, Opening_StateScene_InitAnimatedScene);
    SetOpeningState(work->stateSequence, Opening_StateSequence_WaitSceneCompleted);
}

void Opening_StateSequence_WaitSceneCompleted(Opening *work)
{
    if (IsOpeningSceneCompleteFinished(work))
    {
        work->flags &= ~OPENING_FLAG_SCENE_COMPLETE;
        StopSysSfx();
        CompleteOpeningAnimatedScene(work);

        SetOpeningState(work->stateSequence, Opening_StateSequence_InitNextScene);
    }
}

void Opening_StateSequence_InitCutInScene(Opening *work)
{
    SetOpeningState(work->stateScene, Opening_StateScene_InitCutInScene);
    CreateOpeningBorderSprite(work);
    SetOpeningState(work->stateSequence, Opening_StateSequence_WaitCutInCompleted);
}

void Opening_StateSequence_WaitCutInCompleted(Opening *work)
{
    if ((work->flags & OPENING_FLAG_ALL_CUTIN_DONE) != 0)
    {
        DestroyTaskGroup(TASK_GROUP(1));
        CompleteOpeningCutInScene(work);

        SetOpeningState(work->stateSequence, Opening_StateSequence_InitNextScene);
    }
}

void Opening_StateSequence_StartFadeOut(Opening *work)
{
    StartOpeningFade(&work->fadeControl, OPENING_FADE_TO_WHITE, FLOAT_TO_FX32(1.0666504));

    SetOpeningState(work->stateSequence, Opening_StateSequence_ProcessFadeOut);
}

void Opening_StateSequence_ProcessFadeOut(Opening *work)
{
    if (!ProcessOpeningFade(&work->fadeControl))
        return;

    EndOpeningFade(&work->fadeControl);
    work->flags |= OPENING_FLAG_IS_FINISHED;

    SetOpeningState(work->stateSequence, NULL);
}

void Opening_StateScene_InitAnimatedScene(Opening *work)
{
    static OpeningState sceneInitList[OPENING_ANIMATED_SCENE_COUNT] = {
        Opening_InitScene_OpeningOverhead, Opening_InitScene_JetSkiRide, Opening_InitScene_SonicBlazeGlance, Opening_InitScene_TailsMarineWave, Opening_InitScene_JetSkiSkid,
    };

    GX_SetVisiblePlane(GX_PLANEMASK_BG0);

    OpeningState initSceneFunc = sceneInitList[GetOpeningAnimatedSceneID(work)];
    if (initSceneFunc != NULL)
        initSceneFunc(work);

    SetOpeningState(work->stateScene, Opening_StateScene_ProcessAnimatedScene);
}

void Opening_StateScene_ProcessAnimatedScene(Opening *work)
{
    s32 i;
    AnimatorMDL *targetAnimator = NULL;

    for (i = OPENING_ANIMATOR_CAMERA1; i <= OPENING_ANIMATOR_CAMERA2; i++)
    {
        AnimatorMDL *animator = &work->worldControl.animators[i];

        if ((animator->work.flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0)
        {
            AnimatorMDL__ProcessAnimation(animator);
            AnimatorMDL__Draw(animator);
        }
    }

    GetOpeningMatrix(OPENING_MAT_CAMERA1_NODE, &work->worldControl.matCamera1);
    GetOpeningMatrix(OPENING_MAT_TARGET1_NODE, &work->worldControl.matTarget1);
    GetOpeningMatrix(OPENING_MAT_CAMERA2_NODE, &work->worldControl.matCamera2);
    GetOpeningMatrix(OPENING_MAT_TARGET2_NODE, &work->worldControl.matTarget2);

    if (Camera3D__UseEngineA())
    {
        work->worldControl.camera.config.matProjPosition.y = -work->worldControl.matProjPosY;

        VEC_SetFromArray(&work->worldControl.camera.camPos, &work->worldControl.matCamera1.m[3][0]);
        VEC_SetFromArray(&work->worldControl.camera.camTarget, &work->worldControl.matTarget1.m[3][0]);
    }
    else
    {
        if (work->worldControl.matProjPosY != 0)
        {
            work->worldControl.camera.config.matProjPosition.y = work->worldControl.matProjPosY;

            VEC_SetFromArray(&work->worldControl.camera.camPos, &work->worldControl.matCamera1.m[3][0]);
            VEC_SetFromArray(&work->worldControl.camera.camTarget, &work->worldControl.matTarget1.m[3][0]);
        }
        else
        {
            VEC_SetFromArray(&work->worldControl.camera.camPos, &work->worldControl.matCamera2.m[3][0]);
            VEC_SetFromArray(&work->worldControl.camera.camTarget, &work->worldControl.matTarget2.m[3][0]);
        }
    }

    Camera3D__LoadState(&work->worldControl.camera);

    for (i = OPENING_ANIMATOR_SEAGULL; i < OPENING_ANIMATOR_COUNT; i++)
    {
        AnimatorMDL *animator = &work->worldControl.animators[i];

        if ((animator->work.flags & ANIMATOR_FLAG_DISABLE_DRAW) == 0)
        {
            AnimatorMDL__ProcessAnimation(animator);

            if (GetOpeningAnimatedSceneID(work) == OPENING_ANIMATED_SCENE_TAILS_MARINE_WAVE)
            {
                switch (i)
                {
                    case OPENING_ANIMATOR_JETSKI_TRAIL:
                    case OPENING_ANIMATOR_JETSKI_SPLASH:
                        break;

                    case OPENING_ANIMATOR_JETSKI:
                    case OPENING_ANIMATOR_SONIC:
                    case OPENING_ANIMATOR_BLAZE:
                        if (!Camera3D__UseEngineA())
                            break;
                        // fallthrough

                    default:
                        AnimatorMDL__Draw(animator);
                        break;
                }
            }
            else
            {
                AnimatorMDL__Draw(animator);
            }

            targetAnimator = animator;
        }
    }

    if (targetAnimator != NULL)
    {
        if (!GetOpeningSceneID(work) && targetAnimator->currentAnimObj[B3D_ANIM_JOINT_ANIM]->frame <= FLOAT_TO_FX32(20.0) && (work->flags & OPENING_FLAG_IS_FADING) == 0)
        {
            StartOpeningFade(&work->fadeControl, OPENING_FADE_FROM_WHITE, FLOAT_TO_FX32(0.8));
            work->flags |= OPENING_FLAG_IS_FADING;
        }

        if (GetOpeningSceneID(work) == OPENING_SCENE_ANI_TJETSKI_SKID
            && targetAnimator->currentAnimObj[B3D_ANIM_JOINT_ANIM]->frame >= NNS_G3dAnmObjGetNumFrame(targetAnimator->currentAnimObj[0]) - FLOAT_TO_FX32(30.0)
            && (work->flags & OPENING_FLAG_IS_FADING) == 0)
        {
            StartOpeningFade(&work->fadeControl, OPENING_FADE_TO_WHITE, FLOAT_TO_FX32(0.533204));
            work->flags |= OPENING_FLAG_IS_FADING;
        }

        if ((work->flags & OPENING_FLAG_IS_FADING) != 0 && ProcessOpeningFade(&work->fadeControl))
        {
            EndOpeningFade(&work->fadeControl);
            work->flags &= ~OPENING_FLAG_IS_FADING;
        }

        if (CheckOpeningAnimatorFinished(targetAnimator))
            work->flags |= OPENING_FLAG_SCENE_COMPLETE;
    }
}

void Opening_StateScene_InitCutInScene(Opening *work)
{
    GX_SetVisiblePlane(GX_PLANEMASK_BG1);

    SetOpeningState(work->stateScene, Opening_StateScene_ProcessCutInScene);
}

void Opening_StateScene_ProcessCutInScene(Opening *work)
{
    Camera3DTask *camera3DWork = Camera3D__GetWork();

    for (s32 i = 0; i < 4; i++)
    {
        camera3DWork->gfxControl[GRAPHICS_ENGINE_A].bgPosition[i].x = 0;
        camera3DWork->gfxControl[GRAPHICS_ENGINE_A].bgPosition[i].y = 0;

        camera3DWork->gfxControl[GRAPHICS_ENGINE_B].bgPosition[i].x = 0;
        camera3DWork->gfxControl[GRAPHICS_ENGINE_B].bgPosition[i].y = BOTTOM_SCREEN_CAMERA_OFFSET;
    }

    AnimatePalette(&work->worldControl.aniPalette);
    DrawAnimatedPalette(&work->worldControl.aniPalette);
}

void Opening_InitScene_OpeningOverhead(Opening *work)
{
    InitOpeningCameraForScene(work, OPENING_ANIMATED_SCENE_OPENING_OVERHEAD);

    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_SPLASH], B3D_ANIM_MAT_ANIM, work->worldControl.matAniCutscene, 0, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_TRAIL], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 0, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SEA], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 1, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SONIC], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 0, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_BLAZE], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 1, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SEA], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 2, NULL, FALSE);
}

void Opening_InitScene_JetSkiRide(Opening *work)
{
    InitOpeningCameraForScene(work, OPENING_ANIMATED_SCENE_JETSKI_RIDE);

    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_SPLASH], B3D_ANIM_MAT_ANIM, work->worldControl.matAniCutscene, 1, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_TRAIL], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 2, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SEA], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 3, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SONIC], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 3, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_BLAZE], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 4, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SEA], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 5, NULL, FALSE);
}

void Opening_InitScene_SonicBlazeGlance(Opening *work)
{
    InitOpeningCameraForScene(work, OPENING_ANIMATED_SCENE_SONIC_BLAZE_GLANCE);

    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_SPLASH], B3D_ANIM_MAT_ANIM, work->worldControl.matAniCutscene, 2, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_TRAIL], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 4, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SEA], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 5, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SONIC], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 6, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_BLAZE], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 7, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SEA], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 8, NULL, FALSE);
}

void Opening_InitScene_TailsMarineWave(Opening *work)
{
    InitOpeningCameraForScene(work, OPENING_ANIMATED_SCENE_TAILS_MARINE_WAVE);

    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_SPLASH], B3D_ANIM_MAT_ANIM, work->worldControl.matAniCutscene, 3, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_TRAIL], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 6, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SEA], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 7, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SPLASH_TAILS], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 8, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SPLASH_MARINE], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 9, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SONIC], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 9, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_BLAZE], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 10, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SEA], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 11, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_TAILS], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 12, NULL, FALSE);
}

void Opening_InitScene_JetSkiSkid(Opening *work)
{
    InitOpeningCameraForScene(work, OPENING_ANIMATED_SCENE_JETSKI_SKID);

    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_SPLASH], B3D_ANIM_MAT_ANIM, work->worldControl.matAniCutscene, 4, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_TRAIL], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 10, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SEA], B3D_ANIM_TEX_ANIM, work->worldControl.texAniCutscene, 11, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SONIC], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 13, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_BLAZE], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 14, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_SEA], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 15, NULL, FALSE);
    SetOpeningAnimation(&work->worldControl.animators[OPENING_ANIMATOR_JETSKI_SPLASH2], B3D_ANIM_VIS_ANIM, work->worldControl.visAniCutscene, 16, NULL, FALSE);
}

// OpeningBorderSprite
void CreateOpeningBorderSprite(Opening *parent)
{
    Task *task =
        TaskCreate(OpeningBorderSprite_Main_Init, OpeningBorderSprite_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000, TASK_GROUP(1), OpeningBorderSprite);

    OpeningBorderSprite *work = TaskGetWork(task, OpeningBorderSprite);
    TaskInitWork16(work);

    work->parent = parent;

    void *spriteFile = FileUnknown__GetAOUFile(parent->archiveSprites, ARCHIVE_DMOP_LZ7_FILE_BDPLUS_BAC);
    for (s32 i = 0; i < 2; i++)
    {
        AnimatorSprite__Init(&work->aniBorder[i], spriteFile, 0, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, FALSE, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2(spriteFile)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
        work->aniBorder[i].cParam.palette = PALETTE_ROW_1;
        AnimatorSprite__ProcessAnimationFast(&work->aniBorder[i]);
    }

    work->aniBorder[0].pos.x = 72;
    work->aniBorder[0].pos.y = 0;
    work->aniBorder[0].flags |= ANIMATOR_FLAG_FLIP_Y;

    work->aniBorder[1].pos.x = 184;
    work->aniBorder[1].pos.y = 0;
}

void OpeningBorderSprite_Destructor(Task *task)
{
    OpeningBorderSprite *work = TaskGetWork(task, OpeningBorderSprite);

    for (s32 i = 0; i < 2; i++)
    {
        AnimatorSprite__Release(&work->aniBorder[i]);
    }
}

void OpeningBorderSprite_Main_Init(void)
{
    OpeningBorderSprite *work = TaskGetWorkCurrent(OpeningBorderSprite);
    Opening *parent           = work->parent;

    GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_OBJ);
    MI_CpuClear16(&parent->border, sizeof(struct OpeningBorderControl));
    InitOpeningWindowConfig();
    parent->border.timer = 20;
    SetCurrentTaskMainEvent(OpeningBorderSprite_Main_EnterDelay);
}

void OpeningBorderSprite_Main_EnterDelay(void)
{
    OpeningBorderSprite *work = TaskGetWorkCurrent(OpeningBorderSprite);
    Opening *parent           = work->parent;

    if (parent->border.timer != 0)
        parent->border.timer--;
    else
        SetCurrentTaskMainEvent(OpeningBorderSprite_Main_EnterBorder);
}

void OpeningBorderSprite_Main_EnterBorder(void)
{
    OpeningBorderSprite *work = TaskGetWorkCurrent(OpeningBorderSprite);
    Opening *parent           = work->parent;

    if ((work->parent->border.flags & OPENING_BORDER_SPRITE_FLAG_SONIC_DONE) != 0)
    {
        parent->border.blazePos += 32;
        if (parent->border.blazePos >= 464)
        {
            parent->border.blazePos = 464;
            CreateOpeningBlazeNameSprite(parent);
            SetCurrentTaskMainEvent(OpeningBorderSprite_Main_DisplayCharacters);
        }
    }
    else
    {
        parent->border.sonicPos += 32;
        if (parent->border.sonicPos >= 464)
        {
            parent->border.sonicPos = 464;
            parent->border.flags |= OPENING_BORDER_SPRITE_FLAG_SONIC_DONE;
            CreateOpeningSonicNameSprite(parent);
        }
    }

    ConfigureOpeningWindowForSonic(parent->border.sonicPos);
    ConfigureOpeningWindowForBlaze(parent->border.blazePos);

    work->aniBorder[0].pos.x = 72;
    work->aniBorder[0].pos.y = 464 - parent->border.blazePos;

    work->aniBorder[1].pos.x = 184;
    work->aniBorder[1].pos.y = parent->border.sonicPos;

    if ((parent->border.flags & OPENING_BORDER_SPRITE_FLAG_SONIC_DONE) != 0)
        DrawOpeningSprite(&work->aniBorder[0]);

    DrawOpeningSprite(&work->aniBorder[1]);
}

void OpeningBorderSprite_Main_DisplayCharacters(void)
{
    OpeningBorderSprite *work = TaskGetWorkCurrent(OpeningBorderSprite);
    Opening *parent           = work->parent;

    if ((parent->flags & OPENING_FLAG_CHARACTER_CUTIN_DONE) != 0)
        SetCurrentTaskMainEvent(OpeningBorderSprite_Main_ExitBorder);
}

void OpeningBorderSprite_Main_ExitBorder(void)
{
    OpeningBorderSprite *work = TaskGetWorkCurrent(OpeningBorderSprite);
    Opening *parent           = work->parent;

    parent->border.sonicPos -= 32;
    parent->border.blazePos -= 32;
    if (parent->border.sonicPos <= 0)
    {
        parent->border.sonicPos = 0;
        parent->border.blazePos = 0;
        parent->border.timer    = 20;
        SetCurrentTaskMainEvent(OpeningBorderSprite_Main_ExitDelay);
    }

    ConfigureOpeningWindowForSonic(parent->border.sonicPos);
    ConfigureOpeningWindowForBlaze(parent->border.blazePos);

    work->aniBorder[0].pos.x = 72;
    work->aniBorder[0].pos.y = 464 - parent->border.blazePos;

    work->aniBorder[1].pos.x = 184;
    work->aniBorder[1].pos.y = parent->border.sonicPos;

    DrawOpeningSprite(&work->aniBorder[0]);
    DrawOpeningSprite(&work->aniBorder[1]);
}

void OpeningBorderSprite_Main_ExitDelay(void)
{
    OpeningBorderSprite *work = TaskGetWorkCurrent(OpeningBorderSprite);
    Opening *parent           = work->parent;

    if (parent->border.timer != 0)
        parent->border.timer--;
    else
        SetCurrentTaskMainEvent(OpeningBorderSprite_Main_Finished);
}

void OpeningBorderSprite_Main_Finished(void)
{
    OpeningBorderSprite *work = TaskGetWorkCurrent(OpeningBorderSprite);

    Opening *parent = work->parent;
    ClearOpeningWindowConfig();
    parent->flags |= OPENING_FLAG_ALL_CUTIN_DONE;
    DestroyCurrentTask();
}

// OpeningSonicNameSprite
void CreateOpeningSonicNameSprite(Opening *parent)
{
    Camera3DTask *camera3D = Camera3D__GetWork();
    UNUSED(camera3D);

    Task *task = TaskCreate(OpeningSonicNameSprite_Main_Init, OpeningSonicNameSprite_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4000, TASK_GROUP(1),
                            OpeningSonicNameSprite);

    OpeningSonicNameSprite *work = TaskGetWork(task, OpeningSonicNameSprite);
    TaskInitWork16(work);

    work->parent               = parent;
    work->backgroundPosition.x = -FLOAT_TO_FX32(144.0);
    work->backgroundPosition.y = -FLOAT_TO_FX32(464.0);
    SetOpeningBackgroundPos(BACKGROUND_2, work->backgroundPosition.x, work->backgroundPosition.y);

    void *spriteFile = FileUnknown__GetAOUFile(parent->archiveSprites, ARCHIVE_DMOP_LZ7_FILE_NAME_BAC);

    for (s32 i = 0; i < 16; i++)
    {
        u16 anim = sonicNameLetterAniList[i];

        AnimatorSprite__Init(&work->aniLetters[i], spriteFile, anim, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_DRAW, FALSE, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2FromAnim(spriteFile, sonicNameLetterAniList[i])), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                             SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        work->aniLetters[i].pos.x = sonicNameLetterPositions[i].x;
        work->aniLetters[i].pos.y = sonicNameLetterPositions[i].y;
        AnimatorSprite__ProcessAnimationFast(&work->aniLetters[i]);
    }
}

void OpeningSonicNameSprite_Destructor(Task *task)
{
    OpeningSonicNameSprite *work = TaskGetWork(task, OpeningSonicNameSprite);

    for (s32 i = 0; i < 16; i++)
    {
        AnimatorSprite__Release(&work->aniLetters[i]);
    }
}

void OpeningSonicNameSprite_Main_Init(void)
{
    OpeningSonicNameSprite *work = TaskGetWorkCurrent(OpeningSonicNameSprite);
    UNUSED(work);

    SetCurrentTaskMainEvent(OpeningSonicNameSprite_Main_EnterSprite);
}

void OpeningSonicNameSprite_Main_EnterSprite(void)
{
    OpeningSonicNameSprite *work = TaskGetWorkCurrent(OpeningSonicNameSprite);

    GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG2 | GX_PLANEMASK_OBJ);
    work->backgroundPosition.x = -FLOAT_TO_FX32(144.0);
    work->backgroundPosition.y += FLOAT_TO_FX32(32.0);
    SetOpeningBackgroundPos(BACKGROUND_2, work->backgroundPosition.x, work->backgroundPosition.y);

    if (work->backgroundPosition.y >= FLOAT_TO_FX32(0.0))
    {
        work->enterTimer = 20;
        SetCurrentTaskMainEvent(OpeningSonicNameSprite_Main_ShowSprite);
    }
}

void OpeningSonicNameSprite_Main_ShowSprite(void)
{
    OpeningSonicNameSprite *work = TaskGetWorkCurrent(OpeningSonicNameSprite);

    work->backgroundPosition.x = -FLOAT_TO_FX32(144.0);
    work->backgroundPosition.y += FLOAT_TO_FX32(0.2);
    SetOpeningBackgroundPos(BACKGROUND_2, work->backgroundPosition.x, work->backgroundPosition.y);

    if (work->enterTimer != 0)
        work->enterTimer--;
    else
        SetCurrentTaskMainEvent(OpeningSonicNameSprite_Main_ShowName);
}

void OpeningSonicNameSprite_Main_ShowName(void)
{
    OpeningSonicNameSprite *work = TaskGetWorkCurrent(OpeningSonicNameSprite);

    work->backgroundPosition.x = -FLOAT_TO_FX32(144.0);
    work->backgroundPosition.y += FLOAT_TO_FX32(0.2);

    if (work->letterTimer >= 120 && (work->flags & OPENING_NAME_SPRITE_FLAG_HIDE_LETTERS) == 0)
    {
        work->nameLetterID     = 0;
        work->subtitleLetterID = 0;
        work->flags |= OPENING_NAME_SPRITE_FLAG_HIDE_LETTERS;
    }

    if ((work->flags & OPENING_NAME_SPRITE_FLAG_HIDE_LETTERS) == 0)
    {
        if ((work->letterTimer % 4) == 0)
        {
            if ((work->aniLetters[work->nameLetterID].flags & OPENING_NAME_SPRITE_FLAG_HIDE_LETTERS) != 0)
            {
                work->aniLetters[work->nameLetterID].flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
                work->aniLetters[work->nameLetterID].pos.y -= 6;
            }

            if (work->nameLetterID < 5)
                work->nameLetterID++;

            if (work->nameLetterID >= 1)
            {
                for (s32 i = 0; i < 2; i++)
                {
                    if (work->subtitleLetterID < 11)
                    {
                        work->aniLetters[work->subtitleLetterID + 5].flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
                        work->subtitleLetterID++;
                    }
                }
            }
        }
        else
        {
            if (work->aniLetters[work->nameLetterID - 1].pos.y < sonicNameLetterPositions[work->nameLetterID - 1].y)
                work->aniLetters[work->nameLetterID - 1].pos.y += 2;
            else
                work->aniLetters[work->nameLetterID - 1].pos.y = sonicNameLetterPositions[work->nameLetterID - 1].y;
        }
    }
    else
    {
        work->aniLetters[work->nameLetterID].flags |= ANIMATOR_FLAG_DISABLE_DRAW;

        if (work->nameLetterID < 5)
            work->nameLetterID++;

        if (work->nameLetterID >= 1)
        {
            for (s32 i = 0; i < 2; i++)
            {
                if (work->subtitleLetterID < 11)
                {
                    work->aniLetters[work->subtitleLetterID + 5].flags |= ANIMATOR_FLAG_DISABLE_DRAW;
                    work->subtitleLetterID++;
                }
                else
                {
                    work->flags |= OPENING_NAME_SPRITE_FLAG_IS_DONE;
                }
            }
        }
    }

    work->letterTimer++;
    for (s32 i = 0; i < 16; i++)
    {
        DrawOpeningSprite(&work->aniLetters[i]);
    }

    SetOpeningBackgroundPos(BACKGROUND_2, work->backgroundPosition.x, work->backgroundPosition.y);

    if ((work->flags & OPENING_NAME_SPRITE_FLAG_IS_DONE) != 0)
    {
        work->letterTimer = 0;
        work->exitTimer   = 5;
        SetCurrentTaskMainEvent(OpeningSonicNameSprite_Main_BeginExitSprite);
    }
}

void OpeningSonicNameSprite_Main_BeginExitSprite(void)
{
    OpeningSonicNameSprite *work = TaskGetWorkCurrent(OpeningSonicNameSprite);

    work->backgroundPosition.x = -FLOAT_TO_FX32(144.0);
    work->backgroundPosition.y -= FLOAT_TO_FX32(2.0);

    SetOpeningBackgroundPos(BACKGROUND_2, work->backgroundPosition.x, work->backgroundPosition.y);

    if (work->exitTimer != 0)
        work->exitTimer--;
    else
        SetCurrentTaskMainEvent(OpeningSonicNameSprite_Main_ExitSprite);
}

void OpeningSonicNameSprite_Main_ExitSprite(void)
{
    OpeningSonicNameSprite *work = TaskGetWorkCurrent(OpeningSonicNameSprite);

    work->backgroundPosition.x = -FLOAT_TO_FX32(144.0);
    work->backgroundPosition.y += FLOAT_TO_FX32(32.0);

    SetOpeningBackgroundPos(BACKGROUND_2, work->backgroundPosition.x, work->backgroundPosition.y);
}

// OpeningBlazeNameSprite
void CreateOpeningBlazeNameSprite(Opening *parent)
{
    Task *task = TaskCreate(OpeningBlazeNameSprite_Main_Init, OpeningBlazeNameSprite_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x4000, TASK_GROUP(1),
                            OpeningBlazeNameSprite);

    OpeningBlazeNameSprite *work = TaskGetWork(task, OpeningBlazeNameSprite);
    TaskInitWork16(work);

    work->parent               = parent;
    work->backgroundPosition.x = -FLOAT_TO_FX32(32.0);
    work->backgroundPosition.y = FLOAT_TO_FX32(256.0);
    SetOpeningBackgroundPos(BACKGROUND_3, work->backgroundPosition.x, work->backgroundPosition.y);

    void *spriteFile = FileUnknown__GetAOUFile(parent->archiveSprites, ARCHIVE_DMOP_LZ7_FILE_NAME_BAC);
    for (s32 i = 0; i < 11; i++)
    {
        u16 anim = blazeNameLetterAniList[i];

        AnimatorSprite__Init(&work->aniLetters[i], spriteFile, anim, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK | ANIMATOR_FLAG_DISABLE_DRAW, FALSE, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize2FromAnim(spriteFile, blazeNameLetterAniList[i])), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT,
                             SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        work->aniLetters[i].pos.x = blazeNameLetterPositions[i].x;
        work->aniLetters[i].pos.y = blazeNameLetterPositions[i].y + 80;
        AnimatorSprite__ProcessAnimationFast(&work->aniLetters[i]);
    }
}

void OpeningBlazeNameSprite_Destructor(Task *task)
{
    OpeningBlazeNameSprite *work = TaskGetWork(task, OpeningBlazeNameSprite);

    for (s32 i = 0; i < 11; i++)
    {
        AnimatorSprite__Release(&work->aniLetters[i]);
    }
}

void OpeningBlazeNameSprite_Main_Init(void)
{
    OpeningBlazeNameSprite *work = TaskGetWorkCurrent(OpeningBlazeNameSprite);
    UNUSED(work);

    SetCurrentTaskMainEvent(OpeningBlazeNameSprite_Main_EnterSprite);
}

void OpeningBlazeNameSprite_Main_EnterSprite(void)
{
    OpeningBlazeNameSprite *work = TaskGetWorkCurrent(OpeningBlazeNameSprite);

    GX_SetVisiblePlane(GX_GetVisiblePlane() | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);

    work->backgroundPosition.x = -FLOAT_TO_FX32(32.0);
    work->backgroundPosition.y -= FLOAT_TO_FX32(32.0);
    SetOpeningBackgroundPos(BACKGROUND_3, work->backgroundPosition.x, work->backgroundPosition.y);

    if (work->backgroundPosition.y <= -FLOAT_TO_FX32(208.0))
    {
        work->enterTimer = 20;
        SetCurrentTaskMainEvent(OpeningBlazeNameSprite_Main_ShowSprite);
    }
}

void OpeningBlazeNameSprite_Main_ShowSprite(void)
{
    OpeningBlazeNameSprite *work = TaskGetWorkCurrent(OpeningBlazeNameSprite);

    work->backgroundPosition.x = -FLOAT_TO_FX32(32.0);
    work->backgroundPosition.y -= FLOAT_TO_FX32(0.2);
    SetOpeningBackgroundPos(BACKGROUND_3, work->backgroundPosition.x, work->backgroundPosition.y);

    if (work->enterTimer != 0)
        work->enterTimer--;
    else
        SetCurrentTaskMainEvent(OpeningBlazeNameSprite_Main_ShowName);
}

void OpeningBlazeNameSprite_Main_ShowName(void)
{
    OpeningBlazeNameSprite *work = TaskGetWorkCurrent(OpeningBlazeNameSprite);

    work->backgroundPosition.x = -FLOAT_TO_FX32(32.0);
    work->backgroundPosition.y -= FLOAT_TO_FX32(0.2);

    if (work->letterTimer >= 120 && (work->flags & OPENING_NAME_SPRITE_FLAG_HIDE_LETTERS) == 0)
    {
        work->nameLetterID     = 0;
        work->subtitleLetterID = 0;
        work->flags |= OPENING_NAME_SPRITE_FLAG_HIDE_LETTERS;
    }

    if ((work->flags & OPENING_NAME_SPRITE_FLAG_HIDE_LETTERS) == 0)
    {
        if ((work->letterTimer % 4) == 0)
        {
            if ((work->aniLetters[work->nameLetterID].flags & ANIMATOR_FLAG_DISABLE_DRAW) != 0)
            {
                work->aniLetters[work->nameLetterID].flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
                work->aniLetters[work->nameLetterID].pos.y += 6;
            }

            if (work->nameLetterID < 5)
                work->nameLetterID++;

            if (work->nameLetterID >= 1)
            {
                for (s32 i = 0; i < 2; i++)
                {
                    if (work->subtitleLetterID < 6)
                    {
                        work->aniLetters[work->subtitleLetterID + 5].flags &= ~ANIMATOR_FLAG_DISABLE_DRAW;
                        work->subtitleLetterID++;
                    }
                }
            }
        }
        else
        {
            if (work->aniLetters[work->nameLetterID - 1].pos.y > blazeNameLetterPositions[work->nameLetterID - 1].y + 80)
                work->aniLetters[work->nameLetterID - 1].pos.y -= 2;
            else
                work->aniLetters[work->nameLetterID - 1].pos.y = blazeNameLetterPositions[work->nameLetterID - 1].y + 80;
        }
    }
    else
    {
        work->aniLetters[work->nameLetterID].flags |= ANIMATOR_FLAG_DISABLE_DRAW;

        if (work->nameLetterID < 5)
            work->nameLetterID++;

        if (work->nameLetterID >= 1)
        {
            for (s32 i = 0; i < 2; i++)
            {
                if (work->subtitleLetterID < 6)
                {
                    work->aniLetters[work->subtitleLetterID + 5].flags |= ANIMATOR_FLAG_DISABLE_DRAW;
                    work->subtitleLetterID++;
                }
                else
                {
                    work->flags |= OPENING_NAME_SPRITE_FLAG_IS_DONE;
                }
            }
        }
    }

    work->letterTimer++;
    for (s32 i = 0; i < 11; i++)
    {
        DrawOpeningSprite(&work->aniLetters[i]);
    }

    SetOpeningBackgroundPos(BACKGROUND_3, work->backgroundPosition.x, work->backgroundPosition.y);

    if ((work->flags & OPENING_NAME_SPRITE_FLAG_IS_DONE) != 0)
    {
        work->letterTimer = 0;
        work->exitTimer   = 5;
        SetCurrentTaskMainEvent(OpeningBlazeNameSprite_Main_BeginExitSprite);
    }
}

void OpeningBlazeNameSprite_Main_BeginExitSprite(void)
{
    OpeningBlazeNameSprite *work = TaskGetWorkCurrent(OpeningBlazeNameSprite);

    work->backgroundPosition.x = -FLOAT_TO_FX32(32.0);
    work->backgroundPosition.y += FLOAT_TO_FX32(2.0);
    SetOpeningBackgroundPos(BACKGROUND_3, work->backgroundPosition.x, work->backgroundPosition.y);

    if (work->exitTimer != 0)
        work->exitTimer--;
    else
        SetCurrentTaskMainEvent(OpeningBlazeNameSprite_Main_ExitSprite);
}

void OpeningBlazeNameSprite_Main_ExitSprite(void)
{
    OpeningBlazeNameSprite *work = TaskGetWorkCurrent(OpeningBlazeNameSprite);

    work->backgroundPosition.x = -FLOAT_TO_FX32(32.0);
    work->backgroundPosition.y -= FLOAT_TO_FX32(32.0);
    SetOpeningBackgroundPos(BACKGROUND_3, work->backgroundPosition.x, work->backgroundPosition.y);

    if (work->backgroundPosition.y < -464)
        work->parent->flags |= OPENING_FLAG_CHARACTER_CUTIN_DONE;
}