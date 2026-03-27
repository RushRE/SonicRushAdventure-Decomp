#include <stage/objects/pipe.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/pipeFlowSeed.h>
#include <stage/effects/pipeFlowPetal.h>
#include <stage/effects/steam.h>

// --------------------
// MAPOBJECT PARAMS
// --------------------

#define mapObjectParam_exitStrength mapObject->left

// --------------------
// CONSTANTS/MACROS
// --------------------

#define STEAM_PIPE_COLLISION_RECT_INDEX_FOR_OBJECT(objID) (objID - MAPOBJECT_127)
#define GET_ORIENTATION_FROM_ANGLE(angleDegrees)          (FLOAT_DEG_TO_IDX(angleDegrees) >> 13)
#define FLOWER_PIPE_EXIT_PETAL_COUNT                      5
#define FLOWER_PIPE_EXIT_SEED_COUNT                       10

// --------------------
// STRUCTS
// --------------------

typedef struct SteamPipeCollisionRect_
{
    s16 width;
    s16 height;
    s16 offsetX;
    s16 offsetY;
} SteamPipeCollisionRect;

// --------------------
// VARIABLES
// --------------------

static const fx32 sPipePlayerEnterUserTimer[PIPE_TYPE_COUNT]    = { [PIPE_TYPE_FLOWER] = FLOAT_TO_FX32(0.0), [PIPE_TYPE_STEAM] = FLOAT_TO_FX32(0.0) };
static const fx32 sPipePlayerHitstopTimer[PIPE_TYPE_COUNT]      = { [PIPE_TYPE_FLOWER] = FLOAT_TO_FX32(16.0), [PIPE_TYPE_STEAM] = FLOAT_TO_FX32(32.0) };
static const fx32 sPipeMinimumVelocityOnExit[PIPE_TYPE_COUNT]   = { [PIPE_TYPE_FLOWER] = FLOAT_TO_FX32(10.0), [PIPE_TYPE_STEAM] = FLOAT_TO_FX32(10.0) };
static const fx32 sPipeStrengthUnitVelocity[PIPE_TYPE_COUNT]    = { [PIPE_TYPE_FLOWER] = FLOAT_TO_FX32(0.5), [PIPE_TYPE_STEAM] = FLOAT_TO_FX32(0.5) };
static const SteamPipeCollisionRect sSteamPipeCollisionRects[8] = {
    [STEAM_PIPE_COLLISION_RECT_INDEX_FOR_OBJECT(MAPOBJECT_127)] = { 24, 48, -24, -24 }, [STEAM_PIPE_COLLISION_RECT_INDEX_FOR_OBJECT(MAPOBJECT_128)] = { 48, 24, -24, 0 },
    [STEAM_PIPE_COLLISION_RECT_INDEX_FOR_OBJECT(MAPOBJECT_129)] = { 24, 48, -24, -24 }, [STEAM_PIPE_COLLISION_RECT_INDEX_FOR_OBJECT(MAPOBJECT_130)] = { 48, 24, -24, 0 },
    [STEAM_PIPE_COLLISION_RECT_INDEX_FOR_OBJECT(MAPOBJECT_131)] = { 40, 48, -24, -24 }, [STEAM_PIPE_COLLISION_RECT_INDEX_FOR_OBJECT(MAPOBJECT_132)] = { 48, 40, -24, -16 },
    [STEAM_PIPE_COLLISION_RECT_INDEX_FOR_OBJECT(MAPOBJECT_133)] = { 40, 48, -24, -24 }, [STEAM_PIPE_COLLISION_RECT_INDEX_FOR_OBJECT(MAPOBJECT_134)] = { 48, 40, -24, -16 },
};

static fx32 sFlowerPipe_UpwardsExit_PetalBaseXVelocity[FLOWER_PIPE_EXIT_PETAL_COUNT] = { FLOAT_TO_FX32(-3.0), FLOAT_TO_FX32(-2.5), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(2.5),
                                                                                         FLOAT_TO_FX32(3.0) };
