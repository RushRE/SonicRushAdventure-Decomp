	.include "asm/macros.inc"
	.include "global.inc"
	
	.bss

exPlayerScreenMoveTask__dword_2177BA0: // 0x02177BA0
    .space 0x04
	
exPlayerAdminTask__TaskSingleton: // 0x02177BA4
    .space 0x04
	
exPlayerScreenMoveTask__TaskSingleton: // 0x02177BA8
    .space 0x04
	
exPlayerAdminTask__Unknown_2177BAC: // 0x02177BAC
	.space 0x6C

	.align 4
	
exPlayerAdminTask__Unknown_2177C18: // 0x02177C18
	.space 0x4E0

	.align 4
	
exPlayerAdminTask__Unknown_21780F8: // 0x021780F8
	.space 0x4E0

	.align 4
	
exPlayerAdminTask__word_21785D8: // 0x021785D8
    .space 0x02
	
exPlayerAdminTask__word_21785DA: // 0x021785DA
    .space 0x02
	
exPlayerAdminTask__word_21785DC: // 0x021785DC
    .space 0x02
	
exSonDushEffectTask__ActiveInstanceCount: // 0x021785DE
    .space 0x02

	.align 4

exPlayerAdminTask__dword_21785E0: // 0x021785E0
    .space 0x04
	
exSonDushEffectTask__dword_21785E4: // 0x021785E4
    .space 0x04
	
exSonDushEffectTask__unk_21785E8: // 0x021785E8
    .space 0x04
	
exSonDushEffectTask__dword_21785EC: // 0x021785EC
    .space 0x04
	
exSonDushEffectTask__TaskSingleton: // 0x021785F0
    .space 0x04
	
exSonDushEffectTask__unk_21785F4: // 0x021785F4
    .space 0x04
	
exSonDushEffectTask__unk_21785F8: // 0x021785F8
    .space 0x04
	
exSonDushEffectTask__dword_21785FC: // 0x021785FC
    .space 0x04
	
exPlayerAdminTask__FileTable: // 0x02178600
    .space 0x04
	
exPlayerAdminTask__dword_2178604: // 0x02178604
    .space 0x04
	
exPlayerAdminTask__dword_2178608: // 0x02178608
    .space 0x04
	
exPlayerAdminTask__dword_217860C: // 0x0217860C
    .space 0x04
	
exPlayerAdminTask__dword_2178610: // 0x02178610
    .space 0x04
	
exSonDushEffectTask__AnimTable: // 0x02178614
    .space 0x04 * 3
	
exSonDushEffectTask__FileTable: // 0x02178620
    .space 0x04 * 3

	.text

	arm_func_start exPlayerAdminTask__Main
