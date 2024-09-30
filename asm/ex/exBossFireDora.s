	.include "asm/macros.inc"
	.include "global.inc"

	.bss

exBossSysAdminTask__ActiveInstanceCount: // 0x02175F54
	.space 0x02

exBossSysAdminTask__dword_2175F58: // 0x02175F58
	.space 0x04

exBossSysAdminTask__File_2175F5C: // 0x02175F5C
	.space 0x04

exBossSysAdminTask__unk_2175F60: // 0x02175F60
	.space 0x04

exBossSysAdminTask__FileTable: // 0x02175F64
	.space 0x04 * 15

exBossSysAdminTask__unk_2175FA0: // 0x02175FA0
	.space 0x04

	.align 4

exBossFireDoraTask__ActiveInstanceCount: // 0x02175FA4
	.space 0x02

exBossFireDoraTask__ActiveInstanceCount2: // 0x02175FA6
	.space 0x02

	.align 4

exBossFireDoraTask__unk_2175FA8: // 0x02175FA8
	.space 0x04

exBossFireDoraTask__unk_02175FAC: // 0x002175FAC
	.space 0x04

exBossFireDoraTask__unk_2175FB0: // 0x02175FB0
	.space 0x04

exBossFireDoraTask__dword_2175FB4: // 0x02175FB4
	.space 0x04

exBossFireDoraTask__dword_2175FB8: // 0x02175FB8
	.space 0x04

exBossFireDoraTask__TaskSingleton: // 0x02175FBC
	.space 0x04

exBossFireDoraTask__FileTable2: // 0x02175FC0
	.space 0x04
	
	.text

	arm_func_start ovl09_2154D8C
