	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SailRingManager_Create
SailRingManager_Create: // 0x02156660
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r0, #0x1000
	mov r2, #0
	str r0, [sp]
	mov r0, #1
	ldr r4, _021566C0 // =0x0000090C
	str r0, [sp, #4]
	ldr r0, _021566C4 // =SailRingManager_Main
	ldr r1, _021566C8 // =SailRingManager_Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _021566C0 // =0x0000090C
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r0, r4
	bl SailRingManager_Func_21571C4
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021566C0: .word 0x0000090C
_021566C4: .word SailRingManager_Main
_021566C8: .word SailRingManager_Destructor
	arm_func_end SailRingManager_Create

	arm_func_start SailRingManager_CreateStageRing
SailRingManager_CreateStageRing: // 0x021566CC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl SailManager__GetWork
	ldr ip, [r0, #0x9c]
	mov r3, #0
	mov r1, #0x1c
_021566E4:
	mul r2, r3, r1
	ldrh r0, [ip, r2]
	add r4, ip, r2
	tst r0, #1
	bne _02156760
	mov r1, r4
	mov r0, #0
	mov r2, #0x1c
	bl MIi_CpuClear16
	ldrh r0, [r4, #0]
	add r3, r4, #4
	orr r0, r0, #1
	strh r0, [r4]
	ldmia r5, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	bl SailManager__GetShipType
	cmp r0, #3
	ldrne r0, [r4, #8]
	subne r0, r0, #0x800
	strne r0, [r4, #8]
	bne _02156758
	ldr r1, [r4, #8]
	mov r0, #0x26
	sub r1, r1, #0x10000
	str r1, [r4, #8]
	strh r0, [r4, #2]
	ldrh r0, [r4, #0]
	orr r0, r0, #0x24
	strh r0, [r4]
_02156758:
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}
_02156760:
	add r0, r3, #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	cmp r3, #0x40
	blo _021566E4
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SailRingManager_CreateStageRing

	arm_func_start SailRingManager_CreateObjectRing
SailRingManager_CreateObjectRing: // 0x0215677C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl SailManager__GetWork
	ldr ip, [r0, #0x9c]
	mov r3, #0
	mov r1, #0x1c
_02156798:
	mul r2, r3, r1
	ldrh r0, [ip, r2]
	add r4, ip, r2
	tst r0, #1
	bne _02156808
	mov r1, r4
	mov r0, #0
	mov r2, #0x1c
	bl MIi_CpuClear16
	ldrh r0, [r4, #0]
	add r3, r4, #4
	add ip, r4, #0x10
	orr r0, r0, #1
	strh r0, [r4]
	ldmia r6, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r4, #8]
	mov r3, #0x3c
	sub r0, r0, #0x800
	str r0, [r4, #8]
	ldrh r0, [r4, #0]
	orr r0, r0, #0x20
	strh r0, [r4]
	ldmia r5, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	mov r0, r4
	strh r3, [r4, #2]
	ldmia sp!, {r4, r5, r6, pc}
_02156808:
	add r0, r3, #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	cmp r3, #0x40
	blo _02156798
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SailRingManager_CreateObjectRing

	arm_func_start SailRingManager_CollectSailRing
SailRingManager_CollectSailRing: // 0x02156824
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #0]
	bic r1, r1, #1
	strh r1, [r0]
	bl SailManager__GetWork
	ldr r1, [r0, #0x70]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldrh r0, [r1, #0]
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, [r1, #0x124]
	add r0, r0, #0x100
	ldrsh r1, [r0, #0xe4]
	add r1, r1, #1
	strh r1, [r0, #0xe4]
	ldmia sp!, {r3, pc}
	arm_func_end SailRingManager_CollectSailRing

	arm_func_start SailRingManager_Destructor
SailRingManager_Destructor: // 0x02156868
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x700
	bl AnimatorSprite3D__Release
	add r0, r4, #4
	mov r1, #0
	add r0, r0, #0x800
	str r1, [r4, #0x8e0]
	bl AnimatorSprite3D__Release
	ldmia sp!, {r4, pc}
	arm_func_end SailRingManager_Destructor

	arm_func_start SailRingManager_Main
SailRingManager_Main: // 0x02156894
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailRingManager_UpdateRings
	mov r0, r4
	bl SailRingManager_DrawRings
	ldmia sp!, {r4, pc}
	arm_func_end SailRingManager_Main

	arm_func_start SailRingManager_UpdateRings
SailRingManager_UpdateRings: // 0x021568B0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	bl SailVoyageManager__Func_2157AF4
	mov r8, r0
	bl SailManager__GetShipType
	cmp r0, #3
	beq _0215694C
	mov r6, #0
	mov r4, #0xa00
	mov r7, #0x1c
_021568DC:
	mul r1, r6, r7
	ldrh r0, [r10, r1]
	add r5, r10, r1
	tst r0, #1
	beq _02156930
	tst r0, #0x20
	beq _02156920
	add r0, r5, #4
	add r1, r5, #0x10
	mov r2, r0
	bl VEC_Add
	ldr r0, [r5, #0x14]
	add r0, r0, #0x82
	str r0, [r5, #0x14]
	cmp r0, #0xa00
	strgt r4, [r5, #0x14]
	b _02156930
_02156920:
	add r0, r5, #4
	mov r1, r8
	mov r2, r0
	bl VEC_Subtract
_02156930:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x40
	blo _021568DC
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0215694C:
	ldr r1, [r8, #8]
	mov r0, #0x1800
	mov r9, #0
	umull r3, r2, r1, r0
	mla r2, r1, r9, r2
	mov r1, r1, asr #0x1f
	mla r2, r1, r0, r2
	adds r3, r3, #0x800
	adc r0, r2, #0
	mov r1, r3, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r8, #8]
	add r7, sp, #0
	ldmia r8, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	mov r5, r9
	mov r11, #0x800
	mvn r4, #7
	mov r6, #0x1c
_02156998:
	mul r1, r9, r6
	ldrh r0, [r10, r1]
	add r3, r10, r1
	tst r0, #1
	beq _02156A98
	tst r0, #8
	bne _02156A98
	tst r0, #0x20
	beq _02156A88
	ldmia r8, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	ldrsh r0, [r3, #2]
	sub r0, r0, #1
	strh r0, [r3, #2]
	ldrsh r0, [r3, #2]
	cmp r0, #0x10
	bgt _02156A08
	cmp r0, #8
	blt _02156A08
	sub r0, r0, #8
	ldr r1, [sp, #8]
	mov r0, r0, lsl #9
	smull r2, r0, r1, r0
	adds r1, r2, r11
	adc r0, r0, r5
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #8]
_02156A08:
	ldrsh r0, [r3, #2]
	cmp r0, #9
	ldreqh r0, [r3, #0]
	biceq r0, r0, #4
	streqh r0, [r3]
	ldrsh r0, [r3, #2]
	cmp r0, #0
	bgt _02156A60
	cmp r0, r4
	blt _02156A60
	cmp r0, #0
	rsblt r0, r0, #0
	ldr r1, [sp, #8]
	mov r0, r0, lsl #9
	smull ip, r2, r1, r0
	mov r0, #0x800
	adds r1, ip, r0
	mov r0, #0
	adc r0, r2, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #8]
_02156A60:
	ldrsh r0, [r3, #2]
	cmp r0, #8
	bgt _02156A74
	cmp r0, #0
	bge _02156A98
_02156A74:
	add r0, r3, #4
	mov r1, r7
	mov r2, r0
	bl VEC_Subtract
	b _02156A98
_02156A88:
	add r0, r3, #4
	mov r1, r8
	mov r2, r0
	bl VEC_Subtract
_02156A98:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #0x40
	blo _02156998
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end SailRingManager_UpdateRings

	arm_func_start SailRingManager_Func_2156AB4
SailRingManager_Func_2156AB4: // 0x02156AB4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x44
	mov r10, r0
	mov r0, #0
	mov r9, r1
	add r2, sp, #0
	mov r1, r0
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	str r0, [r2]
	bl SailManager__GetShipType
	cmp r0, #1
	beq _02156B0C
	bl SailManager__GetShipType
	cmp r0, #3
	bne _02156B20
_02156B0C:
	mov r0, r10
	mov r1, r9
	bl SailRingManager_CheckCollisions
	add sp, sp, #0x44
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
_02156B20:
	ldrh r0, [r9, #0]
	cmp r0, #0
	addne sp, sp, #0x44
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r7, [r9, #0x124]
	mov r1, #0x800
	str r1, [sp, #0x24]
	ldr r0, [r9, #0x24]
	mov r8, #0
	tst r0, #1
	movne r0, r1, lsl #1
	strne r0, [sp, #0x24]
	add r5, sp, #0
	mov r4, #0x1c
_02156B58:
	mul r1, r8, r4
	ldrh r0, [r10, r1]
	add r6, r10, r1
	tst r0, #1
	beq _02156BB0
	tst r0, #4
	bne _02156BB0
	add r0, r6, #4
	ldmia r0, {r0, r1, r2}
	stmia r5, {r0, r1, r2}
	ldr r0, [sp, #4]
	mov r1, r5
	rsb r0, r0, #0
	add r2, r0, #0x400
	add r0, r7, #0x34
	str r2, [sp, #4]
	bl SailObject__CheckCollisions
	cmp r0, #0
	beq _02156BB0
	mov r0, r6
	mov r1, r9
	bl SailRingManager_GivePlayerRing
_02156BB0:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0x40
	blo _02156B58
	add sp, sp, #0x44
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end SailRingManager_Func_2156AB4

	arm_func_start SailRingManager_CheckCollisions
SailRingManager_CheckCollisions: // 0x02156BCC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x44
	mov r10, r0
	mov r0, #0
	mov r9, r1
	add r2, sp, #0
	mov r1, r0
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	str r0, [r2]
	ldrh r0, [r9, #0]
	cmp r0, #0
	addeq sp, sp, #0x44
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r7, [r9, #0x124]
	bl SailManager__GetWork
	ldr r6, [r0, #0x70]
	mov r0, #0x1800
	str r0, [sp, #0x24]
	ldrh r0, [r7, #0x28]
	add r4, sp, #0
	mov r11, #0x1c
	cmp r0, #2
	bne _02156CD4
	mov r8, #0
_02156C48:
	mul r1, r8, r11
	ldrh r0, [r10, r1]
	add r5, r10, r1
	tst r0, #1
	beq _02156CB8
	tst r0, #4
	bne _02156CB8
	add r0, r5, #4
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r1, [sp, #4]
	mov r0, r4
	rsb r1, r1, #0
	add r2, r1, #0x1000
	add r1, r7, #0x2c
	str r2, [sp, #4]
	bl SailObject__Func_2165624
	cmp r0, #0
	beq _02156CB8
	ldr r1, [r9, #0x24]
	mov r0, r5
	orr r1, r1, #0x10
	str r1, [r9, #0x24]
	ldrh r2, [r5, #0]
	mov r1, r6
	bic r2, r2, #0x20
	strh r2, [r5]
	bl SailRingManager_GivePlayerRing
_02156CB8:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #0x40
	blo _02156C48
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02156CD4:
	mov r5, #0
_02156CD8:
	mul r1, r5, r11
	ldrh r0, [r10, r1]
	add r8, r10, r1
	tst r0, #1
	beq _02156D48
	tst r0, #4
	bne _02156D48
	add r0, r8, #4
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r1, [sp, #4]
	mov r0, r4
	rsb r1, r1, #0
	add r2, r1, #0x1000
	add r1, r7, #0x2c
	str r2, [sp, #4]
	bl SailObject__CheckCollisions
	cmp r0, #0
	beq _02156D48
	ldr r1, [r9, #0x24]
	mov r0, r8
	orr r1, r1, #0x10
	str r1, [r9, #0x24]
	ldrh r2, [r8, #0]
	mov r1, r6
	bic r2, r2, #0x20
	strh r2, [r8]
	bl SailRingManager_GivePlayerRing
_02156D48:
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #0x40
	blo _02156CD8
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end SailRingManager_CheckCollisions

	arm_func_start SailRingManager_GivePlayerRing
SailRingManager_GivePlayerRing: // 0x02156D64
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r8, r0
	mov r7, r1
	mov r5, #1
	bl SailManager__GetWork
	mov r1, #0x400
	mov r6, r0
	mov r0, r7
	rsb r1, r1, #0
	ldr r4, [r7, #0x124]
	bl SailPlayer__RemoveHealth
	ldrh r2, [r8, #0]
	mov r1, #0
	ldr r0, _02156EFC // =0x0000270F
	orr r2, r2, #0xc
	strh r2, [r8]
	strh r1, [r8, #2]
	str r1, [r8, #0x10]
	str r1, [r8, #0x14]
	str r1, [r8, #0x18]
	ldr r1, [r4, #0x1a4]
	add r1, r1, #1
	str r1, [r4, #0x1a4]
	cmp r1, r0
	strhi r0, [r4, #0x1a4]
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _02156E2C
_02156DDC: // jump table
	b _02156DEC // case 0
	b _02156E1C // case 1
	b _02156DEC // case 2
	b _02156E1C // case 3
_02156DEC:
	mov r0, r7
	mov r1, #0x2000
	bl SailPlayer__GiveBoost
	add r0, r4, #0x100
	ldrh r3, [r0, #0xc4]
	mov r2, #0x50
	mov r1, #0
	add r3, r3, #1
	strh r3, [r0, #0xc4]
	strh r2, [r0, #0xe2]
	strh r1, [r0, #0xe4]
	b _02156E2C
_02156E1C:
	add r0, r4, #0x100
	ldrh r1, [r0, #0xc4]
	add r1, r1, #1
	strh r1, [r0, #0xc4]
_02156E2C:
	add r0, r4, #0x100
	ldrh r2, [r0, #0xc4]
	ldr r1, _02156F00 // =0x000003E7
	cmp r2, r1
	strhih r1, [r0, #0xc4]
	add r0, r4, #0x100
	ldrh r2, [r0, #0xc4]
	ldrh r1, [r0, #0xc6]
	cmp r1, r2
	strloh r2, [r0, #0xc6]
	ldr r0, [r6, #0x24]
	tst r0, #0x1000000
	bne _02156E70
	add r2, r8, #4
	mov r0, #0
	mov r1, #0x14
	bl SailAudio__PlaySpatialSequence
_02156E70:
	ldr r1, [r6, #0x24]
	add r0, r4, #0x100
	orr r1, r1, #0x1000000
	str r1, [r6, #0x24]
	ldrh r0, [r0, #0xc4]
	mov r1, #0x32
	bl FX_DivS32
	add r0, r5, r0
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	ldr r1, [r4, #0x1a8]
	mov r0, #0x64
	mla r1, r5, r0, r1
	ldr r0, _02156F04 // =0x05F5E0FF
	str r1, [r4, #0x1a8]
	cmp r1, r0
	strhi r0, [r4, #0x1a8]
	add r0, r8, #4
	cmp r5, #9
	add r3, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [sp, #4]
	movhi r5, #9
	rsb r0, r0, #0
	str r0, [sp, #4]
	add r0, sp, #0
	mov r2, r5
	mov r1, #0x64
	bl SailScoreBonus__CreateWorld
	ldrh r1, [r0, #4]
	mov r1, r1, asr #1
	strh r1, [r0, #4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02156EFC: .word 0x0000270F
_02156F00: .word 0x000003E7
_02156F04: .word 0x05F5E0FF
	arm_func_end SailRingManager_GivePlayerRing

	arm_func_start SailRingManager_DrawRings
SailRingManager_DrawRings: // 0x02156F08
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov r10, r0
	add r0, r10, #4
	add r6, r0, #0x800
	ldr r8, [r6, #0xd4]
	add r5, r10, #0x700
	mov r0, #4
	strb r0, [r5, #0xa]
	strb r0, [r6, #0xa]
	ldr r0, [r10, #0x700]
	cmp r0, #1
	beq _02156F4C
	cmp r0, #2
	beq _02156F58
	cmp r0, #3
	beq _02156F64
	b _02156F74
_02156F4C:
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	b _02156F74
_02156F58:
	mov r0, r5
	bl AnimatorShape3D__ProcessAnimation
	b _02156F74
_02156F64:
	mov r1, #0
	mov r0, r5
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
_02156F74:
	ldr r0, _021571C0 // =NNS_G3dGlb+0x0000004C
	add r1, r5, #0x24
	bl Camera3D__CopyMatrix3x3
	add r7, r5, #0x24
	ldmia r7!, {r0, r1, r2, r3}
	add r4, r6, #0x24
	stmia r4!, {r0, r1, r2, r3}
	ldmia r7!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldr r0, [r7, #0]
	mov r9, #0
	str r0, [r4]
	add r0, r10, #0x900
	add r4, r6, #0x48
	add r11, r5, #0x48
	str r0, [sp]
_02156FB4:
	mov r0, #0x1c
	mul r1, r9, r0
	ldrh r0, [r10, r1]
	add r7, r10, r1
	tst r0, #1
	beq _021571A4
	tst r0, #2
	bne _021571A4
	tst r0, #8
	add r0, r7, #4
	ldmia r0, {r0, r1, r2}
	beq _02157074
	stmia r4, {r0, r1, r2}
	ldr r0, [r6, #0x4c]
	rsb r0, r0, #0
	str r0, [r6, #0x4c]
	ldr r0, [sp]
	ldrsh r1, [r7, #2]
	ldrh r0, [r0, #8]
	mov r1, r1, asr #1
	mla r0, r1, r0, r8
	str r0, [r6, #0xd4]
	ldr r0, [r6, #0]
	cmp r0, #1
	beq _0215702C
	cmp r0, #2
	beq _02157038
	cmp r0, #3
	beq _02157044
	b _0215704C
_0215702C:
	mov r0, r6
	bl AnimatorMDL__Draw
	b _0215704C
_02157038:
	mov r0, r6
	bl AnimatorShape3D__Draw
	b _0215704C
_02157044:
	mov r0, r6
	bl AnimatorSprite3D__Draw
_0215704C:
	ldrsh r0, [r7, #2]
	add r0, r0, #1
	strh r0, [r7, #2]
	ldrsh r0, [r7, #2]
	cmp r0, #0xc
	blt _02157198
	ldrh r0, [r7, #0]
	bic r0, r0, #1
	strh r0, [r7]
	b _02157198
_02157074:
	stmia r11, {r0, r1, r2}
	ldr r0, [r5, #0x4c]
	rsb r0, r0, #0
	str r0, [r5, #0x4c]
	ldrsh r0, [r7, #2]
	cmp r0, #0
	beq _02157158
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02157158
	ldrsh r0, [r7, #2]
	sub r0, r0, #1
	strh r0, [r7, #2]
	ldrsh r0, [r7, #2]
	cmp r0, #0x10
	bge _02157100
	tst r0, #1
	beq _02157140
	ldr r0, [r5, #0]
	cmp r0, #1
	beq _021570DC
	cmp r0, #2
	beq _021570E8
	cmp r0, #3
	beq _021570F4
	b _02157140
_021570DC:
	mov r0, r5
	bl AnimatorMDL__Draw
	b _02157140
_021570E8:
	mov r0, r5
	bl AnimatorShape3D__Draw
	b _02157140
_021570F4:
	mov r0, r5
	bl AnimatorSprite3D__Draw
	b _02157140
_02157100:
	ldr r0, [r5, #0]
	cmp r0, #1
	beq _02157120
	cmp r0, #2
	beq _0215712C
	cmp r0, #3
	beq _02157138
	b _02157140
_02157120:
	mov r0, r5
	bl AnimatorMDL__Draw
	b _02157140
_0215712C:
	mov r0, r5
	bl AnimatorShape3D__Draw
	b _02157140
_02157138:
	mov r0, r5
	bl AnimatorSprite3D__Draw
_02157140:
	ldrsh r0, [r7, #2]
	cmp r0, #0
	bne _02157198
	mov r0, r7
	bl SailRingManager_CollectSailRing
	b _02157198
_02157158:
	ldr r0, [r5, #0]
	cmp r0, #1
	beq _02157178
	cmp r0, #2
	beq _02157184
	cmp r0, #3
	beq _02157190
	b _02157198
_02157178:
	mov r0, r5
	bl AnimatorMDL__Draw
	b _02157198
_02157184:
	mov r0, r5
	bl AnimatorShape3D__Draw
	b _02157198
_02157190:
	mov r0, r5
	bl AnimatorSprite3D__Draw
_02157198:
	mov r0, #8
	strb r0, [r5, #0xa]
	strb r0, [r6, #0xa]
_021571A4:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #0x40
	blo _02156FB4
	str r8, [r6, #0xd4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_021571C0: .word NNS_G3dGlb+0x0000004C
	arm_func_end SailRingManager_DrawRings

	arm_func_start SailRingManager_Func_21571C4
SailRingManager_Func_21571C4: // 0x021571C4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r8, r0
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _021573C4 // =aSbRingBac
	mov r0, #0
	bl ObjDataLoad
	mov r6, r0
	bl Sprite__GetTextureSize
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r4, r0
	mov r0, r6
	bl Sprite__GetPaletteSize
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0
	mov r5, r0
	add r0, r8, #0x700
	mov r2, r6
	mov r3, r1
	stmia sp, {r1, r4, r5}
	bl AnimatorSprite3D__Init
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0215724C
_0215723C: // jump table
	b _0215724C // case 0
	b _02157254 // case 1
	b _0215724C // case 2
	b _02157254 // case 3
_0215724C:
	mov r0, #0x40
	b _02157258
_02157254:
	mov r0, #0x100
_02157258:
	str r0, [r8, #0x718]
	str r0, [r8, #0x71c]
	str r0, [r8, #0x720]
	ldr r0, [r8, #0x7f4]
	mov r1, #0
	orr r0, r0, #0x8000
	str r0, [r8, #0x7f4]
	mov r2, r1
	add r0, r8, #0x700
	bl AnimatorSprite3D__ProcessAnimation
	ldr r1, [r8, #0x7cc]
	mov r0, r6
	orr r1, r1, #4
	str r1, [r8, #0x7cc]
	add r4, r8, #4
	bl Sprite__GetTextureSize
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r0, #6
	mul r0, r7, r0
	mov r1, #0
	bl VRAMSystem__AllocTexture
	add r1, r8, #0x900
	strh r7, [r1, #8]
	mov r8, r0
	mov r1, #0
	stmia sp, {r1, r8}
	mov r2, r6
	add r0, r4, #0x800
	mov r3, r1
	str r5, [sp, #8]
	bl AnimatorSprite3D__Init
	mov r0, #0x40
	str r0, [r4, #0x818]
	str r0, [r4, #0x81c]
	str r0, [r4, #0x820]
	ldr r0, [r4, #0x890]
	cmp r0, #1
	beq _02157308
	cmp r0, #2
	beq _02157318
	cmp r0, #3
	beq _02157328
	b _02157334
_02157308:
	add r0, r4, #0x890
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	b _02157334
_02157318:
	add r0, r4, #0x890
	mov r1, #1
	bl AnimatorSpriteDS__SetAnimation
	b _02157334
_02157328:
	add r0, r4, #0x890
	mov r1, #1
	bl AnimatorSpriteDS__SetAnimation2
_02157334:
	mov r0, #0x1000
	str r0, [r4, #0x8c8]
	bl SailManager__GetShipType
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0215735C
_0215734C: // jump table
	b _0215735C // case 0
	b _02157364 // case 1
	b _0215735C // case 2
	b _02157364 // case 3
_0215735C:
	mov r0, #0x40
	b _02157368
_02157364:
	mov r0, #0x100
_02157368:
	str r0, [r4, #0x818]
	str r0, [r4, #0x81c]
	str r0, [r4, #0x820]
	ldr r0, [r4, #0x8f4]
	mov r6, #0
	orr r0, r0, #0x8000
	str r0, [r4, #0x8f4]
	mov r5, r6
_02157388:
	mov r1, r5
	mov r2, r5
	add r0, r4, #0x800
	bl AnimatorSprite3D__ProcessAnimation
	add r0, r6, #1
	ldr r1, [r4, #0x8d4]
	mov r0, r0, lsl #0x10
	add r1, r1, r7
	mov r6, r0, lsr #0x10
	str r1, [r4, #0x8d4]
	cmp r6, #6
	blo _02157388
	str r8, [r4, #0x8d4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_021573C4: .word aSbRingBac
	arm_func_end SailRingManager_Func_21571C4

	.data

aSbRingBac: // 0x0218CDBC
	.asciz "sb_ring.bac"
	.align 4