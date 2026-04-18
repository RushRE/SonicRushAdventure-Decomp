#include <seaMap/sailSeaMapView.h>
#include <seaMap/seaMapVoyagePathConfig.h>
#include <seaMap/seaMapEventTrigger.h>
#include <sail/sailManager.h>
#include <game/graphics/renderCore.h>

// --------------------
// VARIABLES
// --------------------

static const BOOL sSeaMapViewButtonState_None[SEAMAPVIEW_BUTTON_COUNT] = {
    [SEAMAPVIEW_BUTTON_BACK] = FALSE,        [SEAMAPVIEW_BUTTON_ZOOM_IN] = FALSE, [SEAMAPVIEW_BUTTON_ZOOM_OUT] = FALSE, [SEAMAPVIEW_BUTTON_CONFIRM_PATH] = FALSE,
    [SEAMAPVIEW_BUTTON_CANCEL_PATH] = FALSE, [SEAMAPVIEW_BUTTON_LAND] = FALSE,    [SEAMAPVIEW_BUTTON_CANCEL] = FALSE,   [SEAMAPVIEW_BUTTON_RETURN_VILLAGE] = FALSE
};

// --------------------
// FUNCTION DECLS
// --------------------

static void SailSeaMapView_Main(void);
static void SailSeaMapView_Destructor(Task *task);
static void SailSeaMapView_FinalizePosition(SailSeaMapView *work);
static void SailSeaMapView_HandleProgress(SailSeaMapView *work);
static u16 SailSeaMapView_GetNodeAngle(SeaMapManagerNode *nextNode, SeaMapManagerNode *prevNode);
static void SailSeaMapView_PreparePosition(SailSeaMapView *work);
static void SailSeaMapView_State_FadeOut(SailSeaMapView *work);
static void SailSeaMapView_State_ConfigureButtons(SailSeaMapView *work);
static void SailSeaMapView_State_Idle(SailSeaMapView *work);

// --------------------
// FUNCTIONS
// --------------------

void CreateSailSeaMapView(ShipType type)
{
    gSeaMapViewType      = SEAMAPVIEW_TYPE_SAILING;
    gSeaMapViewExitEvent = SEAMAPVIEW_EXIT_NONE;

    s16 prevBrightness = VRAMSystem__GFXControl[GRAPHICS_ENGINE_B]->brightness;
    SeaMapManager__Create(GRAPHICS_ENGINE_B, type, TRUE);
    VRAMSystem__GFXControl[GRAPHICS_ENGINE_B]->brightness = prevBrightness;

    SeaMapManager__LoadMapBackground();

    gSeaMapTaskSingleton = TaskCreate(SailSeaMapView_Main, SailSeaMapView_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xFF, TASK_GROUP(0), SailSeaMapView);
    SailSeaMapView *work = TaskGetWork(gSeaMapTaskSingleton, SailSeaMapView);
    TaskInitWork16(work);

    InitSeaMapView(&work->view, GRAPHICS_ENGINE_B, type, FALSE);
    SeaMapManager__LoadNodeList();
    SeaMapView_DrawFinalizedVoyagePath();

    work->state = SailSeaMapView_State_FadeOut;

    SeaMapManagerNode *startNode = SeaMapManager__GetStartNode();
    SeaMapManager__GetPosition2(startNode->position.x, startNode->position.y, &work->position.x, &work->position.y);

    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_None);
    CreateSeaMapEventManager();

    work->boatIcon = (SeaMapBoatIcon *)SeaMapEventManager_CreateObject(SEAMAPOBJECT_BOAT_ICON, FX32_TO_WHOLE(work->position.x), FX32_TO_WHOLE(work->position.y), 0, 0, 0);
    SetSeaMapViewPosition(work->position.x, work->position.y);

    InitSeaMapVoyagePathConfig();
}

void DestroySailSeaMapView(void)
{
    DestroyTask(gSeaMapTaskSingleton);
    DestroySeaMapEventManager();
    SeaMapManager__Destroy();
}

void SailSeaMapView_GetPosition(fx32 *x, fx32 *y)
{
    SailSeaMapView *seaMapView = SailSeaMapView_GetWork();

    if (x != NULL)
        *x = seaMapView->position.x;

    if (y != NULL)
        *y = seaMapView->position.y;
}

SailSeaMapView *SailSeaMapView_GetWork(void)
{
    return TaskGetWork(gSeaMapTaskSingleton, SailSeaMapView);
}

fx32 SailSeaMapView_GetVoyageCompetionPercent(void)
{
    SailManager *manager             = SailManager__GetWork();
    SailVoyageManager *voyageManager = manager->voyageManager;

    return voyageManager->unknownDistance;
}

