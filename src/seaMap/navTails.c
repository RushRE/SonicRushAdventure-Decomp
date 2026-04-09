#include <seaMap/navTails.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/vramSystem.h>
#include <game/file/fsRequest.h>
#include <game/file/binaryBundle.h>
#include <game/text/messageController.h>
#include <game/graphics/background.h>
#include <game/graphics/swapBuffer3D.h>
#include <game/save/saveGame.h>
#include <seaMap/seaMapEventManager.h>
#include <seaMap/seaMapManager.h>

// resources
#include <resources/bb/nv.h>
#include <resources/bb/nv/nav_assets.h>

// --------------------
// CONSTANTS
// --------------------

#define NAVTAILS_BG_VRAM_BLOCK_SIZE 0x800

// --------------------
// ENUMS
// --------------------

enum NavTailsSeaMapIcon
{
    NAVTAILS_SEAMAPICON_SOUTHERN_ISLAND,
    NAVTAILS_SEAMAPICON_PLANT_KINGDOM,
    NAVTAILS_SEAMAPICON_MACHINE_LABYRINTH,
    NAVTAILS_SEAMAPICON_CORAL_CAVE,
    NAVTAILS_SEAMAPICON_HAUNTED_SHIP,
    NAVTAILS_SEAMAPICON_BLIZZARD_PEAKS,
    NAVTAILS_SEAMAPICON_SKY_BABYLON,
    NAVTAILS_SEAMAPICON_PIRATES_ISLAND,
    NAVTAILS_SEAMAPICON_BIG_SWELL,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_1,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_2,
    NAVTAILS_SEAMAPICON_DAIKUN_ISLAND,
    NAVTAILS_SEAMAPICON_KYLOK_ISLAND,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_3,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_4,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_5,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_6,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_7,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_8,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_9,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_10,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_11,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_12,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_13,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_14,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_15,
    NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_16,

    NAVTAILS_SEAMAPICON_COUNT,
};

enum NavTailsAnimIDs
{
    NV_ANI_ICON_JET_UNLOCKED,
    NV_ANI_ICON_JET_LOCKED,
    NV_ANI_ICON_BOAT_UNLOCKED,
    NV_ANI_ICON_BOAT_LOCKED,
    NV_ANI_ICON_HOVER_UNLOCKED,
    NV_ANI_ICON_HOVER_LOCKED,
    NV_ANI_ICON_SUBMARINE_UNLOCKED,
    NV_ANI_ICON_SUBMARINE_LOCKED,
    NV_ANI_SHIP_ICON_WINDOW,
    NV_ANI_SHIP_ICON_BG,
    NV_ANI_PLAYERICON_SONIC,
    NV_ANI_PLAYERICON_SONIC_BLAZE,
    NV_ANI_ICON_SOUTHERN_ISLAND,
    NV_ANI_ICON_PLANT_KINGDOM,
    NV_ANI_ICON_MACHINE_LABYRINTH,
    NV_ANI_ICON_CORAL_CAVE,
    NV_ANI_ICON_HAUNTED_SHIP,
    NV_ANI_ICON_BLIZZARD_PEAKS,
    NV_ANI_ICON_SKY_BABYLON,
    NV_ANI_ICON_PIRATES_ISLAND,
    NV_ANI_ICON_BIG_SWELL,
    NV_ANI_ICON_HIDDEN_ISLAND_1,
    NV_ANI_ICON_HIDDEN_ISLAND_2,
    NV_ANI_ICON_HIDDEN_ISLAND_3,
    NV_ANI_ICON_HIDDEN_ISLAND_4,
    NV_ANI_ICON_HIDDEN_ISLAND_5,
    NV_ANI_ICON_HIDDEN_ISLAND_6,
    NV_ANI_ICON_HIDDEN_ISLAND_7,
    NV_ANI_ICON_HIDDEN_ISLAND_8,
    NV_ANI_ICON_HIDDEN_ISLAND_9,
    NV_ANI_ICON_HIDDEN_ISLAND_10,
    NV_ANI_ICON_HIDDEN_ISLAND_11,
    NV_ANI_ICON_HIDDEN_ISLAND_12,
    NV_ANI_ICON_HIDDEN_ISLAND_13,
    NV_ANI_ICON_HIDDEN_ISLAND_14,
    NV_ANI_ICON_HIDDEN_ISLAND_15,
    NV_ANI_ICON_HIDDEN_ISLAND_16,
    NV_ANI_ICON_KYLOK_ISLAND,
    NV_ANI_ICON_DAIKUN_ISLAND,
    NV_ANI_LIFENUMBER_0,
    NV_ANI_LIFENUMBER_1,
    NV_ANI_LIFENUMBER_2,
    NV_ANI_LIFENUMBER_3,
    NV_ANI_LIFENUMBER_4,
    NV_ANI_LIFENUMBER_5,
    NV_ANI_LIFENUMBER_6,
    NV_ANI_LIFENUMBER_7,
    NV_ANI_LIFENUMBER_8,
    NV_ANI_LIFENUMBER_9,
    NV_ANI_LIFE_X,
    NV_ANI_TALK_ICON_DRAW_MARKER,
    NV_ANI_TALK_ICON_OK_BUTTON,
    NV_ANI_TALK_ICON_CANCEL_BUTTON,
    NV_ANI_TALK_ICON_NAV_BUTTON,
    NV_ANI_TALK_ICON_UNKNOWN_BUTTON,
};

// --------------------
// STRUCTS
// --------------------

typedef struct NavTailsShipIconConfig_
{
    u16 animID;
    u16 paletteRow;
    s16 x;
    s16 y;
} NavTailsShipIconConfig;

typedef struct NavTailsSeaMapIconConfig_
{
    u16 animID;
    u16 paletteRow;
} NavTailsSeaMapIconConfig;

typedef struct NavTailsAnimConfig3_
{
    u16 animID;
    u16 paletteRow;
    s16 advance;
} NavTailsTalkIconComment;

// --------------------
// VARIABLES
// --------------------

static Task *sNavTailsTaskSingleton;

