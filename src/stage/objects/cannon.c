#include <stage/objects/cannon.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/sailboatBazookaSmoke.h>
#include <stage/effects/cannonFireSpeedLines.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

// Used in Cannon (and passed through to CannonPath)
#define mapObjectParam_pathFallLength   mapObject->left
#define mapObjectParam_pathTravelLength mapObject->top

// --------------------
// ENUMS
// --------------------

enum CannonRingObjectFlags_
{
    CANNONRING_OBJFLAG_NONE,

    CANNONRING_OBJFLAG_TYPE_MASK = (1 << 0) | (1 << 1),

    CANNONRING_OBJFLAG_FORCE_COMBO_FINISH = 1 << 7,
};

enum CannonModes_
{
    CANNON_MODE_WAITING_FOR_PLAYER_ENTRY,
    CANNON_MODE_PLAYER_ENTRY_SHAKE,
    CANNON_MODE_AIMING,
    CANNON_MODE_AIM_CONFIRM_SHAKE,
    CANNON_MODE_LAUNCH,
};

enum CannonRingAnimIDs_
{
    CANNONRING_ANI_RING,
    CANNONRING_ANI_PROMPT_IDLE_B,
    CANNONRING_ANI_PROMPT_IDLE_A,
    CANNONRING_ANI_PROMPT_IDLE_R,
    CANNONRING_ANI_PROMPT_ACTIVE_B,
    CANNONRING_ANI_PROMPT_ACTIVE_A,
    CANNONRING_ANI_PROMPT_ACTIVE_R,
};

enum CannonRingFlags_
{
    CANNONRING_FLAG_NONE,

    CANNONRING_FLAG_PROMPT_ACTIVE   = 1 << 0,
    CANNONRING_FLAG_PROMPT_DISABLED = 1 << 1,
};

enum CannonPathFlags_
{
    CANNONPATH_FLAG_NONE = 0x00,

    CANNONPATH_FLAG_FINISHED_TRAVERSE = 1 << 0,
};

// --------------------
// VARIABLES
// --------------------

static BOOL canDrawRings;
static fx32 cannonPosZ;
static fx32 playerPosZ;

// --------------------
// FUNCTION DECLS
// --------------------

