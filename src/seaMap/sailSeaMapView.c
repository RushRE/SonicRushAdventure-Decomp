#include <seaMap/sailSeaMapView.h>
#include <seaMap/seaMapUnknown204AB60.h>
#include <seaMap/seaMapUnknown204A9E4.h>
#include <sail/sailManager.h>
#include <game/graphics/renderCore.h>

// --------------------
// VARIABLES
// --------------------

static const BOOL sailSeaMapViewButtonStates[] = { FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE };

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
    seaMapViewMode     = 5;
    seaMapViewUnknown1 = 0;

    s16 prevBrightness = VRAMSystem__GFXControl[GRAPHICS_ENGINE_B]->brightness;
    SeaMapManager__Create(GRAPHICS_ENGINE_B, type, TRUE);
    VRAMSystem__GFXControl[GRAPHICS_ENGINE_B]->brightness = prevBrightness;

    SeaMapManager__Func_2043D08();

    SeaMapView__sVars.singleton =
        TaskCreate(SailSeaMapView_Main, SailSeaMapView_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0xFF, TASK_GROUP(0), SailSeaMapView);
    SailSeaMapView *work = TaskGetWork(SeaMapView__sVars.singleton, SailSeaMapView);
    TaskInitWork16(work);

    SeaMapView__InitView(&work->view, GRAPHICS_ENGINE_B, type, FALSE);
    SeaMapManager__Func_20444E8();
    SeaMapView__Func_203F8D4();

    work->state = SailSeaMapView_State_FadeOut;

    SeaMapManagerNode *startNode = SeaMapManager__GetStartNode();
    SeaMapManager__GetPosition2(startNode->position.x, startNode->position.y, &work->position.x, &work->position.y);

    SeaMapView__EnableMultipleButtons(&work->view, sailSeaMapViewButtonStates);
    SeaMapEventManager__Create();

    work->boatIcon = (SeaMapBoatIcon *)SeaMapEventManager__CreateObject(SEAMAPOBJECT_BOAT_ICON, FX32_TO_WHOLE(work->position.x), FX32_TO_WHOLE(work->position.y), 0, 0, 0);
    SeaMapView__Func_203DCE0(work->position.x, work->position.y);
    
    SeaMapUnknown204AB60__Init();
}

void DestroySailSeaMapView(void)
{
    DestroyTask(SeaMapView__sVars.singleton);
    SeaMapEventManager__Destroy();
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
    return TaskGetWork(SeaMapView__sVars.singleton, SailSeaMapView);
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

    SeaMapUnknown204AB60__Func_204ABB0();
    SeaMapView__ReleaseAssets(&work->view);

    seaMapViewMode              = 0;
    SeaMapView__sVars.singleton = NULL;
}

void SailSeaMapView_FinalizePosition(SailSeaMapView *work)
{
    SeaMapView__Func_203F770(&work->view);
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

        case 3: // 'SailSeaMapView_GetNodesFromPercent' never returns 3? this logic doesn't appear to ever be called!
            work->useStoredProgress = TRUE;
            SeaMapUnknown204A9E4__RunCallbacks(3, NULL, 0);
            break;

        case 4:
            work->storedVoyageProgress = progress;
            work->useStoredProgress    = TRUE;
            SeaMapUnknown204A9E4__RunCallbacks(4, NULL, 0);
            break;
    }

    u16 unknownY;
    u16 unknownX;
    SeaMapManager__GetPosition2(nodeX, nodeY, &work->position.x, &work->position.y);
    SeaMapManager__Func_2043B0C(nodeX, nodeY, &unknownX, &unknownY);
    SeaMapManager__Func_20442C8(unknownX, unknownY, 3, 3);
    SeaMapManager__EnableDrawFlags(1);

    work->boatIcon->objWork.position.x = FX32_TO_WHOLE(work->position.x);
    work->boatIcon->objWork.position.y = FX32_TO_WHOLE(work->position.y);

    u16 angle = SailSeaMapView_GetNodeAngle(prevNode, nextNode);
    if (angle >= FLOAT_DEG_TO_IDX(90.0) && angle < FLOAT_DEG_TO_IDX(270.0))
        SeaMapEventManager__SetBoatFlipX(&work->boatIcon->objWork, 1);
    else
        SeaMapEventManager__SetBoatFlipX(&work->boatIcon->objWork, 0);
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
        SeaMapView__Func_203DCE0(work->position.x, work->position.y);
}

void SailSeaMapView_State_FadeOut(SailSeaMapView *work)
{
    if (SeaMapView__FadeToBlack(&work->view))
        work->state = SailSeaMapView_State_ConfigureButtons;
}

void SailSeaMapView_State_ConfigureButtons(SailSeaMapView *work)
{
    SeaMapView__EnableMultipleButtons(&work->view, sailSeaMapViewButtonStates);

    work->state = SailSeaMapView_State_Idle;
    work->state(work);
}

void SailSeaMapView_State_Idle(SailSeaMapView *work)
{
    // Do nothing
}
