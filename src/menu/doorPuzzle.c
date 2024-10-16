#include <menu/doorPuzzle.h>
#include <game/input/padInput.h>
#include <game/input/touchInput.h>
#include <game/graphics/drawState.h>
#include <game/file/fileUnknown.h>
#include <game/file/binaryBundle.h>
#include <game/file/fsRequest.h>
#include <game/audio/sysSound.h>
#include <game/system/sysEvent.h>
#include <game/math/mtMath.h>
#include <game/save/saveGame.h>
#include <game/util/spriteButton.h>
#include <game/graphics/drawFadeTask.h>

// resources
#include <resources/narc/dmpz_lz7.h>
#include <resources/narc/tkdm_lz7.h>
#include <resources/bb/tkdm_cutin.h>

// --------------------
// CONSTANTS
// --------------------

#define DOORPUZZLE_REMINDER_INTERVAL   SECONDS_TO_FRAMES(20.0)
#define DOORPUZZLE_REMINDER_START_TIME (DOORPUZZLE_REMINDER_INTERVAL / 2)

// --------------------
// ENUMS
// --------------------

enum DoorPuzzleFlags
{
    DOORPUZZLE_FLAG_NONE = 0x00,

    DOORPUZZLE_FLAG_START_FADE_OUT    = 1 << 0,
    DOORPUZZLE_FLAG_ALL_KEYS_IN_PLACE = 1 << 1,
    DOORPUZZLE_FLAG_TOUCHPAD_READY    = 1 << 2,
    DOORPUZZLE_FLAG_BACK_PRESSED      = 1 << 3,
};

enum DoorPuzzleDialogueFlags
{
    DOORPUZZLEDIALOGUE_FLAG_NONE = 0x00,

    DOORPUZZLEDIALOGUE_FLAG_SHOW_NEXT_PROMPT    = 1 << 0,
    DOORPUZZLEDIALOGUE_FLAG_NEXT_PROMPT_ENABLED = 1 << 1,
    DOORPUZZLEDIALOGUE_FLAG_SHOW_CUTIN          = 1 << 2,
};

enum DoorPuzzleKeysFlags
{
    DOORPUZZLEKEYS_FLAG_NONE = 0x00,

    DOORPUZZLEKEYS_FLAG_IS_READY = 1 << 0,
};

enum DoorPuzzleKeyFlags
{
    DOORPUZZLEKEY_FLAG_NONE = 0x00,

    DOORPUZZLEKEY_FLAG_IS_IN_PLACE      = 1 << 0,
    DOORPUZZLEKEY_FLAG_WILL_BE_IN_PLACE = 1 << 1,
};

enum DoorPuzzlePortraitCharacterID
{
    DOORPUZZLE_PORTRAIT_CHAR_TAILS,
    DOORPUZZLE_PORTRAIT_CHAR_SONIC,
    DOORPUZZLE_PORTRAIT_CHAR_BLAZE,
    DOORPUZZLE_PORTRAIT_CHAR_MARINE,

    DOORPUZZLE_PORTRAIT_CHAR_COUNT,
};

enum DoorPuzzlePortraitID
{
    DOORPUZZLE_PORTRAIT_TAILS_TALK,
    DOORPUZZLE_PORTRAIT_TAILS_AFFIRM,
    DOORPUZZLE_PORTRAIT_SONIC_TALK,
    DOORPUZZLE_PORTRAIT_SONIC_THINK,
    DOORPUZZLE_PORTRAIT_BLAZE_TALK,
    DOORPUZZLE_PORTRAIT_MARINE_TALK,

    DOORPUZZLE_PORTRAIT_COUNT,
};

enum DoorPuzzleMsgSequence
{
    DOORPUZZLE_MSGSEQ_WE_FOUND_IT,
    DOORPUZZLE_MSGSEQ_SO_THIS_LEADS_TO_HIDEOUT,
    DOORPUZZLE_MSGSEQ_AMAZING_TO_THINK_IT_IS_UNDERWATER,
    DOORPUZZLE_MSGSEQ_HOW_DO_WE_GET_IT_OPEN,
    DOORPUZZLE_MSGSEQ_I_SAY_WE_BLAST_THE_BUGGER,
    DOORPUZZLE_MSGSEQ_THERE_MUST_BE_A_SWITCH,
    DOORPUZZLE_MSGSEQ_LOOKS_LIKE_THERES_SOMETHING_IN_THE_MIDDLE,
    DOORPUZZLE_MSGSEQ_WE_STILL_HAVENT_GATHERED_THE_HINTS,
    DOORPUZZLE_MSGSEQ_CHECK_HINTS_AND_USE_STYLUS,
    DOORPUZZLE_MSGSEQ_PRESS_B_TO_RETURN,
    DOORPUZZLE_MSGSEQ_THATS_IT_YOUVE_GOT_IT,
    DOORPUZZLE_MSGSEQ_HEY_SONIC_CHECK_HINTS_AND_USE_STYLUS,
    DOORPUZZLE_MSGSEQ_LETS_GO_BACK_TO_SOUTHERN_ISLAND,
};

enum DoorPuzzleNavLines
{
    DOORPUZZLE_NAVLINE_EXPLAIN_MECHANICS,
    DOORPUZZLE_NAVLINE_EXPLAIN_RETURN,
    DOORPUZZLE_NAVLINE_KEY_IN_PLACE,
    DOORPUZZLE_NAVLINE_REMIND_MECHANICS,
    DOORPUZZLE_NAVLINE_REMIND_RETURN,
    DOORPUZZLE_NAVLINE_DID_CANCEL,
};

enum DoorPuzzleModes
{
    DOORPUZZLE_MODE_INACTIVE,
    DOORPUZZLE_MODE_TRY_BECOME_IDLE,
    DOORPUZZLE_MODE_KEY_IN_PLACE,
    DOORPUZZLE_MODE_UNKNOWN,
    DOORPUZZLE_MODE_IDLE,
};

enum DoorPuzzleDialogueModes
{
    DOORPUZZLEDIALOGUE_MODE_IDLE,
    DOORPUZZLEDIALOGUE_MODE_CAN_ADVANCE,
    DOORPUZZLEDIALOGUE_MODE_ADVANCE_DIALOG,
    DOORPUZZLEDIALOGUE_MODE_CLOSE_WINDOW,
};

// --------------------
// STRUCTS
// --------------------

typedef struct DoorPuzzleDialoguePortraitConfig_
{
    u16 portraitID;
    u16 animID;
} DoorPuzzleDialoguePortraitConfig;

typedef struct DoorPuzzleDialogueEventConfig_
{
    u16 msgSeqStart;
    u16 msgSeqEnd;
} DoorPuzzleDialogueEventConfig;

// --------------------
// VARIABLES
// --------------------

static u16 stoneKeyAnimTable[DOORPUZZLE_STONE_KEY_COUNT] = { [0] = 0, [1] = 1, [2] = 2 };

static u16 cutInAnimTable[DOORPUZZLE_STONE_KEY_COUNT] = { [0] = 26, [1] = 27, [2] = 28 };

static u16 stoneKeyAngleTable[DOORPUZZLE_STONE_KEY_COUNT] = { [0] = FLOAT_DEG_TO_IDX(90.0), [1] = FLOAT_DEG_TO_IDX(270.0), [2] = FLOAT_DEG_TO_IDX(180.0) };

static u16 portraitFileTable[DOORPUZZLE_PORTRAIT_CHAR_COUNT] = { [DOORPUZZLE_PORTRAIT_CHAR_TAILS]  = ARCHIVE_DMPZ_LZ7_FILE_FACE_TIL_BAC,
                                                                 [DOORPUZZLE_PORTRAIT_CHAR_SONIC]  = ARCHIVE_DMPZ_LZ7_FILE_FACE_SON_BAC,
                                                                 [DOORPUZZLE_PORTRAIT_CHAR_BLAZE]  = ARCHIVE_DMPZ_LZ7_FILE_FACE_BLZ_BAC,
                                                                 [DOORPUZZLE_PORTRAIT_CHAR_MARINE] = ARCHIVE_DMPZ_LZ7_FILE_FACE_MRN_BAC };

static Vec2Fx16 cutInPosTable[DOORPUZZLE_STONE_KEY_COUNT] = {
    [0] = { 48, 64 },
    [1] = { 128, 64 },
    [2] = { 208, 64 },
};

static u16 navigatorDialogueTable[6] = { [DOORPUZZLE_NAVLINE_EXPLAIN_MECHANICS] = DOORPUZZLE_MSGSEQ_CHECK_HINTS_AND_USE_STYLUS,
                                         [DOORPUZZLE_NAVLINE_EXPLAIN_RETURN]    = DOORPUZZLE_MSGSEQ_PRESS_B_TO_RETURN,
                                         [DOORPUZZLE_NAVLINE_KEY_IN_PLACE]      = DOORPUZZLE_MSGSEQ_THATS_IT_YOUVE_GOT_IT,
                                         [DOORPUZZLE_NAVLINE_REMIND_MECHANICS]  = DOORPUZZLE_MSGSEQ_HEY_SONIC_CHECK_HINTS_AND_USE_STYLUS,
                                         [DOORPUZZLE_NAVLINE_REMIND_RETURN]     = DOORPUZZLE_MSGSEQ_PRESS_B_TO_RETURN,
                                         [DOORPUZZLE_NAVLINE_DID_CANCEL]        = DOORPUZZLE_MSGSEQ_LETS_GO_BACK_TO_SOUTHERN_ISLAND };