static const AnimatorFlags sShipIconBgFlags[SHIP_COUNT_DRILL] = {
    [SHIP_JET]       = ANIMATOR_FLAG_DISABLE_LOOPING,                                               // Formatting Comment
    [SHIP_BOAT]      = ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_FLIP_X,                        // Formatting Comment
    [SHIP_HOVER]     = ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_FLIP_Y,                        // Formatting Comment
    [SHIP_SUBMARINE] = ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_FLIP_X | ANIMATOR_FLAG_FLIP_Y, // Formatting Comment
    [SHIP_DRILL]     = ANIMATOR_FLAG_DISABLE_DRAW | ANIMATOR_FLAG_DISABLE_LOOPING,                  // Formatting Comment
};

FORCE_INCLUDE_ARRAY(void *, sDisplayControl_1, 2, { &reg_GX_DISPCNT, &reg_GXS_DB_DISPCNT })

static const NavTailsTalkIconComment sTalkSpriteList[] = {
    { NV_ANI_TALK_ICON_DRAW_MARKER, PALETTE_ROW_7, 16 }, { NV_ANI_TALK_ICON_OK_BUTTON, PALETTE_ROW_7, 40 },      { NV_ANI_TALK_ICON_CANCEL_BUTTON, PALETTE_ROW_7, 40 },
    { NV_ANI_TALK_ICON_NAV_BUTTON, PALETTE_ROW_7, 21 },  { NV_ANI_TALK_ICON_UNKNOWN_BUTTON, PALETTE_ROW_7, 21 },
};

static const NavTailsShipIconConfig sShipIconConfigList[SHIP_COUNT] = {
    [SHIP_JET]       = { NV_ANI_ICON_JET_UNLOCKED, PALETTE_ROW_0, 30, 18 },       // Formatting Comment
    [SHIP_BOAT]      = { NV_ANI_ICON_BOAT_UNLOCKED, PALETTE_ROW_1, 86, 18 },      // Formatting Comment
    [SHIP_HOVER]     = { NV_ANI_ICON_HOVER_UNLOCKED, PALETTE_ROW_2, 30, 50 },     // Formatting Comment
    [SHIP_SUBMARINE] = { NV_ANI_ICON_SUBMARINE_UNLOCKED, PALETTE_ROW_3, 86, 50 }, // Formatting Comment
};

static const NavTailsSeaMapIconConfig sSeaMapIconConfigList[NAVTAILS_SEAMAPICON_COUNT] = {
    [NAVTAILS_SEAMAPICON_SOUTHERN_ISLAND]   = { NV_ANI_ICON_SOUTHERN_ISLAND, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_PLANT_KINGDOM]     = { NV_ANI_ICON_PLANT_KINGDOM, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_MACHINE_LABYRINTH] = { NV_ANI_ICON_MACHINE_LABYRINTH, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_CORAL_CAVE]        = { NV_ANI_ICON_CORAL_CAVE, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HAUNTED_SHIP]      = { NV_ANI_ICON_HAUNTED_SHIP, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_BLIZZARD_PEAKS]    = { NV_ANI_ICON_BLIZZARD_PEAKS, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_SKY_BABYLON]       = { NV_ANI_ICON_SKY_BABYLON, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_PIRATES_ISLAND]    = { NV_ANI_ICON_PIRATES_ISLAND, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_BIG_SWELL]         = { NV_ANI_ICON_BIG_SWELL, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_1]   = { NV_ANI_ICON_HIDDEN_ISLAND_1, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_2]   = { NV_ANI_ICON_HIDDEN_ISLAND_2, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_DAIKUN_ISLAND]     = { NV_ANI_ICON_DAIKUN_ISLAND, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_KYLOK_ISLAND]      = { NV_ANI_ICON_KYLOK_ISLAND, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_3]   = { NV_ANI_ICON_HIDDEN_ISLAND_3, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_4]   = { NV_ANI_ICON_HIDDEN_ISLAND_4, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_5]   = { NV_ANI_ICON_HIDDEN_ISLAND_5, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_6]   = { NV_ANI_ICON_HIDDEN_ISLAND_6, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_7]   = { NV_ANI_ICON_HIDDEN_ISLAND_7, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_8]   = { NV_ANI_ICON_HIDDEN_ISLAND_8, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_9]   = { NV_ANI_ICON_HIDDEN_ISLAND_9, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_10]  = { NV_ANI_ICON_HIDDEN_ISLAND_10, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_11]  = { NV_ANI_ICON_HIDDEN_ISLAND_11, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_12]  = { NV_ANI_ICON_HIDDEN_ISLAND_12, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_13]  = { NV_ANI_ICON_HIDDEN_ISLAND_13, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_14]  = { NV_ANI_ICON_HIDDEN_ISLAND_14, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_15]  = { NV_ANI_ICON_HIDDEN_ISLAND_15, PALETTE_ROW_6 },
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_16]  = { NV_ANI_ICON_HIDDEN_ISLAND_16, PALETTE_ROW_6 },
};

static const u32 sSeaMapIconDiscoverList[NAVTAILS_SEAMAPICON_COUNT] = {
    [NAVTAILS_SEAMAPICON_SOUTHERN_ISLAND]   = SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND,
    [NAVTAILS_SEAMAPICON_PLANT_KINGDOM]     = SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM,
    [NAVTAILS_SEAMAPICON_MACHINE_LABYRINTH] = SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH,
    [NAVTAILS_SEAMAPICON_CORAL_CAVE]        = SEAMAPMANAGER_DISCOVER_CORAL_CAVE,
    [NAVTAILS_SEAMAPICON_HAUNTED_SHIP]      = SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP,
    [NAVTAILS_SEAMAPICON_BLIZZARD_PEAKS]    = SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS,
    [NAVTAILS_SEAMAPICON_SKY_BABYLON]       = SEAMAPMANAGER_DISCOVER_SKY_BABYLON,
    [NAVTAILS_SEAMAPICON_PIRATES_ISLAND]    = SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND,
    [NAVTAILS_SEAMAPICON_BIG_SWELL]         = SEAMAPMANAGER_DISCOVER_BIG_SWELL,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_1]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_2]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2,
    [NAVTAILS_SEAMAPICON_DAIKUN_ISLAND]     = SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND,
    [NAVTAILS_SEAMAPICON_KYLOK_ISLAND]      = SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_3]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_4]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_5]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_6]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_7]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_8]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_9]   = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_10]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_11]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_12]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_13]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_14]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_15]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15,
    [NAVTAILS_SEAMAPICON_HIDDEN_ISLAND_16]  = SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void NavTails_Main(void);
