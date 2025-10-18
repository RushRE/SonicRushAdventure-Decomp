#include <stage/objects/springRope.h>
#include <stage/objects/spring.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// ENUMS
// --------------------

enum SpringRopeObjectFlags
{
    SPRINGROPE_OBJFLAG_NONE,

    SPRINGROPE_OBJFLAG_FLIPPED = 1 << 0,
};

enum SpringRopeFlags
{
    SPRINGROPE_FLAG_NONE,

    SPRINGROPE_FLAG_USE_LOW_PRIORITY = 1 << 0,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void SpringRope_State_Active(SpringRope *work);
static void SpringRope_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void CreateSpringRopeChildren(SpringRope *work);

static void SpringRopeSpring_State_Idle(SpringRopeSpring *work);
static void SpringRopeSpring_Action_Use(SpringRopeSpring *work);
static void SpringRopeSpring_State_Used(SpringRopeSpring *work);

static void SpringRopeBase_State_Active(SpringRopeBase *work);

// --------------------
// FUNCTIONS
// --------------------

SpringRope *CreateSpringRope(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), SpringRope);
    if (task == HeapNull)
        return NULL;

    SpringRope *work = TaskGetWork(task, SpringRope);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    // Init 2D graphics, these are fallback graphics in the event this gets rendered on the screen without 3D support
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_rope_c.bac", GetObjectDataWork(OBJDATAWORK_159), gameArchiveStage, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 105);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    // Init 3D graphics, these are the main graphics the devs want you to see
    OBS_ACTION3D_NN_WORK *aniRope3D = &work->aniRope3D;
    ObjAction3dNNModelLoad(&work->gameWork.objWork, aniRope3D, "/mod/gmk_rope_c.nsbmd", 1, GetObjectDataWork(OBJDATAWORK_160), gameArchiveStage);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR | DISPLAY_FLAG_DISABLE_ROTATION;
    aniRope3D->ani.work.scale.x = FLOAT_TO_FX32(3.3);
    aniRope3D->ani.work.scale.y = FLOAT_TO_FX32(3.3);
    aniRope3D->ani.work.scale.z = FLOAT_TO_FX32(3.3);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    if ((mapObject->flags & SPRINGROPE_OBJFLAG_FLIPPED) != 0)
        ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, 132, 64, 140, 72);
    else
        ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -136, 64, -128, 72);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE | OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], SpringRope_OnDefend);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    CreateSpringRopeChildren(work);

    SetTaskState(&work->gameWork.objWork, SpringRope_State_Active);

    return work;
}

void SpringRope_State_Active(SpringRope *work)
{
    Player *player = (Player *)work->gameWork.parent;
    if (player != NULL)
    {
        if (!CheckPlayerGimmickObj(player, work))
        {
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            work->gameWork.parent = NULL;
            AnimatorMDL__SetResource(&work->gameWork.objWork.obj_3d->ani, work->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_MODEL], 1, FALSE, FALSE);
        }
        else
        {
            OBS_ACTION3D_NN_WORK *aniRope3D = work->gameWork.objWork.obj_3d;

            MtxFx33 mtxTemp;
            MTX_Identity33(&aniRope3D->ani.work.rotation);
            MTX_RotX33(&mtxTemp, SinFX((s32)(u16)player->objWork.userWork), CosFX((s32)(u16)player->objWork.userWork));
            MTX_Concat33(&aniRope3D->ani.work.rotation, &mtxTemp, &aniRope3D->ani.work.rotation);

            s32 angle = (s32)(u16) - (s32)(u16)(player->objWork.dir.y - FLOAT_DEG_TO_IDX(90.0));
            MTX_RotY33(&mtxTemp, SinFX(angle), CosFX(angle));
            MTX_Concat33(&aniRope3D->ani.work.rotation, &mtxTemp, &aniRope3D->ani.work.rotation);

            VEC_Set(&aniRope3D->ani.work.scale, FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3), FX32_TO_WHOLE(FLOAT_TO_FX32(3.3) * FX_DivS32(player->objWork.userTimer, 160)));

            if (player->objWork.dir.y < FLOAT_DEG_TO_IDX(180.0))
                work->gameWork.flags |= SPRINGROPE_FLAG_USE_LOW_PRIORITY;
            else
                work->gameWork.flags &= ~SPRINGROPE_FLAG_USE_LOW_PRIORITY;
        }
    }
    else
    {
        OBS_ACTION3D_NN_WORK *aniRope3D = work->gameWork.objWork.obj_3d;
        work->gameWork.flags &= ~SPRINGROPE_FLAG_USE_LOW_PRIORITY;

        MtxFx33 mtxTemp;
        MTX_Identity33(&aniRope3D->ani.work.rotation);
        MTX_RotX33(&mtxTemp, SinFX(FLOAT_DEG_TO_IDX(337.5)), CosFX(FLOAT_DEG_TO_IDX(337.5)));
        MTX_Concat33(&aniRope3D->ani.work.rotation, &mtxTemp, &aniRope3D->ani.work.rotation);
        MTX_RotY33(&mtxTemp, SinFX(FLOAT_DEG_TO_IDX(90.0)), CosFX(FLOAT_DEG_TO_IDX(90.0)));
        MTX_Concat33(&aniRope3D->ani.work.rotation, &mtxTemp, &aniRope3D->ani.work.rotation);

        aniRope3D->ani.work.scale.x = FLOAT_TO_FX32(3.3);
        aniRope3D->ani.work.scale.y = FLOAT_TO_FX32(3.3);
        aniRope3D->ani.work.scale.z = FLOAT_TO_FX32(3.3);
    }
}

