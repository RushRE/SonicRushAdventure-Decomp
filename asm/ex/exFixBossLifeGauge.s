	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exFixBossLifeGaugeTask__Main
exFixBossLifeGaugeTask__Main: // 0x0216A13C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetExTaskWorkCurrent_
	mov r5, r0
	bl GetCurrentTask
	ldr r1, _0216A340 // =0x021766A8
	str r0, [r1, #4]
	bl ExBossSysAdminTask__Func_215DF0C
	str r0, [r5]
	mov r0, #0x1e
	strh r0, [r5, #0x14]
	mov r1, #9
	add r0, r5, #0x14
	strh r1, [r5, #0x16]
	bl exFixAdminTask__LoadSprite
	add r0, r5, #0x94
	mov r1, #0xe000
	bl exDrawReqTask__SetConfigPriority
	mov r0, #0x39
	strh r0, [r5, #0x7c]
	mov r0, #0xb0
	strh r0, [r5, #0x7e]
	ldrb r1, [r5, #0x96]
	add r0, r5, #0x14
	orr r1, r1, #0x20
	strb r1, [r5, #0x96]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	mov r0, #0x14
	strh r0, [r5, #0x9c]
	mov r0, #9
	strh r0, [r5, #0x9e]
	add r0, r5, #0x9c
	bl exFixAdminTask__LoadSprite
	add r0, r5, #0x11c
	mov r1, #0xe000
	bl exDrawReqTask__SetConfigPriority
	mov r1, #0x38
	add r0, r5, #0x100
	strh r1, [r0, #4]
	mov r1, #0xb0
	strh r1, [r0, #6]
	ldrb r1, [r5, #0x11e]
	add r0, r5, #0x9c
	orr r1, r1, #0x20
	strb r1, [r5, #0x11e]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	mov r1, #0x14
	add r0, r5, #0x100
	strh r1, [r0, #0x24]
	mov r1, #9
	strh r1, [r0, #0x26]
	add r0, r5, #0x124
	bl exFixAdminTask__LoadSprite
	add r0, r5, #0x1a4
	mov r1, #0xe000
	bl exDrawReqTask__SetConfigPriority
	mov r1, #0xf8
	add r0, r5, #0x100
	strh r1, [r0, #0x8c]
	mov r1, #0xb0
	strh r1, [r0, #0x8e]
	ldrb r1, [r5, #0x1a6]
	add r0, r5, #0x124
	orr r1, r1, #0x20
	strb r1, [r5, #0x1a6]
	bl exDrawReqTask__Sprite2D__Func_2161B80
	ldr r0, [r5, #0x164]
	mov r6, #0
	orr r0, r0, #0x80
	str r0, [r5, #0x164]
	add r0, r5, #0x2e
	mov r7, r5
	add r8, r5, #0x1ac
	add r9, r5, #0x22c
	add r10, r0, #0x200
	add r4, r5, #0x100
	mov r11, #9
_0216A26C:
	add r0, r6, #0x15
	add r1, r7, #0x100
	strh r0, [r1, #0xac]
	mov r0, r8
	strh r11, [r1, #0xae]
	bl exFixAdminTask__LoadSprite
	ldr r1, _0216A344 // =0x0000DFFF
	mov r0, r9
	bl exDrawReqTask__SetConfigPriority
	add r1, r7, #0x200
	mov r0, #0
	strh r0, [r1, #0x14]
	ldrsh r2, [r4, #6]
	mov r0, r8
	strh r2, [r1, #0x16]
	ldrb r1, [r10, #0]
	orr r1, r1, #0x20
	strb r1, [r10], #0x88
	bl exDrawReqTask__Sprite2D__Func_2161B80
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	cmp r6, #9
	add r7, r7, #0x88
	add r8, r8, #0x88
	add r9, r9, #0x88
	blt _0216A26C
	add r0, r5, #0x100
	ldrsh r2, [r0, #4]
	ldrsh r1, [r0, #0x8c]
	mvn r0, #0xf
	sub r2, r0, r2
	ldr r0, [r5, #0]
	add r1, r2, r1
	strh r1, [r0, #0x64]
	ldr r2, [r5, #0]
	mov r1, #0
	ldrsh r0, [r2, #0x64]
	strh r0, [r2, #0x62]
	ldr r0, [r5, #0]
	ldrsh r2, [r0, #0x62]
	mov r0, r2, asr #2
	add r0, r2, r0, lsr #29
	mov r0, r0, asr #3
	strh r0, [r5, #4]
	ldr r0, [r5, #0]
	ldrsh r0, [r0, #0x64]
	strh r0, [r5, #0xa]
	strh r1, [r5, #0xc]
	bl GetExTaskCurrent
	ldr r1, _0216A348 // =exFixBossLifeGaugeTask__Main_Active
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216A340: .word 0x021766A8
_0216A344: .word 0x0000DFFF
_0216A348: .word exFixBossLifeGaugeTask__Main_Active
	arm_func_end exFixBossLifeGaugeTask__Main

	arm_func_start exFixBossLifeGaugeTask__Func8
exFixBossLifeGaugeTask__Func8: // 0x0216A34C
	ldr ip, _0216A354 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_0216A354: .word GetExTaskWorkCurrent_
	arm_func_end exFixBossLifeGaugeTask__Func8

	arm_func_start exFixBossLifeGaugeTask__Destructor
exFixBossLifeGaugeTask__Destructor: // 0x0216A358
	stmdb sp!, {r4, r5, r6, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x14
	bl exFixAdminTask__ReleaseSprite
	add r0, r4, #0x9c
	bl exFixAdminTask__ReleaseSprite
	add r0, r4, #0x124
	bl exFixAdminTask__ReleaseSprite
	add r5, r4, #0x1ac
	mov r6, #0
	mov r4, #0x88
_0216A388:
	mla r0, r6, r4, r5
	bl exFixAdminTask__ReleaseSprite
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #9
	blo _0216A388
	ldr r0, _0216A3B4 // =0x021766A8
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216A3B4: .word 0x021766A8
	arm_func_end exFixBossLifeGaugeTask__Destructor

	arm_func_start exFixBossLifeGaugeTask__Main_Active
exFixBossLifeGaugeTask__Main_Active: // 0x0216A3B8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetExTaskWorkCurrent_
	mov r8, r0
	bl exSysTask__GetStatus
	add r0, r8, #0x14
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r8, #0x9c
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r8, #0x124
	bl exDrawReqTask__Sprite2D__Animate
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	beq _0216A420
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _0216A420
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	beq _0216A420
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #5
	bne _0216A468
_0216A420:
	mov r0, #0
	strh r0, [r8, #0xc]
	ldr r0, [r8, #0]
	ldrsh r0, [r0, #0x62]
	strh r0, [r8, #0xa]
	ldr r0, [r8, #0]
	ldrsh r1, [r0, #0x62]
	mov r0, r1, asr #2
	add r0, r1, r0, lsr #29
	mov r0, r0, asr #3
	strh r0, [r8, #6]
	ldr r0, [r8, #0]
	ldrsh r0, [r0, #0x62]
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #29
	add r0, r1, r0, ror #29
	strh r0, [r8, #8]
	b _0216A4D8
_0216A468:
	ldr r1, [r8, #0]
	ldrsh r0, [r8, #0xa]
	ldrsh r1, [r1, #0x62]
	cmp r0, r1
	beq _0216A4B0
	sub r0, r0, r1
	strh r0, [r8, #0xc]
	ldr r0, [r8, #0]
	ldrsh r0, [r0, #0x62]
	strh r0, [r8, #0xa]
	ldrsh r0, [r8, #0xc]
	bl _f_itof
	str r0, [r8, #0x10]
	bl GetExTaskCurrent
	ldr r1, _0216A620 // =exFixBossLifeGaugeTask__Main_216A624
	str r1, [r0]
	bl exFixBossLifeGaugeTask__Main_216A624
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216A4B0:
	mov r0, r1, asr #2
	add r0, r1, r0, lsr #29
	mov r0, r0, asr #3
	strh r0, [r8, #6]
	ldr r0, [r8, #0]
	ldrsh r0, [r0, #0x62]
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #29
	add r0, r1, r0, ror #29
	strh r0, [r8, #8]
_0216A4D8:
	ldrsh r0, [r8, #8]
	add r4, r8, #0x1ac
	mov r5, #0
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp]
_0216A4F4:
	mov r0, r4
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	cmp r5, #9
	add r4, r4, #0x88
	blt _0216A4F4
	ldrsh r0, [r8, #4]
	mov r9, #0
	mov r10, r9
	cmp r0, #0
	ble _0216A5A4
	add r6, r8, #0x1ec
	add r7, r8, #0x26c
	add r4, r8, #0x100
	add r11, r8, #0x600
	add r5, r8, #0x200
_0216A53C:
	ldrsh r0, [r8, #6]
	cmp r10, r0
	bge _0216A570
	ldrsh r1, [r4, #4]
	add r9, r10, #1
	add r0, r8, #0x1ac
	add r2, r1, r9, lsl #3
	add r1, r8, #0x22c
	strh r2, [r5, #0x14]
	bl exDrawReqTask__AddRequest
	mov r0, r9, lsl #0x10
	mov r9, r0, asr #0x10
	b _0216A58C
_0216A570:
	ldrsh r2, [r4, #4]
	add r1, r10, #1
	add r0, r6, #0x400
	add r2, r2, r1, lsl #3
	add r1, r7, #0x400
	strh r2, [r11, #0x54]
	bl exDrawReqTask__AddRequest
_0216A58C:
	ldrsh r1, [r8, #4]
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, asr #16
	mov r10, r0, asr #0x10
	bgt _0216A53C
_0216A5A4:
	ldr r0, [sp]
	cmp r0, #8
	beq _0216A5EC
	add r2, r8, #0x100
	mov r1, #0x88
	smulbb r6, r0, r1
	add r0, r9, #1
	add r1, r8, #0x22c
	ldrsh r5, [r2, #4]
	add r4, r8, r6
	add r3, r8, #0x1ac
	mov r0, r0, lsl #0x13
	add r2, r4, #0x200
	add r4, r5, r0, asr #16
	add r0, r3, r6
	add r1, r1, r6
	strh r4, [r2, #0x14]
	bl exDrawReqTask__AddRequest
_0216A5EC:
	add r0, r8, #0x14
	add r1, r8, #0x94
	bl exDrawReqTask__AddRequest
	add r0, r8, #0x9c
	add r1, r8, #0x11c
	bl exDrawReqTask__AddRequest
	add r0, r8, #0x124
	add r1, r8, #0x1a4
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216A620: .word exFixBossLifeGaugeTask__Main_216A624
	arm_func_end exFixBossLifeGaugeTask__Main_Active

	arm_func_start exFixBossLifeGaugeTask__Main_216A624
exFixBossLifeGaugeTask__Main_216A624: // 0x0216A624
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetExTaskWorkCurrent_
	mov r8, r0
	bl exSysTask__GetStatus
	add r0, r8, #0x14
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r8, #0x9c
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r8, #0x124
	bl exDrawReqTask__Sprite2D__Animate
	ldrsh r0, [r8, #0xc]
	cmp r0, #0
	bne _0216A66C
	bl GetExTaskCurrent
	ldr r1, _0216A834 // =exFixBossLifeGaugeTask__Main_Active
	str r1, [r0]
	bl exFixBossLifeGaugeTask__Main_Active
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216A66C:
	ldr r0, [r8, #0x10]
	ldr r1, _0216A838 // =0x3F666666
	bl _f_mul
	str r0, [r8, #0x10]
	ldrsh r0, [r8, #0xc]
	cmp r0, #0
	ble _0216A6D8
	ldr r0, [r8, #0x10]
	bl _f_ftoi
	strh r0, [r8, #0xc]
	ldr r1, [r8, #0]
	ldrsh r0, [r8, #0xc]
	ldrsh r1, [r1, #0x62]
	add r1, r1, r0
	mov r0, r1, asr #2
	add r0, r1, r0, lsr #29
	mov r0, r0, asr #3
	strh r0, [r8, #6]
	ldr r1, [r8, #0]
	ldrsh r0, [r8, #0xc]
	ldrsh r1, [r1, #0x62]
	add r0, r1, r0
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #29
	add r0, r1, r0, ror #29
	strh r0, [r8, #8]
	b _0216A6EC
_0216A6D8:
	mov r0, #0
	strh r0, [r8, #0xc]
	ldr r0, [r8, #0]
	ldrsh r0, [r0, #0x62]
	strh r0, [r8, #0xa]
_0216A6EC:
	ldrsh r0, [r8, #8]
	add r4, r8, #0x1ac
	mov r5, #0
	rsb r0, r0, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	str r0, [sp]
_0216A708:
	mov r0, r4
	bl exDrawReqTask__Sprite2D__Animate
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	cmp r5, #9
	add r4, r4, #0x88
	blt _0216A708
	ldrsh r0, [r8, #4]
	mov r9, #0
	mov r10, r9
	cmp r0, #0
	ble _0216A7B8
	add r6, r8, #0x1ec
	add r7, r8, #0x26c
	add r4, r8, #0x100
	add r11, r8, #0x600
	add r5, r8, #0x200
_0216A750:
	ldrsh r0, [r8, #6]
	cmp r10, r0
	bge _0216A784
	ldrsh r1, [r4, #4]
	add r9, r10, #1
	add r0, r8, #0x1ac
	add r2, r1, r9, lsl #3
	add r1, r8, #0x22c
	strh r2, [r5, #0x14]
	bl exDrawReqTask__AddRequest
	mov r0, r9, lsl #0x10
	mov r9, r0, asr #0x10
	b _0216A7A0
_0216A784:
	ldrsh r2, [r4, #4]
	add r1, r10, #1
	add r0, r6, #0x400
	add r2, r2, r1, lsl #3
	add r1, r7, #0x400
	strh r2, [r11, #0x54]
	bl exDrawReqTask__AddRequest
_0216A7A0:
	ldrsh r1, [r8, #4]
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, asr #16
	mov r10, r0, asr #0x10
	bgt _0216A750
_0216A7B8:
	ldr r0, [sp]
	cmp r0, #8
	beq _0216A800
	add r2, r8, #0x100
	mov r1, #0x88
	smulbb r6, r0, r1
	add r0, r9, #1
	add r1, r8, #0x22c
	ldrsh r5, [r2, #4]
	add r4, r8, r6
	add r3, r8, #0x1ac
	mov r0, r0, lsl #0x13
	add r2, r4, #0x200
	add r4, r5, r0, asr #16
	add r0, r3, r6
	add r1, r1, r6
	strh r4, [r2, #0x14]
	bl exDrawReqTask__AddRequest
_0216A800:
	add r0, r8, #0x14
	add r1, r8, #0x94
	bl exDrawReqTask__AddRequest
	add r0, r8, #0x9c
	add r1, r8, #0x11c
	bl exDrawReqTask__AddRequest
	add r0, r8, #0x124
	add r1, r8, #0x1a4
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216A834: .word exFixBossLifeGaugeTask__Main_Active
_0216A838: .word 0x3F666666
	arm_func_end exFixBossLifeGaugeTask__Main_216A624

	arm_func_start exFixBossLifeGaugeTask__Create
exFixBossLifeGaugeTask__Create: // 0x0216A83C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _0216A8A4 // =0x00000674
	str r4, [sp]
	ldr r0, _0216A8A8 // =aExfixbosslifeg
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216A8AC // =exFixBossLifeGaugeTask__Main
	ldr r1, _0216A8B0 // =exFixBossLifeGaugeTask__Destructor
	mov r2, #0x1800
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	ldr r2, _0216A8A4 // =0x00000674
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _0216A8B4 // =exFixBossLifeGaugeTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216A8A4: .word 0x00000674
_0216A8A8: .word aExfixbosslifeg
_0216A8AC: .word exFixBossLifeGaugeTask__Main
_0216A8B0: .word exFixBossLifeGaugeTask__Destructor
_0216A8B4: .word exFixBossLifeGaugeTask__Func8
	arm_func_end exFixBossLifeGaugeTask__Create

	arm_func_start exFixBossLifeGaugeTask__Destroy
exFixBossLifeGaugeTask__Destroy: // 0x0216A8B8
	stmdb sp!, {r3, lr}
	ldr r0, _0216A8DC // =0x021766A8
	ldr r0, [r0, #4]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _0216A8E0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216A8DC: .word 0x021766A8
_0216A8E0: .word ExTask_State_Destroy
	arm_func_end exFixBossLifeGaugeTask__Destroy