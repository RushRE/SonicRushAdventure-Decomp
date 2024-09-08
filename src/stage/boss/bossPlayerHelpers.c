#include <stage/boss/bossPlayerHelpers.h>
#include <stage/gameObject.h>
#include <game/graphics/screenShake.h>
#include <game/object/obj.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void Boss3__SetInkSplatFlag(void);
NOT_DECOMPILED fx32 Boss6Stage__GetScrollSpeed(void);

// --------------------
// FUNCTIONS
// --------------------

void BossPlayerHelpers_Action_Boss1ChargeKnockback(Player *player, fx32 velX, fx32 velY)
{
    if (player->trickFinishHorizFreezeTimer == 0 && player->objWork.hitstopTimer == 0)
    {
        fx32 groundVel;
        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) != 0)
            groundVel = player->objWork.velocity.x;
        else
            groundVel = player->objWork.groundVel;

        if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0 && player->rings == 0)
        {
            Player__Action_Die(player);
        }
        else
        {
            u32 gimmickFlag = player->gimmickFlag;
            Player__InitState(player);
            player->gimmickFlag |= gimmickFlag & PLAYER_GIMMICK_40000;

            ShakeScreen(SCREENSHAKE_C_SHORT);

            player->blinkTimer            = player->hurtInvulnDuration;
            player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;

            if (MATH_ABS(groundVel) >= player->spdThresholdRun)
                Player__ChangeAction(player, PLAYER_ACTION_HURT_TUMBLE);
            else
                Player__ChangeAction(player, PLAYER_ACTION_HURT_KNOCKBACK);

            if (MATH_ABS(groundVel) < FLOAT_TO_FX32(1.5))
                groundVel = 0;

            player->objWork.velocity.x = FLOAT_TO_FX32(1.5);
            player->objWork.velocity.y = -FLOAT_TO_FX32(3.0);
            player->objWork.groundVel  = FLOAT_TO_FX32(0.0);

            if (player->actionState == PLAYER_ACTION_HURT_TUMBLE)
            {
                player->objWork.velocity.x = groundVel >> 1;
            }
            else if (groundVel > FLOAT_TO_FX32(0.0))
            {
                player->objWork.velocity.x = -player->objWork.velocity.x;
            }
            else if (groundVel == FLOAT_TO_FX32(0.0))
            {
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                    player->objWork.velocity.x = -player->objWork.velocity.x;
            }

            player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
            player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
            player->objWork.velocity.x = velX;
            player->objWork.velocity.y = velY;

            SetTaskState(&player->objWork, BossPlayerHelpers_State_Boss1ChargeKnockback);
        }
    }
}

void BossPlayerHelpers_Action_SetBoss3DefendEvent(Player *player)
{
    ObjRect__SetOnDefend(&player->colliders[0], BossPlayerHelpers_OnDefend_Boss3);
}

void BossPlayerHelpers_Action_Boss3ArmKnockback(Player *player, fx32 velX, fx32 velY)
{
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;

    Player__Action_AttackRecoil(player);
    player->objWork.velocity.x = velX;
    player->objWork.velocity.y = velY;

    Player__ChangeAction(player, PLAYER_ACTION_HURT_KNOCKBACK);
}