static void NavTails_Destructor(Task *task);
static void NavTails_Draw(NavTails *work);

// Helpers
static NavTails *GetNavTailsWork(void);
static void SetupDisplayForNavTails(GraphicsEngine graphicsEngine);
static void InitNavTailsSprites(NavTails *work);
static void ReleaseNavTailsSprites(NavTails *work);
static void ReleaseNavTailsTalkIconSprites(NavTails *work);
static void SetNavTailsLifeAnimators(NavTails *work, s32 num);
static u8 GetLivesForNavTails(void);
static void SetNewNavTailsBackground(NavTails *work, NavTailsSprite id);
static void LoadNavTailsFont(NavTails *work, FontWindow *window);
static void SetNavTailsWindowMode(NavTails *work, BOOL enabled);
static s32 GetNavTailsWindowForDialog(NavTails *work);
static void LoadNavTailsAssets(NavTailsAssets *assets);
static void ReleaseNavTailsAssets(NavTailsAssets *assets);
static void LoadNavTailsTailsSprite(NavTailsAssets *assets, NavTailsSprite id);
static void InitNavTailsBG_Nav(NavTails *work);
static void InitNavTailsBG_Tails(NavTails *work);
static void InitNavTailsBG_MsgWindow(NavTails *work, s32 id);
static void ClearNavTailsBackground(NavTails *work);
static void NavTails_FontCallback(u32 type, FontAnimator *animator, void *context);

// talk states
static void NavTails_StateTalk_Speaking(NavTails *work);
static void NavTails_StateTalk_SpeakDelay(NavTails *work);

