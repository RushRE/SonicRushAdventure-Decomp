	.include "asm/macros.inc"
	.include "global.inc"
	
.public _021895C0
	
	.text

	arm_func_start Truck3DTrigger__Create
Truck3DTrigger__Create: // 0x0216F61C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r2, #0
	str r3, [sp]
	mov r4, #2
	str r4, [sp, #4]
	mov r4, #0x364
	ldr r0, _0216F750 // =StageTask_Main
	ldr r1, _0216F754 // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, #0x364
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r0, [r4, #0x1c]
	orr r0, r0, #0x2100
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x20]
	orr r0, r0, #0x20
	str r0, [r4, #0x20]
	ldrh r0, [r7, #2]
	cmp r0, #0xb2
	moveq r0, #0x5c
	beq _0216F6E4
	cmp r0, #0xb4
	blo _0216F6E0
	cmp r0, #0xb6
	movls r0, #0x20
	bls _0216F6E4
_0216F6E0:
	mov r0, #0x40
_0216F6E4:
	str r4, [r4, #0x234]
	mov r5, #0x100
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	add r0, r4, #0x218
	sub r1, r5, #0x140
	sub r2, r5, #0x160
	sub r3, r5, #0x200
	str r5, [sp, #8]
	bl ObjRect__SetBox3D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _0216F758 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _0216F75C // =Object58__OnDefend_2173030
	mov r0, r4
	str r1, [r4, #0x23c]
	ldr r1, [r4, #0x230]
	orr r1, r1, #0x400
	str r1, [r4, #0x230]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0216F750: .word StageTask_Main
_0216F754: .word GameObject__Destructor
_0216F758: .word 0x0000FFFE
_0216F75C: .word Object58__OnDefend_2173030
	arm_func_end Truck3DTrigger__Create

	arm_func_start Truck3D__Func_216F760
Truck3D__Func_216F760: // 0x0216F760
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x3c
	mov r10, r0
	mov r0, r1
	str r0, [sp, #0x1c]
	str r0, [sp, #0x18]
	mov r0, #0
	str r1, [sp, #0x14]
	mov r9, r1
	str r0, [sp, #0x28]
_0216F788:
	ldr r0, [sp, #0x14]
	mov r1, #1
	ldrb r2, [r0, #0xae]
	ldr r0, [sp, #0x28]
	tst r2, r1, lsl r0
	beq _0216FB28
	mov r0, #0
	str r0, [sp, #0x24]
	add r0, r10, #0x17c
	ldr r11, [sp, #0x18]
	str r0, [sp, #0x30]
_0216F7B4:
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x24]
	add r0, r1, r0
	ldrb r0, [r0, #1]
	cmp r0, #0
	beq _0216FB10
	cmp r0, #1
	bne _0216F93C
	ldr r1, _0216FB60 // =gameState
	ldr r1, [r1, #0x14]
	cmp r1, #3
	ldreq r1, _0216FB60 // =gameState
	ldreq r1, [r1, #0x70]
	cmpeq r1, #0xb
	beq _0216F93C
	ldr r0, [r10, #0x44]
	ldr r1, [r10, #0xe80]
	sub r0, r0, #0x100000
	str r0, [sp, #0x20]
	sub r8, r1, #0x30000
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x24]
	add r1, r1, r0, lsl #1
	ldrh r0, [r1, #4]
	cmp r0, #2
	movhi r0, #2
	strhih r0, [r1, #4]
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x24]
	add r0, r1, r0, lsl #1
	ldrh r0, [r0, #4]
	cmp r0, #0
	beq _0216F844
	cmp r0, #1
	cmpne r0, #2
	beq _0216F84C
_0216F844:
	mov r6, #1
	b _0216F850
_0216F84C:
	mov r6, #0
_0216F850:
	cmp r0, #0
	mov r5, #0
	cmpge r0, #0
	blt _0216FB10
	ldr r1, _0216FB64 // =_021895C0
	ldr r0, [sp, #0x24]
	add r4, r1, r0, lsl #5
	ldr r1, [sp, #0x14]
	add r0, r1, r0, lsl #1
	str r0, [sp, #0x2c]
_0216F878:
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r0, _0216FB68 // =0x00000142
	ldr r1, [sp, #0x20]
	mov r2, r8
	mov r3, #0
	bl GameObject__SpawnObject
	movs r7, r0
	beq _0216F920
	ldr r0, [sp, #0x30]
	add r1, r7, #0x370
	add r0, r0, #0xc00
	mov r2, #0x104
	str r10, [r7, #0x11c]
	bl MI_CpuCopy8
	ldr r0, [sp, #0x1c]
	add r1, r4, r6, lsl #3
	ldrh r0, [r0, #0x9e]
	add r2, sp, #0x34
	add r3, sp, #0x38
	sub r0, r0, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	ldr r0, [r1, #4]
	ldr r1, [r4, r6, lsl #3]
	bl AkMath__Func_2002C98
	ldr r2, [sp, #0x38]
	ldr r1, [r9, #0x78]
	add r0, r11, r5, lsl #2
	add r1, r2, r1
	str r1, [r7, #0x364]
	str r8, [r7, #0x368]
	ldr r2, [sp, #0x34]
	ldr r1, [r9, #0x80]
	add r1, r2, r1
	str r1, [r7, #0x36c]
	str r7, [r0, #0xc]
_0216F920:
	ldr r0, [sp, #0x2c]
	add r5, r5, #1
	ldrh r0, [r0, #4]
	add r6, r6, #1
	cmp r5, r0
	ble _0216F878
	b _0216FB10
_0216F93C:
	ldr r1, [r10, #0x44]
	cmp r0, #5
	mov r4, #1
	sub r1, r1, #0x200000
	addls pc, pc, r0, lsl #2
	b _0216FAA0
_0216F954: // jump table
	b _0216FAA0 // case 0
	b _0216FAA0 // case 1
	b _0216F96C // case 2
	b _0216F9BC // case 3
	b _0216FA14 // case 4
	b _0216FA50 // case 5
_0216F96C:
	ldr r2, [sp, #0x14]
	ldr r0, [sp, #0x24]
	ldr r3, [r10, #0xe80]
	add r0, r2, r0, lsl #1
	sub r8, r3, #0x30000
	ldrh r3, [r0, #4]
	ldr r0, _0216FB68 // =0x00000142
	mov r2, r8
	mov r3, r3, lsl #0x18
	mov r3, r3, asr #0x18
	str r3, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	add r0, r0, #1
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	mov r7, r0
	b _0216FAA0
_0216F9BC:
	ldr r2, [sp, #0x14]
	ldr r0, [sp, #0x24]
	mov r3, #0
	add r0, r2, r0, lsl #1
	ldrh r2, [r0, #4]
	ldr r0, [r10, #0xe80]
	cmp r2, #0
	subne r8, r0, #0x6b000
	addeq r8, r0, #0x15000
	mov r0, r2, lsl #0x18
	mov r0, r0, asr #0x18
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #0x144
	mov r2, r8
	bl GameObject__SpawnObject
	mov r7, r0
	b _0216FAA0
_0216FA14:
	ldr r2, [r10, #0xe80]
	ldr r0, _0216FB68 // =0x00000142
	add r8, r2, #0x15000
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	add r0, r0, #3
	mov r2, r8
	mov r3, #0
	bl GameObject__SpawnObject
	mov r7, r0
	b _0216FAA0
_0216FA50:
	ldr r2, [sp, #0x14]
	ldr r0, [sp, #0x24]
	ldr r3, [r10, #0xe80]
	add r0, r2, r0, lsl #1
	add r8, r3, #0x15000
	ldrh r3, [r0, #4]
	ldr r0, _0216FB68 // =0x00000142
	mov r2, r8
	mov r3, r3, lsl #0x18
	mov r3, r3, asr #0x18
	str r3, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r3, [sp, #8]
	str r3, [sp, #0xc]
	add r0, r0, #4
	mov r4, #3
	str r3, [sp, #0x10]
	bl GameObject__SpawnObject
	mov r7, r0
_0216FAA0:
	cmp r7, #0
	beq _0216FB10
	ldr r0, [sp, #0x1c]
	str r10, [r7, #0x11c]
	ldrh r3, [r0, #0x9e]
	ldr r1, _0216FB64 // =_021895C0
	ldr r0, [sp, #0x24]
	add r1, r1, r0, lsl #5
	sub r0, r3, #0x8000
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add r2, r1, r4, lsl #3
	str r0, [sp]
	ldr r0, [r2, #4]
	ldr r1, [r1, r4, lsl #3]
	add r2, sp, #0x34
	add r3, sp, #0x38
	bl AkMath__Func_2002C98
	ldr r1, [sp, #0x38]
	ldr r0, [r9, #0x78]
	add r0, r1, r0
	str r0, [r7, #0x364]
	str r8, [r7, #0x368]
	ldr r1, [sp, #0x34]
	ldr r0, [r9, #0x80]
	add r0, r1, r0
	str r0, [r7, #0x36c]
	str r7, [r11, #0xc]
_0216FB10:
	ldr r0, [sp, #0x24]
	add r11, r11, #0xc
	add r0, r0, #1
	str r0, [sp, #0x24]
	cmp r0, #3
	blt _0216F7B4
_0216FB28:
	ldr r0, [sp, #0x28]
	add r9, r9, #0xc
	add r0, r0, #1
	str r0, [sp, #0x28]
	cmp r0, #3
	ldr r0, [sp, #0x1c]
	add r0, r0, #6
	str r0, [sp, #0x1c]
	ldr r0, [sp, #0x18]
	add r0, r0, #0x24
	str r0, [sp, #0x18]
	blt _0216F788
	add sp, sp, #0x3c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216FB60: .word gameState
_0216FB64: .word _021895C0
_0216FB68: .word 0x00000142
	arm_func_end Truck3D__Func_216F760

	arm_func_start Truck3D__Func_216FB6C
Truck3D__Func_216FB6C: // 0x0216FB6C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, #0
	add r7, r0, #0xc
	mov r1, r4
	mov ip, r4
	mov lr, #1
_0216FB84:
	ldrb r2, [r0, #0xae]
	tst r2, lr, lsl r4
	bne _0216FBC8
	mov r6, r7
	mov r5, ip
_0216FB98:
	ldr r3, [r6]
	cmp r3, #0
	beq _0216FBB8
	ldr r2, [r3, #0x18]
	tst r2, #0xc
	orreq r2, r2, #8
	streq r2, [r3, #0x18]
	streq r1, [r6]
_0216FBB8:
	add r5, r5, #1
	cmp r5, #9
	add r6, r6, #4
	blt _0216FB98
_0216FBC8:
	add r4, r4, #1
	cmp r4, #3
	add r7, r7, #0x24
	blt _0216FB84
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end Truck3D__Func_216FB6C