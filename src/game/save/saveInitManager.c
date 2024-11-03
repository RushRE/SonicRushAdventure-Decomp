#include <game/save/saveInitManager.h>
#include <game/save/saveInitMessage.h>
#include <game/system/sysEvent.h>
#include <game/save/saveGame.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/background.h>
#include <game/game/gameState.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void DestroySaveInitManager(void);
static void SetupDisplayForSaveInitManager(void);
static void SaveInitManager_Destructor(Task *task);
static void SaveInitManager_Main_InitSave(void);
static void SaveInitManager_Main_TryLoadSave(void);
static void SaveInitManager_Main_BeginResetSave(void);
static void SaveInitManager_Main_ResettingSave(void);
static void SaveInitManager_Main_BeginLoadSave(void);
static void SaveInitManager_Main_SaveLoading(void);
static void SaveInitManager_Main_PrepareNextEvent(void);
static void SaveInitManager_Main_GoNextEvent(void);

// --------------------
// FUNCTIONS
// --------------------

void CreateSaveInitManager(void)
{
    SetupDisplayForSaveInitManager();

    Task *task = TaskCreate(SaveInitManager_Main_InitSave, SaveInitManager_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x2000, TASK_GROUP(0), SaveInitManager);
    // no null checks, this task is that important!!

    SaveInitManager *work = (SaveInitManager *)TaskGetWork(task, SaveInitManager);
    TaskInitWork16(work);
}

void DestroySaveInitManager(void)
{
    DestroyTaskGroup(TASK_GROUP(1));
    DestroyTaskGroup(TASK_GROUP(0));
}

void SetupDisplayForSaveInitManager(void)
{
    VRAMSystem__Init(VRAM_MODE_0);

    GX_SetPower(GX_POWER_2D);
    GX_SetDispSelect(GX_DISP_SELECT_SUB_MAIN);

    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;

    ((GXRgb *)VRAM_BG_PLTT)[0]    = GX_RGB_888(0x00, 0x00, 0x00);
    ((GXRgb *)VRAM_DB_BG_PLTT)[0] = GX_RGB_888(0x00, 0x00, 0x00);

    renderCoreGFXControlA.windowManager.visible = GX_PLANEMASK_NONE;
    renderCoreGFXControlA.blendManager.blendControl.effect = BLENDTYPE_NONE;
    renderCoreGFXControlA.brightness = RENDERCORE_BRIGHTNESS_DEFAULT;
    renderCoreGFXControlA.mosaicSize = 0;

    GX_SetMasterBrightness(renderCoreGFXControlA.brightness);
    GX_SetBGScrOffset(GX_BGSCROFFSET_0x00000);
    GX_SetBGCharOffset(GX_BGCHAROFFSET_0x00000);
    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);

    G2_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x04000, GX_BG_EXTPLTT_01);
    G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x08000, GX_BG_EXTPLTT_01);

    renderCoreGFXControlA.bgPosition[BACKGROUND_0].x = renderCoreGFXControlA.bgPosition[BACKGROUND_0].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_1].x = renderCoreGFXControlA.bgPosition[BACKGROUND_1].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_2].x = renderCoreGFXControlA.bgPosition[BACKGROUND_2].y = 0;
    renderCoreGFXControlA.bgPosition[BACKGROUND_3].x = renderCoreGFXControlA.bgPosition[BACKGROUND_3].y = 0;

    G2_SetBG0Priority(3);
    G2_SetBG1Priority(2);
    G2_SetBG2Priority(1);
    G2_SetBG3Priority(0);

    GX_SetVisiblePlane(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1 | GX_PLANEMASK_OBJ);
    MI_CpuClear16(VRAMSystem__VRAM_BG[0], HW_VRAM_A_SIZE);

    renderCoreGFXControlB.windowManager.visible = FALSE;
    renderCoreGFXControlB.blendManager.blendControl.effect = BLENDTYPE_NONE;
    renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    renderCoreGFXControlB.mosaicSize = 0;
    GXS_SetMasterBrightness(renderCoreGFXControlB.brightness);
    GXS_SetGraphicsMode(GX_BGMODE_0);
    GXS_SetVisiblePlane(GX_PLANEMASK_BG0);

    MI_CpuClear16(VRAMSystem__VRAM_BG[1], HW_VRAM_A_SIZE);
}

void SaveInitManager_Destructor(Task *task)
{
    UNUSED(task);
}

void SaveInitManager_Main_InitSave(void)
{
    SaveInitManager *work = TaskGetWorkCurrent(SaveInitManager);

    if (SaveGame__InitSaveSize() == FALSE)
    {
        work->saveFailed = TRUE;
        SetCurrentTaskMainEvent(SaveInitManager_Main_PrepareNextEvent);
    }
    else
    {
        SaveGame__ClearData(&saveGame, SAVE_BLOCK_FLAG_ALL);
        SetCurrentTaskMainEvent(SaveInitManager_Main_TryLoadSave);
    }
}

