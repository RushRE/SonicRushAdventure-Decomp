#include <seaMap/seaMapMenu.h>
#include <game/game/gameState.h>
#include <game/audio/audioSystem.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>
#include <seaMap/navTails.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/objects/seaMapIslandDrawIcon.h>
#include <menu/menuHelpers.h>

// --------------------
// VARIABLES
// --------------------

static const BOOL sSeaMapViewButtonState_Navigate[SEAMAPVIEW_BUTTON_COUNT] = {
    [SEAMAPVIEW_BUTTON_BACK] = TRUE,         [SEAMAPVIEW_BUTTON_ZOOM_IN] = TRUE, [SEAMAPVIEW_BUTTON_ZOOM_OUT] = TRUE, [SEAMAPVIEW_BUTTON_CONFIRM_PATH] = FALSE,
    [SEAMAPVIEW_BUTTON_CANCEL_PATH] = FALSE, [SEAMAPVIEW_BUTTON_LAND] = FALSE,   [SEAMAPVIEW_BUTTON_CANCEL] = FALSE,  [SEAMAPVIEW_BUTTON_RETURN_VILLAGE] = FALSE
};

static const BOOL sSeaMapViewButtonState_Selected[SEAMAPVIEW_BUTTON_COUNT] = {
    [SEAMAPVIEW_BUTTON_BACK] = FALSE,        [SEAMAPVIEW_BUTTON_ZOOM_IN] = FALSE, [SEAMAPVIEW_BUTTON_ZOOM_OUT] = FALSE, [SEAMAPVIEW_BUTTON_CONFIRM_PATH] = FALSE,
    [SEAMAPVIEW_BUTTON_CANCEL_PATH] = FALSE, [SEAMAPVIEW_BUTTON_LAND] = FALSE,    [SEAMAPVIEW_BUTTON_CANCEL] = TRUE,    [SEAMAPVIEW_BUTTON_RETURN_VILLAGE] = FALSE
};

static const u16 sIslandInfoText_Cleared[SEAMAPMANAGER_DISCOVER_ISLAND_COUNT] = {
    [SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND]   = NAVTAILS_MSGSEQ_THATS_SOUTHERN_ISLAND,
    [SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM]     = NAVTAILS_MSGSEQ_THATS_PLANT_KINGDOM,
    [SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH] = NAVTAILS_MSGSEQ_THATS_MACHINE_LABYRINTH,
    [SEAMAPMANAGER_DISCOVER_CORAL_CAVE]        = NAVTAILS_MSGSEQ_THATS_CORAL_CAVE,
    [SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP]      = NAVTAILS_MSGSEQ_THATS_HAUNTED_SHIP,
    [SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS]    = NAVTAILS_MSGSEQ_THATS_BLIZZARD_PEAKS,
    [SEAMAPMANAGER_DISCOVER_SKY_BABYLON]       = NAVTAILS_MSGSEQ_THATS_SKY_BABYLON,
    [SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND]    = NAVTAILS_MSGSEQ_THATS_PIRATES_ISLAND,
    [SEAMAPMANAGER_DISCOVER_BIG_SWELL]         = NAVTAILS_MSGSEQ_THATS_BIG_SWELL,
    [SEAMAPMANAGER_DISCOVER_DEEP_CORE]         = NAVTAILS_MSGSEQ_THATS_DEEP_CORE,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_1,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_2,
    [SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND]     = NAVTAILS_MSGSEQ_THATS_DAIKUNS_ISLAND,
    [SEAMAPMANAGER_DISCOVER_13]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND]      = NAVTAILS_MSGSEQ_THATS_KYLOKS_ISLAND,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_3,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_4,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_5,
    [SEAMAPMANAGER_DISCOVER_18]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_19]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_20]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_21]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_6,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_7,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_8,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_9,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_10,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_11,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_12,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_13,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_14,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_15,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_33]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_34]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_35]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_36]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_37]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_38]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_39]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_40]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_41]                = NAVTAILS_MSGSEQ_NOTHING,
};

