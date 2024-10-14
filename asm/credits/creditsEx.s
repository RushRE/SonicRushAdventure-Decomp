	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CreditsEx__Create
CreditsEx__Create: // 0x02155EF0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r0, #1
	mov r1, #0
	bl CreditsCommon__Func_2154520
	mov r0, #0x2000
	mov r2, #0
	str r0, [sp]
	ldr r4, _02155F60 // =0x00000BBC
	ldr r0, _02155F64 // =CreditsEx__Main
	ldr r1, _02155F68 // =CreditsEx__Destructor
	mov r3, r2
	stmib sp, {r2, r4}
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02155F60 // =0x00000BBC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r1, #1
	mov r0, r4
	str r1, [r4, #0xc]
	bl TextCutscene__LoadAssets
	mov r0, #0x1a
	bl LoadSysSound
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02155F60: .word 0x00000BBC
_02155F64: .word CreditsEx__Main
_02155F68: .word CreditsEx__Destructor
	arm_func_end CreditsEx__Create

	arm_func_start CreditsEx__Destructor
CreditsEx__Destructor: // 0x02155F6C
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl ReleaseSysSound
	mov r0, r4
	bl CreditsCommon__Func_2155138
	mov r0, r4
	bl CreditsCommon__ReleaseAssets
	ldmia sp!, {r4, pc}
	arm_func_end CreditsEx__Destructor

	arm_func_start CreditsEx__Main
CreditsEx__Main: // 0x02155F90
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0xc]
	bl CreditsCommon__LoadCreditsBG
	mov r0, r4
	bl CreditsCommon__InitSprites
	bl CreditsCommon__Func_2155520
	ldr r2, _02155FDC // =CreditsCommon__Scroll_Screen1
	mov r0, #2
	mov r1, #0x800
	str r2, [r4, #0x10]
	bl CreateDrawFadeTask
	mov r0, #0x22
	mov r1, #1
	bl PlaySysTrack
	ldr r0, _02155FE0 // =CreditsEx__Main_2155FE4
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155FDC: .word CreditsCommon__Scroll_Screen1
_02155FE0: .word CreditsEx__Main_2155FE4
	arm_func_end CreditsEx__Main

	arm_func_start CreditsEx__Main_2155FE4
CreditsEx__Main_2155FE4: // 0x02155FE4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r1, #0xf0
	ldr r0, _02156018 // =CreditsEx__Main_215601C
	str r1, [r4, #0x34]
	mov r1, #0x3c
	str r1, [r4, #0x1c]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156018: .word CreditsEx__Main_215601C
	arm_func_end CreditsEx__Main_2155FE4

	arm_func_start CreditsEx__Main_215601C
CreditsEx__Main_215601C: // 0x0215601C
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x1c]
	ldmneia sp!, {r3, pc}
	ldr r1, _021560A8 // =renderCoreGFXControlA+0x00000020
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldr r1, _021560AC // =renderCoreGFXControlA
	ldr r0, _021560B0 // =CreditsEx__Main_21560B4
	ldrh r2, [r1, #0x20]
	bic r2, r2, #0xc0
	orr r2, r2, #0xc0
	strh r2, [r1, #0x20]
	ldrh r2, [r1, #0x20]
	bic r2, r2, #1
	orr r2, r2, #1
	strh r2, [r1, #0x20]
	ldrh r2, [r1, #0x20]
	bic r2, r2, #2
	strh r2, [r1, #0x20]
	ldrh r2, [r1, #0x20]
	bic r2, r2, #4
	strh r2, [r1, #0x20]
	ldrh r2, [r1, #0x20]
	bic r2, r2, #8
	strh r2, [r1, #0x20]
	ldrh r2, [r1, #0x20]
	bic r2, r2, #0x10
	strh r2, [r1, #0x20]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_021560A8: .word renderCoreGFXControlA+0x00000020
_021560AC: .word renderCoreGFXControlA
_021560B0: .word CreditsEx__Main_21560B4
	arm_func_end CreditsEx__Main_215601C

	arm_func_start CreditsEx__Main_21560B4
CreditsEx__Main_21560B4: // 0x021560B4
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x24]
	ldr r2, _02156104 // =renderCoreGFXControlA
	add r1, r1, #0x33
	add r1, r1, #0x300
	str r1, [r0, #0x24]
	cmp r1, #0x6000
	movlt r0, r1, asr #0xc
	strlth r0, [r2, #0x24]
	ldmltia sp!, {r3, pc}
	mov r1, #0x6000
	str r1, [r0, #0x24]
	mov r1, r1, asr #0xc
	strh r1, [r2, #0x24]
	mov r1, #0x5a
	str r1, [r0, #0x1c]
	ldr r0, _02156108 // =CreditsEx__Main_215610C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156104: .word renderCoreGFXControlA
_02156108: .word CreditsEx__Main_215610C
	arm_func_end CreditsEx__Main_21560B4

	arm_func_start CreditsEx__Main_215610C
CreditsEx__Main_215610C: // 0x0215610C
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x1c]
	ldmneia sp!, {r3, pc}
	mov r1, #0x1e
	str r1, [r0, #0x1c]
	mov r1, #0x3c
	str r1, [r0, #0x20]
	ldr r0, _02156144 // =CreditsEx__Main_2156148
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156144: .word CreditsEx__Main_2156148
	arm_func_end CreditsEx__Main_215610C

	arm_func_start CreditsEx__Main_2156148
CreditsEx__Main_2156148: // 0x02156148
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x10]
	cmp r1, #0
	beq _02156164
	blx r1
_02156164:
	ldr r0, [r4, #0x14]
	tst r0, #8
	beq _021561DC
	tst r0, #0x10
	bne _021561DC
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x1c]
	bne _021561DC
	ldr r0, [r4, #0x24]
	ldr r1, _0215621C // =renderCoreGFXControlA
	sub r0, r0, #0x33
	sub r0, r0, #0x300
	str r0, [r4, #0x24]
	cmp r0, #0
	movgt r0, r0, asr #0xc
	strgth r0, [r1, #0x24]
	bgt _021561DC
	mov r0, #0
	str r0, [r4, #0x24]
	mov r0, r0, asr #0xc
	strh r0, [r1, #0x24]
	ldr r0, [r4, #0x20]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x20]
	ldreq r0, [r4, #0x14]
	orreq r0, r0, #0x10
	streq r0, [r4, #0x14]
_021561DC:
	ldr r0, [r4, #0x14]
	tst r0, #0x20
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x34]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x34]
	ldmneia sp!, {r4, pc}
	mov r0, #0x3c
	bl NNS_SndPlayerStopSeqAll
	mov r0, #4
	mov r1, #0x800
	bl CreateDrawFadeTask
	ldr r0, _02156220 // =CreditsEx__Main_2156224
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_0215621C: .word renderCoreGFXControlA
_02156220: .word CreditsEx__Main_2156224
	arm_func_end CreditsEx__Main_2156148

	arm_func_start CreditsEx__Main_2156224
CreditsEx__Main_2156224: // 0x02156224
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x10]
	cmp r1, #0
	beq _0215623C
	blx r1
_0215623C:
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyDrawFadeTask
	ldr r0, _02156258 // =CreditsEx__Main_215625C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156258: .word CreditsEx__Main_215625C
	arm_func_end CreditsEx__Main_2156224

	arm_func_start CreditsEx__Main_215625C
CreditsEx__Main_215625C: // 0x0215625C
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #0x3c
	str r1, [r0, #0x34]
	ldr r0, _02156278 // =CreditsEx__Main_215627C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156278: .word CreditsEx__Main_215627C
	arm_func_end CreditsEx__Main_215625C

	arm_func_start CreditsEx__Main_215627C
CreditsEx__Main_215627C: // 0x0215627C
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x34]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x34]
	ldmneia sp!, {r3, pc}
	mov r0, #1
	bl CreditsCommon__NextEvent
	bl CreditsCommon__Cleanup
	ldmia sp!, {r3, pc}
	arm_func_end CreditsEx__Main_215627C
