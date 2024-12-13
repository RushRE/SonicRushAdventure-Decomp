#include <seaMap/objects/seaMapTargetFlagIcon.h>
#include <seaMap/seaMapView.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *SeaMapTargetFlagIcon__Create(CHEVObjectType *objectType, CHEVObject *mapObject)
{
    SeaMapManager *manager = SeaMapManager__GetWork();

    u32 mode = SeaMapView__GetMode();
    switch (mode)
    {
        case 2:
            return 0;

        default:
            break;
    }

    // Check if there's a flag that needs displaying
    u32 count = SaveGame__Func_205D65C(mode);
    u16 i     = 0;
    for (; i < count; i++)
    {
        if (mapObject->unlockID == SaveGame__Func_205D758(i))
            break;
    }

    if (i == count)
        return NULL;

    Task *task =
        TaskCreate(SeaMapTargetFlagIcon__Main, SeaMapTargetFlagIcon__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapTargetFlagIcon);

    SeaMapTargetFlagIcon *work = TaskGetWork(task, SeaMapTargetFlagIcon);
    TaskInitWork16(work);

    SeaMapEventManager__InitMapObject(&work->objWork, task, objectType, mapObject);
    SeaMapEventManager__SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapTargetFlagIcon__Main(void)
{
    SeaMapTargetFlagIcon *work = TaskGetWorkCurrent(SeaMapTargetFlagIcon);

    if (!SeaMapEventManager__ObjectInBounds(&work->objWork.position, work->objWork.objectType->viewBounds))
    {
        DestroyCurrentTask();
    }
    else
    {
        SeaMapEventManager *manager = SeaMapEventManager__GetWork();

        SeaMapEventManager__Func_20474FC(&work->objWork.position, &manager->aniTargetFlag.pos);
        AnimatorSprite__DrawFrame(&manager->aniTargetFlag);
    }
}

void SeaMapTargetFlagIcon__Destructor(Task *task)
{
    SeaMapTargetFlagIcon *work = TaskGetWork(task, SeaMapTargetFlagIcon);

    SeaMapEventManager__SetObjectAsInactive(&work->objWork);
    SeaMapEventManager__DestroyObject(&work->objWork);
}