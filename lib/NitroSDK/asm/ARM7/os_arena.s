	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

.public OSi_Initialized
OSi_Initialized: // 0x0380858C
	.space 4

	.text

	arm_func_start OS_SetArenaHi
OS_SetArenaHi: // 0x037FD004
	mov r0, r0, lsl #2
	add r0, r0, #0x2700000
	add r0, r0, #0xff000
	str r1, [r0, #0xda0]
	bx lr
	arm_func_end OS_SetArenaHi

	arm_func_start OS_SetArenaLo
OS_SetArenaLo: // 0x037FD018
	mov r0, r0, lsl #2
	add r0, r0, #0x2700000
	add r0, r0, #0xff000
	str r1, [r0, #0xdc4]
	bx lr
	arm_func_end OS_SetArenaLo

	arm_func_start OS_GetInitArenaHi
OS_GetInitArenaHi: // 0x037FD02C
	cmp r0, #1
	beq _037FD048
	cmp r0, #7
	beq _037FD050
	cmp r0, #8
	beq _037FD060
	b _037FD074
_037FD048:
	ldr r0, _037FD07C // =0x027F9DBC
	bx lr
_037FD050:
	ldr r0, _037FD080 // =0x0380BDF0
	cmp r0, #0x3800000
	movhi r0, #0x3800000
	bx lr
_037FD060:
	mov r0, #0x3800000
	ldr r1, _037FD080 // =0x0380BDF0
	cmp r1, #0x3800000
	movhi r0, r1
	bx lr
_037FD074:
	mov r0, #0
	bx lr
	.align 2, 0
_037FD07C: .word 0x027F9DBC
_037FD080: .word 0x0380BDF0
	arm_func_end OS_GetInitArenaHi

	arm_func_start OS_GetInitArenaLo
OS_GetInitArenaLo: // 0x037FD084
	cmp r0, #1
	beq _037FD0A0
	cmp r0, #7
	beq _037FD0A8
	cmp r0, #8
	beq _037FD0B0
	b _037FD0E8
_037FD0A0:
	ldr r0, _037FD0F0 // =0x027FF000
	bx lr
_037FD0A8:
	mov r0, #0x3800000
	bx lr
_037FD0B0:
	ldr r1, _037FD0F4 // =0x00000400
	ldr r0, _037FD0F8 // =0x0380FF80
	sub r2, r0, r1
	mov r0, #0x3800000
	ldr r1, _037FD0FC // =0x0380BDF0
	cmp r1, #0x3800000
	movhi r0, r1
	ldr r1, _037FD100 // =0x00000400
	cmp r1, #0
	bxeq lr
	cmp r1, #0
	sublt r0, r0, r1
	subge r0, r2, r1
	bx lr
_037FD0E8:
	mov r0, #0
	bx lr
	.align 2, 0
_037FD0F0: .word 0x027FF000
_037FD0F4: .word 0x00000400
_037FD0F8: .word 0x0380FF80
_037FD0FC: .word 0x0380BDF0
_037FD100: .word 0x00000400
	arm_func_end OS_GetInitArenaLo

	arm_func_start OS_GetArenaLo
OS_GetArenaLo: // 0x037FD104
	mov r0, r0, lsl #2
	add r0, r0, #0x2700000
	add r0, r0, #0xff000
	ldr r0, [r0, #0xda0]
	bx lr
	arm_func_end OS_GetArenaLo

	arm_func_start OS_GetArenaHi
OS_GetArenaHi: // 0x037FD118
	mov r0, r0, lsl #2
	add r0, r0, #0x2700000
	add r0, r0, #0xff000
	ldr r0, [r0, #0xdc4]
	bx lr
	arm_func_end OS_GetArenaHi

	arm_func_start OS_InitArena
OS_InitArena: // 0x037FD12C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _037FD1CC // =OSi_Initialized
	ldr r0, [r1]
	cmp r0, #0
	bne _037FD1C0
	mov r0, #1
	str r0, [r1]
	bl OS_GetInitArenaLo
	mov r1, r0
	mov r0, #1
	bl OS_SetArenaLo
	mov r0, #1
	bl OS_GetInitArenaHi
	mov r1, r0
	mov r0, #1
	bl OS_SetArenaHi
	mov r0, #7
	bl OS_GetInitArenaLo
	mov r1, r0
	mov r0, #7
	bl OS_SetArenaLo
	mov r0, #7
	bl OS_GetInitArenaHi
	mov r1, r0
	mov r0, #7
	bl OS_SetArenaHi
	mov r0, #8
	bl OS_GetInitArenaLo
	mov r1, r0
	mov r0, #8
	bl OS_SetArenaLo
	mov r0, #8
	bl OS_GetInitArenaHi
	mov r1, r0
	mov r0, #8
	bl OS_SetArenaHi
_037FD1C0:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FD1CC: .word OSi_Initialized
	arm_func_end OS_InitArena