// dma states
static void NavTails_StateDMA_Idle(NavTails *work);
static void NavTails_StateDMA_PrepareChange(NavTails *work);
static void NavTails_StateDMA_HideOldBackground(NavTails *work);
static void NavTails_StateDMA_LoadNewTailsSprite(NavTails *work);
static void NavTails_StateDMA_ShowNewBackground(NavTails *work);
static void NavTails_StateDMA_EndChange(NavTails *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateNavTails(GraphicsEngine graphicsEngine, u32 shipType, FontWindow *window)
{
    Task *task             = TaskCreate(NavTails_Main, NavTails_Destructor, TASK_FLAG_NONE, 0, 0x100, TASK_GROUP(0), NavTails);
    sNavTailsTaskSingleton = task;

    NavTails *work = TaskGetWork(task, NavTails);
    TaskInitWork16(work);

    work->graphicsEngine = graphicsEngine;
    work->shipType       = shipType;
    work->stateTalk      = NavTails_StateTalk_Speaking;
    work->stateDMA       = NavTails_StateDMA_Idle;

    LoadNavTailsAssets(&work->assets);
    SetupDisplayForNavTails(graphicsEngine);
    InitNavTailsSprites(work);
    LoadNavTailsFont(work, window);
    LoadNavTailsTailsSprite(&work->assets, NAVTAILS_SPRITE_NONE);
    work->dma.tailsBackgroundID = NAVTAILS_SPRITE_NONE;
    InitNavTailsBG_Nav(work);
    InitNavTailsBG_Tails(work);
    InitNavTailsBG_MsgWindow(work, 0);
}

void DestroyNavTails(void)
{
    if (IsNavTailsActive())
    {
        DestroyTask(sNavTailsTaskSingleton);
        sNavTailsTaskSingleton = NULL;
    }
}

BOOL IsNavTailsActive(void)
{
    return sNavTailsTaskSingleton != NULL;
}

void NavTailsSpeak(u16 msgSequence, u16 duration)
{
    NavTails *work = GetNavTailsWork();

    if (msgSequence != FontAnimator__GetCurrentSequence(&work->fontAnimator))
    {
        FontAnimator__SetMsgSequence(&work->fontAnimator, msgSequence);
        work->speakDelay    = 0;
        work->speakDuration = duration;

        if (msgSequence != NAVTAILS_MSGSEQ_NONE)
        {
            if (work->windowMode)
            {
                if (work->messageWindowID != GetNavTailsWindowForDialog(work))
                {
                    InitNavTailsBG_MsgWindow(work, GetNavTailsWindowForDialog(work));
                }
            }
        }
        else
        {
            SetNavTailsWindowMode(work, FALSE);
        }

        ReleaseNavTailsTalkIconSprites(work);

        work->stateTalk = NavTails_StateTalk_SpeakDelay;
        work->stateTalk(work);
    }
}

u16 GetNavTailsActiveSpeakMsg(void)
{
    NavTails *work = GetNavTailsWork();
    return MessageController__GetCurrentSequence(&work->fontAnimator.msgControl);
}

BOOL CheckNavTailsLastDialog(void)
{
    NavTails *work = GetNavTailsWork();
    return FontAnimator__IsLastDialog(&work->fontAnimator);
}

void NavTails_Main(void)
{
    NavTails *work = TaskGetWorkCurrent(NavTails);

    work->stateTalk(work);
    work->stateDMA(work);

    if (!work->usingFontWindowPtr)
        FontWindow__PrepareSwapBuffer(work->fontWindow);

    NavTails_Draw(work);
}

void NavTails_Destructor(Task *task)
{
    NavTails *work = TaskGetWork(task, NavTails);

    RenderCore_StopDMA(1);
    ReleaseNavTailsAssets(&work->assets);
    ReleaseNavTailsSprites(work);
    FontAnimator__Release(&work->fontAnimator);

    if (!work->usingFontWindowPtr)
        FontWindow__Release(work->fontWindow);

    if (work->fontFileData != NULL)
        HeapFree(HEAP_USER, work->fontFileData);

    sNavTailsTaskSingleton = NULL;
}

void NavTails_Draw(NavTails *work)
{
    s32 i;

    AnimatorSprite__DrawFrame(&work->aniWindowElements[0]);

    for (i = 0; i < 4; i++)
    {
        AnimatorSprite__DrawFrame(&work->aniShipIcon[i]);
    }

    AnimatorSprite__ProcessAnimationFast(&work->aniWindowElements[1]);
    AnimatorSprite__DrawFrame(&work->aniWindowElements[1]);
    AnimatorSprite__DrawFrame(&work->aniPlayerIcon);

    if (work->lives != GetLivesForNavTails())
    {
        SetNavTailsLifeAnimators(work, GetLivesForNavTails());
    }

    AnimatorSprite__DrawFrame(&work->aniWindowElements[2]);
    AnimatorSprite__DrawFrame(&work->aniLifeNumbers[0]);
    AnimatorSprite__DrawFrame(&work->aniLifeNumbers[1]);

    for (i = 0; i < 27; i++)
    {
        AnimatorSprite__DrawFrame(&work->aniChart[i]);
    }

    for (i = 0; i < 5; i++)
    {
        if (work->aniTalkIcon[i].vramPixels != NULL)
            AnimatorSprite__DrawFrame(&work->aniTalkIcon[i]);
    }
}

NavTails *GetNavTailsWork(void)
{
    return TaskGetWork(sNavTailsTaskSingleton, NavTails);
}

void SetupDisplayForNavTails(GraphicsEngine graphicsEngine)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[graphicsEngine];

    if (graphicsEngine == GRAPHICS_ENGINE_A)
    {
        GX_SetGraphicsMode(GX_DISPMODE_GRAPHICS, GX_BGMODE_0, GX_BG0_AS_2D);

        G2_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_23);
        G2_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_23);
        G2_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x04000);
        G2_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1800, GX_BG_CHARBASE_0x08000);

        G2_SetBG0Priority(0);
        G2_SetBG1Priority(1);
        G2_SetBG2Priority(2);
        G2_SetBG3Priority(3);

        VRAMSystem__SetupOBJBank(GX_GetBankForOBJ(), GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);
    }
    else
    {
        GXS_SetGraphicsMode(GX_BGMODE_0);

        G2S_SetBG0Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0000, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_23);
        G2S_SetBG1Control(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x0800, GX_BG_CHARBASE_0x00000, GX_BG_EXTPLTT_23);
        G2S_SetBG2ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_256, GX_BG_SCRBASE_0x1000, GX_BG_CHARBASE_0x04000);
        G2S_SetBG3ControlText(GX_BG_SCRSIZE_TEXT_256x256, GX_BG_COLORMODE_16, GX_BG_SCRBASE_0x1800, GX_BG_CHARBASE_0x08000);

        G2S_SetBG0Priority(0);
        G2S_SetBG1Priority(1);
        G2S_SetBG2Priority(2);
        G2S_SetBG3Priority(3);

        VRAMSystem__SetupSubOBJBank(GX_GetBankForSubOBJ(), GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);
    }

    MI_CpuClear32(&gfxControl->bgPosition, sizeof(gfxControl->bgPosition));
    MI_CpuClear16(&gfxControl->windowManager, sizeof(gfxControl->windowManager));
    MI_CpuClear16(&gfxControl->blendManager, sizeof(gfxControl->blendManager));
    MI_CpuClear16(&gfxControl->mosaicSize, sizeof(gfxControl->mosaicSize));

    if (graphicsEngine == GRAPHICS_ENGINE_A)
        GX_SetVisiblePlane(GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);
    else
        GXS_SetVisiblePlane(GX_PLANEMASK_BG2 | GX_PLANEMASK_BG3 | GX_PLANEMASK_OBJ);
}

// Using 'volatile GraphicsEngine' matches this function, but breaks others... so lets just cast to 'volatile GraphicsEngine' when we match
#ifdef NON_MATCHING
#define GetGraphicsEngine(work) (work)->graphicsEngine
#else
struct NavTailsMatcher_
{
    volatile GraphicsEngine graphicsEngine;
};

#define GetGraphicsEngine(work) ((struct NavTailsMatcher_ *)(work))->graphicsEngine
#endif

