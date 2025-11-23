#include <stage/objects/balloon.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/stage/gameSystem.h>
#include <game/audio/spatialAudio.h>
#include <game/math/akMath.h>
#include <stage/effects/enemyDebris.h>
#include <stage/effects/explosion.h>
#include <stage/effects/hoverCrystalSparkle.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void BalloonSpawner_State_Active(BalloonSpawner *work);

static void Balloon_Destructor(Task *task);
static void Balloon_State_Appearing(Balloon *work);
static void Balloon_State_FloatingUp(Balloon *work);
static void Balloon_State_FloatAway(Balloon *work);
static void Balloon_Pop(Balloon *work);
static void Balloon_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Balloon_Draw(void);

// --------------------
// FUNCTIONS
// --------------------

BalloonSpawner *CreateBalloonSpawner(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), BalloonSpawner);
    if (task == HeapNull)
        return NULL;

    BalloonSpawner *work = TaskGetWork(task, BalloonSpawner);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    SetTaskState(&work->gameWork.objWork, BalloonSpawner_State_Active);

    Balloon *balloon = SpawnStageObjectEx(MAPOBJECT_338, x, y, Balloon, mapObject->flags, mapObject->left, mapObject->top, mapObject->width, mapObject->height, 0);
    work->balloon    = balloon;

    if (balloon != NULL)
        balloon->gameWork.objWork.parentObj = &work->gameWork.objWork;

    return work;
}

Balloon *CreateBalloon(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task;
    Balloon *work;
    s32 i;

    task = CreateStageTask(Balloon_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), Balloon);
    if (task == HeapNull)
        return NULL;

    work = TaskGetWork(task, Balloon);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS
                                       | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_LIMIT_MAP_BOUNDS;
    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_balloon.bac", GetObjectDataWork(OBJDATAWORK_161), gameArchiveStage, 16);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 2, 6);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, 2);

    AnimatorSpriteDS *aniBalloon = &work->aniBalloon;
    ObjAction2dBACLoad(aniBalloon, "/act/ac_gmk_balloon.bac", 26, GetObjectDataWork(OBJDATAWORK_161), gameArchiveStage);
    aniBalloon->work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    aniBalloon->work.cParam.palette = ObjDrawAllocSpritePalette(work->gameWork.animator.fileWork->fileData, 0, 97);
    aniBalloon->cParam[0].palette = aniBalloon->cParam[1].palette = aniBalloon->work.cParam.palette;
    aniBalloon->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    StageTask__SetOAMOrder(&aniBalloon->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniBalloon->work, SPRITE_PRIORITY_2);
    AnimatorSpriteDS__SetAnimation(aniBalloon, 0);

    AnimatorSpriteDS *aniCrystal = &work->aniCrystal;
    ObjAction2dBACLoad(aniCrystal, "/act/ac_gmk_balloon.bac", 2, GetObjectDataWork(OBJDATAWORK_161), gameArchiveStage);
    aniCrystal->work.cParam.palette = ObjDrawAllocSpritePalette(work->gameWork.animator.fileWork->fileData, 1, 97);
    aniCrystal->cParam[0].palette = aniCrystal->cParam[1].palette = aniCrystal->work.cParam.palette;
    aniCrystal->work.flags                                        = aniCrystal->work.flags | ANIMATOR_FLAG_DISABLE_PALETTES;
    StageTask__SetOAMOrder(&aniCrystal->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniCrystal->work, SPRITE_PRIORITY_2);
    AnimatorSpriteDS__SetAnimation(aniCrystal, 1);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, -16, -8, 16, 8);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Balloon_OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    work->gameWork.objWork.sequencePlayerPtr = AllocSndHandle();
    SetTaskOutFunc(&work->gameWork.objWork, Balloon_Draw);

    if (type != 0)
    {
        i = 0;

        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;

        work->gameWork.objWork.scale.x = work->gameWork.objWork.scale.y = FLOAT_TO_FX32(0.0);

        SetTaskState(&work->gameWork.objWork, Balloon_State_Appearing);

        fx32 x = work->gameWork.objWork.position.x;
        fx32 y = work->gameWork.objWork.position.y - FLOAT_TO_FX32(40.0);

        u16 angle = FLOAT_DEG_TO_IDX(0.0);
        for (; i < 8;)
        {
            fx32 velX = FX32_TO_WHOLE(FX32_FROM_WHOLE(CosFX(angle >> 0)) << 1);
            fx32 velY = FX32_TO_WHOLE(FX32_FROM_WHOLE(SinFX(angle >> 0)) << 1);
            EffectHoverCrystalSparkle__Create(x, y, velX, velY, -velX >> 8, -velY >> 8);

            i++;
            angle += FLOAT_DEG_TO_IDX(45.0);
        }

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_REGENERATION);
        ProcessSpatialSfx(&defaultSfxPlayer, &work->gameWork.objWork.position);
    }

    return work;
}