static fx32 sFlowerPipe_UpwardsExit_PetalBaseYVelocity[FLOWER_PIPE_EXIT_PETAL_COUNT] = { FLOAT_TO_FX32(-5.5), FLOAT_TO_FX32(-6.0), FLOAT_TO_FX32(-6.5), FLOAT_TO_FX32(-6.0),
                                                                                         FLOAT_TO_FX32(-5.5) };
static fx32 sFlowerPipe_UpRightExit_PetalBaseXVelocity[FLOWER_PIPE_EXIT_PETAL_COUNT] = { FLOAT_TO_FX32(5.0), FLOAT_TO_FX32(5.5), FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(6.5),
                                                                                         FLOAT_TO_FX32(7.0) };
static fx32 sFlowerPipe_UpRightExit_PetalBaseYVelocity[FLOWER_PIPE_EXIT_PETAL_COUNT] = { FLOAT_TO_FX32(-6.0), FLOAT_TO_FX32(-7.0), FLOAT_TO_FX32(-6.0), FLOAT_TO_FX32(-7.0),
                                                                                         FLOAT_TO_FX32(-6.0) };

// --------------------
// FUNCTIONS
// --------------------

FlowerPipe *FlowerPipe__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    UNUSED(type);
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), FlowerPipe);
    if (task == HeapNull)
        return NULL;

    FlowerPipe *work = TaskGetWork(task, FlowerPipe);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_pipe_flw.bac", GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_0);

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;

    ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID].rect, -2, -2, 2, 2);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID], FlowerPipe__OnDefend_Exit_LaunchSeedsAndPetals);

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], FlowerPipe__OnDefend_Exit_FreezePlayerBeforeLaunch);

    u16 anim;
    s16 paletteSlot;
    switch (mapObject->id)
    {
        case MAPOBJECT_115: // entrance
        default:
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], FlowerPipe__OnDefend_Enter);

            work->gameWork.objWork.collisionObj           = NULL;
            work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width     = 16;
            work->gameWork.collisionObject.work.height    = 88;
            work->gameWork.collisionObject.work.ofst_x    = -16;
            work->gameWork.collisionObject.work.ofst_y    = -28;
            work->gameWork.objWork.userWork               = GET_ORIENTATION_FROM_ANGLE(180.0);

            anim        = 0;
            paletteSlot = 9;
            break;

        case MAPOBJECT_116: // upwards exit
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Pipe__OnDefend_Exit);

            work->gameWork.objWork.collisionObj                      = NULL;
            work->gameWork.collisionObject.work.parent               = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data            = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width                = 56;
            work->gameWork.collisionObject.work.height               = 24;
            work->gameWork.collisionObject.work.ofst_x               = -28;
            work->gameWork.collisionObject.work.ofst_y               = 0;
            work->gameWork.objWork.userWork                          = GET_ORIENTATION_FROM_ANGLE(270.0);
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;

            anim        = 1;
            paletteSlot = 10;

            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -2, 14, 2, 18);

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID].parent = &work->gameWork.objWork;
            break;

        case MAPOBJECT_117: // up-right exit
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Pipe__OnDefend_Exit);

            work->gameWork.objWork.collisionObj           = NULL;
            work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width     = 16;
            work->gameWork.collisionObject.work.height    = 88;
            work->gameWork.collisionObject.work.ofst_x    = -32;
            work->gameWork.collisionObject.work.ofst_y    = -44;

            work->gameWork.objWork.userWork                          = GET_ORIENTATION_FROM_ANGLE(315.0);
            work->gameWork.objWork.dir.z                             = FLOAT_DEG_TO_IDX(90.0);
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;

            anim        = 2;
            paletteSlot = 10;

            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -18, 14, -14, 18);

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID].parent = &work->gameWork.objWork;
            break;
    }

    work->gameWork.objWork.userFlag = PIPE_TYPE_FLOWER;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    ObjActionAllocSpritePalette(&work->gameWork.objWork, anim, paletteSlot);
    StageTask__SetAnimation(&work->gameWork.objWork, anim);

    SetTaskState(&work->gameWork.objWork, Pipe__State_PlayerNotEntered);

    return work;
}