static DoorPuzzleDialogueEventConfig eventDialogueConfig[DOORPUZZLE_EVENT_COUNT] = {
    [DOORPUZZLE_EVENT_DISCOVERY] = { .msgSeqStart = DOORPUZZLE_MSGSEQ_WE_FOUND_IT, .msgSeqEnd = DOORPUZZLE_MSGSEQ_LOOKS_LIKE_THERES_SOMETHING_IN_THE_MIDDLE },
    [DOORPUZZLE_EVENT_NO_ACCESS] = { .msgSeqStart = DOORPUZZLE_MSGSEQ_WE_STILL_HAVENT_GATHERED_THE_HINTS, .msgSeqEnd = DOORPUZZLE_MSGSEQ_WE_STILL_HAVENT_GATHERED_THE_HINTS },
    [DOORPUZZLE_EVENT_HAVE_KEYS] = { .msgSeqStart = DOORPUZZLE_MSGSEQ_CHECK_HINTS_AND_USE_STYLUS, .msgSeqEnd = DOORPUZZLE_MSGSEQ_LETS_GO_BACK_TO_SOUTHERN_ISLAND },
};

static Vec2Fx16 stoneKeyPosTable[DOORPUZZLE_STONE_KEY_COUNT] = {
    [0] = { 128, 58 },
    [1] = { 86, 133 },
    [2] = { 170, 133 },
};

static DoorPuzzleDialoguePortraitConfig characterPortraitConfig[DOORPUZZLE_PORTRAIT_COUNT] = {
    [DOORPUZZLE_PORTRAIT_TAILS_TALK]   = { .portraitID = DOORPUZZLE_PORTRAIT_CHAR_TAILS, .animID = 0 },
    [DOORPUZZLE_PORTRAIT_TAILS_AFFIRM] = { .portraitID = DOORPUZZLE_PORTRAIT_CHAR_TAILS, .animID = 1 },
    [DOORPUZZLE_PORTRAIT_SONIC_TALK]   = { .portraitID = DOORPUZZLE_PORTRAIT_CHAR_SONIC, .animID = 0 },
    [DOORPUZZLE_PORTRAIT_SONIC_THINK]  = { .portraitID = DOORPUZZLE_PORTRAIT_CHAR_SONIC, .animID = 1 },
    [DOORPUZZLE_PORTRAIT_BLAZE_TALK]   = { .portraitID = DOORPUZZLE_PORTRAIT_CHAR_BLAZE, .animID = 0 },
    [DOORPUZZLE_PORTRAIT_MARINE_TALK]  = { .portraitID = DOORPUZZLE_PORTRAIT_CHAR_MARINE, .animID = 0 },
};

// --------------------
// FUNCTION DECLS
// --------------------

static void CreateDoorPuzzle(DoorPuzzleEvent event);
static void ClearDoorPuzzleTasks(void);
static void SetupDisplayForDoorPuzzle(void);
static void InitDoorPuzzleAssets(DoorPuzzle *work);
static void ReleaseDoorPuzzleAssets(DoorPuzzle *work);
static void InitDoorPuzzleBackgrounds(DoorPuzzle *work);
static void InitDoorPuzzleGraphics(DoorPuzzleGraphics *work);
static void ReleaseDoorPuzzleGraphics(DoorPuzzleGraphics *work);
static void StartDoorPuzzleFadeOut(DoorPuzzle *work, s32 delay);
static void ChangeEventForDoorPuzzle(DoorPuzzle *work);

// DoorPuzzleBGPillarFlame
static void CreateDoorPuzzleBGPillarFlame(DoorPuzzle *parent);
static void DoorPuzzleBGPillarFlame_Destructor(Task *task);
static void DoorPuzzleBGPillarFlame_Main_Init(void);
static void DoorPuzzleBGPillarFlame_Main_Active(void);

// DoorPuzzleDialogue
static void DoorPuzzleDialogue_Create(DoorPuzzle *parent);
static void DoorPuzzleDialogue_Destructor(Task *task);
static void DoorPuzzleDialogue_Main_Init(void);
static void DoorPuzzleDialogue_Main_Active(void);
static void InitDoorPuzzleEventDialogue(DoorPuzzleDialogue *work);
static BOOL AdvanceDoorPuzzleDialogueMsgSequence(DoorPuzzleDialogue *work);
static void SetDoorPuzzleDialogueNavMessage(DoorPuzzleDialogue *work, s32 id);

// Draw State
static void DoorPuzzleDialogue_StateDraw_InitOpenWindow(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_StateDraw_OpenWindow(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_StateDraw_InitDrawWindow(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_StateDraw_DialogueActive(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_StateDraw_DialogueIdle(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_StateDraw_InitCloseWindow(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_StateDraw_CloseWindow(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_StateDraw_ReleaseWindow(DoorPuzzleDialogue *work);

// State
static void DoorPuzzleDialogue_State_InitCutscene(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_State_ProcessCutscene(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_State_InitNavigator(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_State_AwaitTouchPress(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_State_PuzzleActive(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_State_PuzzleCancelled(DoorPuzzleDialogue *work);
static void DoorPuzzleDialogue_State_PuzzleSuccess(DoorPuzzleDialogue *work);

// Text Helpers
static void DoorPuzzleDialogue_FontCallback(u32 type, FontAnimator *animator, void *context);
static void DrawDoorPuzzleDialogueCharacterPortrait(DoorPuzzleDialogue *work);
static void DrawDoorPuzzleDialogueCutIn(DoorPuzzleDialogue *work);
static void DrawDoorPuzzleDialogueNextPrompt(DoorPuzzleDialogue *work);
static void EnableDoorPuzzleDialogueNextPrompt(DoorPuzzleDialogue *work);
static void DisableDoorPuzzleDialogueNextPrompt(DoorPuzzleDialogue *work);
static void InitDoorPuzzleDialogueText(DoorPuzzleDialogue *work);
static void ReleaseDoorPuzzleDialogueText(DoorPuzzleDialogue *work);
static void OpenDoorPuzzleDialogueWindow(DoorPuzzleDialogue *work);
static BOOL ProcessDoorPuzzleDialogueWindowOpen(DoorPuzzleDialogue *work);
static BOOL ProcessDoorPuzzleDialogueWindowClose(DoorPuzzleDialogue *work);
static void SetDoorPuzzleDialogueWindowOpen(DoorPuzzleDialogue *work);
static void CloseDoorPuzzleDialogueWindow(DoorPuzzleDialogue *work);
static void DrawDoorPuzzleDialogueWindowAll(DoorPuzzleDialogue *work);
static void DrawDoorPuzzleDialogueWindowOnly(DoorPuzzleDialogue *work);
static void AdvanceDoorPuzzleDialogue(DoorPuzzleDialogue *work);

// DoorPuzzleKeySys
static void CreateDoorPuzzleKeySys(DoorPuzzle *parent);
static void DoorPuzzleKeySys_Destructor(Task *task);
static void DoorPuzzleKeySys_Main_InitKeys(void);
static void DoorPuzzleKeySys_Main_ProcessKeys(void);
static BOOL DoorPuzzleKeySys_CheckKeysInPlace(DoorPuzzleKeySys *work);
static void DoorPuzzleKeySys_InitKey(DoorPuzzleKeySys *work, s32 id, s16 x, s16 y);
static void DoorPuzzleKeySys_DrawKey(DoorPuzzleKey *work);
static void DoorPuzzleKeySys_StartTouchInput(DoorPuzzleKeySys *work);
static void DoorPuzzleKeySys_StopTouchInput(DoorPuzzleKeySys *work);
static void DoorPuzzleKeySys_ProcessKey(DoorPuzzleKey *work);
static void DoorPuzzleKeySys_KeyStateDraw_Init(DoorPuzzleKey *work);
static void DoorPuzzleKeySys_KeyStateDraw_Main(DoorPuzzleKey *work);
static void DoorPuzzleKeySys_KeyState_Init(DoorPuzzleKey *work);
static void DoorPuzzleKeySys_KeyState_Active(DoorPuzzleKey *work);

// DoorPuzzleTouchPrompt
static void CreateDoorPuzzleTouchPrompt(DoorPuzzleKeySys *parent);
static void DoorPuzzleTouchPrompt_Destructor(Task *task);
static void DoorPuzzleTouchPrompt_Main_Init(void);
static void DoorPuzzleTouchPrompt_Main_AwaitSignal(void);
static void DoorPuzzleTouchPrompt_Main_Active(void);
static void DoorPuzzleTouchPrompt_Main_FadeOut(void);
static void SetupDisplayForDoorPuzzleTouchPrompt(DoorPuzzleTouchPrompt *work);
static void ResetDisplayFromDoorPuzzleTouchPrompt(DoorPuzzleTouchPrompt *work);
static BOOL HandleDoorPuzzleTouchPromptAlpha(DoorPuzzleTouchPrompt *work, fx32 changeSpeed, s32 targetAlpha);

// DoorPuzzleCompleteActivateEffect
static void CreateDoorPuzzleCompleteActivateEffect(DoorPuzzleKeySys *parent);
static void DoorPuzzleCompleteActivateEffect_Destructor(Task *task);
static void DoorPuzzleCompleteActivateEffect_Main_Init(void);
static void DoorPuzzleCompleteActivateEffect_Main_Animate(void);

// DoorPuzzle
static void DoorPuzzle_Main_Init(void);
static void DoorPuzzle_Destructor(Task *task);
static void DoorPuzzle_Main_FadeIn(void);
static void DoorPuzzle_Main_CreateDialogue(void);
static void DoorPuzzle_Main_Active(void);
static void DoorPuzzle_Main_InitFadeOut(void);
static void DoorPuzzle_Main_FadeOut(void);

// --------------------
// FUNCTIONS
// --------------------

void InitDoorPuzzle(void)
{
    CreateDoorPuzzle(gameState.doorPuzzleEvent);
}

void CreateDoorPuzzle(DoorPuzzleEvent event)
{
    SetupDisplayForDoorPuzzle();

    Task *task = TaskCreate(DoorPuzzle_Main_Init, DoorPuzzle_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_SCOPE_0, DoorPuzzle);

    DoorPuzzle *work = TaskGetWork(task, DoorPuzzle);
    TaskInitWork16(work);

    work->eventID = event;

    InitDoorPuzzleAssets(work);
    InitDoorPuzzleBackgrounds(work);
    CreateDoorPuzzleBGPillarFlame(work);

    LoadSysSound(SYSSOUND_GROUP_MYSTERY);
}

void ClearDoorPuzzleTasks(void)
{
    ClearTaskScope(TASK_SCOPE_2);
    ClearTaskScope(TASK_SCOPE_1);
    ClearTaskScope(TASK_SCOPE_0);
}

void SetupDisplayForDoorPuzzle(void)
{
    VRAMSystem__Init(VRAM_MODE_0);

    GX_SetPower(GX_POWER_2D);

    GX_SetDispSelect(GX_DISP_SELECT_MAIN_SUB);
    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    renderCoreGFXControlA.windowManager.visible            = GX_PLANEMASK_NONE;
    renderCoreGFXControlA.blendManager.blendControl.effect = BLENDTYPE_NONE;
    renderCoreGFXControlA.brightness                       = RENDERCORE_BRIGHTNESS_BLACK;
    renderCoreGFXControlA.mosaicSize                       = 0;
    GX_SetMasterBrightness(renderCoreGFXControlA.brightness);

    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);
    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);

    G2_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x10000, GX_BG_EXTPLTT_01);
    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x14000);

    renderCoreGFXControlA.bgPosition[BACKGROUND_0].x = renderCoreGFXControlA.bgPosition[BACKGROUND_0].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].x = renderCoreGFXControlA.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].x = renderCoreGFXControlA.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 0;

    G2_SetBG0Priority(3);
    G2_SetBG1Priority(2);
    G2_SetBG2Priority(1);
    G2_SetBG3Priority(0);
    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1 | GX_PLANEMASK_BG2 | GX_PLANEMASK_OBJ);

    MI_CpuClear16(VRAMSystem__VRAM_BG[0], 0x20000);

    renderCoreGFXControlB.windowManager.visible            = GX_PLANEMASK_NONE;
    renderCoreGFXControlB.blendManager.blendControl.effect = BLENDTYPE_NONE;
    renderCoreGFXControlB.brightness                       = RENDERCORE_BRIGHTNESS_BLACK;
    renderCoreGFXControlB.mosaicSize                       = 0;
    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness);

    GXS_SetGraphicsMode(GX_BGMODE_0);
    G2S_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x10000, GX_BG_EXTPLTT_01);

    renderCoreGFXControlB.bgPosition[BACKGROUND_0].x = renderCoreGFXControlB.bgPosition[BACKGROUND_0].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_1].x = renderCoreGFXControlB.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_2].x = renderCoreGFXControlB.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlB.bgPosition[BACKGROUND_3].x = renderCoreGFXControlB.bgPosition[BACKGROUND_3].y = 0;

    G2S_SetBG0Priority(3);
    G2S_SetBG1Priority(2);
    G2S_SetBG2Priority(1);
    G2S_SetBG3Priority(0);
    GXS_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_OBJ);

    MI_CpuClear16(VRAMSystem__VRAM_BG[1], 0x20000);
}

