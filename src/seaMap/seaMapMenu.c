#include <seaMap/seaMapMenu.h>
#include <game/game/gameState.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>
#include <seaMap/navTails.h>
#include <seaMap/seaMapEventManager.h>
#include <seaMap/objects/seaMapIslandDrawIcon.h>
#include <menu/menuHelpers.h>

// --------------------
// VARIABLES
// --------------------

static const BOOL buttonStateTable1[] = { TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE };
static const BOOL buttonStateTable2[] = { FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, FALSE };

static const u16 islandInfoText_Cleared[SEAMAP_ISLAND_COUNT] = {
    [SEAMAP_ISLAND_SOUTHERN_ISLAND]   = NAVTAILS_MSGSEQ_THATS_SOUTHERN_ISLAND,
    [SEAMAP_ISLAND_PLANT_KINGDOM]     = NAVTAILS_MSGSEQ_THATS_PLANT_KINGDOM,
    [SEAMAP_ISLAND_MACHINE_LABYRINTH] = NAVTAILS_MSGSEQ_THATS_MACHINE_LABYRINTH,
    [SEAMAP_ISLAND_CORAL_CAVE]        = NAVTAILS_MSGSEQ_THATS_CORAL_CAVE,
    [SEAMAP_ISLAND_HAUNTED_SHIP]      = NAVTAILS_MSGSEQ_THATS_HAUNTED_SHIP,
    [SEAMAP_ISLAND_BLIZZARD_PEAKS]    = NAVTAILS_MSGSEQ_THATS_BLIZZARD_PEAKS,
    [SEAMAP_ISLAND_SKY_BABYLON]       = NAVTAILS_MSGSEQ_THATS_SKY_BABYLON,
    [SEAMAP_ISLAND_PIRATES_ISLAND]    = NAVTAILS_MSGSEQ_THATS_PIRATES_ISLAND,
    [SEAMAP_ISLAND_BIG_SWELL]         = NAVTAILS_MSGSEQ_THATS_BIG_SWELL,
    [SEAMAP_ISLAND_DEEP_CORE]         = NAVTAILS_MSGSEQ_THATS_DEEP_CORE,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_1]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_1,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_2]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_2,
    [SEAMAP_ISLAND_DAIKUN_ISLAND]     = NAVTAILS_MSGSEQ_THATS_DAIKUNS_ISLAND,
    [SEAMAP_ISLAND_13]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_KYLOK_ISLAND]      = NAVTAILS_MSGSEQ_THATS_KYLOKS_ISLAND,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_3]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_3,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_4]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_4,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_5]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_5,
    [SEAMAP_ISLAND_18]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_19]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_20]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_21]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_6]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_6,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_7]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_7,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_8]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_8,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_9]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_9,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_10]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_10,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_11]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_11,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_12]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_12,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_13]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_13,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_14]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_14,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_15]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_15,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_16]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_33]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_34]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_35]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_36]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_37]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_38]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_39]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_40]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_41]                = NAVTAILS_MSGSEQ_NOTHING,
};

static const u16 islandInfoText_NotCleared[SEAMAP_ISLAND_COUNT] = {
    [SEAMAP_ISLAND_SOUTHERN_ISLAND]   = NAVTAILS_MSGSEQ_THATS_SOUTHERN_ISLAND,
    [SEAMAP_ISLAND_PLANT_KINGDOM]     = NAVTAILS_MSGSEQ_THATS_PLANT_KINGDOM,
    [SEAMAP_ISLAND_MACHINE_LABYRINTH] = NAVTAILS_MSGSEQ_THATS_MACHINE_LABYRINTH,
    [SEAMAP_ISLAND_CORAL_CAVE]        = NAVTAILS_MSGSEQ_THATS_CORAL_CAVE,
    [SEAMAP_ISLAND_HAUNTED_SHIP]      = NAVTAILS_MSGSEQ_THATS_HAUNTED_SHIP,
    [SEAMAP_ISLAND_BLIZZARD_PEAKS]    = NAVTAILS_MSGSEQ_THATS_BLIZZARD_PEAKS,
    [SEAMAP_ISLAND_SKY_BABYLON]       = NAVTAILS_MSGSEQ_THATS_SKY_BABYLON,
    [SEAMAP_ISLAND_PIRATES_ISLAND]    = NAVTAILS_MSGSEQ_THATS_PIRATES_ISLAND,
    [SEAMAP_ISLAND_BIG_SWELL]         = NAVTAILS_MSGSEQ_THATS_BIG_SWELL,
    [SEAMAP_ISLAND_DEEP_CORE]         = NAVTAILS_MSGSEQ_THATS_DEEP_CORE,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_1]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_1,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_2]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_2,
    [SEAMAP_ISLAND_DAIKUN_ISLAND]     = NAVTAILS_MSGSEQ_THATS_DAIKUNS_ISLAND,
    [SEAMAP_ISLAND_13]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_KYLOK_ISLAND]      = NAVTAILS_MSGSEQ_THATS_KYLOKS_ISLAND,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_3]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_3,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_4]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_4,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_5]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_5,
    [SEAMAP_ISLAND_18]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_19]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_20]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_21]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_6]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_6,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_7]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_7,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_8]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_8,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_9]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_9,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_10]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_10,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_11]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_11,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_12]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_12,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_13]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_13,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_14]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_14,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_15]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_15,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_16]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_33]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_34]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_35]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_36]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_37]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_38]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_39]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_40]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAP_ISLAND_41]                = NAVTAILS_MSGSEQ_NOTHING,
};

