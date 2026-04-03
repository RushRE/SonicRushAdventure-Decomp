#include <seaMap/objects/seaMapStylusIcon.h>
#include <seaMap/seaMapManager.h>
#include <game/graphics/renderCore.h>
#include <game/save/saveGame.h>

// --------------------
// FUNCTION DECLS
// --------------------

// Helpers
static u32 SeaMapStylusIcon_GetSpriteSize(void);

// Task Funcs
static void SeaMapStylusIcon_Main(void);
static void SeaMapStylusIcon_Destructor(Task *task);

// States
static void SeaMapStylusIcon_State_BeginPressDelay(SeaMapStylusIcon *work);
static void SeaMapStylusIcon_State_PressDelay(SeaMapStylusIcon *work);
static void SeaMapStylusIcon_State_BeginStylusPress(SeaMapStylusIcon *work);
static void SeaMapStylusIcon_State_StylusPress(SeaMapStylusIcon *work);
static void SeaMapStylusIcon_State_BeginStylusMove(SeaMapStylusIcon *work);
static void SeaMapStylusIcon_State_StylusMove(SeaMapStylusIcon *work);
static void SeaMapStylusIcon_State_BeginReleaseDelay(SeaMapStylusIcon *work);
static void SeaMapStylusIcon_State_ReleaseDelay(SeaMapStylusIcon *work);
static void SeaMapStylusIcon_State_BeginStylusRelease(SeaMapStylusIcon *work);
static void SeaMapStylusIcon_State_StylusRelease(SeaMapStylusIcon *work);

// --------------------
// FUNCTIONS
// --------------------

SeaMapObject *CreateSeaMapStylusIcon(const SeaMapLayoutObjectType *objectType, SeaMapLayoutObject *mapObject)
{
    SeaMapStylusIcon *work;

    SeaMapManager *manager = SeaMapManager__GetWork();

    Task *task = TaskCreate(SeaMapStylusIcon_Main, SeaMapStylusIcon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x111, TASK_GROUP(1), SeaMapStylusIcon);

    work = TaskGetWork(task, SeaMapStylusIcon);
    TaskInitWork16(work);

    InitSeaMapEventManagerObject(&work->objWork, task, objectType, mapObject);

    work->state = SeaMapStylusIcon_State_BeginPressDelay;
    work->speed = FLOAT_TO_FX32(1.0f / 120.0f);

    // Init stylus sprite
    AnimatorSprite__Init(&work->aniStylus, manager->assets.sprChCommon, SEAMAP_CHCOM_ANI_125, ANIMATOR_FLAG_DISABLE_LOOPING | ANIMATOR_FLAG_DISABLE_SCREEN_BOUNDS_CHECK, manager->useEngineB,
                         PIXEL_MODE_SPRITE, VRAMSystem__AllocSpriteVram(manager->useEngineB, SeaMapStylusIcon_GetSpriteSize()), PALETTE_MODE_SPRITE,
                         VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_OBJ[manager->useEngineB]), SPRITE_PRIORITY_0, SPRITE_ORDER_1);

    work->aniStylus.cParam.palette = PALETTE_ROW_14;

    SeaMapEventManager_SetObjectAsActive(&work->objWork);

    return &work->objWork;
}

u32 SeaMapStylusIcon_GetSpriteSize(void)
{
    u16 animIDs[] = { SEAMAP_CHCOM_ANI_125, SEAMAP_CHCOM_ANI_126, SEAMAP_CHCOM_ANI_127 };

    void *sprFile = SeaMapManager__GetWork()->assets.sprChCommon;
    
    u32 requiredSize = 0;
    for (u32 i = 0; i < 3; i++)
    {
        u32 animSize = Sprite__GetSpriteSize1FromAnim(sprFile, animIDs[i]);
        if (requiredSize < animSize)
            requiredSize = animSize;
    }

    return requiredSize;
}

void SeaMapStylusIcon_Main(void)
{
    SeaMapStylusIcon *work = TaskGetWorkCurrent(SeaMapStylusIcon);

    work->state(work);

    SeaMapEventManager_GetMapLocalPosition(&work->objWork.position, &work->aniStylus.pos);
    SeaMapEventManager_ProcessAnimator(&work->aniStylus, 0, 0);
    AnimatorSprite__DrawFrame(&work->aniStylus);
}

