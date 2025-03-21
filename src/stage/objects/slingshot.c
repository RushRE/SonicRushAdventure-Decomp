#include <stage/objects/slingshot.h>
#include <game/stage/gameSystem.h>
#include <game/stage/stageAssets.h>
#include <game/object/obj.h>
#include <game/object/objectManager.h>
#include <game/math/akMath.h>
#include <stage/effects/slingDust.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void Slingshot_Destructor(Task *task);
static void Slingshot_State_Idle(Slingshot *work);
static void Slingshot_State_Activated(Slingshot *work);
static void Slingshot_HandleRockPosition(Slingshot *work);
static void Slingshot_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void Slingshot_Draw(void);

static void SlingshotRock_State_Idle(SlingshotRock *work);
static void SlingshotRock_State_Launched(SlingshotRock *work);

// --------------------
// FUNCTIONS
// --------------------

Slingshot *CreateSlingshot(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(Slingshot_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), Slingshot);
    if (task == HeapNull)
        return NULL;

    Slingshot *work = TaskGetWork(task, Slingshot);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_sling.bac", GetObjectDataWork(OBJDATAWORK_159), gameArchiveStage, 48);
    work->gameWork.animator.ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 92);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, 0);

    AnimatorSpriteDS *aniMachine = &work->aniMachine;
    ObjAction2dBACLoad(&work->aniMachine, "/act/ac_gmk_sling.bac", 36, GetObjectDataWork(OBJDATAWORK_159), gameArchiveStage);
    aniMachine->work.cParam.palette = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
    aniMachine->cParam[0].palette = aniMachine->cParam[1].palette = aniMachine->work.cParam.palette;
    aniMachine->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__SetAnimation(&work->aniMachine, 1);
    StageTask__SetOAMOrder(&aniMachine->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniMachine->work, SPRITE_PRIORITY_2);

    AnimatorSpriteDS *aniCounterweight = &work->aniCounterweight;
    ObjAction2dBACLoad(aniCounterweight, "/act/ac_gmk_sling.bac", 20, GetObjectDataWork(OBJDATAWORK_159), gameArchiveStage);
    aniCounterweight->work.cParam.palette = work->gameWork.objWork.obj_2d->ani.work.cParam.palette;
    aniCounterweight->cParam[0].palette = aniCounterweight->cParam[1].palette = aniCounterweight->work.cParam.palette;
    aniCounterweight->work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;
    AnimatorSpriteDS__SetAnimation(aniCounterweight, 2);
    StageTask__SetOAMOrder(&aniCounterweight->work, SPRITE_ORDER_23);
    StageTask__SetOAMPriority(&aniCounterweight->work, SPRITE_PRIORITY_2);

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -152, -32, -120, 0);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 0, 0);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], ~1, 0);
    work->gameWork.colliders[0].onDefend = Slingshot_OnDefend;
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_400;

    work->gameWork.objWork.dir.z = -FLOAT_DEG_TO_IDX(16.875);
    if (mapObject->id == MAPOBJECT_212)
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        work->gameWork.objWork.velocity.x = -FLOAT_TO_FX32(10.0);
    }
    else
    {
        work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(10.0);
    }

    work->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(1.0) * ClampS32(work->gameWork.mapObject->left, 0, 8) - FLOAT_TO_FX32(4.0);
    Slingshot_HandleRockPosition(work);

    SlingshotRock *rock = SpawnStageObject(MAPOBJECT_330, work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, SlingshotRock);
    if (rock)
    {
        rock->gameWork.objWork.parentObj  = &work->gameWork.objWork;
        rock->gameWork.objWork.position.x = work->gameWork.objWork.userTimer;
        rock->gameWork.objWork.position.y = work->gameWork.objWork.userWork;
    }

    SetTaskOutFunc(&work->gameWork.objWork, Slingshot_Draw);
    SetTaskState(&work->gameWork.objWork, Slingshot_State_Idle);

    return work;
}

SlingshotRock *CreateSlingshotRock(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), SlingshotRock);
    if (task == HeapNull)
        return NULL;

    SlingshotRock *work = TaskGetWork(task, SlingshotRock);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_sling.bac", GetObjectDataWork(OBJDATAWORK_159), gameArchiveStage, 8);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 92);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, 3);

    ObjRect__SetGroupFlags(&work->gameWork.colliders[0], 1, 2);
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -20, -20, 20, 20);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], 1, 64);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], 0xFFFF, 0xFF);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], NULL);
    work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800 | OBS_RECT_WORK_FLAG_20;

    ObjRect__SetGroupFlags(&work->gameWork.colliders[1], 1, 2);
    ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, -20, -20, 20, 20);
    work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_800 | OBS_RECT_WORK_FLAG_20;

    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

    SetTaskState(&work->gameWork.objWork, SlingshotRock_State_Idle);

    return work;
}

