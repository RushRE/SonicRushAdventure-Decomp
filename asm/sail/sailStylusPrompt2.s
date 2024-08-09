	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailStylusPromptHUD2__Create
SailStylusPromptHUD2__Create: // 0x0218ADE8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	bl SailManager__GetWork
	ldr r0, _0218AEC0 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x4a
	bl GetObjectFileWork
	ldr r0, [r0]
	cmp r0, #0
	bne _0218AE38
	ldr r0, _0218AEC4 // =aBbSbBb_1
	mov r1, #0x1a
	mov r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	mov r0, #0x4b
	bl GetObjectFileWork
	str r5, [r0]
_0218AE38:
	mov r0, #0x4b
	bl GetObjectFileWork
	mov r1, #0
	ldr ip, _0218AEC8 // =0x0000FFFF
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
	ldr r1, _0218AECC // =SailStylusPromptHUD2__State_218AED0
	mov r0, #0
	str r1, [r4, #0xf4]
	str r0, [r4, #0x2c]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0218AEC0: .word 0x00001010
_0218AEC4: .word aBbSbBb_1
_0218AEC8: .word 0x0000FFFF
_0218AECC: .word SailStylusPromptHUD2__State_218AED0
	arm_func_end SailStylusPromptHUD2__Create

	arm_func_start SailStylusPromptHUD2__State_218AED0
SailStylusPromptHUD2__State_218AED0: // 0x0218AED0
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	bl SailManager__GetWork
	bl SailManager__GetWork
	ldr r0, [r5, #0x2c]
	add r0, r0, #1
	str r0, [r5, #0x2c]
	cmp r0, #1
	bne _0218AF30
	ldr r0, [r5, #0x20]
	mov r1, #0
	orr r0, r0, #0x20
	str r0, [r5, #0x20]
	str r1, [r5, #0x98]
	mov r0, r5
	str r1, [r5, #0x9c]
	bl StageTask__GetAnimID
	cmp r0, #0
	beq _0218AF30
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimation
_0218AF30:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x10
	bne _0218AF58
	ldr r1, [r5, #0x20]
	mov r0, #0x20000
	bic r1, r1, #0x20
	str r1, [r5, #0x20]
	str r0, [r5, #0x44]
	mov r0, #0x8c000
	str r0, [r5, #0x48]
_0218AF58:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x18
	bne _0218AF84
	mov r0, r5
	mov r1, #1
	bl StageTask__SetAnimation
	ldr r1, [r5, #0x20]
	mov r0, #0x4000
	orr r1, r1, #4
	str r1, [r5, #0x20]
	str r0, [r5, #4]
_0218AF84:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x1c
	blt _0218AFC4
	cmp r0, #0x3c
	bge _0218AFC4
	ldr r0, [r5, #0x98]
	mov r1, #0x800
	mov r2, #0x8000
	bl ObjSpdUpSet
	str r0, [r5, #0x98]
	mov r1, #0x800
	ldr r0, [r5, #0x9c]
	rsb r1, r1, #0
	mov r2, #0x2000
	bl ObjSpdUpSet
	str r0, [r5, #0x9c]
_0218AFC4:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x3c
	moveq r0, #0
	streq r0, [r5, #0x98]
	streq r0, [r5, #0x9c]
	ldr r0, [r5, #0x2c]
	cmp r0, #0x44
	bne _0218AFF0
	mov r0, r5
	mov r1, #0
	bl StageTask__SetAnimation
_0218AFF0:
	ldr r0, [r5, #0x2c]
	cmp r0, #0x50
	bne _0218B010
	ldr r1, [r5, #0x20]
	mov r0, #0
	orr r1, r1, #0x20
	str r1, [r5, #0x20]
	str r0, [r5, #0x2c]
_0218B010:
	ldr r0, [r4, #0x24]
	tst r0, #0x2000
	ldrne r0, [r5, #0x18]
	orrne r0, r0, #4
	strne r0, [r5, #0x18]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailStylusPromptHUD2__State_218AED0