void BossPlayerHelpers_Action_TryBoss5Warp(Player *player, fx32 x, fx32 y)
{
    if ((player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
    {
        player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
        player->warpDestPos.x = x;
        player->warpDestPos.y = y;
        BossPlayerHelpers_Action_DoBoss5Warp(player);
    }
}

void BossPlayerHelpers_Action_Boss5Freeze(Player *player)
{
    Player__InitState(player);
    Player__ChangeAction(player, PLAYER_ACTION_BOSS5FREEZE);

    player->objWork.velocity.x = FLOAT_TO_FX32(0.0);
    player->objWork.velocity.y = FLOAT_TO_FX32(0.0);
    player->objWork.groundVel  = FLOAT_TO_FX32(0.0);
    player->objWork.userTimer  = 300;
    player->objWork.userWork   = 0;

    // Spawn a Boss5PlayerFreezeEffect
    GameObject__SpawnObject(MAPOBJECT_294, 0, 0, 0, 0, 0, 0, 0, 0);
    PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_P_FREEZE);

    SetTaskState(&player->objWork, BossPlayerHelpers_State_Boss5Frozen);
}

void BossPlayerHelpers_State_Boss1ChargeKnockback(Player *work)
{
    Player__HandleAirDrag(work);

    if ((work->objWork.flag & STAGE_TASK_FLAG_2) == 0 && (work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        work->colliders[0].flag &= ~OBS_RECT_WORK_FLAG_100;
        Player__Hurt(work);
    }
}

void BossPlayerHelpers_OnDefend_Boss3(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    GameObjectTask *stage = (GameObjectTask *)rect1->parent;
    Player *player        = (Player *)rect2->parent;

    if (stage != NULL && stage->mapObject != NULL && stage->mapObject->id == MAPOBJECT_304)
    {
        // 'BossPlayerHelpers_Action_SplatInkAir' is an action... so 'StageTaskStateMatches(&player->objWork, BossPlayerHelpers_Action_SplatInkAir)' would always be false?
        // perhaps they meant to check for 'BossPlayerHelpers_State_SplatInkHit' instead?
        if (!StageTaskStateMatches(&player->objWork, BossPlayerHelpers_State_SplatInkStuck) && !StageTaskStateMatches(&player->objWork, BossPlayerHelpers_Action_SplatInkAir))
        {
            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
                BossPlayerHelpers_Action_SplatInkAir(player);
            else
                BossPlayerHelpers_Action_SplatInkGround(player);

            Boss3__SetInkSplatFlag();
        }
    }
    else
    {
        Player__OnDefend_Regular(rect1, rect2);
    }
}

void BossPlayerHelpers_Action_SplatInkGround(Player *player)
{
    if (MATH_ABS(player->objWork.groundVel) >= FLOAT_TO_FX32(1.5))
    {
        Player__ChangeAction(player, PLAYER_ACTION_HURT_KNOCKBACK);
        player->objWork.velocity.y = -FLOAT_TO_FX32(3.0);
        player->objWork.groundVel  = FLOAT_TO_FX32(0.0);
        player->objWork.velocity.x = FLOAT_TO_FX32(0.0);
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        SetTaskState(&player->objWork, BossPlayerHelpers_State_SplatInkHit);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_BALANCE_FORWARD);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

        player->objWork.groundVel = player->objWork.velocity.x = player->objWork.velocity.y = FLOAT_TO_FX32(0.0);

        player->objWork.userTimer = 120;
        SetTaskState(&player->objWork, BossPlayerHelpers_State_SplatInkStuck);
    }
}

void BossPlayerHelpers_State_SplatInkStuck(Player *work)
{
    if (work->objWork.userTimer != 0)
        work->objWork.userTimer--;
    else
        work->actionGroundMove(work);
}

void BossPlayerHelpers_Action_SplatInkAir(Player *player)
{
    Player__ChangeAction(player, PLAYER_ACTION_HURT_KNOCKBACK);

    if (player->objWork.velocity.y < 0)
        player->objWork.velocity.y = 0;

    player->objWork.velocity.x = 0;

    SetTaskState(&player->objWork, BossPlayerHelpers_State_SplatInkHit);
}

void BossPlayerHelpers_State_SplatInkHit(Player *work)
{
    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
    {
        Player__Action_LandOnGround(work, 0);
        work->objWork.velocity.x = 0;
        work->objWork.groundVel  = 0;
        BossPlayerHelpers_Action_SplatInkGround(work);
    }
}

void BossPlayerHelpers_State_Boss5Frozen(Player *work)
{
    s32 i;

    u16 shakePower = 0;

    u32 buttonMask = work->inputKeyPress & (PAD_BUTTON_Y | PAD_BUTTON_X | PAD_KEY_DOWN | PAD_KEY_UP | PAD_KEY_LEFT | PAD_KEY_RIGHT | PAD_BUTTON_B | PAD_BUTTON_A);
    for (i = 0; i < 16; i++)
    {
        if ((buttonMask & (1 << i)) != 0)
            shakePower++;
    }

    OBS_RECT_WORK collider;
    MI_CpuClear16(&collider, sizeof(collider));
    ObjRect__SetBox3D(&collider.rect, -16, -16, -32, 16, 16, 32);
    collider.parent = &work->objWork;
    collider.flag |= OBS_RECT_WORK_FLAG_IS_ACTIVE;
    if (ObjTouchCheckPush(&work->objWork, &collider))
        shakePower += 5;

    work->objWork.userTimer--;
    work->objWork.userTimer -= 10 * shakePower;

    if ((work->objWork.userWork & 3) != 0)
    {
        work->objWork.userWork--;
        switch (work->objWork.userWork >> 2)
        {
            case 0:
                work->objWork.offset.x = -FLOAT_TO_FX32(2.0);
                break;

            case 1:
                work->objWork.offset.x = FLOAT_TO_FX32(2.0);
                break;

            case 2:
                work->objWork.offset.y = -FLOAT_TO_FX32(2.0);
                break;

            case 3:
                work->objWork.offset.y = FLOAT_TO_FX32(2.0);
                break;
        }
    }
    else
    {
        if (shakePower != 0)
        {
            work->objWork.userWork = 4 * (mtMathRand() & 3) | 2;
        }
    }

    work->objWork.userTimer--;
    if (work->objWork.userTimer <= 0)
        Player__Hurt(work);
}

void BossPlayerHelpers_Action_DoBoss5Warp(Player *player)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0 && (player->playerFlag & PLAYER_FLAG_FINISHED_STAGE) == 0)
    {
        Player__InitState(player);
        player->objWork.velocity.x = FLOAT_TO_FX32(0.0);
        player->objWork.velocity.y = FLOAT_TO_FX32(0.0);
        player->objWork.groundVel  = FLOAT_TO_FX32(0.0);

        Player__Action_StopBoost(player);
        Player__Action_StopSuperBoost(player);

        player->objWork.userTimer = 0;
        player->waterTimer        = 0;
        player->objWork.scale.x   = FLOAT_TO_FX32(1.0);
        player->objWork.scale.y   = FLOAT_TO_FX32(1.0);

        player->playerFlag |= PLAYER_FLAG_DEATH;
        player->playerFlag &= ~PLAYER_FLAG_DEATH;
        player->gimmickFlag |= PLAYER_GIMMICK_400000;
        Player__Gimmick_200EE68(player);

        player->gimmickFlag |= PLAYER_GIMMICK_200000;
        player->onLandGround(player);
    }
}