void Slingshot_Destructor(Task *task)
{
    Slingshot *work = TaskGetWork(task, Slingshot);

    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_159), &work->aniMachine);
    ObjAction2dBACRelease(GetObjectDataWork(OBJDATAWORK_159), &work->aniCounterweight);

    GameObject__Destructor(task);
}

void Slingshot_State_Idle(Slingshot *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if (player != NULL && !CheckPlayerGimmickObj(player, work))
        work->gameWork.parent = NULL;

    Slingshot_HandleRockPosition(work);
}

void Slingshot_State_Activated(Slingshot *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if (player != NULL && !CheckPlayerGimmickObj(player, work))
        work->gameWork.parent = NULL;

    work->anglePercent -= FLOAT_TO_FX32(0.015625);
    if (work->anglePercent < FLOAT_TO_FX32(0.1875))
        work->anglePercent = FLOAT_TO_FX32(0.1875);

    work->gameWork.objWork.dir.z = AkMath__Func_2002D28(work->gameWork.objWork.dir.z, FLOAT_DEG_TO_IDX(90.0), work->anglePercent);
    Slingshot_HandleRockPosition(work);

    if (work->gameWork.objWork.dir.z == FLOAT_DEG_TO_IDX(90.0))
    {
        work->gameWork.objWork.userFlag |= SLINGSHOT_FLAG_ROCK_LAUNCHED;
        SetTaskState(&work->gameWork.objWork, Slingshot_State_Idle);
    }
}

void Slingshot_HandleRockPosition(Slingshot *work)
{
    u16 angle;
    fx32 x, y;
    fx32 curX, curY;
    fx32 prevX, prevY;

    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        angle = -1 * work->gameWork.objWork.dir.z;
        x     = -FLOAT_TO_FX32(29.0);
        curX  = FLOAT_TO_FX32(132.0);
        prevX = FLOAT_TO_FX32(148.0);
    }
    else
    {
        angle = work->gameWork.objWork.dir.z;
        x     = FLOAT_TO_FX32(29.0);
        curX  = -FLOAT_TO_FX32(132.0);
        prevX = -FLOAT_TO_FX32(148.0);
    }

    AkMath__Func_2002C98(x, FLOAT_TO_FX32(0.0), &x, &y, angle);

    y -= FLOAT_TO_FX32(72.0);
    if (y > -FLOAT_TO_FX32(68.0))
    {
        work->offset.y = -FLOAT_TO_FX32(68.0);
    }
    else
    {
        work->offset.x = x;
        work->offset.y = y;
    }

    AkMath__Func_2002C98(curX, -FLOAT_TO_FX32(8.0), &curX, &curY, angle);
    work->gameWork.objWork.userTimer = work->gameWork.objWork.position.x + curX;
    work->gameWork.objWork.userWork  = work->gameWork.objWork.position.y + curY - FLOAT_TO_FX32(72.0);

    AkMath__Func_2002C98(prevX, FLOAT_TO_FX32(4.0), &prevX, &prevY, angle);
    work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x + prevX;
    work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y + prevY - FLOAT_TO_FX32(72.0);
}

void Slingshot_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Slingshot *slingshot = (Slingshot *)rect2->parent;
    Player *player       = (Player *)rect1->parent;

    if (slingshot == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    slingshot->gameWork.colliders[0].parent = NULL;
    slingshot->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_800;

    slingshot->gameWork.parent = &player->objWork;
    Player__Action_EnterSlingshot(player, &slingshot->gameWork);
    slingshot->anglePercent = FLOAT_TO_FX32(0.3125);
    SetTaskState(&slingshot->gameWork.objWork, Slingshot_State_Activated);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CATAPULT);
}

