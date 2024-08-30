#include <stage/objects/halfpipe.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// ENUMS
// --------------------

enum HalfPipeObjectFlags
{
    HALFPIPE_OBJFLAG_NONE,

    HALFPIPE_OBJFLAG_UNKNOWN_FLAG = 1 << 0,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void Halfpipe_OnDefend_Entry(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Halfpipe_OnDefend_Exit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

Halfpipe *CreateHalfpipe(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task;
    Halfpipe *work;

    u32 halfpipeType = mapObject->id - MAPOBJECT_145;

    task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_SCOPE_2, Halfpipe);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, Halfpipe);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    OBS_DATA_WORK *sprWork = GetObjectDataWork(OBJDATAWORK_186);
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_half_pipe.bac", sprWork, gameArchiveStage, OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, Sprite__GetSpriteSize2FromAnim(sprWork->fileData, halfpipeType), GetObjectSpriteRef(2 * halfpipeType + OBJDATAWORK_187));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 60);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);
    StageTask__SetAnimation(&work->gameWork.objWork, halfpipeType);
    work->gameWork.objWork.obj_2d->ani.work.spriteType = GX_OAM_MODE_XLU;

    ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
    ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], Halfpipe_OnDefend_Entry);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    ObjRect__SetAttackStat(&work->gameWork.colliders[1], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~1, 0);
    ObjRect__SetOnDefend(&work->gameWork.colliders[1], Halfpipe_OnDefend_Exit);

    if (mapObject->id != MAPOBJECT_147)
    {
        work->gameWork.colliders[0].parent = &work->gameWork.objWork;
        ObjRect__SetBox3D(&work->gameWork.colliders[0].rect, 0, -128, -256, 64, 0, 256);
        if (mapObject->id == MAPOBJECT_145)
        {
            work->gameWork.colliders[1].parent = &work->gameWork.objWork;
            ObjRect__SetBox3D(&work->gameWork.colliders[1].rect, -64, -512, -256, 0, 0, 256);
        }
    }
    else
    {
        work->gameWork.colliders[1].parent = &work->gameWork.objWork;
        ObjRect__SetBox3D(&work->gameWork.colliders[1].rect, 0, -512, -256, 64, 0, 256);
    }

    return work;
}

void Halfpipe_OnDefend_Entry(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Halfpipe *halfpipe = (Halfpipe *)rect2->parent;
    Player *player     = (Player *)rect1->parent;

    BOOL flag = FALSE;

    if (halfpipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0 || player->objWork.rideObj != NULL)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        MapObject *mapObject = halfpipe->gameWork.mapObject;

        if (mapObject->id == MAPOBJECT_145)
        {
            if ((mapObject->flags & HALFPIPE_OBJFLAG_UNKNOWN_FLAG) != 0)
                flag = TRUE;
        }
        else if (mapObject->id == MAPOBJECT_147)
        {
            if ((mapObject->flags & HALFPIPE_OBJFLAG_UNKNOWN_FLAG) == 0)
                flag = TRUE;
        }

        Player__Action_EnterHalfpipe(player, &halfpipe->gameWork, flag);
        Player__Action_AllowTrickCombos(player, &halfpipe->gameWork);
    }
}

void Halfpipe_OnDefend_Exit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Halfpipe *halfpipe = (Halfpipe *)rect2->parent;
    Player *player     = (Player *)rect1->parent;

    if (halfpipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((halfpipe->gameWork.mapObject->id == MAPOBJECT_145 && player->objWork.groundVel > 0)
        || (halfpipe->gameWork.mapObject->id == MAPOBJECT_147 && player->objWork.groundVel < 0))
        ObjRect__FuncNoHit(rect1, rect2);
    else
        Player__Action_ExitHalfpipe(player);
}
