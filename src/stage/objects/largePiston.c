#include <stage/objects/largePiston.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>
#include <stage/effects/piston.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *LargePiston__unknown2Table;
NOT_DECOMPILED void *LargePiston__unknownTable;

NOT_DECOMPILED void *aModGmkLPistonN;
NOT_DECOMPILED void *aActAcGmkLPisto;

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC LargePiston *LargePiston__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x48
	mov r7, r0
	ldrsb r9, [r7, #6]
	mov r10, r1
	mov r11, r2
	cmp r9, #0
	movlt r9, #0
	blt _0216765C
	cmp r9, #3
	movgt r9, #3
_0216765C:
	mov r0, #0x1800
	str r0, [sp]
	mov r0, #2
	mov r5, r9, lsl #5
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, =0x00000588
	add r8, r5, #0xa0
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	mov r6, r8, lsl #0xb
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0x48
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, =0x00000588
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r2, r10
	mov r3, r11
	mov r0, r4
	mov r1, r7
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xbb
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	bl GetObjectFileWork
	str r0, [sp]
	ldr r1, =gameArchiveStage
	mov r0, r4
	ldr r2, [r1, #0]
	add r1, r4, #0x364
	str r2, [sp, #4]
	ldr r2, =aModGmkLPistonN
	mov r3, #0
	bl ObjAction3dNNModelLoad
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x200
	str r0, [r4, #0x20]
	ldrh r0, [r7, #2]
	add r0, r0, #0x55
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _021677E0
	mov r0, #0xbc
	bl GetObjectFileWork
	ldr r1, =gameArchiveStage
	mov r3, r0
	ldr r1, [r1, #0]
	ldr r2, =aActAcGmkLPisto
	mov r0, r4
	str r1, [sp]
	mov r1, #0
	str r1, [sp, #4]
	add r1, r4, #0x168
	bl ObjObjectAction2dBACLoad
	mov r0, #0xbd
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r4
	mov r1, #0x24
	bl ObjObjectActionAllocSprite
	mov r0, #0xbd
	bl GetObjectFileWork
	ldrh r0, [r0, #4]
	bic r0, r0, #0x8000
	cmp r0, #1
	ble _021677AC
	ldr r1, [r4, #0x128]
	ldr r0, [r1, #0x3c]
	orr r0, r0, #8
	str r0, [r1, #0x3c]
_021677AC:
	mov r0, r4
	mov r1, #0
	mov r2, #0x36
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
_021677E0:
	mov r10, #0x10
	str r4, [r4, #0x234]
	add r0, r4, #0x218
	sub r1, r10, #0x18
	sub r2, r10, #0x20
	mov r3, #0x18
	str r10, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =LargePiston__OnDefend_2168194
	add r0, r4, #0x258
	str r1, [r4, #0x23c]
	ldr r2, [r4, #0x230]
	mov r1, #0
	orr r2, r2, #0x400
	str r2, [r4, #0x230]
	str r4, [r4, #0x274]
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x258
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, =LargePiston__OnDefend_2168300
	add r0, r4, #0x298
	str r1, [r4, #0x27c]
	ldr r2, [r4, #0x270]
	mov r1, #0
	orr r2, r2, #0x400
	str r2, [r4, #0x270]
	str r4, [r4, #0x2b4]
	mov r2, r1
	bl ObjRect__SetAttackStat
	add r0, r4, #0x298
	ldr r1, =0x0000FFFE
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, =LargePiston__OnDefend_21683F0
	str r0, [r4, #0x2bc]
	ldr r0, [r4, #0x2b0]
	orr r0, r0, #0x400
	str r0, [r4, #0x2b0]
	ldrh r0, [r7, #2]
	cmp r0, #0x58
	bne _02167924
	mov r8, r8, asr #1
	add r0, r8, #0x20
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	mov r5, #0x90
	sub r1, r5, #0xa0
	str r0, [sp]
	mov r0, r10
	str r0, [sp, #4]
	str r5, [sp, #8]
	mov r2, r1
	add r0, r4, #0x258
	mov r3, #0x70
	mov r5, #0
	bl ObjRect__SetBox3D
	add r0, r8, #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	mov r8, #0x47
	sub r1, r8, #0x57
	str r0, [sp]
	mov r0, r10
	str r0, [sp, #4]
	mov r2, r1
	add r0, r4, #0x298
	mov r3, #0x27
	str r8, [sp, #8]
	bl ObjRect__SetBox3D
	b _02167A40
_02167924:
	cmp r0, #0xab
	add r0, r5, #0xc0
	mov r11, #0x90
	bne _021679BC
	mov r1, r0, asr #1
	mov r5, #1
	mov r0, r9, lsl #5
	rsb r8, r1, #0x20
	add r2, r0, #0xc0
	sub r0, r5, #0x21
	sub r3, r5, #0x81
	sub r10, r0, r2, asr #1
	mov r1, r8, lsl #0x10
	mov r2, r10, lsl #0x10
	str r3, [sp]
	mov r0, r1, asr #0x10
	str r0, [sp, #4]
	add r0, r4, #0x258
	sub r1, r11, #0x130
	mov r2, r2, asr #0x10
	mov r3, #0x70
	str r11, [sp, #8]
	bl ObjRect__SetBox3D
	add r0, r8, r9, lsl #2
	mov r0, r0, lsl #0x10
	mvn r1, #0x1f
	mov r2, r10, lsl #0x10
	mov r8, #0x47
	str r1, [sp]
	mov r0, r0, asr #0x10
	str r0, [sp, #4]
	add r0, r4, #0x298
	sub r1, r8, #0xe7
	mov r2, r2, asr #0x10
	mov r3, #0x27
	str r8, [sp, #8]
	bl ObjRect__SetBox3D
	b _02167A40
_021679BC:
	mov r1, r0, asr #1
	mov r0, r9, lsl #5
	rsb r8, r1, #0x20
	mov r3, #0xa0
	str r3, [sp]
	mov r5, #2
	add r2, r0, #0xc0
	sub r0, r5, #0x22
	sub r10, r0, r2, asr #1
	mov r1, r8, lsl #0x10
	mov r0, r1, asr #0x10
	str r0, [sp, #4]
	mov r2, r10, lsl #0x10
	add r0, r4, #0x258
	mov r2, r2, asr #0x10
	mov r1, #0x80
	mov r3, #0x70
	str r11, [sp, #8]
	bl ObjRect__SetBox3D
	add r0, r8, r9, lsl #2
	mov r0, r0, lsl #0x10
	mov r2, #0xa0
	mov r1, r10, lsl #0x10
	str r2, [sp]
	mov r0, r0, asr #0x10
	str r0, [sp, #4]
	mov r8, #0x47
	mov r2, r1, asr #0x10
	add r0, r4, #0x298
	mov r1, #0x20
	mov r3, #0x27
	str r8, [sp, #8]
	bl ObjRect__SetBox3D
_02167A40:
	mov r0, #0x60
	mul r0, r5, r0
	ldr r1, =LargePiston__Draw
	ldr r3, =LargePiston__unknownTable
	str r1, [r4, #0xfc]
	ldr r9, =LargePiston__State_2167CBC
	add r1, r4, #0x11c
	str r9, [r4, #0xf4]
	add r11, r3, r0
	ldr r10, =0x021891F0
	add lr, r1, #0x400
	add r1, r10, r0
	ldr ip, =0x02189214
	ldr r9, =0x021891FC
	str r1, [sp, #0x14]
	add r1, r9, r0
	add ip, ip, r0
	add r3, r4, #0x134
	str r1, [sp, #0x18]
	add r1, r3, #0x400
	str r1, [sp, #0x1c]
	ldr r1, =0x02189208
	add r2, r4, #0x128
	add r1, r1, r0
	str r1, [sp, #0x20]
	add r1, r4, #0x4e0
	str r1, [sp, #0x10]
	add r1, r4, #0x540
	str r1, [sp, #0x24]
	add r1, r4, #0x14c
	add r1, r1, #0x400
	str r1, [sp, #0x28]
	ldr r1, =0x02189220
	str ip, [sp, #0xc]
	add ip, r2, #0x400
	add r1, r1, r0
	add r8, r4, #0xec
	add r2, r4, #0x158
	str r1, [sp, #0x2c]
	add r1, r2, #0x400
	str r1, [sp, #0x30]
	ldr r1, =0x0218922C
	add r2, r4, #0x164
	add r1, r1, r0
	str r1, [sp, #0x34]
	add r1, r2, #0x400
	ldr r2, =0x02189238
	str r1, [sp, #0x38]
	add r0, r2, r0
	str r0, [sp, #0x3c]
	mov r0, #0xc
	mul r3, r5, r0
	ldr r0, =LargePiston__unknown2Table
	add r1, r4, #0x570
	add r8, r8, #0x400
	str r1, [sp, #0x40]
	add r10, r0, r3
	ldmia r11, {r0, r1, r2}
	stmia r8, {r0, r1, r2}
	ldr r0, =0x021891C6
	ldr r5, [sp, #0x10]
	add r0, r0, r3
	str r0, [sp, #0x44]
	ldr r0, [sp, #0xc]
	add r9, r4, #0x500
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldmia r11, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	ldr r0, [sp, #0x14]
	ldr r5, [sp, #0x1c]
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, [sp, #0x18]
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, [sp, #0x20]
	ldr r5, [sp, #0x24]
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, [sp, #0xc]
	ldr r5, [sp, #0x28]
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, [sp, #0x2c]
	ldr r5, [sp, #0x30]
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, [sp, #0x34]
	ldr r5, [sp, #0x38]
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, [sp, #0x3c]
	ldr r5, [sp, #0x40]
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, =LargePiston__unknown2Table
	ldrh r1, [r0, r3]
	ldrh r0, [r10, #2]
	strh r1, [r9, #0x7c]
	strh r0, [r9, #0x7e]
	ldrh r0, [r10, #4]
	strh r0, [r9, #0x80]
	ldr r0, =0x021891C6
	ldrh r1, [r0, r3]
	ldr r0, [sp, #0x44]
	ldrh r0, [r0, #2]
	strh r1, [r9, #0x82]
	strh r0, [r9, #0x84]
	ldr r0, [sp, #0x44]
	ldrh r0, [r0, #4]
	strh r0, [r9, #0x86]
	ldrh r0, [r7, #2]
	cmp r0, #0x58
	bne _02167C34
	ldr r0, [r8, #0]
	add r0, r0, r6
	str r0, [r8]
	ldr r0, [lr]
	add r0, r0, r6
	str r0, [lr]
	ldr r0, [ip]
	add r0, r0, r6
	str r0, [ip]
	b _02167C58
_02167C34:
	ldr r0, [r4, #0x4f0]
	sub r0, r0, r6, asr #1
	str r0, [r4, #0x4f0]
	ldr r0, [r4, #0x520]
	sub r0, r0, r6, asr #1
	str r0, [r4, #0x520]
	ldr r0, [r4, #0x52c]
	sub r0, r0, r6, asr #1
	str r0, [r4, #0x52c]
_02167C58:
	mov r0, r4
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void LargePiston__State_2167CBC(LargePiston *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x510]
	cmp r1, #0
	beq _02167CD4
	blx r1
_02167CD4:
	ldr r1, [r4, #0x514]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void LargePiston__State1_2167CEC(LargePiston *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x500
	ldrsh r1, [r0, #0x1a]
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	ldmia sp!, {r4, pc}
_02167D08: // jump table
	b _02167D18 // case 0
	b _02167DB0 // case 1
	b _02167E1C // case 2
	b _02167EB8 // case 3
_02167D18:
	ldr r0, [r4, #0x28]
	bl StageTask__DecrementBySpeed
	ldr r1, =playerGameStatus
	str r0, [r4, #0x28]
	ldr r0, [r1, #0xc]
	tst r0, #1
	beq _02167D90
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r0, [r3, #0]
	ldr r2, =0x3C6EF35F
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	sub r0, r0, #3
	str ip, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x4f8]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	sub r0, r0, #3
	str r1, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x4fc]
_02167D90:
	ldr r0, [r4, #0x28]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x500
	ldrsh r1, [r0, #0x1a]
	add r1, r1, #1
	strh r1, [r0, #0x1a]
	ldmia sp!, {r4, pc}
_02167DB0:
	ldr r2, [r4, #0x4e0]
	ldr r1, [r4, #0x564]
	add r1, r2, r1
	str r1, [r4, #0x4e0]
	ldr r2, [r4, #0x4e4]
	ldr r1, [r4, #0x568]
	add r1, r2, r1
	str r1, [r4, #0x4e4]
	ldr r2, [r4, #0x4e8]
	ldr r1, [r4, #0x56c]
	add r2, r2, r1
	str r2, [r4, #0x4e8]
	ldr r1, [r4, #0x560]
	cmp r2, r1
	ldmltia sp!, {r4, pc}
	ldr r2, [r4, #0x558]
	mov r1, #0x10
	str r2, [r4, #0x4e0]
	ldr r2, [r4, #0x55c]
	str r2, [r4, #0x4e4]
	ldr r2, [r4, #0x560]
	str r2, [r4, #0x4e8]
	ldrsh r2, [r0, #0x1a]
	add r2, r2, #1
	strh r2, [r0, #0x1a]
	str r1, [r4, #0x28]
	ldmia sp!, {r4, pc}
_02167E1C:
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #1
	beq _02167E88
	ldr r3, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r0, [r3, #0]
	ldr r2, =0x3C6EF35F
	mla ip, r0, r1, r2
	mov r0, ip, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	sub r0, r0, #3
	str ip, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x4f8]
	ldr r0, [r3, #0]
	mla r1, r0, r1, r2
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	sub r0, r0, #3
	str r1, [r3]
	mov r0, r0, lsl #0xc
	str r0, [r4, #0x4fc]
_02167E88:
	ldr r0, [r4, #0x28]
	subs r0, r0, #1
	str r0, [r4, #0x28]
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x500
	ldrsh r2, [r0, #0x1a]
	mov r1, #0
	add r2, r2, #1
	strh r2, [r0, #0x1a]
	str r1, [r4, #0x4f8]
	str r1, [r4, #0x4fc]
	ldmia sp!, {r4, pc}
_02167EB8:
	ldr r1, [r4, #0x4e0]
	ldr r0, [r4, #0x570]
	add r0, r1, r0
	str r0, [r4, #0x4e0]
	ldr r1, [r4, #0x4e4]
	ldr r0, [r4, #0x574]
	add r0, r1, r0
	str r0, [r4, #0x4e4]
	ldr r1, [r4, #0x4e8]
	ldr r0, [r4, #0x578]
	add r1, r1, r0
	str r1, [r4, #0x4e8]
	ldr r0, [r4, #0x554]
	cmp r1, r0
	ldmgtia sp!, {r4, pc}
	mov r0, #0
	str r0, [r4, #0x510]
	ldr r0, [r4, #0x54c]
	str r0, [r4, #0x4e0]
	ldr r0, [r4, #0x550]
	str r0, [r4, #0x4e4]
	ldr r0, [r4, #0x554]
	str r0, [r4, #0x4e8]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void LargePiston__State2_2167F28(LargePiston *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov r2, r0
	add r0, r2, #0x500
	ldrsh r0, [r0, #0x18]
	cmp r0, #0
	beq _02167F5C
	cmp r0, #1
	beq _0216804C
	cmp r0, #2
	beq _021680F4
	add sp, sp, #0xc
	ldmia sp!, {pc}
_02167F5C:
	ldr r1, [r2, #0x4ec]
	ldr r0, [r2, #0x534]
	add r0, r1, r0
	str r0, [r2, #0x4ec]
	ldr r1, [r2, #0x4f0]
	ldr r0, [r2, #0x538]
	add r0, r1, r0
	str r0, [r2, #0x4f0]
	ldr r1, [r2, #0x4f4]
	ldr r0, [r2, #0x53c]
	add r0, r1, r0
	str r0, [r2, #0x4f4]
	ldr r3, [r2, #0x524]
	ldr r1, [r2, #0x530]
	cmp r1, r3
	bge _02167FA8
	ldr r0, [r2, #0x4f4]
	cmp r0, r1
	ble _02167FBC
_02167FA8:
	cmp r1, r3
	ldrge r0, [r2, #0x4f4]
	cmpge r0, r1
	addlt sp, sp, #0xc
	ldmltia sp!, {pc}
_02167FBC:
	ldr r0, [r2, #0x528]
	add r1, r2, #0x17c
	str r0, [r2, #0x4ec]
	ldr r0, [r2, #0x52c]
	add r3, r2, #0x500
	str r0, [r2, #0x4f0]
	ldr r0, [r2, #0x530]
	mov ip, #0x10
	str r0, [r2, #0x4f4]
	ldrsh lr, [r3, #0x18]
	add r0, sp, #0
	add r1, r1, #0x400
	add lr, lr, #1
	strh lr, [r3, #0x18]
	str ip, [r2, #0x2c]
	ldr ip, [r2, #0x44]
	ldr r3, [r2, #0x4ec]
	ldr lr, [r2, #0x504]
	add r3, ip, r3
	add r3, lr, r3
	str r3, [sp]
	ldr ip, [r2, #0x48]
	ldr r3, [r2, #0x4f0]
	ldr lr, [r2, #0x508]
	add r3, ip, r3
	add r3, lr, r3
	str r3, [sp, #4]
	ldr ip, [r2, #0x4c]
	ldr r3, [r2, #0x4f4]
	ldr lr, [r2, #0x50c]
	add r2, ip, r3
	add r2, lr, r2
	str r2, [sp, #8]
	bl EffectPiston__Create
	add sp, sp, #0xc
	ldmia sp!, {pc}
_0216804C:
	ldr r0, =playerGameStatus
	ldr r0, [r0, #0xc]
	tst r0, #1
	beq _021680B8
	ldr ip, =_mt_math_rand
	ldr r1, =0x00196225
	ldr r0, [ip]
	ldr r3, =0x3C6EF35F
	mla lr, r0, r1, r3
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	sub r0, r0, #3
	str lr, [ip]
	mov r0, r0, lsl #0xd
	str r0, [r2, #0x504]
	ldr r0, [ip]
	mla r1, r0, r1, r3
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #7
	sub r0, r0, #3
	str r1, [ip]
	mov r0, r0, lsl #0xd
	str r0, [r2, #0x508]
_021680B8:
	ldr r0, [r2, #0x2c]
	sub r0, r0, #1
	cmp r0, #0
	str r0, [r2, #0x2c]
	addgt sp, sp, #0xc
	ldmgtia sp!, {pc}
	add r0, r2, #0x500
	ldrsh r3, [r0, #0x18]
	mov r1, #0
	add sp, sp, #0xc
	add r3, r3, #1
	strh r3, [r0, #0x18]
	str r1, [r2, #0x504]
	str r1, [r2, #0x508]
	ldmia sp!, {pc}
_021680F4:
	ldr r1, [r2, #0x4ec]
	ldr r0, [r2, #0x540]
	add r0, r1, r0
	str r0, [r2, #0x4ec]
	ldr r1, [r2, #0x4f0]
	ldr r0, [r2, #0x544]
	add r0, r1, r0
	str r0, [r2, #0x4f0]
	ldr r1, [r2, #0x4f4]
	ldr r0, [r2, #0x548]
	add r0, r1, r0
	str r0, [r2, #0x4f4]
	ldr r1, [r2, #0x524]
	ldr r3, [r2, #0x530]
	cmp r3, r1
	bge _02168140
	ldr r0, [r2, #0x4f4]
	cmp r0, r1
	bge _0216815C
_02168140:
	cmp r3, r1
	addlt sp, sp, #0xc
	ldmltia sp!, {pc}
	ldr r0, [r2, #0x4f4]
	cmp r0, r1
	addgt sp, sp, #0xc
	ldmgtia sp!, {pc}
_0216815C:
	mov r0, #0
	str r0, [r2, #0x514]
	ldr r0, [r2, #0x51c]
	str r0, [r2, #0x4ec]
	ldr r0, [r2, #0x520]
	str r0, [r2, #0x4f0]
	ldr r0, [r2, #0x524]
	str r0, [r2, #0x4f4]
	add sp, sp, #0xc
	ldmia sp!, {pc}

// clang-format on
#endif
}

NONMATCH_FUNC void LargePiston__OnDefend_2168194(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	ldr r1, [r4, #0x340]
	ldrsb r3, [r1, #6]
	cmp r3, #0
	movlt r3, #0
	blt _021681C0
	cmp r3, #3
	movgt r3, #3
_021681C0:
	cmp r4, #0
	cmpne r5, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, pc}
	ldrh r0, [r5, #0]
	cmp r0, #1
	ldreqb r0, [r5, #0x5d1]
	cmpeq r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, pc}
	ldrh r1, [r1, #2]
	cmp r1, #0x58
	bne _02168210
	mov r0, #0x1800
	mul r0, r3, r0
	add r2, r0, #0x7000
	mov ip, r3, lsl #0xc
	mov r3, #0
	mov r0, #0xc000
	b _0216822C
_02168210:
	mov ip, r3, lsl #0xc
	rsb r0, ip, #0
	sub r3, r0, #0x6800
	mov r2, #0xa000
	mov r0, #0x9000
	cmp r1, #0xab
	subeq r2, r0, #0x13000
_0216822C:
	str r0, [sp]
	mov r0, r5
	mov r1, r4
	str ip, [sp, #4]
	bl Player__Action_LargePiston1
	mov r0, #0x8000
	str r0, [r4, #0x28]
	add r1, r4, #0x14c
	add r0, r4, #0x500
	mov r2, #0
	strh r2, [r0, #0x1a]
	add r0, r1, #0x400
	add r3, r4, #0x4e0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, =LargePiston__State1_2167CEC
	add r1, r4, #0x82
	str r0, [r4, #0x510]
	ldr r2, [r4, #0x44]
	ldr r0, [r4, #0x4e0]
	ldr r3, [r4, #0x4f8]
	add r0, r2, r0
	add r0, r3, r0
	str r0, [sp, #8]
	ldr r2, [r4, #0x48]
	ldr r0, [r4, #0x4e4]
	ldr r3, [r4, #0x4fc]
	add r0, r2, r0
	add r0, r3, r0
	str r0, [sp, #0xc]
	ldr r2, [r4, #0x4c]
	ldr r0, [r4, #0x4e8]
	ldr r3, [r4, #0x500]
	add r0, r2, r0
	add r2, r3, r0
	add r0, sp, #8
	add r1, r1, #0x500
	str r2, [sp, #0x10]
	bl EffectPiston__Create
	mov r0, r5
	mov r1, r4
	bl Player__Action_AllowTrickCombos
	mov r0, #0
	str r0, [sp]
	mov r1, #0x56
	str r1, [sp, #4]
	sub r1, r1, #0x57
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void LargePiston__OnDefend_2168300(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r1, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	ldr lr, [r1, #0x340]
	ldrsb ip, [lr, #6]
	cmp ip, #0
	movlt ip, #0
	blt _0216832C
	cmp ip, #3
	movgt ip, #3
_0216832C:
	cmp r1, #0
	cmpne r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, pc}
	ldrh r2, [r0, #0]
	cmp r2, #1
	ldreqb r2, [r0, #0x5d1]
	cmpeq r2, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, pc}
	ldr r3, [r0, #0xf4]
	ldr r2, =Player__State_LargePiston1
	cmp r3, r2
	addne sp, sp, #8
	ldmneia sp!, {r3, pc}
	ldrh lr, [lr, #2]
	cmp lr, #0x58
	bne _02168390
	mov r2, #0x1800
	mul r2, ip, r2
	mov r3, #0
	add r2, r2, #0x7000
	sub lr, r3, #0x9000
	mov ip, ip, lsl #0xc
	b _021683BC
_02168390:
	mov ip, ip, lsl #0xc
	rsb r2, ip, #0
	sub r2, r2, #0x6800
	add r3, r2, r2, lsl #1
	mov r2, #0x7800
	mov r3, r3, lsl #0xa
	rsb r2, r2, #0
	cmp lr, #0xab
	sub lr, r2, #0x800
	mov r3, r3, asr #0xc
	moveq r2, #0x7800
_021683BC:
	str lr, [sp]
	str ip, [sp, #4]
	bl Player__Action_LargePiston2
	mov ip, #0x56
	sub r1, ip, #0x57
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add sp, sp, #8
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void LargePiston__OnDefend_21683F0(OBS_RECT_WORK *rect1, OBS_RECT_WORK *rect2)
{
#ifdef NON_MATCHING

#else
// clang-format off
	ldr r3, [r1, #0x1c]
	ldr r1, [r0, #0x1c]
	cmp r3, #0
	cmpne r1, #0
	bxeq lr
	ldrh r0, [r1, #0]
	cmp r0, #1
	ldreqb r0, [r1, #0x5d1]
	cmpeq r0, #0
	bxne lr
	ldr r1, [r1, #0xf4]
	ldr r0, =Player__State_LargePiston1
	cmp r1, r0
	ldreq r0, [r3, #0x514]
	cmpeq r0, #0
	bxne lr
	mov ip, #0
	add r1, r3, #0x11c
	add r2, r3, #0xec
	str ip, [r3, #0x2c]
	add r0, r3, #0x500
	strh ip, [r0, #0x18]
	add r0, r1, #0x400
	add ip, r2, #0x400
	ldmia r0, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, =LargePiston__State2_2167F28
	str r0, [r3, #0x514]
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void LargePiston__Draw(void)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r5, [r4, #0x12c]
	ldr r6, [r4, #0x128]
	ldr r1, [r4, #0x20]
	str r1, [sp, #0x10]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x58
	beq _021684B8
	orr r1, r1, #0x800
	str r1, [sp, #0x10]
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0xab
	orreq r0, r1, #1
	streq r0, [sp, #0x10]
_021684B8:
	add r0, r4, #0x44
	add r3, sp, #0x14
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x4e0]
	ldr r0, [r4, #0x4f8]
	ldr r2, [sp, #0x14]
	add r0, r1, r0
	add r0, r2, r0
	str r0, [sp, #0x14]
	ldr r1, [r4, #0x4e4]
	ldr r0, [r4, #0x4fc]
	ldr r2, [sp, #0x18]
	add r0, r1, r0
	add r0, r2, r0
	str r0, [sp, #0x18]
	ldr r1, [r4, #0x4e8]
	ldr r0, [r4, #0x500]
	ldr r2, [sp, #0x1c]
	add r0, r1, r0
	add r0, r2, r0
	str r0, [sp, #0x1c]
	ldr r1, =0x00003A13
	add r2, r4, #0x82
	str r1, [r4, #0x37c]
	str r1, [r4, #0x380]
	str r1, [r4, #0x384]
	add r0, sp, #0x10
	str r0, [sp]
	mov ip, #0
	str ip, [sp, #4]
	str ip, [sp, #8]
	mov r1, r3
	mov r0, r5
	str ip, [sp, #0xc]
	add r2, r2, #0x500
	add r3, r4, #0x38
	bl StageTask__Draw3DEx
	ldr r0, [r4, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x58
	beq _0216858C
	ldr r0, [r6, #0x64]
	mov r2, #0
	orr r1, r0, #1
	str r1, [r6, #0x64]
	add r0, sp, #0x10
	stmia sp, {r0, r2}
	add r1, sp, #0x14
	mov r0, r6
	mov r3, r2
	str r2, [sp, #8]
	bl StageTask__Draw2DEx
_0216858C:
	ldr r0, [r4, #0x4f4]
	cmp r0, #0xc0000
	addge sp, sp, #0x20
	ldmgeia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x44
	add r3, sp, #0x14
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r4, #0x4ec]
	ldr r0, [r4, #0x504]
	ldr r2, [sp, #0x14]
	add r0, r1, r0
	add r0, r2, r0
	str r0, [sp, #0x14]
	ldr r1, [r4, #0x4f0]
	ldr r0, [r4, #0x508]
	ldr r2, [sp, #0x18]
	add r0, r1, r0
	add r0, r2, r0
	str r0, [sp, #0x18]
	ldr r1, [r4, #0x4f4]
	ldr r0, [r4, #0x50c]
	ldr r2, [sp, #0x1c]
	add r0, r1, r0
	add r0, r2, r0
	str r0, [sp, #0x1c]
	ldr r1, =0x00002A3C
	add r2, r4, #0x17c
	str r1, [r4, #0x37c]
	str r1, [r4, #0x380]
	str r1, [r4, #0x384]
	add r0, sp, #0x10
	str r0, [sp]
	mov r6, #0
	str r6, [sp, #4]
	str r6, [sp, #8]
	mov r1, r3
	mov r0, r5
	add r2, r2, #0x400
	add r3, r4, #0x38
	str r6, [sp, #0xc]
	bl StageTask__Draw3DEx
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}