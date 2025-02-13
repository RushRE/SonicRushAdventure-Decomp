#include <menu/deleteSaveDataMenu.h>
#include <game/game/gameState.h>
#include <game/save/saveGame.h>
#include <game/save/saveManager.h>
#include <game/audio/sysSound.h>
#include <game/input/padInput.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/background.h>
#include <game/file/binaryBundle.h>
#include <game/file/fsRequest.h>
#include <game/file/fileUnknown.h>
#include <game/file/bundleFileUnknown.h>
#include <game/system/sysEvent.h>

// resources
#include <resources/narc/dm_sd_act_lz7.h>
#include <resources/narc/dmni_lz7.h>
#include <resources/bb/dm_save_del.h>

// --------------------
// ENUMS
// --------------------

enum DeleteSaveMsgSequences
{
    DELETESAVE_MSGSEQ_DELETING_SAVE_DATA,
    DELETESAVE_MSGSEQ_DELETE_DATA_TYPE_CHOICE,
    DELETESAVE_MSGSEQ_THIS_WILL_DELETE_ALL_STORY_DATA,
    DELETESAVE_MSGSEQ_STORY_DATA_CONFIRM_CHOICE,
    DELETESAVE_MSGSEQ_THIS_WILL_DELETE_ALL_DATA,
    DELETESAVE_MSGSEQ_ALL_DATA_CONFIRM_CHOICE,
    DELETESAVE_MSGSEQ_DELETING_SAVED_DATA,
    DELETESAVE_MSGSEQ_SAVE_DATA_DELETED,
    DELETESAVE_MSGSEQ_DELETION_CANCELLED,
};

enum DataTypeSelection
{
    DATATYPE_SEL_STORY_DATA,
    DATATYPE_SEL_ALL_DATA,
    DATATYPE_SEL_QUIT,
};

enum ConfirmSelection
{
    CONFIRM_SEL_YES,
    CONFIRM_SEL_NO,
};

// --------------------
// FUNCTION DECLS
// --------------------

// Initialization & Release
void LoadDeleteSaveDataMenuAssets(DeleteSaveDataMenu *work);
void SetupDisplayForDeleteSaveDataMenu(DeleteSaveDataMenu *work);
void InitDeleteSaveDataMenuFontWindow(DeleteSaveDataMenu *work);
void InitDeleteSaveDataMenuText(DeleteSaveDataMenu *work);
void InitDeleteSaveDataMenuSprites(DeleteSaveDataMenu *work);
void InitDeleteSaveDataMenuBackground(DeleteSaveDataMenu *work);
void ReleaseDeleteSaveDataMenu(DeleteSaveDataMenu *work);
void ResetDisplayFromDeleteSaveDataMenu(DeleteSaveDataMenu *work);
void ReleaseDeleteSaveDataMenuFontWindow(DeleteSaveDataMenu *work);
void ReleaseDeleteSaveDataMenuText(DeleteSaveDataMenu *work);
void ReleaseDeleteSaveDataMenuSprites(DeleteSaveDataMenu *work);
void ReleaseDeleteSaveDataMenuBackground(DeleteSaveDataMenu *work);

// Task Events
void DeleteSaveDataMenu_Main(void);
void DeleteSaveDataMenu_Destructor(Task *task);

