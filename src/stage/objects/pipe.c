#include <stage/objects/pipe.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/pipeFlowSeed.h>
#include <stage/effects/pipeFlowPetal.h>
#include <stage/effects/steam.h>

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

static const fx32 FlowerPipe__dword_21883A0[2]                = { FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0) };
static const fx32 FlowerPipe__dword_21883A8[2]                = { FLOAT_TO_FX32(16.0), FLOAT_TO_FX32(32.0) };
static const fx32 SteamPipe__dword_2188390[2]                 = { FLOAT_TO_FX32(10.0), FLOAT_TO_FX32(10.0) };
static const fx32 SteamPipe__dword_2188398[2]                 = { FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(0.5) };
static const SteamPipeCollisionRect SteamPipe__stru_21883B0[] = {
    { 24, 48, -24, -24 }, { 48, 24, -24, 0 }, { 24, 48, -24, -24 }, { 48, 24, -24, 0 }, { 40, 48, -24, -24 }, { 48, 40, -24, -16 }, { 40, 48, -24, -24 }, { 48, 40, -24, -16 },
};

fx32 FlowerPipe__dword_2188F54[] = { FLOAT_TO_FX32(-3.0), FLOAT_TO_FX32(-2.5), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(2.5), FLOAT_TO_FX32(3.0) };
fx32 FlowerPipe__dword_2188F2C[] = { FLOAT_TO_FX32(-5.5), FLOAT_TO_FX32(-6.0), FLOAT_TO_FX32(-6.5), FLOAT_TO_FX32(-6.0), FLOAT_TO_FX32(-5.5) };
fx32 FlowerPipe__dword_2188F40[] = { FLOAT_TO_FX32(5.0), FLOAT_TO_FX32(5.5), FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(6.5), FLOAT_TO_FX32(7.0) };
fx32 FlowerPipe__dword_2188F68[] = { FLOAT_TO_FX32(-6.0), FLOAT_TO_FX32(-7.0), FLOAT_TO_FX32(-6.0), FLOAT_TO_FX32(-7.0), FLOAT_TO_FX32(-6.0) };

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
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID], FlowerPipe__OnDefend_216188C);

    ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
    ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
    work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
    ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], FlowerPipe__OnDefend_2161854);

    u16 anim;
    s16 paletteSlot;
    switch (mapObject->id)
    {
        case MAPOBJECT_115:
        default:
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], FlowerPipe__OnDefend_216174C);

            work->gameWork.objWork.collisionObj           = NULL;
            work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width     = 16;
            work->gameWork.collisionObject.work.height    = 88;
            work->gameWork.collisionObject.work.ofst_x    = -16;
            work->gameWork.collisionObject.work.ofst_y    = -28;
            work->gameWork.objWork.userWork               = 4;

            anim        = 0;
            paletteSlot = 9;
            break;

        case MAPOBJECT_116:
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], SteamPipe__OnDefend_21617B0);

            work->gameWork.objWork.collisionObj                      = NULL;
            work->gameWork.collisionObject.work.parent               = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data            = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width                = 56;
            work->gameWork.collisionObject.work.height               = 24;
            work->gameWork.collisionObject.work.ofst_x               = -28;
            work->gameWork.collisionObject.work.ofst_y               = 0;
            work->gameWork.objWork.userWork                          = 6;
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;

            anim        = 1;
            paletteSlot = 10;

            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -2, 14, 2, 18);

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID].parent = &work->gameWork.objWork;
            break;

        case MAPOBJECT_117:
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], SteamPipe__OnDefend_21617B0);

            work->gameWork.objWork.collisionObj           = NULL;
            work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
            work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;
            work->gameWork.collisionObject.work.width     = 16;
            work->gameWork.collisionObject.work.height    = 88;
            work->gameWork.collisionObject.work.ofst_x    = -32;
            work->gameWork.collisionObject.work.ofst_y    = -44;

            work->gameWork.objWork.userWork                          = 7;
            work->gameWork.objWork.dir.z                             = FLOAT_DEG_TO_IDX(90.0);
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;

            anim        = 2;
            paletteSlot = 10;

            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -18, 14, -14, 18);

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_SOLID].parent = &work->gameWork.objWork;
            break;
    }

    work->gameWork.objWork.userFlag = 0;
    work->gameWork.objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    ObjActionAllocSpritePalette(&work->gameWork.objWork, anim, paletteSlot);
    StageTask__SetAnimation(&work->gameWork.objWork, anim);

    SetTaskState(&work->gameWork.objWork, SteamPipe__State_2161728);

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
    work->gameWork.objWork.userFlag = 1;
    u16 const *id                   = &mapObject->id;

    u16 anim;
    if (*id >= MAPOBJECT_127 && *id <= MAPOBJECT_130)
    {
        ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], SteamPipe__OnDefend_2161DA0);

        work->gameWork.objWork.userWork = 2 * (mapObject->id - MAPOBJECT_127);
        switch (mapObject->id)
        {
            case MAPOBJECT_127:
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                // fallthrough

            case MAPOBJECT_129:
                anim = 0;
                break;

            case MAPOBJECT_130:
                work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                // fallthrough

            case MAPOBJECT_128:
                anim = 1;
                break;
        }

        SetTaskState(&work->gameWork.objWork, SteamPipe__State_2161728);
    }
    else
    {
        if (mapObject->id >= MAPOBJECT_131 && mapObject->id <= MAPOBJECT_134)
        {
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_WEAK], SteamPipe__OnDefend_21617B0);

            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].parent = &work->gameWork.objWork;
            ObjRect__SetBox2D(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].rect, -2, -2, 2, 2);
            ObjRect__SetAttackStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_WORK_ATTR_NONE, OBS_RECT_HITPOWER_VULNERABLE);
            ObjRect__SetDefenceStat(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], OBS_RECT_ATTR_NO_HIT(OBS_RECT_WORK_ATTR_BODY), OBS_RECT_DEFPOWER_VULNERABLE);
            work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK].flag |= OBS_RECT_WORK_FLAG_USE_ONENTER_BEHAVIOR;
            ObjRect__SetOnDefend(&work->gameWork.colliders[GAMEOBJECT_COLLIDER_ATK], SteamPipe__OnDefend_2161DE0);
            work->gameWork.objWork.userWork = 2 * (mapObject->id - MAPOBJECT_131);

            switch (mapObject->id)
            {
                case MAPOBJECT_131:
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                    // fallthrough

                case MAPOBJECT_133:
                    anim = 2;
                    break;

                case MAPOBJECT_134:
                    work->gameWork.objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;
                    // fallthrough

                case MAPOBJECT_132:
                    anim = 3;
                    break;
            }
        }
    }

    work->gameWork.objWork.collisionObj           = NULL;
    work->gameWork.collisionObject.work.parent    = &work->gameWork.objWork;
    work->gameWork.collisionObject.work.diff_data = StageTask__DefaultDiffData;

    const SteamPipeCollisionRect *config       = &SteamPipe__stru_21883B0[mapObject->id - MAPOBJECT_127];
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

