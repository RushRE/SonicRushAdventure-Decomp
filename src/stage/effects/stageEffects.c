// Effect System Headers
#include <stage/effectTask.h>
#include <stage/gameObject.h>

// Common Effect Headers
#include <stage/effects/explosion.h>
#include <stage/effects/found.h>
#include <stage/effects/vitality.h>
#include <stage/effects/enemyDebris.h>
#include <stage/effects/waterExplosion.h>
#include <stage/effects/groundExplosion.h>
#include <stage/effects/battleBurst.h>

// Zone Effect Headers
#include <stage/effects/steamBlasterSmoke.h>
#include <stage/effects/steamBlasterSteam.h>
#include <stage/effects/waterSplash.h>
#include <stage/effects/waterWake.h>
#include <stage/effects/waterGush.h>
#include <stage/effects/waterBubble.h>
#include <stage/effects/coralDebris.h>
#include <stage/effects/bridgeDebris.h>
#include <stage/effects/iceSparkles.h>
#include <stage/effects/startDash.h>
#include <stage/effects/breakableObjDebris.h>
#include <stage/effects/goalJewel.h>
#include <stage/effects/bouncyMushroomPuff.h>
#include <stage/effects/pipeFlowPetal.h>
#include <stage/effects/pipeFlowSeed.h>
#include <stage/effects/steam.h>
#include <stage/effects/steamFan.h>
#include <stage/effects/piston.h>
#include <stage/effects/iceBlockDebris.h>
#include <stage/effects/truckSparkles.h>
#include <stage/effects/snowslide.h>
#include <stage/effects/truckJewel.h>
#include <stage/effects/pirateShipCannonBlast.h>
#include <stage/effects/unknown202C414.h>
#include <stage/effects/slingDust.h>
#include <stage/effects/sailboatBazookaSmoke.h>
#include <stage/effects/hoverCrystalSparkle.h>
#include <stage/effects/iceSparklesSpawner.h>
#include <stage/effects/medal.h>
#include <stage/effects/ringSparkle.h>
#include <stage/effects/buttonPrompt.h>

// Player Effect Headers
#include <stage/effects/waterSplash.h>
#include <stage/effects/waterWake.h>
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
#include <stage/effects/invincibleSparkle.h>
#include <stage/effects/snowSmoke.h>
#include <stage/effects/drownAlert.h>
#include <stage/effects/playerIcon.h>
#include <stage/effects/battleAttack.h>

// Misc Includes
#include <game/object/objectManager.h>
#include <game/stage/mapSys.h>
#include <game/stage/bossHelpers.h>
#include <game/system/allocator.h>
#include <game/stage/gameSystem.h>
#include <game/game/gameState.h>
#include <game/math/mtMath.h>
#include <game/math/akMath.h>
#include <game/object/objAction.h>
#include <game/object/obj.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/paletteAnimation.h>
#include <game/audio/spatialAudio.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED const char *aActAcEffWaterB_0;
NOT_DECOMPILED const char *aAcEffFoundBac;
NOT_DECOMPILED const char *aNsbmd;
NOT_DECOMPILED const char *aActAcGmkTruckJ;
NOT_DECOMPILED const char *aActAcGmkTruckJ_0;
NOT_DECOMPILED const char *aBpaGmkMedal;
NOT_DECOMPILED const char *aActAcDecCoralB;
NOT_DECOMPILED const char *aActAcDecSakuBa;
NOT_DECOMPILED const char *aEffeStartdash;
NOT_DECOMPILED const char *aActAcGmkBreakO;
NOT_DECOMPILED const char *aAcEffGoalJewel;
NOT_DECOMPILED const char *aActAcGmkFlipmu;
NOT_DECOMPILED const char *aActAcGmkPipeFl;
NOT_DECOMPILED const char *aActAcGmkPipeFl;
NOT_DECOMPILED const char *aActAcEffSteamD;
NOT_DECOMPILED const char *aActAcGmkSteamE;
NOT_DECOMPILED const char *aActAcGmkSteamF;
NOT_DECOMPILED const char *aModGmkPistonEf;
NOT_DECOMPILED const char *aActAcGmkIceBlo;
NOT_DECOMPILED const char *aActAcGmkTruckB;
NOT_DECOMPILED const char *aActAcGmkSnowsl;
NOT_DECOMPILED const char *aActAcGmkSnowsl;
NOT_DECOMPILED const char *aActAcGmkPirate;
NOT_DECOMPILED const char *aActAcGmkSlingD;
NOT_DECOMPILED const char *aModSbBazooka;
NOT_DECOMPILED const char *aActAcGmkAirEfB;
NOT_DECOMPILED const char *aActAcGmkMedal;
NOT_DECOMPILED const char *aAcItmRingBac_0;
NOT_DECOMPILED const char *aAcFixKeyLittle;

NOT_DECOMPILED u8 RegularShield__matList[];
NOT_DECOMPILED u8 RegularShield__shpList[];

NOT_DECOMPILED u8 MagnetShield__matList[];
NOT_DECOMPILED u8 MagnetShield__shpList[];

NOT_DECOMPILED MtxFx33 PlayerTrail__mtxIdentity;

// --------------------
// FUNCTION DECLS
// --------------------

// Common
static void HandleEffectZScale(fx32 z, fx32 *a2, fx32 *scale);

// --------------------
// FUNCTIONS
// --------------------

// ================
// COMMON FUNCTIONS
// ================

void HandleEffectZScale(fx32 z, fx32 *a2, fx32 *scale)
{
    if (z < FLOAT_TO_FX32(0.0))
    {
        z = -z;
        z = MATH_MIN(z, FLOAT_TO_FX32(100.0));

        *a2    = MultiplyFX(FLOAT_TO_FX32(0.009765625), MultiplyFX(-FLOAT_TO_FX32(5.0), z));
        *scale = MultiplyFX(FLOAT_TO_FX32(0.009765625), MultiplyFX(-FLOAT_TO_FX32(0.5), z));
    }
    else
    {
        z = MATH_MIN(z, FLOAT_TO_FX32(100.0));

        *a2    = MultiplyFX(FLOAT_TO_FX32(0.009765625), MultiplyFX(FLOAT_TO_FX32(20.0), z));
        *scale = MultiplyFX(FLOAT_TO_FX32(0.009765625), MultiplyFX(FLOAT_TO_FX32(0.625), z));
    }
}

// =====
// WATER
// =====

EffectWaterSplash *CreateEffectWaterSplashForPlayer(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectWaterSplash(&player->objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), mapCamera.camera[0].waterLevel);
}

EffectWaterWake *CreateEffectWaterWakeForPlayer(Player *player)
{
    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0)
        return NULL;

    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectWaterWake(&player->objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), mapCamera.camera[0].waterLevel, 2);
}

EffectWaterWake *CreateEffectWaterWakeForPlayer2(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    u16 type = player->objWork.move.x > FLOAT_TO_FX32(6.0);
    if (IsBossStage())
        return NULL;

    return CreateEffectWaterWake(&player->objWork, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), mapCamera.camera[0].waterLevel, type);
}

// ============
// WATER BUBBLE
// ============

void CreateEffectWaterBubbleForPlayer(Player *player, fx32 x, fx32 y, u16 duration)
{
    if (!CheckIsPlayer1(player))
        return;

    u16 type = mtMathRandRepeat(4);
    if (IsBossStage())
        return;

    switch (type)
    {
        case 0:
            EffectWaterBubble__Create(player->objWork.position.x + x + FLOAT_TO_FX32(0.0), player->objWork.position.y + y + FLOAT_TO_FX32(0.0), WATERBUBBLE_ANI_TINY_BUBBLE,
                                      duration);
            break;

        case 1:
            EffectWaterBubble__Create(player->objWork.position.x + x + FLOAT_TO_FX32(4.0), player->objWork.position.y + y + FLOAT_TO_FX32(8.0), WATERBUBBLE_ANI_SMALL_BUBBLE,
                                      duration);
            EffectWaterBubble__Create(player->objWork.position.x + x + FLOAT_TO_FX32(1.0), player->objWork.position.y + y - FLOAT_TO_FX32(3.0), WATERBUBBLE_ANI_SMALL_BUBBLE,
                                      duration);
            break;

        case 2:
            EffectWaterBubble__Create(player->objWork.position.x + x + FLOAT_TO_FX32(0.0), player->objWork.position.y + y + FLOAT_TO_FX32(0.0), WATERBUBBLE_ANI_TINY_BUBBLE,
                                      duration);
            EffectWaterBubble__Create(player->objWork.position.x + x + FLOAT_TO_FX32(2.0), player->objWork.position.y + y + FLOAT_TO_FX32(6.0), WATERBUBBLE_ANI_SMALL_BUBBLE,
                                      duration);
            break;

        case 3:
            EffectWaterBubble__Create(player->objWork.position.x + x + FLOAT_TO_FX32(0.0), player->objWork.position.y + y + FLOAT_TO_FX32(0.0), WATERBUBBLE_ANI_TINY_BUBBLE,
                                      duration);
            EffectWaterBubble__Create(player->objWork.position.x + x - FLOAT_TO_FX32(2.0), player->objWork.position.y + y + FLOAT_TO_FX32(6.0), WATERBUBBLE_ANI_SMALL_BUBBLE,
                                      duration);
            EffectWaterBubble__Create(player->objWork.position.x + x + FLOAT_TO_FX32(4.0), player->objWork.position.y + y + FLOAT_TO_FX32(9.0), WATERBUBBLE_ANI_SMALL_BUBBLE,
                                      duration);
            break;
    }
}

// ==========
// BRAKE DUST
// ==========

void CreateEffectBrakeDustForPlayer(Player *player)
{
    if (IsBossStage())
    {
        if (mapCamera.camControl.bossArenaRadius)
        {
            CreateEffectBrakeDust3DForPlayer(player, FLOAT_TO_FX32(10.0), FLOAT_TO_FX32(14.0));
        }
        else
        {
            CreateEffectBrakeDust3D(player, FLOAT_TO_FX32(10.0), FLOAT_TO_FX32(14.0));
        }
    }
    else
    {
        CreateEffectBrakeDust(player, FLOAT_TO_FX32(10.0), FLOAT_TO_FX32(14.0));
    }
}