void InitNavTailsSprites(NavTails *work)
{
    int graphicsEngine;
    void *sprNav;
    u16 anim;
    s32 i;
    AnimatorSprite *aniSprite;

    sprNav         = work->assets.sprNav;
    graphicsEngine = work->graphicsEngine;

    aniSprite = &work->aniWindowElements[0];
    AnimatorSprite__Init(aniSprite, sprNav, NV_ANI_SHIP_ICON_WINDOW, ANIMATOR_FLAG_NONE, graphicsEngine, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(graphicsEngine, Sprite__GetSpriteSize1FromAnim(sprNav, NV_ANI_SHIP_ICON_WINDOW)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GetGraphicsEngine(work)]), SPRITE_PRIORITY_3, SPRITE_ORDER_16);
    aniSprite->cParam.palette = PALETTE_ROW_4;
    aniSprite->pos.x          = 8;
    aniSprite->pos.y          = 100;
    AnimatorSprite__ProcessAnimationFast(aniSprite);

    aniSprite = &work->aniWindowElements[1];
    AnimatorSprite__Init(aniSprite, sprNav, NV_ANI_SHIP_ICON_BG, sShipIconBgFlags[work->shipType], graphicsEngine, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(graphicsEngine, Sprite__GetSpriteSize1FromAnim(sprNav, NV_ANI_SHIP_ICON_BG)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GetGraphicsEngine(work)]), SPRITE_PRIORITY_3, SPRITE_ORDER_14);
    aniSprite->cParam.palette = PALETTE_ROW_4;

    if (work->shipType != SHIP_MENU)
    {
        aniSprite->pos.x = sShipIconConfigList[work->shipType].x + 8;
        aniSprite->pos.y = sShipIconConfigList[work->shipType].y + 100;
    }
    AnimatorSprite__ProcessAnimationFast(aniSprite);

    aniSprite = &work->aniWindowElements[2];
    AnimatorSprite__Init(aniSprite, sprNav, NV_ANI_LIFE_X, ANIMATOR_FLAG_NONE, graphicsEngine, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(graphicsEngine, Sprite__GetSpriteSize1FromAnim(sprNav, NV_ANI_LIFE_X)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GetGraphicsEngine(work)]), SPRITE_PRIORITY_3, SPRITE_ORDER_15);
    aniSprite->cParam.palette = PALETTE_ROW_5;
    aniSprite->pos.x          = 70;
    aniSprite->pos.y          = 180;
    AnimatorSprite__ProcessAnimationFast(aniSprite);

    aniSprite = &work->aniPlayerIcon;
    u16 playerIconAnim;
    if (SaveGame__BlazeUnlocked())
        playerIconAnim = NV_ANI_PLAYERICON_SONIC_BLAZE;
    else
        playerIconAnim = NV_ANI_PLAYERICON_SONIC;

    AnimatorSprite__Init(aniSprite, sprNav, playerIconAnim, ANIMATOR_FLAG_NONE, graphicsEngine, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(graphicsEngine, Sprite__GetSpriteSize1FromAnim(sprNav, playerIconAnim)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GetGraphicsEngine(work)]), SPRITE_PRIORITY_3, SPRITE_ORDER_15);
    aniSprite->cParam.palette = PALETTE_ROW_5;
    aniSprite->pos.x          = 54;
    aniSprite->pos.y          = 174;
    AnimatorSprite__ProcessAnimationFast(aniSprite);

    for (i = 0; i < SHIP_COUNT; i++)
    {
        const NavTailsShipIconConfig *configShip = &sShipIconConfigList[i];
        aniSprite                                = &work->aniShipIcon[i];

        anim = configShip->animID;
        if (SaveGame__IsShipUnlocked((u16)i) == FALSE)
            anim++;

        AnimatorSprite__Init(aniSprite, sprNav, anim, ANIMATOR_FLAG_NONE, graphicsEngine, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(graphicsEngine, Sprite__GetSpriteSize1FromAnim(sprNav, anim)), PALETTE_MODE_SPRITE,
                             VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GetGraphicsEngine(work)]), SPRITE_PRIORITY_3, SPRITE_ORDER_13);
        aniSprite->cParam.palette = configShip->paletteRow;
        aniSprite->pos.x          = configShip->x + 8;
        aniSprite->pos.y          = configShip->y + 100;
        AnimatorSprite__ProcessAnimationFast(aniSprite);
    }

    for (i = 0; i < 2; i++)
    {
        aniSprite = &work->aniLifeNumbers[i];

        AnimatorSprite__Init(aniSprite, sprNav, NV_ANI_LIFENUMBER_0, ANIMATOR_FLAG_NONE, graphicsEngine, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(graphicsEngine, Sprite__GetSpriteSize1FromAnim(sprNav, NV_ANI_LIFENUMBER_0)), PALETTE_MODE_SPRITE,
                             VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GetGraphicsEngine(work)]), SPRITE_PRIORITY_3, SPRITE_ORDER_15);
        aniSprite->cParam.palette = PALETTE_ROW_5;
        aniSprite->pos.x          = 76 + (8 * i);
        aniSprite->pos.y          = 180;
    }

    SetNavTailsLifeAnimators(work, GetLivesForNavTails());

    for (i = 0; i < 27; i++)
    {
        const NavTailsSeaMapIconConfig *configChart = &sSeaMapIconConfigList[i];
        aniSprite                                   = &work->aniChart[i];

        AnimatorSprite__Init(aniSprite, sprNav, configChart->animID, ANIMATOR_FLAG_NONE, graphicsEngine, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(graphicsEngine, Sprite__GetSpriteSize1FromAnim(sprNav, configChart->animID)), PALETTE_MODE_SPRITE,
                             VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[GetGraphicsEngine(work)]), SPRITE_PRIORITY_3, SPRITE_ORDER_16);
        aniSprite->cParam.palette = configChart->paletteRow;
        AnimatorSprite__ProcessAnimationFast(aniSprite);

        if (SeaMapEventManager_CheckIslandUnlocked(sSeaMapIconDiscoverList[i]) == FALSE)
        {
            aniSprite->flags |= ANIMATOR_FLAG_DISABLE_DRAW;
        }
    }
}

void ReleaseNavTailsSprites(NavTails *work)
{
    s32 i;

    for (i = 0; i < 3; i++)
    {
        AnimatorSprite__Release(&work->aniWindowElements[i]);
    }

    AnimatorSprite__Release(&work->aniPlayerIcon);

    for (i = 0; i < 4; i++)
    {
        AnimatorSprite__Release(&work->aniShipIcon[i]);
    }

    for (i = 0; i < 2; i++)
    {
        AnimatorSprite__Release(&work->aniLifeNumbers[i]);
    }

    for (i = 0; i < 27; i++)
    {
        AnimatorSprite__Release(&work->aniChart[i]);
    }

    ReleaseNavTailsTalkIconSprites(work);
}

void ReleaseNavTailsTalkIconSprites(NavTails *work)
{
    for (s32 i = 0; i < 5; i++)
    {
        AnimatorSprite__Release(&work->aniTalkIcon[i]);
    }

    MI_CpuClear16(work->aniTalkIcon, sizeof(work->aniTalkIcon));
}

void SetNavTailsLifeAnimators(NavTails *work, s32 num)
{
    u16 digit1 = FX_DivS32(num, 10) + NV_ANI_LIFENUMBER_0;
    AnimatorSprite__SetAnimation(&work->aniLifeNumbers[0], digit1);
    AnimatorSprite__ProcessAnimationFast(&work->aniLifeNumbers[0]);

    u32 digit2 = (num + NV_ANI_LIFENUMBER_0);
    digit2 -= 10 * (digit1 - NV_ANI_LIFENUMBER_0);
    AnimatorSprite__SetAnimation(&work->aniLifeNumbers[1], digit2);
    AnimatorSprite__ProcessAnimationFast(&work->aniLifeNumbers[1]);

    work->lives = num;
}