void SteamPipe__State_2161728(SteamPipe *work)
{
    if (work->gameWork.objWork.userTimer != 0)
    {
        work->gameWork.objWork.userTimer--;
        if (work->gameWork.objWork.userTimer == 0)
            work->gameWork.objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    }
}

void FlowerPipe__OnDefend_216174C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
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
    Player__Action_PipeEnter(player, &pipe->gameWork, angle + FLOAT_DEG_TO_IDX(180.0), FlowerPipe__dword_21883A0[pipe->gameWork.objWork.userFlag]);
}

void SteamPipe__OnDefend_21617B0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SteamPipe *pipe = (SteamPipe *)rect2->parent;
    Player *player  = (Player *)rect1->parent;
    if ((pipe == NULL) || (player == NULL))
        return;
    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;
    if (CheckPlayerGimmickObj(player, pipe))
        return;
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS) == 0)
        return;

    BOOL allowTricks = FALSE;
    u32 userFlag     = pipe->gameWork.objWork.userFlag;
    u32 type         = 0;
    fx32 velocity    = SteamPipe__dword_2188390[userFlag];
    if (pipe->gameWork.mapObject->left > 0)
        velocity = pipe->gameWork.mapObject->left * SteamPipe__dword_2188398[userFlag] + velocity;
    if (userFlag <= 1)
        allowTricks = TRUE;
    if (userFlag == 0)
        type = 0;
    else if (userFlag == 1)
        type = 1;
    Player__Action_PipeExit(player, velocity, allowTricks, type);
    Player__Action_AllowTrickCombos(player, &pipe->gameWork);
}