static const s32 progressForIsland[SEAMAP_ISLAND_COUNT] = {
    [SEAMAP_ISLAND_SOUTHERN_ISLAND]   = 0,
    [SEAMAP_ISLAND_PLANT_KINGDOM]     = 0,
    [SEAMAP_ISLAND_MACHINE_LABYRINTH] = 4,
    [SEAMAP_ISLAND_CORAL_CAVE]        = 7,
    [SEAMAP_ISLAND_HAUNTED_SHIP]      = 11,
    [SEAMAP_ISLAND_BLIZZARD_PEAKS]    = 14,
    [SEAMAP_ISLAND_SKY_BABYLON]       = 17,
    [SEAMAP_ISLAND_PIRATES_ISLAND]    = 21,
    [SEAMAP_ISLAND_BIG_SWELL]         = 24,
    [SEAMAP_ISLAND_DEEP_CORE]         = 0,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_1]   = 9,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_2]   = 19,
    [SEAMAP_ISLAND_DAIKUN_ISLAND]     = 0,
    [SEAMAP_ISLAND_13]                = 0,
    [SEAMAP_ISLAND_KYLOK_ISLAND]      = 0,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_3]   = 25,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_4]   = 26,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_5]   = 27,
    [SEAMAP_ISLAND_18]                = 0,
    [SEAMAP_ISLAND_19]                = 0,
    [SEAMAP_ISLAND_20]                = 0,
    [SEAMAP_ISLAND_21]                = 0,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_6]   = 28,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_7]   = 29,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_8]   = 30,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_9]   = 31,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_10]  = 32,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_11]  = 33,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_12]  = 34,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_13]  = 35,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_14]  = 36,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_15]  = 37,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_16]  = 38,
    [SEAMAP_ISLAND_33]                = 38,
    [SEAMAP_ISLAND_34]                = 38,
    [SEAMAP_ISLAND_35]                = 38,
    [SEAMAP_ISLAND_36]                = 38,
    [SEAMAP_ISLAND_37]                = 38,
    [SEAMAP_ISLAND_38]                = 38,
    [SEAMAP_ISLAND_39]                = 38,
    [SEAMAP_ISLAND_40]                = 38,
    [SEAMAP_ISLAND_41]                = 38,
};

// --------------------
// FUNCTION DECLS
// --------------------

static u16 SeaMapMenu_GetIslandInfoText(u32 id);
static BOOL SeaMapMenu_HandleIslandSelected(SeaMapMenu *work);
static BOOL SeaMapMenu_ProcessMainButtons(SeaMapMenu *work);
static BOOL SeaMapMenu_ProcessIslandSelectedButtons(SeaMapMenu *work);

