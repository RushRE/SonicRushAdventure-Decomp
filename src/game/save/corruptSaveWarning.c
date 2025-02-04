#include <game/save/corruptSaveWarning.h>
#include <game/system/allocator.h>
#include <game/system/system.h>
#include <game/system/sysEvent.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/background.h>
#include <game/file/fsRequest.h>
#include <game/file/fileUnknown.h>
#include <game/game/gameState.h>
#include <game/input/padInput.h>

// resources
#include <resources/narc/dm_save_error_lz7.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void CorruptSaveWarning_Destructor(Task *task);
static void CorruptSaveWarning_Main_Corrupted(void);
static void CorruptSaveWarning_Main_CantReadSave(void);

// --------------------
// FUNCTIONS
// --------------------

void CreateCorruptSaveWarning(void)
{
    SetupDisplayForCorruptSaveWarning();

    ((u16 *)VRAM_BG_PLTT)[0]    = GX_RGB_888(0x00, 0x00, 0x00);
    ((u16 *)VRAM_DB_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);

    TaskMain mainFunc;
    if (gameState.lastSaveError == GAMESAVE_ERROR_CORRUPT)
    {
        mainFunc = CorruptSaveWarning_Main_Corrupted;
    }
    else
    {
        mainFunc = CorruptSaveWarning_Main_CantReadSave;
        RenderCore_DisableSoftReset(TRUE);
    }

    Task *task               = TaskCreate(mainFunc, CorruptSaveWarning_Destructor, TASK_FLAG_NONE, 0, 0x1000, TASK_GROUP(1), CorruptSaveWarning);
    CorruptSaveWarning *work = TaskGetWork(task, CorruptSaveWarning);
    TaskInitWork16(work);

    work->fontPtr = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);
    FSRequestArchive("/narc/dm_save_error_lz7.narc", &work->archive, TRUE);

    // Load font resources
    FontWindow__Init(&work->fontWindow);
    FontWindow__LoadFromMemory(&work->fontWindow, work->fontPtr, 1);
    FontAnimator__Init(&work->fontAnimator);
    FontAnimator__LoadFont2(&work->fontAnimator, &work->fontWindow, 8, 1, 9, 30, 6, 1, 0, 1, 0);

    // Init font resources
    FontAnimator__LoadMPCFile(&work->fontAnimator, FileUnknown__GetAOUFile(work->archive, ARCHIVE_DM_SAVE_ERROR_LZ7_FILE_DM_SAVE_ERROR_JPN_MPC + GetGameLanguage()));
    FontAnimator__SetCallbackType(&work->fontAnimator, 1);
    FontAnimator__LoadPaletteFunc2(&work->fontAnimator);
    FontWindowAnimator__Init(&work->fontWindowAnimator);
    FontWindowAnimator__Load1(&work->fontWindowAnimator, &work->fontWindow, 0, 0, 2, 0, 7, 32, 10, TRUE, BACKGROUND_1, 3, 700, 0);
    FontAnimator__SetMsgSequence(&work->fontAnimator, gameState.lastSaveError);
    FontAnimator__InitStartPos(&work->fontAnimator, 1, 0);
    FontAnimator__LoadCharacters(&work->fontAnimator, 0);
    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontAnimator__Draw(&work->fontAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    // Init sprites
    AnimatorSprite__Init(&work->aniButtonPrompt, FileUnknown__GetAOUFile(work->archive, ARCHIVE_DM_SAVE_ERROR_LZ7_FILE_DMCMN_FIX_NEXT_BAC), 2, ANIMATOR_FLAG_DISABLE_LOOPING, 1, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(TRUE, 4), PALETTE_MODE_SPRITE, VRAM_DB_OBJ_PLTT, SPRITE_PRIORITY_0, SPRITE_ORDER_1);
    work->aniButtonPrompt.cParam.palette = PALETTE_ROW_1;
    work->aniButtonPrompt.pos.x   = 216;
    work->aniButtonPrompt.pos.y   = 104;
    AnimatorSprite__ProcessAnimationFast(&work->aniButtonPrompt);

    GXS_SetVisiblePlane(GX_PLANEMASK_BG1 | GX_PLANEMASK_OBJ);
}

