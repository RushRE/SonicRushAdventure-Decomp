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

static const BOOL sButtonStateTable1[] = { TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE };
static const BOOL sButtonStateTable2[] = { FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, FALSE };

static const u16 sIslandInfoText_Cleared[SEAMAP_ISLAND_COUNT] = {
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

static const u16 sIslandInfoText_NotCleared[SEAMAP_ISLAND_COUNT] = {
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

static const s32 sStageForIsland[SEAMAP_ISLAND_COUNT] = {
    [SEAMAP_ISLAND_SOUTHERN_ISLAND]   = STAGE_Z11,
    [SEAMAP_ISLAND_PLANT_KINGDOM]     = STAGE_Z11,
    [SEAMAP_ISLAND_MACHINE_LABYRINTH] = STAGE_Z21,
    [SEAMAP_ISLAND_CORAL_CAVE]        = STAGE_Z31,
    [SEAMAP_ISLAND_HAUNTED_SHIP]      = STAGE_Z41,
    [SEAMAP_ISLAND_BLIZZARD_PEAKS]    = STAGE_Z51,
    [SEAMAP_ISLAND_SKY_BABYLON]       = STAGE_Z61,
    [SEAMAP_ISLAND_PIRATES_ISLAND]    = STAGE_Z71,
    [SEAMAP_ISLAND_BIG_SWELL]         = STAGE_BOSS_FINAL,
    [SEAMAP_ISLAND_DEEP_CORE]         = STAGE_Z11,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_1]   = STAGE_HIDDEN_ISLAND_1,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_2]   = STAGE_HIDDEN_ISLAND_2,
    [SEAMAP_ISLAND_DAIKUN_ISLAND]     = STAGE_Z11,
    [SEAMAP_ISLAND_13]                = STAGE_Z11,
    [SEAMAP_ISLAND_KYLOK_ISLAND]      = STAGE_Z11,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_3]   = STAGE_HIDDEN_ISLAND_3,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_4]   = STAGE_HIDDEN_ISLAND_4,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_5]   = STAGE_HIDDEN_ISLAND_5,
    [SEAMAP_ISLAND_18]                = STAGE_Z11,
    [SEAMAP_ISLAND_19]                = STAGE_Z11,
    [SEAMAP_ISLAND_20]                = STAGE_Z11,
    [SEAMAP_ISLAND_21]                = STAGE_Z11,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_6]   = STAGE_HIDDEN_ISLAND_6,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_7]   = STAGE_HIDDEN_ISLAND_7,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_8]   = STAGE_HIDDEN_ISLAND_8,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_9]   = STAGE_HIDDEN_ISLAND_9,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_10]  = STAGE_HIDDEN_ISLAND_10,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_11]  = STAGE_HIDDEN_ISLAND_11,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_12]  = STAGE_HIDDEN_ISLAND_12,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_13]  = STAGE_HIDDEN_ISLAND_13,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_14]  = STAGE_HIDDEN_ISLAND_14,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_15]  = STAGE_HIDDEN_ISLAND_15,
    [SEAMAP_ISLAND_HIDDEN_ISLAND_16]  = STAGE_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_33]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_34]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_35]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_36]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_37]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_38]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_39]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_40]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAP_ISLAND_41]                = STAGE_HIDDEN_ISLAND_16,
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
static void SeaMapMenu_State_StartZoomIn(SeaMapMenu *work);
static void SeaMapMenu_State_ApplyZoomIn(SeaMapMenu *work);
static void SeaMapMenu_State_EndZoomIn(SeaMapMenu *work);
static void SeaMapMenu_Action_ZoomOut(SeaMapMenu *work);
static void SeaMapMenu_State_ZoomOut(SeaMapMenu *work);
static void SeaMapMenu_State_StartZoomOut(SeaMapMenu *work);
static void SeaMapMenu_State_ApplyZoomOut(SeaMapMenu *work);
static void SeaMapMenu_State_EndZoomOut(SeaMapMenu *work);
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

    gSeaMapViewType      = SEAMAPVIEW_TYPE_MENU;
    gSeaMapViewExitEvent = SEAMAPVIEW_EXIT_NONE;

    RenderCoreGFXControl *gfxControl = VRAMSystem__GFXControl[useEngineB];
    prevBrightness                   = gfxControl->brightness;
    SeaMapManager__Create(useEngineB, SHIP_MENU, FALSE);
    gfxControl->brightness = prevBrightness;

    SeaMapManager__LoadMapBackground();

    ReleaseAudioSystem();
    LoadAudioSndArc("snd/sys/sound_data.sdat");
    NNS_SndArcLoadGroup(SND_SYS_GROUP_CHART, gAudioManagerSndHeap);

    Task *task           = TaskCreate(SeaMapMenu_Main, SeaMapMenu_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xFF, TASK_GROUP(0), SeaMapMenu);
    gSeaMapTaskSingleton = task;

    SeaMapMenu *work = TaskGetWork(task, SeaMapMenu);
    TaskInitWork16(work);

    InitSeaMapView(&work->view, useEngineB, SHIP_MENU, TRUE);

    work->state = SeaMapMenu_State_FadeIn;

    SeaMapLayoutObject *obj = SeaMapEventManager_GetObjectFromID(gameState.landedIslandID);
    SetSeaMapViewPosition(FX32_FROM_WHOLE(obj->position.x), FX32_FROM_WHOLE(obj->position.y));
    SeaMapView_EnableMultipleButtons(&work->view, sButtonStateTable1);
    SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_NEAREST);

    CreateSeaMapEventManager();

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
            if (MenuHelpers__CheckStageCleared(sStageForIsland[id], TRUE, FALSE))
                return sIslandInfoText_Cleared[id];
            else
                return sIslandInfoText_NotCleared[id];
            break;
    }
}

