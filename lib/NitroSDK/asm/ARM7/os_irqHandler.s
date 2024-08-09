	.include "asm/macros.inc"
	.include "global.inc"
	
	.public OS_IRQTable

	.text

	arm_func_start OS_IrqHandler
OS_IrqHandler: // 0x037FB9D4
	stmdb sp!, {lr}
	mov ip, #0x4000000
	add ip, ip, #0x210
	ldr r1, [ip, #-8]
	cmp r1, #0
	ldmeqia sp!, {pc}
	ldmia ip, {r1, r2}
	ands r1, r1, r2
	ldmeqia sp!, {pc}
	mov r3, #1
	mov r0, #0
_037FBA00:
	ands r2, r1, r3, lsl r0
	addeq r0, r0, #1
	beq _037FBA00
	str r2, [ip, #4]
	ldr r1, _037FBA20 // =OS_IRQTable
	ldr r0, [r1, r0, lsl #2]
	ldr lr, _037FBA24 // =OS_IrqHandler_ThreadSwitch
	bx r0
	.align 2, 0
_037FBA20: .word OS_IRQTable
_037FBA24: .word OS_IrqHandler_ThreadSwitch
	arm_func_end OS_IrqHandler

	arm_func_start OS_IrqHandler_ThreadSwitch
OS_IrqHandler_ThreadSwitch: // 0x037FBA28
	ldr ip, _037FBB44 // =_038083A4
	mov r3, #0
	ldr ip, [ip]
	mov r2, #1
	cmp ip, #0
	beq _037FBA78
_037FBA40:
	str r2, [ip, #0x48]
	str r3, [ip, #0x5c]
	str r3, [ip, #0x60]
	ldr r0, [ip, #0x64]
	str r3, [ip, #0x64]
	mov ip, r0
	cmp ip, #0
	bne _037FBA40
	ldr ip, _037FBB44 // =_038083A4
	str r3, [ip]
	str r3, [ip, #4]
	ldr ip, _037FBB48 // =0x03808434
	mov r1, #1
	strh r1, [ip]
_037FBA78:
	ldr ip, _037FBB48 // =0x03808434
	ldrh r1, [ip]
	cmp r1, #0
	ldreq pc, [sp], #4
	mov r1, #0
	strh r1, [ip]
	mov r3, #0xd2
	msr cpsr_c, r3
	add r2, ip, #8
	ldr r1, [r2]
_037FBAA0:
	cmp r1, #0
	ldrneh r0, [r1, #0x48]
	cmpne r0, #1
	ldrne r1, [r1, #0x4c]
	bne _037FBAA0
	cmp r1, #0
	bne _037FBAC8
_037FBABC:
	mov r3, #0x92
	msr cpsr_c, r3
	ldr pc, [sp], #4
_037FBAC8:
	ldr r0, [ip, #4]
	cmp r1, r0
	beq _037FBABC
	ldr r3, [ip, #0xc]
	cmp r3, #0
	beq _037FBAF0
	stmdb sp!, {r0, r1, ip}
	mov lr, pc
	bx r3
	arm_func_end OS_IrqHandler_ThreadSwitch

	arm_func_start sub_37FBAEC
sub_37FBAEC: // 0x037FBAEC
	ldmia sp!, {r0, r1, ip}
_037FBAF0:
	str r1, [ip, #4]
	mrs r2, spsr
	str r2, [r0, #0]!
	ldmib sp!, {r2, r3}
	stmib r0!, {r2, r3}
	ldmib sp!, {r2, r3, ip, lr}
	stmib r0!, {r2, r3, r4, r5, r6, r7, r8, sb, sl, fp, ip, sp, lr} ^
	stmib r0!, {lr}
	mov r3, #0xd3
	msr cpsr_c, r3
	stmib r0!, {sp}
	ldr sp, [r1, #0x44]
	mov r3, #0xd2
	msr cpsr_c, r3
	ldr r2, [r1, #0]!
	msr spsr_fc, r2
	ldr lr, [r1, #0x40]
	ldmib r1!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, sb, sl, fp, ip, sp, lr} ^
	mov r0, r0
	stmda sp!, {r0, r1, r2, r3, ip, lr}
	ldmia sp!, {pc}
	.align 2, 0
_037FBB44: .word _038083A4
_037FBB48: .word 0x03808434
	arm_func_end sub_37FBAEC

	.bss
	
.public _038083A4
_038083A4:
	.space 0x3A4C