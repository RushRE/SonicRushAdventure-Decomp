	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start EXIi_SelectRcnt
EXIi_SelectRcnt: // 0x037FED00
	mov r1, r0
	mov r0, #0xc000
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ldr ip, _037FED18 // =EXIi_SetBitRcnt0L
	bx ip
	.align 2, 0
_037FED18: .word EXIi_SetBitRcnt0L
	arm_func_end EXIi_SelectRcnt

	arm_func_start EXIi_SetBitRcnt0L
EXIi_SetBitRcnt0L: // 0x037FED1C
	mvn r3, r0
	ldr r2, _037FED38 // =0x04000134
	ldrh r0, [r2, #0]
	and r0, r3, r0
	orr r0, r1, r0
	strh r0, [r2]
	bx lr
	.align 2, 0
_037FED38: .word 0x04000134
	arm_func_end EXIi_SetBitRcnt0L