SteamPipe *SteamPipe__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
    UNUSED(type);
    Task *task = CreateStageTask(GameObject__Destructor, TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1800, TASK_GROUP(2), SteamPipe);
    if (task == HeapNull)
        return NULL;

    SteamPipe *work = TaskGetWork(task, SteamPipe);
    TaskInitWork8(work);
    GameObject__InitFromObject(&work->gameWork, mapObject, x, y);

    ObjObjectAction2dBACLoad(&work->gameWork.objWork, &work->gameWork.animator, "/act/ac_gmk_pipe_steam.bac", GetObjectFileWork(OBJDATAWORK_159), gameArchiveStage,
                             OBJ_DATA_GFX_AUTO);
    StageTask__SetAnimatorOAMOrder(&work->gameWork.objWork, SPRITE_ORDER_23);
    StageTask__SetAnimatorPriority(&work->gameWork.objWork, SPRITE_PRIORITY_0);
    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    work->gameWork.objWork.userFlag = PIPE_TYPE_STEAM;
    const u16 *id                   = &mapObject->id;

    u16 anim;
    if (*id >= MAPOBJECT_127 && *id <= MAPOBJECT_130)
    {
        ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], SteamPipe__OnDefend_Enter);

        work->gameWork.objWork.userWork = 2 * (mapObject->id - MAPOBJECT_127);
        switch (mapObject->id)
        {
            case MAPOBJECT_127: // leftwards entrance
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                // fallthrough

            case MAPOBJECT_129: // rightwards entrance
                anim = 0;
                break;

            case MAPOBJECT_130: // downwards entrance
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                // fallthrough

            case MAPOBJECT_128: // upwards entrance
                anim = 1;
                break;
        }

        SetTaskState(&work->gameWork.objWork, Pipe__State_PlayerNotEntered);
    }
    else
    {
        if (mapObject->id >= MAPOBJECT_131 && mapObject->id <= MAPOBJECT_134)
        {
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], Pipe__OnDefend_Exit);

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -2, -2, 2, 2);
            ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
            ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], SteamPipe__OnDefend_Exit_FreezePlayerAndOpenDoor);
            work->gameWork.objWork.userWork = 2 * (mapObject->id - MAPOBJECT_131);

            switch (mapObject->id)
            {
                case MAPOBJECT_131: // rightwards exit
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                    // fallthrough

                case MAPOBJECT_133: // leftwards exit
                    anim = 2;
                    break;

                case MAPOBJECT_134: // upwards exit
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                    // fallthrough

                case MAPOBJECT_132: // downwards exit
                    anim = 3;
                    break;
            }
        }
    }

    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;

    const SteamPipeCollisionRect *config       = &sSteamPipeCollisionRects[STEAM_PIPE_COLLISION_RECT_INDEX_FOR_OBJECT(mapObject->id)];
    work->gameWork.collisionObject.work.width  = config->width;
    work->gameWork.collisionObject.work.height = config->height;
    work->gameWork.collisionObject.work.ofst_x = config->offsetX;
    work->gameWork.collisionObject.work.ofst_y = config->offsetY;

    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;

    ObjActionAllocSpritePalette(&work->gameWork.objWork, 0, 32);
    StageTask__SetAnimation(&work->gameWork.objWork, anim);

    return work;
}

void Pipe__State_PlayerNotEntered(SteamPipe *work)
{
    if (work->gameWork.objWork.userTimer != 0)
    {
        work->gameWork.objWork.userTimer--;
        if (work->gameWork.objWork.userTimer == 0)
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    }
}

