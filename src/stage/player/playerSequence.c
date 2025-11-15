#include <stage/player/player.h>
#include <stage/gameObject.h>
#include <game/system/allocator.h>
#include <game/input/padInput.h>
#include <game/object/obj.h>
#include <game/object/objPacket.h>
#include <game/math/mtMath.h>
#include <game/system/system.h>
#include <game/game/gameState.h>
#include <game/audio/spatialAudio.h>
#include <game/object/objectManager.h>
#include <game/graphics/paletteQueue.h>
#include <game/stage/gameSystem.h>
#include <game/stage/mapSys.h>
#include <game/system/sysEvent.h>
#include <stage/core/bgmManager.h>
#include <stage/core/ringManager.h>
#include <stage/core/hud.h>
#include <game/graphics/drawFadeTask.h>
#include <game/graphics/screenShake.h>

// Related Objects
#include <stage/player/starCombo.h>
#include <stage/player/scoreBonus.h>
#include <stage/objects/playerSnowboard.h>
#include <stage/objects/tripleGrindRail.h>
#include <stage/objects/cannon.h>

// Effects
#include <stage/effects/buttonPrompt.h>
#include <stage/effects/waterSplash.h>
#include <stage/effects/waterWake.h>
#include <stage/effects/waterGush.h>
#include <stage/effects/waterBubble.h>
#include <stage/effects/brakeDust.h>
#include <stage/effects/spindashDust.h>
#include <stage/effects/flameDust.h>
#include <stage/effects/flameJet.h>
#include <stage/effects/hummingTop.h>
#include <stage/effects/boost.h>
#include <stage/effects/playerTrail.h>
#include <stage/effects/shield.h>
#include <stage/effects/grind.h>
#include <stage/effects/trickSparkle.h>
#include <stage/effects/invincible.h>
#include <stage/effects/snowSmoke.h>
#include <stage/effects/drownAlert.h>
#include <stage/effects/playerIcon.h>
#include <stage/effects/battleAttack.h>

// Gimmick Objects
#include <stage/objects/jumpbox.h>
#include <stage/objects/hoverCrystal.h>
#include <stage/objects/diveStand.h>
#include <stage/objects/slingshot.h>
#include <stage/objects/corkscrewPath.h>
#include <stage/objects/dreamWing.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void _s32_div_f(void);

// --------------------
// INLINE FUNCTIONS
// --------------------

// extra macro for specific cases where the inline function won't match!
#define PlayPlayerSfxEx(seqPlayer, sfx) PlaySfxEx(seqPlayer, AUDIOMANAGER_PLAYERNO_AUTO, AUDIOMANAGER_BANKNO_AUTO, AUDIOMANAGER_PLAYERPRIO_AUTO, SND_ZONE_SEQARC_GAME_SE, sfx)

// --------------------
// FUNCTIONS
// --------------------

void Player__Action_StageStartSnowboard(Player *player)
{
    Player__ChangeAction(player, PLAYER_ACTION_IDLE_SNOWBOARD);
    ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_IDLE);

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
    SetTaskState(&player->objWork, Player__State_StageStartSnowboard);
}

void Player__State_StageStartSnowboard(Player *work)
{
    // Empty
}

void Player__Action_Spring(Player *player, fx32 velX, fx32 velY)
{
    Player__Action_GimmickLaunch(player, velX, velY);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPRING);
}

void Player__Action_GimmickLaunch(Player *player, fx32 velX, fx32 velY)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0)
    {
        Player__InitGimmick(player, TRUE);

        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
            player->objWork.velocity.x = player->objWork.groundVel;

        Player__Action_LandOnGround(player, FLOAT_DEG_TO_IDX(0.0));
        StageTask__ObjectSpdDirFall(&velX, &velY, player->objWork.fallDir);

        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
            player->cameraJumpPosY = player->objWork.position.y;

        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        SetTaskState(&player->objWork, Player__State_Air);

        if (velX != FLOAT_TO_FX32(0.0))
        {
            if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
            {
                Player__ChangeAction(player, PLAYER_ACTION_AIRFORWARD_01);
            }
            else
            {
                Player__ChangeAction(player, PLAYER_ACTION_AIRFORWARD_SNOWBOARD_01);
                ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_10);
            }

            player->objWork.velocity.x = velX;
            if (player->objWork.velocity.x < 0)
            {
                if (player->objWork.groundVel > 0)
                    player->objWork.groundVel = 0;

                player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            }
            else
            {
                if (player->objWork.groundVel < 0)
                    player->objWork.groundVel = 0;

                player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            }

            player->overSpeedLimitTimer = 64;
        }
        else
        {
            if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
            {
                Player__ChangeAction(player, PLAYER_ACTION_AIRRISE);
            }
            else
            {
                Player__ChangeAction(player, PLAYER_ACTION_AIRRISE_SNOWBOARD);
                ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_AIRRISE);
            }

            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            player->objWork.velocity.x = MultiplyFX(player->objWork.groundVel, CosFX(player->objWork.dir.z));
        }

        if (velY)
            player->objWork.velocity.y = velY;
        else
            player->objWork.velocity.y = MultiplyFX(player->objWork.groundVel, SinFX(player->objWork.dir.z));

        ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);
        player->playerFlag &= ~(PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
        player->playerFlag |= PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG;
        player->objWork.userTimer  = 0;
        player->objWork.userWork   = 0;
        player->trickCooldownTimer = 0;

        if ((player->playerFlag & PLAYER_FLAG_IN_WATER) != 0)
        {
            if (!IsBossStage())
                player->objWork.velocity.x = (player->objWork.velocity.x >> 1) + (player->objWork.velocity.x >> 2);

            if (!IsBossStage())
                player->objWork.velocity.y = (player->objWork.velocity.y >> 1) + (player->objWork.velocity.y >> 2);

            CreateEffectWaterBubbleForPlayer(player, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), mapCamera.camera[player->cameraID].waterLevel);
        }
    }
}

void Player__Gimmick_201B418(Player *player, fx32 velX, fx32 velY, BOOL allowTricks)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) != 0)
        return;

    Player__InitPhysics(player);
    Player__InitGimmick(player, allowTricks);
    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_HOMING_ATTACK);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_JUMP_SNOWBOARD_01);
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_JUMP_01);
    }

    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
    player->objWork.velocity.x = velX;
    player->objWork.velocity.y = velY;
    ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NORMAL, PLAYER_HITPOWER_NORMAL);
    player->playerFlag &= ~(PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
    player->playerFlag |= PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG;
    player->objWork.userTimer  = 0;
    player->objWork.userWork   = 0;
    player->trickCooldownTimer = 0;

    if (!allowTricks)
    {
        player->playerFlag &= ~PLAYER_FLAG_ALLOW_TRICKS;
        player->starComboCount = 0;
    }

    SetTaskState(&player->objWork, Player__State_Air);
}

void Player__Action_FollowParent(Player *player, GameObjectTask *other, fx32 offsetX, fx32 offsetY, fx32 offsetZ)
{
    if (player->gimmickObj != other)
    {
        Player__InitPhysics(player);
        Player__InitGimmick(player, FALSE);

        player->gimmickObj = other;
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR | STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES);
        player->objWork.displayFlag &= ~DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        player->objWork.userFlag = PLAYER_CHILDFLAG_NONE;
        player->playerFlag &= ~(PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
        player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;
        player->objWork.velocity.x            = FLOAT_TO_FX32(0.0);
        player->objWork.velocity.y            = FLOAT_TO_FX32(0.0);
        player->objWork.groundVel             = FLOAT_TO_FX32(0.0);
        player->objWork.userWork              = 0;
        player->objWork.userTimer             = 0;
        player->gimmick.followParent.offset.x = offsetX;
        player->gimmick.followParent.offset.y = offsetY;
        player->gimmick.followParent.offset.z = offsetZ;

        SetTaskState(&player->objWork, Player__State_FollowParent);
    }
}

void Player__State_FollowParent(Player *work)
{
    GameObjectTask *gimmickObj = work->gimmickObj;

    if (gimmickObj != NULL)
    {
        work->objWork.prevPosition.x = work->objWork.position.x;
        work->objWork.prevPosition.y = work->objWork.position.y;
        work->objWork.prevPosition.z = work->objWork.position.z;

        if ((work->playerFlag & (PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG)) != 0)
        {
            FXMatrix33 matDirection;
            FXMatrix33 matTemp;

            MTX_Identity33(matDirection.nnMtx);

            if ((work->playerFlag & PLAYER_FLAG_DISABLE_TRICK_FINISHER) != 0)
            {
                MTX_RotZ33(matDirection.nnMtx, SinFX(gimmickObj->objWork.dir.z), CosFX(gimmickObj->objWork.dir.z));
                work->objWork.dir.z = gimmickObj->objWork.dir.z;
            }

            if ((work->playerFlag & PLAYER_FLAG_USER_FLAG) != 0)
            {
                MTX_RotX33(matTemp.nnMtx, SinFX(gimmickObj->objWork.dir.x), CosFX(gimmickObj->objWork.dir.x));
                work->objWork.dir.x = gimmickObj->objWork.dir.x;
                MTX_Concat33(matDirection.nnMtx, matTemp.nnMtx, matDirection.nnMtx);
            }

            if ((work->playerFlag & PLAYER_FLAG_ALLOW_TRICKS) != 0)
            {
                MTX_RotY33(matTemp.nnMtx, SinFX((s32)(u16)-gimmickObj->objWork.dir.y), CosFX((s32)(u16)-gimmickObj->objWork.dir.y));
                work->objWork.dir.y = gimmickObj->objWork.dir.y;
                MTX_Concat33(matDirection.nnMtx, matTemp.nnMtx, matDirection.nnMtx);
            }

            if ((work->playerFlag & PLAYER_FLAG_FINISHED_TRICK_COMBO) != 0)
            {
                MTX_RotZ33(matTemp.nnMtx, SinFX(gimmickObj->objWork.dir.z), CosFX(gimmickObj->objWork.dir.z));
                work->objWork.dir.z = gimmickObj->objWork.dir.z;
                MTX_Concat33(matDirection.nnMtx, matTemp.nnMtx, matDirection.nnMtx);
            }

            VecFx32 offset;
            VEC_Set(&offset, work->gimmick.followParent.offset.x, work->gimmick.followParent.offset.y, work->gimmick.followParent.offset.z);
            MTX_MultVec33(&offset, matDirection.nnMtx, &offset);

            if ((work->objWork.userFlag & PLAYER_CHILDFLAG_FOLLOW_PREV_POS) != 0)
            {
                VEC_Set(&work->objWork.position, gimmickObj->objWork.prevPosition.x + offset.x, gimmickObj->objWork.prevPosition.y + offset.y,
                        gimmickObj->objWork.prevPosition.z + offset.z);
            }
            else
            {
                VEC_Set(&work->objWork.position, gimmickObj->objWork.position.x + offset.x, gimmickObj->objWork.position.y + offset.y, gimmickObj->objWork.position.z + offset.z);
            }
        }
        else if ((work->objWork.userFlag & PLAYER_CHILDFLAG_FOLLOW_PREV_POS) != 0)
        {
            work->objWork.position.x = gimmickObj->objWork.prevPosition.x + work->gimmick.followParent.offset.x;
            work->objWork.position.y = gimmickObj->objWork.prevPosition.y + work->gimmick.followParent.offset.y;
            work->objWork.position.z = gimmickObj->objWork.prevPosition.z;
        }
        else
        {
            work->objWork.position.x = gimmickObj->objWork.position.x + work->gimmick.followParent.offset.x;
            work->objWork.position.y = gimmickObj->objWork.position.y + work->gimmick.followParent.offset.y;
            work->objWork.position.z = gimmickObj->objWork.position.z;
        }

        work->objWork.move.x = work->objWork.position.x - work->objWork.prevPosition.x;
        work->objWork.move.y = work->objWork.position.y - work->objWork.prevPosition.y;
        work->objWork.move.z = work->objWork.position.z - work->objWork.prevPosition.z;

        if ((work->objWork.userFlag & PLAYER_CHILDFLAG_INHERIT_SHAKE_TIMER) != 0 && gimmickObj->objWork.shakeTimer != FLOAT_TO_FX32(0.0))
            work->objWork.shakeTimer = gimmickObj->objWork.shakeTimer + FLOAT_TO_FX32(1.0);

        if ((gimmickObj->objWork.userFlag & PLAYER_PARENTFLAG_RELEASE_WITH_VELOCITY) != 0)
        {
            work->objWork.velocity.x = gimmickObj->objWork.velocity.x;
            work->objWork.velocity.y = gimmickObj->objWork.velocity.y;
            work->gimmickObj         = NULL;
        }
        else if ((gimmickObj->objWork.userFlag & PLAYER_PARENTFLAG_RELEASE_WITH_GROUNDVEL) != 0)
        {
            work->objWork.velocity.x = gimmickObj->objWork.groundVel;
            work->gimmickObj         = NULL;
        }

        if ((gimmickObj->objWork.userFlag & PLAYER_PARENTFLAG_RELEASE_WITH_MOVE) != 0)
        {
            work->objWork.velocity.x = work->objWork.move.x;
            work->objWork.velocity.y = work->objWork.move.y;
            work->gimmickObj         = NULL;
        }
    }

    if (work->gimmickObj == NULL || ((work->objWork.userFlag & PLAYER_CHILDFLAG_CAN_JUMP) != 0 && (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0))
    {
        work->gimmickObj = NULL;

        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT)
                                  | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
        work->objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        work->playerFlag &= ~(PLAYER_FLAG_2000 | PLAYER_FLAG_DISABLE_TENSION_DRAIN);
        work->gimmickFlag &= ~(PLAYER_GIMMICK_10 | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_GRABBED);

        work->gimmickCamOffsetX = work->gimmickCamOffsetY = 0;
        work->objWork.dir.x = work->objWork.dir.y = work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

        StopPlayerSfx(work, PLAYER_SEQPLAYER_COMMON);

        u32 flag = work->objWork.userFlag;
        if ((flag & PLAYER_CHILDFLAG_CAN_JUMP) != 0 && (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
        {
            work->actionJump(work);
        }
        else if ((flag & PLAYER_CHILDFLAG_FORCE_JUMP_ACTION) != 0)
        {
            fx32 velX = work->objWork.velocity.x;
            fx32 velY = work->objWork.velocity.y;
            work->actionJump(work);
            work->objWork.velocity.x = velX;
            work->objWork.velocity.y = velY;
        }
        else if ((flag & PLAYER_CHILDFLAG_FORCE_LAUNCH_ACTION) != 0)
        {
            Player__Action_GimmickLaunch(work, work->objWork.velocity.x, work->objWork.velocity.y);

            if ((flag & PLAYER_CHILDFLAG_FINISH_TRICK_COMBO) != 0)
                work->playerFlag |= PLAYER_FLAG_FINISHED_TRICK_COMBO;

            if ((flag & PLAYER_CHILDFLAG_DISABLE_TRICK_FINISHER) != 0)
                work->playerFlag |= PLAYER_FLAG_DISABLE_TRICK_FINISHER;
        }
        else
        {
            Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
            work->actionGroundIdle(work);
        }
    }
}

void Player__Action_DashRing(Player *player, fx32 x, fx32 y, fx32 velX, fx32 velY)
{
    player->gimmickFlag &= ~(PLAYER_GIMMICK_40 | PLAYER_GIMMICK_10);
    player->gimmickFlag &= ~(PLAYER_GIMMICK_80 | PLAYER_GIMMICK_20);

    MapSys__Func_20091D0(player->cameraID);
    MapSys__Func_20091F0(player->cameraID);
    player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

    if (x != FLOAT_TO_FX32(0.0))
        player->objWork.position.x = x;

    if (y != FLOAT_TO_FX32(0.0))
        player->objWork.position.y = y;

    Player__Action_JumpDashLaunch(player, velX, velY);

    if (velX == FLOAT_TO_FX32(0.0))
        player->objWork.velocity.x = FLOAT_TO_FX32(0.0);

    player->overSpeedLimitTimer = 30;
    player->objWork.userTimer   = 30;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
}

void Player__Action_JumpDashLaunch(Player *player, fx32 velX, fx32 velY)
{
    Player__InitGimmick(player, TRUE);

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        player->objWork.velocity.x = player->objWork.groundVel;

    Player__Action_LandOnGround(player, FLOAT_DEG_TO_IDX(0.0));
    StageTask__ObjectSpdDirFall(&velX, &velY, player->objWork.fallDir);

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
        player->cameraJumpPosY = player->objWork.position.y;

    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;

    SetTaskState(&player->objWork, Player__State_Air);

    if (velX != FLOAT_TO_FX32(0.0))
    {
        if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            Player__ChangeAction(player, PLAYER_ACTION_JUMPDASH_01);
        }
        else
        {
            Player__ChangeAction(player, PLAYER_ACTION_JUMPDASH_SNOWBOARD_01);
            ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_RAINBOWDASHRING);
        }
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

        player->objWork.velocity.x = velX;
        if (player->objWork.velocity.x < FLOAT_TO_FX32(0.0))
        {
            if (player->objWork.groundVel > FLOAT_TO_FX32(0.0))
                player->objWork.groundVel = FLOAT_TO_FX32(0.0);

            player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        }
        else
        {
            if (player->objWork.groundVel < FLOAT_TO_FX32(0.0))
                player->objWork.groundVel = FLOAT_TO_FX32(0.0);

            player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
        }
    }
    else
    {
        if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            Player__ChangeAction(player, PLAYER_ACTION_AIRRISE);
        }
        else
        {
            Player__ChangeAction(player, PLAYER_ACTION_AIRRISE_SNOWBOARD);
            ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_AIRRISE);
        }

        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        player->objWork.velocity.x = MultiplyFX(player->objWork.groundVel, CosFX(player->objWork.dir.z));
    }

    if (velY != FLOAT_TO_FX32(0.0))
        player->objWork.velocity.y = velY;
    else
        player->objWork.velocity.y = MultiplyFX(player->objWork.groundVel, SinFX(player->objWork.dir.z));

    ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);
    player->playerFlag &= ~(PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
    player->playerFlag |= PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG;
    player->overSpeedLimitTimer = 48;
    player->objWork.userTimer   = 0;
    player->objWork.userWork    = 0;
    player->trickCooldownTimer  = 0;

    if ((player->playerFlag & PLAYER_FLAG_IN_WATER) != 0)
    {
        if (!IsBossStage())
            player->objWork.velocity.x = (player->objWork.velocity.x >> 1) + (player->objWork.velocity.x >> 2);

        if (!IsBossStage())
            player->objWork.velocity.y = (player->objWork.velocity.y >> 1) + (player->objWork.velocity.y >> 2);

        CreateEffectWaterBubbleForPlayer(player, 0, 0, mapCamera.camera[player->cameraID].waterLevel);
    }
}

void Player__Action_SpringboardLaunch(Player *player, fx32 velX, fx32 velY)
{
    StageTask__ObjectSpdDirFall(&velX, &velY, player->objWork.fallDir);
    Player__Action_JumpDashLaunch(player, velX, velY);

    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_JUMP_STAND);
}

u16 Player__CheckOnCorkscrewPath(Player *player)
{
    if (StageTaskStateMatches(&player->objWork, Player__State_CorkscrewPath))
        return TRUE;
    else
        return FALSE;
}

void Player__Action_CorkscrewPath(Player *player, fx32 x, fx32 y, s32 flags, u16 type)
{
    if (!Player__CheckOnCorkscrewPath(player))
    {
        u8 prevGrindID  = player->grindID;
        player->grindID = PLAYER_GRIND_NONE;
        Player__InitGimmick(player, FALSE);
        player->grindID = prevGrindID;

        s32 pathType = (flags >> CORKSCREWPATH_OBJFLAG_TYPE_SHIFT);
        if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            if (pathType != CORKSCREWPATH_TYPE_2 && player->actionState != PLAYER_ACTION_ROLL)
            {
                Player__HandleStartWalkAnimation(player);
            }
        }
        else
        {
            if (pathType != CORKSCREWPATH_TYPE_2 && player->actionState != PLAYER_ACTION_WALK_SNOWBOARD)
            {
                Player__ChangeAction(player, PLAYER_ACTION_WALK_SNOWBOARD);
                ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_WALK);
            }
        }

        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->playerFlag &= ~(PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);

        player->gimmick.corkscrewPath.x        = x;
        player->gimmick.corkscrewPath.y        = y;
        player->gimmick.corkscrewPath.pathType = pathType;
        player->gimmick.corkscrewPath.type     = type;
        player->objWork.userWork               = flags & CORKSCREWPATH_OBJFLAG_FLAG_MASK;
        player->objWork.userTimer              = 0;

        if ((player->objWork.userWork & CORKSCREWPATH_OBJFLAG_RIGHT_TRIGGER) != 0)
        {
            if (player->gimmick.corkscrewPath.x > player->objWork.position.x)
            {
                player->objWork.userTimer = player->gimmick.corkscrewPath.x - player->objWork.position.x;
            }
        }
        else
        {
            if (player->gimmick.corkscrewPath.x < player->objWork.position.x)
            {
                player->objWork.userTimer = player->objWork.position.x - player->gimmick.corkscrewPath.x;
            }
        }

        player->gimmick.corkscrewPath.y -= FX32_FROM_WHOLE(player->objWork.hitboxRect.bottom);

        if (player->gimmick.corkscrewPath.pathType == CORKSCREWPATH_TYPE_VERTICAL)
        {
            if ((player->objWork.userWork & CORKSCREWPATH_OBJFLAG_2) == 0)
                player->gimmick.corkscrewPath.y -= FLOAT_TO_FX32(4.0);
        }
        else
        {
            player->objWork.userWork |= CORKSCREWPATH_OBJFLAG_2;
        }

        SetTaskState(&player->objWork, Player__State_CorkscrewPath);
        player->trickCooldownTimer = 16;
    }
}

