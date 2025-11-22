#include <stage/objects/pirateShip.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/pirateShipCannonBlast.h>
#include <stage/effects/explosion.h>
#include <stage/effects/groundExplosion.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_distanceUnits    mapObject->top   // 1 = 100 pixels
#define mapObjectParam_distanceSubUnits mapObject->width // 1 = 1 pixel

// --------------------
// ENUMS
// --------------------

enum PirateShipFlags
{
    PIRATESHIP_FLAG_NONE,

    PIRATESHIP_FLAG_MOVING_LEFT = 1 << 0,
};

// --------------------
// VARIABLES
// --------------------

static s16 cannonBallShootIntervalTable[] = { 25, 15, 20, 15, 25, 5, 10, 20, 5, 15, 25, 20, 10, 25, 20, 15 };
static s16 cannonBallSpawnPosTable[]      = { 0, -41, -37, -34, -21, -38, 39, -34, 0, -41, -37, -34, 22, -39, 39, -34 };
static s16 cannonBallVelocityXTable[]     = { 56, -88, 108, -56, 72, -76, 64, -64, 80, -80, 96, -72, 48, -60, 88, -48 };

// --------------------
// FUNCTION DECLS
// --------------------

static void PirateShip_State_Appear(PirateShip *work);
static void PirateShip_State_Active(PirateShip *work);
static void PirateShip_State_Disappear(PirateShip *work);
static void PirateShip_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static fx32 PirateShip_GetPlayerVelocity(Player *player);

static void PirateShipCannonBall_State_Active(PirateShipCannonBall *work);
static void PirateShipCannonBall_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE OBS_SPRITE_REF *GetCannonBallSpriteRef(int arg0)
{
  return GetObjectSpriteRef(arg0);
}

// --------------------
// FUNCTIONS
// --------------------

PirateShip *CreatePirateShip(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), PirateShip);
    if (task == HeapNull)
        return NULL;

    PirateShip *work = TaskGetWork(task, PirateShip);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_pirate_ship.bac", GetObjectDataWork(OBJDATAWORK_162), gameArchiveStage, 119);
    ObjActionAllocSpritePalette(&work->gameWork.objWork, PIRATESHIP_ANI_SHIP, 87);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_3);
    StageTask__SetAnimation(&work->gameWork.objWork, PIRATESHIP_ANI_SHIP);

    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].rect, 0, -512, 64, 0);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], PirateShip_OnDefend);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    work->startPos = work->gameWork.objWork.position.x - FLOAT_TO_FX32(32.0);
    work->endPos   = work->gameWork.objWork.position.x + FX32_FROM_WHOLE((mapObjectParam_distanceSubUnits + 100 * mapObjectParam_distanceUnits)) + FLOAT_TO_FX32(32.0);

    return work;
}

PirateShipCannonBall *CreatePirateShipCannonBall(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), PirateShipCannonBall);
    if (task == HeapNull)
        return NULL;

    PirateShipCannonBall *work = TaskGetWork(task, PirateShipCannonBall);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= 
        STAGE_TASK_MOVE_FLAG_DISABLE_X_COLLISION_CHECK |
        STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | 
        STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | 
        STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_pirate_ship.bac", GetObjectDataWork(OBJDATAWORK_162), gameArchiveStage,
                             OBJ_DATA_GFX_NONE);
    ObjObjectActionAllocSprite(&work->gameWork.objWork, 8, GetCannonBallSpriteRef(OBJDATAWORK_163));
    ObjActionAllocSpritePalette(&work->gameWork.objWork, PIRATESHIP_ANI_CANNONBALL, 83);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->gameWork.objWork, PIRATESHIP_ANI_CANNONBALL);
    ObjRect__SetDefenceStat(work->gameWork.colliders, OBS_RECT_WORK_ATTR_BODY, OBS_RECT_DEFPOWER_DEFAULT + 2);
    ObjRect__SetOnAttack(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], PirateShipCannonBall_OnHit);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_ALLOW_MULTI_ATK_PER_FRAME;

    StageTask__SetHitbox(&work->gameWork.objWork, -4, 7, 4, 13);
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.position.z = FLOAT_TO_FX32(64.0);
    work->gameWork.objWork.scale.x    = FLOAT_TO_FX32(0.125);
    work->gameWork.objWork.scale.y    = FLOAT_TO_FX32(0.125);

    SetTaskState(&work->gameWork.objWork, PirateShipCannonBall_State_Active);

    return work;
}

