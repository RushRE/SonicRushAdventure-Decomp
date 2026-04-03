#include <seaMap/objects/seaMapJohnnyIcon.h>
#include <seaMap/seaMapView.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapEventTrigger.h>
#include <seaMap/sailSeaMapView.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapJohnnyIcon_Main(void);
static void SeaMapJohnnyIcon_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapJohnnyIcon(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject)
{
    SeaMapJohnnyIcon *work;

    SeaMapManager *manager = SeaMapManager__GetWork();
    UNUSED(manager);

    if ((mapObject->usrFlags & SEAMAPJOHNNYICON_FLAG_STORY_EVENT) != 0)
    {
        // Hide this icon if we've encountered johnny for the first time
        if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_12)
            return NULL;
    }
    else
    {
        // Hide this icon if we've yet to encounter johnny for the first time
        if (SaveGame__GetGameProgress() < SAVE_PROGRESS_12)
            return NULL;
    }

    Task *task = TaskCreate(SeaMapJohnnyIcon_Main, SeaMapJohnnyIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapJohnnyIcon);

    work = TaskGetWork(task, SeaMapJohnnyIcon);
    TaskInitWork16(work);

    InitSeaMapEventManagerObject(&work->objWork, task, objectType, mapObject);
    SeaMapEventManager_SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapJohnnyIcon_Main(void)
{
    SeaMapJohnnyIcon *work = TaskGetWorkCurrent(SeaMapJohnnyIcon);

    SeaMapLayoutObject *mapObject = work->objWork.mapObject;
    if (SeaMapEventManager_CheckVisible(&work->objWork.position, work->objWork.objectType->viewBounds) == FALSE)
    {
        DestroyCurrentTask();
    }
    else
    {
        if (GetSeaMapViewType() == SEAMAPVIEW_TYPE_SAILING)
        {
            ViewRect viewRect;
            fx32 y, x;

            SeaMapEventManager_GetViewRect(&mapObject->box, mapObject->position.x, mapObject->position.y, &viewRect);
            SailSeaMapView_GetPosition(&x, &y);

            if (SeaMapEventManager_PointInViewRect(viewRect.left, viewRect.top, viewRect.right, viewRect.bottom, x, y))
                SeaMapEventTrigger_DoEvent(SEAMAPEVENTTRIGGER_EVENT_RIVAL_ENCOUNTER, mapObject, NULL);
        }

        if (SeaMapEventManager_CheckObjectPosDiscoveredOnMap(mapObject))
        {
            SeaMapEventManager *manager = GetSeaMapEventManagerWork();
            UNUSED(manager);

            AnimatorSprite *aniJohnny;
            if (SeaMapManager__GetSaveFlag(mapObject->id))
                aniJohnny = &GetSeaMapEventManagerWork()->aniJohnnyDefeated;
            else
                aniJohnny = &GetSeaMapEventManagerWork()->aniJohnny;

            SeaMapEventManager_GetMapLocalPosition(&work->objWork.position, &aniJohnny->pos);
            AnimatorSprite__DrawFrame(aniJohnny);
        }
    }
}

void SeaMapJohnnyIcon_Destructor(Task *task)
{
    SeaMapJohnnyIcon *work = TaskGetWork(task, SeaMapJohnnyIcon);

    SeaMapEventManager_SetObjectAsInactive(&work->objWork);
    DestroySeaMapEventManagerObject(&work->objWork);
}

BOOL SeaMapJohnnyIcon_ArrivalCheck(SeaMapLayoutObject *mapObject, fx32 x, fx32 y, BOOL ignoreDiscoveryCheck)
{
    if ((mapObject->usrFlags & SEAMAPJOHNNYICON_FLAG_STORY_EVENT) != 0)
    {
        // Hide this icon if we've encountered johnny for the first time
        if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_12)
            return FALSE;
    }
    else
    {
        // Hide this icon if we've yet to encounter johnny for the first time
        if (SaveGame__GetGameProgress() < SAVE_PROGRESS_12)
            return FALSE;
    }

    return SeaMapEventManager_ViewElipseCheck(mapObject, x, y);
}
