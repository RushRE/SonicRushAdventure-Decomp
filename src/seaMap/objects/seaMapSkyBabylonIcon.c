#include <seaMap/objects/seaMapSkyBabylonIcon.h>
#include <seaMap/seaMapManager.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void SeaMapSkyBabylonIcon_Main(void);
static void SeaMapSkyBabylonIcon_Destructor(Task *task);

// States
static void SeaMapSkyBabylonIcon_State_Hidden(SeaMapSkyBabylonIcon *work);
static void SeaMapSkyBabylonIcon_State_Appear(SeaMapSkyBabylonIcon *work);
static void SeaMapSkyBabylonIcon_State_BeginHover(SeaMapSkyBabylonIcon *work);
static void SeaMapSkyBabylonIcon_State_Hovering(SeaMapSkyBabylonIcon *work);

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapSkyBabylonIcon(CHEVObjectType *objectType, CHEVObject *mapObject)
{
    SeaMapSkyBabylonIcon *work;

    SeaMapManager *manager = SeaMapManager__GetWork();

    Task *task =
        TaskCreate(SeaMapSkyBabylonIcon_Main, SeaMapSkyBabylonIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapSkyBabylonIcon);
    SeaMapEventManager__GetWork()->skyBabylonIcon = task;

    work = TaskGetWork(task, SeaMapSkyBabylonIcon);
    TaskInitWork16(work);

    if (SaveGame__GetUnknownProgress2() >= 4)
        work->state = SeaMapSkyBabylonIcon_State_BeginHover;
    else
        work->state = SeaMapSkyBabylonIcon_State_Hidden;

    SeaMapEventManager__InitMapObject(&work->objWork, task, objectType, mapObject);

    // Init island sprite
    AnimatorSprite__Init(&work->aniIcon, manager->assets.sprChCommon, objectType->animID, ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK,
                         manager->useEngineB, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(manager->useEngineB, Sprite__GetSpriteSize1FromAnim(manager->assets.sprChCommon, objectType->animID)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_13);

    work->aniIcon.pos.x   = mapObject->position.x;
    work->aniIcon.pos.y   = mapObject->position.y;
    work->aniIcon.palette = objectType->palette;

    // Init island shadow sprite
    AnimatorSprite__Init(&work->aniShadow, manager->assets.sprChCommon, 132, ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, manager->useEngineB, PIXEL_MODE_SPRITE,
                         VRAMSystem__AllocSpriteVram(manager->useEngineB, Sprite__GetSpriteSize1FromAnim(manager->assets.sprChCommon, 132)), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_15);

    work->aniShadow.palette = PALETTE_ROW_9;

    SeaMapEventManager__SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

void SeaMapSkyBabylonIcon_Main(void)
{
    SeaMapSkyBabylonIcon *work = TaskGetWorkCurrent(SeaMapSkyBabylonIcon);

    if (!SeaMapEventManager__ObjectInBounds(&work->objWork.position, work->objWork.objectType->viewBounds))
    {
        DestroyCurrentTask();
    }
    else
    {
        work->angle += 182;
        work->state(work);
    }
}

void SeaMapSkyBabylonIcon_Destructor(Task *task)
{
    SeaMapSkyBabylonIcon *work = TaskGetWork(task, SeaMapSkyBabylonIcon);

    AnimatorSprite__Release(&work->aniIcon);
    AnimatorSprite__Release(&work->aniShadow);
    SeaMapEventManager__SetObjectAsInactive(&work->objWork);
    SeaMapEventManager__DestroyObject(&work->objWork);

    if (SeaMapEventManager__Singleton != NULL)
        SeaMapEventManager__GetWork()->skyBabylonIcon = NULL;
}

void SeaMapSkyBabylonIcon_State_Hidden(SeaMapSkyBabylonIcon *work)
{
    // Nothing
}

void SeaMapSkyBabylonIcon_State_BeginAppear(SeaMapSkyBabylonIcon *work)
{
    AnimatorSprite__SetAnimation(&work->aniIcon, 131);
    work->aniIcon.flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;

    work->state = SeaMapSkyBabylonIcon_State_Appear;
    work->state(work);
}

void SeaMapSkyBabylonIcon_State_Appear(SeaMapSkyBabylonIcon *work)
{
    s16 oscillation = FX32_TO_WHOLE(SinFX(work->angle) * 3);

    Vec2Fx16 pos;
    pos.x = work->objWork.position.x;
    pos.y = work->objWork.position.y + oscillation;

    SeaMapEventManager__Func_20474FC(&pos, &work->aniIcon.pos);
    AnimatorSprite__ProcessAnimationFast(&work->aniIcon);
    AnimatorSprite__DrawFrame(&work->aniIcon);

    work->aniShadow.pos.x = work->aniIcon.pos.x;
    work->aniShadow.pos.y = work->aniIcon.pos.y;
    AnimatorSprite__ProcessAnimationFast(&work->aniShadow);
    AnimatorSprite__DrawFrame(&work->aniShadow);

    if ((work->aniIcon.flags & ANIMATOR_FLAG_DID_FINISH) != 0)
    {
        work->state = SeaMapSkyBabylonIcon_State_BeginHover;
    }
}

void SeaMapSkyBabylonIcon_State_BeginHover(SeaMapSkyBabylonIcon *work)
{
    AnimatorSprite__SetAnimation(&work->aniIcon, 130);
    work->aniIcon.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;

    work->state = SeaMapSkyBabylonIcon_State_Hovering;
    work->state(work);
}

void SeaMapSkyBabylonIcon_State_Hovering(SeaMapSkyBabylonIcon *work)
{
    s16 oscillation = FX32_TO_WHOLE(SinFX(work->angle) * 3);

    Vec2Fx16 pos;
    pos.x = work->objWork.position.x;
    pos.y = work->objWork.position.y + oscillation;

    SeaMapEventManager__Func_20474FC(&pos, &work->aniIcon.pos);
    AnimatorSprite__ProcessAnimationFast(&work->aniIcon);

    work->aniShadow.pos.x = work->aniIcon.pos.x;
    work->aniShadow.pos.y = work->aniIcon.pos.y;
    AnimatorSprite__ProcessAnimationFast(&work->aniShadow);

    if (SeaMapManager__GetWork()->zoomLevel == 0)
    {
        AnimatorSprite__DrawFrame(&work->aniIcon);
        AnimatorSprite__DrawFrame(&work->aniShadow);
    }
    else
    {
        AnimatorSprite__DrawFrameRotoZoom(&work->aniIcon, SeaMapManager__GetZoomOutScale(), SeaMapManager__GetZoomOutScale(), 0);
        AnimatorSprite__DrawFrameRotoZoom(&work->aniShadow, SeaMapManager__GetZoomOutScale(), SeaMapManager__GetZoomOutScale(), 0);
    }
}
