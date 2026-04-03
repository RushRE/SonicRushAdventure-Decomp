#include <seaMap/objects/seaMapCoralCaveIcon.h>
#include <seaMap/seaMapManager.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTION DECLS
// --------------------

void SeaMapCoralCaveIcon_Main(void);
void SeaMapCoralCaveIcon_Destructor(Task *task);

// States
void SeaMapCoralCaveIcon_State_Hidden(SeaMapCoralCaveIcon *work);
void SeaMapCoralCaveIcon_State_BeginAppearing(SeaMapCoralCaveIcon *work);
void SeaMapCoralCaveIcon_State_Appearing(SeaMapCoralCaveIcon *work);
void SeaMapCoralCaveIcon_State_BeginActive(SeaMapCoralCaveIcon *work);
void SeaMapCoralCaveIcon_State_Active(SeaMapCoralCaveIcon *work);

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapCoralCaveIcon(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject)
{
    SeaMapCoralCaveIcon *work;

    SeaMapManager *manager = SeaMapManager__GetWork();

    Task *task =
        TaskCreate(SeaMapCoralCaveIcon_Main, SeaMapCoralCaveIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapCoralCaveIcon);
    GetSeaMapEventManagerWork()->coralCaveIcon = task;

    work = TaskGetWork(task, SeaMapCoralCaveIcon);
    TaskInitWork16(work);

    if (SaveGame__GetGameProgress() >= SAVE_PROGRESS_14)
        work->state = SeaMapCoralCaveIcon_State_BeginActive;
    else
        work->state = SeaMapCoralCaveIcon_State_Hidden;

    InitSeaMapEventManagerObject(&work->objWork, task, objectType, mapObject);

    // Init island sprite
    AnimatorSprite__Init(&work->aniIcon, manager->assets.sprChCommon, objectType->animID, ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK,
                         manager->useEngineB, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(manager->useEngineB, Sprite__GetSpriteSize1FromAnim(manager->assets.sprChCommon, objectType->animID)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_13);

    work->aniIcon.pos.x   = mapObject->position.x;
    work->aniIcon.pos.y   = mapObject->position.y;
    work->aniIcon.cParam.palette = objectType->palette;

    SeaMapEventManager_SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapCoralCaveIcon_Main(void)
{
    SeaMapCoralCaveIcon *work = TaskGetWorkCurrent(SeaMapCoralCaveIcon);

    if (SeaMapEventManager_CheckVisible(&work->objWork.position, work->objWork.objectType->viewBounds) == FALSE)
    {
        DestroyCurrentTask();
    }
    else
    {
        work->state(work);
    }
}

void SeaMapCoralCaveIcon_Destructor(Task *task)
{
    SeaMapCoralCaveIcon *work = TaskGetWork(task, SeaMapCoralCaveIcon);

    AnimatorSprite__Release(&work->aniIcon);
    SeaMapEventManager_SetObjectAsInactive(&work->objWork);
    DestroySeaMapEventManagerObject(&work->objWork);

    if (gSeaMapEventManagerTaskSingleton != NULL)
        GetSeaMapEventManagerWork()->coralCaveIcon = NULL;
}

void SeaMapCoralCaveIcon_State_Hidden(SeaMapCoralCaveIcon *work)
{
    // Nothing.
}

void SeaMapCoralCaveIcon_State_BeginAppearing(SeaMapCoralCaveIcon *work)
{
    AnimatorSprite__SetAnimation(&work->aniIcon, SEAMAP_CHCOM_ANI_129);
    work->aniIcon.flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;

    work->state = SeaMapCoralCaveIcon_State_Appearing;
    work->state(work);
}

void SeaMapCoralCaveIcon_State_Appearing(SeaMapCoralCaveIcon *work)
{
    SeaMapEventManager_GetMapLocalPosition(&work->objWork.position, &work->aniIcon.pos);
    AnimatorSprite__ProcessAnimationFast(&work->aniIcon);
    AnimatorSprite__DrawFrame(&work->aniIcon);

    if ((work->aniIcon.flags & ANIMATOR_FLAG_DID_FINISH) != 0)
        work->state = SeaMapCoralCaveIcon_State_BeginActive;
}

void SeaMapCoralCaveIcon_State_BeginActive(SeaMapCoralCaveIcon *work)
{
    AnimatorSprite__SetAnimation(&work->aniIcon, SEAMAP_CHCOM_ANI_128);
    work->aniIcon.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;

    work->state = SeaMapCoralCaveIcon_State_Active;
    work->state(work);
}

void SeaMapCoralCaveIcon_State_Active(SeaMapCoralCaveIcon *work)
{
    SeaMapEventManager_GetMapLocalPosition(&work->objWork.position, &work->aniIcon.pos);
    AnimatorSprite__ProcessAnimationFast(&work->aniIcon);

    if (SeaMapManager__GetWork()->zoomLevel == 0)
    {
        AnimatorSprite__DrawFrame(&work->aniIcon);
    }
    else
    {
        AnimatorSprite__DrawFrameRotoZoom(&work->aniIcon, SeaMapManager__GetZoomOutScale(), SeaMapManager__GetZoomOutScale(), FLOAT_IDX_TO_FX16_IDX(0.0));
    }
}
