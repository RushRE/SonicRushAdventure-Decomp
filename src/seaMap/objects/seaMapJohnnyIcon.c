#include <seaMap/objects/seaMapJohnnyIcon.h>
#include <seaMap/seaMapView.h>
#include <seaMap/seaMapManager.h>
#include <seaMap/seaMapUnknown204A9E4.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void SailSeaMapView__GetPosition(fx32 *x, fx32 *y);

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapJohnnyIcon_Main(void);
static void SeaMapJohnnyIcon_Destructor(Task *task);

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapJohnnyIcon(CHEVObjectType *objectType, CHEVObject *mapObject)
{
    SeaMapJohnnyIcon *work;

    SeaMapManager *manager = SeaMapManager__GetWork();
    UNUSED(manager);

    if ((mapObject->flags2 & 0x1) != 0)
    {
        if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_12)
            return NULL;
    }
    else
    {
        if (SaveGame__GetGameProgress() < SAVE_PROGRESS_12)
            return NULL;
    }

    Task *task = TaskCreate(SeaMapJohnnyIcon_Main, SeaMapJohnnyIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapJohnnyIcon);

    work = TaskGetWork(task, SeaMapJohnnyIcon);
    TaskInitWork16(work);

    SeaMapEventManager__InitMapObject(&work->objWork, task, objectType, mapObject);
    SeaMapEventManager__SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapJohnnyIcon_Main(void)
{
    SeaMapJohnnyIcon *work = TaskGetWorkCurrent(SeaMapJohnnyIcon);

    CHEVObject *mapObject = work->objWork.mapObject;
    if (SeaMapEventManager__ObjectInBounds(&work->objWork.position, work->objWork.objectType->viewBounds) == FALSE)
    {
        DestroyCurrentTask();
    }
    else
    {
        if (SeaMapView__GetMode() == 5)
        {
            ViewRect viewRect;
            fx32 y, x;

            SeaMapEventManager__GetViewRect(&mapObject->box, mapObject->position.x, mapObject->position.y, &viewRect);
            SailSeaMapView__GetPosition(&x, &y);

            if (SeaMapEventManager__PointInViewRect(viewRect.left, viewRect.top, viewRect.right, viewRect.bottom, x, y))
                SeaMapUnknown204A9E4__RunCallbacks(5, mapObject, 0);
        }

        if (SeaMapEventManager__Func_204756C(mapObject))
        {
            SeaMapEventManager *manager = SeaMapEventManager__GetWork();
            UNUSED(manager);

            AnimatorSprite *aniJohnny;
            if (SeaMapManager__GetSaveFlag(mapObject->unlockID))
                aniJohnny = &SeaMapEventManager__GetWork()->aniJohnnyDefeated;
            else
                aniJohnny = &SeaMapEventManager__GetWork()->aniJohnny;

            SeaMapEventManager__Func_20474FC(&work->objWork.position, &aniJohnny->pos);
            AnimatorSprite__DrawFrame(aniJohnny);
        }
    }
}

void SeaMapJohnnyIcon_Destructor(Task *task)
{
    SeaMapJohnnyIcon *work = TaskGetWork(task, SeaMapJohnnyIcon);

    SeaMapEventManager__SetObjectAsInactive(&work->objWork);
    SeaMapEventManager__DestroyObject(&work->objWork);
}

BOOL SeaMapJohnnyIcon_ViewCheck(CHEVObject *mapObject, fx32 x, fx32 y, BOOL flag)
{
    if ((mapObject->flags2 & 0x1) != 0)
    {
        if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_12)
            return FALSE;
    }
    else
    {
        if (SaveGame__GetGameProgress() < SAVE_PROGRESS_12)
            return FALSE;
    }

    return SeaMapEventManager__ViewRectCheck2(mapObject, x, y);
}