void FlowerPipe__OnDefend_Enter(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FlowerPipe *pipe = (FlowerPipe *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (pipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    fx32 angle = pipe->gameWork.objWork.userWork * FLOAT_DEG_TO_IDX(45.0);

    pipe->gameWork.objWork.userTimer = 96;
    pipe->gameWork.objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    Player__Action_PipeEnter(player, &pipe->gameWork, angle + FLOAT_DEG_TO_IDX(180.0), sPipePlayerEnterUserTimer[pipe->gameWork.objWork.userFlag]);
}

void Pipe__OnDefend_Exit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Pipe *pipe     = (Pipe *)rect2->parent;
    Player *player = (Player *)rect1->parent;
    if ((pipe == NULL) || (player == NULL))
        return;
    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;
    if (CheckPlayerGimmickObj(player, pipe))
        return;
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS) == 0)
        return;

    BOOL allowTricks     = FALSE;
    u32 pipeType         = pipe->gameWork.objWork.userFlag;
    u32 type             = 0;
    fx32 velocity        = sPipeMinimumVelocityOnExit[pipeType];
    MapObject *mapObject = pipe->gameWork.mapObject;
    if (mapObjectParam_exitStrength > 0)
        velocity = mapObjectParam_exitStrength * sPipeStrengthUnitVelocity[pipeType] + velocity;
    if (pipeType <= (PIPE_TYPE_COUNT - 1))
        allowTricks = TRUE;
    if (pipeType == PIPE_TYPE_FLOWER)
        type = PIPE_TYPE_FLOWER;
    else if (pipeType == PIPE_TYPE_STEAM)
        type = PIPE_TYPE_STEAM;
    Player__Action_PipeExit(player, velocity, allowTricks, type);
    Player__Action_AllowTrickCombos(player, &pipe->gameWork);
}