void Cannon_Destructor(Task *task);
static void Cannon_State_PlayerEntered(Cannon *work);
static void Cannon_State_LaunchedPlayer(Cannon *work);
void Cannon_Draw(void);
void Cannon_OnDefend_Entrry(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

void CannonFloor_State_Solid(CannonFloor *work);
void CannonFloor_Collide(void);

static void CannonPath_Destructor(Task *task);
static void CannonPath_State_PlayerLaunched(CannonPath *work);

static void CannonRing_Destructor(Task *task);
static void CannonRing_Draw(void);
static void CannonRing_OnDefend_RingTriggerStart(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);
static void CannonRing_OnDefend_RingTriggerEnd(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2);

// --------------------
// FUNCTIONS
// --------------------

CannonPath *CreateCannonPath(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(CannonPath_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x10F6, TASK_GROUP(2), CannonPath);
    if (task == HeapNull)
        return NULL;

    CannonPath *work = TaskGetWork(task, CannonPath);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

    SetTaskState(&work->gameWork.objWork, CannonPath_State_PlayerLaunched);

    playerPosZ   = FLOAT_TO_FX32(0.0);
    cannonPosZ   = FLOAT_TO_FX32(0.0);
    canDrawRings = FALSE;

    work->pathRemaining = FX32_FROM_WHOLE(mapObjectParam_pathTravelLength << 6) - FLOAT_TO_FX32(128.0);
    if (work->pathRemaining < FLOAT_TO_FX32(64.0))
        work->pathRemaining = FLOAT_TO_FX32(64.0);

    work->pathFallDistance = work->pathRemaining;
    work->pathRemaining += FLOAT_TO_FX32(128.0);

    work->fallVelocity = FX_Div(FX32_FROM_WHOLE(mapObjectParam_pathFallLength << 6), FX_Div(work->pathFallDistance, FLOAT_TO_FX32(1.42212)));

    return work;
}

fx32 GetCannonPlayerPosZ(void)
{
    return playerPosZ;
}

CannonRing *CreateCannonRing(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    Task *task = CreateStageTask(CannonRing_Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), CannonRing);
    if (task == HeapNull)
        return NULL;

    CannonRing *work = TaskGetWork(task, CannonRing);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION | DISPLAY_FLAG_DISABLE_LOOPING;
    work->type = mapObject->flags & CANNONRING_OBJFLAG_TYPE_MASK;

    void *sprCannonRing = ObjDataLoad(GetObjectFileWork(OBJDATAWORK_166), "/act/ac_gmk_dash_ct_f3d.bac", gameArchiveStage);

    AnimatorSprite3D *aniRing  = &work->aniRing;
    VRAMPixelKey vramTexture   = VRAMSystem__AllocTexture(2048, FALSE);
    VRAMPaletteKey vramPalette = VRAMSystem__AllocPalette(16, FALSE);
    AnimatorSprite3D__Init(aniRing, ANIMATOR_FLAG_NONE, sprCannonRing, CANNONRING_ANI_RING, ANIMATOR_FLAG_NONE, vramTexture, vramPalette);
    aniRing->work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
    aniRing->work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;
    AnimatorSprite3D__ProcessAnimationFast(aniRing);
    aniRing->animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    AnimatorSprite3D *aniButtonPrompt = &work->aniButtonPrompt;
    vramTexture                       = VRAMSystem__AllocTexture(512, FALSE);
    vramPalette                       = VRAMSystem__AllocPalette(16, FALSE);
    AnimatorSprite3D__Init(aniButtonPrompt, ANIMATOR_FLAG_NONE, sprCannonRing, CANNONRING_ANI_PROMPT_IDLE_B + work->type, ANIMATOR_FLAG_NONE, vramTexture, vramPalette);
    aniButtonPrompt->work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
    aniButtonPrompt->work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;
    AnimatorSprite3D__ProcessAnimationFast(aniButtonPrompt);
    aniButtonPrompt->animatorSprite.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    SetTaskOutFunc(&work->gameWork.objWork, CannonRing_Draw);

    work->gameWork.colliders[0].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[0].rect, -8, -128, 4, 128);
    ObjRect__SetAttackStat(&work->gameWork.colliders[0], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[0], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[0], CannonRing_OnDefend_RingTriggerStart);

    work->gameWork.colliders[1].parent = &work->gameWork.objWork;
    ObjRect__SetBox2D(&work->gameWork.colliders[1].rect, 4, -128, 8, 128);
    ObjRect__SetAttackStat(&work->gameWork.colliders[1], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[1], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    ObjRect__SetOnDefend(&work->gameWork.colliders[1], CannonRing_OnDefend_RingTriggerEnd);

    return work;
}

void Cannon_Destructor(Task *task)
{
    Cannon *cannon = TaskGetWork(task, Cannon);

    for (s32 i = 0; i < (s32)ARRAY_COUNT(cannon->aniCannon); i++)
    {
        AnimatorMDL__Release(&cannon->aniCannon[i]);
    }

    ObjDataRelease(GetObjectDataWork(OBJDATAWORK_165));

    GameObject__Destructor(task);
}

