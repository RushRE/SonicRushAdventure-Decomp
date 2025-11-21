#include <stage/objects/cannon.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/sailboatBazookaSmoke.h>
#include <stage/effects/cannonFireSpeedLines.h>

// --------------------
// ENUMS
// --------------------

enum CannonModelIDs_
{
	CANNON_MDL_GUN,
	CANNON_MDL_HOUSING,
	CANNON_MDL_FLOOR,
};

// --------------------
// FUNCTION DECLS
// --------------------

extern void Cannon_Destructor(Task *task);
extern void Cannon_Draw(void);
extern void Cannon_OnDefend_Entrry(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

extern void CannonFloor_State_Solid(CannonFloor *work);
extern void CannonFloor_Collide(void);

// --------------------
// FUNCTIONS
// --------------------

Cannon *CreateCannon(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task;
    Cannon *work;
    s32 i;
    AnimatorMDL *animator;

    task = CreateStageTask(Cannon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), Cannon);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, Cannon);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    void *mdlCannon = ObjDataLoad(GetObjectFileWork(OBJDATAWORK_165), "/mod/gmk_cannon.nsbmd", gameArchiveStage);

    animator = &work->aniCannon[0];

    i = CANNON_MDL_GUN;
    while (i < CANNON_MDL_FLOOR)
    {
        AnimatorMDL__Init(animator, ANIMATORMDL_FLAG_NONE);
        AnimatorMDL__SetResource(animator, mdlCannon, (u16)i, FALSE, FALSE);

        VEC_Set(&animator->work.scale, FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3));

        i++;
        animator++;
    }

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR | DISPLAY_FLAG_DISABLE_ROTATION;
    work->gameWork.objWork.dir.y       = FLOAT_DEG_TO_IDX(45.0);
    work->gameWork.colliders[0].parent = &work->gameWork.objWork;

    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -32, -96, 32, -56);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Cannon_OnDefend_Entrry);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    work->gameWork.objWork.collisionObj = NULL;

    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.width     = 40;
    work->gameWork.collisionObject.work.height    = 80;
    work->gameWork.collisionObject.work.ofst_x    = -16;
    work->gameWork.collisionObject.work.ofst_y    = -74;

    SetTaskOutFunc(&work->gameWork.objWork, Cannon_Draw);

    return work;
}

CannonFloor *CreateCannonFloor(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), CannonFloor);
    if (task == HeapNull)
        return NULL;

    CannonFloor *work = TaskGetWork(task, CannonFloor);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    OBS_ACTION3D_NN_WORK *aniCannon = &work->aniCannon;
    ObjAction3dNNModelLoad(&work->gameWork.objWork, aniCannon, "/mod/gmk_cannon.nsbmd", CANNON_MDL_FLOOR, GetObjectFileWork(OBJDATAWORK_165), gameArchiveStage);
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
    aniCannon->ani.work.scale.x = FLOAT_TO_FX32(2.3523);
    aniCannon->ani.work.scale.y = FLOAT_TO_FX32(2.3523);
    aniCannon->ani.work.scale.z = FLOAT_TO_FX32(2.3523);

    work->gameWork.objWork.collisionObj = NULL;

    StageTaskCollisionObj *collisionWorkFloor = &work->gameWork.collisionObject.work;
    collisionWorkFloor->parent                = &work->gameWork.objWork;
    collisionWorkFloor->diff_data             = StageTask__DefaultDiffData;
    collisionWorkFloor->width                 = 384;
    collisionWorkFloor->height                = 8;
    collisionWorkFloor->ofst_x                = -192;
    collisionWorkFloor->ofst_y                = 0;

    StageTaskCollisionObj *collisionWorkWallL = &work->collisionWorkWallL;
    collisionWorkWallL->parent                = &work->gameWork.objWork;
    collisionWorkWallL->diff_data             = StageTask__DefaultDiffData;
    collisionWorkWallL->width                 = 16;
    collisionWorkWallL->height                = 120;
    collisionWorkWallL->ofst_x                = -192;
    collisionWorkWallL->ofst_y                = 8;

    StageTaskCollisionObj *collisionWorkWallR = &work->collisionWorkWallR;
    collisionWorkWallR->parent                = &work->gameWork.objWork;
    collisionWorkWallR->diff_data             = StageTask__DefaultDiffData;
    collisionWorkWallR->width                 = 16;
    collisionWorkWallR->height                = 120;
    collisionWorkWallR->ofst_x                = 176;
    collisionWorkWallR->ofst_y                = 8;

    SetTaskState(&work->gameWork.objWork, CannonFloor_State_Solid);
    SetTaskCollideFunc(&work->gameWork.objWork, CannonFloor_Collide);

    // BUG?: This returns NULL? Why doesn't it return 'work'
    return NULL;
}