void BalloonSpawner_State_Active(BalloonSpawner *work)
{
    if (work->balloon != NULL && (IsStageTaskDestroyedAny(&work->balloon->gameWork.objWork) || work->balloon->gameWork.objWork.parentObj == NULL))
    {
        work->balloon                    = NULL;
        work->gameWork.objWork.userTimer = 180 - 3 * work->gameWork.mapObject->left;
    }

    if (work->gameWork.objWork.userTimer != 0)
    {
        work->gameWork.objWork.userTimer--;
        if (work->gameWork.objWork.userTimer <= 0)
        {
            MapObject *mapObject             = work->gameWork.mapObject;
            work->gameWork.objWork.userTimer = 0;

            Balloon *balloon = SpawnStageObjectEx(MAPOBJECT_338, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, Balloon, mapObject->flags, mapObject->left,
                                                  mapObject->top, mapObject->width, mapObject->height, 1);
            work->balloon    = balloon;
            if (balloon != NULL)
                balloon->gameWork.objWork.parentObj = &work->gameWork.objWork;
        }
    }
}

void Balloon_Destructor(Task *task)
{
    s32 i;
    Balloon *work = TaskGetWork(task, Balloon);

    for (i = 0; i < 2; i++)
    {
        ObjDrawReleaseSpritePalette(work->animators[i].work.cParam.palette);
        ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_161), &work->animators[i]);
    }

    NNS_SndPlayerStopSeq(work->gameWork.objWork.sequencePlayerPtr, 0);

    GameObject__Destructor(task);
}

void Balloon_State_Appearing(Balloon *work)
{
    work->gameWork.objWork.userTimer += FLOAT_TO_FX32(1.0 / 10.0);

    if (work->gameWork.objWork.userTimer >= FLOAT_TO_FX32(1.0))
    {
        work->gameWork.objWork.scale.x = work->gameWork.objWork.scale.y = FLOAT_TO_FX32(1.0);

        work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
        SetTaskState(&work->gameWork.objWork, NULL);
    }
    else
    {
        work->gameWork.objWork.scale.x = work->gameWork.objWork.scale.y = mtLerpEx(work->gameWork.objWork.userTimer, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), 1);
    }
}

void Balloon_State_FloatingUp(Balloon *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
    {
        Balloon_Pop(work);
    }
    else
    {
        if (player == NULL || !CheckPlayerGimmickObj(player, work) || MATH_ABS((s16)work->gameWork.objWork.dir.z - (s16)player->objWork.dir.z) >= FLOAT_DEG_TO_IDX(22.5))
        {
            work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
            work->gameWork.objWork.velocity.x = work->gameWork.objWork.move.x;
            work->gameWork.objWork.velocity.y = work->gameWork.objWork.move.y;

            SetTaskState(&work->gameWork.objWork, Balloon_State_FloatAway);
            Balloon_State_FloatAway(work);
        }
        else
        {
            fx32 x;
            fx32 y;

            work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x;
            work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y;
            work->gameWork.objWork.dir.z          = player->objWork.dir.z;

            AkMath__Func_2002C98(FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(16.0), &x, &y, work->gameWork.objWork.dir.z);

            work->gameWork.objWork.position.x = player->objWork.position.x + x;
            work->gameWork.objWork.position.y = player->objWork.position.y + y;
            work->gameWork.objWork.position.z = player->objWork.position.z;

            work->gameWork.objWork.move.x = work->gameWork.objWork.position.x - work->gameWork.objWork.prevPosition.x;
            work->gameWork.objWork.move.y = work->gameWork.objWork.position.y - work->gameWork.objWork.prevPosition.y;

            AkMath__Func_2002C98(FLOAT_TO_FX32(0.0), -60, &x, &y, work->gameWork.objWork.dir.z);
            StageTask__SetHitbox(&work->gameWork.objWork, x - 20, y - 20, x + 20, y + 20);

            if ((playerGameStatus.stageTimer & 7) == 0)
            {
                AkMath__Func_2002C98(FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(66.0), &x, &y, work->gameWork.objWork.dir.z);

                fx32 offsetX = FX32_FROM_WHOLE(mtMathRandRange2(-4, 4));
                fx32 offsetY = FX32_FROM_WHOLE(mtMathRandRange2(-4, 4));

                EffectHoverCrystalSparkle__Create(work->gameWork.objWork.position.x + x + offsetX, work->gameWork.objWork.position.y + y + offsetY,
                                                  -work->gameWork.objWork.move.x >> 4, -work->gameWork.objWork.move.y >> 3, offsetX >> 7, FLOAT_TO_FX32(0.0));
            }

            ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
        }
    }
}