void InitDoorPuzzleAssets(DoorPuzzle *work)
{
    FSRequestArchive("/narc/dmpz_lz7.narc", &work->archiveDoorPuzzle, FALSE);
    FSRequestArchive("/narc/tkdm_lz7.narc", &work->archiveCutscene, FALSE);
}

void ReleaseDoorPuzzleAssets(DoorPuzzle *work)
{
    HeapFree(HEAP_USER, work->archiveDoorPuzzle);
    HeapFree(HEAP_USER, work->archiveCutscene);
}

void InitDoorPuzzleBackgrounds(DoorPuzzle *work)
{
    InitBackground(&work->bgScreen, FileUnknown__GetAOUFile(work->archiveDoorPuzzle, ARCHIVE_DMPZ_LZ7_FILE_SCREEN_BBG), BACKGROUND_FLAG_LOAD_ALL, FALSE, BACKGROUND_0,
                   BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&work->bgScreen);

    InitBackground(&work->bgBase, FileUnknown__GetAOUFile(work->archiveDoorPuzzle, ARCHIVE_DMPZ_LZ7_FILE_BASE_BBG), BACKGROUND_FLAG_LOAD_ALL, TRUE, BACKGROUND_0,
                   BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&work->bgBase);
}

void InitDoorPuzzleGraphics(DoorPuzzleGraphics *work)
{
    work->pixels   = HeapAllocTail(HEAP_USER, 32);
    work->mappings = HeapAllocTail(HEAP_USER, BG_DISPLAY_SINGLE_TILE_SIZE * sizeof(GXScrFmtText));
    work->palette  = HeapAllocTail(HEAP_USER, 16 * sizeof(GXRgb));

    MI_CpuFill16(work->pixels, 0x1111, 32);
    MI_CpuFill16(work->mappings, 0, BG_DISPLAY_SINGLE_TILE_SIZE * sizeof(GXScrFmtText));
    MI_CpuFill16(work->palette, GX_RGB_888(0x00, 0x00, 0x00), 16 * sizeof(GXRgb));

    LoadUncompressedPixels(work->pixels, 32, PIXEL_MODE_SPRITE, VRAMKEY_TO_ADDR(HW_DB_BG_VRAM + 0x10000));
    Mappings__LoadUnknown(work->mappings, 0, 0, BG_DISPLAY_FULL_WIDTH, TRUE, MAPPINGS_MODE_TEXT_256x256_B, 0, 1, 0, 0, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT_EX);
    LoadUncompressedPalette(work->palette, 16, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(VRAM_DB_BG_PLTT));
}

void ReleaseDoorPuzzleGraphics(DoorPuzzleGraphics *work)
{
    HeapFree(HEAP_USER, work->pixels);
    HeapFree(HEAP_USER, work->mappings);
    HeapFree(HEAP_USER, work->palette);
}

void StartDoorPuzzleFadeOut(DoorPuzzle *work, s32 delay)
{
    work->flags |= DOORPUZZLE_FLAG_START_FADE_OUT;
    work->fadeOutDelay = delay;
}

void ChangeEventForDoorPuzzle(DoorPuzzle *work)
{
    if ((work->flags & DOORPUZZLE_FLAG_ALL_KEYS_IN_PLACE) != 0)
        SaveGame__Func_205B9F0(10);
    else
        SaveGame__Func_205B9F0(0);

    RequestSysEventChange(0); // SYSEVENT_UPDATE_PROGRESS
    NextSysEvent();
}

// DoorPuzzleBGPillarFlame
void CreateDoorPuzzleBGPillarFlame(DoorPuzzle *parent)
{
    Task *task = TaskCreate(DoorPuzzleBGPillarFlame_Main_Init, DoorPuzzleBGPillarFlame_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000, TASK_SCOPE_2,
                            DoorPuzzleBGPillarFlame);

    DoorPuzzleBGPillarFlame *work = TaskGetWork(task, DoorPuzzleBGPillarFlame);
    TaskInitWork16(work);

    void *sprFire = FileUnknown__GetAOUFile(parent->archiveDoorPuzzle, ARCHIVE_DMPZ_LZ7_FILE_FIRE_BAC);
    AnimatorSprite__Init(&work->aniFire1, sprFire, 0, ANIMATOR_FLAG_DISABLE_LOOPING, FALSE, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize3(sprFire)),
                         PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_2);
    work->aniFire1.palette = PALETTE_ROW_1;
    work->aniFire1.pos.x   = 24;
    work->aniFire1.pos.y   = 16;

    sprFire = FileUnknown__GetAOUFile(parent->archiveDoorPuzzle, ARCHIVE_DMPZ_LZ7_FILE_FIRE_BAC);
    AnimatorSprite__Init(&work->aniFire2, sprFire, 1, ANIMATOR_FLAG_DISABLE_LOOPING, FALSE, PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize3(sprFire)),
                         PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_2);
    work->aniFire2.palette = PALETTE_ROW_2;
    work->aniFire2.pos.x   = 200;
    work->aniFire2.pos.y   = 16;
}

void DoorPuzzleBGPillarFlame_Destructor(Task *task)
{
    DoorPuzzleBGPillarFlame *work = TaskGetWork(task, DoorPuzzleBGPillarFlame);

    AnimatorSprite__Release(&work->aniFire1);
    AnimatorSprite__Release(&work->aniFire2);
}

void DoorPuzzleBGPillarFlame_Main_Init(void)
{
    SetCurrentTaskMainEvent(DoorPuzzleBGPillarFlame_Main_Active);
}

void DoorPuzzleBGPillarFlame_Main_Active(void)
{
    DoorPuzzleBGPillarFlame *work = TaskGetWorkCurrent(DoorPuzzleBGPillarFlame);

    AnimatorSprite__ProcessAnimationFast(&work->aniFire1);
    AnimatorSprite__ProcessAnimationFast(&work->aniFire2);

    AnimatorSprite__DrawFrame(&work->aniFire1);
    AnimatorSprite__DrawFrame(&work->aniFire2);
}