static void SeaMapMenu_Main(void);
static void SeaMapMenu_Destructor(Task *task);
static void SeaMapMenu_Draw(SeaMapMenu *work);
static void SeaMapMenu_Action_ZoomIn(SeaMapMenu *work);
static void SeaMapMenu_State_ZoomIn(SeaMapMenu *work);
static void SeaMapMenu_State_TryZoomIn(SeaMapMenu *work);
static void SeaMapMenu_State_PrepareZoomIn(SeaMapMenu *work);
static void SeaMapMenu_State_ZoomInFinish(SeaMapMenu *work);
static void SeaMapMenu_Action_ZoomOut(SeaMapMenu *work);
static void SeaMapMenu_State_ZoomOut(SeaMapMenu *work);
static void SeaMapMenu_State_TryZoomOut(SeaMapMenu *work);
static void SeaMapMenu_State_PrepareZoomOut(SeaMapMenu *work);
static void SeaMapMenu_State_ZoomOutFinish(SeaMapMenu *work);
static void SeaMapMenu_State_FadeIn(SeaMapMenu *work);
static void SeaMapMenu_State_InitMenu(SeaMapMenu *work);
static void SeaMapMenu_State_ProcessInputs(SeaMapMenu *work);
static void SeaMapMenu_State_InitIslandSelectedMenu(SeaMapMenu *work);
static void SeaMapMenu_State_IslandSelectedMenu(SeaMapMenu *work);
static void SeaMapMenu_State_Close(SeaMapMenu *work);
static void SeaMapMenu_State_FadeOut(SeaMapMenu *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSeaMapMenu(BOOL useEngineB)
{
    s32 prevBrightness;

    seaMapViewMode     = 1;
    seaMapViewUnknown1 = 0;

    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];
    prevBrightness                   = gfxControl->brightness;
    SeaMapManager__Create(useEngineB, SHIP_MENU, FALSE);
    gfxControl->brightness = prevBrightness;

    SeaMapManager__LoadMapBackground();

    ReleaseAudioSystem();
    LoadAudioSndArc("snd/sys/sound_data.sdat");
    NNS_SndArcLoadGroup(SND_SYS_GROUP_CHART, audioManagerSndHeap);

    Task *task                  = TaskCreate(SeaMapMenu_Main, SeaMapMenu_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xFF, TASK_GROUP(0), SeaMapMenu);
    SeaMapView__sVars.singleton = task;

    SeaMapMenu *work = TaskGetWork(task, SeaMapMenu);
    TaskInitWork16(work);

    SeaMapView__InitView(&work->view, useEngineB, SHIP_MENU, TRUE);

    work->state = SeaMapMenu_State_FadeIn;

    CHEVObject *obj = SeaMapEventManager__GetObjectFromID(gameState.field_80);
    SeaMapView__SetViewPosition(FX32_FROM_WHOLE(obj->position.x), FX32_FROM_WHOLE(obj->position.y));
    SeaMapView__EnableMultipleButtons(&work->view, buttonStateTable1);
    SeaMapView__SetZoomLevel(&work->view, 0);

    SeaMapEventManager__Create();

    PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_CHART);
}

u16 SeaMapMenu_GetIslandInfoText(u32 id)
{
    switch (id)
    {
        case SEAMAP_ISLAND_PIRATES_ISLAND:
            if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_32)
                return NAVTAILS_MSGSEQ_THATS_PIRATES_ISLAND;
            else
                return NAVTAILS_MSGSEQ_THATS_PIRATES_ISLAND_NO_MATERIAL_VER;
            break;

        case SEAMAP_ISLAND_KYLOK_ISLAND:
            if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_18)
                return NAVTAILS_MSGSEQ_THATS_KYLOKS_ISLAND;
            else
                return NAVTAILS_MSGSEQ_LOOKS_LIKE_NO_ONE_IS_HERE;
            break;

        default:
            if (MenuHelpers__CheckProgress(progressForIsland[id], TRUE, FALSE))
                return islandInfoText_Cleared[id];
            else
                return islandInfoText_NotCleared[id];
            break;
    }
}

BOOL SeaMapMenu_HandleIslandSelected(SeaMapMenu *work)
{
    SeaMapManager *mapManager = SeaMapManager__GetWork();
    UNUSED(mapManager);

    SeaMapEventManager *manager = SeaMapEventManager__GetWork2();

    BOOL didAction = TRUE;
    switch (manager->lastTouchedIconType)
    {
        case SEAMAPOBJECT_ISLAND_DRAW_ICON:
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_CURSOL);
            work->selectedIsland = manager->lastTouchedIcon->objWork.mapObject;
            SeaMapEventManager__Func_2046A78();
            work->state = SeaMapMenu_State_InitIslandSelectedMenu;
            break;

        default:
            didAction = FALSE;
            break;
    }

    return didAction;
}

