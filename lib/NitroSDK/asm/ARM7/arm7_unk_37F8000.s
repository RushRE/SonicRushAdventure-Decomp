	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start VBlankIntr
VBlankIntr: // 0x037F8000
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _037F8028 // =0x0380ABD4
	ldr r0, [r0]
	cmp r0, #0
	beq _037F801C
	bl PM_SelfBlinkProc
_037F801C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037F8028: .word 0x0380ABD4
	arm_func_end VBlankIntr

	arm_func_start sub_37F802C
sub_37F802C: // 0x037F802C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #4
	mov sl, r0
	mov r8, #0
	bl sub_37F81E8
	cmp r0, #0
	beq _037F80F8
	bl sub_37F81C4
	mov r7, r0
	mov sb, r8
	mov r4, #1
	mov fp, #0x8a
	mov r5, #0x70
_037F8060:
	add r6, sl, sb, lsl #8
	ldr r0, _037F81B4 // =0x0000FFFF
	mov r1, r6
	mov r2, r5
	bl sub_37F81B8
	mov r2, r6
	ldrh r1, [r2, #0x72]
	cmp r0, r1
	bne _037F80E0
	ldrh r0, [r2, #0x70]
	cmp r0, #0x80
	bhs _037F80E0
	ldr r0, _037F81B4 // =0x0000FFFF
	add r1, r6, #0x74
	mov r2, fp
	bl sub_37F81B8
	mov r3, r6
	ldrh r1, [r3, #0xfe]
	cmp r0, r1
	bne _037F80E0
	ldrh r2, [r3, #0x76]
	ldrb r0, [r3, #0x75]
	mov r1, r4, lsl r0
	ands r1, r1, r2
	beq _037F80E0
	ands r1, r7, r2
	ldrneh r1, [r6, #0x64]
	bicne r1, r1, #7
	andne r0, r0, #7
	orrne r0, r1, r0
	strneh r0, [r6, #0x64]
	orr r8, r8, r4, lsl sb
_037F80E0:
	add r0, sb, #1
	mov r0, r0, lsl #0x10
	mov sb, r0, lsr #0x10
	cmp sb, #2
	blo _037F8060
	b _037F8158
_037F80F8:
	bl sub_37F81C4
	cmp r0, #0
	movne r0, #3
	bne _037F81A8
	mov r7, r8
	mov r4, #1
	ldr r6, _037F81B4 // =0x0000FFFF
	mov r5, #0x70
_037F8118:
	mov r0, r6
	add r1, sl, r7, lsl #8
	mov r2, r5
	bl sub_37F81B8
	add r2, sl, r7, lsl #8
	ldrh r1, [r2, #0x72]
	cmp r0, r1
	bne _037F8144
	ldrh r0, [r2, #0x70]
	cmp r0, #0x80
	orrlo r8, r8, r4, lsl r7
_037F8144:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #2
	blo _037F8118
_037F8158:
	cmp r8, #1
	beq _037F8174
	cmp r8, #2
	beq _037F8174
	cmp r8, #3
	beq _037F817C
	b _037F81A4
_037F8174:
	mov r0, r8
	b _037F81A8
_037F817C:
	ldrh r0, [sl, #0x70]
	add r0, r0, #1
	and r0, r0, #0x7f
	and r1, r0, #0xff
	add r0, sl, #0x100
	ldrh r0, [r0, #0x70]
	cmp r1, r0
	moveq r0, #2
	movne r0, #1
	b _037F81A8
_037F81A4:
	mov r0, #0
_037F81A8:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	bx lr
	.align 2, 0
_037F81B4: .word 0x0000FFFF
	arm_func_end sub_37F802C

	arm_func_start sub_37F81B8
sub_37F81B8: // 0x037F81B8
	ldr ip, _037F81C0 // =SVC_GetCRC16
	bx ip
	.align 2, 0
_037F81C0: .word SVC_GetCRC16
	arm_func_end sub_37F81B8

	arm_func_start sub_37F81C4
sub_37F81C4: // 0x037F81C4
	mov r0, #0
	ldr r1, _037F81E4 // =0x027FFE1D
	ldrb r1, [r1]
	cmp r1, #0x80
	orreq r0, r0, #0x40
	moveq r0, r0, lsl #0x10
	moveq r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_037F81E4: .word 0x027FFE1D
	arm_func_end sub_37F81C4

	arm_func_start sub_37F81E8
sub_37F81E8: // 0x037F81E8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x1d
	mov r1, #1
	add r2, sp, #0
	bl NVRAM_ReadDataBytes
	ldrb r0, [sp]
	cmp r0, #0xff
	moveq r0, #0
	beq _037F821C
	ands r0, r0, #0x40
	movne r0, #1
	moveq r0, #0
_037F821C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_37F81E8

	arm_func_start sub_37F8228
sub_37F8228: // 0x037F8228
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x210
	mov r0, #0x20
	mov r1, #2
	add r2, sp, #4
	bl NVRAM_ReadDataBytes
	ldr r0, [sp, #4]
	mov r0, r0, lsl #3
	str r0, [sp, #4]
	mov r1, #0x100
	add r2, sp, #0x10
	bl NVRAM_ReadDataBytes
	ldr r0, [sp, #4]
	add r0, r0, #0x100
	mov r1, #0x100
	add r2, sp, #0x110
	bl NVRAM_ReadDataBytes
	add r0, sp, #0x10
	bl sub_37F802C
	cmp r0, #3
	blt _037F8290
	mvn r0, #0
	ldr r1, _037F83A4 // =0x027FFC80
	mov r2, #0x74
	bl MIi_CpuClear32
	b _037F834C
_037F8290:
	cmp r0, #0
	beq _037F833C
	mov r2, r0, lsl #8
	ldr r1, _037F83A8 // =0xFFFFFF2A
	add r1, sp, r1
	ldrb r1, [r1, r0, lsl #8]
	cmp r1, #0xa
	bhs _037F82DC
	mov ip, #0xa
	mov r3, #0
	add r1, sp, #0x10
	add r2, r1, r2
	b _037F82D0
_037F82C4:
	add r1, r2, ip, lsl #1
	strh r3, [r1, #-0xfc]
	sub ip, ip, #1
_037F82D0:
	ldrb r1, [r2, #-0xe6]
	cmp ip, r1
	bgt _037F82C4
_037F82DC:
	mov r2, r0, lsl #8
	ldr r1, _037F83AC // =0xFFFFFF60
	add r1, sp, r1
	ldrb r1, [r1, r0, lsl #8]
	cmp r1, #0x1a
	bhs _037F8320
	mov ip, #0x1a
	mov r3, #0
	add r1, sp, #0x10
	add r2, r1, r2
	b _037F8314
_037F8308:
	add r1, r2, ip, lsl #1
	strh r3, [r1, #-0xe6]
	sub ip, ip, #1
_037F8314:
	ldrb r1, [r2, #-0xb0]
	cmp ip, r1
	bgt _037F8308
_037F8320:
	add r1, sp, #0x10
	sub r0, r0, #1
	add r0, r1, r0, lsl #8
	ldr r1, _037F83A4 // =0x027FFC80
	mov r2, #0x74
	bl MIi_CpuCopy32
	b _037F834C
_037F833C:
	mov r0, #0
	ldr r1, _037F83A4 // =0x027FFC80
	mov r2, #0x74
	bl MIi_CpuClear32
_037F834C:
	mov r0, #0x36
	mov r1, #6
	add r2, sp, #8
	bl NVRAM_ReadDataBytes
	ldr r0, _037F83A4 // =0x027FFC80
	add r4, r0, #0x74
	add r0, sp, #8
	mov r1, r4
	mov r2, #6
	bl MI_CpuCopy8
	mov r0, #0x3c
	mov r1, #2
	add r2, sp, #0
	bl NVRAM_ReadDataBytes
	ldrh r0, [sp]
	mov r0, r0, lsl #0xf
	mov r0, r0, lsr #0x10
	bl WMSP_GetAllowedChannel
	strh r0, [r4, #6]
	add sp, sp, #0x210
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037F83A4: .word 0x027FFC80
_037F83A8: .word 0xFFFFFF2A
_037F83AC: .word 0xFFFFFF60
	arm_func_end sub_37F8228

	arm_func_start sub_37F83B0
sub_37F83B0: // 0x037F83B0
	stmdb sp!, {r4, lr}
	mov r0, #8
	bl OS_GetArenaHi
	mov r4, r0
	mov r0, #8
	bl OS_GetArenaLo
	mov r1, r0
	mov r0, #8
	mov r2, r4
	mov r3, #1
	bl OS_InitAlloc
	mov r4, r0
	mov r0, #8
	bl OS_GetArenaHi
	mov r2, r0
	mov r0, r4
	mov r1, #0
	sub r2, r2, r4
	bl MI_CpuFill8
	mov r0, #8
	mov r1, r4
	bl OS_SetArenaHi
	mov r0, #8
	bl OS_GetArenaHi
	mov r4, r0
	mov r0, #8
	bl OS_GetArenaLo
	mov r1, r0
	mov r0, #8
	mov r2, r4
	bl OS_CreateHeap
	movs r4, r0
	bpl _037F8438
	bl OS_Terminate
_037F8438:
	mov r0, #8
	mov r1, r4
	bl OS_SetCurrentHeap
	mov r0, #8
	mov r1, r4
	bl OS_CheckHeap
	cmp r0, #0x2100
	bhs _037F845C
	bl OS_Terminate
_037F845C:
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_37F83B0