void SpringRope_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SpringRope *springRope = (SpringRope *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (springRope == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (springRope->gameWork.parent == NULL)
    {
        springRope->gameWork.parent = &player->objWork;
        springRope->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        AnimatorMDL__SetResource(&springRope->gameWork.objWork.obj_3d->ani, springRope->gameWork.objWork.obj_3d->resources[B3D_RESOURCE_MODEL], 0, FALSE, FALSE);
        springRope->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        Player__Action_SpringRope(player, &springRope->gameWork, FLOAT_TO_FX32(160.0));
    }
}

void CreateSpringRopeChildren(SpringRope *work)
{
    Spring *spring = SpawnStageObjectEx(MAPOBJECT_335, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, Spring, 0, work->gameWork.mapObject->left, 0, 0, 0, 0);
    if (spring != NULL)
        spring->gameWork.objWork.parentObj = &work->gameWork.objWork;

    SpringRopeSpring *springRopeSpring =
        SpawnStageObject(MAPOBJECT_336, work->gameWork.objWork.position.x - FLOAT_TO_FX32(144.0), work->gameWork.objWork.position.y + FLOAT_TO_FX32(64.0), SpringRopeSpring);
    if (springRopeSpring != NULL)
        springRopeSpring->gameWork.objWork.parentObj = &work->gameWork.objWork;

    SpringRopeBase *springRopeBase = SpawnStageObject(MAPOBJECT_337, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y + FLOAT_TO_FX32(24.0), SpringRopeBase);
    if (springRopeBase != NULL)
        springRopeBase->gameWork.objWork.parentObj = &work->gameWork.objWork;
}

SpringRopeSpring *CreateSpringRopeSpring(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), SpringRopeSpring);
    if (task == HeapNull)
        return NULL;

    SpringRopeSpring *work = TaskGetWork(task, SpringRopeSpring);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_rope_c_spring.bac", GetObjectDataWork(OBJDATAWORK_161), gameArchiveStage, 8);
    work->gameWork.objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 2);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    SetTaskState(&work->gameWork.objWork, SpringRopeSpring_State_Idle);

    return work;
}

void SpringRopeSpring_State_Idle(SpringRopeSpring *work)
{
    SpringRope *parent = (SpringRope *)work->gameWork.objWork.parentObj;
    if (parent != NULL)
    {
        if ((parent->gameWork.objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) != 0)
            SpringRopeSpring_Action_Use(work);
    }
}

void SpringRopeSpring_Action_Use(SpringRopeSpring *work)
{
    SetTaskState(&work->gameWork.objWork, SpringRopeSpring_State_Used);

    work->gameWork.objWork.shakeTimer = FLOAT_TO_FX32(8.0);
    work->gameWork.objWork.scale.x = work->gameWork.objWork.scale.y = FLOAT_TO_FX32(1.25);
}

void SpringRopeSpring_State_Used(SpringRopeSpring *work)
{
    if (work->gameWork.objWork.scale.x > FLOAT_TO_FX32(1.0))
    {
        work->gameWork.objWork.scale.x -= FLOAT_TO_FX32(0.125);
        work->gameWork.objWork.scale.y = work->gameWork.objWork.scale.x;
    }

    SpringRope *parent = (SpringRope *)work->gameWork.objWork.parentObj;
    if (parent != NULL)
    {
        if ((parent->gameWork.objWork.flag & STAGE_TASK_FLAG_NO_OBJ_COLLISION) == 0)
        {
            work->gameWork.objWork.scale.x = work->gameWork.objWork.scale.y = FLOAT_TO_FX32(1.0);

            SetTaskState(&work->gameWork.objWork, SpringRopeSpring_State_Idle);
        }
    }
}

SpringRopeBase *CreateSpringRopeBase(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), SpringRopeBase);
    if (task == HeapNull)
        return NULL;

    SpringRopeBase *work = TaskGetWork(task, SpringRopeBase);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_rope_c_land.bac", GetObjectDataWork(OBJDATAWORK_162), gameArchiveStage, 16);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 106);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    SetTaskState(&work->gameWork.objWork, SpringRopeBase_State_Active);

    return work;
}

void SpringRopeBase_State_Active(SpringRopeBase *work)
{
    SpringRope *parent = (SpringRope *)work->gameWork.objWork.parentObj;
    if (parent != NULL)
    {
        if ((parent->gameWork.flags & SPRINGROPE_FLAG_USE_LOW_PRIORITY) != 0)
            StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
        else
            StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    }
}