static const u16 sIslandInfoText_NotCleared[SEAMAPMANAGER_DISCOVER_ISLAND_COUNT] = {
    [SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND]   = NAVTAILS_MSGSEQ_THATS_SOUTHERN_ISLAND,
    [SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM]     = NAVTAILS_MSGSEQ_THATS_PLANT_KINGDOM,
    [SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH] = NAVTAILS_MSGSEQ_THATS_MACHINE_LABYRINTH,
    [SEAMAPMANAGER_DISCOVER_CORAL_CAVE]        = NAVTAILS_MSGSEQ_THATS_CORAL_CAVE,
    [SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP]      = NAVTAILS_MSGSEQ_THATS_HAUNTED_SHIP,
    [SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS]    = NAVTAILS_MSGSEQ_THATS_BLIZZARD_PEAKS,
    [SEAMAPMANAGER_DISCOVER_SKY_BABYLON]       = NAVTAILS_MSGSEQ_THATS_SKY_BABYLON,
    [SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND]    = NAVTAILS_MSGSEQ_THATS_PIRATES_ISLAND,
    [SEAMAPMANAGER_DISCOVER_BIG_SWELL]         = NAVTAILS_MSGSEQ_THATS_BIG_SWELL,
    [SEAMAPMANAGER_DISCOVER_DEEP_CORE]         = NAVTAILS_MSGSEQ_THATS_DEEP_CORE,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_1,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_2,
    [SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND]     = NAVTAILS_MSGSEQ_THATS_DAIKUNS_ISLAND,
    [SEAMAPMANAGER_DISCOVER_13]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND]      = NAVTAILS_MSGSEQ_THATS_KYLOKS_ISLAND,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_3,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_4,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_5,
    [SEAMAPMANAGER_DISCOVER_18]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_19]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_20]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_21]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_6,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_7,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_8,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9]   = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_9,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_10,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_11,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_12,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_13,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_14,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_15,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16]  = NAVTAILS_MSGSEQ_THATS_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_33]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_34]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_35]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_36]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_37]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_38]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_39]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_40]                = NAVTAILS_MSGSEQ_NOTHING,
    [SEAMAPMANAGER_DISCOVER_41]                = NAVTAILS_MSGSEQ_NOTHING,
};

static const s32 sStageForIsland[SEAMAPMANAGER_DISCOVER_ISLAND_COUNT] = {
    [SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND]   = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_PLANT_KINGDOM]     = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_MACHINE_LABYRINTH] = STAGE_Z21,
    [SEAMAPMANAGER_DISCOVER_CORAL_CAVE]        = STAGE_Z31,
    [SEAMAPMANAGER_DISCOVER_HAUNTED_SHIP]      = STAGE_Z41,
    [SEAMAPMANAGER_DISCOVER_BLIZZARD_PEAKS]    = STAGE_Z51,
    [SEAMAPMANAGER_DISCOVER_SKY_BABYLON]       = STAGE_Z61,
    [SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND]    = STAGE_Z71,
    [SEAMAPMANAGER_DISCOVER_BIG_SWELL]         = STAGE_BOSS_FINAL,
    [SEAMAPMANAGER_DISCOVER_DEEP_CORE]         = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_1]   = STAGE_HIDDEN_ISLAND_1,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_2]   = STAGE_HIDDEN_ISLAND_2,
    [SEAMAPMANAGER_DISCOVER_DAIKUN_ISLAND]     = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_13]                = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND]      = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_3]   = STAGE_HIDDEN_ISLAND_3,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_4]   = STAGE_HIDDEN_ISLAND_4,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_5]   = STAGE_HIDDEN_ISLAND_5,
    [SEAMAPMANAGER_DISCOVER_18]                = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_19]                = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_20]                = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_21]                = STAGE_Z11,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_6]   = STAGE_HIDDEN_ISLAND_6,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_7]   = STAGE_HIDDEN_ISLAND_7,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_8]   = STAGE_HIDDEN_ISLAND_8,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_9]   = STAGE_HIDDEN_ISLAND_9,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_10]  = STAGE_HIDDEN_ISLAND_10,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_11]  = STAGE_HIDDEN_ISLAND_11,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_12]  = STAGE_HIDDEN_ISLAND_12,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_13]  = STAGE_HIDDEN_ISLAND_13,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_14]  = STAGE_HIDDEN_ISLAND_14,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_15]  = STAGE_HIDDEN_ISLAND_15,
    [SEAMAPMANAGER_DISCOVER_HIDDEN_ISLAND_16]  = STAGE_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_33]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_34]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_35]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_36]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_37]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_38]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_39]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_40]                = STAGE_HIDDEN_ISLAND_16,
    [SEAMAPMANAGER_DISCOVER_41]                = STAGE_HIDDEN_ISLAND_16,
};

// --------------------
// FUNCTION DECLS
// --------------------

static u16 SeaMapMenu_GetIslandInfoText(SeaMapManagerSaveFlag id);
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
    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_Navigate);
    SeaMapView_SetZoomLevel(&work->view, SEAMAP_ZOOM_NEAREST);

    CreateSeaMapEventManager();

    PlayTrack(NULL, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_SYS_SEQ_SEQ_CHART);
}