void Cannon_State_PlayerEntered(Cannon *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if (CheckPlayerGimmickObj(player, work) == FALSE)
    {
        SetTaskState(&work->gameWork.objWork, NULL);
    }
    else
    {
        switch (work->gameWork.objWork.userWork)
        {
            case CANNON_MODE_WAITING_FOR_PLAYER_ENTRY:
                if ((player->objWork.userFlag & PLAYER_CANNON_FLAG_IN_CANNON) != 0)
                {
                    work->gameWork.objWork.userWork++;
                    work->gameWork.objWork.shakeTimer = FLOAT_TO_FX32(4.0);
                }
                break;

            case CANNON_MODE_PLAYER_ENTRY_SHAKE:
                if (work->gameWork.objWork.shakeTimer == FLOAT_TO_FX32(0.0))
                    work->gameWork.objWork.userWork++;
                break;

            case CANNON_MODE_AIMING:
                work->gameWork.objWork.dir.x += FLOAT_DEG_TO_IDX(1.40625);
                if (work->gameWork.objWork.dir.x >= FLOAT_DEG_TO_IDX(56.25))
                {
                    work->gameWork.objWork.userWork++;
                    work->gameWork.objWork.shakeTimer = FLOAT_TO_FX32(4.0);
                }
                break;

            case CANNON_MODE_AIM_CONFIRM_SHAKE:
                if (work->gameWork.objWork.shakeTimer == FLOAT_TO_FX32(0.0))
                {
                    work->gameWork.objWork.userWork++;
                    work->gameWork.objWork.userTimer = 0;
                }
                break;

            case CANNON_MODE_LAUNCH:
                work->gameWork.objWork.userTimer++;
                if (work->gameWork.objWork.userTimer >= 8)
                {
                    MapObject *mapObject = work->gameWork.mapObject;
                    CannonPath *path     = SpawnStageObjectEx(MAPOBJECT_328, player->objWork.position.x, player->objWork.position.y, CannonPath, mapObject->flags, mapObject->left,
                                                              mapObject->top, mapObject->width, mapObject->height, 0);

                    if (path == NULL)
                    {
                        SetTaskState(&work->gameWork.objWork, NULL);

                        player->gimmickObj    = NULL;
                        work->gameWork.parent = NULL;
                    }
                    else
                    {
                        path->gameWork.parent = &player->objWork;

                        path->dir = work->gameWork.objWork.dir;

                        path->gameWork.objWork.dir.z = work->gameWork.objWork.dir.x;
                        path->gameWork.objWork.dir.y = work->gameWork.objWork.dir.y - FLOAT_DEG_TO_IDX(90.0);

                        path->cannonPos = work->gameWork.objWork.position;

                        FXMatrix33 mtxRot;
                        FXMatrix33 mtxTemp;

                        MTX_Identity33(mtxRot.nnMtx);

                        MTX_RotX33(mtxTemp.nnMtx, SinFX((s32)(u16)(path->dir.x - FLOAT_DEG_TO_IDX(90.0))), CosFX((s32)(u16)(path->dir.x - FLOAT_DEG_TO_IDX(90.0))));
                        MTX_Concat33(mtxRot.nnMtx, mtxTemp.nnMtx, mtxRot.nnMtx);

                        MTX_RotY33(mtxTemp.nnMtx, SinFX((s32)(u16)-path->dir.y), CosFX((s32)(u16)-path->dir.y));
                        MTX_Concat33(mtxRot.nnMtx, mtxTemp.nnMtx, mtxRot.nnMtx);

                        MTX_RotZ33(mtxTemp.nnMtx, SinFX(path->dir.z), CosFX(path->dir.z));
                        MTX_Concat33(mtxRot.nnMtx, mtxTemp.nnMtx, mtxRot.nnMtx);

                        path->launchVelocity.x = FLOAT_TO_FX32(0.0);
                        path->launchVelocity.y = FLOAT_TO_FX32(0.0);
                        path->launchVelocity.z = -FLOAT_TO_FX32(10.0);
                        MTX_MultVec33(&path->launchVelocity, mtxRot.nnMtx, &path->launchVelocity);

                        Player__Action_FireCannon(player, &path->gameWork);

                        work->gameWork.parent = NULL;

                        SetTaskState(&work->gameWork.objWork, Cannon_State_LaunchedPlayer);

                        EffectSailboatBazookaSmoke__Create(&work->gameWork.objWork, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(40.0), FLOAT_TO_FX32(30.0));
                    }
                }
                break;
        }
    }
}

void Cannon_State_LaunchedPlayer(Cannon *work)
{
    work->gameWork.objWork.offset.z = playerPosZ;
}