void BossPlayerHelpers_Action_SetOnLandGround_Boss6(Player *player)
{
    player->onLandGround = BossPlayerHelpers_OnLandGround_Boss6;
    player->onLandGround(player);
}

void BossPlayerHelpers_OnLandGround_Boss6(Player *player)
{
    if (BossPlayerHelpers_CheckPlayerRidingObj(player))
    {
        if (player->objWork.groundVel != FLOAT_TO_FX32(0.0))
        {
            player->actionGroundMove(player);
            return;
        }

        Player__ChangeAction(player, PLAYER_ACTION_IDLE);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_BOSS6_RUN);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_ROTATION;
        MTX_RotY33(&player->obj_3dWork.ani.work.matrix33, SinFX(FLOAT_DEG_TO_IDX(180.0)), CosFX(FLOAT_DEG_TO_IDX(180.0)));

        if ((player->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
        {
            player->tailAnimator.work.matrix33 = player->obj_3dWork.ani.work.matrix33;
        }
    }

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
    SetTaskState(&player->objWork, BossPlayerHelpers_State_Ground_Boss6);
}

BOOL BossPlayerHelpers_CheckPlayerRidingObj(Player *player)
{
    return player->objWork.rideObj != NULL;
}

void BossPlayerHelpers_State_Ground_Boss6(Player *work)
{
    if (BossPlayerHelpers_CheckPlayerRidingObj(work))
    {
        Player__State_GroundIdle(work);
    }
    else if (Player__HandleFallOffSurface(work))
    {
        work->objWork.displayFlag &= ~DISPLAY_FLAG_400;
        Player__Action_Launch(work);
    }
    else
    {
        if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0 && work->actionJump != NULL)
        {
            work->objWork.displayFlag &= ~DISPLAY_FLAG_400;
            work->actionJump(work);
        }
        else
        {
            fx32 accStore      = work->acceleration;
            fx32 decStore      = work->deceleration;
            work->acceleration = FLOAT_TO_FX32(0.25);
            work->deceleration = FLOAT_TO_FX32(0.375);
            Player__HandleGroundMovement(work);
            work->acceleration = accStore;
            work->deceleration = decStore;

            fx32 animSpeed;
            switch (work->characterID)
            {
                case CHARACTER_BLAZE:
                    animSpeed = MultiplyFX(Boss6Stage__GetScrollSpeed(), FLOAT_TO_FX32(1.0));
                    break;

                // case CHARACTER_SONIC:
                default:
                    animSpeed = MultiplyFX(Boss6Stage__GetScrollSpeed(), FLOAT_TO_FX32(0.5));
                    break;
            }

            if (work->objWork.obj_3d != NULL)
                work->objWork.obj_3d->ani.speedMultiplier = animSpeed;

            if ((work->playerFlag & PLAYER_FLAG_TAIL_IS_ACTIVE) != 0)
                work->tailAnimator.speedMultiplier = animSpeed;
        }
    }
}
