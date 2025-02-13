#include <menu/playerNameMenu.h>
#include <menu/nameMenu.h>
#include <game/game/gameState.h>
#include <game/save/saveManager.h>
#include <game/audio/sysSound.h>
#include <game/graphics/renderCore.h>
#include <game/file/fsRequest.h>
#include <game/system/sysEvent.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void InitPlayerNameMenu(PlayerNameMenu *work);
static void SetupDisplayForPlayerNameMenu(PlayerNameMenu *work);
static void InitPlayerNameMenuFontWindow(PlayerNameMenu *work);
static void InitPlayerNameMenuBackground(PlayerNameMenu *work);
static void InitPlayerNameMenuControl(PlayerNameMenu *work);
static void ReleasePlayerNameMenu(PlayerNameMenu *work);
static void ResetDisplayFromPlayerNameMenu(PlayerNameMenu *work);
static void ReleasePlayerNameMenuFontWindow(PlayerNameMenu *work);
static void ReleasePlayerNameMenuBackground(PlayerNameMenu *work);
static void ReleasePlayerNameMenuControl(PlayerNameMenu *work);
static void PlayerNameMenu_Main(void);
static void PlayerNameMenu_Destructor(Task *task);
static void GetPlayerNameMenuSaveName(SavePlayerName *name);
static BOOL SetPlayerNameMenuSaveName(SavePlayerName *name);

// --------------------
// FUNCTIONS
// --------------------

void CreatePlayerNameMenu(void)
{
    SavePlayerName name;

    Task *task = TaskCreate(PlayerNameMenu_Main, PlayerNameMenu_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(0), PlayerNameMenu);

    PlayerNameMenu *work = TaskGetWork(task, PlayerNameMenu);
    TaskInitWork16(work);

    InitPlayerNameMenu(work);
    ResetTouchInput();

    GetPlayerNameMenuSaveName(&name);
    NameMenu__Create(0, &name, &work->fontWindow);

    LoadSysSoundVillage();
    PlaySysVillageTrack(FALSE);
}

void InitPlayerNameMenu(PlayerNameMenu *work)
{
    SetupDisplayForPlayerNameMenu(work);
    InitPlayerNameMenuFontWindow(work);
    InitPlayerNameMenuBackground(work);
    InitPlayerNameMenuControl(work);
}

void SetupDisplayForPlayerNameMenu(PlayerNameMenu *work)
{
    VRAMSystem__Init(VRAM_MODE_0);

    renderCurrentDisplay = GX_DISP_SELECT_MAIN_SUB;

    if (renderCoreGFXControlA.brightness <= RENDERCORE_BRIGHTNESS_DEFAULT)
    {
        renderCoreGFXControlA.brightness = renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_BLACK;
    }
    else
    {
        renderCoreGFXControlA.brightness = renderCoreGFXControlB.brightness = RENDERCORE_BRIGHTNESS_WHITE;
    }

    GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);
    GX_SetVisiblePlane(GX_PLANEMASK_NONE);

    GXS_SetGraphicsMode(GX_BGMODE_0);
    GXS_SetVisiblePlane(GX_PLANEMASK_NONE);

    MI_CpuClearFast(VRAM_BG, 0x80000);
    MI_CpuClearFast(VRAM_DB_BG, 0x20000);

    MI_CpuClear16(VRAM_BG_PLTT, 0x200);
    MI_CpuClear16(VRAM_DB_BG_PLTT, 0x200);
}

void InitPlayerNameMenuFontWindow(PlayerNameMenu *work)
{
    work->fntAll = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);

    FontWindow__Init(&work->fontWindow);
    FontWindow__LoadFromMemory(&work->fontWindow, work->fntAll, TRUE);
    FontWindow__SetDMA(&work->fontWindow, 0);
}

void InitPlayerNameMenuBackground(PlayerNameMenu *work)
{
    // nothing
}

void InitPlayerNameMenuControl(PlayerNameMenu *work)
{
    NameMenu__LoadAssets();
}

void ReleasePlayerNameMenu(PlayerNameMenu *work)
{
    ReleasePlayerNameMenuControl(work);
    ReleasePlayerNameMenuBackground(work);
    ReleasePlayerNameMenuFontWindow(work);
    ResetDisplayFromPlayerNameMenu(work);
}

void ResetDisplayFromPlayerNameMenu(PlayerNameMenu *work)
{
    // nothing
}

void ReleasePlayerNameMenuFontWindow(PlayerNameMenu *work)
{
    FontWindow__Release(&work->fontWindow);

    if (work->fntAll != NULL)
    {
        HeapFree(HEAP_USER, work->fntAll);
        work->fntAll = NULL;
    }
}

void ReleasePlayerNameMenuBackground(PlayerNameMenu *work)
{
    // nothing
}

void ReleasePlayerNameMenuControl(PlayerNameMenu *work)
{
    NameMenu__ReleaseAssets();
}

void PlayerNameMenu_Main(void)
{
    PlayerNameMenu *work = TaskGetWorkCurrent(PlayerNameMenu);

    if (NameMenu__IsFinished())
    {
        if (NameMenu__ShouldApplyName() && SetPlayerNameMenuSaveName(NameMenu__GetName()) == FALSE)
        {
            DestroyCurrentTask();
            ReleaseSysSound();
            RequestSysEventChange(1); // SYSEVENT_CORRUPT_SAVE_WARNING
            NextSysEvent();
        }
        else
        {
            DestroyCurrentTask();
            gameState.talk.state.hubStartAction = 1;
            RequestSysEventChange(0); // SYSEVENT_RETURN_TO_HUB
            NextSysEvent();
        }
    }
    else
    {
        FontWindow__PrepareSwapBuffer(&work->fontWindow);
    }
}

void PlayerNameMenu_Destructor(Task *task)
{
    PlayerNameMenu *work = TaskGetWork(task, PlayerNameMenu);

    ReleasePlayerNameMenu(work);
}

void GetPlayerNameMenuSaveName(SavePlayerName *name)
{
    MI_CpuCopy16(&saveGame.system.name, name, sizeof(SavePlayerName));
}

BOOL SetPlayerNameMenuSaveName(SavePlayerName *name)
{
    MI_CpuCopy16(name, &saveGame.system.name, sizeof(SavePlayerName));

    return TrySaveGameData(SAVE_TYPE_SYSTEM);
}