void FlowerPipe__OnDefend_2161854(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    FlowerPipe *pipe = (FlowerPipe *)rect2->parent;
    Player *player   = (Player *)rect1->parent;

    if (pipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    player->objWork.hitstopTimer = FlowerPipe__dword_21883A8[pipe->gameWork.objWork.userFlag];
}

void FlowerPipe__OnDefend_216188C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
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
    fx32 posX             = pipe->gameWork.objWork.position.x;
    fx32 posY             = pipe->gameWork.objWork.position.y;
    if (pipe->gameWork.objWork.userWork == 6)
    {
        // For MAPOBJECT_116, upwards exit
        const fx32 *petalBaseXVelocity = FlowerPipe__dword_2188F54;
        const fx32 *petalBaseYVelocity = FlowerPipe__dword_2188F2C;
        for (i = 0; i < 5; i++, coordinateOffset += FX32_FROM_WHOLE(2),
            type ^= 1 // Alternate between ac_gmk_pipe_flw.bac's animations 3 and 4
        )
        {
            u32 randY = mtMathRandRange2(-1, 3); // Range ultimately reduced to [-0.5; 1.5], a multiple of 0.5 is drawn
            u32 randX = mtMathRandRange2(-1, 3); // Range ultimately reduced to [-0.25; 0.75], a multiple of 0.25 is drawn
            fx32 velX = *(petalBaseXVelocity++) + (randX << (FX32_SHIFT - 2));
            fx32 velY = *(petalBaseYVelocity++) + (randY << (FX32_SHIFT - 1));
            EffectFlowerPipePetal__Create(posX + coordinateOffset, posY, velX, velY, type);
        }
        for (i = 0, coordinateOffset = FLOAT_TO_FX32(-2.25); i < 10; i++)
        {
            u32 randY = mtMathRand();
            u32 randX = mtMathRandRange2(-3, 5);
            fx32 velX = FX32_FROM_WHOLE(randX);
            fx32 velY = FX32_FROM_WHOLE(-4) - ((FX32_FROM_WHOLE(randY) << 17) >> 18); // The random range is reduced to [-2; 1.5], a multiple of 0.5 is drawn
            EffectFlowerPipeSeed__Create(posX + coordinateOffset, posY, velX, velY, type);
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
        const fx32 *petalBaseXVelocity = FlowerPipe__dword_2188F40;
        const fx32 *petalBaseYVelocity = FlowerPipe__dword_2188F68;
        for (i = 0; i < 5; i++, coordinateOffset += FX32_FROM_WHOLE(2), type ^= 1)
        {
            u32 randY = mtMathRandRange2(-1, 3);
            u32 randX = mtMathRandRange2(-1, 3);
            fx32 velX = *(petalBaseXVelocity++) + (randX << (FX32_SHIFT - 2));
            fx32 velY = *(petalBaseYVelocity++) + (randY << (FX32_SHIFT - 1));
            EffectFlowerPipePetal__Create(posX, posY + coordinateOffset, velX, velY, type);
        }
        for (i = 0, coordinateOffset = FLOAT_TO_FX32(-2.25); i < 10; i++)
        {
            u32 randY = mtMathRand();
            u32 randX = mtMathRandRange2(-3, 5);
            fx32 velX = (randX << (FX32_SHIFT - 1)) + FX32_FROM_WHOLE(3);
            fx32 velY = FX32_FROM_WHOLE(-3) - ((FX32_FROM_WHOLE(randY) << 17) >> 18);
            EffectFlowerPipeSeed__Create(posX + coordinateOffset, posY, velX, velY, type);
            type++;
            if (type >= 3)
                type = 0;
            coordinateOffset += FLOAT_TO_FX32(0.5);
        }
    }
}

void SteamPipe__State_2161B64(SteamPipe *work)
{
    work->gameWork.objWork.userTimer--;
    if (work->gameWork.objWork.userTimer <= 0)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID == 0)
            StageTask__SetAnimation(&work->gameWork.objWork, 4);
        else
            StageTask__SetAnimation(&work->gameWork.objWork, 7);

        SetTaskState(&work->gameWork.objWork, NULL);
    }
}