void Cannon_Draw(void)
{
    FXMatrix33 mtxTemp;
    VecFx32 position;

    Cannon *work = TaskGetWorkCurrent(Cannon);

    StageDisplayFlags displayFlag = work->gameWork.objWork.displayFlag;
    if (playerPosZ != FLOAT_TO_FX32(0.0))
        displayFlag &= ~DISPLAY_FLAG_ROTATE_CAMERA_DIR;

    AnimatorMDL *aniCannon0 = &work->aniCannon[0];
    MTX_Identity33(aniCannon0->work.rotation.nnMtx);

    MTX_RotX33(mtxTemp.nnMtx, SinFX((s32)(u16)-work->gameWork.objWork.dir.x), CosFX((s32)(u16)-work->gameWork.objWork.dir.x));
    MTX_Concat33(aniCannon0->work.rotation.nnMtx, mtxTemp.nnMtx, aniCannon0->work.rotation.nnMtx);

    MTX_RotY33(mtxTemp.nnMtx, SinFX((s32)(u16)-work->gameWork.objWork.dir.y), CosFX((s32)(u16)-work->gameWork.objWork.dir.y));
    MTX_Concat33(aniCannon0->work.rotation.nnMtx, mtxTemp.nnMtx, aniCannon0->work.rotation.nnMtx);

    position.x = work->gameWork.objWork.position.x + work->gameWork.objWork.offset.x;
    position.y = work->gameWork.objWork.position.y - FLOAT_TO_FX32(39.0) + work->gameWork.objWork.offset.y;
    position.z = work->gameWork.objWork.position.z + playerPosZ;
    StageTask__Draw3DEx(&aniCannon0->work, &position, NULL, NULL, &displayFlag, NULL, NULL, NULL);

    AnimatorMDL *aniCannon1 = &work->aniCannon[1];
    MTX_Identity33(aniCannon1->work.rotation.nnMtx);

    MTX_RotY33(mtxTemp.nnMtx, SinFX((s32)(u16)-work->gameWork.objWork.dir.y), CosFX((s32)(u16)-work->gameWork.objWork.dir.y));
    MTX_Concat33(aniCannon1->work.rotation.nnMtx, mtxTemp.nnMtx, aniCannon1->work.rotation.nnMtx);

    position.x = work->gameWork.objWork.position.x + work->gameWork.objWork.offset.x;
    position.y = work->gameWork.objWork.position.y + work->gameWork.objWork.offset.y;
    position.z = work->gameWork.objWork.position.z + playerPosZ;
    StageTask__Draw3DEx(&aniCannon1->work, &position, NULL, NULL, &displayFlag, NULL, NULL, NULL);
}

void Cannon_OnDefend_Entrry(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Cannon *cannon = (Cannon *)rect2->parent;
    Player *player = (Player *)rect1->parent;

    if (cannon == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if (player->objWork.position.y + FLOAT_TO_FX32(13.0) <= cannon->gameWork.objWork.position.y - FLOAT_TO_FX32(74.0))
    {
        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        {
            Player__Action_EnterCannon(player, &cannon->gameWork, PLAYER_CANNON_ENTRY_WALK_INTO);
        }
        else if ((cannon->gameWork.objWork.position.x - FLOAT_TO_FX32(8.0) <= player->objWork.position.x
                  && player->objWork.position.x <= cannon->gameWork.objWork.position.x + FLOAT_TO_FX32(8.0)))
        {
            Player__Action_EnterCannon(player, &cannon->gameWork, PLAYER_CANNON_ENTRY_FALL_INTO);
        }
        else
        {
            ObjRect__FuncNoHit(rect1, rect2);
            return;
        }
    }
    else
    {
        if ((player->objWork.position.x + FLOAT_TO_FX32(6.0) <= cannon->gameWork.objWork.position.x - FLOAT_TO_FX32(16.0)
             || player->objWork.position.x - FLOAT_TO_FX32(6.0) >= cannon->gameWork.objWork.position.x + FLOAT_TO_FX32(24.0)))
        {
            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0
                && player->objWork.position.y + FLOAT_TO_FX32(13.0) >= cannon->gameWork.objWork.position.y - FLOAT_TO_FX32(58.0))
            {
                Player__Action_EnterCannon(player, &cannon->gameWork, PLAYER_CANNON_ENTRY_ROTATE_INTO);
            }
            else
            {
                ObjRect__FuncNoHit(rect1, rect2);
                return;
            }
        }
        else
        {
            ObjRect__FuncNoHit(rect1, rect2);
            return;
        }
    }

    cannon->gameWork.colliders[0].parent = NULL;
    cannon->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    cannon->gameWork.parent           = &player->objWork;
    cannon->gameWork.objWork.userWork = CANNONPATH_MODE_MOVE_TO_PATH;

    SetTaskState(&cannon->gameWork.objWork, Cannon_State_PlayerEntered);
}

