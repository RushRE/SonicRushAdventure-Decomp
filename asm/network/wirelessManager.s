	.include "asm/macros.inc"
	.include "global.inc"

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
	ldr r2, _02067374 // =whConfig+0x00000020
	str r3, [r2]
	b _020671F0
_02067184:
	ldr r3, _02067378 // =_AllocTailHEAP_SYSTEM
	ldr r2, _02067374 // =whConfig+0x00000020
	str r3, [r2]
	b _020671F0
_02067194:
	ldr r3, _0206737C // =_AllocHeadHEAP_USER
	ldr r2, _02067374 // =whConfig+0x00000020
	str r3, [r2]
	b _020671F0
_020671A4:
	ldr r3, _02067380 // =_AllocTailHEAP_USER
	ldr r2, _02067374 // =whConfig+0x00000020
	str r3, [r2]
	b _020671F0
_020671B4:
	ldr r3, _02067384 // =_AllocHeadHEAP_ITCM
	ldr r2, _02067374 // =whConfig+0x00000020
	str r3, [r2]
	b _020671F0
_020671C4:
	ldr r3, _02067388 // =_AllocTailHEAP_ITCM
	ldr r2, _02067374 // =whConfig+0x00000020
	str r3, [r2]
	b _020671F0
_020671D4:
	ldr r3, _0206738C // =_AllocHeadHEAP_DTCM
	ldr r2, _02067374 // =whConfig+0x00000020
	str r3, [r2]
	b _020671F0
_020671E4:
	ldr r3, _02067390 // =_AllocTailHEAP_DTCM
	ldr r2, _02067374 // =whConfig+0x00000020
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
	ldr r0, _02067398 // =whConfig+0x00000040
	str r2, [r0]
	b _02067258
_0206722C:
	ldr r2, _0206739C // =_FreeHEAP_USER
	ldr r0, _02067398 // =whConfig+0x00000040
	str r2, [r0]
	b _02067258
_0206723C:
	ldr r2, _020673A0 // =_FreeHEAP_ITCM
	ldr r0, _02067398 // =whConfig+0x00000040
	str r2, [r0]
	b _02067258
_0206724C:
	ldr r2, _020673A4 // =_FreeHEAP_DTCM
	ldr r0, _02067398 // =whConfig+0x00000040
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
_02067374: .word whConfig+0x00000020
_02067378: .word _AllocTailHEAP_SYSTEM
_0206737C: .word _AllocHeadHEAP_USER
_02067380: .word _AllocTailHEAP_USER
_02067384: .word _AllocHeadHEAP_ITCM
_02067388: .word _AllocTailHEAP_ITCM
_0206738C: .word _AllocHeadHEAP_DTCM
_02067390: .word _AllocTailHEAP_DTCM
_02067394: .word _FreeHEAP_SYSTEM
_02067398: .word whConfig+0x00000040
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

	arm_func_start Task__Unknown20674C4__Create
Task__Unknown20674C4__Create: // 0x020674C4
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
	arm_func_end Task__Unknown20674C4__Create

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

	arm_func_start MultibootManager__Func_206789C
MultibootManager__Func_206789C: // 0x0206789C
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
	bl MultibootManager__Func_2067B50
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
	arm_func_end MultibootManager__Func_206789C

	arm_func_start MultibootManager__Func_20679A8
MultibootManager__Func_20679A8: // 0x020679A8
	ldr ip, _020679B0 // =WirelessManager__Func_2068360
	bx ip
	.align 2, 0
_020679B0: .word WirelessManager__Func_2068360
	arm_func_end MultibootManager__Func_20679A8

	arm_func_start MultibootManager__Func_20679B4
MultibootManager__Func_20679B4: // 0x020679B4
	ldr ip, _020679BC // =WirelessManager__Func_2068380
	bx ip
	.align 2, 0
_020679BC: .word WirelessManager__Func_2068380
	arm_func_end MultibootManager__Func_20679B4

	arm_func_start MultibootManager__Func_20679C0
MultibootManager__Func_20679C0: // 0x020679C0
	ldr ip, _020679C8 // =WirelessManager__Func_20683A8
	bx ip
	.align 2, 0
_020679C8: .word WirelessManager__Func_20683A8
	arm_func_end MultibootManager__Func_20679C0

	arm_func_start MultibootManager__Func_20679CC
MultibootManager__Func_20679CC: // 0x020679CC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WirelessManager__GetField8
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
	arm_func_end MultibootManager__Func_20679CC

	arm_func_start MultibootManager__Func_2067A18
MultibootManager__Func_2067A18: // 0x02067A18
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
	arm_func_end MultibootManager__Func_2067A18

	arm_func_start MultibootManager__Func_2067A48
MultibootManager__Func_2067A48: // 0x02067A48
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
	arm_func_end MultibootManager__Func_2067A48

	arm_func_start MultibootManager__Func_2067A88
MultibootManager__Func_2067A88: // 0x02067A88
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
	arm_func_end MultibootManager__Func_2067A88

	arm_func_start MultibootManager__Func_2067AE8
MultibootManager__Func_2067AE8: // 0x02067AE8
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
	arm_func_end MultibootManager__Func_2067AE8

	arm_func_start WirelessManager__GetSendBuffer
WirelessManager__GetSendBuffer: // 0x02067B18
	ldr r0, _02067B20 // =WirelessManager__sendBuffer
	bx lr
	.align 2, 0
_02067B20: .word WirelessManager__sendBuffer
	arm_func_end WirelessManager__GetSendBuffer

	arm_func_start WirelessManager__GetRecieveBuffer