// DoorPuzzleDialogue
void DoorPuzzleDialogue_Create(DoorPuzzle *parent)
{
    s32 i;

    Task *task = TaskCreate(DoorPuzzleDialogue_Main_Init, (TaskDestructor)DoorPuzzleDialogue_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000, TASK_SCOPE_1,
                            DoorPuzzleDialogue);

    DoorPuzzleDialogue *work = TaskGetWork(task, DoorPuzzleDialogue);
    TaskInitWork16(work);

    work->parent = parent;

    parent->fntAll = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);

    i = 0;
    for (; i < DOORPUZZLE_PORTRAIT_CHAR_COUNT; i++)
    {
        void *sprPortrait = FileUnknown__GetAOUFile(parent->archiveDoorPuzzle, portraitFileTable[i]);

        AnimatorSprite__Init(&work->aniCharPortrait[i], sprPortrait, 0, ANIMATOR_FLAG_DISABLE_LOOPING, FALSE, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize3(sprPortrait)), PALETTE_MODE_OBJ, NULL, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        work->aniCharPortrait[i].pos.x = 48;
        work->aniCharPortrait[i].pos.y = -70;
    }

    GetCompressedFileFromBundle("/bb/tkdm_cutin.bb", BUNDLE_TKDM_CUTIN_FILE_RESOURCES_BB_TKDM_CUTIN_CUTIN_BAC, &parent->sprCutin, FALSE);

    s32 c = 0;
    for (; c < DOORPUZZLE_STONE_KEY_COUNT; c++)
    {
        AnimatorSprite__Init(&work->aniCutInIcon[c], parent->sprCutin, cutInAnimTable[c], ANIMATOR_FLAG_DISABLE_LOOPING, FALSE, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize3(parent->sprCutin)), PALETTE_MODE_OBJ, NULL, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
        work->aniCutInIcon[c].palette = c + PALETTE_ROW_1;
        work->aniCutInIcon[c].pos.x   = cutInPosTable[c].x;
        work->aniCutInIcon[c].pos.y   = cutInPosTable[c].y;
        AnimatorSprite__ProcessAnimationFast(&work->aniCutInIcon[c]);

        AnimatorSprite__Init(&work->aniCutInPanel[c], parent->sprCutin, 0, ANIMATOR_FLAG_DISABLE_LOOPING, FALSE, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize3(parent->sprCutin)), PALETTE_MODE_OBJ, NULL, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
        work->aniCutInPanel[c].palette = PALETTE_ROW_4;
        work->aniCutInPanel[c].pos.x   = cutInPosTable[c].x;
        work->aniCutInPanel[c].pos.y   = cutInPosTable[c].y;
        AnimatorSprite__ProcessAnimationFast(&work->aniCutInPanel[c]);
    }

    void *sprNextPrompt = FileUnknown__GetAOUFile(parent->archiveCutscene, ARCHIVE_TKDM_LZ7_FILE_FIX_NEXT_BAC);
    AnimatorSprite__Init(&work->aniNextPrompt, sprNextPrompt, 0, ANIMATOR_FLAG_DISABLE_LOOPING, FALSE, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize3(sprNextPrompt)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_0);
    work->aniNextPrompt.palette = PALETTE_ROW_0;
    work->aniNextPrompt.pos.x   = 224;
    work->aniNextPrompt.pos.y   = 160;
}

void DoorPuzzleDialogue_Destructor(Task *task)
{
    DoorPuzzleDialogue *work = TaskGetWork(task, DoorPuzzleDialogue);

    ReleaseDoorPuzzleDialogueText(work);
    HeapFree(HEAP_USER, work->parent->fntAll);

    for (s32 c = 0; c < DOORPUZZLE_STONE_KEY_COUNT; c++)
    {
        AnimatorSprite__Release(&work->aniCutInIcon[c]);
        AnimatorSprite__Release(&work->aniCutInPanel[c]);
    }

    HeapFree(HEAP_USER, work->parent->sprCutin);

    for (s32 i = 0; i < DOORPUZZLE_PORTRAIT_CHAR_COUNT; i++)
    {
        AnimatorSprite__Release(&work->aniCharPortrait[i]);
    }

    AnimatorSprite__Release(&work->aniNextPrompt);
}

void DoorPuzzleDialogue_Main_Init(void)
{
    DoorPuzzleDialogue *work = TaskGetWorkCurrent(DoorPuzzleDialogue);

    if (work->parent->eventID == DOORPUZZLE_EVENT_HAVE_KEYS)
        work->state = DoorPuzzleDialogue_State_InitNavigator;
    else
        work->state = DoorPuzzleDialogue_State_InitCutscene;

    work->stateDraw = NULL;

    SetCurrentTaskMainEvent(DoorPuzzleDialogue_Main_Active);
}

void DoorPuzzleDialogue_Main_Active(void)
{
    DoorPuzzleDialogue *work = TaskGetWorkCurrent(DoorPuzzleDialogue);

    if (work->state != NULL)
        work->state(work);

    if (work->stateDraw != NULL)
        work->stateDraw(work);
}

void InitDoorPuzzleEventDialogue(DoorPuzzleDialogue *work)
{
    work->msgSequence = eventDialogueConfig[work->parent->eventID].msgSeqStart;
}

BOOL AdvanceDoorPuzzleDialogueMsgSequence(DoorPuzzleDialogue *work)
{
    work->msgSequence++;
    return work->msgSequence > eventDialogueConfig[work->parent->eventID].msgSeqEnd;
}

void SetDoorPuzzleDialogueNavMessage(DoorPuzzleDialogue *work, s32 id)
{
    work->msgSequence = navigatorDialogueTable[id];
}

void DoorPuzzleDialogue_StateDraw_InitOpenWindow(DoorPuzzleDialogue *work)
{
    InitDoorPuzzleDialogueText(work);
    OpenDoorPuzzleDialogueWindow(work);

    work->stateDraw = DoorPuzzleDialogue_StateDraw_OpenWindow;
    work->stateDraw(work);
}

void DoorPuzzleDialogue_StateDraw_OpenWindow(DoorPuzzleDialogue *work)
{
    if (ProcessDoorPuzzleDialogueWindowOpen(work))
    {
        SetDoorPuzzleDialogueWindowOpen(work);
        work->stateDraw = DoorPuzzleDialogue_StateDraw_InitDrawWindow;
    }
}

void DoorPuzzleDialogue_StateDraw_InitDrawWindow(DoorPuzzleDialogue *work)
{
    work->stateDraw = DoorPuzzleDialogue_StateDraw_DialogueActive;
    work->stateDraw(work);
}

void DoorPuzzleDialogue_StateDraw_DialogueActive(DoorPuzzleDialogue *work)
{
    DrawDoorPuzzleDialogueWindowAll(work);

    switch (work->dialogueMode)
    {
        case DOORPUZZLEDIALOGUE_MODE_CAN_ADVANCE:
            DrawDoorPuzzleDialogueWindowOnly(work);
            work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_IDLE;
            break;
    }

    if (FontAnimator__IsEndOfLine(&work->fontAnimator))
    {
        EnableDoorPuzzleDialogueNextPrompt(work);
        work->stateDraw = DoorPuzzleDialogue_StateDraw_DialogueIdle;
    }
}

void DoorPuzzleDialogue_StateDraw_DialogueIdle(DoorPuzzleDialogue *work)
{
    DrawDoorPuzzleDialogueWindowAll(work);

    switch (work->dialogueMode)
    {
        case DOORPUZZLEDIALOGUE_MODE_IDLE:
            break;

        case DOORPUZZLEDIALOGUE_MODE_ADVANCE_DIALOG:
            AdvanceDoorPuzzleDialogue(work);
            DisableDoorPuzzleDialogueNextPrompt(work);

            work->stateDraw    = DoorPuzzleDialogue_StateDraw_InitDrawWindow;
            work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_IDLE;
            break;

        case DOORPUZZLEDIALOGUE_MODE_CLOSE_WINDOW:
            work->stateDraw    = DoorPuzzleDialogue_StateDraw_InitCloseWindow;
            work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_IDLE;
            break;
    }
}

void DoorPuzzleDialogue_StateDraw_InitCloseWindow(DoorPuzzleDialogue *work)
{
    CloseDoorPuzzleDialogueWindow(work);

    work->stateDraw = DoorPuzzleDialogue_StateDraw_CloseWindow;
    work->stateDraw(work);
}

void DoorPuzzleDialogue_StateDraw_CloseWindow(DoorPuzzleDialogue *work)
{
    if (ProcessDoorPuzzleDialogueWindowClose(work))
    {
        work->stateDraw = DoorPuzzleDialogue_StateDraw_ReleaseWindow;
    }
}

void DoorPuzzleDialogue_StateDraw_ReleaseWindow(DoorPuzzleDialogue *work)
{
    SetDoorPuzzleDialogueWindowOpen(work);
    ReleaseDoorPuzzleDialogueText(work);

    work->stateDraw = NULL;
}

void DoorPuzzleDialogue_State_InitCutscene(DoorPuzzleDialogue *work)
{
    work->stateDraw = DoorPuzzleDialogue_StateDraw_InitOpenWindow;

    work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_IDLE;
    DisableDoorPuzzleDialogueNextPrompt(work);

    work->flags |= DOORPUZZLE_FLAG_START_FADE_OUT;
    InitDoorPuzzleEventDialogue(work);

    work->state = DoorPuzzleDialogue_State_ProcessCutscene;
}

