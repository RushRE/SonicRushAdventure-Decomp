	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailStylusPromptHUD__Create
SailStylusPromptHUD__Create: // 0x0218ABB0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	bl SailManager__GetWork
	ldr r0, _0218AC80 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x4a
	bl GetObjectFileWork
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0218AC00
	ldr r0, _0218AC84 // =aBbSbBb_1
	mov r1, #0x1a
	mov r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	mov r0, #0x4b
	bl GetObjectFileWork
	str r5, [r0]
_0218AC00:
	mov r0, #0x4b
	bl GetObjectFileWork
	mov r1, #0
	ldr ip, _0218AC88 // =0x0000FFFF
	mov r3, r0
	mov r0, r4
	mov r2, r1
	stmia sp, {r1, ip}
	bl ObjObjectAction2dBACLoad
	mov r0, r4
	mov r1, #0
	mov r2, #0x4b
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, #0
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0x1000
	bl SailObject__SetAnimSpeed
	mov r0, #0x26000
	str r0, [r4, #0x44]
	str r0, [r4, #0x48]
	ldr r0, _0218AC8C // =SailStylusPromptHUD__State_218AC90
	str r0, [r4, #0xf4]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0218AC80: .word 0x00001010
_0218AC84: .word 0x0218D7DC // aBbSbBb_1
_0218AC88: .word 0x0000FFFF
_0218AC8C: .word SailStylusPromptHUD__State_218AC90
	arm_func_end SailStylusPromptHUD__Create

	arm_func_start SailStylusPromptHUD__State_218AC90
SailStylusPromptHUD__State_218AC90: // 0x0218AC90
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	bl SailManager__GetWork
	bl SailManager__GetWork
	ldr r1, [r0, #0x70]
	ldr r0, [r1, #0x1c]
	ldr r2, [r1, #0x124]
	tst r0, #0x10
	beq _0218AD9C
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #2
	bne _0218ACF8
	ldr r1, [r5, #0x20]
	add r0, r2, #0x100
	bic r1, r1, #0x20
	str r1, [r5, #0x20]
	ldrsh r1, [r0, #0xdc]
	mov r0, #0x8c000
	mov r1, r1, lsl #0xc
	add r1, r1, #0x80000
	str r1, [r5, #0x44]
	str r0, [r5, #0x48]
_0218ACF8:
	ldr r0, [r5, #0x2c]
	cmp r0, #0xa
	bne _0218AD24
	mov r0, r5
	mov r1, #1
	bl StageTask__SetAnimation
	ldr r1, [r5, #0x20]
	mov r0, #0x4000
	orr r1, r1, #4
	str r1, [r5, #0x20]
	str r0, [r5, #4]
_0218AD24:
	ldr r0, [r5, #0x2c]
	cmp r0, #0xe
	blt _0218AD50
	cmp r0, #0x1c
	bge _0218AD50
	mov r1, #0x1000
	ldr r0, [r5, #0x9c]
	rsb r1, r1, #0
	mov r2, #0xa000
	bl ObjSpdUpSet
	str r0, [r5, #0x9c]
_0218AD50:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x1c
	moveq r0, #0
	streq r0, [r5, #0x9c]
	ldr r0, [r5, #0x2c]
	cmp r0, #0x1e
	bne _0218AD78
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimation
_0218AD78:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x44
	bne _0218ADD0
	ldr r1, [r5, #0x20]
	mov r0, #0
	orr r1, r1, #0x20
	str r1, [r5, #0x20]
	str r0, [r5, #0x2c]
	b _0218ADD0
_0218AD9C:
	ldr r0, [r5, #0x20]
	mov r1, #0
	orr r0, r0, #0x20
	str r0, [r5, #0x20]
	str r1, [r5, #0x2c]
	mov r0, r5
	str r1, [r5, #0x9c]
	bl StageTask__GetAnimID
	cmp r0, #0
	beq _0218ADD0
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimation
_0218ADD0:
	ldr r0, [r4, #0x24]
	tst r0, #0x2000
	ldrne r0, [r5, #0x18]
	orrne r0, r0, #4
	strne r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailStylusPromptHUD__State_218AC90