// Main States
void DeleteSaveDataMenu_State_FadeIn(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_OpenWindow(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_PrepareOptionSelect(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_Selection(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_DeleteStoryDataSelected(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_ConfirmDeleteStoryData(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_DeletingDataSelected(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_ConfirmDeleteAllData(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_ConfirmDeleteDataSelected(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_DeletingData(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_DeletedData(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_CancelSelected(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_BeginReturnToTitle(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_State_FadeOut(DeleteSaveDataMenu *work);

// Selection States
void DeleteSaveDataMenu_StateSelect_Init(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_StateSelect_ShowWindow(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_StateSelect_Selecting(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_StateSelect_MadeSelection(DeleteSaveDataMenu *work);
void DeleteSaveDataMenu_StateSelect_CloseWindow(DeleteSaveDataMenu *work);

// Utils
DeleteSaveDataStatus DeleteSaveDataMenuDeleteData(BOOL deleteAllData);

// --------------------
// FUNCTIONS
// --------------------

void CreateDeleteSaveDataMenu(void)
{
    Task *task = TaskCreate(DeleteSaveDataMenu_Main, DeleteSaveDataMenu_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(0), DeleteSaveDataMenu);

    DeleteSaveDataMenu *work = TaskGetWork(task, DeleteSaveDataMenu);
    TaskInitWork32(work);

    LoadDeleteSaveDataMenuAssets(work);
    work->selection     = DATATYPE_SEL_ALL_DATA;
    work->msgSelection  = 0xFFFF;
    work->deleteAllData = FALSE;
    work->saveChanged   = FALSE;
    work->saveStatus    = DELETESAVEDATA_STATUS_SUCCEEDED;
    work->state         = DeleteSaveDataMenu_State_FadeIn;
    work->stateSelect   = NULL;

    LoadSysSoundVillage();
}

// Initialization & Release
void LoadDeleteSaveDataMenuAssets(DeleteSaveDataMenu *work)
{
    SetupDisplayForDeleteSaveDataMenu(work);

    work->mpcDeleteSaveData =
        ReadFileFromBundle("bb/dm_save_del.bb", BUNDLE_DM_SAVE_DEL_FILE_RESOURCES_BB_DM_SAVE_DEL_DM_SAVE_DEL_JPN_MPC + GetGameLanguage(), BINARYBUNDLE_AUTO_ALLOC_HEAD);
    work->fntAll = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);

    FontWindow__Init(&work->fontWindow);
    FontWindow__LoadFromMemory(&work->fontWindow, work->fntAll, TRUE);
    FontWindow__Load_mw_frame(&work->fontWindow);
    FontWindow__SetDMA(&work->fontWindow, 0);

    work->archiveSaveDelete = BundleFileUnknown__LoadFile("narc/dm_sd_act_lz7.narc", FSREQ_AUTO_ALLOC_HEAD);

    InitDeleteSaveDataMenuFontWindow(work);
    InitDeleteSaveDataMenuText(work);
    InitDeleteSaveDataMenuSprites(work);
    InitDeleteSaveDataMenuBackground(work);
}

void SetupDisplayForDeleteSaveDataMenu(DeleteSaveDataMenu *work)
{
    if (renderCoreGFXControlA.brightness > RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_WHITE;
        renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_WHITE;
    }
    else
    {
        renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_BLACK;
        renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    }

    GX_SetMasterBrightness(renderCoreGFXControlA.brightness);
    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness);

    GX_SetPower(GX_POWER_ALL);
    GX_Power3D(FALSE);

    VRAMSystem__Init(VRAM_MODE_0);

    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);
    GXS_SetGraphicsMode(GX_BGMODE_0);

    G2_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x18000, GX_BG_EXTPLTT_01);
    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x10000, GX_BG_EXTPLTT_01);
    G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x08000);
    G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1800, GX_BG_CHARBASE_0x04000);

    G2S_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1800, GX_BG_CHARBASE_0x04000);

    MI_CpuClear32(renderCoreGFXControlA.bgPosition, sizeof(renderCoreGFXControlA.bgPosition));
    MI_CpuClear32(renderCoreGFXControlB.bgPosition, sizeof(renderCoreGFXControlB.bgPosition));

    G2_SetBG0Priority(0);
    G2_SetBG1Priority(1);
    G2_SetBG2Priority(2);
    G2_SetBG3Priority(3);
    GX_SetVisiblePlane(GX_PLANEMASK_ALL);

    G2S_SetBG0Priority(0);
    G2S_SetBG1Priority(1);
    G2S_SetBG2Priority(2);
    G2S_SetBG3Priority(3);
    GXS_SetVisiblePlane(GX_PLANEMASK_BG3);

    MI_CpuClearFast(VRAM_BG, 0x80000);
    MI_CpuClearFast(VRAM_DB_BG, 0x20000);

    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;
}

void InitDeleteSaveDataMenuFontWindow(DeleteSaveDataMenu *work)
{
    FontWindowAnimator__Init(&work->fontWindowAnimatorMain);
    FontWindowAnimator__Load1(&work->fontWindowAnimatorMain, &work->fontWindow, 0, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG, PIXEL_TO_TILE(0),
                              PIXEL_TO_TILE(0), PIXEL_TO_TILE(HW_LCD_WIDTH), PIXEL_TO_TILE(96), GRAPHICS_ENGINE_A, BACKGROUND_2, PALETTE_ROW_2, 1, 0);
    FontWindowAnimator__Init(&work->fntWindowSelection);
}

void InitDeleteSaveDataMenuText(DeleteSaveDataMenu *work)
{
    FontAnimator__Init(&work->aniFontMain);
    FontAnimator__LoadFont1(&work->aniFontMain, &work->fontWindow, 0, PIXEL_TO_TILE(8), PIXEL_TO_TILE(8), PIXEL_TO_TILE(240), PIXEL_TO_TILE(80), GRAPHICS_ENGINE_A, BACKGROUND_1,
                            PALETTE_ROW_1, 1);
    FontAnimator__LoadMPCFile(&work->aniFontMain, work->mpcDeleteSaveData);
    FontAnimator__SetMsgSequence(&work->aniFontMain, DELETESAVE_MSGSEQ_DELETING_SAVE_DATA);
    FontAnimator__InitStartPos(&work->aniFontMain, 1, 0);
    FontAnimator__ClearPixels(&work->aniFontMain);
    FontAnimator__LoadMappingsFunc(&work->aniFontMain);
    FontAnimator__LoadPaletteFunc(&work->aniFontMain);

    FontAnimator__Init(&work->aniFontSelection);
    FontAnimator__LoadFont1(&work->aniFontSelection, &work->fontWindow, 0, PIXEL_TO_TILE(40), PIXEL_TO_TILE(112), PIXEL_TO_TILE(176), PIXEL_TO_TILE(48), GRAPHICS_ENGINE_A,
                            BACKGROUND_0, PALETTE_ROW_1, 1);
    FontAnimator__LoadMPCFile(&work->aniFontSelection, work->mpcDeleteSaveData);
    FontAnimator__SetMsgSequence(&work->aniFontSelection, DELETESAVE_MSGSEQ_DELETING_SAVE_DATA);
    FontAnimator__InitStartPos(&work->aniFontSelection, 1, 0);
    FontAnimator__ClearPixels(&work->aniFontSelection);
    FontAnimator__LoadMappingsFunc(&work->aniFontSelection);
    FontAnimator__LoadPaletteFunc(&work->aniFontSelection);
}

void InitDeleteSaveDataMenuSprites(DeleteSaveDataMenu *work)
{
    FontWindowMWControl__Init(&work->fontMWControl);
    FontWindowMWControl__Load(&work->fontMWControl, &work->fontWindow, 0, FONTWINDOWMW_FILL, 176, 16, GRAPHICS_ENGINE_A, SPRITE_PRIORITY_1, SPRITE_ORDER_0, PALETTE_ROW_0);

    void *sprCursor = FileUnknown__GetAOUFile(work->archiveSaveDelete, ARCHIVE_DM_SD_ACT_LZ7_FILE_NL_CURSOR_IKARI_BAC);
    AnimatorSprite__Init(&work->aniCursor, sprCursor, 0, ANIMATOR_FLAG_DISABLE_LOOPING, FALSE, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(FALSE, Sprite__GetSpriteSize3FromAnim(sprCursor, FALSE)), PALETTE_MODE_SPRITE, VRAM_OBJ_PLTT, SPRITE_PRIORITY_0,
                         SPRITE_ORDER_0);
    work->aniCursor.cParam.palette = PALETTE_ROW_1;
}

void InitDeleteSaveDataMenuBackground(DeleteSaveDataMenu *work)
{
    Background background;

    void *bgMenu = ArchiveFileUnknown__LoadFileFromArchive("narc/dmni_lz7.narc", ARCHIVE_DMNI_LZ7_FILE_DMNI_NAME_BASE_UP_BBG, FILEUNKNOWN_AUTO_ALLOC_HEAD);

    InitBackground(&background, bgMenu, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_A, BACKGROUND_3, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);

    InitBackground(&background, bgMenu, BACKGROUND_FLAG_LOAD_ALL, GRAPHICS_ENGINE_B, BACKGROUND_3, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT);
    DrawBackground(&background);

    HeapFree(HEAP_USER, bgMenu);
}

void ReleaseDeleteSaveDataMenu(DeleteSaveDataMenu *work)
{
    ReleaseDeleteSaveDataMenuBackground(work);
    ReleaseDeleteSaveDataMenuSprites(work);
    ReleaseDeleteSaveDataMenuText(work);
    ReleaseDeleteSaveDataMenuFontWindow(work);

    HeapFree(HEAP_USER, work->archiveSaveDelete);
    FontWindow__Release(&work->fontWindow);
    HeapFree(HEAP_USER, work->fntAll);
    HeapFree(HEAP_USER, work->mpcDeleteSaveData);

    ResetDisplayFromDeleteSaveDataMenu(work);
    ReleaseSysSound();
}

void ResetDisplayFromDeleteSaveDataMenu(DeleteSaveDataMenu *work)
{
    MI_CpuClearFast(VRAM_BG, 0x80000);
    MI_CpuClearFast(VRAM_DB_BG, 0x20000);
}

void ReleaseDeleteSaveDataMenuFontWindow(DeleteSaveDataMenu *work)
{
    FontWindowAnimator__Release(&work->fntWindowSelection);
    FontWindowAnimator__Release(&work->fontWindowAnimatorMain);
}

void ReleaseDeleteSaveDataMenuText(DeleteSaveDataMenu *work)
{
    FontAnimator__Release(&work->aniFontSelection);
    FontAnimator__Release(&work->aniFontMain);
}

void ReleaseDeleteSaveDataMenuSprites(DeleteSaveDataMenu *work)
{
    AnimatorSprite__Release(&work->aniCursor);
    FontWindowMWControl__Release(&work->fontMWControl);
}

void ReleaseDeleteSaveDataMenuBackground(DeleteSaveDataMenu *work)
{
    // nothing
}

// Task Events
void DeleteSaveDataMenu_Main(void)
{
    DeleteSaveDataMenu *work = TaskGetWorkCurrent(DeleteSaveDataMenu);

    if (work->state != NULL)
    {
        work->state(work);
        FontWindow__PrepareSwapBuffer(&work->fontWindow);
    }
    else
    {
        u32 nextEvent;
        if (work->saveChanged)
        {
            if (work->saveStatus != DELETESAVEDATA_STATUS_FAILED)
            {
                nextEvent = 0; // SYSEVENT_TITLE
            }
            else
            {
                gameState.lastSaveError = GAMESAVE_ERROR_CANT_SAVE;
                nextEvent               = 2; // SYSEVENT_CORRUPT_SAVE_WARNING
            }
        }
        else
        {
            gameState.talk.state.hubStartAction = 2;
            nextEvent                     = 1; // SYSEVENT_RETURN_TO_HUB
        }

        DestroyCurrentTask();
        RequestSysEventChange((s16)nextEvent);
        NextSysEvent();
    }
}

void DeleteSaveDataMenu_Destructor(Task *task)
{
    DeleteSaveDataMenu *work = TaskGetWork(task, DeleteSaveDataMenu);

    ReleaseDeleteSaveDataMenu(work);
}

// Main States
void DeleteSaveDataMenu_State_FadeIn(DeleteSaveDataMenu *work)
{
    if (renderCoreGFXControlA.brightness < RENDERCORE_BRIGHTNESS_DEFAULT)
        renderCoreGFXControlA.brightness++;

    if (renderCoreGFXControlA.brightness > RENDERCORE_BRIGHTNESS_DEFAULT)
        renderCoreGFXControlA.brightness--;

    renderCoreGFXControlB.brightness = renderCoreGFXControlA.brightness;

    if (renderCoreGFXControlA.brightness == RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        FontWindowAnimator__InitAnimation(&work->fontWindowAnimatorMain, 1, 8, 0, 0);
        FontWindowAnimator__StartAnimating(&work->fontWindowAnimatorMain);
        FontWindowAnimator__Func_20599B4(&work->fontWindowAnimatorMain);

        work->timer = 0;
        work->state = DeleteSaveDataMenu_State_OpenWindow;
    }
}

void DeleteSaveDataMenu_State_OpenWindow(DeleteSaveDataMenu *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimatorMain);

    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimatorMain))
    {
        FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimatorMain);
        FontAnimator__SetMsgSequence(&work->aniFontMain, DELETESAVE_MSGSEQ_DELETING_SAVE_DATA);

        u32 lineCount = FontAnimator__GetDialogLineCount(&work->aniFontMain, 0);
        FontAnimator__AdvanceLine(&work->aniFontMain, 4 * (10 - 2 * lineCount));
        work->timer = 0;
        work->state = DeleteSaveDataMenu_State_PrepareOptionSelect;
    }
}

void DeleteSaveDataMenu_State_PrepareOptionSelect(DeleteSaveDataMenu *work)
{
    FontAnimator__LoadCharacters(&work->aniFontMain, 1);
    FontAnimator__Draw(&work->aniFontMain);

    if (FontAnimator__IsEndOfLine(&work->aniFontMain))
    {
        work->selection    = DATATYPE_SEL_QUIT;
        work->msgSelection = DELETESAVE_MSGSEQ_DELETE_DATA_TYPE_CHOICE;
        work->stateSelect  = DeleteSaveDataMenu_StateSelect_Init;
        work->timer        = 0;
        work->state        = DeleteSaveDataMenu_State_Selection;
    }
}

void DeleteSaveDataMenu_State_Selection(DeleteSaveDataMenu *work)
{
    if (work->stateSelect != NULL)
    {
        work->stateSelect(work);
    }
    else
    {
        switch (work->selection)
        {
            case DATATYPE_SEL_STORY_DATA:
                FontAnimator__SetMsgSequence(&work->aniFontMain, DELETESAVE_MSGSEQ_THIS_WILL_DELETE_ALL_STORY_DATA);
                work->timer = 0;
                work->state = DeleteSaveDataMenu_State_DeleteStoryDataSelected;
                break;

            case DATATYPE_SEL_ALL_DATA:
                FontAnimator__SetMsgSequence(&work->aniFontMain, DELETESAVE_MSGSEQ_THIS_WILL_DELETE_ALL_DATA);
                work->timer = 0;
                work->state = DeleteSaveDataMenu_State_DeletingDataSelected;
                break;

            case DATATYPE_SEL_QUIT:
                work->saveChanged = FALSE;
                FontAnimator__SetMsgSequence(&work->aniFontMain, DELETESAVE_MSGSEQ_DELETION_CANCELLED);
                work->timer = 0;
                work->state = DeleteSaveDataMenu_State_CancelSelected;
                break;
        }

        u32 lineCount = FontAnimator__GetDialogLineCount(&work->aniFontMain, 0);
        FontAnimator__AdvanceLine(&work->aniFontMain, 4 * (10 - 2 * lineCount));
    }
}

void DeleteSaveDataMenu_State_DeleteStoryDataSelected(DeleteSaveDataMenu *work)
{
    FontAnimator__LoadCharacters(&work->aniFontMain, 1);
    FontAnimator__Draw(&work->aniFontMain);

    if (FontAnimator__IsEndOfLine(&work->aniFontMain))
    {
        work->selection    = CONFIRM_SEL_NO;
        work->msgSelection = DELETESAVE_MSGSEQ_STORY_DATA_CONFIRM_CHOICE;
        work->stateSelect  = DeleteSaveDataMenu_StateSelect_Init;
        work->timer        = 0;
        work->state        = DeleteSaveDataMenu_State_ConfirmDeleteStoryData;
    }
}

void DeleteSaveDataMenu_State_ConfirmDeleteStoryData(DeleteSaveDataMenu *work)
{
    if (work->stateSelect != NULL)
    {
        work->stateSelect(work);
    }
    else
    {

        switch (work->selection)
        {
            case CONFIRM_SEL_YES:
                work->deleteAllData = FALSE;
                work->saveChanged   = TRUE;
                FontAnimator__SetMsgSequence(&work->aniFontMain, DELETESAVE_MSGSEQ_DELETING_SAVED_DATA);
                work->timer = 0;
                work->state = DeleteSaveDataMenu_State_ConfirmDeleteDataSelected;
                break;

            case CONFIRM_SEL_NO:
                work->saveChanged = FALSE;
                FontAnimator__SetMsgSequence(&work->aniFontMain, DELETESAVE_MSGSEQ_DELETION_CANCELLED);
                work->timer = 0;
                work->state = DeleteSaveDataMenu_State_CancelSelected;
                break;
        }

        u32 lineCount = FontAnimator__GetDialogLineCount(&work->aniFontMain, 0);
        FontAnimator__AdvanceLine(&work->aniFontMain, 4 * (10 - 2 * lineCount));
    }
}

void DeleteSaveDataMenu_State_DeletingDataSelected(DeleteSaveDataMenu *work)
{
    FontAnimator__LoadCharacters(&work->aniFontMain, 1);
    FontAnimator__Draw(&work->aniFontMain);

    if (FontAnimator__IsEndOfLine(&work->aniFontMain))
    {
        work->selection    = CONFIRM_SEL_NO;
        work->msgSelection = DELETESAVE_MSGSEQ_ALL_DATA_CONFIRM_CHOICE;
        work->stateSelect  = DeleteSaveDataMenu_StateSelect_Init;
        work->timer        = 0;
        work->state        = DeleteSaveDataMenu_State_ConfirmDeleteAllData;
    }
}

void DeleteSaveDataMenu_State_ConfirmDeleteAllData(DeleteSaveDataMenu *work)
{
    if (work->stateSelect != NULL)
    {
        work->stateSelect(work);
    }
    else
    {
        switch (work->selection)
        {
            case CONFIRM_SEL_YES:
                work->deleteAllData = TRUE;
                work->saveChanged   = TRUE;
                FontAnimator__SetMsgSequence(&work->aniFontMain, DELETESAVE_MSGSEQ_DELETING_SAVED_DATA);
                work->timer = 0;
                work->state = DeleteSaveDataMenu_State_ConfirmDeleteDataSelected;
                break;

            case CONFIRM_SEL_NO:
                work->saveChanged = FALSE;
                FontAnimator__SetMsgSequence(&work->aniFontMain, DELETESAVE_MSGSEQ_DELETION_CANCELLED);
                work->timer = 0;
                work->state = DeleteSaveDataMenu_State_CancelSelected;
                break;
        }

        u32 lineCount = FontAnimator__GetDialogLineCount(&work->aniFontMain, 0);
        FontAnimator__AdvanceLine(&work->aniFontMain, 4 * (10 - 2 * lineCount));
    }
}

void DeleteSaveDataMenu_State_ConfirmDeleteDataSelected(DeleteSaveDataMenu *work)
{
    FontAnimator__LoadCharacters(&work->aniFontMain, 1);
    FontAnimator__Draw(&work->aniFontMain);

    if (FontAnimator__IsEndOfLine(&work->aniFontMain))
    {
        work->timer = 0;
        work->state = DeleteSaveDataMenu_State_DeletingData;
    }
}

void DeleteSaveDataMenu_State_DeletingData(DeleteSaveDataMenu *work)
{
    FontAnimator__LoadCharacters(&work->aniFontMain, 1);
    FontAnimator__Draw(&work->aniFontMain);

    work->saveStatus = DeleteSaveDataMenuDeleteData(work->deleteAllData);

    switch (work->saveStatus)
    {
        // case DELETESAVEDATA_STATUS_SUCCEEDED:
        default:
            FontAnimator__SetMsgSequence(&work->aniFontMain, DELETESAVE_MSGSEQ_SAVE_DATA_DELETED);

            u32 lineCount = FontAnimator__GetDialogLineCount(&work->aniFontMain, 0);
            FontAnimator__AdvanceLine(&work->aniFontMain, 4 * (10 - 2 * lineCount));

            work->timer = 0;
            work->state = DeleteSaveDataMenu_State_DeletedData;
            break;

        case DELETESAVEDATA_STATUS_FAILED:
            FontAnimator__ClearPixels(&work->aniFontMain);
            FontAnimator__Draw(&work->aniFontMain);
            FontWindowAnimator__InitAnimation(&work->fontWindowAnimatorMain, 4, 8, 0, 0);
            FontWindowAnimator__StartAnimating(&work->fontWindowAnimatorMain);

            work->windowOpen = TRUE;
            work->state      = DeleteSaveDataMenu_State_BeginReturnToTitle;
            break;
    }
}

void DeleteSaveDataMenu_State_DeletedData(DeleteSaveDataMenu *work)
{
    FontAnimator__LoadCharacters(&work->aniFontMain, 1);
    FontAnimator__Draw(&work->aniFontMain);

    if (FontAnimator__IsEndOfLine(&work->aniFontMain))
    {
        work->timer++;
        if (work->timer >= 120)
        {
            FontAnimator__ClearPixels(&work->aniFontMain);
            FontAnimator__Draw(&work->aniFontMain);
            FontWindowAnimator__InitAnimation(&work->fontWindowAnimatorMain, 4, 8, 0, 0);
            FontWindowAnimator__StartAnimating(&work->fontWindowAnimatorMain);
            work->windowOpen = TRUE;
            work->state      = DeleteSaveDataMenu_State_BeginReturnToTitle;
        }
    }
}

void DeleteSaveDataMenu_State_CancelSelected(DeleteSaveDataMenu *work)
{
    FontAnimator__LoadCharacters(&work->aniFontMain, 1);
    FontAnimator__Draw(&work->aniFontMain);

    if (FontAnimator__IsEndOfLine(&work->aniFontMain))
    {
        work->timer++;
        if (work->timer >= 120)
        {
            FontAnimator__ClearPixels(&work->aniFontMain);
            FontAnimator__Draw(&work->aniFontMain);
            FontWindowAnimator__InitAnimation(&work->fontWindowAnimatorMain, 4, 8, 0, 0);
            FontWindowAnimator__StartAnimating(&work->fontWindowAnimatorMain);
            work->windowOpen = TRUE;
            work->state      = DeleteSaveDataMenu_State_BeginReturnToTitle;
        }
    }
}

void DeleteSaveDataMenu_State_BeginReturnToTitle(DeleteSaveDataMenu *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fontWindowAnimatorMain);

    if (FontWindowAnimator__IsFinishedAnimating(&work->fontWindowAnimatorMain))
    {
        if (work->windowOpen)
        {
            FontWindowAnimator__SetWindowClosed(&work->fontWindowAnimatorMain);
            work->windowOpen = FALSE;
        }
        else
        {
            FontWindowAnimator__SetWindowOpen(&work->fontWindowAnimatorMain);
            work->state = DeleteSaveDataMenu_State_FadeOut;
        }
    }
}

void DeleteSaveDataMenu_State_FadeOut(DeleteSaveDataMenu *work)
{
    if (renderCoreGFXControlA.brightness > RENDERCORE_BRIGHTNESS_BLACK)
        renderCoreGFXControlA.brightness--;

    renderCoreGFXControlB.brightness = renderCoreGFXControlA.brightness;

    if (renderCoreGFXControlA.brightness == RENDERCORE_BRIGHTNESS_BLACK)
        work->state = NULL;
}

// Selection States
void DeleteSaveDataMenu_StateSelect_Init(DeleteSaveDataMenu *work)
{
    FontAnimator__SetMsgSequence(&work->aniFontSelection, work->msgSelection);
    FontWindowAnimator__Load1(&work->fntWindowSelection, &work->fontWindow, 0, FONTWINDOWANIMATOR_ARC_WIN_SIMPLE, ARCHIVE_WIN_SIMPLE_LZ7_FILE_WIN_SIMPLE_C_BBG, PIXEL_TO_TILE(32),
                              PIXEL_TO_TILE(104), PIXEL_TO_TILE(192), (PIXEL_TO_TILE(16) * FontAnimator__GetDialogLineCount(&work->aniFontSelection, 0)) + PIXEL_TO_TILE(16),
                              GRAPHICS_ENGINE_A, BACKGROUND_2, PALETTE_ROW_2, 512, 0);
    FontWindowAnimator__InitAnimation(&work->fntWindowSelection, 1, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&work->fntWindowSelection);
    FontWindowAnimator__Func_20599B4(&work->fntWindowSelection);

    work->stateSelect = DeleteSaveDataMenu_StateSelect_ShowWindow;
}

void DeleteSaveDataMenu_StateSelect_ShowWindow(DeleteSaveDataMenu *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fntWindowSelection);

    if (FontWindowAnimator__IsFinishedAnimating(&work->fntWindowSelection))
    {
        FontWindowAnimator__SetWindowOpen(&work->fntWindowSelection);

        FontAnimator__LoadCharacters(&work->aniFontSelection, 0);
        FontWindowMWControl__SetPaletteAnim(&work->fontMWControl, 0);
        FontWindowMWControl__ValidatePaletteAnim(&work->fontMWControl);
        FontWindowMWControl__SetPosition(&work->fontMWControl, 40, 16 * work->selection + 112);
        AnimatorSprite__SetAnimation(&work->aniCursor, 0);

        work->stateSelect = DeleteSaveDataMenu_StateSelect_Selecting;
    }
}

void DeleteSaveDataMenu_StateSelect_Selecting(DeleteSaveDataMenu *work)
{
    BOOL selectionChanged = FALSE;
    BOOL cancelled        = FALSE;

    s32 selectionCount = FontAnimator__GetDialogLineCount(&work->aniFontSelection, 0);

    if ((padInput.btnPress & PAD_KEY_UP) != 0)
    {
        if (work->selection > 0)
        {
            work->selection--;
            selectionChanged = TRUE;
        }
    }
    else if ((padInput.btnPress & PAD_KEY_DOWN) != 0)
    {
        if (work->selection < selectionCount - 1)
        {
            work->selection++;
            selectionChanged = TRUE;
        }
    }
    else if ((padInput.btnPress & PAD_BUTTON_B) != 0)
    {
        cancelled = TRUE;
    }

    if (selectionChanged)
    {
        FontWindowMWControl__ValidatePaletteAnim(&work->fontMWControl);
        FontWindowMWControl__SetPosition(&work->fontMWControl, 40, 16 * work->selection + 112);
        AnimatorSprite__SetAnimation(&work->aniCursor, 0);
    }

    FontAnimator__Draw(&work->aniFontSelection);
    FontWindowMWControl__Draw(&work->fontMWControl);
    FontWindowMWControl__CallWindowFunc2(&work->fontMWControl);

    work->aniCursor.pos.x = 40;
    work->aniCursor.pos.y = 120;
    work->aniCursor.pos.y += 16 * work->selection;
    AnimatorSprite__ProcessAnimation(&work->aniCursor, 0, 0);
    AnimatorSprite__DrawFrame(&work->aniCursor);

    if (selectionChanged)
    {
        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CURSOR);
    }
    else if (cancelled)
    {
        FontWindowMWControl__SetPaletteAnim(&work->fontMWControl, 1);
        work->timer       = 0;
        work->stateSelect = DeleteSaveDataMenu_StateSelect_MadeSelection;
        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_CANCEL);
    }
    else if ((padInput.btnPress & PAD_BUTTON_A) != 0)
    {
        FontWindowMWControl__SetPaletteAnim(&work->fontMWControl, 1);
        work->timer       = 0;
        work->stateSelect = DeleteSaveDataMenu_StateSelect_MadeSelection;
        PlaySysMenuNavSfx(SYSSOUND_MENUNAV_DECIDE);
    }
}

