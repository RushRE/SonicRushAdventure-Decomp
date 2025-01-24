	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start exSonDushEffectTask__LoadAssets
exSonDushEffectTask__LoadAssets: // 0x02171BE8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02172248 // =0x021785D8
	mov r4, r0
	str r4, [r1, #0x1c]
	ldr r0, [r1, #0xc]
	cmp r0, #0
	ldrne r0, [r1, #0x10]
	cmpne r0, #0
	beq _02171C64
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02172248 // =0x021785D8
	ldr r1, [r1, #0xc]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02172248 // =0x021785D8
	ldr r1, [r1, #0x10]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02172248 // =0x021785D8
	ldr r1, [r1, #0xc]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02171C64:
	mov r0, r4
	bl exDrawReqTask__InitModel
	ldr r0, _02172248 // =0x021785D8
	ldrsh r0, [r0, #6]
	cmp r0, #0
	bne _02171D10
	mov r1, #0x1a
	ldr r0, _0217224C // =aExtraExBb_10
	sub r2, r1, #0x1b
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _02172248 // =0x021785D8
	mov r0, r0, lsr #8
	str r0, [r1, #0xc]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02172248 // =0x021785D8
	mov r0, r5
	str r1, [r2, #0x14]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x45
	bl exSysTask__LoadExFile
	ldr r1, _02172248 // =0x021785D8
	mov r2, #0
	str r0, [r1, #0x48]
	mov r0, #0x46
	str r2, [r1, #0x3c]
	bl exSysTask__LoadExFile
	ldr r1, _02172248 // =0x021785D8
	mov r2, #1
	str r0, [r1, #0x4c]
	mov r0, #0x47
	str r2, [r1, #0x40]
	bl exSysTask__LoadExFile
	ldr r1, _02172248 // =0x021785D8
	mov r2, #4
	str r0, [r1, #0x50]
	str r2, [r1, #0x44]
	ldr r0, [r1, #0x14]
	bl Asset3DSetup__Create
_02171D10:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02172248 // =0x021785D8
	str r2, [sp]
	ldr r1, [r0, #0x14]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _02172250 // =0x02178614
	ldr r5, _02172254 // =0x02178620
	mov r7, r8
_02171D48:
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
	blo _02171D48
	ldr r2, _02172248 // =0x021785D8
	add r1, r4, #0x300
	ldr r3, [r2, #0x40]
	mov r0, #0
	strh r3, [r1, #0x48]
	ldr r1, [r2, #0x40]
	mov r3, #1
	add r1, r4, r1, lsl #2
	ldr r1, [r1, #0x104]
	str r1, [r4, #0x344]
_02171D9C:
	mov r1, r3, lsl r0
	tst r1, #0x13
	beq _02171DBC
	add r1, r4, r0, lsl #1
	add r1, r1, #0x100
	ldrh r2, [r1, #0x2c]
	orr r2, r2, #2
	strh r2, [r1, #0x2c]
_02171DBC:
	add r0, r0, #1
	cmp r0, #5
	blo _02171D9C
	mov r0, #0x3c000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	str r0, [r4, #0x370]
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _02171E40
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _02171E40
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _02171E40
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _021721E4
_02171E40:
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	beq _02171E70
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _02171E70
	bl exSysTask__GetStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	bne _02171E80
_02171E70:
	ldr r1, _02172258 // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	b _021721F0
_02171E80:
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02171EE4
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _02171EE4
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _02171EE4
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02171EE4
	ldr r1, _02172258 // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	b _021721F0
_02171EE4:
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02171F54
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02171F54
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _02171F54
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02171F54
	ldr r2, _02172258 // =0x0000BFF4
	add r0, r4, #0x300
	ldr r1, _0217225C // =0x00001FFE
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _021721F0
_02171F54:
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02171FC0
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02171FC0
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _02171FC0
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _02171FC0
	ldr r2, _02172258 // =0x0000BFF4
	add r0, r4, #0x300
	ldr r1, _02172260 // =0x00003FFC
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _021721F0
_02171FC0:
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _02172030
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02172030
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02172030
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _02172030
	ldr r1, _02172258 // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	mov r1, r1, lsr #1
	strh r1, [r0, #0x4c]
	b _021721F0
_02172030:
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0217209C
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _0217209C
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0217209C
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _0217209C
	ldr r2, _02172258 // =0x0000BFF4
	add r0, r4, #0x300
	ldr r1, _02172264 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _021721F0
_0217209C:
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0217210C
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _0217210C
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0217210C
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _0217210C
	ldr r2, _02172258 // =0x0000BFF4
	add r0, r4, #0x300
	ldr r1, _02172268 // =0x00009FF6
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _021721F0
_0217210C:
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02172174
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _02172174
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _02172174
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _02172174
	ldr r1, _02172258 // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _021721F0
_02172174:
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _021721F0
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _021721F0
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _021721F0
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _021721F0
	ldr r2, _02172258 // =0x0000BFF4
	add r0, r4, #0x300
	ldr r1, _0217226C // =0x0000DFF2
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4c]
	b _021721F0
_021721E4:
	ldr r1, _02172258 // =0x0000BFF4
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
_021721F0:
	mov r3, #0
	strb r3, [r4]
	ldrb r2, [r4, #5]
	add r0, r4, #0x350
	ldr r1, _02172248 // =0x021785D8
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
_02172248: .word 0x021785D8
_0217224C: .word aExtraExBb_10
_02172250: .word 0x02178614
_02172254: .word 0x02178620
_02172258: .word 0x0000BFF4
_0217225C: .word 0x00001FFE
_02172260: .word 0x00003FFC
_02172264: .word 0x00007FF8
_02172268: .word 0x00009FF6
_0217226C: .word 0x0000DFF2
	arm_func_end exSonDushEffectTask__LoadAssets

	arm_func_start exSonDushEffectTask__Destroy_2172270
exSonDushEffectTask__Destroy_2172270: // 0x02172270
	stmdb sp!, {r4, lr}
	ldr r1, _02172314 // =0x021785D8
	mov r4, r0
	ldrsh r0, [r1, #6]
	cmp r0, #1
	bgt _021722F4
	ldr r0, [r1, #0x14]
	cmp r0, #0
	beq _02172298
	bl NNS_G3dResDefaultRelease
_02172298:
	ldr r0, _02172314 // =0x021785D8
	ldr r0, [r0, #0x48]
	cmp r0, #0
	beq _021722AC
	bl NNS_G3dResDefaultRelease
_021722AC:
	ldr r0, _02172314 // =0x021785D8
	ldr r0, [r0, #0x4c]
	cmp r0, #0
	beq _021722C0
	bl NNS_G3dResDefaultRelease
_021722C0:
	ldr r0, _02172314 // =0x021785D8
	ldr r0, [r0, #0x50]
	cmp r0, #0
	beq _021722D4
	bl NNS_G3dResDefaultRelease
_021722D4:
	ldr r0, _02172314 // =0x021785D8
	ldr r0, [r0, #0x14]
	cmp r0, #0
	beq _021722E8
	bl _FreeHEAP_USER
_021722E8:
	ldr r0, _02172314 // =0x021785D8
	mov r1, #0
	str r1, [r0, #0x14]
_021722F4:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02172314 // =0x021785D8
	ldrsh r1, [r0, #6]
	cmp r1, #0
	subgt r1, r1, #1
	strgth r1, [r0, #6]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172314: .word 0x021785D8
	arm_func_end exSonDushEffectTask__Destroy_2172270

	arm_func_start exSonDushEffectTask__Main
exSonDushEffectTask__Main: // 0x02172318
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0217235C // =0x021785D8
	str r0, [r1, #0x18]
	add r0, r4, #4
	bl exSonDushEffectTask__LoadAssets
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _02172360 // =exSonDushEffectTask__Main_Active
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217235C: .word 0x021785D8
_02172360: .word exSonDushEffectTask__Main_Active
	arm_func_end exSonDushEffectTask__Main

	arm_func_start exSonDushEffectTask__Func8
exSonDushEffectTask__Func8: // 0x02172364
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exSysTask__GetFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02172388 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02172388: .word ExTask_State_Destroy
	arm_func_end exSonDushEffectTask__Func8

	arm_func_start exSonDushEffectTask__Destructor
exSonDushEffectTask__Destructor: // 0x0217238C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl exSonDushEffectTask__Destroy_2172270
	ldr r0, _021723AC // =0x021785D8
	mov r1, #0
	str r1, [r0, #0x18]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021723AC: .word 0x021785D8
	arm_func_end exSonDushEffectTask__Destructor

	arm_func_start exSonDushEffectTask__Main_Active
exSonDushEffectTask__Main_Active: // 0x021723B0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl exDrawReqTask__Model__Animate
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
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02172408
	bl GetExTaskCurrent
	ldr r1, _02172424 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02172408:
	add r0, r4, #4
	add r1, r4, #0x390
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172424: .word ExTask_State_Destroy
	arm_func_end exSonDushEffectTask__Main_Active

	arm_func_start exSonDushEffectTask__Create
exSonDushEffectTask__Create: // 0x02172428
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr r1, _021724B0 // =0x021785D8
	mov r4, r0
	ldr r0, [r1, #0x18]
	cmp r0, #0
	beq _02172448
	bl exSonDushEffectTask__Destroy
_02172448:
	mov r5, #0
	ldr r1, _021724B4 // =0x000004E4
	str r5, [sp]
	str r1, [sp, #4]
	ldr r0, _021724B8 // =aExsondusheffec
	ldr r1, _021724BC // =exSonDushEffectTask__Destructor
	str r0, [sp, #8]
	ldr r0, _021724C0 // =exSonDushEffectTask__Main
	mov r2, #0x2000
	mov r3, #5
	str r5, [sp, #0xc]
	bl ExTaskCreate_
	mov r6, r0
	bl GetExTaskWork_
	mov r1, r5
	ldr r2, _021724B4 // =0x000004E4
	mov r5, r0
	bl MI_CpuFill8
	mov r0, r6
	str r4, [r5, #0x4e0]
	bl GetExTask
	ldr r1, _021724C4 // =exSonDushEffectTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_021724B0: .word 0x021785D8
_021724B4: .word 0x000004E4
_021724B8: .word aExsondusheffec
_021724BC: .word exSonDushEffectTask__Destructor
_021724C0: .word exSonDushEffectTask__Main
_021724C4: .word exSonDushEffectTask__Func8
	arm_func_end exSonDushEffectTask__Create

	arm_func_start exSonDushEffectTask__Destroy
exSonDushEffectTask__Destroy: // 0x021724C8
	stmdb sp!, {r3, lr}
	ldr r0, _021724EC // =0x021785D8
	ldr r0, [r0, #0x18]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _021724F0 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021724EC: .word 0x021785D8
_021724F0: .word ExTask_State_Destroy
	arm_func_end exSonDushEffectTask__Destroy

	arm_func_start exSonDushEffectTask__LoadSonicSprite
exSonDushEffectTask__LoadSonicSprite: // 0x021724F4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	bl exDrawReqTask__InitSprite3D
	ldr r0, _021725F0 // =0x021785D8
	ldrsh r0, [r0, #0]
	cmp r0, #0
	bne _02172524
	mov r0, #0
	bl exSysTask__LoadExFile
	ldr r1, _021725F0 // =0x021785D8
	str r0, [r1, #0x24]
_02172524:
	ldr r0, _021725F0 // =0x021785D8
	mov r1, #1
	ldr r0, [r0, #0x24]
	bl Sprite__GetTextureSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocTexture
	ldr r1, _021725F0 // =0x021785D8
	mov r5, r0
	ldr r0, [r1, #0x24]
	mov r1, #1
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #4
	stmia sp, {r1, r5}
	str r0, [sp, #8]
	ldr r2, _021725F0 // =0x021785D8
	add r0, r4, #0x20
	ldr r2, [r2, #0x24]
	mov r1, #0
	mov r3, #0xe
	bl AnimatorSprite3D__Init
	ldr r0, [r4, #0x114]
	mov r3, #0
	orr r0, r0, #0x800
	str r0, [r4, #0x114]
	strb r3, [r4]
	ldrb r2, [r4, #5]
	mov r1, #0x46000
	ldr r0, _021725F4 // =0x00000333
	orr r2, r2, #4
	strb r2, [r4, #5]
	str r1, [r4, #0x134]
	str r0, [r4, #0x138]
	str r0, [r4, #0x13c]
	str r0, [r4, #0x140]
	ldrb r2, [r4, #0x150]
	ldr r0, _021725F0 // =0x021785D8
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
_021725F0: .word 0x021785D8
_021725F4: .word 0x00000333
	arm_func_end exSonDushEffectTask__LoadSonicSprite

	arm_func_start exSonDushEffectTask__Func_21725F8
exSonDushEffectTask__Func_21725F8: // 0x021725F8
	stmdb sp!, {r3, lr}
	add r0, r0, #0x20
	bl AnimatorSprite3D__Release
	ldr r0, _02172618 // =0x021785D8
	ldrsh r1, [r0, #0]
	sub r1, r1, #1
	strh r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02172618: .word 0x021785D8
	arm_func_end exSonDushEffectTask__Func_21725F8

	.data

_02175E34:
	.hword 2, 0, 1, 0

aExplayerscreen: // 0x02175E3C
	.asciz "exPlayerScreenMoveTask"
	.align 4
	
aExplayeradmint: // 0x02175E54
	.asciz "exPlayerAdminTask"
	.align 4
	
aExtraExBb_10: // 0x02175E68
	.asciz "/extra/ex.bb"
	.align 4
	
aExsondusheffec: // 0x02175E78
	.asciz "exSonDushEffectTask"