#include <stage/objects/avalanche.h>
#include <stage/effects/snowslide.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/audio/spatialAudio.h>
#include <game/graphics/screenShake.h>

// --------------------
// ENUMS
// --------------------

enum AvalancheTreeObjectFlags
{
    AVALANCHETREE_OBJFLAG_NONE,

    AVALANCHETREE_OBJFLAG_LOW_PRIORITY = 1 << 0,
};

// TODO: probably move this to an ice tree decoration header when/if it's made
enum AvalancheTreeAnimID
{
    AVALANCHETREE_ANI_TREE_0,
    AVALANCHETREE_ANI_TREE_1,
    AVALANCHETREE_ANI_AVALANCHE_TREE,
};

enum AvalancheFlags
{
    AVALANCHE_FLAG_NONE,

    AVALANCHE_FLAG_TRACK_DISTANCE = 1 << 0,
    AVALANCHE_FLAG_IS_READY       = 1 << 1,
};

// --------------------
// VARIABLES
// --------------------

static fx32 moveSpeedTable_Near[CHARACTER_COUNT] = { [CHARACTER_SONIC] = FLOAT_TO_FX32(10.5), [CHARACTER_BLAZE] = FLOAT_TO_FX32(10.0) };
static fx32 distanceTable_Start[CHARACTER_COUNT] = { [CHARACTER_SONIC] = FLOAT_TO_FX32(48.0), [CHARACTER_BLAZE] = FLOAT_TO_FX32(56.0) };
static fx32 distanceTable_Near[CHARACTER_COUNT]  = { [CHARACTER_SONIC] = FLOAT_TO_FX32(48.0), [CHARACTER_BLAZE] = FLOAT_TO_FX32(56.0) };
static fx32 distanceTable_Far[CHARACTER_COUNT]   = { [CHARACTER_SONIC] = FLOAT_TO_FX32(64.0), [CHARACTER_BLAZE] = FLOAT_TO_FX32(72.0) };
static fx32 moveSpeedTable_Far[CHARACTER_COUNT]  = { [CHARACTER_SONIC] = FLOAT_TO_FX32(14.0), [CHARACTER_BLAZE] = FLOAT_TO_FX32(13.0) };

static u8 debrisTypeTable[8] = { 0, 1, 2, 0, 1, 2, 0, 1 };

// --------------------
// FUNCTION DECLS
// --------------------

static void Avalanche_State_Ready(Avalanche *work);
static void Avalanche_State_Active(Avalanche *work);
static void Avalanche_OnDefend_StartTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Avalanche_OnDefend_ActivateTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Avalanche_OnDefend_EndTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Avalanche_OnDefend_CameraTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

static void AvalancheTree_State_Hit(AvalancheTree *work);
static void AvalancheTree_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

Avalanche *CreateAvalanche(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), Avalanche);
    if (task == HeapNull)
        return NULL;

    Avalanche *work = TaskGetWork(task, Avalanche);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_NO_DRAW;

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, mapObject->left, mapObject->top, mapObject->left + mapObject->width, mapObject->top + mapObject->height);

    if (mapObject->id == MAPOBJECT_194)
    {
        ObjRect__SetAttackStat(work->gameWork.colliders, 0, 0);
        ObjRect__SetDefenceStat(work->gameWork.colliders, ~1, 0);
        ObjRect__SetOnDefend(&work->gameWork.colliders[0], Avalanche_OnDefend_ActivateTrigger);

        work->gameWork.colliders[1].parent = &work->gameWork.objWork;
        ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, mapObject->left - 48, mapObject->top, mapObject->left - 16, mapObject->top + mapObject->height);
        ObjRect__SetAttackStat(&work->gameWork.colliders[1], 0, 0);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~1, 0);
        ObjRect__SetOnDefend(&work->gameWork.colliders[1], Avalanche_OnDefend_StartTrigger);
    }
    else
    {
        ObjRect__SetGroupFlags(&work->gameWork.colliders[0], 1, 2);
        ObjRect__SetAttackStat(&work->gameWork.colliders[0], 16, 0);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~0, 0xFF);
        ObjRect__SetOnDefend(&work->gameWork.colliders[0], NULL);

        work->gameWork.colliders[1].parent = &work->gameWork.objWork;
        ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, mapObject->left, mapObject->top, mapObject->left + mapObject->width, mapObject->top + mapObject->height);
        ObjRect__SetAttackStat(&work->gameWork.colliders[1], 0, 0);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~1, 0);
        ObjRect__SetOnDefend(&work->gameWork.colliders[1], Avalanche_OnDefend_CameraTrigger);
    }
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();

    return work;
}