void DoorPuzzleDialogue_State_ProcessCutscene(DoorPuzzleDialogue *work)
{
    if ((padInput.btnPress & (PAD_BUTTON_Y | PAD_BUTTON_X | PAD_BUTTON_A)) != 0)
    {
        if ((work->flags & DOORPUZZLE_FLAG_ALL_KEYS_IN_PLACE) != 0)
        {
            PlaySysSfx(SND_SYS_SEQARC_ARC_MYSTERY_SEQ_SE_P_BUTTON);
            if (FontAnimator__IsLastDialog(&work->fontAnimator))
            {
                if (AdvanceDoorPuzzleDialogueMsgSequence(work))
                {
                    work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_CLOSE_WINDOW;
                    work->state        = NULL;
                    StartDoorPuzzleFadeOut(work->parent, 60);
                }
                else
                {
                    work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_ADVANCE_DIALOG;
                }
            }
            else
            {
                work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_ADVANCE_DIALOG;
            }
        }
        else
        {
            work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_CAN_ADVANCE;
        }
    }
}

void DoorPuzzleDialogue_State_InitNavigator(DoorPuzzleDialogue *work)
{
    work->flags &= ~DOORPUZZLEDIALOGUE_FLAG_SHOW_NEXT_PROMPT;
    work->flags |= DOORPUZZLEDIALOGUE_FLAG_SHOW_CUTIN;

    work->stateDraw    = DoorPuzzleDialogue_StateDraw_InitOpenWindow;
    work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_IDLE;

    DisableDoorPuzzleDialogueNextPrompt(work);
    InitDoorPuzzleEventDialogue(work);

    work->timer        = DOORPUZZLE_REMINDER_START_TIME;
    work->parent->mode = DOORPUZZLE_MODE_IDLE;

    work->state = DoorPuzzleDialogue_State_AwaitTouchPress;
}

void DoorPuzzleDialogue_State_AwaitTouchPress(DoorPuzzleDialogue *work)
{
    if (IsTouchInputEnabled())
    {
        if (TOUCH_HAS_PUSH(touchInput.flags))
        {
            SetDoorPuzzleDialogueNavMessage(work, DOORPUZZLE_NAVLINE_EXPLAIN_RETURN);
            work->dialogueMode  = DOORPUZZLEDIALOGUE_MODE_ADVANCE_DIALOG;
            work->timer         = DOORPUZZLE_REMINDER_START_TIME;
            work->parent->mode  = DOORPUZZLE_MODE_IDLE;
            work->state         = DoorPuzzleDialogue_State_PuzzleActive;
            work->parent->timer = 0;
        }
    }
}

void DoorPuzzleDialogue_State_PuzzleActive(DoorPuzzleDialogue *work)
{
    if ((padInput.btnPress & PAD_BUTTON_B) != 0)
    {
        PlaySysSfx(SND_SYS_SEQARC_ARC_MYSTERY_SEQ_SE_M_CANCELL);
        work->parent->flags |= DOORPUZZLE_FLAG_BACK_PRESSED;
        SetDoorPuzzleDialogueNavMessage(work, DOORPUZZLE_NAVLINE_DID_CANCEL);
        work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_ADVANCE_DIALOG;
        work->timer        = 240;
        work->state        = DoorPuzzleDialogue_State_PuzzleCancelled;
    }
    else
    {
        if (work->parent->mode == DOORPUZZLE_MODE_KEY_IN_PLACE)
        {
            SetDoorPuzzleDialogueNavMessage(work, DOORPUZZLE_NAVLINE_KEY_IN_PLACE);
            work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_ADVANCE_DIALOG;
            if ((work->parent->flags & DOORPUZZLE_FLAG_ALL_KEYS_IN_PLACE) != 0)
            {
                work->timer = 100;
                work->state = DoorPuzzleDialogue_State_PuzzleSuccess;
            }
            else
            {
                work->timer        = DOORPUZZLE_REMINDER_START_TIME;
                work->parent->mode = DOORPUZZLE_MODE_TRY_BECOME_IDLE;
            }
        }
        else
        {
            if (work->parent->timer >= DOORPUZZLE_REMINDER_INTERVAL)
            {
                SetDoorPuzzleDialogueNavMessage(work, DOORPUZZLE_NAVLINE_REMIND_MECHANICS);
                work->dialogueMode  = DOORPUZZLEDIALOGUE_MODE_ADVANCE_DIALOG;
                work->timer         = DOORPUZZLE_REMINDER_START_TIME;
                work->parent->timer = 0;
                work->parent->mode  = DOORPUZZLE_MODE_TRY_BECOME_IDLE;
            }
            else
            {
                if (work->timer != 0)
                {
                    work->timer--;
                }
                else if (work->parent->mode == DOORPUZZLE_MODE_TRY_BECOME_IDLE)
                {
                    SetDoorPuzzleDialogueNavMessage(work, DOORPUZZLE_NAVLINE_EXPLAIN_RETURN);
                    work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_ADVANCE_DIALOG;
                    work->timer        = DOORPUZZLE_REMINDER_START_TIME;
                    work->parent->mode = DOORPUZZLE_MODE_IDLE;
                }
            }
        }
    }
}

void DoorPuzzleDialogue_State_PuzzleCancelled(DoorPuzzleDialogue *work)
{
    if (work->timer != 0)
    {
        work->timer--;
    }
    else
    {
        work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_CLOSE_WINDOW;
        StartDoorPuzzleFadeOut(work->parent, 60);
        work->state = NULL;
    }
}

void DoorPuzzleDialogue_State_PuzzleSuccess(DoorPuzzleDialogue *work)
{
    if (work->timer != 0)
    {
        work->timer--;
    }
    else
    {
        work->dialogueMode = DOORPUZZLEDIALOGUE_MODE_CLOSE_WINDOW;
        StartDoorPuzzleFadeOut(work->parent, 60);
        work->state = NULL;
    }
}

void DoorPuzzleDialogue_FontCallback(u32 type, FontAnimator *animator, void *arg)
{
    DoorPuzzleDialogue *dialogue = (DoorPuzzleDialogue *)arg;

    switch (type)
    {
        case 10:
            dialogue->portraitID = DOORPUZZLE_PORTRAIT_TAILS_TALK;
            break;

        case 11:
            dialogue->portraitID = DOORPUZZLE_PORTRAIT_TAILS_AFFIRM;
            break;

        case 12:
            dialogue->portraitID = DOORPUZZLE_PORTRAIT_SONIC_TALK;
            break;

        case 13:
            dialogue->portraitID = DOORPUZZLE_PORTRAIT_SONIC_THINK;
            break;

        case 14:
            dialogue->portraitID = DOORPUZZLE_PORTRAIT_BLAZE_TALK;
            break;

        case 15:
            dialogue->portraitID = DOORPUZZLE_PORTRAIT_MARINE_TALK;
            break;
    }
}

void DrawDoorPuzzleDialogueCharacterPortrait(DoorPuzzleDialogue *work)
{
    u32 portraitID = characterPortraitConfig[work->portraitID].portraitID;

    AnimatorSprite__SetAnimation(&work->aniCharPortrait[portraitID], characterPortraitConfig[work->portraitID].animID);
    AnimatorSprite__ProcessAnimationFast(&work->aniCharPortrait[portraitID]);
    AnimatorSprite__DrawFrame(&work->aniCharPortrait[portraitID]);
}

void DrawDoorPuzzleDialogueCutIn(DoorPuzzleDialogue *work)
{
    if ((work->flags & DOORPUZZLEDIALOGUE_FLAG_SHOW_CUTIN) != 0)
    {
        for (s32 c = 0; c < DOORPUZZLE_STONE_KEY_COUNT; c++)
        {
            AnimatorSprite__ProcessAnimationFast(&work->aniCutInIcon[c]);
            AnimatorSprite__ProcessAnimationFast(&work->aniCutInPanel[c]);

            AnimatorSprite__DrawFrame(&work->aniCutInIcon[c]);
            AnimatorSprite__DrawFrame(&work->aniCutInPanel[c]);
        }
    }
}

void DrawDoorPuzzleDialogueNextPrompt(DoorPuzzleDialogue *work)
{
    if ((work->flags & DOORPUZZLEDIALOGUE_FLAG_SHOW_NEXT_PROMPT) != 0)
    {
        AnimatorSprite__ProcessAnimationFast(&work->aniNextPrompt);

        AnimatorSprite__DrawFrame(&work->aniNextPrompt);
    }
}

void EnableDoorPuzzleDialogueNextPrompt(DoorPuzzleDialogue *work)
{
    work->flags |= DOORPUZZLEDIALOGUE_FLAG_NEXT_PROMPT_ENABLED;

    AnimatorSprite__SetAnimation(&work->aniNextPrompt, 2);
}

void DisableDoorPuzzleDialogueNextPrompt(DoorPuzzleDialogue *work)
{
    work->flags &= ~DOORPUZZLEDIALOGUE_FLAG_NEXT_PROMPT_ENABLED;

    AnimatorSprite__SetAnimation(&work->aniNextPrompt, 0);
}

void InitDoorPuzzleDialogueText(DoorPuzzleDialogue *work)
{
    FontWindow__Init(&work->fontWindow);
    FontWindow__LoadFromMemory(&work->fontWindow, work->parent->fntAll, TRUE);
    FontWindowAnimator__Init(&work->fontWindowAnimator);
    FontWindowAnimator__Load1(&work->fontWindowAnimator, &work->fontWindow, 0, 0, 2, 0, 14, 32, 10, FALSE, BACKGROUND_1, 0, 1, 0);
    FontAnimator__Init(&work->fontAnimator);
    FontAnimator__LoadFont1(&work->fontAnimator, &work->fontWindow, 0, 11, 15, 21, 8, FALSE, BACKGROUND_2, 1, 1);

    FontAnimator__LoadMPCFile(&work->fontAnimator, FileUnknown__GetAOUFile(work->parent->archiveDoorPuzzle, GetGameLanguage() + ARCHIVE_DMPZ_LZ7_FILE_MSG_JPN_MPC));
    FontAnimator__SetCallback(&work->fontAnimator, DoorPuzzleDialogue_FontCallback, work);
    FontAnimator__SetMsgSequence(&work->fontAnimator, work->msgSequence);
    FontAnimator__SetDialog(&work->fontAnimator, 0);
    FontAnimator__LoadMappingsFunc(&work->fontAnimator);
    FontAnimator__LoadPaletteFunc(&work->fontAnimator);
}