ovl09_2154D8C: // 0x02154D8C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02154EEC // =exBossFireDoraTask__ActiveInstanceCount
	mov r4, r0
	str r4, [r1, #0xc]
	ldr r0, [r1, #0x14]
	cmp r0, #0
	ldrne r0, [r1, #4]
	cmpne r0, #0
	beq _02154DF8
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02154EEC // =exBossFireDoraTask__ActiveInstanceCount
	ldr r1, [r1, #0x14]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02154EEC // =exBossFireDoraTask__ActiveInstanceCount
	ldr r1, [r1, #4]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02154EEC // =exBossFireDoraTask__ActiveInstanceCount
	ldr r1, [r1, #0x14]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_02154DF8:
	mov r0, r4
	bl ovl09_2161CB0
	ldr r0, _02154EEC // =exBossFireDoraTask__ActiveInstanceCount
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02154E60
	mov r1, #0x17
	ldr r0, _02154EF0 // =aExtraExBb_1
	sub r2, r1, #0x18
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _02154EEC // =exBossFireDoraTask__ActiveInstanceCount
	mov r0, r0, lsr #8
	str r0, [r1, #0x14]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02154EEC // =exBossFireDoraTask__ActiveInstanceCount
	mov r0, r5
	str r1, [r2, #0x10]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	ldr r0, _02154EEC // =exBossFireDoraTask__ActiveInstanceCount
	ldr r0, [r0, #0x10]
	bl Asset3DSetup__Create
_02154E60:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02154EEC // =exBossFireDoraTask__ActiveInstanceCount
	str r2, [sp]
	ldr r1, [r0, #0x10]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r0, #0
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r1, _02154EF4 // =0x00003FFC
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #2]
	mov r1, #0x5000
	add r2, r4, #0x350
	orr r3, r3, #0x20
	strb r3, [r4, #2]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r1, [r4, #0x14]
	ldr r1, _02154EEC // =exBossFireDoraTask__ActiveInstanceCount
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02154EEC: .word exBossFireDoraTask__ActiveInstanceCount
_02154EF0: .word aExtraExBb_1
_02154EF4: .word 0x00003FFC
	arm_func_end ovl09_2154D8C

	arm_func_start ovl09_2154EF8
ovl09_2154EF8: // 0x02154EF8
	stmdb sp!, {r4, lr}
	ldr r1, _02154F5C // =exBossFireDoraTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _02154F40
	ldr r0, [r1, #0x10]
	cmp r0, #0
	beq _02154F20
	bl NNS_G3dResDefaultRelease
_02154F20:
	ldr r0, _02154F5C // =exBossFireDoraTask__ActiveInstanceCount
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _02154F34
	bl _FreeHEAP_USER
_02154F34:
	ldr r0, _02154F5C // =exBossFireDoraTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x10]
_02154F40:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02154F5C // =exBossFireDoraTask__ActiveInstanceCount
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02154F5C: .word exBossFireDoraTask__ActiveInstanceCount
	arm_func_end ovl09_2154EF8

	arm_func_start exBossFireDoraTask__Main
exBossFireDoraTask__Main: // 0x02154F60
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl ovl09_217175C
	bl GetCurrentTask
	ldr r1, _02155108 // =exBossFireDoraTask__ActiveInstanceCount
	str r0, [r1, #0x18]
	add r0, r4, #0x38
	bl ovl09_2154D8C
	add r0, r4, #0x3c4
	mov r1, #0xa800
	bl ovl09_21641E8
	add r0, r4, #0x3c4
	bl ovl09_21641F0
	add r0, r4, #0x114
	add r0, r0, #0x400
	bl ovl09_2154C48
	add r0, r4, #0x264
	add r0, r0, #0x400
	mov r1, #0xa800
	bl ovl09_21641E8
	add r0, r4, #0x264
	add r0, r0, #0x400
	bl ovl09_21641F0
	ldr r1, [r4, #0x7b4]
	mov r0, #0x3c000
	ldr r2, [r1, #0x3ec]
	ldr r1, _0215510C // =0x02173F98
	str r2, [r4, #0x388]
	ldr r2, [r4, #0x7b4]
	ldr r3, _02155110 // =0xB40B40B5
	ldr r2, [r2, #0x3f0]
	add ip, r4, #0x300
	str r2, [r4, #0x38c]
	str r0, [r4, #0x390]
	ldrh r2, [r4, #0]
	add r0, r4, #0x3b8
	mov lr, #4
	mov r2, r2, lsl #1
	ldrh r6, [r1, r2]
	add r0, r0, #0x400
	add r1, r4, #0x388
	smull r2, r5, r3, r6
	add r5, r6, r5
	mov r2, r6, lsr #0x1f
	add r5, r2, r5, asr #7
	strh r6, [ip, #0x84]
	strh r5, [r4, #0x26]
	ldrh r3, [ip, #0x84]
	mov r2, #2
	strh r3, [r4, #0x22]
	strh lr, [r4, #4]
	bl ovl09_216241C
	add r0, r4, #0x224
	ldr r1, _02155114 // =0x0000A7FF
	add r0, r0, #0x800
	bl ovl09_21641E8
	ldr r2, _02155118 // =_mt_math_rand
	ldr r0, _0215511C // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02155120 // =0x3C6EF35F
	ldr ip, _02155124 // =0x51EB851F
	mla r0, r3, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	smull r1, lr, ip, r2
	mov r1, r2, lsr #0x1f
	add lr, r1, lr, asr #4
	mov r3, #0x32
	smull r1, r2, r3, lr
	rsb lr, r1, r0, lsr #16
	add r2, lr, #1
	smull r1, r0, ip, r2
	mov r1, r2, lsr #0x1f
	add r0, r1, r0, asr #5
	bl _f_itof
	mov r1, r0
	mov r0, #0x3f800000
	bl _fadd
	str r0, [r4, #0x28]
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	moveq r0, #9
	streqh r0, [r4, #0x42]
	beq _021550D8
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	moveq r0, #0xc
	streqh r0, [r4, #0x42]
_021550D8:
	mov r4, #0xc7
	sub r1, r4, #0xc8
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, r4}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _02155128 // =ovl09_2155188
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02155108: .word exBossFireDoraTask__ActiveInstanceCount
_0215510C: .word 0x02173F98
_02155110: .word 0xB40B40B5
_02155114: .word 0x0000A7FF
_02155118: .word _mt_math_rand
_0215511C: .word 0x00196225
_02155120: .word 0x3C6EF35F
_02155124: .word 0x51EB851F
_02155128: .word ovl09_2155188
	arm_func_end exBossFireDoraTask__Main

	arm_func_start exBossFireDoraTask__Func8
exBossFireDoraTask__Func8: // 0x0215512C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02155150 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155150: .word ExTask_State_Destroy
	arm_func_end exBossFireDoraTask__Func8

	arm_func_start exBossFireDoraTask__Destructor
exBossFireDoraTask__Destructor: // 0x02155154
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x38
	bl ovl09_2154EF8
	add r0, r4, #0x114
	add r0, r0, #0x400
	bl ovl09_2154D58
	ldr r0, _02155184 // =exBossFireDoraTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x18]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155184: .word exBossFireDoraTask__ActiveInstanceCount
	arm_func_end exBossFireDoraTask__Destructor

	arm_func_start ovl09_2155188
ovl09_2155188: // 0x02155188
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl ovl09_217175C
	mov r5, r0
	add r0, r4, #0x38
	bl ovl09_2162164
	ldrb r0, [r4, #0x3e]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _02155200
	bic r0, r0, #1
	strb r0, [r4, #0x3e]
	ldrb r0, [r4, #0x38]
	cmp r0, #2
	bne _021551D0
	bl ovl09_2155450
	ldmia sp!, {r3, r4, r5, pc}
_021551D0:
	ldrsh r1, [r4, #0x42]
	ldrsh r0, [r4, #0x40]
	sub r0, r1, r0
	strh r0, [r4, #0x42]
	ldrsh r0, [r4, #0x42]
	cmp r0, #0
	bgt _021551F4
	bl ovl09_21556EC
	ldmia sp!, {r3, r4, r5, pc}
_021551F4:
	mov r0, #0
	strh r0, [r4, #0x40]
	b _02155214
_02155200:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02155214
	bl ovl09_21556EC
	ldmia sp!, {r3, r4, r5, pc}
_02155214:
	bl ovl09_2154C28
	cmp r0, #1
	bne _02155228
	bl ovl09_21556EC
	ldmia sp!, {r3, r4, r5, pc}
_02155228:
	ldrsh r1, [r4, #2]
	sub r0, r1, #1
	strh r0, [r4, #2]
	cmp r1, #0
	bgt _02155244
	bl ovl09_21556EC
	ldmia sp!, {r3, r4, r5, pc}
_02155244:
	ldr r0, [r4, #0x28]
	mov r1, #0
	bl _fgr
	ldr r1, [r4, #0x28]
	ldr r0, _02155444 // =0x45800000
	bls _02155270
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0215527C
_02155270:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0215527C:
	bl _f_ftoi
	str r0, [r4, #8]
	ldr r0, [r4, #0x28]
	mov r1, #0
	bl _fgr
	ldr r1, [r4, #0x28]
	ldr r0, _02155444 // =0x45800000
	bls _021552B0
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021552BC
_021552B0:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021552BC:
	bl _f_ftoi
	str r0, [r4, #0xc]
	ldr r0, [r4, #0x28]
	mov r1, #0
	bl _fgr
	ldr r1, [r4, #0x28]
	ldr r0, _02155444 // =0x45800000
	bls _021552F0
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021552FC
_021552F0:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021552FC:
	bl _f_ftoi
	str r0, [r4, #0x10]
	ldrsh r0, [r4, #4]
	sub r0, r0, #1
	strh r0, [r4, #4]
	ldrsh r0, [r4, #4]
	cmp r0, #0
	bge _0215536C
	mov r0, #4
	strh r0, [r4, #4]
	mov r0, #0x5b0
	str r0, [sp]
	ldr r3, [r4, #0x38c]
	ldr r0, [r5, #4]
	ldr r2, [r4, #0x388]
	ldr r1, [r5, #0]
	sub r0, r3, r0
	sub r1, r2, r1
	add r2, r4, #0x20
	add r3, r4, #0x26
	bl ovl09_2152EA8
	add r0, r4, #0x3b8
	ldrh r3, [r4, #0x22]
	add r2, r4, #0x700
	add r0, r0, #0x400
	add r1, r4, #0x388
	strh r3, [r2, #0xd8]
	bl ovl09_2162CC8
_0215536C:
	ldr r1, _02155448 // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x84]
	ldrh r5, [r0, #0x84]
	ldrh r3, [r4, #0x22]
	add r1, r4, #0x3b8
	add r2, r4, #0x224
	add r3, r5, r3
	strh r3, [r0, #0x84]
	ldrh r0, [r4, #0x22]
	ldr ip, _0215544C // =FX_SinCosTable_
	ldr r3, [r4, #8]
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r5, [ip, r0]
	add r0, r1, #0x400
	add r1, r2, #0x800
	smull r3, r2, r5, r3
	adds r3, r3, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r4, #8]
	ldrh r3, [r4, #0x22]
	ldr r2, [r4, #0xc]
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r3, [ip, r3]
	smull r5, r2, r3, r2
	adds r3, r5, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r4, #0xc]
	ldr r3, [r4, #0x388]
	ldr r2, [r4, #8]
	sub r2, r3, r2
	str r2, [r4, #0x388]
	ldr r3, [r4, #0x38c]
	ldr r2, [r4, #0xc]
	sub r2, r3, r2
	str r2, [r4, #0x38c]
	bl ovl09_2164034
	add r0, r4, #0x38
	add r1, r4, #0x3c4
	bl ovl09_2164034
	add r0, r4, #0x38
	bl ovl09_216AE78
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02155444: .word 0x45800000
_02155448: .word 0x0000BFF4
_0215544C: .word FX_SinCosTable_
	arm_func_end ovl09_2155188

	arm_func_start ovl09_2155450
ovl09_2155450: // 0x02155450
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r2, [r4, #0x3e]
	mov r1, #0
	mov r0, #0x1000
	bic r2, r2, #1
	strb r2, [r4, #0x3e]
	ldrb r2, [r4, #0x3c]
	orr r2, r2, #2
	strb r2, [r4, #0x3c]
	str r1, [r4, #8]
	str r0, [r4, #0xc]
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _021554FC
	ldrsh r0, [r4, #0x40]
	ldr r2, [r4, #0xc]
	cmp r0, #6
	bne _021554CC
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0xc]
	b _02155570
_021554CC:
	mov r0, #0x6000
	mov r1, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0xc]
	b _02155570
_021554FC:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _02155570
	ldrsh r0, [r4, #0x40]
	ldr r2, [r4, #0xc]
	cmp r0, #7
	bne _02155544
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0xc]
	b _02155570
_02155544:
	mov r0, #0x6000
	mov r1, #0
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds r2, ip, #0x800
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0xc]
_02155570:
	mov r0, #0
	ldr r2, _021555E4 // =0x00003FFC
	str r0, [r4, #0x10]
	add r1, r4, #0x300
	strh r2, [r1, #0x82]
	mov r2, r2, lsl #1
	strh r2, [r1, #0x84]
	strh r0, [r1, #0x86]
	ldr r2, _021555E8 // =0x00001554
	ldr r3, _021555EC // =_mt_math_rand
	strh r2, [r4, #0x2e]
	ldr ip, [r3]
	ldr r1, _021555F0 // =0x00196225
	ldr r2, _021555F4 // =0x3C6EF35F
	mla lr, ip, r1, r2
	mov r1, lr, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #31
	adds r1, r2, r1, ror #31
	str lr, [r3]
	movne r0, #1
	str r0, [r4, #0x34]
	bl GetExTaskCurrent
	ldr r1, _021555F8 // =ovl09_21555FC
	str r1, [r0]
	bl ovl09_21555FC
	ldmia sp!, {r4, pc}
	.align 2, 0
_021555E4: .word 0x00003FFC
_021555E8: .word 0x00001554
_021555EC: .word _mt_math_rand
_021555F0: .word 0x00196225
_021555F4: .word 0x3C6EF35F
_021555F8: .word ovl09_21555FC
	arm_func_end ovl09_2155450

	arm_func_start ovl09_21555FC
ovl09_21555FC: // 0x021555FC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r0, [r4, #0x3e]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _02155628
	bl GetExTaskCurrent
	ldr r1, _021556E8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02155628:
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _02155644
	bl GetExTaskCurrent
	ldr r1, _021556E8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02155644:
	ldr r0, [r4, #0x34]
	cmp r0, #0
	add r0, r4, #0x300
	ldreqh r2, [r0, #0x84]
	ldreqh r1, [r4, #0x2e]
	subeq r1, r2, r1
	beq _0215566C
	ldrh r2, [r0, #0x84]
	ldrh r1, [r4, #0x2e]
	add r1, r2, r1
_0215566C:
	strh r1, [r0, #0x84]
	ldr r1, [r4, #0x38c]
	ldr r0, [r4, #0xc]
	add r0, r1, r0
	str r0, [r4, #0x38c]
	ldr r1, [r4, #0x388]
	cmp r1, #0x5a000
	bge _021556B4
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _021556B4
	ldr r1, [r4, #0x38c]
	cmp r1, #0xc8000
	bge _021556B4
	add r0, r0, #0x1e000
	cmp r1, r0
	bgt _021556C4
_021556B4:
	bl GetExTaskCurrent
	ldr r1, _021556E8 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021556C4:
	add r0, r4, #0x38
	add r1, r4, #0x3c4
	bl ovl09_2164034
	add r0, r4, #0x38
	bl ovl09_216AE78
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021556E8: .word ExTask_State_Destroy
	arm_func_end ovl09_21555FC

	arm_func_start ovl09_21556EC
ovl09_21556EC: // 0x021556EC
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	ldr r1, [r0, #0x388]
	mov ip, #0xc8
	str r1, [r0, #0x640]
	ldr r2, [r0, #0x38c]
	sub r1, ip, #0xc9
	str r2, [r0, #0x644]
	ldr r3, [r0, #0x390]
	mov r2, r1
	str r3, [r0, #0x648]
	mov r0, #0
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _02155744 // =ovl09_2155748
	str r1, [r0]
	bl ovl09_2155748
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155744: .word ovl09_2155748
	arm_func_end ovl09_21556EC

	arm_func_start ovl09_2155748
ovl09_2155748: // 0x02155748
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x114
	add r0, r0, #0x400
	bl ovl09_2163ADC
	add r0, r4, #0x114
	add r0, r0, #0x400
	bl ovl09_2163BF4
	cmp r0, #0
	beq _0215577C
	bl ovl09_21557A0
	ldmia sp!, {r4, pc}
_0215577C:
	add r0, r4, #0x114
	add r1, r4, #0x264
	add r0, r0, #0x400
	add r1, r1, #0x400
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2155748

	arm_func_start ovl09_21557A0
ovl09_21557A0: // 0x021557A0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r1, [r4, #0x388]
	add r0, r4, #0x114
	str r1, [r4, #0x640]
	ldr r1, [r4, #0x38c]
	add r0, r0, #0x400
	str r1, [r4, #0x644]
	ldr r1, [r4, #0x390]
	mov r2, #0x1e
	str r1, [r4, #0x648]
	mov r1, #6
	strh r2, [r4, #2]
	bl ovl09_2154D44
	add r0, r4, #0x264
	add r0, r0, #0x400
	bl ovl09_2164218
	bl GetExTaskCurrent
	ldr r1, _021557FC // =ovl09_2155800
	str r1, [r0]
	bl ovl09_2155800
	ldmia sp!, {r4, pc}
	.align 2, 0
_021557FC: .word ovl09_2155800
	arm_func_end ovl09_21557A0

	arm_func_start ovl09_2155800
ovl09_2155800: // 0x02155800
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x114
	add r0, r0, #0x400
	bl ovl09_2163ADC
	ldrsh r0, [r4, #2]
	cmp r0, #0
	bgt _02155860
	ldr r1, [r4, #0x628]
	mov r0, r1, lsl #0xb
	mov r0, r0, lsr #0x1b
	cmp r0, #1
	bhi _02155848
	bl GetExTaskCurrent
	ldr r1, _0215588C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02155848:
	sub r0, r0, #1
	bic r1, r1, #0x1f0000
	mov r0, r0, lsl #0x1b
	orr r0, r1, r0, lsr #11
	str r0, [r4, #0x628]
	b _02155868
_02155860:
	sub r0, r0, #1
	strh r0, [r4, #2]
_02155868:
	add r0, r4, #0x114
	add r1, r4, #0x264
	add r0, r0, #0x400
	add r1, r1, #0x400
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215588C: .word ExTask_State_Destroy
	arm_func_end ovl09_2155800

	arm_func_start exBossFireDoraTask__Create
exBossFireDoraTask__Create: // 0x02155890
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _02155918 // =0x00000B74
	str r4, [sp]
	str r1, [sp, #4]
	ldr r0, _0215591C // =aExbossfiredora
	ldr r1, _02155920 // =exBossFireDoraTask__Destructor
	str r0, [sp, #8]
	ldr r0, _02155924 // =exBossFireDoraTask__Main
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _02155918 // =0x00000B74
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x7b4]
	ldrh r1, [r0, #0x66]
	mov r0, r5
	strh r1, [r4]
	ldr r1, [r4, #0x7b4]
	ldrsh r1, [r1, #0x58]
	strh r1, [r4, #2]
	bl GetExTask
	ldr r1, _02155928 // =exBossFireDoraTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02155918: .word 0x00000B74
_0215591C: .word aExbossfiredora
_02155920: .word exBossFireDoraTask__Destructor
_02155924: .word exBossFireDoraTask__Main
_02155928: .word exBossFireDoraTask__Func8
	arm_func_end exBossFireDoraTask__Create

	.data

_02173F98:
	.hword 0x6000, 0x7F49, 0xB6, 0x2000

aExtraExBb_1: // 0x02173FA0
	.asciz "/extra/ex.bb"
	.align 4
	
aExbossfiredora: // 0x02173FB0
	.asciz "exBossFireDoraTask"