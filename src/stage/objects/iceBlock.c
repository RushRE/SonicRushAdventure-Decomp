#include <stage/objects/iceBlock.h>
#include <stage/effects/iceBlockDebris.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>

// --------------------
// ENUMS
// --------------------

enum IceBlockObjectFlags
{
    ICEBLOCK_OBJFLAG_NONE,

    ICEBLOCK_OBJFLAG_REMOVE_IN_VS_BATTLE = 1 << 0,
};

enum IceBlockAnimID
{
    ICEBLOCK_ANI_BLOCK,
    ICEBLOCK_ANI_DEBRIS_1,
    ICEBLOCK_ANI_DEBRIS_2,
    ICEBLOCK_ANI_DEBRIS_3,
    ICEBLOCK_ANI_DEBRIS_4,
};

// --------------------
// FUNCTION DECLS
// --------------------

static void IceBlock_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

IceBlock *CreateIceBlock(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    if (gmCheckGameMode(GAMEMODE_VS_BATTLE) && (mapObject->flags & ICEBLOCK_OBJFLAG_REMOVE_IN_VS_BATTLE) != 0)
    {
        DestroyMapObject(mapObject);
        return NULL;
    }

    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), IceBlock);
    if (task == HeapNull)
        return NULL;

    IceBlock *work = TaskGetWork(task, IceBlock);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_ice_block.bac", GetObjectFileWork(OBJDATAWORK_175), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 8, GetObjectSpriteRef(OBJDATAWORK_176));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, ICEBLOCK_ANI_BLOCK, 35);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_22);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, ICEBLOCK_ANI_BLOCK);

    ObjRect__SetAttackStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_NORMAL), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].onDefend = IceBlock_OnDefend;
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
    work->gameWork.collisionObject.work.width     = 32;
    work->gameWork.collisionObject.work.height    = 32;
    work->gameWork.collisionObject.work.ofst_x    = -16;
    work->gameWork.collisionObject.work.ofst_y    = -32;

    return work;
}

void IceBlock_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    IceBlock *iceBlock = (IceBlock *)rect2->parent;
    Player *player     = (Player *)rect1->parent;

    if (iceBlock == NULL || player == NULL)
        return;

    switch (player->objWork.objType)
    {
        case STAGE_OBJ_TYPE_EFFECT:
            player = (Player *)player->objWork.parentObj;

            if (player == NULL || player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
                return;

            player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL;
            break;

        default:
            if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
                return;

            if (((player->objWork.moveFlag == STAGE_TASK_MOVE_FLAG_NONE) & STAGE_TASK_MOVE_FLAG_IS_FALLING) != 0)
                return;

            Player__Action_DestroyAttackRecoil(player);
            break;
    }

    QueueDestroyStageTask(&iceBlock->gameWork.objWork);
    iceBlock->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    iceBlock->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;
    iceBlock->gameWork.collisionObject.work.flag |= STAGE_TASK_OBJCOLLISION_FLAG_DISABLED;

    fx32 x = iceBlock->gameWork.objWork.position.x;
    fx32 y = iceBlock->gameWork.objWork.position.y;
    EffectIceBlockDebris__Create(0, x, y, -FLOAT_TO_FX32(3.1875), -FLOAT_TO_FX32(2.875));
    EffectIceBlockDebris__Create(1, x, y, -FLOAT_TO_FX32(2.0), -FLOAT_TO_FX32(2.5));
    EffectIceBlockDebris__Create(2, x, y, FLOAT_TO_FX32(3.0), -FLOAT_TO_FX32(2.0));
    EffectIceBlockDebris__Create(3, x, y, FLOAT_TO_FX32(2.25), -FLOAT_TO_FX32(3.125));

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ICE_BLOCK);
}