void SteamPipe__State_2161BB0(SteamPipe *work)
{
    work->gameWork.objWork.userTimer = StageTask__DecrementBySpeed(work->gameWork.objWork.userTimer);

    if (work->gameWork.objWork.userTimer <= 0)
    {
        if (work->gameWork.objWork.obj_2d->ani.work.animID == 5)
            StageTask__SetAnimation(&work->gameWork.objWork, 6);
        else
            StageTask__SetAnimation(&work->gameWork.objWork, 9);
        work->gameWork.objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_LOOPING;

        ObjDrawReleaseSprite(32);
        ObjActionAllocSpritePalette(&work->gameWork.objWork, 6, 34);

        SetTaskState(&work->gameWork.objWork, SteamPipe__State_2161D20);

        fx32 dustX = work->gameWork.objWork.position.x;
        fx32 dustY = work->gameWork.objWork.position.y;

        fx32 dustVelX;
        fx32 dustVelY;

        switch (work->gameWork.mapObject->id)
        {
            case MAPOBJECT_131:
            default:
                dustVelX = FLOAT_TO_FX32(4.0);
                dustVelY = -FLOAT_TO_FX32(4.0);

                dustX += FLOAT_TO_FX32(16.0);
                break;

            case MAPOBJECT_132:
                dustVelX = FLOAT_TO_FX32(0.0);
                dustVelY = FLOAT_TO_FX32(4.0);

                dustY += FLOAT_TO_FX32(16.0);
                break;

            case MAPOBJECT_133:
                dustVelX = -FLOAT_TO_FX32(4.0);
                dustVelY = -FLOAT_TO_FX32(4.0);

                dustX -= FLOAT_TO_FX32(16.0);
                break;

            case MAPOBJECT_134:
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

void SteamPipe__State_2161D20(SteamPipe *work)
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
                break;

            case MAPOBJECT_131:
            case MAPOBJECT_133:
                work->gameWork.collisionObject.work.ofst_x += 7;
                break;

            case MAPOBJECT_132:
            case MAPOBJECT_134:
                work->gameWork.collisionObject.work.ofst_y -= 7;
                break;
        }
    }
}

void SteamPipe__OnDefend_2161DA0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SteamPipe *pipe = (SteamPipe *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (pipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    FlowerPipe__OnDefend_216174C(rect1, rect2);
    pipe->gameWork.objWork.userTimer = 8;

    SetTaskState(&pipe->gameWork.objWork, SteamPipe__State_2161B64);
}

void SteamPipe__OnDefend_2161DE0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SteamPipe *pipe = (SteamPipe *)rect2->parent;
    Player *player  = (Player *)rect1->parent;

    if (pipe == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    player->objWork.hitstopTimer = FlowerPipe__dword_21883A8[pipe->gameWork.objWork.userFlag];

    if (pipe->gameWork.objWork.obj_2d->ani.work.animID == 2)
        StageTask__SetAnimation(&pipe->gameWork.objWork, 5);
    else
        StageTask__SetAnimation(&pipe->gameWork.objWork, 8);

    pipe->gameWork.objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    pipe->gameWork.objWork.userTimer = player->objWork.hitstopTimer;

    SetTaskState(&pipe->gameWork.objWork, SteamPipe__State_2161BB0);
}