void PirateShip_State_Appear(PirateShip *work)
{
    Player *player = (Player *)work->gameWork.parent;

    fx32 velocity = PirateShip_GetPlayerVelocity(player);
    if (velocity < FLOAT_TO_FX32(0.0))
        velocity = FLOAT_TO_FX32(0.0);

    if (player->objWork.position.x < work->startPos || player->objWork.position.x > work->endPos)
    {
        work->speed += velocity;
        SetTaskState(&work->gameWork.objWork, PirateShip_State_Disappear);
    }
    else
    {
        if (work->gameWork.objWork.position.x >= mapCamera.camera[player->cameraID].disp_pos.x + FLOAT_TO_FX32(127.9921875))
        {
            work->gameWork.objWork.velocity.x = work->speed + PirateShip_GetPlayerVelocity(player);
            work->gameWork.objWork.userTimer  = 0;
            work->gameWork.objWork.userWork   = playerGameStatus.stageTimer & 0xF;
            SetTaskState(&work->gameWork.objWork, PirateShip_State_Active);
        }
        else
        {
            work->speed = ObjSpdDownSet(work->speed, FLOAT_TO_FX32(0.0625));
            if (work->speed < FLOAT_TO_FX32(2.0))
                work->speed = FLOAT_TO_FX32(2.0);
            work->gameWork.objWork.velocity.x = velocity + work->speed;
        }
    }
}

void PirateShip_State_Active(PirateShip *work)
{
    Player *player = (Player *)work->gameWork.parent;

    fx32 velocity = PirateShip_GetPlayerVelocity(player);
    if (player->objWork.position.x < work->startPos || player->objWork.position.x > work->endPos)
    {
        work->speed += velocity;
        SetTaskState(&work->gameWork.objWork, PirateShip_State_Disappear);
        return;
    }

    fx32 targetPos = mapCamera.camera[player->cameraID].disp_pos.x + FLOAT_TO_FX32(HW_LCD_CENTER_X);
    fx32 shipPos   = work->gameWork.objWork.position.x;

    if (targetPos + FLOAT_TO_FX32(32.0) < shipPos)
    {
        work->speed = ObjSpdUpSet(work->speed, -FLOAT_TO_FX32(0.09375), FLOAT_TO_FX32(2.5));
        work->gameWork.flags |= PIRATESHIP_FLAG_MOVING_LEFT;
    }
    else
    {
        if (targetPos - FLOAT_TO_FX32(32.0) > shipPos)
        {
            work->speed = ObjSpdUpSet(work->speed, FLOAT_TO_FX32(0.09375), FLOAT_TO_FX32(2.5));
            work->gameWork.flags &= ~PIRATESHIP_FLAG_MOVING_LEFT;
        }
        else
        {
            if ((work->gameWork.flags & PIRATESHIP_FLAG_MOVING_LEFT) == 0 && targetPos < shipPos)
            {
                if (work->speed >= FLOAT_TO_FX32(0.0))
                {
                    work->speed = ObjSpdDownSet(work->speed, FLOAT_TO_FX32(0.09375));
                    if (work->speed < FLOAT_TO_FX32(1.5))
                        work->speed = FLOAT_TO_FX32(1.5);
                }
                else
                {
                    work->speed = ObjSpdUpSet(work->speed, FLOAT_TO_FX32(0.09375), FLOAT_TO_FX32(2.5));
                }
            }
            else
            {
                if ((work->gameWork.flags & PIRATESHIP_FLAG_MOVING_LEFT) != 0 && targetPos > shipPos)
                {
                    if (work->speed < FLOAT_TO_FX32(0.0))
                    {
                        work->speed = ObjSpdDownSet(work->speed, FLOAT_TO_FX32(0.09375));
                        if (work->speed > -FLOAT_TO_FX32(1.5))
                            work->speed = -FLOAT_TO_FX32(1.5);
                    }
                    else
                    {
                        work->speed = ObjSpdUpSet(work->speed, -FLOAT_TO_FX32(0.09375), FLOAT_TO_FX32(2.5));
                    }
                }
                else
                {
                    fx32 step = FLOAT_TO_FX32(0.09375);
                    if ((work->gameWork.flags & PIRATESHIP_FLAG_MOVING_LEFT) != 0)
                        step = -FLOAT_TO_FX32(0.09375);

                    work->speed = ObjSpdUpSet(work->speed, step, FLOAT_TO_FX32(2.5));
                }
            }
        }
    }

    work->gameWork.objWork.velocity.x = velocity + work->speed;

    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer <= 0)
    {
        PirateShipCannonBall *cannonBall;

        fx32 spawnOffsetX = FX32_FROM_WHOLE(cannonBallSpawnPosTable[((2 * work->gameWork.objWork.userWork) & 0xF) + 0]);
        fx32 spawnOffsetY = FX32_FROM_WHOLE(cannonBallSpawnPosTable[((2 * work->gameWork.objWork.userWork) & 0xF) + 1]);

        fx32 spawnX = work->gameWork.objWork.position.x + spawnOffsetX;
        fx32 spawnY = work->gameWork.objWork.position.y + spawnOffsetY;
        cannonBall  = SpawnStageObject(MAPOBJECT_327, spawnX, spawnY, PirateShipCannonBall);

        if (cannonBall != NULL)
        {
            cannonBall->gameWork.objWork.velocity.x = velocity;
            cannonBall->gameWork.objWork.velocity.y = -FLOAT_TO_FX32(8.5);

            fx32 speed = player->objWork.position.x - (work->gameWork.objWork.position.x + spawnOffsetX);
            if (velocity != FLOAT_TO_FX32(0.0))
                speed += FX32_FROM_WHOLE(cannonBallVelocityXTable[work->gameWork.objWork.userWork & 0xF]);
            cannonBall->gameWork.objWork.velocity.x += FX_DivS32(speed, FLOAT_TO_FX32(0.026));
        }

        PirateShipCannonBlast__Create(&work->gameWork.objWork, spawnOffsetX, spawnOffsetY);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PIRATE_FIRE);
        work->gameWork.objWork.userTimer = cannonBallShootIntervalTable[work->gameWork.objWork.userWork];
        work->gameWork.objWork.userWork  = (work->gameWork.objWork.userWork + 1) & 0xF;
    }
}