AvalancheTree *CreateAvalancheTree(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), AvalancheTree);
    if (task == HeapNull)
        return NULL;

    AvalancheTree *work = TaskGetWork(task, AvalancheTree);
    TaskInitWork8(work);

    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_dec_ice_tree.bac", GetObjectDataWork(OBJDATAWORK_202), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 54, GetObjectSpriteRef(OBJDATAWORK_203));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, AVALANCHETREE_ANI_TREE_0, 64);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    if ((mapObject->flags & AVALANCHETREE_OBJFLAG_LOW_PRIORITY) != 0)
        StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_0);
    else
        StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_3);
    StageTask__SetAnimation(&work->gameWork.objWork, AVALANCHETREE_ANI_AVALANCHE_TREE);

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, 16, -52, 60, 2);
    ObjRect__SetGroupFlags(&work->gameWork.colliders[0], 1, 2);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], 1, 0x3F);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], AvalancheTree_OnDefend);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    return work;
}

void Avalanche_State_Ready(Avalanche *work)
{
    fx32 distance;

    if ((gPlayer->playerFlag & PLAYER_FLAG_DEATH) != 0
        || ((distance = (gPlayer->objWork.position.x - work->gameWork.objWork.position.x)), MATH_ABS(distance) >= FLOAT_TO_FX32(1024.0)))
    {
        DestroyStageTask(&work->gameWork.objWork);
    }
    else if (distance >= FLOAT_TO_FX32(128.0))
    {
        gPlayer->gimmickCamCenterOffsetX = 80;
        gPlayer->gimmickCamCenterOffsetY = 40;

        work->gameWork.objWork.position.y += FLOAT_TO_FX32(160.0);
        work->gameWork.colliders[0].parent = &work->gameWork.objWork;
        ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -32, -32, 0, 16);
        ObjRect__SetAttackStat(&work->gameWork.colliders[0], 4, 64);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~0, 0xFF);
        ObjRect__SetOnDefend(&work->gameWork.colliders[0], NULL);
        work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_IS_ACTIVE;

        work->gameWork.colliders[1].parent = &work->gameWork.objWork;
        ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -16, -16, 16, 16);
        ObjRect__SetAttackStat(&work->gameWork.colliders[1], 0, 0);
        ObjRect__SetDefenceStat(&work->gameWork.colliders[1], ~16, 0);
        ObjRect__SetOnDefend(&work->gameWork.colliders[1], Avalanche_OnDefend_EndTrigger);
        work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_400 | OBS_RECT_WORK_FLAG_IS_ACTIVE;

        StageTask__SetHitbox(&work->gameWork.objWork, -6, -6, 6, 6);

        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
        work->gameWork.objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        work->gameWork.objWork.moveFlag |=
            STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
        work->gameWork.objWork.groundVel = FLOAT_TO_FX32(13.5);
        SetTaskState(&work->gameWork.objWork, Avalanche_State_Active);

        PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SNOWSLIDE);
        ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);

        ShakeScreen(SCREENSHAKE_D_LONG);

        work->gameWork.objWork.userWork = 8;
    }
}

