#include <stage/objects/corkscrewPath.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void CorkscrewPath_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

CorkscrewPath *CreateCorkscrewPath(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), CorkscrewPath);
    if (task == HeapNull)
        return NULL;

    CorkscrewPath *work = TaskGetWork(task, CorkscrewPath);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    if ((mapObject->flags & CORKSCREWPATH_OBJFLAG_RIGHT_TRIGGER) != 0)
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -16, -8, -4, 0); // vertical corkscrew path
    else
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, 4, -8, 16, 0); // horizontal corkscrew path
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_80 | OBS_RECT_WORK_FLAG_40;
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], CorkscrewPath_OnDefend);
    work->gameWork.colliders[0].parent = &work->gameWork.objWork;

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_20;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    return work;
}

void CorkscrewPath_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    CorkscrewPath *corkscrewPath = (CorkscrewPath *)rect2->parent;

    u16 type             = 0;
    MapObject *mapObject = corkscrewPath->gameWork.mapObject;
    u16 flags            = mapObject->flags & ~CORKSCREWPATH_OBJFLAG_80;

    if (mapObject->id == MAPOBJECT_105)
        flags |= (mapObject->left << 2);

    Player *player = (Player *)rect1->parent;

    if (player != NULL && player->objWork.objType == STAGE_OBJ_TYPE_PLAYER)
    {
        fx32 threshold = player->spdThresholdRun;
        fx32 speed     = player->objWork.groundVel;
        if ((mapObject->flags & CORKSCREWPATH_OBJFLAG_80) != 0)
            threshold = FLOAT_TO_FX32(0.0);

        if (speed >= threshold && (mapObject->flags & CORKSCREWPATH_OBJFLAG_RIGHT_TRIGGER) == 0
            || speed <= -threshold && (mapObject->flags & CORKSCREWPATH_OBJFLAG_RIGHT_TRIGGER) != 0)
        {
            if (mapObject->id == MAPOBJECT_105)
            {
                flags |= CORKSCREWPATH_TYPE_VERTICAL << CORKSCREWPATH_OBJFLAG_TYPE_SHIFT;
                if (mapObject->top == 1)
                    type = 1;
            }

            if ((mapObject->flags & CORKSCREWPATH_OBJFLAG_80) != 0)
                flags |= CORKSCREWPATH_TYPE_2 << CORKSCREWPATH_OBJFLAG_TYPE_SHIFT;

            if ((mapObject->flags & CORKSCREWPATH_OBJFLAG_80) != 0)
            {
                if (player->actionState >= PLAYER_ACTION_GRIND && player->actionState <= PLAYER_ACTION_GRINDTRICK_3_03
                    || player->actionState >= PLAYER_ACTION_GRIND_SNOWBOARD && player->actionState <= PLAYER_ACTION_GRINDTRICK_SNOWBOARD_3_03)
                {
                    Player__Action_CorkscrewPath(player, corkscrewPath->gameWork.objWork.position.x, corkscrewPath->gameWork.objWork.position.y, flags, 0);
                }
            }
            else
            {
                Player__Action_CorkscrewPath(player, corkscrewPath->gameWork.objWork.position.x, corkscrewPath->gameWork.objWork.position.y, flags, type);
            }
        }
    }
}