void PirateShip_State_Disappear(PirateShip *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if (player->objWork.position.x >= work->startPos && player->objWork.position.x <= work->endPos)
    {
        SetTaskState(&work->gameWork.objWork, PirateShip_State_Appear);
        PirateShip_State_Appear(work);
    }
    else
    {
        work->speed                       = ObjSpdUpSet(work->speed, FLOAT_TO_FX32(0.125), FLOAT_TO_FX32(17.0));
        work->gameWork.objWork.velocity.x = work->speed;

        if (mapCamera.camera[player->cameraID].disp_pos.x + FLOAT_TO_FX32(HW_LCD_WIDTH + 96.0f) < work->gameWork.objWork.position.x)
        {
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
            work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
            work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = &work->gameWork.objWork;
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag &= ~OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

            work->gameWork.objWork.velocity.x = FLOAT_TO_FX32(0.0);

            work->gameWork.objWork.prevPosition.x = work->originPos;
            work->gameWork.objWork.position.x     = work->gameWork.objWork.prevPosition.x;

            SetTaskState(&work->gameWork.objWork, NULL);
        }
    }
}

void PirateShip_OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    PirateShip *pirateShip = (PirateShip *)rect2->parent;
    Player *player         = (Player *)rect1->parent;

    if (pirateShip == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    fx32 velocity = PirateShip_GetPlayerVelocity(player);
    if (velocity < 0)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        pirateShip->gameWork.objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
        pirateShip->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
        pirateShip->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        pirateShip->gameWork.flags &= ~PIRATESHIP_FLAG_MOVING_LEFT;

        pirateShip->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].parent = NULL;
        pirateShip->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

        pirateShip->gameWork.parent                 = &player->objWork;
        pirateShip->gameWork.objWork.velocity.x     = velocity + FLOAT_TO_FX32(6.0);
        pirateShip->speed                           = FLOAT_TO_FX32(6.0);
        pirateShip->originPos                       = pirateShip->gameWork.objWork.position.x;
        pirateShip->gameWork.objWork.position.x     = mapCamera.camera[player->cameraID].disp_pos.x - FLOAT_TO_FX32(96.0);
        pirateShip->gameWork.objWork.prevPosition.x = pirateShip->gameWork.objWork.position.x;

        SetTaskState(&pirateShip->gameWork.objWork, PirateShip_State_Appear);
    }
}

fx32 PirateShip_GetPlayerVelocity(Player *player)
{
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) != 0)
        return player->objWork.velocity.x;
    else
        return MultiplyFX(player->objWork.groundVel, CosFX(player->objWork.dir.z));
}

void PirateShipCannonBall_State_Active(PirateShipCannonBall *work)
{
    work->gameWork.objWork.position.z -= FLOAT_TO_FX32(0.875);
    if (work->gameWork.objWork.position.z < FLOAT_TO_FX32(0.0))
        work->gameWork.objWork.position.z = FLOAT_TO_FX32(0.0);

    fx32 zScale                    = MultiplyFX(work->gameWork.objWork.position.z, 56);
    work->gameWork.objWork.scale.x = FLOAT_TO_FX32(1.0) - zScale;
    work->gameWork.objWork.scale.y = FLOAT_TO_FX32(1.0) - zScale;

    if (work->gameWork.objWork.velocity.y > FLOAT_TO_FX32(0.0))
        work->gameWork.objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    if ((work->gameWork.objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        CreateEffectGroundExplosion(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(14.0));
        DestroyStageTask(&work->gameWork.objWork);
        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SE_PIRATE_IMPACT);
    }
}

void PirateShipCannonBall_OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    PirateShipCannonBall *cannonBall = (PirateShipCannonBall *)rect1->parent;
    Player *player                   = (Player *)rect2->parent;

    if (cannonBall == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    CreateEffectExplosion(&cannonBall->gameWork.objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), EXPLOSION_BIG);
    QueueDestroyStageTask(&cannonBall->gameWork.objWork);
}