void CannonFloor_State_Solid(CannonFloor *work)
{
    if (cannonPosZ != FLOAT_TO_FX32(500.0))
    {
        work->gameWork.objWork.offset.z = cannonPosZ;
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    }
    else
    {
        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    }
}

void CannonFloor_Collide(void)
{
    CannonFloor *work = TaskGetWorkCurrent(CannonFloor);

    if ((work->gameWork.objWork.flag & (STAGE_TASK_FLAG_DESTROY_NEXT_FRAME | STAGE_TASK_FLAG_DESTROYED)) != 0)
        return;

    if (StageTask__ViewCheck_Default(&work->gameWork.objWork) != FALSE)
        return;

    if (work->gameWork.collisionObject.work.parent)
        ObjCollisionObjectRegist(&work->gameWork.collisionObject.work);

    if (work->collisionWorkWallL.parent)
        ObjCollisionObjectRegist(&work->collisionWorkWallL);

    if (work->collisionWorkWallR.parent)
        ObjCollisionObjectRegist(&work->collisionWorkWallR);
}

void CannonPath_Destructor(Task *task)
{
    playerPosZ   = FLOAT_TO_FX32(0.0);
    cannonPosZ   = FLOAT_TO_FX32(0.0);
    canDrawRings = FALSE;

    GameObject__Destructor(task);
}

void CannonPath_State_PlayerLaunched(CannonPath *work)
{
    Player *player = (Player *)work->gameWork.parent;

    if (CheckPlayerGimmickObj(player, work) == FALSE)
    {
        work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
        playerPosZ   = FLOAT_TO_FX32(0.0);
        cannonPosZ   = FLOAT_TO_FX32(0.0);
        canDrawRings = FALSE;
    }
    else
    {
        work->gameWork.objWork.prevPosition = work->gameWork.objWork.position;

        switch (work->gameWork.objWork.userWork)
        {
            case CANNONPATH_MODE_MOVE_TO_PATH:
                work->gameWork.objWork.position.x += work->launchVelocity.x;
                work->gameWork.objWork.position.y += work->launchVelocity.y;
                work->gameWork.objWork.position.z += work->launchVelocity.z;

                if (work->gameWork.objWork.position.y < work->cannonPos.y - FLOAT_TO_FX32(96.0))
                    work->gameWork.objWork.userWork++;
                break;

            case CANNONPATH_MODE_READY_PATH_TRAVERSE:
                work->gameWork.objWork.position.x += work->launchVelocity.x;
                work->gameWork.objWork.position.y += work->launchVelocity.y;
                work->gameWork.objWork.position.z += work->launchVelocity.z;

                playerPosZ += FLOAT_TO_FX32(10.0);
                if (playerPosZ >= FLOAT_TO_FX32(35.0) - work->gameWork.objWork.position.z)
                    playerPosZ = FLOAT_TO_FX32(35.0) - work->gameWork.objWork.position.z;

                cannonPosZ = playerPosZ;

                if (work->gameWork.objWork.position.y < work->cannonPos.y - FLOAT_TO_FX32(192.0))
                {
                    work->gameWork.objWork.userWork++;

                    work->gameWork.objWork.position.y = work->cannonPos.y - FLOAT_TO_FX32(192.0);

                    playerPosZ = FLOAT_TO_FX32(35.0);
                    cannonPosZ = FLOAT_TO_FX32(500.0);

                    work->gameWork.objWork.position.z = FLOAT_TO_FX32(0.0);

                    canDrawRings                    = TRUE;
                    work->gameWork.objWork.userFlag = CANNONPATH_FLAG_NONE;

                    EffectCannonFireSpeedLines__Create(&work->gameWork.objWork);
                }
                break;

            case CANNONPATH_MODE_TRAVERSE_PATH:
                work->gameWork.objWork.position.x += FLOAT_TO_FX32(1.4222);

                work->pathRemaining -= FLOAT_TO_FX32(1.4222);
                if (work->pathRemaining <= work->pathFallDistance)
                    work->gameWork.objWork.position.y += work->fallVelocity;

                if (work->pathRemaining <= FLOAT_TO_FX32(0.0))
                {
                    work->gameWork.objWork.userWork++;

                    work->pathFinishTargetPos.x = work->gameWork.objWork.position.x + FLOAT_TO_FX32(128.0);
                    work->pathFinishTargetPos.y = work->gameWork.objWork.position.y + FLOAT_TO_FX32(121.0);

                    work->pathFinishStartPos = work->gameWork.objWork.position;

                    work->percent                     = FLOAT_TO_FX32(0.0);
                    work->gameWork.objWork.position.z = playerPosZ + FLOAT_TO_FX32(400.0);

                    playerPosZ   = -FLOAT_TO_FX32(400.0);
                    canDrawRings = FALSE;

                    work->gameWork.objWork.userFlag = CANNONPATH_FLAG_FINISHED_TRAVERSE;
                }
                break;

            case CANNONPATH_MODE_BEGIN_EXIT_PATH:
                work->gameWork.objWork.userWork++;
                break;

            case CANNONPATH_MODE_EXIT_PATH:
                work->percent += FLOAT_TO_FX32(1.0f / 60.0f);
                if (work->percent >= FLOAT_TO_FX32(1.0))
                    work->percent = FLOAT_TO_FX32(1.0);

                work->gameWork.objWork.position.x = mtLerpEx(work->percent, work->pathFinishStartPos.x, work->pathFinishTargetPos.x, 3);
                work->gameWork.objWork.position.y = mtLerpEx(work->percent, work->pathFinishStartPos.y, work->pathFinishTargetPos.y, 1);
                fx32 z                            = mtLerpEx2(work->percent, -FLOAT_TO_FX32(400.0), FLOAT_TO_FX32(0.0), 1);

                playerPosZ = z;
                cannonPosZ = z;

                if (work->percent >= FLOAT_TO_FX32(1.0))
                {
                    work->percent = FLOAT_TO_FX32(1.0);
                    Player__Action_ExitCannonPath(player, &work->gameWork);
                    work->gameWork.objWork.flag |= STAGE_TASK_FLAG_DESTROYED;
                }
                break;
        }
    }
}

