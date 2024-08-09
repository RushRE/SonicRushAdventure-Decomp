	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailTraining__Create
SailTraining__Create: // 0x02189D2C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	bl SailManager__GetWork
	mov r1, #0x1000
	mov r4, r0
	mov r2, #0
	str r1, [sp]
	mov r5, #1
	str r5, [sp, #4]
	mov r5, #0x20
	ldr r0, _02189DF4 // =SailTraining__Main
	ldr r1, _02189DF8 // =SailTraining__Destructor
	mov r3, r2
	str r5, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r5, r0
	mov r1, r5
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r1, [r4, #0x24]
	mov r0, #0
	orr r1, r1, #1
	str r1, [r4, #0x24]
	bl SailTrainingDialog__Create
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02189DB4
_02189DA4: // jump table
	b _02189DB4 // case 0
	b _02189DC4 // case 1
	b _02189DD4 // case 2
	b _02189DE4 // case 3
_02189DB4:
	ldr r0, _02189DFC // =SailTraining__State_Jet
	add sp, sp, #0xc
	str r0, [r5, #4]
	ldmia sp!, {r4, r5, pc}
_02189DC4:
	ldr r0, _02189E00 // =SailTraining__State_Boat
	add sp, sp, #0xc
	str r0, [r5, #4]
	ldmia sp!, {r4, r5, pc}
_02189DD4:
	ldr r0, _02189E04 // =SailTraining__State_Hover
	add sp, sp, #0xc
	str r0, [r5, #4]
	ldmia sp!, {r4, r5, pc}
_02189DE4:
	ldr r0, _02189E08 // =SailTraining__State_Submarine
	str r0, [r5, #4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02189DF4: .word SailTraining__Main
_02189DF8: .word SailTraining__Destructor
_02189DFC: .word SailTraining__State_Jet
_02189E00: .word SailTraining__State_Boat
_02189E04: .word SailTraining__State_Hover
_02189E08: .word SailTraining__State_Submarine
	arm_func_end SailTraining__Create

	arm_func_start SailTraining__Destructor
SailTraining__Destructor: // 0x02189E0C
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	bl SailManager__GetWork
	ldr r1, [r0, #0x24]
	bic r1, r1, #1
	str r1, [r0, #0x24]
	ldmia sp!, {r3, pc}
	arm_func_end SailTraining__Destructor

	arm_func_start SailTraining__Main
SailTraining__Main: // 0x02189E28
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	mov r5, r0
	bl SailManager__GetWork
	bl SailManager__GetWork
	bl SailManager__GetWork
	bl SailManager__GetShipType
	ldr r0, [r5, #0x18]
	cmp r0, #0
	beq _02189E8C
	ldrh r0, [r4, #8]
	tst r0, #2
	bne _02189EBC
	ldr r0, [r5, #0x24]
	tst r0, #0x10
	bne _02189EBC
	ldr r0, _02189F30 // =0x0000FFFF
	bl SailTrainingDialog__Create
	str r0, [r4, #0x1c]
	ldrh r0, [r4, #8]
	orr r0, r0, #2
	strh r0, [r4, #8]
	b _02189EBC
_02189E8C:
	ldrh r1, [r4]
	cmp r1, #0
	bne _02189EBC
	ldr r0, [r5, #0x24]
	tst r0, #0x10
	bne _02189EBC
	add r0, r1, #1
	strh r0, [r4]
	ldrh r0, [r4]
	bl SailTrainingDialog__Create
	ldr r0, _02189F34 // =SailTraining__Main_2189F3C
	bl SetCurrentTaskMainEvent
_02189EBC:
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r0, #0x18]
	tst r1, #4
	ldmeqia sp!, {r3, r4, r5, pc}
	bl SailMessageCommon__Func_21729F4
	mov r1, #0
	str r1, [r4, #0x1c]
	cmp r0, #0
	beq _02189F10
	ldr r0, _02189F38 // =0x0000FFFE
	bl SailTrainingDialog__Create
	ldrh r2, [r4, #8]
	add r0, r5, #0x500
	mov r1, #1
	orr r2, r2, #4
	strh r2, [r4, #8]
	strh r1, [r0, #0xd0]
	str r1, [r5, #4]
	b _02189F24
_02189F10:
	ldrh r0, [r4]
	add r0, r0, #1
	strh r0, [r4]
	ldrh r0, [r4]
	bl SailTrainingDialog__Create
_02189F24:
	ldr r0, _02189F34 // =SailTraining__Main_2189F3C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02189F30: .word 0x0000FFFF
_02189F34: .word SailTraining__Main_2189F3C
_02189F38: .word 0x0000FFFE
	arm_func_end SailTraining__Main

	arm_func_start SailTraining__Main_2189F3C
SailTraining__Main_2189F3C: // 0x02189F3C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	mov r5, r0
	bl SailManager__GetWork
	ldr r6, [r0, #0x98]
	bl SailManager__GetWork
	ldr r7, [r0, #0x70]
	bl SailManager__GetWork
	ldr r8, [r0, #0xa4]
	bl SailManager__GetShipType
	ldrh r1, [r4, #8]
	mov r0, r0, lsl #0x10
	mov sb, r0, lsr #0x10
	tst r1, #4
	bne _0218A0DC
	ldr r0, [r5, #0x24]
	tst r0, #0x2000
	bne _0218A048
	ldrh r3, [r4]
	cmp r3, #6
	bhs _02189FC4
	mov r0, #6
	mul r2, sb, r0
	ldr r1, _0218A108 // =_0218C8DC
	ldr r0, _0218A10C // =_0218C8F4
	add r1, r1, r2
	ldrb r1, [r3, r1]
	add r0, r0, r2
	strh r1, [r6, #0x6c]
	ldrh r1, [r4]
	ldrb r0, [r1, r0]
	strh r0, [r6, #0x6e]
_02189FC4:
	ldr r0, [r4, #4]
	blx r0
	cmp r0, #0
	ldrne r0, [r5, #0x24]
	orrne r0, r0, #0x2000
	strne r0, [r5, #0x24]
	ldrh r0, [r4, #8]
	tst r0, #1
	beq _0218A0DC
	ldr r0, [r5, #0x24]
	tst r0, #0x10
	bne _0218A0DC
	mov r1, #0x100000
	mov r0, r7
	rsb r1, r1, #0
	bl SailPlayer__RemoveHealth
	mov r1, #0
	strh r1, [r6, #0x6c]
	strh r1, [r6, #0x6e]
	ldr r0, [r5, #0x18]
	cmp r0, #0
	add r0, r5, #0x500
	movne r1, #1
	strneh r1, [r0, #0xd0]
	strne r1, [r5, #4]
	bne _0218A040
	strh r1, [r0, #0xd0]
	ldr r0, [r5, #0x24]
	orr r0, r0, #8
	str r0, [r5, #0x24]
	bl SailRetireEvent__CreateFadeOut
_0218A040:
	bl DestroyCurrentTask
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
_0218A048:
	tst r0, #0x10
	bne _0218A0DC
	ldrh r0, [r6, #0x6e]
	cmp r0, #0
	beq _0218A064
	mov r0, #0
	bl SailTrainingFinishedDialog__Create
_0218A064:
	ldrh r0, [r6, #0x6e]
	cmp r0, #0
	bne _0218A0D0
	ldr r1, _0218A10C // =_0218C8F4
	mov r0, #6
	mla r1, sb, r0, r1
	ldrh r2, [r4]
	ldrh r0, [r6, #0x24]
	ldrb r1, [r2, r1]
	cmp r1, r0
	bgt _0218A0D0
	ldrh r0, [r4, #8]
	tst r0, #1
	beq _0218A0B4
	mov r0, #1
	bl SailTrainingFinishedDialog__Create
	ldr r0, [r5, #0x24]
	bic r0, r0, #0x2000
	str r0, [r5, #0x24]
	b _0218A0D0
_0218A0B4:
	add r0, r2, #1
	strh r0, [r4]
	ldrh r0, [r4]
	bl SailTrainingDialog__Create
	ldr r0, [r5, #0x24]
	bic r0, r0, #0x2000
	str r0, [r5, #0x24]
_0218A0D0:
	mov r0, #0
	strh r0, [r6, #0x6c]
	strh r0, [r6, #0x6e]
_0218A0DC:
	ldr r1, [r8, #0x10]
	ldr r0, [r8, #0x28]
	cmp r1, r0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	cmp r1, #0x80000
	ldmgtia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	mov r1, #0x100000
	mov r0, r7
	rsb r1, r1, #0
	bl SailPlayer__RemoveHealth
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_0218A108: .word _0218C8DC
_0218A10C: .word _0218C8F4
	arm_func_end SailTraining__Main_2189F3C

	arm_func_start SailTraining__State_Jet
SailTraining__State_Jet: // 0x0218A110
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	mov r7, r0
	mov r5, #0
	bl SailManager__GetWork
	ldr r6, [r0, #0x70]
	bl SailManager__GetWork
	ldr r8, [r0, #0xa4]
	bl SailManager__GetWork
	cmp r8, #0
	ldr r1, [r0, #0x98]
	moveq r0, r5
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r6, #0
	ldrne r5, [r6, #0x124]
	cmp r5, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r7, #0x24]
	tst r0, #1
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r0, [r4]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0218A398
_0218A180: // jump table
	b _0218A398 // case 0
	b _0218A198 // case 1
	b _0218A1E8 // case 2
	b _0218A288 // case 3
	b _0218A2F8 // case 4
	b _0218A368 // case 5
_0218A198:
	ldr r0, _0218A3A0 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #0
	strne r0, [r4, #0xc]
	ldr r0, _0218A3A0 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	beq _0218A398
	ldr r0, [r4, #0xc]
	add r0, r0, #1
	str r0, [r4, #0xc]
	cmp r0, #0x3c
	ble _0218A398
	mov r0, #0
	str r0, [r4, #0xc]
	ldr r1, [r5, #0x1a4]
	mov r0, #1
	str r1, [r4, #0x14]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A1E8:
	ldr r0, _0218A3A0 // =touchInput
	ldrh r1, [r0, #0x12]
	tst r1, #1
	beq _0218A398
	ldrh r1, [r0, #0x18]
	ldrh r0, [r0, #0x14]
	sub r0, r1, r0
	cmp r0, #4
	ldrgt r0, [r4, #0x18]
	ldr r1, _0218A3A0 // =touchInput
	orrgt r0, r0, #1
	strgt r0, [r4, #0x18]
	ldrh r2, [r1, #0x18]
	ldrh r1, [r1, #0x14]
	mvn r0, #3
	sub r1, r2, r1
	cmp r1, r0
	ldrlt r0, [r4, #0x18]
	orrlt r0, r0, #2
	strlt r0, [r4, #0x18]
	ldr r1, [r4, #0x14]
	ldr r0, [r5, #0x1a4]
	cmp r1, r0
	ldrlo r0, [r4, #0xc]
	addlo r0, r0, #1
	strlo r0, [r4, #0xc]
	ldr r0, [r5, #0x1a4]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x18]
	cmp r0, #3
	bne _0218A398
	ldr r0, [r4, #0xc]
	cmp r0, #0xa
	blt _0218A398
	mov r0, #0
	str r0, [r4, #0x14]
	str r0, [r4, #0xc]
	str r0, [r4, #0x18]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A288:
	ldr r0, [r4, #0x18]
	tst r0, #2
	bne _0218A2A4
	bl SailStylusPromptHUD__Create
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
_0218A2A4:
	ldr r1, [r4, #0xc]
	cmp r1, #3
	blt _0218A2D0
	add r0, r1, #1
	str r0, [r4, #0xc]
	cmp r0, #0x14
	ble _0218A398
	mov r0, #0
	str r0, [r4, #0xc]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A2D0:
	ldr r0, [r6, #0x24]
	tst r0, #4
	beq _0218A2EC
	ldr r0, [r4, #0x14]
	tst r0, #4
	addeq r0, r1, #1
	streq r0, [r4, #0xc]
_0218A2EC:
	ldr r0, [r6, #0x24]
	str r0, [r4, #0x14]
	b _0218A398
_0218A2F8:
	ldr r0, [r4, #0x18]
	tst r0, #1
	bne _0218A314
	bl CreateSailButtonPrompt
	ldr r0, [r4, #0x18]
	orr r0, r0, #1
	str r0, [r4, #0x18]
_0218A314:
	ldr r0, [r6, #0x24]
	tst r0, #1
	bne _0218A338
	ldr r0, [r5, #0x1bc]
	cmp r0, #0x1e000
	bgt _0218A338
	mov r0, r6
	mov r1, #0x60000
	bl SailPlayer__GiveBoost
_0218A338:
	ldr r0, [r5, #0x1ac]
	cmp r0, #0
	beq _0218A398
	ldr r0, [r4, #0xc]
	add r0, r0, #1
	str r0, [r4, #0xc]
	cmp r0, #0x1c
	ble _0218A398
	mov r0, #0
	str r0, [r4, #0xc]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A368:
	ldr r0, [r1, #0x44]
	cmp r0, #0x7d0000
	blt _0218A398
	ldrh r2, [r4, #8]
	mov r1, #0x100000
	mov r0, r6
	orr r2, r2, #1
	rsb r1, r1, #0
	strh r2, [r4, #8]
	bl SailPlayer__RemoveHealth
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A398:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0218A3A0: .word touchInput
	arm_func_end SailTraining__State_Jet

	arm_func_start SailTraining__State_Boat
SailTraining__State_Boat: // 0x0218A3A4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	mov r5, r0
	mov r6, #0
	bl SailManager__GetWork
	ldr r7, [r0, #0x70]
	bl SailManager__GetWork
	ldr r8, [r0, #0xa4]
	bl SailManager__GetWork
	ldr r0, [r0, #0x98]
	cmp r8, #0
	moveq r0, r6
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r7, #0
	ldrne r6, [r7, #0x124]
	cmp r6, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r2, [r5, #0x24]
	tst r2, #1
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r1, [r4]
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	b _0218A664
_0218A414: // jump table
	b _0218A664 // case 0
	b _0218A428 // case 1
	b _0218A49C // case 2
	b _0218A530 // case 3
	b _0218A5C4 // case 4
_0218A428:
	orr r0, r2, #0x400000
	str r0, [r5, #0x24]
	add r0, r6, #0x200
	mov r1, #0
	strh r1, [r0, #0xe]
	ldrb r0, [r6, #0x1b3]
	ldr r1, [r4, #0x14]
	cmp r1, r0
	ldrlt r0, [r4, #0xc]
	addlt r0, r0, #1
	strlt r0, [r4, #0xc]
	ldrb r0, [r6, #0x1b3]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0xc]
	cmp r0, #1
	ldrge r0, [r4, #0x10]
	addge r0, r0, #1
	strge r0, [r4, #0x10]
	ldr r0, [r4, #0x10]
	cmp r0, #0xf
	ble _0218A664
	mov r0, #0
	str r0, [r4, #0xc]
	str r0, [r4, #0x10]
	str r0, [r4, #0x18]
	ldrb r1, [r6, #0x1b4]
	mov r0, #1
	str r1, [r4, #0x14]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A49C:
	add r0, r6, #0x200
	ldrh r0, [r0, #0xe]
	cmp r0, #1
	beq _0218A4BC
	mov r0, #0
	mov r2, r0
	mov r1, #0x1f
	bl SailAudio__PlaySpatialSequence
_0218A4BC:
	add r0, r6, #0x200
	mov r1, #1
	strh r1, [r0, #0xe]
	ldrb r0, [r6, #0x1b4]
	ldr r1, [r4, #0x14]
	cmp r1, r0
	ldrlt r0, [r4, #0xc]
	addlt r0, r0, #1
	strlt r0, [r4, #0xc]
	ldrb r0, [r6, #0x1b4]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0xc]
	cmp r0, #4
	ldrge r0, [r4, #0x10]
	addge r0, r0, #1
	strge r0, [r4, #0x10]
	ldr r0, [r4, #0x10]
	cmp r0, #0xa
	ble _0218A664
	mov r0, #0
	str r0, [r4, #0xc]
	str r0, [r4, #0x10]
	ldr r1, [r6, #0x1a4]
	mov r0, #1
	str r1, [r4, #0x14]
	ldr r1, [r4, #0x18]
	bic r1, r1, #2
	str r1, [r4, #0x18]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A530:
	ldr r0, [r4, #0x18]
	tst r0, #2
	bne _0218A54C
	bl SailStylusPromptHUD2__Create
	ldr r0, [r4, #0x18]
	orr r0, r0, #2
	str r0, [r4, #0x18]
_0218A54C:
	add r0, r6, #0x200
	ldrh r0, [r0, #0xe]
	cmp r0, #2
	beq _0218A56C
	mov r0, #0
	mov r2, r0
	mov r1, #0x1f
	bl SailAudio__PlaySpatialSequence
_0218A56C:
	add r0, r6, #0x200
	mov r1, #2
	strh r1, [r0, #0xe]
	ldr r1, [r4, #0x14]
	ldr r0, [r6, #0x1a4]
	cmp r1, r0
	ldrlo r0, [r4, #0xc]
	addlo r0, r0, #1
	strlo r0, [r4, #0xc]
	ldr r0, [r6, #0x1a4]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0xc]
	cmp r0, #0x1e
	blt _0218A664
	mov r0, #0
	str r0, [r4, #0xc]
	ldr r1, [r4, #0x18]
	mov r0, #1
	bic r1, r1, #1
	bic r1, r1, #2
	str r1, [r4, #0x18]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A5C4:
	bic r1, r2, #0x400000
	str r1, [r5, #0x24]
	ldr r1, [r4, #0xc]
	cmp r1, #0
	bne _0218A5F0
	add r1, r6, #0x200
	mov r2, #0
	strh r2, [r1, #0xe]
	ldr r1, [r4, #0xc]
	add r1, r1, #1
	str r1, [r4, #0xc]
_0218A5F0:
	add r1, r6, #0x200
	ldrh r1, [r1, #0xe]
	cmp r1, #1
	ldreq r1, [r4, #0x18]
	orreq r1, r1, #1
	streq r1, [r4, #0x18]
	add r1, r6, #0x200
	ldrh r1, [r1, #0xe]
	cmp r1, #2
	ldreq r1, [r4, #0x18]
	orreq r1, r1, #2
	streq r1, [r4, #0x18]
	ldr r0, [r0, #0x44]
	cmp r0, #0x640000
	blt _0218A664
	ldr r0, [r4, #0x18]
	tst r0, #1
	beq _0218A664
	tst r0, #2
	beq _0218A664
	ldrh r2, [r4, #8]
	mov r1, #0x100000
	mov r0, r7
	orr r2, r2, #1
	rsb r1, r1, #0
	strh r2, [r4, #8]
	bl SailPlayer__RemoveHealth
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A664:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SailTraining__State_Boat

	arm_func_start SailTraining__State_Hover
SailTraining__State_Hover: // 0x0218A66C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	mov r7, r0
	mov r5, #0
	bl SailManager__GetWork
	ldr r6, [r0, #0x70]
	bl SailManager__GetWork
	ldr r8, [r0, #0xa4]
	bl SailManager__GetWork
	cmp r8, #0
	ldr r1, [r0, #0x98]
	moveq r0, r5
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r6, #0
	ldrne r5, [r6, #0x124]
	cmp r5, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r7, #0x24]
	tst r0, #1
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r0, [r4]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _0218A850
_0218A6DC: // jump table
	b _0218A850 // case 0
	b _0218A6F0 // case 1
	b _0218A794 // case 2
	b _0218A7DC // case 3
	b _0218A820 // case 4
_0218A6F0:
	ldr r0, _0218A858 // =touchInput
	ldrh r1, [r0, #0x12]
	tst r1, #1
	beq _0218A850
	ldrh r1, [r0, #0x18]
	ldrh r0, [r0, #0x14]
	sub r0, r1, r0
	cmp r0, #4
	ldrgt r0, [r4, #0x18]
	ldr r1, _0218A858 // =touchInput
	orrgt r0, r0, #1
	strgt r0, [r4, #0x18]
	ldrh r2, [r1, #0x18]
	ldrh r1, [r1, #0x14]
	mvn r0, #3
	sub r1, r2, r1
	cmp r1, r0
	ldrlt r0, [r4, #0x18]
	orrlt r0, r0, #2
	strlt r0, [r4, #0x18]
	ldr r1, [r4, #0x14]
	ldr r0, [r5, #0x1a4]
	cmp r1, r0
	ldrlo r0, [r4, #0xc]
	addlo r0, r0, #1
	strlo r0, [r4, #0xc]
	ldr r0, [r5, #0x1a4]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x18]
	cmp r0, #3
	bne _0218A850
	ldr r0, [r4, #0xc]
	cmp r0, #0xa
	ble _0218A850
	mov r0, #0
	str r0, [r4, #0xc]
	str r0, [r4, #0x18]
	ldrb r1, [r5, #0x1b0]
	mov r0, #1
	str r1, [r4, #0x14]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A794:
	ldrb r0, [r5, #0x1b0]
	ldr r1, [r4, #0x14]
	cmp r1, r0
	ldrlt r0, [r4, #0xc]
	addlt r0, r0, #1
	strlt r0, [r4, #0xc]
	ldrb r0, [r5, #0x1b0]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0xc]
	cmp r0, #3
	blt _0218A850
	mov r0, #0
	str r0, [r4, #0xc]
	str r0, [r4, #0x18]
	ldrb r1, [r5, #0x1b2]
	mov r0, #1
	str r1, [r4, #0x14]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A7DC:
	ldrb r0, [r5, #0x1b2]
	ldr r1, [r4, #0x14]
	cmp r1, r0
	ldrlt r0, [r4, #0xc]
	addlt r0, r0, #1
	strlt r0, [r4, #0xc]
	ldrb r0, [r5, #0x1b2]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0xc]
	cmp r0, #3
	blt _0218A850
	mov r0, #0
	str r0, [r4, #0xc]
	str r0, [r4, #0x18]
	str r0, [r4, #0x14]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A820:
	ldr r0, [r1, #0x44]
	cmp r0, #0x840000
	blt _0218A850
	ldrh r2, [r4, #8]
	mov r1, #0x100000
	mov r0, r6
	orr r2, r2, #1
	rsb r1, r1, #0
	strh r2, [r4, #8]
	bl SailPlayer__RemoveHealth
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A850:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0218A858: .word touchInput
	arm_func_end SailTraining__State_Hover

	arm_func_start SailTraining__State_Submarine
SailTraining__State_Submarine: // 0x0218A85C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetWork
	mov r7, r0
	mov r5, #0
	bl SailManager__GetWork
	ldr r6, [r0, #0x70]
	bl SailManager__GetWork
	ldr r8, [r0, #0xa4]
	bl SailManager__GetWork
	cmp r8, #0
	ldr r1, [r0, #0x98]
	moveq r0, r5
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r6, #0
	ldrne r5, [r6, #0x124]
	cmp r5, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r7, #0x24]
	tst r0, #1
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r0, [r4]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0218A9CC
_0218A8CC: // jump table
	b _0218A9CC // case 0
	b _0218A8DC // case 1
	b _0218A93C // case 2
	b _0218A99C // case 3
_0218A8DC:
	ldr r1, [r4, #0x14]
	ldr r0, [r5, #0x1ac]
	cmp r1, r0
	ldrlo r0, [r4, #0xc]
	addlo r0, r0, #1
	strlo r0, [r4, #0xc]
	ldr r0, [r5, #0x1ac]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0xc]
	cmp r0, #1
	ldrge r0, [r4, #0x10]
	addge r0, r0, #1
	strge r0, [r4, #0x10]
	ldr r0, [r4, #0x10]
	cmp r0, #0xa
	ble _0218A9CC
	mov r0, #0
	str r0, [r4, #0xc]
	str r0, [r4, #0x10]
	str r0, [r4, #0x18]
	ldr r1, [r5, #0x1ac]
	mov r0, #1
	str r1, [r4, #0x14]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A93C:
	ldr r1, [r4, #0x14]
	ldr r0, [r5, #0x1ac]
	cmp r1, r0
	ldrlo r0, [r4, #0xc]
	addlo r0, r0, #1
	strlo r0, [r4, #0xc]
	ldr r0, [r5, #0x1ac]
	str r0, [r4, #0x14]
	ldr r0, [r4, #0xc]
	cmp r0, #2
	ldrge r0, [r4, #0x10]
	addge r0, r0, #1
	strge r0, [r4, #0x10]
	ldr r0, [r4, #0x10]
	cmp r0, #0xa
	ble _0218A9CC
	mov r0, #0
	str r0, [r4, #0xc]
	str r0, [r4, #0x10]
	str r0, [r4, #0x18]
	ldr r1, [r5, #0x1ac]
	mov r0, #1
	str r1, [r4, #0x14]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A99C:
	ldr r0, [r1, #0x44]
	cmp r0, #0x580000
	blt _0218A9CC
	ldrh r2, [r4, #8]
	mov r1, #0x100000
	mov r0, r6
	orr r2, r2, #1
	rsb r1, r1, #0
	strh r2, [r4, #8]
	bl SailPlayer__RemoveHealth
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0218A9CC:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SailTraining__State_Submarine

	arm_func_start CreateSailButtonPrompt
CreateSailButtonPrompt: // 0x0218A9D4
	stmdb sp!, {r3, lr}
	mov r0, #8
	mov r1, #0x60000
	bl SailButtonPromptHUD__Create
	mov r0, #9
	mov r1, #0xa0000
	bl SailButtonPromptHUD__Create
	mov r0, #0xb
	mov r1, #0x88000
	bl SailButtonPromptHUD__Create
	mov r0, #0xc
	mov r1, #0xb8000
	bl SailButtonPromptHUD__Create
	ldmia sp!, {r3, pc}
	arm_func_end CreateSailButtonPrompt

	.rodata

_0218C8DC: // 0x0218C8DC
    .byte 0, 0, 3, 6, 9, 0xB
	.byte 0, 0, 3, 6, 8, 0
	.byte 0, 0, 3, 6, 0xB, 0
	.byte 0, 0, 4, 8, 0, 0

_0218C8F4: // 0x0218C8F4
    .byte 0, 2, 5, 8, 0xB, 0x11
	.byte 0, 2, 5, 8, 0xD, 0
	.byte 0, 2, 5, 0xB, 0x11, 0
	.byte 0, 2, 6, 0xE, 0, 0