void SetupDisplayForCorruptSaveWarning(void)
{
    GX_SetMasterBrightness(RENDERCORE_BRIGHTNESS_BLACK);
    GXS_SetMasterBrightness(RENDERCORE_BRIGHTNESS_BLACK);

    GX_SetVisiblePlane(GX_PLANEMASK_NONE);
    GXS_SetVisiblePlane(GX_PLANEMASK_NONE);

    VRAMSystem__Init(VRAM_MODE_0);
    VRAMSystem__SetupBGExtPalBank(GX_VRAM_BGEXTPLTT_NONE);
    VRAMSystem__SetupSubBGExtPalBank(GX_VRAM_SUB_BGEXTPLTT_NONE);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_128_D, GX_OBJVRAMMODE_CHAR_1D_64K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 1024);

    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);
    GX_SetVisiblePlane(GX_PLANEMASK_NONE);

    GX_SetPower(GX_POWER_2D);
    GX_SetDispSelect(GX_DISP_SELECT_MAIN_SUB);

    GX_DispOn();
    GXS_DispOn();

    ResetRenderAffine();

    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);

    G2_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0xf000, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_01);
    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0xf800, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_01);

    G2_SetBG0Priority(1);
    G2_SetBG1Priority(0);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(3);

    // not sure why this is called a second time, perhaps it was intended to be GXS_?
    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);

    G2S_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0xe800, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_01);
    G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0xf800, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_01);

    G2S_SetBG0Priority(1);
    G2S_SetBG1Priority(0);
    G2S_SetBG2Priority(2);
    G2S_SetBG3Priority(3);

    MI_CpuClear32((VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_A] + 0xF000), 0x1000);
    MI_CpuClear32((VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_B] + 0xE800), 0x1800);

    MI_CpuClear32(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_A], 32);
    MI_CpuClear32(VRAMSystem__VRAM_BG[GRAPHICS_ENGINE_B], 32);
}

void CorruptSaveWarning_Destructor(Task *task)
{
    CorruptSaveWarning *work = TaskGetWork(task, CorruptSaveWarning);

    ((u16 *)VRAM_BG_PLTT)[0]    = GX_RGB_888(0x00, 0x00, 0x00);
    ((u16 *)VRAM_DB_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);

    GX_SetVisiblePlane(GX_PLANEMASK_NONE);
    GXS_SetVisiblePlane(GX_PLANEMASK_NONE);

    FontAnimator__Release(&work->fontAnimator);
    FontWindowAnimator__Release(&work->fontWindowAnimator);
    FontWindow__Release(&work->fontWindow);

    if (work->fontPtr != NULL)
        HeapFree(HEAP_USER, work->fontPtr);

    AnimatorSprite__Release(&work->aniButtonPrompt);

    if (work->archive != NULL)
        HeapFree(HEAP_USER, work->archive);
}

void CorruptSaveWarning_Main_Corrupted(void)
{
    CorruptSaveWarning *work = TaskGetWorkCurrent(CorruptSaveWarning);

    CorruptSaveWarning_Main_CantReadSave();

    AnimatorSprite__ProcessAnimationFast(&work->aniButtonPrompt);
    AnimatorSprite__DrawFrame(&work->aniButtonPrompt);

    if ((padInput.btnPress & PAD_BUTTON_A) != 0)
    {
        DestroyCurrentTask();
        RequestSysEventChange(0);
        NextSysEvent();
    }
}

void CorruptSaveWarning_Main_CantReadSave(void)
{
    CorruptSaveWarning *work = TaskGetWorkCurrent(CorruptSaveWarning);

    FontWindowAnimator__Draw(&work->fontWindowAnimator);
    FontAnimator__Draw(&work->fontAnimator);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);
}