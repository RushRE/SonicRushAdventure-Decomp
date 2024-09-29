	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_RemoveAllDWCGHTTPParamEntry
DWCi_RemoveAllDWCGHTTPParamEntry: // 0x0209C624
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r0, _0209C690 // =0x02144318
	ldr r7, [r0]
	cmp r7, #0
	beq _0209C67C
	mov r5, #4
	mov r4, #0
_0209C644:
	mov r6, r7
	ldr r1, [r6, #0x10]
	ldr r7, [r7, #0x18]
	cmp r1, #0
	beq _0209C664
	mov r0, r5
	mov r2, r4
	bl DWC_Free
_0209C664:
	mov r0, r5
	mov r1, r6
	mov r2, r4
	bl DWC_Free
	cmp r7, #0
	bne _0209C644
_0209C67C:
	ldr r0, _0209C690 // =0x02144318
	mov r1, #0
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209C690: .word 0x02144318
	arm_func_end DWCi_RemoveAllDWCGHTTPParamEntry

	arm_func_start DWCi_FindDWCGHTTPParamEntryByReq
DWCi_FindDWCGHTTPParamEntryByReq: // 0x0209C694
	ldr r1, _0209C6C0 // =0x02144318
	ldr r2, [r1]
	b _0209C6A4
_0209C6A0:
	ldr r2, [r2, #0x18]
_0209C6A4:
	cmp r2, #0
	beq _0209C6B8
	ldr r1, [r2, #0x14]
	cmp r1, r0
	bne _0209C6A0
_0209C6B8:
	mov r0, r2
	bx lr
	.align 2, 0
_0209C6C0: .word 0x02144318
	arm_func_end DWCi_FindDWCGHTTPParamEntryByReq

	arm_func_start DWCi_RemoveDWCGHTTPParamEntry
DWCi_RemoveDWCGHTTPParamEntry: // 0x0209C6C4
	stmdb sp!, {r4, lr}
	ldr r1, _0209C744 // =0x02144318
	ldr r1, [r1]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	cmp r1, r0
	bne _0209C6FC
	mov r0, #4
	mov r2, #0
	ldr r4, [r1, #0x18]
	bl DWC_Free
	ldr r0, _0209C744 // =0x02144318
	str r4, [r0]
	ldmia sp!, {r4, pc}
_0209C6FC:
	ldr r2, [r1, #0x18]
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
_0209C708:
	cmp r2, r0
	movne r1, r2
	bne _0209C734
	ldr ip, [r1, #0x18]
	mov r0, #4
	ldr r3, [ip, #0x18]
	mov r2, #0
	str r3, [r1, #0x18]
	mov r1, ip
	bl DWC_Free
	ldmia sp!, {r4, pc}
_0209C734:
	ldr r2, [r2, #0x18]
	cmp r2, #0
	bne _0209C708
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209C744: .word 0x02144318
	arm_func_end DWCi_RemoveDWCGHTTPParamEntry

	arm_func_start DWCi_AppendDWCGHTTPParam
DWCi_AppendDWCGHTTPParam: // 0x0209C748
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #4
	mov r1, #0x1c
	bl DWC_Alloc
	movs ip, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldmia r4, {r0, r1, r2, r3}
	stmia ip, {r0, r1, r2, r3}
	mov r0, #0
	str r0, [ip, #0x18]
	ldr r1, _0209C7A0 // =0x02144318
	str r0, [ip, #0x10]
	ldr r0, [r1]
	cmp r0, #0
	moveq r0, ip
	streq ip, [r1]
	strne r0, [ip, #0x18]
	movne r0, ip
	strne ip, [r1]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209C7A0: .word 0x02144318
	arm_func_end DWCi_AppendDWCGHTTPParam

	arm_func_start DWCi_HandleGHTTPError
DWCi_HandleGHTTPError: // 0x0209C7A4
	stmdb sp!, {r4, lr}
	movs r4, r0
	mov r0, #7
	ldr r1, _0209C8E4 // =0xFFFE8130
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r2, r4, #7
	cmp r2, #0x1a
	addls pc, pc, r2, lsl #2
	b _0209C8D8
_0209C7CC: // jump table
	b _0209C838 // case 0
	b _0209C840 // case 1
	b _0209C84C // case 2
	b _0209C854 // case 3
	b _0209C854 // case 4
	b _0209C854 // case 5
	b _0209C85C // case 6
	b _0209C8D8 // case 7
	b _0209C868 // case 8
	b _0209C874 // case 9
	b _0209C87C // case 10
	b _0209C888 // case 11
	b _0209C890 // case 12
	b _0209C898 // case 13
	b _0209C8A0 // case 14
	b _0209C8A8 // case 15
	b _0209C8A8 // case 16
	b _0209C8A8 // case 17
	b _0209C898 // case 18
	b _0209C898 // case 19
	b _0209C8B4 // case 20
	b _0209C8B4 // case 21
	b _0209C8BC // case 22
	b _0209C8C8 // case 23
	b _0209C8D0 // case 24
	b _0209C8D8 // case 25
	b _0209C868 // case 26
_0209C838:
	sub r1, r1, #0x320
	b _0209C8D8
_0209C840:
	ldr r2, _0209C8E8 // =0xFFFFFCD6
	add r1, r1, r2
	b _0209C8D8
_0209C84C:
	sub r1, r1, #0x348
	b _0209C8D8
_0209C854:
	sub r1, r1, #0x334
	b _0209C8D8
_0209C85C:
	ldr r2, _0209C8EC // =0xFFFFFCC2
	add r1, r1, r2
	b _0209C8D8
_0209C868:
	sub r1, r1, #1
	mov r0, #9
	b _0209C8D8
_0209C874:
	sub r1, r1, #0x348
	b _0209C8D8
_0209C87C:
	ldr r2, _0209C8F0 // =0xFFFFFCAE
	add r1, r1, r2
	b _0209C8D8
_0209C888:
	sub r1, r1, #0x1e
	b _0209C8D8
_0209C890:
	sub r1, r1, #0x32
	b _0209C8D8
_0209C898:
	sub r1, r1, #0x14
	b _0209C8D8
_0209C8A0:
	sub r1, r1, #0x35c
	b _0209C8D8
_0209C8A8:
	ldr r2, _0209C8F4 // =0xFFFFFC9A
	add r1, r1, r2
	b _0209C8D8
_0209C8B4:
	sub r1, r1, #0x370
	b _0209C8D8
_0209C8BC:
	ldr r2, _0209C8F8 // =0xFFFFFC86
	add r1, r1, r2
	b _0209C8D8
_0209C8C8:
	sub r1, r1, #0x384
	b _0209C8D8
_0209C8D0:
	ldr r2, _0209C8FC // =0xFFFFFC72
	add r1, r1, r2
_0209C8D8:
	bl DWCi_SetError
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209C8E4: .word 0xFFFE8130
_0209C8E8: .word 0xFFFFFCD6
_0209C8EC: .word 0xFFFFFCC2
_0209C8F0: .word 0xFFFFFCAE
_0209C8F4: .word 0xFFFFFC9A
_0209C8F8: .word 0xFFFFFC86
_0209C8FC: .word 0xFFFFFC72
	arm_func_end DWCi_HandleGHTTPError

	arm_func_start DWC_CancelGHTTPRequest
DWC_CancelGHTTPRequest: // 0x0209C900
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ghttpCancelRequest
	mov r0, r4
	bl DWCi_FindDWCGHTTPParamEntryByReq
	movs r4, r0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x10]
	cmp r1, #0
	beq _0209C934
	mov r0, #4
	mov r2, #0
	bl DWC_Free
_0209C934:
	mov r0, r4
	bl DWCi_RemoveDWCGHTTPParamEntry
	ldmia sp!, {r4, pc}
	arm_func_end DWC_CancelGHTTPRequest

	arm_func_start DWC_GetGHTTPDataEx
DWC_GetGHTTPDataEx: // 0x0209C940
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr lr, [sp, #0x10]
	str r3, [sp]
	ldr ip, [sp, #0x14]
	str lr, [sp, #4]
	mov r3, #0
	str ip, [sp, #8]
	bl DWCi_GetGHTTPDataEx
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end DWC_GetGHTTPDataEx

	arm_func_start DWCi_GetGHTTPDataEx
DWCi_GetGHTTPDataEx: // 0x0209C96C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x28
	ldr r9, [sp, #0x4c]
	ldr r8, [sp, #0x50]
	mov r5, r0
	mov r4, r1
	mov r6, r2
	mov r10, r3
	mov r7, #0
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #0x28
	mvnne r0, #7
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r1, [sp, #0x48]
	add r0, sp, #0x18
	str r8, [sp, #0x18]
	str r9, [sp, #0x1c]
	str r1, [sp, #0x20]
	str r6, [sp, #0x24]
	bl DWCi_AppendDWCGHTTPParam
	movs r6, r0
	bne _0209C9F0
	mvn r0, #4
	bl DWCi_HandleGHTTPError
	mov r0, r7
	mov r1, r0
	mov r3, r8
	mvn r2, #4
	blx r9
	add sp, sp, #0x28
	mvn r0, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0209C9F0:
	cmp r4, #0
	ble _0209CA40
	mov r1, r4
	mov r0, #4
	bl DWC_Alloc
	movs r7, r0
	bne _0209CA3C
	mvn r0, #4
	bl DWCi_HandleGHTTPError
	mov r0, #0
	mov r1, r0
	mov r3, r8
	mvn r2, #4
	blx r9
	mov r0, r6
	bl DWCi_RemoveDWCGHTTPParamEntry
	add sp, sp, #0x28
	mvn r0, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0209CA3C:
	str r7, [r6, #0x10]
_0209CA40:
	cmp r10, #0
	beq _0209CA88
	ldr r0, [r10]
	mov r1, #0
	str r0, [sp]
	str r1, [sp, #4]
	ldr r2, _0209CB14 // =GHTTPProgressCallback
	str r1, [sp, #8]
	ldr r0, _0209CB18 // =GHTTPCompletedCallback
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, r5
	mov r2, r7
	mov r3, r4
	str r6, [sp, #0x14]
	bl ghttpGetExA
	mov r4, r0
	b _0209CAC0
_0209CA88:
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, _0209CB14 // =GHTTPProgressCallback
	str r1, [sp, #8]
	ldr r0, _0209CB18 // =GHTTPCompletedCallback
	str r2, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, r5
	mov r2, r7
	mov r3, r4
	str r6, [sp, #0x14]
	bl ghttpGetExA
	mov r4, r0
_0209CAC0:
	cmp r4, #0
	bge _0209CB04
	mov r0, r4
	bl DWCi_HandleGHTTPError
	mov r0, #0
	mov r1, r0
	mov r2, r4
	mov r3, r8
	blx r9
	ldr r1, [r6, #0x10]
	cmp r1, #0
	beq _0209CAFC
	mov r0, #4
	mov r2, #0
	bl DWC_Free
_0209CAFC:
	mov r0, r6
	bl DWCi_RemoveDWCGHTTPParamEntry
_0209CB04:
	mov r0, r4
	str r4, [r6, #0x14]
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0209CB14: .word GHTTPProgressCallback
_0209CB18: .word GHTTPCompletedCallback
	arm_func_end DWCi_GetGHTTPDataEx

	arm_func_start GHTTPProgressCallback
GHTTPProgressCallback: // 0x0209CB1C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, [sp, #0x18]
	ldr lr, [r4, #8]
	cmp lr, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr ip, [sp, #0x14]
	mov r0, r1
	str ip, [sp]
	mov r1, r2
	mov r2, r3
	ldr ip, [r4]
	ldr r3, [sp, #0x10]
	str ip, [sp, #4]
	blx lr
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end GHTTPProgressCallback

	arm_func_start GHTTPCompletedCallback
GHTTPCompletedCallback: // 0x0209CB64
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r6, [sp, #0x18]
	mov r7, r1
	ldr r5, [r6, #4]
	ldr r4, [r6, #0xc]
	cmp r5, #0
	beq _0209CBC0
	cmp r7, #0
	bne _0209CBA4
	mov r1, r3
	mov r0, r2
	ldr r3, [r6]
	mov r2, r7
	blx r5
	b _0209CBC0
_0209CBA4:
	mov r0, r7
	bl DWCi_HandleGHTTPError
	mov r0, #0
	ldr r3, [r6]
	mov r1, r0
	mov r2, r7
	blx r5
_0209CBC0:
	cmp r7, #0
	bne _0209CBD0
	cmp r4, #1
	bne _0209CBEC
_0209CBD0:
	ldr r1, [r6, #0x10]
	cmp r1, #0
	moveq r4, #1
	beq _0209CBEC
	mov r0, #4
	mov r2, #0
	bl DWC_Free
_0209CBEC:
	mov r0, r6
	bl DWCi_RemoveDWCGHTTPParamEntry
	cmp r4, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end GHTTPCompletedCallback

	arm_func_start DWC_ProcessGHTTP
DWC_ProcessGHTTP: // 0x0209CC08
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	bl ghttpThink
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWC_ProcessGHTTP

	arm_func_start DWC_ShutdownGHTTP
DWC_ShutdownGHTTP: // 0x0209CC34
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0209CC7C // =0x0214431C
	ldr r0, [r0]
	cmp r0, #0
	addle sp, sp, #4
	movle r0, #1
	ldmleia sp!, {pc}
	bl ghttpCleanup
	ldr r0, _0209CC7C // =0x0214431C
	ldr r1, [r0]
	subs r1, r1, #1
	str r1, [r0]
	bne _0209CC70
	bl DWCi_RemoveAllDWCGHTTPParamEntry
_0209CC70:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209CC7C: .word 0x0214431C
	arm_func_end DWC_ShutdownGHTTP

	arm_func_start DWC_InitGHTTP
DWC_InitGHTTP: // 0x0209CC80
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ghttpStartup
	ldr r1, _0209CCA8 // =0x0214431C
	mov r0, #1
	ldr r2, [r1]
	add r2, r2, #1
	str r2, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209CCA8: .word 0x0214431C
	arm_func_end DWC_InitGHTTP
