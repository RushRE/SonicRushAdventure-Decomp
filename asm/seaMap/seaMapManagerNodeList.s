	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start SeaMapManagerNodeList__Init
SeaMapManagerNodeList__Init: // 0x02045E7C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl NNS_FndInitList
	add r0, r4, #0xc
	mov r1, #0
	bl NNS_FndInitList
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManagerNodeList__Init

	arm_func_start SeaMapManagerNodeList__Release
SeaMapManagerNodeList__Release: // 0x02045E9C
	ldr ip, _02045EA4 // =SeaMapManagerNodeList__RemoveAllNodes
	bx ip
	.align 2, 0
_02045EA4: .word SeaMapManagerNodeList__RemoveAllNodes
	arm_func_end SeaMapManagerNodeList__Release

	arm_func_start SeaMapManagerNodeList__CopyNodes
SeaMapManagerNodeList__CopyNodes: // 0x02045EA8
	ldr ip, _02045EB4 // =SeaMapManagerNodeList__CopyNodesEx
	ldrh r2, [r0, #8]
	bx ip
	.align 2, 0
_02045EB4: .word SeaMapManagerNodeList__CopyNodesEx
	arm_func_end SeaMapManagerNodeList__CopyNodes

	arm_func_start SeaMapManagerNodeList__GetNodeDistance
SeaMapManagerNodeList__GetNodeDistance: // 0x02045EB8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bge _02045F34
	ldr r0, [r4, #0]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0xc]
	beq _02045F34
	ldrh r2, [r0, #0xa]
	ldrh r3, [r4, #0xa]
	ldrh r1, [r4, #8]
	ldrh r0, [r0, #8]
	sub r2, r3, r2
	mov ip, r2, lsl #0xc
	sub r0, r1, r0
	mov r1, r0, lsl #0xc
	smull r0, r2, r1, r1
	adds r3, r0, #0x800
	smull r1, r0, ip, ip
	adc r2, r2, #0
	adds r1, r1, #0x800
	mov r3, r3, lsr #0xc
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r3, r3, r2, lsl #20
	orr r1, r1, r0, lsl #20
	add r0, r3, r1
	bl FX_Sqrt
	str r0, [r4, #0xc]
_02045F34:
	ldr r0, [r4, #0xc]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManagerNodeList__GetNodeDistance

	arm_func_start SeaMapManagerNodeList__CopyNodesEx
SeaMapManagerNodeList__CopyNodesEx: // 0x02045F3C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	movs r6, r2
	mov r7, r1
	ldr r4, [r8, #0]
	mov r5, #0
	beq _02045F90
_02045F58:
	mov r0, r7
	bl SeaMapManagerNodeList__AddNode
	mov r1, r0
	mov r0, r4
	bl SeaMapManagerNodeList__CopyNode
	mov r0, r8
	mov r1, r4
	bl NNS_FndGetNextListObject
	add r1, r5, #1
	mov r1, r1, lsl #0x10
	mov r4, r0
	cmp r6, r1, lsr #16
	mov r5, r1, lsr #0x10
	bhi _02045F58
_02045F90:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end SeaMapManagerNodeList__CopyNodesEx

	arm_func_start SeaMapManagerNodeList__AddGroup
SeaMapManagerNodeList__AddGroup: // 0x02045F98
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _02045FD0 // =0x0000040C
	bl _AllocHeadHEAP_SYSTEM
	mov r4, r0
	ldr r2, _02045FD0 // =0x0000040C
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r1, r4
	add r0, r5, #0xc
	bl NNS_FndAppendListObject
	mov r0, r4
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02045FD0: .word 0x0000040C
	arm_func_end SeaMapManagerNodeList__AddGroup

	arm_func_start SeaMapManagerNodeList__RemoveLastGroup
SeaMapManagerNodeList__RemoveLastGroup: // 0x02045FD4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #0x14]
	cmp r0, #0
	beq _02046000
	ldr r4, [r5, #0x10]
	add r0, r5, #0xc
	mov r1, r4
	bl NNS_FndRemoveListObject
	mov r0, r4
	bl _FreeHEAP_SYSTEM
_02046000:
	ldrh r0, [r5, #0x14]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManagerNodeList__RemoveLastGroup

	arm_func_start SeaMapManagerNodeList__GetLastGroup
SeaMapManagerNodeList__GetLastGroup: // 0x02046008
	ldr r0, [r0, #0x10]
	bx lr
	arm_func_end SeaMapManagerNodeList__GetLastGroup

	arm_func_start SeaMapManagerNodeList__GetGroupAvailableSize
SeaMapManagerNodeList__GetGroupAvailableSize: // 0x02046010
	stmdb sp!, {r3, lr}
	bl SeaMapManagerNodeList__GetLastGroup
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	add r0, r0, #0x400
	ldrh r0, [r0, #8]
	rsb r0, r0, #0x40
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapManagerNodeList__GetGroupAvailableSize

	arm_func_start SeaMapManagerNodeList__AddNode
SeaMapManagerNodeList__AddNode: // 0x0204603C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManagerNodeList__GetGroupAvailableSize
	cmp r0, #0
	mov r0, r4
	beq _0204605C
	bl SeaMapManagerNodeList__GetLastGroup
	b _02046060
_0204605C:
	bl SeaMapManagerNodeList__AddGroup
_02046060:
	add r2, r0, #0x400
	ldrh ip, [r2, #8]
	add r1, r0, #8
	mov r0, r4
	add r3, ip, #1
	add r4, r1, ip, lsl #4
	mov r1, r4
	strh r3, [r2, #8]
	mvn r2, #0
	str r2, [r4, #0xc]
	bl NNS_FndAppendListObject
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManagerNodeList__AddNode

	arm_func_start SeaMapManagerNodeList__RemoveLastNode
SeaMapManagerNodeList__RemoveLastNode: // 0x02046094
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #8]
	cmp r1, #0
	beq _020460DC
	ldr r1, [r4, #4]
	bl NNS_FndRemoveListObject
	mov r0, r4
	bl SeaMapManagerNodeList__GetLastGroup
	add r0, r0, #0x400
	ldrh r1, [r0, #8]
	sub r1, r1, #1
	strh r1, [r0, #8]
	ldrh r0, [r0, #8]
	cmp r0, #0
	bne _020460DC
	mov r0, r4
	bl SeaMapManagerNodeList__RemoveLastGroup
_020460DC:
	ldrh r0, [r4, #8]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManagerNodeList__RemoveLastNode

	arm_func_start SeaMapManagerNodeList__RemoveAllNodes
SeaMapManagerNodeList__RemoveAllNodes: // 0x020460E4
	stmdb sp!, {r4, lr}
	mov r4, r0
_020460EC:
	mov r0, r4
	bl SeaMapManagerNodeList__RemoveLastNode
	cmp r0, #0
	bne _020460EC
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapManagerNodeList__RemoveAllNodes

	arm_func_start SeaMapManagerNodeList__CopyNode
SeaMapManagerNodeList__CopyNode: // 0x02046100
	ldrh r2, [r0, #8]
	strh r2, [r1, #8]
	ldrh r2, [r0, #0xa]
	strh r2, [r1, #0xa]
	ldr r0, [r0, #0xc]
	str r0, [r1, #0xc]
	bx lr
	arm_func_end SeaMapManagerNodeList__CopyNode

	arm_func_start SeaMapManagerNodeList__Func_204611C
SeaMapManagerNodeList__Func_204611C: // 0x0204611C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl SeaMapManagerNodeList__Func_2046240
	mov r0, r5
	mov r1, r4
	bl SeaMapManagerNodeList__Func_204634C
	mov r0, r5
	mov r1, r4
	bl SeaMapManagerNodeList__Func_204652C
	mov r0, r5
	mov r1, r4
	bl SeaMapManagerNodeList__Func_204634C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapManagerNodeList__Func_204611C

	arm_func_start SeaMapManagerNodeList__Func_2046154
SeaMapManagerNodeList__Func_2046154: // 0x02046154
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r2
	mov r4, r3
	add r2, sp, #0xc
	add r3, sp, #0x10
	bl SeaMapManager__GetPosition2
	add r2, sp, #4
	add r3, sp, #8
	mov r0, r5
	mov r1, r4
	bl SeaMapManager__GetPosition2
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #4]
	mov r2, r0, asr #0xf
	cmp r2, r1, asr #15
	bne _020461AC
	ldr r1, [sp, #0x10]
	ldr r2, [sp, #8]
	mov r3, r1, asr #0xf
	cmp r3, r2, asr #15
	beq _020461B8
_020461AC:
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, pc}
_020461B8:
	add r2, sp, #0
	add r3, sp, #2
	bl SeaMapManager__Func_2043B60
	ldrh r0, [sp]
	ldrh r1, [sp, #2]
	mov r0, r0, lsl #0xd
	mov r1, r1, lsl #0xd
	mov r0, r0, lsr #0x10
	mov r1, r1, lsr #0x10
	bl SeaMapCollision__GetCollisionAtPoint
	ldr ip, [sp, #0x10]
	ldr r2, [sp, #8]
	ldr r3, [sp, #0xc]
	ldr r1, [sp, #4]
	mov ip, ip, asr #0xc
	mov r3, r3, asr #0xc
	mov r1, r1, asr #0xc
	ldr r4, _0204623C // =byte_210FB80
	mov lr, ip, lsl #0x1d
	mov r2, r2, asr #0xc
	add ip, r4, r0, lsl #6
	mov r0, r2, lsl #0x1d
	and r3, r3, #7
	add r2, ip, lr, lsr #26
	and r1, r1, #7
	add r0, ip, r0, lsr #26
	ldrb r2, [r3, r2]
	ldrb r0, [r1, r0]
	cmp r2, r0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0204623C: .word byte_210FB80
	arm_func_end SeaMapManagerNodeList__Func_2046154

	arm_func_start SeaMapManagerNodeList__Func_2046240
SeaMapManagerNodeList__Func_2046240: // 0x02046240
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x18
	mov r4, r0
	ldrh r0, [r4, #8]
	mov r5, r1
	sub r0, r0, r5
	cmp r0, #1
	addle sp, sp, #0x18
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	add r0, sp, #0
	bl SeaMapManagerNodeList__Init
	add r1, sp, #0
	mov r0, r4
	mov r2, r5
	bl SeaMapManagerNodeList__CopyNodesEx
	mov r5, r0
	add r0, sp, #0
	bl SeaMapManagerNodeList__AddNode
	mov r7, r0
	mov r0, r5
	mov r1, r7
	bl SeaMapManagerNodeList__CopyNode
	mov r0, r4
	mov r1, r5
	bl NNS_FndGetNextListObject
	movs r9, r0
	beq _02046328
	add r6, sp, #0
	mvn r5, #0
_020462B4:
	mov r0, r6
	mov r8, r7
	bl SeaMapManagerNodeList__AddNode
	mov r7, r0
	mov r0, r9
	mov r1, r7
	bl SeaMapManagerNodeList__CopyNode
	mov r0, r7
	str r5, [r7, #0xc]
	bl SeaMapManagerNodeList__GetNodeDistance
	mov r0, r4
	mov r1, r9
	bl NNS_FndGetNextListObject
	movs r9, r0
	beq _02046320
	ldr r0, [r7, #0xc]
	cmp r0, #0x3000
	bge _02046320
	ldrh r0, [r8, #8]
	ldrh r1, [r8, #0xa]
	ldrh r2, [r7, #8]
	ldrh r3, [r7, #0xa]
	bl SeaMapManagerNodeList__Func_2046154
	cmp r0, #0
	bne _02046320
	mov r0, r6
	bl SeaMapManagerNodeList__RemoveLastNode
_02046320:
	cmp r9, #0
	bne _020462B4
_02046328:
	mov r0, r4
	bl SeaMapManagerNodeList__Release
	add r0, sp, #0
	mov r1, r4
	bl SeaMapManagerNodeList__CopyNodes
	add r0, sp, #0
	bl SeaMapManagerNodeList__Release
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end SeaMapManagerNodeList__Func_2046240

	arm_func_start SeaMapManagerNodeList__Func_204634C
SeaMapManagerNodeList__Func_204634C: // 0x0204634C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r11, r0
	ldrh r0, [r11, #8]
	mov r4, r1
	sub r0, r0, r4
	cmp r0, #2
	addle sp, sp, #0x1c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, sp, #4
	bl SeaMapManagerNodeList__Init
	add r1, sp, #4
	mov r0, r11
	mov r2, r4
	bl SeaMapManagerNodeList__CopyNodesEx
	mov r5, r0
	mov r0, r11
	mov r1, r5
	bl NNS_FndGetNextListObject
	mov r9, r0
	ldrh r3, [r9, #0xa]
	ldrh r0, [r5, #0xa]
	ldrh r2, [r9, #8]
	ldrh r1, [r5, #8]
	sub r0, r3, r0
	mov r0, r0, lsl #0xc
	sub r1, r2, r1
	mov r1, r1, lsl #0xc
	bl FX_Atan2Idx
	mov r6, r0
	add r0, sp, #4
	bl SeaMapManagerNodeList__AddNode
	mov r4, r0
	mov r0, r5
	mov r1, r4
	bl SeaMapManagerNodeList__CopyNode
	add r0, sp, #4
	bl SeaMapManagerNodeList__AddNode
	mov r5, r0
	mov r0, r9
	mov r1, r5
	bl SeaMapManagerNodeList__CopyNode
	mov r0, r11
	mov r1, r9
	bl NNS_FndGetNextListObject
	mov r10, r0
	mvn r0, #0
	str r0, [sp]
_0204640C:
	ldrh r3, [r10, #0xa]
	ldrh r0, [r9, #0xa]
	ldrh r2, [r10, #8]
	ldrh r1, [r9, #8]
	sub r0, r3, r0
	mov r0, r0, lsl #0xc
	sub r1, r2, r1
	mov r1, r1, lsl #0xc
	mov r7, #0
	mov r8, r6
	bl FX_Atan2Idx
	mov r6, r0
	sub r0, r8, r6
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	movs r0, r0, asr #0x10
	rsbmi r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0x300
	bhs _02046480
	ldrh r0, [r9, #8]
	ldrh r1, [r9, #0xa]
	ldrh r2, [r10, #8]
	ldrh r3, [r10, #0xa]
	bl SeaMapManagerNodeList__Func_2046154
	cmp r0, #0
	moveq r7, #1
_02046480:
	cmp r7, #0
	beq _020464D4
	ldrh r1, [r10, #8]
	mov r0, r5
	strh r1, [r5, #8]
	ldrh r1, [r10, #0xa]
	strh r1, [r5, #0xa]
	ldr r1, [sp]
	str r1, [r5, #0xc]
	bl SeaMapManagerNodeList__GetNodeDistance
	ldrh r3, [r5, #0xa]
	ldrh r0, [r4, #0xa]
	ldrh r2, [r5, #8]
	ldrh r1, [r4, #8]
	sub r0, r3, r0
	mov r0, r0, lsl #0xc
	sub r1, r2, r1
	mov r1, r1, lsl #0xc
	bl FX_Atan2Idx
	mov r6, r0
	b _020464F0
_020464D4:
	add r0, sp, #4
	mov r4, r5
	bl SeaMapManagerNodeList__AddNode
	mov r5, r0
	mov r0, r10
	mov r1, r5
	bl SeaMapManagerNodeList__CopyNode
_020464F0:
	mov r0, r11
	mov r1, r10
	mov r9, r10
	bl NNS_FndGetNextListObject
	movs r10, r0
	bne _0204640C
	mov r0, r11
	bl SeaMapManagerNodeList__Release
	add r0, sp, #4
	mov r1, r11
	bl SeaMapManagerNodeList__CopyNodes
	add r0, sp, #4
	bl SeaMapManagerNodeList__Release
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end SeaMapManagerNodeList__Func_204634C

	arm_func_start SeaMapManagerNodeList__Func_204652C
SeaMapManagerNodeList__Func_204652C: // 0x0204652C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x18
	mov r10, r0
	ldrh r0, [r10, #8]
	mov r4, r1
	sub r0, r0, r4
	cmp r0, #2
	addle sp, sp, #0x18
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, sp, #0
	bl SeaMapManagerNodeList__Init
	add r1, sp, #0
	mov r0, r10
	mov r2, r4
	bl SeaMapManagerNodeList__CopyNodesEx
	mov r4, r0
	add r0, sp, #0
	bl SeaMapManagerNodeList__AddNode
	mov r6, r0
	mov r0, r4
	mov r1, r6
	bl SeaMapManagerNodeList__CopyNode
	mov r0, r10
	mov r1, r4
	bl NNS_FndGetNextListObject
	mov r4, r0
	add r0, sp, #0
	bl SeaMapManagerNodeList__AddNode
	mov r7, r0
	mov r0, r4
	mov r1, r7
	bl SeaMapManagerNodeList__CopyNode
	mov r1, r4
	mov r0, r10
	bl NNS_FndGetNextListObject
	movs r9, r0
	beq _020466A8
	mvn r4, #0
	add r11, sp, #0
_020465C8:
	mov r0, r11
	bl SeaMapManagerNodeList__AddNode
	mov r8, r0
	mov r0, r9
	mov r1, r8
	bl SeaMapManagerNodeList__CopyNode
	ldrh r3, [r7, #0xa]
	ldrh r0, [r6, #0xa]
	ldrh r2, [r7, #8]
	ldrh r1, [r6, #8]
	sub r0, r3, r0
	mov r0, r0, lsl #0xc
	sub r1, r2, r1
	mov r1, r1, lsl #0xc
	bl FX_Atan2Idx
	mov r5, r0
	ldrh r3, [r8, #0xa]
	ldrh r0, [r7, #0xa]
	ldrh r2, [r8, #8]
	ldrh r1, [r7, #8]
	sub r0, r3, r0
	mov r0, r0, lsl #0xc
	sub r1, r2, r1
	mov r1, r1, lsl #0xc
	bl FX_Atan2Idx
	sub r0, r5, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	movs r0, r0, asr #0x10
	rsbmi r0, r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0x4000
	bls _0204668C
	ldr r0, [r7, #0xc]
	cmp r0, #0x4700
	ldrge r0, [r8, #0xc]
	cmpge r0, #0x4700
	bge _0204668C
	mov r0, r8
	mov r1, r7
	bl SeaMapManagerNodeList__CopyNode
	mov r0, r7
	str r4, [r7, #0xc]
	bl SeaMapManagerNodeList__GetNodeDistance
	mov r0, r11
	bl SeaMapManagerNodeList__RemoveLastNode
	b _02046694
_0204668C:
	mov r6, r7
	mov r7, r8
_02046694:
	mov r0, r10
	mov r1, r9
	bl NNS_FndGetNextListObject
	movs r9, r0
	bne _020465C8
_020466A8:
	mov r0, r10
	bl SeaMapManagerNodeList__Release
	add r0, sp, #0
	mov r1, r10
	bl SeaMapManagerNodeList__CopyNodes
	add r0, sp, #0
	bl SeaMapManagerNodeList__Release
	add sp, sp, #0x18
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end SeaMapManagerNodeList__Func_204652C

	.rodata
	
.public byte_210FB80
byte_210FB80: // 0x0210FB80
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1
	.byte 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	.byte 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0
	.byte 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1
	.byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0
	.byte 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
	.byte 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1
	.byte 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0