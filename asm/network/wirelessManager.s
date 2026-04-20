	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public WirelessManager__sVars
WirelessManager__sVars: // 0x02135EC0
	.space 0x18 
	
.public WirelessManager__sendBufferQueue
WirelessManager__sendBufferQueue: // 0x002135ED8
	.space 18 * 0x4
	
.public Task__Unknown20673B0__byte_2135F20
Task__Unknown20673B0__byte_2135F20: // 02135F20
	.space 32 * 0x1
	
.public WirelessManager__gameInfo
WirelessManager__gameInfo: // 0x02135F40
	.space 0x80
	
.public WirelessManager__sendBuffer
WirelessManager__sendBuffer: // 0x02135FC0
	.space 128 * 0x04 
	
.public word_21361C0
word_21361C0: // 0x021361C0
	.space 144 * 0x04

	.text

	arm_func_start WirelessManager__InitAllocator
WirelessManager__InitAllocator: // 0x0206712C
	ldr r2, _0206736C // =WirelessManager__sVars
	mov r3, #0
	str r3, [r2, #0x14]
	str r3, [r2, #8]
	strh r3, [r2, #2]
	str r3, [r2, #4]
	str r3, [r2, #0x10]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _020671F0
_02067154: // jump table
	b _02067174 // case 0
	b _02067184 // case 1
	b _02067194 // case 2
	b _020671A4 // case 3
	b _020671B4 // case 4
	b _020671C4 // case 5
	b _020671D4 // case 6
	b _020671E4 // case 7
_02067174:
	ldr r3, _02067370 // =_AllocHeadHEAP_SYSTEM
	ldr r2, _02067374 // =whConfig_whAllocFunc
	str r3, [r2]
	b _020671F0
_02067184:
	ldr r3, _02067378 // =_AllocTailHEAP_SYSTEM
	ldr r2, _02067374 // =whConfig_whAllocFunc
	str r3, [r2]
	b _020671F0
_02067194:
	ldr r3, _0206737C // =_AllocHeadHEAP_USER
	ldr r2, _02067374 // =whConfig_whAllocFunc
	str r3, [r2]
	b _020671F0
_020671A4:
	ldr r3, _02067380 // =_AllocTailHEAP_USER
	ldr r2, _02067374 // =whConfig_whAllocFunc
	str r3, [r2]
	b _020671F0
_020671B4:
	ldr r3, _02067384 // =_AllocHeadHEAP_ITCM
	ldr r2, _02067374 // =whConfig_whAllocFunc
	str r3, [r2]
	b _020671F0
_020671C4:
	ldr r3, _02067388 // =_AllocTailHEAP_ITCM
	ldr r2, _02067374 // =whConfig_whAllocFunc
	str r3, [r2]
	b _020671F0
_020671D4:
	ldr r3, _0206738C // =_AllocHeadHEAP_DTCM
	ldr r2, _02067374 // =whConfig_whAllocFunc
	str r3, [r2]
	b _020671F0
_020671E4:
	ldr r3, _02067390 // =_AllocTailHEAP_DTCM
	ldr r2, _02067374 // =whConfig_whAllocFunc
	str r3, [r2]
_020671F0:
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _02067258
_020671FC: // jump table
	b _0206721C // case 0
	b _0206721C // case 1
	b _0206722C // case 2
	b _0206722C // case 3
	b _0206723C // case 4
	b _0206723C // case 5
	b _0206724C // case 6
	b _0206724C // case 7
_0206721C:
	ldr r2, _02067394 // =_FreeHEAP_SYSTEM
	ldr r0, _02067398 // =whConfig_whFreeFunc
	str r2, [r0]
	b _02067258
_0206722C:
	ldr r2, _0206739C // =_FreeHEAP_USER
	ldr r0, _02067398 // =whConfig_whFreeFunc
	str r2, [r0]
	b _02067258
_0206723C:
	ldr r2, _020673A0 // =_FreeHEAP_ITCM
	ldr r0, _02067398 // =whConfig_whFreeFunc
	str r2, [r0]
	b _02067258
_0206724C:
	ldr r2, _020673A4 // =_FreeHEAP_DTCM
	ldr r0, _02067398 // =whConfig_whFreeFunc
	str r2, [r0]
_02067258:
	cmp r1, #7
	addls pc, pc, r1, lsl #2
	b _02067300
_02067264: // jump table
	b _02067284 // case 0
	b _02067294 // case 1
	b _020672A4 // case 2
	b _020672B4 // case 3
	b _020672C4 // case 4
	b _020672D4 // case 5
	b _020672E4 // case 6
	b _020672F4 // case 7
_02067284:
	ldr r2, _02067370 // =_AllocHeadHEAP_SYSTEM
	ldr r0, _020673A8 // =wfsi_task+0x000004C8
	str r2, [r0]
	b _02067300
_02067294:
	ldr r2, _02067378 // =_AllocTailHEAP_SYSTEM
	ldr r0, _020673A8 // =wfsi_task+0x000004C8
	str r2, [r0]
	b _02067300
_020672A4:
	ldr r2, _0206737C // =_AllocHeadHEAP_USER
	ldr r0, _020673A8 // =wfsi_task+0x000004C8
	str r2, [r0]
	b _02067300
_020672B4:
	ldr r2, _02067380 // =_AllocTailHEAP_USER
	ldr r0, _020673A8 // =wfsi_task+0x000004C8
	str r2, [r0]
	b _02067300
_020672C4:
	ldr r2, _02067384 // =_AllocHeadHEAP_ITCM
	ldr r0, _020673A8 // =wfsi_task+0x000004C8
	str r2, [r0]
	b _02067300
_020672D4:
	ldr r2, _02067388 // =_AllocTailHEAP_ITCM
	ldr r0, _020673A8 // =wfsi_task+0x000004C8
	str r2, [r0]
	b _02067300
_020672E4:
	ldr r2, _0206738C // =_AllocHeadHEAP_DTCM
	ldr r0, _020673A8 // =wfsi_task+0x000004C8
	str r2, [r0]
	b _02067300
_020672F4:
	ldr r2, _02067390 // =_AllocTailHEAP_DTCM
	ldr r0, _020673A8 // =wfsi_task+0x000004C8
	str r2, [r0]
_02067300:
	cmp r1, #7
	addls pc, pc, r1, lsl #2
	bx lr
_0206730C: // jump table
	b _0206732C // case 0
	b _0206732C // case 1
	b _0206733C // case 2
	b _0206733C // case 3
	b _0206734C // case 4
	b _0206734C // case 5
	b _0206735C // case 6
	b _0206735C // case 7
_0206732C:
	ldr r1, _02067394 // =_FreeHEAP_SYSTEM
	ldr r0, _020673AC // =dword_213927C
	str r1, [r0]
	bx lr
_0206733C:
	ldr r1, _0206739C // =_FreeHEAP_USER
	ldr r0, _020673AC // =dword_213927C
	str r1, [r0]
	bx lr
_0206734C:
	ldr r1, _020673A0 // =_FreeHEAP_ITCM
	ldr r0, _020673AC // =dword_213927C
	str r1, [r0]
	bx lr
_0206735C:
	ldr r1, _020673A4 // =_FreeHEAP_DTCM
	ldr r0, _020673AC // =dword_213927C
	str r1, [r0]
	bx lr
	.align 2, 0
_0206736C: .word WirelessManager__sVars
_02067370: .word _AllocHeadHEAP_SYSTEM
_02067374: .word whConfig_whAllocFunc
_02067378: .word _AllocTailHEAP_SYSTEM
_0206737C: .word _AllocHeadHEAP_USER
_02067380: .word _AllocTailHEAP_USER
_02067384: .word _AllocHeadHEAP_ITCM
_02067388: .word _AllocTailHEAP_ITCM
_0206738C: .word _AllocHeadHEAP_DTCM
_02067390: .word _AllocTailHEAP_DTCM
_02067394: .word _FreeHEAP_SYSTEM
_02067398: .word whConfig_whFreeFunc
_0206739C: .word _FreeHEAP_USER
_020673A0: .word _FreeHEAP_ITCM
_020673A4: .word _FreeHEAP_DTCM
_020673A8: .word wfsi_task+0x000004C8
_020673AC: .word dword_213927C
	arm_func_end WirelessManager__InitAllocator

	arm_func_start WirelessManager__Create
WirelessManager__Create: // 0x020673B0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r5, r3
	mov r3, #0
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r3, [sp]
	mov r0, #0xfd
	str r0, [sp, #4]
	ldr r4, _020674A4 // =0x00001D14
	ldr r0, _020674A8 // =WirelessManager__Main1
	ldr r1, _020674AC // =WirelessManager__Destructor
	mov r2, #3
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _020674B0 // =WirelessManager__sVars
	str r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _020674A4 // =0x00001D14
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	ldr r1, _020674B4 // =WirelessManager__State_2068994
	mov r0, #1
	str r1, [r4]
	str r0, [r4, #4]
	str r0, [r4, #8]
	rsb r1, r0, #0x10000
	strb r8, [r4, #0x16]
	add r0, r4, #0x1900
	strh r1, [r0, #0x2a]
	add r0, r4, #0x1a00
	strh r6, [r0, #0xee]
	ldrh r1, [r0, #0xee]
	cmp r1, #4
	movlo r1, #4
	strloh r1, [r0, #0xee]
	mov r0, r7
	bl WH_SetMaxChildCount
	mov r0, #4
	bl WH_SetMinDataSize
	mov r0, #4
	bl WirelessManager__Func_2068614
	bl WH_Initialize
	ldr r0, _020674B8 // =0x00400342
	bl WH_SetGgid
	ldr r0, _020674BC // =WirelessManager__JudgeAcceptFunc
	bl WH_SetJudgeAcceptFunc
	cmp r5, #0
	ldrneh r2, [sp, #0x28]
	cmpne r2, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	ldr r1, _020674C0 // =WirelessManager__gameInfo
	mov r0, r5
	str r2, [r4, #0x20]
	bl MI_CpuCopy8
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020674A4: .word 0x00001D14
_020674A8: .word WirelessManager__Main1
_020674AC: .word WirelessManager__Destructor
_020674B0: .word WirelessManager__sVars
_020674B4: .word WirelessManager__State_2068994
_020674B8: .word 0x00400342
_020674BC: .word WirelessManager__JudgeAcceptFunc
_020674C0: .word WirelessManager__gameInfo
	arm_func_end WirelessManager__Create

	arm_func_start WirelessManager__Create1
WirelessManager__Create1: // 0x020674C4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r5, r3
	mov r3, #0
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r3, [sp]
	mov r0, #0xfd
	str r0, [sp, #4]
	ldr r4, _02067614 // =0x00001D14
	ldr r0, _02067618 // =WirelessManager__Main3
	ldr r1, _0206761C // =WirelessManager__Destructor
	mov r2, #3
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _02067620 // =WirelessManager__sVars
	str r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02067614 // =0x00001D14
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	ldr r1, _02067624 // =WirelessManager__State_2068DD4
	mov r0, #1
	str r1, [r4]
	str r0, [r4, #4]
	rsb r2, r0, #0x10000
	mov r0, #2
	str r0, [r4, #8]
	ldrh r1, [r8, #0]
	mov r3, #0x19
	add r0, r4, #0x1900
	strh r1, [r4, #0x10]
	ldrh ip, [r8, #4]
	add r1, r4, #0x1a00
	strh ip, [r4, #0x12]
	strb r3, [r4, #0x16]
	strh r2, [r0, #0x2a]
	strh r6, [r1, #0xee]
	str r7, [r4, #0x1c]
	ldrh r0, [r1, #0xee]
	mov r2, #0
	cmp r0, #4
	movlo r0, #4
	strloh r0, [r1, #0xee]
	b _020675A0
_02067584:
	ldrh r1, [r4, #0x14]
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #1
	orr r1, r1, #1
	strh r1, [r4, #0x14]
	mov r2, r0, lsr #0x10
_020675A0:
	ldrh r0, [r8, #2]
	cmp r2, r0
	blo _02067584
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WH_SetMaxChildCount
	add r0, r4, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WH_SetMinDataSize
	add r0, r4, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WirelessManager__Func_2068614
	bl WH_Initialize
	ldr r0, _02067628 // =0x00400342
	bl WH_SetGgid
	ldr r0, _0206762C // =WirelessManager__JudgeAcceptFunc
	bl WH_SetJudgeAcceptFunc
	cmp r5, #0
	ldrneh r2, [sp, #0x28]
	cmpne r2, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	ldr r1, _02067630 // =WirelessManager__gameInfo
	mov r0, r5
	str r2, [r4, #0x20]
	bl MI_CpuCopy8
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02067614: .word 0x00001D14
_02067618: .word WirelessManager__Main3
_0206761C: .word WirelessManager__Destructor
_02067620: .word WirelessManager__sVars
_02067624: .word WirelessManager__State_2068DD4
_02067628: .word 0x00400342
_0206762C: .word WirelessManager__JudgeAcceptFunc
_02067630: .word WirelessManager__gameInfo
	arm_func_end WirelessManager__Create1

	arm_func_start WirelessManager__Create2
WirelessManager__Create2: // 0x02067634
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r5, r3
	mov r3, #0
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r3, [sp]
	mov r0, #0xfd
	str r0, [sp, #4]
	ldr r4, _0206771C // =0x00001D14
	ldr r0, _02067720 // =WirelessManager__Main1
	ldr r1, _02067724 // =WirelessManager__Destructor
	mov r2, #3
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _02067728 // =WirelessManager__sVars
	str r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _0206771C // =0x00001D14
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	ldr r1, _0206772C // =WirelessManager__State_2069024
	mov r0, #1
	str r1, [r4]
	str r0, [r4, #4]
	mov r2, #4
	str r2, [r4, #8]
	rsb r1, r0, #0x10000
	strb r8, [r4, #0x16]
	add r0, r4, #0x1900
	strh r1, [r0, #0x2a]
	add r0, r4, #0x1a00
	strh r6, [r0, #0xee]
	ldrh r1, [r0, #0xee]
	cmp r1, #4
	strloh r2, [r0, #0xee]
	mov r0, r7
	bl WH_SetMaxChildCount
	mov r0, #4
	bl WH_SetMinDataSize
	mov r0, #4
	bl WirelessManager__Func_2068614
	bl WH_Initialize
	ldr r0, _02067730 // =0x00400342
	bl WH_SetGgid
	cmp r5, #0
	ldrneh r2, [sp, #0x28]
	cmpne r2, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	ldr r1, _02067734 // =Task__Unknown20673B0__byte_2135F20
	mov r0, r5
	bl MI_CpuCopy8
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0206771C: .word 0x00001D14
_02067720: .word WirelessManager__Main1
_02067724: .word WirelessManager__Destructor
_02067728: .word WirelessManager__sVars
_0206772C: .word WirelessManager__State_2069024
_02067730: .word 0x00400342
_02067734: .word Task__Unknown20673B0__byte_2135F20
	arm_func_end WirelessManager__Create2

	arm_func_start WirelessManager__Create3
WirelessManager__Create3: // 0x02067738
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r5, r3
	mov r3, #0
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r3, [sp]
	mov r0, #0xfd
	str r0, [sp, #4]
	ldr r4, _02067880 // =0x00001D14
	ldr r0, _02067884 // =WirelessManager__Main3
	ldr r1, _02067888 // =WirelessManager__Destructor
	mov r2, #3
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _0206788C // =WirelessManager__sVars
	str r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02067880 // =0x00001D14
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	ldr r1, _02067890 // =WirelessManager__State_2069498
	mov r0, #1
	str r1, [r4]
	str r0, [r4, #4]
	mov r0, #5
	str r0, [r4, #8]
	add r0, r8, #4
	add r1, r4, #0x2c
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r2, [r8, #0]
	mov r1, #0
	add r0, r4, #0x1900
	strh r2, [r4, #0x5e]
	strh r1, [r0, #0x2a]
	mov r0, #0x19
	strb r0, [r4, #0x16]
	add r0, r4, #0x1a00
	strh r7, [r0, #0xee]
	ldrh r1, [r0, #0xee]
	mov r2, #0
	cmp r1, #4
	movlo r1, #4
	strloh r1, [r0, #0xee]
	b _02067818
_020677FC:
	ldrh r1, [r4, #0x14]
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #1
	orr r1, r1, #1
	strh r1, [r4, #0x14]
	mov r2, r0, lsr #0x10
_02067818:
	ldrh r0, [r8, #2]
	cmp r2, r0
	blo _020677FC
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WH_SetMaxChildCount
	add r0, r4, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WH_SetMinDataSize
	add r0, r4, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WirelessManager__Func_2068614
	bl WH_Initialize
	ldr r0, _02067894 // =0x00400342
	bl WH_SetGgid
	cmp r6, #0
	cmpne r5, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	ldr r1, _02067898 // =Task__Unknown20673B0__byte_2135F20
	mov r0, r6
	mov r2, r5
	bl MI_CpuCopy8
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02067880: .word 0x00001D14
_02067884: .word WirelessManager__Main3
_02067888: .word WirelessManager__Destructor
_0206788C: .word WirelessManager__sVars
_02067890: .word WirelessManager__State_2069498
_02067894: .word 0x00400342
_02067898: .word Task__Unknown20673B0__byte_2135F20
	arm_func_end WirelessManager__Create3

	arm_func_start WirelessManager__Func_206789C
WirelessManager__Func_206789C: // 0x0206789C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	cmp r0, #0
	mov r6, #1
	beq _020678B8
	cmp r0, #1
	beq _0206795C
	b _02067970
_020678B8:
	mov r7, #0
	bl WirelessManager__Func_2068484
	bl WMi_CheckInitialized
	cmp r0, #0
	bne _020678D4
	mov r0, r7
	bl WH_SetReceiver
_020678D4:
	mov r4, #0
	mov r5, r4
_020678DC:
	bl WH_GetSystemState
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02067944
_020678EC: // jump table
	b _02067920 // case 0
	b _02067918 // case 1
	b _02067944 // case 2
	b _02067948 // case 3
	b _02067944 // case 4
	b _02067944 // case 5
	b _02067944 // case 6
	b _02067944 // case 7
	b _02067944 // case 8
	b _02067928 // case 9
	b _0206793C // case 10
_02067918:
	bl WH_End
	b _02067948
_02067920:
	mov r6, r5
	b _02067948
_02067928:
	add r7, r7, #1
	cmp r7, #3
	bhi _0206793C
	bl WH_Reset
	b _02067948
_0206793C:
	mov r6, r4
	b _02067948
_02067944:
	bl WH_Finalize
_02067948:
	cmp r6, #0
	bne _020678DC
	bl WirelessManager__ClearSendBuffer
	bl WirelessManager__ClearUnknownBuffer
	b _02067970
_0206795C:
	bl WMi_CheckInitialized
	cmp r0, #0
	bne _02067970
	mov r0, #0
	bl WH_SetReceiver
_02067970:
	ldr r0, _020679A4 // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	bl SetTaskFlags
	ldr r0, _020679A4 // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	bl DestroyTask
	ldr r0, _020679A4 // =WirelessManager__sVars
	mov r1, #0
	str r1, [r0, #0x14]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_020679A4: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_206789C

	arm_func_start WirelessManager__Func_20679A8
WirelessManager__Func_20679A8: // 0x020679A8
	ldr ip, _020679B0 // =WirelessManager__Func_2068360
	bx ip
	.align 2, 0
_020679B0: .word WirelessManager__Func_2068360
	arm_func_end WirelessManager__Func_20679A8

	arm_func_start WirelessManager__GetEntry2
WirelessManager__GetEntry2: // 0x020679B4
	ldr ip, _020679BC // =WirelessManager__Func_2068380
	bx ip
	.align 2, 0
_020679BC: .word WirelessManager__Func_2068380
	arm_func_end WirelessManager__GetEntry2

	arm_func_start WirelessManager__RemoveEntry2
WirelessManager__RemoveEntry2: // 0x020679C0
	ldr ip, _020679C8 // =WirelessManager__Func_20683A8
	bx ip
	.align 2, 0
_020679C8: .word WirelessManager__Func_20683A8
	arm_func_end WirelessManager__RemoveEntry2

	arm_func_start WirelessManager__Func_20679CC
WirelessManager__Func_20679CC: // 0x020679CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WirelessManager__GetStatus
	cmp r0, #4
	ldmneia sp!, {r4, pc}
	bl WH_GetSystemState
	cmp r0, #2
	bne _020679F0
	bl WH_EndScan
_020679F0:
	bl WirelessManager__Func_2068360
	cmp r4, r0
	ldmhsia sp!, {r4, pc}
	ldr r0, _02067A14 // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	bl GetTaskWork_
	add r0, r0, #0x1900
	strh r4, [r0, #0x2a]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02067A14: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_20679CC

	arm_func_start WirelessManager__Func_2067A18
WirelessManager__Func_2067A18: // 0x02067A18
	stmdb sp!, {r4, lr}
	ldr r1, _02067A44 // =WirelessManager__sVars
	mov r4, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	add r0, r0, #0x12c
	add r2, r0, #0x1800
	sub r1, r4, #1
	mov r0, #0x1e
	mla r0, r1, r0, r2
	ldmia sp!, {r4, pc}
	.align 2, 0
_02067A44: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2067A18

	arm_func_start WirelessManager__Func_2067A48
WirelessManager__Func_2067A48: // 0x02067A48
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02067A84 // =WirelessManager__sVars
	mov r5, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	ldrh r0, [r4, #0x10]
	strh r0, [r5]
	bl WirelessManager__Func_2068214
	strh r0, [r5, #2]
	ldrh r0, [r4, #0x12]
	add r0, r0, #1
	orr r0, r0, #0x8000
	strh r0, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02067A84: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2067A48

	arm_func_start WirelessManager__Func_2067A88
WirelessManager__Func_2067A88: // 0x02067A88
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02067AE4 // =WirelessManager__sVars
	mov r5, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1900
	ldrh r1, [r0, #0x2a]
	mov r0, #0xc8
	mla r0, r1, r0, r4
	ldrh r0, [r0, #0x5e]
	strh r0, [r5]
	bl WirelessManager__Func_2068214
	strh r0, [r5, #2]
	add r0, r4, #0x1900
	ldrh r1, [r0, #0x2a]
	add r2, r4, #0x2c
	mov r0, #0xc8
	mla r0, r1, r0, r2
	add r1, r5, #4
	mov r2, #6
	bl MI_CpuCopy8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02067AE4: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2067A88

	arm_func_start WirelessManager__Func_2067AE8
WirelessManager__Func_2067AE8: // 0x02067AE8
	cmp r0, #0
	ldreq r0, _02067B14 // =WirelessManager__sVars
	ldreq r1, [r0, #0x10]
	biceq r1, r1, #1
	streq r1, [r0, #0x10]
	bxeq lr
	ldr r0, _02067B14 // =WirelessManager__sVars
	ldr r1, [r0, #0x10]
	orr r1, r1, #1
	str r1, [r0, #0x10]
	bx lr
	.align 2, 0
_02067B14: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2067AE8

	arm_func_start WirelessManager__GetSendBuffer
WirelessManager__GetSendBuffer: // 0x02067B18
	ldr r0, _02067B20 // =WirelessManager__sendBuffer
	bx lr
	.align 2, 0
_02067B20: .word WirelessManager__sendBuffer
	arm_func_end WirelessManager__GetSendBuffer

	arm_func_start WirelessManager__GetReceiveBuffer
WirelessManager__GetReceiveBuffer: // 0x02067B24
	ldr r1, _02067B30 // =WirelessManager__sendBufferQueue
	ldr r0, [r1, r0, lsl #2]
	bx lr
	.align 2, 0
_02067B30: .word WirelessManager__sendBufferQueue
	arm_func_end WirelessManager__GetReceiveBuffer

	arm_func_start WirelessManager__ClearSendBuffer
WirelessManager__ClearSendBuffer: // 0x02067B34
	ldr ip, _02067B48 // =MIi_CpuClear32
	ldr r1, _02067B4C // =WirelessManager__sendBuffer
	mov r0, #0
	mov r2, #0x200
	bx ip
	.align 2, 0
_02067B48: .word MIi_CpuClear32
_02067B4C: .word WirelessManager__sendBuffer
	arm_func_end WirelessManager__ClearSendBuffer

	arm_func_start WirelessManager__ClearUnknownBuffer
WirelessManager__ClearUnknownBuffer: // 0x02067B50
	ldr ip, _02067B64 // =MIi_CpuClear32
	ldr r1, _02067B68 // =word_21361C0
	mov r0, #0
	mov r2, #0x240
	bx ip
	.align 2, 0
_02067B64: .word MIi_CpuClear32
_02067B68: .word word_21361C0
	arm_func_end WirelessManager__ClearUnknownBuffer

	arm_func_start WirelessManager__Create4
WirelessManager__Create4: // 0x02067B6C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r5, r3
	mov r3, #0
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r3, [sp]
	mov r0, #0xfd
	str r0, [sp, #4]
	ldr r4, _02067C94 // =0x00001D14
	ldr r0, _02067C98 // =WirelessManager__Main3
	ldr r1, _02067C9C // =WirelessManager__Destructor
	mov r2, #3
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _02067CA0 // =WirelessManager__sVars
	str r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02067C94 // =0x00001D14
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	ldr r1, _02067CA4 // =WirelessManager__State_2068DD4
	mov r0, #2
	str r1, [r4]
	str r0, [r4, #4]
	str r0, [r4, #8]
	ldrh r0, [r8, #0]
	mov r3, #0x19
	ldr r2, _02067CA8 // =0x0000FFFF
	strh r0, [r4, #0x10]
	ldrh ip, [r8, #4]
	add r0, r4, #0x1900
	add r1, r4, #0x1a00
	strh ip, [r4, #0x12]
	strb r3, [r4, #0x16]
	strh r2, [r0, #0x2a]
	strh r6, [r1, #0xf0]
	strh r5, [r1, #0xf2]
	str r7, [r4, #0x1c]
	mov r2, #0
	b _02067C38
_02067C1C:
	ldrh r1, [r4, #0x14]
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #1
	orr r1, r1, #1
	strh r1, [r4, #0x14]
	mov r2, r0, lsr #0x10
_02067C38:
	ldrh r0, [r8, #2]
	cmp r2, r0
	blo _02067C1C
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WH_SetMaxChildCount
	bl WH_Initialize
	ldr r0, _02067CAC // =0x00400342
	bl WH_SetGgid
	ldr r0, _02067CB0 // =WirelessManager__JudgeAcceptFunc
	bl WH_SetJudgeAcceptFunc
	ldr r0, [sp, #0x28]
	cmp r0, #0
	ldrneh r2, [sp, #0x2c]
	cmpne r2, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	ldr r1, _02067CB4 // =WirelessManager__gameInfo
	str r2, [r4, #0x20]
	bl MI_CpuCopy8
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02067C94: .word 0x00001D14
_02067C98: .word WirelessManager__Main3
_02067C9C: .word WirelessManager__Destructor
_02067CA0: .word WirelessManager__sVars
_02067CA4: .word WirelessManager__State_2068DD4
_02067CA8: .word 0x0000FFFF
_02067CAC: .word 0x00400342
_02067CB0: .word WirelessManager__JudgeAcceptFunc
_02067CB4: .word WirelessManager__gameInfo
	arm_func_end WirelessManager__Create4

	arm_func_start WirelessManager__Create5
WirelessManager__Create5: // 0x02067CB8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0xc
	mov r5, r3
	mov r3, #0
	mov r8, r0
	mov r7, r1
	mov r6, r2
	str r3, [sp]
	mov r0, #0xfd
	str r0, [sp, #4]
	ldr r4, _02067DD8 // =0x00001D14
	ldr r0, _02067DDC // =WirelessManager__Main3
	ldr r1, _02067DE0 // =WirelessManager__Destructor
	mov r2, #3
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _02067DE4 // =WirelessManager__sVars
	str r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02067DD8 // =0x00001D14
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	ldr r1, _02067DE8 // =WirelessManager__State_2069498
	mov r0, #2
	str r1, [r4]
	str r0, [r4, #4]
	mov r0, #4
	str r0, [r4, #8]
	add r0, r8, #4
	add r1, r4, #0x2c
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r1, [r8, #0]
	mov r2, #0
	add r0, r4, #0x1900
	strh r1, [r4, #0x5e]
	strh r2, [r0, #0x2a]
	mov r0, #0x19
	strb r0, [r4, #0x16]
	add r0, r4, #0x1a00
	strh r7, [r0, #0xf0]
	strh r6, [r0, #0xf2]
	b _02067D88
_02067D6C:
	ldrh r1, [r4, #0x14]
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #1
	orr r1, r1, #1
	strh r1, [r4, #0x14]
	mov r2, r0, lsr #0x10
_02067D88:
	ldrh r0, [r8, #2]
	cmp r2, r0
	blo _02067D6C
	sub r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WH_SetMaxChildCount
	bl WH_Initialize
	ldr r0, _02067DEC // =0x00400342
	bl WH_SetGgid
	cmp r5, #0
	ldrneh r2, [sp, #0x28]
	cmpne r2, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	ldr r1, _02067DF0 // =Task__Unknown20673B0__byte_2135F20
	mov r0, r5
	bl MI_CpuCopy8
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02067DD8: .word 0x00001D14
_02067DDC: .word WirelessManager__Main3
_02067DE0: .word WirelessManager__Destructor
_02067DE4: .word WirelessManager__sVars
_02067DE8: .word WirelessManager__State_2069498
_02067DEC: .word 0x00400342
_02067DF0: .word Task__Unknown20673B0__byte_2135F20
	arm_func_end WirelessManager__Create5

	arm_func_start WirelessManager__Func_2067DF4
WirelessManager__Func_2067DF4: // 0x02067DF4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	cmp r0, #0
	mov r6, #1
	beq _02067E10
	cmp r0, #1
	beq _02067EB4
	b _02067EC8
_02067E10:
	mov r7, #0
	bl WirelessManager__Func_2068484
	bl WFS_End
	bl WMi_CheckInitialized
	cmp r0, #0
	bne _02067E30
	mov r0, r7
	bl WH_SetReceiver
_02067E30:
	mov r4, #0
	mov r5, r4
_02067E38:
	bl WH_GetSystemState
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02067E9C
_02067E48: // jump table
	b _02067E7C // case 0
	b _02067E74 // case 1
	b _02067E9C // case 2
	b _02067EA0 // case 3
	b _02067E9C // case 4
	b _02067E9C // case 5
	b _02067E9C // case 6
	b _02067E9C // case 7
	b _02067E9C // case 8
	b _02067E84 // case 9
	b _02067E84 // case 10
_02067E74:
	bl WH_End
	b _02067EA0
_02067E7C:
	mov r6, r5
	b _02067EA0
_02067E84:
	add r7, r7, #1
	cmp r7, #3
	movhi r6, r4
	bhi _02067EA0
	bl WH_Reset
	b _02067EA0
_02067E9C:
	bl WH_Finalize
_02067EA0:
	cmp r6, #0
	bne _02067E38
	bl WirelessManager__ClearSendBuffer
	bl WirelessManager__ClearUnknownBuffer
	b _02067EC8
_02067EB4:
	bl WMi_CheckInitialized
	cmp r0, #0
	bne _02067EC8
	mov r0, #0
	bl WH_SetReceiver
_02067EC8:
	ldr r0, _02067EFC // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	bl SetTaskFlags
	ldr r0, _02067EFC // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	bl DestroyTask
	ldr r0, _02067EFC // =WirelessManager__sVars
	mov r1, #0
	str r1, [r0, #0x14]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02067EFC: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2067DF4

	arm_func_start WirelessManager__Func_2067F00
WirelessManager__Func_2067F00: // 0x02067F00
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02067F3C // =WirelessManager__sVars
	mov r5, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	ldrh r0, [r4, #0x10]
	strh r0, [r5]
	bl WirelessManager__Func_2068214
	strh r0, [r5, #2]
	ldrh r0, [r4, #0x12]
	add r0, r0, #1
	orr r0, r0, #0x8000
	strh r0, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02067F3C: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2067F00

	arm_func_start WirelessManager__Func_2067F40
WirelessManager__Func_2067F40: // 0x02067F40
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02067F9C // =WirelessManager__sVars
	mov r5, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x1900
	ldrh r1, [r0, #0x2a]
	mov r0, #0xc8
	mla r0, r1, r0, r4
	ldrh r0, [r0, #0x5e]
	strh r0, [r5]
	bl WirelessManager__Func_2068214
	strh r0, [r5, #2]
	add r0, r4, #0x1900
	ldrh r1, [r0, #0x2a]
	add r2, r4, #0x2c
	mov r0, #0xc8
	mla r0, r1, r0, r2
	add r1, r5, #4
	mov r2, #6
	bl MI_CpuCopy8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02067F9C: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2067F40

	arm_func_start WirelessManager__Create6
WirelessManager__Create6: // 0x02067FA0
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r3, #0
	mov r6, r0
	mov r4, r1
	str r3, [sp]
	mov r0, #0xfd
	ldr r5, _02068048 // =0x00001D14
	str r0, [sp, #4]
	ldr r0, _0206804C // =Task__Unknown2067FA0__Main
	ldr r1, _02068050 // =Task__Unknown2067FA0__Destructor
	mov r2, #3
	str r5, [sp, #8]
	bl TaskCreate_
	ldr r1, _02068054 // =WirelessManager__sVars
	str r0, [r1, #0x14]
	bl GetTaskWork_
	mov r5, r0
	ldr r2, _02068048 // =0x00001D14
	mov r1, r5
	mov r0, #0
	bl MIi_CpuClear16
	ldr r1, _02068058 // =WirelessManager__State_2068994
	mov r0, r6
	str r1, [r5]
	add r1, r5, #0x2f4
	add r1, r1, #0x1800
	mov r2, #3
	str r2, [r5, #4]
	mov r2, #1
	str r2, [r5, #8]
	mov r2, #0x3c
	bl MIi_CpuCopy16
	add r0, r5, #0x1000
	ldr r1, _0206805C // =0x00400342
	str r4, [r0, #0xb30]
	str r1, [r0, #0xb08]
	bl WH_Initialize
	ldr r0, _0206805C // =0x00400342
	bl WH_SetGgid
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02068048: .word 0x00001D14
_0206804C: .word Task__Unknown2067FA0__Main
_02068050: .word Task__Unknown2067FA0__Destructor
_02068054: .word WirelessManager__sVars
_02068058: .word WirelessManager__State_2068994
_0206805C: .word 0x00400342
	arm_func_end WirelessManager__Create6

	arm_func_start WirelessManager__Func_2068060
WirelessManager__Func_2068060: // 0x02068060
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, #1
	bl WH_GetSystemState
	cmp r0, #0
	beq _020680F4
	mov r7, #0
	mov r4, r7
	mov r5, r7
_02068080:
	bl WH_GetSystemState
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _020680E4
_02068090: // jump table
	b _020680C4 // case 0
	b _020680BC // case 1
	b _020680E4 // case 2
	b _020680E8 // case 3
	b _020680E4 // case 4
	b _020680E4 // case 5
	b _020680E4 // case 6
	b _020680E4 // case 7
	b _020680E4 // case 8
	b _020680CC // case 9
	b _020680CC // case 10
_020680BC:
	bl WH_End
	b _020680E8
_020680C4:
	mov r6, r5
	b _020680E8
_020680CC:
	add r7, r7, #1
	cmp r7, #3
	movhi r6, r4
	bhi _020680E8
	bl WH_Reset
	b _020680E8
_020680E4:
	bl WH_Finalize
_020680E8:
	cmp r6, #0
	bne _02068080
	b _02068128
_020680F4:
	mov r4, #0
_020680F8:
	bl MBP_GetState
	cmp r0, #0
	cmpne r0, #5
	beq _02068114
	cmp r0, #6
	beq _02068120
	b _0206811C
_02068114:
	mov r6, r4
	b _02068120
_0206811C:
	bl MBP_Cancel
_02068120:
	cmp r6, #0
	bne _020680F8
_02068128:
	ldr r0, _0206815C // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r1, #0
	bl SetTaskFlags
	ldr r0, _0206815C // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	bl DestroyTask
	ldr r0, _0206815C // =WirelessManager__sVars
	mov r1, #0
	str r1, [r0, #0x14]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206815C: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2068060

	arm_func_start WirelessManager__Func_2068160
WirelessManager__Func_2068160: // 0x02068160
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0206819C // =WirelessManager__sVars
	mov r5, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	mov r4, r0
	ldrh r0, [r4, #0x10]
	strh r0, [r5]
	bl WirelessManager__Func_2068214
	strh r0, [r5, #2]
	ldrh r0, [r4, #0x12]
	add r0, r0, #1
	orr r0, r0, #0x8000
	strh r0, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206819C: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2068160

	arm_func_start WirelessManager__Func_20681A0
WirelessManager__Func_20681A0: // 0x020681A0
	stmdb sp!, {r4, lr}
	ldr r1, _020681CC // =WirelessManager__sVars
	mov r4, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	add r0, r0, #0x334
	add r2, r0, #0x1800
	sub r1, r4, #1
	mov r0, #0x1e
	mla r0, r1, r0, r2
	ldmia sp!, {r4, pc}
	.align 2, 0
_020681CC: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_20681A0

	arm_func_start WirelessManager__Func_20681D0
WirelessManager__Func_20681D0: // 0x020681D0
	stmdb sp!, {r3, lr}
	ldr r0, _020681F4 // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	bl GetTaskWork_
	ldr r1, [r0, #8]
	cmp r1, #2
	moveq r1, #1
	streqb r1, [r0, #0x17]
	ldmia sp!, {r3, pc}
	.align 2, 0
_020681F4: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_20681D0

	arm_func_start WirelessManager__Func_20681F8
WirelessManager__Func_20681F8: // 0x020681F8
	stmdb sp!, {r3, lr}
	ldr r0, _02068210 // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	bl GetTaskWork_
	ldrh r0, [r0, #0x14]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02068210: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_20681F8

	arm_func_start WirelessManager__Func_2068214
WirelessManager__Func_2068214: // 0x02068214
	stmdb sp!, {r3, lr}
	ldr r0, _02068230 // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	bl GetTaskWork_
	ldrh r0, [r0, #0x14]
	bl WirelessManager__Func_2068284
	ldmia sp!, {r3, pc}
	.align 2, 0
_02068230: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2068214

	arm_func_start WirelessManager__Func_2068234
WirelessManager__Func_2068234: // 0x02068234
	stmdb sp!, {r3, lr}
	ldr r0, _02068258 // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	ldr r0, [r0, #4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02068258: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2068234

	arm_func_start WirelessManager__GetStatus
WirelessManager__GetStatus: // 0x0206825C
	stmdb sp!, {r3, lr}
	ldr r0, _02068280 // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	ldr r0, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02068280: .word WirelessManager__sVars
	arm_func_end WirelessManager__GetStatus

	arm_func_start WirelessManager__Func_2068284
WirelessManager__Func_2068284: // 0x02068284
	cmp r0, #0
	mov r1, #0
	beq _020682B0
_02068290:
	tst r0, #1
	addne r1, r1, #1
	mov r0, r0, asr #1
	movne r1, r1, lsl #0x10
	mov r0, r0, lsl #0x10
	movne r1, r1, lsr #0x10
	movs r0, r0, lsr #0x10
	bne _02068290
_020682B0:
	mov r0, r1
	bx lr
	arm_func_end WirelessManager__Func_2068284

	arm_func_start WirelessManager__GetLinkLevel
WirelessManager__GetLinkLevel: // 0x020682B8
	stmdb sp!, {r3, lr}
	bl WMi_CheckInitialized
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r3, pc}
	bl WM_GetLinkLevel
	ldmia sp!, {r3, pc}
	arm_func_end WirelessManager__GetLinkLevel

	arm_func_start WirelessManager__StartMBP
WirelessManager__StartMBP: // 0x020682D4
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldr r1, _02068358 // =WirelessManager__sVars
	mov r4, r0
	ldr r0, [r1, #0xc]
	cmp r0, #0
	bne _02068320
	mov r2, #1
	add r0, sp, #0
	str r2, [r1, #0xc]
	bl RTC_GetTime
	ldr r1, [sp, #8]
	ldr r0, [sp, #4]
	and r2, r1, #0x3f
	mov r1, r0, lsl #0x1c
	ldr r0, _02068358 // =WirelessManager__sVars
	orr r1, r2, r1, lsr #22
	strh r1, [r0]
	b _02068334
_02068320:
	ldrh r2, [r1, #0]
	ldr r0, _0206835C // =0x000003FF
	add r2, r2, #1
	and r0, r2, r0
	strh r0, [r1]
_02068334:
	ldr r0, _02068358 // =WirelessManager__sVars
	and r1, r4, #0x1f
	ldrh r0, [r0, #0]
	mov r0, r0, lsl #0x16
	orr r0, r1, r0, lsr #17
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02068358: .word WirelessManager__sVars
_0206835C: .word 0x000003FF
	arm_func_end WirelessManager__StartMBP

	arm_func_start WirelessManager__Func_2068360
WirelessManager__Func_2068360: // 0x02068360
	stmdb sp!, {r3, lr}
	ldr r0, _0206837C // =WirelessManager__sVars
	ldr r0, [r0, #0x14]
	bl GetTaskWork_
	add r0, r0, #0x1900
	ldrh r0, [r0, #0x28]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206837C: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2068360

	arm_func_start WirelessManager__Func_2068380
WirelessManager__Func_2068380: // 0x02068380
	stmdb sp!, {r4, lr}
	ldr r1, _020683A4 // =WirelessManager__sVars
	mov r4, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	add r1, r0, #0x28
	mov r0, #0xc8
	mla r0, r4, r0, r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_020683A4: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2068380

	arm_func_start WirelessManager__Func_20683A8
WirelessManager__Func_20683A8: // 0x020683A8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r1, _0206842C // =WirelessManager__sVars
	mov r5, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	mov r6, r0
	add r4, r6, #0x1900
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r4, #0x28]
	add r7, r6, #0x28
	mov r8, r0, lsr #0x10
	cmp r1, r0, lsr #16
	bls _02068418
	mov r5, #0xc8
	mov r9, r5
	mov r10, r5
_020683EC:
	sub r2, r8, #1
	mla r0, r8, r9, r7
	mla r1, r2, r10, r7
	mov r2, r5
	bl MIi_CpuCopy16
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	ldrh r1, [r4, #0x28]
	mov r8, r0, lsr #0x10
	cmp r1, r0, lsr #16
	bhi _020683EC
_02068418:
	add r0, r6, #0x1900
	ldrh r1, [r0, #0x28]
	sub r1, r1, #1
	strh r1, [r0, #0x28]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0206842C: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_20683A8

	arm_func_start Task__Unknown2068430__Create
Task__Unknown2068430__Create: // 0x02068430
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r1, #0xf000
	mov r4, r0
	str r1, [sp]
	mov r2, #0xfd
	ldr r0, _02068478 // =Task__Unknown2068430__Main
	ldr r1, _0206847C // =Task__Unknown2068430__Destructor
	str r2, [sp, #4]
	mov r3, #0
	mov r2, #3
	str r3, [sp, #8]
	bl TaskCreate_
	ldr r1, _02068480 // =WirelessManager__sVars
	str r0, [r1, #8]
	str r4, [r1, #4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02068478: .word Task__Unknown2068430__Main
_0206847C: .word Task__Unknown2068430__Destructor
_02068480: .word WirelessManager__sVars
	arm_func_end Task__Unknown2068430__Create

	arm_func_start WirelessManager__Func_2068484
WirelessManager__Func_2068484: // 0x02068484
	stmdb sp!, {r3, lr}
	ldr r0, _020684B0 // =WirelessManager__sVars
	ldr r0, [r0, #8]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	mov r1, #0
	bl SetTaskFlags
	ldr r0, _020684B0 // =WirelessManager__sVars
	ldr r0, [r0, #8]
	bl DestroyTask
	ldmia sp!, {r3, pc}
	.align 2, 0
_020684B0: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2068484

	arm_func_start Task__Unknown2068430__Main
Task__Unknown2068430__Main: // 0x020684B4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	bl WH_GetSystemState
	cmp r0, #5
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	bl WH_GetConnectBitmap
	mov r5, r0
	ldr r0, _020685EC // =WirelessManager__sendBuffer
	mov r1, #0x200
	bl DC_StoreRange
	ldr r0, _020685F0 // =WirelessManager__sVars
	ldr r0, [r0, #0x10]
	tst r0, #1
	beq _020684F4
	ldr r0, _020685EC // =WirelessManager__sendBuffer
	bl WH_StepDS
	b _02068588
_020684F4:
	ldr r4, _020685EC // =WirelessManager__sendBuffer
	b _02068538
_020684FC:
	bl WH_GetErrorCode
	cmp r0, #5
	beq _02068534
	ldr r0, _020685F0 // =WirelessManager__sVars
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0206851C
	blx r0
_0206851C:
	ldr r1, _020685F0 // =WirelessManager__sVars
	mov r2, #0
	mov r0, #2
	str r2, [r1, #4]
	bl WirelessManager__Func_2069838
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02068534:
	bl OS_WaitVBlankIntr
_02068538:
	mov r0, r4
	bl WH_StepDS
	cmp r0, #0
	beq _020684FC
	bl WH_GetCurrentAid
	cmp r0, #0
	bne _02068588
	bl WH_GetConnectBitmap
	cmp r0, r5
	bhs _02068588
	ldr r0, _020685F0 // =WirelessManager__sVars
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _02068574
	blx r0
_02068574:
	ldr r1, _020685F0 // =WirelessManager__sVars
	mov r2, #0
	mov r0, #2
	str r2, [r1, #4]
	bl WirelessManager__Func_2069838
_02068588:
	mov r8, #0
	ldr r5, _020685F4 // =WirelessManager__sendBufferQueue
	mov r4, r8
	ldr r7, _020685F8 // =whConfig_wmMinDataSize
	ldr r6, _020685FC // =whConfig_wmMaxChildCount
	b _020685D8
_020685A0:
	mov r0, r8
	bl WH_GetSharedDataAdr
	cmp r0, #0
	ldrh r2, [r7, #0]
	beq _020685C0
	ldr r1, [r5, r8, lsl #2]
	bl MI_CpuCopy8
	b _020685CC
_020685C0:
	ldr r0, [r5, r8, lsl #2]
	mov r1, r4
	bl MI_CpuFill8
_020685CC:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
_020685D8:
	ldrh r0, [r6, #0]
	add r0, r0, #1
	cmp r8, r0
	blt _020685A0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020685EC: .word WirelessManager__sendBuffer
_020685F0: .word WirelessManager__sVars
_020685F4: .word WirelessManager__sendBufferQueue
_020685F8: .word whConfig_wmMinDataSize
_020685FC: .word whConfig_wmMaxChildCount
	arm_func_end Task__Unknown2068430__Main

	arm_func_start Task__Unknown2068430__Destructor
Task__Unknown2068430__Destructor: // 0x02068600
	ldr r0, _02068610 // =WirelessManager__sVars
	mov r1, #0
	str r1, [r0, #8]
	bx lr
	.align 2, 0
_02068610: .word WirelessManager__sVars
	arm_func_end Task__Unknown2068430__Destructor

	arm_func_start WirelessManager__Func_2068614
WirelessManager__Func_2068614: // 0x02068614
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WirelessManager__ClearSendBuffer
	bl WirelessManager__ClearUnknownBuffer
	ldr r1, _02068670 // =WirelessManager__sendBufferQueue
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClear32
	add r0, r4, #3
	bic r0, r0, #3
	mov r1, r0, lsl #0x10
	ldr ip, _02068674 // =word_21361C0
	mov r3, #0
	ldr r2, _02068670 // =WirelessManager__sendBufferQueue
	b _02068664
_02068650:
	add r0, r3, #1
	mov r0, r0, lsl #0x10
	str ip, [r2, r3, lsl #2]
	add ip, ip, r1, lsr #16
	mov r3, r0, lsr #0x10
_02068664:
	cmp r3, #0x10
	blo _02068650
	ldmia sp!, {r4, pc}
	.align 2, 0
_02068670: .word WirelessManager__sendBufferQueue
_02068674: .word word_21361C0
	arm_func_end WirelessManager__Func_2068614

	arm_func_start WirelessManager__Main1
WirelessManager__Main1: // 0x02068678
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r0, #0
	bl WirelessManager__GetReceiveBuffer
	ldrh r0, [r0, #0]
	strh r0, [r4, #0x14]
	ldrh r0, [r4, #0x1a]
	cmp r0, #0xf0
	bne _020686B4
	add r1, r0, #1
	mov r0, #3
	strh r1, [r4, #0x1a]
	bl WirelessManager__Func_2069838
	b _020686BC
_020686B4:
	addlo r0, r0, #1
	strloh r0, [r4, #0x1a]
_020686BC:
	ldr r1, [r4, #0]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	arm_func_end WirelessManager__Main1

	arm_func_start WirelessManager__Main3
WirelessManager__Main3: // 0x020686CC
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldrh r0, [r4, #0x1a]
	cmp r0, #0x1e0
	bne _020686F8
	add r1, r0, #1
	mov r0, #3
	strh r1, [r4, #0x1a]
	bl WirelessManager__Func_2069838
	b _02068700
_020686F8:
	addlo r0, r0, #1
	strloh r0, [r4, #0x1a]
_02068700:
	ldr r1, [r4, #0]
	mov r0, r4
	blx r1
	ldmia sp!, {r4, pc}
	arm_func_end WirelessManager__Main3

	arm_func_start WirelessManager__Destructor
WirelessManager__Destructor: // 0x02068710
	ldr r0, _02068720 // =WirelessManager__sVars
	mov r1, #0
	str r1, [r0, #0x14]
	bx lr
	.align 2, 0
_02068720: .word WirelessManager__sVars
	arm_func_end WirelessManager__Destructor

	arm_func_start WirelessManager__JudgeAcceptFunc
WirelessManager__JudgeAcceptFunc: // 0x02068724
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02068778 // =WirelessManager__sVars
	mov r4, r0
	ldr r0, [r1, #0x14]
	bl GetTaskWork_
	add r0, r0, #0x12c
	ldrh r1, [r4, #0x10]
	add r2, r0, #0x1800
	mov r0, #0x1e
	sub r1, r1, #1
	mla r5, r1, r0, r2
	mov r1, r5
	add r0, r4, #0xa
	mov r2, #6
	bl MI_CpuCopy8
	add r0, r4, #0x14
	add r1, r5, #6
	mov r2, #0x18
	bl MI_CpuCopy8
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02068778: .word WirelessManager__sVars
	arm_func_end WirelessManager__JudgeAcceptFunc

	arm_func_start WirelessManager__Func_206877C
WirelessManager__Func_206877C: // 0x0206877C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r2, _020688D8 // =WirelessManager__sVars
	mov r10, r0
	ldr r0, [r2, #0x14]
	str r1, [sp]
	bl GetTaskWork_
	ldrb r1, [r10, #0x4b]
	mov r11, r0
	add r5, r11, #0x28
	tst r1, #2
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r11, #0x1900
	ldrh r6, [r0, #0x28]
	cmp r6, #0x20
	ldmhsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r2, [r10, #0x48]
	ldrb r0, [r11, #0x16]
	and r1, r2, #0x1f
	cmp r1, r0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	tst r2, #0x8000
	beq _02068828
	mov r8, #0
	cmp r6, #0
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r7, #6
	mov r4, #0xc8
_020687E8:
	mla r0, r8, r4, r5
	mov r2, r7
	add r0, r0, #4
	add r1, r10, #4
	bl memcmp
	cmp r0, #0
	bne _02068810
	mov r0, r8
	bl WirelessManager__Func_20683A8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02068810:
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	cmp r6, r0, lsr #16
	mov r8, r0, lsr #0x10
	bhi _020687E8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02068828:
	cmp r6, #0
	mov r9, #0
	bls _02068894
	mov r4, #0xc8
_02068838:
	mla r7, r9, r4, r5
	mov r2, #6
	add r0, r7, #4
	add r1, r10, #4
	bl memcmp
	cmp r0, #0
	bne _02068880
	mov r0, r10
	mov r1, r7
	mov r2, #0xc0
	bl MIi_CpuCopy32
	mov r1, r7
	mov r0, #0
	str r0, [r1, #0xc0]
	ldr r0, [sp]
	ldrh r0, [r0, #0x12]
	strh r0, [r1, #0xc4]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02068880:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	cmp r6, r0, lsr #16
	mov r9, r0, lsr #0x10
	bhi _02068838
_02068894:
	mov r0, #0xc8
	mul r4, r9, r0
	mov r0, r10
	add r1, r5, r4
	mov r2, #0xc0
	bl MIi_CpuCopy32
	add r2, r5, r4
	mov r0, #0
	str r0, [r2, #0xc0]
	ldr r0, [sp]
	ldrh r1, [r0, #0x12]
	add r0, r11, #0x1900
	strh r1, [r2, #0xc4]
	ldrh r1, [r0, #0x28]
	add r1, r1, #1
	strh r1, [r0, #0x28]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020688D8: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_206877C

	arm_func_start WirelessManager__Func_20688DC
WirelessManager__Func_20688DC: // 0x020688DC
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _02068940 // =WirelessManager__sVars
	mov r6, r0
	ldr r0, [r2, #0x14]
	mov r5, r1
	bl GetTaskWork_
	ldrb r1, [r6, #0x4b]
	mov r4, r0
	tst r1, #2
	addeq r0, r4, #0x1900
	ldreqh r0, [r0, #0x28]
	cmpeq r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r6
	add r1, r4, #0x28
	mov r2, #0xc0
	bl MIi_CpuCopy32
	mov r0, #0
	str r0, [r4, #0xe8]
	ldrh r2, [r5, #0x12]
	add r0, r4, #0x1900
	mov r1, #1
	strh r2, [r4, #0xec]
	strh r1, [r0, #0x28]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02068940: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_20688DC

	arm_func_start WirelessManager__SendDataCB_2068944
WirelessManager__SendDataCB_2068944: // 0x02068944
	bx lr
	arm_func_end WirelessManager__SendDataCB_2068944

	arm_func_start WirelessManager__ReceiverCB_2068948
WirelessManager__ReceiverCB_2068948: // 0x02068948
	cmp r2, #4
	bxne lr
	ldr r3, _02068968 // =word_21361C0
	mov r1, #1
	ldrh r2, [r3, #2]
	orr r0, r2, r1, lsl r0
	strh r0, [r3, #2]
	bx lr
	.align 2, 0
_02068968: .word word_21361C0
	arm_func_end WirelessManager__ReceiverCB_2068948

	arm_func_start WirelessManager__SendDataCB_206896C
WirelessManager__SendDataCB_206896C: // 0x0206896C
	bx lr
	arm_func_end WirelessManager__SendDataCB_206896C

	arm_func_start WirelessManager__ReceiverCB_2068970
WirelessManager__ReceiverCB_2068970: // 0x02068970
	cmp r2, #4
	bxne lr
	ldrh r2, [r1, #0]
	ldrh r1, [r1, #2]
	ldr r0, _02068990 // =word_21361C0
	strh r2, [r0]
	strh r1, [r0, #2]
	bx lr
	.align 2, 0
_02068990: .word word_21361C0
	arm_func_end WirelessManager__ReceiverCB_2068970

	arm_func_start WirelessManager__State_2068994
WirelessManager__State_2068994: // 0x02068994
	mov r1, #1
	str r1, [r0, #8]
	mov r2, #0
	ldr r1, _020689B0 // =WirelessManager__State_20689B4
	strh r2, [r0, #0x1a]
	str r1, [r0]
	bx lr
	.align 2, 0
_020689B0: .word WirelessManager__State_20689B4
	arm_func_end WirelessManager__State_2068994

	arm_func_start WirelessManager__State_20689B4
WirelessManager__State_20689B4: // 0x020689B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WH_GetSystemState
	cmp r0, #1
	ldmneia sp!, {r4, pc}
	ldr r0, _02068A00 // =WirelessManager__gameInfo
	mov r1, #0x70
	bl WH_SetUserGameInfo
	bl WH_StartMeasureChannel
	cmp r0, #0
	bne _020689EC
	mov r0, #1
	bl WirelessManager__Func_2069838
	ldmia sp!, {r4, pc}
_020689EC:
	mov r1, #0
	ldr r0, _02068A04 // =WirelessManager__State_2068A08
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02068A00: .word WirelessManager__gameInfo
_02068A04: .word WirelessManager__State_2068A08
	arm_func_end WirelessManager__State_20689B4

	arm_func_start WirelessManager__State_2068A08
WirelessManager__State_2068A08: // 0x02068A08
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WH_GetSystemState
	cmp r0, #7
	ldmneia sp!, {r4, pc}
	movs r0, #0
	strh r0, [r4, #0x10]
	bne _02068A30
	bl WH_GetMeasureChannel
	strh r0, [r4, #0x10]
_02068A30:
	ldr r0, [r4, #4]
	cmp r0, #3
	ldreq r0, _02068A70 // =WirelessManager__State_20698CC
	beq _02068A60
	ldrb r0, [r4, #0x16]
	bl WirelessManager__StartMBP
	strh r0, [r4, #0x12]
	ldrh r1, [r4, #0x12]
	ldrh r2, [r4, #0x10]
	mov r0, #4
	bl WH_ParentConnect
	ldr r0, _02068A74 // =WirelessManager__State_2068A78
_02068A60:
	str r0, [r4]
	mov r0, #0
	strh r0, [r4, #0x1a]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02068A70: .word WirelessManager__State_20698CC
_02068A74: .word WirelessManager__State_2068A78
	arm_func_end WirelessManager__State_2068A08

	arm_func_start WirelessManager__State_2068A78
WirelessManager__State_2068A78: // 0x02068A78
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WH_GetSystemState
	bl WH_GetSystemState
	cmp r0, #5
	ldmneia sp!, {r4, pc}
	ldr r0, _02068AB4 // =WirelessManager__Func_2069794
	bl Task__Unknown2068430__Create
	mov r0, #1
	bl WirelessManager__Func_2067AE8
	mov r1, #0
	ldr r0, _02068AB8 // =WirelessManager__State_2068ABC
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02068AB4: .word WirelessManager__Func_2069794
_02068AB8: .word WirelessManager__State_2068ABC
	arm_func_end WirelessManager__State_2068A78

	arm_func_start WirelessManager__State_2068ABC
WirelessManager__State_2068ABC: // 0x02068ABC
	mov r1, #1
	str r1, [r0, #8]
	mov r2, #0
	ldr r1, _02068AD8 // =WirelessManager__State_2068ADC
	strh r2, [r0, #0x1a]
	str r1, [r0]
	bx lr
	.align 2, 0
_02068AD8: .word WirelessManager__State_2068ADC
	arm_func_end WirelessManager__State_2068ABC

	arm_func_start WirelessManager__State_2068ADC
WirelessManager__State_2068ADC: // 0x02068ADC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl WirelessManager__GetSendBuffer
	mov r4, r0
	bl WH_GetConnectBitmap
	strh r0, [r4]
	bl WirelessManager__Func_2068214
	cmp r0, #1
	bls _02068B3C
	mov r0, #2
	str r0, [r5, #8]
	ldrb r0, [r5, #0x17]
	cmp r0, #0
	beq _02068B44
	ldrh r2, [r4, #2]
	mov r0, #0
	ldr r1, _02068B54 // =WirelessManager__State_2068B5C
	orr r2, r2, #1
	strh r2, [r4, #2]
	strh r0, [r5, #0x18]
	ldr r0, _02068B58 // =WirelessManager__Main3
	str r1, [r5]
	bl SetCurrentTaskMainEvent
	b _02068B44
_02068B3C:
	mov r0, #1
	str r0, [r5, #8]
_02068B44:
	mov r0, #0
	strb r0, [r5, #0x17]
	strh r0, [r5, #0x1a]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02068B54: .word WirelessManager__State_2068B5C
_02068B58: .word WirelessManager__Main3
	arm_func_end WirelessManager__State_2068ADC

	arm_func_start WirelessManager__State_2068B5C
WirelessManager__State_2068B5C: // 0x02068B5C
	mov r1, #2
	str r1, [r0, #8]
	mov r2, #0
	ldr r1, _02068B78 // =WirelessManager__State_2068B7C
	strh r2, [r0, #0x1a]
	str r1, [r0]
	bx lr
	.align 2, 0
_02068B78: .word WirelessManager__State_2068B7C
	arm_func_end WirelessManager__State_2068B5C

	arm_func_start WirelessManager__State_2068B7C
WirelessManager__State_2068B7C: // 0x02068B7C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WH_GetConnectBitmap
	bics r0, r0, #1
	ldmneia sp!, {r4, pc}
	bl WirelessManager__GetSendBuffer
	mov r1, r0
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear32
	bl WirelessManager__Func_2068484
	bl WH_Finalize
	mov r1, #0
	ldr r0, _02068BC0 // =WirelessManager__State_2068BC4
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02068BC0: .word WirelessManager__State_2068BC4
	arm_func_end WirelessManager__State_2068B7C

	arm_func_start WirelessManager__State_2068BC4
WirelessManager__State_2068BC4: // 0x02068BC4
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl WH_GetSystemState
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, _02068C68 // =WirelessManager__gameInfo
	mov r1, #0x70
	bl WH_SetUserGameInfo
	ldrh r0, [r4, #0x12]
	orr r0, r0, #0x8000
	strh r0, [r4, #0x12]
	ldr r0, [r4, #4]
	cmp r0, #1
	beq _02068C08
	cmp r0, #2
	beq _02068C30
	b _02068C44
_02068C08:
	ldr r0, _02068C6C // =WirelessManager__Func_2069794
	mov r5, #4
	bl Task__Unknown2068430__Create
	add r0, r4, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WH_SetMinDataSize
	add r0, r4, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WirelessManager__Func_2068614
	b _02068C44
_02068C30:
	add r1, r4, #0x1a00
	ldrh r0, [r1, #0xf0]
	ldrh r1, [r1, #0xf2]
	mov r5, #6
	bl WH_SetMaxParentChildSize
_02068C44:
	ldrh r1, [r4, #0x12]
	ldrh r2, [r4, #0x10]
	mov r0, r5
	bl WH_ParentConnect
	mov r1, #0
	ldr r0, _02068C70 // =WirelessManager__State_2068C74
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02068C68: .word WirelessManager__gameInfo
_02068C6C: .word WirelessManager__Func_2069794
_02068C70: .word WirelessManager__State_2068C74
	arm_func_end WirelessManager__State_2068BC4

	arm_func_start WirelessManager__State_2068C74
WirelessManager__State_2068C74: // 0x02068C74
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	cmp r0, #1
	beq _02068C94
	cmp r0, #2
	beq _02068CA0
	b _02068CAC
_02068C94:
	bl WH_GetConnectBitmap
	mov r6, r0
	b _02068CAC
_02068CA0:
	bl WFS_GetBusyBitmap
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
_02068CAC:
	ldrh r0, [r4, #0x14]
	bl WirelessManager__Func_2068284
	mov r5, r0
	mov r0, r6
	bl WirelessManager__Func_2068284
	cmp r5, r0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #4]
	cmp r0, #1
	beq _02068CE0
	cmp r0, #2
	beq _02068D10
	ldmia sp!, {r4, r5, r6, pc}
_02068CE0:
	bl WirelessManager__GetSendBuffer
	strh r6, [r0]
	ldrh r3, [r0, #2]
	mov r2, #5
	mov r1, #0
	orr r3, r3, #2
	strh r3, [r0, #2]
	strh r2, [r4, #0x18]
	ldr r0, _02068D80 // =WirelessManager__State_206966C
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
_02068D10:
	bl WirelessManager__GetSendBuffer
	mov r5, r0
	bl WFS_GetStatus
	cmp r0, #2
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, _02068D84 // =word_21361C0
	mov r0, #0
	mov r2, #0x240
	bl MIi_CpuClear32
	ldr r0, _02068D88 // =WirelessManager__ReceiverCB_2068948
	bl WH_SetReceiver
	mov r0, r5
	strh r6, [r5]
	mov r2, #1
	mov r1, #4
	strh r2, [r5, #2]
	bl DC_StoreRange
	ldr r2, _02068D8C // =WirelessManager__SendDataCB_2068944
	mov r0, r5
	mov r1, #4
	bl WH_SendData
	mov r0, r6
	bl WFS_EnableSync
	mov r1, #0
	ldr r0, _02068D90 // =WirelessManager__State_2068D94
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02068D80: .word WirelessManager__State_206966C
_02068D84: .word word_21361C0
_02068D88: .word WirelessManager__ReceiverCB_2068948
_02068D8C: .word WirelessManager__SendDataCB_2068944
_02068D90: .word WirelessManager__State_2068D94
	arm_func_end WirelessManager__State_2068C74

	arm_func_start WirelessManager__State_2068D94
WirelessManager__State_2068D94: // 0x02068D94
	ldr r1, _02068DC8 // =word_21361C0
	ldr r2, _02068DCC // =WirelessManager__sendBuffer
	ldrh r1, [r1, #2]
	ldrh r2, [r2, #0]
	orr r1, r1, #1
	cmp r2, r1
	bxne lr
	mov r2, #0
	strh r2, [r0, #0x18]
	ldr r1, _02068DD0 // =WirelessManager__State_206966C
	strh r2, [r0, #0x1a]
	str r1, [r0]
	bx lr
	.align 2, 0
_02068DC8: .word word_21361C0
_02068DCC: .word WirelessManager__sendBuffer
_02068DD0: .word WirelessManager__State_206966C
	arm_func_end WirelessManager__State_2068D94

	arm_func_start WirelessManager__State_2068DD4
WirelessManager__State_2068DD4: // 0x02068DD4
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl WH_GetSystemState
	cmp r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r0, _02068E6C // =WirelessManager__gameInfo
	mov r1, #0x70
	bl WH_SetUserGameInfo
	ldr r0, [r4, #4]
	cmp r0, #1
	beq _02068E0C
	cmp r0, #2
	beq _02068E34
	b _02068E48
_02068E0C:
	ldr r0, _02068E70 // =WirelessManager__Func_2069794
	mov r5, #4
	bl Task__Unknown2068430__Create
	add r0, r4, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WH_SetMinDataSize
	add r0, r4, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WirelessManager__Func_2068614
	b _02068E48
_02068E34:
	add r1, r4, #0x1a00
	ldrh r0, [r1, #0xf0]
	ldrh r1, [r1, #0xf2]
	mov r5, #6
	bl WH_SetMaxParentChildSize
_02068E48:
	ldrh r1, [r4, #0x12]
	ldrh r2, [r4, #0x10]
	mov r0, r5
	bl WH_ParentConnect
	mov r1, #0
	ldr r0, _02068E74 // =WirelessManager__State_2068E78
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02068E6C: .word WirelessManager__gameInfo
_02068E70: .word WirelessManager__Func_2069794
_02068E74: .word WirelessManager__State_2068E78
	arm_func_end WirelessManager__State_2068DD4

	arm_func_start WirelessManager__State_2068E78
WirelessManager__State_2068E78: // 0x02068E78
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	ldr r0, [r6, #4]
	mov r4, #0
	cmp r0, #1
	beq _02068E9C
	cmp r0, #2
	beq _02068EA8
	b _02068EB4
_02068E9C:
	bl WH_GetConnectBitmap
	mov r5, r0
	b _02068EB4
_02068EA8:
	bl WFS_GetBusyBitmap
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
_02068EB4:
	ldr r0, [r6, #0x1c]
	tst r0, #1
	beq _02068EDC
	mov r0, r5
	bl WirelessManager__Func_2068284
	cmp r0, #2
	ldrhsh r1, [r6, #0x1a]
	ldrhs r0, _02068FC0 // =0x000001DF
	cmphs r1, r0
	movhs r4, #1
_02068EDC:
	ldrh r0, [r6, #0x14]
	bl WirelessManager__Func_2068284
	mov r7, r0
	mov r0, r5
	bl WirelessManager__Func_2068284
	cmp r7, r0
	moveq r4, #1
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	strh r5, [r6, #0x14]
	ldr r0, [r6, #4]
	cmp r0, #1
	beq _02068F1C
	cmp r0, #2
	beq _02068F4C
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02068F1C:
	bl WirelessManager__GetSendBuffer
	strh r5, [r0]
	ldrh r3, [r0, #2]
	mov r2, #5
	mov r1, #0
	orr r3, r3, #2
	strh r3, [r0, #2]
	strh r2, [r6, #0x18]
	ldr r0, _02068FC4 // =WirelessManager__State_206966C
	strh r1, [r6, #0x1a]
	str r0, [r6]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02068F4C:
	bl WirelessManager__GetSendBuffer
	mov r4, r0
	bl WFS_GetStatus
	cmp r0, #2
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, _02068FC8 // =word_21361C0
	mov r0, #0
	mov r2, #0x240
	bl MIi_CpuClear32
	ldr r0, _02068FCC // =WirelessManager__ReceiverCB_2068948
	bl WH_SetReceiver
	strh r5, [r4]
	ldrh r2, [r4, #2]
	mov r0, r4
	mov r1, #4
	orr r2, r2, #1
	strh r2, [r4, #2]
	bl DC_StoreRange
	ldr r2, _02068FD0 // =WirelessManager__SendDataCB_2068944
	mov r0, r4
	mov r1, #4
	bl WH_SendData
	mov r0, r5
	bl WFS_EnableSync
	mov r1, #0
	ldr r0, _02068FD4 // =WirelessManager__State_2068FD8
	strh r1, [r6, #0x1a]
	str r0, [r6]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02068FC0: .word 0x000001DF
_02068FC4: .word WirelessManager__State_206966C
_02068FC8: .word word_21361C0
_02068FCC: .word WirelessManager__ReceiverCB_2068948
_02068FD0: .word WirelessManager__SendDataCB_2068944
_02068FD4: .word WirelessManager__State_2068FD8
	arm_func_end WirelessManager__State_2068E78

	arm_func_start WirelessManager__State_2068FD8
WirelessManager__State_2068FD8: // 0x02068FD8
	ldr r1, _02069018 // =word_21361C0
	ldr r2, _0206901C // =WirelessManager__sendBuffer
	ldrh r1, [r1, #2]
	ldrh r2, [r2, #0]
	mov r3, #0
	orr r1, r1, #1
	cmp r2, r1
	moveq r3, #1
	cmp r3, #0
	bxeq lr
	mov r2, #0
	strh r2, [r0, #0x18]
	ldr r1, _02069020 // =WirelessManager__State_206966C
	strh r2, [r0, #0x1a]
	str r1, [r0]
	bx lr
	.align 2, 0
_02069018: .word word_21361C0
_0206901C: .word WirelessManager__sendBuffer
_02069020: .word WirelessManager__State_206966C
	arm_func_end WirelessManager__State_2068FD8

	arm_func_start WirelessManager__State_2069024
WirelessManager__State_2069024: // 0x02069024
	mov r1, #4
	ldr r2, _0206904C // =0x0000FFFF
	str r1, [r0, #8]
	add r1, r0, #0x1900
	strh r2, [r1, #0x2a]
	mov r2, #0
	ldr r1, _02069050 // =WirelessManager__State_2069054
	strh r2, [r0, #0x1a]
	str r1, [r0]
	bx lr
	.align 2, 0
_0206904C: .word 0x0000FFFF
_02069050: .word WirelessManager__State_2069054
	arm_func_end WirelessManager__State_2069024

	arm_func_start WirelessManager__State_2069054
WirelessManager__State_2069054: // 0x02069054
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl WH_GetSystemState
	cmp r0, #1
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r2, _020690D8 // =_021116C0
	ldr r0, _020690DC // =Task__Unknown20673B0__byte_2135F20
	ldrb r1, [r2, #1]
	ldrb r3, [r2, #0]
	ldrb ip, [r2, #2]
	strb r1, [sp, #1]
	strb r3, [sp]
	ldrb r3, [r2, #3]
	mov r1, #0x18
	strb ip, [sp, #2]
	strb r3, [sp, #3]
	ldrb r3, [r2, #4]
	ldrb r2, [r2, #5]
	strb r3, [sp, #4]
	strb r2, [sp, #5]
	bl WH_SetSsid
	ldr r0, _020690E0 // =WirelessManager__Func_206877C
	add r1, sp, #0
	mov r2, #0
	bl WH_StartScan
	mov r1, #0
	ldr r0, _020690E4 // =WirelessManager__State_20690E8
	strh r1, [r4, #0x1a]
	str r0, [r4]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020690D8: .word _021116C0
_020690DC: .word Task__Unknown20673B0__byte_2135F20
_020690E0: .word WirelessManager__Func_206877C
_020690E4: .word WirelessManager__State_20690E8
	arm_func_end WirelessManager__State_2069054

	arm_func_start WirelessManager__State_20690E8
WirelessManager__State_20690E8: // 0x020690E8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r2, r4, #0x1900
	ldrh r0, [r2, #0x28]
	mov lr, #0
	cmp r0, #0
	bls _02069130
	mov r0, #0xc8
_02069108:
	mla ip, lr, r0, r4
	ldr r3, [ip, #0xe8]
	add r1, lr, #1
	add r3, r3, #1
	str r3, [ip, #0xe8]
	ldrh r3, [r2, #0x28]
	mov r1, r1, lsl #0x10
	mov lr, r1, lsr #0x10
	cmp r3, r1, lsr #16
	bhi _02069108
_02069130:
	bl WH_GetSystemState
	cmp r0, #1
	bne _0206917C
	add r2, r4, #0x1900
	ldrh r3, [r2, #0x2a]
	ldr r0, _02069188 // =0x0000FFFF
	cmp r3, r0
	beq _0206917C
	mov r1, #0xc8
	mla r0, r3, r1, r4
	ldrh ip, [r0, #0x70]
	add r3, r4, #0x28
	mov r0, #5
	strh ip, [r4, #0x12]
	ldrh r2, [r2, #0x2a]
	mla r1, r2, r1, r3
	bl WH_ChildConnect
	ldr r0, _0206918C // =WirelessManager__State_2069190
	str r0, [r4]
_0206917C:
	mov r0, #0
	strh r0, [r4, #0x1a]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02069188: .word 0x0000FFFF
_0206918C: .word WirelessManager__State_2069190
	arm_func_end WirelessManager__State_20690E8

	arm_func_start WirelessManager__State_2069190
WirelessManager__State_2069190: // 0x02069190
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WH_GetSystemState
	cmp r0, #5
	ldmneia sp!, {r4, pc}
	ldr r0, _020691C8 // =WirelessManager__Func_2069794
	bl Task__Unknown2068430__Create
	mov r0, #1
	bl WirelessManager__Func_2067AE8
	mov r1, #0
	ldr r0, _020691CC // =WirelessManager__State_20691D0
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020691C8: .word WirelessManager__Func_2069794
_020691CC: .word WirelessManager__State_20691D0
	arm_func_end WirelessManager__State_2069190

	arm_func_start WirelessManager__State_20691D0
WirelessManager__State_20691D0: // 0x020691D0
	mov r1, #5
	str r1, [r0, #8]
	mov r2, #0
	ldr r1, _020691EC // =WirelessManager__State_20691F0
	strh r2, [r0, #0x1a]
	str r1, [r0]
	bx lr
	.align 2, 0
_020691EC: .word WirelessManager__State_20691F0
	arm_func_end WirelessManager__State_20691D0

	arm_func_start WirelessManager__State_20691F0
WirelessManager__State_20691F0: // 0x020691F0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WH_GetSystemState
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, pc}
_02069208: // jump table
	ldmia sp!, {r4, pc} // case 0
	ldmia sp!, {r4, pc} // case 1
	ldmia sp!, {r4, pc} // case 2
	ldmia sp!, {r4, pc} // case 3
	ldmia sp!, {r4, pc} // case 4
	b _02069240 // case 5
	ldmia sp!, {r4, pc} // case 6
	ldmia sp!, {r4, pc} // case 7
	b _02069234 // case 8
	b _02069234 // case 9
	b _02069234 // case 10
_02069234:
	mov r0, #2
	bl WirelessManager__Func_2069838
	ldmia sp!, {r4, pc}
_02069240:
	mov r0, #0
	bl WirelessManager__GetReceiveBuffer
	ldrh r0, [r0, #2]
	tst r0, #1
	beq _02069264
	ldr r0, _02069270 // =WirelessManager__Main3
	bl SetCurrentTaskMainEvent
	ldr r0, _02069274 // =WirelessManager__State_2069278
	str r0, [r4]
_02069264:
	mov r0, #0
	strh r0, [r4, #0x1a]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02069270: .word WirelessManager__Main3
_02069274: .word WirelessManager__State_2069278
	arm_func_end WirelessManager__State_20691F0

	arm_func_start WirelessManager__State_2069278
WirelessManager__State_2069278: // 0x02069278
	mov r1, #5
	str r1, [r0, #8]
	mov r2, #0
	ldr r1, _02069294 // =WirelessManager__State_2069298
	strh r2, [r0, #0x1a]
	str r1, [r0]
	bx lr
	.align 2, 0
_02069294: .word WirelessManager__State_2069298
	arm_func_end WirelessManager__State_2069278

	arm_func_start WirelessManager__State_2069298
WirelessManager__State_2069298: // 0x02069298
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WirelessManager__GetSendBuffer
	mov r1, r0
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear32
	bl WirelessManager__Func_2068484
	bl WH_Finalize
	mov r1, #0
	ldr r0, _020692D0 // =WirelessManager__State_20692D4
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020692D0: .word WirelessManager__State_20692D4
	arm_func_end WirelessManager__State_2069298

	arm_func_start WirelessManager__State_20692D4
WirelessManager__State_20692D4: // 0x020692D4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl WH_GetSystemState
	cmp r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #0
	strh r0, [r6, #0x1a]
	ldrh r0, [r6, #0x18]
	cmp r0, #0xa
	blo _0206939C
	add r0, r6, #0x1900
	ldrh r2, [r0, #0x2a]
	ldr r1, [r6, #4]
	add r3, r6, #0x28
	mov r0, #0xc8
	mla r4, r2, r0, r3
	cmp r1, #1
	beq _02069328
	cmp r1, #2
	beq _02069350
	b _0206937C
_02069328:
	add r0, r6, #0x1a00
	ldrh r0, [r0, #0xee]
	mov r5, #5
	bl WH_SetMinDataSize
	add r0, r6, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WirelessManager__Func_2068614
	ldr r0, _020693A8 // =WirelessManager__Func_2069794
	bl Task__Unknown2068430__Create
	b _0206937C
_02069350:
	add r1, r6, #0x1a00
	ldrh r0, [r1, #0xf0]
	ldrh r1, [r1, #0xf2]
	mov r5, #7
	bl WH_SetMaxParentChildSize
	ldr r1, _020693AC // =word_21361C0
	mov r0, #0
	mov r2, #0x240
	bl MIi_CpuClear32
	ldr r0, _020693B0 // =WirelessManager__ReceiverCB_2068970
	bl WH_SetReceiver
_0206937C:
	ldrh r3, [r4, #0x36]
	ldr r0, _020693B4 // =WirelessManager__Func_20688DC
	mov r1, r5
	add r2, r4, #4
	bl WH_ChildConnectAuto
	ldr r0, _020693B8 // =WirelessManager__State_20693BC
	str r0, [r6]
	ldmia sp!, {r4, r5, r6, pc}
_0206939C:
	add r0, r0, #1
	strh r0, [r6, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020693A8: .word WirelessManager__Func_2069794
_020693AC: .word word_21361C0
_020693B0: .word WirelessManager__ReceiverCB_2068970
_020693B4: .word WirelessManager__Func_20688DC
_020693B8: .word WirelessManager__State_20693BC
	arm_func_end WirelessManager__State_20692D4

	arm_func_start WirelessManager__State_20693BC
WirelessManager__State_20693BC: // 0x020693BC
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl WH_GetSystemState
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, r4, r5, pc}
_020693D4: // jump table
	ldmia sp!, {r3, r4, r5, pc} // case 0
	ldmia sp!, {r3, r4, r5, pc} // case 1
	ldmia sp!, {r3, r4, r5, pc} // case 2
	ldmia sp!, {r3, r4, r5, pc} // case 3
	b _0206943C // case 4
	b _0206940C // case 5
	ldmia sp!, {r3, r4, r5, pc} // case 6
	ldmia sp!, {r3, r4, r5, pc} // case 7
	b _02069400 // case 8
	b _02069400 // case 9
	b _02069400 // case 10
_02069400:
	mov r0, #2
	bl WirelessManager__Func_2069838
	ldmia sp!, {r3, r4, r5, pc}
_0206940C:
	mov r0, #0
	bl WirelessManager__GetReceiveBuffer
	ldrh r0, [r0, #2]
	tst r0, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, #4
	strh r0, [r4, #0x18]
	mov r1, #0
	ldr r0, _0206948C // =WirelessManager__State_206966C
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
_0206943C:
	ldr r5, _02069490 // =word_21361C0
	bl WFS_GetStatus
	cmp r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #2]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, _02069494 // =WirelessManager__SendDataCB_206896C
	mov r0, r5
	mov r1, #4
	bl WH_SendData
	mov r0, #0
	bl WH_SetReceiver
	mov r0, #4
	strh r0, [r4, #0x18]
	mov r1, #0
	ldr r0, _0206948C // =WirelessManager__State_206966C
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206948C: .word WirelessManager__State_206966C
_02069490: .word word_21361C0
_02069494: .word WirelessManager__SendDataCB_206896C
	arm_func_end WirelessManager__State_20693BC

	arm_func_start WirelessManager__State_2069498
WirelessManager__State_2069498: // 0x02069498
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	bl WH_GetSystemState
	cmp r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #0
	strh r0, [r6, #0x1a]
	ldrh r0, [r6, #0x18]
	cmp r0, #0xa
	blo _02069560
	add r0, r6, #0x1900
	ldrh r2, [r0, #0x2a]
	ldr r1, [r6, #4]
	add r3, r6, #0x28
	mov r0, #0xc8
	mla r4, r2, r0, r3
	cmp r1, #1
	beq _020694EC
	cmp r1, #2
	beq _02069514
	b _02069540
_020694EC:
	ldr r0, _0206956C // =WirelessManager__Func_2069794
	mov r5, #5
	bl Task__Unknown2068430__Create
	add r0, r6, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WH_SetMinDataSize
	add r0, r6, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WirelessManager__Func_2068614
	b _02069540
_02069514:
	add r1, r6, #0x1a00
	ldrh r0, [r1, #0xf0]
	ldrh r1, [r1, #0xf2]
	mov r5, #7
	bl WH_SetMaxParentChildSize
	ldr r1, _02069570 // =word_21361C0
	mov r0, #0
	mov r2, #0x240
	bl MIi_CpuClear32
	ldr r0, _02069574 // =WirelessManager__ReceiverCB_2068970
	bl WH_SetReceiver
_02069540:
	ldrh r3, [r4, #0x36]
	ldr r0, _02069578 // =WirelessManager__Func_20688DC
	mov r1, r5
	add r2, r4, #4
	bl WH_ChildConnectAuto
	ldr r0, _0206957C // =WirelessManager__State_2069580
	str r0, [r6]
	ldmia sp!, {r4, r5, r6, pc}
_02069560:
	add r0, r0, #1
	strh r0, [r6, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0206956C: .word WirelessManager__Func_2069794
_02069570: .word word_21361C0
_02069574: .word WirelessManager__ReceiverCB_2068970
_02069578: .word WirelessManager__Func_20688DC
_0206957C: .word WirelessManager__State_2069580
	arm_func_end WirelessManager__State_2069498

	arm_func_start WirelessManager__State_2069580
WirelessManager__State_2069580: // 0x02069580
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl WH_GetSystemState
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, r4, r5, pc}
_02069598: // jump table
	ldmia sp!, {r3, r4, r5, pc} // case 0
	ldmia sp!, {r3, r4, r5, pc} // case 1
	ldmia sp!, {r3, r4, r5, pc} // case 2
	ldmia sp!, {r3, r4, r5, pc} // case 3
	b _02069608 // case 4
	b _020695D0 // case 5
	ldmia sp!, {r3, r4, r5, pc} // case 6
	ldmia sp!, {r3, r4, r5, pc} // case 7
	b _020695C4 // case 8
	b _020695C4 // case 9
	b _020695C4 // case 10
_020695C4:
	mov r0, #2
	bl WirelessManager__Func_2069838
	ldmia sp!, {r3, r4, r5, pc}
_020695D0:
	mov r0, #0
	bl WirelessManager__GetReceiveBuffer
	ldrh r1, [r0, #2]
	tst r1, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r2, [r0, #0]
	mov r0, #4
	mov r1, #0
	strh r2, [r4, #0x14]
	strh r0, [r4, #0x18]
	ldr r0, _02069660 // =WirelessManager__State_206966C
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
_02069608:
	ldr r5, _02069664 // =word_21361C0
	bl WFS_GetStatus
	cmp r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [r5, #2]
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r2, _02069668 // =WirelessManager__SendDataCB_206896C
	mov r0, r5
	mov r1, #4
	bl WH_SendData
	mov r0, #0
	bl WH_SetReceiver
	ldrh r2, [r5, #0]
	mov r0, #4
	mov r1, #0
	strh r2, [r4, #0x14]
	strh r0, [r4, #0x18]
	ldr r0, _02069660 // =WirelessManager__State_206966C
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02069660: .word WirelessManager__State_206966C
_02069664: .word word_21361C0
_02069668: .word WirelessManager__SendDataCB_206896C
	arm_func_end WirelessManager__State_2069580

	arm_func_start WirelessManager__State_206966C
WirelessManager__State_206966C: // 0x0206966C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	bl WirelessManager__Func_2067AE8
	add r0, r4, #0x1a00
	ldrh r0, [r0, #0xee]
	bl WirelessManager__Func_2068614
	mov r1, #0
	ldr r0, _0206969C // =WirelessManager__State_20696A0
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206969C: .word WirelessManager__State_20696A0
	arm_func_end WirelessManager__State_206966C

	arm_func_start WirelessManager__State_20696A0
WirelessManager__State_20696A0: // 0x020696A0
	ldrh r1, [r0, #0x18]
	cmp r1, #0
	subne r1, r1, #1
	strneh r1, [r0, #0x18]
	moveq r1, #6
	streq r1, [r0, #8]
	mov r1, #0
	strh r1, [r0, #0x1a]
	bx lr
	arm_func_end WirelessManager__State_20696A0

	arm_func_start WirelessManager__State_20696C4
WirelessManager__State_20696C4: // 0x020696C4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	ldr r0, [r4, #8]
	cmp r0, #7
	beq _02069788
	mov r0, #7
	str r0, [r4, #8]
	mov r7, #1
	mov r8, #0
	bl WirelessManager__Func_2068484
	bl WFS_End
	bl WMi_CheckInitialized
	cmp r0, #0
	bne _02069704
	mov r0, r8
	bl WH_SetReceiver
_02069704:
	mov r5, #0
	mov r6, r5
_0206970C:
	bl WH_GetSystemState
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _02069774
_0206971C: // jump table
	b _02069750 // case 0
	b _02069748 // case 1
	b _02069774 // case 2
	b _02069778 // case 3
	b _02069774 // case 4
	b _02069774 // case 5
	b _02069774 // case 6
	b _02069774 // case 7
	b _02069774 // case 8
	b _02069758 // case 9
	b _0206976C // case 10
_02069748:
	bl WH_End
	b _02069778
_02069750:
	mov r7, r6
	b _02069778
_02069758:
	add r8, r8, #1
	cmp r8, #3
	bhi _0206976C
	bl WH_Reset
	b _02069778
_0206976C:
	mov r7, r5
	b _02069778
_02069774:
	bl WH_Finalize
_02069778:
	cmp r7, #0
	bne _0206970C
	bl WirelessManager__ClearSendBuffer
	bl WirelessManager__ClearUnknownBuffer
_02069788:
	mov r0, #0
	strh r0, [r4, #0x1a]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end WirelessManager__State_20696C4

	arm_func_start WirelessManager__Func_2069794
WirelessManager__Func_2069794: // 0x02069794
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl WirelessManager__Func_2068484
	mov r7, #0
	ldr r0, _02069834 // =WirelessManager__sVars
	mov r6, #1
	str r7, [r0, #4]
	mov r4, r7
	mov r5, r7
_020697B4:
	bl WH_GetSystemState
	cmp r0, #0xa
	addls pc, pc, r0, lsl #2
	b _0206981C
_020697C4: // jump table
	b _020697F8 // case 0
	b _020697F0 // case 1
	b _0206981C // case 2
	b _02069820 // case 3
	b _0206981C // case 4
	b _0206981C // case 5
	b _0206981C // case 6
	b _0206981C // case 7
	b _0206981C // case 8
	b _02069800 // case 9
	b _02069814 // case 10
_020697F0:
	bl WH_End
	b _02069820
_020697F8:
	mov r6, r5
	b _02069820
_02069800:
	add r7, r7, #1
	cmp r7, #3
	bhi _02069814
	bl WH_Reset
	b _02069820
_02069814:
	mov r6, r4
	b _02069820
_0206981C:
	bl WH_Finalize
_02069820:
	cmp r6, #0
	bne _020697B4
	mov r0, #2
	bl WirelessManager__Func_2069838
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02069834: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2069794

	arm_func_start WirelessManager__Func_2069838
WirelessManager__Func_2069838: // 0x02069838
	stmdb sp!, {r4, lr}
	ldr r1, _02069864 // =WirelessManager__sVars
	mov r4, r0
	ldr r0, [r1, #0x14]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl GetTaskWork_
	ldr r1, _02069868 // =WirelessManager__State_20696C4
	str r4, [r0, #0xc]
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02069864: .word WirelessManager__sVars
_02069868: .word WirelessManager__State_20696C4
	arm_func_end WirelessManager__Func_2069838

	arm_func_start Task__Unknown2067FA0__Main
Task__Unknown2067FA0__Main: // 0x0206986C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldrh r0, [r4, #0x1a]
	cmp r0, #0xf0
	bne _02069898
	add r1, r0, #1
	mov r0, #3
	strh r1, [r4, #0x1a]
	bl WirelessManager__Func_2069838
	b _020698A0
_02069898:
	addlo r0, r0, #1
	strloh r0, [r4, #0x1a]
_020698A0:
	ldr r1, [r4, #0]
	mov r0, r4
	blx r1
	mov r0, #0
	strb r0, [r4, #0x17]
	ldmia sp!, {r4, pc}
	arm_func_end Task__Unknown2067FA0__Main

	arm_func_start Task__Unknown2067FA0__Destructor
Task__Unknown2067FA0__Destructor: // 0x020698B8
	ldr r0, _020698C8 // =WirelessManager__sVars
	mov r1, #0
	str r1, [r0, #0x14]
	bx lr
	.align 2, 0
_020698C8: .word WirelessManager__sVars
	arm_func_end Task__Unknown2067FA0__Destructor

	arm_func_start WirelessManager__State_20698CC
WirelessManager__State_20698CC: // 0x020698CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WH_End
	ldr r0, _020698E4 // =WirelessManager__State_20698E8
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020698E4: .word WirelessManager__State_20698E8
	arm_func_end WirelessManager__State_20698CC

	arm_func_start WirelessManager__State_20698E8
WirelessManager__State_20698E8: // 0x020698E8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WH_GetSystemState
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r1, #0
	ldr r0, _02069910 // =WirelessManager__State_2069914
	strh r1, [r4, #0x1a]
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02069910: .word WirelessManager__State_2069914
	arm_func_end WirelessManager__State_20698E8

	arm_func_start WirelessManager__State_2069914
WirelessManager__State_2069914: // 0x02069914
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x18
	bl WirelessManager__StartMBP
	strh r0, [r4, #0x12]
	add r0, r4, #0x1000
	ldrh r1, [r4, #0x12]
	ldr r0, [r0, #0xb08]
	bl MBP_Init
	add r0, r4, #0xf6
	add r1, r0, #0x1c00
	mov r0, #0
	mov r2, #0x1e
	bl MIi_CpuClear16
	ldr r1, _02069960 // =WirelessManager__State_2069964
	mov r0, r4
	str r1, [r4]
	blx r1
	ldmia sp!, {r4, pc}
	.align 2, 0
_02069960: .word WirelessManager__State_2069964
	arm_func_end WirelessManager__State_2069914

	arm_func_start WirelessManager__State_2069964
WirelessManager__State_2069964: // 0x02069964
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r0, #5
	ldrh r6, [r8, #0x14]
	bl MBP_GetChildBmp
	mov r4, r0
	mov r0, #4
	bl MBP_GetChildBmp
	mov r7, r0
	mov r0, #2
	bl MBP_GetChildBmp
	mov r5, r0
	mov r0, #3
	bl MBP_GetChildBmp
	orr r0, r5, r0
	orr r0, r7, r0
	orr r0, r4, r0
	orr r0, r0, #1
	add r1, r8, #0x334
	strh r0, [r8, #0x14]
	ldr r2, _02069B88 // =0x000001C2
	mov r0, #0
	add r1, r1, #0x1800
	bl MIi_CpuClear16
	mov r7, #1
	mov r5, #0
	mov r4, #0x1e
_020699D0:
	mov r0, r7
	bl MBP_GetChildInfo
	cmp r0, #0
	beq _02069A1C
	mla r1, r7, r4, r8
	add r1, r1, #0x16
	add ip, r1, #0x1b00
	mov r3, #7
_020699F0:
	ldrh r2, [r0, #0]
	ldrh r1, [r0, #2]
	add r0, r0, #4
	subs r3, r3, #1
	strh r2, [ip]
	strh r1, [ip, #2]
	add ip, ip, #4
	bne _020699F0
	ldrh r0, [r0, #0]
	strh r0, [ip]
	b _02069A28
_02069A1C:
	add r0, r8, r7, lsl #1
	add r0, r0, #0x1c00
	strh r5, [r0, #0xf4]
_02069A28:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0xf
	bls _020699D0
	mov r0, #1
	str r0, [r8, #8]
	bl MBP_GetState
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02069A54: // jump table
	ldmia sp!, {r4, r5, r6, r7, r8, pc} // case 0
	b _02069A74 // case 1
	b _02069A90 // case 2
	b _02069AC4 // case 3
	b _02069B40 // case 4
	b _02069B54 // case 5
	ldmia sp!, {r4, r5, r6, r7, r8, pc} // case 6
	b _02069B70 // case 7
_02069A74:
	mov r0, #0
	strh r0, [r8, #0x1a]
	ldrh r1, [r8, #0x10]
	add r0, r8, #0x2f4
	add r0, r0, #0x1800
	bl MBP_Start
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02069A90:
	ldrh r0, [r8, #0x14]
	bics r0, r0, #1
	beq _02069AB4
	mov r0, #2
	str r0, [r8, #8]
	ldrb r0, [r8, #0x17]
	cmp r0, #0
	beq _02069AB4
	bl MBP_StartDownloadAll
_02069AB4:
	mov r0, #0
	strh r0, [r8, #0x18]
	strh r0, [r8, #0x1a]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02069AC4:
	mov r0, #3
	str r0, [r8, #8]
	ldrh r1, [r8, #0x14]
	cmp r1, #1
	bne _02069AF4
	mov r0, #0xf0
	strh r0, [r8, #0x1a]
	mov r0, #7
	str r0, [r8, #8]
	mov r0, #2
	str r0, [r8, #0xc]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02069AF4:
	add r0, r8, #0x1000
	ldr r0, [r0, #0xb30]
	tst r0, #1
	cmpne r6, r1
	beq _02069B24
	mov r0, #0xf0
	strh r0, [r8, #0x1a]
	mov r0, #7
	str r0, [r8, #8]
	mov r0, #2
	str r0, [r8, #0xc]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02069B24:
	bl MBP_IsBootableAll
	cmp r0, #0
	beq _02069B34
	bl MBP_StartRebootAll
_02069B34:
	mov r0, #0
	strh r0, [r8, #0x1a]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02069B40:
	mov r0, #3
	str r0, [r8, #8]
	mov r0, #0
	strh r0, [r8, #0x1a]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02069B54:
	mov r0, #6
	str r0, [r8, #8]
	mov r1, #0
	ldr r0, _02069B8C // =WirelessManager__State_2069B90
	strh r1, [r8, #0x1a]
	str r0, [r8]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_02069B70:
	mov r0, #7
	str r0, [r8, #8]
	mov r0, #3
	str r0, [r8, #0xc]
	bl MBP_Cancel
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02069B88: .word 0x000001C2
_02069B8C: .word WirelessManager__State_2069B90
	arm_func_end WirelessManager__State_2069964

	arm_func_start WirelessManager__State_2069B90
WirelessManager__State_2069B90: // 0x02069B90
	mov r1, #0
	strh r1, [r0, #0x1a]
	bx lr
	arm_func_end WirelessManager__State_2069B90

	.rodata

.public _021116C0
_021116C0: // 0x021116C0
    .byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
    .align 4