void Balloon_State_FloatAway(Balloon *work)
{
    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
    {
        Balloon_Pop(work);
    }
    else
    {
        fx32 x;
        fx32 y;

        work->gameWork.objWork.velocity.y = ObjSpdUpSet(work->gameWork.objWork.velocity.y, -FLOAT_TO_FX32(0.0625), work->gameWork.objWork.userTimer);
        work->gameWork.objWork.velocity.x = ObjSpdDownSet(work->gameWork.objWork.velocity.x, FLOAT_TO_FX32(0.0625));
        work->gameWork.objWork.dir.z      = ObjRoopMove16(work->gameWork.objWork.dir.z, FLOAT_DEG_TO_IDX(0.0), FLOAT_TO_FX32(0.03125));

        AkMath__Func_2002C98(FLOAT_TO_FX32(0.0), -60, &x, &y, work->gameWork.objWork.dir.z);
        StageTask__SetHitbox(&work->gameWork.objWork, x - 20, y - 20, x + 20, y + 20);
    }
}

void Balloon_Pop(Balloon *work)
{
    CreateEffectExplosion(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(68.0), EXPLOSION_SMALL);
    CreateEffectEnemyDebris(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(68.0), -FLOAT_TO_FX32(2.0), -FLOAT_TO_FX32(4.0), 9);
    CreateEffectEnemyDebris(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(68.0), FLOAT_TO_FX32(2.0), -FLOAT_TO_FX32(4.0), 9);

    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CELING);
    DestroyStageTask(&work->gameWork.objWork);
}

void Balloon_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Balloon *balloon = (Balloon *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (balloon == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    balloon->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    balloon->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;

    balloon->gameWork.objWork.userTimer = (MTM_MATH_CLIP(balloon->gameWork.mapObject->left, 0, 16) << 11) + FLOAT_TO_FX32(2.0);
    Player__Action_BalloonRide(player, &balloon->gameWork, balloon->gameWork.objWork.userTimer);
    balloon->gameWork.parent            = &player->objWork;
    balloon->gameWork.objWork.parentObj = NULL;
    balloon->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    StageTask__SetHitbox(&balloon->gameWork.objWork, -20, -80, 20, -40);
    balloon->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IS_FALLING;

    SetTaskState(&balloon->gameWork.objWork, Balloon_State_FloatingUp);

    PlayHandleStageSfx(balloon->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RISE);
    ProcessSpatialSfx(balloon->gameWork.objWork.sequencePlayerPtr, &balloon->gameWork.objWork.position);
}

void Balloon_Draw(void)
{
    Balloon *work = TaskGetWorkCurrent(Balloon);

    StageTask__Draw2D(&work->gameWork.objWork, &work->gameWork.objWork.obj_2d->ani);

    u32 displayFlag = work->gameWork.objWork.displayFlag;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    StageTask__Draw2D(&work->gameWork.objWork, &work->aniBalloon);
    StageTask__Draw2D(&work->gameWork.objWork, &work->aniCrystal);

    work->gameWork.objWork.displayFlag = displayFlag;
}