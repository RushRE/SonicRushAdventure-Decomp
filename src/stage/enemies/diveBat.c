#include <stage/enemies/divebat.h>
#include <game/game/gameState.h>
#include <game/stage/gameSystem.h>
#include <game/object/objectManager.h>
#include <game/object/obj.h>
#include <game/audio/spatialAudio.h>

// --------------------
// STRUCTS
// --------------------

struct DiveBatInstance
{
    EnemyDiveBat *entity;
    u8 count;
    u8 flags;
    s16 timer;
};

// --------------------
// VARIABLES
// --------------------

static struct DiveBatInstance _0218A35C[3];

NOT_DECOMPILED void *_02188DA0;
NOT_DECOMPILED void *aActAcEneDiveba;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC EnemyDiveBat *EnemyDiveBat__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	movs r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	beq _0215C420
	ldrb r0, [r8]
	cmp r0, #0xff
	ldreqb r0, [r8, #1]
	cmpeq r0, #0xff
	beq _0215C444
_0215C420:
	ldr r0, =gameState
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _0215C444
	ldrh r0, [r8, #4]
	tst r0, #0x80
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0215C444:
	ldrh r0, [r8, #2]
	mov r2, #0
	mov r4, #2
	cmp r0, #0x15c
	ldreq r0, =0x000014FF
	ldr r1, =EnemyDiveBat__Destructor
	movne r0, #0x1500
	str r0, [sp]
	str r4, [sp, #4]
	mov r4, #0x3c8
	ldr r0, =StageTask_Main
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
	mov r2, #0x3c8
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	mov r0, #0x17
	bl GetObjectFileWork
	mov r3, r0
	ldr r0, =gameArchiveStage
	ldr r1, =0x0000FFFF
	ldr r2, [r0]
	mov r0, r4
	str r2, [sp]
	str r1, [sp, #4]
	ldr r2, =aActAcEneDiveba
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
	mov r2, #0x70
	bl ObjActionAllocSpritePalette
	ldr r1, [r4, #0x1c]
	mov r2, #0
	orr r1, r1, #0x100
	mov r0, #0x62
	str r1, [r4, #0x1c]
	str r0, [sp]
	sub r1, r0, #0xc2
	add r0, r4, #0x364
	sub r3, r2, #0x10
	bl ObjRect__SetBox2D
	mov r1, #0
	add r0, r4, #0x364
	mov r2, r1
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x364
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =0x00000102
	add r0, r4, #0x300
	strh r1, [r0, #0x98]
	ldr r1, [r4, #0x37c]
	ldr r0, =EnemyDiveBat__OnDefend
	orr r1, r1, #0x4c0
	str r1, [r4, #0x37c]
	str r0, [r4, #0x388]
	str r4, [r4, #0x380]
	ldr r0, [r4, #0x44]
	str r0, [r4, #0x3ac]
	ldr r0, [r4, #0x48]
	str r0, [r4, #0x3b0]
	ldrsb r0, [r8, #6]
	ldr r1, [r4, #0x44]
	add r1, r1, r0, lsl #12
	str r1, [r4, #0x3a4]
	ldrb r0, [r8, #8]
	add r0, r1, r0, lsl #12
	str r0, [r4, #0x3a8]
	ldr r0, [r4, #0x48]
	ldr r1, [r4, #0x44]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	str r0, [r4, #0x3c0]
	ldrh r0, [r8, #4]
	tst r0, #0x40
	ldrne r0, [r4, #0x20]
	orrne r0, r0, #1
	strne r0, [r4, #0x20]
	ldrh r0, [r8, #2]
	cmp r0, #0x15c
	bne _0215C618
	ldr r1, [r4, #0x20]
	mov r0, #0
	orr r1, r1, #0x20
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x12
	str r1, [r4, #0x18]
	strb r5, [r4, #0x3c6]
	str r0, [r4, #0x48]
	str r0, [r4, #0x44]
	b _0215C658
_0215C618:
	ldrh r0, [r8, #4]
	tst r0, #3
	beq _0215C650
	mov r0, r8
	bl EnemyDiveBat__CreateChild
	cmp r0, #0
	beq _0215C650
	ldrb r1, [r0, #0x3c6]
	mov r0, r4
	strb r1, [r4, #0x3c6]
	bl EnemyDiveBat__Action_215C804
	add sp, sp, #0xc
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0215C650:
	mov r0, #0xff
	strb r0, [r4, #0x3c6]
_0215C658:
	bl AllocSndHandle
	str r0, [r4, #0x138]
	mov r0, r4
	bl EnemyDiveBat__Action_Init
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__Destructor(Task *task)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	ldr r1, [r0, #0x340]
	ldrh r1, [r1, #2]
	cmp r1, #0x15c
	bne _0215C6D4
	ldrb r3, [r0, #0x3c6]
	ldr r2, =_0218A35C
	ldr r1, [r2, r3, lsl #3]
	cmp r1, r0
	moveq r0, #0
	streq r0, [r2, r3, lsl #3]
	b _0215C6F0
_0215C6D4:
	ldrb r2, [r0, #0x3c6]
	cmp r2, #0xff
	ldrne r1, =0x0218A360
	ldrneb r0, [r1, r2, lsl #3]
	cmpne r0, #0
	subne r0, r0, #1
	strneb r0, [r1, r2, lsl #3]
_0215C6F0:
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__CreateChild(MapObject *mapObject)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	ldrh r3, [r0, #4]
	ldr r1, =0x0218A360
	and r2, r3, #3
	sub r2, r2, #1
	and r4, r2, #0xff
	ldrb r2, [r1, r4, lsl #3]
	cmp r2, #0
	bne _0215C748
	ldr r1, =_0218A35C
	ldr r1, [r1, r4, lsl #3]
	cmp r1, #0
	beq _0215C764
	ldr r1, [r1, #0x18]
	tst r1, #4
	bne _0215C764
_0215C748:
	cmp r2, #0x10
	addhs sp, sp, #0x14
	movhs r0, #0
	ldmhsia sp!, {r3, r4, pc}
	ldr r0, =_0218A35C
	ldr r0, [r0, r4, lsl #3]
	b _0215C7D4
_0215C764:
	ldrsb ip, [r0, #6]
	ldr r1, =_02188DA0
	ldr r2, =0x02188DA2
	str ip, [sp]
	ldrsb lr, [r0, #7]
	mov ip, r4, lsl #2
	str lr, [sp, #4]
	ldrb lr, [r0, #8]
	str lr, [sp, #8]
	ldrb lr, [r0, #9]
	mov r0, #0x15c
	str lr, [sp, #0xc]
	str r4, [sp, #0x10]
	ldrh r1, [r1, ip]
	ldrh r2, [r2, ip]
	bl GameObject__SpawnObject
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r3, r4, pc}
	ldr r1, =_0218A35C
	ldr r2, =0x0218A362
	str r0, [r1, r4, lsl #3]
	mov ip, r4, lsl #3
	mov r3, #0
	ldr r1, =0x0218A361
	strh r3, [r2, ip]
	strb r3, [r1, r4, lsl #3]
_0215C7D4:
	ldr r2, =0x0218A360
	ldrb r1, [r2, r4, lsl #3]
	add r1, r1, #1
	strb r1, [r2, r4, lsl #3]
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__Action_215C804(EnemyDiveBat *work){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldr r2, =EnemyDiveBat__Draw
	ldr r1, =EnemyDiveBat__State_215C820
	str r2, [r0, #0xfc]
	str r1, [r0, #0xf4]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__State_215C820(EnemyDiveBat *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r5, r0
	ldrb r2, [r5, #0x3c6]
	ldr r1, =_0218A35C
	ldr r4, [r1, r2, lsl #3]
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, =0x0218A361
	ldrb r1, [r1, r2, lsl #3]
	tst r1, #1
	beq _0215C860
	bl EnemyDiveBat__Action_215CC38
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0215C860:
	ldr r1, [r4, #0x44]
	ldr r0, [r4, #0x3ac]
	ldr r2, [r5, #0x3ac]
	sub r0, r1, r0
	add r0, r2, r0
	str r0, [r5, #0x44]
	ldr r1, [r4, #0x48]
	ldr r0, [r4, #0x3b0]
	ldr r2, [r5, #0x3b0]
	sub r0, r1, r0
	add r0, r2, r0
	str r0, [r5, #0x48]
	ldr r0, [r4, #0x20]
	add r8, r4, #0x218
	bic r0, r0, #0x20
	orr r0, r0, #0x1000
	str r0, [r5, #0x20]
	add r7, r5, #0x218
	ldmia r8!, {r0, r1, r2, r3}
	stmia r7!, {r0, r1, r2, r3}
	ldmia r8!, {r0, r1, r2, r3}
	stmia r7!, {r0, r1, r2, r3}
	ldmia r8!, {r0, r1, r2, r3}
	stmia r7!, {r0, r1, r2, r3}
	ldmia r8, {r0, r1, r2, r3}
	stmia r7, {r0, r1, r2, r3}
	add r6, r4, #0x258
	add lr, r5, #0x258
	ldmia r6!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1, r2, r3}
	stmia lr, {r0, r1, r2, r3}
	ldr ip, =EnemyDiveBat__State_215C9D8
	ldr r0, [r4, #0xf4]
	cmp r0, ip
	ldreq r0, [r4, #0x28]
	cmpeq r0, #0
	bne _0215C914
	mov r0, r5
	add r1, r5, #0x364
	bl StageTask__HandleCollider
_0215C914:
	ldr r0, [r4, #0x20]
	tst r0, #8
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r1, #0
	mov r0, #0x89
	str r1, [sp]
	sub r1, r0, #0x8a
	str r0, [sp, #4]
	ldr r0, [r5, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r5, #0x138]
	add r1, r5, #0x44
	bl ProcessSpatialSfx
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__Draw(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldrb r2, [r0, #0x3c6]
	ldr r1, =_0218A35C
	ldr r1, [r1, r2, lsl #3]
	ldr r1, [r1, #0x128]
	bl StageTask__Draw2D
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__Action_Init(EnemyDiveBat *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	mov r1, #0
	orr r0, r0, #4
	str r0, [r4, #0x20]
	tst r0, #1
	mov r0, #0x1000
	rsbeq r0, r0, #0
	str r0, [r4, #0x98]
	str r1, [r4, #0x9c]
	str r1, [r4, #0xc8]
	ldr r0, =EnemyDiveBat__State_215C9D8
	str r1, [r4, #0x2c]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__State_215C9D8(EnemyDiveBat *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, [r5, #0x340]
	mov r4, #0
	ldrh r0, [r0, #2]
	cmp r0, #0x15c
	bne _0215CA64
	ldrb r1, [r5, #0x3c6]
	ldr r0, =0x0218A360
	ldrb r0, [r0, r1, lsl #3]
	mov r2, r1, lsl #3
	cmp r0, #0
	bne _0215CA24
	ldr r0, [r5, #0x18]
	add sp, sp, #8
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
_0215CA24:
	ldr r1, =0x0218A362
	ldrsh r0, [r1, r2]
	cmp r0, #0
	beq _0215CA9C
	sub r0, r0, #1
	strh r0, [r1, r2]
	ldrb r0, [r5, #0x3c6]
	mov r2, r0, lsl #3
	ldrsh r0, [r1, r2]
	cmp r0, #0
	bne _0215CA9C
	ldr r1, =0x0218A361
	ldrb r0, [r1, r2]
	orr r0, r0, #1
	strb r0, [r1, r2]
	b _0215CA9C
_0215CA64:
	ldr r0, [r5, #0x20]
	tst r0, #8
	beq _0215CA9C
	mov r0, #0x89
	str r4, [sp]
	sub r1, r0, #0x8a
	str r0, [sp, #4]
	ldr r0, [r5, #0x138]
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r5, #0x138]
	add r1, r5, #0x44
	bl ProcessSpatialSfx
_0215CA9C:
	ldr r0, [r5, #0x98]
	ldr r1, [r5, #0x44]
	cmp r0, #0
	bgt _0215CABC
	ldr r0, [r5, #0x3a4]
	cmp r1, r0
	movle r4, #1
	b _0215CAC8
_0215CABC:
	ldr r0, [r5, #0x3a8]
	cmp r1, r0
	movge r4, #1
_0215CAC8:
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #3
	bne _0215CB54
	ldr r0, [r5, #0x3c0]
	ldr r2, =0x00196225
	ldr r3, =0x3C6EF35F
	ldr r1, =0x00001FFF
	mla ip, r0, r2, r3
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	str ip, [r5, #0x3c0]
	and r0, r1, r0, lsr #16
	str r0, [r5, #0x2c]
	ldr r0, [r5, #0x3c0]
	mla r1, r0, r2, r3
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r5, #0x3c0]
	tst r0, #1
	ldrne r0, [r5, #0x2c]
	rsbne r0, r0, #0
	strne r0, [r5, #0x2c]
	ldr r2, [r5, #0x3b0]
	ldr r1, [r5, #0x48]
	sub r0, r2, #0x8000
	cmp r1, r0
	ldrle r0, =0x00001FFF
	strle r0, [r5, #0x2c]
	ble _0215CB54
	add r0, r2, #0x8000
	cmp r1, r0
	ldrge r0, =0xFFFFE001
	strge r0, [r5, #0x2c]
_0215CB54:
	mov r0, #0x400
	str r0, [sp]
	ldr r0, [r5, #0x9c]
	ldr r1, [r5, #0x2c]
	mov r2, #1
	mov r3, #0
	bl ObjShiftSet
	str r0, [r5, #0x9c]
	ldr r0, [r5, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x15
	bne _0215CBB0
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0215CBA4
	subs r0, r0, #1
	str r0, [r5, #0x28]
	ldreq r0, [r5, #0x37c]
	orreq r0, r0, #4
	streq r0, [r5, #0x37c]
_0215CBA4:
	mov r0, r5
	add r1, r5, #0x364
	bl StageTask__HandleCollider
_0215CBB0:
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl EnemyDiveBat__Action_215CBEC
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__Action_215CBEC(EnemyDiveBat *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r1, #2
	mov r4, r0
	bl GameObject__SetAnimation
	mov r1, #0
	str r1, [r4, #0x9c]
	ldr r0, =EnemyDiveBat__State_215CC18
	str r1, [r4, #0x98]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__State_215CC18(EnemyDiveBat *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x20]
	tst r1, #8
	ldmeqia sp!, {r3, pc}
	eor r1, r1, #1
	str r1, [r0, #0x20]
	bl EnemyDiveBat__Action_Init
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__Action_215CC38(EnemyDiveBat *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r1, #1
	bl GameObject__SetAnimation
	ldr r1, [r4, #0x20]
	add r0, r4, #0x300
	orr r1, r1, #4
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x44]
	mov r2, #0x4000
	str r1, [r4, #0x3b4]
	ldr r3, [r4, #0x48]
	ldr r1, =EnemyDiveBat__State_215CD40
	str r3, [r4, #0x3b8]
	strh r2, [r0, #0xc4]
	str r1, [r4, #0xf4]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x15
	bne _0215CCF4
	ldrb r1, [r4, #0x3c6]
	cmp r1, #0xff
	beq _0215CCF4
	ldr r0, =0x0218A361
	mov r2, r1, lsl #3
	ldrb r0, [r0, r1, lsl #3]
	tst r0, #1
	ldreq r1, =0x0218A362
	ldreqsh r0, [r1, r2]
	cmpeq r0, #0
	moveq r0, #0x10
	streqh r0, [r1, r2]
	mov r0, #0
	str r0, [r4, #0xfc]
	ldr r2, [r4, #0x20]
	ldr r0, =0xFFFFEFDF
	ldr r1, =0x0218A360
	and r0, r2, r0
	str r0, [r4, #0x20]
	ldrb r2, [r4, #0x3c6]
	ldrb r0, [r1, r2, lsl #3]
	cmp r0, #0
	subne r0, r0, #1
	strneb r0, [r1, r2, lsl #3]
	mov r0, #0xff
	strb r0, [r4, #0x3c6]
_0215CCF4:
	mov r1, #0
	mov r0, #0x8a
	str r1, [sp]
	sub r1, r0, #0x8b
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

NONMATCH_FUNC void EnemyDiveBat__State_215CD40(EnemyDiveBat *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	add r3, r0, #0x300
	ldrh r1, [r3, #0xc4]
	add r1, r1, #0xc7
	add r1, r1, #0x100
	strh r1, [r3, #0xc4]
	ldrh r1, [r3, #0xc4]
	cmp r1, #0x8000
	bls _0215CD6C
	bl EnemyDiveBat__Action_215CE0C
	ldmia sp!, {r3, r4, r5, pc}
_0215CD6C:
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	ldr lr, =FX_SinCosTable_
	mov r1, r1, lsl #1
	ldrsh ip, [lr, r1]
	ldr r1, =0x000038E3
	mov r2, #0
	umull r5, r4, ip, r1
	mla r4, ip, r2, r4
	mov ip, ip, asr #0x1f
	adds r5, r5, #0x800
	mla r4, ip, r1, r4
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	str r5, [r0, #0x98]
	ldrh r3, [r3, #0xc4]
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r3, [lr, r3]
	umull lr, ip, r3, r1
	mla ip, r3, r2, ip
	mov r2, r3, asr #0x1f
	mla ip, r2, r1, ip
	adds lr, lr, #0x800
	adc r1, ip, #0
	mov r2, lr, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x9c]
	ldr r1, [r0, #0x20]
	tst r1, #1
	ldrne r1, [r0, #0x98]
	rsbne r1, r1, #0
	strne r1, [r0, #0x98]
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__Action_215CE0C(EnemyDiveBat *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl GameObject__SetAnimation
	ldr r0, [r4, #0x20]
	mov r1, #0
	orr r0, r0, #4
	str r0, [r4, #0x20]
	str r1, [r4, #0x2c]
	str r1, [r4, #0x3bc]
	str r1, [r4, #0x9c]
	ldr r0, =EnemyDiveBat__State_215CE4C
	str r1, [r4, #0x98]
	str r0, [r4, #0xf4]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__State_215CE4C(EnemyDiveBat *work)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r2, [r4, #0x3b0]
	ldr r3, [r4, #0x48]
	sub r1, r2, #0x8000
	cmp r3, r1
	blt _0215CE84
	add r1, r2, #0x8000
	cmp r3, r1
	bgt _0215CE84
	bl EnemyDiveBat__Action_Init
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
_0215CE84:
	ldr r0, [r4, #0x3b8]
	ldr r2, [r4, #0x3b4]
	ldr r1, [r4, #0x44]
	sub r0, r0, r3
	sub r1, r2, r1
	bl FX_Atan2Idx
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #4
	mov r3, r0, lsl #1
	add r0, r3, #1
	ldr r1, =FX_SinCosTable_
	mov r2, r0, lsl #1
	mov r0, r3, lsl #1
	ldrsh r3, [r1, r2]
	ldrsh r2, [r1, r0]
	mov r0, #0x800
	mov r1, r3, asr #0x1f
	mov ip, r1, lsl #0xd
	mov r1, r2, asr #0x1f
	adds lr, r0, r3, lsl #13
	orr ip, ip, r3, lsr #19
	mov r1, r1, lsl #0xd
	adc ip, ip, #0
	mov lr, lr, lsr #0xc
	adds r3, r0, r2, lsl #13
	orr r1, r1, r2, lsr #19
	orr lr, lr, ip, lsl #20
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	str lr, [r4, #0x98]
	orr r1, r1, r0, lsl #20
	ldr r0, =playerGameStatus
	str r1, [r4, #0x9c]
	ldr r0, [r0, #0xc]
	tst r0, #3
	bne _0215CF44
	ldr r3, [r4, #0x3c0]
	ldr r0, =0x00196225
	ldr r1, =0x3C6EF35F
	ldr r2, =0x00001FFF
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	and r0, r2, r0, lsr #16
	str r1, [r4, #0x3c0]
	rsb r0, r0, #0
	str r0, [r4, #0x2c]
_0215CF44:
	mov r0, #0x400
	str r0, [sp]
	ldr r0, [r4, #0x3bc]
	ldr r1, [r4, #0x2c]
	mov r2, #1
	mov r3, #0
	bl ObjShiftSet
	str r0, [r4, #0x3bc]
	ldr r1, [r4, #0x9c]
	add r0, r1, r0
	str r0, [r4, #0x9c]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void EnemyDiveBat__OnDefend(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r2, [r1, #0x1c]
	ldr r1, [r0, #0x1c]
	ldr r0, [r2, #0x18]
	tst r0, #2
	ldmneia sp!, {r3, pc}
	ldrh r0, [r1]
	cmp r0, #1
	ldreqb r0, [r1, #0x5d1]
	cmpeq r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #0x3c
	str r0, [r2, #0x28]
	ldr r1, [r2, #0x37c]
	mov r0, r2
	bic r1, r1, #4
	str r1, [r2, #0x37c]
	bl EnemyDiveBat__Action_215CC38
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}