void SeaMapStylusIcon_Destructor(Task *task)
{
    SeaMapStylusIcon *work = TaskGetWork(task, SeaMapStylusIcon);

    AnimatorSprite__Release(&work->aniStylus);

    SeaMapEventManager_SetObjectAsInactive(&work->objWork);
    DestroySeaMapEventManagerObject(&work->objWork);
}

void SeaMapStylusIcon_State_BeginPressDelay(SeaMapStylusIcon *work)
{
    work->objWork.position.x = FX32_TO_WHOLE(work->startPos.x);
    work->objWork.position.y = FX32_TO_WHOLE(work->startPos.y);

    AnimatorSprite__SetAnimation(&work->aniStylus, 125);
    work->aniStylus.flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;
    AnimatorSprite__ProcessAnimationFast(&work->aniStylus);
    work->aniStylus.flags |= ANIMATOR_FLAG_DID_LOOP;

    work->timer = 0;
    work->state = SeaMapStylusIcon_State_PressDelay;
}

void SeaMapStylusIcon_State_PressDelay(SeaMapStylusIcon *work)
{
    if (work->timer++ > 60)
        work->state = SeaMapStylusIcon_State_BeginStylusPress;
}

void SeaMapStylusIcon_State_BeginStylusPress(SeaMapStylusIcon *work)
{
    work->aniStylus.flags &= ~ANIMATOR_FLAG_DID_LOOP;

    work->timer = 0;
    work->state = SeaMapStylusIcon_State_StylusPress;
}

void SeaMapStylusIcon_State_StylusPress(SeaMapStylusIcon *work)
{
    if ((work->aniStylus.flags & ANIMATOR_FLAG_DID_FINISH) != 0 && work->aniStylus.animID == 125)
    {
        AnimatorSprite__SetAnimation(&work->aniStylus, 126);
        work->aniStylus.flags |= ANIMATOR_FLAG_DISABLE_LOOPING;
    }

    if (work->timer++ > 60 && work->aniStylus.animID != 125)
        work->state = SeaMapStylusIcon_State_BeginStylusMove;
}

void SeaMapStylusIcon_State_BeginStylusMove(SeaMapStylusIcon *work)
{
    work->percent = FLOAT_TO_FX32(0.0);
    work->state   = SeaMapStylusIcon_State_StylusMove;
}

void SeaMapStylusIcon_State_StylusMove(SeaMapStylusIcon *work)
{
    BOOL done = FALSE;

    work->percent += work->speed;
    if (work->percent > FLOAT_TO_FX32(1.0))
    {
        work->percent = FLOAT_TO_FX32(1.0);
        done          = TRUE;
    }

    work->objWork.position.x = FX32_TO_WHOLE(work->startPos.x + MultiplyFX(work->endPos.x - work->startPos.x, work->percent));
    work->objWork.position.y = FX32_TO_WHOLE(work->startPos.y + MultiplyFX(work->endPos.y - work->startPos.y, work->percent));

    if (done)
        work->state = SeaMapStylusIcon_State_BeginReleaseDelay;
}

void SeaMapStylusIcon_State_BeginReleaseDelay(SeaMapStylusIcon *work)
{
    work->timer = 0;
    work->state = SeaMapStylusIcon_State_ReleaseDelay;
}

void SeaMapStylusIcon_State_ReleaseDelay(SeaMapStylusIcon *work)
{
    if (work->timer++ > 60)
        work->state = SeaMapStylusIcon_State_BeginStylusRelease;
}

void SeaMapStylusIcon_State_BeginStylusRelease(SeaMapStylusIcon *work)
{
    AnimatorSprite__SetAnimation(&work->aniStylus, 127);
    work->aniStylus.flags &= ~ANIMATOR_FLAG_DISABLE_LOOPING;

    work->timer = 0;
    work->state = SeaMapStylusIcon_State_StylusRelease;
}

void SeaMapStylusIcon_State_StylusRelease(SeaMapStylusIcon *work)
{
    if (work->timer++ > 60 && (work->aniStylus.flags & ANIMATOR_FLAG_DID_FINISH) != 0)
        work->state = SeaMapStylusIcon_State_BeginPressDelay;
}