void CannonRing_Destructor(Task *task)
{
    CannonRing *work = TaskGetWork(task, CannonRing);

    AnimatorSprite3D__Release(&work->aniRing);
    AnimatorSprite3D__Release(&work->aniButtonPrompt);

    ObjDataRelease(GetObjectFileWork(OBJDATAWORK_166));

    GameObject__Destructor(task);
}

NONMATCH_FUNC void CannonRing_Draw(void)
{
    // https://decomp.me/scratch/bv3Ua -> 98.78%
    // Issues with 'displayFlag' initalization
#ifdef NON_MATCHING
    MapSysCamera *camera = &mapCamera.camera[0];

    CannonRing *work = TaskGetWorkCurrent(CannonRing);

    StageDisplayFlags displayFlag = work->gameWork.objWork.displayFlag & ~DISPLAY_FLAG_DISABLE_LOOPING;

    if (canDrawRings == FALSE)
        return;

    if (work->gameWork.objWork.position.x >= camera->disp_pos.x && work->gameWork.objWork.position.x <= camera->disp_pos.x + FLOAT_TO_FX32(256.0))
    {
        fx32 screenX = work->gameWork.objWork.position.x - camera->disp_pos.x;

        VecFx32 position;
        position.x = camera->disp_pos.x + MultiplyFX(FLOAT_TO_FX32(1.0), screenX);
        position.y = camera->disp_pos.y + FLOAT_TO_FX32(241.0) + MultiplyFX(-FLOAT_TO_FX32(0.9375), screenX);
        position.z = playerPosZ + FLOAT_TO_FX32(600.0) + MultiplyFX(-FLOAT_TO_FX32(4.6875), screenX);

        StageTask__Draw3DEx(&work->aniRing.work, &position, NULL, NULL, &work->gameWork.objWork.displayFlag, NULL, NULL, NULL);

        if ((work->gameWork.objWork.userFlag & CANNONRING_FLAG_PROMPT_DISABLED) == 0)
            StageTask__Draw3DEx(&work->aniButtonPrompt.work, &position, NULL, NULL, &displayFlag, NULL, NULL, NULL);
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x20
	ldr r5, =mapCamera
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, =cannonPosZ
	ldr r2, [r4, #0x20]
	ldr r1, [r0, #8]
	bic r2, r2, #4
	str r2, [sp, #0x10]
	cmp r1, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r8, [r5, #4]
	ldr r3, [r4, #0x44]
	cmp r3, r8
	addlt sp, sp, #0x20
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r1, r8, #0x100000
	cmp r3, r1
	addgt sp, sp, #0x20
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov lr, #0x800
	mov r2, #0
	sub r7, r3, r8
	sub r9, lr, #0x1700
	sub ip, r2, #1
	umull r3, r1, r7, r9
	sub r10, lr, #0x5300
	adds lr, lr, r7, lsl #12
	ldr r5, [r5, #8]
	mla r1, r7, ip, r1
	mov r6, r7, asr #0x1f
	mov ip, r6, lsl #0xc
	mla r1, r6, r9, r1
	orr ip, ip, r7, lsr #20
	mov lr, lr, lsr #0xc
	adc r9, ip, #0
	orr lr, lr, r9, lsl #20
	add r8, r8, lr
	str r8, [sp, #0x14]
	adds r8, r3, #0x800
	adc r1, r1, #0
	mov r8, r8, lsr #0xc
	add r5, r5, #0xf1000
	orr r8, r8, r1, lsl #20
	add r8, r5, r8
	sub r3, r2, #1
	umull r5, r1, r7, r10
	mla r1, r7, r3, r1
	mla r1, r6, r10, r1
	str r8, [sp, #0x18]
	adds r3, r5, #0x800
	ldr r5, [r0, #4]
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	add r3, r5, #0x258000
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	str r0, [sp, #0x1c]
	add r0, r4, #0x20
	stmia sp, {r0, r2}
	str r2, [sp, #8]
	add r1, sp, #0x14
	mov r3, r2
	str r2, [sp, #0xc]
	add r0, r4, #0x364
	bl StageTask__Draw3DEx
	ldr r0, [r4, #0x24]
	tst r0, #2
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r2, #0
	add r0, sp, #0x10
	stmia sp, {r0, r2}
	add r0, r4, #0x68
	str r2, [sp, #8]
	add r1, sp, #0x14
	mov r3, r2
	add r0, r0, #0x400
	str r2, [sp, #0xc]
	bl StageTask__Draw3DEx
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

void CannonRing_OnDefend_RingTriggerStart(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    CannonRing *ring = (CannonRing *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (ring == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    Player__Action_AllowTrickCombos(player, &ring->gameWork);

    u32 type = ring->type;
    if ((ring->gameWork.mapObject->flags & CANNONRING_OBJFLAG_FORCE_COMBO_FINISH) != 0)
        type |= CANNONRING_TYPE_FORCE_COMBO_FINISH;
    Player__Action_EnterCannonRingTrigger(player, type);

    ring->gameWork.colliders[0].parent = NULL;
    ring->gameWork.colliders[0].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    ring->gameWork.objWork.userFlag |= CANNONRING_FLAG_PROMPT_ACTIVE;

    AnimatorSprite__SetAnimation(&ring->aniButtonPrompt.animatorSprite,
                                 (CANNONRING_ANI_PROMPT_ACTIVE_B - CANNONRING_ANI_PROMPT_IDLE_B) + ring->aniButtonPrompt.animatorSprite.animID);
}

void CannonRing_OnDefend_RingTriggerEnd(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    CannonRing *ring = (CannonRing *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (ring == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    Player__Action_ExitCannonRingTrigger(player, ring->type);

    ring->gameWork.colliders[1].parent = NULL;
    ring->gameWork.colliders[1].flag |= OBS_RECT_WORK_FLAG_NO_HIT_CHECKS;

    ring->gameWork.objWork.userFlag |= CANNONRING_FLAG_PROMPT_DISABLED;
}