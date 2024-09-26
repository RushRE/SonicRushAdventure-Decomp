	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start OSi_IrqVBlank
OSi_IrqVBlank: // 0x037FBB4C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _037FBB98 // =0x038083AC
	ldr r2, [r0, #0x60]
	ldr r1, _037FBB9C // =0x027FFC3C
	ldr r0, [r1]
	add r0, r0, #1
	str r0, [r1]
	cmp r2, #0
	beq _037FBB7C
	mov lr, pc
	bx r2
_037FBB7C:
	ldr r1, _037FBBA0 // =0x0380FFF8
	ldr r0, [r1]
	orr r0, r0, #1
	str r0, [r1]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FBB98: .word 0x038083AC
_037FBB9C: .word 0x027FFC3C
_037FBBA0: .word 0x0380FFF8
	arm_func_end OSi_IrqVBlank

	arm_func_start OSi_IrqTimer3
OSi_IrqTimer3: // 0x037FBBA4
	mov r0, #7
	ldr ip, _037FBBB0 // =OSi_IrqCallback
	bx ip
	.align 2, 0
_037FBBB0: .word OSi_IrqCallback
	arm_func_end OSi_IrqTimer3

	arm_func_start OSi_IrqTimer2
OSi_IrqTimer2: // 0x037FBBB4
	mov r0, #6
	ldr ip, _037FBBC0 // =OSi_IrqCallback
	bx ip
	.align 2, 0
_037FBBC0: .word OSi_IrqCallback
	arm_func_end OSi_IrqTimer2

	arm_func_start OSi_IrqTimer1
OSi_IrqTimer1: // 0x037FBBC4
	mov r0, #5
	ldr ip, _037FBBD0 // =OSi_IrqCallback
	bx ip
	.align 2, 0
_037FBBD0: .word OSi_IrqCallback
	arm_func_end OSi_IrqTimer1

	arm_func_start OSi_IrqTimer0
OSi_IrqTimer0: // 0x037FBBD4
	mov r0, #4
	ldr ip, _037FBBE0 // =OSi_IrqCallback
	bx ip
	.align 2, 0
_037FBBE0: .word OSi_IrqCallback
	arm_func_end OSi_IrqTimer0

	arm_func_start OSi_IrqDma3
OSi_IrqDma3: // 0x037FBBE4
	mov r0, #3
	ldr ip, _037FBBF0 // =OSi_IrqCallback
	bx ip
	.align 2, 0
_037FBBF0: .word OSi_IrqCallback
	arm_func_end OSi_IrqDma3

	arm_func_start OSi_IrqDma2
OSi_IrqDma2: // 0x037FBBF4
	mov r0, #2
	ldr ip, _037FBC00 // =OSi_IrqCallback
	bx ip
	.align 2, 0
_037FBC00: .word OSi_IrqCallback
	arm_func_end OSi_IrqDma2

	arm_func_start OSi_IrqDma1
OSi_IrqDma1: // 0x037FBC04
	mov r0, #1
	ldr ip, _037FBC10 // =OSi_IrqCallback
	bx ip
	.align 2, 0
_037FBC10: .word OSi_IrqCallback
	arm_func_end OSi_IrqDma1

	arm_func_start OSi_IrqDma0
OSi_IrqDma0: // 0x037FBC14
	mov r0, #0
	ldr ip, _037FBC20 // =OSi_IrqCallback
	bx ip
	.align 2, 0
_037FBC20: .word OSi_IrqCallback
	arm_func_end OSi_IrqDma0

	arm_func_start OSi_IrqCallback
OSi_IrqCallback: // 0x037FBC24
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r3, #1
	mov r2, r0, lsl #1
	ldr r1, _037FBCA4 // =OSi_IrqCallbackInfoIndex
	ldrh r1, [r1, r2]
	mov r5, r3, lsl r1
	mov r1, #0xc
	mul r4, r0, r1
	ldr r2, _037FBCA8 // =0x038083AC
	ldr r1, [r2, r4]
	mov r0, #0
	str r0, [r2, r4]
	cmp r1, #0
	beq _037FBC70
	ldr r0, _037FBCAC // =0x038083B4
	ldr r0, [r0, r4]
	mov lr, pc
	bx r1
_037FBC70:
	ldr r1, _037FBCB0 // =0x0380FFF8
	ldr r0, [r1]
	orr r0, r0, r5
	str r0, [r1]
	ldr r0, _037FBCB4 // =0x038083B0
	ldr r0, [r0, r4]
	cmp r0, #0
	bne _037FBC98
	mov r0, r5
	bl OS_DisableIrqMask
_037FBC98:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FBCA4: .word OSi_IrqCallbackInfoIndex
_037FBCA8: .word 0x038083AC
_037FBCAC: .word 0x038083B4
_037FBCB0: .word 0x0380FFF8
_037FBCB4: .word 0x038083B0
	arm_func_end OSi_IrqCallback

	arm_func_start OS_IrqDummy
OS_IrqDummy: // 0x037FBCB8
	bx lr
	arm_func_end OS_IrqDummy

	.rodata

.public OSi_IrqCallbackInfoIndex
OSi_IrqCallbackInfoIndex:
	.hword 8, 9, 0xA, 0xB, 3, 4, 5, 6, 0, 0

.public OS_IRQTable
OS_IRQTable: // 0x03808290
	.word OSi_IrqVBlank, OS_IrqDummy, OS_IrqDummy, OSi_IrqTimer0
	.word OSi_IrqTimer1, OSi_IrqTimer2, OSi_IrqTimer3, OS_IrqDummy
	.word OSi_IrqDma0, OSi_IrqDma1, OSi_IrqDma2, OSi_IrqDma3
	.word OS_IrqDummy, OS_IrqDummy, OS_IrqDummy, OS_IrqDummy
	.word OS_IrqDummy, OS_IrqDummy, OS_IrqDummy, OS_IrqDummy
	.word OS_IrqDummy, OS_IrqDummy, OS_IrqDummy, OS_IrqDummy
	.word OS_IrqDummy