BOOL SeaMapMenu_ProcessMainButtons(SeaMapMenu *work)
{
    BOOL didAction = TRUE;
    switch (work->view.selectedButton)
    {
        case 0: // back
            seaMapViewUnknown1 = 2;
            NNS_SndPlayerStopSeqBySeqNo(SND_SYS_SEQ_SEQ_CHART, 16);
            work->state = SeaMapMenu_State_Close;
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_CANCELL);
            break;

        case 1: // zoom in
            SeaMapMenu_Action_ZoomIn(work);
            break;

        case 2: // zoom out
            SeaMapMenu_Action_ZoomOut(work);
            break;

        default:
            didAction = FALSE;
            break;
    }

    return didAction;
}

BOOL SeaMapMenu_ProcessIslandSelectedButtons(SeaMapMenu *work)
{
    BOOL didAction = TRUE;
    switch (work->view.selectedButton)
    {
        case 5:
        case 7:
            gameState.field_80 = work->selectedIsland->unlockID;
            seaMapViewUnknown1 = 1;
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_DECIDE);
            NNS_SndPlayerStopSeqBySeqNo(SND_SYS_SEQ_SEQ_CHART, 16);
            work->state = SeaMapMenu_State_FadeOut;
            break;

        case 6:
            NavTailsSpeak(NAVTAILS_MSGSEQ_SELECT_AN_ISLAND_TO_GO_TO, SECONDS_TO_FRAMES(10.0));
            SeaMapView__Func_203F35C(&work->view, 0);
            SeaMapView__SetTouchAreaCallback(&work->view, SeaMapView__TouchAreaCallback);
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_CANCELL);
            work->state = SeaMapMenu_State_InitMenu;
            break;

        default:
            didAction = FALSE;
            break;
    }

    return didAction;
}

void SeaMapMenu_Main(void)
{
    SeaMapMenu *work = TaskGetWorkCurrent(SeaMapMenu);

    work->state(work);

    if (work->isClosed == FALSE)
    {
        SeaMapMenu_Draw(work);
    }
    else
    {
        DestroyCurrentTask();
        SeaMapEventManager__Destroy();
        SeaMapManager__Destroy();
    }
}

void SeaMapMenu_Destructor(Task *task)
{
    SeaMapMenu *work = TaskGetWork(task, SeaMapMenu);

    SeaMapView__ReleaseAssets(&work->view);
    ReleaseAudioSystem();

    seaMapViewMode              = 0;
    SeaMapView__sVars.singleton = NULL;
}

void SeaMapMenu_Draw(SeaMapMenu *work)
{
    SeaMapView__Func_203E8A8(&work->view);

    if (work->drawPadCursors)
        SeaMapView__DrawPadCursors(&work->view);

    SeaMapView__Func_203F770(&work->view);
    SeaMapView__DrawButtons(&work->view);
    SeaMapView__DrawTouchCursor(&work->view);
}

void SeaMapMenu_Action_ZoomIn(SeaMapMenu *work)
{
    work->prevState = work->state;
    work->state     = SeaMapMenu_State_ZoomIn;
}

void SeaMapMenu_State_ZoomIn(SeaMapMenu *work)
{
    SeaMapView__InitZoomControl(&work->zoomControl, work->view.useEngineB);
    SeaMapManager__EnableTouchField(FALSE);
    PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_ZOOMIN);

    work->state = SeaMapMenu_State_TryZoomIn;
    work->state(work);
}

void SeaMapMenu_State_TryZoomIn(SeaMapMenu *work)
{
    if (SeaMapView__CanZoomIn(&work->zoomControl))
        work->state = SeaMapMenu_State_PrepareZoomIn;
}

void SeaMapMenu_State_PrepareZoomIn(SeaMapMenu *work)
{
    switch (SeaMapManager__GetZoomLevel())
    {
        case 1:
            SeaMapView__SetZoomLevel(&work->view, 0);
            break;

        case 2:
            SeaMapView__SetZoomLevel(&work->view, 1);
            break;
    }

    SeaMapView__ProcessPadInputs(&work->view);
    SeaMapView__InitZoomControl(&work->zoomControl, work->view.useEngineB);

    work->state = SeaMapMenu_State_ZoomInFinish;
    work->state(work);
}

void SeaMapMenu_State_ZoomInFinish(SeaMapMenu *work)
{
    if (SeaMapView__HandleZoomIn(&work->zoomControl))
    {
        work->state = work->prevState;
        SeaMapManager__EnableTouchField(TRUE);
    }
}

void SeaMapMenu_Action_ZoomOut(SeaMapMenu *work)
{
    work->prevState = work->state;
    work->state     = SeaMapMenu_State_ZoomOut;
}