void ReleaseDoorPuzzleDialogueText(DoorPuzzleDialogue *work)
{
    FontAnimator__Release(&work->fontAnimator);
    FontWindowAnimator__Release(&work->fontWindowAnimator);
    FontWindow__Release(&work->fontWindow);
}

void OpenDoorPuzzleDialogueWindow(DoorPuzzleDialogue *work)
{
    FontWindowAnimator__InitAnimation(&work->fontWindowAnimator, 2, 15, 10, 0);
    FontWindowAnimator__StartAnimating(&work->fontWindowAnimator);
}

BOOL ProcessDoorPuzzleDialogueWindowOpen(DoorPuzzleDialogue *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);
    return FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator) != 0;
}

BOOL ProcessDoorPuzzleDialogueWindowClose(DoorPuzzleDialogue *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimator);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);
    if (!FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimator))
        return FALSE;

    FontWindowAnimator__SetWindowClosed(&work->fontWindowAnimator);
    return TRUE;
}

void SetDoorPuzzleDialogueWindowOpen(DoorPuzzleDialogue *work)
{
    FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimator);
}

void CloseDoorPuzzleDialogueWindow(DoorPuzzleDialogue *work)
{
    FontAnimator__ClearPixels(&work->fontAnimator);
    FontAnimator__Draw(&work->fontAnimator);

    FontWindowAnimator__InitAnimation(&work->fontWindowAnimator, 5, 15, 10, 0);
    FontWindowAnimator__StartAnimating(&work->fontWindowAnimator);
}

