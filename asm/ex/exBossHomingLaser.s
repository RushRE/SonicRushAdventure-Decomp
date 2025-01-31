	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

.public exBossHomingLaserTask__ActiveInstanceCount
exBossHomingLaserTask__ActiveInstanceCount: // 0x0217617C
    .space 0x02

.public exBossHomingLaserTask__ActiveInstanceCount
exBossHomingLaserTask__unk_217617E: // 0x0217617E
    .space 0x02

	.align 4

.public exBossHomingLaserTask__TaskSingleton
exBossHomingLaserTask__TaskSingleton: // 0x02176180
    .space 0x04
	
.public exBossHomingLaserTask__FileTable
exBossHomingLaserTask__FileTable: // 0x02176184
    .space 0x04

	.text

	arm_func_start exBossHomingLaserTask__Func_2159CEC
exBossHomingLaserTask__Func_2159CEC: // 0x02159CEC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	bl exDrawReqTask__InitSprite3D
	ldr r0, _02159DEC // =exBossHomingLaserTask__ActiveInstanceCount
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02159D1C
	mov r0, #0
	bl LoadExSystemFile
	ldr r1, _02159DEC // =exBossHomingLaserTask__ActiveInstanceCount
	str r0, [r1, #8]
_02159D1C:
	ldr r0, _02159DEC // =exBossHomingLaserTask__ActiveInstanceCount
	mov r1, #1
	ldr r0, [r0, #8]
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	ldr r1, _02159DEC // =exBossHomingLaserTask__ActiveInstanceCount
	mov r5, r0
	ldr r0, [r1, #8]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	ldr r2, _02159DEC // =exBossHomingLaserTask__ActiveInstanceCount
	add r0, r4, #0x20
	ldr r2, [r2, #8]
	mov r1, #0
	mov r3, #0xd
	bl AnimatorSprite3D__Init
	ldr r0, [r4, #0x114]
	mov r3, #0
	orr r0, r0, #0x800
	str r0, [r4, #0x114]
	strb r3, [r4]
	ldrb r2, [r4, #3]
	mov r1, #0x46000
	mov r0, #0x400
	orr r2, r2, #4
	strb r2, [r4, #3]
	str r1, [r4, #0x134]
	str r0, [r4, #0x138]
	str r0, [r4, #0x13c]
	str r0, [r4, #0x140]
	ldrb r2, [r4, #0x150]
	mov r1, #0x2000
	add r0, r4, #0x12c
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r4, #0x150]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r3, [r4, #0x14]
	str r0, [r4, #0x18]
	ldr r0, _02159DEC // =exBossHomingLaserTask__ActiveInstanceCount
	ldrsh r1, [r0, #0]
	add r1, r1, #1
	strh r1, [r0]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02159DEC: .word exBossHomingLaserTask__ActiveInstanceCount
	arm_func_end exBossHomingLaserTask__Func_2159CEC

	arm_func_start exBossHomingLaserTask__Func_2159DF0
exBossHomingLaserTask__Func_2159DF0: // 0x02159DF0
	stmdb sp!, {r3, lr}
	add r0, r0, #0x20
	bl AnimatorSprite3D__Release
	ldr r0, _02159E10 // =exBossHomingLaserTask__ActiveInstanceCount
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02159E10: .word exBossHomingLaserTask__ActiveInstanceCount
	arm_func_end exBossHomingLaserTask__Func_2159DF0

	arm_func_start exBossHomingLaserTask__AnyActive
exBossHomingLaserTask__AnyActive: // 0x02159E14
	ldr r0, _02159E20 // =exBossHomingLaserTask__ActiveInstanceCount
	ldrsh r0, [r0, #2]
	bx lr
	.align 2, 0
_02159E20: .word exBossHomingLaserTask__ActiveInstanceCount
	arm_func_end exBossHomingLaserTask__AnyActive

	arm_func_start exBossHomingLaserTask__Main
exBossHomingLaserTask__Main: // 0x02159E24
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _02159F5C // =exBossHomingLaserTask__ActiveInstanceCount
	mov r4, r0
	ldrsh r2, [r1, #2]
	add r0, r4, #0x44
	add r2, r2, #1
	strh r2, [r1, #2]
	bl exBossHomingLaserTask__Func_2159CEC
	add r0, r4, #0x194
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x194
	bl exDrawReqTask__Func_2164218
	bl GetCurrentTask
	ldr r1, _02159F5C // =exBossHomingLaserTask__ActiveInstanceCount
	ldr r3, _02159F60 // =0x021740A4
	str r0, [r1, #4]
	ldr r0, [r4, #0x40]
	ldr ip, _02159F64 // =0xB40B40B5
	ldr r1, [r0, #0x3ec]
	add r0, r4, #0x2e4
	str r1, [r4, #0x2c]
	ldr r2, [r4, #0x40]
	add r1, r4, #0x2c
	ldr r5, [r2, #0x3f0]
	mov r2, #3
	str r5, [r4, #0x30]
	ldr r5, [r4, #0x40]
	ldr r5, [r5, #0x3f4]
	str r5, [r4, #0x34]
	ldrh r5, [r4, #0]
	mov r5, r5, lsl #1
	ldrh r5, [r3, r5]
	smull r3, lr, ip, r5
	add lr, r5, lr
	mov r3, r5, lsr #0x1f
	strh r5, [r4, #0x3a]
	add lr, r3, lr, asr #7
	strh lr, [r4, #0x26]
	ldrh r3, [r4, #0x3a]
	strh r3, [r4, #0x22]
	bl exDrawReqTask__InitTrail
	ldr r1, _02159F68 // =0x0000A7FF
	add r0, r4, #0x550
	bl exDrawReqTask__SetConfigPriority
	mov r0, #1
	strh r0, [r4, #4]
	ldr r2, _02159F6C // =_mt_math_rand
	ldr r0, _02159F70 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02159F74 // =0x3C6EF35F
	ldr ip, _02159F78 // =0x51EB851F
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
	bl GetExTaskCurrent
	ldr r1, _02159F7C // =exBossHomingLaserTask__Main_2159FE4
	str r1, [r0]
	bl exBossHomingLaserTask__Main_2159FE4
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02159F5C: .word exBossHomingLaserTask__ActiveInstanceCount
_02159F60: .word 0x021740A4
_02159F64: .word 0xB40B40B5
_02159F68: .word 0x0000A7FF
_02159F6C: .word _mt_math_rand
_02159F70: .word 0x00196225
_02159F74: .word 0x3C6EF35F
_02159F78: .word 0x51EB851F
_02159F7C: .word exBossHomingLaserTask__Main_2159FE4
	arm_func_end exBossHomingLaserTask__Main

	arm_func_start exBossHomingLaserTask__Func8
exBossHomingLaserTask__Func8: // 0x02159F80
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02159FA4 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02159FA4: .word ExTask_State_Destroy
	arm_func_end exBossHomingLaserTask__Func8

	arm_func_start exBossHomingLaserTask__Destructor
exBossHomingLaserTask__Destructor: // 0x02159FA8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _02159FE0 // =exBossHomingLaserTask__ActiveInstanceCount
	add r0, r0, #0x44
	ldrsh r2, [r1, #2]
	cmp r2, #1
	subgt r2, r2, #1
	movle r2, #0
	strh r2, [r1, #2]
	bl exBossHomingLaserTask__Func_2159DF0
	ldr r0, _02159FE0 // =exBossHomingLaserTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02159FE0: .word exBossHomingLaserTask__ActiveInstanceCount
	arm_func_end exBossHomingLaserTask__Destructor

	arm_func_start exBossHomingLaserTask__Main_2159FE4
exBossHomingLaserTask__Main_2159FE4: // 0x02159FE4
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExPlayerPosition
	mov r5, r0
	add r0, r4, #0x44
	bl exDrawReqTask__Sprite3D__Animate
	ldr r0, [r4, #0x28]
	mov r1, #0
	bl _fgr
	ldr r1, [r4, #0x28]
	ldr r0, _0215A260 // =0x45800000
	bls _0215A02C
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0215A038
_0215A02C:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0215A038:
	bl _f_ftoi
	str r0, [r4, #8]
	ldr r0, [r4, #0x28]
	mov r1, #0
	bl _fgr
	ldr r1, [r4, #0x28]
	ldr r0, _0215A260 // =0x45800000
	bls _0215A06C
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0215A078
_0215A06C:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0215A078:
	bl _f_ftoi
	str r0, [r4, #0xc]
	ldr r0, [r4, #0x28]
	mov r1, #0
	bl _fgr
	ldr r1, [r4, #0x28]
	ldr r0, _0215A260 // =0x45800000
	bls _0215A0AC
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0215A0B8
_0215A0AC:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0215A0B8:
	bl _f_ftoi
	str r0, [r4, #0x10]
	ldrsh r0, [r4, #4]
	sub r0, r0, #1
	strh r0, [r4, #4]
	ldrsh r0, [r4, #4]
	cmp r0, #0
	bge _0215A128
	mov r1, #1
	ldr r0, _0215A264 // =0x00000444
	strh r1, [r4, #4]
	str r0, [sp]
	ldr r3, [r4, #0x30]
	ldr r0, [r5, #4]
	ldr r2, [r4, #0x2c]
	ldr r1, [r5, #0]
	sub r0, r3, r0
	sub r1, r2, r1
	add r2, r4, #0x20
	add r3, r4, #0x26
	bl ovl09_2152EA8
	ldrh r5, [r4, #0x22]
	add r3, r4, #0x300
	add r0, r4, #0x2e4
	add r1, r4, #0x2c
	mov r2, #0
	strh r5, [r3, #4]
	bl exDrawReqTask__Trail__HandleTrail5
_0215A128:
	ldrh r1, [r4, #0x22]
	ldr r2, _0215A268 // =FX_SinCosTable_
	ldr r0, [r4, #8]
	mov r1, r1, asr #4
	mov r1, r1, lsl #1
	add r1, r1, #1
	mov r1, r1, lsl #1
	ldrsh r1, [r2, r1]
	smull r3, r0, r1, r0
	adds r1, r3, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #8]
	ldrh r1, [r4, #0x22]
	ldr r0, [r4, #0xc]
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r1, [r2, r1]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0xc]
	ldr r1, [r4, #0x2c]
	ldr r0, [r4, #8]
	sub r0, r1, r0
	str r0, [r4, #0x2c]
	ldr r1, [r4, #0x30]
	ldr r0, [r4, #0xc]
	sub r0, r1, r0
	str r0, [r4, #0x30]
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215A1C0
	bl exBossHomingLaserTask__Func_215A388
	ldmia sp!, {r3, r4, r5, pc}
_0215A1C0:
	bl GetExPlayerPosition
	ldr r0, [r0, #4]
	cmp r0, #0xf000
	blt _0215A1F0
	bl GetExPlayerPosition
	ldr r0, [r0, #4]
	ldr r1, [r4, #0x30]
	add r0, r0, #0x1000
	cmp r1, r0
	bgt _0215A1F0
	bl exBossHomingLaserTask__Func_215A270
	ldmia sp!, {r3, r4, r5, pc}
_0215A1F0:
	ldr r1, [r4, #0x30]
	cmp r1, #0xf000
	bgt _0215A204
	bl exBossHomingLaserTask__Func_215A270
	ldmia sp!, {r3, r4, r5, pc}
_0215A204:
	ldr r0, _0215A26C // =0x00024C04
	cmp r1, r0
	ble _0215A21C
	add r0, r4, #0x2e4
	add r1, r4, #0x550
	bl exDrawReqTask__AddRequest
_0215A21C:
	ldr r1, [r4, #0x30]
	ldr r0, _0215A26C // =0x00024C04
	cmp r1, r0
	bgt _0215A248
	ldr r1, [r4, #0x2c]
	add r0, r4, #0x44
	str r1, [r4, #0x170]
	ldr r2, [r4, #0x30]
	add r1, r4, #0x194
	str r2, [r4, #0x174]
	bl exDrawReqTask__AddRequest
_0215A248:
	add r0, r4, #0x2e4
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A260: .word 0x45800000
_0215A264: .word 0x00000444
_0215A268: .word FX_SinCosTable_
_0215A26C: .word 0x00024C04
	arm_func_end exBossHomingLaserTask__Main_2159FE4

	arm_func_start exBossHomingLaserTask__Func_215A270
exBossHomingLaserTask__Func_215A270: // 0x0215A270
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r1, #0x90
	strh r1, [r0, #2]
	ldrb r2, [r0, #0x550]
	mov ip, #0xc6
	sub r1, ip, #0xc7
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r0, #0x550]
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0215A2C8 // =exBossHomingLaserTask__Func_215A2CC
	str r1, [r0]
	bl exBossHomingLaserTask__Func_215A2CC
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215A2C8: .word exBossHomingLaserTask__Func_215A2CC
	arm_func_end exBossHomingLaserTask__Func_215A270

	arm_func_start exBossHomingLaserTask__Func_215A2CC
exBossHomingLaserTask__Func_215A2CC: // 0x0215A2CC
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r5, r0
	bl GetExPlayerPosition
	mov r4, r0
	add r0, r5, #0x44
	bl exDrawReqTask__Sprite3D__Animate
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215A2FC
	bl exBossHomingLaserTask__Func_215A388
	ldmia sp!, {r3, r4, r5, pc}
_0215A2FC:
	ldrsh r1, [r5, #2]
	sub r0, r1, #1
	strh r0, [r5, #2]
	cmp r1, #0
	bge _0215A318
	bl exBossHomingLaserTask__Func_215A388
	ldmia sp!, {r3, r4, r5, pc}
_0215A318:
	ldr r0, _0215A384 // =0x00000444
	add r2, r5, #0x20
	str r0, [sp]
	ldr ip, [r5, #0x30]
	ldr r0, [r4, #4]
	ldr r3, [r5, #0x2c]
	ldr r1, [r4, #0]
	sub r0, ip, r0
	sub r1, r3, r1
	add r3, r5, #0x26
	bl ovl09_2152EA8
	ldrh r4, [r5, #0x22]
	add r3, r5, #0x300
	add r0, r5, #0x2e4
	add r1, r5, #0x2c
	mov r2, #1
	strh r4, [r3, #4]
	bl exDrawReqTask__Trail__HandleTrail5
	add r0, r5, #0x44
	add r1, r5, #0x194
	bl exDrawReqTask__AddRequest
	add r0, r5, #0x2e4
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A384: .word 0x00000444
	arm_func_end exBossHomingLaserTask__Func_215A2CC

	arm_func_start exBossHomingLaserTask__Func_215A388
exBossHomingLaserTask__Func_215A388: // 0x0215A388
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov r0, #1
	ldr r2, _0215A41C // =_mt_math_rand
	strh r0, [r4, #4]
	ldr r5, [r2, #0]
	ldr r0, _0215A420 // =0x00196225
	ldr r3, _0215A424 // =0x3C6EF35F
	ldr r1, _0215A428 // =0x51EB851F
	mla r3, r5, r0, r3
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	mov r5, ip, lsr #0x1f
	smull ip, lr, r1, ip
	add lr, r5, lr, asr #4
	mov r5, #0x32
	smull ip, lr, r5, lr
	rsb lr, ip, r0, lsr #16
	add r0, lr, #1
	mov r5, r0, lsr #0x1f
	smull ip, r0, r1, r0
	add r0, r5, r0, asr #5
	str r3, [r2]
	bl _f_itof
	mov r1, r0
	ldr r0, _0215A42C // =0x40A00000
	bl _fadd
	str r0, [r4, #0x28]
	mov r0, #1
	strh r0, [r4, #2]
	bl GetExTaskCurrent
	ldr r1, _0215A430 // =exBossHomingLaserTask__Func_215A434
	str r1, [r0]
	bl exBossHomingLaserTask__Func_215A434
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A41C: .word _mt_math_rand
_0215A420: .word 0x00196225
_0215A424: .word 0x3C6EF35F
_0215A428: .word 0x51EB851F
_0215A42C: .word 0x40A00000
_0215A430: .word exBossHomingLaserTask__Func_215A434
	arm_func_end exBossHomingLaserTask__Func_215A388

	arm_func_start exBossHomingLaserTask__Func_215A434
exBossHomingLaserTask__Func_215A434: // 0x0215A434
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExPlayerPosition
	mov r5, r0
	ldr r0, [r4, #0x28]
	mov r1, #0
	bl _fgr
	ldr r1, [r4, #0x28]
	ldr r0, _0215A670 // =0x45800000
	bls _0215A474
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0215A480
_0215A474:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0215A480:
	bl _f_ftoi
	str r0, [r4, #8]
	ldr r0, [r4, #0x28]
	mov r1, #0
	bl _fgr
	ldr r1, [r4, #0x28]
	ldr r0, _0215A670 // =0x45800000
	bls _0215A4B4
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0215A4C0
_0215A4B4:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0215A4C0:
	bl _f_ftoi
	str r0, [r4, #0xc]
	ldr r0, [r4, #0x28]
	mov r1, #0
	bl _fgr
	ldr r1, [r4, #0x28]
	ldr r0, _0215A670 // =0x45800000
	bls _0215A4F4
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _0215A500
_0215A4F4:
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_0215A500:
	bl _f_ftoi
	str r0, [r4, #0x10]
	ldrsh r0, [r4, #4]
	sub r0, r0, #1
	strh r0, [r4, #4]
	ldrsh r0, [r4, #4]
	cmp r0, #0
	bge _0215A570
	mov r0, #1
	strh r0, [r4, #4]
	mov r0, #0x16c
	str r0, [sp]
	ldr r3, [r4, #0x30]
	ldr r0, [r5, #4]
	ldr r2, [r4, #0x2c]
	ldr r1, [r5, #0]
	sub r0, r3, r0
	sub r1, r2, r1
	add r2, r4, #0x20
	add r3, r4, #0x26
	bl ovl09_2152EA8
	ldrh r5, [r4, #0x22]
	add r3, r4, #0x300
	add r0, r4, #0x2e4
	add r1, r4, #0x2c
	mov r2, #2
	strh r5, [r3, #4]
	bl exDrawReqTask__Trail__HandleTrail5
_0215A570:
	ldrh r0, [r4, #0x22]
	ldr r5, _0215A674 // =FX_SinCosTable_
	ldr r2, [r4, #8]
	mov r0, r0, asr #4
	mov r0, r0, lsl #1
	add r0, r0, #1
	mov r0, r0, lsl #1
	ldrsh r3, [r5, r0]
	mov r0, #0
	mov r1, #0x800
	smull ip, r2, r3, r2
	adds r3, ip, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r4, #8]
	ldrh r3, [r4, #0x22]
	ldr r2, [r4, #0xc]
	mov r3, r3, asr #4
	mov r3, r3, lsl #2
	ldrsh r3, [r5, r3]
	smull r5, r2, r3, r2
	adds r3, r5, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [r4, #0xc]
	ldr r3, [r4, #0x2c]
	cmp r3, #0x5a000
	bge _0215A60C
	sub r0, r0, #0x5a000
	cmp r3, r0
	ble _0215A60C
	ldr r2, [r4, #0x30]
	cmp r2, #0xc8000
	bge _0215A60C
	sub r0, r1, #0x3c800
	cmp r2, r0
	bgt _0215A630
_0215A60C:
	ldrsh r1, [r4, #2]
	sub r0, r1, #1
	strh r0, [r4, #2]
	cmp r1, #0
	bgt _0215A64C
	bl GetExTaskCurrent
	ldr r1, _0215A678 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, pc}
_0215A630:
	ldr r0, [r4, #8]
	sub r0, r3, r0
	str r0, [r4, #0x2c]
	ldr r1, [r4, #0x30]
	ldr r0, [r4, #0xc]
	sub r0, r1, r0
	str r0, [r4, #0x30]
_0215A64C:
	add r0, r4, #0x2e4
	add r1, r4, #0x550
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x2e4
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A670: .word 0x45800000
_0215A674: .word FX_SinCosTable_
_0215A678: .word ExTask_State_Destroy
	arm_func_end exBossHomingLaserTask__Func_215A434

	arm_func_start exBossHomingLaserTask__Create
exBossHomingLaserTask__Create: // 0x0215A67C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x6a0
	str r1, [sp, #4]
	ldr r0, _0215A6F8 // =aExbosshomingla
	ldr r1, _0215A6FC // =exBossHomingLaserTask__Destructor
	str r0, [sp, #8]
	ldr r0, _0215A700 // =exBossHomingLaserTask__Main
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x6a0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x40]
	ldrh r1, [r0, #0x66]
	mov r0, r5
	strh r1, [r4]
	bl GetExTask
	ldr r1, _0215A704 // =exBossHomingLaserTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A6F8: .word aExbosshomingla
_0215A6FC: .word exBossHomingLaserTask__Destructor
_0215A700: .word exBossHomingLaserTask__Main
_0215A704: .word exBossHomingLaserTask__Func8
	arm_func_end exBossHomingLaserTask__Create

	arm_func_start exBossSysAdminTask__Action_StartHomi0
exBossSysAdminTask__Action_StartHomi0: // 0x0215A708
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #9
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl exBossEffectHomingTask__Create
	mov r0, #0
	str r0, [sp]
	mov r1, #0x104
	str r1, [sp, #4]
	sub r1, r0, #1
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	bl GetExTaskCurrent
	ldr r1, _0215A768 // =exBossSysAdminTask__Main_StartHomi0
	str r1, [r0]
	bl exBossSysAdminTask__Main_StartHomi0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A768: .word exBossSysAdminTask__Main_StartHomi0
	arm_func_end exBossSysAdminTask__Action_StartHomi0

	arm_func_start exBossSysAdminTask__Main_StartHomi0
exBossSysAdminTask__Main_StartHomi0: // 0x0215A76C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0x1e000
	blt _0215A7C8
	mov ip, #0xc9
	sub r1, ip, #0xca
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0215A7F0 // =exBossSysAdminTask__Main_FinishHomi0
	str r1, [r0]
	bl exBossSysAdminTask__Main_FinishHomi0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215A7C8:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A7F0: .word exBossSysAdminTask__Main_FinishHomi0
	arm_func_end exBossSysAdminTask__Main_StartHomi0

	arm_func_start exBossSysAdminTask__Main_FinishHomi0
exBossSysAdminTask__Main_FinishHomi0: // 0x0215A7F4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215A820
	bl exBossSysAdminTask__Action_StartHomi1
	ldmia sp!, {r4, pc}
_0215A820:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_FinishHomi0

	arm_func_start exBossSysAdminTask__Action_StartHomi1
exBossSysAdminTask__Action_StartHomi1: // 0x0215A844
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0xa
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _0215A878 // =exBossSysAdminTask__Main_StartHomi1
	str r1, [r0]
	bl exBossSysAdminTask__Main_StartHomi1
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A878: .word exBossSysAdminTask__Main_StartHomi1
	arm_func_end exBossSysAdminTask__Action_StartHomi1

	arm_func_start exBossSysAdminTask__Main_StartHomi1
exBossSysAdminTask__Main_StartHomi1: // 0x0215A87C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0xa000
	blt _0215A8FC
	mov r5, #0
_0215A8A8:
	strh r5, [r4, #0x66]
	bl exBossHomingLaserTask__Create
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #6
	blo _0215A8A8
	mov ip, #0xc5
	sub r1, ip, #0xc6
	mov r0, #0
	strh r0, [r4, #0x66]
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0215A940 // =exBossSysAdminTask__Main_FinishHomi1
	str r1, [r0]
	bl exBossSysAdminTask__Main_FinishHomi1
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_0215A8FC:
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215A918
	bl exBossSysAdminTask__Action_StartHomi2
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
_0215A918:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215A940: .word exBossSysAdminTask__Main_FinishHomi1
	arm_func_end exBossSysAdminTask__Main_StartHomi1

	arm_func_start exBossSysAdminTask__Main_FinishHomi1
exBossSysAdminTask__Main_FinishHomi1: // 0x0215A944
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215A970
	bl exBossSysAdminTask__Action_StartHomi2
	ldmia sp!, {r4, pc}
_0215A970:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_FinishHomi1

	arm_func_start exBossSysAdminTask__Action_StartHomi2
exBossSysAdminTask__Action_StartHomi2: // 0x0215A994
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exBossEffectShotTask__Func_215753C
	add r0, r4, #0x6c
	mov r1, #0xb
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _0215A9CC // =exBossSysAdminTask__Main_StartHomi2
	str r1, [r0]
	bl exBossSysAdminTask__Main_StartHomi2
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215A9CC: .word exBossSysAdminTask__Main_StartHomi2
	arm_func_end exBossSysAdminTask__Action_StartHomi2

	arm_func_start exBossSysAdminTask__Main_StartHomi2
exBossSysAdminTask__Main_StartHomi2: // 0x0215A9D0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215A9FC
	bl exBossSysAdminTask__Action_FinishHomingAttack
	ldmia sp!, {r4, pc}
_0215A9FC:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Main_StartHomi2

	arm_func_start exBossSysAdminTask__Action_FinishHomingAttack
exBossSysAdminTask__Action_FinishHomingAttack: // 0x0215AA20
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0x548]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__Action_FinishHomingAttack

	.data
	
_021740A4:
	.word 0x80009555, 0x15556AAA, 0xEAAA00B6

aExbosshomingla: // 0x021740B0
	.asciz "exBossHomingLaserTask"