void FlowerPipe__OnDefend_Exit_FreezePlayerBeforeLaunch(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FlowerPipe *pipe = (FlowerPipe *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if ((pipe == NULL) || (player == NULL))
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    player->objWork.hitstopTimer = sPipePlayerHitstopTimer[pipe->gameWork.objWork.userFlag];
}

void FlowerPipe__OnDefend_Exit_LaunchSeedsAndPetals(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FlowerPipe *pipe = (FlowerPipe *)rect2->parent;
    Player *player   = (Player *)rect1->parent;
    if ((pipe == NULL) || (player == NULL))
        return;
    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;
    if (CheckPlayerGimmickObj(player, pipe))
        return;
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS) == 0)
        return;

    s32 i;
    u16 type              = 0;
    fx32 coordinateOffset = FX32_FROM_WHOLE(-4);
    fx32 objectPosX       = pipe->gameWork.objWork.position.x;
    fx32 objectPosY       = pipe->gameWork.objWork.position.y;
    if (pipe->gameWork.objWork.userWork == GET_ORIENTATION_FROM_ANGLE(270.0))
    {
        // For MAPOBJECT_116, upwards exit
        const fx32 *petalBaseXVelocity = sFlowerPipe_UpwardsExit_PetalBaseXVelocity;
        const fx32 *petalBaseYVelocity = sFlowerPipe_UpwardsExit_PetalBaseYVelocity;
        for (i = 0; i < FLOWER_PIPE_EXIT_PETAL_COUNT; i++, coordinateOffset += FX32_FROM_WHOLE(2),
            type ^= 1 // Alternate between ac_gmk_pipe_flw.bac's animations 3 and 4
        )
        {
            u32 randY = mtMathRandRange2(-1, 3); // Range ultimately reduced to [-0.5; 1.5], a multiple of 0.5 is drawn
            u32 randX = mtMathRandRange2(-1, 3); // Range ultimately reduced to [-0.25; 0.75], a multiple of 0.25 is drawn
            fx32 velX = *(petalBaseXVelocity++) + (randX << (FX32_SHIFT - 2));
            fx32 velY = *(petalBaseYVelocity++) + (randY << (FX32_SHIFT - 1));
            EffectFlowerPipePetal__Create(objectPosX + coordinateOffset, objectPosY, velX, velY, type);
        }
        for (i = 0, coordinateOffset = FLOAT_TO_FX32(-2.25); i < FLOWER_PIPE_EXIT_SEED_COUNT; i++)
        {
            u32 randY = mtMathRand();
            u32 randX = mtMathRandRange2(-3, 5);
            fx32 velX = FX32_FROM_WHOLE(randX);
            fx32 velY = FX32_FROM_WHOLE(-4) - ((FX32_FROM_WHOLE(randY) << 17) >> 18); // The random range is reduced to [-2; 1.5], a multiple of 0.5 is drawn
            EffectFlowerPipeSeed__Create(objectPosX + coordinateOffset, objectPosY, velX, velY, type);
            // In fine, alternate between ac_gmk_pipe_flw.bac's animations 5, 6 and 7
            type++;
            if (type >= 3)
                type = 0;
            coordinateOffset += FLOAT_TO_FX32(0.5);
        }
    }
    else
    {
        // MAPOBJECT_117, an exit shooting the player to the up-right.
        const fx32 *petalBaseXVelocity = sFlowerPipe_UpRightExit_PetalBaseXVelocity;
        const fx32 *petalBaseYVelocity = sFlowerPipe_UpRightExit_PetalBaseYVelocity;
        for (i = 0; i < FLOWER_PIPE_EXIT_PETAL_COUNT; i++, coordinateOffset += FX32_FROM_WHOLE(2), type ^= 1)
        {
            u32 randY = mtMathRandRange2(-1, 3);
            u32 randX = mtMathRandRange2(-1, 3);
            fx32 velX = *(petalBaseXVelocity++) + (randX << (FX32_SHIFT - 2));
            fx32 velY = *(petalBaseYVelocity++) + (randY << (FX32_SHIFT - 1));
            EffectFlowerPipePetal__Create(objectPosX, objectPosY + coordinateOffset, velX, velY, type);
        }
        for (i = 0, coordinateOffset = FLOAT_TO_FX32(-2.25); i < FLOWER_PIPE_EXIT_SEED_COUNT; i++)
        {
            u32 randY = mtMathRand();
            u32 randX = mtMathRandRange2(-3, 5);
            fx32 velX = (randX << (FX32_SHIFT - 1)) + FX32_FROM_WHOLE(3);
            fx32 velY = FX32_FROM_WHOLE(-3) - ((FX32_FROM_WHOLE(randY) << 17) >> 18);
            EffectFlowerPipeSeed__Create(objectPosX + coordinateOffset, objectPosY, velX, velY, type);
            type++;
            if (type >= 3)
                type = 0;
            coordinateOffset += FLOAT_TO_FX32(0.5);
        }
    }
}

void SteamPipe__State_WaitToCloseEntrance(SteamPipe *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer <= 0)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID == 0)
            // horizontal entrances
            StageTask__SetAnimation(&work->gameWork.objWork, 4);
        else
            // vertical entrances
            StageTask__SetAnimation(&work->gameWork.objWork, 7);

        SetTaskState(&work->gameWork.objWork, NULL);
    }
}