void DrawDoorPuzzleDialogueWindowAll(DoorPuzzleDialogue *work)
{
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontAnimator__LoadCharacters(&work->fontAnimator, 1);
    FontAnimator__Draw(&work->fontAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    DrawDoorPuzzleDialogueCharacterPortrait(work);
    DrawDoorPuzzleDialogueCutIn(work);
    DrawDoorPuzzleDialogueNextPrompt(work);
}

void DrawDoorPuzzleDialogueWindowOnly(DoorPuzzleDialogue *work)
{
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontAnimator__LoadCharacters(&work->fontAnimator, 0);

    FontAnimator__Draw(&work->fontAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);
}

void AdvanceDoorPuzzleDialogue(DoorPuzzleDialogue *work)
{
    if (FontAnimator__IsLastDialog(&work->fontAnimator))
    {
        FontAnimator__SetMsgSequence(&work->fontAnimator, work->msgSequence);
        FontAnimator__SetDialog(&work->fontAnimator, 0);
    }
    else if (FontAnimator__IsEndOfLine(&work->fontAnimator))
    {
        FontAnimator__SetDialog(&work->fontAnimator, FontAnimator__GetDialogID(&work->fontAnimator) + 1);
    }

    FontAnimator__LoadMappingsFunc(&work->fontAnimator);
    FontAnimator__LoadPaletteFunc(&work->fontAnimator);
}

// DoorPuzzleKeySys
void CreateDoorPuzzleKeySys(DoorPuzzle *parent)
{
    Task *task =
        TaskCreate(DoorPuzzleKeySys_Main_InitKeys, DoorPuzzleKeySys_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000, TASK_SCOPE_1, DoorPuzzleKeySys);

    DoorPuzzleKeySys *work = TaskGetWork(task, DoorPuzzleKeySys);
    TaskInitWork16(work);

    work->parent = parent;
    for (s32 i = 0; i < DOORPUZZLE_STONE_KEY_COUNT; i++)
    {
        DoorPuzzleKeySys_InitKey(work, i, stoneKeyPosTable[i].x, stoneKeyPosTable[i].y);
    }

    work->seqPlayer = AllocSndHandle();
}

void DoorPuzzleKeySys_Destructor(Task *task)
{
    DoorPuzzleKeySys *work = TaskGetWork(task, DoorPuzzleKeySys);

    FreeSndHandle(work->seqPlayer);

    for (s32 c = 0; c < DOORPUZZLE_STONE_KEY_COUNT; c++)
    {
        AnimatorSprite__Release(&work->stoneKeys[c].aniSprite);
        ReleasePaletteAnimator(&work->stoneKeys[c].aniPalette);
    }
}

NONMATCH_FUNC void DoorPuzzleKeySys_Main_InitKeys(void)
{
    // https://decomp.me/scratch/EmMS4 -> 99.44%
    // small register mismatch at the start of function
#ifdef NON_MATCHING
    DoorPuzzleKeySys *work;
    s32 i;

    work = TaskGetWorkCurrent(DoorPuzzleKeySys);

    if (work->parent->eventID == DOORPUZZLE_EVENT_HAVE_KEYS)
    {
        DoorPuzzleKeySys_StartTouchInput();
        CreateDoorPuzzleTouchPrompt(work);

        for (i = 0; i < DOORPUZZLE_STONE_KEY_COUNT; i++)
        {
            work->stoneKeys[i].state     = DoorPuzzleKeySys_KeyState_Init;
            work->stoneKeys[i].stateDraw = DoorPuzzleKeySys_KeyStateDraw_Init;
        }
    }
    else
    {
        DoorPuzzleKeySys_StopTouchInput();

        for (i = 0; i < DOORPUZZLE_STONE_KEY_COUNT; i++)
        {
            work->stoneKeys[i].state     = NULL;
            work->stoneKeys[i].stateDraw = DoorPuzzleKeySys_KeyStateDraw_Init;
        }
    }

    SetCurrentTaskMainEvent(DoorPuzzleKeySys_Main_ProcessKeys);
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #4]
	ldr r1, [r1, #0xac]
	cmp r1, #2
	bne _02158AC4
	bl DoorPuzzleKeySys_StartTouchInput
	mov r0, r4
	bl CreateDoorPuzzleTouchPrompt
	ldr r1, =DoorPuzzleKeySys_KeyState_Init
	ldr r0, =DoorPuzzleKeySys_KeyStateDraw_Init
	mov r2, #0
_02158AA8:
	str r1, [r4, #0x20]
	add r2, r2, #1
	str r0, [r4, #0x24]
	cmp r2, #3
	add r4, r4, #0xa0
	blt _02158AA8
	b _02158AEC
_02158AC4:
	bl DoorPuzzleKeySys_StopTouchInput
	mov r2, #0
	ldr r0, =DoorPuzzleKeySys_KeyStateDraw_Init
	mov r1, r2
_02158AD4:
	str r1, [r4, #0x20]
	add r2, r2, #1
	str r0, [r4, #0x24]
	cmp r2, #3
	add r4, r4, #0xa0
	blt _02158AD4
_02158AEC:
	ldr r0, =DoorPuzzleKeySys_Main_ProcessKeys
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void DoorPuzzleKeySys_Main_ProcessKeys(void)
{
    DoorPuzzleKeySys *work = TaskGetWorkCurrent(DoorPuzzleKeySys);

    s32 i              = 0;
    DoorPuzzleKey *key = work->stoneKeys;
    for (; i < DOORPUZZLE_STONE_KEY_COUNT; i++)
    {
        if (key->state != NULL)
            key->state(key);

        if (key->stateDraw != NULL)
            key->stateDraw(key);

        key++;
    }

    if (work->parent->eventID == DOORPUZZLE_EVENT_HAVE_KEYS)
    {
        if (IsTouchInputEnabled() && TOUCH_HAS_ON(touchInput.flags))
        {
            work->parent->timer = 0;
        }
        else
        {
            if (work->parent->timer < 0xFFFF)
                work->parent->timer++;
        }
    }

    if ((work->parent->flags & DOORPUZZLE_FLAG_BACK_PRESSED) != 0)
    {
        for (i = 0; i < DOORPUZZLE_STONE_KEY_COUNT; i++)
        {
            work->stoneKeys[i].state = NULL;
        }

        if (work->seqPlayer->player != NULL)
        {
            StopStageSfx(work->seqPlayer);
            ReleaseStageSfx(work->seqPlayer);
        }

        DoorPuzzleKeySys_StopTouchInput(work);
    }
    else if (DoorPuzzleKeySys_CheckKeysInPlace(work))
    {
        for (i = 0; i < DOORPUZZLE_STONE_KEY_COUNT; i++)
        {
            work->stoneKeys[i].state = NULL;
        }

        if (work->seqPlayer->player != NULL)
        {
            StopStageSfx(work->seqPlayer);
            ReleaseStageSfx(work->seqPlayer);
        }

        if ((work->parent->flags & DOORPUZZLE_FLAG_ALL_KEYS_IN_PLACE) == 0)
            CreateDoorPuzzleCompleteActivateEffect(work);

        work->parent->flags |= DOORPUZZLE_FLAG_ALL_KEYS_IN_PLACE;
        DoorPuzzleKeySys_StopTouchInput(work);
    }
}

BOOL DoorPuzzleKeySys_CheckKeysInPlace(DoorPuzzleKeySys *work)
{
    for (s32 i = 0; i < DOORPUZZLE_STONE_KEY_COUNT; i++)
    {
        if ((work->stoneKeys[i].flags & DOORPUZZLEKEY_FLAG_IS_IN_PLACE) == 0)
            return FALSE;
    }

    return TRUE;
}

void DoorPuzzleKeySys_InitKey(DoorPuzzleKeySys *work, s32 id, s16 x, s16 y)
{
    DoorPuzzleKey *key = &work->stoneKeys[id];
    key->parent        = work;
    key->pos.x         = x;
    key->pos.y         = y;
    key->pos.x         = x;
    key->pos.y         = y;
    key->angle         = stoneKeyAngleTable[id];

    void *sprKey = FileUnknown__GetAOUFile(work->parent->archiveDoorPuzzle, ARCHIVE_DMPZ_LZ7_FILE_PANEL_BAC);
    AnimatorSprite__Init(&work->stoneKeys[id].aniSprite, sprKey, stoneKeyAnimTable[id], ANIMATOR_FLAG_DISABLE_LOOPING, TRUE, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(TRUE, Sprite__GetSpriteSize3(sprKey)), PALETTE_MODE_SUB_OBJ, 0, SPRITE_PRIORITY_3, SPRITE_ORDER_1);
    key->aniSprite.palette = id;
    key->aniSprite.pos.x   = key->pos.x;
    key->aniSprite.pos.y   = key->pos.y;

    void *palAniKey = FileUnknown__GetAOUFile(work->parent->archiveDoorPuzzle, ARCHIVE_DMPZ_LZ7_FILE_PANEL_BPA);
    InitPaletteAnimator(&work->stoneKeys[id].aniPalette, palAniKey, 0, ANIMATORBPA_FLAG_CAN_LOOP, PALETTE_MODE_SUB_OBJ, VRAMKEY_TO_ADDR(id << 9));
}

void DoorPuzzleKeySys_DrawKey(DoorPuzzleKey *work)
{
    if ((work->flags & DOORPUZZLEKEY_FLAG_WILL_BE_IN_PLACE) != 0)
    {
        AnimatePalette(&work->aniPalette);
        DrawAnimatedPalette(&work->aniPalette);

        work->aniSprite.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    }
    else
    {
        work->aniSprite.flags &= ~ANIMATOR_FLAG_DISABLE_PALETTES;
    }

    AnimatorSprite__ProcessAnimationFast(&work->aniSprite);
    AnimatorSprite__DrawFrameRotoZoom(&work->aniSprite, FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(1.0), work->angle);
}

void DoorPuzzleKeySys_StartTouchInput(DoorPuzzleKeySys *workid)
{
    StartSamplingTouchInput(4);
}

void DoorPuzzleKeySys_StopTouchInput(DoorPuzzleKeySys *work)
{
    StopSamplingTouchInput();
}

void DoorPuzzleKeySys_ProcessKey(DoorPuzzleKey *work)
{
    if ((s32)work->angle > (u16)-FLOAT_DEG_TO_IDX(3.0) || (s32)work->angle < FLOAT_DEG_TO_IDX(3.0))
    {
        work->flags |= DOORPUZZLEKEY_FLAG_WILL_BE_IN_PLACE;

        if ((work->flags & DOORPUZZLEKEY_FLAG_IS_IN_PLACE) == 0)
        {
            work->timer++;
            if (work->timer > 40)
                work->timer = 40;
        }
    }
    else
    {
        work->timer = 0;
        work->flags &= ~DOORPUZZLEKEY_FLAG_IS_IN_PLACE;
        work->flags &= ~DOORPUZZLEKEY_FLAG_WILL_BE_IN_PLACE;
    }

    if (work->timer >= 40)
    {
        work->parent->parent->mode = DOORPUZZLE_MODE_KEY_IN_PLACE;
        work->flags |= DOORPUZZLEKEY_FLAG_IS_IN_PLACE;
        work->timer = 0;
    }
}

void DoorPuzzleKeySys_KeyStateDraw_Init(DoorPuzzleKey *work)
{
    DoorPuzzleKeySys_DrawKey(work);

    work->stateDraw = DoorPuzzleKeySys_KeyStateDraw_Main;
}

void DoorPuzzleKeySys_KeyStateDraw_Main(DoorPuzzleKey *work)
{
    DoorPuzzleKeySys_DrawKey(work);
    DoorPuzzleKeySys_ProcessKey(work);
}

void DoorPuzzleKeySys_KeyState_Init(DoorPuzzleKey *work)
{
    work->state = DoorPuzzleKeySys_KeyState_Active;
}

void DoorPuzzleKeySys_KeyState_Active(DoorPuzzleKey *work)
{
    if ((work->parent->flags & DOORPUZZLEKEYS_FLAG_IS_READY) != 0)
    {
        if (IsTouchInputEnabled() && TOUCH_HAS_ON(touchInput.flags) && (!IsTouchInputEnabled() || !TOUCH_HAS_PUSH(touchInput.flags)))
        {
            VecFx32 touchPos;
            VecFx32 center;

            VEC_Set(&touchPos, FX32_FROM_WHOLE(touchInput.on.x), FX32_FROM_WHOLE(touchInput.on.y), FLOAT_TO_FX32(0.0));
            VEC_Set(&center, FX32_FROM_WHOLE(work->pos.x), FX32_FROM_WHOLE(work->pos.y), FLOAT_TO_FX32(0.0));

            if (VEC_Distance(&center, &touchPos) < FLOAT_TO_FX32(34.0))
            {
                fx32 prevTouchY = FX32_FROM_WHOLE(touchInput.prev.y);
                fx32 prevTouchX = FX32_FROM_WHOLE(touchInput.prev.x);

                u16 curAngle = FX_Atan2Idx(touchPos.y - center.y, touchPos.x - center.x);
                u16 prevAngle = FX_Atan2Idx(prevTouchY - center.y, prevTouchX - center.x);

                s32 angleDistance = (curAngle - prevAngle);
                if (MATH_ABS(angleDistance) > FLOAT_DEG_TO_IDX(180.0))
                {
                    if (angleDistance >= 0)
                        angleDistance = FLOAT_DEG_TO_IDX(360.0) - angleDistance;
                    else
                        angleDistance = -FLOAT_DEG_TO_IDX(360.0) - angleDistance;
                }

                u16 angleMove = angleDistance >> 4;

                if (angleMove != 0)
                {
                    if (work->parent->seqPlayer->player == NULL)
                    {
                        PlayHandleSystemSfx(work->parent->seqPlayer, SND_SYS_SEQARC_ARC_MYSTERY, SND_SYS_SEQARC_ARC_MYSTERY_SEQ_SE_MONUMENT);
                    }
                }
                else
                {
                    if (work->parent->seqPlayer->player != NULL)
                    {
                        StopStageSfx(work->parent->seqPlayer);
                        ReleaseStageSfx(work->parent->seqPlayer);
                    }
                }

                work->angle += angleMove;
            }
        }
        else
        {
            if (work->parent->seqPlayer->player != NULL)
            {
                StopStageSfx(work->parent->seqPlayer);
                ReleaseStageSfx(work->parent->seqPlayer);
            }
        }
    }
}

// DoorPuzzleTouchPrompt
void CreateDoorPuzzleTouchPrompt(DoorPuzzleKeySys *parent)
{
    Task *task = TaskCreate(DoorPuzzleTouchPrompt_Main_Init, DoorPuzzleTouchPrompt_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000, TASK_SCOPE_2,
                            DoorPuzzleTouchPrompt);

    DoorPuzzleTouchPrompt *work = TaskGetWork(task, DoorPuzzleTouchPrompt);
    TaskInitWork16(work);

    work->parent = parent;
    InitDoorPuzzleGraphics(&parent->parent->graphics);

    LoadSpriteButtonTouchpadSprite();

    void *sprTouchpad = GetSpriteButtonTouchpadSprite();
    AnimatorSprite__Init(&work->aniTouchPad, sprTouchpad, 0, ANIMATOR_FLAG_DISABLE_LOOPING, TRUE, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(TRUE, Sprite__GetSpriteSize3(sprTouchpad)), PALETTE_MODE_SPRITE, VRAMKEY_TO_ADDR(HW_DB_OBJ_PLTT), SPRITE_PRIORITY_0,
                         SPRITE_ORDER_0);
    work->aniTouchPad.pos.x = 128;
    work->aniTouchPad.pos.y = 96;
    AnimatorSprite__ProcessAnimationFast(&work->aniTouchPad);
}

void DoorPuzzleTouchPrompt_Destructor(Task *task)
{
    DoorPuzzleTouchPrompt *work = TaskGetWork(task, DoorPuzzleTouchPrompt);

    ReleaseDoorPuzzleGraphics(&work->parent->parent->graphics);
    AnimatorSprite__Release(&work->aniTouchPad);

    ReleaseSpriteButtonTouchpadSprite();
}

void DoorPuzzleTouchPrompt_Main_Init(void)
{
    DoorPuzzleTouchPrompt *work = TaskGetWorkCurrent(DoorPuzzleTouchPrompt);

    work->timer = 600;
    SetCurrentTaskMainEvent(DoorPuzzleTouchPrompt_Main_AwaitSignal);
}

void DoorPuzzleTouchPrompt_Main_AwaitSignal(void)
{
    DoorPuzzleTouchPrompt *work = TaskGetWorkCurrent(DoorPuzzleTouchPrompt);

    if ((work->parent->parent->flags & DOORPUZZLE_FLAG_TOUCHPAD_READY) != 0)
    {
        SetupDisplayForDoorPuzzleTouchPrompt(work);
        PlaySysSfx(SND_SYS_SEQARC_ARC_MYSTERY_SEQ_SE_DS);
        SetCurrentTaskMainEvent(DoorPuzzleTouchPrompt_Main_Active);
    }
}

NONMATCH_FUNC void DoorPuzzleTouchPrompt_Main_Active(void)
{
    // https://decomp.me/scratch/2RVId -> 84.49%
#ifdef NON_MATCHING
    DoorPuzzleTouchPrompt *work = TaskGetWorkCurrent(DoorPuzzleTouchPrompt);

    AnimatorSprite__ProcessAnimationFast(&work->aniTouchPad);
    AnimatorSprite__DrawFrame(&work->aniTouchPad);

    HandleDoorPuzzleTouchPromptAlpha(work, FLOAT_TO_FX32(0.5), 7);

    if (IsTouchInputEnabled() && TOUCH_HAS_PUSH(touchInput.flags) || work->timer-- == 0)
    {
        if (work->aniTouchPad.animFrameIndex >= 12)
        {
            PlaySysSfx(SND_SYS_SEQARC_ARC_MYSTERY_SEQ_SE_M_DECIDE);
            work->parent->flags |= DOORPUZZLEKEYS_FLAG_IS_READY;
            SetCurrentTaskMainEvent(DoorPuzzleTouchPrompt_Main_FadeOut);
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r0, r4, #0xc
	bl AnimatorSprite__ProcessAnimation
	add r0, r4, #0xc
	bl AnimatorSprite__DrawFrame
	mov r0, r4
	mov r1, #0x800
	mov r2, #7
	bl HandleDoorPuzzleTouchPromptAlpha
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0215929C
	ldr r0, =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	bne _021592B0
_0215929C:
	ldr r0, [r4, #4]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #4]
	ldmneia sp!, {r4, pc}
_021592B0:
	ldrh r0, [r4, #0x1a]
	cmp r0, #0xc
	ldmloia sp!, {r4, pc}
	mov r0, #0
	bl PlaySysSfx
	ldr r2, [r4, #0]
	ldr r0, =DoorPuzzleTouchPrompt_Main_FadeOut
	ldr r1, [r2, #0]
	orr r1, r1, #1
	str r1, [r2]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void DoorPuzzleTouchPrompt_Main_FadeOut(void)
{
    DoorPuzzleTouchPrompt *work = TaskGetWorkCurrent(DoorPuzzleTouchPrompt);

    if (HandleDoorPuzzleTouchPromptAlpha(work, FLOAT_TO_FX32(0.5), 15))
    {
        ResetDisplayFromDoorPuzzleTouchPrompt(work);
        DestroyCurrentTask();
    }
}

void SetupDisplayForDoorPuzzleTouchPrompt(DoorPuzzleTouchPrompt *work)
{
    work->alpha = FLOAT_TO_FX32(16.0);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~GX_PLANEMASK_BG1);

    MI_CpuClear16(&renderCoreGFXControlB.blendManager, sizeof(renderCoreGFXControlB.blendManager));

    renderCoreGFXControlB.blendManager.blendControl.effect     = BLENDTYPE_ALPHA;
    renderCoreGFXControlB.blendManager.blendControl.plane2_BG0 = TRUE;
    renderCoreGFXControlB.blendManager.blendControl.plane1_BG1 = TRUE;
    renderCoreGFXControlB.blendManager.blendControl.plane2_OBJ = TRUE;

    renderCoreGFXControlB.blendManager.blendAlpha.ev1 = 0x00;
    renderCoreGFXControlB.blendManager.blendAlpha.ev2 = FX32_TO_WHOLE(work->alpha);
}

void ResetDisplayFromDoorPuzzleTouchPrompt(DoorPuzzleTouchPrompt *work)
{
    work->alpha = FLOAT_TO_FX32(16.0);

    GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~GX_PLANEMASK_BG1);

    MI_CpuClear16(&renderCoreGFXControlB.blendManager, sizeof(renderCoreGFXControlB.blendManager));
}

BOOL HandleDoorPuzzleTouchPromptAlpha(DoorPuzzleTouchPrompt *work, fx32 changeSpeed, s32 targetAlpha)
{
    fx32 targetAlpha32 = MTM_MATH_CLIP(FX32_FROM_WHOLE(targetAlpha), FX32_FROM_WHOLE(0), FX32_FROM_WHOLE(16));

    fx32 change = targetAlpha32 - work->alpha;

    if ((GXS_GetVisiblePlane() & GX_PLANEMASK_BG1) == 0)
        GXS_SetVisiblePlane(GXS_GetVisiblePlane() | GX_PLANEMASK_BG1);

    changeSpeed = MTM_MATH_CLIP(changeSpeed, FX32_FROM_WHOLE(0), FX32_FROM_WHOLE(16));

    if (change < 0)
    {
        work->alpha -= changeSpeed;
        if (targetAlpha32 > work->alpha)
            work->alpha = targetAlpha32;
    }
    else
    {
        work->alpha += changeSpeed;
        if (targetAlpha32 < work->alpha)
            work->alpha = targetAlpha32;
    }

    renderCoreGFXControlB.blendManager.blendAlpha.ev2 = MTM_MATH_CLIP(FX32_TO_WHOLE(work->alpha), 0, 16);

    return work->alpha == targetAlpha32;
}

// DoorPuzzleCompleteActivateEffect
void CreateDoorPuzzleCompleteActivateEffect(DoorPuzzleKeySys *parent)
{
    Task *task = TaskCreate(DoorPuzzleCompleteActivateEffect_Main_Init, DoorPuzzleCompleteActivateEffect_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x3000,
                            TASK_SCOPE_2, DoorPuzzleCompleteActivateEffect);

    DoorPuzzleCompleteActivateEffect *work = TaskGetWork(task, DoorPuzzleCompleteActivateEffect);
    TaskInitWork16(work);

    InitPaletteAnimator(&work->aniPalette, FileUnknown__GetAOUFile(parent->parent->archiveDoorPuzzle, ARCHIVE_DMPZ_LZ7_FILE_PANEL_BG_BPA), 0, ANIMATORBPA_FLAG_NONE,
                        PALETTE_MODE_SUB_BG, NULL);
}

void DoorPuzzleCompleteActivateEffect_Destructor(Task *task)
{
    DoorPuzzleCompleteActivateEffect *work = TaskGetWork(task, DoorPuzzleCompleteActivateEffect);

    ReleasePaletteAnimator(&work->aniPalette);
}

void DoorPuzzleCompleteActivateEffect_Main_Init(void)
{
    PlaySysSfx(SND_SYS_SEQARC_ARC_MYSTERY_SEQ_SE_SUCCESS);
    SetCurrentTaskMainEvent(DoorPuzzleCompleteActivateEffect_Main_Animate);
}

void DoorPuzzleCompleteActivateEffect_Main_Animate(void)
{
    DoorPuzzleCompleteActivateEffect *work = TaskGetWorkCurrent(DoorPuzzleCompleteActivateEffect);

    AnimatePalette(&work->aniPalette);
    DrawAnimatedPalette(&work->aniPalette);

    if (CheckPaletteAnimationLooped(&work->aniPalette))
        DestroyCurrentTask();
}

// DoorPuzzle
void DoorPuzzle_Main_Init(void)
{
    DoorPuzzle *work = TaskGetWorkCurrent(DoorPuzzle);

    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_FADE_TO_BLACK, FLOAT_TO_FX32(1.0));

    CreateDoorPuzzleKeySys(work);
    PlaySysTrack(SND_SYS_SEQ_SEQ_MYSTERY, TRUE);

    SetCurrentTaskMainEvent(DoorPuzzle_Main_FadeIn);
}

void DoorPuzzle_Destructor(Task *task)
{
    DoorPuzzle *work = TaskGetWork(task, DoorPuzzle);

    ReleaseSysSound();
    ReleaseDoorPuzzleAssets(work);
}

void DoorPuzzle_Main_FadeIn(void)
{
    if (IsDrawFadeTaskFinished())
    {
        SetCurrentTaskMainEvent(DoorPuzzle_Main_CreateDialogue);
    }
}

void DoorPuzzle_Main_CreateDialogue(void)
{
    DoorPuzzle *work = TaskGetWorkCurrent(DoorPuzzle);

    work->flags |= DOORPUZZLE_FLAG_TOUCHPAD_READY;
    DoorPuzzleDialogue_Create(work);

    SetCurrentTaskMainEvent(DoorPuzzle_Main_Active);
}

void DoorPuzzle_Main_Active(void)
{
    DoorPuzzle *work = TaskGetWorkCurrent(DoorPuzzle);

    if ((work->flags & DOORPUZZLE_FLAG_START_FADE_OUT) != 0)
    {
        if (work->fadeOutDelay != 0)
		{
            work->fadeOutDelay--;
		}
        else
		{
            SetCurrentTaskMainEvent(DoorPuzzle_Main_InitFadeOut);
		}
    }
}

void DoorPuzzle_Main_InitFadeOut(void)
{
    CreateDrawFadeTask(DRAW_FADE_TASK_FLAG_DESTROY_ON_FINISHED, FLOAT_TO_FX32(1.0));
    FadeSysTrack(20);

    SetCurrentTaskMainEvent(DoorPuzzle_Main_FadeOut);
}

void DoorPuzzle_Main_FadeOut(void)
{
    DoorPuzzle *work = TaskGetWorkCurrent(DoorPuzzle);

    if (IsDrawFadeTaskFinished())
    {
        DestroyDrawFadeTask();
        ChangeEventForDoorPuzzle(work);
        ClearDoorPuzzleTasks();
    }
}
