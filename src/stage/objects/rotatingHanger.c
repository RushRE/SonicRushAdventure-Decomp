#include <stage/objects/rotatingHanger.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/stage/gameSystem.h>

// --------------------
// ENUMS
// --------------------

enum RotatingHangerFlags
{
    ROTATINGHANGER_FLAG_NONE,

    ROTATINGHANGER_FLAG_IS_SWINGING = 1 << 0,
};

// --------------------
// FUNCTIONS
// --------------------

RotatingHanger *RotatingHanger__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), RotatingHanger);
    if (task == HeapNull)
        return NULL;

    RotatingHanger *work = TaskGetWork(task, RotatingHanger);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_rot_hanger.bac", GetObjectDataWork(OBJDATAWORK_160), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 85);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    ObjRect__SetAttackStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], RotatingHanger__OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    StageTask__SetAnimation(&work->gameWork.objWork, 0);

    SetTaskState(&work->gameWork.objWork, RotatingHanger__State_Active);

    return work;
}

void RotatingHanger__State_Active(RotatingHanger *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if (player != NULL)
    {
        if (CheckPlayerGimmickObj(player, work))
        {
            work->gameWork.objWork.dir.z = (u16)player->gimmick.value3 + FLOAT_DEG_TO_IDX(90.0);
        }
        else
        {
            work->gameWork.parent           = NULL;
            work->gameWork.objWork.userWork = 16;
            work->gameWork.flags |= ROTATINGHANGER_FLAG_IS_SWINGING;

            s32 angle = work->gameWork.objWork.dir.z;
            if ((s32)work->gameWork.objWork.dir.z >= FLOAT_DEG_TO_IDX(180.0))
                angle = -(u16)(FLOAT_DEG_TO_IDX(360.0) - (s32)angle);
            work->gameWork.objWork.userTimer = angle;
            work->gameWork.objWork.groundVel = FLOAT_TO_FX32(0.0);
        }
    }
    else
    {
        if (work->gameWork.objWork.userWork != 0)
        {
            work->gameWork.objWork.userWork--;
            if (work->gameWork.objWork.userWork == 0)
                work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        }

        if ((work->gameWork.flags & ROTATINGHANGER_FLAG_IS_SWINGING) != 0)
        {
            if (MATH_ABS(work->gameWork.objWork.userTimer) < 0x100 && MATH_ABS(work->gameWork.objWork.groundVel) < 0x80)
            {
                work->gameWork.objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
                work->gameWork.flags &= ~ROTATINGHANGER_FLAG_IS_SWINGING;
            }
            else
            {
                if (work->gameWork.objWork.userTimer >= 0)
                {
                    if (work->gameWork.objWork.groundVel >= 0)
                        work->gameWork.objWork.groundVel = ObjSpdDownSet(work->gameWork.objWork.groundVel, 0x40);

                    work->gameWork.objWork.groundVel = ObjSpdUpSet(work->gameWork.objWork.groundVel, -0x40, 0x800);
                }
                else
                {
                    if (work->gameWork.objWork.groundVel < 0)
                        work->gameWork.objWork.groundVel = ObjSpdDownSet(work->gameWork.objWork.groundVel, 0x40);

                    work->gameWork.objWork.groundVel = ObjSpdUpSet(work->gameWork.objWork.groundVel, 0x40, 0x800);
                }

                work->gameWork.objWork.userTimer += work->gameWork.objWork.groundVel;
                work->gameWork.objWork.dir.z = work->gameWork.objWork.userTimer;
            }
        }
    }
}

void RotatingHanger__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    RotatingHanger *hanger = (RotatingHanger *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (hanger == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    hanger->gameWork.flags &= ~ROTATINGHANGER_FLAG_IS_SWINGING;
    hanger->gameWork.parent = &player->objWork;
    hanger->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

    Player__Action_RotatingHanger(player, &hanger->gameWork, -FLOAT_TO_FX32(24.0),
                                  player->objWork.position.y < hanger->gameWork.objWork.position.y ? GRAPHICS_ENGINE_A : GRAPHICS_ENGINE_B);
}
