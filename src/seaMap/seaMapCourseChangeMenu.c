#include <seaMap/seaMapCourseChangeMenu.h>
#include <seaMap/seaMapChartCourseView.h>
#include <seaMap/navTails.h>
#include <seaMap/seaMapCollision.h>
#include <game/input/touchInput.h>
#include <game/system/sysEvent.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/renderCore.h>
#include <game/game/gameState.h>
#include <game/save/saveGame.h>
#include <sail/sailInitEvent.h>
#include <hub/dockCommon.h>

// --------------------
// VARIABLES
// --------------------

Vec2Fx32 gSeaMapCourseChangeMenu_shipPosition;

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapCourseChangeMenu_Main(void);
static void SeaMapCourseChangeMenu_Destructor(Task *task);

static void DestroySeaMapCourseChangeMenu(SeaMapCourseChangeMenu *work);

static void SeaMapCourseChangeMenu_DrawText(SeaMapCourseChangeMenu *work);

static void InitDisplayForSeaMapCourseChangeMenu(void);

static void SeaMapCourseChangeMenu_State_Init(SeaMapCourseChangeMenu *work);
static void SeaMapCourseChangeMenu_State_FadeIn(SeaMapCourseChangeMenu *work);
static void SeaMapCourseChangeMenu_State_Active(SeaMapCourseChangeMenu *work);
static void SeaMapCourseChangeMenu_State_FadeOut(SeaMapCourseChangeMenu *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapCourseChangeMenu(void)
{
    ReleaseAudioSystem();
    LoadAudioSndArc("snd/sys/sound_data.sdat");
    NNS_SndArcLoadGroup(SND_SYS_GROUP_CHART, gAudioManagerSndHeap);

    LoadSpriteButtonCursorSprite();
    LoadSpriteButtonTouchpadSprite();

    Task *task =
        TaskCreate(SeaMapCourseChangeMenu_Main, SeaMapCourseChangeMenu_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(0), SeaMapCourseChangeMenu);

    SeaMapCourseChangeMenu *work = TaskGetWork(task, SeaMapCourseChangeMenu);
    TaskInitWork16(work);

    work->state = SeaMapCourseChangeMenu_State_Init;

    InitDisplayForSeaMapCourseChangeMenu();
    CreateSeaMapChartCourseView(GRAPHICS_ENGINE_A, gameState.sailShipType, SEAMAPCHARTCOURSEVIEW_TYPE_CHANGE_COURSE);
    SeaMapManager__LoadNodeList();

    u16 nodeY, nodeX;
    fx32 inY, inX;
    u16 y, x;
    while (TRUE)
    {
        SeaMapManager__Func_2045BF8(gSeaMapViewStoredVoyageDist - SeaMapCourseChangeMenu_02134174, &inX, &inY);
        SeaMapManager__Func_2043B60(inX, inY, &nodeX, &nodeY);
        if (SeaMapCollision__Collide(nodeX, nodeY, TRUE) == FALSE)
            break;

        gSeaMapViewStoredVoyageDist -= FLOAT_TO_FX32(0.5);

        if (SeaMapCourseChangeMenu_02134174 > gSeaMapViewStoredVoyageDist)
        {
            gSeaMapViewStoredVoyageDist = SeaMapCourseChangeMenu_02134174;
            break;
        }
    }

    SeaMapManager__Func_2045BF8(gSeaMapViewStoredVoyageDist - SeaMapCourseChangeMenu_02134174, &gSeaMapCourseChangeMenu_shipPosition.x, &gSeaMapCourseChangeMenu_shipPosition.y);
    SeaMapManager__RemoveAllNodes();
    SetSeaMapViewPosition(gSeaMapCourseChangeMenu_shipPosition.x, gSeaMapCourseChangeMenu_shipPosition.y);

    SeaMapManager__Func_2043B28(gSeaMapCourseChangeMenu_shipPosition.x, gSeaMapCourseChangeMenu_shipPosition.y, &x, &y);
    SeaMapManager__AddNode(x, y);

    SeaMapEventManager_CreateObject(SEAMAPOBJECT_BOAT_ICON, FX32_TO_WHOLE(gSeaMapCourseChangeMenu_shipPosition.x), FX32_TO_WHOLE(gSeaMapCourseChangeMenu_shipPosition.y), 0, NULL, 0);

    CreateNavTails(GRAPHICS_ENGINE_B, gameState.sailShipType, NULL);

    PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_CHART);

    ResetTouchInput();
}

