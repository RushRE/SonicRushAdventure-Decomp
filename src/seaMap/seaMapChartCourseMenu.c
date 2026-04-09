#include <seaMap/seaMapChartCourseMenu.h>
#include <seaMap/navTails.h>
#include <seaMap/seaMapChartCourseView.h>
#include <game/graphics/renderCore.h>
#include <game/audio/audioSystem.h>
#include <game/system/sysEvent.h>
#include <game/game/gameState.h>
#include <game/save/saveGame.h>
#include <hub/dockCommon.h>

// --------------------
// FUNCTIONS
// --------------------

static void SeaMapChartCourseMenu_Main(void);
static void SeaMapChartCourseMenu_Destructor(Task *task);
static void DestroySeaMapChartCourseMenu(SeaMapChartCourseMenu *work);
static void SeaMapChartCourseMenu_DrawText(SeaMapChartCourseMenu *work);
static void InitDisplayForSeaMapChartCourseMenu(void);
static void SeaMapChartCourseMenu_State_Init(SeaMapChartCourseMenu *work);
static void SeaMapChartCourseMenu_State_FadeIn(SeaMapChartCourseMenu *work);
static void SeaMapChartCourseMenu_State_Active(SeaMapChartCourseMenu *work);
static void SeaMapChartCourseMenu_State_FadeOut(SeaMapChartCourseMenu *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapChartCourseMenu(void)
{
    ReleaseAudioSystem();
    LoadAudioSndArc("snd/sys/sound_data.sdat");
    NNS_SndArcLoadGroup(SND_SYS_GROUP_CHART, gAudioManagerSndHeap);

    LoadSpriteButtonCursorSprite();
    LoadSpriteButtonTouchpadSprite();

    Task *task = TaskCreate(SeaMapChartCourseMenu_Main, SeaMapChartCourseMenu_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(0), SeaMapChartCourseMenu);

    SeaMapChartCourseMenu *work = TaskGetWork(task, SeaMapChartCourseMenu);
    TaskInitWork16(work);

    work->state = SeaMapChartCourseMenu_State_Init;

    InitDisplayForSeaMapChartCourseMenu();

    CreateSeaMapChartCourseView(GRAPHICS_ENGINE_A, gameState.sailShipType, SEAMAPCHARTCOURSEVIEW_TYPE_CHART_COURSE);
    
    SeaMapLayoutObject *landedIsland = SeaMapEventManager_GetObjectFromID(gameState.landedIslandID);
    SetSeaMapViewPosition(FX32_FROM_WHOLE(landedIsland->position.x), FX32_FROM_WHOLE(landedIsland->position.y));

    CreateNavTails(GRAPHICS_ENGINE_B, gameState.sailShipType, NULL);

    PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_CHART);

    ResetTouchInput();
}

void SeaMapChartCourseMenu_Main(void)
{
    SeaMapChartCourseMenu *work = TaskGetWorkCurrent(SeaMapChartCourseMenu);

    work->state(work);

    if (!work->destroyQueued)
        SeaMapChartCourseMenu_DrawText(work);
    else
        DestroySeaMapChartCourseMenu(work);
}

void SeaMapChartCourseMenu_Destructor(Task *task)
{
    SeaMapChartCourseMenu *work = TaskGetWork(task, SeaMapChartCourseMenu);
    UNUSED(work);

    ReleaseAudioSystem();
}

void DestroySeaMapChartCourseMenu(SeaMapChartCourseMenu *work)
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
            gameState.talk.state.hubStartAction = HUB_STARTACTION_RESUME_HUB;
            RequestSysEventChange(1); // SYSEVENT_RETURN_TO_HUB
            break;
    }

    NextSysEvent();
}

void SeaMapChartCourseMenu_DrawText(SeaMapChartCourseMenu *work)
{
    // Do nothing, there's no text to draw.
}

void InitDisplayForSeaMapChartCourseMenu(void)
{
    VRAMSystem__Reset();

    VRAMSystem__SetupBGBank(GX_VRAM_BG_128_D);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_32_FG, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);

    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);

    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;
}

void SeaMapChartCourseMenu_State_Init(SeaMapChartCourseMenu *work)
{
    work->state = SeaMapChartCourseMenu_State_FadeIn;
}

void SeaMapChartCourseMenu_State_FadeIn(SeaMapChartCourseMenu *work)
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
        work->state = SeaMapChartCourseMenu_State_Active;
}

void SeaMapChartCourseMenu_State_Active(SeaMapChartCourseMenu *work)
{
    if (IsSeaMapChartCourseViewFinished() == FALSE)
    {
        NNS_SndPlayerStopSeqBySeqNo(SND_SYS_SEQ_SEQ_CHART, 16);
        work->state = SeaMapChartCourseMenu_State_FadeOut;
    }
}

void SeaMapChartCourseMenu_State_FadeOut(SeaMapChartCourseMenu *work)
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