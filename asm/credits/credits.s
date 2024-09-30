	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start Credits__Create
Credits__Create: // 0x02155974
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r0, #0
	mov r1, r0
	bl ovl05_2154520
	mov r0, #0x2000
	mov r2, #0
	str r0, [sp]
	ldr r4, _021559EC // =0x00000BBC
	ldr r0, _021559F0 // =Credits__Main
	ldr r1, _021559F4 // =Credits__Destructor
	mov r3, r2
	stmib sp, {r2, r4}
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021559EC // =0x00000BBC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0xc]
	bl TextCutscene__LoadAssets
	mov r0, r4
	bl WandRoom__Create
	mov r0, #0x1a
	bl LoadSysSound
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021559EC: .word 0x00000BBC
_021559F0: .word Credits__Main
_021559F4: .word Credits__Destructor
	arm_func_end Credits__Create

	arm_func_start Credits__Destructor
Credits__Destructor: // 0x021559F8
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl ReleaseSysSound
	mov r0, r4
	bl ovl05_2155138
	mov r0, r4
	bl ovl05_21549A4
	ldmia sp!, {r4, pc}
	arm_func_end Credits__Destructor

	arm_func_start Credits__Main
Credits__Main: // 0x02155A1C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0xc]
	bl ovl05_2154AE4
	mov r0, r4
	bl ovl05_2155034
	bl ovl05_2155520
	ldr r2, _02155A68 // =ovl05_2155600
	mov r0, #2
	mov r1, #0x800
	str r2, [r4, #0x10]
	bl CreateDrawFadeTask
	mov r0, #0x22
	mov r1, #1
	bl PlaySysTrack
	ldr r0, _02155A6C // =Task__OV05Unknown2155974__Main_2155A70
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155A68: .word ovl05_2155600
_02155A6C: .word Task__OV05Unknown2155974__Main_2155A70
	arm_func_end Credits__Main

	arm_func_start Task__OV05Unknown2155974__Main_2155A70
Task__OV05Unknown2155974__Main_2155A70: // 0x02155A70
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _02155A9C // =Task__OV05Unknown2155974__Main_2155AA0
	mov r1, #0x3c
	str r1, [r4, #0x1c]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155A9C: .word Task__OV05Unknown2155974__Main_2155AA0
	arm_func_end Task__OV05Unknown2155974__Main_2155A70

	arm_func_start Task__OV05Unknown2155974__Main_2155AA0
Task__OV05Unknown2155974__Main_2155AA0: // 0x02155AA0
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x1c]
	ldmneia sp!, {r3, pc}
	ldr r1, _02155B2C // =0x0213D2E0
	mov r0, #0
	mov r2, #6
	bl MIi_CpuClear16
	ldr r1, _02155B30 // =renderCoreGFXControlA
	ldr r0, _02155B34 // =Task__OV05Unknown2155974__Main_2155B38
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
_02155B2C: .word 0x0213D2E0
_02155B30: .word renderCoreGFXControlA
_02155B34: .word Task__OV05Unknown2155974__Main_2155B38
	arm_func_end Task__OV05Unknown2155974__Main_2155AA0

	arm_func_start Task__OV05Unknown2155974__Main_2155B38
Task__OV05Unknown2155974__Main_2155B38: // 0x02155B38
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x24]
	ldr r2, _02155B88 // =renderCoreGFXControlA
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
	ldr r0, _02155B8C // =Task__OV05Unknown2155974__Main_2155B90
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155B88: .word renderCoreGFXControlA
_02155B8C: .word Task__OV05Unknown2155974__Main_2155B90
	arm_func_end Task__OV05Unknown2155974__Main_2155B38

	arm_func_start Task__OV05Unknown2155974__Main_2155B90
