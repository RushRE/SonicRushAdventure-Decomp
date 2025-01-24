	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public ov09_02175F00
ov09_02175F00: // 0x02175F00
	.space 0x02

exPlayerAdminTask__ActiveInstanceCount: // 0x02175F02
	.space 0x02

exBlzDushEffectTask__ActiveInstanceCount2: // 0x02175F04
	.space 0x02

exBlzDushEffectTask__ActiveInstanceCount: // 0x02175F06
	.space 0x02
	

	.align 4

exBlzDushEffectTask__unk_2175F08: // 0x02175F08
	.space 0x04

exBlzDushEffectTask__dword_2175F0C: // 0x02175F0C
	.space 0x04

exBlzDushEffectTask__unk_2175F10: // 0x02175F10
	.space 0x04

exBlzDushEffectTask__dword_2175F14: // 0x02175F14
	.space 0x04

exBlzDushEffectTask__TaskSingleton: // 0x02175F18
	.space 0x04

exBlzDushEffectTask__unk_2175F1C: // 0x02175F1C
	.space 0x04

exBlzDushEffectTask__unk_2175F20: // 0x02175F20
	.space 0x04

exBlzDushEffectTask__dword_2175F24: // 0x02175F24
	.space 0x04

exBlzDushEffectTask__FileTable: // 0x02175F28
	.space 0x04

exBlzDushEffectTask__dword_2175F2C: // 0x02175F2C
	.space 0x04

exPlayerAdminTask__dword_2175F30: // 0x02175F30
	.space 0x04

exPlayerAdminTask__unk_2175F34: // 0x02175F34
	.space 0x04

exPlayerAdminTask__dword_2175F38: // 0x02175F38
	.space 0x04

exBlzDushEffectTask__AnimTable: // 0x02175F3C
	.space 0x04
	.space 0x04
	.space 0x04

exBlzDushEffectTask__FileTable2: // 0x02175F48
	.space 0x04
	.space 0x04
	.space 0x04
	
	.text

	arm_func_start ovl09_2153584
