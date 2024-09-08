#include <stage/enemies/pirate.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/audio/spatialAudio.h>
#include <stage/effects/explosion.h>
#include <stage/effects/found.h>

NOT_DECOMPILED const void *_021881DC;
NOT_DECOMPILED const void *_021881F8;
NOT_DECOMPILED const void *_02188208;
NOT_DECOMPILED const void *_02188218;
NOT_DECOMPILED const void *_02188234;
NOT_DECOMPILED const void *_02188238;
NOT_DECOMPILED const void *_02188254;
NOT_DECOMPILED const void *_0218828C;
NOT_DECOMPILED const void *_021882C4;
NOT_DECOMPILED const void *_021882C8;
NOT_DECOMPILED const void *_021882CC;
NOT_DECOMPILED const void *_021882DC;

NOT_DECOMPILED void *aActAcEnePrtBom;
NOT_DECOMPILED void *aActAcEnePrtHog;
NOT_DECOMPILED void *aActAcEneHobarG;
NOT_DECOMPILED void *aActAcEnePrtKni;
NOT_DECOMPILED void *aActAcEnePSkele;
NOT_DECOMPILED void *aActAcEneHobarB;
NOT_DECOMPILED void *_02188D4C;
NOT_DECOMPILED void *_02188D50;
NOT_DECOMPILED void *_02188D54;
NOT_DECOMPILED void *_02188D58;
NOT_DECOMPILED void *_02188D5C;
NOT_DECOMPILED void *_02188D60;
NOT_DECOMPILED void *_02188D64;
NOT_DECOMPILED void *aActAcEnePrtBaz;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC EnemyPirate *EnemyPirate__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	movs r8, r0
	mov r7, r1
	mov r6, r2
	beq _02159114
	ldrb r0, [r8]
	cmp r0, #0xff
	ldreqb r0, [r8, #1]
	cmpeq r0, #0xff
	beq _02159138
_02159114:
	ldr r0, =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _02159138
	ldrh r0, [r8, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02159138:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x3f4
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
	mov r2, #0x3f4
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldrh r0, [r8, #2]
	sub r0, r0, #0xd
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _02159550
_021591C0: // jump table
	b _021591DC // case 0
	b _02159258 // case 1
	b _021592D4 // case 2
	b _02159360 // case 3
	b _021593D0 // case 4
	b _02159454 // case 5
	b _021594D4 // case 6
_021591DC:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #0
	orr r1, r1, #0x80
	orr r1, r1, #0xc000
	str r1, [r4, #0x1c]
	bl EnemyPirate__Func_215A000
	ldr r1, =EnemyPirate__OnInit_215A36C
	add r0, r4, #0x300
	str r1, [r4, #0x3ac]
	mov r2, r5
	strh r2, [r0, #0xd0]
	mov r1, #1
	strh r1, [r0, #0xd2]
	mov r1, #2
	strh r1, [r0, #0xd4]
	mov r1, #0x78
	strh r1, [r0, #0xd6]
	strh r2, [r0, #0xd8]
	mov r2, #0xc00
	str r2, [r4, #0x3e0]
	ldr r1, =EnemyPirate__OnDetect_215A714
	mov r2, #3
	str r1, [r4, #0x3b0]
	ldr r1, =EnemyPirate__State_215A7D0
	strh r2, [r0, #0xe4]
	str r1, [r4, #0x3ec]
	b _02159550
_02159258:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #1
	orr r1, r1, #0x80
	orr r1, r1, #0x8000
	str r1, [r4, #0x1c]
	bl EnemyPirate__Func_215A000
	ldr r1, =EnemyPirate__OnInit_215A36C
	add r0, r4, #0x300
	str r1, [r4, #0x3ac]
	mov r2, #0
	strh r2, [r0, #0xd0]
	mov r1, #3
	strh r1, [r0, #0xd2]
	mov r1, #2
	strh r1, [r0, #0xd4]
	mov r1, #0x78
	strh r1, [r0, #0xd6]
	strh r2, [r0, #0xd8]
	mov r2, #0xf00
	str r2, [r4, #0x3e0]
	ldr r1, =EnemyPirate__OnDetect_215A714
	mov r2, r5
	str r1, [r4, #0x3b0]
	ldr r1, =EnemyPirate__State_215A828
	strh r2, [r0, #0xe4]
	str r1, [r4, #0x3ec]
	b _02159550
_021592D4:
	ldr r0, [r4, #0x20]
	mov r5, #2
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x80
	orr r0, r0, #0x8000
	str r0, [r4, #0x1c]
	strb r5, [r4, #0x345]
	ldr r1, [r4, #0x340]
	mov r0, r4
	ldrb r1, [r1, #0xb]
	rsb r1, r1, #2
	strb r1, [r4, #0x345]
	bl EnemyPirate__Func_215A000
	ldr r0, =EnemyPirate__OnInit_215A618
	mov r2, #0
	str r0, [r4, #0x3ac]
	add r0, r4, #0x300
	strh r2, [r0, #0xd0]
	mov r1, #1
	strh r1, [r0, #0xd2]
	rsb r1, r1, #0x10000
	strh r1, [r0, #0xd4]
	mov r2, #0x800
	str r2, [r4, #0x3e0]
	ldr r1, =EnemyPirate__OnDetect_215A714
	mov r2, #3
	str r1, [r4, #0x3b0]
	mov r1, #0xf
	strh r1, [r0, #0xe6]
	ldr r1, =EnemyPirate__State_215A8CC
	strh r2, [r0, #0xe4]
	str r1, [r4, #0x3ec]
	b _02159550
_02159360:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #3
	orr r1, r1, #0x80
	orr r1, r1, #0x8000
	str r1, [r4, #0x1c]
	bl EnemyPirate__Func_215A000
	ldr r1, =EnemyPirate__OnInit_215A36C
	add r0, r4, #0x300
	str r1, [r4, #0x3ac]
	mov r1, #0
	strh r1, [r0, #0xd0]
	mov r2, #2
	ldr r1, =0x0000FFFF
	strh r2, [r0, #0xd2]
	strh r1, [r0, #0xd4]
	mov r2, #0xc00
	ldr r1, =EnemyPirate__OnDetect_215A714
	str r2, [r4, #0x3e0]
	str r1, [r4, #0x3b0]
	mov r2, #1
	ldr r1, =EnemyPirate__State_215A828
	strh r2, [r0, #0xe4]
	str r1, [r4, #0x3ec]
	b _02159550
_021593D0:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #4
	orr r1, r1, #0x80
	orr r1, r1, #0x8000
	str r1, [r4, #0x1c]
	bl EnemyPirate__Func_215A000
	ldr r0, =EnemyPirate__OnInit_215A674
	mov r1, #1
	str r0, [r4, #0x3ac]
	add r0, r4, #0x300
	mov r2, #0
	strh r2, [r0, #0xd0]
	strh r1, [r0, #0xd2]
	rsb r1, r1, #0x10000
	strh r1, [r0, #0xd4]
	mov r1, #0x78
	strh r1, [r0, #0xd6]
	strh r2, [r0, #0xd8]
	mov r1, #0x4000
	strh r1, [r0, #0xda]
	mov r2, #0xc00
	ldr r1, =EnemyPirate__OnDetect_215A714
	str r2, [r4, #0x3e0]
	str r1, [r4, #0x3b0]
	mov r2, #2
	ldr r1, =EnemyPirate__State_215A828
	strh r2, [r0, #0xe4]
	str r1, [r4, #0x3ec]
	b _02159550
_02159454:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #5
	orr r1, r1, #0xf00
	str r1, [r4, #0x1c]
	bl EnemyPirate__Func_215A000
	ldr r1, =EnemyPirate__OnInit_215A674
	add r0, r4, #0x300
	str r1, [r4, #0x3ac]
	mov r2, #0
	strh r2, [r0, #0xd0]
	mov r1, #1
	strh r1, [r0, #0xd2]
	mov r1, #2
	strh r1, [r0, #0xd4]
	mov r1, #0x78
	strh r1, [r0, #0xd6]
	strh r2, [r0, #0xd8]
	mov r1, #0x4000
	strh r1, [r0, #0xda]
	mov r2, #0xc00
	ldr r1, =EnemyPirate__OnDetect_215A714
	str r2, [r4, #0x3e0]
	str r1, [r4, #0x3b0]
	mov r2, #3
	ldr r1, =EnemyPirate__State_215A828
	strh r2, [r0, #0xe4]
	str r1, [r4, #0x3ec]
	b _02159550
_021594D4:
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r5, #6
	orr r1, r1, #0xf00
	str r1, [r4, #0x1c]
	bl EnemyPirate__Func_215A000
	ldr r1, =EnemyPirate__OnInit_215A674
	add r0, r4, #0x300
	str r1, [r4, #0x3ac]
	mov r2, #0
	strh r2, [r0, #0xd0]
	mov r1, #1
	strh r1, [r0, #0xd2]
	mov r1, #2
	strh r1, [r0, #0xd4]
	mov r1, #0x78
	strh r1, [r0, #0xd6]
	strh r2, [r0, #0xd8]
	mov r1, #0x4000
	strh r1, [r0, #0xda]
	mov r2, #0xc00
	ldr r1, =EnemyPirate__OnDetect_215A714
	str r2, [r4, #0x3e0]
	str r1, [r4, #0x3b0]
	mov r2, #3
	ldr r1, =EnemyPirate__State_215A828
	strh r2, [r0, #0xe4]
	str r1, [r4, #0x3ec]
_02159550:
	ldr r0, =_02188218
	add r1, r4, #0x300
	ldr r0, [r0, r5, lsl #2]
	strh r5, [r1, #0xc6]
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	ldr r2, =0x0000FFFF
	ldr r3, [r1]
	ldr r1, =_02188D4C
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
	ldr r2, =_021881DC
	ldrsh r2, [r2, r3]
	bl ObjActionAllocSpritePalette
	ldr r0, [r4, #0x1c]
	tst r0, #0x100
	bne _021595E8
	mvn r6, #1
	mov r0, r4
	sub r1, r6, #6
	sub r2, r6, #8
	mov r3, #8
	str r6, [sp]
	bl StageTask__SetHitbox
_021595E8:
	ldr r3, =0x0218825A
	mov r7, r5, lsl #3
	ldr r1, =_02188254
	ldr r2, =0x02188256
	ldrsh r6, [r3, r7]
	ldr r0, =0x02188258
	ldrsh r1, [r1, r7]
	ldrsh r3, [r0, r7]
	ldrsh r2, [r2, r7]
	add r0, r4, #0x364
	str r6, [sp]
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
	ldr r0, [r4, #0x37c]
	cmp r5, #6
	orr r0, r0, #0x4c0
	str r0, [r4, #0x37c]
	ldrne r0, =EnemyPirate__OnDefend_215B83C
	strne r0, [r4, #0x388]
	bne _02159674
	ldr r0, =EnemyPirate__OnDefend_215B8C4
	str r0, [r4, #0x388]
	ldr r0, [r4, #0x37c]
	bic r0, r0, #0x400
	str r0, [r4, #0x37c]
_02159674:
	str r4, [r4, #0x380]
	ldrh r0, [r8, #4]
	tst r0, #1
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
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

NONMATCH_FUNC EnemyBazookaPirateShot *EnemyBazookaPirateShot__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
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
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x41
	bl ObjRect__SetDefenceStat
	ldr r0, =EnemyBazookaPirateShot__OnHit
	mov r3, #7
	str r0, [r4, #0x278]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	sub r1, r3, #0xe
	orr r2, r2, #0x50
	str r2, [r4, #0x1c]
	str r3, [sp]
	mov r2, r1
	bl StageTask__SetHitbox
	mov r0, #0x10
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =_02188D4C
	ldr r2, [r2, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x4c
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #4
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyBazookaPirateShot__State_215AB70
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC EnemyBallChainPirateBall *EnemyBallChainPirateBall__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x6e0
	ldr r0, =StageTask_Main
	ldr r1, =EnemyBallChainPirateBall__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x6e0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x41
	bl ObjRect__SetDefenceStat
	ldr r0, [r4, #0x18]
	mov r3, #0xd
	orr r0, r0, #0x10
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	sub r1, r3, #0x1a
	orr r2, r2, #0x50
	str r2, [r4, #0x1c]
	str r3, [sp]
	mov r2, r1
	bl StageTask__SetHitbox
	mov r0, #0x11
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =_02188D4C
	ldr r2, [r2, #8]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x4d
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #4
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyBallChainPirateBall__Draw_215A224
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xfc]
	ldr r1, =EnemyBallChainPirateBall__State_215A198
	ldr r0, =EnemyBallChainPirateBall__Unknown_215AC34
	str r1, [r4, #0xf4]
	str r0, [r4, #0x6c8]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC EnemyBombPirateBomb *EnemyBombPirateBomb__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x368
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
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x368
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x41
	bl ObjRect__SetDefenceStat
	ldr r0, =EnemyBombPirateBomb__OnHit
	mov r3, #6
	str r0, [r4, #0x278]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	sub r1, r3, #0xc
	orr r2, r2, #0x50
	str r2, [r4, #0x1c]
	str r3, [sp]
	mov r2, r1
	bl StageTask__SetHitbox
	mov r0, #0x12
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =_02188D4C
	ldr r2, [r2, #0xc]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x4e
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #3
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyBombPirateBomb__State_215B218
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC EnemySkeletonPirateBone *EnemySkeletonPirateBone__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
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
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x41
	bl ObjRect__SetDefenceStat
	ldr r0, =EnemySkeletonPirateBone__OnHit
	mov r3, #3
	str r0, [r4, #0x278]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	sub r1, r3, #6
	orr r2, r2, #0x50
	str r2, [r4, #0x1c]
	str r3, [sp]
	mov r2, r1
	bl StageTask__SetHitbox
	mov r0, #0x13
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =_02188D4C
	ldr r2, [r2, #0x10]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x4f
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #3
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemySkeletonPirateBone__State_215B434
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC EnemyHoverBomberPirateBomb *EnemyHoverBomberPirateBomb__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
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
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x41
	bl ObjRect__SetDefenceStat
	ldr r0, =EnemyHoverBomberPirateBomb__OnHit
	mov r3, #8
	str r0, [r4, #0x278]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	sub r1, r3, #0x10
	orr r2, r2, #0x50
	str r2, [r4, #0x1c]
	str r3, [sp]
	mov r2, r1
	bl StageTask__SetHitbox
	mov r0, #0x14
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =_02188D4C
	ldr r2, [r2, #0x14]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x50
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #4
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyHoverBomberPirateBomb__State_215B4F4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC EnemyHoverGunnerPirateShot *EnemyHoverGunnerPirateShot__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1500
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
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
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x41
	bl ObjRect__SetDefenceStat
	ldr r0, =EnemyBazookaPirateShot__OnHit
	mov r3, #4
	str r0, [r4, #0x278]
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r2, [r4, #0x1c]
	sub r1, r3, #8
	orr r2, r2, #0x50
	str r2, [r4, #0x1c]
	str r3, [sp]
	mov r2, r1
	bl StageTask__SetHitbox
	mov r0, #0x15
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	add r1, r4, #0x168
	ldr r2, =_02188D4C
	ldr r2, [r2, #0x18]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x52
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #4
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyHoverGunnerPirateShot__State_215B5C0
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}


NONMATCH_FUNC void EnemyPirate__Func_215A000(EnemyPirate *work)
{
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

NONMATCH_FUNC void EnemyPirate__Func_215A028(EnemyPirate *work)
{
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

NONMATCH_FUNC void EnemyBallChainPirateBall__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x364
	bl ObjObjectActionReleaseGfxRefs
	ldr r1, [r4, #0x48c]
	ldr r0, [r1, #0xa4]
	cmp r0, #0
	beq _0215A088
	bl ObjDataRelease
	b _0215A0A4
_0215A088:
	ldr r0, [r1, #0x14]
	cmp r0, #0
	beq _0215A0A4
	ldr r1, [r4, #0x37c]
	tst r1, #0x100
	bne _0215A0A4
	bl _FreeHEAP_USER
_0215A0A4:
	ldr r0, [r4, #0x37c]
	tst r0, #0x9c000000
	beq _0215A0C4
	tst r0, #0x10000000
	ldrne r0, [r4, #0x48c]
	cmpne r0, #0
	beq _0215A0C4
	bl _FreeHEAP_USER
_0215A0C4:
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__Func_215A0D0(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r3, r0
	add r4, r3, #0x364
	ldr r0, [r4, #0x20]
	mov r2, #0
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldr r1, [r4, #0x1c]
	mov r0, r4
	orr r1, r1, #0x1f00
	str r1, [r4, #0x1c]
	ldr r1, [r3, #0x340]
	mov r3, r2
	bl GameObject__InitFromObject
	mov r0, #0x11
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r0, [r1]
	ldr r1, =0x0000FFFF
	str r0, [sp]
	ldr r0, =_02188D4C
	str r1, [sp, #4]
	ldr r2, [r0, #8]
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
	mov r2, #0x4d
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #5
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x20]
	mov r0, r4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBallChainPirateBall__State_215A198(EnemyBallChainPirateBall *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x20]
	ldr ip, [r0, #0x11c]
	bic r3, r1, #0x23
	str r3, [r0, #0x20]
	ldr r1, [r0, #0x11c]
	ldr r2, [r1, #0x20]
	add r1, ip, #0x300
	and r2, r2, #0x23
	orr r2, r3, r2
	str r2, [r0, #0x20]
	ldr r2, [r0, #0x384]
	bic r3, r2, #0x23
	str r3, [r0, #0x384]
	ldr r2, [r0, #0x11c]
	ldr r2, [r2, #0x20]
	and r2, r2, #0x23
	orr r2, r3, r2
	str r2, [r0, #0x384]
	ldrsh r1, [r1, #0x50]
	cmp r1, #0
	add r1, r0, #0x200
	moveq r2, #0x3f
	streqh r2, [r1, #0x46]
	moveq r2, #0x40
	beq _0215A20C
	mov r2, #0xff
	strh r2, [r1, #0x46]
	mov r2, #0
_0215A20C:
	strh r2, [r1, #0x84]
	ldr r1, [r0, #0x6c8]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	blx r1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBallChainPirateBall__Draw_215A224(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	bl GetCurrentTaskWork_
	mov r5, r0
	bl StageTask__Draw
	ldr r0, [r5, #0x20]
	ldr r3, [r5, #0x11c]
	tst r0, #1
	ldreq r0, [r5, #0x6d4]
	ldreq r1, [r3, #0x44]
	addeq r7, r1, r0
	beq _0215A260
	ldr r0, [r5, #0x6d4]
	ldr r1, [r3, #0x44]
	sub r7, r1, r0
_0215A260:
	ldr r2, [r5, #0x44]
	ldr r3, [r3, #0x48]
	ldr r0, [r5, #0x6d8]
	ldr r1, [r5, #0x48]
	add r8, r3, r0
	str r7, [r5, #0x3a8]
	str r8, [r5, #0x3ac]
	ldr r0, [r5, #0x1c]
	sub r1, r8, r1
	tst r0, #0x80
	sub r4, r7, r2
	mov r11, r1, asr #3
	mov r6, #0
	bne _0215A2D4
	mov r9, r6
	mov r10, r6
_0215A2A0:
	sub r0, r7, r9
	str r0, [r5, #0x3a8]
	sub r1, r8, r10
	add r0, r5, #0x364
	str r1, [r5, #0x3ac]
	bl StageTask__Draw
	add r6, r6, #1
	cmp r6, #8
	add r9, r9, r4, asr #3
	add r10, r10, r11
	blt _0215A2A0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215A2D4:
	mov r0, r11, lsl #3
	str r0, [sp]
	mov r0, r0, asr #0x1f
	mov r9, r6
	mov r10, r6
	str r0, [sp, #4]
_0215A2EC:
	mov r0, r10, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r1, r0, lsl #2
	ldr r0, =FX_SinCosTable_
	ldr ip, [sp]
	ldrsh r2, [r0, r1]
	sub r0, r7, r9
	str r0, [r5, #0x3a8]
	mov r1, r2, asr #0x1f
	umull r11, r3, ip, r2
	mla r3, ip, r1, r3
	ldr r1, [sp, #4]
	add r0, r5, #0x364
	mla r3, r1, r2, r3
	adds r2, r11, #0x800
	adc r1, r3, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r1, r8, r2
	str r1, [r5, #0x3ac]
	bl StageTask__Draw
	add r6, r6, #1
	add r9, r9, r4, asr #3
	add r10, r10, #0x800
	cmp r6, #8
	blt _0215A2EC
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__OnInit_215A36C(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0xd0]
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyPirate__State_215A3A4
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, #0
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__State_215A3A4(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r2, [r6, #0x354]
	add r4, r6, #0x3d0
	tst r2, #1
	mov r5, #0
	beq _0215A400
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
	b _0215A45C
_0215A400:
	add r0, r6, #0x300
	ldrh r0, [r0, #0xc6]
	cmp r0, #3
	bne _0215A45C
	ldr r0, [r6, #0x128]
	ldrh r0, [r0, #0xe]
	cmp r0, #1
	bne _0215A458
	ldr r0, [r6, #0x3cc]
	cmp r0, #0
	bne _0215A45C
	ldr r0, =0x00000116
	str r5, [sp]
	str r0, [sp, #4]
	sub r1, r5, #1
	ldr r0, [r6, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #1
	str r0, [r6, #0x3cc]
	b _0215A45C
_0215A458:
	str r5, [r6, #0x3cc]
_0215A45C:
	mov r0, r6
	bl EnemyPirate__Func_215A028
	mov r0, r6
	add r1, r6, #0x364
	bl StageTask__HandleCollider
	ldrh r1, [r4, #4]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	beq _0215A55C
	ldr r0, [r6, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, r1
	beq _0215A4E8
	ldr r0, [r6, #0x2c]
	add r1, r0, #1
	str r1, [r6, #0x2c]
	ldrh r0, [r4, #6]
	cmp r1, r0
	blt _0215A55C
	mov r0, #0
	str r0, [r6, #0x98]
	ldrh r1, [r4, #4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldrh r0, [r4, #8]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0x20]
	add sp, sp, #8
	orr r0, r0, #4
	str r0, [r6, #0x20]
	ldrh r0, [r4, #8]
	str r0, [r6, #0x2c]
	ldmia sp!, {r4, r5, r6, pc}
_0215A4E8:
	ldr r0, [r6, #0x20]
	tst r0, #4
	beq _0215A530
	ldr r0, [r6, #0x2c]
	sub r0, r0, #1
	cmp r0, #0
	addgt sp, sp, #8
	str r0, [r6, #0x2c]
	ldmgtia sp!, {r4, r5, r6, pc}
	mov r0, #0
	str r0, [r6, #0x2c]
	ldrh r1, [r4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
	b _0215A55C
_0215A530:
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, #0
	str r0, [r6, #0x2c]
	ldrh r1, [r4]
	mov r0, r6
	bl GameObject__SetAnimation
	ldr r0, [r6, #0x20]
	orr r0, r0, #4
	str r0, [r6, #0x20]
_0215A55C:
	ldr r0, [r6, #0x20]
	tst r0, #1
	ldr r0, [r4, #0x10]
	rsbeq r0, r0, #0
	str r0, [r6, #0x98]
	ldr r0, [r6, #0x1c]
	bic r0, r0, #0x400
	str r0, [r6, #0x1c]
	tst r0, #0xc
	beq _0215A594
	ldr r0, [r6, #0x1c]
	mov r5, #1
	orr r0, r0, #0x400
	str r0, [r6, #0x1c]
_0215A594:
	ldr r0, [r6, #0x3b4]
	ldr r1, [r6, #0x44]
	cmp r1, r0
	strlt r0, [r6, #0x44]
	movlt r5, #1
	blt _0215A5BC
	ldr r0, [r6, #0x3bc]
	cmp r1, r0
	strgt r0, [r6, #0x44]
	movgt r5, #1
_0215A5BC:
	cmp r5, #0
	beq _0215A5FC
	ldrh r1, [r4, #2]
	ldr r0, =0x0000FFFF
	cmp r1, r0
	ldreq r0, [r6, #0x20]
	eoreq r0, r0, #1
	streq r0, [r6, #0x20]
	beq _0215A5FC
	mov r0, r6
	bl GameObject__SetAnimation
	mov r0, #0
	str r0, [r6, #0x98]
	ldr r0, [r6, #0x354]
	orr r0, r0, #1
	str r0, [r6, #0x354]
_0215A5FC:
	ldr r0, [r6, #0x138]
	add r1, r6, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__OnInit_215A618(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl EnemyPirate__OnInit_215A36C
	ldr r1, [r5, #0x3f0]
	cmp r1, #0
	ldrne r0, =EnemyBallChainPirateBall__Unknown_215AC34
	strne r0, [r1, #0x6c8]
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl EnemyPirate__Func_215AA2C
	mov r4, r0
	mov r1, r5
	mov r2, #0x400
	bl StageTask__SetParent
	mov r1, #0
	str r4, [r5, #0x3f0]
	str r1, [r4, #0x68]
	sub r1, r1, #0x4d000
	mov r0, r4
	str r1, [r4, #0x6c]
	bl EnemyPirate__Func_215A0D0
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__OnInit_215A674(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x300
	ldrh r1, [r1, #0xd0]
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyPirate__State_215A6AC
	orr r1, r1, #4
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	mov r0, #0
	str r0, [r4, #0x2c]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__State_215A6AC(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl EnemyPirate__State_215A3A4
	add r1, r4, #0x300
	ldrh r2, [r1, #0xdc]
	ldr r0, =FX_SinCosTable_
	ldrh ip, [r1, #0xda]
	mov r2, r2, asr #4
	mov r2, r2, lsl #2
	ldrsh r2, [r0, r2]
	mov r3, #0
	umull r5, lr, ip, r2
	mov r0, r2, asr #0x1f
	mla lr, ip, r0, lr
	adds r5, r5, #0x800
	mla lr, r3, r2, lr
	adc r0, lr, #0
	mov r2, r5, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [r4, #0x54]
	ldrh r0, [r1, #0xdc]
	add r0, r0, #0x8e
	add r0, r0, #0x300
	strh r0, [r1, #0xdc]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__OnDetect_215A714(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x98]
	add r5, r4, #0x3e4
	ldrsh r1, [r5, #2]
	cmp r1, #0
	beq _0215A750
	str r1, [r4, #0x2c]
	ldr r1, [r4, #0x20]
	ldr r0, =EnemyPirate__State_215A768
	orr r1, r1, #0x10
	str r1, [r4, #0x20]
	str r0, [r4, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}
_0215A750:
	ldrh r1, [r5]
	bl GameObject__SetAnimation
	ldr r0, [r5, #8]
	str r0, [r4, #0xf4]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__State_215A768(EnemyPirate *work)
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
	ldrh r1, [r1, #0xe4]
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x3ec]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__State_215A7A4(EnemyPirate *work)
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

NONMATCH_FUNC void EnemyPirate__State_215A7D0(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x20]
	add r2, r0, #0x3e4
	tst r1, #8
	mov r1, #0
	movne r1, #1
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldrsh r1, [r2, #4]
	cmp r1, #0
	beq _0215A818
	mov r1, #0
	str r1, [r0, #0x98]
	ldrsh r2, [r2, #4]
	ldr r1, =EnemyPirate__State_215A7A4
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	ldmia sp!, {r3, pc}
_0215A818:
	ldr r1, [r0, #0x3ac]
	blx r1
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__State_215A828(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r1, r6, #0x300
	ldrh r2, [r1, #0xc6]
	ldr r3, [r6, #0x128]
	ldr r1, =0x021881EA
	mov r2, r2, lsl #1
	ldrh r3, [r3, #0xe]
	ldrh r1, [r1, r2]
	add r4, r6, #0x3e4
	mov r5, #0
	cmp r3, r1
	ldreq r1, [r6, #0x3c8]
	cmpeq r1, #0
	bne _0215A870
	bl EnemyPirate__Func_215AA2C
	mov r0, #1
	str r0, [r6, #0x3c8]
_0215A870:
	ldr r0, [r6, #0x20]
	tst r0, #8
	movne r0, #0
	movne r5, #1
	strne r0, [r6, #0x3c8]
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrsh r0, [r4, #4]
	cmp r0, #0
	beq _0215A8B4
	mov r0, #0
	str r0, [r6, #0x98]
	ldrsh r1, [r4, #4]
	ldr r0, =EnemyPirate__State_215A7A4
	str r1, [r6, #0x2c]
	str r0, [r6, #0xf4]
	ldmia sp!, {r4, r5, r6, pc}
_0215A8B4:
	ldr r1, [r6, #0x3ac]
	mov r0, r6
	blx r1
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__State_215A8CC(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #0x128]
	add r1, r0, #0x3e4
	ldrh r3, [r4, #0xc]
	mov r2, #0
	cmp r3, #3
	bne _0215A96C
	ldrh r3, [r4, #0xe]
	cmp r3, #7
	addls pc, pc, r3, lsl #2
	b _0215A940
_0215A8F8: // jump table
	b _0215A940 // case 0
	b _0215A918 // case 1
	b _0215A940 // case 2
	b _0215A940 // case 3
	b _0215A920 // case 4
	b _0215A928 // case 5
	b _0215A930 // case 6
	b _0215A938 // case 7
_0215A918:
	mov ip, r2
	b _0215A944
_0215A920:
	mov ip, #1
	b _0215A944
_0215A928:
	mov ip, #2
	b _0215A944
_0215A930:
	mov ip, #3
	b _0215A944
_0215A938:
	mov ip, r2
	b _0215A944
_0215A940:
	mov ip, #4
_0215A944:
	cmp ip, #4
	beq _0215A96C
	ldr r4, =_02188234
	ldr r3, =_02188238
	ldr r4, [r4, ip, lsl #3]
	ldr lr, [r1, #0xc]
	ldr ip, [r3, ip, lsl #3]
	str r4, [lr, #0x6d4]
	ldr r3, [r1, #0xc]
	str ip, [r3, #0x6d8]
_0215A96C:
	add r3, r0, #0x300
	ldrh ip, [r3, #0xc6]
	ldr lr, [r0, #0x128]
	ldr r3, =0x021881EA
	mov ip, ip, lsl #1
	ldrh lr, [lr, #0xe]
	ldrh r3, [r3, ip]
	cmp lr, r3
	ldreq r3, [r0, #0x3c8]
	cmpeq r3, #0
	bne _0215A9AC
	ldr ip, [r1, #0xc]
	ldr lr, =EnemyBallChainPirateBall__Unknown_215AEE0
	mov r3, #1
	str lr, [ip, #0x6c8]
	str r3, [r0, #0x3c8]
_0215A9AC:
	ldr r3, [r0, #0x128]
	ldrh r3, [r3, #0xe]
	cmp r3, #6
	ldreq r3, [r1, #0xc]
	ldreq ip, =EnemyBallChainPirateBall__Unknown_215B18C
	streq ip, [r3, #0x6c8]
	ldr r3, [r0, #0x20]
	tst r3, #8
	movne r2, #0
	strne r2, [r0, #0x3c8]
	movne r2, #1
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
	ldrsh r2, [r1, #4]
	cmp r2, #0
	beq _0215AA08
	mov r2, #0
	str r2, [r0, #0x98]
	ldrsh r2, [r1, #4]
	ldr r1, =EnemyPirate__State_215A7A4
	str r2, [r0, #0x2c]
	str r1, [r0, #0xf4]
	ldmia sp!, {r4, pc}
_0215AA08:
	ldr r1, [r0, #0x3ac]
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__Func_215AA2C(EnemyPirate *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r7, r0
	ldr r1, [r7, #0x20]
	tst r1, #1
	add r1, r7, #0x300
	ldrh r1, [r1, #0xc6]
	beq _0215AA60
	ldr r2, =_021882C4
	ldr r3, [r7, #0x44]
	ldr r2, [r2, r1, lsl #3]
	sub r6, r3, r2
	b _0215AA70
_0215AA60:
	ldr r2, =_021882C4
	ldr r3, [r7, #0x44]
	ldr r2, [r2, r1, lsl #3]
	add r6, r3, r2
_0215AA70:
	ldr r2, =_021882C8
	ldr r5, [r7, #0x48]
	ldr r4, [r2, r1, lsl #3]
	cmp r1, #6
	addls pc, pc, r1, lsl #2
	b _0215AB00
_0215AA88: // jump table
	b _0215AB00 // case 0
	b _0215AAA4 // case 1
	b _0215AADC // case 2
	b _0215AAE4 // case 3
	b _0215AAEC // case 4
	b _0215AAF4 // case 5
	b _0215AAFC // case 6
_0215AAA4:
	mov r1, #0
	str r1, [sp]
	mov r0, #0x114
	sub r1, r1, #1
	str r0, [sp, #4]
	ldr r0, [r7, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r7, #0x138]
	add r1, r7, #0x44
	bl ProcessSpatialSfx
	ldr r0, =0x00000156
	b _0215AB00
_0215AADC:
	ldr r0, =0x00000157
	b _0215AB00
_0215AAE4:
	mov r0, #0x158
	b _0215AB00
_0215AAEC:
	ldr r0, =0x00000159
	b _0215AB00
_0215AAF4:
	ldr r0, =0x0000015A
	b _0215AB00
_0215AAFC:
	ldr r0, =0x0000015B
_0215AB00:
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	mov r1, r6
	add r2, r5, r4
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	mov r1, #0
	str r1, [r0, #0x9c]
	str r1, [r0, #0x98]
	str r1, [r0, #0xc8]
	ldr r1, [r7, #0x20]
	tst r1, #1
	ldr r1, [r0, #0x20]
	orrne r1, r1, #1
	biceq r1, r1, #1
	str r1, [r0, #0x20]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBazookaPirateShot__State_215AB70(EnemyBazookaPirateShot *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	mov r1, #0x3000
	str r1, [r0, #0xc8]
	ldr r1, [r0, #0x20]
	tst r1, #1
	movne r1, #0
	moveq r1, #0x8000
	strh r1, [r0, #0x34]
	ldr r1, =EnemyBazookaPirateShot__State_215AB9C
	str r1, [r0, #0xf4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBazookaPirateShot__State_215AB9C(EnemyBazookaPirateShot *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0xf
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r2, [r4, #0x18]
	mov r1, #0
	orr r2, r2, #4
	str r2, [r4, #0x18]
	mvn r2, #0x13
	str r2, [sp]
	mov r2, #0xe
	str r2, [sp, #4]
	mov r2, #0xb
	str r2, [sp, #8]
	mov r3, #7
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #1
	sub r3, r1, #0x11
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBallChainPirateBall__Unknown_215AC34(EnemyBallChainPirateBall *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r3, =EnemyBallChainPirateBall__Unknown_215ACBC
	mov r4, r0
	str r3, [r4, #0x6c8]
	ldr r1, [r4, #0x1c]
	mov r2, #0
	bic r1, r1, #0x80
	str r1, [r4, #0x1c]
	str r2, [r4, #0xa0]
	str r2, [r4, #0x9c]
	str r2, [r4, #0x98]
	add r1, r4, #0x600
	strh r2, [r1, #0xd0]
	ldr r1, [r4, #0x11c]
	ldr r2, [r4, #0x48]
	ldr r1, [r1, #0x48]
	sub r1, r1, #0x4d000
	cmp r2, r1
	ldrgt r0, =EnemyBallChainPirateBall__Unknown_215AE0C
	strgt r0, [r4, #0x6c8]
	bgt _0215ACA0
	str r3, [r4, #0x6c8]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x400
	str r1, [r4, #0x18]
	ldr r1, [r4, #0x6c8]
	blx r1
_0215ACA0:
	mov r0, #0xa000
	str r0, [r4, #0x6d4]
	sub r0, r0, #0x47000
	str r0, [r4, #0x6d8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBallChainPirateBall__Unknown_215ACBC(EnemyBallChainPirateBall *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	add r1, r5, #0x600
	ldrh r0, [r1, #0xd0]
	ldr r4, [r5, #0x11c]
	ldr r2, =0x0000071C
	add r0, r0, #0x31c
	add r0, r0, #0x400
	strh r0, [r1, #0xd0]
	ldrh r0, [r1, #0xd0]
	cmp r0, r2
	bls _0215AD2C
	ldr r0, [r5, #0x6dc]
	cmp r0, #0
	bne _0215AD34
	mov r1, #0
	str r1, [sp]
	mov r0, #0x118
	sub r1, r1, #1
	str r0, [sp, #4]
	ldr r0, [r5, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #1
	str r0, [r5, #0x6dc]
	b _0215AD34
_0215AD2C:
	mov r0, #0
	str r0, [r5, #0x6dc]
_0215AD34:
	ldr r0, [r5, #0x138]
	add r1, r5, #0x44
	bl ProcessSpatialSfx
	ldr r0, [r5, #0x20]
	mov r1, #0
	tst r0, #1
	add r0, r5, #0x600
	ldrh r2, [r0, #0xd0]
	beq _0215AD94
	mov r2, r2, asr #4
	ldr r0, =FX_SinCosTable_
	mov r2, r2, lsl #2
	ldrsh r2, [r0, r2]
	mov r0, #0x3c000
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r5, #0x68]
	b _0215ADD0
_0215AD94:
	mov r2, r2, asr #4
	ldr r0, =FX_SinCosTable_
	mov r2, r2, lsl #2
	ldrsh r2, [r0, r2]
	mov r0, #0x3c000
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	rsb r0, r1, #0
	str r0, [r5, #0x68]
_0215ADD0:
	ldr r0, [r4, #0x354]
	tst r0, #1
	beq _0215ADF0
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldrne r0, [r5, #0x68]
	rsbne r0, r0, #0
	strne r0, [r5, #0x68]
_0215ADF0:
	mov r0, #0x4d000
	rsb r0, r0, #0
	str r0, [r5, #0x6c]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBallChainPirateBall__Unknown_215AE0C(EnemyBallChainPirateBall *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r0, #0x11c]
	ldr r1, [r0, #0x20]
	ldr r2, [r4, #0x44]
	tst r1, #1
	subne r5, r2, #0x3c000
	addeq r5, r2, #0x3c000
	ldr r3, [r0, #0x44]
	mov r1, #0x7000
	umull lr, ip, r3, r1
	mov r2, #0
	mla ip, r3, r2, ip
	mov r3, r3, asr #0x1f
	ldr r4, [r4, #0x48]
	mla ip, r3, r1, ip
	adds lr, lr, #0x800
	adc r3, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	add r3, r5, ip
	mov r3, r3, asr #3
	str r3, [r0, #0x44]
	ldr r3, [r0, #0x48]
	sub r4, r4, #0x4d000
	umull lr, ip, r3, r1
	mla ip, r3, r2, ip
	mov r2, r3, asr #0x1f
	mla ip, r2, r1, ip
	adds lr, lr, #0x800
	adc r1, ip, #0
	mov r2, lr, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r4, r2
	mov r1, r1, asr #3
	str r1, [r0, #0x48]
	subs r1, r1, r4
	rsbmi r1, r1, #0
	cmp r1, #0x5000
	ldmgtia sp!, {r3, r4, r5, pc}
	ldr r1, [r0, #0x18]
	orr r1, r1, #0x400
	str r1, [r0, #0x18]
	ldr r1, [r0, #0x20]
	tst r1, #1
	movne r2, #0x4000
	add r1, r0, #0x600
	moveq r2, #0xc000
	strh r2, [r1, #0xd0]
	ldr r1, =EnemyBallChainPirateBall__Unknown_215ACBC
	str r1, [r0, #0x6c8]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBallChainPirateBall__Unknown_215AEE0(EnemyBallChainPirateBall *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x18]
	mov r0, #0
	bic r1, r1, #0x400
	str r1, [r4, #0x18]
	str r0, [r4, #0x68]
	str r0, [r4, #0x6c]
	ldr r0, [r4, #0x20]
	tst r0, #1
	ldr r0, [r4, #0x11c]
	ldrne r0, [r0, #0x44]
	addne r0, r0, #0x35000
	ldreq r0, [r0, #0x44]
	subeq r0, r0, #0x35000
	str r0, [r4, #0x44]
	ldr r1, [r4, #0x11c]
	mov r0, r4
	ldr r2, [r1, #0x48]
	mov r1, #0x150
	sub r2, r2, #0x39000
	str r2, [r4, #0x48]
	mov r2, #0xf000
	bl StageTask__SetGravity
	ldr r0, [r4, #0x1c]
	mov r2, #0
	orr r0, r0, #0x4000
	orr r0, r0, #0x20000000
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	sub r1, r2, #1
	tst r0, #1
	ldrne r0, =0x00000AAA
	mov r3, r1
	ldreq r0, =0x00007555
	strh r0, [r4, #0x34]
	str r2, [r4, #0xa0]
	str r2, [r4, #0x9c]
	str r2, [r4, #0x98]
	mov r0, #0x5000
	str r0, [r4, #0xc8]
	add r0, r4, #0x600
	strh r2, [r0, #0xcc]
	str r2, [sp]
	mov r0, #0x118
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, =EnemyBallChainPirateBall__Unknown_215AFD0
	str r0, [r4, #0x6c8]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBallChainPirateBall__Unknown_215AFD0(EnemyBallChainPirateBall *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r1, [r4, #0x11c]
	ldr r0, [r4, #0x44]
	ldr r1, [r1, #0x44]
	subs r0, r1, r0
	rsbmi r0, r0, #0
	cmp r0, #0x82000
	blt _0215B070
	ldr r0, [r4, #0x20]
	ands r0, r0, #1
	beq _0215B038
	ldr r1, [r4, #0xc8]
	mov r0, #0x8000
	mov r1, r1, asr #2
	str r1, [r4, #0xc8]
	ldr r1, [r4, #0x11c]
	rsb r0, r0, #0
	ldr r1, [r1, #0x44]
	add r1, r1, #0x82000
	str r1, [r4, #0x44]
	ldrsh r1, [r4, #0x34]
	sub r0, r0, r1
	strh r0, [r4, #0x34]
	b _0215B070
_0215B038:
	cmp r0, #0
	bne _0215B070
	ldr r1, [r4, #0xc8]
	mov r0, #0x8000
	mov r1, r1, asr #2
	str r1, [r4, #0xc8]
	ldr r1, [r4, #0x11c]
	rsb r0, r0, #0
	ldr r1, [r1, #0x44]
	sub r1, r1, #0x82000
	str r1, [r4, #0x44]
	ldrsh r1, [r4, #0x34]
	sub r0, r0, r1
	strh r0, [r4, #0x34]
_0215B070:
	add r0, r4, #0x600
	ldrh r1, [r0, #0xce]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0xce]
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0x1c]
	tst r1, #0xf
	beq _0215B14C
	ldrh r1, [r0, #0xcc]
	cmp r1, #1
	blo _0215B0D8
	mov r1, #0
	str r1, [r4, #0xc8]
	ldr r0, =0x00000119
	str r1, [sp]
	rsb r1, r0, #0x118
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, =EnemyBallChainPirateBall__Unknown_215B170
	str r0, [r4, #0x6c8]
	b _0215B14C
_0215B0D8:
	add r1, r1, #1
	mov r2, #5
	strh r1, [r0, #0xcc]
	strh r2, [r0, #0xce]
	ldr r1, [r4, #0x1c]
	mov r0, #0
	orr r1, r1, #0x10
	str r1, [r4, #0x1c]
	sub r1, r0, #1
	str r0, [sp]
	add r0, r2, #0x114
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #0
	str r0, [r4, #0xa0]
	str r0, [r4, #0x9c]
	str r0, [r4, #0x98]
	ldr r0, [r4, #0xc8]
	mov r0, r0, asr #2
	str r0, [r4, #0xc8]
	ldr r0, [r4, #0x20]
	tst r0, #1
	ldrne r0, =0x00008E38
	strneh r0, [r4, #0x34]
	ldreq r0, =0x0000F1C7
	streqh r0, [r4, #0x34]
_0215B14C:
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBallChainPirateBall__Unknown_215B170(EnemyBallChainPirateBall *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r1, [r0, #0x11c]
	ldr r1, [r1, #0x354]
	tst r1, #0x10000
	ldrne r1, [r0, #0x18]
	orrne r1, r1, #0x400
	strne r1, [r0, #0x18]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBallChainPirateBall__Unknown_215B18C(EnemyBallChainPirateBall *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r1, [r0, #0x1c]
	mov r2, #0
	bic r1, r1, #0x80
	str r1, [r0, #0x1c]
	str r2, [r0, #0xa0]
	str r2, [r0, #0x9c]
	ldr r1, =EnemyBallChainPirateBall__Unknown_215B1B8
	str r2, [r0, #0x98]
	str r1, [r0, #0x6c8]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBallChainPirateBall__Unknown_215B1B8(EnemyBallChainPirateBall *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr ip, [r0, #0x11c]
	ldr r1, [r0, #0x20]
	ldr r2, [ip, #0x44]
	tst r1, #1
	subne r3, r2, #0x3c000
	addeq r3, r2, #0x3c000
	ldr r2, [ip, #0x48]
	ldr r1, [r0, #0x48]
	sub r2, r2, #0x4d000
	subs r1, r1, r2
	rsbmi r1, r1, #0
	cmp r1, #0x5000
	bxle lr
	ldr r1, [r0, #0x44]
	rsb r1, r1, r1, lsl #3
	add r1, r3, r1
	mov r1, r1, asr #3
	str r1, [r0, #0x44]
	ldr r1, [r0, #0x48]
	rsb r1, r1, r1, lsl #3
	add r1, r2, r1
	mov r1, r1, asr #3
	str r1, [r0, #0x48]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBombPirateBomb__State_215B218(EnemyBombPirateBomb *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0x150
	mov r2, #0xf000
	bl StageTask__SetGravity
	ldr r0, [r4, #0x1c]
	ldr r2, =0x00000117
	orr r0, r0, #0x4000
	orr r0, r0, #0x20000000
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	mov r3, #0
	tst r0, #1
	ldrne r0, =0x0000D555
	sub r1, r2, #0x118
	ldreq r0, =0x0000AAAA
	strh r0, [r4, #0x34]
	mov r0, #0x2000
	str r0, [r4, #0xc8]
	add r0, r4, #0x300
	strh r3, [r0, #0x64]
	str r3, [sp]
	str r2, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, =EnemyBombPirateBomb__State_215B2B4
	str r0, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBombPirateBomb__State_215B2B4(EnemyBombPirateBomb *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	mov r1, r0
	add r0, r1, #0x300
	ldrh r2, [r0, #0x66]
	cmp r2, #0
	subne r1, r2, #1
	strneh r1, [r0, #0x66]
	ldmneia sp!, {r3, pc}
	ldr r2, [r1, #0x1c]
	tst r2, #0xf
	beq _0215B374
	ldrh r2, [r0, #0x64]
	cmp r2, #3
	blo _0215B324
	ldr r0, [r1, #0x20]
	mov r2, #0x3c
	tst r0, #1
	movne r0, #0
	moveq r0, #0x8000
	strh r0, [r1, #0x34]
	ldr r0, [r1, #0xbc]
	cmp r0, #0
	rsblt r0, r0, #0
	str r0, [r1, #0xc8]
	ldr r0, =EnemyBombPirateBomb__State_215B388
	str r2, [r1, #0x2c]
	str r0, [r1, #0xf4]
	b _0215B374
_0215B324:
	add r2, r2, #1
	strh r2, [r0, #0x64]
	mov r2, #5
	strh r2, [r0, #0x66]
	ldr r2, [r1, #0x1c]
	mov r0, #0
	orr r2, r2, #0x10
	str r2, [r1, #0x1c]
	str r0, [r1, #0xa0]
	str r0, [r1, #0x9c]
	str r0, [r1, #0x98]
	ldr r0, [r1, #0xc8]
	sub r0, r0, r0, asr #3
	str r0, [r1, #0xc8]
	ldr r0, [r1, #0x20]
	tst r0, #1
	movne r0, #0xe000
	strneh r0, [r1, #0x34]
	moveq r0, #0xa000
	streqh r0, [r1, #0x34]
_0215B374:
	ldr r0, [r1, #0x138]
	add r1, r1, #0x44
	bl ProcessSpatialSfx
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBombPirateBomb__State_215B388(EnemyBombPirateBomb *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x2c]
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r3, r4, pc}
	ldr r0, [r4, #0x18]
	mov r1, #0
	orr r0, r0, #4
	str r0, [r4, #0x18]
	mvn r0, #0x13
	str r0, [sp]
	mov r0, #0xe
	str r0, [sp, #4]
	mov r0, #0xb
	str r0, [sp, #8]
	mov r3, #7
	mov r0, r4
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #1
	sub r3, r1, #0x11
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemySkeletonPirateBone__State_215B434(EnemySkeletonPirateBone *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #0x150
	mov r2, #0xf000
	bl StageTask__SetGravity
	ldr r0, [r4, #0x1c]
	mov r2, #0
	orr r0, r0, #0x4000
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	tst r0, #1
	ldrne r0, =0x0000CE38
	ldreq r0, =0x0000B1C7
	strh r0, [r4, #0x34]
	mov r0, #0x3000
	str r0, [r4, #0xc8]
	add r0, r4, #0x300
	strh r2, [r0, #0x64]
	mov r0, #0x81
	str r2, [sp]
	sub r1, r0, #0x82
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, =EnemySkeletonPirateBone__State_215B4C8
	str r0, [r4, #0xf4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemySkeletonPirateBone__State_215B4C8(EnemySkeletonPirateBone *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r0, [r4, #0x1c]
	tst r0, #0xf
	ldrne r0, [r4, #0x18]
	orrne r0, r0, #4
	strne r0, [r4, #0x18]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyHoverBomberPirateBomb__State_215B4F4(EnemyHoverBomberPirateBomb *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r1, #0x150
	mov r2, #0xf000
	mov r4, r0
	bl StageTask__SetGravity
	mov r0, #0x4000
	strh r0, [r4, #0x34]
	mov r1, #0x3000
	ldr r0, =EnemyHoverBomberPirateBomb__State_215B528
	str r1, [r4, #0xc8]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyHoverBomberPirateBomb__State_215B528(EnemyHoverBomberPirateBomb *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0xf
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r2, [r4, #0x18]
	mov r1, #0
	orr r2, r2, #4
	str r2, [r4, #0x18]
	mvn r2, #0x1b
	str r2, [sp]
	mov r2, #0x1e
	str r2, [sp, #4]
	mov r2, #0x1c
	str r2, [sp, #8]
	mov r2, #7
	str r2, [sp, #0xc]
	mov ip, #2
	sub r2, r1, #0x10000
	sub r3, r1, #0x1e
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyHoverGunnerPirateShot__State_215B5C0(EnemyHoverGunnerPirateShot *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	mov r1, #0x3000
	str r1, [r0, #0xc8]
	ldr r1, [r0, #0x20]
	tst r1, #1
	movne r1, #0x2000
	moveq r1, #0x6000
	strh r1, [r0, #0x34]
	ldr r1, =EnemyHoverGunnerPirateShot__State_215B5EC
	str r1, [r0, #0xf4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyHoverGunnerPirateShot__State_215B5EC(EnemyHoverGunnerPirateShot *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r1, [r4, #0x1c]
	tst r1, #0xf
	addeq sp, sp, #0x14
	ldmeqia sp!, {r3, r4, pc}
	ldr r2, [r4, #0x18]
	mov r1, #0
	orr r2, r2, #4
	str r2, [r4, #0x18]
	mvn r2, #0x13
	str r2, [sp]
	mov r2, #0xe
	str r2, [sp, #4]
	mov r2, #0xb
	str r2, [sp, #8]
	mov r3, #7
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #1
	sub r3, r1, #0x11
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBazookaPirateShot__OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0x1c]
	mov r1, #0
	ldr r2, [r4, #0x18]
	mvn r0, #0x13
	orr r2, r2, #4
	str r2, [r4, #0x18]
	str r0, [sp]
	mov r0, #0xe
	str r0, [sp, #4]
	mov r0, #0xb
	str r0, [sp, #8]
	mov r3, #7
	mov r0, r4
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #1
	sub r3, r1, #0x11
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyBombPirateBomb__OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0x1c]
	mov r1, #0
	ldr r2, [r4, #0x18]
	mvn r0, #0x13
	orr r2, r2, #4
	str r2, [r4, #0x18]
	str r0, [sp]
	mov r0, #0xe
	str r0, [sp, #4]
	mov r0, #0xb
	str r0, [sp, #8]
	mov r3, #7
	mov r0, r4
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #1
	sub r3, r1, #0x11
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemySkeletonPirateBone__OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r1, [r0, #0x1c]
	ldr r0, [r1, #0x18]
	orr r0, r0, #4
	str r0, [r1, #0x18]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyHoverBomberPirateBomb__OnHit(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldr r4, [r0, #0x1c]
	mov r1, #0
	ldr r2, [r4, #0x18]
	mvn r0, #0x1b
	orr r2, r2, #4
	str r2, [r4, #0x18]
	str r0, [sp]
	mov r0, #0x1e
	str r0, [sp, #4]
	mov r0, #0x1c
	str r0, [sp, #8]
	mov r3, #7
	mov r0, r4
	mov r2, r1
	str r3, [sp, #0xc]
	mov ip, #2
	sub r3, r1, #0x1e
	str ip, [sp, #0x10]
	bl CreateEffectHarmfulExplosion
	mov r2, #0
	mov r0, #0x80
	sub r1, r0, #0x81
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__OnDefend_215B83C(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	ldr r0, [r5, #0x18]
	tst r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r5, #0x300
	ldrh r2, [r0, #0xc6]
	ldr r1, =0x0218828C
	ldr r0, =0x02188290
	ldr r1, [r1, r2, lsl #3]
	ldr r2, [r0, r2, lsl #3]
	mov r0, r5
	bl CreateEffectFound
	ldr r0, [r4, #0x44]
	add r1, r5, #0x300
	str r0, [r5, #0x3a4]
	ldr r0, [r4, #0x48]
	ldr r2, =0x021881F8
	str r0, [r5, #0x3a8]
	ldr r3, [r5, #0x37c]
	mov r0, r5
	bic r3, r3, #4
	str r3, [r5, #0x37c]
	ldrh r3, [r1, #0xc6]
	mov r3, r3, lsl #1
	ldrsh r2, [r2, r3]
	strh r2, [r1, #0xc4]
	ldr r1, [r5, #0x3b0]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyPirate__OnDefend_215B8C4(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r5, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	ldr r0, [r5, #0x18]
	tst r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r3, [r4, #0x48]
	ldr r0, [r5, #0x48]
	ldr r2, [r4, #0x44]
	ldr r1, [r5, #0x44]
	sub r0, r3, r0
	sub r1, r2, r1
	bl FX_Atan2Idx
	ldr r1, [r5, #0x20]
	tst r1, #1
	beq _0215B91C
	ldr r1, =0x00001555
	cmp r0, r1
	ldmloia sp!, {r3, r4, r5, pc}
	cmp r0, r1, lsl #1
	bls _0215B934
	ldmia sp!, {r3, r4, r5, pc}
_0215B91C:
	ldr r1, =0x00005555
	cmp r0, r1
	ldmloia sp!, {r3, r4, r5, pc}
	ldr r1, =0x00006AAA
	cmp r0, r1
	ldmhiia sp!, {r3, r4, r5, pc}
_0215B934:
	add r0, r5, #0x300
	ldrh r2, [r0, #0xc6]
	ldr r1, =0x0218828C
	ldr r0, =0x02188290
	ldr r1, [r1, r2, lsl #3]
	ldr r2, [r0, r2, lsl #3]
	mov r0, r5
	bl CreateEffectFound
	ldr r0, [r4, #0x44]
	add r1, r5, #0x300
	str r0, [r5, #0x3a4]
	ldr r0, [r4, #0x48]
	ldr r2, =0x021881F8
	str r0, [r5, #0x3a8]
	ldr r3, [r5, #0x37c]
	mov r0, r5
	bic r3, r3, #4
	str r3, [r5, #0x37c]
	ldrh r3, [r1, #0xc6]
	mov r3, r3, lsl #1
	ldrsh r2, [r2, r3]
	strh r2, [r1, #0xc4]
	ldr r1, [r5, #0x3b0]
	blx r1
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}
