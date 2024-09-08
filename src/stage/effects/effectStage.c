// Effect System Headers
#include <stage/effectTask.h>
#include <stage/gameObject.h>
#include <stage/core/ringManager.h>

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
#include <stage/effects/flipMushPuff.h>
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
#include <stage/objects/jumpbox.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void *_02118FBC;
NOT_DECOMPILED void *_0210EA44;
NOT_DECOMPILED void *_0202B670;
NOT_DECOMPILED void *_0202C470;
NOT_DECOMPILED void *EffectButtonPrompt__states;
NOT_DECOMPILED void *_02118FB4;
NOT_DECOMPILED void *EffectButtonPrompt_animIDs;
NOT_DECOMPILED void *_02119324;
NOT_DECOMPILED void *_0211930C;

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

NOT_DECOMPILED void *_0210EA5C;

// --------------------
// VARIABLES
// --------------------

extern RingManager *ringManagerWork;

// --------------------
// FUNCTION DECLS
// --------------------

// Common
static void HandleEffectZScale(fx32 z, fx32 *a2, fx32 *scale);

// --------------------
// FUNCTIONS
// --------------------

// EffectAvalanche
NONMATCH_FUNC EffectSnowSlide *EffectAvalanche__Create(fx32 x, fx32 y, fx32 velX, fx32 velY){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r4, =playerGameStatus
	mov r8, r0
	ldr r0, [r4]
	mov r7, r1
	tst r0, #1
	mov r6, r2
	mov r5, r3
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0x218
	mov r1, #0
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0xc1
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcGmkSnowsl
	mov r0, r4
	str r1, [sp]
	mov ip, #0
	add r1, r4, #0x168
	str ip, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, #0xc2
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #0xa0
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x23
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	mov r0, #0xc2
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	bgt _0202BC6C
	ldr r3, [r4, #0x128]
	mov r1, #0
	ldr r0, [r3, #0x3c]
	mov r2, r1
	orr r0, r0, #0x20
	str r0, [r3, #0x3c]
	ldr r0, [r4, #0x128]
	bl AnimatorSpriteDS__ProcessAnimation
_0202BC6C:
	ldr r3, [r4, #0x128]
	mov r0, r4
	ldr r2, [r3, #0x3c]
	mov r1, #0xc
	orr r2, r2, #8
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r8, [r4, #0x44]
	str r7, [r4, #0x48]
	str r6, [r4, #0x98]
	mov r2, #0
	str r5, [r4, #0x9c]
	str r2, [sp]
	mov r0, r4
	mov r3, r2
	mov r1, #0x20
	str r2, [sp, #4]
	bl InitEffectTaskViewCheck
	mov r0, #0x20
	ldr r1, =EffectTask_State_DestroyAfterAnimation
	str r0, [r4, #0x2c]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

NONMATCH_FUNC EffectSnowSlide *EffectAvalancheDebris__Create(s32 type, fx32 x, fx32 y, fx32 velX, fx32 velY){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #8
	ldr r4, =playerGameStatus
	mov r9, r0
	ldr r0, [r4]
	mov r8, r1
	tst r0, #1
	mov r7, r2
	mov r6, r3
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	cmp r9, #2
	movhi r9, #2
	mov r0, #0x218
	mov r1, #0
	and r9, r9, #0xff
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, #0xc1
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcGmkSnowsl
	str r1, [sp]
	mov r5, #0
	mov r0, r4
	add r1, r4, #0x168
	str r5, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, r5
	mov r2, #0x23
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x20c]
	add r5, r9, #1
	mov r1, r5, lsl #0x10
	ldr r0, [r0]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize2FromAnim
	mov r1, r9, lsl #1
	mov r9, r0
	add r0, r1, #0xc4
	bl GetObjectFileWork
	mov r2, r0
	mov r1, r9
	mov r0, r4
	bl ObjObjectActionAllocSprite
	mov r0, r5, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r4
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [r4, #0x20]
	ldr r2, =_mt_math_rand
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	str r1, [r2]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [r4, #0x20]
	mov r2, #0
	orrne r0, r0, #2
	strne r0, [r4, #0x20]
	str r8, [r4, #0x44]
	str r7, [r4, #0x48]
	ldr r0, [sp, #0x28]
	str r6, [r4, #0x98]
	str r0, [r4, #0x9c]
	str r2, [sp]
	mov r0, r4
	mov r3, r2
	str r2, [sp, #4]
	mov r1, #0x10
	bl InitEffectTaskViewCheck
	ldr r1, [r4, #0x1c]
	mov r0, #0x20
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	str r0, [r4, #0x2c]
	ldr r1, =EffectTask_State_MoveTowardsZeroX
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
// clang-format on
#endif
}

// EffectTruckJewel
NONMATCH_FUNC EffectTruckJewel *EffectTruckJewel__Create(StageTask *parent, fx32 velX, fx32 velY, fx32 velZ, u8 type, u8 flag){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r8, r0
	mov r7, r1
	mov r1, r8
	mov r0, #0x32c
	mov r6, r2
	mov r5, r3
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	ldrb r0, [sp, #0x28]
	cmp r0, #5
	movhs r0, #4
	strhsb r0, [sp, #0x28]
	mov r0, #0xb5
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r0, [r1]
	ldr ip, =0x0000FFFF
	str r0, [sp]
	ldr r2, =aActAcGmkTruckJ
	mov r0, r4
	add r1, r4, #0x168
	str ip, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x3a
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x18
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, #0xb6
	bl GetObjectFileWork
	ldr r3, =0x0000FFFF
	ldr r1, =gameArchiveStage
	str r3, [sp]
	str r0, [sp, #4]
	ldr r1, [r1]
	ldr r2, =aActAcGmkTruckJ_0
	str r1, [sp, #8]
	mov r0, r4
	add r1, r4, #0x218
	bl ObjObjectAction3dBACLoad
	mov r0, #0x1d
	strb r0, [r4, #0x222]
	mov r0, #7
	strb r0, [r4, #0x223]
	ldrb r1, [sp, #0x28]
	mov r0, r4
	bl StageTask__SetAnimation
	ldrb r0, [sp, #0x2c]
	str r7, [r4, #0x98]
	str r6, [r4, #0x9c]
	str r5, [r4, #0xa0]
	cmp r0, #0
	beq _0202BFF4
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x12
	str r1, [r2]
	add r0, r0, #0x2000
	str r0, [r4, #0x2c]
_0202BFF4:
	ldr r0, [r4, #0x1c]
	ldr r2, =EffectTruckJewel__Draw
	orr r0, r0, #0x2000
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	ldr r1, =EffectTruckJewel__State_202C06C
	orr r0, r0, #0x10000
	bic r3, r0, #0x100
	str r3, [r4, #0x20]
	ldr r0, [r8, #0x20]
	and r0, r0, #1
	orr r0, r3, r0
	str r0, [r4, #0x20]
	ldr r3, [r4, #0x18]
	mov r0, r4
	orr r3, r3, #0x200
	str r3, [r4, #0x18]
	str r2, [r4, #0xfc]
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectTruckJewel__State_202C06C(EffectTruckJewel *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r2, [r4, #0x11c]
	cmp r2, #0
	beq _0202C1D0
	ldr r1, [r2, #0x44]
	ldr r0, [r2, #0x50]
	add r2, sp, #8
	add r0, r1, r0
	str r0, [r4, #0x44]
	ldr r0, [r4, #0x11c]
	add r3, sp, #0x10
	ldr r1, [r0, #0x48]
	ldr r0, [r0, #0x54]
	add r0, r1, r0
	str r0, [r4, #0x48]
	ldr r0, [r4, #0x11c]
	ldr r0, [r0, #0x4c]
	str r0, [r4, #0x4c]
	ldr r0, [r4, #0x11c]
	ldrh r0, [r0, #0x32]
	rsb r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [r4, #0xa0]
	ldr r1, [r4, #0x98]
	bl AkMath__Func_2002C98
	ldr r0, [r4, #0x11c]
	add r2, sp, #0x10
	ldrh r0, [r0, #0x34]
	add r3, sp, #0xc
	str r0, [sp]
	ldr r0, [sp, #0x10]
	ldr r1, [r4, #0x9c]
	bl AkMath__Func_2002C98
	ldr r1, [r4, #0x44]
	ldr r0, [sp, #0x10]
	add r0, r1, r0
	str r0, [r4, #0x44]
	ldr r1, [r4, #0x48]
	ldr r0, [sp, #0xc]
	add r0, r1, r0
	str r0, [r4, #0x48]
	ldr r1, [r4, #0x4c]
	ldr r0, [sp, #8]
	add r0, r1, r0
	str r0, [r4, #0x4c]
	ldr r2, [r4, #0x11c]
	ldrh r1, [r2, #0x30]
	ldrh r0, [r2, #0x32]
	strh r1, [r4, #0x30]
	strh r0, [r4, #0x32]
	ldrh r0, [r2, #0x34]
	strh r0, [r4, #0x34]
	ldr r2, [r4, #0x2c]
	cmp r2, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r1, [r4, #0x11c]
	ldr r0, [r1, #0x98]
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r3, r4, r5, r6, pc}
	ldr r0, [r1, #0x9c]
	cmp r0, r2
	addlt sp, sp, #0x14
	ldmltia sp!, {r3, r4, r5, r6, pc}
	mov r2, #0
	str r2, [sp]
	mov r0, r4
	mov r3, r2
	mov r1, #0x10
	str r2, [sp, #4]
	bl InitEffectTaskViewCheck
	mov r1, #0
	str r1, [r4, #0x98]
	ldr r0, [r4, #0x11c]
	add sp, sp, #0x14
	ldr r0, [r0, #0x9c]
	str r0, [r4, #0x9c]
	str r1, [r4, #0xa0]
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x2000
	str r0, [r4, #0x1c]
	str r1, [r4, #0xf4]
	str r1, [r4, #0x11c]
	ldmia sp!, {r3, r4, r5, r6, pc}
_0202C1D0:
	ldr r6, =_mt_math_rand
	mov r5, #0x4000
	ldr r3, [r6]
	ldr ip, =0x00196225
	ldr lr, =0x3C6EF35F
	rsb r5, r5, #0
	mla r1, r3, ip, lr
	mov r3, r1, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	and r3, r3, #0x3f0
	mov r3, r3, lsl #4
	str r1, [r6]
	add r1, r3, #0x6000
	str r1, [r4, #0x98]
	ldr r1, [r6]
	mov r2, #0
	mla r3, r1, ip, lr
	mov r1, r3, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0x3f0
	str r3, [r6]
	sub r1, r5, r1, lsl #4
	str r1, [r4, #0x9c]
	str r2, [r4, #0xa0]
	strh r2, [r4, #0x34]
	strh r2, [r4, #0x32]
	strh r2, [r4, #0x30]
	str r2, [sp]
	mov r3, r2
	str r2, [sp, #4]
	mov r1, #0x40
	bl InitEffectTaskViewCheck
	ldr r1, [r4, #0x1c]
	mov r0, #0
	bic r1, r1, #0x2000
	orr r1, r1, #0x80
	str r1, [r4, #0x1c]
	str r0, [r4, #0xf4]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, r5, r6, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectTruckJewel__Draw(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #0x10
	bl GetCurrentTaskWork_
	mov r3, r0
	ldr r1, [r3, #0x11c]
	cmp r1, #0
	beq _0202C314
	ldr r0, [r1, #0x4c]
	cmp r0, #0
	ldreqh r0, [r1, #0x32]
	cmpeq r0, #0
	add r0, r3, #0x20
	bne _0202C2E4
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [r3, #0x128]
	add r1, r3, #0x44
	add r2, r3, #0x30
	add r3, r3, #0x38
	bl StageTask__Draw2DEx
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}
_0202C2E4:
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, [r3, #0x134]
	add r1, r3, #0x44
	add r2, r3, #0x30
	add r3, r3, #0x38
	bl StageTask__Draw3DEx
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}
_0202C314:
	add r0, r3, #0x20
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [r3, #0x128]
	add r1, r3, #0x44
	add r2, r3, #0x30
	add r3, r3, #0x38
	bl StageTask__Draw2DEx
	add sp, sp, #0x10
	ldmia sp!, {r3, pc}
// clang-format on
#endif
}

// EffectPirateShip
NONMATCH_FUNC EffectPirateShipCannonBlast *PirateShipCannonBlast__Create(StageTask *parent, fx32 velX, fx32 velY){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r1
	mov r1, r0
	mov r0, #0x218
	mov r5, r2
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, #0xa2
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, =aActAcGmkPirate
	mov r0, r4
	str r1, [sp]
	mov ip, #8
	add r1, r4, #0x168
	str ip, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x53
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #3
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimation
	str r6, [r4, #0x98]
	str r5, [r4, #0x9c]
	ldr r0, [r4, #0x1c]
	ldr r1, =EffectTask_State_TrackParent
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r2, [r4, #0x18]
	mov r0, r4
	orr r2, r2, #2
	str r2, [r4, #0x18]
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
// clang-format on
#endif
}

// EffectUnknown202C414
EffectUnknown202C414 *EffectUnknown202C414__Create(StageTask *parent)
{
    EffectUnknown202C414 *work = CreateEffect(EffectUnknown202C414, parent);
    if (work == NULL)
        return NULL;

    SetTaskDestructorEvent(EffectTask__sVars.lastCreatedTask, EffectUnknown202C414__Destructor);

    work->cmdList = HeapAllocHead(HEAP_SYSTEM, 0x300);
    G3_BeginMakeDL(&work->info, work->cmdList, 0x300);

    u8 polygonAlpha[] = { GX_COLOR_FROM_888(0x28), GX_COLOR_FROM_888(0x38), GX_COLOR_FROM_888(0x48), GX_COLOR_FROM_888(0x58), GX_COLOR_FROM_888(0x68),
                          GX_COLOR_FROM_888(0x58), GX_COLOR_FROM_888(0x48), GX_COLOR_FROM_888(0x38), GX_COLOR_FROM_888(0x28), GX_COLOR_FROM_888(0x18) };

    G3C_MtxMode(&work->info, GX_MTXMODE_POSITION);
    G3C_Color(&work->info, GX_RGB_888(0xFF, 0xFF, 0xFF));

    s32 i;
    fx32 z;

    for (i = 0, z = FLOAT_TO_FX32(0.0); i < 10; i++)
    {
        G3C_PolygonAttr(&work->info, 0, GX_POLYGONMODE_MODULATE, GX_CULL_NONE, 0, polygonAlpha[i], GX_POLYGON_ATTR_MISC_NONE);
        G3C_Begin(&work->info, GX_BEGIN_QUAD_STRIP);
        G3C_Vtx(&work->info, 0, 32, z >> 6);
        G3C_Vtx(&work->info, 0, -32, z >> 6);
        z += FLOAT_TO_FX32(3.2);
        G3C_Vtx(&work->info, 0, 32, z >> 6);
        G3C_Vtx(&work->info, 0, -32, z >> 6);
        G3C_End(&work->info);
    }
    G3_EndMakeDL(&work->info);
    DC_FlushRange(work->cmdList, 0x300);

    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT | STAGE_TASK_MOVE_FLAG_DISABLE_COLLIDE_EVENT;
    work->objWork.flag |= STAGE_TASK_FLAG_2;

    SetTaskState(&work->objWork, EffectUnknown202C414__State_202C5F8);
    SetTaskOutFunc(&work->objWork, EffectUnknown202C414__Draw);

    work->objWork.position.z = FLOAT_TO_FX32(0.0);
    return work;
}

void EffectUnknown202C414__Destructor(Task *task)
{
    EffectUnknown202C414 *work = TaskGetWork(task, EffectUnknown202C414);

    HeapFree(HEAP_SYSTEM, work->cmdList);
    StageTask_Destructor(task);
}

NONMATCH_FUNC void EffectUnknown202C414__State_202C5F8(EffectUnknown202C414 *work)
{
    // https://decomp.me/scratch/HLeU8 -> 99.03%
    // minor register issues
#ifdef NON_MATCHING
    s32 id;
    BOOL isActive = FALSE;

    if (work->objWork.parentObj != NULL && (work->objWork.parentObj->flag & STAGE_TASK_FLAG_DESTROYED) == 0 && work->objWork.parentObj->userFlag)
        work->objWork.userFlag = TRUE;

    work->objWork.position.x = work->objWork.parentObj->position.x;
    work->objWork.position.y = work->objWork.parentObj->position.y;

    work->objWork.userTimer--;
    if (work->objWork.userTimer <= 0 && !work->objWork.userFlag)
    {
        id = 0;
        for (; id < EFFECTUNKNOWN202C414_LIST_SIZE; id++)
        {
            EffectUnknown202C414Entry *entry = &work->list[id];

            if (entry->active)
                continue;

            entry->active = TRUE;

            entry->position.x = ((mtMathRand() & 0x1F) * 0x20) + 0x200;
            entry->position.y = FLOAT_TO_FX32(0.0);
            entry->position.z = FLOAT_TO_FX32(0.0);

            entry->angle1 = (mtMathRand() & 0x3FF) + 0x1000;
            entry->angle2 = mtMathRand();
            entry->scale  = FLOAT_TO_FX32(0.0);
            break;
        }

        if (id < EFFECTUNKNOWN202C414_LIST_SIZE)
        {
            work->objWork.userTimer = mtMathRand() & 7;
        }
    }

    for (s32 i = 0; i < EFFECTUNKNOWN202C414_LIST_SIZE; i++)
    {
        EffectUnknown202C414Entry *entry = &work->list[i];

        if (!entry->active)
            continue;

        isActive = TRUE;

        if (entry->scale < FLOAT_TO_FX32(1.0))
        {
            entry->scale += FLOAT_TO_FX32(0.25);

            if (entry->scale > FLOAT_TO_FX32(1.0))
                entry->scale = FLOAT_TO_FX32(1.0);
        }
        else
        {
            entry->position.z += FLOAT_TO_FX32(0.125);

            if (entry->position.z >= FLOAT_TO_FX32(1.0))
                entry->active = FALSE;
        }
    }

    if (work->objWork.userFlag)
    {
        if (!isActive)
            DestroyStageTask(&work->objWork);
    }
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r2, [r0, #0x11c]
	mov r4, #0
	cmp r2, #0
	beq _0202C628
	ldr r1, [r2, #0x18]
	tst r1, #4
	bne _0202C628
	ldr r1, [r2, #0x24]
	cmp r1, #0
	movne r1, #1
	strne r1, [r0, #0x24]
_0202C628:
	ldr r1, [r0, #0x11c]
	ldr r1, [r1, #0x44]
	str r1, [r0, #0x44]
	ldr r1, [r0, #0x11c]
	ldr r1, [r1, #0x48]
	str r1, [r0, #0x48]
	ldr r1, [r0, #0x2c]
	sub r1, r1, #1
	str r1, [r0, #0x2c]
	cmp r1, #0
	bgt _0202C740
	ldr r1, [r0, #0x24]
	cmp r1, #0
	bne _0202C740
	add lr, r0, #0x180
	mov ip, #0
_0202C668:
	ldrh r1, [lr]
	cmp r1, #0
	bne _0202C6FC
	mov r3, #1
	ldr r8, =_mt_math_rand
	strh r3, [lr]
	ldr r5, [r8]
	ldr r6, =0x00196225
	ldr r7, =0x3C6EF35F
	mov r1, #0
	mla r2, r5, r6, r7
	mov r5, r2, lsr #0x10
	mov r5, r5, lsl #0x10
	mov r5, r5, lsr #0x10
	mov r5, r5, lsl #0x1b
	mov r5, r5, lsr #0x16
	str r2, [r8]
	add r2, r5, #0x200
	str r2, [lr, #8]
	str r1, [lr, #0xc]
	str r1, [lr, #0x10]
	ldr r2, [r8]
	rsb r3, r3, #0x400
	mla r5, r2, r6, r7
	mov r2, r5, lsr #0x10
	mov r2, r2, lsl #0x10
	and r2, r3, r2, lsr #16
	str r5, [r8]
	add r2, r2, #0x1000
	strh r2, [lr, #4]
	ldr r2, [r8]
	mla r3, r2, r6, r7
	str r3, [r8]
	mov r2, r3, lsr #0x10
	strh r2, [lr, #6]
	str r1, [lr, #0x14]
	b _0202C70C
_0202C6FC:
	add ip, ip, #1
	cmp ip, #0x20
	add lr, lr, #0x18
	blt _0202C668
_0202C70C:
	cmp ip, #0x20
	bge _0202C740
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r5, [r3]
	ldr r2, =0x3C6EF35F
	mla r2, r5, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r2, [r3]
	and r1, r1, #7
	str r1, [r0, #0x2c]
_0202C740:
	mov r7, #0
	add r6, r0, #0x180
	mov r5, #1
	mov r1, r7
	mov r3, #0x1000
_0202C754:
	ldrh r2, [r6]
	cmp r2, #0
	beq _0202C798
	ldr r2, [r6, #0x14]
	mov r4, r5
	cmp r2, #0x1000
	bge _0202C784
	add r2, r2, #0x400
	str r2, [r6, #0x14]
	cmp r2, #0x1000
	strgt r3, [r6, #0x14]
	b _0202C798
_0202C784:
	ldr r2, [r6, #0x10]
	add r2, r2, #0x200
	str r2, [r6, #0x10]
	cmp r2, #0x1000
	strgeh r1, [r6]
_0202C798:
	add r7, r7, #1
	cmp r7, #0x20
	add r6, r6, #0x18
	blt _0202C754
	ldr r1, [r0, #0x24]
	cmp r1, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r4, #0
	ldreq r1, [r0, #0x18]
	orreq r1, r1, #4
	streq r1, [r0, #0x18]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectUnknown202C414__Draw(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x8c
	bl GetCurrentTaskWork_
	ldr r3, =0x000D3300
	ldr r2, =0x02112D50
	mov r8, r0
	ldrsh r1, [r2]
	ldrsh r2, [r2, #2]
	add r0, sp, #0x50
	str r3, [sp, #0x74]
	str r3, [sp, #0x78]
	str r3, [sp, #0x7c]
	blx MTX_RotX33_
	ldr r2, =0x02116550
	add r0, sp, #0x2c
	ldrsh r1, [r2]
	ldrsh r2, [r2, #2]
	blx MTX_RotY33_
	add r0, sp, #0x50
	add r1, sp, #0x2c
	mov r2, r0
	bl MTX_Concat33
	ldr r2, =FX_SinCosTable_
	add r0, sp, #0x2c
	ldrsh r1, [r2]
	ldrsh r2, [r2, #2]
	blx MTX_RotZ33_
	add r0, sp, #0x50
	add r1, sp, #0x2c
	mov r2, r0
	bl MTX_Concat33
	ldr r1, [r8, #0x44]
	add r0, sp, #0x80
	add r1, r1, #0x18000
	str r1, [sp, #0x80]
	ldr r2, [r8, #0x48]
	add r1, sp, #0x20
	sub r2, r2, #0x18000
	str r2, [sp, #0x84]
	ldr r3, [r8, #0x4c]
	mov r2, #0
	str r3, [sp, #0x88]
	mov r3, r2
	bl GameObject__Func_20282A8
	add r0, sp, #0x74
	bl NNS_G3dGlbSetBaseScale
	ldr r1, =0x021472FC
	add r0, sp, #0x50
	bl MI_Copy36B
	ldr r1, =NNS_G3dGlb
	add r0, sp, #0x20
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	bl NNS_G3dGlbSetBaseTrans
	mov r2, #1
	mov r0, #0x10
	add r1, sp, #4
	str r2, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	bl NNS_G3dGlbFlushP
	ldr r6, =FX_SinCosTable_
	add r9, r8, #0x180
	mov r10, #0
	mov r11, #0x11
	add r7, sp, #0x50
	add r5, sp, #0x2c
	mov r4, #0x1000
_0202C8E4:
	ldrh r0, [r9]
	cmp r0, #0
	beq _0202CA18
	mov r1, #0
	mov r0, r11
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	ldrh r1, [r9, #2]
	mov r0, r7
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r6, r2, lsl #1
	ldrsh r1, [r6, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotX33_
	ldrh r1, [r9, #4]
	mov r0, r5
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r6, r2, lsl #1
	ldrsh r1, [r6, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotY33_
	mov r0, r7
	mov r1, r5
	mov r2, r7
	bl MTX_Concat33
	ldrh r1, [r9, #6]
	mov r0, r5
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r6, r2, lsl #1
	ldrsh r1, [r6, r1]
	ldrsh r2, [r2, #2]
	blx MTX_RotZ33_
	mov r0, r7
	mov r1, r5
	mov r2, r7
	bl MTX_Concat33
	mov r0, #0x1a
	mov r1, r7
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	ldr r3, [r9, #0x10]
	ldr r2, [r9, #0xc]
	ldr r1, [r9, #8]
	mov r0, #0x1c
	str r1, [sp, #0x14]
	str r2, [sp, #0x18]
	str r3, [sp, #0x1c]
	add r1, sp, #0x14
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	ldr r0, [r9, #0x14]
	add r1, sp, #8
	str r0, [sp, #0x10]
	str r4, [sp, #8]
	str r4, [sp, #0xc]
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	ldr r1, [r8, #0x168]
	ldr r0, [r8, #0x170]
	tst r1, #3
	ldrne r1, [r8, #0x16c]
	sub r1, r1, r0
	ldr r0, [r8, #0x17c]
	bl NNS_G3dGeSendDL
	mov r0, #1
	str r0, [sp]
	mov r0, #0x12
	add r1, sp, #0
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
_0202CA18:
	add r10, r10, #1
	cmp r10, #0x20
	add r9, r9, #0x18
	blt _0202C8E4
	add sp, sp, #0x8c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

// EffectSlingDust
NONMATCH_FUNC EffectSlingDust *EffectSlingDust__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, s32 type){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r6, [sp, #0x28]
	mov r10, r0
	mov r9, r1
	cmp r6, #1
	movhi r6, #1
	mov r0, #0x218
	mov r1, #0
	mov r8, r2
	mov r7, r3
	and r6, r6, #0xff
	bl CreateEffectTask
	movs r5, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, #0xa0
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	ldr r2, =aActAcGmkSlingD
	ldr r1, [r1]
	mov r3, r0
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	mov r0, r5
	add r1, r5, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r5
	mov r1, r6
	mov r2, #0x5c
	bl ObjActionAllocSpritePalette
	ldr r0, [r5, #0x20c]
	mov r1, r6, lsl #0x10
	ldr r0, [r0]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize2FromAnim
	mov r4, r0
	mov r0, r6, lsl #1
	add r0, r0, #0xa1
	bl GetObjectFileWork
	mov r2, r0
	mov r1, r4
	mov r0, r5
	bl ObjObjectActionAllocSprite
	mov r0, r6, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r5
	bl StageTask__SetAnimation
	mov r0, r5
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r10, [r5, #0x44]
	str r9, [r5, #0x48]
	str r8, [r5, #0x98]
	mov r2, #0
	str r7, [r5, #0x9c]
	str r2, [sp]
	mov r0, r5
	mov r1, #0x10
	mov r3, r2
	str r2, [sp, #4]
	bl InitEffectTaskViewCheck
	ldr r2, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	tst r0, #1
	ldrne r0, [r5, #0x20]
	ldr r2, =_mt_math_rand
	orrne r0, r0, #1
	strne r0, [r5, #0x20]
	ldr r0, =0x00196225
	ldr r3, [r2]
	ldr r1, =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	ldrne r0, [r5, #0x20]
	orrne r0, r0, #2
	strne r0, [r5, #0x20]
	ldr r1, [r5, #0x1c]
	mov r0, #0xa0
	orr r1, r1, #0x80
	str r1, [r5, #0x1c]
	str r0, [r5, #0x2c]
	ldr r1, =EffectTask_State_MoveTowardsZeroX
	mov r0, r5
	str r1, [r5, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
// clang-format on
#endif
}

// EffectSailboatBazookaSmoke
NONMATCH_FUNC EffectSailboatBazookaSmoke *EffectSailboatBazookaSmoke__Create(StageTask *parent, fx32 velX, fx32 velY, fx32 velZ){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x60
	mov r8, r0
	mov r7, r1
	mov r1, r8
	mov r0, #0x2d0
	mov r6, r2
	mov r5, r3
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #0x60
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0xa7
	bl GetObjectFileWork
	mov r2, #0x15
	str r2, [sp]
	ldr r1, =EffectTask_State_TrackParent
	mov r2, r0
	str r1, [sp, #4]
	mov r1, #0
	str r1, [sp, #8]
	ldr r0, =gameArchiveStage
	ldr r1, =aModSbBazooka
	ldr r3, [r0]
	mov r0, r4
	bl LoadEffectTask3DAsset
	ldrh r1, [r8, #0x30]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x3c
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	blx MTX_RotX33_
	ldrh r1, [r8, #0x32]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x18
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
	blx MTX_RotY33_
	add r0, sp, #0x3c
	add r1, sp, #0x18
	mov r2, r0
	bl MTX_Concat33
	ldrh r1, [r8, #0x34]
	ldr r3, =FX_SinCosTable_
	add r0, sp, #0x18
	mov r1, r1, asr #4
	mov r2, r1, lsl #1
	mov r1, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	blx MTX_RotZ33_
	add r0, sp, #0x3c
	add r1, sp, #0x18
	mov r2, r0
	bl MTX_Concat33
	add r0, sp, #0xc
	str r7, [sp, #0xc]
	str r6, [sp, #0x10]
	str r5, [sp, #0x14]
	add r1, sp, #0x3c
	mov r2, r0
	bl MTX_MultVec33
	ldr r1, [r8, #0x44]
	ldr r0, [sp, #0xc]
	add r0, r1, r0
	str r0, [r4, #0x44]
	ldr r1, [r8, #0x48]
	ldr r0, [sp, #0x10]
	add r0, r1, r0
	str r0, [r4, #0x48]
	ldr r2, [r8, #0x4c]
	ldr r1, [sp, #0x14]
	mov r0, r4
	add r1, r2, r1
	str r1, [r4, #0x4c]
	ldr r1, [sp, #0xc]
	str r1, [r4, #0x98]
	ldr r1, [sp, #0x10]
	str r1, [r4, #0x9c]
	ldr r1, [sp, #0x14]
	str r1, [r4, #0xa0]
	ldrh r2, [r8, #0x30]
	ldrh r1, [r8, #0x32]
	strh r2, [r4, #0x30]
	strh r1, [r4, #0x32]
	ldrh r1, [r8, #0x34]
	strh r1, [r4, #0x34]
	ldr r1, [r4, #0x20]
	bic r1, r1, #0x100
	bic r1, r1, #0x200
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2000
	str r1, [r4, #0x1c]
	add sp, sp, #0x60
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

// EffectHoverCrystalSparkle
NONMATCH_FUNC EffectHoverCrystalSparkle *EffectHoverCrystalSparkle__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, fx32 accX, fx32 accY){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r4, =EffectTask__sVars
	mov r8, r0
	ldr r4, [r4, #4]
	mov r7, r1
	mov r6, r2
	mov r5, r3
	cmp r4, #0
	beq _0202CE0C
	add r0, r4, #0x200
	ldrsh r0, [r0, #0x18]
	cmp r0, #0x20
	blt _0202CF08
_0202CE0C:
	ldr r0, =0x0000059C
	mov r1, #0
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, =EffectTask__sVars
	ldr r1, =EffectHoverCrystalSparkle__Destructor
	ldr r0, [r0]
	bl SetTaskDestructorEvent
	ldr r0, [r4, #0x1c]
	ldr r1, =EffectTask__sVars
	orr r0, r0, #0x2000
	str r0, [r4, #0x1c]
	mov r0, #0xae
	str r4, [r1, #4]
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	ldr r2, =aActAcGmkAirEfB
	mov r0, r4
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, #0xaf
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #0xa
	bl ObjObjectActionAllocSprite
	mov r0, r4
	mov r1, #0
	mov r2, #0x61
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	ldr r3, [r4, #0x128]
	mov r1, #0
	ldr r0, [r3, #0x3c]
	mov r2, r1
	orr r0, r0, #0x20
	str r0, [r3, #0x3c]
	ldr r0, [r4, #0x128]
	bl AnimatorSpriteDS__ProcessAnimation
	ldr r3, [r4, #0x128]
	ldr r1, =EffectHoverCrystalSparkle__State_202CFB8
	ldr r2, [r3, #0x3c]
	ldr r0, =EffectHoverCrystalSparkle__Draw
	orr r2, r2, #8
	str r2, [r3, #0x3c]
	str r1, [r4, #0xf4]
	str r0, [r4, #0xfc]
_0202CF08:
	add r1, r4, #0x200
	ldrsh r3, [r1, #0x1a]
	ldrsh r2, [r1, #0x18]
	mov r0, #0x1c
	add ip, r4, #0x21c
	add r2, r3, r2
	and r2, r2, #0x1f
	smulbb r0, r2, r0
	str r8, [ip, r0]
	add r3, ip, r0
	str r7, [r3, #4]
	str r6, [r3, #8]
	ldr r2, [sp, #0x20]
	str r5, [r3, #0xc]
	ldr r0, [sp, #0x24]
	str r2, [r3, #0x10]
	str r0, [r3, #0x14]
	mov r0, #0
	strh r0, [r3, #0x18]
	ldrsh r2, [r1, #0x18]
	mov r0, r4
	add r2, r2, #1
	strh r2, [r1, #0x18]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectHoverCrystalSparkle__Destructor(Task *task){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	ldr r1, =EffectTask__sVars
	ldr r2, [r1, #4]
	cmp r2, r0
	moveq r0, #0
	streq r0, [r1, #4]
	mov r0, r4
	bl StageTask_Destructor
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectHoverCrystalSparkle__State_202CFB8(EffectHoverCrystalSparkle *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	add r4, r0, #0x200
	ldrsh r1, [r4, #0x18]
	mov r3, #0
	mov ip, r3
	cmp r1, #0
	ble _0202D06C
	add r1, r0, #0x21c
	mov lr, #0x1c
_0202CFDC:
	ldrsh r2, [r4, #0x1a]
	add r2, r2, r3
	and r5, r2, #0x1f
	mla r2, r5, lr, r1
	ldrh r5, [r2, #0x18]
	add r5, r5, #1
	strh r5, [r2, #0x18]
	ldrh r5, [r2, #0x18]
	cmp r5, #0x24
	blo _0202D01C
	ldrsh r2, [r4, #0x1a]
	add ip, ip, #1
	add r2, r2, #1
	and r2, r2, #0x1f
	strh r2, [r4, #0x1a]
	b _0202D05C
_0202D01C:
	ldr r6, [r2]
	ldr r5, [r2, #8]
	add r5, r6, r5
	str r5, [r2]
	ldr r6, [r2, #4]
	ldr r5, [r2, #0xc]
	add r5, r6, r5
	str r5, [r2, #4]
	ldr r6, [r2, #8]
	ldr r5, [r2, #0x10]
	add r5, r6, r5
	str r5, [r2, #8]
	ldr r6, [r2, #0xc]
	ldr r5, [r2, #0x14]
	add r5, r6, r5
	str r5, [r2, #0xc]
_0202D05C:
	ldrsh r2, [r4, #0x18]
	add r3, r3, #1
	cmp r3, r2
	blt _0202CFDC
_0202D06C:
	add r1, r0, #0x200
	ldrsh r2, [r1, #0x18]
	sub r2, r2, ip
	strh r2, [r1, #0x18]
	ldrsh r1, [r1, #0x18]
	cmp r1, #0
	ldmgtia sp!, {r4, r5, r6, pc}
	ldr r1, =EffectTask__sVars
	ldr r2, [r1, #4]
	cmp r2, r0
	moveq r2, #0
	streq r2, [r1, #4]
	ldr r1, [r0, #0x18]
	orr r1, r1, #4
	str r1, [r0, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectHoverCrystalSparkle__Draw(void){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r0, #0x1000
	str r0, [sp, #0xc]
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r10, [r5, #0x128]
	mov r1, #0
	mov r0, r10
	bl AnimatorSpriteDS__SetAnimation
	mov r8, #0
	str r8, [sp, #0x18]
	add r4, r5, #0x200
	ldrsh r0, [r4, #0x18]
	subs r7, r0, #1
	addmi sp, sp, #0x1c
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r6, r5, #0x21c
	add r5, sp, #0xc
	mov r11, #0x1c
_0202D100:
	ldrsh r0, [r4, #0x1a]
	add r0, r0, r7
	and r0, r0, #0x1f
	mla r9, r0, r11, r6
	ldrh r0, [r9, #0x18]
	subs r1, r0, r8
	beq _0202D134
	mov r2, #0
	mov r0, r10
	mov r3, r2
	mov r1, r1, lsl #0xc
	bl AnimatorSpriteDS__AnimateManual
	ldrh r8, [r9, #0x18]
_0202D134:
	ldr r1, [r9]
	mov r0, r10
	str r1, [sp, #0x10]
	ldr r2, [r9, #4]
	add r1, sp, #0x10
	str r2, [sp, #0x14]
	mov r2, #0
	str r5, [sp]
	str r2, [sp, #4]
	mov r9, r2
	mov r3, r2
	str r9, [sp, #8]
	bl StageTask__Draw2DEx
	subs r7, r7, #1
	bpl _0202D100
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
// clang-format on
#endif
}

// EffectIceSparklesSpawner
NONMATCH_FUNC EffectIceSparklesSpawner *EffectIceSparklesSpawner__Create(StageTask *parent){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	mov r1, r0
	mov r0, #0x168
	bl CreateEffectTask
	cmp r0, #0
	ldrne r1, =EffectIceSparklesSpawner__State_202D19C
	strne r1, [r0, #0xf4]
	ldmia sp!, {r3, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectIceSparklesSpawner__State_202D19C(EffectIceSparklesSpawner *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r0, [r4, #0x2c]
	ldr r1, [r4, #0x11c]
	tst r0, #3
	bne _0202D228
	ldr r3, =_mt_math_rand
	ldr r0, =0x00196225
	ldr lr, [r3]
	ldr r2, =0x3C6EF35F
	mov ip, #1
	mla r5, lr, r0, r2
	mla r2, r5, r0, r2
	str r5, [r3]
	ldr r0, [r1, #0x48]
	mov lr, r5, lsr #0x10
	str r2, [r3]
	str ip, [sp]
	ldr r3, [r3]
	mov r2, lr, lsl #0x10
	mov r3, r3, lsr #0x10
	mov ip, r2, lsr #0x10
	mov r2, r3, lsl #0x10
	and r3, ip, #6
	mov r2, r2, lsr #0x10
	rsb r3, r3, #3
	and r2, r2, #6
	add r3, r0, r3, lsl #12
	ldr r1, [r1, #0x44]
	rsb r0, r2, #3
	add r0, r1, r0, lsl #12
	add r1, r3, #0x10000
	mov r2, #0
	mov r3, #0x2000
	bl EffectIceSparkles__Create
_0202D228:
	ldr r0, [r4, #0x2c]
	add r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0x3c
	ldrge r0, [r4, #0x18]
	orrge r0, r0, #4
	strge r0, [r4, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
// clang-format on
#endif
}

// EffectMedal
NONMATCH_FUNC EffectMedal *EffectMedal__Create(StageTask *parent){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x4c
	mov r1, r0
	mov r0, #0x23c
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #0x4c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, =EffectTask__sVars
	ldr r1, =EffectMedal__Destructor
	ldr r0, [r0]
	bl SetTaskDestructorEvent
	ldr r0, =gameState
	ldrh r0, [r0, #0x28]
	cmp r0, #0x16
	addls pc, pc, r0, lsl #2
	b _0202D2F8
_0202D29C: // jump table
	b _0202D2F8 // case 0
	b _0202D300 // case 1
	b _0202D2F8 // case 2
	b _0202D2F8 // case 3
	b _0202D308 // case 4
	b _0202D310 // case 5
	b _0202D2F8 // case 6
	b _0202D318 // case 7
	b _0202D320 // case 8
	b _0202D2F8 // case 9
	b _0202D2F8 // case 10
	b _0202D328 // case 11
	b _0202D330 // case 12
	b _0202D2F8 // case 13
	b _0202D338 // case 14
	b _0202D340 // case 15
	b _0202D2F8 // case 16
	b _0202D348 // case 17
	b _0202D350 // case 18
	b _0202D2F8 // case 19
	b _0202D2F8 // case 20
	b _0202D358 // case 21
	b _0202D360 // case 22
_0202D2F8:
	mov r5, #0
	b _0202D364
_0202D300:
	mov r5, #1
	b _0202D364
_0202D308:
	mov r5, #2
	b _0202D364
_0202D310:
	mov r5, #3
	b _0202D364
_0202D318:
	mov r5, #4
	b _0202D364
_0202D320:
	mov r5, #5
	b _0202D364
_0202D328:
	mov r5, #6
	b _0202D364
_0202D330:
	mov r5, #7
	b _0202D364
_0202D338:
	mov r5, #8
	b _0202D364
_0202D340:
	mov r5, #9
	b _0202D364
_0202D348:
	mov r5, #0xa
	b _0202D364
_0202D350:
	mov r5, #0xb
	b _0202D364
_0202D358:
	mov r5, #0xc
	b _0202D364
_0202D360:
	mov r5, #0xd
_0202D364:
	mov r0, r5
	mov r1, #0xa
	bl FX_DivS32
	add r2, r0, #0x30
	mov r0, r5
	mov r1, #0xa
	strb r2, [sp, #8]
	bl FX_ModS32
	add r3, r0, #0x30
	mov r2, #0
	ldr r1, =aActAcGmkMedal
	add r0, sp, #0xb
	strb r3, [sp, #9]
	strb r2, [sp, #0xa]
	bl STD_CopyString
	add r0, sp, #0xb
	add r1, sp, #8
	bl STD_ConcatenateString
	ldr r1, =_0211930C
	add r0, sp, #0xb
	bl STD_ConcatenateString
	mov r0, #0x9c
	bl GetObjectFileWork
	mov r3, r0
	mov r0, #0
	str r0, [sp]
	ldr r1, =0x0000FFFF
	mov r0, r4
	str r1, [sp, #4]
	add r1, r4, #0x168
	add r2, sp, #0xb
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x6c
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	ldr r3, [r4, #0x128]
	mov r0, r4
	ldr r2, [r3, #0x3c]
	mov r1, #0xd
	orr r2, r2, #0x200
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	ldr r1, =aBpaGmkMedal
	add r0, sp, #0xb
	bl STD_CopyString
	add r0, sp, #0xb
	add r1, sp, #8
	bl STD_ConcatenateString
	ldr r1, =_02119324
	add r0, sp, #0xb
	bl STD_ConcatenateString
	mov r0, #0x9d
	bl GetObjectFileWork
	add r1, sp, #0xb
	mov r2, #0
	bl ObjDataLoad
	mov r2, #0
	str r2, [sp]
	ldr r3, [r4, #0x128]
	mov r1, r0
	ldrh ip, [r3, #0x90]
	add r0, r4, #0x218
	mov r3, #2
	mov ip, ip, lsl #5
	add ip, ip, #0x200
	add ip, ip, #0x5000000
	str ip, [sp, #4]
	bl InitPaletteAnimator
	ldr r1, [r4, #0x48]
	mov r0, #0
	sub r1, r1, #0x20000
	str r1, [r4, #0x48]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	sub r0, r0, #0x7000
	str r0, [r4, #0x9c]
	ldr r1, =EffectMedal__State_202D514
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectMedal__Destructor(Task *task){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	add r0, r0, #0x218
	bl ReleasePaletteAnimator
	mov r0, #0x9d
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, r4
	bl StageTask_Destructor
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectMedal__State_202D514(EffectMedal *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x18]
	tst r0, #1
	beq _0202D600
	ldr r1, =mapCamera
	add r0, r4, #0x218
	ldr r7, [r1]
	ldr r5, [r1, #0x70]
	mov r6, #0
	bl AnimatePalette
	add r0, r4, #0x218
	bl CheckPaletteAnimationIsValid
	cmp r0, #0
	beq _0202D600
	tst r7, #0x1000000
	beq _0202D564
	tst r7, #0x2000000
	beq _0202D590
_0202D564:
	ldr r1, [r4, #0x128]
	add r0, r4, #0x218
	ldrh r2, [r1, #0x90]
	mov r1, #0
	mov r2, r2, lsl #5
	add r2, r2, #0x200
	add r2, r2, #0x5000000
	bl SetPaletteAnimationTarget
	add r0, r4, #0x218
	bl DrawAnimatedPalette
	b _0202D594
_0202D590:
	mov r6, #1
_0202D594:
	tst r5, #0x1000000
	beq _0202D5A4
	tst r5, #0x2000000
	beq _0202D5D0
_0202D5A4:
	ldr r1, [r4, #0x128]
	add r0, r4, #0x218
	ldrh r2, [r1, #0x90]
	mov r1, #0
	mov r2, r2, lsl #5
	add r2, r2, #0x600
	add r2, r2, #0x5000000
	bl SetPaletteAnimationTarget
	add r0, r4, #0x218
	bl DrawAnimatedPalette
	b _0202D5D4
_0202D5D0:
	mov r6, #1
_0202D5D4:
	cmp r6, #0
	beq _0202D600
	ldr r0, [r4, #0x128]
	ldr r3, =objDrawPalette2
	ldrh r2, [r0, #0x90]
	add r0, r4, #0x218
	mov r1, #0
	add r2, r3, r2, lsl #5
	bl SetPaletteAnimationTarget
	add r0, r4, #0x218
	bl DrawAnimatedPalette
_0202D600:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _0202D614
	cmp r0, #1
	b _0202D764
_0202D614:
	ldr r0, [r4, #0x2c]
	add r0, r0, #0x44
	str r0, [r4, #0x2c]
	cmp r0, #0x1000
	ble _0202D658
	ldr r1, [r4, #0x28]
	mov r0, #0x1000
	add r1, r1, #1
	str r1, [r4, #0x28]
	ldr r1, [r4, #0x18]
	orr r1, r1, #1
	str r1, [r4, #0x18]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x38]
	mov r0, #0
	str r0, [r4, #0x9c]
	b _0202D764
_0202D658:
	mov r0, r0, lsl #0x10
	mov r3, r0, asr #0x10
	mov r0, #0
	mov r2, r3, asr #0x1f
	mov r1, #1
	mov r6, r0
	mov r5, #0x800
_0202D674:
	rsb r7, r0, #0x1000
	umull ip, r8, r7, r3
	mla r8, r7, r2, r8
	mov r7, r7, asr #0x1f
	mla r8, r7, r3, r8
	adds ip, ip, r5
	adc r7, r8, r6
	mov r8, ip, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r1, #0
	add r0, r0, r8
	sub r1, r1, #1
	bne _0202D674
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	ldr r0, [r4, #0x2c]
	cmp r0, #0x800
	bgt _0202D714
	mov r0, r0, lsl #0x11
	mov r3, r0, asr #0x10
	mov r1, #0
	sub r0, r1, #0x7000
	mov r2, r3, asr #0x1f
	mov r6, r1
	mov r5, #0x800
_0202D6D8:
	rsb ip, r0, #0
	umull r7, lr, ip, r3
	mla lr, ip, r2, lr
	mov ip, ip, asr #0x1f
	adds r8, r7, r5
	mla lr, ip, r3, lr
	adc r7, lr, r6
	mov r8, r8, lsr #0xc
	orr r8, r8, r7, lsl #20
	cmp r1, #0
	add r0, r0, r8
	sub r1, r1, #1
	bne _0202D6D8
	str r0, [r4, #0x9c]
	b _0202D764
_0202D714:
	sub r0, r0, #0x800
	mov r0, r0, lsl #0x11
	mov ip, r0, asr #0x10
	mov r7, #0
	mov r8, ip, asr #0x1f
	mov r6, #0x7000
	mov r1, r7
	mov r0, #0x800
_0202D734:
	umull r5, r3, r6, ip
	mla r3, r6, r8, r3
	mov r2, r6, asr #0x1f
	adds r5, r5, r0
	mla r3, r2, ip, r3
	adc r2, r3, r1
	mov r6, r5, lsr #0xc
	cmp r7, #0
	orr r6, r6, r2, lsl #20
	sub r7, r7, #1
	bne _0202D734
	str r6, [r4, #0x9c]
_0202D764:
	ldr r0, [r4, #0x38]
	cmp r0, #0x100
	addle sp, sp, #8
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r4, #0x238]
	tst r0, #0xf
	bne _0202D7EC
	ldr r5, =_obj_disp_rand
	mov r2, #0
	ldr r6, [r5]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	mov r3, r2
	mla ip, r6, r0, r1
	mla r0, ip, r0, r1
	str r0, [r5]
	str r2, [sp]
	str r2, [sp, #4]
	ldr r0, [r5]
	mov r5, ip, lsr #0x10
	mov r1, r0, lsr #0x10
	mov r0, r5, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	and r1, r0, #0x1e
	and r0, r5, #0x1e
	ldr ip, [r4, #0x44]
	rsb r6, r1, #0xf
	ldr r5, [r4, #0x48]
	rsb r1, r0, #0xf
	add r0, ip, r6, lsl #12
	add r1, r5, r1, lsl #12
	bl EffectRingSparkle__Create
_0202D7EC:
	ldr r0, [r4, #0x238]
	add r0, r0, #1
	str r0, [r4, #0x238]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

// EffectRingSparkle
NONMATCH_FUNC EffectRingSparkle *EffectRingSparkle__Create(fx32 x, fx32 y, fx32 velX, fx32 velY, fx32 accX, fx32 accY){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r4, =ringManagerWork
	mov r8, r0
	ldr r0, [r4]
	mov r7, r1
	cmp r0, #0
	mov r6, r2
	mov r5, r3
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0x218
	mov r1, #0
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, =EffectTask__sVars
	ldr r1, =EffectRingSparkle__Destructor
	ldr r0, [r0]
	bl SetTaskDestructorEvent
	mov r0, #0x99
	bl GetObjectFileWork
	ldr r1, =gameArchiveCommon
	mov r3, r0
	ldr r1, [r1]
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, r4
	add r1, r4, #0x168
	ldr r2, =aAcItmRingBac_0
	bl ObjObjectAction2dBACLoad
	ldr r1, =ringManagerWork
	ldr r2, [r4, #0x128]
	ldr r0, [r1]
	mov r3, #2
	ldr ip, [r0, #0x130]
	mov r0, r4
	str ip, [r2, #0x78]
	ldr r1, [r1]
	ldr r2, [r4, #0x128]
	ldr ip, [r1, #0x134]
	mov r1, #1
	str ip, [r2, #0x7c]
	ldr r2, [r4, #0x128]
	strh r3, [r2, #0x92]
	ldr r3, [r4, #0x128]
	ldrh r2, [r3, #0x92]
	strh r2, [r3, #0x90]
	ldr r3, [r4, #0x128]
	ldr r2, [r3, #0x3c]
	orr r2, r2, #0x10
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0xc
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	str r8, [r4, #0x44]
	str r7, [r4, #0x48]
	str r6, [r4, #0x98]
	str r5, [r4, #0x9c]
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x24]
	str r1, [r4, #0xa4]
	str r0, [r4, #0xa8]
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	mov r0, r4
	mov r1, #0x10
	mov r3, r2
	bl InitEffectTaskViewCheck
	ldr r1, =EffectTask_State_DestroyAfterAnimation
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
// clang-format on
#endif
}

NONMATCH_FUNC void EffectRingSparkle__Destructor(Task *task){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	ldr r1, [r0, #0x128]
	mov r2, #0
	str r2, [r1, #0x78]
	ldr r1, [r0, #0x128]
	mov r0, r4
	str r2, [r1, #0x7c]
	bl StageTask_Destructor
	ldmia sp!, {r4, pc}
// clang-format on
#endif
}

// EffectButtonPrompt
NONMATCH_FUNC EffectButtonPrompt *EffectButtonPrompt__Create(StageTask *parent, s32 type)
{
#ifdef NON_MATCHING
    static u8 animIDs[2]                                = { 1, 0 };
    static void (*states[2])(EffectButtonPrompt * work) = { EffectButtonPrompt__State_DPadUp, EffectButtonPrompt__State_JumpButton };

    EffectButtonPrompt *work = CreateEffect(EffectButtonPrompt, parent);

    if (work == NULL)
        return NULL;

    ObjObjectAction2dBACLoad(&work->objWork, &work->ani, "/ac_fix_key_little.bac", GetObjectFileWork(OBJDATAWORK_152), gameArchiveCommon, OBJ_DATA_GFX_AUTO);
    work->objWork.obj_2d->ani.cParam[1].palette = 1;
    work->objWork.obj_2d->ani.cParam[0].palette = work->objWork.obj_2d->ani.cParam[1].palette;
    work->objWork.obj_2d->ani.work.flags |= ANIMATOR_FLAG_DISABLE_PALETTES;

    StageTask__SetAnimation(&work->objWork, animIDs[type]);
    StageTask__SetAnimatorOAMOrder(&work->objWork, SPRITE_ORDER_6);
    StageTask__SetAnimatorPriority(&work->objWork, SPRITE_PRIORITY_0);
    work->objWork.moveFlag |= STAGE_TASK_MOVE_FLAG_DISABLE_MOVE_EVENT;
    work->objWork.displayFlag |= DISPLAY_FLAG_DISABLE_LOOPING;
    work->objWork.position.y -= FLOAT_TO_FX32(32.0);
    SetTaskState(&work->objWork, states[type]);

    return work;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r1
	mov r1, r0
	mov r0, #0x218
	bl CreateEffectTask
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, #0x98
	bl GetObjectFileWork
	ldr r1, =gameArchiveCommon
	ldr ip, =0x0000FFFF
	ldr r1, [r1]
	mov r3, r0
	stmia sp, {r1, ip}
	ldr r2, =aAcFixKeyLittle
	mov r0, r4
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	ldr r1, [r4, #0x128]
	mov r2, #1
	strh r2, [r1, #0x92]
	ldr r3, [r4, #0x128]
	ldr r0, =EffectButtonPrompt_animIDs
	ldrh r2, [r3, #0x92]
	ldrb r1, [r0, r5]
	mov r0, r4
	strh r2, [r3, #0x90]
	ldr r3, [r4, #0x128]
	ldr r2, [r3, #0x3c]
	orr r2, r2, #0x10
	str r2, [r3, #0x3c]
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #6
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimatorPriority
	ldr r1, [r4, #0x1c]
	ldr r0, =EffectButtonPrompt__states
	orr r2, r1, #0x2000
	str r2, [r4, #0x1c]
	ldr r2, [r4, #0x20]
	ldr r1, [r0, r5, lsl #2]
	orr r2, r2, #4
	str r2, [r4, #0x20]
	ldr r2, [r4, #0x48]
	mov r0, r4
	sub r2, r2, #0x20000
	str r2, [r4, #0x48]
	str r1, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
// clang-format on
#endif
}

void EffectButtonPrompt__State_DPadUp(EffectButtonPrompt *work)
{
    StageTask *parent = work->objWork.parentObj;
    if (parent != NULL)
    {
        work->objWork.position.x = parent->position.x;
        work->objWork.position.y = parent->position.y - FLOAT_TO_FX32(32.0);

        work->objWork.userTimer++;
        if (work->objWork.userTimer >= 300 || !StageTaskStateMatches(parent, Player__State_DreamWing))
            DestroyStageTask(&work->objWork);
    }
}

void EffectButtonPrompt__State_JumpButton(EffectButtonPrompt *work)
{
    StageTask *parent = work->objWork.parentObj;
    if (parent != NULL)
    {
        work->objWork.position.x = parent->position.x;
        work->objWork.position.y = parent->position.y - FLOAT_TO_FX32(32.0);

        if (parent->userWork != JUMPBOX_STATE_VAULTING || !StageTaskStateMatches(parent, Player__State_JumpBox))
            DestroyStageTask(&work->objWork);
    }
}
