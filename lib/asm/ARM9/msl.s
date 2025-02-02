	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public _021523F0
_021523F0: // 0x021523F0
	.space 0x04
	
.public _021523F4
_021523F4: // 0x021523F4
	.space 0x04
	
.public _021523F8
_021523F8: // 0x021523F8
	.space 0x04
	
.public _021523FC
_021523FC: // 0x021523FC
	.space 0x04
	
.public _02152400
_02152400: // 0x02152400
	.space 0x100
	
.public _02152500
_02152500: // 0x02152500
	.space 0x0C
	
.public _0215250C
_0215250C: // 0x0215250C
	.space 0x10
	
.public _0215251C
_0215251C: // 0x0215251C
	.space 0x08

.public _02152524
_02152524: // 0x02152524
	.space 0x04
	.space 0x04 // padding
	.space 0x04 // padding

.public _02152530
_02152530: // 0x02152530
	.space 0x10
	
.public _02152540
_02152540: // 0x02152540
	.space 0x08
	
.public _02152548
_02152548: // 0x02152548
	.space 0x48
	
.public _02152590
_02152590: // 0x02152590
	.space 0x60
	
.public _021525F0
_021525F0: // 0x021525F0
	.space 0x330
	
.public errno
errno: // 0x02152920
	.space 0x04
	
.public _02152924
_02152924: // 0x02152924
	.space 0x1C
	
.public __global_destructor_chain
__global_destructor_chain: // 0x02152940
	.space 0x04

	.text

	// library begin: MSL_C_NITRO_Ai_LE.a

	arm_func_start abort
abort: // 0x020FD4D8
	stmdb sp!, {r3, lr}
	mov r0, #1
	bl raise
	ldr r1, _020FD4F8 // =_021523F0
	mov r0, #1
	str r0, [r1, #0xc]
	bl exit
	ldmia sp!, {r3, pc}
	.align 2, 0
_020FD4F8: .word _021523F0
	arm_func_end abort

	arm_func_start exit
exit: // 0x020FD4FC
	stmdb sp!, {r4, lr}
	ldr r1, _020FD544 // =_021523F0
	mov r4, r0
	ldr r0, [r1, #0xc]
	cmp r0, #0
	bne _020FD538
	bl __destroy_global_chain
	ldr r0, _020FD544 // =_021523F0
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _020FD538
	blx r0
	ldr r0, _020FD544 // =_021523F0
	mov r1, #0
	str r1, [r0, #4]
_020FD538:
	mov r0, r4
	bl __exit
	ldmia sp!, {r4, pc}
	.align 2, 0
_020FD544: .word _021523F0
	arm_func_end exit

	arm_func_start __exit
__exit: // 0x020FD548
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, _020FD658 // =_02152548
	bl OS_TryLockMutex
	cmp r0, #0
	bne _020FD580
	ldr r0, _020FD65C // =OSi_ThreadInfo
	ldr r1, _020FD660 // =_02152500
	ldr r2, [r0, #4]
	ldr r0, _020FD664 // =_02152524
	ldr r3, [r2, #0x6c]
	mov r2, #1
	str r3, [r1]
	str r2, [r0]
	b _020FD5D8
_020FD580:
	ldr r0, _020FD65C // =OSi_ThreadInfo
	ldr r1, _020FD660 // =_02152500
	ldr r0, [r0, #4]
	ldr r1, [r1, #0]
	ldr r0, [r0, #0x6c]
	cmp r1, r0
	bne _020FD5B0
	ldr r0, _020FD664 // =_02152524
	ldr r1, [r0, #0]
	add r1, r1, #1
	str r1, [r0]
	b _020FD5D8
_020FD5B0:
	ldr r0, _020FD658 // =_02152548
	bl OS_LockMutex
	ldr r0, _020FD65C // =OSi_ThreadInfo
	ldr r1, _020FD660 // =_02152500
	ldr r2, [r0, #4]
	ldr r0, _020FD664 // =_02152524
	ldr r3, [r2, #0x6c]
	mov r2, #1
	str r3, [r1]
	str r2, [r0]
_020FD5D8:
	ldr r4, _020FD668 // =_021523F0
	ldr r0, [r4, #8]
	cmp r0, #0
	ble _020FD60C
	ldr r5, _020FD66C // =_02152400
_020FD5EC:
	ldr r0, [r4, #8]
	sub r1, r0, #1
	ldr r0, [r5, r1, lsl #2]
	str r1, [r4, #8]
	blx r0
	ldr r0, [r4, #8]
	cmp r0, #0
	bgt _020FD5EC
_020FD60C:
	ldr r0, _020FD664 // =_02152524
	ldr r1, [r0, #0]
	subs r1, r1, #1
	str r1, [r0]
	bne _020FD628
	ldr r0, _020FD658 // =_02152548
	bl OS_UnlockMutex
_020FD628:
	ldr r0, _020FD668 // =_021523F0
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _020FD648
	blx r0
	ldr r0, _020FD668 // =_021523F0
	mov r1, #0
	str r1, [r0]
_020FD648:
	mov r0, #0
	bl fflush
	bl _ExitProcess
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_020FD658: .word _02152548
_020FD65C: .word OSi_ThreadInfo
_020FD660: .word _02152500
_020FD664: .word _02152524
_020FD668: .word _021523F0
_020FD66C: .word _02152400
	arm_func_end __exit

	arm_func_start nan
nan: // 0x020FD670
	ldr r0, _020FD680 // =0x021323F4
	ldr ip, _020FD684 // =_f2d
	ldr r0, [r0, #0]
	bx ip
	.align 2, 0
_020FD680: .word 0x021323F4
_020FD684: .word _f2d
	arm_func_end nan

	arm_func_start __flush_line_buffered_output_files
__flush_line_buffered_output_files: // 0x020FD688
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r0, _020FD710 // =_021322D4
	mov r4, #0
	mov r5, #1
	mov r8, r0
	mvn r9, #0
	mov r7, r4
	mov r6, #0x4c
_020FD6A8:
	ldr r1, [r0, #4]
	mov r2, r1, lsl #0x16
	movs r2, r2, lsr #0x1d
	beq _020FD6E8
	mov r1, r1, lsl #0x19
	mov r1, r1, lsr #0x1e
	tst r1, #1
	beq _020FD6E8
	ldr r1, [r0, #8]
	mov r1, r1, lsl #0x1d
	mov r1, r1, lsr #0x1d
	cmp r1, #1
	bne _020FD6E8
	bl fflush
	cmp r0, #0
	movne r4, r9
_020FD6E8:
	cmp r5, #3
	movge r0, r7
	bge _020FD700
	mul r0, r5, r6
	add r5, r5, #1
	add r0, r8, r0
_020FD700:
	cmp r0, #0
	bne _020FD6A8
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020FD710: .word _021322D4
	arm_func_end __flush_line_buffered_output_files

	arm_func_start __flush_all
__flush_all: // 0x020FD714
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r0, _020FD778 // =_021322D4
	mov r4, #0
	mov r5, #1
	mov r8, r0
	mvn r9, #0
	mov r7, r4
	mov r6, #0x4c
_020FD734:
	ldr r1, [r0, #4]
	mov r1, r1, lsl #0x16
	movs r1, r1, lsr #0x1d
	beq _020FD750
	bl fflush
	cmp r0, #0
	movne r4, r9
_020FD750:
	cmp r5, #3
	movge r0, r7
	bge _020FD768
	mul r0, r5, r6
	add r5, r5, #1
	add r0, r8, r0
_020FD768:
	cmp r0, #0
	bne _020FD734
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020FD778: .word _021322D4
	arm_func_end __flush_all

	arm_func_start abs
abs: // 0x020FD77C
	cmp r0, #0
	rsblt r0, r0, #0
	bx lr
	arm_func_end abs

	arm_func_start __msl_assertion_failed
__msl_assertion_failed: // 0x020FD788
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r0
	mov lr, r1
	mov ip, r2
	str r3, [sp]
	ldr r0, _020FD7C0 // =aAssertionSFail
	mov r1, r4
	mov r2, lr
	mov r3, ip
	bl printf
	bl abort
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_020FD7C0: .word aAssertionSFail
	arm_func_end __msl_assertion_failed

	arm_func_start __convert_from_newlines
__convert_from_newlines: // 0x020FD7C4
	bx lr
	arm_func_end __convert_from_newlines

	arm_func_start __convert_to_newlines
__convert_to_newlines: // 0x020FD7C8
	bx lr
	arm_func_end __convert_to_newlines

	arm_func_start __prep_buffer
__prep_buffer: // 0x020FD7CC
	ldr r1, [r0, #0x1c]
	str r1, [r0, #0x24]
	ldr r3, [r0, #0x20]
	str r3, [r0, #0x28]
	ldr r2, [r0, #0x18]
	ldr r1, [r0, #0x2c]
	and r1, r2, r1
	sub r1, r3, r1
	str r1, [r0, #0x28]
	ldr r1, [r0, #0x18]
	str r1, [r0, #0x34]
	bx lr
	arm_func_end __prep_buffer

	arm_func_start __load_buffer
__load_buffer: // 0x020FD7FC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r2
	mov r4, r0
	mov r6, r1
	bl __prep_buffer
	cmp r5, #1
	ldreq r0, [r4, #0x20]
	add r2, r4, #0x28
	streq r0, [r4, #0x28]
	ldr r0, [r4, #0]
	ldr r1, [r4, #0x1c]
	ldr r3, [r4, #0x48]
	ldr ip, [r4, #0x3c]
	blx ip
	cmp r0, #2
	moveq r1, #0
	streq r1, [r4, #0x28]
	cmp r6, #0
	ldrne r1, [r4, #0x28]
	strne r1, [r6]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r4, #0x18]
	ldr r0, [r4, #0x28]
	add r0, r1, r0
	str r0, [r4, #0x18]
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x13
	movs r0, r0, lsr #0x1f
	bne _020FD880
	ldr r0, [r4, #0x1c]
	add r1, r4, #0x28
	bl __convert_to_newlines
_020FD880:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end __load_buffer

	arm_func_start __flush_buffer
__flush_buffer: // 0x020FD888
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r2, [r5, #0x24]
	ldr r0, [r5, #0x1c]
	mov r4, r1
	subs r0, r2, r0
	beq _020FD900
	str r0, [r5, #0x28]
	ldr r0, [r5, #4]
	mov r0, r0, lsl #0x13
	movs r0, r0, lsr #0x1f
	bne _020FD8C4
	ldr r0, [r5, #0x1c]
	add r1, r5, #0x28
	bl __convert_from_newlines
_020FD8C4:
	ldr r0, [r5, #0]
	ldr r1, [r5, #0x1c]
	ldr r3, [r5, #0x48]
	ldr ip, [r5, #0x40]
	add r2, r5, #0x28
	blx ip
	cmp r4, #0
	ldrne r1, [r5, #0x28]
	strne r1, [r4]
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r1, [r5, #0x18]
	ldr r0, [r5, #0x28]
	add r0, r1, r0
	str r0, [r5, #0x18]
_020FD900:
	mov r0, r5
	bl __prep_buffer
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end __flush_buffer

	arm_func_start fread
fread: // 0x020FD910
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r4, _020FDA08 // =_021322D4
	mov r7, r3
	cmp r7, r4
	moveq r6, #2
	mov r10, r0
	movne r6, #5
	mov r0, #0x18
	mul r4, r6, r0
	ldr r5, _020FDA0C // =_02152548
	mov r9, r1
	add r0, r5, r4
	mov r8, r2
	bl OS_TryLockMutex
	cmp r0, #0
	bne _020FD974
	ldr r0, _020FDA10 // =OSi_ThreadInfo
	ldr r2, _020FDA14 // =_02152500
	ldr r1, [r0, #4]
	ldr r0, _020FDA18 // =_02152524
	ldr r3, [r1, #0x6c]
	mov r1, #1
	str r3, [r2, r6, lsl #2]
	str r1, [r0, r6, lsl #2]
	b _020FD9CC
_020FD974:
	ldr r0, _020FDA10 // =OSi_ThreadInfo
	ldr r1, _020FDA14 // =_02152500
	ldr r0, [r0, #4]
	ldr r1, [r1, r6, lsl #2]
	ldr r0, [r0, #0x6c]
	cmp r1, r0
	bne _020FD9A4
	ldr r1, _020FDA18 // =_02152524
	ldr r0, [r1, r6, lsl #2]
	add r0, r0, #1
	str r0, [r1, r6, lsl #2]
	b _020FD9CC
_020FD9A4:
	add r0, r5, r4
	bl OS_LockMutex
	ldr r0, _020FDA10 // =OSi_ThreadInfo
	ldr r2, _020FDA14 // =_02152500
	ldr r1, [r0, #4]
	ldr r0, _020FDA18 // =_02152524
	ldr r3, [r1, #0x6c]
	mov r1, #1
	str r3, [r2, r6, lsl #2]
	str r1, [r0, r6, lsl #2]
_020FD9CC:
	mov r0, r10
	mov r1, r9
	mov r2, r8
	mov r3, r7
	bl __fread
	ldr r1, _020FDA18 // =_02152524
	mov r7, r0
	ldr r0, [r1, r6, lsl #2]
	subs r0, r0, #1
	str r0, [r1, r6, lsl #2]
	bne _020FDA00
	add r0, r5, r4
	bl OS_UnlockMutex
_020FDA00:
	mov r0, r7
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020FDA08: .word _021322D4
_020FDA0C: .word _02152548
_020FDA10: .word OSi_ThreadInfo
_020FDA14: .word _02152500
_020FDA18: .word _02152524
	arm_func_end fread

	arm_func_start __fread
__fread: // 0x020FDA1C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #4
	mov r7, r3
	mov r9, r0
	mov r8, r1
	mov r0, r7
	mov r1, #0
	mov r4, r2
	bl fwide
	cmp r0, #0
	bne _020FDA54
	mov r0, r7
	mvn r1, #0
	bl fwide
_020FDA54:
	muls r4, r8, r4
	beq _020FDA78
	ldrb r0, [r7, #0xd]
	cmp r0, #0
	bne _020FDA78
	ldr r1, [r7, #4]
	mov r0, r1, lsl #0x16
	movs r0, r0, lsr #0x1d
	bne _020FDA84
_020FDA78:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_020FDA84:
	mov r0, r1, lsl #0x13
	movs r0, r0, lsr #0x1f
	movne r0, r1, lsl #0x19
	movne r0, r0, lsr #0x1e
	ldr r1, [r7, #8]
	cmpne r0, #2
	mov r6, #1
	mov r0, r1, lsl #0x1d
	movne r6, #0
	movs r0, r0, lsr #0x1d
	bne _020FDAD8
	ldr r0, [r7, #4]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1d
	tst r0, #1
	beq _020FDAD8
	bic r0, r1, #7
	orr r0, r0, #2
	str r0, [r7, #8]
	mov r0, #0
	str r0, [r7, #0x28]
_020FDAD8:
	ldr r0, [r7, #8]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1d
	cmp r0, #2
	bhs _020FDB04
	mov r0, #1
	strb r0, [r7, #0xd]
	mov r0, #0
	add sp, sp, #4
	str r0, [r7, #0x28]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_020FDB04:
	ldr r0, [r7, #4]
	mov r0, r0, lsl #0x19
	mov r0, r0, lsr #0x1e
	tst r0, #1
	beq _020FDB3C
	bl __flush_line_buffered_output_files
	cmp r0, #0
	beq _020FDB3C
	mov r0, #1
	strb r0, [r7, #0xd]
	mov r0, #0
	add sp, sp, #4
	str r0, [r7, #0x28]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_020FDB3C:
	cmp r4, #0
	mov r5, #0
	beq _020FDC00
	ldr r0, [r7, #8]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1d
	cmp r0, #3
	blo _020FDC00
	mov r10, r5
_020FDB60:
	mov r0, r7
	mov r1, r10
	bl fwide
	cmp r0, #1
	ldr r0, [r7, #8]
	bne _020FDB94
	mov r0, r0, lsl #0x1d
	add r0, r7, r0, lsr #28
	ldrh r0, [r0, #0xe]
	add r5, r5, #2
	sub r4, r4, #2
	strh r0, [r9], #2
	b _020FDBAC
_020FDB94:
	mov r0, r0, lsl #0x1d
	add r0, r7, r0, lsr #29
	ldrb r0, [r0, #0xf]
	add r5, r5, #1
	sub r4, r4, #1
	strb r0, [r9], #1
_020FDBAC:
	ldr r1, [r7, #8]
	cmp r4, #0
	mov r0, r1, lsl #0x1d
	mov r0, r0, lsr #0x1d
	sub r0, r0, #1
	bic r1, r1, #7
	and r0, r0, #7
	orr r0, r1, r0
	str r0, [r7, #8]
	beq _020FDBE8
	ldr r0, [r7, #8]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1d
	cmp r0, #3
	bhs _020FDB60
_020FDBE8:
	ldr r0, [r7, #8]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1d
	cmp r0, #2
	ldreq r0, [r7, #0x30]
	streq r0, [r7, #0x28]
_020FDC00:
	cmp r4, #0
	beq _020FDCC4
	ldr r0, [r7, #0x28]
	cmp r0, #0
	cmpeq r6, #0
	beq _020FDCC4
	mov r10, #0
_020FDC1C:
	ldr r0, [r7, #0x28]
	cmp r0, #0
	bne _020FDC70
	mov r0, r7
	mov r1, r10
	mov r2, r10
	bl __load_buffer
	cmp r0, #0
	beq _020FDC70
	cmp r0, #1
	mov r0, #1
	streqb r0, [r7, #0xd]
	beq _020FDC60
	ldr r1, [r7, #8]
	bic r1, r1, #7
	str r1, [r7, #8]
	strb r0, [r7, #0xc]
_020FDC60:
	mov r0, #0
	str r0, [r7, #0x28]
	mov r4, #0
	b _020FDCC4
_020FDC70:
	ldr r0, [r7, #0x28]
	str r0, [sp]
	cmp r0, r4
	strhi r4, [sp]
	ldr r1, [r7, #0x24]
	ldr r2, [sp]
	mov r0, r9
	bl memcpy
	ldr r2, [sp]
	ldr r0, [r7, #0x24]
	subs r4, r4, r2
	add r0, r0, r2
	str r0, [r7, #0x24]
	ldr r1, [r7, #0x28]
	ldr r0, [sp]
	add r9, r9, r2
	sub r0, r1, r0
	add r5, r5, r2
	str r0, [r7, #0x28]
	cmpne r6, #0
	bne _020FDC1C
_020FDCC4:
	cmp r4, #0
	beq _020FDD50
	cmp r6, #0
	bne _020FDD50
	ldr r6, [r7, #0x1c]
	ldr r10, [r7, #0x20]
	add r1, sp, #0
	str r9, [r7, #0x1c]
	mov r0, r7
	mov r2, #1
	str r4, [r7, #0x20]
	bl __load_buffer
	cmp r0, #0
	beq _020FDD30
	cmp r0, #1
	mov r0, #1
	bne _020FDD18
	strb r0, [r7, #0xd]
	mov r0, #0
	str r0, [r7, #0x28]
	b _020FDD30
_020FDD18:
	ldr r1, [r7, #8]
	bic r1, r1, #7
	str r1, [r7, #8]
	strb r0, [r7, #0xc]
	mov r0, #0
	str r0, [r7, #0x28]
_020FDD30:
	ldr r1, [sp]
	mov r0, r7
	str r6, [r7, #0x1c]
	str r10, [r7, #0x20]
	add r5, r5, r1
	bl __prep_buffer
	mov r0, #0
	str r0, [r7, #0x28]
_020FDD50:
	mov r0, r5
	mov r1, r8
	bl _u32_div_f
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end __fread

	arm_func_start __fwrite
__fwrite: // 0x020FDD64
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r9, r3
	mov r10, r0
	str r1, [sp]
	mov r0, r9
	mov r1, #0
	mov r4, r2
	bl fwide
	cmp r0, #0
	bne _020FDD9C
	mov r0, r9
	mvn r1, #0
	bl fwide
_020FDD9C:
	ldr r0, [sp]
	muls r5, r0, r4
	beq _020FDDC4
	ldrb r0, [r9, #0xd]
	cmp r0, #0
	bne _020FDDC4
	ldr r1, [r9, #4]
	mov r0, r1, lsl #0x16
	movs r0, r0, lsr #0x1d
	bne _020FDDD0
_020FDDC4:
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020FDDD0:
	mov r0, r1, lsl #0x13
	movs r0, r0, lsr #0x1f
	movne r0, r1, lsl #0x19
	movne r0, r0, lsr #0x1e
	cmpne r0, #2
	ldr r1, [r9, #8]
	cmpne r0, #1
	mov r8, #1
	mov r0, r1, lsl #0x1d
	movne r8, #0
	movs r0, r0, lsr #0x1d
	bne _020FDE28
	ldr r0, [r9, #4]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1d
	tst r0, #2
	beq _020FDE28
	bic r0, r1, #7
	orr r1, r0, #1
	mov r0, r9
	str r1, [r9, #8]
	bl __prep_buffer
_020FDE28:
	ldr r0, [r9, #8]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1d
	cmp r0, #1
	beq _020FDE54
	mov r0, #1
	strb r0, [r9, #0xd]
	mov r0, #0
	add sp, sp, #8
	str r0, [r9, #0x28]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020FDE54:
	cmp r5, #0
	mov r6, #0
	beq _020FDF7C
	ldr r0, [r9, #0x1c]
	ldr r2, [r9, #0x24]
	cmp r2, r0
	cmpeq r8, #0
	beq _020FDF7C
	ldr r1, [r9, #0x20]
	sub r0, r2, r0
	sub r0, r1, r0
	str r0, [r9, #0x28]
	mov r11, #0xa
	mov r4, #0
_020FDE8C:
	ldr r0, [r9, #0x28]
	mov r7, r4
	str r0, [sp, #4]
	cmp r0, r5
	strhi r5, [sp, #4]
	ldr r0, [r9, #4]
	mov r0, r0, lsl #0x19
	mov r0, r0, lsr #0x1e
	cmp r0, #1
	bne _020FDEDC
	ldr r2, [sp, #4]
	cmp r2, #0
	beq _020FDEDC
	mov r0, r10
	mov r1, r11
	bl __memrchr
	movs r7, r0
	addne r0, r7, #1
	subne r0, r0, r10
	strne r0, [sp, #4]
_020FDEDC:
	ldr r2, [sp, #4]
	cmp r2, #0
	beq _020FDF1C
	ldr r0, [r9, #0x24]
	mov r1, r10
	bl memcpy
	ldr r2, [sp, #4]
	ldr r0, [r9, #0x24]
	add r10, r10, r2
	add r0, r0, r2
	str r0, [r9, #0x24]
	ldr r1, [r9, #0x28]
	ldr r0, [sp, #4]
	sub r5, r5, r2
	sub r0, r1, r0
	str r0, [r9, #0x28]
_020FDF1C:
	ldr r0, [r9, #0x28]
	cmp r0, #0
	beq _020FDF40
	cmp r7, #0
	bne _020FDF40
	ldr r0, [r9, #4]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1e
	bne _020FDF68
_020FDF40:
	mov r0, r9
	mov r1, #0
	bl __flush_buffer
	cmp r0, #0
	beq _020FDF68
	mov r0, #1
	strb r0, [r9, #0xd]
	mov r5, #0
	str r5, [r9, #0x28]
	b _020FDF7C
_020FDF68:
	ldr r0, [sp, #4]
	cmp r5, #0
	add r6, r6, r0
	cmpne r8, #0
	bne _020FDE8C
_020FDF7C:
	cmp r5, #0
	beq _020FDFE8
	cmp r8, #0
	bne _020FDFE8
	ldr r4, [r9, #0x1c]
	ldr r7, [r9, #0x20]
	add r2, r10, r5
	str r10, [r9, #0x1c]
	str r5, [r9, #0x20]
	add r1, sp, #4
	mov r0, r9
	str r2, [r9, #0x24]
	bl __flush_buffer
	cmp r0, #0
	ldreq r0, [sp, #4]
	addeq r6, r6, r0
	beq _020FDFD0
	mov r0, #1
	strb r0, [r9, #0xd]
	mov r0, #0
	str r0, [r9, #0x28]
_020FDFD0:
	str r4, [r9, #0x1c]
	mov r0, r9
	str r7, [r9, #0x20]
	bl __prep_buffer
	mov r0, #0
	str r0, [r9, #0x28]
_020FDFE8:
	ldr r0, [r9, #4]
	ldr r1, [sp]
	mov r0, r0, lsl #0x19
	mov r0, r0, lsr #0x1e
	cmp r0, #2
	movne r0, #0
	strne r0, [r9, #0x28]
	mov r0, r6
	bl _u32_div_f
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end __fwrite

	arm_func_start fclose
fclose: // 0x020FE014
	stmdb sp!, {r3, r4, r5, lr}
	movs r5, r0
	mvneq r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r5, #4]
	mov r1, r1, lsl #0x16
	movs r1, r1, lsr #0x1d
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	bl fflush
	mov r4, r0
	ldr r0, [r5, #0]
	ldr r1, [r5, #0x44]
	blx r1
	ldr r1, [r5, #4]
	mov r2, #0
	bic r1, r1, #0x380
	str r1, [r5, #4]
	str r2, [r5]
	ldr r1, [r5, #8]
	mov r1, r1, lsl #0x1c
	movs r1, r1, lsr #0x1f
	subne r0, r2, #1
	ldmneia sp!, {r3, r4, r5, pc}
	cmp r4, #0
	cmpeq r0, #0
	movne r2, #1
	rsb r0, r2, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end fclose

	arm_func_start fflush
fflush: // 0x020FE088
	stmdb sp!, {r4, lr}
	movs r4, r0
	bne _020FE09C
	bl __flush_all
	ldmia sp!, {r4, pc}
_020FE09C:
	ldrb r0, [r4, #0xd]
	cmp r0, #0
	bne _020FE0B8
	ldr r0, [r4, #4]
	mov r1, r0, lsl #0x16
	movs r1, r1, lsr #0x1d
	bne _020FE0C0
_020FE0B8:
	mvn r0, #0
	ldmia sp!, {r4, pc}
_020FE0C0:
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1d
	cmp r0, #1
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #8]
	mov r1, r0, lsl #0x1d
	mov r1, r1, lsr #0x1d
	cmp r1, #3
	bichs r0, r0, #7
	orrhs r0, r0, #2
	strhs r0, [r4, #8]
	ldr r0, [r4, #8]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1d
	cmp r0, #2
	moveq r0, #0
	streq r0, [r4, #0x28]
	ldr r0, [r4, #8]
	mov r1, r0, lsl #0x1d
	mov r1, r1, lsr #0x1d
	cmp r1, #1
	beq _020FE12C
	bic r0, r0, #7
	str r0, [r4, #8]
	mov r0, #0
	ldmia sp!, {r4, pc}
_020FE12C:
	mov r0, r4
	mov r1, #0
	bl __flush_buffer
	cmp r0, #0
	mov r0, #0
	beq _020FE158
	mov r1, #1
	strb r1, [r4, #0xd]
	str r0, [r4, #0x28]
	sub r0, r0, #1
	ldmia sp!, {r4, pc}
_020FE158:
	ldr r1, [r4, #8]
	bic r1, r1, #7
	str r1, [r4, #8]
	str r0, [r4, #0x18]
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
	arm_func_end fflush

	arm_func_start __msl_strrev
__msl_strrev: // 0x020FE170
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, #0
	bl strlen
	sub r2, r0, #1
	cmp r2, #0
	ble _020FE1AC
_020FE18C:
	ldrsb r1, [r5, r4]
	ldrsb r0, [r5, r2]
	strb r0, [r5, r4]
	strb r1, [r5, r2]
	add r4, r4, #1
	sub r2, r2, #1
	cmp r4, r2
	blt _020FE18C
_020FE1AC:
	mov r0, r5
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end __msl_strrev

	arm_func_start __msl_itoa
__msl_itoa: // 0x020FE1B4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r8, r0
	mov r5, #0
	mov r6, r5
	mov r4, r1
	mov r7, r2
	rsbmi r8, r8, #0
	movmi r5, #1
_020FE1D4:
	mov r0, r8
	mov r1, r7
	bl _u32_div_f
	cmp r1, #9
	addgt r0, r1, #0x37
	addle r0, r1, #0x30
	strb r0, [r4, r6]
	mov r0, r8
	mov r1, r7
	add r6, r6, #1
	bl _u32_div_f
	movs r8, r0
	bne _020FE1D4
	cmp r5, #0
	movne r0, #0x2d
	strneb r0, [r4, r6]
	addne r6, r6, #1
	mov r1, #0
	mov r0, r4
	strb r1, [r4, r6]
	bl __msl_strrev
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end __msl_itoa

	arm_func_start _ftell
_ftell: // 0x020FE230
	ldr r1, [r0, #4]
	mov r1, r1, lsl #0x16
	mov r1, r1, lsr #0x1d
	and r1, r1, #0xff
	add r1, r1, #0xff
	and r1, r1, #0xff
	cmp r1, #1
	bhi _020FE25C
	ldrb r1, [r0, #0xd]
	cmp r1, #0
	beq _020FE270
_020FE25C:
	ldr r0, _020FE2A8 // =errno
	mov r1, #0x28
	str r1, [r0]
	sub r0, r1, #0x29
	bx lr
_020FE270:
	ldr r1, [r0, #8]
	mov r1, r1, lsl #0x1d
	movs ip, r1, lsr #0x1d
	ldreq r0, [r0, #0x18]
	bxeq lr
	ldr r2, [r0, #0x24]
	ldr r1, [r0, #0x1c]
	ldr r3, [r0, #0x34]
	sub r0, r2, r1
	cmp ip, #3
	add r0, r3, r0
	subhs r1, ip, #2
	subhs r0, r0, r1
	bx lr
	.align 2, 0
_020FE2A8: .word errno
	arm_func_end _ftell

	arm_func_start ftell
ftell: // 0x020FE2AC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r1, _020FE3AC // =_021322D4
	mov r7, r0
	cmp r7, r1
	moveq r6, #2
	beq _020FE2E4
	ldr r0, _020FE3B0 // =0x02132320
	cmp r7, r0
	moveq r6, #3
	beq _020FE2E4
	ldr r0, _020FE3B4 // =0x0213236C
	cmp r7, r0
	moveq r6, #4
	movne r6, #5
_020FE2E4:
	mov r0, #0x18
	mul r4, r6, r0
	ldr r5, _020FE3B8 // =_02152548
	add r0, r5, r4
	bl OS_TryLockMutex
	cmp r0, #0
	bne _020FE324
	ldr r0, _020FE3BC // =OSi_ThreadInfo
	ldr r2, _020FE3C0 // =_02152500
	ldr r1, [r0, #4]
	ldr r0, _020FE3C4 // =_02152524
	ldr r3, [r1, #0x6c]
	mov r1, #1
	str r3, [r2, r6, lsl #2]
	str r1, [r0, r6, lsl #2]
	b _020FE37C
_020FE324:
	ldr r0, _020FE3BC // =OSi_ThreadInfo
	ldr r1, _020FE3C0 // =_02152500
	ldr r0, [r0, #4]
	ldr r1, [r1, r6, lsl #2]
	ldr r0, [r0, #0x6c]
	cmp r1, r0
	bne _020FE354
	ldr r1, _020FE3C4 // =_02152524
	ldr r0, [r1, r6, lsl #2]
	add r0, r0, #1
	str r0, [r1, r6, lsl #2]
	b _020FE37C
_020FE354:
	add r0, r5, r4
	bl OS_LockMutex
	ldr r0, _020FE3BC // =OSi_ThreadInfo
	ldr r2, _020FE3C0 // =_02152500
	ldr r1, [r0, #4]
	ldr r0, _020FE3C4 // =_02152524
	ldr r3, [r1, #0x6c]
	mov r1, #1
	str r3, [r2, r6, lsl #2]
	str r1, [r0, r6, lsl #2]
_020FE37C:
	mov r0, r7
	bl _ftell
	ldr r1, _020FE3C4 // =_02152524
	mov r7, r0
	ldr r0, [r1, r6, lsl #2]
	subs r0, r0, #1
	str r0, [r1, r6, lsl #2]
	bne _020FE3A4
	add r0, r5, r4
	bl OS_UnlockMutex
_020FE3A4:
	mov r0, r7
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_020FE3AC: .word _021322D4
_020FE3B0: .word 0x02132320
_020FE3B4: .word 0x0213236C
_020FE3B8: .word _02152548
_020FE3BC: .word OSi_ThreadInfo
_020FE3C0: .word _02152500
_020FE3C4: .word _02152524
	arm_func_end ftell

	arm_func_start _fseek
_fseek: // 0x020FE3C8
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r1, [r5, #4]
	mov r4, r2
	mov r1, r1, lsl #0x16
	mov r1, r1, lsr #0x1d
	and r1, r1, #0xff
	cmp r1, #1
	ldreqb r1, [r5, #0xd]
	cmpeq r1, #0
	beq _020FE414
	ldr r0, _020FE5AC // =errno
	mov r1, #0x28
	str r1, [r0]
	sub r0, r1, #0x29
	ldmia sp!, {r3, r4, r5, lr}
	add sp, sp, #0x10
	bx lr
_020FE414:
	ldr r1, [r5, #8]
	mov r1, r1, lsl #0x1d
	mov r1, r1, lsr #0x1d
	cmp r1, #1
	bne _020FE464
	mov r1, #0
	bl __flush_buffer
	cmp r0, #0
	beq _020FE464
	mov r0, #1
	strb r0, [r5, #0xd]
	mov r2, #0
	ldr r0, _020FE5AC // =errno
	mov r1, #0x28
	str r2, [r5, #0x28]
	str r1, [r0]
	sub r0, r1, #0x29
	ldmia sp!, {r3, r4, r5, lr}
	add sp, sp, #0x10
	bx lr
_020FE464:
	cmp r4, #1
	bne _020FE484
	mov r0, r5
	mov r4, #0
	bl _ftell
	ldr r1, [sp, #0x14]
	add r0, r1, r0
	str r0, [sp, #0x14]
_020FE484:
	cmp r4, #2
	beq _020FE518
	ldr r0, [r5, #4]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1d
	cmp r0, #3
	beq _020FE518
	ldr r0, [r5, #8]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1d
	sub r0, r0, #2
	cmp r0, #1
	bhi _020FE518
	ldr r2, [sp, #0x14]
	ldr r0, [r5, #0x18]
	cmp r2, r0
	bhs _020FE4D4
	ldr r0, [r5, #0x34]
	cmp r2, r0
	bhs _020FE4E4
_020FE4D4:
	ldr r0, [r5, #8]
	bic r0, r0, #7
	str r0, [r5, #8]
	b _020FE524
_020FE4E4:
	ldr r1, [r5, #0x1c]
	sub r0, r2, r0
	add r0, r1, r0
	str r0, [r5, #0x24]
	ldr r1, [r5, #0x18]
	ldr r0, [sp, #0x14]
	sub r0, r1, r0
	str r0, [r5, #0x28]
	ldr r0, [r5, #8]
	bic r0, r0, #7
	orr r0, r0, #2
	str r0, [r5, #8]
	b _020FE524
_020FE518:
	ldr r0, [r5, #8]
	bic r0, r0, #7
	str r0, [r5, #8]
_020FE524:
	ldr r0, [r5, #8]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1d
	bne _020FE59C
	ldr ip, [r5, #0x38]
	cmp ip, #0
	beq _020FE588
	ldr r0, [r5, #0]
	ldr r3, [r5, #0x48]
	add r1, sp, #0x14
	mov r2, r4
	blx ip
	cmp r0, #0
	beq _020FE588
	mov r0, #1
	strb r0, [r5, #0xd]
	mov r2, #0
	ldr r0, _020FE5AC // =errno
	mov r1, #0x28
	str r2, [r5, #0x28]
	str r1, [r0]
	sub r0, r1, #0x29
	ldmia sp!, {r3, r4, r5, lr}
	add sp, sp, #0x10
	bx lr
_020FE588:
	mov r1, #0
	strb r1, [r5, #0xc]
	ldr r0, [sp, #0x14]
	str r0, [r5, #0x18]
	str r1, [r5, #0x28]
_020FE59C:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020FE5AC: .word errno
	arm_func_end _fseek

	arm_func_start fseek
fseek: // 0x020FE5B0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r3, _020FE6C0 // =_021322D4
	mov r9, r0
	cmp r9, r3
	mov r8, r1
	mov r7, r2
	moveq r6, #2
	beq _020FE5F0
	ldr r0, _020FE6C4 // =0x02132320
	cmp r9, r0
	moveq r6, #3
	beq _020FE5F0
	ldr r0, _020FE6C8 // =0x0213236C
	cmp r9, r0
	moveq r6, #4
	movne r6, #5
_020FE5F0:
	mov r0, #0x18
	mul r4, r6, r0
	ldr r5, _020FE6CC // =_02152548
	add r0, r5, r4
	bl OS_TryLockMutex
	cmp r0, #0
	bne _020FE630
	ldr r0, _020FE6D0 // =OSi_ThreadInfo
	ldr r2, _020FE6D4 // =_02152500
	ldr r1, [r0, #4]
	ldr r0, _020FE6D8 // =_02152524
	ldr r3, [r1, #0x6c]
	mov r1, #1
	str r3, [r2, r6, lsl #2]
	str r1, [r0, r6, lsl #2]
	b _020FE688
_020FE630:
	ldr r0, _020FE6D0 // =OSi_ThreadInfo
	ldr r1, _020FE6D4 // =_02152500
	ldr r0, [r0, #4]
	ldr r1, [r1, r6, lsl #2]
	ldr r0, [r0, #0x6c]
	cmp r1, r0
	bne _020FE660
	ldr r1, _020FE6D8 // =_02152524
	ldr r0, [r1, r6, lsl #2]
	add r0, r0, #1
	str r0, [r1, r6, lsl #2]
	b _020FE688
_020FE660:
	add r0, r5, r4
	bl OS_LockMutex
	ldr r0, _020FE6D0 // =OSi_ThreadInfo
	ldr r2, _020FE6D4 // =_02152500
	ldr r1, [r0, #4]
	ldr r0, _020FE6D8 // =_02152524
	ldr r3, [r1, #0x6c]
	mov r1, #1
	str r3, [r2, r6, lsl #2]
	str r1, [r0, r6, lsl #2]
_020FE688:
	mov r0, r9
	mov r1, r8
	mov r2, r7
	bl _fseek
	ldr r1, _020FE6D8 // =_02152524
	mov r7, r0
	ldr r0, [r1, r6, lsl #2]
	subs r0, r0, #1
	str r0, [r1, r6, lsl #2]
	bne _020FE6B8
	add r0, r5, r4
	bl OS_UnlockMutex
_020FE6B8:
	mov r0, r7
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020FE6C0: .word _021322D4
_020FE6C4: .word 0x02132320
_020FE6C8: .word 0x0213236C
_020FE6CC: .word _02152548
_020FE6D0: .word OSi_ThreadInfo
_020FE6D4: .word _02152500
_020FE6D8: .word _02152524
	arm_func_end fseek

	arm_func_start rewind
rewind: // 0x020FE6DC
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r4, r0
	mov r2, r1
	strb r1, [r4, #0xd]
	bl fseek
	mov r0, #0
	strb r0, [r4, #0xd]
	ldmia sp!, {r4, pc}
	arm_func_end rewind

	arm_func_start mbtowc
mbtowc: // 0x020FE700
	stmdb sp!, {r3, lr}
	ldr r3, _020FE718 // =_02132514
	ldr r3, [r3, #8]
	ldr r3, [r3, #0]
	blx r3
	ldmia sp!, {r3, pc}
	.align 2, 0
_020FE718: .word _02132514
	arm_func_end mbtowc

	arm_func_start __mbtowc_noconv
__mbtowc_noconv: // 0x020FE71C
	cmp r1, #0
	moveq r0, #0
	bxeq lr
	cmp r2, #0
	mvneq r0, #0
	bxeq lr
	cmp r0, #0
	ldrneb r2, [r1, #0]
	strneh r2, [r0]
	ldrsb r0, [r1, #0]
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	bx lr
	arm_func_end __mbtowc_noconv

	arm_func_start __wctomb_noconv
__wctomb_noconv: // 0x020FE754
	cmp r0, #0
	moveq r0, #0
	strneb r1, [r0]
	movne r0, #1
	bx lr
	arm_func_end __wctomb_noconv

	arm_func_start wctomb
wctomb: // 0x020FE768
	stmdb sp!, {r3, lr}
	ldr r2, _020FE780 // =_02132514
	ldr r2, [r2, #8]
	ldr r2, [r2, #4]
	blx r2
	ldmia sp!, {r3, pc}
	.align 2, 0
_020FE780: .word _02132514
	arm_func_end wctomb

	arm_func_start mbstowcs
mbstowcs: // 0x020FE784
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r1
	mov r8, r0
	mov r0, r7
	mov r6, r2
	bl strlen
	mov r5, r0
	cmp r8, #0
	mov r4, #0
	beq _020FE804
	cmp r6, #0
	bls _020FE804
_020FE7B4:
	ldrsb r0, [r7, #0]
	cmp r0, #0
	beq _020FE7EC
	mov r0, r8
	mov r1, r7
	mov r2, r5
	bl mbtowc
	cmp r0, #0
	add r8, r8, #2
	addgt r7, r7, r0
	subgt r5, r5, r0
	bgt _020FE7F8
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020FE7EC:
	mov r0, #0
	strh r0, [r8]
	b _020FE804
_020FE7F8:
	add r4, r4, #1
	cmp r4, r6
	blo _020FE7B4
_020FE804:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end mbstowcs

	arm_func_start wcstombs
wcstombs: // 0x020FE80C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	movs r4, r0
	mov r9, r1
	cmpne r9, #0
	mov r8, r2
	mov r7, #0
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r6, sp, #0
_020FE830:
	ldrh r1, [r9, #0]
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r4, r7]
	beq _020FE87C
	mov r0, r6
	add r9, r9, #2
	bl wctomb
	mov r5, r0
	add r0, r7, r5
	cmp r0, r8
	bhi _020FE87C
	mov r1, r6
	mov r2, r5
	add r0, r4, r7
	bl strncpy
	add r7, r7, r5
	cmp r7, r8
	bls _020FE830
_020FE87C:
	mov r0, r7
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end wcstombs

	arm_func_start memcpy
memcpy: // 0x020FE884
	mov ip, r0
	cmp r2, #0
	bxeq lr
_020FE890:
	ldrsb r3, [r1], #1
	subs r2, r2, #1
	strb r3, [ip], #1
	bne _020FE890
	bx lr
	arm_func_end memcpy

	arm_func_start memmove
memmove: // 0x020FE8A4
	cmp r1, r0
	blo _020FE8CC
	mov ip, r0
	cmp r2, #0
	bxeq lr
_020FE8B8:
	ldrsb r3, [r1], #1
	subs r2, r2, #1
	strb r3, [ip], #1
	bne _020FE8B8
	bx lr
_020FE8CC:
	cmp r2, #0
	add r3, r1, r2
	add ip, r0, r2
	bxeq lr
_020FE8DC:
	ldrsb r1, [r3, #-1]!
	subs r2, r2, #1
	strb r1, [ip, #-1]!
	bne _020FE8DC
	bx lr
	arm_func_end memmove

	arm_func_start memset
memset: // 0x020FE8F0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl __fill_mem
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end memset

	arm_func_start memchr
memchr: // 0x020FE904
	cmp r2, #0
	and r3, r1, #0xff
	beq _020FE928
_020FE910:
	ldrb r1, [r0], #1
	cmp r1, r3
	subeq r0, r0, #1
	bxeq lr
	subs r2, r2, #1
	bne _020FE910
_020FE928:
	mov r0, #0
	bx lr
	arm_func_end memchr

	arm_func_start __memrchr
__memrchr: // 0x020FE930
	cmp r2, #0
	and r3, r1, #0xff
	add r0, r0, r2
	beq _020FE954
_020FE940:
	ldrb r1, [r0, #-1]!
	cmp r1, r3
	bxeq lr
	subs r2, r2, #1
	bne _020FE940
_020FE954:
	mov r0, #0
	bx lr
	arm_func_end __memrchr

	arm_func_start memcmp
memcmp: // 0x020FE95C
	cmp r2, #0
	beq _020FE994
_020FE964:
	ldrb ip, [r0], #1
	ldrb r3, [r1], #1
	cmp ip, r3
	beq _020FE98C
	ldrb r2, [r0, #-1]
	ldrb r0, [r1, #-1]
	cmp r2, r0
	mvnlo r0, #0
	movhs r0, #1
	bx lr
_020FE98C:
	subs r2, r2, #1
	bne _020FE964
_020FE994:
	mov r0, #0
	bx lr
	arm_func_end memcmp

	arm_func_start __fill_mem
__fill_mem: // 0x020FE99C
	cmp r2, #0x20
	and r3, r1, #0xff
	blo _020FEA30
	rsb r1, r0, #0
	ands ip, r1, #3
	beq _020FE9C8
	sub r2, r2, ip
	and r1, r3, #0xff
_020FE9BC:
	strb r1, [r0], #1
	subs ip, ip, #1
	bne _020FE9BC
_020FE9C8:
	cmp r3, #0
	beq _020FE9E0
	mov r1, r3, lsl #0x10
	orr r1, r1, r3, lsl #24
	orr r1, r1, r3, lsl #8
	orr r3, r3, r1
_020FE9E0:
	movs r1, r2, lsr #5
	beq _020FEA14
_020FE9E8:
	str r3, [r0]
	str r3, [r0, #4]
	str r3, [r0, #8]
	str r3, [r0, #0xc]
	str r3, [r0, #0x10]
	str r3, [r0, #0x14]
	str r3, [r0, #0x18]
	str r3, [r0, #0x1c]
	add r0, r0, #0x20
	subs r1, r1, #1
	bne _020FE9E8
_020FEA14:
	and r1, r2, #0x1f
	movs r1, r1, lsr #2
	beq _020FEA2C
_020FEA20:
	str r3, [r0], #4
	subs r1, r1, #1
	bne _020FEA20
_020FEA2C:
	and r2, r2, #3
_020FEA30:
	cmp r2, #0
	bxeq lr
	and r1, r3, #0xff
_020FEA3C:
	strb r1, [r0], #1
	subs r2, r2, #1
	bne _020FEA3C
	bx lr
	arm_func_end __fill_mem

	arm_func_start parse_format__printf
parse_format__printf: // 0x020FEA4C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	ldrsb r3, [r0, #1]
	mov r4, #0
	mov r5, #1
	mov lr, r2
	strb r5, [sp]
	strb r4, [sp, #1]
	strb r4, [sp, #2]
	strb r4, [sp, #3]
	strb r4, [sp, #4]
	str r4, [sp, #8]
	str r4, [sp, #0xc]
	cmp r3, #0x25
	add ip, r0, #1
	bne _020FEAA8
	add r0, sp, #0
	strb r3, [sp, #5]
	ldmia r0, {r0, r1, r2, r3}
	stmia lr, {r0, r1, r2, r3}
	add sp, sp, #0x10
	add r0, ip, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020FEAA8:
	mov r2, #2
	mov r0, r4
	mov r5, r2
	mov r6, r4
	mov r7, #1
_020FEABC:
	mov r8, r7
	cmp r3, #0x2b
	bgt _020FEAEC
	bge _020FEB14
	cmp r3, #0x23
	bgt _020FEB44
	cmp r3, #0x20
	blt _020FEB44
	beq _020FEB1C
	cmp r3, #0x23
	beq _020FEB2C
	b _020FEB44
_020FEAEC:
	cmp r3, #0x30
	bgt _020FEB44
	cmp r3, #0x2d
	blt _020FEB44
	beq _020FEB0C
	cmp r3, #0x30
	beq _020FEB34
	b _020FEB44
_020FEB0C:
	strb r6, [sp]
	b _020FEB48
_020FEB14:
	strb r7, [sp, #1]
	b _020FEB48
_020FEB1C:
	ldrb r4, [sp, #1]
	cmp r4, #1
	strneb r5, [sp, #1]
	b _020FEB48
_020FEB2C:
	strb r7, [sp, #3]
	b _020FEB48
_020FEB34:
	ldrb r4, [sp]
	cmp r4, #0
	strneb r2, [sp]
	b _020FEB48
_020FEB44:
	mov r8, r0
_020FEB48:
	cmp r8, #0
	ldrnesb r3, [ip, #1]!
	bne _020FEABC
	cmp r3, #0x2a
	bne _020FEB90
	ldr r0, [r1, #0]
	add r0, r0, #4
	str r0, [r1]
	ldr r0, [r0, #-4]
	str r0, [sp, #8]
	cmp r0, #0
	bge _020FEB88
	rsb r0, r0, #0
	mov r2, #0
	strb r2, [sp]
	str r0, [sp, #8]
_020FEB88:
	ldrsb r3, [ip, #1]!
	b _020FEBE0
_020FEB90:
	ldr r4, _020FEFD4 // =__ctype_mapC
	mov r5, #0
	mov r0, #0xa
	b _020FEBB4
_020FEBA0:
	ldr r2, [sp, #8]
	sub r3, r3, #0x30
	mla r6, r2, r0, r3
	ldrsb r3, [ip, #1]!
	str r6, [sp, #8]
_020FEBB4:
	cmp r3, #0
	blt _020FEBC4
	cmp r3, #0x80
	blt _020FEBCC
_020FEBC4:
	mov r2, r5
	b _020FEBD8
_020FEBCC:
	mov r2, r3, lsl #1
	ldrh r2, [r4, r2]
	and r2, r2, #8
_020FEBD8:
	cmp r2, #0
	bne _020FEBA0
_020FEBE0:
	ldr r2, [sp, #8]
	ldr r0, _020FEFD8 // =0x000001FD
	cmp r2, r0
	ble _020FEC10
	mov r1, #0xff
	add r0, sp, #0
	strb r1, [sp, #5]
	ldmia r0, {r0, r1, r2, r3}
	stmia lr, {r0, r1, r2, r3}
	add sp, sp, #0x10
	add r0, ip, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020FEC10:
	cmp r3, #0x2e
	bne _020FECA4
	ldrsb r3, [ip, #1]!
	mov r0, #1
	strb r0, [sp, #2]
	cmp r3, #0x2a
	bne _020FEC54
	ldr r0, [r1, #0]
	add r0, r0, #4
	str r0, [r1]
	ldr r0, [r0, #-4]
	ldrsb r3, [ip, #1]!
	str r0, [sp, #0xc]
	cmp r0, #0
	movlt r0, #0
	strltb r0, [sp, #2]
	b _020FECA4
_020FEC54:
	ldr r2, _020FEFD4 // =__ctype_mapC
	mov r4, #0
	mov r0, #0xa
	b _020FEC78
_020FEC64:
	ldr r1, [sp, #0xc]
	sub r3, r3, #0x30
	mla r5, r1, r0, r3
	ldrsb r3, [ip, #1]!
	str r5, [sp, #0xc]
_020FEC78:
	cmp r3, #0
	blt _020FEC88
	cmp r3, #0x80
	blt _020FEC90
_020FEC88:
	mov r1, r4
	b _020FEC9C
_020FEC90:
	mov r1, r3, lsl #1
	ldrh r1, [r2, r1]
	and r1, r1, #8
_020FEC9C:
	cmp r1, #0
	bne _020FEC64
_020FECA4:
	cmp r3, #0x6c
	mov r0, #1
	bgt _020FECDC
	cmp r3, #0x68
	blt _020FECD0
	beq _020FECF8
	cmp r3, #0x6a
	beq _020FED44
	cmp r3, #0x6c
	beq _020FED14
	b _020FED68
_020FECD0:
	cmp r3, #0x4c
	beq _020FED38
	b _020FED68
_020FECDC:
	cmp r3, #0x74
	bgt _020FECEC
	beq _020FED50
	b _020FED68
_020FECEC:
	cmp r3, #0x7a
	beq _020FED5C
	b _020FED68
_020FECF8:
	ldrsb r1, [ip, #1]
	mov r2, #2
	strb r2, [sp, #4]
	cmp r1, #0x68
	streqb r0, [sp, #4]
	ldreqsb r3, [ip, #1]!
	b _020FED6C
_020FED14:
	ldrsb r1, [ip, #1]
	mov r2, #3
	strb r2, [sp, #4]
	cmp r1, #0x6c
	bne _020FED6C
	mov r1, #4
	strb r1, [sp, #4]
	ldrsb r3, [ip, #1]!
	b _020FED6C
_020FED38:
	mov r1, #9
	strb r1, [sp, #4]
	b _020FED6C
_020FED44:
	mov r1, #6
	strb r1, [sp, #4]
	b _020FED6C
_020FED50:
	mov r1, #8
	strb r1, [sp, #4]
	b _020FED6C
_020FED5C:
	mov r1, #7
	strb r1, [sp, #4]
	b _020FED6C
_020FED68:
	mov r0, #0
_020FED6C:
	cmp r0, #0
	ldrnesb r3, [ip, #1]!
	strb r3, [sp, #5]
	cmp r3, #0x61
	bgt _020FEDC0
	bge _020FEEA8
	cmp r3, #0x47
	bgt _020FEDB4
	subs r0, r3, #0x41
	addpl pc, pc, r0, lsl #2
	b _020FEFB4
_020FED98: // jump table
	b _020FEEA8 // case 0
	b _020FEFB4 // case 1
	b _020FEFB4 // case 2
	b _020FEFB4 // case 3
	b _020FEEF0 // case 4
	b _020FEE70 // case 5
	b _020FEEE0 // case 6
_020FEDB4:
	cmp r3, #0x58
	beq _020FEE34
	b _020FEFB4
_020FEDC0:
	cmp r3, #0x63
	bgt _020FEDD0
	beq _020FEF50
	b _020FEFB4
_020FEDD0:
	sub r0, r3, #0x64
	cmp r0, #0x14
	addls pc, pc, r0, lsl #2
	b _020FEFB4
_020FEDE0: // jump table
	b _020FEE34 // case 0
	b _020FEEF0 // case 1
	b _020FEE70 // case 2
	b _020FEEE0 // case 3
	b _020FEFB4 // case 4
	b _020FEE34 // case 5
	b _020FEFB4 // case 6
	b _020FEFB4 // case 7
	b _020FEFB4 // case 8
	b _020FEFB4 // case 9
	b _020FEFA0 // case 10
	b _020FEE34 // case 11
	b _020FEF2C // case 12
	b _020FEFB4 // case 13
	b _020FEFB4 // case 14
	b _020FEF7C // case 15
	b _020FEFB4 // case 16
	b _020FEE34 // case 17
	b _020FEFB4 // case 18
	b _020FEFB4 // case 19
	b _020FEE34 // case 20
_020FEE34:
	ldrb r0, [sp, #4]
	cmp r0, #9
	moveq r0, #0xff
	streqb r0, [sp, #5]
	beq _020FEFBC
	ldrb r0, [sp, #2]
	cmp r0, #0
	moveq r0, #1
	streq r0, [sp, #0xc]
	beq _020FEFBC
	ldrb r0, [sp]
	cmp r0, #2
	moveq r0, #1
	streqb r0, [sp]
	b _020FEFBC
_020FEE70:
	ldrb r0, [sp, #4]
	cmp r0, #2
	cmpne r0, #6
	cmpne r0, #7
	cmpne r0, #8
	cmpne r0, #4
	moveq r0, #0xff
	streqb r0, [sp, #5]
	beq _020FEFBC
	ldrb r0, [sp, #2]
	cmp r0, #0
	moveq r0, #6
	streq r0, [sp, #0xc]
	b _020FEFBC
_020FEEA8:
	ldrb r0, [sp, #2]
	cmp r0, #0
	moveq r0, #0xd
	streq r0, [sp, #0xc]
	ldrb r0, [sp, #4]
	cmp r0, #2
	cmpne r0, #6
	cmpne r0, #7
	cmpne r0, #8
	cmpne r0, #4
	cmpne r0, #1
	moveq r0, #0xff
	streqb r0, [sp, #5]
	b _020FEFBC
_020FEEE0:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	moveq r0, #1
	streq r0, [sp, #0xc]
_020FEEF0:
	ldrb r0, [sp, #4]
	cmp r0, #2
	cmpne r0, #6
	cmpne r0, #7
	cmpne r0, #8
	cmpne r0, #4
	cmpne r0, #1
	moveq r0, #0xff
	streqb r0, [sp, #5]
	beq _020FEFBC
	ldrb r0, [sp, #2]
	cmp r0, #0
	moveq r0, #6
	streq r0, [sp, #0xc]
	b _020FEFBC
_020FEF2C:
	mov r3, #0x78
	mov r2, #1
	mov r1, #3
	mov r0, #8
	strb r3, [sp, #5]
	strb r2, [sp, #3]
	strb r1, [sp, #4]
	str r0, [sp, #0xc]
	b _020FEFBC
_020FEF50:
	ldrb r1, [sp, #4]
	cmp r1, #3
	moveq r0, #5
	streqb r0, [sp, #4]
	beq _020FEFBC
	ldrb r0, [sp, #2]
	cmp r0, #0
	cmpeq r1, #0
	movne r0, #0xff
	strneb r0, [sp, #5]
	b _020FEFBC
_020FEF7C:
	ldrb r0, [sp, #4]
	cmp r0, #3
	moveq r0, #5
	streqb r0, [sp, #4]
	beq _020FEFBC
	cmp r0, #0
	movne r0, #0xff
	strneb r0, [sp, #5]
	b _020FEFBC
_020FEFA0:
	ldrb r0, [sp, #4]
	cmp r0, #9
	moveq r0, #0xff
	streqb r0, [sp, #5]
	b _020FEFBC
_020FEFB4:
	mov r0, #0xff
	strb r0, [sp, #5]
_020FEFBC:
	add r0, sp, #0
	ldmia r0, {r0, r1, r2, r3}
	stmia lr, {r0, r1, r2, r3}
	add r0, ip, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020FEFD4: .word __ctype_mapC
_020FEFD8: .word 0x000001FD
	arm_func_end parse_format__printf

	arm_func_start long2str__printf
long2str__printf: // 0x020FEFDC
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	movs r10, r0
	mov r0, #0
	mov r5, r1
	str r0, [sp, #0xc]
	ldr r7, [sp, #0x4c]
	mov r6, r0
	strb r0, [r5, #-1]!
	ldrb r0, [sp, #0x43]
	str r1, [sp]
	ldrb r8, [sp, #0x45]
	str r0, [sp, #4]
	ldr r0, [sp, #0x48]
	ldrb r11, [sp, #0x41]
	str r0, [sp, #8]
	cmpeq r7, #0
	bne _020FF050
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _020FF03C
	cmp r8, #0x6f
	beq _020FF050
_020FF03C:
	add sp, sp, #0x10
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020FF050:
	cmp r8, #0x69
	bgt _020FF078
	bge _020FF0AC
	cmp r8, #0x58
	bgt _020FF06C
	beq _020FF0D8
	b _020FF0E0
_020FF06C:
	cmp r8, #0x64
	beq _020FF0AC
	b _020FF0E0
_020FF078:
	cmp r8, #0x6f
	bgt _020FF08C
	moveq r4, #8
	moveq r11, #0
	b _020FF0E0
_020FF08C:
	cmp r8, #0x78
	bgt _020FF0E0
	cmp r8, #0x75
	blt _020FF0E0
	beq _020FF0CC
	cmp r8, #0x78
	beq _020FF0D8
	b _020FF0E0
_020FF0AC:
	cmp r10, #0
	mov r4, #0xa
	bge _020FF0E0
	mov r0, #1
	cmp r10, #0x80000000
	rsbne r10, r10, #0
	str r0, [sp, #0xc]
	b _020FF0E0
_020FF0CC:
	mov r4, #0xa
	mov r11, #0
	b _020FF0E0
_020FF0D8:
	mov r4, #0x10
	mov r11, #0
_020FF0E0:
	mov r0, r10
	mov r1, r4
	bl _u32_div_f
	mov r9, r1
	mov r0, r10
	mov r1, r4
	bl _u32_div_f
	cmp r9, #0xa
	mov r10, r0
	addlt r9, r9, #0x30
	blt _020FF118
	cmp r8, #0x78
	addeq r9, r9, #0x57
	addne r9, r9, #0x37
_020FF118:
	cmp r10, #0
	strb r9, [r5, #-1]!
	add r6, r6, #1
	bne _020FF0E0
	cmp r4, #8
	bne _020FF14C
	ldr r0, [sp, #4]
	cmp r0, #0
	ldrnesb r0, [r5, #0]
	cmpne r0, #0x30
	movne r0, #0x30
	strneb r0, [r5, #-1]!
	addne r6, r6, #1
_020FF14C:
	ldrb r0, [sp, #0x40]
	cmp r0, #2
	bne _020FF180
	ldr r0, [sp, #0xc]
	ldr r7, [sp, #8]
	cmp r0, #0
	cmpeq r11, #0
	subne r7, r7, #1
	cmp r4, #0x10
	bne _020FF180
	ldr r0, [sp, #4]
	cmp r0, #0
	subne r7, r7, #2
_020FF180:
	ldr r0, [sp]
	sub r1, r0, r5
	ldr r0, _020FF224 // =0x000001FD
	add r1, r7, r1
	cmp r1, r0
	addgt sp, sp, #0x10
	movgt r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addgt sp, sp, #0x10
	bxgt lr
	cmp r6, r7
	bge _020FF1C4
	mov r0, #0x30
_020FF1B4:
	add r6, r6, #1
	cmp r6, r7
	strb r0, [r5, #-1]!
	blt _020FF1B4
_020FF1C4:
	cmp r4, #0x10
	bne _020FF1E0
	ldr r0, [sp, #4]
	cmp r0, #0
	movne r0, #0x30
	strneb r8, [r5, #-1]
	strneb r0, [r5, #-2]!
_020FF1E0:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	movne r0, #0x2d
	strneb r0, [r5, #-1]!
	bne _020FF210
	cmp r11, #1
	moveq r0, #0x2b
	streqb r0, [r5, #-1]!
	beq _020FF210
	cmp r11, #2
	moveq r0, #0x20
	streqb r0, [r5, #-1]!
_020FF210:
	mov r0, r5
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020FF224: .word 0x000001FD
	arm_func_end long2str__printf

	arm_func_start longlong2str__printf
longlong2str__printf: // 0x020FF228
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	mov r9, r1
	mov r1, #0
	mov r10, r0
	mov r6, r2
	mov r0, r1
	strb r0, [r6, #-1]!
	ldr r0, [sp, #0x58]
	cmp r9, #0
	str r0, [sp, #0x10]
	ldrb r0, [sp, #0x4f]
	cmpeq r10, #0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [sp, #0x54]
	str r1, [sp, #0x14]
	str r0, [sp, #8]
	ldrb r0, [sp, #0x4d]
	mov r7, r1
	ldrb r8, [sp, #0x51]
	str r0, [sp, #0xc]
	ldreq r0, [sp, #0x10]
	cmpeq r0, #0
	bne _020FF2B8
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _020FF2A4
	cmp r8, #0x6f
	beq _020FF2B8
_020FF2A4:
	add sp, sp, #0x18
	mov r0, r6
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020FF2B8:
	cmp r8, #0x69
	bgt _020FF2E0
	bge _020FF310
	cmp r8, #0x58
	bgt _020FF2D4
	beq _020FF364
	b _020FF370
_020FF2D4:
	cmp r8, #0x64
	beq _020FF310
	b _020FF370
_020FF2E0:
	cmp r8, #0x6f
	bgt _020FF2F0
	beq _020FF344
	b _020FF370
_020FF2F0:
	cmp r8, #0x78
	bgt _020FF370
	cmp r8, #0x75
	blt _020FF370
	beq _020FF354
	cmp r8, #0x78
	beq _020FF364
	b _020FF370
_020FF310:
	subs r0, r10, #0
	sbcs r0, r9, #0
	mov r11, #0xa
	mov r5, #0
	bge _020FF370
	cmp r9, #0x80000000
	cmpeq r10, r5
	beq _020FF338
	rsbs r10, r10, #0
	rsc r9, r9, #0
_020FF338:
	mov r0, #1
	str r0, [sp, #0x14]
	b _020FF370
_020FF344:
	mov r5, #0
	str r5, [sp, #0xc]
	mov r11, #8
	b _020FF370
_020FF354:
	mov r5, #0
	str r5, [sp, #0xc]
	mov r11, #0xa
	b _020FF370
_020FF364:
	mov r5, #0
	str r5, [sp, #0xc]
	mov r11, #0x10
_020FF370:
	mov r0, r10
	mov r1, r9
	mov r2, r11
	mov r3, r5
	bl _ull_mod
	mov r4, r0
	mov r0, r10
	mov r1, r9
	mov r2, r11
	mov r3, r5
	bl _ll_udiv
	mov r10, r0
	cmp r4, #0xa
	mov r9, r1
	addlt r0, r4, #0x30
	blt _020FF3BC
	cmp r8, #0x78
	addeq r0, r4, #0x57
	addne r0, r4, #0x37
_020FF3BC:
	strb r0, [r6, #-1]!
	mov r0, #0
	cmp r9, r0
	cmpeq r10, r0
	add r7, r7, #1
	bne _020FF370
	cmp r5, #0
	cmpeq r11, #8
	bne _020FF3FC
	ldr r0, [sp, #4]
	cmp r0, #0
	ldrnesb r0, [r6, #0]
	cmpne r0, #0x30
	movne r0, #0x30
	strneb r0, [r6, #-1]!
	addne r7, r7, #1
_020FF3FC:
	ldrb r0, [sp, #0x4c]
	cmp r0, #2
	bne _020FF44C
	ldr r0, [sp, #8]
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	cmp r0, #0
	ldreq r0, [sp, #0xc]
	cmpeq r0, #0
	ldrne r0, [sp, #0x10]
	subne r0, r0, #1
	strne r0, [sp, #0x10]
	cmp r5, #0
	cmpeq r11, #0x10
	bne _020FF44C
	ldr r0, [sp, #4]
	cmp r0, #0
	ldrne r0, [sp, #0x10]
	subne r0, r0, #2
	strne r0, [sp, #0x10]
_020FF44C:
	ldr r0, [sp]
	ldr r1, _020FF504 // =0x000001FD
	sub r2, r0, r6
	ldr r0, [sp, #0x10]
	add r0, r0, r2
	cmp r0, r1
	addgt sp, sp, #0x18
	movgt r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addgt sp, sp, #0x10
	bxgt lr
	ldr r0, [sp, #0x10]
	cmp r7, r0
	bge _020FF49C
	mov r1, #0x30
_020FF488:
	ldr r0, [sp, #0x10]
	add r7, r7, #1
	cmp r7, r0
	strb r1, [r6, #-1]!
	blt _020FF488
_020FF49C:
	cmp r5, #0
	cmpeq r11, #0x10
	bne _020FF4BC
	ldr r0, [sp, #4]
	cmp r0, #0
	movne r0, #0x30
	strneb r8, [r6, #-1]
	strneb r0, [r6, #-2]!
_020FF4BC:
	ldr r0, [sp, #0x14]
	cmp r0, #0
	movne r0, #0x2d
	strneb r0, [r6, #-1]!
	bne _020FF4F0
	ldr r0, [sp, #0xc]
	cmp r0, #1
	moveq r0, #0x2b
	streqb r0, [r6, #-1]!
	beq _020FF4F0
	cmp r0, #2
	moveq r0, #0x20
	streqb r0, [r6, #-1]!
_020FF4F0:
	mov r0, r6
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020FF504: .word 0x000001FD
	arm_func_end longlong2str__printf

	arm_func_start double2hex__printf
double2hex__printf: // 0x020FF508
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x44
	ldr r7, [sp, #0x80]
	ldr r0, _020FF9B8 // =0x000001FD
	mov r8, r2
	cmp r7, r0
	ldrb r6, [sp, #0x79]
	ldrb r5, [sp, #0x77]
	ldrb r4, [sp, #0x75]
	ldr r1, [sp, #0x68]
	ldr r2, [sp, #0x6c]
	addgt sp, sp, #0x44
	movgt r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	addgt sp, sp, #0x10
	bxgt lr
	mov r10, #0
	mov r9, #0x20
	add r0, sp, #8
	add r3, sp, #0xc
	strb r10, [sp, #8]
	strh r9, [sp, #0xa]
	bl __num2dec
	ldr r0, [sp, #0x68]
	ldr r1, [sp, #0x6c]
	bl fabs
	mov r2, r0
	mov r0, r10
	mov r3, r1
	mov r1, r0
	bl _dls
	bne _020FF5D4
	ldr r3, _020FF9BC // =a0x0p0
	sub r0, r8, #6
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	add sp, sp, #0x44
	strb r2, [r8, #-6]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldrb r2, [r3, #4]
	ldrb r1, [r3, #5]
	strb r2, [r0, #4]
	strb r1, [r0, #5]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_020FF5D4:
	ldrb r0, [sp, #0x11]
	cmp r0, #0x49
	bne _020FF6E4
	ldrsb r0, [sp, #0xc]
	cmp r0, #0
	beq _020FF670
	cmp r6, #0x41
	sub r0, r8, #5
	bne _020FF634
	ldr r3, _020FF9C0 // =_02132624
	add sp, sp, #0x44
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldrb r1, [r3, #4]
	strb r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_020FF634:
	ldr r3, _020FF9C4 // =0x0213262C
	add sp, sp, #0x44
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldrb r1, [r3, #4]
	strb r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_020FF670:
	cmp r6, #0x41
	sub r0, r8, #4
	bne _020FF6B0
	ldr r3, _020FF9C8 // =0x02132634
	add sp, sp, #0x44
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_020FF6B0:
	ldr r3, _020FF9CC // =0x02132638
	add sp, sp, #0x44
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_020FF6E4:
	cmp r0, #0x4e
	bne _020FF7F0
	ldrsb r0, [sp, #0xc]
	cmp r0, #0
	beq _020FF77C
	cmp r6, #0x41
	sub r0, r8, #5
	bne _020FF740
	ldr r3, _020FF9D0 // =0x0213263C
	add sp, sp, #0x44
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldrb r1, [r3, #4]
	strb r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_020FF740:
	ldr r3, _020FF9D4 // =0x02132644
	add sp, sp, #0x44
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldrb r1, [r3, #4]
	strb r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_020FF77C:
	cmp r6, #0x41
	sub r0, r8, #4
	bne _020FF7BC
	ldr r3, _020FF9D8 // =0x0213264C
	add sp, sp, #0x44
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_020FF7BC:
	ldr r3, _020FF9DC // =0x02132650
	add sp, sp, #0x44
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_020FF7F0:
	mov r3, r10
	mov r1, #1
	mov r0, #0x64
	add r9, sp, #0x68
	strb r1, [sp, #0x34]
	strb r1, [sp, #0x35]
	strb r3, [sp, #0x36]
	strb r3, [sp, #0x37]
	strb r3, [sp, #0x38]
	str r3, [sp, #0x3c]
	str r1, [sp, #0x40]
	strb r0, [sp, #0x39]
_020FF820:
	rsb r1, r3, #7
	ldrsb r2, [r9, r3]
	ldrsb r0, [r9, r1]
	strb r0, [r9, r3]
	add r3, r3, #1
	strb r2, [r9, r1]
	cmp r3, #4
	blt _020FF820
	ldrb r0, [sp, #0x69]
	ldrb r1, [sp, #0x68]
	ldr r9, _020FF9E0 // =0x000007FF
	mov r0, r0, lsl #0x11
	orr r1, r0, r1, lsl #25
	add r0, sp, #0x34
	and lr, r9, r1, lsr #21
	sub ip, sp, #8
	ldmia r0, {r0, r1, r2, r3}
	stmia ip, {r0, r1, r2, r3}
	rsb r0, r9, #0x400
	mov r1, r8
	add r0, lr, r0
	ldmia ip, {r2, r3}
	bl long2str__printf
	cmp r6, #0x61
	moveq r1, #0x70
	movne r1, #0x50
	strb r1, [r0, #-1]!
	mov r1, r7, lsl #2
	mov lr, r7
	cmp r7, #1
	add r8, r1, #0xb
	add ip, sp, #0x68
	blt _020FF930
	mov r9, #0x30
_020FF8A8:
	cmp r8, #0x40
	bge _020FF918
	ldrb r1, [ip, r8, asr #3]
	and r2, r8, #7
	rsb r3, r2, #7
	mov r2, r1, asr r3
	sub r10, r8, #4
	bic r1, r8, #7
	bic r10, r10, #7
	cmp r1, r10
	add r10, ip, r8, asr #3
	and r1, r2, #0xff
	beq _020FF8EC
	ldrb r2, [r10, #-1]
	mov r2, r2, lsl #8
	orr r1, r1, r2, asr r3
	and r1, r1, #0xff
_020FF8EC:
	and r1, r1, #0xf
	cmp r1, #0xa
	addlo r1, r1, #0x30
	andlo r1, r1, #0xff
	blo _020FF91C
	cmp r6, #0x61
	addeq r1, r1, #0x57
	andeq r1, r1, #0xff
	addne r1, r1, #0x37
	andne r1, r1, #0xff
	b _020FF91C
_020FF918:
	mov r1, r9
_020FF91C:
	sub lr, lr, #1
	cmp lr, #1
	strb r1, [r0, #-1]!
	sub r8, r8, #4
	bge _020FF8A8
_020FF930:
	cmp r7, #0
	cmpeq r5, #0
	movne r1, #0x2e
	strneb r1, [r0, #-1]!
	mov r1, #0x31
	strb r1, [r0, #-1]
	cmp r6, #0x61
	moveq r1, #0x78
	movne r1, #0x58
	strb r1, [r0, #-2]!
	mov r1, #0x30
	strb r1, [r0, #-1]!
	ldrsb r1, [sp, #0xc]
	cmp r1, #0
	movne r1, #0x2d
	strneb r1, [r0, #-1]!
	addne sp, sp, #0x44
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	addne sp, sp, #0x10
	bxne lr
	cmp r4, #1
	moveq r1, #0x2b
	streqb r1, [r0, #-1]!
	addeq sp, sp, #0x44
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	addeq sp, sp, #0x10
	bxeq lr
	cmp r4, #2
	moveq r1, #0x20
	streqb r1, [r0, #-1]!
	add sp, sp, #0x44
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020FF9B8: .word 0x000001FD
_020FF9BC: .word a0x0p0
_020FF9C0: .word _02132624
_020FF9C4: .word 0x0213262C
_020FF9C8: .word 0x02132634
_020FF9CC: .word 0x02132638
_020FF9D0: .word 0x0213263C
_020FF9D4: .word 0x02132644
_020FF9D8: .word 0x0213264C
_020FF9DC: .word 0x02132650
_020FF9E0: .word 0x000007FF
	arm_func_end double2hex__printf

	arm_func_start round_decimal__printf
round_decimal__printf: // 0x020FF9E4
	stmdb sp!, {r4, lr}
	cmp r1, #0
	bge _020FFA0C
_020FF9F0:
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #1
	strb r1, [r0, #4]
	mov r1, #0x30
	strb r1, [r0, #5]
	ldmia sp!, {r4, pc}
_020FFA0C:
	ldrb lr, [r0, #4]
	cmp r1, lr
	ldmgeia sp!, {r4, pc}
	add ip, r0, #5
	add r2, ip, r1
	add r2, r2, #1
	ldrsb r3, [r2, #-1]!
	sub r3, r3, #0x30
	mov r3, r3, lsl #0x18
	mov r3, r3, asr #0x18
	cmp r3, #5
	bne _020FFA6C
	add ip, ip, lr
_020FFA40:
	sub ip, ip, #1
	cmp ip, r2
	bls _020FFA58
	ldrsb r3, [ip]
	cmp r3, #0x30
	beq _020FFA40
_020FFA58:
	cmp ip, r2
	ldreqsb r3, [r2, #-1]
	andeq r4, r3, #1
	movne r4, #1
	b _020FFA74
_020FFA6C:
	movgt r4, #1
	movle r4, #0
_020FFA74:
	cmp r1, #0
	beq _020FFAD0
	mov ip, #0
	mov lr, #1
_020FFA84:
	ldrsb r3, [r2, #-1]!
	sub r3, r3, #0x30
	add r3, r3, r4
	mov r3, r3, lsl #0x18
	mov r3, r3, asr #0x18
	cmp r3, #9
	movgt r4, lr
	movle r4, ip
	cmp r4, #0
	bne _020FFAB4
	cmp r3, #0
	bne _020FFABC
_020FFAB4:
	sub r1, r1, #1
	b _020FFAC8
_020FFABC:
	add r3, r3, #0x30
	strb r3, [r2]
	b _020FFAD0
_020FFAC8:
	cmp r1, #0
	bne _020FFA84
_020FFAD0:
	cmp r4, #0
	beq _020FFAF8
	ldrsh r3, [r0, #2]
	mov r2, #1
	mov r1, #0x31
	add r3, r3, #1
	strh r3, [r0, #2]
	strb r2, [r0, #4]
	strb r1, [r0, #5]
	ldmia sp!, {r4, pc}
_020FFAF8:
	cmp r1, #0
	beq _020FF9F0
	strb r1, [r0, #4]
	ldmia sp!, {r4, pc}
	arm_func_end round_decimal__printf

	arm_func_start float2str__printf
float2str__printf: // 0x020FFB08
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	ldr r7, [sp, #0x68]
	ldr r3, _02100240 // =0x000001FD
	ldrb r6, [sp, #0x61]
	ldrb r5, [sp, #0x5f]
	ldrb r4, [sp, #0x5d]
	cmp r7, r3
	mov r10, r0
	mov r8, r1
	mov r9, r2
	addgt sp, sp, #0x2c
	movgt r0, #0
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addgt sp, sp, #0x10
	bxgt lr
	mov ip, #0
	mov r11, #0x20
	add r0, sp, #0
	add r3, sp, #4
	mov r1, r10
	mov r2, r8
	strb ip, [sp]
	strh r11, [sp, #2]
	bl __num2dec
	ldrb r0, [sp, #8]
	add r1, sp, #9
	add r0, r1, r0
	b _020FFB98
_020FFB80:
	ldrb r2, [sp, #8]
	ldrsh r1, [sp, #6]
	sub r2, r2, #1
	add r1, r1, #1
	strb r2, [sp, #8]
	strh r1, [sp, #6]
_020FFB98:
	ldrb r1, [sp, #8]
	cmp r1, #1
	bls _020FFBB0
	ldrsb r1, [r0, #-1]!
	cmp r1, #0x30
	beq _020FFB80
_020FFBB0:
	ldrb r0, [sp, #9]
	cmp r0, #0x30
	beq _020FFBD0
	cmp r0, #0x49
	beq _020FFBDC
	cmp r0, #0x4e
	beq _020FFD3C
	b _020FFE90
_020FFBD0:
	mov r0, #0
	strh r0, [sp, #6]
	b _020FFE90
_020FFBDC:
	mov r2, #0
	mov r0, r10
	mov r1, r8
	mov r3, r2
	bl _dleq
	bhs _020FFCA0
	cmp r6, #0
	sub r0, r9, #5
	blt _020FFC08
	cmp r6, #0x80
	blt _020FFC10
_020FFC08:
	mov r1, #0
	b _020FFC20
_020FFC10:
	ldr r1, _02100244 // =__ctype_mapC
	mov r2, r6, lsl #1
	ldrh r1, [r1, r2]
	and r1, r1, #0x200
_020FFC20:
	cmp r1, #0
	beq _020FFC64
	ldr r3, _02100248 // =_02132624
	add sp, sp, #0x2c
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldrb r1, [r3, #4]
	strb r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020FFC64:
	ldr r3, _0210024C // =0x0213262C
	add sp, sp, #0x2c
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldrb r1, [r3, #4]
	strb r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020FFCA0:
	cmp r6, #0
	sub r0, r9, #4
	blt _020FFCB4
	cmp r6, #0x80
	blt _020FFCBC
_020FFCB4:
	mov r1, #0
	b _020FFCCC
_020FFCBC:
	ldr r1, _02100244 // =__ctype_mapC
	mov r2, r6, lsl #1
	ldrh r1, [r1, r2]
	and r1, r1, #0x200
_020FFCCC:
	cmp r1, #0
	beq _020FFD08
	ldr r3, _02100250 // =0x02132634
	add sp, sp, #0x2c
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020FFD08:
	ldr r3, _02100254 // =0x02132638
	add sp, sp, #0x2c
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020FFD3C:
	ldrsb r0, [sp, #4]
	cmp r0, #0
	beq _020FFDF4
	cmp r6, #0
	sub r0, r9, #5
	blt _020FFD5C
	cmp r6, #0x80
	blt _020FFD64
_020FFD5C:
	mov r1, #0
	b _020FFD74
_020FFD64:
	ldr r1, _02100244 // =__ctype_mapC
	mov r2, r6, lsl #1
	ldrh r1, [r1, r2]
	and r1, r1, #0x200
_020FFD74:
	cmp r1, #0
	beq _020FFDB8
	ldr r3, _02100258 // =0x0213263C
	add sp, sp, #0x2c
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldrb r1, [r3, #4]
	strb r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020FFDB8:
	ldr r3, _0210025C // =0x02132644
	add sp, sp, #0x2c
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldrb r1, [r3, #4]
	strb r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020FFDF4:
	cmp r6, #0
	sub r0, r9, #4
	blt _020FFE08
	cmp r6, #0x80
	blt _020FFE10
_020FFE08:
	mov r1, #0
	b _020FFE20
_020FFE10:
	ldr r1, _02100244 // =__ctype_mapC
	mov r2, r6, lsl #1
	ldrh r1, [r1, r2]
	and r1, r1, #0x200
_020FFE20:
	cmp r1, #0
	beq _020FFE5C
	ldr r3, _02100260 // =0x0213264C
	add sp, sp, #0x2c
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020FFE5C:
	ldr r3, _02100264 // =0x02132650
	add sp, sp, #0x2c
	ldrb r2, [r3, #0]
	ldrb r1, [r3, #1]
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [r0, #2]
	strb r1, [r0, #3]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020FFE90:
	ldrb r0, [sp, #8]
	ldrsh r1, [sp, #6]
	sub r8, r9, #1
	sub r0, r0, #1
	add r0, r1, r0
	strh r0, [sp, #6]
	mov r0, #0
	strb r0, [r8]
	cmp r6, #0x65
	bgt _020FFEE4
	bge _020FFF70
	cmp r6, #0x47
	bgt _0210022C
	cmp r6, #0x45
	blt _0210022C
	beq _020FFF70
	cmp r6, #0x46
	beq _021000B8
	cmp r6, #0x47
	beq _020FFEFC
	b _0210022C
_020FFEE4:
	cmp r6, #0x66
	bgt _020FFEF4
	beq _021000B8
	b _0210022C
_020FFEF4:
	cmp r6, #0x67
	bne _0210022C
_020FFEFC:
	ldrb r0, [sp, #8]
	cmp r0, r7
	ble _020FFF14
	add r0, sp, #4
	mov r1, r7
	bl round_decimal__printf
_020FFF14:
	ldrsh r2, [sp, #6]
	mvn r0, #3
	cmp r2, r0
	blt _020FFF2C
	cmp r2, r7
	blt _020FFF4C
_020FFF2C:
	cmp r5, #0
	ldreqb r0, [sp, #8]
	subne r7, r7, #1
	subeq r7, r0, #1
	cmp r6, #0x67
	moveq r6, #0x65
	movne r6, #0x45
	b _020FFF70
_020FFF4C:
	cmp r5, #0
	addne r0, r2, #1
	subne r7, r7, r0
	bne _021000B8
	ldrb r1, [sp, #8]
	add r0, r2, #1
	subs r7, r1, r0
	movmi r7, #0
	b _021000B8
_020FFF70:
	ldrb r0, [sp, #8]
	add r1, r7, #1
	cmp r0, r1
	ble _020FFF88
	add r0, sp, #4
	bl round_decimal__printf
_020FFF88:
	ldrsh lr, [sp, #6]
	mov r11, #0x2b
	mov r10, #0
	cmp lr, #0
	rsblt lr, lr, #0
	movlt r11, #0x2d
	ldr r3, _02100268 // =0x66666667
	mov r0, #0xa
	b _020FFFDC
_020FFFAC:
	mov r1, lr, lsr #0x1f
	smull r2, ip, r3, lr
	add ip, r1, ip, asr #2
	smull r1, r2, r0, ip
	sub ip, lr, r1
	add r1, ip, #0x30
	strb r1, [r8, #-1]!
	mov r2, lr
	smull r1, lr, r3, r2
	mov r1, r2, lsr #0x1f
	add lr, r1, lr, asr #2
	add r10, r10, #1
_020FFFDC:
	cmp lr, #0
	bne _020FFFAC
	cmp r10, #2
	blt _020FFFAC
	strb r11, [r8, #-1]
	strb r6, [r8, #-2]!
	sub r1, r9, r8
	ldr r0, _02100240 // =0x000001FD
	add r1, r7, r1
	cmp r1, r0
	addgt sp, sp, #0x2c
	movgt r0, #0
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addgt sp, sp, #0x10
	bxgt lr
	ldrb r1, [sp, #8]
	add r0, r7, #1
	cmp r1, r0
	bge _02100048
	add r0, r7, #2
	sub r0, r0, r1
	subs r1, r0, #1
	beq _02100048
	mov r0, #0x30
_0210003C:
	strb r0, [r8, #-1]!
	subs r1, r1, #1
	bne _0210003C
_02100048:
	ldrb r1, [sp, #8]
	add r0, sp, #9
	add r2, r0, r1
	subs r1, r1, #1
	beq _0210006C
_0210005C:
	ldrsb r0, [r2, #-1]!
	subs r1, r1, #1
	strb r0, [r8, #-1]!
	bne _0210005C
_0210006C:
	cmp r7, #0
	cmpeq r5, #0
	movne r0, #0x2e
	strneb r0, [r8, #-1]!
	ldrb r0, [sp, #9]
	strb r0, [r8, #-1]!
	ldrsb r0, [sp, #4]
	cmp r0, #0
	movne r0, #0x2d
	strneb r0, [r8, #-1]!
	bne _0210022C
	cmp r4, #1
	moveq r0, #0x2b
	streqb r0, [r8, #-1]!
	beq _0210022C
	cmp r4, #2
	moveq r0, #0x20
	streqb r0, [r8, #-1]!
	b _0210022C
_021000B8:
	ldrsh r3, [sp, #6]
	ldrb r2, [sp, #8]
	sub r0, r2, r3
	subs r1, r0, #1
	movmi r1, #0
	cmp r1, r7
	ble _021000F8
	sub r1, r1, r7
	add r0, sp, #4
	sub r1, r2, r1
	bl round_decimal__printf
	ldrsh r3, [sp, #6]
	ldrb r2, [sp, #8]
	sub r0, r2, r3
	subs r1, r0, #1
	movmi r1, #0
_021000F8:
	adds r0, r3, #1
	movmi r0, #0
	ldr r3, _02100240 // =0x000001FD
	add r6, r0, r1
	cmp r6, r3
	addgt sp, sp, #0x2c
	movgt r0, #0
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addgt sp, sp, #0x10
	bxgt lr
	add r3, sp, #9
	sub r6, r7, r1
	cmp r6, #0
	add r2, r3, r2
	mov r9, #0
	ble _0210014C
	mov r3, #0x30
_0210013C:
	add r9, r9, #1
	cmp r9, r6
	strb r3, [r8, #-1]!
	blt _0210013C
_0210014C:
	mov r6, #0
	b _02100160
_02100154:
	ldrsb r3, [r2, #-1]!
	add r6, r6, #1
	strb r3, [r8, #-1]!
_02100160:
	cmp r6, r1
	ldrltb r3, [sp, #8]
	cmplt r6, r3
	blt _02100154
	cmp r6, r1
	bge _0210018C
	mov r3, #0x30
_0210017C:
	add r6, r6, #1
	cmp r6, r1
	strb r3, [r8, #-1]!
	blt _0210017C
_0210018C:
	cmp r7, #0
	cmpeq r5, #0
	movne r1, #0x2e
	strneb r1, [r8, #-1]!
	cmp r0, #0
	beq _021001F4
	ldrb r1, [sp, #8]
	mov r5, #0
	sub r1, r0, r1
	cmp r1, #0
	ble _021001D4
	mov r3, #0x30
_021001BC:
	strb r3, [r8, #-1]!
	ldrb r1, [sp, #8]
	add r5, r5, #1
	sub r1, r0, r1
	cmp r5, r1
	blt _021001BC
_021001D4:
	cmp r5, r0
	bge _021001FC
_021001DC:
	ldrsb r1, [r2, #-1]!
	add r5, r5, #1
	cmp r5, r0
	strb r1, [r8, #-1]!
	blt _021001DC
	b _021001FC
_021001F4:
	mov r0, #0x30
	strb r0, [r8, #-1]!
_021001FC:
	ldrsb r0, [sp, #4]
	cmp r0, #0
	movne r0, #0x2d
	strneb r0, [r8, #-1]!
	bne _0210022C
	cmp r4, #1
	moveq r0, #0x2b
	streqb r0, [r8, #-1]!
	beq _0210022C
	cmp r4, #2
	moveq r0, #0x20
	streqb r0, [r8, #-1]!
_0210022C:
	mov r0, r8
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02100240: .word 0x000001FD
_02100244: .word __ctype_mapC
_02100248: .word _02132624
_0210024C: .word 0x0213262C
_02100250: .word 0x02132634
_02100254: .word 0x02132638
_02100258: .word 0x0213263C
_0210025C: .word 0x02132644
_02100260: .word 0x0213264C
_02100264: .word 0x02132650
_02100268: .word 0x66666667
	arm_func_end float2str__printf

	arm_func_start __pformatter
__pformatter: // 0x0210026C
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x22c
	mov r3, #0x20
	mov r11, r2
	strb r3, [sp, #0x19]
	ldrsb r2, [r11, #0]
	mov r9, r0
	mov r8, r1
	cmp r2, #0
	mov r10, #0
	beq _02100A74
_0210029C:
	mov r0, r11
	mov r1, #0x25
	bl strchr
	str r0, [sp, #0xc]
	cmp r0, #0
	bne _021002F0
	mov r0, r11
	bl strlen
	movs r2, r0
	add r10, r10, r2
	beq _02100A74
	mov r0, r8
	mov r1, r11
	blx r9
	cmp r0, #0
	bne _02100A74
	add sp, sp, #0x22c
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_021002F0:
	subs r2, r0, r11
	add r10, r10, r2
	beq _02100320
	mov r0, r8
	mov r1, r11
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x22c
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
_02100320:
	ldr r0, [sp, #0xc]
	add r1, sp, #0x25c
	add r2, sp, #0x1c
	bl parse_format__printf
	ldrb r1, [sp, #0x21]
	mov r11, r0
	cmp r1, #0x61
	bgt _0210038C
	bge _021006F0
	cmp r1, #0x47
	bgt _02100380
	subs r0, r1, #0x41
	addpl pc, pc, r0, lsl #2
	b _02100374
_02100358: // jump table
	b _021006F0 // case 0
	b _021008D8 // case 1
	b _021008D8 // case 2
	b _021008D8 // case 3
	b _02100688 // case 4
	b _02100688 // case 5
	b _02100688 // case 6
_02100374:
	cmp r1, #0x25
	beq _021008C4
	b _021008D8
_02100380:
	cmp r1, #0x58
	beq _0210054C
	b _021008D8
_0210038C:
	cmp r1, #0x75
	bgt _021003F4
	subs r0, r1, #0x64
	addpl pc, pc, r0, lsl #2
	b _021003E8
_021003A0: // jump table
	b _0210040C // case 0
	b _02100688 // case 1
	b _02100688 // case 2
	b _02100688 // case 3
	b _021008D8 // case 4
	b _0210040C // case 5
	b _021008D8 // case 6
	b _021008D8 // case 7
	b _021008D8 // case 8
	b _021008D8 // case 9
	b _02100818 // case 10
	b _0210054C // case 11
	b _021008D8 // case 12
	b _021008D8 // case 13
	b _021008D8 // case 14
	b _02100758 // case 15
	b _021008D8 // case 16
	b _0210054C // case 17
_021003E8:
	cmp r1, #0x63
	beq _021008A4
	b _021008D8
_021003F4:
	cmp r1, #0x78
	bgt _02100404
	beq _0210054C
	b _021008D8
_02100404:
	cmp r1, #0xff
	b _021008D8
_0210040C:
	ldrb r0, [sp, #0x20]
	cmp r0, #3
	bne _0210042C
	ldr r1, [sp, #0x25c]
	add r1, r1, #4
	str r1, [sp, #0x25c]
	ldr r5, [r1, #-4]
	b _021004C4
_0210042C:
	cmp r0, #4
	bne _02100454
	ldr r1, [sp, #0x25c]
	add r2, r1, #8
	str r2, [sp, #0x25c]
	ldr r1, [r2, #-8]
	str r1, [sp, #0x10]
	ldr r1, [r2, #-4]
	str r1, [sp, #0x14]
	b _021004C4
_02100454:
	cmp r0, #6
	bne _0210047C
	ldr r1, [sp, #0x25c]
	add r2, r1, #8
	str r2, [sp, #0x25c]
	ldr r1, [r2, #-8]
	str r1, [sp, #0x10]
	ldr r1, [r2, #-4]
	str r1, [sp, #0x14]
	b _021004C4
_0210047C:
	cmp r0, #7
	bne _02100498
	ldr r1, [sp, #0x25c]
	add r1, r1, #4
	str r1, [sp, #0x25c]
	ldr r5, [r1, #-4]
	b _021004C4
_02100498:
	cmp r0, #8
	bne _021004B4
	ldr r1, [sp, #0x25c]
	add r1, r1, #4
	str r1, [sp, #0x25c]
	ldr r5, [r1, #-4]
	b _021004C4
_021004B4:
	ldr r1, [sp, #0x25c]
	add r1, r1, #4
	str r1, [sp, #0x25c]
	ldr r5, [r1, #-4]
_021004C4:
	cmp r0, #2
	moveq r1, r5, lsl #0x10
	moveq r5, r1, asr #0x10
	cmp r0, #1
	moveq r1, r5, lsl #0x18
	moveq r5, r1, asr #0x18
	cmp r0, #4
	cmpne r0, #6
	add r0, sp, #0x1c
	bne _02100518
	sub r4, sp, #4
	ldmia r0, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	ldr r3, [r4, #0]
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	add r2, sp, #0x22c
	bl longlong2str__printf
	movs r7, r0
	beq _021008D8
	b _0210053C
_02100518:
	sub r4, sp, #8
	ldmia r0, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	add r1, sp, #0x22c
	mov r0, r5
	ldmia r4, {r2, r3}
	bl long2str__printf
	movs r7, r0
	beq _021008D8
_0210053C:
	add r0, sp, #0x200
	add r0, r0, #0x2b
	sub r6, r0, r7
	b _02100924
_0210054C:
	ldrb r0, [sp, #0x20]
	cmp r0, #3
	bne _0210056C
	ldr r1, [sp, #0x25c]
	add r1, r1, #4
	str r1, [sp, #0x25c]
	ldr r5, [r1, #-4]
	b _02100604
_0210056C:
	cmp r0, #4
	bne _02100594
	ldr r1, [sp, #0x25c]
	add r2, r1, #8
	str r2, [sp, #0x25c]
	ldr r1, [r2, #-8]
	str r1, [sp, #0x10]
	ldr r1, [r2, #-4]
	str r1, [sp, #0x14]
	b _02100604
_02100594:
	cmp r0, #6
	bne _021005BC
	ldr r1, [sp, #0x25c]
	add r2, r1, #8
	str r2, [sp, #0x25c]
	ldr r1, [r2, #-8]
	str r1, [sp, #0x10]
	ldr r1, [r2, #-4]
	str r1, [sp, #0x14]
	b _02100604
_021005BC:
	cmp r0, #7
	bne _021005D8
	ldr r1, [sp, #0x25c]
	add r1, r1, #4
	str r1, [sp, #0x25c]
	ldr r5, [r1, #-4]
	b _02100604
_021005D8:
	cmp r0, #8
	bne _021005F4
	ldr r1, [sp, #0x25c]
	add r1, r1, #4
	str r1, [sp, #0x25c]
	ldr r5, [r1, #-4]
	b _02100604
_021005F4:
	ldr r1, [sp, #0x25c]
	add r1, r1, #4
	str r1, [sp, #0x25c]
	ldr r5, [r1, #-4]
_02100604:
	cmp r0, #2
	moveq r1, r5, lsl #0x10
	moveq r5, r1, lsr #0x10
	cmp r0, #1
	andeq r5, r5, #0xff
	cmp r0, #4
	cmpne r0, #6
	add r0, sp, #0x1c
	bne _02100654
	sub r4, sp, #4
	ldmia r0, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	ldr r3, [r4, #0]
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	add r2, sp, #0x22c
	bl longlong2str__printf
	movs r7, r0
	beq _021008D8
	b _02100678
_02100654:
	sub r4, sp, #8
	ldmia r0, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	add r1, sp, #0x22c
	mov r0, r5
	ldmia r4, {r2, r3}
	bl long2str__printf
	movs r7, r0
	beq _021008D8
_02100678:
	add r0, sp, #0x200
	add r0, r0, #0x2b
	sub r6, r0, r7
	b _02100924
_02100688:
	ldrb r0, [sp, #0x20]
	cmp r0, #9
	ldrne r0, [sp, #0x25c]
	addne r0, r0, #8
	strne r0, [sp, #0x25c]
	bne _021006AC
	ldr r0, [sp, #0x25c]
	add r0, r0, #8
	str r0, [sp, #0x25c]
_021006AC:
	ldr r7, [r0, #-8]
	ldr r6, [r0, #-4]
	add r0, sp, #0x1c
	sub r4, sp, #4
	ldmia r0, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	ldr r3, [r4, #0]
	mov r0, r7
	mov r1, r6
	add r2, sp, #0x22c
	bl float2str__printf
	movs r7, r0
	beq _021008D8
	add r0, sp, #0x200
	add r0, r0, #0x2b
	sub r6, r0, r7
	b _02100924
_021006F0:
	ldrb r0, [sp, #0x20]
	cmp r0, #9
	ldrne r0, [sp, #0x25c]
	addne r0, r0, #8
	strne r0, [sp, #0x25c]
	bne _02100714
	ldr r0, [sp, #0x25c]
	add r0, r0, #8
	str r0, [sp, #0x25c]
_02100714:
	ldr r7, [r0, #-8]
	ldr r6, [r0, #-4]
	add r0, sp, #0x1c
	sub r4, sp, #4
	ldmia r0, {r0, r1, r2, r3}
	stmia r4, {r0, r1, r2, r3}
	ldr r3, [r4, #0]
	mov r0, r7
	mov r1, r6
	add r2, sp, #0x22c
	bl double2hex__printf
	movs r7, r0
	beq _021008D8
	add r0, sp, #0x200
	add r0, r0, #0x2b
	sub r6, r0, r7
	b _02100924
_02100758:
	ldrb r0, [sp, #0x20]
	cmp r0, #5
	bne _02100798
	ldr r0, [sp, #0x25c]
	mov r2, #0x200
	add r0, r0, #4
	str r0, [sp, #0x25c]
	ldr r1, [r0, #-4]
	add r0, sp, #0x2c
	cmp r1, #0
	ldreq r1, _02100A88 // =0x02132654
	bl wcstombs
	cmp r0, #0
	blt _021008D8
	add r7, sp, #0x2c
	b _021007A8
_02100798:
	ldr r0, [sp, #0x25c]
	add r0, r0, #4
	str r0, [sp, #0x25c]
	ldr r7, [r0, #-4]
_021007A8:
	ldrb r0, [sp, #0x1f]
	cmp r7, #0
	ldreq r7, _02100A8C // =0x02132658
	cmp r0, #0
	beq _021007DC
	ldrb r0, [sp, #0x1e]
	ldrb r6, [r7], #1
	cmp r0, #0
	beq _02100924
	ldr r0, [sp, #0x28]
	cmp r6, r0
	movgt r6, r0
	b _02100924
_021007DC:
	ldrb r0, [sp, #0x1e]
	cmp r0, #0
	beq _02100808
	ldr r6, [sp, #0x28]
	mov r0, r7
	mov r2, r6
	mov r1, #0
	bl memchr
	cmp r0, #0
	subne r6, r0, r7
	b _02100924
_02100808:
	mov r0, r7
	bl strlen
	mov r6, r0
	b _02100924
_02100818:
	ldr r1, [sp, #0x25c]
	ldrb r0, [sp, #0x20]
	add r1, r1, #4
	str r1, [sp, #0x25c]
	ldr r1, [r1, #-4]
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _02100A68
_02100838: // jump table
	b _0210085C // case 0
	b _02100A68 // case 1
	b _02100864 // case 2
	b _0210086C // case 3
	b _02100894 // case 4
	b _02100A68 // case 5
	b _02100874 // case 6
	b _02100884 // case 7
	b _0210088C // case 8
_0210085C:
	str r10, [r1]
	b _02100A68
_02100864:
	strh r10, [r1]
	b _02100A68
_0210086C:
	str r10, [r1]
	b _02100A68
_02100874:
	str r10, [r1]
	mov r0, r10, asr #0x1f
	str r0, [r1, #4]
	b _02100A68
_02100884:
	str r10, [r1]
	b _02100A68
_0210088C:
	str r10, [r1]
	b _02100A68
_02100894:
	str r10, [r1]
	mov r0, r10, asr #0x1f
	str r0, [r1, #4]
	b _02100A68
_021008A4:
	ldr r0, [sp, #0x25c]
	add r7, sp, #0x2c
	add r0, r0, #4
	str r0, [sp, #0x25c]
	ldr r0, [r0, #-4]
	mov r6, #1
	strb r0, [sp, #0x2c]
	b _02100924
_021008C4:
	mov r0, #0x25
	strb r0, [sp, #0x2c]
	add r7, sp, #0x2c
	mov r6, #1
	b _02100924
_021008D8:
	ldr r0, [sp, #0xc]
	bl strlen
	movs r4, r0
	beq _02100910
	ldr r1, [sp, #0xc]
	mov r0, r8
	mov r2, r4
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x22c
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
_02100910:
	add sp, sp, #0x22c
	add r0, r10, r4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02100924:
	ldrb r0, [sp, #0x1c]
	mov r4, r6
	cmp r0, #0
	beq _021009D8
	cmp r0, #2
	moveq r0, #0x30
	movne r0, #0x20
	strb r0, [sp, #0x19]
	ldrsb r0, [r7, #0]
	cmp r0, #0x2b
	cmpne r0, #0x2d
	cmpne r0, #0x20
	bne _02100994
	ldrsb r0, [sp, #0x19]
	cmp r0, #0x30
	bne _02100994
	mov r0, r8
	mov r1, r7
	mov r2, #1
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x22c
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
	add r7, r7, #1
	sub r6, r6, #1
_02100994:
	ldr r0, [sp, #0x24]
	cmp r4, r0
	bge _021009D8
_021009A0:
	mov r0, r8
	add r1, sp, #0x19
	mov r2, #1
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x22c
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldr r0, [sp, #0x24]
	add r4, r4, #1
	cmp r4, r0
	blt _021009A0
_021009D8:
	cmp r6, #0
	beq _02100A08
	mov r0, r8
	mov r1, r7
	mov r2, r6
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x22c
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
_02100A08:
	ldrb r0, [sp, #0x1c]
	cmp r0, #0
	bne _02100A64
	ldr r0, [sp, #0x24]
	cmp r4, r0
	bge _02100A64
	mov r6, #0x20
	add r7, sp, #0x18
_02100A28:
	mov r0, r8
	mov r1, r7
	mov r2, #1
	strb r6, [sp, #0x18]
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x22c
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldr r0, [sp, #0x24]
	add r4, r4, #1
	cmp r4, r0
	blt _02100A28
_02100A64:
	add r10, r10, r4
_02100A68:
	ldrsb r0, [r11, #0]
	cmp r0, #0
	bne _0210029C
_02100A74:
	mov r0, r10
	add sp, sp, #0x22c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02100A88: .word 0x02132654
_02100A8C: .word 0x02132658
	arm_func_end __pformatter

	arm_func_start __FileWrite
__FileWrite: // 0x02100A90
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, r1
	mov r3, r5
	mov r1, #1
	mov r4, r2
	bl __fwrite
	cmp r4, r0
	movne r5, #0
	mov r0, r5
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end __FileWrite

	arm_func_start __StringWrite
__StringWrite: // 0x02100ABC
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r3, [r4, #8]
	mov r5, r2
	ldr r2, [r4, #4]
	add r0, r3, r5
	cmp r0, r2
	ldr r0, [r4, #0]
	subhi r5, r2, r3
	mov r2, r5
	add r0, r0, r3
	bl memcpy
	ldr r1, [r4, #8]
	mov r0, #1
	add r1, r1, r5
	str r1, [r4, #8]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end __StringWrite

	arm_func_start printf
printf: // 0x02100B00
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, lr}
	ldr r0, _02100C00 // =0x02132320
	mvn r1, #0
	bl fwide
	cmp r0, #0
	mvnge r0, #0
	ldmgeia sp!, {r4, lr}
	addge sp, sp, #0x10
	bxge lr
	ldr r0, _02100C04 // =_02152590
	bl OS_TryLockMutex
	cmp r0, #0
	bne _02100B5C
	ldr r0, _02100C08 // =OSi_ThreadInfo
	ldr r1, _02100C0C // =_02152500
	ldr r2, [r0, #4]
	ldr r0, _02100C10 // =_02152524
	ldr r3, [r2, #0x6c]
	mov r2, #1
	str r3, [r1, #0xc]
	str r2, [r0, #0xc]
	b _02100BB4
_02100B5C:
	ldr r0, _02100C08 // =OSi_ThreadInfo
	ldr r1, _02100C0C // =_02152500
	ldr r0, [r0, #4]
	ldr r1, [r1, #0xc]
	ldr r0, [r0, #0x6c]
	cmp r1, r0
	bne _02100B8C
	ldr r0, _02100C10 // =_02152524
	ldr r1, [r0, #0xc]
	add r1, r1, #1
	str r1, [r0, #0xc]
	b _02100BB4
_02100B8C:
	ldr r0, _02100C04 // =_02152590
	bl OS_LockMutex
	ldr r0, _02100C08 // =OSi_ThreadInfo
	ldr r1, _02100C0C // =_02152500
	ldr r2, [r0, #4]
	ldr r0, _02100C10 // =_02152524
	ldr r3, [r2, #0x6c]
	mov r2, #1
	str r3, [r1, #0xc]
	str r2, [r0, #0xc]
_02100BB4:
	add r0, sp, #8
	bic r3, r0, #3
	ldr r2, [sp, #8]
	ldr r0, _02100C14 // =__FileWrite
	ldr r1, _02100C00 // =0x02132320
	add r3, r3, #4
	bl __pformatter
	ldr r1, _02100C10 // =_02152524
	mov r4, r0
	ldr r0, [r1, #0xc]
	subs r0, r0, #1
	str r0, [r1, #0xc]
	bne _02100BF0
	ldr r0, _02100C04 // =_02152590
	bl OS_UnlockMutex
_02100BF0:
	mov r0, r4
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02100C00: .word 0x02132320
_02100C04: .word _02152590
_02100C08: .word OSi_ThreadInfo
_02100C0C: .word _02152500
_02100C10: .word _02152524
_02100C14: .word __FileWrite
	arm_func_end printf

	arm_func_start vsnprintf
vsnprintf: // 0x02100C18
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r4, r1
	mov ip, #0
	ldr r0, _02100C7C // =__StringWrite
	add r1, sp, #0
	str r5, [sp]
	str r4, [sp, #4]
	str ip, [sp, #8]
	bl __pformatter
	cmp r5, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, pc}
	cmp r0, r4
	movlo r1, #0
	addlo sp, sp, #0xc
	strlob r1, [r5, r0]
	ldmloia sp!, {r4, r5, pc}
	cmp r4, #0
	addne r1, r5, r4
	movne r2, #0
	strneb r2, [r1, #-1]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02100C7C: .word __StringWrite
	arm_func_end vsnprintf

	arm_func_start snprintf
snprintf: // 0x02100C80
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, lr}
	add r3, sp, #0x10
	bic r3, r3, #3
	ldr r2, [sp, #0x10]
	add r3, r3, #4
	bl vsnprintf
	ldmia sp!, {r3, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end snprintf

	arm_func_start sprintf
sprintf: // 0x02100CA8
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, lr}
	add r1, sp, #0xc
	bic r1, r1, #3
	add r3, r1, #4
	ldr r2, [sp, #0xc]
	mvn r1, #0
	bl vsnprintf
	ldmia sp!, {r3, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sprintf

	arm_func_start qsort
qsort: // 0x02100CD4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	mov r9, r1
	cmp r9, #2
	mov r10, r0
	mov r8, r2
	mov r7, r3
	addlo sp, sp, #0x10
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r9, lsr #1
	add r11, r0, #1
	sub r0, r11, #1
	mla r0, r8, r0, r10
	sub r2, r9, #1
	str r0, [sp, #0xc]
	mla r0, r8, r2, r10
	str r0, [sp, #8]
	mul r0, r11, r8
	mvn r1, #0
	str r0, [sp, #4]
	mul r0, r8, r1
	str r0, [sp]
_02100D2C:
	cmp r11, #1
	bls _02100D54
	ldr r0, [sp, #4]
	sub r11, r11, #1
	sub r0, r0, r8
	str r0, [sp, #4]
	ldr r0, [sp, #0xc]
	sub r0, r0, r8
	str r0, [sp, #0xc]
	b _02100D9C
_02100D54:
	mov r2, r8
	ldr r4, [sp, #8]
	ldr r3, [sp, #0xc]
	cmp r8, #0
	beq _02100D80
_02100D68:
	ldrsb r0, [r4, #0]
	ldrsb r1, [r3, #0]
	subs r2, r2, #1
	strb r0, [r3], #1
	strb r1, [r4], #1
	bne _02100D68
_02100D80:
	sub r9, r9, #1
	cmp r9, #1
	addeq sp, sp, #0x10
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #8]
	sub r0, r0, r8
	str r0, [sp, #8]
_02100D9C:
	ldr r1, [sp, #4]
	ldr r0, [sp]
	mov r4, r11
	add r0, r1, r0
	cmp r9, r11, lsl #1
	add r5, r10, r0
	blo _02100D2C
_02100DB8:
	mov r4, r4, lsl #1
	sub r0, r4, #1
	mov r6, r5
	mla r5, r8, r0, r10
	cmp r9, r4
	bls _02100DE8
	mov r0, r5
	add r1, r5, r8
	blx r7
	cmp r0, #0
	addlt r4, r4, #1
	addlt r5, r5, r8
_02100DE8:
	mov r0, r6
	mov r1, r5
	blx r7
	cmp r0, #0
	bge _02100D2C
	mov r2, r8
	mov r3, r5
	cmp r8, #0
	beq _02100E24
_02100E0C:
	ldrsb r1, [r6, #0]
	ldrsb r0, [r3, #0]
	subs r2, r2, #1
	strb r0, [r6], #1
	strb r1, [r3], #1
	bne _02100E0C
_02100E24:
	cmp r9, r4, lsl #1
	bhs _02100DB8
	b _02100D2C
_02100E30:
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end qsort

	arm_func_start rand
rand: // 0x02100E38
	ldr r2, _02100E60 // =0x0213265C
	ldr r0, _02100E64 // =0x41C64E6D
	ldr r3, [r2, #0]
	ldr r1, _02100E68 // =0x00007FFF
	mul r0, r3, r0
	add r0, r0, #0x39
	add r0, r0, #0x3000
	str r0, [r2]
	and r0, r1, r0, lsr #16
	bx lr
	.align 2, 0
_02100E60: .word 0x0213265C
_02100E64: .word 0x41C64E6D
_02100E68: .word 0x00007FFF
	arm_func_end rand

	arm_func_start srand
srand: // 0x02100E6C
	ldr r1, _02100E78 // =0x0213265C
	str r0, [r1]
	bx lr
	.align 2, 0
_02100E78: .word 0x0213265C
	arm_func_end srand

	arm_func_start parse_format__printf__scanf
parse_format__printf__scanf: // 0x02100E7C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x28
	ldr r6, _0210136C // =_0211724C
	add r5, sp, #0
	mov r7, r0
	mov lr, r1
	mov r4, r5
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6!, {r0, r1, r2, r3}
	stmia r5!, {r0, r1, r2, r3}
	ldmia r6, {r0, r1}
	stmia r5, {r0, r1}
	ldrsb r0, [r7, #1]
	add ip, r7, #1
	cmp r0, #0x25
	bne _02100EE8
	strb r0, [sp, #3]
	ldmia r4!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r4!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r4, {r0, r1}
	stmia lr, {r0, r1}
	add sp, sp, #0x28
	add r0, ip, #1
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02100EE8:
	cmp r0, #0x2a
	moveq r0, #1
	streqb r0, [sp]
	ldreqsb r0, [ip, #1]!
	cmp r0, #0
	blt _02100F08
	cmp r0, #0x80
	blt _02100F10
_02100F08:
	mov r1, #0
	b _02100F20
_02100F10:
	ldr r1, _02101370 // =__ctype_mapC
	mov r2, r0, lsl #1
	ldrh r1, [r1, r2]
	and r1, r1, #8
_02100F20:
	cmp r1, #0
	beq _02100FC0
	mov r1, #0
	ldr r3, _02101370 // =__ctype_mapC
	str r1, [sp, #4]
	mov r4, r1
	mov r1, #0xa
_02100F3C:
	ldr r2, [sp, #4]
	sub r0, r0, #0x30
	mla r0, r2, r1, r0
	str r0, [sp, #4]
	ldrsb r0, [ip, #1]!
	cmp r0, #0
	blt _02100F60
	cmp r0, #0x80
	blt _02100F68
_02100F60:
	mov r2, r4
	b _02100F74
_02100F68:
	mov r2, r0, lsl #1
	ldrh r2, [r3, r2]
	and r2, r2, #8
_02100F74:
	cmp r2, #0
	bne _02100F3C
	ldr r1, [sp, #4]
	cmp r1, #0
	bne _02100FB8
	mov r0, #0xff
	add r4, sp, #0
	strb r0, [sp, #3]
	ldmia r4!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r4!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r4, {r0, r1}
	stmia lr, {r0, r1}
	add sp, sp, #0x28
	add r0, ip, #1
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02100FB8:
	mov r1, #1
	strb r1, [sp, #1]
_02100FC0:
	cmp r0, #0x6c
	mov r1, #1
	bgt _02100FF8
	cmp r0, #0x68
	blt _02100FEC
	beq _02101014
	cmp r0, #0x6a
	beq _02101060
	cmp r0, #0x6c
	beq _02101030
	b _02101084
_02100FEC:
	cmp r0, #0x4c
	beq _02101054
	b _02101084
_02100FF8:
	cmp r0, #0x74
	bgt _02101008
	beq _02101078
	b _02101084
_02101008:
	cmp r0, #0x7a
	beq _0210106C
	b _02101084
_02101014:
	mov r2, #2
	strb r2, [sp, #2]
	ldrsb r2, [ip, #1]
	cmp r2, #0x68
	streqb r1, [sp, #2]
	ldreqsb r0, [ip, #1]!
	b _02101088
_02101030:
	mov r2, #3
	strb r2, [sp, #2]
	ldrsb r2, [ip, #1]
	cmp r2, #0x6c
	bne _02101088
	mov r0, #7
	strb r0, [sp, #2]
	ldrsb r0, [ip, #1]!
	b _02101088
_02101054:
	mov r2, #9
	strb r2, [sp, #2]
	b _02101088
_02101060:
	mov r2, #4
	strb r2, [sp, #2]
	b _02101088
_0210106C:
	mov r2, #5
	strb r2, [sp, #2]
	b _02101088
_02101078:
	mov r2, #6
	strb r2, [sp, #2]
	b _02101088
_02101084:
	mov r1, #0
_02101088:
	cmp r1, #0
	ldrnesb r0, [ip, #1]!
	strb r0, [sp, #3]
	cmp r0, #0x5b
	bgt _021010DC
	bge _0210122C
	cmp r0, #0x47
	bgt _021010D0
	subs r1, r0, #0x41
	addpl pc, pc, r1, lsl #2
	b _0210133C
_021010B4: // jump table
	b _02101168 // case 0
	b _0210133C // case 1
	b _0210133C // case 2
	b _0210133C // case 3
	b _02101168 // case 4
	b _02101168 // case 5
	b _02101168 // case 6
_021010D0:
	cmp r0, #0x58
	beq _02101154
	b _0210133C
_021010DC:
	cmp r0, #0x61
	bgt _021010EC
	beq _02101168
	b _0210133C
_021010EC:
	sub r0, r0, #0x63
	cmp r0, #0x15
	addls pc, pc, r0, lsl #2
	b _0210133C
_021010FC: // jump table
	b _021011B8 // case 0
	b _02101154 // case 1
	b _02101168 // case 2
	b _02101168 // case 3
	b _02101168 // case 4
	b _0210133C // case 5
	b _02101154 // case 6
	b _0210133C // case 7
	b _0210133C // case 8
	b _0210133C // case 9
	b _0210133C // case 10
	b _02101344 // case 11
	b _02101154 // case 12
	b _021011A4 // case 13
	b _0210133C // case 14
	b _0210133C // case 15
	b _021011DC // case 16
	b _0210133C // case 17
	b _02101154 // case 18
	b _0210133C // case 19
	b _0210133C // case 20
	b _02101154 // case 21
_02101154:
	ldrb r0, [sp, #2]
	cmp r0, #9
	moveq r0, #0xff
	streqb r0, [sp, #3]
	b _02101344
_02101168:
	ldrb r1, [sp, #2]
	cmp r1, #1
	cmpne r1, #2
	beq _02101188
	add r0, r1, #0xfc
	and r0, r0, #0xff
	cmp r0, #3
	bhi _02101194
_02101188:
	mov r0, #0xff
	strb r0, [sp, #3]
	b _02101344
_02101194:
	cmp r1, #3
	moveq r0, #8
	streqb r0, [sp, #2]
	b _02101344
_021011A4:
	mov r1, #3
	mov r0, #0x78
	strb r1, [sp, #2]
	strb r0, [sp, #3]
	b _02101344
_021011B8:
	ldrb r0, [sp, #2]
	cmp r0, #3
	moveq r0, #0xa
	streqb r0, [sp, #2]
	beq _02101344
	cmp r0, #0
	movne r0, #0xff
	strneb r0, [sp, #3]
	b _02101344
_021011DC:
	ldrb r0, [sp, #2]
	cmp r0, #3
	moveq r0, #0xa
	streqb r0, [sp, #2]
	beq _021011FC
	cmp r0, #0
	movne r0, #0xff
	strneb r0, [sp, #3]
_021011FC:
	add r2, sp, #8
	mov r1, #0x20
	mov r0, #0xff
_02101208:
	sub r1, r1, #1
	cmp r1, #0
	strb r0, [r2], #1
	bgt _02101208
	mov r1, #0xc1
	mov r0, #0xfe
	strb r1, [sp, #9]
	strb r0, [sp, #0xc]
	b _02101344
_0210122C:
	ldrb r0, [sp, #2]
	cmp r0, #3
	moveq r0, #0xa
	streqb r0, [sp, #2]
	beq _0210124C
	cmp r0, #0
	movne r0, #0xff
	strneb r0, [sp, #3]
_0210124C:
	ldrsb r2, [ip, #1]!
	mov r1, #0
	cmp r2, #0x5e
	ldreqsb r2, [ip, #1]!
	moveq r1, #1
	cmp r2, #0x5d
	bne _021012F4
	ldrb r0, [sp, #0x13]
	orr r0, r0, #0x20
	strb r0, [sp, #0x13]
	ldrsb r2, [ip, #1]!
	b _021012F4
_0210127C:
	add r0, sp, #0
	and r3, r2, #0xff
	add r6, r0, r3, asr #3
	ldrb r5, [r6, #8]
	and r3, r2, #7
	mov r4, #1
	orr r3, r5, r4, lsl r3
	strb r3, [r6, #8]
	ldrsb r3, [ip, #1]
	cmp r3, #0x2d
	bne _021012F0
	ldrsb r7, [ip, #2]
	cmp r7, #0
	cmpne r7, #0x5d
	beq _021012F0
	add r2, r2, #1
	cmp r2, r7
	bgt _021012E8
_021012C4:
	and r3, r2, #0xff
	add r6, r0, r3, asr #3
	ldrb r5, [r6, #8]
	and r3, r2, #7
	add r2, r2, #1
	orr r3, r5, r4, lsl r3
	strb r3, [r6, #8]
	cmp r2, r7
	ble _021012C4
_021012E8:
	ldrsb r2, [ip, #3]!
	b _021012F4
_021012F0:
	ldrsb r2, [ip, #1]!
_021012F4:
	cmp r2, #0
	cmpne r2, #0x5d
	bne _0210127C
	cmp r2, #0
	moveq r0, #0xff
	streqb r0, [sp, #3]
	beq _02101344
	cmp r1, #0
	beq _02101344
	add r2, sp, #8
	mov r1, #0x20
_02101320:
	ldrb r0, [r2, #0]
	sub r1, r1, #1
	cmp r1, #0
	mvn r0, r0
	strb r0, [r2], #1
	bgt _02101320
	b _02101344
_0210133C:
	mov r0, #0xff
	strb r0, [sp, #3]
_02101344:
	add r4, sp, #0
	ldmia r4!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r4!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	ldmia r4, {r0, r1}
	stmia lr, {r0, r1}
	add r0, ip, #1
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0210136C: .word _0211724C
_02101370: .word __ctype_mapC
	arm_func_end parse_format__printf__scanf

	arm_func_start __sformatter
__sformatter: // 0x02101374
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x88
	ldrsb r5, [r2, #0]
	str r2, [sp, #0xc]
	mov r2, #0
	mov r9, r0
	mov r0, r2
	str r2, [sp, #0x20]
	mov r8, r1
	str r3, [sp, #0x10]
	str r0, [sp, #0x24]
	cmp r5, #0
	ldr r10, [sp, #0xb0]
	str r0, [sp, #0x30]
	mov r4, r2
	str r0, [sp, #0x44]
	str r0, [sp, #0x40]
	beq _02102088
_021013BC:
	cmp r5, #0
	mov r0, #1
	blt _021013D0
	cmp r5, #0x80
	movlt r0, #0
_021013D0:
	cmp r0, #0
	movne r0, #0
	bne _021013EC
	mov r1, r5, lsl #1
	ldr r0, _021020C0 // =__ctype_mapC
	ldrh r0, [r0, r1]
	and r0, r0, #0x100
_021013EC:
	cmp r0, #0
	beq _021014AC
	mov r2, #0
	ldr r1, _021020C0 // =__ctype_mapC
	mov ip, r2
	mov r3, #1
_02101404:
	ldr r0, [sp, #0xc]
	ldrsb r5, [r0, #1]!
	str r0, [sp, #0xc]
	mov r0, r3
	cmp r5, #0
	blt _02101424
	cmp r5, #0x80
	movlt r0, r2
_02101424:
	cmp r0, #0
	movne r0, ip
	moveq r0, r5, lsl #1
	ldreqh r0, [r1, r0]
	andeq r0, r0, #0x100
	cmp r0, #0
	bne _02101404
	ldr r0, [sp, #0x30]
	cmp r0, #0
	bne _02102078
	ldr r5, _021020C0 // =__ctype_mapC
	b _02101458
_02101454:
	add r4, r4, #1
_02101458:
	mov r1, #0
	mov r0, r8
	mov r2, r1
	blx r9
	strb r0, [sp, #0x50]
	ldrsb r1, [sp, #0x50]
	cmp r1, #0
	blt _02101480
	cmp r1, #0x80
	blt _02101488
_02101480:
	mov r0, #0
	b _02101494
_02101488:
	mov r0, r1, lsl #1
	ldrh r0, [r5, r0]
	and r0, r0, #0x100
_02101494:
	cmp r0, #0
	bne _02101454
	mov r0, r8
	mov r2, #1
	blx r9
	b _02102078
_021014AC:
	cmp r5, #0x25
	beq _02101524
	ldr r0, [sp, #0x30]
	cmp r0, #0
	bne _02101524
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	strb r0, [sp, #0x50]
	and r0, r5, #0xff
	ldrsb r1, [sp, #0x50]
	cmp r0, r1
	beq _02101510
	mov r0, r8
	mov r2, #1
	blx r9
	cmp r10, #0
	beq _02102088
	mov r0, #1
	str r0, [sp, #0x30]
	ldr r0, [sp, #0xc]
	add r0, r0, #1
	str r0, [sp, #0xc]
	b _02102078
_02101510:
	ldr r0, [sp, #0xc]
	add r4, r4, #1
	add r0, r0, #1
	str r0, [sp, #0xc]
	b _02102078
_02101524:
	ldr r0, [sp, #0xc]
	add r1, sp, #0x60
	bl parse_format__printf__scanf
	str r0, [sp, #0xc]
	ldrb r0, [sp, #0x60]
	cmp r0, #0
	bne _02101560
	ldrb r0, [sp, #0x63]
	cmp r0, #0x25
	beq _02101560
	ldr r0, [sp, #0x10]
	add r0, r0, #4
	str r0, [sp, #0x10]
	ldr r5, [r0, #-4]
	b _02101564
_02101560:
	mov r5, #0
_02101564:
	ldrb r0, [sp, #0x63]
	cmp r0, #0x6e
	beq _021015A4
	ldr r0, [sp, #0x30]
	cmp r0, #0
	bne _021015A4
	mov r0, r8
	mov r1, #0
	mov r2, #2
	blx r9
	cmp r0, #0
	beq _021015A4
	cmp r10, #0
	beq _02102088
	mov r0, #1
	str r0, [sp, #0x30]
_021015A4:
	ldrb r1, [sp, #0x63]
	cmp r1, #0x5b
	bgt _021015FC
	bge _02101DD0
	cmp r1, #0x47
	bgt _021015F0
	subs r0, r1, #0x41
	addpl pc, pc, r0, lsl #2
	b _021015E4
_021015C8: // jump table
	b _02101A4C // case 0
	b _02102088 // case 1
	b _02102088 // case 2
	b _02102088 // case 3
	b _02101A4C // case 4
	b _02101A4C // case 5
	b _02101A4C // case 6
_021015E4:
	cmp r1, #0x25
	beq _02101CC8
	b _02102088
_021015F0:
	cmp r1, #0x58
	beq _02101888
	b _02102088
_021015FC:
	cmp r1, #0x78
	bgt _02101674
	subs r0, r1, #0x63
	addpl pc, pc, r0, lsl #2
	b _02101668
_02101610: // jump table
	b _02101B10 // case 0
	b _0210167C // case 1
	b _02101A4C // case 2
	b _02101A4C // case 3
	b _02101A4C // case 4
	b _02102088 // case 5
	b _02101684 // case 6
	b _02102088 // case 7
	b _02102088 // case 8
	b _02102088 // case 9
	b _02102088 // case 10
	b _02102014 // case 11
	b _02101878 // case 12
	b _02102088 // case 13
	b _02102088 // case 14
	b _02102088 // case 15
	b _02101D54 // case 16
	b _02102088 // case 17
	b _02101880 // case 18
	b _02102088 // case 19
	b _02102088 // case 20
	b _02101888 // case 21
_02101668:
	cmp r1, #0x61
	beq _02101A4C
	b _02102088
_02101674:
	cmp r1, #0xff
	b _02102088
_0210167C:
	mov r0, #0xa
	b _02101688
_02101684:
	mov r0, #0
_02101688:
	ldr r1, [sp, #0x30]
	cmp r1, #0
	beq _021016A8
	mov r0, #0
	str r0, [sp, #0x1c]
	str r0, [sp, #0x20]
	str r0, [sp, #0x24]
	b _021017B0
_021016A8:
	ldrb r1, [sp, #0x62]
	add r2, sp, #0x5c
	cmp r1, #7
	cmpne r1, #4
	add r1, sp, #0x58
	bne _021016EC
	str r2, [sp]
	str r1, [sp, #4]
	add r1, sp, #0x54
	str r1, [sp, #8]
	ldr r1, [sp, #0x64]
	mov r2, r9
	mov r3, r8
	bl __strtoull
	str r0, [sp, #0x34]
	str r1, [sp, #0x18]
	b _02101710
_021016EC:
	str r2, [sp]
	str r1, [sp, #4]
	add r1, sp, #0x54
	str r1, [sp, #8]
	ldr r1, [sp, #0x64]
	mov r2, r9
	mov r3, r8
	bl __strtoul
	str r0, [sp, #0x3c]
_02101710:
	ldr r0, [sp, #0x5c]
	cmp r0, #0
	bne _02101740
	cmp r10, #0
	beq _02102088
	mov r0, #1
	str r0, [sp, #0x30]
	mov r0, #0
	str r0, [sp, #0x1c]
	str r0, [sp, #0x20]
	str r0, [sp, #0x24]
	b _021017B0
_02101740:
	add r4, r4, r0
	ldrb r0, [sp, #0x62]
	cmp r0, #7
	cmpne r0, #4
	bne _02101790
	ldr r0, [sp, #0x58]
	cmp r0, #0
	beq _0210177C
	ldr r0, [sp, #0x34]
	rsbs r0, r0, #0
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x18]
	rsc r0, r0, #0
	str r0, [sp, #0x24]
	b _021017B0
_0210177C:
	ldr r0, [sp, #0x34]
	str r0, [sp, #0x20]
	ldr r0, [sp, #0x18]
	str r0, [sp, #0x24]
	b _021017B0
_02101790:
	ldr r0, [sp, #0x58]
	cmp r0, #0
	ldreq r0, [sp, #0x3c]
	streq r0, [sp, #0x1c]
	beq _021017B0
	ldr r0, [sp, #0x3c]
	rsb r0, r0, #0
	str r0, [sp, #0x1c]
_021017B0:
	cmp r5, #0
	beq _02101868
	ldrb r0, [sp, #0x62]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _02101854
_021017C8: // jump table
	b _021017E8 // case 0
	b _021017F4 // case 1
	b _02101800 // case 2
	b _0210180C // case 3
	b _02101818 // case 4
	b _0210182C // case 5
	b _02101838 // case 6
	b _02101844 // case 7
_021017E8:
	ldr r0, [sp, #0x1c]
	str r0, [r5]
	b _02101854
_021017F4:
	ldr r0, [sp, #0x1c]
	strb r0, [r5]
	b _02101854
_02101800:
	ldr r0, [sp, #0x1c]
	strh r0, [r5]
	b _02101854
_0210180C:
	ldr r0, [sp, #0x1c]
	str r0, [r5]
	b _02101854
_02101818:
	ldr r0, [sp, #0x20]
	str r0, [r5]
	ldr r0, [sp, #0x24]
	str r0, [r5, #4]
	b _02101854
_0210182C:
	ldr r0, [sp, #0x1c]
	str r0, [r5]
	b _02101854
_02101838:
	ldr r0, [sp, #0x1c]
	str r0, [r5]
	b _02101854
_02101844:
	ldr r0, [sp, #0x20]
	str r0, [r5]
	ldr r0, [sp, #0x24]
	str r0, [r5, #4]
_02101854:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	ldreq r0, [sp, #0x44]
	addeq r0, r0, #1
	streq r0, [sp, #0x44]
_02101868:
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	str r0, [sp, #0x40]
	b _02102078
_02101878:
	mov r0, #8
	b _0210188C
_02101880:
	mov r0, #0xa
	b _0210188C
_02101888:
	mov r0, #0x10
_0210188C:
	ldr r1, [sp, #0x30]
	cmp r1, #0
	beq _021018AC
	mov r0, #0
	str r0, [sp, #0x3c]
	str r0, [sp, #0x34]
	str r0, [sp, #0x18]
	b _02101984
_021018AC:
	ldrb r1, [sp, #0x62]
	add r2, sp, #0x5c
	cmp r1, #7
	cmpne r1, #4
	add r1, sp, #0x58
	bne _021018F0
	str r2, [sp]
	str r1, [sp, #4]
	add r1, sp, #0x54
	str r1, [sp, #8]
	ldr r1, [sp, #0x64]
	mov r2, r9
	mov r3, r8
	bl __strtoull
	str r0, [sp, #0x34]
	str r1, [sp, #0x18]
	b _02101914
_021018F0:
	str r2, [sp]
	str r1, [sp, #4]
	add r1, sp, #0x54
	str r1, [sp, #8]
	ldr r1, [sp, #0x64]
	mov r2, r9
	mov r3, r8
	bl __strtoul
	str r0, [sp, #0x3c]
_02101914:
	ldr r0, [sp, #0x5c]
	cmp r0, #0
	bne _02101944
	cmp r10, #0
	beq _02102088
	mov r0, #1
	str r0, [sp, #0x30]
	mov r0, #0
	str r0, [sp, #0x3c]
	str r0, [sp, #0x34]
	str r0, [sp, #0x18]
	b _02101984
_02101944:
	add r4, r4, r0
	ldr r0, [sp, #0x58]
	cmp r0, #0
	beq _02101984
	ldrb r0, [sp, #0x62]
	cmp r0, #7
	ldrne r0, [sp, #0x3c]
	rsbne r0, r0, #0
	strne r0, [sp, #0x3c]
	bne _02101984
	ldr r0, [sp, #0x34]
	rsbs r0, r0, #0
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x18]
	rsc r0, r0, #0
	str r0, [sp, #0x18]
_02101984:
	cmp r5, #0
	beq _02101A3C
	ldrb r0, [sp, #0x62]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _02101A28
_0210199C: // jump table
	b _021019BC // case 0
	b _021019C8 // case 1
	b _021019D4 // case 2
	b _021019E0 // case 3
	b _021019EC // case 4
	b _02101A00 // case 5
	b _02101A0C // case 6
	b _02101A18 // case 7
_021019BC:
	ldr r0, [sp, #0x3c]
	str r0, [r5]
	b _02101A28
_021019C8:
	ldr r0, [sp, #0x3c]
	strb r0, [r5]
	b _02101A28
_021019D4:
	ldr r0, [sp, #0x3c]
	strh r0, [r5]
	b _02101A28
_021019E0:
	ldr r0, [sp, #0x3c]
	str r0, [r5]
	b _02101A28
_021019EC:
	ldr r0, [sp, #0x34]
	str r0, [r5]
	ldr r0, [sp, #0x18]
	str r0, [r5, #4]
	b _02101A28
_02101A00:
	ldr r0, [sp, #0x3c]
	str r0, [r5]
	b _02101A28
_02101A0C:
	ldr r0, [sp, #0x3c]
	str r0, [r5]
	b _02101A28
_02101A18:
	ldr r0, [sp, #0x34]
	str r0, [r5]
	ldr r0, [sp, #0x18]
	str r0, [r5, #4]
_02101A28:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	ldreq r0, [sp, #0x44]
	addeq r0, r0, #1
	streq r0, [sp, #0x44]
_02101A3C:
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	str r0, [sp, #0x40]
	b _02102078
_02101A4C:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	beq _02101A68
	ldr r0, _021020C4 // =0x021323F4
	ldr r0, [r0, #0]
	bl _f2d
	b _02101AB4
_02101A68:
	add r0, sp, #0x54
	str r0, [sp]
	ldr r0, [sp, #0x64]
	mov r1, r9
	mov r2, r8
	add r3, sp, #0x5c
	bl __strtold
	ldr r2, [sp, #0x5c]
	cmp r2, #0
	bne _02101AB0
	cmp r10, #0
	beq _02102088
	mov r0, #1
	str r0, [sp, #0x30]
	ldr r0, _021020C4 // =0x021323F4
	ldr r0, [r0, #0]
	bl _f2d
	b _02101AB4
_02101AB0:
	add r4, r4, r2
_02101AB4:
	cmp r5, #0
	beq _02101B00
	ldrb r2, [sp, #0x62]
	cmp r2, #0
	beq _02101ADC
	cmp r2, #8
	beq _02101AE8
	cmp r2, #9
	stmeqia r5, {r0, r1}
	b _02101AEC
_02101ADC:
	bl _d2f
	str r0, [r5]
	b _02101AEC
_02101AE8:
	stmia r5, {r0, r1}
_02101AEC:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	ldreq r0, [sp, #0x44]
	addeq r0, r0, #1
	streq r0, [sp, #0x44]
_02101B00:
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	str r0, [sp, #0x40]
	b _02102078
_02101B10:
	ldrb r0, [sp, #0x61]
	cmp r0, #0
	moveq r0, #1
	streq r0, [sp, #0x64]
	cmp r5, #0
	beq _02101C58
	cmp r10, #0
	beq _02101B44
	ldr r0, [sp, #0x10]
	mov r7, #1
	add r0, r0, #4
	ldr r11, [r0, #-4]
	str r0, [sp, #0x10]
_02101B44:
	ldr r0, [sp, #0x30]
	mov r1, #0
	cmp r0, #0
	str r1, [sp, #0x5c]
	beq _02101B64
	cmp r11, #0
	strneb r1, [r5]
	b _02102078
_02101B64:
	mvn r0, #0
	str r5, [sp, #0x2c]
	str r0, [sp, #0x48]
	b _02101BAC
_02101B74:
	ldrb r0, [sp, #0x62]
	strb r6, [sp, #0x50]
	cmp r0, #0xa
	ldrnesb r0, [sp, #0x50]
	strneb r0, [r5], #1
	bne _02101BA0
	mov r0, r5
	add r1, sp, #0x50
	mov r2, #1
	bl mbtowc
	add r5, r5, #1
_02101BA0:
	ldr r0, [sp, #0x5c]
	add r1, r0, #1
	str r1, [sp, #0x5c]
_02101BAC:
	ldr r0, [sp, #0x64]
	cmp r0, #0
	sub r0, r0, #1
	str r0, [sp, #0x64]
	beq _02101BFC
	cmp r10, #0
	beq _02101BDC
	cmp r11, r1
	movhi r7, #1
	movls r7, #0
	cmp r7, #0
	beq _02101BFC
_02101BDC:
	mov r1, #0
	mov r0, r8
	mov r2, r1
	blx r9
	mov r6, r0
	ldr r0, [sp, #0x48]
	cmp r6, r0
	bne _02101B74
_02101BFC:
	strb r6, [sp, #0x50]
	ldr r0, [sp, #0x5c]
	cmp r0, #0
	beq _02101C1C
	cmp r10, #0
	beq _02101C44
	cmp r7, #0
	bne _02101C44
_02101C1C:
	cmp r10, #0
	beq _02102088
	mov r0, #1
	cmp r11, #0
	str r0, [sp, #0x30]
	beq _02102078
	ldr r0, [sp, #0x2c]
	mov r1, #0
	strb r1, [r0]
	b _02102078
_02101C44:
	add r4, r4, r0
	ldr r0, [sp, #0x44]
	add r0, r0, #1
	str r0, [sp, #0x44]
	b _02101CB8
_02101C58:
	mov r0, #0
	str r0, [sp, #0x5c]
	mvn r5, #0
	b _02101C78
_02101C68:
	strb r6, [sp, #0x50]
	ldr r0, [sp, #0x5c]
	add r0, r0, #1
	str r0, [sp, #0x5c]
_02101C78:
	ldr r0, [sp, #0x64]
	cmp r0, #0
	sub r0, r0, #1
	str r0, [sp, #0x64]
	beq _02101CA8
	mov r1, #0
	mov r0, r8
	mov r2, r1
	blx r9
	mov r6, r0
	cmp r6, r5
	bne _02101C68
_02101CA8:
	strb r6, [sp, #0x50]
	ldr r0, [sp, #0x5c]
	cmp r0, #0
	beq _02102088
_02101CB8:
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	str r0, [sp, #0x40]
	b _02102078
_02101CC8:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	bne _02102078
	ldr r5, _021020C0 // =__ctype_mapC
	b _02101CE0
_02101CDC:
	add r4, r4, #1
_02101CE0:
	mov r1, #0
	mov r0, r8
	mov r2, r1
	blx r9
	strb r0, [sp, #0x50]
	ldrsb r1, [sp, #0x50]
	cmp r1, #0
	blt _02101D08
	cmp r1, #0x80
	blt _02101D10
_02101D08:
	mov r0, #0
	b _02101D1C
_02101D10:
	mov r0, r1, lsl #1
	ldrh r0, [r5, r0]
	and r0, r0, #0x100
_02101D1C:
	cmp r0, #0
	bne _02101CDC
	cmp r1, #0x25
	beq _02101D4C
	mov r0, r8
	mov r2, #1
	blx r9
	cmp r10, #0
	beq _02102088
	mov r0, #1
	str r0, [sp, #0x30]
	b _02102078
_02101D4C:
	add r4, r4, #1
	b _02102078
_02101D54:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	bne _02101DD0
	mov r1, #0
	mov r0, r8
	mov r2, r1
	blx r9
	strb r0, [sp, #0x50]
	b _02101D90
_02101D78:
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r4, r4, #1
	blx r9
	strb r0, [sp, #0x50]
_02101D90:
	ldrsb r1, [sp, #0x50]
	cmp r1, #0
	blt _02101DA4
	cmp r1, #0x80
	blt _02101DAC
_02101DA4:
	mov r0, #0
	b _02101DBC
_02101DAC:
	ldr r0, _021020C0 // =__ctype_mapC
	mov r2, r1, lsl #1
	ldrh r0, [r0, r2]
	and r0, r0, #0x100
_02101DBC:
	cmp r0, #0
	bne _02101D78
	mov r0, r8
	mov r2, #1
	blx r9
_02101DD0:
	cmp r5, #0
	beq _02101F4C
	cmp r10, #0
	beq _02101DF8
	ldr r0, [sp, #0x10]
	mov r7, #1
	add r0, r0, #4
	str r0, [sp, #0x10]
	ldr r0, [r0, #-4]
	sub r11, r0, #1
_02101DF8:
	ldr r0, [sp, #0x30]
	mov r1, #0
	cmp r0, #0
	str r1, [sp, #0x5c]
	beq _02101E18
	cmp r11, #0
	strneb r1, [r5]
	b _02102078
_02101E18:
	mvn r0, #0
	str r5, [sp, #0x28]
	str r0, [sp, #0x4c]
	b _02101E7C
_02101E28:
	strb r6, [sp, #0x50]
	ldrsb r1, [sp, #0x50]
	add r2, sp, #0x60
	and r3, r1, #0xff
	add r2, r2, r3, asr #3
	ldrb r3, [r2, #8]
	and r0, r1, #7
	mov r2, #1
	tst r3, r2, lsl r0
	beq _02101ECC
	ldrb r0, [sp, #0x62]
	cmp r0, #0xa
	strneb r1, [r5], #1
	bne _02101E70
	mov r0, r5
	add r1, sp, #0x50
	bl mbtowc
	add r5, r5, #2
_02101E70:
	ldr r0, [sp, #0x5c]
	add r1, r0, #1
	str r1, [sp, #0x5c]
_02101E7C:
	ldr r0, [sp, #0x64]
	cmp r0, #0
	sub r0, r0, #1
	str r0, [sp, #0x64]
	beq _02101ECC
	cmp r10, #0
	beq _02101EAC
	cmp r11, r1
	movhs r7, #1
	movlo r7, #0
	cmp r7, #0
	beq _02101ECC
_02101EAC:
	mov r1, #0
	mov r0, r8
	mov r2, r1
	blx r9
	mov r6, r0
	ldr r0, [sp, #0x4c]
	cmp r6, r0
	bne _02101E28
_02101ECC:
	strb r6, [sp, #0x50]
	ldr r0, [sp, #0x5c]
	cmp r0, #0
	beq _02101EEC
	cmp r10, #0
	beq _02101F24
	cmp r7, #0
	bne _02101F24
_02101EEC:
	mov r0, r8
	ldrsb r1, [sp, #0x50]
	mov r2, #1
	blx r9
	cmp r10, #0
	beq _02102088
	mov r0, #1
	cmp r11, #0
	str r0, [sp, #0x30]
	beq _02102078
	ldr r0, [sp, #0x28]
	mov r1, #0
	strb r1, [r0]
	b _02102078
_02101F24:
	add r4, r4, r0
	ldrb r0, [sp, #0x62]
	cmp r0, #0xa
	mov r0, #0
	streqh r0, [r5]
	strneb r0, [r5]
	ldr r0, [sp, #0x44]
	add r0, r0, #1
	str r0, [sp, #0x44]
	b _02101FE8
_02101F4C:
	mov r0, #0
	str r0, [sp, #0x5c]
	mvn r5, #0
	b _02101F90
_02101F5C:
	strb r6, [sp, #0x50]
	ldrsb r1, [sp, #0x50]
	and r0, r1, #7
	and r2, r1, #0xff
	add r1, sp, #0x60
	add r1, r1, r2, asr #3
	ldrb r2, [r1, #8]
	mov r1, #1
	tst r2, r1, lsl r0
	beq _02101FC0
	ldr r0, [sp, #0x5c]
	add r0, r0, #1
	str r0, [sp, #0x5c]
_02101F90:
	ldr r0, [sp, #0x64]
	cmp r0, #0
	sub r0, r0, #1
	str r0, [sp, #0x64]
	beq _02101FC0
	mov r1, #0
	mov r0, r8
	mov r2, r1
	blx r9
	mov r6, r0
	cmp r6, r5
	bne _02101F5C
_02101FC0:
	strb r6, [sp, #0x50]
	ldr r0, [sp, #0x5c]
	cmp r0, #0
	bne _02101FE4
	mov r0, r8
	ldrsb r1, [sp, #0x50]
	mov r2, #1
	blx r9
	b _02102078
_02101FE4:
	add r4, r4, r0
_02101FE8:
	ldr r0, [sp, #0x64]
	cmp r0, #0
	blt _02102004
	mov r0, r8
	ldrsb r1, [sp, #0x50]
	mov r2, #1
	blx r9
_02102004:
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	str r0, [sp, #0x40]
	b _02102078
_02102014:
	cmp r5, #0
	beq _02102078
	ldrb r0, [sp, #0x62]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _02102078
_0210202C: // jump table
	b _0210204C // case 0
	b _02102064 // case 1
	b _02102054 // case 2
	b _0210205C // case 3
	b _02102078 // case 4
	b _02102078 // case 5
	b _02102078 // case 6
	b _0210206C // case 7
_0210204C:
	str r4, [r5]
	b _02102078
_02102054:
	strh r4, [r5]
	b _02102078
_0210205C:
	str r4, [r5]
	b _02102078
_02102064:
	strb r4, [r5]
	b _02102078
_0210206C:
	str r4, [r5]
	mov r0, r4, asr #0x1f
	str r0, [r5, #4]
_02102078:
	ldr r0, [sp, #0xc]
	ldrsb r5, [r0, #0]
	cmp r5, #0
	bne _021013BC
_02102088:
	mov r0, r8
	mov r1, #0
	mov r2, #2
	blx r9
	cmp r0, #0
	beq _021020B4
	ldr r0, [sp, #0x40]
	cmp r0, #0
	addeq sp, sp, #0x88
	mvneq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_021020B4:
	ldr r0, [sp, #0x44]
	add sp, sp, #0x88
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021020C0: .word __ctype_mapC
_021020C4: .word 0x021323F4
	arm_func_end __sformatter

	arm_func_start __StringRead
__StringRead: // 0x021020C8
	cmp r2, #0
	beq _021020E4
	cmp r2, #1
	beq _02102114
	cmp r2, #2
	beq _0210213C
	b _02102144
_021020E4:
	ldr r1, [r0, #0]
	ldrsb r2, [r1, #0]
	cmp r2, #0
	bne _02102104
	mov r1, #1
	str r1, [r0, #4]
	sub r0, r1, #2
	bx lr
_02102104:
	add r1, r1, #1
	str r1, [r0]
	and r0, r2, #0xff
	bx lr
_02102114:
	ldr r2, [r0, #4]
	cmp r2, #0
	movne r2, #0
	strne r2, [r0, #4]
	bne _02102134
	ldr r2, [r0, #0]
	sub r2, r2, #1
	str r2, [r0]
_02102134:
	mov r0, r1
	bx lr
_0210213C:
	ldr r0, [r0, #4]
	bx lr
_02102144:
	mov r0, #0
	bx lr
	arm_func_end __StringRead

	arm_func_start vsscanf
vsscanf: // 0x0210214C
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	str r0, [sp, #4]
	cmp r0, #0
	ldrnesb r0, [r0, #0]
	mov lr, r1
	mov r3, r2
	cmpne r0, #0
	addeq sp, sp, #0xc
	mvneq r0, #0
	ldmeqia sp!, {pc}
	mov ip, #0
	str ip, [sp, #8]
	ldr r0, _0210219C // =__StringRead
	add r1, sp, #4
	mov r2, lr
	str ip, [sp]
	bl __sformatter
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0210219C: .word __StringRead
	arm_func_end vsscanf

	arm_func_start sscanf
sscanf: // 0x021021A0
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, lr}
	add r2, sp, #0xc
	bic r2, r2, #3
	ldr r1, [sp, #0xc]
	add r2, r2, #4
	bl vsscanf
	ldmia sp!, {r3, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sscanf

	arm_func_start raise
raise: // 0x021021C8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	cmp r5, #1
	blt _021021E0
	cmp r5, #7
	ble _021021E8
_021021E0:
	mvn r0, #0
	ldmia sp!, {r3, r4, r5, pc}
_021021E8:
	ldr r0, _021022E4 // =_021525F0
	bl OS_TryLockMutex
	cmp r0, #0
	bne _0210221C
	ldr r0, _021022E8 // =OSi_ThreadInfo
	ldr r1, _021022EC // =_02152500
	ldr r2, [r0, #4]
	ldr r0, _021022F0 // =_02152524
	ldr r3, [r2, #0x6c]
	mov r2, #1
	str r3, [r1, #0x1c]
	str r2, [r0, #0x1c]
	b _02102274
_0210221C:
	ldr r0, _021022E8 // =OSi_ThreadInfo
	ldr r1, _021022EC // =_02152500
	ldr r0, [r0, #4]
	ldr r1, [r1, #0x1c]
	ldr r0, [r0, #0x6c]
	cmp r1, r0
	bne _0210224C
	ldr r0, _021022F0 // =_02152524
	ldr r1, [r0, #0x1c]
	add r1, r1, #1
	str r1, [r0, #0x1c]
	b _02102274
_0210224C:
	ldr r0, _021022E4 // =_021525F0
	bl OS_LockMutex
	ldr r0, _021022E8 // =OSi_ThreadInfo
	ldr r1, _021022EC // =_02152500
	ldr r2, [r0, #4]
	ldr r0, _021022F0 // =_02152524
	ldr r3, [r2, #0x6c]
	mov r2, #1
	str r3, [r1, #0x1c]
	str r2, [r0, #0x1c]
_02102274:
	ldr r1, _021022F4 // =_02152924
	sub r2, r5, #1
	ldr r4, [r1, r2, lsl #2]
	cmp r4, #1
	movne r0, #0
	strne r0, [r1, r2, lsl #2]
	ldr r0, _021022F0 // =_02152524
	ldr r1, [r0, #0x1c]
	subs r1, r1, #1
	str r1, [r0, #0x1c]
	bne _021022A8
	ldr r0, _021022E4 // =_021525F0
	bl OS_UnlockMutex
_021022A8:
	cmp r4, #1
	beq _021022BC
	cmp r4, #0
	cmpeq r5, #1
	bne _021022C4
_021022BC:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
_021022C4:
	cmp r4, #0
	bne _021022D4
	mov r0, #0
	bl exit
_021022D4:
	mov r0, r5
	blx r4
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021022E4: .word _021525F0
_021022E8: .word OSi_ThreadInfo
_021022EC: .word _02152500
_021022F0: .word _02152524
_021022F4: .word _02152924
	arm_func_end raise

	arm_func_start strlen
strlen: // 0x021022F8
	mvn r2, #0
_021022FC:
	ldrsb r1, [r0], #1
	add r2, r2, #1
	cmp r1, #0
	bne _021022FC
	mov r0, r2
	bx lr
	arm_func_end strlen

	arm_func_start strcpy
strcpy: // 0x02102314
	stmdb sp!, {r3, r4, r5, lr}
	and r4, r1, #3
	and r3, r0, #3
	mov r2, r0
	cmp r3, r4
	bne _021023B0
	cmp r4, #0
	beq _0210236C
	ldrb r3, [r1, #0]
	strb r3, [r0]
	cmp r3, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	rsbs r4, r4, #3
	beq _02102364
_0210234C:
	ldrb r3, [r1, #1]!
	cmp r3, #0
	strb r3, [r2, #1]!
	ldmeqia sp!, {r3, r4, r5, pc}
	subs r4, r4, #1
	bne _0210234C
_02102364:
	add r2, r2, #1
	add r1, r1, #1
_0210236C:
	ldr r5, [r1, #0]
	ldr r3, _021023D4 // =0xFEFEFEFF
	mvn r4, r5
	add lr, r5, r3
	ldr ip, _021023D8 // =0x80808080
	and r4, lr, r4
	tst r4, ip
	bne _021023B0
	sub r2, r2, #4
_02102390:
	str r5, [r2, #4]!
	ldr r5, [r1, #4]!
	add r4, r5, r3
	mvn lr, r5
	and lr, r4, lr
	tst lr, ip
	beq _02102390
	add r2, r2, #4
_021023B0:
	ldrb r3, [r1, #0]
	strb r3, [r2]
	cmp r3, #0
	ldmeqia sp!, {r3, r4, r5, pc}
_021023C0:
	ldrb r3, [r1, #1]!
	cmp r3, #0
	strb r3, [r2, #1]!
	bne _021023C0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021023D4: .word 0xFEFEFEFF
_021023D8: .word 0x80808080
	arm_func_end strcpy

	arm_func_start strncpy
strncpy: // 0x021023DC
	stmdb sp!, {r3, lr}
	mov lr, r0
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
_021023EC:
	ldrsb r3, [r1], #1
	mov ip, lr
	strb r3, [lr], #1
	ldrsb r3, [ip]
	cmp r3, #0
	bne _02102420
	subs r2, r2, #1
	ldmeqia sp!, {r3, pc}
	mov r1, #0
_02102410:
	strb r1, [lr], #1
	subs r2, r2, #1
	bne _02102410
	ldmia sp!, {r3, pc}
_02102420:
	subs r2, r2, #1
	bne _021023EC
	ldmia sp!, {r3, pc}
	arm_func_end strncpy

	arm_func_start strcat
strcat: // 0x0210242C
	mov r3, r0
_02102430:
	ldrsb r2, [r3], #1
	cmp r2, #0
	bne _02102430
	sub r3, r3, #1
_02102440:
	ldrsb r2, [r1], #1
	mov ip, r3
	strb r2, [r3], #1
	ldrsb r2, [ip]
	cmp r2, #0
	bne _02102440
	bx lr
	arm_func_end strcat

	arm_func_start strcmp
strcmp: // 0x0210245C
	stmdb sp!, {r4, lr}
	ldrb r2, [r0, #0]
	ldrb r3, [r1, #0]
	subs r3, r2, r3
	movne r0, r3
	ldmneia sp!, {r4, pc}
	and r4, r0, #3
	and r3, r1, #3
	cmp r3, r4
	bne _02102538
	cmp r4, #0
	beq _021024D0
	cmp r2, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	rsbs r4, r4, #3
	beq _021024C8
_021024A0:
	ldrb r3, [r0, #1]!
	ldrb r2, [r1, #1]!
	subs r2, r3, r2
	movne r0, r2
	ldmneia sp!, {r4, pc}
	cmp r3, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	subs r4, r4, #1
	bne _021024A0
_021024C8:
	add r0, r0, #1
	add r1, r1, #1
_021024D0:
	ldr r2, [r0, #0]
	ldr r3, _02102568 // =0xFEFEFEFF
	mvn r4, r2
	add lr, r2, r3
	ldr ip, _0210256C // =0x80808080
	and r4, lr, r4
	tst r4, ip
	ldr r4, [r1, #0]
	bne _02102524
	cmp r2, r4
	bne _02102518
_021024FC:
	ldr r2, [r0, #4]!
	ldr r4, [r1, #4]!
	add lr, r2, r3
	tst lr, ip
	bne _02102524
	cmp r2, r4
	beq _021024FC
_02102518:
	sub r0, r0, #1
	sub r1, r1, #1
	b _02102538
_02102524:
	ldrb r2, [r0, #0]
	ldrb r3, [r1, #0]
	subs r3, r2, r3
	movne r0, r3
	ldmneia sp!, {r4, pc}
_02102538:
	cmp r2, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
_02102544:
	ldrb r3, [r0, #1]!
	ldrb r2, [r1, #1]!
	subs r2, r3, r2
	movne r0, r2
	ldmneia sp!, {r4, pc}
	cmp r3, #0
	bne _02102544
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02102568: .word 0xFEFEFEFF
_0210256C: .word 0x80808080
	arm_func_end strcmp

	arm_func_start strncmp
strncmp: // 0x02102570
	cmp r2, #0
	beq _0210259C
_02102578:
	ldrb ip, [r1], #1
	ldrb r3, [r0], #1
	cmp r3, ip
	subne r0, r3, ip
	bxne lr
	cmp r3, #0
	beq _0210259C
	subs r2, r2, #1
	bne _02102578
_0210259C:
	mov r0, #0
	bx lr
	arm_func_end strncmp

	arm_func_start strchr
strchr: // 0x021025A4
	ldrsb r2, [r0], #1
	mov r1, r1, lsl #0x18
	mov r1, r1, asr #0x18
	cmp r2, #0
	beq _021025D0
_021025B8:
	cmp r2, r1
	subeq r0, r0, #1
	bxeq lr
	ldrsb r2, [r0], #1
	cmp r2, #0
	bne _021025B8
_021025D0:
	cmp r1, #0
	movne r0, #0
	subeq r0, r0, #1
	bx lr
	arm_func_end strchr

	arm_func_start strspn
strspn: // 0x021025E0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	add ip, sp, #0
	mov r3, #8
	mov r2, #0
_021025F4:
	strb r2, [ip]
	strb r2, [ip, #1]
	strb r2, [ip, #2]
	strb r2, [ip, #3]
	add ip, ip, #4
	subs r3, r3, #1
	bne _021025F4
	ldrb r3, [r1, #0]
	add r4, r1, #1
	cmp r3, #0
	beq _02102650
	add lr, sp, #0
	mov r2, #1
_02102628:
	and ip, r3, #0xff
	and r1, r3, #7
	mov r1, r2, lsl r1
	ldrb r3, [lr, ip, asr #3]
	and r1, r1, #0xff
	orr r1, r3, r1
	strb r1, [lr, ip, asr #3]
	ldrb r3, [r4], #1
	cmp r3, #0
	bne _02102628
_02102650:
	ldrb r1, [r0, #0]
	add r4, r0, #1
	cmp r1, #0
	beq _02102690
	add ip, sp, #0
	mov r2, #1
_02102668:
	and r3, r1, #0xff
	and r1, r1, #7
	mov r1, r2, lsl r1
	ldrb r3, [ip, r3, asr #3]
	and r1, r1, #0xff
	tst r3, r1
	bne _02102690
	ldrb r1, [r4], #1
	cmp r1, #0
	bne _02102668
_02102690:
	sub r0, r4, r0
	sub r0, r0, #1
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	arm_func_end strspn

	arm_func_start strstr
strstr: // 0x021026A0
	stmdb sp!, {r4, lr}
	cmp r1, #0
	ldrneb r2, [r1, #0]
	cmpne r2, #0
	ldmeqia sp!, {r4, pc}
	ldrb r3, [r0, #0]
	add r4, r0, #1
	cmp r3, #0
	beq _02102704
_021026C4:
	cmp r3, r2
	bne _021026F8
	mov lr, r4
	add ip, r1, #1
_021026D4:
	ldrb r3, [ip], #1
	ldrb r0, [lr], #1
	cmp r0, r3
	bne _021026EC
	cmp r0, #0
	bne _021026D4
_021026EC:
	cmp r3, #0
	subeq r0, r4, #1
	ldmeqia sp!, {r4, pc}
_021026F8:
	ldrb r3, [r4], #1
	cmp r3, #0
	bne _021026C4
_02102704:
	mov r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end strstr

	arm_func_start __strtold
__strtold: // 0x0210270C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xa8
	ldr r4, [sp, #0xd0]
	mov r10, #0
	str r4, [sp, #0xd0]
	str r0, [sp]
	add r6, sp, #0x80
	mov r9, r1
	mov r8, r2
	str r3, [sp, #4]
	mov r4, r10
	str r10, [sp, #0x2c]
	mov r5, #1
	mov r0, #4
_02102744:
	strh r10, [r6]
	strh r10, [r6, #2]
	strh r10, [r6, #4]
	strh r10, [r6, #6]
	add r6, r6, #8
	subs r0, r0, #1
	bne _02102744
	mov r0, #0
	str r0, [sp, #0x28]
	strh r10, [r6]
	strh r10, [r6, #2]
	ldr r2, [sp, #0x28]
	ldr r1, [sp, #0xd0]
	strh r10, [r6, #4]
	str r2, [r1]
	mov r1, r2
	mov r0, r8
	str r1, [sp, #0x24]
	str r1, [sp, #0x20]
	str r1, [sp, #0x1c]
	str r1, [sp, #0x18]
	str r1, [sp, #0x10]
	str r1, [sp, #0xc]
	str r1, [sp, #8]
	add r4, r4, #1
	blx r9
	mov r1, r0
	ldr r7, _021036EC // =aFinity
	add r0, sp, #0x4d
	mov r6, #4
_021027BC:
	ldrb r3, [r7, #0]
	ldrb r2, [r7, #1]
	add r7, r7, #2
	strb r3, [r0]
	strb r2, [r0, #1]
	add r0, r0, #2
	subs r6, r6, #1
	bne _021027BC
	ldrb r3, [r7, #0]
	ldr r2, _021036F0 // =aNan_3
	strb r3, [r0]
	ldrb r3, [r2, #1]
	ldrb r0, [r2, #2]
	ldrb r6, [r2, #0]
	strb r3, [sp, #0x31]
	strb r0, [sp, #0x32]
	ldrb r3, [r2, #3]
	ldrb r0, [r2, #4]
	strb r6, [sp, #0x30]
	strb r3, [sp, #0x33]
	strb r0, [sp, #0x34]
	b _02103500
_02102814:
	cmp r5, #0x100
	bgt _0210288C
	bge _02102F94
	cmp r5, #0x20
	bgt _02102870
	bge _02102E68
	cmp r5, #8
	bgt _02102864
	cmp r5, #0
	addge pc, pc, r5, lsl #2
	b _02103500
_02102840: // jump table
	b _02103500 // case 0
	b _021028D0 // case 1
	b _02102CB4 // case 2
	b _02103500 // case 3
	b _02102D64 // case 4
	b _02103500 // case 5
	b _02103500 // case 6
	b _02103500 // case 7
	b _02102D8C // case 8
_02102864:
	cmp r5, #0x10
	beq _02102E30
	b _02103500
_02102870:
	cmp r5, #0x40
	bgt _02102880
	beq _02102EF4
	b _02103500
_02102880:
	cmp r5, #0x80
	beq _02102F40
	b _02103500
_0210288C:
	cmp r5, #0x2000
	bgt _021028B4
	bge _02102AE8
	cmp r5, #0x200
	bgt _021028A8
	beq _02102FF4
	b _02103500
_021028A8:
	cmp r5, #0x400
	beq _0210301C
	b _02103500
_021028B4:
	cmp r5, #0x4000
	bgt _021028C4
	beq _021029F0
	b _02103500
_021028C4:
	cmp r5, #0x8000
	beq _02103094
	b _02103500
_021028D0:
	cmp r1, #0
	blt _021028E0
	cmp r1, #0x80
	blt _021028E8
_021028E0:
	mov r0, #0
	b _021028F8
_021028E8:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #0x100
_021028F8:
	cmp r0, #0
	beq _02102924
	mov r1, #0
	mov r0, r8
	mov r2, r1
	blx r9
	mov r1, r0
	ldr r0, [sp, #0x2c]
	add r0, r0, #1
	str r0, [sp, #0x2c]
	b _02103500
_02102924:
	cmp r1, #0
	blt _02102934
	cmp r1, #0x80
	blt _0210293C
_02102934:
	mov r0, r1
	b _02102944
_0210293C:
	ldr r0, _021036F8 // =__upper_mapC
	ldrb r0, [r0, r1]
_02102944:
	cmp r0, #0x49
	bgt _02102970
	bge _021029A8
	cmp r0, #0x2d
	bgt _021029E8
	cmp r0, #0x2b
	blt _021029E8
	beq _02102984
	cmp r0, #0x2d
	beq _0210297C
	b _021029E8
_02102970:
	cmp r0, #0x4e
	beq _021029C8
	b _021029E8
_0210297C:
	mov r0, #1
	str r0, [sp, #0x28]
_02102984:
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r4, r4, #1
	blx r9
	mov r1, r0
	mov r0, #1
	str r0, [sp, #0x18]
	b _02103500
_021029A8:
	add r4, r4, #1
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	mov r1, r0
	mov r5, #0x4000
	b _02103500
_021029C8:
	add r4, r4, #1
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	mov r1, r0
	mov r5, #0x2000
	b _02103500
_021029E8:
	mov r5, #2
	b _02103500
_021029F0:
	mov r5, #1
	add r7, sp, #0x4d
	add r0, sp, #0x76
	mov r6, #4
_02102A00:
	ldrb r3, [r7, #0]
	ldrb r2, [r7, #1]
	add r7, r7, #2
	strb r3, [r0]
	strb r2, [r0, #1]
	add r0, r0, #2
	subs r6, r6, #1
	bne _02102A00
	ldrb r2, [r7, #0]
	add r6, sp, #0x77
	ldr r7, _021036F8 // =__upper_mapC
	strb r2, [r0]
	b _02102A54
_02102A34:
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r6, r6, #1
	add r5, r5, #1
	add r4, r4, #1
	blx r9
	mov r1, r0
_02102A54:
	cmp r5, #8
	bge _02102A84
	cmp r1, #0
	blt _02102A6C
	cmp r1, #0x80
	blt _02102A74
_02102A6C:
	mov r2, r1
	b _02102A78
_02102A74:
	ldrb r2, [r7, r1]
_02102A78:
	ldrsb r0, [r6, #0]
	cmp r0, r2
	beq _02102A34
_02102A84:
	cmp r5, #3
	cmpne r5, #8
	bne _02102AE0
	ldr r0, [sp, #0x28]
	cmp r0, #0
	beq _02102AB4
	ldr r1, _021036FC // =_021323F0
	mov r0, #0
	ldr r1, [r1, #0]
	bl _f_sub
	bl _f2d
	b _02102AC0
_02102AB4:
	ldr r0, _021036FC // =_021323F0
	ldr r0, [r0, #0]
	bl _f2d
_02102AC0:
	ldr r2, [sp, #0x2c]
	add r3, r2, r5
	ldr r2, [sp, #0x18]
	add r3, r2, r3
	ldr r2, [sp, #4]
	add sp, sp, #0xa8
	str r3, [r2]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02102AE0:
	mov r5, #0x1000
	b _02103500
_02102AE8:
	ldrb r3, [sp, #0x30]
	ldrb r0, [sp, #0x32]
	ldrb r2, [sp, #0x31]
	strb r3, [sp, #0x40]
	strb r0, [sp, #0x42]
	ldrb r3, [sp, #0x33]
	ldrb r0, [sp, #0x34]
	strb r2, [sp, #0x41]
	mov r5, #1
	strb r0, [sp, #0x44]
	mov r6, #0
	add r2, sp, #0x56
	strb r3, [sp, #0x43]
	mov r0, #8
_02102B20:
	strb r6, [r2]
	strb r6, [r2, #1]
	strb r6, [r2, #2]
	strb r6, [r2, #3]
	add r2, r2, #4
	subs r0, r0, #1
	bne _02102B20
	add r7, sp, #0x41
	b _02102B64
_02102B44:
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r7, r7, #1
	add r5, r5, #1
	add r4, r4, #1
	blx r9
	mov r1, r0
_02102B64:
	cmp r5, #4
	bge _02102B98
	cmp r1, #0
	blt _02102B7C
	cmp r1, #0x80
	blt _02102B84
_02102B7C:
	mov r2, r1
	b _02102B8C
_02102B84:
	ldr r0, _021036F8 // =__upper_mapC
	ldrb r2, [r0, r1]
_02102B8C:
	ldrsb r0, [r7, #0]
	cmp r0, r2
	beq _02102B44
_02102B98:
	sub r0, r5, #3
	cmp r0, #1
	bhi _02102CAC
	cmp r5, #4
	bne _02102C50
	ldr r7, _021036F4 // =__ctype_mapC
	b _02102BD8
_02102BB4:
	add r0, sp, #0x56
	strb r1, [r0, r6]
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r6, r6, #1
	add r4, r4, #1
	blx r9
	mov r1, r0
_02102BD8:
	cmp r6, #0x20
	bge _02102C40
	cmp r1, #0
	blt _02102BF0
	cmp r1, #0x80
	blt _02102BF8
_02102BF0:
	mov r0, #0
	b _02102C04
_02102BF8:
	mov r0, r1, lsl #1
	ldrh r0, [r7, r0]
	and r0, r0, #8
_02102C04:
	cmp r0, #0
	bne _02102BB4
	cmp r1, #0
	blt _02102C1C
	cmp r1, #0x80
	blt _02102C24
_02102C1C:
	mov r0, #0
	b _02102C30
_02102C24:
	mov r0, r1, lsl #1
	ldrh r0, [r7, r0]
	and r0, r0, #1
_02102C30:
	cmp r0, #0
	bne _02102BB4
	cmp r1, #0x2e
	beq _02102BB4
_02102C40:
	cmp r1, #0x29
	movne r5, #0x1000
	bne _02103500
	add r6, r6, #1
_02102C50:
	add r0, sp, #0x56
	mov r1, #0
	strb r1, [r0, r6]
	ldr r1, [sp, #0x28]
	cmp r1, #0
	beq _02102C84
	bl nan
	mov r2, r0
	mov r0, #0
	mov r3, r1
	mov r1, r0
	bl _dsub
	b _02102C88
_02102C84:
	bl nan
_02102C88:
	ldr r2, [sp, #0x2c]
	add r2, r2, r5
	add r3, r6, r2
	ldr r2, [sp, #0x18]
	add r3, r2, r3
	ldr r2, [sp, #4]
	add sp, sp, #0xa8
	str r3, [r2]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02102CAC:
	mov r5, #0x1000
	b _02103500
_02102CB4:
	cmp r1, #0x2e
	bne _02102CDC
	mov r5, #0x10
	add r4, r4, #1
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	mov r1, r0
	b _02103500
_02102CDC:
	cmp r1, #0
	blt _02102CEC
	cmp r1, #0x80
	blt _02102CF4
_02102CEC:
	mov r0, #0
	b _02102D04
_02102CF4:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #8
_02102D04:
	cmp r0, #0
	moveq r5, #0x1000
	beq _02103500
	cmp r1, #0x30
	bne _02102D5C
	add r4, r4, #1
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	cmp r0, #0
	mov r1, r0
	blt _02102D48
	cmp r0, #0x80
	bge _02102D48
	ldr r2, _021036F8 // =__upper_mapC
	ldrb r0, [r2, r0]
_02102D48:
	cmp r0, #0x58
	moveq r5, #0x8000
	moveq r10, #1
	movne r5, #4
	b _02103500
_02102D5C:
	mov r5, #8
	b _02103500
_02102D64:
	cmp r1, #0x30
	movne r5, #8
	bne _02103500
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02102D8C:
	cmp r1, #0
	blt _02102D9C
	cmp r1, #0x80
	blt _02102DA4
_02102D9C:
	mov r0, #0
	b _02102DB4
_02102DA4:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #8
_02102DB4:
	cmp r0, #0
	bne _02102DE8
	cmp r1, #0x2e
	movne r5, #0x40
	bne _02103500
	mov r1, #0
	mov r0, r8
	mov r2, r1
	mov r5, #0x20
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02102DE8:
	ldrb r2, [sp, #0x84]
	cmp r2, #0x14
	ldrhs r0, [sp, #0x1c]
	addhs r0, r0, #1
	strhs r0, [sp, #0x1c]
	bhs _02102E14
	add r0, r2, #1
	strb r0, [sp, #0x84]
	add r0, sp, #0x80
	add r0, r0, r2
	strb r1, [r0, #5]
_02102E14:
	add r4, r4, #1
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	mov r1, r0
	b _02103500
_02102E30:
	cmp r1, #0
	blt _02102E40
	cmp r1, #0x80
	blt _02102E48
_02102E40:
	mov r0, #0
	b _02102E58
_02102E48:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #8
_02102E58:
	cmp r0, #0
	moveq r5, #0x1000
	movne r5, #0x20
	b _02103500
_02102E68:
	cmp r1, #0
	blt _02102E78
	cmp r1, #0x80
	blt _02102E80
_02102E78:
	mov r0, #0
	b _02102E90
_02102E80:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #8
_02102E90:
	cmp r0, #0
	moveq r5, #0x40
	beq _02103500
	ldrb r3, [sp, #0x84]
	cmp r3, #0x14
	bhs _02102ED8
	cmp r1, #0x30
	cmpeq r3, #0
	beq _02102ECC
	ldrb r2, [sp, #0x84]
	add r0, sp, #0x80
	add r0, r0, r3
	add r2, r2, #1
	strb r2, [sp, #0x84]
	strb r1, [r0, #5]
_02102ECC:
	ldr r0, [sp, #0x1c]
	sub r0, r0, #1
	str r0, [sp, #0x1c]
_02102ED8:
	add r4, r4, #1
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	mov r1, r0
	b _02103500
_02102EF4:
	cmp r1, #0
	blt _02102F04
	cmp r1, #0x80
	blt _02102F0C
_02102F04:
	mov r0, r1
	b _02102F14
_02102F0C:
	ldr r0, _021036F8 // =__upper_mapC
	ldrb r0, [r0, r1]
_02102F14:
	cmp r0, #0x45
	movne r5, #0x800
	bne _02103500
	mov r1, #0
	mov r0, r8
	mov r2, r1
	mov r5, #0x80
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02102F40:
	cmp r1, #0x2b
	bne _02102F64
	add r4, r4, #1
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	mov r1, r0
	b _02102F8C
_02102F64:
	cmp r1, #0x2d
	bne _02102F8C
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r4, r4, #1
	blx r9
	mov r1, r0
	mov r0, #1
	str r0, [sp, #0x24]
_02102F8C:
	mov r5, #0x100
	b _02103500
_02102F94:
	cmp r1, #0
	blt _02102FA4
	cmp r1, #0x80
	blt _02102FAC
_02102FA4:
	mov r0, #0
	b _02102FBC
_02102FAC:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #8
_02102FBC:
	cmp r0, #0
	moveq r5, #0x1000
	beq _02103500
	cmp r1, #0x30
	movne r5, #0x400
	bne _02103500
	mov r1, #0
	mov r0, r8
	mov r2, r1
	mov r5, #0x200
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02102FF4:
	cmp r1, #0x30
	movne r5, #0x400
	bne _02103500
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_0210301C:
	cmp r1, #0
	blt _0210302C
	cmp r1, #0x80
	blt _02103034
_0210302C:
	mov r0, #0
	b _02103044
_02103034:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #8
_02103044:
	cmp r0, #0
	moveq r5, #0x800
	beq _02103500
	ldr r0, [sp, #0x20]
	sub r2, r1, #0x30
	mov r1, #0xa
	mla r0, r1, r0, r2
	ldr r1, _02103700 // =0x00007FFF
	str r0, [sp, #0x20]
	cmp r0, r1
	ldrgt r0, [sp, #0xd0]
	movgt r1, #1
	strgt r1, [r0]
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02103094:
	cmp r10, #0x20
	bgt _021030E4
	bge _021033B8
	cmp r10, #8
	bgt _021030D8
	cmp r10, #0
	addge pc, pc, r10, lsl #2
	b _02103500
_021030B4: // jump table
	b _02103500 // case 0
	b _02103108 // case 1
	b _02103158 // case 2
	b _02103500 // case 3
	b _02103180 // case 4
	b _02103500 // case 5
	b _02103500 // case 6
	b _02103500 // case 7
	b _02103290 // case 8
_021030D8:
	cmp r10, #0x10
	beq _0210336C
	b _02103500
_021030E4:
	cmp r10, #0x80
	bgt _021030FC
	bge _02103460
	cmp r10, #0x40
	beq _02103400
	b _02103500
_021030FC:
	cmp r10, #0x100
	beq _02103488
	b _02103500
_02103108:
	mov r1, #0
	add r0, sp, #0x45
	str r0, [sp, #0x14]
	strb r1, [r0]
	strb r1, [r0, #1]
	strb r1, [r0, #2]
	strb r1, [r0, #3]
	strb r1, [r0, #4]
	strb r1, [r0, #5]
	strb r1, [r0, #6]
	strb r1, [r0, #7]
	mov r0, r8
	mov r2, r1
	str r1, [sp, #8]
	mov r11, r1
	mov r10, #2
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02103158:
	cmp r1, #0x30
	movne r10, #4
	bne _02103500
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02103180:
	cmp r1, #0
	blt _02103190
	cmp r1, #0x80
	blt _02103198
_02103190:
	mov r0, #0
	b _021031A8
_02103198:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #0x400
_021031A8:
	cmp r0, #0
	bne _021031DC
	cmp r1, #0x2e
	movne r10, #0x10
	bne _02103500
	mov r1, #0
	mov r0, r8
	mov r2, r1
	mov r10, #8
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_021031DC:
	ldr r2, [sp, #8]
	mov r0, #0xe
	cmp r2, r0
	bhs _02103274
	mov r0, r2
	add r0, r0, #1
	str r0, [sp, #8]
	ldr r0, [sp, #0x14]
	add r2, r11, r11, lsr #31
	cmp r1, #0
	ldrb r0, [r0, r2, asr #1]
	blt _0210321C
	cmp r1, #0x80
	bge _0210321C
	ldr r2, _021036F8 // =__upper_mapC
	ldrb r1, [r2, r1]
_0210321C:
	cmp r1, #0x41
	subge r1, r1, #0x37
	sublt r1, r1, #0x30
	mov r2, r11, lsr #0x1f
	and r3, r1, #0xff
	rsb r1, r2, r11, lsl #31
	adds r1, r2, r1, ror #31
	moveq r1, r3, lsl #4
	add r2, r11, r11, lsr #31
	orrne r0, r0, r3
	andeq r1, r1, #0xff
	orreq r0, r0, r1
	ldr r1, [sp, #0x14]
	add r11, r11, #1
	strb r0, [r1, r2, asr #1]
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02103274:
	add r4, r4, #1
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	mov r1, r0
	b _02103500
_02103290:
	cmp r1, #0
	blt _021032A0
	cmp r1, #0x80
	blt _021032A8
_021032A0:
	mov r0, #0
	b _021032B8
_021032A8:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #0x400
_021032B8:
	cmp r0, #0
	moveq r10, #0x10
	beq _02103500
	ldr r2, [sp, #8]
	mov r0, #0xe
	cmp r2, r0
	bhs _02103350
	ldr r0, [sp, #0x14]
	add r2, r11, r11, lsr #31
	cmp r1, #0
	ldrb r0, [r0, r2, asr #1]
	blt _021032F8
	cmp r1, #0x80
	bge _021032F8
	ldr r2, _021036F8 // =__upper_mapC
	ldrb r1, [r2, r1]
_021032F8:
	cmp r1, #0x41
	subge r1, r1, #0x37
	sublt r1, r1, #0x30
	mov r2, r11, lsr #0x1f
	and r3, r1, #0xff
	rsb r1, r2, r11, lsl #31
	adds r1, r2, r1, ror #31
	moveq r1, r3, lsl #4
	add r2, r11, r11, lsr #31
	orrne r0, r0, r3
	andeq r1, r1, #0xff
	orreq r0, r0, r1
	ldr r1, [sp, #0x14]
	add r11, r11, #1
	strb r0, [r1, r2, asr #1]
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02103350:
	add r4, r4, #1
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	mov r1, r0
	b _02103500
_0210336C:
	cmp r1, #0
	blt _0210337C
	cmp r1, #0x80
	blt _02103384
_0210337C:
	mov r0, r1
	b _0210338C
_02103384:
	ldr r0, _021036F8 // =__upper_mapC
	ldrb r0, [r0, r1]
_0210338C:
	cmp r0, #0x50
	movne r5, #0x800
	bne _02103500
	mov r1, #0
	mov r0, r8
	mov r2, r1
	mov r10, #0x20
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_021033B8:
	cmp r1, #0x2d
	moveq r0, #1
	streq r0, [sp, #0xc]
	beq _021033E0
	cmp r1, #0x2b
	beq _021033E0
	mov r0, r8
	mov r2, #1
	blx r9
	sub r4, r4, #1
_021033E0:
	mov r10, #0x40
	add r4, r4, #1
	mov r0, r8
	mov r1, #0
	mov r2, r1
	blx r9
	mov r1, r0
	b _02103500
_02103400:
	cmp r1, #0
	blt _02103410
	cmp r1, #0x80
	blt _02103418
_02103410:
	mov r0, #0
	b _02103428
_02103418:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #8
_02103428:
	cmp r0, #0
	moveq r5, #0x1000
	beq _02103500
	cmp r1, #0x30
	movne r10, #0x100
	bne _02103500
	mov r1, #0
	mov r0, r8
	mov r2, r1
	mov r10, #0x80
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02103460:
	cmp r1, #0x30
	movne r10, #0x100
	bne _02103500
	mov r1, #0
	mov r0, r8
	mov r2, r1
	add r4, r4, #1
	blx r9
	mov r1, r0
	b _02103500
_02103488:
	cmp r1, #0
	blt _02103498
	cmp r1, #0x80
	blt _021034A0
_02103498:
	mov r0, #0
	b _021034B0
_021034A0:
	mov r2, r1, lsl #1
	ldr r0, _021036F4 // =__ctype_mapC
	ldrh r0, [r0, r2]
	and r0, r0, #8
_021034B0:
	cmp r0, #0
	moveq r5, #0x800
	beq _02103500
	ldr r0, [sp, #0x10]
	sub r2, r1, #0x30
	mov r1, #0xa
	mla r0, r1, r0, r2
	str r0, [sp, #0x10]
	ldr r1, _02103700 // =0x00007FFF
	ldr r0, [sp, #0x20]
	add r4, r4, #1
	cmp r0, r1
	ldrgt r0, [sp, #0xd0]
	movgt r1, #1
	strgt r1, [r0]
	mov r1, #0
	mov r0, r8
	mov r2, r1
	blx r9
	mov r1, r0
_02103500:
	ldr r0, [sp]
	cmp r4, r0
	bgt _02103520
	mvn r0, #0
	cmp r1, r0
	beq _02103520
	tst r5, #0x1800
	beq _02102814
_02103520:
	cmp r5, #0x8000
	beq _0210353C
	ldr r0, _02103704 // =0x00000E2C
	tst r5, r0
	moveq r0, #1
	movne r0, #0
	b _02103560
_0210353C:
	sub r0, r4, #1
	cmp r0, #2
	ble _02103554
	ldr r0, _02103708 // =0x0000018E
	tst r10, r0
	bne _0210355C
_02103554:
	mov r0, #1
	b _02103560
_0210355C:
	mov r0, #0
_02103560:
	cmp r0, #0
	movne r2, #0
	ldrne r0, [sp, #4]
	bne _02103580
	ldr r0, [sp, #0x2c]
	sub r2, r4, #1
	add r2, r2, r0
	ldr r0, [sp, #4]
_02103580:
	str r2, [r0]
	mov r0, r8
	mov r2, #1
	blx r9
	cmp r10, #0
	bne _02103784
	ldr r0, [sp, #0x24]
	ldrb r2, [sp, #0x84]
	cmp r0, #0
	ldrne r0, [sp, #0x20]
	rsbne r0, r0, #0
	strne r0, [sp, #0x20]
	add r0, sp, #0x85
	add r1, r0, r2
	b _021035C8
_021035BC:
	ldr r0, [sp, #0x1c]
	add r0, r0, #1
	str r0, [sp, #0x1c]
_021035C8:
	cmp r2, #0
	sub r2, r2, #1
	beq _021035E0
	ldrb r0, [r1, #-1]!
	cmp r0, #0x30
	beq _021035BC
_021035E0:
	add r0, r2, #1
	strb r0, [sp, #0x84]
	ands r2, r0, #0xff
	bne _02103604
	add r1, r2, #1
	strb r1, [sp, #0x84]
	add r0, sp, #0x85
	mov r1, #0x30
	strb r1, [r0, r2]
_02103604:
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x1c]
	mov r2, #0x8000
	add r0, r1, r0
	rsb r2, r2, #0
	str r0, [sp, #0x20]
	cmp r0, r2
	blt _0210362C
	cmp r0, r2, lsr #17
	ble _02103638
_0210362C:
	ldr r0, [sp, #0xd0]
	mov r1, #1
	str r1, [r0]
_02103638:
	ldr r0, [sp, #0xd0]
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _02103694
	ldr r0, [sp, #0x24]
	cmp r0, #0
	movne r0, #0
	addne sp, sp, #0xa8
	movne r1, r0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x28]
	cmp r0, #0
	ldreq r1, _0210370C // =0x021323F8
	addeq sp, sp, #0xa8
	ldmeqia r1, {r0, r1}
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _0210370C // =0x021323F8
	mov r0, #0
	ldmia r1, {r2, r3}
	mov r1, r0
	bl _dsub
	add sp, sp, #0xa8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02103694:
	ldr r1, [sp, #0x20]
	add r0, sp, #0x80
	strh r1, [sp, #0x82]
	bl __dec2num
	mov r4, r0
	mov r6, r1
	mov r0, #0
	mov r1, r0
	mov r2, r4
	mov r3, r6
	bl _dneq
	beq _02103714
	mov r0, r4
	mov r1, r6
	mov r2, #0
	mov r3, #0x100000
	bl _dleq
	bhs _02103714
	ldr r0, [sp, #0xd0]
	mov r1, #1
	str r1, [r0]
	b _02103740
	.align 2, 0
_021036EC: .word aFinity
_021036F0: .word aNan_3
_021036F4: .word __ctype_mapC
_021036F8: .word __upper_mapC
_021036FC: .word _021323F0
_02103700: .word 0x00007FFF
_02103704: .word 0x00000E2C
_02103708: .word 0x0000018E
_0210370C: .word 0x021323F8
_02103710: .word 0x7FEFFFFF
_02103714:
	ldr r3, _02103710 // =0x7FEFFFFF
	mov r0, r4
	mov r1, r6
	mvn r2, #0
	bl _dgeq
	bls _02103740
	ldr r0, [sp, #0xd0]
	mov r2, #1
	ldr r1, _0210370C // =0x021323F8
	str r2, [r0]
	ldmia r1, {r4, r6}
_02103740:
	ldr r0, [sp, #0x28]
	cmp r0, #0
	beq _02103774
	ldr r0, _02103704 // =0x00000E2C
	tst r5, r0
	beq _02103774
	mov r0, #0
	mov r1, r0
	mov r2, r4
	mov r3, r6
	bl _dsub
	mov r4, r0
	mov r6, r1
_02103774:
	add sp, sp, #0xa8
	mov r0, r4
	mov r1, r6
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02103784:
	ldr r0, [sp, #0xc]
	add r4, sp, #0x38
	cmp r0, #0
	ldrne r0, [sp, #0x10]
	ldrb r3, [sp, #0x45]
	rsbne r0, r0, #0
	strne r0, [sp, #0x10]
	ldr r1, [sp, #0x10]
	ldr r0, [sp, #8]
	mov r2, #0
	add r0, r1, r0, lsl #2
	str r0, [sp, #0x10]
	mov r1, #0x80
	b _021037CC
_021037BC:
	ldr r0, [sp, #0x10]
	add r2, r2, #1
	sub r0, r0, #1
	str r0, [sp, #0x10]
_021037CC:
	cmp r2, #4
	bhs _021037DC
	tst r3, r1, asr r2
	beq _021037BC
_021037DC:
	adds r5, r2, #1
	beq _02103828
	add r0, sp, #0x4c
	add r3, sp, #0x45
	str r0, [sp, #0x14]
	mov r1, #0
	cmp r0, r3
	blo _02103828
	rsb r6, r5, #8
_02103800:
	ldr r0, [sp, #0x14]
	ldrb r0, [r0, #0]
	orr r2, r1, r0, lsl r5
	mov r1, r0, asr r6
	ldr r0, [sp, #0x14]
	and r1, r1, #0xff
	strb r2, [r0], #-1
	str r0, [sp, #0x14]
	cmp r0, r3
	bhs _02103800
_02103828:
	mov r2, #0
	mov r6, r2
	strb r2, [r4]
	strb r2, [r4, #1]
	strb r2, [r4, #2]
	strb r2, [r4, #3]
	strb r2, [r4, #4]
	strb r2, [r4, #5]
	strb r2, [r4, #6]
	strb r2, [r4, #7]
	mov r3, #0xc
	mov r7, #1
	mov r0, #0xff
	add r1, sp, #0x45
_02103860:
	add r5, r2, #8
	cmp r5, #0x34
	ldrb r5, [r1, r6]
	rsbhi r8, r2, #0x34
	and r11, r3, #7
	andhi r5, r5, r0, lsl r8
	andhi r5, r5, #0xff
	mov r8, r5, asr r11
	and r9, r8, #0xff
	ldrb r10, [r4, r7]
	rsb r8, r11, #8
	mov r5, r5, lsl r8
	orr r9, r10, r9
	strb r9, [r4, r7]
	add r7, r7, #1
	add r2, r2, #8
	ldrb r8, [r4, r7]
	and r5, r5, #0xff
	cmp r2, #0x34
	orr r5, r8, r5
	strb r5, [r4, r7]
	add r3, r3, #8
	add r6, r6, #1
	blo _02103860
	ldr r0, [sp, #0x10]
	mov r1, #0x800
	add r0, r0, #0xfe
	add r2, r0, #0x300
	rsb r1, r1, #0
	tst r2, r1
	beq _021038F8
	ldr r2, [sp, #0xd0]
	mov r3, #1
	mov r0, #0
	add sp, sp, #0xa8
	mov r1, r0
	str r3, [r2]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_021038F8:
	ldrb r0, [r4, #1]
	mov r2, r2, lsl #0x15
	ldrb r1, [r4, #0]
	orr r0, r0, r2, lsr #17
	strb r0, [r4, #1]
	ldr r0, [sp, #0x28]
	orr r1, r1, r2, lsr #25
	cmp r0, #0
	andne r0, r1, #0xff
	strb r1, [r4]
	orrne r0, r0, #0x80
	strneb r0, [r4]
	mov r3, #0
_0210392C:
	rsb r1, r3, #7
	ldrb r2, [r4, r3]
	ldrb r0, [r4, r1]
	strb r0, [r4, r3]
	add r3, r3, #1
	strb r2, [r4, r1]
	cmp r3, #4
	blt _0210392C
	ldmia r4, {r0, r1}
	add sp, sp, #0xa8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end __strtold

	arm_func_start strtold
strtold: // 0x02103958
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r7, r0
	mov r0, #0
	mov r6, r1
	str r0, [sp, #8]
	add r4, sp, #0xc
	str r7, [sp, #4]
	ldr r1, _02103A2C // =__StringRead
	add r2, sp, #4
	add r3, sp, #0x10
	sub r0, r0, #0x80000001
	str r4, [sp]
	bl __strtold
	mov r5, r1
	mov r4, r0
	cmp r6, #0
	ldrne r0, [sp, #0x10]
	mov r1, r5
	addne r0, r7, r0
	strne r0, [r6]
	mov r0, r4
	bl fabs
	ldr r2, [sp, #0xc]
	mov r6, r0
	mov r7, r1
	cmp r2, #0
	bne _02103A10
	mov r0, #0
	mov r1, r0
	mov r2, r4
	mov r3, r5
	bl _dneq
	beq _02103A1C
	mov r0, r6
	mov r1, r7
	mov r2, #0
	mov r3, #0x100000
	bl _dleq
	blo _02103A10
	ldr r3, _02103A30 // =0x7FEFFFFF
	mov r0, r6
	mov r1, r7
	mvn r2, #0
	bl _dgeq
	bls _02103A1C
_02103A10:
	ldr r0, _02103A34 // =errno
	mov r1, #0x22
	str r1, [r0]
_02103A1C:
	mov r0, r4
	mov r1, r5
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02103A2C: .word __StringRead
_02103A30: .word 0x7FEFFFFF
_02103A34: .word errno
	arm_func_end strtold

	arm_func_start atof
atof: // 0x02103A38
	ldr ip, _02103A44 // =strtold
	mov r1, #0
	bx ip
	.align 2, 0
_02103A44: .word strtold
	arm_func_end atof

	arm_func_start __strtoul
__strtoul: // 0x02103A48
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r4, [sp, #0x38]
	movs r9, r0
	ldr r0, [sp, #0x34]
	str r4, [sp, #0x38]
	mov r4, #0
	str r0, [sp, #0x34]
	ldr r0, [sp, #0x38]
	str r1, [sp]
	str r4, [r0]
	mov r0, r4
	str r0, [sp, #4]
	ldr r0, [sp, #0x34]
	mov r1, r4
	str r1, [r0]
	ldr r0, [sp, #0x30]
	str r4, [sp, #8]
	mov r8, r2
	mov r7, r3
	mov r5, r4
	mov r10, r4
	str r0, [sp, #0x30]
	mov r4, #1
	bmi _02103AC8
	cmp r9, #1
	beq _02103AC8
	cmp r9, #0x24
	bgt _02103AC8
	ldr r0, [sp]
	cmp r0, #1
	bge _02103AD0
_02103AC8:
	mov r4, #0x40
	b _02103AEC
_02103AD0:
	ldr r1, [sp, #8]
	mov r0, r7
	mov r3, r1
	mov r2, r1
	add r5, r3, #1
	blx r8
	mov r6, r0
_02103AEC:
	cmp r9, #0
	beq _02103B04
	mov r1, r9
	mvn r0, #0
	bl _u32_div_f
	str r0, [sp, #4]
_02103B04:
	mvn r11, #0
	b _02103DC4
_02103B0C:
	cmp r4, #8
	bgt _02103B44
	cmp r4, #0
	addge pc, pc, r4, lsl #2
	b _02103DC4
_02103B20: // jump table
	b _02103DC4 // case 0
	b _02103B50 // case 1
	b _02103BFC // case 2
	b _02103DC4 // case 3
	b _02103C38 // case 4
	b _02103DC4 // case 5
	b _02103DC4 // case 6
	b _02103DC4 // case 7
	b _02103C78 // case 8
_02103B44:
	cmp r4, #0x10
	beq _02103C78
	b _02103DC4

_02103B50:
	cmp r6, #0
	blt _02103B60
	cmp r6, #0x80
	blt _02103B68
_02103B60:
	mov r0, #0
	b _02103B78
_02103B68:
	ldr r0, _02103E28 // =__ctype_mapC
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	and r0, r0, #0x100
_02103B78:
	cmp r0, #0
	beq _02103BA4
	mov r1, #0
	mov r0, r7
	mov r2, r1
	blx r8
	mov r6, r0
	ldr r0, [sp, #8]
	add r0, r0, #1
	str r0, [sp, #8]
	b _02103DC4
_02103BA4:
	cmp r6, #0x2b
	bne _02103BC8
	mov r1, #0
	mov r0, r7
	mov r2, r1
	add r5, r5, #1
	blx r8
	mov r6, r0
	b _02103BF4
_02103BC8:
	cmp r6, #0x2d
	bne _02103BF4
	mov r1, #0
	mov r0, r7
	mov r2, r1
	add r5, r5, #1
	blx r8
	mov r6, r0
	ldr r0, [sp, #0x34]
	mov r1, #1
	str r1, [r0]
_02103BF4:
	mov r4, #2
	b _02103DC4
	
_02103BFC: // 0x02103BFC
	cmp r9, #0
	cmpne r9, #0x10
	bne _02103C30
	cmp r6, #0x30
	bne _02103C30
	mov r1, #0
	mov r0, r7
	mov r2, r1
	mov r4, #4
	add r5, r5, #1
	blx r8
	mov r6, r0
	b _02103DC4
_02103C30:
	mov r4, #8
	b _02103DC4
	
_02103C38:
	cmp r6, #0x58
	cmpne r6, #0x78
	bne _02103C68
	mov r1, #0
	mov r0, r7
	mov r2, r1
	mov r9, #0x10
	mov r4, #8
	add r5, r5, #1
	blx r8
	mov r6, r0
	b _02103DC4
_02103C68:
	cmp r9, #0
	moveq r9, #8
	mov r4, #0x10
	b _02103DC4
_02103C78:
	ldr r0, [sp, #4]
	cmp r9, #0
	moveq r9, #0xa
	cmp r0, #0
	bne _02103C9C
	mov r0, r11
	mov r1, r9
	bl _u32_div_f
	str r0, [sp, #4]
_02103C9C:
	cmp r6, #0
	blt _02103CAC
	cmp r6, #0x80
	blt _02103CB4
_02103CAC:
	mov r0, #0
	b _02103CC4
_02103CB4:
	ldr r0, _02103E28 // =__ctype_mapC
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	and r0, r0, #8
_02103CC4:
	cmp r0, #0
	beq _02103CEC
	sub r6, r6, #0x30
	cmp r6, r9
	blt _02103D74
	cmp r4, #0x10
	moveq r4, #0x20
	movne r4, #0x40
	add r6, r6, #0x30
	b _02103DC4
_02103CEC:
	cmp r6, #0
	blt _02103CFC
	cmp r6, #0x80
	blt _02103D04
_02103CFC:
	mov r0, #0
	b _02103D14
_02103D04:
	ldr r0, _02103E28 // =__ctype_mapC
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	and r0, r0, #1
_02103D14:
	cmp r0, #0
	beq _02103D48
	cmp r6, #0
	blt _02103D2C
	cmp r6, #0x80
	blt _02103D34
_02103D2C:
	mov r0, r6
	b _02103D3C
_02103D34:
	ldr r0, _02103E2C // =__upper_mapC
	ldrb r0, [r0, r6]
_02103D3C:
	sub r0, r0, #0x37
	cmp r0, r9
	blt _02103D58
_02103D48:
	cmp r4, #0x10
	moveq r4, #0x20
	movne r4, #0x40
	b _02103DC4
_02103D58:
	cmp r6, #0
	blt _02103D70
	cmp r6, #0x80
	bge _02103D70
	ldr r0, _02103E2C // =__upper_mapC
	ldrb r6, [r0, r6]
_02103D70:
	sub r6, r6, #0x37
_02103D74:
	ldr r0, [sp, #4]
	mov r4, #0x10
	cmp r10, r0
	ldrhi r0, [sp, #0x38]
	movhi r1, #1
	strhi r1, [r0]
	mul r0, r10, r9
	mov r10, r0
	sub r0, r11, r0
	cmp r6, r0
	ldrhi r0, [sp, #0x38]
	movhi r1, #1
	strhi r1, [r0]
	mov r1, #0
	mov r0, r7
	mov r2, r1
	add r10, r10, r6
	add r5, r5, #1
	blx r8
	mov r6, r0
_02103DC4:
	ldr r0, [sp]
	cmp r5, r0
	bgt _02103DE0
	cmp r6, r11
	beq _02103DE0
	tst r4, #0x60
	beq _02103B0C
_02103DE0:
	tst r4, #0x34
	bne _02103DF8
	ldr r0, [sp, #0x30]
	mov r10, #0
	str r10, [r0]
	b _02103E0C
_02103DF8:
	ldr r0, [sp, #8]
	sub r1, r5, #1
	add r1, r1, r0
	ldr r0, [sp, #0x30]
	str r1, [r0]
_02103E0C:
	mov r0, r7
	mov r1, r6
	mov r2, #1
	blx r8
	mov r0, r10
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02103E28: .word __ctype_mapC
_02103E2C: .word __upper_mapC
	arm_func_end __strtoul

	arm_func_start __strtoull
__strtoull: // 0x02103E30
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r4, [sp, #0x48]
	movs r9, r0
	ldr r0, [sp, #0x44]
	str r4, [sp, #0x48]
	mov r4, #0
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x48]
	str r1, [sp]
	str r4, [r0]
	mov r0, r4
	str r0, [sp, #0xc]
	str r0, [sp, #8]
	ldr r0, [sp, #0x44]
	mov r1, r4
	str r1, [r0]
	ldr r0, [sp, #0x40]
	str r4, [sp, #0x14]
	mov r8, r2
	mov r7, r3
	mov r5, r4
	mov r10, r4
	mov r11, r4
	str r0, [sp, #0x40]
	mov r4, #1
	bmi _02103EB8
	cmp r9, #1
	beq _02103EB8
	cmp r9, #0x24
	bgt _02103EB8
	ldr r0, [sp]
	cmp r0, #1
	bge _02103EC0
_02103EB8:
	mov r4, #0x40
	b _02103ED8
_02103EC0:
	ldr r1, [sp, #0x14]
	mov r0, r7
	mov r2, r1
	add r5, r1, #1
	blx r8
	mov r6, r0
_02103ED8:
	cmp r9, #0
	beq _02103EFC
	mvn r0, #0
	mov r1, r0
	mov r3, r9, asr #0x1f
	mov r2, r9
	bl _ll_udiv
	str r0, [sp, #0xc]
	str r1, [sp, #8]
_02103EFC:
	mvn r0, #0
	str r0, [sp, #0x18]
	b _02104204
_02103F08:
	cmp r4, #8
	bgt _02103F40
	cmp r4, #0
	addge pc, pc, r4, lsl #2
	b _02104204
_02103F1C: // jump table
	b _02104204 // case 0
	b _02103F4C // case 1
	b _02103FF8 // case 2
	b _02104204 // case 3
	b _02104034 // case 4
	b _02104204 // case 5
	b _02104204 // case 6
	b _02104204 // case 7
	b _02104074 // case 8
_02103F40:
	cmp r4, #0x10
	beq _02104074
	b _02104204

_02103F4C:
	cmp r6, #0
	blt _02103F5C
	cmp r6, #0x80
	blt _02103F64
_02103F5C:
	mov r0, #0
	b _02103F74
_02103F64:
	ldr r0, _02104274 // =__ctype_mapC
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	and r0, r0, #0x100
_02103F74:
	cmp r0, #0
	beq _02103FA0
	mov r1, #0
	mov r0, r7
	mov r2, r1
	blx r8
	mov r6, r0
	ldr r0, [sp, #0x14]
	add r0, r0, #1
	str r0, [sp, #0x14]
	b _02104204
_02103FA0:
	cmp r6, #0x2b
	bne _02103FC4
	mov r1, #0
	mov r0, r7
	mov r2, r1
	add r5, r5, #1
	blx r8
	mov r6, r0
	b _02103FF0
_02103FC4:
	cmp r6, #0x2d
	bne _02103FF0
	mov r1, #0
	mov r0, r7
	mov r2, r1
	add r5, r5, #1
	blx r8
	mov r6, r0
	ldr r0, [sp, #0x44]
	mov r1, #1
	str r1, [r0]
_02103FF0:
	mov r4, #2
	b _02104204
	
_02103FF8:
	cmp r9, #0
	cmpne r9, #0x10
	bne _0210402C
	cmp r6, #0x30
	bne _0210402C
	mov r1, #0
	mov r0, r7
	mov r2, r1
	mov r4, #4
	add r5, r5, #1
	blx r8
	mov r6, r0
	b _02104204
_0210402C:
	mov r4, #8
	b _02104204
	
_02104034:
	cmp r6, #0x58
	cmpne r6, #0x78
	bne _02104064
	mov r1, #0
	mov r0, r7
	mov r2, r1
	mov r9, #0x10
	mov r4, #8
	add r5, r5, #1
	blx r8
	mov r6, r0
	b _02104204
_02104064:
	cmp r9, #0
	moveq r9, #8
	mov r4, #0x10
	b _02104204
_02104074:
	ldr r1, [sp, #8]
	mov r0, #0
	cmp r9, #0
	moveq r9, #0xa
	cmp r1, r0
	ldr r1, [sp, #0xc]
	cmpeq r1, r0
	bne _021040B0
	ldr r0, [sp, #0x18]
	mov r3, r9, asr #0x1f
	mov r1, r0
	mov r2, r9
	bl _ll_udiv
	str r0, [sp, #0xc]
	str r1, [sp, #8]
_021040B0:
	cmp r6, #0
	blt _021040C0
	cmp r6, #0x80
	blt _021040C8
_021040C0:
	mov r0, #0
	b _021040D8
_021040C8:
	ldr r0, _02104274 // =__ctype_mapC
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	and r0, r0, #8
_021040D8:
	cmp r0, #0
	beq _02104100
	sub r6, r6, #0x30
	cmp r6, r9
	blt _02104188
	cmp r4, #0x10
	moveq r4, #0x20
	movne r4, #0x40
	add r6, r6, #0x30
	b _02104204
_02104100:
	cmp r6, #0
	blt _02104110
	cmp r6, #0x80
	blt _02104118
_02104110:
	mov r0, #0
	b _02104128
_02104118:
	ldr r0, _02104274 // =__ctype_mapC
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	and r0, r0, #1
_02104128:
	cmp r0, #0
	beq _0210415C
	cmp r6, #0
	blt _02104140
	cmp r6, #0x80
	blt _02104148
_02104140:
	mov r0, r6
	b _02104150
_02104148:
	ldr r0, _02104278 // =__upper_mapC
	ldrb r0, [r0, r6]
_02104150:
	sub r0, r0, #0x37
	cmp r0, r9
	blt _0210416C
_0210415C:
	cmp r4, #0x10
	moveq r4, #0x20
	movne r4, #0x40
	b _02104204
_0210416C:
	cmp r6, #0
	blt _02104184
	cmp r6, #0x80
	bge _02104184
	ldr r0, _02104278 // =__upper_mapC
	ldrb r6, [r0, r6]
_02104184:
	sub r6, r6, #0x37
_02104188:
	ldr r0, [sp, #8]
	umull r2, r3, r10, r9
	cmp r11, r0
	ldr r0, [sp, #0xc]
	mov r4, #0x10
	cmpeq r10, r0
	ldrhi r0, [sp, #0x48]
	movhi r1, #1
	strhi r1, [r0]
	mov r1, r9, asr #0x1f
	mla r3, r10, r1, r3
	mla r3, r11, r9, r3
	ldr r1, [sp, #0x18]
	mov r10, r2
	subs r2, r1, r2
	mov r0, r6, asr #0x1f
	sbc r1, r1, r3
	cmp r0, r1
	cmpeq r6, r2
	ldrhi r1, [sp, #0x48]
	movhi r2, #1
	strhi r2, [r1]
	mov r1, #0
	mov r11, r3
	adds r10, r10, r6
	adc r11, r11, r0
	mov r0, r7
	mov r2, r1
	add r5, r5, #1
	blx r8
	mov r6, r0
_02104204:
	ldr r0, [sp]
	cmp r5, r0
	bgt _02104224
	ldr r0, [sp, #0x18]
	cmp r6, r0
	beq _02104224
	tst r4, #0x60
	beq _02103F08
_02104224:
	tst r4, #0x34
	bne _02104240
	ldr r0, [sp, #0x40]
	mov r10, #0
	mov r11, r10
	str r10, [r0]
	b _02104254
_02104240:
	ldr r0, [sp, #0x14]
	sub r1, r5, #1
	add r1, r1, r0
	ldr r0, [sp, #0x40]
	str r1, [r0]
_02104254:
	mov r0, r7
	mov r1, r6
	mov r2, #1
	blx r8
	mov r0, r10
	mov r1, r11
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02104274: .word __ctype_mapC
_02104278: .word __upper_mapC
	arm_func_end __strtoull

	arm_func_start strtoul
strtoul: // 0x0210427C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x20
	mov r5, r0
	mov lr, #0
	mov r0, r2
	mov r4, r1
	add r2, sp, #0x1c
	str r5, [sp, #0xc]
	str lr, [sp, #0x10]
	str r2, [sp]
	add r1, sp, #0x18
	str r1, [sp, #4]
	add ip, sp, #0x14
	ldr r2, _0210430C // =__StringRead
	add r3, sp, #0xc
	sub r1, lr, #0x80000001
	str ip, [sp, #8]
	bl __strtoul
	cmp r4, #0
	ldrne r1, [sp, #0x1c]
	addne r1, r5, r1
	strne r1, [r4]
	ldr r1, [sp, #0x14]
	cmp r1, #0
	beq _021042F8
	ldr r0, _02104310 // =errno
	mov r1, #0x22
	str r1, [r0]
	add sp, sp, #0x20
	mvn r0, #0
	ldmia sp!, {r3, r4, r5, pc}
_021042F8:
	ldr r1, [sp, #0x18]
	cmp r1, #0
	rsbne r0, r0, #0
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0210430C: .word __StringRead
_02104310: .word errno
	arm_func_end strtoul

	arm_func_start strtol
strtol: // 0x02104314
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x20
	mov r5, r0
	mov lr, #0
	mov r0, r2
	mov r4, r1
	add r2, sp, #0x1c
	str r5, [sp, #0xc]
	str lr, [sp, #0x10]
	str r2, [sp]
	add r1, sp, #0x18
	str r1, [sp, #4]
	add ip, sp, #0x14
	ldr r2, _021043D4 // =__StringRead
	add r3, sp, #0xc
	sub r1, lr, #0x80000001
	str ip, [sp, #8]
	bl __strtoul
	cmp r4, #0
	ldrne r1, [sp, #0x1c]
	addne r1, r5, r1
	strne r1, [r4]
	ldr r1, [sp, #0x14]
	cmp r1, #0
	bne _021043A0
	ldr r2, [sp, #0x18]
	cmp r2, #0
	bne _02104390
	mvn r1, #0x80000000
	cmp r0, r1
	bhi _021043A0
_02104390:
	cmp r2, #0
	beq _021043C4
	cmp r0, #0x80000000
	bls _021043C4
_021043A0:
	ldr r0, [sp, #0x18]
	ldr r1, _021043D8 // =errno
	mov r2, #0x22
	cmp r0, #0
	movne r0, #0x80000000
	str r2, [r1]
	add sp, sp, #0x20
	mvneq r0, #0x80000000
	ldmia sp!, {r3, r4, r5, pc}
_021043C4:
	cmp r2, #0
	rsbne r0, r0, #0
	add sp, sp, #0x20
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021043D4: .word __StringRead
_021043D8: .word errno
	arm_func_end strtol

	arm_func_start atoi
atoi: // 0x021043DC
	ldr ip, _021043EC // =strtol
	mov r1, #0
	mov r2, #0xa
	bx ip
	.align 2, 0
_021043EC: .word strtol
	arm_func_end atoi

	arm_func_start fwide
fwide: // 0x021043F0
	cmp r0, #0
	beq _02104408
	ldr r3, [r0, #4]
	mov r2, r3, lsl #0x16
	movs r2, r2, lsr #0x1d
	bne _02104410
_02104408:
	mov r0, #0
	bx lr
_02104410:
	mov r2, r3, lsl #0x14
	movs r2, r2, lsr #0x1e
	beq _02104430
	cmp r2, #1
	beq _02104458
	cmp r2, #2
	moveq r1, #1
	b _0210445C
_02104430:
	cmp r1, #0
	ble _02104448
	bic r2, r3, #0xc00
	orr r2, r2, #0x800
	str r2, [r0, #4]
	b _0210445C
_02104448:
	biclt r2, r3, #0xc00
	orrlt r2, r2, #0x400
	strlt r2, [r0, #4]
	b _0210445C
_02104458:
	mvn r1, #0
_0210445C:
	mov r0, r1
	bx lr
	arm_func_end fwide

	arm_func_start wmemcpy
wmemcpy: // 0x02104464
	ldr ip, _02104470 // =memcpy
	mov r2, r2, lsl #1
	bx ip
	.align 2, 0
_02104470: .word memcpy
	arm_func_end wmemcpy

	arm_func_start sub_2104474
sub_2104474: // 0x02104474
	cmp r2, #0
	beq _02104494
_0210447C:
	ldrh r3, [r0, #0]
	cmp r3, r1
	bxeq lr
	add r0, r0, #2
	subs r2, r2, #1
	bne _0210447C
_02104494:
	mov r0, #0
	bx lr
	arm_func_end sub_2104474

	arm_func_start parse_format
parse_format: // 0x0210449C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	ldrh r3, [r0, #2]
	mov r4, #0
	mov r5, #1
	mov lr, r2
	strb r5, [sp]
	strb r4, [sp, #1]
	strb r4, [sp, #2]
	strb r4, [sp, #3]
	strb r4, [sp, #4]
	str r4, [sp, #8]
	str r4, [sp, #0xc]
	cmp r3, #0x25
	add ip, r0, #2
	bne _021044F8
	add r0, sp, #0
	strh r3, [sp, #6]
	ldmia r0, {r0, r1, r2, r3}
	stmia lr, {r0, r1, r2, r3}
	add sp, sp, #0x10
	add r0, ip, #2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_021044F8:
	mov r2, #2
	mov r0, r4
	mov r5, r2
	mov r6, r4
	mov r7, #1
_0210450C:
	mov r8, r7
	cmp r3, #0x2b
	bgt _0210453C
	bge _02104564
	cmp r3, #0x23
	bgt _02104594
	cmp r3, #0x20
	blt _02104594
	beq _0210456C
	cmp r3, #0x23
	beq _0210457C
	b _02104594
_0210453C:
	cmp r3, #0x30
	bgt _02104594
	cmp r3, #0x2d
	blt _02104594
	beq _0210455C
	cmp r3, #0x30
	beq _02104584
	b _02104594
_0210455C:
	strb r6, [sp]
	b _02104598
_02104564:
	strb r7, [sp, #1]
	b _02104598
_0210456C:
	ldrb r4, [sp, #1]
	cmp r4, #1
	strneb r5, [sp, #1]
	b _02104598
_0210457C:
	strb r7, [sp, #3]
	b _02104598
_02104584:
	ldrb r4, [sp]
	cmp r4, #0
	strneb r2, [sp]
	b _02104598
_02104594:
	mov r8, r0
_02104598:
	cmp r8, #0
	ldrneh r3, [ip, #2]!
	bne _0210450C
	cmp r3, #0x2a
	bne _021045E0
	ldr r0, [r1, #0]
	add r0, r0, #4
	str r0, [r1]
	ldr r0, [r0, #-4]
	str r0, [sp, #8]
	cmp r0, #0
	bge _021045D8
	rsb r0, r0, #0
	mov r2, #0
	strb r2, [sp]
	str r0, [sp, #8]
_021045D8:
	ldrh r3, [ip, #2]!
	b _02104624
_021045E0:
	mov r2, #0
	ldr r5, _02104A08 // =0x02117384
	mov r0, #0xa
	b _02104604
_021045F0:
	ldr r4, [sp, #8]
	sub r3, r3, #0x30
	mla r6, r4, r0, r3
	ldrh r3, [ip, #2]!
	str r6, [sp, #8]
_02104604:
	cmp r3, #0x80
	movhs r4, r2
	bhs _0210461C
	mov r4, r3, lsl #1
	ldrh r4, [r5, r4]
	and r4, r4, #8
_0210461C:
	cmp r4, #0
	bne _021045F0
_02104624:
	ldr r2, [sp, #8]
	ldr r0, _02104A0C // =0x000001FD
	cmp r2, r0
	ble _02104654
	ldr r1, _02104A10 // =0x0000FFFF
	add r0, sp, #0
	strh r1, [sp, #6]
	ldmia r0, {r0, r1, r2, r3}
	stmia lr, {r0, r1, r2, r3}
	add sp, sp, #0x10
	add r0, ip, #2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02104654:
	cmp r3, #0x2e
	bne _021046DC
	ldrh r3, [ip, #2]!
	mov r0, #1
	strb r0, [sp, #2]
	cmp r3, #0x2a
	bne _02104698
	ldr r0, [r1, #0]
	add r0, r0, #4
	str r0, [r1]
	ldr r0, [r0, #-4]
	ldrh r3, [ip, #2]!
	str r0, [sp, #0xc]
	cmp r0, #0
	movlt r0, #0
	strltb r0, [sp, #2]
	b _021046DC
_02104698:
	mov r1, #0
	ldr r4, _02104A08 // =0x02117384
	mov r0, #0xa
	b _021046BC
_021046A8:
	ldr r2, [sp, #0xc]
	sub r3, r3, #0x30
	mla r5, r2, r0, r3
	ldrh r3, [ip, #2]!
	str r5, [sp, #0xc]
_021046BC:
	cmp r3, #0x80
	movhs r2, r1
	bhs _021046D4
	mov r2, r3, lsl #1
	ldrh r2, [r4, r2]
	and r2, r2, #8
_021046D4:
	cmp r2, #0
	bne _021046A8
_021046DC:
	cmp r3, #0x6c
	mov r0, #1
	bgt _02104714
	cmp r3, #0x68
	blt _02104708
	beq _02104730
	cmp r3, #0x6a
	beq _0210477C
	cmp r3, #0x6c
	beq _0210474C
	b _021047A0
_02104708:
	cmp r3, #0x4c
	beq _02104770
	b _021047A0
_02104714:
	cmp r3, #0x74
	bgt _02104724
	beq _02104788
	b _021047A0
_02104724:
	cmp r3, #0x7a
	beq _02104794
	b _021047A0
_02104730:
	ldrh r1, [ip, #2]
	mov r2, #2
	strb r2, [sp, #4]
	cmp r1, #0x68
	streqb r0, [sp, #4]
	ldreqh r3, [ip, #2]!
	b _021047A4
_0210474C:
	ldrh r1, [ip, #2]
	mov r2, #3
	strb r2, [sp, #4]
	cmp r1, #0x6c
	bne _021047A4
	mov r1, #4
	strb r1, [sp, #4]
	ldrh r3, [ip, #2]!
	b _021047A4
_02104770:
	mov r1, #9
	strb r1, [sp, #4]
	b _021047A4
_0210477C:
	mov r1, #6
	strb r1, [sp, #4]
	b _021047A4
_02104788:
	mov r1, #8
	strb r1, [sp, #4]
	b _021047A4
_02104794:
	mov r1, #7
	strb r1, [sp, #4]
	b _021047A4
_021047A0:
	mov r0, #0
_021047A4:
	cmp r0, #0
	ldrneh r3, [ip, #2]!
	strh r3, [sp, #6]
	cmp r3, #0x61
	bgt _021047F8
	bge _021048DC
	cmp r3, #0x47
	bgt _021047EC
	subs r0, r3, #0x41
	addpl pc, pc, r0, lsl #2
	b _021049E8
_021047D0: // jump table
	b _021048DC // case 0
	b _021049E8 // case 1
	b _021049E8 // case 2
	b _021049E8 // case 3
	b _02104924 // case 4
	b _021048A4 // case 5
	b _02104914 // case 6
_021047EC:
	cmp r3, #0x58
	beq _0210486C
	b _021049E8
_021047F8:
	cmp r3, #0x63
	bgt _02104808
	beq _02104984
	b _021049E8
_02104808:
	sub r0, r3, #0x64
	cmp r0, #0x14
	addls pc, pc, r0, lsl #2
	b _021049E8
_02104818: // jump table
	b _0210486C // case 0
	b _02104924 // case 1
	b _021048A4 // case 2
	b _02104914 // case 3
	b _021049E8 // case 4
	b _0210486C // case 5
	b _021049E8 // case 6
	b _021049E8 // case 7
	b _021049E8 // case 8
	b _021049E8 // case 9
	b _021049D4 // case 10
	b _0210486C // case 11
	b _02104960 // case 12
	b _021049E8 // case 13
	b _021049E8 // case 14
	b _021049B0 // case 15
	b _021049E8 // case 16
	b _0210486C // case 17
	b _021049E8 // case 18
	b _021049E8 // case 19
	b _0210486C // case 20
_0210486C:
	ldrb r0, [sp, #4]
	cmp r0, #9
	moveq r0, #4
	streqb r0, [sp, #4]
	ldrb r0, [sp, #2]
	cmp r0, #0
	moveq r0, #1
	streq r0, [sp, #0xc]
	beq _021049F0
	ldrb r0, [sp]
	cmp r0, #2
	moveq r0, #1
	streqb r0, [sp]
	b _021049F0
_021048A4:
	ldrb r0, [sp, #4]
	cmp r0, #2
	cmpne r0, #6
	cmpne r0, #7
	cmpne r0, #8
	cmpne r0, #4
	ldreq r0, _02104A10 // =0x0000FFFF
	streqh r0, [sp, #6]
	beq _021049F0
	ldrb r0, [sp, #2]
	cmp r0, #0
	moveq r0, #6
	streq r0, [sp, #0xc]
	b _021049F0
_021048DC:
	ldrb r0, [sp, #2]
	cmp r0, #0
	moveq r0, #0xd
	streq r0, [sp, #0xc]
	ldrb r0, [sp, #4]
	cmp r0, #2
	cmpne r0, #6
	cmpne r0, #7
	cmpne r0, #8
	cmpne r0, #4
	cmpne r0, #1
	ldreq r0, _02104A10 // =0x0000FFFF
	streqh r0, [sp, #6]
	b _021049F0
_02104914:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	moveq r0, #1
	streq r0, [sp, #0xc]
_02104924:
	ldrb r0, [sp, #4]
	cmp r0, #2
	cmpne r0, #6
	cmpne r0, #7
	cmpne r0, #8
	cmpne r0, #4
	cmpne r0, #1
	ldreq r0, _02104A10 // =0x0000FFFF
	streqh r0, [sp, #6]
	beq _021049F0
	ldrb r0, [sp, #2]
	cmp r0, #0
	moveq r0, #6
	streq r0, [sp, #0xc]
	b _021049F0
_02104960:
	mov r3, #3
	mov r2, #1
	mov r1, #0x78
	mov r0, #8
	strb r3, [sp, #4]
	strb r2, [sp, #3]
	strh r1, [sp, #6]
	str r0, [sp, #0xc]
	b _021049F0
_02104984:
	ldrb r1, [sp, #4]
	cmp r1, #3
	moveq r0, #5
	streqb r0, [sp, #4]
	beq _021049F0
	ldrb r0, [sp, #2]
	cmp r0, #0
	cmpeq r1, #0
	ldrne r0, _02104A10 // =0x0000FFFF
	strneh r0, [sp, #6]
	b _021049F0
_021049B0:
	ldrb r0, [sp, #4]
	cmp r0, #3
	moveq r0, #5
	streqb r0, [sp, #4]
	beq _021049F0
	cmp r0, #0
	ldrne r0, _02104A10 // =0x0000FFFF
	strneh r0, [sp, #6]
	b _021049F0
_021049D4:
	ldrb r0, [sp, #4]
	cmp r0, #9
	moveq r0, #4
	streqb r0, [sp, #4]
	b _021049F0
_021049E8:
	ldr r0, _02104A10 // =0x0000FFFF
	strh r0, [sp, #6]
_021049F0:
	add r0, sp, #0
	ldmia r0, {r0, r1, r2, r3}
	stmia lr, {r0, r1, r2, r3}
	add r0, ip, #2
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02104A08: .word 0x02117384
_02104A0C: .word 0x000001FD
_02104A10: .word 0x0000FFFF
	arm_func_end parse_format

	arm_func_start long2str__wprintf
long2str__wprintf: // 0x02104A14
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10
	movs r10, r0
	mov r0, #0
	mov r5, r1
	str r0, [sp, #0xc]
	ldr r7, [sp, #0x4c]
	mov r6, r0
	strh r0, [r5, #-2]!
	ldrb r0, [sp, #0x43]
	str r1, [sp]
	ldrh r8, [sp, #0x46]
	str r0, [sp, #4]
	ldr r0, [sp, #0x48]
	ldrb r11, [sp, #0x41]
	str r0, [sp, #8]
	cmpeq r7, #0
	bne _02104A88
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _02104A74
	cmp r8, #0x6f
	beq _02104A88
_02104A74:
	add sp, sp, #0x10
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02104A88:
	cmp r8, #0x69
	bgt _02104AB0
	bge _02104AE4
	cmp r8, #0x58
	bgt _02104AA4
	beq _02104B10
	b _02104B18
_02104AA4:
	cmp r8, #0x64
	beq _02104AE4
	b _02104B18
_02104AB0:
	cmp r8, #0x6f
	bgt _02104AC4
	moveq r4, #8
	moveq r11, #0
	b _02104B18
_02104AC4:
	cmp r8, #0x78
	bgt _02104B18
	cmp r8, #0x75
	blt _02104B18
	beq _02104B04
	cmp r8, #0x78
	beq _02104B10
	b _02104B18
_02104AE4:
	cmp r10, #0
	mov r4, #0xa
	bge _02104B18
	mov r0, #1
	cmp r10, #0x80000000
	rsbne r10, r10, #0
	str r0, [sp, #0xc]
	b _02104B18
_02104B04:
	mov r4, #0xa
	mov r11, #0
	b _02104B18
_02104B10:
	mov r4, #0x10
	mov r11, #0
_02104B18:
	mov r0, r10
	mov r1, r4
	bl _u32_div_f
	mov r9, r1
	mov r0, r10
	mov r1, r4
	bl _u32_div_f
	cmp r9, #0xa
	mov r10, r0
	addlt r9, r9, #0x30
	blt _02104B50
	cmp r8, #0x78
	addeq r9, r9, #0x57
	addne r9, r9, #0x37
_02104B50:
	cmp r10, #0
	strh r9, [r5, #-2]!
	add r6, r6, #1
	bne _02104B18
	cmp r4, #8
	bne _02104B84
	ldr r0, [sp, #4]
	cmp r0, #0
	ldrneh r0, [r5, #0]
	cmpne r0, #0x30
	movne r0, #0x30
	strneh r0, [r5, #-2]!
	addne r6, r6, #1
_02104B84:
	ldrb r0, [sp, #0x40]
	cmp r0, #2
	bne _02104BB8
	ldr r0, [sp, #0xc]
	ldr r7, [sp, #8]
	cmp r0, #0
	cmpeq r11, #0
	subne r7, r7, #1
	cmp r4, #0x10
	bne _02104BB8
	ldr r0, [sp, #4]
	cmp r0, #0
	subne r7, r7, #2
_02104BB8:
	ldr r0, [sp]
	ldr r1, _02104C60 // =0x000001FD
	sub r0, r0, r5
	add r0, r0, r0, lsr #31
	add r0, r7, r0, asr #1
	cmp r0, r1
	addgt sp, sp, #0x10
	movgt r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addgt sp, sp, #0x10
	bxgt lr
	cmp r6, r7
	bge _02104C00
	mov r0, #0x30
_02104BF0:
	add r6, r6, #1
	cmp r6, r7
	strh r0, [r5, #-2]!
	blt _02104BF0
_02104C00:
	cmp r4, #0x10
	bne _02104C1C
	ldr r0, [sp, #4]
	cmp r0, #0
	movne r0, #0x30
	strneh r8, [r5, #-2]
	strneh r0, [r5, #-4]!
_02104C1C:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	movne r0, #0x2d
	strneh r0, [r5, #-2]!
	bne _02104C4C
	cmp r11, #1
	moveq r0, #0x2b
	streqh r0, [r5, #-2]!
	beq _02104C4C
	cmp r11, #2
	moveq r0, #0x20
	streqh r0, [r5, #-2]!
_02104C4C:
	mov r0, r5
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02104C60: .word 0x000001FD
	arm_func_end long2str__wprintf

	arm_func_start longlong2str__wprintf
longlong2str__wprintf: // 0x02104C64
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	mov r9, r1
	mov r1, #0
	mov r10, r0
	mov r6, r2
	mov r0, r1
	strh r0, [r6, #-2]!
	ldr r0, [sp, #0x58]
	cmp r9, #0
	str r0, [sp, #0x10]
	ldrb r0, [sp, #0x4f]
	cmpeq r10, #0
	str r2, [sp]
	str r0, [sp, #4]
	ldr r0, [sp, #0x54]
	str r1, [sp, #0x14]
	str r0, [sp, #8]
	ldrb r0, [sp, #0x4d]
	mov r7, r1
	ldrh r8, [sp, #0x52]
	str r0, [sp, #0xc]
	ldreq r0, [sp, #0x10]
	cmpeq r0, #0
	bne _02104CF4
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _02104CE0
	cmp r8, #0x6f
	beq _02104CF4
_02104CE0:
	add sp, sp, #0x18
	mov r0, r6
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02104CF4:
	cmp r8, #0x69
	bgt _02104D1C
	bge _02104D4C
	cmp r8, #0x58
	bgt _02104D10
	beq _02104DA0
	b _02104DAC
_02104D10:
	cmp r8, #0x64
	beq _02104D4C
	b _02104DAC
_02104D1C:
	cmp r8, #0x6f
	bgt _02104D2C
	beq _02104D80
	b _02104DAC
_02104D2C:
	cmp r8, #0x78
	bgt _02104DAC
	cmp r8, #0x75
	blt _02104DAC
	beq _02104D90
	cmp r8, #0x78
	beq _02104DA0
	b _02104DAC
_02104D4C:
	subs r0, r10, #0
	sbcs r0, r9, #0
	mov r11, #0xa
	mov r5, #0
	bge _02104DAC
	cmp r9, #0x80000000
	cmpeq r10, r5
	beq _02104D74
	rsbs r10, r10, #0
	rsc r9, r9, #0
_02104D74:
	mov r0, #1
	str r0, [sp, #0x14]
	b _02104DAC
_02104D80:
	mov r5, #0
	str r5, [sp, #0xc]
	mov r11, #8
	b _02104DAC
_02104D90:
	mov r5, #0
	str r5, [sp, #0xc]
	mov r11, #0xa
	b _02104DAC
_02104DA0:
	mov r5, #0
	str r5, [sp, #0xc]
	mov r11, #0x10
_02104DAC:
	mov r0, r10
	mov r1, r9
	mov r2, r11
	mov r3, r5
	bl _ull_mod
	mov r4, r0
	mov r0, r10
	mov r1, r9
	mov r2, r11
	mov r3, r5
	bl _ll_udiv
	mov r10, r0
	cmp r4, #0xa
	mov r9, r1
	addlt r0, r4, #0x30
	blt _02104DF8
	cmp r8, #0x78
	addeq r0, r4, #0x57
	addne r0, r4, #0x37
_02104DF8:
	strh r0, [r6, #-2]!
	mov r0, #0
	cmp r9, r0
	cmpeq r10, r0
	add r7, r7, #1
	bne _02104DAC
	cmp r5, #0
	cmpeq r11, #8
	bne _02104E38
	ldr r0, [sp, #4]
	cmp r0, #0
	ldrneh r0, [r6, #0]
	cmpne r0, #0x30
	movne r0, #0x30
	strneh r0, [r6, #-2]!
	addne r7, r7, #1
_02104E38:
	ldrb r0, [sp, #0x4c]
	cmp r0, #2
	bne _02104E88
	ldr r0, [sp, #8]
	str r0, [sp, #0x10]
	ldr r0, [sp, #0x14]
	cmp r0, #0
	ldreq r0, [sp, #0xc]
	cmpeq r0, #0
	ldrne r0, [sp, #0x10]
	subne r0, r0, #1
	strne r0, [sp, #0x10]
	cmp r5, #0
	cmpeq r11, #0x10
	bne _02104E88
	ldr r0, [sp, #4]
	cmp r0, #0
	ldrne r0, [sp, #0x10]
	subne r0, r0, #2
	strne r0, [sp, #0x10]
_02104E88:
	ldr r0, [sp]
	ldr r2, _02104F44 // =0x000001FD
	sub r0, r0, r6
	add r1, r0, r0, lsr #31
	ldr r0, [sp, #0x10]
	add r0, r0, r1, asr #1
	cmp r0, r2
	addgt sp, sp, #0x18
	movgt r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addgt sp, sp, #0x10
	bxgt lr
	ldr r0, [sp, #0x10]
	cmp r7, r0
	bge _02104EDC
	mov r1, #0x30
_02104EC8:
	ldr r0, [sp, #0x10]
	add r7, r7, #1
	cmp r7, r0
	strh r1, [r6, #-2]!
	blt _02104EC8
_02104EDC:
	cmp r5, #0
	cmpeq r11, #0x10
	bne _02104EFC
	ldr r0, [sp, #4]
	cmp r0, #0
	movne r0, #0x30
	strneh r8, [r6, #-2]
	strneh r0, [r6, #-4]!
_02104EFC:
	ldr r0, [sp, #0x14]
	cmp r0, #0
	movne r0, #0x2d
	strneh r0, [r6, #-2]!
	bne _02104F30
	ldr r0, [sp, #0xc]
	cmp r0, #1
	moveq r0, #0x2b
	streqh r0, [r6, #-2]!
	beq _02104F30
	cmp r0, #2
	moveq r0, #0x20
	streqh r0, [r6, #-2]!
_02104F30:
	mov r0, r6
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02104F44: .word 0x000001FD
	arm_func_end longlong2str__wprintf

	arm_func_start double2hex__wprintf
double2hex__wprintf: // 0x02104F48
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x44
	ldr r7, [sp, #0x80]
	ldr r0, _021052B4 // =0x000001FD
	mov r8, r2
	cmp r7, r0
	ldrh r6, [sp, #0x7a]
	ldrb r5, [sp, #0x77]
	ldrb r4, [sp, #0x75]
	ldr r1, [sp, #0x68]
	ldr r2, [sp, #0x6c]
	addgt sp, sp, #0x44
	movgt r0, #0
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	addgt sp, sp, #0x10
	bxgt lr
	mov r10, #0
	mov r9, #0x20
	add r0, sp, #8
	add r3, sp, #0xc
	strb r10, [sp, #8]
	strh r9, [sp, #0xa]
	bl __num2dec
	ldr r0, [sp, #0x68]
	ldr r1, [sp, #0x6c]
	bl fabs
	mov r2, r0
	mov r0, r10
	mov r3, r1
	mov r1, r0
	bl _dls
	bne _02104FF0
	sub r4, r8, #0xc
	ldr r1, _021052B8 // =0x02132660
	mov r0, r4
	bl wcscpy
	add sp, sp, #0x44
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_02104FF0:
	ldrb r0, [sp, #0x11]
	cmp r0, #0x49
	bne _02105070
	ldrsb r0, [sp, #0xc]
	cmp r0, #0
	beq _02105034
	cmp r6, #0x41
	sub r4, r8, #0xa
	bne _02105024
	ldr r1, _021052BC // =0x0213266C
	mov r0, r4
	bl wcscpy
	b _0210505C
_02105024:
	ldr r1, _021052C0 // =0x02132678
	mov r0, r4
	bl wcscpy
	b _0210505C
_02105034:
	cmp r6, #0x41
	sub r4, r8, #8
	bne _02105050
	ldr r1, _021052C4 // =0x02132684
	mov r0, r4
	bl wcscpy
	b _0210505C
_02105050:
	ldr r1, _021052C8 // =0x0213268C
	mov r0, r4
	bl wcscpy
_0210505C:
	add sp, sp, #0x44
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_02105070:
	cmp r0, #0x4e
	bne _021050EC
	ldrsb r0, [sp, #0xc]
	cmp r0, #0
	beq _021050B0
	cmp r6, #0x41
	sub r4, r8, #0xa
	bne _021050A0
	ldr r1, _021052CC // =0x02132694
	mov r0, r4
	bl wcscpy
	b _021050D8
_021050A0:
	ldr r1, _021052D0 // =0x021326A0
	mov r0, r4
	bl wcscpy
	b _021050D8
_021050B0:
	cmp r6, #0x41
	sub r4, r8, #8
	bne _021050CC
	ldr r1, _021052D4 // =0x021326AC
	mov r0, r4
	bl wcscpy
	b _021050D8
_021050CC:
	ldr r1, _021052D8 // =0x021326B4
	mov r0, r4
	bl wcscpy
_021050D8:
	add sp, sp, #0x44
	mov r0, r4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
_021050EC:
	mov r3, r10
	mov r1, #1
	mov r0, #0x64
	add r9, sp, #0x68
	strb r1, [sp, #0x34]
	strb r1, [sp, #0x35]
	strb r3, [sp, #0x36]
	strb r3, [sp, #0x37]
	strb r3, [sp, #0x38]
	str r3, [sp, #0x3c]
	str r1, [sp, #0x40]
	strh r0, [sp, #0x3a]
_0210511C:
	rsb r1, r3, #7
	ldrsb r2, [r9, r3]
	ldrsb r0, [r9, r1]
	strb r0, [r9, r3]
	add r3, r3, #1
	strb r2, [r9, r1]
	cmp r3, #4
	blt _0210511C
	ldrb r0, [sp, #0x69]
	ldrb r1, [sp, #0x68]
	ldr r9, _021052DC // =0x000007FF
	mov r0, r0, lsl #0x11
	orr r1, r0, r1, lsl #25
	add r0, sp, #0x34
	and lr, r9, r1, lsr #21
	sub ip, sp, #8
	ldmia r0, {r0, r1, r2, r3}
	stmia ip, {r0, r1, r2, r3}
	rsb r0, r9, #0x400
	mov r1, r8
	add r0, lr, r0
	ldmia ip, {r2, r3}
	bl long2str__wprintf
	cmp r6, #0x61
	moveq r1, #0x70
	movne r1, #0x50
	strh r1, [r0, #-2]!
	mov r1, r7, lsl #2
	mov lr, r7
	cmp r7, #1
	add r8, r1, #0xb
	add ip, sp, #0x68
	blt _0210522C
	mov r9, #0x30
_021051A4:
	cmp r8, #0x40
	bge _02105214
	ldrb r1, [ip, r8, asr #3]
	and r2, r8, #7
	rsb r3, r2, #7
	mov r2, r1, asr r3
	sub r10, r8, #4
	bic r1, r8, #7
	bic r10, r10, #7
	cmp r1, r10
	add r10, ip, r8, asr #3
	and r1, r2, #0xff
	beq _021051E8
	ldrb r2, [r10, #-1]
	mov r2, r2, lsl #8
	orr r1, r1, r2, asr r3
	and r1, r1, #0xff
_021051E8:
	and r1, r1, #0xf
	cmp r1, #0xa
	addlo r1, r1, #0x30
	andlo r1, r1, #0xff
	blo _02105218
	cmp r6, #0x61
	addeq r1, r1, #0x57
	andeq r1, r1, #0xff
	addne r1, r1, #0x37
	andne r1, r1, #0xff
	b _02105218
_02105214:
	mov r1, r9
_02105218:
	sub lr, lr, #1
	cmp lr, #1
	strh r1, [r0, #-2]!
	sub r8, r8, #4
	bge _021051A4
_0210522C:
	cmp r7, #0
	cmpeq r5, #0
	movne r1, #0x2e
	strneh r1, [r0, #-2]!
	mov r1, #0x31
	strh r1, [r0, #-2]
	cmp r6, #0x61
	moveq r1, #0x78
	movne r1, #0x58
	strh r1, [r0, #-4]!
	mov r1, #0x30
	strh r1, [r0, #-2]!
	ldrsb r1, [sp, #0xc]
	cmp r1, #0
	movne r1, #0x2d
	strneh r1, [r0, #-2]!
	addne sp, sp, #0x44
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	addne sp, sp, #0x10
	bxne lr
	cmp r4, #1
	moveq r1, #0x2b
	streqh r1, [r0, #-2]!
	addeq sp, sp, #0x44
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	addeq sp, sp, #0x10
	bxeq lr
	cmp r4, #2
	moveq r1, #0x20
	streqh r1, [r0, #-2]!
	add sp, sp, #0x44
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_021052B4: .word 0x000001FD
_021052B8: .word 0x02132660
_021052BC: .word 0x0213266C
_021052C0: .word 0x02132678
_021052C4: .word 0x02132684
_021052C8: .word 0x0213268C
_021052CC: .word 0x02132694
_021052D0: .word 0x021326A0
_021052D4: .word 0x021326AC
_021052D8: .word 0x021326B4
_021052DC: .word 0x000007FF
	arm_func_end double2hex__wprintf

	arm_func_start round_decimal
round_decimal: // 0x021052E0
	stmdb sp!, {r4, lr}
	cmp r1, #0
	bge _02105308
_021052EC:
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #1
	strb r1, [r0, #4]
	mov r1, #0x30
	strb r1, [r0, #5]
	ldmia sp!, {r4, pc}
_02105308:
	ldrb lr, [r0, #4]
	cmp r1, lr
	ldmgeia sp!, {r4, pc}
	add ip, r0, #5
	add r2, ip, r1
	add r2, r2, #1
	ldrsb r3, [r2, #-1]!
	sub r3, r3, #0x30
	mov r3, r3, lsl #0x18
	mov r3, r3, asr #0x18
	cmp r3, #5
	bne _02105368
	add ip, ip, lr
_0210533C:
	sub ip, ip, #1
	cmp ip, r2
	bls _02105354
	ldrsb r3, [ip]
	cmp r3, #0x30
	beq _0210533C
_02105354:
	cmp ip, r2
	ldreqsb r3, [r2, #-1]
	andeq r4, r3, #1
	movne r4, #1
	b _02105370
_02105368:
	movgt r4, #1
	movle r4, #0
_02105370:
	cmp r1, #0
	beq _021053CC
	mov ip, #0
	mov lr, #1
_02105380:
	ldrsb r3, [r2, #-1]!
	sub r3, r3, #0x30
	add r3, r3, r4
	mov r3, r3, lsl #0x18
	mov r3, r3, asr #0x18
	cmp r3, #9
	movgt r4, lr
	movle r4, ip
	cmp r4, #0
	bne _021053B0
	cmp r3, #0
	bne _021053B8
_021053B0:
	sub r1, r1, #1
	b _021053C4
_021053B8:
	add r3, r3, #0x30
	strb r3, [r2]
	b _021053CC
_021053C4:
	cmp r1, #0
	bne _02105380
_021053CC:
	cmp r4, #0
	beq _021053F4
	ldrsh r3, [r0, #2]
	mov r2, #1
	mov r1, #0x31
	add r3, r3, #1
	strh r3, [r0, #2]
	strb r2, [r0, #4]
	strb r1, [r0, #5]
	ldmia sp!, {r4, pc}
_021053F4:
	cmp r1, #0
	beq _021052EC
	strb r1, [r0, #4]
	ldmia sp!, {r4, pc}
	arm_func_end round_decimal

	arm_func_start float2str__wprintf
float2str__wprintf: // 0x02105404
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x22c
	mov r10, r0
	add r0, sp, #0x250
	ldr r7, [sp, #0x268]
	ldr r3, _02105A24 // =0x000001FD
	ldrh r6, [r0, #0x12]
	cmp r7, r3
	ldrb r5, [sp, #0x25f]
	ldrb r4, [sp, #0x25d]
	mov r8, r1
	mov r9, r2
	addgt sp, sp, #0x22c
	movgt r0, #0
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addgt sp, sp, #0x10
	bxgt lr
	mov ip, #0
	mov r11, #0x20
	add r0, sp, #0
	add r3, sp, #4
	mov r1, r10
	mov r2, r8
	strb ip, [sp]
	strh r11, [sp, #2]
	bl __num2dec
	ldrb r0, [sp, #8]
	add r1, sp, #9
	add r0, r1, r0
	b _02105498
_02105480:
	ldrb r2, [sp, #8]
	ldrsh r1, [sp, #6]
	sub r2, r2, #1
	add r1, r1, #1
	strb r2, [sp, #8]
	strh r1, [sp, #6]
_02105498:
	ldrb r1, [sp, #8]
	cmp r1, #1
	bls _021054B0
	ldrsb r1, [r0, #-1]!
	cmp r1, #0x30
	beq _02105480
_021054B0:
	ldrb r0, [sp, #9]
	cmp r0, #0x30
	beq _021054D0
	cmp r0, #0x49
	beq _021054DC
	cmp r0, #0x4e
	beq _02105594
	b _02105640
_021054D0:
	mov r0, #0
	strh r0, [sp, #6]
	b _02105640
_021054DC:
	mov r2, #0
	mov r0, r10
	mov r1, r8
	mov r3, r2
	bl _dleq
	bhs _0210553C
	cmp r6, #0x80
	sub r4, r9, #0xa
	movhs r0, #0
	bhs _02105514
	ldr r0, _02105A28 // =0x02117384
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	and r0, r0, #0x200
_02105514:
	cmp r0, #0
	beq _0210552C
	ldr r1, _02105A2C // =0x0213266C
	mov r0, r4
	bl wcscpy
	b _02105580
_0210552C:
	ldr r1, _02105A30 // =0x02132678
	mov r0, r4
	bl wcscpy
	b _02105580
_0210553C:
	cmp r6, #0x80
	sub r4, r9, #8
	movhs r0, #0
	bhs _0210555C
	ldr r0, _02105A28 // =0x02117384
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	and r0, r0, #0x200
_0210555C:
	cmp r0, #0
	beq _02105574
	ldr r1, _02105A34 // =0x02132684
	mov r0, r4
	bl wcscpy
	b _02105580
_02105574:
	ldr r1, _02105A38 // =0x0213268C
	mov r0, r4
	bl wcscpy
_02105580:
	add sp, sp, #0x22c
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02105594:
	ldrsb r0, [sp, #4]
	cmp r0, #0
	beq _021055E8
	cmp r6, #0x80
	sub r4, r9, #0xa
	movhs r0, #0
	bhs _021055C0
	ldr r0, _02105A28 // =0x02117384
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	and r0, r0, #0x200
_021055C0:
	cmp r0, #0
	beq _021055D8
	ldr r1, _02105A3C // =0x02132694
	mov r0, r4
	bl wcscpy
	b _0210562C
_021055D8:
	ldr r1, _02105A40 // =0x021326A0
	mov r0, r4
	bl wcscpy
	b _0210562C
_021055E8:
	cmp r6, #0x80
	sub r4, r9, #8
	movhs r0, #0
	bhs _02105608
	ldr r0, _02105A28 // =0x02117384
	mov r1, r6, lsl #1
	ldrh r0, [r0, r1]
	and r0, r0, #0x200
_02105608:
	cmp r0, #0
	beq _02105620
	ldr r1, _02105A44 // =0x021326AC
	mov r0, r4
	bl wcscpy
	b _0210562C
_02105620:
	ldr r1, _02105A48 // =0x021326B4
	mov r0, r4
	bl wcscpy
_0210562C:
	add sp, sp, #0x22c
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02105640:
	ldrb r1, [sp, #8]
	ldrsh r2, [sp, #6]
	add r0, sp, #0x200
	sub r1, r1, #1
	add r0, r0, #0x2a
	add r1, r2, r1
	sub r8, r0, #1
	strh r1, [sp, #6]
	mov r0, #0
	strb r0, [r8]
	cmp r6, #0x65
	bgt _0210569C
	bge _02105728
	cmp r6, #0x47
	bgt _021059E8
	cmp r6, #0x45
	blt _021059E8
	beq _02105728
	cmp r6, #0x46
	beq _02105874
	cmp r6, #0x47
	beq _021056B4
	b _021059E8
_0210569C:
	cmp r6, #0x66
	bgt _021056AC
	beq _02105874
	b _021059E8
_021056AC:
	cmp r6, #0x67
	bne _021059E8
_021056B4:
	ldrb r0, [sp, #8]
	cmp r0, r7
	ble _021056CC
	add r0, sp, #4
	mov r1, r7
	bl round_decimal
_021056CC:
	ldrsh r2, [sp, #6]
	mvn r0, #3
	cmp r2, r0
	blt _021056E4
	cmp r2, r7
	blt _02105704
_021056E4:
	cmp r5, #0
	ldreqb r0, [sp, #8]
	subne r7, r7, #1
	subeq r7, r0, #1
	cmp r6, #0x67
	moveq r6, #0x65
	movne r6, #0x45
	b _02105728
_02105704:
	cmp r5, #0
	addne r0, r2, #1
	subne r7, r7, r0
	bne _02105874
	ldrb r1, [sp, #8]
	add r0, r2, #1
	subs r7, r1, r0
	movmi r7, #0
	b _02105874
_02105728:
	ldrb r0, [sp, #8]
	add r1, r7, #1
	cmp r0, r1
	ble _02105740
	add r0, sp, #4
	bl round_decimal
_02105740:
	ldrsh lr, [sp, #6]
	mov r11, #0x2b
	mov r10, #0
	cmp lr, #0
	rsblt lr, lr, #0
	movlt r11, #0x2d
	ldr r3, _02105A4C // =0x66666667
	mov r0, #0xa
	b _02105794
_02105764:
	mov r1, lr, lsr #0x1f
	smull r2, ip, r3, lr
	add ip, r1, ip, asr #2
	smull r1, r2, r0, ip
	sub ip, lr, r1
	add r1, ip, #0x30
	strb r1, [r8, #-1]!
	mov r2, lr
	smull r1, lr, r3, r2
	mov r1, r2, lsr #0x1f
	add lr, r1, lr, asr #2
	add r10, r10, #1
_02105794:
	cmp lr, #0
	bne _02105764
	cmp r10, #2
	blt _02105764
	add r0, sp, #0x2a
	strb r11, [r8, #-1]
	strb r6, [r8, #-2]!
	sub r1, r0, r8
	ldr r0, _02105A24 // =0x000001FD
	add r1, r1, r7
	cmp r1, r0
	addgt sp, sp, #0x22c
	movgt r0, #0
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addgt sp, sp, #0x10
	bxgt lr
	ldrb r1, [sp, #8]
	add r0, r7, #1
	cmp r1, r0
	bge _02105804
	add r0, r7, #2
	sub r0, r0, r1
	subs r1, r0, #1
	beq _02105804
	mov r0, #0x30
_021057F8:
	strb r0, [r8, #-1]!
	subs r1, r1, #1
	bne _021057F8
_02105804:
	ldrb r1, [sp, #8]
	add r0, sp, #9
	add r2, r0, r1
	subs r1, r1, #1
	beq _02105828
_02105818:
	ldrsb r0, [r2, #-1]!
	subs r1, r1, #1
	strb r0, [r8, #-1]!
	bne _02105818
_02105828:
	cmp r7, #0
	cmpeq r5, #0
	movne r0, #0x2e
	strneb r0, [r8, #-1]!
	ldrb r0, [sp, #9]
	strb r0, [r8, #-1]!
	ldrsb r0, [sp, #4]
	cmp r0, #0
	movne r0, #0x2d
	strneb r0, [r8, #-1]!
	bne _021059E8
	cmp r4, #1
	moveq r0, #0x2b
	streqb r0, [r8, #-1]!
	beq _021059E8
	cmp r4, #2
	moveq r0, #0x20
	streqb r0, [r8, #-1]!
	b _021059E8
_02105874:
	ldrsh r3, [sp, #6]
	ldrb r2, [sp, #8]
	sub r0, r2, r3
	subs r1, r0, #1
	movmi r1, #0
	cmp r1, r7
	ble _021058B4
	sub r1, r1, r7
	add r0, sp, #4
	sub r1, r2, r1
	bl round_decimal
	ldrsh r3, [sp, #6]
	ldrb r2, [sp, #8]
	sub r0, r2, r3
	subs r1, r0, #1
	movmi r1, #0
_021058B4:
	adds r0, r3, #1
	movmi r0, #0
	ldr r3, _02105A24 // =0x000001FD
	add r6, r0, r1
	cmp r6, r3
	addgt sp, sp, #0x22c
	movgt r0, #0
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addgt sp, sp, #0x10
	bxgt lr
	add r3, sp, #9
	sub r6, r7, r1
	cmp r6, #0
	add r2, r3, r2
	mov r10, #0
	ble _02105908
	mov r3, #0x30
_021058F8:
	add r10, r10, #1
	cmp r10, r6
	strb r3, [r8, #-1]!
	blt _021058F8
_02105908:
	mov r6, #0
	b _0210591C
_02105910:
	ldrsb r3, [r2, #-1]!
	add r6, r6, #1
	strb r3, [r8, #-1]!
_0210591C:
	cmp r6, r1
	ldrltb r3, [sp, #8]
	cmplt r6, r3
	blt _02105910
	cmp r6, r1
	bge _02105948
	mov r3, #0x30
_02105938:
	add r6, r6, #1
	cmp r6, r1
	strb r3, [r8, #-1]!
	blt _02105938
_02105948:
	cmp r7, #0
	cmpeq r5, #0
	movne r1, #0x2e
	strneb r1, [r8, #-1]!
	cmp r0, #0
	beq _021059B0
	ldrb r1, [sp, #8]
	mov r5, #0
	sub r1, r0, r1
	cmp r1, #0
	ble _02105990
	mov r3, #0x30
_02105978:
	strb r3, [r8, #-1]!
	ldrb r1, [sp, #8]
	add r5, r5, #1
	sub r1, r0, r1
	cmp r5, r1
	blt _02105978
_02105990:
	cmp r5, r0
	bge _021059B8
_02105998:
	ldrsb r1, [r2, #-1]!
	add r5, r5, #1
	cmp r5, r0
	strb r1, [r8, #-1]!
	blt _02105998
	b _021059B8
_021059B0:
	mov r0, #0x30
	strb r0, [r8, #-1]!
_021059B8:
	ldrsb r0, [sp, #4]
	cmp r0, #0
	movne r0, #0x2d
	strneb r0, [r8, #-1]!
	bne _021059E8
	cmp r4, #1
	moveq r0, #0x2b
	streqb r0, [r8, #-1]!
	beq _021059E8
	cmp r4, #2
	moveq r0, #0x20
	streqb r0, [r8, #-1]!
_021059E8:
	mov r0, r8
	bl strlen
	sub r1, r9, r0, lsl #1
	mov r0, r8
	sub r4, r1, #2
	bl strlen
	mov r2, r0
	mov r0, r4
	mov r1, r8
	bl mbstowcs
	mov r0, r4
	add sp, sp, #0x22c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02105A24: .word 0x000001FD
_02105A28: .word 0x02117384
_02105A2C: .word 0x0213266C
_02105A30: .word 0x02132678
_02105A34: .word 0x02132684
_02105A38: .word 0x0213268C
_02105A3C: .word 0x02132694
_02105A40: .word 0x021326A0
_02105A44: .word 0x021326AC
_02105A48: .word 0x021326B4
_02105A4C: .word 0x66666667
	arm_func_end float2str__wprintf

	arm_func_start __wpformatter
__wpformatter: // 0x02105A50
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x430
	mov r3, #0x20
	mov r11, r2
	strh r3, [sp, #0x1c]
	ldrh r2, [r11, #0]
	mov r9, r0
	mov r8, r1
	cmp r2, #0
	mov r4, #0
	beq _02106320
_02105A80:
	mov r0, r11
	mov r1, #0x25
	bl wcschr
	str r0, [sp, #0xc]
	cmp r0, #0
	bne _02105AD4
	mov r0, r11
	bl wcslen
	movs r2, r0
	add r4, r4, r2
	beq _02106320
	mov r0, r8
	mov r1, r11
	blx r9
	cmp r0, #0
	bne _02106320
	add sp, sp, #0x430
	mvn r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02105AD4:
	sub r0, r0, r11
	add r0, r0, r0, lsr #31
	movs r2, r0, asr #1
	add r4, r4, r2
	beq _02105B0C
	mov r0, r8
	mov r1, r11
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x430
	mvneq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
_02105B0C:
	add r1, sp, #0x400
	ldr r0, [sp, #0xc]
	add r1, r1, #0x64
	add r2, sp, #0x20
	bl parse_format
	ldrh r1, [sp, #0x26]
	mov r11, r0
	cmp r1, #0x61
	bgt _02105B7C
	bge _02105EE8
	cmp r1, #0x47
	bgt _02105B70
	subs r0, r1, #0x41
	addpl pc, pc, r0, lsl #2
	b _02105B64
_02105B48: // jump table
	b _02105EE8 // case 0
	b _0210618C // case 1
	b _0210618C // case 2
	b _0210618C // case 3
	b _02105E78 // case 4
	b _02105E78 // case 5
	b _02105E78 // case 6
_02105B64:
	cmp r1, #0x25
	beq _02106178
	b _0210618C
_02105B70:
	cmp r1, #0x58
	beq _02105D3C
	b _0210618C
_02105B7C:
	cmp r1, #0x75
	bgt _02105BE4
	subs r0, r1, #0x64
	addpl pc, pc, r0, lsl #2
	b _02105BD8
_02105B90: // jump table
	b _02105C00 // case 0
	b _02105E78 // case 1
	b _02105E78 // case 2
	b _02105E78 // case 3
	b _0210618C // case 4
	b _02105C00 // case 5
	b _0210618C // case 6
	b _0210618C // case 7
	b _0210618C // case 8
	b _0210618C // case 9
	b _02106094 // case 10
	b _02105D3C // case 11
	b _0210618C // case 12
	b _0210618C // case 13
	b _0210618C // case 14
	b _02105F58 // case 15
	b _0210618C // case 16
	b _02105D3C // case 17
_02105BD8:
	cmp r1, #0x63
	beq _02106120
	b _0210618C
_02105BE4:
	cmp r1, #0x78
	bgt _02105BF4
	beq _02105D3C
	b _0210618C
_02105BF4:
	ldr r0, _02106334 // =0x0000FFFF
	cmp r1, r0
	b _0210618C
_02105C00:
	ldrb r0, [sp, #0x24]
	cmp r0, #3
	bne _02105C20
	ldr r1, [sp, #0x464]
	add r1, r1, #4
	str r1, [sp, #0x464]
	ldr r10, [r1, #-4]
	b _02105CB8
_02105C20:
	cmp r0, #4
	bne _02105C48
	ldr r1, [sp, #0x464]
	add r2, r1, #8
	str r2, [sp, #0x464]
	ldr r1, [r2, #-8]
	str r1, [sp, #0x10]
	ldr r1, [r2, #-4]
	str r1, [sp, #0x14]
	b _02105CB8
_02105C48:
	cmp r0, #6
	bne _02105C70
	ldr r1, [sp, #0x464]
	add r2, r1, #8
	str r2, [sp, #0x464]
	ldr r1, [r2, #-8]
	str r1, [sp, #0x10]
	ldr r1, [r2, #-4]
	str r1, [sp, #0x14]
	b _02105CB8
_02105C70:
	cmp r0, #7
	bne _02105C8C
	ldr r1, [sp, #0x464]
	add r1, r1, #4
	str r1, [sp, #0x464]
	ldr r10, [r1, #-4]
	b _02105CB8
_02105C8C:
	cmp r0, #8
	bne _02105CA8
	ldr r1, [sp, #0x464]
	add r1, r1, #4
	str r1, [sp, #0x464]
	ldr r10, [r1, #-4]
	b _02105CB8
_02105CA8:
	ldr r1, [sp, #0x464]
	add r1, r1, #4
	str r1, [sp, #0x464]
	ldr r10, [r1, #-4]
_02105CB8:
	cmp r0, #2
	moveq r1, r10, lsl #0x10
	moveq r10, r1, asr #0x10
	cmp r0, #4
	cmpne r0, #6
	add r0, sp, #0x20
	bne _02105D00
	sub r5, sp, #4
	ldmia r0, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	ldr r3, [r5, #0]
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	add r2, sp, #0x430
	bl longlong2str__wprintf
	movs r6, r0
	beq _0210618C
	b _02105D24
_02105D00:
	sub r5, sp, #8
	ldmia r0, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	add r1, sp, #0x430
	mov r0, r10
	ldmia r5, {r2, r3}
	bl long2str__wprintf
	movs r6, r0
	beq _0210618C
_02105D24:
	add r0, sp, #0x400
	add r0, r0, #0x2e
	sub r0, r0, r6
	add r0, r0, r0, lsr #31
	mov r7, r0, asr #1
	b _021061D8
_02105D3C:
	ldrb r0, [sp, #0x24]
	cmp r0, #3
	bne _02105D5C
	ldr r1, [sp, #0x464]
	add r1, r1, #4
	str r1, [sp, #0x464]
	ldr r10, [r1, #-4]
	b _02105DF4
_02105D5C:
	cmp r0, #4
	bne _02105D84
	ldr r1, [sp, #0x464]
	add r2, r1, #8
	str r2, [sp, #0x464]
	ldr r1, [r2, #-8]
	str r1, [sp, #0x10]
	ldr r1, [r2, #-4]
	str r1, [sp, #0x14]
	b _02105DF4
_02105D84:
	cmp r0, #6
	bne _02105DAC
	ldr r1, [sp, #0x464]
	add r2, r1, #8
	str r2, [sp, #0x464]
	ldr r1, [r2, #-8]
	str r1, [sp, #0x10]
	ldr r1, [r2, #-4]
	str r1, [sp, #0x14]
	b _02105DF4
_02105DAC:
	cmp r0, #7
	bne _02105DC8
	ldr r1, [sp, #0x464]
	add r1, r1, #4
	str r1, [sp, #0x464]
	ldr r10, [r1, #-4]
	b _02105DF4
_02105DC8:
	cmp r0, #8
	bne _02105DE4
	ldr r1, [sp, #0x464]
	add r1, r1, #4
	str r1, [sp, #0x464]
	ldr r10, [r1, #-4]
	b _02105DF4
_02105DE4:
	ldr r1, [sp, #0x464]
	add r1, r1, #4
	str r1, [sp, #0x464]
	ldr r10, [r1, #-4]
_02105DF4:
	cmp r0, #2
	moveq r1, r10, lsl #0x10
	moveq r10, r1, lsr #0x10
	cmp r0, #4
	cmpne r0, #6
	add r0, sp, #0x20
	bne _02105E3C
	sub r5, sp, #4
	ldmia r0, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	ldr r3, [r5, #0]
	ldr r0, [sp, #0x10]
	ldr r1, [sp, #0x14]
	add r2, sp, #0x430
	bl longlong2str__wprintf
	movs r6, r0
	beq _0210618C
	b _02105E60
_02105E3C:
	sub r5, sp, #8
	ldmia r0, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	add r1, sp, #0x430
	mov r0, r10
	ldmia r5, {r2, r3}
	bl long2str__wprintf
	movs r6, r0
	beq _0210618C
_02105E60:
	add r0, sp, #0x400
	add r0, r0, #0x2e
	sub r0, r0, r6
	add r0, r0, r0, lsr #31
	mov r7, r0, asr #1
	b _021061D8
_02105E78:
	ldrb r0, [sp, #0x24]
	cmp r0, #9
	ldrne r0, [sp, #0x464]
	addne r0, r0, #8
	strne r0, [sp, #0x464]
	bne _02105E9C
	ldr r0, [sp, #0x464]
	add r0, r0, #8
	str r0, [sp, #0x464]
_02105E9C:
	ldr r7, [r0, #-8]
	ldr r6, [r0, #-4]
	add r0, sp, #0x20
	sub r5, sp, #4
	ldmia r0, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	ldr r3, [r5, #0]
	mov r0, r7
	mov r1, r6
	add r2, sp, #0x430
	bl float2str__wprintf
	movs r6, r0
	beq _0210618C
	add r0, sp, #0x400
	add r0, r0, #0x2e
	sub r0, r0, r6
	add r0, r0, r0, lsr #31
	mov r7, r0, asr #1
	b _021061D8
_02105EE8:
	ldrb r0, [sp, #0x24]
	cmp r0, #9
	ldrne r0, [sp, #0x464]
	addne r0, r0, #8
	strne r0, [sp, #0x464]
	bne _02105F0C
	ldr r0, [sp, #0x464]
	add r0, r0, #8
	str r0, [sp, #0x464]
_02105F0C:
	ldr r7, [r0, #-8]
	ldr r6, [r0, #-4]
	add r0, sp, #0x20
	sub r5, sp, #4
	ldmia r0, {r0, r1, r2, r3}
	stmia r5, {r0, r1, r2, r3}
	ldr r3, [r5, #0]
	mov r0, r7
	mov r1, r6
	add r2, sp, #0x430
	bl double2hex__wprintf
	movs r6, r0
	beq _0210618C
	add r0, sp, #0x400
	add r0, r0, #0x2e
	sub r0, r0, r6
	add r0, r0, r0, lsr #31
	mov r7, r0, asr #1
	b _021061D8
_02105F58:
	ldrb r0, [sp, #0x24]
	cmp r0, #5
	bne _02105FF4
	ldr r0, [sp, #0x464]
	add r0, r0, #4
	str r0, [sp, #0x464]
	ldr r6, [r0, #-4]
	ldrb r0, [sp, #0x23]
	cmp r6, #0
	ldreq r6, _02106338 // =0x021326BC
	cmp r0, #0
	beq _02105FAC
	ldrh r1, [r6], #2
	ldrb r0, [sp, #0x22]
	and r7, r1, #0xff
	cmp r0, #0
	beq _021061D8
	ldr r0, [sp, #0x2c]
	cmp r7, r0
	movgt r7, r0
	b _021061D8
_02105FAC:
	ldrb r0, [sp, #0x22]
	cmp r0, #0
	beq _02105FE4
	ldr r7, [sp, #0x2c]
	mov r0, r6
	mov r2, r7
	mov r1, #0
	bl sub_2104474
	cmp r0, #0
	beq _021061D8
	sub r0, r0, r6
	add r0, r0, r0, lsr #31
	mov r7, r0, asr #1
	b _021061D8
_02105FE4:
	mov r0, r6
	bl wcslen
	mov r7, r0
	b _021061D8
_02105FF4:
	ldr r0, [sp, #0x464]
	add r0, r0, #4
	str r0, [sp, #0x464]
	ldr r5, [r0, #-4]
	ldrb r0, [sp, #0x23]
	cmp r5, #0
	ldreq r5, _0210633C // =0x021326C0
	cmp r0, #0
	beq _0210603C
	ldrh r1, [r6, #0]
	ldrb r0, [sp, #0x22]
	and r6, r1, #0xff
	cmp r0, #0
	beq _02106074
	ldr r0, [sp, #0x2c]
	cmp r6, r0
	movgt r6, r0
	b _02106074
_0210603C:
	ldrb r0, [sp, #0x22]
	cmp r0, #0
	beq _02106068
	ldr r6, [sp, #0x2c]
	mov r0, r5
	mov r2, r6
	mov r1, #0
	bl memchr
	cmp r0, #0
	subne r6, r0, r5
	b _02106074
_02106068:
	mov r0, r5
	bl strlen
	mov r6, r0
_02106074:
	add r0, sp, #0x30
	mov r1, r5
	mov r2, r6
	bl mbstowcs
	movs r7, r0
	bmi _0210618C
	add r6, sp, #0x30
	b _021061D8
_02106094:
	ldr r1, [sp, #0x464]
	ldrb r0, [sp, #0x24]
	add r1, r1, #4
	str r1, [sp, #0x464]
	ldr r6, [r1, #-4]
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _02106314
_021060B4: // jump table
	b _021060D8 // case 0
	b _02106314 // case 1
	b _021060E0 // case 2
	b _021060E8 // case 3
	b _02106110 // case 4
	b _02106314 // case 5
	b _021060F0 // case 6
	b _02106100 // case 7
	b _02106108 // case 8
_021060D8:
	str r4, [r6]
	b _02106314
_021060E0:
	strh r4, [r6]
	b _02106314
_021060E8:
	str r4, [r6]
	b _02106314
_021060F0:
	str r4, [r6]
	mov r0, r4, asr #0x1f
	str r0, [r6, #4]
	b _02106314
_02106100:
	str r4, [r6]
	b _02106314
_02106108:
	str r4, [r6]
	b _02106314
_02106110:
	str r4, [r6]
	mov r0, r4, asr #0x1f
	str r0, [r6, #4]
	b _02106314
_02106120:
	ldrb r0, [sp, #0x24]
	add r6, sp, #0x30
	cmp r0, #5
	bne _0210614C
	ldr r0, [sp, #0x464]
	mov r7, #1
	add r0, r0, #4
	str r0, [sp, #0x464]
	ldr r0, [r0, #-4]
	strh r0, [r6]
	b _021061D8
_0210614C:
	ldr r0, [sp, #0x464]
	add r1, sp, #0x18
	add r0, r0, #4
	str r0, [sp, #0x464]
	ldr r3, [r0, #-4]
	mov r0, r6
	mov r2, #1
	strb r3, [sp, #0x18]
	bl mbtowc
	mov r7, r0
	b _021061D8
_02106178:
	mov r0, #0x25
	strh r0, [sp, #0x30]
	add r6, sp, #0x30
	mov r7, #1
	b _021061D8
_0210618C:
	ldr r0, [sp, #0xc]
	bl wcslen
	movs r5, r0
	beq _021061C4
	ldr r1, [sp, #0xc]
	mov r0, r8
	mov r2, r5
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x430
	mvneq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
_021061C4:
	add sp, sp, #0x430
	add r0, r4, r5
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_021061D8:
	ldrb r0, [sp, #0x20]
	mov r5, r7
	cmp r0, #0
	beq _02106288
	cmp r0, #2
	moveq r1, #0x30
	movne r1, #0x20
	strh r1, [sp, #0x1c]
	ldrh r0, [r6, #0]
	cmp r0, #0x2b
	cmpne r0, #0x2d
	cmpne r0, #0x20
	bne _02106244
	cmp r1, #0x30
	bne _02106244
	mov r0, r8
	mov r1, r6
	mov r2, #1
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x430
	mvneq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
	add r6, r6, #2
	sub r7, r7, #1
_02106244:
	ldr r0, [sp, #0x28]
	cmp r5, r0
	bge _02106288
_02106250:
	mov r0, r8
	add r1, sp, #0x1c
	mov r2, #1
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x430
	mvneq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldr r0, [sp, #0x28]
	add r5, r5, #1
	cmp r5, r0
	blt _02106250
_02106288:
	cmp r7, #0
	beq _021062B8
	mov r0, r8
	mov r1, r6
	mov r2, r7
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x430
	mvneq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
_021062B8:
	ldrb r0, [sp, #0x20]
	cmp r0, #0
	bne _02106310
	ldr r0, [sp, #0x28]
	cmp r5, r0
	bge _02106310
	mov r7, #0x20
_021062D4:
	mov r0, r8
	add r1, sp, #0x1a
	mov r2, #1
	strh r7, [sp, #0x1a]
	blx r9
	cmp r0, #0
	addeq sp, sp, #0x430
	mvneq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldr r0, [sp, #0x28]
	add r5, r5, #1
	cmp r5, r0
	blt _021062D4
_02106310:
	add r4, r4, r5
_02106314:
	ldrh r0, [r11, #0]
	cmp r0, #0
	bne _02105A80
_02106320:
	mov r0, r4
	add sp, sp, #0x430
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02106334: .word 0x0000FFFF
_02106338: .word 0x021326BC
_0210633C: .word 0x021326C0
	arm_func_end __wpformatter

	arm_func_start __wStringWrite
__wStringWrite: // 0x02106340
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldr r3, [r4, #8]
	mov r5, r2
	ldr r2, [r4, #4]
	add r0, r3, r5
	cmp r0, r2
	ldr r0, [r4, #0]
	subhi r5, r2, r3
	mov r2, r5
	add r0, r0, r3, lsl #1
	bl wmemcpy
	ldr r1, [r4, #8]
	add r1, r1, r5
	str r1, [r4, #8]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end __wStringWrite

	arm_func_start swprintf
swprintf: // 0x02106380
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, lr}
	add r3, sp, #0x10
	bic r3, r3, #3
	ldr r2, [sp, #0x10]
	add r3, r3, #4
	bl vswprintf
	ldmia sp!, {r3, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end swprintf

	arm_func_start vswprintf
vswprintf: // 0x021063A8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r4, r1
	mov ip, #0
	ldr r0, _02106414 // =__wStringWrite
	add r1, sp, #0
	str r5, [sp]
	str r4, [sp, #4]
	str ip, [sp, #8]
	bl __wpformatter
	cmp r0, #0
	addlt sp, sp, #0xc
	ldmltia sp!, {r4, r5, pc}
	cmp r0, r4
	bhs _021063FC
	mov r1, r0, lsl #1
	mov r2, #0
	add sp, sp, #0xc
	strh r2, [r5, r1]
	ldmia sp!, {r4, r5, pc}
_021063FC:
	mov r1, #0
	add r0, r5, r4, lsl #1
	strh r1, [r0, #-2]
	sub r0, r1, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02106414: .word __wStringWrite
	arm_func_end vswprintf

	arm_func_start wcslen
wcslen: // 0x02106418
	mvn r2, #0
_0210641C:
	ldrh r1, [r0], #2
	add r2, r2, #1
	cmp r1, #0
	bne _0210641C
	mov r0, r2
	bx lr
	arm_func_end wcslen

	arm_func_start wcscpy
wcscpy: // 0x02106434
	mov r3, r0
_02106438:
	ldrh r2, [r1], #2
	mov ip, r3
	strh r2, [r3], #2
	ldrh r2, [ip]
	cmp r2, #0
	bne _02106438
	bx lr
	arm_func_end wcscpy

	arm_func_start wcschr
wcschr: // 0x02106454
	ldrh r2, [r0], #2
	cmp r2, #0
	beq _02106478
_02106460:
	cmp r2, r1
	subeq r0, r0, #2
	bxeq lr
	ldrh r2, [r0], #2
	cmp r2, #0
	bne _02106460
_02106478:
	cmp r1, #0
	movne r0, #0
	subeq r0, r0, #2
	bx lr
	arm_func_end wcschr

	arm_func_start __ieee754_pow
__ieee754_pow: // 0x02106488
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x80
	ldr r8, [sp, #0xb4]
	ldr r6, [sp, #0xac]
	ldr r0, [sp, #0xb0]
	bic r9, r8, #0x80000000
	orrs r1, r9, r0
	ldr r7, [sp, #0xa8]
	bic r4, r6, #0x80000000
	addeq sp, sp, #0x80
	moveq r0, #0
	ldreq r1, _02106A34 // =0x3FF00000
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldr r1, _02106A38 // =0x7FF00000
	cmp r4, r1
	bgt _021064F8
	bne _021064E0
	cmp r7, #0
	bne _021064F8
_021064E0:
	ldr r1, _02106A38 // =0x7FF00000
	cmp r9, r1
	bgt _021064F8
	bne _0210651C
	cmp r0, #0
	beq _0210651C
_021064F8:
	ldr r0, [sp, #0xa8]
	ldr r1, [sp, #0xac]
	ldr r2, [sp, #0xb0]
	ldr r3, [sp, #0xb4]
	bl _dadd
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_0210651C:
	cmp r6, #0
	mov r5, #0
	bge _02106584
	ldr r1, _02106A3C // =0x43400000
	cmp r9, r1
	movge r5, #2
	bge _02106584
	sub r1, r1, #0x3500000
	cmp r9, r1
	blt _02106584
	ldr r1, _02106A40 // =0xFFFFFC01
	add r1, r1, r9, asr #20
	cmp r1, #0x14
	ble _0210656C
	rsb r2, r1, #0x34
	mov r1, r0, lsr r2
	cmp r0, r1, lsl r2
	andeq r1, r1, #1
	rsbeq r5, r1, #2
	b _02106584
_0210656C:
	cmp r0, #0
	rsbeq r2, r1, #0x14
	moveq r1, r9, asr r2
	cmpeq r9, r1, lsl r2
	andeq r1, r1, #1
	rsbeq r5, r1, #2
_02106584:
	cmp r0, #0
	bne _021066E0
	ldr r1, _02106A38 // =0x7FF00000
	cmp r9, r1
	bne _02106638
	add r0, r4, #0x100000
	add r0, r0, #0xc0000000
	orrs r0, r0, r7
	bne _021065CC
	ldr r0, [sp, #0xb0]
	ldr r1, [sp, #0xb4]
	mov r2, r0
	mov r3, r1
	bl _dsub
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_021065CC:
	sub r0, r1, #0x40000000
	cmp r4, r0
	blt _021065FC
	cmp r8, #0
	ldrge r0, [sp, #0xb0]
	ldrge r1, [sp, #0xb4]
	movlt r0, #0
	add sp, sp, #0x80
	movlt r1, r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_021065FC:
	cmp r8, #0
	mov r0, #0
	addge sp, sp, #0x80
	movge r1, r0
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addge sp, sp, #0x10
	bxge lr
	ldr r2, [sp, #0xb0]
	ldr r3, [sp, #0xb4]
	mov r1, r0
	bl _dsub
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02106638:
	sub r0, r1, #0x40000000
	cmp r9, r0
	bne _02106684
	cmp r8, #0
	ldrge r0, [sp, #0xa8]
	ldrge r1, [sp, #0xac]
	addge sp, sp, #0x80
	ldmgeia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addge sp, sp, #0x10
	bxge lr
	ldr r2, [sp, #0xa8]
	ldr r3, [sp, #0xac]
	sub r1, r1, #0x40000000
	mov r0, #0
	bl _ddiv
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02106684:
	cmp r8, #0x40000000
	bne _021066B0
	ldr r0, [sp, #0xa8]
	ldr r1, [sp, #0xac]
	mov r2, r0
	mov r3, r1
	bl _dmul
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_021066B0:
	ldr r0, _02106A44 // =0x3FE00000
	cmp r8, r0
	bne _021066E0
	cmp r6, #0
	blt _021066E0
	ldr r0, [sp, #0xa8]
	ldr r1, [sp, #0xac]
	bl _dsqrt
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_021066E0:
	ldr r0, [sp, #0xa8]
	ldr r1, [sp, #0xac]
	bl fabs
	str r0, [sp, #0x70]
	str r1, [sp, #0x74]
	cmp r7, #0
	bne _021067E4
	ldr r0, _02106A38 // =0x7FF00000
	cmp r4, r0
	cmpne r4, #0
	subne r0, r0, #0x40000000
	cmpne r4, r0
	bne _021067E4
	ldr r2, [sp, #0x70]
	ldr r3, [sp, #0x74]
	str r2, [sp, #0x78]
	str r3, [sp, #0x7c]
	cmp r8, #0
	bge _02106740
	ldr r1, _02106A34 // =0x3FF00000
	mov r0, #0
	bl _ddiv
	str r0, [sp, #0x78]
	str r1, [sp, #0x7c]
_02106740:
	cmp r6, #0
	bge _021067CC
	add r0, r4, #0x100000
	add r0, r0, #0xc0000000
	orrs r0, r0, r5
	bne _021067A8
	ldr r0, [sp, #0x78]
	ldr r1, [sp, #0x7c]
	mov r2, r0
	mov r3, r1
	bl _dsub
	mov r4, r0
	mov r5, r1
	ldr r0, [sp, #0x78]
	ldr r1, [sp, #0x7c]
	mov r2, r0
	mov r3, r1
	bl _dsub
	mov r2, r0
	mov r3, r1
	mov r0, r4
	mov r1, r5
	bl _ddiv
	str r0, [sp, #0x78]
	str r1, [sp, #0x7c]
	b _021067CC
_021067A8:
	cmp r5, #1
	bne _021067CC
	mov r0, #0
	ldr r2, [sp, #0x78]
	ldr r3, [sp, #0x7c]
	mov r1, r0
	bl _dsub
	str r0, [sp, #0x78]
	str r1, [sp, #0x7c]
_021067CC:
	ldr r0, [sp, #0x78]
	ldr r1, [sp, #0x7c]
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_021067E4:
	mov r0, r6, asr #0x1f
	add r7, r0, #1
	orrs r0, r7, r5
	bne _0210681C
	ldr r0, _02106A48 // =0x021323F4
	ldr r1, _02106A4C // =errno
	ldr r0, [r0, #0]
	mov r2, #0x21
	str r2, [r1]
	bl _f2d
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_0210681C:
	ldr r3, _02106A50 // =0x41E00000
	cmp r9, r3
	ble _02106B20
	add r0, r3, #0x2100000
	cmp r9, r0
	ble _0210688C
	ldr r1, _02106A54 // =0x3FEFFFFF
	cmp r4, r1
	bgt _02106860
	cmp r8, #0
	mov r0, #0
	addlt r1, r1, #0x40000001
	add sp, sp, #0x80
	movge r1, r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02106860:
	add r0, r1, #1
	cmp r4, r0
	blt _0210688C
	cmp r8, #0
	mov r0, #0
	addgt r1, r1, #0x40000001
	add sp, sp, #0x80
	movle r1, r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_0210688C:
	ldr r2, _02106A54 // =0x3FEFFFFF
	cmp r4, r2
	bge _021068B8
	cmp r8, #0
	mov r0, #0
	addlt r1, r2, #0x40000001
	add sp, sp, #0x80
	movge r1, r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_021068B8:
	add r0, r2, #1
	cmp r4, r0
	ble _021068E4
	cmp r8, #0
	mov r0, #0
	addgt r1, r2, #0x40000001
	add sp, sp, #0x80
	movle r1, r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_021068E4:
	ldr r0, [sp, #0xa8]
	ldr r1, [sp, #0xac]
	add r3, r2, #1
	mov r2, #0
	bl _dsub
	mov r2, r0
	mov r3, r1
	str r0, [sp, #0x50]
	str r1, [sp, #0x54]
	bl _dmul
	mov r6, r1
	mov r4, r0
	ldr r2, [sp, #0x50]
	ldr r3, [sp, #0x54]
	ldr r1, _02106A58 // =0x3FD00000
	mov r0, #0
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106A5C // =0x55555555
	sub r1, r0, #0x15800000
	bl _dsub
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x50]
	ldr r1, [sp, #0x54]
	bl _dmul
	mov r2, r0
	mov r3, r1
	mov r0, #0
	ldr r1, _02106A44 // =0x3FE00000
	bl _dsub
	mov r2, r0
	mov r0, r4
	mov r3, r1
	mov r1, r6
	bl _dmul
	mov r6, r0
	mov r8, r1
	mov r0, #0x60000000
	ldr r1, _02106A60 // =0x3FF71547
	ldr r2, [sp, #0x50]
	ldr r3, [sp, #0x54]
	bl _dmul
	mov r4, r0
	mov r9, r1
	ldr r0, _02106A64 // =0xF85DDF44
	ldr r1, _02106A68 // =0x3E54AE0B
	ldr r2, [sp, #0x50]
	ldr r3, [sp, #0x54]
	bl _dmul
	mov r11, r0
	mov r10, r1
	ldr r0, _02106A6C // =0x652B82FE
	ldr r1, _02106A60 // =0x3FF71547
	mov r2, r6
	mov r3, r8
	bl _dmul
	mov r2, r0
	mov r3, r1
	mov r0, r11
	mov r1, r10
	bl _dsub
	mov r6, r0
	mov r8, r1
	mov r0, r4
	mov r1, r9
	mov r2, r6
	mov r3, r8
	bl _dadd
	mov r2, r4
	mov r3, r9
	str r1, [sp, #0x5c]
	mov r0, #0
	str r0, [sp, #0x58]
	bl _dsub
	mov r2, r0
	mov r0, r6
	mov r3, r1
	mov r1, r8
	bl _dsub
	mov r4, r0
	mov r8, r1
	b _0210707C
	.align 2, 0
_02106A34: .word 0x3FF00000
_02106A38: .word 0x7FF00000
_02106A3C: .word 0x43400000
_02106A40: .word 0xFFFFFC01
_02106A44: .word 0x3FE00000
_02106A48: .word 0x021323F4
_02106A4C: .word errno
_02106A50: .word 0x41E00000
_02106A54: .word 0x3FEFFFFF
_02106A58: .word 0x3FD00000
_02106A5C: .word 0x55555555
_02106A60: .word 0x3FF71547
_02106A64: .word 0xF85DDF44
_02106A68: .word 0x3E54AE0B
_02106A6C: .word 0x652B82FE
_02106A70: .word 0x0003988E
_02106A74: .word 0x000BB67A
_02106A78: .word 0x02117594
_02106A7C: .word 0x4A454EEF
_02106A80: .word 0x3FCA7E28
_02106A84: .word 0x93C9DB65
_02106A88: .word 0x3FCD864A
_02106A8C: .word 0xA91D4101
_02106A90: .word 0x3FD17460
_02106A94: .word 0x518F264D
_02106A98: .word 0x3FD55555
_02106A9C: .word 0xDB6FABFF
_02106AA0: .word 0x3FDB6DB6
_02106AA4: .word 0x33333303
_02106AA8: .word 0x3FE33333
_02106AAC: .word 0x40080000
_02106AB0: .word 0x3FEEC709
_02106AB4: .word 0x145B01F5
_02106AB8: .word 0xBE3E2FE0
_02106ABC: .word 0xDC3A03FD
_02106AC0: .word 0x021175A4
_02106AC4: .word 0x02117584
_02106AC8: .word 0x40900000
_02106ACC: .word 0x8800759C
_02106AD0: .word 0x7E37E43C
_02106AD4: .word 0x3C971547
_02106AD8: .word 0x3F6F3400
_02106ADC: .word 0xC2F8F359
_02106AE0: .word 0x01A56E1F
_02106AE4: .word 0x3FE62E43
_02106AE8: .word 0xFEFA39EF
_02106AEC: .word 0x3FE62E42
_02106AF0: .word 0x0CA86C39
_02106AF4: .word 0xBE205C61
_02106AF8: .word 0x72BEA4D0
_02106AFC: .word 0x3E663769
_02106B00: .word 0xC5D26BF1
_02106B04: .word 0xBEBBBD41
_02106B08: .word 0xAF25DE2C
_02106B0C: .word 0x3F11566A
_02106B10: .word 0x16BEBD93
_02106B14: .word 0xBF66C16C
_02106B18: .word 0x5555553E
_02106B1C: .word 0x3FC55555
_02106B20:
	cmp r4, #0x100000
	mov r6, #0
	bge _02106B50
	ldr r0, [sp, #0x70]
	ldr r1, [sp, #0x74]
	mov r2, r6
	add r3, r3, #0x1600000
	bl _dmul
	mov r4, r1
	str r0, [sp, #0x70]
	str r4, [sp, #0x74]
	sub r6, r6, #0x35
_02106B50:
	ldr r0, _02106A40 // =0xFFFFFC01
	ldr r1, _02106A70 // =0x0003988E
	and r2, r4, r0, lsr #12
	add r0, r0, r4, asr #20
	orr r9, r2, #0xff00000
	cmp r2, r1
	add r6, r6, r0
	orr r9, r9, #0x30000000
	movle r8, #0
	ble _02106B90
	ldr r0, _02106A74 // =0x000BB67A
	cmp r2, r0
	movlt r8, #1
	addge r6, r6, #1
	subge r9, r9, #0x100000
	movge r8, #0
_02106B90:
	ldr r2, _02106A78 // =0x02117594
	ldr r0, [sp, #0x70]
	add r1, r2, r8, lsl #3
	ldr r3, [r1, #4]
	ldr r2, [r2, r8, lsl #3]
	mov r1, r9
	str r9, [sp, #0x74]
	bl _dsub
	ldr r2, _02106A78 // =0x02117594
	mov r10, r0
	add r3, r2, r8, lsl #3
	mov r4, r1
	ldr r0, [sp, #0x70]
	ldr r2, [r2, r8, lsl #3]
	ldr r3, [r3, #4]
	mov r1, r9
	bl _dadd
	mov r3, r1
	mov r2, r0
	ldr r1, _02106A34 // =0x3FF00000
	mov r0, #0
	bl _ddiv
	str r1, [sp, #0x24]
	mov r11, r0
	ldr r3, [sp, #0x24]
	mov r0, r10
	mov r1, r4
	mov r2, r11
	bl _dmul
	mov r2, r9, asr #1
	orr r2, r2, #0x20000000
	mov r9, r1
	add r2, r2, #0x80000
	add r1, r2, r8, lsl #18
	ldr r2, _02106A78 // =0x02117594
	str r0, [sp, #0x28]
	add r3, r2, r8, lsl #3
	mov r0, #0
	ldr r2, [r2, r8, lsl #3]
	ldr r3, [r3, #4]
	str r9, [sp, #0x4c]
	str r1, [sp, #0x44]
	str r0, [sp, #0x48]
	str r0, [sp, #0x40]
	bl _dsub
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x70]
	ldr r1, [sp, #0x74]
	bl _dsub
	str r0, [sp, #0x2c]
	str r1, [sp, #0x1c]
	ldr r0, [sp, #0x48]
	ldr r2, [sp, #0x40]
	ldr r3, [sp, #0x44]
	mov r1, r9
	bl _dmul
	mov r2, r0
	mov r3, r1
	mov r0, r10
	mov r1, r4
	bl _dsub
	mov r10, r0
	mov r4, r1
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x1c]
	ldr r0, [sp, #0x48]
	mov r1, r9
	bl _dmul
	mov r2, r0
	mov r3, r1
	mov r0, r10
	mov r1, r4
	bl _dsub
	mov r3, r1
	mov r2, r0
	ldr r1, [sp, #0x24]
	mov r0, r11
	bl _dmul
	str r0, [sp, #0x30]
	ldr r0, [sp, #0x28]
	str r1, [sp, #0x14]
	mov r1, r9
	mov r2, r0
	mov r3, r9
	bl _dmul
	mov r4, r0
	mov r10, r1
	mov r2, r4
	mov r3, r10
	bl _dmul
	str r0, [sp, #0x34]
	mov r11, r1
	ldr r0, _02106A7C // =0x4A454EEF
	ldr r1, _02106A80 // =0x3FCA7E28
	mov r2, r4
	mov r3, r10
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106A84 // =0x93C9DB65
	ldr r1, _02106A88 // =0x3FCD864A
	bl _dadd
	mov r2, r0
	mov r3, r1
	mov r0, r4
	mov r1, r10
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106A8C // =0xA91D4101
	ldr r1, _02106A90 // =0x3FD17460
	bl _dadd
	mov r2, r0
	mov r3, r1
	mov r0, r4
	mov r1, r10
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106A94 // =0x518F264D
	ldr r1, _02106A98 // =0x3FD55555
	bl _dadd
	mov r2, r0
	mov r3, r1
	mov r0, r4
	mov r1, r10
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106A9C // =0xDB6FABFF
	ldr r1, _02106AA0 // =0x3FDB6DB6
	bl _dadd
	mov r2, r0
	mov r3, r1
	mov r0, r4
	mov r1, r10
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106AA4 // =0x33333303
	ldr r1, _02106AA8 // =0x3FE33333
	bl _dadd
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x34]
	mov r1, r11
	bl _dmul
	mov r4, r0
	mov r10, r1
	ldr r0, [sp, #0x48]
	ldr r2, [sp, #0x28]
	mov r1, r9
	mov r3, r9
	bl _dadd
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x30]
	ldr r1, [sp, #0x14]
	bl _dmul
	mov r2, r0
	mov r3, r1
	mov r0, r4
	mov r1, r10
	bl _dadd
	mov r4, r0
	ldr r0, [sp, #0x48]
	mov r10, r1
	mov r1, r9
	mov r2, r0
	mov r3, r1
	bl _dmul
	str r1, [sp, #0xc]
	mov r11, r0
	ldr r1, _02106AAC // =0x40080000
	ldr r3, [sp, #0xc]
	mov r0, #0
	mov r2, r11
	bl _dadd
	mov r2, r4
	mov r3, r10
	bl _dadd
	mov r0, #0
	ldr r3, _02106AAC // =0x40080000
	mov r2, r0
	str r1, [sp, #0x44]
	str r0, [sp, #0x40]
	bl _dsub
	ldr r3, [sp, #0xc]
	mov r2, r11
	bl _dsub
	mov r2, r0
	mov r3, r1
	mov r0, r4
	mov r1, r10
	bl _dsub
	str r0, [sp, #0x38]
	str r1, [sp, #4]
	ldr r0, [sp, #0x48]
	ldr r2, [sp, #0x40]
	ldr r3, [sp, #0x44]
	mov r1, r9
	bl _dmul
	mov r4, r0
	mov r10, r1
	ldr r0, [sp, #0x30]
	ldr r1, [sp, #0x14]
	ldr r2, [sp, #0x40]
	ldr r3, [sp, #0x44]
	bl _dmul
	str r0, [sp, #0x3c]
	mov r11, r1
	ldr r0, [sp, #0x38]
	ldr r1, [sp, #4]
	ldr r2, [sp, #0x28]
	mov r3, r9
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x3c]
	mov r1, r11
	bl _dadd
	mov r9, r0
	mov r11, r1
	mov r0, r4
	mov r1, r10
	mov r2, r9
	mov r3, r11
	bl _dadd
	mov r0, #0
	mov r2, r4
	mov r3, r10
	str r1, [sp, #0x6c]
	str r0, [sp, #0x68]
	bl _dsub
	mov r2, r0
	mov r3, r1
	mov r0, r9
	mov r1, r11
	bl _dsub
	mov r10, r1
	mov r11, r0
	ldr r1, _02106AB0 // =0x3FEEC709
	ldr r2, [sp, #0x68]
	ldr r3, [sp, #0x6c]
	mov r0, #0xe0000000
	bl _dmul
	mov r4, r0
	mov r9, r1
	ldr r0, _02106AB4 // =0x145B01F5
	ldr r1, _02106AB8 // =0xBE3E2FE0
	ldr r2, [sp, #0x68]
	ldr r3, [sp, #0x6c]
	bl _dmul
	mov r2, r11
	mov r3, r10
	mov r11, r0
	mov r10, r1
	ldr r0, _02106ABC // =0xDC3A03FD
	ldr r1, _02106AB0 // =0x3FEEC709
	bl _dmul
	mov r2, r0
	mov r3, r1
	mov r0, r11
	mov r1, r10
	bl _dadd
	mov r2, r0
	mov r3, r1
	ldr r0, _02106AC0 // =0x021175A4
	add r1, r0, r8, lsl #3
	ldr r0, [r0, r8, lsl #3]
	ldr r1, [r1, #4]
	bl _dadd
	mov r11, r0
	mov r10, r1
	mov r0, r6
	bl _dflt
	str r0, [sp, #0x50]
	str r1, [sp, #0x54]
	mov r0, r4
	mov r1, r9
	mov r2, r11
	mov r3, r10
	bl _dadd
	ldr r2, _02106AC4 // =0x02117584
	add r3, r2, r8, lsl #3
	ldr r2, [r2, r8, lsl #3]
	ldr r3, [r3, #4]
	bl _dadd
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x50]
	ldr r1, [sp, #0x54]
	bl _dadd
	str r1, [sp, #0x5c]
	mov r0, #0
	str r0, [sp, #0x58]
	ldr r2, [sp, #0x50]
	ldr r3, [sp, #0x54]
	bl _dsub
	ldr r2, _02106AC4 // =0x02117584
	add r3, r2, r8, lsl #3
	ldr r2, [r2, r8, lsl #3]
	ldr r3, [r3, #4]
	bl _dsub
	mov r2, r4
	mov r3, r9
	bl _dsub
	mov r2, r0
	mov r0, r11
	mov r3, r1
	mov r1, r10
	bl _dsub
	mov r4, r0
	mov r8, r1
_0210707C:
	sub r0, r5, #1
	ldr r1, [sp, #0xb4]
	orrs r0, r7, r0
	ldr r5, _02106A34 // =0x3FF00000
	mov r2, #0
	ldr r0, [sp, #0xb0]
	mov r3, r1
	mov r6, #0
	subeq r5, r5, #0x80000000
	str r1, [sp, #0x64]
	str r2, [sp, #0x60]
	bl _dsub
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x58]
	ldr r1, [sp, #0x5c]
	bl _dmul
	mov r7, r0
	mov r9, r1
	ldr r0, [sp, #0xb0]
	ldr r1, [sp, #0xb4]
	mov r2, r4
	mov r3, r8
	bl _dmul
	mov r2, r0
	mov r3, r1
	mov r0, r7
	mov r1, r9
	bl _dadd
	mov r7, r0
	mov r8, r1
	ldr r0, [sp, #0x60]
	ldr r1, [sp, #0x64]
	ldr r2, [sp, #0x58]
	ldr r3, [sp, #0x5c]
	bl _dmul
	mov r2, r0
	mov r3, r1
	mov r0, r7
	mov r1, r8
	str r2, [sp, #0x68]
	str r3, [sp, #0x6c]
	bl _dadd
	mov r9, r1
	ldr r2, _02106AC8 // =0x40900000
	str r0, [sp, #0x78]
	str r9, [sp, #0x7c]
	cmp r9, r2
	blt _02107208
	add r1, r9, #0xf700000
	add r1, r1, #0xb0000000
	orrs r0, r1, r0
	beq _02107188
	ldr r0, _02106ACC // =0x8800759C
	ldr r1, _02106AD0 // =0x7E37E43C
	mov r2, r6
	mov r3, r5
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106ACC // =0x8800759C
	ldr r1, _02106AD0 // =0x7E37E43C
	bl _dmul
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02107188:
	ldr r0, _02106A6C // =0x652B82FE
	ldr r1, _02106AD4 // =0x3C971547
	mov r2, r7
	mov r3, r8
	bl _dadd
	mov r4, r0
	mov r10, r1
	ldr r0, [sp, #0x78]
	ldr r2, [sp, #0x68]
	ldr r3, [sp, #0x6c]
	mov r1, r9
	bl _dsub
	mov r2, r0
	mov r3, r1
	mov r0, r4
	mov r1, r10
	bl _dgeq
	bls _021072BC
	ldr r0, _02106ACC // =0x8800759C
	ldr r1, _02106AD0 // =0x7E37E43C
	mov r2, r6
	mov r3, r5
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106ACC // =0x8800759C
	ldr r1, _02106AD0 // =0x7E37E43C
	bl _dmul
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02107208:
	bic r3, r9, #0x80000000
	add r2, r2, #0xcc00
	cmp r3, r2
	blt _021072BC
	ldr r2, _02106AD8 // =0x3F6F3400
	add r2, r9, r2
	orrs r2, r2, r0
	beq _02107260
	ldr r0, _02106ADC // =0xC2F8F359
	ldr r1, _02106AE0 // =0x01A56E1F
	mov r2, r6
	mov r3, r5
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106ADC // =0xC2F8F359
	ldr r1, _02106AE0 // =0x01A56E1F
	bl _dmul
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_02107260:
	ldr r2, [sp, #0x68]
	ldr r3, [sp, #0x6c]
	bl _dsub
	mov r2, r0
	mov r3, r1
	mov r0, r7
	mov r1, r8
	bl _dgr
	bhi _021072BC
	ldr r0, _02106ADC // =0xC2F8F359
	ldr r1, _02106AE0 // =0x01A56E1F
	mov r2, r6
	mov r3, r5
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106ADC // =0xC2F8F359
	ldr r1, _02106AE0 // =0x01A56E1F
	bl _dmul
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_021072BC:
	ldr r0, _02106A40 // =0xFFFFFC01
	bic r3, r9, #0x80000000
	ldr r1, _02106A44 // =0x3FE00000
	add r2, r0, r3, asr #20
	cmp r3, r1
	mov r4, #0
	ble _02107338
	mov r1, #0x100000
	add r2, r2, #1
	add r2, r9, r1, asr r2
	bic r3, r2, #0x80000000
	add r0, r0, r3, asr #20
	sub r3, r1, #1
	mvn r3, r3, asr r0
	sub r1, r1, #1
	and r1, r2, r1
	and r2, r2, r3
	str r2, [sp, #0x54]
	str r4, [sp, #0x50]
	orr r1, r1, #0x100000
	rsb r0, r0, #0x14
	mov r4, r1, asr r0
	cmp r9, #0
	ldr r0, [sp, #0x68]
	ldr r1, [sp, #0x6c]
	ldr r2, [sp, #0x50]
	ldr r3, [sp, #0x54]
	rsblt r4, r4, #0
	bl _dsub
	str r0, [sp, #0x68]
	str r1, [sp, #0x6c]
_02107338:
	ldr r2, [sp, #0x68]
	ldr r3, [sp, #0x6c]
	mov r0, r7
	mov r1, r8
	bl _dadd
	mov r3, r1
	mov r0, #0
	ldr r1, _02106AE4 // =0x3FE62E43
	mov r2, r0
	str r3, [sp, #0x54]
	str r0, [sp, #0x50]
	bl _dmul
	mov r9, r0
	mov r10, r1
	ldr r0, [sp, #0x50]
	ldr r1, [sp, #0x54]
	ldr r2, [sp, #0x68]
	ldr r3, [sp, #0x6c]
	bl _dsub
	mov r2, r0
	mov r0, r7
	mov r3, r1
	mov r1, r8
	bl _dsub
	mov r2, r0
	mov r3, r1
	ldr r0, _02106AE8 // =0xFEFA39EF
	ldr r1, _02106AEC // =0x3FE62E42
	bl _dmul
	mov r7, r0
	mov r8, r1
	ldr r0, _02106AF0 // =0x0CA86C39
	ldr r1, _02106AF4 // =0xBE205C61
	ldr r2, [sp, #0x50]
	ldr r3, [sp, #0x54]
	bl _dmul
	mov r2, r0
	mov r0, r7
	mov r3, r1
	mov r1, r8
	bl _dadd
	mov r7, r0
	mov r8, r1
	mov r0, r9
	mov r1, r10
	mov r2, r7
	mov r3, r8
	bl _dadd
	mov r2, r9
	mov r3, r10
	str r0, [sp, #0x78]
	str r1, [sp, #0x7c]
	bl _dsub
	mov r2, r0
	mov r3, r1
	mov r0, r7
	mov r1, r8
	bl _dsub
	mov r8, r0
	mov r9, r1
	ldr r0, [sp, #0x78]
	ldr r1, [sp, #0x7c]
	mov r2, r0
	mov r3, r1
	bl _dmul
	mov r2, r0
	str r2, [sp, #0x50]
	mov r3, r1
	str r3, [sp, #0x54]
	ldr r0, _02106AF8 // =0x72BEA4D0
	ldr r1, _02106AFC // =0x3E663769
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106B00 // =0xC5D26BF1
	ldr r1, _02106B04 // =0xBEBBBD41
	bl _dadd
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x50]
	ldr r1, [sp, #0x54]
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106B08 // =0xAF25DE2C
	ldr r1, _02106B0C // =0x3F11566A
	bl _dadd
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x50]
	ldr r1, [sp, #0x54]
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106B10 // =0x16BEBD93
	ldr r1, _02106B14 // =0xBF66C16C
	bl _dadd
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x50]
	ldr r1, [sp, #0x54]
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, _02106B18 // =0x5555553E
	ldr r1, _02106B1C // =0x3FC55555
	bl _dadd
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x50]
	ldr r1, [sp, #0x54]
	bl _dmul
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #0x78]
	ldr r1, [sp, #0x7c]
	bl _dsub
	mov r2, r0
	str r2, [sp, #0x58]
	mov r3, r1
	str r3, [sp, #0x5c]
	ldr r0, [sp, #0x78]
	ldr r1, [sp, #0x7c]
	bl _dmul
	mov r7, r0
	mov r10, r1
	ldr r0, [sp, #0x58]
	ldr r1, [sp, #0x5c]
	mov r2, #0
	mov r3, #0x40000000
	bl _dsub
	mov r2, r0
	mov r0, r7
	mov r3, r1
	mov r1, r10
	bl _ddiv
	mov r7, r0
	mov r10, r1
	ldr r0, [sp, #0x78]
	ldr r1, [sp, #0x7c]
	mov r2, r8
	mov r3, r9
	bl _dmul
	mov r2, r0
	mov r0, r8
	mov r3, r1
	mov r1, r9
	bl _dadd
	mov r2, r0
	mov r0, r7
	mov r3, r1
	mov r1, r10
	bl _dsub
	ldr r2, [sp, #0x78]
	ldr r3, [sp, #0x7c]
	bl _dsub
	mov r3, r1
	mov r2, r0
	ldr r1, _02106A34 // =0x3FF00000
	mov r0, #0
	bl _dsub
	add r3, r1, r4, lsl #20
	mov r2, r3, asr #0x14
	str r0, [sp, #0x78]
	cmp r2, #0
	str r1, [sp, #0x7c]
	addgt r0, sp, #0x78
	strgt r3, [r0, #4]
	bgt _021075EC
	mov r2, r4
	bl scalbn
	str r0, [sp, #0x78]
	str r1, [sp, #0x7c]
_021075EC:
	ldr r2, [sp, #0x78]
	ldr r3, [sp, #0x7c]
	mov r0, r6
	mov r1, r5
	bl _dmul
	add sp, sp, #0x80
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end __ieee754_pow

	arm_func_start copysign
copysign: // 0x02107610
	stmdb sp!, {r0, r1, r2, r3}
	ldr r1, [sp, #4]
	ldr r0, [sp, #0xc]
	bic r1, r1, #0x80000000
	and r0, r0, #0x80000000
	orr r1, r1, r0
	ldr r0, [sp]
	str r1, [sp, #4]
	add sp, sp, #0x10
	bx lr
	arm_func_end copysign

	arm_func_start fabs
fabs: // 0x02107638
	stmdb sp!, {r0, r1, r2, r3}
	add r2, sp, #0
	ldr r1, [r2, #4]
	ldr r0, [sp]
	bic r1, r1, #0x80000000
	str r1, [r2, #4]
	add sp, sp, #0x10
	bx lr
	arm_func_end fabs

	arm_func_start frexp
frexp: // 0x02107658
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, lr}
	ldr r1, [sp, #0xc]
	ldr r0, _02107704 // =0x7FF00000
	mov r4, r2
	bic r3, r1, #0x80000000
	mov r2, #0
	str r2, [r4]
	cmp r3, r0
	ldr r0, [sp, #8]
	bge _0210768C
	orrs r0, r3, r0
	bne _021076A0
_0210768C:
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
_021076A0:
	cmp r3, #0x100000
	bge _021076CC
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	ldr r3, _02107708 // =0x43500000
	bl _dmul
	mvn r2, #0x35
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r2, [r4]
	bic r3, r1, #0x80000000
_021076CC:
	ldr r2, _0210770C // =0x800FFFFF
	ldr r0, _02107710 // =0xFFFFFC02
	and r1, r1, r2
	orr r1, r1, #0xfe00000
	orr r1, r1, #0x30000000
	ldr r2, [r4, #0]
	add r0, r0, r3, asr #20
	add r2, r2, r0
	ldr r0, [sp, #8]
	str r2, [r4]
	str r1, [sp, #0xc]
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02107704: .word 0x7FF00000
_02107708: .word 0x43500000
_0210770C: .word 0x800FFFFF
_02107710: .word 0xFFFFFC02
	arm_func_end frexp

	arm_func_start ldexp
ldexp: // 0x02107714
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, lr}
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	mov r4, r2
	bl __fpclassifyd
	cmp r0, #2
	ble _0210774C
	mov r0, #0
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	mov r1, r0
	bl _dls
	bne _02107760
_0210774C:
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
_02107760:
	ldr r3, [sp, #0xc]
	ldr r0, _02107934 // =0x7FF00000
	ldr r1, [sp, #8]
	and r0, r3, r0
	movs ip, r0, asr #0x14
	bne _021077EC
	bic r0, r3, #0x80000000
	orrs r0, r1, r0
	ldreq r0, [sp, #8]
	ldreq r1, [sp, #0xc]
	ldmeqia sp!, {r4, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	ldr r3, _02107938 // =0x43500000
	mov r2, #0
	bl _dmul
	mov r3, r1
	ldr r1, _02107934 // =0x7FF00000
	ldr ip, _0210793C // =0xFFFF3CB0
	and r1, r3, r1
	mov r2, r0
	mov r0, r1, asr #0x14
	str r2, [sp, #8]
	str r3, [sp, #0xc]
	cmp r4, ip
	sub ip, r0, #0x36
	bge _021077EC
	ldr r0, _02107940 // =0xC2F8F359
	ldr r1, _02107944 // =0x01A56E1F
	bl _dmul
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
_021077EC:
	ldr r0, _02107948 // =0x000007FF
	cmp ip, r0
	bne _02107818
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	mov r2, r0
	mov r3, r1
	bl _dadd
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
_02107818:
	add r2, ip, r4
	sub r0, r0, #1
	cmp r2, r0
	ble _0210785C
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	ldr r0, _0210794C // =0x8800759C
	ldr r1, _02107950 // =0x7E37E43C
	bl copysign
	mov r2, r0
	mov r3, r1
	ldr r0, _0210794C // =0x8800759C
	ldr r1, _02107950 // =0x7E37E43C
	bl _dmul
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
_0210785C:
	cmp r2, #0
	ble _02107884
	ldr r1, _02107954 // =0x800FFFFF
	ldr r0, [sp, #8]
	and r1, r3, r1
	orr r1, r1, r2, lsl #20
	str r1, [sp, #0xc]
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
_02107884:
	mvn r0, #0x35
	cmp r2, r0
	bgt _02107904
	ldr r0, _02107958 // =0x0000C350
	cmp r4, r0
	ble _021078D0
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	ldr r0, _0210794C // =0x8800759C
	ldr r1, _02107950 // =0x7E37E43C
	bl copysign
	mov r2, r0
	mov r3, r1
	ldr r0, _0210794C // =0x8800759C
	ldr r1, _02107950 // =0x7E37E43C
	bl _dmul
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
_021078D0:
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	ldr r0, _02107940 // =0xC2F8F359
	ldr r1, _02107944 // =0x01A56E1F
	bl copysign
	mov r2, r0
	mov r3, r1
	ldr r0, _02107940 // =0xC2F8F359
	ldr r1, _02107944 // =0x01A56E1F
	bl _dmul
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
_02107904:
	ldr r0, _02107954 // =0x800FFFFF
	add r1, r2, #0x36
	and r0, r3, r0
	orr r3, r0, r1, lsl #20
	ldr r2, [sp, #8]
	ldr r1, _0210795C // =0x3C900000
	mov r0, #0
	str r3, [sp, #0xc]
	bl _dmul
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02107934: .word 0x7FF00000
_02107938: .word 0x43500000
_0210793C: .word 0xFFFF3CB0
_02107940: .word 0xC2F8F359
_02107944: .word 0x01A56E1F
_02107948: .word 0x000007FF
_0210794C: .word 0x8800759C
_02107950: .word 0x7E37E43C
_02107954: .word 0x800FFFFF
_02107958: .word 0x0000C350
_0210795C: .word 0x3C900000
	arm_func_end ldexp

	arm_func_start pow
pow: // 0x02107960
	ldr ip, _02107968 // =__ieee754_pow
	bx ip
	.align 2, 0
_02107968: .word __ieee754_pow
	arm_func_end pow

	arm_func_start __must_round
__must_round: // 0x0210796C
	add r3, r0, #5
	ldrb r2, [r3, r1]
	add ip, r3, r1
	cmp r2, #5
	movhi r0, #1
	bxhi lr
	mvnlo r0, #0
	bxlo lr
	ldrb r2, [r0, #4]
	add ip, ip, #1
	add r3, r3, r2
	cmp ip, r3
	bhs _021079BC
_021079A0:
	ldrb r2, [ip]
	cmp r2, #0
	movne r0, #1
	bxne lr
	add ip, ip, #1
	cmp ip, r3
	blo _021079A0
_021079BC:
	sub r1, r1, #1
	add r0, r0, r1
	ldrb r0, [r0, #5]
	tst r0, #1
	movne r0, #1
	mvneq r0, #0
	bx lr
	arm_func_end __must_round

	arm_func_start __dorounddecup
__dorounddecup: // 0x021079D8
	add r3, r0, #5
	add r1, r3, r1
	sub ip, r1, #1
	mov r1, #0
_021079E8:
	ldrb r2, [ip]
	cmp r2, #9
	addlo r0, r2, #1
	strlob r0, [ip]
	bxlo lr
	cmp ip, r3
	bne _02107A1C
	mov r1, #1
	strb r1, [ip]
	ldrsh r1, [r0, #2]
	add r1, r1, #1
	strh r1, [r0, #2]
	bx lr
_02107A1C:
	strb r1, [ip], #-1
	b _021079E8
	bx lr
	arm_func_end __dorounddecup

	arm_func_start __rounddec
__rounddec: // 0x02107A28
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	mov r5, r0
	cmp r4, #0
	ldmleia sp!, {r3, r4, r5, pc}
	ldrb r2, [r5, #4]
	cmp r4, r2
	ldmgeia sp!, {r3, r4, r5, pc}
	bl __must_round
	strb r4, [r5, #4]
	cmp r0, #0
	ldmltia sp!, {r3, r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl __dorounddecup
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end __rounddec

	arm_func_start __ull2dec
__ull2dec: // 0x02107A68
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	mov r0, #0
	mov r8, r2
	strb r0, [r10]
	mov r9, r1
	cmp r8, #0
	strb r0, [r10, #4]
	cmpeq r9, #0
	beq _02107AF4
	mov r6, #0xa
	mov r11, r0
	mov r5, r0
	mov r4, r0
_02107AA0:
	ldrb r1, [r10, #4]
	mov r0, r9
	mov r2, r6
	add r3, r1, #1
	mov r7, r1
	strb r3, [r10, #4]
	mov r1, r8
	mov r3, r11
	bl _ull_mod
	add r1, r10, r7
	strb r0, [r1, #5]
	mov r0, r9
	mov r1, r8
	mov r2, #0xa
	mov r3, #0
	bl _ll_udiv
	mov r8, r1
	mov r9, r0
	cmp r8, r5
	cmpeq r9, r4
	bne _02107AA0
_02107AF4:
	ldrb r0, [r10, #4]
	add r2, r10, #5
	add r0, r2, r0
	sub r3, r0, #1
	cmp r2, r3
	bhs _02107B24
_02107B0C:
	ldrb r0, [r3, #0]
	ldrb r1, [r2, #0]
	strb r0, [r2], #1
	strb r1, [r3], #-1
	cmp r2, r3
	blo _02107B0C
_02107B24:
	ldrb r0, [r10, #4]
	sub r0, r0, #1
	strh r0, [r10, #2]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end __ull2dec

	arm_func_start __timesdec
__timesdec: // 0x02107B34
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x40
	ldrb r6, [r1, #4]
	ldrb r5, [r2, #4]
	mov r4, #0
	add r3, sp, #0
	add r5, r6, r5
	sub r5, r5, #1
	add r3, r3, r5
	add r6, r3, #1
	mov r7, r6
	strb r4, [r0]
	cmp r5, #0
	ble _02107BFC
	add lr, r1, #5
	add r11, r2, #5
_02107B74:
	ldrb r3, [r2, #4]
	sub r10, r3, #1
	sub r3, r5, r10
	subs r9, r3, #1
	ldrb r3, [r1, #4]
	movmi r9, #0
	submi r10, r5, #1
	add r8, r10, #1
	sub r3, r3, r9
	cmp r8, r3
	movgt r8, r3
	add r10, r11, r10
	add r9, lr, r9
	cmp r8, #0
	ble _02107BC8
_02107BB0:
	ldrb ip, [r9], #1
	ldrb r3, [r10], #-1
	sub r8, r8, #1
	cmp r8, #0
	mla r4, ip, r3, r4
	bgt _02107BB0
_02107BC8:
	ldr r3, _02107CB4 // =0xCCCCCCCD
	sub r5, r5, #1
	umull r8, r9, r4, r3
	mov r9, r9, lsr #3
	cmp r5, #0
	mov r10, #0xa
	umull r8, r9, r10, r9
	sub r9, r4, r8
	strb r9, [r6, #-1]!
	mov r8, r4
	umull r3, r4, r8, r3
	mov r4, r4, lsr #3
	bgt _02107B74
_02107BFC:
	ldrsh r3, [r1, #2]
	ldrsh r1, [r2, #2]
	cmp r4, #0
	add r1, r3, r1
	strh r1, [r0, #2]
	beq _02107C24
	strb r4, [r6, #-1]!
	ldrsh r1, [r0, #2]
	add r1, r1, #1
	strh r1, [r0, #2]
_02107C24:
	mov r3, #0
	b _02107C3C
_02107C2C:
	ldrb r2, [r6], #1
	add r1, r0, r3
	add r3, r3, #1
	strb r2, [r1, #5]
_02107C3C:
	cmp r3, #0x20
	bge _02107C4C
	cmp r6, r7
	blo _02107C2C
_02107C4C:
	cmp r6, r7
	addhs sp, sp, #0x40
	strb r3, [r0, #4]
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r1, [r6, #0]
	cmp r1, #5
	addlo sp, sp, #0x40
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bne _02107CA4
	add r2, r6, #1
	cmp r2, r7
	bhs _02107C94
_02107C7C:
	ldrb r1, [r2, #0]
	cmp r1, #0
	bne _02107CA4
	add r2, r2, #1
	cmp r2, r7
	blo _02107C7C
_02107C94:
	ldrb r1, [r6, #-1]
	tst r1, #1
	addeq sp, sp, #0x40
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02107CA4:
	ldrb r1, [r0, #4]
	bl __dorounddecup
	add sp, sp, #0x40
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02107CB4: .word 0xCCCCCCCD
	arm_func_end __timesdec

	arm_func_start __str2dec
__str2dec: // 0x02107CB8
	stmdb sp!, {r3, lr}
	strh r2, [r0, #2]
	mov ip, #0
	strb ip, [r0]
	b _02107CE0
_02107CCC:
	ldrsb r3, [r1], #1
	add r2, r0, ip
	add ip, ip, #1
	sub r3, r3, #0x30
	strb r3, [r2, #5]
_02107CE0:
	cmp ip, #0x20
	bge _02107CF4
	ldrsb r2, [r1, #0]
	cmp r2, #0
	bne _02107CCC
_02107CF4:
	strb ip, [r0, #4]
	ldrsb r2, [r1, #0]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	cmp r2, #5
	ldmltia sp!, {r3, pc}
	bgt _02107D48
	ldrsb r2, [r1, #1]
	add r1, r1, #1
	cmp r2, #0
	beq _02107D34
_02107D20:
	cmp r2, #0x30
	bne _02107D48
	ldrsb r2, [r1, #1]!
	cmp r2, #0
	bne _02107D20
_02107D34:
	sub r1, ip, #1
	add r1, r0, r1
	ldrb r1, [r1, #5]
	tst r1, #1
	ldmeqia sp!, {r3, pc}
_02107D48:
	ldrb r1, [r0, #4]
	bl __dorounddecup
	ldmia sp!, {r3, pc}
	arm_func_end __str2dec

	arm_func_start __two_exp
__two_exp: // 0x02107D54
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x4c
	mov r4, r1
	mvn r2, #0x34
	mov r5, r0
	cmp r4, r2
	bgt _02107D84
	bge _02107E50
	sub r0, r2, #0xb
	cmp r4, r0
	beq _02107E38
	b _02107FE0
_02107D84:
	add r1, r4, #0x20
	cmp r1, #0x28
	addls pc, pc, r1, lsl #2
	b _02107FE0
_02107D94: // jump table
	b _02107E64 // case 0
	b _02107FE0 // case 1
	b _02107FE0 // case 2
	b _02107FE0 // case 3
	b _02107FE0 // case 4
	b _02107FE0 // case 5
	b _02107FE0 // case 6
	b _02107FE0 // case 7
	b _02107FE0 // case 8
	b _02107FE0 // case 9
	b _02107FE0 // case 10
	b _02107FE0 // case 11
	b _02107FE0 // case 12
	b _02107FE0 // case 13
	b _02107FE0 // case 14
	b _02107FE0 // case 15
	b _02107E78 // case 16
	b _02107FE0 // case 17
	b _02107FE0 // case 18
	b _02107FE0 // case 19
	b _02107FE0 // case 20
	b _02107FE0 // case 21
	b _02107FE0 // case 22
	b _02107FE0 // case 23
	b _02107E8C // case 24
	b _02107EA0 // case 25
	b _02107EB4 // case 26
	b _02107EC8 // case 27
	b _02107EDC // case 28
	b _02107EF0 // case 29
	b _02107F04 // case 30
	b _02107F18 // case 31
	b _02107F2C // case 32
	b _02107F40 // case 33
	b _02107F54 // case 34
	b _02107F68 // case 35
	b _02107F7C // case 36
	b _02107F90 // case 37
	b _02107FA4 // case 38
	b _02107FB8 // case 39
	b _02107FCC // case 40
_02107E38:
	ldr r1, _02108084 // =a54210108624275
	mov r0, r5
	mvn r2, #0x13
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107E50:
	ldr r1, _02108088 // =a11102230246251
	add r2, r2, #0x25
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107E64:
	ldr r1, _0210808C // =a23283064365386
	add r2, r2, #0x2b
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107E78:
	ldr r1, _02108090 // =a152587890625
	add r2, r2, #0x30
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107E8C:
	ldr r1, _02108094 // =a390625
	add r2, r2, #0x32
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107EA0:
	ldr r1, _02108098 // =a78125
	add r2, r2, #0x32
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107EB4:
	ldr r1, _0210809C // =a15625
	add r2, r2, #0x33
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107EC8:
	ldr r1, _021080A0 // =a3125
	add r2, r2, #0x33
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107EDC:
	ldr r1, _021080A4 // =a625
	add r2, r2, #0x33
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107EF0:
	ldr r1, _021080A8 // =a125
	add r2, r2, #0x34
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107F04:
	ldr r1, _021080AC // =a25
	add r2, r2, #0x34
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107F18:
	ldr r1, _021080B0 // =a5
	add r2, r2, #0x34
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107F2C:
	ldr r1, _021080B4 // =a1_3
	mov r2, #0
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107F40:
	ldr r1, _021080B8 // =a2_0
	mov r2, #0
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107F54:
	ldr r1, _021080BC // =a4_0
	mov r2, #0
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107F68:
	ldr r1, _021080C0 // =a8
	mov r2, #0
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107F7C:
	ldr r1, _021080C4 // =a16
	mov r2, #1
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107F90:
	ldr r1, _021080C8 // =a32
	mov r2, #1
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107FA4:
	ldr r1, _021080CC // =a64
	mov r2, #1
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107FB8:
	ldr r1, _021080D0 // =a128
	mov r2, #2
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107FCC:
	ldr r1, _021080D4 // =a256
	mov r2, #2
	bl __str2dec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
_02107FE0:
	and r0, r4, #0x80000000
	add r1, r4, r0, lsr #31
	add r0, sp, #0x26
	mov r1, r1, asr #1
	bl __two_exp
	add r1, sp, #0x26
	mov r0, r5
	mov r2, r1
	bl __timesdec
	tst r4, #1
	addeq sp, sp, #0x4c
	ldmeqia sp!, {r4, r5, pc}
	add r3, sp, #0
	mov ip, r5
	mov r2, #9
_0210801C:
	ldrh r1, [ip]
	ldrh r0, [ip, #2]
	add ip, ip, #4
	subs r2, r2, #1
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	bne _0210801C
	ldrh r0, [ip]
	cmp r4, #0
	strh r0, [r3]
	add r0, sp, #0x26
	ble _02108060
	ldr r1, _021080B8 // =a2_0
	mov r2, #0
	bl __str2dec
	b _0210806C
_02108060:
	ldr r1, _021080B0 // =a5
	mvn r2, #0
	bl __str2dec
_0210806C:
	add r1, sp, #0
	add r2, sp, #0x26
	mov r0, r5
	bl __timesdec
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02108084: .word a54210108624275
_02108088: .word a11102230246251
_0210808C: .word a23283064365386
_02108090: .word a152587890625
_02108094: .word a390625
_02108098: .word a78125
_0210809C: .word a15625
_021080A0: .word a3125
_021080A4: .word a625
_021080A8: .word a125
_021080AC: .word a25
_021080B0: .word a5
_021080B4: .word a1_3
_021080B8: .word a2_0
_021080BC: .word a4_0
_021080C0: .word a8
_021080C4: .word a16
_021080C8: .word a32
_021080CC: .word a64
_021080D0: .word a128
_021080D4: .word a256
	arm_func_end __two_exp

	arm_func_start __equals_dec
__equals_dec: // 0x021080D8
	stmdb sp!, {r4, lr}
	ldrb r3, [r0, #5]
	cmp r3, #0
	bne _021080FC
	ldrb r0, [r1, #5]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, pc}
_021080FC:
	ldrb r2, [r1, #5]
	cmp r2, #0
	bne _02108118
	cmp r3, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, pc}
_02108118:
	ldrsh r3, [r0, #2]
	ldrsh r2, [r1, #2]
	cmp r3, r2
	bne _021081B0
	ldrb r4, [r0, #4]
	ldrb r2, [r1, #4]
	mov ip, #0
	mov lr, r4
	cmp r4, r2
	movgt lr, r2
	cmp lr, #0
	ble _02108170
_02108148:
	add r3, r0, ip
	add r2, r1, ip
	ldrb r3, [r3, #5]
	ldrb r2, [r2, #5]
	cmp r3, r2
	movne r0, #0
	ldmneia sp!, {r4, pc}
	add ip, ip, #1
	cmp ip, lr
	blt _02108148
_02108170:
	cmp lr, r4
	moveq r0, r1
	ldrb r1, [r0, #4]
	cmp ip, r1
	bge _021081A8
_02108184:
	add r1, r0, ip
	ldrb r1, [r1, #5]
	cmp r1, #0
	movne r0, #0
	ldmneia sp!, {r4, pc}
	ldrb r1, [r0, #4]
	add ip, ip, #1
	cmp ip, r1
	blt _02108184
_021081A8:
	mov r0, #1
	ldmia sp!, {r4, pc}
_021081B0:
	mov r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end __equals_dec

	arm_func_start __less_dec
__less_dec: // 0x021081B8
	stmdb sp!, {r3, r4, r5, lr}
	ldrb r2, [r0, #5]
	cmp r2, #0
	bne _021081DC
	ldrb r0, [r1, #5]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, r4, r5, pc}
_021081DC:
	ldrb r2, [r1, #5]
	cmp r2, #0
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrsh r3, [r1, #2]
	ldrsh r2, [r0, #2]
	cmp r2, r3
	bne _0210828C
	ldrb r5, [r0, #4]
	ldrb r4, [r1, #4]
	mov ip, #0
	mov lr, r5
	cmp r5, r4
	movgt lr, r4
	cmp lr, #0
	ble _02108250
_0210821C:
	add r3, r1, ip
	add r2, r0, ip
	ldrb r3, [r3, #5]
	ldrb r2, [r2, #5]
	cmp r2, r3
	movlo r0, #1
	ldmloia sp!, {r3, r4, r5, pc}
	cmp r3, r2
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	add ip, ip, #1
	cmp ip, lr
	blt _0210821C
_02108250:
	cmp lr, r5
	bne _02108284
	cmp ip, r4
	bge _02108284
_02108260:
	add r0, r1, ip
	ldrb r0, [r0, #5]
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldrb r0, [r1, #4]
	add ip, ip, #1
	cmp ip, r0
	blt _02108260
_02108284:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
_0210828C:
	movlt r0, #1
	movge r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end __less_dec

	arm_func_start __minus_dec
__minus_dec: // 0x02108298
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r5, #9
_021082A4:
	ldrh r4, [r1, #0]
	ldrh r3, [r1, #2]
	add r1, r1, #4
	subs r5, r5, #1
	strh r4, [r6]
	strh r3, [r6, #2]
	add r6, r6, #4
	bne _021082A4
	ldrh r1, [r1, #0]
	strh r1, [r6]
	ldrb r1, [r2, #5]
	cmp r1, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldrb r7, [r0, #4]
	ldrb r3, [r2, #4]
	ldrsh r4, [r0, #2]
	mov r1, r7
	cmp r7, r3
	movlt r1, r3
	ldrsh r3, [r2, #2]
	sub r6, r4, r3
	add r1, r1, r6
	cmp r1, #0x20
	movgt r1, #0x20
	cmp r7, r1
	bge _02108330
	mov r4, #0
_02108310:
	ldrb r5, [r0, #4]
	add r3, r0, r7
	add r5, r5, #1
	strb r5, [r0, #4]
	strb r4, [r3, #5]
	ldrb r7, [r0, #4]
	cmp r7, r1
	blt _02108310
_02108330:
	ldrb r4, [r2, #4]
	add r3, r0, #5
	add ip, r3, r1
	add r4, r4, r6
	cmp r4, r1
	addlt ip, r3, r4
	sub r4, ip, r3
	add r1, r2, #5
	sub r4, r4, r6
	add lr, r1, r4
	mov r4, lr
	b _021083C4
_02108360:
	ldrb r7, [ip, #-1]!
	ldrb r5, [lr, #-1]!
	cmp r7, r5
	bhs _021083B4
	ldrb r7, [ip, #-1]
	sub r5, ip, #1
	cmp r7, #0
	bne _0210838C
_02108380:
	ldrb r7, [r5, #-1]!
	cmp r7, #0
	beq _02108380
_0210838C:
	cmp r5, ip
	beq _021083B4
_02108394:
	ldrb r7, [r5, #0]
	sub r7, r7, #1
	strb r7, [r5]
	ldrb r7, [r5, #1]!
	cmp r5, ip
	add r7, r7, #0xa
	strb r7, [r5]
	bne _02108394
_021083B4:
	ldrb r7, [ip]
	ldrb r5, [lr]
	sub r5, r7, r5
	strb r5, [ip]
_021083C4:
	cmp ip, r3
	cmphi lr, r1
	bhi _02108360
	ldrb r5, [r2, #4]
	sub lr, r4, r1
	cmp lr, r5
	bge _021084A0
	ldrb r1, [r4, #0]
	mov r7, #0
	cmp r1, #5
	movlo r7, #1
	blo _0210843C
	bne _0210843C
	add r1, r2, #5
	add r2, r1, r5
	add r4, r4, #1
	cmp r4, r2
	bhs _02108424
_0210840C:
	ldrb r1, [r4, #0]
	cmp r1, #0
	bne _021084A0
	add r4, r4, #1
	cmp r4, r2
	blo _0210840C
_02108424:
	add r1, r3, lr
	add r2, r1, r6
	ldrb r1, [r2, #-1]
	sub ip, r2, #1
	tst r1, #1
	movne r7, #1
_0210843C:
	cmp r7, #0
	beq _021084A0
	ldrb r1, [ip]
	cmp r1, #1
	bhs _02108494
	ldrb r1, [ip, #-1]
	sub r2, ip, #1
	cmp r1, #0
	bne _0210846C
_02108460:
	ldrb r1, [r2, #-1]!
	cmp r1, #0
	beq _02108460
_0210846C:
	cmp r2, ip
	beq _02108494
_02108474:
	ldrb r1, [r2, #0]
	sub r1, r1, #1
	strb r1, [r2]
	ldrb r1, [r2, #1]!
	cmp r2, ip
	add r1, r1, #0xa
	strb r1, [r2]
	bne _02108474
_02108494:
	ldrb r1, [ip]
	sub r1, r1, #1
	strb r1, [ip]
_021084A0:
	ldrb r1, [r3, #0]
	mov r5, r3
	cmp r1, #0
	bne _021084BC
_021084B0:
	ldrb r1, [r5, #1]!
	cmp r1, #0
	beq _021084B0
_021084BC:
	cmp r5, r3
	bls _02108504
	ldrsh r1, [r0, #2]
	sub r2, r5, r3
	and r4, r2, #0xff
	sub r1, r1, r4
	strh r1, [r0, #2]
	ldrb r1, [r0, #4]
	add r2, r3, r1
	cmp r5, r2
	bhs _021084F8
_021084E8:
	ldrb r1, [r5], #1
	cmp r5, r2
	strb r1, [r3], #1
	blo _021084E8
_021084F8:
	ldrb r1, [r0, #4]
	sub r1, r1, r4
	strb r1, [r0, #4]
_02108504:
	ldrb r1, [r0, #4]
	add r2, r0, #5
	add r3, r2, r1
	cmp r3, r2
	bls _0210852C
_02108518:
	ldrb r1, [r3, #-1]!
	cmp r1, #0
	bne _0210852C
	cmp r3, r2
	bhi _02108518
_0210852C:
	sub r1, r3, r2
	add r1, r1, #1
	strb r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end __minus_dec

	arm_func_start __num2dec_internal
__num2dec_internal: // 0x0210853C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x58
	mov r8, r1
	mov r6, r2
	mov r7, r0
	mov r0, r8
	mov r1, r6
	bl __signbitf
	cmp r0, #0
	movne r1, #1
	moveq r1, #0
	mov r4, r1, lsl #0x18
	mov r0, #0
	mov r1, r0
	mov r2, r8
	mov r3, r6
	mov r5, r4, asr #0x18
	bl _dls
	bne _021085A8
	strb r5, [r7]
	mov r1, #0
	strh r1, [r7, #2]
	mov r0, #1
	strb r0, [r7, #4]
	add sp, sp, #0x58
	strb r1, [r7, #5]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_021085A8:
	mov r0, r8
	mov r1, r6
	bl __fpclassifyd
	cmp r0, #2
	bgt _021085F4
	strb r5, [r7]
	mov r2, #0
	strh r2, [r7, #2]
	mov r2, #1
	mov r0, r8
	mov r1, r6
	strb r2, [r7, #4]
	bl __fpclassifyd
	cmp r0, #1
	moveq r0, #0x4e
	movne r0, #0x49
	add sp, sp, #0x58
	strb r0, [r7, #5]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_021085F4:
	cmp r5, #0
	beq _02108618
	mov r0, #0
	mov r1, r0
	mov r2, r8
	mov r3, r6
	bl _dsub
	mov r8, r0
	mov r6, r1
_02108618:
	add r2, sp, #8
	mov r0, r8
	mov r1, r6
	bl frexp
	mov r4, r0
	mov r6, r1
	orr ip, r4, #0
	rsbs r2, ip, #0
	orr r3, r6, #0x100000
	rsc r1, r3, #0
	mov r0, #0
	and r3, r3, r1
	sub r1, r0, #1
	and ip, ip, r2
	mov r2, r1
	adds r0, ip, r1
	adc r1, r3, r2
	str r4, [sp]
	str r6, [sp, #4]
	bl __msl_generic_count_bits64
	rsb r8, r0, #0x35
	ldr r1, [sp, #8]
	add r0, sp, #0xc
	sub r1, r1, r8
	bl __two_exp
	mov r0, r4
	mov r1, r6
	mov r2, r8
	bl ldexp
	bl _ll_ufrom_d
	mov r2, r1
	mov r1, r0
	add r0, sp, #0x32
	bl __ull2dec
	mov r0, r7
	add r1, sp, #0x32
	add r2, sp, #0xc
	bl __timesdec
	strb r5, [r7]
	add sp, sp, #0x58
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end __num2dec_internal

	arm_func_start __num2dec
__num2dec: // 0x021086BC
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r3
	ldrsh r5, [r0, #2]
	mov r0, r4
	bl __num2dec_internal
	ldrb r0, [r4, #5]
	cmp r0, #9
	ldmhiia sp!, {r3, r4, r5, pc}
	cmp r5, #0x20
	movgt r5, #0x20
	mov r0, r4
	mov r1, r5
	bl __rounddec
	ldrb r0, [r4, #4]
	cmp r0, r5
	bge _02108720
	mov r1, #0
_02108700:
	ldrb r2, [r4, #4]
	add r0, r4, r0
	add r2, r2, #1
	strb r2, [r4, #4]
	strb r1, [r0, #5]
	ldrb r0, [r4, #4]
	cmp r0, r5
	blt _02108700
_02108720:
	ldrsh r1, [r4, #2]
	sub r0, r0, #1
	mov r2, #0
	sub r0, r1, r0
	strh r0, [r4, #2]
	ldrb r0, [r4, #4]
	cmp r0, #0
	ldmleia sp!, {r3, r4, r5, pc}
_02108740:
	add r1, r4, r2
	ldrb r0, [r1, #5]
	add r2, r2, #1
	add r0, r0, #0x30
	strb r0, [r1, #5]
	ldrb r0, [r4, #4]
	cmp r2, r0
	blt _02108740
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end __num2dec

	arm_func_start __dec2num
__dec2num: // 0x02108764
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xfc
	mov r4, r0
	ldrb r0, [r4, #4]
	cmp r0, #0
	bne _021087A4
	ldrsb r0, [r4, #0]
	mov r2, #0
	cmp r0, #0
	ldreq r3, _02108D68 // =0x3FF00000
	mov r0, #0
	ldrne r3, _02108D6C // =0xBFF00000
	mov r1, r0
	bl copysign
	add sp, sp, #0xfc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_021087A4:
	ldrb r0, [r4, #5]
	cmp r0, #0x30
	beq _021087C4
	cmp r0, #0x49
	beq _021087EC
	cmp r0, #0x4e
	beq _02108820
	b _02108868
_021087C4:
	ldrsb r0, [r4, #0]
	mov r2, #0
	cmp r0, #0
	ldreq r3, _02108D68 // =0x3FF00000
	mov r0, #0
	ldrne r3, _02108D6C // =0xBFF00000
	mov r1, r0
	bl copysign
	add sp, sp, #0xfc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_021087EC:
	ldrsb r0, [r4, #0]
	mov r5, #0
	cmp r0, #0
	ldreq r4, _02108D68 // =0x3FF00000
	ldr r0, _02108D70 // =_021323F0
	ldrne r4, _02108D6C // =0xBFF00000
	ldr r0, [r0, #0]
	bl _f2d
	mov r2, r5
	mov r3, r4
	bl copysign
	add sp, sp, #0xfc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02108820:
	ldr r1, _02108D74 // =0x7FF00000
	add r3, sp, #0x10
	mov r2, #0
	str r2, [r3]
	str r1, [r3, #4]
	ldrsb r0, [r4, #0]
	cmp r0, #0
	beq _02108850
	orr r0, r1, #0x80000000
	orr r1, r2, r2
	str r1, [r3]
	str r0, [r3, #4]
_02108850:
	ldmia r3, {r0, r1}
	orr r0, r0, #0
	orr r1, r1, #0x80000
	stmia r3, {r0, r1}
	add sp, sp, #0xfc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02108868:
	add r3, sp, #0xd6
	mov r5, r4
	mov r2, #9
_02108874:
	ldrh r1, [r5, #0]
	ldrh r0, [r5, #2]
	add r5, r5, #4
	subs r2, r2, #1
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	bne _02108874
	ldrh r0, [r5, #0]
	add r1, sp, #0xdb
	strh r0, [r3]
	ldrb r0, [sp, #0xda]
	add r5, r1, r0
	cmp r1, r5
	bhs _021088C4
_021088B0:
	ldrb r0, [r1, #0]
	sub r0, r0, #0x30
	strb r0, [r1], #1
	cmp r1, r5
	blo _021088B0
_021088C4:
	ldrb r1, [sp, #0xda]
	ldrsh r2, [sp, #0xd8]
	add r0, sp, #0xb0
	sub r1, r1, #1
	add r1, r2, r1
	strh r1, [sp, #0xd8]
	ldr r1, _02108D78 // =a17976931348623
	mov r2, #0x134
	ldrsh r11, [sp, #0xd8]
	bl __str2dec
	add r0, sp, #0xb0
	add r1, sp, #0xd6
	bl __less_dec
	cmp r0, #0
	beq _02108934
	ldrsb r0, [r4, #0]
	mov r5, #0
	cmp r0, #0
	ldreq r4, _02108D68 // =0x3FF00000
	ldr r0, _02108D70 // =_021323F0
	ldrne r4, _02108D6C // =0xBFF00000
	ldr r0, [r0, #0]
	bl _f2d
	mov r2, r5
	mov r3, r4
	bl copysign
	add sp, sp, #0xfc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02108934:
	add r1, sp, #0xdb
	ldrb r0, [r1, #0]
	add r8, r1, #1
	bl _dfltu
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	cmp r8, r5
	bhs _02108A0C
_02108954:
	sub r0, r5, r8
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #29
	adds r7, r1, r0, ror #29
	moveq r7, #8
	mov r6, #0
	mov r2, #0
	cmp r7, #0
	ble _02108990
	mov r0, #0xa
_0210897C:
	ldrb r1, [r8], #1
	add r2, r2, #1
	cmp r2, r7
	mla r6, r0, r6, r1
	blt _0210897C
_02108990:
	ldr r0, _02108D7C // =0x021326C4
	ldr r1, [sp, #0xc]
	add r3, r0, r7, lsl #3
	ldr r2, [r3, #-8]
	ldr r0, [sp, #8]
	ldr r3, [r3, #-4]
	bl _dmul
	mov r4, r0
	mov r9, r1
	mov r0, r6
	bl _dfltu
	mov r2, r0
	mov r3, r1
	mov r0, r4
	mov r1, r9
	bl _dadd
	cmp r6, #0
	mov r6, r0
	mov r10, r1
	beq _021089F8
	mov r0, r4
	mov r1, r9
	mov r2, r6
	mov r3, r10
	bl _dls
	beq _02108A0C
_021089F8:
	str r6, [sp, #8]
	str r10, [sp, #0xc]
	cmp r8, r5
	sub r11, r11, r7
	blo _02108954
_02108A0C:
	cmp r11, #0
	bge _02108A50
	rsb r0, r11, #0
	bl _dflt
	mov r3, r1
	mov r2, r0
	ldr r1, _02108D80 // =0x40140000
	mov r0, #0
	bl pow
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	bl _ddiv
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	b _02108A88
_02108A50:
	mov r0, r11
	bl _dflt
	mov r3, r1
	mov r2, r0
	ldr r1, _02108D80 // =0x40140000
	mov r0, #0
	bl pow
	mov r2, r0
	mov r3, r1
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	bl _dmul
	str r0, [sp, #8]
	str r1, [sp, #0xc]
_02108A88:
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	mov r2, r11
	bl ldexp
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	bl __fpclassifyd
	cmp r0, #2
	bne _02108ABC
	ldr r0, _02108D84 // =0x7FEFFFFF
	mvn r1, #0
	str r1, [sp, #8]
	str r0, [sp, #0xc]
_02108ABC:
	ldr r1, [sp, #8]
	ldr r2, [sp, #0xc]
	add r0, sp, #0x8a
	add r4, sp, #0
	mov r5, #0
	bl __num2dec_internal
	add r0, sp, #0x8a
	add r1, sp, #0xd6
	bl __equals_dec
	cmp r0, #0
	bne _02108D30
	add r0, sp, #0x8a
	add r1, sp, #0xd6
	bl __less_dec
	cmp r0, #0
	movne r5, #1
	ldr r1, [sp, #8]
	ldr r0, [sp, #0xc]
	cmp r5, #0
	moveq r6, #1
	str r1, [sp]
	str r0, [sp, #4]
	movne r6, #0
_02108B18:
	cmp r6, #0
	bne _02108B40
	ldmia r4, {r0, r1}
	adds r0, r0, #1
	adc r1, r1, #0
	stmia r4, {r0, r1}
	bl __fpclassifyd
	cmp r0, #2
	beq _02108D30
	b _02108B58
_02108B40:
	ldr r1, [r4, #0]
	ldr r0, [r4, #4]
	subs r1, r1, #1
	sbc r0, r0, #0
	str r1, [r4]
	str r0, [r4, #4]
_02108B58:
	ldr r1, [sp]
	ldr r2, [sp, #4]
	add r0, sp, #0x64
	bl __num2dec_internal
	cmp r5, #0
	beq _02108B84
	add r0, sp, #0x64
	add r1, sp, #0xd6
	bl __less_dec
	cmp r0, #0
	beq _02108CA8
_02108B84:
	cmp r5, #0
	bne _02108C60
	add r0, sp, #0xd6
	add r1, sp, #0x64
	bl __less_dec
	cmp r0, #0
	bne _02108C60
	add r3, sp, #0x8a
	add r5, sp, #0x3e
	mov r2, #9
_02108BAC:
	ldrh r1, [r3, #0]
	ldrh r0, [r3, #2]
	add r3, r3, #4
	strh r1, [r5]
	strh r0, [r5, #2]
	add r5, r5, #4
	subs r2, r2, #1
	bne _02108BAC
	ldrh r0, [r3, #0]
	add r3, sp, #0x64
	add r4, sp, #0x8a
	strh r0, [r5]
	mov r2, #9
_02108BE0:
	ldrh r1, [r3, #0]
	ldrh r0, [r3, #2]
	add r3, r3, #4
	strh r1, [r4]
	strh r0, [r4, #2]
	add r4, r4, #4
	subs r2, r2, #1
	bne _02108BE0
	ldrh r0, [r3, #0]
	add r3, sp, #0x3e
	add r5, sp, #0x64
	strh r0, [r4]
	mov r2, #9
_02108C14:
	ldrh r1, [r3, #0]
	ldrh r0, [r3, #2]
	add r3, r3, #4
	strh r1, [r5]
	strh r0, [r5, #2]
	add r5, r5, #4
	subs r2, r2, #1
	bne _02108C14
	ldrh r4, [r3, #0]
	ldr r3, [sp, #8]
	ldr r1, [sp]
	ldr r2, [sp, #0xc]
	ldr r0, [sp, #4]
	strh r4, [r5]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	str r3, [sp]
	str r2, [sp, #4]
	b _02108CA8
_02108C60:
	add r7, sp, #0x64
	add r3, sp, #0x8a
	mov r2, #9
_02108C6C:
	ldrh r1, [r7, #0]
	ldrh r0, [r7, #2]
	add r7, r7, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _02108C6C
	ldrh r2, [r7, #0]
	ldr r1, [sp]
	ldr r0, [sp, #4]
	strh r2, [r3]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	b _02108B18
_02108CA8:
	add r0, sp, #0x3e
	add r1, sp, #0xd6
	add r2, sp, #0x8a
	bl __minus_dec
	add r0, sp, #0x18
	add r1, sp, #0x64
	add r2, sp, #0xd6
	bl __minus_dec
	add r0, sp, #0x3e
	add r1, sp, #0x18
	bl __equals_dec
	cmp r0, #0
	beq _02108D0C
	ldr r1, [sp, #8]
	ldr r0, [sp, #0xc]
	and r1, r1, #1
	and r0, r0, #0
	cmp r0, #0
	cmpeq r1, #0
	beq _02108D30
	ldr r1, [sp]
	ldr r0, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	b _02108D30
_02108D0C:
	add r0, sp, #0x3e
	add r1, sp, #0x18
	bl __less_dec
	cmp r0, #0
	bne _02108D30
	ldr r1, [sp]
	ldr r0, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
_02108D30:
	ldrsb r0, [sp, #0xd6]
	cmp r0, #0
	beq _02108D58
	mov r0, #0
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	mov r1, r0
	bl _dsub
	str r0, [sp, #8]
	str r1, [sp, #0xc]
_02108D58:
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	add sp, sp, #0xfc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02108D68: .word 0x3FF00000
_02108D6C: .word 0xBFF00000
_02108D70: .word _021323F0
_02108D74: .word 0x7FF00000
_02108D78: .word a17976931348623
_02108D7C: .word 0x021326C4
_02108D80: .word 0x40140000
_02108D84: .word 0x7FEFFFFF
	arm_func_end __dec2num

	arm_func_start __msl_generic_count_bits64
__msl_generic_count_bits64: // 0x02108D88
	mov r3, r0, lsr #1
	ldr r2, _02108E10 // =0x55555555
	orr r3, r3, r1, lsl #31
	and r3, r3, r2
	subs ip, r0, r3
	and r2, r2, r1, lsr #1
	ldr r0, _02108E14 // =0x33333333
	sbc r3, r1, r2
	mov r1, ip, lsr #2
	orr r1, r1, r3, lsl #30
	and r2, ip, r0
	and r1, r1, r0
	adds r2, r2, r1
	and r1, r3, r0
	and r0, r0, r3, lsr #2
	adc r1, r1, r0
	mov r0, r2, lsr #4
	orr r0, r0, r1, lsl #28
	adds r2, r2, r0
	ldr r0, _02108E18 // =0x0F0F0F0F
	adc r1, r1, r1, lsr #4
	and r3, r2, r0
	and r2, r1, r0
	mov r0, r3, lsr #8
	orr r0, r0, r2, lsl #24
	adds r1, r3, r0
	adc r2, r2, r2, lsr #8
	mov r0, r1, lsr #0x10
	orr r0, r0, r2, lsl #16
	adds r1, r1, r0
	adc r0, r2, r2, lsr #16
	adds r0, r1, r0
	and r0, r0, #0xff
	bx lr
	.align 2, 0
_02108E10: .word 0x55555555
_02108E14: .word 0x33333333
_02108E18: .word 0x0F0F0F0F
	arm_func_end __msl_generic_count_bits64

	arm_func_start __signbitf
__signbitf: // 0x02108E1C
	stmdb sp!, {r0, r1, r2, r3}
	ldr r0, [sp, #4]
	and r0, r0, #0x80000000
	add sp, sp, #0x10
	bx lr
	arm_func_end __signbitf

	arm_func_start __fpclassifyd
__fpclassifyd: // 0x02108E30
	stmdb sp!, {r0, r1, r2, r3}
	ldr r2, [sp, #4]
	ldr r0, _02108E98 // =0x7FF00000
	ands r1, r2, r0
	beq _02108E6C
	cmp r1, r0
	bne _02108E8C
	ldr r0, _02108E9C // =0x000FFFFF
	tst r2, r0
	ldreq r0, [sp]
	add sp, sp, #0x10
	cmpeq r0, #0
	movne r0, #1
	moveq r0, #2
	bx lr
_02108E6C:
	ldr r0, _02108E9C // =0x000FFFFF
	tst r2, r0
	ldreq r0, [sp]
	add sp, sp, #0x10
	cmpeq r0, #0
	movne r0, #5
	moveq r0, #3
	bx lr
_02108E8C:
	mov r0, #4
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_02108E98: .word 0x7FF00000
_02108E9C: .word 0x000FFFFF
	arm_func_end __fpclassifyd

	arm_func_start scalbn
scalbn: // 0x02108EA0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r2
	add r2, sp, #0
	bl frexp
	ldr r2, [sp]
	add r2, r2, r4
	str r2, [sp]
	bl ldexp
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end scalbn

	arm_func_start stricmp
stricmp: // 0x02108ECC
	stmdb sp!, {r3, lr}
	ldr r3, _02108F30 // =__lower_mapC
_02108ED4:
	ldrb r2, [r0], #1
	cmp r2, #0
	blt _02108EEC
	cmp r2, #0x80
	bge _02108EEC
	ldrb r2, [r3, r2]
_02108EEC:
	ldrb lr, [r1], #1
	and ip, r2, #0xff
	cmp lr, #0
	blt _02108F08
	cmp lr, #0x80
	bge _02108F08
	ldrb lr, [r3, lr]
_02108F08:
	and r2, lr, #0xff
	cmp ip, r2
	mvnlo r0, #0
	ldmloia sp!, {r3, pc}
	movhi r0, #1
	ldmhiia sp!, {r3, pc}
	cmp ip, #0
	bne _02108ED4
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02108F30: .word __lower_mapC
	arm_func_end stricmp

	arm_func_start strcasecmp
strcasecmp: // 0x02108F34
	ldr ip, _02108F3C // =stricmp
	bx ip
	.align 2, 0
_02108F3C: .word stricmp
	arm_func_end strcasecmp

	arm_func_start itoa
itoa: // 0x02108F40
	ldr ip, _02108F48 // =__msl_itoa
	bx ip
	.align 2, 0
_02108F48: .word __msl_itoa
	arm_func_end itoa

	arm_func_start _dadd
_dadd: // 0x02108F4C
	stmdb sp!, {r4, lr}
	eors ip, r1, r3
	eormi r3, r3, #0x80000000
	bmi _021099E4
_02108F5C:
	subs ip, r0, r2
	sbcs lr, r1, r3
	bhs _02108F78
	adds r2, r2, ip
	adc r3, r3, lr
	subs r0, r0, ip
	sbc r1, r1, lr
_02108F78:
	mov lr, #0x80000000
	mov ip, r1, lsr #0x14
	orr r1, lr, r1, lsl #11
	orr r1, r1, r0, lsr #21
	mov r0, r0, lsl #0xb
	movs r4, ip, lsl #0x15
	cmnne r4, #0x200000
	beq _02109074
	mov r4, r3, lsr #0x14
	orr r3, lr, r3, lsl #11
	orr r3, r3, r2, lsr #21
	mov r2, r2, lsl #0xb
	movs lr, r4, lsl #0x15
	beq _021090BC
_02108FB0:
	subs r4, ip, r4
	beq _02109008
	cmp r4, #0x20
	ble _02108FEC
	cmp r4, #0x38
	movge r4, #0x3f
	sub r4, r4, #0x20
	rsb lr, r4, #0x20
	orrs lr, r2, r3, lsl lr
	mov r2, r3, lsr r4
	orrne r2, r2, #1
	adds r0, r0, r2
	adcs r1, r1, #0
	blo _02109030
	b _02109014
_02108FEC:
	rsb lr, r4, #0x20
	movs lr, r2, lsl lr
	rsb lr, r4, #0x20
	mov r2, r2, lsr r4
	orr r2, r2, r3, lsl lr
	mov r3, r3, lsr r4
	orrne r2, r2, #1
_02109008:
	adds r0, r0, r2
	adcs r1, r1, r3
	blo _02109030
_02109014:
	add ip, ip, #1
	and r4, r0, #1
	movs r1, r1, rrx
	orr r0, r4, r0, rrx
	mov lr, ip, lsl #0x15
	cmn lr, #0x200000
	beq _02109240
_02109030:
	movs r2, r0, lsl #0x15
	mov r0, r0, lsr #0xb
	orr r0, r0, r1, lsl #21
	add r1, r1, r1
	mov r1, r1, lsr #0xc
	orr r1, r1, ip, lsl #20
	tst r2, #0x80000000
	ldmeqia sp!, {r4, lr}
	bxeq lr
	movs r2, r2, lsl #1
	andeqs r2, r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	adds r0, r0, #1
	adc r1, r1, #0
	ldmia sp!, {r4, lr}
	bx lr
_02109074:
	cmp ip, #0x800
	movge lr, #0x80000000
	movlt lr, #0
	bics ip, ip, #0x800
	beq _021090E0
	orrs r4, r0, r1, lsl #1
	bne _0210921C
	mov r4, r3, lsr #0x14
	mov r3, r3, lsl #0xb
	orr r3, r3, r2, lsr #21
	mov r2, r2, lsl #0xb
	movs r4, r4, lsl #0x15
	beq _02109208
	cmn r4, #0x200000
	bne _02109208
	orrs r4, r2, r3, lsl #1
	beq _02109208
	b _0210921C
_021090BC:
	cmp r4, #0x800
	movge lr, #0x80000000
	movlt lr, #0
	bic ip, ip, #0x800
	bics r4, r4, #0x800
	beq _0210914C
	orrs r4, r2, r3, lsl #1
	bne _0210921C
	b _02109208
_021090E0:
	orrs r4, r0, r1, lsl #1
	beq _02109120
	mov ip, #1
	bic r1, r1, #0x80000000
	mov r4, r3, lsr #0x14
	mov r3, r3, lsl #0xb
	orr r3, r3, r2, lsr #21
	mov r2, r2, lsl #0xb
	movs r4, r4, lsl #0x15
	cmnne r4, #0x200000
	mov r4, r4, lsr #0x15
	orr r4, r4, lr, lsr #20
	beq _021090BC
	orr r3, r3, #0x80000000
	orr ip, ip, lr, lsr #20
	b _02108FB0
_02109120:
	mov ip, r3, lsr #0x14
	mov r1, r3, lsl #0xb
	orr r1, r1, r2, lsr #21
	mov r0, r2, lsl #0xb
	movs r4, ip, lsl #0x15
	beq _021091D4
	cmn r4, #0x200000
	bne _021091D4
	orrs r4, r0, r1, lsl #1
	beq _02109208
	b _02109220
_0210914C:
	orrs r4, r2, r3, lsl #1
	beq _021091E4
	mov r4, #1
	bic r3, r3, #0x80000000
	cmp r1, #0
	bpl _02109170
	orr ip, ip, lr, lsr #20
	orr r4, r4, lr, lsr #20
	b _02108FB0
_02109170:
	adds r0, r0, r2
	adcs r1, r1, r3
	blo _02109190
	add ip, ip, #1
	and r4, r0, #1
	movs r1, r1, rrx
	mov r0, r0, rrx
	orr r0, r0, r4
_02109190:
	cmp r1, #0
	subges ip, ip, #1
	movs r2, r0, lsl #0x15
	mov r0, r0, lsr #0xb
	orr r0, r0, r1, lsl #21
	add r1, r1, r1
	orr r1, lr, r1, lsr #12
	orr r1, r1, ip, lsl #20
	ldmeqia sp!, {r4, lr}
	bxeq lr
	tst r2, #0x80000000
	ldmeqia sp!, {r4, lr}
	bxeq lr
	movs r2, r2, lsl #1
	andeqs r2, r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
_021091D4:
	mov r1, r3
	mov r0, r2
	ldmia sp!, {r4, lr}
	bx lr
_021091E4:
	cmp r1, #0
	subges ip, ip, #1
	mov r0, r0, lsr #0xb
	orr r0, r0, r1, lsl #21
	add r1, r1, r1
	orr r1, lr, r1, lsr #12
	orr r1, r1, ip, lsl #20
	ldmia sp!, {r4, lr}
	bx lr
_02109208:
	ldr r1, _02109260 // =0x7FF00000
	orr r1, lr, r1
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_0210921C:
	mov r1, r3
_02109220:
	mvn r0, #0
	bic r1, r0, #0x80000000
	ldmia sp!, {r4, lr}
	bx lr
_02109230:
	mvn r0, #0
	bic r1, r0, #0x80000000
	ldmia sp!, {r4, lr}
	bx lr
_02109240:
	cmp ip, #0x800
	movge lr, #0x80000000
	movlt lr, #0
	ldr r1, _02109260 // =0x7FF00000
	orr r1, lr, r1
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_02109260: .word 0x7FF00000
	arm_func_end _dadd

	arm_func_start _d2f
_d2f: // 0x02109264
	and r2, r1, #0x80000000
	mov ip, r1, lsr #0x14
	bics ip, ip, #0x800
	beq _021092DC
	mov r3, ip, lsl #0x15
	cmn r3, #0x200000
	bhs _021092C0
	subs ip, ip, #0x380
	bls _021092EC
	cmp ip, #0xff
	bge _0210935C
	mov r1, r1, lsl #0xc
	orr r3, r2, r1, lsr #9
	orr r3, r3, r0, lsr #29
	movs r1, r0, lsl #3
	orr r0, r3, ip, lsl #23
	bxeq lr
	tst r1, #0x80000000
	bxeq lr
	movs r1, r1, lsl #1
	andeqs r1, r0, #1
	addne r0, r0, #1
	bx lr
_021092C0:
	orrs r3, r0, r1, lsl #12
	bne _021092D4
	mov r0, #0xff000000
	orr r0, r2, r0, lsr #1
	bx lr
_021092D4:
	mvn r0, #0x80000000
	bx lr
_021092DC:
	orrs r3, r0, r1, lsl #12
	bne _02109354
	mov r0, r2
	bx lr
_021092EC:
	cmn ip, #0x17
	beq _02109340
	bmi _02109354
	mov r1, r1, lsl #0xb
	orr r1, r1, #0x80000000
	mov r3, r1, lsr #8
	orr r3, r3, r0, lsr #29
	rsb ip, ip, #1
	movs r1, r0, lsl #3
	orr r0, r2, r3, lsr ip
	rsb ip, ip, #0x20
	mov r3, r3, lsl ip
	orrne r3, r3, #1
	movs r1, r3
	bxeq lr
	tst r1, #0x80000000
	bxeq lr
	movs r1, r1, lsl #1
	andeqs r1, r0, #1
	addne r0, r0, #1
	bx lr
_02109340:
	orr r0, r0, r1, lsl #12
	movs r1, r0
	mov r0, r2
	addne r0, r0, #1
	bx lr
_02109354:
	mov r0, r2
	bx lr
_0210935C:
	mov r0, #0xff000000
	orr r0, r2, r0, lsr #1
	bx lr
	arm_func_end _d2f

	.public _dfix
	.type _dfix, @function
	.public _d_dtoi
	.type _d_dtoi, @function
_dfix: // 0x02109368
_d_dtoi: // 0x02109368
	bic r3, r1, #0x80000000
	ldr r2, _021093B0 // =0x0000041E
	subs r2, r2, r3, lsr #20
	ble _021093A4
	cmp r2, #0x20
	bge _0210939C
	mov r3, r1, lsl #0xb
	orr r3, r3, #0x80000000
	orr r3, r3, r0, lsr #21
	cmp r1, #0
	mov r0, r3, lsr r2
	rsbmi r0, r0, #0
	bx lr
_0210939C:
	mov r0, #0
	bx lr
_021093A4:
	mvn r0, r1, asr #31
	add r0, r0, #0x80000000
	bx lr
	.align 2, 0
_021093B0: .word 0x0000041E

	arm_func_start _ll_ufrom_d
_ll_ufrom_d: // 0x021093B4
	tst r1, #0x80000000
	bne _02109418
	ldr r2, _0210943C // =0x0000043E
	subs r2, r2, r1, lsr #20
	blt _02109430
	cmp r2, #0x40
	bge _0210940C
	mov ip, r1, lsl #0xb
	orr ip, ip, #0x80000000
	orr ip, ip, r0, lsr #21
	cmp r2, #0x20
	ble _021093F4
	sub r2, r2, #0x20
	mov r1, #0
	mov r0, ip, lsr r2
	bx lr
_021093F4:
	mov r3, r0, lsl #0xb
	mov r1, ip, lsr r2
	mov r0, r3, lsr r2
	rsb r2, r2, #0x20
	orr r0, r0, ip, lsl r2
	bx lr
_0210940C:
	mov r1, #0
	mov r0, #0
	bx lr
_02109418:
	cmn r1, #0x100000
	cmpeq r0, #0
	bhi _02109430
	mov r1, #0
	mov r0, #0
	bx lr
_02109430:
	mvn r1, #0
	mvn r0, #0
	bx lr
	.align 2, 0
_0210943C: .word 0x0000043E
	arm_func_end _ll_ufrom_d

	.public _dflt
	.type _dflt, @function
	.public _d_itod
	.type _d_itod, @function
_dflt: // 0x02109440
_d_itod: // 0x02109440
	ands r2, r0, #0x80000000
	rsbmi r0, r0, #0
	cmp r0, #0
	mov r1, #0
	bxeq lr
	mov r3, #0x400
	add r3, r3, #0x1e
	clz ip, r0
	movs r0, r0, lsl ip
	sub r3, r3, ip
	movs r1, r0
	mov r0, r1, lsl #0x15
	add r1, r1, r1
	orr r1, r2, r1, lsr #12
	orr r1, r1, r3, lsl #20
	bx lr

	arm_func_start _dfltu
_dfltu: // 0x02109480
	cmp r0, #0
	mov r1, #0
	bxeq lr
	mov r3, #0x400
	add r3, r3, #0x1e
	bmi _021094A4
	clz ip, r0
	movs r0, r0, lsl ip
	sub r3, r3, ip
_021094A4:
	mov r1, r0
	mov r0, r1, lsl #0x15
	add r1, r1, r1
	mov r1, r1, lsr #0xc
	orr r1, r1, r3, lsl #20
	bx lr
	arm_func_end _dfltu

	.public _dmul
	.type _dmul, @function
	.public _d_mul
	.type _d_mul, @function
_dmul: // 0x021094BC
_d_mul: // 0x021094BC
	stmdb sp!, {r4, r5, r6, r7, lr}
	eor lr, r1, r3
	and lr, lr, #0x80000000
	mov ip, r1, lsr #0x14
	mov r1, r1, lsl #0xb
	orr r1, r1, r0, lsr #21
	mov r0, r0, lsl #0xb
	movs r6, ip, lsl #0x15
	cmnne r6, #0x200000
	beq _021095C4
	orr r1, r1, #0x80000000
	bic ip, ip, #0x800
	mov r4, r3, lsr #0x14
	mov r3, r3, lsl #0xb
	orr r3, r3, r2, lsr #21
	mov r2, r2, lsl #0xb
	movs r5, r4, lsl #0x15
	cmnne r5, #0x200000
	beq _0210960C
	orr r3, r3, #0x80000000
	bic r4, r4, #0x800
_02109510:
	add ip, r4, ip
	umull r5, r4, r0, r2
	umull r7, r6, r0, r3
	adds r4, r7, r4
	adc r6, r6, #0
	umull r7, r0, r1, r2
	adds r4, r7, r4
	adcs r0, r0, r6
	umull r7, r2, r1, r3
	adc r1, r2, #0
	adds r0, r0, r7
	adc r1, r1, #0
	orrs r4, r4, r5
	orrne r0, r0, #1
	cmp r1, #0
	blt _0210955C
	sub ip, ip, #1
	adds r0, r0, r0
	adc r1, r1, r1
_0210955C:
	add ip, ip, #2
	subs ip, ip, #0x400
	bmi _021096F8
	beq _021096F8
	mov r6, ip, lsl #0x14
	cmn r6, #0x100000
	bmi _021097F8
	movs r2, r0, lsl #0x15
	mov r0, r0, lsr #0xb
	orr r0, r0, r1, lsl #21
	add r1, r1, r1
	orr r1, lr, r1, lsr #12
	orr r1, r1, ip, lsl #20
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	tst r2, #0x80000000
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	movs r2, r2, lsl #1
	andeqs r2, r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	adds r0, r0, #1
	adc r1, r1, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_021095C4:
	bics ip, ip, #0x800
	beq _02109620
	orrs r6, r0, r1, lsl #1
	bne _021097AC
	mov r4, r3, lsr #0x14
	mov r3, r3, lsl #0xb
	orr r3, r3, r2, lsr #21
	mov r2, r2, lsl #0xb
	movs r5, r4, lsl #0x15
	beq _02109600
	cmn r5, #0x200000
	bne _02109798
	orrs r5, r2, r3, lsl #1
	beq _02109798
	b _021097AC
_02109600:
	orrs r5, r3, r2
	beq _021097C0
	b _02109798
_0210960C:
	bics r4, r4, #0x800
	beq _021096B4
	orrs r6, r2, r3, lsl #1
	bne _021097AC
	b _02109798
_02109620:
	orrs r6, r0, r1, lsl #1
	beq _02109688
	mov ip, #1
	cmp r1, #0
	bne _02109644
	sub ip, ip, #0x20
	movs r1, r0
	mov r0, #0
	bmi _02109660
_02109644:
	clz r6, r1
	movs r1, r1, lsl r6
	rsb r6, r6, #0x20
	orr r1, r1, r0, lsr r6
	rsb r6, r6, #0x20
	mov r0, r0, lsl r6
	sub ip, ip, r6
_02109660:
	mov r4, r3, lsr #0x14
	mov r3, r3, lsl #0xb
	orr r3, r3, r2, lsr #21
	mov r2, r2, lsl #0xb
	movs r5, r4, lsl #0x15
	cmnne r5, #0x200000
	beq _0210960C
	orr r3, r3, #0x80000000
	bic r4, r4, #0x800
	b _02109510
_02109688:
	mov r4, r3, lsr #0x14
	mov r3, r3, lsl #0xb
	orr r3, r3, r2, lsr #21
	mov r2, r2, lsl #0xb
	movs r5, r4, lsl #0x15
	beq _0210980C
	cmn r5, #0x200000
	bne _0210980C
	orrs r6, r2, r3, lsl #1
	beq _021097C0
	b _021097AC
_021096B4:
	orrs r5, r2, r3, lsl #1
	beq _0210980C
	mov r4, #1
	cmp r3, #0
	bne _021096D8
	sub r4, r4, #0x20
	movs r3, r2
	mov r2, #0
	bmi _02109510
_021096D8:
	clz r6, r3
	movs r3, r3, lsl r6
	rsb r6, r6, #0x20
	orr r3, r3, r2, lsr r6
	rsb r6, r6, #0x20
	mov r2, r2, lsl r6
	sub r4, r4, r6
	b _02109510
_021096F8:
	cmn ip, #0x34
	beq _02109790
	bmi _021097E8
	mov r2, r1
	mov r3, r0
	add r4, ip, #0x34
	cmp r4, #0x20
	movge r2, r3
	movge r3, #0
	subge r4, r4, #0x20
	rsb r5, r4, #0x20
	mov r2, r2, lsl r4
	orr r2, r2, r3, lsr r5
	movs r3, r3, lsl r4
	orrne r2, r2, #1
	rsb ip, ip, #0xc
	cmp ip, #0x20
	movge r0, r1
	movge r1, #0
	subge ip, ip, #0x20
	rsb r4, ip, #0x20
	mov r0, r0, lsr ip
	orr r0, r0, r1, lsl r4
	orr r1, lr, r1, lsr ip
	cmp r2, #0
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	tst r2, #0x80000000
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	movs r2, r2, lsl #1
	andeqs r2, r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	adds r0, r0, #1
	adc r1, r1, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_02109790:
	orr r0, r0, r1, lsl #1
	b _021097D0
_02109798:
	ldr r1, _0210981C // =0x7FF00000
	orr r1, lr, r1
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_021097AC:
	mov r1, r3
	mvn r0, #0
	bic r1, r0, #0x80000000
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_021097C0:
	mvn r0, #0
	bic r1, r0, #0x80000000
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_021097D0:
	movs r2, r0
	mov r1, lr
	mov r0, #0
	addne r0, r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_021097E8:
	mov r1, lr
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_021097F8:
	ldr r1, _0210981C // =0x7FF00000
	orr r1, lr, r1
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_0210980C:
	mov r1, lr
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_0210981C: .word 0x7FF00000

	arm_func_start _dsqrt
_dsqrt: // 0x02109820
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _021099B0 // =0x7FF00000
	cmp r1, r2
	bhs _0210996C
	movs ip, r1, lsr #0x14
	beq _02109918
	bic r1, r1, r2
	orr r1, r1, #0x100000
_02109840:
	movs ip, ip, asr #1
	bhs _02109854
	sub ip, ip, #1
	movs r0, r0, lsl #1
	adc r1, r1, r1
_02109854:
	movs r3, r0, lsl #1
	adc r1, r1, r1
	mov r2, #0
	mov r4, #0
	mov lr, #0x200000
_02109868:
	add r6, r4, lr
	cmp r6, r1
	addle r4, r6, lr
	suble r1, r1, r6
	addle r2, r2, lr
	movs r3, r3, lsl #1
	adc r1, r1, r1
	movs lr, lr, lsr #1
	bne _02109868
	mov r0, #0
	mov r5, #0
	cmp r1, r4
	cmpeq r3, #0x80000000
	blo _021098B0
	subs r3, r3, #0x80000000
	sbc r1, r1, r4
	add r4, r4, #1
	mov r0, #0x80000000
_021098B0:
	movs r3, r3, lsl #1
	adc r1, r1, r1
	mov lr, #0x40000000
_021098BC:
	add r6, r5, lr
	cmp r4, r1
	cmpeq r6, r3
	bhi _021098DC
	add r5, r6, lr
	subs r3, r3, r6
	sbc r1, r1, r4
	add r0, r0, lr
_021098DC:
	movs r3, r3, lsl #1
	adc r1, r1, r1
	movs lr, lr, lsr #1
	bne _021098BC
	orrs r1, r1, r3
	biceq r0, r0, #1
	movs r1, r2, lsr #1
	movs r0, r0, rrx
	adcs r0, r0, #0
	adc r1, r1, #0
	add r1, r1, #0x20000000
	sub r1, r1, #0x100000
	add r1, r1, ip, lsl #20
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_02109918:
	cmp r1, #0
	bne _02109948
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mvn ip, #0x13
	clz r5, r0
	movs r0, r0, lsl r5
	sub ip, ip, r5
	mov r1, r0, lsr #0xb
	mov r0, r0, lsl #0x15
	b _02109840
_02109948:
	clz r2, r1
	movs r1, r1, lsl r2
	rsb r2, r2, #0x2b
	mov r1, r1, lsr #0xb
	orr r1, r1, r0, lsr r2
	rsb r2, r2, #0x20
	mov r0, r0, lsl r2
	rsb ip, r2, #1
	b _02109840
_0210996C:
	tst r1, #0x80000000
	beq _02109988
	bics r3, r1, #0x80000000
	cmpeq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	b _02109994
_02109988:
	orrs r2, r0, r1, lsl #12
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
_02109994:
	ldr r2, _021099B4 // =0x7FF80000
	orr r1, r1, r2
	ldr r3, _021099B8 // =errno
	mov r4, #0x21
	str r4, [r3]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_021099B0: .word 0x7FF00000
_021099B4: .word 0x7FF80000
_021099B8: .word errno
	arm_func_end _dsqrt

	arm_func_start _drsb
_drsb: // 0x021099BC
	eor r1, r1, r3
	eor r3, r1, r3
	eor r1, r1, r3
	eor r0, r0, r2
	eor r2, r0, r2
	eor r0, r0, r2
	arm_func_end _drsb

	.public _dsub
	.type _dsub, @function
	.public _d_sub
	.type _d_sub, @function
_dsub: // 0x021099D4
_d_sub: // 0x021099D4
	stmdb sp!, {r4, lr}
	eors ip, r1, r3
	eormi r3, r3, #0x80000000
	bmi _02108F5C
_021099E4:
	subs ip, r0, r2
	sbcs lr, r1, r3
	bhs _02109A04
	eor lr, lr, #0x80000000
	adds r2, r2, ip
	adc r3, r3, lr
	subs r0, r0, ip
	sbc r1, r1, lr
_02109A04:
	mov lr, #0x80000000
	mov ip, r1, lsr #0x14
	orr r1, lr, r1, lsl #11
	orr r1, r1, r0, lsr #21
	mov r0, r0, lsl #0xb
	movs r4, ip, lsl #0x15
	cmnne r4, #0x200000
	beq _02109C08
	mov r4, r3, lsr #0x14
	orr r3, lr, r3, lsl #11
	orr r3, r3, r2, lsr #21
	mov r2, r2, lsl #0xb
	movs lr, r4, lsl #0x15
	beq _02109C50
_02109A3C:
	subs r4, ip, r4
	beq _02109AE4
	cmp r4, #0x20
	ble _02109A78
	cmp r4, #0x38
	movge r4, #0x3f
	sub r4, r4, #0x20
	rsb lr, r4, #0x20
	orrs lr, r2, r3, lsl lr
	mov r2, r3, lsr r4
	orrne r2, r2, #1
	subs r0, r0, r2
	sbcs r1, r1, #0
	bmi _02109AA0
	b _02109B90
_02109A78:
	rsb lr, r4, #0x20
	movs lr, r2, lsl lr
	rsb lr, r4, #0x20
	mov r2, r2, lsr r4
	orr r2, r2, r3, lsl lr
	mov r3, r3, lsr r4
	orrne r2, r2, #1
	subs r0, r0, r2
	sbcs r1, r1, r3
	bpl _02109B90
_02109AA0:
	movs r2, r0, lsl #0x15
	mov r0, r0, lsr #0xb
	orr r0, r0, r1, lsl #21
	add r1, r1, r1
	mov r1, r1, lsr #0xc
	orr r1, r1, ip, lsl #20
	tst r2, #0x80000000
	ldmeqia sp!, {r4, lr}
	bxeq lr
	movs r2, r2, lsl #1
	andeqs r2, r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	adds r0, r0, #1
	adc r1, r1, #0
	ldmia sp!, {r4, lr}
	bx lr
_02109AE4:
	subs r0, r0, r2
	sbc r1, r1, r3
	orrs lr, r1, r0
	beq _02109D74
	mov lr, ip, lsl #0x14
	and lr, lr, #0x80000000
	bic ip, ip, #0x800
	cmp r1, #0
	bmi _02109B6C
	bne _02109B1C
	sub ip, ip, #0x20
	movs r1, r0
	mov r0, #0
	bmi _02109B38
_02109B1C:
	clz r4, r1
	movs r1, r1, lsl r4
	rsb r4, r4, #0x20
	orr r1, r1, r0, lsr r4
	rsb r4, r4, #0x20
	mov r0, r0, lsl r4
	sub ip, ip, r4
_02109B38:
	cmp ip, #0
	bgt _02109B74
	rsb ip, ip, #0xc
	cmp ip, #0x20
	movge r0, r1
	movge r1, #0
	subge ip, ip, #0x20
	rsb r4, ip, #0x20
	mov r0, r0, lsr ip
	orr r0, r0, r1, lsl r4
	orr r1, lr, r1, lsr ip
	ldmia sp!, {r4, lr}
	bx lr
_02109B6C:
	cmp r1, #0
	subges ip, ip, #1
_02109B74:
	mov r0, r0, lsr #0xb
	orr r0, r0, r1, lsl #21
	add r1, r1, r1
	orr r1, lr, r1, lsr #12
	orr r1, r1, ip, lsl #20
	ldmia sp!, {r4, lr}
	bx lr
_02109B90:
	mov lr, ip, lsl #0x14
	and lr, lr, #0x80000000
	bic ip, ip, #0x800
	cmp r1, #0
	bne _02109BB4
	sub ip, ip, #0x20
	movs r1, r0
	mov r0, #0
	bmi _02109BD0
_02109BB4:
	clz r4, r1
	movs r1, r1, lsl r4
	rsb r4, r4, #0x20
	orr r1, r1, r0, lsr r4
	rsb r4, r4, #0x20
	mov r0, r0, lsl r4
	sub ip, ip, r4
_02109BD0:
	cmp ip, #0
	orrgt ip, ip, lr, lsr #20
	bgt _02109AA0
	rsb ip, ip, #0xc
	cmp ip, #0x20
	movge r0, r1
	movge r1, #0
	subge ip, ip, #0x20
	rsb r4, ip, #0x20
	mov r0, r0, lsr ip
	orr r0, r0, r1, lsl r4
	orr r1, lr, r1, lsr ip
	ldmia sp!, {r4, lr}
	bx lr
_02109C08:
	cmp ip, #0x800
	movge lr, #0x80000000
	movlt lr, #0
	bics ip, ip, #0x800
	beq _02109C74
	orrs r4, r0, r1, lsl #1
	bne _02109D50
	mov r4, r3, lsr #0x14
	mov r3, r3, lsl #0xb
	orr r3, r3, r2, lsr #21
	mov r2, r2, lsl #0xb
	movs r4, r4, lsl #0x15
	beq _02109D3C
	cmn r4, #0x200000
	bne _02109D3C
	orrs r4, r2, r3, lsl #1
	beq _02109D64
	b _02109D50
_02109C50:
	cmp r4, #0x800
	movge lr, #0x80000000
	movlt lr, #0
	bic ip, ip, #0x800
	bics r4, r4, #0x800
	beq _02109CEC
	orrs r4, r2, r3, lsl #1
	bne _02109D50
	b _02109D3C
_02109C74:
	orrs r4, r0, r1, lsl #1
	beq _02109CB4
	mov ip, #1
	bic r1, r1, #0x80000000
	mov r4, r3, lsr #0x14
	mov r3, r3, lsl #0xb
	orr r3, r3, r2, lsr #21
	mov r2, r2, lsl #0xb
	movs r4, r4, lsl #0x15
	cmnne r4, #0x200000
	mov r4, r4, lsr #0x15
	orr r4, r4, lr, lsr #20
	beq _02109C50
	orr r3, r3, #0x80000000
	orr ip, ip, lr, lsr #20
	b _02109A3C
_02109CB4:
	mov ip, r3, lsr #0x14
	mov r1, r3, lsl #0xb
	orr r1, r1, r2, lsr #21
	mov r0, r2, lsl #0xb
	movs r4, ip, lsl #0x15
	beq _02109CE0
	cmn r4, #0x200000
	bne _02109D08
	orrs r4, r0, r1, lsl #1
	bne _02109D54
	b _02109D3C
_02109CE0:
	orrs r4, r0, r1, lsl #1
	beq _02109D74
	b _02109D08
_02109CEC:
	orrs r4, r2, r3, lsl #1
	beq _02109D18
	mov r4, #1
	bic r3, r3, #0x80000000
	orr ip, ip, lr, lsr #20
	orr r4, r4, lr, lsr #20
	b _02109A3C
_02109D08:
	mov r1, r3
	mov r0, r2
	ldmia sp!, {r4, lr}
	bx lr
_02109D18:
	cmp r1, #0
	subges ip, ip, #1
	mov r0, r0, lsr #0xb
	orr r0, r0, r1, lsl #21
	add r1, r1, r1
	orr r1, lr, r1, lsr #12
	orr r1, r1, ip, lsl #20
	ldmia sp!, {r4, lr}
	bx lr
_02109D3C:
	ldr r1, _02109D84 // =0x7FF00000
	orr r1, lr, r1
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_02109D50:
	mov r1, r3
_02109D54:
	mvn r0, #0
	bic r1, r0, #0x80000000
	ldmia sp!, {r4, lr}
	bx lr
_02109D64:
	mvn r0, #0
	bic r1, r0, #0x80000000
	ldmia sp!, {r4, lr}
	bx lr
_02109D74:
	mov r1, #0
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_02109D84: .word 0x7FF00000

	arm_func_start _fadd
	arm_func_start _f_add
_fadd: // 0x02109D88
_f_add: // 0x02109D88
	eors r2, r0, r1
	eormi r1, r1, #0x80000000
	bmi __fsub_start
__fadd_start:
	subs ip, r0, r1
	sublo r0, r0, ip
	addlo r1, r1, ip
	mov r2, #0x80000000
	mov r3, r0, lsr #0x17
	orr r0, r2, r0, lsl #8
	ands ip, r3, #0xff
	cmpne ip, #0xff
	beq _02109E28
	mov ip, r1, lsr #0x17
	orr r1, r2, r1, lsl #8
	ands r2, ip, #0xff
	beq _02109E68
_02109DC8:
	subs ip, r3, ip
	beq _02109DE0
	rsb r2, ip, #0x20
	movs r2, r1, lsl r2
	mov r1, r1, lsr ip
	orrne r1, r1, #1
_02109DE0:
	adds r0, r0, r1
	blo _02109E00
	and r1, r0, #1
	orr r0, r1, r0, rrx
	add r3, r3, #1
	and r2, r3, #0xff
	cmp r2, #0xff
	beq _02109F70
_02109E00:
	ands r1, r0, #0xff
	add r0, r0, r0
	mov r0, r0, lsr #9
	orr r0, r0, r3, lsl #23
	tst r1, #0x80
	bxeq lr
	ands r1, r1, #0x7f
	andeqs r1, r0, #1
	addne r0, r0, #1
	bx lr
_02109E28:
	cmp r3, #0x100
	movge r2, #0x80000000
	movlt r2, #0
	ands r3, r3, #0xff
	beq _02109E8C
	movs r0, r0, lsl #1
	bne _02109F9C
	mov ip, r1, lsr #0x17
	mov r1, r1, lsl #9
	ands ip, ip, #0xff
	beq _02109F90
	cmp ip, #0xff
	blt _02109F90
	cmp r1, #0
	beq _02109F90
	b _02109F9C
_02109E68:
	cmp r3, #0x100
	movge r2, #0x80000000
	movlt r2, #0
	and r3, r3, #0xff
	ands ip, ip, #0xff
	beq _02109EE8
_02109E80:
	movs r1, r1, lsl #1
	bne _02109F9C
	b _02109F90
_02109E8C:
	movs r0, r0, lsl #1
	beq _02109EC4
	mov r3, #1
	mov r0, r0, lsr #1
	mov ip, r1, lsr #0x17
	mov r1, r1, lsl #8
	ands ip, ip, #0xff
	beq _02109EE8
	cmp ip, #0xff
	beq _02109E80
	orr r1, r1, #0x80000000
	orr r3, r3, r2, lsr #23
	orr ip, ip, r2, lsr #23
	b _02109DC8
_02109EC4:
	mov r3, r1, lsr #0x17
	mov r0, r1, lsl #9
	ands r3, r3, #0xff
	beq _02109F50
	cmp r3, #0xff
	blt _02109F50
	cmp r0, #0
	beq _02109F90
	b _02109F88
_02109EE8:
	movs r1, r1, lsl #1
	beq _02109F58
	mov r1, r1, lsr #1
	mov ip, #1
	orr r3, r3, r2, lsr #23
	orr ip, ip, r2, lsr #23
	cmp r0, #0
	bmi _02109DC8
	adds r0, r0, r1
	blo _02109F1C
	and r1, r0, #1
	orr r0, r1, r0, rrx
	add ip, ip, #1
_02109F1C:
	cmp r0, #0
	subge ip, ip, #1
	ands r1, r0, #0xff
	add r0, r0, r0
	mov r0, r0, lsr #9
	orr r0, r0, ip, lsl #23
	bxeq lr
	tst r1, #0x80
	bxeq lr
	ands r1, r1, #0x7f
	andeqs r1, r0, #1
	addne r0, r0, #1
	bx lr
_02109F50:
	mov r0, r1
	bx lr
_02109F58:
	cmp r0, #0
	subges r3, r3, #1
	add r0, r0, r0
	orr r0, r2, r0, lsr #9
	orr r0, r0, r3, lsl #23
	bx lr
_02109F70:
	cmp r3, #0x100
	movge r2, #0x80000000
	movlt r2, #0
	mov r0, #0xff000000
	orr r0, r2, r0, lsr #1
	bx lr
_02109F88:
	mvn r0, #0x80000000
	bx lr
_02109F90:
	mov r0, #0xff000000
	orr r0, r2, r0, lsr #1
	bx lr
_02109F9C:
	mvn r0, #0x80000000
	bx lr
	mvn r0, #0x80000000
	bx lr

	.public _dgeq
	.type _dgeq, @function
	.public _d_fge
	.type _d_fge, @function
_dgeq: // 0x02109FAC
_d_fge: // 0x02109FAC
	mov ip, #0x200000
	cmn ip, r1, lsl #1
	bhs _0210A020
	cmn ip, r3, lsl #1
	bhs _0210A034
_02109FC0:
	orrs ip, r3, r1
	bmi _02109FF0
	cmp r1, r3
	cmpeq r0, r2
	movhi r0, #1
	movls r0, #0
	bx lr
_02109FDC:
	mov r0, #0
	mrs ip, cpsr
	bic ip, ip, #0x20000000
	msr CPSR_f, ip
	bx lr
_02109FF0:
	orr ip, r0, ip, lsl #1
	orrs ip, ip, r2
	moveq r0, #0
	mrs ip, cpsr
	bic ip, ip, #0x20000000
	msr CPSR_f, ip
	bxeq lr
	cmp r3, r1
	cmpeq r2, r0
	movhi r0, #1
	movls r0, #0
	bx lr
_0210A020:
	bne _02109FDC
	cmp r0, #0
	bhi _02109FDC
	cmn ip, r3, lsl #1
	blo _02109FC0
_0210A034:
	bne _02109FDC
	cmp r2, #0
	bhi _02109FDC
	b _02109FC0

	.public _dgr
	.type _dgr, @function
	.public _d_fgt
	.type _d_fgt, @function
_dgr: // 0x0210A044
_d_fgt: // 0x0210A044
	mov ip, #0x200000
	cmn ip, r1, lsl #1
	bhs _0210A0C4
	cmn ip, r3, lsl #1
	bhs _0210A0D8
_0210A058:
	orrs ip, r3, r1
	bmi _0210A08C
	cmp r1, r3
	cmpeq r0, r2
	movls r0, #1
	movhi r0, #0
	bx lr
_0210A074:
	mov r0, #0
	mrs ip, cpsr
	bic ip, ip, #0x40000000
	orr ip, ip, #0x20000000
	msr CPSR_f, ip
	bx lr
_0210A08C:
	orr ip, r0, ip, lsl #1
	orrs ip, ip, r2
	moveq r0, #1
	bne _0210A0B0
	mrs ip, cpsr
	bic ip, ip, #0x20000000
	orr ip, ip, #0x40000000
	msr CPSR_f, ip
	bxeq lr
_0210A0B0:
	cmp r3, r1
	cmpeq r2, r0
	movls r0, #1
	movhi r0, #0
	bx lr
_0210A0C4:
	bne _0210A074
	cmp r0, #0
	bhi _0210A074
	cmn ip, r3, lsl #1
	blo _0210A058
_0210A0D8:
	bne _0210A074
	cmp r2, #0
	bhi _0210A074
	b _0210A058

	.public _dleq
	.type _dleq, @function
	.public _d_fle
	.type _d_fle, @function
_dleq: // 0x0210A0E8
_d_fle: // 0x0210A0E8
	mov ip, #0x200000
	cmn ip, r1, lsl #1
	bhs _0210A160
	cmn ip, r3, lsl #1
	bhs _0210A174
_0210A0FC:
	orrs ip, r3, r1
	bmi _0210A12C
	cmp r1, r3
	cmpeq r0, r2
	movlo r0, #1
	movhs r0, #0
	bx lr
_0210A118:
	mov r0, #0
	mrs ip, cpsr
	orr ip, ip, #0x20000000
	msr CPSR_f, ip
	bx lr
_0210A12C:
	orr ip, r0, ip, lsl #1
	orrs ip, ip, r2
	moveq r0, #0
	bne _0210A14C
	mrs ip, cpsr
	orr ip, ip, #0x20000000
	msr CPSR_f, ip
	bxeq lr
_0210A14C:
	cmp r3, r1
	cmpeq r2, r0
	movlo r0, #1
	movhs r0, #0
	bx lr
_0210A160:
	bne _0210A118
	cmp r0, #0
	bhi _0210A118
	cmn ip, r3, lsl #1
	blo _0210A0FC
_0210A174:
	bne _0210A118
	cmp r2, #0
	bhi _0210A118
	b _0210A0FC

	.public _dls
	.type _dls, @function
	.public _d_flt
	.type _d_flt, @function
_dls: // 0x0210A184
_d_flt: // 0x0210A184
	mov ip, #0x200000
	cmn ip, r1, lsl #1
	bhs _0210A1EC
	cmn ip, r3, lsl #1
	bhs _0210A200
_0210A198:
	orrs ip, r3, r1
	bmi _0210A1C8
	cmp r1, r3
	cmpeq r0, r2
	moveq r0, #1
	movne r0, #0
	bx lr
_0210A1B4:
	mov r0, #0
	mrs ip, cpsr
	bic ip, ip, #0x40000000
	msr CPSR_f, ip
	bx lr
_0210A1C8:
	orr ip, r0, ip, lsl #1
	orrs ip, ip, r2
	moveq r0, #1
	bxeq lr
	cmp r3, r1
	cmpeq r2, r0
	moveq r0, #1
	movne r0, #0
	bx lr
_0210A1EC:
	bne _0210A1B4
	cmp r0, #0
	bhi _0210A1B4
	cmn ip, r3, lsl #1
	blo _0210A198
_0210A200:
	bne _0210A1B4
	cmp r2, #0
	bhi _0210A1B4
	b _0210A198

	.public _dneq
	.type _dneq, @function
	.public _d_fne
	.type _d_fne, @function
_dneq: // 0x0210A210
_d_fne: // 0x0210A210
	mov ip, #0x200000
	cmn ip, r1, lsl #1
	bhs _0210A278
	cmn ip, r3, lsl #1
	bhs _0210A28C
_0210A224:
	orrs ip, r3, r1
	bmi _0210A254
	cmp r1, r3
	cmpeq r0, r2
	movne r0, #1
	moveq r0, #0
	bx lr
_0210A240:
	mov r0, #1
	mrs ip, cpsr
	bic ip, ip, #0x40000000
	msr CPSR_f, ip
	bx lr
_0210A254:
	orr ip, r0, ip, lsl #1
	orrs ip, ip, r2
	moveq r0, #0
	bxeq lr
	cmp r3, r1
	cmpeq r2, r0
	movne r0, #1
	moveq r0, #0
	bx lr
_0210A278:
	bne _0210A240
	cmp r0, #0
	bhi _0210A240
	cmn ip, r3, lsl #1
	blo _0210A224
_0210A28C:
	bne _0210A240
	cmp r2, #0
	bhi _0210A240
	b _0210A224

	arm_func_start _fgr
_fgr: // 0x0210A29C
	mov r3, #0xff000000
	cmp r3, r0, lsl #1
	cmphs r3, r1, lsl #1
	blo _0210A2E4
	cmp r0, #0
	bicmi r0, r0, #0x80000000
	rsbmi r0, r0, #0
	cmp r1, #0
	bicmi r1, r1, #0x80000000
	rsbmi r1, r1, #0
	cmp r0, r1
	movgt r0, #1
	movle r0, #0
	mrs ip, cpsr
	bicle ip, ip, #0x20000000
	orrgt ip, ip, #0x20000000
	msr CPSR_f, ip
	bx lr
_0210A2E4:
	mov r0, #0
	mrs ip, cpsr
	bic ip, ip, #0x20000000
	msr CPSR_f, ip
	bx lr
	arm_func_end _fgr

	arm_func_start _fls
_fls: // 0x0210A2F8
	mov r3, #0xff000000
	cmp r3, r0, lsl #1
	cmphs r3, r1, lsl #1
	blo _0210A340
	cmp r0, #0
	bicmi r0, r0, #0x80000000
	rsbmi r0, r0, #0
	cmp r1, #0
	bicmi r1, r1, #0x80000000
	rsbmi r1, r1, #0
	cmp r0, r1
	movlt r0, #1
	movge r0, #0
	mrs ip, cpsr
	orrge ip, ip, #0x20000000
	biclt ip, ip, #0x20000000
	msr CPSR_f, ip
	bx lr
_0210A340:
	mov r0, #0
	mrs ip, cpsr
	orr ip, ip, #0x20000000
	msr CPSR_f, ip
	bx lr
	arm_func_end _fls

	arm_func_start _fneq
_fneq: // 0x0210A354
	mov r3, #0xff000000
	cmp r3, r0, lsl #1
	blo _0210A3A8
	cmp r3, r1, lsl #1
	blo _0210A3A8
	orr r3, r0, r1
	movs r3, r3, lsl #1
	moveq r0, #0
	bne _0210A388
	mrs ip, cpsr
	orr ip, ip, #0x40000000
	msr CPSR_f, ip
	bx lr
_0210A388:
	cmp r0, r1
	movne r0, #1
	moveq r0, #0
	mrs ip, cpsr
	bicne ip, ip, #0x40000000
	orreq ip, ip, #0x40000000
	msr CPSR_f, ip
	bx lr
_0210A3A8:
	mov r0, #1
	mrs ip, cpsr
	bic ip, ip, #0x40000000
	msr CPSR_f, ip
	bx lr
	arm_func_end _fneq

	arm_func_start _frdiv
_frdiv: // 0x0210A3BC
	eor r0, r0, r1
	eor r1, r0, r1
	eor r0, r0, r1
	arm_func_end _frdiv

	arm_func_start _fdiv
_fdiv: // 0x0210A3C8
	stmdb sp!, {lr}
	mov ip, #0xff
	ands r3, ip, r0, lsr #23
	cmpne r3, #0xff
	beq _0210A59C
	ands ip, ip, r1, lsr #23
	cmpne ip, #0xff
	beq _0210A5D8
	orr r1, r1, #0x800000
	orr r0, r0, #0x800000
	bic r2, r0, #0xff000000
	bic lr, r1, #0xff000000
_0210A3F8:
	cmp r2, lr
	movlo r2, r2, lsl #1
	sublo r3, r3, #1
	teq r0, r1
	sub r0, pc, #0x94
	ldrb r1, [r0, lr, lsr #15]
	rsb lr, lr, #0
	mov r0, lr, asr #1
	mul r0, r1, r0
	add r0, r0, #0x80000000
	mov r0, r0, lsr #6
	mul r0, r1, r0
	mov r0, r0, lsr #0xe
	mul r1, lr, r0
	sub ip, r3, ip
	mov r1, r1, lsr #0xc
	mul r1, r0, r1
	mov r0, r0, lsl #0xe
	add r0, r0, r1, lsr #15
	umull r1, r0, r2, r0
	mov r3, r0
	orrmi r0, r0, #0x80000000
	adds ip, ip, #0x7e
	bmi _0210A6A0
	cmp ip, #0xfe
	bge _0210A754
	add r0, r0, ip, lsl #23
	mov ip, r1, lsr #0x1c
	cmp ip, #7
	beq _0210A57C
	add r0, r0, r1, lsr #31
	ldmia sp!, {lr}
	bx lr

_0210A47C: // 0x0210A47C
	.byte 0xFF, 0xFF, 0xFE, 0xFD
	.byte 0xFC, 0xFB, 0xFA, 0xF9, 0xF8, 0xF7, 0xF6, 0xF5, 0xF4, 0xF3, 0xF2, 0xF1, 0xF0, 0xF0, 0xEF, 0xEE
	.byte 0xED, 0xEC, 0xEB, 0xEA, 0xEA, 0xE9, 0xE8, 0xE7, 0xE6, 0xE6, 0xE5, 0xE4, 0xE3, 0xE2, 0xE2, 0xE1
	.byte 0xE0, 0xDF, 0xDF, 0xDE, 0xDD, 0xDC, 0xDC, 0xDB, 0xDA, 0xD9, 0xD9, 0xD8, 0xD7, 0xD7, 0xD6, 0xD5
	.byte 0xD4, 0xD4, 0xD3, 0xD2, 0xD2, 0xD1, 0xD0, 0xD0, 0xCF, 0xCE, 0xCE, 0xCD, 0xCC, 0xCC, 0xCB, 0xCB
	.byte 0xCA, 0xC9, 0xC9, 0xC8, 0xC8, 0xC7, 0xC6, 0xC6, 0xC5, 0xC5, 0xC4, 0xC3, 0xC3, 0xC2, 0xC2, 0xC1
	.byte 0xC0, 0xC0, 0xBF, 0xBF, 0xBE, 0xBE, 0xBD, 0xBD, 0xBC, 0xBC, 0xBB, 0xBA, 0xBA, 0xB9, 0xB9, 0xB8
	.byte 0xB8, 0xB7, 0xB7, 0xB6, 0xB6, 0xB5, 0xB5, 0xB4, 0xB4, 0xB3, 0xB3, 0xB2, 0xB2, 0xB1, 0xB1, 0xB0
	.byte 0xB0, 0xAF, 0xAF, 0xAF, 0xAE, 0xAE, 0xAD, 0xAD, 0xAC, 0xAC, 0xAB, 0xAB, 0xAA, 0xAA, 0xAA, 0xA9
	.byte 0xA9, 0xA8, 0xA8, 0xA7, 0xA7, 0xA7, 0xA6, 0xA6, 0xA5, 0xA5, 0xA4, 0xA4, 0xA4, 0xA3, 0xA3, 0xA2
	.byte 0xA2, 0xA2, 0xA1, 0xA1, 0xA0, 0xA0, 0xA0, 0x9F, 0x9F, 0x9E, 0x9E, 0x9E, 0x9D, 0x9D, 0x9D, 0x9C
	.byte 0x9C, 0x9B, 0x9B, 0x9B, 0x9A, 0x9A, 0x9A, 0x99, 0x99, 0x99, 0x98, 0x98, 0x98, 0x97, 0x97, 0x96
	.byte 0x96, 0x96, 0x95, 0x95, 0x95, 0x94, 0x94, 0x94, 0x93, 0x93, 0x93, 0x92, 0x92, 0x92, 0x91, 0x91
	.byte 0x91, 0x91, 0x90, 0x90, 0x90, 0x8F, 0x8F, 0x8F, 0x8E, 0x8E, 0x8E, 0x8D, 0x8D, 0x8D, 0x8C, 0x8C
	.byte 0x8C, 0x8C, 0x8B, 0x8B, 0x8B, 0x8A, 0x8A, 0x8A, 0x8A, 0x89, 0x89, 0x89, 0x88, 0x88, 0x88, 0x88
	.byte 0x87, 0x87, 0x87, 0x86, 0x86, 0x86, 0x86, 0x85, 0x85, 0x85, 0x85, 0x84, 0x84, 0x84, 0x83, 0x83
	.byte 0x83, 0x83, 0x82, 0x82, 0x82, 0x82, 0x81, 0x81, 0x81, 0x81, 0x80, 0x80

_0210A57C:
	mov r1, r3, lsl #1
	add r1, r1, #1
	rsb lr, lr, #0
	mul r1, lr, r1
	cmp r1, r2, lsl #24
	addmi r0, r0, #1
	ldmia sp!, {lr}
	bx lr
	
_0210A59C:
	eor lr, r0, r1
	and lr, lr, #0x80000000
	cmp r3, #0
	beq _0210A5F4
	movs r0, r0, lsl #9
	bne _0210A73C
	mov ip, r1, lsr #0x17
	mov r1, r1, lsl #9
	ands ip, ip, #0xff
	beq _0210A72C
	cmp ip, #0xff
	blt _0210A72C
	cmp r1, #0
	beq _0210A748
	b _0210A724
_0210A5D8:
	eor lr, r0, r1
	and lr, lr, #0x80000000
	cmp ip, #0
	beq _0210A658
_0210A5E8:
	movs r1, r1, lsl #9
	bne _0210A724
	b _0210A774
_0210A5F4:
	movs r2, r0, lsl #9
	beq _0210A628
	clz r3, r2
	movs r2, r2, lsl r3
	rsb r3, r3, #0
	mov r2, r2, lsr #8
	ands ip, ip, r1, lsr #23
	beq _0210A680
	cmp ip, #0xff
	beq _0210A5E8
	orr r1, r1, #0x800000
	bic lr, r1, #0xff000000
	b _0210A3F8
_0210A628:
	mov ip, r1, lsr #0x17
	mov r1, r1, lsl #9
	ands ip, ip, #0xff
	beq _0210A64C
	cmp ip, #0xff
	blt _0210A774
	cmp r1, #0
	beq _0210A774
	b _0210A724
_0210A64C:
	cmp r1, #0
	beq _0210A748
	b _0210A774
_0210A658:
	movs ip, r1, lsl #9
	beq _0210A72C
	mov lr, ip
	clz ip, lr
	movs lr, lr, lsl ip
	rsb ip, ip, #0
	mov lr, lr, lsr #8
	orr r0, r0, #0x800000
	bic r2, r0, #0xff000000
	b _0210A3F8
_0210A680:
	movs ip, r1, lsl #9
	beq _0210A72C
	mov lr, ip
	clz ip, lr
	movs lr, lr, lsl ip
	rsb ip, ip, #0
	mov lr, lr, lsr #8
	b _0210A3F8
_0210A6A0:
	and r0, r0, #0x80000000
	cmn ip, #0x18
	beq _0210A714
	bmi _0210A76C
	add r1, ip, #0x17
	mov r2, r2, lsl r1
	rsb ip, ip, #0
	mov r3, r3, lsr ip
	orr r0, r0, r3
	rsb lr, lr, #0
	mul r1, lr, r3
	cmp r1, r2
	ldmeqia sp!, {lr}
	bxeq lr
	add r1, r1, lr
	cmp r1, r2
	beq _0210A708
	addmi r0, r0, #1
	subpl r1, r1, lr
	add r1, lr, r1, lsl #1
	cmp r1, r2, lsl #1
	and r3, r0, #1
	addmi r0, r0, #1
	addeq r0, r0, r3
	ldmia sp!, {lr}
	bx lr

_0210A708:
	add r0, r0, #1
	ldmia sp!, {lr}
	bx lr

_0210A714:
	cmn r2, lr
	addne r0, r0, #1
	ldmia sp!, {lr}
	bx lr

_0210A724:
	mov r0, r1
	b _0210A73C
_0210A72C:
	mov r0, #0xff000000
	orr r0, lr, r0, lsr #1
	ldmia sp!, {lr}
	bx lr
	
_0210A73C:
	mvn r0, #0x80000000
	ldmia sp!, {lr}
	bx lr
	
_0210A748:
	mvn r0, #0x80000000
	ldmia sp!, {lr}
	bx lr
	
_0210A754:
	tst r0, #0x80000000
	mov r0, #0xff000000
	movne r0, r0, asr #1
	moveq r0, r0, lsr #1
	ldmia sp!, {lr}
	bx lr
	
_0210A76C:
	ldmia sp!, {lr}
	bx lr
	
_0210A774:
	mov r0, lr
	ldmia sp!, {lr}
	bx lr
	arm_func_end _fdiv

	arm_func_start _f2d
_f2d: // 0x0210A780
	and r2, r0, #0x80000000
	mov ip, r0, lsr #0x17
	mov r3, r0, lsl #9
	ands ip, ip, #0xff
	beq _0210A7B0
	cmp ip, #0xff
	beq _0210A7DC
_0210A79C:
	add ip, ip, #0x380
	mov r0, r3, lsl #0x14
	orr r1, r2, r3, lsr #12
	orr r1, r1, ip, lsl #20
	bx lr
_0210A7B0:
	cmp r3, #0
	bne _0210A7C4
	mov r1, r2
	mov r0, #0
	bx lr
_0210A7C4:
	mov r3, r3, lsr #1
	clz ip, r3
	movs r3, r3, lsl ip
	rsb ip, ip, #1
	add r3, r3, r3
	b _0210A79C
_0210A7DC:
	cmp r3, #0
	bhi _0210A7F4
	ldr r1, _0210A800 // =0x7FF00000
	orr r1, r1, r2
	mov r0, #0
	bx lr
_0210A7F4:
	mvn r0, #0
	bic r1, r0, #0x80000000
	bx lr
	.align 2, 0
_0210A800: .word 0x7FF00000
	arm_func_end _f2d

	.public _f_ftoi
	.type _f_ftoi, @function
	.public _ffix
	.type _ffix, @function
_f_ftoi: // 0x0210A804
_ffix: // 0x0210A804
	bic r1, r0, #0x80000000
	mov r2, #0x9e
	subs r2, r2, r1, lsr #23
	ble _0210A82C
	mov r1, r1, lsl #8
	orr r1, r1, #0x80000000
	cmp r0, #0
	mov r0, r1, lsr r2
	rsbmi r0, r0, #0
	bx lr
_0210A82C:
	mvn r0, r0, asr #31
	add r0, r0, #0x80000000
	bx lr

	.public _ffixu
	.type _ffixu, @function
	.public _f_ftou
	.type _f_ftou, @function
_ffixu: // 0x0210A838
_f_ftou: // 0x0210A838
	tst r0, #0x80000000
	bne _0210A85C
	mov r1, #0x9e
	subs r1, r1, r0, lsr #23
	blt _0210A870
	mov r2, r0, lsl #8
	orr r0, r2, #0x80000000
	mov r0, r0, lsr r1
	bx lr
_0210A85C:
	mov r2, #0xff000000
	cmp r2, r0, lsl #1
	movhs r0, #0
	mvnlo r0, #0
	bx lr
_0210A870:
	mvn r0, #0
	bx lr

	arm_func_start _ll_ufrom_f
_ll_ufrom_f: // 0x0210A878
	tst r0, #0x80000000
	bne _0210A8BC
	mov r2, #0xbe
	subs r2, r2, r0, lsr #23
	blt _0210A8D4
	mov r3, r0, lsl #8
	orr r3, r3, #0x80000000
	cmp r2, #0x20
	bgt _0210A8AC
	mov r1, r3, lsr r2
	rsb r2, r2, #0x20
	mov r0, r3, lsl r2
	bx lr
_0210A8AC:
	sub r2, r2, #0x20
	mov r1, #0
	mov r0, r3, lsr r2
	bx lr
_0210A8BC:
	mov r2, #0xff000000
	cmp r2, r0, lsl #1
	blo _0210A8D4
	mov r1, #0
	mov r0, #0
	bx lr
_0210A8D4:
	mvn r1, #0
	mvn r0, #0
	bx lr
	arm_func_end _ll_ufrom_f

	.public _fflt
	.type _fflt, @function
	.public _f_itof
	.type _f_itof, @function
_fflt: // 0x0210A8E0
_f_itof: // 0x0210A8E0
	ands r2, r0, #0x80000000
	rsbmi r0, r0, #0
	cmp r0, #0
	bxeq lr
	clz r3, r0
	movs r0, r0, lsl r3
	rsb r3, r3, #0x9e
	ands r1, r0, #0xff
	add r0, r0, r0
	orr r0, r2, r0, lsr #9
	orr r0, r0, r3, lsl #23
	bxeq lr
	tst r1, #0x80
	bxeq lr
	ands r3, r1, #0x7f
	andeqs r3, r0, #1
	addne r0, r0, #1
	bx lr

	.public _ffltu
	.type _ffltu, @function
	.public _f_utof
	.type _f_utof, @function
_ffltu: // 0x0210A928
_f_utof: // 0x0210A928
	cmp r0, #0
__f_utof_common:
	bxeq lr
	mov r3, #0x9e
	bmi _0210A944
	clz ip, r0
	movs r0, r0, lsl ip
	sub r3, r3, ip
_0210A944:
	ands r2, r0, #0xff
	add r0, r0, r0
	mov r0, r0, lsr #9
	orr r0, r0, r3, lsl #23
	bxeq lr
	tst r2, #0x80
	bxeq lr
	ands r1, r2, #0x7f
	andeqs r1, r0, #1
	addne r0, r0, #1
	bx lr
	arm_func_end _f_utof

	.public _f_ulltof
	.type _f_ulltof, @function
	.public _ll_uto_f
	.type _ll_uto_f, @function
_f_ulltof: // 0x0210A970
_ll_uto_f: // 0x0210A970
	cmp r1, #0
	bne _0210A980
	movs r0, r0
	b __f_utof_common
_0210A980:
	mov r3, #0x20
	bmi _0210A9A0
	clz ip, r1
	movs r1, r1, lsl ip
	sub r3, r3, ip
	orr r1, r1, r0, lsr r3
	rsb r2, r3, #0x20
	mov r0, r0, lsl r2
_0210A9A0:
	cmp r0, #0
	orrne r1, r1, #1
	add r3, r3, #0x9e
	ands r2, r1, #0xff
	add r0, r1, r1
	mov r0, r0, lsr #9
	orr r0, r0, r3, lsl #23
	bxeq lr
	tst r2, #0x80
	bxeq lr
	ands r1, r2, #0x7f
	andeqs r1, r0, #1
	addne r0, r0, #1
	bx lr

	.public _fmul
	.type _fmul, @function
	.public _f_mul
	.type _f_mul, @function
_fmul: // 0x0210A9D8
_f_mul: // 0x0210A9D8
	eor r2, r0, r1
	and r2, r2, #0x80000000
	mov ip, #0xff
	ands r3, ip, r0, lsr #23
	mov r0, r0, lsl #8
	cmpne r3, #0xff
	beq _0210AA54
	orr r0, r0, #0x80000000
	ands ip, ip, r1, lsr #23
	mov r1, r1, lsl #8
	cmpne ip, #0xff
	beq _0210AA94
	orr r1, r1, #0x80000000
_0210AA0C:
	add ip, r3, ip
	umull r1, r3, r0, r1
	movs r0, r3
	addpl r0, r0, r0
	subpl ip, ip, #1
	subs ip, ip, #0x7f
	bmi _0210AB20
	cmp ip, #0xfe
	bge _0210AB8C
	ands r3, r0, #0xff
	orr r0, r2, r0, lsr #8
	add r0, r0, ip, lsl #23
	tst r3, #0x80
	bxeq lr
	orrs r1, r1, r3, lsl #25
	andeqs r3, r0, #1
	addne r0, r0, #1
	bx lr
_0210AA54:
	cmp r3, #0
	beq _0210AAA8
	movs r0, r0, lsl #1
	bne __f_result_x_NaN
	mov ip, r1, lsr #0x17
	mov r1, r1, lsl #9
	ands ip, ip, #0xff
	beq _0210AA88
	cmp ip, #0xff
	blt __f_result_INF
	cmp r1, #0
	beq __f_result_INF
	b __f_result_x_NaN
_0210AA88:
	cmp r1, #0
	beq __f_result_invalid
	b __f_result_INF
_0210AA94:
	cmp ip, #0
	beq _0210AB04
_0210AA9C:
	movs r1, r1, lsl #1
	bne __f_result_x_NaN
	b __f_result_INF
_0210AAA8:
	movs r0, r0, lsl #1
	beq _0210AAE0
	mov r0, r0, lsr #1
	clz r3, r0
	movs r0, r0, lsl r3
	rsb r3, r3, #1
	mov ip, r1, lsr #0x17
	mov r1, r1, lsl #8
	ands ip, ip, #0xff
	beq _0210AB04
	cmp ip, #0xff
	beq _0210AA9C
	orr r1, r1, #0x80000000
	b _0210AA0C
_0210AAE0:
	mov ip, r1, lsr #0x17
	mov r1, r1, lsl #9
	ands ip, ip, #0xff
	beq _0210ABB0
	cmp ip, #0xff
	blt _0210ABB0
	cmp r1, #0
	beq __f_result_invalid
	b __f_result_x_NaN
_0210AB04:
	movs r1, r1, lsl #1
	beq _0210ABB0
	mov r1, r1, lsr #1
	clz ip, r1
	movs r1, r1, lsl ip
	rsb ip, ip, #1
	b _0210AA0C
_0210AB20:
	cmn ip, #0x18
	beq _0210AB68
	bmi _0210ABA8
	cmp r1, #0
	orrne r0, r0, #1
	mov r3, r0
	mov r0, r0, lsr #8
	rsb ip, ip, #0
	orr r0, r2, r0, lsr ip
	rsb ip, ip, #0x18
	movs r1, r3, lsl ip
	bxeq lr
	tst r1, #0x80000000
	bxeq lr
	movs r1, r1, lsl #1
	andeqs r1, r0, #1
	addne r0, r0, #1
	bx lr
_0210AB68:
	mov r0, r0, lsl #1
	b _0210AB98
__f_result_INF:
	mov r0, #0xff000000
	orr r0, r2, r0, lsr #1
	bx lr
__f_result_x_NaN:
	mvn r0, #0x80000000
	bx lr
__f_result_invalid:
	mvn r0, #0x80000000
	bx lr
_0210AB8C:
	mov r0, #0xff000000
	orr r0, r2, r0, lsr #1
	bx lr
_0210AB98:
	movs r1, r0
	mov r0, r2
	addne r0, r0, #1
	bx lr
_0210ABA8:
	mov r0, r2
	bx lr
_0210ABB0:
	mov r0, r2
	bx lr

	arm_func_start _frsb
_frsb: // 0x0210ABB8
	eor r0, r0, r1
	eor r1, r0, r1
	eor r0, r0, r1
	arm_func_end _frsb

	.public _fsub
	.type _fsub, @function
	.public _f_sub
	.type _f_sub, @function
_fsub: // 0x0210ABC4
_f_sub: // 0x0210ABC4
	eors r2, r0, r1
	eormi r1, r1, #0x80000000
	bmi __fadd_start
__fsub_start:
	subs ip, r0, r1
	eorlo ip, ip, #0x80000000
	sublo r0, r0, ip
	addlo r1, r1, ip
	mov r2, #0x80000000
	mov r3, r0, lsr #0x17
	orr r0, r2, r0, lsl #8
	ands ip, r3, #0xff
	cmpne ip, #0xff
	beq _0210ACEC
	mov ip, r1, lsr #0x17
	orr r1, r2, r1, lsl #8
	ands r2, ip, #0xff
	beq _0210AD2C
_0210AC08:
	subs ip, r3, ip
	beq _0210AC50
	rsb r2, ip, #0x20
	movs r2, r1, lsl r2
	mov r1, r1, lsr ip
	orrne r1, r1, #1
	subs r0, r0, r1
	bpl _0210AC94
	ands r1, r0, #0xff
	add r0, r0, r0
	mov r0, r0, lsr #9
	orr r0, r0, r3, lsl #23
	tst r1, #0x80
	bxeq lr
	ands r1, r1, #0x7f
	andeqs r1, r0, #1
	addne r0, r0, #1
	bx lr
_0210AC50:
	subs r0, r0, r1
	beq _0210ADF8
	mov r2, r3, lsl #0x17
	and r2, r2, #0x80000000
	bic r3, r3, #0x100
	clz ip, r0
	movs r0, r0, lsl ip
	sub r3, r3, ip
	cmp r3, #0
	bgt _0210AC84
	rsb r3, r3, #9
	orr r0, r2, r0, lsr r3
	bx lr
_0210AC84:
	add r0, r0, r0
	orr r0, r2, r0, lsr #9
	orr r0, r0, r3, lsl #23
	bx lr
_0210AC94:
	mov r2, r3, lsl #0x17
	and r2, r2, #0x80000000
	bic r3, r3, #0x100
	clz ip, r0
	movs r0, r0, lsl ip
	sub r3, r3, ip
	cmp r3, #0
	bgt _0210ACC0
	rsb r3, r3, #9
	orr r0, r2, r0, lsr r3
	bx lr
_0210ACC0:
	ands r1, r0, #0xff
	add r0, r0, r0
	orr r0, r2, r0, lsr #9
	orr r0, r0, r3, lsl #23
	bxeq lr
	tst r1, #0x80
	bxeq lr
	ands r1, r1, #0x7f
	andeqs r1, r0, #1
	addne r0, r0, #1
	bx lr
_0210ACEC:
	cmp r3, #0x100
	movge r2, #0x80000000
	movlt r2, #0
	ands r3, r3, #0xff
	beq _0210AD54
	movs r0, r0, lsl #1
	bne _0210AE2C
	mov ip, r1, lsr #0x17
	mov r1, r1, lsl #9
	ands ip, ip, #0xff
	beq _0210AE20
	cmp ip, #0xff
	blt _0210AE20
	cmp r1, #0
	beq _0210AE34
	b _0210AE2C
_0210AD2C:
	cmp ip, #0x100
	movge r2, #0x80000000
	movlt r2, #0
	and r3, r3, #0xff
	ands ip, ip, #0xff
	beq _0210ADBC
_0210AD44:
	eor r2, r2, #0x80000000
	movs r1, r1, lsl #1
	bne _0210AE2C
	b _0210AE20
_0210AD54:
	movs r0, r0, lsl #1
	beq _0210AD8C
	mov r0, r0, lsr #1
	mov r3, #1
	mov ip, r1, lsr #0x17
	mov r1, r1, lsl #8
	ands ip, ip, #0xff
	beq _0210ADBC
	cmp ip, #0xff
	beq _0210AD44
	orr r1, r1, #0x80000000
	orr r3, r3, r2, lsr #23
	orr ip, ip, r2, lsr #23
	b _0210AC08
_0210AD8C:
	mov r3, r1, lsr #0x17
	mov r0, r1, lsl #9
	ands r2, r3, #0xff
	beq _0210ADB0
	cmp r2, #0xff
	blt _0210ADD8
	cmp r0, #0
	bne _0210AE18
	b _0210AE20
_0210ADB0:
	cmp r0, #0
	beq _0210ADF8
	b _0210ADD8
_0210ADBC:
	movs r1, r1, lsl #1
	beq _0210ADE0
	mov r1, r1, lsr #1
	mov ip, #1
	orr ip, ip, r2, lsr #23
	orr r3, r3, r2, lsr #23
	b _0210AC08
_0210ADD8:
	mov r0, r1
	bx lr
_0210ADE0:
	cmp r0, #0
	subges r3, r3, #1
	add r0, r0, r0
	orr r0, r2, r0, lsr #9
	orr r0, r0, r3, lsl #23
	bx lr
_0210ADF8:
	mov r0, #0
	bx lr
_0210AE00: // 0x0210AE00
	cmp r0, #0
	subges r3, r3, #1
	add r0, r0, r0
	mov r0, r0, lsr #9
	orr r0, r0, r3, lsl #23
	bx lr
_0210AE18:
	mvn r0, #0x80000000
	bx lr
_0210AE20:
	mov r0, #0xff000000
	orr r0, r2, r0, lsr #1
	bx lr
_0210AE2C:
	mvn r0, #0x80000000
	bx lr
_0210AE34:
	mvn r0, #0x80000000
	bx lr

	arm_func_start _ll_mod
_ll_mod: // 0x0210AE3C
	stmdb sp!, {r4, r5, r6, r7, r11, ip, lr}
	mov r4, r1
	orr r4, r4, #1
	b _0210AE5C
	arm_func_end _ll_mod

	.public _ll_sdiv
	.type _ll_sdiv, @function
	.public _ll_div
	.type _ll_div, @function
_ll_sdiv: // 0x0210AE4C
_ll_div: // 0x0210AE4C
	stmdb sp!, {r4, r5, r6, r7, r11, ip, lr}
	eor r4, r1, r3
	mov r4, r4, asr #1
	mov r4, r4, lsl #1
_0210AE5C:
	orrs r5, r3, r2
	bne _0210AE6C
	ldmia sp!, {r4, r5, r6, r7, r11, ip, lr}
	bx lr
_0210AE6C:
	mov r5, r0, lsr #0x1f
	add r5, r5, r1
	mov r6, r2, lsr #0x1f
	add r6, r6, r3
	orrs r6, r5, r6
	bne _0210AEA0
	mov r1, r2
	bl _s32_div_f
	ands r4, r4, #1
	movne r0, r1
	mov r1, r0, asr #0x1f
	ldmia sp!, {r4, r5, r6, r7, r11, ip, lr}
	bx lr
_0210AEA0:
	cmp r1, #0
	bge _0210AEB0
	rsbs r0, r0, #0
	rsc r1, r1, #0
_0210AEB0:
	cmp r3, #0
	bge _0210AEC0
	rsbs r2, r2, #0
	rsc r3, r3, #0
_0210AEC0:
	orrs r5, r1, r0
	beq _0210AFE4
	mov r5, #0
	mov r6, #1
	cmp r3, #0
	bmi _0210AEEC
_0210AED8:
	add r5, r5, #1
	adds r2, r2, r2
	adcs r3, r3, r3
	bpl _0210AED8
	add r6, r6, r5
_0210AEEC:
	cmp r1, #0
	blt _0210AF0C
_0210AEF4:
	cmp r6, #1
	beq _0210AF0C
	sub r6, r6, #1
	adds r0, r0, r0
	adcs r1, r1, r1
	bpl _0210AEF4
_0210AF0C:
	mov r7, #0
	mov ip, #0
	mov r11, #0
	b _0210AF34
_0210AF1C:
	orr ip, ip, #1
	subs r6, r6, #1
	beq _0210AF8C
	adds r0, r0, r0
	adcs r1, r1, r1
	adcs r7, r7, r7
_0210AF34:
	subs r0, r0, r2
	sbcs r1, r1, r3
	sbcs r7, r7, #0
	adds ip, ip, ip
	adc r11, r11, r11
	cmp r7, #0
	bge _0210AF1C
_0210AF50:
	subs r6, r6, #1
	beq _0210AF84
	adds r0, r0, r0
	adcs r1, r1, r1
	adc r7, r7, r7
	adds r0, r0, r2
	adcs r1, r1, r3
	adc r7, r7, #0
	adds ip, ip, ip
	adc r11, r11, r11
	cmp r7, #0
	bge _0210AF1C
	b _0210AF50
_0210AF84:
	adds r0, r0, r2
	adc r1, r1, r3
_0210AF8C:
	ands r7, r4, #1
	moveq r0, ip
	moveq r1, r11
	beq _0210AFC4
	subs r7, r5, #0x20
	movge r0, r1, lsr r7
	bge _0210AFE8
	rsb r7, r5, #0x20
	mov r0, r0, lsr r5
	orr r0, r0, r1, lsl r7
	mov r1, r1, lsr r5
	b _0210AFC4
_0210AFBC: // 0x0210AFBC
	mov r0, r1, lsr r7
	mov r1, #0
_0210AFC4:
	cmp r4, #0
	blt _0210AFD4
	ldmia sp!, {r4, r5, r6, r7, r11, ip, lr}
	bx lr
_0210AFD4:
	rsbs r0, r0, #0
	rsc r1, r1, #0
	ldmia sp!, {r4, r5, r6, r7, r11, ip, lr}
	bx lr
_0210AFE4:
	mov r0, #0
_0210AFE8:
	mov r1, #0
	cmp r4, #0
	blt _0210AFD4
	ldmia sp!, {r4, r5, r6, r7, r11, ip, lr}
	bx lr

	.public _ll_udiv
	.type _ll_udiv, @function
	.public _ull_div
	.type _ull_div, @function
	arm_func_start _ll_udiv
_ll_udiv: // 0x0210AFFC
_ull_div:
	stmdb sp!, {r4, r5, r6, r7, r11, ip, lr}
	mov r4, #0
	b _0210B010

	arm_func_start _ull_mod
_ull_mod: // 0x0210B008
	stmdb sp!, {r4, r5, r6, r7, r11, ip, lr}
	mov r4, #1
_0210B010:
	orrs r5, r3, r2
	bne _0210B020
	ldmia sp!, {r4, r5, r6, r7, r11, ip, lr}
	bx lr
_0210B020:
	orrs r5, r1, r3
	bne _0210AEC0
	mov r1, r2
	bl _u32_div_not_0_f
	cmp r4, #0
	movne r0, r1
	mov r1, #0
	ldmia sp!, {r4, r5, r6, r7, r11, ip, lr}
	bx lr
	arm_func_end _ull_mod

	.public _ll_mul
	.type _ll_mul, @function
	.public _ull_mul
	.type _ull_mul, @function
_ll_mul: // 0x0210B044
_ull_mul: // 0x0210B044
	stmdb sp!, {r4, r5, lr}
	umull r5, r4, r0, r2
	mla r4, r0, r3, r4
	mla r4, r2, r1, r4
	mov r1, r4
	mov r0, r5
	ldmia sp!, {r4, r5, lr}
	bx lr

	arm_func_start _s32_div_f
_s32_div_f: // 0x0210B064
	eor ip, r0, r1
	and ip, ip, #0x80000000
	cmp r0, #0
	rsblt r0, r0, #0
	addlt ip, ip, #1
	cmp r1, #0
	rsblt r1, r1, #0
	beq _0210B25C
	cmp r0, r1
	movlo r1, r0
	movlo r0, #0
	blo _0210B25C
	mov r2, #0x1c
	mov r3, r0, lsr #4
	cmp r1, r3, lsr #12
	suble r2, r2, #0x10
	movle r3, r3, lsr #0x10
	cmp r1, r3, lsr #4
	suble r2, r2, #8
	movle r3, r3, lsr #8
	cmp r1, r3
	suble r2, r2, #4
	movle r3, r3, lsr #4
	mov r0, r0, lsl r2
	rsb r1, r1, #0
	adds r0, r0, r0
	add r2, r2, r2, lsl #1
	add pc, pc, r2, lsl #2
	mov r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	mov r1, r3
_0210B25C:
	ands r3, ip, #0x80000000
	rsbne r0, r0, #0
	ands r3, ip, #1
	rsbne r1, r1, #0
	bx lr
	arm_func_end _s32_div_f

	arm_func_start _u32_div_f
_u32_div_f: // 0x0210B270
	cmp r1, #0
	bxeq lr
	arm_func_end _u32_div_f

	arm_func_start _u32_div_not_0_f
_u32_div_not_0_f: // 0x0210B278
	cmp r0, r1
	movlo r1, r0
	movlo r0, #0
	bxlo lr
	mov r2, #0x1c
	mov r3, r0, lsr #4
	cmp r1, r3, lsr #12
	suble r2, r2, #0x10
	movle r3, r3, lsr #0x10
	cmp r1, r3, lsr #4
	suble r2, r2, #8
	movle r3, r3, lsr #8
	cmp r1, r3
	suble r2, r2, #4
	movle r3, r3, lsr #4
	mov r0, r0, lsl r2
	rsb r1, r1, #0
	adds r0, r0, r0
	add r2, r2, r2, lsl #1
	add pc, pc, r2, lsl #2
	mov r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	adcs r3, r1, r3, lsl #1
	sublo r3, r3, r1
	adcs r0, r0, r0
	mov r1, r3
	bx lr
	arm_func_end _u32_div_not_0_f

	arm_func_start _drdiv
_drdiv: // 0x0210B454
	eor r1, r1, r3
	eor r3, r1, r3
	eor r1, r1, r3
	eor r0, r0, r2
	eor r2, r0, r2
	eor r0, r0, r2
	arm_func_end _drdiv

	.public _ddiv
	.type _ddiv, @function
	.public _d_div
	.type _d_div, @function
_ddiv: // 0x0210B46C
_d_div:
	stmdb sp!, {r4, r5, r6, lr}
	ldr lr, _0210B9AC // =0x00000FFE
	eor r4, r1, r3
	ands ip, lr, r1, lsr #19
	cmpne ip, lr
	beq _0210B818
	bic r1, r1, lr, lsl #20
	orr r1, r1, #0x100000
	add ip, ip, r4, lsr #31
_0210B490:
	ands r4, lr, r3, lsr #19
	cmpne r4, lr
	beq _0210B8B0
	bic r3, r3, lr, lsl #20
	orr r3, r3, #0x100000
_0210B4A4:
	sub ip, ip, r4
	cmp r1, r3
	cmpeq r0, r2
	bhs _0210B4C0
	adds r0, r0, r0
	adc r1, r1, r1
	sub ip, ip, #2
_0210B4C0:
	sub r4, pc, #0x24
	ldrb lr, [r4, r3, lsr #12]
	rsbs r2, r2, #0
	rsc r3, r3, #0
	mov r4, #0x20000000
	mla r5, lr, r3, r4
	mov r6, r3, lsl #0xa
	mov r5, r5, lsr #7
	mul lr, r5, lr
	orr r6, r6, r2, lsr #22
	mov lr, lr, lsr #0xd
	mul r5, lr, r6
	mov r6, r1, lsl #0xa
	orr r6, r6, r0, lsr #22
	mov r5, r5, lsr #0x10
	mul r5, lr, r5
	mov lr, lr, lsl #0xe
	add lr, lr, r5, lsr #16
	umull r5, r6, lr, r6
	umull r4, r5, r6, r2
	mla r5, r3, r6, r5
	mov r4, r4, lsr #0x1a
	orr r4, r4, r5, lsl #6
	add r4, r4, r0, lsl #2
	umull lr, r5, r4, lr
	mov r4, #0
	adds r5, r5, r6, lsl #24
	adc r4, r4, r6, lsr #8
	cmp ip, #0x800
	bge _0210B6A4
	add ip, ip, #0x7f0
	adds ip, ip, #0xc
	bmi _0210B6BC
	orr r1, r4, ip, lsl #31
	bic ip, ip, #1
	add r1, r1, ip, lsl #19
	tst lr, #0x80000000
	bne _0210B594
	rsbs r2, r2, #0
	mov r4, r4, lsl #1
	add r4, r4, r5, lsr #31
	mul lr, r2, r4
	mov r6, #0
	mov r4, r5, lsl #1
	orr r4, r4, #1
	umlal r6, lr, r4, r2
	rsc r3, r3, #0
	mla lr, r4, r3, lr
	cmp lr, r0, lsl #21
	bmi _0210B594
	mov r0, r5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B594:
	adds r0, r5, #1
	adc r1, r1, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr

UNK_210B5A4: // 0x0210B5A4
	.byte 0xFF, 0xFF, 0xFE, 0xFD, 0xFC, 0xFB, 0xFA, 0xF9, 0xF8, 0xF7, 0xF6, 0xF5
	.byte 0xF4, 0xF3, 0xF2, 0xF1, 0xF0, 0xF0, 0xEF, 0xEE, 0xED, 0xEC, 0xEB, 0xEA, 0xEA, 0xE9, 0xE8, 0xE7
	.byte 0xE6, 0xE6, 0xE5, 0xE4, 0xE3, 0xE2, 0xE2, 0xE1, 0xE0, 0xDF, 0xDF, 0xDE, 0xDD, 0xDC, 0xDC, 0xDB
	.byte 0xDA, 0xD9, 0xD9, 0xD8, 0xD7, 0xD7, 0xD6, 0xD5, 0xD4, 0xD4, 0xD3, 0xD2, 0xD2, 0xD1, 0xD0, 0xD0
	.byte 0xCF, 0xCE, 0xCE, 0xCD, 0xCC, 0xCC, 0xCB, 0xCB, 0xCA, 0xC9, 0xC9, 0xC8, 0xC8, 0xC7, 0xC6, 0xC6
	.byte 0xC5, 0xC5, 0xC4, 0xC3, 0xC3, 0xC2, 0xC2, 0xC1, 0xC0, 0xC0, 0xBF, 0xBF, 0xBE, 0xBE, 0xBD, 0xBD
	.byte 0xBC, 0xBC, 0xBB, 0xBA, 0xBA, 0xB9, 0xB9, 0xB8, 0xB8, 0xB7, 0xB7, 0xB6, 0xB6, 0xB5, 0xB5, 0xB4
	.byte 0xB4, 0xB3, 0xB3, 0xB2, 0xB2, 0xB1, 0xB1, 0xB0, 0xB0, 0xAF, 0xAF, 0xAF, 0xAE, 0xAE, 0xAD, 0xAD
	.byte 0xAC, 0xAC, 0xAB, 0xAB, 0xAA, 0xAA, 0xAA, 0xA9, 0xA9, 0xA8, 0xA8, 0xA7, 0xA7, 0xA7, 0xA6, 0xA6
	.byte 0xA5, 0xA5, 0xA4, 0xA4, 0xA4, 0xA3, 0xA3, 0xA2, 0xA2, 0xA2, 0xA1, 0xA1, 0xA0, 0xA0, 0xA0, 0x9F
	.byte 0x9F, 0x9E, 0x9E, 0x9E, 0x9D, 0x9D, 0x9D, 0x9C, 0x9C, 0x9B, 0x9B, 0x9B, 0x9A, 0x9A, 0x9A, 0x99
	.byte 0x99, 0x99, 0x98, 0x98, 0x98, 0x97, 0x97, 0x96, 0x96, 0x96, 0x95, 0x95, 0x95, 0x94, 0x94, 0x94
	.byte 0x93, 0x93, 0x93, 0x92, 0x92, 0x92, 0x91, 0x91, 0x91, 0x91, 0x90, 0x90, 0x90, 0x8F, 0x8F, 0x8F
	.byte 0x8E, 0x8E, 0x8E, 0x8D, 0x8D, 0x8D, 0x8C, 0x8C, 0x8C, 0x8C, 0x8B, 0x8B, 0x8B, 0x8A, 0x8A, 0x8A
	.byte 0x8A, 0x89, 0x89, 0x89, 0x88, 0x88, 0x88, 0x88, 0x87, 0x87, 0x87, 0x86, 0x86, 0x86, 0x86, 0x85
	.byte 0x85, 0x85, 0x85, 0x84, 0x84, 0x84, 0x83, 0x83, 0x83, 0x83, 0x82, 0x82, 0x82, 0x82, 0x81, 0x81
	.byte 0x81, 0x81, 0x80, 0x80
_0210B6A4:
	movs r1, ip, lsl #0x1f
	orr r1, r1, #0x7f000000
	orr r1, r1, #0xf00000
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B6BC:
	mvn r6, ip, asr #1
	cmp r6, #0x34
	bgt _0210B808
	beq _0210B7E4
	cmp r6, #0x14
	bge _0210B704
	rsb r6, r6, #0x13
	mov lr, r0, lsl r6
	rsb r6, r6, #0x14
	mov r0, r5, lsr r6
	rsb r6, r6, #0x20
	orr r0, r0, r4, lsl r6
	rsb r6, r6, #0x20
	mov r4, r4, lsr r6
	orr r1, r4, ip, lsl #31
	mov ip, lr
	mov lr, #0
	b _0210B734
_0210B704:
	rsb r6, r6, #0x33
	mov lr, r1, lsl r6
	mov r1, ip, lsl #0x1f
	rsb r6, r6, #0x20
	orr ip, lr, r0, lsr r6
	rsb r6, r6, #0x20
	mov lr, r0, lsl r6
	mov r5, r5, lsr #0x15
	orr r5, r5, r4, lsl #11
	rsb r6, r6, #0x1f
	mov r0, r5, lsr r6
	mov r4, #0
_0210B734:
	rsbs r2, r2, #0
	mul r4, r2, r4
	mov r5, #0
	umlal r5, r4, r2, r0
	rsc r3, r3, #0
	mla r4, r0, r3, r4
	cmp r4, ip
	cmpeq r5, lr
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	adds r5, r5, r2
	adc r4, r4, r3
	cmp r4, ip
	bmi _0210B7D8
	bne _0210B77C
	cmp r5, lr
	beq _0210B7C8
	blo _0210B7D8
_0210B77C:
	subs r5, r5, r2
	sbc r4, r4, r3
_0210B784:
	adds r5, r5, r5
	adc r4, r4, r4
	adds r5, r5, r2
	adc r4, r4, r3
	adds lr, lr, lr
	adc ip, ip, ip
	cmp r4, ip
	bmi _0210B7C8
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	cmp r5, lr
	blo _0210B7C8
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	tst r0, #1
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
_0210B7C8:
	adds r0, r0, #1
	adc r1, r1, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B7D8:
	adds r0, r0, #1
	adc r1, r1, #0
	b _0210B784
_0210B7E4:
	rsbs r2, r2, #0
	rsc r3, r3, #0
	cmp r1, r3
	cmpeq r0, r2
	mov r1, ip, lsl #0x1f
	mov r0, #0
	movne r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B808:
	mov r1, ip, lsl #0x1f
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B818:
	orrs r5, r0, r1, lsl #1
	beq _0210B93C
	cmp ip, lr
	beq _0210B880
	movs r1, r1, lsl #0xc
	beq _0210B85C
	clz r5, r1
	movs r1, r1, lsl r5
	sub ip, ip, r5
	add r5, ip, #0x1f
	mov r1, r1, lsr #0xb
	orr r1, r1, r0, lsr r5
	rsb r5, r5, #0x20
	mov r0, r0, lsl r5
	mov ip, ip, lsl #1
	orr ip, ip, r4, lsr #31
	b _0210B490
_0210B85C:
	mvn ip, #0x13
	clz r5, r0
	movs r0, r0, lsl r5
	sub ip, ip, r5
	mov r1, r0, lsr #0xb
	mov r0, r0, lsl #0x15
	mov ip, ip, lsl #1
	orr ip, ip, r4, lsr #31
	b _0210B490
_0210B880:
	orrs r5, r0, r1, lsl #12
	bne _0210B964
	bic r5, r3, #0x80000000
	cmp r5, lr, lsl #19
	bhs _0210B8A4
	and r5, r3, #0x80000000
	eor r1, r5, r1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B8A4:
	orrs r5, r2, r3, lsl #12
	bne _0210B984
	b _0210B99C
_0210B8B0:
	orrs r5, r2, r3, lsl #1
	beq _0210B928
	cmp r4, lr
	beq _0210B910
	movs r3, r3, lsl #0xc
	beq _0210B8F0
	clz r5, r3
	movs r3, r3, lsl r5
	sub r4, r4, r5
	add r5, r4, #0x1f
	mov r3, r3, lsr #0xb
	orr r3, r3, r2, lsr r5
	rsb r5, r5, #0x20
	mov r2, r2, lsl r5
	mov r4, r4, lsl #1
	b _0210B4A4
_0210B8F0:
	mvn r4, #0x13
	clz r5, r2
	movs r2, r2, lsl r5
	sub r4, r4, r5
	mov r3, r2, lsr #0xb
	mov r2, r2, lsl #0x15
	mov r4, r4, lsl #1
	b _0210B4A4
_0210B910:
	orrs r5, r2, r3, lsl #12
	bne _0210B984
	mov r1, ip, lsl #0x1f
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B928:
	mov r1, ip, lsl #0x1f
	orr r1, r1, lr, lsl #19
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B93C:
	orrs r5, r2, r3, lsl #1
	beq _0210B99C
	bic r5, r3, #0x80000000
	cmp r5, lr, lsl #19
	cmpeq r2, #0
	bhi _0210B984
	eor r1, r1, r3
	and r1, r1, #0x80000000
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B964:
	tst r1, #0x80000
	beq _0210B99C
	bic r5, r3, #0x80000000
	cmp r5, lr, lsl #19
	cmpeq r2, #0
	bhi _0210B984
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B984:
	tst r3, #0x80000
	beq _0210B99C
	mov r1, r3
	mov r0, r2
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_0210B99C:
	orr r1, r1, #0x7f000000
	orr r1, r1, #0xf80000
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_0210B9AC: .word 0x00000FFE

	arm_func_start _fp_init
_fp_init: // 0x0210B9B0
	bx lr
	arm_func_end _fp_init

	// NITRO_Runtime_Ai_LE.a

	arm_func_start sys_writec
sys_writec: // 0x0210B9B4
	str lr, [sp, #-4]!
	mov r1, r0
	mov r0, #3
	swi 0x123456
	ldr pc, [sp], #4
	arm_func_end sys_writec

	arm_func_start sys_readc
sys_readc: // 0x0210B9C8
	str lr, [sp, #-4]!
	mov r1, #0
	mov r0, #7
	swi 0x123456
	ldr pc, [sp], #4
	arm_func_end sys_readc

	arm_func_start sys_exit
sys_exit: // 0x0210B9DC
	mov r1, #0
	mov r0, #0x18
	swi 0x123456
	mov pc, lr
	arm_func_end sys_exit

	arm_func_start __read_console
__read_console: // 0x0210B9EC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r2
	ldr r5, [r6, #0]
	mov r7, r1
	cmp r5, #0
	mov r4, #0
	bls _0210BA34
_0210BA08:
	bl sys_readc
	and r1, r0, #0xff
	cmp r1, #0xd
	strb r0, [r7, r4]
	cmpne r1, #0xa
	addeq r0, r4, #1
	streq r0, [r6]
	beq _0210BA34
	add r4, r4, #1
	cmp r4, r5
	blo _0210BA08
_0210BA34:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end __read_console

	arm_func_start __write_console
__write_console: // 0x0210BA3C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r5, [r2, #0]
	mov r6, r1
	cmp r5, #0
	mov r4, #0
	bls _0210BA68
_0210BA54:
	add r0, r6, r4
	bl sys_writec
	add r4, r4, #1
	cmp r4, r5
	blo _0210BA54
_0210BA68:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end __write_console

	arm_func_start __close_console
__close_console: // 0x0210BA70
	mov r0, #0
	bx lr
	arm_func_end __close_console

	arm_func_start __call_static_initializers
__call_static_initializers: // 0x0210BA78
	stmdb sp!, {r4, lr}
	ldr r4, _0210BAA0 // =0x021175B4
	b _0210BA8C
_0210BA84:
	blx r0
	add r4, r4, #4
_0210BA8C:
	cmp r4, #0
	ldrne r0, [r4, #0]
	cmpne r0, #0
	bne _0210BA84
	ldmia sp!, {r4, pc}
	.align 2, 0
_0210BAA0: .word 0x021175B4
	arm_func_end __call_static_initializers

	arm_func_start __destroy_global_chain
__destroy_global_chain: // 0x0210BAA4
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, _0210BAE4 // =__global_destructor_chain
	ldr r2, [r4, #0]
	cmp r2, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mvn r5, #0
_0210BABC:
	ldr r0, [r2, #0]
	mov r1, r5
	str r0, [r4]
	ldr r0, [r2, #8]
	ldr r2, [r2, #4]
	blx r2
	ldr r2, [r4, #0]
	cmp r2, #0
	bne _0210BABC
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0210BAE4: .word __global_destructor_chain
	arm_func_end __destroy_global_chain

	arm_func_start _ZNSt9type_infoD2Ev
_ZNSt9type_infoD2Ev: // 0x0210BAE8
	bx lr
	arm_func_end _ZNSt9type_infoD2Ev

	arm_func_start _ZN10__cxxabiv117__class_type_infoD1Ev
_ZN10__cxxabiv117__class_type_infoD1Ev: // 0x0210BAEC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZNSt9type_infoD2Ev
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end _ZN10__cxxabiv117__class_type_infoD1Ev

	arm_func_start _ZN10__cxxabiv117__class_type_infoD0Ev
_ZN10__cxxabiv117__class_type_infoD0Ev: // 0x0210BB00
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZNSt9type_infoD2Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end _ZN10__cxxabiv117__class_type_infoD0Ev

	arm_func_start _ZN10__cxxabiv117__class_type_infoD2Ev
_ZN10__cxxabiv117__class_type_infoD2Ev: // 0x0210BB1C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZNSt9type_infoD2Ev
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end _ZN10__cxxabiv117__class_type_infoD2Ev

	arm_func_start _ZN10__cxxabiv120__si_class_type_infoD1Ev
_ZN10__cxxabiv120__si_class_type_infoD1Ev: // 0x0210BB30
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZN10__cxxabiv117__class_type_infoD2Ev
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end _ZN10__cxxabiv120__si_class_type_infoD1Ev

	arm_func_start _ZN10__cxxabiv120__si_class_type_infoD0Ev
_ZN10__cxxabiv120__si_class_type_infoD0Ev: // 0x0210BB44
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl _ZN10__cxxabiv117__class_type_infoD2Ev
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end _ZN10__cxxabiv120__si_class_type_infoD0Ev

	arm_func_start _ExitProcess
_ExitProcess: // 0x0210BB60
	ldr ip, _0210BB68 // =sys_exit
	bx ip
	.align 2, 0
_0210BB68: .word sys_exit
	arm_func_end _ExitProcess

	exception abort, 0x25, 0x100000
	exception exit, 0x4D, 0x100100
	exception __exit, 0x129, 0x200300
	exception nan, 0x19, 0
	exception __flush_line_buffered_output_files, 0x8D, 0x403F00
	exception __flush_all, 0x69, 0x403F00
	exception __msl_assertion_failed, 0x3D, 0x200100
	exception __load_buffer, 0x8D, 0x200700
	exception __flush_buffer, 0x89, 0x200300
	exception fread, 0x10D, 0x407F00
	exception __fread, 0x349, 0x507F00
	exception __fwrite, 0x2B1, 0x60FF00
	exception fclose, 0x75, 0x200300
	exception fflush, 0xE9, 0x100100
	exception __msl_strrev, 0x45, 0x200300
	exception __msl_itoa, 0x7D, 0x301F00
	exception ftell, 0x11D, 0x300F00
	exception _fseek, 0x1E9, 0x400320
	exception fseek, 0x12D, 0x403F00
	exception rewind, 0x25, 0x100100
	exception mbtowc, 0x1D, 0x100000
	exception wctomb, 0x1D, 0x100000
	exception mbstowcs, 0x89, 0x301F00
	exception wcstombs, 0x79, 0x403F00
	exception memset, 0x15, 0x100100
	exception long2str__printf, 0x24D, 0x90FF20
	exception longlong2str__printf, 0x2E1, 0xA0FF20
	exception double2hex__printf, 0x4DD, 0xF07F20
	exception float2str__printf, 0x765, 0xC0FF20
	exception __pformatter, 0x824, byte_210BB6C
	exception __FileWrite, 0x2D, 0x200300
	exception __StringWrite, 0x45, 0x200300
	exception printf, 0x119, 0x300120
	exception vsnprintf, 0x69, 0x300300
	exception snprintf, 0x29, 0x300020
	exception sprintf, 0x2D, 0x300020
	exception qsort, 0x165, 0x70FF00
	exception __sformatter, 0xD54, byte_210BB74
	exception vsscanf, 0x55, 0x200000
	exception sscanf, 0x29, 0x300020
	exception raise, 0x131, 0x200300
	exception __strtold, 0x124C, byte_210BB7C
	exception strtold, 0xE1, 0x500F00
	exception atof, 0x11, 0
	exception __strtoul, 0x3E9, 0x60FF00
	exception __strtoull, 0x44D, 0x80FF00
	exception strtoul, 0x99, 0x600300
	exception strtol, 0xC9, 0x600300
	exception atoi, 0x15, 0
	exception wmemcpy, 0x11, 0
	exception long2str__wprintf, 0x251, 0x90FF20
	exception longlong2str__wprintf, 0x2E5, 0xA0FF20
	exception double2hex__wprintf, 0x399, 0xF07F20
	exception float2str__wprintf, 0x64C, byte_210BB84
	exception __wpformatter, 0x8F0, byte_210BB8C
	exception __wStringWrite, 0x41, 0x200300
	exception swprintf, 0x29, 0x300020
	exception vswprintf, 0x71, 0x300300
	exception __ieee754_pow, 0x1188, byte_210BB94
	exception frexp, 0xBD, 0x300120
	exception ldexp, 0x24D, 0x300120
	exception pow, 0xD, 0
	exception __rounddec, 0x41, 0x200300
	exception __ull2dec, 0xCD, 0x50FF00
	exception __timesdec, 0x185, 0xD0FF00
	exception __str2dec, 0x9D, 0x100000
	exception __two_exp, 0x385, 0xB00300
	exception __num2dec_internal, 0x181, 0xE01F00
	exception __num2dec, 0xA9, 0x200300
	exception __dec2num, 0x624, byte_210BB9C
	exception scalbn, 0x2D, 0x200100
	exception __read_console, 0x51, 0x300F00
	exception __write_console, 0x35, 0x200700
	exception __call_static_initializers, 0x2D, 0x100100
	exception __destroy_global_chain, 0x45, 0x200300
	exception _ZN10__cxxabiv117__class_type_infoD1Ev, 0x15, 0x100100
	exception _ZN10__cxxabiv117__class_type_infoD0Ev, 0x1D, 0x100100
	exception _ZN10__cxxabiv117__class_type_infoD2Ev, 0x15, 0x100100
	exception _ZN10__cxxabiv120__si_class_type_infoD1Ev, 0x15, 0x100100
	exception _ZN10__cxxabiv120__si_class_type_infoD0Ev, 0x1D, 0x100100
	exception _ExitProcess, 0xD, 0
	
	.section .exception,4,1,2
	; MSL symbols have exceptions for C++ mode, even when compiling C.

byte_210BB6C: // 0x0210BB6C
	.byte 0x20, 0xFF, 9, 0x60, 0, 0, 0, 0

byte_210BB74: // 0x0210BB74
	.byte 0, 0xFF, 1, 0xB0, 0, 0, 0, 0

byte_210BB7C: // 0x0210BB7C
	.byte 0, 0xFF, 1, 0xD0, 0, 0, 0, 0

byte_210BB84: // 0x0210BB84
	.byte 0x20, 0xFF, 9, 0x60, 0, 0, 0, 0

byte_210BB8C: // 0x0210BB8C
	.byte 0x20, 0xFF, 0x11, 0x68, 0, 0, 0, 0

byte_210BB94: // 0x0210BB94
	.byte 0x20, 0xFF, 1, 0xB8, 0, 0, 0, 0

byte_210BB9C: // 0x0210BB9C
	.byte 0, 0xFF, 5, 0x20, 0, 0, 0, 0

	.rodata

.public __lower_mapC
__lower_mapC: // 0x0211704C
	.byte 0x00, 0x01, 0x02, 0x03
	.byte 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13
	.byte 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x22, 0x23
	.byte 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x30, 0x31, 0x32, 0x33
	.byte 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40, 0x61, 0x62, 0x63
	.byte 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70, 0x71, 0x72, 0x73
	.byte 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, 0x60, 0x61, 0x62, 0x63
	.byte 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70, 0x71, 0x72, 0x73
	.byte 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F
	
.public __upper_mapC
__upper_mapC: // 0x021170CC
	.byte 0x00, 0x01, 0x02, 0x03
	.byte 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13
	.byte 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x22, 0x23
	.byte 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x30, 0x31, 0x32, 0x33
	.byte 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40, 0x41, 0x42, 0x43
	.byte 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53
	.byte 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, 0x60, 0x41, 0x42, 0x43
	.byte 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53
	.byte 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F, 
	
.public __ctype_mapC
__ctype_mapC: // 0x0211714C
	.byte 0x04, 0x00, 0x04, 0x00
	.byte 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x06, 0x01
	.byte 0x04, 0x01, 0x04, 0x01, 0x04, 0x01, 0x04, 0x01, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00
	.byte 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00
	.byte 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x42, 0x01, 0xD0, 0x00
	.byte 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00
	.byte 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0x58, 0x04, 0x58, 0x04
	.byte 0x58, 0x04, 0x58, 0x04, 0x58, 0x04, 0x58, 0x04, 0x58, 0x04, 0x58, 0x04, 0x58, 0x04, 0x58, 0x04
	.byte 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0x51, 0x06
	.byte 0x51, 0x06, 0x51, 0x06, 0x51, 0x06, 0x51, 0x06, 0x51, 0x06, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02
	.byte 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02
	.byte 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02
	.byte 0x51, 0x02, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0x71, 0x04
	.byte 0x71, 0x04, 0x71, 0x04, 0x71, 0x04, 0x71, 0x04, 0x71, 0x04, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00
	.byte 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00
	.byte 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00
	.byte 0x71, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0x04, 0x00, 
	
.public _0211724C
_0211724C: // 0x0211724C
	.byte 0x00, 0x00, 0x00, 0x00
	.byte 0xFF, 0xFF, 0xFF, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

.public _0211725C
_0211725C: // 0x0211725C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 
	
.public aNan_3
aNan_3: // 0x02117274
	.asciz "NAN("

.public aFinity
aFinity: // 0x02117279
	.asciz "INFINITY"
	.align 4
	
.public _02117284
_02117284:
	.byte 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00
	.byte 0x06, 0x00, 0x07, 0x00, 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x0D, 0x00
	.byte 0x0E, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x11, 0x00, 0x12, 0x00, 0x13, 0x00, 0x14, 0x00, 0x15, 0x00
	.byte 0x16, 0x00, 0x17, 0x00, 0x18, 0x00, 0x19, 0x00, 0x1A, 0x00, 0x1B, 0x00, 0x1C, 0x00, 0x1D, 0x00
	.byte 0x1E, 0x00, 0x1F, 0x00, 0x20, 0x00, 0x21, 0x00, 0x22, 0x00, 0x23, 0x00, 0x24, 0x00, 0x25, 0x00
	.byte 0x26, 0x00, 0x27, 0x00, 0x28, 0x00, 0x29, 0x00, 0x2A, 0x00, 0x2B, 0x00, 0x2C, 0x00, 0x2D, 0x00
	.byte 0x2E, 0x00, 0x2F, 0x00, 0x30, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00
	.byte 0x36, 0x00, 0x37, 0x00, 0x38, 0x00, 0x39, 0x00, 0x3A, 0x00, 0x3B, 0x00, 0x3C, 0x00, 0x3D, 0x00
	.byte 0x3E, 0x00, 0x3F, 0x00, 0x40, 0x00, 0x61, 0x00, 0x62, 0x00, 0x63, 0x00, 0x64, 0x00, 0x65, 0x00
	.byte 0x66, 0x00, 0x67, 0x00, 0x68, 0x00, 0x69, 0x00, 0x6A, 0x00, 0x6B, 0x00, 0x6C, 0x00, 0x6D, 0x00
	.byte 0x6E, 0x00, 0x6F, 0x00, 0x70, 0x00, 0x71, 0x00, 0x72, 0x00, 0x73, 0x00, 0x74, 0x00, 0x75, 0x00
	.byte 0x76, 0x00, 0x77, 0x00, 0x78, 0x00, 0x79, 0x00, 0x7A, 0x00, 0x5B, 0x00, 0x5C, 0x00, 0x5D, 0x00
	.byte 0x5E, 0x00, 0x5F, 0x00, 0x60, 0x00, 0x61, 0x00, 0x62, 0x00, 0x63, 0x00, 0x64, 0x00, 0x65, 0x00
	.byte 0x66, 0x00, 0x67, 0x00, 0x68, 0x00, 0x69, 0x00, 0x6A, 0x00, 0x6B, 0x00, 0x6C, 0x00, 0x6D, 0x00
	.byte 0x6E, 0x00, 0x6F, 0x00, 0x70, 0x00, 0x71, 0x00, 0x72, 0x00, 0x73, 0x00, 0x74, 0x00, 0x75, 0x00
	.byte 0x76, 0x00, 0x77, 0x00, 0x78, 0x00, 0x79, 0x00, 0x7A, 0x00, 0x7B, 0x00, 0x7C, 0x00, 0x7D, 0x00
	.byte 0x7E, 0x00, 0x7F, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00
	.byte 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x06, 0x01, 0x04, 0x01, 0x04, 0x01, 0x04, 0x01, 0x04, 0x01
	.byte 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00
	.byte 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00, 0x04, 0x00
	.byte 0x04, 0x00, 0x04, 0x00, 0x42, 0x01, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00
	.byte 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00
	.byte 0xD0, 0x00, 0xD0, 0x00, 0x58, 0x04, 0x58, 0x04, 0x58, 0x04, 0x58, 0x04, 0x58, 0x04, 0x58, 0x04
	.byte 0x58, 0x04, 0x58, 0x04, 0x58, 0x04, 0x58, 0x04, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00
	.byte 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0x51, 0x06, 0x51, 0x06, 0x51, 0x06, 0x51, 0x06, 0x51, 0x06
	.byte 0x51, 0x06, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02
	.byte 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02
	.byte 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0x51, 0x02, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00
	.byte 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0x71, 0x04, 0x71, 0x04, 0x71, 0x04, 0x71, 0x04, 0x71, 0x04
	.byte 0x71, 0x04, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00
	.byte 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00
	.byte 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0x71, 0x00, 0xD0, 0x00, 0xD0, 0x00, 0xD0, 0x00
	.byte 0xD0, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00
	.byte 0x06, 0x00, 0x07, 0x00, 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x0D, 0x00
	.byte 0x0E, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x11, 0x00, 0x12, 0x00, 0x13, 0x00, 0x14, 0x00, 0x15, 0x00
	.byte 0x16, 0x00, 0x17, 0x00, 0x18, 0x00, 0x19, 0x00, 0x1A, 0x00, 0x1B, 0x00, 0x1C, 0x00, 0x1D, 0x00
	.byte 0x1E, 0x00, 0x1F, 0x00, 0x20, 0x00, 0x21, 0x00, 0x22, 0x00, 0x23, 0x00, 0x24, 0x00, 0x25, 0x00
	.byte 0x26, 0x00, 0x27, 0x00, 0x28, 0x00, 0x29, 0x00, 0x2A, 0x00, 0x2B, 0x00, 0x2C, 0x00, 0x2D, 0x00
	.byte 0x2E, 0x00, 0x2F, 0x00, 0x30, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00
	.byte 0x36, 0x00, 0x37, 0x00, 0x38, 0x00, 0x39, 0x00, 0x3A, 0x00, 0x3B, 0x00, 0x3C, 0x00, 0x3D, 0x00
	.byte 0x3E, 0x00, 0x3F, 0x00, 0x40, 0x00, 0x41, 0x00, 0x42, 0x00, 0x43, 0x00, 0x44, 0x00, 0x45, 0x00
	.byte 0x46, 0x00, 0x47, 0x00, 0x48, 0x00, 0x49, 0x00, 0x4A, 0x00, 0x4B, 0x00, 0x4C, 0x00, 0x4D, 0x00
	.byte 0x4E, 0x00, 0x4F, 0x00, 0x50, 0x00, 0x51, 0x00, 0x52, 0x00, 0x53, 0x00, 0x54, 0x00, 0x55, 0x00
	.byte 0x56, 0x00, 0x57, 0x00, 0x58, 0x00, 0x59, 0x00, 0x5A, 0x00, 0x5B, 0x00, 0x5C, 0x00, 0x5D, 0x00
	.byte 0x5E, 0x00, 0x5F, 0x00, 0x60, 0x00, 0x41, 0x00, 0x42, 0x00, 0x43, 0x00, 0x44, 0x00, 0x45, 0x00
	.byte 0x46, 0x00, 0x47, 0x00, 0x48, 0x00, 0x49, 0x00, 0x4A, 0x00, 0x4B, 0x00, 0x4C, 0x00, 0x4D, 0x00
	.byte 0x4E, 0x00, 0x4F, 0x00, 0x50, 0x00, 0x51, 0x00, 0x52, 0x00, 0x53, 0x00, 0x54, 0x00, 0x55, 0x00
	.byte 0x56, 0x00, 0x57, 0x00, 0x58, 0x00, 0x59, 0x00, 0x5A, 0x00, 0x7B, 0x00, 0x7C, 0x00, 0x7D, 0x00
	.byte 0x7E, 0x00, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40
	.byte 0x03, 0xB8, 0xE2, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0x3F, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0xF8, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0xD0, 0xCF, 0x43
	.byte 0xEB, 0xFD, 0x4C, 0x3E 

	.data

.public _021322D4
_021322D4:
	.byte 0x00, 0x00, 0x00, 0x00, 0x24, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x20, 0x28, 0x15, 0x02, 0x00, 0x01, 0x00, 0x00, 0x20, 0x28, 0x15, 0x02, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0xEC, 0xB9, 0x10, 0x02, 0x3C, 0xBA, 0x10, 0x02, 0x70, 0xBA, 0x10, 0x02, 0x00, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x28, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x27, 0x15, 0x02
	.byte 0x00, 0x01, 0x00, 0x00, 0x20, 0x27, 0x15, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEC, 0xB9, 0x10, 0x02
	.byte 0x3C, 0xBA, 0x10, 0x02, 0x70, 0xBA, 0x10, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
	.byte 0x08, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x26, 0x15, 0x02, 0x00, 0x01, 0x00, 0x00
	.byte 0x20, 0x26, 0x15, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEC, 0xB9, 0x10, 0x02, 0x3C, 0xBA, 0x10, 0x02
	.byte 0x70, 0xBA, 0x10, 0x02, 0x00, 0x00, 0x00, 0x00
	
.public aAssertionSFail
aAssertionSFail: // 0x021323B8
	.asciz "Assertion (%s) failed in \"%s\", function \"%s\", line %d\n"
	.align 4

.public _021323F0
_021323F0:
	.byte 0x00, 0x00, 0x80, 0x7F, 0xFF, 0xFF, 0xFF, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0x7F
	.byte 0x00, 0x00, 0x00, 0x00, 0x25, 0x54, 0x00, 0x00

.public aAmPm
aAmPm: // 0x02132408
	.asciz "AM|PM"
	.align 4

.public _02132410
_02132410:
	.byte 0x1C, 0xE7, 0x0F, 0x02, 0x54, 0xE7, 0x0F, 0x02, 0x20, 0x00, 0x00, 0x00, 0x6E, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x48, 0x24, 0x13, 0x02, 0x08, 0x24, 0x13, 0x02, 0x2C, 0x25, 0x13, 0x02
	.byte 0x20, 0x25, 0x13, 0x02, 0x08, 0x25, 0x13, 0x02, 0x04, 0x24, 0x13, 0x02, 0x3C, 0x25, 0x13, 0x02
	.byte 0x94, 0x25, 0x13, 0x02, 0x00, 0x24, 0x13, 0x02, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x04, 0x00
	.byte 0x05, 0x00, 0x06, 0x00, 0x07, 0x00, 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x0C, 0x00
	.byte 0x0D, 0x00, 0x0E, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x21, 0x00, 0x22, 0x00, 0x23, 0x00, 0x24, 0x00
	.byte 0x25, 0x00, 0x26, 0x00, 0x27, 0x00, 0x28, 0x00, 0x29, 0x00, 0x2A, 0x00, 0x11, 0x00, 0x12, 0x00
	.byte 0x13, 0x00, 0x14, 0x00, 0x15, 0x00, 0x16, 0x00, 0x17, 0x00, 0x2B, 0x00, 0x2D, 0x00, 0x2F, 0x00
	.byte 0x31, 0x00, 0x33, 0x00, 0x35, 0x00, 0x37, 0x00, 0x39, 0x00, 0x3B, 0x00, 0x3D, 0x00, 0x3F, 0x00
	.byte 0x41, 0x00, 0x43, 0x00, 0x45, 0x00, 0x47, 0x00, 0x49, 0x00, 0x4B, 0x00, 0x4D, 0x00, 0x4F, 0x00
	.byte 0x51, 0x00, 0x53, 0x00, 0x55, 0x00, 0x57, 0x00, 0x59, 0x00, 0x5B, 0x00, 0x5D, 0x00, 0x18, 0x00
	.byte 0x19, 0x00, 0x1A, 0x00, 0x1B, 0x00, 0x1C, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x2E, 0x00, 0x30, 0x00
	.byte 0x32, 0x00, 0x34, 0x00, 0x36, 0x00, 0x38, 0x00, 0x3A, 0x00, 0x3C, 0x00, 0x3E, 0x00, 0x40, 0x00
	.byte 0x42, 0x00, 0x44, 0x00, 0x46, 0x00, 0x48, 0x00, 0x4A, 0x00, 0x4C, 0x00, 0x4E, 0x00, 0x50, 0x00
	.byte 0x52, 0x00, 0x54, 0x00, 0x56, 0x00, 0x58, 0x00, 0x5A, 0x00, 0x5C, 0x00, 0x5E, 0x00, 0x1D, 0x00
	.byte 0x1E, 0x00, 0x1F, 0x00, 0x20, 0x00, 0x00, 0x00

.public aMDY
aMDY: // 0x02132508
	.asciz "%m/%d/%y"
	.align 4

.public _02132514
_02132514:
	.byte 0x28, 0x24, 0x13, 0x02, 0x18, 0x24, 0x13, 0x02, 0x10, 0x24, 0x13, 0x02

.public aIMSP
aIMSP: // 0x02132520
	.asciz "%I:%M:%S %p"

.public aABETY
aABETY: // 0x0213252C
	.asciz "%a %b %e %T %Y"
	.align 4

.public aSunSundayMonMo
aSunSundayMonMo: // 0x0213253C
	.asciz "Sun|Sunday|Mon|Monday|Tue|Tuesday|Wed|Wednesday|Thu|Thursday|Fri|Friday|Sat|Saturday"
	.align 4

.public aJanJanuaryFebF
aJanJanuaryFebF: // 0x02132594
	.asciz "Jan|January|Feb|February|Mar|March|Apr|April|May|May|Jun|June|Jul|July|Aug|August|Sep|September|Oct|October|Nov|November|Dec|December"
	.align 4

.public a0x0p0
a0x0p0: // 0x0213261C
	.asciz "0x0p0"
	.align 4

.public _02132624
_02132624:
	.byte 0x2D, 0x49, 0x4E, 0x46, 0x00, 0x00, 0x00, 0x00, 0x2D, 0x69, 0x6E, 0x66
	.byte 0x00, 0x00, 0x00, 0x00, 0x49, 0x4E, 0x46, 0x00, 0x69, 0x6E, 0x66, 0x00, 0x2D, 0x4E, 0x41, 0x4E
	.byte 0x00, 0x00, 0x00, 0x00, 0x2D, 0x6E, 0x61, 0x6E, 0x00, 0x00, 0x00, 0x00, 0x4E, 0x41, 0x4E, 0x00
	.byte 0x6E, 0x61, 0x6E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x30, 0x00, 0x78, 0x00, 0x30, 0x00, 0x70, 0x00, 0x30, 0x00, 0x00, 0x00, 0x2D, 0x00, 0x49, 0x00
	.byte 0x4E, 0x00, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2D, 0x00, 0x69, 0x00, 0x6E, 0x00, 0x66, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x49, 0x00, 0x4E, 0x00, 0x46, 0x00, 0x00, 0x00, 0x69, 0x00, 0x6E, 0x00
	.byte 0x66, 0x00, 0x00, 0x00, 0x2D, 0x00, 0x4E, 0x00, 0x41, 0x00, 0x4E, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x2D, 0x00, 0x6E, 0x00, 0x61, 0x00, 0x6E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4E, 0x00, 0x41, 0x00
	.byte 0x4E, 0x00, 0x00, 0x00, 0x6E, 0x00, 0x61, 0x00, 0x6E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x24, 0x40, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x59, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x8F, 0x40, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x88, 0xC3, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x6A, 0xF8, 0x40, 0x00, 0x00, 0x00, 0x00
	.byte 0x80, 0x84, 0x2E, 0x41, 0x00, 0x00, 0x00, 0x00, 0xD0, 0x12, 0x63, 0x41, 0x00, 0x00, 0x00, 0x00
	.byte 0x84, 0xD7, 0x97, 0x41

.public a54210108624275
a54210108624275: // 0x02132704
	.asciz "542101086242752217003726400434970855712890625"
	.align 4

.public a11102230246251
a11102230246251: // 0x02132734
	.asciz "11102230246251565404236316680908203125"
	.align 4

.public a23283064365386
a23283064365386: // 0x0213275C
	.asciz "23283064365386962890625"
	.align 4

.public a152587890625
a152587890625: // 0x02132774
	.asciz "152587890625"
	.align 4

.public a390625
a390625: // 0x02132784
	.asciz "390625"
	.align 4

.public a78125
a78125: // 0x0213278C
	.asciz "78125"
	.align 4

.public a15625
a15625: // 0x02132794
	.asciz "15625"
	.align 4

.public a3125
a3125: // 0x0213279C
	.asciz "3125"
	.align 4

.public a625
a625: // a625
	.asciz "625"
	.align 4

.public a125
a125:
	.asciz "125"
	.align 4

.public a25
a25:
	.asciz "25"
	.align 4

.public a5
a5:
	.asciz "5"
	.align 4

.public a1_3
a1_3:
	.asciz "1"
	.align 4

.public a2_0
a2_0:
	.asciz "2"
	.align 4

.public a4_0
a4_0:
	.asciz "4"
	.align 4

.public a8
a8:
	.asciz "8"
	.align 4

.public a16
a16:
	.asciz "16"
	.align 4

.public a32
a32:
	.asciz "32"
	.align 4

.public a64
a64:
	.asciz "64"
	.align 4

.public a128
a128:
	.asciz "128"
	.align 4

.public a256
a256:
	.asciz "256"
	.align 4

.public a17976931348623
a17976931348623: // 0x021327D8
	.asciz "179769313486231580793728714053034151"
	.align 4

.public _ZTISt9type_info
_ZTISt9type_info: // 0x02132800
    .word _ZTVN10__cxxabiv117__class_type_infoE+8
	.word _ZTSSt9type_info    

.public _ZTIN10__cxxabiv117__array_type_infoE
_ZTIN10__cxxabiv117__array_type_infoE: // 0x02132808
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8 
	.word _ZTSN10__cxxabiv117__array_type_infoE 
	.word _ZTISt9type_info    

.public _ZTIN10__cxxabiv119__pointer_type_infoE
_ZTIN10__cxxabiv119__pointer_type_infoE: // 0x02132814
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8 
	.word _ZTSN10__cxxabiv119__pointer_type_infoE 
	.word _ZTIN10__cxxabiv117__pbase_type_infoE 

.public _02132624
_ZTIN10__cxxabiv116__enum_type_infoE: // 0x02132820
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8 
	.word _ZTSN10__cxxabiv116__enum_type_infoE 
	.word _ZTISt9type_info    

.public _ZTIN10__cxxabiv117__pbase_type_infoE
_ZTIN10__cxxabiv117__pbase_type_infoE: // 0x0213282C
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8
	.word _ZTSN10__cxxabiv117__pbase_type_infoE 
	.word _ZTISt9type_info    

.public _ZTIN10__cxxabiv121__vmi_class_type_infoE
_ZTIN10__cxxabiv121__vmi_class_type_infoE: // 0x02132838
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8 
	.word _ZTSN10__cxxabiv121__vmi_class_type_infoE 
	.word _ZTIN10__cxxabiv117__class_type_infoE 

.public _ZTIN10__cxxabiv120__function_type_infoE
_ZTIN10__cxxabiv120__function_type_infoE: // 0x02132844
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8 
	.word _ZTSN10__cxxabiv120__function_type_infoE 
	.word _ZTISt9type_info    

.public _ZTIN10__cxxabiv120__si_class_type_infoE
_ZTIN10__cxxabiv120__si_class_type_infoE: // 0x02132850
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8
	.word _ZTSN10__cxxabiv120__si_class_type_infoE 
	.word _ZTIN10__cxxabiv117__class_type_infoE 

.public _ZTIN10__cxxabiv129__pointer_to_member_type_infoE
_ZTIN10__cxxabiv129__pointer_to_member_type_infoE: // 0x0213285C
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8 
	.word _ZTSN10__cxxabiv129__pointer_to_member_type_infoE 
	.word _ZTIN10__cxxabiv117__pbase_type_infoE 

.public _ZTIN10__cxxabiv123__fundamental_type_infoE
_ZTIN10__cxxabiv123__fundamental_type_infoE: // 0x02132868
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8 
	.word _ZTSN10__cxxabiv123__fundamental_type_infoE 
	.word _ZTISt9type_info    

.public _ZTIN10__cxxabiv117__class_type_infoE
_ZTIN10__cxxabiv117__class_type_infoE: // 0x02132874
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8
	.word _ZTSN10__cxxabiv117__class_type_infoE 
	.word _ZTISt9type_info    
	
.public _ZTSSt9type_info
_ZTSSt9type_info: // 0x02132880
	.asciz "St9type_info"
	.align 4
	
.public _ZTVN10__cxxabiv120__si_class_type_infoE
_ZTVN10__cxxabiv120__si_class_type_infoE: // 0x02132890
	.word 0, _ZTIN10__cxxabiv120__si_class_type_infoE
	.word _ZN10__cxxabiv120__si_class_type_infoD1Ev, _ZN10__cxxabiv120__si_class_type_infoD0Ev
	
.public _ZTVN10__cxxabiv117__class_type_infoE
_ZTVN10__cxxabiv117__class_type_infoE: // 0x021328A0
	.word 0, _ZTIN10__cxxabiv117__class_type_infoE
	.word _ZN10__cxxabiv117__class_type_infoD1Ev, _ZN10__cxxabiv117__class_type_infoD0Ev

.public _ZTSN10__cxxabiv116__enum_type_infoE
_ZTSN10__cxxabiv116__enum_type_infoE: // 0x021328B0
	.asciz "N10__cxxabiv116__enum_type_infoE"
	.align 4
	
.public _ZTSN10__cxxabiv117__pbase_type_infoE
_ZTSN10__cxxabiv117__pbase_type_infoE: // 0x021328D4
	.asciz "N10__cxxabiv117__pbase_type_infoE"
	.align 4
	
.public _ZTSN10__cxxabiv117__class_type_infoE
_ZTSN10__cxxabiv117__class_type_infoE: // 0x021328F8
	.asciz "N10__cxxabiv117__class_type_infoE"
	.align 4
	
.public _ZTSN10__cxxabiv117__array_type_infoE
_ZTSN10__cxxabiv117__array_type_infoE: // 0x0213291C
	.asciz "N10__cxxabiv117__array_type_infoE"
	.align 4
	
.public _02132624
_ZTSN10__cxxabiv119__pointer_type_infoE: // 0x02132940
	.asciz "N10__cxxabiv119__pointer_type_infoE"
	.align 4
	
.public _ZTSN10__cxxabiv120__function_type_infoE
_ZTSN10__cxxabiv120__function_type_infoE: // 0x02132964
	.asciz "N10__cxxabiv120__function_type_infoE"
	.align 4
	
.public _ZTSN10__cxxabiv120__si_class_type_infoE
_ZTSN10__cxxabiv120__si_class_type_infoE: // 0x0213298C
	.asciz "N10__cxxabiv120__si_class_type_infoE"
	.align 4
	
.public _ZTSN10__cxxabiv121__vmi_class_type_infoE
_ZTSN10__cxxabiv121__vmi_class_type_infoE: // 0x021329B4
	.asciz "N10__cxxabiv121__vmi_class_type_infoE"
	.align 4
	
.public _ZTSN10__cxxabiv123__fundamental_type_infoE
_ZTSN10__cxxabiv123__fundamental_type_infoE: // 0x021329DC
	.asciz "N10__cxxabiv123__fundamental_type_infoE"
	.align 4

.public _ZTSN10__cxxabiv129__pointer_to_member_type_infoE
_ZTSN10__cxxabiv129__pointer_to_member_type_infoE: // 0x02132A04
	.asciz "N10__cxxabiv129__pointer_to_member_type_infoE"
	.align 4