u16 SeaMapMenu_GetIslandInfoText(SeaMapManagerSaveFlag id)
{
    switch (id)
    {
        case SEAMAPMANAGER_DISCOVER_PIRATES_ISLAND:
            if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_32)
                return NAVTAILS_MSGSEQ_THATS_PIRATES_ISLAND;
            else
                return NAVTAILS_MSGSEQ_THATS_PIRATES_ISLAND_NO_MATERIAL_VER;
            break;

        case SEAMAPMANAGER_DISCOVER_KYLOK_ISLAND:
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

    BOOL madeSelection = TRUE;
    switch (manager->lastTouchedIconType)
    {
        case SEAMAPOBJECT_ISLAND_DRAW_ICON:
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_CURSOL);
            work->selectedIsland = manager->lastTouchedIcon->objWork.mapObject;
            SeaMapEventManager_ClearLastTouchedIcon();
            work->state = SeaMapMenu_State_InitIslandSelectedMenu;
            break;

        default:
            madeSelection = FALSE;
            break;
    }

    return madeSelection;
}

BOOL SeaMapMenu_ProcessMainButtons(SeaMapMenu *work)
{
    BOOL madeSelection = TRUE;

    switch (work->view.selectedButton)
    {
        case SEAMAPVIEW_BUTTON_BACK:
            gSeaMapViewExitEvent = SEAMAPVIEW_EXIT_BACK;
            NNS_SndPlayerStopSeqBySeqNo(SND_SYS_SEQ_SEQ_CHART, 16);
            work->state = SeaMapMenu_State_Close;
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_CANCELL);
            break;

        case SEAMAPVIEW_BUTTON_ZOOM_IN:
            SeaMapMenu_Action_ZoomIn(work);
            break;

        case SEAMAPVIEW_BUTTON_ZOOM_OUT:
            SeaMapMenu_Action_ZoomOut(work);
            break;

        default:
            madeSelection = FALSE;
            break;
    }

    return madeSelection;
}

BOOL SeaMapMenu_ProcessIslandSelectedButtons(SeaMapMenu *work)
{
    BOOL madeSelection = TRUE;
    switch (work->view.selectedButton)
    {
        case SEAMAPVIEW_BUTTON_LAND:
        case SEAMAPVIEW_BUTTON_RETURN_VILLAGE:
            gameState.landedIslandID = work->selectedIsland->id;
            gSeaMapViewExitEvent     = SEAMAPVIEW_EXIT_CONFIRM;
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_DECIDE);
            NNS_SndPlayerStopSeqBySeqNo(SND_SYS_SEQ_SEQ_CHART, 16);
            work->state = SeaMapMenu_State_FadeOut;
            break;

        case SEAMAPVIEW_BUTTON_CANCEL:
            NavTailsSpeak(NAVTAILS_MSGSEQ_SELECT_AN_ISLAND_TO_GO_TO, SECONDS_TO_FRAMES(10.0));
            SeaMapView_SetTouchAreaPriority(&work->view, FALSE);
            SeaMapView_SetTouchAreaCallback(&work->view, SeaMapView_TouchAreaCallback_Active);
            PlayChartSfx(SND_SYS_SEQARC_ARC_CHART_SEQ_SE_V_CANCELL);
            work->state = SeaMapMenu_State_InitMenu;
            break;

        default:
            madeSelection = FALSE;
            break;
    }

    return madeSelection;
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
    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_Navigate);

    SeaMapView_SetZoomLevelForZoomButtons(&work->view, SeaMapManager__GetZoomLevel());
    NavTailsSpeak(NAVTAILS_MSGSEQ_SELECT_AN_ISLAND_TO_GO_TO, SECONDS_TO_FRAMES(10.0));

    work->state = SeaMapMenu_State_ProcessInputs;
    work->state(work);
}

void SeaMapMenu_State_ProcessInputs(SeaMapMenu *work)
{
    SeaMapView_ProcessMapInputs(&work->view);
    SeaMapView_ProcessButtonInputs(&work->view);

    if (GetSeaMapEventManagerWork2()->lastTouchedIconType != SEAMAPOBJECT_NONE)
        SeaMapMenu_HandleIslandSelected(work);
    else
        SeaMapMenu_ProcessMainButtons(work);

    work->view.selectedButton = SEAMAPVIEW_BUTTON_NONE;
}

void SeaMapMenu_State_InitIslandSelectedMenu(SeaMapMenu *work)
{
    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_Selected);

    if (work->selectedIsland->id == SEAMAPMANAGER_DISCOVER_SOUTHERN_ISLAND)
        SeaMapView_EnableButton(&work->view, SEAMAPVIEW_BUTTON_RETURN_VILLAGE, TRUE);
    else
        SeaMapView_EnableButton(&work->view, SEAMAPVIEW_BUTTON_LAND, TRUE);

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