u8 GetLivesForNavTails(void)
{
    return saveGame.stage.status.lives;
}

void SetNewNavTailsBackground(NavTails *work, NavTailsSprite id)
{
    if (id != work->dma.tailsBackgroundID)
    {
        work->dma.tailsBackgroundID = id;
        work->stateDMA              = NavTails_StateDMA_PrepareChange;
    }
}

void LoadNavTailsFont(NavTails *work, FontWindow *window)
{
    if (window != NULL)
    {
        work->fontWindow         = window;
        work->usingFontWindowPtr = TRUE;
    }
    else
    {
        work->fontWindow         = &work->_fontWindow;
        work->usingFontWindowPtr = FALSE;

        FontWindow__Init(work->fontWindow);
        work->fontFileData = FSRequestFileSync("fnt/font_all.fnt", FSREQ_AUTO_ALLOC_HEAD);
        FontWindow__LoadFromMemory(work->fontWindow, work->fontFileData, FALSE);
    }

    FontAnimator__Init(&work->fontAnimator);
    FontAnimator__LoadFont1(&work->fontAnimator, work->fontWindow, 0, PIXEL_TO_TILE(0), PIXEL_TO_TILE(0), PIXEL_TO_TILE(160), PIXEL_TO_TILE(80), work->graphicsEngine, BACKGROUND_0,
                            PALETTE_ROW_15, 296);
    FontAnimator__LoadMPCFile(&work->fontAnimator, work->assets.mpcText);
    FontAnimator__SetCallbackType(&work->fontAnimator, 8);
    ClearNavTailsBackground(work);
    FontAnimator__LoadMappingsFunc(&work->fontAnimator);
    FontAnimator__LoadPaletteFunc(&work->fontAnimator);
    FontAnimator__SetCallback(&work->fontAnimator, NavTails_FontCallback, work);
}

void SetNavTailsWindowMode(NavTails *work, BOOL enabled)
{
    if (enabled)
    {
        if (work->graphicsEngine == GRAPHICS_ENGINE_A)
        {
            GX_SetVisiblePlane(GX_GetVisiblePlane() | (GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1));
        }
        else
        {
            GXS_SetVisiblePlane(GXS_GetVisiblePlane() | (GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1));
        }
    }
    else
    {
        if (work->graphicsEngine == GRAPHICS_ENGINE_A)
        {
            GX_SetVisiblePlane(GX_GetVisiblePlane() & ~(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1));
        }
        else
        {
            GXS_SetVisiblePlane(GXS_GetVisiblePlane() & ~(GX_PLANEMASK_BG0 | GX_PLANEMASK_BG1));
        }
    }

    work->windowMode = enabled;
}

s32 GetNavTailsWindowForDialog(NavTails *work)
{
    u32 seqCount          = FontAnimator__GetSequenceDialogCount(&work->fontAnimator);
    u32 requiredLineCount = 0;

    for (u16 i = 0; i < seqCount; i++)
    {
        u32 lineCount = FontAnimator__GetDialogLineCount(&work->fontAnimator, i);
        if (requiredLineCount < lineCount)
            requiredLineCount = lineCount;
    }

    switch (requiredLineCount)
    {
        case 0:
        case 1:
        case 2:
        case 3:
            return 0;

        case 4:
            return 1;

        case 5:
            return 2;
    }

    return 0;
}

void LoadNavTailsAssets(NavTailsAssets *assets)
{
    NNSFndArchive arc;

    MI_CpuClear16(assets, sizeof(*assets));

    GetCompressedFileFromBundle("bb/nv.bb", BUNDLE_NV_FILE_RESOURCES_BB_NV_NAV_ASSETS_NARC, &assets->archiveNv, TRUE, FALSE);
    NNS_FndMountArchive(&arc, "nv", assets->archiveNv);

    assets->sprNav = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_NAV_ASSETS_FILE_NV_BAC);
    assets->bgNav  = NNS_FndGetArchiveFileByIndex(&arc, ARCHIVE_NAV_ASSETS_FILE_NV_BG_BBG);
    for (s32 i = 0; i < 4; i++)
    {
        assets->bgMsgWindow[i] = NNS_FndGetArchiveFileByIndex(&arc, i + ARCHIVE_NAV_ASSETS_FILE_NV_MSG_WIN_3_BBG);
    }

    s32 textFileID;
    switch (GetGameLanguage())
    {
        case OS_LANGUAGE_JAPANESE:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_JPN_MPC;
            break;

        case OS_LANGUAGE_ENGLISH:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_ENG_MPC;
            break;

        case OS_LANGUAGE_FRENCH:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_FRA_MPC;
            break;

        case OS_LANGUAGE_GERMAN:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_DEU_MPC;
            break;

        case OS_LANGUAGE_ITALIAN:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_ITA_MPC;
            break;

        case OS_LANGUAGE_SPANISH:
            textFileID = ARCHIVE_NAV_ASSETS_FILE_NV_MSG_MAIN_SPA_MPC;
            break;
    }

    assets->mpcText = NNS_FndGetArchiveFileByIndex(&arc, textFileID);
    NNS_FndUnmountArchive(&arc);
}

void ReleaseNavTailsAssets(NavTailsAssets *assets)
{
    HeapFree(HEAP_USER, assets->archiveNv);

    if (assets->bgTails != NULL)
    {
        HeapFree(HEAP_USER, assets->bgTails);
        assets->bgTails = NULL;
    }

    MI_CpuClear16(assets, sizeof(*assets));
}

