#include <stage/objects/barrel.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/stage/gameSystem.h>
#include <game/audio/spatialAudio.h>
#include <stage/effects/battleBurst.h>

// --------------------
// VARIABLES
// --------------------

static const s8 offsetTable[] = { 0, 2, 2, -2, -2, -2, 0, -2, 2, 2, -2, 0, 2, 0, -2, -2 };

NOT_DECOMPILED void *aActAcGmkBarrel;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC Barrel *Barrel__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, =0x000010F6
	mov r7, r0
	str r3, [sp]
	mov r0, #2
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x000004BC
	ldr r0, =StageTask_Main
	ldr r1, =Barrel__Destructor
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
	ldr r2, =0x000004BC
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldrsb r1, [r7, #6]
	and r0, r1, #0xff
	cmp r0, #0x2a
	movhi r0, #0x2a
	strhib r0, [r7, #6]
	bhi _02177534
	cmp r1, #0
	moveq r0, #0x26
	streqb r0, [r7, #6]
_02177534:
	ldrsb r1, [r7, #6]
	mov r0, #0xa1
	mov r1, r1, lsl #0xf
	str r1, [r4, #0x4b0]
	ldr r1, [r4, #0x1c]
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r0, [r1, #0]
	ldr r5, =0x0000FFFF
	str r0, [sp]
	ldr r2, =aActAcGmkBarrel
	mov r0, r4
	add r1, r4, #0x168
	str r5, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x54
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #6
	bl StageTask__SetAnimation
	mov r0, #0xa1
	add r5, r4, #0x364
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r2, [r1, #0]
	ldr r1, =aActAcGmkBarrel
	str r2, [sp]
	mov r0, r5
	mov r2, #1
	bl ObjAction2dBACLoad
	add r0, r4, #0x100
	ldrh r2, [r0, #0xb8]
	mov r0, r5
	mov r1, #4
	strh r2, [r5, #0x50]
	strh r2, [r5, #0x92]
	strh r2, [r5, #0x90]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r5
	mov r1, #1
	bl StageTask__SetOAMPriority
	add r0, r4, #8
	add r5, r0, #0x400
	mov r0, #0xa1
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r2, [r1, #0]
	ldr r1, =aActAcGmkBarrel
	str r2, [sp]
	mov r0, r5
	mov r2, #2
	bl ObjAction2dBACLoad
	add r0, r4, #0x100
	ldrh r2, [r0, #0xb8]
	mov r0, r5
	mov r1, #0
	strh r2, [r5, #0x50]
	strh r2, [r5, #0x92]
	strh r2, [r5, #0x90]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r5
	mov r1, #0x17
	bl StageTask__SetOAMOrder
	mov r0, r5
	mov r1, #1
	bl StageTask__SetOAMPriority
	ldr r0, =Barrel__Draw
	mvn r1, #0x3f
	str r0, [r4, #0xfc]
	ldr r2, [r4, #0x4b0]
	add r0, r4, #0x218
	mov r2, r2, asr #0xc
	sub r2, r2, #0xb8
	mov r2, r2, lsl #0x10
	mov r5, r2, asr #0x10
	sub r2, r1, #0x58
	mov r3, #0x40
	str r5, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	str r4, [r4, #0x234]
	add r0, r4, #0x218
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x218
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, =Barrel__OnDefend_2178178
	mov r1, #0x38
	str r0, [r4, #0x23c]
	ldr r2, [r4, #0x230]
	add r0, r4, #0x258
	orr r2, r2, #0x400
	str r2, [r4, #0x230]
	str r1, [sp]
	sub r1, r1, #0x58
	mov r2, #0x14
	mov r3, #0x20
	bl ObjRect__SetBox2D
	add r0, r4, #0x258
	mov r1, #0
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x258
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =Barrel__OnDefend_21781A8
	mov r0, r4
	str r1, [r4, #0x27c]
	ldr r1, [r4, #0x270]
	orr r1, r1, #0x1400
	str r1, [r4, #0x270]
	ldr r1, [r4, #0x44]
	mov r1, r1, asr #0xc
	str r1, [r4, #0x264]
	ldr r1, [r4, #0x48]
	mov r1, r1, asr #0xc
	sub r1, r1, #0xe8
	str r1, [r4, #0x268]
	ldr r1, [r4, #0x4c]
	mov r1, r1, asr #0xc
	str r1, [r4, #0x26c]
	bl Barrel__Func_21777F4
	bl AllocSndHandle
	str r0, [r4, #0x138]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Barrel__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0xa1
	bl GetObjectFileWork
	add r1, r4, #0x364
	bl ObjAction2dBACRelease
	mov r0, #0xa1
	bl GetObjectFileWork
	add r1, r4, #8
	add r1, r1, #0x400
	bl ObjAction2dBACRelease
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	mov r0, r5
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Barrel__Func_21777F4(Barrel *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #8
	add r0, r0, #0x400
	mov r1, #0
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r4
	mov r1, #6
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x20]
	ldr r2, =_mt_math_rand
	orr r0, r0, #0x10
	str r0, [r4, #0x20]
	ldr ip, [r2]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	mov r3, #0
	mla r1, ip, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r0, r0, #0x3c
	str r1, [r2]
	and r0, r0, #0x7f
	str r0, [r4, #0x2c]
	str r4, [r4, #0x234]
	ldr r1, [r4, #0x230]
	ldr r0, =Barrel__State_2177894
	bic r1, r1, #0x800
	str r1, [r4, #0x230]
	str r3, [r4, #0x274]
	ldr r1, [r4, #0x270]
	orr r1, r1, #0x800
	str r1, [r4, #0x270]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Barrel__State_2177894(Barrel *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	add r1, r0, #0x400
	ldrh r1, [r1, #0x14]
	cmp r1, #0
	bne _02177974
	ldr r1, [r0, #0x20]
	tst r1, #0x10
	beq _02177904
	ldr r1, [r0, #0x2c]
	sub r1, r1, #1
	str r1, [r0, #0x2c]
	cmp r1, #0
	ldmgtia sp!, {r3, pc}
	ldr r1, [r0, #0x20]
	ldr r3, =_mt_math_rand
	bic r1, r1, #0x10
	str r1, [r0, #0x20]
	ldr ip, [r3]
	ldr r1, =0x00196225
	ldr r2, =0x3C6EF35F
	mla r2, ip, r1, r2
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r2, [r3]
	and r1, r1, #0x7f
	str r1, [r0, #0x2c]
	ldmia sp!, {r3, pc}
_02177904:
	tst r1, #8
	ldmeqia sp!, {r3, pc}
	ldr r2, [r0, #0x2c]
	ldr r1, =playerGameStatus
	sub r2, r2, #1
	str r2, [r0, #0x2c]
	ldr r3, [r1, #0xc]
	ldr r2, =offsetTable
	mov r3, r3, lsr #1
	mov r3, r3, lsl #0x1d
	mov r3, r3, lsr #0x1c
	ldrsb r3, [r2, r3]
	ldr r2, =0x02188731
	str r3, [r0, #0x50]
	ldr r1, [r1, #0xc]
	mov r1, r1, lsr #1
	mov r1, r1, lsl #0x1d
	mov r1, r1, lsr #0x1c
	ldrsb r1, [r2, r1]
	str r1, [r0, #0x54]
	ldr r1, [r0, #0x2c]
	cmp r1, #0
	ldmgtia sp!, {r3, pc}
	add r0, r0, #8
	add r0, r0, #0x400
	mov r1, #1
	bl AnimatorSpriteDS__SetAnimation
	ldmia sp!, {r3, pc}
_02177974:
	ldr r1, [r0, #0x444]
	tst r1, #0x40000000
	ldmeqia sp!, {r3, pc}
	bl Barrel__Func_21777F4
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Barrel__Func_21779A0(Barrel *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x234]
	ldr r2, [r4, #0x230]
	mov r1, #2
	orr r2, r2, #0x800
	str r2, [r4, #0x230]
	ldr r2, [r4, #0x20]
	bic r2, r2, #0x10
	str r2, [r4, #0x20]
	bl StageTask__SetAnimation
	mov r1, #0
	str r1, [r4, #0x28]
	str r1, [r4, #0x4b4]
	ldr r0, =Barrel__State_21779F0
	str r1, [r4, #0x24]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Barrel__State_21779F0(Barrel *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02177A14
	cmp r0, #1
	beq _02177A70
	b _02177AB8
_02177A14:
	ldr r0, [r4, #0x20]
	tst r0, #8
	beq _02177AB8
	str r4, [r4, #0x274]
	ldr r1, [r4, #0x270]
	mov r0, #0x6f
	bic r1, r1, #0x800
	str r1, [r4, #0x270]
	ldr r2, [r4, #0x28]
	sub r1, r0, #0x70
	add r2, r2, #1
	str r2, [r4, #0x28]
	mov r2, #0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	b _02177AB8
_02177A70:
	ldr r0, [r4, #0x4b4]
	mov r1, #0x300
	mov r2, #0xf000
	bl ObjSpdUpSet
	str r0, [r4, #0x4b4]
	ldr r1, [r4, #0x4ac]
	add r0, r1, r0
	str r0, [r4, #0x4ac]
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r1, [r4, #0x4b0]
	ldr r0, [r4, #0x4ac]
	cmp r0, r1
	blt _02177AB8
	mov r0, r4
	str r1, [r4, #0x4ac]
	bl Barrel__Func_2177B14
_02177AB8:
	ldr r0, [r4, #0x44]
	mov r0, r0, asr #0xc
	str r0, [r4, #0x264]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x4ac]
	add r0, r1, r0
	mov r0, r0, asr #0xc
	sub r0, r0, #0xe8
	str r0, [r4, #0x268]
	ldr r0, [r4, #0x4c]
	mov r0, r0, asr #0xc
	str r0, [r4, #0x26c]
	ldr r0, [r4, #0x44]
	str r0, [r4, #0x8c]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x4ac]
	add r0, r1, r0
	sub r0, r0, #0xe8000
	str r0, [r4, #0x90]
	ldr r0, [r4, #0x4c]
	str r0, [r4, #0x94]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Barrel__Func_2177B14(Barrel *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	str r1, [r4, #0x274]
	ldr r2, [r4, #0x270]
	mov r1, #3
	orr r2, r2, #0x800
	str r2, [r4, #0x270]
	bl StageTask__SetAnimation
	ldr r0, =Barrel__State_2177B64
	mov r1, #0
	str r0, [r4, #0xf4]
	str r1, [r4, #0x28]
	ldr r0, [r4, #0x354]
	bic r0, r0, #1
	str r0, [r4, #0x354]
	ldr r0, [r4, #0x138]
	bl NNS_SndPlayerStopSeq
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Barrel__State_2177B64(Barrel *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	ldrne r0, [r0, #0x6d8]
	cmpne r0, r4
	beq _02177B9C
	mov r1, #0
	str r1, [r4, #0x35c]
	ldr r0, [r4, #0x354]
	bic r0, r0, #1
	str r0, [r4, #0x354]
	strh r1, [r4, #0x34]
_02177B9C:
	ldr r0, [r4, #0x28]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _02177D64
_02177BAC: // jump table
	b _02177BC0 // case 0
	b _02177C3C // case 1
	b _02177CA8 // case 2
	b _02177D34 // case 3
	b _02177D50 // case 4
_02177BC0:
	ldr r0, [r4, #0x20]
	tst r0, #8
	beq _02177D64
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	moveq r0, #0x4000
	rsbeq r0, r0, #0
	streq r0, [r4, #0x4b4]
	beq _02177BFC
	mov r0, #0x8000
	rsb r0, r0, #0
	str r0, [r4, #0x4b4]
	ldr r0, [r4, #0x354]
	orr r0, r0, #2
	str r0, [r4, #0x354]
_02177BFC:
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x4ac]
	cmp r0, #0
	ble _02177D64
	mov r1, #0
	mov r0, #0x70
	str r1, [sp]
	sub r1, r0, #0x71
	str r0, [sp, #4]
	ldr r0, [r4, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _02177D64
_02177C3C:
	ldr r0, [r4, #0x138]
	add r1, r4, #0x44
	bl ProcessSpatialSfx
	ldr r1, [r4, #0x4ac]
	ldr r0, [r4, #0x4b4]
	add r0, r1, r0
	str r0, [r4, #0x4ac]
	cmp r0, #0
	bgt _02177D64
	add r0, r4, #8
	mov r1, #0
	str r1, [r4, #0x4ac]
	mov r2, #0x10
	add r0, r0, #0x400
	mov r1, #1
	str r2, [r4, #0x2c]
	bl AnimatorSpriteDS__SetAnimation
	mov r0, r4
	mov r1, #6
	bl StageTask__SetAnimation
	ldr r0, [r4, #0x138]
	mov r1, #0
	bl NNS_SndPlayerStopSeq
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	b _02177D64
_02177CA8:
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	cmp r0, #0
	bgt _02177CF4
	ldr r0, [r4, #0x20]
	tst r0, #8
	beq _02177CF4
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	beq _02177CE4
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	b _02177D64
_02177CE4:
	mov r0, r4
	bl Barrel__Func_21777F4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02177CF4:
	ldr r0, =playerGameStatus
	ldr r2, =offsetTable
	ldr r3, [r0, #0xc]
	ldr r1, =0x02188731
	mov r3, r3, lsr #1
	mov r3, r3, lsl #0x1d
	mov r3, r3, lsr #0x1c
	ldrsb r2, [r2, r3]
	str r2, [r4, #0x50]
	ldr r0, [r0, #0xc]
	mov r0, r0, lsr #1
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1c
	ldrsb r0, [r1, r0]
	str r0, [r4, #0x54]
	b _02177D64
_02177D34:
	ldr r0, [r4, #0x35c]
	cmp r0, #0
	bne _02177D64
	mov r0, r4
	bl Barrel__Func_21777F4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02177D50:
	ldr r0, [r4, #0x20]
	tst r0, #8
	beq _02177D64
	mov r0, r4
	bl Barrel__Func_2177B14
_02177D64:
	ldr r1, [r4, #0x35c]
	cmp r1, #0
	beq _02177FB0
	ldr r0, [r1, #0x28]
	tst r0, #2
	beq _02177DC4
	mov r3, #0
	str r3, [r4, #0x35c]
	ldr r0, [r4, #0x354]
	sub r1, r3, #0x4000
	bic r0, r0, #1
	str r0, [r4, #0x354]
	strh r3, [r4, #0x34]
	ldr r2, [r4, #0x24]
	mov r0, r4
	orr r2, r2, #1
	str r2, [r4, #0x24]
	str r3, [r4, #0x98]
	str r1, [r4, #0x9c]
	mov r2, #4
	mov r1, #2
	str r2, [r4, #0x28]
	bl StageTask__SetAnimation
	b _02177EF8
_02177DC4:
	tst r0, #1
	beq _02177EF8
	ldr r0, [r1, #0x2c]
	add r0, r0, #2
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x354]
	tst r0, #1
	bne _02177DF4
	ldr r1, [r4, #0x2c]
	add r0, r4, #0x400
	mov r1, r1, lsl #7
	strh r1, [r0, #0xb8]
_02177DF4:
	ldr r0, [r4, #0x354]
	ldr r2, =_mt_math_rand
	orr r0, r0, #1
	str r0, [r4, #0x354]
	ldr r3, [r2, #0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	mla ip, r3, r0, r1
	mla r0, ip, r0, r1
	str r0, [r2]
	mov r2, ip, lsr #0x10
	mov r1, r0, lsr #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	and r3, r0, #0x1f
	and r0, r2, #0x1f
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x4ac]
	ldr ip, [r4, #0x44]
	sub r3, r3, #0xf
	add r2, r2, r1
	sub r1, r0, #0xd7
	add r0, ip, r3, lsl #12
	add r1, r2, r1, lsl #12
	bl CreateEffectBattleBurst
	ldr r3, =_mt_math_rand
	ldr r0, =0x00196225
	ldr r2, [r3, #0]
	ldr r1, =0x3C6EF35F
	mla ip, r2, r0, r1
	mov r2, ip, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	str ip, [r3]
	tst r2, #1
	beq _02177EDC
	mla r2, ip, r0, r1
	mla r0, r2, r0, r1
	mov r2, r2, lsr #0x10
	str r0, [r3]
	mov r1, r0, lsr #0x10
	mov r0, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	and r3, r0, #0x1f
	and r0, r2, #0x1f
	ldr r2, [r4, #0x48]
	ldr r1, [r4, #0x4ac]
	ldr ip, [r4, #0x44]
	sub r3, r3, #0xf
	add r2, r2, r1
	sub r1, r0, #0xd7
	add r0, ip, r3, lsl #12
	add r1, r2, r1, lsl #12
	bl CreateEffectBattleBurst
_02177EDC:
	mov ip, #0x43
	sub r1, ip, #0x44
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
_02177EF8:
	ldr r0, [r4, #0x354]
	tst r0, #1
	beq _02177FB0
	add r0, r4, #0x400
	ldrh r2, [r4, #0x34]
	ldrsh r1, [r0, #0xb8]
	add r1, r2, r1
	strh r1, [r4, #0x34]
	ldr r3, [r4, #0x2c]
	cmp r3, #0
	ble _02177F78
	ldrsh r2, [r0, #0xb8]
	ldrsh r1, [r4, #0x34]
	cmp r2, #0
	blt _02177F58
	cmp r1, r2, lsl #1
	blt _02177FB0
	rsb r1, r3, #0
	mov r1, r1, lsl #7
	strh r1, [r0, #0xb8]
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	b _02177FB0
_02177F58:
	cmp r1, r2, lsl #1
	bgt _02177FB0
	mov r1, r3, lsl #7
	strh r1, [r0, #0xb8]
	ldr r0, [r4, #0x2c]
	sub r0, r0, #1
	str r0, [r4, #0x2c]
	b _02177FB0
_02177F78:
	ldrsh r1, [r0, #0xb8]
	cmp r1, #0
	ldrgesh r0, [r4, #0x34]
	cmpge r0, #0
	bge _02177F9C
	cmp r1, #0
	ldrltsh r0, [r4, #0x34]
	cmplt r0, #0
	bge _02177FB0
_02177F9C:
	ldr r1, [r4, #0x354]
	mov r0, #0
	bic r1, r1, #1
	str r1, [r4, #0x354]
	strh r0, [r4, #0x34]
_02177FB0:
	ldr r0, [r4, #0x44]
	str r0, [r4, #0x8c]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x4ac]
	add r0, r1, r0
	sub r0, r0, #0xe8000
	str r0, [r4, #0x90]
	ldr r0, [r4, #0x4c]
	str r0, [r4, #0x94]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Barrel__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x1c
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x20]
	str r1, [sp, #0xc]
	ldr r0, [r4, #0x354]
	tst r0, #1
	orreq r0, r1, #0x100
	streq r0, [sp, #0xc]
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x50]
	add r0, r1, r0
	str r0, [sp, #0x10]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x4ac]
	ldr r2, [r4, #0x54]
	add r0, r1, r0
	sub r0, r0, #0xe8000
	add r0, r2, r0
	str r0, [sp, #0x14]
	ldr r0, [r4, #0x4c]
	str r0, [sp, #0x18]
	ldrh r0, [r4, #0x34]
	ldr r1, [r4, #0x128]
	cmp r0, #0
	ldr r0, [r1, #0x3c]
	beq _02178078
	orr r0, r0, #0x200
	str r0, [r1, #0x3c]
	ldr r0, [r4, #0x444]
	orr r0, r0, #0x200
	b _02178088
_02178078:
	bic r0, r0, #0x200
	str r0, [r1, #0x3c]
	ldr r0, [r4, #0x444]
	bic r0, r0, #0x200
_02178088:
	str r0, [r4, #0x444]
	ldr r0, [r4, #0x128]
	ldrh r0, [r0, #0xc]
	cmp r0, #6
	bne _021780E0
	add r0, r4, #0x400
	ldrh r0, [r0, #0x14]
	cmp r0, #1
	bne _021780B8
	ldr r0, [r4, #0x444]
	tst r0, #0x40000000
	bne _021780E0
_021780B8:
	add r1, r4, #0x20
	add r0, r4, #8
	str r1, [sp]
	mov r3, #0
	str r3, [sp, #4]
	add r1, sp, #0x10
	add r0, r0, #0x400
	add r2, r4, #0x30
	str r3, [sp, #8]
	bl StageTask__Draw2DEx
_021780E0:
	add r0, r4, #0x20
	str r0, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r3, [sp, #8]
	ldr r0, [r4, #0x128]
	add r1, sp, #0x10
	add r2, r4, #0x30
	bl StageTask__Draw2DEx
	ldr r1, [r4, #0x4ac]
	ldr r0, [r4, #0x44]
	add r1, r1, #0x10000
	str r0, [sp, #0x10]
	ldr r0, [r4, #0x48]
	mov r1, r1, asr #0xf
	sub r0, r0, #0xf8000
	str r0, [sp, #0x14]
	adds r8, r1, #1
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	add r7, sp, #0xc
	mov r6, #0
	add r5, sp, #0x10
_0217813C:
	str r7, [sp]
	str r6, [sp, #4]
	mov r1, r5
	mov r2, r6
	mov r3, r6
	str r6, [sp, #8]
	add r0, r4, #0x364
	bl StageTask__Draw2DEx
	ldr r0, [sp, #0x14]
	subs r8, r8, #1
	add r0, r0, #0x8000
	str r0, [sp, #0x14]
	bne _0217813C
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Barrel__OnDefend_2178178(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	cmp r1, #0
	cmpne r0, #0
	ldmeqia sp!, {r3, pc}
	ldrh r0, [r0, #0]
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	mov r0, r1
	bl Barrel__Func_21779A0
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Barrel__OnDefend_21781A8(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x35c]
	cmp r0, r5
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	str r5, [r4, #0x35c]
	bl Barrel__Func_2177B14
	ldr r1, [r4, #0x354]
	mov r0, r5
	bic r2, r1, #2
	mov r1, r4
	str r2, [r4, #0x354]
	bl Player__Func_2021CE8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}