Task__OV05Unknown2155974__Main_2155B90: // 0x02155B90
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
	ldr r0, _02155BC8 // =Task__OV05Unknown2155974__Main_2155BCC
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155BC8: .word Task__OV05Unknown2155974__Main_2155BCC
	arm_func_end Task__OV05Unknown2155974__Main_2155B90

	arm_func_start Task__OV05Unknown2155974__Main_2155BCC
Task__OV05Unknown2155974__Main_2155BCC: // 0x02155BCC
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x10]
	cmp r1, #0
	beq _02155BE8
	blx r1
_02155BE8:
	ldr r0, [r4, #0x14]
	tst r0, #8
	beq _02155C60
	tst r0, #0x10
	bne _02155C60
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x1c]
	bne _02155C60
	ldr r0, [r4, #0x24]
	ldr r1, _02155CA4 // =renderCoreGFXControlA
	sub r0, r0, #0x33
	sub r0, r0, #0x300
	str r0, [r4, #0x24]
	cmp r0, #0
	movgt r0, r0, asr #0xc
	strgth r0, [r1, #0x24]
	bgt _02155C60
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
_02155C60:
	ldr r0, [r4, #0x14]
	tst r0, #0x20
	ldmeqia sp!, {r4, pc}
	ldr r3, _02155CA8 // =0x04001000
	ldr r0, _02155CAC // =Task__OV05Unknown2155974__Main_2155CB0
	ldr r2, [r3, #0]
	ldr r1, [r3, #0]
	and r2, r2, #0x1f00
	mov ip, r2, lsr #8
	bic r2, r1, #0x1f00
	orr r1, ip, #2
	orr r1, r2, r1, lsl #8
	str r1, [r3]
	mov r1, #0
	str r1, [r4, #0x30]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155CA4: .word renderCoreGFXControlA
_02155CA8: .word 0x04001000
_02155CAC: .word Task__OV05Unknown2155974__Main_2155CB0
	arm_func_end Task__OV05Unknown2155974__Main_2155BCC

	arm_func_start Task__OV05Unknown2155974__Main_2155CB0
Task__OV05Unknown2155974__Main_2155CB0: // 0x02155CB0
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x10]
	cmp r1, #0
	beq _02155CCC
	blx r1
_02155CCC:
	ldr r0, [r4, #0x30]
	add r0, r0, #0x200
	str r0, [r4, #0x30]
	bl ovl05_21551E8
	ldr r0, [r4, #0x30]
	cmp r0, #0x10000
	ldmltia sp!, {r4, pc}
	ldr r0, _02155CFC // =Task__OV05Unknown2155974__Main_2155D00
	mov r1, #0x168
	str r1, [r4, #0x34]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155CFC: .word Task__OV05Unknown2155974__Main_2155D00
	arm_func_end Task__OV05Unknown2155974__Main_2155CB0

	arm_func_start Task__OV05Unknown2155974__Main_2155D00
Task__OV05Unknown2155974__Main_2155D00: // 0x02155D00
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x10]
	cmp r1, #0
	beq _02155D1C
	blx r1
_02155D1C:
	mov r0, #8
	bl SaveGame__CheckZoneBeaten
	cmp r0, #0
	bne _02155D44
	ldr r1, [r4, #0x34]
	ldr r0, _02155D78 // =0x0000014A
	cmp r1, r0
	ldrlo r0, [r4, #0x14]
	orrlo r0, r0, #2
	strlo r0, [r4, #0x14]
_02155D44:
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
	ldr r0, _02155D7C // =Task__OV05Unknown2155974__Main_2155D80
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155D78: .word 0x0000014A
_02155D7C: .word Task__OV05Unknown2155974__Main_2155D80
	arm_func_end Task__OV05Unknown2155974__Main_2155D00

	arm_func_start Task__OV05Unknown2155974__Main_2155D80
Task__OV05Unknown2155974__Main_2155D80: // 0x02155D80
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x10]
	cmp r1, #0
	beq _02155D98
	blx r1
_02155D98:
	bl IsDrawFadeTaskFinished
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyDrawFadeTask
	bl SaveGame__CheckProgress37
	cmp r0, #0
	beq _02155DC0
	ldr r0, _02155DCC // =Task__OV05Unknown2155974__Main_2155EA4
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
_02155DC0:
	ldr r0, _02155DD0 // =Task__OV05Unknown2155974__Main_2155DD4
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155DCC: .word Task__OV05Unknown2155974__Main_2155EA4
_02155DD0: .word Task__OV05Unknown2155974__Main_2155DD4
	arm_func_end Task__OV05Unknown2155974__Main_2155D80

	arm_func_start Task__OV05Unknown2155974__Main_2155DD4
Task__OV05Unknown2155974__Main_2155DD4: // 0x02155DD4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl ovl05_21551C8
	mov r0, r4
	mov r1, #0
	bl CreditsNotification__Create
	ldr r0, _02155DFC // =Task__OV05Unknown2155974__Main_2155E00
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155DFC: .word Task__OV05Unknown2155974__Main_2155E00
	arm_func_end Task__OV05Unknown2155974__Main_2155DD4

	arm_func_start Task__OV05Unknown2155974__Main_2155E00
Task__OV05Unknown2155974__Main_2155E00: // 0x02155E00
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x14]
	tst r0, #0x40
	ldmeqia sp!, {r4, pc}
	bl ovl05_21541A0
	cmp r0, #0
	beq _02155E3C
	ldr r1, [r4, #0x14]
	ldr r0, _02155E48 // =Task__OV05Unknown2155974__Main_2155E50
	bic r1, r1, #0x40
	str r1, [r4, #0x14]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
_02155E3C:
	ldr r0, _02155E4C // =Task__OV05Unknown2155974__Main_2155EA4
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155E48: .word Task__OV05Unknown2155974__Main_2155E50
_02155E4C: .word Task__OV05Unknown2155974__Main_2155EA4
	arm_func_end Task__OV05Unknown2155974__Main_2155E00

	arm_func_start Task__OV05Unknown2155974__Main_2155E50
Task__OV05Unknown2155974__Main_2155E50: // 0x02155E50
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #1
	bl CreditsNotification__Create
	bl LoadSysSoundVillage
	mov r0, #0
	mov r1, #1
	bl PlaySysTrack
	ldr r0, _02155E7C // =Task__OV05Unknown2155974__Main_2155E80
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155E7C: .word Task__OV05Unknown2155974__Main_2155E80
	arm_func_end Task__OV05Unknown2155974__Main_2155E50

	arm_func_start Task__OV05Unknown2155974__Main_2155E80
Task__OV05Unknown2155974__Main_2155E80: // 0x02155E80
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r0, [r0, #0x14]
	tst r0, #0x40
	ldmeqia sp!, {r3, pc}
	ldr r0, _02155EA0 // =Task__OV05Unknown2155974__Main_2155EA4
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155EA0: .word Task__OV05Unknown2155974__Main_2155EA4
	arm_func_end Task__OV05Unknown2155974__Main_2155E80

	arm_func_start Task__OV05Unknown2155974__Main_2155EA4
Task__OV05Unknown2155974__Main_2155EA4: // 0x02155EA4
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #0x3c
	str r1, [r0, #0x34]
	ldr r0, _02155EC0 // =Task__OV05Unknown2155974__Main_2155EC4
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155EC0: .word Task__OV05Unknown2155974__Main_2155EC4
	arm_func_end Task__OV05Unknown2155974__Main_2155EA4

	arm_func_start Task__OV05Unknown2155974__Main_2155EC4
Task__OV05Unknown2155974__Main_2155EC4: // 0x02155EC4
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r1, [r0, #0x34]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x34]
	ldmneia sp!, {r3, pc}
	mov r0, #0
	bl ovl05_21551D8
	bl ovl05_2155188
	ldmia sp!, {r3, pc}
	arm_func_end Task__OV05Unknown2155974__Main_2155EC4