void LoadNavTailsTailsSprite(NavTailsAssets *assets, u32 id)
{
    static u16 const tailsBackgroundFileID[NAVTAILS_SPRITE_COUNT - NAVTAILS_SPRITE_ID_OFFSET] = {
        [NAVTAILS_SPRITE_NONE - NAVTAILS_SPRITE_ID_OFFSET]      = BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_1_BBG,
        [NAVTAILS_SPRITE_IDLE - NAVTAILS_SPRITE_ID_OFFSET]      = BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_2_BBG,
        [NAVTAILS_SPRITE_EXPLAIN - NAVTAILS_SPRITE_ID_OFFSET]   = BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_3_BBG,
        [NAVTAILS_SPRITE_CONFUSED - NAVTAILS_SPRITE_ID_OFFSET]  = BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_4_BBG,
        [NAVTAILS_SPRITE_GOOD_LUCK - NAVTAILS_SPRITE_ID_OFFSET] = BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_5_BBG,
        [NAVTAILS_SPRITE_GUIDE - NAVTAILS_SPRITE_ID_OFFSET]     = BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_6_BBG,
        [NAVTAILS_SPRITE_DENY - NAVTAILS_SPRITE_ID_OFFSET]      = BUNDLE_NV_FILE_RESOURCES_BB_NV_BG_NAV_7_BBG
    };

    if (assets->tailsSpriteID != id)
    {
        if (assets->bgTails != NULL)
        {
            HeapFree(HEAP_USER, assets->bgTails);
            assets->bgTails = NULL;
        }

        assets->bgTails       = ReadFileFromBundle("bb/nv.bb", tailsBackgroundFileID[id], BINARYBUNDLE_AUTO_ALLOC_HEAD);
        assets->tailsSpriteID = id;
    }
}

void InitNavTailsBG_Nav(NavTails *work)
{
    Background background;

    void *bgAsset = work->assets.bgNav;
    InitBackground(&background, bgAsset, BACKGROUND_FLAG_LOAD_ALL, work->graphicsEngine, BACKGROUND_3, GetBackgroundWidth(bgAsset), GetBackgroundHeight(bgAsset));
    DrawBackground(&background);
}

void InitNavTailsBG_Tails(NavTails *work)
{
    Background background;

    void *bgAsset = work->assets.bgTails;
    InitBackground(&background, bgAsset, BACKGROUND_FLAG_LOAD_MAPPINGS_PIXELS | BACKGROUND_FLAG_DISABLE_PALETTE, work->graphicsEngine, BACKGROUND_2, GetBackgroundWidth(bgAsset),
                   GetBackgroundHeight(bgAsset));
    DrawBackground(&background);
}

void InitNavTailsBG_MsgWindow(NavTails *work, s32 id)
{
    static Vec2U16 const messageWindowPos[4] = {
        { -12, -16 },
        { -12, -16 },
        { -12, -16 },
        { -12, -16 },
    };

    Background background;

    void *bgAsset = work->assets.bgMsgWindow[id];
    InitBackground(&background, bgAsset, BACKGROUND_FLAG_LOAD_MAPPINGS_PIXELS | BACKGROUND_FLAG_DISABLE_PALETTE, work->graphicsEngine, BACKGROUND_1, GetBackgroundWidth(bgAsset),
                   GetBackgroundHeight(bgAsset));
    background.vramPixels = background.vramPixels + (4 * NAVTAILS_BG_VRAM_BLOCK_SIZE);
    DrawBackground(&background);

    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->graphicsEngine];

    gfxControl->bgPosition[BACKGROUND_0].x = messageWindowPos[id].x;
    gfxControl->bgPosition[BACKGROUND_0].y = messageWindowPos[id].y;
    work->messageWindowID                  = id;
}

void ClearNavTailsBackground(NavTails *work)
{
    MappingsMode mappingsMode;
    u16 screenBaseA;
    u16 screenBaseBlock;

    GetVRAMTileConfig(work->graphicsEngine, BACKGROUND_0, &mappingsMode, &screenBaseA, &screenBaseBlock);

    int baseBlock = 0x10000 * screenBaseA + NAVTAILS_BG_VRAM_BLOCK_SIZE * screenBaseBlock;
    MI_CpuFill16(VRAMSystem__VRAM_BG[work->graphicsEngine] + baseBlock, 0x100, NAVTAILS_BG_VRAM_BLOCK_SIZE);
}

void NavTails_FontCallback(u32 type, FontAnimator *animator, void *context)
{
    void *sprNav;
    NavTails *work = (NavTails *)context;
    const NavTailsTalkIconComment *config;
    AnimatorSprite *aniIcon;
    GraphicsEngine graphicsEngine;
    RenderCoreGFXControl *gfxControl;
    u32 id;

    graphicsEngine = work->graphicsEngine;
    sprNav         = work->assets.sprNav;

    if (type >= 10 && type <= 14)
    {
        id = type - 10;

        config  = &sTalkSpriteList[id];
        aniIcon = &work->aniTalkIcon[id];

        AnimatorSprite__Init(aniIcon, sprNav, config->animID, ANIMATOR_FLAG_NONE, graphicsEngine, PIXEL_MODE_SPRITE,
                             VRAMSystem__AllocSpriteVram(graphicsEngine, Sprite__GetSpriteSize1FromAnim(sprNav, config->animID)), PALETTE_MODE_SPRITE,
                             VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[graphicsEngine]), SPRITE_PRIORITY_0, SPRITE_ORDER_10);
        aniIcon->cParam.palette = config->paletteRow;
        AnimatorSprite__ProcessAnimationFast(aniIcon);

        gfxControl = VRAMSystem__GFXControl[graphicsEngine];

        FontAnimator__GetMsgPosition(animator, &aniIcon->pos.x, &aniIcon->pos.y);
        aniIcon->pos.x -= gfxControl->bgPosition[BACKGROUND_0].x;
        aniIcon->pos.y -= gfxControl->bgPosition[BACKGROUND_0].y;
        FontAnimator__AdvanceXPos(animator, config->advance);
    }
    else if (type >= 15 && type <= 20)
    {
        id = type - (15 - NAVTAILS_SPRITE_ID_OFFSET);

        SetNewNavTailsBackground(work, id);
    }
}

