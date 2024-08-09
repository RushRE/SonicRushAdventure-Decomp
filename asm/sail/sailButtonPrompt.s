	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailButtonPromptHUD__Create
SailButtonPromptHUD__Create: // 0x0218AA0C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r6, r1
	bl SailManager__GetWork
	ldr r0, _0218AAE8 // =0x00001010
	mov r1, #1
	bl CreateStageTaskEx_
	mov r4, r0
	mov r0, #0x4a
	bl GetObjectFileWork
	ldr r0, [r0]
	cmp r0, #0
	bne _0218AA64
	ldr r0, _0218AAEC // =aBbSbBb_1
	mov r1, #0x19
	mov r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	mov r0, #0x4a
	bl GetObjectFileWork
	str r5, [r0]
_0218AA64:
	mov r0, #0x4a
	bl GetObjectFileWork
	mov r1, #0
	ldr ip, _0218AAF0 // =0x0000FFFF
	mov r3, r0
	mov r0, r4
	mov r2, r1
	stmia sp, {r1, ip}
	bl ObjObjectAction2dBACLoad
	ldr r2, _0218AAF4 // =0x0000041A
	mov r0, r4
	mov r1, #0
	bl ObjActionAllocSpritePalette
	mov r0, r4
	mov r1, r7
	bl StageTask__SetAnimation
	mov r0, r4
	mov r1, #1
	bl StageTask__SetAnimatorPriority
	mov r0, r4
	mov r1, #0x1000
	bl SailObject__SetAnimSpeed
	str r6, [r4, #0x44]
	mov r0, #0x26000
	str r0, [r4, #0x48]
	ldr r0, _0218AAF8 // =SailButtonPromptHUD__State_218AAFC
	str r0, [r4, #0xf4]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x1000
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0218AAE8: .word 0x00001010
_0218AAEC: .word aBbSbBb_1
_0218AAF0: .word 0x0000FFFF
_0218AAF4: .word 0x0000041A
_0218AAF8: .word SailButtonPromptHUD__State_218AAFC
	arm_func_end SailButtonPromptHUD__Create

	arm_func_start SailButtonPromptHUD__State_218AAFC
SailButtonPromptHUD__State_218AAFC: // 0x0218AAFC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	bl SailManager__GetWork
	ldr r6, [r0, #0x98]
	bl SailManager__GetWork
	ldr r1, [r4, #0x24]
	ldr r4, [r0, #0x70]
	tst r1, #0x2000
	beq _0218AB40
	mov r0, #1
	bl SailHUD__Func_2174BA4
	ldr r0, [r5, #0x18]
	orr r0, r0, #4
	str r0, [r5, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
_0218AB40:
	ldr r1, [r6, #0x44]
	ldr r0, _0218ABAC // =0x00448000
	cmp r1, r0
	ldmltia sp!, {r4, r5, r6, pc}
	ldr r1, [r5, #0x20]
	mov r0, #0
	bic r1, r1, #0x1000
	bic r1, r1, #0x20
	str r1, [r5, #0x20]
	bl SailHUD__Func_2174BA4
	ldr r0, [r4, #0x24]
	tst r0, #1
	ldr r0, [r5, #0x20]
	bicne r0, r0, #4
	strne r0, [r5, #0x20]
	ldmneia sp!, {r4, r5, r6, pc}
	tst r0, #4
	bne _0218AB9C
	mov r0, r5
	bl StageTask__GetAnimID
	mov r1, r0
	mov r0, r5
	bl StageTask__SetAnimation
_0218AB9C:
	ldr r0, [r5, #0x20]
	orr r0, r0, #4
	str r0, [r5, #0x20]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0218ABAC: .word 0x00448000
	arm_func_end SailButtonPromptHUD__State_218AAFC

	.data

aBbSbBb_1: // 0x0218D7DC
	.asciz "bb/sb.bb"
    .align 4