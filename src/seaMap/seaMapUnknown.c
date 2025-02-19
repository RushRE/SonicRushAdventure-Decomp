#include <seaMap/seaMapUnknown.h>
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

static void SeaMapUnknown_Main(void);
static void SeaMapUnknown_Destructor(Task *task);
static void SeaMapUnknown_Destroy(SeaMapUnknown *work);
static void SeaMapUnknown_RunState(SeaMapUnknown *work);
static void InitDisplayForSeaMapUnknown(void);
static void SeaMapUnknown_State_Init(SeaMapUnknown *work);
static void SeaMapUnknown_State_FadeIn(SeaMapUnknown *work);
static void SeaMapUnknown_State_Active(SeaMapUnknown *work);
static void SeaMapUnknown_State_FadeOut(SeaMapUnknown *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapUnknown(void)
{
    ReleaseAudioSystem();
    LoadAudioSndArc("snd/sys/sound_data.sdat");
    NNS_SndArcLoadGroup(SND_SYS_GROUP_CHART, audioManagerSndHeap);

    LoadSpriteButtonCursorSprite();
    LoadSpriteButtonTouchpadSprite();

    Task *task = TaskCreate(SeaMapUnknown_Main, SeaMapUnknown_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0, TASK_GROUP(0), SeaMapUnknown);

    SeaMapUnknown *work = TaskGetWork(task, SeaMapUnknown);
    TaskInitWork16(work);

    work->state = SeaMapUnknown_State_Init;

    InitDisplayForSeaMapUnknown();

    SeaMapChartCourseView__Create(FALSE, gameState.sailShipType, 0);
    
    CHEVObject *obj = SeaMapEventManager__GetObjectFromID(gameState.field_80);
    SeaMapView__Func_203DCE0(FX32_FROM_WHOLE(obj->position.x), FX32_FROM_WHOLE(obj->position.y));

    CreateNavTails(TRUE, gameState.sailShipType, NULL);

    PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_CHART);

    ResetTouchInput();
}

void SeaMapUnknown_Main(void)
{
    SeaMapUnknown *work = TaskGetWorkCurrent(SeaMapUnknown);

    work->state(work);

    if (!work->destroyQueued)
        SeaMapUnknown_RunState(work);
    else
        SeaMapUnknown_Destroy(work);
}

void SeaMapUnknown_Destructor(Task *task)
{
    SeaMapUnknown *work = TaskGetWork(task, SeaMapUnknown);
    UNUSED(work);

    ReleaseAudioSystem();
}

void SeaMapUnknown_Destroy(SeaMapUnknown *work)
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
            gameState.talk.state.hubStartAction = HUB_STARTACTION_RESUME_HUB;
            RequestSysEventChange(1); // SYSEVENT_RETURN_TO_HUB
            break;
    }

    NextSysEvent();
}

void SeaMapUnknown_RunState(SeaMapUnknown *work)
{
    // Do nothing.
}

void InitDisplayForSeaMapUnknown(void)
{
    VRAMSystem__Reset();

    VRAMSystem__SetupBGBank(GX_VRAM_BG_128_D);
    VRAMSystem__SetupOBJBank(GX_VRAM_OBJ_32_FG, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x400);

    VRAMSystem__SetupSubBGBank(GX_VRAM_SUB_BG_128_C);
    VRAMSystem__SetupSubOBJBank(GX_VRAM_SUB_OBJ_16_I, GX_OBJVRAMMODE_CHAR_1D_32K, GX_OBJVRAMMODE_BMP_1D_128K, 0, 0x200);

    renderCurrentDisplay = GX_DISP_SELECT_SUB_MAIN;
}

void SeaMapUnknown_State_Init(SeaMapUnknown *work)
{
    work->state = SeaMapUnknown_State_FadeIn;
}

void SeaMapUnknown_State_FadeIn(SeaMapUnknown *work)
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
        work->state = SeaMapUnknown_State_Active;
}

void SeaMapUnknown_State_Active(SeaMapUnknown *work)
{
    if (SeaMapChartCourseView__Func_2040978() == FALSE)
    {
        NNS_SndPlayerStopSeqBySeqNo(SND_SYS_SEQ_SEQ_CHART, 16);
        work->state = SeaMapUnknown_State_FadeOut;
    }
}

void SeaMapUnknown_State_FadeOut(SeaMapUnknown *work)
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