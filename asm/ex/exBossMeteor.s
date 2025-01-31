	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exBossMeteLockOnTask__ActiveInstanceCount: // 0x021761CC
	.space 0x02

exBossMeteBombTask__ActiveInstanceCount: // 0x021761CE
	.space 0x02

exBossMeteMeteoTask__ActiveInstanceCount: // 0x021761D0
	.space 0x02

	.align 4

exBossMeteMeteoTask__FileTable: // 0x021761D4
    .space 0x04
	
exBossMeteMeteoTask_unk_21761D8: // 0x021761D8
    .space 0x04
	
exBossMeteMeteoTask__AnimTable: // 0x021761DC
    .space 0x04
	
exBossMeteBombTask__unk_21761E0: // 0x021761E0
    .space 0x04
	
exBossMeteMeteoTask__TaskSingleton: // 0x021761E4
    .space 0x04
	
exBossMeteMeteoTask__unk_21761E8: // 0x021761E8
    .space 0x04
	
exBossMeteMeteoTask__dword_21761EC: // 0x021761EC
    .space 0x04
	
exBossMeteBombTask__unk_21761F0: // 0x021761F0
    .space 0x04
	
exBossMeteMeteoTask__unk_21761F4: // 0x021761F4
    .space 0x04
	
exBossMeteMeteoTask__dword_21761F8: // 0x021761F8
    .space 0x04
	
exBossMeteLockOnTask__unk_21761FC: // 0x021761FC
    .space 0x04
	
exBossMeteLockOnTask__TaskSingleton: // 0x02176200
    .space 0x04
	
exBossMeteAdminTask__TaskSingleton: // 0x02176204
    .space 0x04
	
exBossMeteLockOnTask__unk_2176208: // 0x02176208
    .space 0x04
	
exBossMeteLockOnTask__unk_217620C: // 0x0217620C
    .space 0x04

exBossMeteLockOnTask__unk_2176210: // 0x02176210
    .space 0x04
	
exBossMeteLockOnTask__dword_2176214: // 0x02176214
    .space 0x04
	
exBossMeteBombTask__dword_2176218: // 0x02176218
    .space 0x04
	
exBossMeteBombTask__TaskSingleton: // 0x0217621C
    .space 0x04
	
exBossMeteBombTask__unk_2176220: // 0x02176220
    .space 0x04
	
exBossMeteBombTask__dword_2176224: // 0x02176224
    .space 0x04
	
exBossMeteLockOnTask__AnimTable: // 0x02176228
    .space 0x04 * 3
	
exBossMeteLockOnTask__FileTable: // 0x02176234
    .space 0x04 * 3
	
exBossMeteMeteoTask__unk_2176240: // 0x02176240
    .space 0x04
	
exBossMeteMeteoTask__unk_2176244: // 0x02176244
    .space 0x04
	
exBossMeteMeteoTask__unk_2176248: // 0x02176248
    .space 0x04
	
exBossMeteBombTask__AnimTable: // 0x0217624C
    .space 0x04 * 4
	
exBossMeteBombTask__FileTable: // 0x0217625C
    .space 0x04 * 4

	.text

	arm_func_start exBossMeteBombTask__Func_215C00C