BOOL SeaMapMenu_HandleIslandSelected(SeaMapMenu *work)
{
    SeaMapManager *mapManager = SeaMapManager__GetWork();
    UNUSED(mapManager);

    SeaMapEventManager *manager = GetSeaMapEventManagerWork2();

    BOOL didAction = TRUE;
    switch (manager->lastTouchedIconType)
    {
        case SEAMAPOBJECT_ISLAND_DRAW_ICON:
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_CURSOL);
            work->selectedIsland = manager->lastTouchedIcon->objWork.mapObject;
            SeaMapEventManager_ClearLastTouchedIcon();
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
            gSeaMapViewExitEvent = SEAMAPVIEW_EXIT_BACK;
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
            gameState.landedIslandID = work->selectedIsland->id;
            gSeaMapViewExitEvent     = SEAMAPVIEW_EXIT_CONFIRM;
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_DECIDE);
            NNS_SndPlayerStopSeqBySeqNo(SND_SYS_SEQ_SEQ_CHART, 16);
            work->state = SeaMapMenu_State_FadeOut;
            break;

        case 6:
            NavTailsSpeak(NAVTAILS_MSGSEQ_SELECT_AN_ISLAND_TO_GO_TO, SECONDS_TO_FRAMES(10.0));
            SeaMapView_SetTouchAreaPriority(&work->view, FALSE);
            SeaMapView_SetTouchAreaCallback(&work->view, SeaMapView_TouchAreaCallback_Active);
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
        DestroySeaMapEventManager();
        SeaMapManager__Destroy();
    }
}

void SeaMapMenu_Destructor(Task *task)
{
    SeaMapMenu *work = TaskGetWork(task, SeaMapMenu);

    ReleaseSeaMapView(&work->view);
    ReleaseAudioSystem();

    gSeaMapViewType      = SEAMAPVIEW_TYPE_NONE;
    gSeaMapTaskSingleton = NULL;
}

void SeaMapMenu_Draw(SeaMapMenu *work)
{
    SeaMapView_ProcessIndicatorFlashTimer(&work->view);

    if (work->drawPadCursors)
        SeaMapView_DrawIndicators(&work->view);

    SeaMapView_ReadPosition(&work->view);
    SeaMapView_DrawButtons(&work->view);
    SeaMapView_DrawTouchCursor(&work->view);
}

void SeaMapMenu_Action_ZoomIn(SeaMapMenu *work)
{
    work->prevState = work->state;
    work->state     = SeaMapMenu_State_ZoomIn;
}

void SeaMapMenu_State_ZoomIn(SeaMapMenu *work)
{
    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);
    SeaMapManager__EnableTouchField(FALSE);
    PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_ZOOMIN);

    work->state = SeaMapMenu_State_StartZoomIn;
    work->state(work);
}

void SeaMapMenu_State_StartZoomIn(SeaMapMenu *work)
{
    if (SeaMapView_HandleZoomIn_Intro(&work->zoomControl))
        work->state = SeaMapMenu_State_ApplyZoomIn;
}

void SeaMapMenu_State_ApplyZoomIn(SeaMapMenu *work)
{
    switch (SeaMapManager__GetZoomLevel())
    {
        case SEAMAP_ZOOM_MIDDLE:
            SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_NEAREST);
            break;

        case SEAMAP_ZOOM_FARTHEST:
            SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_MIDDLE);
            break;
    }

    SeaMapView_ProcessMapInputs(&work->view);
    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);

    work->state = SeaMapMenu_State_EndZoomIn;
    work->state(work);
}

