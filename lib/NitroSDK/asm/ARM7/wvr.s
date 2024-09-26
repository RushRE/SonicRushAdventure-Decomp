	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start WvrBegin
WvrBegin: // 0x03806168
	stmdb sp!, {lr}
	sub sp, sp, #0x54
	ldr r1, _03806200 // =wvrWlWork
	str r1, [sp]
	ldr r1, _03806204 // =wvrWlWork
	str r1, [sp, #4]
	mov r1, #0x600
	str r1, [sp, #8]
	mov r3, #4
	str r3, [sp, #0xc]
	mov r1, #0
	str r1, [sp, #0x20]
	mov r2, #8
	str r2, [sp, #0x24]
	str r0, [sp, #0x28]
	ldr r0, _03806208 // =wvrWlStaElement
	str r0, [sp, #0x2c]
	mov r0, #0x1c0
	str r0, [sp, #0x30]
	mov r1, #3
	str r1, [sp, #0x34]
	mov r0, #0x40
	str r0, [sp, #0x1c]
	str r1, [sp, #0x3c]
	str r3, [sp, #0x4c]
	mov r0, #5
	str r0, [sp, #0x44]
	mov r0, #7
	str r0, [sp, #0x38]
	str r2, [sp, #0x48]
	mov r0, #9
	str r0, [sp, #0x40]
	add r0, sp, #0
	add r1, sp, #0x34
	bl WM_sp_init
	add sp, sp, #0x54
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03806200: .word wvrWlWork
_03806204: .word wvrWlWork
_03806208: .word wvrWlStaElement
	arm_func_end WvrBegin

	arm_func_start WVR_Shutdown
WVR_Shutdown: // 0x0380620C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _03806240 // =0x04000304
	ldrh r0, [r1]
	bic r0, r0, #2
	strh r0, [r1]
	mov r0, #1
	bl PM_SetLEDPattern
	mov r0, #1
	bl PMi_SetLED
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03806240: .word 0x04000304
	arm_func_end WVR_Shutdown

	arm_func_start WVR_Init
WVR_Init: // 0x03806244
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	ldr r0, _03806288 // =wvrVramImageBuf
	str r1, [r0]
	ldr r0, _0380628C // =wvrHeapHandle
	str r4, [r0]
	ldr r0, _03806290 // =wvrThread
	mov r2, #0xa4
	bl MI_CpuFill8
	mov r0, r4
	bl WvrBegin
	mov r1, #3
	ldr r0, _03806294 // =wvrStatus
	strb r1, [r0]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03806288: .word wvrVramImageBuf
_0380628C: .word wvrHeapHandle
_03806290: .word wvrThread
_03806294: .word wvrStatus
	arm_func_end WVR_Init