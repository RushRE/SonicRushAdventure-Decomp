	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public _02147230
_02147230:
	.space 0x04
	
.public _02147234
_02147234:
	.space 0x0C // NNSFndList
	
.public NNS_G3dGlb
NNS_G3dGlb:
	.space 0x264
	
.public _021474A4
_021474A4:
	.space 0x2D10

	.text

arm_func_start NNS_FndGetNthListObject
NNS_FndGetNthListObject: // 0x020CCC24
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, #0
	mov r5, r1
	mov r1, r4
	mov r6, r0
	bl NNS_FndGetNextListObject
	movs r1, r0
	beq _020CCC64
_020CCC44:
	cmp r4, r5
	moveq r0, r1
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r6
	add r4, r4, #1
	bl NNS_FndGetNextListObject
	movs r1, r0
	bne _020CCC44
_020CCC64:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_FndGetNthListObject

	arm_func_start NNS_FndGetPrevListObject
NNS_FndGetPrevListObject: // 0x020CCC6C
	cmp r1, #0
	ldreq r0, [r0, #4]
	ldrneh r0, [r0, #0xa]
	ldrne r0, [r1, r0]
	bx lr
	arm_func_end NNS_FndGetPrevListObject

	arm_func_start NNS_FndGetNextListObject
NNS_FndGetNextListObject: // 0x020CCC80
	cmp r1, #0
	ldreq r0, [r0]
	ldrneh r0, [r0, #0xa]
	addne r0, r1, r0
	ldrne r0, [r0, #4]
	bx lr
	arm_func_end NNS_FndGetNextListObject

	arm_func_start NNS_FndRemoveListObject
NNS_FndRemoveListObject: // 0x020CCC98
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh ip, [r0, #0xa]
	ldr r3, [r1, ip]
	add lr, r1, ip
	cmp r3, #0
	ldreq r1, [lr, #4]
	streq r1, [r0]
	ldrne r2, [lr, #4]
	addne r1, r3, ip
	strne r2, [r1, #4]
	ldr r3, [lr, #4]
	cmp r3, #0
	ldreq r1, [lr]
	streq r1, [r0, #4]
	ldrneh r1, [r0, #0xa]
	ldrne r2, [lr]
	strne r2, [r3, r1]
	mov r1, #0
	str r1, [lr]
	str r1, [lr, #4]
	ldrh r1, [r0, #8]
	sub r1, r1, #1
	strh r1, [r0, #8]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_FndRemoveListObject

	arm_func_start NNS_FndInsertListObject
NNS_FndInsertListObject: // 0x020CCD00
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0
	bne _020CCD20
	mov r1, r2
	bl NNS_FndAppendListObject
	add sp, sp, #4
	ldmia sp!, {pc}
_020CCD20:
	ldr r3, [r0]
	cmp r1, r3
	bne _020CCD3C
	mov r1, r2
	bl NNS_FndPrependListObject
	add sp, sp, #4
	ldmia sp!, {pc}
_020CCD3C:
	ldrh lr, [r0, #0xa]
	ldr r3, [r1, lr]
	add ip, r2, lr
	str r3, [r2, lr]
	str r1, [ip, #4]
	add r3, r3, lr
	str r2, [r3, #4]
	ldrh r3, [r0, #0xa]
	str r2, [r1, r3]
	ldrh r1, [r0, #8]
	add r1, r1, #1
	strh r1, [r0, #8]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_FndInsertListObject

	arm_func_start NNS_FndPrependListObject
NNS_FndPrependListObject: // 0x020CCD74
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0]
	cmp r2, #0
	bne _020CCD94
	bl SetFirstObject
	add sp, sp, #4
	ldmia sp!, {pc}
_020CCD94:
	ldrh r3, [r0, #0xa]
	mov r2, #0
	str r2, [r1, r3]
	ldr r2, [r0]
	add r3, r1, r3
	str r2, [r3, #4]
	ldrh r2, [r0, #0xa]
	ldr r3, [r0]
	str r1, [r3, r2]
	str r1, [r0]
	ldrh r1, [r0, #8]
	add r1, r1, #1
	strh r1, [r0, #8]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_FndPrependListObject

	arm_func_start NNS_FndAppendListObject
NNS_FndAppendListObject: // 0x020CCDD0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0]
	cmp r2, #0
	bne _020CCDF0
	bl SetFirstObject
	add sp, sp, #4
	ldmia sp!, {pc}
_020CCDF0:
	ldrh ip, [r0, #0xa]
	ldr r3, [r0, #4]
	mov r2, #0
	str r3, [r1, ip]
	add r3, r1, ip
	str r2, [r3, #4]
	ldrh r2, [r0, #0xa]
	ldr r3, [r0, #4]
	add r2, r3, r2
	str r1, [r2, #4]
	str r1, [r0, #4]
	ldrh r1, [r0, #8]
	add r1, r1, #1
	strh r1, [r0, #8]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_FndAppendListObject

	arm_func_start SetFirstObject
SetFirstObject: // 0x020CCE30
	ldrh r3, [r0, #0xa]
	mov r2, #0
	add ip, r1, r3
	str r2, [ip, #4]
	str r2, [r1, r3]
	str r1, [r0]
	str r1, [r0, #4]
	ldrh r1, [r0, #8]
	add r1, r1, #1
	strh r1, [r0, #8]
	bx lr
	arm_func_end SetFirstObject

	arm_func_start NNS_FndInitList
NNS_FndInitList: // 0x020CCE5C
	mov r2, #0
	str r2, [r0]
	str r2, [r0, #4]
	strh r2, [r0, #8]
	strh r1, [r0, #0xa]
	bx lr
	arm_func_end NNS_FndInitList

	arm_func_start NNSi_FndFinalizeHeap
NNSi_FndFinalizeHeap: // 0x020CCE74
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FindListContainHeap
	mov r1, r4
	bl NNS_FndRemoveListObject
	ldmia sp!, {r4, pc}
	arm_func_end NNSi_FndFinalizeHeap

	arm_func_start NNSi_FndInitHeapHead
NNSi_FndInitHeapHead: // 0x020CCE8C
	stmdb sp!, {r4, lr}
	mov r4, r0
	str r1, [r4]
	str r2, [r4, #0x18]
	str r3, [r4, #0x1c]
	mov r0, #0
	str r0, [r4, #0x20]
	ldr r1, [r4, #0x20]
	ldrh r0, [sp, #8]
	bic r1, r1, #0xff
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x20]
	and r0, r0, #0xff
	orr r2, r1, r0
	add r0, r4, #0xc
	mov r1, #4
	str r2, [r4, #0x20]
	bl NNS_FndInitList
	ldr r0, _020CCF10 // =_02147230
	ldr r0, [r0]
	cmp r0, #0
	bne _020CCEFC
	ldr r0, _020CCF14 // =_02147234
	mov r1, #4
	bl NNS_FndInitList
	ldr r0, _020CCF10 // =_02147230
	mov r1, #1
	str r1, [r0]
_020CCEFC:
	mov r0, r4
	bl FindListContainHeap
	mov r1, r4
	bl NNS_FndAppendListObject
	ldmia sp!, {r4, pc}
	.align 2, 0
_020CCF10: .word _02147230
_020CCF14: .word _02147234
	arm_func_end NNSi_FndInitHeapHead

	arm_func_start FindListContainHeap
FindListContainHeap: // 0x020CCF18
	stmdb sp!, {r4, lr}
	ldr r4, _020CCF3C // =_02147234
	mov r1, r0
	mov r0, r4
	bl FindContainHeap
	cmp r0, #0
	addne r4, r0, #0xc
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_020CCF3C: .word _02147234
	arm_func_end FindListContainHeap

	arm_func_start FindContainHeap
FindContainHeap: // 0x020CCF40
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r1, #0
	mov r6, r0
	bl NNS_FndGetNextListObject
	movs r4, r0
	beq _020CCFA0
_020CCF5C:
	ldr r0, [r4, #0x18]
	cmp r0, r5
	bhi _020CCF8C
	ldr r0, [r4, #0x1c]
	cmp r5, r0
	bhs _020CCF8C
	mov r1, r5
	add r0, r4, #0xc
	bl FindContainHeap
	cmp r0, #0
	moveq r0, r4
	ldmia sp!, {r4, r5, r6, pc}
_020CCF8C:
	mov r0, r6
	mov r1, r4
	bl NNS_FndGetNextListObject
	movs r4, r0
	bne _020CCF5C
_020CCFA0:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end FindContainHeap

	arm_func_start NNS_FndSetAllocModeForExpHeap
NNS_FndSetAllocModeForExpHeap: // 0x020CCFA8
	add ip, r0, #0x24
	ldrh r3, [ip, #0x12]
	and r1, r1, #1
	bic r0, r3, #1
	strh r0, [ip, #0x12]
	ldrh r2, [ip, #0x12]
	and r0, r3, #1
	mov r0, r0, lsl #0x10
	orr r1, r2, r1
	strh r1, [ip, #0x12]
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end NNS_FndSetAllocModeForExpHeap

	arm_func_start NNS_FndGetAllocatableSizeForExpHeapEx
NNS_FndGetAllocatableSizeForExpHeapEx: // 0x020CCFD8
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r0, r1
	bl abs
	ldr r4, [r4, #0x24]
	mov r6, #0
	cmp r4, #0
	mvn r5, #0
	beq _020CD054
	sub ip, r0, #1
	mvn r3, ip
_020CD004:
	add r2, r4, #0x10
	ldr r0, [r4, #4]
	add r1, ip, r2
	and r1, r3, r1
	add r0, r0, r2
	cmp r1, r0
	bhs _020CD048
	sub lr, r0, r1
	cmp r6, lr
	sub r0, r1, r2
	blo _020CD040
	cmp r6, lr
	bne _020CD048
	cmp r5, r0
	bls _020CD048
_020CD040:
	mov r6, lr
	mov r5, r0
_020CD048:
	ldr r4, [r4, #0xc]
	cmp r4, #0
	bne _020CD004
_020CD054:
	mov r0, r6
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_FndGetAllocatableSizeForExpHeapEx

	arm_func_start NNS_FndGetTotalFreeSizeForExpHeap
NNS_FndGetTotalFreeSizeForExpHeap: // 0x020CD05C
	ldr r2, [r0, #0x24]
	mov r0, #0
	cmp r2, #0
	bxeq lr
_020CD06C:
	ldr r1, [r2, #4]
	ldr r2, [r2, #0xc]
	add r0, r0, r1
	cmp r2, #0
	bne _020CD06C
	bx lr
	arm_func_end NNS_FndGetTotalFreeSizeForExpHeap

	arm_func_start NNS_FndFreeToExpHeap
NNS_FndFreeToExpHeap: // 0x020CD084
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	sub r4, r1, #0x10
	add r5, r0, #0x24
	add r0, sp, #0
	mov r1, r4
	bl GetRegionOfMBlock
	mov r1, r4
	add r0, r5, #8
	bl RemoveMBlock
	add r1, sp, #0
	mov r0, r5
	bl RecycleRegion
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNS_FndFreeToExpHeap

	arm_func_start NNS_FndAllocFromExpHeapEx
NNS_FndAllocFromExpHeapEx: // 0x020CD0C0
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0
	moveq r1, #1
	add r1, r1, #3
	cmp r2, #0
	bic r1, r1, #3
	blt _020CD0EC
	bl NNS_ExpHeap_AllocFromHead
	add sp, sp, #4
	ldmia sp!, {pc}
_020CD0EC:
	rsb r2, r2, #0
	bl NNS_ExpHeap_AllocFromTail
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_FndAllocFromExpHeapEx

	arm_func_start NNS_FndDestroyExpHeap
NNS_FndDestroyExpHeap: // 0x020CD0FC
	ldr ip, _020CD104 // =NNSi_FndFinalizeHeap
	bx ip
	.align 2, 0
_020CD104: .word NNSi_FndFinalizeHeap
	arm_func_end NNS_FndDestroyExpHeap

	arm_func_start NNS_FndCreateExpHeapEx
NNS_FndCreateExpHeapEx: // 0x020CD108
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r1, r1, r0
	add r0, r0, #3
	bic r1, r1, #3
	bic r0, r0, #3
	cmp r0, r1
	bhi _020CD134
	sub r3, r1, r0
	cmp r3, #0x4c
	bhs _020CD140
_020CD134:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020CD140:
	bl NNS_InitExpHeap
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_FndCreateExpHeapEx

	arm_func_start RecycleRegion
RecycleRegion: // 0x020CD14C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r1
	ldr r2, [r5]
	ldr r1, [r5, #4]
	mov r6, r0
	str r2, [sp]
	str r1, [sp, #4]
	ldr r1, [r6]
	mov r4, #0
	cmp r1, #0
	beq _020CD1C0
	ldr r0, [r5]
_020CD180:
	cmp r1, r0
	movlo r4, r1
	blo _020CD1B4
	ldr r0, [r5, #4]
	cmp r1, r0
	bne _020CD1C0
	ldr r2, [r1, #4]
	add r0, r1, #0x10
	add r2, r2, r0
	mov r0, r6
	str r2, [sp, #4]
	bl RemoveMBlock
	b _020CD1C0
_020CD1B4:
	ldr r1, [r1, #0xc]
	cmp r1, #0
	bne _020CD180
_020CD1C0:
	cmp r4, #0
	beq _020CD1F4
	ldr r2, [r4, #4]
	add r1, r4, #0x10
	ldr r0, [r5]
	add r1, r2, r1
	cmp r1, r0
	bne _020CD1F4
	mov r0, r6
	mov r1, r4
	str r4, [sp]
	bl RemoveMBlock
	mov r4, r0
_020CD1F4:
	ldr r1, [sp, #4]
	ldr r0, [sp]
	sub r0, r1, r0
	cmp r0, #0x10
	addlo sp, sp, #8
	movlo r0, #0
	ldmloia sp!, {r4, r5, r6, pc}
	ldr r1, _020CD238 // =0x00004652
	add r0, sp, #0
	bl InitMBlock
	mov r1, r0
	mov r0, r6
	mov r2, r4
	bl InsertMBlock
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020CD238: .word 0x00004652
	arm_func_end RecycleRegion

	arm_func_start NNS_ExpHeap_AllocFromTail
NNS_ExpHeap_AllocFromTail: // 0x020CD23C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	add r0, r0, #0x24
	ldrh r4, [r0, #0x12]
	mov r3, r1
	mvn lr, #0
	and r1, r4, #1
	mov r1, r1, lsl #0x10
	movs r1, r1, lsr #0x10
	moveq r5, #1
	mov r1, #0
	ldr r4, [r0, #4]
	movne r5, #0
	mov ip, r1
	cmp r4, #0
	beq _020CD2D0
	sub r2, r2, #1
	mvn r2, r2
_020CD284:
	ldr r8, [r4, #4]
	add r9, r4, #0x10
	add r6, r8, r9
	sub r6, r6, r3
	and r7, r2, r6
	subs r6, r7, r9
	bmi _020CD2C4
	cmp lr, r8
	bls _020CD2C4
	mov r1, r4
	mov lr, r8
	mov ip, r7
	cmp r5, #0
	bne _020CD2D0
	cmp r8, r3
	beq _020CD2D0
_020CD2C4:
	ldr r4, [r4, #8]
	cmp r4, #0
	bne _020CD284
_020CD2D0:
	cmp r1, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r4, #1
	mov r2, ip
	str r4, [sp]
	bl NNS_ExpHeap_AllocUsedBlockFromFreeBlock
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end NNS_ExpHeap_AllocFromTail

	arm_func_start NNS_ExpHeap_AllocFromHead
NNS_ExpHeap_AllocFromHead: // 0x020CD2F8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	add r0, r0, #0x24
	ldrh r4, [r0, #0x12]
	mov r3, r1
	ldr r5, [r0]
	and r1, r4, #1
	mov r1, r1, lsl #0x10
	movs r1, r1, lsr #0x10
	moveq r6, #1
	mov r1, #0
	movne r6, #0
	mov lr, r1
	cmp r5, #0
	mvn r4, #0
	beq _020CD390
	sub ip, r2, #1
	mvn r2, ip
_020CD340:
	add r8, r5, #0x10
	add r7, ip, r8
	and r9, r2, r7
	sub r7, r9, r8
	ldr r8, [r5, #4]
	add r7, r3, r7
	cmp r8, r7
	blo _020CD384
	cmp r4, r8
	bls _020CD384
	mov r1, r5
	mov r4, r8
	mov lr, r9
	cmp r6, #0
	bne _020CD390
	cmp r8, r3
	beq _020CD390
_020CD384:
	ldr r5, [r5, #0xc]
	cmp r5, #0
	bne _020CD340
_020CD390:
	cmp r1, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r4, #0
	mov r2, lr
	str r4, [sp]
	bl NNS_ExpHeap_AllocUsedBlockFromFreeBlock
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end NNS_ExpHeap_AllocFromHead

	arm_func_start NNS_ExpHeap_AllocUsedBlockFromFreeBlock
NNS_ExpHeap_AllocUsedBlockFromFreeBlock: // 0x020CD3B8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x18
	mov r7, r0
	add r0, sp, #0
	mov r8, r1
	mov r6, r2
	mov r5, r3
	bl GetRegionOfMBlock
	ldr r3, [sp, #4]
	sub r4, r6, #0x10
	add r2, r5, r6
	mov r0, r7
	mov r1, r8
	str r4, [sp, #4]
	str r3, [sp, #0xc]
	str r2, [sp, #8]
	bl RemoveMBlock
	ldr r2, [sp]
	ldr r1, [sp, #4]
	mov r5, r0
	sub r0, r1, r2
	cmp r0, #0x10
	strlo r2, [sp, #4]
	blo _020CD438
	ldr r1, _020CD538 // =0x00004652
	add r0, sp, #0
	bl InitMBlock
	mov r1, r0
	mov r0, r7
	mov r2, r5
	bl InsertMBlock
	mov r5, r0
_020CD438:
	ldr r1, [sp, #0xc]
	ldr r0, [sp, #8]
	sub r0, r1, r0
	cmp r0, #0x10
	strlo r1, [sp, #8]
	blo _020CD46C
	ldr r1, _020CD538 // =0x00004652
	add r0, sp, #8
	bl InitMBlock
	mov r1, r0
	mov r0, r7
	mov r2, r5
	bl InsertMBlock
_020CD46C:
	ldr r0, [r7, #-4]
	ldr r1, [sp, #4]
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	ldr r2, [sp, #8]
	mov r0, r0, lsr #0x10
	sub r2, r2, r1
	ands r0, r0, #1
	beq _020CD498
	mov r0, #0
	bl MIi_CpuClear32
_020CD498:
	ldr r2, [sp, #8]
	ldr r1, _020CD53C // =0x00005544
	add r0, sp, #0x10
	str r4, [sp, #0x10]
	str r2, [sp, #0x14]
	bl InitMBlock
	mov r1, r0
	ldrh r3, [r1, #2]
	ldrh r2, [sp, #0x30]
	add r0, r7, #8
	bic r3, r3, #0x8000
	strh r3, [r1, #2]
	ldrh r3, [r1, #2]
	and r2, r2, #1
	orr r2, r3, r2, lsl #15
	strh r2, [r1, #2]
	ldrh r2, [r1, #2]
	ldr r3, [sp, #4]
	bic r2, r2, #0x7f00
	strh r2, [r1, #2]
	sub r2, r1, r3
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	ldrh r3, [r1, #2]
	and r2, r2, #0x7f
	orr r2, r3, r2, lsl #8
	strh r2, [r1, #2]
	ldrh r2, [r1, #2]
	ldrh r3, [r7, #0x10]
	bic r2, r2, #0xff
	strh r2, [r1, #2]
	ldrh r2, [r1, #2]
	and r3, r3, #0xff
	orr r2, r2, r3
	strh r2, [r1, #2]
	ldr r2, [r7, #0xc]
	bl InsertMBlock
	mov r0, r6
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020CD538: .word 0x00004652
_020CD53C: .word 0x00005544
	arm_func_end NNS_ExpHeap_AllocUsedBlockFromFreeBlock

	arm_func_start NNS_InitExpHeap
NNS_InitExpHeap: // 0x020CD540
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r3, r1
	add r4, r5, #0x24
	str r2, [sp]
	ldr r1, _020CD5B8 // =0x45585048
	add r2, r4, #0x14
	bl NNSi_FndInitHeapHead
	mov r0, #0
	strh r0, [r4, #0x10]
	strh r0, [r4, #0x12]
	ldrh r2, [r4, #0x12]
	ldr r1, _020CD5BC // =0x00004652
	add r0, sp, #4
	bic r2, r2, #1
	strh r2, [r4, #0x12]
	ldr r2, [r5, #0x18]
	str r2, [sp, #4]
	ldr r2, [r5, #0x1c]
	str r2, [sp, #8]
	bl InitMBlock
	str r0, [r5, #0x24]
	str r0, [r4, #4]
	mov r1, #0
	str r1, [r4, #8]
	mov r0, r5
	str r1, [r4, #0xc]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020CD5B8: .word 0x45585048
_020CD5BC: .word 0x00004652
	arm_func_end NNS_InitExpHeap

	arm_func_start InitMBlock
InitMBlock: // 0x020CD5C0
	ldr r3, [r0]
	mov r2, #0
	strh r1, [r3]
	strh r2, [r3, #2]
	ldr r1, [r0, #4]
	add r0, r3, #0x10
	sub r0, r1, r0
	str r0, [r3, #4]
	str r2, [r3, #8]
	mov r0, r3
	str r2, [r3, #0xc]
	bx lr
	arm_func_end InitMBlock

	arm_func_start InsertMBlock
InsertMBlock: // 0x020CD5F0
	str r2, [r1, #8]
	cmp r2, #0
	ldrne r3, [r2, #0xc]
	strne r1, [r2, #0xc]
	ldreq r3, [r0]
	streq r1, [r0]
	str r3, [r1, #0xc]
	cmp r3, #0
	strne r1, [r3, #8]
	streq r1, [r0, #4]
	mov r0, r1
	bx lr
	arm_func_end InsertMBlock

	arm_func_start RemoveMBlock
RemoveMBlock: // 0x020CD620
	ldr r2, [r1, #8]
	ldr r1, [r1, #0xc]
	cmp r2, #0
	strne r1, [r2, #0xc]
	streq r1, [r0]
	cmp r1, #0
	strne r2, [r1, #8]
	streq r2, [r0, #4]
	mov r0, r2
	bx lr
	arm_func_end RemoveMBlock

	arm_func_start GetRegionOfMBlock
GetRegionOfMBlock: // 0x020CD648
	ldrh r2, [r1, #2]
	add r3, r1, #0x10
	mov r2, r2, asr #8
	and r2, r2, #0x7f
	mov r2, r2, lsl #0x10
	sub r2, r1, r2, lsr #16
	str r2, [r0]
	ldr r1, [r1, #4]
	add r1, r1, r3
	str r1, [r0, #4]
	bx lr
	arm_func_end GetRegionOfMBlock

	arm_func_start NNS_FndFreeToFrmHeap
NNS_FndFreeToFrmHeap: // 0x020CD674
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r5, r0
	ands r1, r4, #1
	beq _020CD690
	bl NNS_FrameHeap_FreeHead
_020CD690:
	ands r0, r4, #2
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r5
	bl NNS_FrameHeap_FreeTail
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNS_FndFreeToFrmHeap

	arm_func_start NNS_FndAllocFromFrmHeapEx
NNS_FndAllocFromFrmHeapEx: // 0x020CD6AC
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0
	moveq r1, #1
	add r1, r1, #3
	add r0, r0, #0x24
	cmp r2, #0
	bic r1, r1, #3
	blt _020CD6DC
	bl NNS_FrameHeap_AllocFromHead
	add sp, sp, #4
	ldmia sp!, {pc}
_020CD6DC:
	rsb r2, r2, #0
	bl NNS_FrameHeap_AllocFromTail
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_FndAllocFromFrmHeapEx

	arm_func_start NNS_FndDestroyFrmHeap
NNS_FndDestroyFrmHeap: // 0x020CD6EC
	ldr ip, _020CD6F4 // =NNSi_FndFinalizeHeap
	bx ip
	.align 2, 0
_020CD6F4: .word NNSi_FndFinalizeHeap
	arm_func_end NNS_FndDestroyFrmHeap

	arm_func_start NNS_FndCreateFrmHeapEx
NNS_FndCreateFrmHeapEx: // 0x020CD6F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r1, r1, r0
	add r0, r0, #3
	bic r1, r1, #3
	bic r0, r0, #3
	cmp r0, r1
	bhi _020CD724
	sub r3, r1, r0
	cmp r3, #0x30
	bhs _020CD730
_020CD724:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020CD730:
	bl NNS_InitFrameHeap
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_FndCreateFrmHeapEx

	arm_func_start NNS_FrameHeap_FreeTail
NNS_FrameHeap_FreeTail: // 0x020CD73C
	add r2, r0, #0x24
	ldr r3, [r2, #8]
	cmp r3, #0
	beq _020CD760
_020CD74C:
	ldr r1, [r0, #0x1c]
	str r1, [r3, #8]
	ldr r3, [r3, #0xc]
	cmp r3, #0
	bne _020CD74C
_020CD760:
	ldr r0, [r0, #0x1c]
	str r0, [r2, #4]
	bx lr
	arm_func_end NNS_FrameHeap_FreeTail

	arm_func_start NNS_FrameHeap_FreeHead
NNS_FrameHeap_FreeHead: // 0x020CD76C
	ldr r1, [r0, #0x18]
	add r2, r0, #0x24
	str r1, [r0, #0x24]
	mov r0, #0
	str r0, [r2, #8]
	bx lr
	arm_func_end NNS_FrameHeap_FreeHead

	arm_func_start NNS_FrameHeap_AllocFromTail
NNS_FrameHeap_AllocFromTail: // 0x020CD784
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r3, [r5, #4]
	sub r0, r2, #1
	mvn r2, r0
	sub r1, r3, r1
	ldr r0, [r5]
	and r4, r2, r1
	cmp r4, r0
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r4, r5, pc}
	ldr r0, [r5, #-4]
	sub r2, r3, r4
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ands r0, r0, #1
	beq _020CD7E0
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear32
_020CD7E0:
	mov r0, r4
	str r4, [r5, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNS_FrameHeap_AllocFromTail

	arm_func_start NNS_FrameHeap_AllocFromHead
NNS_FrameHeap_AllocFromHead: // 0x020CD7F0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6]
	sub r2, r2, #1
	mvn r3, r2
	add r2, r2, r0
	and r5, r3, r2
	ldr r2, [r6, #4]
	add r4, r1, r5
	cmp r4, r2
	movhi r0, #0
	ldmhiia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #-4]
	sub r2, r4, r0
	and r1, r1, #0xff
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ands r1, r1, #1
	beq _020CD848
	mov r1, r0
	mov r0, #0
	bl MIi_CpuClear32
_020CD848:
	mov r0, r5
	str r4, [r6]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_FrameHeap_AllocFromHead

	arm_func_start NNS_InitFrameHeap
NNS_InitFrameHeap: // 0x020CD854
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r3, r1
	add r4, r5, #0x24
	str r2, [sp]
	ldr r1, _020CD89C // =0x46524D48
	add r2, r4, #0xc
	bl NNSi_FndInitHeapHead
	ldr r0, [r5, #0x18]
	mov r1, #0
	str r0, [r5, #0x24]
	ldr r2, [r5, #0x1c]
	mov r0, r5
	str r2, [r4, #4]
	str r1, [r4, #8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020CD89C: .word 0x46524D48
	arm_func_end NNS_InitFrameHeap

	arm_func_start OpenFileFast_IfFileID
OpenFileFast_IfFileID: // 0x020CD8A0
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r3, [r1, #0x60]
	mov ip, #0
	ldrh r3, [r3, #8]
	cmp r2, r3
	bhs _020CD8D4
	add r3, sp, #0
	str r1, [sp]
	str r2, [sp, #4]
	ldmia r3, {r1, r2}
	bl FS_OpenFileFast
	mov ip, r0
_020CD8D4:
	mov r0, ip
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end OpenFileFast_IfFileID

	arm_func_start NNS_FndGetArchiveFileByIndex
NNS_FndGetArchiveFileByIndex: // 0x020CD8E0
	ldr r3, [r0, #0x60]
	mov ip, #0
	ldrh r2, [r3, #8]
	cmp r1, r2
	addlo r1, r3, r1, lsl #3
	ldrlo r2, [r0, #0x64]
	ldrlo r0, [r1, #0xc]
	addlo ip, r2, r0
	mov r0, ip
	bx lr
	arm_func_end NNS_FndGetArchiveFileByIndex

	arm_func_start NNS_FndGetArchiveFileByName
NNS_FndGetArchiveFileByName: // 0x020CD908
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x4c
	mov r5, r0
	add r0, sp, #0
	mov r4, #0
	bl FS_InitFile
	add r0, sp, #0
	mov r1, r5
	bl FS_OpenFile
	cmp r0, #0
	beq _020CD94C
	ldr r0, [sp, #8]
	ldr r1, [sp, #0x24]
	ldr r2, [r0, #0x64]
	add r0, sp, #0
	add r4, r2, r1
	bl FS_CloseFile
_020CD94C:
	mov r0, r4
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNS_FndGetArchiveFileByName

	arm_func_start NNS_FndUnmountArchive
NNS_FndUnmountArchive: // 0x020CD958
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl FS_UnloadArchive
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl RemoveArchiveFromList
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end NNS_FndUnmountArchive

	arm_func_start NNS_FndMountArchive
NNS_FndMountArchive: // 0x020CD980
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x10
	mov r7, r2
	mov r6, #0
	mov r9, r0
	mov r0, r7
	mov r8, r1
	mov r5, r6
	mov r4, r6
	bl Rush__File__ValidateNARCHeader
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, r6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldrh r1, [r7, #0xc]
	ldrh r0, [r7, #0xe]
	mov r2, r6
	add r1, r7, r1
	cmp r0, #0
	ble _020CDA1C
	ldr r3, _020CDAC0 // =0x464E5442
	ldr ip, _020CDAC4 // =0x46494D47
	ldr lr, _020CDAC8 // =0x46415442
_020CD9DC:
	ldr r10, [r1]
	cmp r10, lr
	beq _020CD9FC
	cmp r10, ip
	beq _020CDA04
	cmp r10, r3
	moveq r5, r1
	b _020CDA08
_020CD9FC:
	mov r6, r1
	b _020CDA08
_020CDA04:
	mov r4, r1
_020CDA08:
	ldr r10, [r1, #4]
	add r2, r2, #1
	add r1, r1, r10
	cmp r2, r0
	blt _020CD9DC
_020CDA1C:
	mov r0, r9
	bl FS_InitArchive
	str r7, [r9, #0x5c]
	mov r0, r8
	str r6, [r9, #0x60]
	add r4, r4, #8
	str r4, [r9, #0x64]
	bl strlen
	mov r2, r0
	mov r0, r9
	mov r1, r8
	bl FS_RegisterArchiveName
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r0, r5, #8
	sub r0, r0, r4
	str r0, [sp]
	ldr r0, [r5, #4]
	add r2, r6, #0xc
	sub r0, r0, #8
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldr r3, [r6, #4]
	mov r0, r9
	mov r1, r4
	sub r2, r2, r4
	sub r3, r3, #0xc
	bl FS_LoadArchive
	cmp r0, #0
	addne sp, sp, #0x10
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r9
	bl RemoveArchiveFromList
	mov r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020CDAC0: .word 0x464E5442
_020CDAC4: .word 0x46494D47
_020CDAC8: .word 0x46415442
	arm_func_end NNS_FndMountArchive

	arm_func_start Rush__File__ValidateNARCHeader
Rush__File__ValidateNARCHeader: // 0x020CDACC
	ldr r2, [r0]
	ldr r1, _020CDB08 // =0x4352414E
	cmp r2, r1
	movne r0, #0
	bxne lr
	ldrh r2, [r0, #4]
	ldr r1, _020CDB0C // =0x0000FFFE
	cmp r2, r1
	movne r0, #0
	bxne lr
	ldrh r0, [r0, #6]
	cmp r0, #0x100
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_020CDB08: .word 0x4352414E
_020CDB0C: .word 0x0000FFFE
	arm_func_end Rush__File__ValidateNARCHeader

	arm_func_start NNS_FndFreeToAllocator
NNS_FndFreeToAllocator: // 0x020CDB10
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0]
	ldr r2, [r2, #4]
	blx r2
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_FndFreeToAllocator

	arm_func_start NNS_FndAllocFromAllocator
NNS_FndAllocFromAllocator: // 0x020CDB2C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0]
	ldr r2, [r2]
	blx r2
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_FndAllocFromAllocator