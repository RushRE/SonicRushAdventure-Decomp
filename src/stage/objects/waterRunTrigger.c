#include <stage/objects/waterRunTrigger.h>

// --------------------
// ENUMS
// --------------------

enum WaterRunTriggerObjectFlags
{
    WATERRUNTRIGGER_OBJFLAG_FROM_RIGHT = 1 << 0,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void WaterRunTrigger_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

WaterRunTrigger *CreateWaterRunTrigger(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), WaterRunTrigger);

    if (task == HeapNull)
        return NULL;

    WaterRunTrigger *work = TaskGetWork(task, WaterRunTrigger);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

    if ((mapObject->flags & WATERRUNTRIGGER_OBJFLAG_FROM_RIGHT) != 0)
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -16, -8, 4, 0);
    else
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -4, -8, 16, 0);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], WaterRunTrigger_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR | OBS_RECT_WORK_FLAG_ENABLED;

    return work;
}

void WaterRunTrigger_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    WaterRunTrigger *trigger = (WaterRunTrigger *)rect2->parent;
    Player *player           = (Player *)rect1->parent;

    if (trigger == NULL || player == NULL)
        return;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        if ((player->objWork.groundVel >= player->spdThresholdRun && (trigger->gameWork.mapObject->flags & WATERRUNTRIGGER_OBJFLAG_FROM_RIGHT) == 0)
            || (player->objWork.groundVel <= -player->spdThresholdRun && (trigger->gameWork.mapObject->flags & WATERRUNTRIGGER_OBJFLAG_FROM_RIGHT) != 0))
        {
            Player__Gimmick_WaterRun(player);
        }
    }
}