void SeaMapMenu_State_EndZoomIn(SeaMapMenu *work)
{
    if (SeaMapView_HandleZoomIn_Outro(&work->zoomControl))
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
    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);
    SeaMapManager__EnableTouchField(FALSE);
    PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_ZOOMOUT);

    work->state = SeaMapMenu_State_StartZoomOut;
    work->state(work);
}

void SeaMapMenu_State_StartZoomOut(SeaMapMenu *work)
{
    if (SeaMapView_HandleZoomOut_Intro(&work->zoomControl))
        work->state = SeaMapMenu_State_ApplyZoomOut;
}

void SeaMapMenu_State_ApplyZoomOut(SeaMapMenu *work)
{
    switch (SeaMapManager__GetZoomLevel())
    {
        case SEAMAP_ZOOM_NEAREST:
            SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_MIDDLE);
            break;

        case SEAMAP_ZOOM_MIDDLE:
            SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_FARTHEST);
            break;
    }

    SeaMapView_ProcessMapInputs(&work->view);
    InitSeaMapViewZoomControl(&work->zoomControl, work->view.useEngineB);

    work->state = SeaMapMenu_State_EndZoomOut;
    work->state(work);
}

void SeaMapMenu_State_EndZoomOut(SeaMapMenu *work)
{
    if (SeaMapView_HandleZoomOut_Outro(&work->zoomControl))
    {
        work->state = work->prevState;
        SeaMapManager__EnableTouchField(TRUE);
    }
}

void SeaMapMenu_State_FadeIn(SeaMapMenu *work)
{
    if (SeaMapView_FadeActiveScreen_ToDefault(&work->view))
        work->state = SeaMapMenu_State_InitMenu;
}

void SeaMapMenu_State_InitMenu(SeaMapMenu *work)
{
    SeaMapView_ResetIndicatorFlashTimer(&work->view);

    work->drawPadCursors = TRUE;
    SeaMapView_EnableMultipleButtons(&work->view, sButtonStateTable1);

    SeaMapView_SetZoomLevelForZoomButtons(&work->view, SeaMapManager__GetZoomLevel());
    NavTailsSpeak(NAVTAILS_MSGSEQ_SELECT_AN_ISLAND_TO_GO_TO, SECONDS_TO_FRAMES(10.0));

    work->state = SeaMapMenu_State_ProcessInputs;
    work->state(work);
}

void SeaMapMenu_State_ProcessInputs(SeaMapMenu *work)
{
    SeaMapView_ProcessMapInputs(&work->view);
    SeaMapView_ProcessButtonInputs(&work->view);

    if (GetSeaMapEventManagerWork2()->lastTouchedIconType != -1)
        SeaMapMenu_HandleIslandSelected(work);
    else
        SeaMapMenu_ProcessMainButtons(work);

    work->view.selectedButton = -1;
}

void SeaMapMenu_State_InitIslandSelectedMenu(SeaMapMenu *work)
{
    SeaMapView_EnableMultipleButtons(&work->view, sButtonStateTable2);

    if (work->selectedIsland->id == SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND)
        SeaMapView_EnableButton(&work->view, 7, TRUE);
    else
        SeaMapView_EnableButton(&work->view, 5, TRUE);

    work->drawPadCursors = FALSE;
    work->state          = SeaMapMenu_State_IslandSelectedMenu;

    SeaMapView_SetTouchAreaPriority(&work->view, TRUE);
    SeaMapView_SetTouchAreaCallback(&work->view, SeaMapView_TouchAreaCallback_Inactive);
    SeaMapView_ClearLocalMoveInputs(&work->view);
    SeaMapView_ProcessMapInputs(&work->view);

    NavTailsSpeak(SeaMapMenu_GetIslandInfoText(work->selectedIsland->id), 0);

    work->state(work);
}

void SeaMapMenu_State_IslandSelectedMenu(SeaMapMenu *work)
{
    SeaMapMenu_ProcessIslandSelectedButtons(work);
}

void SeaMapMenu_State_Close(SeaMapMenu *work)
{
    if (SeaMapView_FadeActiveScreen_ToTarget(&work->view))
        work->isClosed = TRUE;
}

void SeaMapMenu_State_FadeOut(SeaMapMenu *work)
{
    BOOL doneMain  = SeaMapView_FadeActiveScreen_ToTarget(&work->view);
    BOOL doneOther = SeaMapView_FadeOtherScreen_ToTarget(&work->view);

    if (doneMain && doneOther)
        work->isClosed = TRUE;
}