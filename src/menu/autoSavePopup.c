#include <menu/autoSavePopup.h>
#include <game/system/sysEvent.h>
#include <game/file/archiveFile.h>
#include <game/file/fileUnknown.h>
#include <game/file/binaryBundle.h>
#include <game/save/saveManager.h>
#include <game/graphics/renderCore.h>

// resources
#include <resources/bb/dmta_menu.h>
#include <resources/bb/dmta_menu/eng.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void InitAutoSavePopup(AutoSavePopup *work);
static void SetupDisplayForAutoSavePopup(AutoSavePopup *work);
static void LoadAutoSavePopupAssets(AutoSavePopup *work);
static void InitAutoSavePopupButtons(AutoSavePopup *work);
static void ReleaseAutoSavePopup(AutoSavePopup *work);
static void ResetDisplayFromAutoSavePopup(AutoSavePopup *work);
static void ReleaseAutoSavePopupAssets(AutoSavePopup *work);
static void ReleaseAutoSavePopupButtons(AutoSavePopup *work);
static void AutoSavePopup_Main_OpenWindow(void);
static void AutoSavePopup_Main_TrySave(void);
static void AutoSavePopup_Main_CloseWindow(void);
static void AutoSavePopup_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

void CreateAutoSavePopup(void)
{
    Task *task = TaskCreate(AutoSavePopup_Main_OpenWindow, AutoSavePopup_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(0), AutoSavePopup);

    AutoSavePopup *work = TaskGetWork(task, AutoSavePopup);
    TaskInitWork32(work);

    work->saveFailed = FALSE;
    InitAutoSavePopup(work);
}

void InitAutoSavePopup(AutoSavePopup *work)
{
    SetupDisplayForAutoSavePopup(work);
    LoadAutoSavePopupAssets(work);
    InitAutoSavePopupButtons(work);
}

void SetupDisplayForAutoSavePopup(AutoSavePopup *work)
{
    GX_SetVisiblePlane(GX_PLANEMASK_OBJ);
    GXS_SetVisiblePlane(GX_PLANEMASK_OBJ);

    VRAMSystem__Init(VRAM_MODE_0);
    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);
    GXS_SetGraphicsMode(GX_BGMODE_0);

    ((GXRgb *)VRAM_DB_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);
    ((GXRgb *)VRAM_BG_PLTT)[0]    = GX_RGB_888(0x00, 0x00, 0x00);

    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    renderCoreGFXControlA.brightness = renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_DEFAULT;
}

void LoadAutoSavePopupAssets(AutoSavePopup *work)
{
    work->fntAll = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);

    void *archive      = ReadFileFromBundle("bb/dmta_menu.bb", BUNDLE_DMTA_MENU_FILE_RESOURCES_BB_DMTA_MENU_JPN_NARC + GetGameLanguage(), BINARYBUNDLE_AUTO_ALLOC_TAIL);
    work->mpcDmta_lang = ArchiveFileUnknown__GetFileFromMemArchive(archive, ARCHIVE_ENG_FILE_DMTA_LANG_MPC, FILEUNKNOWN_AUTO_ALLOC_HEAD);
    HeapFree(HEAP_USER, archive);
}

void InitAutoSavePopupButtons(AutoSavePopup *work)
{
    FontWindow__Init(&work->fontWindow);
    FontWindow__LoadFromMemory(&work->fontWindow, work->fntAll, TRUE);

    SaveSpriteButton__Func_206515C(&work->spriteButton);
    SaveSpriteButton__Func_20651D4(&work->spriteButton, 3, 0, 0, 0, 0, &work->fontWindow, work->mpcDmta_lang, 0, 0, 2);
}

void ReleaseAutoSavePopup(AutoSavePopup *work)
{
    ReleaseAutoSavePopupButtons(work);
    ReleaseAutoSavePopupAssets(work);
    ResetDisplayFromAutoSavePopup(work);
}

void ResetDisplayFromAutoSavePopup(AutoSavePopup *work)
{
    GX_SetVisiblePlane(GX_PLANEMASK_NONE);
    GXS_SetVisiblePlane(GX_PLANEMASK_NONE);

    renderCoreGFXControlA.brightness = renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_BLACK;
}

void ReleaseAutoSavePopupAssets(AutoSavePopup *work)
{
    if (work->mpcDmta_lang != NULL)
    {
        HeapFree(HEAP_USER, work->mpcDmta_lang);
        work->mpcDmta_lang = NULL;
    }

    if (work->fntAll != NULL)
    {
        HeapFree(HEAP_USER, work->fntAll);
        work->fntAll = NULL;
    }
}

void ReleaseAutoSavePopupButtons(AutoSavePopup *work)
{
    SaveSpriteButton__Func_20651A4(&work->spriteButton);
    FontWindow__Release(&work->fontWindow);
}

void AutoSavePopup_Main_OpenWindow(void)
{
    AutoSavePopup *work = TaskGetWorkCurrent(AutoSavePopup);

    SaveSpriteButton__RunState2(&work->spriteButton);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    if (SaveSpriteButton__CheckState2Thing(&work->spriteButton))
        SetCurrentTaskMainEvent(AutoSavePopup_Main_TrySave);
}

void AutoSavePopup_Main_TrySave(void)
{
    AutoSavePopup *work = TaskGetWorkCurrent(AutoSavePopup);

    SaveSpriteButton__RunState2(&work->spriteButton);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    work->saveFailed = TrySaveGameData(SAVE_TYPE_ALL) == FALSE;
    SaveSpriteButton__Func_206546C(&work->spriteButton);

    SetCurrentTaskMainEvent(AutoSavePopup_Main_CloseWindow);
}

void AutoSavePopup_Main_CloseWindow(void)
{
    AutoSavePopup *work = TaskGetWorkCurrent(AutoSavePopup);

    SaveSpriteButton__RunState2(&work->spriteButton);
    FontWindow__PrepareSwapBuffer(&work->fontWindow);

    if (SaveSpriteButton__CheckInvalidState2(&work->spriteButton))
    {
        BOOL failed = work->saveFailed;
        DestroyCurrentTask();
        if (failed)
            RequestSysEventChange(1); // SYSEVENT_CORRUPT_SAVE_WARNING
        else
            RequestSysEventChange(0); // SYSEVENT_SPLASH_SCREEN
        NextSysEvent();
    }
}

void AutoSavePopup_Destructor(Task *task)
{
    AutoSavePopup *work = TaskGetWork(task, AutoSavePopup);

    ReleaseAutoSavePopup(work);
}
