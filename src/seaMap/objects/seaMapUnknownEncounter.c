#include <seaMap/objects/seaMapUnknownEncounter.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapEventTrigger.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>
#include <seaMap/sailSeaMapView.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapUnknownEncounter_Main(void);
static void SeaMapUnknownEncounter_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapUnknownEncounter(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject)
{
    SeaMapUnknownEncounter *work;

    SeaMapManager *manager = SeaMapManager__GetWork();
    UNUSED(manager);

    if (SeaMapManager__GetSaveFlag(mapObject->id))
        return NULL;

    Task *task = TaskCreate(SeaMapUnknownEncounter_Main, SeaMapUnknownEncounter_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapUnknownEncounter);

    work = TaskGetWork(task, SeaMapUnknownEncounter);
    TaskInitWork16(work);

    InitSeaMapEventManagerObject(&work->objWork, task, objectType, mapObject);
    SeaMapEventManager_SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapUnknownEncounter_Main(void)
{
    SeaMapUnknownEncounter *work = TaskGetWorkCurrent(SeaMapUnknownEncounter);

    SeaMapLayoutObject *mapObject = work->objWork.mapObject;
    if (SeaMapEventManager_CheckVisible(&work->objWork.position, work->objWork.objectType->viewBounds) == FALSE)
    {
        DestroyCurrentTask();
    }
    else
    {
        ViewRect viewRect;
        fx32 y, x;

        SeaMapEventManager_GetViewRect(&mapObject->box, mapObject->position.x, mapObject->position.y, &viewRect);
        SailSeaMapView_GetPosition(&x, &y);

        if (SeaMapEventManager_PointInViewRect(viewRect.left, viewRect.top, viewRect.right, viewRect.bottom, x, y))
            SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_EVENT_UNKNOWN_ENCOUNTER, mapObject, NULL);
    }
}

void SeaMapUnknownEncounter_Destructor(Task *task)
{
    SeaMapUnknownEncounter *work = TaskGetWork(task, SeaMapUnknownEncounter);

    SeaMapEventManager_SetObjectAsInactive(&work->objWork);
    DestroySeaMapEventManagerObject(&work->objWork);
}

BOOL SeaMapUnknownEncounter_ArrivalCheck(SeaMapLayoutObject *mapObject, fx32 x, fx32 y, BOOL ignoreDiscoveryCheck)
{
    if (SeaMapManager__GetSaveFlag(mapObject->id))
        return FALSE;
        
    return SeaMapEventManager_ViewElipseCheck(mapObject, x, y);
}
