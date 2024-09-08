#include <stage/enemies/snowflakeHead.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/audio/spatialAudio.h>

NOT_DECOMPILED void *aActAcEneQHeadB;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC EnemySnowflakeHead *EnemySnowflakeHead__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	beq _02158130
	ldrb r0, [r7]
	cmp r0, #0xff
	ldreqb r0, [r7, #1]
	cmpeq r0, #0xff
	beq _02158154
_02158130:
	ldr r0, =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _02158154
	ldrh r0, [r7, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
_02158154:
	mov r0, #0x1500
	mov r2, #0
	str r0, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x37c
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
	mov r2, #0x37c
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x100
	str r0, [r4, #0x20]
	ldrh r0, [r7, #4]
	and r0, r0, #7
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _02158234
_021581E8: // jump table
	b _021581FC // case 0
	b _02158208 // case 1
	b _02158214 // case 2
	b _02158220 // case 3
	b _0215822C // case 4
_021581FC:
	mov r0, #0
	strb r0, [r4, #0x374]
	b _02158234
_02158208:
	mov r0, #1
	strb r0, [r4, #0x374]
	b _02158234
_02158214:
	mov r0, #2
	strb r0, [r4, #0x374]
	b _02158234
_02158220:
	mov r0, #3
	strb r0, [r4, #0x374]
	b _02158234
_0215822C:
	mov r0, #4
	strb r0, [r4, #0x374]
_02158234:
	ldrb r0, [r4, #0x374]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _021582A4
_02158244: // jump table
	b _021582A4 // case 0
	b _02158258 // case 1
	b _02158258 // case 2
	b _02158280 // case 3
	b _02158280 // case 4
_02158258:
	ldr r0, [r4, #0x340]
	ldr r1, [r4, #0x44]
	ldrsb r0, [r0, #6]
	add r1, r1, r0, lsl #12
	str r1, [r4, #0x364]
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #8]
	add r0, r1, r0, lsl #12
	str r0, [r4, #0x36c]
	b _021582A4
_02158280:
	ldr r0, [r4, #0x340]
	ldr r1, [r4, #0x48]
	ldrsb r0, [r0, #7]
	add r1, r1, r0, lsl #12
	str r1, [r4, #0x368]
	ldr r0, [r4, #0x340]
	ldrb r0, [r0, #9]
	add r0, r1, r0, lsl #12
	str r0, [r4, #0x370]
_021582A4:
	mov r0, #0xc
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r0, [r1]
	ldr r5, =0x0000FFFF
	str r0, [sp]
	ldr r2, =aActAcEneQHeadB
	mov r0, r4
	add r1, r4, #0x168
	str r5, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0
	mov r2, #0x35
	bl ObjActionAllocSpritePalette
	mov r0, r4
	bl EnemySnowflakeHead__Action_Init
	mov r0, r4
	bl StageTask__InitSeqPlayer
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemySnowflakeHead__Action_Init(EnemySnowflakeHead *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	orr r0, r0, #4
	str r0, [r4, #0x20]
	ldrb r0, [r4, #0x374]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, pc}
_0215835C: // jump table
	b _02158370 // case 0
	b _0215837C // case 1
	b _0215837C // case 2
	b _02158388 // case 3
	b _02158388 // case 4
_02158370:
	ldr r0, =EnemySnowflakeHead__State_2158494
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
_0215837C:
	ldr r0, =EnemySnowflakeHead__State_21583A0
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}
_02158388:
	ldr r0, =EnemySnowflakeHead__State_215841C
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemySnowflakeHead__State_21583A0(EnemySnowflakeHead *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r1, [r0, #0x364]
	ldr r2, [r0, #0x44]
	cmp r2, r1
	bge _021583C0
	str r1, [r0, #0x44]
	mov r1, #1
	strb r1, [r0, #0x374]
	b _021583D4
_021583C0:
	ldr r1, [r0, #0x36c]
	cmp r2, r1
	strgt r1, [r0, #0x44]
	movgt r1, #2
	strgtb r1, [r0, #0x374]
_021583D4:
	ldrb r1, [r0, #0x374]
	cmp r1, #1
	bne _021583F4
	mov r1, #0xc00
	str r1, [r0, #0x98]
	mov r1, #0
	str r1, [r0, #0x9c]
	b _02158410
_021583F4:
	cmp r1, #2
	bne _02158410
	mov r1, #0xc00
	rsb r1, r1, #0
	str r1, [r0, #0x98]
	mov r1, #0
	str r1, [r0, #0x9c]
_02158410:
	ldr ip, =EnemySnowflakeHead__Func_21584AC
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void EnemySnowflakeHead__State_215841C(EnemySnowflakeHead *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r1, [r0, #0x368]
	ldr r2, [r0, #0x48]
	cmp r2, r1
	bge _0215843C
	str r1, [r0, #0x48]
	mov r1, #4
	strb r1, [r0, #0x374]
	b _02158450
_0215843C:
	ldr r1, [r0, #0x370]
	cmp r2, r1
	strgt r1, [r0, #0x48]
	movgt r1, #3
	strgtb r1, [r0, #0x374]
_02158450:
	ldrb r1, [r0, #0x374]
	cmp r1, #3
	bne _02158470
	mov r1, #0
	str r1, [r0, #0x98]
	sub r1, r1, #0xc00
	str r1, [r0, #0x9c]
	b _02158488
_02158470:
	cmp r1, #4
	bne _02158488
	mov r1, #0
	str r1, [r0, #0x98]
	mov r1, #0xc00
	str r1, [r0, #0x9c]
_02158488:
	ldr ip, =EnemySnowflakeHead__Func_21584AC
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void EnemySnowflakeHead__State_2158494(EnemySnowflakeHead *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	mov r1, #0
	str r1, [r0, #0x98]
	ldr ip, =EnemySnowflakeHead__Func_21584AC
	str r1, [r0, #0x9c]
	bx ip

// clang-format on
#endif
}

NONMATCH_FUNC void EnemySnowflakeHead__Func_21584AC(EnemySnowflakeHead *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x378]
	add r0, r0, #1
	cmp r0, #0x78
	addle sp, sp, #8
	str r0, [r4, #0x378]
	ldmleia sp!, {r4, pc}
	mov r1, #0
	str r1, [r4, #0x378]
	mov r0, #0x7d
	str r1, [sp]
	sub r1, r0, #0x7e
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	mov r0, #0
	str r0, [r4, #0x98]
	ldr r2, =EnemySnowflakeHead__State_2158540
	str r0, [r4, #0x9c]
	mov r0, r4
	mov r1, #1
	str r2, [r4, #0xf4]
	bl GameObject__SetAnimation
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x41
	bl ObjRect__SetDefenceStat
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemySnowflakeHead__State_2158540(EnemySnowflakeHead *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x100
	ldrh r0, [r0, #0x76]
	cmp r0, #0x12
	bne _02158568
	add r0, r4, #0x218
	mov r1, #1
	mov r2, #0x3f
	bl ObjRect__SetDefenceStat
_02158568:
	ldr r0, [r4, #0x20]
	tst r0, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl EnemySnowflakeHead__Action_Init
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}