void SteamPipe__State_Exit_WaitToShowSteamAndDust(SteamPipe *work)
{
    work->gameWork.objWork.userTimer = StageTask__DecrementBySpeed(work->gameWork.objWork.userTimer);

    if (work->gameWork.objWork.userTimer <= 0)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID == 5)
            // horizontal steam
            StageTask__SetAnimation(&work->gameWork.objWork, 6);
        else
            // vertical steam
            StageTask__SetAnimation(&work->gameWork.objWork, 9);
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_LOOPING;

        ObjDrawReleaseSprite(32);
        ObjActionAllocSpritePalette(&work->gameWork.objWork, 6, 34);

        SetTaskState(&work->gameWork.objWork, SteamPipe__State_Exit_PlayerLaunchedOut);

        fx32 dustX = work->gameWork.objWork.position.x;
        fx32 dustY = work->gameWork.objWork.position.y;

        fx32 dustVelX;
        fx32 dustVelY;

        switch (work->gameWork.mapObject->id)
        {
            case MAPOBJECT_131: // rightwards exit
            default:
                dustVelX = FLOAT_TO_FX32(4.0);
                dustVelY = -FLOAT_TO_FX32(4.0);

                dustX += FLOAT_TO_FX32(16.0);
                break;

            case MAPOBJECT_132: // downwards exit
                dustVelX = FLOAT_TO_FX32(0.0);
                dustVelY = FLOAT_TO_FX32(4.0);

                dustY += FLOAT_TO_FX32(16.0);
                break;

            case MAPOBJECT_133: // leftwards exit
                dustVelX = -FLOAT_TO_FX32(4.0);
                dustVelY = -FLOAT_TO_FX32(4.0);

                dustX -= FLOAT_TO_FX32(16.0);
                break;

            case MAPOBJECT_134: // upwards exit
                dustVelX = FLOAT_TO_FX32(0.0);
                dustVelY = -FLOAT_TO_FX32(4.0);

                dustY -= FLOAT_TO_FX32(16.0);
                break;
        }

        EffectSteamDust__Create(EFFECTSTEAM_TYPE_LARGE, dustX, dustY, dustVelX + FLOAT_TO_FX32(0.0), dustVelY - FLOAT_TO_FX32(1.0));
        EffectSteamDust__Create(EFFECTSTEAM_TYPE_LARGE, dustX, dustY, dustVelX + FLOAT_TO_FX32(1.5), dustVelY + FLOAT_TO_FX32(2.0));
        EffectSteamDust__Create(EFFECTSTEAM_TYPE_SMALL, dustX, dustY, dustVelX + FLOAT_TO_FX32(2.5), dustVelY + FLOAT_TO_FX32(0.0));
        EffectSteamDust__Create(EFFECTSTEAM_TYPE_LARGE, dustX, dustY, dustVelX - FLOAT_TO_FX32(1.5), dustVelY + FLOAT_TO_FX32(1.0));
        EffectSteamDust__Create(EFFECTSTEAM_TYPE_SMALL, dustX, dustY, dustVelX - FLOAT_TO_FX32(2.5), dustVelY - FLOAT_TO_FX32(2.0));
    }
}

void SteamPipe__State_Exit_PlayerLaunchedOut(SteamPipe *work)
{
    if ((work->gameWork.objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
    {
        SetTaskState(&work->gameWork.objWork, NULL);

        work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

        switch (work->gameWork.mapObject->id)
        {
            case MAPOBJECT_127:
            case MAPOBJECT_128:
            case MAPOBJECT_129:
            case MAPOBJECT_130:
                // entrances
                break;

            case MAPOBJECT_131:
            case MAPOBJECT_133:
                // horizontal exits
                work->gameWork.collisionObject.work.ofst_x += 7;
                break;

            case MAPOBJECT_132:
            case MAPOBJECT_134:
                // vertical exits
                work->gameWork.collisionObject.work.ofst_y -= 7;
                break;
        }
    }
}

void SteamPipe__OnDefend_Enter(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SteamPipe *pipe = (SteamPipe *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (pipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    FlowerPipe__OnDefend_Enter(rect1, rect2);
    pipe->gameWork.objWork.userTimer = 8; // frame count until the entrance door is shut

    SetTaskState(&pipe->gameWork.objWork, SteamPipe__State_WaitToCloseEntrance);
}

void SteamPipe__OnDefend_Exit_FreezePlayerAndOpenDoor(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SteamPipe *pipe = (SteamPipe *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (pipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    player->objWork.hitstopTimer = sPipePlayerHitstopTimer[pipe->gameWork.objWork.userFlag];

    if (pipe->gameWork.objWork.obj_2d->ani.work.animID == 2)
        StageTask__SetAnimation(&pipe->gameWork.objWork, 5); // horizontal door
    else
        StageTask__SetAnimation(&pipe->gameWork.objWork, 8); // vertical door

    pipe->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    pipe->gameWork.objWork.userTimer = player->objWork.hitstopTimer;

    SetTaskState(&pipe->gameWork.objWork, SteamPipe__State_Exit_WaitToShowSteamAndDust);
}