void SeaMapMenu_State_ZoomOut(SeaMapMenu *work)
{
    SeaMapView__InitZoomControl(&work->zoomControl, work->view.useEngineB);
    SeaMapManager__EnableTouchField(FALSE);
    PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_ZOOMOUT);

    work->state = SeaMapMenu_State_TryZoomOut;
    work->state(work);
}

void SeaMapMenu_State_TryZoomOut(SeaMapMenu *work)
{
    if (SeaMapView__CanZoomOut(&work->zoomControl))
        work->state = SeaMapMenu_State_PrepareZoomOut;
}

void SeaMapMenu_State_PrepareZoomOut(SeaMapMenu *work)
{
    switch (SeaMapManager__GetZoomLevel())
    {
        case 0:
            SeaMapView__SetZoomLevel(&work->view, 1);
            break;

        case 1:
            SeaMapView__SetZoomLevel(&work->view, 2);
            break;
    }

    SeaMapView__ProcessPadInputs(&work->view);
    SeaMapView__InitZoomControl(&work->zoomControl, work->view.useEngineB);

    work->state = SeaMapMenu_State_ZoomOutFinish;
    work->state(work);
}

void SeaMapMenu_State_ZoomOutFinish(SeaMapMenu *work)
{
    if (SeaMapView__HandleZoomOut(&work->zoomControl))
    {
        work->state = work->prevState;
        SeaMapManager__EnableTouchField(TRUE);
    }
}

void SeaMapMenu_State_FadeIn(SeaMapMenu *work)
{
    if (SeaMapView__FadeToBlack(&work->view))
        work->state = SeaMapMenu_State_InitMenu;
}

void SeaMapMenu_State_InitMenu(SeaMapMenu *work)
{
    SeaMapView__Func_203E898(&work->view);

    work->drawPadCursors = TRUE;
    SeaMapView__EnableMultipleButtons(&work->view, buttonStateTable1);

    SeaMapView__SetButtonMode(&work->view, SeaMapManager__GetZoomLevel());
    NavTailsSpeak(NAVTAILS_MSGSEQ_SELECT_AN_ISLAND_TO_GO_TO, SECONDS_TO_FRAMES(10.0));

    work->state = SeaMapMenu_State_ProcessInputs;
    work->state(work);
}

void SeaMapMenu_State_ProcessInputs(SeaMapMenu *work)
{
    SeaMapView__ProcessPadInputs(&work->view);
    SeaMapView__ProcessButtons(&work->view);

    if (SeaMapEventManager__GetWork2()->lastTouchedIconType != -1)
        SeaMapMenu_HandleIslandSelected(work);
    else
        SeaMapMenu_ProcessMainButtons(work);

    work->view.selectedButton = -1;
}

void SeaMapMenu_State_InitIslandSelectedMenu(SeaMapMenu *work)
{
    SeaMapView__EnableMultipleButtons(&work->view, buttonStateTable2);

    if (work->selectedIsland->unlockID == 0)
        SeaMapView__EnableButton(&work->view, 7, TRUE);
    else
        SeaMapView__EnableButton(&work->view, 5, TRUE);

    work->drawPadCursors = FALSE;
    work->state          = SeaMapMenu_State_IslandSelectedMenu;

    SeaMapView__Func_203F35C(&work->view, 1);
    SeaMapView__SetTouchAreaCallback(&work->view, SeaMapView__TouchAreaCallback2);
    SeaMapView__Func_203F344(&work->view);
    SeaMapView__ProcessPadInputs(&work->view);

    NavTailsSpeak(SeaMapMenu_GetIslandInfoText(work->selectedIsland->unlockID), 0);

    work->state(work);
}

void SeaMapMenu_State_IslandSelectedMenu(SeaMapMenu *work)
{
    SeaMapMenu_ProcessIslandSelectedButtons(work);
}

void SeaMapMenu_State_Close(SeaMapMenu *work)
{
    if (SeaMapView__FadeActiveScreen(&work->view))
        work->isClosed = TRUE;
}

void SeaMapMenu_State_FadeOut(SeaMapMenu *work)
{
    BOOL doneMain  = SeaMapView__FadeActiveScreen(&work->view);
    BOOL doneOther = SeaMapView__FadeOtherScreen(&work->view);

    if (doneMain && doneOther)
        work->isClosed = TRUE;
}