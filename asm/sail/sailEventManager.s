	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailEventManager__Create
SailEventManager__Create: // 0x02154B48
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x30
	bl SailManager__GetWork
	mov r1, #0x4800
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #4
	str r4, [sp, #4]
	mov r4, #0x4c
	ldr r0, _02154ED4 // =SailEventManager__Main
	ldr r1, _02154ED8 // =SailEventManager__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x4c
	bl MIi_CpuClear16
	mov r0, r4
	mov r1, #0
	bl NNS_FndInitList
	add r0, r4, #0xc
	mov r1, #0
	bl NNS_FndInitList
	ldr r0, [r5, #0xc]
	cmp r0, #0
	mov r0, #0x4000
	beq _02154BCC
	bl _AllocHeadHEAP_USER
	b _02154BD0
_02154BCC:
	bl _AllocHeadHEAP_SYSTEM
_02154BD0:
	str r0, [r4, #0x18]
	ldr r1, [r4, #0x18]
	mov r0, #0
	mov r2, #0x4000
	bl MIi_CpuClear16
	mov r0, #0x400
	bl _AllocHeadHEAP_USER
	str r0, [r4, #0x1c]
	mov r1, r0
	mov r0, #0
	mov r2, #0x400
	bl MIi_CpuClear16
	ldrh r0, [r5, #0x14]
	cmp r0, #0
	beq _02154C88
	ldr r6, _02154EDC // =aBSbMs000Sbb
	add r3, sp, #0x1d
	mov r2, #8
_02154C18:
	ldrb r1, [r6, #0]
	ldrb r0, [r6, #1]
	add r6, r6, #2
	strb r1, [r3]
	strb r0, [r3, #1]
	add r3, r3, #2
	subs r2, r2, #1
	bne _02154C18
	ldrb r0, [r6, #0]
	mov r1, #0xa
	strb r0, [r3]
	ldrh r0, [r5, #0x14]
	bl FX_DivS32
	mov r1, #0xa
	mul r2, r0, r1
	ldrh r3, [r5, #0x14]
	ldrsb r1, [sp, #0x27]
	ldrsb r5, [sp, #0x28]
	sub r2, r3, r2
	add r1, r1, r0
	add r2, r5, r2
	strb r1, [sp, #0x27]
	add r0, sp, #0x1d
	strb r2, [sp, #0x28]
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r4, #0x48]
	b _02154D30
_02154C88:
	ldr r0, [r5, #0xc]
	cmp r0, #1
	bne _02154D10
	ldr r6, _02154EE0 // =aSbbSbJoh00Sbb
	add r3, sp, #0xc
	mov r2, #8
_02154CA0:
	ldrb r1, [r6, #0]
	ldrb r0, [r6, #1]
	add r6, r6, #2
	strb r1, [r3]
	strb r0, [r3, #1]
	add r3, r3, #2
	subs r2, r2, #1
	bne _02154CA0
	ldrb r0, [r6, #0]
	mov r1, #0xa
	strb r0, [r3]
	ldrh r0, [r5, #0x10]
	bl FX_DivS32
	mov r1, #0xa
	mul r2, r0, r1
	ldrh r3, [r5, #0x10]
	ldrsb r1, [sp, #0x16]
	ldrsb r5, [sp, #0x17]
	sub r2, r3, r2
	add r1, r1, r0
	add r2, r5, r2
	strb r1, [sp, #0x16]
	add r0, sp, #0xc
	strb r2, [sp, #0x17]
	mov r1, #0
	bl FSRequestFileSync
	str r0, [r4, #0x48]
	b _02154D30
_02154D10:
	mov r0, #0x33
	bl GetObjectFileWork
	mov r5, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _02154EE4 // =aSbJetSbb
	mov r0, r5
	bl ObjDataLoad
_02154D30:
	ldr r0, _02154EE8 // =0x0000FFFE
	strh r0, [r4, #0x36]
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02154EC8
_02154D48: // jump table
	b _02154D58 // case 0
	b _02154DD4 // case 1
	b _02154D58 // case 2
	b _02154E50 // case 3
_02154D58:
	ldr r1, _02154EEC // =FX_SinCosTable_
	mov r0, #0x28000
	ldrsh r7, [r1, #0]
	ldrsh r3, [r1, #2]
	rsb r0, r0, #0
	umull r2, ip, r7, r0
	mvn r1, #0
	umull r6, r5, r3, r0
	adds lr, r2, #0x800
	mov r2, #0x48000
	mla ip, r7, r1, ip
	mov r7, r7, asr #0x1f
	mla ip, r7, r0, ip
	adc r7, ip, #0
	mov ip, lr, lsr #0xc
	adds r6, r6, #0x800
	orr ip, ip, r7, lsl #20
	mla r5, r3, r1, r5
	mov r1, r3, asr #0x1f
	mla r5, r1, r0, r5
	adc r0, r5, #0
	mov r1, r6, lsr #0xc
	str ip, [r4, #0x24]
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x2c]
	mov r0, #0x2f000
	str r0, [r4, #0x30]
	str r2, [r4, #0x38]
	sub r0, r2, #0x4b000
	str r0, [r4, #0x3c]
	b _02154EC8
_02154DD4:
	ldr r1, _02154EEC // =FX_SinCosTable_
	mov r0, #0x30000
	ldrsh r7, [r1, #0]
	ldrsh r3, [r1, #2]
	rsb r0, r0, #0
	umull r2, ip, r7, r0
	mvn r1, #0
	umull r6, r5, r3, r0
	adds lr, r2, #0x800
	mov r2, #0x68000
	mla ip, r7, r1, ip
	mov r7, r7, asr #0x1f
	mla ip, r7, r0, ip
	adc r7, ip, #0
	mov ip, lr, lsr #0xc
	adds r6, r6, #0x800
	orr ip, ip, r7, lsl #20
	mla r5, r3, r1, r5
	mov r1, r3, asr #0x1f
	mla r5, r1, r0, r5
	adc r0, r5, #0
	mov r1, r6, lsr #0xc
	str ip, [r4, #0x24]
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x2c]
	mov r0, #0x90000
	str r0, [r4, #0x30]
	str r2, [r4, #0x38]
	sub r0, r2, #0x88000
	str r0, [r4, #0x3c]
	b _02154EC8
_02154E50:
	ldr r1, _02154EEC // =FX_SinCosTable_
	mov r0, #0x68000
	ldrsh lr, [r1]
	ldrsh r3, [r1, #2]
	rsb r0, r0, #0
	umull r2, r6, lr, r0
	mvn r1, #0
	umull ip, r5, r3, r0
	adds r7, r2, #0x800
	mov r2, #0x68000
	mla r6, lr, r1, r6
	mov lr, lr, asr #0x1f
	mla r6, lr, r0, r6
	adc r6, r6, #0
	mov r7, r7, lsr #0xc
	adds ip, ip, #0x800
	orr r7, r7, r6, lsl #20
	mla r5, r3, r1, r5
	mov r1, r3, asr #0x1f
	mla r5, r1, r0, r5
	adc r0, r5, #0
	mov r1, ip, lsr #0xc
	str r7, [r4, #0x24]
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x2c]
	mov r0, #0x70000
	str r0, [r4, #0x30]
	str r2, [r4, #0x38]
	sub r0, r2, #0x94000
	str r0, [r4, #0x3c]
_02154EC8:
	mov r0, r4
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02154ED4: .word SailEventManager__Main
_02154ED8: .word SailEventManager__Destructor
_02154EDC: .word aBSbMs000Sbb
_02154EE0: .word aSbbSbJoh00Sbb
_02154EE4: .word aSbJetSbb
_02154EE8: .word 0x0000FFFE
_02154EEC: .word FX_SinCosTable_
	arm_func_end SailEventManager__Create

	arm_func_start SailEventManager__ProcessSBB
SailEventManager__ProcessSBB: // 0x02154EF0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	bl SailManager__GetWork
	ldr r11, [r0, #0xa0]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	bl SailManager__GetWork
	str r0, [sp, #8]
	mov r1, #0
	mov r0, #0x33
	mov r7, #1
	str r1, [sp, #4]
	bl GetObjectFileWork
	ldr r1, [sp, #8]
	ldr r6, [r0, #0]
	ldr r1, [r1, #0xc]
	cmp r1, #0
	ldreq r0, [sp, #8]
	ldreqh r0, [r0, #0x14]
	cmpeq r0, #0
	bne _02154F90
	ldrh r0, [r5, #0xb8]
	cmp r0, #1
	addlo sp, sp, #0xc
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl SailManager__GetShipType
	cmp r0, #3
	bne _02154F90
	ldr r0, [sp, #4]
	ldrh r2, [r5, #0xb8]
	add r1, r0, #9
	add r3, r7, #1
	mov r0, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	cmp r2, #2
	str r0, [sp, #4]
	addlo sp, sp, #0xc
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02154F90:
	cmp r7, #0
	mov r4, #0
	bls _02154FC4
	ldr r3, _021554D8 // =0x0000FFFF
	mov r0, #0x28
_02154FA4:
	ldr r2, [r5, #0xc0]
	add r1, r4, #1
	mla r2, r4, r0, r2
	mov r1, r1, lsl #0x10
	strh r3, [r2, #6]
	cmp r7, r1, lsr #16
	mov r4, r1, lsr #0x10
	bhi _02154FA4
_02154FC4:
	ldr r0, [sp, #8]
	ldr r0, [r0, #0xc]
	cmp r0, #1
	beq _02154FE4
	ldr r0, [sp, #8]
	ldrh r0, [r0, #0x14]
	cmp r0, #0
	beq _02155144
_02154FE4:
	ldr r2, [r11, #0x48]
	mov r10, #0
	ldr r1, [r2, #0]
	mov r9, r10
	add r4, r2, r1
	ldrh r0, [r4, #8]
	ldr r1, [r2, r1]
	mov r11, r10
	add r0, r0, #1
	strh r0, [r5, #0xb8]
	add r6, r4, r1
_02155010:
	mov r0, #0xc
	mla r7, r9, r0, r6
	ldr r1, [r5, #0xc0]
	mov r0, #0x28
	mla r8, r9, r0, r1
	mov r0, #0
	strh r0, [r8, #8]
	strh r9, [r8, #6]
	bl SailManager__GetShipType
	cmp r0, #1
	mov r0, #0
	bne _02155054
	strh r0, [r8, #4]
	ldrh r0, [r7, #0xa]
	mov r0, r0, lsl #8
	strh r0, [r8, #0xa]
	b _02155064
_02155054:
	strh r0, [r8, #0xa]
	ldrh r0, [r7, #0xa]
	mov r0, r0, lsl #8
	strh r0, [r8, #4]
_02155064:
	strb r11, [r8]
	ldrh r0, [r7, #6]
	tst r0, #4
	beq _02155090
	mov r0, #0xc
	strh r0, [r8, #8]
	mov r0, r10
	mov r1, r9
	mov r2, r11
	bl SailJetRaceGoalHUD__Create
	mov r10, r9
_02155090:
	ldrh r0, [r4, #8]
	cmp r9, r0
	beq _021550B0
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #0xff
	blo _02155010
_021550B0:
	mov r0, r10
	mov r1, r9
	mov r2, #1
	bl SailJetRaceGoalHUD__Create
	mov r0, #0x28
	sub r2, r9, #1
	mul r1, r2, r0
	ldr r2, [r5, #0xc0]
	mul r0, r9, r0
	add r2, r2, r1
	mov r3, #0
	strh r3, [r2, #4]
	ldr r2, [r5, #0xc0]
	mov r4, #0x1a
	add r2, r2, r0
	strh r3, [r2, #4]
	ldr r2, [r5, #0xc0]
	mov r3, #0x1b
	strb r4, [r2, r1]
	ldr r2, [r5, #0xc0]
	strb r3, [r2, r0]
	ldr r2, [sp, #8]
	ldr r2, [r2, #0x24]
	tst r2, #0x1000
	ldrne r2, [sp, #8]
	ldrne r2, [r2, #0x18]
	cmpne r2, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, [r5, #0xc0]
	mov r3, #0xe
	strb r3, [r2, r1]
	ldr r1, [r5, #0xc0]
	mov r2, #0xf
	strb r2, [r1, r0]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02155144:
	ldr r0, [sp, #8]
	ldrh r0, [r0, #0x12]
	cmp r0, #6
	bne _021551BC
	ldrh r1, [r5, #0xb8]
	mov r0, #0
	mov r2, #1
	bl SailJetRaceGoalHUD__Create
	ldrh r1, [r5, #0xb8]
	ldr r3, [r5, #0xc0]
	mov r0, #0x28
	sub r2, r1, #1
	mla r1, r2, r0, r3
	mov r3, #0
	strh r3, [r1, #4]
	ldrh r2, [r5, #0xb8]
	ldr r1, [r5, #0xc0]
	mov r8, #0x1a
	mla r1, r2, r0, r1
	strh r3, [r1, #4]
	ldrh r1, [r5, #0xb8]
	ldr r4, [r5, #0xc0]
	mov r3, #0x1b
	sub r1, r1, #1
	mul r2, r1, r0
	strb r8, [r4, r2]
	ldrh r1, [r5, #0xb8]
	ldr r2, [r5, #0xc0]
	mul r0, r1, r0
	strb r3, [r2, r0]
_021551BC:
	cmp r7, #0x100
	addhs sp, sp, #0xc
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_021551C8:
	ldrh r0, [r5, #0xb8]
	cmp r7, r0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r4, [r5, #0xc0]
	mov r0, #0x28
	mla r0, r7, r0, r4
	ldr r2, [r6, #0]
	ldrh r1, [r11, #0x34]
	add r3, r6, r2
	ldr r2, [r6, r2]
	str r0, [sp]
	cmp r1, #0
	add r9, r3, r2
	add r8, r3, #4
	beq _02155220
	add r0, r1, #1
	strh r0, [r11, #0x34]
	ldrh r2, [r11, #0x34]
	mov r0, #0
	strh r0, [r11, #0x34]
	b _02155438
_02155220:
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02155394
	ldrh r4, [r11, #0x42]
	bl SailManager__GetShipType
	cmp r0, #1
	movne r0, r4, lsl #0xf
	movne r4, r0, lsr #0x10
	cmp r4, #4
	ldrh r0, [r11, #0x44]
	movhi r4, #4
	cmp r0, #0
	beq _02155298
	ldr r2, _021554DC // =_mt_math_rand
	ldr r0, _021554E0 // =0x00196225
	ldr r4, [r2, #0]
	ldr r1, _021554E4 // =0x3C6EF35F
	ldr r3, _021554E8 // =_0218CD30
	mla r0, r4, r0, r1
	mov r1, r0, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xf
	add r1, r3, r1
	ldrb r1, [r1, #0x60]
	str r1, [sp, #4]
	str r0, [r2]
	mov r0, #0
	strh r0, [r11, #0x44]
	b _0215533C
_02155298:
	ldr r3, _021554DC // =_mt_math_rand
	ldr r0, _021554E8 // =_0218CD30
	ldr r2, [r3, #0]
	ldr lr, _021554E0 // =0x00196225
	ldr ip, _021554E4 // =0x3C6EF35F
	add r10, r0, r4, lsl #4
	mla r1, r2, lr, ip
	str r1, [r3]
	mov r2, r1, lsr #0x10
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	and r2, r2, #0xf
	ldrb r2, [r2, r10]
	cmp r2, #0
	beq _02155318
	cmp r4, #0
	beq _0215530C
	mla r2, r1, lr, ip
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xf
	add r0, r0, r1
	ldrb r0, [r0, #0x50]
	str r2, [r3]
	cmp r0, #0
	movne r0, #3
	strne r0, [sp, #4]
	bne _0215533C
_0215530C:
	mov r0, #0
	str r0, [sp, #4]
	b _0215533C
_02155318:
	mla r2, r1, lr, ip
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #0xf
	add r0, r0, r1
	ldrb r0, [r0, #0x70]
	str r0, [sp, #4]
	str r2, [r3]
_0215533C:
	ldr r0, [sp, #4]
	cmp r0, #9
	addls pc, pc, r0, lsl #2
	b _02155394
_0215534C: // jump table
	b _02155374 // case 0
	b _02155394 // case 1
	b _02155394 // case 2
	b _02155384 // case 3
	b _02155394 // case 4
	b _02155394 // case 5
	b _0215538C // case 6
	b _02155394 // case 7
	b _02155394 // case 8
	b _0215538C // case 9
_02155374:
	ldrh r0, [r11, #0x42]
	add r0, r0, #1
	strh r0, [r11, #0x42]
	b _02155394
_02155384:
	mov r0, #1
	strh r0, [r11, #0x44]
_0215538C:
	mov r0, #0
	strh r0, [r11, #0x42]
_02155394:
	ldr r0, [sp]
	mov r4, #0xc
	ldrb r1, [r0, #1]
	ldr r0, [sp, #4]
	add r0, r0, r1
	add r8, r8, r0, lsl #3
_021553AC:
	ldr r0, _021554DC // =_mt_math_rand
	ldr r1, _021554E0 // =0x00196225
	ldr r2, [r0, #0]
	ldr r0, _021554E4 // =0x3C6EF35F
	mla r1, r2, r1, r0
	ldr r0, _021554DC // =_mt_math_rand
	str r1, [r0]
	mov r0, r1, lsr #0x10
	mov r10, r0, lsl #0x10
	ldrh r1, [r8, #4]
	mov r0, r10, lsr #0x10
	bl FX_DivS32
	ldrh r3, [r8, #4]
	ldr r2, [r6, #0]
	ldr r1, [r8, #0]
	mul r0, r3, r0
	add r2, r6, r2
	add r2, r2, #4
	rsb r0, r0, r10, lsr #16
	add r1, r1, r2
	ldr r2, [r1, r0, lsl #2]
	mov r1, #0xc
	mla r1, r2, r1, r9
	mov r0, #1
_0215540C:
	mla r3, r0, r4, r1
	ldrh r3, [r3, #-6]
	tst r3, #1
	addne r0, r0, #1
	movne r0, r0, lsl #0x10
	movne r0, r0, lsr #0x10
	bne _0215540C
	add r1, r7, r0
	ldrh r0, [r5, #0xb8]
	cmp r1, r0
	bgt _021553AC
_02155438:
	mov r0, #0xc
	mla r9, r2, r0, r9
	ldrh r0, [r9, #6]
	tst r0, #1
	ldr r0, [sp]
	strneh r2, [r11, #0x34]
	ldrb r1, [r0, #0]
	cmp r1, #0xe
	bhs _02155470
	ldrh r0, [r9, #6]
	tst r0, #1
	ldrne r0, [sp]
	addne r1, r1, #7
	strneb r1, [r0]
_02155470:
	ldr r1, [sp, #4]
	ldr r0, [sp]
	strh r1, [r0, #8]
	strh r2, [r0, #6]
	ldrh r0, [r9, #0xa]
	mov r1, r0, lsl #8
	ldr r0, [sp]
	strh r1, [r0, #0xa]
	bl SailManager__GetShipType
	cmp r0, #3
	bne _021554BC
	ldr r0, [sp, #4]
	add r0, r0, #3
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	cmp r0, #0x54
	movhs r0, #0
	strhs r0, [sp, #4]
_021554BC:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0x100
	blo _021551C8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021554D8: .word 0x0000FFFF
_021554DC: .word _mt_math_rand
_021554E0: .word 0x00196225
_021554E4: .word 0x3C6EF35F
_021554E8: .word _0218CD30
	arm_func_end SailEventManager__ProcessSBB

	arm_func_start SailEventManager__LoadMapObjects
SailEventManager__LoadMapObjects: // 0x021554EC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r11, r0
	bl SailManager__GetWork
	ldr r0, [r0, #0xa0]
	str r0, [sp, #0xc]
	bl SailManager__GetWork
	ldr r5, [r0, #0x98]
	bl SailManager__GetShipType
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #8]
	bl SailManager__GetWork
	add r2, sp, #0x10
	mov r1, #0
	str r1, [r2]
	str r1, [r2, #4]
	str r1, [r2, #8]
	ldr r2, [r5, #0xc0]
	mov r1, #0x28
	mla r8, r11, r1, r2
	ldr r1, [sp, #0xc]
	mov r9, r0
	ldrh r2, [r1, #0x36]
	ldr r1, _02155B8C // =0x0000FFFE
	cmp r2, r1
	bne _0215556C
	ldr r0, [sp, #0xc]
	add r1, r1, #1
	strh r1, [r0, #0x36]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215556C:
	ldr r0, [r9, #0xc]
	cmp r0, #1
	beq _02155584
	ldrh r0, [r9, #0x14]
	cmp r0, #0
	beq _02155590
_02155584:
	ldr r0, [sp, #0xc]
	ldr r2, [r0, #0x48]
	b _0215559C
_02155590:
	mov r0, #0x33
	bl GetObjectFileWork
	ldr r2, [r0, #0]
_0215559C:
	ldr r1, [r2, #0]
	cmp r11, #0xff
	ldr r0, [r2, r1]
	add r1, r2, r1
	add r4, r1, r0
	bhs _0215598C
	ldr r0, [r9, #0xc]
	cmp r0, #1
	beq _021555CC
	ldrh r0, [r9, #0x14]
	cmp r0, #0
	beq _021555E8
_021555CC:
	ldrh r0, [r5, #0xb8]
	sub r0, r0, #2
	cmp r11, r0
	bne _02155600
	mov r0, r8
	bl SailBuoy__CreateFromSegment2
	b _02155600
_021555E8:
	ldrh r0, [r5, #0xb8]
	sub r0, r0, #1
	cmp r11, r0
	bne _02155600
	mov r0, r8
	bl SailBuoy__CreateFromSegment2
_02155600:
	ldr r0, [sp, #8]
	cmp r0, #3
	bne _02155684
	mov r6, #0
	mov r7, r6
_02155614:
	mov r0, r8
	mov r1, r7
	bl SailStone__CreateFromSegment
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #5
	blo _02155614
	ldr r2, _02155B90 // =_obj_disp_rand
	ldr r0, _02155B94 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02155B98 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #3
	bne _021557A8
	mov r6, #0
_02155664:
	mov r0, r8
	bl SailSubFish__CreateUnknown1
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #4
	blo _02155664
	b _021557A8
_02155684:
	ldrh r0, [r8, #0x30]
	cmp r0, #0xc
	addls pc, pc, r0, lsl #2
	b _021556C8
_02155694: // jump table
	b _021556C8 // case 0
	b _021556C8 // case 1
	b _021556C8 // case 2
	b _0215575C // case 3
	b _0215575C // case 4
	b _0215575C // case 5
	b _0215575C // case 6
	b _0215575C // case 7
	b _0215575C // case 8
	b _0215575C // case 9
	b _0215575C // case 10
	b _0215575C // case 11
	b _021557A0 // case 12
_021556C8:
	ldr r0, [sp, #8]
	cmp r0, #1
	beq _021557A8
	ldr r7, _02155B90 // =_obj_disp_rand
	ldr r10, _02155B98 // =0x3C6EF35F
	mov r6, #0
_021556E0:
	ldr r1, [r7, #0]
	ldr r0, _02155B94 // =0x00196225
	mla r2, r1, r0, r10
	mov r0, r2, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [r7]
	tst r0, #1
	beq _02155710
	mov r0, r8
	mov r1, #0
	bl SailStone__CreateFromSegment
_02155710:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #3
	blo _021556E0
	ldr r2, _02155B90 // =_obj_disp_rand
	ldr r0, _02155B94 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02155B98 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	beq _021557A8
	mov r0, r8
	bl SailSeagull__CreateFromSegment
	b _021557A8
_0215575C:
	ldr r2, _02155B90 // =_obj_disp_rand
	ldr r0, _02155B94 // =0x00196225
	ldr r3, [r2, #0]
	ldr r1, _02155B98 // =0x3C6EF35F
	mla r1, r3, r0, r1
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r2]
	tst r0, #1
	beq _02155794
	mov r0, r8
	mov r1, #0
	bl SailStone__CreateFromSegment
_02155794:
	mov r0, r8
	bl SailBuoy__CreateFromSegment
	b _021557A8
_021557A0:
	mov r0, r8
	bl SailBuoy__CreateFromSegment2
_021557A8:
	ldrb r0, [r8, #0]
	cmp r0, #0x13
	addls pc, pc, r0, lsl #2
	b _0215598C
_021557B8: // jump table
	b _0215598C // case 0
	b _021558EC // case 1
	b _021558EC // case 2
	b _0215598C // case 3
	b _0215598C // case 4
	b _0215598C // case 5
	b _0215598C // case 6
	b _0215598C // case 7
	b _021558EC // case 8
	b _021558EC // case 9
	b _0215598C // case 10
	b _0215598C // case 11
	b _0215598C // case 12
	b _0215598C // case 13
	b _0215598C // case 14
	b _0215598C // case 15
	b _021558B8 // case 16
	b _02155934 // case 17
	b _02155808 // case 18
	b _0215584C // case 19
_02155808:
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02155820
	bl SailManager__GetShipType
	cmp r0, #3
	bne _0215598C
_02155820:
	mov r7, #0
	mov r6, #2
_02155828:
	mov r0, r8
	mov r1, r6
	bl SailStone__CreateFromSegment
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #8
	blo _02155828
	b _0215598C
_0215584C:
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02155864
	bl SailManager__GetShipType
	cmp r0, #3
	bne _0215598C
_02155864:
	mov r7, #0
	mov r6, #2
_0215586C:
	mov r0, r8
	mov r1, r6
	bl SailStone__CreateFromSegment
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #8
	blo _0215586C
	mov r7, #0
	mov r6, #1
_02155894:
	mov r0, r8
	mov r1, r6
	bl SailStone__CreateFromSegment
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0x10
	blo _02155894
	b _0215598C
_021558B8:
	bl SailManager__GetShipType
	cmp r0, #1
	bne _021558EC
	mov r7, #0
	mov r6, r7
_021558CC:
	mov r0, r8
	mov r1, r6
	bl SailIce__CreateFromSegment
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #3
	blo _021558CC
_021558EC:
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02155920
	mov r7, #0
	mov r6, r7
_02155900:
	mov r0, r8
	mov r1, r6
	bl SailIce__CreateFromSegment
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #8
	blo _02155900
_02155920:
	ldrb r0, [r8, #0]
	cmp r0, #0x10
	bne _0215598C
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02155934:
	mov r5, #0
	mov r4, r5
_0215593C:
	mov r0, r8
	mov r1, r4
	bl SailIce__CreateFromSegment
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #8
	blo _0215593C
	mov r5, #0
	mov r4, #1
_02155964:
	mov r0, r8
	mov r1, r4
	bl SailIce__CreateFromSegment
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #0x20
	blo _02155964
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215598C:
	ldrh r3, [r8, #6]
	ldr r1, _02155B9C // =0x0000FFFF
	cmp r3, r1
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0xc]
	ldrh r2, [r0, #0x36]
	mov r0, #0xc
	cmp r2, r1
	mlane r4, r2, r0, r4
	mlaeq r4, r3, r0, r4
	ldrh r0, [r5, #0xb8]
	ldr r1, [r4, #0]
	cmp r11, r0
	add r6, r4, r1
	addhs sp, sp, #0x1c
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r0, [r4, #4]
	mov r10, #0
	cmp r0, #0
	bls _02155B54
	ldr r0, [sp, #8]
	ldr r2, _02155BA0 // =_0218B9AC
	mov r3, r0, lsl #1
	ldrh r0, [r2, r3]
	ldr r1, _02155BA4 // =_0218B9B4
	str r0, [sp, #4]
	ldrh r0, [r1, r3]
	str r0, [sp]
_02155A00:
	bl SailEventManager__AllocateStageObject
	mov r7, r0
	mov r0, #0
	mov r1, r7
	mov r2, #0x40
	bl MIi_CpuClear16
	ldrh r0, [r6, #0xc]
	add r3, r7, #0x10
	strh r0, [r7, #0x30]
	strh r11, [r7, #0x2c]
	ldrh r0, [r8, #2]
	strh r0, [r7, #0x2e]
	ldmia r6, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [r7, #0x10]
	mov r0, r8
	sub r2, r1, #0x80
	ldr r1, [sp, #4]
	mul r1, r2, r1
	str r1, [r7, #0x10]
	ldr r2, [r7, #0x14]
	ldr r1, [sp]
	mul r1, r2, r1
	str r1, [r7, #0x14]
	ldr r1, [r7, #0x18]
	mov r1, r1, lsl #3
	rsb r1, r1, #0x1000
	str r1, [r7, #0x18]
	ldrh r1, [r6, #0x10]
	str r1, [r7, #0x28]
	ldr r1, [r6, #0x14]
	str r1, [r7, #0x38]
	ldr r1, [r7, #0x18]
	bl SailVoyageManager__Func_2158854
	strh r0, [r7, #0x2e]
	mov r0, r8
	bl SailVoyageManager__Func_2157B14
	ldr r1, [r7, #0x18]
	smull r3, r2, r1, r0
	mov r0, #0x800
	adds r1, r3, r0
	mov r0, #0
	adc r0, r2, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r7, #0x18]
	str r6, [r7, #0x3c]
	ldr r1, [r7, #0x18]
	ldr r0, [r8, #0x24]
	add r1, r1, r0
	str r1, [r7, #0x18]
	ldr r0, [r5, #0x70]
	add r0, r1, r0
	str r0, [r7, #0x18]
	ldrh r0, [r9, #0x62]
	strh r0, [r7, #0x32]
	mov r0, #0x10000000
	str r0, [r7, #0x34]
	ldrh r1, [r6, #0xe]
	orr r0, r1, #0x10000000
	str r0, [r7, #0x34]
	ldr r0, [r5, #0x70]
	cmp r0, #0
	ldrne r0, [r7, #0x34]
	orrne r0, r0, #0x8000000
	strne r0, [r7, #0x34]
	ldr r0, [r9, #0x24]
	tst r0, #4
	beq _02155B2C
	ldr r0, [r7, #0x10]
	rsb r0, r0, #0
	str r0, [r7, #0x10]
	ldr r0, [r7, #0x34]
	orr r0, r0, #0x80000000
	str r0, [r7, #0x34]
_02155B2C:
	ldr r0, [sp, #0xc]
	mov r1, r7
	bl NNS_FndAppendListObject
	add r0, r10, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r4, #4]
	add r6, r6, #0x18
	mov r10, r0, lsr #0x10
	cmp r1, r0, lsr #16
	bhi _02155A00
_02155B54:
	ldrb r0, [r8, #0]
	cmp r0, #7
	blo _02155B68
	cmp r0, #0xe
	blo _02155B78
_02155B68:
	cmp r0, #7
	ldrloh r0, [r9, #0x62]
	addlo r0, r0, #1
	strloh r0, [r9, #0x62]
_02155B78:
	ldr r1, _02155B9C // =0x0000FFFF
	ldr r0, [sp, #0xc]
	strh r1, [r0, #0x36]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02155B8C: .word 0x0000FFFE
_02155B90: .word _obj_disp_rand
_02155B94: .word 0x00196225
_02155B98: .word 0x3C6EF35F
_02155B9C: .word 0x0000FFFF
_02155BA0: .word _0218B9AC
_02155BA4: .word _0218B9B4
	arm_func_end SailEventManager__LoadMapObjects

	arm_func_start SailEventManager__LoadObject
SailEventManager__LoadObject: // 0x02155BA8
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	bl SailManager__GetWork
	ldr r6, [r0, #0xa0]
	bl SailEventManager__AllocateTempObject
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClear16
	ldrh r0, [r5, #0xc]
	mov ip, #0x10000000
	add lr, r4, #0x10
	strh r0, [r4, #0x30]
	ldmia r5, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	ldrh r2, [r5, #0x10]
	orr r3, ip, #0x40000000
	add r0, r6, #0xc
	mov r2, r2, lsl #0xc
	str r2, [r4, #0x28]
	str r3, [r4, #0x34]
	ldr r2, [r5, #0x14]
	mov r1, r4
	str r2, [r4, #0x38]
	bl NNS_FndAppendListObject
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailEventManager__LoadObject

	arm_func_start SailEventManager__ViewCheck
SailEventManager__ViewCheck: // 0x02155C14
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r6, r0
	mov r5, r1
	bl SailManager__GetWork
	ldr r4, [r0, #0xa0]
	add r2, sp, #0
	mov r1, r6
	add r0, r4, #0x24
	bl VEC_Subtract
	ldr r1, [sp]
	ldr r0, [sp, #8]
	mov r2, r1, asr #8
	smull r1, r3, r2, r2
	adds ip, r1, #0x800
	ldr r2, [r4, #0x30]
	mov r1, r5, asr #8
	mov r0, r0, asr #8
	add lr, r1, r2, asr #8
	smull r1, r2, r0, r0
	adc r4, r3, #0
	adds r3, r1, #0x800
	mov r5, ip, lsr #0xc
	smull r1, r0, lr, lr
	adc r2, r2, #0
	adds r1, r1, #0x800
	mov r3, r3, lsr #0xc
	orr r5, r5, r4, lsl #20
	orr r3, r3, r2, lsl #20
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	add r2, r5, r3
	orr r1, r1, r0, lsl #20
	cmp r2, r1
	bge _02155D00
	bl SailManager__GetShipType
	ldr r1, _02155D0C // =_0218B9B4
	mov r0, r0, lsl #1
	ldrh r1, [r1, r0]
	mvn r0, #0xb3
	ldr r2, [r6, #4]
	mul r0, r1, r0
	cmp r2, r0
	blt _02155CE8
	bl SailManager__GetShipType
	ldr r1, _02155D0C // =_0218B9B4
	mov r0, r0, lsl #1
	ldrh r1, [r1, r0]
	mov r0, #0x60
	ldr r2, [r6, #4]
	mul r0, r1, r0
	cmp r2, r0
	ble _02155CF4
_02155CE8:
	add sp, sp, #0xc
	mov r0, #1
	ldmia sp!, {r3, r4, r5, r6, pc}
_02155CF4:
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, pc}
_02155D00:
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02155D0C: .word _0218B9B4
	arm_func_end SailEventManager__ViewCheck

	arm_func_start SailEventManager__RemoveEntry
SailEventManager__RemoveEntry: // 0x02155D10
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	cmp r0, #0
	ldrne r0, [r0, #0xa0]
	cmpne r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x34]
	bic r1, r1, #0x10000000
	str r1, [r4, #0x34]
	ldr r1, [r4, #8]
	cmp r1, #0
	ldrneh r1, [r0, #0x40]
	subne r1, r1, #1
	strneh r1, [r0, #0x40]
	mov r1, #0
	str r1, [r4, #8]
	str r1, [r4, #0xc]
	ldr r1, [r4, #0x34]
	tst r1, #0x40000000
	mov r1, r4
	bne _02155D70
	bl NNS_FndRemoveListObject
	ldmia sp!, {r4, pc}
_02155D70:
	add r0, r0, #0xc
	bl NNS_FndRemoveListObject
	ldmia sp!, {r4, pc}
	arm_func_end SailEventManager__RemoveEntry

	arm_func_start SailEventManager__CreateObject
SailEventManager__CreateObject: // 0x02155D7C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r8, r1
	mov r9, r0
	bl SailManager__GetWork
	ldr r7, [r0, #0x98]
	bl SailEventManager__AllocateStageObject
	ldr r1, [r8, #8]
	mov r6, r0
	ldr r5, [r7, #0xc0]
	mov r0, #0x28
	mov r1, r1, asr #0x13
	mul r4, r1, r0
	mov r0, #0
	mov r1, r6
	mov r2, #0x40
	bl MIi_CpuClear16
	strh r9, [r6, #0x30]
	ldr r0, [r8, #8]
	add r9, r6, #0x10
	mov r0, r0, asr #0x13
	strh r0, [r6, #0x2c]
	ldmia r8, {r0, r1, r2}
	stmia r9, {r0, r1, r2}
	mov r3, #0
	str r3, [r6, #0x3c]
	add r0, r5, r4
	bl SailVoyageManager__Func_2157B14
	mov r1, r0
	ldr r2, [r6, #0x18]
	ldr r0, _02155EB8 // =0x0007FFFF
	and r0, r2, r0
	bl FX_Div
	mov r8, r0
	add r0, r5, r4
	mov r1, r8
	bl SailVoyageManager__Func_2158854
	strh r0, [r6, #0x2e]
	mov r1, r8
	add r0, r5, r4
	add r2, r6, #0x1c
	add r3, r6, #0x24
	bl SailVoyageManager__Func_2158888
	ldrh r2, [r6, #0x2e]
	mov r1, r7
	ldr r7, _02155EBC // =FX_SinCosTable_
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r4, [r7, r2]
	ldr r5, [r6, #0x10]
	add r0, r6, #0x1c
	smull r8, r4, r5, r4
	adds r5, r8, #0x800
	ldr r3, [r6, #0x1c]
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r3, r3, r5
	str r3, [r6, #0x1c]
	ldrh r4, [r6, #0x2e]
	ldr r5, [r6, #0x10]
	ldr r3, [r6, #0x24]
	mov r4, r4, asr #4
	mov r4, r4, lsl #2
	ldrsh r4, [r7, r4]
	mov r2, r0
	smull r7, r4, r5, r4
	adds r5, r7, #0x800
	adc r4, r4, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	add r3, r3, r5
	str r3, [r6, #0x24]
	bl VEC_Subtract
	mov r1, #0x10000000
	mov r0, r6
	str r1, [r6, #0x34]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02155EB8: .word 0x0007FFFF
_02155EBC: .word FX_SinCosTable_
	arm_func_end SailEventManager__CreateObject

	arm_func_start SailEventManager__CreateObject2
SailEventManager__CreateObject2: // 0x02155EC0
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl SailManager__GetShipType
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	bl SailManager__GetWork
	ldr r1, [r4, #0x34]
	ldr r0, [r0, #0xa0]
	tst r1, #0x20000000
	bne _02155EF0
	mov r1, r4
	bl NNS_FndAppendListObject
_02155EF0:
	ldrh r2, [r4, #0x30]
	cmp r2, #1
	bne _02155F14
	add r0, r4, #0x1c
	bl SailRingManager_CreateStageRing
	ldr r1, [r4, #0x34]
	tst r1, #0x20000000
	streq r0, [r4, #0xc]
	ldmia sp!, {r3, r4, r5, pc}
_02155F14:
	cmp r5, #2
	moveq r5, #0
	cmp r5, #3
	subeq r0, r5, #1
	moveq r0, r0, lsl #0x10
	moveq r5, r0, lsr #0x10
	ldr r1, _02155F54 // =sailObjectSpawnList
	mov r0, #0x98
	mla r0, r5, r0, r1
	ldr r1, [r0, r2, lsl #2]
	mov r0, r4
	blx r1
	ldr r1, [r4, #0x34]
	tst r1, #0x20000000
	streq r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02155F54: .word sailObjectSpawnList
	arm_func_end SailEventManager__CreateObject2

	arm_func_start SailEventManager__Destructor
SailEventManager__Destructor: // 0x02155F58
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	mov r4, r0
	mov r0, r5
	bl GetTaskWork_
	mov r5, r0
	ldr r0, [r5, #0x18]
	cmp r0, #0
	beq _02155F98
	ldr r1, [r4, #0xc]
	cmp r1, #0
	beq _02155F94
	bl _FreeHEAP_USER
	b _02155F98
_02155F94:
	bl _FreeHEAP_SYSTEM
_02155F98:
	mov r0, #0
	str r0, [r5, #0x18]
	ldr r0, [r5, #0x1c]
	cmp r0, #0
	beq _02155FB0
	bl _FreeHEAP_USER
_02155FB0:
	mov r0, #0
	str r0, [r5, #0x1c]
	ldr r0, [r5, #0x48]
	cmp r0, #0
	beq _02155FCC
	bl _FreeHEAP_USER
	ldmia sp!, {r3, r4, r5, pc}
_02155FCC:
	mov r0, #0x33
	bl GetObjectFileWork
	bl ObjDataRelease
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailEventManager__Destructor

	arm_func_start SailEventManager__Main
SailEventManager__Main: // 0x02155FDC
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x40
	bl GetCurrentTaskWork_
	mov r5, r0
	bl SailManager__GetWork
	ldr r6, [r0, #0x98]
	bl SailManager__GetWork
	str r0, [sp, #8]
	mov r10, #0
	bl SailManager__GetWork
	ldr r4, [r0, #0x70]
	bl SailVoyageManager__Func_2157AE4
	mov r8, r0
	bl SailManager__GetShipType
	mov r0, r0, lsl #0x10
	cmp r4, #0
	mov r4, r0, lsr #0x10
	ldr r9, [r5, #0x38]
	beq _02156034
	bl SailManager__GetWork
	ldr r0, [r0, #0x70]
	ldr r10, [r0, #0x124]
_02156034:
	ldr r0, [sp, #8]
	ldr r0, [r0, #0x24]
	tst r0, #0x800
	addne sp, sp, #0x40
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r4, #2
	moveq r4, #0
	cmp r4, #3
	subeq r0, r4, #1
	moveq r0, r0, lsl #0x10
	moveq r4, r0, lsr #0x10
	cmp r10, #0
	addne r0, r10, #0x100
	ldrnesh r0, [r0, #0xca]
	ldr r7, [r5, #0]
	cmpne r0, #0
	beq _021560A8
	mov r2, r0, asr #2
	mov r0, #0x30000
	umull r10, r3, r2, r0
	mov r1, #0
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	adds r2, r10, #0x800
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	sub r9, r9, r1
_021560A8:
	ldr r1, _021565C4 // =sailObjectSpawnList
	mov r0, #0x98
	mla r0, r4, r0, r1
	str r0, [sp]
	add r0, r8, r9
	str r0, [sp, #4]
	add r4, sp, #0x34
_021560C4:
	cmp r7, #0
	beq _0215630C
	mov r0, r5
	mov r1, r7
	bl NNS_FndGetNextListObject
	str r0, [sp, #0xc]
	ldr r0, [r7, #0x34]
	tst r0, #0x8000000
	beq _021560F8
	ldr r1, [r7, #0x18]
	ldr r0, [r6, #0x74]
	add r0, r1, r0
	str r0, [r7, #0x18]
_021560F8:
	ldr r0, [r7, #0xc]
	cmp r0, #0
	ldreq r1, [r7, #8]
	cmpeq r1, #0
	bne _021562B0
	ldr r1, [r7, #0x18]
	ldr r0, [sp, #4]
	cmp r0, r1
	ble _02156304
	ldrh r10, [r7, #0x2c]
	ldr r9, [r6, #0xc0]
	mov r3, #0x28
	mla r9, r10, r3, r9
	add r0, r7, #0x10
	add r3, sp, #0x28
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r1, [sp, #0x30]
	ldr r0, [r9, #0x24]
	sub r0, r1, r0
	str r0, [sp, #0x30]
	mov r0, r3
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	mov r0, r9
	bl SailVoyageManager__Func_2157B14
	mov r1, r0
	ldr r0, [sp, #0x30]
	bl FX_Div
	mov r1, r0
	mov r0, r9
	mov r2, r4
	add r3, sp, #0x3c
	bl SailVoyageManager__Func_2158888
	ldrh r1, [r7, #0x2e]
	ldr ip, [sp, #0x28]
	ldr r3, [sp, #0x34]
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, asr #4
	ldr r1, _021565C8 // =FX_SinCosTable_
	mov lr, #0
	add r1, r1, r2, lsl #2
	ldrsh r9, [r1, #2]
	ldr r11, [sp, #0x3c]
	mov r0, r4
	smull r9, r10, ip, r9
	adds r9, r9, #0x800
	adc r10, r10, #0
	mov r9, r9, lsr #0xc
	orr r9, r9, r10, lsl #20
	add r3, r3, r9
	str r3, [sp, #0x34]
	ldrh r3, [r7, #0x2e]
	mov r10, lr
	mov r1, r6
	rsb r3, r3, #0
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	mov r3, r3, asr #4
	mov r9, r3, lsl #2
	ldr r3, _021565C8 // =FX_SinCosTable_
	mov r2, r4
	ldrsh r3, [r3, r9]
	smull r9, r3, ip, r3
	adds r9, r9, #0x800
	adc r3, r3, r10
	mov r9, r9, lsr #0xc
	orr r9, r9, r3, lsl #20
	add r3, r11, r9
	str r3, [sp, #0x3c]
	bl VEC_Subtract
	add r3, r7, #0x1c
	ldmia r4, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r10
	str r0, [r7, #0xc]
	str r0, [r7, #8]
	ldr r0, [sp, #8]
	ldr r1, [r7, #0x34]
	ldrh r0, [r0, #0x5e]
	and r1, r1, #0x700
	cmp r0, r1, lsr #8
	bhs _02156268
	mov r0, r7
	bl SailEventManager__RemoveEntry
	b _02156304
_02156268:
	ldrh r1, [r7, #0x30]
	cmp r1, #1
	bne _02156284
	mov r0, r4
	bl SailRingManager_CreateStageRing
	str r0, [r7, #0xc]
	b _02156304
_02156284:
	ldr r0, [sp]
	ldr r1, [r0, r1, lsl #2]
	cmp r1, #0
	beq _02156304
	mov r0, r7
	blx r1
	str r0, [r7, #8]
	ldrh r0, [r5, #0x40]
	add r0, r0, #1
	strh r0, [r5, #0x40]
	b _02156304
_021562B0:
	ldrh r1, [r7, #0x30]
	cmp r1, #1
	bne _02156304
	ldrh r1, [r0, #0]
	tst r1, #1
	bne _021562D4
	mov r0, r7
	bl SailEventManager__RemoveEntry
	b _02156304
_021562D4:
	ldr r2, [r7, #0x18]
	ldr r1, [r5, #0x3c]
	add r1, r8, r1
	cmp r1, r2
	bge _021562F8
	ldr r1, [r5, #0x38]
	add r1, r8, r1
	cmp r1, r2
	bge _02156304
_021562F8:
	bl SailRingManager_CollectSailRing
	mov r0, r7
	bl SailEventManager__RemoveEntry
_02156304:
	ldr r7, [sp, #0xc]
	b _021560C4
_0215630C:
	add r2, sp, #0x1c
	mov r1, #0
	add r0, sp, #0x10
	str r1, [r2]
	str r1, [r2, #4]
	str r1, [r2, #8]
	str r1, [r0]
	str r1, [r0, #4]
	str r1, [r0, #8]
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _021564D8
_02156340: // jump table
	b _02156350 // case 0
	b _021563D4 // case 1
	b _02156350 // case 2
	b _02156458 // case 3
_02156350:
	ldrh r1, [r6, #0x34]
	mov r0, #0x28000
	ldr r3, _021565C8 // =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r2, [r3, r1]
	rsb r0, r0, #0
	mvn r1, #0
	umull r7, r4, r2, r0
	mla r4, r2, r1, r4
	mov r2, r2, asr #0x1f
	adds r7, r7, #0x800
	mla r4, r2, r0, r4
	adc r2, r4, #0
	mov r4, r7, lsr #0xc
	orr r4, r4, r2, lsl #20
	str r4, [r5, #0x24]
	ldrh r2, [r6, #0x34]
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [r3, r2]
	umull r4, r3, r2, r0
	adds r4, r4, #0x800
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r4, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r5, #0x2c]
	b _021564D8
_021563D4:
	ldrh r1, [r6, #0x34]
	mov r0, #0x30000
	ldr r3, _021565C8 // =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r2, [r3, r1]
	rsb r0, r0, #0
	mvn r1, #0
	umull r7, r4, r2, r0
	mla r4, r2, r1, r4
	mov r2, r2, asr #0x1f
	adds r7, r7, #0x800
	mla r4, r2, r0, r4
	adc r2, r4, #0
	mov r4, r7, lsr #0xc
	orr r4, r4, r2, lsl #20
	str r4, [r5, #0x24]
	ldrh r2, [r6, #0x34]
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [r3, r2]
	umull r4, r3, r2, r0
	adds r4, r4, #0x800
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r4, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r5, #0x2c]
	b _021564D8
_02156458:
	ldrh r1, [r6, #0x34]
	mov r0, #0x68000
	ldr r3, _021565C8 // =FX_SinCosTable_
	mov r1, r1, asr #4
	mov r1, r1, lsl #2
	ldrsh r2, [r3, r1]
	rsb r0, r0, #0
	mvn r1, #0
	umull r7, r4, r2, r0
	mla r4, r2, r1, r4
	mov r2, r2, asr #0x1f
	adds r7, r7, #0x800
	mla r4, r2, r0, r4
	adc r2, r4, #0
	mov r4, r7, lsr #0xc
	orr r4, r4, r2, lsl #20
	str r4, [r5, #0x24]
	ldrh r2, [r6, #0x34]
	mov r2, r2, asr #4
	mov r2, r2, lsl #1
	add r2, r2, #1
	mov r2, r2, lsl #1
	ldrsh r2, [r3, r2]
	umull r4, r3, r2, r0
	adds r4, r4, #0x800
	mla r3, r2, r1, r3
	mov r1, r2, asr #0x1f
	mla r3, r1, r0, r3
	adc r0, r3, #0
	mov r1, r4, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r5, #0x2c]
_021564D8:
	add r0, sp, #0x10
	mov r1, r6
	mov r2, r0
	bl VEC_Add
	mov r8, #0
	mov r7, #0x800
	ldr r4, [r5, #0xc]
	mov r10, r8
	mov r9, r7
_021564FC:
	cmp r4, #0
	addeq sp, sp, #0x40
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, sp, #0x10
	add r2, sp, #0x1c
	add r1, r4, #0x10
	bl VEC_Subtract
	ldr r1, [sp, #0x24]
	ldr r3, [sp, #0x1c]
	mov r11, r1, asr #8
	smull r2, r1, r11, r11
	mov r11, r3, asr #8
	smull ip, r3, r11, r11
	adds r11, ip, #0x800
	adc ip, r3, #0
	adds r2, r2, r7
	mov r3, r11, lsr #0xc
	adc r1, r1, r8
	mov r2, r2, lsr #0xc
	ldr r0, [r4, #0x28]
	orr r3, r3, ip, lsl #20
	orr r2, r2, r1, lsl #20
	add r1, r3, r2
	mov r2, r0, asr #8
	ldr r3, [r5, #0x30]
	ldr r0, [r4, #8]
	add r11, r2, r3, asr #8
	smull r3, r2, r11, r11
	adds r3, r3, r9
	adc r2, r2, r10
	cmp r0, #0
	mov r0, r3, lsr #0xc
	orr r0, r0, r2, lsl #20
	bne _021565A8
	cmp r1, r0
	bge _021565A8
	mov r1, r6
	add r0, r4, #0x10
	add r2, r4, #0x1c
	bl VEC_Subtract
	mov r0, r4
	bl SailLanding__Create
	str r0, [r4, #8]
_021565A8:
	mov r1, r4
	add r0, r5, #0xc
	bl NNS_FndGetNextListObject
	mov r4, r0
	b _021564FC
_021565BC:
	.byte 0x40, 0xD0, 0x8D, 0xE2
	.byte 0xF8, 0x8F, 0xBD, 0xE8
_021565C4: .word sailObjectSpawnList
_021565C8: .word FX_SinCosTable_
	arm_func_end SailEventManager__Main

	arm_func_start SailEventManager__AllocateStageObject
SailEventManager__AllocateStageObject: // 0x021565CC
	stmdb sp!, {r3, lr}
	bl SailManager__GetWork
	ldr r3, [r0, #0xa0]
	ldrh ip, [r3, #0x20]
_021565DC:
	ldrh r0, [r3, #0x20]
	and r0, r0, #0xff
	strh r0, [r3, #0x20]
	ldrh r0, [r3, #0x20]
	ldr r2, [r3, #0x18]
	mov r1, r0
	add r0, r0, #1
	strh r0, [r3, #0x20]
	add r0, r2, r1, lsl #6
	ldr r1, [r0, #0x34]
	tst r1, #0x10000000
	ldmeqia sp!, {r3, pc}
	ldrh r0, [r3, #0x20]
	cmp ip, r0
	bne _021565DC
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end SailEventManager__AllocateStageObject

	arm_func_start SailEventManager__AllocateTempObject
SailEventManager__AllocateTempObject: // 0x02156620
	stmdb sp!, {r3, lr}
	bl SailManager__GetWork
	ldr r0, [r0, #0xa0]
	mov r2, #0
	ldr r3, [r0, #0x1c]
_02156634:
	add r0, r3, r2, lsl #6
	ldr r1, [r0, #0x34]
	tst r1, #0x10000000
	ldmeqia sp!, {r3, pc}
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	cmp r2, #0x10
	blo _02156634
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end SailEventManager__AllocateTempObject

	.rodata

_0218B9AC: // 0x0218B9AC
	.hword 0xA0, 0x1200, 0xA0, 0x400

_0218B9B4: // 0x0218B9B4
	.hword 0xA0, 0x1200, 0xA0, 0x400

aSbbSbJoh00Sbb: // 0x0218B9BC
	.asciz "sbb/sb_joh00.sbb"

aBSbMs000Sbb: // aBSbMs000Sbb
	.asciz "sbb/sb_ms000.sbb"
    .align 4

sailObjectSpawnList: // 0x0218B9E0
	// Jetski/Hovercraft Object List
	.word 0								// SAILOBJECT_0
	.word 0								// SAILOBJECT_1
	.word SailJetItem__Create			// SAILOBJECT_2
	.word SailJetMine__Create			// SAILOBJECT_3
	.word SailJetBob__Create			// SAILOBJECT_4
	.word SailJetShark__Create			// SAILOBJECT_5
	.word SailJetShark__Create			// SAILOBJECT_6
	.word SailJetBird__Create			// SAILOBJECT_7
	.word SailJetJumpRamp__Create		// SAILOBJECT_8
	.word SailJetCreateDashPanel		// SAILOBJECT_9
	.word SailJetJumpRamp__Create		// SAILOBJECT_10
	.word SailJetBob__Create			// SAILOBJECT_11
	.word SailJetBird__Create			// SAILOBJECT_12
	.word SailJetBomber__Create			// SAILOBJECT_13
	.word SailHoverEnemyHover1__Create	// SAILOBJECT_14
	.word SailHoverEnemyHover1__Create	// SAILOBJECT_15
	.word SailHoverEnemyHover2__Create	// SAILOBJECT_16
	.word SailHoverEnemyHover2__Create	// SAILOBJECT_17
	.word SailHoverBoat02__Create		// SAILOBJECT_18
	.word SailHoverBoat01__Create		// SAILOBJECT_19
	.word SailHoverBob__Create			// SAILOBJECT_20
	.word SailHoverBobBird__Create		// SAILOBJECT_21
	.word SailHoverBobBird__Create		// SAILOBJECT_22
	.word SailHoverBobBird__Create		// SAILOBJECT_23
	.word SailHoverBobBird__Create		// SAILOBJECT_24
	.word SailHoverBobBird__Create		// SAILOBJECT_25
	.word SailStone__Create				// SAILOBJECT_26
	.word 0								// SAILOBJECT_27
	.word 0								// SAILOBJECT_28
	.word 0								// SAILOBJECT_29
	.word 0								// SAILOBJECT_30
	.word SailBuoy__Create				// SAILOBJECT_31
	.word SailSeagull__Create			// SAILOBJECT_32
	.word SailStone__Create				// SAILOBJECT_33
	.word SailIce__Create				// SAILOBJECT_34
	.word SailSeagull2__Create			// SAILOBJECT_35
	.word SailSubFish__Create			// SAILOBJECT_36
	.word SailJetBoatCloud__Create		// SAILOBJECT_37

	// Sailboat Object List
	.word 0								// SAILOBJECT_0
	.word 0								// SAILOBJECT_1
	.word SailJetItem__Create			// SAILOBJECT_2
	.word SailSailerBoat03__Create		// SAILOBJECT_3
	.word SailSailerBoat03__Create		// SAILOBJECT_4
	.word SailSailerBoat03__Create		// SAILOBJECT_5
	.word SailSailerBoat03__Create		// SAILOBJECT_6
	.word SailSailerBoat02__Create		// SAILOBJECT_7
	.word SailSailerBoat02__Create		// SAILOBJECT_8
	.word SailSailerBoat02__Create		// SAILOBJECT_9
	.word SailSailerBoat02__Create		// SAILOBJECT_10
	.word SailSailerBigBob01__Create	// SAILOBJECT_11
	.word SailSailerBigBob01__Create	// SAILOBJECT_12
	.word SailSailerBigBob02__Create	// SAILOBJECT_13
	.word SailSailerCruiser__Create		// SAILOBJECT_14
	.word SailSailerCruiser__Create		// SAILOBJECT_15
	.word SailSailerCruiser__Create		// SAILOBJECT_16
	.word SailSailerCruiser__Create		// SAILOBJECT_17
	.word SailSailerBird__Create		// SAILOBJECT_18
	.word SailSailerBird__Create		// SAILOBJECT_19
	.word SailSailerBird__Create		// SAILOBJECT_20
	.word SailSailerBoat01__Create		// SAILOBJECT_21
	.word SailSailerBoat02_2__Create	// SAILOBJECT_22
	.word SailSailerCruiser02__Create	// SAILOBJECT_23
	.word SailSailerBird__Create		// SAILOBJECT_24
	.word SailSailerBird__Create		// SAILOBJECT_25
	.word SailSailerBigBob01__Create	// SAILOBJECT_26
	.word SailSailerBoat03__Create		// SAILOBJECT_27
	.word SailSailerBoat02__Create		// SAILOBJECT_28
	.word SailJetMine__Create			// SAILOBJECT_29
	.word SailStone__Create				// SAILOBJECT_30
	.word SailBuoy__Create				// SAILOBJECT_31
	.word SailSeagull__Create			// SAILOBJECT_32
	.word SailStone__Create				// SAILOBJECT_33
	.word SailIce__Create				// SAILOBJECT_34
	.word SailSeagull2__Create			// SAILOBJECT_35
	.word SailSubFish__Create			// SAILOBJECT_36
	.word SailJetBoatCloud__Create		// SAILOBJECT_37

	// Submarine Object List
	.word 0								// SAILOBJECT_0
	.word 0								// SAILOBJECT_1
	.word SailSubItem__Create			// SAILOBJECT_2
	.word SailSubBoat02__Create			// SAILOBJECT_3
	.word SailSubMine__Create			// SAILOBJECT_4
	.word SailSubShark__Create			// SAILOBJECT_5
	.word SailSubShark__Create			// SAILOBJECT_6
	.word SailSubShark__Create			// SAILOBJECT_7
	.word SailSubShark__Create			// SAILOBJECT_8
	.word SailSubShark__Create			// SAILOBJECT_9
	.word SailSubShark__Create			// SAILOBJECT_10
	.word SailSubMine2__Create			// SAILOBJECT_11
	.word SailSubDepth__Create			// SAILOBJECT_12
	.word SailSubDepth__Create			// SAILOBJECT_13
	.word SailSubDepth__Create			// SAILOBJECT_14
	.word SailSubDepth__Create			// SAILOBJECT_15
	.word SailSubDepth__Create			// SAILOBJECT_16
	.word SailSubDepth__Create			// SAILOBJECT_17
	.word SailSubDepth__Create			// SAILOBJECT_18
	.word SailSubDepth__Create			// SAILOBJECT_19
	.word SailSubShark__Create			// SAILOBJECT_20
	.word SailSubShark__Create			// SAILOBJECT_21
	.word SailSubDepth__Create			// SAILOBJECT_22
	.word SailSubDepth__Create			// SAILOBJECT_23
	.word 0								// SAILOBJECT_24
	.word 0								// SAILOBJECT_25
	.word 0								// SAILOBJECT_26
	.word 0								// SAILOBJECT_27
	.word 0								// SAILOBJECT_28
	.word 0								// SAILOBJECT_29
	.word 0								// SAILOBJECT_30
	.word SailBuoy__Create				// SAILOBJECT_31
	.word SailSeagull__Create			// SAILOBJECT_32
	.word SailStone__Create				// SAILOBJECT_33
	.word SailIce__Create				// SAILOBJECT_34
	.word SailSeagull2__Create			// SAILOBJECT_35
	.word SailSubFish__Create			// SAILOBJECT_36
	.word 0								// SAILOBJECT_37

	.data

_0218CD30: // 0x0218CD30
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x09, 0x09, 0x09, 0x09
	.byte 0x06, 0x06, 0x03, 0x03, 0x03, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09

aSbJetSbb: // 0x0218CDB0
	.asciz "sb_jet.sbb"
	.align 4