EffectBrakeDust *CreateEffectBrakeDust(Player *parent, fx32 velX, fx32 velY)
{
    EffectBrakeDust *work = CreateEffect(EffectBrakeDust, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_kemuri_brake.bac", &EffectTask__sVars.effectBrakeDustFile, gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 30);
    StageTask__SetAnimation(&work->objWork, 0);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    work->objWork.position.x = parent->objWork.position.x;
    work->objWork.position.y = parent->objWork.position.y;

    u16 angle    = (parent->objWork.dir.z + parent->objWork.fallDir);
    fx32 newVelX = FLOAT_TO_FX32(0.5);
    fx32 newVelY = FLOAT_TO_FX32(0.0);
    fx32 accX    = FLOAT_TO_FX32(0.0625);
    fx32 accY    = -FLOAT_TO_FX32(0.0234375);

    if ((parent->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        newVelX = -newVelX;
        accX    = -accX;
        velX    = -velX;
    }

    if (parent->objWork.position.z != FLOAT_TO_FX32(0.0))
    {
        fx32 a2;
        fx32 scale;

        HandleEffectZScale(parent->objWork.position.z, &a2, &scale);
        velY += a2;
        work->objWork.scale.x += scale;
        work->objWork.scale.y += scale;

        if (scale != FLOAT_TO_FX32(0.0))
            work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    }

    if (angle != FLOAT_DEG_TO_IDX(0.0))
    {
        AkMath__Func_2002C98(newVelX, newVelY, &newVelX, &newVelY, angle);
        AkMath__Func_2002C98(accX, accY, &accX, &accY, angle);
        AkMath__Func_2002C98(velX, velY, &velX, &velY, angle);
    }

    work->objWork.position.x += velX;
    work->objWork.position.y += velY;

    work->objWork.velocity.x = newVelX;
    work->objWork.velocity.y = newVelY;

    work->objWork.acceleration.x = accX;
    work->objWork.acceleration.y = accY;

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
}

// =============
// BRAKE DUST 3D
// =============

EffectBrakeDust3D *CreateEffectBrakeDust3D(Player *parent, fx32 velX, fx32 velY)
{
    EffectBrakeDust3D *work = CreateEffect(EffectBrakeDust3D, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction3dBACLoad(&work->objWork, &work->animator, "/ac_eff_kemuri_brake3d.bac", OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, &EffectTask__sVars.effectBrakeDust3DFile,
                             gameArchiveCommon);
    work->objWork.obj_2dIn3d->ani.work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    // enable forward & backward rendering
    work->objWork.obj_2dIn3d->ani.polygonAttr.noCullFront = TRUE;
    work->objWork.obj_2dIn3d->ani.polygonAttr.noCullBack = TRUE;

    StageTask__SetAnimation(&work->objWork, 0);
    work->objWork.position.x = parent->objWork.position.x;
    work->objWork.position.y = parent->objWork.position.y;

    u16 angle    = (parent->objWork.dir.z + parent->objWork.fallDir);
    fx32 newVelX = FLOAT_TO_FX32(0.5);
    fx32 newVelY = FLOAT_TO_FX32(0.0);
    fx32 accX    = FLOAT_TO_FX32(0.0625);
    fx32 accY    = -FLOAT_TO_FX32(0.0234375);

    if ((parent->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        newVelX = -newVelX;
        accX    = -accX;
        velX    = -velX;
    }

    if (angle != 0)
    {
        AkMath__Func_2002C98(newVelX, newVelY, &newVelX, &newVelY, angle);
        AkMath__Func_2002C98(accX, accY, &accX, &accY, angle);
        AkMath__Func_2002C98(velX, velY, &velX, &velY, angle);
    }

    work->objWork.position.x += velX;
    work->objWork.position.y += velY;

    work->objWork.velocity.x = newVelX;
    work->objWork.velocity.y = newVelY;

    work->objWork.acceleration.x = accX;
    work->objWork.acceleration.y = accY;

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
}

NONMATCH_FUNC EffectBrakeDust3D *CreateEffectBrakeDust3DForPlayer(Player *parent, fx32 velX, fx32 velY)
{
    // https://decomp.me/scratch/Sz1na -> 98.89%
#ifdef NON_MATCHING
    EffectBrakeDust3D *work = CreateEffectBrakeDust3D(parent, velX, velY);

    if (work != NULL)
    {
        work->animator.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
        work->animator.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

        u16 angle = -BossStage_GetCirclePos(work->objWork.position.x, mapCamera.camControl.bossArenaLeft, mapCamera.camControl.bossArenaRight,
                                                         mapCamera.camControl.bossArenaRadius, &work->objWork.position.x, &work->objWork.position.z);

        fx32 vel                 = work->objWork.velocity.x;
        work->objWork.velocity.x = MultiplyFX(CosFX((s32)angle), vel);
        work->objWork.velocity.z = MultiplyFX(SinFX((s32)angle), vel);

        fx32 acc                     = work->objWork.acceleration.x;
        work->objWork.acceleration.x = MultiplyFX(CosFX((s32)angle), acc);
        work->objWork.acceleration.z = MultiplyFX(SinFX((s32)angle), acc);
    }

    return work;
#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl CreateEffectBrakeDust3D
	movs r4, r0
	beq _0202E4AC
	mov r0, #0x1d
	strb r0, [r4, #0x172]
	mov r0, #7
	strb r0, [r4, #0x173]
	add r0, r4, #0x44
	str r0, [sp]
	add r0, r4, #0x4c
	str r0, [sp, #4]
	ldr r3, =mapCamera
	ldr r0, [r4, #0x44]
	ldr r1, [r3, #0xfc]
	ldr r2, [r3, #0x100]
	ldr r3, [r3, #0xf8]
	bl BossStage_GetCirclePos
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	ldr r3, =FX_SinCosTable_
	mov r0, r0, lsl #1
	mov r1, r1, lsl #1
	ldrsh r0, [r3, r0]
	ldr r2, [r4, #0x98]
	ldrsh lr, [r3, r1]
	smull r1, r3, r0, r2
	adds ip, r1, #0x800
	smull r2, r1, lr, r2
	adc r3, r3, #0
	adds r2, r2, #0x800
	mov ip, ip, lsr #0xc
	orr ip, ip, r3, lsl #20
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	str ip, [r4, #0x98]
	orr r2, r2, r1, lsl #20
	str r2, [r4, #0xa0]
	ldr ip, [r4, #0xa4]
	smull r1, r2, r0, ip
	adds r3, r1, #0x800
	smull r1, r0, lr, ip
	adc r2, r2, #0
	adds r1, r1, #0x800
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	str r3, [r4, #0xa4]
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0xac]
_0202E4AC:
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// =============
// SPINDASH DUST
// =============

EffectSpindashDust *CreateEffectSmallSpindashDust(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
    {
        if (mapCamera.camControl.bossArenaRadius)
        {
            return (EffectSpindashDust *)CreateEffectSpindashDust3DForBossArena(player, -FLOAT_TO_FX32(10.0), FLOAT_TO_FX32(14.0), player->characterID,
                                                                                EFFECTSPINDASHDUST_SMALL_DUST);
        }
        else
        {
            return (EffectSpindashDust *)CreateEffectSpindashDust3D(player, -FLOAT_TO_FX32(10.0), FLOAT_TO_FX32(14.0), player->characterID, EFFECTSPINDASHDUST_SMALL_DUST);
        }
    }
    else
    {
        return CreateEffectSpindashDust(player, -FLOAT_TO_FX32(10.0), FLOAT_TO_FX32(14.0), player->characterID, EFFECTSPINDASHDUST_SMALL_DUST);
    }
}

EffectSpindashDust *CreateEffectBigSpindashDust(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
    {
        if (mapCamera.camControl.bossArenaRadius != 0)
        {
            return (EffectSpindashDust *)CreateEffectSpindashDust3DForBossArena(player, -FLOAT_TO_FX32(10.0), FLOAT_TO_FX32(14.0), player->characterID,
                                                                                EFFECTSPINDASHDUST_BIG_DUST);
        }
        else
        {
            return (EffectSpindashDust *)CreateEffectSpindashDust3D(player, -FLOAT_TO_FX32(10.0), FLOAT_TO_FX32(14.0), player->characterID, EFFECTSPINDASHDUST_BIG_DUST);
        }
    }
    else
    {
        return CreateEffectSpindashDust(player, -FLOAT_TO_FX32(10.0), FLOAT_TO_FX32(14.0), player->characterID, EFFECTSPINDASHDUST_BIG_DUST);
    }
}

EffectSpindashDust *CreateEffectSpindashDust(Player *parent, fx32 velX, fx32 velY, s32 characterID, EffectSpindashDustType type)
{
    EffectSpindashDust *work = CreateEffect(EffectSpindashDust, parent);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_kemuri_spin.bac", &EffectTask__sVars.effectSpindashDustFile, gameArchiveCommon, OBJ_DATA_GFX_AUTO);

    ObjActionAllocSpritePalette(&work->objWork, 0, 30);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    work->objWork.dir.z = parent->objWork.dir.z;
    if ((parent->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if (parent->objWork.position.z != 0)
    {
        fx32 a2;
        fx32 scale;

        HandleEffectZScale(parent->objWork.position.z, &a2, &scale);
        velY += a2;
        work->objWork.scale.x += scale;
        work->objWork.scale.y += scale;

        if (scale != 0)
            work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    }

    if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        velX = -velX;

    StageTask__ObjectSpdDirFall(&velX, &velY, parent->objWork.fallDir + parent->objWork.dir.z);
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;
    work->objWork.position.x += work->objWork.velocity.x;
    work->objWork.position.y += work->objWork.velocity.y;

    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    switch (type)
    {
        // case EFFECTSPINDASHDUST_BIG_DUST:
        default:
            StageTask__SetAnimation(&work->objWork, 2 + (2 * characterID));
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            SetTaskState(&work->objWork, EffectSpindashDust3D_State_BigDust);
            break;

        case EFFECTSPINDASHDUST_SMALL_DUST:
            StageTask__SetAnimation(&work->objWork, characterID);
            SetTaskState(&work->objWork, EffectSpindashDust3D_State_SmallDust);
            break;
    }

    return work;
}

// ================
// SPINDASH DUST 3D
// ================

EffectSpindashDust3D *CreateEffectSpindashDust3D(Player *parent, fx32 velX, fx32 velY, s32 characterID, EffectSpindashDustType type)
{
    EffectSpindashDust3D *work = CreateEffect(EffectSpindashDust3D, parent);
    if (work == NULL)
        return NULL;

    ObjObjectAction3dBACLoad(&work->objWork, &work->animator, "/ac_eff_kemuri_spin_3d.bac", OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, &EffectTask__sVars.effectSpindashDust3DFile,
                             gameArchiveCommon);
    work->objWork.obj_2dIn3d->ani.work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    work->objWork.obj_2dIn3d->ani.work.matrixOpIDs[1] = MATRIX_OP_NONE;
    // disable forward & backward culling
    work->objWork.obj_2dIn3d->ani.polygonAttr.noCullFront = TRUE;
    work->objWork.obj_2dIn3d->ani.polygonAttr.noCullBack = TRUE;

    work->objWork.dir.z = parent->objWork.dir.z;
    if ((parent->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        velX = -velX;

    StageTask__ObjectSpdDirFall(&velX, &velY, parent->objWork.fallDir + parent->objWork.dir.z);
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;
    work->objWork.position.x += work->objWork.velocity.x;
    work->objWork.position.y += work->objWork.velocity.y;

    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    switch (type)
    {
        // case EFFECTSPINDASHDUST_BIG_DUST:
        default:
            StageTask__SetAnimation(&work->objWork, 2 + (2 * characterID));
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            SetTaskState(&work->objWork, EffectSpindashDust3D_State_BigDust);
            break;

        case EFFECTSPINDASHDUST_SMALL_DUST:
            StageTask__SetAnimation(&work->objWork, characterID);
            SetTaskState(&work->objWork, EffectSpindashDust3D_State_SmallDust);
            break;
    }

    return work;
}

EffectSpindashDust3D *CreateEffectSpindashDust3DForBossArena(Player *player, fx32 velX, fx32 velY, s32 characterID, EffectSpindashDustType type)
{
    EffectSpindashDust3D *work = CreateEffectSpindashDust3D(player, velX, velY, characterID, type);

    if (work != NULL)
    {
        work->animator.ani.work.matrixOpIDs[0] = MATRIX_OP_SET_CAMERA_ROT_33;
        work->animator.ani.work.matrixOpIDs[1] = MATRIX_OP_FLUSH_P_CAMERA3D;

        BossStage_GetCirclePos(work->objWork.position.x, mapCamera.camControl.bossArenaLeft, mapCamera.camControl.bossArenaRight, mapCamera.camControl.bossArenaRadius,
                                            &work->objWork.position.x, &work->objWork.position.z);
    }

    return work;
}

void EffectSpindashDust3D_State_SmallDust(EffectSpindashDust3D *work)
{
    Player *player = (Player *)work->objWork.parentObj;

    if (player != NULL)
    {
        if (!mapCamera.camControl.bossArenaRadius)
        {
            work->objWork.position.x = player->objWork.position.x;
            work->objWork.position.y = work->objWork.parentObj->position.y;
            work->objWork.position.x += work->objWork.velocity.x;
            work->objWork.position.y += work->objWork.velocity.y;

            if (work->objWork.parentObj->groundVel != 0)
                work->objWork.parentObj = NULL;
        }
    }

    if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        DestroyStageTask(&work->objWork);
}

void EffectSpindashDust3D_State_BigDust(EffectSpindashDust3D *work)
{
    Player *player = (Player *)work->objWork.parentObj;

    AnimatorSprite *animator = &work->objWork.obj_2d->ani.work;
    if (animator == NULL)
        animator = &work->objWork.obj_2dIn3d->ani.animatorSprite;

    if (player != NULL)
    {
        if (animator->animID == 3 || animator->animID == 5)
        {
            if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
                DestroyStageTask(&work->objWork);
        }
        else
        {
            if (!mapCamera.camControl.bossArenaRadius)
            {
                work->objWork.position.x = player->objWork.position.x;
                work->objWork.position.y = work->objWork.parentObj->position.y;
                work->objWork.position.x += work->objWork.velocity.x;
                work->objWork.position.y += work->objWork.velocity.y;
            }

            if (player->actionState < PLAYER_ACTION_SPINDASH || player->actionState > PLAYER_ACTION_SPINDASH_CHARGE || (player->playerFlag & PLAYER_FLAG_USER_FLAG) == 0)
            {
                StageTask__SetAnimation(&work->objWork, animator->animID + 1);
                if (player->actionState < PLAYER_ACTION_SPINDASH || player->actionState > PLAYER_ACTION_SPINDASH_CHARGE)
                {
                    work->objWork.moveFlag &= ~STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
                    work->objWork.velocity.x = FLOAT_TO_FX32(1.0);
                    work->objWork.velocity.y = 0;

                    if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                        work->objWork.velocity.x = -work->objWork.velocity.x;

                    StageTask__ObjectSpdDirFall(&work->objWork.velocity.x, &work->objWork.velocity.y, player->objWork.fallDir + work->objWork.dir.z);
                }
            }
        }
    }
}

// ==========
// FLAME DUST
// ==========

EffectFlameDust *CreateEffectFlameDustForPlayer(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectFlameDust(player, -FLOAT_TO_FX32(8.0), FLOAT_TO_FX32(8.0), EFFECTFLAMEDUST_0);
}

EffectFlameDust *CreateEffectFlameDustForPlayer2(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectFlameDust(player, FLOAT_TO_FX32(12.0), FLOAT_TO_FX32(8.0), EFFECTFLAMEDUST_1);
}

EffectFlameDust *CreateEffectFlameDustForPlayer3(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectFlameDust(player, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(8.0), EFFECTFLAMEDUST_2);
}

EffectFlameDust *CreateEffectFlameDustForPlayerBlaze(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectFlameDust(player, -FLOAT_TO_FX32(18.0), FLOAT_TO_FX32(0.0), EFFECTFLAMEDUST_3);
}

EffectFlameDust *CreateEffectFlameDust(Player *player, fx32 velX, fx32 velY, EffectFlameDustType type)
{
    EffectFlameDust *work;

    u16 angle = (player->objWork.dir.z + player->objWork.fallDir);

    work = CreateEffect(EffectFlameDust, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_boost.bac", &EffectTask__sVars.effectBoostFile, gameArchiveCommon, 8);
    ObjActionAllocSpritePalette(&work->objWork, 8, 30);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);
    StageTask__SetAnimation(&work->objWork, 8);

    work->objWork.obj_2d->ani.work.spriteType = GX_OAM_MODE_XLU;

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    work->objWork.position.x = player->objWork.position.x;
    work->objWork.position.y = player->objWork.position.y;

    if (player->objWork.position.z != FLOAT_TO_FX32(0.0))
    {
        fx32 a2;
        fx32 scale;

        HandleEffectZScale(player->objWork.position.z, &a2, &scale);
        velY += a2;
        work->objWork.scale.x += scale;
        work->objWork.scale.y += scale;

        if (scale != FLOAT_TO_FX32(0.0))
            work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    }

    switch (type)
    {
        case EFFECTFLAMEDUST_0:
        default:
            work->objWork.velocity.x     = (0xFFE >> 1) - (0xFFE & mtMathRand()) + (player->objWork.move.x >> 1);
            work->objWork.velocity.y     = 0x9FF - ((0xFFE - 0xC00) & mtMathRand());
            work->objWork.acceleration.x = 0x9FF - 0x600 - ((0xFFE - 0x800) & mtMathRand());
            work->objWork.acceleration.y = 0x9FF - 0xB00 - ((0xFFE - 0xE00) & mtMathRand());

            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            {
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                velX                         = -velX;
                work->objWork.acceleration.x = -work->objWork.acceleration.x;
            }

            if (angle)
                AkMath__Func_2002C98(velX, velY, &velX, &velY, angle);

            work->objWork.position.x += velX + FX32_FROM_WHOLE(mtMathRandRange(-4, 4));
            work->objWork.position.y += velY + FX32_FROM_WHOLE(mtMathRandRange(-4, 4));

            SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);
            break;

        case EFFECTFLAMEDUST_1: {
            u16 angle2 = playerGameStatus.stageTimer << 11;
            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            {
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                velX   = -velX;
                angle2 = -angle2;
            }

            fx32 y;
            AkMath__Func_2002C98(velX, 0, &velX, &y, angle2);

            if (y < 0)
                StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);

            work->objWork.velocity.x     = 0;
            work->objWork.velocity.y     = player->objWork.move.y >> 2;
            work->objWork.acceleration.x = 0;
            work->objWork.acceleration.y = -work->objWork.velocity.y >> 4;

            if (player->objWork.fallDir)
                AkMath__Func_2002C98(velX, velY, &velX, &velY, player->objWork.fallDir);

            work->objWork.position.x += velX;
            work->objWork.position.y += velY;

            SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);
            break;
        }

        case EFFECTFLAMEDUST_2:
            work->objWork.obj_2d->ani.work.animAdvance = work->objWork.obj_2d->ani.work.animAdvance >> 1;

            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            {
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
                velX = -velX;
            }

            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_Y;

            work->objWork.parentObj  = &player->objWork;
            work->objWork.velocity.y = -FLOAT_TO_FX32(0.5);

            StageTask__ObjectSpdDirFall(&velX, &velY, angle);

            velX += FX32_FROM_WHOLE(mtMathRandRange(-4, 4));
            velY += FX32_FROM_WHOLE(mtMathRandRange(-4, 4));

            work->objWork.userTimer = (playerGameStatus.stageTimer << 28) >> 16;
            work->objWork.move.x    = velX;
            work->objWork.move.y    = velY;
            work->objWork.userWork  = 512;
            work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

            SetTaskState(&work->objWork, EffectFlameDust_State_Type2);
            break;

        case EFFECTFLAMEDUST_3: {
            if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

            work->objWork.dir.z = FX_Atan2Idx(player->objWork.move.y, player->objWork.move.x);

            if (MATH_ABS(player->objWork.move.x) > MATH_ABS(player->objWork.move.y))
            {
                work->objWork.velocity.x = (0xFFE >> 1) - (0xFFE & mtMathRand()) + MATH_ABS(player->objWork.move.x >> 1);
            }
            else
            {
                work->objWork.velocity.x = (0xFFE >> 1) - (0xFFE & mtMathRand()) + MATH_ABS(player->objWork.move.y >> 1);
            }

            StageTask__ObjectSpdDirFall(&work->objWork.velocity.x, &work->objWork.velocity.y, work->objWork.dir.z);

            velX += (0xDFE >> 1) - (0xDFE & mtMathRand()) << 4;
            velY += (0xFFF - ((0xDFE + 0x1200) & mtMathRand())) << 4;

            work->objWork.acceleration.x = 16 * mtMathRandRange(-64, 64);
            work->objWork.acceleration.y = -velY >> 5;

            StageTask__ObjectSpdDirFall(&work->objWork.acceleration.x, &work->objWork.acceleration.y, work->objWork.dir.z);
            StageTask__ObjectSpdDirFall(&velX, &velY, work->objWork.dir.z);
            work->objWork.position.x += velX;
            work->objWork.position.y += velY;

            SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);
            break;
        }
    }

    return work;
}

void EffectFlameDust_State_Type2(EffectFlameDust *work)
{
    Player *player = (Player *)work->objWork.parentObj;
    if (player != NULL)
    {
        work->objWork.position.x = player->objWork.position.x + work->objWork.move.x;
        work->objWork.position.y = player->objWork.position.y + work->objWork.move.y;

        if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
            work->objWork.position.x -= work->objWork.prevPosition.x;
        else
            work->objWork.position.x += work->objWork.prevPosition.x;

        if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_Y) != 0)
            work->objWork.position.y -= work->objWork.prevPosition.y;
        else
            work->objWork.position.y += work->objWork.prevPosition.y;

        work->objWork.userTimer -= FLOAT_DEG_TO_IDX(8.4375);
        work->objWork.velocity.x = (s32)(work->objWork.userWork * CosFX((s32)(u16)work->objWork.userTimer)) >> 8;
        work->objWork.velocity.y -= FLOAT_TO_FX32(0.0390625);
        work->objWork.userWork += 24;
        work->objWork.prevPosition.x += work->objWork.velocity.x;
        work->objWork.prevPosition.y += work->objWork.velocity.y;

        if (work->objWork.velocity.x < 0)
            StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);
        else
            StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);
    }

    if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        DestroyStageTask(&work->objWork);
}

// =========
// FLAME JET
// =========

EffectFlameJet *CreateEffectFlameJetForPlayer(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
    {
        if (mapCamera.camControl.bossArenaRadius)
        {
            return (EffectFlameJet *)CreateEffectFlameJet3DForPlayer(player, -FLOAT_TO_FX32(8.0), FLOAT_TO_FX32(6.0));
        }
        else
        {
            return (EffectFlameJet *)CreateEffectFlameJet3D(player, -FLOAT_TO_FX32(8.0), FLOAT_TO_FX32(6.0));
        }
    }
    else
    {
        return CreateEffectFlameJet(player, -FLOAT_TO_FX32(8.0), FLOAT_TO_FX32(6.0));
    }
}

EffectFlameJet *CreateEffectFlameJet(Player *player, fx32 velX, fx32 velY)
{
    EffectFlameJet *work = CreateEffect(EffectFlameJet, player);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_b_jet.bac", &EffectTask__sVars.effectFlameJetFile, gameArchiveCommon, 8);
    ObjActionAllocSpritePalette(&work->objWork, 0, 30);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);
    StageTask__SetAnimation(&work->objWork, 0);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    if (player->objWork.position.z != 0)
    {
        fx32 a2;
        fx32 scale;

        HandleEffectZScale(player->objWork.position.z, &a2, &scale);
        velY += a2;
        work->objWork.scale.x += scale;
        work->objWork.scale.y += scale;

        if (scale != 0)
            work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    }

    work->objWork.dir.z = FX_Atan2Idx(-FLOAT_DEG_TO_IDX(180.0), player->objWork.velocity.x);
    work->objWork.dir.z += player->objWork.fallDir + FLOAT_DEG_TO_IDX(90.0);
    StageTask__ObjectSpdDirFall(&velX, &velY, player->objWork.fallDir + player->objWork.dir.z);
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        velX = -velX;
    }

    work->objWork.position.x += velX;
    work->objWork.position.y += velY;

    SetTaskState(&work->objWork, EffectFlameJet_State_Active);

    return work;
}

void EffectFlameJet_State_Active(EffectFlameJet *work)
{
    if (work->objWork.parentObj != NULL)
    {
        work->objWork.position.x = work->objWork.parentObj->position.x;
        work->objWork.position.y = work->objWork.parentObj->position.y;
        work->objWork.position.z = work->objWork.parentObj->position.z;

        if ((work->objWork.parentObj->displayFlag & DISPLAY_FLAG_DISABLE_ROTATION) == 0)
        {
            work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            work->objWork.displayFlag |= work->objWork.parentObj->displayFlag & DISPLAY_FLAG_FLIP_X;
            work->objWork.dir.z = FX_Atan2Idx(-FLOAT_DEG_TO_IDX(180.0), work->objWork.parentObj->velocity.x);
            work->objWork.dir.z += work->objWork.parentObj->fallDir + FLOAT_DEG_TO_IDX(90.0);

            if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->objWork.position.x -= work->objWork.velocity.x;
            else
                work->objWork.position.x += work->objWork.velocity.x;

            work->objWork.position.y += work->objWork.velocity.y;
        }
        else
        {
            VecFx32 translation;
            VEC_SetFromArray(&translation, &work->objWork.parentObj->obj_3d->ani.work.rotation.m[2][0]);

            work->objWork.position.x += MultiplyFX(-FLOAT_TO_FX32(20.0), translation.x);
            work->objWork.position.y -= MultiplyFX(-FLOAT_TO_FX32(20.0), translation.y);
            work->objWork.position.z += MultiplyFX(-FLOAT_TO_FX32(20.0), translation.z);
        }
    }

    if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        DestroyStageTask(&work->objWork);
}

// ============
// FLAME JET 3D
// ============

EffectFlameJet3D *CreateEffectFlameJet3D(Player *player, fx32 velX, fx32 velY)
{
    EffectFlameJet3D *work = CreateEffect(EffectFlameJet3D, player);
    if (work == NULL)
        return NULL;

    ObjObjectAction3dBACLoad(&work->objWork, &work->animator, "/ac_eff_b_jet3d.bac", OBJ_DATA_GFX_AUTO, OBJ_DATA_GFX_AUTO, &EffectTask__sVars.effectFlameJet3DFile,
                             gameArchiveCommon);
    work->objWork.obj_2dIn3d->ani.work.matrixOpIDs[0] = MATRIX_OP_FLUSH_VP;
    work->animator.ani.work.matrixOpIDs[0]            = MATRIX_OP_SET_CAMERA_ROT_33;
    work->animator.ani.work.matrixOpIDs[1]            = MATRIX_OP_FLUSH_P_CAMERA3D;
    StageTask__SetAnimation(&work->objWork, 0);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->objWork.dir.z = FX_Atan2Idx(-FLOAT_DEG_TO_IDX(180.0), player->objWork.velocity.x);
    work->objWork.dir.z += player->objWork.fallDir + FLOAT_DEG_TO_IDX(90.0);
    StageTask__ObjectSpdDirFall(&velX, &velY, player->objWork.fallDir + player->objWork.dir.z);
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;

    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        velX = -velX;
    }

    if ((player->objWork.displayFlag & DISPLAY_FLAG_DISABLE_ROTATION) == 0)
    {
        work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
        work->objWork.position.x += velX;
        work->objWork.position.y += velY;
    }

    SetTaskState(&work->objWork, EffectFlameJet_State_Active);

    return work;
}

EffectFlameJet3D *CreateEffectFlameJet3DForPlayer(Player *player, fx32 velX, fx32 velY)
{
    EffectFlameJet3D *work = CreateEffectFlameJet3D(player, velX, velY);

    if (work)
    {
        BossStage_GetCirclePos(work->objWork.position.x, mapCamera.camControl.bossArenaLeft, mapCamera.camControl.bossArenaRight, mapCamera.camControl.bossArenaRadius,
                                            &work->objWork.position.x, &work->objWork.position.z);

        SetTaskState(&work->objWork, EffectFlameJet3D_State_Active3D);
    }
    return work;
}

void EffectFlameJet3D_State_Active3D(EffectFlameJet3D *work)
{
    EffectFlameJet_State_Active((EffectFlameJet *)work);

    BossStage_GetCirclePos(work->objWork.position.x, mapCamera.camControl.bossArenaLeft, mapCamera.camControl.bossArenaRight, mapCamera.camControl.bossArenaRadius,
                                        &work->objWork.position.x, &work->objWork.position.z);
}

// ===========
// HUMMING TOP
// ===========

EffectHummingTop *CreateEffectHummingTopForPlayer(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectHummingTop(player, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0));
}

EffectHummingTop *CreateEffectHummingTop(Player *player, fx32 velX, fx32 velY)
{
    EffectHummingTop *work;

    u16 angle = (player->objWork.dir.z + player->objWork.fallDir);
    work      = CreateEffect(EffectHummingTop, player);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_boost.bac", &EffectTask__sVars.effectBoostFile, gameArchiveCommon, 16);
    ObjActionAllocSpritePalette(&work->objWork, 9, 31);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);
    StageTask__SetAnimation(&work->objWork, 9);
    work->objWork.obj_2d->ani.work.spriteType = GX_OAM_MODE_XLU;

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        velX = -velX;
    }

    work->objWork.fallDir = player->objWork.fallDir;

    if (angle)
        AkMath__Func_2002C98(velX, velY, &velX, &velY, angle);

    work->objWork.position.x += velX;
    work->objWork.position.y += velY;

    SetTaskState(&work->objWork, EffectHummingTop_State_Active);

    return work;
}

void EffectHummingTop_State_Active(EffectHummingTop *work)
{
    Player *player = (Player *)work->objWork.parentObj;

    if (player != NULL)
    {
        PlayerAction action = player->actionState;

        work->objWork.position.x = player->objWork.position.x;
        work->objWork.position.y = player->objWork.position.y;

        if ((player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
        {
            work->objWork.displayFlag &= ~DISPLAY_FLAG_FLIP_X;
            work->objWork.position.x -= work->objWork.velocity.x;
        }
        else
        {
            work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
            work->objWork.position.x += work->objWork.velocity.x;
        }
        work->objWork.position.y += work->objWork.velocity.y;

        if (action != PLAYER_ACTION_TRICK_FINISH_H_01 && action != PLAYER_ACTION_TRICK_FINISH_H_02 && action != PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_01
            && action != PLAYER_ACTION_TRICK_FINISH_H_SNOWBOARD_02)
            DestroyStageTask(&work->objWork);
    }
    else
    {
        DestroyStageTask(&work->objWork);
    }
}

// =====
// BOOST
// =====

EffectBoost *CreateEffectBoostSuperStartFX(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectBoost(player, 0, 0, player->characterID, EFFECTBOOST_START_SUPER);
}

EffectBoost *CreateEffectBoostAura(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectBoost(player, 0, 0, player->characterID, EFFECTBOOST_AURA);
}

EffectBoost *CreateEffectBoostParticle(Player *player, fx32 velX, fx32 velY)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectBoost(player, velX, velY, player->characterID, EFFECTBOOST_PARTICLE);
}

EffectBoost *CreateEffectBoostStartFX(Player *player, fx32 velX, fx32 velY)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectBoost(player, velX, velY, player->characterID, EFFECTBOOST_START_BOOST);
}

EffectBoost *CreateEffectBoost(Player *parent, fx32 velX, fx32 velY, s32 characterID, EffectBoostType type)
{
    const u16 animIDs[]                    = { 6, 4, 0, 2 };
    const u16 gfxSizes[CHARACTER_COUNT][4] = { { 38, 32, 8, 18 }, { 58, 32, 8, 18 } };

    EffectBoost *work = CreateEffect(EffectBoost, parent);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_boost.bac", &EffectTask__sVars.effectBoostFile, gameArchiveCommon, gfxSizes[characterID][type]);

    s32 animID;
    if (characterID != CHARACTER_SONIC)
    {
        animID = characterID + animIDs[type];
        ObjActionAllocSpritePalette(&work->objWork, animID, 30);
    }
    else
    {
        animID = characterID + animIDs[type];
        ObjActionAllocSpritePalette(&work->objWork, animID, 31);
    }

    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);
    StageTask__SetAnimation(&work->objWork, animID);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    if (parent->objWork.position.z != 0)
    {
        fx32 a2;
        fx32 scale;

        HandleEffectZScale(parent->objWork.position.z, &a2, &scale);
        velY += a2;
        work->objWork.scale.x += scale;
        work->objWork.scale.y += scale;

        if (scale != 0)
            work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    }

    work->objWork.dir.z = parent->objWork.dir.z + parent->objWork.fallDir;
    if ((work->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        velX = -velX;

    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;
    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    switch (type)
    {
        case EFFECTBOOST_START_SUPER:
        default:
            work->objWork.obj_2d->ani.work.spriteType = GX_OAM_MODE_XLU;
            work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;

            if ((parent->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

            SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);
            SetTaskOutFunc(&work->objWork, EffectBoost_Draw_Super);
            break;

        case EFFECTBOOST_AURA:
            work->objWork.obj_2d->ani.work.spriteType = GX_OAM_MODE_XLU;
            work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING | DISPLAY_FLAG_FLIP_X;

            SetTaskState(&work->objWork, EffectBoost_State_Aura);
            break;

        case EFFECTBOOST_PARTICLE:
            if ((parent->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
                work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

            StageTask__ObjectSpdDirFall(&work->objWork.velocity.x, &work->objWork.velocity.y, work->objWork.dir.z);
            SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);
            break;

        case EFFECTBOOST_START_BOOST:
            work->objWork.obj_2d->ani.work.spriteType = GX_OAM_MODE_XLU;
            work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING | DISPLAY_FLAG_FLIP_X;

            if ((parent->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) != 0)
                work->objWork.userTimer = 64;
            else
                work->objWork.userTimer = 8;

            SetTaskState(&work->objWork, EffectBoost_State_Aura);
            break;
    }

    work->objWork.position.x += work->objWork.velocity.x;
    work->objWork.position.y += work->objWork.velocity.y;

    return work;
}

void EffectBoost_Draw_Super(void)
{
    EffectBoost *work = TaskGetWorkCurrent(EffectBoost);

    StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);

    StageDisplayFlags displayFlags = work->objWork.displayFlag;
    work->objWork.displayFlag ^= DISPLAY_FLAG_FLIP_Y;
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_UPDATE;
    StageTask__Draw2D(&work->objWork, &work->objWork.obj_2d->ani);

    work->objWork.displayFlag = displayFlags;
}

void EffectBoost_State_Aura(EffectBoost *work)
{
    Player *player = (Player *)work->objWork.parentObj;
    if (player != NULL)
    {
        work->objWork.position.x = player->objWork.position.x;
        work->objWork.position.y = player->objWork.position.y;

        if (work->objWork.position.z != player->objWork.position.z)
        {
            if (player->objWork.position.z == 0)
            {
                work->objWork.scale.y = FLOAT_TO_FX32(1.0);
                work->objWork.scale.x = FLOAT_TO_FX32(1.0);

                work->objWork.velocity.y = FLOAT_TO_FX32(0.0);
            }
            else
            {
                fx32 a2Player;
                fx32 scalePlayer;
                HandleEffectZScale(player->objWork.position.z, &a2Player, &scalePlayer);

                fx32 a2Work;
                fx32 scaleWork;
                HandleEffectZScale(work->objWork.position.z, &a2Work, &scaleWork);

                work->objWork.scale.x += scalePlayer - scaleWork;
                work->objWork.velocity.y += a2Player - a2Work;
            }

            work->objWork.position.z = player->objWork.position.z;
        }

        if (player->objWork.hitstopTimer == 0)
        {
            if (player->objWork.move.x == 0 && player->objWork.move.y == 0)
                work->objWork.dir.z = player->objWork.dir.z;
            else
                work->objWork.dir.z = FX_Atan2Idx(player->objWork.move.y, player->objWork.move.x);

            if ((work->objWork.dir.z == 0 && player->objWork.fallDir == 0 && player->objWork.dir.z == 0) && (player->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
                work->objWork.dir.z += FLOAT_DEG_TO_IDX(180.0);
        }

        work->objWork.position.x += work->objWork.velocity.x;
        work->objWork.position.y += work->objWork.velocity.y;

        if ((player->gimmickFlag & PLAYER_GIMMICK_GRABBED) != 0)
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        else
            work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

        if (work->objWork.userTimer != 0)
        {
            if ((player->objWork.moveFlag & STAGE_TASK_MOVE_FLAG_TOUCHING_FLOOR) == 0 && work->objWork.userTimer > 8)
                work->objWork.userTimer = 8;

            work->objWork.userTimer--;
            if (work->objWork.userTimer == 0)
            {
                DestroyStageTask(&work->objWork);
                ObjObjectActionReleaseGfxRefs(&work->objWork);
            }
        }
        else
        {
            if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
                return;

            DestroyStageTask(&work->objWork);
            ObjObjectActionReleaseGfxRefs(&work->objWork);
        }
    }
}

// ============
// PLAYER TRAIL
// ============

NONMATCH_FUNC s32 CreateEffectPlayerTrail(Player *parent, fx32 height, u32 nodeCount, GXRgb startColor, GXRgb endColor)
{
    // should match when variables are decompiled (when 'EffectTask__sVars.trailTaskList' is able to be just 'trailTaskList')
#ifdef NON_MATCHING
    s32 id = -1;

    for (s32 i = 0; i < 2; i++)
    {
        if (EffectTask__sVars.trailTaskList[i] == NULL)
        {
            id = i;
            break;
        }
    }

    if (id == -1)
        return -1;

    EffectTask__sVars.trailIDList[id] = 0;

    EffectPlayerTrail *work = CreateEffect(EffectPlayerTrail, &parent->objWork);
    if (work == NULL)
        return -1;

    EffectTask__sVars.trailTaskList[id] = EffectTask__sVars.lastCreatedTask;
    SetTaskDestructorEvent(EffectTask__sVars.trailTaskList[id], EffectPlayerTrail_Destructor);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_OBJ_COLLISIONS | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    work->objWork.flag |= STAGE_TASK_FLAG_NO_DESTROY_WITH_PARENT;
    work->id           = id;
    work->height       = height;
    work->minNodeCount = nodeCount;

    for (s32 i = 0; i < 11; i++)
    {
        work->trailBuffer[i].next = &work->trailBuffer[i + 1];
    }
    work->trailBuffer[10].next = &work->trailBuffer[0];

    for (s32 i = 10; i > 0; i--)
    {
        work->trailBuffer[i].prev = &work->trailBuffer[i - 1];
    }
    work->trailBuffer[0].prev = &work->trailBuffer[10];

    work->trailListStart = &work->trailBuffer[0];
    HandlePlayerTrailOffset(work);
    RecordPlayerTrailBuffer(work->trailBuffer, parent, work->height);
    work->trailStartColor = startColor;
    work->trailEndColor   = endColor;
    work->unknownAlpha    = 6;
    work->startAlpha      = 18;
    work->endAlpha        = 1;
    work->vanish_time     = 10;
    work->field_2F0       = 3;

    SetTaskState(&work->objWork, EffectPlayerTrail_State_Init);
    SetTaskOutFunc(&work->objWork, EffectPlayerTrail_Draw);

    return id;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r8, r1
	mov r7, r2
	ldr r1, =0x02133F44
	mov r9, r0
	mov r6, r3
	mvn r4, #0
	mov r2, #0
_020303F8:
	ldr r0, [r1, r2, lsl #2]
	cmp r0, #0
	moveq r4, r2
	beq _02030414
	add r2, r2, #1
	cmp r2, #2
	blt _020303F8
_02030414:
	mvn r0, #0
	cmp r4, r0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r2, =0x02133F3C
	mov r3, #0
	mov r1, r9
	mov r0, #0x2f4
	strb r3, [r2, r4]
	bl CreateEffectTask
	movs r5, r0
	mvneq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	ldr r0, =EffectTask__sVars
	ldr r2, =0x02133F44
	ldr r0, [r0, #0]
	ldr r1, =EffectPlayerTrail_Destructor
	str r0, [r2, r4, lsl #2]
	bl SetTaskDestructorEvent
	ldr r1, [r5, #0x1c]
	mov r0, #0
	orr r1, r1, #0x2300
	str r1, [r5, #0x1c]
	ldr r1, [r5, #0x20]
	add r3, r5, #0x170
	orr r1, r1, #0x20
	str r1, [r5, #0x20]
	ldr r1, [r5, #0x18]
	orr r1, r1, #0x200
	str r1, [r5, #0x18]
	str r4, [r5, #0x168]
	str r8, [r5, #0x16c]
	str r7, [r5, #0x2d8]
_02030494:
	add r2, r0, #1
	add r1, r5, r0, lsl #5
	add r7, r3, r2, lsl #5
	mov r0, r2
	str r7, [r1, #0x188]
	cmp r2, #0xb
	blt _02030494
	str r3, [r5, #0x2c8]
	mov r3, #0xa
	add r2, r5, #0x170
_020304BC:
	sub r1, r3, #1
	add r0, r5, r3, lsl #5
	add r1, r2, r1, lsl #5
	sub r3, r3, #1
	str r1, [r0, #0x18c]
	cmp r3, #0
	bgt _020304BC
	add r0, r5, #0x2b0
	str r0, [r5, #0x18c]
	mov r0, r5
	str r2, [r5, #0x2d0]
	bl HandlePlayerTrailOffset
	ldr r2, [r5, #0x16c]
	mov r1, r9
	add r0, r5, #0x170
	bl RecordPlayerTrailBuffer
	add r0, r5, #0x200
	ldrh r2, [sp, #0x20]
	strh r6, [r0, #0xdc]
	mov r1, #6
	strh r2, [r0, #0xde]
	str r1, [r5, #0x2e0]
	mov r0, #0x12
	str r0, [r5, #0x2e4]
	mov r0, #1
	str r0, [r5, #0x2e8]
	mov r0, #0xa
	str r0, [r5, #0x2ec]
	mov r1, #3
	ldr r0, =EffectPlayerTrail_State_Init
	str r1, [r5, #0x2f0]
	ldr r1, =EffectPlayerTrail_Draw
	str r0, [r5, #0xf4]
	mov r0, r4
	str r1, [r5, #0xfc]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

void EffectPlayerTrail_Destructor(Task *task)
{
    EffectPlayerTrail *work = TaskGetWork(task, EffectPlayerTrail);

    if (EffectTask__sVars.trailTaskList[work->id] == task)
        EffectTask__sVars.trailTaskList[work->id] = NULL;

    StageTask_Destructor(task);
}

NONMATCH_FUNC void SetPlayerTrailOffset(s32 offset)
{
    // code is correct but trailXOffset isn't part of the struct, it's all individual static vars
#ifdef NON_MATCHING
    EffectTask__sVars.trailXOffset = offset;

    for (s32 i = 0; i < 2; i++)
    {
        EffectTask__sVars.trailIDList[i] = 1;
    }
#else
    // clang-format off
	ldr r1, =0x02133F40
	ldr r2, =0x02133F3C
	str r0, [r1]
	mov r1, #0
	mov r0, #1
_020305AC:
	add r1, r1, #1
	cmp r1, #2
	strb r0, [r2], #1
	blt _020305AC
	bx lr
// clang-format on
#endif
}

void EffectPlayerTrail_State_Init(EffectPlayerTrail *work)
{
    Player *player = (Player *)work->objWork.parentObj;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER && (player->playerFlag & PLAYER_FLAG_SUPERBOOST) == 0)
    {
        SetTaskState(&work->objWork, EffectPlayerTrail_State_Finish);
        EffectPlayerTrail_State_Finish(work);
    }
    else
    {
        TrailEffect *node    = work->trailListStart->next;
        work->trailListStart = node;
        HandlePlayerTrailOffset(work);
        RecordPlayerTrailBuffer(node, player, work->height);

        work->nodeCount++;
        if (work->nodeCount >= work->minNodeCount)
        {
            work->nodeCount = work->minNodeCount;
            SetTaskState(&work->objWork, EffectPlayerTrail_State_Active);
        }
        work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
    }
}

void EffectPlayerTrail_State_Active(EffectPlayerTrail *work)
{
    Player *player = (Player *)work->objWork.parentObj;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER && (player->playerFlag & PLAYER_FLAG_SUPERBOOST) == 0)
    {
        SetTaskState(&work->objWork, EffectPlayerTrail_State_Finish);
        EffectPlayerTrail_State_Finish(work);
    }
    else
    {
        TrailEffect *node    = work->trailListStart->next;
        work->trailListStart = node;

        HandlePlayerTrailOffset(work);
        RecordPlayerTrailBuffer(node, player, work->height);
    }
}

void EffectPlayerTrail_State_Finish(EffectPlayerTrail *work)
{
    Player *player = (Player *)work->objWork.parentObj;

    if (player->objWork.objType == STAGE_OBJ_TYPE_PLAYER && (player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
        DestroyStageTask(&work->objWork);
        EffectTask__sVars.trailTaskList[work->id] = 0;
    }
    else
    {
        TrailEffect *node    = work->trailListStart->next;
        work->trailListStart = node;
        HandlePlayerTrailOffset(work);
        RecordPlayerTrailBuffer(node, player, work->height);

        work->nodeCount--;
        if (work->nodeCount <= 0)
        {
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
            DestroyStageTask(&work->objWork);
            EffectTask__sVars.trailTaskList[work->id] = 0;
        }
    }
}

void RecordPlayerTrailBuffer(TrailEffect *trail, Player *player, fx32 height)
{
    MtxFx33 matTransform;
    MtxFx33 matTemp;
    VecFx32 end;
    VecFx32 start;

    fx32 z    = player->objWork.position.z;
    u16 angle = 0;

    if (z != 0)
    {
        if (z < 0)
        {
            z = -z;
            if (z > FLOAT_TO_FX32(100.0))
                z = FLOAT_TO_FX32(100.0);

            height -= MultiplyFX(FLOAT_TO_FX32(0.009765625), MultiplyFX(height >> 1, z));
        }
        else
        {
            if (z > FLOAT_TO_FX32(100.0))
                z = FLOAT_TO_FX32(100.0);

            height += MultiplyFX(FLOAT_TO_FX32(0.009765625), MultiplyFX(height, z));
        }
    }
    VEC_Set(&start, FLOAT_TO_FX32(0.0), -height >> 1, FLOAT_TO_FX32(0.0));
    VEC_Set(&end, FLOAT_TO_FX32(0.0), height >> 1, FLOAT_TO_FX32(0.0));

    if ((player->objWork.moveFlag & PLAYER_FLAG_IS_ATTACKING_PLAYER) != 0)
        angle = FX_Atan2Idx(player->objWork.position.y - player->objWork.prevPosition.y, player->objWork.position.x - player->objWork.prevPosition.x);

    MTX_RotX33(&matTransform, SinFX(player->objWork.dir.x), CosFX(player->objWork.dir.x));
    MTX_RotY33(&matTemp, SinFX(player->objWork.dir.y), CosFX(player->objWork.dir.y));
    MTX_Concat33(&matTransform, &matTemp, &matTransform);
    MTX_RotZ33(&matTemp, SinFX((s32)(u16)(player->objWork.dir.z + angle)), CosFX((s32)(u16)(player->objWork.dir.z + angle)));
    MTX_Concat33(&matTransform, &matTemp, &matTransform);

    MTX_MultVec33(&start, &matTransform, &start);
    trail->start.x = player->objWork.position.x + start.x;
    trail->start.y = player->objWork.position.y + start.y;
    trail->start.z = player->objWork.position.z + start.z;

    MTX_MultVec33(&end, &matTransform, &end);
    trail->end.x = player->objWork.position.x + end.x;
    trail->end.y = player->objWork.position.y + end.y;
    trail->end.z = player->objWork.position.z + end.z;
}

NONMATCH_FUNC void HandlePlayerTrailOffset(EffectPlayerTrail *work)
{
    // code is correct but trailIDList isn't part of the struct, it's all individual static vars
#ifdef NON_MATCHING
    TrailEffect *node = work->trailListStart;

    if (EffectTask__sVars.trailIDList[work->id])
    {
        for (s32 i = 0; i < 11; i++)
        {
            node->end.x += EffectTask__sVars.trailXOffset;
            node->start.x += EffectTask__sVars.trailXOffset;
            node = node->next;
        }

        EffectTask__sVars.trailIDList[work->id] = 0;
    }
#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r2, [r0, #0x168]
	ldr r1, =0x02133F3C
	ldr lr, [r0, #0x2d0]
	ldrb r1, [r1, r2]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r1, =0x02133F40
	mov ip, #0
_020309F0:
	ldr r3, [lr]
	ldr r2, [r1, #0]
	add ip, ip, #1
	add r2, r3, r2
	str r2, [lr]
	ldr r3, [lr, #0xc]
	ldr r2, [r1, #0]
	cmp ip, #0xb
	add r2, r3, r2
	str r2, [lr, #0xc]
	ldr lr, [lr, #0x18]
	blt _020309F0
	ldr r1, [r0, #0x168]
	ldr r0, =0x02133F3C
	mov r2, #0
	strb r2, [r0, r1]
	ldmia sp!, {r3, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectPlayerTrail_Draw(void)
{
    // https://decomp.me/scratch/Zqqul -> 99.77%
#ifdef NON_MATCHING
    VecFx32 vertices[4];
    VecFx32 baseScale;
    s32 n;
    s32 v;
    VecFx32 baseTranslation;
    EffectPlayerTrail *work;
    TrailEffect *nextNode;
    VecFx32 offset2;
    VecFx16 offset;
    Player *player;
    TrailEffect *curNode;

    work   = TaskGetWorkCurrent(EffectPlayerTrail);
    player = (Player *)work->objWork.parentObj;

    if ((work->objWork.displayFlag & DISPLAY_FLAG_DISABLE_DRAW) == 0 && work->nodeCount && (player->objWork.objType != 1 || (player->gimmickFlag & PLAYER_GIMMICK_GRABBED) == 0))
    {
        MapSys__Func_20090D0(&mapCamera.camera[0], work->trailListStart->start.x, work->trailListStart->start.y, &offset.x, &offset.y);
        offset.z = 0;

        NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);

        offset2.x = g_obj.offset[0] + FX32_TO_WHOLE(work->objWork.offset.x) - offset.x;
        offset2.y = g_obj.offset[1] + FX32_TO_WHOLE(work->objWork.offset.y) - offset.y;

        VEC_Set(&baseScale, FLOAT_TO_FX32(4096.0), FLOAT_TO_FX32(4096.0), FLOAT_TO_FX32(4096.0));

        static MtxFx33 baseRot = { FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0),
                                   FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0) };

        VEC_Set(&baseTranslation, FX32_FROM_WHOLE(offset.x), FX32_FROM_WHOLE(-offset.y), FX32_FROM_WHOLE(offset.z));
        baseTranslation.z += FLOAT_TO_FX32(1.0);

        NNS_G3dGlbSetBaseScale(&baseScale);
        NNS_G3dGlbSetBaseRot(&baseRot);
        NNS_G3dGlbSetBaseTrans(&baseTranslation);
        NNS_G3dGlbFlush();

        curNode  = work->trailListStart;
        nextNode = curNode->prev;

        fx32 timeNow = FX_DivS32(work->nodeCount * work->field_2F0, work->vanish_time);

        GXRgb inputColor0 = work->trailStartColor;
        GXRgb inputColor1 = work->trailEndColor;

        s32 nodeCount = work->nodeCount;
        for (n = 0; n < nodeCount; n++)
        {
            fx32 alpha;
            if (n <= timeNow)
            {
                if (timeNow == 0)
                {
                    alpha = work->unknownAlpha;
                }
                else
                {
                    alpha = work->unknownAlpha - FX_DivS32((work->unknownAlpha - work->startAlpha) * n, timeNow);
                }
            }
            else
            {
                if (timeNow == 0)
                {
                    alpha = work->endAlpha;
                }
                else
                {
                    alpha = work->startAlpha - FX_DivS32((work->startAlpha - work->endAlpha) * (n - timeNow), nodeCount - timeNow);
                }
            }

            NNS_G3dGePolygonAttr(GX_LIGHTMASK_NONE, GX_POLYGONMODE_MODULATE, GX_CULL_NONE, 0, alpha & 0x1F, GX_POLYGON_ATTR_MISC_NONE);

            VEC_Set(&vertices[0], curNode->start.x, curNode->start.y, curNode->start.z);
            VEC_Set(&vertices[1], curNode->end.x, curNode->end.y, curNode->end.z);
            VEC_Set(&vertices[2], nextNode->start.x, nextNode->start.y, nextNode->start.z);
            VEC_Set(&vertices[3], nextNode->end.x, nextNode->end.y, nextNode->end.z);

            NNS_G3dGeBegin(GX_BEGIN_TRIANGLE_STRIP);

            fx16 x;
            fx16 y;
            GXRgb vertexColor;
            AkMath__BlendColors(&vertexColor, inputColor0, inputColor1, nodeCount, n);

            for (v = 0; v < 4; v++)
            {
                NNS_G3dGeColor(vertexColor);

                MapSys__Func_20090D0(&mapCamera.camera[0], vertices[v].x, vertices[v].y, &x, &y);
                x += offset2.x;
                y += offset2.y;

                NNS_G3dGeVtx(x, -y, 0);
            }
            NNS_G3dGeEnd();

            curNode  = nextNode;
            nextNode = nextNode->prev;
        }
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x84
	bl GetCurrentTaskWork_
	mov r6, r0
	ldr r0, [r6, #0x20]
	ldr r1, [r6, #0x11c]
	tst r0, #0x20
	addne sp, sp, #0x84
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r6, #0x2d4]
	cmp r0, #0
	addeq sp, sp, #0x84
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [r1, #0]
	cmp r0, #1
	bne _02030A8C
	ldr r0, [r1, #0x5dc]
	tst r0, #0x20000
	addne sp, sp, #0x84
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02030A8C:
	ldr r2, [r6, #0x2d0]
	add r1, sp, #0x36
	str r1, [sp]
	ldr r1, [r2, #0xc]
	ldr r0, =mapCamera
	ldr r2, [r2, #0x10]
	add r3, sp, #0x34
	bl MapSys__Func_20090D0
	mov r4, #0
	mov r3, #2
	add r1, sp, #0x30
	mov r0, #0x10
	mov r2, #1
	strh r4, [sp, #0x38]
	str r3, [sp, #0x30]
	bl NNS_G3dGeBufferOP_N
	ldr r2, =g_obj
	ldrsh r1, [sp, #0x36]
	ldrsh r3, [sp, #0x38]
	ldrsh r8, [r2, #0xc]
	ldr r7, [r6, #0x50]
	ldrsh r5, [r2, #0xe]
	ldr r2, [r6, #0x54]
	rsb r4, r1, #0
	add r8, r8, r7, asr #12
	mov r7, #0x1000000
	ldrsh r0, [sp, #0x34]
	add r9, r5, r2, asr #12
	mov r3, r3, lsl #0xc
	mov r5, r0, lsl #0xc
	sub r8, r8, r0
	mov r4, r4, lsl #0xc
	add r2, r3, #0x1000
	add r0, sp, #0x48
	sub r9, r9, r1
	str r7, [sp, #0x48]
	str r7, [sp, #0x4c]
	str r7, [sp, #0x50]
	str r5, [sp, #0x3c]
	str r4, [sp, #0x40]
	str r2, [sp, #0x44]
	bl NNS_G3dGlbSetBaseScale
	ldr r0, =PlayerTrail__mtxIdentity
	ldr r1, =NNS_G3dGlb+0x000000BC
	bl MI_Copy36B
	ldr r1, =NNS_G3dGlb
	add r0, sp, #0x3c
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	bl NNS_G3dGlbSetBaseTrans
	bl NNS_G3dGlbFlushP
	ldr r5, [r6, #0x2d0]
	ldr r2, [r6, #0x2d4]
	ldr r0, [r6, #0x2f0]
	ldr r1, [r6, #0x2ec]
	mul r0, r2, r0
	ldr r7, [r5, #0x1c]
	bl FX_DivS32
	add r1, r6, #0x200
	mov r11, r0
	ldrh r0, [r1, #0xdc]
	mov r4, #0
	str r0, [sp, #4]
	ldrh r0, [r1, #0xde]
	str r0, [sp, #8]
	ldr r0, [r6, #0x2d4]
	str r0, [sp, #0x10]
	cmp r0, #0
	addle sp, sp, #0x84
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	sub r0, r0, r11
	str r0, [sp, #0xc]
_02030BB0:
	cmp r4, r11
	bgt _02030BE8
	cmp r11, #0
	ldreq r0, [r6, #0x2e0]
	beq _02030C18
	ldr r2, [r6, #0x2e0]
	ldr r0, [r6, #0x2e4]
	mov r1, r11
	sub r0, r2, r0
	mul r0, r4, r0
	bl FX_DivS32
	ldr r1, [r6, #0x2e0]
	sub r0, r1, r0
	b _02030C18
_02030BE8:
	cmp r11, #0
	ldreq r0, [r6, #0x2e8]
	beq _02030C18
	ldr r2, [r6, #0x2e4]
	ldr r1, [r6, #0x2e8]
	sub r0, r4, r11
	sub r1, r2, r1
	mul r0, r1, r0
	ldr r1, [sp, #0xc]
	bl FX_DivS32
	ldr r1, [r6, #0x2e4]
	sub r0, r1, r0
_02030C18:
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0xb
	orr r0, r0, #0xc0
	str r0, [sp, #0x2c]
	add r1, sp, #0x2c
	mov r0, #0x29
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r0, [r5, #0xc]
	mov r3, #2
	str r0, [sp, #0x54]
	ldr r1, [r5, #0x10]
	mov r0, #0x40
	str r1, [sp, #0x58]
	ldr r2, [r5, #0x14]
	add r1, sp, #0x28
	str r2, [sp, #0x5c]
	ldr r10, [r5, #0]
	mov r2, #1
	str r10, [sp, #0x60]
	ldr r10, [r5, #4]
	str r10, [sp, #0x64]
	ldr r5, [r5, #8]
	str r5, [sp, #0x68]
	ldr r5, [r7, #0xc]
	str r5, [sp, #0x6c]
	ldr r5, [r7, #0x10]
	str r5, [sp, #0x70]
	ldr r5, [r7, #0x14]
	str r5, [sp, #0x74]
	ldr r5, [r7, #0]
	str r5, [sp, #0x78]
	ldr r5, [r7, #4]
	str r5, [sp, #0x7c]
	ldr r5, [r7, #8]
	str r5, [sp, #0x80]
	str r3, [sp, #0x28]
	bl NNS_G3dGeBufferOP_N
	ldr r1, [sp, #4]
	ldr r2, [sp, #8]
	ldr r3, [sp, #0x10]
	add r0, sp, #0x14
	str r4, [sp]
	bl AkMath__BlendColors
	mov r5, #0
	add r10, sp, #0x54
_02030CD0:
	ldrh r2, [sp, #0x14]
	mov r0, #0x20
	add r1, sp, #0x24
	str r2, [sp, #0x24]
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x16
	str r0, [sp]
	ldr r0, =mapCamera
	add r3, sp, #0x18
	ldmia r10, {r1, r2}
	bl MapSys__Func_20090D0
	ldrsh r1, [sp, #0x16]
	ldrsh r2, [sp, #0x18]
	mov r0, #0
	add r1, r1, r9
	strh r1, [sp, #0x16]
	ldrsh ip, [sp, #0x16]
	add r2, r2, r8
	strh r2, [sp, #0x18]
	rsb ip, ip, #0
	mov ip, ip, lsl #0x10
	mov ip, ip, asr #0x10
	mov ip, ip, lsl #0x10
	str r0, [sp, #0x20]
	ldrh r3, [sp, #0x18]
	mov ip, ip, lsr #0x10
	mov r0, #0x23
	orr r3, r3, ip, lsl #16
	add r1, sp, #0x1c
	mov r2, #2
	str r3, [sp, #0x1c]
	bl NNS_G3dGeBufferOP_N
	add r5, r5, #1
	add r10, r10, #0xc
	cmp r5, #4
	blt _02030CD0
	mov r1, #0
	mov r2, r1
	mov r0, #0x41
	bl NNS_G3dGeBufferOP_N
	mov r5, r7
	ldr r0, [sp, #0x10]
	add r4, r4, #1
	cmp r4, r0
	ldr r7, [r7, #0x1c]
	blt _02030BB0
	add sp, sp, #0x84
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

// ==============
// REGULAR SHIELD
// ==============

void CreateEffectRegularShieldForPlayer(Player *player)
{
    if (!CheckIsPlayer1(player))
        return;

    if (IsBossStage())
        return;

    CreateEffectRegularShield(player);
}

EffectShield *CreateEffectRegularShield(Player *parent)
{
    /*
    static const u8 matList[] = {
            0, 4, 5, 1, 2, 3
    };

    static const u8 shpList[] = {
            3, 4, 5, 2, 0, 1
    };
    */

    s32 i;
    EffectShield *work = CreateEffect(EffectShield, parent);

    // no 'if (work == HeapNull)' check here...?

    OBS_DATA_WORK *fileWork = GetObjectFileWork(OBJDATAWORK_149);
    for (i = 0; i < 6; i++)
    {
        ObjObjectAction3dModelSimpleLoad(&work->objWork, &work->esWork[i], "/eff_barrier.nsbmd", 0, RegularShield__shpList[i], RegularShield__matList[i], fileWork, gameArchiveCommon);
    }

    work->esWork[3].flags |= 0x40;
    work->esWork[4].flags |= 0x40;
    work->esWork[5].flags |= 0x40;

    ObjAction3dModelSimpleSetScale(work->objWork.obj_3des, FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3));

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->objWork.displayFlag |= parent->objWork.displayFlag & DISPLAY_FLAG_ROTATE_CAMERA_DIR;

    SetTaskState(&work->objWork, EffectRegularShield_State_Active);

    return work;
}

RUSH_INLINE void EffectRegularShield__RotateMtx(MtxFx33 *mtx, MtxFx33 *matTemp, u16 angle)
{
    MTX_RotY33(mtx, SinFX((s32)angle), CosFX((s32)angle));
    MTX_RotZ33(matTemp, SinFX(FLOAT_DEG_TO_IDX(337.5)), CosFX(FLOAT_DEG_TO_IDX(337.5)));
    MTX_Concat33(mtx, matTemp, mtx);
}

NONMATCH_FUNC void EffectRegularShield_State_Active(EffectShield *work)
{
    // https://decomp.me/scratch/4sCXT -> 94.51%
#ifdef NON_MATCHING
    Player *player = (Player *)work->objWork.parentObj;
    if (player != NULL)
    {
        work->objWork.position = player->objWork.position;

        work->objWork.displayFlag &= ~DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        work->objWork.displayFlag |= player->objWork.displayFlag & DISPLAY_FLAG_ROTATE_CAMERA_DIR;

        if ((work->objWork.userTimer & 4) != 0)
            work->esWork[4].flags |= 0x80;
        else
            work->esWork[4].flags &= ~0x80;

        MtxFx33 matTemp;
        EffectRegularShield__RotateMtx(&work->objWork.obj_3des->ani.work.rotation, &matTemp, work->field_79C);
        EffectRegularShield__RotateMtx(&work->esWork[3].ani.work.rotation, &matTemp, -work->field_79E);

        if ((player->playerFlag & PLAYER_FLAG_SHIELD_REGULAR) == 0 || (player->playerFlag & PLAYER_FLAG_SHIELD_MAGNET) != 0)
            DestroyStageTask(&work->objWork);

        work->objWork.scale = player->objWork.scale;
    }

    work->field_79C = (work->field_79C + FLOAT_DEG_TO_IDX(8.4375)) & 0x7FFF;
    work->field_79E = (work->field_79E + FLOAT_DEG_TO_IDX(8.4375)) & 0x7FFF;

    work->objWork.userTimer++;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x24
	mov r9, r0
	ldr r6, [r9, #0x11c]
	cmp r6, #0
	beq _02031040
	add r0, r6, #0x44
	add r3, r9, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r9, #0x20]
	mov r4, r9
	bic r1, r0, #0x200
	str r1, [r9, #0x20]
	ldr r0, [r6, #0x20]
	ldr r2, =FX_SinCosTable_
	and r0, r0, #0x200
	orr r0, r1, r0
	str r0, [r9, #0x20]
	ldr r0, [r9, #0x2c]
	tst r0, #4
	ldr r0, [r9, #0x4d4]
	orrne r0, r0, #0x80
	biceq r0, r0, #0x80
	str r0, [r9, #0x4d4]
	add r0, r4, #0x700
	ldrh r0, [r0, #0x9c]
	ldr r5, [r9, #0x130]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r5, #0x24
	bl MTX_RotY33_
	ldr r1, =FX_SinCosTable_+0x00003C00
	add r0, sp, #0
	ldrsh r7, [r1, #2]
	ldrsh r8, [r1, #0]
	mov r2, r7
	mov r1, r8
	bl MTX_RotZ33_
	add r0, r5, #0x24
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat33
	add r0, r4, #0x700
	ldrh r1, [r0, #0x9e]
	ldr r3, =FX_SinCosTable_
	add r0, r4, #0x39c
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	bl MTX_RotY33_
	mov r1, r8
	mov r2, r7
	add r0, sp, #0
	bl MTX_RotZ33_
	add r0, r4, #0x39c
	add r1, sp, #0
	mov r2, r0
	bl MTX_Concat33
	ldr r0, [r6, #0x5d8]
	tst r0, #0x10000000
	beq _02031024
	tst r0, #0x20000000
	beq _02031030
_02031024:
	ldr r0, [r9, #0x18]
	orr r0, r0, #4
	str r0, [r9, #0x18]
_02031030:
	add r0, r6, #0x38
	add r3, r9, #0x38
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_02031040:
	add r1, r4, #0x700
	ldrh r2, [r1, #0x9c]
	ldr r0, =0x00007FFF
	add r2, r2, #0x600
	and r2, r2, r0
	strh r2, [r1, #0x9c]
	ldrh r2, [r1, #0x9e]
	add r2, r2, #0x600
	and r0, r2, r0
	strh r0, [r1, #0x9e]
	ldr r0, [r9, #0x2c]
	add r0, r0, #1
	str r0, [r9, #0x2c]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

// =============
// MAGNET SHIELD
// =============

void CreateEffectMagnetShieldForPlayer(Player *player)
{
    if (!CheckIsPlayer1(player))
        return;

    if (IsBossStage())
        return;

    CreateEffectMagnetShield(player);
}

EffectShield *CreateEffectMagnetShield(Player *parent)
{
    /*
    static const u8 matList[] = {
            4, 5, 6, 7, 2, 1, 3, 0, 8
    };

    static const u8 shpList[] = {
            1, 2, 3, 4, 5, 6, 0, 7, 8
    };
    */

    s32 i;
    EffectShield *work = CreateEffect(EffectShield, parent);

    // no 'if (work == NULL)' check here...?

    OBS_DATA_WORK *fileWork = GetObjectFileWork(OBJDATAWORK_150);
    for (i = 0; i < 9; i++)
    {
        ObjObjectAction3dModelSimpleLoad(&work->objWork, &work->esWork[i], "/eff_magnet.nsbmd", 0, MagnetShield__shpList[i], MagnetShield__matList[i], fileWork, gameArchiveCommon);
    }

    work->esWork[6].flags |= 0x40;
    work->esWork[7].flags |= 0x40;
    work->esWork[8].flags |= 0x40;

    work->alpha = 0;

    ObjAction3dModelSimpleSetScale(work->objWork.obj_3des, FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3), FLOAT_TO_FX32(3.3));

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    work->objWork.displayFlag |= parent->objWork.displayFlag & DISPLAY_FLAG_ROTATE_CAMERA_DIR;

    SetTaskState(&work->objWork, EffectMagnetShield_State_Active);

    return work;
}

NONMATCH_FUNC void EffectMagnetShield_State_Active(EffectShield *work)
{
    // https://decomp.me/scratch/5ApH1 -> 95.53%
#ifdef NON_MATCHING
    Player *player = (Player *)work->objWork.parentObj;
    if (player != NULL)
    {
        MtxFx33 matTemp;

        work->objWork.position = player->objWork.position;

        work->objWork.displayFlag &= ~DISPLAY_FLAG_ROTATE_CAMERA_DIR;
        work->objWork.displayFlag |= player->objWork.displayFlag & DISPLAY_FLAG_ROTATE_CAMERA_DIR;

        if ((work->objWork.userTimer & 4) != 0)
            work->esWork[8].flags |= 0x80;
        else
            work->esWork[8].flags &= ~0x80;

        if ((work->objWork.userTimer & 15) < 7)
            work->alpha += FLOAT_TO_FX32(2.125);
        else if ((work->objWork.userTimer & 15) > 8)
            work->alpha -= FLOAT_TO_FX32(2.125);
        else
            work->alpha = FLOAT_TO_FX32(17.0);

        NNS_G3dMdlSetMdlAlpha((NNSG3dResMdl *)work->objWork.obj_3des->resource, 4, FX32_TO_WHOLE(work->alpha) & 0x1F);

        MTX_RotZ33(&work->objWork.obj_3des->ani.work.rotation, SinFX((s32)work->field_79C), CosFX((s32)work->field_79C));

        MtxFx33 *mtx = &work->esWork[6].ani.work.rotation;
        MTX_RotY33(mtx, SinFX((s32)(u16)-work->field_79E), CosFX((s32)(u16)-work->field_79E));
        MTX_RotZ33(&matTemp, SinFX(FLOAT_DEG_TO_IDX(337.5)), CosFX(FLOAT_DEG_TO_IDX(337.5)));
        MTX_Concat33(mtx, &matTemp, mtx);

        MTX_RotZ33(&work->esWork[5].ani.work.rotation, SinFX((s32)work->field_7A0), CosFX((s32)work->field_7A0));

        if ((player->playerFlag & PLAYER_FLAG_SHIELD_MAGNET) == 0)
            DestroyStageTask(&work->objWork);

        work->objWork.scale = player->objWork.scale;
    }

    if ((work->objWork.userTimer & 7) == 0)
    {
        work->field_79C += FLOAT_DEG_TO_IDX(360.0 / 6.0);
        work->field_7A0 = mtMathRand();
    }

    work->field_79E = (work->field_79E + FLOAT_DEG_TO_IDX(8.4375)) & 0x7FFF;

    work->objWork.userTimer++;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x24
	mov r7, r0
	ldr r5, [r7, #0x11c]
	cmp r5, #0
	beq _02031388
	add r0, r5, #0x44
	add r3, r7, #0x44
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r7, #0x20]
	mov r4, r7
	bic r1, r0, #0x200
	str r1, [r7, #0x20]
	ldr r0, [r5, #0x20]
	and r0, r0, #0x200
	orr r0, r1, r0
	str r0, [r7, #0x20]
	ldr r0, [r7, #0x2c]
	tst r0, #4
	ldr r0, [r7, #0x794]
	orrne r0, r0, #0x80
	biceq r0, r0, #0x80
	str r0, [r7, #0x794]
	ldr r0, [r7, #0x2c]
	and r0, r0, #0xf
	cmp r0, #7
	bge _02031254
	ldr r0, [r4, #0x798]
	add r0, r0, #0x2200
	str r0, [r4, #0x798]
	b _02031270
_02031254:
	cmp r0, #8
	movle r0, #0x11000
	strle r0, [r4, #0x798]
	ble _02031270
	ldr r0, [r4, #0x798]
	sub r0, r0, #0x2200
	str r0, [r4, #0x798]
_02031270:
	ldr r0, [r7, #0x130]
	ldr r1, [r4, #0x798]
	ldr r0, [r0, #0x90]
	mov r1, r1, asr #0xc
	and r2, r1, #0x1f
	mov r1, #4
	bl NNS_G3dMdlSetMdlAlpha
	add r0, r4, #0x700
	ldrh r0, [r0, #0x9c]
	ldr r2, =FX_SinCosTable_
	ldr r3, [r7, #0x130]
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r1, r1, lsl #1
	mov r0, r0, lsl #1
	ldrsh r1, [r2, r1]
	ldrsh r2, [r2, r0]
	add r0, r3, #0x24
	bl MTX_RotZ33_
	add r0, r4, #0x700
	ldrh r1, [r0, #0x9e]
	ldr r3, =FX_SinCosTable_
	add r0, r4, #0x188
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	add r6, r0, #0x400
	add r1, r2, #1
	mov ip, r2, lsl #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, ip]
	ldrsh r2, [r3, r2]
	add r0, r6, #0x24
	bl MTX_RotY33_
	ldr r2, =FX_SinCosTable_+0x00003C00
	add r0, sp, #0
	ldrsh r1, [r2, #0]
	ldrsh r2, [r2, #2]
	bl MTX_RotZ33_
	add r0, r6, #0x24
	mov r2, r0
	add r1, sp, #0
	bl MTX_Concat33
	add r0, r4, #0x700
	ldrh r1, [r0, #0xa0]
	add r0, r4, #0xfc
	ldr r3, =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	mov r6, r1, lsl #1
	add r1, r1, #1
	mov r2, r1, lsl #1
	ldrsh r1, [r3, r6]
	ldrsh r2, [r3, r2]
	add r0, r0, #0x400
	bl MTX_RotZ33_
	ldr r0, [r5, #0x5d8]
	add r3, r7, #0x38
	tst r0, #0x20000000
	ldreq r0, [r7, #0x18]
	orreq r0, r0, #4
	streq r0, [r7, #0x18]
	add r0, r5, #0x38
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_02031388:
	ldr r0, [r7, #0x2c]
	tst r0, #7
	bne _020313C8
	add r2, r4, #0x700
	ldrh r0, [r2, #0x9c]
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	add r0, r0, #0xaa
	add r0, r0, #0x2a00
	strh r0, [r2, #0x9c]
	ldr r5, [r3, #0]
	ldr r0, =0x3C6EF35F
	mla r0, r5, r1, r0
	str r0, [r3]
	mov r0, r0, lsr #0x10
	strh r0, [r2, #0xa0]
_020313C8:
	add r1, r4, #0x700
	ldrh r2, [r1, #0x9e]
	ldr r0, =0x00007FFF
	add r2, r2, #0x600
	and r0, r2, r0
	strh r0, [r1, #0x9e]
	ldr r0, [r7, #0x2c]
	add r0, r0, #1
	str r0, [r7, #0x2c]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, pc}
// clang-format on
#endif
}

// ===========
// GRIND SPARK
// ===========

EffectGrind *CreateEffectGrindSparkForPlayer(Player *player)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    if ((player->gimmickFlag & PLAYER_GIMMICK_10000) != 0)
        return CreateEffectWaterGrindSpark(player, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(18.0));

    return CreateEffectGrindSpark(player, FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(18.0));
}

EffectGrind *CreateEffectGrindSpark(Player *parent, fx32 velX, fx32 velY)
{
    EffectGrind *work = CreateEffect(EffectGrind, parent);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_graind.bac", &EffectTask__sVars.effectGrindFile, gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, 0, 30);
    StageTask__SetAnimation(&work->objWork, 0);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    work->objWork.dir.z      = parent->objWork.fallDir;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;
    StageTask__ObjectSpdDirFall(&velX, &velY, parent->objWork.fallDir + parent->objWork.dir.z);

    work->objWork.position.x += velX;
    work->objWork.position.y += velY;
    SetTaskState(&work->objWork, EffectGrindSpark_State_FollowParent);

    return work;
}

void EffectGrindSpark_State_FollowParent(EffectGrind *work)
{
    if (work->objWork.parentObj != NULL)
    {
        fx32 velX = work->objWork.velocity.x;
        fx32 velY = work->objWork.velocity.y;
        StageTask__ObjectSpdDirFall(&velX, &velY, work->objWork.parentObj->fallDir + work->objWork.parentObj->dir.z);

        work->objWork.position.x = work->objWork.parentObj->position.x;
        work->objWork.position.y = work->objWork.parentObj->position.y;
        work->objWork.position.x = work->objWork.parentObj->position.x + velX;
        work->objWork.position.y = work->objWork.parentObj->position.y + velY;

        if (StageTaskStateMatches(work->objWork.parentObj, Player__State_Grinding) == FALSE)
            DestroyStageTask(&work->objWork);
    }
}

// =================
// WATER GRIND SPARK
// =================

EffectGrind *CreateEffectWaterGrindSpark(Player *parent, fx32 velX, fx32 velY)
{
    EffectGrind *work = CreateEffect(EffectGrind, parent);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/act/ac_eff_water.bac", &EffectTask__sVars.effectWaterGrindFile, gameArchiveStage, 16);
    ObjActionAllocSpritePalette(&work->objWork, 2, 33);
    StageTask__SetAnimation(&work->objWork, 2);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    if ((parent->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;

    work->objWork.dir.z      = parent->objWork.dir.z + parent->objWork.fallDir;
    work->objWork.velocity.x = velX;
    work->objWork.velocity.y = velY;
    StageTask__ObjectSpdDirFall(&velX, &velY, work->objWork.dir.z);

    work->objWork.position.x += velX;
    work->objWork.position.y += velY;
    SetTaskState(&work->objWork, EffectGrindSpark_State_FollowParent);

    return work;
}

// ==============
// TRICK SPARKLES
// ==============

EffectTrickSparkle *CreateEffectTrickSparkleForPlayer(Player *player)
{
    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0)
        return NULL;

    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectTrickSparkle(player, mtMathRandRange(-16, 16), mtMathRandRange(-16, 16));
}

EffectTrickSparkle *CreateEffectTrickSparkle(Player *parent, fx32 offsetX, fx32 offsetY)
{
    EffectTrickSparkle *work = CreateEffect(EffectTrickSparkle, NULL);
    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_trick.bac", &EffectTask__sVars.effectTrickSparkleFile, gameArchiveCommon, 8);
    ObjActionAllocSpritePalette(&work->objWork, 12, 30);
    StageTask__SetAnimation(&work->objWork, 12);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    if ((parent->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        offsetX = -offsetX;
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
    }

    work->objWork.position.x = parent->objWork.position.x + offsetX;
    work->objWork.position.y = parent->objWork.position.y + offsetY;

    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);
    return work;
}

// ==============
// INVINCIBLE
// ==============

void CreateEffectInvincible(Player *parent)
{
    Task *task = CreateStageTaskFast(TASK_FLAG_NONE, 0, TASK_PRIORITY_UPDATE_LIST_START + 0x1A00, TASK_GROUP(4), EffectInvincible);
    if (task == HeapNull)
        return;

    EffectInvincible *work = TaskGetWork(task, EffectInvincible);
    TaskInitWork16(work);

    work->objWork.parentObj = &parent->objWork;

    work->objWork.position.x = parent->objWork.position.x;
    work->objWork.position.y = parent->objWork.position.y;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.flag |= STAGE_TASK_FLAG_DISABLE_VIEWCHECK_EVENT | STAGE_TASK_FLAG_NO_OBJ_COLLISION;
    SetTaskState(&work->objWork, EffectInvincible_State_Active);
}

void EffectInvincible_State_Active(EffectInvincible *work)
{
    Player *parent = (Player *)work->objWork.parentObj;

    if (parent)
    {
        if ((work->objWork.userTimer & 7) == 0)
        {
            u16 angle = work->objWork.userTimer * FLOAT_DEG_TO_IDX(11.25);

            fx32 cos = 6 * CosFX((u16)(angle << 0));
            fx32 sin = 6 * SinFX((u16)(angle << 0));

            CreateEffectInvincibleSparkle(parent->objWork.position.x + cos, parent->objWork.position.y + sin, angle);
            CreateEffectInvincibleSparkle(parent->objWork.position.x - cos, parent->objWork.position.y - sin, angle + FLOAT_DEG_TO_IDX(180.0));
        }

        work->objWork.userTimer++;

        if (parent->invincibleTimer == 0)
            DestroyStageTask(&work->objWork);
    }
}

// ===================
// INVINCIBLE SPARKLES
// ===================

void CreateEffectInvincibleSparkle(fx32 x, fx32 y, u16 timer)
{
    EffectInvincibleSparkle *work = (EffectInvincibleSparkle *)CreateEffectTask(sizeof(EffectInvincibleSparkle), NULL);

    if (work == NULL)
        return;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_trick.bac", &EffectTask__sVars.effectTrickSparkleFile, gameArchiveCommon, 0);
    ObjObjectActionAllocSprite(&work->objWork, 12, GetObjectFileWork(OBJDATAWORK_120));

    work->animator.ani.cParam[0].palette = 1;
    work->animator.ani.cParam[1].palette = 1;
    work->animator.ani.work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    StageTask__SetAnimation(&work->objWork, 5);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    work->objWork.position.x = x;
    work->objWork.position.y = y;
    work->objWork.userTimer  = timer;
    SetTaskState(&work->objWork, EffectInvincibleSparkle_State_SparkleOrbit);
}

void EffectInvincibleSparkle_State_SparkleOrbit(EffectInvincibleSparkle *work)
{
    u32 angle                = (u16)((u16)work->objWork.userTimer + FLOAT_DEG_TO_IDX(90.0));
    work->objWork.velocity.x = 2 * CosFX((u16)angle);
    work->objWork.velocity.y = 2 * SinFX((u16)angle);

    work->objWork.userTimer += FLOAT_TO_FX32(0.25);
    if ((work->objWork.displayFlag & DISPLAY_FLAG_DID_FINISH) != 0)
        DestroyStageTask(&work->objWork);
}

// ==========
// SNOW SMOKE
// ==========

EffectSnowSmoke *CreateSmallEffectSnowSmokeForPlayer(Player *player)
{
    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0)
        return NULL;

    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectSnowSmoke(player, 0, FLOAT_TO_FX32(16.0f), 0);
}

EffectSnowSmoke *CreateLargeEffectSnowSmokeForPlayer(Player *player)
{
    if ((playerGameStatus.flags & PLAYERGAMESTATUS_FLAG_FREEZE_TIME) == 0)
        return NULL;

    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectSnowSmoke(player, 0, FLOAT_TO_FX32(16.0f), 1);
}

EffectSnowSmoke *CreateEffectSnowSmoke(Player *parent, fx32 offsetX, fx32 offsetY, s32 animID)
{
    static const u16 gfxSizeForAnim[] = { 4, 0x10, 0xC000, 0xFFFE };

    EffectSnowSmoke *work = CreateEffect(EffectSnowSmoke, NULL);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_yukikemuri.bac", &EffectTask__sVars.effectSnowSmokeFile, gameArchiveCommon, gfxSizeForAnim[animID]);
    ObjActionAllocSpritePalette(&work->objWork, 0, 55);
    StageTask__SetAnimation(&work->objWork, animID);
    work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    work->objWork.dir.z = parent->objWork.fallDir + parent->objWork.dir.z;
    if ((parent->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) != 0)
    {
        work->objWork.displayFlag |= DISPLAY_FLAG_FLIP_X;
        offsetX = -offsetX;
    }

    StageTask__ObjectSpdDirFall(&offsetX, &offsetY, parent->objWork.fallDir + parent->objWork.dir.z);

    work->objWork.position.x = parent->objWork.position.x + offsetX;
    work->objWork.position.y = parent->objWork.position.y + offsetY;
    work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_ROTATION;
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    SetTaskState(&work->objWork, EffectTask_State_DestroyAfterAnimation);

    return work;
}

// ===========
// DROWN ALERT
// ===========

EffectDrownAlert *CreateEffectDrownAlertForPlayer(Player *player, s32 animID)
{
    if (!CheckIsPlayer1(player))
        return NULL;

    if (IsBossStage())
        return NULL;

    return CreateEffectDrownAlert(player, 0, -FLOAT_TO_FX32(24.0f), animID);
}

EffectDrownAlert *CreateEffectDrownAlert(Player *parent, fx32 offsetX, fx32 offsetY, s32 animID)
{
    EffectDrownAlert *work = CreateEffect(EffectDrownAlert, parent);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/act/ac_fix_awa_count.bac", &EffectTask__sVars.effectDrownAlertFile, gameArchiveStage, OBJ_DATA_GFX_AUTO);

    work->objWork.obj_2d->ani.cParam[1].palette = 2;
    work->objWork.obj_2d->ani.cParam[0].palette = work->objWork.obj_2d->ani.cParam[1].palette;
    work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    StageTask__SetAnimation(&work->objWork, animID);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_12);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);

    if (gmCheckVsBattleFlag())
        work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_B;

    if ((parent->objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
        offsetX = -offsetX;

    work->objWork.velocity.x = offsetX;
    work->objWork.velocity.y = offsetY;
    work->objWork.position.x += offsetX;
    work->objWork.position.y += offsetY;

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    SetTaskState(&work->objWork, EffectDrownAlert_State_Rising);

    return work;
}

void EffectDrownAlert_State_Rising(EffectDrownAlert *work)
{
    if (work->objWork.parentObj)
    {
        work->objWork.position.x = work->objWork.parentObj->position.x + work->objWork.velocity.x;
        work->objWork.position.y = work->objWork.parentObj->position.y + work->objWork.velocity.y;
    }

    work->objWork.userTimer++;
    if (work->objWork.userTimer > 16)
    {
        work->objWork.velocity.y -= FLOAT_TO_FX32(0.75);

        // flicker every 4 frames
        if ((work->objWork.userTimer & 2) != 0)
            work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;
        else
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
    }

    if (work->objWork.userTimer > 48)
        DestroyStageTask(&work->objWork);
}

// ===========
// PLAYER ICON
// ===========

EffectPlayerIcon *CreateEffectPlayerIcon(Player *parent)
{
    EffectPlayerIcon *work = CreateEffect(EffectPlayerIcon, parent);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_fix_cont.bac", GetObjectFileWork(OBJDATAWORK_1), gameArchiveCommon, 0);

    work->objWork.obj_2d->ani.vramPixels[1] = VRAMSystem__AllocSpriteVram(TRUE, 8);
    work->objWork.obj_2d->ani.flags |= ANIMATORSPRITEDS_FLAG_DISABLE_A;
    work->animator.ani.work.cParam.palette      = PALETTE_ROW_0;
    work->animator.ani.cParam[0].palette = work->animator.ani.cParam[1].palette = 0;
    work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    StageTask__SetAnimation(&work->objWork, parent->characterID);
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_13);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_2);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    SetTaskState(&work->objWork, EffectPlayerIcon_State_TrackParent);

    return work;
}

void EffectPlayerIcon_State_TrackParent(EffectPlayerIcon *work)
{
    work->objWork.position.x = work->objWork.parentObj->position.x;
    work->objWork.position.y = work->objWork.parentObj->position.y;
}

// =============
// BATTLE ATTACK
// =============

EffectBattleAttack *CreateEffectBattleAttack(Player *parent, EffectBattleAttackTypes type)
{
    static const u8 flagsForType[] = { 2, 2, 2, 0x1F };

    if (type == EFFECTBATTLEATTACK_SLOWMO)
    {
        if (parent->slomoTimer)
        {
            return NULL;
        }
    }
    else if (type == EFFECTBATTLEATTACK_CONFUSION)
    {
        if (parent->confusionTimer)
        {
            return NULL;
        }
    }

    EffectBattleAttack *work = CreateEffect(EffectBattleAttack, parent);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->animator, "/ac_eff_battle.bac", &EffectTask__sVars.effectBattleAttackFile, gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    ObjActionAllocSpritePalette(&work->objWork, type, flagsForType[type]);
    StageTask__SetAnimation(&work->objWork, type);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_13);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_1);

    switch (type)
    {
        case EFFECTBATTLEATTACK_SLOWMO:
        default:
            work->objWork.position.y -= FLOAT_TO_FX32(32.0);
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            SetTaskState(&work->objWork, EffectBattleAttack_State_SlowMo);
            break;

        case EFFECTBATTLEATTACK_CONFUSION:
            work->objWork.position.y -= FLOAT_TO_FX32(32.0);
            work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
            SetTaskState(&work->objWork, EffectBattleAttack_State_Confusion);
            break;

        case EFFECTBATTLEATTACK_TENSION_GAIN:
            work->objWork.position.y -= FLOAT_TO_FX32(16.0);
            work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
            SetTaskState(&work->objWork, EffectBattleAttack_State_TensionGain);
            break;

        case EFFECTBATTLEATTACK_TENSION_DRAIN:
            work->objWork.position.y -= FLOAT_TO_FX32(32.0);
            work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_ENABLE_SCALE;
            SetTaskState(&work->objWork, EffectBattleAttack_State_TensionDrain);
            break;
    }

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;

    return work;
}

void EffectBattleAttack_State_SlowMo(EffectBattleAttack *work)
{
    Player *parent = (Player *)work->objWork.parentObj;

    if (parent)
    {
        work->objWork.position.x = parent->objWork.position.x;
        work->objWork.position.y = parent->objWork.position.y - FLOAT_TO_FX32(32.0);

        if (parent->slomoTimer < 128)
        {
            if ((parent->slomoTimer & 2) != 0)
                work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
            else
                work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

            if (parent->slomoTimer == 0)
                DestroyStageTask(&work->objWork);
        }
    }
}

void EffectBattleAttack_State_Confusion(EffectBattleAttack *work)
{
    Player *parent = (Player *)work->objWork.parentObj;

    if (parent)
    {
        work->objWork.position.x = parent->objWork.position.x;
        work->objWork.position.y = parent->objWork.position.y - FLOAT_TO_FX32(32.0);

        if (parent->confusionTimer < 128)
        {
            if ((parent->confusionTimer & 2) != 0)
                work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_DRAW;
            else
                work->objWork.displayFlag &= ~DISPLAY_FLAG_DISABLE_DRAW;

            if (parent->confusionTimer == 0)
                DestroyStageTask(&work->objWork);
        }
    }
}

void EffectBattleAttack_State_TensionGain(EffectBattleAttack *work)
{
    Player *parent = (Player *)work->objWork.parentObj;

    if (parent)
    {
        if (work->objWork.scale.x == FLOAT_TO_FX32(0.03125) && work->objWork.scale.y == FLOAT_TO_FX32(1.5))
        {
            work->objWork.scale.y   = FLOAT_TO_FX32(1.0);
            work->objWork.scale.x   = FLOAT_TO_FX32(1.0);
            work->objWork.userTimer = 0;
            work->objWork.userWork++;
        }

        work->objWork.position.x = parent->objWork.position.x;
        work->objWork.position.y = parent->objWork.position.y - FLOAT_TO_FX32(16.0) - FLOAT_TO_FX32(1.25) * work->objWork.userTimer;
        work->objWork.userTimer++;

        work->objWork.scale.x = ObjDiffSet(work->objWork.scale.x, FLOAT_TO_FX32(0.03125), FLOAT_TO_FX32(1.0), 2, 0, 0);
        work->objWork.scale.y = ObjDiffSet(work->objWork.scale.y, FLOAT_TO_FX32(1.5), FLOAT_TO_FX32(1.0), 2, 0, 0);

        if (work->objWork.userWork > 1)
            DestroyStageTask(&work->objWork);
    }
}

void EffectBattleAttack_State_TensionDrain(EffectBattleAttack *work)
{
    Player *parent = (Player *)work->objWork.parentObj;

    if (parent)
    {
        if (work->objWork.scale.x == FLOAT_TO_FX32(2.0) && work->objWork.scale.y == FLOAT_TO_FX32(0.03125))
        {
            work->objWork.scale.y   = FLOAT_TO_FX32(1.0);
            work->objWork.scale.x   = FLOAT_TO_FX32(1.0);
            work->objWork.userTimer = 0;
            work->objWork.userWork++;
        }

        work->objWork.position.x = parent->objWork.position.x;
        work->objWork.position.y = parent->objWork.position.y - FLOAT_TO_FX32(32.0) + FLOAT_TO_FX32(0.5) * work->objWork.userTimer;
        work->objWork.userTimer++;

        work->objWork.scale.x = ObjShiftSet(work->objWork.scale.x, FLOAT_TO_FX32(2.0), 4, 0, 0x80);
        work->objWork.scale.y = ObjShiftSet(work->objWork.scale.y, FLOAT_TO_FX32(0.03125), 4, 0, 0x80);

        if (work->objWork.userWork > 1)
            DestroyStageTask(&work->objWork);
    }
}