s32 SailSeaMapView_GetNodesFromPercent(s32 progress, u16 *nodeX, u16 *nodeY, SeaMapManagerNode **prevNodePtr, SeaMapManagerNode **nextNodePtr)
{
    SeaMapManagerNode *prevNode;
    SeaMapManagerNode *nextNode;

    BOOL reachedEnd = FALSE;

    prevNode = SeaMapManager__GetStartNode();

    for (nextNode = SeaMapManager__GetNextNode(prevNode); nextNode != NULL; nextNode = SeaMapManager__GetNextNode(nextNode))
    {
        fx32 distance = nextNode->distance;
        if (progress <= distance)
            break;

        prevNode = nextNode;
        progress -= distance;
    }

    if (nextNode == NULL)
    {
        *nodeX     = prevNode->position.x;
        *nodeY     = prevNode->position.y;
        nextNode   = prevNode;
        prevNode   = SeaMapManager__GetPrevNode(prevNode);
        reachedEnd = TRUE;
    }
    else
    {
        s16 percent = FX_Div(progress, nextNode->distance);

        fx32 prevX = FX32_FROM_WHOLE(prevNode->position.x);
        fx32 nextX = FX32_FROM_WHOLE(nextNode->position.x);
        *nodeX     = FX32_TO_WHOLE(prevX + MultiplyFX(nextX - prevX, percent));

        fx32 prevY = FX32_FROM_WHOLE(prevNode->position.y);
        fx32 nextY = FX32_FROM_WHOLE(nextNode->position.y);
        *nodeY     = FX32_TO_WHOLE(prevY + MultiplyFX(nextY - prevY, percent));
    }

    *prevNodePtr = prevNode;
    *nextNodePtr = nextNode;

    if (reachedEnd)
        return 4;

    return 0;
}

void SailSeaMapView_Main(void)
{
    SailSeaMapView *work = TaskGetWorkCurrent(SailSeaMapView);

    work->state(work);

    SailSeaMapView_PreparePosition(work);
    SailSeaMapView_HandleProgress(work);
    SailSeaMapView_FinalizePosition(work);
}

void SailSeaMapView_Destructor(Task *task)
{
    SailSeaMapView *work = TaskGetWork(task, SailSeaMapView);

    ReleaseSeaMapVoyagePathConfig();
    ReleaseSeaMapView(&work->view);

    gSeaMapViewType      = SEAMAPVIEW_TYPE_NONE;
    gSeaMapTaskSingleton = NULL;
}

void SailSeaMapView_FinalizePosition(SailSeaMapView *work)
{
    SeaMapView_ReadPosition(&work->view);
}

void SailSeaMapView_HandleProgress(SailSeaMapView *work)
{
    SeaMapManagerNode *prevNode;
    SeaMapManagerNode *nextNode;

    s32 progress;
    if (work->useStoredProgress)
        progress = work->storedVoyageProgress;
    else
        progress = SailSeaMapView_GetVoyageCompetionPercent();

    u16 nodeY;
    u16 nodeX;
    switch (SailSeaMapView_GetNodesFromPercent(progress, &nodeX, &nodeY, &prevNode, &nextNode))
    {
        case 0:
            work->storedVoyageProgress = progress;
            break;

        case 3: // NOTE: 'SailSeaMapView_GetNodesFromPercent' never returns 3? this logic doesn't appear to ever be called.
            work->useStoredProgress = TRUE;
            SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_EVENT_SAILING_UNKNOWN, NULL, NULL);
            break;

        case 4:
            work->storedVoyageProgress = progress;
            work->useStoredProgress    = TRUE;
            SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_EVENT_REACHED_END, NULL, NULL);
            break;
    }

    u16 unknownY;
    u16 unknownX;
    SeaMapManager__GetPosition2(nodeX, nodeY, &work->position.x, &work->position.y);
    SeaMapManager__Func_2043B0C(nodeX, nodeY, &unknownX, &unknownY);
    SeaMapManager__DiscoverMap_Elipse(unknownX, unknownY, 3, 3);
    SeaMapManager__EnableDrawFlags(SEAMAPMANAGER_DRAWFLAG_MAPMASK);

    work->boatIcon->objWork.position.x = FX32_TO_WHOLE(work->position.x);
    work->boatIcon->objWork.position.y = FX32_TO_WHOLE(work->position.y);

    u16 angle = SailSeaMapView_GetNodeAngle(prevNode, nextNode);
    if (angle >= FLOAT_DEG_TO_IDX(90.0) && angle < FLOAT_DEG_TO_IDX(270.0))
        SeaMapEventManager_SetBoatDirection(work->boatIcon, TRUE);
    else
        SeaMapEventManager_SetBoatDirection(work->boatIcon, FALSE);
}

u16 SailSeaMapView_GetNodeAngle(SeaMapManagerNode *nextNode, SeaMapManagerNode *prevNode)
{
    return FX_Atan2Idx(FX32_FROM_WHOLE(prevNode->position.y - nextNode->position.y), FX32_FROM_WHOLE(prevNode->position.x - nextNode->position.x));
}

void SailSeaMapView_PreparePosition(SailSeaMapView *work)
{
    fx16 y, x;

    SeaMapManager__Func_2043A04(work->position.x, work->position.y, &x, &y);
    if (x < 64 || x > (HW_LCD_WIDTH - 64) || y < 48 || y > (HW_LCD_HEIGHT - 48))
        SetSeaMapViewPosition(work->position.x, work->position.y);
}

void SailSeaMapView_State_FadeOut(SailSeaMapView *work)
{
    if (SeaMapView_FadeActiveScreen_ToDefault(&work->view))
        work->state = SailSeaMapView_State_ConfigureButtons;
}

void SailSeaMapView_State_ConfigureButtons(SailSeaMapView *work)
{
    SeaMapView_EnableMultipleButtons(&work->view, sSeaMapViewButtonState_None);

    work->state = SailSeaMapView_State_Idle;
    work->state(work);
}

void SailSeaMapView_State_Idle(SailSeaMapView *work)
{
    // Do nothing
}
