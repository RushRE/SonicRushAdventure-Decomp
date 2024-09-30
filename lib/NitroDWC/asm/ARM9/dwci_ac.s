	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public _021438CC
_021438CC:
	.space 0x1D6C

	.text

	arm_func_start CheckDuplicate
CheckDuplicate: // 0x02086134
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r1, _020861CC // =_021438CC
	ldr r0, _020861D0 // =0x00000474
	ldr r10, [r1, #0]
	mov r4, #0xc0
	ldrb r7, [r10, #0xd13]
	add r5, r10, r0
	ldrb r0, [r10, #0xd0d]
	mla r9, r7, r4, r5
	cmp r0, #6
	movhs r0, #1
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldrb r6, [r10, #0xd12]
	mov r8, #0
	cmp r6, #0
	bls _020861C4
_02086174:
	cmp r8, r7
	beq _020861B4
	add r0, r10, r8, lsl #2
	ldrb r0, [r0, #0x445]
	cmp r0, #6
	bhs _020861B4
	mul r1, r8, r4
	add r0, r10, r1
	add r0, r0, #0x400
	ldrh r2, [r0, #0x7a]
	mov r0, r9
	add r1, r5, r1
	bl strncmp
	cmp r0, #0
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020861B4:
	add r0, r8, #1
	and r8, r0, #0xff
	cmp r8, r6
	blo _02086174
_020861C4:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020861CC: .word _021438CC
_020861D0: .word 0x00000474
	arm_func_end CheckDuplicate

	arm_func_start Free_Disused
Free_Disused: // 0x020861D4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0208620C // =0x021438D8
	mov r0, #8
	ldr r1, [r1, #0]
	mov r2, #0xc
	bl DWCi_AC_Free
	ldr r0, _02086210 // =_021438CC
	ldr r2, _02086214 // =0x00000D18
	ldr r1, [r0, #0]
	mov r0, #0x10
	bl DWCi_AC_Free
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208620C: .word 0x021438D8
_02086210: .word _021438CC
_02086214: .word 0x00000D18
	arm_func_end Free_Disused

	arm_func_start DWCi_ConvConnectAPType
DWCi_ConvConnectAPType: // 0x02086218
	cmp r0, #2
	subhi r0, r0, #3
	andhi r0, r0, #0xff
	bx lr
	arm_func_end DWCi_ConvConnectAPType

	arm_func_start DWCi_AC_SetApType
DWCi_AC_SetApType: // 0x02086228
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_ConvConnectAPType
	ldr r1, _02086248 // =0x021438DC
	ldr r1, [r1, #0]
	strb r0, [r1, #0x17]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02086248: .word 0x021438DC
	arm_func_end DWCi_AC_SetApType

	arm_func_start DWCi_AC_GetError
DWCi_AC_GetError: // 0x0208624C
	ldr r0, _0208625C // =0x021438DC
	ldr r0, [r0, #0]
	ldr r0, [r0, #0xc]
	bx lr
	.align 2, 0
_0208625C: .word 0x021438DC
	arm_func_end DWCi_AC_GetError

	arm_func_start DWCi_AC_SetError
DWCi_AC_SetError: // 0x02086260
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #1
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	str r5, [r4, #0xc]
	bl DWCi_AC_GetPhase
	strb r0, [r4, #0xa]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_AC_SetError

	arm_func_start DWCi_AC_GetPhase
DWCi_AC_GetPhase: // 0x0208628C
	ldr r0, _0208629C // =0x021438DC
	ldr r0, [r0, #0]
	ldrb r0, [r0, #9]
	bx lr
	.align 2, 0
_0208629C: .word 0x021438DC
	arm_func_end DWCi_AC_GetPhase

	arm_func_start DWCi_AC_SetPhase
DWCi_AC_SetPhase: // 0x020862A0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #1
	bl DWCi_AC_GetMemPtr
	mov r5, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	strb r6, [r5, #9]
	cmp r6, #0x10
	ldmhsia sp!, {r4, r5, r6, pc}
	ldrb r0, [r5, #0x16]
	cmp r6, r0
	ldmlsia sp!, {r4, r5, r6, pc}
	strb r6, [r5, #0x16]
	cmp r6, #7
	ldmlsia sp!, {r4, r5, r6, pc}
	ldrb r0, [r4, #0xd0d]
	bl DWCi_ConvConnectAPType
	strb r0, [r5, #0x15]
	ldrb r0, [r4, #0xd13]
	add r0, r4, r0, lsl #2
	ldrb r0, [r0, #0x444]
	strb r0, [r5, #0x14]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_AC_SetPhase

	arm_func_start DWCi_AC_GetMemPtr
DWCi_AC_GetMemPtr: // 0x02086304
	ands r1, r0, #1
	ldrne r0, _02086358 // =0x021438DC
	ldrne r0, [r0, #0]
	bxne lr
	ands r1, r0, #2
	ldrne r0, _0208635C // =0x021438D0
	ldrne r0, [r0, #0]
	bxne lr
	ands r1, r0, #4
	ldrne r0, _02086360 // =0x021438D4
	ldrne r0, [r0, #0]
	bxne lr
	ands r1, r0, #8
	ldrne r0, _02086364 // =0x021438D8
	ldrne r0, [r0, #0]
	bxne lr
	ands r0, r0, #0x10
	ldrne r0, _02086368 // =_021438CC
	ldrne r0, [r0, #0]
	moveq r0, #0
	bx lr
	.align 2, 0
_02086358: .word 0x021438DC
_0208635C: .word 0x021438D0
_02086360: .word 0x021438D4
_02086364: .word 0x021438D8
_02086368: .word _021438CC
	arm_func_end DWCi_AC_GetMemPtr

	arm_func_start DWCi_AC_FreeAll
DWCi_AC_FreeAll: // 0x0208636C
	stmdb sp!, {r4, lr}
	mov r0, #1
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	ldrb r0, [r4, #8]
	ands r0, r0, #0x10
	beq _020863B0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	ldrb r3, [r4, #8]
	mov r1, r0
	ldr r2, _02086478 // =0x00000D18
	bic r0, r3, #0x10
	strb r0, [r4, #8]
	ldr r3, [r4, #4]
	mov r0, #0x10
	blx r3
_020863B0:
	ldrb r0, [r4, #8]
	ands r0, r0, #8
	beq _020863E4
	mov r0, #8
	bl DWCi_AC_GetMemPtr
	ldrb r2, [r4, #8]
	mov r1, r0
	mov r0, #8
	bic r2, r2, #8
	strb r2, [r4, #8]
	ldr r3, [r4, #4]
	mov r2, #0xc
	blx r3
_020863E4:
	ldrb r0, [r4, #8]
	ands r0, r0, #4
	beq _02086418
	mov r0, #4
	bl DWCi_AC_GetMemPtr
	ldrb r2, [r4, #8]
	mov r1, r0
	mov r0, #4
	bic r2, r2, #4
	strb r2, [r4, #8]
	ldr r3, [r4, #4]
	mov r2, #0x58
	blx r3
_02086418:
	ldrb r0, [r4, #8]
	ands r0, r0, #2
	beq _0208644C
	mov r0, #2
	bl DWCi_AC_GetMemPtr
	ldrb r2, [r4, #8]
	mov r1, r0
	mov r0, #2
	bic r2, r2, #2
	strb r2, [r4, #8]
	ldr r3, [r4, #4]
	mov r2, #0x2300
	blx r3
_0208644C:
	ldrb r0, [r4, #8]
	ands r1, r0, #1
	ldmeqia sp!, {r4, pc}
	bic r0, r0, #1
	strb r0, [r4, #8]
	ldr r3, [r4, #4]
	mov r1, r4
	mov r0, #1
	mov r2, #0x18
	blx r3
	ldmia sp!, {r4, pc}
	.align 2, 0
_02086478: .word 0x00000D18
	arm_func_end DWCi_AC_FreeAll

	arm_func_start DWCi_AC_Free
DWCi_AC_Free: // 0x0208647C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #1
	mov r5, r1
	mov r4, r2
	bl DWCi_AC_GetMemPtr
	ldrb r2, [r0, #8]
	ands r1, r2, r6
	ldmeqia sp!, {r4, r5, r6, pc}
	mvn r1, r6
	and r1, r2, r1
	strb r1, [r0, #8]
	ldr r3, [r0, #4]
	mov r0, r6
	mov r1, r5
	mov r2, r4
	blx r3
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end DWCi_AC_Free

	arm_func_start DWCi_AC_Alloc
DWCi_AC_Alloc: // 0x020864C4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #1
	mov r4, r1
	bl DWCi_AC_GetMemPtr
	ldrb r1, [r0, #8]
	ands r2, r1, r5
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, pc}
	orr r1, r1, r5
	strb r1, [r0, #8]
	ldr r2, [r0, #0]
	mov r0, r5
	mov r1, r4
	blx r2
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_AC_Alloc

	arm_func_start DWCi_AC_InsertApInfo
DWCi_AC_InsertApInfo: // 0x02086510
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #0x10
	mov r4, r1
	bl DWCi_AC_GetMemPtr
	mov r1, r0
	mov r0, r4
	add r1, r1, r5, lsl #8
	mov r2, #0xf0
	bl MIi_CpuCopy32
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWCi_AC_InsertApInfo

	arm_func_start DWC_AC_Destroy
DWC_AC_Destroy: // 0x02086544
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_AC_GetPhase
	strb r0, [sp]
	ldrb r0, [sp]
	cmp r0, #0
	beq _02086568
	cmp r0, #0x12
	bne _02086578
_02086568:
	bl DWCi_AC_FreeAll
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {pc}
_02086578:
	add r0, sp, #0
	bl DWCi_AC_CloseNetwork
	ldrb r0, [sp]
	bl DWCi_AC_SetPhase
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWC_AC_Destroy

	arm_func_start DWC_AC_GetApType
DWC_AC_GetApType: // 0x02086594
	stmdb sp!, {r4, lr}
	ldr r0, _020865D4 // =0x021438DC
	mov r4, #0xff
	ldr r0, [r0, #0]
	cmp r0, #0
	moveq r0, r4
	ldmeqia sp!, {r4, pc}
	bl DWCi_AC_GetPhase
	cmp r0, #0xa
	blo _020865CC
	cmp r0, #0x10
	ldrls r0, _020865D4 // =0x021438DC
	ldrls r0, [r0, #0]
	ldrlsb r4, [r0, #0x17]
_020865CC:
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_020865D4: .word 0x021438DC
	arm_func_end DWC_AC_GetApType

	arm_func_start DWC_AC_GetStatus
DWC_AC_GetStatus: // 0x020865D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_AC_GetPhase
	cmp r0, #1
	addls sp, sp, #4
	movls r0, #0
	ldmlsia sp!, {pc}
	cmp r0, #7
	addlo sp, sp, #4
	movlo r0, #1
	ldmloia sp!, {pc}
	cmp r0, #9
	addeq sp, sp, #4
	moveq r0, #4
	ldmeqia sp!, {pc}
	cmp r0, #0xa
	addlo sp, sp, #4
	movlo r0, #2
	ldmloia sp!, {pc}
	cmp r0, #0xb
	addeq sp, sp, #4
	moveq r0, #4
	ldmeqia sp!, {pc}
	cmp r0, #0x10
	addlo sp, sp, #4
	movlo r0, #3
	ldmloia sp!, {pc}
	cmp r0, #0x10
	addeq sp, sp, #4
	moveq r0, #5
	ldmeqia sp!, {pc}
	cmp r0, #0x11
	addeq sp, sp, #4
	moveq r0, #4
	ldmeqia sp!, {pc}
	bl DWCi_AC_GetResult
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end DWC_AC_GetStatus

	arm_func_start DWC_AC_Process
DWC_AC_Process: // 0x02086670
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl DWCi_AC_GetPhase
	mov r5, r0
	cmp r5, #1
	bne _02086694
	bl sub_2088634
	mov r5, r0
	b _02086708
_02086694:
	cmp r5, #7
	bhs _020866BC
	bl OS_DisableInterrupts
	mov r4, r0
	bl sub_2088560
	mov r5, r0
	bl DWCi_AC_SetPhase
	mov r0, r4
	bl OS_RestoreInterrupts
	b _02086708
_020866BC:
	cmp r5, #9
	bhs _020866D0
	bl sub_20874F8
	mov r5, r0
	b _02086708
_020866D0:
	cmp r5, #0xa
	bhs _020866E4
	bl sub_2087D08
	mov r5, r0
	b _02086708
_020866E4:
	cmp r5, #0x10
	bhs _020866F8
	bl sub_2088AAC
	mov r5, r0
	b _02086708
_020866F8:
	cmp r5, #0x11
	bne _02086708
	bl sub_2087898
	mov r5, r0
_02086708:
	mov r0, r5
	bl DWCi_AC_SetPhase
	cmp r5, #0x10
	bne _02086730
	bl CheckDuplicate
	mov r4, r0
	bl Free_Disused
	add sp, sp, #4
	mov r0, r4
	ldmia sp!, {r4, r5, pc}
_02086730:
	cmp r5, #0x12
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, pc}
	bl Free_Disused
	mvn r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWC_AC_Process

	arm_func_start DWC_AC_Create
DWC_AC_Create: // 0x02086750
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0]
	mov r0, #1
	mov r1, #0x18
	blx r2
	mov r1, r0
	ldr r3, _020868F8 // =0x021438DC
	mov r0, #0
	mov r2, #0x18
	str r1, [r3]
	bl MIi_CpuClear32
	ldr r0, _020868F8 // =0x021438DC
	ldr r1, [r4, #0]
	ldr r3, [r0, #0]
	mov r2, #1
	str r1, [r3]
	ldr r0, [r4, #4]
	ldr r1, _020868FC // =0x00000D18
	str r0, [r3, #4]
	strb r2, [r3, #9]
	strb r2, [r3, #0x16]
	mov r0, #0x10
	strb r2, [r3, #8]
	bl DWCi_AC_Alloc
	ldr r2, _02086900 // =_021438CC
	mov r1, #0x2300
	str r0, [r2]
	mov r0, #2
	bl DWCi_AC_Alloc
	ldr r2, _02086904 // =0x021438D0
	mov r1, #0x58
	str r0, [r2]
	mov r0, #4
	bl DWCi_AC_Alloc
	ldr r2, _02086908 // =0x021438D4
	mov r1, #0xc
	str r0, [r2]
	mov r0, #8
	bl DWCi_AC_Alloc
	ldr r2, _0208690C // =0x021438D8
	ldr r1, _02086900 // =_021438CC
	str r0, [r2]
	ldr r1, [r1, #0]
	mov r0, #0
	ldr r2, _020868FC // =0x00000D18
	bl MIi_CpuClear32
	mov r0, #0
	ldr r1, _02086904 // =0x021438D0
	mov r2, #0x2300
	ldr r1, [r1, #0]
	bl MIi_CpuClear32
	mov r0, #0
	ldr r1, _02086908 // =0x021438D4
	mov r2, #0x58
	ldr r1, [r1, #0]
	bl MIi_CpuClear32
	mov r0, #0
	ldr r1, _0208690C // =0x021438D8
	mov r2, #0xc
	ldr r1, [r1, #0]
	bl MIi_CpuClear32
	ldr r0, _02086900 // =_021438CC
	ldrb r1, [r4, #8]
	ldr r0, [r0, #0]
	strb r1, [r0, #0xd0a]
	ldrb r2, [r0, #0xd0b]
	ldrb r1, [r4, #9]
	bic r2, r2, #3
	and r1, r1, #3
	orr r1, r2, r1
	strb r1, [r0, #0xd0b]
	ldr r1, _0208690C // =0x021438D8
	ldr r2, [r4, #0]
	ldr r3, [r1, #0]
	mov r1, #0
	str r2, [r3]
	ldr r2, [r4, #4]
	str r2, [r3, #4]
	str r1, [r3, #8]
	ldrb r2, [r0, #0xd0c]
	ldrb r1, [r4, #0xa]
	bic r2, r2, #0xf
	and r1, r1, #0xf
	orr r1, r2, r1
	strb r1, [r0, #0xd0c]
	ldrb r2, [r0, #0xd0c]
	ldrb r1, [r4, #0xb]
	bic r2, r2, #0x30
	and r1, r1, #3
	orr r1, r2, r1, lsl #4
	strb r1, [r0, #0xd0c]
	bl sub_208E130
	ldr r0, _02086904 // =0x021438D0
	mov r1, #0x2300
	ldr r0, [r0, #0]
	bl WCM_Init
	cmp r0, #1
	beq _020868E4
	cmp r0, #4
	blt _020868F0
_020868E4:
	bl DWCi_AC_FreeAll
	mov r0, #0
	ldmia sp!, {r4, pc}
_020868F0:
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_020868F8: .word 0x021438DC
_020868FC: .word 0x00000D18
_02086900: .word _021438CC
_02086904: .word 0x021438D0
_02086908: .word 0x021438D4
_0208690C: .word 0x021438D8
	arm_func_end DWC_AC_Create

	arm_func_start sub_2086910
sub_2086910: // 0x02086910
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xcc
	ldr r2, _02086A0C // =0x00000444
	mov r10, r0
	add r0, r1, #0x470
	add r8, r1, r2
	str r0, [sp]
	subs r9, r10, #1
	bmi _020869E0
	mov r4, #0xc0
	mla r6, r9, r4, r0
	add r7, r8, r9, lsl #2
	mov r5, #4
_02086944:
	add r1, r8, r10, lsl #2
	add r0, r8, r9, lsl #2
	ldrb r1, [r1, #2]
	ldrb r0, [r0, #2]
	cmp r1, r0
	blo _020869E0
	mov r0, r7
	add r1, sp, #4
	mov r2, r5
	bl MIi_CpuCopy32
	add r11, r8, r10, lsl #2
	mov r0, r11
	mov r1, r7
	mov r2, r5
	bl MIi_CpuCopy32
	mov r1, r11
	add r0, sp, #4
	mov r2, r5
	bl MIi_CpuCopy32
	mov r0, r6
	add r1, sp, #8
	mov r2, r4
	bl MIi_CpuCopy32
	ldr r0, [sp]
	mov r1, #0xc0
	mla r11, r10, r1, r0
	mov r0, r11
	mov r1, r6
	mov r2, r4
	bl MIi_CpuCopy32
	mov r1, r11
	add r0, sp, #8
	mov r2, r4
	bl MIi_CpuCopy32
	mov r10, r9
	sub r7, r7, #4
	sub r6, r6, #0xc0
	subs r9, r9, #1
	bpl _02086944
_020869E0:
	add r1, r8, #0x28
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear32
	ldr r0, [sp]
	mov r2, #0xc0
	add r1, r0, #0x780
	mov r0, #0
	bl MIi_CpuClear32
	add sp, sp, #0xcc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02086A0C: .word 0x00000444
	arm_func_end sub_2086910

	arm_func_start sub_2086A10
sub_2086A10: // 0x02086A10
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldrh r4, [r1, #2]
	ldr lr, _02086A8C // =0x00000444
	add r5, r3, #0x470
	mov ip, #0xc0
	add r3, r3, lr
	mla ip, r0, ip, r5
	add r0, r3, r0, lsl #2
	ands r3, r4, #2
	movne r3, r4, asr #2
	andne r4, r3, #0xff
	moveq r3, r4, asr #2
	addeq r3, r3, #0x19
	andeq r4, r3, #0xff
	ldrb r3, [r0, #2]
	and lr, r4, #0xff
	cmp lr, r3
	bls _02086A74
	strb lr, [r0, #2]
	ldrb r3, [r0, #3]
	and r2, r2, #0x7f
	bic r3, r3, #0x7f
	orr r2, r3, r2
	strb r2, [r0, #3]
_02086A74:
	mov r0, r1
	mov r1, ip
	mov r2, #0xc0
	bl MIi_CpuCopy32
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02086A8C: .word 0x00000444
	arm_func_end sub_2086A10

	arm_func_start sub_2086A90
sub_2086A90: // 0x02086A90
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr lr, _02086AF4 // =0x0000046C
	add ip, r3, #0xbf0
	add r3, r3, lr
	strb r0, [r3, #1]
	ldrh lr, [r1, #2]
	and r2, r2, #0x7f
	ands r0, lr, #2
	movne r0, lr, asr #2
	andne r0, r0, #0xff
	moveq r0, lr, asr #2
	addeq r0, r0, #0x19
	andeq r0, r0, #0xff
	strb r0, [r3, #2]
	ldrb lr, [r3, #3]
	mov r0, r1
	bic r1, lr, #0x7f
	orr lr, r1, r2
	mov r1, ip
	mov r2, #0xc0
	strb lr, [r3, #3]
	bl MIi_CpuCopy32
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02086AF4: .word 0x0000046C
	arm_func_end sub_2086A90

	arm_func_start sub_2086AF8
sub_2086AF8: // 0x02086AF8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r3
	ldrb r3, [r6, #0xd12]
	mvn r4, #0
	mov r5, #0
	cmp r3, #0
	ble _02086B90
	ldr lr, _02086BD4 // =0x00000474
	ldrb ip, [r1, #4]
	add lr, r6, lr
_02086B20:
	ldrb r7, [lr]
	cmp ip, r7
	bne _02086B80
	ldrb r8, [r1, #5]
	ldrb r7, [lr, #1]
	cmp r8, r7
	bne _02086B80
	ldrb r8, [r1, #6]
	ldrb r7, [lr, #2]
	cmp r8, r7
	bne _02086B80
	ldrb r8, [r1, #7]
	ldrb r7, [lr, #3]
	cmp r8, r7
	bne _02086B80
	ldrb r8, [r1, #8]
	ldrb r7, [lr, #4]
	cmp r8, r7
	bne _02086B80
	ldrb r8, [r1, #9]
	ldrb r7, [lr, #5]
	cmp r8, r7
	moveq r4, r5
	beq _02086B90
_02086B80:
	add r5, r5, #1
	cmp r5, r3
	add lr, lr, #0xc0
	blt _02086B20
_02086B90:
	mvn r3, #0
	cmp r4, r3
	bne _02086BC0
	mov r3, r6
	and r0, r0, #0xff
	bl sub_2086A90
	ldrb r0, [r6, #0xd12]
	mov r4, #0xa
	cmp r0, #0xa
	addlo r0, r0, #1
	strlob r0, [r6, #0xd12]
	b _02086BCC
_02086BC0:
	mov r0, r4
	mov r3, r6
	bl sub_2086A10
_02086BCC:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02086BD4: .word 0x00000474
	arm_func_end sub_2086AF8

	arm_func_start sub_2086BD8
sub_2086BD8: // 0x02086BD8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r4, r0
	ldrh r2, [r4, #0xa]
	mov r10, r1
	cmp r2, #0x20
	bne _02086BFC
	bl sub_2086D00
	cmp r0, #0
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02086BFC:
	ldrb r5, [r10, #0xd12]
	mov r9, #0
	cmp r5, #0
	ble _02086C64
	ldr r0, _02086C6C // =0x0000047C
	ldrh r6, [r4, #0xa]
	mov r8, r10
	add r7, r10, r0
	add r4, r4, #0xc
_02086C20:
	add r0, r8, #0x400
	ldrh r0, [r0, #0x7a]
	cmp r6, r0
	bne _02086C50
	mov r0, r4
	mov r1, r7
	mov r2, r6
	bl strncmp
	cmp r0, #0
	addeq r0, r10, r9, lsl #2
	ldreqb r0, [r0, #0x445]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02086C50:
	add r9, r9, #1
	cmp r9, r5
	add r8, r8, #0xc0
	add r7, r7, #0xc0
	blt _02086C20
_02086C64:
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02086C6C: .word 0x0000047C
	arm_func_end sub_2086BD8

	arm_func_start sub_2086C70
sub_2086C70: // 0x02086C70
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r6, r0
	ldrh r3, [r6, #0xa]
	mov r5, r1
	mov r4, r2
	cmp r3, #0x20
	bne _02086CA0
	bl sub_2086D00
	cmp r0, #0
	addgt sp, sp, #4
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02086CA0:
	cmp r5, #0
	mov r9, #0
	ble _02086CF4
	ldrh r8, [r6, #0xa]
	add r6, r6, #0xc
	and r7, r8, #0xff
_02086CB8:
	ldrb r0, [r4, #3]
	cmp r7, r0
	bne _02086CE4
	mov r0, r6
	mov r2, r8
	add r1, r4, #4
	bl strncmp
	cmp r0, #0
	addeq sp, sp, #4
	ldreqb r0, [r4, #1]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_02086CE4:
	add r9, r9, #1
	cmp r9, r5
	add r4, r4, #0x24
	blt _02086CB8
_02086CF4:
	mvn r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end sub_2086C70

	arm_func_start sub_2086D00
sub_2086D00: // 0x02086D00
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	ldrb r0, [r4, #0xd0c]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1c
	beq _02086D30
	cmp r0, #4
	bne _02086D60
_02086D30:
	ldrh r0, [r5, #0x2c]
	mov r0, r0, asr #4
	and r0, r0, #1
	and r0, r0, #0xff
	cmp r0, #1
	bne _02086D60
	add r0, r5, #0xc
	bl sub_20890B8
	cmp r0, #1
	addeq sp, sp, #4
	moveq r0, #6
	ldmeqia sp!, {r4, r5, pc}
_02086D60:
	ldrb r0, [r4, #0xd0c]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1c
	beq _02086D78
	cmp r0, #5
	bne _02086DA8
_02086D78:
	ldrh r0, [r5, #0x2c]
	mov r0, r0, asr #4
	and r0, r0, #1
	and r0, r0, #0xff
	cmp r0, #1
	bne _02086DA8
	add r0, r5, #0xc
	bl sub_2089158
	cmp r0, #1
	addeq sp, sp, #4
	moveq r0, #7
	ldmeqia sp!, {r4, r5, pc}
_02086DA8:
	mvn r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_2086D00

	arm_func_start sub_2086DB4
sub_2086DB4: // 0x02086DB4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r0, #0x10
	mvn r6, #0
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	mov r0, #1
	bl DWCi_AC_GetMemPtr
	mov r1, #1
	strb r1, [r0, #0xb]
	bl DWCi_AC_GetPhase
	cmp r0, #3
	beq _02086E04
	cmp r0, #4
	beq _02086E74
	cmp r0, #5
	beq _02086EC0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_02086E04:
	ldrh r1, [r7, #0xa]
	ldrb r5, [r4, #0xd11]
	cmp r1, #0
	beq _02086E20
	ldrb r0, [r7, #0xc]
	cmp r0, #0
	bne _02086E2C
_02086E20:
	ldrh r0, [r7, #0x36]
	bl sub_208852C
	b _02086F08
_02086E2C:
	cmp r1, #1
	beq _02086E3C
	cmp r0, #0x20
	bne _02086E5C
_02086E3C:
	ldrh r0, [r7, #0x36]
	bl sub_208852C
	ldrb r1, [r4, #0xd10]
	mov r0, r7
	add r2, r4, #0x300
	bl sub_2086C70
	mov r6, r0
	b _02086F08
_02086E5C:
	ldrb r1, [r4, #0xd10]
	mov r0, r7
	add r2, r4, #0x300
	bl sub_2086C70
	mov r6, r0
	b _02086F08
_02086E74:
	ldrb r2, [r4, #0xd0f]
	mov r1, #0xc0
	mov r0, r7
	mla r1, r2, r1, r4
	add r1, r1, #0x400
	ldrh r2, [r1, #0xa6]
	mov r1, r4
	sub r2, r2, #1
	and r5, r2, #0xff
	bl sub_2086BD8
	movs r6, r0
	bmi _02086F08
	ldr r0, _02086F38 // =0x00000447
	ldrb r1, [r4, #0xd0f]
	add r2, r4, r0
	ldrb r0, [r2, r1, lsl #2]
	orr r0, r0, #0x80
	strb r0, [r2, r1, lsl #2]
	b _02086F08
_02086EC0:
	ldrb r1, [r4, #0xd0f]
	add r2, r4, #0x300
	mov r0, #0x24
	mla r2, r1, r0, r2
	mov r0, r7
	mov r1, #1
	ldrb r5, [r4, #0xd11]
	bl sub_2086C70
	movs r6, r0
	bmi _02086F08
	ldrb r1, [r4, #0xd0f]
	mov r0, #0x24
	add r3, r4, #0x300
	mul r2, r1, r0
	ldrb r0, [r3, r2]
	bic r0, r0, #0xf
	orr r0, r0, #1
	strb r0, [r3, r2]
_02086F08:
	cmp r6, #0
	addlt sp, sp, #4
	ldmltia sp!, {r4, r5, r6, r7, pc}
	mov r0, r6
	mov r1, r7
	mov r2, r5
	mov r3, r4
	bl sub_2086AF8
	mov r1, r4
	bl sub_2086910
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02086F38: .word 0x00000447
	arm_func_end sub_2086DB4

	arm_func_start sub_2086F3C
sub_2086F3C: // 0x02086F3C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	ldrsh r1, [r4, #0]
	cmp r1, #5
	bne _02086FB4
	ldrsh r1, [r4, #2]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #8]
	cmp r1, #0xd
	beq _02086F84
	cmp r1, #0xf
	beq _02086F90
	cmp r1, #0x11
	beq _02086F9C
	b _02086FA8
_02086F84:
	mov r1, #1
	strb r1, [r0, #0xd14]
	ldmia sp!, {r4, pc}
_02086F90:
	mov r1, #2
	strb r1, [r0, #0xd14]
	ldmia sp!, {r4, pc}
_02086F9C:
	mov r1, #3
	strb r1, [r0, #0xd14]
	ldmia sp!, {r4, pc}
_02086FA8:
	mov r1, #4
	strb r1, [r0, #0xd14]
	ldmia sp!, {r4, pc}
_02086FB4:
	cmp r1, #7
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #4]
	bl sub_2086DB4
	ldmia sp!, {r4, pc}
	arm_func_end sub_2086F3C

	arm_func_start sub_2086FC8
sub_2086FC8: // 0x02086FC8
	stmdb sp!, {r4, lr}
	mov r4, r2
	cmp r1, #9
	addls pc, pc, r1, lsl #2
	b _020870A8
_02086FDC: // jump table
	b _0208700C // case 0
	b _02087008 // case 1
	b _02087004 // case 2
	b _02087038 // case 3
	b _02087034 // case 4
	b _02087030 // case 5
	b _0208705C // case 6
	b _02087084 // case 7
	b _020870A8 // case 8
	b _020870A8 // case 9
_02087004:
	add r0, r0, #0x100
_02087008:
	add r0, r0, #0x100
_0208700C:
	ldrb r2, [r0, #0xe6]
	add r0, r0, #0x80
	add r1, r4, #2
	mov r2, r2, lsl #0x1e
	mov r3, r2, lsr #0x1e
	mov r2, #0x50
	strb r3, [r4]
	bl MI_CpuCopy8
	b _020870A8
_02087030:
	add r0, r0, #0x100
_02087034:
	add r0, r0, #0x100
_02087038:
	mov r3, #1
	add r0, r0, #0xd1
	add r1, r4, #2
	mov r2, #0x14
	strb r3, [r4]
	bl MI_CpuCopy8
	mov r0, #0
	strb r0, [r4, #0x16]
	b _020870A8
_0208705C:
	mov r1, #2
	strb r1, [r4]
	ldr r1, _020870BC // =0x0000047C
	ldrb r2, [r0, #0xd13]
	add r1, r0, r1
	mov r0, #0xc0
	mla r0, r2, r0, r1
	add r1, r4, #2
	bl sub_20890A8
	b _020870A8
_02087084:
	mov r1, #2
	strb r1, [r4]
	ldr r1, _020870BC // =0x0000047C
	ldrb r2, [r0, #0xd13]
	add r1, r0, r1
	mov r0, #0xc0
	mla r0, r2, r0, r1
	add r1, r4, #2
	bl sub_2089130
_020870A8:
	ldrb r0, [r4, #0]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_020870BC: .word 0x0000047C
	arm_func_end sub_2086FC8

	arm_func_start sub_20870C0
sub_20870C0: // 0x020870C0
	ldrb r0, [r0, #0xd0b]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1e
	cmp r0, #1
	moveq r0, #0xc0000
	movne r0, #0x80000
	bx lr
	arm_func_end sub_20870C0

	arm_func_start sub_20870DC
sub_20870DC: // 0x020870DC
	ldrb r0, [r0, #0xd0b]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1e
	cmp r0, #1
	moveq r0, #0x30000
	movne r0, #0x20000
	bx lr
	arm_func_end sub_20870DC

	arm_func_start sub_20870F8
sub_20870F8: // 0x020870F8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	ldrb r2, [r10, #0xd13]
	ldrb r1, [r10, #0xd0c]
	add r3, r10, #0x470
	mov r0, #0xc0
	mla r9, r2, r0, r3
	mov r0, r1, lsl #0x18
	movs r0, r0, lsr #0x1e
	mov r0, #0
	str r0, [sp]
	bne _0208721C
	ldrh r0, [r9, #0xa]
	ldr r7, [sp]
	cmp r0, #0x20
	bne _0208715C
	mov r0, r9
	bl sub_2086D00
	cmp r0, #0
	str r0, [sp]
	movle r0, #0
	addgt r7, r7, #1
	strle r0, [sp]
	b _02087180
_0208715C:
	cmp r0, #8
	bne _02087180
	mov r0, r9
	bl sub_2087C1C
	cmp r0, #0
	str r0, [sp]
	moveq r0, #0
	addne r7, r7, #1
	streq r0, [sp]
_02087180:
	ldrb r0, [r10, #0xd10]
	mov r8, #0
	cmp r0, #0
	ble _0208728C
	mov r6, r10
	add r5, r10, #0x304
	add r4, r10, #0x300
	ldr r0, _0208729C // =0x00000D0C
	add r11, r10, r0
_020871A4:
	ldrh r2, [r9, #0xa]
	ldrb r0, [r6, #0x303]
	cmp r2, r0
	bne _020871FC
	mov r1, r5
	add r0, r9, #0xc
	bl strncmp
	cmp r0, #0
	bne _020871FC
	cmp r7, #0
	ldreqb r0, [r6, #0x301]
	streq r0, [sp]
	beq _020871F8
	ldrb r0, [r4, #0]
	bic r0, r0, #0xf0
	orr r0, r0, #0x10
	strb r0, [r4]
	ldrb r0, [r11, #0]
	bic r0, r0, #0xc0
	orr r0, r0, #0x40
	strb r0, [r11]
_020871F8:
	add r7, r7, #1
_020871FC:
	ldrb r0, [r10, #0xd10]
	add r8, r8, #1
	add r6, r6, #0x24
	cmp r8, r0
	add r5, r5, #0x24
	add r4, r4, #0x24
	blt _020871A4
	b _0208728C
_0208721C:
	ldrb r0, [r10, #0xd10]
	ldr r2, [sp]
	mov r3, r2
	cmp r0, #0
	ble _0208727C
	mov r4, r10
	add r5, r10, #0x300
_02087238:
	ldrb r0, [r5, #0]
	mov r1, r0, lsl #0x18
	mov r1, r1, lsr #0x1c
	cmp r1, #1
	bne _02087264
	cmp r3, #0
	biceq r0, r0, #0xf0
	streqb r0, [r5]
	ldreqb r0, [r4, #0x301]
	add r3, r3, #1
	streq r0, [sp]
_02087264:
	ldrb r0, [r10, #0xd10]
	add r2, r2, #1
	add r5, r5, #0x24
	cmp r2, r0
	add r4, r4, #0x24
	blt _02087238
_0208727C:
	cmp r3, #1
	ldreqb r0, [r10, #0xd0c]
	biceq r0, r0, #0xc0
	streqb r0, [r10, #0xd0c]
_0208728C:
	ldr r0, [sp]
	and r0, r0, #0xff
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208729C: .word 0x00000D0C
	arm_func_end sub_20870F8

	arm_func_start sub_20872A0
sub_20872A0: // 0x020872A0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl WCM_GetPhase
	ldrb r2, [r6, #0xd13]
	add r3, r6, #0x470
	mov r1, #0xc0
	mla r5, r2, r1, r3
	cmp r0, #3
	bne _020873AC
	mov r0, r6
	bl sub_20870DC
	ldrb r1, [r6, #0xd15]
	mov r4, r0
	add r0, r1, #1
	strb r0, [r6, #0xd15]
	ldrb r1, [r6, #0xd15]
	cmp r1, #3
	bls _02087308
	mov r0, #0
	strb r0, [r6, #0xd15]
	ldrb r1, [r6, #0xd13]
	mov r2, #1
	mov r0, #9
	add r1, r6, r1, lsl #2
	strb r2, [r1, #0x444]
	ldmia sp!, {r4, r5, r6, pc}
_02087308:
	cmp r1, #1
	beq _02087388
	ldrb r0, [r6, #0xd14]
	cmp r0, #1
	ldreqb r0, [r6, #0xd0b]
	biceq r0, r0, #0xc
	streqb r0, [r6, #0xd0b]
	beq _02087388
	cmp r0, #2
	bne _02087350
	mov r0, #0
	strb r0, [r6, #0xd15]
	ldrb r1, [r6, #0xd13]
	mov r2, #3
	mov r0, #9
	add r1, r6, r1, lsl #2
	strb r2, [r1, #0x444]
	ldmia sp!, {r4, r5, r6, pc}
_02087350:
	cmp r0, #3
	bne _02087378
	mov r0, #0
	strb r0, [r6, #0xd15]
	ldrb r1, [r6, #0xd13]
	mov r2, #4
	mov r0, #9
	add r1, r6, r1, lsl #2
	strb r2, [r1, #0x444]
	ldmia sp!, {r4, r5, r6, pc}
_02087378:
	cmp r1, #3
	ldreqb r0, [r6, #0xd0b]
	biceq r0, r0, #0xc
	streqb r0, [r6, #0xd0b]
_02087388:
	mov r0, r6
	bl sub_20870C0
	mov r2, r0
	ldr r1, _020873D8 // =0x00000CB8
	mov r0, r5
	add r1, r6, r1
	orr r2, r4, r2
	bl WCM_ConnectAsync
	b _020873D0
_020873AC:
	cmp r0, #9
	bne _020873D0
	mov r0, #0
	strb r0, [r6, #0xd15]
	bl OS_GetTick
	str r0, [r6, #0xcb0]
	str r1, [r6, #0xcb4]
	mov r0, #0xa
	ldmia sp!, {r4, r5, r6, pc}
_020873D0:
	mov r0, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020873D8: .word 0x00000CB8
	arm_func_end sub_20872A0

	arm_func_start sub_20873DC
sub_20873DC: // 0x020873DC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldrb r2, [r5, #0xd13]
	add r3, r5, #0x470
	mov r1, #0xc0
	mla r4, r2, r1, r3
	bl sub_20870F8
	ldr r1, _020874F4 // =0x00000CB8
	strb r0, [r5, #0xd0d]
	add r0, r5, r1
	mov r1, #0
	mov r2, #0x52
	bl MI_CpuFill8
	ldr r2, _020874F4 // =0x00000CB8
	ldrb r1, [r5, #0xd0d]
	mov r0, r5
	add r2, r5, r2
	bl sub_2086FC8
	cmp r0, #0
	beq _020874A0
	ldrb r0, [r5, #0xd0b]
	bic r0, r0, #0xc
	orr r0, r0, #4
	strb r0, [r5, #0xd0b]
	ldrh r0, [r4, #0x2c]
	mov r0, r0, asr #4
	ands r0, r0, #1
	bne _0208746C
	ldrb r1, [r5, #0xd13]
	mov r2, #3
	add sp, sp, #4
	add r1, r5, r1, lsl #2
	strb r2, [r1, #0x444]
	mov r0, #9
	ldmia sp!, {r4, r5, pc}
_0208746C:
	ldrb r0, [r5, #0xd0d]
	cmp r0, #6
	bne _020874DC
	ldrb r0, [r4, #0x15]
	cmp r0, #0
	bne _020874DC
	ldrb r1, [r5, #0xd13]
	mov r2, #3
	add sp, sp, #4
	add r1, r5, r1, lsl #2
	strb r2, [r1, #0x444]
	mov r0, #9
	ldmia sp!, {r4, r5, pc}
_020874A0:
	ldrb r0, [r5, #0xd0b]
	bic r0, r0, #0xc
	strb r0, [r5, #0xd0b]
	ldrh r0, [r4, #0x2c]
	mov r0, r0, asr #4
	and r0, r0, #1
	cmp r0, #1
	bne _020874DC
	ldrb r1, [r5, #0xd13]
	mov r2, #3
	add sp, sp, #4
	add r1, r5, r1, lsl #2
	strb r2, [r1, #0x444]
	mov r0, #9
	ldmia sp!, {r4, r5, pc}
_020874DC:
	mov r0, #0
	strb r0, [r5, #0xd15]
	strb r0, [r5, #0xd14]
	mov r0, #8
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020874F4: .word 0x00000CB8
	arm_func_end sub_20873DC

	arm_func_start sub_20874F8
sub_20874F8: // 0x020874F8
	stmdb sp!, {r4, lr}
	bl DWCi_AC_GetPhase
	mov r4, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	cmp r4, #7
	beq _02087520
	cmp r4, #8
	beq _0208752C
	b _02087534
_02087520:
	bl sub_20873DC
	mov r4, r0
	b _02087534
_0208752C:
	bl sub_20872A0
	mov r4, r0
_02087534:
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end sub_20874F8

	arm_func_start sub_208753C
sub_208753C: // 0x0208753C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20BDBEC
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	bl sub_20BE40C
	cmp r0, #0
	beq _02087570
	mvn r1, #0x26
	cmp r0, r1
	bne _0208757C
_02087570:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {pc}
_0208757C:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_208753C

	arm_func_start sub_2087588
sub_2087588: // 0x02087588
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WCM_GetPhase
	cmp r0, #0xc
	addls pc, pc, r0, lsl #2
	b _0208761C
_020875A0: // jump table
	b _020875D4 // case 0
	b _020875E0 // case 1
	b _0208761C // case 2
	b _020875E8 // case 3
	b _0208761C // case 4
	b _0208761C // case 5
	b _020875F0 // case 6
	b _0208761C // case 7
	b _0208761C // case 8
	b _020875F8 // case 9
	b _0208761C // case 10
	b _02087608 // case 11
	b _02087600 // case 12
_020875D4:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {pc}
_020875E0:
	bl WCM_Finish
	b _0208761C
_020875E8:
	bl WCM_CleanupAsync
	b _0208761C
_020875F0:
	bl WCM_EndSearchAsync
	b _0208761C
_020875F8:
	bl WCM_DisconnectAsync
	b _0208761C
_02087600:
	bl WCM_TerminateAsync
	b _0208761C
_02087608:
	mov r0, #0
	bl DWCi_AC_SetError
	add sp, sp, #4
	mvn r0, #0
	ldmia sp!, {pc}
_0208761C:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_2087588

	arm_func_start DWCi_AC_CloseNetwork
DWCi_AC_CloseNetwork: // 0x02087628
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r0, [r4, #0]
	cmp r0, #0xa
	bhi _02087670
	bl sub_2087588
	cmp r0, #1
	moveq r0, #0
	streqb r0, [r4]
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	mvn r1, #0
	cmp r0, r1
	bne _020876A4
	mov r0, #0x12
	strb r0, [r4]
	mov r0, #1
	ldmia sp!, {r4, pc}
_02087670:
	cmp r0, #0xe
	bne _0208768C
	bl sub_208CC90
	bl sub_208CD10
	mov r0, #0xc
	strb r0, [r4]
	b _020876A4
_0208768C:
	cmp r0, #0x12
	bhs _020876A4
	bl sub_208753C
	cmp r0, #1
	moveq r0, #0xa
	streqb r0, [r4]
_020876A4:
	mov r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_AC_CloseNetwork

	arm_func_start sub_20876AC
sub_20876AC: // 0x020876AC
	ldrb r1, [r0, #0x16]
	cmp r1, #0xa
	bhs _020876F4
	ldrb r1, [r0, #0x14]
	cmp r1, #3
	ldreqb r1, [r0, #0x15]
	ldreq r0, _020877B4 // =0xFFFF3864
	subeq r2, r0, r1
	beq _020877AC
	cmp r1, #4
	ldreqb r1, [r0, #0x15]
	moveq r0, #0xc800
	rsbeq r0, r0, #0
	subeq r2, r0, r1
	ldrneb r1, [r0, #0x15]
	ldrne r0, _020877B8 // =0xFFFF379C
	subne r2, r0, r1
	b _020877AC
_020876F4:
	cmp r1, #0xd
	ldrlob r1, [r0, #0x15]
	ldrlo r0, _020877BC // =0xFFFF34E0
	sublo r2, r0, r1
	blo _020877AC
	ldr r2, [r0, #0x10]
	cmp r2, #0
	ldreqb r1, [r0, #0x15]
	ldreq r0, _020877C0 // =0xFFFF3CB0
	subeq r2, r0, r1
	beq _020877AC
	mvn r1, #0
	cmp r2, r1
	ldreqb r1, [r0, #0x15]
	ldreq r0, _020877C4 // =0xFFFF347C
	subeq r2, r0, r1
	beq _020877AC
	mvn r1, #1
	cmp r2, r1
	ldreqb r1, [r0, #0x15]
	ldreq r0, _020877C8 // =0xFFFF3418
	subeq r2, r0, r1
	beq _020877AC
	mvn r1, #2
	cmp r2, r1
	ldreqb r1, [r0, #0x15]
	ldreq r0, _020877CC // =0xFFFF33B4
	subeq r2, r0, r1
	beq _020877AC
	mvn r1, #3
	cmp r2, r1
	ldreqb r1, [r0, #0x15]
	ldreq r0, _020877D0 // =0xFFFF30F8
	subeq r2, r0, r1
	beq _020877AC
	mvn r1, #4
	cmp r2, r1
	ldreqb r1, [r0, #0x15]
	ldreq r0, _020877D4 // =0xFFFF3094
	subeq r2, r0, r1
	beq _020877AC
	mvn r1, #5
	cmp r2, r1
	ldreqb r1, [r0, #0x15]
	ldreq r0, _020877D8 // =0xFFFF3030
	subeq r2, r0, r1
_020877AC:
	mov r0, r2
	bx lr
	.align 2, 0
_020877B4: .word 0xFFFF3864
_020877B8: .word 0xFFFF379C
_020877BC: .word 0xFFFF34E0
_020877C0: .word 0xFFFF3CB0
_020877C4: .word 0xFFFF347C
_020877C8: .word 0xFFFF3418
_020877CC: .word 0xFFFF33B4
_020877D0: .word 0xFFFF30F8
_020877D4: .word 0xFFFF3094
_020877D8: .word 0xFFFF3030
	arm_func_end sub_20876AC

	arm_func_start sub_20877DC
sub_20877DC: // 0x020877DC
	ldrb r0, [r0, #0xb]
	cmp r0, #0
	ldreq r0, _020877F0 // =0xFFFF3C4D
	ldrne r0, _020877F4 // =0xFFFF3865
	bx lr
	.align 2, 0
_020877F0: .word 0xFFFF3C4D
_020877F4: .word 0xFFFF3865
	arm_func_end sub_20877DC

	arm_func_start sub_20877F8
sub_20877F8: // 0x020877F8
	mvn r0, #5
	bx lr
	arm_func_end sub_20877F8

	arm_func_start sub_2087800
sub_2087800: // 0x02087800
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0208783C
_0208780C: // jump table
	b _02087824 // case 0
	b _0208781C // case 1
	b _0208782C // case 2
	b _02087834 // case 3
_0208781C:
	mvn r0, #8
	bx lr
_02087824:
	mvn r0, #9
	bx lr
_0208782C:
	mvn r0, #7
	bx lr
_02087834:
	mvn r0, #6
	bx lr
_0208783C:
	mov r0, #0
	bx lr
	arm_func_end sub_2087800

	arm_func_start DWCi_AC_GetResult
DWCi_AC_GetResult: // 0x02087844
	stmdb sp!, {r4, lr}
	mov r0, #1
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	bl DWCi_AC_GetError
	cmp r0, #4
	bge _02087868
	bl sub_2087800
	ldmia sp!, {r4, pc}
_02087868:
	cmp r0, #5
	bge _02087878
	bl sub_20877F8
	ldmia sp!, {r4, pc}
_02087878:
	cmp r0, #5
	bne _0208788C
	mov r0, r4
	bl sub_20877DC
	ldmia sp!, {r4, pc}
_0208788C:
	mov r0, r4
	bl sub_20876AC
	ldmia sp!, {r4, pc}
	arm_func_end DWCi_AC_GetResult

	arm_func_start sub_2087898
sub_2087898: // 0x02087898
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	bl DWCi_AC_GetMemPtr
	add r0, r0, #0xa
	bl DWCi_AC_CloseNetwork
	cmp r0, #1
	moveq r0, #0x12
	movne r0, #0x11
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_2087898

	arm_func_start sub_20878C4
sub_20878C4: // 0x020878C4
	ldrb r2, [r0, #0xd12]
	mov r3, #0
	mov ip, r3
	cmp r2, #0
	bls _02087900
_020878D8:
	add r1, r0, ip, lsl #2
	ldrb r1, [r1, #0x447]
	mov r1, r1, lsl #0x18
	movs r1, r1, lsr #0x1f
	moveq r3, ip
	beq _02087900
	add r1, ip, #1
	and ip, r1, #0xff
	cmp ip, r2
	blo _020878D8
_02087900:
	mov r0, r3
	bx lr
	arm_func_end sub_20878C4

	arm_func_start sub_2087908
sub_2087908: // 0x02087908
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldrb r1, [r0, #0xd12]
	mov r3, #0
	mov ip, r3
	cmp r1, #0
	ble _02087990
	ldr r2, _0208799C // =0x00000447
	mov r1, r0
	add r2, r0, r2
_02087930:
	add r4, r0, ip, lsl #2
	ldrb r4, [r4, #0x444]
	cmp r4, #0
	bne _0208796C
	add lr, r1, #0x400
	ldrh r4, [lr, #0xa6]
	ldrb lr, [r2]
	sub r5, r4, #1
	mov r4, lr, lsl #0x19
	cmp r5, r4, lsr #25
	bicne lr, lr, #0x80
	addne r3, r3, #1
	strneb lr, [r2]
	andne r3, r3, #0xff
	bne _02087978
_0208796C:
	ldrb lr, [r2]
	orr lr, lr, #0x80
	strb lr, [r2]
_02087978:
	ldrb lr, [r0, #0xd12]
	add ip, ip, #1
	add r2, r2, #4
	cmp ip, lr
	add r1, r1, #0xc0
	blt _02087930
_02087990:
	mov r0, r3
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0208799C: .word 0x00000447
	arm_func_end sub_2087908

	arm_func_start sub_20879A0
sub_20879A0: // 0x020879A0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r5, #0
	mov r4, r0
	mov r6, r5
	add lr, r0, #0x300
	mov ip, r5
	mov r2, r5
	mov r1, r5
	mov r7, r5
	mov r3, #1
_020879C8:
	ldrb r8, [r0, #0xd0c]
	mov r8, r8, lsl #0x1c
	movs r9, r8, lsr #0x1c
	beq _020879E4
	add r8, r6, #1
	cmp r9, r8
	bne _02087AA0
_020879E4:
	ldrb r8, [r4, #0xe7]
	cmp r8, #0xff
	beq _02087AA0
	mov r9, ip
_020879F4:
	add r8, r4, r9
	ldrb r10, [r8, #0x40]
	cmp r10, #0
	beq _02087A1C
	add r8, r9, #1
	add r9, lr, r9
	strb r10, [r9, #4]
	and r9, r8, #0xff
	cmp r9, #0x20
	blo _020879F4
_02087A1C:
	cmp r9, #0
	strneb r9, [lr, #3]
	movne r8, r3
	strneb r6, [lr, #1]
	moveq r8, r2
	cmp r8, #0
	addne r5, r5, #1
	ldrb r8, [r4, #0xe7]
	andne r5, r5, #0xff
	addne lr, lr, #0x24
	cmp r8, #1
	bne _02087AA0
	mov r9, r1
_02087A50:
	add r8, r4, r9
	ldrb r10, [r8, #0x60]
	cmp r10, #0
	beq _02087A78
	add r8, r9, #1
	add r9, lr, r9
	strb r10, [r9, #4]
	and r9, r8, #0xff
	cmp r9, #0x20
	blo _02087A50
_02087A78:
	cmp r9, #0
	strneb r9, [lr, #3]
	movne r9, r3
	addne r8, r6, #3
	moveq r9, r7
	strneb r8, [lr, #1]
	cmp r9, #0
	addne r5, r5, #1
	andne r5, r5, #0xff
	addne lr, lr, #0x24
_02087AA0:
	add r6, r6, #1
	cmp r6, #3
	add r4, r4, #0x100
	blt _020879C8
	mov r0, r5
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end sub_20879A0

	arm_func_start sub_2087AB8
sub_2087AB8: // 0x02087AB8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	add r4, r6, #0x300
	bl sub_20879A0
	ldrb r1, [r6, #0xd0c]
	mov r5, r0
	mov r0, #0x24
	mov r1, r1, lsl #0x1c
	mla r4, r5, r0, r4
	movs r0, r1, lsr #0x1c
	beq _02087AEC
	cmp r0, #4
	bne _02087B18
_02087AEC:
	ldr r0, _02087BA4 // =aNwcusbap
	add r1, r4, #4
	mov r2, #8
	bl MI_CpuCopy8
	mov r1, #8
	add r0, r5, #1
	strb r1, [r4, #3]
	mov r1, #6
	strb r1, [r4, #1]
	and r5, r0, #0xff
	add r4, r4, #0x24
_02087B18:
	ldrb r0, [r6, #0xd0c]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1c
	beq _02087B30
	cmp r0, #7
	bne _02087B5C
_02087B30:
	ldr r0, _02087BA8 // =aWayport2freesp
	add r1, r4, #4
	mov r2, #8
	bl MI_CpuCopy8
	mov r1, #8
	add r0, r5, #1
	strb r1, [r4, #3]
	mov r1, #9
	strb r1, [r4, #1]
	and r5, r0, #0xff
	add r4, r4, #0x24
_02087B5C:
	ldrb r0, [r6, #0xd0c]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1c
	beq _02087B74
	cmp r0, #8
	bne _02087B9C
_02087B74:
	ldr r0, _02087BAC // =0x02112548
	add r1, r4, #4
	mov r2, #0xb
	bl MI_CpuCopy8
	mov r1, #0xb
	add r0, r5, #1
	strb r1, [r4, #3]
	mov r1, #0xa
	strb r1, [r4, #1]
	and r5, r0, #0xff
_02087B9C:
	mov r0, r5
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02087BA4: .word aNwcusbap
_02087BA8: .word aWayport2freesp
_02087BAC: .word 0x02112548
	arm_func_end sub_2087AB8

	arm_func_start sub_2087BB0
sub_2087BB0: // 0x02087BB0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	add r4, r5, #0x300
	bl sub_20879A0
	ldrb r1, [r5, #0xd0c]
	mov r5, r0
	mov r0, #0x24
	mov r1, r1, lsl #0x1c
	mla r4, r5, r0, r4
	movs r0, r1, lsr #0x1c
	beq _02087BE8
	cmp r0, #6
	bne _02087C0C
_02087BE8:
	ldr r0, _02087C18 // =0x02112540
	add r1, r4, #4
	mov r2, #8
	bl MI_CpuCopy8
	mov r1, #8
	strb r1, [r4, #3]
	add r0, r5, #1
	strb r1, [r4, #1]
	and r5, r0, #0xff
_02087C0C:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02087C18: .word 0x02112540
	arm_func_end sub_2087BB0

	arm_func_start sub_2087C1C
sub_2087C1C: // 0x02087C1C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	ldrb r0, [r0, #0xd0c]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1c
	beq _02087C44
	cmp r0, #6
	bne _02087C60
_02087C44:
	ldr r1, _02087C68 // =0x02112540
	add r0, r4, #0xc
	mov r2, #8
	bl strncmp
	cmp r0, #0
	moveq r0, #8
	ldmeqia sp!, {r4, pc}
_02087C60:
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02087C68: .word 0x02112540
	arm_func_end sub_2087C1C

	arm_func_start sub_2087C6C
sub_2087C6C: // 0x02087C6C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	cmp r5, #0
	beq _02087CA0
	cmp r5, #1
	beq _02087CC0
	cmp r5, #2
	beq _02087CD8
	b _02087CFC
_02087CA0:
	add r1, r4, #0x300
	mov r0, #0
	mov r2, #0x144
	bl MIi_CpuClear32
	mov r0, r4
	bl sub_2087BB0
	strb r0, [r4, #0xd10]
	b _02087CFC
_02087CC0:
	bl sub_2087908
	strb r0, [r4, #0xd10]
	mov r0, r4
	bl sub_20878C4
	strb r0, [r4, #0xd0f]
	b _02087CFC
_02087CD8:
	add r1, r4, #0x300
	mov r0, #0
	mov r2, #0x144
	bl MIi_CpuClear32
	mov r1, #0
	mov r0, r4
	strb r1, [r4, #0xd0f]
	bl sub_2087AB8
	strb r0, [r4, #0xd10]
_02087CFC:
	ldrb r0, [r4, #0xd10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_2087C6C

	arm_func_start sub_2087D08
sub_2087D08: // 0x02087D08
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	mov r5, #9
	bl WCM_GetPhase
	cmp r0, #0xc
	addls pc, pc, r0, lsl #2
	b _02087DE0
_02087D30: // jump table
	b _02087DE0 // case 0
	b _02087DE0 // case 1
	b _02087DE0 // case 2
	b _02087D64 // case 3
	b _02087DE0 // case 4
	b _02087DE0 // case 5
	b _02087DB0 // case 6
	b _02087DE0 // case 7
	b _02087DE0 // case 8
	b _02087DB8 // case 9
	b _02087DE0 // case 10
	b _02087DD4 // case 11
	b _02087DC0 // case 12
_02087D64:
	ldrb r0, [r4, #0xd0c]
	ldrb r5, [r4, #0xd0e]
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1e
	cmp r0, #1
	bne _02087D94
	ldrb r0, [r4, #0xd13]
	mov r1, #0
	mov r5, #7
	add r0, r4, r0, lsl #2
	strb r1, [r0, #0x444]
	b _02087DE0
_02087D94:
	cmp r5, #3
	blo _02087DE0
	cmp r5, #5
	bhi _02087DE0
	mov r0, r5
	bl sub_20883C4
	b _02087DE0
_02087DB0:
	bl WCM_EndSearchAsync
	b _02087DE0
_02087DB8:
	bl WCM_DisconnectAsync
	b _02087DE0
_02087DC0:
	bl WCM_TerminateAsync
	mov r0, #4
	bl DWCi_AC_SetError
	mov r5, #0x11
	b _02087DE0
_02087DD4:
	mov r0, #0
	bl DWCi_AC_SetError
	mov r5, #0x11
_02087DE0:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_2087D08

	arm_func_start sub_2087DEC
sub_2087DEC: // 0x02087DEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, _02087E14 // =_02112554
	cmp r2, #0xc
	movgt r2, #0xc
	ldr r2, [ip, r2, lsl #2]
	orr r2, r3, r2
	bl WCM_SearchAsync
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02087E14: .word _02112554
	arm_func_end sub_2087DEC

	arm_func_start sub_2087E18
sub_2087E18: // 0x02087E18
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xd00
	ldrh r0, [r0, #0x16]
	cmp r0, #0
	beq _02087E54
	mov r0, #2
	bl sub_2087C6C
	cmp r0, #0
	beq _02087E54
	mov r0, #0
	bl sub_20884C0
	strb r0, [r4, #0xd11]
	mov r0, #5
	ldmia sp!, {r4, pc}
_02087E54:
	ldrb r0, [r4, #0xd0b]
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1c
	cmp r0, #1
	movhs r0, #6
	ldmhsia sp!, {r4, pc}
	mov r0, r4
	bl sub_2088288
	ldmia sp!, {r4, pc}
	arm_func_end sub_2087E18

	arm_func_start sub_2087E78
sub_2087E78: // 0x02087E78
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	cmp r4, #0x11
	mov r5, r0
	addeq sp, sp, #4
	moveq r0, r4
	ldmeqia sp!, {r4, r5, pc}
	ldrb r1, [r5, #0xd12]
	mov r2, #0
	cmp r1, #0
	bls _02087EC8
_02087EA8:
	add r0, r5, r2, lsl #2
	ldrb r0, [r0, #0x444]
	cmp r0, #0
	beq _02087EC8
	add r0, r2, #1
	and r2, r0, #0xff
	cmp r2, r1
	blo _02087EA8
_02087EC8:
	cmp r4, #6
	bne _02087F00
	cmp r1, r2
	bne _02087F38
	cmp r2, #0
	bne _02087EEC
	mov r0, #5
	bl DWCi_AC_SetError
	b _02087EF4
_02087EEC:
	mov r0, #6
	bl DWCi_AC_SetError
_02087EF4:
	add sp, sp, #4
	mov r0, #0x11
	ldmia sp!, {r4, r5, pc}
_02087F00:
	cmp r1, #0
	addeq sp, sp, #4
	moveq r0, r4
	ldmeqia sp!, {r4, r5, pc}
	cmp r1, r2
	addeq sp, sp, #4
	moveq r0, r4
	ldmeqia sp!, {r4, r5, pc}
	add r0, r5, r2, lsl #2
	ldrb r0, [r0, #0x446]
	cmp r0, #0x14
	addlo sp, sp, #4
	movlo r0, r4
	ldmloia sp!, {r4, r5, pc}
_02087F38:
	strb r2, [r5, #0xd13]
	bl WCM_EndSearchAsync
	cmp r0, #1
	strneb r4, [r5, #0xd0e]
	movne r4, #7
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_2087E78

	arm_func_start sub_2087F58
sub_2087F58: // 0x02087F58
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r5, r0
	cmp r4, #3
	beq _02087F84
	cmp r4, #4
	beq _02087FE8
	cmp r4, #5
	beq _02087FF4
	b _02088014
_02087F84:
	ldrb r1, [r5, #0xd12]
	cmp r1, #0
	bne _02087FA0
	add r1, r5, #0xd00
	ldrh r1, [r1, #0x16]
	cmp r1, #0
	beq _02087FC4
_02087FA0:
	mov r0, #1
	bl sub_2087C6C
	cmp r0, #0
	movne r4, #4
	bne _02088014
	mov r0, r5
	bl sub_2087E18
	mov r4, r0
	b _02088014
_02087FC4:
	ldrb r1, [r5, #0xd0b]
	mov r1, r1, lsl #0x18
	mov r1, r1, lsr #0x1c
	cmp r1, #1
	movhs r4, #6
	bhs _02088014
	bl sub_2088288
	mov r4, r0
	b _02088014
_02087FE8:
	bl sub_2087E18
	mov r4, r0
	b _02088014
_02087FF4:
	ldrb r1, [r5, #0xd0b]
	mov r1, r1, lsl #0x18
	mov r1, r1, lsr #0x1c
	cmp r1, #1
	movhs r4, #6
	bhs _02088014
	bl sub_2088288
	mov r4, r0
_02088014:
	mov r0, r4
	bl sub_20883C4
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_2087F58

	arm_func_start sub_2088028
sub_2088028: // 0x02088028
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_GetTick
	ldr r3, [r4, #0xcb0]
	ldr r2, [r4, #0xcb4]
	subs r3, r0, r3
	sbc r0, r1, r2
	mov r1, r0, lsl #6
	ldr r2, _02088140 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	cmp r1, #0
	cmpeq r0, #0x96
	bhs _02088088
	ldrb r1, [r4, #0xd0f]
	mov r0, #0x24
	mla r0, r1, r0, r4
	ldrb r0, [r0, #0x300]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	cmp r0, #1
	bne _02088138
_02088088:
	ldrb r1, [r4, #0xd0f]
	mov r0, #0x24
	add r3, r4, #0x300
	mul r2, r1, r0
	ldrb r0, [r3, r2]
	bic r0, r0, #0xf
	strb r0, [r3, r2]
	ldrb r0, [r4, #0xd0f]
	add r0, r0, #1
	strb r0, [r4, #0xd0f]
	ldrb r1, [r4, #0xd10]
	ldrb r0, [r4, #0xd0f]
	cmp r1, r0
	bhi _020880E0
	ldrb r1, [r4, #0xd15]
	mov r0, #0
	add r1, r1, #1
	strb r1, [r4, #0xd15]
	strb r0, [r4, #0xd0f]
	ldrb r0, [r4, #0xd15]
	bl sub_20884C0
	strb r0, [r4, #0xd11]
_020880E0:
	add r0, r4, #0xd00
	ldrsb r0, [r0, #0x11]
	cmp r0, #0
	bge _02088108
	mov r2, #0
	mov r0, r4
	mov r1, #5
	strb r2, [r4, #0xd15]
	bl sub_2087F58
	ldmia sp!, {r4, pc}
_02088108:
	bl OS_GetTick
	str r0, [r4, #0xcb0]
	str r1, [r4, #0xcb4]
	ldrb r3, [r4, #0xd0f]
	add r1, r4, #0x304
	mov r0, #0x24
	add r2, r4, #0xd00
	mla r1, r3, r0, r1
	ldrsb r2, [r2, #0x11]
	ldr r0, _02088144 // =0x0211279C
	mov r3, #0x300000
	bl sub_2087DEC
_02088138:
	mov r0, #5
	ldmia sp!, {r4, pc}
	.align 2, 0
_02088140: .word 0x000082EA
_02088144: .word 0x0211279C
	arm_func_end sub_2088028

	arm_func_start sub_2088148
sub_2088148: // 0x02088148
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_GetTick
	ldr r3, [r4, #0xcb0]
	ldr r2, [r4, #0xcb4]
	subs r3, r0, r3
	sbc r0, r1, r2
	mov r1, r0, lsl #6
	ldr r2, _02088274 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	cmp r1, #0
	cmpeq r0, #0x96
	bhs _020881A4
	ldrb r0, [r4, #0xd0f]
	add r0, r4, r0, lsl #2
	ldrb r0, [r0, #0x447]
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0208826C
_020881A4:
	ldr r0, _02088278 // =0x00000447
	ldrb r1, [r4, #0xd0f]
	add r2, r4, r0
	ldrb r0, [r2, r1, lsl #2]
	orr r0, r0, #0x80
	strb r0, [r2, r1, lsl #2]
	ldrb r2, [r4, #0xd12]
	ldrb r3, [r4, #0xd0f]
	cmp r3, r2
	bhs _02088204
	ldr r0, _0208827C // =0x00000D0F
	add r1, r4, r0
_020881D4:
	add r0, r4, r3, lsl #2
	ldrb r0, [r0, #0x447]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _02088204
	ldrb r0, [r1, #0]
	add r0, r0, #1
	strb r0, [r1]
	ldrb r2, [r4, #0xd12]
	ldrb r3, [r4, #0xd0f]
	cmp r3, r2
	blo _020881D4
_02088204:
	cmp r2, r3
	bhi _02088224
	mov r2, #0
	mov r0, r4
	mov r1, #4
	strb r2, [r4, #0xd0f]
	bl sub_2087F58
	ldmia sp!, {r4, pc}
_02088224:
	bl OS_GetTick
	str r0, [r4, #0xcb0]
	str r1, [r4, #0xcb4]
	ldrb r2, [r4, #0xd0f]
	mov r0, #0xc0
	ldr r1, _02088280 // =0x00000474
	mul ip, r2, r0
	add r0, r4, ip
	add r0, r0, #0x400
	ldrh r2, [r0, #0xa6]
	ldr r0, _02088284 // =0x0000047C
	add r3, r4, r1
	add r1, r4, r0
	add r0, r3, ip
	add r1, r1, ip
	sub r2, r2, #1
	mov r3, #0x300000
	bl sub_2087DEC
_0208826C:
	mov r0, #4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02088274: .word 0x000082EA
_02088278: .word 0x00000447
_0208827C: .word 0x00000D0F
_02088280: .word 0x00000474
_02088284: .word 0x0000047C
	arm_func_end sub_2088148

	arm_func_start sub_2088288
sub_2088288: // 0x02088288
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	strb r0, [r4, #0xd15]
	ldrb r2, [r4, #0xd0b]
	mov r1, r2, lsl #0x18
	mov r1, r1, lsr #0x1c
	add r1, r1, #1
	and r1, r1, #0xff
	bic r2, r2, #0xf0
	and r1, r1, #0xf
	orr r1, r2, r1, lsl #4
	strb r1, [r4, #0xd0b]
	bl sub_2087C6C
	mov r0, #1
	strb r0, [r4, #0xd11]
	mov r0, #3
	ldmia sp!, {r4, pc}
	arm_func_end sub_2088288

	arm_func_start sub_20882D0
sub_20882D0: // 0x020882D0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_GetTick
	ldr r3, [r4, #0xcb0]
	ldr r2, [r4, #0xcb4]
	subs r3, r0, r3
	sbc r0, r1, r2
	mov r1, r0, lsl #6
	ldr r2, _02088368 // =0x000082EA
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	cmp r1, #0
	cmpeq r0, #0x12c
	blo _02088360
	add r0, r4, #0xd00
	ldrsb r1, [r0, #0x11]
	add r1, r1, #2
	strb r1, [r4, #0xd11]
	ldrsb r0, [r0, #0x11]
	cmp r0, #0xd
	blt _0208833C
	mov r0, r4
	mov r1, #3
	bl sub_2087F58
	ldmia sp!, {r4, pc}
_0208833C:
	bl OS_GetTick
	str r0, [r4, #0xcb0]
	str r1, [r4, #0xcb4]
	add r0, r4, #0xd00
	ldrsb r2, [r0, #0x11]
	ldr r0, _0208836C // =0x0211279C
	ldr r1, _02088370 // =0x021127A4
	mov r3, #0x200000
	bl sub_2087DEC
_02088360:
	mov r0, #3
	ldmia sp!, {r4, pc}
	.align 2, 0
_02088368: .word 0x000082EA
_0208836C: .word 0x0211279C
_02088370: .word 0x021127A4
	arm_func_end sub_20882D0

	arm_func_start sub_2088374
sub_2088374: // 0x02088374
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_GetTick
	str r0, [r4, #0xcb0]
	str r1, [r4, #0xcb4]
	mov r0, #0
	strb r0, [r4, #0xd11]
	bl OS_GetTick
	str r0, [r4, #0xcb0]
	str r1, [r4, #0xcb4]
	add r0, r4, #0xd00
	ldrsb r2, [r0, #0x11]
	ldr r0, _020883BC // =0x0211279C
	ldr r1, _020883C0 // =0x021127A4
	mov r3, #0x200000
	bl sub_2087DEC
	mov r0, #3
	ldmia sp!, {r4, pc}
	.align 2, 0
_020883BC: .word 0x0211279C
_020883C0: .word 0x021127A4
	arm_func_end sub_2088374

	arm_func_start sub_20883C4
sub_20883C4: // 0x020883C4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	cmp r5, #3
	beq _020883FC
	cmp r5, #4
	beq _02088428
	cmp r5, #5
	beq _02088478
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020883FC:
	bl OS_GetTick
	str r0, [r4, #0xcb0]
	str r1, [r4, #0xcb4]
	add r0, r4, #0xd00
	ldrsb r2, [r0, #0x11]
	ldr r0, _020884B0 // =0x0211279C
	ldr r1, _020884B4 // =0x021127A4
	mov r3, #0x200000
	bl sub_2087DEC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02088428:
	bl OS_GetTick
	str r0, [r4, #0xcb0]
	str r1, [r4, #0xcb4]
	ldrb r2, [r4, #0xd0f]
	mov r0, #0xc0
	ldr r1, _020884B8 // =0x00000474
	mul ip, r2, r0
	add r0, r4, ip
	add r0, r0, #0x400
	ldrh r2, [r0, #0xa6]
	ldr r0, _020884BC // =0x0000047C
	add r3, r4, r1
	add r1, r4, r0
	add r0, r3, ip
	add r1, r1, ip
	sub r2, r2, #1
	mov r3, #0x300000
	bl sub_2087DEC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_02088478:
	bl OS_GetTick
	str r0, [r4, #0xcb0]
	str r1, [r4, #0xcb4]
	ldrb r3, [r4, #0xd0f]
	add r1, r4, #0x304
	mov r0, #0x24
	add r2, r4, #0xd00
	mla r1, r3, r0, r1
	ldrsb r2, [r2, #0x11]
	ldr r0, _020884B0 // =0x0211279C
	mov r3, #0x300000
	bl sub_2087DEC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020884B0: .word 0x0211279C
_020884B4: .word 0x021127A4
_020884B8: .word 0x00000474
_020884BC: .word 0x0000047C
	arm_func_end sub_20883C4

	arm_func_start sub_20884C0
sub_20884C0: // 0x020884C0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	add r0, r0, #0xd00
	ldrh r2, [r0, #0x16]
	cmp r2, #0
	mvneq r0, #0
	ldmeqia sp!, {r4, pc}
	mov ip, #0
	mov r3, ip
	mov r1, #1
_020884F0:
	mov r0, r1, lsl ip
	ands r0, r2, r0
	beq _02088514
	cmp r3, r4
	moveq r0, ip, lsl #0x18
	moveq r0, r0, asr #0x18
	ldmeqia sp!, {r4, pc}
	add r0, r3, #1
	and r3, r0, #0xff
_02088514:
	add r0, ip, #1
	and ip, r0, #0xff
	cmp ip, #0xd
	blo _020884F0
	mvn r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end sub_20884C0

	arm_func_start sub_208852C
sub_208852C: // 0x0208852C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	add r0, r0, #0xd00
	cmp r4, #0xd
	movhi r4, #0xd
	ldrh r3, [r0, #0x16]
	sub r1, r4, #1
	mov r2, #1
	orr r1, r3, r2, lsl r1
	strh r1, [r0, #0x16]
	ldmia sp!, {r4, pc}
	arm_func_end sub_208852C

	arm_func_start sub_2088560
sub_2088560: // 0x02088560
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	mov r5, r0
	bl DWCi_AC_GetPhase
	mov r4, r0
	bl WCM_GetPhase
	cmp r4, #2
	bne _020885A0
	cmp r0, #3
	bne _020885A0
	mov r0, r5
	bl sub_2088374
	mov r4, r0
	b _02088628
_020885A0:
	cmp r4, #6
	bne _020885BC
	mov r0, r5
	mov r1, r4
	bl sub_2087E78
	mov r4, r0
	b _02088628
_020885BC:
	cmp r0, #3
	beq _020885CC
	cmp r0, #6
	bne _02088628
_020885CC:
	mov r0, r5
	mov r1, r4
	bl sub_2087E78
	mov r4, r0
	cmp r4, #7
	beq _02088628
	cmp r4, #3
	bne _020885FC
	mov r0, r5
	bl sub_20882D0
	mov r4, r0
	b _02088628
_020885FC:
	cmp r4, #4
	bne _02088614
	mov r0, r5
	bl sub_2088148
	mov r4, r0
	b _02088628
_02088614:
	cmp r4, #5
	bne _02088628
	mov r0, r5
	bl sub_2088028
	mov r4, r0
_02088628:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_2088560

	arm_func_start sub_2088634
sub_2088634: // 0x02088634
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	bl WCM_GetPhase
	mov r4, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	cmp r4, #1
	bne _020886A0
	ldrb r1, [r0, #0xd0a]
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	bl sub_2087C6C
	ldr r1, _020886B8 // =sub_2086F3C
	add r0, sp, #0
	bl WCM_StartupAsync
	cmp r0, #1
	beq _0208868C
	cmp r0, #4
	blt _020886AC
_0208868C:
	mov r0, #1
	bl DWCi_AC_SetError
	add sp, sp, #0x10
	mov r0, #0x11
	ldmia sp!, {r4, pc}
_020886A0:
	add sp, sp, #0x10
	mov r0, #1
	ldmia sp!, {r4, pc}
_020886AC:
	mov r0, #2
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_020886B8: .word sub_2086F3C
	arm_func_end sub_2088634

	arm_func_start sub_20886BC
sub_20886BC: // 0x020886BC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldrb r0, [r4, #0xd0d]
	cmp r0, #6
	addhs sp, sp, #8
	ldmhsia sp!, {r4, pc}
	bl DWCi_ConvConnectAPType
	add r4, r4, r0, lsl #8
	ldrb r0, [r4, #0xc0]
	ldrb r2, [r4, #0xc8]
	ldrb r1, [r4, #0xc9]
	cmp r0, #0
	ldrb r3, [r4, #0xca]
	add r1, r2, r1
	ldrb r2, [r4, #0xcb]
	add r1, r3, r1
	addne sp, sp, #8
	add r0, r2, r1
	ldmneia sp!, {r4, pc}
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0xc8
	bl sub_2088798
	str r0, [sp]
	add r0, r4, #0xcc
	bl sub_2088798
	str r0, [sp, #4]
	add r0, sp, #0
	add r1, sp, #4
	bl sub_20BE6EC
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end sub_20886BC

	arm_func_start sub_2088744
sub_2088744: // 0x02088744
	rsb r0, r0, #0x20
	cmp r0, #0
	mvn r3, #0
	mov r1, #0
	ble _02088768
_02088758:
	add r1, r1, #1
	cmp r1, r0
	mov r3, r3, lsl #1
	blt _02088758
_02088768:
	mov r1, r3, lsr #0x18
	mov r0, r3, lsr #8
	mov r2, r3, lsl #8
	mov r3, r3, lsl #0x18
	and r1, r1, #0xff
	and r0, r0, #0xff00
	and r2, r2, #0xff0000
	orr r0, r1, r0
	and r1, r3, #0xff000000
	orr r0, r2, r0
	orr r0, r1, r0
	bx lr
	arm_func_end sub_2088744

	arm_func_start sub_2088798
sub_2088798: // 0x02088798
	ldrb r1, [r0, #0]
	ldrb r2, [r0, #1]
	mov r3, #0
	orr r3, r3, r1, lsl #24
	ldrb r1, [r0, #2]
	orr r2, r3, r2, lsl #16
	ldrb r0, [r0, #3]
	orr r1, r2, r1, lsl #8
	orr r3, r1, r0
	mov r1, r3, lsr #0x18
	mov r0, r3, lsr #8
	mov r2, r3, lsl #8
	mov r3, r3, lsl #0x18
	and r1, r1, #0xff
	and r0, r0, #0xff00
	and r2, r2, #0xff0000
	orr r0, r1, r0
	and r1, r3, #0xff000000
	orr r0, r2, r0
	orr r0, r1, r0
	bx lr
	arm_func_end sub_2088798

	arm_func_start sub_20887EC
sub_20887EC: // 0x020887EC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r4, r2
	mov r5, r1
	ldr r0, _020888A8 // =0x02112588
	mov r1, r4
	mov r2, #0x58
	bl MI_CpuCopy8
	ldr r0, [r6, #0]
	str r0, [r4, #4]
	ldr r0, [r6, #4]
	str r0, [r4, #8]
	ldrb r0, [r5, #0xd0d]
	cmp r0, #6
	ldmhsia sp!, {r4, r5, r6, pc}
	bl DWCi_ConvConnectAPType
	add r5, r5, r0, lsl #8
	ldrb r0, [r5, #0xc0]
	cmp r0, #0
	beq _02088884
	mov r0, #0
	str r0, [r4, #0xc]
	add r0, r5, #0xc0
	bl sub_2088798
	str r0, [r4, #0x10]
	ldrb r0, [r5, #0xd0]
	bl sub_2088744
	str r0, [r4, #0x14]
	add r0, r5, #0xc4
	bl sub_2088798
	str r0, [r4, #0x18]
	add r0, r5, #0xc8
	bl sub_2088798
	str r0, [r4, #0x1c]
	add r0, r5, #0xcc
	bl sub_2088798
	str r0, [r4, #0x20]
	ldmia sp!, {r4, r5, r6, pc}
_02088884:
	mov r0, #1
	str r0, [r4, #0xc]
	mov r0, #0
	str r0, [r4, #0x10]
	str r0, [r4, #0x14]
	str r0, [r4, #0x18]
	str r0, [r4, #0x1c]
	str r0, [r4, #0x20]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020888A8: .word 0x02112588
	arm_func_end sub_20887EC

	arm_func_start sub_20888AC
sub_20888AC: // 0x020888AC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20BDBEC
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0xb
	ldmneia sp!, {pc}
	bl sub_20BE40C
	cmp r0, #0
	beq _020888E0
	mvn r1, #0x26
	cmp r0, r1
	bne _020888EC
_020888E0:
	add sp, sp, #4
	mov r0, #9
	ldmia sp!, {pc}
_020888EC:
	mov r0, #0xb
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20888AC

	arm_func_start sub_20888F8
sub_20888F8: // 0x020888F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrb r0, [r0, #0xd0d]
	bl DWCi_AC_SetApType
	mov r0, #0x10
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20888F8

	arm_func_start sub_2088914
sub_2088914: // 0x02088914
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #1
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	bl sub_208CC4C
	movs r5, r0
	beq _02088978
	ldrb r0, [r6, #0xd0d]
	bl DWCi_ConvConnectAPType
	ldrb r1, [r4, #0x15]
	cmp r1, r0
	bne _02088950
	bl sub_208CC34
	str r0, [r4, #0x10]
_02088950:
	bl sub_208CD10
	cmp r5, #0xb
	moveq r0, #0xf
	ldmeqia sp!, {r4, r5, r6, pc}
	ldrb r1, [r6, #0xd13]
	mov r2, #1
	mov r0, #0xb
	add r1, r6, r1, lsl #2
	strb r2, [r1, #0x444]
	ldmia sp!, {r4, r5, r6, pc}
_02088978:
	mov r0, #0xe
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_2088914

	arm_func_start sub_2088980
sub_2088980: // 0x02088980
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #8
	bl DWCi_AC_GetMemPtr
	bl sub_208CE10
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0xe
	ldmeqia sp!, {pc}
	mov r0, #3
	bl DWCi_AC_SetError
	mov r0, #0x11
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_2088980

	arm_func_start sub_20889B8
sub_20889B8: // 0x020889B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SO_GetHostID
	cmp r0, #0
	beq _020889F0
	mov r0, r4
	bl sub_20886BC
	ldrb r0, [r4, #0xd0c]
	mov r0, r0, lsl #0x1a
	mov r0, r0, lsr #0x1e
	cmp r0, #1
	moveq r0, #0xf
	movne r0, #0xd
	ldmia sp!, {r4, pc}
_020889F0:
	bl OS_GetTick
	ldr r3, [r4, #0xcb0]
	ldr r2, [r4, #0xcb4]
	subs r3, r0, r3
	sbc r0, r1, r2
	mov r1, r0, lsl #6
	ldr r2, _02088A44 // =0x01FF6210
	orr r1, r1, r3, lsr #26
	mov r0, r3, lsl #6
	mov r3, #0
	bl _ll_udiv
	cmp r1, #0
	cmpeq r0, #0xa
	movlo r0, #0xc
	ldmloia sp!, {r4, pc}
	ldrb r1, [r4, #0xd13]
	mov r2, #1
	mov r0, #0xb
	add r1, r4, r1, lsl #2
	strb r2, [r1, #0x444]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02088A44: .word 0x01FF6210
	arm_func_end sub_20889B8

	arm_func_start sub_2088A48
sub_2088A48: // 0x02088A48
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #1
	bl DWCi_AC_GetMemPtr
	mov r5, r0
	mov r0, #4
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	mov r0, r5
	mov r1, r6
	mov r2, r4
	bl sub_20887EC
	ldr r1, _02088AA8 // =0x0214563C
	mov r2, #4
	mov r0, r4
	str r2, [r1]
	bl sub_20BE418
	cmp r0, #0
	moveq r0, #0xc
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, #2
	bl DWCi_AC_SetError
	mov r0, #0x11
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02088AA8: .word 0x0214563C
	arm_func_end sub_2088A48

	arm_func_start sub_2088AAC
sub_2088AAC: // 0x02088AAC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl DWCi_AC_GetPhase
	mov r5, r0
	mov r0, #0x10
	bl DWCi_AC_GetMemPtr
	mov r4, r0
	bl WCM_GetPhase
	cmp r0, #9
	bne _02088B54
	sub r0, r5, #0xa
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02088BA4
_02088AE4: // jump table
	b _02088AFC // case 0
	b _02088B48 // case 1
	b _02088B0C // case 2
	b _02088B1C // case 3
	b _02088B28 // case 4
	b _02088B38 // case 5
_02088AFC:
	mov r0, r4
	bl sub_2088A48
	mov r5, r0
	b _02088BA4
_02088B0C:
	mov r0, r4
	bl sub_20889B8
	mov r5, r0
	b _02088BA4
_02088B1C:
	bl sub_2088980
	mov r5, r0
	b _02088BA4
_02088B28:
	mov r0, r4
	bl sub_2088914
	mov r5, r0
	b _02088BA4
_02088B38:
	mov r0, r4
	bl sub_20888F8
	mov r5, r0
	b _02088BA4
_02088B48:
	bl sub_20888AC
	mov r5, r0
	b _02088BA4
_02088B54:
	cmp r5, #0xb
	beq _02088B7C
	cmp r5, #0xe
	beq _02088B88
	cmp r5, #0xf
	bne _02088B90
	mov r0, r4
	bl sub_20888F8
	mov r5, r0
	b _02088BA4
_02088B7C:
	bl sub_20888AC
	mov r5, r0
	b _02088BA4
_02088B88:
	bl sub_208CC90
	bl sub_208CD10
_02088B90:
	ldrb r0, [r4, #0xd13]
	mov r1, #2
	mov r5, #0xb
	add r0, r4, r0, lsl #2
	strb r1, [r0, #0x444]
_02088BA4:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_2088AAC

	arm_func_start sub_2088BB0
sub_2088BB0: // 0x02088BB0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r4, #3
	mul r4, r2, r4
	mov r4, r4, lsr #2
	mov r10, r0
	mov r0, r4
	cmp r3, r0
	andhs r11, r2, #3
	subhs r0, r2, r11
	str r4, [sp, #4]
	mov r9, r1
	strhs r0, [sp]
	bhs _02088BF4
	add sp, sp, #0x1c
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02088BF4:
	cmp r0, #0
	mov r7, #0
	ble _02088C80
	mov r5, r7
	add r4, sp, #0x10
	str r7, [sp, #0xc]
	str r7, [sp, #8]
_02088C10:
	ldr r8, [sp, #8]
	mov r6, r8
_02088C18:
	add r0, r7, r6
	ldrb r0, [r10, r0]
	bl sub_2088D24
	rsb r2, r6, #3
	mov r1, #6
	mul r1, r2, r1
	orr r8, r8, r0, lsl r1
	add r6, r6, #1
	cmp r6, #4
	blt _02088C18
	mov r0, #3
	mul r1, r5, r0
	ldr r2, [sp, #0xc]
	str r8, [sp, #0x10]
_02088C50:
	rsb r0, r2, #2
	ldrb r0, [r4, r0]
	add r2, r2, #1
	cmp r2, #3
	strb r0, [r9, r1]
	add r1, r1, #1
	blt _02088C50
	ldr r0, [sp]
	add r7, r7, #4
	cmp r7, r0
	add r5, r5, #1
	blt _02088C10
_02088C80:
	cmp r11, #0
	beq _02088D18
	mov r5, #0
	mov r4, r5
	str r5, [sp, #0x14]
	cmp r11, #0
	ble _02088CD4
	mov r6, #6
_02088CA0:
	ldr r0, [sp]
	add r0, r0, r4
	ldrb r0, [r10, r0]
	bl sub_2088D24
	rsb r1, r4, #3
	mul r2, r1, r6
	orr r5, r5, r0, lsl r2
	ldr r0, [sp, #0x14]
	add r4, r4, #1
	orr r0, r0, r5
	cmp r4, r11
	str r0, [sp, #0x14]
	blt _02088CA0
_02088CD4:
	cmp r11, #0
	mov r2, #0
	ble _02088D18
	ldr r0, [sp]
	mov r1, #3
	mul r1, r0, r1
	mov r0, r1, asr #1
	add r0, r1, r0, lsr #30
	mov r3, r0, asr #2
	add r1, sp, #0x14
_02088CFC:
	rsb r0, r2, #2
	ldrb r0, [r1, r0]
	add r2, r2, #1
	cmp r2, r11
	strb r0, [r9, r3]
	add r3, r3, #1
	blt _02088CFC
_02088D18:
	ldr r0, [sp, #4]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end sub_2088BB0

	arm_func_start sub_2088D24
sub_2088D24: // 0x02088D24
	cmp r0, #0x41
	blo _02088D38
	cmp r0, #0x5a
	subls r0, r0, #0x41
	bxls lr
_02088D38:
	cmp r0, #0x61
	blo _02088D50
	cmp r0, #0x7a
	subls r0, r0, #0x61
	addls r0, r0, #0x1a
	bxls lr
_02088D50:
	cmp r0, #0x30
	blo _02088D68
	cmp r0, #0x39
	subls r0, r0, #0x30
	addls r0, r0, #0x34
	bxls lr
_02088D68:
	cmp r0, #0x2b
	moveq r0, #0x3e
	bxeq lr
	cmp r0, #0x2f
	moveq r0, #0x3f
	bxeq lr
	cmp r0, #0x3d
	movne r0, #1
	moveq r0, #0
	rsb r0, r0, #0
	bx lr
	arm_func_end sub_2088D24

	arm_func_start sub_2088D94
sub_2088D94: // 0x02088D94
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, r1
	mov r1, #0
	ldr lr, _02088F44 // =0x92492493
	ldr ip, _02088F48 // =0x00000007
_02088DAC:
	smull r2, r3, lr, r1
	add r3, r1, r3
	mov r3, r3, asr #2
	mov r2, r1, lsr #0x1f
	add r3, r2, r3
	smull r2, r3, ip, r3
	sub r3, r1, r2
	add r2, r3, #0xd
	ldrb r3, [r0, r1]
	ldrb r2, [r0, r2]
	eor r2, r3, r2
	strb r2, [r4, r1]
	add r1, r1, #1
	cmp r1, #0xd
	blt _02088DAC
	mov ip, #0
_02088DEC:
	add r3, ip, #3
	add r1, ip, #0xd
	ldrb r2, [r4, r3]
	ldrb r1, [r0, r1]
	add ip, ip, #1
	cmp ip, #7
	eor r1, r2, r1
	strb r1, [r4, r3]
	blt _02088DEC
	ldr r0, _02088F4C // =_0211ADC8
	mov r3, #0
_02088E18:
	ldr r1, [r0, #0]
	ldrb r2, [r4, r3]
	ldrsb r1, [r1, r3]
	eor r1, r2, r1
	strb r1, [r4, r3]
	add r3, r3, #1
	cmp r3, #0xd
	blt _02088E18
	add r1, sp, #0
	mov r0, r4
	mov r2, #0xd
	bl MI_CpuCopy8
	ldr r3, _02088F50 // =0x021125E0
	add ip, sp, #0
	mov r2, #0
_02088E54:
	ldrb r1, [ip]
	ldrb r0, [r3, #0]
	add r2, r2, #1
	cmp r2, #0xd
	strb r1, [r4, r0]
	add ip, ip, #1
	add r3, r3, #1
	blt _02088E54
	ldr r0, _02088F54 // =_0211ADCC
	mov r3, #0
_02088E7C:
	ldr r1, [r0, #0]
	ldrb r2, [r4, r3]
	ldrsb r1, [r1, r3]
	eor r1, r2, r1
	strb r1, [r4, r3]
	add r3, r3, #1
	cmp r3, #0xd
	blt _02088E7C
	ldr r2, _02088F58 // =0x021125F0
	mov ip, #0
_02088EA4:
	ldrb r3, [r4, ip]
	mov r0, r3, asr #4
	and r1, r0, #0xf
	and r0, r3, #0xf
	ldrb r1, [r2, r1]
	ldrb r0, [r2, r0]
	orr r0, r0, r1, lsl #4
	strb r0, [r4, ip]
	add ip, ip, #1
	cmp ip, #0xd
	blt _02088EA4
	mov r0, #0
_02088ED4:
	add lr, r0, #6
	ldrb r2, [r4, r0]
	ldrb r1, [r4, lr]
	add ip, r0, #9
	add r3, r0, #3
	eor r1, r2, r1
	strb r1, [r4, r0]
	ldrb r2, [r4, r3]
	ldrb r1, [r4, ip]
	eor r1, r2, r1
	strb r1, [r4, r3]
	ldrb r2, [r4, lr]
	ldrb r1, [r4, r3]
	eor r1, r2, r1
	strb r1, [r4, lr]
	ldrb r2, [r4, ip]
	ldrb r1, [r4, r0]
	eor r1, r2, r1
	strb r1, [r4, ip]
	ldrb r1, [r4, r0]
	ldrb r2, [r4, #0xc]
	add r0, r0, #1
	cmp r0, #3
	eor r1, r2, r1
	strb r1, [r4, #0xc]
	blt _02088ED4
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_02088F44: .word 0x92492493
_02088F48: .word 0x00000007
_02088F4C: .word _0211ADC8
_02088F50: .word 0x021125E0
_02088F54: .word _0211ADCC
_02088F58: .word 0x021125F0
	arm_func_end sub_2088D94

	arm_func_start sub_2088F5C
sub_2088F5C: // 0x02088F5C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x6c
	mov r5, r0
	add r0, sp, #0x14
	mov r4, r1
	bl DGT_Hash1Reset
	add r0, sp, #0x14
	mov r1, r5
	mov r2, #0x18
	bl DGT_Hash1SetSource
	add r0, sp, #0
	add r1, sp, #0x14
	bl DGT_Hash1GetDigest_R
	add r0, sp, #3
	mov r1, r4
	mov r2, #0xd
	bl MI_CpuCopy8
	add sp, sp, #0x6c
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_2088F5C

	arm_func_start sub_2088FA8
sub_2088FA8: // 0x02088FA8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	ldr lr, _0208909C // =0x02112600
	add ip, sp, #0
	mov r4, r1
	mov r3, #0xc
_02088FC0:
	ldrb r2, [lr], #1
	ldrb r1, [lr], #1
	subs r3, r3, #1
	strb r2, [ip], #1
	strb r1, [ip], #1
	bne _02088FC0
	mov r1, r4
	mov r2, #0x20
	mov r3, #0x18
	bl sub_2088BB0
	mov r3, #0
	ldr r0, _020890A0 // =_0211ADD0
_02088FF0:
	ldr r1, [r0, #0]
	ldrb r2, [r4, r3]
	ldrsb r1, [r1, r3]
	eor r1, r2, r1
	strb r1, [r4, r3]
	add r3, r3, #1
	cmp r3, #0x18
	blt _02088FF0
	mov lr, #0
	add ip, sp, #0
	mov r1, #0xff
_0208901C:
	and r7, lr, #0xff
	ldrb r0, [ip, r7]
	mov r6, r7
	ldrb r5, [r4, lr]
	cmp r0, #0xff
	beq _02089060
_02089034:
	add r3, ip, r6
	ldrb r6, [ip, r6]
	ldrb r0, [ip, r7]
	ldrb r2, [r4, r6]
	mov r7, r6
	strb r5, [r4, r0]
	strb r1, [r3]
	ldrb r0, [ip, r6]
	mov r5, r2
	cmp r0, #0xff
	bne _02089034
_02089060:
	add lr, lr, #1
	cmp lr, #0x18
	blt _0208901C
	ldr r0, _020890A4 // =_0211ADC4
	mov r3, #0
_02089074:
	ldr r1, [r0, #0]
	ldrb r2, [r4, r3]
	ldrsb r1, [r1, r3]
	eor r1, r2, r1
	strb r1, [r4, r3]
	add r3, r3, #1
	cmp r3, #0x18
	blt _02089074
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0208909C: .word 0x02112600
_020890A0: .word _0211ADD0
_020890A4: .word _0211ADC4
	arm_func_end sub_2088FA8

	arm_func_start sub_20890A8
sub_20890A8: // 0x020890A8
	ldr ip, _020890B4 // =sub_2088D94
	add r0, r0, #0xc
	bx ip
	.align 2, 0
_020890B4: .word sub_2088D94
	arm_func_end sub_20890A8

	arm_func_start sub_20890B8
sub_20890B8: // 0x020890B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020890E0 // =aNwcusbap_0
	mov r2, #8
	bl memcmp
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020890E0: .word aNwcusbap_0
	arm_func_end sub_20890B8

	arm_func_start sub_20890E4
sub_20890E4: // 0x020890E4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r1
	add r1, sp, #0
	bl sub_2088FA8
	ldr r1, _0208912C // =aNdwcshap
	add r0, sp, #0
	mov r2, #8
	bl memcmp
	cmp r0, #0
	addne sp, sp, #0x18
	ldmneia sp!, {r4, pc}
	add r0, sp, #8
	mov r1, r4
	mov r2, #0xa
	bl MI_CpuCopy8
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208912C: .word aNdwcshap
	arm_func_end sub_20890E4

	arm_func_start sub_2089130
sub_2089130: // 0x02089130
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r1
	add r1, sp, #0
	bl sub_2088FA8
	add r0, sp, #0
	mov r1, r4
	bl sub_2088F5C
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	arm_func_end sub_2089130

	arm_func_start sub_2089158
sub_2089158: // 0x02089158
	stmdb sp!, {lr}
	sub sp, sp, #0x1c
	add r1, sp, #0
	bl sub_2088FA8
	ldr r1, _0208918C // =aNdwcshap
	add r0, sp, #0
	mov r2, #8
	bl memcmp
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #0x1c
	ldmia sp!, {pc}
	.align 2, 0
_0208918C: .word aNdwcshap
	arm_func_end sub_2089158

	.rodata

aWayport2freesp: // 0x02112538
	.asciz "Wayport2FREESPOTNINTENDOWFC"
	.align 4
	
_02112554:
	.byte 0x02, 0x80, 0x00, 0x00, 0x04, 0x80, 0x00, 0x00, 0x08, 0x80, 0x00, 0x00
	.byte 0x10, 0x80, 0x00, 0x00, 0x20, 0x80, 0x00, 0x00, 0x40, 0x80, 0x00, 0x00, 0x80, 0x80, 0x00, 0x00
	.byte 0x00, 0x81, 0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x00, 0x84, 0x00, 0x00, 0x00, 0x88, 0x00, 0x00
	.byte 0x00, 0x90, 0x00, 0x00, 0x00, 0xA0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00
	.byte 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0xB8, 0xAD, 0x11, 0x02, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x05, 0x01, 0x0C, 0x04, 0x02, 0x03, 0x0A, 0x00, 0x0B, 0x07, 0x09, 0x08, 0x06, 0x00, 0x00, 0x00
	.byte 0x0A, 0x0D, 0x0E, 0x08, 0x09, 0x03, 0x06, 0x00, 0x0C, 0x05, 0x02, 0x07, 0x0B, 0x01, 0x0F, 0x04
	.byte 0x17, 0x14, 0x11, 0x0D, 0x0B, 0x06, 0x0F, 0x0E, 0x09, 0x15, 0x0C, 0x04, 0x02, 0x01, 0x12, 0x10
	.byte 0x05, 0x03, 0x13, 0x0A, 0x07, 0x08, 0x00, 0x16, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x00, 0x04
	.byte 0x03, 0x05, 0x06, 0x07, 0x05, 0x09, 0x01, 0x0E, 0x0C, 0x02, 0x0A, 0x00, 0x0B, 0x0D, 0x03, 0x04
	.byte 0x08, 0x06, 0x0F, 0x07, 0x03, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
	.byte 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00

	.data

aNwcusbap: // 0x0211ADAC
	.asciz "NWCUSBAP"
	.align 4

aNintendoDs: // 0x0211ADB8
	.asciz "NINTENDO-DS"
	.align 4

_0211ADC4: // _0211ADC4
    .word a38g6zxjk20gvmv
	
_0211ADC8: // _0211ADC8
    .word aGwi6Fs0nf
	
_0211ADCC: // _0211ADCC
    .word aEgerAgSM
	
_0211ADD0: // _0211ADD0
    .word a952uybjnpmu903

aGwi6Fs0nf: // 0x0211ADD4
	.asciz "gwi'6&fs=0Nf~"
	.align 4

aEgerAgSM: // 0x0211ADE4
	.asciz "%(egEr)ag(s&m"
	.align 4

a38g6zxjk20gvmv: // 0x0211ADF4
	.asciz "38g6zxjk20gvmv]6^=j&%vY1"
	.align 4

a952uybjnpmu903: // 0x0211AE10
	.asciz "952uybjnpmu903bia@bk5m[-"
	.align 4

aNwcusbap_0: // 0x0211AE2C
	.asciz "NWCUSBAP"
	.align 4

aNdwcshap: // 0x0211AE38
	.asciz "NDWCSHAP"
	.align 4
