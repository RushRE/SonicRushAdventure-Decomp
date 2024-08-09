	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start TouchField__Init
TouchField__Init: // 0x0206E6BC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x18
	bl MIi_CpuClear32
	mov r0, #1
	str r0, [r4, #0xc]
	mov r0, #0xf
	strb r0, [r4, #0x10]
	mov r1, #2
	strb r1, [r4, #0x11]
	mov r0, #4
	strb r0, [r4, #0x12]
	mov r0, #0x14
	strb r0, [r4, #0x13]
	strb r1, [r4, #0x14]
	ldmia sp!, {r4, pc}
	arm_func_end TouchField__Init

	arm_func_start TouchField__Process
TouchField__Process: // 0x0206E704
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r0, [r5, #4]
	ldr r4, [r5]
	tst r0, #1
	movne r1, #2
	moveq r1, #0
	ldr r0, _0206E820 // =touchInput
	str r1, [r5, #4]
	ldrh r0, [r0, #0x12]
	tst r0, #1
	ldrne r0, [r5, #4]
	orrne r0, r0, #1
	strne r0, [r5, #4]
	ldr r0, [r5, #4]
	tst r0, #1
	beq _0206E76C
	tst r0, #2
	bne _0206E76C
	orr r1, r0, #4
	ldr r0, _0206E820 // =touchInput
	str r1, [r5, #4]
	ldrh r1, [r0, #0x14]
	strh r1, [r5, #8]
	ldrh r0, [r0, #0x16]
	strh r0, [r5, #0xa]
_0206E76C:
	ldr r0, [r5, #4]
	tst r0, #1
	bne _0206E784
	tst r0, #2
	orrne r0, r0, #8
	strne r0, [r5, #4]
_0206E784:
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r5, #0xc]
	mov r6, #1
	cmp r0, #0
	beq _0206E7C0
_0206E79C:
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl TouchField__ProcessSingle
	ldr r4, [r4]
	ldr r0, [r5]
	cmp r0, r4
	bne _0206E79C
	ldmia sp!, {r4, r5, r6, pc}
_0206E7C0:
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl TouchField__ProcessSingle
	cmp r0, #0
	ldrne r4, [r4]
	bne _0206E7EC
	ldr r4, [r4]
	ldr r0, [r5]
	cmp r0, r4
	bne _0206E7C0
_0206E7EC:
	ldr r0, [r5]
	cmp r0, r4
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r6, #0
_0206E7FC:
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl TouchField__ProcessSingle
	ldr r4, [r4]
	ldr r0, [r5]
	cmp r0, r4
	bne _0206E7FC
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0206E820: .word touchInput
	arm_func_end TouchField__Process

	arm_func_start TouchField__InitAreaShape
TouchField__InitAreaShape: // 0x0206E824
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r1
	mov r6, r2
	mov r1, #0
	mov r2, #0x38
	mov r4, r0
	mov r5, r3
	bl MI_CpuFill8
	cmp r7, #0
	beq _0206E85C
	ldrsh r1, [r7, #2]
	ldrsh r0, [r7]
	strh r0, [r4, #0x24]
	strh r1, [r4, #0x26]
_0206E85C:
	str r6, [r4, #8]
	cmp r5, #0
	beq _0206E874
	mov r0, r4
	mov r1, r5
	bl TouchField__SetHitbox
_0206E874:
	mov r0, r4
	bl TouchField__ResetArea
	ldr r1, [sp, #0x18]
	ldr r0, [sp, #0x1c]
	str r1, [r4, #0xc]
	str r0, [r4, #0x10]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end TouchField__InitAreaShape

	arm_func_start TouchField__ResetArea
TouchField__ResetArea: // 0x0206E890
	ldr r2, _0206E8A8 // =0x0000FFFF
	mov r1, #0
	strh r2, [r0, #0x22]
	str r1, [r0, #0x14]
	str r1, [r0, #0x18]
	bx lr
	.align 2, 0
_0206E8A8: .word 0x0000FFFF
	arm_func_end TouchField__ResetArea

	arm_func_start TouchField__SetHitbox
TouchField__SetHitbox: // 0x0206E8AC
	ldr ip, _0206E8C4 // =MI_CpuCopy8
	mov r2, r0
	mov r0, r1
	add r1, r2, #0x28
	mov r2, #0x10
	bx ip
	.align 2, 0
_0206E8C4: .word MI_CpuCopy8
	arm_func_end TouchField__SetHitbox

	arm_func_start TouchField__InitAreaSprite
TouchField__InitAreaSprite: // 0x0206E8C8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r7, r1
	mov r6, r2
	mov r4, r0
	mov r1, #0
	mov r2, #0x38
	mov r5, r3
	bl MI_CpuFill8
	str r7, [r4, #0x24]
	strh r6, [r4, #0x28]
	strh r5, [r4, #0x2a]
	mvn r0, #0
	strh r0, [r4, #0x32]
	ldrsh r0, [r4, #0x32]
	strh r0, [r4, #0x30]
	ldrh r0, [r4, #0x2a]
	tst r0, #1
	bne _0206E920
	mov r0, r7
	mov r1, r6
	add r2, r4, #0x2c
	bl AnimatorSprite__GetBlockData
_0206E920:
	ldr r1, _0206E944 // =TouchField__PointInAnimator
	mov r0, r4
	str r1, [r4, #8]
	bl TouchField__ResetArea
	ldr r1, [sp, #0x18]
	ldr r0, [sp, #0x1c]
	str r1, [r4, #0xc]
	str r0, [r4, #0x10]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206E944: .word TouchField__PointInAnimator
	arm_func_end TouchField__InitAreaSprite

	arm_func_start TouchField__SetAreaHitbox
TouchField__SetAreaHitbox: // 0x0206E948
	ldr ip, _0206E960 // =MIi_CpuCopy16
	mov r2, r0
	mov r0, r1
	add r1, r2, #0x2c
	mov r2, #8
	bx ip
	.align 2, 0
_0206E960: .word MIi_CpuCopy16
	arm_func_end TouchField__SetAreaHitbox

	arm_func_start TouchField__AddArea
TouchField__AddArea: // 0x0206E964
	stmdb sp!, {r3, lr}
	strh r2, [r1, #0x20]
	ldr lr, [r0]
	mov ip, lr
	cmp lr, #0
	bne _0206E98C
	str r1, [r1]
	str r1, [r1, #4]
	str r1, [r0]
	ldmia sp!, {r3, pc}
_0206E98C:
	ldr r3, _0206EA08 // =0x0000FFFF
	cmp r2, r3
	bne _0206E9B8
	str lr, [r1]
	ldr r0, [lr, #4]
	str r0, [r1, #4]
	str r1, [r0]
	ldmia r1, {r0, r2}
	ldr r1, [r2]
	str r1, [r0, #4]
	ldmia sp!, {r3, pc}
_0206E9B8:
	ldrh r3, [lr, #0x20]
	cmp r2, r3
	strlo r1, [r0]
	blo _0206E9E8
	cmp r3, r2
	bhi _0206E9E8
_0206E9D0:
	ldr ip, [ip]
	cmp lr, ip
	beq _0206E9E8
	ldrh r0, [ip, #0x20]
	cmp r0, r2
	bls _0206E9D0
_0206E9E8:
	str ip, [r1]
	ldr r0, [ip, #4]
	str r0, [r1, #4]
	str r1, [r0]
	ldmia r1, {r0, r2}
	ldr r1, [r2]
	str r1, [r0, #4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206EA08: .word 0x0000FFFF
	arm_func_end TouchField__AddArea

	arm_func_start TouchField__RemoveArea
TouchField__RemoveArea: // 0x0206EA0C
	ldmia r1, {r2, r3}
	str r3, [r2, #4]
	ldr r3, [r1]
	ldr r2, [r1, #4]
	str r3, [r2]
	ldr r2, [r0]
	cmp r2, r1
	bxne lr
	ldr r2, [r1]
	cmp r1, r2
	strne r2, [r0]
	moveq r1, #0
	streq r1, [r0]
	bx lr
	arm_func_end TouchField__RemoveArea

	arm_func_start TouchField__UpdateAreaPriority
TouchField__UpdateAreaPriority: // 0x0206EA44
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl TouchField__RemoveArea
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl TouchField__AddArea
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end TouchField__UpdateAreaPriority

	arm_func_start TouchField__Func_206EA6C
TouchField__Func_206EA6C: // 0x0206EA6C
	stmdb sp!, {r3, lr}
	mov r2, r0
	ldr r0, [r2, #0x14]
	orr r1, r0, #0x400
	bic r0, r1, #0x800
	str r0, [r2, #0x14]
	tst r0, #0x10
	ldmneia sp!, {r3, pc}
	ldr r0, _0206EAA0 // =0x021413FA
	add r1, r2, #0x1c
	mov r2, #4
	bl MIi_CpuCopy16
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206EAA0: .word 0x021413FA
	arm_func_end TouchField__Func_206EA6C

	arm_func_start TouchField__Func_206EAA4
TouchField__Func_206EAA4: // 0x0206EAA4
	ldr r1, [r0, #0x14]
	bic r1, r1, #0x400
	str r1, [r0, #0x14]
	tst r1, #0x10
	ldrne r1, [r0, #0x14]
	orrne r1, r1, #0x800
	strne r1, [r0, #0x14]
	bx lr
	arm_func_end TouchField__Func_206EAA4

	arm_func_start TouchField__Func_206EAC4
TouchField__Func_206EAC4: // 0x0206EAC4
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl TouchField__Func_206EA6C
	mov r0, r4
	bl TouchField__Func_206EAA4
	ldmia sp!, {r4, pc}
	arm_func_end TouchField__Func_206EAC4

	arm_func_start TouchField__PointInRect
TouchField__PointInRect: // 0x0206EADC
	stmdb sp!, {r4, lr}
	ldr r1, _0206EB6C // =touchInput
	ldrsh ip, [r0, #0x24]
	ldrsh r2, [r0, #0x28]
	ldrh r3, [r1, #0x14]
	mov r1, #0
	add r2, ip, r2
	cmp r2, r3
	ldrlesh r2, [r0, #0x2c]
	mov r4, r1
	mov lr, r1
	addle r2, ip, r2
	cmple r3, r2
	movle r4, #1
	cmp r4, #0
	beq _0206EB38
	ldr r2, _0206EB6C // =touchInput
	ldrsh ip, [r0, #0x26]
	ldrsh r3, [r0, #0x2a]
	ldrh r2, [r2, #0x16]
	add r3, ip, r3
	cmp r3, r2
	movle lr, #1
_0206EB38:
	cmp lr, #0
	beq _0206EB5C
	ldr r2, _0206EB6C // =touchInput
	ldrsh r3, [r0, #0x26]
	ldrsh r0, [r0, #0x2e]
	ldrh r2, [r2, #0x16]
	add r0, r3, r0
	cmp r2, r0
	movle r1, #1
_0206EB5C:
	cmp r1, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206EB6C: .word touchInput
	arm_func_end TouchField__PointInRect

	arm_func_start TouchField__PointInCircle
TouchField__PointInCircle: // 0x0206EB70
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r1, _0206EC50 // =touchInput
	ldrsh r4, [r0, #0x26]
	ldrh r2, [r1, #0x16]
	ldrsh r3, [r0, #0x24]
	ldrh r1, [r1, #0x14]
	sub r2, r4, r2
	mov r2, r2, lsl #0xc
	sub r1, r3, r1
	movs r1, r1, lsl #0xc
	rsbmi r1, r1, #0
	cmp r2, #0
	rsblt r2, r2, #0
	cmp r2, r1
	ldr r3, _0206EC54 // =0x00000F5E
	ldr ip, _0206EC58 // =0x0000065D
	mov lr, #0
	bge _0206EBF8
	umull r7, r6, r1, r3
	mla r6, r1, lr, r6
	umull r5, r4, r2, ip
	mov r1, r1, asr #0x1f
	mla r6, r1, r3, r6
	adds r7, r7, #0x800
	adc r6, r6, #0
	adds r3, r5, #0x800
	mov r5, r7, lsr #0xc
	mla r4, r2, lr, r4
	mov r1, r2, asr #0x1f
	mla r4, r1, ip, r4
	adc r1, r4, #0
	mov r2, r3, lsr #0xc
	orr r5, r5, r6, lsl #20
	b _0206EC34
_0206EBF8:
	umull r7, r6, r2, r3
	mla r6, r2, lr, r6
	umull r5, r4, r1, ip
	mla r4, r1, lr, r4
	mov r2, r2, asr #0x1f
	mov r1, r1, asr #0x1f
	mla r6, r2, r3, r6
	adds r7, r7, #0x800
	adc r3, r6, #0
	adds r2, r5, #0x800
	mla r4, r1, ip, r4
	mov r5, r7, lsr #0xc
	adc r1, r4, #0
	mov r2, r2, lsr #0xc
	orr r5, r5, r3, lsl #20
_0206EC34:
	orr r2, r2, r1, lsl #20
	ldr r0, [r0, #0x28]
	add r1, r5, r2
	cmp r1, r0
	movle r0, #1
	movgt r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206EC50: .word touchInput
_0206EC54: .word 0x00000F5E
_0206EC58: .word 0x0000065D
	arm_func_end TouchField__PointInCircle

	arm_func_start TouchField__PointInAnimator
TouchField__PointInAnimator: // 0x0206EC5C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldr r0, [r4, #0x24]
	ldr r1, [r0, #0x3c]
	tst r1, #1
	beq _0206EC84
	ldrh r1, [r4, #0x2a]
	tst r1, #8
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
_0206EC84:
	ldr r1, _0206EE20 // =0x04000304
	ldrh r1, [r1]
	and r1, r1, #0x8000
	mov r1, r1, asr #0xf
	cmp r1, #1
	bne _0206ECA8
	ldr r1, [r0, #4]
	cmp r1, #1
	bne _0206ECC8
_0206ECA8:
	ldr r1, _0206EE20 // =0x04000304
	ldrh r1, [r1]
	and r1, r1, #0x8000
	movs r1, r1, asr #0xf
	bne _0206ECD8
	ldr r1, [r0, #4]
	cmp r1, #0
	beq _0206ECD8
_0206ECC8:
	ldrh r1, [r4, #0x2a]
	tst r1, #0x10
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
_0206ECD8:
	ldrh r1, [r4, #0x2a]
	tst r1, #2
	bne _0206ED1C
	ldrh r1, [r4, #0x28]
	add r2, r4, #0x2c
	bl AnimatorSprite__GetBlockData
	cmp r0, #0
	beq _0206ED1C
	ldrh r0, [r4, #0x2a]
	tst r0, #4
	beq _0206ED1C
	ldrsh r0, [r4, #0x2c]
	sub r0, r0, #1
	strh r0, [r4, #0x30]
	ldrsh r0, [r4, #0x2e]
	sub r0, r0, #1
	strh r0, [r4, #0x32]
_0206ED1C:
	ldr r3, [r4, #0x24]
	ldr r5, [r3, #0x3c]
	tst r5, #0x100
	beq _0206ED5C
	ldrh r0, [r4, #0x2a]
	tst r0, #0x20
	bne _0206ED5C
	ldrsh r1, [r4, #0x32]
	ldrsh r0, [r4, #0x2e]
	rsb r2, r1, #0
	rsb r1, r0, #0
	mov r0, r2, lsl #0x10
	mov r2, r1, lsl #0x10
	mov r1, r0, asr #0x10
	mov r2, r2, asr #0x10
	b _0206ED64
_0206ED5C:
	ldrsh r1, [r4, #0x2e]
	ldrsh r2, [r4, #0x32]
_0206ED64:
	tst r5, #0x80
	beq _0206ED9C
	ldrh r0, [r4, #0x2a]
	tst r0, #0x40
	bne _0206ED9C
	ldrsh ip, [r4, #0x30]
	ldrsh r0, [r4, #0x2c]
	rsb ip, ip, #0
	rsb r4, r0, #0
	mov r0, ip, lsl #0x10
	mov r4, r4, lsl #0x10
	mov r5, r0, asr #0x10
	mov r7, r4, asr #0x10
	b _0206EDA4
_0206ED9C:
	ldrsh r5, [r4, #0x2c]
	ldrsh r7, [r4, #0x30]
_0206EDA4:
	ldr r0, _0206EE24 // =touchInput
	ldrsh lr, [r3, #8]
	ldrh ip, [r0, #0x14]
	mov r0, #0
	add r4, lr, r5
	cmp r4, ip
	addle r4, lr, r7
	mov r6, r0
	cmple ip, r4
	movle r6, #1
	mov r5, r0
	cmp r6, #0
	beq _0206EDF0
	ldr r4, _0206EE24 // =touchInput
	ldrsh ip, [r3, #0xa]
	ldrh r4, [r4, #0x16]
	add r1, ip, r1
	cmp r1, r4
	movle r5, #1
_0206EDF0:
	cmp r5, #0
	beq _0206EE10
	ldr r1, _0206EE24 // =touchInput
	ldrsh r3, [r3, #0xa]
	ldrh r4, [r1, #0x16]
	add r1, r3, r2
	cmp r4, r1
	movle r0, #1
_0206EE10:
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206EE20: .word 0x04000304
_0206EE24: .word touchInput
	arm_func_end TouchField__PointInAnimator

	arm_func_start TouchField__ProcessSingle
TouchField__ProcessSingle: // 0x0206EE28
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov sb, r1
	ldr r1, [sb, #0x14]
	mov r4, r0
	tst r1, #0x40
	movne r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	tst r1, #0x80
	movne r2, #0
	str r1, [sb, #0x18]
	cmp r2, #0
	beq _0206EE8C
	ldr r0, [r4, #4]
	tst r0, #1
	beq _0206EE8C
	ldr r1, [sb, #8]
	mov r0, sb
	blx r1
	cmp r0, #0
	beq _0206EE8C
	ldr r0, [sb, #0x18]
	and r0, r0, #0xc0
	orr r0, r0, #0x10
	str r0, [sb, #0x14]
	b _0206EE98
_0206EE8C:
	ldr r0, [sb, #0x18]
	and r0, r0, #0xc0
	str r0, [sb, #0x14]
_0206EE98:
	ldr r0, [sb, #0x18]
	tst r0, #0x10
	ldrne r0, [sb, #0x14]
	orrne r0, r0, #0x20
	strne r0, [sb, #0x14]
	ldr r0, [sb, #0x18]
	ldr r1, [sb, #0x14]
	tst r0, #0x1000000
	andne r0, r0, #0x1000
	andeq r0, r0, #0x3c00
	orr r0, r1, r0
	str r0, [sb, #0x14]
	ldr r0, [sb, #0x14]
	ands r1, r0, #0x10
	bne _0206EEE0
	ldr r0, [sb, #0x18]
	tst r0, #0x10
	beq _0206F0A4
_0206EEE0:
	cmp r1, #0
	beq _0206EF94
	ldr r0, [sb, #0x18]
	tst r0, #0x10
	bne _0206EF94
	ldr r0, [sb, #0x14]
	orr r0, r0, #0x10000
	str r0, [sb, #0x14]
	ldr r0, [r4, #4]
	tst r0, #4
	movne r1, #0x400000
	ldr r0, [sb, #0x14]
	moveq r1, #0x2000000
	orr r0, r0, r1
	orr r0, r0, #0x200000
	str r0, [sb, #0x14]
	ldrb r0, [r4, #0x13]
	strh r0, [sb, #0x22]
	ldr r0, [sb, #0x14]
	tst r0, #0x400
	bne _0206EF48
	ldr r0, _0206F298 // =0x021413FA
	add r1, sb, #0x1c
	mov r2, #4
	bl MIi_CpuCopy16
	b _0206F0A4
_0206EF48:
	ldr r0, _0206F29C // =touchInput
	ldrsh r1, [sb, #0x1c]
	ldrsh r0, [r0, #0x14]
	ldrb r2, [r4, #0x11]
	subs r0, r0, r1
	rsbmi r0, r0, #0
	cmp r2, r0
	ble _0206EF84
	ldr r0, _0206F29C // =touchInput
	ldrsh r1, [sb, #0x1e]
	ldrsh r0, [r0, #0x16]
	subs r0, r0, r1
	rsbmi r0, r0, #0
	cmp r2, r0
	bgt _0206F0A4
_0206EF84:
	ldr r0, [sb, #0x14]
	orr r0, r0, #0x4800000
	str r0, [sb, #0x14]
	b _0206F0A4
_0206EF94:
	cmp r1, #0
	bne _0206EFDC
	ldr r0, [sb, #0x18]
	tst r0, #0x10
	beq _0206EFDC
	ldr r0, [sb, #0x14]
	orr r0, r0, #0x20000
	str r0, [sb, #0x14]
	ldr r0, [r4, #4]
	ldr r1, [sb, #0x14]
	tst r0, #8
	movne r2, #0x1000000
	moveq r2, #0x8000000
	orr r1, r1, r2
	ldr r0, _0206F2A0 // =0x0000FFFF
	str r1, [sb, #0x14]
	strh r0, [sb, #0x22]
	b _0206F0A4
_0206EFDC:
	cmp r1, #0
	beq _0206F0A4
	ldr r0, [sb, #0x18]
	tst r0, #0x10
	beq _0206F0A4
	ldr r0, _0206F29C // =touchInput
	ldrsh r1, [sb, #0x1c]
	ldrsh r0, [r0, #0x14]
	ldrb r2, [r4, #0x11]
	subs r0, r0, r1
	rsbmi r0, r0, #0
	cmp r2, r0
	ble _0206F02C
	ldr r0, _0206F29C // =touchInput
	ldrsh r1, [sb, #0x1e]
	ldrsh r0, [r0, #0x16]
	subs r0, r0, r1
	rsbmi r0, r0, #0
	cmp r2, r0
	bgt _0206F038
_0206F02C:
	ldr r0, [sb, #0x14]
	orr r0, r0, #0x4000000
	str r0, [sb, #0x14]
_0206F038:
	ldr r0, [sb, #0x18]
	tst r0, #0x800
	bne _0206F08C
	ldr r0, _0206F29C // =touchInput
	ldrsh r1, [r4, #8]
	ldrsh r0, [r0, #0x14]
	ldrb r2, [r4, #0x12]
	subs r0, r0, r1
	rsbmi r0, r0, #0
	cmp r2, r0
	ble _0206F080
	ldr r0, _0206F29C // =touchInput
	ldrsh r1, [r4, #0xa]
	ldrsh r0, [r0, #0x16]
	subs r0, r0, r1
	rsbmi r0, r0, #0
	cmp r2, r0
	bgt _0206F08C
_0206F080:
	ldr r0, [sb, #0x14]
	orr r0, r0, #0x400
	str r0, [sb, #0x14]
_0206F08C:
	ldr r0, [sb, #0x14]
	tst r0, #0x400
	beq _0206F0A4
	tst r0, #0x800
	orrne r0, r0, #0x800000
	strne r0, [sb, #0x14]
_0206F0A4:
	ldr r2, [sb, #0x14]
	tst r2, #0x400000
	beq _0206F0F4
	tst r2, #0x1000
	ldrneh r1, [sb, #0x22]
	ldrne r0, _0206F2A0 // =0x0000FFFF
	cmpne r1, r0
	beq _0206F0D8
	orr r1, r2, #0x2000
	orr r1, r1, #0x100000
	bic r1, r1, #0x1000
	str r1, [sb, #0x14]
	strh r0, [sb, #0x22]
_0206F0D8:
	ldrb r0, [r4, #0x12]
	cmp r0, #0
	bne _0206F1C4
	ldr r0, [sb, #0x14]
	orr r0, r0, #0x400
	str r0, [sb, #0x14]
	b _0206F1C4
_0206F0F4:
	tst r2, #0x1000000
	beq _0206F124
	ldr r0, [sb, #0x18]
	tst r0, #0x800
	bne _0206F1C4
	tst r2, #0x2000
	bne _0206F1C4
	orr r0, r2, #0x41000
	str r0, [sb, #0x14]
	ldrb r0, [r4, #0x10]
	strh r0, [sb, #0x22]
	b _0206F1C4
_0206F124:
	tst r2, #0x400
	beq _0206F19C
	ldr r0, [r4, #4]
	tst r0, #1
	beq _0206F180
	ldr r0, _0206F29C // =touchInput
	ldrsh r1, [sb, #0x1c]
	ldrsh r0, [r0, #0x14]
	ldrb r2, [r4, #0x11]
	subs r0, r0, r1
	rsbmi r0, r0, #0
	cmp r2, r0
	ble _0206F174
	ldr r0, _0206F29C // =touchInput
	ldrsh r1, [sb, #0x1e]
	ldrsh r0, [r0, #0x16]
	subs r0, r0, r1
	rsbmi r0, r0, #0
	cmp r2, r0
	bgt _0206F180
_0206F174:
	ldr r0, [sb, #0x14]
	orr r0, r0, #0x800000
	str r0, [sb, #0x14]
_0206F180:
	ldr r0, [r4, #4]
	tst r0, #8
	beq _0206F1C4
	ldr r0, [sb, #0x14]
	orr r0, r0, #0x1000000
	str r0, [sb, #0x14]
	b _0206F1C4
_0206F19C:
	tst r2, #0x2000000
	beq _0206F1B4
	orr r0, r2, #0x800
	orr r0, r0, #0x4000000
	str r0, [sb, #0x14]
	b _0206F1C4
_0206F1B4:
	ldr r0, [sb, #0x18]
	tst r0, #0x8000000
	bicne r0, r2, #0x2800
	strne r0, [sb, #0x14]
_0206F1C4:
	ldrh r1, [sb, #0x22]
	ldr r0, _0206F2A0 // =0x0000FFFF
	cmp r1, r0
	beq _0206F210
	sub r0, r1, #1
	strh r0, [sb, #0x22]
	cmp r1, #0
	bne _0206F210
	ldr r0, [sb, #0x14]
	tst r0, #0x1000
	beq _0206F200
	orr r0, r0, #0x80000
	bic r0, r0, #0x1000
	str r0, [sb, #0x14]
	b _0206F210
_0206F200:
	orr r0, r0, #0x200000
	str r0, [sb, #0x14]
	ldrb r0, [r4, #0x14]
	strh r0, [sb, #0x22]
_0206F210:
	ldr r8, [sb, #0xc]
	cmp r8, #0
	beq _0206F268
	ldr r6, [sb, #0x10]
	ldr r4, _0206F2A4 // =_021116E8
	mov r7, #0x10000
	mov r5, #0
_0206F22C:
	ldr r0, [sb, #0x14]
	tst r0, r7
	beq _0206F250
	ldr ip, [r4, r5, lsl #2]
	mov r0, r7
	mov r1, sb
	mov r2, r8
	mov r3, r6
	blx ip
_0206F250:
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #0xc
	mov r7, r7, lsl #1
	blo _0206F22C
_0206F268:
	ldr r0, [sb, #0x14]
	tst r0, #0x4800000
	beq _0206F284
	ldr r0, _0206F298 // =0x021413FA
	add r1, sb, #0x1c
	mov r2, #4
	bl MIi_CpuCopy16
_0206F284:
	ldr r0, [sb, #0x14]
	tst r0, #0x10
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_0206F298: .word 0x021413FA
_0206F29C: .word touchInput
_0206F2A0: .word 0x0000FFFF
_0206F2A4: .word _021116E8
	arm_func_end TouchField__ProcessSingle

	arm_func_start TouchField__Func_206F2A8
TouchField__Func_206F2A8: // 0x0206F2A8
	stmdb sp!, {r3, lr}
	str r0, [sp]
	mov ip, r2
	add r0, sp, #0
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	arm_func_end TouchField__Func_206F2A8

	arm_func_start TouchField__Func_206F2C4
TouchField__Func_206F2C4: // 0x0206F2C4
	stmdb sp!, {r3, lr}
	str r0, [sp]
	mov ip, r2
	add r0, sp, #0
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	arm_func_end TouchField__Func_206F2C4

	arm_func_start TouchField__Func_206F2E0
TouchField__Func_206F2E0: // 0x0206F2E0
	stmdb sp!, {r3, lr}
	str r0, [sp]
	mov ip, r2
	add r0, sp, #0
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	arm_func_end TouchField__Func_206F2E0

	arm_func_start TouchField__Func_206F2FC
TouchField__Func_206F2FC: // 0x0206F2FC
	stmdb sp!, {r3, lr}
	str r0, [sp]
	mov ip, r2
	add r0, sp, #0
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	arm_func_end TouchField__Func_206F2FC

	arm_func_start TouchField__Func_206F318
TouchField__Func_206F318: // 0x0206F318
	stmdb sp!, {r3, lr}
	str r0, [sp]
	mov ip, r2
	add r0, sp, #0
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	arm_func_end TouchField__Func_206F318

	arm_func_start TouchField__Func_206F334
TouchField__Func_206F334: // 0x0206F334
	stmdb sp!, {r3, lr}
	str r0, [sp]
	mov ip, r2
	add r0, sp, #0
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	arm_func_end TouchField__Func_206F334

	arm_func_start TouchField__Func_206F350
TouchField__Func_206F350: // 0x0206F350
	stmdb sp!, {r3, lr}
	str r0, [sp]
	mov ip, r2
	add r0, sp, #0
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	arm_func_end TouchField__Func_206F350

	arm_func_start TouchField__Func_206F36C
TouchField__Func_206F36C: // 0x0206F36C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr ip, _0206F3B4 // =touchInput
	str r0, [sp]
	ldrsh r4, [ip, #0x14]
	ldrsh lr, [r1, #0x1c]
	mov r5, r2
	add r0, sp, #0
	sub r2, r4, lr
	strh r2, [sp, #4]
	ldrsh lr, [ip, #0x16]
	ldrsh ip, [r1, #0x1e]
	mov r2, r3
	sub r3, lr, ip
	strh r3, [sp, #6]
	blx r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206F3B4: .word touchInput
	arm_func_end TouchField__Func_206F36C

	arm_func_start TouchField__Func_206F3B8
TouchField__Func_206F3B8: // 0x0206F3B8
	stmdb sp!, {r3, lr}
	str r0, [sp]
	mov ip, r2
	add r0, sp, #0
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	arm_func_end TouchField__Func_206F3B8

	arm_func_start TouchField__Func_206F3D4
TouchField__Func_206F3D4: // 0x0206F3D4
	stmdb sp!, {r3, lr}
	str r0, [sp]
	mov ip, r2
	add r0, sp, #0
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	arm_func_end TouchField__Func_206F3D4

	arm_func_start TouchField__Func_206F3F0
TouchField__Func_206F3F0: // 0x0206F3F0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr ip, _0206F438 // =touchInput
	str r0, [sp]
	ldrsh r4, [ip, #0x14]
	ldrsh lr, [r1, #0x1c]
	mov r5, r2
	add r0, sp, #0
	sub r2, r4, lr
	strh r2, [sp, #4]
	ldrsh lr, [ip, #0x16]
	ldrsh ip, [r1, #0x1e]
	mov r2, r3
	sub r3, lr, ip
	strh r3, [sp, #6]
	blx r5
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206F438: .word touchInput
	arm_func_end TouchField__Func_206F3F0

	arm_func_start TouchField__Func_206F43C
TouchField__Func_206F43C: // 0x0206F43C
	stmdb sp!, {r3, lr}
	str r0, [sp]
	mov ip, r2
	add r0, sp, #0
	mov r2, r3
	blx ip
	ldmia sp!, {r3, pc}
	arm_func_end TouchField__Func_206F43C

	.rodata

_021116E8: // 0x021116E8
    .word TouchField__Func_206F2A8, TouchField__Func_206F2C4
    .word TouchField__Func_206F2E0, TouchField__Func_206F2FC
    .word TouchField__Func_206F318, TouchField__Func_206F334
    .word TouchField__Func_206F350, TouchField__Func_206F36C
    .word TouchField__Func_206F3B8, TouchField__Func_206F3D4
    .word TouchField__Func_206F3F0, TouchField__Func_206F43C