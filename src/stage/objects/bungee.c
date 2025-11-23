#include <stage/objects/bungee.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <game/math/akMath.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_left   mapObject->left
#define mapObjectParam_top    mapObject->top
#define mapObjectParam_width  mapObject->width
#define mapObjectParam_height mapObject->height

// --------------------
// FUNCTION DECLS
// --------------------

static void Bungee_State_Active(Bungee *work);
static void Bungee_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Bungee_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

Bungee *CreateBungee(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), Bungee);
    if (task == HeapNull)
        return NULL;

    Bungee *work = TaskGetWork(task, Bungee);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_bungee.bac", GetObjectDataWork(OBJDATAWORK_163), gameArchiveStage, 1);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 106);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);

    SetTaskOutFunc(&work->gameWork.objWork, Bungee_Draw);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, mapObjectParam_left, mapObjectParam_top, mapObjectParam_left + mapObjectParam_width,
                      mapObjectParam_top + mapObjectParam_height);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_DISABLE_DEF_RESPONSE | OBS_RECT_WORK_FLAG_DISABLE_ATK_RESPONSE;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Bungee_OnDefend);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    SetTaskState(&work->gameWork.objWork, Bungee_State_Active);

    return work;
}

void Bungee_State_Active(Bungee *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if (player != NULL)
    {
        if (CheckPlayerGimmickObj(player, work))
        {
            work->gameWork.objWork.userTimer = player->objWork.userTimer;
        }
        else
        {
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            work->gameWork.parent = NULL;
        }
    }
}

void Bungee_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Bungee *bungee = (Bungee *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    if (bungee == NULL || player == NULL)
        return;

    if (bungee->gameWork.parent != NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IS_FALLING) == 0)
    {
        if (MATH_ABS(player->objWork.groundVel) >= player->spdThresholdRun)
        {
            bungee->gameWork.parent = &player->objWork;
            bungee->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;

            Player__Action_Bungee(player, &bungee->gameWork, ObjRect__CenterX(&bungee->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK]), ObjRect__CenterY(&bungee->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK]));
        }
    }
}

void Bungee_Draw(void)
{
    Bungee *work = TaskGetWorkCurrent(Bungee);

    VecFx32 position;
    Vec2Fx32 nodePositions[8];
    AnimatorSpriteDS *aniNode;
    u8 i;
    u32 nodeCount;

    if (work->gameWork.parent != NULL)
    {
        fx32 x;
        fx32 y;
        AkMath__Func_2002C98(FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(14.0), &x, &y, work->gameWork.parent->dir.z);

        fx32 stepX = FX_DivS32(work->gameWork.parent->position.x - (work->gameWork.objWork.position.x + x), 8);
        fx32 stepY = FX_DivS32(work->gameWork.parent->position.y - (work->gameWork.objWork.position.y + y), 8);

        for (i = 0; i < 8; i++)
        {
            nodePositions[i].x = work->gameWork.objWork.position.x + stepX * i;
            nodePositions[i].y = work->gameWork.objWork.position.y + stepY * i;
        }

        if (work->gameWork.objWork.userTimer != 0)
        {
            for (u8 i = 1; i < 8; i++)
            {
                u32 offset = ((i + 2 * work->gameWork.objWork.userTimer) & 7) - 4;
                nodePositions[i].x += FX32_FROM_WHOLE(offset);
                nodePositions[i].y += FX32_FROM_WHOLE(offset);
            }
        }

        nodeCount = 8;
    }
    else
    {
        nodeCount          = 1;
        nodePositions[0].x = work->gameWork.objWork.position.x;
        nodePositions[0].y = work->gameWork.objWork.position.y;
    }

    aniNode    = &work->gameWork.objWork.obj_2d->ani;
    position.z = FLOAT_TO_FX32(0.0);
    for (i = 0; i < nodeCount; i++)
    {
        position.x = nodePositions[i].x;
        position.y = nodePositions[i].y;
        StageTask__Draw2DEx(aniNode, &position, NULL, &work->gameWork.objWork.scale, &work->gameWork.objWork.displayFlag, NULL, NULL);
    }
}