void Slingshot_Draw(void)
{
    Slingshot *work = TaskGetWorkCurrent(Slingshot);

    u32 displayFlag = (work->gameWork.objWork.displayFlag | DISPLAY_FLAG_DISABLE_ROTATION) & ~DISPLAY_FLAG_FLIP_X;
    StageTask__Draw2DEx(&work->aniMachine, &work->gameWork.objWork.position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);

    displayFlag |= DISPLAY_FLAG_FLIP_X;
    StageTask__Draw2DEx(&work->aniMachine, &work->gameWork.objWork.position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);

    displayFlag = work->gameWork.objWork.displayFlag | DISPLAY_FLAG_DISABLE_ROTATION;

    VecFx32 position;
    VecU16 direction;

    position.x = work->gameWork.objWork.position.x + work->offset.x;
    position.y = work->gameWork.objWork.position.y + work->offset.y;
    position.z = FLOAT_TO_FX32(0.0);
    StageTask__Draw2DEx(&work->aniCounterweight, &position, NULL, &work->gameWork.objWork.scale, &displayFlag, NULL, NULL);

    position.x = work->gameWork.objWork.position.x;
    position.y = work->gameWork.objWork.position.y;
    position.y -= FLOAT_TO_FX32(72.0);

    direction.x = direction.y = FLOAT_DEG_TO_IDX(0.0);
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        direction.z = -work->gameWork.objWork.dir.z;
    }
    else
    {
        direction.z = work->gameWork.objWork.dir.z;
    }

    StageTask__Draw2DEx(&work->gameWork.objWork.obj_2d->ani, &position, &direction, &work->gameWork.objWork.scale, &work->gameWork.objWork.displayFlag, NULL, NULL);
}

void SlingshotRock_State_Idle(SlingshotRock *work)
{
    Slingshot *parent = (Slingshot *)work->gameWork.objWork.parentObj;
    if (parent != NULL)
    {
        work->gameWork.objWork.prevPosition.x = work->gameWork.objWork.position.x;
        work->gameWork.objWork.prevPosition.y = work->gameWork.objWork.position.y;
        work->gameWork.objWork.position.x     = parent->gameWork.objWork.userTimer;
        work->gameWork.objWork.position.y     = parent->gameWork.objWork.userWork;
        work->gameWork.objWork.move.x         = work->gameWork.objWork.position.x - work->gameWork.objWork.prevPosition.x;
        work->gameWork.objWork.move.y         = work->gameWork.objWork.position.y - work->gameWork.objWork.prevPosition.y;

        if ((parent->gameWork.objWork.userFlag & SLINGSHOT_FLAG_ROCK_LAUNCHED) != 0)
        {
            SetTaskState(&work->gameWork.objWork, SlingshotRock_State_Launched);
            work->gameWork.objWork.parentObj = NULL;

            work->gameWork.objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;

            work->gameWork.objWork.velocity.x = parent->gameWork.objWork.velocity.x;
            work->gameWork.objWork.velocity.y = parent->gameWork.objWork.velocity.y;

            Player *player = (Player *)parent->gameWork.parent;
            if (player != NULL)
            {
                if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
                {
                    work->gameWork.objWork.velocity.x += (parent->gameWork.objWork.velocity.x >> 3) + (parent->gameWork.objWork.velocity.x >> 4);
                    work->gameWork.objWork.velocity.y += parent->gameWork.objWork.velocity.y >> 4;
                }
                else if ((player->playerFlag & PLAYER_FLAG_BOOST) != 0)
                {
                    work->gameWork.objWork.velocity.x += parent->gameWork.objWork.velocity.x >> 4;
                    work->gameWork.objWork.velocity.y += parent->gameWork.objWork.velocity.y >> 4;
                }
            }

            work->gameWork.colliders[0].parent = &work->gameWork.objWork;
            work->gameWork.colliders[0].flag &= ~OBS_RECT_WORK_FLAG_800;
            work->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;

            work->gameWork.colliders[1].parent = &work->gameWork.objWork;
            work->gameWork.colliders[1].flag &= ~OBS_RECT_WORK_FLAG_800;
            work->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;

            work->gameWork.collisionObject.work.parent = NULL;
        }
    }
}

void SlingshotRock_State_Launched(SlingshotRock *work)
{
    work->gameWork.objWork.dir.z += work->gameWork.objWork.velocity.x >> 4;

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
    {
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROYED;

        EffectSlingDust__Create(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, -FLOAT_TO_FX32(2.0) - (mtMathRandRepeat(128) << 4),
                                -FLOAT_TO_FX32(3.0) - (mtMathRandRepeat(128) << 4), 0);

        EffectSlingDust__Create(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, FLOAT_TO_FX32(2.0) + (mtMathRandRepeat(128) << 4),
                                -FLOAT_TO_FX32(4.0) - (mtMathRandRepeat(128) << 4), 1);

        EffectSlingDust__Create(work->gameWork.objWork.position.x, work->gameWork.objWork.position.y, FLOAT_TO_FX32(0.25) - (mtMathRandRepeat(128) << 4),
                                -FLOAT_TO_FX32(4.0) - (mtMathRandRepeat(128) << 4), 1);

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_DEST_OBJ);
    }
}