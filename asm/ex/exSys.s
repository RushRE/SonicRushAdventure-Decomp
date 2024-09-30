	.include "asm/macros.inc"
	.include "global.inc"

	.bss

exSysTask__Value_2178644: // 0x02178644
    .space 0x04

exSysTask__Singleton: // 0x02178648
    .space 0x04
	
exSysTask__TaskSingleton: // 0x0217864C
    .space 0x04
	
exSysTask__Flag_2178650: // 0x02178650
    .space 0x04
	
exSysTask__Flag_2178654: // 0x02178654
    .space 0x04
	
exSysTask__Flag_2178658: // 0x02178658
    .space 0x01
	
exSysTask__unk_2178659: // 0x02178659
    .space 0x01
	
exSysTask__byte_217865A: // 0x0217865A
    .space 0x01
	
exSysTask__byte_217865B: // 0x0217865B
    .space 0x01
	
exSysTask__byte_217865C: // 0x0217865C
    .space 0x01

	.align 2

exSysTask__word_217865E: // 0x0217865E
    .space 0x02

	.align 4
	
exSysTask__dword_2178660: // 0x02178660
    .space 0x04 * 3
	
	.text

	arm_func_start ovl09_2172A18
ovl09_2172A18: // 0x02172A18
	ldr r0, _02172A24 // =0x0217862C
	ldr r0, [r0, #4]
	bx lr
	.align 2, 0
_02172A24: .word 0x0217862C
	arm_func_end ovl09_2172A18

	arm_func_start ovl09_2172A28
ovl09_2172A28: // 0x02172A28
	ldr r0, _02172A34 // =exSysTask__Value_2178644
	ldrb r0, [r0, #0]
	bx lr
	.align 2, 0
_02172A34: .word exSysTask__Value_2178644
	arm_func_end ovl09_2172A28

	arm_func_start ovl09_2172A38
ovl09_2172A38: // 0x02172A38
	ldr r0, _02172A4C // =exSysTask__Value_2178644
	ldrb r1, [r0, #0]
	sub r1, r1, #1
	strb r1, [r0]
	bx lr
	.align 2, 0
_02172A4C: .word exSysTask__Value_2178644
	arm_func_end ovl09_2172A38

	arm_func_start ovl09_2172A50
ovl09_2172A50: // 0x02172A50
	stmdb sp!, {r3, lr}
	ldr r0, _02172AC8 // =saveGame
	ldr r1, _02172ACC // =exSysTask__Value_2178644
	ldr r0, [r0, #0x1c0]
	mov r3, #1
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1e
	ldr r0, _02172AC8 // =saveGame
	strb r3, [r1, #0x15]
	ldr r0, [r0, #0x1c0]
	strb r3, [r1, #0x17]
	mov r2, #0x32
	strh r2, [r1, #0x1a]
	ldr r1, _02172ACC // =exSysTask__Value_2178644
	moveq r3, #2
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	strb r3, [r1, #0x14]
	movne r1, #1
	ldr r0, _02172ACC // =exSysTask__Value_2178644
	moveq r1, #2
	strb r1, [r0, #0x16]
	bl ovl09_2172A28
	ldr r2, _02172ACC // =exSysTask__Value_2178644
	mov r1, #0
	strb r0, [r2, #0x18]
	ldr r0, _02172AD0 // =exSysTask__dword_2178660
	mov r2, #0xc
	bl MI_CpuFill8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02172AC8: .word saveGame
_02172ACC: .word exSysTask__Value_2178644
_02172AD0: .word exSysTask__dword_2178660
	arm_func_end ovl09_2172A50

	arm_func_start exSysTask__GetStatus
exSysTask__GetStatus: // 0x02172AD4
	ldr r0, _02172ADC // =exSysTask__Flag_2178658
	bx lr
	.align 2, 0
_02172ADC: .word exSysTask__Flag_2178658
	arm_func_end exSysTask__GetStatus

	arm_func_start ovl09_2172AE0
ovl09_2172AE0: // 0x02172AE0
	ldr r0, _02172AEC // =exSysTask__Value_2178644
	ldr r0, [r0, #0xc]
	bx lr
	.align 2, 0
_02172AEC: .word exSysTask__Value_2178644
	arm_func_end ovl09_2172AE0

	arm_func_start exSysTask__Main
exSysTask__Main: // 0x02172AF0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	ldr r2, _02172CCC // =saveGame
	ldr r1, _02172CD0 // =exSysTask__Value_2178644
	ldr r2, [r2, #0x1c0]
	mov r4, r0
	mov r0, r2, lsl #0x16
	mov r0, r0, lsr #0x19
	strb r0, [r1]
	bl GetCurrentTask
	ldr r1, _02172CD0 // =exSysTask__Value_2178644
	str r0, [r1, #8]
	mov r0, r4
	bl ovl09_2173438
	mov r0, r4
	bl ovl09_2173500
	bl Camera3D__Create
	bl Camera3D__GetWork
	mov r4, r0
	bl Camera3D__GetWork
	mov r1, #0
	strh r1, [r0, #0x7c]
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	bic r1, r1, #1
	orr r1, r1, #1
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	bic r2, r2, #1
	and r1, r1, #1
	orr r1, r2, r1
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x200
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x16
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x200
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #22
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x400
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x15
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x400
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #21
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x800
	strh r1, [r0, #0x7c]
	ldrh r1, [r0, #0x7c]
	ldrh r2, [r4, #0x20]
	mov r1, r1, lsl #0x14
	mov r1, r1, lsr #0x1f
	bic r2, r2, #0x800
	mov r1, r1, lsl #0x1f
	orr r1, r2, r1, lsr #20
	strh r1, [r4, #0x20]
	ldrh r1, [r0, #0x7c]
	orr r1, r1, #0x1000
	strh r1, [r0, #0x7c]
	ldrh r0, [r0, #0x7c]
	ldrh r1, [r4, #0x20]
	mov r0, r0, lsl #0x13
	mov r0, r0, lsr #0x1f
	bic r1, r1, #0x1000
	mov r0, r0, lsl #0x1f
	orr r0, r1, r0, lsr #19
	strh r0, [r4, #0x20]
	bl Camera3D__GetWork
	mov r3, #0x1f
	str r3, [sp]
	mov r4, #0
	add r0, r0, #0x7c
	mov r1, #0x10
	mov r2, #1
	str r4, [sp, #4]
	bl RenderCore_SetBlendBrightnessExt
	bl ovl09_2172A50
	mov r0, #1
	mov r1, r0
	bl ovl09_21615A4
	bl exDrawReqTask__Create
	bl exHitCheckTask__Create
	bl exGameSystemTask__Create
	bl exFixAdminTask__Create
	bl exSysTask__GetStatus
	mov r1, #3
	strb r1, [r0, #3]
	mov r0, #1
	mov r1, r4
	str r0, [sp]
	sub r0, r0, #0x11
	mov r2, #0x20
	mov r3, r1
	bl exDrawFadeTask__Create
	mov r0, #2
	mov r1, r4
	str r0, [sp]
	sub r0, r0, #0x12
	mov r2, #0x20
	mov r3, r1
	bl exDrawFadeTask__Create
	bl GetExTaskCurrent
	ldr r1, _02172CD4 // =ovl09_2172D30
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172CCC: .word saveGame
_02172CD0: .word exSysTask__Value_2178644
_02172CD4: .word ovl09_2172D30
	arm_func_end exSysTask__Main

	arm_func_start exSysTask__Func8
exSysTask__Func8: // 0x02172CD8
	ldr ip, _02172CE0 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_02172CE0: .word GetExTaskWorkCurrent_
	arm_func_end exSysTask__Func8

	arm_func_start exSysTask__Destructor
exSysTask__Destructor: // 0x02172CE4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl ovl09_216AA78
	bl ovl09_216AD70
	ldr r0, [r4, #0]
	bl _FreeHEAP_USER
	ldr r0, [r4, #4]
	bl _FreeHEAP_USER
	bl NNS_SndStopSoundAll
	bl ReleaseAudioSystem
	mov r0, #0
	bl NNS_G3dGeUseFastDma
	ldr r0, _02172D2C // =exSysTask__Value_2178644
	mov r1, #0
	str r1, [r0, #8]
	str r1, [r0, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172D2C: .word exSysTask__Value_2178644
	arm_func_end exSysTask__Destructor

	arm_func_start ovl09_2172D30
ovl09_2172D30: // 0x02172D30
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #3
	beq _02172D5C
	bl exSysTask__GetStatus
	mov r1, #4
	strb r1, [r0, #3]
	bl ovl09_2172D6C
	ldmia sp!, {r3, pc}
_02172D5C:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_2172D30

	arm_func_start ovl09_2172D6C
ovl09_2172D6C: // 0x02172D6C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _02172D94 // =ovl09_2172D98
	str r1, [r0]
	bl ovl09_2172D98
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02172D94: .word ovl09_2172D98
	arm_func_end ovl09_2172D6C

	arm_func_start ovl09_2172D98
ovl09_2172D98: // 0x02172D98
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	beq _02172DF4
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _02172DF4
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	beq _02172DF4
	bl ovl09_216D8C8
	cmp r0, #0
	bne _02172DF4
	ldr r0, _02172E44 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #8
	beq _02172DF4
	bl ovl09_2172E48
	ldmia sp!, {r3, pc}
_02172DF4:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #1]
	cmp r0, #6
	bne _02172E18
	bl exSysTask__GetStatus
	mov r1, #0xb
	strb r1, [r0, #3]
	bl ovl09_21730D0
	ldmia sp!, {r3, pc}
_02172E18:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #1]
	cmp r0, #2
	bne _02172E30
	bl ovl09_2173000
	ldmia sp!, {r3, pc}
_02172E30:
	bl ovl09_216ADD8
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02172E44: .word padInput
	arm_func_end ovl09_2172D98

	arm_func_start ovl09_2172E48
ovl09_2172E48: // 0x02172E48
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r0, #1
	bl ovl09_216AD9C
	bl exSysTask__GetStatus
	mov r1, #4
	strb r1, [r0, #1]
	bl exPauseTask__Create
	bl GetExTaskCurrent
	ldr r1, _02172E78 // =ovl09_2172E7C
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02172E78: .word ovl09_2172E7C
	arm_func_end ovl09_2172E48

	arm_func_start ovl09_2172E7C
ovl09_2172E7C: // 0x02172E7C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl ovl09_216E3E4
	cmp r0, #1
	bne _02172EB0
	bl exSysTask__GetStatus
	mov r1, #1
	strb r1, [r0, #1]
	bl GetExTaskCurrent
	ldr r1, _02172EF0 // =ovl09_2172D6C
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02172EB0:
	bl ovl09_216E3E4
	cmp r0, #2
	bne _02172EE0
	mov r0, #0xa
	strh r0, [r4, #0xc]
	bl exSysTask__GetStatus
	mov r1, #0xb
	strb r1, [r0, #3]
	bl GetExTaskCurrent
	ldr r1, _02172EF4 // =ovl09_2172EF8
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02172EE0:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172EF0: .word ovl09_2172D6C
_02172EF4: .word ovl09_2172EF8
	arm_func_end ovl09_2172E7C

	arm_func_start ovl09_2172EF8
ovl09_2172EF8: // 0x02172EF8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrsh r2, [r0, #0xc]
	sub r1, r2, #1
	strh r1, [r0, #0xc]
	cmp r2, #0
	bgt _02172F1C
	bl ovl09_2172F30
	ldmia sp!, {r3, pc}
_02172F1C:
	bl ovl09_216ADD8
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_2172EF8

	arm_func_start ovl09_2172F30
ovl09_2172F30: // 0x02172F30
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exSysTask__GetStatus
	mov r1, #5
	strb r1, [r0, #1]
	mov r0, #0
	mov ip, #1
	mov r3, r0
	sub r1, r0, #0x10
	mov r2, #0x40
	str ip, [sp]
	bl exDrawFadeTask__Create
	mov r0, #0
	mov r1, #2
	str r1, [sp]
	sub r1, r0, #0x10
	mov r2, #0x40
	mov r3, r0
	bl exDrawFadeTask__Create
	mov r0, #0x40
	strh r0, [r4, #0xc]
	bl GetExTaskCurrent
	ldr r1, _02172FA0 // =ovl09_2172FA4
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02172FA0: .word ovl09_2172FA4
	arm_func_end ovl09_2172F30

	arm_func_start ovl09_2172FA4
ovl09_2172FA4: // 0x02172FA4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrsh r2, [r0, #0xc]
	sub r1, r2, #1
	strh r1, [r0, #0xc]
	cmp r2, #0
	bgt _02172FE8
	ldr r1, _02172FF8 // =exSysTask__Value_2178644
	mov r2, #1
	str r2, [r1, #0xc]
	mov r1, #5
	strh r1, [r0, #0xc]
	bl GetExTaskCurrent
	ldr r1, _02172FFC // =ovl09_21732E4
	str r1, [r0]
	bl ovl09_21732E4
	ldmia sp!, {r3, pc}
_02172FE8:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02172FF8: .word exSysTask__Value_2178644
_02172FFC: .word ovl09_21732E4
	arm_func_end ovl09_2172FA4

	arm_func_start ovl09_2173000
ovl09_2173000: // 0x02173000
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exSysTask__GetStatus
	mov r1, #3
	strb r1, [r0, #1]
	mov r0, #0
	mov ip, #1
	mov r3, r0
	sub r1, r0, #0x10
	mov r2, #0x40
	str ip, [sp]
	bl exDrawFadeTask__Create
	mov r0, #0
	mov r1, #2
	str r1, [sp]
	sub r1, r0, #0x10
	mov r2, #0x40
	mov r3, r0
	bl exDrawFadeTask__Create
	mov r0, #0x40
	strh r0, [r4, #0xc]
	bl GetExTaskCurrent
	ldr r1, _02173070 // =ovl09_2173074
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02173070: .word ovl09_2173074
	arm_func_end ovl09_2173000

	arm_func_start ovl09_2173074
ovl09_2173074: // 0x02173074
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrsh r2, [r0, #0xc]
	sub r1, r2, #1
	strh r1, [r0, #0xc]
	cmp r2, #0
	bgt _021730B8
	ldr r1, _021730C8 // =exSysTask__Value_2178644
	mov r2, #1
	str r2, [r1, #0xc]
	mov r1, #5
	strh r1, [r0, #0xc]
	bl GetExTaskCurrent
	ldr r1, _021730CC // =ovl09_21732E4
	str r1, [r0]
	bl ovl09_21732E4
	ldmia sp!, {r3, pc}
_021730B8:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021730C8: .word exSysTask__Value_2178644
_021730CC: .word ovl09_21732E4
	arm_func_end ovl09_2173074

	arm_func_start ovl09_21730D0
ovl09_21730D0: // 0x021730D0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl ovl09_2172A28
	cmp r0, #0
	bne _021730FC
	bl exSysTask__GetStatus
	mov r1, #8
	strb r1, [r0, #1]
	b _02173100
_021730FC:
	bl ovl09_2172A38
_02173100:
	mov r0, #0
	mov ip, #1
	mov r3, r0
	sub r1, r0, #0x10
	mov r2, #0x40
	str ip, [sp]
	bl exDrawFadeTask__Create
	mov r0, #0
	mov ip, #2
	mov r3, r0
	sub r1, r0, #0x10
	mov r2, #0x40
	str ip, [sp]
	bl exDrawFadeTask__Create
	mov r0, #0x40
	strh r0, [r4, #0xc]
	bl GetExTaskCurrent
	ldr r1, _02173154 // =ovl09_2173158
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02173154: .word ovl09_2173158
	arm_func_end ovl09_21730D0

	arm_func_start ovl09_2173158
ovl09_2173158: // 0x02173158
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrsh r1, [r4, #0xc]
	sub r0, r1, #1
	strh r0, [r4, #0xc]
	cmp r1, #0
	bgt _021731C0
	ldr r0, _021731D0 // =exSysTask__Value_2178644
	mov r1, #1
	str r1, [r0, #0xc]
	bl exSysTask__GetStatus
	ldrb r0, [r0, #1]
	cmp r0, #8
	mov r0, #5
	strh r0, [r4, #0xc]
	bne _021731B0
	bl GetExTaskCurrent
	ldr r1, _021731D4 // =ovl09_21732E4
	str r1, [r0]
	bl ovl09_21732E4
	ldmia sp!, {r4, pc}
_021731B0:
	bl GetExTaskCurrent
	ldr r1, _021731D8 // =ovl09_21731DC
	str r1, [r0]
	ldmia sp!, {r4, pc}
_021731C0:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021731D0: .word exSysTask__Value_2178644
_021731D4: .word ovl09_21732E4
_021731D8: .word ovl09_21731DC
	arm_func_end ovl09_2173158

	arm_func_start ovl09_21731DC
ovl09_21731DC: // 0x021731DC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrsh r1, [r4, #0xc]
	sub r0, r1, #1
	strh r0, [r4, #0xc]
	cmp r1, #0
	bgt _02173224
	bl ovl09_216AA78
	bl ovl09_216AD70
	ldr r0, _02173234 // =exSysTask__Value_2178644
	mov r1, #0
	str r1, [r0, #0xc]
	mov r0, #0xf
	strh r0, [r4, #0xc]
	bl GetExTaskCurrent
	ldr r1, _02173238 // =ovl09_217323C
	str r1, [r0]
_02173224:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02173234: .word exSysTask__Value_2178644
_02173238: .word ovl09_217323C
	arm_func_end ovl09_21731DC

	arm_func_start ovl09_217323C
ovl09_217323C: // 0x0217323C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrsh r2, [r0, #0xc]
	sub r1, r2, #1
	strh r1, [r0, #0xc]
	cmp r2, #0
	bgt _021732CC
	ldr r0, _021732DC // =exSysTask__Value_2178644
	mov r1, #0
	str r1, [r0, #0x10]
	bl ovl09_2172A50
	bl exDrawReqTask__Create
	bl exHitCheckTask__Create
	bl exGameSystemTask__Create
	bl exFixAdminTask__Create
	mov r0, #1
	mov r1, #0
	str r0, [sp]
	sub r0, r0, #0x11
	mov r2, #0x20
	mov r3, r1
	bl exDrawFadeTask__Create
	mov r0, #2
	mov r1, #0
	str r0, [sp]
	sub r0, r0, #0x12
	mov r2, #0x20
	mov r3, r1
	bl exDrawFadeTask__Create
	bl exSysTask__GetStatus
	mov r1, #3
	strb r1, [r0, #3]
	bl GetExTaskCurrent
	ldr r1, _021732E0 // =ovl09_2172D30
	str r1, [r0]
	ldmia sp!, {r3, pc}
_021732CC:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021732DC: .word exSysTask__Value_2178644
_021732E0: .word ovl09_2172D30
	arm_func_end ovl09_217323C

	arm_func_start ovl09_21732E4
ovl09_21732E4: // 0x021732E4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldrsh r2, [r0, #0xc]
	sub r1, r2, #1
	strh r1, [r0, #0xc]
	cmp r2, #0
	ldmgtia sp!, {r3, pc}
	bl ovl09_216AA78
	bl ovl09_216AD70
	ldr r0, _02173330 // =exSysTask__Value_2178644
	mov r1, #1
	str r1, [r0, #0x10]
	bl GetExTaskCurrent
	ldr r1, _02173334 // =ovl09_2173338
	str r1, [r0]
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02173330: .word exSysTask__Value_2178644
_02173334: .word ovl09_2173338
	arm_func_end ovl09_21732E4

	arm_func_start ovl09_2173338
ovl09_2173338: // 0x02173338
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CloseTaskSystem
	bl Camera3D__Destroy
	bl exSysTask__GetStatus
	ldrb r0, [r0, #1]
	bl ovl09_2173CC8
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_2173338

	arm_func_start exSysTask__Create
exSysTask__Create: // 0x02173358
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r2, #0
	str r2, [sp]
	mov r0, #0x10
	ldr r3, _021733C0 // =aExsystask
	str r0, [sp, #4]
	ldr r0, _021733C4 // =exSysTask__Main
	ldr r1, _021733C8 // =exSysTask__Destructor
	str r3, [sp, #8]
	mov r3, #1
	str r3, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	ldr r3, _021733CC // =exSysTask__Value_2178644
	mov r1, #0
	mov r2, #0x10
	str r0, [r3, #4]
	bl MI_CpuFill8
	mov r0, r4
	bl GetExTask
	ldr r1, _021733D0 // =exSysTask__Func8
	str r1, [r0, #8]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_021733C0: .word aExsystask
_021733C4: .word exSysTask__Main
_021733C8: .word exSysTask__Destructor
_021733CC: .word exSysTask__Value_2178644
_021733D0: .word exSysTask__Func8
	arm_func_end exSysTask__Create

	arm_func_start ovl09_21733D4
ovl09_21733D4: // 0x021733D4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x68
	ldr r1, _0217341C // =exSysTask__Value_2178644
	mov r4, r0
	ldr r1, [r1, #4]
	add r0, sp, #0
	ldr r2, [r1, #4]
	ldr r1, _02173420 // =aEx
	bl NNS_FndMountArchive
	add r0, sp, #0
	mov r1, r4
	bl NNS_FndGetArchiveFileByIndex
	mov r4, r0
	add r0, sp, #0
	bl NNS_FndUnmountArchive
	mov r0, r4
	add sp, sp, #0x68
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217341C: .word exSysTask__Value_2178644
_02173420: .word aEx
	arm_func_end ovl09_21733D4

	arm_func_start ovl09_2173424
ovl09_2173424: // 0x02173424
	ldr r0, _02173434 // =exSysTask__Value_2178644
	ldr r0, [r0, #4]
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_02173434: .word exSysTask__Value_2178644
	arm_func_end ovl09_2173424

	arm_func_start ovl09_2173438
ovl09_2173438: // 0x02173438
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r1, #0
	ldr r0, _021734F0 // =aExtraExBb_12
	mov r2, r1
	bl ReadFileFromBundle
	str r0, [r5]
	mov r1, #1
	ldr r0, _021734F0 // =aExtraExBb_12
	sub r2, r1, #2
	bl ReadFileFromBundle
	mov r4, r0
	ldr r1, [r4, #0]
	and r0, r1, #0xf0
	cmp r0, #0x20
	bhi _02173488
	bhs _021734B8
	cmp r0, #0x10
	beq _02173498
	b _021734B8
_02173488:
	cmp r0, #0x30
	bls _021734B8
	cmp r0, #0x80
	b _021734B8
_02173498:
	mov r0, r1, lsr #8
	bl _AllocHeadHEAP_USER
	str r0, [r5, #4]
	mov r1, r0
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
_021734B8:
	mov r2, #0
	ldr r0, _021734F4 // =audioManagerSndHeap
	str r2, [sp]
	ldr r0, [r0, #0]
	ldr r1, _021734F8 // =0x00057800
	mov r3, r2
	bl NNS_SndHeapAlloc
	str r0, [r5, #8]
	mov r1, r0
	ldr r0, _021734FC // =aExtraSoundData
	bl FSRequestFileSync
	ldr r0, [r5, #8]
	bl InitAudioSystemForStage
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021734F0: .word aExtraExBb_12
_021734F4: .word audioManagerSndHeap
_021734F8: .word 0x00057800
_021734FC: .word aExtraSoundData
	arm_func_end ovl09_2173438

	arm_func_start ovl09_2173500
ovl09_2173500: // 0x02173500
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r5, #0
	bl VRAMSystem__Reset
	mov r0, #0x10
	mov ip, #0x400
	add r1, r0, #0x100000
	mov r2, #0x40
	mov r3, r5
	str ip, [sp]
	bl VRAMSystem__SetupOBJBank
	mov r0, r5
	bl VRAMSystem__InitSpriteBuffer
	mov r0, #0x40
	bl VRAMSystem__SetupBGBank
	mov r0, #3
	bl VRAMSystem__SetupTextureBank
	mov r0, #0x20
	bl VRAMSystem__SetupTexturePalBank
	mov r0, #1
	mov r1, r5
	mov r2, r0
	bl GX_SetGraphicsMode
	mov r1, #0x4000000
	ldr r0, [r1, #0]
	mov r2, r5
	bic r0, r0, #0x38000000
	str r0, [r1]
	ldr ip, [r1]
	ldr r0, _02173654 // =renderCoreSwapBuffer
	bic ip, ip, #0x7000000
	str ip, [r1]
	str r2, [r0, #4]
	mov r2, #1
	str r2, [r0, #8]
	ldrh r2, [r1, #8]
	orr r3, r5, #0x11
	ldr r0, _02173658 // =0x0213D2E0
	bic r2, r2, #3
	strh r2, [r1, #8]
	ldrh r2, [r1, #0xa]
	bic r2, r2, #3
	orr r2, r2, #1
	strh r2, [r1, #0xa]
	ldrh r2, [r1, #0xc]
	bic r2, r2, #3
	orr r2, r2, #2
	strh r2, [r1, #0xc]
	ldrh r2, [r1, #0xe]
	bic r2, r2, #3
	orr r2, r2, #3
	strh r2, [r1, #0xe]
	ldr r2, [r1, #0]
	bic r2, r2, #0x1f00
	orr r2, r2, r3, lsl #8
	str r2, [r1]
	bl RenderCore_DisableBlending
	ldr r0, _0217365C // =renderCoreGFXControlA
	mov r1, r5
	str r1, [r0, #0x1c]
	ldr r2, _02173660 // =0x04001000
	ldr r0, _02173664 // =0x0213D284
	ldr r1, [r2, #0]
	bic r1, r1, #0x1f00
	str r1, [r2]
	bl RenderCore_DisableBlending
	ldr r0, _02173668 // =renderCoreGFXControlB
	mov r1, r5
	str r1, [r0, #0x1c]
	ldr r3, _0217366C // =0x04000304
	ldr r0, _02173670 // =0xFFFFFDF1
	ldrh r2, [r3, #0]
	ldr r1, _02173674 // =0xBFFF0000
	and r0, r2, r0
	orr r0, r0, #0xe
	orr r0, r0, #0x200
	strh r0, [r3]
	str r1, [r3, #0x27c]
	ldr r0, [r4, #0]
	ldr r1, _02173678 // =0x001FFFF8
	bl LoadDrawState
	bl ReleaseAudioSystem
	mov r0, #1
	bl NNS_G3dGeUseFastDma
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02173654: .word renderCoreSwapBuffer
_02173658: .word 0x0213D2E0
_0217365C: .word renderCoreGFXControlA
_02173660: .word 0x04001000
_02173664: .word 0x0213D284
_02173668: .word renderCoreGFXControlB
_0217366C: .word 0x04000304
_02173670: .word 0xFFFFFDF1
_02173674: .word 0xBFFF0000
_02173678: .word 0x001FFFF8
	arm_func_end ovl09_2173500

	.data

aExsystask: // 0x02175EA8
	.asciz "exSysTask"
	.align 4

aEx: // 0x02175EB4
	.asciz "ex"
	.align 4

aExtraExBb_12: // 0x02175EB8
	.asciz "/extra/ex.bb"
	.align 4
	
aExtraSoundData: // 0x02175EC8
	.asciz "/extra/sound_data.sdat"