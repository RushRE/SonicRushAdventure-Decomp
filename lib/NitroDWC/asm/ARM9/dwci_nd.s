	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_SVLTokenWaitThread
DWCi_SVLTokenWaitThread: // 0x0209E078
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_209E2B4
	bl sub_209E258
	ldr r0, _0209E0B4 // =0x02144338
	ldr r1, _0209E0B8 // =0x0214432C
	ldr r0, [r0]
	ldr r1, [r1]
	blx r1
	bl sub_209E2B0
	ldr r0, _0209E0BC // =0x02144328
	mov r1, #0
	str r1, [r0]
	blx r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209E0B4: .word 0x02144338
_0209E0B8: .word 0x0214432C
_0209E0BC: .word 0x02144328
	arm_func_end DWCi_SVLTokenWaitThread

	arm_func_start DWC_NdInitAsync
DWC_NdInitAsync: // 0x0209E0C0
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov r2, r0
	mov ip, #0x800
	ldr r0, _0209E0FC // =0x02144340
	ldr r1, _0209E100 // =DWCi_SVLTokenWaitThread
	ldr r3, _0209E104 // =0x02144C00
	str ip, [sp]
	mov ip, #0x10
	str ip, [sp, #4]
	bl OS_CreateThread
	ldr r0, _0209E0FC // =0x02144340
	bl OS_WakeupThreadDirect
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0209E0FC: .word 0x02144340
_0209E100: .word DWCi_SVLTokenWaitThread
_0209E104: .word 0x02144C00
	arm_func_end DWC_NdInitAsync

	arm_func_start sub_209E108
sub_209E108: // 0x0209E108
	stmdb sp!, {r4, lr}
	ldr r4, _0209E134 // =0x0214433C
	ldr r0, [r4]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
_0209E11C:
	ldr r0, [r0, #8]
	bl sub_209E138
	ldr r0, [r4]
	cmp r0, #0
	bne _0209E11C
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209E134: .word 0x0214433C
	arm_func_end sub_209E108

	arm_func_start sub_209E138
sub_209E138: // 0x0209E138
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, #0
	bl sub_209E1E4
	movs r4, r0
	beq _0209E1D0
	ldr r0, _0209E1DC // =0x0214433C
	ldr r2, [r0]
	ldr r1, [r2]
	cmp r2, r1
	beq _0209E190
	ldr r2, [r4, #4]
	ldr r1, [r4]
	str r2, [r1, #4]
	ldr r2, [r4]
	ldr r1, [r4, #4]
	str r2, [r1]
	ldr r1, [r0]
	cmp r1, r4
	ldreq r1, [r4, #4]
	streq r1, [r0]
	b _0209E198
_0209E190:
	mov r1, r5
	str r1, [r0]
_0209E198:
	ldr r0, [r4, #0xc]
	ldr r7, [r0, #0x3c]
	ldr r6, [r0, #0x30]
	ldr r5, [r0, #0x2c]
	bl sub_209E310
	ldr r1, _0209E1E0 // =0x0214432C
	mov r0, r4
	ldr r1, [r1]
	blx r1
	mov r1, r6
	mov r2, r5
	mov r0, #8
	blx r7
	mov r5, #1
_0209E1D0:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209E1DC: .word 0x0214433C
_0209E1E0: .word 0x0214432C
	arm_func_end sub_209E138

	arm_func_start sub_209E1E4
sub_209E1E4: // 0x0209E1E4
	ldr r1, _0209E238 // =0x0214433C
	mov ip, #0
	ldr r3, [r1]
	cmp r3, #0
	beq _0209E230
	ldr r1, [r3, #8]
	cmp r1, r0
	moveq ip, r3
	beq _0209E230
	ldr r2, [r3, #4]
	cmp r2, r3
	beq _0209E230
_0209E214:
	ldr r1, [r2, #8]
	cmp r1, r0
	moveq ip, r2
	beq _0209E230
	ldr r2, [r2, #4]
	cmp r2, r3
	bne _0209E214
_0209E230:
	mov r0, ip
	bx lr
	.align 2, 0
_0209E238: .word 0x0214433C
	arm_func_end sub_209E1E4

	arm_func_start sub_209E23C
sub_209E23C: // 0x0209E23C
	ldr ip, _0209E250 // =OS_SendMessage
	mov r1, #0
	ldr r0, _0209E254 // =0x02144C18
	mov r2, r1
	bx ip
	.align 2, 0
_0209E250: .word OS_SendMessage
_0209E254: .word 0x02144C18
	arm_func_end sub_209E23C

	arm_func_start sub_209E258
sub_209E258: // 0x0209E258
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0209E280 // =0x02144334
	mov r1, #1
	str r1, [r0]
	bl sub_209E23C
	ldr r0, _0209E284 // =0x02144C38
	bl OS_JoinThread
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209E280: .word 0x02144334
_0209E284: .word 0x02144C38
	arm_func_end sub_209E258

	arm_func_start sub_209E288
sub_209E288: // 0x0209E288
	ldr ip, _0209E294 // =OS_UnlockMutex
	ldr r0, _0209E298 // =0x02144C00
	bx ip
	.align 2, 0
_0209E294: .word OS_UnlockMutex
_0209E298: .word 0x02144C00
	arm_func_end sub_209E288

	arm_func_start sub_209E29C
sub_209E29C: // 0x0209E29C
	ldr ip, _0209E2A8 // =OS_LockMutex
	ldr r0, _0209E2AC // =0x02144C00
	bx ip
	.align 2, 0
_0209E2A8: .word OS_LockMutex
_0209E2AC: .word 0x02144C00
	arm_func_end sub_209E29C

	arm_func_start sub_209E2B0
sub_209E2B0: // 0x0209E2B0
	bx lr
	arm_func_end sub_209E2B0

	arm_func_start sub_209E2B4
sub_209E2B4: // 0x0209E2B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_209E29C
	ldr r0, _0209E30C // =0x02144330
	ldr r2, [r0]
	cmp r2, #0
	beq _0209E2FC
	ldr r1, [r2, #0xc]
	ldr r1, [r1, #4]
	cmp r1, #0
	bne _0209E2FC
	ldr r1, [r2, #0xc]
	mov r2, #1
	str r2, [r1, #4]
	ldr r1, [r0]
	ldr r0, [r1, #0xc]
	ldr r1, [r1, #0x10]
	bl sub_209E3E8
_0209E2FC:
	bl sub_209E108
	bl sub_209E288
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209E30C: .word 0x02144330
	arm_func_end sub_209E2B4

	arm_func_start sub_209E310
sub_209E310: // 0x0209E310
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x34]
	bl sub_209E388
	ldr r0, [r4, #0x38]
	bl sub_209E388
	ldr r0, [r4, #0x20]
	cmp r0, #0
	beq _0209E35C
	ldr r0, [r0, #0x800]
	cmp r0, #0
	beq _0209E34C
	ldr r1, _0209E384 // =0x0214432C
	ldr r1, [r1]
	blx r1
_0209E34C:
	ldr r1, _0209E384 // =0x0214432C
	ldr r0, [r4, #0x20]
	ldr r1, [r1]
	blx r1
_0209E35C:
	ldr r1, _0209E384 // =0x0214432C
	ldr r0, [r4, #0x24]
	ldr r1, [r1]
	blx r1
	ldr r1, _0209E384 // =0x0214432C
	mov r0, r4
	ldr r1, [r1]
	blx r1
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209E384: .word 0x0214432C
	arm_func_end sub_209E310

	arm_func_start sub_209E388
sub_209E388: // 0x0209E388
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r4, _0209E3E4 // =0x0214432C
	mov r5, #0
_0209E3A4:
	ldr r0, [r7]
	cmp r7, r0
	beq _0209E3C4
	ldr r6, [r0]
	ldr r1, [r4]
	blx r1
	str r6, [r7]
	b _0209E3D4
_0209E3C4:
	ldr r1, [r4]
	mov r0, r7
	blx r1
	mov r7, r5
_0209E3D4:
	cmp r7, #0
	bne _0209E3A4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209E3E4: .word 0x0214432C
	arm_func_end sub_209E388

	arm_func_start sub_209E3E8
sub_209E3E8: // 0x0209E3E8
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0
	addlt sp, sp, #4
	ldmltia sp!, {pc}
	mov r0, r1
	mov r1, #2
	bl sub_20BE91C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_209E3E8

	arm_func_start sub_209E410
sub_209E410: // 0x0209E410
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, #0
	ldr r4, _0209E454 // =0x02144D08
	ldr r6, _0209E458 // =0x02144D0C
	mov r5, r7
_0209E428:
	ldr r0, [r6, r7, lsl #2]
	cmp r0, #0
	beq _0209E440
	ldr r1, [r4]
	blx r1
	str r5, [r6, r7, lsl #2]
_0209E440:
	add r7, r7, #1
	cmp r7, #3
	blt _0209E428
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209E454: .word 0x02144D08
_0209E458: .word 0x02144D0C
	arm_func_end sub_209E410

	arm_func_start DWCi_NdCleanupAsync
DWCi_NdCleanupAsync: // 0x0209E45C
	ldr r1, _0209E47C // =0x02144CF8
	ldr r2, _0209E480 // =0x02144D04
	str r0, [r1]
	mov r1, #0
	ldr ip, _0209E484 // =DWC_NdInitAsync
	ldr r0, _0209E488 // =sub_209E48C
	str r1, [r2]
	bx ip
	.align 2, 0
_0209E47C: .word 0x02144CF8
_0209E480: .word 0x02144D04
_0209E484: .word DWC_NdInitAsync
_0209E488: .word sub_209E48C
	arm_func_end DWCi_NdCleanupAsync

	arm_func_start sub_209E48C
sub_209E48C: // 0x0209E48C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_209E410
	bl sub_209E4F0
	bl sub_209E4EC
	ldr r0, _0209E4DC // =0x02144CFC
	ldr r1, _0209E4E0 // =0x02144D08
	ldr r0, [r0]
	ldr r1, [r1]
	blx r1
	ldr r0, _0209E4E4 // =0x02144D00
	ldr r1, _0209E4E0 // =0x02144D08
	ldr r0, [r0]
	ldr r1, [r1]
	blx r1
	ldr r0, _0209E4E8 // =0x02144CF8
	ldr r0, [r0]
	blx r0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209E4DC: .word 0x02144CFC
_0209E4E0: .word 0x02144D08
_0209E4E4: .word 0x02144D00
_0209E4E8: .word 0x02144CF8
	arm_func_end sub_209E48C

	arm_func_start sub_209E4EC
sub_209E4EC: // 0x0209E4EC
	bx lr
	arm_func_end sub_209E4EC

	arm_func_start sub_209E4F0
sub_209E4F0: // 0x0209E4F0
	bx lr
	arm_func_end sub_209E4F0