void Avalanche_State_Active(Avalanche *work)
{
    u32 characterID = gPlayer->characterID;

    if (work->gameWork.objWork.userTimer == 0 && ((gPlayer->playerFlag & PLAYER_FLAG_DEATH) != 0 || (playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0))
    {
        work->gameWork.objWork.userTimer = 16;
    }
    else
    {
        if (MATH_ABS(gPlayer->objWork.position.x - work->gameWork.objWork.position.x) >= FLOAT_TO_FX32(1024.0) || (work->gameWork.objWork.move.x + work->gameWork.objWork.move.y) == FLOAT_TO_FX32(0.0)
            || (work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
        {
            DestroyStageTask(&work->gameWork.objWork);

            ShakeScreen(SCREENSHAKE_STOP);
            ShakeScreen(SCREENSHAKE_C_LONG);

            gPlayer->gimmickCamCenterOffsetX = 0;
            gPlayer->gimmickCamCenterOffsetY = 0;
            return;
        }

        if (work->gameWork.objWork.userTimer != 0)
        {
            work->gameWork.objWork.userTimer--;
            if (work->gameWork.objWork.userTimer == 0)
            {
                DestroyStageTask(&work->gameWork.objWork);

                StopStageSfx(work->gameWork.objWork.sequencePlayerPtr);
                ShakeScreen(SCREENSHAKE_STOP);
                ShakeScreen(SCREENSHAKE_C_LONG);

                gPlayer->gimmickCamCenterOffsetX = 0;
                gPlayer->gimmickCamCenterOffsetY = 0;
                return;
            }
        }
    }

    if (gPlayer->objWork.position.x < work->gameWork.objWork.position.x)
    {
        gPlayer->gimmickCamCenterOffsetX = 0;
        gPlayer->gimmickCamCenterOffsetY = 0;
    }
    else
    {
        gPlayer->gimmickCamCenterOffsetX = 80;
        gPlayer->gimmickCamCenterOffsetY = 40;
    }

    if (work->gameWork.objWork.userWork != 0)
    {
        work->gameWork.objWork.userWork--;
        if (work->gameWork.objWork.userWork == 0)
            ShakeScreen(SCREENSHAKE_C_LOOP);
    }

    if ((work->gameWork.flags & AVALANCHE_FLAG_TRACK_DISTANCE) != 0)
    {
        fx32 distance = gPlayer->objWork.position.x - work->gameWork.objWork.position.x;
        if (distance >= distanceTable_Far[characterID])
        {
            work->gameWork.objWork.groundVel = moveSpeedTable_Far[characterID];
        }
        else if (distance <= distanceTable_Near[characterID])
        {
            work->gameWork.objWork.groundVel = moveSpeedTable_Near[characterID];
        }
    }
    else
    {
        if (gPlayer->objWork.position.x - work->gameWork.objWork.position.x <= distanceTable_Start[characterID])
        {
            work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION;
            work->gameWork.objWork.groundVel = moveSpeedTable_Near[characterID];
            work->gameWork.flags |= AVALANCHE_FLAG_TRACK_DISTANCE;
        }
    }

    if ((playerGameStatus.stageTimer & 1) == 0)
    {
        fx32 velY    = -FLOAT_TO_FX32(0.0625) - mtMathRandRepeat(0x400);
        fx32 offsetY = FX32_FROM_WHOLE(mtMathRandRepeat(32) - 24);
        fx32 offsetX = FX32_FROM_WHOLE(mtMathRandRepeat(32) - 15);

        EffectAvalanche__Create(work->gameWork.objWork.position.x + offsetX, work->gameWork.objWork.position.y + offsetY, -work->gameWork.objWork.move.x >> 4, velY);
    }

    if (((playerGameStatus.stageTimer + 4) & 0x1F) == 0)
    {
        fx32 velY = (mtMathRandRepeat(FLOAT_TO_FX32(1.0)) - FLOAT_TO_FX32(3.0));
        fx32 velX = (mtMathRandRepeat(FLOAT_TO_FX32(1.0)) + FLOAT_TO_FX32(8.0));
        fx32 type = mtMathRandRepeat(8);

        EffectAvalancheDebris__Create(debrisTypeTable[type], work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, velX, velY);
    }

    ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
}

void Avalanche_OnDefend_StartTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player       = (Player *)rect1->parent;
    Avalanche *avalanche = (Avalanche *)rect2->parent;

    if (avalanche == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (StageTaskStateMatches(&avalanche->gameWork.objWork, Avalanche_State_Ready) == FALSE && StageTaskStateMatches(&avalanche->gameWork.objWork, Avalanche_State_Active) == FALSE)
        avalanche->gameWork.flags |= AVALANCHE_FLAG_IS_READY;
}

void Avalanche_OnDefend_ActivateTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player       = (Player *)rect1->parent;
    Avalanche *avalanche = (Avalanche *)rect2->parent;

    if (avalanche == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((avalanche->gameWork.flags & AVALANCHE_FLAG_IS_READY) != 0)
    {
        avalanche->gameWork.flags &= ~AVALANCHE_FLAG_IS_READY;
        SetTaskState(&avalanche->gameWork.objWork, Avalanche_State_Ready);
        ObjRect__SetOnDefend(&avalanche->gameWork.colliders[0], NULL);
    }
}

void Avalanche_OnDefend_EndTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Avalanche *avalanche  = (Avalanche *)rect2->parent;
    Avalanche *avalanche2 = (Avalanche *)rect1->parent;

    if (avalanche == NULL || avalanche2 == NULL)
        return;

    if (avalanche2->gameWork.objWork.objType != STAGE_OBJ_TYPE_OBJECT)
        return;

    if (avalanche2->gameWork.mapObject->id == MAPOBJECT_195)
    {
        QueueDestroyStageTask(&avalanche->gameWork.objWork);

        ShakeScreen(SCREENSHAKE_STOP);
        ShakeScreen(SCREENSHAKE_C_LONG);

        gPlayer->gimmickCamCenterOffsetX = 0;
        gPlayer->gimmickCamCenterOffsetY = 0;
    }
}

void Avalanche_OnDefend_CameraTrigger(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player       = (Player *)rect1->parent;
    Avalanche *avalanche = (Avalanche *)rect2->parent;

    if (avalanche == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    player->gimmickCamCenterOffsetX = 0;
    player->gimmickCamCenterOffsetY = 0;

    ObjRect__SetOnDefend(&avalanche->gameWork.colliders[1], NULL);
}

void AvalancheTree_State_Hit(AvalancheTree *work)
{
    work->gameWork.objWork.dir.z += FLOAT_DEG_TO_IDX(11.25);

    if (work->gameWork.objWork.dir.z >= FLOAT_DEG_TO_IDX(112.5))
        SetTaskState(&work->gameWork.objWork, NULL);
}

void AvalancheTree_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    AvalancheTree *tree  = (AvalancheTree *)rect2->parent;
    Avalanche *avalanche = (Avalanche *)rect1->parent;

    if (tree == NULL || avalanche == NULL)
        return;

    if (avalanche->gameWork.objWork.objType != STAGE_OBJ_TYPE_OBJECT)
        return;

    if (avalanche->gameWork.mapObject->id == MAPOBJECT_194)
    {
        tree->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
        tree->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        SetTaskState(&tree->gameWork.objWork, AvalancheTree_State_Hit);

        fx32 velY = -mtMathRandRepeat(0x200);
        fx32 velX = mtMathRandRepeat(0x200);
        EffectAvalanche__Create(tree->gameWork.objWork.position.x - FLOAT_TO_FX32(16.0), tree->gameWork.objWork.position.y - FLOAT_TO_FX32(48.0), velX, velY);
    }
}