void SeaMapCourseChangeMenu_Main(void)
{
    SeaMapCourseChangeMenu *work = TaskGetWorkCurrent(SeaMapCourseChangeMenu);

    work->state(work);

    if (!work->destroyQueued)
        SeaMapCourseChangeMenu_DrawText(work);
    else
        DestroySeaMapCourseChangeMenu(work);
}

void SeaMapCourseChangeMenu_Destructor(Task *task)
{
    SeaMapCourseChangeMenu *work = TaskGetWork(task, SeaMapCourseChangeMenu);
    UNUSED(work);

    ReleaseAudioSystem();
}

void DestroySeaMapCourseChangeMenu(SeaMapCourseChangeMenu *work)
{
    DestroySeaMapChartCourseView();
    ReleaseSpriteButtonCursorSprite();
    ReleaseSpriteButtonTouchpadSprite();
    DestroyCurrentTask();

    switch (GetSeaMapViewExitEvent())
    {
        case SEAMAPVIEW_EXIT_CONFIRM:
            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_BEGIN_SAILING);
            RequestSysEventChange(0); // SYSEVENT_SAILING
            break;

        case SEAMAPVIEW_EXIT_BACK:
            ResetSailState();
            gameState.talk.state.hubStartAction = HUB_STARTACTION_NONE;
            RequestSysEventChange(1); // SYSEVENT_RETURN_TO_HUB
            break;
    }

    NextSysEvent();
}

void SeaMapCourseChangeMenu_DrawText(SeaMapCourseChangeMenu *work)
{
    // Do nothing, there's no text to draw.
}

void InitDisplayForSeaMapCourseChangeMenu(void)
{
    VRAMSystem__Reset();

    VRAMSystem__SetupBGBank(GX_VRAM_BG_128_D);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_32_FG, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);

    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);

    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;
}

void SeaMapCourseChangeMenu_State_Init(SeaMapCourseChangeMenu *work)
{
    work->state = SeaMapCourseChangeMenu_State_FadeIn;
}

void SeaMapCourseChangeMenu_State_FadeIn(SeaMapCourseChangeMenu *work)
{
    BOOL done = TRUE;
    for (s32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
    {
        RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[i];

        if (gfxControl->brightness > RENDERCORE_BRIGHTNESS_DEFAULT)
        {
            gfxControl->brightness--;
        }
        else if (gfxControl->brightness < RENDERCORE_BRIGHTNESS_DEFAULT)
        {
            gfxControl->brightness++;
        }

        if (gfxControl->brightness != RENDERCORE_BRIGHTNESS_DEFAULT)
            done = FALSE;
    }

    if (done)
        work->state = SeaMapCourseChangeMenu_State_Active;
}

void SeaMapCourseChangeMenu_State_Active(SeaMapCourseChangeMenu *work)
{
    if (IsSeaMapChartCourseViewFinished() == FALSE)
    {
        NNS_SndPlayerStopSeqBySeqNo(SND_SYS_SEQ_SEQ_CHART, 16);
        work->state = SeaMapCourseChangeMenu_State_FadeOut;
    }
}

void SeaMapCourseChangeMenu_State_FadeOut(SeaMapCourseChangeMenu *work)
{
    BOOL done = TRUE;
    for (s32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
    {
        RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[i];

        if (gfxControl->brightness > RENDERCORE_BRIGHTNESS_BLACK)
        {
            gfxControl->brightness--;
            done = FALSE;
        }
    }

    if (done)
        work->destroyQueued = TRUE;
}