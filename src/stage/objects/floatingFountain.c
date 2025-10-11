#include <stage/objects/floatingFountain.h>
#include <game/stage/gameSystem.h>
#include <game/stage/stageAssets.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <stage/effects/iceSparklesSpawner.h>
#include <stage/objects/platform.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_startX mapObject->left
#define mapObjectParam_startY mapObject->top
#define mapObjectParam_sizeX  mapObject->width
#define mapObjectParam_sizeY  mapObject->height

// --------------------
// ENUMS
// --------------------

enum FloatingFountainObjectFlags
{
    FLOATINGFOUNTAIN_OBJFLAG_NONE,

    FLOATINGFOUNTAIN_OBJFLAG_FORCE_MASK = (1 << 6) | (1 << 7),
};

enum FloatingFountainAnimIDs
{
    FLOATINGFOUNTAIN_ANI_IDLE,
    FLOATINGFOUNTAIN_ANI_ACTIVATED,
    FLOATINGFOUNTAIN_ANI_SPLASH,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void FloatingFountain_Destructor(Task *task);
static void FloatingFountain_Action_Idle(FloatingFountain *work);
static void FloatingFountain_State_Idle(FloatingFountain *work);
static void FloatingFountain_Action_Activate(FloatingFountain *work);
static void FloatingFountain_State_Activated(FloatingFountain *work);
static void FloatingFountain_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void FloatingFountain_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

FloatingFountain *CreateFloatingFountain(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(FloatingFountain_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1801, TASK_GROUP(2), FloatingFountain);
    if (task == HeapNull)
        return NULL;

    FloatingFountain *work = TaskGetWork(task, FloatingFountain);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_float_fountain.bac", GetObjectDataWork(OBJDATAWORK_165), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 93);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    AnimatorSpriteDS *aniFountain = &work->aniFountain;
    ObjAction2dBACLoad(&work->aniFountain, "/act/ac_gmk_float_fountain.bac", 8, GetObjectDataWork(OBJDATAWORK_165), gameArchiveStage);
    aniFountain->work.cParam.palette      = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
    aniFountain->cParam[0].palette = aniFountain->cParam[1].palette = aniFountain->work.cParam.palette;
    aniFountain->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__SetAnimation(&work->aniFountain, 2);
    StageTask__SetOAMOrder(&aniFountain->work, SPRITE_ORDER_22);
    StageTask__SetOAMPriority(&aniFountain->work, SPRITE_PRIORITY_2);

    ObjRect__SetAttackStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], FloatingFountain_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    Platform *platform = SpawnStageObjectEx(MAPOBJECT_332, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, Platform,
                                            (mapObject->flags & ~FLOATINGFOUNTAIN_OBJFLAG_FORCE_MASK) | 0x80, mapObjectParam_startX, mapObjectParam_startY, mapObjectParam_sizeX,
                                            mapObjectParam_sizeY, 0);
    if (platform != NULL)
    {
        work->gameWork.objWork.parentObj = &platform->gameWork.objWork;
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    }

    SetTaskOutFunc(&work->gameWork.objWork, FloatingFountain_Draw);

    FloatingFountain_Action_Idle(work);

    return work;
}

void FloatingFountain_Destructor(Task *task)
{
    FloatingFountain *work = TaskGetWork(task, FloatingFountain);

    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_165), &work->aniFountain);

    GameObject__Destructor(task);
}

void FloatingFountain_Action_Idle(FloatingFountain *work)
{
    StageTask__SetAnimation(&work->gameWork.objWork, FLOATINGFOUNTAIN_ANI_IDLE);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, FloatingFountain_State_Idle);
}

void FloatingFountain_State_Idle(FloatingFountain *work)
{
    Player *player = (Player *)work->gameWork.objWork.parentObj;

    if (player != NULL)
    {
        work->gameWork.objWork.position = player->objWork.position;
    }
}

void FloatingFountain_Action_Activate(FloatingFountain *work)
{
    StageTask__SetAnimation(&work->gameWork.objWork, FLOATINGFOUNTAIN_ANI_ACTIVATED);
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_LOOPING;

    SetTaskState(&work->gameWork.objWork, FloatingFountain_State_Activated);
}

void FloatingFountain_State_Activated(FloatingFountain *work)
{
    Player *player = (Player *)work->gameWork.objWork.parentObj;

    if (player != NULL)
    {
        work->gameWork.objWork.position = player->objWork.position;
    }

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME;
        FloatingFountain_Action_Idle(work);
    }
}

void FloatingFountain_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FloatingFountain *fountain = (FloatingFountain *)rect2->parent;
    Player *player             = (Player *)rect1->parent;

    if (fountain == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    FloatingFountain_Action_Activate(fountain);
    Player__Action_Spring(player, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(1.5) * ((fountain->gameWork.mapObject->flags & FLOATINGFOUNTAIN_OBJFLAG_FORCE_MASK) >> 6) - FLOAT_TO_FX32(7.5));
    Player__Action_AllowTrickCombos(player, &fountain->gameWork);
    EffectIceSparklesSpawner__Create(&player->objWork);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FOUNTAIN);
}

void FloatingFountain_Draw(void)
{
    FloatingFountain *work = TaskGetWorkCurrent(FloatingFountain);

    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);

    u32 displayFlag = work->gameWork.objWork.displayFlag | DISPLAY_FLAG_DISABLE_LOOPING;
    StageTask__Draw2DEx(&work->aniFountain, &work->gameWork.objWork.position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);
}
