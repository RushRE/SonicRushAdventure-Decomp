#include <stage/objects/spikes.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

// used in Spikes
#define mapObjectParam_interval mapObject->left

// used in Spikes2
#define mapObjectParam_size mapObject->left

// --------------------
// FUNCTION DECLS
// --------------------

void SetSpikesAnimation(Spikes *work, u16 anim);

void Spikes_Action_Idle(Spikes *work);
static void Spikes_State_Idle(Spikes *work);
static void Spikes_Action_Extend(Spikes *work);
static void Spikes_State_Extend(Spikes *work);
static void Spikes_Action_Retract(Spikes *work);
static void Spikes_State_Retract(Spikes *work);

static void Spikes2_State_Idle(Spikes *work);

// --------------------
// VARIABLES
// --------------------

static u32 vramOffset[] = { 0x0000, 0x0A00, 0x0F00, 0x1200, 0x0000 };

// --------------------
// FUNCTIONS
// --------------------

Spikes *CreateSpikes2(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), Spikes);
    if (task == HeapNull)
        return NULL;

    Spikes *work = TaskGetWork(task, Spikes);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    s8 size = MTM_MATH_CLIP_S8(mapObjectParam_size, 1, 5);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetAttackStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_NORMAL, OBS_RECT_HITPOWER_DEFAULT);
    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_NONE), OBS_RECT_DEFPOWER_INVINCIBLE);
    work->gameWork.objWork.collisionObj           = 0;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.flag |= STAGE_TASK_OBJCOLLISION_FLAG_FLIP_TILE_ANGLE;

    switch (mapObject->id)
    {
        case MAPOBJECT_274:
        case MAPOBJECT_275:
            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -26, -12, -21, 32 * (size - 1) + 12);
            work->gameWork.collisionObject.work.width  = 24;
            work->gameWork.collisionObject.work.height = 32 * size;
            work->gameWork.collisionObject.work.ofst_x = -16;
            work->gameWork.collisionObject.work.ofst_y = -16;
            break;

        default:
            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -16, -24, 32 * (size - 1) + 16, -21);
            work->gameWork.collisionObject.work.width  = 32 * size;
            work->gameWork.collisionObject.work.height = 24;
            work->gameWork.collisionObject.work.ofst_x = -16;
            work->gameWork.collisionObject.work.ofst_y = -20;

            if (Player__UseUpsideDownGravity(x, y))
                work->gameWork.collisionObject.work.flag |= STAGE_TASK_OBJCOLLISION_FLAG_FLIP_TILE_ANGLE;

            SetTaskState(&work->gameWork.objWork, Spikes2_State_Idle);
            break;
    }

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    switch (mapObject->id)
    {
        case MAPOBJECT_273:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
            break;

        case MAPOBJECT_275:
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            break;
    }

    return work;
}

void SetSpikesAnimation(Spikes *work, u16 anim)
{
    StageTask__SetAnimation(&work->gameWork.objWork, anim);

    work->gameWork.objWork.obj_2d->ani.vramPixels[0] = work->gameWork.objWork.obj_2d->spriteRef->engineRef[0].vramPixels + vramOffset[anim];
    work->gameWork.objWork.obj_2d->ani.vramPixels[1] = work->gameWork.objWork.obj_2d->spriteRef->engineRef[1].vramPixels + vramOffset[anim];
}

void Spikes_Action_Idle(Spikes *work)
{
    SetSpikesAnimation(work, work->gameWork.actionState);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    SetTaskState(&work->gameWork.objWork, Spikes_State_Idle);
    work->gameWork.objWork.userTimer = 0;
}

void Spikes_State_Idle(Spikes *work)
{
    if (work->gameWork.mapObject->id >= MAPOBJECT_93)
    {
        work->gameWork.objWork.userTimer++;
        if (work->gameWork.objWork.userTimer > 120)
        {
            if (work->gameWork.actionState == SPIKES_ANI_VERTICAL_HIDDEN)
            {
                work->gameWork.actionState = SPIKES_ANI_VERTICAL_EXTEND;
                Spikes_Action_Extend(work);
            }
            else
            {
                work->gameWork.actionState = SPIKES_ANI_VERTICAL_RETRACT;
                Spikes_Action_Retract(work);
            }
            return;
        }
    }

    if (work->gameWork.mapObject->id == MAPOBJECT_77 || work->gameWork.mapObject->id == MAPOBJECT_93)
    {
        Player *player = (Player *)work->gameWork.collisionObject.work.riderObj;
        if (player == NULL)
            return;

        Spikes *spikes = (Spikes *)player->objWork.rideObj;

        if (spikes != work || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
            return;

        if (ObjRect__FlagCheck(work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].hitFlag, player->colliders[GAMEOBJECT_COLLIDER_WEAK].defFlag, work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].hitPower, player->colliders[GAMEOBJECT_COLLIDER_WEAK].defPower))
        {
            Player__OnDefend_Regular(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], &player->colliders[GAMEOBJECT_COLLIDER_WEAK]);
        }
    }
}

void Spikes_Action_Extend(Spikes *work)
{
    SetSpikesAnimation(work, work->gameWork.actionState);
    SetTaskState(&work->gameWork.objWork, Spikes_State_Extend);

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->gameWork.objWork.userTimer = 24;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
}

void Spikes_State_Extend(Spikes *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer == 0)
        Spikes_Action_Retract(work);
}

void Spikes_Action_Retract(Spikes *work)
{
    SetSpikesAnimation(work, work->gameWork.actionState);
    SetTaskState(&work->gameWork.objWork, Spikes_State_Retract);

    work->gameWork.objWork.userTimer = 0;
    work->gameWork.objWork.userWork  = 0;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;

    if (work->gameWork.actionState == SPIKES_ANI_VERTICAL_EXTEND)
        work->gameWork.objWork.userWork = -3;
    else
        work->gameWork.objWork.userWork = 3;
}

void Spikes_State_Retract(Spikes *work)
{
    work->gameWork.objWork.userTimer++;

    work->gameWork.collisionObject.work.ofst_y += work->gameWork.objWork.userWork;
    if (work->gameWork.objWork.userTimer >= 8)
    {
        if (work->gameWork.actionState == SPIKES_ANI_VERTICAL_RETRACT)
        {
            work->gameWork.actionState = SPIKES_ANI_VERTICAL_HIDDEN;
        }
        else if (work->gameWork.actionState == SPIKES_ANI_VERTICAL_EXTEND)
        {
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            work->gameWork.actionState = SPIKES_ANI_VERTICAL_VISIBLE;
        }

        Spikes_Action_Idle(work);
    }
}

void Spikes2_State_Idle(Spikes *work)
{
    Player *player = (Player *)work->gameWork.collisionObject.work.riderObj;

    if (player == NULL)
        return;

    Spikes *spikes = (Spikes *)player->objWork.rideObj;

    if (spikes != work || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (ObjRect__FlagCheck(work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].hitFlag, player->colliders[GAMEOBJECT_COLLIDER_WEAK].defFlag, work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].hitPower, player->colliders[GAMEOBJECT_COLLIDER_WEAK].defPower))
    {
        Player__OnDefend_Regular(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], &player->colliders[GAMEOBJECT_COLLIDER_WEAK]);
    }
}
