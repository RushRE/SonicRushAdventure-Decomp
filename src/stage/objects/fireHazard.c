#include <stage/objects/fireHazard.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// ENUMS
// --------------------

enum FireHazardAnimID
{
    FIREFLOOR_ANI_ACTIVE_V,
    FIREFLOOR_ANI_FLAREUP_V,
    FIREFLOOR_ANI_EMBER,
    FIREFLOOR_ANI_ACTIVE_H,
    FIREFLOOR_ANI_FLAREUP_H,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void FireHazard_State_Active(FireHazard *work);
static void FireHazard_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void FireHazard_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

FireHazard *CreateFireHazard(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), FireHazard);
    if (task == HeapNull)
        return NULL;

    FireHazard *work = TaskGetWork(task, FireHazard);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_firefloor.bac", GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, FIREFLOOR_ANI_ACTIVE_V, 83);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_1);

    if (mapObject->id == MAPOBJECT_224 || mapObject->id == MAPOBJECT_225)
    {
        StageTask__SetAnimation(&work->gameWork.objWork, FIREFLOOR_ANI_ACTIVE_V);
        if (mapObject->id == MAPOBJECT_225)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
    }
    else
    {
        StageTask__SetAnimation(&work->gameWork.objWork, FIREFLOOR_ANI_ACTIVE_H);
        if (mapObject->id == MAPOBJECT_226)
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    }

    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    ObjRect__SetOnAttack(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], FireHazard_OnHit);
    SetTaskState(&work->gameWork.objWork, FireHazard_State_Active);

    return work;
}

void FireHazard_State_Active(FireHazard *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID == FIREFLOOR_ANI_FLAREUP_V)
        {
            StageTask__SetAnimation(&work->gameWork.objWork, FIREFLOOR_ANI_ACTIVE_V);
        }
        else if (work->gameWork.objWork.obj_2d->ani.work.animID == FIREFLOOR_ANI_FLAREUP_H)
        {
            StageTask__SetAnimation(&work->gameWork.objWork, FIREFLOOR_ANI_ACTIVE_H);
        }

        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }

    BOOL checkRange = FALSE;
    BOOL isImmune   = FALSE;
    u16 id          = work->gameWork.mapObject->id;

    if (gPlayer->characterID == CHARACTER_BLAZE || (gPlayer->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
    {
        checkRange = TRUE;
    }
    else
    {
        checkRange = isImmune;
    }

    if (checkRange)
    {
        fx32 x = work->gameWork.objWork.position.x;
        if (x - FLOAT_TO_FX32(64.0) <= gPlayer->objWork.position.x && gPlayer->objWork.position.x <= x + FLOAT_TO_FX32(64.0))
        {
            fx32 y = work->gameWork.objWork.position.y;
            if (y - FLOAT_TO_FX32(64.0) <= gPlayer->objWork.position.y && gPlayer->objWork.position.y <= y + FLOAT_TO_FX32(64.0))
                isImmune = TRUE;
        }
    }

    fx32 *scale;
    if (id == MAPOBJECT_224 || id == MAPOBJECT_225)
        scale = &work->gameWork.objWork.scale.y;
    else
        scale = &work->gameWork.objWork.scale.x;

    if (isImmune && (work->gameWork.objWork.obj_2d->ani.work.animID == FIREFLOOR_ANI_ACTIVE_V || work->gameWork.objWork.obj_2d->ani.work.animID == FIREFLOOR_ANI_ACTIVE_H))
    {
        if (*scale > FLOAT_TO_FX32(0.25))
        {
            *scale -= FLOAT_TO_FX32(0.125);
            if (*scale < FLOAT_TO_FX32(0.25))
                *scale = FLOAT_TO_FX32(0.25);
        }

        ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
        ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], FireHazard_OnDefend);
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    }
    else
    {
        if (*scale < FLOAT_TO_FX32(1.0))
        {
            *scale += FLOAT_TO_FX32(0.125);
            if (*scale > FLOAT_TO_FX32(1.0))
                *scale = FLOAT_TO_FX32(1.0);
        }
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].hitFlag  = OBS_RECT_WORK_ATTR_NORMAL;
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].hitPower = OBS_RECT_HITPOWER_DEFAULT;
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].defFlag  = OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_NONE);
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].defPower = OBS_RECT_DEFPOWER_INVINCIBLE;
        ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], FireHazard_OnHit);
        work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag &= ~OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    }

    if (work->gameWork.objWork.userTimer != 0)
    {
        work->gameWork.objWork.userTimer--;
        if (work->gameWork.objWork.userTimer == 0)
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag &= ~(OBS_RECT_WORK_FLAG_NO_ONATTACK_ONENTER | OBS_RECT_WORK_FLAG_SYS_HAD_DEF_THIS_FRAME | OBS_RECT_WORK_FLAG_SYS_WILL_DEF_THIS_FRAME);
    }
}

void FireHazard_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FireHazard *fire = (FireHazard *)rect1->parent;
    Player *player   = (Player *)rect2->parent;

    if (fire == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (fire->gameWork.objWork.obj_2d->ani.work.animID == FIREFLOOR_ANI_ACTIVE_V)
    {
        StageTask__SetAnimation(&fire->gameWork.objWork, FIREFLOOR_ANI_FLAREUP_V);
    }
    else if (fire->gameWork.objWork.obj_2d->ani.work.animID == FIREFLOOR_ANI_ACTIVE_H)
    {
        StageTask__SetAnimation(&fire->gameWork.objWork, FIREFLOOR_ANI_FLAREUP_H);
    }
}

void FireHazard_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FireHazard *fire = (FireHazard *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (fire == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (player->objWork.move.x == 0 && player->objWork.move.y == 0)
        ObjRect__FuncNoHit(rect1, rect2);
    else
        fire->gameWork.objWork.userTimer = 5;
}