ovl09_2153584: // 0x02153584
	stmdb sp!, {r4, lr}
	ldr r1, _021535E8 // =ov09_02175F00
	mov r4, r0
	ldrsh r0, [r1, #4]
	cmp r0, #1
	bne _021535C8
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	beq _021535AC
	bl NNS_G3dResDefaultRelease
_021535AC:
	ldr r1, _021535E8 // =ov09_02175F00
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r1, #0x2c]
	beq _021535C8
	bl _FreeHEAP_USER
_021535C8:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _021535E8 // =ov09_02175F00
	ldrsh r1, [r0, #4]
	cmp r1, #0
	subgt r1, r1, #1
	strgth r1, [r0, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021535E8: .word ov09_02175F00
	arm_func_end ovl09_2153584

	arm_func_start ovl09_21535EC
ovl09_21535EC: // 0x021535EC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02153C4C // =ov09_02175F00
	mov r4, r0
	str r4, [r1, #0x1c]
	ldr r0, [r1, #0xc]
	cmp r0, #0
	ldrne r0, [r1, #0x10]
	cmpne r0, #0
	beq _02153668
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02153C4C // =ov09_02175F00
	ldr r1, [r1, #0xc]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02153C4C // =ov09_02175F00
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02153C4C // =ov09_02175F00
	ldr r1, [r1, #0xc]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02153668:
	mov r0, r4
	bl ovl09_2161CB0
	ldr r0, _02153C4C // =ov09_02175F00
	ldrsh r0, [r0, #6]
	cmp r0, #0
	bne _02153714
	mov r1, #0x1b
	ldr r0, _02153C50 // =aExtraExBb
	sub r2, r1, #0x1c
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _02153C4C // =ov09_02175F00
	mov r0, r0, lsr #8
	str r0, [r1, #0xc]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02153C4C // =ov09_02175F00
	mov r0, r5
	str r1, [r2, #0x14]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x48
	bl ovl09_21733D4
	ldr r1, _02153C4C // =ov09_02175F00
	mov r2, #0
	str r0, [r1, #0x48]
	mov r0, #0x49
	str r2, [r1, #0x3c]
	bl ovl09_21733D4
	ldr r1, _02153C4C // =ov09_02175F00
	mov r2, #1
	str r0, [r1, #0x4c]
	mov r0, #0x4a
	str r2, [r1, #0x40]
	bl ovl09_21733D4
	ldr r1, _02153C4C // =ov09_02175F00
	mov r2, #4
	str r0, [r1, #0x50]
	str r2, [r1, #0x44]
	ldr r0, [r1, #0x14]
	bl Asset3DSetup__Create
_02153714:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02153C4C // =ov09_02175F00
	str r2, [sp]
	ldr r1, [r0, #0x14]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _02153C54 // =exBlzDushEffectTask__AnimTable
	ldr r5, _02153C58 // =exBlzDushEffectTask__FileTable2
	mov r7, r8
_0215374C:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #3
	blo _0215374C
	ldr r2, _02153C4C // =ov09_02175F00
	add r1, r4, #0x300
	ldr r3, [r2, #0x40]
	mov r0, #0
	strh r3, [r1, #0x48]
	ldr r1, [r2, #0x40]
	mov r3, #1
	add r1, r4, r1, lsl #2
	ldr r1, [r1, #0x104]
	str r1, [r4, #0x344]
_021537A0:
	mov r1, r3, lsl r0
	tst r1, #0x13
	beq _021537C0
	add r1, r4, r0, lsl #1
	add r1, r1, #0x100
	ldrh r2, [r1, #0x2c]
	orr r2, r2, #2
	strh r2, [r1, #0x2c]
_021537C0:
	add r0, r0, #1
	cmp r0, #5
	blo _021537A0
	mov r0, #0x3c000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	str r0, [r4, #0x370]
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _02153844
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _02153844
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _02153844
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153BE8
_02153844:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	beq _02153874
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _02153874
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	bne _02153884
_02153874:
	ldr r1, _02153C5C // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	b _02153BF4
_02153884:
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _021538E8
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _021538E8
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _021538E8
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _021538E8
	ldr r1, _02153C5C // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	b _02153BF4
_021538E8:
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02153958
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153958
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _02153958
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153958
	ldr r2, _02153C5C // =0x0000BFF4
	add r0, r4, #0x300
	ldr r1, _02153C60 // =0x00001FFE
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _02153BF4
_02153958:
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _021539C4
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _021539C4
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _021539C4
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _021539C4
	ldr r2, _02153C5C // =0x0000BFF4
	add r0, r4, #0x300
	ldr r1, _02153C64 // =0x00003FFC
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _02153BF4
_021539C4:
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02153A34
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153A34
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153A34
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _02153A34
	ldr r1, _02153C5C // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	mov r1, r1, lsr #1
	strh r1, [r0, #0x4c]
	b _02153BF4
_02153A34:
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02153AA0
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _02153AA0
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153AA0
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _02153AA0
	ldr r2, _02153C5C // =0x0000BFF4
	add r0, r4, #0x300
	ldr r1, _02153C68 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _02153BF4
_02153AA0:
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153B10
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _02153B10
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153B10
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _02153B10
	ldr r2, _02153C5C // =0x0000BFF4
	add r0, r4, #0x300
	ldr r1, _02153C6C // =0x00009FF6
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _02153BF4
_02153B10:
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153B78
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _02153B78
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _02153B78
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _02153B78
	ldr r1, _02153C5C // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _02153BF4
_02153B78:
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153BF4
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _02153BF4
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _02153BF4
	bl ovl09_216E3F4
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02153BF4
	ldr r2, _02153C5C // =0x0000BFF4
	add r0, r4, #0x300
	ldr r1, _02153C70 // =0x0000DFF2
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _02153BF4
_02153BE8:
	ldr r1, _02153C5C // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
_02153BF4:
	mov r3, #0
	strb r3, [r4]
	ldrb r2, [r4, #5]
	add r0, r4, #0x350
	ldr r1, _02153C4C // =ov09_02175F00
	bic r2, r2, #1
	orr r2, r2, #1
	strb r2, [r4, #5]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r0, [r4, #0x18]
	ldrb r2, [r4, #0x38c]
	mov r0, #1
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r4, #0x38c]
	ldrsh r2, [r1, #6]
	add r2, r2, #1
	strh r2, [r1, #6]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02153C4C: .word ov09_02175F00
_02153C50: .word aExtraExBb
_02153C54: .word exBlzDushEffectTask__AnimTable
_02153C58: .word exBlzDushEffectTask__FileTable2
_02153C5C: .word 0x0000BFF4
_02153C60: .word 0x00001FFE
_02153C64: .word 0x00003FFC
_02153C68: .word 0x00007FF8
_02153C6C: .word 0x00009FF6
_02153C70: .word 0x0000DFF2
	arm_func_end ovl09_21535EC

	arm_func_start ovl09_2153C74
ovl09_2153C74: // 0x02153C74
	stmdb sp!, {r4, lr}
	ldr r1, _02153D18 // =ov09_02175F00
	mov r4, r0
	ldrsh r0, [r1, #6]
	cmp r0, #1
	bgt _02153CF8
	ldr r0, [r1, #0x14]
	cmp r0, #0
	beq _02153C9C
	bl NNS_G3dResDefaultRelease
_02153C9C:
	ldr r0, _02153D18 // =ov09_02175F00
	ldr r0, [r0, #0x48]
	cmp r0, #0
	beq _02153CB0
	bl NNS_G3dResDefaultRelease
_02153CB0:
	ldr r0, _02153D18 // =ov09_02175F00
	ldr r0, [r0, #0x4c]
	cmp r0, #0
	beq _02153CC4
	bl NNS_G3dResDefaultRelease
_02153CC4:
	ldr r0, _02153D18 // =ov09_02175F00
	ldr r0, [r0, #0x50]
	cmp r0, #0
	beq _02153CD8
	bl NNS_G3dResDefaultRelease
_02153CD8:
	ldr r0, _02153D18 // =ov09_02175F00
	ldr r0, [r0, #0x14]
	cmp r0, #0
	beq _02153CEC
	bl _FreeHEAP_USER
_02153CEC:
	ldr r0, _02153D18 // =ov09_02175F00
	mov r1, #0
	str r1, [r0, #0x14]
_02153CF8:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02153D18 // =ov09_02175F00
	ldrsh r1, [r0, #6]
	cmp r1, #0
	subgt r1, r1, #1
	strgth r1, [r0, #6]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153D18: .word ov09_02175F00
	arm_func_end ovl09_2153C74

	arm_func_start exBlzDushEffectTask__Main
exBlzDushEffectTask__Main: // 0x02153D1C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02153D60 // =ov09_02175F00
	str r0, [r1, #0x18]
	add r0, r4, #4
	bl ovl09_21535EC
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl ovl09_21641F0
	bl GetExTaskCurrent
	ldr r1, _02153D64 // =ovl09_2153DB4
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153D60: .word ov09_02175F00
_02153D64: .word ovl09_2153DB4
	arm_func_end exBlzDushEffectTask__Main

	arm_func_start exBlzDushEffectTask__Func8
exBlzDushEffectTask__Func8: // 0x02153D68
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02153D8C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153D8C: .word ExTask_State_Destroy
	arm_func_end exBlzDushEffectTask__Func8

	arm_func_start exBlzDushEffectTask__Destructor
exBlzDushEffectTask__Destructor: // 0x02153D90
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl ovl09_2153C74
	ldr r0, _02153DB0 // =ov09_02175F00
	mov r1, #0
	str r1, [r0, #0x18]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153DB0: .word ov09_02175F00
	arm_func_end exBlzDushEffectTask__Destructor

	arm_func_start ovl09_2153DB4
ovl09_2153DB4: // 0x02153DB4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl ovl09_2162164
	ldr r1, [r4, #0x4e0]
	add r0, r4, #4
	ldr r1, [r1, #0x350]
	str r1, [r4, #0x354]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x354]
	str r1, [r4, #0x358]
	ldr r1, [r4, #0x4e0]
	ldr r1, [r1, #0x358]
	str r1, [r4, #0x35c]
	bl ovl09_21623F8
	cmp r0, #0
	beq _02153E0C
	bl GetExTaskCurrent
	ldr r1, _02153E28 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02153E0C:
	add r0, r4, #4
	add r1, r4, #0x390
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02153E28: .word ExTask_State_Destroy
	arm_func_end ovl09_2153DB4

	arm_func_start exBlzDushEffectTask__Create
exBlzDushEffectTask__Create: // 0x02153E2C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr r1, _02153EC4 // =ov09_02175F00
	mov r4, r0
	ldr r0, [r1, #0x18]
	cmp r0, #0
	beq _02153E4C
	bl ovl09_2153EDC
_02153E4C:
	cmp r4, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r5, #0
	ldr r1, _02153EC8 // =0x000004E4
	str r5, [sp]
	str r1, [sp, #4]
	ldr r0, _02153ECC // =aExblzdusheffec
	ldr r1, _02153ED0 // =exBlzDushEffectTask__Destructor
	str r0, [sp, #8]
	ldr r0, _02153ED4 // =exBlzDushEffectTask__Main
	mov r2, #0x2000
	mov r3, #5
	str r5, [sp, #0xc]
	bl ExTaskCreate_
	mov r6, r0
	bl GetExTaskWork_
	mov r1, r5
	ldr r2, _02153EC8 // =0x000004E4
	mov r5, r0
	bl MI_CpuFill8
	mov r0, r6
	str r4, [r5, #0x4e0]
	bl GetExTask
	ldr r1, _02153ED8 // =exBlzDushEffectTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02153EC4: .word ov09_02175F00
_02153EC8: .word 0x000004E4
_02153ECC: .word aExblzdusheffec
_02153ED0: .word exBlzDushEffectTask__Destructor
_02153ED4: .word exBlzDushEffectTask__Main
_02153ED8: .word exBlzDushEffectTask__Func8
	arm_func_end exBlzDushEffectTask__Create

	arm_func_start ovl09_2153EDC
ovl09_2153EDC: // 0x02153EDC
	stmdb sp!, {r3, lr}
	ldr r0, _02153F00 // =ov09_02175F00
	ldr r0, [r0, #0x18]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _02153F04 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02153F00: .word ov09_02175F00
_02153F04: .word ExTask_State_Destroy
	arm_func_end ovl09_2153EDC

	arm_func_start ovl09_2153F08
ovl09_2153F08: // 0x02153F08
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	bl ovl09_21636BC
	ldr r0, _02154004 // =ov09_02175F00
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02153F38
	mov r0, #0
	bl ovl09_21733D4
	ldr r1, _02154004 // =ov09_02175F00
	str r0, [r1, #0x24]
_02153F38:
	ldr r0, _02154004 // =ov09_02175F00
	mov r1, #1
	ldr r0, [r0, #0x24]
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	ldr r1, _02154004 // =ov09_02175F00
	mov r5, r0
	ldr r0, [r1, #0x24]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	ldr r2, _02154004 // =ov09_02175F00
	add r0, r4, #0x20
	ldr r2, [r2, #0x24]
	mov r1, #0
	mov r3, #0xf
	bl AnimatorSprite3D__Init
	ldr r0, [r4, #0x114]
	mov r3, #0
	orr r0, r0, #0x800
	str r0, [r4, #0x114]
	strb r3, [r4]
	ldrb r2, [r4, #5]
	mov r1, #0x46000
	ldr r0, _02154008 // =0x00000333
	orr r2, r2, #4
	strb r2, [r4, #5]
	str r1, [r4, #0x134]
	str r0, [r4, #0x138]
	str r0, [r4, #0x13c]
	str r0, [r4, #0x140]
	ldrb r2, [r4, #0x150]
	ldr r0, _02154004 // =ov09_02175F00
	add r1, r4, #0x12c
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r4, #0x150]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r1, [r4, #0x18]
	ldrsh r1, [r0, #0]
	add r1, r1, #1
	strh r1, [r0]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02154004: .word ov09_02175F00
_02154008: .word 0x00000333
	arm_func_end ovl09_2153F08

	arm_func_start ovl09_215400C
ovl09_215400C: // 0x0215400C
	stmdb sp!, {r3, lr}
	add r0, r0, #0x20
	bl AnimatorSprite3D__Release
	ldr r0, _0215402C // =ov09_02175F00
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215402C: .word ov09_02175F00
	arm_func_end ovl09_215400C
	
	.data

aExtraExBb: // 0x02173E60
	.asciz "/extra/ex.bb"
	.align 4

aExblzdusheffec: // 0x02173E70
	.asciz "exBlzDushEffectTask"