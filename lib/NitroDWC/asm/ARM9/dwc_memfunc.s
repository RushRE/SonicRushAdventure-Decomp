	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_GsFree
DWCi_GsFree: // 0x0208EE18
	ldr ip, _0208EE2C // =DWC_Free
	mov r1, r0
	mov r0, #5
	mov r2, #0
	bx ip
	.align 2, 0
_0208EE2C: .word DWC_Free
	arm_func_end DWCi_GsFree

	arm_func_start DWCi_GsRealloc
DWCi_GsRealloc: // 0x0208EE30
	ldr ip, _0208EE48 // =DWC_Realloc
	mov r2, r1
	mov r1, r0
	mov r3, r2
	mov r0, #5
	bx ip
	.align 2, 0
_0208EE48: .word DWC_Realloc
	arm_func_end DWCi_GsRealloc

	arm_func_start DWCi_GsMalloc
DWCi_GsMalloc: // 0x0208EE4C
	ldr ip, _0208EE5C // =DWC_Alloc
	mov r1, r0
	mov r0, #5
	bx ip
	.align 2, 0
_0208EE5C: .word DWC_Alloc
	arm_func_end DWCi_GsMalloc

	arm_func_start DWC_ReallocEx
DWC_ReallocEx: // 0x0208EE60
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr ip, _0208EECC // =0x021439EC
	mov r4, r2
	mov r7, r3
	mov r5, r1
	ldr r2, [sp, #0x18]
	ldr r3, [ip]
	mov r1, r7
	mov r8, r0
	blx r3
	movs r6, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r5, #0
	beq _0208EEC4
	mov r0, r5
	mov r1, r6
	mov r2, r7
	bl MI_CpuCopy8
	ldr r1, _0208EED0 // =0x021439E8
	mov r0, r8
	ldr r3, [r1, #0]
	mov r1, r5
	mov r2, r4
	blx r3
_0208EEC4:
	mov r0, r6
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0208EECC: .word 0x021439EC
_0208EED0: .word 0x021439E8
	arm_func_end DWC_ReallocEx

	arm_func_start DWC_Realloc
DWC_Realloc: // 0x0208EED4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov ip, #0x20
	str ip, [sp]
	bl DWC_ReallocEx
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWC_Realloc

	arm_func_start DWC_Free
DWC_Free: // 0x0208EEF0
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r3, _0208EF18 // =0x021439E8
	ldr r3, [r3, #0]
	blx r3
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208EF18: .word 0x021439E8
	arm_func_end DWC_Free

	arm_func_start DWC_AllocEx
DWC_AllocEx: // 0x0208EF1C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, _0208EF38 // =0x021439EC
	ldr r3, [r3, #0]
	blx r3
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208EF38: .word 0x021439EC
	arm_func_end DWC_AllocEx

	arm_func_start DWC_Alloc
DWC_Alloc: // 0x0208EF3C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, _0208EF5C // =0x021439EC
	mov r2, #0x20
	ldr r3, [r3, #0]
	blx r3
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208EF5C: .word 0x021439EC
	arm_func_end DWC_Alloc

	arm_func_start DWC_SetMemFunc
DWC_SetMemFunc: // 0x0208EF60
	ldr r3, _0208EF74 // =0x021439EC
	ldr r2, _0208EF78 // =0x021439E8
	str r0, [r3]
	str r1, [r2]
	bx lr
	.align 2, 0
_0208EF74: .word 0x021439EC
_0208EF78: .word 0x021439E8
	arm_func_end DWC_SetMemFunc
