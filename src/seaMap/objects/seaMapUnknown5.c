#include <seaMap/objects/seaMapUnknown5.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapUnknown204A9E4.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTION DECLS
// --------------------

NOT_DECOMPILED void SailSeaMapView__GetPosition(fx32 *x, fx32 *y);

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapUnknown5(CHEVObjectType *objectType, CHEVObject *mapObject)
{
    SeaMapUnknown5 *work;

    SeaMapManager *manager = SeaMapManager__GetWork();
    UNUSED(manager);

    if (SeaMapManager__GetSaveFlag(mapObject->unlockID))
        return NULL;

    Task *task = TaskCreate(SeaMapUnknown5_Main, SeaMapUnknown5_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapUnknown5);

    work = TaskGetWork(task, SeaMapUnknown5);
    TaskInitWork16(work);

    SeaMapEventManager__InitMapObject(&work->objWork, task, objectType, mapObject);
    SeaMapEventManager__SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapUnknown5_Main(void)
{
    SeaMapUnknown5 *work = TaskGetWorkCurrent(SeaMapUnknown5);

    CHEVObject *mapObject = work->objWork.mapObject;
    if (SeaMapEventManager__ObjectInBounds(&work->objWork.position, work->objWork.objectType->viewBounds) == FALSE)
    {
        DestroyCurrentTask();
    }
    else
    {
        ViewRect viewRect;
        fx32 y, x;

        SeaMapEventManager__GetViewRect(&mapObject->box, mapObject->position.x, mapObject->position.y, &viewRect);
        SailSeaMapView__GetPosition(&x, &y);

        if (SeaMapEventManager__PointInViewRect(viewRect.left, viewRect.top, viewRect.right, viewRect.bottom, x, y))
            SeaMapUnknown204A9E4__RunCallbacks(6, mapObject, 0);
    }
}

void SeaMapUnknown5_Destructor(Task *task)
{
    SeaMapUnknown5 *work = TaskGetWork(task, SeaMapUnknown5);

    SeaMapEventManager__SetObjectAsInactive(&work->objWork);
    SeaMapEventManager__DestroyObject(&work->objWork);
}

BOOL SeaMapUnknown5_ViewCheck(CHEVObject *mapObject, fx32 x, fx32 y, BOOL flag)
{
    if (SeaMapManager__GetSaveFlag(mapObject->unlockID))
        return FALSE;
        
    return SeaMapEventManager__ViewRectCheck2(mapObject, x, y);
}
