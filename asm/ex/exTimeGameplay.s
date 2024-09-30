	.include "asm/macros.inc"
	.include "global.inc"

	.bss

exTimeGamePlayTask__dword_2178674: // 0x02178674
    .space 0x04
	
exTimeGamePlayTask__TaskSingleton: // 0x02178678
    .space 0x04
	
	.text

	arm_func_start exTimeGamePlayTask__Main
exTimeGamePlayTask__Main: // 0x02173904
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02173948 // =exTimeGamePlayTask__dword_2178674
	str r0, [r1, #4]
	bl exSysTask__GetStatus
	add r0, r0, #8
	str r0, [r4, #8]
	mov r0, #0
	str r0, [r4]
	str r0, [r4, #4]
	bl GetExTaskCurrent
	ldr r1, _0217394C // =exTimeGamePlayTask__Main_2173978
	str r1, [r0]
	bl exTimeGamePlayTask__Main_2173978
	ldmia sp!, {r4, pc}
	.align 2, 0
_02173948: .word exTimeGamePlayTask__dword_2178674
_0217394C: .word exTimeGamePlayTask__Main_2173978
	arm_func_end exTimeGamePlayTask__Main

	arm_func_start exTimeGamePlayTask__Func8
exTimeGamePlayTask__Func8: // 0x02173950
	ldr ip, _02173958 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_02173958: .word GetExTaskWorkCurrent_
	arm_func_end exTimeGamePlayTask__Func8

	arm_func_start exTimeGamePlayTask__Destructor
exTimeGamePlayTask__Destructor: // 0x0217395C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _02173974 // =exTimeGamePlayTask__dword_2178674
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02173974: .word exTimeGamePlayTask__dword_2178674
	arm_func_end exTimeGamePlayTask__Destructor

	arm_func_start exTimeGamePlayTask__Main_2173978
exTimeGamePlayTask__Main_2173978: // 0x02173978
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	ldr r1, _02173B7C // =exTimeGamePlayTask__dword_2178674
	mov r2, #0
	str r2, [r1]
	mov r4, r0
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #4
	blo _02173B68
	ldmia r4, {r0, r1}
	bl _f_ulltof
	ldr r1, _02173B80 // =0x44D04000
	bl _fadd
	bl _ll_ufrom_f_r
	stmia r4, {r0, r1}
	ldr r0, [r4, #0]
	mov r2, #0x3e8
	mov r3, #0
	bl _ll_udiv
	ldr r1, [r4, #8]
	strh r0, [r1, #0xa]
	ldr r0, [r4, #8]
	ldrh r0, [r0, #0xa]
	cmp r0, #9
	bls _02173B68
	ldr r2, [r4, #0]
	ldr r0, _02173B84 // =0x00002710
	ldr r1, [r4, #4]
	subs r2, r2, r0
	mov r0, #0
	str r2, [r4]
	sbc r1, r1, r0
	str r1, [r4, #4]
	ldr r1, [r4, #8]
	strh r0, [r1, #0xa]
	ldr r2, [r4, #8]
	ldrh r1, [r2, #8]
	add r1, r1, #1
	strh r1, [r2, #8]
	ldr r2, [r4, #8]
	ldrh r1, [r2, #8]
	cmp r1, #9
	bls _02173B68
	strh r0, [r2, #8]
	ldr r2, [r4, #8]
	ldrh r1, [r2, #6]
	add r1, r1, #1
	strh r1, [r2, #6]
	ldr r3, [r4, #8]
	ldrh r2, [r3, #6]
	cmp r2, #9
	bls _02173B20
	ldrh r1, [r3, #2]
	cmp r1, #9
	bne _02173AC4
	ldrh r1, [r3, #4]
	cmp r1, #3
	blo _02173AC4
	cmp r2, #0xa
	bne _02173AC4
	mov ip, #0x2b
	sub r1, ip, #0x2c
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
_02173AC4:
	ldr r0, [r4, #8]
	mov r2, #0
	strh r2, [r0, #6]
	ldr r1, [r4, #8]
	ldrh r0, [r1, #4]
	add r0, r0, #1
	strh r0, [r1, #4]
	ldr r1, [r4, #8]
	ldrh r0, [r1, #4]
	cmp r0, #5
	bls _02173B68
	strh r2, [r1, #4]
	ldr r1, [r4, #8]
	ldrh r0, [r1, #2]
	add r0, r0, #1
	strh r0, [r1, #2]
	ldr r0, [r4, #8]
	ldrh r0, [r0, #2]
	cmp r0, #9
	bls _02173B68
	bl exTimeGamePlayTask__Func_2173B88
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_02173B20:
	ldrh r0, [r3, #2]
	cmp r0, #9
	bne _02173B68
	ldrh r0, [r3, #4]
	cmp r0, #4
	blo _02173B68
	mov r1, r2, lsr #0x1f
	rsb r0, r1, r2, lsl #31
	adds r0, r1, r0, ror #31
	cmpne r2, #0xa
	bne _02173B68
	mov r4, #0x2b
	sub r1, r4, #0x2c
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
_02173B68:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02173B7C: .word exTimeGamePlayTask__dword_2178674
_02173B80: .word 0x44D04000
_02173B84: .word 0x00002710
	arm_func_end exTimeGamePlayTask__Main_2173978

	arm_func_start exTimeGamePlayTask__Func_2173B88
exTimeGamePlayTask__Func_2173B88: // 0x02173B88
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _02173BE0 // =exTimeGamePlayTask__dword_2178674
	mov r2, #1
	str r2, [r1]
	ldr r1, [r0, #8]
	mov r3, #9
	strh r3, [r1, #2]
	ldr r1, [r0, #8]
	mov r2, #5
	strh r2, [r1, #4]
	ldr r1, [r0, #8]
	strh r3, [r1, #6]
	ldr r1, [r0, #8]
	strh r3, [r1, #8]
	ldr r0, [r0, #8]
	strh r3, [r0, #0xa]
	bl GetExTaskCurrent
	ldr r1, _02173BE4 // =exTimeGamePlayTask__Main_2173BE8
	str r1, [r0]
	bl exTimeGamePlayTask__Main_2173BE8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02173BE0: .word exTimeGamePlayTask__dword_2178674
_02173BE4: .word exTimeGamePlayTask__Main_2173BE8
	arm_func_end exTimeGamePlayTask__Func_2173B88

	arm_func_start exTimeGamePlayTask__Main_2173BE8
exTimeGamePlayTask__Main_2173BE8: // 0x02173BE8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exTimeGamePlayTask__Main_2173BE8

	arm_func_start exTimeGamePlayTask__Create
exTimeGamePlayTask__Create: // 0x02173C00
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0xc
	ldr r0, _02173C68 // =aExtimegameplay
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02173C6C // =exTimeGamePlayTask__Main
	ldr r1, _02173C70 // =exTimeGamePlayTask__Destructor
	mov r2, #0x1200
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r1, #0
	mov r2, #0xc
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _02173C74 // =exTimeGamePlayTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_02173C68: .word aExtimegameplay
_02173C6C: .word exTimeGamePlayTask__Main
_02173C70: .word exTimeGamePlayTask__Destructor
_02173C74: .word exTimeGamePlayTask__Func8
	arm_func_end exTimeGamePlayTask__Create

	arm_func_start exFixTimeTask__Func_2173C78
exFixTimeTask__Func_2173C78: // 0x02173C78
	stmdb sp!, {r3, lr}
	ldr r0, _02173C9C // =exTimeGamePlayTask__dword_2178674
	ldr r0, [r0, #4]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _02173CA0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02173C9C: .word exTimeGamePlayTask__dword_2178674
_02173CA0: .word ExTask_State_Destroy
	arm_func_end exFixTimeTask__Func_2173C78

	arm_func_start ovl09_2173CA4
ovl09_2173CA4: // 0x02173CA4
	ldr r0, _02173CB0 // =exTimeGamePlayTask__dword_2178674
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_02173CB0: .word exTimeGamePlayTask__dword_2178674
	arm_func_end ovl09_2173CA4

	arm_func_start ovl09_2173CB4
ovl09_2173CB4: // 0x02173CB4
	ldr r0, _02173CC4 // =exTimeGamePlayTask__dword_2178674
	mov r1, #0
	str r1, [r0]
	bx lr
	.align 2, 0
_02173CC4: .word exTimeGamePlayTask__dword_2178674
	arm_func_end ovl09_2173CB4

	.data
	
aExtimegameplay: // 0x02175EE0
	.asciz "exTimeGamePlayTask"