void DeleteSaveDataMenu_StateSelect_MadeSelection(DeleteSaveDataMenu *work)
{
    FontWindowMWControl__Draw(&work->fontMWControl);
    FontWindowMWControl__CallWindowFunc2(&work->fontMWControl);
    work->timer++;

    FontAnimator__ClearPixels(&work->aniFontSelection);
    FontAnimator__Draw(&work->aniFontSelection);
    FontWindowAnimator__InitAnimation(&work->fntWindowSelection, 4, 8, 0, 0);
    FontWindowAnimator__StartAnimating(&work->fntWindowSelection);

    work->windowOpen  = TRUE;
    work->stateSelect = DeleteSaveDataMenu_StateSelect_CloseWindow;
}

void DeleteSaveDataMenu_StateSelect_CloseWindow(DeleteSaveDataMenu *work)
{
    FontWindowAnimator__ProcessWindowAnim(&work->fntWindowSelection);

    if (FontWindowAnimator__IsFinishedAnimating(&work->fntWindowSelection))
    {
        if (work->windowOpen)
        {
            FontWindowAnimator__SetWindowClosed(&work->fntWindowSelection);
            work->windowOpen = FALSE;
        }
        else
        {
            FontWindowAnimator__SetWindowOpen(&work->fntWindowSelection);
            FontWindowAnimator__Release(&work->fntWindowSelection);
            work->stateSelect = NULL;
        }
    }
}

// Utils
DeleteSaveDataStatus DeleteSaveDataMenuDeleteData(BOOL deleteAllData)
{
    SaveErrorTypes result;

    if (deleteAllData)
    {
        SaveGame__ClearData(&saveGame, SAVE_BLOCK_FLAG_ALL);
        result = SaveGame__SaveData(&saveGame, SAVE_BLOCK_FLAG_ALL);
    }
    else
    {
        SaveGame__ClearData(&saveGame, SAVE_BLOCK_FLAG_STAGE | SAVE_BLOCK_FLAG_CHART);
        result = SaveGame__SaveData(&saveGame, SAVE_BLOCK_FLAG_ALL);
    }

    return result == SAVE_ERROR_CANT_LOAD ? DELETESAVEDATA_STATUS_FAILED : DELETESAVEDATA_STATUS_SUCCEEDED;
}
