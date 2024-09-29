	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWC_NdCleanupAsync
DWC_NdCleanupAsync: // 0x0208F478
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0208F4C8 // =0x021439F4
	ldr r2, [r1]
	cmp r2, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	str r0, [r2, #4]
	ldr r0, [r1]
	ldr r0, [r0, #0x48]
	cmp r0, #0
	bne _0208F4B4
	bl DWCi_NdCleanupCallback
	b _0208F4BC
_0208F4B4:
	ldr r0, _0208F4CC // =DWCi_NdCleanupCallback
	bl DWCi_NdCleanupAsync
_0208F4BC:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208F4C8: .word 0x021439F4
_0208F4CC: .word DWCi_NdCleanupCallback
	arm_func_end DWC_NdCleanupAsync

	arm_func_start DWCi_NdCleanupCallback
DWCi_NdCleanupCallback: // 0x0208F4D0
	stmdb sp!, {r4, lr}
	ldr r0, _0208F510 // =0x021439F4
	ldr r0, [r0]
	add r0, r0, #0x9c0
	bl OS_JoinThread
	ldr r0, _0208F510 // =0x021439F4
	ldr r0, [r0]
	ldr r4, [r0, #4]
	bl DWCi_NdFree
	ldr r0, _0208F510 // =0x021439F4
	mov r1, #0
	str r1, [r0]
	cmp r4, #0
	ldmeqia sp!, {r4, pc}
	blx r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208F510: .word 0x021439F4
	arm_func_end DWCi_NdCleanupCallback

	arm_func_start DWCi_NdFree
DWCi_NdFree: // 0x0208F514
	ldr ip, _0208F528 // =DWC_Free
	mov r1, r0
	mov r0, #6
	mov r2, #0
	bx ip
	.align 2, 0
_0208F528: .word DWC_Free
	arm_func_end DWCi_NdFree