void Player__State_CorkscrewPath(Player *work)
{
    if (work->gimmick.corkscrewPath.pathType != CORKSCREWPATH_TYPE_2)
    {
        if (MATH_ABS(work->objWork.groundVel) < work->spdThresholdJog && Player__HandleFallOffSurface(work))
        {
            work->objWork.dir.x = work->objWork.dir.y = work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
            work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
            Player__Action_Launch(work);
            return;
        }
    }

    if ((work->inputKeyPress & PAD_BUTTON_A) != 0 && work->actionJump != NULL)
    {
        if (work->gimmick.corkscrewPath.pathType == CORKSCREWPATH_TYPE_2)
            work->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;

        work->objWork.dir.x = work->objWork.dir.y = work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        work->actionJump(work);
        return;
    }

    if (work->trickCooldownTimer != 0)
    {
        work->trickCooldownTimer--;
    }
    else
    {
        if ((work->objWork.userWork & CORKSCREWPATH_OBJFLAG_2) != 0)
            work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;

        if ((work->objWork.moveFlag & (STAGE_TASK_MOVE_FLAG_TOUCHING_RWALL | STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL | STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR)) != 0)
        {
            work->objWork.dir.x = work->objWork.dir.y = work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

            work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
            if (work->gimmick.corkscrewPath.pathType == CORKSCREWPATH_TYPE_VERTICAL && ((work->objWork.userWork >> 2) & 1) == 0)
            {
                work->objWork.groundVel = -work->objWork.groundVel;
                work->objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;
            }

            work->objWork.velocity.x = work->objWork.groundVel;
            Player__Action_LandOnGround(work, 0);

            if (work->gimmick.corkscrewPath.pathType == CORKSCREWPATH_TYPE_2)
                Player__Action_Grind(work);
            else
                work->actionGroundIdle(work);

            return;
        }
    }

    if (work->gimmick.corkscrewPath.pathType != CORKSCREWPATH_TYPE_2)
    {
        if ((work->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            Player__SetAnimSpeedFromVelocity(work, work->objWork.groundVel);
            if (work->actionState != PLAYER_ACTION_ROLL)
                Player__HandleActiveWalkAnimation(work);
        }
        Player__HandleGroundMovement(work);
    }

    switch (work->gimmick.corkscrewPath.pathType)
    {
        case CORKSCREWPATH_TYPE_HORIZONTAL:
        default:
            Player__HandleCorkscrewPathH(work, 0x1759D0, 288, 38);
            break;

        case CORKSCREWPATH_TYPE_VERTICAL:
            if (work->gimmick.corkscrewPath.type == 0)
                Player__HandleCorkscrewPathV(work, 0x21E520, 84, 128, 0x83F00, 128, 32);
            else
                Player__HandleCorkscrewPathV(work, 0x13C030, 40, 192, 327680, 64, 50);
            break;

        case CORKSCREWPATH_TYPE_2:
            Player__HandleCorkscrewPathH(work, 0x13D9D0, 256, 30);
            break;
    }
}

NONMATCH_FUNC void Player__HandleCorkscrewPathH(Player *player, s32 a2, s32 a3, s16 a4)
{
    // https://decomp.me/scratch/VhMz7 -> 71.08%
#ifdef NON_MATCHING
    player->objWork.userTimer += MATH_ABS(player->objWork.groundVel);

    s16 v11  = (player->objWork.userTimer / a2) << 8;
    s32 v12  = ((player->objWork.userTimer - a2 * v11) << 8) / a2;
    s32 v13  = v12 << 4;
    u16 dirX = (v12 << 4);

    player->objWork.dir.x = dirX;
    if ((player->objWork.userWork & CORKSCREWPATH_OBJFLAG_RIGHT_TRIGGER) != 0)
        player->objWork.dir.x = -player->objWork.dir.x;

    if (player->objWork.dir.x < FLOAT_DEG_TO_IDX(90.0))
    {
        player->objWork.dir.z = player->objWork.dir.x;
    }
    else if (player->objWork.dir.x < FLOAT_DEG_TO_IDX(180.0))
    {
        player->objWork.dir.z = FLOAT_DEG_TO_IDX(180.0) - player->objWork.dir.x;
    }
    else
    {
        if (player->objWork.dir.x < FLOAT_DEG_TO_IDX(270.0))
            player->objWork.dir.z = player->objWork.dir.x - FLOAT_DEG_TO_IDX(180.0);
        else
            player->objWork.dir.z = FLOAT_DEG_TO_IDX(360.0) - player->objWork.dir.x;
    }

    player->objWork.dir.z = player->objWork.dir.z >> 1;
    if (player->objWork.dir.x < FLOAT_DEG_TO_IDX(180.0))
        player->objWork.dir.z = -player->objWork.dir.z;
    player->objWork.dir.x = -player->objWork.dir.x;

    fx32 cos = CosFX(dirX);
    s16 v18  = (a4 - player->objWork.hitboxRect.bottom);
    if ((player->objWork.userWork & CORKSCREWPATH_OBJFLAG_2) != 0)
        v18 = -v18;

    player->objWork.prevPosition.x = player->objWork.position.x;
    player->objWork.prevPosition.y = player->objWork.position.y;

    if ((player->objWork.userWork & CORKSCREWPATH_OBJFLAG_RIGHT_TRIGGER) != 0)
    {
        player->objWork.position.x = player->gimmick.corkscrewPath.x - ((v11 * a3) << 12) - a3 * v13;
    }
    else
    {
        player->objWork.position.x = player->gimmick.corkscrewPath.x + ((v11 * a3) << 12) + a3 * v13;
    }

    player->objWork.position.y = player->gimmick.corkscrewPath.y + (v18 << 12) - cos * v18;

    player->objWork.move.x = player->objWork.position.x - player->objWork.prevPosition.x;
    player->objWork.move.y = player->objWork.position.y - player->objWork.prevPosition.y;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r7, r0
	ldr r4, [r7, #0xc8]
	ldr r0, [r7, #0x2c]
	cmp r4, #0
	rsblt r4, r4, #0
	add r8, r0, r4
	mov r9, r1
	mov r1, r9
	mov r0, r8
	mov r6, r2
	mov r5, r3
	str r8, [r7, #0x2c]
	bl _s32_div_f
	mov r0, r0, lsl #0x18
	mov r4, r0, asr #0x18
	mul r0, r9, r4
	sub r0, r8, r0
	mov r1, r9
	mov r0, r0, lsl #8
	bl _s32_div_f
	mov r1, r0, lsl #4
	mov r0, r1, lsl #0x14
	mov r0, r0, lsr #0x10
	strh r0, [r7, #0x30]
	ldr r2, [r7, #0x28]
	tst r2, #1
	ldrneh r2, [r7, #0x30]
	rsbne r2, r2, #0
	strneh r2, [r7, #0x30]
	ldrh r2, [r7, #0x30]
	cmp r2, #0x4000
	strloh r2, [r7, #0x34]
	blo _0201C298
	cmp r2, #0x8000
	rsblo r2, r2, #0x8000
	strloh r2, [r7, #0x34]
	blo _0201C298
	cmp r2, #0xc000
	sublo r2, r2, #0x8000
	strloh r2, [r7, #0x34]
	rsbhs r2, r2, #0x10000
	strhsh r2, [r7, #0x34]
_0201C298:
	ldrh r2, [r7, #0x34]
	mov r0, r0, lsl #0x10
	mov r2, r2, asr #1
	strh r2, [r7, #0x34]
	ldrh r2, [r7, #0x30]
	cmp r2, #0x8000
	ldrloh r2, [r7, #0x34]
	rsblo r2, r2, #0
	strloh r2, [r7, #0x34]
	ldrh r3, [r7, #0x30]
	mov r2, r0, lsr #0x10
	mov r2, r2, asr #4
	rsb r0, r3, #0
	strh r0, [r7, #0x30]
	ldrsh r0, [r7, #0xf2]
	mov r2, r2, lsl #1
	add r8, r2, #1
	sub r0, r5, r0
	ldr r2, [r7, #0x28]
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	tst r2, #2
	rsbne r2, r5, #0
	movne r2, r2, lsl #0x10
	movne r5, r2, asr #0x10
	ldr r2, [r7, #0x44]
	ldr r3, =FX_SinCosTable_
	str r2, [r7, #0x8c]
	ldr r2, [r7, #0x48]
	mov r8, r8, lsl #1
	str r2, [r7, #0x90]
	ldr r2, [r7, #0x28]
	ldrsh r0, [r3, r8]
	tst r2, #1
	mul r2, r4, r6
	ldreq r3, [r7, #0x6f0]
	addeq r2, r3, r2, lsl #12
	mlaeq r1, r6, r1, r2
	beq _0201C344
	mul r1, r6, r1
	ldr r3, [r7, #0x6f0]
	sub r2, r3, r2, lsl #12
	sub r1, r2, r1
_0201C344:
	str r1, [r7, #0x44]
	mul r1, r0, r5
	ldr r0, [r7, #0x6f4]
	add r0, r0, r5, lsl #12
	sub r0, r0, r1
	str r0, [r7, #0x48]
	ldr r1, [r7, #0x44]
	ldr r0, [r7, #0x8c]
	sub r0, r1, r0
	str r0, [r7, #0xbc]
	ldr r1, [r7, #0x48]
	ldr r0, [r7, #0x90]
	sub r0, r1, r0
	str r0, [r7, #0xc0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Player__HandleCorkscrewPathV(Player *player, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6, s32 a7)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	mov r11, r1
	ldr r1, [sp, #0x28]
	ldr r0, [r10, #0xc8]
	str r1, [sp, #0x28]
	cmp r0, #0
	ldr r4, [r10, #0x28]
	ldr r1, [r10, #0x2c]
	mov r4, r4, lsl #0x16
	rsblt r0, r0, #0
	mov r9, r2
	adds r2, r1, r0
	rsbmi r1, r2, #0
	ldr r7, [sp, #0x2c]
	ldr r6, [sp, #0x30]
	ldr r0, [sp, #0x28]
	movpl r1, r2
	mov r8, r3
	mov r4, r4, asr #0x18
	str r2, [r10, #0x2c]
	cmp r1, r0
	blt _0201C73C
	ldr r0, [r10, #0x5d8]
	tst r0, #1
	bne _0201C470
	orr r0, r0, #1
	str r0, [r10, #0x5d8]
	ldr r0, [r10, #0x28]
	ldrsh r1, [r10, #0xf2]
	tst r0, #1
	sub r0, r7, r9
	beq _0201C418
	ldr r2, [r10, #0x6f0]
	add r0, r1, r0
	sub r0, r2, r0, lsl #12
	b _0201C424
_0201C418:
	ldr r2, [r10, #0x6f0]
	add r0, r1, r0
	add r0, r2, r0, lsl #12
_0201C424:
	str r0, [r10, #0x6f0]
	ldr r0, [r10, #0x28]
	ldr r1, [r10, #0x6f4]
	tst r0, #2
	rsbne r0, r6, r8, asr #2
	addne r0, r1, r0, lsl #12
	rsbeq r0, r6, r8, asr #2
	subeq r0, r1, r0, lsl #12
	str r0, [r10, #0x6f4]
	ldr r0, [r10, #0x28]
	tst r0, #2
	bne _0201C45C
	tst r4, #1
	beq _0201C468
_0201C45C:
	mov r0, #0xc000
	strh r0, [r10, #0x30]
	b _0201C470
_0201C468:
	mov r0, #0x4000
	strh r0, [r10, #0x30]
_0201C470:
	ldr r1, [r10, #0x2c]
	ldr r0, [sp, #0x28]
	sub r0, r1, r0
	adds r5, r0, r11, asr #2
	rsbmi r0, r5, #0
	movpl r0, r5
	mov r1, r11, asr #1
	add r0, r0, r11, asr #2
	str r1, [sp]
	bl FX_DivS32
	mov r0, r0, lsl #0x18
	cmp r4, r0, asr #24
	mov r0, r0, asr #0x18
	bgt _0201C614
	ldr r1, [r10, #0x5d8]
	tst r1, #2
	bne _0201C528
	orr r1, r1, #2
	str r1, [r10, #0x5d8]
	ldr r1, [r10, #0x28]
	tst r1, #1
	ldrsh r1, [r10, #0xf2]
	ldreq r2, [r10, #0x6f0]
	subeq r1, r9, r1
	addeq r1, r2, r1, lsl #12
	beq _0201C4E4
	ldr r2, [r10, #0x6f0]
	sub r1, r9, r1
	sub r1, r2, r1, lsl #12
_0201C4E4:
	str r1, [r10, #0x6f0]
	ldr r1, [r10, #0x28]
	tst r1, #2
	sub r1, r0, #1
	mov r0, r8, asr #1
	beq _0201C514
	mul r0, r1, r0
	ldr r1, [r10, #0x6f4]
	add r0, r0, r8, asr #2
	sub r0, r1, r0, lsl #12
	str r0, [r10, #0x6f4]
	b _0201C528
_0201C514:
	mul r0, r1, r0
	ldr r1, [r10, #0x6f4]
	add r0, r0, r8, asr #2
	add r0, r1, r0, lsl #12
	str r0, [r10, #0x6f4]
_0201C528:
	ldr r0, [sp]
	mul r1, r0, r4
	sub r0, r5, r1
	add r0, r0, r11, asr #2
	ldr r1, [sp, #0x28]
	mov r0, r0, lsl #8
	bl FX_DivS32
	mov r0, r0, lsl #4
	mov r1, r0, asr #0x1f
	mov r2, r1, lsl #0xe
	mov r1, #0x800
	adds r3, r1, r0, lsl #14
	orr r2, r2, r0, lsr #18
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r2, #0xc000
	ldr r2, [r10, #0x28]
	mov r1, r1, lsl #0x10
	tst r2, #2
	mov r1, r1, lsr #0x10
	bne _0201C590
	tst r4, #1
	rsbeq r1, r1, #0
	moveq r1, r1, lsl #0x10
	moveq r1, r1, lsr #0x10
_0201C590:
	strh r1, [r10, #0x30]
	ldr r2, [r10, #0x28]
	tst r2, #2
	rsbne r1, r6, #0
	movne r1, r1, lsl #0x10
	movne r6, r1, asr #0x10
	tst r2, #1
	rsbne r1, r7, #0
	movne r1, r1, lsl #0x10
	movne r7, r1, asr #0x10
	tst r4, #1
	rsbeq r1, r7, #0
	moveq r1, r1, lsl #0x10
	moveq r7, r1, asr #0x10
	ldr r1, [r10, #0x44]
	str r1, [r10, #0x8c]
	ldr r1, [r10, #0x48]
	str r1, [r10, #0x90]
	ldr r1, [r10, #0x6f0]
	mla r1, r7, r0, r1
	str r1, [r10, #0x44]
	ldr r1, [r10, #0x6f4]
	mla r0, r6, r0, r1
	str r0, [r10, #0x48]
	ldr r1, [r10, #0x44]
	ldr r0, [r10, #0x8c]
	sub r0, r1, r0
	str r0, [r10, #0xbc]
	ldr r1, [r10, #0x48]
	ldr r0, [r10, #0x90]
	sub r0, r1, r0
	str r0, [r10, #0xc0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0201C614:
	mov r0, r5
	mov r1, r11
	bl FX_DivS32
	mov r0, r0, lsl #0x18
	mov r6, r0, asr #0x18
	mul r0, r11, r6
	mov r1, r11
	sub r0, r5, r0
	bl FX_Div
	mov r1, r0, lsl #0x14
	mov r1, r1, lsr #0x10
	add r2, r1, #0xc000
	and r2, r2, #0xff00
	strh r2, [r10, #0x32]
	ldr r2, [r10, #0x28]
	tst r2, #1
	ldrneh r2, [r10, #0x32]
	rsbne r2, r2, #0
	strneh r2, [r10, #0x32]
	ldr r2, [r10, #0x28]
	tst r2, #2
	bne _0201C67C
	tst r4, #1
	ldreqh r2, [r10, #0x32]
	rsbeq r2, r2, #0
	streqh r2, [r10, #0x32]
_0201C67C:
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r4, r2, #1
	ldr r2, [r10, #0x28]
	ldrsh r1, [r10, #0xf2]
	tst r2, #2
	rsbne r2, r8, #0
	movne r2, r2, lsl #0x10
	movne r8, r2, asr #0x10
	ldr r2, [r10, #0x44]
	sub r1, r9, r1
	str r2, [r10, #0x8c]
	ldr r2, [r10, #0x48]
	mov r1, r1, lsl #0x10
	str r2, [r10, #0x90]
	ldr r2, [r10, #0x28]
	ldr r3, =FX_SinCosTable_
	mov r4, r4, lsl #1
	mov r9, r1, asr #0x10
	ldrsh r1, [r3, r4]
	tst r2, #1
	beq _0201C6F0
	ldr r2, [r10, #0x6f0]
	sub r2, r2, r9, lsl #12
	mla r2, r1, r9, r2
	str r2, [r10, #0x44]
	b _0201C704
_0201C6F0:
	mul r2, r1, r9
	ldr r1, [r10, #0x6f0]
	add r1, r1, r9, lsl #12
	sub r1, r1, r2
	str r1, [r10, #0x44]
_0201C704:
	mul r1, r6, r8
	ldr r2, [r10, #0x6f4]
	add r1, r2, r1, lsl #12
	mla r0, r8, r0, r1
	str r0, [r10, #0x48]
	ldr r1, [r10, #0x44]
	ldr r0, [r10, #0x8c]
	sub r0, r1, r0
	str r0, [r10, #0xbc]
	ldr r1, [r10, #0x48]
	ldr r0, [r10, #0x90]
	sub r0, r1, r0
	str r0, [r10, #0xc0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0201C73C:
	mov r1, r0
	mov r0, r2, lsl #8
	bl FX_DivS32
	mov r0, r0, lsl #4
	mov r1, r0, asr #0x1f
	mov r2, r1, lsl #0xe
	mov r1, #0x800
	adds r3, r1, r0, lsl #14
	orr r2, r2, r0, lsr #18
	adc r1, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r1, lsl #20
	ldr r2, [r10, #0x28]
	mov r1, r3, lsl #0x10
	tst r2, #2
	mov r1, r1, lsr #0x10
	bne _0201C788
	tst r4, #1
	beq _0201C794
_0201C788:
	rsb r1, r1, #0x10000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
_0201C794:
	strh r1, [r10, #0x30]
	ldr r2, [r10, #0x28]
	tst r2, #2
	rsbne r1, r6, #0
	movne r1, r1, lsl #0x10
	movne r6, r1, asr #0x10
	tst r2, #1
	rsbne r1, r7, #0
	movne r1, r1, lsl #0x10
	movne r7, r1, asr #0x10
	ldr r1, [r10, #0x44]
	str r1, [r10, #0x8c]
	ldr r1, [r10, #0x48]
	str r1, [r10, #0x90]
	ldr r1, [r10, #0x6f0]
	mla r1, r7, r0, r1
	str r1, [r10, #0x44]
	ldr r1, [r10, #0x6f4]
	mla r0, r6, r0, r1
	str r0, [r10, #0x48]
	ldr r1, [r10, #0x44]
	ldr r0, [r10, #0x8c]
	sub r0, r1, r0
	str r0, [r10, #0xbc]
	ldr r1, [r10, #0x48]
	ldr r0, [r10, #0x90]
	sub r0, r1, r0
	str r0, [r10, #0xc0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

void Player__Action_PipeEnter(Player *player, GameObjectTask *other, u16 angle, s32 timer)
{
    static const enum SND_ZONE_SEQARC_GAME_SE sfxJump[CHARACTER_COUNT] = {
        [CHARACTER_SONIC] = SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPIN, [CHARACTER_BLAZE] = SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BURST
    };

    if (player->gimmickObj != other)
    {
        Player__InitPhysics(player);
        Player__InitGimmick(player, FALSE);

        player->gimmickObj = other;
        Player__ChangeAction(player, PLAYER_ACTION_ROLL);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        SetTaskState(&player->objWork, Player__State_PipeTravel);

        player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
        player->objWork.moveFlag |=
            STAGE_TASK_MOVE_FLAG_4000 | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION | STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_IDLE_ACCELERATION);
        player->playerFlag &= ~PLAYER_FLAG_USER_FLAG;
        player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;
        player->gimmickFlag |= PLAYER_GIMMICK_GRABBED;
        player->objWork.groundVel     = FLOAT_TO_FX32(0.0);
        player->objWork.velocity.x    = FLOAT_TO_FX32(0.0);
        player->objWork.velocity.y    = FLOAT_TO_FX32(0.0);
        player->objWork.dir.z         = FLOAT_DEG_TO_IDX(0.0);
        player->objWork.userWork      = 0;
        player->objWork.userTimer     = timer;
        player->gimmick.pipe.angle    = angle;
        player->gimmick.pipe.startX   = player->objWork.position.x;
        player->gimmick.pipe.startY   = player->objWork.position.y;
        player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;
        player->blinkTimer            = 0;
        player->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

        PlayPlayerSfxEx(&player->seqPlayers[PLAYER_SEQPLAYER_COMMON], sfxJump[player->characterID]);
    }
}

void Player__State_PipeTravel(Player *work)
{
    work->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;

    switch (work->objWork.userWork)
    {
        case 0:
            if (work->gimmickObj != NULL)
            {
                work->objWork.prevPosition.x = work->objWork.position.x;
                work->objWork.prevPosition.y = work->objWork.position.y;

                if (work->gimmick.pipe.angle == FLOAT_DEG_TO_IDX(0.0) || work->gimmick.pipe.angle == FLOAT_DEG_TO_IDX(180.0))
                {
                    work->objWork.position.y =
                        ObjDiffSet(work->objWork.position.y, work->gimmickObj->objWork.position.y, work->gimmick.pipe.startY, 1, FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(1.0));

                    if (MATH_ABS(work->objWork.position.y - work->gimmickObj->objWork.position.y) < FLOAT_TO_FX32(8.0))
                        work->objWork.position.x =
                            ObjDiffSet(work->objWork.position.x, work->gimmickObj->objWork.position.x, work->gimmick.pipe.startX, 1, FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(1.0));
                }
                else
                {
                    work->objWork.position.x =
                        ObjDiffSet(work->objWork.position.x, work->gimmickObj->objWork.position.x, work->gimmick.pipe.startX, 1, FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(1.0));

                    if (MATH_ABS(work->objWork.position.x - work->gimmickObj->objWork.position.x) < FLOAT_TO_FX32(8.0))
                        work->objWork.position.y =
                            ObjDiffSet(work->objWork.position.y, work->gimmickObj->objWork.position.y, work->gimmick.pipe.startY, 1, FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(1.0));
                }

                if (work->gimmickObj->objWork.position.x == work->objWork.position.x && work->gimmickObj->objWork.position.y == work->objWork.position.y)
                {
                    work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
                    work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
                    work->objWork.userWork++;
                    work->objWork.dir.z = work->gimmick.pipe.angle;
                }
            }
            else
            {
                work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
                work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
                work->objWork.userWork++;
                work->objWork.dir.z = work->gimmick.pipe.angle;
            }
            break;

        case 1:
            if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
            {
                work->objWork.dir.z += FLOAT_DEG_TO_IDX(180.0);
                work->playerFlag ^= PLAYER_FLAG_USER_FLAG;
            }

            work->objWork.userTimer--;
            if (work->objWork.userTimer <= 0 && (work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
            {
                work->objWork.groundVel = FLOAT_TO_FX32(8.0);

                if ((work->playerFlag & PLAYER_FLAG_USER_FLAG) != 0)
                    work->objWork.groundVel = -work->objWork.groundVel;

                work->objWork.userWork++;
                PlayHandleStageSfx(work->seqPlayers, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FLOWER_MOVE);
            }
            break;

        default:
            if ((work->playerFlag & PLAYER_FLAG_USER_FLAG) != 0)
                work->objWork.groundVel = ObjSpdUpSet(work->objWork.groundVel, -FLOAT_TO_FX32(0.0625), FLOAT_TO_FX32(13.0));
            else
                work->objWork.groundVel = ObjSpdUpSet(work->objWork.groundVel, FLOAT_TO_FX32(0.0625), FLOAT_TO_FX32(13.0));

            Player__SetAnimSpeedFromVelocity(work, work->objWork.groundVel);
            work->boostEndTimer = 0;
            break;
    }
}

void Player__Action_PipeExit(Player *player, fx32 velocity, BOOL allowTricks, u32 type)
{
    const s8 sfxEject[2] = { SND_ZONE_SEQARC_GAME_SE_SEQ_SE_FLOWER_EJECT, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_STEAM_PIPE };

    if (StageTaskStateMatches(&player->objWork, Player__State_PipeTravel))
    {
        if (type >= 2)
            type = 0;

        s32 orientation = player->objWork.dir.z >> 13;
        if ((player->playerFlag & PLAYER_FLAG_USER_FLAG) != 0)
            orientation = (orientation + 4) & 7;

        if (velocity == FLOAT_TO_FX32(0.0))
            velocity = (s16)MATH_ABS(player->objWork.groundVel);

        fx32 velocity2 = MultiplyFX(velocity, SinFX(FLOAT_DEG_TO_IDX(45.0)));

        player->gimmickObj = NULL;
        player->objWork.moveFlag |= (STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_IDLE_ACCELERATION | STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY);
        player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS
                                      | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_4000);
        player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
        player->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;
        player->gimmickFlag &= ~PLAYER_GIMMICK_GRABBED;

        PlayPlayerSfxEx(&player->seqPlayers[PLAYER_SEQPLAYER_COMMON], sfxEject[type]);

        player->objWork.groundVel = 0;
        player->actionJump(player);
        player->objWork.velocity.x = 0;
        player->objWork.velocity.y = 0;

        switch (orientation)
        {
            case 0:
            default:
                player->objWork.velocity.x = velocity;
                break;

            case 1:
                player->objWork.velocity.x = velocity2;
                player->objWork.velocity.y = velocity2;
                break;

            case 2:
                player->objWork.velocity.y = velocity;
                break;

            case 3:
                player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                player->objWork.velocity.x = -velocity2;
                player->objWork.velocity.y = velocity2;
                break;

            case 4:
                player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                player->objWork.velocity.x = -velocity;
                break;

            case 5:
                player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                player->objWork.velocity.x = -velocity2;
                player->objWork.velocity.y = -velocity2;
                break;

            case 6:
                player->objWork.velocity.y = -velocity;
                break;

            case 7:
                player->objWork.velocity.x = velocity2;
                player->objWork.velocity.y = -velocity2;
                break;
        }

        player->playerFlag |= PLAYER_FLAG_USER_FLAG;
        if (allowTricks)
            player->playerFlag |= PLAYER_FLAG_ALLOW_TRICKS;

        player->colliders[0].defPower = PLAYER_DEFPOWER_NORMAL;
    }
}

void Player__Action_RotatingHanger(Player *player, GameObjectTask *hanger, fx32 launchForce, BOOL launchUpwards)
{
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) != 0)
    {
        player->objWork.groundVel = MATH_ABS(player->objWork.velocity.x) + MATH_ABS(player->objWork.velocity.y);
    }
    else
    {
        player->objWork.groundVel = MATH_ABS(player->objWork.groundVel) + MATH_ABS(player->objWork.velocity.x) + MATH_ABS(player->objWork.velocity.y);
    }

    if (player->objWork.groundVel < FLOAT_TO_FX32(6.0))
    {
        player->objWork.groundVel = FLOAT_TO_FX32(6.0);
    }
    else if (player->objWork.groundVel > FLOAT_TO_FX32(7.5))
    {
        player->objWork.groundVel = FLOAT_TO_FX32(7.5);
    }

    // player->objWork.groundVel = MTM_MATH_CLIP(player->objWork.groundVel, FLOAT_TO_FX32(6.0), FLOAT_TO_FX32(7.5));
    player->objWork.groundVel >>= 4;

    player->objWork.velocity.x = FLOAT_TO_FX32(0.0);
    player->objWork.velocity.y = FLOAT_TO_FX32(0.0);
    Player__InitPhysics(player);
    Player__InitGimmick(player, FALSE);
    player->gimmickObj     = hanger;
    player->gimmick.value2 = player->objWork.groundVel;
    Player__ChangeAction(player, PLAYER_ACTION_HANG_ROT);
    player->objWork.obj_3d->ani.speedMultiplier = FLOAT_TO_FX32(0.0);
    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES | STAGE_TASK_MOVE_FLAG_IN_AIR);
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    player->objWork.flag |= STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING;
    player->playerFlag |= PLAYER_FLAG_2000;
    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;
    player->gimmickFlag |= PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10 | PLAYER_GIMMICK_8;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

    player->objWork.dir.x = FLOAT_DEG_TO_IDX(0.0);
    if (!launchUpwards)
        player->objWork.dir.y = FLOAT_DEG_TO_IDX(180.0);

    u16 angle = FX_Atan2Idx(hanger->objWork.position.y - player->objWork.position.y, hanger->objWork.position.x - player->objWork.position.x);

    player->objWork.dir.z     = FLOAT_DEG_TO_IDX(0.0);
    player->gimmick.value3    = angle;
    player->objWork.userWork  = 0;
    player->objWork.userTimer = 0;
    player->gimmickCamOffsetY = 0;
    player->gimmick.value1    = launchForce;
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GIMMICK);

    SetTaskState(&player->objWork, Player__State_RotatingHanger);
}

NONMATCH_FUNC void Player__State_RotatingHanger(Player *work)
{
    // https://decomp.me/scratch/CFcqm -> 94.49%
#ifdef NON_MATCHING
    if (work->gimmickObj != NULL)
    {
        s32 spinDir;
        BOOL flag;
        if (work->objWork.dir.y != FLOAT_DEG_TO_IDX(0.0))
        {
            u16 angle = work->gimmick.value3;

            flag = FALSE;
            if (angle > FLOAT_DEG_TO_IDX(90.0) && angle <= FLOAT_DEG_TO_IDX(270.0))
                flag = TRUE;

            spinDir = 1;
        }
        else
        {
            u16 angle = work->gimmick.value3;

            flag = TRUE;
            if (angle > FLOAT_DEG_TO_IDX(90.0) && angle <= FLOAT_DEG_TO_IDX(270.0))
                flag = FALSE;

            spinDir = -1;
        }

        if (flag)
        {
            work->objWork.groundVel = ObjSpdUpSet(work->objWork.groundVel, work->gimmick.value2 >> 5, work->gimmick.value2);
        }
        else
        {
            work->objWork.groundVel = ObjSpdDownSet(work->objWork.groundVel, work->gimmick.value2 >> 5);

            if (work->objWork.groundVel < work->gimmick.value2 >> 1)
                work->objWork.groundVel = work->gimmick.value2 >> 1;
        }

        u16 prevAngle        = work->gimmick.value3;
        work->gimmick.value3 = (u16)(work->gimmick.value3 + spinDir * work->objWork.groundVel);
        if (work->objWork.dir.y && prevAngle < FLOAT_DEG_TO_IDX(180.0) && work->gimmick.value3 >= FLOAT_DEG_TO_IDX(180.0)
            || !work->objWork.dir.y && prevAngle < FLOAT_DEG_TO_IDX(180.0) && work->gimmick.value3 > FLOAT_DEG_TO_IDX(180.0))
        {
            PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TURN_RING);
        }

        u16 angle;
        if (work->objWork.dir.y != FLOAT_DEG_TO_IDX(0.0))
        {
            angle = work->gimmick.value3;
            angle += FLOAT_DEG_TO_IDX(270.0);
        }
        else
        {
            angle = -work->gimmick.value3;
            angle += FLOAT_DEG_TO_IDX(90.0);
        }
        Player__SetAnimFrame(work, (FLOAT_TO_FX32(80.0) * (angle >> 8)) >> 8);

        work->objWork.prevPosition.x = work->objWork.position.x;
        work->objWork.prevPosition.y = work->objWork.position.y;
        work->objWork.position.x     = work->gimmickObj->objWork.position.x + MultiplyFX(work->gimmick.value1, CosFX((s32)(u16)work->gimmick.value3));
        work->objWork.position.y     = work->gimmickObj->objWork.position.y + MultiplyFX(work->gimmick.value1, SinFX((s32)(u16)work->gimmick.value3));
        work->objWork.move.x         = work->objWork.position.x - work->objWork.prevPosition.x;
        work->objWork.move.y         = work->objWork.position.y - work->objWork.prevPosition.y;
    }

    if (work->gimmickObj == NULL || (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
    {
        s32 offset = FLOAT_DEG_TO_IDX(45.0);
        if (work->objWork.dir.y == FLOAT_DEG_TO_IDX(0.0))
            offset = -offset;
        u16 angle = (u16)work->gimmick.value3 + FLOAT_DEG_TO_IDX(180.0) + offset;

        StopPlayerSfx(work, PLAYER_SEQPLAYER_COMMON);

        fx32 force              = work->gimmick.value2;
        work->objWork.groundVel = 0;
        work->objWork.dir.y     = 0;
        work->objWork.dir.z     = 0;
        work->gimmickObj        = NULL;
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_4000 | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);

        force *= 16;
        fx32 velX = MultiplyFX(force, CosFX(angle));
        fx32 velY = MultiplyFX(force, SinFX(angle));
        work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        work->playerFlag &= ~(PLAYER_FLAG_2000 | PLAYER_FLAG_DISABLE_TENSION_DRAIN);
        work->gimmickFlag &= ~(PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10 | PLAYER_GIMMICK_8);
        Player__Gimmick_201B418(work, velX, velY, TRUE);
        work->objWork.userTimer = 5;
        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    }
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0x6d8]
	cmp r0, #0
	beq _0201D1E4
	ldrh r0, [r5, #0x32]
	cmp r0, #0
	ldr r0, [r5, #0x6f8]
	beq _0201CFE0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	cmp r0, #0x4000
	bls _0201CFD8
	cmp r0, #0xc000
	movls r1, #1
_0201CFD8:
	mov r4, #1
	b _0201D000
_0201CFE0:
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #1
	cmp r0, #0x4000
	bls _0201CFFC
	cmp r0, #0xc000
	movls r1, #0
_0201CFFC:
	mvn r4, #0
_0201D000:
	cmp r1, #0
	beq _0201D020
	ldr r2, [r5, #0x6f4]
	ldr r0, [r5, #0xc8]
	mov r1, r2, asr #5
	bl ObjSpdUpSet
	str r0, [r5, #0xc8]
	b _0201D044
_0201D020:
	ldr r1, [r5, #0x6f4]
	ldr r0, [r5, #0xc8]
	mov r1, r1, asr #5
	bl ObjSpdDownSet
	str r0, [r5, #0xc8]
	ldr r1, [r5, #0x6f4]
	cmp r0, r1, asr #1
	mov r0, r1, asr #1
	strlt r0, [r5, #0xc8]
_0201D044:
	ldr r2, [r5, #0x6f8]
	ldr r1, [r5, #0xc8]
	mov r0, r2, lsl #0x10
	mla r1, r4, r1, r2
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [r5, #0x6f8]
	ldrh r2, [r5, #0x32]
	mov r1, r0, lsr #0x10
	cmp r2, #0
	beq _0201D084
	cmp r1, #0x8000
	bhs _0201D084
	ldr r0, [r5, #0x6f8]
	cmp r0, #0x8000
	bge _0201D0A0
_0201D084:
	cmp r2, #0
	bne _0201D0C8
	cmp r1, #0x8000
	bhs _0201D0C8
	ldr r0, [r5, #0x6f8]
	cmp r0, #0x8000
	ble _0201D0C8
_0201D0A0:
	mov r4, #0x4d
	sub r1, r4, #0x4e
	add r0, r5, #0x254
	mov r2, #0
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	str r4, [sp, #4]
	bl PlaySfxEx
_0201D0C8:
	ldrh r0, [r5, #0x32]
	cmp r0, #0
	ldr r0, [r5, #0x6f8]
	beq _0201D0E8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r0, r0, #0xc000
	b _0201D0F8
_0201D0E8:
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r0, r0, #0x4000
_0201D0F8:
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #8
	add r0, r0, r0, lsl #2
	mov r1, r0, lsl #0x10
	mov r0, r5
	mov r1, r1, asr #8
	bl Player__SetAnimFrame
	ldr r1, [r5, #0x44]
	ldr r0, =FX_SinCosTable_
	str r1, [r5, #0x8c]
	ldr r1, [r5, #0x48]
	str r1, [r5, #0x90]
	ldr r2, [r5, #0x6f8]
	ldr r1, [r5, #0x6d8]
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [r0, r2]
	ldr r3, [r5, #0x6f0]
	ldr r4, [r1, #0x44]
	smull r2, r1, r3, r2
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r4, r2
	str r1, [r5, #0x44]
	ldr r1, [r5, #0x6f8]
	ldr r2, [r5, #0x6d8]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r0, [r0, r1]
	ldr r1, [r5, #0x6f0]
	ldr r3, [r2, #0x48]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	str r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x8c]
	sub r0, r1, r0
	str r0, [r5, #0xbc]
	ldr r1, [r5, #0x48]
	ldr r0, [r5, #0x90]
	sub r0, r1, r0
	str r0, [r5, #0xc0]
_0201D1E4:
	ldr r0, [r5, #0x6d8]
	cmp r0, #0
	beq _0201D204
	add r0, r5, #0x700
	ldrh r0, [r0, #0x22]
	tst r0, #3
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
_0201D204:
	ldrh r0, [r5, #0x32]
	mov r2, #0x2000
	add r1, r5, #0x254
	cmp r0, #0
	ldr r0, [r5, #0x6f8]
	rsbeq r2, r2, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r0, r0, #0x8000
	add r0, r0, r2
	mov r2, r0, lsl #0x10
	add r0, r1, #0x400
	mov r1, #0
	mov r4, r2, lsr #0x10
	bl NNS_SndPlayerStopSeq
	ldr ip, [r5, #0x6f4]
	mov r1, #0
	str r1, [r5, #0xc8]
	mov r0, r4, lsl #0x10
	strh r1, [r5, #0x32]
	mov r0, r0, lsr #0x10
	strh r1, [r5, #0x34]
	mov r0, r0, asr #4
	str r1, [r5, #0x6d8]
	mov r4, r0, lsl #1
	ldr r1, [r5, #0x1c]
	add r0, r4, #1
	orr r3, r1, #0xc0
	mov r1, r0, lsl #1
	ldr r2, =FX_SinCosTable_
	mov r0, r4, lsl #1
	bic r3, r3, #0x6100
	str r3, [r5, #0x1c]
	ldrsh r1, [r2, r1]
	mov ip, ip, lsl #4
	ldrsh r0, [r2, r0]
	smull r2, r1, ip, r1
	ldr r4, [r5, #0x18]
	adds r3, r2, #0x800
	bic r2, r4, #2
	str r2, [r5, #0x18]
	smull r0, r2, ip, r0
	adc ip, r1, #0
	adds r4, r0, #0x800
	mov r1, r3, lsr #0xc
	adc r3, r2, #0
	mov r2, r4, lsr #0xc
	orr r2, r2, r3, lsl #20
	ldr lr, [r5, #0x5d8]
	ldr r0, =0xFFEFDFFF
	orr r1, r1, ip, lsl #20
	and r0, lr, r0
	str r0, [r5, #0x5d8]
	ldr r0, [r5, #0x5dc]
	mov r3, #1
	bic r4, r0, #0x38
	mov r0, r5
	str r4, [r5, #0x5dc]
	bl Player__Gimmick_201B418
	mov r0, #5
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x1c]
	bic r0, r0, #0x80
	str r0, [r5, #0x1c]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Player__Action_SwingRope(Player *player, GameObjectTask *swingRope, s32 radius, s32 angleOffset)
{
    if (player->gimmickObj != swingRope)
    {
        Player__InitPhysics(player);
        Player__InitGimmick(player, 0);
        player->gimmickObj = swingRope;
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->playerFlag &= ~(PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
        player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN | PLAYER_FLAG_2000;
        player->gimmickFlag |= PLAYER_GIMMICK_20;
        player->gimmickCamOffsetY             = -58;
        player->objWork.velocity.x            = 0;
        player->objWork.velocity.y            = 0;
        player->objWork.groundVel             = 0;
        player->objWork.dir.z                 = swingRope->objWork.dir.z;
        player->objWork.userWork              = 0;
        player->objWork.userTimer             = 0;
        player->gimmick.swingRope.radius      = radius;
        player->gimmick.swingRope.angleOffset = angleOffset;

        PlayStageSfx(SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GIMMICK);

        SetTaskState(&player->objWork, Player__State_SwingRope);
    }
}

void Player__State_SwingRope(Player *work)
{
    GameObjectTask *swingRope = work->gimmickObj;

    if (swingRope != NULL)
    {
        work->objWork.prevPosition.x = work->objWork.position.x;
        work->objWork.prevPosition.y = work->objWork.position.y;
        work->objWork.prevPosition.z = work->objWork.position.z;

        work->objWork.dir.z = swingRope->objWork.dir.z;
        if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
            work->objWork.dir.z += FLOAT_DEG_TO_IDX(180.0);

        work->objWork.position.x =
            swingRope->objWork.prevPosition.x + MultiplyFX(work->gimmick.swingRope.radius, CosFX((s32)(u16)(work->objWork.dir.z + work->gimmick.swingRope.angleOffset)));
        work->objWork.position.y =
            swingRope->objWork.prevPosition.y + MultiplyFX(work->gimmick.swingRope.radius, SinFX((s32)(u16)(work->objWork.dir.z + work->gimmick.swingRope.angleOffset)));
        work->objWork.position.z = swingRope->objWork.prevPosition.z;

        work->objWork.move.x = work->objWork.position.x - work->objWork.prevPosition.x;
        work->objWork.move.y = work->objWork.position.y - work->objWork.prevPosition.y;
        work->objWork.move.z = work->objWork.position.z - work->objWork.prevPosition.z;

        work->objWork.groundVel  = work->objWork.move.x;
        work->objWork.velocity.y = work->objWork.move.y;
    }

    if (work->gimmickObj == NULL || (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
    {
        work->gimmickObj = NULL;
        work->gimmickFlag &= ~PLAYER_GIMMICK_20;
        work->gimmickCamOffsetY = 0;
        work->playerFlag &= ~(PLAYER_FLAG_2000 | PLAYER_FLAG_DISABLE_TENSION_DRAIN);
        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
        work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
        work->objWork.groundVel >>= 1;

        if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
        {
            work->actionJump(work);
        }
        else
        {
            Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
            work->actionGroundIdle(work);
        }
    }
}

void Player__Action_MushroomBounce(Player *player, fx32 velX, fx32 velY, s32 timer)
{
    ClampSingleS32(&player->objWork.groundVel, player->spdThresholdDash);
    ClampSingleS32(&player->objWork.velocity.x, player->spdThresholdDash);

    Player__Action_GimmickLaunch(player, velX, velY);
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    player->objWork.userTimer = 3 * timer + 1;

    Player__ChangeAction(player, PLAYER_ACTION_MUSHROOM_BOUNCE);
    StopPlayerSfx(player, PLAYER_SEQPLAYER_COMMON);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_MUSHROOM);
}

void Player__Action_TripleGrindRailStartSpring(Player *player, GameObjectTask *tripleGrindRailSpring, fx32 velX, fx32 velY)
{
    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

    player->objWork.groundVel  = FLOAT_TO_FX32(0.0);
    player->objWork.velocity.x = player->objWork.velocity.y = FLOAT_TO_FX32(0.0);
    Player__Action_GimmickLaunch(player, velX, velY);

    player->inputKeyDown &= PLAYER_INPUT_JUMP;
    SetTaskState(&player->objWork, Player__State_TripleGrindRailStartSpring);

    player->playerFlag |= PLAYER_FLAG_SLOWMO | PLAYER_FLAG_DISABLE_TRICK_FINISHER;
    player->slomoTimer = 0;
    player->gimmickFlag |= PLAYER_GIMMICK_2000000;
    player->gimmick.tripleGrindRailSpring.scaleSpeed = 30;
    Player__Action_StopSuperBoost(player);
    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPRING);
}

void Player__State_TripleGrindRailStartSpring(Player *work)
{
    work->inputKeyDown &= PLAYER_INPUT_JUMP;

    Player__State_Air(work);

    work->objWork.scale.x += work->gimmick.tripleGrindRailSpring.scaleSpeed;
    if (work->objWork.scale.x > FLOAT_TO_FX32(2.5))
        work->objWork.scale.x = FLOAT_TO_FX32(2.5);

    work->objWork.scale.y = work->objWork.scale.z = work->objWork.scale.x;

    if (!StageTaskStateMatches(&work->objWork, Player__State_TripleGrindRailStartSpring))
    {
        work->gimmickFlag &= ~PLAYER_GIMMICK_2000000;
        work->playerFlag &= ~PLAYER_FLAG_SLOWMO;
    }
}

void Player__Action_TripleGrindRailEndSpring(Player *player, GameObjectTask *tripleGrindRail)
{
    if (player->gimmickObj != tripleGrindRail && StageTaskStateMatches(&player->objWork, Player__State_TripleGrindRailStartSpring))
    {
        player->starComboCount = 0;
        player->gimmickFlag &= ~PLAYER_GIMMICK_ALLOW_TRICK_COMBO;
        player->gimmickObj = tripleGrindRail;
        player->objWork.displayFlag &= ~DISPLAY_FLAG_ROTATE_CAMERA_DIR;

        fx32 moveX                                       = FX_DivS32(tripleGrindRail->objWork.position.x - player->objWork.position.x, player->objWork.velocity.x);
        player->gimmick.tripleGrindRailSpring.angleSpeed = FX_DivS32(FLOAT_TO_FX32(4.0), moveX);
        player->gimmickFlag |= PLAYER_GIMMICK_2000000;
        player->gimmick.tripleGrindRailSpring.scaleSpeed = FX_DivS32(FLOAT_TO_FX32(1.5), moveX);
        player->gimmickFlag |= PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10;
        player->gimmickCamOffsetY = 80;

        SetTaskState(&player->objWork, Player__State_TripleGrindRailEndSpring);
    }
}

void Player__State_TripleGrindRailEndSpring(Player *work)
{
    if (work->gimmickObj != NULL)
    {
        work->inputKeyDown &= PLAYER_INPUT_JUMP;

        Player__State_Air(work);

        work->objWork.dir.y = ObjRoopMove16(work->objWork.dir.y, FLOAT_DEG_TO_IDX(270.0), (s16)work->gimmick.tripleGrindRailSpring.angleSpeed);

        work->objWork.scale.x += work->gimmick.tripleGrindRailSpring.scaleSpeed;
        if (work->objWork.scale.x > FLOAT_TO_FX32(2.5))
            work->objWork.scale.x = FLOAT_TO_FX32(2.5);

        work->objWork.scale.y = work->objWork.scale.z = work->objWork.scale.x;
    }
}

void Player__Gimmick_TripleGrindRail(Player *player)
{
    player->playerFlag |= PLAYER_FLAG_2000;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_RESET_FLOW | STAGE_TASK_MOVE_FLAG_DISABLE_MAP_COLLISIONS;
    Player__Action_LandOnGround(player, FLOAT_DEG_TO_IDX(0.0));

    player->objWork.velocity.x = player->objWork.velocity.y = 0;
    player->objWork.groundVel                               = 0;

    Player__ChangeAction(player, PLAYER_ACTION_GRIND2);
    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.gravityStrength = FLOAT_TO_FX32(0.328125);
    Player__Action_StopBoost(player);

    SetTaskState(&player->objWork, Player__State_TripleGrindRail);
    ObjRect__SetOnDefend(&player->colliders[0], Player__OnDefend_TripleGrindRail);
    player->gimmick.tripleGrindRail.rail = 1;

    StopPlayerSfx(player, PLAYER_SEQPLAYER_GRIND);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRIND, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GRIND);
}

void Player__State_TripleGrindRail(Player *work)
{
    Player__HandleRideTripleGrindRail(work);
}

void Player__HandleRideTripleGrindRail(Player *player)
{
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
    {
        BOOL jumped = FALSE;
        fx32 velX   = 0;

        if ((player->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
        {
            // just jumping
            jumped = TRUE;
        }
        else
        {
            if ((player->inputKeyDown & PAD_KEY_LEFT) != 0)
            {
                if (player->gimmick.tripleGrindRail.rail < 2)
                {
                    // hopping left one rail!
                    jumped = TRUE;
                    player->gimmick.tripleGrindRail.rail++;
                    velX = -FLOAT_TO_FX32(2.9697265625);
                }
            }
            else if ((player->inputKeyDown & PAD_KEY_RIGHT) != 0)
            {
                if (player->gimmick.tripleGrindRail.rail > 0)
                {
                    // hopping right one rail!
                    jumped = TRUE;
                    player->gimmick.tripleGrindRail.rail--;
                    velX = FLOAT_TO_FX32(2.9697265625);
                }
            }
        }

        if (jumped)
        {
            Player__ChangeAction(player, PLAYER_ACTION_HOMING_ATTACK);
            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

            player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;

            if (velX != 0)
            {
                // player is hopping between rails
                player->objWork.velocity.x = velX;
                player->objWork.velocity.y = -FLOAT_TO_FX32(4.921875);
            }
            else
            {
                // player is jumping
                player->objWork.velocity.x = 0;
                player->objWork.velocity.y = -FLOAT_TO_FX32(8.203125);
            }

            StopPlayerSfx(player, PLAYER_SEQPLAYER_GRIND);
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_JUMP);
        }
    }
    else
    {
        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        {
            // player has landed... put them back in the grind action!
            player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_IN_AIR;
            player->objWork.velocity.x = player->objWork.velocity.y = 0;
            Player__ChangeAction(player, PLAYER_ACTION_GRIND2);
            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_GRIND, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GRIND);
        }
        else
        {
            // wait for it...
            if (player->objWork.userTimer != 0)
            {
                player->objWork.userTimer--;
                if (player->objWork.userTimer == 0)
                    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            }
        }
    }
}

void Player__OnDefend_TripleGrindRail(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player = (Player *)rect2->parent;

    if (player->objWork.hitstopTimer != 0 || rect1->parent->objType == STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0)
    {
        Player__GiveTension(player, -PLAYER_TENSION_HURT_PENALTY);
        UpdateTensionGaugeHUD(player->tension >> 4, TRUE);
    }

    if ((rect1->hitFlag & OBS_RECT_WORK_ATTR_USER_1) != 0)
    {
        if (player->rings != 0)
        {
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RINGLOST);
            TripleGrindRailRingLoss__Create(player);
        }

        Player__Action_Die(player);
        return;
    }

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0 && player->rings == 0)
    {
        Player__Action_Die(player);
        return;
    }

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0)
    {
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RINGLOST);
        TripleGrindRailRingLoss__Create(player);
    }

    player->playerFlag &= ~(PLAYER_FLAG_SHIELD_MAGNET | PLAYER_FLAG_SHIELD_REGULAR);
    ShakeScreen(SCREENSHAKE_MEDIUM_SHORT);

    player->objWork.shakeTimer    = 8;
    player->blinkTimer            = player->hurtInvulnDuration;
    player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;

    switch (player->characterID)
    {
        // case CHARACTER_SONIC:
        default:
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_OWA);
            break;

        case CHARACTER_BLAZE:
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_UPS);
            break;
    }
}

NONMATCH_FUNC void Player__Func_201DD24(Player *player)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	ldr r1, [r0, #0x5d8]
	bic r1, r1, #0x2000
	str r1, [r0, #0x5d8]
	ldr r1, [r0, #0x5dc]
	bic r1, r1, #0x10
	str r1, [r0, #0x5dc]
	ldr r1, [r0, #0x5d8]
	orr r1, r1, #0x200000
	str r1, [r0, #0x5d8]
	ldr r1, [r0, #0x1c]
	orr r1, r1, #0x2080
	str r1, [r0, #0x1c]
	tst r1, #1
	bne _0201DD88
	ldr r1, [r0, #0x6d8]
	cmp r1, #0
	beq _0201DD88
	ldr r3, [r1, #0x44]
	ldr r1, =0x00141BB2
	ldr r2, [r0, #0x44]
	add r1, r3, r1
	sub r1, r1, r2
	str r1, [r0, #0x6f0]
	b _0201DDB4
_0201DD88:
	ldr r4, [r0, #0x6f0]
	ldr r1, =0x00059184
	ldr r2, =0x000E8A2E
	mov r3, #0
	mla r1, r4, r1, r2
	str r1, [r0, #0x6f0]
	ldr r1, [r0, #0x1c]
	bic r1, r1, #0x10
	str r1, [r0, #0x1c]
	str r3, [r0, #0x9c]
	str r3, [r0, #0x98]
_0201DDB4:
	mov r1, #0
	str r1, [r0, #0x6f4]
	ldr ip, [r0, #0x6f0]
	ldr r2, =0x0000647A
	mov r3, ip, asr #0x1f
	umull r4, lr, ip, r2
	mla lr, ip, r1, lr
	adds r4, r4, #0x800
	mla lr, r3, r2, lr
	adc r2, lr, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r2, lsl #20
	mov r3, r3, asr #2
	ldr ip, =0x66666667
	mov r2, r3, lsr #0x1f
	smull r3, r4, ip, r3
	add r4, r2, r4, asr #4
	str r4, [r0, #0x6f8]
	ldr r2, =Player__State_201DE24
	str r1, [r0, #0x28]
	str r2, [r0, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Player__State_201DE24(Player *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	ldr r0, [r7, #0x6d8]
	mov r4, #0
	cmp r0, #0
	ldrne r1, [r0, #0x44]
	ldrne r0, =0x00141BB2
	addne r4, r1, r0
	ldr r0, [r7, #0x6f4]
	cmp r0, #0
	beq _0201DE6C
	cmp r0, #1
	beq _0201E0C4
	cmp r0, #2
	beq _0201E108
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0201DE6C:
	ldr r0, [r7, #0x44]
	str r0, [r7, #0x8c]
	ldr r0, [r7, #0x48]
	str r0, [r7, #0x90]
	ldr r0, [r7, #0x4c]
	str r0, [r7, #0x94]
	ldr r1, [r7, #0x1c]
	tst r1, #1
	beq _0201DEF8
	add r0, r7, #0x500
	ldrsh r0, [r0, #0xd4]
	cmp r0, #0x28
	beq _0201DF34
	bic r0, r1, #0x10
	str r0, [r7, #0x1c]
	mov r1, #0
	str r1, [r7, #0x9c]
	str r1, [r7, #0x98]
	mov r0, r7
	mov r1, #0x28
	bl Player__ChangeAction
	ldr r0, [r7, #0x20]
	mov r5, #0x37
	orr r2, r0, #4
	sub r1, r5, #0x38
	add r0, r7, #0x258
	str r2, [r7, #0x20]
	mov r2, #0
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	str r5, [sp, #4]
	bl PlaySfxEx
	b _0201DF34
_0201DEF8:
	ldr r1, [r7, #0x98]
	cmp r1, #0
	ldreq r0, [r7, #0x9c]
	cmpeq r0, #0
	beq _0201DF34
	ldr r0, [r7, #0x6f0]
	sub r0, r0, r1
	str r0, [r7, #0x6f0]
	ldr r1, [r7, #0x9c]
	ldr r0, [r7, #0xd8]
	add r1, r1, r0
	str r1, [r7, #0x9c]
	ldr r0, [r7, #0x48]
	add r0, r0, r1
	str r0, [r7, #0x48]
_0201DF34:
	ldrh r5, [r7, #0x32]
	ldr r6, [r7, #0x6f0]
	ldr r2, =0x00000199
	mov r0, r5
	mov r1, #0
	bl ObjRoopMove16
	strh r0, [r7, #0x32]
	ldrh r1, [r7, #0x32]
	ldr r2, =FX_SinCosTable_
	mov r0, r6, asr #0x1f
	add r1, r1, #0x4000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	add r1, r1, #0x8000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r3, r1, #1
	mov r3, r3, lsl #1
	ldrsh r2, [r2, r3]
	smull ip, r3, r2, r6
	adds ip, ip, #0x800
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r4, r3
	str r2, [r7, #0x44]
	ldrh r3, [r7, #0x32]
	sub r2, r5, r3
	mov r2, r2, lsl #0x10
	movs r4, r2, asr #0x10
	ldr r2, =0x00000199
	rsbmi r4, r4, #0
	cmp r4, r2
	bge _0201E03C
	mov r3, r3, lsl #0x10
	mov r2, r5, lsl #0x10
	mov r3, r3, asr #0x10
	rsbs r4, r3, r2, asr #16
	ldr r2, =0x0000C199
	rsbmi r4, r4, #0
	sub r2, r2, r4
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	ldr r3, =FX_SinCosTable_
	mov r2, r2, lsl #1
	ldrsh r2, [r3, r2]
	ldr r5, [r7, #0x44]
	umull r4, r3, r2, r6
	mla r3, r2, r0, r3
	mov r2, r2, asr #0x1f
	mla r3, r2, r6, r3
	adds r4, r4, #0x800
	adc r2, r3, #0
	mov r3, r4, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r5, r3
	str r2, [r7, #0x44]
_0201E03C:
	ldr r2, =FX_SinCosTable_
	mov r1, r1, lsl #1
	ldrsh r1, [r2, r1]
	umull r3, r2, r1, r6
	mla r2, r1, r0, r2
	mov r0, r1, asr #0x1f
	adds r1, r3, #0x800
	mla r2, r0, r6, r2
	adc r0, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	rsb r0, r1, #0
	str r0, [r7, #0x2c]
	ldr r1, [r7, #0x44]
	ldr r0, [r7, #0x8c]
	sub r0, r1, r0
	str r0, [r7, #0xbc]
	ldr r1, [r7, #0x48]
	ldr r0, [r7, #0x90]
	sub r0, r1, r0
	str r0, [r7, #0xc0]
	ldr r1, [r7, #0x4c]
	ldr r0, [r7, #0x94]
	sub r0, r1, r0
	str r0, [r7, #0xc4]
	ldrh r0, [r7, #0x32]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r7, #0x6f4]
	add sp, sp, #8
	add r0, r0, #1
	str r0, [r7, #0x6f4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0201E0C4:
	ldr r0, [r7, #0x1c]
	add r2, r4, #0x12c000
	bic r0, r0, #0x2080
	str r0, [r7, #0x1c]
	ldr r0, [r7, #0x20]
	orr r0, r0, #0x200
	str r0, [r7, #0x20]
	ldr r1, [r7, #0x6f8]
	str r1, [r7, #0x98]
	ldr r0, [r7, #0x44]
	sub r0, r2, r0
	bl FX_DivS32
	add r0, r0, #0x78
	str r0, [r7, #0x28]
	ldr r0, [r7, #0x6f4]
	add r0, r0, #1
	str r0, [r7, #0x6f4]
_0201E108:
	ldr r1, [r7, #0x44]
	add r0, r4, #0x12c000
	cmp r1, r0
	addlt sp, sp, #8
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r7
	bl Player__InitPhysics
	ldr r1, [r7, #0x1c]
	ldr r0, =0xEFFFEFFF
	add r3, r7, #0x258
	and r0, r1, r0
	orr r0, r0, #0x80
	str r0, [r7, #0x1c]
	ldr r0, [r7, #0x5d8]
	add r2, r7, #0x600
	bic r0, r0, #0x380000
	str r0, [r7, #0x5d8]
	ldr r0, [r7, #0x5dc]
	mov r1, #0
	bic r0, r0, #0x20
	str r0, [r7, #0x5dc]
	strh r1, [r2, #0xde]
	mov r4, #0x1e
	add r0, r3, #0x400
	strh r4, [r2, #0x98]
	bl NNS_SndPlayerStopSeq
	ldr r1, =0x000038E3
	ldr r2, =0xFFFEEEF0
	mov r0, r7
	bl Player__Action_Spring
	add r0, r7, #0x500
	mov r2, #0x5a
	ldr r1, =0x00000611
	strh r2, [r0, #0xfa]
	str r1, [r7, #0xd8]
	ldr r0, [r7, #0x5dc]
	ldr r1, =Player__OnDefend_Regular
	bic r0, r0, #0x2000000
	str r0, [r7, #0x5dc]
	mov r0, #0x1000
	str r1, [r7, #0x534]
	bl SetStageRingScale
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

void Player__Gimmick_WaterRun(Player *player)
{
    if (!StageTaskStateMatches(&player->objWork, Player__State_WaterRun) && (player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) == 0)
    {
        Player__InitGimmick(player, FALSE);
        Player__HandleStartWalkAnimation(player);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

        player->objWork.position.y = FX32_FROM_WHOLE(mapCamera.camera[player->cameraID].waterLevel - 15);
        SetTaskState(&player->objWork, Player__State_WaterRun);
        player->trickCooldownTimer = 8;

        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_WATER_RUN);
    }
}

NONMATCH_FUNC void Player__State_WaterRun(Player *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0xc8]
	ldr r0, [r4, #0x648]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r1, r0
	bge _0201E304
	mov r0, r4
	bl Player__HandleFallOffSurface
	cmp r0, #0
	beq _0201E304
	add r0, r4, #0x254
	add r0, r0, #0x400
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	strh r0, [r4, #0x34]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	bl Player__Action_Launch
	ldmia sp!, {r4, pc}
_0201E304:
	add r0, r4, #0x700
	ldrh r0, [r0, #0x22]
	tst r0, #3
	ldrne r0, [r4, #0x5f0]
	cmpne r0, #0
	beq _0201E350
	add r0, r4, #0x254
	add r0, r0, #0x400
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, #0
	strh r0, [r4, #0x34]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x5f0]
	blx r1
	ldmia sp!, {r4, pc}
_0201E350:
	add r0, r4, #0x500
	ldrsh r1, [r0, #0xd6]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xd6]
	bne _0201E3BC
	ldr r0, [r4, #0x1c]
	tst r0, #0xd
	beq _0201E3BC
	add r0, r4, #0x254
	add r0, r0, #0x400
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r1, #0
	strh r1, [r4, #0x34]
	ldr r2, [r4, #0x1c]
	mov r0, r4
	bic r2, r2, #0x2000
	orr r2, r2, #0x80
	str r2, [r4, #0x1c]
	ldr r2, [r4, #0xc8]
	str r2, [r4, #0x98]
	bl Player__Action_LandOnGround
	ldr r1, [r4, #0x5e4]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
_0201E3BC:
	ldr r1, [r4, #0xc8]
	mov r0, r4
	bl Player__SetAnimSpeedFromVelocity
	mov r0, r4
	bl Player__HandleActiveWalkAnimation
	mov r0, r4
	bl Player__HandleGroundMovement
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #7
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl CreateEffectWaterWakeForPlayer
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Player__Action_SteamFan(Player *player, GameObjectTask *other, s32 fanRadius)
{
    if (player->gimmickObj != other)
    {
        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) != 0)
        {
            player->objWork.groundVel = FX_Sqrt(MT_SQUARED(player->objWork.velocity.x >> 6) + MT_SQUARED(player->objWork.velocity.y >> 6));
        }
        else
        {
            player->objWork.groundVel = MATH_ABS(player->objWork.groundVel);
        }

        player->objWork.velocity.x = FLOAT_TO_FX32(0.5);

        Player__InitPhysics(player);
        Player__InitGimmick(player, FALSE);
        player->gimmickObj = other;
        if (player->actionState != PLAYER_ACTION_STEAM_FAN)
        {
            Player__ChangeAction(player, PLAYER_ACTION_STEAM_FAN);
            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        }
        SetTaskState(&player->objWork, Player__State_SteamFan);
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_4000 | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
        player->gimmickFlag |= PLAYER_GIMMICK_GRABBED;
        player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;

        player->objWork.velocity.y = player->objWork.velocity.z = FLOAT_TO_FX32(0.0);

        player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

        player->gimmick.steamFan.radius      = FX_Sqrt(SquaredFX(player->gimmickObj->objWork.position.x - player->objWork.position.x)
                                                       + SquaredFX(player->gimmickObj->objWork.position.y - player->objWork.position.y));
        player->gimmick.steamFan.launchForce = fanRadius;
    }
}

void Player__State_SteamFan(Player *work)
{
    if (work->gimmickObj == NULL || (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
    {
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_4000 | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        work->gimmickFlag &= ~PLAYER_GIMMICK_GRABBED;
        work->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;

        work->objWork.dir.z      = FLOAT_DEG_TO_IDX(0.0);
        work->objWork.velocity.x = work->objWork.groundVel = FLOAT_TO_FX32(0.0);
        work->actionJump(work);
        work->playerFlag |= PLAYER_FLAG_USER_FLAG;

        if (work->gimmickObj != NULL)
        {
            u16 angle = FX_Atan2Idx(work->objWork.position.y - work->gimmickObj->objWork.position.y, work->objWork.position.x - work->gimmickObj->objWork.position.x);

            work->objWork.velocity.x = MultiplyFX(CosFX((s32)angle), work->gimmick.steamFan.launchForce);
            work->objWork.velocity.y = MultiplyFX(SinFX((s32)angle), work->gimmick.steamFan.launchForce);

            if (work->objWork.velocity.x >= FLOAT_TO_FX32(0.0))
                work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            else
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        }

        work->overSpeedLimitTimer = 30;
        work->gimmickObj          = NULL;
    }
    else
    {
        u16 angle = work->gimmickObj->objWork.dir.z;

        fx32 radius;
        if (work->objWork.groundVel != FLOAT_TO_FX32(0.0))
        {
            work->gimmick.steamFan.radius = ObjSpdDownSet(work->gimmick.steamFan.radius, work->objWork.groundVel);
            radius                        = work->gimmick.steamFan.radius;

            work->objWork.groundVel -= (work->objWork.groundVel >> 3);
            if (work->objWork.groundVel < FLOAT_TO_FX32(0.125) || !work->gimmick.steamFan.radius)
                work->objWork.groundVel = FLOAT_TO_FX32(0.0);
        }
        else
        {
            if (work->gimmick.steamFan.radius > FLOAT_TO_FX32(40.0))
            {
                radius                        = MATH_MAX(work->gimmick.steamFan.radius - work->objWork.velocity.x, FLOAT_TO_FX32(40.0));
                work->gimmick.steamFan.radius = radius;
                work->objWork.velocity.x      = ObjSpdUpSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(2.0));
            }
            else if (work->gimmick.steamFan.radius < FLOAT_TO_FX32(40.0))
            {
                radius                        = MATH_MIN(work->gimmick.steamFan.radius + work->objWork.velocity.x, FLOAT_TO_FX32(40.0));
                work->gimmick.steamFan.radius = radius;
                work->objWork.velocity.x      = ObjSpdUpSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.0625), FLOAT_TO_FX32(2.5));
            }
            else
            {
                radius = FLOAT_TO_FX32(40.0);
            }
        }

        work->objWork.position.x = work->gimmickObj->objWork.position.x + MultiplyFX(CosFX((s32)angle), radius);
        work->objWork.position.y = work->gimmickObj->objWork.position.y + MultiplyFX(SinFX((s32)angle), radius);

        work->objWork.prevPosition.x = work->objWork.position.x;
        work->objWork.prevPosition.y = work->objWork.position.y;

        work->objWork.move.x = work->objWork.position.x - work->objWork.prevPosition.x;
        work->objWork.move.y = work->objWork.position.y - work->objWork.prevPosition.y;
        work->objWork.move.z = work->objWork.position.z - work->objWork.prevPosition.z;
    }
}

void Player__Action_PopSteam(Player *player, GameObjectTask *other, fx32 velX, fx32 velY, fx32 speedThreshold, BOOL allowTricks)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0)
    {
        Player__InitPhysics(player);
        Player__InitGimmick(player, TRUE);

        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR);
        player->objWork.velocity.x = velX;
        player->objWork.velocity.y = velY;

        if (velX != FLOAT_TO_FX32(0.0))
        {
            player->objWork.position.y = other->objWork.position.y;
            Player__ChangeAction(player, PLAYER_ACTION_AIRFORWARD_01);

            if (player->objWork.velocity.x < FLOAT_TO_FX32(0.0))
            {
                if (player->objWork.groundVel > FLOAT_TO_FX32(0.0))
                    player->objWork.groundVel = FLOAT_TO_FX32(0.0);

                player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            }
            else
            {
                if (player->objWork.groundVel < FLOAT_TO_FX32(0.0))
                    player->objWork.groundVel = FLOAT_TO_FX32(0.0);

                player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            }
        }
        else
        {
            player->objWork.position.x = other->objWork.position.x;
            Player__ChangeAction(player, PLAYER_ACTION_AIRRISE);
            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            if (player->objWork.velocity.y > FLOAT_TO_FX32(0.0))
                player->objWork.dir.z = FLOAT_DEG_TO_IDX(180.0);
        }

        ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);;
        player->gimmick.popSteam.threshold   = speedThreshold;
        player->gimmick.popSteam.x           = other->objWork.position.x;
        player->gimmick.popSteam.y           = other->objWork.position.y;
        player->gimmick.popSteam.allowTricks = allowTricks;

        velX = MATH_ABS(velX);
        velY = MATH_ABS(velY);

        if (velX >= velY)
            velX = velY;

        player->objWork.userTimer = velX;

        SetTaskState(&player->objWork, Player__State_PopSteam);
    }
}

void Player__State_PopSteam(Player *work)
{
    if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0 || work->objWork.userTimer >= MATH_ABS(work->objWork.velocity.x) + MATH_ABS(work->objWork.velocity.y))
    {
        Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
        work->starComboCount = 0;
        work->actionGroundIdle(work);
    }
    else
    {
        fx32 x = MATH_ABS(work->objWork.position.x - work->gimmick.popSteam.x);
        fx32 y = MATH_ABS(work->objWork.position.y - work->gimmick.popSteam.y);
        if (work->gimmick.popSteam.threshold * FX32_TO_WHOLE(work->gimmick.popSteam.threshold) <= x * FX32_TO_WHOLE(x) + y * FX32_TO_WHOLE(y))
        {
            work->gimmick.popSteam.x = work->gimmick.popSteam.y = 0;
            work->gimmick.popSteam.threshold                    = 0;
            work->playerFlag &= ~(PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG);
            work->playerFlag |= PLAYER_FLAG_USER_FLAG;

            if (work->gimmick.popSteam.allowTricks != 0)
                work->playerFlag |= PLAYER_FLAG_ALLOW_TRICKS;

            work->objWork.userTimer  = 0;
            work->objWork.userWork   = 0;
            work->trickCooldownTimer = FLOAT_TO_FX32(0.0);
            if (work->objWork.velocity.x != FLOAT_TO_FX32(0.0))
            {
                work->overSpeedLimitTimer = 30;
                work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            }
            else
            {
                work->objWork.userTimer = 30;
            }

            SetTaskState(&work->objWork, Player__State_Air);
        }
    }
}

void Player__Action_DreamWing(Player *player, GameObjectTask *other, fx32 velX, fx32 velY, s32 burstDelay)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0)
    {
        Player__InitPhysics(player);
        Player__InitGimmick(player, FALSE);
        Player__ChangeAction(player, PLAYER_ACTION_DREAMWING);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        player->gimmickObj = other;
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;

        player->objWork.dir.z               = FLOAT_DEG_TO_IDX(0.0);
        player->gimmick.dreamWing.startVelX = player->objWork.groundVel;

        player->objWork.velocity.x = velX;
        player->objWork.velocity.y = velY;
        player->objWork.groundVel  = FLOAT_TO_FX32(0.0);

        player->gimmick.dreamWing.topSpeedY = -velY;
        if (velY <= FLOAT_TO_FX32(0.0))
            player->gimmick.dreamWing.topSpeedY = FLOAT_TO_FX32(2.0);

        player->objWork.position.x             = other->objWork.position.x;
        player->objWork.position.y             = other->objWork.position.y + FLOAT_TO_FX32(16.0);
        player->gimmick.dreamWing.burstTimer   = burstDelay;
        player->gimmick.dreamWing.exhaustTimer = 0;
        player->objWork.userFlag               = DREAMWING_PLAYERFLAG_NONE;

        if ((other->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        else
            player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

        ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);;
        player->objWork.userTimer = 8;
        player->objWork.userWork  = 0;
        SetTaskState(&player->objWork, Player__State_DreamWing);
        EffectButtonPrompt__Create(&player->objWork, 0);
    }
}

void Player__State_DreamWing(Player *work)
{
    if (work->gimmickObj == NULL)
    {
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS);
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
        work->objWork.groundVel = work->gimmick.dreamWing.startVelX;
        Player__Action_Launch(work);
        return;
    }

    if (work->objWork.userTimer != 0)
    {
        work->objWork.userTimer--;
        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_ANY;
        if (work->objWork.userTimer == 0)
            work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS;
    }
    else
    {
        if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        {
            work->objWork.groundVel = work->gimmick.dreamWing.startVelX;
            Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
            work->actionGroundIdle(work);
            work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS);
            work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            work->gimmickObj = NULL;
            return;
        }

        if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0
            || (work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_CEILING) != 0 && work->objWork.move.y <= -FLOAT_TO_FX32(1.0)
            || (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
        {
            work->objWork.groundVel = work->gimmick.dreamWing.startVelX;
            Player__Action_Launch(work);
            work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS);
            work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            work->gimmickObj = NULL;
            return;
        }
    }

    if ((work->inputKeyPress & PAD_KEY_UP) != 0)
        work->objWork.userWork++;

    if (work->gimmick.dreamWing.burstTimer != 0)
    {
        work->gimmick.dreamWing.burstTimer--;
        if (work->gimmick.dreamWing.burstTimer == 0)
            work->objWork.userFlag |= DREAMWING_PLAYERFLAG_ALLOW_GRAVITY;
    }
    else if ((work->objWork.userFlag & DREAMWING_PLAYERFLAG_ALLOW_GRAVITY) != 0)
    {
        work->objWork.velocity.y += FLOAT_TO_FX32(0.1640625);
        if (work->objWork.velocity.y >= work->gimmick.dreamWing.topSpeedY)
        {
            work->objWork.userFlag &= ~DREAMWING_PLAYERFLAG_ALLOW_GRAVITY;
            work->objWork.velocity.y = work->gimmick.dreamWing.topSpeedY;
        }
    }

    if ((work->inputKeyPress & PAD_KEY_UP) != 0)
    {
        work->objWork.userWork++;
        work->objWork.userFlag |= DREAMWING_PLAYERFLAG_EXHAUST_ACTIVE;
        work->gimmick.dreamWing.exhaustTimer = 15;
        work->objWork.velocity.y             = -FLOAT_TO_FX32(5.0);
        work->objWork.userFlag &= ~DREAMWING_PLAYERFLAG_ALLOW_GRAVITY;
        work->gimmick.dreamWing.burstTimer = 15;
    }

    if (work->gimmick.dreamWing.exhaustTimer != 0)
    {
        work->gimmick.dreamWing.exhaustTimer--;
        if (work->gimmick.dreamWing.exhaustTimer == 0)
            work->objWork.userFlag &= ~DREAMWING_PLAYERFLAG_EXHAUST_ACTIVE;
    }
}

void Player__Action_LargePiston1(Player *player, GameObjectTask *other, fx32 velX, fx32 velY, fx32 velZ, fx32 delay)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0)
    {
        Player__InitPhysics(player);

        if (player->actionState >= PLAYER_ACTION_TRICK_FINISH_V_01 && player->actionState <= PLAYER_ACTION_TRICK_FINISH)
        {
            Player__InitGimmick(player, TRUE);
            Player__ChangeAction(player, PLAYER_ACTION_AIRRISE);
            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

            if (velX > FLOAT_TO_FX32(0.0))
                player->objWork.dir.x = -FLOAT_DEG_TO_IDX(67.5);
            else
                player->objWork.dir.x = -FLOAT_DEG_TO_IDX(112.5);
            player->objWork.dir.y = FLOAT_DEG_TO_IDX(22.5);
            player->objWork.dir.z = FLOAT_DEG_TO_IDX(90.0);
        }
        else
        {
            Player__InitGimmick(player, FALSE);
            Player__ChangeAction(player, PLAYER_ACTION_PISTON_01);

            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            player->objWork.dir.x = FLOAT_DEG_TO_IDX(0.0);

            if (velX > FLOAT_TO_FX32(0.0))
                player->objWork.dir.y = -FLOAT_DEG_TO_IDX(22.5);
            else
                player->objWork.dir.y = FLOAT_DEG_TO_IDX(22.5);

            if (velY != FLOAT_TO_FX32(0.0))
                player->objWork.dir.z = FLOAT_DEG_TO_IDX(45.0);
            else
                player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
        }

        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES);

        player->gimmickFlag |= PLAYER_GIMMICK_4000000 | PLAYER_GIMMICK_GRABBED;
        player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;

        if (velX > FLOAT_TO_FX32(0.0))
            player->gimmickCamGimmickCenterOffsetX = 64;
        else
            player->gimmickCamGimmickCenterOffsetX = -64;

        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
        ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);;

        player->objWork.position.x = other->objWork.position.x;
        player->objWork.position.y = other->objWork.position.y;
        player->objWork.position.z = FLOAT_TO_FX32(0.0);

        player->objWork.shakeTimer   = FLOAT_TO_FX32(8.0);
        player->objWork.hitstopTimer = FLOAT_TO_FX32(8.0);
        player->objWork.velocity.x   = velX;
        player->objWork.velocity.y   = velY;
        player->objWork.velocity.z   = velZ;
        player->objWork.userTimer    = delay;
        player->trickCooldownTimer   = 0;
        player->playerFlag &= ~PLAYER_FLAG_FINISHED_TRICK_COMBO;

        SetTaskState(&player->objWork, Player__State_LargePiston1);
    }
}

void Player__State_LargePiston1(Player *work)
{
    if (work->objWork.userTimer != 0)
    {
        work->objWork.userTimer = StageTask__DecrementBySpeed(work->objWork.userTimer);
    }
    else
    {
        if (MATH_ABS(work->objWork.velocity.x) > FLOAT_TO_FX32(3.25))
        {
            work->objWork.velocity.x = ObjSpdDownSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.0625));
            if (MATH_ABS(work->objWork.velocity.x) <= FLOAT_TO_FX32(3.25))
            {
                if (work->objWork.velocity.x >= FLOAT_TO_FX32(0.0))
                    work->objWork.velocity.x = FLOAT_TO_FX32(3.25);
                else
                    work->objWork.velocity.x = -FLOAT_TO_FX32(3.25);
            }
        }
    }

    if (work->objWork.velocity.z > FLOAT_TO_FX32(5.5))
    {
        work->objWork.velocity.z = ObjSpdDownSet(work->objWork.velocity.z, FLOAT_TO_FX32(0.125));
        if (work->objWork.velocity.z <= FLOAT_TO_FX32(5.5))
            work->objWork.velocity.z = FLOAT_TO_FX32(5.5);
    }

    if (work->objWork.hitstopTimer == FLOAT_TO_FX32(0.0))
    {
        if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
            work->objWork.userWork = work->inputKeyPress;

        work->trickCooldownTimer++;
        if (work->trickCooldownTimer > 255)
            work->trickCooldownTimer = 255;

        if ((work->playerFlag & PLAYER_FLAG_FINISHED_TRICK_COMBO) == 0)
        {
            if (work->trickCooldownTimer > 24
                || (work->actionState < PLAYER_ACTION_TRICK_FINISH_H_01 || work->actionState > PLAYER_ACTION_TRICK_FINISH)
                       && (work->actionState < PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_01 || work->actionState > PLAYER_ACTION_TRICK_FINISH_SNOWBOARD))
            {
                if (work->objWork.userWork != PAD_INPUT_FLAG_NONE)
                    Player__PerformTrick(work);
            }
        }
    }
    if (work->objWork.position.z >= FLOAT_TO_FX32(156.0))
    {
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
        work->gimmickFlag &= ~(PLAYER_GIMMICK_GRABBED | PLAYER_GIMMICK_4000000);
        work->playerFlag &= PLAYER_FLAG_DISABLE_TENSION_DRAIN;

        work->gimmickCamGimmickCenterOffsetX = 0;
        work->objWork.velocity.z             = FLOAT_TO_FX32(0.0);
        work->objWork.dir.y                  = FLOAT_DEG_TO_IDX(0.0);

        Player__Action_Launch(work);
    }
}

void Player__Action_LargePiston2(Player *player, GameObjectTask *other, fx32 velX, fx32 velY, fx32 velZ, fx32 delay)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0 && StageTaskStateMatches(&player->objWork, Player__State_LargePiston1))
    {
        ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);;

        if (player->actionState >= PLAYER_ACTION_TRICK_FINISH_V_01 && player->actionState <= PLAYER_ACTION_TRICK_FINISH)
        {
            Player__ChangeAction(player, PLAYER_ACTION_AIRRISE);
            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

            if (velY != FLOAT_TO_FX32(0.0))
            {
                player->objWork.dir.x = FLOAT_DEG_TO_IDX(0.0);

                if (velX >= FLOAT_TO_FX32(0.0))
                {
                    player->objWork.dir.y = FLOAT_DEG_TO_IDX(45.0);
                    player->objWork.dir.z = FLOAT_DEG_TO_IDX(67.5);
                }
                else
                {
                    player->objWork.dir.y = FLOAT_DEG_TO_IDX(135.0);
                    player->objWork.dir.z = -FLOAT_DEG_TO_IDX(67.5);
                }
            }
            else
            {
                player->objWork.dir.x = FLOAT_DEG_TO_IDX(45.0);
                player->objWork.dir.y = FLOAT_DEG_TO_IDX(45.0);
                player->objWork.dir.z = FLOAT_DEG_TO_IDX(67.5);
            }
        }
        else
        {
            player->starComboCount = 0;
            player->gimmickFlag &= ~PLAYER_GIMMICK_ALLOW_TRICK_COMBO;

            Player__ChangeAction(player, PLAYER_ACTION_PISTON_02);
            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

            player->objWork.dir.x = FLOAT_DEG_TO_IDX(0.0);

            if (velX >= FLOAT_TO_FX32(0.0))
                player->objWork.dir.y = FLOAT_DEG_TO_IDX(22.5);
            else
                player->objWork.dir.y = -FLOAT_DEG_TO_IDX(22.5);

            if (velY != FLOAT_TO_FX32(0.0))
                player->objWork.dir.z = FLOAT_DEG_TO_IDX(45.0);
            else
                player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
        }

        player->objWork.shakeTimer   = FLOAT_TO_FX32(8.0);
        player->objWork.hitstopTimer = FLOAT_TO_FX32(8.0);

        player->objWork.velocity.x = velX;
        player->objWork.velocity.y = velY;
        player->objWork.velocity.z = velZ;
        player->objWork.userTimer  = delay;
        player->trickCooldownTimer = 0;
        player->playerFlag &= ~PLAYER_FLAG_FINISHED_TRICK_COMBO;

        SetTaskState(&player->objWork, Player__State_LargePiston2);
    }
}

void Player__State_LargePiston2(Player *work)
{
    if (work->objWork.hitstopTimer == FLOAT_TO_FX32(0.0))
    {
        if (work->objWork.userTimer != 0)
        {
            work->objWork.userTimer = StageTask__DecrementBySpeed(work->objWork.userTimer);
        }
        else
        {
            if (MATH_ABS(work->objWork.velocity.x) > FLOAT_TO_FX32(3.25))
            {
                work->objWork.velocity.x = ObjSpdDownSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.046875));
                if (MATH_ABS(work->objWork.velocity.x) <= FLOAT_TO_FX32(3.25))
                {
                    if (work->objWork.velocity.x >= FLOAT_TO_FX32(0.0))
                        work->objWork.velocity.x = FLOAT_TO_FX32(3.25);
                    else
                        work->objWork.velocity.x = -FLOAT_TO_FX32(3.25);
                }
            }
        }

        if (work->objWork.velocity.z < -FLOAT_TO_FX32(3.5))
        {
            work->objWork.velocity.z = ObjSpdDownSet(work->objWork.velocity.z, FLOAT_TO_FX32(0.25));
            if (work->objWork.velocity.z >= -FLOAT_TO_FX32(3.5))
                work->objWork.velocity.z = -FLOAT_TO_FX32(3.5);
        }
    }

    if (work->objWork.hitstopTimer == FLOAT_TO_FX32(0.0))
    {
        if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
            work->objWork.userWork = work->inputKeyPress;

        work->trickCooldownTimer++;
        if (work->trickCooldownTimer > 255)
            work->trickCooldownTimer = 255;

        if ((work->playerFlag & PLAYER_FLAG_FINISHED_TRICK_COMBO) == 0)
        {
            if (work->trickCooldownTimer > 24
                || (work->actionState < PLAYER_ACTION_TRICK_FINISH_H_01 || work->actionState > PLAYER_ACTION_TRICK_FINISH)
                       && (work->actionState < PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_01 || work->actionState > PLAYER_ACTION_TRICK_FINISH_SNOWBOARD))
            {
                if (work->objWork.userWork != PAD_INPUT_FLAG_NONE)
                    Player__PerformTrick(work);
            }
        }
    }

    if (work->objWork.position.z <= FLOAT_TO_FX32(0.0))
    {
        fx32 velX      = work->objWork.velocity.x;
        fx32 velY      = work->objWork.velocity.y;
        u32 playerFlag = work->playerFlag;

        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
        work->gimmickFlag &= ~(PLAYER_GIMMICK_GRABBED | PLAYER_GIMMICK_4000000);
        work->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;

        work->gimmickCamGimmickCenterOffsetX = 0;
        work->objWork.velocity.z             = FLOAT_TO_FX32(0.0);
        work->objWork.dir.y                  = FLOAT_DEG_TO_IDX(0.0);

        Player__Action_Launch(work);

        work->overSpeedLimitTimer = 64;
        work->objWork.velocity.x  = 2 * velX;
        work->objWork.velocity.y  = velY;

        if (work->objWork.velocity.x >= FLOAT_TO_FX32(0.0))
            work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
        else
            work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

        work->playerFlag |= playerFlag & PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS;
    }
}

void Player__Action_IcicleGrab(Player *player, GameObjectTask *other, s32 width)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0)
    {
        Player__InitPhysics(player);
        Player__InitGimmick(player, FALSE);
        Player__ChangeAction(player, PLAYER_ACTION_ICICLE);

        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        player->gimmickObj = other;
        player->objWork.moveFlag |= PLAYER_GIMMICK_2000 | PLAYER_GIMMICK_200 | PLAYER_GIMMICK_100 | PLAYER_GIMMICK_10;
        player->gimmickFlag |= PLAYER_GIMMICK_GRABBED | PLAYER_GIMMICK_10;
        player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;
        player->gimmickCamOffsetX = 0;
        player->objWork.dir.x = player->objWork.dir.y = player->objWork.dir.z = 0;
        player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

        ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);;

        player->gimmick.icicleGrab.width = width;
        fx32 icicleY                     = other->objWork.position.y - FLOAT_TO_FX32(256.0);

        fx32 size;
        if (player->objWork.position.y > icicleY)
            size = FX_Div(68 * (player->gimmick.icicleGrab.width - (player->objWork.position.y - icicleY)), player->gimmick.icicleGrab.width);
        else
            size = FLOAT_TO_FX32(68.0);

        if (player->objWork.position.x <= other->objWork.position.x)
        {
            player->objWork.position.x       = other->objWork.position.x - (size >> 1);
            player->gimmick.icicleGrab.angle = FLOAT_DEG_TO_IDX(0.0);
        }
        else
        {
            player->objWork.position.x       = other->objWork.position.x + (size >> 1);
            player->gimmick.icicleGrab.angle = FLOAT_DEG_TO_IDX(180.0);
        }

        player->objWork.position.z = 0;
        player->objWork.velocity.x = player->objWork.velocity.y = 0;

        SetTaskState(&player->objWork, Player__State_IcicleGrab);
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ICICLE_TURNING);
    }
}

void Player__State_IcicleGrab(Player *work)
{
    GameObjectTask *icicle = work->gimmickObj;
    if (icicle == NULL || (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
    {
        work->gimmickFlag &= ~(PLAYER_GIMMICK_10 | PLAYER_GIMMICK_GRABBED);
        work->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        work->objWork.dir.y     = FLOAT_DEG_TO_IDX(0.0);
        work->objWork.groundVel = FLOAT_TO_FX32(0.0);
        work->actionJump(work);

        work->playerFlag |= PLAYER_FLAG_USER_FLAG;
        work->objWork.velocity.y >>= 2;
        work->objWork.velocity.x = FLOAT_TO_FX32(3.0);

        if ((work->inputKeyDown & PAD_KEY_LEFT) != 0)
        {
            work->objWork.velocity.x = -work->objWork.velocity.x;
            work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        }
        work->overSpeedLimitTimer = 30;
        work->gimmickObj          = NULL;

        StopPlayerSfx(work, PLAYER_SEQPLAYER_COMMON);
        return;
    }

    work->objWork.prevPosition.x = work->objWork.position.x;
    work->objWork.prevPosition.y = work->objWork.position.y;

    work->objWork.velocity.y = ObjSpdUpSet(work->objWork.velocity.y, FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(4.0));
    work->objWork.position.y += work->objWork.velocity.y;

    fx32 icicleY = icicle->objWork.position.y - FLOAT_TO_FX32(256.0);

    fx32 size;
    if (work->objWork.position.y > icicleY)
        size = FX_Div(68 * (work->gimmick.icicleGrab.width - (work->objWork.position.y - icicleY)), work->gimmick.icicleGrab.width);
    else
        size = FLOAT_TO_FX32(68.0);

    if (size <= FLOAT_TO_FX32(2.0))
    {
        work->gimmickFlag &= ~(PLAYER_GIMMICK_10 | PLAYER_GIMMICK_GRABBED);
        work->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        work->objWork.dir.y      = FLOAT_DEG_TO_IDX(0.0);
        work->objWork.velocity.x = work->objWork.groundVel = FLOAT_TO_FX32(0.0);
        work->gimmickObj                                   = NULL;

        StopPlayerSfx(work, PLAYER_SEQPLAYER_COMMON);
        Player__Action_Launch(work);
    }
    else
    {
        work->gimmick.icicleGrab.angle += MultiplyFX(-64, (FLOAT_TO_FX32(68.0) - size)) - 128;
        work->objWork.dir.y = work->gimmick.icicleGrab.angle;

        fx32 radius              = size >> 1;
        work->objWork.position.x = icicle->objWork.position.x + MultiplyFX(radius, CosFX((s32)(u16)(s32)(work->objWork.dir.y + FLOAT_DEG_TO_IDX(180.0))));
        work->objWork.position.z = MultiplyFX(radius, SinFX((s32)(u16)(s32)(work->objWork.dir.y + FLOAT_DEG_TO_IDX(180.0))));

        work->objWork.move.x = work->objWork.position.x - work->objWork.prevPosition.x;
        work->objWork.move.y = work->objWork.position.y - work->objWork.prevPosition.y;
        work->objWork.move.z = work->objWork.position.z - work->objWork.prevPosition.z;
    }
}

void Player__Action_IceSlide(Player *player, s32 _unused)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0 && !StageTaskStateMatches(&player->objWork, Player__State_IceSlide))
    {
        Player__InitGimmick(player, FALSE);
        Player__ChangeAction(player, PLAYER_ACTION_ICE_SLIDE);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);;

        if (MATH_ABS(player->objWork.velocity.x) < MATH_ABS(player->objWork.groundVel))
            player->objWork.velocity.x = player->objWork.groundVel;

        Player__Action_LandOnGround(player, player->objWork.dir.z);

        if (player->objWork.groundVel == FLOAT_TO_FX32(0.0))
        {
            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                player->objWork.groundVel = -FLOAT_TO_FX32(1.0);
            else
                player->objWork.groundVel = FLOAT_TO_FX32(1.0);
        }
        else
        {
            player->objWork.groundVel = MATH_ABS(player->objWork.groundVel);

            if (player->objWork.groundVel < FLOAT_TO_FX32(1.0))
                player->objWork.groundVel = FLOAT_TO_FX32(1.0);

            if (player->objWork.dir.z > FLOAT_DEG_TO_IDX(22.5) && player->objWork.dir.z < FLOAT_DEG_TO_IDX(337.5))
            {
                if (player->objWork.dir.z > FLOAT_DEG_TO_IDX(180.0))
                {
                    player->objWork.velocity.x = -player->objWork.velocity.x;
                    player->objWork.groundVel  = -player->objWork.groundVel;
                    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                    {
                        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL;
                        player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                    }
                }
                else
                {
                    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    {
                        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL;
                        player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
                    }
                }
            }
            else
            {
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                {
                    player->objWork.velocity.x = -player->objWork.velocity.x;
                    player->objWork.groundVel  = -player->objWork.groundVel;
                }
            }
        }

        SetTaskState(&player->objWork, Player__State_IceSlide);
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ICELAND);
    }
}

void Player__State_IceSlide(Player *player)
{
    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0)
        player->objWork.displayFlag ^= DISPLAY_FLAG_FLIP_X;

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0)
    {
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION;

        player->objWork.velocity.x = MultiplyFX(player->objWork.groundVel, CosFX(player->objWork.dir.z));
        player->objWork.velocity.y = MultiplyFX(player->objWork.groundVel, SinFX(player->objWork.dir.z));

        if (player->objWork.velocity.x > -FLOAT_TO_FX32(2.0) && player->objWork.velocity.x < FLOAT_TO_FX32(2.0))
        {
            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                player->objWork.velocity.x = -FLOAT_TO_FX32(2.0);
            else
                player->objWork.velocity.x = FLOAT_TO_FX32(2.0);
        }

        player->gimmick.iceSlide.spinSpeed = FLOAT_TO_FX32(0.625);
        Player__ChangeAction(player, PLAYER_ACTION_JUMPFALL);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        SetTaskState(&player->objWork, Player__State_IceSlideLaunch);
        StopPlayerSfx(player, PLAYER_SEQPLAYER_COMMON);
    }

    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        player->objWork.groundVel = ObjSpdUpSet(player->objWork.groundVel, -FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(8.0));
    else
        player->objWork.groundVel = ObjSpdUpSet(player->objWork.groundVel, FLOAT_TO_FX32(0.5), FLOAT_TO_FX32(8.0));
}

void Player__State_IceSlideLaunch(Player *work)
{
    if ((work->inputKeyPress & (PAD_BUTTON_A | PAD_BUTTON_B | PAD_BUTTON_R)) != 0)
    {
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION;
        work->playerFlag |= PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG;
        SetTaskState(&work->objWork, Player__State_Air);
        work->objWork.userTimer  = 0;
        work->objWork.userWork   = 0;
        work->trickCooldownTimer = 0;
        work->objWork.dir.z      = FLOAT_DEG_TO_IDX(0.0);

        if ((work->inputKeyPress & PAD_BUTTON_R) != 0)
        {
            if ((work->inputKeyDown & PAD_KEY_UP) != 0)
            {
                Player__Action_TrickFinisherVertical(work);
            }
            else
            {
                if ((work->inputKeyDown & PAD_KEY_RIGHT) != 0)
                {
                    work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
                }
                else if ((work->inputKeyDown & PAD_KEY_LEFT) != 0)
                {
                    work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                }
                Player__Action_TrickFinisherHorizontal(work);
            }
        }
        else
        {
            Player__PerformTrick(work);
        }
    }
    else if (work->objWork.move.y > FLOAT_TO_FX32(2.0) && (work->objWork.dir.z < FLOAT_DEG_TO_IDX(22.5) || work->objWork.dir.z > FLOAT_DEG_TO_IDX(337.5)))
    {
        work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES;
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION;
        work->objWork.dir.z     = FLOAT_DEG_TO_IDX(0.0);
        work->objWork.groundVel = FLOAT_TO_FX32(0.0);

        fx32 velX = work->objWork.velocity.x;
        fx32 velY = work->objWork.velocity.y;
        Player__Action_Launch(work);
        work->objWork.velocity.x = velX;
        work->objWork.velocity.y = velY;
    }
    else
    {
        if ((work->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
        {
            work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_USE_SLOPE_ACCELERATION;
            work->objWork.dir.z     = FLOAT_DEG_TO_IDX(0.0);
            work->objWork.groundVel = work->objWork.velocity.x;
            Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
            work->actionGroundIdle(work);
        }
        else
        {
            work->gimmick.iceSlide.spinSpeed -= FLOAT_DEG_TO_IDX(0.087890625);
            if (work->gimmick.iceSlide.spinSpeed < FLOAT_DEG_TO_IDX(5.625))
                work->gimmick.iceSlide.spinSpeed = FLOAT_DEG_TO_IDX(5.625);

            fx32 spinSpeed = MultiplyFX(work->gimmick.iceSlide.spinSpeed, g_obj.speed);
            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->objWork.dir.z += (u16)spinSpeed;
            else
                work->objWork.dir.z -= (u16)spinSpeed;

            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            {
                if ((work->inputKeyDown & PAD_KEY_LEFT) != 0)
                {
                    work->objWork.velocity.x = ObjSpdUpSet(work->objWork.velocity.x, -FLOAT_TO_FX32(0.0625), FLOAT_TO_FX32(6.0));
                }
                else if ((work->inputKeyDown & PAD_KEY_RIGHT) != 0)
                {
                    work->objWork.velocity.x = ObjSpdDownSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.0625));
                }
            }
            else
            {
                if ((work->inputKeyDown & PAD_KEY_RIGHT) != 0)
                {
                    work->objWork.velocity.x = ObjSpdUpSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.0625), FLOAT_TO_FX32(6.0));
                }
                else if ((work->inputKeyDown & PAD_KEY_LEFT) != 0)
                {
                    work->objWork.velocity.x = ObjSpdDownSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.0625));
                }
            }
        }
    }
}

void Player__Action_EnableSnowboard(Player *player, s32 type)
{
    player->gimmickFlag |= PLAYER_GIMMICK_SNOWBOARD;

    switch (type)
    {
        case 0:
            Player__Action_Launch(player);
            break;

        case 1:
            player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            player->actionGroundIdle(player);
            break;
    }
}

NONMATCH_FUNC void Player__Action_LoseSnowboard(Player *player)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x5dc]
	bic r1, r1, #0x800
	str r1, [r0, #0x5dc]
	ldr r1, [r0, #0x1c]
	orr r1, r1, #0x20000
	str r1, [r0, #0x1c]
	tst r1, #1
	beq _0201FD48
	ldr r1, [r0, #0xc8]
	ldr r2, [r0, #0x98]
	cmp r2, r1
	movge r1, r2
	mov r2, #0x6000
	cmp r1, #0x4800
	movlt r1, #0x4800
	rsb r2, r2, #0
	bl Player__Action_JumpDashLaunch
	ldmia sp!, {r3, pc}
_0201FD48:
	ldr r1, [r0, #0x9c]
	cmp r1, #0
	bge _0201FD60
	mov r1, #0x19
	bl Player__ChangeAction
	ldmia sp!, {r3, pc}
_0201FD60:
	mov r1, #0x1a
	bl Player__ChangeAction
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

void Player__Action_Flipboard(Player *player, fx32 velX, fx32 velY)
{
    Player__Gimmick_201B418(player, velX, velY, TRUE);
}

void Player__Action_DiveStandStood(Player *player, GameObjectTask *other)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) == 0)
    {
        Player__InitGimmick(player, FALSE);

        if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_IN_AIR) != 0)
        {
            Player__Action_LandOnGround(player, FLOAT_DEG_TO_IDX(0.0));
            player->actionGroundIdle(player);
        }

        player->gimmickObj = other;

        if (StageTaskStateMatches(&player->objWork, Player__State_GroundIdle))
        {
            SetTaskState(&player->objWork, Player__State_DiveStand_GroundIdle);
        }
        else if (StageTaskStateMatches(&player->objWork, Player__State_GroundMove))
        {
            SetTaskState(&player->objWork, Player__State_DiveStand_GroundMove);
        }
        else if (StageTaskStateMatches(&player->objWork, Player__State_Roll))
        {
            SetTaskState(&player->objWork, Player__State_DiveStand_Roll);
        }

        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    }
}

void Player__UpdateDiveStandState(Player *player)
{
    if (StageTaskStateMatches(&player->objWork, Player__State_GroundIdle))
    {
        SetTaskState(&player->objWork, Player__State_DiveStand_GroundMove);
    }
    else if (StageTaskStateMatches(&player->objWork, Player__State_GroundMove))
    {
        SetTaskState(&player->objWork, Player__State_DiveStand_GroundIdle);
    }
    else if (StageTaskStateMatches(&player->objWork, Player__State_Roll))
    {
        SetTaskState(&player->objWork, Player__State_DiveStand_Roll);
    }
    else if (StageTaskStateMatches(&player->objWork, Player__State_Spindash))
    {
        SetTaskState(&player->objWork, Player__State_DiveStand_Spindash);
    }
    else if (StageTaskStateMatches(&player->objWork, Player__State_Crouch))
    {
        SetTaskState(&player->objWork, Player__State_DiveStand_Crouch);
    }
    else
    {
        DiveStand__Func_2169F6C((DiveStand *)player->gimmickObj);

        player->gimmickObj = NULL;
        player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
    }
}

void Player__HandleDiveStandStood(Player *player)
{
    GameObjectTask *diveStand = player->gimmickObj;

    player->objWork.move.y += (diveStand->objWork.userTimer - FLOAT_TO_FX32(13.0)) - player->objWork.position.y;
    player->objWork.position.y = diveStand->objWork.userTimer - FLOAT_TO_FX32(13.0);
}

void Player__State_DiveStand_GroundMove(Player *work)
{
    GameObjectTask *diveStand = work->gimmickObj;

    if (diveStand == NULL ||                                                                                                           // check if divestand is invalid
        diveStand->mapObject->id == MAPOBJECT_143 && work->objWork.position.x + FLOAT_TO_FX32(16.0) < diveStand->objWork.position.x || // check if player is off the divestand
        diveStand->mapObject->id == MAPOBJECT_149 && work->objWork.position.x - FLOAT_TO_FX32(16.0) > diveStand->objWork.position.x)
    {
        work->gimmickObj = NULL;
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        SetTaskState(&work->objWork, Player__State_GroundIdle);
        Player__State_GroundIdle(work);
    }
    else
    {
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        work->objWork.dir.z = work->gimmickObj->objWork.userWork;

        Player__HandleDiveStandStood(work);

        StageTaskState prevState = work->objWork.state;
        Player__State_GroundIdle(work);
        if (work->objWork.state != prevState)
            Player__UpdateDiveStandState(work);
    }
}

void Player__State_DiveStand_GroundIdle(Player *work)
{
    GameObjectTask *diveStand = work->gimmickObj;

    if (diveStand == NULL ||                                                                                                           // check if divestand is invalid
        diveStand->mapObject->id == MAPOBJECT_143 && work->objWork.position.x + FLOAT_TO_FX32(16.0) < diveStand->objWork.position.x || // check if player is off the divestand
        diveStand->mapObject->id == MAPOBJECT_149 && work->objWork.position.x - FLOAT_TO_FX32(16.0) > diveStand->objWork.position.x)
    {
        work->gimmickObj = NULL;
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        SetTaskState(&work->objWork, Player__State_GroundMove);
        Player__State_GroundMove(work);
    }
    else
    {
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        work->objWork.dir.z = work->gimmickObj->objWork.userWork;

        Player__HandleDiveStandStood(work);

        StageTaskState prevState = work->objWork.state;
        Player__State_GroundMove(work);
        if (work->objWork.state != prevState)
            Player__UpdateDiveStandState(work);
    }
}

void Player__State_DiveStand_Roll(Player *work)
{
    GameObjectTask *diveStand = work->gimmickObj;

    if (diveStand == NULL ||                                                                                                           // check if divestand is invalid
        diveStand->mapObject->id == MAPOBJECT_143 && work->objWork.position.x + FLOAT_TO_FX32(16.0) < diveStand->objWork.position.x || // check if player is off the divestand
        diveStand->mapObject->id == MAPOBJECT_149 && work->objWork.position.x - FLOAT_TO_FX32(16.0) > diveStand->objWork.position.x)
    {
        work->gimmickObj = NULL;
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        SetTaskState(&work->objWork, Player__State_Roll);
        Player__State_Roll(work);
    }
    else
    {
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        work->objWork.dir.z = work->gimmickObj->objWork.userWork;

        Player__HandleDiveStandStood(work);

        StageTaskState prevState = work->objWork.state;
        Player__State_Roll(work);
        if (work->objWork.state != prevState)
            Player__UpdateDiveStandState(work);
    }
}

void Player__State_DiveStand_Spindash(Player *work)
{
    GameObjectTask *diveStand = work->gimmickObj;

    if (diveStand == NULL ||                                                                                                           // check if divestand is invalid
        diveStand->mapObject->id == MAPOBJECT_143 && work->objWork.position.x + FLOAT_TO_FX32(16.0) < diveStand->objWork.position.x || // check if player is off the divestand
        diveStand->mapObject->id == MAPOBJECT_149 && work->objWork.position.x - FLOAT_TO_FX32(16.0) > diveStand->objWork.position.x)
    {
        work->gimmickObj = NULL;
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        SetTaskState(&work->objWork, Player__State_Spindash);
        Player__State_Spindash(work);
    }
    else
    {
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        work->objWork.dir.z = work->gimmickObj->objWork.userWork;

        Player__HandleDiveStandStood(work);

        StageTaskState prevState = work->objWork.state;
        Player__State_Spindash(work);
        if (work->objWork.state != prevState)
            Player__UpdateDiveStandState(work);
    }
}

void Player__State_DiveStand_Crouch(Player *work)
{
    GameObjectTask *diveStand = work->gimmickObj;

    if (diveStand == NULL ||                                                                                                           // check if divestand is invalid
        diveStand->mapObject->id == MAPOBJECT_143 && work->objWork.position.x + FLOAT_TO_FX32(16.0) < diveStand->objWork.position.x || // check if player is off the divestand
        diveStand->mapObject->id == MAPOBJECT_149 && work->objWork.position.x - FLOAT_TO_FX32(16.0) > diveStand->objWork.position.x)
    {
        work->gimmickObj = NULL;
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        SetTaskState(&work->objWork, Player__State_Crouch);
        Player__State_Crouch(work);
    }
    else
    {
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
        work->objWork.dir.z = work->gimmickObj->objWork.userWork;

        Player__HandleDiveStandStood(work);

        StageTaskState prevState = work->objWork.state;
        Player__State_Crouch(work);
        if (work->objWork.state != prevState)
            Player__UpdateDiveStandState(work);
    }
}

void Player__Action_DiveStandGrab(Player *player, GameObjectTask *other)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) != 0)
        return;

    if (player->gimmickObj != other || StageTaskStateMatches(&player->objWork, Player__State_DiveStandGrab))
        return;

    if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
    {
        Player__ChangeAction(player, PLAYER_ACTION_DIVING_BOARD);
    }
    else
    {
        Player__ChangeAction(player, PLAYER_ACTION_DIVING_BOARD_SNOWBOARD);
        ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_DIVING_BOARD);
    }

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);;
    player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

    if (other->mapObject->id == MAPOBJECT_143)
        player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    else
        player->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    player->objWork.position.x = other->objWork.prevPosition.x;
    player->objWork.position.y = other->objWork.prevPosition.y + FLOAT_TO_FX32(2.0);

    SetTaskState(&player->objWork, Player__State_DiveStandGrab);

    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
}

void Player__State_DiveStandGrab(Player *work)
{
    GameObjectTask *diveStand = work->gimmickObj;

    if (diveStand == NULL)
    {
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        Player__Action_Launch(work);
    }
    else
    {
        work->objWork.prevPosition.x = work->objWork.position.x;
        work->objWork.prevPosition.y = work->objWork.position.y;

        work->objWork.position.x = diveStand->objWork.prevPosition.x;
        work->objWork.position.y = diveStand->objWork.prevPosition.y + FLOAT_TO_FX32(2.0);

        work->objWork.move.x = work->objWork.position.x - work->objWork.prevPosition.x;
        work->objWork.move.y = work->objWork.position.y - work->objWork.prevPosition.y;
    }
}

void Player__Action_DiveStandLaunch(Player *player, GameObjectTask *other, fx32 velX, fx32 velY)
{
    if (player->gimmickObj == other)
        player->gimmickObj = NULL;

    Player__Action_GimmickLaunch(player, velX, velY);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPRING);
}

NONMATCH_FUNC void Player__Action_EnterHalfpipe(Player *player, GameObjectTask *other, BOOL flag)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #0x5d8]
	mov r4, r2
	tst r1, #0x400
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r2, [r5, #0xf4]
	ldr r1, =Player__State_Halfpipe
	cmp r2, r1
	ldmeqia sp!, {r3, r4, r5, pc}
	bl Player__InitPhysics
	mov r0, r5
	mov r1, #0
	bl Player__InitGimmick
	mov r1, #0
	mov r2, r1
	add r0, r5, #0x550
	bl ObjRect__SetAttackStat
	ldr r0, [r5, #0x5dc]
	orr r0, r0, #0x20000
	str r0, [r5, #0x5dc]
	ldr r0, [r5, #0x5d8]
	orr r0, r0, #0x100000
	str r0, [r5, #0x5d8]
	ldr r0, [r5, #0x1c]
	orr r0, r0, #0x2300
	str r0, [r5, #0x1c]
	ldr r0, [r5, #0x48]
	str r0, [r5, #0x6f0]
	ldr r0, [r5, #0xc8]
	cmp r0, #0
	bgt _0202050C
	bne _0202052C
	ldr r0, [r5, #0x20]
	tst r0, #1
	bne _0202052C
_0202050C:
	ldr r0, [r5, #0x20]
	bic r0, r0, #1
	str r0, [r5, #0x20]
	ldr r0, [r5, #0xc8]
	cmp r0, #0x2000
	movlt r0, #0x2000
	strlt r0, [r5, #0xc8]
	b _02020558
_0202052C:
	ldr r1, [r5, #0x20]
	mov r0, #0x2000
	orr r1, r1, #1
	str r1, [r5, #0x20]
	ldr r1, [r5, #0x5d8]
	rsb r0, r0, #0
	orr r1, r1, #1
	str r1, [r5, #0x5d8]
	ldr r1, [r5, #0xc8]
	cmp r1, r0
	strgt r0, [r5, #0xc8]
_02020558:
	cmp r4, #0
	ldrne r0, [r5, #0x5d8]
	orrne r0, r0, #1
	strne r0, [r5, #0x5d8]
	ldr r1, [r5, #0xc8]
	cmp r1, #0
	rsblt r1, r1, #0
	mov r0, r1, lsl #4
	add r0, r0, r1, lsl #5
	add r0, r0, r1, lsl #2
	str r0, [r5, #0x6f4]
	ldr r1, [r5, #0xc8]
	mov r0, #0
	str r1, [r5, #0x6fc]
	str r0, [r5, #0x2c]
	mov r0, #0xc000
	str r0, [r5, #0x6f8]
	ldr r0, [r5, #0x5dc]
	tst r0, #0x800
	mov r0, r5
	bne _020205B8
	mov r1, #0x30
	bl Player__ChangeAction
	b _020205CC
_020205B8:
	mov r1, #0x41
	bl Player__ChangeAction
	mov r0, r5
	mov r1, #3
	bl ChangePlayerSnowboardAction
_020205CC:
	ldr r1, [r5, #0x20]
	ldr r0, =Player__State_Halfpipe
	orr r1, r1, #4
	str r1, [r5, #0x20]
	str r0, [r5, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Player__State_Halfpipe(Player *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	ldr r1, [r4, #0x44]
	str r1, [r4, #0x8c]
	ldr r1, [r4, #0x48]
	str r1, [r4, #0x90]
	ldr r1, [r4, #0x4c]
	str r1, [r4, #0x94]
	bl Player__Func_2020DB8
	ldr r0, [r4, #0x6fc]
	cmp r0, #0x1000
	ble _0202063C
	movs r1, r0, asr #1
	rsbmi r2, r1, #0
	ldr r3, [r4, #0xc8]
	movpl r2, r1
	cmp r3, #0
	rsblt r3, r3, #0
	cmp r3, r2
	strlt r1, [r4, #0xc8]
	blt _02020664
_0202063C:
	cmp r0, #0x4000
	ble _02020664
	movs r0, r0, lsl #1
	rsbmi r1, r0, #0
	ldr r2, [r4, #0xc8]
	movpl r1, r0
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r2, r1
	strgt r0, [r4, #0xc8]
_02020664:
	ldr r0, [r4, #0x6f8]
	add r0, r0, #0x99
	add r0, r0, #0x100
	str r0, [r4, #0x6f8]
	ldr r0, [r4, #0xc8]
	cmp r0, #0
	ble _02020694
	ldr r0, [r4, #0x44]
	add r0, r0, #0x198
	add r0, r0, #0x1800
	str r0, [r4, #0x44]
	b _020206D4
_02020694:
	bge _020206AC
	ldr r0, [r4, #0x44]
	sub r0, r0, #0x198
	sub r0, r0, #0x1800
	str r0, [r4, #0x44]
	b _020206D4
_020206AC:
	ldr r0, [r4, #0x20]
	tst r0, #1
	ldr r0, [r4, #0x44]
	addeq r0, r0, #0x198
	addeq r0, r0, #0x1800
	streq r0, [r4, #0x44]
	beq _020206D4
	sub r0, r0, #0x198
	sub r0, r0, #0x1800
	str r0, [r4, #0x44]
_020206D4:
	ldr r0, [r4, #0x6f8]
	ldr r2, [r4, #0x6f4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, asr #4
	ldr r0, =FX_SinCosTable_
	mov r1, r1, lsl #2
	ldrsh r1, [r0, r1]
	mov r5, r2, asr #1
	mov r0, #0
	smull r3, r2, r1, r5
	adds r3, r3, #0x800
	adc r1, r2, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	adds r5, r5, r2
	movmi r5, r0
	ldr r0, [r4, #0x6f0]
	sub r0, r0, r5
	str r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x8c]
	sub r0, r1, r0
	str r0, [r4, #0xbc]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x90]
	sub r0, r1, r0
	str r0, [r4, #0xc0]
	ldr r0, [r4, #0x2c]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02020AA8
_0202075C: // jump table
	b _0202076C // case 0
	b _02020818 // case 1
	b _020209AC // case 2
	b _02020A6C // case 3
_0202076C:
	cmp r5, #0x40000
	movgt r0, #0x40000
	movle r0, r5
	mov r1, #0x40000
	bl FX_Div
	bl Math__Func_207B14C
	strh r0, [r4, #0x30]
	ldr r0, [r4, #0x5d8]
	mov r1, r5
	tst r0, #1
	ldrneh r0, [r4, #0x30]
	rsbne r0, r0, #0x10000
	strneh r0, [r4, #0x30]
	mov r0, r4
	bl Player__Func_2020C00
	cmp r5, #0x80000
	blt _020207F8
	mov r0, #1
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x5dc]
	tst r0, #0x800
	beq _020207DC
	mov r0, r4
	mov r1, #0x42
	bl Player__ChangeAction
	mov r0, r4
	mov r1, #4
	bl ChangePlayerSnowboardAction
_020207DC:
	mov r1, #0
	str r1, [r4, #0x28]
	add r0, r4, #0x500
	strh r1, [r0, #0xd6]
	ldr r0, [r4, #0x5d8]
	bic r0, r0, #4
	str r0, [r4, #0x5d8]
_020207F8:
	ldr r0, [r4, #0xc0]
	cmp r0, #0
	movge r0, #2
	strge r0, [r4, #0x2c]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #1
	str r0, [r4, #0x1c]
	b _02020AA8
_02020818:
	add r0, r4, #0x700
	ldrh r0, [r0, #0x22]
	tst r0, #3
	strne r0, [r4, #0x28]
	cmp r5, #0x80000
	bgt _02020878
	mov r0, #2
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x5dc]
	tst r0, #0x800
	mov r0, r4
	bne _02020854
	mov r1, #0x30
	bl Player__ChangeAction
	b _02020868
_02020854:
	mov r1, #0x41
	bl Player__ChangeAction
	mov r0, r4
	mov r1, #3
	bl ChangePlayerSnowboardAction
_02020868:
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	b _02020990
_02020878:
	add r0, r4, #0x700
	ldrh r1, [r0, #0x22]
	ands r1, r1, #0x100
	beq _020208B4
	ldrh r0, [r0, #0x20]
	tst r0, #0x40
	beq _020208B4
	mov r0, r4
	bl Player__Action_ExitHalfpipe
	ldr r1, [r4, #0x5f0]
	mov r0, r4
	blx r1
	mov r0, r4
	bl Player__Action_TrickFinisherVertical
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020208B4:
	cmp r1, #0
	beq _020208DC
	mov r0, r4
	bl Player__Action_ExitHalfpipe
	ldr r1, [r4, #0x5f0]
	mov r0, r4
	blx r1
	mov r0, r4
	bl Player__Action_TrickFinisherHorizontal
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020208DC:
	add r0, r4, #0x500
	ldrsh r1, [r0, #0xd6]
	add r1, r1, #1
	strh r1, [r0, #0xd6]
	ldrsh r1, [r0, #0xd6]
	cmp r1, #0xff
	movgt r1, #0xff
	strgth r1, [r0, #0xd6]
	ldr r0, [r4, #0x5d8]
	tst r0, #4
	bne _02020950
	add r0, r4, #0x500
	ldrsh r1, [r0, #0xd6]
	cmp r1, #0x18
	bgt _0202093C
	ldrsh r0, [r0, #0xd4]
	cmp r0, #0x64
	blt _0202092C
	cmp r0, #0x69
	ble _02020950
_0202092C:
	cmp r0, #0x47
	blt _0202093C
	cmp r0, #0x4c
	ble _02020950
_0202093C:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02020950
	mov r0, r4
	bl Player__PerformTrick
_02020950:
	ldr r0, [r4, #0xc0]
	mov r2, #0x200
	cmp r0, #0
	bgt _02020974
	ldrh r0, [r4, #0x30]
	mov r1, #0
	bl ObjRoopMove16
	strh r0, [r4, #0x30]
	b _02020990
_02020974:
	ldr r0, [r4, #0x5d8]
	tst r0, #1
	movne r1, #0xc000
	ldrh r0, [r4, #0x30]
	moveq r1, #0x4000
	bl ObjRoopMove16
	strh r0, [r4, #0x30]
_02020990:
	mov r0, r4
	mov r1, r5
	bl Player__Func_2020C00
	ldr r0, [r4, #0x1c]
	bic r0, r0, #1
	str r0, [r4, #0x1c]
	b _02020AA8
_020209AC:
	cmp r5, #0x40000
	movgt r0, #0x40000
	movle r0, r5
	mov r1, #0x40000
	bl FX_Div
	bl Math__Func_207B14C
	strh r0, [r4, #0x30]
	ldr r0, [r4, #0x5d8]
	mov r1, r5
	tst r0, #1
	ldrneh r0, [r4, #0x30]
	rsbne r0, r0, #0x10000
	strneh r0, [r4, #0x30]
	mov r0, r4
	bl Player__Func_2020C00
	ldr r0, [r4, #0xc0]
	cmp r0, #0
	bgt _02020A5C
	ldr r0, [r4, #0xc8]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x80
	movge r0, #0
	strge r0, [r4, #0x2c]
	bge _02020A20
	mov r0, #3
	str r0, [r4, #0x2c]
	mov r0, #0
	str r0, [r4, #0xc8]
_02020A20:
	ldr r0, [r4, #0xc8]
	str r0, [r4, #0x6fc]
	ldr r0, [r4, #0x5d8]
	eor r0, r0, #1
	str r0, [r4, #0x5d8]
	ldr r1, [r4, #0xc8]
	ldr r0, [r4, #0x61c]
	cmp r1, #0
	rsblt r1, r1, #0
	cmp r1, r0
	movgt r1, r0
	mov r0, r1, lsl #4
	add r0, r0, r1, lsl #5
	add r0, r0, r1, lsl #2
	str r0, [r4, #0x6f4]
_02020A5C:
	ldr r0, [r4, #0x1c]
	orr r0, r0, #1
	str r0, [r4, #0x1c]
	b _02020AA8
_02020A6C:
	ldr r0, [r4, #0xc8]
	cmp r0, #0
	beq _02020A9C
	mov r0, #0
	str r0, [r4, #0x2c]
	ldr r1, [r4, #0xc8]
	cmp r1, #0
	rsblt r1, r1, #0
	mov r0, r1, lsl #4
	add r0, r0, r1, lsl #5
	add r0, r0, r1, lsl #2
	str r0, [r4, #0x6f4]
_02020A9C:
	ldr r0, [r4, #0x1c]
	orr r0, r0, #1
	str r0, [r4, #0x1c]
_02020AA8:
	ldr r1, [r4, #0x6f4]
	cmp r1, #0
	beq _02020BE0
	cmp r5, r1
	movge r5, #0x1000
	bge _02020AD0
	mov r0, r5
	bl FX_Div
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
_02020AD0:
	mov r0, #0
	ldr r2, [r4, #0x6f4]
	mov r3, r5, asr #0x1f
	mov r1, #2
	mov lr, r0
	mov ip, #0x800
_02020AE8:
	sub r6, r2, r0
	umull r8, r7, r6, r5
	mla r7, r6, r3, r7
	mov r6, r6, asr #0x1f
	mla r7, r6, r5, r7
	adds r8, r8, ip
	adc r6, r7, lr
	mov r7, r8, lsr #0xc
	orr r7, r7, r6, lsl #20
	cmp r1, #0
	add r0, r0, r7
	sub r1, r1, #1
	bne _02020AE8
	movs r0, r0, asr #2
	mov r0, #0
	bmi _02020BC0
	mov r1, #2
	mov lr, r0
	mov ip, #0x800
_02020B34:
	sub r6, r2, r0
	umull r8, r7, r6, r5
	mla r7, r6, r3, r7
	mov r6, r6, asr #0x1f
	mla r7, r6, r5, r7
	adds r8, r8, ip
	adc r6, r7, lr
	mov r7, r8, lsr #0xc
	orr r7, r7, r6, lsl #20
	cmp r1, #0
	add r0, r0, r7
	sub r1, r1, #1
	bne _02020B34
	mov r0, r0, asr #2
	cmp r0, #0x50000
	movgt r0, #0x50000
	bgt _02020BC0
	mov r0, #0
	mov r1, #2
	mov lr, r0
	mov ip, #0x800
_02020B88:
	sub r6, r2, r0
	umull r8, r7, r6, r5
	mla r7, r6, r3, r7
	mov r6, r6, asr #0x1f
	mla r7, r6, r5, r7
	adds r8, r8, ip
	adc r6, r7, lr
	mov r7, r8, lsr #0xc
	orr r7, r7, r6, lsl #20
	cmp r1, #0
	add r0, r0, r7
	sub r1, r1, #1
	bne _02020B88
	mov r0, r0, asr #2
_02020BC0:
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x5d8]
	tst r0, #1
	beq _02020BE8
	ldr r0, [r4, #0x4c]
	rsb r0, r0, #0
	str r0, [r4, #0x4c]
	b _02020BE8
_02020BE0:
	mov r0, #0
	str r0, [r4, #0x4c]
_02020BE8:
	ldr r1, [r4, #0x4c]
	ldr r0, [r4, #0x94]
	sub r0, r1, r0
	str r0, [r4, #0xc4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Player__Func_2020C00(Player *player, s32 a2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	ldr r0, [r4, #0x6f4]
	cmp r0, #0x40000
	movlt r0, #0
	strlth r0, [r4, #0x34]
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r1, r0, asr #1
	mov r2, r0, asr #1
	ldr r0, [r4, #0xc0]
	mov r5, #1
	bge _02020CF8
	cmp r0, #0
	mov r0, r1
	mov r1, r2
	bge _02020CA0
	bl FX_Div
	mov r0, r0, lsl #0x10
	mov r2, r0, asr #0x10
	mov r0, #0
	mov r3, #0x1000
	mov r1, r2, asr #0x1f
	rsb r3, r3, #0
	mov lr, r0
	mov ip, #0x800
_02020C64:
	sub r6, r3, r0
	umull r8, r7, r6, r2
	mla r7, r6, r1, r7
	mov r6, r6, asr #0x1f
	mla r7, r6, r2, r7
	adds r8, r8, ip
	adc r6, r7, lr
	mov r7, r8, lsr #0xc
	orr r7, r7, r6, lsl #20
	cmp r5, #0
	add r0, r0, r7
	sub r5, r5, #1
	bne _02020C64
	strh r0, [r4, #0x34]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02020CA0:
	bl FX_Div
	mov r0, r0, lsl #0x10
	mov r8, r0, asr #0x10
	mov r6, #0
	mov r7, r8, asr #0x1f
	mov r1, r6
	mov r0, #0x800
_02020CBC:
	rsb r2, r6, #0x1000
	umull ip, r3, r2, r8
	mla r3, r2, r7, r3
	mov r2, r2, asr #0x1f
	mla r3, r2, r8, r3
	adds ip, ip, r0
	adc r2, r3, r1
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	cmp r5, #0
	add r6, r6, r3
	sub r5, r5, #1
	bne _02020CBC
	strh r6, [r4, #0x34]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02020CF8:
	cmp r0, #0
	sub r0, r1, r2
	mov r1, r2
	bge _02020D60
	bl FX_Div
	mov r0, r0, lsl #0x10
	mov r7, r0, asr #0x10
	mov r2, #0
	mov r6, r7, asr #0x1f
	mov r1, r2
	mov r0, #0x800
_02020D24:
	add r2, r2, #0x1000
	umull ip, r3, r2, r7
	mla r3, r2, r6, r3
	mov r2, r2, asr #0x1f
	mla r3, r2, r7, r3
	adds ip, ip, r0
	adc r2, r3, r1
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	cmp r5, #0
	sub r2, r3, #0x1000
	sub r5, r5, #1
	bne _02020D24
	strh r2, [r4, #0x34]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02020D60:
	bl FX_Div
	mov r0, r0, lsl #0x10
	mov r7, r0, asr #0x10
	mov r2, #0
	mov r6, r7, asr #0x1f
	mov r1, r2
	mov r0, #0x800
_02020D7C:
	sub r2, r2, #0x1000
	umull ip, r3, r2, r7
	mla r3, r2, r6, r3
	mov r2, r2, asr #0x1f
	mla r3, r2, r7, r3
	adds ip, ip, r0
	adc r2, r3, r1
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	cmp r5, #0
	add r2, r3, #0x1000
	sub r5, r5, #1
	bne _02020D7C
	strh r2, [r4, #0x34]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Player__Func_2020DB8(Player *player)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r0
	ldr r1, [r7, #0x600]
	ldr r0, [r7, #0x608]
	ldr r2, [r7, #0x5d8]
	ldr r6, [r7, #0x604]
	tst r2, #0x100
	ldrne r6, [r7, #0x61c]
	mov r4, r1, asr #1
	mov r5, r0, asr #4
	tst r2, #0x80
	beq _02020DFC
	ldr r1, [r7, #0x620]
	ldr r0, [r7, #0x628]
	ldr r6, [r7, #0x624]
	mov r4, r1, asr #1
	mov r5, r0, asr #4
_02020DFC:
	ldrh r0, [r7, #0x34]
	cmp r0, #0
	beq _02020E40
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, asr #4
	ldr r0, =FX_SinCosTable_
	mov r1, r1, lsl #2
	ldrsh r0, [r0, r1]
	ldr r1, [r7, #0x630]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	cmp r1, #0
	addgt r6, r6, r1
_02020E40:
	ldr r3, [r7, #0xc8]
	ldr r1, [r7, #0x644]
	cmp r3, #0
	rsblt r2, r3, #0
	movge r2, r3
	mov r0, #0
	cmp r2, r1
	ble _02020E88
	cmp r3, #0
	rsblt r3, r3, #0
	sub r0, r3, r1
	sub r1, r6, r1
	bl FX_Div
	cmp r0, #0x1000
	movgt r0, #0x1000
	mov r1, #0xf80
	mul r1, r0, r1
	mov r0, r1, asr #0xc
_02020E88:
	smull r1, r0, r4, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	ldr r2, [r7, #0x638]
	orr r1, r1, r0, lsl #20
	cmp r2, r6
	sub r4, r4, r1
	blt _02020EDC
	ldr r1, [r7, #0xc8]
	cmp r1, #0
	rsblt r0, r1, #0
	movge r0, r1
	cmp r0, r6
	blt _02020EDC
	cmp r2, r1
	ble _02020ED8
	cmp r1, #0
	rsblt r1, r1, #0
	str r1, [r7, #0x638]
_02020ED8:
	ldr r6, [r7, #0x638]
_02020EDC:
	ldr r0, [r7, #0x5dc]
	tst r0, #0x800
	bne _0202100C
	add r0, r7, #0x700
	ldrh r0, [r0, #0x20]
	tst r0, #0x30
	beq _02020F9C
	tst r0, #0x10
	ldr r0, [r7, #0xc8]
	beq _02020F50
	cmp r0, #0
	blt _02020F2C
	mov r1, r4
	mov r2, r6
	bl ObjSpdUpSet
	str r0, [r7, #0xc8]
	ldr r0, [r7, #0x20]
	bic r0, r0, #1
	str r0, [r7, #0x20]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02020F2C:
	mov r1, r5
	bl ObjSpdDownSet
	str r0, [r7, #0xc8]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r7, #0x20]
	bic r0, r0, #1
	str r0, [r7, #0x20]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02020F50:
	cmp r0, #0
	bgt _02020F78
	mov r2, r6
	rsb r1, r4, #0
	bl ObjSpdUpSet
	str r0, [r7, #0xc8]
	ldr r0, [r7, #0x20]
	orr r0, r0, #1
	str r0, [r7, #0x20]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02020F78:
	mov r1, r5
	bl ObjSpdDownSet
	str r0, [r7, #0xc8]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r7, #0x20]
	orr r0, r0, #1
	str r0, [r7, #0x20]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02020F9C:
	add r0, r7, #0x600
	mov r1, #0
	strh r1, [r0, #0x7c]
	ldr r0, [r7, #0x98]
	rsb r1, r6, #0
	cmp r0, r1
	movlt r0, r1
	blt _02020FC4
	cmp r0, r6
	movgt r0, r6
_02020FC4:
	str r0, [r7, #0x98]
	ldr r0, [r7, #0xc8]
	cmp r0, r1
	blt _02020FE0
	cmp r0, r6
	movle r6, r0
	mov r1, r6
_02020FE0:
	str r1, [r7, #0xc8]
	ldrh r0, [r7, #0x34]
	add r0, r0, #0x2000
	and r0, r0, #0xff00
	cmp r0, #0x4000
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r7, #0xc8]
	mov r1, r5
	bl ObjSpdDownSet
	str r0, [r7, #0xc8]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0202100C:
	add r0, r7, #0x700
	ldrh r0, [r0, #0x20]
	cmp r4, #0x200
	movlt r4, #0x200
	tst r0, #0x20
	beq _02021044
	ldr r0, [r7, #0xc8]
	mov r1, r5
	bl ObjSpdDownSet
	str r0, [r7, #0xc8]
	cmp r0, #0x4000
	movlt r0, #0x4000
	strlt r0, [r7, #0xc8]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02021044:
	tst r0, #0x10
	beq _02021064
	ldr r0, [r7, #0xc8]
	mov r1, r4
	mov r2, r6
	bl ObjSpdUpSet
	str r0, [r7, #0xc8]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02021064:
	add r0, r7, #0x600
	mov r1, #0
	strh r1, [r0, #0x7c]
	ldr r0, [r7, #0xc8]
	mov r2, r6, asr #2
	mov r1, r4, asr #2
	cmp r0, #0x6000
	add r5, r2, r6, asr #1
	add r1, r1, r4, asr #1
	bge _0202109C
	mov r2, #0x6000
	bl ObjSpdUpSet
	str r0, [r7, #0xc8]
	b _020210BC
_0202109C:
	cmp r0, r6
	ble _020210BC
	mov r1, r4
	mov r2, r6
	rsb r0, r0, #0
	bl ObjSpdUpSet
	rsb r0, r0, #0
	str r0, [r7, #0xc8]
_020210BC:
	ldr r0, [r7, #0x98]
	cmp r0, r5
	strgt r5, [r7, #0x98]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Player__Action_ExitHalfpipe(Player *player)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x5d8]
	tst r1, #0x400
	ldreq r2, [r4, #0xf4]
	ldreq r1, =Player__State_Halfpipe
	cmpeq r2, r1
	ldmneia sp!, {r4, pc}
	mov r1, #0
	str r1, [r4, #0x6d8]
	ldr r1, [r4, #0x5dc]
	bic r1, r1, #0x20000
	str r1, [r4, #0x5dc]
	ldr r1, [r4, #0x5d8]
	bic r1, r1, #0x100000
	str r1, [r4, #0x5d8]
	ldr r1, [r4, #0x1c]
	bic r1, r1, #0x2300
	str r1, [r4, #0x1c]
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x6f0]
	cmp r2, r1
	beq _02021178
	ldr r1, [r4, #0x1c]
	bic r1, r1, #1
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x5f0]
	blx r1
	ldr r0, [r4, #0x5d8]
	orr r0, r0, #3
	str r0, [r4, #0x5d8]
	ldr r0, [r4, #0xbc]
	str r0, [r4, #0x98]
	ldr r0, [r4, #0xc0]
	str r0, [r4, #0x9c]
	ldr r0, [r4, #0x5dc]
	tst r0, #0x800
	ldmneia sp!, {r4, pc}
	mov r0, r4
	mov r1, #0x13
	bl Player__ChangeAction
	ldmia sp!, {r4, pc}
_02021178:
	ldr r1, [r4, #0x5e8]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Player__Action_GhostTree(Player *player, GameObjectTask *other)
{
    Player__Action_FollowParent(player, other, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));

    player->objWork.userFlag = PLAYER_CHILDFLAG_FOLLOW_PREV_POS | PLAYER_CHILDFLAG_FORCE_LAUNCH_ACTION;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    Player__ChangeAction(player, PLAYER_ACTION_HOMING_ATTACK);

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;
    player->gimmickFlag |= PLAYER_GIMMICK_GRABBED;

    ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);
}

void Player__Action_SpringCrystal(Player *player, fx32 velX, fx32 velY)
{
    Player__Action_GimmickLaunch(player, velX, velY);
}

void Player__Action_CraneGrab(Player *player, GameObjectTask *other)
{
    fx32 offsetX;
    if ((other->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        offsetX = -FLOAT_TO_FX32(46.0);
    else
        offsetX = FLOAT_TO_FX32(46.0);

    Player__Action_FollowParent(player, other, offsetX, FLOAT_TO_FX32(128.0), 0);

    player->playerFlag |= PLAYER_FLAG_FINISHED_TRICK_COMBO | PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    player->gimmickFlag |= PLAYER_GIMMICK_GRABBED;

    Player__ChangeAction(player, PLAYER_ACTION_CRANE);

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    player->objWork.displayFlag |= other->objWork.displayFlag & DISPLAY_FLAG_FLIP_X;

    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_CRANE_TURN);
}

void Player__Action_Winch(Player *player, GameObjectTask *other, u32 displayFlag)
{
    Player__Action_FollowParent(player, other, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(15.0), FLOAT_TO_FX32(0.0));
    SetTaskState(&player->objWork, Player__State_Winch);

    player->objWork.userFlag |= PLAYER_CHILDFLAG_CAN_JUMP | PLAYER_CHILDFLAG_FOLLOW_PREV_POS | PLAYER_CHILDFLAG_FORCE_LAUNCH_ACTION | PLAYER_CHILDFLAG_INHERIT_SHAKE_TIMER;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

    Player__ChangeAction(player, PLAYER_ACTION_CRANE);

    player->objWork.displayFlag |= displayFlag | DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR;
    player->objWork.collisionFlag &= ~STAGE_TASK_COLLISION_FLAG_GRIND_RAIL;

    player->objWork.dir.x = player->objWork.dir.y = player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
}

void Player__State_Winch(Player *work)
{
    GameObjectTask *gimmick = work->gimmickObj;

    Player__State_FollowParent(work);

    if (!StageTaskStateMatches(&work->objWork, Player__State_Winch) && gimmick != NULL)
        Player__Action_AllowTrickCombos(work, gimmick);
}

void Player__Action_EnterTruck(Player *player, GameObjectTask *other)
{
    if (player->gimmickObj != other)
    {
        Player__InitPhysics(player);
        Player__InitGimmick(player, FALSE);

        player->gimmickObj = other;
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_TOUCHING_ANY;

        Player__Action_StopBoost(player);
        Player__Action_StopSuperBoost(player);
        player->playerFlag |= PLAYER_GIMMICK_BUNGEE;
        Player__ChangeAction(player, PLAYER_ACTION_HANG_ROT);
        player->objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
        Player__SetAnimFrame(player, FLOAT_TO_FX32(40.0));
        player->objWork.userTimer = FLOAT_TO_FX32(40.0);
        player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
        player->objWork.position.x = other->objWork.position.x - FLOAT_TO_FX32(33.0);
        player->objWork.position.y = other->objWork.position.y - FLOAT_TO_FX32(15.0);
        player->objWork.groundVel  = FLOAT_TO_FX32(0.0);
        player->objWork.velocity.x = FLOAT_TO_FX32(0.0);
        player->objWork.velocity.y = FLOAT_TO_FX32(0.0);
        SetTaskState(&player->objWork, Player__State_EnterTruck);
        ObjRect__SetOnDefend(&player->colliders[0], Player__OnDefend_TruckRide);
        player->objWork.userWork = 0;
    }
}

NONMATCH_FUNC void Player__State_EnterTruck(Player *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x34
	mov r5, r0
	ldr r4, [r5, #0x6d8]
	add r1, sp, #4
	mov ip, #0
	str ip, [r1]
	str ip, [r1, #4]
	str ip, [r1, #8]
	cmp r4, #0
	bne _020214C0
	ldr r1, [r5, #0x20]
	bic r1, r1, #0x30
	str r1, [r5, #0x20]
	ldr r1, [r5, #0x1c]
	bic r1, r1, #0x2100
	str r1, [r5, #0x1c]
	ldr r1, [r5, #0x5f0]
	blx r1
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, pc}
_020214C0:
	add r0, r5, #0x44
	add r3, r5, #0x8c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r5, #0x28]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _020216E4
_020214E0: // jump table
	b _020214F0 // case 0
	b _0202154C // case 1
	b _020215CC // case 2
	b _02021648 // case 3
_020214F0:
	ldr r0, [r5, #0x2c]
	subs r0, r0, #0x2000
	str r0, [r5, #0x2c]
	bpl _02021528
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	ldr r0, [r5, #0x12c]
	ldr r0, [r0, #0xe4]
	ldr r0, [r0, #8]
	ldrh r0, [r0, #4]
	mov r0, r0, lsl #0xc
	sub r0, r0, #1
	str r0, [r5, #0x2c]
_02021528:
	ldr r1, [r5, #0x2c]
	mov r0, r5
	bl Player__SetAnimFrame
	mov r1, #0x21000
	rsb r1, r1, #0
	add r0, r1, #0x12000
	str r1, [sp, #4]
	str r0, [sp, #8]
	b _020216E4
_0202154C:
	ldr r1, [r5, #0x2c]
	mov r0, r5
	sub r1, r1, #0x2000
	str r1, [r5, #0x2c]
	bl Player__SetAnimFrame
	ldr r0, [r5, #0x2c]
	cmp r0, #0x32000
	bgt _02021590
	ldr r1, [r5, #0x28]
	mov r0, #0
	add r1, r1, #1
	str r1, [r5, #0x28]
	ldr r1, [r5, #0x20]
	orr r1, r1, #0x20
	str r1, [r5, #0x20]
	str r0, [r5, #0x2c]
	b _020215B4
_02021590:
	rsb r1, r0, #0x50000
	movs r0, r1, asr #2
	str r0, [r5, #0x50]
	movmi r0, #0
	strmi r0, [r5, #0x50]
	movs r0, r1, asr #3
	str r0, [r5, #0x54]
	movmi r0, #0
	strmi r0, [r5, #0x54]
_020215B4:
	mov r1, #0x21000
	rsb r1, r1, #0
	add r0, r1, #0x12000
	str r1, [sp, #4]
	str r0, [sp, #8]
	b _020216E4
_020215CC:
	ldr r0, [r5, #0x2c]
	add r1, r0, #1
	str r1, [r5, #0x2c]
	cmp r1, #0x10
	blt _0202162C
	ldr r1, [r5, #0x28]
	mov r0, r5
	add r1, r1, #1
	str r1, [r5, #0x28]
	ldr r2, [r5, #0x20]
	mov r1, #1
	bic r2, r2, #0x30
	str r2, [r5, #0x20]
	bl Player__ChangeAction
	ldr r0, [r5, #0x20]
	mov r1, #0x10000
	orr r0, r0, #4
	str r0, [r5, #0x20]
	mov r0, #0
	str r0, [r5, #0x2c]
	sub r0, r1, #0x1a000
	str r1, [sp, #4]
	str r0, [sp, #8]
	b _020216E4
_0202162C:
	mov r0, #0x3100
	mul r0, r1, r0
	sub r1, r0, #0x21000
	sub r0, ip, #0xf000
	str r1, [sp, #4]
	str r0, [sp, #8]
	b _020216E4
_02021648:
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #0x12
	blt _020216CC
	mov r2, #0x10000
	str ip, [r5, #0x6d8]
	mov r0, r5
	mov r1, r4
	sub r3, r2, #0x23000
	str ip, [sp]
	bl Player__Action_FollowParent
	ldr r1, =Player__State_TruckRide
	ldr r0, =Player__OnDefend_TruckRide
	str r1, [r5, #0xf4]
	str r0, [r5, #0x534]
	ldr r1, [r5, #0x1c]
	mov r0, #0x13000
	orr r1, r1, #0x100
	str r1, [r5, #0x1c]
	ldr r1, [r5, #0x5d8]
	rsb r0, r0, #0
	orr r1, r1, #7
	str r1, [r5, #0x5d8]
	ldr r1, [r5, #0x24]
	orr r1, r1, #8
	str r1, [r5, #0x24]
	ldr r1, [r5, #0x20]
	orr r1, r1, #0x200
	bic r1, r1, #1
	str r1, [r5, #0x20]
	str r0, [sp, #8]
	b _020216DC
_020216CC:
	rsb r0, r0, #0x12
	mov r0, r0, lsl #0xb
	sub r0, r0, #0x13000
	str r0, [sp, #8]
_020216DC:
	mov r0, #0x10000
	str r0, [sp, #4]
_020216E4:
	ldrh r1, [r4, #0x34]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	bl MTX_RotZ33_
	add r0, sp, #4
	add r1, sp, #0x10
	mov r2, r0
	bl MTX_MultVec33
	ldr r1, [r4, #0x44]
	ldr r0, [sp, #4]
	add r0, r1, r0
	str r0, [r5, #0x44]
	ldr r1, [r4, #0x48]
	ldr r0, [sp, #8]
	add r0, r1, r0
	str r0, [r5, #0x48]
	ldrh r0, [r4, #0x34]
	strh r0, [r5, #0x34]
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x8c]
	sub r0, r1, r0
	str r0, [r5, #0xbc]
	ldr r1, [r5, #0x48]
	ldr r0, [r5, #0x90]
	sub r0, r1, r0
	str r0, [r5, #0xc0]
	ldr r1, [r5, #0x4c]
	ldr r0, [r5, #0x94]
	sub r0, r1, r0
	str r0, [r5, #0xc4]
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

void Player__Action_TruckLaunch(Player *player, GameObjectTask *other, s32 a3)
{
    if (player->gimmickObj == other)
    {
        ObjRect__SetOnDefend(&player->colliders[0], Player__OnDefend_Regular);
        player->gimmickObj = NULL;

        player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
        player->objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        player->objWork.displayFlag &= ~(DISPLAY_FLAG_DISABLE_DRAW | DISPLAY_FLAG_PAUSED);
        player->playerFlag &= ~(PLAYER_FLAG_2000 | PLAYER_FLAG_DISABLE_TENSION_DRAIN);
        player->gimmickFlag &= ~(PLAYER_GIMMICK_10 | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_GRABBED);

        player->gimmickCamOffsetX = player->gimmickCamOffsetY = 0;
        player->objWork.dir.x = player->objWork.dir.y = player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

        Player__Action_GimmickLaunch(player, player->objWork.move.x, -FLOAT_TO_FX32(8.0));

        if (!a3)
            player->playerFlag |= PLAYER_FLAG_DISABLE_TRICK_FINISHER;

        Player__Action_AllowTrickCombos(player, other);
    }
}

void Player__State_TruckRide(Player *work)
{
    if (work->actionState != PLAYER_ACTION_TRUCK_CROUCH)
    {
        if ((work->inputKeyDown & PAD_KEY_DOWN) != 0)
        {
            Player__ChangeAction(work, PLAYER_ACTION_TRUCK_CROUCH);
        }
    }
    else
    {
        if ((work->inputKeyDown & PAD_KEY_DOWN) == 0)
        {
            Player__ChangeAction(work, PLAYER_ACTION_IDLE);
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        }
    }

    Player__State_FollowParent(work);
}

void Player__OnDefend_TruckRide(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player = (Player *)rect2->parent;

    if (player->objWork.hitstopTimer != 0 || rect1->parent->objType == STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0)
    {
        Player__GiveTension(player, -PLAYER_TENSION_HURT_PENALTY);
        UpdateTensionGaugeHUD(player->tension >> 4, TRUE);
    }

    if ((rect1->hitFlag & OBS_RECT_WORK_ATTR_USER_1) != 0)
    {
        if (player->rings != 0)
        {
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RINGLOST);
            CreateLoseRingEffect(player, player->rings);
        }

        Player__Action_Die(player);
        ObjRect__SetOnDefend(&player->colliders[0], Player__OnDefend_Regular);
        return;
    }

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0 && player->rings == 0)
    {
        Player__Action_Die(player);
        ObjRect__SetOnDefend(&player->colliders[0], Player__OnDefend_Regular);
        return;
    }

    if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0)
    {
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_RINGLOST);
        CreateLoseRingEffect(player, player->rings);
    }

    player->playerFlag &= ~(PLAYER_FLAG_SHIELD_MAGNET | PLAYER_FLAG_SHIELD_REGULAR);
    ShakeScreen(SCREENSHAKE_MEDIUM_SHORT);

    player->objWork.shakeTimer    = 8;
    player->blinkTimer            = player->hurtInvulnDuration;
    player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;

    switch (player->characterID)
    {
        // case CHARACTER_SONIC:
        default:
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_OWA);
            break;

        case CHARACTER_BLAZE:
            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_UPS);
            break;
    }
}

void Player__Func_2021A84(Player *player, GameObjectTask *other)
{
    if (player->gimmickObj == other)
    {
        player->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;
        player->gimmickFlag |= PLAYER_GIMMICK_10;
        player->gimmickCamOffsetX = 0;
        Player__ChangeAction(player, PLAYER_ACTION_BALANCE_BACKWARD);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        player->objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
        player->objWork.displayFlag &= ~DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        SetTaskState(&player->objWork, Player__State_FollowParent);
    }
}

void Player__Func_2021AE8(Player *player, GameObjectTask *other)
{
    if (player->gimmickObj == other)
    {
        player->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;
        player->gimmickFlag |= PLAYER_GIMMICK_20;
        player->gimmickCamOffsetY = 64;
        Player__ChangeAction(player, PLAYER_ACTION_IDLE);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        SetTaskState(&player->objWork, Player__State_TruckRide);
    }
}

void Player__Func_2021B44(Player *player, GameObjectTask *other)
{
    if (player->gimmickObj == other)
    {
        player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
        player->objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        player->gimmickFlag &= ~PLAYER_GIMMICK_20;
        player->gimmickCamOffsetY = 0;
    }
}

void Player__Action_AnchorRope(Player *player, GameObjectTask *other)
{
    Player__Action_FollowParent(player, other, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));

    SetTaskState(&player->objWork, Player__State_AnchorRope);

    player->playerFlag |= PLAYER_FLAG_ALLOW_TRICKS | PLAYER_FLAG_USER_FLAG;
    player->objWork.userFlag |= PLAYER_CHILDFLAG_CAN_JUMP | PLAYER_CHILDFLAG_FOLLOW_PREV_POS | PLAYER_CHILDFLAG_FORCE_LAUNCH_ACTION;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    player->gimmickFlag |= PLAYER_GIMMICK_GRABBED | PLAYER_GIMMICK_10;
    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;

    player->gimmickCamOffsetX = 0;
    Player__ChangeAction(player, PLAYER_ACTION_ANCHOR_ROPE);
    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING | DISPLAY_FLAG_FLIP_X;

    player->objWork.dir.x = player->objWork.dir.y = player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
}

void Player__State_AnchorRope(Player *work)
{
    Player__State_FollowParent(work);

    if (StageTaskStateMatches(&work->objWork, Player__State_AnchorRope))
    {
        GameObjectTask *gimmick = work->gimmickObj;
        if (gimmick != NULL)
        {
            fx32 distX     = gimmick->objWork.position.x - work->objWork.position.x;
            fx32 distPrevX = gimmick->objWork.position.x - work->objWork.prevPosition.x;

            if ((distX <= FLOAT_TO_FX32(0.0) && distPrevX > FLOAT_TO_FX32(0.0)) || (distX >= FLOAT_TO_FX32(0.0) && distPrevX < FLOAT_TO_FX32(0.0)))
            {
                if (work->objWork.position.z > FLOAT_TO_FX32(0.0))
                    PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_ANCHOR_ROPE);
            }
        }
    }
    else
    {
        work->objWork.position.z = FLOAT_TO_FX32(0.0);
    }
}

void Player__Action_BarrelGrab(Player *player, GameObjectTask *other)
{
    fx32 offsetX;
    if (player->characterID == CHARACTER_SONIC)
        offsetX = FLOAT_TO_FX32(40.0);
    else
        offsetX = FLOAT_TO_FX32(42.0);
    Player__Action_FollowParent(player, other, FLOAT_TO_FX32(0.0), offsetX, FLOAT_TO_FX32(0.0));

    SetTaskState(&player->objWork, Player__State_BarrelGrab);

    player->playerFlag |= PLAYER_FLAG_FINISHED_TRICK_COMBO;
    player->objWork.userFlag |= PLAYER_CHILDFLAG_FOLLOW_PREV_POS | PLAYER_CHILDFLAG_FORCE_JUMP_ACTION;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    player->gimmickFlag |= PLAYER_GIMMICK_GRABBED | PLAYER_GIMMICK_10;
    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;

    player->gimmickCamOffsetX = 0;
    player->objWork.userWork  = 0;
    player->objWork.userTimer = 0;
    Player__ChangeAction(player, PLAYER_ACTION_HOMING_ATTACK);
    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

    ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);;
    player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;
    player->blinkTimer            = 0;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

    player->objWork.dir.x = player->objWork.dir.y = player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
}

void Player__State_BarrelGrab(Player *work)
{
    if (work->gimmickObj != NULL && (work->gimmickObj->flags & 2) != 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;

    work->objWork.userWork &= ~1;

    if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
    {
        work->objWork.userWork |= 1;
        work->objWork.userTimer++;
    }

    if (work->objWork.userTimer >= 5)
        work->objWork.userWork |= 2;

    Player__State_FollowParent(work);

    if (!StageTaskStateMatches(&work->objWork, Player__State_BarrelGrab))
    {
        work->colliders[0].defPower = PLAYER_DEFPOWER_NORMAL;
        work->playerFlag |= PLAYER_FLAG_USER_FLAG;
        work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

        if (work->characterID == CHARACTER_SONIC)
            work->objWork.position.y += FLOAT_TO_FX32(2.0);
    }
}

void Player__Gimmick_2021E9C(Player *player, GameObjectTask *other)
{
    fx32 velX;
    fx32 velY;

    if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES) != 0)
    {
        velX = player->objWork.velocity.x;
        velY = player->objWork.velocity.y;
    }
    else
    {
        velX = MultiplyFX(player->objWork.groundVel, CosFX(player->objWork.dir.z));
        velY = MultiplyFX(player->objWork.groundVel, SinFX(player->objWork.dir.z));
    }

    if (velY >= 0 && (player->playerFlag & PLAYER_FLAG_DEATH) == 0)
    {
        Player__InitGimmick(player, TRUE);
        player->gimmickObj = other;

        if (velY < FLOAT_TO_FX32(6.0))
            velY = FLOAT_TO_FX32(6.0);

        player->gimmick.value1     = velX;
        player->gimmick.value2     = -velY;
        player->objWork.velocity.x = FLOAT_TO_FX32(0.0);
        player->objWork.velocity.y = velY;
        player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;

        Player__ChangeAction(player, PLAYER_ACTION_JUMPFALL);
        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);;
        player->objWork.userWork = 0;
        SetTaskState(&player->objWork, Player__State_2021FA8);
    }
}

NONMATCH_FUNC void Player__State_2021FA8(Player *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x9c]
	sub r0, r0, r0, asr #2
	str r0, [r5, #0x9c]
	cmp r0, #0x2000
	bgt _02021FD8
	add r0, r5, #0x700
	ldrh r0, [r0, #0x20]
	tst r0, #3
	movne r0, #1
	strne r0, [r5, #0x28]
_02021FD8:
	ldr r0, [r5, #0x9c]
	cmp r0, #0x400
	ldmgtia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x28]
	ldr r4, [r5, #0x6d8]
	cmp r0, #0
	ldr r0, [r5, #0x1c]
	mov r1, #0
	orr r0, r0, #0x80
	str r0, [r5, #0x1c]
	ldr r2, [r5, #0xc8]
	subne r1, r1, #0x2000
	cmp r2, #0
	ldr r0, [r5, #0x64c]
	blt _02022020
	cmp r2, r0
	strgt r0, [r5, #0xc8]
	b _0202202C
_02022020:
	rsb r0, r0, #0
	cmp r2, r0
	strlt r0, [r5, #0xc8]
_0202202C:
	ldr r2, [r5, #0x98]
	ldr r0, [r5, #0x64c]
	cmp r2, #0
	blt _02022048
	cmp r2, r0
	strgt r0, [r5, #0x98]
	b _02022054
_02022048:
	rsb r0, r0, #0
	cmp r2, r0
	strlt r0, [r5, #0x98]
_02022054:
	ldr r2, [r5, #0x6f4]
	mov r0, r5
	add r2, r2, r1
	mov r1, #0
	bl Player__Action_Trampoline
	mov r0, r5
	mov r1, r4
	add r2, r5, #0x600
	mov r3, #2
	strh r3, [r2, #0x98]
	bl Player__Action_AllowTrickCombos
	mov r0, #0
	str r0, [r5, #0x6d8]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Player__Action_Trampoline(Player *player, fx32 velX, fx32 velY)
{
    Player__Action_GimmickLaunch(player, velX, velY);

    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    player->objWork.userTimer = 1;
    player->objWork.displayFlag |= DISPLAY_FLAG_ENABLE_ANIMATION_BLENDING;

    Player__ChangeAction(player, PLAYER_ACTION_TRAMPOLINE);
    ObjRect__SetAttackStat(&player->colliders[1], OBS_RECT_WORK_ATTR_NONE, PLAYER_HITPOWER_VULNERABLE);;

    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TRAMPOLINE);
}

NONMATCH_FUNC void Player__Gimmick_2022108(Player *player, GameObjectTask *other, s32 a3)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r1
	mov r5, r0
	mov r1, #0
	mov r6, r2
	bl Player__InitGimmick
	mov r0, r5
	bl Player__InitState
	str r4, [r5, #0x6d8]
	cmp r6, #0
	beq _02022144
	cmp r6, #1
	beq _02022168
	cmp r6, #2
	b _020221B4
_02022144:
	mov r0, r5
	mov r1, #0x13
	bl Player__ChangeAction
	ldr r1, [r5, #0x20]
	ldr r0, =Player__State_20222E4
	orr r1, r1, #4
	str r1, [r5, #0x20]
	str r0, [r5, #0xf4]
	b _02022244
_02022168:
	mov r0, r5
	mov r1, #0x6b
	bl Player__ChangeAction
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x1c]
	orr r0, r0, #0x2000
	str r0, [r5, #0x1c]
	ldr r1, [r5, #0x44]
	ldr r0, [r4, #0x44]
	cmp r1, r0
	ldr r0, [r5, #0x20]
	biclt r0, r0, #1
	orrge r0, r0, #1
	str r0, [r5, #0x20]
	ldr r0, =Player__Func_20223F8
	str r0, [r5, #0xf4]
	b _02022244
_020221B4:
	mov r0, r5
	mov r1, #0x25
	bl Player__ChangeAction
	ldr r1, [r5, #0x20]
	mov r0, r5
	orr r2, r1, #0x10
	mov r1, #0x28000
	str r2, [r5, #0x20]
	bl Player__SetAnimFrame
	mov r0, #0x28000
	str r0, [r5, #0x2c]
	ldr r1, [r5, #0x44]
	ldr r0, [r4, #0x44]
	cmp r1, r0
	ldr r0, [r5, #0x20]
	bge _02022208
	bic r0, r0, #1
	str r0, [r5, #0x20]
	ldr r0, [r4, #0x44]
	sub r0, r0, #0xe000
	b _02022218
_02022208:
	orr r0, r0, #1
	str r0, [r5, #0x20]
	ldr r0, [r4, #0x44]
	add r0, r0, #0xe000
_02022218:
	str r0, [r5, #0x44]
	ldr r0, [r4, #0x48]
	sub r0, r0, #0x4c000
	str r0, [r5, #0x48]
	ldr r1, [r5, #0x1c]
	ldr r0, =Player__Func_20224BC
	orr r1, r1, #0x2000
	str r1, [r5, #0x1c]
	str r0, [r5, #0xf4]
	mov r0, #0
	str r0, [r5, #0x9c]
_02022244:
	mov r0, r5
	bl Player__Action_StopSuperBoost
	mov r0, r5
	bl Player__Action_StopBoost
	mov r3, #0
	add r1, r5, #0x600
	strh r3, [r1, #0x82]
	ldr r2, [r5, #0x20]
	add r0, r5, #0x500
	bic r2, r2, #0x20
	str r2, [r5, #0x20]
	mov r2, #0xff
	strh r2, [r0, #0x3e]
	ldr r2, [r5, #0x1c]
	mov r0, #0x40
	orr r2, r2, #0x110
	orr r2, r2, #0x8000
	str r2, [r5, #0x1c]
	ldr r2, [r5, #0x5dc]
	orr r2, r2, #0x30
	str r2, [r5, #0x5dc]
	strh r3, [r1, #0xdc]
	strh r0, [r1, #0xde]
	ldr r0, [r5, #0x5d8]
	orr r0, r0, #0x2000
	orr r0, r0, #0x100000
	str r0, [r5, #0x5d8]
	str r3, [r5, #0x98]
	str r3, [r5, #0xc8]
	strh r3, [r5, #0x34]
	str r3, [r5, #0x28]
	str r3, [r5, #0x24]
	ldr r0, [r5, #0x44]
	str r0, [r5, #0x6f0]
	ldr r0, [r5, #0x48]
	str r0, [r5, #0x6f4]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Player__State_20222E4(Player *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0x6d8]
	cmp r4, #0
	beq _020223C4
	ldr r0, [r5, #0x44]
	str r0, [r5, #0x8c]
	ldr r0, [r5, #0x48]
	str r0, [r5, #0x90]
	ldr r0, [r5, #0x28]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #0x4000
	str r0, [sp]
	mov r0, #0x800
	str r0, [sp, #4]
	ldr r0, [r5, #0x44]
	ldr r1, [r4, #0x44]
	ldr r2, [r5, #0x6f0]
	mov r3, #1
	bl ObjDiffSet
	str r0, [r5, #0x44]
	ldr r1, [r4, #0x48]
	ldr r0, [r5, #0x48]
	sub r1, r1, #0x27000
	cmp r0, r1
	blt _02022370
	str r1, [r5, #0x48]
	ldr r1, [r5, #0x1c]
	mov r0, #0
	orr r1, r1, #0x2000
	str r1, [r5, #0x1c]
	str r0, [r5, #0x9c]
_02022370:
	ldr r1, [r5, #0x44]
	ldr r0, [r4, #0x44]
	cmp r1, r0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x48]
	ldr r1, [r5, #0x48]
	sub r0, r0, #0x27000
	cmp r1, r0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, =Player__Func_2022694
	add sp, sp, #8
	str r0, [r5, #0xf4]
	ldr r0, [r5, #0x20]
	bic r0, r0, #1
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x24]
	orr r0, r0, #1
	str r0, [r5, #0x24]
	ldmia sp!, {r3, r4, r5, pc}
_020223C4:
	add r1, r5, #0x500
	mov r2, #0x3f
	strh r2, [r1, #0x3e]
	ldr r1, [r5, #0x5e4]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	bl Player__InitState
	ldr r0, [r5, #0x5e4]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Player__Func_20223F8(Player *player)
{
    GameObjectTask *gimmick = player->gimmickObj;
    if (gimmick != NULL)
    {
        player->objWork.position.x = ObjDiffSet(player->objWork.position.x, gimmick->objWork.position.x, player->gimmick.value1, 1, FLOAT_TO_FX32(4.0), FLOAT_TO_FX32(0.5));
        if (player->objWork.position.x == gimmick->objWork.position.x)
        {
            SetTaskState(&player->objWork, Player__State_20222E4);
            Player__ChangeAction(player, PLAYER_ACTION_JUMPFALL);

            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_IN_AIR;
            player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT);
        }
    }
    else
    {
        player->colliders[0].defPower = PLAYER_DEFPOWER_NORMAL;

        if (player->actionGroundIdle != NULL)
        {
            Player__InitState(player);

            // TODO: I can't figure out what this must be, because it can't possibly be missing the 1st argument can it?
            // until then, I've added a "corrected" version as a non-matching solution, in the event the codebase needs to be more modular
#ifdef NON_MATCHING
            player->actionGroundIdle(player);
#else
            ((void (*)(void))player->actionGroundIdle)();
#endif
        }
    }
}

NONMATCH_FUNC void Player__Func_20224BC(Player *player)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0x6d8]
	cmp r4, #0
	beq _02022660
	ldr r1, [r5, #0x44]
	str r1, [r5, #0x8c]
	ldr r1, [r5, #0x48]
	str r1, [r5, #0x90]
	ldr r1, [r5, #0x28]
	cmp r1, #0
	beq _02022504
	cmp r1, #1
	beq _0202254C
	cmp r1, #2
	beq _020225A0
	b _02022638
_02022504:
	ldr r0, [r5, #0x2c]
	subs r0, r0, #0x2000
	str r0, [r5, #0x2c]
	bpl _0202253C
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	ldr r0, [r5, #0x12c]
	ldr r0, [r0, #0xe4]
	ldr r0, [r0, #8]
	ldrh r0, [r0, #4]
	mov r0, r0, lsl #0xc
	sub r0, r0, #1
	str r0, [r5, #0x2c]
_0202253C:
	ldr r1, [r5, #0x2c]
	mov r0, r5
	bl Player__SetAnimFrame
	b _02022638
_0202254C:
	ldr r1, [r5, #0x2c]
	sub r1, r1, #0x2000
	str r1, [r5, #0x2c]
	bl Player__SetAnimFrame
	ldr r0, [r5, #0x2c]
	cmp r0, #0x32000
	bgt _02022638
	ldr r1, [r5, #0x28]
	mov r0, r5
	add r1, r1, #1
	str r1, [r5, #0x28]
	ldr r2, [r5, #0x20]
	mov r1, #0x13
	orr r2, r2, #0x400
	str r2, [r5, #0x20]
	bl Player__ChangeAction
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	bic r0, r0, #0x10
	str r0, [r5, #0x20]
	b _02022638
_020225A0:
	mov r0, #0x4000
	str r0, [sp]
	mov r0, #0x1000
	str r0, [sp, #4]
	ldr r0, [r5, #0x44]
	ldr r1, [r4, #0x44]
	ldr r2, [r5, #0x6f0]
	mov r3, #1
	bl ObjDiffSet
	str r0, [r5, #0x44]
	mov r0, #0x4000
	str r0, [sp]
	mov r0, #0x1000
	str r0, [sp, #4]
	ldr r1, [r4, #0x48]
	ldr r0, [r5, #0x48]
	ldr r2, [r5, #0x6f4]
	sub r1, r1, #0x27000
	mov r3, #1
	bl ObjDiffSet
	str r0, [r5, #0x48]
	ldr r1, [r5, #0x44]
	ldr r0, [r4, #0x44]
	cmp r1, r0
	bne _02022638
	ldr r0, [r4, #0x48]
	ldr r1, [r5, #0x48]
	sub r0, r0, #0x27000
	cmp r1, r0
	bne _02022638
	ldr r0, =Player__Func_2022694
	str r0, [r5, #0xf4]
	ldr r0, [r5, #0x20]
	bic r0, r0, #1
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x24]
	orr r0, r0, #1
	str r0, [r5, #0x24]
_02022638:
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x8c]
	add sp, sp, #8
	sub r0, r1, r0
	str r0, [r5, #0xbc]
	ldr r1, [r5, #0x48]
	ldr r0, [r5, #0x90]
	sub r0, r1, r0
	str r0, [r5, #0xc0]
	ldmia sp!, {r3, r4, r5, pc}
_02022660:
	add r1, r5, #0x500
	mov r2, #0x3f
	strh r2, [r1, #0x3e]
	ldr r1, [r5, #0x5e4]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	bl Player__InitState
	ldr r0, [r5, #0x5e4]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Player__Func_2022694(Player *player)
{
    if (player->gimmickObj != NULL)
    {
        player->objWork.dir.y    = FLOAT_DEG_TO_IDX(90.0);
        player->objWork.offset.z = -FLOAT_TO_FX32(16.0);
    }
    else
    {
        player->colliders[0].defPower = PLAYER_DEFPOWER_NORMAL;

        if (player->actionGroundIdle != NULL)
        {
            Player__InitState(player);

            // TODO: I can't figure out what this must be, because it can't possibly be missing the 1st argument can it?
            // until then, I've added a "corrected" version as a non-matching solution, in the event the codebase needs to be more modular
#ifdef NON_MATCHING
            player->actionGroundIdle(player);
#else
            ((void (*)(void))player->actionGroundIdle)();
#endif
        }
    }
}

void Player__Action_PRCannon(Player *player, GameObjectTask *other)
{
    if (StageTaskStateMatches(&player->objWork, Player__Func_2022694))
    {
        player->gimmickObj = other;
        Player__ChangeAction(player, PLAYER_ACTION_AIRRISE);

        player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
        player->objWork.velocity.y = 0;
        player->objWork.displayFlag &= ~(DISPLAY_FLAG_FLIP_X | DISPLAY_FLAG_ROTATE_CAMERA_DIR);

        player->objWork.dir = other->objWork.dir;

        player->objWork.moveFlag |=
            STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_IN_AIR;
        player->gimmickCamOffsetY = 25;
        player->playerFlag |= PLAYER_FLAG_2000;
        player->objWork.userWork = 0;
        player->objWork.userFlag = 0;
        SetTaskState(&player->objWork, Player__State_CannonLanched);
        PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_PL_CANNON);
    }
}

NONMATCH_FUNC void Player__State_CannonLanched(Player *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0x6d8]
	cmp r4, #0
	beq _02022C0C
	add ip, r5, #0x44
	add r3, r5, #0x8c
	ldmia ip, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #0x28]
	cmp r0, #3
	bhs _0202280C
	add r0, r4, #0x44
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	bl CannonPath__GetOffsetZ
	str r0, [r5, #0x58]
	b _0202281C
_0202280C:
	ldr r0, [r4, #0x44]
	str r0, [r5, #0x44]
	ldr r0, [r4, #0x48]
	str r0, [r5, #0x48]
_0202281C:
	ldr r0, [r4, #0x28]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _02022BD4
_0202282C: // jump table
	b _02022840 // case 0
	b _02022840 // case 1
	b _02022880 // case 2
	b _02022AE0 // case 3
	b _02022AF4 // case 4
_02022840:
	ldrh r0, [r5, #0x30]
	mov r1, #0x3000
	mov r2, #0x380
	bl ObjRoopMove16
	strh r0, [r5, #0x30]
	ldrh r0, [r5, #0x32]
	mov r1, #0xe000
	mov r2, #0x380
	bl ObjRoopMove16
	strh r0, [r5, #0x32]
	ldrh r0, [r5, #0x34]
	mov r1, #0x4000
	mov r2, #0x380
	bl ObjRoopMove16
	strh r0, [r5, #0x34]
	b _02022BD4
_02022880:
	ldr r2, [r5, #0x24]
	tst r2, #2
	beq _02022954
	add r0, r5, #0x700
	ldrh r1, [r0, #0x22]
	ldr r0, =0x00000103
	and r0, r1, r0
	cmp r0, #2
	bne _02022954
	add r0, r5, #0x500
	ldrsh r0, [r0, #0xd4]
	cmp r0, #0x67
	mov r0, r5
	bne _020228D8
	mov r1, #0x68
	bl Player__ChangeAction
	ldrb r1, [r5, #0x6c9]
	mov r2, #0xa0
	mov r0, r5
	mov r1, r2, asr r1
	bl Player__GiveTension
	b _020228F4
_020228D8:
	mov r1, #0x67
	bl Player__ChangeAction
	ldrb r1, [r5, #0x6c9]
	mov r2, #0xa0
	mov r0, r5
	mov r1, r2, asr r1
	bl Player__GiveTension
_020228F4:
	ldr r1, [r5, #0x24]
	mov r0, r5
	bic r1, r1, #2
	str r1, [r5, #0x24]
	mov r1, #0xc8
	bl Player__GiveScore
	ldr r0, [r5, #0x24]
	tst r0, #0x20
	mov r0, r5
	beq _02022924
	bl StarCombo__FinishTrickCombo
	b _02022928
_02022924:
	bl StarCombo__PerformTrick
_02022928:
	mov r4, #0x3b
	sub r1, r4, #0x3c
	add r0, r5, #0x254
	mov r2, #0
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	str r4, [sp, #4]
	bl PlaySfxEx
	b _02022AA0
_02022954:
	tst r2, #4
	beq _020229FC
	add r0, r5, #0x700
	ldrh r1, [r0, #0x22]
	ldr r0, =0x00000103
	and r0, r1, r0
	cmp r0, #1
	bne _020229FC
	mov r1, #0
	strb r1, [r5, #0x6c9]
	mov r0, r5
	mov r1, #0x69
	bl Player__ChangeAction
	ldr r0, [r5, #0x24]
	mov r2, #0x140
	bic r0, r0, #4
	str r0, [r5, #0x24]
	ldrb r1, [r5, #0x6c9]
	mov r0, r5
	mov r1, r2, asr r1
	bl Player__GiveTension
	mov r0, r5
	mov r1, #0x190
	bl Player__GiveScore
	ldr r0, [r5, #0x24]
	tst r0, #0x20
	mov r0, r5
	beq _020229CC
	bl StarCombo__FinishTrickCombo
	b _020229D0
_020229CC:
	bl StarCombo__PerformTrick
_020229D0:
	mov r4, #0x3b
	sub r1, r4, #0x3c
	add r0, r5, #0x254
	mov r2, #0
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	str r4, [sp, #4]
	bl PlaySfxEx
	b _02022AA0
_020229FC:
	tst r2, #8
	beq _02022AA0
	add r0, r5, #0x700
	ldrh r1, [r0, #0x22]
	ldr r0, =0x00000103
	and r0, r1, r0
	cmp r0, #0x100
	bne _02022AA0
	mov r1, #0
	strb r1, [r5, #0x6c9]
	mov r0, r5
	mov r1, #0x64
	bl Player__ChangeAction
	ldr r0, [r5, #0x24]
	mov r2, #0x140
	bic r0, r0, #8
	str r0, [r5, #0x24]
	ldrb r1, [r5, #0x6c9]
	mov r0, r5
	mov r1, r2, asr r1
	bl Player__GiveTension
	mov r0, r5
	mov r1, #0xc8
	bl Player__GiveScore
	ldr r0, [r5, #0x24]
	tst r0, #0x20
	mov r0, r5
	beq _02022A74
	bl StarCombo__FinishTrickCombo
	b _02022A78
_02022A74:
	bl StarCombo__PerformTrick
_02022A78:
	mov r4, #0x3b
	sub r1, r4, #0x3c
	add r0, r5, #0x254
	mov r2, #0
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	str r4, [sp, #4]
	bl PlaySfxEx
_02022AA0:
	add r0, r5, #0x500
	ldrsh r0, [r0, #0xd4]
	cmp r0, #0x14
	beq _02022BD4
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _02022BD4
	orr r1, r0, #0x400
	mov r0, r5
	str r1, [r5, #0x20]
	mov r1, #0x14
	bl Player__ChangeAction
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	b _02022BD4
_02022AE0:
	bl CannonPath__GetOffsetZ
	ldr r1, [r4, #0x4c]
	add r0, r1, r0
	str r0, [r5, #0x4c]
	b _02022BD4
_02022AF4:
	bl CannonPath__GetOffsetZ
	mov r1, #0xc8000
	rsb r1, r1, #0
	cmp r0, r1
	ble _02022B44
	ldrh r0, [r5, #0x30]
	mov r1, #0
	mov r2, #0xb6
	bl ObjRoopMove16
	strh r0, [r5, #0x30]
	ldrh r0, [r5, #0x32]
	mov r1, #0
	mov r2, #0xb6
	bl ObjRoopMove16
	strh r0, [r5, #0x32]
	ldrh r0, [r5, #0x34]
	mov r1, #0
	mov r2, #0x16c
	bl ObjRoopMove16
	strh r0, [r5, #0x34]
_02022B44:
	bl CannonPath__GetOffsetZ
	mov r1, #0x12c000
	rsb r1, r1, #0
	cmp r0, r1
	ble _02022B74
	ldr r0, [r5, #0x4c]
	mov r1, #0x1000
	bl ObjSpdDownSet
	mov r1, #0x1000
	rsb r1, r1, #0
	and r0, r0, r1
	str r0, [r5, #0x4c]
_02022B74:
	add r0, r5, #0x600
	ldrsh r1, [r0, #0xde]
	sub r1, r1, #1
	strh r1, [r0, #0xde]
	ldrsh r1, [r0, #0xde]
	cmp r1, #0
	movlt r1, #0
	strlth r1, [r0, #0xde]
	add r0, r5, #0x500
	ldrsh r0, [r0, #0xd4]
	cmp r0, #0x13
	beq _02022BD4
	ldrh r0, [r5, #0x34]
	cmp r0, #0x2000
	bhi _02022BD4
	ldr r1, [r5, #0x20]
	mov r0, r5
	orr r1, r1, #0x400
	str r1, [r5, #0x20]
	mov r1, #0x13
	bl Player__ChangeAction
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
_02022BD4:
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x8c]
	add sp, sp, #8
	sub r0, r1, r0
	str r0, [r5, #0xbc]
	ldr r1, [r5, #0x48]
	ldr r0, [r5, #0x90]
	sub r0, r1, r0
	str r0, [r5, #0xc0]
	ldr r1, [r5, #0x4c]
	ldr r0, [r5, #0x94]
	sub r0, r1, r0
	str r0, [r5, #0xc4]
	ldmia sp!, {r3, r4, r5, pc}
_02022C0C:
	add r1, r5, #0x500
	mov r2, #0x3f
	strh r2, [r1, #0x3e]
	ldr r1, [r5, #0x5e4]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	bl Player__InitState
	ldr r0, [r5, #0x5e4]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Player__Func_2022C40(Player *player)
{
    if (StageTaskStateMatches(&player->objWork, Player__State_CannonLanched))
    {
        player->objWork.moveFlag &=
            ~(STAGE_TASK_MOVE_FLAG_IN_AIR | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES);
        player->objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        player->gimmickFlag &= ~(PLAYER_GIMMICK_80 | PLAYER_GIMMICK_40 | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10);

        player->gimmickCamOffsetX = 0;
        player->gimmickCamOffsetY = 0;
        player->playerFlag &= ~(PLAYER_FLAG_2000 | PLAYER_FLAG_DISABLE_TENSION_DRAIN);
        player->colliders[0].defPower = PLAYER_DEFPOWER_NORMAL;

        player->objWork.dir.y = 0;
        Player__Action_Launch(player);

        player->objWork.velocity.x = player->objWork.move.x;
        player->objWork.velocity.y = player->objWork.move.y;
    }
}

void Player__Func_2022CD4(Player *player, u32 flags)
{
    u32 id = flags & ~0x80000000;
    if (StageTaskStateMatches(&player->objWork, Player__State_CannonLanched))
    {
        if (id >= 3)
            id = 0;

        player->objWork.userFlag = (player->objWork.userFlag | (1 << (id + 1))) & ~0x20;

        if (flags & 0x80000000)
            player->objWork.userFlag |= 0x20;
    }
}

void Player__Func_2022D24(Player *player, u8 flag)
{
    if (StageTaskStateMatches(&player->objWork, Player__State_CannonLanched))
        player->objWork.userFlag &= ~(1 << (flag + 1));
}

void Player__Gimmick_JumpBox(Player *player, GameObjectTask *other, CharacterID characterID)
{
    if ((player->playerFlag & PLAYER_FLAG_DEATH) != 0)
        return;

    Player__InitGimmick(player, FALSE);
    player->gimmickObj = other;

    Player__ChangeAction(player, PLAYER_ACTION_HANG_ROT);

    player->objWork.displayFlag |= DISPLAY_FLAG_PAUSED;
    Player__SetAnimFrame(player, FLOAT_TO_FX32(35.0));
    player->objWork.userTimer = FLOAT_TO_FX32(35.0);

    if (player->characterID == characterID)
        player->objWork.userFlag = FALSE;
    else
        player->objWork.userFlag = TRUE;

    player->gimmickFlag |= PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10;
    player->gimmickCamOffsetX = 0;
    player->gimmickCamOffsetY = 64;

    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;

    player->objWork.velocity.x = player->objWork.velocity.y = 0;

    player->objWork.dir.z    = FLOAT_DEG_TO_IDX(0.0);
    player->objWork.userWork = JUMPBOX_STATE_CLIMBING;

    player->gimmick.jumpBox.progress = FLOAT_TO_FX32(0.0);
    player->gimmick.jumpBox.startX   = player->objWork.position.x;
    player->gimmick.jumpBox.startY   = player->objWork.position.y;

    SetTaskState(&player->objWork, Player__State_JumpBox);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_JUMP);
}

NONMATCH_FUNC void Player__State_JumpBox(Player *work)
{
    // https://decomp.me/scratch/2HcIQ -> 99.97%
    // small register issue around dir.z
#ifdef NON_MATCHING
    GameObjectTask *gimmickObj = work->gimmickObj;
    fx32 xOffset;
    fx32 launchDir;
    u16 dir;
    u16 id;
    u32 x, y;
    u32 velXStore, velYStore;

    if (work->gimmickObj == NULL)
    {
        work->actionJump(work);
        return;
    }

    work->objWork.prevPosition = work->objWork.position;

    switch (work->objWork.userWork)
    {
            // preparing...
            // the player is moving towards the target position to vault over here
        case JUMPBOX_STATE_CLIMBING:
            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                xOffset = -FLOAT_TO_FX32(2.0);
            else
                xOffset = FLOAT_TO_FX32(2.0);

            work->objWork.userTimer -= FLOAT_TO_FX32(0.625);
            work->gimmick.jumpBox.progress += FLOAT_TO_FX32(0.125);

            if (work->gimmick.jumpBox.progress >= FLOAT_TO_FX32(1.0))
            {
                work->objWork.userWork++;
                work->objWork.position.x = gimmickObj->objWork.position.x;
                work->objWork.position.y = gimmickObj->objWork.position.y - FLOAT_TO_FX32(62.0);
                EffectButtonPrompt__Create(&work->objWork, 1);
            }
            else
            {
                work->objWork.position.x = mtLerp(work->gimmick.jumpBox.progress, work->gimmick.jumpBox.startX, gimmickObj->objWork.position.x + xOffset);
                work->objWork.position.y = mtLerpEx(work->gimmick.jumpBox.progress, work->gimmick.jumpBox.startY, gimmickObj->objWork.position.y - FLOAT_TO_FX32(62.0), 2);
            }

            break;

            // main action area: press the jump button!!
            // player is vaulting over the jumpbox here!
        case JUMPBOX_STATE_VAULTING:
            work->objWork.userTimer += -FLOAT_TO_FX32(1.208251953125);
            if (work->objWork.userTimer <= FLOAT_TO_FX32(1.0))
            {
                work->objWork.userWork++;
                work->gimmick.jumpBox.animSpeed = -FLOAT_TO_FX32(1.208251953125);
                break;
            }

            if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
            {
                id               = work->gimmickObj->mapObject->id;
                work->gimmickObj = NULL;
                work->gimmickFlag &= ~(PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10);
                work->gimmickCamOffsetX = 0;
                work->gimmickCamOffsetY = 0;
                work->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;
                work->objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
                work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);

                launchDir = (work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0 ? -1 : 1;

                if ((work->objWork.userFlag & CHARACTER_BLAZE) != 0)
                {
                    if (id == MAPOBJECT_240)
                    {
                        y = gimmickObj->mapObject->height;
                        x = gimmickObj->mapObject->width;

                        if (y > 16)
                            y = 16;

                        if (x > 4)
                            x = 4;

                        Player__Action_JumpBoxPlaneSwitchLaunch(work, launchDir * (FLOAT_TO_FX32(1.3125) * x + FLOAT_TO_FX32(7.5)), -FLOAT_TO_FX32(1.3125) * y - FLOAT_TO_FX32(4.0),
                                                                FLOAT_TO_FX32(4.0));
                    }
                    else
                    {
                        x = MTM_MATH_CLIP(gimmickObj->mapObject->top, 0, 4);

                        Player__Action_JumpBoxLaunch(work, launchDir * (FLOAT_TO_FX32(1.3125) * x + FLOAT_TO_FX32(7.5)), -FLOAT_TO_FX32(4.0));
                    }
                }
                else
                {
                    dir = MultiplyFX(FX_Div(work->objWork.userTimer, NNS_G3dAnmObjGetNumFrame(work->objWork.obj_3d->ani.currentAnimObj[B3D_ANIM_JOINT_ANIM])), FLOAT_TO_FX32(16.0));

                    if (id == MAPOBJECT_240)
                    {
                        y = MTM_MATH_CLIP(gimmickObj->mapObject->top, 0, 16);
                        x = MTM_MATH_CLIP(gimmickObj->mapObject->left, 0, 9);

                        Player__Action_JumpBoxPlaneSwitchLaunch(work, launchDir * (FLOAT_TO_FX32(1.3125) * x + FLOAT_TO_FX32(2.0)), -FLOAT_TO_FX32(1.3125) * y - FLOAT_TO_FX32(7.5),
                                                                -FLOAT_TO_FX32(4.0));
                    }
                    else
                    {
                        y = MTM_MATH_CLIP(gimmickObj->mapObject->left, 0, 16);

                        Player__Action_JumpBoxLaunch(work, FX32_FROM_WHOLE(launchDir << 1), -FLOAT_TO_FX32(1.3125) * y - FLOAT_TO_FX32(7.5));
                    }

                    if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    {
                        dir = FLOAT_DEG_TO_IDX(180.0) + dir;
                    }
                    else
                    {
                        dir = FLOAT_DEG_TO_IDX(180.0) - dir;
                    }
                    work->objWork.dir.z = dir;
                }

                Player__Action_AllowTrickCombos(work, gimmickObj);
                PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TOBIBAKO);
                return;
            }
            break;

            // reached the other side of the jumpbox... its over
            // player is vaulting over the other side of the jumpbox here
        case JUMPBOX_STATE_VAULTED:
            work->objWork.userTimer += work->gimmick.jumpBox.animSpeed;
            work->gimmick.jumpBox.animSpeed -= FLOAT_TO_FX32(0.0625);

            if (work->objWork.userTimer < 0)
            {
                work->objWork.userTimer += NNS_G3dAnmObjGetNumFrame(work->objWork.obj_3d->ani.currentAnimObj[B3D_ANIM_JOINT_ANIM]) - 1;
                work->objWork.userWork++;

                if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    work->objWork.velocity.x = -FLOAT_TO_FX32(2.0);
                else
                    work->objWork.velocity.x = FLOAT_TO_FX32(2.0);

                work->objWork.velocity.y = FLOAT_TO_FX32(0.5);
            }

            break;

            // finishing up...
            // player is letting go of the jump bpx here
        case JUMPBOX_STATE_EXIT:
            work->objWork.userTimer += work->gimmick.jumpBox.animSpeed;
            work->gimmick.jumpBox.animSpeed -= FLOAT_TO_FX32(0.0625);

            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->objWork.velocity.x = ObjSpdUpSet(work->objWork.velocity.x, -FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(2.0));
            else
                work->objWork.velocity.x = ObjSpdUpSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.25), FLOAT_TO_FX32(2.0));

            work->objWork.velocity.y = ObjSpdUpSet(work->objWork.velocity.y, FLOAT_TO_FX32(0.03125), FLOAT_TO_FX32(5.0));
            work->objWork.position.x += work->objWork.velocity.x;
            work->objWork.position.y += work->objWork.velocity.y;

            if (work->objWork.userTimer <= FLOAT_TO_FX32(46.0))
            {
                work->gimmickObj = NULL;
                work->gimmickFlag &= ~(PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10);
                work->gimmickCamOffsetX = 0;
                work->gimmickCamOffsetY = 0;
                work->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;
                work->objWork.displayFlag &= ~DISPLAY_FLAG_PAUSED;
                work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);

                if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    work->objWork.groundVel -= FLOAT_TO_FX32(1.0);
                else
                    work->objWork.groundVel += FLOAT_TO_FX32(1.0);

                velXStore = work->objWork.velocity.x;
                velYStore = work->objWork.velocity.y;
                work->objWork.displayFlag |= DISPLAY_FLAG_ENABLE_ANIMATION_BLENDING;
                Player__Action_Launch(work);
                work->objWork.velocity.x = velXStore;
                work->objWork.velocity.y = velYStore;

                return;
            }
            break;

        default:
            break;
    }

    Player__SetAnimFrame(work, work->objWork.userTimer);
    work->objWork.move.x = work->objWork.position.x - work->objWork.prevPosition.x;
    work->objWork.move.y = work->objWork.position.y - work->objWork.prevPosition.y;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0x6d8]
	cmp r4, #0
	bne _02022E80
	ldr r1, [r5, #0x5f0]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_02022E80:
	add r0, r5, #0x44
	add r3, r5, #0x8c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r5, #0x28]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _020233C4
_02022EA0: // jump table
	b _02022EB0 // case 0
	b _02022FD0 // case 1
	b _0202323C // case 2
	b _020232B4 // case 3
_02022EB0:
	ldr r0, [r5, #0x20]
	mov r2, #0x2000
	tst r0, #1
	ldr r0, [r5, #0x2c]
	rsbeq r2, r2, #0
	sub r0, r0, #0xa00
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x6f8]
	add r0, r0, #0x200
	str r0, [r5, #0x6f8]
	cmp r0, #0x1000
	blt _02022F10
	ldr r1, [r5, #0x28]
	mov r0, r5
	add r1, r1, #1
	str r1, [r5, #0x28]
	ldr r2, [r4, #0x44]
	mov r1, #1
	str r2, [r5, #0x44]
	ldr r2, [r4, #0x48]
	sub r2, r2, #0x3e000
	str r2, [r5, #0x48]
	bl EffectButtonPrompt__Create
	b _020233C4
_02022F10:
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	ldr r1, [r4, #0x44]
	ldr r0, [r5, #0x6f0]
	add r1, r1, r2
	mov r3, r6, asr #0x1f
	mov r2, #1
	mov ip, #0
	mov r7, #0x800
_02022F34:
	sub r8, r1, r0
	umull lr, r9, r8, r6
	mla r9, r8, r3, r9
	mov r8, r8, asr #0x1f
	mla r9, r8, r6, r9
	adds lr, lr, r7
	adc r8, r9, ip
	mov r9, lr, lsr #0xc
	orr r9, r9, r8, lsl #20
	cmp r2, #0
	add r0, r0, r9
	sub r2, r2, #1
	bne _02022F34
	str r0, [r5, #0x44]
	ldr r0, [r5, #0x6f8]
	ldr r1, [r4, #0x48]
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	ldr r0, [r5, #0x6f4]
	sub r1, r1, #0x3e000
	mov r3, r4, asr #0x1f
	mov r2, #2
	mov r7, #0
	mov r6, #0x800
_02022F94:
	sub ip, r1, r0
	umull r8, lr, ip, r4
	mla lr, ip, r3, lr
	mov ip, ip, asr #0x1f
	adds r9, r8, r6
	mla lr, ip, r4, lr
	adc r8, lr, r7
	mov r9, r9, lsr #0xc
	orr r9, r9, r8, lsl #20
	cmp r2, #0
	add r0, r0, r9
	sub r2, r2, #1
	bne _02022F94
	str r0, [r5, #0x48]
	b _020233C4
_02022FD0:
	ldr r1, [r5, #0x2c]
	ldr r0, =0xFFFFECAB
	add r1, r1, r0
	str r1, [r5, #0x2c]
	cmp r1, #0x1000
	bgt _02022FFC
	ldr r1, [r5, #0x28]
	add r1, r1, #1
	str r1, [r5, #0x28]
	str r0, [r5, #0x6fc]
	b _020233C4
_02022FFC:
	add r0, r5, #0x700
	ldrh r0, [r0, #0x22]
	tst r0, #3
	beq _020233C4
	ldr r1, [r5, #0x6d8]
	mov r0, #0
	ldr r2, [r1, #0x340]
	add r1, r5, #0x600
	ldrh r6, [r2, #2]
	str r0, [r5, #0x6d8]
	ldr r2, [r5, #0x5dc]
	bic r2, r2, #0x30
	str r2, [r5, #0x5dc]
	strh r0, [r1, #0xdc]
	strh r0, [r1, #0xde]
	ldr r1, [r5, #0x5d8]
	bic r1, r1, #0x100000
	str r1, [r5, #0x5d8]
	ldr r1, [r5, #0x20]
	bic r1, r1, #0x10
	str r1, [r5, #0x20]
	ldr r1, [r5, #0x1c]
	bic r1, r1, #0x2100
	str r1, [r5, #0x1c]
	ldr r1, [r5, #0x20]
	tst r1, #1
	subne r7, r0, #1
	ldr r0, [r5, #0x24]
	moveq r7, #1
	tst r0, #1
	beq _02023100
	cmp r6, #0xf0
	ldr r0, [r4, #0x340]
	bne _020230C8
	ldrb r3, [r0, #9]
	ldrb r2, [r0, #8]
	mov r0, #0x1500
	cmp r3, #0x10
	movhi r3, #0x10
	cmp r2, #4
	movhi r2, #4
	mul r1, r2, r0
	sub r0, r0, #0x2a00
	mul r2, r3, r0
	add r1, r1, #0x7800
	mul r1, r7, r1
	mov r0, r5
	sub r2, r2, #0x4000
	mov r3, #0x4000
	bl Player__Action_JumpBoxPlaneSwitchLaunch
	b _02023200
_020230C8:
	ldrsb r1, [r0, #7]
	cmp r1, #0
	movlt r1, #0
	blt _020230E0
	cmp r1, #4
	movgt r1, #4
_020230E0:
	mov r2, #0x1500
	mul r0, r1, r2
	add r0, r0, #0x7800
	mul r1, r7, r0
	mov r0, r5
	sub r2, r2, #0x5500
	bl Player__Action_JumpBoxLaunch
	b _02023200
_02023100:
	ldr r1, [r5, #0x12c]
	ldr r0, [r5, #0x2c]
	ldr r1, [r1, #0xe4]
	ldr r1, [r1, #8]
	ldrh r1, [r1, #4]
	mov r1, r1, lsl #0xc
	bl FX_Div
	mov r1, r0, asr #0x1f
	mov r2, r1, lsl #0x10
	mov r1, #0x800
	adds r1, r1, r0, lsl #16
	orr r2, r2, r0, lsr #16
	adc r0, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	mov r0, r1, lsl #0x10
	cmp r6, #0xf0
	mov r6, r0, lsr #0x10
	mov r0, #0
	ldr r1, [r4, #0x340]
	bne _020231B0
	ldrsb r8, [r1, #7]
	cmp r8, #0
	movlt r8, r0
	blt _0202316C
	cmp r8, #0x10
	movgt r8, #0x10
_0202316C:
	ldrsb r0, [r1, #6]
	cmp r0, #0
	movlt r0, #0
	blt _02023184
	cmp r0, #9
	movgt r0, #9
_02023184:
	mov r3, #0x1500
	mul r1, r0, r3
	sub r0, r3, #0x2a00
	add r1, r1, #0x2000
	mul r2, r8, r0
	mul r1, r7, r1
	mov r0, r5
	sub r2, r2, #0x7800
	sub r3, r3, #0x5500
	bl Player__Action_JumpBoxPlaneSwitchLaunch
	b _020231E4
_020231B0:
	ldrsb r1, [r1, #6]
	cmp r1, #0
	movlt r1, r0
	blt _020231C8
	cmp r1, #0x10
	movgt r1, #0x10
_020231C8:
	mov r0, #0x1500
	rsb r0, r0, #0
	mul r2, r1, r0
	mov r0, r5
	mov r1, r7, lsl #0xd
	sub r2, r2, #0x7800
	bl Player__Action_JumpBoxLaunch
_020231E4:
	ldr r0, [r5, #0x20]
	tst r0, #1
	addne r0, r6, #0x8000
	rsbeq r0, r6, #0x8000
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	strh r6, [r5, #0x34]
_02023200:
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	mov r4, #0x6b
	sub r1, r4, #0x6c
	add r0, r5, #0x254
	mov r2, #0
	str r2, [sp]
	mov r2, r1
	mov r3, r1
	add r0, r0, #0x400
	str r4, [sp, #4]
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0202323C:
	ldr r1, [r5, #0x2c]
	ldr r0, [r5, #0x6fc]
	add r0, r1, r0
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x6fc]
	sub r0, r0, #0x100
	str r0, [r5, #0x6fc]
	ldr r0, [r5, #0x2c]
	cmp r0, #0
	bge _020233C4
	ldr r0, [r5, #0x12c]
	ldr r1, [r5, #0x2c]
	ldr r0, [r0, #0xe4]
	ldr r0, [r0, #8]
	ldrh r0, [r0, #4]
	mov r0, r0, lsl #0xc
	sub r0, r0, #1
	add r0, r1, r0
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	ldr r0, [r5, #0x20]
	tst r0, #1
	mov r0, #0x2000
	rsbne r0, r0, #0
	str r0, [r5, #0x98]
	mov r0, #0x800
	str r0, [r5, #0x9c]
	b _020233C4
_020232B4:
	ldr r1, [r5, #0x2c]
	ldr r0, [r5, #0x6fc]
	mov r2, #0x2000
	add r0, r1, r0
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x6fc]
	mov r1, #0x400
	sub r0, r0, #0x100
	str r0, [r5, #0x6fc]
	ldr r0, [r5, #0x20]
	tst r0, #1
	ldr r0, [r5, #0x98]
	beq _020232F4
	rsb r1, r1, #0
	bl ObjSpdUpSet
	b _020232F8
_020232F4:
	bl ObjSpdUpSet
_020232F8:
	str r0, [r5, #0x98]
	ldr r0, [r5, #0x9c]
	mov r1, #0x80
	mov r2, #0x5000
	bl ObjSpdUpSet
	str r0, [r5, #0x9c]
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x98]
	add r0, r1, r0
	str r0, [r5, #0x44]
	ldr r1, [r5, #0x48]
	ldr r0, [r5, #0x9c]
	add r0, r1, r0
	str r0, [r5, #0x48]
	ldr r0, [r5, #0x2c]
	cmp r0, #0x2e000
	bgt _020233C4
	mov r2, #0
	str r2, [r5, #0x6d8]
	ldr r1, [r5, #0x5dc]
	add r0, r5, #0x600
	bic r1, r1, #0x30
	str r1, [r5, #0x5dc]
	strh r2, [r0, #0xdc]
	strh r2, [r0, #0xde]
	ldr r0, [r5, #0x5d8]
	bic r0, r0, #0x100000
	str r0, [r5, #0x5d8]
	ldr r0, [r5, #0x20]
	bic r0, r0, #0x10
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x1c]
	bic r0, r0, #0x2100
	str r0, [r5, #0x1c]
	ldr r0, [r5, #0x20]
	tst r0, #1
	ldr r0, [r5, #0xc8]
	subne r0, r0, #0x1000
	addeq r0, r0, #0x1000
	str r0, [r5, #0xc8]
	ldr r0, [r5, #0x20]
	ldr r4, [r5, #0x98]
	orr r1, r0, #0x400
	ldr r6, [r5, #0x9c]
	mov r0, r5
	str r1, [r5, #0x20]
	bl Player__Action_Launch
	str r4, [r5, #0x98]
	add sp, sp, #8
	str r6, [r5, #0x9c]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_020233C4:
	ldr r1, [r5, #0x2c]
	mov r0, r5
	bl Player__SetAnimFrame
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x8c]
	sub r0, r1, r0
	str r0, [r5, #0xbc]
	ldr r1, [r5, #0x48]
	ldr r0, [r5, #0x90]
	sub r0, r1, r0
	str r0, [r5, #0xc0]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}

void Player__Action_JumpBoxLaunch(Player *player, fx32 velX, fx32 velY)
{
    Player__Action_GimmickLaunch(player, velX, velY);

    if (MATH_ABS(velY) > MATH_ABS(velX))
    {
        if ((player->gimmickFlag & PLAYER_GIMMICK_SNOWBOARD) == 0)
        {
            Player__ChangeAction(player, PLAYER_ACTION_AIRRISE);
        }
        else
        {
            Player__ChangeAction(player, PLAYER_ACTION_AIRRISE_SNOWBOARD);
            ChangePlayerSnowboardAction(player, PLAYERSNOWBOARD_ACTION_AIRRISE);
        }
    }
}

void Player__Action_JumpBoxPlaneSwitchLaunch(Player *player, fx32 velX, fx32 velY, fx32 velZ)
{
    player->objWork.groundVel  = 0;
    player->objWork.velocity.x = player->objWork.velocity.y = 0;

    Player__Action_GimmickLaunch(player, velX, velY);
    Player__ChangeAction(player, PLAYER_ACTION_AIRRISE);
    player->objWork.velocity.z = velZ;
    player->playerFlag |= PLAYER_FLAG_DISABLE_INPUT_READ | PLAYER_FLAG_SLOWMO | PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_FINISHED_TRICK_COMBO;
    player->slomoTimer   = 0;
    player->inputKeyDown = player->inputKeyPress = player->inputKeyRepeat = PAD_INPUT_NONE_MASK;
    player->gimmickFlag |= PLAYER_GIMMICK_20000000;

    if (velZ <= 0)
        player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
    else
        player->objWork.flag &= ~STAGE_TASK_FLAG_ON_PLANE_B;

    if (velZ < 0)
    {
        if (velX >= 0)
        {
            player->objWork.dir.y = -FLOAT_DEG_TO_IDX(45.0);
        }
        else
        {
            player->objWork.dir.y = FLOAT_DEG_TO_IDX(45.0);
        }
    }
    else
    {
        if (velX >= 0)
        {
            player->objWork.dir.y = FLOAT_DEG_TO_IDX(45.0);
        }
        else
        {
            player->objWork.dir.y = -FLOAT_DEG_TO_IDX(45.0);
        }
    }

    player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;

    SetTaskState(&player->objWork, Player__State_JumpBoxPlaneSwitchLaunch);
}

void Player__State_JumpBoxPlaneSwitchLaunch(Player *work)
{
    work->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;

    if (work->objWork.velocity.z >= 0)
    {
        if (work->objWork.position.z + work->objWork.velocity.z >= FLOAT_TO_FX32(50.0))
        {
            work->objWork.velocity.z = FLOAT_TO_FX32(50.0) - work->objWork.position.z;
        }
    }
    else
    {
        if (work->objWork.position.z + work->objWork.velocity.z <= -FLOAT_TO_FX32(80.0))
        {
            work->objWork.velocity.z = -FLOAT_TO_FX32(80.0) - work->objWork.position.z;
        }
    }

    work->objWork.dir.y = ObjRoopMove16(work->objWork.dir.y, 0, FLOAT_TO_FX32(0.03125));

    Player__State_Air(work);

    if (!StageTaskStateMatches(&work->objWork, Player__State_JumpBoxPlaneSwitchLaunch))
    {
        work->playerFlag &= ~(PLAYER_FLAG_DISABLE_INPUT_READ | PLAYER_FLAG_SLOWMO);
        work->objWork.dir.y         = 0;
        work->colliders[0].defPower = PLAYER_DEFPOWER_NORMAL;
    }
}

void Player__Action_PlaneSwitchSpring(Player *player, fx32 velX, fx32 velY)
{
    player->objWork.groundVel  = 0;
    player->objWork.velocity.x = player->objWork.velocity.y = 0;

    Player__Action_GimmickLaunch(player, velX, velY);
    player->playerFlag |= PLAYER_FLAG_SLOWMO | PLAYER_FLAG_DISABLE_TRICK_FINISHER | PLAYER_FLAG_USER_FLAG;
    player->slomoTimer = 0;

    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPRING);

    if (player->objWork.position.z < 0)
    {
        player->objWork.velocity.z = FLOAT_TO_FX32(4.0);
    }
    else if (player->objWork.position.z > 0)
    {
        player->objWork.velocity.z = -FLOAT_TO_FX32(3.0);
    }

    player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;
    SetTaskState(&player->objWork, Player__State_PlaneSwitchSpring);
}

void Player__State_PlaneSwitchSpring(Player *work)
{
    u16 targetDir = 0;
    fx32 speed    = FLOAT_TO_FX32(0.0625);

    if (work->objWork.velocity.z >= 0)
    {
        if (work->objWork.position.z + work->objWork.velocity.z >= 0)
        {
            work->objWork.velocity.z = -work->objWork.position.z;
        }
    }
    else
    {
        if (work->objWork.position.z + work->objWork.velocity.z <= 0)
        {
            work->objWork.velocity.z = -work->objWork.position.z;
        }
    }

    if (work->objWork.velocity.z < 0)
    {
        speed = FLOAT_TO_FX32(0.25);

        if (work->objWork.velocity.x >= 0)
            targetDir = -FLOAT_DEG_TO_IDX(45.0);
        else
            targetDir = FLOAT_DEG_TO_IDX(45.0);
    }
    else if (work->objWork.velocity.z > 0)
    {
        speed = FLOAT_TO_FX32(0.25);

        if (work->objWork.velocity.x >= 0)
            targetDir = FLOAT_DEG_TO_IDX(45.0);
        else
            targetDir = -FLOAT_DEG_TO_IDX(45.0);
    }

    work->objWork.dir.y = ObjRoopMove16(work->objWork.dir.y, targetDir, speed);

    Player__State_Air(work);

    if (!StageTaskStateMatches(&work->objWork, Player__State_PlaneSwitchSpring) || (work->objWork.velocity.z == 0 && work->objWork.dir.y == 0))
    {
        work->objWork.dir.y = 0;
        work->gimmickFlag &= ~PLAYER_GIMMICK_20000000;
        work->playerFlag &= ~PLAYER_FLAG_SLOWMO;
    }
}

void Player_Action_EnterFarPlane(Player *player)
{
    if (!StageTaskStateMatches(&player->objWork, Player__State_PlaneSwitchSpring) && !StageTaskStateMatches(&player->objWork, Player__State_JumpBoxPlaneSwitchLaunch))
    {
        player->gimmickFlag &= ~PLAYER_GIMMICK_20000000;
        player->objWork.flag |= STAGE_TASK_FLAG_ON_PLANE_B;

        if (player->objWork.position.z != FLOAT_TO_FX32(0.0))
            player->blazeHoverTimer = 0;
    }
}

void Player__Action_EnterSlingshot(Player *player, GameObjectTask *other)
{
    Player__Action_FollowParent(player, other, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));
    SetTaskState(&player->objWork, Player__State_Slingshot);

    player->playerFlag |= PLAYER_FLAG_FINISHED_TRICK_COMBO;
    player->objWork.userFlag |= PLAYER_CHILDFLAG_CAN_JUMP | PLAYER_CHILDFLAG_FOLLOW_PREV_POS | PLAYER_CHILDFLAG_FORCE_LAUNCH_ACTION;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    player->gimmickFlag |= PLAYER_GIMMICK_GRABBED | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10;
    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;

    player->gimmickCamOffsetX = 0;
    player->gimmickCamOffsetY = 160;
    Player__ChangeAction(player, PLAYER_ACTION_CRANE);

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    player->objWork.displayFlag |= other->objWork.displayFlag & DISPLAY_FLAG_FLIP_X;

    player->objWork.dir.x = player->objWork.dir.y = player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
}

void Player__State_Slingshot(Player *work)
{
    GameObjectTask *slingshot = work->gimmickObj;

    fx32 velX;
    fx32 velY;
    u32 angle;

    velX = FLOAT_TO_FX32(0.0);
    velY = FLOAT_TO_FX32(0.0);

    if (slingshot != NULL && (slingshot->objWork.userFlag & SLINGSHOT_FLAG_ROCK_LAUNCHED) == 0 && (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
    {
        velX = slingshot->objWork.velocity.x;
        velY = slingshot->objWork.velocity.y;

        angle = slingshot->objWork.dir.z;
        if (angle > FLOAT_DEG_TO_IDX(180.0))
            angle = FLOAT_DEG_TO_IDX(0.0);

        fx32 force = MultiplyFX(velX, CosFX(angle));
        velY -= (force >> 1);
        velX -= force;
    }

    Player__State_FollowParent(work);

    if (velX != FLOAT_TO_FX32(0.0) || velY != FLOAT_TO_FX32(0.0))
    {
        work->objWork.velocity.x  = velX;
        work->objWork.velocity.y  = velY;
        work->overSpeedLimitTimer = 64;
        work->playerFlag |= PLAYER_FLAG_USER_FLAG;
    }

    if (!StageTaskStateMatches(&work->objWork, Player__State_Slingshot) && slingshot != NULL)
        Player__Action_AllowTrickCombos(work, slingshot);
}

void Player__Action_RideDolphin(Player *player, GameObjectTask *dolphin)
{
    Player__InitGimmick(player, FALSE);
    Player__InitState(player);

    player->gimmickObj = dolphin;
    SetTaskState(&player->objWork, Player__State_DolphinRide);
    ObjRect__SetOnDefend(&player->colliders[0], Player__OnDefend_DolphinRide);

    player->objWork.moveFlag |= STAGE_TASK_FLAG_DISABLE_OBJ_2D_RELEASE | STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT;
    player->objWork.moveFlag &= ~(STAGE_TASK_FLAG_DISABLE_STATE | STAGE_TASK_FLAG_ALLOCATED_SPRITE_PALETTE);

    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    player->objWork.displayFlag |= dolphin->objWork.displayFlag & DISPLAY_FLAG_FLIP_X;
    Player__Action_StopBoost(player);
    Player__Action_StopSuperBoost(player);
    player->gimmickFlag |= PLAYER_GIMMICK_10;
    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN | PLAYER_FLAG_2000;

    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        player->gimmickCamOffsetX = 112;
    else
        player->gimmickCamOffsetX = -112;

    player->gimmickCamOffsetY = 0;
    Player__ChangeAction(player, PLAYER_ACTION_DOLPHIN_RIDE);
    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_ROTATE_CAMERA_DIR;

    player->objWork.position = dolphin->objWork.position;

    player->objWork.dir.x = player->objWork.dir.y = player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

    player->objWork.groundVel  = FLOAT_TO_FX32(0.0);
    player->objWork.velocity.x = player->objWork.velocity.y = FLOAT_TO_FX32(0.0);
}

void Player__State_DolphinRide(Player *work)
{
    GameObjectTask *dolphin = work->gimmickObj;

    u16 btnDown = PAD_INPUT_NONE_MASK;
    u16 btnForward;
    u16 btnBackward;
    fx32 step;
    fx32 stepForward;

    if (dolphin != NULL && (dolphin->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_ANY) != 0)
    {
        Player__LeaveDolphinRide(work);

        fx32 velX;
        if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
            velX = -FLOAT_TO_FX32(2.0);
        else
            velX = FLOAT_TO_FX32(2.0);

        Player__Action_Knockback_NoHurt(work, velX, -FLOAT_TO_FX32(3.0));
    }
    else
    {
        if ((work->objWork.userFlag & 1) != 0)
        {
            work->objWork.userTimer += FLOAT_TO_FX32(0.03125);
            if (work->objWork.userTimer < FLOAT_TO_FX32(0.5))
            {
                work->objWork.velocity.z = mtLerpEx2(2 * work->objWork.userTimer, work->gimmick.dolphinRide.startZ,
                                                     work->gimmick.dolphinRide.startZ + ((work->gimmick.dolphinRide.targetZ - work->gimmick.dolphinRide.startZ) >> 1), 1)
                                           - work->objWork.position.z;
            }
            else if (work->objWork.userTimer < FLOAT_TO_FX32(1.0))
            {
                work->objWork.velocity.z =
                    mtLerp(2 * (work->objWork.userTimer - FLOAT_TO_FX32(0.5)),
                           work->gimmick.dolphinRide.startZ + ((work->gimmick.dolphinRide.targetZ - work->gimmick.dolphinRide.startZ) >> 1), work->gimmick.dolphinRide.targetZ)
                    - work->objWork.position.z;
            }
            else
            {
                work->objWork.velocity.z =
                    mtLerp(FLOAT_TO_FX32(1.0), (work->gimmick.dolphinRide.targetZ - work->gimmick.dolphinRide.startZ) >> 1, work->gimmick.dolphinRide.targetZ)
                    - work->objWork.position.z;
                work->objWork.userFlag &= ~1;
            }

            work->objWork.dir.y = FX_Atan2Idx(work->objWork.position.z - work->objWork.prevPosition.z, work->objWork.position.x - work->objWork.prevPosition.x);
            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->objWork.dir.y += FLOAT_DEG_TO_IDX(180.0);
        }
        else
        {
            work->objWork.dir.y      = FLOAT_DEG_TO_IDX(0.0);
            work->objWork.velocity.z = FLOAT_TO_FX32(0.0);

            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            {
                stepForward = -FLOAT_TO_FX32(0.125);
                btnForward  = PAD_KEY_LEFT;
                btnBackward = PAD_KEY_RIGHT;
                step        = FLOAT_TO_FX32(0.125);
            }
            else
            {
                btnBackward = PAD_KEY_LEFT;
                step        = -FLOAT_TO_FX32(0.125);
                stepForward = FLOAT_TO_FX32(0.125);
                btnForward  = PAD_KEY_RIGHT;
            }

            btnDown = work->inputKeyDown;

            // default behaviour - accelerate towards default speed
            if (MATH_ABS(work->objWork.groundVel) < FLOAT_TO_FX32(4.0))
                work->objWork.groundVel = ObjSpdUpSet(work->objWork.groundVel, stepForward, FLOAT_TO_FX32(4.0));

            if ((btnDown & btnForward) != 0)
            {
                // holding forward behaviour - accelerate towards top speed
                if (MATH_ABS(work->objWork.groundVel) < FLOAT_TO_FX32(6.0))
                    work->objWork.groundVel = ObjSpdUpSet(work->objWork.groundVel, stepForward, FLOAT_TO_FX32(6.0));
            }
            else if ((btnDown & btnBackward) != 0)
            {
                // holding backwward behaviour - deccelerate towards slow speed
                if (stepForward > 0)
                {
                    if (work->objWork.groundVel > FLOAT_TO_FX32(2.0))
                    {
                        work->objWork.groundVel = ObjSpdDownSet(work->objWork.groundVel, FLOAT_TO_FX32(0.25));
                        if (work->objWork.groundVel < FLOAT_TO_FX32(2.0))
                            work->objWork.groundVel = FLOAT_TO_FX32(2.0);
                    }
                }
                else
                {
                    if (work->objWork.groundVel < -FLOAT_TO_FX32(2.0))
                    {
                        work->objWork.groundVel = ObjSpdDownSet(work->objWork.groundVel, FLOAT_TO_FX32(0.25));
                        if (work->objWork.groundVel > -FLOAT_TO_FX32(2.0))
                            work->objWork.groundVel = -FLOAT_TO_FX32(2.0);
                    }
                }
            }
            else
            {
                if (stepForward > 0)
                {
                    if (work->objWork.groundVel > FLOAT_TO_FX32(4.0))
                    {
                        work->objWork.groundVel = ObjSpdDownSet(work->objWork.groundVel, FLOAT_TO_FX32(0.25));
                        if (work->objWork.groundVel < FLOAT_TO_FX32(4.0))
                            work->objWork.groundVel = FLOAT_TO_FX32(4.0);
                    }
                }
                else
                {
                    if (work->objWork.groundVel < -FLOAT_TO_FX32(4.0))
                    {
                        work->objWork.groundVel = ObjSpdDownSet(work->objWork.groundVel, FLOAT_TO_FX32(0.25));
                        if (work->objWork.groundVel > -FLOAT_TO_FX32(4.0))
                            work->objWork.groundVel = -FLOAT_TO_FX32(4.0);
                    }
                }
            }

            if (work->objWork.position.z != FLOAT_TO_FX32(0.0) && work->starComboCount == 0)
            {
                work->objWork.userFlag |= 1;
                work->objWork.userTimer           = 0;
                work->gimmick.dolphinRide.startZ  = work->objWork.position.z;
                work->gimmick.dolphinRide.targetZ = FLOAT_TO_FX32(0.0);
            }
        }

        if (FX32_TO_WHOLE(work->objWork.position.y) <= mapCamera.camera[work->cameraID].waterLevel)
        {
            work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
        }
        else
        {
            if ((btnDown & PAD_KEY_UP) != 0)
                work->objWork.dir.z = ObjSpdUpSet((s16)work->objWork.dir.z, step, FLOAT_TO_FX32(1.5));
        }

        if ((btnDown & PAD_KEY_DOWN) != 0)
        {
            work->objWork.dir.z = ObjSpdUpSet((s16)work->objWork.dir.z, stepForward, FLOAT_TO_FX32(1.5));
        }
        else if ((btnDown & PAD_KEY_UP) == 0)
        {
            work->objWork.dir.z = ObjRoopMove16(work->objWork.dir.z, 0, 0x200);
        }

        if ((work->playerFlag & PLAYER_FLAG_IN_WATER) == 0 && (playerGameStatus.stageTimer & 7) == 0)
        {
            fx32 velX;
            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                velX = -FLOAT_TO_FX32(6.0);
            else
                velX = FLOAT_TO_FX32(6.0);

            EffectWaterGush__Create(&work->objWork, velX, -FLOAT_TO_FX32(2.0), 1);
        }
    }
}

void Player__Action_FinalDolphinHoop(Player *player, GameObjectTask *hoop)
{
    if (StageTaskStateMatches(&player->objWork, Player__State_DolphinRide))
        SetTaskState(&player->objWork, Player__State_ExitDolphinRide);
}

void Player__State_ExitDolphinRide(Player *work)
{
    GameObjectTask *dolphin = work->gimmickObj;

    if (dolphin != NULL && (dolphin->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_LWALL) != 0)
    {
        Player__LeaveDolphinRide(work);

        fx32 velX;
        if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
            velX = -FLOAT_TO_FX32(2.0);
        else
            velX = FLOAT_TO_FX32(2.0);
        Player__Action_Knockback_NoHurt(work, velX, -FLOAT_TO_FX32(3.0));
    }
    else if ((work->playerFlag & PLAYER_FLAG_IN_WATER) == 0)
    {
        Player__LeaveDolphinRide(work);
        Player__Action_GimmickLaunch(work, FLOAT_TO_FX32(0.0), -FLOAT_TO_FX32(8.0));

        if (dolphin != NULL)
            Player__Action_AllowTrickCombos(work, dolphin);
    }
    else
    {
        fx32 accel;
        s16 angleAccel;

        if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        {
            accel      = -FLOAT_TO_FX32(0.25);
            angleAccel = FLOAT_DEG_TO_IDX(4.21875);

            if (work->objWork.dir.z > FLOAT_DEG_TO_IDX(180.0))
                angleAccel += FLOAT_DEG_TO_IDX(4.21875);
        }
        else
        {
            accel      = FLOAT_TO_FX32(0.25);
            angleAccel = -FLOAT_DEG_TO_IDX(4.21875);

            if (work->objWork.dir.z < FLOAT_DEG_TO_IDX(180.0))
                angleAccel -= FLOAT_DEG_TO_IDX(4.21875);
        }

        work->objWork.groundVel = ObjSpdUpSet(work->objWork.groundVel, accel, FLOAT_TO_FX32(10.0));
        work->objWork.dir.z     = ObjSpdUpSet((s16)work->objWork.dir.z, angleAccel, FLOAT_DEG_TO_IDX(90.0));
    }
}

void Player__LeaveDolphinRide(Player *player)
{
    player->gimmickObj = NULL;

    player->objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    player->gimmickFlag &= ~(PLAYER_GIMMICK_40 | PLAYER_GIMMICK_10);
    player->playerFlag &= ~(PLAYER_FLAG_2000 | PLAYER_FLAG_DISABLE_TENSION_DRAIN);
    player->gimmickCamOffsetX = 0;
    player->gimmickCamOffsetY = 0;

    ObjRect__SetOnDefend(&player->colliders[0], Player__OnDefend_Regular);
}

void Player__OnDefend_DolphinRide(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    Player *player = (Player *)rect2->parent;

    Player__LeaveDolphinRide(player);
    Player__OnDefend_Regular(rect1, rect2);
}

void Player__Action_DolphinHoop(Player *player, GameObjectTask *hoop)
{
    MapObject *mapObject = hoop->mapObject;
    if (StageTaskStateMatches(&player->objWork, Player__State_DolphinRide) && (player->objWork.userFlag & PLAYER_FLAG_USER_FLAG) == 0)
    {
        Player__GiveScore(player, PLAYER_SCOREBONUS_TRICK);

        s32 tension;
        if (mapObject->id == MAPOBJECT_221)
        {
            tension = PLAYER_TENSION_TRICKFINISH >> player->tensionPenalty;
            StarCombo__FinishTrickCombo(player, player->tensionPenalty);
            Player__Action_FinalDolphinHoop(player, hoop);
        }
        else
        {
            tension = PLAYER_TENSION_TRICK >> player->tensionPenalty;
            StarCombo__PerformTrick(player);

            if (mapObject->id >= MAPOBJECT_216 && mapObject->id <= MAPOBJECT_219)
            {
                player->objWork.userFlag |= PLAYER_FLAG_USER_FLAG;
                player->objWork.userTimer = 0;

                switch (mapObject->id)
                {
                    case MAPOBJECT_216:
                        player->gimmick.dolphinRide.startZ  = FLOAT_TO_FX32(0.0);
                        player->gimmick.dolphinRide.targetZ = FLOAT_TO_FX32(90.0);
                        break;

                    case MAPOBJECT_218:
                        player->gimmick.dolphinRide.startZ  = FLOAT_TO_FX32(0.0);
                        player->gimmick.dolphinRide.targetZ = -FLOAT_TO_FX32(90.0);
                        break;

                    case MAPOBJECT_217:
                        player->gimmick.dolphinRide.startZ  = FLOAT_TO_FX32(90.0);
                        player->gimmick.dolphinRide.targetZ = FLOAT_TO_FX32(0.0);
                        break;

                    case MAPOBJECT_219:
                        player->gimmick.dolphinRide.startZ  = -FLOAT_TO_FX32(90.0);
                        player->gimmick.dolphinRide.targetZ = FLOAT_TO_FX32(0.0);
                        break;
                }
            }
            else
            {
                if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                    player->objWork.groundVel = ObjSpdUpSet(player->objWork.groundVel, -FLOAT_TO_FX32(5.0), FLOAT_TO_FX32(8.0));
                else
                    player->objWork.groundVel = ObjSpdUpSet(player->objWork.groundVel, FLOAT_TO_FX32(5.0), FLOAT_TO_FX32(8.0));
            }
        }

        Player__GiveTension(player, tension);
    }
}

void Player__Action_HoverCrystal(Player *player, GameObjectTask *other, fx32 left, fx32 y, fx32 right)
{
    if (StageTaskStateMatches(&player->objWork, Player__State_HoverCrystal))
    {
        player->gimmick.hoverCrystal.boundsL = left - FLOAT_TO_FX32(1.0);

        if (y < player->gimmick.hoverCrystal.targetY || player->gimmick.hoverCrystal.targetY == FLOAT_TO_FX32(0.0))
            player->gimmick.hoverCrystal.targetY = y;

        player->gimmick.hoverCrystal.boundsR = right + FLOAT_TO_FX32(1.0);
        player->gimmickObj                   = other;
    }
    else
    {
        if ((player->objWork.position.y >= y || (other->objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
            && (player->objWork.position.y <= y || (other->objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) == 0))
        {
            Player__InitGimmick(player, FALSE);
            Player__ChangeAction(player, PLAYER_ACTION_HOVER_CRYSTAL);
            player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;

            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
                player->objWork.velocity.x = player->objWork.groundVel;

            s32 weight = other->mapObject->flags & HOVERCRYSTAL_OBJFLAG_WEIGHT_MASK;
            if (weight != 0)
            {
                player->objWork.velocity.x >>= weight;
                player->objWork.velocity.y >>= weight;
                player->objWork.groundVel >>= weight;
            }
            player->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

            player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
            player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
            player->objWork.userFlag = 0;

            player->gimmickFlag |= PLAYER_GIMMICK_GRABBED;
            player->gimmickObj                   = other;
            player->gimmick.hoverCrystal.boundsL = left - FLOAT_TO_FX32(1.0);
            player->gimmick.hoverCrystal.targetY = y;
            player->gimmick.hoverCrystal.boundsR = right + FLOAT_TO_FX32(1.0);

            SetTaskState(&player->objWork, Player__State_HoverCrystal);

            PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_AIR_SWITCH);
        }
    }
}

void Player__State_HoverCrystal(Player *work)
{
    Player__HandleAirMovement(work);

    if (work->gimmickObj != NULL)
    {
        if ((work->objWork.position.y > work->gimmick.hoverCrystal.targetY && (work->objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) == 0)
            || (work->objWork.position.y < work->gimmick.hoverCrystal.targetY && (work->objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0))
        {
            work->objWork.velocity.y = ObjSpdUpSet(work->objWork.velocity.y, -FLOAT_TO_FX32(0.1953125), FLOAT_TO_FX32(4.5));
            work->objWork.userFlag |= 1;
        }
        else
        {
            if (work->objWork.velocity.y < 0)
            {
                if (MATH_ABS(work->objWork.move.y) > FLOAT_TO_FX32(2.0))
                    work->objWork.velocity.y = ObjSpdDownSet(work->objWork.velocity.y, FLOAT_TO_FX32(0.40625));
            }

            work->objWork.velocity.y = ObjSpdUpSet(work->objWork.velocity.y, FLOAT_TO_FX32(0.1953125), FLOAT_TO_FX32(4.5));

            if ((work->objWork.userFlag & 1) != 0)
            {
                work->objWork.userFlag &= ~1;
                PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_AIR_SWITCH);
            }
        }

        if (work->objWork.position.x <= work->gimmick.hoverCrystal.boundsL || work->objWork.position.x >= work->gimmick.hoverCrystal.boundsR)
            work->gimmickObj = NULL;
    }

    if (work->gimmickObj != NULL)
    {
        work->gimmick.hoverCrystal.targetY = FLOAT_TO_FX32(0.0);
    }
    else
    {
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_IN_AIR;
        work->gimmickFlag &= ~PLAYER_GIMMICK_GRABBED;
        Player__Action_LandOnGround(work, 0);
        work->actionGroundIdle(work);
    }
}

void Player__Action_BalloonRide(Player *player, GameObjectTask *balloon, fx32 floatSpeed)
{
    Player__InitPhysics(player);
    Player__InitGimmick(player, FALSE);

    FadeOutPlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES, 32);
    ReleasePlayerSfx(player, PLAYER_SEQPLAYER_GRINDTRICKSUCCES);
    Player__ChangeAction(player, PLAYER_ACTION_BALLOON_RIDE);

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    player->objWork.velocity.x >>= 1;
    player->objWork.velocity.y >>= 2;
    player->objWork.groundVel >>= 1;
    player->objWork.dir.z      = FLOAT_DEG_TO_IDX(0.0);
    player->objWork.position.x = balloon->objWork.position.x;
    player->objWork.position.y = balloon->objWork.position.y + FLOAT_TO_FX32(16.0);
    player->objWork.position.z = balloon->objWork.position.z;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_IN_AIR;
    player->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_HAS_GRAVITY;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;

    player->gimmickObj = balloon;
    player->gimmickFlag |= PLAYER_GIMMICK_4000000;
    player->gimmickCamGimmickCenterOffsetY = 64;
    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;
    player->gimmick.balloonRide.floatSpeed = floatSpeed;

    SetTaskState(&player->objWork, Player__State_BalloonRide);
    Player__Action_StopBoost(player);
    Player__Action_StopSuperBoost(player);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GIMMICK);
}

void Player__State_BalloonRide(Player *work)
{
    GameObjectTask *balloon = work->gimmickObj;

    if (balloon == NULL || IsStageTaskDestroyedAny(&balloon->objWork) || (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
    {
        work->gimmickObj = NULL;
        work->gimmickFlag &= ~PLAYER_GIMMICK_4000000;
        work->gimmickCamGimmickCenterOffsetY = 0;
        work->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_IN_AIR;

        if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
        {
            work->objWork.velocity.x = FLOAT_TO_FX32(0.0);
            work->objWork.velocity.y = FLOAT_TO_FX32(0.0);
            work->objWork.groundVel  = FLOAT_TO_FX32(0.0);
            work->actionJump(work);
        }
        else
        {
            Player__Action_LandOnGround(work, FLOAT_DEG_TO_IDX(0.0));
            work->actionGroundIdle(work);
        }
    }
    else
    {
        work->objWork.velocity.y = ObjSpdUpSet(work->objWork.velocity.y, -FLOAT_TO_FX32(0.0625), work->gimmick.balloonRide.floatSpeed);

        if ((work->inputKeyDown & (PAD_KEY_LEFT | PAD_KEY_RIGHT)) != 0)
        {
            if ((work->inputKeyDown & PAD_KEY_RIGHT) != 0)
            {
                work->objWork.velocity.x = ObjSpdUpSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.0625), FLOAT_TO_FX32(5.0));
                work->objWork.dir.z      = ObjSpdUpSet((s16)work->objWork.dir.z, FLOAT_DEG_TO_IDX(0.3515625), FLOAT_DEG_TO_IDX(22.5));
            }
            else
            {
                work->objWork.velocity.x = ObjSpdUpSet(work->objWork.velocity.x, -FLOAT_TO_FX32(0.0625), FLOAT_TO_FX32(5.0));
                work->objWork.dir.z      = ObjSpdUpSet((s16)work->objWork.dir.z, -FLOAT_DEG_TO_IDX(0.3515625), FLOAT_DEG_TO_IDX(22.5));
            }
        }
        else
        {
            work->objWork.velocity.x = ObjSpdDownSet(work->objWork.velocity.x, FLOAT_TO_FX32(0.0625));
            work->objWork.dir.z      = ObjRoopMove16(work->objWork.dir.z, FLOAT_DEG_TO_IDX(0.0), FLOAT_DEG_TO_IDX(0.17578125));
        }
    }
}

void Player__Action_WaterGun(Player *player, GameObjectTask *other)
{
    Player__InitGimmick(player, FALSE);
    player->gimmickObj = other;
    Player__ChangeAction(player, PLAYER_ACTION_WATERGUN_02);

    player->objWork.groundVel  = FLOAT_TO_FX32(0.0);
    player->objWork.velocity.x = player->objWork.velocity.y = FLOAT_TO_FX32(0.0);
    player->objWork.dir.z                                   = FLOAT_DEG_TO_IDX(0.0);
    player->objWork.position.x                              = other->objWork.position.x;
    player->objWork.position.z                              = other->objWork.position.z;

    if ((other->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        player->objWork.position.x += FLOAT_TO_FX32(30.0);
    else
        player->objWork.position.x -= FLOAT_TO_FX32(30.0);

    player->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
    player->objWork.displayFlag |= other->objWork.displayFlag & DISPLAY_FLAG_FLIP_X;
    player->gimmickFlag |= PLAYER_GIMMICK_GRABBED | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10;
    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN;
    player->gimmickCamOffsetY = 32;

    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        player->gimmickCamOffsetX = 60;
    else
        player->gimmickCamOffsetX = -60;

    player->colliders[0].defPower = PLAYER_DEFPOWER_INVINCIBLE;
    player->blinkTimer            = 0;
    player->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    SetTaskState(&player->objWork, Player__State_WaterGun);
    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_GIMMICK);
}

NONMATCH_FUNC void Player__State_WaterGun(Player *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x6d8]
	cmp r2, #0
	beq _02024840
	ldr r1, [r2, #0x18]
	tst r1, #0xc
	bne _02024840
	ldr r1, [r2, #0x24]
	tst r1, #1
	beq _02024894
_02024840:
	mov r1, #0
	str r1, [r4, #0x6d8]
	ldr r3, [r4, #0x5dc]
	ldr r0, =0xFFFDFF0F
	add r2, r4, #0x600
	and r0, r3, r0
	str r0, [r4, #0x5dc]
	ldr r0, [r4, #0x5d8]
	add r3, r4, #0x500
	bic r0, r0, #0x100000
	str r0, [r4, #0x5d8]
	strh r1, [r2, #0xdc]
	strh r1, [r2, #0xde]
	mov r2, #0x3f
	mov r0, r4
	strh r2, [r3, #0x3e]
	bl Player__Action_LandOnGround
	ldr r1, [r4, #0x5e4]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
_02024894:
	tst r1, #2
	add r1, r4, #0x500
	ldrsh r1, [r1, #0xd4]
	beq _020248C0
	cmp r1, #0x3b
	ldmeqia sp!, {r4, pc}
	mov r1, #0x3b
	bl Player__ChangeAction
	mov r0, #0x8000
	str r0, [r4, #4]
	ldmia sp!, {r4, pc}
_020248C0:
	cmp r1, #0x3c
	ldmeqia sp!, {r4, pc}
	mov r1, #0x3c
	bl Player__ChangeAction
	mov r0, #0x8000
	str r0, [r4, #4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void Player__Action_Bungee(Player *player, GameObjectTask *bungee, fx32 startX, fx32 startY)
{
    fx32 groundVel = player->objWork.groundVel;

    Player__InitGimmick(player, FALSE);
    player->gimmickObj = bungee;
    Player__ChangeAction(player, PLAYER_ACTION_BUNGEE);

    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    SetTaskState(&player->objWork, Player__State_Bungee);
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_4000 | STAGE_TASK_MOVE_FLAG_IN_AIR;
    player->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES);
    player->playerFlag |= PLAYER_GIMMICK_BUNGEE;

    if (player->objWork.dir.z == FLOAT_DEG_TO_IDX(90.0) || player->objWork.dir.z == FLOAT_DEG_TO_IDX(270.0))
    {
        if (player->objWork.groundVel > FLOAT_TO_FX32(9.0))
            player->objWork.groundVel = FLOAT_TO_FX32(9.0);

        if (player->objWork.groundVel < -FLOAT_TO_FX32(9.0))
            player->objWork.groundVel = -FLOAT_TO_FX32(9.0);
    }

    player->objWork.velocity.x = MultiplyFX(player->objWork.groundVel, CosFX(player->objWork.dir.z));
    player->objWork.velocity.y = MultiplyFX(player->objWork.groundVel, SinFX(player->objWork.dir.z));
    player->objWork.userWork   = FX32_TO_WHOLE(16 * player->objWork.groundVel) * FX32_TO_WHOLE(16 * player->objWork.groundVel) * 2;

    if (player->objWork.userWork > FLOAT_TO_FX32(8.0))
        player->objWork.userWork = FLOAT_TO_FX32(8.0);

    if (player->objWork.dir.z == FLOAT_DEG_TO_IDX(90.0) || player->objWork.dir.z == FLOAT_DEG_TO_IDX(270.0))
    {
        player->gimmick.bungee.accelX = FLOAT_TO_FX32(0.0);
        player->gimmick.bungee.accelY = -player->objWork.velocity.y >> 4;
        player->objWork.velocity.x    = FLOAT_TO_FX32(0.0);
        player->objWork.groundVel     = FLOAT_TO_FX32(0.0);
    }
    else
    {
        player->gimmick.bungee.accelX = -player->objWork.velocity.x >> 4;
        player->gimmick.bungee.accelY = -player->objWork.velocity.y >> 4;
    }

    if (groundVel < 0)
        player->objWork.dir.z -= FLOAT_DEG_TO_IDX(90.0);
    else
        player->objWork.dir.z += FLOAT_DEG_TO_IDX(90.0);

    player->gimmick.bungee.startX = startX;
    player->gimmick.bungee.startY = startY;
    player->objWork.userTimer     = 0;
    player->objWork.userFlag      = 0;

    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_BUNGY_ROPE);
}

void Player__State_Bungee(Player *work)
{
    switch (work->objWork.userFlag)
    {
        case 0:
            if (work->gimmickObj != NULL)
            {
                fx32 y = FX32_TO_WHOLE(work->gimmick.bungee.startY - work->objWork.position.y);
                fx32 x = FX32_TO_WHOLE(work->gimmick.bungee.startX - work->objWork.position.x);
                if (x * x + y * y > work->objWork.userWork)
                {
                    work->objWork.userTimer  = 8;
                    work->objWork.velocity.x = FLOAT_TO_FX32(0.0);
                    work->objWork.velocity.y = FLOAT_TO_FX32(0.0);
                    work->objWork.userFlag++;
                }
            }

            if (work->objWork.move.x == 0 && work->objWork.move.y == 0 && work->actionGroundIdle)
            {
                work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
                work->gimmickObj    = NULL;
                work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
                work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_4000);
                work->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;

                work->actionGroundIdle(work);
                return;
            }
            break;

        case 1:
            work->objWork.offset.x = FX32_FROM_WHOLE(((2 * work->objWork.userTimer + 8) & 7) - 4);
            work->objWork.offset.y = FX32_FROM_WHOLE(((2 * work->objWork.userTimer + 8) & 7) - 4);

            work->objWork.userTimer--;
            if (work->objWork.userTimer == 0)
            {
                work->objWork.userWork = 28;
                work->objWork.userFlag++;
                return;
            }
            break;

        case 2:
            work->objWork.userWork--;

            work->objWork.velocity.x += work->gimmick.bungee.accelX;
            work->objWork.velocity.y += work->gimmick.bungee.accelY;

            if (work->objWork.userWork == 0)
            {
                GameObjectTask *bungee = work->gimmickObj;

                work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
                work->gimmickObj    = NULL;
                work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
                work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_4000);
                work->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;

                Player__Action_Spring(work, work->objWork.velocity.x, work->objWork.velocity.y);
                Player__Action_AllowTrickCombos(work, bungee);
            }
            return;
    }

    if ((work->inputKeyPress & PLAYER_INPUT_JUMP) != 0 && work->actionJump != NULL)
    {
        work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);
        work->gimmickObj    = NULL;
        work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_HAS_GRAVITY | STAGE_TASK_MOVE_FLAG_USE_SLOPE_FORCES;
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_SLOPE_ANGLES | STAGE_TASK_MOVE_FLAG_4000);
        work->playerFlag &= ~PLAYER_FLAG_DISABLE_TENSION_DRAIN;
        work->actionJump(work);
    }
}

void Player__Action_SpringRope(Player *player, GameObjectTask *springRope, s32 timer)
{
    Player__InitState(player);
    player->gimmickObj = springRope;

    Player__ChangeAction(player, PLAYER_ACTION_ANCHOR_ROPE);
    player->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    SetTaskState(&player->objWork, Player__State_SpringRope);

    player->objWork.flag |= STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    player->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT | STAGE_TASK_MOVE_FLAG_IN_AIR;
    player->objWork.displayFlag &= ~(DISPLAY_FLAG_FLIP_X | DISPLAY_FLAG_ROTATE_CAMERA_DIR);

    player->playerFlag |= PLAYER_FLAG_DISABLE_TENSION_DRAIN | PLAYER_FLAG_2000;
    player->gimmickFlag |= PLAYER_GIMMICK_GRABBED | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_10;

    player->gimmickCamOffsetX = player->gimmickCamOffsetY = 0;
    player->objWork.velocity.x = player->objWork.velocity.y = player->objWork.velocity.z = FLOAT_TO_FX32(0.0);

    player->objWork.groundVel        = FLOAT_TO_FX32(0.375);
    player->objWork.dir.z            = FLOAT_DEG_TO_IDX(0.0);
    player->objWork.userWork         = FLOAT_DEG_TO_IDX(337.5);
    player->gimmick.springRope.angle = 0;
    player->objWork.userTimer        = timer;

    PlayPlayerSfx(player, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPRING);
}

void Player__State_SpringRope(Player *work)
{
    if (work->gimmickObj == NULL || (work->inputKeyPress & PLAYER_INPUT_JUMP) != 0)
    {
        work->gimmickObj = NULL;

        work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
        work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
        work->playerFlag &= ~(PLAYER_FLAG_2000 | PLAYER_FLAG_DISABLE_TENSION_DRAIN);
        work->gimmickFlag &= ~(PLAYER_GIMMICK_10 | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_GRABBED);
        work->objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        work->objWork.dir.x = work->objWork.dir.y = work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

        work->actionJump(work);
    }
    else
    {
        u16 lastDir = work->objWork.dir.y;

        work->objWork.groundVel = ObjSpdUpSet(work->objWork.groundVel, FLOAT_TO_FX32(0.0234375), FLOAT_TO_FX32(2.5));
        work->gimmick.springRope.angle -= 6 * work->objWork.groundVel;
        work->objWork.dir.y = work->gimmick.springRope.angle >> 4;

        if (work->objWork.dir.y > lastDir)
            PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_MAKIKOMI);

        if (work->objWork.dir.y < FLOAT_DEG_TO_IDX(180.0) && lastDir >= FLOAT_DEG_TO_IDX(180.0))
            PlayPlayerSfx(work, PLAYER_SEQPLAYER_COMMON, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_MAKIKOMI);

        work->objWork.userTimer -= work->objWork.groundVel;

        if (work->objWork.userWork && work->objWork.userWork < (FLOAT_DEG_TO_IDX(360.0) - 1))
        {
            work->objWork.userWork += FLOAT_DEG_TO_IDX(0.3515625);
            if (work->objWork.userWork > (FLOAT_DEG_TO_IDX(360.0) - 1))
                work->objWork.userWork = FLOAT_DEG_TO_IDX(0.0);
        }
        else
        {
            work->objWork.userWork = FLOAT_DEG_TO_IDX(0.0);
        }

        work->objWork.prevPosition = work->objWork.position;

        FXMatrix33 mtx;
        FXMatrix33 mtxTemp;
        MTX_Identity33(mtx.nnMtx);
        MTX_RotZ33(mtxTemp.nnMtx, SinFX((s32)(u16)work->objWork.userWork), CosFX((s32)(u16)work->objWork.userWork));
        MTX_Concat33(mtx.nnMtx, mtxTemp.nnMtx, mtx.nnMtx);
        MTX_RotY33(mtxTemp.nnMtx, SinFX((s32)(u16)-work->objWork.dir.y), CosFX((s32)(u16)-work->objWork.dir.y));
        MTX_Concat33(mtx.nnMtx, mtxTemp.nnMtx, mtx.nnMtx);

        VecFx32 position;
        position.x = work->objWork.userTimer;
        position.y = FLOAT_TO_FX32(0.0);
        position.z = FLOAT_TO_FX32(0.0);
        MTX_MultVec33(&position, mtx.nnMtx, &position);

        work->objWork.position.x = work->gimmickObj->objWork.position.x - position.x;
        work->objWork.position.y = work->gimmickObj->objWork.position.y - position.y;
        work->objWork.position.z = work->gimmickObj->objWork.position.z - position.z;

        work->objWork.move.x = work->objWork.position.x - work->objWork.prevPosition.x;
        work->objWork.move.y = work->objWork.position.y - work->objWork.prevPosition.y;
        work->objWork.move.z = work->objWork.position.z - work->objWork.prevPosition.z;

        if (work->objWork.userTimer < FLOAT_TO_FX32(6.0))
        {
            work->gimmickObj = NULL;

            work->objWork.flag &= ~STAGE_TASK_FLAG_NO_OBJ_COLLISION;
            work->objWork.moveFlag &= ~(STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT);
            work->playerFlag &= ~(PLAYER_FLAG_2000 | PLAYER_FLAG_DISABLE_TENSION_DRAIN);
            work->gimmickFlag &= ~(PLAYER_GIMMICK_10 | PLAYER_GIMMICK_20 | PLAYER_GIMMICK_GRABBED);
            work->objWork.displayFlag |= DISPLAY_FLAG_ROTATE_CAMERA_DIR;
            work->objWork.groundVel = FLOAT_TO_FX32(0.0);
            work->objWork.dir.x = work->objWork.dir.y = work->objWork.dir.z = FLOAT_DEG_TO_IDX(0.0);

            work->actionJump(work);
        }
    }
}