exPlayerAdminTask__Main: // 0x0216E570
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _0216E680 // =exPlayerScreenMoveTask__dword_2177BA0
	str r0, [r1, #4]
	bl exPlayerScreenMoveTask__Create
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exPlayerAdminTask__LoadSuperSonicAssets
	ldr r0, [r4, #8]
	mov r1, #0xa800
	add r0, r0, #0x390
	bl exDrawReqTask__SetConfigPriority
	mov r1, #0x5a000
	rsb r1, r1, #0
	ldr r0, [r4, #8]
	mov r2, #0
	str r1, [r0, #0x358]
	ldr r1, [r4, #8]
	add r0, r4, #0x18
	strh r2, [r1, #2]
	bl exSonDushEffectTask__LoadSonicSprite
	add r0, r4, #0x168
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exPlayerHelpers__LoadBurningBlazeAssets
	ldr r0, [r4, #0xc]
	mov r1, #0xa800
	add r0, r0, #0x390
	bl exDrawReqTask__SetConfigPriority
	mov r1, #0x5a000
	rsb r1, r1, #0
	ldr r0, [r4, #0xc]
	mov r2, #0
	str r1, [r0, #0x358]
	ldr r1, [r4, #0xc]
	add r0, r4, #0x2b8
	strh r2, [r1, #2]
	bl exBlzDushEffectTask__LoadBlazeSprite
	add r0, r4, #8
	add r0, r0, #0x400
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	ldr r1, [r4, #4]
	ldrb r0, [r1, #0x6a]
	bic r0, r0, #1
	strb r0, [r1, #0x6a]
	bl exPlayerAdminTask__Func_21705D8
	add r0, r4, #0x15c
	add r0, r0, #0x400
	ldr r1, [r4, #0x10]
	mov r2, #1
	add r1, r1, #0x350
	bl exDrawReqTask__InitTrail
	add r0, r4, #0x3c8
	add r0, r0, #0x400
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	ldr r0, [r4, #4]
	mov r1, #0
	strh r1, [r0, #0x40]
	bl GetExTaskCurrent
	ldr r1, _0216E684 // =exPlayerAdminTask__Main_216E744
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E680: .word exPlayerScreenMoveTask__dword_2177BA0
_0216E684: .word exPlayerAdminTask__Main_216E744
	arm_func_end exPlayerAdminTask__Main

	arm_func_start exPlayerAdminTask__Func8
exPlayerAdminTask__Func8: // 0x0216E688
	ldr ip, _0216E690 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_0216E690: .word GetExTaskWorkCurrent_
	arm_func_end exPlayerAdminTask__Func8

	arm_func_start exPlayerAdminTask__Destructor
exPlayerAdminTask__Destructor: // 0x0216E694
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exPlayerAdminTask__Func_2171954
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exPlayerAdminTask__Func_2171B80
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exPlayerHelpers__ReleaseBurningBlazeAssets
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exBlzDushEffectTask__Destroy_2153584
	add r0, r4, #0x18
	bl exSonDushEffectTask__Func_21725F8
	add r0, r4, #0x2b8
	bl exBlzDushEffectTask__Func_215400C
	ldr r0, _0216E704 // =exPlayerScreenMoveTask__dword_2177BA0
	ldr r0, [r0, #8]
	bl GetExTask
	ldr r2, _0216E708 // =ExTask_State_Destroy
	ldr r1, _0216E704 // =exPlayerScreenMoveTask__dword_2177BA0
	str r2, [r0]
	mov r0, #0
	str r0, [r1, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E704: .word exPlayerScreenMoveTask__dword_2177BA0
_0216E708: .word ExTask_State_Destroy
	arm_func_end exPlayerAdminTask__Destructor

	arm_func_start exPlayerAdminTask__Main_216E70C
exPlayerAdminTask__Main_216E70C: // 0x0216E70C
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exPlayerAdminTask__Func_2171624
	bl exPlayerAdminTask__Func_217035C
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl exPlayerAdminTask__Func_2170518
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl exPlayerAdminTask__HandleControl
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exPlayerAdminTask__Main_216E70C

	arm_func_start exPlayerAdminTask__Main_216E744
exPlayerAdminTask__Main_216E744: // 0x0216E744
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r2, [r4, #0x10]
	mov r0, #0x14000
	ldr r1, [r2, #0x354]
	rsb r0, r0, #0
	cmp r1, r0
	blt _0216E774
	bl exPlayerAdminTask__Func_216E790
	ldmia sp!, {r4, pc}
_0216E774:
	add r0, r1, #0x1000
	str r0, [r2, #0x354]
	bl exPlayerAdminTask__HandleControl
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__Main_216E744

	arm_func_start exPlayerAdminTask__Func_216E790
exPlayerAdminTask__Func_216E790: // 0x0216E790
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exMsgTitleTask__Create
	bl GetExTaskCurrent
	ldr r1, _0216E7B0 // =exPlayerAdminTask__Main_216E7B4
	str r1, [r0]
	bl exPlayerAdminTask__Main_216E7B4
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216E7B0: .word exPlayerAdminTask__Main_216E7B4
	arm_func_end exPlayerAdminTask__Func_216E790

	arm_func_start exPlayerAdminTask__Main_216E7B4
exPlayerAdminTask__Main_216E7B4: // 0x0216E7B4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exPlayerAdminTask__Func_2171624
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #4
	bne _0216E7DC
	bl GetExTaskCurrent
	ldr r1, _0216E7F0 // =exPlayerAdminTask__Main_216E70C
	str r1, [r0]
_0216E7DC:
	bl exPlayerAdminTask__HandleControl
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216E7F0: .word exPlayerAdminTask__Main_216E70C
	arm_func_end exPlayerAdminTask__Main_216E7B4

	arm_func_start exPlayerAdminTask__Func_216E7F4
exPlayerAdminTask__Func_216E7F4: // 0x0216E7F4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r1, [r4, #4]
	mov r0, #0
	strh r0, [r1, #0x3c]
	bl exDrawReqTask__Func_2164288
	ldr r2, [r4, #4]
	mov r1, #7
	ldrb r0, [r2, #0x6b]
	bic r0, r0, #1
	strb r0, [r2, #0x6b]
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
	ldr r0, [r4, #0xc]
	mov r1, #7
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
	ldr r0, [r4, #4]
	mov r2, #0
	strh r2, [r0, #0x44]
	mov r1, #0x1000
	ldr r0, [r4, #8]
	str r1, [r0, #0x13c]
	ldr r0, [r4, #4]
	strh r2, [r0, #0x46]
	ldr r0, [r4, #4]
	strh r2, [r0, #0x20]
	ldr r0, [r4, #4]
	str r2, [r0, #0x54]
	ldr r0, [r4, #4]
	str r2, [r0, #0x58]
	ldr r1, [r4, #8]
	add r0, r1, #4
	ldrh r1, [r1, #2]
	bl exPlayerAdminTask__SetSuperSonicAnimation
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	ldr r1, [r4, #0xc]
	add r0, r1, #4
	ldrh r1, [r1, #2]
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	add r0, r4, #0x118
	add r0, r0, #0x800
	ldr r1, [r4, #0x14]
	mov r2, #1
	add r1, r1, #0x350
	bl exDrawReqTask__InitTrail
	add r0, r4, #0x384
	add r0, r0, #0x800
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	bl GetExTaskCurrent
	ldr r1, _0216E8EC // =exPlayerAdminTask__Func_216E8F0
	str r1, [r0]
	bl exPlayerAdminTask__Func_216E8F0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216E8EC: .word exPlayerAdminTask__Func_216E8F0
	arm_func_end exPlayerAdminTask__Func_216E7F4

	arm_func_start exPlayerAdminTask__Func_216E8F0
exPlayerAdminTask__Func_216E8F0: // 0x0216E8F0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr lr, [r4, #4]
	ldr r3, [r4, #0x10]
	ldr r0, _0216EA60 // =0x00007FF8
	add r2, lr, #0x62
	str r0, [sp]
	ldr r1, [r3, #0x354]
	ldr r0, [lr, #0x58]
	ldr ip, [r3, #0x350]
	sub r0, r1, r0
	ldr r1, [lr, #0x54]
	add r3, lr, #0x68
	sub r1, ip, r1
	bl ovl09_2152EA8
	arm_func_end exPlayerAdminTask__Func_216E8F0

	arm_func_start exPlayerAdminTask__Func_216E938
exPlayerAdminTask__Func_216E938: // 0x0216E938
	ldr r0, [r4, #4]
	ldr ip, _0216EA64 // =FX_SinCosTable_
	ldrh r2, [r0, #0x64]
	ldr r1, [r0, #8]
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [ip, r2]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r0, #0x48]
	ldr r3, [r4, #4]
	ldrh r1, [r3, #0x64]
	ldr r0, [r3, #0xc]
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r1, [ip, r1]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r3, #0x4c]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #4]
	ldr r1, [r2, #0x350]
	ldr r0, [r0, #0x48]
	sub r0, r1, r0
	str r0, [r2, #0x350]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #4]
	ldr r1, [r2, #0x354]
	ldr r0, [r0, #0x4c]
	sub r0, r1, r0
	str r0, [r2, #0x354]
	ldr ip, [r4, #4]
	ldr r1, [r4, #0x10]
	ldr r3, [ip, #0x54]
	ldr r2, [r1, #0x350]
	add r0, r3, #0x2000
	cmp r2, r0
	bge _0216EA28
	sub r0, r3, #0x2000
	cmp r2, r0
	ble _0216EA28
	ldr r3, [ip, #0x58]
	ldr r2, [r1, #0x354]
	add r0, r3, #0x2000
	cmp r2, r0
	bge _0216EA28
	sub r0, r3, #0x2000
	cmp r2, r0
	ble _0216EA28
	bl exPlayerAdminTask__Func_216EA68
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
_0216EA28:
	ldrb r2, [ip, #0x6a]
	add r0, r4, #0x15c
	add r0, r0, #0x400
	mov r2, r2, lsl #0x1f
	add r1, r1, #0x350
	mov r3, r2, lsr #0x1f
	mov r2, #0
	bl exDrawReqTask__Trail__HandleTrail
	bl exPlayerAdminTask__Func_216EFD4
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0216EA60: .word 0x00007FF8
_0216EA64: .word FX_SinCosTable_
	arm_func_end exPlayerAdminTask__Func_216E938

	arm_func_start exPlayerAdminTask__Func_216EA68
exPlayerAdminTask__Func_216EA68: // 0x0216EA68
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #4]
	mov r1, #0x78
	strh r1, [r0, #0x60]
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	bne _0216EA94
	mov r0, #0
	bl exBossHelpers__Func_2154C38
_0216EA94:
	bl GetExTaskCurrent
	ldr r1, _0216EAA8 // =exPlayerAdminTask__Func_216EAAC
	str r1, [r0]
	bl exPlayerAdminTask__Func_216EAAC
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216EAA8: .word exPlayerAdminTask__Func_216EAAC
	arm_func_end exPlayerAdminTask__Func_216EA68

	arm_func_start exPlayerAdminTask__Func_216EAAC
exPlayerAdminTask__Func_216EAAC: // 0x0216EAAC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	beq _0216EAEC
	ldr r2, [r4, #4]
	ldrsh r1, [r2, #0x60]
	sub r0, r1, #1
	strh r0, [r2, #0x60]
	cmp r1, #0
	bgt _0216EAEC
	bl exPlayerAdminTask__Func_216EB28
	ldmia sp!, {r4, pc}
_0216EAEC:
	ldr r0, [r4, #4]
	ldr r3, [r4, #0x10]
	ldrb r1, [r0, #0x6a]
	add r0, r4, #0x15c
	add r0, r0, #0x400
	mov r2, r1, lsl #0x1f
	add r1, r3, #0x350
	mov r3, r2, lsr #0x1f
	mov r2, #0
	bl exDrawReqTask__Trail__HandleTrail
	bl exPlayerAdminTask__Func_216EFD4
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__Func_216EAAC

	arm_func_start exPlayerAdminTask__Func_216EB28
exPlayerAdminTask__Func_216EB28: // 0x0216EB28
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0x10]
	mov r1, #0
	str r1, [r0, #0x350]
	ldr r0, [r4, #0x10]
	mov r1, #0x5000
	str r1, [r0, #0x354]
	bl GetExStageSingleton
	ldr r1, [r0, #4]
	add r1, r1, #0x1000
	str r1, [r0, #4]
	ldr r0, [r4, #4]
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	bne _0216EBC8
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exSonDushEffectTask__Create
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exBlzDushEffectTask__Create
	mov ip, #0xd
	sub r1, ip, #0xe
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	mov r1, #0x1f
	mov r0, #0
	stmia sp, {r0, r1}
	sub r1, r1, #0x20
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	b _0216EC20
_0216EBC8:
	cmp r0, #1
	bne _0216EC20
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exSonDushEffectTask__Create
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exBlzDushEffectTask__Create
	mov ip, #0xd
	sub r1, ip, #0xe
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	mov r1, #0x1f
	mov r0, #0
	stmia sp, {r0, r1}
	sub r1, r1, #0x20
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
_0216EC20:
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	bne _0216EC40
	ldr r0, [r4, #4]
	mov r1, #0x12c
	strh r1, [r0, #0x60]
	b _0216EC58
_0216EC40:
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	ldreq r0, [r4, #4]
	moveq r1, #0x12c
	streqh r1, [r0, #0x60]
_0216EC58:
	mov r0, #0x10
	mov r1, #0
	mov r4, #1
	mov r2, r0
	mov r3, r1
	str r4, [sp]
	bl exDrawFadeTask__Create
	mov r0, #0x10
	mov r1, #0
	mov r4, #2
	mov r2, r0
	mov r3, r1
	str r4, [sp]
	bl exDrawFadeTask__Create
	bl GetExTaskCurrent
	ldr r1, _0216ECA8 // =exPlayerAdminTask__Func_216ECAC
	str r1, [r0]
	bl exPlayerAdminTask__Func_216ECAC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216ECA8: .word exPlayerAdminTask__Func_216ECAC
	arm_func_end exPlayerAdminTask__Func_216EB28

	arm_func_start exPlayerAdminTask__Func_216ECAC
exPlayerAdminTask__Func_216ECAC: // 0x0216ECAC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r2, [r4, #4]
	ldrsh r1, [r2, #0x60]
	sub r0, r1, #1
	strh r0, [r2, #0x60]
	cmp r1, #0
	bgt _0216ECDC
	bl exPlayerAdminTask__Func_216ED94
	ldmia sp!, {r4, pc}
_0216ECDC:
	ldr r0, [r4, #4]
	ldr r1, [r4, #0x10]
	ldrb r0, [r0, #0x6a]
	mov r2, #2
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	add r0, r4, #0x15c
	bne _0216ED40
	add r0, r0, #0x400
	add r1, r1, #0x350
	mov r3, #0
	bl exDrawReqTask__Trail__HandleTrail
	ldr r1, [r4, #0x14]
	add r0, r4, #0x118
	add r0, r0, #0x800
	add r1, r1, #0x350
	mov r2, #2
	mov r3, #1
	bl exDrawReqTask__Trail__HandleTrail
	add r0, r4, #0x118
	add r1, r4, #0x384
	add r0, r0, #0x800
	add r1, r1, #0x800
	bl exDrawReqTask__AddRequest
	b _0216ED80
_0216ED40:
	add r0, r0, #0x400
	add r1, r1, #0x350
	mov r3, #1
	bl exDrawReqTask__Trail__HandleTrail
	ldr r1, [r4, #0x14]
	add r0, r4, #0x118
	add r0, r0, #0x800
	add r1, r1, #0x350
	mov r2, #2
	mov r3, #0
	bl exDrawReqTask__Trail__HandleTrail
	add r0, r4, #0x118
	add r1, r4, #0x384
	add r0, r0, #0x800
	add r1, r1, #0x800
	bl exDrawReqTask__AddRequest
_0216ED80:
	bl exPlayerAdminTask__Func_216EFD4
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__Func_216ECAC

	arm_func_start exPlayerAdminTask__Func_216ED94
exPlayerAdminTask__Func_216ED94: // 0x0216ED94
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	mov r0, #0
	bl exBossHelpers__Func_2154C38
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	bne _0216EDC8
	bl GetExTaskCurrent
	ldr r1, _0216EDEC // =exPlayerAdminTask__Func_216EDF4
	str r1, [r0]
	bl exPlayerAdminTask__Func_216EDF4
	ldmia sp!, {r3, pc}
_0216EDC8:
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0216EDF0 // =exPlayerAdminTask__Func_216EEE4
	str r1, [r0]
	bl exPlayerAdminTask__Func_216EEE4
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216EDEC: .word exPlayerAdminTask__Func_216EDF4
_0216EDF0: .word exPlayerAdminTask__Func_216EEE4
	arm_func_end exPlayerAdminTask__Func_216ED94

	arm_func_start exPlayerAdminTask__Func_216EDF4
exPlayerAdminTask__Func_216EDF4: // 0x0216EDF4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #8
	bne _0216EE28
	bl GetExTaskCurrent
	ldr r1, _0216EEE0 // =exPlayerAdminTask__Main_216E70C
	str r1, [r0]
	bl exPlayerAdminTask__Func_216EFD4
	ldmia sp!, {r4, pc}
_0216EE28:
	ldr r0, [r4, #4]
	ldr r1, [r4, #0x10]
	ldrb r0, [r0, #0x6a]
	mov r2, #2
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	add r0, r4, #0x15c
	bne _0216EE8C
	add r0, r0, #0x400
	add r1, r1, #0x350
	mov r3, #0
	bl exDrawReqTask__Trail__HandleTrail
	ldr r1, [r4, #0x14]
	add r0, r4, #0x118
	add r0, r0, #0x800
	add r1, r1, #0x350
	mov r2, #2
	mov r3, #1
	bl exDrawReqTask__Trail__HandleTrail
	add r0, r4, #0x118
	add r1, r4, #0x384
	add r0, r0, #0x800
	add r1, r1, #0x800
	bl exDrawReqTask__AddRequest
	b _0216EECC
_0216EE8C:
	add r0, r0, #0x400
	add r1, r1, #0x350
	mov r3, #1
	bl exDrawReqTask__Trail__HandleTrail
	ldr r1, [r4, #0x14]
	add r0, r4, #0x118
	add r0, r0, #0x800
	add r1, r1, #0x350
	mov r2, #2
	mov r3, #0
	bl exDrawReqTask__Trail__HandleTrail
	add r0, r4, #0x118
	add r1, r4, #0x384
	add r0, r0, #0x800
	add r1, r1, #0x800
	bl exDrawReqTask__AddRequest
_0216EECC:
	bl exPlayerAdminTask__Func_216EFD4
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216EEE0: .word exPlayerAdminTask__Main_216E70C
	arm_func_end exPlayerAdminTask__Func_216EDF4

	arm_func_start exPlayerAdminTask__Func_216EEE4
exPlayerAdminTask__Func_216EEE4: // 0x0216EEE4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xa
	bne _0216EF18
	bl GetExTaskCurrent
	ldr r1, _0216EFD0 // =exPlayerAdminTask__Main_216E70C
	str r1, [r0]
	bl exPlayerAdminTask__Func_216EFD4
	ldmia sp!, {r4, pc}
_0216EF18:
	ldr r0, [r4, #4]
	ldr r1, [r4, #0x10]
	ldrb r0, [r0, #0x6a]
	mov r2, #2
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	add r0, r4, #0x15c
	bne _0216EF7C
	add r0, r0, #0x400
	add r1, r1, #0x350
	mov r3, #0
	bl exDrawReqTask__Trail__HandleTrail
	ldr r1, [r4, #0x14]
	add r0, r4, #0x118
	add r0, r0, #0x800
	add r1, r1, #0x350
	mov r2, #2
	mov r3, #1
	bl exDrawReqTask__Trail__HandleTrail
	add r0, r4, #0x118
	add r1, r4, #0x384
	add r0, r0, #0x800
	add r1, r1, #0x800
	bl exDrawReqTask__AddRequest
	b _0216EFBC
_0216EF7C:
	add r0, r0, #0x400
	add r1, r1, #0x350
	mov r3, #1
	bl exDrawReqTask__Trail__HandleTrail
	ldr r1, [r4, #0x14]
	add r0, r4, #0x118
	add r0, r0, #0x800
	add r1, r1, #0x350
	mov r2, #2
	mov r3, #0
	bl exDrawReqTask__Trail__HandleTrail
	add r0, r4, #0x118
	add r1, r4, #0x384
	add r0, r0, #0x800
	add r1, r1, #0x800
	bl exDrawReqTask__AddRequest
_0216EFBC:
	bl exPlayerAdminTask__Func_216EFD4
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216EFD0: .word exPlayerAdminTask__Main_216E70C
	arm_func_end exPlayerAdminTask__Func_216EEE4

	arm_func_start exPlayerAdminTask__Func_216EFD4
exPlayerAdminTask__Func_216EFD4: // 0x0216EFD4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r1, [r4, #0x10]
	ldr r0, _0216F17C // =0x00007F49
	add r1, r1, #0x300
	ldrh r2, [r1, #0x4e]
	cmp r2, r0
	addlo r0, r2, #0x2d8
	strloh r0, [r1, #0x4e]
	blo _0216F018
	ldr r0, _0216F180 // =0x000080B6
	cmp r2, r0
	subhi r0, r2, #0x2d8
	strhih r0, [r1, #0x4e]
	movls r0, #0x8000
	strlsh r0, [r1, #0x4e]
_0216F018:
	ldr r0, [r4, #0x10]
	add r1, r0, #0x38c
	bl exDrawReqTask__AddRequest
	ldr r1, [r4, #0x10]
	ldr r0, [r4, #4]
	add r1, r1, #0x350
	str r1, [r0, #4]
	ldr r0, [r4, #4]
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	bne _0216F0C8
	ldr r1, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r1, [r1, #0x350]
	ldr lr, [r0, #0x350]
	add r1, r1, #0x5000
	sub r2, r1, lr
	mov r1, r2, asr #0x1f
	mov r3, r1, lsl #9
	mov r1, #0x800
	adds ip, r1, r2, lsl #9
	orr r3, r3, r2, lsr #23
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, lr, r3
	str r2, [r0, #0x350]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r2, [r2, #0x354]
	ldr lr, [r0, #0x354]
	sub r2, r2, #0x5000
	sub r3, r2, lr
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #9
	adds ip, r1, r3, lsl #9
	orr r2, r2, r3, lsr #23
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, lr, r2
	str r1, [r0, #0x354]
	b _0216F14C
_0216F0C8:
	cmp r0, #1
	bne _0216F14C
	ldr r1, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r1, [r1, #0x350]
	ldr lr, [r0, #0x350]
	sub r1, r1, #0x5000
	sub r2, r1, lr
	mov r1, r2, asr #0x1f
	mov r3, r1, lsl #9
	mov r1, #0x800
	adds ip, r1, r2, lsl #9
	orr r3, r3, r2, lsr #23
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, lr, r3
	str r2, [r0, #0x350]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r2, [r2, #0x354]
	ldr lr, [r0, #0x354]
	sub r2, r2, #0x5000
	sub r3, r2, lr
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #9
	adds ip, r1, r3, lsl #9
	orr r2, r2, r3, lsr #23
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, lr, r2
	str r1, [r0, #0x354]
_0216F14C:
	ldr r0, [r4, #0x14]
	add r1, r0, #0x38c
	bl exDrawReqTask__AddRequest
	add r0, r4, #0x15c
	add r1, r4, #0x3c8
	add r0, r0, #0x400
	add r1, r1, #0x400
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x10]
	add r0, r0, #0x350
	bl exPlayerScreenMoveTask__SetFollowX
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F17C: .word 0x00007F49
_0216F180: .word 0x000080B6
	arm_func_end exPlayerAdminTask__Func_216EFD4

	arm_func_start exPlayerAdminTask__Func_216F184
exPlayerAdminTask__Func_216F184: // 0x0216F184
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r2, [r4, #4]
	mov r1, #7
	ldrb r0, [r2, #0x6b]
	bic r0, r0, #1
	strb r0, [r2, #0x6b]
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
	ldr r0, [r4, #0xc]
	mov r1, #7
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
	ldr r0, [r4, #4]
	mov r2, #0
	strh r2, [r0, #0x44]
	ldr r0, [r4, #8]
	mov r1, #0x1000
	str r1, [r0, #0x13c]
	ldr r0, [r4, #4]
	mov r1, #5
	strh r2, [r0, #0x46]
	ldr r0, [r4, #4]
	strh r2, [r0, #0x20]
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exPlayerAdminTask__SetSuperSonicAnimation
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r0, [r4, #0xc]
	mov r1, #5
	add r0, r0, #4
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	mov r1, #0x78
	ldr r0, [r4, #4]
	strh r1, [r0, #0x3c]
	ldr r0, [r4, #0x10]
	add r0, r0, #0x350
	bl exEffectBiriBiriTask__Create
	bl GetExTaskCurrent
	ldr r1, _0216F250 // =exPlayerAdminTask__Func_216F254
	str r1, [r0]
	bl exPlayerAdminTask__Func_216F254
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F250: .word exPlayerAdminTask__Func_216F254
	arm_func_end exPlayerAdminTask__Func_216F184

	arm_func_start exPlayerAdminTask__Func_216F254
exPlayerAdminTask__Func_216F254: // 0x0216F254
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, [r0, #0x10]
	ldrb r0, [r1, #6]
	bic r0, r0, #4
	strb r0, [r1, #6]
	bl GetExTaskCurrent
	ldr r1, _0216F280 // =exPlayerAdminTask__Func_216F284
	str r1, [r0]
	bl exPlayerAdminTask__Func_216F284
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216F280: .word exPlayerAdminTask__Func_216F284
	arm_func_end exPlayerAdminTask__Func_216F254

	arm_func_start exPlayerAdminTask__Func_216F284
exPlayerAdminTask__Func_216F284: // 0x0216F284
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642BC
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642BC
	ldr r1, [r4, #8]
	ldrb r0, [r1, #0x390]
	bic r0, r0, #0xf0
	orr r0, r0, #0x50
	strb r0, [r1, #0x390]
	ldr r1, [r4, #0xc]
	ldrb r0, [r1, #0x390]
	bic r0, r0, #0xf0
	orr r0, r0, #0x50
	strb r0, [r1, #0x390]
	bl exPlayerAdminTask__Func_217035C
	cmp r0, #0
	beq _0216F304
	ldr r1, [r4, #8]
	ldrb r0, [r1, #0x390]
	bic r0, r0, #0xf0
	strb r0, [r1, #0x390]
	ldr r1, [r4, #0xc]
	ldrb r0, [r1, #0x390]
	bic r0, r0, #0xf0
	strb r0, [r1, #0x390]
	ldmia sp!, {r4, pc}
_0216F304:
	ldr r2, [r4, #4]
	ldrsh r1, [r2, #0x3c]
	sub r0, r1, #1
	strh r0, [r2, #0x3c]
	cmp r1, #0
	bgt _0216F38C
	ldr r0, [r4, #4]
	mov r1, #0
	strh r1, [r0, #0x3c]
	ldr r1, [r4, #8]
	ldrb r0, [r1, #0x390]
	bic r0, r0, #0xf0
	strb r0, [r1, #0x390]
	ldr r1, [r4, #0xc]
	ldrb r0, [r1, #0x390]
	bic r0, r0, #0xf0
	strb r0, [r1, #0x390]
	ldr r0, [r4, #8]
	ldrh r1, [r0, #2]
	add r0, r0, #4
	bl exPlayerAdminTask__SetSuperSonicAnimation
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	ldr r0, [r4, #0xc]
	ldrh r1, [r0, #2]
	add r0, r0, #4
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	bl GetExTaskCurrent
	ldr r1, _0216F3A0 // =exPlayerAdminTask__Main_216E70C
	str r1, [r0]
_0216F38C:
	bl exPlayerAdminTask__HandleControl
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F3A0: .word exPlayerAdminTask__Main_216E70C
	arm_func_end exPlayerAdminTask__Func_216F284

	arm_func_start exPlayerAdminTask__Action_Die
exPlayerAdminTask__Action_Die: // 0x0216F3A4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExStageSingleton
	mov r1, #0
	str r1, [r0, #4]
	mov r0, r1
	bl exDrawReqTask__Func_2164288
	ldr r2, [r4, #0x10]
	mov r1, #0
	ldrb r0, [r2, #0x38c]
	bic r0, r0, #4
	strb r0, [r2, #0x38c]
	ldr r2, [r4, #0x14]
	ldrb r0, [r2, #0x38c]
	bic r0, r0, #4
	strb r0, [r2, #0x38c]
	ldr r0, [r4, #4]
	strh r1, [r0, #0x3e]
	ldr r0, [r4, #4]
	strh r1, [r0, #0x3c]
	ldr r1, [r4, #8]
	ldrb r0, [r1, #0x390]
	bic r0, r0, #0xf0
	strb r0, [r1, #0x390]
	ldr r1, [r4, #0xc]
	ldrb r0, [r1, #0x390]
	bic r0, r0, #0xf0
	strb r0, [r1, #0x390]
	ldr r2, [r4, #0x10]
	ldr r1, [r4, #0x14]
	ldr r0, [r4, #8]
	ldr r5, [r2, #0x350]
	add r0, r0, #4
	ldr r6, [r2, #0x354]
	ldr r7, [r2, #0x358]
	ldr r8, [r1, #0x350]
	ldr r9, [r1, #0x354]
	ldr r10, [r1, #0x358]
	bl exPlayerAdminTask__Func_2171954
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exPlayerAdminTask__LoadSonicAssets
	ldr r0, [r4, #8]
	mov r1, #0xa800
	add r0, r0, #0x390
	bl exDrawReqTask__SetConfigPriority
	mov r1, #0
	ldr r0, [r4, #8]
	strh r1, [r0, #2]
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exPlayerHelpers__ReleaseBurningBlazeAssets
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exPlayerHelpers__LoadBlazeAssets
	ldr r0, [r4, #0xc]
	mov r1, #0xa800
	add r0, r0, #0x390
	bl exDrawReqTask__SetConfigPriority
	mov r0, #0
	ldr r1, [r4, #0xc]
	strh r0, [r1, #2]
	ldr r1, [r4, #0x10]
	str r5, [r1, #0x350]
	ldr r1, [r4, #0x10]
	str r6, [r1, #0x354]
	ldr r1, [r4, #0x10]
	mov r5, #0x26
	str r7, [r1, #0x358]
	ldr r2, [r4, #0x14]
	sub r1, r5, #0x27
	str r8, [r2, #0x350]
	ldr r2, [r4, #0x14]
	mov r6, #0xa000
	str r9, [r2, #0x354]
	ldr r3, [r4, #0x14]
	mov r2, r1
	str r10, [r3, #0x358]
	ldr r4, [r4, #4]
	mov r3, r1
	str r6, [r4, #0x1c]
	stmia sp, {r0, r5}
	bl PlaySfxEx
	bl GetExTaskCurrent
	ldr r1, _0216F510 // =exPlayerAdminTask__Func_216F514
	str r1, [r0]
	bl exPlayerAdminTask__Func_216F514
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0216F510: .word exPlayerAdminTask__Func_216F514
	arm_func_end exPlayerAdminTask__Action_Die

	arm_func_start exPlayerAdminTask__Func_216F514
exPlayerAdminTask__Func_216F514: // 0x0216F514
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r1, [r4, #4]
	ldr r0, [r1, #0x1c]
	sub r0, r0, #0x800
	str r0, [r1, #0x1c]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #4]
	ldr r1, [r2, #0x358]
	ldr r0, [r0, #0x1c]
	add r0, r1, r0
	str r0, [r2, #0x358]
	ldr r2, [r4, #0x14]
	ldr r0, [r4, #4]
	ldr r1, [r2, #0x358]
	ldr r0, [r0, #0x1c]
	add r0, r1, r0
	str r0, [r2, #0x358]
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0216F580
	bl exPlayerAdminTask__Func_216F5A4
	ldmia sp!, {r4, pc}
_0216F580:
	ldr r1, [r4, #4]
	ldrb r0, [r1, #0x6b]
	orr r0, r0, #4
	strb r0, [r1, #0x6b]
	bl exPlayerAdminTask__HandleControl
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__Func_216F514

	arm_func_start exPlayerAdminTask__Func_216F5A4
exPlayerAdminTask__Func_216F5A4: // 0x0216F5A4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #8]
	mov r1, #1
	add r0, r0, #4
	bl exPlayerAdminTask__SetSonicAnimation
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	ldr r0, [r4, #0xc]
	mov r1, #1
	add r0, r0, #4
	bl exPlayerHelpers__SetBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	ldr r0, [r4, #4]
	mov r1, #0x5a
	strh r1, [r0, #0x42]
	bl GetExTaskCurrent
	ldr r1, _0216F608 // =exPlayerAdminTask__Func_216F60C
	str r1, [r0]
	bl exPlayerAdminTask__Func_216F60C
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F608: .word exPlayerAdminTask__Func_216F60C
	arm_func_end exPlayerAdminTask__Func_216F5A4

	arm_func_start exPlayerAdminTask__Func_216F60C
exPlayerAdminTask__Func_216F60C: // 0x0216F60C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r0, [r4, #0x10]
	ldr r0, [r0, #0x358]
	cmp r0, #0
	bgt _0216F64C
	ldr r2, [r4, #4]
	ldrsh r1, [r2, #0x42]
	sub r0, r1, #1
	strh r0, [r2, #0x42]
	cmp r1, #0
	bgt _0216F68C
	bl exPlayerAdminTask__Func_216F6B0
	ldmia sp!, {r4, pc}
_0216F64C:
	ldr r1, [r4, #4]
	ldr r0, [r1, #0x1c]
	sub r0, r0, #0x800
	str r0, [r1, #0x1c]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #4]
	ldr r1, [r2, #0x358]
	ldr r0, [r0, #0x1c]
	add r0, r1, r0
	str r0, [r2, #0x358]
	ldr r2, [r4, #0x14]
	ldr r0, [r4, #4]
	ldr r1, [r2, #0x358]
	ldr r0, [r0, #0x1c]
	add r0, r1, r0
	str r0, [r2, #0x358]
_0216F68C:
	ldr r1, [r4, #4]
	ldrb r0, [r1, #0x6b]
	orr r0, r0, #4
	strb r0, [r1, #0x6b]
	bl exPlayerAdminTask__HandleControl
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__Func_216F60C

	arm_func_start exPlayerAdminTask__Func_216F6B0
exPlayerAdminTask__Func_216F6B0: // 0x0216F6B0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemStatus
	mov r1, #6
	strb r1, [r0, #1]
	bl GetExTaskCurrent
	ldr r1, _0216F6D8 // =exPlayerAdminTask__Func_216F6DC
	str r1, [r0]
	bl exPlayerAdminTask__Func_216F6DC
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216F6D8: .word exPlayerAdminTask__Func_216F6DC
	arm_func_end exPlayerAdminTask__Func_216F6B0

	arm_func_start exPlayerAdminTask__Func_216F6DC
exPlayerAdminTask__Func_216F6DC: // 0x0216F6DC
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, [r0, #4]
	ldrb r0, [r1, #0x6b]
	orr r0, r0, #4
	strb r0, [r1, #0x6b]
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exPlayerAdminTask__Func_216F6DC

	arm_func_start exPlayerAdminTask__Func_216F704
exPlayerAdminTask__Func_216F704: // 0x0216F704
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	bl GetExSystemStatus
	ldrb r0, [r0, #2]
	cmp r0, #1
	bne _0216F738
	bl CheckExTimeGameplayIsTimeOver
	cmp r0, #0
	beq _0216F738
	bl exPlayerAdminTask__Action_Die
	ldmia sp!, {r4, pc}
_0216F738:
	ldr r0, [r4, #4]
	mov r1, #0
	strh r1, [r0, #0x3c]
	ldr r2, [r4, #0x10]
	mov r1, #7
	ldrb r0, [r2, #6]
	bic r0, r0, #4
	strb r0, [r2, #6]
	ldr r2, [r4, #4]
	ldrb r0, [r2, #0x6b]
	bic r0, r0, #1
	strb r0, [r2, #0x6b]
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
	ldr r0, [r4, #0xc]
	mov r1, #7
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
	ldr r0, [r4, #4]
	mov ip, #0
	strh ip, [r0, #0x44]
	ldr r0, [r4, #8]
	mov r1, #0x1000
	str r1, [r0, #0x13c]
	ldr r0, [r4, #4]
	mov r3, #0x2800
	strh ip, [r0, #0x46]
	ldr r0, [r4, #4]
	mov r2, #0x3c000
	strh ip, [r0, #0x20]
	ldr ip, [r4, #4]
	mov r1, #4
	ldrb r0, [ip, #0x6a]
	orr r0, r0, #0x80
	strb r0, [ip, #0x6a]
	ldr r0, [r4, #4]
	str r3, [r0, #0x34]
	ldr r0, [r4, #4]
	str r2, [r0, #0x38]
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exPlayerAdminTask__SetSuperSonicAnimation
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r0, [r4, #0xc]
	mov r1, #4
	add r0, r0, #4
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _0216F820 // =exPlayerAdminTask__Func_216F824
	str r1, [r0]
	bl exPlayerAdminTask__Func_216F824
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F820: .word exPlayerAdminTask__Func_216F824
	arm_func_end exPlayerAdminTask__Func_216F704

	arm_func_start exPlayerAdminTask__Func_216F824
exPlayerAdminTask__Func_216F824: // 0x0216F824
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov r5, #0
	bl exPlayerAdminTask__Func_2171624
	ldr r1, [r4, #4]
	ldr r0, [r1, #0x34]
	sub r0, r0, #0x100
	str r0, [r1, #0x34]
	ldr r1, [r4, #4]
	ldr r0, [r1, #0x34]
	cmp r0, #0x100
	movle r0, r5
	strle r0, [r1, #0x34]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #4]
	ldr r1, [r2, #0x354]
	ldr r0, [r0, #0x34]
	sub r0, r1, r0
	str r0, [r2, #0x354]
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	addne r0, r5, #1
	andne r5, r0, #0xff
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	addne r0, r5, #1
	andne r5, r0, #0xff
	cmp r5, #2
	bne _0216F8B4
	bl exPlayerAdminTask__Func_216F8D4
	ldmia sp!, {r3, r4, r5, pc}
_0216F8B4:
	ldr r0, [r4, #4]
	mov r1, #0x78
	strh r1, [r0, #0x3e]
	bl exPlayerAdminTask__HandleControl
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end exPlayerAdminTask__Func_216F824

	arm_func_start exPlayerAdminTask__Func_216F8D4
exPlayerAdminTask__Func_216F8D4: // 0x0216F8D4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r0, [r4, #8]
	ldrh r1, [r0, #2]
	add r0, r0, #4
	bl exPlayerAdminTask__SetSuperSonicAnimation
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	ldr r1, [r4, #0xc]
	add r0, r1, #4
	ldrh r1, [r1, #2]
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	mov r2, #0x3c000
	ldr r0, [r4, #0x10]
	mov r1, #0x32000
	str r2, [r0, #0x358]
	ldr r0, [r4, #0x14]
	mov r3, #0x78
	str r1, [r0, #0x358]
	ldr ip, [r4, #4]
	add r0, r4, #0x15c
	add r0, r0, #0x400
	ldrb r1, [ip, #0x6a]
	mov r2, #1
	bic r1, r1, #0x80
	strb r1, [ip, #0x6a]
	ldr r1, [r4, #4]
	strh r3, [r1, #0x3e]
	ldr r1, [r4, #0x10]
	add r1, r1, #0x350
	bl exDrawReqTask__InitTrail
	add r0, r4, #0x3c8
	add r0, r0, #0x400
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	bl GetExTaskCurrent
	ldr r1, _0216F98C // =exPlayerAdminTask__Func_216F990
	str r1, [r0]
	bl exPlayerAdminTask__Func_216F990
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216F98C: .word exPlayerAdminTask__Func_216F990
	arm_func_end exPlayerAdminTask__Func_216F8D4

	arm_func_start exPlayerAdminTask__Func_216F990
exPlayerAdminTask__Func_216F990: // 0x0216F990
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r0, [r4, #4]
	ldrsh r0, [r0, #0x3e]
	cmp r0, #0
	bgt _0216F9C8
	bl exPlayerAdminTask__Func_216FA14
	bl GetExTaskCurrent
	ldr r1, _0216FA10 // =exPlayerAdminTask__Main_216E70C
	str r1, [r0]
	bl exPlayerAdminTask__Main_216E70C
	ldmia sp!, {r4, pc}
_0216F9C8:
	ldr r1, [r4, #0x10]
	ldrb r0, [r1, #6]
	bic r0, r0, #2
	strb r0, [r1, #6]
	ldr r1, [r4, #0x14]
	ldrb r0, [r1, #6]
	bic r0, r0, #2
	strb r0, [r1, #6]
	bl exPlayerAdminTask__Func_2170518
	cmp r0, #0
	beq _0216F9FC
	bl exPlayerAdminTask__Func_216FA14
	ldmia sp!, {r4, pc}
_0216F9FC:
	bl exPlayerAdminTask__HandleControl
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FA10: .word exPlayerAdminTask__Main_216E70C
	arm_func_end exPlayerAdminTask__Func_216F990

	arm_func_start exPlayerAdminTask__Func_216FA14
exPlayerAdminTask__Func_216FA14: // 0x0216FA14
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r2, [r0, #0x10]
	ldrb r1, [r2, #6]
	bic r1, r1, #2
	strb r1, [r2, #6]
	ldr r2, [r0, #0x14]
	ldrb r1, [r2, #6]
	bic r1, r1, #2
	strb r1, [r2, #6]
	ldr r2, [r0, #0x10]
	ldrb r1, [r2, #0x38c]
	bic r1, r1, #4
	strb r1, [r2, #0x38c]
	ldr r1, [r0, #0x14]
	ldrb r0, [r1, #0x38c]
	bic r0, r0, #4
	strb r0, [r1, #0x38c]
	ldmia sp!, {r3, pc}
	arm_func_end exPlayerAdminTask__Func_216FA14

	arm_func_start exPlayerAdminTask__Action_CreateBarrier
exPlayerAdminTask__Action_CreateBarrier: // 0x0216FA60
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r3, [r0, #4]
	mov r2, #1
	ldrb r1, [r3, #0x6b]
	bic r1, r1, #1
	orr r1, r1, #1
	strb r1, [r3, #0x6b]
	ldr r1, [r0, #4]
	strh r2, [r1, #0x44]
	ldr r0, [r0, #8]
	add r0, r0, #4
	bl exExEffectSonicBarrierTaMeTask__Create
	bl GetExTaskCurrent
	ldr r1, _0216FAA8 // =exPlayerAdminTask__Func_216FAAC
	str r1, [r0]
	bl exPlayerAdminTask__Func_216FAAC
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216FAA8: .word exPlayerAdminTask__Func_216FAAC
	arm_func_end exPlayerAdminTask__Action_CreateBarrier

	arm_func_start exPlayerAdminTask__Func_216FAAC
exPlayerAdminTask__Func_216FAAC: // 0x0216FAAC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	bl exPlayerAdminTask__Func_217035C
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	bl exPlayerAdminTask__HandleMovement
	bl exPlayerAdminTask__Func_2170CC4
	ldr r2, [r4, #4]
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	bne _0216FC2C
	ldr r0, _0216FC34 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x400
	bne _0216FAFC
	tst r0, #0x800
	beq _0216FB74
_0216FAFC:
	ldrsh r1, [r2, #0x44]
	add r0, r1, #1
	strh r0, [r2, #0x44]
	cmp r1, #0x78
	blt _0216FB74
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _0216FB68
	ldr r2, [r4, #4]
	ldrb r1, [r2, #0x6b]
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	add r0, r0, #1
	and r0, r0, #0xff
	bic r1, r1, #2
	mov r0, r0, lsl #0x1f
	orr r0, r1, r0, lsr #30
	strb r0, [r2, #0x6b]
	ldr r0, [r4, #8]
	beq _0216FB5C
	mov r1, #4
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
	b _0216FB68
_0216FB5C:
	mov r1, #7
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
_0216FB68:
	ldr r0, [r4, #4]
	mov r1, #0x78
	strh r1, [r0, #0x44]
_0216FB74:
	ldr r0, _0216FC34 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x400
	bne _0216FC2C
	tst r0, #0x800
	bne _0216FC2C
	ldr r0, [r4, #8]
	mov r1, #7
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
	ldr r0, [r4, #4]
	ldrsh r0, [r0, #0x44]
	cmp r0, #0x78
	bne _0216FBEC
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _0216FBCC
	ldr r0, [r4, #8]
	mov r1, #0x12
	strh r1, [r0, #0xc]
	b _0216FC24
_0216FBCC:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _0216FC24
	ldr r0, [r4, #8]
	mov r1, #0x15
	strh r1, [r0, #0xc]
	b _0216FC24
_0216FBEC:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _0216FC0C
	ldr r0, [r4, #8]
	mov r1, #6
	strh r1, [r0, #0xc]
	b _0216FC24
_0216FC0C:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	ldreq r0, [r4, #8]
	moveq r1, #7
	streqh r1, [r0, #0xc]
_0216FC24:
	bl exPlayerAdminTask__Func_216FC38
	ldmia sp!, {r4, pc}
_0216FC2C:
	bl exPlayerAdminTask__HandleControl
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FC34: .word padInput
	arm_func_end exPlayerAdminTask__Func_216FAAC

	arm_func_start exPlayerAdminTask__Func_216FC38
exPlayerAdminTask__Func_216FC38: // 0x0216FC38
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov ip, #0xe
	sub r1, ip, #0xf
	ldr r2, [r4, #4]
	mov r0, #0
	strh r0, [r2, #0x44]
	stmia sp, {r0, ip}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exEffectBarrierTask__Create
	ldr r0, [r4, #8]
	mov r1, #8
	add r0, r0, #4
	bl exPlayerAdminTask__SetSuperSonicAnimation
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r0, [r4, #8]
	mov r1, #0x2000
	str r1, [r0, #0x13c]
	bl GetExTaskCurrent
	ldr r1, _0216FCB8 // =exPlayerAdminTask__Func_216FCBC
	str r1, [r0]
	bl exPlayerAdminTask__Func_216FCBC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FCB8: .word exPlayerAdminTask__Func_216FCBC
	arm_func_end exPlayerAdminTask__Func_216FC38

	arm_func_start exPlayerAdminTask__Func_216FCBC
exPlayerAdminTask__Func_216FCBC: // 0x0216FCBC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0216FCF4
	ldr r0, [r4, #8]
	mov r1, #0x1000
	str r1, [r0, #0x13c]
	bl exPlayerAdminTask__Func_216FD10
	ldmia sp!, {r4, pc}
_0216FCF4:
	bl exPlayerAdminTask__Func_217035C
	cmp r0, #0
	bne _0216FD08
	bl exPlayerAdminTask__HandleMovement
	bl exPlayerAdminTask__Func_2170CC4
_0216FD08:
	bl exPlayerAdminTask__HandleControl
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__Func_216FCBC

	arm_func_start exPlayerAdminTask__Func_216FD10
exPlayerAdminTask__Func_216FD10: // 0x0216FD10
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #8]
	mov r1, #9
	add r0, r0, #4
	bl exPlayerAdminTask__SetSuperSonicAnimation
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r1, [r4, #4]
	ldrb r0, [r1, #0x6b]
	bic r0, r0, #1
	strb r0, [r1, #0x6b]
	bl GetExTaskCurrent
	ldr r1, _0216FD5C // =exPlayerAdminTask__Func_216FD60
	str r1, [r0]
	bl exPlayerAdminTask__Func_216FD60
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FD5C: .word exPlayerAdminTask__Func_216FD60
	arm_func_end exPlayerAdminTask__Func_216FD10

	arm_func_start exPlayerAdminTask__Func_216FD60
exPlayerAdminTask__Func_216FD60: // 0x0216FD60
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	bl exPlayerAdminTask__HandlePlayerSwap
	bl exPlayerAdminTask__Func_2170548
	cmp r0, #0
	beq _0216FD88
	bl exPlayerAdminTask__Func_216FDD4
	ldmia sp!, {r4, pc}
_0216FD88:
	ldr r0, [r4, #8]
	add r0, r0, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _0216FDB4
	bl exPlayerAdminTask__Func_216FDD4
	bl GetExTaskCurrent
	ldr r1, _0216FDD0 // =exPlayerAdminTask__Main_216E70C
	str r1, [r0]
	bl exPlayerAdminTask__Main_216E70C
	ldmia sp!, {r4, pc}
_0216FDB4:
	bl exPlayerAdminTask__Func_217035C
	cmp r0, #0
	bne _0216FDC8
	bl exPlayerAdminTask__HandleMovement
	bl exPlayerAdminTask__Func_2170CC4
_0216FDC8:
	bl exPlayerAdminTask__HandleControl
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FDD0: .word exPlayerAdminTask__Main_216E70C
	arm_func_end exPlayerAdminTask__Func_216FD60

	arm_func_start exPlayerAdminTask__Func_216FDD4
exPlayerAdminTask__Func_216FDD4: // 0x0216FDD4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #8]
	ldrh r1, [r0, #2]
	add r0, r0, #4
	bl exPlayerAdminTask__SetSuperSonicAnimation
	ldr r0, [r4, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__Func_216FDD4

	arm_func_start exPlayerAdminTask__Action_ShootFireball
exPlayerAdminTask__Action_ShootFireball: // 0x0216FE00
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r2, [r4, #4]
	mov r1, #6
	ldrb r0, [r2, #0x6b]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #0x6b]
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exExEffectBlzFireTaMeTask__Create
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exEffectBlzFireTask__Create
	bl GetExTaskCurrent
	ldr r1, _0216FE68 // =exPlayerAdminTask__Func_216FE6C
	str r1, [r0]
	bl exPlayerAdminTask__Func_216FE6C
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FE68: .word exPlayerAdminTask__Func_216FE6C
	arm_func_end exPlayerAdminTask__Action_ShootFireball

	arm_func_start exPlayerAdminTask__Func_216FE6C
exPlayerAdminTask__Func_216FE6C: // 0x0216FE6C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0xc]
	mov r1, #7
	add r0, r0, #4
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	bl GetExTaskCurrent
	ldr r1, _0216FEA8 // =exPlayerAdminTask__Func_216FEAC
	str r1, [r0]
	bl exPlayerAdminTask__Func_216FEAC
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216FEA8: .word exPlayerAdminTask__Func_216FEAC
	arm_func_end exPlayerAdminTask__Func_216FE6C

	arm_func_start exPlayerAdminTask__Func_216FEAC
exPlayerAdminTask__Func_216FEAC: // 0x0216FEAC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	bl exPlayerAdminTask__Func_217035C
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	bl exPlayerAdminTask__HandleMovement
	bl exPlayerAdminTask__Func_2170CC4
	ldr r2, [r4, #4]
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1f
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0217007C
	ldr r0, _02170084 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x400
	bne _0216FF00
	tst r0, #0x800
	beq _0216FF78
_0216FF00:
	ldrsh r1, [r2, #0x46]
	add r0, r1, #1
	strh r0, [r2, #0x46]
	cmp r1, #0x78
	blt _0216FF78
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _0216FF6C
	ldr r2, [r4, #4]
	ldrb r1, [r2, #0x6b]
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	add r0, r0, #1
	and r0, r0, #0xff
	bic r1, r1, #2
	mov r0, r0, lsl #0x1f
	orr r0, r1, r0, lsr #30
	strb r0, [r2, #0x6b]
	ldr r0, [r4, #0xc]
	beq _0216FF60
	mov r1, #4
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
	b _0216FF6C
_0216FF60:
	mov r1, #7
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
_0216FF6C:
	ldr r0, [r4, #4]
	mov r1, #0x78
	strh r1, [r0, #0x46]
_0216FF78:
	ldr r0, _02170084 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x400
	bne _0217007C
	tst r0, #0x800
	bne _0217007C
	ldr r0, [r4, #0xc]
	mov r1, #7
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21642F0
	ldr r0, [r4, #4]
	ldrsh r0, [r0, #0x46]
	cmp r0, #0x50
	ble _0216FFF0
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _0216FFD0
	ldr r0, [r4, #0xc]
	mov r1, #0xf
	strh r1, [r0, #0xc]
	b _02170074
_0216FFD0:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _02170074
	ldr r0, [r4, #0xc]
	mov r1, #0x10
	strh r1, [r0, #0xc]
	b _02170074
_0216FFF0:
	bgt _02170074
	cmp r0, #0x28
	bgt _0217003C
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _0217001C
	ldr r0, [r4, #0xc]
	mov r1, #3
	strh r1, [r0, #0xc]
	b _02170074
_0217001C:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _02170074
	ldr r0, [r4, #0xc]
	mov r1, #4
	strh r1, [r0, #0xc]
	b _02170074
_0217003C:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _0217005C
	ldr r0, [r4, #0xc]
	mov r1, #6
	strh r1, [r0, #0xc]
	b _02170074
_0217005C:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	ldreq r0, [r4, #0xc]
	moveq r1, #7
	streqh r1, [r0, #0xc]
_02170074:
	bl exPlayerAdminTask__Func_2170088
	ldmia sp!, {r4, pc}
_0217007C:
	bl exPlayerAdminTask__HandleControl
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170084: .word padInput
	arm_func_end exPlayerAdminTask__Func_216FEAC

	arm_func_start exPlayerAdminTask__Func_2170088
exPlayerAdminTask__Func_2170088: // 0x02170088
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #4]
	mov r1, #0
	strh r1, [r0, #0x46]
	ldr r0, [r4, #0xc]
	mov r1, #8
	add r0, r0, #4
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _021700D0 // =exPlayerAdminTask__Func_21700D4
	str r1, [r0]
	bl exPlayerAdminTask__Func_21700D4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021700D0: .word exPlayerAdminTask__Func_21700D4
	arm_func_end exPlayerAdminTask__Func_2170088

	arm_func_start exPlayerAdminTask__Func_21700D4
exPlayerAdminTask__Func_21700D4: // 0x021700D4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r0, [r4, #0xc]
	ldr r0, [r0, #0x348]
	ldr r0, [r0, #0]
	cmp r0, #0x5000
	blt _02170218
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _02170180
	ldr r0, [r4, #0xc]
	ldrsh r0, [r0, #0xc]
	cmp r0, #0xf
	bne _0217013C
	mov ip, #0x23
	sub r1, ip, #0x24
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _02170200
_0217013C:
	cmp r0, #6
	mov r0, #0
	bne _02170164
	mov ip, #0x22
	sub r1, ip, #0x23
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _02170200
_02170164:
	mov ip, #0x21
	sub r1, ip, #0x22
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _02170200
_02170180:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	bne _02170200
	ldr r0, [r4, #0xc]
	ldrsh r0, [r0, #0xc]
	cmp r0, #0x10
	bne _021701C0
	mov ip, #0x23
	sub r1, ip, #0x24
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _02170200
_021701C0:
	cmp r0, #7
	mov r0, #0
	bne _021701E8
	mov ip, #0x22
	sub r1, ip, #0x23
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	b _02170200
_021701E8:
	mov ip, #0x21
	sub r1, ip, #0x22
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
_02170200:
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exEffectBlzFireShotTask__Create
	bl GetExTaskCurrent
	ldr r1, _02170238 // =exPlayerAdminTask__Func_217023C
	str r1, [r0]
_02170218:
	bl exPlayerAdminTask__Func_217035C
	cmp r0, #0
	bne _0217022C
	bl exPlayerAdminTask__HandleMovement
	bl exPlayerAdminTask__Func_2170CC4
_0217022C:
	bl exPlayerAdminTask__HandleControl
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170238: .word exPlayerAdminTask__Func_217023C
	arm_func_end exPlayerAdminTask__Func_21700D4

	arm_func_start exPlayerAdminTask__Func_217023C
exPlayerAdminTask__Func_217023C: // 0x0217023C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02170268
	bl exPlayerAdminTask__Func_2170284
	ldmia sp!, {r4, pc}
_02170268:
	bl exPlayerAdminTask__Func_217035C
	cmp r0, #0
	bne _0217027C
	bl exPlayerAdminTask__HandleMovement
	bl exPlayerAdminTask__Func_2170CC4
_0217027C:
	bl exPlayerAdminTask__HandleControl
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__Func_217023C

	arm_func_start exPlayerAdminTask__Func_2170284
exPlayerAdminTask__Func_2170284: // 0x02170284
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0xc]
	mov r1, #9
	add r0, r0, #4
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	bl GetExTaskCurrent
	ldr r1, _021702C0 // =exPlayerAdminTask__Func_21702C4
	str r1, [r0]
	bl exPlayerAdminTask__Func_21702C4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021702C0: .word exPlayerAdminTask__Func_21702C4
	arm_func_end exPlayerAdminTask__Func_2170284

	arm_func_start exPlayerAdminTask__Func_21702C4
exPlayerAdminTask__Func_21702C4: // 0x021702C4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exPlayerAdminTask__Func_2171624
	ldr r0, [r4, #0xc]
	add r0, r0, #4
	bl exDrawReqTask__Model__IsAnimFinished
	cmp r0, #0
	beq _02170300
	bl exPlayerAdminTask__Func_2170320
	bl GetExTaskCurrent
	ldr r1, _0217031C // =exPlayerAdminTask__Main_216E70C
	str r1, [r0]
	bl exPlayerAdminTask__Main_216E70C
	ldmia sp!, {r4, pc}
_02170300:
	bl exPlayerAdminTask__Func_217035C
	cmp r0, #0
	bne _02170314
	bl exPlayerAdminTask__HandleMovement
	bl exPlayerAdminTask__Func_2170CC4
_02170314:
	bl exPlayerAdminTask__HandleControl
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217031C: .word exPlayerAdminTask__Main_216E70C
	arm_func_end exPlayerAdminTask__Func_21702C4

	arm_func_start exPlayerAdminTask__Func_2170320
exPlayerAdminTask__Func_2170320: // 0x02170320
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r1, [r4, #4]
	ldrb r0, [r1, #0x6b]
	bic r0, r0, #1
	strb r0, [r1, #0x6b]
	ldr r0, [r4, #0xc]
	ldrh r1, [r0, #2]
	add r0, r0, #4
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r4, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__Func_2170320

	arm_func_start exPlayerAdminTask__Func_217035C
exPlayerAdminTask__Func_217035C: // 0x0217035C
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	ldr r2, [r0, #4]
	ldrsh r1, [r2, #0x20]
	cmp r1, #0
	bgt _02170454
	ldr r0, [r0, #0x10]
	ldrb r0, [r0, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	beq _021703E4
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	mov r0, #0
	bne _021703BC
	mov ip, #0xf3
	sub r1, ip, #0xf4
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlayVoiceClipEx
	b _021703D4
_021703BC:
	mov ip, #0xfc
	sub r1, ip, #0xfd
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlayVoiceClipEx
_021703D4:
	bl exPlayerAdminTask__Func_216F704
	add sp, sp, #8
	mov r0, #1
	ldmia sp!, {r3, pc}
_021703E4:
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	beq _0217050C
	ldrsh r0, [r2, #0x3c]
	cmp r0, #0
	bgt _02170444
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	mov r0, #0
	bne _0217042C
	mov ip, #0xf3
	sub r1, ip, #0xf4
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlayVoiceClipEx
	b _02170444
_0217042C:
	mov ip, #0xfc
	sub r1, ip, #0xfd
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlayVoiceClipEx
_02170444:
	bl exPlayerAdminTask__Func_216F184
	add sp, sp, #8
	mov r0, #1
	ldmia sp!, {r3, pc}
_02170454:
	ldrb r1, [r2, #0x6a]
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	cmp r1, #1
	bne _021704EC
	ldrsh r1, [r2, #0x3c]
	cmp r1, #0
	bgt _0217050C
	ldr r0, [r0, #0x10]
	ldrb r0, [r0, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	beq _021704B4
	mov ip, #0xfc
	sub r1, ip, #0xfd
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlayVoiceClipEx
	bl exPlayerAdminTask__Func_216F704
	add sp, sp, #8
	mov r0, #1
	ldmia sp!, {r3, pc}
_021704B4:
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	beq _0217050C
	mov ip, #0xfc
	sub r1, ip, #0xfd
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlayVoiceClipEx
	bl exPlayerAdminTask__Func_216F184
	add sp, sp, #8
	mov r0, #1
	ldmia sp!, {r3, pc}
_021704EC:
	ldr r2, [r0, #0x10]
	ldrb r1, [r2, #6]
	bic r1, r1, #2
	strb r1, [r2, #6]
	ldr r1, [r0, #0x10]
	ldrb r0, [r1, #6]
	orr r0, r0, #8
	strb r0, [r1, #6]
_0217050C:
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	arm_func_end exPlayerAdminTask__Func_217035C

	arm_func_start exPlayerAdminTask__Func_2170518
exPlayerAdminTask__Func_2170518: // 0x02170518
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	bl exPlayerAdminTask__HandleMovement
	bl exPlayerAdminTask__Func_2170CC4
	bl exPlayerAdminTask__HandlePlayerSwap
	bl exPlayerAdminTask__Func_2170548
	ldmia sp!, {r3, pc}
	arm_func_end exPlayerAdminTask__Func_2170518

	arm_func_start exPlayerAdminTask__Func_2170548
exPlayerAdminTask__Func_2170548: // 0x02170548
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #4]
	ldrb r0, [r0, #0x6a]
	mov r0, r0, lsl #0x1f
	movs r1, r0, lsr #0x1f
	bne _021705A0
	ldr r0, _021705D4 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x400
	bne _02170594
	tst r0, #0x800
	beq _021705A0
_02170594:
	bl exPlayerAdminTask__Action_CreateBarrier
	mov r0, #1
	ldmia sp!, {r4, pc}
_021705A0:
	cmp r1, #1
	bne _021705CC
	ldr r0, _021705D4 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x400
	bne _021705C0
	tst r0, #0x800
	beq _021705CC
_021705C0:
	bl exPlayerAdminTask__Action_ShootFireball
	mov r0, #1
	ldmia sp!, {r4, pc}
_021705CC:
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_021705D4: .word padInput
	arm_func_end exPlayerAdminTask__Func_2170548

	arm_func_start exPlayerAdminTask__Func_21705D8
exPlayerAdminTask__Func_21705D8: // 0x021705D8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, [r0, #4]
	ldrb r1, [r1, #0x6a]
	mov r1, r1, lsl #0x1f
	movs r1, r1, lsr #0x1f
	bne _02170618
	ldr r2, [r0, #8]
	add r1, r0, #0x2b8
	add r2, r2, #4
	str r2, [r0, #0x10]
	ldr r2, [r0, #0xc]
	add r2, r2, #4
	str r2, [r0, #0x14]
	str r1, [r0, #0x558]
	b _02170640
_02170618:
	cmp r1, #1
	bne _02170640
	ldr r2, [r0, #0xc]
	add r1, r0, #0x18
	add r2, r2, #4
	str r2, [r0, #0x10]
	ldr r2, [r0, #8]
	add r2, r2, #4
	str r2, [r0, #0x14]
	str r1, [r0, #0x558]
_02170640:
	ldr r1, [r0, #0x10]
	mov r2, #2
	strb r2, [r1]
	ldr r1, [r0, #0x14]
	mov r2, #3
	strb r2, [r1]
	ldr r0, [r0, #0x558]
	bl exDrawReqTask__Sprite3D__Animate
	ldmia sp!, {r3, pc}
	arm_func_end exPlayerAdminTask__Func_21705D8

	arm_func_start exPlayerAdminTask__HandleMovement
exPlayerAdminTask__HandleMovement: // 0x02170664
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r5, r0
	ldr r4, [r5, #0x10]
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r3, [r5, #4]
	ldrsh r0, [r3, #0x20]
	cmp r0, #0
	addgt sp, sp, #8
	ldmgtia sp!, {r4, r5, r6, r7, r8, pc}
	ldrb r1, [r3, #0x6a]
	mov r2, #0x1800
	ldr r0, _02170B64 // =padInput
	bic r1, r1, #8
	strb r1, [r3, #0x6a]
	ldr r3, [r5, #4]
	ldrb r1, [r3, #0x6a]
	bic r1, r1, #2
	strb r1, [r3, #0x6a]
	ldr r3, [r5, #4]
	ldrb r1, [r3, #0x6a]
	bic r1, r1, #0x10
	strb r1, [r3, #0x6a]
	ldr r3, [r5, #4]
	ldrb r1, [r3, #0x6a]
	bic r1, r1, #4
	strb r1, [r3, #0x6a]
	ldr r3, [r5, #4]
	ldrb r1, [r3, #0x6a]
	bic r1, r1, #0x20
	strb r1, [r3, #0x6a]
	ldr r1, [r5, #4]
	str r2, [r1, #8]
	ldr r1, [r5, #4]
	str r2, [r1, #0xc]
	ldrh r0, [r0, #0]
	tst r0, #0x20
	beq _02170744
	ldr r1, [r5, #4]
	ldrb r0, [r1, #0x6a]
	orr r0, r0, #8
	strb r0, [r1, #0x6a]
	ldr r0, [r5, #0x10]
	add r0, r0, #0x300
	ldrh r1, [r0, #0x4e]
	cmp r1, #0x6000
	subhi r1, r1, #0x16c
	strhih r1, [r0, #0x4e]
	movls r1, #0x6000
	strlsh r1, [r0, #0x4e]
	b _021707B8
_02170744:
	tst r0, #0x10
	beq _02170780
	ldr r1, [r5, #4]
	ldrb r0, [r1, #0x6a]
	orr r0, r0, #2
	strb r0, [r1, #0x6a]
	ldr r0, [r5, #0x10]
	add r0, r0, #0x300
	ldrh r1, [r0, #0x4e]
	cmp r1, #0xa000
	addlo r1, r1, #0x16c
	strloh r1, [r0, #0x4e]
	movhs r1, #0xa000
	strhsh r1, [r0, #0x4e]
	b _021707B8
_02170780:
	ldr r1, [r5, #0x10]
	ldr r0, _02170B68 // =0x00007F49
	add r1, r1, #0x300
	ldrh r2, [r1, #0x4e]
	cmp r2, r0
	addlo r0, r2, #0x2d8
	strloh r0, [r1, #0x4e]
	blo _021707B8
	ldr r0, _02170B6C // =0x000080B6
	cmp r2, r0
	subhi r0, r2, #0x2d8
	strhih r0, [r1, #0x4e]
	movls r0, #0x8000
	strlsh r0, [r1, #0x4e]
_021707B8:
	ldr r1, [r5, #0x14]
	ldr r0, _02170B68 // =0x00007F49
	add r1, r1, #0x300
	ldrh r2, [r1, #0x4e]
	cmp r2, r0
	addlo r0, r2, #0x2d8
	strloh r0, [r1, #0x4e]
	blo _021707F0
	ldr r0, _02170B6C // =0x000080B6
	cmp r2, r0
	subhi r0, r2, #0x2d8
	strhih r0, [r1, #0x4e]
	movls r0, #0x8000
	strlsh r0, [r1, #0x4e]
_021707F0:
	ldr r0, _02170B64 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x80
	beq _02170840
	ldr r1, [r5, #4]
	ldrb r0, [r1, #0x6a]
	orr r0, r0, #0x10
	strb r0, [r1, #0x6a]
	ldr r2, [r5, #4]
	ldrb r0, [r2, #0x6a]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _02170830
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _02170884
_02170830:
	ldrb r0, [r2, #0x6a]
	orr r0, r0, #0x20
	strb r0, [r2, #0x6a]
	b _02170884
_02170840:
	tst r0, #0x40
	beq _02170884
	ldr r1, [r5, #4]
	ldrb r0, [r1, #0x6a]
	orr r0, r0, #4
	strb r0, [r1, #0x6a]
	ldr r2, [r5, #4]
	ldrb r0, [r2, #0x6a]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _02170878
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _02170884
_02170878:
	ldrb r0, [r2, #0x6a]
	orr r0, r0, #0x20
	strb r0, [r2, #0x6a]
_02170884:
	ldr r6, [r5, #4]
	ldrb r0, [r6, #0x6a]
	mov r0, r0, lsl #0x1a
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _021709C0
	ldr r0, _02170B70 // =FX_SinCosTable_+0x800
	ldr r7, [r6, #8]
	ldrsh r8, [r0, #2]
	mov r0, r8
	bl _f_itof
	ldr r1, _02170B74 // =0x45800000
	bl _fdiv
	mov r1, #0
	bl _fgr
	mov r0, r8
	bls _021708F0
	bl _f_itof
	ldr r1, _02170B74 // =0x45800000
	bl _fdiv
	mov r1, r0
	ldr r0, _02170B74 // =0x45800000
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02170910
_021708F0:
	bl _f_itof
	ldr r1, _02170B74 // =0x45800000
	bl _fdiv
	mov r1, r0
	ldr r0, _02170B74 // =0x45800000
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02170910:
	bl _f_ftoi
	smull r2, r1, r0, r7
	adds r2, r2, #0x800
	ldr r0, _02170B70 // =FX_SinCosTable_+0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	ldrsh r8, [r0, #0]
	orr r2, r2, r1, lsl #20
	str r2, [r6, #8]
	ldr r6, [r5, #4]
	mov r0, r8
	ldr r7, [r6, #0xc]
	bl _f_itof
	ldr r1, _02170B74 // =0x45800000
	bl _fdiv
	mov r1, #0
	bl _fgr
	mov r0, r8
	bls _02170984
	bl _f_itof
	ldr r1, _02170B74 // =0x45800000
	bl _fdiv
	mov r1, r0
	ldr r0, _02170B74 // =0x45800000
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _021709A4
_02170984:
	bl _f_itof
	ldr r1, _02170B74 // =0x45800000
	bl _fdiv
	mov r1, r0
	ldr r0, _02170B74 // =0x45800000
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_021709A4:
	bl _f_ftoi
	smull r2, r1, r0, r7
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r6, #0xc]
_021709C0:
	ldr r0, _02170B64 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #2
	bne _021709D8
	tst r0, #1
	beq _02170AB8
_021709D8:
	ldr r1, [r5, #4]
	ldrb r0, [r1, #0x6b]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0
	strh r0, [r1, #0x20]
	ldr r1, [r5, #4]
	ldrb r1, [r1, #0x6a]
	mov r1, r1, lsl #0x1f
	movs r1, r1, lsr #0x1f
	bne _02170A40
	mov r4, #0xd
	sub r1, r4, #0xe
	stmia sp, {r0, r4}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r5, #4]
	mov r1, #8
	strh r1, [r0, #0x20]
	ldr r0, [r5, #8]
	add r0, r0, #4
	bl exSonDushEffectTask__Create
	b _02170A78
_02170A40:
	cmp r1, #1
	bne _02170A78
	mov r4, #0x1f
	sub r1, r4, #0x20
	stmia sp, {r0, r4}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	ldr r0, [r5, #4]
	mov r1, #6
	strh r1, [r0, #0x20]
	ldr r0, [r5, #0xc]
	add r0, r0, #4
	bl exBlzDushEffectTask__Create
_02170A78:
	ldr r0, [r5, #8]
	mov r1, #3
	add r0, r0, #4
	bl exPlayerAdminTask__SetSuperSonicAnimation
	ldr r0, [r5, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	ldr r0, [r5, #0xc]
	mov r1, #3
	add r0, r0, #4
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r5, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_21641F0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02170AB8:
	ldr r2, [r5, #4]
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02170AE0
	ldr r1, [r4, #0x350]
	ldr r0, [r2, #8]
	sub r0, r1, r0
	str r0, [r4, #0x350]
_02170AE0:
	ldr r2, [r5, #4]
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02170B08
	ldr r1, [r4, #0x350]
	ldr r0, [r2, #8]
	add r0, r1, r0
	str r0, [r4, #0x350]
_02170B08:
	ldr r2, [r5, #4]
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02170B30
	ldr r1, [r4, #0x354]
	ldr r0, [r2, #0xc]
	sub r0, r1, r0
	str r0, [r4, #0x354]
_02170B30:
	ldr r2, [r5, #4]
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [r4, #0x354]
	ldr r0, [r2, #0xc]
	add r0, r1, r0
	str r0, [r4, #0x354]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02170B64: .word padInput
_02170B68: .word 0x00007F49
_02170B6C: .word 0x000080B6
_02170B70: .word FX_SinCosTable_+0x800
_02170B74: .word 0x45800000
	arm_func_end exPlayerAdminTask__HandleMovement

	arm_func_start exPlayerAdminTask__HandlePlayerSwap
exPlayerAdminTask__HandlePlayerSwap: // 0x02170B78
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #4]
	ldrsh r0, [r0, #0x20]
	cmp r0, #0
	addgt sp, sp, #8
	ldmgtia sp!, {r4, pc}
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #4]
	ldrsh r0, [r1, #0x40]
	sub r0, r0, #1
	strh r0, [r1, #0x40]
	ldr r2, [r4, #4]
	ldrsh r0, [r2, #0x40]
	cmp r0, #0
	addgt sp, sp, #8
	ldmgtia sp!, {r4, pc}
	mov r0, #0
	ldr r1, _02170CC0 // =padInput
	strh r0, [r2, #0x40]
	ldrh r1, [r1, #4]
	tst r1, #0x100
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #4]
	mov r2, #0xf
	strh r2, [r1, #0x40]
	ldr r3, [r4, #4]
	ldrb r2, [r3, #0x6a]
	mov r1, r2, lsl #0x1f
	mov r1, r1, lsr #0x1f
	add r1, r1, #1
	and r1, r1, #0xff
	bic r2, r2, #1
	and r1, r1, #1
	orr r1, r2, r1
	strb r1, [r3, #0x6a]
	ldr r1, [r4, #4]
	ldrb r1, [r1, #0x6a]
	mov r1, r1, lsl #0x1f
	movs r1, r1, lsr #0x1f
	bne _02170C74
	mov ip, #0xf5
	sub r1, ip, #0xf6
	stmia sp, {r0, ip}
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	ldr r1, [r4, #0xc]
	ldr r0, [r4, #8]
	ldr r1, [r1, #0x354]
	str r1, [r0, #0x354]
	ldr r1, [r4, #0xc]
	ldr r0, [r4, #8]
	ldr r1, [r1, #0x358]
	str r1, [r0, #0x358]
	b _02170CB4
_02170C74:
	cmp r1, #1
	bne _02170CB4
	mov ip, #0xfe
	sub r1, ip, #0xff
	stmia sp, {r0, ip}
	mov r2, r1
	mov r3, r1
	bl PlayVoiceClipEx
	ldr r1, [r4, #8]
	ldr r0, [r4, #0xc]
	ldr r1, [r1, #0x354]
	str r1, [r0, #0x354]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0xc]
	ldr r1, [r1, #0x358]
	str r1, [r0, #0x358]
_02170CB4:
	bl exPlayerAdminTask__Func_21705D8
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02170CC0: .word padInput
	arm_func_end exPlayerAdminTask__HandlePlayerSwap

	arm_func_start exPlayerAdminTask__Func_2170CC4
exPlayerAdminTask__Func_2170CC4: // 0x02170CC4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetExTaskWorkCurrent_
	mov r5, r0
	ldr r2, [r5, #4]
	ldr r4, [r5, #0x10]
	ldrsh r1, [r2, #0x20]
	sub r0, r1, #1
	strh r0, [r2, #0x20]
	cmp r1, #0
	bgt _02170D10
	ldr r0, _02170FC4 // =0x02175E34
	mov r1, #2
	strh r1, [r0]
	mov r1, #1
	str r1, [r0, #4]
	ldr r0, [r5, #4]
	mov r1, #0
	strh r1, [r0, #0x20]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02170D10:
	ldr r1, [r5, #4]
	ldrsh r0, [r1, #0x20]
	cmp r0, #0
	bgt _02170D68
	ldrb r0, [r1, #0x6b]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	bne _02170D68
	ldr r0, [r5, #8]
	ldrh r1, [r0, #2]
	add r0, r0, #4
	bl exPlayerAdminTask__SetSuperSonicAnimation
	ldr r0, [r5, #8]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
	ldr r0, [r5, #0xc]
	ldrh r1, [r0, #2]
	add r0, r0, #4
	bl exPlayerHelpers__SetBurningBlazeAnimation
	ldr r0, [r5, #0xc]
	add r0, r0, #0x390
	bl exDrawReqTask__Func_2164218
_02170D68:
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r5, #4]
	mov r1, #0x3c00
	str r1, [r0, #8]
	ldr r0, [r5, #4]
	str r1, [r0, #0xc]
	ldr r6, [r5, #4]
	ldrb r0, [r6, #0x6a]
	mov r0, r0, lsl #0x1a
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02170EC8
	ldr r0, _02170FC8 // =FX_SinCosTable_+0x800
	ldr r7, [r6, #8]
	ldrsh r8, [r0, #2]
	mov r0, r8
	bl _f_itof
	ldr r1, _02170FCC // =0x45800000
	bl _fdiv
	mov r1, #0
	bl _fgr
	mov r0, r8
	bls _02170DF8
	bl _f_itof
	ldr r1, _02170FCC // =0x45800000
	bl _fdiv
	mov r1, r0
	ldr r0, _02170FCC // =0x45800000
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02170E18
_02170DF8:
	bl _f_itof
	ldr r1, _02170FCC // =0x45800000
	bl _fdiv
	mov r1, r0
	ldr r0, _02170FCC // =0x45800000
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02170E18:
	bl _f_ftoi
	smull r2, r1, r0, r7
	adds r2, r2, #0x800
	ldr r0, _02170FC8 // =FX_SinCosTable_+0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	ldrsh r8, [r0, #0]
	orr r2, r2, r1, lsl #20
	str r2, [r6, #8]
	ldr r6, [r5, #4]
	mov r0, r8
	ldr r7, [r6, #0xc]
	bl _f_itof
	ldr r1, _02170FCC // =0x45800000
	bl _fdiv
	mov r1, #0
	bl _fgr
	mov r0, r8
	bls _02170E8C
	bl _f_itof
	ldr r1, _02170FCC // =0x45800000
	bl _fdiv
	mov r1, r0
	ldr r0, _02170FCC // =0x45800000
	bl _f_mul
	mov r1, r0
	mov r0, #0x3f000000
	bl _fadd
	b _02170EAC
_02170E8C:
	bl _f_itof
	ldr r1, _02170FCC // =0x45800000
	bl _fdiv
	mov r1, r0
	ldr r0, _02170FCC // =0x45800000
	bl _f_mul
	mov r1, #0x3f000000
	bl _f_sub
_02170EAC:
	bl _f_ftoi
	smull r2, r1, r0, r7
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r6, #0xc]
_02170EC8:
	ldr r2, [r5, #4]
	ldrb r1, [r2, #0x6a]
	mov r0, r1, lsl #0x1c
	movs r3, r0, lsr #0x1f
	bne _02170F14
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _02170F14
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _02170F14
	mov r0, r1, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _02170F14
	ldr r1, [r4, #0x354]
	ldr r0, [r2, #0xc]
	add r0, r1, r0
	str r0, [r4, #0x354]
	b _02170FA4
_02170F14:
	cmp r3, #1
	bne _02170F2C
	ldr r1, [r4, #0x350]
	ldr r0, [r2, #8]
	sub r0, r1, r0
	str r0, [r4, #0x350]
_02170F2C:
	ldr r2, [r5, #4]
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02170F54
	ldr r1, [r4, #0x350]
	ldr r0, [r2, #8]
	add r0, r1, r0
	str r0, [r4, #0x350]
_02170F54:
	ldr r2, [r5, #4]
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02170F7C
	ldr r1, [r4, #0x354]
	ldr r0, [r2, #0xc]
	sub r0, r1, r0
	str r0, [r4, #0x354]
_02170F7C:
	ldr r2, [r5, #4]
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _02170FA4
	ldr r1, [r4, #0x354]
	ldr r0, [r2, #0xc]
	add r0, r1, r0
	str r0, [r4, #0x354]
_02170FA4:
	ldr r0, _02170FC4 // =0x02175E34
	ldrsh r2, [r0, #0]
	sub r1, r2, #1
	strh r1, [r0]
	cmp r2, #0
	movle r1, #2
	strleh r1, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02170FC4: .word 0x02175E34
_02170FC8: .word FX_SinCosTable_+0x800
_02170FCC: .word 0x45800000
	arm_func_end exPlayerAdminTask__Func_2170CC4

	arm_func_start exPlayerAdminTask__HandleControl
exPlayerAdminTask__HandleControl: // 0x02170FD0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #4]
	ldrb r0, [r0, #0x6b]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _02171034
	bl GetExSystemStatus
	ldrb r0, [r0, #2]
	cmp r0, #1
	bne _0217101C
	bl CheckExTimeGameplayIsTimeOver
	cmp r0, #0
	beq _0217101C
	bl ResetExTimeGameplayTimeOverFlag
	bl exPlayerAdminTask__Action_Die
	ldmia sp!, {r4, pc}
_0217101C:
	bl GetExSystemStatus
	ldrh r0, [r0, #6]
	cmp r0, #0
	bne _02171034
	bl exPlayerAdminTask__Action_Die
	ldmia sp!, {r4, pc}
_02171034:
	ldr r2, [r4, #4]
	ldrsh r1, [r2, #0x3e]
	sub r0, r1, #1
	strh r0, [r2, #0x3e]
	cmp r1, #0
	ble _021710D4
	ldr r1, [r4, #0x10]
	ldrb r0, [r1, #6]
	orr r0, r0, #8
	strb r0, [r1, #6]
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02171118
	ldr r2, [r4, #4]
	ldrb r1, [r2, #0x6a]
	mov r0, r1, lsl #0x19
	movs r0, r0, lsr #0x1f
	add r0, r0, #1
	and r0, r0, #0xff
	bic r1, r1, #0x40
	mov r0, r0, lsl #0x1f
	orr r0, r1, r0, lsr #25
	strb r0, [r2, #0x6a]
	ldr r1, [r4, #0x10]
	ldrb r0, [r1, #0x38c]
	beq _021710B8
	orr r0, r0, #4
	strb r0, [r1, #0x38c]
	ldr r1, [r4, #0x14]
	ldrb r0, [r1, #0x38c]
	orr r0, r0, #4
	strb r0, [r1, #0x38c]
	b _02171118
_021710B8:
	bic r0, r0, #4
	strb r0, [r1, #0x38c]
	ldr r1, [r4, #0x14]
	ldrb r0, [r1, #0x38c]
	bic r0, r0, #4
	strb r0, [r1, #0x38c]
	b _02171118
_021710D4:
	ldr r2, [r4, #0x10]
	mov r1, #0
	ldrb r0, [r2, #0x38c]
	bic r0, r0, #4
	strb r0, [r2, #0x38c]
	ldr r2, [r4, #0x14]
	ldrb r0, [r2, #0x38c]
	bic r0, r0, #4
	strb r0, [r2, #0x38c]
	ldr r0, [r4, #4]
	strh r1, [r0, #0x3e]
	bl exBossHelpers__Func_2154C28
	cmp r0, #1
	bne _02171118
	bl GetExTaskCurrent
	ldr r1, _021715EC // =exPlayerAdminTask__Func_216E7F4
	str r1, [r0]
_02171118:
	ldr r0, [r4, #0x10]
	add r1, r0, #0x38c
	bl exDrawReqTask__AddRequest
	ldr r1, [r4, #0x10]
	ldr r0, [r4, #4]
	add r1, r1, #0x350
	str r1, [r0, #4]
	ldr r2, [r4, #4]
	ldrb r1, [r2, #0x6a]
	mov r0, r1, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	movne r0, r1, lsl #0x1e
	movne r0, r0, lsr #0x1f
	cmpne r0, #1
	movne r0, r1, lsl #0x1b
	movne r0, r0, lsr #0x1f
	cmpne r0, #1
	movne r0, r1, lsl #0x1d
	movne r0, r0, lsr #0x1f
	cmpne r0, #1
	bne _02171310
	ldrsh r0, [r2, #0x3e]
	cmp r0, #0
	bgt _021711F8
	ldr lr, [r4, #0x14]
	ldr r0, [r4, #0x10]
	ldr ip, [lr, #0x350]
	ldr r0, [r0, #0x350]
	mov r1, #0x800
	sub r2, r0, ip
	mov r0, r2, asr #0x1f
	mov r0, r0, lsl #9
	adds r3, r1, r2, lsl #9
	orr r0, r0, r2, lsr #23
	adc r0, r0, #0
	mov r2, r3, lsr #0xc
	orr r2, r2, r0, lsl #20
	add r0, ip, r2
	str r0, [lr, #0x350]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r2, [r2, #0x354]
	ldr lr, [r0, #0x354]
	sub r2, r2, #0x5000
	sub r3, r2, lr
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #9
	adds ip, r1, r3, lsl #9
	orr r2, r2, r3, lsr #23
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, lr, r2
	str r1, [r0, #0x354]
	b _02171420
_021711F8:
	ldrb r0, [r2, #0x6a]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	bne _02171288
	ldr r1, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r1, [r1, #0x350]
	ldr lr, [r0, #0x350]
	add r1, r1, #0x5000
	sub r2, r1, lr
	mov r1, r2, asr #0x1f
	mov r3, r1, lsl #9
	mov r1, #0x800
	adds ip, r1, r2, lsl #9
	orr r3, r3, r2, lsr #23
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, lr, r3
	str r2, [r0, #0x350]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r2, [r2, #0x354]
	ldr lr, [r0, #0x354]
	sub r2, r2, #0x5000
	sub r3, r2, lr
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #9
	adds ip, r1, r3, lsl #9
	orr r2, r2, r3, lsr #23
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, lr, r2
	str r1, [r0, #0x354]
	b _02171420
_02171288:
	cmp r0, #1
	bne _02171420
	ldr r1, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r1, [r1, #0x350]
	ldr lr, [r0, #0x350]
	sub r1, r1, #0x5000
	sub r2, r1, lr
	mov r1, r2, asr #0x1f
	mov r3, r1, lsl #9
	mov r1, #0x800
	adds ip, r1, r2, lsl #9
	orr r3, r3, r2, lsr #23
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, lr, r3
	str r2, [r0, #0x350]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r2, [r2, #0x354]
	ldr lr, [r0, #0x354]
	sub r2, r2, #0x5000
	sub r3, r2, lr
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #9
	adds ip, r1, r3, lsl #9
	orr r2, r2, r3, lsr #23
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, lr, r2
	str r1, [r0, #0x354]
	b _02171420
_02171310:
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	bne _0217139C
	ldr r1, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r1, [r1, #0x350]
	ldr lr, [r0, #0x350]
	add r1, r1, #0x5000
	sub r2, r1, lr
	mov r1, r2, asr #0x1f
	mov r3, r1, lsl #9
	mov r1, #0x800
	adds ip, r1, r2, lsl #9
	orr r3, r3, r2, lsr #23
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, lr, r3
	str r2, [r0, #0x350]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r2, [r2, #0x354]
	ldr lr, [r0, #0x354]
	sub r2, r2, #0x5000
	sub r3, r2, lr
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #9
	adds ip, r1, r3, lsl #9
	orr r2, r2, r3, lsr #23
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, lr, r2
	str r1, [r0, #0x354]
	b _02171420
_0217139C:
	cmp r0, #1
	bne _02171420
	ldr r1, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r1, [r1, #0x350]
	ldr lr, [r0, #0x350]
	sub r1, r1, #0x5000
	sub r2, r1, lr
	mov r1, r2, asr #0x1f
	mov r3, r1, lsl #9
	mov r1, #0x800
	adds ip, r1, r2, lsl #9
	orr r3, r3, r2, lsr #23
	adc r2, r3, #0
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, lr, r3
	str r2, [r0, #0x350]
	ldr r2, [r4, #0x10]
	ldr r0, [r4, #0x14]
	ldr r2, [r2, #0x354]
	ldr lr, [r0, #0x354]
	sub r2, r2, #0x5000
	sub r3, r2, lr
	mov r2, r3, asr #0x1f
	mov r2, r2, lsl #9
	adds ip, r1, r3, lsl #9
	orr r2, r2, r3, lsr #23
	adc r1, r2, #0
	mov r2, ip, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, lr, r2
	str r1, [r0, #0x354]
_02171420:
	ldr r1, [r4, #4]
	ldrsh r0, [r1, #0x3e]
	cmp r0, #0
	bgt _0217145C
	ldrb r0, [r1, #0x6b]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _0217145C
	ldr r0, [r4, #0x10]
	mov r1, #0x3c000
	str r1, [r0, #0x358]
	ldr r0, [r4, #0x14]
	mov r1, #0x32000
	str r1, [r0, #0x358]
_0217145C:
	ldr r1, [r4, #4]
	ldrb r0, [r1, #0x6a]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _02171484
	ldrb r0, [r1, #0x6b]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _021715D0
_02171484:
	ldr r1, [r4, #0x14]
	ldr r0, [r4, #0x558]
	ldr r1, [r1, #0x350]
	str r1, [r0, #0x12c]
	ldr r1, [r4, #0x14]
	ldr r0, [r4, #0x558]
	ldr r1, [r1, #0x354]
	str r1, [r0, #0x130]
	ldr r1, [r4, #0x14]
	ldr r0, [r4, #0x558]
	ldr r1, [r1, #0x358]
	str r1, [r0, #0x134]
	ldr r0, [r4, #4]
	ldrb r0, [r0, #0x6b]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _021714DC
	ldr r0, [r4, #0x558]
	add r1, r0, #0x150
	bl exDrawReqTask__AddRequest
	b _021714E8
_021714DC:
	ldr r0, [r4, #0x14]
	add r1, r0, #0x38c
	bl exDrawReqTask__AddRequest
_021714E8:
	ldr r1, [r4, #4]
	ldrb r2, [r1, #0x6a]
	mov r0, r2, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	movne r0, r2, lsl #0x1e
	movne r0, r0, lsr #0x1f
	cmpne r0, #1
	ldrsh r0, [r1, #0x20]
	bne _02171574
	cmp r0, #0
	ldrb r1, [r1, #0x6a]
	ldr r3, [r4, #0x10]
	bgt _02171540
	add r0, r4, #0x15c
	mov r2, r1, lsl #0x1f
	add r1, r3, #0x350
	mov r3, r2, lsr #0x1f
	add r0, r0, #0x400
	mov r2, #1
	bl exDrawReqTask__Trail__HandleTrail
	b _0217155C
_02171540:
	add r0, r4, #0x15c
	mov r2, r1, lsl #0x1f
	add r1, r3, #0x350
	mov r3, r2, lsr #0x1f
	add r0, r0, #0x400
	mov r2, #3
	bl exDrawReqTask__Trail__HandleTrail
_0217155C:
	add r0, r4, #0x15c
	add r1, r4, #0x3c8
	add r0, r0, #0x400
	add r1, r1, #0x400
	bl exDrawReqTask__AddRequest
	b _021715DC
_02171574:
	cmp r0, #0
	ldr r1, [r4, #0x10]
	add r0, r4, #0x15c
	bgt _021715A0
	mov r2, r2, lsl #0x1f
	mov r3, r2, lsr #0x1f
	add r0, r0, #0x400
	add r1, r1, #0x350
	mov r2, #0
	bl exDrawReqTask__Trail__HandleTrail
	b _021715B8
_021715A0:
	mov r2, r2, lsl #0x1f
	mov r3, r2, lsr #0x1f
	add r0, r0, #0x400
	add r1, r1, #0x350
	mov r2, #2
	bl exDrawReqTask__Trail__HandleTrail
_021715B8:
	add r0, r4, #0x15c
	add r1, r4, #0x3c8
	add r0, r0, #0x400
	add r1, r1, #0x400
	bl exDrawReqTask__AddRequest
	b _021715DC
_021715D0:
	ldr r0, [r4, #0x14]
	add r1, r0, #0x38c
	bl exDrawReqTask__AddRequest
_021715DC:
	ldr r0, [r4, #0x10]
	add r0, r0, #0x350
	bl exPlayerScreenMoveTask__SetFollowX
	ldmia sp!, {r4, pc}
	.align 2, 0
_021715EC: .word exPlayerAdminTask__Func_216E7F4
	arm_func_end exPlayerAdminTask__HandleControl

	arm_func_start exPlayerAdminTask__DelayCallback
exPlayerAdminTask__DelayCallback: // 0x021715F0
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0x10]
	add r1, r0, #0x38c
	bl exDrawReqTask__AddRequest
	ldr r0, [r4, #0x558]
	add r1, r0, #0x150
	bl exDrawReqTask__AddRequest
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__DelayCallback

	arm_func_start exPlayerAdminTask__Func_2171624
exPlayerAdminTask__Func_2171624: // 0x02171624
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	ldr r0, [r4, #0x10]
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x14]
	bl exDrawReqTask__Model__Animate
	ldr r0, [r4, #0x558]
	bl exDrawReqTask__Sprite3D__Animate
	ldmia sp!, {r4, pc}
	arm_func_end exPlayerAdminTask__Func_2171624

	arm_func_start exPlayerAdminTask__Create
exPlayerAdminTask__Create: // 0x0217164C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _0217170C // =0x00000CD4
	str r4, [sp]
	ldr r0, _02171710 // =aExplayeradmint
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _02171714 // =exPlayerAdminTask__Main
	ldr r1, _02171718 // =exPlayerAdminTask__Destructor
	mov r2, #0x2000
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTask
	ldr r1, _0217171C // =exPlayerAdminTask__Func8
	str r1, [r0, #8]
	mov r0, r4
	bl GetExTask
	ldr r1, _02171720 // =exPlayerAdminTask__DelayCallback
	str r1, [r0, #0x10]
	mov r0, r4
	bl GetExTaskWork_
	ldr r2, _0217170C // =0x00000CD4
	mov r1, #0
	mov r4, r0
	bl MI_CpuFill8
	ldr r0, _02171724 // =exPlayerAdminTask__Unknown_21780F8
	mov r1, #0
	mov r2, #0x4e0
	bl MI_CpuFill8
	ldr r0, _02171728 // =exPlayerAdminTask__Unknown_2177C18
	mov r1, #0
	mov r2, #0x4e0
	bl MI_CpuFill8
	ldr r0, _0217172C // =exPlayerAdminTask__Unknown_2177BAC
	mov r1, #0
	mov r2, #0x6c
	bl MI_CpuFill8
	ldr r1, _02171724 // =exPlayerAdminTask__Unknown_21780F8
	ldr r0, _02171728 // =exPlayerAdminTask__Unknown_2177C18
	str r1, [r4, #8]
	str r0, [r4, #0xc]
	ldr r0, _0217172C // =exPlayerAdminTask__Unknown_2177BAC
	str r0, [r4, #4]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0217170C: .word 0x00000CD4
_02171710: .word aExplayeradmint
_02171714: .word exPlayerAdminTask__Main
_02171718: .word exPlayerAdminTask__Destructor
_0217171C: .word exPlayerAdminTask__Func8
_02171720: .word exPlayerAdminTask__DelayCallback
_02171724: .word exPlayerAdminTask__Unknown_21780F8
_02171728: .word exPlayerAdminTask__Unknown_2177C18
_0217172C: .word exPlayerAdminTask__Unknown_2177BAC
	arm_func_end exPlayerAdminTask__Create

	arm_func_start exPlayerAdminTask__Destroy_2171730
exPlayerAdminTask__Destroy_2171730: // 0x02171730
	stmdb sp!, {r3, lr}
	ldr r0, _02171754 // =exPlayerScreenMoveTask__dword_2177BA0
	ldr r0, [r0, #4]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _02171758 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02171754: .word exPlayerScreenMoveTask__dword_2177BA0
_02171758: .word ExTask_State_Destroy
	arm_func_end exPlayerAdminTask__Destroy_2171730

	arm_func_start exPlayerAdminTask__Func_217175C
exPlayerAdminTask__Func_217175C: // 0x0217175C
	ldr r0, _02171768 // =exPlayerScreenMoveTask__dword_2177BA0
	ldr r0, [r0, #0x10]
	bx lr
	.align 2, 0
_02171768: .word exPlayerScreenMoveTask__dword_2177BA0
	arm_func_end exPlayerAdminTask__Func_217175C

	arm_func_start exPlayerAdminTask__LoadSuperSonicAssets
exPlayerAdminTask__LoadSuperSonicAssets: // 0x0217176C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02171920 // =exPlayerAdminTask__word_21785D8
	mov r4, r0
	str r4, [r1, #0x34]
	bl exDrawReqTask__InitModel
	ldr r0, _02171920 // =exPlayerAdminTask__word_21785D8
	ldrsh r0, [r0, #2]
	cmp r0, #0
	bne _02171814
	mov r1, #3
	ldr r0, _02171924 // =aExtraExBb_10
	sub r2, r1, #4
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02171920 // =exPlayerAdminTask__word_21785D8
	mov r0, r5
	str r1, [r2, #0x30]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #2
	bl LoadExSystemFile
	ldr r1, _02171920 // =exPlayerAdminTask__word_21785D8
	str r0, [r1, #0x38]
	ldr r0, [r1, #0x30]
	bl NNS_G3dResDefaultSetup
	ldr r0, _02171920 // =exPlayerAdminTask__word_21785D8
	ldr r5, [r0, #0x30]
	mov r0, r5
	bl Asset3DSetup__GetTexSize
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02171920 // =exPlayerAdminTask__word_21785D8
	mov r0, r5
	str r1, [r2, #0x30]
	bl Asset3DSetup__GetTexture
	mov r0, r5
	bl _FreeHEAP_USER
_02171814:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #1
	ldr r0, _02171920 // =exPlayerAdminTask__word_21785D8
	str r3, [sp]
	ldr r1, [r0, #0x30]
	add r0, r4, #0x20
	mov r2, #0
	bl AnimatorMDL__SetResource
	mov r1, #0
	ldr r0, _02171920 // =exPlayerAdminTask__word_21785D8
	str r1, [sp]
	ldr r2, [r0, #0x38]
	mov r3, r1
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r4, #0x300
	mov r3, #0
	strh r3, [r0, #0x48]
	ldr r0, [r4, #0x104]
	mov r2, #1
	str r0, [r4, #0x344]
_02171870:
	mov r0, r2, lsl r3
	tst r0, #1
	beq _02171890
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02171890:
	add r3, r3, #1
	cmp r3, #5
	blo _02171870
	mov r3, #0
	strh r3, [r4, #0x1c]
	mov r0, #0x3c000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _02171928 // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _0217192C // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #2
	strb r0, [r4]
	ldrb r2, [r4, #3]
	mov r1, #0x2000
	add r0, r4, #0x350
	orr r2, r2, #8
	strb r2, [r4, #3]
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	str r3, [r4, #0x14]
	str r0, [r4, #0x18]
	ldrb r1, [r4, #0x38c]
	ldr r0, _02171920 // =exPlayerAdminTask__word_21785D8
	bic r1, r1, #3
	orr r1, r1, #1
	strb r1, [r4, #0x38c]
	ldrsh r1, [r0, #2]
	add r1, r1, #1
	strh r1, [r0, #2]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02171920: .word exPlayerAdminTask__word_21785D8
_02171924: .word aExtraExBb_10
_02171928: .word 0x0000BFF4
_0217192C: .word 0x00007FF8
	arm_func_end exPlayerAdminTask__LoadSuperSonicAssets

	arm_func_start exPlayerAdminTask__SetSuperSonicAnimation
exPlayerAdminTask__SetSuperSonicAnimation: // 0x02171930
	stmdb sp!, {r3, lr}
	ldr r2, _02171950 // =exPlayerAdminTask__word_21785D8
	str r1, [sp]
	ldr r1, [r2, #0x30]
	ldr r3, [r2, #0x38]
	mov r2, #0
	bl exPlayerHelpers__SetAnimationInternal
	ldmia sp!, {r3, pc}
	.align 2, 0
_02171950: .word exPlayerAdminTask__word_21785D8
	arm_func_end exPlayerAdminTask__SetSuperSonicAnimation

	arm_func_start exPlayerAdminTask__Func_2171954
exPlayerAdminTask__Func_2171954: // 0x02171954
	stmdb sp!, {r4, lr}
	ldr r1, _021719B8 // =exPlayerAdminTask__word_21785D8
	mov r4, r0
	ldrsh r0, [r1, #2]
	cmp r0, #1
	bne _02171998
	ldr r0, [r1, #0x30]
	cmp r0, #0
	beq _0217197C
	bl NNS_G3dResDefaultRelease
_0217197C:
	ldr r1, _021719B8 // =exPlayerAdminTask__word_21785D8
	ldr r0, [r1, #0x30]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r1, #0x30]
	beq _02171998
	bl _FreeHEAP_USER
_02171998:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _021719B8 // =exPlayerAdminTask__word_21785D8
	ldrsh r1, [r0, #2]
	cmp r1, #0
	subgt r1, r1, #1
	strgth r1, [r0, #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021719B8: .word exPlayerAdminTask__word_21785D8
	arm_func_end exPlayerAdminTask__Func_2171954

	arm_func_start exPlayerAdminTask__GetSonicAssets
exPlayerAdminTask__GetSonicAssets: // 0x021719BC
	ldr r0, _021719C8 // =exPlayerAdminTask__word_21785D8
	ldr r0, [r0, #0x34]
	bx lr
	.align 2, 0
_021719C8: .word exPlayerAdminTask__word_21785D8
	arm_func_end exPlayerAdminTask__GetSonicAssets

	arm_func_start exPlayerAdminTask__LoadSonicAssets
exPlayerAdminTask__LoadSonicAssets: // 0x021719CC
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02171B4C // =exPlayerAdminTask__word_21785D8
	mov r4, r0
	str r4, [r1, #8]
	bl exDrawReqTask__InitModel
	ldr r0, _02171B4C // =exPlayerAdminTask__word_21785D8
	ldrsh r0, [r0, #4]
	cmp r0, #0
	bne _02171A44
	mov r1, #5
	ldr r0, _02171B50 // =aExtraExBb_10
	sub r2, r1, #6
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02171B4C // =exPlayerAdminTask__word_21785D8
	mov r0, r5
	str r1, [r2, #0x2c]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #4
	bl LoadExSystemFile
	ldr r1, _02171B4C // =exPlayerAdminTask__word_21785D8
	str r0, [r1, #0x28]
	ldr r0, [r1, #0x2c]
	bl Asset3DSetup__Create
_02171A44:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #1
	ldr r0, _02171B4C // =exPlayerAdminTask__word_21785D8
	str r3, [sp]
	ldr r1, [r0, #0x2c]
	add r0, r4, #0x20
	mov r2, #0
	bl AnimatorMDL__SetResource
	mov r1, #0
	ldr r0, _02171B4C // =exPlayerAdminTask__word_21785D8
	str r1, [sp]
	ldr r2, [r0, #0x28]
	mov r3, r1
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r4, #0x300
	mov r3, #0
	strh r3, [r0, #0x48]
	ldr r0, [r4, #0x104]
	mov r2, #1
	str r0, [r4, #0x344]
_02171AA0:
	mov r0, r2, lsl r3
	tst r0, #1
	beq _02171AC0
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02171AC0:
	add r3, r3, #1
	cmp r3, #5
	blo _02171AA0
	mov r3, #0
	strh r3, [r4, #0x1c]
	mov r0, #0x3c000
	str r0, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _02171B54 // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _02171B58 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	mov r0, #2
	strb r0, [r4]
	ldrb r2, [r4, #3]
	add r1, r4, #0x350
	ldr r0, _02171B4C // =exPlayerAdminTask__word_21785D8
	orr r2, r2, #0x10
	strb r2, [r4, #3]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r1, [r4, #0x18]
	ldrb r1, [r4, #0x38c]
	bic r1, r1, #3
	orr r1, r1, #1
	strb r1, [r4, #0x38c]
	ldrsh r1, [r0, #4]
	add r1, r1, #1
	strh r1, [r0, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02171B4C: .word exPlayerAdminTask__word_21785D8
_02171B50: .word aExtraExBb_10
_02171B54: .word 0x0000BFF4
_02171B58: .word 0x00007FF8
	arm_func_end exPlayerAdminTask__LoadSonicAssets

	arm_func_start exPlayerAdminTask__SetSonicAnimation
exPlayerAdminTask__SetSonicAnimation: // 0x02171B5C
	stmdb sp!, {r3, lr}
	ldr r2, _02171B7C // =exPlayerAdminTask__word_21785D8
	str r1, [sp]
	ldr r1, [r2, #0x2c]
	ldr r3, [r2, #0x28]
	mov r2, #0
	bl exPlayerHelpers__SetAnimationInternal
	ldmia sp!, {r3, pc}
	.align 2, 0
_02171B7C: .word exPlayerAdminTask__word_21785D8
	arm_func_end exPlayerAdminTask__SetSonicAnimation

	arm_func_start exPlayerAdminTask__Func_2171B80
exPlayerAdminTask__Func_2171B80: // 0x02171B80
	stmdb sp!, {r4, lr}
	ldr r1, _02171BE4 // =exPlayerAdminTask__word_21785D8
	mov r4, r0
	ldrsh r0, [r1, #4]
	cmp r0, #1
	bne _02171BC4
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	beq _02171BA8
	bl NNS_G3dResDefaultRelease
_02171BA8:
	ldr r1, _02171BE4 // =exPlayerAdminTask__word_21785D8
	ldr r0, [r1, #0x2c]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r1, #0x2c]
	beq _02171BC4
	bl _FreeHEAP_USER
_02171BC4:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02171BE4 // =exPlayerAdminTask__word_21785D8
	ldrsh r1, [r0, #4]
	cmp r1, #0
	subgt r1, r1, #1
	strgth r1, [r0, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171BE4: .word exPlayerAdminTask__word_21785D8
	arm_func_end exPlayerAdminTask__Func_2171B80