exBossMeteBombTask__Func_215C00C: // 0x0215C00C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _0215C278 // =0x021761CC
	mov r4, r0
	str r4, [r1, #0x14]
	ldr r0, [r1, #0x58]
	cmp r0, #0
	ldrne r0, [r1, #0x24]
	cmpne r0, #0
	beq _0215C088
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0215C278 // =0x021761CC
	ldr r1, [r1, #0x58]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0215C278 // =0x021761CC
	ldr r1, [r1, #0x24]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0215C278 // =0x021761CC
	ldr r1, [r1, #0x58]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0215C088:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _0215C278 // =0x021761CC
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _0215C14C
	mov r1, #0x15
	ldr r0, _0215C27C // =aExtraExBb_5
	sub r2, r1, #0x16
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _0215C278 // =0x021761CC
	mov r0, r0, lsr #8
	str r0, [r1, #0x58]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0215C278 // =0x021761CC
	mov r0, r5
	str r1, [r2, #0x4c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x3c
	bl LoadExSystemFile
	ldr r1, _0215C278 // =0x021761CC
	mov r2, #0
	str r0, [r1, #0x90]
	mov r0, #0x3d
	str r2, [r1, #0x80]
	bl LoadExSystemFile
	ldr r1, _0215C278 // =0x021761CC
	mov r2, #1
	str r0, [r1, #0x94]
	mov r0, #0x3e
	str r2, [r1, #0x84]
	bl LoadExSystemFile
	ldr r1, _0215C278 // =0x021761CC
	mov r2, #3
	str r0, [r1, #0x98]
	mov r0, #0x3f
	str r2, [r1, #0x88]
	bl LoadExSystemFile
	ldr r1, _0215C278 // =0x021761CC
	mov r2, #4
	str r0, [r1, #0x9c]
	str r2, [r1, #0x8c]
	ldr r0, [r1, #0x4c]
	bl Asset3DSetup__Create
_0215C14C:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215C278 // =0x021761CC
	str r2, [sp]
	ldr r1, [r0, #0x4c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _0215C280 // =0x0217624C
	ldr r5, _0215C284 // =0x0217625C
	mov r7, r8
_0215C184:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #4
	blo _0215C184
	ldr r1, _0215C278 // =0x021761CC
	add r0, r4, #0x300
	ldr r2, [r1, #0x80]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x80]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215C1D8:
	mov r0, r2, lsl r3
	tst r0, #0x1b
	beq _0215C1F8
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215C1F8:
	add r3, r3, #1
	cmp r3, #5
	blo _0215C1D8
	mov ip, #0
	ldr r0, _0215C288 // =0x0000019A
	str ip, [r4, #0x358]
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _0215C28C // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _0215C290 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #2]
	mov r1, #0x29
	add r2, r4, #0x350
	bic r3, r3, #1
	orr r3, r3, #1
	strb r3, [r4, #2]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str ip, [r4, #0x14]
	ldr r1, _0215C278 // =0x021761CC
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #2]
	add r2, r2, #1
	strh r2, [r1, #2]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215C278: .word 0x021761CC
_0215C27C: .word aExtraExBb_5
_0215C280: .word 0x0217624C
_0215C284: .word 0x0217625C
_0215C288: .word 0x0000019A
_0215C28C: .word 0x0000BFF4
_0215C290: .word 0x00007FF8
	arm_func_end exBossMeteBombTask__Func_215C00C

	arm_func_start exBossMeteBombTask__Func_215C294
exBossMeteBombTask__Func_215C294: // 0x0215C294
	stmdb sp!, {r4, lr}
	ldr r1, _0215C348 // =0x021761CC
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bgt _0215C32C
	ldr r0, [r1, #0x4c]
	cmp r0, #0
	beq _0215C2BC
	bl NNS_G3dResDefaultRelease
_0215C2BC:
	ldr r0, _0215C348 // =0x021761CC
	ldr r0, [r0, #0x90]
	cmp r0, #0
	beq _0215C2D0
	bl NNS_G3dResDefaultRelease
_0215C2D0:
	ldr r0, _0215C348 // =0x021761CC
	ldr r0, [r0, #0x94]
	cmp r0, #0
	beq _0215C2E4
	bl NNS_G3dResDefaultRelease
_0215C2E4:
	ldr r0, _0215C348 // =0x021761CC
	ldr r0, [r0, #0x98]
	cmp r0, #0
	beq _0215C2F8
	bl NNS_G3dResDefaultRelease
_0215C2F8:
	ldr r0, _0215C348 // =0x021761CC
	ldr r0, [r0, #0x9c]
	cmp r0, #0
	beq _0215C30C
	bl NNS_G3dResDefaultRelease
_0215C30C:
	ldr r0, _0215C348 // =0x021761CC
	ldr r0, [r0, #0x4c]
	cmp r0, #0
	beq _0215C320
	bl _FreeHEAP_USER
_0215C320:
	ldr r0, _0215C348 // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x4c]
_0215C32C:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _0215C348 // =0x021761CC
	ldrsh r1, [r0, #2]
	sub r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C348: .word 0x021761CC
	arm_func_end exBossMeteBombTask__Func_215C294

	arm_func_start exBossMeteBombTask__Main
exBossMeteBombTask__Main: // 0x0215C34C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0215C464 // =0x021761CC
	str r0, [r1, #0x50]
	add r0, r4, #0x34
	bl exBossMeteBombTask__Func_215C00C
	add r0, r4, #0x3c0
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x3c0
	bl exDrawReqTask__Func_21641F0
	ldr r1, [r4, #4]
	mov r0, #0
	str r1, [r4, #0x384]
	ldr r1, [r4, #8]
	ldr r6, _0215C468 // =_mt_math_rand
	str r1, [r4, #0x388]
	str r0, [r4, #0x38c]
	ldr r1, [r6, #0]
	ldr r3, _0215C46C // =0x00196225
	ldr ip, _0215C470 // =0x3C6EF35F
	ldr r5, _0215C474 // =0x55555556
	mla r2, r1, r3, ip
	str r2, [r6]
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #31
	add r1, r2, r1, ror #31
	add r1, r1, #1
	strh r1, [r4, #0x2a]
	ldr r1, [r6, #0]
	mov lr, #3
	mla r2, r1, r3, ip
	str r2, [r6]
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	smull r2, r6, r5, r3
	add r6, r6, r3, lsr #31
	smull r2, r3, lr, r6
	rsb r6, r2, r1, lsr #16
	add r1, r6, #5
	strh r1, [r4, #0x30]
	rsb r1, lr, #0x7d0
	mov r2, #0x66
	str r2, [r4, #0x10]
	str r2, [r4, #0x14]
	str r2, [r4, #0x18]
	str r1, [r4, #0x1c]
	str r1, [r4, #0x20]
	str r0, [r4, #0x24]
	mov r1, #0x78
	strh r1, [r4]
	str r0, [sp]
	mov r1, #0xc2
	str r1, [sp, #4]
	sub r1, r1, #0xc3
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0215C478 // =exBossMeteBombTask__Main_215C4C8
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215C464: .word 0x021761CC
_0215C468: .word _mt_math_rand
_0215C46C: .word 0x00196225
_0215C470: .word 0x3C6EF35F
_0215C474: .word 0x55555556
_0215C478: .word exBossMeteBombTask__Main_215C4C8
	arm_func_end exBossMeteBombTask__Main

	arm_func_start exBossMeteBombTask__Func8
exBossMeteBombTask__Func8: // 0x0215C47C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215C4A0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215C4A0: .word ExTask_State_Destroy
	arm_func_end exBossMeteBombTask__Func8

	arm_func_start exBossMeteBombTask__Destructor
exBossMeteBombTask__Destructor: // 0x0215C4A4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x34
	bl exBossMeteBombTask__Func_215C294
	ldr r0, _0215C4C4 // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x50]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215C4C4: .word 0x021761CC
	arm_func_end exBossMeteBombTask__Destructor

	arm_func_start exBossMeteBombTask__Main_215C4C8
exBossMeteBombTask__Main_215C4C8: // 0x0215C4C8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x34
	bl exDrawReqTask__Model__Animate
	mov r0, #0xf
	bl exDrawReqTask__Func_2164288
	ldr r2, [r4, #0x39c]
	ldr r1, [r4, #0x10]
	add r0, r4, #0x34
	add r1, r2, r1
	str r1, [r4, #0x39c]
	ldr r2, [r4, #0x3a0]
	ldr r1, [r4, #0x14]
	add r1, r2, r1
	str r1, [r4, #0x3a0]
	ldr r2, [r4, #0x3a4]
	ldr r1, [r4, #0x18]
	add r1, r2, r1
	str r1, [r4, #0x3a4]
	ldr r2, [r4, #0x40]
	ldr r1, [r4, #0x1c]
	add r1, r2, r1
	str r1, [r4, #0x40]
	ldr r2, [r4, #0x44]
	ldr r1, [r4, #0x20]
	add r1, r2, r1
	str r1, [r4, #0x44]
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215C554
	bl GetExTaskCurrent
	ldr r1, _0215C578 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215C554:
	add r0, r4, #0x34
	add r1, r4, #0x3c0
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x34
	bl exHitCheckTask__AddHitCheck
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C578: .word ExTask_State_Destroy
	arm_func_end exBossMeteBombTask__Main_215C4C8

	arm_func_start exBossMeteBombTask__Create
exBossMeteBombTask__Create: // 0x0215C57C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r5, #0
	mov r4, r0
	str r5, [sp]
	mov r1, #0x510
	str r1, [sp, #4]
	ldr r0, _0215C604 // =aExbossmetebomb
	ldr r1, _0215C608 // =exBossMeteBombTask__Destructor
	str r0, [sp, #8]
	ldr r0, _0215C60C // =exBossMeteBombTask__Main
	mov r2, #0x3100
	mov r3, #5
	str r5, [sp, #0xc]
	bl ExTaskCreate_
	mov r6, r0
	bl GetExTaskWork_
	mov r1, r5
	mov r2, #0x510
	mov r5, r0
	bl MI_CpuFill8
	ldr r1, [r4, #0]
	mov r0, r6
	str r1, [r5, #4]
	ldr r1, [r4, #4]
	str r1, [r5, #8]
	ldr r1, [r4, #8]
	str r1, [r5, #0xc]
	bl GetExTask
	ldr r1, _0215C610 // =exBossMeteBombTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215C604: .word aExbossmetebomb
_0215C608: .word exBossMeteBombTask__Destructor
_0215C60C: .word exBossMeteBombTask__Main
_0215C610: .word exBossMeteBombTask__Func8
	arm_func_end exBossMeteBombTask__Create

	arm_func_start exBossMeteLockOnTask__Func_215C614
exBossMeteLockOnTask__Func_215C614: // 0x0215C614
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _0215C85C // =0x021761CC
	mov r4, r0
	str r4, [r1, #0x44]
	ldr r0, [r1, #0x3c]
	cmp r0, #0
	ldrne r0, [r1, #0x30]
	cmpne r0, #0
	beq _0215C690
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0215C85C // =0x021761CC
	ldr r1, [r1, #0x3c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0215C85C // =0x021761CC
	ldr r1, [r1, #0x30]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0215C85C // =0x021761CC
	ldr r1, [r1, #0x3c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_0215C690:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _0215C85C // =0x021761CC
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _0215C724
	mov r1, #0x16
	ldr r0, _0215C860 // =aExtraExBb_5
	sub r2, r1, #0x17
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _0215C85C // =0x021761CC
	mov r0, r0, lsr #8
	str r0, [r1, #0x3c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0215C85C // =0x021761CC
	mov r0, r5
	str r1, [r2, #0x48]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x40
	bl LoadExSystemFile
	ldr r1, _0215C85C // =0x021761CC
	mov r2, #0
	str r0, [r1, #0x68]
	mov r0, #0x42
	str r2, [r1, #0x5c]
	bl LoadExSystemFile
	ldr r1, _0215C85C // =0x021761CC
	mov r2, #3
	str r0, [r1, #0x6c]
	str r2, [r1, #0x60]
	ldr r0, [r1, #0x48]
	bl Asset3DSetup__Create
_0215C724:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215C85C // =0x021761CC
	str r2, [sp]
	ldr r1, [r0, #0x48]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _0215C864 // =0x02176228
	ldr r5, _0215C868 // =0x02176234
	mov r7, r8
_0215C75C:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #2
	blo _0215C75C
	ldr r1, _0215C85C // =0x021761CC
	add r0, r4, #0x300
	ldr r2, [r1, #0x5c]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x5c]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215C7B0:
	mov r0, r2, lsl r3
	tst r0, #9
	beq _0215C7D0
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215C7D0:
	add r3, r3, #1
	cmp r3, #5
	blo _0215C7B0
	mov r0, #0x41000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _0215C86C // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _0215C870 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r3, #0
	strb r3, [r4]
	ldrb r2, [r4, #1]
	add r0, r4, #0x350
	ldr r1, _0215C85C // =0x021761CC
	orr r2, r2, #0x40
	strb r2, [r4, #1]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r0, [r4, #0x18]
	ldrb r2, [r4, #0x38c]
	mov r0, #1
	bic r2, r2, #3
	orr r2, r2, #1
	strb r2, [r4, #0x38c]
	ldrsh r2, [r1, #0]
	add r2, r2, #1
	strh r2, [r1]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215C85C: .word 0x021761CC
_0215C860: .word aExtraExBb_5
_0215C864: .word 0x02176228
_0215C868: .word 0x02176234
_0215C86C: .word 0x0000BFF4
_0215C870: .word 0x00007FF8
	arm_func_end exBossMeteLockOnTask__Func_215C614

	arm_func_start exBossMeteLockOnTask__Func_215C874
exBossMeteLockOnTask__Func_215C874: // 0x0215C874
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, #0
	ldr r7, _0215C914 // =0x02176228
	ldr r6, _0215C918 // =0x02176234
	mov r5, r0
	mov r4, r1
	mov r8, r9
_0215C890:
	str r8, [sp]
	ldr r1, [r7, r9, lsl #2]
	ldr r2, [r6, r9, lsl #2]
	mov r3, r4
	add r0, r5, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #2
	blo _0215C890
	ldr r1, _0215C91C // =0x021761CC
	add r0, r5, #0x300
	ldr r2, [r1, #0x5c]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x5c]
	mov r2, #1
	add r0, r5, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r5, #0x344]
_0215C8E4:
	mov r0, r2, lsl r3
	tst r0, #9
	beq _0215C904
	add r0, r5, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215C904:
	add r3, r3, #1
	cmp r3, #5
	blo _0215C8E4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0215C914: .word 0x02176228
_0215C918: .word 0x02176234
_0215C91C: .word 0x021761CC
	arm_func_end exBossMeteLockOnTask__Func_215C874

	arm_func_start exBossMeteLockOnTask__Destroy_215C920
exBossMeteLockOnTask__Destroy_215C920: // 0x0215C920
	stmdb sp!, {r4, lr}
	ldr r1, _0215C9AC // =0x021761CC
	mov r4, r0
	ldrsh r0, [r1, #0]
	cmp r0, #1
	bgt _0215C990
	ldr r0, [r1, #0x48]
	cmp r0, #0
	beq _0215C948
	bl NNS_G3dResDefaultRelease
_0215C948:
	ldr r0, _0215C9AC // =0x021761CC
	ldr r0, [r0, #0x68]
	cmp r0, #0
	beq _0215C95C
	bl NNS_G3dResDefaultRelease
_0215C95C:
	ldr r0, _0215C9AC // =0x021761CC
	ldr r0, [r0, #0x6c]
	cmp r0, #0
	beq _0215C970
	bl NNS_G3dResDefaultRelease
_0215C970:
	ldr r0, _0215C9AC // =0x021761CC
	ldr r0, [r0, #0x48]
	cmp r0, #0
	beq _0215C984
	bl _FreeHEAP_USER
_0215C984:
	ldr r0, _0215C9AC // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x48]
_0215C990:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _0215C9AC // =0x021761CC
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215C9AC: .word 0x021761CC
	arm_func_end exBossMeteLockOnTask__Destroy_215C920

	arm_func_start exBossMeteLockOnTask__Main
exBossMeteLockOnTask__Main: // 0x0215C9B0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0215CA40 // =0x021761CC
	mov r2, #0
	str r0, [r1, #0x34]
	add r0, r4, #0x10
	str r2, [r4, #4]
	bl exBossMeteLockOnTask__Func_215C614
	add r0, r4, #0x39c
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x10
	mov r1, #1
	bl exBossMeteLockOnTask__Func_215C874
	add r0, r4, #0x39c
	bl exDrawReqTask__Func_2164218
	ldr r0, [r4, #0x4ec]
	mov r2, #0x41000
	ldr r0, [r0, #0x3bc]
	mov r1, #0x10000
	str r0, [r4, #0x360]
	ldr r3, [r4, #0x4ec]
	mov r0, #0
	ldr r3, [r3, #0x3c0]
	str r3, [r4, #0x364]
	str r2, [r4, #0x368]
	str r1, [r4, #0x378]
	str r1, [r4, #0x37c]
	str r1, [r4, #0x380]
	strh r0, [r4, #8]
	bl GetExTaskCurrent
	ldr r1, _0215CA44 // =exBossMeteLockOnTask__Func_215CA94
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CA40: .word 0x021761CC
_0215CA44: .word exBossMeteLockOnTask__Func_215CA94
	arm_func_end exBossMeteLockOnTask__Main

	arm_func_start exBossMeteLockOnTask__Func8
exBossMeteLockOnTask__Func8: // 0x0215CA48
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215CA6C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215CA6C: .word ExTask_State_Destroy
	arm_func_end exBossMeteLockOnTask__Func8

	arm_func_start exBossMeteLockOnTask__Destructor
exBossMeteLockOnTask__Destructor: // 0x0215CA70
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0x10
	bl exBossMeteLockOnTask__Destroy_215C920
	ldr r0, _0215CA90 // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x34]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215CA90: .word 0x021761CC
	arm_func_end exBossMeteLockOnTask__Destructor

	arm_func_start exBossMeteLockOnTask__Func_215CA94
exBossMeteLockOnTask__Func_215CA94: // 0x0215CA94
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl exDrawReqTask__Model__Animate
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215CABC
	bl exBossMeteLockOnTask__Func_215CFB4
	ldmia sp!, {r4, pc}
_0215CABC:
	bl GetExPlayerPosition
	ldr r0, [r0, #0]
	str r0, [r4, #0x360]
	bl GetExPlayerPosition
	ldr r1, [r0, #4]
	ldr r0, _0215CBD8 // =0x021761CC
	str r1, [r4, #0x364]
	ldr r1, [r0, #0x7c]
	mov r0, #0xf800
	add r1, r1, #0x5000
	str r1, [r4, #0x368]
	ldrsh r2, [r4, #8]
	rsb r0, r0, #0
	mvn r1, #0
	add r2, r2, #0x200
	strh r2, [r4, #8]
	ldrsh r3, [r4, #8]
	mov r2, #0
	umull lr, ip, r3, r0
	adds lr, lr, #0x800
	mla ip, r3, r1, ip
	mov r3, r3, asr #0x1f
	mla ip, r3, r0, ip
	adc r3, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	add r3, ip, #0x10000
	str r3, [r4, #0x378]
	ldrsh r3, [r4, #8]
	umull lr, ip, r3, r0
	adds lr, lr, #0x800
	mla ip, r3, r1, ip
	mov r3, r3, asr #0x1f
	mla ip, r3, r0, ip
	adc r3, ip, #0
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	add r3, ip, #0x10000
	str r3, [r4, #0x37c]
	ldrsh r3, [r4, #8]
	umull lr, ip, r3, r0
	mla ip, r3, r1, ip
	mov r1, r3, asr #0x1f
	mla ip, r1, r0, ip
	adds r1, lr, #0x800
	adc r0, ip, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x10000
	str r0, [r4, #0x380]
	ldrsh r0, [r4, #8]
	cmp r0, #0x1000
	blt _0215CBBC
	mov r0, #0x8000
	str r0, [r4, #0x378]
	str r0, [r4, #0x37c]
	str r0, [r4, #0x380]
	strh r2, [r4, #8]
	bl GetExTaskCurrent
	ldr r2, _0215CBDC // =exBossMeteLockOnTask__Func_215CBE0
	add r1, r4, #0x39c
	str r2, [r0]
	add r0, r4, #0x10
	bl exDrawReqTask__AddRequest
_0215CBBC:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CBD8: .word 0x021761CC
_0215CBDC: .word exBossMeteLockOnTask__Func_215CBE0
	arm_func_end exBossMeteLockOnTask__Func_215CA94

	arm_func_start exBossMeteLockOnTask__Func_215CBE0
exBossMeteLockOnTask__Func_215CBE0: // 0x0215CBE0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl exDrawReqTask__Model__Animate
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215CC08
	bl exBossMeteLockOnTask__Func_215CFB4
	ldmia sp!, {r4, pc}
_0215CC08:
	bl GetExPlayerPosition
	ldr r0, [r0, #0]
	str r0, [r4, #0x360]
	bl GetExPlayerPosition
	ldr r1, [r0, #4]
	ldr r0, _0215CD00 // =0x021761CC
	str r1, [r4, #0x364]
	ldr r0, [r0, #0x7c]
	mov r1, #0x7000
	add r0, r0, #0x5000
	str r0, [r4, #0x368]
	ldrsh r0, [r4, #8]
	rsb r1, r1, #0
	mvn r2, #0
	add r0, r0, #0x99
	add r0, r0, #0x100
	strh r0, [r4, #8]
	ldrsh r0, [r4, #8]
	umull ip, r3, r0, r1
	adds ip, ip, #0x800
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adc r0, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r0, lsl #20
	add r0, r3, #0x8000
	str r0, [r4, #0x378]
	ldrsh r0, [r4, #8]
	umull ip, r3, r0, r1
	adds ip, ip, #0x800
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adc r0, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r0, lsl #20
	add r0, r3, #0x8000
	str r0, [r4, #0x37c]
	ldrsh r0, [r4, #8]
	umull ip, r3, r0, r1
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	adds r1, ip, #0x800
	adc r0, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0x8000
	str r0, [r4, #0x380]
	ldrsh r0, [r4, #8]
	cmp r0, #0x1000
	blt _0215CCE4
	bl exBossMeteLockOnTask__Func_215CD04
	ldmia sp!, {r4, pc}
_0215CCE4:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CD00: .word 0x021761CC
	arm_func_end exBossMeteLockOnTask__Func_215CBE0

	arm_func_start exBossMeteLockOnTask__Func_215CD04
exBossMeteLockOnTask__Func_215CD04: // 0x0215CD04
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #0x1000
	str r1, [r0, #0x378]
	str r1, [r0, #0x37c]
	str r1, [r0, #0x380]
	mov r1, #0xa
	strh r1, [r0]
	bl GetExTaskCurrent
	ldr r1, _0215CD38 // =exBossMeteLockOnTask__Func_215CD3C
	str r1, [r0]
	bl exBossMeteLockOnTask__Func_215CD3C
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215CD38: .word exBossMeteLockOnTask__Func_215CD3C
	arm_func_end exBossMeteLockOnTask__Func_215CD04

	arm_func_start exBossMeteLockOnTask__Func_215CD3C
exBossMeteLockOnTask__Func_215CD3C: // 0x0215CD3C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl exDrawReqTask__Model__Animate
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215CD64
	bl exBossMeteLockOnTask__Func_215CFB4
	ldmia sp!, {r4, pc}
_0215CD64:
	ldrsh r0, [r4, #0]
	cmp r0, #0
	ble _0215CDF8
	bl GetExPlayerPosition
	ldr r1, [r0, #0]
	ldr lr, [r4, #0x360]
	ldr r0, _0215CED4 // =0x00000666
	sub r2, r1, lr
	umull ip, r3, r2, r0
	mov r1, #0
	adds ip, ip, #0x800
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, lr, r1
	str r0, [r4, #0x360]
	bl GetExPlayerPosition
	ldr r1, [r0, #4]
	ldr lr, [r4, #0x364]
	ldr r0, _0215CED4 // =0x00000666
	sub r2, r1, lr
	umull ip, r3, r2, r0
	mov r1, #0
	adds ip, ip, #0x800
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, lr, r1
	str r0, [r4, #0x364]
	mov r0, #0x41000
	str r0, [r4, #0x368]
_0215CDF8:
	ldrsh r1, [r4, #0]
	mvn r0, #0x16
	cmp r1, r0
	movlt r0, #0xa
	blt _0215CE9C
	bl GetExPlayerPosition
	ldr r0, [r0, #0]
	ldr lr, [r4, #0x360]
	mov r1, #0
	sub r2, r0, lr
	mov r0, #0xa4
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds ip, ip, #0x800
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, lr, r1
	str r0, [r4, #0x360]
	bl GetExPlayerPosition
	ldr r0, [r0, #4]
	ldr lr, [r4, #0x364]
	mov r1, #0
	sub r2, r0, lr
	mov r0, #0xa4
	umull ip, r3, r2, r0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adds ip, ip, #0x800
	adc r0, r3, #0
	mov r1, ip, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, lr, r1
	str r0, [r4, #0x364]
	mov r0, #0x41000
	str r0, [r4, #0x368]
	ldrsh r0, [r4, #0]
	sub r0, r0, #1
_0215CE9C:
	strh r0, [r4]
	ldr r0, [r4, #0x4ec]
	ldrsh r0, [r0, #0x56]
	cmp r0, #0xa
	bgt _0215CEB8
	bl exBossMeteLockOnTask__Func_215CED8
	ldmia sp!, {r4, pc}
_0215CEB8:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215CED4: .word 0x00000666
	arm_func_end exBossMeteLockOnTask__Func_215CD3C

	arm_func_start exBossMeteLockOnTask__Func_215CED8
exBossMeteLockOnTask__Func_215CED8: // 0x0215CED8
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	mov r1, #2
	ldr r5, [r4, #0xc4]
	bl exBossMeteLockOnTask__Func_215C874
	add r0, r4, #0x39c
	bl exDrawReqTask__Func_21641F0
	ldr r1, [r4, #0x360]
	ldr r2, _0215CF38 // =0x021761CC
	mov r0, r5
	str r1, [r2, #0x74]
	ldr r3, [r4, #0x364]
	mov r1, #0x1f
	str r3, [r2, #0x78]
	ldr r3, [r4, #0x368]
	str r3, [r2, #0x7c]
	bl NNS_G3dMdlSetMdlDiffAll
	bl GetExTaskCurrent
	ldr r1, _0215CF3C // =exBossMeteLockOnTask__Func_215CF40
	str r1, [r0]
	bl exBossMeteLockOnTask__Func_215CF40
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215CF38: .word 0x021761CC
_0215CF3C: .word exBossMeteLockOnTask__Func_215CF40
	arm_func_end exBossMeteLockOnTask__Func_215CED8

	arm_func_start exBossMeteLockOnTask__Func_215CF40
exBossMeteLockOnTask__Func_215CF40: // 0x0215CF40
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0x354]
	ldr r0, [r0, #0]
	cmp r0, #0xa000
	bge _0215CF68
	add r0, r4, #0x10
	bl exDrawReqTask__Model__Animate
	b _0215CF70
_0215CF68:
	add r0, r4, #0x39c
	bl exDrawReqTask__Func_2164238
_0215CF70:
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0215CF84
	bl exBossMeteLockOnTask__Func_215CFB4
	ldmia sp!, {r4, pc}
_0215CF84:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215CF98
	bl exBossMeteLockOnTask__Func_215CFB4
	ldmia sp!, {r4, pc}
_0215CF98:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exBossMeteLockOnTask__Func_215CF40

	arm_func_start exBossMeteLockOnTask__Func_215CFB4
exBossMeteLockOnTask__Func_215CFB4: // 0x0215CFB4
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	ldr r5, [r4, #0xc4]
	mov r1, #3
	bl exBossMeteLockOnTask__Func_215C874
	add r0, r4, #0x39c
	bl exDrawReqTask__Func_21641F0
	mov r0, r5
	mov r1, #0x7c00
	bl NNS_G3dMdlSetMdlDiffAll
	bl GetExTaskCurrent
	ldr r1, _0215D004 // =exBossMeteLockOnTask__Func_215D008
	str r1, [r0]
	bl exBossMeteLockOnTask__Func_215D008
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215D004: .word exBossMeteLockOnTask__Func_215D008
	arm_func_end exBossMeteLockOnTask__Func_215CFB4

	arm_func_start exBossMeteLockOnTask__Func_215D008
exBossMeteLockOnTask__Func_215D008: // 0x0215D008
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x10
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x10
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215D03C
	bl GetExTaskCurrent
	ldr r1, _0215D058 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215D03C:
	add r0, r4, #0x10
	add r1, r4, #0x39c
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D058: .word ExTask_State_Destroy
	arm_func_end exBossMeteLockOnTask__Func_215D008

	arm_func_start exBossMeteLockOnTask__Create
exBossMeteLockOnTask__Create: // 0x0215D05C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #0x4f0
	ldr r0, _0215D0DC // =aExbossmetelock
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215D0E0 // =exBossMeteLockOnTask__Main
	ldr r1, _0215D0E4 // =exBossMeteLockOnTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x4f0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x4ec]
	mov r0, r5
	bl GetExTask
	ldr r1, _0215D0E8 // =exBossMeteLockOnTask__Func8
	str r1, [r0, #8]
	ldr r1, [r4, #0x4ec]
	mov r0, #1
	ldr r1, [r1, #0x68]
	str r4, [r1, #4]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215D0DC: .word aExbossmetelock
_0215D0E0: .word exBossMeteLockOnTask__Main
_0215D0E4: .word exBossMeteLockOnTask__Destructor
_0215D0E8: .word exBossMeteLockOnTask__Func8
	arm_func_end exBossMeteLockOnTask__Create

	arm_func_start exBossMeteMeteoTask__Func_215D0EC
exBossMeteMeteoTask__Func_215D0EC: // 0x0215D0EC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0215D2D8 // =0x021761CC
	mov r4, r0
	str r4, [r1, #0x28]
	ldr r0, [r1, #0x20]
	cmp r0, #0
	ldrne r0, [r1, #0x1c]
	cmpne r0, #0
	beq _0215D158
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _0215D2D8 // =0x021761CC
	ldr r1, [r1, #0x20]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _0215D2D8 // =0x021761CC
	ldr r1, [r1, #0x1c]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _0215D2D8 // =0x021761CC
	ldr r1, [r1, #0x20]
	cmp r0, r1
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
_0215D158:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _0215D2D8 // =0x021761CC
	ldrsh r0, [r0, #4]
	cmp r0, #0
	bne _0215D1D4
	mov r1, #0x14
	ldr r0, _0215D2DC // =aExtraExBb_5
	sub r2, r1, #0x15
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _0215D2D8 // =0x021761CC
	mov r0, r0, lsr #8
	str r0, [r1, #0x20]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _0215D2D8 // =0x021761CC
	mov r0, r5
	str r1, [r2, #0x2c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x3b
	bl LoadExSystemFile
	ldr r1, _0215D2D8 // =0x021761CC
	mov r2, #0
	str r0, [r1, #8]
	str r2, [r1, #0x10]
	ldr r0, [r1, #0x2c]
	bl Asset3DSetup__Create
_0215D1D4:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _0215D2D8 // =0x021761CC
	str r2, [sp]
	ldr r1, [r0, #0x2c]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r3, #0
	ldr r0, _0215D2D8 // =0x021761CC
	str r3, [sp]
	ldr r1, [r0, #0x10]
	ldr r2, [r0, #8]
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	ldr r1, _0215D2D8 // =0x021761CC
	add r0, r4, #0x300
	ldr r2, [r1, #0x10]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0x10]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_0215D240:
	mov r0, r2, lsl r3
	tst r0, #1
	beq _0215D260
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_0215D260:
	add r3, r3, #1
	cmp r3, #5
	blo _0215D240
	mov r0, #0
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r1, _0215D2E0 // =0x00003FFC
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	mov r1, r1, lsl #1
	strh r1, [r0, #0x4e]
	mov r0, #1
	strb r0, [r4]
	ldrb r3, [r4, #1]
	mov r1, #0x5000
	add r2, r4, #0x350
	orr r3, r3, #0x80
	strb r3, [r4, #1]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r1, [r4, #0x14]
	ldr r1, _0215D2D8 // =0x021761CC
	str r2, [r4, #0x18]
	ldrsh r2, [r1, #4]
	add r2, r2, #1
	strh r2, [r1, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215D2D8: .word 0x021761CC
_0215D2DC: .word aExtraExBb_5
_0215D2E0: .word 0x00003FFC
	arm_func_end exBossMeteMeteoTask__Func_215D0EC

	arm_func_start exBossMeteMeteoTask__Destroy_215D2E4
exBossMeteMeteoTask__Destroy_215D2E4: // 0x0215D2E4
	stmdb sp!, {r4, lr}
	ldr r1, _0215D35C // =0x021761CC
	mov r4, r0
	ldrsh r0, [r1, #4]
	cmp r0, #1
	bgt _0215D340
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	beq _0215D30C
	bl NNS_G3dResDefaultRelease
_0215D30C:
	ldr r0, _0215D35C // =0x021761CC
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _0215D320
	bl NNS_G3dResDefaultRelease
_0215D320:
	ldr r0, _0215D35C // =0x021761CC
	ldr r0, [r0, #0x2c]
	cmp r0, #0
	beq _0215D334
	bl _FreeHEAP_USER
_0215D334:
	ldr r0, _0215D35C // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x2c]
_0215D340:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _0215D35C // =0x021761CC
	ldrsh r1, [r0, #4]
	sub r1, r1, #1
	strh r1, [r0, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D35C: .word 0x021761CC
	arm_func_end exBossMeteMeteoTask__Destroy_215D2E4

	arm_func_start exBossMeteMeteoTask__Main
exBossMeteMeteoTask__Main: // 0x0215D360
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0215D4D0 // =0x021761CC
	str r0, [r1, #0x18]
	add r0, r4, #0x88
	bl exBossMeteMeteoTask__Func_215D0EC
	add r0, r4, #0x14
	add r0, r0, #0x400
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x14
	add r0, r0, #0x400
	bl exDrawReqTask__Func_2164218
	ldr r1, [r4, #0x564]
	ldr r0, _0215D4D4 // =0x000435A1
	ldr r1, [r1, #0x3ec]
	ldr r5, _0215D4D0 // =0x021761CC
	str r1, [r4, #0x3d8]
	ldr r1, [r4, #0x564]
	mov lr, #0x3c000
	ldr r1, [r1, #0x3f0]
	mov ip, #0x3f800000
	str r1, [r4, #0x3dc]
	str r0, [r4, #0x3e0]
	ldr r1, [r4, #0x3d8]
	add r0, r4, #0x168
	str r1, [r4, #0x40]
	add r0, r0, #0x400
	ldr r2, [r4, #0x3dc]
	add r1, r4, #0x40
	str r2, [r4, #0x44]
	ldr r3, [r4, #0x3e0]
	add r2, r4, #0x4c
	str r3, [r4, #0x48]
	ldr r6, [r5, #0x74]
	ldr r3, _0215D4D8 // =0x3A4CCCCD
	str r6, [r4, #0x4c]
	ldr r5, [r5, #0x78]
	str r5, [r4, #0x50]
	str lr, [r4, #0x54]
	str ip, [sp]
	bl exPlayerHelpers__Func_2152FB0
	mov r1, #1
	strh r1, [r4, #0x28]
	ldr r5, _0215D4DC // =_mt_math_rand
	ldr ip, _0215D4E0 // =0x00196225
	ldr r2, [r5, #0]
	ldr lr, _0215D4E4 // =0x3C6EF35F
	mov r0, #0
	mla r3, r2, ip, lr
	str r3, [r5]
	mov r2, r3, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	mov r3, r2, lsr #0x1f
	rsb r2, r3, r2, lsl #31
	add r2, r3, r2, ror #31
	add r2, r2, #1
	strh r2, [r4, #0x2a]
	strh r1, [r4, #0x2e]
	strh r0, [r4, #0x34]
	ldr r1, [r5, #0]
	ldr r3, _0215D4E8 // =0x55555556
	mla r2, r1, ip, lr
	str r2, [r5]
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r5, r1, lsr #0x10
	smull r2, lr, r3, r5
	add lr, lr, r5, lsr #31
	mov ip, #3
	smull r2, r3, ip, lr
	rsb lr, r2, r1, lsr #16
	add r1, lr, #3
	strh r1, [r4, #0x30]
	str r0, [sp]
	mov r1, #0xc0
	str r1, [sp, #4]
	sub r1, r1, #0xc1
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	mov r0, #0
	str r0, [r4, #0x3c]
	bl GetExTaskCurrent
	ldr r1, _0215D4EC // =exBossMeteMeteoTask__Func_215D544
	str r1, [r0]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215D4D0: .word 0x021761CC
_0215D4D4: .word 0x000435A1
_0215D4D8: .word 0x3A4CCCCD
_0215D4DC: .word _mt_math_rand
_0215D4E0: .word 0x00196225
_0215D4E4: .word 0x3C6EF35F
_0215D4E8: .word 0x55555556
_0215D4EC: .word exBossMeteMeteoTask__Func_215D544
	arm_func_end exBossMeteMeteoTask__Main

	arm_func_start exBossMeteMeteoTask__Func8
exBossMeteMeteoTask__Func8: // 0x0215D4F0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215D514 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D514: .word ExTask_State_Destroy
	arm_func_end exBossMeteMeteoTask__Func8

	arm_func_start exBossMeteMeteoTask__Destructor
exBossMeteMeteoTask__Destructor: // 0x0215D518
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r1, #1
	str r1, [r0, #0x3c]
	add r0, r0, #0x88
	bl exBossMeteMeteoTask__Destroy_215D2E4
	ldr r0, _0215D540 // =0x021761CC
	mov r1, #0
	str r1, [r0, #0x18]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D540: .word 0x021761CC
	arm_func_end exBossMeteMeteoTask__Destructor

	arm_func_start exBossMeteMeteoTask__Func_215D544
exBossMeteMeteoTask__Func_215D544: // 0x0215D544
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x88
	bl exDrawReqTask__Model__Animate
	ldrb r0, [r4, #0x8e]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0215D57C
	ldrb r0, [r4, #0x88]
	cmp r0, #2
	bne _0215D57C
	bl exBossMeteMeteoTask__Func_215D794
	ldmia sp!, {r4, pc}
_0215D57C:
	add r0, r4, #0x168
	add r0, r0, #0x400
	add r1, r4, #0x3d8
	mov r2, #1
	bl exPlayerHelpers__Func_21530FC
	cmp r0, #0
	beq _0215D5AC
	ldr r0, [r4, #0x3e0]
	cmp r0, #0x3c000
	bgt _0215D5AC
	bl exBossMeteMeteoTask__Func_215D660
	ldmia sp!, {r4, pc}
_0215D5AC:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215D5D0
	add r0, r4, #0x3d8
	bl CreateExExplosion
	bl GetExTaskCurrent
	ldr r1, _0215D65C // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215D5D0:
	ldr r0, [r4, #0x57c]
	ldr r1, [r4, #0x578]
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0xd2]
	ldr r0, [r4, #0x574]
	ldr r1, [r4, #0x578]
	bl exPlayerHelpers__Func_2152E28
	add r1, r4, #0x300
	strh r0, [r1, #0xd6]
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _0215D618
	add r0, r4, #0x34
	add r1, r4, #0x28
	add r2, r4, #0x2e
	mov r3, #0
	bl exPlayerHelpers__Func_2152D28
_0215D618:
	add r1, r4, #0x300
	ldrh ip, [r1, #0xd2]
	ldrh r3, [r4, #0x34]
	add r2, r4, #0x14
	add r0, r4, #0x88
	add r3, ip, r3
	strh r3, [r1, #0xd2]
	ldrb r3, [r4, #0x414]
	add r1, r2, #0x400
	bic r2, r3, #0xf0
	orr r2, r2, #0xa0
	strb r2, [r4, #0x414]
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D65C: .word ExTask_State_Destroy
	arm_func_end exBossMeteMeteoTask__Func_215D544

	arm_func_start exBossMeteMeteoTask__Func_215D660
exBossMeteMeteoTask__Func_215D660: // 0x0215D660
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _0215D6A0 // =0x021761CC
	mov r3, #0x3c000
	ldr ip, [r1, #0x74]
	mov r2, #3
	str ip, [r0, #0x3d8]
	ldr r1, [r1, #0x78]
	str r1, [r0, #0x3dc]
	str r3, [r0, #0x3e0]
	strh r2, [r0]
	bl GetExTaskCurrent
	ldr r1, _0215D6A4 // =exBossMeteMeteoTask__Func_215D6A8
	str r1, [r0]
	bl exBossMeteMeteoTask__Func_215D6A8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215D6A0: .word 0x021761CC
_0215D6A4: .word exBossMeteMeteoTask__Func_215D6A8
	arm_func_end exBossMeteMeteoTask__Func_215D660

	arm_func_start exBossMeteMeteoTask__Func_215D6A8
exBossMeteMeteoTask__Func_215D6A8: // 0x0215D6A8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x88
	bl exDrawReqTask__Model__Animate
	ldrb r0, [r4, #0x8e]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0215D6E8
	ldrb r0, [r4, #0x88]
	cmp r0, #2
	bne _0215D6E8
	bl exBossMeteMeteoTask__Func_215D794
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215D6E8:
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _0215D710
	add r0, r4, #0x3d8
	bl CreateExExplosion
	bl GetExTaskCurrent
	ldr r1, _0215D790 // =ExTask_State_Destroy
	add sp, sp, #8
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215D710:
	ldrsh r0, [r4, #0]
	cmp r0, #0
	bgt _0215D754
	mov ip, #0xc1
	sub r1, ip, #0xc2
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	add r0, r4, #0x3d8
	bl exBossMeteBombTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215D790 // =ExTask_State_Destroy
	add sp, sp, #8
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215D754:
	ldrb r2, [r4, #0x414]
	add r1, r4, #0x14
	add r0, r4, #0x88
	bic r2, r2, #0xf0
	orr r2, r2, #0xa0
	add r1, r1, #0x400
	strb r2, [r4, #0x414]
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x88
	bl exHitCheckTask__AddHitCheck
	ldrsh r0, [r4, #0]
	sub r0, r0, #1
	strh r0, [r4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D790: .word ExTask_State_Destroy
	arm_func_end exBossMeteMeteoTask__Func_215D6A8

	arm_func_start exBossMeteMeteoTask__Func_215D794
exBossMeteMeteoTask__Func_215D794: // 0x0215D794
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldrb r1, [r4, #0x8e]
	mov r0, #0x800
	bic r1, r1, #1
	strb r1, [r4, #0x8e]
	ldrb r1, [r4, #0x8c]
	orr r1, r1, #2
	strb r1, [r4, #0x8c]
	str r0, [r4, #0x1c]
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _0215D838
	ldrsh r0, [r4, #0x90]
	ldr r2, [r4, #0x1c]
	cmp r0, #6
	bne _0215D808
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x1c]
	b _0215D8AC
_0215D808:
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
	str r1, [r4, #0x1c]
	b _0215D8AC
_0215D838:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _0215D8AC
	ldrsh r0, [r4, #0x90]
	ldr r2, [r4, #0x1c]
	cmp r0, #7
	bne _0215D880
	mov r1, r2, asr #0x1f
	mov r0, #0x800
	mov r1, r1, lsl #0xe
	adds r3, r0, r2, lsl #14
	orr r1, r1, r2, lsr #18
	adc r0, r1, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x1c]
	b _0215D8AC
_0215D880:
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
	str r1, [r4, #0x1c]
_0215D8AC:
	ldrh r2, [r4, #0x30]
	ldr r1, _0215D8E0 // =0x00001FFE
	add r0, r4, #0x300
	add r2, r2, r2, lsl #1
	strh r2, [r4, #0x30]
	strh r1, [r0, #0xd2]
	mov r0, #1
	str r0, [r4, #0x3c]
	bl GetExTaskCurrent
	ldr r1, _0215D8E4 // =exBossMeteMeteoTask__Func_215D8E8
	str r1, [r0]
	bl exBossMeteMeteoTask__Func_215D8E8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D8E0: .word 0x00001FFE
_0215D8E4: .word exBossMeteMeteoTask__Func_215D8E8
	arm_func_end exBossMeteMeteoTask__Func_215D794

	arm_func_start exBossMeteMeteoTask__Func_215D8E8
exBossMeteMeteoTask__Func_215D8E8: // 0x0215D8E8
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x88
	bl exDrawReqTask__Model__Animate
	ldr r2, [r4, #0x3dc]
	ldr r1, [r4, #0x1c]
	add r0, r4, #0xd2
	add r1, r2, r1
	str r1, [r4, #0x3dc]
	ldrb r2, [r4, #0x414]
	add r0, r0, #0x300
	add r1, r4, #0x28
	bic r2, r2, #0xf0
	orr r2, r2, #0xa0
	strb r2, [r4, #0x414]
	add r2, r4, #0x2e
	mov r3, #1
	bl exPlayerHelpers__Func_2152D28
	ldr r1, [r4, #0x3d8]
	cmp r1, #0x5a000
	bge _0215D95C
	mov r0, #0x5a000
	rsb r0, r0, #0
	cmp r1, r0
	ble _0215D95C
	ldr r0, [r4, #0x3dc]
	cmp r0, #0xc8000
	blt _0215D96C
_0215D95C:
	bl GetExTaskCurrent
	ldr r1, _0215D998 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_0215D96C:
	add r1, r4, #0x14
	add r0, r4, #0x88
	add r1, r1, #0x400
	bl exDrawReqTask__AddRequest
	ldrb r0, [r4, #0x8e]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x88
	bl exHitCheckTask__AddHitCheck
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215D998: .word ExTask_State_Destroy
	arm_func_end exBossMeteMeteoTask__Func_215D8E8

	arm_func_start exBossMeteMeteoTask__Create
exBossMeteMeteoTask__Create: // 0x0215D99C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _0215DA1C // =0x0000058C
	str r4, [sp]
	ldr r0, _0215DA20 // =aExbossmetemete
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0215DA24 // =exBossMeteMeteoTask__Main
	ldr r1, _0215DA28 // =exBossMeteMeteoTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _0215DA1C // =0x0000058C
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl GetExTaskWorkCurrent_
	str r0, [r4, #0x564]
	mov r0, r5
	bl GetExTask
	ldr r1, _0215DA2C // =exBossMeteMeteoTask__Func8
	str r1, [r0, #8]
	ldr r1, [r4, #0x564]
	mov r0, #1
	ldr r1, [r1, #0x68]
	str r4, [r1]
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0215DA1C: .word 0x0000058C
_0215DA20: .word aExbossmetemete
_0215DA24: .word exBossMeteMeteoTask__Main
_0215DA28: .word exBossMeteMeteoTask__Destructor
_0215DA2C: .word exBossMeteMeteoTask__Func8
	arm_func_end exBossMeteMeteoTask__Create

	arm_func_start exBossMeteAdminTask__Main
exBossMeteAdminTask__Main: // 0x0215DA30
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetCurrentTask
	ldr r1, _0215DA58 // =exBossMeteLockOnTask__ActiveInstanceCount
	str r0, [r1, #0x38]
	bl GetExTaskCurrent
	ldr r1, _0215DA5C // =exBossMeteAdminTask__Func_215DAA4
	str r1, [r0]
	bl exBossMeteAdminTask__Func_215DAA4
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DA58: .word exBossMeteLockOnTask__ActiveInstanceCount
_0215DA5C: .word exBossMeteAdminTask__Func_215DAA4
	arm_func_end exBossMeteAdminTask__Main

	arm_func_start exBossMeteAdminTask__Func8
exBossMeteAdminTask__Func8: // 0x0215DA60
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl CheckExStageFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0215DA84 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DA84: .word ExTask_State_Destroy
	arm_func_end exBossMeteAdminTask__Func8

	arm_func_start exBossMeteAdminTask__Destructor
exBossMeteAdminTask__Destructor: // 0x0215DA88
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _0215DAA0 // =exBossMeteLockOnTask__ActiveInstanceCount
	mov r1, #0
	str r1, [r0, #0x38]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DAA0: .word exBossMeteLockOnTask__ActiveInstanceCount
	arm_func_end exBossMeteAdminTask__Destructor

	arm_func_start exBossMeteAdminTask__Func_215DAA4
exBossMeteAdminTask__Func_215DAA4: // 0x0215DAA4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0215DAC0
	bl exBossMeteAdminTask__Func_215DAD0
	ldmia sp!, {r3, pc}
_0215DAC0:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossMeteAdminTask__Func_215DAA4

	arm_func_start exBossMeteAdminTask__Func_215DAD0
exBossMeteAdminTask__Func_215DAD0: // 0x0215DAD0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _0215DAEC // =exBossMeteAdminTask__Func_215DAF0
	str r1, [r0]
	bl exBossMeteAdminTask__Func_215DAF0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DAEC: .word exBossMeteAdminTask__Func_215DAF0
	arm_func_end exBossMeteAdminTask__Func_215DAD0

	arm_func_start exBossMeteAdminTask__Func_215DAF0
exBossMeteAdminTask__Func_215DAF0: // 0x0215DAF0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _0215DB0C
	bl exBossMeteAdminTask__Func_215DB1C
	ldmia sp!, {r3, pc}
_0215DB0C:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossMeteAdminTask__Func_215DAF0

	arm_func_start exBossMeteAdminTask__Func_215DB1C
exBossMeteAdminTask__Func_215DB1C: // 0x0215DB1C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r1, _0215DB38 // =exBossMeteAdminTask__Func_215DB3C
	str r1, [r0]
	bl exBossMeteAdminTask__Func_215DB3C
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DB38: .word exBossMeteAdminTask__Func_215DB3C
	arm_func_end exBossMeteAdminTask__Func_215DB1C

	arm_func_start exBossMeteAdminTask__Func_215DB3C
exBossMeteAdminTask__Func_215DB3C: // 0x0215DB3C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldmia r0, {r1, r2}
	ldr r0, [r1, #0x3c]
	cmp r0, #0
	beq _0215DB68
	mov r0, #1
	str r0, [r2, #4]
	bl GetExTaskCurrent
	ldr r1, _0215DB78 // =ExTask_State_Destroy
	str r1, [r0]
_0215DB68:
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DB78: .word ExTask_State_Destroy
	arm_func_end exBossMeteAdminTask__Func_215DB3C

	arm_func_start exBossMeteAdminTask__Create
exBossMeteAdminTask__Create: // 0x0215DB7C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	bl GetExTaskWorkCurrent_
	mov r5, #0
	mov r4, r0
	str r5, [sp]
	mov r1, #0xc
	str r1, [sp, #4]
	ldr r0, _0215DC04 // =aExbossmeteadmi
	ldr r1, _0215DC08 // =exBossMeteAdminTask__Destructor
	str r0, [sp, #8]
	ldr r0, _0215DC0C // =exBossMeteAdminTask__Main
	mov r2, #0x3200
	mov r3, #5
	str r5, [sp, #0xc]
	bl ExTaskCreate_
	mov r6, r0
	bl GetExTaskWork_
	mov r1, r5
	mov r2, #0xc
	mov r5, r0
	bl MI_CpuFill8
	mov r0, r6
	bl GetExTask
	ldr r2, _0215DC10 // =exBossMeteAdminTask__Func8
	mov r1, #0
	str r2, [r0, #8]
	str r5, [r4, #0x68]
	str r1, [r5]
	str r1, [r5, #4]
	str r1, [r5, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0215DC04: .word aExbossmeteadmi
_0215DC08: .word exBossMeteAdminTask__Destructor
_0215DC0C: .word exBossMeteAdminTask__Main
_0215DC10: .word exBossMeteAdminTask__Func8
	arm_func_end exBossMeteAdminTask__Create

	arm_func_start exBossSysAdminTask__RunTaskUnknownEvent
exBossSysAdminTask__RunTaskUnknownEvent: // 0x0215DC14
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__RunTaskUnknownEvent

	arm_func_start exBossSysAdminTask__Action_StartMete0
exBossSysAdminTask__Action_StartMete0: // 0x0215DC2C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #1
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl exBossEffectFireTask__Create
	mov r0, #0
	str r0, [sp]
	ldr r1, _0215DC94 // =0x00000103
	str r1, [sp, #4]
	sub r1, r1, #0x104
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	bl exBossMeteAdminTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215DC98 // =exBossSysAdminTask__Func_215DC9C
	str r1, [r0]
	bl exBossSysAdminTask__Func_215DC9C
	bl exBossSysAdminTask__RunTaskUnknownEvent
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DC94: .word 0x00000103
_0215DC98: .word exBossSysAdminTask__Func_215DC9C
	arm_func_end exBossSysAdminTask__Action_StartMete0

	arm_func_start exBossSysAdminTask__Func_215DC9C
exBossSysAdminTask__Func_215DC9C: // 0x0215DC9C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215DCC8
	bl exBossSysAdminTask__Func_215DCE4
	ldmia sp!, {r4, pc}
_0215DCC8:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl exBossSysAdminTask__RunTaskUnknownEvent
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Func_215DC9C

	arm_func_start exBossSysAdminTask__Func_215DCE4
exBossSysAdminTask__Func_215DCE4: // 0x0215DCE4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov r2, #0xd2
	add r0, r4, #0x6c
	mov r1, #2
	strh r2, [r4, #0x56]
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_2164218
	bl exBossMeteLockOnTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215DD28 // =exBossSysAdminTask__Func_215DD2C
	str r1, [r0]
	bl exBossSysAdminTask__Func_215DD2C
	bl exBossSysAdminTask__RunTaskUnknownEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DD28: .word exBossSysAdminTask__Func_215DD2C
	arm_func_end exBossSysAdminTask__Func_215DCE4

	arm_func_start exBossSysAdminTask__Func_215DD2C
exBossSysAdminTask__Func_215DD2C: // 0x0215DD2C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldrsh r1, [r4, #0x56]
	sub r0, r1, #1
	strh r0, [r4, #0x56]
	cmp r1, #0
	bge _0215DD5C
	bl exBossSysAdminTask__Func_215DD78
	ldmia sp!, {r4, pc}
_0215DD5C:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl exBossSysAdminTask__RunTaskUnknownEvent
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Func_215DD2C

	arm_func_start exBossSysAdminTask__Func_215DD78
exBossSysAdminTask__Func_215DD78: // 0x0215DD78
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov r0, #0
	strh r0, [r4, #0x56]
	bl exBossEffectFireTask__Func_21581C0
	add r0, r4, #0x6c
	mov r1, #3
	bl exBossHelpers__SetAnimation
	add r0, r4, #0x3f8
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _0215DDBC // =exBossSysAdminTask__Func_215DDC0
	str r1, [r0]
	bl exBossSysAdminTask__Func_215DDC0
	bl exBossSysAdminTask__RunTaskUnknownEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DDBC: .word exBossSysAdminTask__Func_215DDC0
	arm_func_end exBossSysAdminTask__Func_215DD78

	arm_func_start exBossSysAdminTask__Func_215DDC0
exBossSysAdminTask__Func_215DDC0: // 0x0215DDC0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0xf000
	blt _0215DE1C
	mov ip, #0xc9
	sub r1, ip, #0xca
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0215DE3C // =exBossSysAdminTask__Func_215DE40
	str r1, [r0]
	bl exBossSysAdminTask__Func_215DE40
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_0215DE1C:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl exBossSysAdminTask__RunTaskUnknownEvent
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215DE3C: .word exBossSysAdminTask__Func_215DE40
	arm_func_end exBossSysAdminTask__Func_215DDC0

	arm_func_start exBossSysAdminTask__Func_215DE40
exBossSysAdminTask__Func_215DE40: // 0x0215DE40
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0x23000
	bne _0215DE6C
	bl exBossSysAdminTask__Func_215DE88
	ldmia sp!, {r4, pc}
_0215DE6C:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl exBossSysAdminTask__RunTaskUnknownEvent
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Func_215DE40

	arm_func_start exBossSysAdminTask__Func_215DE88
exBossSysAdminTask__Func_215DE88: // 0x0215DE88
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exBossMeteMeteoTask__Create
	bl GetExTaskCurrent
	ldr r1, _0215DEAC // =exBossSysAdminTask__Func_215DEB0
	str r1, [r0]
	bl exBossSysAdminTask__Func_215DEB0
	bl exBossSysAdminTask__RunTaskUnknownEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_0215DEAC: .word exBossSysAdminTask__Func_215DEB0
	arm_func_end exBossSysAdminTask__Func_215DE88

	arm_func_start exBossSysAdminTask__Func_215DEB0
exBossSysAdminTask__Func_215DEB0: // 0x0215DEB0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__Animate
	add r0, r4, #0x6c
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0215DEDC
	bl exBossSysAdminTask__Action_FinishMeteorAttack
	ldmia sp!, {r4, pc}
_0215DEDC:
	add r0, r4, #0x6c
	bl exHitCheckTask__AddHitCheck
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl exDrawReqTask__AddRequest
	bl exBossSysAdminTask__RunTaskUnknownEvent
	ldmia sp!, {r4, pc}
	arm_func_end exBossSysAdminTask__Func_215DEB0

	arm_func_start exBossSysAdminTask__Action_FinishMeteorAttack
exBossSysAdminTask__Action_FinishMeteorAttack: // 0x0215DEF8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0x548]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exBossSysAdminTask__Action_FinishMeteorAttack

	.data
	
aExtraExBb_5: // 0x021742B8
	.asciz "/extra/ex.bb"
	.align 4
	
aExbossmetebomb: // 0x021742C8
	.asciz "exBossMeteBombTask"
	.align 4
	
aExbossmetelock: // 0x021742DC
	.asciz "exBossMeteLockOnTask"
	.align 4
	
aExbossmetemete: // 0x021742F4
	.asciz "exBossMeteMeteoTask"
	.align 4

aExbossmeteadmi: // 0x02174308
	.asciz "exBossMeteAdminTask"
	.align 4