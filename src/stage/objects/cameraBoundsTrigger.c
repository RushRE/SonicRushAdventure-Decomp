#include <stage/objects/cameraBoundsTrigger.h>
#include <game/object/objectManager.h>
#include <game/stage/gameSystem.h>

// --------------------
// VARIABLES
// --------------------

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC CameraBoundsTrigger *CameraBoundsTrigger__Create(MapObject *mapObject, fx32 x, fx32 y, fx32 type)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r4, r0
	mov r7, r1
	mov r6, r2
	mov r2, #0
	str r3, [sp]
	mov r5, #2
	str r5, [sp, #4]
	mov r5, #0x39c
	ldr r0, =StageTask_Main
	ldr r1, =GameObject__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	mov r5, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r5, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	mov r0, r5
	bl GetTaskWork_
	mov r5, r0
	mov r1, #0
	mov r2, #0x39c
	bl MI_CpuFill8
	mov r0, r5
	mov r1, r4
	mov r2, r7
	mov r3, r6
	bl GameObject__InitFromObject
	ldr r1, [r5, #0x1c]
	ldr r0, =mapCamera
	orr r1, r1, #0x2100
	str r1, [r5, #0x1c]
	ldr r1, [r5, #0x20]
	orr r1, r1, #0x20
	str r1, [r5, #0x20]
	ldr r0, [r0, #0xe0]
	tst r0, #1
	moveq r2, #2
	beq _02168704
	mov r2, #1
	sub r0, r2, #2
	strb r0, [r5, #0x398]
_02168704:
	cmp r2, #0
	mov r1, #0
	ble _0216879C
	ldr r3, =mapCamera
	ldr r0, =CameraBoundsTrigger__CameraState_ApplyBounds
	add ip, r5, #0x364
_0216871C:
	ldrsb r6, [r3, #0x46]
	add r1, r1, #1
	cmp r1, r2
	strb r6, [ip, #0x18]
	str r0, [ip, #0x14]
	ldrsb r7, [r4, #6]
	ldr r8, [r5, #0x44]
	ldr r6, [r3, #0x24]
	mla r6, r7, r6, r8
	str r6, [ip, #4]
	ldrsb r7, [r4, #7]
	ldr r8, [r5, #0x48]
	ldr r6, [r3, #0x28]
	mla r6, r7, r6, r8
	str r6, [ip, #8]
	ldrsb r7, [r4, #6]
	ldrb r6, [r4, #8]
	ldr lr, [r5, #0x44]
	ldr r8, [r3, #0x24]
	add r6, r7, r6
	mla r6, r8, r6, lr
	str r6, [ip, #0xc]
	ldr lr, [r3, #0x28]
	ldrsb r7, [r4, #7]
	ldrb r6, [r4, #9]
	ldr r8, [r5, #0x48]
	add r3, r3, #0x70
	add r6, r7, r6
	mla r6, lr, r6, r8
	str r6, [ip, #0x10]
	add ip, ip, #0x1c
	blt _0216871C
_0216879C:
	ldr r1, =CameraBoundsTrigger__State_Active
	mov r0, r5
	str r1, [r5, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CameraBoundsTrigger__State_Active(CameraBoundsTrigger *work)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x378]
	cmp r2, #0
	beq _021687E0
	mov r1, #0
	blx r2
_021687E0:
	ldr r2, [r4, #0x394]
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #1
	blx r2
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CameraBoundsTrigger__CameraState_ApplyBounds(CameraBoundsTrigger *work, s32 id)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r2, #0x1c
	mul lr, r1, r2
	add r4, r0, #0x364
	ldr r3, [r4, lr]
	ldr ip, =mapCamera
	mov r0, #0x70
	mla r2, r1, r0, ip
	tst r3, #1
	add r0, r4, lr
	beq _02168860
	ldrsb r1, [r2, #0x68]
	sub r1, r1, #1
	strb r1, [r2, #0x68]
	ldrsb r1, [r2, #0x68]
	cmp r1, #0
	bne _02168860
	ldr r1, [ip, #0x130]
	str r1, [r2, #0x58]
	ldr r1, [r2, #0]
	bic r1, r1, #0x10
	str r1, [r2]
	ldr r1, [r0, #0]
	bic r1, r1, #1
	str r1, [r0]
_02168860:
	ldr r1, [r0, #0]
	tst r1, #2
	beq _021688A8
	ldrsb r1, [r2, #0x69]
	sub r1, r1, #1
	strb r1, [r2, #0x69]
	ldrsb r1, [r2, #0x69]
	cmp r1, #0
	bne _021688A8
	ldr r1, =mapCamera
	ldr r1, [r1, #0x134]
	str r1, [r2, #0x5c]
	ldr r1, [r2, #0]
	bic r1, r1, #0x20
	str r1, [r2]
	ldr r1, [r0, #0]
	bic r1, r1, #2
	str r1, [r0]
_021688A8:
	ldr r1, [r0, #0]
	tst r1, #4
	beq _021688F0
	ldrsb r1, [r2, #0x6a]
	sub r1, r1, #1
	strb r1, [r2, #0x6a]
	ldrsb r1, [r2, #0x6a]
	cmp r1, #0
	bne _021688F0
	ldr r1, =mapCamera
	ldr r1, [r1, #0x138]
	str r1, [r2, #0x60]
	ldr r1, [r2, #0]
	bic r1, r1, #0x10
	str r1, [r2]
	ldr r1, [r0, #0]
	bic r1, r1, #4
	str r1, [r0]
_021688F0:
	ldr r1, [r0, #0]
	tst r1, #8
	beq _02168938
	ldrsb r1, [r2, #0x6b]
	sub r1, r1, #1
	strb r1, [r2, #0x6b]
	ldrsb r1, [r2, #0x6b]
	cmp r1, #0
	bne _02168938
	ldr r1, =mapCamera
	ldr r1, [r1, #0x13c]
	str r1, [r2, #0x64]
	ldr r1, [r2, #0]
	bic r1, r1, #0x20
	str r1, [r2]
	ldr r1, [r0, #0]
	bic r1, r1, #8
	str r1, [r0]
_02168938:
	ldr r1, =CameraBoundsTrigger__CameraState_Idle
	str r1, [r0, #0x14]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CameraBoundsTrigger__CameraState_Idle(CameraBoundsTrigger *work, s32 id)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl CameraBoundsTrigger__Func_2168BC0
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl CameraBoundsTrigger__Func_2168974
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CameraBoundsTrigger__Func_2168974(CameraBoundsTrigger *work, s32 id)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	ldr r3, [r0, #0x340]
	ldr lr, =mapCamera
	mov r2, #0x70
	ldrh ip, [r3, #4]
	add r4, r0, #0x364
	mov r0, #0x1c
	mla r0, r1, r0, r4
	mla r2, r1, r2, lr
	tst ip, #1
	beq _021689C0
	ldr r1, [r0, #4]
	str r1, [r2, #0x58]
	ldrsb r1, [r2, #0x68]
	add r1, r1, #1
	strb r1, [r2, #0x68]
	ldr r1, [r0, #0]
	orr r1, r1, #1
	str r1, [r0]
_021689C0:
	ldrh r1, [r3, #4]
	tst r1, #4
	beq _021689EC
	ldr r1, [r0, #0xc]
	str r1, [r2, #0x60]
	ldrsb r1, [r2, #0x6a]
	add r1, r1, #1
	strb r1, [r2, #0x6a]
	ldr r1, [r0, #0]
	orr r1, r1, #4
	str r1, [r0]
_021689EC:
	ldr r1, =mapCamera
	ldr r1, [r1, #0xe0]
	tst r1, #1
	beq _02168B2C
	tst r1, #2
	ldrh r1, [r3, #4]
	beq _02168A9C
	tst r1, #2
	beq _02168A50
	ldr r1, [r2, #8]
	ldr ip, [r0, #8]
	sub r1, r1, #0x110000
	cmp r1, ip
	addge r1, ip, #0x110000
	strge r1, [r2, #0x5c]
	bge _02168A38
	ldr r1, [r2, #0]
	orr r1, r1, #0x20
	str r1, [r2]
_02168A38:
	ldrsb r1, [r2, #0x69]
	add r1, r1, #1
	strb r1, [r2, #0x69]
	ldr r1, [r0, #0]
	orr r1, r1, #2
	str r1, [r0]
_02168A50:
	ldrh r1, [r3, #4]
	tst r1, #8
	beq _02168B84
	ldr r1, [r2, #8]
	ldr r3, [r0, #0x10]
	add r1, r1, #0xc0000
	cmp r1, r3
	strle r3, [r2, #0x64]
	ble _02168A80
	ldr r1, [r2, #0]
	orr r1, r1, #0x20
	str r1, [r2]
_02168A80:
	ldrsb r1, [r2, #0x6b]
	add r1, r1, #1
	strb r1, [r2, #0x6b]
	ldr r1, [r0, #0]
	orr r1, r1, #8
	str r1, [r0]
	b _02168B84
_02168A9C:
	tst r1, #2
	beq _02168ADC
	ldr ip, [r0, #8]
	ldr r1, [r2, #8]
	cmp r1, ip
	strge ip, [r2, #0x5c]
	bge _02168AC4
	ldr r1, [r2, #0]
	orr r1, r1, #0x20
	str r1, [r2]
_02168AC4:
	ldrsb r1, [r2, #0x69]
	add r1, r1, #1
	strb r1, [r2, #0x69]
	ldr r1, [r0, #0]
	orr r1, r1, #2
	str r1, [r0]
_02168ADC:
	ldrh r1, [r3, #4]
	tst r1, #8
	beq _02168B84
	ldr r1, [r2, #8]
	ldr r3, [r0, #0x10]
	add r1, r1, #0x1d0000
	cmp r1, r3
	suble r1, r3, #0x1d0000
	strle r1, [r2, #0x64]
	ble _02168B10
	ldr r1, [r2, #0]
	orr r1, r1, #0x20
	str r1, [r2]
_02168B10:
	ldrsb r1, [r2, #0x6b]
	add r1, r1, #1
	strb r1, [r2, #0x6b]
	ldr r1, [r0, #0]
	orr r1, r1, #8
	str r1, [r0]
	b _02168B84
_02168B2C:
	ldrh r1, [r3, #4]
	tst r1, #2
	beq _02168B58
	ldr r1, [r0, #8]
	str r1, [r2, #0x5c]
	ldrsb r1, [r2, #0x69]
	add r1, r1, #1
	strb r1, [r2, #0x69]
	ldr r1, [r0, #0]
	orr r1, r1, #2
	str r1, [r0]
_02168B58:
	ldrh r1, [r3, #4]
	tst r1, #8
	beq _02168B84
	ldr r1, [r0, #0x10]
	str r1, [r2, #0x64]
	ldrsb r1, [r2, #0x6b]
	add r1, r1, #1
	strb r1, [r2, #0x6b]
	ldr r1, [r0, #0]
	orr r1, r1, #8
	str r1, [r0]
_02168B84:
	ldr r1, =CameraBoundsTrigger__UnknownState_2168B98
	str r1, [r0, #0x14]
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CameraBoundsTrigger__UnknownState_2168B98(CameraBoundsTrigger *work, s32 id)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl CameraBoundsTrigger__Func_2168BC0
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl CameraBoundsTrigger__CameraState_ApplyBounds
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void CameraBoundsTrigger__Func_2168BC0(CameraBoundsTrigger *work, s32 id)
{
#ifdef NON_MATCHING

#else
// clang-format off
	stmdb sp!, {r4, lr}
	mov r2, #0x1c
	mla r3, r1, r2, r0
	add r1, r3, #0x300
	ldrsb r4, [r1, #0x7c]
	sub r1, r2, #0x1d
	ldr r2, [r0, #0x340]
	cmp r4, r1
	mov r3, #0
	beq _02168C70
	ldr r1, =gPlayerList
	ldrsb ip, [r2, #6]
	ldr r1, [r1, r4, lsl #2]
	ldr r4, [r0, #0x44]
	ldr lr, [r1, #0x44]
	add r4, r4, ip, lsl #12
	cmp r4, lr
	bgt _02168C70
	ldrb ip, [r2, #8]
	add ip, r4, ip, lsl #12
	cmp ip, lr
	blt _02168C70
	ldrsb lr, [r2, #7]
	ldr r0, [r0, #0x48]
	ldr ip, [r1, #0x48]
	add lr, r0, lr, lsl #12
	cmp lr, ip
	bgt _02168C70
	ldrb r0, [r2, #9]
	add r0, lr, r0, lsl #12
	cmp r0, ip
	blt _02168C70
	ldr r0, [r1, #0x18]
	ands r1, r0, #1
	bne _02168C58
	ldrh r0, [r2, #4]
	tst r0, #0x10
	bne _02168C6C
_02168C58:
	cmp r1, #0
	beq _02168C70
	ldrh r0, [r2, #4]
	tst r0, #0x20
	beq _02168C70
_02168C6C:
	mov r3, #1
_02168C70:
	mov r0, r3
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}