void NavTails_StateTalk_Speaking(NavTails *work)
{
    if (work->windowMode != 0 && work->speakDuration != 0)
    {
        work->speakDuration--;
        if (work->speakDuration == 0)
        {
            if (GetNavTailsActiveSpeakMsg() != NAVTAILS_MSGSEQ_NONE)
            {
                NavTailsSpeak(NAVTAILS_MSGSEQ_NONE, 1);
            }
            else
            {
                SetNavTailsWindowMode(work, FALSE);
                ReleaseNavTailsTalkIconSprites(work);
            }
        }
    }
}

void NavTails_StateTalk_SpeakDelay(NavTails *work)
{
    if (work->speakDelay == 0)
    {
        FontAnimator__LoadCharacters(&work->fontAnimator, 1);
        FontAnimator__Draw(&work->fontAnimator);

        if (GetNavTailsActiveSpeakMsg() != NAVTAILS_MSGSEQ_NONE && work->windowMode == 0)
        {
            InitNavTailsBG_MsgWindow(work, GetNavTailsWindowForDialog(work));
            SetNavTailsWindowMode(work, TRUE);
        }

        work->speakDelay = 0;
        if (FontAnimator__IsLastDialog(&work->fontAnimator))
            work->stateTalk = NavTails_StateTalk_Speaking;
    }
    else
    {
        work->speakDelay--;
    }
}

void NavTails_StateDMA_Idle(NavTails *work)
{
    // Do Nothing.
}

void NavTails_StateDMA_PrepareChange(NavTails *work)
{
    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[work->graphicsEngine];
    RenderCore_SetWnd0InsidePlane(&gfxControl->windowManager, GX_WND_PLANEMASK_OBJ | GX_WND_PLANEMASK_BG3 | GX_WND_PLANEMASK_BG2 | GX_WND_PLANEMASK_BG1 | GX_WND_PLANEMASK_BG0,
                                  TRUE);
    RenderCore_SetWndOutsidePlane(&gfxControl->windowManager, GX_WND_PLANEMASK_OBJ | GX_WND_PLANEMASK_BG3 | GX_WND_PLANEMASK_BG1 | GX_WND_PLANEMASK_BG0, TRUE);
    RenderCore_SetWindow0Position(&gfxControl->windowManager, 128, 0, HW_LCD_WIDTH, HW_LCD_HEIGHT);
    gfxControl->windowManager.visible = GX_WNDMASK_W0;

    u32 windowRegisters[2] = { REG_WIN0H_ADDR, REG_DB_WIN0H_ADDR };

    RenderCore_StopDMA(1);
    MI_CpuFill16(work->dma.buffer, DMA_ENABLE, sizeof(work->dma.buffer));
    RenderCore_PrepareDMA(1, &work->dma.buffer[0], work->dma.buffer[1], (void *)windowRegisters[work->graphicsEngine], ARRAY_COUNT(windowRegisters));

    struct NavTailsDMA *dma = &work->dma;
    dma->updateID           = 0;
    dma->timer              = 0;

    work->stateDMA = NavTails_StateDMA_HideOldBackground;
}

void NavTails_StateDMA_HideOldBackground(NavTails *work)
{
    u16 *dmaSrc      = RenderCore_GetDMASrc(1);
    BOOL changeState = FALSE;

    struct NavTailsDMA *dma = &work->dma;

    dma->timer++;
    if (dma->timer != 0)
    {
        dma->updateID++;
        if (dma->updateID < 8)
        {
            for (s32 i = 0; i < HW_LCD_HEIGHT; i++)
            {
                if (dma->updateID < (i & 7))
                    dmaSrc[i] = DMA_ENABLE;
                else
                    dmaSrc[i] = DMA_ENABLE | DMA_SRC_DEC | 0x01;
            }
        }
        else
        {
            MI_CpuFill16(dmaSrc, DMA_ENABLE | DMA_SRC_DEC | 0x01, sizeof(dma->buffer[0]));
            changeState = TRUE;
        }

        dma->timer = 0;
        RenderCore_PrepareDMASwapBuffer(1);
    }

    if (changeState)
        work->stateDMA = NavTails_StateDMA_LoadNewTailsSprite;
}

void NavTails_StateDMA_LoadNewTailsSprite(NavTails *work)
{
    LoadNavTailsTailsSprite(&work->assets, work->dma.tailsBackgroundID);
    InitNavTailsBG_Tails(work);

    struct NavTailsDMA *dma = &work->dma;
    dma->updateID           = 0;
    dma->timer              = 0;

    work->stateDMA = NavTails_StateDMA_ShowNewBackground;
}

void NavTails_StateDMA_ShowNewBackground(NavTails *work)
{
    u16 *dmaSrc      = RenderCore_GetDMASrc(1);
    BOOL changeState = FALSE;

    struct NavTailsDMA *dma = &work->dma;

    dma->timer++;
    if (dma->timer != 0)
    {
        dma->updateID++;
        if (dma->updateID < 8)
        {
            for (s32 i = 0; i < HW_LCD_HEIGHT; i++)
            {
                if (dma->updateID <= 7 - (i & 7))
                    dmaSrc[i] = DMA_ENABLE | DMA_SRC_DEC | 0x01;
                else
                    dmaSrc[i] = DMA_ENABLE;
            }
        }
        else
        {
            MI_CpuFill16(dmaSrc, DMA_ENABLE, sizeof(dma->buffer[0]));
            changeState = TRUE;
        }

        dma->timer = 0;
        RenderCore_PrepareDMASwapBuffer(1);
    }

    if (changeState)
        work->stateDMA = NavTails_StateDMA_EndChange;
}

void NavTails_StateDMA_EndChange(NavTails *work)
{
    RenderCore_StopDMA(1);

    VRAMSystem__GFXControl[work->graphicsEngine]->windowManager.visible = GX_WNDMASK_NONE;
    work->stateDMA                                                      = NavTails_StateDMA_Idle;
}

// --------------------
// UNREFERENCED VARS
// --------------------

FORCE_INCLUDE_ARRAY(void *, sDisplayControl_2, 2, { &reg_GX_DISPCNT, &reg_GXS_DB_DISPCNT })