void SaveInitManager_Main_TryLoadSave(void)
{
    SaveInitManager *work = TaskGetWorkCurrent(SaveInitManager);

    switch (SaveGame__LoadData(&saveGame, &work->corruptFlags, &work->saveFlags))
    {
        case SAVE_ERROR_INVALID_FORMAT:
            work->messageDisplayTimer = 0;
            CreateSaveInitMessage(work, GAMEINIT_MSG_REFORMATTING);
            SetCurrentTaskMainEvent(SaveInitManager_Main_BeginResetSave);
            work->saveFailed = FALSE;
            break;

        case SAVE_ERROR_NONE:
            if (work->corruptFlags != 0)
            {
                SaveGame__ClearData(&saveGame, SAVE_BLOCK_FLAG_ALL);
                work->messageDisplayTimer = 0;
                CreateSaveInitMessage(work, GAMEINIT_MSG_CORRUPTED);
                SetCurrentTaskMainEvent(SaveInitManager_Main_BeginResetSave);
            }
            else if (work->saveFlags != 0)
            {
                work->messageDisplayTimer = 60;
                CreateSaveInitMessage(work, GAMEINIT_MSG_LOADING);
                SetCurrentTaskMainEvent(SaveInitManager_Main_BeginLoadSave);
            }
            else
            {
                work->saveFailed = FALSE;
                SetCurrentTaskMainEvent(SaveInitManager_Main_PrepareNextEvent);
            }
            break;

        // case SAVE_ERROR_CANT_LOAD
        default:
            gameState.lastSaveError = GAMESAVE_ERROR_CANT_READ;
            work->saveFailed                 = TRUE;
            SetCurrentTaskMainEvent(SaveInitManager_Main_PrepareNextEvent);
            break;
    }
}

void SaveInitManager_Main_BeginResetSave(void)
{
    SaveInitManager *work = TaskGetWorkCurrent(SaveInitManager);

    if (work->messageReady)
    {
        CreateCreateSaveWorker(&work->saveCreator, 31);
        SetCurrentTaskMainEvent(SaveInitManager_Main_ResettingSave);
    }
}

void SaveInitManager_Main_ResettingSave(void)
{
    SaveInitManager *work = TaskGetWorkCurrent(SaveInitManager);

    if (AwaitCreateSaveCompletion(&work->saveCreator))
    {
        work->saveFailed = GetCreateSaveSuccess(&work->saveCreator) == FALSE;
        SetCurrentTaskMainEvent(SaveInitManager_Main_PrepareNextEvent);
    }
}

void SaveInitManager_Main_BeginLoadSave(void)
{
    SaveInitManager *work = TaskGetWorkCurrent(SaveInitManager);

    if (work->messageReady)
    {
        CreateLoadSaveWorker(&work->saveLoader, work->saveFlags, 31);
        SetCurrentTaskMainEvent(SaveInitManager_Main_SaveLoading);
    }
}

void SaveInitManager_Main_SaveLoading(void)
{
    SaveInitManager *work = TaskGetWorkCurrent(SaveInitManager);

    if (AwaitLoadSaveCompletion(&work->saveLoader))
    {
        work->saveFailed = GetLoadSaveSuccess(&work->saveLoader) == FALSE;
        SetCurrentTaskMainEvent(SaveInitManager_Main_PrepareNextEvent);
    }
}

void SaveInitManager_Main_PrepareNextEvent(void)
{
    SaveInitManager *work = TaskGetWorkCurrent(SaveInitManager);

    ResetGameState();

    s32 nextEvent;
    if (work->saveFailed)
        nextEvent = 2; // SYSEVENT_CORRUPT_SAVE_WARNING
    else if ((RenderCore_GetResetParam() & RENDERCORE_RESETPARAM_FLAG) != 0)
        nextEvent = 1; // player has reset the game, show then the opening (SYSEVENT_OPENING)
    else
        nextEvent = 0; // cold boot, show the player the splash screens (SYSEVENT_SPLASH_SCREEN)

    if ((u16)nextEvent <= 1 && !SaveGame__HandlePlayerVsDisconnect())
        nextEvent = 2; // SYSEVENT_CORRUPT_SAVE_WARNING

    RequestSysEventChange(nextEvent);
    work->eventChangeTimer = 30;
    SetCurrentTaskMainEvent(SaveInitManager_Main_GoNextEvent);
}

void SaveInitManager_Main_GoNextEvent(void)
{
    SaveInitManager *work = TaskGetWorkCurrent(SaveInitManager);

    if (work->messageReady)
    {
        if (work->messageDisplayTimer != 0)
            work->messageDisplayTimer--;
        else
            work->messageFinished = TRUE;
    }
    else
    {
        if (work->eventChangeTimer != 0)
        {
            work->eventChangeTimer--;
        }
        else
        {
            DestroySaveInitManager();
            NextSysEvent();
        }
    }
}