WirelessManager__GetRecieveBuffer: // 0x02067B24
	ldr r1, _02067B30 // =WirelessManager__sendBufferQueue
	ldr r0, [r1, r0, lsl #2]
	bx lr
	.align 2, 0
_02067B30: .word WirelessManager__sendBufferQueue
	arm_func_end WirelessManager__GetRecieveBuffer

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

	arm_func_start MultibootManager__Func_2067B50
MultibootManager__Func_2067B50: // 0x02067B50
	ldr ip, _02067B64 // =MIi_CpuClear32
	ldr r1, _02067B68 // =word_21361C0
	mov r0, #0
	mov r2, #0x240
	bx ip
	.align 2, 0
_02067B64: .word MIi_CpuClear32
_02067B68: .word word_21361C0
	arm_func_end MultibootManager__Func_2067B50

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
	bl MultibootManager__Func_2067B50
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

	arm_func_start Task__Unknown2067FA0__Create
Task__Unknown2067FA0__Create: // 0x02067FA0
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
	arm_func_end Task__Unknown2067FA0__Create

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

	arm_func_start WirelessManager__GetField8
WirelessManager__GetField8: // 0x0206825C
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
	arm_func_end WirelessManager__GetField8

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
	bl MultibootManager__Func_2069838
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
	bl MultibootManager__Func_2069838
_02068588:
	mov r8, #0
	ldr r5, _020685F4 // =WirelessManager__sendBufferQueue
	mov r4, r8
	ldr r7, _020685F8 // =whConfig+0x0000000C
	ldr r6, _020685FC // =whConfig+0x00000010
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
_020685F8: .word whConfig+0x0000000C
_020685FC: .word whConfig+0x00000010
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
	bl MultibootManager__Func_2067B50
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
	bl WirelessManager__GetRecieveBuffer
	ldrh r0, [r0, #0]
	strh r0, [r4, #0x14]
	ldrh r0, [r4, #0x1a]
	cmp r0, #0xf0
	bne _020686B4
	add r1, r0, #1
	mov r0, #3
	strh r1, [r4, #0x1a]
	bl MultibootManager__Func_2069838
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
	bl MultibootManager__Func_2069838
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
	bl MultibootManager__Func_2069838
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
	bl MultibootManager__Func_2067AE8
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
	bl MultibootManager__Func_2067AE8
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
	bl MultibootManager__Func_2069838
	ldmia sp!, {r4, pc}
_02069240:
	mov r0, #0
	bl WirelessManager__GetRecieveBuffer
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
	bl MultibootManager__Func_2069838
	ldmia sp!, {r3, r4, r5, pc}
_0206940C:
	mov r0, #0
	bl WirelessManager__GetRecieveBuffer
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
	bl MultibootManager__Func_2069838
	ldmia sp!, {r3, r4, r5, pc}
_020695D0:
	mov r0, #0
	bl WirelessManager__GetRecieveBuffer
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
	bl MultibootManager__Func_2067AE8
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
	bl MultibootManager__Func_2067B50
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
	bl MultibootManager__Func_2069838
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02069834: .word WirelessManager__sVars
	arm_func_end WirelessManager__Func_2069794

	arm_func_start MultibootManager__Func_2069838
MultibootManager__Func_2069838: // 0x02069838
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
	arm_func_end MultibootManager__Func_2069838

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
	bl MultibootManager__Func_2069838
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

	arm_func_start WH_GetWMErrCodeName
WH_GetWMErrCodeName: // 0x02069B9C
	cmp r0, #0
	blt _02069BB4
	cmp r0, #0x17
	ldrlo r1, _02069BBC // =WH__errnames
	ldrlo r0, [r1, r0, lsl #2]
	bxlo lr
_02069BB4:
	ldr r0, _02069BC0 // =aNA_0
	bx lr
	.align 2, 0
_02069BBC: .word WH__errnames
_02069BC0: .word aNA_0
	arm_func_end WH_GetWMErrCodeName

	arm_func_start WH_GetWMStateCodeName
WH_GetWMStateCodeName: // 0x02069BC4
	cmp r0, #0x1b
	ldrlo r1, _02069BD8 // =WH__statenames
	ldrlo r0, [r1, r0, lsl #2]
	ldrhs r0, _02069BDC // =0x0211A5C4
	bx lr
	.align 2, 0
_02069BD8: .word WH__statenames
_02069BDC: .word 0x0211A5C4
	arm_func_end WH_GetWMStateCodeName

	arm_func_start WH_ChangeSysState
WH_ChangeSysState: // 0x02069BE0
	stmdb sp!, {r4, lr}
	ldr r1, _02069C34 // =whConfig
	mov r4, r0
	ldr r3, [r1, #0x44]
	cmp r3, #0
	beq _02069C0C
	ldr r2, [r1, #0x1c]
	ldr r1, _02069C38 // =WH__sStateNames
	ldr r0, _02069C3C // =aS
	ldr r1, [r1, r2, lsl #2]
	blx r3
_02069C0C:
	ldr r0, _02069C34 // =whConfig
	str r4, [r0, #0x1c]
	ldr r2, [r0, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _02069C38 // =WH__sStateNames
	ldr r0, _02069C40 // =0x0211A5D0
	ldr r1, [r1, r4, lsl #2]
	blx r2
	ldmia sp!, {r4, pc}
	.align 2, 0
_02069C34: .word whConfig
_02069C38: .word WH__sStateNames
_02069C3C: .word aS
_02069C40: .word 0x0211A5D0
	arm_func_end WH_ChangeSysState

	arm_func_start WH_SetError
WH_SetError: // 0x02069C44
	ldr r1, _02069C5C // =whConfig
	ldr r2, [r1, #0x1c]
	sub r2, r2, #9
	cmp r2, #1
	strhi r0, [r1, #0x4c]
	bx lr
	.align 2, 0
_02069C5C: .word whConfig
	arm_func_end WH_SetError

	arm_func_start WH_Alloc
WH_Alloc: // 0x02069C60
	stmdb sp!, {r3, lr}
	cmp r2, #0
	bne _02069C84
	ldr r0, _02069C9C // =whConfig
	add r2, r1, #3
	ldr r1, [r0, #0x20]
	bic r0, r2, #3
	blx r1
	ldmia sp!, {r3, pc}
_02069C84:
	ldr r1, _02069C9C // =whConfig
	mov r0, r2
	ldr r1, [r1, #0x40]
	blx r1
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069C9C: .word whConfig
	arm_func_end WH_Alloc

	arm_func_start WH_Free
WH_Free: // 0x02069CA0
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #0]
	cmp r1, #0xe
	ldmneia sp!, {r3, pc}
	ldrh r0, [r0, #4]
	cmp r0, #0xa
	ldmneia sp!, {r3, pc}
	ldr r0, _02069CDC // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _02069CD4
	ldr r0, _02069CE0 // =aWhCallbackforw
	blx r1
_02069CD4:
	bl WFS_Start
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069CDC: .word whConfig
_02069CE0: .word aWhCallbackforw
	arm_func_end WH_Free

	arm_func_start WH_StateInSetParentParam
WH_StateInSetParentParam: // 0x02069CE4
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _02069D1C // =WH_StateOutSetParentParam
	ldr r1, _02069D20 // =sParentParam
	bl WM_SetParentParameter
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069D1C: .word WH_StateOutSetParentParam
_02069D20: .word sParentParam
	arm_func_end WH_StateInSetParentParam

	arm_func_start WH_StateOutSetParentParam
WH_StateOutSetParentParam: // 0x02069D24
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _02069D44
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_02069D44:
	ldr r0, _02069D84 // =whConfig
	ldr r0, [r0, #0x30]
	cmp r0, #0
	beq _02069D6C
	bl WH_StateInSetParentWEPKey
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_02069D6C:
	bl WH_StateInStartParent
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069D84: .word whConfig
	arm_func_end WH_StateOutSetParentParam

	arm_func_start WH_StateInSetParentWEPKey
WH_StateInSetParentWEPKey: // 0x02069D88
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r1, _02069DD8 // =whConfig
	ldr r0, _02069DDC // =sWEPKey
	ldr r2, [r1, #0x30]
	ldr r1, _02069DE0 // =sParentParam
	blx r2
	mov r1, r0
	ldr r0, _02069DE4 // =WH_StateOutSetParentWEPKey
	ldr r2, _02069DDC // =sWEPKey
	bl WM_SetWEPKey
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069DD8: .word whConfig
_02069DDC: .word sWEPKey
_02069DE0: .word sParentParam
_02069DE4: .word WH_StateOutSetParentWEPKey
	arm_func_end WH_StateInSetParentWEPKey

	arm_func_start WH_StateOutSetParentWEPKey
WH_StateOutSetParentWEPKey: // 0x02069DE8
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _02069E08
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_02069E08:
	bl WH_StateInStartParent
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	arm_func_end WH_StateOutSetParentWEPKey

	arm_func_start WH_StateInStartParent
WH_StateInStartParent: // 0x02069E20
	stmdb sp!, {r3, lr}
	ldr r0, _02069E70 // =whConfig
	ldr r0, [r0, #0x1c]
	sub r0, r0, #4
	cmp r0, #2
	movls r0, #1
	ldmlsia sp!, {r3, pc}
	ldr r0, _02069E74 // =WH_StateOutStartParent
	bl WM_StartParent
	cmp r0, #2
	beq _02069E58
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_02069E58:
	ldr r1, _02069E70 // =whConfig
	mov r0, #0
	strh r0, [r1, #8]
	mov r0, #1
	strh r0, [r1, #2]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069E70: .word whConfig
_02069E74: .word WH_StateOutStartParent
	arm_func_end WH_StateInStartParent

	arm_func_start WH_StateOutStartParent
WH_StateOutStartParent: // 0x02069E78
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldrh r1, [r4, #0x10]
	ldrh r0, [r4, #2]
	mov r2, #1
	mov r2, r2, lsl r1
	cmp r0, #0
	mov r5, r2, lsl #0x10
	beq _02069EAC
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, r4, r5, pc}
_02069EAC:
	ldrh r3, [r4, #8]
	cmp r3, #7
	bgt _02069EDC
	bge _02069EF8
	cmp r3, #2
	bgt _02069FF0
	cmp r3, #0
	blt _02069FF0
	beq _02069FD8
	cmp r3, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	b _02069FF0
_02069EDC:
	cmp r3, #9
	bgt _02069EEC
	beq _02069F84
	b _02069FF0
_02069EEC:
	cmp r3, #0x1a
	beq _02069FBC
	b _02069FF0
_02069EF8:
	ldr r0, _0206A010 // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _02069F10
	ldr r0, _0206A014 // =aStartparentNew
	blx r2
_02069F10:
	ldr r0, _0206A010 // =whConfig
	ldr r1, [r0, #0x50]
	cmp r1, #0
	beq _02069F54
	mov r0, r4
	blx r1
	cmp r0, #0
	bne _02069F54
	ldrh r1, [r4, #0x10]
	mov r0, #0
	bl WM_Disconnect
	cmp r0, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, r4, r5, pc}
_02069F54:
	ldr r0, _0206A010 // =whConfig
	ldr r0, [r0, #0x2c]
	sub r0, r0, #6
	cmp r0, #1
	bhi _02069F70
	mov r0, r4
	bl WH_Free
_02069F70:
	ldr r0, _0206A010 // =whConfig
	ldrh r1, [r0, #2]
	orr r1, r1, r5, lsr #16
	strh r1, [r0, #2]
	ldmia sp!, {r3, r4, r5, pc}
_02069F84:
	ldr r0, _0206A010 // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _02069F9C
	ldr r0, _0206A018 // =aStartparentChi
	blx r2
_02069F9C:
	ldr r1, _0206A010 // =whConfig
	mvn r2, r5, lsr #16
	ldrh r3, [r1, #2]
	mov r0, r4
	and r2, r3, r2
	strh r2, [r1, #2]
	bl WH_Free
	ldmia sp!, {r3, r4, r5, pc}
_02069FBC:
	ldr r0, _0206A010 // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, _0206A01C // =aStartparentChi_0
	blx r2
	ldmia sp!, {r3, r4, r5, pc}
_02069FD8:
	bl WH_StateInStartParentMP
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, r4, r5, pc}
_02069FF0:
	ldr r0, _0206A010 // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, _0206A020 // =aUnknownIndicat
	mov r1, r3
	blx r2
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206A010: .word whConfig
_0206A014: .word aStartparentNew
_0206A018: .word aStartparentChi
_0206A01C: .word aStartparentChi_0
_0206A020: .word aUnknownIndicat
	arm_func_end WH_StateOutStartParent

	arm_func_start WH_StateInStartParentMP
WH_StateInStartParentMP: // 0x0206A024
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r0, _0206A0C0 // =whConfig
	ldr r0, [r0, #0x1c]
	cmp r0, #4
	cmpne r0, #6
	cmpne r0, #5
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	mov r0, #4
	bl WH_ChangeSysState
	ldr r0, _0206A0C0 // =whConfig
	ldr r1, _0206A0C0 // =whConfig
	ldrh r0, [r0, #0xb6]
	ldr r3, [r1, #0x48]
	cmp r0, #0
	movne r0, #0
	moveq r0, #1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r2}
	ldr r1, [r1, #0x34]
	ldr r0, _0206A0C4 // =WH_StateOutStartParentMP
	mov r2, r1, lsl #0x10
	ldr r1, _0206A0C8 // =sRecvBuffer
	ldr r3, _0206A0CC // =sSendBuffer
	mov r2, r2, lsr #0x10
	bl WM_StartMP
	cmp r0, #2
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A0C0: .word whConfig
_0206A0C4: .word WH_StateOutStartParentMP
_0206A0C8: .word sRecvBuffer
_0206A0CC: .word sSendBuffer
	arm_func_end WH_StateInStartParentMP

	arm_func_start WH_StateOutStartParentMP
WH_StateOutStartParentMP: // 0x0206A0D0
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _0206A0F4
	mov r0, r1
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A0F4:
	ldrh r1, [r0, #4]
	sub r1, r1, #0xa
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0206A1F4
_0206A108: // jump table
	b _0206A118 // case 0
	ldmia sp!, {r3, pc} // case 1
	b _0206A1F4 // case 2
	b _0206A1F4 // case 3
_0206A118:
	ldr r2, _0206A214 // =whConfig
	ldr r1, [r2, #0x2c]
	cmp r1, #2
	bne _0206A170
	ldr r0, [r2, #0x1c]
	cmp r0, #4
	bne _0206A164
	bl WH_StateInStartParentKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, _0206A214 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A158
	ldr r0, _0206A218 // =aWhStateinstart
	blx r1
_0206A158:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A164:
	cmp r0, #6
	bne _0206A1E8
	ldmia sp!, {r3, pc}
_0206A170:
	cmp r1, #4
	bne _0206A1CC
	ldrh r1, [r2, #0x10]
	mov r3, #1
	ldr r0, _0206A21C // =WMDataSharingInfo
	add r1, r1, #1
	mov r1, r3, lsl r1
	str r3, [sp]
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	ldrh r3, [r2, #0xc]
	mov r2, r1, lsr #0x10
	mov r1, #0xd
	bl WM_StartDataSharing
	cmp r0, #0
	beq _0206A1C0
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1C0:
	mov r0, #5
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1CC:
	cmp r1, #6
	bne _0206A1DC
	bl WH_Free
	b _0206A1E8
_0206A1DC:
	cmp r1, #7
	bne _0206A1E8
	bl WH_Free
_0206A1E8:
	mov r0, #4
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1F4:
	ldr r1, _0206A214 // =whConfig
	ldr r2, [r1, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	ldr r0, _0206A220 // =aUnknownIndicat
	blx r2
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A214: .word whConfig
_0206A218: .word aWhStateinstart
_0206A21C: .word WMDataSharingInfo
_0206A220: .word aUnknownIndicat
	arm_func_end WH_StateOutStartParentMP

	arm_func_start WH_StateInStartParentKeyShare
WH_StateInStartParentKeyShare: // 0x0206A224
	stmdb sp!, {r3, lr}
	mov r0, #6
	bl WH_ChangeSysState
	ldr r0, _0206A254 // =sWMKeySetBuf
	mov r1, #0xd
	bl WM_StartKeySharing
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A254: .word sWMKeySetBuf
	arm_func_end WH_StateInStartParentKeyShare

	arm_func_start WH_StateInEndParentKeyShare
WH_StateInEndParentKeyShare: // 0x0206A258
	stmdb sp!, {r3, lr}
	ldr r0, _0206A2B0 // =sWMKeySetBuf
	bl WM_EndKeySharing
	cmp r0, #0
	beq _0206A278
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A278:
	bl WH_StateInEndParentMP
	cmp r0, #0
	bne _0206A2A8
	ldr r0, _0206A2B4 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A29C
	ldr r0, _0206A2B8 // =aWhStateinendpa
	blx r1
_0206A29C:
	bl WH_Reset
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A2A8:
	mov r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A2B0: .word sWMKeySetBuf
_0206A2B4: .word whConfig
_0206A2B8: .word aWhStateinendpa
	arm_func_end WH_StateInEndParentKeyShare

	arm_func_start WH_StateInEndParentMP
WH_StateInEndParentMP: // 0x0206A2BC
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206A2E8 // =WH_StateOutEndParentMP
	bl WM_EndMP
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A2E8: .word WH_StateOutEndParentMP
	arm_func_end WH_StateInEndParentMP

	arm_func_start WH_StateOutEndParentMP
WH_StateOutEndParentMP: // 0x0206A2EC
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206A308
	bl WH_SetError
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206A308:
	bl WH_StateInEndParent
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, _0206A334 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A32C
	ldr r0, _0206A338 // =aWhStateinendpa_0
	blx r1
_0206A32C:
	bl WH_Reset
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A334: .word whConfig
_0206A338: .word aWhStateinendpa_0
	arm_func_end WH_StateOutEndParentMP

	arm_func_start WH_StateInEndParent
WH_StateInEndParent: // 0x0206A33C
	stmdb sp!, {r3, lr}
	ldr r0, _0206A360 // =WH_StateOutEndParent
	bl WM_EndParent
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A360: .word WH_StateOutEndParent
	arm_func_end WH_StateInEndParent

	arm_func_start WH_StateOutEndParent
WH_StateOutEndParent: // 0x0206A364
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206A37C
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206A37C:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	arm_func_end WH_StateOutEndParent

	arm_func_start WH_ChildConnectAuto
WH_ChildConnectAuto: // 0x0206A388
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r7, r0
	mov r5, r2
	mov r4, r3
	cmp r6, #7
	bne _0206A410
	ldr r0, _0206A518 // =whConfig
	ldrh r1, [r0, #6]
	ldrh r0, [r0, #0x14]
	add r1, r1, #0x23
	add r0, r0, #0x21
	bic r1, r1, #0x1f
	bic r0, r0, #0x1f
	cmp r1, r0
	movle r1, r0
	ldr r0, _0206A518 // =whConfig
	str r1, [r0, #0x48]
	ldrh r2, [r0, #0x14]
	ldrh r1, [r0, #0x10]
	ldrh r0, [r0, #6]
	add r2, r2, #0xe
	mul r1, r2, r1
	add r1, r1, #0x29
	bic r1, r1, #0x1f
	add r0, r0, #0x55
	bic r0, r0, #0x1f
	mov r1, r1, lsl #1
	cmp r1, r0, lsl #1
	mov r0, r0, lsl #1
	movle r1, r0
	ldr r0, _0206A518 // =whConfig
	str r1, [r0, #0x34]
	b _0206A440
_0206A410:
	ldr r0, _0206A518 // =whConfig
	ldrh r1, [r0, #0x10]
	ldrh r2, [r0, #0xc]
	add r1, r1, #1
	mul r1, r2, r1
	add r1, r1, #0x59
	bic r1, r1, #0x1f
	mov r3, r1, lsl #1
	add r1, r2, #0x21
	str r3, [r0, #0x34]
	bic r1, r1, #0x1f
	str r1, [r0, #0x48]
_0206A440:
	ldr r0, _0206A518 // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206A45C
	ldr r1, [r0, #0x34]
	ldr r0, _0206A51C // =aRecvBufferSize
	blx r2
_0206A45C:
	ldr r0, _0206A518 // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206A478
	ldr r1, [r0, #0x48]
	ldr r0, _0206A520 // =aSendBufferSize
	blx r2
_0206A478:
	mov r0, #2
	bl WH_ChangeSysState
	ldr r0, _0206A524 // =sBssDesc+0x00000020
	mov r3, #1
	strh r3, [r0, #0x16]
	ldrh r2, [r5, #4]
	ldr r0, _0206A518 // =whConfig
	mov r1, #0
	strh r2, [r0, #0x8c]
	ldrh r2, [r5, #2]
	cmp r6, #7
	strh r2, [r0, #0x8a]
	ldrh r2, [r5, #0]
	strh r2, [r0, #0x88]
	str r6, [r0, #0x2c]
	str r7, [r0, #0x28]
	strh r4, [r0, #4]
	strh r1, [r0, #0x84]
	strh r3, [r0, #0x12]
	bne _0206A4F8
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A4DC
	ldr r0, _0206A528 // =aWfsInitchildCa
	blx r1
_0206A4DC:
	mov r1, #0
	ldr r2, _0206A52C // =WH_Alloc
	mov r3, r1
	mov r0, #1
	bl WFS_InitChild
	mov r0, #1
	bl WFS_SetDebugMode
_0206A4F8:
	bl WH_StateInStartScan
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206A518: .word whConfig
_0206A51C: .word aRecvBufferSize
_0206A520: .word aSendBufferSize
_0206A524: .word sBssDesc+0x00000020
_0206A528: .word aWfsInitchildCa
_0206A52C: .word WH_Alloc
	arm_func_end WH_ChildConnectAuto

	arm_func_start WH_StartScan
WH_StartScan: // 0x0206A530
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _0206A5B0 // =whConfig
	mov r5, r0
	ldr r0, [r3, #0x1c]
	mov r4, r1
	mov r6, r2
	cmp r0, #1
	beq _0206A558
	bl OS_Terminate
	movs r0, #0
_0206A558:
	mov r0, #2
	bl WH_ChangeSysState
	ldr r0, _0206A5B0 // =whConfig
	mov r1, #0
	str r5, [r0, #0x28]
	strh r6, [r0, #4]
	strh r1, [r0, #0x84]
	strh r1, [r0, #0x12]
	ldrh r1, [r4, #4]
	strh r1, [r0, #0x8c]
	ldrh r1, [r4, #2]
	strh r1, [r0, #0x8a]
	ldrh r1, [r4, #0]
	strh r1, [r0, #0x88]
	bl WH_StateInStartScan
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0206A5B0: .word whConfig
	arm_func_end WH_StartScan

	arm_func_start WH_StateInStartScan
WH_StateInStartScan: // 0x0206A5B4
	stmdb sp!, {r3, lr}
	ldr r0, _0206A684 // =whConfig
	ldr r0, [r0, #0x1c]
	cmp r0, #2
	beq _0206A5D0
	bl OS_Terminate
	movs r0, #0
_0206A5D0:
	bl WM_GetAllowedChannel
	cmp r0, #0x8000
	bne _0206A5EC
	mov r0, #3
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A5EC:
	cmp r0, #0
	bne _0206A604
	mov r0, #0x16
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A604:
	ldr r1, _0206A684 // =whConfig
	ldrh r2, [r1, #4]
	cmp r2, #0
	bne _0206A648
	mov ip, #1
	mov r3, ip
_0206A61C:
	ldrh r2, [r1, #0x84]
	add r2, r2, #1
	strh r2, [r1, #0x84]
	ldrh r2, [r1, #0x84]
	cmp r2, #0x10
	strhih ip, [r1, #0x84]
	ldrh r2, [r1, #0x84]
	sub r2, r2, #1
	tst r0, r3, lsl r2
	bne _0206A64C
	b _0206A61C
_0206A648:
	strh r2, [r1, #0x84]
_0206A64C:
	bl WM_GetDispersionScanPeriod
	ldr r2, _0206A684 // =whConfig
	ldr r3, _0206A688 // =sBssDesc
	strh r0, [r2, #0x86]
	ldr r0, _0206A68C // =WH_StateOutStartScan
	ldr r1, _0206A690 // =sScanParam
	str r3, [r2, #0x80]
	bl WM_StartScan
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A684: .word whConfig
_0206A688: .word sBssDesc
_0206A68C: .word WH_StateOutStartScan
_0206A690: .word sScanParam
	arm_func_end WH_StateInStartScan

	arm_func_start WH_StateOutStartScan
WH_StateOutStartScan: // 0x0206A694
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0206A6C0
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0206A6C0:
	ldr ip, _0206A8B0 // =whConfig
	ldr r0, [ip, #0x1c]
	cmp r0, #2
	beq _0206A6F8
	mov r0, #0
	strh r0, [ip, #0x12]
	bl WH_StateInEndScan
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0206A6F8:
	ldrh r0, [r4, #8]
	cmp r0, #3
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	cmp r0, #4
	beq _0206A890
	cmp r0, #5
	bne _0206A890
	ldr r0, [ip, #0x44]
	cmp r0, #0
	beq _0206A754
	ldrb r1, [r4, #0xd]
	ldr r0, _0206A8B4 // =aWhStateoutstar
	str r1, [sp]
	ldrb r1, [r4, #0xe]
	str r1, [sp, #4]
	ldrb r1, [r4, #0xf]
	str r1, [sp, #8]
	ldrb r1, [r4, #0xa]
	ldrb r2, [r4, #0xb]
	ldrb r3, [r4, #0xc]
	ldr ip, [ip, #0x44]
	blx ip
_0206A754:
	ldr r0, _0206A8B8 // =sBssDesc
	mov r1, #0xc0
	bl DC_InvalidateRange
	ldr r0, _0206A8B0 // =whConfig
	ldr r0, [r0, #0x38]
	cmp r0, #0
	beq _0206A7B8
	ldr r0, _0206A8B8 // =sBssDesc
	bl CHT_IsPictochatParent
	cmp r0, #0
	beq _0206A7B8
	ldr r0, _0206A8B0 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A798
	ldr r0, _0206A8BC // =aPictochatParen
	blx r1
_0206A798:
	ldr r0, _0206A8B0 // =whConfig
	ldr r2, [r0, #0x28]
	cmp r2, #0
	beq _0206A890
	ldr r0, _0206A8B8 // =sBssDesc
	mov r1, r4
	blx r2
	b _0206A890
_0206A7B8:
	ldrh r0, [r4, #0x36]
	mov r1, #0
	cmp r0, #0x10
	blo _0206A7D4
	ldrh r0, [r4, #0x38]
	cmp r0, #1
	moveq r1, #1
_0206A7D4:
	cmp r1, #0
	beq _0206A7F0
	ldr r0, _0206A8B0 // =whConfig
	ldr r2, [r4, #0x3c]
	ldr r1, [r0, #0xa8]
	cmp r2, r1
	beq _0206A80C
_0206A7F0:
	ldr r0, _0206A8B0 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A890
	ldr r0, _0206A8C0 // =aNotMyParentGgi
	blx r1
	b _0206A890
_0206A80C:
	ldrb r1, [r4, #0x43]
	and r1, r1, #3
	cmp r1, #1
	ldr r1, [r0, #0x44]
	beq _0206A834
	cmp r1, #0
	beq _0206A890
	ldr r0, _0206A8C4 // =aNotRecieveEntr
	blx r1
	b _0206A890
_0206A834:
	cmp r1, #0
	beq _0206A844
	ldr r0, _0206A8C8 // =aParentFind
	blx r1
_0206A844:
	ldr r0, _0206A8B0 // =whConfig
	ldr r2, [r0, #0x28]
	cmp r2, #0
	beq _0206A860
	ldr r0, _0206A8B8 // =sBssDesc
	mov r1, r4
	blx r2
_0206A860:
	ldr r0, _0206A8B0 // =whConfig
	ldrh r0, [r0, #0x12]
	cmp r0, #0
	beq _0206A890
	bl WH_StateInEndScan
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0206A890:
	bl WH_StateInStartScan
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0206A8B0: .word whConfig
_0206A8B4: .word aWhStateoutstar
_0206A8B8: .word sBssDesc
_0206A8BC: .word aPictochatParen
_0206A8C0: .word aNotMyParentGgi
_0206A8C4: .word aNotRecieveEntr
_0206A8C8: .word aParentFind
	arm_func_end WH_StateOutStartScan

	arm_func_start WH_EndScan
WH_EndScan: // 0x0206A8CC
	stmdb sp!, {r3, lr}
	ldr r1, _0206A8FC // =whConfig
	ldr r0, [r1, #0x1c]
	cmp r0, #2
	movne r0, #0
	ldmneia sp!, {r3, pc}
	mov r2, #0
	mov r0, #3
	strh r2, [r1, #0x12]
	bl WH_ChangeSysState
	mov r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A8FC: .word whConfig
	arm_func_end WH_EndScan

	arm_func_start WH_StateInEndScan
WH_StateInEndScan: // 0x0206A900
	stmdb sp!, {r3, lr}
	ldr r0, _0206A924 // =WH_StateOutEndScan
	bl WM_EndScan
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A924: .word WH_StateOutEndScan
	arm_func_end WH_StateInEndScan

	arm_func_start WH_StateOutEndScan
WH_StateOutEndScan: // 0x0206A928
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206A940
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206A940:
	mov r0, #1
	bl WH_ChangeSysState
	ldr r0, _0206A9AC // =whConfig
	ldrh r1, [r0, #0x12]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, [r0, #0x18]
	cmp r0, #0
	beq _0206A97C
	bl WH_StateInSetChildWEPKey
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A97C:
	bl WH_StateInStartChild
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, _0206A9AC // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A9A0
	ldr r0, _0206A9B0 // =aWhStateoutends
	blx r1
_0206A9A0:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A9AC: .word whConfig
_0206A9B0: .word aWhStateoutends
	arm_func_end WH_StateOutEndScan

	arm_func_start WH_StateInSetChildWEPKey
WH_StateInSetChildWEPKey: // 0x0206A9B4
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r1, _0206AA04 // =whConfig
	ldr r0, _0206AA08 // =sWEPKey
	ldr r2, [r1, #0x18]
	ldr r1, _0206AA0C // =sBssDesc
	blx r2
	mov r1, r0
	ldr r0, _0206AA10 // =WH_StateOutSetChildWEPKey
	ldr r2, _0206AA08 // =sWEPKey
	bl WM_SetWEPKey
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AA04: .word whConfig
_0206AA08: .word sWEPKey
_0206AA0C: .word sBssDesc
_0206AA10: .word WH_StateOutSetChildWEPKey
	arm_func_end WH_StateInSetChildWEPKey

	arm_func_start WH_StateOutSetChildWEPKey
WH_StateOutSetChildWEPKey: // 0x0206AA14
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206AA34
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AA34:
	bl WH_StateInStartChild
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, _0206AA64 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AA58
	ldr r0, _0206AA68 // =aWhStateoutsetc
	blx r1
_0206AA58:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AA64: .word whConfig
_0206AA68: .word aWhStateoutsetc
	arm_func_end WH_StateOutSetChildWEPKey

	arm_func_start WH_StateInStartChild
WH_StateInStartChild: // 0x0206AA6C
	stmdb sp!, {r3, lr}
	ldr r0, _0206AAFC // =whConfig
	ldr r0, [r0, #0x1c]
	cmp r0, #4
	cmpne r0, #6
	cmpne r0, #5
	bne _0206AAA8
	ldr r0, _0206AAFC // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AAA0
	ldr r0, _0206AB00 // =aWhStateinstart_0
	blx r1
_0206AAA0:
	mov r0, #1
	ldmia sp!, {r3, pc}
_0206AAA8:
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206AAFC // =whConfig
	ldr r1, _0206AB04 // =sBssDesc
	ldr r0, [r0, #0x18]
	ldr r2, _0206AB08 // =sConnectionSsid
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	ldr r0, _0206AB0C // =WH_StateOutStartChild
	mov r3, #1
	str ip, [sp]
	bl WM_StartConnectEx
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AAFC: .word whConfig
_0206AB00: .word aWhStateinstart_0
_0206AB04: .word sBssDesc
_0206AB08: .word sConnectionSsid
_0206AB0C: .word WH_StateOutStartChild
	arm_func_end WH_StateInStartChild

	arm_func_start WH_StateOutStartChild
WH_StateOutStartChild: // 0x0206AB10
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0206AB74
	bl WH_SetError
	ldrh r0, [r4, #2]
	cmp r0, #0xc
	bne _0206AB40
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB40:
	cmp r0, #0xb
	bne _0206AB54
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB54:
	cmp r0, #1
	bne _0206AB68
	mov r0, #8
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB68:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB74:
	ldrh r0, [r4, #8]
	cmp r0, #8
	ldmeqia sp!, {r4, pc}
	cmp r0, #7
	bne _0206ABE8
	ldr r0, _0206AC90 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206ABA0
	ldr r0, _0206AC94 // =aConnectToParen
	blx r1
_0206ABA0:
	mov r0, #4
	bl WH_ChangeSysState
	bl WH_StateInStartChildMP
	cmp r0, #0
	bne _0206ABD8
	ldr r0, _0206AC90 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206ABCC
	ldr r0, _0206AC98 // =aWhStateinstart_1
	blx r1
_0206ABCC:
	mov r0, #3
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206ABD8:
	ldrh r1, [r4, #0xa]
	ldr r0, _0206AC90 // =whConfig
	strh r1, [r0, #8]
	ldmia sp!, {r4, pc}
_0206ABE8:
	cmp r0, #6
	ldmeqia sp!, {r4, pc}
	cmp r0, #9
	bne _0206AC38
	ldr r0, _0206AC90 // =whConfig
	ldr r0, [r0, #0x2c]
	cmp r0, #7
	bne _0206AC0C
	bl WFS_End
_0206AC0C:
	ldr r0, _0206AC90 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AC24
	ldr r0, _0206AC9C // =aDisconnectedFr
	blx r1
_0206AC24:
	mov r0, #0x14
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AC38:
	cmp r0, #0x1a
	bne _0206AC58
	ldr r0, _0206AC90 // =whConfig
	ldr r0, [r0, #0x2c]
	cmp r0, #7
	ldmneia sp!, {r4, pc}
	bl WFS_End
	ldmia sp!, {r4, pc}
_0206AC58:
	ldr r1, _0206AC90 // =whConfig
	ldr r1, [r1, #0x44]
	cmp r1, #0
	beq _0206AC84
	bl WH_GetWMStateCodeName
	ldr r3, _0206AC90 // =whConfig
	mov r2, r0
	ldrh r1, [r4, #8]
	ldr r3, [r3, #0x44]
	ldr r0, _0206ACA0 // =aUnknownStateDS
	blx r3
_0206AC84:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206AC90: .word whConfig
_0206AC94: .word aConnectToParen
_0206AC98: .word aWhStateinstart_1
_0206AC9C: .word aDisconnectedFr
_0206ACA0: .word aUnknownStateDS
	arm_func_end WH_StateOutStartChild

	arm_func_start WH_StateInStartChildMP
WH_StateInStartChildMP: // 0x0206ACA4
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r2, _0206AD00 // =whConfig
	mov r3, #1
	ldr r1, [r2, #0x48]
	ldr r0, _0206AD04 // =WH_StateOutStartChildMP
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	stmia sp, {r1, r3}
	ldr r2, [r2, #0x34]
	ldr r1, _0206AD08 // =sRecvBuffer
	mov r2, r2, lsl #0x10
	ldr r3, _0206AD0C // =sSendBuffer
	mov r2, r2, lsr #0x10
	bl WM_StartMP
	cmp r0, #2
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AD00: .word whConfig
_0206AD04: .word WH_StateOutStartChildMP
_0206AD08: .word sRecvBuffer
_0206AD0C: .word sSendBuffer
	arm_func_end WH_StateInStartChildMP

	arm_func_start WH_StateOutStartChildMP
WH_StateOutStartChildMP: // 0x0206AD10
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _0206AD44
	cmp r1, #0xf
	cmpne r1, #9
	cmpne r1, #0xd
	ldmeqia sp!, {r3, pc}
	mov r0, r1
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AD44:
	ldrh r1, [r0, #4]
	sub r1, r1, #0xa
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0206AE40
_0206AD58: // jump table
	b _0206AD68 // case 0
	b _0206AE40 // case 1
	ldmia sp!, {r3, pc} // case 2
	ldmia sp!, {r3, pc} // case 3
_0206AD68:
	ldr r2, _0206AE60 // =whConfig
	ldr r1, [r2, #0x2c]
	cmp r1, #3
	bne _0206ADB8
	ldr r0, [r2, #0x1c]
	cmp r0, #6
	ldmeqia sp!, {r3, pc}
	cmp r0, #4
	bne _0206AE34
	bl WH_StateInStartChildKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, _0206AE60 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206ADB0
	ldr r0, _0206AE64 // =aWhStateinstart_2
	blx r1
_0206ADB0:
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206ADB8:
	cmp r1, #5
	bne _0206AE28
	ldrh r1, [r2, #0x10]
	mov r3, #1
	ldr r0, _0206AE68 // =WMDataSharingInfo
	add r1, r1, #1
	mov r1, r3, lsl r1
	str r3, [sp]
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	ldrh r3, [r2, #0xc]
	mov r2, r1, lsr #0x10
	mov r1, #0xd
	bl WM_StartDataSharing
	cmp r0, #0
	beq _0206AE04
	bl WH_SetError
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206AE04:
	ldr r0, _0206AE60 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AE1C
	ldr r0, _0206AE6C // =aWhStateoutstar_0
	blx r1
_0206AE1C:
	mov r0, #5
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AE28:
	cmp r1, #7
	bne _0206AE34
	bl WH_Free
_0206AE34:
	mov r0, #4
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AE40:
	ldr r1, _0206AE60 // =whConfig
	ldr r2, [r1, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	ldr r0, _0206AE70 // =aUnknownIndicat
	blx r2
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AE60: .word whConfig
_0206AE64: .word aWhStateinstart_2
_0206AE68: .word WMDataSharingInfo
_0206AE6C: .word aWhStateoutstar_0
_0206AE70: .word aUnknownIndicat
	arm_func_end WH_StateOutStartChildMP

	arm_func_start WH_StateInStartChildKeyShare
WH_StateInStartChildKeyShare: // 0x0206AE74
	stmdb sp!, {r3, lr}
	ldr r0, _0206AEC4 // =whConfig
	ldr r0, [r0, #0x1c]
	cmp r0, #6
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	cmp r0, #4
	movne r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #6
	bl WH_ChangeSysState
	ldr r0, _0206AEC8 // =sWMKeySetBuf
	mov r1, #0xd
	bl WM_StartKeySharing
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AEC4: .word whConfig
_0206AEC8: .word sWMKeySetBuf
	arm_func_end WH_StateInStartChildKeyShare

	arm_func_start WH_StateInEndChildKeyShare
WH_StateInEndChildKeyShare: // 0x0206AECC
	stmdb sp!, {r3, lr}
	ldr r0, _0206AF1C // =whConfig
	ldr r0, [r0, #0x1c]
	cmp r0, #6
	movne r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206AF20 // =sWMKeySetBuf
	bl WM_EndKeySharing
	cmp r0, #0
	beq _0206AF08
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206AF08:
	bl WH_StateInEndChildMP
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AF1C: .word whConfig
_0206AF20: .word sWMKeySetBuf
	arm_func_end WH_StateInEndChildKeyShare

	arm_func_start WH_StateInEndChildMP
WH_StateInEndChildMP: // 0x0206AF24
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206AF50 // =WH_StateOutEndChildMP
	bl WM_EndMP
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AF50: .word WH_StateOutEndChildMP
	arm_func_end WH_StateInEndChildMP

	arm_func_start WH_StateOutEndChildMP
WH_StateOutEndChildMP: // 0x0206AF54
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206AF70
	bl WH_SetError
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206AF70:
	bl WH_StateInEndChild
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	arm_func_end WH_StateOutEndChildMP

	arm_func_start WH_StateInEndChild
WH_StateInEndChild: // 0x0206AF88
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206AFBC // =WH_StateOutEndChild
	mov r1, #0
	bl WM_Disconnect
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	bl WH_Reset
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AFBC: .word WH_StateOutEndChild
	arm_func_end WH_StateInEndChild

	arm_func_start WH_StateOutEndChild
WH_StateOutEndChild: // 0x0206AFC0
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206AFD8
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206AFD8:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	arm_func_end WH_StateOutEndChild

	arm_func_start WH_StateInReset
WH_StateInReset: // 0x0206AFE4
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206B010 // =WH_StateOutReset
	bl WM_Reset
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B010: .word WH_StateOutReset
	arm_func_end WH_StateInReset

	arm_func_start WH_StateOutReset
WH_StateOutReset: // 0x0206B014
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #2]
	cmp r1, #0
	beq _0206B03C
	mov r0, #9
	bl WH_ChangeSysState
	ldrh r0, [r4, #2]
	bl WH_SetError
	ldmia sp!, {r4, pc}
_0206B03C:
	ldr r1, _0206B060 // =whConfig
	ldr r1, [r1, #0x2c]
	sub r1, r1, #6
	cmp r1, #1
	bhi _0206B054
	bl WH_Free
_0206B054:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206B060: .word whConfig
	arm_func_end WH_StateOutReset

	arm_func_start WH_StateInSetMPData
WH_StateInSetMPData: // 0x0206B064
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r3, _0206B0FC // =whConfig
	mov r6, r0
	mov r5, r1
	ldr r1, [r3, #0x48]
	ldr r0, _0206B100 // =sSendBuffer
	mov r4, r2
	bl DC_FlushRange
	ldr r0, _0206B104 // =0x0000FFFF
	mov ip, #0xe
	str r0, [sp]
	ldr r0, _0206B108 // =WH_StateOutSetMPData
	mov r1, r4
	mov r2, r6
	mov r3, r5
	str ip, [sp, #4]
	mov ip, #2
	str ip, [sp, #8]
	bl WM_SetMPDataToPort
	cmp r0, #2
	beq _0206B0F0
	ldr r1, _0206B0FC // =whConfig
	ldr r1, [r1, #0x44]
	cmp r1, #0
	beq _0206B0E4
	bl WH_GetWMErrCodeName
	ldr r2, _0206B0FC // =whConfig
	mov r1, r0
	ldr r2, [r2, #0x44]
	ldr r0, _0206B10C // =aWhStateinsetmp
	blx r2
_0206B0E4:
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, pc}
_0206B0F0:
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0206B0FC: .word whConfig
_0206B100: .word sSendBuffer
_0206B104: .word 0x0000FFFF
_0206B108: .word WH_StateOutSetMPData
_0206B10C: .word aWhStateinsetmp
	arm_func_end WH_StateInSetMPData

	arm_func_start WH_StateOutSetMPData
WH_StateOutSetMPData: // 0x0206B110
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	cmpne r0, #0xf
	beq _0206B130
	bl WH_SetError
	ldmia sp!, {r4, pc}
_0206B130:
	ldr r1, [r4, #0x20]
	cmp r1, #0
	beq _0206B14C
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	blx r1
_0206B14C:
	ldr r0, _0206B16C // =whConfig
	ldr r0, [r0, #0x2c]
	sub r0, r0, #6
	cmp r0, #1
	ldmhiia sp!, {r4, pc}
	mov r0, r4
	bl WH_Free
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206B16C: .word whConfig
	arm_func_end WH_StateOutSetMPData

	arm_func_start WH_PortReceiveCallback
WH_PortReceiveCallback: // 0x0206B170
	stmdb sp!, {r3, lr}
	mov r1, r0
	ldrh r0, [r1, #2]
	cmp r0, #0
	beq _0206B18C
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206B18C:
	ldr r0, _0206B1D8 // =whConfig
	ldr r3, [r0, #0x24]
	cmp r3, #0
	ldmeqia sp!, {r3, pc}
	ldrh r0, [r1, #4]
	cmp r0, #0x15
	bne _0206B1BC
	ldrh r0, [r1, #0x12]
	ldrh r2, [r1, #0x10]
	ldr r1, [r1, #0xc]
	blx r3
	ldmia sp!, {r3, pc}
_0206B1BC:
	cmp r0, #9
	ldmneia sp!, {r3, pc}
	ldrh r0, [r1, #0x12]
	mov r1, #0
	mov r2, r1
	blx r3
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B1D8: .word whConfig
	arm_func_end WH_PortReceiveCallback

	arm_func_start WH_StateOutEnd
WH_StateOutEnd: // 0x0206B1DC
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206B1F8
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206B1F8:
	mov r0, #0
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	arm_func_end WH_StateOutEnd

	arm_func_start WH_SetGgid
WH_SetGgid: // 0x0206B204
	ldr r1, _0206B210 // =whConfig
	str r0, [r1, #0xa8]
	bx lr
	.align 2, 0
_0206B210: .word whConfig
	arm_func_end WH_SetGgid

	arm_func_start WH_SetSsid
WH_SetSsid: // 0x0206B214
	stmdb sp!, {r4, lr}
	mov r4, r1
	cmp r4, #0x18
	movhi r4, #0x18
	ldr r1, _0206B248 // =sConnectionSsid
	mov r2, r4
	bl MI_CpuCopy8
	ldr r0, _0206B248 // =sConnectionSsid
	rsb r2, r4, #0x18
	add r0, r0, r4
	mov r1, #0
	bl MI_CpuFill8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206B248: .word sConnectionSsid
	arm_func_end WH_SetSsid

	arm_func_start WH_SetUserGameInfo
WH_SetUserGameInfo: // 0x0206B24C
	ldr r2, _0206B25C // =whConfig
	str r0, [r2, #0xa0]
	strh r1, [r2, #0xa4]
	bx lr
	.align 2, 0
_0206B25C: .word whConfig
	arm_func_end WH_SetUserGameInfo

	arm_func_start WH_SetMaxChildCount
WH_SetMaxChildCount: // 0x0206B260
	ldr r1, _0206B26C // =whConfig
	strh r0, [r1, #0x10]
	bx lr
	.align 2, 0
_0206B26C: .word whConfig
	arm_func_end WH_SetMaxChildCount

	arm_func_start WH_SetMinDataSize
WH_SetMinDataSize: // 0x0206B270
	ldr r1, _0206B27C // =whConfig
	strh r0, [r1, #0xc]
	bx lr
	.align 2, 0
_0206B27C: .word whConfig
	arm_func_end WH_SetMinDataSize

	arm_func_start WH_SetMaxParentChildSize
WH_SetMaxParentChildSize: // 0x0206B280
	ldr r2, _0206B290 // =whConfig
	strh r0, [r2, #6]
	strh r1, [r2, #0x14]
	bx lr
	.align 2, 0
_0206B290: .word whConfig
	arm_func_end WH_SetMaxParentChildSize

	arm_func_start WH_GetConnectBitmap
WH_GetConnectBitmap: // 0x0206B294
	ldr r0, _0206B2A0 // =whConfig
	ldrh r0, [r0, #2]
	bx lr
	.align 2, 0
_0206B2A0: .word whConfig
	arm_func_end WH_GetConnectBitmap

	arm_func_start WH_GetSystemState
WH_GetSystemState: // 0x0206B2A4
	ldr r0, _0206B2B0 // =whConfig
	ldr r0, [r0, #0x1c]
	bx lr
	.align 2, 0
_0206B2B0: .word whConfig
	arm_func_end WH_GetSystemState

	arm_func_start WH_GetErrorCode
WH_GetErrorCode: // 0x0206B2B4
	ldr r0, _0206B2C0 // =whConfig
	ldr r0, [r0, #0x4c]
	bx lr
	.align 2, 0
_0206B2C0: .word whConfig
	arm_func_end WH_GetErrorCode

	arm_func_start WH_StartMeasureChannel
WH_StartMeasureChannel: // 0x0206B2C4
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	add r0, sp, #0
	bl OS_GetMacAddress
	ldr r1, _0206B378 // =0x027FFC3C
	ldrh r0, [sp]
	ldr r2, [r1, #0]
	ldrh r1, [sp, #2]
	add r0, r0, r2
	ldrh r2, [sp, #4]
	add r1, r1, r0
	ldr r0, _0206B37C // =0x00010DCD
	add r1, r2, r1
	mul r0, r1, r0
	add r0, r0, #0x39
	ldr r1, _0206B380 // =whConfig
	add r0, r0, #0x3000
	str r0, [r1, #0x3c]
	mov r0, #0
	strh r0, [r1, #0xa]
	mov r2, #0x65
	mov r0, #3
	strh r2, [r1]
	bl WH_ChangeSysState
	mov r0, #1
	bl WH_StateInMeasureChannel
	cmp r0, #0x18
	bne _0206B350
	mov r0, #0x18
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206B350:
	cmp r0, #2
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B378: .word 0x027FFC3C
_0206B37C: .word 0x00010DCD
_0206B380: .word whConfig
	arm_func_end WH_StartMeasureChannel

	arm_func_start WH_StateInMeasureChannel
WH_StateInMeasureChannel: // 0x0206B384
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WM_GetAllowedChannel
	cmp r0, #0x8000
	bne _0206B3B0
	mov r0, #3
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #3
	ldmia sp!, {r4, pc}
_0206B3B0:
	cmp r0, #0
	bne _0206B3D0
	mov r0, #0x16
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0x18
	ldmia sp!, {r4, pc}
_0206B3D0:
	sub r1, r4, #1
	mov r2, #1
	tst r0, r2, lsl r1
	bne _0206B404
_0206B3E0:
	add r1, r4, #1
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	cmp r4, #0x10
	movhi r0, #0x18
	ldmhiia sp!, {r4, pc}
	sub r1, r4, #1
	tst r0, r2, lsl r1
	beq _0206B3E0
_0206B404:
	ldr r0, _0206B41C // =WH_StateOutMeasureChannel
	mov r1, r4
	bl WHi_MeasureChannel
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206B41C: .word WH_StateOutMeasureChannel
	arm_func_end WH_StateInMeasureChannel

	arm_func_start WH_StateOutMeasureChannel
WH_StateOutMeasureChannel: // 0x0206B420
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0206B444
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206B444:
	ldr r0, _0206B4E4 // =whConfig
	ldr r3, [r0, #0x44]
	cmp r3, #0
	beq _0206B464
	ldrh r1, [r4, #8]
	ldrh r2, [r4, #0xa]
	ldr r0, _0206B4E8 // =aChannelDBratio
	blx r3
_0206B464:
	ldr r0, _0206B4E4 // =whConfig
	ldrh r3, [r4, #0xa]
	ldrh r1, [r0, #0]
	ldrh ip, [r4, #8]
	cmp r1, r3
	bls _0206B494
	sub r1, ip, #1
	mov r2, #1
	mov r1, r2, lsl r1
	strh r3, [r0]
	strh r1, [r0, #0xe]
	b _0206B4AC
_0206B494:
	bne _0206B4AC
	ldrh r3, [r0, #0xe]
	sub r1, ip, #1
	mov r2, #1
	orr r1, r3, r2, lsl r1
	strh r1, [r0, #0xe]
_0206B4AC:
	add r0, ip, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WH_StateInMeasureChannel
	cmp r0, #0x18
	bne _0206B4D0
	mov r0, #7
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206B4D0:
	cmp r0, #2
	ldmeqia sp!, {r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206B4E4: .word whConfig
_0206B4E8: .word aChannelDBratio
	arm_func_end WH_StateOutMeasureChannel

	arm_func_start WHi_MeasureChannel
WHi_MeasureChannel: // 0x0206B4EC
	stmdb sp!, {r3, lr}
	mov r3, r1
	mov ip, #0x1e
	mov r1, #3
	mov r2, #0x11
	str ip, [sp]
	bl WM_MeasureChannel
	ldmia sp!, {r3, pc}
	arm_func_end WHi_MeasureChannel

	arm_func_start WH_GetMeasureChannel
WH_GetMeasureChannel: // 0x0206B50C
	stmdb sp!, {r3, lr}
	ldr r0, _0206B564 // =whConfig
	ldr r0, [r0, #0x1c]
	cmp r0, #7
	beq _0206B524
	bl OS_Terminate
_0206B524:
	mov r0, #1
	bl WH_ChangeSysState
	ldr r0, _0206B564 // =whConfig
	ldrh r0, [r0, #0xe]
	bl WHi_SelectChannel
	ldr r1, _0206B564 // =whConfig
	strh r0, [r1, #0xa]
	ldr r2, [r1, #0x44]
	cmp r2, #0
	beq _0206B558
	ldrh r1, [r1, #0xa]
	ldr r0, _0206B568 // =aDecidedChannel
	blx r2
_0206B558:
	ldr r0, _0206B564 // =whConfig
	ldrh r0, [r0, #0xa]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B564: .word whConfig
_0206B568: .word aDecidedChannel
	arm_func_end WH_GetMeasureChannel

	arm_func_start WHi_SelectChannel
WHi_SelectChannel: // 0x0206B56C
	stmdb sp!, {r3, lr}
	mov r3, #0
	mov r1, r3
	mov lr, r3
	mov ip, #1
_0206B580:
	tst r0, ip, lsl lr
	beq _0206B5A0
	add r3, lr, #1
	add r2, r1, #1
	mov r1, r3, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r1, asr #0x10
	mov r1, r2, lsr #0x10
_0206B5A0:
	add r2, lr, #1
	mov r2, r2, lsl #0x10
	mov lr, r2, asr #0x10
	cmp lr, #0x10
	blt _0206B580
	cmp r1, #1
	movls r0, r3
	ldmlsia sp!, {r3, pc}
	ldr ip, _0206B640 // =whConfig
	ldr r3, _0206B644 // =0x00010DCD
	ldr lr, [ip, #0x3c]
	mov r2, #0
	mul r3, lr, r3
	add r3, r3, #0x39
	add lr, r3, #0x3000
	and r3, lr, #0xff
	mul r3, r1, r3
	mov r1, r3, lsl #8
	str lr, [ip, #0x3c]
	mov r3, r1, lsr #0x10
_0206B5F0:
	tst r0, #1
	beq _0206B61C
	cmp r3, #0
	bne _0206B610
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	ldmia sp!, {r3, pc}
_0206B610:
	sub r1, r3, #1
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
_0206B61C:
	add r1, r2, #1
	mov r1, r1, lsl #0x10
	mov r0, r0, lsl #0xf
	mov r2, r1, asr #0x10
	cmp r2, #0x10
	mov r0, r0, lsr #0x10
	blt _0206B5F0
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B640: .word whConfig
_0206B644: .word 0x00010DCD
	arm_func_end WHi_SelectChannel

	arm_func_start WH_Initialize
WH_Initialize: // 0x0206B648
	stmdb sp!, {r3, lr}
	ldr r3, _0206B6D0 // =whConfig
	mov r1, #0
	str r1, [r3, #0x34]
	str r1, [r3, #0x48]
	str r1, [r3, #0x24]
	strh r1, [r3, #8]
	mov r0, #1
	strh r0, [r3, #2]
	str r1, [r3, #0x4c]
	str r1, [r3, #0xa0]
	ldr r0, _0206B6D4 // =sConnectionSsid
	mov r2, #0x18
	strh r1, [r3, #0xa4]
	bl MI_CpuFill8
	ldr r3, _0206B6D0 // =whConfig
	mov r1, #0
	ldr r0, _0206B6D8 // =WMDataSharingInfo
	mov r2, #0x820
	str r1, [r3, #0x50]
	bl MI_CpuFill8
	ldr r0, _0206B6DC // =sDataSet
	mov r1, #0
	mov r2, #0x200
	bl MI_CpuFill8
	ldr r0, _0206B6E0 // =sWMKeySetBuf
	mov r1, #0
	mov r2, #0x820
	bl MI_CpuFill8
	bl WH_StateInInitialize
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B6D0: .word whConfig
_0206B6D4: .word sConnectionSsid
_0206B6D8: .word WMDataSharingInfo
_0206B6DC: .word sDataSet
_0206B6E0: .word sWMKeySetBuf
	arm_func_end WH_Initialize

	arm_func_start WH_IndicateHandler
WH_IndicateHandler: // 0x0206B6E4
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #8
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	bl OS_Terminate
	arm_func_end WH_IndicateHandler

	arm_func_start sub_206b700
sub_206b700: // 0x0206B700
	ldmia sp!, {r3, pc}
	arm_func_end sub_206b700

	arm_func_start WH_StateInInitialize
WH_StateInInitialize: // 0x0206B704
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206B740 // =sWmBuffer
	ldr r1, _0206B744 // =WH_StateOutInitialize
	mov r2, #2
	bl WM_Initialize
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0xa
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B740: .word sWmBuffer
_0206B744: .word WH_StateOutInitialize
	arm_func_end WH_StateInInitialize

	arm_func_start WH_StateOutInitialize
WH_StateOutInitialize: // 0x0206B748
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206B768
	bl WH_SetError
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206B768:
	ldr r0, _0206B794 // =WH_IndicateHandler
	bl WM_SetIndCallback
	cmp r0, #0
	beq _0206B788
	bl WH_SetError
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206B788:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B794: .word WH_IndicateHandler
	arm_func_end WH_StateOutInitialize

	arm_func_start WH_ParentConnect
WH_ParentConnect: // 0x0206B798
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r3, _0206B9EC // =whConfig
	mov r6, r0
	ldr r0, [r3, #0x1c]
	mov r5, r1
	mov r4, r2
	cmp r0, #1
	beq _0206B7C4
	bl OS_Terminate
	movs r0, #0
_0206B7C4:
	cmp r6, #6
	bne _0206B838
	ldr r0, _0206B9EC // =whConfig
	ldrh r1, [r0, #6]
	ldrh r0, [r0, #0x14]
	add r1, r1, #0x23
	add r0, r0, #0x21
	bic r1, r1, #0x1f
	bic r0, r0, #0x1f
	cmp r1, r0
	movle r1, r0
	ldr r0, _0206B9EC // =whConfig
	str r1, [r0, #0x48]
	ldrh r2, [r0, #0x14]
	ldrh r1, [r0, #0x10]
	ldrh r0, [r0, #6]
	add r2, r2, #0xe
	mul r1, r2, r1
	add r1, r1, #0x29
	bic r1, r1, #0x1f
	add r0, r0, #0x55
	bic r0, r0, #0x1f
	mov r1, r1, lsl #1
	cmp r1, r0, lsl #1
	mov r0, r0, lsl #1
	movle r1, r0
	ldr r0, _0206B9EC // =whConfig
	str r1, [r0, #0x34]
	b _0206B870
_0206B838:
	ldr r0, _0206B9EC // =whConfig
	ldrh r2, [r0, #0xc]
	ldrh r1, [r0, #0x10]
	add r3, r2, #0xe
	mul ip, r3, r1
	add r1, r1, #1
	mul r1, r2, r1
	add r2, ip, #0x29
	bic r2, r2, #0x1f
	mov r2, r2, lsl #1
	add r1, r1, #0x27
	str r2, [r0, #0x34]
	bic r1, r1, #0x1f
	str r1, [r0, #0x48]
_0206B870:
	ldr r0, _0206B9EC // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206B88C
	ldr r1, [r0, #0x34]
	ldr r0, _0206B9F0 // =aRecvBufferSize
	blx r2
_0206B88C:
	ldr r0, _0206B9EC // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206B8A8
	ldr r1, [r0, #0x48]
	ldr r0, _0206B9F4 // =aSendBufferSize
	blx r2
_0206B8A8:
	ldr r1, _0206B9EC // =whConfig
	mov r0, #3
	str r6, [r1, #0x2c]
	bl WH_ChangeSysState
	ldr r0, _0206B9EC // =whConfig
	strh r5, [r0, #0xac]
	strh r4, [r0, #0xd2]
	bl WM_GetDispersionBeaconPeriod
	ldr r1, _0206B9EC // =whConfig
	cmp r6, #6
	strh r0, [r1, #0xb8]
	bne _0206B8EC
	ldrh r0, [r1, #6]
	strh r0, [r1, #0xd4]
	ldrh r0, [r1, #0x14]
	strh r0, [r1, #0xd6]
	b _0206B908
_0206B8EC:
	ldrh r0, [r1, #0x10]
	ldrh r2, [r1, #0xc]
	add r0, r0, #1
	mul r0, r2, r0
	add r0, r0, #4
	strh r0, [r1, #0xd4]
	strh r2, [r1, #0xd6]
_0206B908:
	ldr r0, _0206B9EC // =whConfig
	cmp r6, #6
	ldrh r1, [r0, #0x10]
	moveq r2, #1
	movne r2, #0
	strh r1, [r0, #0xb0]
	ldr r0, _0206B9EC // =whConfig
	mov r1, #0
	strh r2, [r0, #0xb6]
	strh r1, [r0, #0xb2]
	mov r2, #1
	strh r2, [r0, #0xae]
	cmp r6, #2
	movne r2, r1
	ldr r0, _0206B9EC // =whConfig
	cmp r6, #6
	strh r2, [r0, #0xb4]
	addls pc, pc, r6, lsl #2
	b _0206B9C4
_0206B954: // jump table
	b _0206B9B8 // case 0
	b _0206B9C4 // case 1
	b _0206B9B8 // case 2
	b _0206B9C4 // case 3
	b _0206B9B8 // case 4
	b _0206B9C4 // case 5
	b _0206B970 // case 6
_0206B970:
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206B984
	ldr r0, _0206B9F8 // =aWfsInitparentC
	blx r1
_0206B984:
	ldr r0, _0206B9EC // =whConfig
	mov r1, #0
	ldrh r0, [r0, #6]
	ldr r2, _0206B9FC // =WH_Alloc
	mov r3, r1
	stmia sp, {r0, r1}
	mov r0, #1
	str r0, [sp, #8]
	bl WFS_InitParent
	mov r0, #1
	bl WFS_SetDebugMode
	mov r0, #0
	bl WFS_EnableSync
_0206B9B8:
	bl WH_StateInSetParentParam
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
_0206B9C4:
	ldr r0, _0206B9EC // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206B9E0
	ldr r0, _0206BA00 // =aUnknownConnect
	mov r1, r6
	blx r2
_0206B9E0:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0206B9EC: .word whConfig
_0206B9F0: .word aRecvBufferSize
_0206B9F4: .word aSendBufferSize
_0206B9F8: .word aWfsInitparentC
_0206B9FC: .word WH_Alloc
_0206BA00: .word aUnknownConnect
	arm_func_end WH_ParentConnect

	arm_func_start WH_ChildConnect
WH_ChildConnect: // 0x0206BA04
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _0206BBD8 // =whConfig
	mov r5, r0
	ldr r0, [r2, #0x1c]
	mov r4, r1
	cmp r0, #1
	beq _0206BA28
	bl OS_Terminate
	movs r0, #0
_0206BA28:
	cmp r5, #7
	bne _0206BA9C
	ldr r0, _0206BBD8 // =whConfig
	ldrh r1, [r0, #6]
	ldrh r0, [r0, #0x14]
	add r1, r1, #0x23
	add r0, r0, #0x21
	bic r1, r1, #0x1f
	bic r0, r0, #0x1f
	cmp r1, r0
	movle r1, r0
	ldr r0, _0206BBD8 // =whConfig
	str r1, [r0, #0x48]
	ldrh r2, [r0, #0x14]
	ldrh r1, [r0, #0x10]
	ldrh r0, [r0, #6]
	add r2, r2, #0xe
	mul r1, r2, r1
	add r1, r1, #0x29
	bic r1, r1, #0x1f
	add r0, r0, #0x55
	bic r0, r0, #0x1f
	mov r1, r1, lsl #1
	cmp r1, r0, lsl #1
	mov r0, r0, lsl #1
	movle r1, r0
	ldr r0, _0206BBD8 // =whConfig
	str r1, [r0, #0x34]
	b _0206BACC
_0206BA9C:
	ldr r0, _0206BBD8 // =whConfig
	ldrh r1, [r0, #0x10]
	ldrh r2, [r0, #0xc]
	add r1, r1, #1
	mul r1, r2, r1
	add r1, r1, #0x59
	bic r1, r1, #0x1f
	mov r3, r1, lsl #1
	add r1, r2, #0x21
	str r3, [r0, #0x34]
	bic r1, r1, #0x1f
	str r1, [r0, #0x48]
_0206BACC:
	ldr r0, _0206BBD8 // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BAE8
	ldr r1, [r0, #0x34]
	ldr r0, _0206BBDC // =aRecvBufferSize
	blx r2
_0206BAE8:
	ldr r0, _0206BBD8 // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BB04
	ldr r1, [r0, #0x48]
	ldr r0, _0206BBE0 // =aSendBufferSize
	blx r2
_0206BB04:
	ldr r1, _0206BBD8 // =whConfig
	mov r0, #3
	str r5, [r1, #0x2c]
	bl WH_ChangeSysState
	cmp r5, #7
	addls pc, pc, r5, lsl #2
	b _0206BBB4
_0206BB20: // jump table
	b _0206BBB4 // case 0
	b _0206BB74 // case 1
	b _0206BBB4 // case 2
	b _0206BB74 // case 3
	b _0206BBB4 // case 4
	b _0206BB74 // case 5
	b _0206BBB4 // case 6
	b _0206BB40 // case 7
_0206BB40:
	ldr r0, _0206BBD8 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206BB58
	ldr r0, _0206BBE4 // =aWfsInitchildCa
	blx r1
_0206BB58:
	mov r1, #0
	ldr r2, _0206BBE8 // =WH_Alloc
	mov r3, r1
	mov r0, #1
	bl WFS_InitChild
	mov r0, #1
	bl WFS_SetDebugMode
_0206BB74:
	ldr r1, _0206BBEC // =sBssDesc
	mov r0, r4
	mov r2, #0xc0
	bl MI_CpuCopy8
	ldr r0, _0206BBEC // =sBssDesc
	mov r1, #0xc0
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	ldr r0, _0206BBD8 // =whConfig
	ldr r0, [r0, #0x18]
	cmp r0, #0
	beq _0206BBAC
	bl WH_StateInSetChildWEPKey
	ldmia sp!, {r3, r4, r5, pc}
_0206BBAC:
	bl WH_StateInStartChild
	ldmia sp!, {r3, r4, r5, pc}
_0206BBB4:
	ldr r0, _0206BBD8 // =whConfig
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BBD0
	ldr r0, _0206BBF0 // =aUnknownConnect
	mov r1, r5
	blx r2
_0206BBD0:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206BBD8: .word whConfig
_0206BBDC: .word aRecvBufferSize
_0206BBE0: .word aSendBufferSize
_0206BBE4: .word aWfsInitchildCa
_0206BBE8: .word WH_Alloc
_0206BBEC: .word sBssDesc
_0206BBF0: .word aUnknownConnect
	arm_func_end WH_ChildConnect

	arm_func_start WH_SetJudgeAcceptFunc
WH_SetJudgeAcceptFunc: // 0x0206BBF4
	ldr r1, _0206BC00 // =whConfig
	str r0, [r1, #0x50]
	bx lr
	.align 2, 0
_0206BC00: .word whConfig
	arm_func_end WH_SetJudgeAcceptFunc

	arm_func_start WH_SetReceiver
WH_SetReceiver: // 0x0206BC04
	stmdb sp!, {r3, lr}
	ldr r2, _0206BC4C // =whConfig
	ldr r1, _0206BC50 // =WH_PortReceiveCallback
	str r0, [r2, #0x24]
	mov r0, #0xe
	mov r2, #0
	bl WM_SetPortCallback
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldr r0, _0206BC4C // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, _0206BC54 // =aWmNotInitializ
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206BC4C: .word whConfig
_0206BC50: .word WH_PortReceiveCallback
_0206BC54: .word aWmNotInitializ
	arm_func_end WH_SetReceiver

	arm_func_start WH_SendData
WH_SendData: // 0x0206BC58
	ldr ip, _0206BC60 // =WH_StateInSetMPData
	bx ip
	.align 2, 0
_0206BC60: .word WH_StateInSetMPData
	arm_func_end WH_SendData

	arm_func_start WH_GetSharedDataAdr
WH_GetSharedDataAdr: // 0x0206BC64
	ldr ip, _0206BC78 // =WM_GetSharedDataAddress
	mov r2, r0
	ldr r0, _0206BC7C // =WMDataSharingInfo
	ldr r1, _0206BC80 // =sDataSet
	bx ip
	.align 2, 0
_0206BC78: .word WM_GetSharedDataAddress
_0206BC7C: .word WMDataSharingInfo
_0206BC80: .word sDataSet
	arm_func_end WH_GetSharedDataAdr

	arm_func_start WH_StepDS
WH_StepDS: // 0x0206BC84
	stmdb sp!, {r4, lr}
	mov r1, r0
	ldr r0, _0206BCF0 // =WMDataSharingInfo
	ldr r2, _0206BCF4 // =sDataSet
	bl WM_StepDataSharing
	mov r4, r0
	cmp r4, #7
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	cmp r4, #5
	bne _0206BCD8
	ldr r0, _0206BCF8 // =whConfig
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206BCC8
	ldr r0, _0206BCFC // =aWhStepdatashar
	blx r1
_0206BCC8:
	mov r0, r4
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r4, pc}
_0206BCD8:
	cmp r4, #0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206BCF0: .word WMDataSharingInfo
_0206BCF4: .word sDataSet
_0206BCF8: .word whConfig
_0206BCFC: .word aWhStepdatashar
	arm_func_end WH_StepDS

	arm_func_start WH_Reset
WH_Reset: // 0x0206BD00
	stmdb sp!, {r3, lr}
	bl WFS_End
	ldr r0, _0206BD44 // =whConfig
	ldr r0, [r0, #0x1c]
	cmp r0, #5
	bne _0206BD2C
	ldr r0, _0206BD48 // =WMDataSharingInfo
	bl WM_EndDataSharing
	cmp r0, #0
	beq _0206BD2C
	bl WH_SetError
_0206BD2C:
	bl WH_StateInReset
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206BD44: .word whConfig
_0206BD48: .word WMDataSharingInfo
	arm_func_end WH_Reset

	arm_func_start WH_Finalize
WH_Finalize: // 0x0206BD4C
	stmdb sp!, {r3, lr}
	ldr r0, _0206BE90 // =whConfig
	ldr r1, [r0, #0x1c]
	cmp r1, #1
	bne _0206BD78
	ldr r1, [r0, #0x44]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, _0206BE94 // =aAlreadyWhSysst
	blx r1
	ldmia sp!, {r3, pc}
_0206BD78:
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BD8C
	ldr r0, _0206BE98 // =aWhFinalizeStat
	blx r2
_0206BD8C:
	ldr r0, _0206BE90 // =whConfig
	ldr r0, [r0, #0x1c]
	cmp r0, #2
	bne _0206BDB0
	bl WH_EndScan
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BDB0:
	cmp r0, #6
	cmpne r0, #5
	cmpne r0, #4
	mov r0, #3
	beq _0206BDD0
	bl WH_ChangeSysState
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BDD0:
	bl WH_ChangeSysState
	ldr r0, _0206BE90 // =whConfig
	ldr r0, [r0, #0x2c]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, pc}
_0206BDE8: // jump table
	b _0206BE7C // case 0
	b _0206BE38 // case 1
	b _0206BE4C // case 2
	b _0206BE08 // case 3
	b _0206BE64 // case 4
	b _0206BE20 // case 5
	b _0206BE60 // case 6
	b _0206BE1C // case 7
_0206BE08:
	bl WH_StateInEndChildKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE1C:
	bl WFS_End
_0206BE20:
	ldr r0, _0206BE9C // =WMDataSharingInfo
	bl WM_EndDataSharing
	cmp r0, #0
	beq _0206BE38
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE38:
	bl WH_StateInEndChildMP
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE4C:
	bl WH_StateInEndParentKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE60:
	bl WFS_End
_0206BE64:
	ldr r0, _0206BE9C // =WMDataSharingInfo
	bl WM_EndDataSharing
	cmp r0, #0
	beq _0206BE7C
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE7C:
	bl WH_StateInEndParentMP
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206BE90: .word whConfig
_0206BE94: .word aAlreadyWhSysst
_0206BE98: .word aWhFinalizeStat
_0206BE9C: .word WMDataSharingInfo
	arm_func_end WH_Finalize

	arm_func_start WH_End
WH_End: // 0x0206BEA0
	stmdb sp!, {r3, lr}
	ldr r0, _0206BEE4 // =whConfig
	ldr r0, [r0, #0x1c]
	cmp r0, #1
	beq _0206BEB8
	bl OS_Terminate
_0206BEB8:
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206BEE8 // =WH_StateOutEnd
	bl WM_End
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206BEE4: .word whConfig
_0206BEE8: .word WH_StateOutEnd
	arm_func_end WH_End

	arm_func_start WH_GetCurrentAid
WH_GetCurrentAid: // 0x0206BEEC
	ldr r0, _0206BEF8 // =whConfig
	ldrh r0, [r0, #8]
	bx lr
	.align 2, 0
_0206BEF8: .word whConfig
	arm_func_end WH_GetCurrentAid

	arm_func_start WFSi_ReadRomCallback
WFSi_ReadRomCallback: // 0x0206BEFC
	stmdb sp!, {r3, lr}
	mov r0, r2
	mov r2, r3
	bl MI_CpuCopy8
	mov r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end WFSi_ReadRomCallback

	arm_func_start WFSi_WriteRomCallback
WFSi_WriteRomCallback: // 0x0206BF14
	mov r0, #1
	bx lr
	arm_func_end WFSi_WriteRomCallback

	arm_func_start WFSi_RomArchiveProc
WFSi_RomArchiveProc: // 0x0206BF1C
	stmdb sp!, {r3, lr}
	cmp r1, #0
	beq _0206BF34
	cmp r1, #1
	beq _0206BF74
	b _0206BF7C
_0206BF34:
	ldr r1, _0206BF84 // =wfsi_work
	ldr r1, [r1, #0]
	cmp r1, #0
	beq _0206BF50
	ldr r1, [r1, #0xc]
	cmp r1, #2
	beq _0206BF58
_0206BF50:
	mov r0, #5
	ldmia sp!, {r3, pc}
_0206BF58:
	ldr r1, [r0, #0x38]
	cmp r1, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	bl WFSi_ReadRequest
	mov r0, #6
	ldmia sp!, {r3, pc}
_0206BF74:
	mov r0, #4
	ldmia sp!, {r3, pc}
_0206BF7C:
	mov r0, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206BF84: .word wfsi_work
	arm_func_end WFSi_RomArchiveProc

	arm_func_start WFSi_LoadTables
WFSi_LoadTables: // 0x0206BF88
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xf4
	movs r5, r0
	mov r0, #0
	moveq r4, #1
	movne r4, r0
	str r0, [sp, #4]
	cmp r4, #0
	mov r8, #0
	bne _0206BFB8
	cmp r1, #0
	movne r8, #1
_0206BFB8:
	add r0, sp, #0x4c
	bl FS_InitFile
	mov r1, #0
	add r0, sp, #0x4c
	sub r2, r1, #0x80000001
	bl FS_CreateFileFromRom
	cmp r4, #0
	beq _0206BFEC
	mov r4, #0
	mov r6, r4
	bl CARD_GetRomHeader
	mov r7, r0
	b _0206C024
_0206BFEC:
	ldr r1, [r5, #0x24]
	ldr r0, [r5, #0x2c]
	add r7, sp, #0x94
	sub r9, r0, r1
	add r4, r9, r1
	mov r0, r5
	mov r1, r7
	mov r2, #0x60
	mov r6, r4
	bl FS_ReadFile
	mov r0, r5
	mov r1, r9
	mov r2, #0
	bl FS_SeekFile
_0206C024:
	cmp r8, #0
	bne _0206C070
	ldr r1, [r7, #0x48]
	ldr r0, [r7, #0x4c]
	str r1, [sp, #0x2c]
	str r0, [sp, #0x30]
	ldr r1, [r7, #0x40]
	ldr r0, [r7, #0x44]
	str r1, [sp, #0x34]
	str r0, [sp, #0x38]
	ldr r1, [r7, #0x50]
	ldr r0, [r7, #0x54]
	str r1, [sp, #0x3c]
	str r0, [sp, #0x40]
	ldr r1, [r7, #0x58]
	ldr r0, [r7, #0x5c]
	str r1, [sp, #0x44]
	str r0, [sp, #0x48]
	b _0206C0C4
_0206C070:
	bl CARD_GetRomHeader
	ldr r1, [r0, #0x48]
	ldr r0, [r0, #0x4c]
	str r1, [sp, #0x2c]
	str r0, [sp, #0x30]
	bl CARD_GetRomHeader
	ldr r1, [r0, #0x40]
	ldr r0, [r0, #0x44]
	mov r6, #0
	str r1, [sp, #0x34]
	str r0, [sp, #0x38]
	ldr r0, [r7, #0x50]
	add r0, r0, r4
	str r0, [sp, #0x3c]
	ldr r0, [r7, #0x54]
	str r0, [sp, #0x40]
	ldr r0, [r7, #0x58]
	add r0, r0, r4
	str r0, [sp, #0x44]
	ldr r0, [r7, #0x5c]
	str r0, [sp, #0x48]
_0206C0C4:
	ldr r0, [sp, #4]
	mov r2, #0
	add r0, r0, #4
	str r0, [sp, #4]
	add r1, sp, #0x2c
	mov r0, #2
	add r9, sp, #0x1c
_0206C0E0:
	add r3, r1, r2, lsl #3
	cmp r2, #0
	ldr r5, [r3, #4]
	bne _0206C118
	cmp r8, #0
	beq _0206C118
	mov r10, r0
_0206C0FC:
	add r3, r1, r10, lsl #3
	ldr r3, [r3, #4]
	add r10, r10, #1
	mov r3, r3, lsr #5
	cmp r10, #4
	add r5, r5, r3, lsl #3
	blt _0206C0FC
_0206C118:
	add r3, r5, #0x1f
	bic r3, r3, #0x1f
	str r3, [r9, r2, lsl #2]
	add r5, r3, #4
	ldr r3, [sp, #4]
	add r2, r2, #1
	add r3, r3, r5
	cmp r2, #4
	str r3, [sp, #4]
	blt _0206C0E0
	bl OS_DisableInterrupts
	ldr r1, _0206C2E8 // =wfsi_work
	mov r5, r0
	ldr r2, [r1, #0]
	ldr r1, [sp, #4]
	ldr r0, [r2, #0x18]
	ldr r3, [r2, #0x14]
	mov r2, #0
	blx r3
	str r0, [sp, #8]
	mov r0, r5
	bl OS_RestoreInterrupts
	ldr r0, [sp, #8]
	mov r10, #0
	str r6, [r0]
	add r9, r0, #4
	add r5, sp, #0x2c
	add r11, sp, #0x4c
_0206C188:
	add r0, r5, r10, lsl #3
	ldr r1, [r0, #4]
	add r0, sp, #0xc
	str r1, [r9]
	ldr r1, [r5, r10, lsl #3]
	str r9, [r0, r10, lsl #2]
	mov r0, r11
	mov r2, #0
	add r1, r6, r1
	bl FS_SeekFile
	ldr r2, [r9, #0]
	mov r0, r11
	add r1, r9, #4
	bl FS_ReadFile
	add r0, sp, #0x1c
	ldr r0, [r0, r10, lsl #2]
	add r10, r10, #1
	add r0, r0, #4
	add r9, r9, r0
	cmp r10, #4
	blt _0206C188
	cmp r8, #0
	beq _0206C2AC
	ldr r2, [sp, #0xc]
	ldr r0, [r7, #0x48]
	ldr r1, [r2, #0]
	add r11, r4, r0
	mov r0, #2
	add r5, r2, #4
	mov r6, r1, lsr #3
	add r10, r5, r6, lsl #3
	str r0, [sp]
_0206C208:
	ldr r0, [sp]
	add r1, sp, #0xc
	ldr r0, [r1, r0, lsl #2]
	mov r9, #0
	add r7, r0, #4
	ldr r0, [r0, #0]
	mov r8, r0, lsr #5
	cmp r8, #0
	ble _0206C28C
_0206C22C:
	add r1, r7, r9, lsl #5
	ldr r1, [r1, #0x18]
	add r0, sp, #0x4c
	mov r2, #0
	add r1, r11, r1, lsl #3
	bl FS_SeekFile
	add r0, sp, #0x4c
	mov r1, r10
	mov r2, #8
	bl FS_ReadFile
	ldr r2, [r5, r6, lsl #3]
	add r1, r7, r9, lsl #5
	add r2, r2, r4
	add r9, r9, #1
	add r0, r5, r6, lsl #3
	str r2, [r5, r6, lsl #3]
	ldr r2, [r0, #4]
	add r10, r10, #8
	add r2, r2, r4
	str r2, [r0, #4]
	str r6, [r1, #0x18]
	add r6, r6, #1
	cmp r9, r8
	blt _0206C22C
_0206C28C:
	ldr r0, [sp]
	add r0, r0, #1
	str r0, [sp]
	cmp r0, #4
	blt _0206C208
	ldr r0, [sp, #0xc]
	mov r1, r6, lsl #3
	str r1, [r0]
_0206C2AC:
	ldr r0, [sp, #8]
	ldr r1, [sp, #4]
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	add r0, sp, #0x4c
	bl FS_CloseFile
	ldr r1, _0206C2E8 // =wfsi_work
	ldr r0, [sp, #8]
	ldr r2, [r1, #0]
	str r0, [r2, #0x20]
	ldr r1, [r1, #0]
	ldr r0, [sp, #4]
	str r0, [r1, #0x24]
	add sp, sp, #0xf4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0206C2E8: .word wfsi_work
	arm_func_end WFSi_LoadTables

	arm_func_start WFSi_ReplaceRomArchive
WFSi_ReplaceRomArchive: // 0x0206C2EC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x30
	mov r6, r0
	ldr r0, _0206C398 // =0x0211AA30
	mov r1, #3
	bl FS_FindArchive
	mov r5, r0
	bl FS_UnloadArchive
	ldr r1, _0206C39C // =WFSi_RomArchiveProc
	mov r0, r5
	mvn r2, #0
	bl FS_SetArchiveProc
	ldr r4, [r6], #4
	mov r3, #0
	add r2, sp, #0x10
_0206C328:
	add r0, r6, #4
	str r0, [r2, r3, lsl #3]
	ldr r1, [r6, #0]
	add r0, r2, r3, lsl #3
	str r1, [r0, #4]
	add r0, r1, #0x1f
	ldr r1, [r2, r3, lsl #3]
	bic r0, r0, #0x1f
	add r3, r3, #1
	cmp r3, #4
	add r6, r1, r0
	blt _0206C328
	ldr r0, [sp, #0x18]
	ldr r1, _0206C3A0 // =WFSi_ReadRomCallback
	str r0, [sp]
	ldr r2, [sp, #0x1c]
	ldr r0, _0206C3A4 // =WFSi_WriteRomCallback
	str r2, [sp, #4]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	ldr r2, [sp, #0x10]
	ldr r3, [sp, #0x14]
	mov r0, r5
	mov r1, #0
	bl FS_LoadArchive
	mov r0, r4
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0206C398: .word 0x0211AA30
_0206C39C: .word WFSi_RomArchiveProc
_0206C3A0: .word WFSi_ReadRomCallback
_0206C3A4: .word WFSi_WriteRomCallback
	arm_func_end WFSi_ReplaceRomArchive

	arm_func_start WFSi_OnSendMessageDone
WFSi_OnSendMessageDone: // 0x0206C3A8
	stmdb sp!, {r3, lr}
	ldr r1, _0206C3EC // =wfsi_work
	ldr r2, [r1, #0]
	cmp r2, #0
	ldrne r1, [r2, #0xc]
	cmpne r1, #0
	ldrne r1, [r2, #0]
	cmpne r1, #0
	ldmeqia sp!, {r3, pc}
	ldrh r0, [r0, #8]
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	add r0, r2, #0x10000
	mov r1, #0
	str r1, [r0, #0xb94]
	bl WFSi_SendAck
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206C3EC: .word wfsi_work
	arm_func_end WFSi_OnSendMessageDone

	arm_func_start WFSi_SendMessage
WFSi_SendMessage: // 0x0206C3F0
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr ip, [sp]
	and r0, r0, #0xf
	bic ip, ip, #0xf
	orr ip, ip, r0
	and ip, ip, #0xff
	orr ip, ip, r3, lsl #8
	ldr r0, _0206C460 // =wfsi_work
	str r2, [sp, #4]
	ldr r3, [r0, #0]
	str ip, [sp]
	ldr r0, [r3, #0x28]
	bic r2, ip, #0xf0
	mov r0, r0, asr #8
	and r0, r0, #0xff
	mov r0, r0, lsl #0x1c
	orr r0, r2, r0, lsr #24
	str r0, [sp]
	ldr ip, [r3, #0x28]
	mov r0, r1
	ldr r3, _0206C464 // =WFSi_OnSendMessageDone
	add r1, sp, #0
	mov r2, #9
	strb ip, [sp, #8]
	bl WBT_PutUserData
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0206C460: .word wfsi_work
_0206C464: .word WFSi_OnSendMessageDone
	arm_func_end WFSi_SendMessage

	arm_func_start WFSi_SendAck
WFSi_SendAck: // 0x0206C468
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r0, _0206C6E4 // =wfsi_work
	ldr r2, [r0, #0]
	cmp r2, #0
	ldrne r0, [r2, #0]
	add r4, r2, #0x440
	cmpne r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r3, r4, #0x10000
	ldr r0, [r3, #0x754]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [r3, #0x74c]
	ldr r0, [r3, #0x758]
	and r0, r1, r0
	str r0, [r3, #0x74c]
	ldr r1, [r3, #0x750]
	ldr r0, [r3, #0x758]
	and r0, r1, r0
	str r0, [r3, #0x750]
	ldr r1, [r3, #0x75c]
	ldr r0, [r3, #0x758]
	and r0, r1, r0
	str r0, [r3, #0x75c]
	ldr r1, [r3, #0x768]
	ldr r0, [r3, #0x758]
	and r0, r1, r0
	str r0, [r3, #0x768]
	ldr r0, [r3, #0x760]
	cmp r0, #0
	beq _0206C550
	ldr r0, [r3, #0x764]
	cmp r0, #0
	bne _0206C550
	ldr r0, [r3, #0x76c]
	ldr r1, [r2, #0x2c]
	mov r5, #0
	str r5, [r3, #0x760]
	str r0, [r2, #0x28]
	bl WBT_SetPacketSize
	add r0, r4, #0x10000
	ldr r0, [r0, #0x768]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r0, lsl #0x10
	mov r2, r5
	mov r1, r0, lsr #0x10
	mov r3, r2
	mov r0, #1
	bl WFSi_SendMessage
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r0, r4, #0x10000
	mov r1, #1
	str r1, [r0, #0x754]
	mov r1, r5
	str r1, [r0, #0x768]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0206C550:
	add r0, r4, #0x10000
	ldr r5, [r0, #0x74c]
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r3, [r0, #0x750]
	mov r1, #0
	cmp r3, #0
	beq _0206C580
	and r0, r3, r5
	cmp r3, r0
	moveq r6, #1
	beq _0206C584
_0206C580:
	mov r6, #0
_0206C584:
	cmp r6, #0
	movne r5, r3
	mvneq r0, r3
	andeq r5, r5, r0
	mov lr, r4
	mov r2, #0
	mov r0, #1
_0206C5A0:
	cmp r5, r0, lsl r2
	mov ip, r0, lsl r2
	blt _0206C5F8
	tst ip, r5
	beq _0206C5EC
	cmp r1, #0
	moveq r1, lr
	beq _0206C5EC
	ldr r8, [r1, #0]
	ldr r7, [lr]
	mov r8, r8, lsl #0x1c
	mov r8, r8, lsr #0x1c
	mov r7, r7, lsl #0x1c
	cmp r8, r7, lsr #28
	ldreq r8, [r1, #4]
	ldreq r7, [lr, #4]
	cmpeq r8, r7
	mvnne ip, ip
	andne r5, r5, ip
_0206C5EC:
	add lr, lr, #0xc
	add r2, r2, #1
	b _0206C5A0
_0206C5F8:
	cmp r6, #0
	cmpne r5, r3
	addne r0, r4, #0x10000
	movne r2, #0
	strne r2, [r0, #0x750]
	cmp r1, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r1, #0]
	mov r2, r0, lsl #0x1c
	movs r2, r2, lsr #0x1c
	beq _0206C630
	cmp r2, #2
	beq _0206C640
	b _0206C698
_0206C630:
	bic r0, r0, #0xf
	orr r0, r0, #1
	str r0, [r1]
	b _0206C698
_0206C640:
	bic r0, r0, #0xf
	orr r0, r0, #3
	str r0, [r1]
	add r0, r4, #0x10000
	ldr r3, [r0, #0x75c]
	mvn r2, r5
	and r2, r3, r2
	mov r6, #1
	str r2, [r0, #0x75c]
	mov r3, r6
_0206C668:
	tst r5, r3, lsl r6
	beq _0206C684
	add r0, r4, r6, lsl #2
	add r0, r0, #0x10000
	ldr r2, [r0, #0x770]
	add r2, r2, #1
	str r2, [r0, #0x770]
_0206C684:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x10
	blo _0206C668
_0206C698:
	ldr r0, [r1, #0]
	mov r3, r5, lsl #0x10
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	ldr r2, [r1, #4]
	mov r1, r3, lsr #0x10
	and r0, r0, #0xff
	mov r3, #1
	bl WFSi_SendMessage
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r0, r4, #0x10000
	mov r1, #1
	str r1, [r0, #0x754]
	ldr r2, [r0, #0x74c]
	mvn r1, r5
	and r1, r2, r1
	str r1, [r0, #0x74c]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0206C6E4: .word wfsi_work
	arm_func_end WFSi_SendAck

	arm_func_start WFSi_SendOpenAck
WFSi_SendOpenAck: // 0x0206C6E8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r6, r1
	bl OS_DisableInterrupts
	ldr r1, _0206C7C8 // =wfsi_work
	mov r4, r0
	ldr r0, [r1, #0]
	cmp r0, #0
	ldrne r0, [r0, #0xc]
	cmpne r0, #0
	beq _0206C7B8
	ldr r5, [r6, #0x88]
	mov r3, #0
	str r3, [r6, #0x88]
	add r0, r7, #0x10000
	ldr r1, [r0, #0x74c]
	orr r1, r1, r5
	str r1, [r0, #0x74c]
	ldr r0, [r6, #0x84]
	cmp r0, #0
	bgt _0206C77C
	ldr r2, [r6, #0x60]
	ldr r0, [r6, #0x5c]
	ldr r1, [r6, #0x8c]
	sub r0, r2, r0
	cmp r0, #0x400
	str r0, [sp]
	mov ip, #0
	ldr r2, _0206C7CC // =wfsi_def_user_data
	addls r3, r6, #0xc0
	add r0, r6, #4
	str ip, [sp, #4]
	bl WBT_RegisterBlock
	mov r0, r7
	mov r1, r6
	bl WFSi_FromBusyToAlive
_0206C77C:
	mov r2, #0
	mov r1, #1
_0206C784:
	cmp r5, r1, lsl r2
	mov r0, r1, lsl r2
	blt _0206C7B8
	tst r0, r5
	beq _0206C7AC
	ldr r0, [r6, #0x84]
	add r0, r0, #1
	str r0, [r6, #0x84]
	ldr r0, [r6, #0x8c]
	str r0, [r7, #4]
_0206C7AC:
	add r7, r7, #0xc
	add r2, r2, #1
	b _0206C784
_0206C7B8:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206C7C8: .word wfsi_work
_0206C7CC: .word wfsi_def_user_data
	arm_func_end WFSi_SendOpenAck

	arm_func_start WFSi_FindAlive
WFSi_FindAlive: // 0x0206C7D0
	add r0, r0, #0x10000
	ldr r0, [r0, #0x744]
	cmp r0, #0
	bxeq lr
_0206C7E0:
	ldr r3, [r0, #0x80]
	cmp r3, #2
	ldreq ip, [r0, #0x5c]
	cmpeq r1, ip
	ldreq r3, [r0, #0x60]
	subeq r3, r3, ip
	cmpeq r2, r3
	bxeq lr
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0206C7E0
	bx lr
	arm_func_end WFSi_FindAlive

	arm_func_start WFSi_FindBusy
WFSi_FindBusy: // 0x0206C810
	stmdb sp!, {r4, r5, r6, lr}
	add r3, r0, #0x10000
	ldr r4, [r3, #0x748]
	mov r6, r1
	mov r5, r2
	cmp r4, #0
	beq _0206C854
_0206C82C:
	ldr r1, [r4, #0x80]
	cmp r1, #1
	ldreq r1, [r4, #0x90]
	cmpeq r1, r6
	ldreq r1, [r4, #0x94]
	cmpeq r1, r5
	beq _0206C854
	ldr r4, [r4, #0]
	cmp r4, #0
	bne _0206C82C
_0206C854:
	cmp r4, #0
	bne _0206C878
	bl WFSi_FromFreeToBusy
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x84]
	str r6, [r4, #0x90]
	str r5, [r4, #0x94]
	bl WFSi_NotifyBusy
_0206C878:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end WFSi_FindBusy

	arm_func_start WFSi_FindAliveForID
WFSi_FindAliveForID: // 0x0206C880
	add r0, r0, #0x10000
	ldr r0, [r0, #0x744]
	cmp r0, #0
	bxeq lr
_0206C890:
	ldr r2, [r0, #0x80]
	cmp r2, #2
	ldreq r2, [r0, #4]
	cmpeq r2, r1
	bxeq lr
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0206C890
	bx lr
	arm_func_end WFSi_FindAliveForID

	arm_func_start WFSi_MoveList
WFSi_MoveList: // 0x0206C8B4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl OS_DisableInterrupts
	ldr r1, [r6, #0]
	cmp r1, #0
	beq _0206C924
_0206C8D4:
	ldr r2, [r6, #0]
	cmp r2, r4
	bne _0206C914
	ldr r1, [r4, #0]
	str r1, [r6]
	ldr r1, [r5, #0]
	cmp r1, #0
	beq _0206C904
_0206C8F4:
	mov r5, r1
	ldr r1, [r1, #0]
	cmp r1, #0
	bne _0206C8F4
_0206C904:
	str r4, [r5]
	mov r1, #0
	str r1, [r4]
	b _0206C924
_0206C914:
	ldr r1, [r2, #0]
	mov r6, r2
	cmp r1, #0
	bne _0206C8D4
_0206C924:
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end WFSi_MoveList

	arm_func_start WFSi_FromFreeToBusy
WFSi_FromFreeToBusy: // 0x0206C92C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0x10000
	ldr r4, [r0, #0x740]
	add r0, r5, #0x740
	add r1, r5, #0x348
	mov r2, r4
	add r0, r0, #0x10000
	add r1, r1, #0x10400
	bl WFSi_MoveList
	mov r0, #1
	str r0, [r4, #0x80]
	add r1, r5, #0x10000
	ldr r2, [r1, #0x764]
	mov r0, r4
	add r2, r2, #1
	str r2, [r1, #0x764]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end WFSi_FromFreeToBusy

	arm_func_start WFSi_FromBusyToAlive
WFSi_FromBusyToAlive: // 0x0206C974
	stmdb sp!, {r4, lr}
	mov r4, r1
	add r1, r0, #0x348
	add r3, r0, #0x344
	add r0, r1, #0x10400
	mov r2, r4
	add r1, r3, #0x10400
	bl WFSi_MoveList
	mov r0, #2
	str r0, [r4, #0x80]
	ldmia sp!, {r4, pc}
	arm_func_end WFSi_FromBusyToAlive

	arm_func_start WFSi_FromAliveToBusy
WFSi_FromAliveToBusy: // 0x0206C9A0
	stmdb sp!, {r4, lr}
	mov r4, r1
	add r1, r0, #0x344
	add r3, r0, #0x348
	add r0, r1, #0x10400
	mov r2, r4
	add r1, r3, #0x10400
	bl WFSi_MoveList
	mov r0, #3
	str r0, [r4, #0x80]
	ldmia sp!, {r4, pc}
	arm_func_end WFSi_FromAliveToBusy

	arm_func_start WFSi_FromBusyToFree
WFSi_FromBusyToFree: // 0x0206C9CC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	add r0, r5, #0x348
	add r1, r5, #0x740
	mov r2, r4
	add r0, r0, #0x10400
	add r1, r1, #0x10000
	bl WFSi_MoveList
	mov r0, #0
	str r0, [r4, #0x80]
	add r0, r5, #0x10000
	ldr r1, [r0, #0x764]
	sub r1, r1, #1
	str r1, [r0, #0x764]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end WFSi_FromBusyToFree

	arm_func_start WFSi_ReadRequest
WFSi_ReadRequest: // 0x0206CA0C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _0206CA60 // =wfsi_work
	mov r5, r0
	ldr r4, [r1, #0]
	ldr r1, [r5, #0x38]
	add r0, r4, #0x440
	bl WFSi_ReallocBitmap
	ldr r1, _0206CA60 // =wfsi_work
	mov r0, #0
	ldr r2, [r1, #0]
	mov r1, #1
	str r5, [r2, #0x1c]
	ldr ip, [r4, #0xf44]
	ldr r2, [r5, #0x2c]
	ldr r3, [r5, #0x38]
	add r2, ip, r2
	bl WFSi_SendMessage
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl OS_Terminate
	arm_func_end WFSi_ReadRequest

	arm_func_start sub_206ca5c
sub_206ca5c: // 0x0206CA5C
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206CA60: .word wfsi_work
	arm_func_end sub_206ca5c

	arm_func_start WFSi_SetMPData
WFSi_SetMPData: // 0x0206CA64
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldr r0, _0206CB18 // =wfsi_work
	ldr r4, [r0, #0]
	ldr r2, [r4, #0]
	cmp r2, #0
	ldrne r0, [r4, #0x28]
	ldreq r0, [r4, #0x2c]
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldr r0, [r4, #4]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	cmp r2, #0
	add r0, r4, #0x40
	beq _0206CAB0
	bl WBT_MpParentSendHook
	b _0206CAB4
_0206CAB0:
	bl WBT_MpChildSendHook
_0206CAB4:
	ldr r1, _0206CB1C // =0x0000FFFF
	mov r0, r0, lsl #0x10
	str r1, [sp]
	ldrh r1, [r4, #0x30]
	mov r3, r0, lsr #0x10
	ldr r0, _0206CB20 // =WFSi_OnSetMPDataDone
	str r1, [sp, #4]
	mov ip, #3
	add r2, r4, #0x40
	mov r1, #0
	str ip, [sp, #8]
	bl WM_SetMPDataToPort
	cmp r0, #2
	moveq r1, #1
	movne r1, #0
	ldr r0, _0206CB18 // =wfsi_work
	str r1, [r4, #8]
	ldr r0, [r0, #0]
	ldr r0, [r0, #8]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	str r0, [r4, #4]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0206CB18: .word wfsi_work
_0206CB1C: .word 0x0000FFFF
_0206CB20: .word WFSi_OnSetMPDataDone
	arm_func_end WFSi_SetMPData

	arm_func_start WFSi_OnSetMPDataDone
WFSi_OnSetMPDataDone: // 0x0206CB24
	stmdb sp!, {r3, lr}
	ldr r0, _0206CB54 // =wfsi_work
	ldr r1, [r0, #0]
	cmp r1, #0
	ldrne r0, [r1, #0xc]
	cmpne r0, #0
	ldmeqia sp!, {r3, pc}
	mov r0, #1
	str r0, [r1, #4]
	bl WFSi_SendAck
	bl WFSi_SetMPData
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206CB54: .word wfsi_work
	arm_func_end WFSi_OnSetMPDataDone

	arm_func_start WFSi_PortCallback
WFSi_PortCallback: // 0x0206CB58
	stmdb sp!, {r3, lr}
	ldr r1, _0206CC74 // =wfsi_work
	ldr r3, [r1, #0]
	cmp r3, #0
	ldrne r2, [r3, #0xc]
	add ip, r3, #0x440
	cmpne r2, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	cmp r1, #0x15
	bgt _0206CBA8
	bge _0206CC28
	cmp r1, #9
	ldmgtia sp!, {r3, pc}
	cmp r1, #7
	ldmltia sp!, {r3, pc}
	beq _0206CBC0
	cmp r1, #9
	beq _0206CBE4
	ldmia sp!, {r3, pc}
_0206CBA8:
	cmp r1, #0x1a
	ldmgtia sp!, {r3, pc}
	cmp r1, #0x19
	ldmltia sp!, {r3, pc}
	cmpne r1, #0x1a
	ldmia sp!, {r3, pc}
_0206CBC0:
	ldr r0, [r3, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	cmp r2, #2
	ldreq r0, [r3, #8]
	cmpeq r0, #0
	ldmneia sp!, {r3, pc}
	bl WFSi_SetMPData
	ldmia sp!, {r3, pc}
_0206CBE4:
	ldr r1, [r3, #0]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	cmp r2, #2
	ldmneia sp!, {r3, pc}
	ldrh r2, [r0, #0x12]
	mov r3, #1
	add r1, ip, #0x10000
	mov r0, r3, lsl r2
	mvn r2, r3, lsl r2
	ldr r3, [r1, #0x758]
	mov r0, r0, lsl #0x10
	and r2, r3, r2
	mov r0, r0, lsr #0x10
	str r2, [r1, #0x758]
	bl WBT_CancelCurrentCommand
	ldmia sp!, {r3, pc}
_0206CC28:
	ldr r1, [r3, #0]
	ldr lr, [r0, #0xc]
	cmp r1, #0
	ldrh r1, [r0, #0x10]
	beq _0206CC68
	cmp r2, #2
	bne _0206CC68
	add r3, ip, #0x10000
	ldrh r2, [r0, #0x12]
	ldr ip, [r3, #0x758]
	mov r0, #1
	orr ip, ip, r0, lsl r2
	mov r0, lr
	str ip, [r3, #0x758]
	bl WBT_MpParentRecvHook
	ldmia sp!, {r3, pc}
_0206CC68:
	mov r0, lr
	bl WBT_MpChildRecvHook
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206CC74: .word wfsi_work
	arm_func_end WFSi_PortCallback

	arm_func_start WFSi_OnParentSystemCallback
WFSi_OnParentSystemCallback: // 0x0206CC78
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	ldrh r0, [r4, #0xa]
	bl WBT_AidbitmapToAid
	ldr r1, [r4, #0]
	mov r5, r0
	cmp r1, #0xc
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r4, #4]
	cmp r0, #2
	ldmleia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r0, #0xd
	ldmgtia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r0, #8
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	cmp r0, #0xa
	beq _0206CCCC
	cmp r0, #0xd
	beq _0206CE64
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CCCC:
	ldr r3, _0206CFBC // =wfsi_work
	add r6, r4, #0x14
	ldr r1, [r3, #0]
	mov r0, #0xc
	mla r0, r5, r0, r1
	add r7, r0, #0x440
	ldmia r6, {r0, r1, r2}
	stmia r7, {r0, r1, r2}
	ldr r4, [r4, #0x14]
	mov r0, r4, lsl #0x1c
	movs r0, r0, lsr #0x1c
	beq _0206CD08
	cmp r0, #2
	beq _0206CDEC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CD08:
	ldr r1, [r3, #0]
	mov r3, r4, lsl #0x18
	add r7, r1, #0x440
	add r0, r7, #0x10000
	ldr r0, [r0, #0x760]
	ldrb r2, [r6, #8]
	mov r3, r3, lsr #0x1c
	cmp r0, #0
	ldreq r0, [r1, #0x28]
	orr r2, r2, r3, lsl #8
	mov r4, r4, lsr #8
	ldr r6, [r6, #4]
	cmpeq r2, r0
	beq _0206CD68
	add r0, r7, #0x10000
	mov r2, #1
	str r2, [r0, #0x760]
	ldr r1, [r0, #0x768]
	orr r1, r1, r2, lsl r5
	str r1, [r0, #0x768]
	ldr r1, [r0, #0x75c]
	orr r1, r1, r2, lsl r5
	str r1, [r0, #0x75c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CD68:
	mov r0, r7
	mov r1, r6
	mov r2, r4
	bl WFSi_FindAlive
	cmp r0, #0
	beq _0206CDB4
	add r1, r7, #0x10000
	mov r2, #0xc
	ldr r4, [r1, #0x74c]
	mov r3, #1
	orr r3, r4, r3, lsl r5
	str r3, [r1, #0x74c]
	mla r1, r5, r2, r7
	ldr r2, [r0, #0x8c]
	str r2, [r1, #4]
	ldr r1, [r0, #0x84]
	add r1, r1, #1
	str r1, [r0, #0x84]
	b _0206CDD4
_0206CDB4:
	mov r0, r7
	mov r1, r6
	mov r2, r4
	bl WFSi_FindBusy
	ldr r2, [r0, #0x88]
	mov r1, #1
	orr r1, r2, r1, lsl r5
	str r1, [r0, #0x88]
_0206CDD4:
	add r0, r7, #0x10000
	ldr r2, [r0, #0x75c]
	mov r1, #1
	orr r1, r2, r1, lsl r5
	str r1, [r0, #0x75c]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CDEC:
	ldr r0, [r3, #0]
	add r4, r0, #0x440
	bl OS_DisableInterrupts
	add r1, r4, #0x10000
	ldr r3, [r1, #0x74c]
	mov r2, #1
	orr r2, r3, r2, lsl r5
	str r2, [r1, #0x74c]
	mov r7, r0
	ldr r1, [r6, #4]
	mov r0, r4
	bl WFSi_FindAliveForID
	movs r5, r0
	beq _0206CE58
	ldr r0, [r5, #0x84]
	sub r0, r0, #1
	str r0, [r5, #0x84]
	cmp r0, #0
	bgt _0206CE58
	mov r0, #0
	str r0, [r5, #0x88]
	ldr r0, [r6, #4]
	bl WBT_UnregisterBlock
	mov r0, r4
	mov r1, r5
	bl WFSi_FromAliveToBusy
	bl WFSi_NotifyBusy
_0206CE58:
	mov r0, r7
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206CE64:
	ldr r0, _0206CFBC // =wfsi_work
	ldr r1, [r4, #0x14]
	ldr r0, [r0, #0]
	mov r2, #0
	add r0, r0, #0x440
	str r2, [r4, #0x1c]
	bl WFSi_FindAliveForID
	movs r5, r0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r1, [r5, #0x9c]
	ldrsh r0, [r4, #0x20]
	cmp r1, #2
	ldr r1, [r5, #0x98]
	ldr r2, [r4, #0x18]
	beq _0206CEBC
	ldr r3, [r5, #0x44]
	tst r3, #1
	movne r3, #1
	moveq r3, #0
	cmp r3, #0
	moveq r3, #2
	streq r3, [r5, #0x9c]
_0206CEBC:
	mul ip, r0, r1
	str r2, [r5, #0x98]
	mov r3, #0
	b _0206CF10
_0206CECC:
	ldr r6, [r5, #0x9c]
	cmp r3, r6
	beq _0206CF0C
	add r6, r5, r3, lsl #2
	ldr r6, [r6, #0xa4]
	subs r7, ip, r6
	bmi _0206CF0C
	add r6, r7, r0
	cmp r6, #0x400
	bgt _0206CF0C
	add r6, r5, #0xc0
	add r6, r6, r3, lsl #10
	str r1, [r4, #0x18]
	add r1, r6, r7
	str r1, [r4, #0x1c]
	b _0206CF18
_0206CF0C:
	add r3, r3, #1
_0206CF10:
	cmp r3, #2
	blt _0206CECC
_0206CF18:
	ldr r1, [r5, #0x9c]
	cmp r1, #2
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mul r6, r0, r2
	mov r2, #0
	b _0206CF50
_0206CF30:
	add r1, r5, r2, lsl #2
	ldr r1, [r1, #0xa4]
	subs r1, r6, r1
	bmi _0206CF4C
	add r1, r1, r0
	cmp r1, #0x400
	ble _0206CF58
_0206CF4C:
	add r2, r2, #1
_0206CF50:
	cmp r2, #2
	blt _0206CF30
_0206CF58:
	cmp r2, #2
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r4, [r5, #0xa0]
	mov r0, #0
_0206CF68:
	add r4, r4, #1
	cmp r4, #2
	movge r4, r0
	cmp r4, r3
	beq _0206CF68
	mov r0, #0x200
	str r4, [r5, #0xa0]
	rsb r0, r0, #0
	and r1, r6, r0
	str r4, [r5, #0x9c]
	add r3, r5, r4, lsl #2
	add r0, r5, #0x38
	mov r2, #0
	str r1, [r3, #0xa4]
	bl FS_SeekFile
	add r1, r5, #0xc0
	add r0, r5, #0x38
	add r1, r1, r4, lsl #10
	mov r2, #0x400
	bl FS_ReadFileAsync
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206CFBC: .word wfsi_work
	arm_func_end WFSi_OnParentSystemCallback

	arm_func_start WFSi_ReallocBitmap
WFSi_ReallocBitmap: // 0x0206CFC0
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	cmp r1, #0
	ldrlt r1, [r4, #0xb08]
	movlt r0, #0
	strlt r0, [r4, #0xb08]
	ldr r0, [r4, #0xb08]
	cmp r0, r1
	ldmhsia sp!, {r4, r5, r6, pc}
	str r1, [r4, #0xb08]
	ldr r6, [r4, #0xb00]
	cmp r6, #0
	beq _0206D020
	bl OS_DisableInterrupts
	ldr r1, _0206D088 // =wfsi_work
	mov r5, r0
	ldr r1, [r1, #0]
	mov r2, r6
	ldr r0, [r1, #0x18]
	ldr r3, [r1, #0x14]
	mov r1, #0
	blx r3
	mov r0, r5
	bl OS_RestoreInterrupts
_0206D020:
	ldr r0, _0206D088 // =wfsi_work
	ldr r2, [r4, #0xb08]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x28]
	sub r1, r0, #0xe
	add r0, r2, r1
	sub r0, r0, #1
	bl _u32_div_f
	add r0, r0, #0x1f
	mov r0, r0, lsr #2
	mov r5, r0, lsl #4
	bl OS_DisableInterrupts
	ldr r1, _0206D088 // =wfsi_work
	mov r6, r0
	ldr r2, [r1, #0]
	mov r1, r5
	ldr r0, [r2, #0x18]
	ldr r3, [r2, #0x14]
	mov r2, #0
	blx r3
	mov r5, r0
	mov r0, r6
	bl OS_RestoreInterrupts
	str r5, [r4, #0xb00]
	str r5, [r4, #0x80]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0206D088: .word wfsi_work
	arm_func_end WFSi_ReallocBitmap

	arm_func_start WFSi_OnChildSystemCallback
WFSi_OnChildSystemCallback: // 0x0206D08C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #8
	mov r6, r0
	ldrh r0, [r6, #0xa]
	bl WBT_AidbitmapToAid
	ldr r1, _0206D38C // =wfsi_work
	ldr r3, [r6, #0]
	ldr r2, [r1, #0]
	mov r4, r0
	cmp r3, #6
	add r5, r2, #0x440
	bgt _0206D0E4
	cmp r3, #2
	addlt sp, sp, #8
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
	beq _0206D0F4
	cmp r3, #4
	beq _0206D224
	cmp r3, #6
	beq _0206D180
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D0E4:
	cmp r3, #0xc
	beq _0206D2C0
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D0F4:
	ldrh r0, [r6, #8]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldrsh r0, [r6, #0x16]
	add r0, r0, #0xe
	str r0, [r2, #0x28]
	ldrsh r2, [r6, #0x18]
	ldr r0, [r1, #0]
	add r2, r2, #0xe
	str r2, [r0, #0x2c]
	ldr r1, [r1, #0]
	ldr r0, [r1, #0x20]
	cmp r0, #0
	bne _0206D14C
	ldr r3, _0206D390 // =WFSi_OnChildSystemCallback
	mov r2, r5
	mov r0, #1
	mov r1, #0
	bl sub_20F689C
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D14C:
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, r5
	mvn r1, #0
	bl WFSi_ReallocBitmap
	ldr r0, _0206D38C // =wfsi_work
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x1c]
	bl WFSi_ReadRequest
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D180:
	ldr r0, [r5, r4, lsl #2]
	ldr r0, [r0, #4]
	str r0, [r2, #0x24]
	ldr r0, [r1, #0]
	ldr r6, [r0, #0x24]
	bl OS_DisableInterrupts
	ldr r1, _0206D38C // =wfsi_work
	mov r7, r0
	ldr r2, [r1, #0]
	mov r1, r6
	ldr r0, [r2, #0x18]
	ldr r3, [r2, #0x14]
	mov r2, #0
	blx r3
	mov r6, r0
	mov r0, r7
	bl OS_RestoreInterrupts
	ldr r1, _0206D38C // =wfsi_work
	mov r0, r5
	ldr r2, [r1, #0]
	str r6, [r2, #0x20]
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x24]
	bl WFSi_ReallocBitmap
	ldr r1, _0206D38C // =wfsi_work
	add r6, r5, r4, lsl #2
	ldr r0, [r1, #0]
	add r4, r5, #0x80
	add r2, r5, #0x40
	ldr r5, [r0, #0x20]
	ldr r3, _0206D390 // =WFSi_OnChildSystemCallback
	str r5, [r6, #0x40]
	str r4, [sp]
	str r3, [sp, #4]
	ldr r3, [r1, #0]
	mov r0, #1
	ldr r3, [r3, #0x24]
	mov r1, #0x20000
	bl WBT_GetBlock
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D224:
	ldrh r0, [r6, #8]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r2, #0xc]
	cmp r0, #2
	beq _0206D294
	ldr r0, [r2, #0x20]
	ldr r1, [r2, #0x24]
	bl DC_FlushRange
	ldr r0, _0206D38C // =wfsi_work
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x20]
	bl WFSi_ReplaceRomArchive
	ldr r1, _0206D38C // =wfsi_work
	str r0, [r5, #0xb04]
	ldr r0, [r1, #0]
	mov r2, #2
	str r2, [r0, #0xc]
	ldr r0, [r1, #0]
	ldr r1, [r0, #0x10]
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #0
	blx r1
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D294:
	mov r1, #1
	ldr r2, [r5, #0xb0c]
	mov r3, r1
	mov r0, #2
	bl WFSi_SendMessage
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	bl OS_Terminate
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D2C0:
	ldr r0, [r6, #4]
	cmp r0, #0xa
	addne sp, sp, #8
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r0, [r6, #0x14]
	mov r3, r0, lsl #0x1c
	mov r3, r3, lsr #0x1c
	cmp r3, #1
	beq _0206D2F4
	cmp r3, #3
	beq _0206D360
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D2F4:
	movs r0, r0, lsr #8
	bne _0206D310
	ldr r1, _0206D390 // =WFSi_OnChildSystemCallback
	mov r0, #1
	bl WBT_RequestSync
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D310:
	ldr r0, [r6, #0x18]
	add r4, r5, r4, lsl #2
	str r0, [r5, #0xb0c]
	ldr r0, [r1, #0]
	add r3, r5, #0x80
	ldr r2, [r0, #0x1c]
	ldr r0, _0206D390 // =WFSi_OnChildSystemCallback
	ldr r6, [r2, #0x30]
	add r2, r5, #0x40
	str r6, [r4, #0x40]
	str r3, [sp]
	str r0, [sp, #4]
	ldr r0, [r1, #0]
	ldr r1, [r5, #0xb0c]
	ldr r3, [r0, #0x1c]
	mov r0, #1
	ldr r3, [r3, #0x38]
	bl WBT_GetBlock
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_0206D360:
	ldr r4, [r2, #0x1c]
	mov r1, #0
	ldr r0, [r4, #8]
	str r1, [r2, #0x1c]
	ldr r3, [r4, #0x2c]
	ldr r2, [r4, #0x38]
	add r2, r3, r2
	str r2, [r4, #0x2c]
	bl FS_NotifyArchiveAsyncEnd
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206D38C: .word wfsi_work
_0206D390: .word WFSi_OnChildSystemCallback
	arm_func_end WFSi_OnChildSystemCallback

	arm_func_start WFSi_InitCommon
WFSi_InitCommon: // 0x0206D394
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r3
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r0, r5
	mov r1, #0x10c00
	mov r2, #0
	blx r6
	movs r4, r0
	bne _0206D3C4
	bl OS_Terminate
_0206D3C4:
	ldr r1, _0206D434 // =wfsi_work
	mvn r0, #0
	str r4, [r1]
	bl FS_Init
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r0, [r4, #0x30]
	mov r2, #0
	str r2, [r4, #4]
	str r2, [r4, #8]
	str r2, [r4, #0xc]
	str r7, [r4, #0x10]
	str r6, [r4, #0x14]
	str r5, [r4, #0x18]
	str r2, [r4, #0x1c]
	str r2, [r4, #0x24]
	str r2, [r4, #0x20]
	str r2, [r4, #0x28]
	mov r1, #0xe
	str r1, [r4, #0x2c]
	ldr r3, _0206D434 // =wfsi_work
	ldr r1, _0206D438 // =WFSi_PortCallback
	str r2, [r3, #8]
	bl WM_SetPortCallback
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	bl OS_Terminate
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0206D434: .word wfsi_work
_0206D438: .word WFSi_PortCallback
	arm_func_end WFSi_InitCommon

	arm_func_start WFS_InitParent
WFS_InitParent: // 0x0206D43C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl OS_DisableInterrupts
	ldr r9, _0206D654 // =wfsi_work
	mov r4, r0
	ldr r1, [r9, #4]
	cmp r1, #0
	bne _0206D648
	mov r10, #1
	mov r0, r8
	mov r1, r7
	mov r2, r6
	mov r3, r5
	str r10, [r9, #4]
	bl WFSi_InitCommon
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r9
	ldr r8, [r0, #0]
	mov r3, r10
	add r9, r8, #0x440
	ldr r2, _0206D658 // =0x000107B0
	mov r0, r9
	mov r1, #0
	str r3, [r8]
	bl MI_CpuFill8
	ldr r1, _0206D658 // =0x000107B0
	mov r0, r9
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	add r10, r9, #0xc0
	add r0, r9, #0x10000
	str r10, [r0, #0x740]
	add r0, r9, #0x740
	ldr r4, _0206D65C // =0xEA0EA0EB
	mov r6, r10
	add r5, r0, #0x10000
	mov r7, #0
_0206D4E4:
	add r1, r10, #0x8c0
	add r0, r10, #0x38
	str r1, [r10]
	bl FS_InitFile
	add r0, r10, #0x8c0
	add r0, r0, #0x8c00000
	sub r1, r0, r6
	smull r0, r2, r4, r1
	str r7, [r10, #0x84]
	add r2, r1, r2
	mov r0, r1, lsr #0x1f
	str r7, [r10, #0x80]
	add r2, r0, r2, asr #11
	str r2, [r10, #0x8c]
	ldr r0, [r10, #0]
	cmp r0, r5
	strhs r7, [r10]
	bhs _0206D534
	mov r10, r0
	b _0206D4E4
_0206D534:
	add r3, r9, #0x10000
	str r7, [r3, #0x750]
	str r7, [r3, #0x74c]
	str r7, [r3, #0x754]
	str r7, [r3, #0x744]
	ldr r0, [sp, #0x28]
	str r7, [r3, #0x748]
	str r0, [r8, #0x28]
	mov r0, #1
	str r0, [r3, #0x758]
	str r7, [r3, #0x75c]
	str r7, [r3, #0x760]
	str r7, [r3, #0x768]
	str r7, [r3, #0x764]
	add r1, r9, #0x770
	ldr r4, [r8, #0x28]
	mov r0, r7
	add r1, r1, #0x10000
	mov r2, #0x40
	str r4, [r3, #0x76c]
	bl MIi_CpuClear32
	ldr r1, _0206D658 // =0x000107B0
	mov r0, r9
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	ldr r0, [r8, #0x28]
	ldr r1, [r8, #0x2c]
	ldr r2, _0206D660 // =WFSi_OnParentSystemCallback
	bl WBT_InitParent
	ldr r0, [sp, #0x2c]
	ldr r1, [sp, #0x30]
	bl WFSi_LoadTables
	add r2, r9, #0x10000
	ldr r5, [r2, #0x740]
	mov r3, #1
	ldr r1, [r5, #0]
	mov r0, r5
	str r1, [r2, #0x740]
	ldr r4, [r2, #0x744]
	mov r1, #0
	str r4, [r5]
	str r5, [r2, #0x744]
	str r3, [r5, #0x84]
	mov r2, #0x8c0
	bl MI_CpuFill8
	add r0, r5, #4
	ldr r1, _0206D654 // =wfsi_work
	mov r3, #0
	ldr r2, [r1, #0]
	mov r1, #0x20000
	ldr r4, [r2, #0x24]
	ldr r2, _0206D664 // =wfsi_def_user_data
	str r4, [sp]
	str r3, [sp, #4]
	ldr r3, [r8, #0x20]
	bl WBT_RegisterBlock
	bl OS_DisableInterrupts
	mov r4, r0
	mov r0, #1
	str r0, [r8, #0xc]
	ldr r0, [r8, #4]
	cmp r0, #0
	beq _0206D634
	bl WFS_Start
_0206D634:
	mov r0, r4
	bl OS_RestoreInterrupts
	bl WFSi_CreateTaskThread
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_0206D648:
	bl OS_RestoreInterrupts
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_0206D654: .word wfsi_work
_0206D658: .word 0x000107B0
_0206D65C: .word 0xEA0EA0EB
_0206D660: .word WFSi_OnParentSystemCallback
_0206D664: .word wfsi_def_user_data
	arm_func_end WFS_InitParent

	arm_func_start WFS_InitChild
WFS_InitChild: // 0x0206D668
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl OS_DisableInterrupts
	ldr ip, _0206D760 // =wfsi_work
	mov r4, r0
	ldr r1, [ip, #4]
	cmp r1, #0
	bne _0206D758
	mov lr, #1
	mov r0, r8
	mov r1, r7
	mov r2, r6
	mov r3, r5
	str lr, [ip, #4]
	bl WFSi_InitCommon
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r0, _0206D760 // =wfsi_work
	mov r2, #0
	ldr r4, [r0, #0]
	mov r1, #0xb10
	add r5, r4, #0x440
	mov r0, r5
	str r2, [r4]
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	mov r1, #0
	add r3, r5, #0xc0
	mov r2, r1
_0206D6E8:
	str r3, [r5, r1, lsl #2]
	add r0, r5, r1, lsl #2
	str r2, [r0, #0x40]
	add r1, r1, #1
	str r2, [r0, #0x80]
	cmp r1, #0x10
	add r3, r3, #0x28
	blt _0206D6E8
	str r2, [r5, #0xb00]
	str r2, [r5, #0xb08]
	mov r0, r5
	mov r1, #0xb10
	str r2, [r5, #0xb0c]
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	ldr r0, _0206D764 // =WFSi_OnChildSystemCallback
	bl WBT_InitChild
	bl OS_DisableInterrupts
	mov r1, #1
	str r1, [r4, #0xc]
	ldr r1, [r4, #4]
	mov r4, r0
	cmp r1, #0
	beq _0206D74C
	bl WFS_Start
_0206D74C:
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0206D758:
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0206D760: .word wfsi_work
_0206D764: .word WFSi_OnChildSystemCallback
	arm_func_end WFS_InitChild

	arm_func_start WFS_Start
WFS_Start: // 0x0206D768
	stmdb sp!, {r3, r4, r5, lr}
	bl OS_DisableInterrupts
	mov r4, r0
	bl WFS_GetStatus
	cmp r0, #1
	beq _0206D794
	ldr r0, _0206D808 // =wfsi_work
	mov r1, #1
	ldr r0, [r0, #0]
	str r1, [r0, #4]
	b _0206D7FC
_0206D794:
	ldr r0, _0206D808 // =wfsi_work
	mov r2, #1
	ldr r1, [r0, #0]
	str r2, [r1, #4]
	ldr r5, [r0, #0]
	ldr r1, [r5, #0]
	cmp r1, #0
	bne _0206D7D8
	add r0, r5, #0x780
	bl WM_ReadStatus
	add r0, r5, #0x840
	ldrh r0, [r0, #0xc8]
	bl WBT_SetOwnAid
	ldr r1, _0206D80C // =WFSi_OnChildSystemCallback
	mov r0, #1
	bl WBT_RequestSync
	b _0206D7F8
_0206D7D8:
	mov r1, #2
	str r1, [r5, #0xc]
	ldr r0, [r0, #0]
	ldr r1, [r0, #0x10]
	cmp r1, #0
	beq _0206D7F8
	mov r0, #0
	blx r1
_0206D7F8:
	bl WFSi_SetMPData
_0206D7FC:
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206D808: .word wfsi_work
_0206D80C: .word WFSi_OnChildSystemCallback
	arm_func_end WFS_Start

	arm_func_start WFS_End
WFS_End: // 0x0206D810
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r0, _0206D968 // =wfsi_work
	ldr r4, [r0, #0]
	bl OS_DisableInterrupts
	ldr r1, _0206D968 // =wfsi_work
	mov r5, r0
	ldr r0, [r1, #4]
	cmp r0, #0
	beq _0206D95C
	ldr r7, [r4, #0x20]
	cmp r7, #0
	beq _0206D87C
	beq _0206D870
	bl OS_DisableInterrupts
	ldr r1, _0206D968 // =wfsi_work
	mov r6, r0
	ldr r1, [r1, #0]
	mov r2, r7
	ldr r0, [r1, #0x18]
	ldr r3, [r1, #0x14]
	mov r1, #0
	blx r3
	mov r0, r6
	bl OS_RestoreInterrupts
_0206D870:
	mov r0, #0
	str r0, [r4, #0x20]
	str r0, [r4, #0x24]
_0206D87C:
	mov r2, #0
	ldr r0, _0206D968 // =wfsi_work
	str r2, [r4, #0xc]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _0206D8F0
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	beq _0206D8B4
	ldr r0, [r0, #8]
	mov r1, #5
	str r2, [r4, #0x1c]
	bl FS_NotifyArchiveAsyncEnd
_0206D8B4:
	ldr r6, [r4, #0xf40]
	cmp r6, #0
	beq _0206D8F4
	bl OS_DisableInterrupts
	ldr r1, _0206D968 // =wfsi_work
	mov r4, r0
	ldr r1, [r1, #0]
	mov r2, r6
	ldr r0, [r1, #0x18]
	ldr r3, [r1, #0x14]
	mov r1, #0
	blx r3
	mov r0, r4
	bl OS_RestoreInterrupts
	b _0206D8F4
_0206D8F0:
	bl WFSi_EndTaskThread
_0206D8F4:
	bl WBT_End
	ldr r0, _0206D968 // =wfsi_work
	mov r1, #0
	ldr r0, [r0, #0]
	mov r2, r1
	ldrh r0, [r0, #0x30]
	bl WM_SetPortCallback
	ldr r0, _0206D968 // =wfsi_work
	ldr r6, [r0, #0]
	cmp r6, #0
	beq _0206D94C
	bl OS_DisableInterrupts
	ldr r1, _0206D968 // =wfsi_work
	mov r4, r0
	ldr r1, [r1, #0]
	mov r2, r6
	ldr r0, [r1, #0x18]
	ldr r3, [r1, #0x14]
	mov r1, #0
	blx r3
	mov r0, r4
	bl OS_RestoreInterrupts
_0206D94C:
	ldr r0, _0206D968 // =wfsi_work
	mov r1, #0
	str r1, [r0]
	str r1, [r0, #4]
_0206D95C:
	mov r0, r5
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206D968: .word wfsi_work
	arm_func_end WFS_End

	arm_func_start WFS_GetStatus
WFS_GetStatus: // 0x0206D96C
	ldr r0, _0206D984 // =wfsi_work
	ldr r0, [r0, #0]
	cmp r0, #0
	ldrne r0, [r0, #0xc]
	moveq r0, #0
	bx lr
	.align 2, 0
_0206D984: .word wfsi_work
	arm_func_end WFS_GetStatus

	arm_func_start WFS_GetBusyBitmap
WFS_GetBusyBitmap: // 0x0206D988
	ldr r0, _0206D9B0 // =wfsi_work
	ldr r1, [r0, #4]
	cmp r1, #0
	ldrne r1, [r0, #0]
	ldrne r0, [r1, #0]
	cmpne r0, #0
	moveq r0, #0
	addne r0, r1, #0x10000
	ldrne r0, [r0, #0xb98]
	bx lr
	.align 2, 0
_0206D9B0: .word wfsi_work
	arm_func_end WFS_GetBusyBitmap

	arm_func_start WFS_Func_206D9B4
WFS_Func_206D9B4: // 0x0206D9B4
	stmdb sp!, {r4, lr}
	ldr r0, _0206DA24 // =wfsi_work
	mvn r4, #0
	ldr r1, [r0, #4]
	cmp r1, #0
	ldrne r0, [r0, #0]
	ldrne r0, [r0, #0]
	cmpne r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	bl WFS_GetBusyBitmap
	ldr r1, _0206DA24 // =wfsi_work
	mov ip, #1
	mov r3, ip
	ldr r2, [r1, #0]
	b _0206DA14
_0206D9F4:
	tst r0, r3, lsl ip
	beq _0206DA10
	add r1, r2, ip, lsl #2
	add r1, r1, #0x10000
	ldr r1, [r1, #0xbb0]
	cmp r4, r1
	movhi r4, r1
_0206DA10:
	add ip, ip, #1
_0206DA14:
	cmp ip, #0x10
	blt _0206D9F4
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206DA24: .word wfsi_work
	arm_func_end WFS_Func_206D9B4

	arm_func_start WFS_EnableSync
WFS_EnableSync: // 0x0206DA28
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _0206DA50 // =wfsi_work
	bic r2, r4, #1
	ldr r1, [r1, #0]
	add r1, r1, #0x10000
	str r2, [r1, #0xb90]
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206DA50: .word wfsi_work
	arm_func_end WFS_EnableSync

	arm_func_start WFS_SetDebugMode
WFS_SetDebugMode: // 0x0206DA54
	ldr r1, _0206DA60 // =wfsi_work
	str r0, [r1, #8]
	bx lr
	.align 2, 0
_0206DA60: .word wfsi_work
	arm_func_end WFS_SetDebugMode

	arm_func_start WFSi_NotifyBusy
WFSi_NotifyBusy: // 0x0206DA64
	ldr ip, _0206DA70 // =OS_WakeupThreadDirect
	ldr r0, _0206DA74 // =wfsi_task+0x00000400
	bx ip
	.align 2, 0
_0206DA70: .word OS_WakeupThreadDirect
_0206DA74: .word wfsi_task+0x00000400
	arm_func_end WFSi_NotifyBusy

	arm_func_start WFSi_TaskThread
WFSi_TaskThread: // 0x0206DA78
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r0, _0206DBA0 // =wfsi_work
	ldr r0, [r0, #0]
	add r4, r0, #0x440
_0206DA88:
	bl OS_DisableInterrupts
	add r7, r4, #0x10000
	ldr r5, [r7, #0x748]
	mov r6, r0
	cmp r5, #0
	bne _0206DAD8
	ldr r8, _0206DBA0 // =wfsi_work
	mov r9, #0
_0206DAA8:
	ldr r0, [r8, #0]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _0206DAC4
	mov r0, r6
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0206DAC4:
	mov r0, r9
	bl OS_SleepThread
	ldr r5, [r7, #0x748]
	cmp r5, #0
	beq _0206DAA8
_0206DAD8:
	mov r0, r6
	bl OS_RestoreInterrupts
	ldr r0, [r5, #0x80]
	cmp r0, #1
	bne _0206DB74
	ldr r1, [r5, #0x90]
	ldr r2, [r5, #0x94]
	add r0, r5, #0x38
	bl FS_CreateFileFromRom
	mov r7, #0
	mov r8, r7
	add r9, r5, #0xc0
	mov r6, #0x400
_0206DB0C:
	add r3, r5, r7, lsl #2
	mov r1, r9
	mov r2, r6
	add r0, r5, #0x38
	str r8, [r3, #0xa4]
	bl FS_ReadFile
	add r7, r7, #1
	cmp r7, #2
	add r8, r8, #0x400
	add r9, r9, #0x400
	blt _0206DB0C
	mov r0, #0
	str r0, [r5, #0x98]
	mov r0, #1
	str r0, [r5, #0xa0]
	mov r0, #2
	str r0, [r5, #0x9c]
	bl OS_DisableInterrupts
	mov r6, r0
	mov r0, r4
	mov r1, r5
	mov r2, #1
	bl WFSi_SendOpenAck
	mov r0, r6
	bl OS_RestoreInterrupts
	b _0206DA88
_0206DB74:
	add r0, r5, #0x38
	bl FS_CloseFile
	bl OS_DisableInterrupts
	mov r6, r0
	mov r0, r4
	mov r1, r5
	bl WFSi_FromBusyToFree
	mov r0, r6
	bl OS_RestoreInterrupts
	b _0206DA88
	arm_func_end WFSi_TaskThread

	arm_func_start sub_206DB9C
sub_206DB9C: // 0x0206DB9C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0206DBA0: .word wfsi_work
	arm_func_end sub_206DB9C

	arm_func_start WFSi_CreateTaskThread
WFSi_CreateTaskThread: // 0x0206DBA4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, _0206DBF0 // =wfsi_task
	mov r0, #0
	str r0, [r4, #0x4c4]
	str r0, [r4, #0x4c0]
	mov r0, #0x400
	str r0, [sp]
	add r0, r4, #0x400
	mov ip, #0xf
	ldr r1, _0206DBF4 // =WFSi_TaskThread
	mov r2, r4
	mov r3, r0
	str ip, [sp, #4]
	bl OS_CreateThread
	add r0, r4, #0x400
	bl OS_WakeupThreadDirect
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206DBF0: .word wfsi_task
_0206DBF4: .word WFSi_TaskThread
	arm_func_end WFSi_CreateTaskThread

	arm_func_start WFSi_EndTaskThread
WFSi_EndTaskThread: // 0x0206DBF8
	stmdb sp!, {r4, lr}
	ldr r4, _0206DC28 // =wfsi_task
	b _0206DC14
_0206DC04:
	add r0, r4, #0x400
	bl OS_WakeupThreadDirect
	add r0, r4, #0x400
	bl OS_JoinThread
_0206DC14:
	add r0, r4, #0x400
	bl OS_IsThreadTerminated
	cmp r0, #0
	beq _0206DC04
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206DC28: .word wfsi_task
	arm_func_end WFSi_EndTaskThread

	arm_func_start MBP_Init
MBP_Init: // 0x0206DC2C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x78
	mov r5, r0
	add r0, sp, #0x28
	mov r4, r1
	bl OS_GetOwnerInfo
	ldrb r2, [sp, #0x12]
	ldrb r1, [sp, #0x29]
	ldrh r3, [sp, #0x40]
	bic r2, r2, #0xf
	and r1, r1, #0xf
	orr r2, r2, r1
	strb r2, [sp, #0x12]
	add r0, sp, #0x2c
	add r1, sp, #0x14
	mov r2, r3, lsl #1
	strb r3, [sp, #0x13]
	bl MI_CpuCopy8
	ldrb r1, [sp, #0x12]
	add ip, sp, #4
	mov r0, #0
	bic r1, r1, #0xf0
	ldr r3, _0206DD38 // =mbpState
	strb r1, [sp, #0x12]
	strh r0, [ip]
	strh r0, [ip, #2]
	strh r0, [ip, #4]
	strh r0, [ip, #6]
	strh r0, [ip, #8]
	strh r0, [ip, #0xa]
	strh r0, [ip, #0xc]
	mov r2, #3
_0206DCAC:
	ldrh r1, [ip]
	ldrh r0, [ip, #2]
	add ip, ip, #4
	strh r1, [r3]
	strh r0, [r3, #2]
	add r3, r3, #4
	subs r2, r2, #1
	bne _0206DCAC
	ldr r0, _0206DD3C // =wfsi_task+0x000004C8
	ldrh r2, [ip]
	ldr r1, [r0, #0]
	mov r0, #0xc000
	strh r2, [r3]
	blx r1
	ldr r1, _0206DD3C // =wfsi_task+0x000004C8
	mov r2, #2
	str r0, [r1, #0xc]
	str r2, [sp]
	ldr r0, [r1, #0xc]
	add r1, sp, #0x12
	mov r2, r5
	mov r3, r4
	bl MB_Init
	cmp r0, #0
	beq _0206DD14
	bl OS_Terminate
_0206DD14:
	mov r0, #0x100
	mov r1, #0xf
	bl MB_SetParentCommParam
	ldr r0, _0206DD40 // =MBPi_ParentStateCallback
	bl MB_CommSetParentStateCallback
	mov r0, #1
	bl MBP_ChangeState
	add sp, sp, #0x78
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206DD38: .word mbpState
_0206DD3C: .word wfsi_task+0x000004C8
_0206DD40: .word MBPi_ParentStateCallback
	arm_func_end MBP_Init

	arm_func_start MBP_Start
MBP_Start: // 0x0206DD44
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	mov r0, #2
	bl MBP_ChangeState
	mov r0, r4
	bl MB_StartParent
	cmp r0, #0
	beq _0206DD74
	mov r0, #7
	bl MBP_ChangeState
	ldmia sp!, {r3, r4, r5, pc}
_0206DD74:
	mov r0, r5
	bl MBP_RegistFile
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	bl OS_Terminate
	arm_func_end MBP_Start

	arm_func_start sub_206dd88
sub_206dd88: // 0x0206DD88
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end sub_206dd88

	arm_func_start MBP_RegistFile
MBP_RegistFile: // 0x0206DD8C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	sub sp, sp, #0x48
	mov r6, r0
	ldr r0, [r6, #0]
	mov r5, #0
	cmp r0, #0
	moveq r4, r5
	beq _0206DDD4
	add r0, sp, #0
	bl FS_InitFile
	ldr r1, [r6, #0]
	add r0, sp, #0
	bl FS_OpenFile
	cmp r0, #0
	addeq sp, sp, #0x48
	moveq r0, r5
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r4, sp, #0
_0206DDD4:
	mov r0, r4
	bl MB_GetSegmentLength
	movs r7, r0
	beq _0206DE40
	ldr r1, _0206DE5C // =wfsi_task+0x000004C8
	ldr r1, [r1, #0]
	blx r1
	movs r1, r0
	ldr r0, _0206DE5C // =wfsi_task+0x000004C8
	str r1, [r0, #4]
	beq _0206DE40
	mov r0, r4
	mov r2, r7
	bl MB_ReadSegment
	cmp r0, #0
	beq _0206DE2C
	ldr r1, _0206DE5C // =wfsi_task+0x000004C8
	mov r0, r6
	ldr r1, [r1, #4]
	bl MB_UnregisterFile
	cmp r0, #0
	movne r5, #1
_0206DE2C:
	cmp r5, #0
	bne _0206DE40
	ldr r1, _0206DE5C // =wfsi_task+0x000004C8
	ldmib r1, {r0, r1}
	blx r1
_0206DE40:
	add r0, sp, #0
	cmp r4, r0
	bne _0206DE50
	bl FS_CloseFile
_0206DE50:
	mov r0, r5
	add sp, sp, #0x48
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206DE5C: .word wfsi_task+0x000004C8
	arm_func_end MBP_RegistFile

	arm_func_start MBP_AcceptChild
MBP_AcceptChild: // 0x0206DE60
	stmdb sp!, {r3, r4, r5, lr}
	mov r1, #1
	mov r4, r0
	bl MB_CommResponseRequest
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #1
	mvn r0, r0, lsl r4
	mov r5, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _0206DEE4 // =wfsi_task+0x000004C8
	ldrh r2, [r1, #0x12]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x12]
	ldrh r2, [r1, #0x14]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x18]
	ldrh r2, [r1, #0x1a]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1a]
	ldrh r2, [r1, #0x1c]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1c]
	bl OS_RestoreInterrupts
	mov r0, r4
	bl MB_DisconnectChild
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206DEE4: .word wfsi_task+0x000004C8
	arm_func_end MBP_AcceptChild

	arm_func_start MBP_KickChild
MBP_KickChild: // 0x0206DEE8
	stmdb sp!, {r3, r4, r5, lr}
	mov r1, #0
	mov r4, r0
	bl MB_CommResponseRequest
	cmp r0, #0
	bne _0206DF6C
	mov r0, #1
	mvn r0, r0, lsl r4
	mov r5, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _0206DF9C // =wfsi_task+0x000004C8
	ldrh r2, [r1, #0x12]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x12]
	ldrh r2, [r1, #0x14]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x18]
	ldrh r2, [r1, #0x1a]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1a]
	ldrh r2, [r1, #0x1c]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1c]
	bl OS_RestoreInterrupts
	mov r0, r4
	bl MB_DisconnectChild
	ldmia sp!, {r3, r4, r5, pc}
_0206DF6C:
	bl OS_DisableInterrupts
	ldr r1, _0206DF9C // =wfsi_task+0x000004C8
	mov r3, #1
	ldrh r2, [r1, #0x14]
	mvn r3, r3, lsl r4
	and r2, r2, r3
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x12]
	and r2, r2, r3
	strh r2, [r1, #0x12]
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206DF9C: .word wfsi_task+0x000004C8
	arm_func_end MBP_KickChild

	arm_func_start MBP_StartDownload
MBP_StartDownload: // 0x0206DFA0
	stmdb sp!, {r3, r4, r5, lr}
	mov r1, #2
	mov r4, r0
	bl MB_CommResponseRequest
	cmp r0, #0
	bne _0206E024
	mov r0, #1
	mvn r0, r0, lsl r4
	mov r5, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _0206E054 // =wfsi_task+0x000004C8
	ldrh r2, [r1, #0x12]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x12]
	ldrh r2, [r1, #0x14]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x18]
	ldrh r2, [r1, #0x1a]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1a]
	ldrh r2, [r1, #0x1c]
	and r2, r2, r5, lsr #16
	strh r2, [r1, #0x1c]
	bl OS_RestoreInterrupts
	mov r0, r4
	bl MB_DisconnectChild
	ldmia sp!, {r3, r4, r5, pc}
_0206E024:
	bl OS_DisableInterrupts
	ldr r1, _0206E054 // =wfsi_task+0x000004C8
	mov r5, #1
	ldrh r3, [r1, #0x16]
	mvn r2, r5, lsl r4
	and r2, r3, r2
	strh r2, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	orr r2, r2, r5, lsl r4
	strh r2, [r1, #0x18]
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206E054: .word wfsi_task+0x000004C8
	arm_func_end MBP_StartDownload

	arm_func_start MBP_StartDownloadAll
MBP_StartDownloadAll: // 0x0206E058
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r0, #3
	bl MBP_ChangeState
	mov r5, #1
	ldr r7, _0206E104 // =wfsi_task+0x000004C8
	mov r4, r5
_0206E070:
	ldrh r0, [r7, #0x12]
	tst r0, r4, lsl r5
	beq _0206E0EC
	mov r0, r5
	bl MBP_GetChildState
	cmp r0, #1
	bne _0206E0EC
	mvn r0, r4, lsl r5
	mov r6, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldrh r1, [r7, #0x12]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x12]
	ldrh r1, [r7, #0x14]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x14]
	ldrh r1, [r7, #0x16]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x16]
	ldrh r1, [r7, #0x18]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x18]
	ldrh r1, [r7, #0x1a]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x1a]
	ldrh r1, [r7, #0x1c]
	and r1, r1, r6, lsr #16
	strh r1, [r7, #0x1c]
	bl OS_RestoreInterrupts
	mov r0, r5
	bl MB_DisconnectChild
_0206E0EC:
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #0x10
	blo _0206E070
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206E104: .word wfsi_task+0x000004C8
	arm_func_end MBP_StartDownloadAll

	arm_func_start MBP_IsBootableAll
MBP_IsBootableAll: // 0x0206E108
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _0206E164 // =wfsi_task+0x000004C8
	ldrh r0, [r4, #0x12]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r6, #1
	mov r5, r6
_0206E128:
	ldrh r0, [r4, #0x12]
	tst r0, r5, lsl r6
	beq _0206E148
	mov r0, r6
	bl MB_CommIsBootable
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
_0206E148:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x10
	blo _0206E128
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0206E164: .word wfsi_task+0x000004C8
	arm_func_end MBP_IsBootableAll

	arm_func_start MBP_StartRebootAll
MBP_StartRebootAll: // 0x0206E168
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r7, #1
	ldr r4, _0206E240 // =wfsi_task+0x000004C8
	mov r8, #0
	mov r5, #3
	mov r6, r7
_0206E180:
	ldrh r0, [r4, #0x1a]
	tst r0, r6, lsl r7
	beq _0206E20C
	mov r0, r7
	mov r1, r5
	bl MB_CommResponseRequest
	cmp r0, #0
	orrne r0, r8, r6, lsl r7
	movne r0, r0, lsl #0x10
	movne r8, r0, lsr #0x10
	bne _0206E20C
	mvn r0, r6, lsl r7
	mov r9, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldrh r1, [r4, #0x12]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x12]
	ldrh r1, [r4, #0x14]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x14]
	ldrh r1, [r4, #0x16]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x16]
	ldrh r1, [r4, #0x18]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x18]
	ldrh r1, [r4, #0x1a]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x1a]
	ldrh r1, [r4, #0x1c]
	and r1, r1, r9, lsr #16
	strh r1, [r4, #0x1c]
	bl OS_RestoreInterrupts
	mov r0, r7
	bl MB_DisconnectChild
_0206E20C:
	add r0, r7, #1
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	cmp r7, #0x10
	blo _0206E180
	cmp r8, #0
	bne _0206E234
	mov r0, #7
	bl MBP_ChangeState
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
_0206E234:
	mov r0, #4
	bl MBP_ChangeState
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0206E240: .word wfsi_task+0x000004C8
	arm_func_end MBP_StartRebootAll

	arm_func_start MBP_Cancel
MBP_Cancel: // 0x0206E244
	stmdb sp!, {r3, lr}
	mov r0, #6
	bl MBP_ChangeState
	bl MB_End
	ldmia sp!, {r3, pc}
	arm_func_end MBP_Cancel

	arm_func_start MBPi_CheckAllReboot
MBPi_CheckAllReboot: // 0x0206E258
	stmdb sp!, {r3, lr}
	ldr r0, _0206E280 // =wfsi_task+0x000004C8
	ldrh r1, [r0, #0x10]
	cmp r1, #4
	ldreqh r1, [r0, #0x12]
	ldreqh r0, [r0, #0x1c]
	cmpeq r1, r0
	ldmneia sp!, {r3, pc}
	bl MB_End
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206E280: .word wfsi_task+0x000004C8
	arm_func_end MBPi_CheckAllReboot

	arm_func_start MBPi_ParentStateCallback
MBPi_ParentStateCallback: // 0x0206E284
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r2
	cmp r1, #0xe
	addls pc, pc, r1, lsl #2
	b _0206E560
_0206E29C: // jump table
	b _0206E560 // case 0
	ldmia sp!, {r3, r4, r5, pc} // case 1
	b _0206E2D8 // case 2
	b _0206E360 // case 3
	ldmia sp!, {r3, r4, r5, pc} // case 4
	ldmia sp!, {r3, r4, r5, pc} // case 5
	ldmia sp!, {r3, r4, r5, pc} // case 6
	b _0206E460 // case 7
	ldmia sp!, {r3, r4, r5, pc} // case 8
	b _0206E488 // case 9
	b _0206E3D4 // case 10
	ldmia sp!, {r3, r4, r5, pc} // case 11
	b _0206E4B4 // case 12
	b _0206E520 // case 13
	b _0206E434 // case 14
_0206E2D8:
	bl MBP_GetState
	cmp r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	bl OS_DisableInterrupts
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	mov r2, #1
	ldrh r3, [r1, #0x12]
	orr r2, r3, r2, lsl r5
	strh r2, [r1, #0x12]
	bl OS_RestoreInterrupts
	sub r1, r5, #1
	mov r0, #0x1e
	mul r0, r1, r0
	ldrb r3, [r4, #0xa]
	ldr r1, _0206E56C // =childInfo+0x00000016
	ldr r2, _0206E570 // =childInfo+0x00000017
	strb r3, [r1, r0]
	ldrb r3, [r4, #0xb]
	ldr r1, _0206E574 // =childInfo+0x00000018
	ldr ip, _0206E578 // =childInfo+0x00000019
	strb r3, [r2, r0]
	ldrb lr, [r4, #0xc]
	ldr r3, _0206E57C // =childInfo+0x0000001A
	ldr r2, _0206E580 // =childInfo+0x0000001B
	strb lr, [r1, r0]
	ldrb lr, [r4, #0xd]
	ldr r1, _0206E584 // =childInfo+0x0000001C
	strb lr, [ip, r0]
	ldrb ip, [r4, #0xe]
	strb ip, [r3, r0]
	ldrb r3, [r4, #0xf]
	strb r3, [r2, r0]
	strh r5, [r1, r0]
	ldmia sp!, {r3, r4, r5, pc}
_0206E360:
	bl MBP_GetChildState
	cmp r0, #6
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, #1
	mvn r0, r0, lsl r5
	mov r4, r0, lsl #0x10
	bl OS_DisableInterrupts
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	ldrh r2, [r1, #0x12]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x12]
	ldrh r2, [r1, #0x14]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x16]
	ldrh r2, [r1, #0x18]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x18]
	ldrh r2, [r1, #0x1a]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x1a]
	ldrh r2, [r1, #0x1c]
	and r2, r2, r4, lsr #16
	strh r2, [r1, #0x1c]
	bl OS_RestoreInterrupts
	bl MBPi_CheckAllReboot
	ldmia sp!, {r3, r4, r5, pc}
_0206E3D4:
	bl MBP_GetState
	cmp r0, #2
	beq _0206E3EC
	mov r0, r5
	bl MBP_KickChild
	ldmia sp!, {r3, r4, r5, pc}
_0206E3EC:
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	mov r2, #1
	ldrh r3, [r1, #0x14]
	mov r0, r5
	orr r2, r3, r2, lsl r5
	strh r2, [r1, #0x14]
	bl MBP_AcceptChild
	mov r0, r5
	bl MB_CommGetChildUser
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r3, _0206E588 // =childInfo
	sub r2, r5, #1
	mov r1, #0x1e
	mla r1, r2, r1, r3
	mov r2, #0x16
	bl MI_CpuCopy8
	ldmia sp!, {r3, r4, r5, pc}
_0206E434:
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	mov r4, #1
	ldrh r3, [r1, #0x14]
	mvn r2, r4, lsl r5
	and r2, r3, r2
	strh r2, [r1, #0x14]
	ldrh r2, [r1, #0x16]
	orr r2, r2, r4, lsl r5
	strh r2, [r1, #0x16]
	bl MBP_StartDownload
	ldmia sp!, {r3, r4, r5, pc}
_0206E460:
	ldr r0, _0206E568 // =wfsi_task+0x000004C8
	mov r3, #1
	ldrh r2, [r0, #0x18]
	mvn r1, r3, lsl r5
	and r1, r2, r1
	strh r1, [r0, #0x18]
	ldrh r1, [r0, #0x1a]
	orr r1, r1, r3, lsl r5
	strh r1, [r0, #0x1a]
	ldmia sp!, {r3, r4, r5, pc}
_0206E488:
	ldr r0, _0206E568 // =wfsi_task+0x000004C8
	mov r3, #1
	ldrh r2, [r0, #0x1a]
	mvn r1, r3, lsl r5
	and r1, r2, r1
	strh r1, [r0, #0x1a]
	ldrh r1, [r0, #0x1c]
	orr r1, r1, r3, lsl r5
	strh r1, [r0, #0x1c]
	bl MBPi_CheckAllReboot
	ldmia sp!, {r3, r4, r5, pc}
_0206E4B4:
	bl MBP_GetState
	cmp r0, #4
	bne _0206E4CC
	mov r0, #5
	bl MBP_ChangeState
	b _0206E4D4
_0206E4CC:
	mov r0, #0
	bl MBP_ChangeState
_0206E4D4:
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	ldr r0, [r1, #4]
	cmp r0, #0
	beq _0206E4F8
	ldr r1, [r1, #8]
	blx r1
	ldr r0, _0206E568 // =wfsi_task+0x000004C8
	mov r1, #0
	str r1, [r0, #4]
_0206E4F8:
	ldr r1, _0206E568 // =wfsi_task+0x000004C8
	ldr r0, [r1, #0xc]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r1, [r1, #8]
	blx r1
	ldr r0, _0206E568 // =wfsi_task+0x000004C8
	mov r1, #0
	str r1, [r0, #0xc]
	ldmia sp!, {r3, r4, r5, pc}
_0206E520:
	ldrh r0, [r4, #0]
	cmp r0, #8
	bgt _0206E54C
	ldmgeia sp!, {r3, r4, r5, pc}
	cmp r0, #2
	ldmgtia sp!, {r3, r4, r5, pc}
	cmp r0, #1
	ldmltia sp!, {r3, r4, r5, pc}
	cmpne r0, #2
	beq _0206E554
	ldmia sp!, {r3, r4, r5, pc}
_0206E54C:
	cmp r0, #9
	ldmneia sp!, {r3, r4, r5, pc}
_0206E554:
	mov r0, #7
	bl MBP_ChangeState
	ldmia sp!, {r3, r4, r5, pc}
_0206E560:
	bl OS_Terminate
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206E568: .word wfsi_task+0x000004C8
_0206E56C: .word childInfo+0x00000016
_0206E570: .word childInfo+0x00000017
_0206E574: .word childInfo+0x00000018
_0206E578: .word childInfo+0x00000019
_0206E57C: .word childInfo+0x0000001A
_0206E580: .word childInfo+0x0000001B
_0206E584: .word childInfo+0x0000001C
_0206E588: .word childInfo
	arm_func_end MBPi_ParentStateCallback

	arm_func_start MBP_ChangeState
MBP_ChangeState: // 0x0206E58C
	ldr r1, _0206E598 // =wfsi_task+0x000004C8
	strh r0, [r1, #0x10]
	bx lr
	.align 2, 0
_0206E598: .word wfsi_task+0x000004C8
	arm_func_end MBP_ChangeState

	arm_func_start MBP_GetState
MBP_GetState: // 0x0206E59C
	ldr r0, _0206E5A8 // =wfsi_task+0x000004C8
	ldrh r0, [r0, #0x10]
	bx lr
	.align 2, 0
_0206E5A8: .word wfsi_task+0x000004C8
	arm_func_end MBP_GetState

	arm_func_start MBP_GetChildBmp
MBP_GetChildBmp: // 0x0206E5AC
	ldr r1, _0206E5BC // =0x0211AB20
	ldr r0, [r1, r0, lsl #2]
	ldrh r0, [r0, #0]
	bx lr
	.align 2, 0
_0206E5BC: .word 0x0211AB20
	arm_func_end MBP_GetChildBmp

	arm_func_start MBP_GetChildState
MBP_GetChildState: // 0x0206E5C0
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _0206E680 // =wfsi_task+0x000004C8
	mov r2, #1
	mov r2, r2, lsl r4
	ldrh r1, [r1, #0x12]
	mov r4, r2, lsl #0x10
	mov r5, r0
	tst r1, r4, lsr #16
	bne _0206E600
	bl OS_RestoreInterrupts
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
_0206E600:
	ldr r0, _0206E684 // =mbpState
	add r1, sp, #0
	mov r2, #0xe
	bl MI_CpuCopy8
	mov r0, r5
	bl OS_RestoreInterrupts
	ldrh r0, [sp, #4]
	tst r0, r4, lsr #16
	addne sp, sp, #0x10
	movne r0, #2
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [sp, #6]
	tst r0, r4, lsr #16
	addne sp, sp, #0x10
	movne r0, #3
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [sp, #8]
	tst r0, r4, lsr #16
	addne sp, sp, #0x10
	movne r0, #4
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [sp, #0xa]
	tst r0, r4, lsr #16
	addne sp, sp, #0x10
	movne r0, #5
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r0, [sp, #0xc]
	tst r0, r4, lsr #16
	movne r0, #6
	moveq r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206E680: .word wfsi_task+0x000004C8
_0206E684: .word mbpState
	arm_func_end MBP_GetChildState

	arm_func_start MBP_GetChildInfo
MBP_GetChildInfo: // 0x0206E688
	ldr r1, _0206E6B4 // =wfsi_task+0x000004C8
	mov r2, #1
	ldrh r1, [r1, #0x12]
	tst r1, r2, lsl r0
	moveq r0, #0
	bxeq lr
	ldr r2, _0206E6B8 // =childInfo
	sub r1, r0, #1
	mov r0, #0x1e
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_0206E6B4: .word wfsi_task+0x000004C8
_0206E6B8: .word childInfo
	arm_func_end MBP_GetChildInfo

	.rodata

_021116C0: // 0x021116C0
    .byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
    .align 4

wfsi_def_user_data: // 0x021116C8
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	.data

.public aNA
aNA: // 0x02119F0C
	.asciz "N/A"
	.align 4

aWhSysstateIdle: // 0x02119F10
	.asciz "WH_SYSSTATE_IDLE"
	.align 4

aWhSysstateBusy: // 0x02119F24
	.asciz "WH_SYSSTATE_BUSY"
	.align 4

aWhSysstateStop: // 0x02119F38
	.asciz "WH_SYSSTATE_STOP"
	.align 4

aWhSysstateErro: // 0x02119F4C
	.asciz "WH_SYSSTATE_ERROR"
	.align 4

aWmErrcodeFaile: // 0x02119F60
	.asciz "WM_ERRCODE_FAILED"
	.align 4

aWmErrcodeSucce: // 0x02119F74
	.asciz "WM_ERRCODE_SUCCESS"
	.align 4

aWmErrcodeNoDat: // 0x02119F88
	.asciz "WM_ERRCODE_NO_DATA"
	.align 4

aWmErrcodeTimeo: // 0x02119F9C
	.asciz "WM_ERRCODE_TIMEOUT"
	.align 4

aWmStatecodeMpI: // 0x02119FB0
	.asciz "WM_STATECODE_MP_IND"
	.align 4

aWhErrcodeNoRad: // 0x02119FC4
	.asciz "WH_ERRCODE_NO_RADIO"
	.align 4

aWmErrcodeNoChi: // 0x02119FD8
	.asciz "WM_ERRCODE_NO_CHILD"
	.align 4

aWmErrcodeNoEnt: // 0x02119FEC
	.asciz "WM_ERRCODE_NO_ENTRY"
	.align 4

aWmErrcodeDcfTe: // 0x0211A000
	.asciz "WM_ERRCODE_DCF_TEST"
	.align 4

aWmStatecodeDcf: // 0x0211A014
	.asciz "WM_STATECODE_DCF_IND"
	.align 4

aWmStatecodeUnk: // 0x0211A02C
	.asciz "WM_STATECODE_UNKNOWN"
	.align 4

aWhSysstateScan: // 0x0211A044
	.asciz "WH_SYSSTATE_SCANNING"
	.align 4

aWmErrcodeOpera: // 0x0211A05C
	.asciz "WM_ERRCODE_OPERATING"
	.align 4

aWmStatecodeMpS: // 0x0211A074
	.asciz "WM_STATECODE_MP_START"
	.align 4

aWmErrcodeNoDat_0: // 0x0211A08C
	.asciz "WM_ERRCODE_NO_DATASET"
	.align 4

aWmErrcodeFifoE: // 0x0211A0A4
	.asciz "WM_ERRCODE_FIFO_ERROR"
	.align 4

aWmErrcodeWmDis: // 0x0211A0BC
	.asciz "WM_ERRCODE_WM_DISABLE"
	.align 4

aWhSysstateConn: // 0x0211A0D4
	.asciz "WH_SYSSTATE_CONNECTED"
	.align 4

aWmStatecodeMpe: // 0x0211A0EC
	.asciz "WM_STATECODE_MPEND_IND"
	.align 4

aWmStatecodeMpa: // 0x0211A104
	.asciz "WM_STATECODE_MPACK_IND"
	.align 4

aWmStatecodeDcf_0: // 0x0211A11C
	.asciz "WM_STATECODE_DCF_START"
	.align 4

aWmStatecodePor: // 0x0211A134
	.asciz "WM_STATECODE_PORT_SEND"
	.align 4

aWmStatecodePor_0: // 0x0211A14C
	.asciz "WM_STATECODE_PORT_RECV"
	.align 4

aWmStatecodePor_1: // 0x0211A164
	.asciz "WM_STATECODE_PORT_INIT"
	.align 4

aWmErrcodeSendF: // 0x0211A17C
	.asciz "WM_ERRCODE_SEND_FAILED"
	.align 4

aWmErrcodeFlash: // 0x0211A194
	.asciz "WM_ERRCODE_FLASH_ERROR"
	.align 4

aWhSysstateKeys: // 0x0211A1AC
	.asciz "WH_SYSSTATE_KEYSHARING"
	.align 4

aWmStatecodeCon: // 0x0211A1C4
	.asciz "WM_STATECODE_CONNECTED"
	.align 4

aWmStatecodeFif: // 0x0211A1DC
	.asciz "WM_STATECODE_FIFO_ERROR"
	.align 4

aWhSysstateData: // 0x0211A1F4
	.asciz "WH_SYSSTATE_DATASHARING"
	.align 4

aWhErrcodeDisco: // 0x0211A20C
	.asciz "WH_ERRCODE_DISCONNECTED"
	.align 4

aWmStatecodeSca: // 0x0211A224
	.asciz "WM_STATECODE_SCAN_START"
	.align 4

aWmStatecodeBea: // 0x0211A23C
	.asciz "WM_STATECODE_BEACON_LOST"
	.align 4

aWmStatecodeBea_0: // 0x0211A258
	.asciz "WM_STATECODE_BEACON_RECV"
	.align 4

aWmStatecodeRea: // 0x0211A274
	.asciz "WM_STATECODE_REASSOCIATE"
	.align 4

aWmStatecodeInf: // 0x0211A290
	.asciz "WM_STATECODE_INFORMATION"
	.align 4

aWmErrcodeIlleg: // 0x0211A2AC
	.asciz "WM_ERRCODE_ILLEGAL_STATE"
	.align 4

aWmErrcodeInval: // 0x0211A2C8
	.asciz "WM_ERRCODE_INVALID_PARAM"
	.align 4

aWmErrcodeWlLen: // 0x0211A2E4
	.asciz "WM_ERRCODE_WL_LENGTH_ERR"
	.align 4

aWhSysstateConn_0: // 0x0211A300
	.asciz "WH_SYSSTATE_CONNECT_FAIL"
	.align 4

aWmStatecodeBea_1: // 0x0211A31C
	.asciz "WM_STATECODE_BEACON_SENT"
	.align 4

aWmStatecodeDis: // 0x0211A338
	.asciz "WM_STATECODE_DISCONNECTED"
	.align 4

aWmStatecodeDis_0: // 0x0211A354
	.asciz "WM_STATECODE_DISASSOCIATE"
	.align 4

aWmStatecodeAut: // 0x0211A370
	.asciz "WM_STATECODE_AUTHENTICATE"
	.align 4

aWmErrcodeOverM: // 0x0211A38C
	.asciz "WM_ERRCODE_OVER_MAX_ENTRY"
	.align 4

aWmStatecodePar: // 0x0211A3A8
	.asciz "WM_STATECODE_PARENT_START"
	.align 4

aWmStatecodePar_0: // 0x0211A3C4
	.asciz "WM_STATECODE_PARENT_FOUND"
	.align 4

aWmErrcodeSendQ: // 0x0211A3E0
	.asciz "WM_ERRCODE_SEND_QUEUE_FULL"
	.align 4

aWhSysstateMeas: // 0x0211A3FC
	.asciz "WH_SYSSTATE_MEASURECHANNEL"
	.align 4

aWmStatecodeCon_0: // 0x0211A418
	.asciz "WM_STATECODE_CONNECT_START"
	.align 4

aWmErrcodeWlInv: // 0x0211A434
	.asciz "WM_ERRCODE_WL_INVALID_PARAM"
	.align 4

aWhErrcodeParen: // 0x0211A450
	.asciz "WH_ERRCODE_PARENT_NOT_FOUND"
	.align 4

aWmErrcodeInval_0: // 0x0211A46C
	.asciz "WM_ERRCODE_INVALID_POLLBITMAP"
	.align 4

aWmStatecodePar_1: // 0x0211A48C
	.asciz "WM_STATECODE_PARENT_NOT_FOUND"
	.align 4

aWmStatecodeDis_1: // 0x0211A4AC
	.asciz "WM_STATECODE_DISCONNECTED_FROM_MYSELF"
	.align 4

.public WH__sStateNames
WH__sStateNames: // 0x0211A4D4
	.word aWhSysstateStop     // "WH_SYSSTATE_STOP"
	.word aWhSysstateIdle     // "WH_SYSSTATE_IDLE"
	.word aWhSysstateScan     // "WH_SYSSTATE_SCANNING"
	.word aWhSysstateBusy     // "WH_SYSSTATE_BUSY"
	.word aWhSysstateConn     // "WH_SYSSTATE_CONNECTED"
	.word aWhSysstateData     // "WH_SYSSTATE_DATASHARING"
	.word aWhSysstateKeys     // "WH_SYSSTATE_KEYSHARING"
	.word aWhSysstateMeas     // "WH_SYSSTATE_MEASURECHANNEL"
	.word aWhSysstateConn_0   // "WH_SYSSTATE_CONNECT_FAIL"
	.word aWhSysstateErro     // "WH_SYSSTATE_ERROR"

.public WH__errnames
WH__errnames:  // 0x0211A4FC
    .word aWmErrcodeSucce 	  // "WM_ERRCODE_SUCCESS"
	.word aWmErrcodeFaile     // "WM_ERRCODE_FAILED"
	.word aWmErrcodeOpera     // "WM_ERRCODE_OPERATING"
	.word aWmErrcodeIlleg     // "WM_ERRCODE_ILLEGAL_STATE"
	.word aWmErrcodeWmDis     // "WM_ERRCODE_WM_DISABLE"
	.word aWmErrcodeNoDat_0   // "WM_ERRCODE_NO_DATASET"
	.word aWmErrcodeInval     // "WM_ERRCODE_INVALID_PARAM"
	.word aWmErrcodeNoChi     // "WM_ERRCODE_NO_CHILD"
	.word aWmErrcodeFifoE     // "WM_ERRCODE_FIFO_ERROR"
	.word aWmErrcodeTimeo     // "WM_ERRCODE_TIMEOUT"
	.word aWmErrcodeSendQ     // "WM_ERRCODE_SEND_QUEUE_FULL"
	.word aWmErrcodeNoEnt     // "WM_ERRCODE_NO_ENTRY"
	.word aWmErrcodeOverM     // "WM_ERRCODE_OVER_MAX_ENTRY"
	.word aWmErrcodeInval_0   // "WM_ERRCODE_INVALID_POLLBITMAP"
	.word aWmErrcodeNoDat     // "WM_ERRCODE_NO_DATA"
	.word aWmErrcodeSendF     // "WM_ERRCODE_SEND_FAILED"
	.word aWmErrcodeDcfTe     // "WM_ERRCODE_DCF_TEST"
	.word aWmErrcodeWlInv     // "WM_ERRCODE_WL_INVALID_PARAM"
	.word aWmErrcodeWlLen     // "WM_ERRCODE_WL_LENGTH_ERR"
	.word aWmErrcodeFlash     // "WM_ERRCODE_FLASH_ERROR"
	.word aWhErrcodeDisco     // "WH_ERRCODE_DISCONNECTED"
	.word aWhErrcodeParen     // "WH_ERRCODE_PARENT_NOT_FOUND"
	.word aWhErrcodeNoRad     // "WH_ERRCODE_NO_RADIO"

.public WH__statenames
WH__statenames: // 0x0211A558
	.word aWmStatecodePar 	 // "WM_STATECODE_PARENT_START"
	.word aNA                // "N/A"
	.word aWmStatecodeBea_1  // "WM_STATECODE_BEACON_SENT"
	.word aWmStatecodeSca    // "WM_STATECODE_SCAN_START"
	.word aWmStatecodePar_1  // "WM_STATECODE_PARENT_NOT_FOUND"
	.word aWmStatecodePar_0  // "WM_STATECODE_PARENT_FOUND"
	.word aWmStatecodeCon_0  // "WM_STATECODE_CONNECT_START"
	.word aWmStatecodeCon    // "WM_STATECODE_CONNECTED"
	.word aWmStatecodeBea    // "WM_STATECODE_BEACON_LOST"
	.word aWmStatecodeDis    // "WM_STATECODE_DISCONNECTED"
	.word aWmStatecodeMpS    // "WM_STATECODE_MP_START"
	.word aWmStatecodeMpe    // "WM_STATECODE_MPEND_IND"
	.word aWmStatecodeMpI    // "WM_STATECODE_MP_IND"
	.word aWmStatecodeMpa    // "WM_STATECODE_MPACK_IND"
	.word aWmStatecodeDcf_0  // "WM_STATECODE_DCF_START"
	.word aWmStatecodeDcf    // "WM_STATECODE_DCF_IND"
	.word aWmStatecodeBea_0  // "WM_STATECODE_BEACON_RECV"
	.word aWmStatecodeDis_0  // "WM_STATECODE_DISASSOCIATE"
	.word aWmStatecodeRea    // "WM_STATECODE_REASSOCIATE"
	.word aWmStatecodeAut    // "WM_STATECODE_AUTHENTICATE"
	.word aWmStatecodePor    // "WM_STATECODE_PORT_SEND"
	.word aWmStatecodePor_0  // "WM_STATECODE_PORT_RECV"
	.word aWmStatecodeFif    // "WM_STATECODE_FIFO_ERROR"
	.word aWmStatecodeInf    // "WM_STATECODE_INFORMATION"
	.word aWmStatecodeUnk    // "WM_STATECODE_UNKNOWN"
	.word aWmStatecodePor_1  // "WM_STATECODE_PORT_INIT"
	.word aWmStatecodeDis_1  // "WM_STATECODE_DISCONNECTED_FROM_MYSELF"

aNA_0: // 0x0211A5C4
	.asciz "N/A"

aS: // 0x0211A5C8
	.asciz "%s -> "

_0211A5CF:
	.byte 0x00
	.byte 0x25, 0x73, 0x0A, 0x00
aWhCallbackforw: // 0x0211A5D4
	.asciz "WH_CallbackForWFS : WFS_Start\n"
_0211A5F3:
	.byte 0x00
aStartparentNew: // 0x0211A5F4
	.asciz "StartParent - new child (aid 0x%x) connected\n"
_0211A622:
	.byte 0x00, 0x00
aStartparentChi: // 0x0211A624
	.asciz "StartParent - child (aid 0x%x) disconnected\n"
_0211A651:
	.byte 0x00, 0x00, 0x00
aStartparentChi_0: // 0x0211A654
	.asciz "StartParent - child (aid 0x%x) disconnected from myself\n"
_0211A68D:
	.byte 0x00, 0x00, 0x00
aUnknownIndicat: // 0x0211A690
	.asciz "unknown indicate, state = %d\n"
_0211A6AE:
	.byte 0x00, 0x00
aWhStateinstart: // 0x0211A6B0
	.asciz "WH_StateInStartParentKeyShare failed\n"
_0211A6D6:
	.byte 0x00, 0x00
aWhStateinendpa: // 0x0211A6D8
	.asciz "WH_StateInEndParentMP failed\n"
_0211A6F6:
	.byte 0x00, 0x00
aWhStateinendpa_0: // 0x0211A6F8
	.asciz "WH_StateInEndParent failed\n"
aRecvBufferSize: // 0x0211A714
	.asciz "recv buffer size = %d\n"
_0211A72B:
	.byte 0x00
aSendBufferSize: // 0x0211A72C
	.asciz "send buffer size = %d\n"
_0211A743:
	.byte 0x00
aWfsInitchildCa: // 0x0211A744
	.asciz "WFS_InitChild call\n"
aWhStateoutstar: // 0x0211A758
	.asciz "WH_StateOutStartScan : MAC=%02x%02x%02x%02x%02x%02x "
_0211A78D:
	.byte 0x00, 0x00, 0x00
aPictochatParen: // 0x0211A790
	.asciz "pictochat parent find\n"
_0211A7A7:
	.byte 0x00
aNotMyParentGgi: // 0x0211A7A8
	.asciz "not my parent ggid \n"
_0211A7BD:
	.byte 0x00, 0x00, 0x00
aNotRecieveEntr: // 0x0211A7C0
	.asciz "not recieve entry\n"
_0211A7D3:
	.byte 0x00
aParentFind: // 0x0211A7D4
	.asciz "parent find\n"
_0211A7E1:
	.byte 0x00, 0x00, 0x00
aWhStateoutends: // 0x0211A7E4
	.asciz "WH_StateOutEndScan : startchild failed\n"
aWhStateoutsetc: // 0x0211A80C
	.asciz "WH_StateOutSetChildWEPKey : startchild failed\n"
_0211A83B:
	.byte 0x00
aWhStateinstart_0: // 0x0211A83C
	.asciz "WH_StateInStartChild : already connected?\n"
_0211A867:
	.byte 0x00
aConnectToParen: // 0x0211A868
	.asciz "Connect to Parent\n"
_0211A87B:
	.byte 0x00
aWhStateinstart_1: // 0x0211A87C
	.asciz "WH_StateInStartChildMP failed\n"
_0211A89B:
	.byte 0x00
aDisconnectedFr: // 0x0211A89C
	.asciz "Disconnected from Parent\n"
_0211A8B6:
	.byte 0x00, 0x00
aUnknownStateDS: // 0x0211A8B8
	.asciz "unknown state %d, %s\n"
_0211A8CE:
	.byte 0x00, 0x00
aWhStateinstart_2: // 0x0211A8D0
	.asciz "WH_StateInStartChildKeyShare failed\n"
_0211A8F5:
	.byte 0x00, 0x00, 0x00
aWhStateoutstar_0: // 0x0211A8F8
	.asciz "WH_StateOutStartChildMP : WM_StartDataSharing OK\n"
_0211A92A:
	.byte 0x00, 0x00
aWhStateinsetmp: // 0x0211A92C
	.asciz "WH_StateInSetMPData failed - %s\n"
_0211A94D:
	.byte 0x00, 0x00, 0x00
aChannelDBratio: // 0x0211A950
	.asciz "channel %d bratio = 0x%x\n"
_0211A96A:
	.byte 0x00, 0x00
aDecidedChannel: // 0x0211A96C
	.asciz "decided channel = %d\n"
_0211A982:
	.byte 0x00, 0x00
aWfsInitparentC: // 0x0211A984
	.asciz "WFS_InitParent call\n"
_0211A999:
	.byte 0x00, 0x00, 0x00
aUnknownConnect: // 0x0211A99C
	.asciz "unknown connect mode %d\n"
_0211A9B5:
	.byte 0x00, 0x00, 0x00
aWmNotInitializ: // 0x0211A9B8
	.asciz "WM not Initialized\n"
aWhStepdatashar: // 0x0211A9CC
	.asciz "WH_StepDataSharing - Warning No DataSet\n"
_0211A9F5:
	.byte 0x00, 0x00, 0x00
aAlreadyWhSysst: // 0x0211A9F8
	.asciz "already WH_SYSSTATE_IDLE\n"
_0211AA12:
	.byte 0x00, 0x00
aWhFinalizeStat: // 0x0211AA14
	.asciz "WH_Finalize, state = %d\n"
_0211AA2D:
	.byte 0x00, 0x00, 0x00
	.byte 0x72, 0x6F, 0x6D, 0x00
aMbpStateStop: // 0x0211AA34
	.asciz "MBP_STATE_STOP"
_0211AA43:
	.byte 0x00
aMbpStateIdle: // 0x0211AA44
	.asciz "MBP_STATE_IDLE"
_0211AA53:
	.byte 0x00
aMbpStateError: // 0x0211AA54
	.asciz "MBP_STATE_ERROR"
aMbpStateEntry: // 0x0211AA64
	.asciz "MBP_STATE_ENTRY"
aMbpStateCancel: // 0x0211AA74
	.asciz "MBP_STATE_CANCEL"
_0211AA85:
	.byte 0x00, 0x00, 0x00
aMbCommPstateEn: // 0x0211AA88
	.asciz "MB_COMM_PSTATE_END"
_0211AA9B:
	.byte 0x00
aMbpStateComple: // 0x0211AA9C
	.asciz "MBP_STATE_COMPLETE"
_0211AAAF:
	.byte 0x00
aMbCommPstateNo: // 0x0211AAB0
	.asciz "MB_COMM_PSTATE_NONE"
aMbpStateReboot: // 0x0211AAC4
	.asciz "MBP_STATE_REBOOTING"
aMbCommPstateEr: // 0x0211AAD8
	.asciz "MB_COMM_PSTATE_ERROR"
_0211AAED:
	.byte 0x00, 0x00, 0x00
aMbpStateDatase: // 0x0211AAF0
	.asciz "MBP_STATE_DATASENDING"
_0211AB06:
	.byte 0x00, 0x00
aMbCommPstateKi: // 0x0211AB08
	.asciz "MB_COMM_PSTATE_KICKED"
	.align 4

_0211AB20:
	.word mbpState+0x02
	.word mbpState+0x04
	.word mbpState+0x06
	.word mbpState+0x08
	.word mbpState+0x0A
	.word mbpState+0x0C

_0211AB38: // 0x0211AB38
	.word aMbpStateStop       // "MBP_STATE_STOP"
	.word aMbpStateIdle       // "MBP_STATE_IDLE"
	.word aMbpStateEntry      // "MBP_STATE_ENTRY"
	.word aMbpStateDatase     // "MBP_STATE_DATASENDING"
	.word aMbpStateReboot     // "MBP_STATE_REBOOTING"
	.word aMbpStateComple     // "MBP_STATE_COMPLETE"
	.word aMbpStateCancel     // "MBP_STATE_CANCEL"
	.word aMbpStateError      // "MBP_STATE_ERROR"
	.word aMbCommPstateNo     // "MB_COMM_PSTATE_NONE"
	.word aMbCommPstateIn     // "MB_COMM_PSTATE_INIT_COMPLETE"
	.word aMbCommPstateCo     // "MB_COMM_PSTATE_CONNECTED"
	.word aMbCommPstateDi     // "MB_COMM_PSTATE_DISCONNECTED"
	.word aMbCommPstateKi     // "MB_COMM_PSTATE_KICKED"
	.word aMbCommPstateRe     // "MB_COMM_PSTATE_REQ_ACCEPTED"
	.word aMbCommPstateSe     // "MB_COMM_PSTATE_SEND_PROCEED"
	.word aMbCommPstateSe_0   // "MB_COMM_PSTATE_SEND_COMPLETE"
	.word aMbCommPstateBo     // "MB_COMM_PSTATE_BOOT_REQUEST"
	.word aMbCommPstateBo_0   // "MB_COMM_PSTATE_BOOT_STARTABLE"
	.word aMbCommPstateRe_0   // "MB_COMM_PSTATE_REQUESTED"
	.word aMbCommPstateMe     // "MB_COMM_PSTATE_MEMBER_FULL"
	.word aMbCommPstateEn     // "MB_COMM_PSTATE_END"
	.word aMbCommPstateEr     // "MB_COMM_PSTATE_ERROR"
	.word aMbCommPstateWa     // "MB_COMM_PSTATE_WAIT_TO_SEND"

aMbCommPstateCo: // 0x0211AB94
	.asciz "MB_COMM_PSTATE_CONNECTED"
_0211ABAD:
	.byte 0x00, 0x00, 0x00
aMbCommPstateRe_0: // 0x0211ABB0
	.asciz "MB_COMM_PSTATE_REQUESTED"
_0211ABC9:
	.byte 0x00, 0x00, 0x00
aMbCommPstateMe: // 0x0211ABCC
	.asciz "MB_COMM_PSTATE_MEMBER_FULL"
_0211ABE7:
	.byte 0x00
aMbCommPstateDi: // 0x0211ABE8
	.asciz "MB_COMM_PSTATE_DISCONNECTED"
aMbCommPstateRe: // 0x0211AC04
	.asciz "MB_COMM_PSTATE_REQ_ACCEPTED"
aMbCommPstateSe: // 0x0211AC20
	.asciz "MB_COMM_PSTATE_SEND_PROCEED"
aMbCommPstateBo: // 0x0211AC3C
	.asciz "MB_COMM_PSTATE_BOOT_REQUEST"
aMbCommPstateWa: // 0x0211AC58
	.asciz "MB_COMM_PSTATE_WAIT_TO_SEND"
aMbCommPstateIn: // 0x0211AC74
	.asciz "MB_COMM_PSTATE_INIT_COMPLETE"
_0211AC91:
	.byte 0x00, 0x00, 0x00
aMbCommPstateSe_0: // 0x0211AC94
	.asciz "MB_COMM_PSTATE_SEND_COMPLETE"
_0211ACB1:
	.byte 0x00, 0x00, 0x00
aMbCommPstateBo_0: // 0x0211ACB4
	.asciz "MB_COMM_PSTATE_BOOT_STARTABLE"
	.align 4