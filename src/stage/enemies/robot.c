#include <stage/enemies/robot.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/audio/spatialAudio.h>
#include <stage/core/bgmManager.h>
#include <stage/effects/explosion.h>
#include <stage/effects/found.h>
#include <stage/effects/steamBlasterSmoke.h>
#include <stage/effects/steamBlasterSteam.h>
#include <stage/effects/waterSplash.h>
#include <stage/objects/tutorial.h>

NOT_DECOMPILED const void *_02188194;
NOT_DECOMPILED const void *_021881A0;
NOT_DECOMPILED const void *_021881B4;

NOT_DECOMPILED s16 _02188B48[5];
NOT_DECOMPILED void *_02188B54;
NOT_DECOMPILED void *aActAcEneTriBac;
NOT_DECOMPILED void *aActAcEnePteraB;
NOT_DECOMPILED void *aActAcEneFlyFis;
NOT_DECOMPILED void *aActAcEneProtSp;
NOT_DECOMPILED void *aActAcEneProtDa_0;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC EnemyRobot *EnemyRobot__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	movs r8, r0
	mov r7, r1
	mov r6, r2
	beq _02154EC0
	ldrb r0, [r8]
	cmp r0, #0xff
	ldreqb r0, [r8, #1]
	cmpeq r0, #0xff
	beq _02154EE4
_02154EC0:
	ldr r0, =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _02154EE4
	ldrh r0, [r8, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02154EE4:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x3e8
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x3e8
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldrh r0, [r8, #2]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _021551EC
_02154F68: // jump table
	b _02154F7C // case 0
	b _02155020 // case 1
	b _02155064 // case 2
	b _021550C8 // case 3
	b _02155144 // case 4
_02154F7C:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #0
	orr r1, r1, #0xc0
	str r1, [r4, #0x1c]
	bl EnemyRobot__Func_2155378
	ldr r0, =EnemyRobot__OnInit_21553D0
	mov r2, r5
	str r0, [r4, #0x3ac]
	add r0, r4, #0x300
	strh r2, [r0, #0xc8]
	mov r1, #1
	strh r1, [r0, #0xca]
	rsb r1, r1, #0x10000
	strh r1, [r0, #0xcc]
	mov r2, #0xc00
	ldr r1, =EnemyRobot__OnDetect_2155820
	str r2, [r4, #0x3d4]
	str r1, [r4, #0x3b0]
	mov r1, #0x200
	str r1, [r4, #0x3dc]
	mov r1, #0x4000
	str r1, [r4, #0x3e0]
	mov r1, #0xa
	strh r1, [r0, #0xe4]
	strh r1, [r0, #0xe6]
	mov r1, #2
	strh r1, [r0, #0xd8]
	ldrh r0, [r8, #4]
	tst r0, #0x40
	beq _021551EC
	ldr r0, =EnemyRobot__OnDefend_TutorialEnemy
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x1c]
	bic r0, r0, #0x80
	orr r0, r0, #0x100
	str r0, [r4, #0x1c]
	b _021551EC
_02155020:
	ldr r0, [r4, #0x20]
	ldr r1, =EnemyRobot__OnInit_21557D8
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	mov r5, #1
	orr r0, r0, #0x100
	str r0, [r4, #0x1c]
	ldrh r0, [r8, #4]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldr r0, =EnemyRobot__OnDetect_2155C5C
	str r1, [r4, #0x3ac]
	str r0, [r4, #0x3b0]
	b _021551EC
_02155064:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #2
	orr r1, r1, #0x140
	str r1, [r4, #0x1c]
	bl EnemyRobot__Func_2155378
	ldr r1, =EnemyRobot__OnInit_2155620
	add r0, r4, #0x300
	str r1, [r4, #0x3ac]
	mov r1, #0
	strh r1, [r0, #0xc8]
	mov r1, #4
	strh r1, [r0, #0xca]
	mov r1, #0xc00
	str r1, [r4, #0x3cc]
	mov r1, #0x1800
	str r1, [r4, #0x3d0]
	mov r2, #0x300
	ldr r1, =EnemyRobot__OnDetect_21559D8
	strh r2, [r0, #0xd4]
	str r1, [r4, #0x3b0]
	b _021551EC
_021550C8:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #3
	orr r1, r1, #0xc0
	str r1, [r4, #0x1c]
	bl EnemyRobot__Func_2155378
	ldr r1, =EnemyRobot__OnInit_21553D0
	add r0, r4, #0x300
	str r1, [r4, #0x3ac]
	mov r2, #0
	strh r2, [r0, #0xc8]
	mov r1, #1
	strh r1, [r0, #0xca]
	mov r1, #2
	strh r1, [r0, #0xcc]
	mov r1, #0x78
	strh r1, [r0, #0xce]
	strh r2, [r0, #0xd0]
	mov r2, #0xc00
	ldr r1, =EnemyRobot__OnDetect_2155820
	str r2, [r4, #0x3d4]
	str r1, [r4, #0x3b0]
	ldr r2, [r4, #0x354]
	mov r1, r5
	orr r2, r2, #0x8000
	str r2, [r4, #0x354]
	strh r1, [r0, #0xd8]
	b _021551EC
_02155144:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #4
	orr r1, r1, #0xc0
	str r1, [r4, #0x1c]
	bl EnemyRobot__Func_2155378
	ldr r0, =EnemyRobot__OnInit_21553D0
	mov r1, #0
	str r0, [r4, #0x3ac]
	add r0, r4, #0x300
	strh r1, [r0, #0xc8]
	mov r2, #5
	strh r2, [r0, #0xca]
	mov r2, #1
	strh r2, [r0, #0xcc]
	mov r2, #0xf0
	strh r2, [r0, #0xce]
	strh r1, [r0, #0xd0]
	mov r0, #0xc00
	ldr r3, =EnemyRobot__OnDetect_FoundFX
	str r0, [r4, #0x3d4]
	mov r2, r1
	add r0, r4, #0x298
	str r3, [r4, #0x3b0]
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x298
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =0x00000102
	add r0, r4, #0x200
	strh r1, [r0, #0xcc]
	ldr r0, [r4, #0x2b0]
	ldr r1, =EnemyRobot__OnDefend_Hurtbox
	orr r0, r0, #0x400
	str r0, [r4, #0x2b0]
	mov r0, r4
	str r1, [r4, #0x2bc]
	bl EffectSteamBlasterSmoke__Create
_021551EC:
	ldr r0, =_021881A0
	add r1, r4, #0x300
	ldr r0, [r0, r5, lsl #2]
	strh r5, [r1, #0xc6]
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	ldr r2, =0x0000FFFF
	ldr r3, [r1]
	ldr r1, =_02188B54
	str r3, [sp]
	str r2, [sp, #4]
	mov r3, r0
	ldr r2, [r1, r5, lsl #2]
	mov r0, r4
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r3, r5, lsl #1
	ldr r2, =_02188194
	ldrsh r2, [r2, r3]
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x1c]
	tst r0, #0x100
	bne _02155284
	mvn r6, #1
	mov r0, r4
	sub r1, r6, #6
	sub r2, r6, #8
	mov r3, #8
	str r6, [sp]
	bl StageTask__SetHitbox
_02155284:
	ldr r3, =0x021881BA
	mov r6, r5, lsl #3
	ldr r1, =_021881B4
	ldr r2, =0x021881B6
	ldr r0, =0x021881B8
	ldrsh r5, [r3, r6]
	ldrsh r1, [r1, r6]
	ldrsh r2, [r2, r6]
	ldrsh r3, [r0, r6]
	add r0, r4, #0x364
	str r5, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x364
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x364
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =0x00000102
	add r0, r4, #0x300
	strh r1, [r0, #0x98]
	ldr r1, [r4, #0x37c]
	ldr r0, =EnemyRobot__OnDefend_Detector
	orr r1, r1, #0x4c0
	str r1, [r4, #0x37c]
	str r0, [r4, #0x388]
	str r4, [r4, #0x380]
	ldr r1, [r4, #0x3ac]
	mov r0, r4
	blx r1
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__Func_2155378(EnemyRobot *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r1, [r0, #0x340]
	ldr r2, [r0, #0x44]
	ldrsb r1, [r1, #6]
	add r2, r2, r1, lsl #12
	str r2, [r0, #0x3b4]
	ldr r1, [r0, #0x340]
	ldrb r1, [r1, #8]
	add r1, r2, r1, lsl #12
	str r1, [r0, #0x3bc]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__Func_21553A0(EnemyRobot *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	add r1, r0, #0x300
	ldrsh r2, [r1, #0xc4]
	cmp r2, #0
	bxeq lr
	sub r2, r2, #1
	strh r2, [r1, #0xc4]
	ldrsh r1, [r1, #0xc4]
	cmp r1, #0
	ldreq r1, [r0, #0x37c]
	orreq r1, r1, #4
	streq r1, [r0, #0x37c]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__OnInit_21553D0(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0xc8]
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyRobot__State_2155450
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r1, #0
	str r1, [r4, #0x2c]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	mov r0, #0x77
	str r1, [sp]
	sub r1, r0, #0x78
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_2155450(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r2, [r6, #0x354]
	add r4, r6, #0x3c8
	tst r2, #1
	mov r5, #0
	beq _021554A0
	ldr r1, [r6, #0x20]
	tst r1, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	bic r1, r2, #1
	str r1, [r6, #0x354]
	ldr r1, [r6, #0x20]
	eor r1, r1, #1
	str r1, [r6, #0x20]
	ldrh r1, [r4]
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_021554A0:
	mov r0, r6
	bl EnemyRobot__Func_21553A0
	mov r0, r6
	add r1, r6, #0x364
	bl StageTask__HandleCollider
	ldrh r1, [r4, #4]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	beq _02155590
	ldr r0, [r6, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, r1
	beq _02155524
	ldr r0, [r6, #0x2c]
	add r1, r0, #1
	str r1, [r6, #0x2c]
	ldrsh r0, [r4, #6]
	cmp r1, r0
	blt _02155590
	mov r0, #0
	str r0, [r6, #0xc8]
	ldrh r1, [r4, #4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldrsh r0, [r4, #8]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
	ldrsh r0, [r4, #8]
	str r0, [r6, #0x2c]
	ldmia sp!, {r4, r5, r6, pc}
_02155524:
	ldr r0, [r6, #0x20]
	tst r0, #4
	beq _02155568
	ldr r0, [r6, #0x2c]
	sub r0, r0, #1
	str r0, [r6, #0x2c]
	cmp r0, #0
	ldmgtia sp!, {r4, r5, r6, pc}
	mov r0, #0
	str r0, [r6, #0x2c]
	ldrh r1, [r4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
	b _02155590
_02155568:
	tst r0, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, #0
	str r0, [r6, #0x2c]
	ldrh r1, [r4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_02155590:
	ldr r0, [r6, #0x20]
	tst r0, #1
	ldr r0, [r4, #0xc]
	rsbeq r0, r0, #0
	str r0, [r6, #0xc8]
	ldr r0, [r6, #0x1c]
	ldr r1, [r6, #0x44]
	tst r0, #4
	ldr r0, [r6, #0x3b4]
	movne r5, #1
	cmp r1, r0
	strlt r0, [r6, #0x44]
	movlt r5, #1
	blt _021555D8
	ldr r0, [r6, #0x3bc]
	cmp r1, r0
	strgt r0, [r6, #0x44]
	movgt r5, #1
_021555D8:
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrh r1, [r4, #2]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	ldreq r0, [r6, #0x20]
	eoreq r0, r0, #1
	streq r0, [r6, #0x20]
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r6, #0xc8]
	ldr r0, [r6, #0x354]
	orr r0, r0, #1
	str r0, [r6, #0x354]
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__OnInit_2155620(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0xc8]
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyRobot__State_2155650
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_2155650(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r2, [r6, #0x354]
	add r4, r6, #0x3c8
	tst r2, #1
	mov r5, #0
	beq _021556A8
	ldr r1, [r6, #0x20]
	tst r1, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	bic r1, r2, #1
	str r1, [r6, #0x354]
	ldr r1, [r6, #0x20]
	eor r1, r1, #1
	str r1, [r6, #0x20]
	ldrh r1, [r4]
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_021556A8:
	ldr r0, [r6, #0x20]
	ldr r1, =FX_SinCosTable_
	tst r0, #1
	ldr r0, [r4, #4]
	rsbeq r0, r0, #0
	str r0, [r6, #0xc8]
	ldrh r2, [r4, #0xe]
	ldrh r0, [r4, #0xc]
	add r0, r2, r0
	strh r0, [r4, #0xe]
	ldrh r2, [r4, #0xe]
	ldr r0, [r4, #8]
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r1, [r1, r2]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r6, #0x9c]
	ldr r0, [r6, #0x1c]
	ldr r1, [r6, #0x44]
	tst r0, #4
	ldr r0, [r6, #0x3b4]
	movne r5, #1
	cmp r1, r0
	strlt r0, [r6, #0x44]
	movlt r5, #1
	blt _02155730
	ldr r0, [r6, #0x3bc]
	cmp r1, r0
	strgt r0, [r6, #0x44]
	movgt r5, #1
_02155730:
	cmp r5, #0
	beq _02155774
	ldrh r1, [r4, #2]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	ldreq r0, [r6, #0x20]
	eoreq r0, r0, #1
	streq r0, [r6, #0x20]
	beq _02155774
	mov r0, r6
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r6, #0xc8]
	str r0, [r6, #0x9c]
	ldr r0, [r6, #0x354]
	orr r0, r0, #1
	str r0, [r6, #0x354]
_02155774:
	mov r0, r6
	bl EnemyRobot__Func_21553A0
	mov r0, r6
	add r1, r6, #0x364
	bl StageTask__HandleCollider
	ldr r0, [r6, #0x20]
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r1, #0
	mov r0, #0x75
	str r1, [sp]
	sub r1, r0, #0x76
	str r0, [sp, #4]
	ldr r0, [r6, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r6, #0x138]
	add r1, r6, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__OnInit_21557D8(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyRobot__State_2155804
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_2155804(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl EnemyRobot__Func_21553A0
	mov r0, r4
	add r1, r4, #0x364
	bl StageTask__HandleCollider
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__OnDetect_2155820(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0xc8]
	add r2, r4, #0x3d8
	ldrsh r1, [r2, #0xc]
	cmp r1, #0
	beq _0215585C
	str r1, [r4, #0x2c]
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyRobot__State_2155894
	orr r1, r1, #0x10
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
_0215585C:
	ldrh r1, [r2]
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x354]
	ldr r1, =EnemyRobot__State_21558F0
	tst r0, #0x8000
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #4
	streq r0, [r4, #0x20]
	mov r0, r4
	str r1, [r4, #0xf4]
	bl EnemyRobot__Func_2156100
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_2155894(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x2c]
	subs r1, r1, #1
	str r1, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0x20]
	add r1, r4, #0x300
	bic r2, r2, #0x10
	str r2, [r4, #0x20]
	ldrh r1, [r1, #0xd8]
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x354]
	ldr r1, =EnemyRobot__State_21558F0
	tst r0, #0x8000
	ldreq r0, [r4, #0x20]
	orreq r0, r0, #4
	streq r0, [r4, #0x20]
	mov r0, r4
	str r1, [r4, #0xf4]
	bl EnemyRobot__Func_2156100
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_21558F0(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x354]
	add r4, r6, #0x3d8
	tst r0, #0x8000
	mov r5, #0
	ldr r0, [r6, #0x20]
	bne _02155960
	tst r0, #1
	ldr r0, [r6, #0xc8]
	ldmib r4, {r1, r2}
	beq _02155928
	bl ObjSpdUpSet
	b _02155930
_02155928:
	rsb r1, r1, #0
	bl ObjSpdUpSet
_02155930:
	str r0, [r6, #0xc8]
	ldr r0, [r6, #0x3b4]
	ldr r1, [r6, #0x44]
	cmp r1, r0
	strlt r0, [r6, #0x44]
	movlt r5, #1
	blt _02155968
	ldr r0, [r6, #0x3bc]
	cmp r1, r0
	strgt r0, [r6, #0x44]
	movgt r5, #1
	b _02155968
_02155960:
	tst r0, #8
	movne r5, #1
_02155968:
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrsh r0, [r4, #0xe]
	cmp r0, #0
	beq _02155998
	mov r0, #0
	str r0, [r6, #0xc8]
	ldrsh r1, [r4, #0xe]
	ldr r0, =EnemyRobot__State_21559AC
	str r1, [r6, #0x2c]
	str r0, [r6, #0xf4]
	ldmia sp!, {r4, r5, r6, pc}
_02155998:
	ldr r1, [r6, #0x3ac]
	mov r0, r6
	blx r1
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_21559AC(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x2c]
	subs r1, r1, #1
	str r1, [r0, #0x2c]
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x20]
	bic r1, r1, #0x10
	str r1, [r0, #0x20]
	ldr r1, [r0, #0x3ac]
	blx r1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__OnDetect_21559D8(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r4, r0
	str r1, [r4, #0x9c]
	str r1, [r4, #0x98]
	str r1, [r4, #0xc8]
	ldr r3, [r4, #0x3a8]
	ldr r0, [r4, #0x48]
	ldr r2, [r4, #0x3a4]
	ldr r1, [r4, #0x44]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	strh r0, [r4, #0x34]
	ldr r0, [r4, #0x44]
	mov r2, #0x3000
	str r0, [r4, #0x3d8]
	ldr r1, [r4, #0x48]
	mov r0, r4
	str r1, [r4, #0x3dc]
	ldr r1, [r4, #0x354]
	rsb r2, r2, #0
	bic r1, r1, #0x8000
	str r1, [r4, #0x354]
	mov r1, #1
	str r2, [r4, #0xc8]
	bl GameObject__SetAnimation
	ldr r0, =EnemyRobot__State_2155A54
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_2155A54(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0xc8]
	mov r1, #0x200
	bl ObjSpdDownSet
	str r0, [r4, #0xc8]
	ldr r0, [r4, #0x20]
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #2
	bl GameObject__SetAnimation
	ldr r2, =EnemyRobot__State_2155AC4
	mov r0, #0x76
	sub r1, r0, #0x77
	str r2, [r4, #0xf4]
	mov r2, #0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_2155AC4(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x354]
	mov r4, #0
	tst r0, #0x8000
	ldr r1, [r5, #0x48]
	beq _02155B60
	ldr r0, [r5, #0x3dc]
	cmp r1, r0
	bgt _02155B38
	ldr r0, [r5, #0x20]
	ands r2, r0, #1
	beq _02155B08
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3d8]
	cmp r1, r0
	ble _02155B20
_02155B08:
	cmp r2, #0
	bne _02155B38
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3d8]
	cmp r1, r0
	blt _02155B38
_02155B20:
	mov r0, #0
	str r0, [r5, #0xc8]
	ldr r0, [r5, #0x20]
	tst r0, #8
	movne r4, #1
	b _02155BB8
_02155B38:
	ldr r0, [r5, #0x20]
	tst r0, #8
	movne r0, #0x3000
	strne r0, [r5, #0xc8]
	bne _02155BB8
	ldr r0, [r5, #0xc8]
	ldr r1, =0x00000199
	bl ObjSpdDownSet
	str r0, [r5, #0xc8]
	b _02155BB8
_02155B60:
	ldr r0, [r5, #0x3a8]
	cmp r1, r0
	blt _02155BA4
	ldr r0, [r5, #0x20]
	ands r2, r0, #1
	beq _02155B88
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3a4]
	cmp r1, r0
	bge _02155BA0
_02155B88:
	cmp r2, #0
	bne _02155BA4
	ldr r1, [r5, #0x44]
	ldr r0, [r5, #0x3a4]
	cmp r1, r0
	bgt _02155BA4
_02155BA0:
	mov r4, #1
_02155BA4:
	ldr r0, [r5, #0xc8]
	mov r1, #0x400
	mov r2, #0x6000
	bl ObjSpdUpSet
	str r0, [r5, #0xc8]
_02155BB8:
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r5, #0x354]
	tst r0, #0x8000
	beq _02155C10
	ldr r0, [r5, #0x3d8]
	mov r1, #0
	str r0, [r5, #0x44]
	ldr r0, [r5, #0x3dc]
	mov r2, #0xa
	str r0, [r5, #0x48]
	str r1, [r5, #0xc8]
	strh r1, [r5, #0x34]
	mov r0, r5
	str r2, [r5, #0x2c]
	bl GameObject__SetAnimation
	ldr r1, [r5, #0x20]
	ldr r0, =EnemyRobot__State_21559AC
	orr r1, r1, #0x10
	str r1, [r5, #0x20]
	str r0, [r5, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
_02155C10:
	mov r0, #0x3000
	str r0, [r5, #0xc8]
	ldrh r2, [r5, #0x34]
	mov r1, #0x8000
	mov r0, r5
	add r2, r2, #0x8000
	strh r2, [r5, #0x34]
	str r1, [r5, #8]
	ldr r2, [r5, #0x354]
	mov r1, #3
	orr r2, r2, #0x8000
	str r2, [r5, #0x354]
	bl GameObject__SetAnimation
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__OnDetect_2155C5C(EnemyRobot *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	mov r1, #0
	str r1, [r0, #0xc8]
	str r1, [r0, #0x28]
	mov r2, #3
	ldr r1, =EnemyRobot__State_2155C80
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_2155C80(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x28]
	cmp r2, #0
	beq _02155CA8
	cmp r2, #1
	beq _02155D18
	cmp r2, #2
	beq _02155DD0
	ldmia sp!, {r4, pc}
_02155CA8:
	mov r1, #0x3000
	str r1, [r4, #0x9c]
	ldr r1, [r4, #0x2c]
	subs r1, r1, #1
	str r1, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0x28]
	mov r1, #0
	add r2, r2, #1
	str r2, [r4, #0x28]
	str r1, [r4, #0x98]
	sub r1, r1, #0x6000
	str r1, [r4, #0x9c]
	ldr r2, [r4, #0x1c]
	mov r1, #1
	orr r2, r2, #0x80
	str r2, [r4, #0x1c]
	bl GameObject__SetAnimation
	ldr r0, =mapCamera
	mov r1, #0
	ldrh r3, [r0, #0x6e]
	mov r0, r4
	mov r2, r1
	bl CreateEffectWaterSplash
	ldr r0, [r4, #0x354]
	orr r0, r0, #0x8000
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
_02155D18:
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	ldmleia sp!, {r4, pc}
	ldr r0, [r4, #0x34c]
	ldr r1, [r4, #0x48]
	add r0, r0, #0x10000
	cmp r1, r0
	blt _02155D90
	add r0, r2, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x20]
	mov r1, #0x2800
	eor r0, r0, #1
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	rsb r1, r1, #0
	bic r0, r0, #0x80
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	tst r0, #1
	mov r0, #0x800
	rsbeq r0, r0, #0
	str r0, [r4, #0x98]
	str r1, [r4, #0x9c]
	mov r0, r4
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
_02155D90:
	ldr r0, [r4, #0x354]
	tst r0, #0x8000
	ldmeqia sp!, {r4, pc}
	ldr r0, =mapCamera
	ldr r1, [r4, #0x48]
	ldrh r3, [r0, #0x6e]
	cmp r1, r3, lsl #12
	ldmltia sp!, {r4, pc}
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl CreateEffectWaterSplash
	ldr r0, [r4, #0x354]
	bic r0, r0, #0x8000
	str r0, [r4, #0x354]
	ldmia sp!, {r4, pc}
_02155DD0:
	ldr r2, [r4, #0x34c]
	ldr r1, [r4, #0x48]
	cmp r1, r2
	ldmgtia sp!, {r4, pc}
	mov r1, #0
	str r2, [r4, #0x48]
	str r1, [r4, #0x9c]
	str r1, [r4, #0x98]
	ldr r1, [r4, #0x3ac]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__OnDetect_FoundFX(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r4, r0
	str r1, [r4, #0x9c]
	str r1, [r4, #0x98]
	str r1, [r4, #0xc8]
	ldr r3, [r4, #0x20]
	sub r2, r1, #0x40000
	orr r3, r3, #0x10
	str r3, [r4, #0x20]
	bl CreateEffectFound
	mov r1, #0xc
	ldr r0, =EnemyRobot__State_2155E44
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_2155E44(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x2c]
	subs r1, r1, #1
	str r1, [r4, #0x2c]
	ldmneia sp!, {r4, pc}
	ldr r2, [r4, #0x20]
	mov r1, #2
	bic r2, r2, #0x10
	str r2, [r4, #0x20]
	bl GameObject__SetAnimation
	ldr r0, =EnemyRobot__State_2155E80
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyRobot__State_2155E80(EnemyRobot *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x128]
	ldrh r1, [r1, #0xc]
	cmp r1, #2
	beq _02155EA8
	cmp r1, #3
	beq _02155F4C
	b _02155FD0
_02155EA8:
	ldr r1, [r4, #0x20]
	tst r1, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #3
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, #0x78
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0x2c]
	mov r1, #0
	str r4, [r4, #0x2b4]
	ldr r0, [r4, #0x2b0]
	mov r2, r1
	orr r0, r0, #4
	str r0, [r4, #0x2b0]
	mov r3, r1
	add r0, r4, #0x298
	str r1, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0x21000
	rsb r1, r1, #0
	mov r0, r4
	add r2, r1, #0x2000
	mov r3, #0x78
	bl EffectSteamBlasterSteam__Create
	mov r0, #0
	str r0, [sp]
	mov r0, #0x83
	sub r1, r0, #0x84
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02155F4C:
	ldr r1, [r4, #0x2c]
	subs r1, r1, #1
	str r1, [r4, #0x2c]
	beq _02155FAC
	rsb r1, r1, #0x78
	mov r0, #0xc
	mul r2, r1, r0
	mvn r3, #0xf
	cmp r2, #0x48
	movgt r2, #0x48
	sub r0, r3, #0x11
	sub r0, r0, r2
	mov r1, r0, lsl #0x10
	str r3, [sp]
	sub r2, r3, #0x18
	add r0, r4, #0x298
	mov r1, r1, asr #0x10
	sub r3, r3, #0x11
	bl ObjRect__SetBox2D
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02155FAC:
	mov r1, #4
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r4, #0x2b4]
	ldr r0, [r4, #0x138]
	mov r1, #0x20
	bl NNS_SndPlayerStopSeq
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02155FD0:
	ldr r1, [r4, #0x20]
	tst r1, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x3ac]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

void EnemyRobot__OnDefend_Hurtbox(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyRobot *robot = (EnemyRobot *)rect2->parent;
    Player *player    = (Player *)rect1->parent;

    if (robot == NULL || player == NULL)
        return;

    if (player->objWork.objType != STAGE_OBJ_TYPE_PLAYER)
        return;

    if ((player->playerFlag & PLAYER_FLAG_SUPERBOOST) != 0)
    {
        ObjRect__FuncNoHit(rect1, rect2);
    }
    else
    {
        fx32 y                             = robot->gameWork.objWork.position.y;
        robot->gameWork.objWork.position.y = player->objWork.position.y;

        fx32 velX;
        if ((robot->gameWork.objWork.displayFlag & DISPLAY_FLAG_FLIP_X) == 0)
            velX = -FLOAT_TO_FX32(5.0);
        else
            velX = FLOAT_TO_FX32(5.0);

        Player__Action_PopSteam(player, &robot->gameWork, velX, -FLOAT_TO_FX32(1.0), FLOAT_TO_FX32(96.0), 0);

        robot->gameWork.objWork.position.y = y;
    }
}

void EnemyRobot__OnDefend_Detector(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    EnemyRobot *robot = (EnemyRobot *)rect2->parent;
    Player *player    = (Player *)rect1->parent;

    if ((robot->gameWork.objWork.flag & STAGE_TASK_FLAG_2) == 0)
    {
        robot->field_3A4.x = player->objWork.position.x;
        robot->field_3A4.y = player->objWork.position.y;
        robot->collider.flag &= ~OBS_RECT_WORK_FLAG_IS_ACTIVE;
        robot->field_3C4 = _02188B48[robot->type];
        robot->onDetect(robot);
    }
}

void EnemyRobot__OnDefend_TutorialEnemy(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
    SetTutorialEnemyDestroy();
    GameObject__OnDefend_Enemy(rect1, rect2);
}

void EnemyRobot__Func_2156100(EnemyRobot *work)
{
    switch (work->gameWork.mapObject->id)
    {
        case MAPOBJECT_0:
            PlayHandleStageSfx(work->gameWork.objWork.sequencePlayerPtr, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_TANK_ACCEL);
            ProcessSpatialSfx(work->gameWork.objWork.sequencePlayerPtr, &work->gameWork.objWork.position);
            break;

        case MAPOBJECT_3:
            CreateManagedSfx(SND_ZONE_SEQARC_GAME_SE, SND_ZONE_SEQARC_GAME_SE_SEQ_SE_SPANNER,
                             MANAGEDSFX_FLAG_DESTROY_WITH_PARENT | MANAGEDSFX_FLAG_HAS_PARENT | MANAGEDSFX_FLAG_HAS_DELAY | MANAGEDSFX_FLAG_HAS_DURATION, &work->gameWork.objWork,
                             240, 48);
            break;
    }
}