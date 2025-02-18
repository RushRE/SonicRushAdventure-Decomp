#include <seaMap/seaMapCourseChangeView.h>
#include <seaMap/seaMapChartCourseView.h>
#include <seaMap/navTails.h>
#include <seaMap/seaMapCollision.h>
#include <game/input/touchInput.h>
#include <game/system/sysEvent.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/renderCore.h>
#include <game/game/gameState.h>
#include <game/save/saveGame.h>
#include <sail/vikingCupManager.h>
#include <hub/dockCommon.h>

// --------------------
// VARIABLES
// --------------------

Vec2Fx32 SeaMapCourseChangeView_shipPosition;

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapCourseChangeView_Main(void);
static void SeaMapCourseChangeView_Destructor(Task *task);
static void SeaMapCourseChangeView_Destroy(SeaMapCourseChangeView *work);
static void SeaMapCourseChangeView_RunState(SeaMapCourseChangeView *work);
static void InitDisplayForSeaMapCourseChangeView(void);
static void SeaMapCourseChangeView_State_Setup(SeaMapCourseChangeView *work);
static void SeaMapCourseChangeView_State_FadeIn(SeaMapCourseChangeView *work);
static void SeaMapCourseChangeView_State_Active(SeaMapCourseChangeView *work);
static void SeaMapCourseChangeView_State_FadeOut(SeaMapCourseChangeView *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapCourseChangeView(void)
{
    ReleaseAudioSystem();
    LoadAudioSndArc("snd/sys/sound_data.sdat");
    NNS_SndArcLoadGroup(SND_SYS_GROUP_CHART, audioManagerSndHeap);

    LoadSpriteButtonCursorSprite();
    LoadSpriteButtonTouchpadSprite();

    Task *task =
        TaskCreate(SeaMapCourseChangeView_Main, SeaMapCourseChangeView_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(0), SeaMapCourseChangeView);

    SeaMapCourseChangeView *work = TaskGetWork(task, SeaMapCourseChangeView);
    TaskInitWork16(work);

    work->state = SeaMapCourseChangeView_State_Setup;

    InitDisplayForSeaMapCourseChangeView();
    SeaMapChartCourseView__Create(FALSE, gameState.sailShipType, 1);
    SeaMapManager__Func_20444E8();

    u16 nodeY, nodeX;
    fx32 inY, inX;
    u16 y, x;
    while (TRUE)
    {
        SeaMapManager__Func_2045BF8(seaMapViewUnknown2 - SeaMapCourseChangeView_02134174, &inX, &inY);
        SeaMapManager__Func_2043B60(inX, inY, &nodeX, &nodeY);
        if (!SeaMapCollision__Collide(nodeX, nodeY, TRUE))
            break;

        seaMapViewUnknown2 -= FLOAT_TO_FX32(0.5);

        if (SeaMapCourseChangeView_02134174 > seaMapViewUnknown2)
        {
            seaMapViewUnknown2 = SeaMapCourseChangeView_02134174;
            break;
        }
    }

    SeaMapManager__Func_2045BF8(seaMapViewUnknown2 - SeaMapCourseChangeView_02134174, &SeaMapCourseChangeView_shipPosition.x, &SeaMapCourseChangeView_shipPosition.y);
    SeaMapManager__RemoveAllNodes();
    SeaMapView__Func_203DCE0(SeaMapCourseChangeView_shipPosition.x, SeaMapCourseChangeView_shipPosition.y);

    SeaMapManager__Func_2043B28(SeaMapCourseChangeView_shipPosition.x, SeaMapCourseChangeView_shipPosition.y, &x, &y);
    SeaMapManager__AddNode(x, y);

    SeaMapEventManager__CreateObject(SEAMAPOBJECT_BOAT_ICON, FX32_TO_WHOLE(SeaMapCourseChangeView_shipPosition.x), FX32_TO_WHOLE(SeaMapCourseChangeView_shipPosition.y), 0, 0, 0);

    CreateNavTails(TRUE, gameState.sailShipType, NULL);

    PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_CHART);

    ResetTouchInput();
}

void SeaMapCourseChangeView_Main(void)
{
    SeaMapCourseChangeView *work = TaskGetWorkCurrent(SeaMapCourseChangeView);

    work->state(work);

    if (!work->destroyQueued)
        SeaMapCourseChangeView_RunState(work);
    else
        SeaMapCourseChangeView_Destroy(work);
}

void SeaMapCourseChangeView_Destructor(Task *task)
{
    SeaMapCourseChangeView *work = TaskGetWork(task, SeaMapCourseChangeView);
    UNUSED(work);

    ReleaseAudioSystem();
}

void SeaMapCourseChangeView_Destroy(SeaMapCourseChangeView *work)
{
    SeaMapChartCourseView__Destroy();
    ReleaseSpriteButtonCursorSprite();
    ReleaseSpriteButtonTouchpadSprite();
    DestroyCurrentTask();

    switch (SeaMapView__Func_203DCB4())
    {
        case 1:
            SaveGame__SetProgressType(SAVE_PROGRESSTYPE_2);
            RequestSysEventChange(0); // SYSEVENT_SAILING
            break;

        case 2:
            VikingCupManager__Func_2063C40();
            gameState.talk.state.hubStartAction = HUB_STARTACTION_NONE;
            RequestSysEventChange(1); // SYSEVENT_RETURN_TO_HUB
            break;
    }

    NextSysEvent();
}

void SeaMapCourseChangeView_RunState(SeaMapCourseChangeView *work)
{
    // Do nothing.
}

void InitDisplayForSeaMapCourseChangeView(void)
{
    VRAMSystem__Reset();

    VRAMSystem__SetupBGBank(GX_VRAM_BG_128_D);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_32_FG, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);

    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);

    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;
}

void SeaMapCourseChangeView_State_Setup(SeaMapCourseChangeView *work)
{
    work->state = SeaMapCourseChangeView_State_FadeIn;
}

void SeaMapCourseChangeView_State_FadeIn(SeaMapCourseChangeView *work)
{
    BOOL done = TRUE;
    for (s32 i = 0; i < GRAPHICS_ENGINE_COUNT; i++)
    {
        RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[i];

        if (gfxControl->brightness > 0)
        {
            gfxControl->brightness--;
        }
        else if (gfxControl->brightness < 0)
        {
            gfxControl->brightness++;
        }

        if (gfxControl->brightness != RENDERCORE_BRIGHTNESS_DEFAULT)
            done = FALSE;
    }

    if (done)
        work->state = SeaMapCourseChangeView_State_Active;
}

void SeaMapCourseChangeView_State_Active(SeaMapCourseChangeView *work)
{
    if (SeaMapChartCourseView__Func_2040978() == FALSE)
    {
        NNS_SndPlayerStopSeqBySeqNo(SND_SYS_SEQ_SEQ_CHART, 16);
        work->state = SeaMapCourseChangeView_State_FadeOut;
    }
}

void SeaMapCourseChangeView_State_FadeOut(SeaMapCourseChangeView *work)
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