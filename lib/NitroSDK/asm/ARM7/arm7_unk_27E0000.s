	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start SDK_AUTOLOAD_MAIN_START
SDK_AUTOLOAD_MAIN_START: // 0x027E0000
	ldr r1, _027E002C // =0x027F9454
	ldr r2, [r1, #0x550]
	strh r0, [r2, #0x32]
	add r1, r2, #0x100
	ldrh r1, [r1, #0x88]
	cmp r1, #0
	addeq r0, r0, #2
	streqh r0, [r2, #0x3a]
	addne r0, r0, #2
	strneh r0, [r2, #0x38]
	bx lr
	.align 2, 0
_027E002C: .word 0x027F9454
	arm_func_end SDK_AUTOLOAD_MAIN_START

	arm_func_start WMSP_SetParentSize
WMSP_SetParentSize: // 0x027E0030
	ldr r1, _027E005C // =0x027F9454
	ldr r2, [r1, #0x550]
	strh r0, [r2, #0x30]
	add r1, r2, #0x100
	ldrh r1, [r1, #0x88]
	cmp r1, #0
	addeq r0, r0, #4
	streqh r0, [r2, #0x38]
	addne r0, r0, #4
	strneh r0, [r2, #0x3a]
	bx lr
	.align 2, 0
_027E005C: .word 0x027F9454
	arm_func_end WMSP_SetParentSize

	arm_func_start WMSP_SetChildMaxSize
WMSP_SetChildMaxSize: // 0x027E0060
	ldr r1, _027E00AC // =0x027F9454
	ldr r2, [r1, #0x550]
	strh r0, [r2, #0x36]
	strh r0, [r2, #0x32]
	add r1, r2, #0x100
	ldrh r1, [r1, #0x88]
	cmp r1, #0
	addne r0, r0, #2
	movne r0, r0, lsl #0x10
	movne r0, r0, lsr #0x10
	strneh r0, [r2, #0x3c]
	strneh r0, [r2, #0x38]
	bxne lr
	add r0, r0, #2
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r0, [r2, #0x3e]
	strh r0, [r2, #0x3a]
	bx lr
	.align 2, 0
_027E00AC: .word 0x027F9454
	arm_func_end WMSP_SetChildMaxSize

	arm_func_start WMSP_SetParentMaxSize
WMSP_SetParentMaxSize: // 0x027E00B0
	ldr r1, _027E00FC // =0x027F9454
	ldr r2, [r1, #0x550]
	strh r0, [r2, #0x30]
	strh r0, [r2, #0x34]
	add r1, r2, #0x100
	ldrh r1, [r1, #0x88]
	cmp r1, #0
	addne r0, r0, #4
	movne r0, r0, lsl #0x10
	movne r0, r0, lsr #0x10
	strneh r0, [r2, #0x3e]
	strneh r0, [r2, #0x3a]
	bxne lr
	add r0, r0, #4
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r0, [r2, #0x3c]
	strh r0, [r2, #0x38]
	bx lr
	.align 2, 0
_027E00FC: .word 0x027F9454
	arm_func_end WMSP_SetParentMaxSize

	arm_func_start WMSP_ResetSizeVars
WMSP_ResetSizeVars: // 0x027E0100
	ldr r0, _027E0130 // =0x027F9454
	ldr r1, [r0, #0x550]
	mov r0, #0
	strh r0, [r1, #0x38]
	strh r0, [r1, #0x3a]
	strh r0, [r1, #0x30]
	strh r0, [r1, #0x32]
	strh r0, [r1, #0x3c]
	strh r0, [r1, #0x3e]
	strh r0, [r1, #0x34]
	strh r0, [r1, #0x36]
	bx lr
	.align 2, 0
_027E0130: .word 0x027F9454
	arm_func_end WMSP_ResetSizeVars

	arm_func_start WMSP_GetInternalRequestBuf
WMSP_GetInternalRequestBuf: // 0x027E0134
	stmdb sp!, {r4, lr}
	mov r4, #0
	bl OS_DisableInterrupts
	ldr r1, _027E01A0 // =0x027F9454
	ldr r2, [r1, #0x54c]
	cmp r2, #0
	beq _027E0190
	mov ip, r4
	b _027E0188
_027E0158:
	mov r3, ip, lsl #4
	add r1, r2, ip, lsl #4
	ldr r1, [r1, #0xd0]
	ands r1, r1, #0x8000
	beq _027E0184
	add r2, r2, #0xd0
	add r4, r2, r3
	ldr r1, [r2, r3]
	bic r1, r1, #0x8000
	str r1, [r2, r3]
	b _027E0190
_027E0184:
	add ip, ip, #1
_027E0188:
	cmp ip, #0x20
	blt _027E0158
_027E0190:
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E01A0: .word 0x027F9454
	arm_func_end WMSP_GetInternalRequestBuf

	arm_func_start WmspError
WmspError: // 0x027E01A4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl WMSP_GetBuffer4Callback2Wm9
	strh r6, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WmspError

	arm_func_start WMSP_SetThreadPriorityHigh
WMSP_SetThreadPriorityHigh: // 0x027E01D8
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	mov r4, r0
	bl OS_DisableScheduler
	ldr r0, _027E022C // =0x0380BCCC
	ldr r1, _027E0230 // =0x027F9454
	ldr r1, [r1, #0x578]
	bl OS_YieldThread
	bl WL_GetThreadStruct
	ldr r1, _027E0230 // =0x027F9454
	ldr r1, [r1, #0x57c]
	bl OS_YieldThread
	ldr r0, _027E0234 // =0x0380BC28
	ldr r1, _027E0230 // =0x027F9454
	ldr r1, [r1, #0x580]
	bl OS_YieldThread
	bl OS_EnableScheduler
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E022C: .word 0x0380BCCC
_027E0230: .word 0x027F9454
_027E0234: .word 0x0380BC28
	arm_func_end WMSP_SetThreadPriorityHigh

	arm_func_start WMSP_SetThreadPriorityLow
WMSP_SetThreadPriorityLow: // 0x027E0238
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	mov r4, r0
	bl OS_DisableScheduler
	ldr r0, _027E028C // =0x0380BC28
	ldr r1, _027E0290 // =0x027F9454
	ldr r1, [r1, #0x58c]
	bl OS_YieldThread
	bl WL_GetThreadStruct
	ldr r1, _027E0290 // =0x027F9454
	ldr r1, [r1, #0x588]
	bl OS_YieldThread
	ldr r0, _027E0294 // =0x0380BCCC
	ldr r1, _027E0290 // =0x027F9454
	ldr r1, [r1, #0x584]
	bl OS_YieldThread
	bl OS_EnableScheduler
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E028C: .word 0x0380BC28
_027E0290: .word 0x027F9454
_027E0294: .word 0x0380BCCC
	arm_func_end WMSP_SetThreadPriorityLow

	arm_func_start WMSP_GetLinkLevel
WMSP_GetLinkLevel: // 0x027E0298
	ldr r1, _027E02FC // =0x027F9454
	ldr r1, [r1, #0x54c]
	ldrb r1, [r1, #0x53]
	cmp r1, #8
	bne _027E02D4
	cmp r0, #0x16
	movlo r0, #0
	bxlo lr
	cmp r0, #0x1c
	movlo r0, #1
	bxlo lr
	cmp r0, #0x22
	movlo r0, #2
	movhs r0, #3
	bx lr
_027E02D4:
	cmp r0, #8
	movlo r0, #0
	bxlo lr
	cmp r0, #0xe
	movlo r0, #1
	bxlo lr
	cmp r0, #0x14
	movlo r0, #2
	movhs r0, #3
	bx lr
	.align 2, 0
_027E02FC: .word 0x027F9454
	arm_func_end WMSP_GetLinkLevel

	arm_func_start WMSP_GetAverageLinkLevel
WMSP_GetAverageLinkLevel: // 0x027E0300
	mov r2, #0
	mov r3, r2
	ldr r1, _027E0334 // =_027F8454
_027E030C:
	add r0, r1, r3
	add r0, r0, #0x1000
	ldrb r0, [r0, #0x554]
	add r2, r2, r0
	add r3, r3, #1
	cmp r3, #0x20
	blt _027E030C
	mov r0, r2, lsr #5
	ldr ip, _027E0338 // =WMSP_GetLinkLevel
	bx ip
	.align 2, 0
_027E0334: .word _027F8454
_027E0338: .word WMSP_GetLinkLevel
	arm_func_end WMSP_GetAverageLinkLevel

	arm_func_start WMSP_FillRssiIntoList
WMSP_FillRssiIntoList: // 0x027E033C
	mov r3, #0
	ldr r2, _027E036C // =_027F8454
_027E0344:
	add r1, r2, r3
	add r1, r1, #0x1000
	strb r0, [r1, #0x554]
	add r3, r3, #1
	cmp r3, #0x20
	blt _027E0344
	mov r1, #0
	ldr r0, _027E0370 // =0x027F9454
	str r1, [r0, #0x574]
	bx lr
	.align 2, 0
_027E036C: .word _027F8454
_027E0370: .word 0x027F9454
	arm_func_end WMSP_FillRssiIntoList

	arm_func_start WMSP_AddRssiToList
WMSP_AddRssiToList: // 0x027E0374
	ldr r1, _027E03AC // =0x027F9454
	ldr r3, [r1, #0x574]
	ldr r2, _027E03B0 // =0x027F99A8
	strb r0, [r2, r3]
	ldr r2, [r1, #0x574]
	add r2, r2, #1
	and r2, r2, #0x1f
	str r2, [r1, #0x574]
	ldr r2, _027E03B4 // =0x027FFF98
	ldrh r1, [r2, #0]
	eor r0, r0, r1, lsl #1
	eor r0, r0, r0, lsr #16
	strh r0, [r2]
	bx lr
	.align 2, 0
_027E03AC: .word 0x027F9454
_027E03B0: .word 0x027F99A8
_027E03B4: .word 0x027FFF98
	arm_func_end WMSP_AddRssiToList

	arm_func_start WMSP_SetAllParams
WMSP_SetAllParams: // 0x027E03B8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027E04FC // =0x027F9454
	ldr r4, [r0, #0x550]
	add r0, r4, #0xe0
	add r1, r5, #0x10
	mov r2, #6
	bl MI_CpuCopy8
	mov r0, #7
	strh r0, [r5, #0x16]
	add r0, r4, #0x100
	ldrh r1, [r0, #0xf4]
	strh r1, [r5, #0x18]
	ldrh r1, [r0, #0xec]
	strh r1, [r5, #0x1e]
	ldrh r1, [r4, #0xe6]
	strh r1, [r5, #0x1c]
	ldr r1, [r4, #0x198]
	cmp r1, #0
	bne _027E0430
	mov r0, #0
	strh r0, [r5, #0x20]
	strh r0, [r5, #0x22]
	add r1, r5, #0x24
	mov r2, #0x50
	bl MIi_CpuClear16
	mov r0, #0
	strh r0, [r5, #0x9e]
	b _027E0458
_027E0430:
	ldrh r0, [r0, #0x96]
	strh r0, [r5, #0x20]
	ldrh r0, [r4, #0xc4]
	strh r0, [r5, #0x22]
	add r0, r4, #0x19c
	add r1, r5, #0x24
	mov r2, #0x50
	bl MI_CpuCopy8
	mov r0, #1
	strh r0, [r5, #0x9e]
_027E0458:
	mov r0, #1
	strh r0, [r5, #0x74]
	strh r0, [r5, #0x76]
	ldrh r0, [r4, #0xe6]
	cmp r0, #1
	moveq r0, #0
	streqh r0, [r5, #0x78]
	movne r0, #0x10
	strneh r0, [r5, #0x78]
	mov r0, #0xa
	strh r0, [r5, #0x7a]
	cmp r6, #0x26
	bne _027E04A0
	mov r0, #0
	add r1, r5, #0x7c
	mov r2, #0x20
	bl MIi_CpuClear16
	b _027E04C0
_027E04A0:
	mov r0, #0
	add r1, r5, #0x7c
	mov r2, #8
	bl MIi_CpuClear16
	ldr r0, _027E0500 // =0x0000FFFF
	add r1, r5, #0x84
	mov r2, #0x18
	bl MIi_CpuClear16
_027E04C0:
	add r0, r4, #0x100
	ldrh r0, [r0, #0xee]
	strh r0, [r5, #0x9c]
	mov r0, r5
	bl WMSP_WL_ParamSetAll
	ldrh r2, [r0, #4]
	cmp r2, #0
	moveq r0, #1
	beq _027E04F4
	mov r0, r6
	mov r1, #0x200
	bl WmspError
	mov r0, #0
_027E04F4:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027E04FC: .word 0x027F9454
_027E0500: .word 0x0000FFFF
	arm_func_end WMSP_SetAllParams

	arm_func_start WMSP_CopyParentParam
WMSP_CopyParentParam: // 0x027E0504
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r0
	ldr r0, [r1, #8]
	str r0, [r2, #4]
	ldrh r0, [r1, #0xc]
	strh r0, [r2, #8]
	ldrh r0, [r1, #0x12]
	cmp r0, #0
	movne r3, #2
	moveq r3, #0
	ldrh r0, [r1, #0xe]
	cmp r0, #0
	movne ip, #1
	moveq ip, #0
	ldrh r0, [r1, #0x14]
	cmp r0, #0
	movne lr, #4
	moveq lr, #0
	orr r0, ip, r3
	orr r0, lr, r0
	strb r0, [r2, #0xb]
	ldrh r0, [r1, #4]
	strb r0, [r2, #0xa]
	mov r0, #1
	strh r0, [r2]
	strb r0, [r2, #2]
	mov r0, #0
	strb r0, [r2, #3]
	ldrh r0, [r1, #0x34]
	strh r0, [r2, #0xc]
	ldrh r0, [r1, #0x36]
	strh r0, [r2, #0xe]
	ldrb r3, [r2, #0xa]
	cmp r3, #0
	beq _027E05A8
	ldr r0, [r1, #0]
	add r1, r2, #0x10
	add r2, r3, #1
	bic r2, r2, #1
	bl MI_CpuCopy8
_027E05A8:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WMSP_CopyParentParam

	arm_func_start WMSP_CheckMacAddress
WMSP_CheckMacAddress: // 0x027E05B4
	ldr r1, _027E062C // =0x027F9454
	ldr r1, [r1, #0x550]
	add r3, r1, #0xe0
	ldrb r2, [r0, #0]
	ldrb r1, [r1, #0xe0]
	cmp r2, r1
	bne _027E0624
	ldrb r2, [r0, #1]
	ldrb r1, [r3, #1]
	cmp r2, r1
	bne _027E0624
	ldrb r2, [r0, #2]
	ldrb r1, [r3, #2]
	cmp r2, r1
	bne _027E0624
	ldrb r2, [r0, #3]
	ldrb r1, [r3, #3]
	cmp r2, r1
	bne _027E0624
	ldrb r2, [r0, #4]
	ldrb r1, [r3, #4]
	cmp r2, r1
	bne _027E0624
	ldrb r1, [r0, #5]
	ldrb r0, [r3, #5]
	cmp r1, r0
	moveq r0, #1
	bxeq lr
_027E0624:
	mov r0, #0
	bx lr
	.align 2, 0
_027E062C: .word 0x027F9454
	arm_func_end WMSP_CheckMacAddress

	arm_func_start WmspPxiCallback
WmspPxiCallback: // 0x027E0630
	stmdb sp!, {r4, lr}
	mov r4, r1
	cmp r2, #0
	bne _027E0688
	ldr r0, _027E0690 // =byte_27F84DC
	mov r2, #0
	bl OS_SendMessage
	cmp r0, #0
	bne _027E0688
	ldr r0, _027E0694 // =0x027F9454
	ldr r0, [r0, #0x54c]
	cmp r0, #0
	beq _027E0688
	bl WMSP_GetBuffer4Callback2Wm9
	ldrh r1, [r4, #0]
	strh r1, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	mov r1, #0
	strh r1, [r0, #4]
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
_027E0688:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E0690: .word byte_27F84DC
_027E0694: .word 0x027F9454
	arm_func_end WmspPxiCallback

	arm_func_start WMSP_WlRequest
WMSP_WlRequest: // 0x027E0698
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, r0
	ldr r0, _027E0710 // =_027F8454
	mov r2, #1
	bl OS_SendMessage
	ldr r0, _027E0714 // =byte_27F84AC
	add r1, sp, #0
	mov r2, #1
	bl OS_ReceiveMessage
	ldr r1, [sp]
	ldrh r0, [r1, #0xe]
	add r0, r1, r0, lsl #1
	ldrh r0, [r0, #0x14]
	cmp r0, #0xe
	bne _027E0700
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #0x13
	strh r1, [r0, #2]
	mov r1, #0x18
	strh r1, [r0, #4]
	bl WMSP_ReturnResult2Wm9
	bl SND_BeginSleep
	bl OS_Terminate
_027E0700:
	ldr r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E0710: .word _027F8454
_027E0714: .word byte_27F84AC
	arm_func_end WMSP_WlRequest

	arm_func_start WM_sp_init
WM_sp_init: // 0x027E0718
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r4, r1
	ldr r1, [r4, #0]
	ldr r0, _027E08A4 // =0x027F9454
	str r1, [r0, #0x540]
	ldr r1, [r5, #0x24]
	str r1, [r0, #0x544]
	ldr r1, [r5, #0x28]
	str r1, [r0, #0x548]
	mov r1, #0
	str r1, [r0, #0x54c]
	str r1, [r0, #0x550]
	ldr r0, _027E08A8 // =_027F8454
	ldr r1, _027E08AC // =byte_27F8474
	mov r2, #2
	bl OS_InitMessageQueue
	ldr r0, _027E08B0 // =byte_27F847C
	ldr r1, _027E08B4 // =byte_27F849C
	mov r2, #4
	bl OS_InitMessageQueue
	ldr r0, _027E08B8 // =byte_27F84AC
	ldr r1, _027E08BC // =byte_27F84CC
	mov r2, #4
	bl OS_InitMessageQueue
	ldr r0, _027E08C0 // =byte_27F84DC
	ldr r1, _027E08C4 // =0x027F84FC
	mov r2, #0x20
	bl OS_InitMessageQueue
	ldr r0, _027E08A8 // =_027F8454
	str r0, [r5, #0x10]
	ldr r0, _027E08B0 // =byte_27F847C
	str r0, [r5, #0x14]
	ldr r1, [r4, #8]
	ldr r0, _027E08A4 // =0x027F9454
	str r1, [r0, #0x578]
	ldr r1, [r4, #0x18]
	str r1, [r0, #0x57c]
	ldr r1, [r4, #0x10]
	str r1, [r0, #0x580]
	ldr r1, [r4, #4]
	str r1, [r0, #0x584]
	ldr r1, [r4, #0x14]
	str r1, [r0, #0x588]
	ldr r1, [r4, #0xc]
	str r1, [r0, #0x58c]
	ldr r0, _027E08C8 // =0x027F997C
	bl OS_InitMutex
	mov r0, #0x400
	str r0, [sp]
	ldr r0, [r4, #4]
	str r0, [sp, #4]
	ldr r0, _027E08CC // =0x0380BCCC
	ldr r1, _027E08D0 // =WMSP_IndicateThread
	mov r2, #0
	ldr r3, _027E08C8 // =0x027F997C
	bl OS_CreateThread
	ldr r0, _027E08CC // =0x0380BCCC
	bl OS_WakeupThreadDirect
	mov r0, #0x1000
	str r0, [sp]
	ldr r0, [r4, #0xc]
	str r0, [sp, #4]
	ldr r0, _027E08D4 // =0x0380BC28
	ldr r1, _027E08D8 // =WMSP_RequestThread
	mov r2, #0
	ldr r3, _027E08DC // =0x027F957C
	bl OS_CreateThread
	ldr r0, _027E08D4 // =0x0380BC28
	bl OS_WakeupThreadDirect
	mov r3, #0
	mov r2, r3
	ldr r1, _027E08A8 // =_027F8454
_027E0840:
	add r0, r1, r3
	add r0, r0, #0x1000
	strb r2, [r0, #0x554]
	add r3, r3, #1
	cmp r3, #0x20
	blt _027E0840
	ldr r0, _027E08A4 // =0x027F9454
	str r2, [r0, #0x574]
	bl OS_IsVAlarmAvailable
	cmp r0, #0
	bne _027E0870
	bl OS_InitVAlarm
_027E0870:
	bl PXI_Init
	mov r0, #0xa
	ldr r1, _027E08E0 // =WmspPxiCallback
	bl PXI_SetFifoRecvCallback
	mov r0, #2
	str r0, [r5, #0x18]
	ldr r0, [r4, #0x14]
	str r0, [r5, #0xc]
	mov r0, r5
	bl WL_InitDriver
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E08A4: .word 0x027F9454
_027E08A8: .word _027F8454
_027E08AC: .word byte_27F8474
_027E08B0: .word byte_27F847C
_027E08B4: .word byte_27F849C
_027E08B8: .word byte_27F84AC
_027E08BC: .word byte_27F84CC
_027E08C0: .word byte_27F84DC
_027E08C4: .word 0x027F84FC
_027E08C8: .word 0x027F997C
_027E08CC: .word 0x0380BCCC
_027E08D0: .word WMSP_IndicateThread
_027E08D4: .word 0x0380BC28
_027E08D8: .word WMSP_RequestThread
_027E08DC: .word 0x027F957C
_027E08E0: .word WmspPxiCallback
	arm_func_end WM_sp_init

	arm_func_start WMSP_InitAlarm
WMSP_InitAlarm: // 0x027E08E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027E0908 // =0x0380BD9C
	bl OS_CreateAlarm
	ldr r0, _027E090C // =0x0380BD70
	bl OS_CreateAlarm
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E0908: .word 0x0380BD9C
_027E090C: .word 0x0380BD70
	arm_func_end WMSP_InitAlarm

	arm_func_start WmspIndicateMlmeAuthenticate
WmspIndicateMlmeAuthenticate: // 0x027E0910
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #0x13
	strh r1, [r0, #4]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WmspIndicateMlmeAuthenticate

	arm_func_start WmspIndicateMlmeDeAuthenticate
WmspIndicateMlmeDeAuthenticate: // 0x027E0944
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r8, r0
	ldr r0, _027E0C04 // =0x027F9454
	ldr r6, [r0, #0x550]
	ldrh r0, [r6, #0]
	cmp r0, #7
	beq _027E096C
	cmp r0, #9
	bne _027E0AF8
_027E096C:
	add r0, r8, #0x10
	add r1, sp, #0
	mov r2, #6
	bl MI_CpuCopy8
	mov r5, #0
	mov r7, r5
	mov r4, #1
	mov r9, #6
	b _027E0A70
_027E0990:
	bl OS_DisableInterrupts
	mov r11, r0
	add ip, r6, #0x100
	ldrh r3, [ip, #0x82]
	add r1, r7, #1
	mov r0, r4, lsl r1
	ands r0, r3, r0
	beq _027E0A64
	mul r2, r7, r9
	add r0, r6, r2
	ldrb lr, [sp]
	ldrb r10, [r0, #0x128]
	cmp lr, r10
	bne _027E0A64
	ldrb lr, [sp, #1]
	ldrb r10, [r0, #0x129]
	cmp lr, r10
	bne _027E0A64
	ldrb lr, [sp, #2]
	ldrb r10, [r0, #0x12a]
	cmp lr, r10
	bne _027E0A64
	ldrb lr, [sp, #3]
	ldrb r10, [r0, #0x12b]
	cmp lr, r10
	bne _027E0A64
	ldrb r10, [sp, #4]
	ldrb lr, [r0, #0x12c]
	cmp r10, lr
	bne _027E0A64
	ldrb r10, [sp, #5]
	ldrb r0, [r0, #0x12d]
	cmp r10, r0
	bne _027E0A64
	mov r0, r1, lsl #0x10
	mov r5, r0, lsr #0x10
	mvn r1, r4, lsl r5
	and r0, r3, r1
	strh r0, [ip, #0x82]
	ldrh r0, [r6, #0x86]
	and r0, r0, r1
	strh r0, [r6, #0x86]
	mov r1, #0
	add r0, r6, r5, lsl #3
	str r1, [r0, #0x738]
	str r1, [r0, #0x73c]
	add r0, r6, #0x128
	add r0, r0, r2
	mov r2, #6
	bl MI_CpuFill8
	mov r0, r11
	bl OS_RestoreInterrupts
	b _027E0A78
_027E0A64:
	mov r0, r11
	bl OS_RestoreInterrupts
	add r7, r7, #1
_027E0A70:
	cmp r7, #0xf
	blt _027E0990
_027E0A78:
	cmp r5, #0
	beq _027E0BF8
	bl WMSP_GetBuffer4Callback2Wm9
	mov r4, r0
	mov r0, #8
	strh r0, [r4]
	mov r0, #0
	strh r0, [r4, #2]
	mov r0, #9
	strh r0, [r4, #8]
	ldrh r0, [r8, #0x16]
	strh r0, [r4, #0x12]
	strh r5, [r4, #0x10]
	add r0, r8, #0x10
	add r1, r4, #0xa
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r0, [r6, #0x30]
	strh r0, [r4, #0x2c]
	ldrh r0, [r6, #0x32]
	strh r0, [r4, #0x2e]
	mov r0, r4
	bl WMSP_ReturnResult2Wm9
	ldr r0, [r6, #0xc]
	cmp r0, #1
	bne _027E0BF8
	mov r0, #1
	mov r0, r0, lsl r5
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WMSP_CleanSendQueue
	b _027E0BF8
_027E0AF8:
	mov r5, #0
	bl OS_DisableInterrupts
	mov r4, r0
	add r1, r6, #0x100
	ldrh r1, [r1, #0x82]
	cmp r1, #0
	bne _027E0B1C
	bl OS_RestoreInterrupts
	b _027E0BF8
_027E0B1C:
	ldr r0, [r6, #0xc]
	cmp r0, #1
	bne _027E0B3C
	mov r0, r5
	str r0, [r6, #0xc]
	mov r5, #1
	bl WMSP_CancelVAlarm
	bl WMSP_SetThreadPriorityLow
_027E0B3C:
	mov r1, #0
	add r0, r6, #0x100
	strh r1, [r0, #0x82]
	strh r1, [r6, #0x86]
	str r1, [r6, #0x14]
	str r1, [r6, #0x10]
	str r1, [r6, #0x1c]
	str r1, [r6, #0x198]
	strh r1, [r0, #0x96]
	add r0, r6, #0x19c
	mov r2, #0x50
	bl MI_CpuFill8
	bl WMSP_ResetSizeVars
	mov r0, #0
	strh r0, [r6, #0xc2]
	mov r0, #3
	strh r0, [r6]
	mov r0, r4
	bl OS_RestoreInterrupts
	bl WMSP_GetBuffer4Callback2Wm9
	mov r4, r0
	mov r0, #0xc
	strh r0, [r4]
	mov r0, #0
	strh r0, [r4, #2]
	mov r0, #9
	strh r0, [r4, #8]
	ldrh r0, [r8, #0x16]
	strh r0, [r4, #0xc]
	add r0, r6, #0x100
	ldrh r0, [r0, #0x88]
	strh r0, [r4, #0xa]
	ldr r0, _027E0C08 // =0x0000018A
	add r0, r6, r0
	add r1, r4, #0x10
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r0, [r6, #0x30]
	strh r0, [r4, #0x16]
	ldrh r0, [r6, #0x32]
	strh r0, [r4, #0x18]
	mov r0, r4
	bl WMSP_ReturnResult2Wm9
	cmp r5, #0
	beq _027E0BF8
	mov r0, #1
	bl WMSP_CleanSendQueue
_027E0BF8:
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E0C04: .word 0x027F9454
_027E0C08: .word 0x0000018A
	arm_func_end WmspIndicateMlmeDeAuthenticate

	arm_func_start WmspIndicateMlmeAssociate
WmspIndicateMlmeAssociate: // 0x027E0C0C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r0, _027E0D8C // =0x027F9454
	ldr r5, [r0, #0x550]
	ldrh r6, [r7, #0x16]
	cmp r6, #0
	beq _027E0D80
	cmp r6, #0x10
	bhs _027E0D80
	ldrh r0, [r5, #0xf6]
	cmp r0, #0
	bne _027E0CAC
	bl WMSP_GetInternalRequestBuf
	movs r4, r0
	moveq r0, #0
	beq _027E0C78
	mov r0, #0x22
	str r0, [r4]
	add r0, r7, #0x10
	add r1, r4, #4
	mov r2, #6
	bl MI_CpuCopy8
	ldr r0, _027E0D90 // =byte_27F84DC
	mov r1, r4
	mov r2, #0
	bl OS_SendMessage
_027E0C78:
	cmp r0, #0
	bne _027E0D80
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	mov r1, #0x16
	strh r1, [r0, #4]
	mov r1, #0x22
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	b _027E0D80
_027E0CAC:
	bl OS_DisableInterrupts
	mov r4, r0
	mov r2, #1
	add r0, r5, #0x100
	ldrh r1, [r0, #0x82]
	orr r1, r1, r2, lsl r6
	strh r1, [r0, #0x82]
	ldrh r1, [r5, #0x86]
	mvn r0, r2, lsl r6
	and r0, r1, r0
	strh r0, [r5, #0x86]
	bl OS_GetTick
	orr r1, r1, #0
	orr r2, r0, #1
	add r0, r5, r6, lsl #3
	str r2, [r0, #0x738]
	str r1, [r0, #0x73c]
	add r0, r7, #0x10
	add r1, r5, #0x128
	sub r3, r6, #1
	mov r2, #6
	mla r1, r3, r2, r1
	bl MI_CpuCopy8
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
	add r1, r5, #0x1f8
	add r1, r1, r6, lsl #4
	mov r2, #0x10
	bl MIi_CpuClear16
	bl WMSP_GetBuffer4Callback2Wm9
	mov r4, r0
	mov r0, #8
	strh r0, [r4]
	mov r0, #0
	strh r0, [r4, #2]
	mov r0, #7
	strh r0, [r4, #8]
	add r0, r7, #0x10
	add r1, r4, #0xa
	mov r2, #6
	bl MI_CpuCopy8
	strh r6, [r4, #0x10]
	add r0, r7, #0x22
	add r1, r4, #0x14
	mov r2, #0x18
	bl MIi_CpuCopy16
	ldrh r0, [r5, #0x30]
	strh r0, [r4, #0x2c]
	ldrh r0, [r5, #0x32]
	strh r0, [r4, #0x2e]
	mov r0, r4
	bl WMSP_ReturnResult2Wm9
_027E0D80:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027E0D8C: .word 0x027F9454
_027E0D90: .word byte_27F84DC
	arm_func_end WmspIndicateMlmeAssociate

	arm_func_start WmspIndicateMlmeReAssociate
WmspIndicateMlmeReAssociate: // 0x027E0D94
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #0x12
	strh r1, [r0, #4]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WmspIndicateMlmeReAssociate

	arm_func_start WmspIndicateMlmeDisAssociate
WmspIndicateMlmeDisAssociate: // 0x027E0DC8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #0x11
	strh r1, [r0, #4]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WmspIndicateMlmeDisAssociate

	arm_func_start WmspIndicateMaFatalErr
WmspIndicateMaFatalErr: // 0x027E0DFC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _027E0F20 // =0x027F9454
	ldr r5, [r1, #0x550]
	ldrh r1, [r5, #0x9a]
	cmp r1, #1
	bne _027E0E80
	ldrh r0, [r0, #0x10]
	cmp r0, #0x20
	bne _027E0E80
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r0, _027E0F24 // =0x0380BD70
	bl OS_CancelAlarm
	mov r0, #0
	strh r0, [r5, #0x84]
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r1, #0
	strh r1, [r5, #0x8a]
	mov r0, #1
	bl WMSP_FlushSendQueue
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #0x17
	strh r1, [r0, #4]
	mov r1, #1
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	b _027E0F14
_027E0E80:
	bl WMSP_GetInternalRequestBuf
	movs r1, r0
	moveq r0, #0
	beq _027E0EE4
	mov r0, #0x25
	str r0, [r1]
	ldr r0, _027E0F28 // =0x00008003
	str r0, [r1, #8]
	ldrh r0, [r5, #0]
	cmp r0, #9
	beq _027E0EB4
	cmp r0, #7
	bne _027E0EC0
_027E0EB4:
	ldr r0, _027E0F2C // =0x00007FFE
	str r0, [r1, #4]
	b _027E0ED8
_027E0EC0:
	cmp r0, #0xa
	beq _027E0ED0
	cmp r0, #8
	bne _027E0ED8
_027E0ED0:
	mov r0, #1
	str r0, [r1, #4]
_027E0ED8:
	ldr r0, _027E0F30 // =byte_27F84DC
	mov r2, #0
	bl OS_SendMessage
_027E0EE4:
	cmp r0, #0
	bne _027E0F14
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	mov r1, #0x16
	strh r1, [r0, #4]
	mov r1, #0x25
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
_027E0F14:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E0F20: .word 0x027F9454
_027E0F24: .word 0x0380BD70
_027E0F28: .word 0x00008003
_027E0F2C: .word 0x00007FFE
_027E0F30: .word byte_27F84DC
	arm_func_end WmspIndicateMaFatalErr

	arm_func_start WmspIndicateMaData
WmspIndicateMaData: // 0x027E0F34
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _027E1024 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _027E1018
	ldrb r1, [r5, #0x1f]
	ands r0, r1, #2
	movne r0, r1, asr #2
	andne r0, r0, #0xff
	moveq r0, r1, asr #2
	addeq r0, r0, #0x19
	andeq r0, r0, #0xff
	bl WMSP_AddRssiToList
	bl WMSP_GetAverageLinkLevel
	strh r0, [r4, #0xbc]
	add r5, r5, #0x10
	add r0, r5, #0x1e
	bl WMSP_CheckMacAddress
	cmp r0, #1
	beq _027E1018
	ldrh r1, [r5, #6]
	ldr r0, _027E1028 // =0x000005E4
	cmp r1, r0
	bhi _027E1018
	ldrh r0, [r4, #0xae]
	eor r0, r0, #1
	strh r0, [r4, #0xae]
	ldrh r0, [r4, #0xae]
	add r0, r4, r0, lsl #2
	ldr r4, [r0, #0xb0]
	mov r0, r5
	mov r1, r4
	ldrh r2, [r5, #6]
	add r2, r2, #0x2c
	add r2, r2, #1
	bic r2, r2, #1
	bl MI_CpuCopy8
	add r0, r5, #0x18
	add r1, r4, #0x18
	mov r2, #6
	bl MI_CpuCopy8
	add r0, r5, #0x1e
	add r1, r4, #0x1e
	mov r2, #6
	bl MI_CpuCopy8
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x11
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #0xf
	strh r1, [r0, #4]
	str r4, [r0, #8]
	bl WMSP_ReturnResult2Wm9
_027E1018:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E1024: .word 0x027F9454
_027E1028: .word 0x000005E4
	arm_func_end WmspIndicateMaData

	arm_func_start WmspKickMPChild
WmspKickMPChild: // 0x027E102C
	stmdb sp!, {r4, lr}
	bl WMSP_GetInternalRequestBuf
	movs r1, r0
	ldr r4, _027E10B4 // =_027F8454
	ldr r0, _027E10B8 // =0x027F9454
	ldr r0, [r0, #0x550]
	mov r2, #0
	strh r2, [r0, #0x5e]
	strh r2, [r0, #0x60]
	strh r2, [r0, #0x88]
	beq _027E106C
	mov r0, #0x2c
	str r0, [r1]
	add r0, r4, #0x88
	bl OS_SendMessage
	mov r2, r0
_027E106C:
	cmp r2, #0
	bne _027E10AC
	add r0, r4, #0x1000
	ldr r0, [r0, #0x54c]
	cmp r0, #0
	beq _027E10AC
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	mov r1, #0x16
	strh r1, [r0, #4]
	mov r1, #0x2c
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
_027E10AC:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E10B4: .word _027F8454
_027E10B8: .word 0x027F9454
	arm_func_end WmspKickMPChild

	arm_func_start WmspMPChildIntervalAlarmCallback
WmspMPChildIntervalAlarmCallback: // 0x027E10BC
	ldr ip, _027E10C4 // =WmspKickMPChild
	bx ip
	.align 2, 0
_027E10C4: .word WmspKickMPChild
	arm_func_end WmspMPChildIntervalAlarmCallback

	arm_func_start WmspIndicateMaMultiPollAck
WmspIndicateMaMultiPollAck: // 0x027E10C8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	add r9, r0, #0x10
	ldr r1, _027E1320 // =0x027F9454
	ldr r5, [r1, #0x550]
	mov r7, #0
	ldr r1, [r5, #0xc]
	cmp r1, #0
	beq _027E1314
	ldrh r0, [r0, #0xe]
	cmp r0, #0
	bne _027E1144
	mov r8, #1
	ldr r2, _027E1324 // =0x048080F8
	ldrh r1, [r2, #0]
	ldr r0, _027E1328 // =0x048080FA
	ldrh r3, [r0, #0]
	ldrh r2, [r2, #0]
	cmp r1, r2
	ldrhih r3, [r0, #0]
	mov r0, r3, lsl #0xc
	orr r0, r0, r2, asr #4
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldrh r0, [r5, #0x82]
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	cmp r0, #0
	bgt _027E1148
	b _027E1314
_027E1144:
	mov r8, r7
_027E1148:
	bl OS_DisableInterrupts
	mov r4, r0
	ldrh r1, [r5, #0x84]
	cmp r1, #0
	bne _027E1164
	bl OS_RestoreInterrupts
	b _027E1314
_027E1164:
	mov r0, #0
	strh r0, [r5, #0x84]
	ldrh r6, [r5, #0x90]
	ldr r0, _027E132C // =0x0380BD70
	bl OS_CancelAlarm
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
	ldrh r3, [r5, #0x8c]
	cmp r3, #0
	beq _027E11B4
	cmp r8, #0
	bne _027E11B0
	ldrh r2, [r9, #0x2e]
	add r1, r5, #0x100
	ldrh r1, [r1, #0x88]
	mov r1, r0, lsl r1
	ands r1, r2, r1
	bne _027E11B4
_027E11B0:
	mov r0, #0
_027E11B4:
	cmp r3, #0
	movne r1, #0
	strneh r1, [r5, #0x8c]
	ldrh r1, [r5, #0x8e]
	cmp r1, #0
	beq _027E11F0
	mov r1, #0
	strh r1, [r5, #0x8e]
	cmp r0, #0
	movne r1, #1
	mov r0, r8
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl WMSP_FlushSendQueue
	mov r7, r0
_027E11F0:
	cmp r6, #0
	beq _027E1314
	bl WMSP_GetBuffer4Callback2Wm9
	mov r4, r0
	mov r0, #0xe
	strh r0, [r4]
	cmp r8, #0
	movne r0, #9
	strneh r0, [r4, #2]
	bne _027E1240
	ldrh r2, [r9, #0x2e]
	mov r1, #1
	add r0, r5, #0x100
	ldrh r0, [r0, #0x88]
	mov r0, r1, lsl r0
	ands r0, r2, r0
	movne r0, #0xf
	strneh r0, [r4, #2]
	moveq r0, #0
	streqh r0, [r4, #2]
_027E1240:
	mov r0, #0xd
	strh r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #8]
	cmp r8, #0
	bne _027E12A0
	ldrh r0, [r9, #0xc]
	strh r0, [r4, #0xc]
	ldrh r0, [r9, #0xe]
	strh r0, [r4, #0xe]
	add r0, r9, #0x18
	add r1, r4, #0x10
	mov r2, #6
	bl MI_CpuCopy8
	add r0, r9, #0x1e
	add r1, r4, #0x16
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r0, [r9, #0x2a]
	strh r0, [r4, #0x1c]
	ldrh r0, [r9, #0x2c]
	strh r0, [r4, #0x1e]
	ldrh r0, [r9, #0x2e]
	strh r0, [r4, #0x20]
_027E12A0:
	mov r0, r4
	bl WMSP_ReturnResult2Wm9
	cmp r6, #0
	beq _027E1314
	cmp r7, #1
	beq _027E12C4
	ldrh r0, [r5, #0x5e]
	cmp r0, #0
	bne _027E1300
_027E12C4:
	ldrh r0, [r5, #0x46]
	cmp r0, #0
	beq _027E12F8
	ldr r0, _027E1330 // =0x0380BD9C
	bl OS_CancelAlarm
	mov r0, #0
	str r0, [sp]
	ldr r0, _027E1330 // =0x0380BD9C
	ldr r1, [r5, #0x50]
	ldr r2, [r5, #0x54]
	ldr r3, _027E1334 // =WmspMPChildIntervalAlarmCallback
	bl OS_SetAlarm
	b _027E1314
_027E12F8:
	bl WmspKickMPChild
	b _027E1314
_027E1300:
	mov r1, #0
	strh r1, [r5, #0x5e]
	mov r0, #1
	strh r0, [r5, #0x60]
	strh r1, [r5, #0x88]
_027E1314:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027E1320: .word 0x027F9454
_027E1324: .word 0x048080F8
_027E1328: .word 0x048080FA
_027E132C: .word 0x0380BD70
_027E1330: .word 0x0380BD9C
_027E1334: .word WmspMPChildIntervalAlarmCallback
	arm_func_end WmspIndicateMaMultiPollAck

	arm_func_start WmspMaMultiPollAckAlarmCallback
WmspMaMultiPollAckAlarmCallback: // 0x027E1338
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r5, _027E13C8 // =_027F8454
	ldr r1, _027E13CC // =0x027F9454
	ldr r0, [r1, #0x544]
	ldr r1, [r1, #0x548]
	mov r2, #0x40
	bl OS_AllocFromHeap
	mov r4, r0
	ldr r0, _027E13D0 // =0x00000185
	strh r0, [r4, #0xc]
	mov r2, #0
	strh r2, [r4, #0xe]
	ldr r0, _027E13D4 // =byte_27F847C
	mov r1, r4
	bl OS_SendMessage
	cmp r0, #0
	bne _027E13BC
	mov r0, r4
	bl WmspFreeBufOfWL
	add r0, r5, #0x1000
	ldr r0, [r0, #0x54c]
	cmp r0, #0
	beq _027E13BC
	bl WMSP_GetBuffer4Callback2Wm9
	mov r2, #0x80
	strh r2, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	mov r1, #0x16
	strh r1, [r0, #4]
	strh r2, [r0, #6]
	bl WMSP_ReturnResult2Wm9
_027E13BC:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E13C8: .word _027F8454
_027E13CC: .word 0x027F9454
_027E13D0: .word 0x00000185
_027E13D4: .word byte_27F847C
	arm_func_end WmspMaMultiPollAckAlarmCallback

	arm_func_start WmspIndicateMaMultiPoll
WmspIndicateMaMultiPoll: // 0x027E13D8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	ldr r0, _027E170C // =0x027F9454
	ldr r5, [r0, #0x550]
	ldrb r1, [r10, #0x1f]
	ands r0, r1, #2
	movne r0, r1, asr #2
	andne r1, r0, #0xff
	moveq r0, r1, asr #2
	addeq r0, r0, #0x19
	andeq r1, r0, #0xff
	ldrh r0, [r5, #0xbe]
	cmp r0, r1
	strhih r1, [r5, #0xbe]
	ldr r0, [r5, #0xc]
	cmp r0, #0
	beq _027E1700
	ldrh r0, [r5, #0x60]
	cmp r0, #1
	moveq r0, #0
	streqh r0, [r5, #0x60]
	ldrh r6, [r5, #0x8e]
	ldrh r0, [r5, #0x70]
	eor r0, r0, #1
	strh r0, [r5, #0x70]
	ldrh r0, [r5, #0x70]
	add r0, r5, r0, lsl #2
	ldr r8, [r0, #0x74]
	ldrh r0, [r10, #0x16]
	add r2, r0, #0x30
	ldrh r0, [r5, #0x72]
	cmp r0, r2
	movlo r2, r0
	add r0, r10, #0x10
	mov r1, r8
	bl MI_CpuCopy8
	bl OS_DisableInterrupts
	mov r11, r0
	mov r7, #0
	ldrh r0, [r5, #0x84]
	cmp r0, #1
	bne _027E1490
	mov r7, #1
	ldr r0, _027E1710 // =0x0380BD70
	bl OS_CancelAlarm
_027E1490:
	mov r9, #1
	strh r9, [r5, #0x84]
	ldrh r0, [r8, #0xa]
	strh r0, [r5, #0x82]
	ldrh r4, [r10, #0x18]
	ands r0, r4, #0x2000
	moveq r9, #0
	strh r9, [r5, #0x90]
	mov lr, #0
	str lr, [sp]
	ldr r0, _027E1710 // =0x0380BD70
	ldrh r2, [r8, #0xa]
	ldrh r1, [r8, #0xc]
	sub r1, r2, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	add r1, r1, #0x80
	mov r2, r1, lsl #4
	mov r1, r2, asr #0x1f
	ldr r3, _027E1714 // =0x000082EA
	umull ip, r3, r2, r3
	mla r3, r2, lr, r3
	ldr r2, _027E1714 // =0x000082EA
	mla r3, r1, r2, r3
	mov lr, r3, lsr #6
	mov r1, ip, lsr #6
	orr r1, r1, r3, lsl #26
	mov r2, lr, lsr #0xa
	mov r1, r1, lsr #0xa
	orr r1, r1, lr, lsl #22
	ldr r3, _027E1718 // =WmspMaMultiPollAckAlarmCallback
	bl OS_SetAlarm
	and r0, r4, #0x2800
	cmp r0, #0x2800
	moveq r1, #1
	movne r1, #0
	and r0, r4, #0x6000
	cmp r0, #0x6000
	moveq r2, #1
	movne r2, #0
	cmp r2, #0
	movne r0, #0
	strneh r0, [r5, #0x8a]
	cmp r1, #0
	movne r0, #1
	moveq r0, #0
	strh r0, [r5, #0x8e]
	cmp r2, #0
	movne r0, #1
	moveq r0, #0
	strh r0, [r5, #0x8c]
	cmp r9, #0
	beq _027E15A0
	ldrh r0, [r8, #0x2c]
	sub r0, r0, #0x66
	mov r1, #4
	bl _s32_div_f
	subs r1, r0, #0x20
	bmi _027E15A0
	ldrh r0, [r5, #0x36]
	cmp r1, r0
	movgt r1, r0
	ldrh r0, [r5, #0x32]
	cmp r1, r0
	beq _027E15A0
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	bl SDK_AUTOLOAD_MAIN_START
_027E15A0:
	mov r0, r11
	bl OS_RestoreInterrupts
	cmp r7, #0
	beq _027E15EC
	cmp r6, #1
	bne _027E15C4
	mov r0, r7
	mov r1, #0
	bl WMSP_FlushSendQueue
_027E15C4:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xe
	strh r1, [r0]
	mov r1, #9
	strh r1, [r0, #2]
	mov r1, #0xd
	strh r1, [r0, #4]
	mov r1, #0
	str r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
_027E15EC:
	cmp r9, #0
	bne _027E1618
	ldrh r0, [r8, #6]
	cmp r0, #2
	blo _027E1700
	ldrh r0, [r8, #0x30]
	ands r0, r0, #0x8000
	movne r0, #1
	moveq r0, #0
	strh r0, [r5, #0x5e]
	b _027E1700
_027E1618:
	add r0, r10, #0x28
	add r1, r8, #0x18
	mov r2, #6
	bl MI_CpuCopy8
	add r0, r10, #0x2e
	add r1, r8, #0x1e
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r0, [r8, #6]
	cmp r0, #2
	blo _027E16A8
	sub r0, r0, #2
	strh r0, [r8, #6]
	ldrh r0, [r8, #0x30]
	ands r0, r0, #0x8000
	movne r0, #1
	moveq r0, #0
	strh r0, [r5, #0x5e]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xe
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #0xc
	strh r1, [r0, #4]
	str r8, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	ldrh r3, [r8, #6]
	cmp r3, #0
	beq _027E16D4
	str r8, [sp]
	mov r0, #0
	ldrh r1, [r8, #0x30]
	add r2, r8, #0x32
	bl WMSP_ParsePortPacket
	b _027E16D4
_027E16A8:
	mov r0, #0
	strh r0, [r8, #6]
	strh r0, [r5, #0x5e]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xe
	strh r1, [r0]
	strh r1, [r0, #2]
	mov r1, #0xc
	strh r1, [r0, #4]
	str r8, [r0, #8]
	bl WMSP_ReturnResult2Wm9
_027E16D4:
	ldr r2, [r5, #0x7b8]
	ldr r1, [r5, #0x7bc]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	beq _027E1700
	bl OS_GetTick
	orr r1, r1, #0
	orr r0, r0, #1
	str r0, [r5, #0x738]
	str r1, [r5, #0x73c]
_027E1700:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E170C: .word 0x027F9454
_027E1710: .word 0x0380BD70
_027E1714: .word 0x000082EA
_027E1718: .word WmspMaMultiPollAckAlarmCallback
	arm_func_end WmspIndicateMaMultiPoll

	arm_func_start WmspSetRssi
WmspSetRssi: // 0x027E171C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r2, _027E1798 // =0x027F9454
	ldr lr, [r2, #0x550]
	ldrh r4, [lr, #0xbe]
	cmp r1, #0
	bne _027E178C
	ldrh r3, [r0, #0x14]
	cmp r3, #1
	blo _027E178C
	mov r5, #0
	add ip, r0, #0x1a
	b _027E1780
_027E1750:
	ldrh r2, [r0, #0x16]
	mla r1, r2, r5, ip
	ldrb r2, [r1, #3]
	ands r1, r2, #2
	movne r1, r2, asr #2
	andne r1, r1, #0xff
	moveq r1, r2, asr #2
	addeq r1, r1, #0x19
	andeq r1, r1, #0xff
	cmp r1, r4
	movlo r4, r1
	add r5, r5, #1
_027E1780:
	cmp r5, r3
	blt _027E1750
	strh r4, [lr, #0xbe]
_027E178C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E1798: .word 0x027F9454
	arm_func_end WmspSetRssi

	arm_func_start WmspKickMPParent
WmspKickMPParent: // 0x027E179C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl WMSP_GetInternalRequestBuf
	movs r1, r0
	ldr r4, _027E1820 // =_027F8454
	moveq r0, #0
	beq _027E17D4
	mov r0, #0x2b
	str r0, [r1]
	str r5, [r1, #4]
	add r0, r4, #0x88
	mov r2, #0
	bl OS_SendMessage
_027E17D4:
	cmp r0, #0
	bne _027E1814
	add r0, r4, #0x1000
	ldr r0, [r0, #0x54c]
	cmp r0, #0
	beq _027E1814
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	mov r1, #0x16
	strh r1, [r0, #4]
	mov r1, #0x2b
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
_027E1814:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E1820: .word _027F8454
	arm_func_end WmspKickMPParent

	arm_func_start WmspMPParentIntervalAlarmCallback
WmspMPParentIntervalAlarmCallback: // 0x027E1824
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr ip, _027E1834 // =WmspKickMPParent
	bx ip
	.align 2, 0
_027E1834: .word WmspKickMPParent
	arm_func_end WmspMPParentIntervalAlarmCallback

	arm_func_start WMSP_RequestResumeMP
WMSP_RequestResumeMP: // 0x027E1838
	stmdb sp!, {r4, lr}
	ldr r0, _027E18B0 // =0x027F9454
	ldr r4, [r0, #0x550]
	bl WMSP_GetInternalRequestBuf
	movs r1, r0
	moveq r0, #0
	beq _027E1870
	mov r0, #0x2d
	str r0, [r1]
	ldrh r0, [r4, #0x68]
	str r0, [r1, #4]
	ldr r0, _027E18B4 // =byte_27F84DC
	mov r2, #0
	bl OS_SendMessage
_027E1870:
	cmp r0, #0
	movne r0, #1
	strneh r0, [r4, #0x66]
	bne _027E18A8
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	mov r1, #0x16
	strh r1, [r0, #4]
	mov r1, #0x2d
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
_027E18A8:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E18B0: .word 0x027F9454
_027E18B4: .word byte_27F84DC
	arm_func_end WMSP_RequestResumeMP

	arm_func_start WmspIndicateMaMultiPollEnd
WmspIndicateMaMultiPollEnd: // 0x027E18B8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	mov r10, r0
	ldr r0, _027E1C08 // =0x027F9454
	ldr r8, [r0, #0x550]
	mov r5, #0
	ldr r0, [r8, #0xc]
	cmp r0, #0
	beq _027E1BFC
	ldrh r0, [r10, #0x12]
	cmp r0, #0
	bne _027E1900
	ldrh r1, [r8, #0x66]
	cmp r1, #1
	bne _027E1908
	ldrh r0, [r10, #0x10]
	cmp r0, #0
	beq _027E1908
_027E1900:
	bl WMSP_RequestResumeMP
	b _027E1BFC
_027E1908:
	cmp r1, #0
	movne r0, #0
	strneh r0, [r8, #0x66]
	ldrh r0, [r8, #0x70]
	add r0, r8, r0, lsl #2
	ldr r7, [r0, #0x74]
	ldrh r1, [r10, #0x16]
	ldrh r0, [r10, #0x14]
	mul r0, r1, r0
	add r2, r0, #0xa
	ldrh r0, [r8, #0x72]
	cmp r0, r2
	movlo r2, r0
	add r0, r10, #0x10
	mov r1, r7
	bl MI_CpuCopy8
	mov r0, r10
	ldrh r1, [r7, #0]
	ldrh r2, [r8, #0x92]
	bl WmspSetRssi
	bl OS_GetTick
	mov r9, #0
	mov r2, #1
	str r2, [sp, #0x10]
	orr r1, r1, #0
	str r1, [sp, #8]
	orr r0, r0, #1
	str r0, [sp, #4]
	add r6, r7, #0xa
	ldrh r11, [r7, #0]
	str r9, [sp, #0x14]
	mov r0, #0x25
	str r0, [sp, #0x18]
	mov r0, #0x80
	str r0, [sp, #0x1c]
	mov r0, #8
	str r0, [sp, #0x20]
	mov r0, #0x16
	str r0, [sp, #0x24]
	b _027E1B10
_027E19A8:
	ldrh r4, [r6, #4]
	ldrh r1, [r6, #0]
	cmp r4, #1
	blo _027E1AFC
	cmp r4, #0xf
	bhi _027E1AFC
	cmp r1, #2
	blo _027E1A24
	ldr r0, _027E1C0C // =0x0000FFFF
	cmp r1, r0
	beq _027E1A24
	sub r0, r1, #2
	strh r0, [r6]
	ldrh r2, [r8, #0x86]
	ldr r1, [sp, #0x10]
	orr r1, r2, r1, lsl r4
	strh r1, [r8, #0x86]
	add r2, r8, r4, lsl #3
	ldr r1, [sp, #4]
	str r1, [r2, #0x738]
	ldr r1, [sp, #8]
	str r1, [r2, #0x73c]
	mov r0, r0, lsl #0x10
	movs r3, r0, lsr #0x10
	beq _027E1AFC
	str r7, [sp]
	mov r0, r4
	ldrh r1, [r6, #8]
	add r2, r6, #0xa
	bl WMSP_ParsePortPacket
	b _027E1AFC
_027E1A24:
	cmp r1, #0
	bne _027E1AFC
	add r1, r8, r4, lsl #3
	ldr r0, [r1, #0x738]
	ldr r3, [r1, #0x73c]
	ldr r1, [sp, #0x10]
	mov r1, r1, lsl r4
	str r1, [sp, #0xc]
	ldr r1, [sp, #0x10]
	orr r11, r11, r1, lsl r4
	ldr r2, [r8, #0x7b8]
	ldr r1, [r8, #0x7bc]
	mov ip, #0
	cmp r1, ip
	cmpeq r2, ip
	beq _027E1AFC
	cmp r3, ip
	cmpeq r0, ip
	beq _027E1AFC
	ldr ip, [sp, #4]
	subs r0, ip, r0
	ldr ip, [sp, #8]
	sbc r3, ip, r3
	cmp r3, r1
	cmpeq r0, r2
	bls _027E1AFC
	bl WMSP_GetInternalRequestBuf
	movs r1, r0
	add r2, r8, r4, lsl #3
	ldr r0, [sp, #0x14]
	str r0, [r2, #0x738]
	str r0, [r2, #0x73c]
	beq _027E1ACC
	ldr r0, [sp, #0x18]
	str r0, [r1]
	ldr r0, [sp, #0xc]
	str r0, [r1, #4]
	ldr r0, _027E1C10 // =0x00008001
	str r0, [r1, #8]
	ldr r0, _027E1C14 // =byte_27F84DC
	ldr r2, [sp, #0x14]
	bl OS_SendMessage
_027E1ACC:
	cmp r0, #0
	bne _027E1AFC
	bl WMSP_GetBuffer4Callback2Wm9
	ldr r1, [sp, #0x1c]
	strh r1, [r0]
	ldr r1, [sp, #0x20]
	strh r1, [r0, #2]
	ldr r1, [sp, #0x24]
	strh r1, [r0, #4]
	ldr r1, [sp, #0x18]
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
_027E1AFC:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	ldrh r0, [r7, #6]
	add r6, r6, r0
_027E1B10:
	ldrh r0, [r7, #4]
	cmp r9, r0
	blo _027E19A8
	mov r0, #0
	mov r1, r11, lsl #0x10
	mov r1, r1, lsr #0x10
	bl WMSP_FlushSendQueue
	ldrh r0, [r7, #0]
	cmp r0, #0
	movne r5, #1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xe
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #0xb
	strh r1, [r0, #4]
	str r7, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	ldrh r0, [r8, #0x70]
	eor r0, r0, #1
	strh r0, [r8, #0x70]
	bl OS_DisableInterrupts
	cmp r5, #0
	ldreqsh r1, [r8, #0x62]
	subeq r1, r1, #1
	streqh r1, [r8, #0x62]
	ldrsh r1, [r8, #0x64]
	cmp r1, #0
	subgt r1, r1, #1
	strgth r1, [r8, #0x64]
	ldrsh r1, [r8, #0x62]
	cmp r1, #0
	ble _027E1BA8
	ldrsh r1, [r8, #0x64]
	cmp r1, #0
	movgt r4, #1
	bgt _027E1BAC
_027E1BA8:
	mov r4, #0
_027E1BAC:
	bl OS_RestoreInterrupts
	cmp r4, #0
	beq _027E1BFC
	cmp r5, #1
	ldreqh r4, [r10, #0x10]
	ldrne r4, _027E1C0C // =0x0000FFFF
	ldrh r0, [r8, #0x44]
	cmp r0, #0
	beq _027E1BF4
	ldr r0, _027E1C18 // =0x0380BD9C
	bl OS_CancelAlarm
	str r4, [sp]
	ldr r0, _027E1C18 // =0x0380BD9C
	ldr r1, [r8, #0x48]
	ldr r2, [r8, #0x4c]
	ldr r3, _027E1C1C // =WmspMPParentIntervalAlarmCallback
	bl OS_SetAlarm
	b _027E1BFC
_027E1BF4:
	mov r0, r4
	bl WmspKickMPParent
_027E1BFC:
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E1C08: .word 0x027F9454
_027E1C0C: .word 0x0000FFFF
_027E1C10: .word 0x00008001
_027E1C14: .word byte_27F84DC
_027E1C18: .word 0x0380BD9C
_027E1C1C: .word WmspMPParentIntervalAlarmCallback
	arm_func_end WmspIndicateMaMultiPollEnd

	arm_func_start WmspIndicateMlmeBeaconLost
WmspIndicateMlmeBeaconLost: // 0x027E1C20
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027E1C68 // =0x027F9454
	ldr r0, [r0, #0x550]
	ldrh r0, [r0, #0xc2]
	cmp r0, #0
	beq _027E1C5C
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xc
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #8
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
_027E1C5C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E1C68: .word 0x027F9454
	arm_func_end WmspIndicateMlmeBeaconLost

	arm_func_start WmspIndicateMlmeBeaconRecv
WmspIndicateMlmeBeaconRecv: // 0x027E1C6C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r0, _027E1DC0 // =0x027F9454
	ldr r4, [r0, #0x550]
	add r6, r7, #0x3c
	ldrb r1, [r7, #0x1f]
	ands r0, r1, #2
	movne r0, r1, asr #2
	andne r2, r0, #0xff
	moveq r0, r1, asr #2
	addeq r0, r0, #0x19
	andeq r2, r0, #0xff
	ldr r1, _027E1DC4 // =0x027FFF98
	ldrh r0, [r1, #0]
	eor r0, r2, r0, lsl #1
	eor r0, r0, r0, lsr #16
	strh r0, [r1]
	ldrh r0, [r4, #0]
	cmp r0, #8
	beq _027E1CC8
	cmp r0, #0xa
	bne _027E1DB4
_027E1CC8:
	ldrh r1, [r4, #0xba]
	ldrh r0, [r6, #8]
	cmp r1, r0
	beq _027E1D40
	bl WMSP_GetInternalRequestBuf
	movs r1, r0
	moveq r0, #0
	beq _027E1D0C
	mov r0, #0x25
	str r0, [r1]
	mov r0, #1
	str r0, [r1, #4]
	ldr r0, _027E1DC8 // =0x00008002
	str r0, [r1, #8]
	ldr r0, _027E1DCC // =byte_27F84DC
	mov r2, #0
	bl OS_SendMessage
_027E1D0C:
	cmp r0, #0
	bne _027E1DB4
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	mov r1, #0x16
	strh r1, [r0, #4]
	mov r1, #0x25
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	b _027E1DB4
_027E1D40:
	ldr r0, _027E1DC0 // =0x027F9454
	ldr r0, [r0, #0x550]
	ldrh r0, [r0, #0xc2]
	cmp r0, #0
	beq _027E1DB4
	bl WMSP_GetBuffer4Callback2Wm9
	mov r5, r0
	mov r0, #0x80
	strh r0, [r5]
	mov r0, #0
	strh r0, [r5, #2]
	mov r0, #0x10
	strh r0, [r5, #4]
	ldrh r0, [r6, #8]
	strh r0, [r5, #6]
	ldrh r0, [r4, #0]
	strh r0, [r5, #8]
	ldrh r0, [r7, #0x16]
	strh r0, [r5, #0xa]
	ldrh r2, [r5, #0xa]
	cmp r2, #0x80
	bhi _027E1DAC
	mov r0, r6
	add r1, r5, #0xc
	add r2, r2, #1
	bic r2, r2, #1
	bl MIi_CpuCopy16
_027E1DAC:
	mov r0, r5
	bl WMSP_ReturnResult2Wm9
_027E1DB4:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027E1DC0: .word 0x027F9454
_027E1DC4: .word 0x027FFF98
_027E1DC8: .word 0x00008002
_027E1DCC: .word byte_27F84DC
	arm_func_end WmspIndicateMlmeBeaconRecv

	arm_func_start WmspIndicateMlmeBeaconSend
WmspIndicateMlmeBeaconSend: // 0x027E1DD0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027E1E18 // =0x027F9454
	ldr r0, [r0, #0x550]
	ldrh r0, [r0, #0xc2]
	cmp r0, #0
	beq _027E1E0C
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #8
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #2
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
_027E1E0C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E1E18: .word 0x027F9454
	arm_func_end WmspIndicateMlmeBeaconSend

	arm_func_start WmspIndicateFuncDummy
WmspIndicateFuncDummy: // 0x027E1E1C
	bx lr
	arm_func_end WmspIndicateFuncDummy

	arm_func_start WmspFreeBufOfWL
WmspFreeBufOfWL: // 0x027E1E20
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r1, _027E1E5C // =0x027F9454
	ldr r0, [r1, #0x544]
	ldr r1, [r1, #0x548]
	mov r2, r5
	bl OS_FreeToHeap
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E1E5C: .word 0x027F9454
	arm_func_end WmspFreeBufOfWL

	arm_func_start WmspIndicate
WmspIndicate: // 0x027E1E60
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, _027E1F9C // =0x027F9454
	ldr r2, [r1, #0x54c]
	cmp r2, #0
	beq _027E1F94
	ldr r1, [r1, #0x550]
	ldrh r1, [r1, #0]
	cmp r1, #1
	beq _027E1F94
	ldrh r2, [r4, #0xc]
	ldr r1, _027E1FA0 // =0x00000182
	cmp r2, r1
	bgt _027E1EE8
	cmp r2, r1
	bge _027E1F64
	cmp r2, #0x8d
	bgt _027E1EDC
	subs r1, r2, #0x84
	addpl pc, pc, r1, lsl #2
	b _027E1F84
_027E1EB4: // jump table
	b _027E1F18 // case 0
	b _027E1F20 // case 1
	b _027E1F28 // case 2
	b _027E1F30 // case 3
	b _027E1F38 // case 4
	b _027E1F84 // case 5
	b _027E1F84 // case 6
	b _027E1F40 // case 7
	b _027E1F48 // case 8
	b _027E1F50 // case 9
_027E1EDC:
	cmp r2, #0x180
	beq _027E1F58
	b _027E1F84
_027E1EE8:
	ldr r1, _027E1FA4 // =0x00000185
	cmp r2, r1
	bgt _027E1F08
	cmp r2, r1
	bge _027E1F74
	cmp r2, #0x184
	beq _027E1F6C
	b _027E1F84
_027E1F08:
	ldr r1, _027E1FA8 // =0x00000186
	cmp r2, r1
	beq _027E1F7C
	b _027E1F84
_027E1F18:
	bl WmspIndicateMlmeAuthenticate
	b _027E1F8C
_027E1F20:
	bl WmspIndicateMlmeDeAuthenticate
	b _027E1F8C
_027E1F28:
	bl WmspIndicateMlmeAssociate
	b _027E1F8C
_027E1F30:
	bl WmspIndicateMlmeReAssociate
	b _027E1F8C
_027E1F38:
	bl WmspIndicateMlmeDisAssociate
	b _027E1F8C
_027E1F40:
	bl WmspIndicateMlmeBeaconLost
	b _027E1F8C
_027E1F48:
	bl WmspIndicateMlmeBeaconSend
	b _027E1F8C
_027E1F50:
	bl WmspIndicateMlmeBeaconRecv
	b _027E1F8C
_027E1F58:
	mov r0, r4
	bl WmspIndicateMaData
	b _027E1F8C
_027E1F64:
	bl WmspIndicateMaMultiPoll
	b _027E1F8C
_027E1F6C:
	bl WmspIndicateMaMultiPollEnd
	b _027E1F8C
_027E1F74:
	bl WmspIndicateMaMultiPollAck
	b _027E1F8C
_027E1F7C:
	bl WmspIndicateMaFatalErr
	b _027E1F8C
_027E1F84:
	mov r0, r4
	bl WmspIndicateFuncDummy
_027E1F8C:
	mov r0, r4
	bl WmspFreeBufOfWL
_027E1F94:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E1F9C: .word 0x027F9454
_027E1FA0: .word 0x00000182
_027E1FA4: .word 0x00000185
_027E1FA8: .word 0x00000186
	arm_func_end WmspIndicate

	arm_func_start WMSP_IndicateThread
WMSP_IndicateThread: // 0x027E1FAC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r0, _027E2044 // =_027F8454
	add r7, r0, #0x58
	mov r4, #1
	add r6, r0, #0x28
	add r5, sp, #0
_027E1FC8:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl OS_ReceiveMessage
	ldr r1, [sp]
	cmp r1, #0
	bne _027E1FEC
	bl OS_ExitThread
	b _027E2038
_027E1FEC:
	ldrh r2, [r1, #0xc]
	and r0, r2, #0xff
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	and r0, r2, #0xff00
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	beq _027E2014
	cmp r0, #0x100
	bne _027E2028
_027E2014:
	ands r0, r3, #0x80
	beq _027E2028
	mov r0, r1
	bl WmspIndicate
	b _027E1FC8
_027E2028:
	mov r0, r7
	mov r2, r4
	bl OS_SendMessage
	b _027E1FC8
_027E2038:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027E2044: .word _027F8454
	arm_func_end WMSP_IndicateThread

	arm_func_start WmspRequestFuncDummy
WmspRequestFuncDummy: // 0x027E2048
	bx lr
	arm_func_end WmspRequestFuncDummy

	arm_func_start WMSP_RequestThread
WMSP_RequestThread: // 0x027E204C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	ldr r1, _027E20EC // =_027F8454
	ldr r0, _027E20F0 // =0x027F9454
	ldr r10, [r0, #0x550]
	mov r6, #1
	ldr r5, _027E20F4 // =WmspRequestFuncTable
	mov r4, #0
	add r8, r1, #0x88
	add r7, sp, #0
_027E2074:
	mov r0, r8
	mov r1, r7
	mov r2, r6
	bl OS_ReceiveMessage
	ldr r0, [sp]
	cmp r0, #0
	bne _027E2098
	bl OS_ExitThread
	b _027E20E0
_027E2098:
	ldrh r9, [r0, #0]
	ands r0, r9, #0x8000
	bicne r0, r9, #0x8000
	movne r0, r0, lsl #0x10
	movne r9, r0, lsr #0x10
	cmp r9, #0x2e
	bhs _027E20D0
	str r6, [r10, #4]
	strh r9, [r10, #2]
	ldr r0, [sp]
	ldr r1, [r5, r9, lsl #2]
	mov lr, pc
	bx r1
_27E20CC: // 0x027E20CC
	str r4, [r10, #4]
_027E20D0:
	orr r1, r9, #0x8000
	ldr r0, [sp]
	strh r1, [r0]
	b _027E2074
_027E20E0:
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_027E20EC: .word _027F8454
_027E20F0: .word 0x027F9454
_027E20F4: .word WmspRequestFuncTable
	arm_func_end WMSP_RequestThread

	arm_func_start WMSPi_WL_NoArg
WMSPi_WL_NoArg: // 0x027E20F8
	stmdb sp!, {r4, lr}
	mov r3, #0
	strh r3, [r0]
	strh r3, [r0, #2]
	strh r3, [r0, #4]
	strh r3, [r0, #6]
	strh r3, [r0, #8]
	strh r3, [r0, #0xa]
	strh r1, [r0, #0xc]
	strh r3, [r0, #0xe]
	ldrh r1, [r0, #0xe]
	add r3, r0, r1, lsl #1
	add r4, r3, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r3, #0x10]
	strh r2, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WMSPi_WL_NoArg

	arm_func_start WMSP_WL_DevTestSignal
WMSP_WL_DevTestSignal: // 0x027E2148
	stmdb sp!, {r4, lr}
	mov ip, #0
	strh ip, [r0]
	strh ip, [r0, #2]
	strh ip, [r0, #4]
	strh ip, [r0, #6]
	strh ip, [r0, #8]
	strh ip, [r0, #0xa]
	ldr ip, _027E21B8 // =0x00000309
	strh ip, [r0, #0xc]
	mov ip, #4
	strh ip, [r0, #0xe]
	strh r1, [r0, #0x10]
	strh r2, [r0, #0x12]
	strh r3, [r0, #0x14]
	ldrh r1, [sp, #8]
	strh r1, [r0, #0x16]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	mov r1, #1
	strh r1, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E21B8: .word 0x00000309
	arm_func_end WMSP_WL_DevTestSignal

	arm_func_start WMSP_WL_DevGetStationState
WMSP_WL_DevGetStationState: // 0x027E21BC
	mov r1, #0x308
	mov r2, #2
	ldr ip, _027E21CC // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E21CC: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_DevGetStationState

	arm_func_start WMSP_WL_DevGetWirelessCounter
WMSP_WL_DevGetWirelessCounter: // 0x027E21D0
	ldr r1, _027E21E0 // =0x00000307
	mov r2, #0x5c
	ldr ip, _027E21E4 // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E21E0: .word 0x00000307
_027E21E4: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_DevGetWirelessCounter

	arm_func_start WMSP_WL_DevGetVersion
WMSP_WL_DevGetVersion: // 0x027E21E8
	ldr r1, _027E21F8 // =0x00000306
	mov r2, #9
	ldr ip, _027E21FC // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E21F8: .word 0x00000306
_027E21FC: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_DevGetVersion

	arm_func_start WMSP_WL_DevSetInitializeWirelessCounter
WMSP_WL_DevSetInitializeWirelessCounter: // 0x027E2200
	ldr r1, _027E2210 // =0x00000305
	mov r2, #1
	ldr ip, _027E2214 // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E2210: .word 0x00000305
_027E2214: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_DevSetInitializeWirelessCounter

	arm_func_start WMSP_WL_DevRestart
WMSP_WL_DevRestart: // 0x027E2218
	mov r1, #0x304
	mov r2, #1
	ldr ip, _027E2228 // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E2228: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_DevRestart

	arm_func_start WMSP_WL_DevClass1
WMSP_WL_DevClass1: // 0x027E222C
	ldr r1, _027E223C // =0x00000303
	mov r2, #1
	ldr ip, _027E2240 // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E223C: .word 0x00000303
_027E2240: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_DevClass1

	arm_func_start WMSP_WL_DevIdle
WMSP_WL_DevIdle: // 0x027E2244
	ldr r1, _027E2254 // =0x00000302
	mov r2, #1
	ldr ip, _027E2258 // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E2254: .word 0x00000302
_027E2258: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_DevIdle

	arm_func_start WMSP_WL_DevShutdown
WMSP_WL_DevShutdown: // 0x027E225C
	ldr r1, _027E226C // =0x00000301
	mov r2, #1
	ldr ip, _027E2270 // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E226C: .word 0x00000301
_027E2270: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_DevShutdown

	arm_func_start WMSP_WL_ParamGetMode
WMSP_WL_ParamGetMode: // 0x027E2274
	mov r1, #0x284
	mov r2, #2
	ldr ip, _027E2284 // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E2284: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_ParamGetMode

	arm_func_start WMSP_WL_ParamGetEnableChannel
WMSP_WL_ParamGetEnableChannel: // 0x027E2288
	ldr r1, _027E2298 // =0x00000283
	mov r2, #3
	ldr ip, _027E229C // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E2298: .word 0x00000283
_027E229C: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_ParamGetEnableChannel

	arm_func_start WMSP_WL_ParamGetMacAddress
WMSP_WL_ParamGetMacAddress: // 0x027E22A0
	ldr r1, _027E22B0 // =0x00000281
	mov r2, #4
	ldr ip, _027E22B4 // =WMSPi_WL_NoArg
	bx ip
	.align 2, 0
_027E22B0: .word 0x00000281
_027E22B4: .word WMSPi_WL_NoArg
	arm_func_end WMSP_WL_ParamGetMacAddress

	arm_func_start WMSP_WL_ParamSetGameInfo
WMSP_WL_ParamSetGameInfo: // 0x027E22B8
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r6, r1
	mov r5, r2
	mov r0, #0
	strh r0, [r4]
	strh r0, [r4, #2]
	strh r0, [r4, #4]
	strh r0, [r4, #6]
	strh r0, [r4, #8]
	strh r0, [r4, #0xa]
	ldr r0, _027E2344 // =0x00000245
	strh r0, [r4, #0xc]
	add r0, r6, #1
	mov r1, #2
	bl _s32_div_f
	add r0, r0, #1
	strh r0, [r4, #0xe]
	strh r6, [r4, #0x10]
	mov r0, r5
	add r1, r4, #0x12
	mov r2, r6
	bl MIi_CpuCopy16
	ldrh r0, [r4, #0xe]
	add r1, r4, r0, lsl #1
	add r5, r1, #0x10
	ldrh r0, [r4, #0xc]
	strh r0, [r1, #0x10]
	mov r0, #1
	strh r0, [r5, #2]
	mov r0, r4
	bl WMSP_WlRequest
	mov r0, r5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027E2344: .word 0x00000245
	arm_func_end WMSP_WL_ParamSetGameInfo

	arm_func_start WMSP_WL_ParamSetBeaconPeriod
WMSP_WL_ParamSetBeaconPeriod: // 0x027E2348
	stmdb sp!, {r4, lr}
	mov r2, #0
	strh r2, [r0]
	strh r2, [r0, #2]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	ldr r2, _027E23A4 // =0x00000242
	strh r2, [r0, #0xc]
	mov r3, #1
	strh r3, [r0, #0xe]
	strh r1, [r0, #0x10]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	strh r3, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E23A4: .word 0x00000242
	arm_func_end WMSP_WL_ParamSetBeaconPeriod

	arm_func_start WMSP_WL_ParamSetNullKeyResponseMode
WMSP_WL_ParamSetNullKeyResponseMode: // 0x027E23A8
	stmdb sp!, {r4, lr}
	mov r2, #0
	strh r2, [r0]
	strh r2, [r0, #2]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	ldr r2, _027E2404 // =0x00000216
	strh r2, [r0, #0xc]
	mov r3, #1
	strh r3, [r0, #0xe]
	strh r1, [r0, #0x10]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	strh r3, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E2404: .word 0x00000216
	arm_func_end WMSP_WL_ParamSetNullKeyResponseMode

	arm_func_start WMSP_WL_ParamSetBeaconSendRecvInd
WMSP_WL_ParamSetBeaconSendRecvInd: // 0x027E2408
	stmdb sp!, {r4, lr}
	mov r2, #0
	strh r2, [r0]
	strh r2, [r0, #2]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	ldr r2, _027E2464 // =0x00000215
	strh r2, [r0, #0xc]
	mov r3, #1
	strh r3, [r0, #0xe]
	strh r1, [r0, #0x10]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	strh r3, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E2464: .word 0x00000215
	arm_func_end WMSP_WL_ParamSetBeaconSendRecvInd

	arm_func_start WMSP_WL_ParamSetMaxConnectableChild
WMSP_WL_ParamSetMaxConnectableChild: // 0x027E2468
	stmdb sp!, {r4, lr}
	mov r2, #0
	strh r2, [r0]
	strh r2, [r0, #2]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	ldr r2, _027E24C4 // =0x00000212
	strh r2, [r0, #0xc]
	mov r3, #1
	strh r3, [r0, #0xe]
	strh r1, [r0, #0x10]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	strh r3, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E24C4: .word 0x00000212
	arm_func_end WMSP_WL_ParamSetMaxConnectableChild

	arm_func_start WMSP_WL_ParamSetLifeTime
WMSP_WL_ParamSetLifeTime: // 0x027E24C8
	stmdb sp!, {r4, lr}
	mov ip, #0
	strh ip, [r0]
	strh ip, [r0, #2]
	strh ip, [r0, #4]
	strh ip, [r0, #6]
	strh ip, [r0, #8]
	strh ip, [r0, #0xa]
	ldr ip, _027E2530 // =0x00000211
	strh ip, [r0, #0xc]
	mov ip, #3
	strh ip, [r0, #0xe]
	strh r1, [r0, #0x10]
	strh r2, [r0, #0x12]
	strh r3, [r0, #0x14]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	mov r1, #1
	strh r1, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E2530: .word 0x00000211
	arm_func_end WMSP_WL_ParamSetLifeTime

	arm_func_start WMSP_WL_ParamSetPreambleType
WMSP_WL_ParamSetPreambleType: // 0x027E2534
	stmdb sp!, {r4, lr}
	mov r2, #0
	strh r2, [r0]
	strh r2, [r0, #2]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	ldr r2, _027E2590 // =0x0000020E
	strh r2, [r0, #0xc]
	mov r3, #1
	strh r3, [r0, #0xe]
	strh r1, [r0, #0x10]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	strh r3, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E2590: .word 0x0000020E
	arm_func_end WMSP_WL_ParamSetPreambleType

	arm_func_start WMSP_WL_ParamSetSsidMask
WMSP_WL_ParamSetSsidMask: // 0x027E2594
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r0, #0
	strh r0, [r4]
	strh r0, [r4, #2]
	strh r0, [r4, #4]
	strh r0, [r4, #6]
	strh r0, [r4, #8]
	strh r0, [r4, #0xa]
	ldr r0, _027E2610 // =0x0000020D
	strh r0, [r4, #0xc]
	mov r0, #0x10
	strh r0, [r4, #0xe]
	mov r0, r1
	add r1, r4, #0x10
	mov r2, #0x20
	bl MIi_CpuCopy16
	ldrh r0, [r4, #0xe]
	add r1, r4, r0, lsl #1
	add r5, r1, #0x10
	ldrh r0, [r4, #0xc]
	strh r0, [r1, #0x10]
	mov r0, #1
	strh r0, [r5, #2]
	mov r0, r4
	bl WMSP_WlRequest
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E2610: .word 0x0000020D
	arm_func_end WMSP_WL_ParamSetSsidMask

	arm_func_start WMSP_WL_ParamSetBeaconLostThreshold
WMSP_WL_ParamSetBeaconLostThreshold: // 0x027E2614
	stmdb sp!, {r4, lr}
	mov r2, #0
	strh r2, [r0]
	strh r2, [r0, #2]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	ldr r2, _027E2670 // =0x0000020B
	strh r2, [r0, #0xc]
	mov r3, #1
	strh r3, [r0, #0xe]
	strh r1, [r0, #0x10]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	strh r3, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E2670: .word 0x0000020B
	arm_func_end WMSP_WL_ParamSetBeaconLostThreshold

	arm_func_start WMSP_WL_ParamSetWepKeyId
WMSP_WL_ParamSetWepKeyId: // 0x027E2674
	stmdb sp!, {r4, lr}
	mov r2, #0
	strh r2, [r0]
	strh r2, [r0, #2]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	ldr r2, _027E26D0 // =0x00000207
	strh r2, [r0, #0xc]
	mov r3, #1
	strh r3, [r0, #0xe]
	strh r1, [r0, #0x10]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	strh r3, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E26D0: .word 0x00000207
	arm_func_end WMSP_WL_ParamSetWepKeyId

	arm_func_start WMSP_WL_ParamSetAll
WMSP_WL_ParamSetAll: // 0x027E26D4
	stmdb sp!, {r4, lr}
	mov r1, #0
	strh r1, [r0]
	strh r1, [r0, #2]
	strh r1, [r0, #4]
	strh r1, [r0, #6]
	strh r1, [r0, #8]
	strh r1, [r0, #0xa]
	mov r1, #0x200
	strh r1, [r0, #0xc]
	mov r1, #0x48
	strh r1, [r0, #0xe]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	mov r1, #1
	strh r1, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WMSP_WL_ParamSetAll

	arm_func_start WMSP_WL_MaClearData
WMSP_WL_MaClearData: // 0x027E2730
	stmdb sp!, {r4, lr}
	mov r2, #0
	strh r2, [r0]
	strh r2, [r0, #2]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	mov r2, #0x104
	strh r2, [r0, #0xc]
	mov r3, #1
	strh r3, [r0, #0xe]
	strh r1, [r0, #0x10]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	strh r3, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WMSP_WL_MaClearData

	arm_func_start WMSP_WL_MaMp
WMSP_WL_MaMp: // 0x027E278C
	stmdb sp!, {r4, lr}
	mov ip, #0
	strh ip, [r0]
	strh ip, [r0, #2]
	strh ip, [r0, #4]
	strh ip, [r0, #6]
	strh ip, [r0, #8]
	strh ip, [r0, #0xa]
	ldr ip, _027E2824 // =0x00000102
	strh ip, [r0, #0xc]
	mov ip, #0xa
	strh ip, [r0, #0xe]
	strh r1, [r0, #0x10]
	strh r2, [r0, #0x12]
	strh r3, [r0, #0x14]
	ldrh r1, [sp, #8]
	strh r1, [r0, #0x16]
	ldrh r1, [sp, #0xc]
	strh r1, [r0, #0x18]
	ldrh r1, [sp, #0x10]
	strh r1, [r0, #0x1a]
	ldrh r1, [sp, #0x14]
	strh r1, [r0, #0x1c]
	ldrh r1, [sp, #0x18]
	strh r1, [r0, #0x1e]
	ldr r1, [sp, #0x1c]
	str r1, [r0, #0x20]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	mov r1, #1
	strh r1, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E2824: .word 0x00000102
	arm_func_end WMSP_WL_MaMp

	arm_func_start WMSP_WL_MaKeyData
WMSP_WL_MaKeyData: // 0x027E2828
	stmdb sp!, {r4, lr}
	mov ip, #0
	strh ip, [r0]
	strh ip, [r0, #2]
	strh ip, [r0, #4]
	strh ip, [r0, #6]
	strh ip, [r0, #8]
	strh ip, [r0, #0xa]
	ldr ip, _027E2890 // =0x00000101
	strh ip, [r0, #0xc]
	mov ip, #4
	strh ip, [r0, #0xe]
	strh r1, [r0, #0x10]
	strh r2, [r0, #0x12]
	str r3, [r0, #0x14]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	mov r1, #1
	strh r1, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E2890: .word 0x00000101
	arm_func_end WMSP_WL_MaKeyData

	arm_func_start WMSP_WL_MaData
WMSP_WL_MaData: // 0x027E2894
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r5, r1
	mov r0, #0
	strh r0, [r4]
	strh r0, [r4, #2]
	strh r0, [r4, #4]
	strh r0, [r4, #6]
	strh r0, [r4, #8]
	strh r0, [r4, #0xa]
	mov r0, #0x100
	strh r0, [r4, #0xc]
	mov r0, #0x18
	strh r0, [r4, #0xe]
	mov r0, r5
	add r1, r4, #0x10
	mov r2, #0x30
	bl MIi_CpuCopy16
	mov r0, #0
	strh r0, [r5, #2]
	strh r0, [r5, #4]
	strh r0, [r5, #8]
	strh r0, [r5, #0xa]
	strh r0, [r5, #0xc]
	strh r0, [r5, #0x10]
	strh r0, [r5, #0x12]
	strh r0, [r5, #0x14]
	strh r0, [r5, #0x16]
	strh r0, [r5, #0x24]
	strh r0, [r5, #0x26]
	strh r0, [r5, #0x28]
	strh r0, [r5, #0x2a]
	ldrh r0, [r4, #0xe]
	add r1, r4, r0, lsl #1
	add r5, r1, #0x10
	ldrh r0, [r4, #0xc]
	strh r0, [r1, #0x10]
	mov r0, #2
	strh r0, [r5, #2]
	mov r0, r4
	bl WMSP_WlRequest
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WMSP_WL_MaData

	arm_func_start WMSP_WL_MlmeMeasureChannel
WMSP_WL_MlmeMeasureChannel: // 0x027E294C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov ip, #0
	strh ip, [r4]
	strh ip, [r4, #2]
	strh ip, [r4, #4]
	strh ip, [r4, #6]
	strh ip, [r4, #8]
	strh ip, [r4, #0xa]
	mov r0, #0xa
	strh r0, [r4, #0xc]
	mov r0, #0xc
	strh r0, [r4, #0xe]
	strh ip, [r4, #0x10]
	strh r1, [r4, #0x12]
	strh r2, [r4, #0x14]
	strh r3, [r4, #0x16]
	ldr r0, [sp, #0x10]
	add r1, r4, #0x18
	mov r2, #0x10
	bl MIi_CpuCopy16
	ldrh r0, [r4, #0xe]
	add r1, r4, r0, lsl #1
	add r5, r1, #0x10
	ldrh r0, [r4, #0xc]
	strh r0, [r1, #0x10]
	mov r0, #0x12
	strh r0, [r5, #2]
	mov r0, r4
	bl WMSP_WlRequest
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WMSP_WL_MlmeMeasureChannel

	arm_func_start WMSP_WL_MlmeStart
WMSP_WL_MlmeStart: // 0x027E29D8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	mov r0, #0
	strh r0, [r7]
	strh r0, [r7, #2]
	strh r0, [r7, #4]
	strh r0, [r7, #6]
	strh r0, [r7, #8]
	strh r0, [r7, #0xa]
	mov r0, #9
	strh r0, [r7, #0xc]
	ldrh r0, [sp, #0x28]
	add r0, r0, #1
	mov r1, #2
	bl _s32_div_f
	add r0, r0, #0x17
	strh r0, [r7, #0xe]
	strh r6, [r7, #0x10]
	mov r0, r5
	add r1, r7, #0x12
	mov r2, #0x20
	bl MIi_CpuCopy16
	strh r4, [r7, #0x32]
	ldrh r0, [sp, #0x18]
	strh r0, [r7, #0x34]
	ldrh r0, [sp, #0x1c]
	strh r0, [r7, #0x36]
	ldrh r0, [sp, #0x20]
	strh r0, [r7, #0x38]
	ldrh r0, [sp, #0x24]
	strh r0, [r7, #0x3a]
	ldrh r2, [sp, #0x28]
	strh r2, [r7, #0x3c]
	ldr r0, [sp, #0x2c]
	add r1, r7, #0x3e
	bl MIi_CpuCopy16
	ldrh r0, [r7, #0xe]
	add r1, r7, r0, lsl #1
	add r4, r1, #0x10
	ldrh r0, [r7, #0xc]
	strh r0, [r1, #0x10]
	mov r0, #1
	strh r0, [r4, #2]
	mov r0, r7
	bl WMSP_WlRequest
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WMSP_WL_MlmeStart

	arm_func_start WMSP_WL_MlmeAssociate
WMSP_WL_MlmeAssociate: // 0x027E2AAC
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r6, r2
	mov r5, r3
	mov r0, #0
	strh r0, [r4]
	strh r0, [r4, #2]
	strh r0, [r4, #4]
	strh r0, [r4, #6]
	strh r0, [r4, #8]
	strh r0, [r4, #0xa]
	mov r2, #6
	strh r2, [r4, #0xc]
	mov r0, #5
	strh r0, [r4, #0xe]
	mov r0, r1
	add r1, r4, #0x10
	bl MIi_CpuCopy16
	strh r6, [r4, #0x16]
	strh r5, [r4, #0x18]
	ldrh r0, [r4, #0xe]
	add r1, r4, r0, lsl #1
	add r5, r1, #0x10
	ldrh r0, [r4, #0xc]
	strh r0, [r1, #0x10]
	mov r0, #3
	strh r0, [r5, #2]
	mov r0, r4
	bl WMSP_WlRequest
	mov r0, r5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WMSP_WL_MlmeAssociate

	arm_func_start WMSP_WL_MlmeDeAuthenticate
WMSP_WL_MlmeDeAuthenticate: // 0x027E2B2C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r5, r2
	mov r0, #0
	strh r0, [r4]
	strh r0, [r4, #2]
	strh r0, [r4, #4]
	strh r0, [r4, #6]
	strh r0, [r4, #8]
	strh r0, [r4, #0xa]
	mov r0, #5
	strh r0, [r4, #0xc]
	mov r0, #4
	strh r0, [r4, #0xe]
	mov r0, r1
	add r1, r4, #0x10
	mov r2, #6
	bl MIi_CpuCopy16
	strh r5, [r4, #0x16]
	ldrh r0, [r4, #0xe]
	add r1, r4, r0, lsl #1
	add r5, r1, #0x10
	ldrh r0, [r4, #0xc]
	strh r0, [r1, #0x10]
	mov r0, #4
	strh r0, [r5, #2]
	mov r0, r4
	bl WMSP_WlRequest
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WMSP_WL_MlmeDeAuthenticate

	arm_func_start WMSP_WL_MlmeAuthenticate
WMSP_WL_MlmeAuthenticate: // 0x027E2BB0
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r6, r2
	mov r5, r3
	mov r0, #0
	strh r0, [r4]
	strh r0, [r4, #2]
	strh r0, [r4, #4]
	strh r0, [r4, #6]
	strh r0, [r4, #8]
	strh r0, [r4, #0xa]
	mov r0, #4
	strh r0, [r4, #0xc]
	mov r0, #5
	strh r0, [r4, #0xe]
	mov r0, r1
	add r1, r4, #0x10
	mov r2, #6
	bl MIi_CpuCopy16
	strh r6, [r4, #0x16]
	strh r5, [r4, #0x18]
	ldrh r0, [r4, #0xe]
	add r1, r4, r0, lsl #1
	add r5, r1, #0x10
	ldrh r0, [r4, #0xc]
	strh r0, [r1, #0x10]
	mov r0, #6
	strh r0, [r5, #2]
	mov r0, r4
	bl WMSP_WlRequest
	mov r0, r5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WMSP_WL_MlmeAuthenticate

	arm_func_start WMSP_WL_MlmeJoin
WMSP_WL_MlmeJoin: // 0x027E2C34
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r3, #0
	strh r3, [r4]
	strh r3, [r4, #2]
	strh r3, [r4, #4]
	strh r3, [r4, #6]
	strh r3, [r4, #8]
	strh r3, [r4, #0xa]
	mov r0, #3
	strh r0, [r4, #0xc]
	mov r0, #0x22
	strh r0, [r4, #0xe]
	strh r1, [r4, #0x10]
	strh r3, [r4, #0x12]
	mov r0, r2
	add r1, r4, #0x14
	mov r2, #0x44
	bl MIi_CpuCopy16
	ldrh r0, [r4, #0xe]
	add r1, r4, r0, lsl #1
	add r5, r1, #0x10
	ldrh r0, [r4, #0xc]
	strh r0, [r1, #0x10]
	mov r0, #5
	strh r0, [r5, #2]
	mov r0, r4
	bl WMSP_WlRequest
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WMSP_WL_MlmeJoin

	arm_func_start WMSP_WL_MlmeScan
WMSP_WL_MlmeScan: // 0x027E2CB8
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	mov r6, r3
	mov r0, #0
	strh r0, [r5]
	strh r0, [r5, #2]
	strh r0, [r5, #4]
	strh r0, [r5, #6]
	strh r0, [r5, #8]
	strh r0, [r5, #0xa]
	mov r0, #2
	strh r0, [r5, #0xc]
	mov r0, #0x1f
	strh r0, [r5, #0xe]
	mov r0, r2
	add r1, r5, #0x10
	mov r2, #6
	bl MIi_CpuCopy16
	strh r6, [r5, #0x16]
	ldr r0, [sp, #0x10]
	add r1, r5, #0x18
	mov r2, #0x20
	bl MIi_CpuCopy16
	ldrh r0, [sp, #0x14]
	strh r0, [r5, #0x38]
	ldr r0, [sp, #0x18]
	add r1, r5, #0x3a
	mov r2, #0x10
	bl MIi_CpuCopy16
	ldrh r0, [sp, #0x1c]
	strh r0, [r5, #0x4a]
	mov r0, #0
	strh r0, [r5, #0x4c]
	ldrh r0, [r5, #0xe]
	add r1, r5, r0, lsl #1
	add r6, r1, #0x10
	ldrh r0, [r5, #0xc]
	strh r0, [r1, #0x10]
	mov r0, r4, lsr #1
	sub r0, r0, #0x2c
	strh r0, [r6, #2]
	mov r0, r5
	bl WMSP_WlRequest
	mov r0, r6
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WMSP_WL_MlmeScan

	arm_func_start WMSP_WL_MlmePowerManagement
WMSP_WL_MlmePowerManagement: // 0x027E2D74
	stmdb sp!, {r4, lr}
	mov ip, #0
	strh ip, [r0]
	strh ip, [r0, #2]
	strh ip, [r0, #4]
	strh ip, [r0, #6]
	strh ip, [r0, #8]
	strh ip, [r0, #0xa]
	mov lr, #1
	strh lr, [r0, #0xc]
	mov ip, #3
	strh ip, [r0, #0xe]
	strh r1, [r0, #0x10]
	strh r2, [r0, #0x12]
	strh r3, [r0, #0x14]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	strh lr, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WMSP_WL_MlmePowerManagement

	arm_func_start WMSP_WL_MlmeReset
WMSP_WL_MlmeReset: // 0x027E2DD8
	stmdb sp!, {r4, lr}
	mov r2, #0
	strh r2, [r0]
	strh r2, [r0, #2]
	strh r2, [r0, #4]
	strh r2, [r0, #6]
	strh r2, [r0, #8]
	strh r2, [r0, #0xa]
	strh r2, [r0, #0xc]
	mov r3, #1
	strh r3, [r0, #0xe]
	strh r1, [r0, #0x10]
	ldrh r1, [r0, #0xe]
	add r2, r0, r1, lsl #1
	add r4, r2, #0x10
	ldrh r1, [r0, #0xc]
	strh r1, [r2, #0x10]
	strh r3, [r4, #2]
	bl WMSP_WlRequest
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WMSP_WL_MlmeReset

	arm_func_start WMSP_Initialize
WMSP_Initialize: // 0x027E2E30
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, [r0, #4]
	ldr r1, _027E2EDC // =0x027F9454
	str r4, [r1, #0x54c]
	ldr r2, [r0, #8]
	str r2, [r1, #0x550]
	str r2, [r4]
	ldr r0, [r0, #0xc]
	str r0, [r4, #8]
	bl WMSPi_CommonInit
	mov r0, #0xf
	bl PM_SetLEDPattern
	mov r1, #1
	ldr r0, [r4, #0]
	strh r1, [r0]
	add r0, sp, #0
	add r1, sp, #2
	bl WMSPi_CommonWlIdle
	cmp r0, #0
	bne _027E2EB0
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	ldrh r1, [sp]
	strh r1, [r0, #4]
	ldrh r1, [sp, #2]
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	b _027E2ED0
_027E2EB0:
	mov r1, #2
	ldr r0, [r4, #0]
	strh r1, [r0]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0
	strh r1, [r0]
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E2ED0:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E2EDC: .word 0x027F9454
	arm_func_end WMSP_Initialize

	arm_func_start WmspError_0
WmspError_0: // 0x027E2EE0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #1
	strh r1, [r0]
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_0

	arm_func_start WMSP_Reset
WMSP_Reset: // 0x027E2F18
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x214
	ldr r0, _027E3304 // =0x027F9454
	ldr r7, [r0, #0x550]
	mov r5, #0
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r0, [r7, #0xc]
	cmp r0, #1
	bne _027E2F74
	mov r0, r5
	str r0, [r7, #0xc]
	mov r5, #1
	bl WMSP_CancelVAlarm
	bl WMSP_SetThreadPriorityLow
	ldrh r0, [r7, #0]
	cmp r0, #0xa
	moveq r0, #8
	streqh r0, [r7]
	beq _027E2F74
	cmp r0, #9
	moveq r0, #7
	streqh r0, [r7]
_027E2F74:
	ldrh r1, [r7, #0]
	ldr r0, _027E3308 // =0x0000FFF9
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _027E2FA8
	add r0, r7, #0x100
	ldrh r9, [r0, #0x82]
	cmp r1, #7
	moveq r10, #1
	movne r10, #0
	b _027E2FAC
_027E2FA8:
	mov r9, #0
_027E2FAC:
	mov r1, #0
	add r0, r7, #0x100
	strh r1, [r0, #0x82]
	strh r1, [r7, #0x86]
	str r1, [r7, #0x14]
	str r1, [r7, #0x10]
	str r1, [r7, #0x1c]
	strh r1, [r7, #0xc2]
	mov r0, r4
	bl OS_RestoreInterrupts
	cmp r5, #0
	beq _027E2FE4
	ldr r0, _027E330C // =0x0000FFFF
	bl WMSP_CleanSendQueue
_027E2FE4:
	cmp r10, #0
	movne r0, #0
	strneh r0, [r7, #0xf6]
	cmp r9, #0
	beq _027E3048
	mov r8, #0
	add r5, r7, #0x128
	ldr r0, _027E3310 // =0x0000018A
	add r11, r7, r0
	mov r6, #1
	mov r4, #6
_027E3010:
	mov r0, r6, lsl r8
	ands r0, r9, r0
	beq _027E303C
	cmp r8, #0
	moveq r2, r11
	subne r0, r8, #1
	mlane r2, r0, r4, r5
	mov r0, r10
	mov r1, r8, lsl #0x10
	mov r1, r1, lsr #0x10
	bl WMSP_IndicateDisconnectionFromMyself
_027E303C:
	add r8, r8, #1
	cmp r8, #0x10
	blt _027E3010
_027E3048:
	add r0, r7, #0x128
	mov r1, #0
	mov r2, #0x5a
	bl MI_CpuFill8
	add r0, sp, #0x10
	bl WMSP_WL_DevGetStationState
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3078
	mov r0, #0x308
	bl WmspError_0
	b _027E32F8
_027E3078:
	ldrh r4, [r0, #6]
	add r0, sp, #0x10
	bl WMSP_WL_ParamGetMode
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E309C
	mov r0, #0x284
	bl WmspError_0
	b _027E32F8
_027E309C:
	ldrh r1, [r0, #6]
	cmp r4, #0x20
	bgt _027E30F0
	cmp r4, #0x20
	bge _027E31CC
	cmp r4, #0
	bgt _027E30C4
	cmp r4, #0
	beq _027E31F0
	b _027E32D0
_027E30C4:
	cmp r4, #0x12
	bgt _027E32D0
	cmp r4, #0x10
	blt _027E32D0
	cmp r4, #0x10
	beq _027E3210
	cmp r4, #0x11
	beq _027E3268
	cmp r4, #0x12
	beq _027E3268
	b _027E32D0
_027E30F0:
	cmp r4, #0x30
	bgt _027E3104
	cmp r4, #0x30
	beq _027E310C
	b _027E32D0
_027E3104:
	cmp r4, #0x40
	bne _027E32D0
_027E310C:
	ldr r0, _027E3314 // =0x0000FFFE
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _027E3194
	ldr r0, _027E3310 // =0x0000018A
	add r0, r7, r0
	add r1, sp, #4
	mov r2, #6
	bl MI_CpuCopy8
	mov r6, #0
	add r5, sp, #4
	mov r4, #3
	b _027E3188
_027E3148:
	add r0, sp, #0x10
	mov r1, r5
	mov r2, r4
	bl WMSP_WL_MlmeDeAuthenticate
	ldrh r0, [r0, #4]
	cmp r0, #0
	beq _027E3178
	cmp r0, #7
	beq _027E3184
	cmp r0, #0xc
	beq _027E3184
	b _027E31CC
_027E3178:
	mov r0, #3
	strh r0, [r7]
	b _027E31CC
_027E3184:
	add r6, r6, #1
_027E3188:
	cmp r6, #2
	blt _027E3148
	b _027E31CC
_027E3194:
	cmp r1, #1
	bne _027E31CC
	add r0, sp, #0xa
	mov r1, #0xff
	mov r2, #6
	bl MI_CpuFill8
	add r0, sp, #0x10
	add r1, sp, #0xa
	mov r2, #3
	bl WMSP_WL_MlmeDeAuthenticate
	ldrh r0, [r0, #4]
	cmp r0, #0
	moveq r0, #3
	streqh r0, [r7]
_027E31CC:
	add r0, sp, #0x10
	mov r1, #1
	bl WMSP_WL_MlmeReset
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E31F0
	mov r0, #0
	bl WmspError_0
	b _027E32F8
_027E31F0:
	add r0, sp, #0x10
	bl WMSP_WL_DevIdle
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3210
	ldr r0, _027E3318 // =0x00000302
	bl WmspError_0
	b _027E32F8
_027E3210:
	add r0, r7, #0x100
	ldrh r0, [r0, #0xee]
	cmp r0, #0
	bne _027E3250
	add r0, sp, #0x10
	mov r1, #1
	bl WMSP_WL_ParamSetPreambleType
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3244
	ldr r0, _027E331C // =0x0000020E
	bl WmspError_0
	b _027E32F8
_027E3244:
	mov r1, #1
	add r0, r7, #0x100
	strh r1, [r0, #0xee]
_027E3250:
	mov r0, #2
	strh r0, [r7]
	mov r0, #0
	str r0, [r7, #0x198]
	bl WMSP_ResetSizeVars
	b _027E32E0
_027E3268:
	cmp r1, #0
	bne _027E32A4
	mov r0, #1
	str r0, [sp]
	add r0, sp, #0x10
	mov r1, #0
	mov r2, r1
	mov r3, #0x14
	bl WMSP_WL_DevTestSignal
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E32A4
	ldr r0, _027E3320 // =0x00000309
	bl WmspError_0
	b _027E32F8
_027E32A4:
	add r0, sp, #0x10
	bl WMSP_WL_DevIdle
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E32C4
	ldr r0, _027E3318 // =0x00000302
	bl WmspError_0
	b _027E32F8
_027E32C4:
	mov r0, #2
	strh r0, [r7]
	b _027E32E0
_027E32D0:
	mov r0, #0x308
	mov r1, #0
	bl WmspError_0
	b _027E32F8
_027E32E0:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #1
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E32F8:
	add sp, sp, #0x214
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E3304: .word 0x027F9454
_027E3308: .word 0x0000FFF9
_027E330C: .word 0x0000FFFF
_027E3310: .word 0x0000018A
_027E3314: .word 0x0000FFFE
_027E3318: .word 0x00000302
_027E331C: .word 0x0000020E
_027E3320: .word 0x00000309
	arm_func_end WMSP_Reset

	arm_func_start WmspError_1
WmspError_1: // 0x027E3324
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #2
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_1

	arm_func_start WMSP_End
WMSP_End: // 0x027E3360
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x200
	ldr r0, _027E33F0 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldrh r0, [r4, #0]
	cmp r0, #2
	beq _027E3398
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #2
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E33E4
_027E3398:
	add r0, sp, #0
	bl WMSP_WL_DevShutdown
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E33B8
	ldr r0, _027E33F4 // =0x00000301
	bl WmspError_1
	b _027E33E4
_027E33B8:
	mov r0, #1
	strh r0, [r4]
	bl PM_SetLEDPattern
	mov r0, #0
	strh r0, [r4]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #2
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E33E4:
	add sp, sp, #0x200
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E33F0: .word 0x027F9454
_027E33F4: .word 0x00000301
	arm_func_end WMSP_End

	arm_func_start WmspError_2
WmspError_2: // 0x027E33F8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #7
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_2

	arm_func_start WMSP_SetParentParam
WMSP_SetParentParam: // 0x027E3434
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x200
	ldr r1, _027E34D4 // =0x027F9454
	ldr r4, [r1, #0x550]
	ldr r0, [r0, #4]
	add r1, r4, #0xe8
	mov r2, #0x40
	bl MI_CpuCopy8
	mov r2, #1
	add r0, r4, #0x100
	ldrh r1, [r0, #0x1a]
	mov r1, r2, lsl r1
	ldrh r0, [r0, #0xf4]
	ands r0, r1, r0
	bne _027E348C
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #7
	strh r1, [r0]
	mov r1, #6
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E34C8
_027E348C:
	add r0, sp, #0
	ldrh r1, [r4, #0xf8]
	bl WMSP_WL_ParamSetMaxConnectableChild
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E34B0
	ldr r0, _027E34D8 // =0x00000212
	bl WmspError_2
	b _027E34C8
_027E34B0:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #7
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E34C8:
	add sp, sp, #0x200
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E34D4: .word 0x027F9454
_027E34D8: .word 0x00000212
	arm_func_end WMSP_SetParentParam

	arm_func_start WmspError_3
WmspError_3: // 0x027E34DC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #8
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	mov r1, #0
	strh r1, [r0, #8]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_3

	arm_func_start WMSP_StartParent
WMSP_StartParent: // 0x027E3520
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x2b8
	ldr r1, _027E379C // =0x027F9454
	ldr r4, [r1, #0x550]
	add r6, sp, #0x38
	ldrh r1, [r4, #0]
	cmp r1, #2
	beq _027E3564
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #8
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	mov r1, #0
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E3790
_027E3564:
	ldr r5, [r0, #4]
	add r0, r4, #0x100
	ldrh r3, [r0, #0xf6]
	mov r2, #1
	ldrh r1, [r0, #0x1a]
	mov r1, r2, lsl r1
	mov r1, r1, asr #1
	ands r1, r3, r1
	bne _027E35AC
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #8
	strh r1, [r0]
	mov r1, #6
	strh r1, [r0, #2]
	mov r1, #0
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E3790
_027E35AC:
	strh r2, [r4, #0xe6]
	mov r1, #0
	strh r1, [r0, #0x88]
	bl OS_DisableInterrupts
	mov r2, #0
	add r1, r4, #0x100
	strh r2, [r1, #0x82]
	strh r2, [r4, #0x86]
	bl OS_RestoreInterrupts
	mov r1, #1
	add r0, r4, #0x100
	strh r1, [r0, #0xee]
	mov r0, #8
	mov r1, r6
	bl WMSP_SetAllParams
	cmp r0, #0
	beq _027E3790
	mov r0, r6
	bl WMSP_WL_DevClass1
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3610
	ldr r0, _027E37A0 // =0x00000303
	bl WmspError_3
	b _027E3790
_027E3610:
	cmp r5, #0
	movne r0, #1
	moveq r0, #0
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r0, r6
	mov r1, r5
	mov r2, #0
	mov r3, #1
	bl WMSP_WL_MlmePowerManagement
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3650
	mov r0, #1
	bl WmspError_3
	b _027E3790
_027E3650:
	strh r5, [r4, #0xc6]
	add r5, r4, #0xe8
	mov r0, #0
	add r1, sp, #0x238
	mov r2, #0x80
	bl MIi_CpuClear16
	add r0, sp, #0x238
	mov r1, r5
	bl WMSP_CopyParentParam
	mov r0, #0
	add r1, sp, #0x18
	mov r2, #0x20
	bl MIi_CpuClear16
	ldr r0, [r5, #8]
	strh r0, [sp, #0x18]
	ldr r0, [r5, #8]
	mov r0, r0, lsr #0x10
	strh r0, [sp, #0x1a]
	ldrh r0, [r5, #0xc]
	strh r0, [sp, #0x1c]
	mov r0, #0
	strh r0, [sp, #0x1e]
	mov r0, #2
	str r0, [sp]
	ldrh r0, [r5, #0x32]
	str r0, [sp, #4]
	mov r0, #3
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	ldrh r0, [r5, #4]
	add r0, r0, #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	add r0, sp, #0x238
	str r0, [sp, #0x14]
	mov r0, r6
	mov r1, #0x20
	add r2, sp, #0x18
	ldrh r3, [r5, #0x18]
	bl WMSP_WL_MlmeStart
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E370C
	mov r0, #9
	bl WmspError_3
	b _027E3790
_027E370C:
	ldrh r0, [r5, #0x14]
	cmp r0, #0
	movne r1, #0x2a
	moveq r1, #0
	ldrh r0, [r5, #0x34]
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WMSP_SetParentMaxSize
	ldrh r0, [r5, #0x14]
	cmp r0, #0
	movne r1, #6
	moveq r1, #0
	ldrh r0, [r5, #0x36]
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WMSP_SetChildMaxSize
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #7
	strh r1, [r4]
	mov r1, #8
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	strh r1, [r0, #8]
	ldrh r1, [r4, #0x30]
	strh r1, [r0, #0x2c]
	ldrh r1, [r4, #0x32]
	strh r1, [r0, #0x2e]
	bl WMSP_ReturnResult2Wm9
	mov r0, #1
	strh r0, [r4, #0xc2]
_027E3790:
	add sp, sp, #0x2b8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027E379C: .word 0x027F9454
_027E37A0: .word 0x00000303
	arm_func_end WMSP_StartParent

	arm_func_start WmspError_4
WmspError_4: // 0x027E37A4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #9
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_4

	arm_func_start WMSP_EndParent
WMSP_EndParent: // 0x027E37E0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x214
	ldr r0, _027E39AC // =0x027F9454
	ldr r8, [r0, #0x550]
	ldrh r0, [r8, #0]
	cmp r0, #7
	beq _027E3818
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #9
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E39A0
_027E3818:
	mov r6, #0
	strh r6, [r8, #0xf6]
	mov r10, #1
	add r4, r8, #0x128
	mov r11, #6
	mov r0, #3
	str r0, [sp]
	str r10, [sp, #4]
	mov r5, r10
_027E383C:
	mov r7, r5, lsl r10
	add r0, r8, #0x100
	ldrh r0, [r0, #0x82]
	ands r0, r0, r7
	beq _027E3900
	sub r1, r10, #1
	mov r0, #6
	mla r0, r1, r0, r4
	add r1, sp, #8
	mov r2, r11
	bl MI_CpuCopy8
	mov r9, r6
	b _027E38A0
_027E3870:
	add r0, sp, #0x10
	add r1, sp, #8
	ldr r2, [sp]
	bl WMSP_WL_MlmeDeAuthenticate
	ldrh r0, [r0, #4]
	cmp r0, #0
	beq _027E38A8
	cmp r0, #7
	beq _027E389C
	cmp r0, #0xc
	bne _027E38A8
_027E389C:
	add r9, r9, #1
_027E38A0:
	cmp r9, #2
	blt _027E3870
_027E38A8:
	bl OS_DisableInterrupts
	add r1, r8, #0x100
	ldrh r2, [r1, #0x82]
	ands r3, r2, r7
	beq _027E38FC
	mvn r3, r7
	and r2, r2, r3
	strh r2, [r1, #0x82]
	ldrh r1, [r8, #0x86]
	and r1, r1, r3
	strh r1, [r8, #0x86]
	add r1, r8, r10, lsl #3
	str r6, [r1, #0x738]
	str r6, [r1, #0x73c]
	bl OS_RestoreInterrupts
	ldr r0, [sp, #4]
	mov r1, r10, lsl #0x10
	mov r1, r1, lsr #0x10
	add r2, sp, #8
	bl WMSP_IndicateDisconnectionFromMyself
	b _027E3900
_027E38FC:
	bl OS_RestoreInterrupts
_027E3900:
	add r10, r10, #1
	cmp r10, #0x10
	blt _027E383C
	add r0, sp, #0x10
	mov r1, #1
	bl WMSP_WL_MlmeReset
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3930
	mov r0, #0
	bl WmspError_4
	b _027E39A0
_027E3930:
	mov r0, #0
	strh r0, [r8, #0xc2]
	mov r0, #3
	strh r0, [r8]
	add r0, sp, #0x10
	bl WMSP_WL_DevIdle
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3960
	ldr r0, _027E39B0 // =0x00000302
	bl WmspError_4
	b _027E39A0
_027E3960:
	mov r0, #2
	strh r0, [r8]
	mov r1, #0
	str r1, [r8, #0x198]
	add r0, r8, #0x100
	strh r1, [r0, #0x96]
	add r0, r8, #0x19c
	mov r2, #0x50
	bl MI_CpuFill8
	bl WMSP_ResetSizeVars
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #9
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E39A0:
	add sp, sp, #0x214
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E39AC: .word 0x027F9454
_027E39B0: .word 0x00000302
	arm_func_end WMSP_EndParent

	arm_func_start WmspError_5
WmspError_5: // 0x027E39B4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl WMSP_GetBuffer4Callback2Wm9
	cmp r4, #0
	movne r1, #0x26
	strneh r1, [r0]
	moveq r1, #0xa
	streqh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	mov r1, #4
	strh r1, [r0, #8]
	strh r6, [r0, #4]
	strh r5, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WmspError_5

	arm_func_start WmspGetScanExBufSize4WL
WmspGetScanExBufSize4WL: // 0x027E3A00
	stmdb sp!, {r4, lr}
	mov r4, r0
	sub r0, r4, #0x40
	mov r1, #0x42
	bl _u32_div_f
	sub r0, r4, r0, lsl #1
	add r0, r0, #0x5e
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WmspGetScanExBufSize4WL

	arm_func_start IsIncludeValidSSID
IsIncludeValidSSID: // 0x027E3A24
	ldrh r2, [r0, #0xa]
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r2, #0x20
	movhi r0, #0
	bxhi lr
	mov r3, #0
	b _027E3A60
_027E3A48:
	add r1, r0, r3
	ldrb r1, [r1, #0xc]
	cmp r1, #0
	movne r0, #1
	bxne lr
	add r3, r3, #1
_027E3A60:
	cmp r3, r2
	blt _027E3A48
	mov r0, #0
	bx lr
	arm_func_end IsIncludeValidSSID

	arm_func_start WMSP_StartScanEx
WMSP_StartScanEx: // 0x027E3A70
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr ip, _027E3F8C // =0x000004CC
	sub sp, sp, ip
	mov r8, r0
	ldr r0, _027E3F90 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldrh r0, [r4, #0]
	cmp r0, #2
	beq _027E3AC8
	cmp r0, #3
	beq _027E3AC8
	cmp r0, #5
	beq _027E3AC8
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x26
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	mov r1, #4
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E3F7C
_027E3AC8:
	ldr r0, [r8, #4]
	str r0, [r4, #0x184]
	ldrh r10, [r8, #2]
	add r0, r4, #0x100
	strh r10, [r0, #0x90]
	ldrh r11, [r8, #0xa]
	add r0, r8, #0xc
	add r1, sp, #0x1c
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r6, [r8, #0x36]
	ldrh r7, [r8, #0x12]
	cmp r7, #2
	beq _027E3B0C
	cmp r7, #3
	beq _027E3B18
	b _027E3B24
_027E3B0C:
	mov r5, #1
	mov r7, #0
	b _027E3B28
_027E3B18:
	mov r5, #1
	mov r7, r5
	b _027E3B28
_027E3B24:
	mov r5, #0
_027E3B28:
	ldrh r9, [r8, #0x14]
	add r0, r8, #0x16
	add r1, sp, #0x22
	mov r2, #0x20
	bl MI_CpuCopy8
	ldrh r0, [r8, #8]
	str r0, [sp, #0x10]
	ldrh r1, [sp, #0x1c]
	ldr r0, _027E3F94 // =0x0000FFFF
	cmp r1, r0
	beq _027E3B60
	ands r0, r1, #1
	bicne r0, r1, #1
	strneh r0, [sp, #0x1c]
_027E3B60:
	mov r0, r10, lsl #0x11
	mov r1, r0, lsr #0x10
	add r0, r4, #0x100
	ldrh r0, [r0, #0xf4]
	ands r10, r1, r0
	bne _027E3B9C
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x26
	strh r1, [r0]
	mov r1, #6
	strh r1, [r0, #2]
	mov r1, #4
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E3F7C
_027E3B9C:
	ldr r0, [r8, #4]
	cmp r0, #0
	beq _027E3BBC
	ands r0, r0, #3
	bne _027E3BBC
	ldrh r0, [r8, #8]
	cmp r0, #0x40
	bhs _027E3BE0
_027E3BBC:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x26
	strh r1, [r0]
	mov r1, #6
	strh r1, [r0, #2]
	mov r1, #4
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E3F7C
_027E3BE0:
	mov r0, #2
	strh r0, [r4, #0xe6]
	add r0, sp, #0x74
	bl WMSP_WL_DevGetStationState
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3C0C
	mov r0, #0x308
	mov r2, #1
	bl WmspError_5
	b _027E3F7C
_027E3C0C:
	ldrh r0, [r0, #6]
	cmp r0, #0x10
	bne _027E3C90
	mov r0, #0x26
	add r1, sp, #0x74
	bl WMSP_SetAllParams
	cmp r0, #0
	beq _027E3F7C
	add r0, sp, #0x74
	bl WMSP_WL_DevClass1
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3C50
	ldr r0, _027E3F98 // =0x00000303
	mov r2, #1
	bl WmspError_5
	b _027E3F7C
_027E3C50:
	mov r0, #3
	strh r0, [r4]
	add r0, sp, #0x74
	mov r1, #1
	mov r2, #0
	mov r3, r1
	bl WMSP_WL_MlmePowerManagement
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3C88
	mov r0, #1
	mov r2, r0
	bl WmspError_5
	b _027E3F7C
_027E3C88:
	mov r0, #1
	strh r0, [r4, #0xc6]
_027E3C90:
	cmp r7, #0
	bne _027E3CE0
	add r0, r4, #0x100
	ldrh r0, [r0, #0xee]
	cmp r0, #1
	bne _027E3D24
	add r0, sp, #0x74
	mov r1, #0
	bl WMSP_WL_ParamSetPreambleType
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3CD0
	ldr r0, _027E3F9C // =0x0000020E
	mov r2, #1
	bl WmspError_5
	b _027E3F7C
_027E3CD0:
	mov r1, #0
	add r0, r4, #0x100
	strh r1, [r0, #0xee]
	b _027E3D24
_027E3CE0:
	add r0, r4, #0x100
	ldrh r0, [r0, #0xee]
	cmp r0, #0
	bne _027E3D24
	add r0, sp, #0x74
	mov r1, #1
	bl WMSP_WL_ParamSetPreambleType
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3D18
	ldr r0, _027E3F9C // =0x0000020E
	mov r2, #1
	bl WmspError_5
	b _027E3F7C
_027E3D18:
	mov r1, #1
	add r0, r4, #0x100
	strh r1, [r0, #0xee]
_027E3D24:
	cmp r5, #1
	bne _027E3D7C
	add r0, sp, #0x42
	mov r1, #0xff
	mov r2, #0x20
	bl MI_CpuFill8
	cmp r6, #0x20
	bhi _027E3D54
	add r0, sp, #0x42
	mov r1, #0
	mov r2, r6
	bl MI_CpuFill8
_027E3D54:
	add r0, sp, #0x74
	add r1, sp, #0x42
	bl WMSP_WL_ParamSetSsidMask
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E3D7C
	ldr r0, _027E3FA0 // =0x0000020D
	mov r2, #1
	bl WmspError_5
	b _027E3F7C
_027E3D7C:
	mov r0, #5
	strh r0, [r4]
	mov r5, #0
	add r0, sp, #0x62
	mov r1, r5
	mov r2, #0x10
	bl MI_CpuFill8
	mov r3, #1
	add r1, sp, #0x62
	mov r2, r3
_027E3DA4:
	mov r0, r2, lsl r3
	ands r0, r10, r0
	strneb r3, [r1, r5]
	addne r0, r5, #1
	movne r0, r0, lsl #0x10
	movne r5, r0, lsr #0x10
	add r0, r3, #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	cmp r3, #0xf
	blo _027E3DA4
	ldr r0, [sp, #0x10]
	bl WmspGetScanExBufSize4WL
	mov r1, r0
	add r0, sp, #0x22
	str r0, [sp]
	str r7, [sp, #4]
	add r0, sp, #0x62
	str r0, [sp, #8]
	str r11, [sp, #0xc]
	add r0, sp, #0x74
	add r2, sp, #0x1c
	mov r3, r9
	bl WMSP_WL_MlmeScan
	mov r8, r0
	ldrh r1, [r8, #4]
	cmp r1, #0
	beq _027E3E24
	mov r0, #2
	mov r2, #1
	bl WmspError_5
	b _027E3F7C
_027E3E24:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r7, r0
	ldrh r0, [r8, #8]
	cmp r0, #0
	bne _027E3E60
	mov r0, #0x26
	strh r0, [r7]
	mov r1, #0
	strh r1, [r7, #2]
	mov r0, #4
	strh r0, [r7, #8]
	strh r1, [r7, #0xe]
	mov r0, r10, asr #1
	strh r0, [r7, #0xa]
	b _027E3F74
_027E3E60:
	add r5, r8, #0xa
	ldr r4, [r4, #0x184]
	mov r0, #0
	mov r1, r4
	ldr r2, [sp, #0x10]
	bl MIi_CpuClear16
	mov r6, #0
	mov r0, #0x20
	str r0, [sp, #0x18]
	b _027E3F40
_027E3E88:
	ldrh r0, [r5, #0]
	mov r0, r0, lsl #0x11
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x14]
	mov r0, r5
	mov r1, r4
	ldr r2, [sp, #0x14]
	bl MI_CpuCopy8
	cmp r9, #0
	beq _027E3ED4
	mov r0, r4
	bl IsIncludeValidSSID
	cmp r0, #0
	bne _027E3ED4
	strh r9, [r4, #0xa]
	add r0, sp, #0x22
	add r1, r4, #0xc
	ldr r2, [sp, #0x18]
	bl MI_CpuCopy8
_027E3ED4:
	add r0, r7, r6, lsl #2
	str r4, [r0, #0x10]
	ldrh r0, [r5, #2]
	and r1, r0, #0xff
	ands r0, r1, #2
	movne r0, r1, asr #2
	andne r11, r0, #0xff
	moveq r0, r1, asr #2
	addeq r0, r0, #0x19
	andeq r11, r0, #0xff
	mov r0, r11
	bl WMSP_GetLinkLevel
	add r1, r7, r6, lsl #1
	strh r0, [r1, #0x50]
	ldr r0, _027E3FA4 // =0x027FFF98
	ldrh r0, [r0, #0]
	eor r0, r11, r0, lsl #1
	eor r1, r0, r0, lsr #16
	ldr r0, _027E3FA4 // =0x027FFF98
	strh r1, [r0]
	ldr r0, [sp, #0x14]
	add r5, r5, r0
	add r4, r4, r0
	ands r0, r4, #2
	addne r0, r4, #2
	bicne r4, r0, #3
	add r6, r6, #1
_027E3F40:
	ldrh r0, [r8, #8]
	cmp r6, r0
	blt _027E3E88
	mov r0, #0x26
	strh r0, [r7]
	mov r0, #0
	strh r0, [r7, #2]
	mov r0, #5
	strh r0, [r7, #8]
	ldrh r0, [r8, #8]
	strh r0, [r7, #0xe]
	mov r0, r10, asr #1
	strh r0, [r7, #0xa]
_027E3F74:
	mov r0, r7
	bl WMSP_ReturnResult2Wm9
_027E3F7C:
	ldr ip, _027E3F8C // =0x000004CC
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E3F8C: .word 0x000004CC
_027E3F90: .word 0x027F9454
_027E3F94: .word 0x0000FFFF
_027E3F98: .word 0x00000303
_027E3F9C: .word 0x0000020E
_027E3FA0: .word 0x0000020D
_027E3FA4: .word 0x027FFF98
	arm_func_end WMSP_StartScanEx

	arm_func_start WMSP_StartScan
WMSP_StartScan: // 0x027E3FA8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x24c
	add r6, sp, #0x48
	ldr r1, _027E4330 // =0x027F9454
	ldr r4, [r1, #0x550]
	ldrh r1, [r4, #0]
	cmp r1, #2
	beq _027E3FFC
	cmp r1, #3
	beq _027E3FFC
	cmp r1, #5
	beq _027E3FFC
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xa
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	mov r1, #4
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E4324
_027E3FFC:
	ldr r1, [r0, #4]
	str r1, [r4, #0x184]
	ldrh r7, [r0, #2]
	add r1, r4, #0x100
	strh r7, [r1, #0x90]
	ldrh r5, [r0, #8]
	add r0, r0, #0xa
	add r1, sp, #0x10
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r1, [sp, #0x10]
	ldr r0, _027E4334 // =0x0000FFFF
	cmp r1, r0
	beq _027E4040
	ands r0, r1, #1
	bicne r0, r1, #1
	strneh r0, [sp, #0x10]
_027E4040:
	cmp r7, #0
	bne _027E406C
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xa
	strh r1, [r0]
	mov r1, #6
	strh r1, [r0, #2]
	mov r1, #4
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E4324
_027E406C:
	mov r0, #1
	mov r1, r0, lsl r7
	add r0, r4, #0x100
	ldrh r0, [r0, #0xf4]
	ands r0, r1, r0
	bne _027E40A8
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xa
	strh r1, [r0]
	mov r1, #6
	strh r1, [r0, #2]
	mov r1, #4
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E4324
_027E40A8:
	mov r0, #2
	strh r0, [r4, #0xe6]
	mov r0, r6
	bl WMSP_WL_DevGetStationState
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E40D4
	mov r0, #0x308
	mov r2, #0
	bl WmspError_5
	b _027E4324
_027E40D4:
	ldrh r0, [r0, #6]
	cmp r0, #0x10
	bne _027E4158
	mov r0, #0xa
	mov r1, r6
	bl WMSP_SetAllParams
	cmp r0, #0
	beq _027E4324
	mov r0, r6
	bl WMSP_WL_DevClass1
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E4118
	ldr r0, _027E4338 // =0x00000303
	mov r2, #0
	bl WmspError_5
	b _027E4324
_027E4118:
	mov r0, #3
	strh r0, [r4]
	mov r0, r6
	mov r1, #1
	mov r2, #0
	mov r3, r1
	bl WMSP_WL_MlmePowerManagement
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E4150
	mov r0, #1
	mov r2, #0
	bl WmspError_5
	b _027E4324
_027E4150:
	mov r0, #1
	strh r0, [r4, #0xc6]
_027E4158:
	mov r0, #5
	strh r0, [r4]
	ldr r0, _027E4334 // =0x0000FFFF
	add r1, sp, #0x16
	mov r2, #0x20
	bl MIi_CpuClear16
	strb r7, [sp, #0x36]
	add r0, sp, #0x37
	mov r1, #0
	mov r2, #0xf
	bl MI_CpuFill8
	add r0, sp, #0x16
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	add r0, sp, #0x36
	str r0, [sp, #8]
	str r5, [sp, #0xc]
	mov r0, r6
	ldr r1, _027E433C // =0x0000011E
	add r2, sp, #0x10
	mov r3, #0
	bl WMSP_WL_MlmeScan
	mov r6, r0
	ldrh r1, [r6, #4]
	cmp r1, #0
	beq _027E41D4
	mov r0, #2
	mov r2, #0
	bl WmspError_5
	b _027E4324
_027E41D4:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r5, r0
	ldrh r0, [r6, #8]
	cmp r0, #0
	bne _027E420C
	mov r0, #0xa
	strh r0, [r5]
	mov r1, #0
	strh r1, [r5, #2]
	mov r0, #4
	strh r0, [r5, #8]
	strh r7, [r5, #0x10]
	strh r1, [r5, #0x12]
	b _027E431C
_027E420C:
	mov r0, #0
	ldr r1, [r4, #0x184]
	add r1, r1, #0x40
	mov r2, #0x80
	bl MIi_CpuClear16
	add r0, r6, #0xa
	ldr r1, [r4, #0x184]
	ldrh r2, [r6, #0xa]
	mov r2, r2, lsl #1
	bl MI_CpuCopy8
	mov r0, #0xa
	strh r0, [r5]
	mov r0, #0
	strh r0, [r5, #2]
	mov r0, #5
	strh r0, [r5, #8]
	ldrh r0, [r6, #0x40]
	strh r0, [r5, #0x10]
	ldrh r0, [r6, #0xc]
	and r1, r0, #0xff
	ands r0, r1, #2
	movne r0, r1, asr #2
	andne r4, r0, #0xff
	moveq r0, r1, asr #2
	addeq r0, r0, #0x19
	andeq r4, r0, #0xff
	mov r0, r4
	bl WMSP_GetLinkLevel
	strh r0, [r5, #0x12]
	ldr r1, _027E4340 // =0x027FFF98
	ldrh r0, [r1, #0]
	eor r0, r4, r0, lsl #1
	eor r0, r0, r0, lsr #16
	strh r0, [r1]
	ldrh r0, [r6, #0x14]
	strh r0, [r5, #0x14]
	add r0, r6, #0xe
	add r1, r5, #0xa
	mov r2, #6
	bl MI_CpuCopy8
	add r0, r6, #0x16
	add r1, r5, #0x16
	mov r2, #0x20
	bl MIi_CpuCopy16
	ldrh r0, [r6, #0x46]
	strh r0, [r5, #0x36]
	ldrh r0, [r5, #0x36]
	cmp r0, #0x80
	bls _027E42F4
	mov r0, #0xa
	strh r0, [r5]
	mov r1, #0
	strh r1, [r5, #2]
	mov r0, #4
	strh r0, [r5, #8]
	strh r7, [r5, #0x10]
	strh r1, [r5, #0x12]
	b _027E431C
_027E42F4:
	mov r0, #0
	add r1, r5, #0x38
	mov r2, #0x80
	bl MIi_CpuClear16
	add r0, r6, #0x4a
	add r1, r5, #0x38
	ldrh r2, [r5, #0x36]
	add r2, r2, #1
	bic r2, r2, #1
	bl MIi_CpuCopy16
_027E431C:
	mov r0, r5
	bl WMSP_ReturnResult2Wm9
_027E4324:
	add sp, sp, #0x24c
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027E4330: .word 0x027F9454
_027E4334: .word 0x0000FFFF
_027E4338: .word 0x00000303
_027E433C: .word 0x0000011E
_027E4340: .word 0x027FFF98
	arm_func_end WMSP_StartScan

	arm_func_start WmspError_6
WmspError_6: // 0x027E4344
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xb
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_6

	arm_func_start WMSP_EndScan
WMSP_EndScan: // 0x027E4380
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x204
	add r5, sp, #0
	ldr r0, _027E4448 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldrh r0, [r4, #0]
	cmp r0, #5
	beq _027E43BC
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xb
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E443C
_027E43BC:
	mov r0, r5
	bl WMSP_WL_DevIdle
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E43DC
	ldr r0, _027E444C // =0x00000302
	bl WmspError_6
	b _027E443C
_027E43DC:
	mov r0, #2
	strh r0, [r4]
	add r0, r4, #0x100
	ldrh r0, [r0, #0xee]
	cmp r0, #0
	bne _027E4424
	mov r0, r5
	mov r1, #1
	bl WMSP_WL_ParamSetPreambleType
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E4418
	ldr r0, _027E4450 // =0x0000020E
	bl WmspError_6
	b _027E443C
_027E4418:
	mov r1, #1
	add r0, r4, #0x100
	strh r1, [r0, #0xee]
_027E4424:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xb
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E443C:
	add sp, sp, #0x204
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E4448: .word 0x027F9454
_027E444C: .word 0x00000302
_027E4450: .word 0x0000020E
	arm_func_end WMSP_EndScan

	arm_func_start WmspError_7
WmspError_7: // 0x027E4454
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xc
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r6, [r0, #4]
	strh r5, [r0, #6]
	strh r4, [r0, #0xe]
	bl WMSP_ReturnResult2Wm9
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WmspError_7

	arm_func_start WMSP_StartConnectEx
WMSP_StartConnectEx: // 0x027E4490
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x250
	mov r6, r0
	add r4, sp, #0xc
	ldr r0, _027E4A5C // =0x027F9454
	ldr r7, [r0, #0x54c]
	ldr r5, [r0, #0x550]
	ldrh r0, [r5, #0]
	cmp r0, #2
	beq _027E44DC
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xc
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	mov r1, #6
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E4A50
_027E44DC:
	ldr r0, [r6, #4]
	add r1, r7, #0x10
	mov r2, #0xc0
	bl MI_CpuCopy8
	ldrh r0, [r7, #0x4c]
	cmp r0, #0x10
	blo _027E4528
	ldrb r0, [r7, #0x5b]
	ands r0, r0, #1
	bne _027E4528
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xc
	strh r1, [r0]
	mov r1, #0xb
	strh r1, [r0, #2]
	mov r1, #6
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E4A50
_027E4528:
	mov r1, #1
	ldrh r0, [r7, #0x46]
	mov r1, r1, lsl r0
	add r0, r5, #0x100
	ldrh r0, [r0, #0xf4]
	ands r0, r1, r0
	beq _027E4554
	mov r1, r1, asr #1
	ldr r0, _027E4A60 // =0x00001FFF
	ands r0, r1, r0
	bne _027E4574
_027E4554:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xc
	strh r1, [r0]
	mov r1, #6
	strh r1, [r0, #2]
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E4A50
_027E4574:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xc
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #6
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	add r0, r5, #0x100
	ldrh r1, [r0, #0xec]
	cmp r1, #1
	bne _027E45C0
	ldrh r1, [r7, #0x3e]
	ands r1, r1, #1
	movne r1, #1
	strneh r1, [r0, #0xec]
	moveq r1, #2
	streqh r1, [r0, #0xec]
	b _027E45D8
_027E45C0:
	ldrh r1, [r7, #0x3e]
	ands r1, r1, #2
	movne r1, #2
	strneh r1, [r0, #0xec]
	moveq r1, #1
	streqh r1, [r0, #0xec]
_027E45D8:
	ldrh r0, [r7, #0x3c]
	ands r0, r0, #0x20
	movne r1, #1
	addne r0, r5, #0x100
	strneh r1, [r0, #0xee]
	moveq r1, #0
	addeq r0, r5, #0x100
	streqh r1, [r0, #0xee]
	ldrh r0, [r7, #0x4c]
	cmp r0, #0
	moveq r0, #3
	streqh r0, [r5, #0xe6]
	movne r0, #2
	strneh r0, [r5, #0xe6]
	mov r0, #0xc
	mov r1, r4
	bl WMSP_SetAllParams
	cmp r0, #0
	beq _027E4A50
	mov r0, r4
	mov r1, #0
	bl WMSP_WL_ParamSetNullKeyResponseMode
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E464C
	ldr r0, _027E4A64 // =0x00000216
	mov r2, #0
	bl WmspError_7
	b _027E4A50
_027E464C:
	ldrh r0, [r7, #0x4c]
	cmp r0, #0x10
	bhs _027E46A8
	ldrh r1, [r7, #0x42]
	cmp r1, #0
	moveq r0, #1
	beq _027E4674
	ldr r0, _027E4A68 // =0x00002710
	bl _s32_div_f
	add r0, r0, #1
_027E4674:
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	cmp r1, #0xff
	movhi r1, #0xff
	mov r0, r4
	bl WMSP_WL_ParamSetBeaconLostThreshold
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E46A8
	ldr r0, _027E4A6C // =0x0000020B
	mov r2, #0
	bl WmspError_7
	b _027E4A50
_027E46A8:
	mov r0, r4
	bl WMSP_WL_DevClass1
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E46CC
	ldr r0, _027E4A70 // =0x00000303
	mov r2, #0
	bl WmspError_7
	b _027E4A50
_027E46CC:
	mov r0, #3
	strh r0, [r5]
	ldr r0, [r6, #0x20]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	mov r0, r4
	mov r1, r8
	mov r2, #0
	mov r3, #1
	bl WMSP_WL_MlmePowerManagement
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E471C
	mov r0, #1
	mov r2, #0
	bl WmspError_7
	b _027E4A50
_027E471C:
	strh r8, [r5, #0xc6]
	add r0, r7, #0x10
	add r1, sp, #0x20c
	mov r2, #0x40
	bl MI_CpuCopy8
	ldrh r0, [r5, #0xe6]
	cmp r0, #2
	bne _027E477C
	mov r1, #0x20
	add r0, sp, #0x200
	strh r1, [r0, #0x16]
	ldr r1, [r7, #0x54]
	strh r1, [r0, #0x18]
	ldr r1, [r7, #0x54]
	mov r1, r1, lsr #0x10
	strh r1, [r0, #0x1a]
	ldrh r1, [r7, #0x58]
	strh r1, [r0, #0x1c]
	mov r1, #0
	strh r1, [r0, #0x1e]
	add r0, r6, #8
	add r1, sp, #0x220
	mov r2, #0x18
	bl MI_CpuCopy8
_027E477C:
	mov r0, r4
	mov r1, #0x7d0
	add r2, sp, #0x20c
	bl WMSP_WL_MlmeJoin
	mov r2, r0
	ldrh r1, [r2, #4]
	cmp r1, #0
	bne _027E47A8
	ldrh r0, [r2, #6]
	cmp r0, #0
	beq _027E47B8
_027E47A8:
	mov r0, #3
	ldrh r2, [r2, #6]
	bl WmspError_7
	b _027E4A50
_027E47B8:
	add r0, r2, #8
	ldr r1, _027E4A74 // =0x0000018A
	add r1, r5, r1
	mov r2, #6
	bl MI_CpuCopy8
	ldr r0, _027E4A74 // =0x0000018A
	add r0, r5, r0
	add r1, sp, #0
	mov r2, #6
	bl MI_CpuCopy8
	mov r0, r4
	add r1, sp, #0
	ldrh r2, [r6, #0x26]
	mov r3, #0x7d0
	bl WMSP_WL_MlmeAuthenticate
	mov r2, r0
	ldrh r1, [r2, #4]
	cmp r1, #0xc
	bne _027E4830
	ldrh r0, [r2, #6]
	cmp r0, #0x13
	bne _027E4830
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xc
	strh r1, [r0]
	strh r1, [r0, #2]
	mov r1, #6
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E4A50
_027E4830:
	cmp r1, #0
	bne _027E4844
	ldrh r0, [r2, #6]
	cmp r0, #0
	beq _027E4854
_027E4844:
	mov r0, #4
	ldrh r2, [r2, #6]
	bl WmspError_7
	b _027E4A50
_027E4854:
	ldr r0, _027E4A74 // =0x0000018A
	add r0, r5, r0
	add r1, sp, #6
	mov r2, #6
	bl MI_CpuCopy8
	mov r0, r4
	add r1, sp, #6
	mov r2, #1
	mov r3, #0x7d0
	bl WMSP_WL_MlmeAssociate
	mov r4, r0
	bl OS_DisableInterrupts
	mov r6, r0
	ldrh r2, [r4, #4]
	cmp r2, #0xc
	bne _027E48C4
	ldrh r1, [r4, #6]
	cmp r1, #0x13
	bne _027E48C4
	bl OS_RestoreInterrupts
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xc
	strh r1, [r0]
	strh r1, [r0, #2]
	mov r1, #6
	strh r1, [r0, #8]
	bl WMSP_ReturnResult2Wm9
	b _027E4A50
_027E48C4:
	cmp r2, #0
	bne _027E48D8
	ldrh r0, [r4, #6]
	cmp r0, #0
	beq _027E48F4
_027E48D8:
	mov r0, r6
	bl OS_RestoreInterrupts
	mov r0, #6
	ldrh r1, [r4, #4]
	ldrh r2, [r4, #6]
	bl WmspError_7
	b _027E4A50
_027E48F4:
	ldrh r1, [r4, #8]
	add r0, r5, #0x100
	strh r1, [r0, #0x88]
	ldrh r0, [r7, #0x58]
	strh r0, [r5, #0xba]
	mov r0, #1
	add r1, r5, #0x1f8
	mov r2, #0x10
	bl MIi_CpuClear16
	ldrh r0, [r7, #0x12]
	and r1, r0, #0xff
	ands r0, r1, #2
	movne r0, r1, asr #2
	andne r4, r0, #0xff
	moveq r0, r1, asr #2
	addeq r0, r0, #0x19
	andeq r4, r0, #0xff
	mov r0, r4
	bl WMSP_GetLinkLevel
	strh r0, [r5, #0xbc]
	mov r0, r4
	bl WMSP_FillRssiIntoList
	bl OS_DisableInterrupts
	mov r4, r0
	mov r1, #1
	add r0, r5, #0x100
	strh r1, [r0, #0x82]
	strh r1, [r5, #0x86]
	ldr r2, [r5, #0x7b8]
	ldr r1, [r5, #0x7bc]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	beq _027E4990
	bl OS_GetTick
	orr r1, r1, #0
	orr r0, r0, #1
	str r0, [r5, #0x738]
	str r1, [r5, #0x73c]
_027E4990:
	mov r0, #8
	strh r0, [r5]
	ldrb r0, [r7, #0x5b]
	ands r0, r0, #4
	movne r1, #0x2a
	moveq r1, #0
	ldrh r0, [r7, #0x5c]
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WMSP_SetParentMaxSize
	ldrb r0, [r7, #0x5b]
	ands r0, r0, #4
	movne r1, #6
	moveq r1, #0
	ldrh r0, [r7, #0x5e]
	add r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WMSP_SetChildMaxSize
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
	strh r0, [r5, #0xc2]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r4, r0
	mov r0, #0xc
	strh r0, [r4]
	mov r0, #0
	strh r0, [r4, #2]
	mov r0, #7
	strh r0, [r4, #8]
	add r0, r5, #0x100
	ldrh r0, [r0, #0x88]
	strh r0, [r4, #0xa]
	ldr r0, _027E4A74 // =0x0000018A
	add r0, r5, r0
	add r1, r4, #0x10
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r0, [r5, #0x30]
	strh r0, [r4, #0x16]
	ldrh r0, [r5, #0x32]
	strh r0, [r4, #0x18]
	mov r0, r4
	bl WMSP_ReturnResult2Wm9
	mov r0, r6
	bl OS_RestoreInterrupts
_027E4A50:
	add sp, sp, #0x250
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027E4A5C: .word 0x027F9454
_027E4A60: .word 0x00001FFF
_027E4A64: .word 0x00000216
_027E4A68: .word 0x00002710
_027E4A6C: .word 0x0000020B
_027E4A70: .word 0x00000303
_027E4A74: .word 0x0000018A
	arm_func_end WMSP_StartConnectEx

	arm_func_start WmspIndError
WmspIndError: // 0x027E4A78
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x25
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r7, [r0, #4]
	strh r6, [r0, #6]
	strh r5, [r0, #8]
	strh r4, [r0, #0xa]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WmspIndError

	arm_func_start WmspError_8
WmspError_8: // 0x027E4AC4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xd
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r7, [r0, #4]
	strh r6, [r0, #6]
	strh r5, [r0, #8]
	strh r4, [r0, #0xa]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end WmspError_8

	arm_func_start WMSP_IndicateDisconnectionFromMyself
WMSP_IndicateDisconnectionFromMyself: // 0x027E4B10
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	ldr r0, _027E4BD4 // =0x027F9454
	ldr r4, [r0, #0x550]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r5, r0
	mov r0, #0
	strh r0, [r5, #2]
	cmp r8, #0
	beq _027E4B80
	mov r0, #8
	strh r0, [r5]
	mov r0, #0x1a
	strh r0, [r5, #8]
	ldr r0, _027E4BD8 // =0x0000F001
	strh r0, [r5, #0x12]
	strh r7, [r5, #0x10]
	mov r0, r6
	add r1, r5, #0xa
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r0, [r4, #0x30]
	strh r0, [r5, #0x2c]
	ldrh r0, [r4, #0x32]
	strh r0, [r5, #0x2e]
	b _027E4BC4
_027E4B80:
	mov r0, #0xc
	strh r0, [r5]
	mov r0, #0x1a
	strh r0, [r5, #8]
	ldr r0, _027E4BD8 // =0x0000F001
	strh r0, [r5, #0xc]
	add r0, r4, #0x100
	ldrh r0, [r0, #0x88]
	strh r0, [r5, #0xa]
	mov r0, r6
	add r1, r5, #0x10
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r0, [r4, #0x30]
	strh r0, [r5, #0x16]
	ldrh r0, [r4, #0x32]
	strh r0, [r5, #0x18]
_027E4BC4:
	mov r0, r5
	bl WMSP_ReturnResult2Wm9
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027E4BD4: .word 0x027F9454
_027E4BD8: .word 0x0000F001
	arm_func_end WMSP_IndicateDisconnectionFromMyself

	arm_func_start WMSP_DisconnectCore
WMSP_DisconnectCore: // 0x027E4BDC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x244
	movs r10, r1
	str r2, [sp]
	ldr r1, _027E51D0 // =0x027F9454
	ldr r5, [r1, #0x550]
	ldr r1, [r0, #4]
	mov r1, r1, lsl #0x10
	mov r9, r1, lsr #0x10
	ldrne r0, [r0, #8]
	moveq r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	mov r8, #0
	mov r7, r8
	ldrh r0, [r5, #0]
	cmp r0, #9
	beq _027E4C30
	cmp r0, #7
	bne _027E4C40
_027E4C30:
	ldr r0, [r5, #0xc]
	cmp r0, #1
	moveq r7, #1
	b _027E4D3C
_027E4C40:
	cmp r0, #0xa
	beq _027E4C50
	cmp r0, #8
	bne _027E4D00
_027E4C50:
	bl OS_DisableInterrupts
	mov r4, r0
	add r1, r5, #0x100
	ldrh r1, [r1, #0x82]
	cmp r1, #0
	bne _027E4CA8
	bl OS_RestoreInterrupts
	cmp r10, #0
	bne _027E4CA0
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xd
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	mov r1, #0
	strh r1, [r0, #4]
	strh r1, [r0, #6]
	strh r9, [r0, #8]
	strh r1, [r0, #0xa]
	bl WMSP_ReturnResult2Wm9
_027E4CA0:
	mov r0, #0
	b _027E51C4
_027E4CA8:
	ldr r0, [r5, #0xc]
	cmp r0, #1
	bne _027E4CD8
	mov r0, #0
	str r0, [r5, #0xc]
	mov r7, #1
	bl WMSP_CancelVAlarm
	bl WMSP_SetThreadPriorityLow
	ldrh r0, [r5, #0]
	cmp r0, #0xa
	moveq r0, #8
	streqh r0, [r5]
_027E4CD8:
	mov r1, #0
	add r0, r5, #0x100
	strh r1, [r0, #0x82]
	strh r1, [r5, #0x86]
	str r1, [r5, #0x14]
	str r1, [r5, #0x10]
	str r1, [r5, #0x1c]
	mov r0, r4
	bl OS_RestoreInterrupts
	b _027E4D3C
_027E4D00:
	cmp r10, #0
	bne _027E4D34
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xd
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	mov r1, r8
	strh r1, [r0, #4]
	strh r1, [r0, #6]
	strh r9, [r0, #8]
	strh r1, [r0, #0xa]
	bl WMSP_ReturnResult2Wm9
_027E4D34:
	mov r0, #0
	b _027E51C4
_027E4D3C:
	ldrh r0, [r5, #0]
	cmp r0, #0xa
	beq _027E4D50
	cmp r0, #8
	bne _027E4F94
_027E4D50:
	ldr r0, _027E51D4 // =0x0000018A
	add r0, r5, r0
	add r1, sp, #0x38
	mov r2, #6
	bl MI_CpuCopy8
	mov r8, #0
	add r6, sp, #0x38
	mov r4, #3
	b _027E4E10
_027E4D74:
	add r0, sp, #0x44
	mov r1, r6
	mov r2, r4
	bl WMSP_WL_MlmeDeAuthenticate
	ldrh r1, [r0, #4]
	cmp r1, #7
	bgt _027E4DBC
	cmp r1, #7
	bge _027E4DC4
	cmp r1, #1
	bgt _027E4DCC
	cmp r1, #0
	blt _027E4DCC
	cmp r1, #0
	beq _027E4E18
	cmp r1, #1
	beq _027E4E18
	b _027E4DCC
_027E4DBC:
	cmp r1, #0xc
	bne _027E4DCC
_027E4DC4:
	add r8, r8, #1
	b _027E4E10
_027E4DCC:
	cmp r10, #0
	beq _027E4DE8
	mov r0, #5
	mov r2, r9
	mov r3, #0
	bl WmspIndError
	b _027E4DF8
_027E4DE8:
	mov r0, #5
	mov r2, r9
	mov r3, #0
	bl WmspError_8
_027E4DF8:
	cmp r7, #0
	beq _027E4E08
	mov r0, #1
	bl WMSP_CleanSendQueue
_027E4E08:
	mov r0, #0
	b _027E51C4
_027E4E10:
	cmp r8, #2
	blt _027E4D74
_027E4E18:
	mov r8, #1
	mov r0, #0
	strh r0, [r5, #0xc2]
	mov r0, #3
	strh r0, [r5]
	add r0, sp, #0x44
	mov r1, r8
	bl WMSP_WL_MlmeReset
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E4E88
	cmp r10, #0
	beq _027E4E60
	mov r0, #0
	mov r2, r9
	mov r3, r8
	bl WmspIndError
	b _027E4E70
_027E4E60:
	mov r0, #0
	mov r2, r9
	mov r3, r8
	bl WmspError_8
_027E4E70:
	cmp r7, #0
	beq _027E4E80
	mov r0, #1
	bl WMSP_CleanSendQueue
_027E4E80:
	mov r0, #0
	b _027E51C4
_027E4E88:
	add r0, sp, #0x44
	bl WMSP_WL_DevIdle
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E4EE0
	cmp r10, #0
	beq _027E4EB8
	ldr r0, _027E51D8 // =0x00000302
	mov r2, r9
	mov r3, r8
	bl WmspIndError
	b _027E4EC8
_027E4EB8:
	ldr r0, _027E51D8 // =0x00000302
	mov r2, r9
	mov r3, r8
	bl WmspError_8
_027E4EC8:
	cmp r7, #0
	beq _027E4ED8
	mov r0, #1
	bl WMSP_CleanSendQueue
_027E4ED8:
	mov r0, #0
	b _027E51C4
_027E4EE0:
	mov r0, #2
	strh r0, [r5]
	mov r1, #0
	str r1, [r5, #0x198]
	add r0, r5, #0x100
	strh r1, [r0, #0x96]
	add r0, r5, #0x19c
	mov r2, #0x50
	bl MI_CpuFill8
	bl WMSP_ResetSizeVars
	cmp r10, #1
	bne _027E4F70
	bl WMSP_GetBuffer4Callback2Wm9
	mov r4, r0
	mov r0, #0xc
	strh r0, [r4]
	mov r0, #0
	strh r0, [r4, #2]
	mov r0, #9
	strh r0, [r4, #8]
	ldr r0, [sp, #4]
	strh r0, [r4, #0xc]
	add r0, r5, #0x100
	ldrh r0, [r0, #0x88]
	strh r0, [r4, #0xa]
	add r0, sp, #0x38
	add r1, r4, #0x10
	mov r2, #6
	bl MI_CpuCopy8
	ldrh r0, [r5, #0x30]
	strh r0, [r4, #0x16]
	ldrh r0, [r5, #0x32]
	strh r0, [r4, #0x18]
	mov r0, r4
	bl WMSP_ReturnResult2Wm9
	b _027E4F80
_027E4F70:
	mov r0, #0
	mov r1, r0
	add r2, sp, #0x38
	bl WMSP_IndicateDisconnectionFromMyself
_027E4F80:
	cmp r7, #0
	beq _027E51B4
	mov r0, #1
	bl WMSP_CleanSendQueue
	b _027E51B4
_027E4F94:
	mov r6, #1
	str r6, [sp, #0x24]
	mov r0, #0
	str r0, [sp, #0x18]
	mov r0, #6
	str r0, [sp, #0x14]
	str r6, [sp, #0x34]
	mov r0, #8
	str r0, [sp, #0x2c]
	mov r0, #9
	str r0, [sp, #0x30]
	mov r0, #3
	str r0, [sp, #0x1c]
	str r6, [sp, #0x10]
	b _027E51AC
_027E4FD0:
	ldr r0, [sp, #0x10]
	mov r4, r0, lsl r6
	add r0, r5, #0x100
	ldrh r0, [r0, #0x82]
	and r0, r0, r9
	ands r0, r4, r0
	beq _027E51A8
	mov r0, r6, lsl #0x10
	mov r11, r0, lsr #0x10
	add r2, r5, #0x128
	sub r1, r6, #1
	mov r0, #6
	mla r0, r1, r0, r2
	str r0, [sp, #0xc]
	add r1, sp, #0x3e
	ldr r2, [sp, #0x14]
	bl MI_CpuCopy8
	ldr r0, [sp, #0x18]
	str r0, [sp, #8]
	b _027E50A0
_027E5020:
	add r0, sp, #0x44
	add r1, sp, #0x3e
	ldr r2, [sp, #0x1c]
	bl WMSP_WL_MlmeDeAuthenticate
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E50AC
	cmp r1, #7
	beq _027E504C
	cmp r1, #0xc
	bne _027E505C
_027E504C:
	ldr r0, [sp, #8]
	add r0, r0, #1
	str r0, [sp, #8]
	b _027E50A0
_027E505C:
	cmp r10, #0
	beq _027E5078
	mov r0, #5
	mov r2, r9
	mov r3, r8
	bl WmspIndError
	b _027E5088
_027E5078:
	mov r0, #5
	mov r2, r9
	mov r3, r8
	bl WmspError_8
_027E5088:
	cmp r7, #0
	beq _027E5098
	mov r0, #1
	bl WMSP_CleanSendQueue
_027E5098:
	mov r0, #0
	b _027E51C4
_027E50A0:
	ldr r0, [sp, #8]
	cmp r0, #2
	blt _027E5020
_027E50AC:
	bl OS_DisableInterrupts
	str r0, [sp, #0x20]
	add r2, r5, #0x100
	ldrh r1, [r2, #0x82]
	ands r3, r1, r4
	beq _027E51A4
	ldr r0, [sp, #0x24]
	orr r0, r8, r0, lsl r11
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	mvn r3, r4
	and r0, r1, r3
	strh r0, [r2, #0x82]
	ldrh r0, [r5, #0x86]
	and r0, r0, r3
	strh r0, [r5, #0x86]
	add r1, r5, r11, lsl #3
	ldr r0, [sp, #0x18]
	str r0, [r1, #0x738]
	str r0, [r1, #0x73c]
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #0x18]
	ldr r2, [sp, #0x14]
	bl MI_CpuFill8
	ldr r0, [sp, #0x20]
	bl OS_RestoreInterrupts
	cmp r10, #1
	bne _027E5178
	bl WMSP_GetBuffer4Callback2Wm9
	str r0, [sp, #0x28]
	ldr r1, [sp, #0x2c]
	strh r1, [r0]
	ldr r1, [sp, #0x18]
	strh r1, [r0, #2]
	ldr r1, [sp, #0x30]
	strh r1, [r0, #8]
	ldr r1, [sp, #4]
	strh r1, [r0, #0x12]
	strh r11, [r0, #0x10]
	add r0, sp, #0x3e
	ldr r1, [sp, #0x28]
	add r1, r1, #0xa
	ldr r2, [sp, #0x14]
	bl MI_CpuCopy8
	ldrh r1, [r5, #0x30]
	ldr r0, [sp, #0x28]
	strh r1, [r0, #0x2c]
	ldrh r1, [r5, #0x32]
	strh r1, [r0, #0x2e]
	bl WMSP_ReturnResult2Wm9
	b _027E518C
_027E5178:
	ldr r0, [sp, #0x34]
	mov r1, r6, lsl #0x10
	mov r1, r1, lsr #0x10
	add r2, sp, #0x3e
	bl WMSP_IndicateDisconnectionFromMyself
_027E518C:
	cmp r7, #0
	beq _027E51A8
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WMSP_CleanSendQueue
	b _027E51A8
_027E51A4:
	bl OS_RestoreInterrupts
_027E51A8:
	add r6, r6, #1
_027E51AC:
	cmp r6, #0x10
	blt _027E4FD0
_027E51B4:
	ldr r0, [sp]
	cmp r0, #0
	strneh r8, [r0]
	mov r0, #1
_027E51C4:
	add sp, sp, #0x244
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E51D0: .word 0x027F9454
_027E51D4: .word 0x0000018A
_027E51D8: .word 0x00000302
	arm_func_end WMSP_DisconnectCore

	arm_func_start WMSP_Disconnect
WMSP_Disconnect: // 0x027E51DC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, [r0, #4]
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	mov r1, #0
	add r2, sp, #0
	bl WMSP_DisconnectCore
	cmp r0, #1
	bne _027E5228
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xd
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	strh r4, [r0, #8]
	ldrh r1, [sp]
	strh r1, [r0, #0xa]
	bl WMSP_ReturnResult2Wm9
_027E5228:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WMSP_Disconnect

	arm_func_start WMSP_StartMP
WMSP_StartMP: // 0x027E5234
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x200
	ldr r1, _027E54E4 // =_027F8454
	ldr r2, _027E54E8 // =0x027F9454
	ldr r4, [r2, #0x550]
	mov r10, #0
	ldr r9, [r0, #4]
	ldr r8, [r0, #8]
	ldr r7, [r0, #0xc]
	ldr r6, [r0, #0x10]
	add r5, r0, #0x14
	ldrh r0, [r4, #0x9c]
	cmp r0, #0
	bne _027E52BC
	ldrh r0, [r4, #0x3c]
	add r0, r0, #0x1f
	bic r0, r0, #0x1f
	cmp r6, r0
	movlo r10, #6
	add r0, r4, #0x100
	ldrh r0, [r0, #0x88]
	cmp r0, #0
	ldrneh r0, [r4, #0x3e]
	addne r0, r0, #0x51
	bicne r0, r0, #0x1f
	bne _027E52B4
	ldrh r0, [r4, #0x3e]
	add r2, r0, #0xc
	ldrh r0, [r4, #0xf8]
	mul r0, r2, r0
	add r0, r0, #0x29
	bic r0, r0, #0x1f
_027E52B4:
	cmp r8, r0
	movlo r10, #6
_027E52BC:
	ldrh r0, [r4, #0xe6]
	cmp r0, #2
	bne _027E52F0
	add r0, r4, #0x100
	ldrh r0, [r0, #0xf6]
	mov r2, #1
	add r1, r1, #0x1000
	ldr r1, [r1, #0x54c]
	ldrh r1, [r1, #0x46]
	mov r1, r2, lsl r1
	mov r1, r1, asr #1
	ands r0, r0, r1
	moveq r10, #6
_027E52F0:
	cmp r10, #0
	beq _027E5318
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xe
	strh r1, [r0]
	strh r10, [r0, #2]
	mov r1, #0xa
	strh r1, [r0, #4]
	bl WMSP_ReturnResult2Wm9
	b _027E54D8
_027E5318:
	mov r1, #0
	ldr r0, [r4, #0xc]
	cmp r0, #0
	strne r1, [r4, #0xc]
	movne r1, #1
	cmp r1, #0
	beq _027E533C
	ldr r0, _027E54EC // =0x0000FFFF
	bl WMSP_CleanSendQueue
_027E533C:
	bl WMSP_InitSendQueue
	mov r0, r5
	mov r1, #0
	bl WMSP_SetMPParameterCore
	bl OS_DisableInterrupts
	mov r5, r0
	ldrh r2, [r4, #0]
	ldr r1, _027E54F0 // =0x0000FFF9
	add r1, r2, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #1
	bhi _027E54B4
	mov r2, #0
	strh r2, [r4, #0x84]
	strh r2, [r4, #0x5e]
	mov r1, #1
	strh r1, [r4, #0x60]
	strh r2, [r4, #0x88]
	strh r2, [r4, #0x9e]
	mov r0, #0x3c
	strh r0, [r4, #0xa0]
	str r2, [r4, #0x734]
	strh r2, [r4, #0x8a]
	strh r2, [r4, #0x8c]
	strh r2, [r4, #0x8e]
	strh r2, [r4, #0x90]
	strh r2, [r4, #0x66]
	str r9, [r4, #0x74]
	strh r8, [r4, #0x72]
	add r0, r9, r8
	str r0, [r4, #0x78]
	strh r2, [r4, #0x70]
	str r7, [r4, #0x7c]
	strh r6, [r4, #0x80]
	strh r2, [r4, #0x62]
	strh r2, [r4, #0x64]
	strh r2, [r4, #0x68]
	strh r2, [r4, #0x6a]
	ldr r0, _027E54EC // =0x0000FFFF
	strh r0, [r4, #0xbe]
	strh r1, [r4, #0xc0]
	bl OS_GetTick
	mov r2, #0
	orr r1, r1, #0
	orr r3, r0, #1
_027E53F4:
	add r0, r4, r2, lsl #3
	str r3, [r0, #0x738]
	str r1, [r0, #0x73c]
	add r2, r2, #1
	cmp r2, #0x10
	blt _027E53F4
	bl WMSP_SetThreadPriorityHigh
	mov r0, #0
	strh r0, [r4, #0xce]
	bl WMSP_SetVAlarm
	ldrh r0, [r4, #0]
	cmp r0, #8
	moveq r0, #0xa
	streqh r0, [r4]
	beq _027E543C
	cmp r0, #7
	moveq r0, #9
	streqh r0, [r4]
_027E543C:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xe
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #0xa
	strh r1, [r0, #4]
	bl WMSP_ReturnResult2Wm9
	mov r0, #1
	str r0, [r4, #0xc]
	mov r0, r5
	bl OS_RestoreInterrupts
	add r0, sp, #0
	mov r1, #1
	bl WMSP_WL_ParamSetNullKeyResponseMode
	mov r4, r0
	ldrh r0, [r4, #4]
	cmp r0, #0
	beq _027E54D8
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xe
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	ldr r1, _027E54F4 // =0x00000216
	strh r1, [r0, #4]
	ldrh r1, [r4, #4]
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	b _027E54D8
_027E54B4:
	bl OS_RestoreInterrupts
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0xe
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	mov r1, #0xa
	strh r1, [r0, #4]
	bl WMSP_ReturnResult2Wm9
_027E54D8:
	add sp, sp, #0x200
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_027E54E4: .word _027F8454
_027E54E8: .word 0x027F9454
_027E54EC: .word 0x0000FFFF
_027E54F0: .word 0x0000FFF9
_027E54F4: .word 0x00000216
	arm_func_end WMSP_StartMP

	arm_func_start WMSP_SetMPData
WMSP_SetMPData: // 0x027E54F8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	ldr r1, _027E5638 // =0x027F9454
	ldr r4, [r1, #0x550]
	add r2, r4, #0x100
	ldrh r5, [r2, #0x82]
	ldr r10, [r0, #4]
	ldr r1, [r0, #8]
	mov r1, r1, lsl #0x10
	mov r9, r1, lsr #0x10
	ldr r8, [r0, #0xc]
	ldr r1, [r0, #0x10]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #0x10]
	ldr r1, [r0, #0x14]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ldr r7, [r0, #0x18]
	ldr r11, [r0, #0x1c]
	ldrh r0, [r2, #0x88]
	cmp r0, #0
	movne r8, #1
	ldr r0, [r4, #0xc]
	cmp r0, #0
	moveq r6, #3
	beq _027E5594
	ands r0, r8, r5
	moveq r6, #0
	beq _027E5594
	str r10, [sp]
	str r9, [sp, #4]
	str r7, [sp, #8]
	str r11, [sp, #0xc]
	mov r0, r5
	ldr r2, [sp, #0x10]
	mov r3, r8
	bl WMSP_PutSendQueue
	mov r6, r0
_027E5594:
	cmp r6, #2
	beq _027E562C
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x81
	strh r1, [r0]
	strh r6, [r0, #2]
	mov r1, #0x14
	strh r1, [r0, #8]
	ldr r1, [sp, #0x10]
	strh r1, [r0, #0xa]
	strh r8, [r0, #0xc]
	cmp r6, #0xa
	andeq r1, r8, r5
	streqh r1, [r0, #0xe]
	movne r1, #0
	strneh r1, [r0, #0xe]
	mov r1, #0
	strh r1, [r0, #0x10]
	strh r9, [r0, #0x18]
	str r10, [r0, #0x14]
	str r7, [r0, #0x1c]
	str r11, [r0, #0x20]
	ldr r1, _027E563C // =0x0000FFFF
	strh r1, [r0, #0x1a]
	ldrh r2, [r4, #0x30]
	ldrh r3, [r4, #0x32]
	add r1, r4, #0x100
	ldrh r1, [r1, #0x88]
	cmp r1, #0
	moveq r1, r2
	movne r1, r3
	strh r1, [r0, #0x24]
	add r1, r4, #0x100
	ldrh r1, [r1, #0x88]
	cmp r1, #0
	movne r3, r2
	strh r3, [r0, #0x26]
	bl WMSP_ReturnResult2Wm9
_027E562C:
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E5638: .word 0x027F9454
_027E563C: .word 0x0000FFFF
	arm_func_end WMSP_SetMPData

	arm_func_start WmspError_9
WmspError_9: // 0x027E5640
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x10
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_9

	arm_func_start WMSP_EndMP
WMSP_EndMP: // 0x027E567C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x200
	ldr r0, _027E5790 // =0x027F9454
	ldr r4, [r0, #0x550]
	mov r6, #0
	ldrh r0, [r4, #0]
	cmp r0, #9
	beq _027E56C0
	cmp r0, #0xa
	beq _027E56C0
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x10
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E5784
_027E56C0:
	bl OS_DisableInterrupts
	mov r5, r0
	ldr r0, [r4, #0xc]
	cmp r0, #1
	moveq r6, #1
	mov r0, #0
	str r0, [r4, #0xc]
	bl WMSP_CancelVAlarm
	bl WMSP_SetThreadPriorityLow
	ldrh r0, [r4, #0]
	cmp r0, #0xa
	moveq r0, #8
	streqh r0, [r4]
	beq _027E5704
	cmp r0, #9
	moveq r0, #7
	streqh r0, [r4]
_027E5704:
	mov r0, r5
	bl OS_RestoreInterrupts
	add r0, sp, #0
	mov r1, #0
	bl WMSP_WL_ParamSetNullKeyResponseMode
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E5730
	ldr r0, _027E5794 // =0x00000216
	bl WmspError_9
	b _027E5784
_027E5730:
	add r0, sp, #0
	mov r1, #7
	bl WMSP_WL_MaClearData
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E5754
	mov r0, #0x104
	bl WmspError_9
	b _027E5784
_027E5754:
	mov r0, #0
	strh r0, [r4, #0x8a]
	cmp r6, #0
	beq _027E576C
	ldr r0, _027E5798 // =0x0000FFFF
	bl WMSP_CleanSendQueue
_027E576C:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x10
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E5784:
	add sp, sp, #0x200
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027E5790: .word 0x027F9454
_027E5794: .word 0x00000216
_027E5798: .word 0x0000FFFF
	arm_func_end WMSP_EndMP

	arm_func_start WMSP_StartDCF
WMSP_StartDCF: // 0x027E579C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, _027E5824 // =0x027F9454
	ldr r5, [r1, #0x550]
	ldr r8, [r0, #4]
	ldr r0, [r0, #8]
	mov r6, r0, lsl #0x10
	mov r7, r6, lsr #0x10
	bl OS_DisableInterrupts
	mov r4, r0
	str r8, [r5, #0xb0]
	strh r7, [r5, #0xb8]
	add r0, r8, r6, lsr #16
	str r0, [r5, #0xb4]
	mov r0, #0
	strh r0, [r5, #0xae]
	str r0, [r5, #0xa8]
	strh r0, [r5, #0xac]
	str r0, [r5, #0x18]
	mov r0, #0xb
	strh r0, [r5]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x11
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	mov r1, #0xe
	strh r1, [r0, #4]
	bl WMSP_ReturnResult2Wm9
	mov r0, #1
	str r0, [r5, #0x10]
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027E5824: .word 0x027F9454
	arm_func_end WMSP_StartDCF

	arm_func_start WMSP_SetDCFData
WMSP_SetDCFData: // 0x027E5828
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x234
	mov r5, r0
	ldr r0, _027E591C // =0x027F9454
	ldr r4, [r0, #0x550]
	add r0, r5, #4
	add r1, r4, #0xa2
	mov r2, #6
	bl MI_CpuCopy8
	ldr r0, [r5, #0xc]
	str r0, [r4, #0xa8]
	ldr r0, [r5, #0x10]
	strh r0, [r4, #0xac]
	mov r0, #1
	str r0, [r4, #0x18]
	mov r0, #0
	add r1, sp, #0
	mov r2, #0x30
	bl MIi_CpuClear16
	mov r0, #0
	strh r0, [sp]
	ldr r0, [r5, #0x10]
	strh r0, [sp, #6]
	add r0, r4, #0x100
	ldrh r0, [r0, #0xec]
	cmp r0, #2
	moveq r0, #0x14
	movne r0, #0xa
	strb r0, [sp, #0xe]
	add r0, r5, #4
	add r1, sp, #0x18
	mov r2, #6
	bl MI_CpuCopy8
	add r0, r4, #0xe0
	add r1, sp, #0x1e
	mov r2, #6
	bl MI_CpuCopy8
	ldr r0, [r5, #0xc]
	str r0, [sp, #0x2c]
	add r0, sp, #0x30
	add r1, sp, #0
	bl WMSP_WL_MaData
	mov r4, r0
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x12
	strh r1, [r0]
	ldrh r1, [r4, #4]
	cmp r1, #0
	moveq r1, #0
	movne r1, #1
	strh r1, [r0, #2]
	ldrh r1, [r4, #4]
	cmp r1, #0
	movne r1, #0x100
	strneh r1, [r0, #4]
	ldrneh r1, [r4, #4]
	strneh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #0x234
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E591C: .word 0x027F9454
	arm_func_end WMSP_SetDCFData

	arm_func_start WmspError_10
WmspError_10: // 0x027E5920
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x13
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_10

	arm_func_start WMSP_EndDCF
WMSP_EndDCF: // 0x027E595C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x200
	ldr r0, _027E59F8 // =0x027F9454
	ldr r4, [r0, #0x550]
	bl OS_DisableInterrupts
	ldrh r1, [r4, #0]
	cmp r1, #0xb
	beq _027E599C
	bl OS_RestoreInterrupts
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x13
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E59EC
_027E599C:
	mov r1, #0
	str r1, [r4, #0x10]
	mov r1, #8
	strh r1, [r4]
	bl OS_RestoreInterrupts
	add r0, sp, #0
	mov r1, #7
	bl WMSP_WL_MaClearData
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E59D4
	mov r0, #0x104
	bl WmspError_10
	b _027E59EC
_027E59D4:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x13
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E59EC:
	add sp, sp, #0x200
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E59F8: .word 0x027F9454
	arm_func_end WMSP_EndDCF

	arm_func_start WmspError_11
WmspError_11: // 0x027E59FC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x14
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_11

	arm_func_start WMSP_SetWEPKeyEx
WMSP_SetWEPKeyEx: // 0x027E5A38
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x204
	mov r5, r0
	ldr r0, _027E5B14 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldr r1, [r5, #4]
	add r0, r4, #0x100
	strh r1, [r0, #0x96]
	ldrh r0, [r0, #0x96]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _027E5A90
_027E5A68: // jump table
	b _027E5A78 // case 0
	b _027E5A84 // case 1
	b _027E5A84 // case 2
	b _027E5A84 // case 3
_027E5A78:
	mov r0, #0
	str r0, [r4, #0x198]
	b _027E5A98
_027E5A84:
	mov r0, #1
	str r0, [r4, #0x198]
	b _027E5A98
_027E5A90:
	mov r0, #0
	str r0, [r4, #0x198]
_027E5A98:
	ldr r0, [r4, #0x198]
	cmp r0, #1
	bne _027E5AB8
	ldr r0, [r5, #8]
	add r1, r4, #0x19c
	mov r2, #0x50
	bl MI_CpuCopy8
	b _027E5AC8
_027E5AB8:
	add r0, r4, #0x19c
	mov r1, #0
	mov r2, #0x50
	bl MI_CpuFill8
_027E5AC8:
	ldr r0, [r5, #0xc]
	strh r0, [r4, #0xc4]
	add r0, sp, #0
	ldrh r1, [r4, #0xc4]
	bl WMSP_WL_ParamSetWepKeyId
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E5AF0
	ldr r0, _027E5B18 // =0x00000207
	bl WmspError_11
_027E5AF0:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x27
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #0x204
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E5B14: .word 0x027F9454
_027E5B18: .word 0x00000207
	arm_func_end WMSP_SetWEPKeyEx

	arm_func_start WMSP_SetWEPKey
WMSP_SetWEPKey: // 0x027E5B1C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _027E5BCC // =0x027F9454
	ldr r3, [r1, #0x550]
	ldr r2, [r0, #4]
	add r1, r3, #0x100
	strh r2, [r1, #0x96]
	ldrh r1, [r1, #0x96]
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _027E5B70
_027E5B48: // jump table
	b _027E5B58 // case 0
	b _027E5B64 // case 1
	b _027E5B64 // case 2
	b _027E5B64 // case 3
_027E5B58:
	mov r1, #0
	str r1, [r3, #0x198]
	b _027E5B78
_027E5B64:
	mov r1, #1
	str r1, [r3, #0x198]
	b _027E5B78
_027E5B70:
	mov r1, #0
	str r1, [r3, #0x198]
_027E5B78:
	ldr r1, [r3, #0x198]
	cmp r1, #1
	bne _027E5B98
	ldr r0, [r0, #8]
	add r1, r3, #0x19c
	mov r2, #0x50
	bl MI_CpuCopy8
	b _027E5BA8
_027E5B98:
	add r0, r3, #0x19c
	mov r1, #0
	mov r2, #0x50
	bl MI_CpuFill8
_027E5BA8:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x14
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E5BCC: .word 0x027F9454
	arm_func_end WMSP_SetWEPKey

	arm_func_start WMSP_SetGameInfo
WMSP_SetGameInfo: // 0x027E5BD0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x280
	ldr r1, _027E5CBC // =0x027F9454
	ldr r4, [r1, #0x550]
	ldr r1, [r0, #4]
	str r1, [r4, #0xe8]
	ldr r1, [r0, #8]
	strh r1, [r4, #0xec]
	ldr r1, [r0, #0xc]
	str r1, [r4, #0xf0]
	ldr r1, [r0, #0x10]
	strh r1, [r4, #0xf4]
	ldr r0, [r0, #0x14]
	and r1, r0, #0xff
	ands r0, r1, #1
	movne r0, #1
	moveq r0, #0
	strh r0, [r4, #0xf6]
	ands r0, r1, #2
	movne r0, #1
	moveq r0, #0
	strh r0, [r4, #0xfa]
	ands r0, r1, #4
	movne r0, #1
	moveq r0, #0
	strh r0, [r4, #0xfc]
	ands r0, r1, #8
	movne r0, #1
	moveq r0, #0
	strh r0, [r4, #0xfe]
	add r0, sp, #0x200
	add r1, r4, #0xe8
	bl WMSP_CopyParentParam
	add r0, sp, #0
	ldrh r1, [r4, #0xec]
	add r1, r1, #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	add r2, sp, #0x200
	bl WMSP_WL_ParamSetGameInfo
	mov r4, r0
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x18
	strh r1, [r0]
	ldrh r1, [r4, #4]
	cmp r1, #0
	moveq r1, #0
	movne r1, #1
	strh r1, [r0, #2]
	ldrh r1, [r4, #4]
	cmp r1, #0
	ldrne r1, _027E5CC0 // =0x00000245
	strneh r1, [r0, #4]
	ldrneh r1, [r4, #4]
	strneh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #0x280
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E5CBC: .word 0x027F9454
_027E5CC0: .word 0x00000245
	arm_func_end WMSP_SetGameInfo

	arm_func_start WmspError_12
WmspError_12: // 0x027E5CC4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x19
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_12

	arm_func_start WMSP_SetBeaconTxRxInd
WMSP_SetBeaconTxRxInd: // 0x027E5D00
	stmdb sp!, {lr}
	sub sp, sp, #0x204
	mov r1, r0
	add r0, sp, #0
	ldr r1, [r1, #4]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl WMSP_WL_ParamSetBeaconSendRecvInd
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E5D38
	ldr r0, _027E5D5C // =0x00000215
	bl WmspError_12
	b _027E5D50
_027E5D38:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x19
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E5D50:
	add sp, sp, #0x204
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E5D5C: .word 0x00000215
	arm_func_end WMSP_SetBeaconTxRxInd

	arm_func_start WMSP_StartTestMode
WMSP_StartTestMode: // 0x027E5D60
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x1a
	strh r1, [r0]
	mov r1, #4
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WMSP_StartTestMode

	arm_func_start WMSP_StopTestMode
WMSP_StopTestMode: // 0x027E5D8C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x1b
	strh r1, [r0]
	mov r1, #4
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WMSP_StopTestMode

	arm_func_start WmspError_13
WmspError_13: // 0x027E5DB8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x1d
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_13

	arm_func_start WMSP_SetLifeTime
WMSP_SetLifeTime: // 0x027E5DF4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x204
	mov r3, r0
	ldr r0, _027E5F04 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldr r0, [r3, #0x10]
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	add r0, sp, #0
	ldr r1, [r3, #4]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ldr r2, [r3, #8]
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	ldr r3, [r3, #0xc]
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	bl WMSP_WL_ParamSetLifeTime
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E5E58
	ldr r0, _027E5F08 // =0x00000211
	bl WmspError_13
	b _027E5EF8
_027E5E58:
	ldr r0, _027E5F0C // =0x0000FFFF
	cmp r5, r0
	beq _027E5EAC
	cmp r5, #0
	moveq r1, #1
	moveq r0, #0
	beq _027E5EA0
	mov r0, #0x64
	mul r3, r5, r0
	mov r2, r3, asr #0x1f
	mov r1, #0
	ldr r0, _027E5F10 // =0x000082EA
	umull ip, r5, r3, r0
	mla r5, r3, r1, r5
	mla r5, r2, r0, r5
	mov r0, r5, lsr #6
	mov r1, ip, lsr #6
	orr r1, r1, r5, lsl #26
_027E5EA0:
	str r1, [r4, #0x7b8]
	str r0, [r4, #0x7bc]
	b _027E5EB8
_027E5EAC:
	mov r0, #0
	str r0, [r4, #0x7b8]
	str r0, [r4, #0x7bc]
_027E5EB8:
	bl OS_GetTick
	mov r2, #0
	orr r1, r1, #0
	orr r3, r0, #1
_027E5EC8:
	add r0, r4, r2, lsl #3
	str r3, [r0, #0x738]
	str r1, [r0, #0x73c]
	add r2, r2, #1
	cmp r2, #0x10
	blt _027E5EC8
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x1d
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E5EF8:
	add sp, sp, #0x204
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E5F04: .word 0x027F9454
_027E5F08: .word 0x00000211
_027E5F0C: .word 0x0000FFFF
_027E5F10: .word 0x000082EA
	arm_func_end WMSP_SetLifeTime

	arm_func_start WmspError_14
WmspError_14: // 0x027E5F14
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x1e
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_14

	arm_func_start WMSP_MeasureChannel
WMSP_MeasureChannel: // 0x027E5F50
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x214
	mov r8, r0
	ldr r0, _027E60F8 // =0x027F9454
	ldr r4, [r0, #0x550]
	add r7, sp, #0x14
	ldrh r0, [r4, #0]
	cmp r0, #2
	beq _027E5F90
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x1e
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E60EC
_027E5F90:
	mov r0, r7
	bl WMSP_WL_DevGetStationState
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E5FB0
	mov r0, #0x308
	bl WmspError_14
	b _027E60EC
_027E5FB0:
	ldrh r1, [r0, #6]
	mov r0, #2
	strh r0, [r4, #0xe6]
	cmp r1, #0x10
	bne _027E6034
	mov r0, #0xa
	mov r1, r7
	bl WMSP_SetAllParams
	cmp r0, #0
	beq _027E60EC
	mov r0, r7
	bl WMSP_WL_DevClass1
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E5FF8
	ldr r0, _027E60FC // =0x00000303
	bl WmspError_14
	b _027E60EC
_027E5FF8:
	mov r0, #3
	strh r0, [r4]
	mov r0, r7
	mov r1, #1
	mov r2, #0
	mov r3, r1
	bl WMSP_WL_MlmePowerManagement
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E602C
	mov r0, #1
	bl WmspError_14
	b _027E60EC
_027E602C:
	mov r0, #1
	strh r0, [r4, #0xc6]
_027E6034:
	ldrh r6, [r8, #2]
	ldrh r5, [r8, #4]
	ldrh r9, [r8, #6]
	ldrh r8, [r8, #8]
	add r0, sp, #4
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	strb r9, [sp, #4]
	add r0, sp, #4
	str r0, [sp]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r8
	bl WMSP_WL_MlmeMeasureChannel
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E608C
	mov r0, #0xa
	bl WmspError_14
	b _027E60EC
_027E608C:
	ldrh r1, [r0, #8]
	and r0, r1, #0xff
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r0, r1, lsl #8
	mov r6, r0, lsr #0x10
	mov r0, r7
	bl WMSP_WL_DevIdle
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E60C4
	ldr r0, _027E6100 // =0x00000302
	bl WmspError_14
	b _027E60EC
_027E60C4:
	mov r0, #2
	strh r0, [r4]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x1e
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	strh r5, [r0, #8]
	strh r6, [r0, #0xa]
	bl WMSP_ReturnResult2Wm9
_027E60EC:
	add sp, sp, #0x214
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027E60F8: .word 0x027F9454
_027E60FC: .word 0x00000303
_027E6100: .word 0x00000302
	arm_func_end WMSP_MeasureChannel

	arm_func_start WmspError_15
WmspError_15: // 0x027E6104
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x1f
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_15

	arm_func_start WMSP_InitWirelessCounter
WMSP_InitWirelessCounter: // 0x027E6140
	stmdb sp!, {lr}
	sub sp, sp, #0x204
	add r0, sp, #0
	bl WMSP_WL_DevSetInitializeWirelessCounter
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E6168
	ldr r0, _027E618C // =0x00000305
	bl WmspError_15
	b _027E6180
_027E6168:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x1f
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E6180:
	add sp, sp, #0x204
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E618C: .word 0x00000305
	arm_func_end WMSP_InitWirelessCounter

	arm_func_start WmspError_16
WmspError_16: // 0x027E6190
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x20
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_16

	arm_func_start WMSP_GetWirelessCounter
WMSP_GetWirelessCounter: // 0x027E61CC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x204
	add r0, sp, #0
	bl WMSP_WL_DevGetWirelessCounter
	mov r5, r0
	ldrh r1, [r5, #4]
	cmp r1, #0
	beq _027E61F8
	ldr r0, _027E6234 // =0x00000307
	bl WmspError_16
	b _027E6228
_027E61F8:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r4, r0
	mov r0, #0x20
	strh r0, [r4]
	mov r0, #0
	strh r0, [r4, #2]
	add r0, r5, #8
	add r1, r4, #8
	mov r2, #0xb4
	bl MIi_CpuCopy16
	mov r0, r4
	bl WMSP_ReturnResult2Wm9
_027E6228:
	add sp, sp, #0x204
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E6234: .word 0x00000307
	arm_func_end WMSP_GetWirelessCounter

	arm_func_start WmspFromVAlarmToWmspThread
WmspFromVAlarmToWmspThread: // 0x027E6238
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r5, _027E62E8 // =_027F8454
	ldr r0, _027E62EC // =0x027F9454
	ldr r4, [r0, #0x550]
	bl OS_DisableInterrupts
	ldrh r1, [r4, #0xce]
	cmp r1, #1
	bne _027E6264
	bl OS_RestoreInterrupts
	b _027E62DC
_027E6264:
	mov r1, #1
	strh r1, [r4, #0xce]
	bl OS_RestoreInterrupts
	bl WMSP_GetInternalRequestBuf
	movs r1, r0
	moveq r0, #0
	beq _027E6294
	mov r0, #0x1c
	str r0, [r1]
	add r0, r5, #0x88
	mov r2, #0
	bl OS_SendMessage
_027E6294:
	cmp r0, #0
	bne _027E62DC
	mov r0, #0
	strh r0, [r4, #0xce]
	add r0, r5, #0x1000
	ldr r0, [r0, #0x54c]
	cmp r0, #0
	beq _027E62DC
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	mov r1, #0x16
	strh r1, [r0, #4]
	mov r1, #0x1c
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
_027E62DC:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E62E8: .word _027F8454
_027E62EC: .word 0x027F9454
	arm_func_end WmspFromVAlarmToWmspThread

	arm_func_start WmspParentVAlarmMP
WmspParentVAlarmMP: // 0x027E62F0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027E632C // =0x027F9454
	ldr r0, [r0, #0x550]
	ldr r0, [r0, #0xc]
	cmp r0, #1
	bne _027E6320
	mov r0, #0xd1
	ldr r1, _027E6330 // =WmspParentAdjustVSync
	mov r2, #3
	bl WmspSetVAlarm
	bl WmspFromVAlarmToWmspThread
_027E6320:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E632C: .word 0x027F9454
_027E6330: .word WmspParentAdjustVSync
	arm_func_end WmspParentVAlarmMP

	arm_func_start WmspParentAdjustVSync
WmspParentAdjustVSync: // 0x027E6334
	stmdb sp!, {r4, lr}
	ldr r0, _027E6394 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldrh r0, [r4, #0xdc]
	cmp r0, #0x3c
	blo _027E6370
	ldr r1, _027E6398 // =0x04000006
	ldrh r0, [r1, #0]
	cmp r0, #0xd1
	blt _027E6378
	cmp r0, #0xd4
	strlth r0, [r1]
	movlt r0, #0
	strlth r0, [r4, #0xdc]
	b _027E6378
_027E6370:
	add r0, r0, #1
	strh r0, [r4, #0xdc]
_027E6378:
	bl WmspSetVTSF
	ldrsh r0, [r4, #0x40]
	ldr r1, _027E639C // =WmspParentVAlarmMP
	mov r2, #5
	bl WmspSetVAlarm
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E6394: .word 0x027F9454
_027E6398: .word 0x04000006
_027E639C: .word WmspParentVAlarmMP
	arm_func_end WmspParentAdjustVSync

	arm_func_start WmspChildVAlarmMP
WmspChildVAlarmMP: // 0x027E63A0
	stmdb sp!, {r4, lr}
	ldr r0, _027E6498 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldr r0, [r4, #0xc]
	cmp r0, #1
	bne _027E6490
	mov r0, #0xc8
	ldr r1, _027E649C // =WmspChildAdjustVSync1
	mov r2, #1
	bl WmspSetVAlarm
	ldr r2, [r4, #0x7b8]
	ldr r1, [r4, #0x7bc]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	beq _027E648C
	bl OS_GetTick
	mov r2, #0
	orr r3, r1, #0
	orr ip, r0, #1
	ldr r1, [r4, #0x738]
	ldr r0, [r4, #0x73c]
	cmp r0, r2
	cmpeq r1, r2
	beq _027E648C
	subs ip, ip, r1
	sbc r3, r3, r0
	ldr r1, [r4, #0x7b8]
	ldr r0, [r4, #0x7bc]
	cmp r3, r0
	cmpeq ip, r1
	bls _027E648C
	str r2, [r4, #0x738]
	str r2, [r4, #0x73c]
	bl WMSP_GetInternalRequestBuf
	movs r1, r0
	moveq r0, #0
	beq _027E6458
	mov r0, #0x25
	str r0, [r1]
	mov r2, #0
	str r2, [r1, #4]
	ldr r0, _027E64A0 // =0x00008001
	str r0, [r1, #8]
	ldr r0, _027E64A4 // =byte_27F84DC
	bl OS_SendMessage
_027E6458:
	cmp r0, #0
	bne _027E6490
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x80
	strh r1, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	mov r1, #0x16
	strh r1, [r0, #4]
	mov r1, #0x25
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	b _027E6490
_027E648C:
	bl WmspFromVAlarmToWmspThread
_027E6490:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E6498: .word 0x027F9454
_027E649C: .word WmspChildAdjustVSync1
_027E64A0: .word 0x00008001
_027E64A4: .word byte_27F84DC
	arm_func_end WmspChildVAlarmMP

	arm_func_start WmspChildAdjustVSync2
WmspChildAdjustVSync2: // 0x027E64A8
	stmdb sp!, {r4, lr}
	ldr r0, _027E64E0 // =0x027F9454
	ldr r4, [r0, #0x550]
	bl WmspExpendVRemain
	ldr r0, [r4, #0xd8]
	cmp r0, #0x7f
	movhs r0, #0
	strhs r0, [r4, #0x1c]
	ldrsh r0, [r4, #0x42]
	ldr r1, _027E64E4 // =WmspChildVAlarmMP
	mov r2, #4
	bl WmspSetVAlarm
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E64E0: .word 0x027F9454
_027E64E4: .word WmspChildVAlarmMP
	arm_func_end WmspChildAdjustVSync2

	arm_func_start WmspChildAdjustVSync1
WmspChildAdjustVSync1: // 0x027E64E8
	stmdb sp!, {r4, lr}
	ldr r0, _027E6558 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldr r0, _027E655C // =0x0380FFF0
	ldrh r0, [r0, #0]
	str r0, [r4, #0xd0]
	ldr r1, [r4, #0xd0]
	ldr r0, [r4, #0xd4]
	cmp r0, r1
	beq _027E6518
	str r1, [r4, #0xd4]
	bl WmspCalcVRemain
_027E6518:
	ldr r0, [r4, #0xd8]
	cmp r0, #0x7f
	bls _027E6538
	mov r0, #0xd0
	ldr r1, _027E6560 // =WmspChildAdjustVSync2
	mov r2, #2
	bl WmspSetVAlarm
	b _027E6550
_027E6538:
	mov r0, #1
	str r0, [r4, #0x1c]
	ldrsh r0, [r4, #0x42]
	ldr r1, _027E6564 // =WmspChildVAlarmMP
	mov r2, #4
	bl WmspSetVAlarm
_027E6550:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E6558: .word 0x027F9454
_027E655C: .word 0x0380FFF0
_027E6560: .word WmspChildAdjustVSync2
_027E6564: .word WmspChildVAlarmMP
	arm_func_end WmspChildAdjustVSync1

	arm_func_start WmspExpendVRemain
WmspExpendVRemain: // 0x027E6568
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027E65F4 // =0x027F9454
	ldr ip, [r0, #0x550]
	ldr r0, _027E65F8 // =0x04000006
	ldrh r3, [r0, #0]
	cmp r3, #0xd0
	blt _027E65E8
	cmp r3, #0xd4
	bge _027E65E8
	ldr r2, [ip, #0xd8]
	cmp r2, #0x7f
	blo _027E65E8
	mov lr, #1
	mov r0, #0x3f
	b _027E65BC
_027E65A8:
	mul r1, lr, r0
	add r1, r1, #0x7f
	cmp r2, r1
	blo _027E65C4
	add lr, lr, #1
_027E65BC:
	cmp lr, #7
	blt _027E65A8
_027E65C4:
	rsb r0, lr, #1
	add r1, r3, r0
	ldr r0, _027E65F8 // =0x04000006
	strh r1, [r0]
	ldr r1, [ip, #0xd8]
	mov r0, #0x3f
	mul r0, lr, r0
	sub r0, r1, r0
	str r0, [ip, #0xd8]
_027E65E8:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E65F4: .word 0x027F9454
_027E65F8: .word 0x04000006
	arm_func_end WmspExpendVRemain

	arm_func_start WmspCalcVRemain
WmspCalcVRemain: // 0x027E65FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027E66DC // =0x027F9454
	ldr r0, [r0, #0x550]
	ldr r1, [r0, #0xd0]
	mov r1, r1, lsl #6
	str r1, [r0, #0xd0]
	ldr r3, _027E66E0 // =0x048080F8
	ldrh r2, [r3, #0]
	ldr r1, _027E66E4 // =0x048080FA
	ldrh ip, [r1]
	ldrh r3, [r3, #0]
	cmp r2, r3
	ldrhih ip, [r1]
	orr ip, r3, ip, lsl #16
	ldr r1, _027E66E8 // =0x04000006
	ldrh r3, [r1, #0]
	ldr r2, _027E66EC // =0x003FFFC0
	and ip, ip, r2
	ldr r1, _027E66F0 // =0x00000107
	sub r3, r1, r3
	mov r1, #0x7f
	mul r1, r3, r1
	add r1, r1, ip, lsl #1
	and ip, r2, r1, lsr #1
	ldr r1, [r0, #0xd0]
	cmp r1, ip
	movhi r1, #0
	strhi r1, [r0, #0xd8]
	bhi _027E66D0
	mov lr, #1
	add r3, r0, #0xd0
	ldr r1, _027E66F4 // =0x0000414B
	b _027E66C0
_027E6684:
	ldr r2, [r3, #0]
	add r2, r2, r1
	str r2, [r3]
	ldr r2, [r0, #0xd0]
	cmp r2, ip
	bls _027E66BC
	sub r1, r2, ip
	str r1, [r0, #0xd8]
	ldr r2, [r0, #0xd8]
	ldr r1, _027E66F8 // =0x0000400E
	cmp r2, r1
	movhi r1, #0
	strhi r1, [r0, #0xd8]
	b _027E66D0
_027E66BC:
	add lr, lr, #1
_027E66C0:
	cmp lr, #0x1e
	blt _027E6684
	mov r1, #0
	str r1, [r0, #0xd8]
_027E66D0:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E66DC: .word 0x027F9454
_027E66E0: .word 0x048080F8
_027E66E4: .word 0x048080FA
_027E66E8: .word 0x04000006
_027E66EC: .word 0x003FFFC0
_027E66F0: .word 0x00000107
_027E66F4: .word 0x0000414B
_027E66F8: .word 0x0000400E
	arm_func_end WmspCalcVRemain

	arm_func_start WmspSetVTSF
WmspSetVTSF: // 0x027E66FC
	ldr r0, _027E6744 // =0x04000006
	ldrh ip, [r0]
	ldr r2, _027E6748 // =0x048080F8
	ldrh r1, [r2, #0]
	ldr r0, _027E674C // =0x048080FA
	ldrh r3, [r0, #0]
	ldrh r2, [r2, #0]
	cmp r1, r2
	ldrhih r3, [r0, #0]
	orr r0, r2, r3, lsl #16
	mov r1, r0, lsl #1
	mov r0, #0x7f
	mul r0, ip, r0
	sub r0, r1, r0
	mov r1, r0, lsr #7
	ldr r0, _027E6750 // =0x0380FFF0
	strh r1, [r0]
	bx lr
	.align 2, 0
_027E6744: .word 0x04000006
_027E6748: .word 0x048080F8
_027E674C: .word 0x048080FA
_027E6750: .word 0x0380FFF0
	arm_func_end WmspSetVTSF

	arm_func_start WmspSetVAlarm
WmspSetVAlarm: // 0x027E6754
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov ip, r0
	mov r3, r1
	str r2, [sp]
	ldr r0, _027E6784 // =0x0380BDC8
	mov r1, ip
	ldr r2, _027E6788 // =0x00000107
	bl OS_SetVAlarm
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E6784: .word 0x0380BDC8
_027E6788: .word 0x00000107
	arm_func_end WmspSetVAlarm

	arm_func_start WMSP_SetVAlarm
WMSP_SetVAlarm: // 0x027E678C
	stmdb sp!, {r4, lr}
	ldr r0, _027E680C // =0x027F9454
	ldr r4, [r0, #0x550]
	ldr r0, _027E6810 // =0x0380BDC8
	ldrh r1, [r4, #0xe6]
	cmp r1, #1
	bne _027E67CC
	ldr r1, [r0, #0]
	cmp r1, #0
	beq _027E67B8
	bl OS_CancelVAlarm
_027E67B8:
	mov r0, #0xd1
	ldr r1, _027E6814 // =WmspParentAdjustVSync
	mov r2, #3
	bl WmspSetVAlarm
	b _027E6804
_027E67CC:
	cmp r1, #2
	bne _027E6804
	mov r1, #0
	str r1, [r4, #0x1c]
	ldr r1, [r0, #0]
	cmp r1, #0
	beq _027E67EC
	bl OS_CancelVAlarm
_027E67EC:
	mov r0, #0xc8
	ldr r1, _027E6818 // =WmspChildAdjustVSync1
	mov r2, #1
	bl WmspSetVAlarm
	mov r0, #0
	str r0, [r4, #0xd8]
_027E6804:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E680C: .word 0x027F9454
_027E6810: .word 0x0380BDC8
_027E6814: .word WmspParentAdjustVSync
_027E6818: .word WmspChildAdjustVSync1
	arm_func_end WMSP_SetVAlarm

	arm_func_start WMSP_CancelVAlarm
WMSP_CancelVAlarm: // 0x027E681C
	ldr r0, _027E6828 // =0x0380BDC8
	ldr ip, _027E682C // =OS_CancelVAlarm
	bx ip
	.align 2, 0
_027E6828: .word 0x0380BDC8
_027E682C: .word OS_CancelVAlarm
	arm_func_end WMSP_CancelVAlarm

	arm_func_start WMSP_InitVAlarm
WMSP_InitVAlarm: // 0x027E6830
	ldr r0, _027E683C // =0x0380BDC8
	ldr ip, _027E6840 // =OS_CreateVAlarm
	bx ip
	.align 2, 0
_027E683C: .word 0x0380BDC8
_027E6840: .word OS_CreateVAlarm
	arm_func_end WMSP_InitVAlarm

	arm_func_start WMSP_KickNextMP_Resume
WMSP_KickNextMP_Resume: // 0x027E6844
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _027E687C // =0x027F9454
	ldr r1, [r1, #0x550]
	ldrh r1, [r1, #0]
	cmp r1, #9
	bne _027E6870
	ldr r0, [r0, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WMSP_ResumeMaMP
_027E6870:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E687C: .word 0x027F9454
	arm_func_end WMSP_KickNextMP_Resume

	arm_func_start WMSP_KickNextMP_Child
WMSP_KickNextMP_Child: // 0x027E6880
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027E68AC // =0x027F9454
	ldr r0, [r0, #0x550]
	ldrh r0, [r0, #0]
	cmp r0, #0xa
	bne _027E68A0
	bl WMSP_SendMaKeyData
_027E68A0:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E68AC: .word 0x027F9454
	arm_func_end WMSP_KickNextMP_Child

	arm_func_start WMSP_KickNextMP_Parent
WMSP_KickNextMP_Parent: // 0x027E68B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _027E68E8 // =0x027F9454
	ldr r1, [r1, #0x550]
	ldrh r1, [r1, #0]
	cmp r1, #9
	bne _027E68DC
	ldr r0, [r0, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WMSP_SendMaMP
_027E68DC:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E68E8: .word 0x027F9454
	arm_func_end WMSP_KickNextMP_Parent

	arm_func_start WMSP_VAlarmSetMPData
WMSP_VAlarmSetMPData: // 0x027E68EC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _027E6A8C // =0x027F9454
	ldr r4, [r0, #0x550]
	mov r0, #0
	strh r0, [r4, #0xce]
	mov r0, #1
	strh r0, [r4, #0x88]
	ldrh r0, [r4, #0xc0]
	sub r0, r0, #1
	strh r0, [r4, #0xc0]
	ldrh r0, [r4, #0xc0]
	cmp r0, #0
	bne _027E695C
	ldrh r1, [r4, #0xbe]
	ldr r0, _027E6A90 // =0x0000FFFF
	cmp r1, r0
	moveq r0, #4
	streqh r0, [r4, #0xbe]
	ldrh r0, [r4, #0xbe]
	and r0, r0, #0xff
	bl WMSP_AddRssiToList
	bl WMSP_GetAverageLinkLevel
	strh r0, [r4, #0xbc]
	ldr r0, _027E6A90 // =0x0000FFFF
	strh r0, [r4, #0xbe]
	mov r0, #1
	strh r0, [r4, #0xc0]
_027E695C:
	ldrh r0, [r4, #0]
	cmp r0, #9
	bne _027E6A4C
	bl OS_DisableInterrupts
	add r1, r4, #0x100
	ldrh r1, [r1, #0x82]
	cmp r1, #0
	bne _027E698C
	mov r1, #0
	strh r1, [r4, #0x62]
	bl OS_RestoreInterrupts
	b _027E6A80
_027E698C:
	mov r3, #1
	ldrsh r2, [r4, #0x62]
	cmp r2, #0
	ble _027E69A8
	ldrsh r1, [r4, #0x64]
	cmp r1, #0
	movgt r3, #0
_027E69A8:
	cmp r2, #0
	movlt r1, #0
	strlth r1, [r4, #0x62]
	ldrsh r2, [r4, #0x62]
	ldrsh r1, [r4, #0x5a]
	add r1, r2, r1
	strh r1, [r4, #0x62]
	ldrsh r1, [r4, #0x62]
	cmp r1, #0x100
	movgt r1, #0x100
	strgth r1, [r4, #0x62]
	ldrh r1, [r4, #0x5c]
	strh r1, [r4, #0x64]
	cmp r3, #0
	beq _027E6A00
	ldrsh r1, [r4, #0x62]
	cmp r1, #0
	ble _027E6A00
	ldrsh r1, [r4, #0x64]
	cmp r1, #0
	movgt r5, #1
	bgt _027E6A04
_027E6A00:
	mov r5, #0
_027E6A04:
	bl OS_RestoreInterrupts
	cmp r5, #0
	beq _027E6A18
	ldr r0, _027E6A90 // =0x0000FFFF
	bl WMSP_SendMaMP
_027E6A18:
	ldrh r0, [r4, #0x92]
	cmp r0, #1
	bne _027E6A80
	ldrh r0, [r4, #0xa0]
	sub r0, r0, #1
	strh r0, [r4, #0xa0]
	ldrh r0, [r4, #0xa0]
	cmp r0, #0
	moveq r0, #1
	streqh r0, [r4, #0x9e]
	moveq r0, #0x3c
	streqh r0, [r4, #0xa0]
	b _027E6A80
_027E6A4C:
	cmp r0, #0xa
	bne _027E6A80
	mov r5, #0
	bl OS_DisableInterrupts
	ldr r1, [r4, #0x734]
	cmp r1, #1
	movne r5, #1
	movne r1, #0
	strneh r1, [r4, #0x60]
	bl OS_RestoreInterrupts
	cmp r5, #1
	bne _027E6A80
	bl WMSP_SendMaKeyData
_027E6A80:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E6A8C: .word 0x027F9454
_027E6A90: .word 0x0000FFFF
	arm_func_end WMSP_VAlarmSetMPData

	arm_func_start WmspGetTmptt
WmspGetTmptt: // 0x027E6A94
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r3
	ands r0, r5, #0x8000
	ldrne r0, _027E6B38 // =0x00007FFF
	andne r5, r5, r0
	addeq r0, r5, #0x1c
	moveq r0, r0, lsl #2
	addeq r5, r0, #0x66
	mov r0, r2
	bl MATH_CountPopulation
	add r1, r6, #0x22
	mov r1, r1, lsl #2
	add r1, r1, #0x60
	mul r0, r5, r0
	add r0, r0, #0x388
	add r3, r1, r0
	ldr r0, _027E6B3C // =0x04000006
	ldrh r1, [r0, #0]
	sub r0, r4, #2
	subs r4, r0, r1
	bpl _027E6AFC
	ldr r0, _027E6B40 // =0x00000107
_027E6AF4:
	adds r4, r4, r0
	bmi _027E6AF4
_027E6AFC:
	mov r0, #0x7f
	mul r2, r4, r0
	ldr r1, _027E6B44 // =0x66666667
	smull r0, r4, r1, r2
	mov r4, r4, asr #3
	mov r0, r2, lsr #0x1f
	add r4, r0, r4
	mov r0, #0xa
	mul r0, r4, r0
	cmp r0, r3
	movlo r4, #0
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027E6B38: .word 0x00007FFF
_027E6B3C: .word 0x04000006
_027E6B40: .word 0x00000107
_027E6B44: .word 0x66666667
	arm_func_end WmspGetTmptt

	arm_func_start WMSP_ParsePortPacket
WMSP_ParsePortPacket: // 0x027E6B48
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	str r0, [sp]
	mov r10, r2
	movs r9, r3
	ldr r0, [sp, #0x60]
	str r0, [sp, #0x60]
	ldr r0, _027E6DDC // =0x027F9454
	ldr r8, [r0, #0x550]
	addeq sp, sp, #0x2c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldrh r0, [r8, #0x3e]
	cmp r9, r0
	addhi sp, sp, #0x2c
	ldmhiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addhi sp, sp, #0x10
	bxhi lr
	add r0, r8, #0x100
	ldrh r1, [r0, #0x88]
	ldr r0, [sp]
	cmp r0, r1
	addeq sp, sp, #0x2c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addeq sp, sp, #0x10
	bxeq lr
	cmp r0, #0x10
	addhs sp, sp, #0x2c
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addhs sp, sp, #0x10
	bxhs lr
	ands r0, r9, #1
	addne sp, sp, #0x2c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addne sp, sp, #0x10
	bxne lr
	mov r0, #1
	str r0, [sp, #4]
	cmp r9, #0
	addle sp, sp, #0x2c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addle sp, sp, #0x10
	bxle lr
	add r1, r8, #0x1f8
	ldr r0, [sp]
	add r11, r1, r0, lsl #4
	mov r4, #0
	mov r0, #0x200
	str r0, [sp, #0xc]
	ldr r0, [sp, #4]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	mov r0, #2
	str r0, [sp, #0x18]
	mov r0, #0x82
	str r0, [sp, #0x20]
	mov r0, #0x15
	str r0, [sp, #0x24]
	ldr r0, [sp, #4]
	str r0, [sp, #0x1c]
_027E6C40:
	ldr r5, _027E6DE0 // =0x0000FFFF
	ldr r0, [sp, #4]
	cmp r0, #1
	streq r4, [sp, #4]
	addeq r0, sp, #0x54
	movne r0, r10
	addne r10, r10, #2
	subne r9, r9, #2
	ldrh r1, [r0, #0]
	and r0, r1, #0xff
	movs r7, r0, lsl #1
	ldreq r7, [sp, #0xc]
	ands r0, r1, #0x1000
	ldrne r2, [sp, #0x10]
	moveq r2, r4
	ands r0, r1, #0x800
	ldrne r3, [sp, #0x14]
	moveq r3, r4
	cmp r2, #0
	ldrne r6, [sp, #0x18]
	moveq r6, r4
	cmp r3, #0
	ldrne r0, [sp, #0x18]
	moveq r0, r4
	add r0, r7, r0
	add r0, r0, r6
	subs r9, r9, r0
	addmi sp, sp, #0x2c
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addmi sp, sp, #0x10
	bxmi lr
	and r1, r1, #0xf00
	mov r1, r1, lsl #8
	mov r6, r1, lsr #0x10
	str r10, [sp, #8]
	add r1, r10, r7
	add r10, r10, r0
	cmp r3, #1
	bne _027E6D1C
	and r0, r6, #7
	mov r3, r0, lsl #1
	add r0, r11, r0, lsl #1
	ldrh ip, [r11, r3]
	ldrh r5, [r1], #2
	ands r3, ip, #1
	movne r3, r5, lsl #1
	strneh r3, [r0]
	bne _027E6D1C
	mov r5, r5, lsl #1
	sub r3, ip, r5
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	cmp r3, #0x100
	blo _027E6DC4
	strh r5, [r0]
_027E6D1C:
	cmp r2, #1
	bne _027E6D40
	ldrh r2, [r1, #0]
	add r0, r8, #0x100
	ldrh r1, [r0, #0x88]
	ldr r0, [sp, #0x1c]
	mov r0, r0, lsl r1
	ands r0, r2, r0
	beq _027E6DC4
_027E6D40:
	cmp r7, #0
	ble _027E6DC4
	bl WMSP_GetBuffer4Callback2Wm9
	ldr r1, [sp, #0x20]
	strh r1, [r0]
	strh r4, [r0, #2]
	ldr r1, [sp, #0x24]
	strh r1, [r0, #4]
	strh r6, [r0, #6]
	ldr r1, [sp, #0x60]
	str r1, [r0, #8]
	ldr r1, [sp, #8]
	str r1, [r0, #0xc]
	strh r7, [r0, #0x10]
	ldr r1, [sp]
	strh r1, [r0, #0x12]
	add r1, r8, #0x100
	ldrh r2, [r1, #0x88]
	strh r2, [r0, #0x20]
	strh r5, [r0, #0x1a]
	ldrh r2, [r8, #0x30]
	ldrh r3, [r8, #0x32]
	ldrh r1, [r1, #0x88]
	cmp r1, #0
	moveq r1, r2
	movne r1, r3
	strh r1, [r0, #0x40]
	add r1, r8, #0x100
	ldrh r1, [r1, #0x88]
	cmp r1, #0
	movne r3, r2
	strh r3, [r0, #0x42]
	bl WMSP_ReturnResult2Wm9
_027E6DC4:
	cmp r9, #0
	bgt _027E6C40
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_027E6DDC: .word 0x027F9454
_027E6DE0: .word 0x0000FFFF
	arm_func_end WMSP_ParsePortPacket

	arm_func_start WMSP_CleanSendQueue
WMSP_CleanSendQueue: // 0x027E6DE4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r1, _027E6FE4 // =0x027F9454
	ldr r6, [r1, #0x550]
	add r9, r6, #0x2f8
	mvn r1, r0
	add r0, r6, #0x100
	ldrh r0, [r0, #0x82]
	and r0, r1, r0
	str r0, [sp, #8]
	ldr r0, _027E6FE8 // =0x0000071C
	add r0, r6, r0
	bl OS_LockMutex
	mov r0, #0
	str r0, [sp]
	ldr r0, _027E6FEC // =0x0000070C
	add r0, r6, r0
	str r0, [sp, #0xc]
	mov r0, #0x81
	str r0, [sp, #0x14]
	ldr r0, [sp]
	str r0, [sp, #0x18]
	mov r0, #0x14
	str r0, [sp, #0x1c]
	ldr r4, _027E6FF0 // =0x0000FFFF
	ldr r0, [sp]
	str r0, [sp, #0x10]
_027E6E50:
	ldr r0, [sp, #0x10]
	str r0, [sp, #4]
	ldr r5, [sp, #0xc]
_027E6E5C:
	mov r11, r5
	mov r8, r4
	ldrh r10, [r5, #0]
	cmp r10, r4
	beq _027E6FA0
_027E6E70:
	add r7, r9, r10, lsl #5
	ldrh r1, [r7, #6]
	ldr r0, [sp, #8]
	and r0, r1, r0
	strh r0, [r7, #6]
	ldrh r1, [r7, #0xa]
	ldr r0, [sp, #8]
	and r0, r1, r0
	strh r0, [r7, #0xa]
	ldrh r0, [r7, #6]
	cmp r0, #0
	bne _027E6F78
	bl WMSP_GetBuffer4Callback2Wm9
	ldr r1, [sp, #0x14]
	strh r1, [r0]
	ldr r1, [sp, #0x18]
	strh r1, [r0, #2]
	ldr r1, [sp, #0x1c]
	strh r1, [r0, #8]
	ldrh r1, [r7, #2]
	strh r1, [r0, #0xa]
	ldrh r1, [r7, #4]
	strh r1, [r0, #0xc]
	ldrh r1, [r7, #6]
	strh r1, [r0, #0xe]
	ldrh r1, [r7, #8]
	strh r1, [r0, #0x10]
	ldrh r1, [r7, #0xe]
	strh r1, [r0, #0x18]
	ldr r1, [r7, #0x14]
	str r1, [r0, #0x14]
	ldr r1, [r7, #0x18]
	str r1, [r0, #0x1c]
	ldr r1, [r7, #0x1c]
	str r1, [r0, #0x20]
	ldrh r1, [r7, #0x10]
	strh r1, [r0, #0x1a]
	ldrh r1, [r6, #0x30]
	ldrh r2, [r6, #0x32]
	add r3, r6, #0x100
	ldrh r3, [r3, #0x88]
	cmp r3, #0
	moveq r3, r1
	movne r3, r2
	strh r3, [r0, #0x24]
	add r3, r6, #0x100
	ldrh r3, [r3, #0x88]
	cmp r3, #0
	movne r2, r1
	strh r2, [r0, #0x26]
	bl WMSP_ReturnResult2Wm9
	ldrh r0, [r7, #0]
	cmp r0, r4
	streqh r8, [r5, #2]
	ldrh r0, [r7, #0]
	strh r0, [r11]
	strh r4, [r7]
	add r0, r6, #0x600
	ldrh r1, [r0, #0xfa]
	cmp r1, r4
	streqh r10, [r0, #0xf8]
	movne r0, r1, lsl #5
	strneh r10, [r9, r0]
	add r0, r6, #0x600
	strh r10, [r0, #0xfa]
	mov r10, r8
_027E6F78:
	cmp r10, r4
	addne r11, r9, r10, lsl #5
	moveq r11, r5
	mov r8, r10
	cmp r10, r4
	movne r0, r10, lsl #5
	ldrneh r10, [r9, r0]
	ldreqh r10, [r5, #0]
	cmp r10, r4
	bne _027E6E70
_027E6FA0:
	add r5, r5, #4
	ldr r0, [sp, #4]
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #4
	blt _027E6E5C
	ldr r0, [sp]
	add r0, r0, #1
	str r0, [sp]
	cmp r0, #2
	blt _027E6E50
	ldr r0, _027E6FE8 // =0x0000071C
	add r0, r6, r0
	bl OS_UnlockMutex
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E6FE4: .word 0x027F9454
_027E6FE8: .word 0x0000071C
_027E6FEC: .word 0x0000070C
_027E6FF0: .word 0x0000FFFF
	arm_func_end WMSP_CleanSendQueue

	arm_func_start WMSP_FlushSendQueue
WMSP_FlushSendQueue: // 0x027E6FF4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	str r0, [sp]
	mov r4, r1
	ldr r0, _027E7328 // =0x027F9454
	ldr r6, [r0, #0x550]
	add r10, r6, #0x2f8
	mov r0, #0
	str r0, [sp, #8]
	ldrh r0, [r6, #0]
	cmp r0, #9
	moveq r5, #1
	beq _027E7044
	cmp r0, #0xa
	ldreq r5, [sp, #8]
	beq _027E7044
	ldr r0, [sp, #8]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_027E7044:
	ldr r0, _027E732C // =0x0000071C
	add r0, r6, r0
	bl OS_LockMutex
	ldr r0, [r6, #0x734]
	cmp r0, #0
	bne _027E7078
	ldr r0, _027E732C // =0x0000071C
	add r0, r6, r0
	bl OS_UnlockMutex
	mov r0, #0
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_027E7078:
	cmp r5, #0
	moveq r11, #1
	beq _027E7094
	bl OS_DisableInterrupts
	add r1, r6, #0x100
	ldrh r11, [r1, #0x82]
	bl OS_RestoreInterrupts
_027E7094:
	mov r0, #0
	str r0, [sp, #4]
	ldr r0, _027E7330 // =0x000006FC
	add r8, r6, r0
	mvn r0, r4
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x18]
	ldr r4, _027E7334 // =0x0000FFFF
	ldr r0, [sp, #4]
	str r0, [sp, #0x14]
	mov r0, #0x81
	str r0, [sp, #0x1c]
	mov r0, #0xf
	str r0, [sp, #0x24]
	ldr r0, [sp, #4]
	str r0, [sp, #0x20]
	mov r0, #0x14
	str r0, [sp, #0x28]
_027E70E0:
	mov r5, r4
	str r4, [sp, #0xc]
	ldrh r9, [r8, #0]
	cmp r9, r4
	beq _027E72AC
_027E70F4:
	add r7, r10, r9, lsl #5
	ldr r0, [sp]
	cmp r0, #0
	bne _027E7130
	ldrh r2, [r7, #8]
	ldrh r1, [r7, #0xa]
	ldr r0, [sp, #0x10]
	and r0, r1, r0
	orr r0, r2, r0
	strh r0, [r7, #8]
	ldrh r1, [r7, #6]
	ldrh r0, [r7, #8]
	mvn r0, r0
	and r0, r1, r0
	strh r0, [r7, #6]
_027E7130:
	ldrh r0, [r7, #6]
	and r0, r0, r11
	strh r0, [r7, #6]
	ldr r0, [sp, #0x14]
	strh r0, [r7, #0xa]
	ldrh r0, [r7, #6]
	cmp r0, #0
	beq _027E71BC
	ldrh r0, [r7, #2]
	ands r0, r0, #8
	bne _027E7168
	ldrh r0, [r7, #0x12]
	cmp r0, #0
	beq _027E71BC
_027E7168:
	ldr r0, [sp, #0x18]
	str r0, [sp, #8]
	ldrh r0, [r7, #0x12]
	cmp r0, #0
	subne r0, r0, #1
	strneh r0, [r7, #0x12]
	ldrh r0, [r7, #0]
	cmp r0, r4
	streqh r4, [r8, #2]
	ldrh r0, [r7, #0]
	strh r0, [r8]
	strh r4, [r7]
	cmp r5, r4
	moveq r0, r9, lsl #0x10
	moveq r0, r0, lsr #0x10
	streq r0, [sp, #0xc]
	movne r0, r5, lsl #5
	strneh r9, [r10, r0]
	mov r0, r9, lsl #0x10
	mov r5, r0, lsr #0x10
	b _027E72A0
_027E71BC:
	bl WMSP_GetBuffer4Callback2Wm9
	ldr r1, [sp, #0x1c]
	strh r1, [r0]
	ldrh r1, [r7, #6]
	cmp r1, #0
	ldreq r1, [sp, #0x20]
	streqh r1, [r0, #2]
	ldrne r1, [sp, #0x24]
	strneh r1, [r0, #2]
	ldr r1, [sp, #0x28]
	strh r1, [r0, #8]
	ldrh r1, [r7, #2]
	strh r1, [r0, #0xa]
	ldrh r1, [r7, #4]
	strh r1, [r0, #0xc]
	ldrh r1, [r7, #6]
	strh r1, [r0, #0xe]
	ldrh r1, [r7, #8]
	strh r1, [r0, #0x10]
	ldrh r1, [r7, #0xe]
	strh r1, [r0, #0x18]
	ldr r1, [r7, #0x14]
	str r1, [r0, #0x14]
	ldr r1, [r7, #0x18]
	str r1, [r0, #0x1c]
	ldr r1, [r7, #0x1c]
	str r1, [r0, #0x20]
	ldrh r1, [r7, #0x10]
	strh r1, [r0, #0x1a]
	ldrh r1, [r6, #0x30]
	ldrh r2, [r6, #0x32]
	add r3, r6, #0x100
	ldrh r3, [r3, #0x88]
	cmp r3, #0
	moveq r3, r1
	movne r3, r2
	strh r3, [r0, #0x24]
	add r3, r6, #0x100
	ldrh r3, [r3, #0x88]
	cmp r3, #0
	movne r2, r1
	strh r2, [r0, #0x26]
	bl WMSP_ReturnResult2Wm9
	ldrh r0, [r7, #0]
	cmp r0, r4
	streqh r4, [r8, #2]
	ldrh r0, [r7, #0]
	strh r0, [r8]
	strh r4, [r7]
	add r0, r6, #0x600
	ldrh r1, [r0, #0xfa]
	cmp r1, r4
	streqh r9, [r0, #0xf8]
	movne r0, r1, lsl #5
	strneh r9, [r10, r0]
	add r0, r6, #0x600
	strh r9, [r0, #0xfa]
_027E72A0:
	ldrh r9, [r8, #0]
	cmp r9, r4
	bne _027E70F4
_027E72AC:
	cmp r5, r4
	beq _027E72EC
	ldr r0, [sp, #4]
	add r0, r6, r0, lsl #2
	add r0, r0, #0x700
	ldrh r2, [r0, #0xc]
	mov r1, r5, lsl #5
	strh r2, [r10, r1]
	ldrh r1, [r0, #0xe]
	cmp r1, r4
	streqh r5, [r0, #0xe]
	ldr r0, [sp, #4]
	add r0, r6, r0, lsl #2
	add r1, r0, #0x700
	ldr r0, [sp, #0xc]
	strh r0, [r1, #0xc]
_027E72EC:
	add r8, r8, #4
	ldr r0, [sp, #4]
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #4
	blt _027E70E0
	mov r0, #0
	str r0, [r6, #0x734]
	ldr r0, _027E732C // =0x0000071C
	add r0, r6, r0
	bl OS_UnlockMutex
	ldr r0, [sp, #8]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E7328: .word 0x027F9454
_027E732C: .word 0x0000071C
_027E7330: .word 0x000006FC
_027E7334: .word 0x0000FFFF
	arm_func_end WMSP_FlushSendQueue

	arm_func_start WMSP_PutSendQueue
WMSP_PutSendQueue: // 0x027E7338
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	mov r7, r2
	mov r6, r3
	ldr r0, _027E7484 // =0x027F9454
	ldr r9, [r0, #0x550]
	add r5, r9, #0x2f8
	ldr r0, _027E7488 // =0x0000070C
	add r0, r9, r0
	add r4, r0, r1, lsl #2
	ldrh r0, [sp, #0x24]
	cmp r0, #0
	moveq r0, #6
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	ands r0, r7, #8
	movne r1, #2
	moveq r1, #0
	ldrh r0, [sp, #0x24]
	add r1, r0, r1
	ldrh r0, [r9, #0x3c]
	cmp r1, r0
	movgt r0, #6
	addgt sp, sp, #4
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxgt lr
	ldr r0, _027E748C // =0x0000071C
	add r0, r9, r0
	bl OS_LockMutex
	add r2, r9, #0x600
	ldrh r0, [r2, #0xf8]
	ldr r3, _027E7490 // =0x0000FFFF
	cmp r0, r3
	bne _027E73E4
	ldr r0, _027E748C // =0x0000071C
	add r0, r9, r0
	bl OS_UnlockMutex
	mov r0, #0xa
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_027E73E4:
	mov ip, r0, lsl #5
	add r1, r5, r0, lsl #5
	ldrh ip, [r5, ip]
	strh ip, [r2, #0xf8]
	ldrh ip, [r2, #0xfa]
	cmp ip, r0
	streqh r3, [r2, #0xfa]
	strh r7, [r1, #2]
	strh r6, [r1, #4]
	and r2, r6, r8
	strh r2, [r1, #6]
	mov r2, #0
	strh r2, [r1, #8]
	strh r2, [r1, #0xa]
	ldr r2, [sp, #0x20]
	str r2, [r1, #0x14]
	ldrh r2, [sp, #0x24]
	strh r2, [r1, #0xe]
	ldr r2, [sp, #0x28]
	str r2, [r1, #0x18]
	ldr r2, [sp, #0x2c]
	str r2, [r1, #0x1c]
	ldr r3, _027E7490 // =0x0000FFFF
	strh r3, [r1]
	strh r3, [r1, #0x10]
	ldrh r2, [r9, #0x98]
	strh r2, [r1, #0x12]
	ldrh r1, [r4, #2]
	cmp r1, r3
	streqh r0, [r4]
	movne r1, r1, lsl #5
	strneh r0, [r5, r1]
	strh r0, [r4, #2]
	ldr r0, _027E748C // =0x0000071C
	add r0, r9, r0
	bl OS_UnlockMutex
	mov r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027E7484: .word 0x027F9454
_027E7488: .word 0x0000070C
_027E748C: .word 0x0000071C
_027E7490: .word 0x0000FFFF
	arm_func_end WMSP_PutSendQueue

	arm_func_start WmspMakePortPacket
WmspMakePortPacket: // 0x027E7494
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x64
	mov r10, r3
	ldr r3, [sp, #0x88]
	str r3, [sp, #0x88]
	ldr r3, [sp, #0x8c]
	str r3, [sp, #0x8c]
	ldr r3, _027E79B8 // =0x027F9454
	ldr r3, [r3, #0x550]
	str r3, [sp, #0x38]
	ldrh r8, [r3, #0x38]
	ldr r7, [r3, #0x7c]
	ldrh r4, [r3, #0x80]
	add r3, r8, #0x1f
	bic r3, r3, #0x1f
	cmp r4, r3
	movlt r0, #1
	addlt sp, sp, #0x64
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxlt lr
	ldr r3, [sp, #0x38]
	add r3, r3, #0x100
	ldrh r3, [r3, #0x88]
	cmp r3, #0x10
	movhs r0, #1
	addhs sp, sp, #0x64
	ldmhsia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxhs lr
	ldr r3, [sp, #0x38]
	ldrh r3, [r3, #0]
	cmp r3, #9
	moveq r3, #1
	streq r3, [sp, #0x10]
	beq _027E753C
	cmp r3, #0xa
	moveq r3, #0
	streq r3, [sp, #0x10]
	beq _027E753C
	mov r0, #1
	add sp, sp, #0x64
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_027E753C:
	mov r3, #0
	str r3, [sp, #0x14]
	strh r3, [r10]
	mov r4, r3
	ldr r3, [sp, #0x88]
	str r4, [r3]
	ldr r4, [sp, #0x14]
	ldr r3, [sp, #0x8c]
	str r4, [r3]
	mov r6, r4
	cmp r8, #0
	movlt r0, #1
	addlt sp, sp, #0x64
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxlt lr
	str r2, [sp, #0x1c]
	mov r3, #1
	str r3, [sp, #0x18]
	ldr r3, [sp, #0x10]
	cmp r3, #0
	beq _027E75AC
	ldr r3, [sp, #0x38]
	ldrh r3, [r3, #0x92]
	cmp r3, #0
	strne r1, [sp, #0x1c]
	movne r1, r4
	strne r1, [sp, #0x18]
	b _027E75B4
_027E75AC:
	mov r1, r4
	str r1, [sp, #0x18]
_027E75B4:
	and r4, r2, r0
	mov r0, #0
	str r0, [sp, #8]
	mov r0, #1
	str r0, [sp, #0xc]
	ldr r1, _027E79BC // =0x0000071C
	ldr r0, [sp, #0x38]
	add r0, r0, r1
	bl OS_LockMutex
	ldr r0, [sp, #0x38]
	ldr r0, [r0, #0x734]
	cmp r0, #1
	bne _027E7608
	ldr r1, _027E79BC // =0x0000071C
	ldr r0, [sp, #0x38]
	add r0, r0, r1
	bl OS_UnlockMutex
	mov r0, #1
	add sp, sp, #0x64
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_027E7608:
	mov r1, #1
	str r1, [sp, #0x40]
	ldr r0, [sp, #0x38]
	str r1, [r0, #0x734]
	add r0, r0, #0x2f8
	str r0, [sp, #0x20]
	mov r0, #0
	str r0, [sp, #0x24]
	ldr r1, _027E79C0 // =0x0000070C
	ldr r0, [sp, #0x38]
	add r11, r0, r1
	ldr r1, _027E79C4 // =0x000006FC
	add r0, r0, r1
	str r0, [sp, #0x28]
	mvn r0, r4
	str r0, [sp, #0x3c]
	ldr r0, [sp, #0x24]
	str r0, [sp, #0x44]
	str r0, [sp, #0x48]
	str r0, [sp, #0x50]
	mov r0, #2
	str r0, [sp, #0x4c]
	ldr r0, [sp, #0x24]
	str r0, [sp, #0x54]
	str r0, [sp, #0x58]
	str r0, [sp, #0x5c]
	str r0, [sp, #0x60]
	b _027E7970
_027E7678:
	str r11, [sp, #0x2c]
	ldr r0, _027E79C8 // =0x0000FFFF
	str r0, [sp, #0x30]
	ldrh r9, [r11, #0]
	b _027E7940
_027E768C:
	ldr r0, [sp, #0x20]
	add r5, r0, r9, lsl #5
	ldrh r0, [r5, #2]
	ldr r1, [sp, #0x40]
	mov r1, r1, lsl r0
	str r1, [sp, #0x34]
	ldr r2, [sp, #8]
	ands r1, r2, r1
	bne _027E790C
	ldr r1, [sp, #0x34]
	orr r1, r2, r1
	str r1, [sp, #8]
	ldrh r2, [r5, #6]
	ldr r1, [sp, #0x1c]
	and r4, r2, r1
	ldr r1, [sp, #0x18]
	cmp r1, #0
	beq _027E76E0
	ldr r1, [sp, #0x3c]
	ands r1, r4, r1
	bne _027E790C
_027E76E0:
	ands r0, r0, #8
	ldrne r0, [sp, #0x40]
	strne r0, [sp, #4]
	ldreq r0, [sp, #0x44]
	streq r0, [sp, #4]
	ldr r0, [sp, #0x10]
	cmp r0, #0
	beq _027E7718
	orr r1, r4, #1
	ldr r0, _027E79C8 // =0x0000FFFF
	cmp r1, r0
	ldrne r0, [sp, #0x40]
	strne r0, [sp]
	bne _027E7720
_027E7718:
	ldr r0, [sp, #0x48]
	str r0, [sp]
_027E7720:
	ldrh r0, [r5, #0xe]
	and r1, r0, #1
	cmp r1, #1
	addeq r0, r0, #1
	streqh r0, [r5, #0xe]
	ldr r0, [sp, #4]
	cmp r0, #0
	ldrne r0, [sp, #0x4c]
	ldreq r0, [sp, #0x50]
	ldr r1, [sp, #0xc]
	cmp r1, #0
	ldrne r3, [sp, #0x54]
	ldreq r3, [sp, #0x4c]
	ldr r1, [sp]
	cmp r1, #0
	ldrne r1, [sp, #0x4c]
	ldreq r1, [sp, #0x58]
	ldrh r2, [r5, #0xe]
	add r2, r2, r3
	add r0, r2, r0
	add r0, r1, r0
	cmp r0, r8
	bgt _027E790C
	ldr r0, [sp, #0xc]
	cmp r0, #0
	moveq r10, r7
	ldreq r0, [sp, #0x5c]
	streqh r0, [r7], #2
	addeq r6, r6, #2
	subeq r8, r8, #2
	ldrh r0, [r10, #0]
	ldrh r1, [r5, #2]
	mov r1, r1, lsl #8
	and r2, r1, #0xf00
	ldrh r1, [r5, #0xe]
	mov r1, r1, lsr #1
	and r1, r1, #0xff
	orr r1, r2, r1
	orr r0, r0, r1
	strh r0, [r10]
	ldr r0, [r5, #0x14]
	mov r1, r7
	ldrh r2, [r5, #0xe]
	bl MIi_CpuCopy16
	ldrh r1, [r5, #0xe]
	bic r0, r1, #1
	add r7, r7, r0
	add r6, r6, r1
	sub r8, r8, r1
	ldr r0, [sp, #4]
	cmp r0, #1
	bne _027E784C
	ldrh r1, [r5, #0x10]
	ands r0, r1, #1
	moveq r2, r1, asr #1
	beq _027E7838
	ldr r0, [sp, #0x38]
	add r0, r0, #0x100
	ldrh r2, [r0, #0x88]
	ldrh r0, [r5, #2]
	and r1, r0, #7
	ldr r0, [sp, #0x38]
	add r0, r0, r2, lsl #4
	add r0, r0, r1, lsl #1
	add r0, r0, #0x100
	ldrh r2, [r0, #0xf8]
	add r1, r2, #1
	strh r1, [r0, #0xf8]
	mov r0, r2, lsl #1
	strh r0, [r5, #0x10]
_027E7838:
	ldr r0, _027E79CC // =0x00007FFF
	and r0, r2, r0
	strh r0, [r7], #2
	add r6, r6, #2
	sub r8, r8, #2
_027E784C:
	ldr r0, [sp]
	cmp r0, #1
	bne _027E7870
	ldrh r0, [r10, #0]
	orr r0, r0, #0x1000
	strh r0, [r10]
	strh r4, [r7], #2
	add r6, r6, #2
	sub r8, r8, #2
_027E7870:
	ldr r0, [sp, #0xc]
	cmp r0, #1
	ldreq r0, [sp, #0x60]
	streq r0, [sp, #0xc]
	ldrh r0, [r11, #2]
	cmp r0, r9
	ldreq r0, [sp, #0x30]
	streqh r0, [r11, #2]
	ldrh r1, [r5, #0]
	ldr r0, [sp, #0x2c]
	strh r1, [r0]
	ldr r0, _027E79C8 // =0x0000FFFF
	strh r0, [r5]
	ldr r0, [sp, #0x28]
	ldrh r1, [r0, #2]
	ldr r0, _027E79C8 // =0x0000FFFF
	cmp r1, r0
	ldreq r0, [sp, #0x28]
	streqh r9, [r0]
	movne r1, r1, lsl #5
	ldrne r0, [sp, #0x20]
	strneh r9, [r0, r1]
	ldr r0, [sp, #0x28]
	strh r9, [r0, #2]
	strh r4, [r5, #0xa]
	ldr r0, [sp, #0x34]
	mvn r1, r0
	ldr r0, [sp, #8]
	and r0, r0, r1
	str r0, [sp, #8]
	ldrh r1, [r5, #4]
	ldr r0, [sp, #0x14]
	orr r0, r0, r1
	str r0, [sp, #0x14]
	ldr r9, [sp, #0x30]
	ldr r0, [sp, #0x38]
	ldrh r0, [r0, #0x94]
	cmp r0, #1
	beq _027E7984
_027E790C:
	ldr r0, _027E79C8 // =0x0000FFFF
	cmp r9, r0
	ldrne r0, [sp, #0x20]
	addne r0, r0, r9, lsl #5
	strne r0, [sp, #0x2c]
	streq r11, [sp, #0x2c]
	str r9, [sp, #0x30]
	ldr r0, _027E79C8 // =0x0000FFFF
	cmp r9, r0
	movne r1, r9, lsl #5
	ldrne r0, [sp, #0x20]
	ldrneh r9, [r0, r1]
	ldreqh r9, [r11, #0]
_027E7940:
	ldr r0, _027E79C8 // =0x0000FFFF
	cmp r9, r0
	beq _027E7954
	cmp r8, #2
	bgt _027E768C
_027E7954:
	add r11, r11, #4
	ldr r0, [sp, #0x28]
	add r0, r0, #4
	str r0, [sp, #0x28]
	ldr r0, [sp, #0x24]
	add r0, r0, #1
	str r0, [sp, #0x24]
_027E7970:
	ldr r0, [sp, #0x24]
	cmp r0, #4
	bhs _027E7984
	cmp r8, #2
	bgt _027E7678
_027E7984:
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x88]
	str r1, [r0]
	ldr r0, [sp, #0x8c]
	str r6, [r0]
	ldr r1, _027E79BC // =0x0000071C
	ldr r0, [sp, #0x38]
	add r0, r0, r1
	bl OS_UnlockMutex
	mov r0, #0
	add sp, sp, #0x64
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027E79B8: .word 0x027F9454
_027E79BC: .word 0x0000071C
_027E79C0: .word 0x0000070C
_027E79C4: .word 0x000006FC
_027E79C8: .word 0x0000FFFF
_027E79CC: .word 0x00007FFF
	arm_func_end WmspMakePortPacket

	arm_func_start WMSP_ResumeMaMP
WMSP_ResumeMaMP: // 0x027E79D0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x218
	mov r7, r0
	ldr r0, _027E7AC8 // =0x027F9454
	ldr r4, [r0, #0x550]
	bl OS_DisableInterrupts
	bl OS_RestoreInterrupts
	ldr r0, _027E7ACC // =0x048080F8
	ldrh r6, [r0, #0]
	ldrh r5, [r4, #0x6a]
	add r0, r4, #0x100
	ldrh r0, [r0, #0x82]
	and r7, r7, r0
	ldrh r8, [r4, #0x3a]
	mov r0, r7
	bl MATH_CountPopulation
	ldrh r2, [r4, #0x72]
	add r1, r8, #0xc
	mul r0, r1, r0
	add r0, r0, #0x29
	bic r0, r0, #0x1f
	cmp r2, r0
	bge _027E7A44
	mov r0, #2
	bl OS_Sleep
	bl WMSP_RequestResumeMP
	add sp, sp, #0x218
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_027E7A44:
	ldrsh r0, [r4, #0x62]
	cmp r0, #1
	beq _027E7A5C
	ldrsh r0, [r4, #0x64]
	cmp r0, #1
	bne _027E7A78
_027E7A5C:
	ldrh r0, [r4, #0x6e]
	ldrh r1, [r4, #0x6c]
	mov r2, r7
	ldrh r3, [r4, #0x40]
	bl WmspGetTmptt
	orr r5, r5, #0x8000
	b _027E7A80
_027E7A78:
	mov r0, #0
	bic r5, r5, #0x8000
_027E7A80:
	mov r1, r7, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp]
	str r0, [sp, #4]
	str r6, [sp, #8]
	mov r2, #0
	str r2, [sp, #0xc]
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	str r2, [sp, #0x14]
	add r0, sp, #0x18
	ldr r1, _027E7AD0 // =0x0000800C
	mov r3, r2
	bl WMSP_WL_MaMp
	add sp, sp, #0x218
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027E7AC8: .word 0x027F9454
_027E7ACC: .word 0x048080F8
_027E7AD0: .word 0x0000800C
	arm_func_end WMSP_ResumeMaMP

	arm_func_start WMSP_SendMaMP
WMSP_SendMaMP: // 0x027E7AD4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x228
	mov r8, r0
	ldr r0, _027E7CC4 // =0x027F9454
	ldr r4, [r0, #0x550]
	bl OS_DisableInterrupts
	add r1, r4, #0x100
	ldrh r7, [r1, #0x82]
	ldrh r6, [r4, #0x86]
	bl OS_RestoreInterrupts
	mov r1, #0
	strh r1, [sp, #0x18]
	ldrh r0, [r4, #0x88]
	cmp r0, #1
	ldreq r8, _027E7CC8 // =0x0000FFFF
	streqh r1, [r4, #0x88]
	ldrh r0, [r4, #0x9e]
	cmp r0, #0
	bne _027E7C0C
	ldrh r5, [r4, #0x3a]
	add r0, sp, #0x1c
	str r0, [sp]
	add r0, sp, #0x20
	str r0, [sp, #4]
	mov r0, r8
	mov r1, r7
	mov r2, r6
	add r3, sp, #0x18
	bl WmspMakePortPacket
	cmp r0, #1
	moveq r0, #0
	streqh r0, [r4, #0x62]
	streqh r0, [r4, #0x64]
	addeq sp, sp, #0x228
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	add r6, r5, #2
	ldrh r0, [r4, #0x92]
	cmp r0, #1
	ldreq r8, [sp, #0x1c]
	and r8, r8, r7
	mov r0, r8
	bl MATH_CountPopulation
	ldrh r2, [r4, #0x72]
	add r1, r5, #0xc
	mul r0, r1, r0
	add r0, r0, #0x29
	bic r0, r0, #0x1f
	cmp r2, r0
	bge _027E7BC4
	mov r0, #0
	mov r1, r8, lsl #0x10
	mov r1, r1, lsr #0x10
	bl WMSP_FlushSendQueue
	mov r0, #0
	strh r0, [r4, #0x62]
	strh r0, [r4, #0x64]
	add sp, sp, #0x228
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_027E7BC4:
	ldrsh r0, [r4, #0x62]
	cmp r0, #1
	beq _027E7BDC
	ldrsh r0, [r4, #0x64]
	cmp r0, #1
	bne _027E7C04
_027E7BDC:
	ldr r0, [sp, #0x20]
	mov r1, r6
	mov r2, r8
	ldrh r3, [r4, #0x40]
	bl WmspGetTmptt
	mov r5, r0
	ldrh r0, [sp, #0x18]
	orr r0, r0, #0x8000
	strh r0, [sp, #0x18]
	b _027E7C4C
_027E7C04:
	mov r5, #0
	b _027E7C4C
_027E7C0C:
	mov r5, #0
	strh r5, [r4, #0x9e]
	mov r8, r7
	ldr r6, _027E7CCC // =0x000080D6
	str r5, [sp, #0x20]
	ldrh r0, [sp, #0x18]
	bic r0, r0, #0x8000
	strh r0, [sp, #0x18]
	bl OS_DisableInterrupts
	ldrsh r1, [r4, #0x62]
	add r1, r1, #1
	strh r1, [r4, #0x62]
	ldrsh r1, [r4, #0x64]
	add r1, r1, #1
	strh r1, [r4, #0x64]
	bl OS_RestoreInterrupts
_027E7C4C:
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp]
	str r5, [sp, #4]
	ldr r0, _027E7CD0 // =0x048080F8
	ldrh r0, [r0, #0]
	str r0, [sp, #8]
	ldr r0, [sp, #0x20]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [sp, #0xc]
	ldrh r0, [sp, #0x18]
	str r0, [sp, #0x10]
	ldr r0, [r4, #0x7c]
	str r0, [sp, #0x14]
	add r0, sp, #0x24
	mov r1, #0
	mov r2, r1
	mov r3, r6, lsl #0x10
	mov r3, r3, lsr #0x10
	bl WMSP_WL_MaMp
	strh r8, [r4, #0x68]
	ldrh r0, [sp, #0x18]
	strh r0, [r4, #0x6a]
	strh r6, [r4, #0x6c]
	ldr r0, [sp, #0x20]
	strh r0, [r4, #0x6e]
	add sp, sp, #0x228
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027E7CC4: .word 0x027F9454
_027E7CC8: .word 0x0000FFFF
_027E7CCC: .word 0x000080D6
_027E7CD0: .word 0x048080F8
	arm_func_end WMSP_SendMaMP

	arm_func_start WMSP_SendMaKeyData
WMSP_SendMaKeyData: // 0x027E7CD4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x218
	ldr r0, _027E7DA0 // =0x027F9454
	ldr r4, [r0, #0x550]
	add r0, r4, #0x100
	ldrh r0, [r0, #0x82]
	cmp r0, #0
	addeq sp, sp, #0x218
	ldmeqia sp!, {r4, lr}
	bxeq lr
	mov r0, #1
	strh r0, [r4, #0x8a]
	mov r1, #0
	strh r1, [sp, #8]
	add r1, sp, #0xc
	str r1, [sp]
	add r1, sp, #0x10
	str r1, [sp, #4]
	mov r1, r0
	mov r2, r0
	add r3, sp, #8
	bl WmspMakePortPacket
	cmp r0, #1
	moveq r0, #0
	streqh r0, [r4, #0x8a]
	addeq sp, sp, #0x218
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, [r4, #0x1c]
	cmp r0, #1
	ldreqh r0, [sp, #8]
	orreq r0, r0, #0x8000
	streqh r0, [sp, #8]
	add r0, sp, #0x14
	ldr r1, [sp, #0x10]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ldrh r2, [sp, #8]
	ldr r3, [r4, #0x7c]
	bl WMSP_WL_MaKeyData
	ldrh r0, [r0, #4]
	cmp r0, #0
	addeq sp, sp, #0x218
	ldmeqia sp!, {r4, lr}
	bxeq lr
	cmp r0, #8
	movne r0, #0
	strneh r0, [r4, #0x8a]
	add sp, sp, #0x218
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E7DA0: .word 0x027F9454
	arm_func_end WMSP_SendMaKeyData

	arm_func_start WMSP_InitSendQueue
WMSP_InitSendQueue: // 0x027E7DA4
	stmdb sp!, {r4, lr}
	ldr r0, _027E7E58 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldr r0, _027E7E5C // =0x0000071C
	add r0, r4, r0
	bl OS_LockMutex
	mov r0, #0
	add r1, r4, #0x2f8
	mov r2, #0x400
	bl MIi_CpuClear16
	mov r2, #0
_027E7DD0:
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	add r0, r4, r2, lsl #5
	add r0, r0, #0x200
	strh r1, [r0, #0xf8]
	mov r2, r1
	cmp r1, #0x1f
	blo _027E7DD0
	ldr r2, _027E7E60 // =0x0000FFFF
	add r0, r4, r1, lsl #5
	add r0, r0, #0x200
	strh r2, [r0, #0xf8]
	mov r3, #0
	add r0, r4, #0x600
	strh r3, [r0, #0xf8]
	strh r1, [r0, #0xfa]
_027E7E14:
	add r1, r4, r3, lsl #2
	add r0, r1, #0x700
	strh r2, [r0, #0xc]
	strh r2, [r0, #0xe]
	add r0, r1, #0x600
	strh r2, [r0, #0xfc]
	strh r2, [r0, #0xfe]
	add r0, r3, #1
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	cmp r3, #4
	blo _027E7E14
	ldr r0, _027E7E5C // =0x0000071C
	add r0, r4, r0
	bl OS_UnlockMutex
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E7E58: .word 0x027F9454
_027E7E5C: .word 0x0000071C
_027E7E60: .word 0x0000FFFF
	arm_func_end WMSP_InitSendQueue

	arm_func_start WMSP_SetEntry
WMSP_SetEntry: // 0x027E7E64
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x280
	ldr r1, _027E7EF0 // =0x027F9454
	ldr r4, [r1, #0x550]
	ldr r0, [r0, #4]
	strh r0, [r4, #0xf6]
	add r0, sp, #0x200
	add r1, r4, #0xe8
	bl WMSP_CopyParentParam
	add r0, sp, #0
	ldrh r1, [r4, #0xec]
	add r1, r1, #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	add r2, sp, #0x200
	bl WMSP_WL_ParamSetGameInfo
	mov r4, r0
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x21
	strh r1, [r0]
	ldrh r1, [r4, #4]
	cmp r1, #0
	moveq r1, #0
	streqh r1, [r0, #2]
	beq _027E7EE0
	mov r1, #1
	strh r1, [r0, #2]
	ldr r1, _027E7EF4 // =0x00000245
	strh r1, [r0, #4]
	ldrh r1, [r4, #4]
	strh r1, [r0, #6]
_027E7EE0:
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #0x280
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E7EF0: .word 0x027F9454
_027E7EF4: .word 0x00000245
	arm_func_end WMSP_SetEntry

	arm_func_start WMSP_AutoDeAuth
WMSP_AutoDeAuth: // 0x027E7EF8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x208
	add r0, r0, #4
	add r1, sp, #0
	mov r2, #6
	bl MI_CpuCopy8
	mov r8, #0
	add r7, sp, #8
	add r6, sp, #0
	mov r5, #0x13
	b _027E7F58
_027E7F24:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl WMSP_WL_MlmeDeAuthenticate
	mov r4, r0
	ldrh r0, [r4, #4]
	cmp r0, #0
	beq _027E7F60
	cmp r0, #7
	beq _027E7F54
	cmp r0, #0xc
	bne _027E7F60
_027E7F54:
	add r8, r8, #1
_027E7F58:
	cmp r8, #2
	blt _027E7F24
_027E7F60:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x22
	strh r1, [r0]
	ldrh r1, [r4, #4]
	cmp r1, #0
	moveq r1, #0
	streqh r1, [r0, #2]
	beq _027E7F98
	mov r1, #1
	strh r1, [r0, #2]
	mov r1, #5
	strh r1, [r0, #4]
	ldrh r1, [r4, #4]
	strh r1, [r0, #6]
_027E7F98:
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #0x208
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end WMSP_AutoDeAuth

	arm_func_start WMSPi_CommonInit
WMSPi_CommonInit: // 0x027E7FA8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r0, _027E80F4 // =0x027F9454
	ldr r7, [r0, #0x54c]
	ldr r4, [r0, #0x550]
	mov r6, #0
	bl OS_DisableInterrupts
	mov r5, r0
	ldr r0, [r4, #0xc]
	cmp r0, #1
	bne _027E7FE8
	mov r0, r6
	str r0, [r4, #0xc]
	mov r6, #1
	bl WMSP_CancelVAlarm
	bl WMSP_SetThreadPriorityLow
_027E7FE8:
	mov r1, #0
	add r0, r4, #0x100
	strh r1, [r0, #0x82]
	strh r1, [r4, #0x86]
	str r1, [r4, #0x14]
	str r1, [r4, #0x10]
	str r1, [r4, #0x1c]
	strh r1, [r4, #0xce]
	strh r1, [r4, #0xc2]
	mov r2, #1
	strh r2, [r4, #0x58]
	strh r2, [r4, #0x5a]
	mov r2, #6
	strh r2, [r4, #0x5c]
	strh r1, [r4, #0x98]
	strh r1, [r4, #0x92]
	strh r1, [r4, #0x94]
	strh r1, [r4, #0x9a]
	strh r1, [r4, #0x9c]
	str r1, [r4, #0x198]
	strh r1, [r0, #0x96]
	add r0, r4, #0x19c
	mov r2, #0x50
	bl MI_CpuFill8
	bl WMSP_ResetSizeVars
	mov r0, #0x104
	strh r0, [r4, #0x40]
	mov r0, #0xf0
	strh r0, [r4, #0x42]
	mov r0, #0x3e8
	strh r0, [r4, #0x44]
	mov r1, #0
	strh r1, [r4, #0x46]
	ldr r0, _027E80F8 // =0x0000020B
	str r0, [r4, #0x48]
	str r1, [r4, #0x4c]
	str r1, [r4, #0x50]
	str r1, [r4, #0x54]
	strh r1, [r4, #0xc6]
	mov r1, #1
	add r0, r4, #0x100
	strh r1, [r0, #0xee]
	mov r0, r5
	bl OS_RestoreInterrupts
	cmp r6, #0
	beq _027E80A8
	ldr r0, _027E80FC // =0x0000FFFF
	bl WMSP_CleanSendQueue
_027E80A8:
	mov r2, #0
	mov r1, #0x8000
_027E80B0:
	add r0, r7, r2, lsl #4
	str r1, [r0, #0xd0]
	add r2, r2, #1
	cmp r2, #0x20
	blt _027E80B0
	mov r0, #1
	add r1, r4, #0x1f8
	mov r2, #0x100
	bl MIi_CpuClear16
	bl WMSP_InitAlarm
	ldr r0, _027E8100 // =0x0000071C
	add r0, r4, r0
	bl OS_InitMutex
	bl WMSP_InitVAlarm
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027E80F4: .word 0x027F9454
_027E80F8: .word 0x0000020B
_027E80FC: .word 0x0000FFFF
_027E8100: .word 0x0000071C
	arm_func_end WMSPi_CommonInit

	arm_func_start WMSP_Enable
WMSP_Enable: // 0x027E8104
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #4]
	ldr r1, _027E8160 // =0x027F9454
	str r4, [r1, #0x54c]
	ldr r2, [r0, #8]
	str r2, [r1, #0x550]
	str r2, [r4]
	ldr r0, [r0, #0xc]
	str r0, [r4, #8]
	bl WMSPi_CommonInit
	mov r0, #0xf
	bl PM_SetLEDPattern
	mov r1, #1
	ldr r0, [r4, #0]
	strh r1, [r0]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #3
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E8160: .word 0x027F9454
	arm_func_end WMSP_Enable

	arm_func_start WMSP_Disable
WMSP_Disable: // 0x027E8164
	stmdb sp!, {r4, lr}
	ldr r0, _027E81C8 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldrh r0, [r4, #0]
	cmp r0, #1
	beq _027E8198
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #4
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E81C0
_027E8198:
	mov r0, #1
	bl PM_SetLEDPattern
	mov r0, #0
	strh r0, [r4]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #4
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E81C0:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E81C8: .word 0x027F9454
	arm_func_end WMSP_Disable

	arm_func_start WmspStabilizeBeacon
WmspStabilizeBeacon: // 0x027E81CC
	mov r1, #0xc8
	ldr r0, _027E81F4 // =0x04808124
	strh r1, [r0]
	mov r1, #0x7d0
	ldr r0, _027E81F8 // =0x04808128
	strh r1, [r0]
	ldr r1, _027E81FC // =0x00000202
	ldr r0, _027E8200 // =0x04808150
	strh r1, [r0]
	bx lr
	.align 2, 0
_027E81F4: .word 0x04808124
_027E81F8: .word 0x04808128
_027E81FC: .word 0x00000202
_027E8200: .word 0x04808150
	arm_func_end WmspStabilizeBeacon

	arm_func_start WMSPi_CommonWlIdle
WMSPi_CommonWlIdle: // 0x027E8204
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x204
	mov r7, r0
	mov r6, r1
	ldr r0, _027E83D4 // =0x027F9454
	ldr r5, [r0, #0x550]
	add r0, sp, #0
	bl WMSP_WL_DevRestart
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E8248
	mov r1, #0x304
	strh r1, [r7]
	ldrh r0, [r0, #4]
	strh r0, [r6]
	mov r0, #0
	b _027E83C8
_027E8248:
	add r0, sp, #0
	bl WMSP_WL_DevIdle
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E8274
	ldr r1, _027E83D8 // =0x00000302
	strh r1, [r7]
	ldrh r0, [r0, #4]
	strh r0, [r6]
	mov r0, #0
	b _027E83C8
_027E8274:
	bl WmspStabilizeBeacon
	add r0, sp, #0
	bl WMSP_WL_ParamGetEnableChannel
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E82A4
	ldr r1, _027E83DC // =0x00000283
	strh r1, [r7]
	ldrh r0, [r0, #4]
	strh r0, [r6]
	mov r0, #0
	b _027E83C8
_027E82A4:
	ldrh r1, [r0, #6]
	add r0, r5, #0x100
	strh r1, [r0, #0xf4]
	mov r0, r1, lsl #0xf
	mov r0, r0, lsr #0x10
	bl WMSP_GetAllowedChannel
	add r1, r5, #0x100
	strh r0, [r1, #0xf6]
	add r0, sp, #0
	ldr r1, _027E83E0 // =0x0000FFFF
	mov r2, #0x28
	mov r3, #5
	bl WMSP_WL_ParamSetLifeTime
	ldr r1, _027E83E4 // =0x001FF621
	mov r0, #0
	str r1, [r5, #0x7b8]
	str r0, [r5, #0x7bc]
	mov r1, #2
	add r0, r5, #0x100
	strh r1, [r0, #0xec]
	mov r1, #1
	strh r1, [r0, #0xee]
	add r0, sp, #0
	bl WMSP_WL_DevGetVersion
	mov r4, r0
	ldrh r0, [r4, #4]
	cmp r0, #0
	beq _027E832C
	ldr r0, _027E83E8 // =0x00000306
	strh r0, [r7]
	ldrh r0, [r4, #4]
	strh r0, [r6]
	mov r0, #0
	b _027E83C8
_027E832C:
	add r0, r4, #6
	add r1, r5, #0x20
	mov r2, #8
	bl MIi_CpuCopy16
	ldrh r0, [r4, #0xe]
	strh r0, [r5, #0x28]
	ldrh r0, [r4, #0x10]
	strh r0, [r5, #0x2c]
	ldrh r0, [r4, #0x12]
	strh r0, [r5, #0x2e]
	ldrh r0, [r4, #0x14]
	strh r0, [r5, #0x2a]
	add r0, sp, #0
	bl WMSP_WL_ParamGetMacAddress
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E8388
	ldr r1, _027E83EC // =0x00000281
	strh r1, [r7]
	ldrh r0, [r0, #4]
	strh r0, [r6]
	mov r0, #0
	b _027E83C8
_027E8388:
	add r0, r0, #6
	add r1, r5, #0xe0
	mov r2, #6
	bl MI_CpuCopy8
	add r0, sp, #0
	mov r1, #1
	bl WMSP_WL_ParamSetBeaconSendRecvInd
	ldrh r1, [r0, #4]
	cmp r1, #0
	moveq r0, #1
	beq _027E83C8
	ldr r1, _027E83F0 // =0x00000215
	strh r1, [r7]
	ldrh r0, [r0, #4]
	strh r0, [r6]
	mov r0, #0
_027E83C8:
	add sp, sp, #0x204
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027E83D4: .word 0x027F9454
_027E83D8: .word 0x00000302
_027E83DC: .word 0x00000283
_027E83E0: .word 0x0000FFFF
_027E83E4: .word 0x001FF621
_027E83E8: .word 0x00000306
_027E83EC: .word 0x00000281
_027E83F0: .word 0x00000215
	arm_func_end WMSPi_CommonWlIdle

	arm_func_start WMSP_PowerOn
WMSP_PowerOn: // 0x027E83F4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r0, _027E8498 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldrh r0, [r4, #0]
	cmp r0, #1
	beq _027E842C
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #5
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E848C
_027E842C:
	add r0, sp, #0
	add r1, sp, #2
	bl WMSPi_CommonWlIdle
	cmp r0, #0
	bne _027E846C
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #5
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	ldrh r1, [sp]
	strh r1, [r0, #4]
	ldrh r1, [sp, #2]
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	b _027E848C
_027E846C:
	mov r0, #2
	strh r0, [r4]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #5
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E848C:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E8498: .word 0x027F9454
	arm_func_end WMSP_PowerOn

	arm_func_start WMSP_PowerOff
WMSP_PowerOff: // 0x027E849C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x204
	ldr r0, _027E8544 // =0x027F9454
	ldr r5, [r0, #0x550]
	ldrh r0, [r5, #0]
	cmp r0, #2
	beq _027E84D4
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #6
	strh r1, [r0]
	mov r1, #3
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E8538
_027E84D4:
	add r0, sp, #0
	bl WMSP_WL_DevShutdown
	mov r4, r0
	ldrh r0, [r4, #4]
	cmp r0, #0
	beq _027E8518
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #6
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	ldr r1, _027E8548 // =0x00000301
	strh r1, [r0, #4]
	ldrh r1, [r4, #4]
	strh r1, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	b _027E8538
_027E8518:
	mov r0, #1
	strh r0, [r5]
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #6
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E8538:
	add sp, sp, #0x204
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E8544: .word 0x027F9454
_027E8548: .word 0x00000301
	arm_func_end WMSP_PowerOff

	arm_func_start WMSP_SetMPParameterCore
WMSP_SetMPParameterCore: // 0x027E854C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, r1
	ldr r0, _027E8840 // =0x027F9454
	ldr r4, [r0, #0x550]
	mov r6, #0
	ldr r5, [r9, #0]
	ldrh r1, [r4, #0]
	ldr r0, _027E8844 // =0x0000FFF7
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _027E8594
	ands r0, r5, #0x2c00
	movne r6, #3
	bicne r5, r5, #0x2c00
_027E8594:
	bl OS_DisableInterrupts
	mov r7, r0
	cmp r8, #0
	beq _027E861C
	ldr r0, _027E8848 // =0x00003FFF
	str r0, [r8]
	ldrh r0, [r4, #0x5a]
	strh r0, [r8, #4]
	ldrh r0, [r4, #0x5a]
	strh r0, [r8, #6]
	ldrh r0, [r4, #0x5a]
	strh r0, [r8, #8]
	ldrh r0, [r4, #0x30]
	strh r0, [r8, #0xa]
	ldrh r0, [r4, #0x32]
	strh r0, [r8, #0xc]
	ldrh r0, [r4, #0x44]
	strh r0, [r8, #0xe]
	ldrh r0, [r4, #0x46]
	strh r0, [r8, #0x10]
	ldrh r0, [r4, #0x40]
	strh r0, [r8, #0x12]
	ldrh r0, [r4, #0x42]
	strh r0, [r8, #0x14]
	ldrh r0, [r4, #0x98]
	strh r0, [r8, #0x16]
	ldrh r0, [r4, #0x92]
	strb r0, [r8, #0x18]
	ldrh r0, [r4, #0x94]
	strb r0, [r8, #0x19]
	ldrh r0, [r4, #0x9a]
	strb r0, [r8, #0x1a]
	ldrh r0, [r4, #0x9c]
	strb r0, [r8, #0x1b]
_027E861C:
	ands r0, r5, #1
	beq _027E8634
	ldrh r0, [r9, #4]
	cmp r0, #0
	moveq r0, #0x10
	strh r0, [r4, #0x58]
_027E8634:
	ands r0, r5, #2
	beq _027E8658
	ldrh r1, [r9, #6]
	cmp r1, #0
	moveq r1, #0x10
	strh r1, [r4, #0x5a]
	ldrsh r0, [r4, #0x62]
	cmp r0, r1
	strgth r1, [r4, #0x62]
_027E8658:
	ands r0, r5, #4
	beq _027E867C
	ldrh r1, [r9, #8]
	cmp r1, #0
	moveq r1, #0x10
	strh r1, [r4, #0x5c]
	ldrsh r0, [r4, #0x62]
	cmp r0, r1
	strgth r1, [r4, #0x62]
_027E867C:
	ands r0, r5, #8
	beq _027E86AC
	ldrh r0, [r9, #0xa]
	add r1, r0, #1
	bic r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	ldrh r1, [r4, #0x34]
	cmp r2, r1
	movhi r6, #6
	bhi _027E86AC
	bl WMSP_SetParentSize
_027E86AC:
	ands r0, r5, #0x10
	beq _027E86DC
	ldrh r0, [r9, #0xc]
	add r1, r0, #1
	bic r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	ldrh r1, [r4, #0x36]
	cmp r2, r1
	movhi r6, #6
	bhi _027E86DC
	bl SDK_AUTOLOAD_MAIN_START
_027E86DC:
	ands r0, r5, #0x20
	beq _027E8730
	ldrh r8, [r9, #0xe]
	ldr r0, _027E884C // =0x00002710
	cmp r8, r0
	movhi r6, #6
	bhi _027E8730
	strh r8, [r4, #0x44]
	mov r1, #0
	ldr r0, _027E8850 // =0x000082EA
	umull r3, r2, r8, r0
	mla r2, r8, r1, r2
	mla r2, r1, r0, r2
	mov r0, r2, lsr #6
	mov r1, r3, lsr #6
	orr r1, r1, r2, lsl #26
	mov r2, r0, lsr #0xa
	mov r1, r1, lsr #0xa
	orr r1, r1, r0, lsl #22
	str r1, [r4, #0x48]
	str r2, [r4, #0x4c]
_027E8730:
	ands r0, r5, #0x40
	beq _027E8784
	ldrh r8, [r9, #0x10]
	ldr r0, _027E884C // =0x00002710
	cmp r8, r0
	movhi r6, #6
	bhi _027E8784
	strh r8, [r4, #0x46]
	mov r1, #0
	ldr r0, _027E8850 // =0x000082EA
	umull r3, r2, r8, r0
	mla r2, r8, r1, r2
	mla r2, r1, r0, r2
	mov r0, r2, lsr #6
	mov r1, r3, lsr #6
	orr r1, r1, r2, lsl #26
	mov r2, r0, lsr #0xa
	mov r1, r1, lsr #0xa
	orr r1, r1, r0, lsl #22
	str r1, [r4, #0x50]
	str r2, [r4, #0x54]
_027E8784:
	ands r0, r5, #0x80
	beq _027E87B8
	ldrh r1, [r9, #0x12]
	cmp r1, #0xbe
	bls _027E87AC
	cmp r1, #0xdc
	blo _027E87B4
	ldr r0, _027E8854 // =0x00000106
	cmp r1, r0
	bhi _027E87B4
_027E87AC:
	strh r1, [r4, #0x40]
	b _027E87B8
_027E87B4:
	mov r6, #6
_027E87B8:
	ands r0, r5, #0x100
	beq _027E87EC
	ldrh r1, [r9, #0x14]
	cmp r1, #0xbe
	bls _027E87E0
	cmp r1, #0xdc
	blo _027E87E8
	ldr r0, _027E8854 // =0x00000106
	cmp r1, r0
	bhi _027E87E8
_027E87E0:
	strh r1, [r4, #0x42]
	b _027E87EC
_027E87E8:
	mov r6, #6
_027E87EC:
	ands r0, r5, #0x200
	ldrneh r0, [r9, #0x16]
	strneh r0, [r4, #0x98]
	ands r0, r5, #0x400
	ldrneb r0, [r9, #0x18]
	strneh r0, [r4, #0x92]
	ands r0, r5, #0x800
	ldrneb r0, [r9, #0x19]
	strneh r0, [r4, #0x94]
	ands r0, r5, #0x1000
	ldrneb r0, [r9, #0x1a]
	strneh r0, [r4, #0x9a]
	ands r0, r5, #0x2000
	ldrneb r0, [r9, #0x1b]
	strneh r0, [r4, #0x9c]
	mov r0, r7
	bl OS_RestoreInterrupts
	mov r0, r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027E8840: .word 0x027F9454
_027E8844: .word 0x0000FFF7
_027E8848: .word 0x00003FFF
_027E884C: .word 0x00002710
_027E8850: .word 0x000082EA
_027E8854: .word 0x00000106
	arm_func_end WMSP_SetMPParameterCore

	arm_func_start WMSP_SetMPParameter
WMSP_SetMPParameter: // 0x027E8858
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r6, r0
	add r0, r6, #4
	add r1, sp, #0
	bl WMSP_SetMPParameterCore
	mov r5, r0
	bl WMSP_GetBuffer4Callback2Wm9
	mov r4, r0
	mov r0, #0x23
	strh r0, [r4]
	strh r5, [r4, #2]
	ldr r0, [r6, #4]
	str r0, [r4, #4]
	add r0, sp, #0
	add r1, r4, #8
	mov r2, #0x1c
	bl MI_CpuCopy8
	mov r0, r4
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end WMSP_SetMPParameter

	arm_func_start WmspError_17
WmspError_17: // 0x027E88B4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x24
	strh r1, [r0]
	mov r1, #1
	strh r1, [r0, #2]
	strh r5, [r0, #4]
	strh r4, [r0, #6]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WmspError_17

	arm_func_start WMSP_SetBeaconPeriod
WMSP_SetBeaconPeriod: // 0x027E88F0
	stmdb sp!, {lr}
	sub sp, sp, #0x204
	mov r1, r0
	add r0, sp, #0
	ldr r1, [r1, #4]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl WMSP_WL_ParamSetBeaconPeriod
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E8928
	ldr r0, _027E894C // =0x00000242
	bl WmspError_17
	b _027E8940
_027E8928:
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x24
	strh r1, [r0]
	mov r1, #0
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
_027E8940:
	add sp, sp, #0x204
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E894C: .word 0x00000242
	arm_func_end WMSP_SetBeaconPeriod

	arm_func_start WMSP_AutoDisconnect
WMSP_AutoDisconnect: // 0x027E8950
	mov r1, #1
	mov r2, #0
	ldr ip, _027E8960 // =WMSP_DisconnectCore
	bx ip
	.align 2, 0
_027E8960: .word WMSP_DisconnectCore
	arm_func_end WMSP_AutoDisconnect

	arm_func_start WMSP_SetPowerSaveMode
WMSP_SetPowerSaveMode: // 0x027E8964
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x234
	mov r7, r0
	ldr r0, _027E8AE0 // =0x027F9454
	ldr r4, [r0, #0x550]
	add r6, sp, #0x30
	bl WMSP_GetBuffer4Callback2Wm9
	mov r5, r0
	mov r1, #0x28
	strh r1, [r5]
	ldrh r1, [r4, #0]
	cmp r1, #0xb
	beq _027E89A8
	mov r1, #3
	strh r1, [r5, #2]
	bl WMSP_ReturnResult2Wm9
	b _027E8AD4
_027E89A8:
	ldr r0, [r7, #4]
	cmp r0, #1
	moveq r1, #1
	movne r1, #0
	mov r0, r6
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, #0
	mov r3, #1
	bl WMSP_WL_MlmePowerManagement
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E89FC
	mov r1, #1
	strh r1, [r5, #2]
	strh r1, [r5, #4]
	ldrh r0, [r0, #4]
	strh r0, [r5, #6]
	mov r0, r5
	bl WMSP_ReturnResult2Wm9
	b _027E8AD4
_027E89FC:
	ldr r0, _027E8AE0 // =0x027F9454
	ldr r4, [r0, #0x550]
	ldr r0, _027E8AE4 // =0x0000018A
	add r0, r4, r0
	add r1, r4, #0xa2
	mov r2, #6
	bl MI_CpuCopy8
	add r0, sp, #0x30
	str r0, [r4, #0xa8]
	mov r0, #0
	strh r0, [r4, #0xac]
	mov r1, #1
	str r1, [r4, #0x18]
	add r1, sp, #0
	mov r2, #0x30
	bl MIi_CpuClear16
	mov r0, #0
	strh r0, [sp]
	strh r0, [sp, #6]
	add r0, r4, #0x100
	ldrh r0, [r0, #0xec]
	cmp r0, #2
	moveq r0, #0x14
	movne r0, #0xa
	strb r0, [sp, #0xe]
	ldr r0, _027E8AE4 // =0x0000018A
	add r0, r4, r0
	add r1, sp, #0x18
	mov r2, #6
	bl MI_CpuCopy8
	add r0, r4, #0xe0
	add r1, sp, #0x1e
	mov r2, #6
	bl MI_CpuCopy8
	add r0, sp, #0x30
	str r0, [sp, #0x2c]
	add r1, sp, #0
	bl WMSP_WL_MaData
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E8AC4
	mov r1, #1
	strh r1, [r5, #2]
	mov r1, #0x100
	strh r1, [r5, #4]
	ldrh r0, [r0, #4]
	strh r0, [r5, #6]
	mov r0, r5
	bl WMSP_ReturnResult2Wm9
	b _027E8AD4
_027E8AC4:
	mov r0, #0
	strh r0, [r5, #2]
	mov r0, r5
	bl WMSP_ReturnResult2Wm9
_027E8AD4:
	add sp, sp, #0x234
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027E8AE0: .word 0x027F9454
_027E8AE4: .word 0x0000018A
	arm_func_end WMSP_SetPowerSaveMode

	arm_func_start WMSP_StartTestRxMode
WMSP_StartTestRxMode: // 0x027E8AE8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x29
	strh r1, [r0]
	mov r1, #4
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WMSP_StartTestRxMode

	arm_func_start WMSP_StopTestRxMode
WMSP_StopTestRxMode: // 0x027E8B14
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WMSP_GetBuffer4Callback2Wm9
	mov r1, #0x2a
	strh r1, [r0]
	mov r1, #4
	strh r1, [r0, #2]
	bl WMSP_ReturnResult2Wm9
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end WMSP_StopTestRxMode

	arm_func_start WL_GetThreadStruct
WL_GetThreadStruct: // 0x027E8B40
	ldr r0, _027E8B50 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x18
	bx lr
	.align 2, 0
_027E8B50: .word 0x0380FFF4
	arm_func_end WL_GetThreadStruct

	arm_func_start WL_InitDriver
WL_InitDriver: // 0x027E8B54
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, r0
	ldr r1, [r4, #0]
	ldr r0, _027E8D18 // =0x0380FFF4
	str r1, [r0]
	mov r0, #0
	ldr r2, _027E8D1C // =0x00000694
	bl MIi_CpuClearFast
	bl OS_GetLockID
	ldr r2, _027E8D18 // =0x0380FFF4
	ldr r1, [r2, #0]
	str r0, [r1, #0x314]
	ldr r1, [r4, #0x18]
	ldr r0, [r2, #0]
	str r1, [r0, #0x30c]
	ldr r0, [r4, #0x1c]
	mov r1, r0, lsr #1
	ldr r0, [r2, #0]
	str r1, [r0, #0x310]
	ldr r1, [r2, #0]
	ldr r0, [r1, #0x310]
	cmp r0, #0
	mvneq r0, #0
	streq r0, [r1, #0x310]
	add r0, r4, #0x20
	bl InitializeHeapBuf
	bl FLASH_MakeImage
	ldr r1, _027E8D20 // =0x04000304
	ldrh r0, [r1, #0]
	orr r0, r0, #2
	strh r0, [r1]
	mov r1, #0x30
	ldr r0, _027E8D24 // =0x04000206
	strh r1, [r0]
	mov r1, #3
	ldr r2, _027E8D18 // =0x0380FFF4
	ldr r0, [r2, #0]
	str r1, [r0, #0x68c]
	mov r0, #0x3c
	mov r1, #2
	ldr r3, [r2, #0]
	ldr r2, _027E8D28 // =0x00000692
	add r2, r3, r2
	bl FLASH_Read
	mov r0, #0x3e
	mov r1, #2
	ldr r2, _027E8D18 // =0x0380FFF4
	ldr r2, [r2, #0]
	add r2, r2, #0x690
	bl FLASH_Read
	ldr r1, [r4, #0x10]
	ldr r2, _027E8D18 // =0x0380FFF4
	ldr r0, [r2, #0]
	str r1, [r0, #0x308]
	ldr r1, [r4, #0x14]
	ldr r0, [r2, #0]
	str r1, [r0, #0x304]
	ldr r0, [r4, #0x30]
	mov r1, #0x1c
	bl _u32_div_f
	mov r1, r0
	ldr r0, [r4, #0x2c]
	bl InitializeParam
	bl InitializeTask
	bl InitializeCmdIf
	bl InitializeMLME
	bl InitializeCAM
	bl InitializeAlarm
	add r0, sp, #8
	bl FLASH_VerifyCheckSum
	cmp r0, #0
	beq _027E8C94
	ldr r0, _027E8D18 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0x3e]
	orr r1, r1, #0x80
	strh r1, [r0, #0x3e]
	b _027E8CBC
_027E8C94:
	bl WConfigDevice
	bl DiagMacRegister
	bl WWakeUp
	bl InitMac
	bl InitRF
	bl DiagMacMemory
	bl DiagBaseBand
	bl InitBaseBand
	bl WSetDefaultParameters
	bl WShutdown
_027E8CBC:
	ldr r0, [r4, #8]
	str r0, [sp]
	ldr r0, [r4, #0xc]
	str r0, [sp, #4]
	ldr r0, _027E8D18 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x18
	ldr r1, _027E8D2C // =MainTaskRoutine
	mov r2, #0
	ldr r3, [r4, #4]
	bl OS_CreateThread
	ldr r0, _027E8D18 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x18
	bl OS_WakeupThreadDirect
	bl InitializeIntr
	ldr r0, _027E8D18 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3e]
	add sp, sp, #0x10
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E8D18: .word 0x0380FFF4
_027E8D1C: .word 0x00000694
_027E8D20: .word 0x04000304
_027E8D24: .word 0x04000206
_027E8D28: .word 0x00000692
_027E8D2C: .word MainTaskRoutine
	arm_func_end WL_InitDriver

	arm_func_start WlessLibReboot
WlessLibReboot: // 0x027E8D30
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl ClearTimeOut
	bl WShutdown
	bl InitMac
	bl ReleaseAllWlHeapBuf
	bl InitializeTask
	ldr r0, _027E8D80 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x31c]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x20]
	bl InitializeParam
	bl InitializeCmdIf
	bl InitializeMLME
	bl InitializeCAM
	bl WSetDefaultParameters
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E8D80: .word 0x0380FFF4
	arm_func_end WlessLibReboot

	arm_func_start InitializeTask
InitializeTask: // 0x027E8D84
	stmdb sp!, {r4, lr}
	ldr r0, _027E8E04 // =0x0380FFF4
	ldr r4, [r0, #0]
	mov r3, #0
	strh r3, [r4, #0x10]
	strh r3, [r4, #0x12]
	ldr r2, _027E8E08 // =0x0000FFFF
_027E8DA0:
	mov r1, r3, lsl #1
	add r0, r4, r3, lsl #1
	strh r2, [r0, #8]
	ldrh r0, [r0, #8]
	strh r0, [r4, r1]
	add r3, r3, #1
	cmp r3, #4
	blo _027E8DA0
	mov lr, #0
	ldr ip, _027E8E08 // =0x0000FFFF
	mov r2, lr
	ldr r1, _027E8E0C // =pTaskFunc
_027E8DD0:
	add r3, r4, lr, lsl #3
	strh ip, [r3, #0xbc]
	strh r2, [r3, #0xbe]
	ldr r0, [r1, lr, lsl #2]
	str r0, [r3, #0xc0]
	add lr, lr, #1
	cmp lr, #0x18
	blo _027E8DD0
	mov r0, #3
	mov r1, #0xc
	bl AddTask
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E8E04: .word 0x0380FFF4
_027E8E08: .word 0x0000FFFF
_027E8E0C: .word pTaskFunc
	arm_func_end InitializeTask

	arm_func_start ReleaseAllHeapBuf
ReleaseAllHeapBuf: // 0x027E8E10
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r6, [r7, #0]
	ldrh r0, [r7, #8]
	cmp r0, #0
	beq _027E8E58
	mvn r4, #0
	b _027E8E50
_027E8E34:
	mov r0, r6
	bl GetHeapBufNextAdrs
	mov r5, r0
	mov r0, r7
	mov r1, r6
	bl ReleaseHeapBuf
	mov r6, r5
_027E8E50:
	cmp r6, r4
	bne _027E8E34
_027E8E58:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end ReleaseAllHeapBuf

	arm_func_start ReleaseAllWlHeapBuf
ReleaseAllWlHeapBuf: // 0x027E8E64
	stmdb sp!, {r4, lr}
	ldr r0, _027E8EBC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r4, r0, #0x17c
	add r0, r4, #0x18
	bl ReleaseAllHeapBuf
	add r0, r4, #0x24
	bl ReleaseAllHeapBuf
	add r0, r4, #0x30
	bl ReleaseAllHeapBuf
	add r0, r4, #0x3c
	bl ReleaseAllHeapBuf
	add r0, r4, #0x48
	bl ReleaseAllHeapBuf
	add r0, r4, #0x54
	bl ReleaseAllHeapBuf
	add r0, r4, #0x60
	bl ReleaseAllHeapBuf
	add r0, r4, #0x6c
	bl ReleaseAllHeapBuf
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E8EBC: .word 0x0380FFF4
	arm_func_end ReleaseAllWlHeapBuf

	arm_func_start InitializeHeapBuf
InitializeHeapBuf: // 0x027E8EC0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _027E8FA0 // =0x0380FFF4
	ldr r2, [r1, #0]
	add r5, r2, #0x17c
	add r4, r2, #0x344
	ldr r1, [r0, #0]
	str r1, [r2, #0x17c]
	ldr r1, [r0, #4]
	str r1, [r5, #4]
	ldr r0, [r0, #8]
	str r0, [r5, #8]
	add r0, r5, #0xc
	mov r1, #2
	bl InitHeapBufMan
	add r0, r5, #0x18
	mov r1, #3
	bl InitHeapBufMan
	add r0, r5, #0x24
	mov r1, #4
	bl InitHeapBufMan
	add r0, r5, #0x30
	mov r1, #5
	bl InitHeapBufMan
	add r0, r5, #0x3c
	mov r1, #6
	bl InitHeapBufMan
	add r0, r5, #0x48
	mov r1, #7
	bl InitHeapBufMan
	add r0, r5, #0x54
	mov r1, #8
	bl InitHeapBufMan
	add r0, r5, #0x60
	mov r1, #9
	bl InitHeapBufMan
	add r0, r5, #0x6c
	mov r1, #0xa
	bl InitHeapBufMan
	add r0, r5, #0x78
	mov r1, #0xb
	bl InitHeapBufMan
	add r0, r5, #0x84
	mov r1, #0xc
	bl InitHeapBufMan
	add r0, r5, #0xc
	mov r1, #0x81
	bl AllocateHeapBuf
	add r0, r0, #0xc
	str r0, [r4, #0x9c]
	mov r0, #0
	strh r0, [r4, #0xa0]
	strh r0, [r4, #0xa4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E8FA0: .word 0x0380FFF4
	arm_func_end InitializeHeapBuf

	arm_func_start InitHeapBufMan
InitHeapBufMan: // 0x027E8FA4
	mvn r2, #0
	str r2, [r0]
	str r2, [r0, #4]
	mov r2, #0
	strh r2, [r0, #8]
	strh r1, [r0, #0xa]
	bx lr
	arm_func_end InitHeapBufMan

	arm_func_start ReleaseWlTask
ReleaseWlTask: // 0x027E8FC0
	stmdb sp!, {r4, lr}
	ldr r0, _027E9010 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r4, r0, #0x17c
	bl ReleaseIntr
	add r0, r4, #0xc
	ldr r1, _027E9010 // =0x0380FFF4
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x318]
	sub r1, r1, #0xc
	bl ReleaseHeapBuf
	add r0, r4, #0xc
	ldr r1, _027E9010 // =0x0380FFF4
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x3e0]
	sub r1, r1, #0xc
	bl ReleaseHeapBuf
	bl OS_ExitThread
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E9010: .word 0x0380FFF4
	arm_func_end ReleaseWlTask

	arm_func_start TerminateWlTask
TerminateWlTask: // 0x027E9014
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _027E90B0 // =0x0380FFF4
	ldr r0, [r2, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0x3e]
	orr r1, r1, #0x8000
	strh r1, [r0, #0x3e]
	ldr r0, [r2, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x4c]
	cmp r0, #0
	beq _027E9084
	bl WStop
	ldr r2, _027E90B0 // =0x0380FFF4
	ldr r0, [r2, #0]
	add r0, r0, #0x400
	ldrh r1, [r0, #4]
	cmp r1, #0
	beq _027E9080
	mov r1, #0
	strh r1, [r0, #4]
	mov r1, #6
	ldr r0, [r2, #0]
	ldr r0, [r0, #0x420]
	strh r1, [r0, #4]
	bl IssueMlmeConfirm
_027E9080:
	bl WShutdown
_027E9084:
	mov r0, #3
	bl DeleteTask
	ldr r1, _027E90B4 // =0x0000FFFF
	cmp r0, r1
	bne _027E9084
	mov r0, #3
	mov r1, #0x17
	bl AddTask
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E90B0: .word 0x0380FFF4
_027E90B4: .word 0x0000FFFF
	arm_func_end TerminateWlTask

	arm_func_start SendFatalErrMsgTask
SendFatalErrMsgTask: // 0x027E90B8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _027E9138 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r5, r1, #0x344
	ldrh r0, [r5, #0xb0]
	cmp r0, #0
	beq _027E912C
	add r0, r1, #0x188
	mov r1, #0x12
	bl AllocateHeapBuf
	movs r4, r0
	beq _027E912C
	ldr r0, _027E913C // =0x00000186
	strh r0, [r4, #0xc]
	mov r0, #1
	strh r0, [r4, #0xe]
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	ldrh r1, [r5, #0xb0]
	strh r1, [r4, #0x10]
	mov r1, #0
	strh r1, [r5, #0xb0]
	bl OS_EnableIrqMask
	ldr r0, _027E9138 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, r4
	bl SendMessageToWmDirect
_027E912C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E9138: .word 0x0380FFF4
_027E913C: .word 0x00000186
	arm_func_end SendFatalErrMsgTask

	arm_func_start SetFatalErr
SetFatalErr: // 0x027E9140
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	ldr r1, _027E9180 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r2, [r1, #0xf4]
	orr r2, r2, r4
	strh r2, [r1, #0xf4]
	bl OS_EnableIrqMask
	mov r0, #2
	mov r1, #0x15
	bl AddTask
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E9180: .word 0x0380FFF4
	arm_func_end SetFatalErr

	arm_func_start WCheckTxBuf
WCheckTxBuf: // 0x027E9184
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _027E9280 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r5, r1, #0x344
	ldr r0, _027E9284 // =0x0000042C
	add r4, r1, r0
	add r0, r1, #0x300
	ldrh r0, [r0, #0x50]
	cmp r0, #1
	beq _027E91C0
	cmp r0, #2
	beq _027E91F4
	cmp r0, #3
	b _027E9230
_027E91C0:
	add r0, r4, #0x78
	bl WCheckTxBufIdBeforeFrame
	cmp r0, #0
	beq _027E91D8
	bl WaitMacStop
	bl MakeBeaconFrame
_027E91D8:
	add r0, r4, #0x28
	bl WCheckTxBufIdBeforeFrame
	cmp r0, #0
	beq _027E9230
	add r0, r4, #0x28
	bl RestoreTxFrame
	b _027E9230
_027E91F4:
	add r0, r4, #0x64
	bl WCheckTxBufIdBeforeFrame
	add r0, r4, #0x28
	bl WCheckTxBufIdBeforeFrame
	cmp r0, #0
	beq _027E9230
	ldrh r0, [r4, #0x28]
	cmp r0, #0
	beq _027E921C
	bl WaitMacStop
_027E921C:
	ldrh r0, [r5, #0x6a]
	bl MakePsPollFrame
	ldrh r0, [r5, #0xb8]
	add r0, r0, #1
	strh r0, [r5, #0xb8]
_027E9230:
	add r0, r4, #0x14
	bl WCheckTxBufIdBeforeFrame
	cmp r0, #0
	beq _027E9248
	add r0, r4, #0x14
	bl RestoreTxFrame
_027E9248:
	mov r0, r4
	bl WCheckTxBufIdBeforeFrame
	cmp r0, #0
	beq _027E9260
	mov r0, r4
	bl RestoreTxFrame
_027E9260:
	ldr r1, _027E9288 // =0x04808004
	ldrh r0, [r1, #0]
	cmp r0, #0
	moveq r0, #1
	streqh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E9280: .word 0x0380FFF4
_027E9284: .word 0x0000042C
_027E9288: .word 0x04808004
	arm_func_end WCheckTxBuf

	arm_func_start RestoreTxFrame
RestoreTxFrame: // 0x027E928C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #0]
	cmp r0, #0
	beq _027E92CC
	bl WaitMacStop
	ldr r0, [r4, #8]
	ldr r1, [r4, #0xc]
	sub r1, r1, #0x10
	bl CopyTxFrmToMacBuf
	ldr r0, _027E92D4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0xfc]
	add r1, r1, #1
	strh r1, [r0, #0xfc]
_027E92CC:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E92D4: .word 0x0380FFF4
	arm_func_end RestoreTxFrame

	arm_func_start WaitMacStop
WaitMacStop: // 0x027E92D8
	mov r1, #0
	ldr r0, _027E9314 // =0x04808004
	strh r1, [r0]
	mov r2, #0x10
	ldr r1, _027E9318 // =0x04808214
	b _027E9308
_027E92F0:
	ldrh r0, [r1, #0]
	cmp r0, #0
	bxeq lr
	cmp r0, #9
	bxeq lr
	sub r2, r2, #1
_027E9308:
	cmp r2, #0
	bne _027E92F0
	bx lr
	.align 2, 0
_027E9314: .word 0x04808004
_027E9318: .word 0x04808214
	arm_func_end WaitMacStop

	arm_func_start WCheckTxBufIdBeforeFrame
WCheckTxBufIdBeforeFrame: // 0x027E931C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, [r0, #8]
	sub lr, r3, #4
	ldrh r2, [r3, #-4]
	ldr r1, _027E93A4 // =0x0000B6B8
	cmp r2, r1
	bne _027E934C
	ldrh r2, [lr, #2]
	ldr r1, _027E93A8 // =0x00001D46
	cmp r2, r1
	beq _027E9394
_027E934C:
	mov ip, #1
	strh ip, [r3, #0xa]
	ldr r3, _027E93A4 // =0x0000B6B8
	strh r3, [lr]
	ldr r2, _027E93A8 // =0x00001D46
	strh r2, [lr, #2]
	ldr r0, [r0, #8]
	add r1, r0, #0xc
	strh r3, [r0, #0xc]
	strh r2, [r1, #2]
	ldr r0, _027E93AC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0xfa]
	add r1, r1, #1
	strh r1, [r0, #0xfa]
	mov r0, ip
	b _027E9398
_027E9394:
	mov r0, #0
_027E9398:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E93A4: .word 0x0000B6B8
_027E93A8: .word 0x00001D46
_027E93AC: .word 0x0380FFF4
	arm_func_end WCheckTxBufIdBeforeFrame

	arm_func_start calc_NextCRC
calc_NextCRC: // 0x027E93B0
	and r2, r1, #0xf
	mov r3, r2, lsl #1
	ldr r2, _027E9420 // =crc16_table
	ldrh ip, [r2, r3]
	ldr r3, _027E9424 // =0x00000FFF
	and r1, r3, r1, asr #4
	mov r1, r1, lsl #0x10
	eor ip, ip, r1, lsr #16
	and r1, r0, #0xf
	mov r1, r1, lsl #1
	ldrh r1, [r2, r1]
	eor r1, ip, r1
	mov r1, r1, lsl #0x10
	mov ip, r1, lsr #0x10
	and r1, r3, ip, asr #4
	mov r1, r1, lsl #0x10
	and r3, ip, #0xf
	mov r3, r3, lsl #1
	ldrh r3, [r2, r3]
	eor r1, r3, r1, lsr #16
	mov r0, r0, asr #4
	and r0, r0, #0xf
	mov r0, r0, lsl #1
	ldrh r0, [r2, r0]
	eor r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_027E9420: .word crc16_table
_027E9424: .word 0x00000FFF
	arm_func_end calc_NextCRC

	arm_func_start RND_rand
RND_rand: // 0x027E9428
	ldr r0, _027E9454 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r3, r0, #0x5f0
	ldrh r2, [r3, #2]
	ldrh r1, [r3, #4]
	add r0, r0, #0x500
	ldrh r0, [r0, #0xf0]
	mla r0, r1, r0, r2
	strh r0, [r3, #4]
	ldrh r0, [r3, #4]
	bx lr
	.align 2, 0
_027E9454: .word 0x0380FFF4
	arm_func_end RND_rand

	arm_func_start RND_seed
RND_seed: // 0x027E9458
	ldr r1, _027E946C // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x500
	strh r0, [r1, #0xf4]
	bx lr
	.align 2, 0
_027E946C: .word 0x0380FFF4
	arm_func_end RND_seed

	arm_func_start RND_init
RND_init: // 0x027E9470
	ldr r2, _027E949C // =0x0380FFF4
	ldr r3, [r2, #0]
	add ip, r3, #0x5f0
	ldr r2, _027E94A0 // =0x0000FFF8
	and r0, r0, r2
	add r2, r0, #5
	add r0, r3, #0x500
	strh r2, [r0, #0xf0]
	orr r0, r1, #1
	strh r0, [ip, #2]
	bx lr
	.align 2, 0
_027E949C: .word 0x0380FFF4
_027E94A0: .word 0x0000FFF8
	arm_func_end RND_init

	arm_func_start WL_ReadByte
WL_ReadByte: // 0x027E94A4
	ands r1, r0, #1
	ldrneh r0, [r0, #-1]
	movne r0, r0, asr #8
	andne r0, r0, #0xff
	ldreqh r0, [r0, #0]
	andeq r0, r0, #0xff
	and r0, r0, #0xff
	bx lr
	arm_func_end WL_ReadByte

	arm_func_start WL_WriteByte
WL_WriteByte: // 0x027E94C4
	ands r2, r0, #1
	ldrneh r2, [r0, #-1]
	andne r2, r2, #0xff
	orrne r1, r2, r1, lsl #8
	strneh r1, [r0, #-1]
	ldreqh r2, [r0, #0]
	andeq r2, r2, #0xff00
	andeq r1, r1, #0xff
	orreq r1, r2, r1
	streqh r1, [r0]
	bx lr
	arm_func_end WL_WriteByte

	arm_func_start DMA_WepWriteHeaderData
DMA_WepWriteHeaderData: // 0x027E94F0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r2
	mov r4, r3
	mov r2, #0x12
	bl DMA_WriteCore
	cmp r4, #0
	beq _027E9524
	add r0, r6, #0x28
	mov r1, r5
	add r2, r4, #1
	mov r2, r2, lsr #1
	bl DMA_WriteCore
_027E9524:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end DMA_WepWriteHeaderData

	arm_func_start DMA_WriteHeaderData
DMA_WriteHeaderData: // 0x027E952C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r2
	mov r4, r3
	mov r2, #0x12
	bl DMA_WriteCore
	cmp r4, #0
	beq _027E9560
	add r0, r6, #0x24
	mov r1, r5
	add r2, r4, #1
	mov r2, r2, lsr #1
	bl DMA_WriteCore
_027E9560:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end DMA_WriteHeaderData

	arm_func_start DMA_Write
DMA_Write: // 0x027E9568
	add r2, r2, #1
	mov r2, r2, lsr #1
	ldr ip, _027E9578 // =DMA_WriteCore
	bx ip
	.align 2, 0
_027E9578: .word DMA_WriteCore
	arm_func_end DMA_Write

	arm_func_start DMA_WriteCore
DMA_WriteCore: // 0x027E957C
	mov r3, r0
	mov r0, r1
	mov r1, r3
	mov r2, r2, lsl #1
	ldr ip, _027E9594 // =MIi_CpuCopy16
	bx ip
	.align 2, 0
_027E9594: .word MIi_CpuCopy16
	arm_func_end DMA_WriteCore

	arm_func_start DMA_Read
DMA_Read: // 0x027E9598
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	add r0, r2, #1
	bic r2, r0, #1
	add r1, r6, r2
	ldr r0, _027E9614 // =0x04805F60
	cmp r1, r0
	subhi r5, r0, r6
	subhi r4, r2, r5
	movls r5, r2
	movls r4, #0
	mov r0, r6
	mov r1, r7
	mov r2, r5
	bl MIi_CpuCopy16
	cmp r4, #0
	beq _027E9608
	add r1, r6, r5
	ldr r0, _027E9618 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xde]
	sub r0, r1, r0
	add r1, r7, r5
	mov r2, r4
	bl MIi_CpuCopy16
_027E9608:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027E9614: .word 0x04805F60
_027E9618: .word 0x0380FFF4
	arm_func_end DMA_Read

	arm_func_start ClearTimeOut
ClearTimeOut: // 0x027E961C
	ldr r0, _027E9634 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027E9638 // =0x00000634
	add r0, r1, r0
	ldr ip, _027E963C // =OS_CancelAlarm
	bx ip
	.align 2, 0
_027E9634: .word 0x0380FFF4
_027E9638: .word 0x00000634
_027E963C: .word OS_CancelAlarm
	arm_func_end ClearTimeOut

	arm_func_start SetupUsTimeOut
SetupUsTimeOut: // 0x027E9640
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldr r0, _027E96C4 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027E96C8 // =0x00000634
	add r0, r1, r0
	bl OS_CancelAlarm
	mov r3, #0
	ldr r0, _027E96CC // =0x000082EA
	umull ip, r2, r5, r0
	mla r2, r5, r3, r2
	mla r2, r3, r0, r2
	mov r1, r2, lsr #6
	mov r0, ip, lsr #6
	orr r0, r0, r2, lsl #26
	mov r2, #0x3e8
	bl _ll_udiv
	mov r3, r0
	mov r2, r1
	mov r0, #0
	str r0, [sp]
	ldr r0, _027E96C4 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027E96C8 // =0x00000634
	add r0, r1, r0
	mov r1, r3
	mov r3, r4
	bl OS_SetAlarm
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E96C4: .word 0x0380FFF4
_027E96C8: .word 0x00000634
_027E96CC: .word 0x000082EA
	arm_func_end SetupUsTimeOut

	arm_func_start SetupTimeOut
SetupTimeOut: // 0x027E96D0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldr r0, _027E973C // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027E9740 // =0x00000634
	add r0, r1, r0
	bl OS_CancelAlarm
	mov r2, #0
	str r2, [sp]
	ldr r0, _027E973C // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027E9740 // =0x00000634
	add r0, r1, r0
	ldr r1, _027E9744 // =0x000082EA
	umull ip, r3, r5, r1
	mla r3, r5, r2, r3
	mla r3, r2, r1, r3
	mov r2, r3, lsr #6
	mov r1, ip, lsr #6
	orr r1, r1, r3, lsl #26
	mov r3, r4
	bl OS_SetAlarm
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027E973C: .word 0x0380FFF4
_027E9740: .word 0x00000634
_027E9744: .word 0x000082EA
	arm_func_end SetupTimeOut

	arm_func_start WIntervalTimer
WIntervalTimer: // 0x027E9748
	stmdb sp!, {r4, lr}
	ldr r0, _027E97C4 // =0x0380FFF4
	ldr r4, [r0, #0]
	ldr r0, [r4, #0x3ec]
	add r0, r0, #1
	str r0, [r4, #0x3ec]
	mov r0, #1
	mov r1, #0xa
	bl AddTask
	mov r0, #2
	mov r1, #0x12
	bl AddTask
	mov r0, #1
	mov r1, #0x11
	bl AddTask
	add r0, r4, #0x100
	ldrh r0, [r0, #0xfc]
	cmp r0, #0
	beq _027E97A0
	mov r0, #2
	mov r1, #0x13
	bl AddTask
_027E97A0:
	add r0, r4, #0x300
	ldrh r0, [r0, #0xf4]
	cmp r0, #0
	beq _027E97BC
	mov r0, #2
	mov r1, #0x15
	bl AddTask
_027E97BC:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E97C4: .word 0x0380FFF4
	arm_func_end WIntervalTimer

	arm_func_start ClearPeriodicTimeOut
ClearPeriodicTimeOut: // 0x027E97C8
	ldr r0, _027E97E0 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027E97E4 // =0x00000608
	add r0, r1, r0
	ldr ip, _027E97E8 // =OS_CancelAlarm
	bx ip
	.align 2, 0
_027E97E0: .word 0x0380FFF4
_027E97E4: .word 0x00000608
_027E97E8: .word OS_CancelAlarm
	arm_func_end ClearPeriodicTimeOut

	arm_func_start SetupPeriodicTimeOut
SetupPeriodicTimeOut: // 0x027E97EC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r5, r0
	mov r4, r1
	ldr r0, _027E9870 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027E9874 // =0x00000608
	add r0, r1, r0
	bl OS_CancelAlarm
	mov r1, #0
	ldr r0, _027E9878 // =0x000082EA
	umull r3, r2, r5, r0
	mla r2, r5, r1, r2
	mla r2, r1, r0, r2
	mov r6, r3, lsr #6
	orr r6, r6, r2, lsl #26
	bl OS_GetTick
	mov r5, #0
	adds ip, r6, r0
	adc r2, r1, #0
	str r4, [sp, #4]
	str r5, [sp, #8]
	mov r3, r6
	str r5, [sp]
	ldr r0, _027E9870 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027E9874 // =0x00000608
	add r0, r1, r0
	mov r1, ip
	bl OS_SetPeriodicAlarm
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027E9870: .word 0x0380FFF4
_027E9874: .word 0x00000608
_027E9878: .word 0x000082EA
	arm_func_end SetupPeriodicTimeOut

	arm_func_start WWaitus
WWaitus: // 0x027E987C
	ldr r1, _027E9888 // =TimeoutDummy
	ldr ip, _027E988C // =WaitLoop_Waitus
	bx ip
	.align 2, 0
_027E9888: .word TimeoutDummy
_027E988C: .word WaitLoop_Waitus
	arm_func_end WWaitus

	arm_func_start WWait
WWait: // 0x027E9890
	mov r1, #0x3e8
	mul r1, r0, r1
	mov r0, r1
	ldr ip, _027E98A4 // =WWaitus
	bx ip
	.align 2, 0
_027E98A4: .word WWaitus
	arm_func_end WWait

	arm_func_start TimeoutDummy
TimeoutDummy: // 0x027E98A8
	mov r1, #0
	str r1, [r0]
	bx lr
	arm_func_end TimeoutDummy

	arm_func_start InitializeAlarm
InitializeAlarm: // 0x027E98B4
	stmdb sp!, {r4, lr}
	ldr r0, _027E9904 // =0x0380FFF4
	ldr r4, [r0, #0]
	bl OS_IsAlarmAvailable
	cmp r0, #0
	addeq r0, r4, #0x300
	ldreqh r1, [r0, #0x3e]
	orreq r1, r1, #0x40
	streqh r1, [r0, #0x3e]
	beq _027E98FC
	ldr r0, _027E9908 // =0x00000608
	add r0, r4, r0
	bl OS_CreateAlarm
	ldr r0, _027E990C // =0x00000634
	add r0, r4, r0
	bl OS_CreateAlarm
	add r0, r4, #0x660
	bl OS_CreateAlarm
_027E98FC:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E9904: .word 0x0380FFF4
_027E9908: .word 0x00000608
_027E990C: .word 0x00000634
	arm_func_end InitializeAlarm

	arm_func_start InitRF
InitRF: // 0x027E9910
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	ldr r0, _027E9A90 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027E9A94 // =0x000005F8
	add r7, r1, r0
	mov r8, #0
	str r8, [sp, #4]
	mov r6, #2
	add r5, sp, #4
	ldr r4, _027E9A98 // =macTxRxRegAdrs
_027E993C:
	mov r0, r8, lsl #1
	add r0, r0, #0x44
	mov r1, r6
	mov r2, r5
	bl FLASH_Read
	ldr r1, [sp, #4]
	mov r0, r8, lsl #1
	ldrh r0, [r4, r0]
	add r0, r0, #0x4800000
	add r0, r0, #0x8000
	strh r1, [r0]
	add r8, r8, #1
	cmp r8, #0x10
	blo _027E993C
	ldrh r0, [r7, #2]
	mov r1, r0, lsr #7
	mov r0, r1, lsl #8
	str r0, [sp]
	ldrh r0, [r7, #2]
	and r0, r0, #0x7f
	orr r1, r0, r1, lsl #8
	str r1, [sp]
	ldr r0, _027E9A9C // =0x04808184
	strh r1, [r0]
	mov r5, #0xce
	ldrh r0, [r7, #2]
	and r0, r0, #0x7f
	add r0, r0, #7
	mov r1, #8
	bl _s32_div_f
	mov r8, r0
	ldrh r4, [r7, #4]
	ldrh r0, [r7, #0]
	cmp r0, #3
	bne _027E9A2C
	add r0, r4, #0xce
	mov r1, #1
	add r2, r7, #8
	bl FLASH_Read
	mov r9, #0
	mov r8, r9
	mov r7, #1
	add r6, sp, #0
	b _027E9A20
_027E99EC:
	str r8, [sp]
	mov r0, r5
	mov r1, r7
	mov r2, r6
	bl FLASH_Read
	ldr r1, [sp]
	mov r0, r9, lsl #8
	add r0, r0, #0x50000
	orr r0, r1, r0
	str r0, [sp]
	bl RF_Write
	add r9, r9, #1
	add r5, r5, #1
_027E9A20:
	cmp r9, r4
	blo _027E99EC
	b _027E9A84
_027E9A2C:
	mov r0, #0
	str r0, [sp]
	add r6, sp, #0
	b _027E9A7C
_027E9A3C:
	mov r0, r5
	mov r1, r8
	mov r2, r6
	bl FLASH_Read
	ldr r0, [sp]
	bl RF_Write
	ldrh r0, [r7, #0]
	cmp r0, #2
	bne _027E9A74
	ldr r1, [sp]
	mov r0, r1, lsr #0x12
	cmp r0, #9
	biceq r0, r1, #0x7c00
	streq r0, [r7, #0xc]
_027E9A74:
	sub r4, r4, #1
	add r5, r5, r8
_027E9A7C:
	cmp r4, #0
	bne _027E9A3C
_027E9A84:
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027E9A90: .word 0x0380FFF4
_027E9A94: .word 0x000005F8
_027E9A98: .word macTxRxRegAdrs
_027E9A9C: .word 0x04808184
	arm_func_end InitRF

	arm_func_start InitBaseBand
InitBaseBand: // 0x027E9AA0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r1, #0x100
	ldr r0, _027E9B0C // =0x04808160
	strh r1, [r0]
	mov r6, #0x64
	mov r7, #0
	str r7, [sp]
	mov r5, #1
	add r4, sp, #0
_027E9AC8:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl FLASH_Read
	mov r0, r7
	ldr r1, [sp]
	bl BBP_Write
	add r6, r6, #1
	add r7, r7, #1
	cmp r7, #0x69
	blo _027E9AC8
	mov r0, #0x5a
	mov r1, #2
	bl BBP_Write
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027E9B0C: .word 0x04808160
	arm_func_end InitBaseBand

	arm_func_start InitMac
InitMac: // 0x027E9B10
	mov ip, #0
	ldr r2, _027E9B44 // =macInitRegs
_027E9B18:
	mov r3, ip, lsl #2
	add r0, r2, ip, lsl #2
	ldrh r1, [r0, #2]
	ldrh r0, [r2, r3]
	add r0, r0, #0x4800000
	add r0, r0, #0x8000
	strh r1, [r0]
	add ip, ip, #1
	cmp ip, #0x19
	blo _027E9B18
	bx lr
	.align 2, 0
_027E9B44: .word macInitRegs
	arm_func_end InitMac

	arm_func_start WConfigDevice
WConfigDevice: // 0x027E9B48
	stmdb sp!, {r4, lr}
	ldr r0, _027E9BB4 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027E9BB8 // =0x000005F8
	add r4, r1, r0
	mov r0, #0
	mov r1, r4
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, #0x40
	mov r1, #1
	mov r2, r4
	bl FLASH_Read
	mov r0, #0x41
	mov r1, #1
	add r2, r4, #2
	bl FLASH_Read
	mov r0, #0x42
	mov r1, #1
	add r2, r4, #4
	bl FLASH_Read
	mov r0, #0x43
	mov r1, #1
	add r2, r4, #6
	bl FLASH_Read
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027E9BB4: .word 0x0380FFF4
_027E9BB8: .word 0x000005F8
	arm_func_end WConfigDevice

	arm_func_start CalcBbpCRC
CalcBbpCRC: // 0x027E9BBC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r8, #0x64
	mov r6, #0
	str r6, [sp]
	mov r7, r6
	mov r5, #1
	add r4, sp, #0
_027E9BDC:
	mov r0, r8
	mov r1, r5
	mov r2, r4
	bl FLASH_Read
	cmp r7, #1
	ldreq r0, [sp]
	andeq r0, r0, #0x80
	streq r0, [sp]
	ldr r0, [sp]
	and r0, r0, #0xff
	mov r1, r6
	bl calc_NextCRC
	mov r6, r0
	add r8, r8, #1
	add r7, r7, #1
	cmp r7, #0x69
	blo _027E9BDC
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end CalcBbpCRC

	arm_func_start RF_Write
RF_Write: // 0x027E9C2C
	ldr r1, _027E9C48 // =0x0480817E
	strh r0, [r1]
	mov r1, r0, lsr #0x10
	ldr r0, _027E9C4C // =0x0480817C
	strh r1, [r0]
	ldr ip, _027E9C50 // =WaitLoop_RfAccess
	bx ip
	.align 2, 0
_027E9C48: .word 0x0480817E
_027E9C4C: .word 0x0480817C
_027E9C50: .word WaitLoop_RfAccess
	arm_func_end RF_Write

	arm_func_start BBP_Write
BBP_Write: // 0x027E9C54
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _027E9C8C // =0x0480815A
	strh r1, [r2]
	orr r1, r0, #0x5000
	ldr r0, _027E9C90 // =0x04808158
	strh r1, [r0]
	bl WaitLoop_BbpAccess
	cmp r0, #0
	mvnne r0, #0
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E9C8C: .word 0x0480815A
_027E9C90: .word 0x04808158
	arm_func_end BBP_Write

	arm_func_start BBP_Read
BBP_Read: // 0x027E9C94
	stmdb sp!, {lr}
	sub sp, sp, #4
	orr r1, r0, #0x6000
	ldr r0, _027E9CC0 // =0x04808158
	strh r1, [r0]
	bl WaitLoop_BbpAccess
	ldr r0, _027E9CC4 // =0x0480815C
	ldrh r0, [r0, #0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027E9CC0: .word 0x04808158
_027E9CC4: .word 0x0480815C
	arm_func_end BBP_Read

	arm_func_start WCalcManRate
WCalcManRate: // 0x027E9CC8
	ldr r0, _027E9D10 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0x30]
	cmp r1, #0
	beq _027E9CEC
	cmp r1, #1
	beq _027E9D00
	b _027E9D08
_027E9CEC:
	ldrh r0, [r0, #0xa4]
	ands r0, r0, #1
	beq _027E9D08
	mov r0, #0xa
	bx lr
_027E9D00:
	mov r0, #0xa
	bx lr
_027E9D08:
	mov r0, #0x14
	bx lr
	.align 2, 0
_027E9D10: .word 0x0380FFF4
	arm_func_end WCalcManRate

	arm_func_start WElement2RateSet
WElement2RateSet: // 0x027E9D14
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r4, r0
	mov r10, r1
	mov r0, #0
	strh r0, [r10]
	strh r0, [r10, #2]
	add r0, r4, #1
	bl WL_ReadByte
	mov r8, r0
	mov r9, #0
	ldr r6, _027E9DCC // =RateElement2Bit
	add r7, r4, #2
	add r4, r10, #2
	mov r5, #1
	b _027E9DBC
_027E9D50:
	add r0, r7, r9
	bl WL_ReadByte
	and r1, r0, #0x7f
	sub r1, r1, #1
	cmp r1, #0x78
	bhs _027E9D9C
	mov r1, r1, lsl #1
	ldrh r3, [r6, r1]
	cmp r3, #0xff
	beq _027E9D9C
	mov r2, r5, lsl r3
	ldrh r1, [r4, #0]
	orr r1, r1, r5, lsl r3
	strh r1, [r4]
	ands r0, r0, #0x80
	ldrneh r0, [r10, #0]
	orrne r0, r0, r2
	strneh r0, [r10]
	b _027E9DB8
_027E9D9C:
	ldrh r1, [r4, #0]
	orr r1, r1, #0x8000
	strh r1, [r4]
	ands r0, r0, #0x80
	ldrneh r0, [r10, #0]
	orrne r0, r0, #0x8000
	strneh r0, [r10]
_027E9DB8:
	add r9, r9, #1
_027E9DBC:
	cmp r9, r8
	blo _027E9D50
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_027E9DCC: .word RateElement2Bit
	arm_func_end WElement2RateSet

	arm_func_start CheckEnableChannel
CheckEnableChannel: // 0x027E9DD0
	mov r2, #1
	ldr r1, _027E9DEC // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x2c]
	and r0, r1, r2, lsl r0
	bx lr
	.align 2, 0
_027E9DEC: .word 0x0380FFF4
	arm_func_end CheckEnableChannel

	arm_func_start MatchMacAdrs
MatchMacAdrs: // 0x027E9DF0
	ldrh r3, [r0, #4]
	ldrh r2, [r1, #4]
	cmp r3, r2
	bne _027E9E24
	ldrh r3, [r0, #2]
	ldrh r2, [r1, #2]
	cmp r3, r2
	bne _027E9E24
	ldrh r2, [r0, #0]
	ldrh r0, [r1, #0]
	cmp r2, r0
	moveq r0, #1
	bxeq lr
_027E9E24:
	mov r0, #0
	bx lr
	arm_func_end MatchMacAdrs

	arm_func_start WCheckSSID
WCheckSSID: // 0x027E9E2C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r9, r0
	mov r8, r1
	ldr r0, _027E9EF8 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r2, r0, #0x344
	cmp r9, #0x20
	movhi r0, #0
	bhi _027E9EF0
	ldrh r1, [r2, #0x1e]
	cmp r1, #0
	moveq r0, #1
	beq _027E9EF0
	add r0, r0, #0x400
	ldrh r0, [r0, #4]
	cmp r0, #0x13
	bne _027E9E84
	cmp r9, r1
	movlo r0, #0
	blo _027E9EF0
	mov r9, r1
	b _027E9E90
_027E9E84:
	cmp r9, r1
	movne r0, #0
	bne _027E9EF0
_027E9E90:
	add r7, r2, #0x20
	add r6, r2, #0x40
	mov r5, #0
	b _027E9EE4
_027E9EA0:
	mov r0, r6
	bl WL_ReadByte
	mov r4, r0
	add r6, r6, #1
	mov r0, r8
	bl WL_ReadByte
	mov r10, r0
	add r8, r8, #1
	mov r0, r7
	bl WL_ReadByte
	add r7, r7, #1
	orr r1, r10, r4
	orr r0, r0, r4
	cmp r1, r0
	movne r0, #0
	bne _027E9EF0
	add r5, r5, #1
_027E9EE4:
	cmp r5, r9
	blo _027E9EA0
	mov r0, #1
_027E9EF0:
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_027E9EF8: .word 0x0380FFF4
	arm_func_end WCheckSSID

	arm_func_start WUpdateCounter
WUpdateCounter: // 0x027E9EFC
	ldr r0, _027EA0F4 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027EA0F8 // =0x0000053C
	add r1, r1, r0
	ldr r0, _027EA0FC // =0x048081B0
	ldrh r2, [r0, #0]
	ldr r3, [r1, #0x50]
	and r2, r2, #0xff
	add r2, r3, r2
	str r2, [r1, #0x50]
	ldrh ip, [r0, #2]
	ldr r2, [r1, #0x4c]
	add r2, r2, ip, asr #8
	str r2, [r1, #0x4c]
	ldr r3, [r1, #0x5c]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0x5c]
	ldrh ip, [r0, #4]
	ldr r2, [r1, #0x58]
	add r2, r2, ip, asr #8
	str r2, [r1, #0x58]
	ldr r3, [r1, #0x54]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0x54]
	ldrh ip, [r0, #6]
	ldr r2, [r1, #0x60]
	add r2, r2, ip, asr #8
	str r2, [r1, #0x60]
	ldr r3, [r1, #0x38]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0x38]
	ldrh r2, [r0, #8]
	ldr r3, [r1, #0x48]
	and r2, r2, #0xff
	add r2, r3, r2
	str r2, [r1, #0x48]
	ldrh r2, [r0, #0xa]
	ldr r3, [r1, #0x20]
	and r2, r2, #0xff
	add r2, r3, r2
	str r2, [r1, #0x20]
	ldrh ip, [r0, #0xc]
	ldr r2, [r1, #0x30]
	add r2, r2, ip, asr #8
	str r2, [r1, #0x30]
	ldr r3, [r1, #0x44]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0x44]
	ldrh ip, [r0, #0xe]
	ldr r3, [r1, #0x3c]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0x3c]
	ldr r2, [r1, #0x40]
	add r2, r2, ip, asr #8
	str r2, [r1, #0x40]
	ldrh r2, [r0, #0x10]
	ldr r3, [r1, #0xc]
	and r2, r2, #0xff
	add r2, r3, r2
	str r2, [r1, #0xc]
	ldrh r3, [r0, #0x20]
	ldr r2, [r1, #0x78]
	add r2, r2, r3, asr #8
	str r2, [r1, #0x78]
	ldrh ip, [r0, #0x22]
	ldr r3, [r1, #0x7c]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0x7c]
	ldr r2, [r1, #0x80]
	add r2, r2, ip, asr #8
	str r2, [r1, #0x80]
	ldrh ip, [r0, #0x24]
	ldr r3, [r1, #0x84]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0x84]
	ldr r2, [r1, #0x88]
	add r2, r2, ip, asr #8
	str r2, [r1, #0x88]
	ldrh ip, [r0, #0x26]
	ldr r3, [r1, #0x8c]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0x8c]
	ldr r2, [r1, #0x90]
	add r2, r2, ip, asr #8
	str r2, [r1, #0x90]
	ldrh ip, [r0, #0x28]
	ldr r3, [r1, #0x94]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0x94]
	ldr r2, [r1, #0x98]
	add r2, r2, ip, asr #8
	str r2, [r1, #0x98]
	ldrh ip, [r0, #0x2a]
	ldr r3, [r1, #0x9c]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0x9c]
	ldr r2, [r1, #0xa0]
	add r2, r2, ip, asr #8
	str r2, [r1, #0xa0]
	ldrh ip, [r0, #0x2c]
	ldr r3, [r1, #0xa4]
	and r2, ip, #0xff
	add r2, r3, r2
	str r2, [r1, #0xa4]
	ldr r2, [r1, #0xa8]
	add r2, r2, ip, asr #8
	str r2, [r1, #0xa8]
	ldrh r3, [r0, #0x2e]
	ldr r2, [r1, #0xac]
	and r0, r3, #0xff
	add r0, r2, r0
	str r0, [r1, #0xac]
	ldr r0, [r1, #0xb0]
	add r0, r0, r3, asr #8
	str r0, [r1, #0xb0]
	bx lr
	.align 2, 0
_027EA0F4: .word 0x0380FFF4
_027EA0F8: .word 0x0000053C
_027EA0FC: .word 0x048081B0
	arm_func_end WUpdateCounter

	arm_func_start WInitCounter
WInitCounter: // 0x027EA100
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WUpdateCounter
	mov r0, #0
	ldr r1, _027EA134 // =0x0380FFF4
	ldr r2, [r1, #0]
	ldr r1, _027EA138 // =0x0000053C
	add r1, r2, r1
	mov r2, #0xb4
	bl MIi_CpuClear32
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EA134: .word 0x0380FFF4
_027EA138: .word 0x0000053C
	arm_func_end WInitCounter

	arm_func_start WSetMacAdrs3
WSetMacAdrs3: // 0x027EA13C
	ldrh ip, [r1]
	strh ip, [r0]
	ldrh ip, [r1, #2]
	strh ip, [r0, #2]
	ldrh r1, [r1, #4]
	strh r1, [r0, #4]
	ldrh r1, [r2, #0]
	strh r1, [r0, #6]
	ldrh r1, [r2, #2]
	strh r1, [r0, #8]
	ldrh r1, [r2, #4]
	strh r1, [r0, #0xa]
	ldrh r1, [r3, #0]
	strh r1, [r0, #0xc]
	ldrh r1, [r3, #2]
	strh r1, [r0, #0xe]
	ldrh r1, [r3, #4]
	strh r1, [r0, #0x10]
	bx lr
	arm_func_end WSetMacAdrs3

	arm_func_start WSetMacAdrs2
WSetMacAdrs2: // 0x027EA188
	ldrh r3, [r1, #0]
	strh r3, [r0]
	ldrh r3, [r1, #2]
	strh r3, [r0, #2]
	ldrh r1, [r1, #4]
	strh r1, [r0, #4]
	ldrh r1, [r2, #0]
	strh r1, [r0, #6]
	ldrh r1, [r2, #2]
	strh r1, [r0, #8]
	ldrh r1, [r2, #4]
	strh r1, [r0, #0xa]
	bx lr
	arm_func_end WSetMacAdrs2

	arm_func_start WSetMacAdrs1
WSetMacAdrs1: // 0x027EA1BC
	ldrh r2, [r1, #0]
	strh r2, [r0]
	ldrh r2, [r1, #2]
	strh r2, [r0, #2]
	ldrh r1, [r1, #4]
	strh r1, [r0, #4]
	bx lr
	arm_func_end WSetMacAdrs1

	arm_func_start WClearKSID
WClearKSID: // 0x027EA1D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027EA200 // =0x04808094
	ldrh r0, [r0, #0]
	ands r0, r0, #0x8000
	bne _027EA1F4
	bl WaitLoop_ClrAid
_027EA1F4:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EA200: .word 0x04808094
	arm_func_end WClearKSID

	arm_func_start WSetKSID
WSetKSID: // 0x027EA204
	ldr r0, _027EA220 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0xae]
	ldr r0, _027EA224 // =0x04808028
	strh r1, [r0]
	bx lr
	.align 2, 0
_027EA220: .word 0x0380FFF4
_027EA224: .word 0x04808028
	arm_func_end WSetKSID

	arm_func_start WClearAids
WClearAids: // 0x027EA228
	stmdb sp!, {r4, lr}
	ldr r0, _027EA27C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r4, r0, #0x344
	mov r0, #0
	strh r0, [r4, #0x6a]
	bl WaitLoop_ClrAid
	mov r1, #0
	ldr r0, _027EA280 // =0x0480802A
	strh r1, [r0]
	ldrh r0, [r4, #0x88]
	cmp r0, #0
	beq _027EA274
	bl DeleteTxFrames
	ldrh r0, [r4, #0x88]
	mov r1, #0x20
	bl CAM_SetStaState
	mov r0, #0
	strh r0, [r4, #0x88]
_027EA274:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EA27C: .word 0x0380FFF4
_027EA280: .word 0x0480802A
	arm_func_end WClearAids

	arm_func_start WSetAids
WSetAids: // 0x027EA284
	ldr r2, _027EA2BC // =0x0380FFF4
	ldr r1, [r2, #0]
	add r1, r1, #0x300
	strh r0, [r1, #0xae]
	ldr r1, _027EA2C0 // =0x0480802A
	strh r0, [r1]
	ldr r1, [r2, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x3a]
	mov r1, r1, lsl #0x18
	movs r1, r1, lsr #0x1f
	ldrne r1, _027EA2C4 // =0x04808028
	strneh r0, [r1]
	bx lr
	.align 2, 0
_027EA2BC: .word 0x0380FFF4
_027EA2C0: .word 0x0480802A
_027EA2C4: .word 0x04808028
	arm_func_end WSetAids

	arm_func_start WSetGameInfo
WSetGameInfo: // 0x027EA2C8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027EA370 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r4, r0, #0x344
	cmp r6, #0x80
	movhi r0, #4
	bhi _027EA368
	cmp r6, #0
	beq _027EA358
	ldrh r0, [r4, #0xa2]
	ands r0, r0, #1
	beq _027EA348
	ldr r8, [r4, #0x9c]
	mov r0, r8
	mov r1, #0xff
	bl WL_WriteByte
	add r8, r8, #1
	mov r7, #0
	b _027EA33C
_027EA31C:
	mov r0, r5
	bl WL_ReadByte
	mov r1, r0
	mov r0, r8
	bl WL_WriteByte
	add r8, r8, #1
	add r5, r5, #1
	add r7, r7, #1
_027EA33C:
	cmp r7, r6
	blo _027EA31C
	b _027EA358
_027EA348:
	mov r0, r5
	ldr r1, [r4, #0x9c]
	add r2, r6, #1
	bl MIi_CpuCopy16
_027EA358:
	strh r6, [r4, #0xa0]
	mov r0, #1
	strh r0, [r4, #0xa4]
	mov r0, #0
_027EA368:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027EA370: .word 0x0380FFF4
	arm_func_end WSetGameInfo

	arm_func_start WInitGameInfo
WInitGameInfo: // 0x027EA374
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _027EA3BC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r4, r0, #0x344
	cmp r5, #0x80
	movhi r0, #4
	bhi _027EA3B0
	mov r0, r1
	ldr r1, [r4, #0x9c]
	add r2, r5, #1
	bl MIi_CpuCopy16
	strh r5, [r4, #0xa0]
	mov r0, #0
_027EA3B0:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027EA3BC: .word 0x0380FFF4
	arm_func_end WInitGameInfo

	arm_func_start WEnableTmpttPowerSave
WEnableTmpttPowerSave: // 0x027EA3C0
	mov r1, #0
	ldr r0, _027EA3E8 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	strh r1, [r0, #0xea]
	ldr r1, _027EA3EC // =0x04808038
	ldrh r0, [r1, #0]
	orr r0, r0, #2
	strh r0, [r1]
	bx lr
	.align 2, 0
_027EA3E8: .word 0x0380FFF4
_027EA3EC: .word 0x04808038
	arm_func_end WEnableTmpttPowerSave

	arm_func_start WDisableTmpttPowerSave
WDisableTmpttPowerSave: // 0x027EA3F0
	mov r2, #1
	ldr r1, _027EA438 // =0x0380FFF4
	ldr r0, [r1, #0]
	add r0, r0, #0x300
	strh r2, [r0, #0xea]
	ldr r0, [r1, #0]
	add r0, r0, #0x400
	ldrh r0, [r0, #0x68]
	cmp r0, #0
	bxne lr
	ldr r1, _027EA43C // =0x04808038
	ldrh r0, [r1, #0]
	bic r0, r0, #2
	strh r0, [r1]
	mov r1, #0
	ldr r0, _027EA440 // =0x04808048
	strh r1, [r0]
	bx lr
	.align 2, 0
_027EA438: .word 0x0380FFF4
_027EA43C: .word 0x04808038
_027EA440: .word 0x04808048
	arm_func_end WDisableTmpttPowerSave

	arm_func_start WSetFrameLifeTime
WSetFrameLifeTime: // 0x027EA444
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _027EA4A4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r5, r0, #0x344
	add r4, r0, #0x31c
	ldr r0, _027EA4A8 // =0x0000FFFF
	cmp r6, r0
	moveq r1, #0xff
	streqh r1, [r4, #0x1c]
	streqh r0, [r5, #0x8c]
	beq _027EA498
	ldrh r0, [r5, #0x6e]
	mul r0, r6, r0
	mov r1, #0x64
	bl _u32_div_f
	cmp r0, #0x10000
	movhi r0, #5
	bhi _027EA49C
	strh r6, [r4, #0x1c]
	strh r0, [r5, #0x8c]
_027EA498:
	mov r0, #0
_027EA49C:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EA4A4: .word 0x0380FFF4
_027EA4A8: .word 0x0000FFFF
	arm_func_end WSetFrameLifeTime

	arm_func_start WWakeUp
WWakeUp: // 0x027EA4AC
	stmdb sp!, {r4, lr}
	mov r1, #0
	ldr r0, _027EA534 // =0x04808036
	strh r1, [r0]
	mov r0, #8
	bl WWait
	mov r1, #0
	ldr r0, _027EA538 // =0x04808168
	strh r1, [r0]
	ldr r0, _027EA53C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r0, [r0, #0xf8]
	cmp r0, #2
	beq _027EA4F4
	cmp r0, #3
	beq _027EA528
	b _027EA52C
_027EA4F4:
	mov r0, #1
	bl BBP_Read
	mov r4, r0
	mov r0, #1
	and r1, r4, #0x7f
	bl BBP_Write
	mov r0, #1
	mov r1, r4
	bl BBP_Write
	mov r0, #0x28
	bl WWait
	bl InitRF
	b _027EA52C
_027EA528:
	bl InitRF
_027EA52C:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EA534: .word 0x04808036
_027EA538: .word 0x04808168
_027EA53C: .word 0x0380FFF4
	arm_func_end WWakeUp

	arm_func_start WShutdown
WShutdown: // 0x027EA540
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027EA5A0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r0, [r0, #0xf8]
	cmp r0, #2
	bne _027EA568
	ldr r0, _027EA5A4 // =0x0000C008
	bl RF_Write
_027EA568:
	mov r0, #0x1e
	bl BBP_Read
	orr r1, r0, #0x3f
	mov r0, #0x1e
	bl BBP_Write
	ldr r1, _027EA5A8 // =0x0000800D
	ldr r0, _027EA5AC // =0x04808168
	strh r1, [r0]
	mov r1, #1
	ldr r0, _027EA5B0 // =0x04808036
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EA5A0: .word 0x0380FFF4
_027EA5A4: .word 0x0000C008
_027EA5A8: .word 0x0000800D
_027EA5AC: .word 0x04808168
_027EA5B0: .word 0x04808036
	arm_func_end WShutdown

	arm_func_start WSetForcePowerState
WSetForcePowerState: // 0x027EA5B4
	ldr r1, _027EA5C4 // =0x04808040
	strh r0, [r1]
	mov r0, #0
	bx lr
	.align 2, 0
_027EA5C4: .word 0x04808040
	arm_func_end WSetForcePowerState

	arm_func_start WSetPowerState
WSetPowerState: // 0x027EA5C8
	mov r2, r0, lsr #1
	ldr r1, _027EA5EC // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	strh r2, [r1, #0x54]
	ldr r1, _027EA5F0 // =0x0480803C
	strh r0, [r1]
	mov r0, #0
	bx lr
	.align 2, 0
_027EA5EC: .word 0x0380FFF4
_027EA5F0: .word 0x0480803C
	arm_func_end WSetPowerState

	arm_func_start WSetPowerMgtMode
WSetPowerMgtMode: // 0x027EA5F4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _027EA660 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r2, r1, #0x31c
	add r1, r1, #0x300
	strh r0, [r1, #0x52]
	cmp r0, #0
	beq _027EA634
	ldrh r0, [r2, #0x12]
	cmp r0, #1
	ldrne r1, _027EA664 // =0x04808006
	ldrneh r0, [r1, #0]
	orrne r0, r0, #0x40
	strneh r0, [r1]
	bne _027EA650
_027EA634:
	ldr r1, _027EA664 // =0x04808006
	ldrh r0, [r1, #0]
	bic r0, r0, #0x40
	strh r0, [r1]
	ldrh r0, [r2, #0x20]
	mov r1, #0
	bl WSetActiveZoneTime
_027EA650:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EA660: .word 0x0380FFF4
_027EA664: .word 0x04808006
	arm_func_end WSetPowerMgtMode

	arm_func_start WSetTxTimeStampOffset
WSetTxTimeStampOffset: // 0x027EA668
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027EA6E4 // =0x0000E2E2
	str r0, [sp]
	mov r0, #0x58
	mov r1, #2
	add r2, sp, #0
	bl FLASH_Read
	ldr r1, [sp]
	ldr r0, _027EA6E8 // =0x00000202
	add r0, r1, r0
	str r0, [sp]
	bl WCalcManRate
	cmp r0, #0x14
	bne _027EA6CC
	ldr r1, [sp]
	ldr r0, _027EA6EC // =0x00006161
	sub r1, r1, r0
	str r1, [sp]
	ldr r0, _027EA6F0 // =0x048080BC
	ldrh r0, [r0, #0]
	ands r0, r0, #2
	ldrne r0, _027EA6F4 // =0x00006060
	subne r0, r1, r0
	strne r0, [sp]
_027EA6CC:
	ldr r1, [sp]
	ldr r0, _027EA6F8 // =0x04808140
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EA6E4: .word 0x0000E2E2
_027EA6E8: .word 0x00000202
_027EA6EC: .word 0x00006161
_027EA6F0: .word 0x048080BC
_027EA6F4: .word 0x00006060
_027EA6F8: .word 0x04808140
	arm_func_end WSetTxTimeStampOffset

	arm_func_start WSetRateSet
WSetRateSet: // 0x027EA6FC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _027EA740 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r3, r1, #0x3a4
	ldrh r2, [r0, #0]
	add r1, r1, #0x300
	strh r2, [r1, #0xa4]
	ldrh r1, [r0, #2]
	ldrh r0, [r0, #0]
	orr r0, r1, r0
	strh r0, [r3, #2]
	bl WSetTxTimeStampOffset
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EA740: .word 0x0380FFF4
	arm_func_end WSetRateSet

	arm_func_start WSetChannel
WSetChannel: // 0x027EA744
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	cmp r1, #0
	ldrne r9, _027EA9BC // =FLASH_DirectRead
	ldreq r9, _027EA9C0 // =FLASH_Read
	mov r0, r10
	bl CheckEnableChannel
	cmp r0, #0
	moveq r0, #5
	beq _027EA9B0
	ldr r1, _027EA9C4 // =0x04808040
	ldrh r8, [r1, #0]
	ldr r0, _027EA9C8 // =0x00008001
	strh r0, [r1]
	ldr r2, _027EA9CC // =0x0480803C
	ldr r1, _027EA9D0 // =0x04808214
_027EA788:
	ldrh r0, [r2, #0]
	mov r3, r0, asr #8
	ldrh r0, [r1, #0]
	cmp r3, #2
	bne _027EA788
	cmp r0, #0
	beq _027EA7AC
	cmp r0, #9
	bne _027EA788
_027EA7AC:
	ldr r11, _027EA9D4 // =0x0380FFF4
	ldr r0, [r11, #0]
	add r0, r0, #0x300
	strh r10, [r0, #0xbe]
	ldr r0, [r11, #0]
	add r0, r0, #0x500
	ldrh r1, [r0, #0xf8]
	cmp r1, #2
	beq _027EA7E0
	cmp r1, #3
	beq _027EA8B0
	cmp r1, #5
	bne _027EA998
_027EA7E0:
	mov r0, #0
	str r0, [sp]
	sub r4, r10, #1
	mov r0, #6
	mul r5, r4, r0
	add r0, r5, #0xf2
	mov r1, #3
	add r2, sp, #0
	mov lr, pc
	bx r9
_27EA808:
	ldr r0, [sp]
	bl RF_Write
	add r0, r5, #0xf5
	mov r1, #3
	add r2, sp, #0
	mov lr, pc
	bx r9
_27EA824:
	ldr r0, [sp]
	bl RF_Write
	mov r0, #0
	str r0, [sp]
	ldr r0, _027EA9D4 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r1, [r0, #0x604]
	ands r0, r1, #0x10000
	beq _027EA888
	ands r0, r1, #0x8000
	bne _027EA998
	add r0, r4, #0x154
	mov r1, #1
	add r2, sp, #0
	mov lr, pc
	bx r9
_27EA864: // 0x027EA864
	ldr r0, _027EA9D4 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r1, [r0, #0x604]
	ldr r0, [sp]
	and r0, r0, #0x1f
	orr r0, r1, r0, lsl #10
	str r0, [sp]
	bl RF_Write
	b _027EA998
_027EA888:
	ldr r0, _027EA9D8 // =0x00000146
	add r0, r4, r0
	mov r1, #1
	add r2, sp, #0
	mov lr, pc
	bx r9
_27EA8A0: // 0x027EA8A0
	mov r0, #0x1e
	ldr r1, [sp]
	bl BBP_Write
	b _027EA998
_027EA8B0:
	ldrh r0, [r0, #0xfc]
	add r7, r0, #0xcf
	mov r6, #0
	mov r5, r6
	mov r4, #1
	b _027EA90C
_027EA8C8:
	str r5, [sp]
	str r5, [sp, #4]
	mov r0, r7
	mov r1, r4
	add r2, sp, #4
	mov lr, pc
	bx r9
_27EA8E4: // 0x027EA8E4
	add r0, r7, r10
	mov r1, r4
	add r2, sp, #0
	mov lr, pc
	bx r9
_27EA8F8: // 0x027EA8F8
	ldr r0, [sp, #4]
	ldr r1, [sp]
	bl BBP_Write
	add r7, r7, #0xf
	add r6, r6, #1
_027EA90C:
	ldr r0, [r11, #0]
	add r0, r0, #0x600
	ldrh r0, [r0, #0]
	cmp r6, r0
	blo _027EA8C8
	mov r6, #0
	mov r5, r6
	mov r4, #1
	ldr r11, _027EA9D4 // =0x0380FFF4
	b _027EA984
_027EA934:
	str r5, [sp]
	mov r0, r7
	mov r1, r4
	add r2, sp, #0
	mov lr, pc
	bx r9
_27EA94C: // 0x027EA94C
	ldr r0, [sp]
	mov r0, r0, lsl #8
	str r0, [sp]
	add r0, r7, r10
	mov r1, r4
	add r2, sp, #0
	mov lr, pc
	bx r9
_27EA96C: // 0x027EA96C
	ldr r0, [sp]
	orr r0, r0, #0x50000
	str r0, [sp]
	bl RF_Write
	add r7, r7, #0xf
	add r6, r6, #1
_027EA984:
	ldr r0, [r11, #0]
	add r0, r0, #0x500
	ldrh r0, [r0, #0xfe]
	cmp r6, r0
	blo _027EA934
_027EA998:
	ldr r0, _027EA9C4 // =0x04808040
	strh r8, [r0]
	mov r1, #3
	ldr r0, _027EA9DC // =0x04808048
	strh r1, [r0]
	mov r0, #0
_027EA9B0:
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027EA9BC: .word FLASH_DirectRead
_027EA9C0: .word FLASH_Read
_027EA9C4: .word 0x04808040
_027EA9C8: .word 0x00008001
_027EA9CC: .word 0x0480803C
_027EA9D0: .word 0x04808214
_027EA9D4: .word 0x0380FFF4
_027EA9D8: .word 0x00000146
_027EA9DC: .word 0x04808048
	arm_func_end WSetChannel

	arm_func_start WSetDefaultParameters
WSetDefaultParameters: // 0x027EA9E0
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov r0, #0x36
	mov r1, #6
	add r2, sp, #2
	bl FLASH_Read
	mov r0, #0x3c
	mov r1, #2
	add r2, sp, #0
	bl FLASH_Read
	add r0, sp, #2
	bl WSetMacAdrs
	mov r0, #7
	bl WSetRetryLimit
	ldrh r1, [sp]
	ldr r0, _027EAB14 // =0x00007FFE
	and r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WSetEnableChannel
	mov r0, #2
	bl WSetMode
	mov r0, #0
	bl WSetRate
	mov r0, #0
	bl WSetWepMode
	mov r0, #0
	bl WSetWepKeyId
	ldr r0, _027EAB18 // =def_WepKey
	bl WSetWepKey
	mov r0, #0x1f4
	bl WSetBeaconPeriod
	mov r0, #0
	bl WSetBeaconType
	mov r0, #0
	bl WSetBcSsidResponse
	mov r0, #0x10
	bl WSetBeaconLostThreshold
	ldr r0, _027EAB1C // =0x0000FFFF
	mov r1, #0
	bl WSetActiveZoneTime
	ldr r0, _027EAB20 // =def_SsidMask
	bl WSetSsidMask
	mov r0, #1
	bl WSetPreambleType
	mov r0, #0
	bl WSetAuthAlgo
	ldr r0, _027EAB24 // =c_RateSet_3853
	bl WSetRateSet
	mov r0, #0
	mov r1, #0x1f
	bl WSetCCA_ED
	mov r0, #5
	bl WSetFrameLifeTime
	mov r0, #0
	mov r1, r0
	bl WSetDiversity
	mov r0, #0
	bl WSetMainAntenna
	mov r0, #0
	bl WSetBeaconSendRecvIndicate
	mov r0, #0
	bl WSetNullKeyMode
	ldr r2, _027EAB28 // =0x04808044
	ldrh r1, [r2, #0]
	ldrh r0, [r2, #0]
	add r0, r1, r0, lsl #8
	ldrh r1, [r2, #0]
	bl RND_init
	mov r1, #1
	ldr r0, _027EAB2C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	strh r1, [r0, #0x58]
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EAB14: .word 0x00007FFE
_027EAB18: .word def_WepKey
_027EAB1C: .word 0x0000FFFF
_027EAB20: .word def_SsidMask
_027EAB24: .word c_RateSet_3853
_027EAB28: .word 0x04808044
_027EAB2C: .word 0x0380FFF4
	arm_func_end WSetDefaultParameters

	arm_func_start WSetListenInterval
WSetListenInterval: // 0x027EAB30
	cmp r0, #1
	blo _027EAB40
	cmp r0, #0xff
	bls _027EAB48
_027EAB40:
	mov r0, #5
	bx lr
_027EAB48:
	ldr r1, _027EAB60 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	strh r0, [r1, #0xb4]
	mov r0, #0
	bx lr
	.align 2, 0
_027EAB60: .word 0x0380FFF4
	arm_func_end WSetListenInterval

	arm_func_start WSetDTIMPeriod
WSetDTIMPeriod: // 0x027EAB64
	cmp r0, #1
	blo _027EAB74
	cmp r0, #0xff
	bls _027EAB7C
_027EAB74:
	mov r0, #5
	bx lr
_027EAB7C:
	ldr r1, _027EABA4 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	strh r0, [r1, #0xb8]
	ldr r1, _027EABA8 // =0x0480808E
	strh r0, [r1]
	mov r0, #0
	ldr r1, _027EABAC // =0x04808088
	strh r0, [r1]
	bx lr
	.align 2, 0
_027EABA4: .word 0x0380FFF4
_027EABA8: .word 0x0480808E
_027EABAC: .word 0x04808088
	arm_func_end WSetDTIMPeriod

	arm_func_start WSetBeaconPeriod
WSetBeaconPeriod: // 0x027EABB0
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0xa
	blo _027EABC8
	cmp r0, #0x3e8
	bls _027EABD0
_027EABC8:
	mov r0, #5
	b _027EABFC
_027EABD0:
	ldr r2, _027EAC08 // =0x0380FFF4
	ldr r1, [r2, #0]
	add r1, r1, #0x300
	strh r0, [r1, #0xb2]
	ldr r1, _027EAC0C // =0x0480808C
	strh r0, [r1]
	ldr r0, [r2, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x38]
	bl WSetFrameLifeTime
	mov r0, #0
_027EABFC:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EAC08: .word 0x0380FFF4
_027EAC0C: .word 0x0480808C
	arm_func_end WSetBeaconPeriod

	arm_func_start WSetSsid
WSetSsid: // 0x027EAC10
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	mov r7, r1
	ldr r0, _027EAD28 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r6, r1, #0x344
	mov r4, #0
	cmp r8, #0x20
	movhi r0, #5
	bhi _027EAD1C
	ldrh r0, [r6, #8]
	cmp r0, #0x40
	bne _027EAC74
	add r0, r1, #0x300
	ldrh r0, [r0, #0x2e]
	cmp r0, #1
	bne _027EAC74
	ldrh r0, [r6, #0x1e]
	cmp r0, r8
	movne r0, #6
	bne _027EAD1C
	ldrh r0, [r6, #0x92]
	cmp r0, #0
	movne r4, #1
_027EAC74:
	mov r5, #0
	add r9, r6, #0x20
	b _027EAC9C
_027EAC80:
	mov r0, r7
	bl WL_ReadByte
	mov r1, r0
	add r0, r9, r5
	bl WL_WriteByte
	add r7, r7, #1
	add r5, r5, #1
_027EAC9C:
	cmp r5, r8
	blo _027EAC80
	add r9, r6, #0x20
	mov r7, #0
	b _027EACC0
_027EACB0:
	add r0, r9, r5
	mov r1, r7
	bl WL_WriteByte
	add r5, r5, #1
_027EACC0:
	cmp r5, #0x20
	blo _027EACB0
	strh r8, [r6, #0x1e]
	cmp r4, #0
	beq _027EAD18
	ldr r0, _027EAD28 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x4ac]
	add r1, r0, #0x26
	ldrh r0, [r6, #0x92]
	add r7, r1, r0
	mov r5, #0
	add r4, r6, #0x20
	b _027EAD10
_027EACF8:
	add r0, r4, r5
	bl WL_ReadByte
	mov r1, r0
	add r0, r7, r5
	bl WL_WriteByte
	add r5, r5, #1
_027EAD10:
	cmp r5, r8
	blo _027EACF8
_027EAD18:
	mov r0, #0
_027EAD1C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027EAD28: .word 0x0380FFF4
	arm_func_end WSetSsid

	arm_func_start WSetBssid
WSetBssid: // 0x027EAD2C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _027EAD88 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x3a8
	mov r1, r4
	bl WSetMacAdrs1
	ldr r0, _027EAD8C // =0x04808020
	mov r1, r4
	bl WSetMacAdrs1
	ldrh r0, [r4, #0]
	ands r0, r0, #1
	ldrne r1, _027EAD90 // =0x048080D0
	ldrneh r0, [r1, #0]
	bicne r0, r0, #0x400
	strneh r0, [r1]
	ldreq r1, _027EAD90 // =0x048080D0
	ldreqh r0, [r1, #0]
	orreq r0, r0, #0x400
	streqh r0, [r1]
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EAD88: .word 0x0380FFF4
_027EAD8C: .word 0x04808020
_027EAD90: .word 0x048080D0
	arm_func_end WSetBssid

	arm_func_start WSetNullKeyMode
WSetNullKeyMode: // 0x027EAD94
	cmp r0, #1
	movhi r0, #5
	bxhi lr
	ldr r1, _027EADE4 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r2, r1, #0x300
	ldrh r1, [r2, #0x3a]
	bic r3, r1, #0x80
	mov r1, r0, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #1
	orr r1, r3, r1, lsl #7
	strh r1, [r2, #0x3a]
	cmp r0, #1
	ldreq r0, _027EADE8 // =0x0480802A
	ldreqh r1, [r0, #0]
	ldreq r0, _027EADEC // =0x04808028
	streqh r1, [r0]
	mov r0, #0
	bx lr
	.align 2, 0
_027EADE4: .word 0x0380FFF4
_027EADE8: .word 0x0480802A
_027EADEC: .word 0x04808028
	arm_func_end WSetNullKeyMode

	arm_func_start WSetBeaconSendRecvIndicate
WSetBeaconSendRecvIndicate: // 0x027EADF0
	cmp r0, #1
	movhi r0, #5
	bxhi lr
	ldr r1, _027EAE2C // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r2, [r1, #0x3a]
	bic r2, r2, #0x40
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #1
	orr r0, r2, r0, lsl #6
	strh r0, [r1, #0x3a]
	mov r0, #0
	bx lr
	.align 2, 0
_027EAE2C: .word 0x0380FFF4
	arm_func_end WSetBeaconSendRecvIndicate

	arm_func_start WSetDiversity
WSetDiversity: // 0x027EAE30
	cmp r0, #1
	bhi _027EAE40
	cmp r1, #1
	bls _027EAE48
_027EAE40:
	mov r0, #5
	bx lr
_027EAE48:
	cmp r0, #0
	beq _027EAE5C
	cmp r0, #1
	beq _027EAE88
	b _027EAEB0
_027EAE5C:
	ldr r2, _027EAF04 // =0x0380FFF4
	ldr r2, [r2, #0]
	add r2, r2, #0x300
	ldrh r3, [r2, #0x3a]
	bic r3, r3, #0x20
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	and r1, r1, #1
	orr r1, r3, r1, lsl #5
	strh r1, [r2, #0x3a]
	b _027EAEB0
_027EAE88:
	ldr r1, _027EAF04 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r2, [r1, #0x2e]
	cmp r2, #1
	movne r0, #0xb
	bxne lr
	ldrh r2, [r1, #0x3a]
	bic r2, r2, #0x20
	strh r2, [r1, #0x3a]
_027EAEB0:
	ldr r3, _027EAF04 // =0x0380FFF4
	ldr r1, [r3, #0]
	add r1, r1, #0x300
	ldrh r2, [r1, #0x3a]
	bic r2, r2, #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #1
	orr r0, r2, r0, lsl #4
	strh r0, [r1, #0x3a]
	ldr r0, [r3, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r1, r0, lsl #0x1a
	mov r1, r1, lsr #0x1f
	mov r0, r0, lsl #0x1c
	eor r1, r1, r0, lsr #31
	ldr r0, _027EAF08 // =0x04808290
	strh r1, [r0]
	mov r0, #0
	bx lr
	.align 2, 0
_027EAF04: .word 0x0380FFF4
_027EAF08: .word 0x04808290
	arm_func_end WSetDiversity

	arm_func_start WSetMainAntenna
WSetMainAntenna: // 0x027EAF0C
	cmp r0, #1
	movhi r0, #5
	bxhi lr
	ldr r3, _027EAF6C // =0x0380FFF4
	ldr r1, [r3, #0]
	add r1, r1, #0x300
	ldrh r2, [r1, #0x3a]
	bic r2, r2, #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #1
	orr r0, r2, r0, lsl #3
	strh r0, [r1, #0x3a]
	ldr r0, [r3, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r1, r0, lsl #0x1a
	mov r1, r1, lsr #0x1f
	mov r0, r0, lsl #0x1c
	eor r1, r1, r0, lsr #31
	ldr r0, _027EAF70 // =0x04808290
	strh r1, [r0]
	mov r0, #0
	bx lr
	.align 2, 0
_027EAF6C: .word 0x0380FFF4
_027EAF70: .word 0x04808290
	arm_func_end WSetMainAntenna

	arm_func_start WSetCCA_ED
WSetCCA_ED: // 0x027EAF74
	stmdb sp!, {r4, lr}
	mov r2, r0
	mov r4, r1
	cmp r2, #3
	movhi r0, #5
	bhi _027EAFB4
	cmp r4, #0x3f
	movhi r0, #5
	bhi _027EAFB4
	mov r0, #0x13
	mov r1, r2
	bl BBP_Write
	mov r0, #0x35
	mov r1, r4
	bl BBP_Write
	mov r0, #0
_027EAFB4:
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end WSetCCA_ED

	arm_func_start WSetAuthAlgo
WSetAuthAlgo: // 0x027EAFBC
	cmp r0, #1
	movhi r0, #5
	ldrls r1, _027EAFDC // =0x0380FFF4
	ldrls r1, [r1, #0]
	addls r1, r1, #0x300
	strlsh r0, [r1, #0x32]
	movls r0, #0
	bx lr
	.align 2, 0
_027EAFDC: .word 0x0380FFF4
	arm_func_end WSetAuthAlgo

	arm_func_start WSetPreambleType
WSetPreambleType: // 0x027EAFE0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _027EB098 // =0x0380FFF4
	ldr r2, [r1, #0]
	add r1, r2, #0x344
	cmp r0, #1
	movhi r0, #5
	bhi _027EB08C
	add r2, r2, #0x300
	ldrh r3, [r2, #0x3a]
	bic ip, r3, #4
	and r3, r0, #1
	orr r3, ip, r3, lsl #2
	strh r3, [r2, #0x3a]
	cmp r0, #0
	ldreqh r2, [r1, #0x7c]
	biceq r2, r2, #0x20
	streqh r2, [r1, #0x7c]
	ldrneh r2, [r1, #0x7c]
	orrne r2, r2, #0x20
	strneh r2, [r1, #0x7c]
	ldrh r2, [r1, #8]
	cmp r2, #0x40
	bne _027EB060
	ldr r2, _027EB098 // =0x0380FFF4
	ldr r3, [r2, #0]
	add r2, r3, #0x300
	ldrh r2, [r2, #0x2e]
	cmp r2, #1
	ldreqh r2, [r1, #0x7c]
	ldreq r1, [r3, #0x4ac]
	streqh r2, [r1, #0x2e]
_027EB060:
	cmp r0, #0
	ldreq r1, _027EB09C // =0x048080BC
	ldreqh r0, [r1, #0]
	biceq r0, r0, #6
	streqh r0, [r1]
	ldrne r1, _027EB09C // =0x048080BC
	ldrneh r0, [r1, #0]
	orrne r0, r0, #6
	strneh r0, [r1]
	bl WSetTxTimeStampOffset
	mov r0, #0
_027EB08C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EB098: .word 0x0380FFF4
_027EB09C: .word 0x048080BC
	arm_func_end WSetPreambleType

	arm_func_start WSetSsidMask
WSetSsidMask: // 0x027EB0A0
	ldr r1, _027EB0CC // =0x0380FFF4
	ldr r1, [r1, #0]
	add r2, r1, #0x384
	mov r3, #0
_027EB0B0:
	ldrh r1, [r0], #2
	strh r1, [r2], #2
	add r3, r3, #1
	cmp r3, #0x10
	blo _027EB0B0
	mov r0, #0
	bx lr
	.align 2, 0
_027EB0CC: .word 0x0380FFF4
	arm_func_end WSetSsidMask

	arm_func_start WSetActiveZoneTime
WSetActiveZoneTime: // 0x027EB0D0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	cmp r4, #0xa
	movlo r0, #5
	blo _027EB17C
	ldr r0, _027EB188 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	strh r4, [r0, #0x3c]
	cmp r1, #0
	ldrne r0, _027EB18C // =0x04808134
	strneh r4, [r0]
	ldr r0, _027EB188 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r0, r1, #0x400
	ldrh r0, [r0, #0xa4]
	cmp r0, #0
	beq _027EB178
	ldr r0, [r1, #0x4ac]
	add r2, r0, #0x24
	add r0, r1, #0x300
	ldrh r1, [r0, #0xda]
	add r1, r2, r1
	add r5, r1, #6
	ldrh r0, [r0, #0x52]
	cmp r0, #1
	bne _027EB160
	mov r0, r5
	and r1, r4, #0xff
	bl WL_WriteByte
	add r0, r5, #1
	mov r1, r4, asr #8
	and r1, r1, #0xff
	bl WL_WriteByte
	b _027EB178
_027EB160:
	mov r0, r5
	mov r1, #0xff
	bl WL_WriteByte
	add r0, r5, #1
	mov r1, #0xff
	bl WL_WriteByte
_027EB178:
	mov r0, #0
_027EB17C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027EB188: .word 0x0380FFF4
_027EB18C: .word 0x04808134
	arm_func_end WSetActiveZoneTime

	arm_func_start WSetBeaconLostThreshold
WSetBeaconLostThreshold: // 0x027EB190
	cmp r0, #0xff
	movhi r0, #5
	bxhi lr
	mov r3, #0
	ldr r2, _027EB1C4 // =0x0380FFF4
	ldr r1, [r2, #0]
	add r1, r1, #0x300
	strh r3, [r1, #0xc4]
	ldr r1, [r2, #0]
	add r1, r1, #0x300
	strh r0, [r1, #0xc2]
	mov r0, r3
	bx lr
	.align 2, 0
_027EB1C4: .word 0x0380FFF4
	arm_func_end WSetBeaconLostThreshold

	arm_func_start WSetBcSsidResponse
WSetBcSsidResponse: // 0x027EB1C8
	cmp r0, #1
	movhi r0, #5
	bxhi lr
	ldr r1, _027EB1FC // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r2, [r1, #0x3a]
	bic r2, r2, #2
	and r0, r0, #1
	orr r0, r2, r0, lsl #1
	strh r0, [r1, #0x3a]
	mov r0, #0
	bx lr
	.align 2, 0
_027EB1FC: .word 0x0380FFF4
	arm_func_end WSetBcSsidResponse

	arm_func_start WSetBeaconType
WSetBeaconType: // 0x027EB200
	cmp r0, #1
	movhi r0, #5
	bxhi lr
	ldr r1, _027EB234 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r2, [r1, #0x3a]
	bic r2, r2, #1
	and r0, r0, #1
	orr r0, r2, r0
	strh r0, [r1, #0x3a]
	mov r0, #0
	bx lr
	.align 2, 0
_027EB234: .word 0x0380FFF4
	arm_func_end WSetBeaconType

	arm_func_start WSetWepKey
WSetWepKey: // 0x027EB238
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _027EB28C // =0x04805F80
	mov r1, r4
	mov r2, #0x14
	bl DMA_Write
	ldr r0, _027EB290 // =0x04805FA0
	add r1, r4, #0x14
	mov r2, #0x14
	bl DMA_Write
	ldr r0, _027EB294 // =0x04805FC0
	add r1, r4, #0x28
	mov r2, #0x14
	bl DMA_Write
	ldr r0, _027EB298 // =0x04805FE0
	add r1, r4, #0x3c
	mov r2, #0x14
	bl DMA_Write
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EB28C: .word 0x04805F80
_027EB290: .word 0x04805FA0
_027EB294: .word 0x04805FC0
_027EB298: .word 0x04805FE0
	arm_func_end WSetWepKey

	arm_func_start WSetWepKeyId
WSetWepKeyId: // 0x027EB29C
	cmp r0, #3
	movhi r0, #5
	ldrls r1, _027EB2BC // =0x0380FFF4
	ldrls r1, [r1, #0]
	addls r1, r1, #0x300
	strlsh r0, [r1, #0x36]
	movls r0, #0
	bx lr
	.align 2, 0
_027EB2BC: .word 0x0380FFF4
	arm_func_end WSetWepKeyId

	arm_func_start WSetWepMode
WSetWepMode: // 0x027EB2C0
	ldr r1, _027EB368 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r2, r1, #0x344
	cmp r0, #3
	movhi r0, #5
	bxhi lr
	add r1, r1, #0x300
	strh r0, [r1, #0x34]
	cmp r0, #0
	bne _027EB304
	ldrh r1, [r2, #0x7c]
	bic r1, r1, #0x10
	strh r1, [r2, #0x7c]
	ldrh r1, [r2, #0x8a]
	bic r1, r1, #0x4000
	strh r1, [r2, #0x8a]
	b _027EB31C
_027EB304:
	ldrh r1, [r2, #0x7c]
	orr r1, r1, #0x10
	strh r1, [r2, #0x7c]
	ldrh r1, [r2, #0x8a]
	orr r1, r1, #0x4000
	strh r1, [r2, #0x8a]
_027EB31C:
	ldrh r1, [r2, #8]
	cmp r1, #0x40
	bne _027EB340
	cmp r0, #1
	ldreqh r2, [r2, #0x7c]
	ldreq r1, _027EB368 // =0x0380FFF4
	ldreq r1, [r1, #0]
	ldreq r1, [r1, #0x4ac]
	streqh r2, [r1, #0x2e]
_027EB340:
	cmp r0, #0
	moveq r0, #1
	ldr r3, _027EB36C // =0x04808006
	ldrh r2, [r3, #0]
	ldr r1, _027EB370 // =0x0000FFC7
	and r1, r2, r1
	orr r0, r1, r0, lsl #3
	strh r0, [r3]
	mov r0, #0
	bx lr
	.align 2, 0
_027EB368: .word 0x0380FFF4
_027EB36C: .word 0x04808006
_027EB370: .word 0x0000FFC7
	arm_func_end WSetWepMode

	arm_func_start WSetRate
WSetRate: // 0x027EB374
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #2
	movhi r0, #5
	bhi _027EB3A0
	ldr r1, _027EB3AC // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	strh r0, [r1, #0x30]
	bl WSetTxTimeStampOffset
	mov r0, #0
_027EB3A0:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EB3AC: .word 0x0380FFF4
	arm_func_end WSetRate

	arm_func_start WSetMode
WSetMode: // 0x027EB3B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #3
	movhi r0, #5
	bhi _027EB420
	ldr ip, _027EB42C // =0x0380FFF4
	ldr r1, [ip]
	add r1, r1, #0x300
	strh r0, [r1, #0x2e]
	ldr r1, [ip]
	add r1, r1, #0x300
	strh r0, [r1, #0x50]
	ldr r3, _027EB430 // =0x04808006
	ldrh r2, [r3, #0]
	ldr r1, _027EB434 // =0x0000FFF8
	and r1, r2, r1
	orr r0, r1, r0
	strh r0, [r3]
	ldr r0, [ip]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x52]
	bl WSetPowerMgtMode
	ldr r0, _027EB42C // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x340]
	orr r0, r0, #8
	str r0, [r1, #0x340]
	mov r0, #0
_027EB420:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EB42C: .word 0x0380FFF4
_027EB430: .word 0x04808006
_027EB434: .word 0x0000FFF8
	arm_func_end WSetMode

	arm_func_start WSetEnableChannel
WSetEnableChannel: // 0x027EB438
	ldr r1, _027EB470 // =0x00007FFE
	ands r1, r0, r1
	moveq r0, #5
	bxeq lr
	ldr r2, _027EB474 // =0x0380FFF4
	ldr r1, [r2, #0]
	add r1, r1, #0x300
	strh r0, [r1, #0x2c]
	ldr r1, [r2, #0]
	ldr r0, [r1, #0x340]
	orr r0, r0, #4
	str r0, [r1, #0x340]
	mov r0, #0
	bx lr
	.align 2, 0
_027EB470: .word 0x00007FFE
_027EB474: .word 0x0380FFF4
	arm_func_end WSetEnableChannel

	arm_func_start WSetRetryLimit
WSetRetryLimit: // 0x027EB478
	cmp r0, #0xff
	movhi r0, #5
	bxhi lr
	ldr r1, _027EB4A4 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	strh r0, [r1, #0x2a]
	ldr r1, _027EB4A8 // =0x0480802C
	strh r0, [r1]
	mov r0, #0
	bx lr
	.align 2, 0
_027EB4A4: .word 0x0380FFF4
_027EB4A8: .word 0x0480802C
	arm_func_end WSetRetryLimit

	arm_func_start WSetMacAdrs
WSetMacAdrs: // 0x027EB4AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #0]
	ands r0, r0, #1
	movne r0, #5
	bne _027EB4FC
	ldr r0, _027EB504 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x324
	mov r1, r4
	bl WSetMacAdrs1
	ldr r0, _027EB508 // =0x04808018
	mov r1, r4
	bl WSetMacAdrs1
	ldr r0, _027EB504 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x340]
	orr r0, r0, #2
	str r0, [r1, #0x340]
	mov r0, #0
_027EB4FC:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EB504: .word 0x0380FFF4
_027EB508: .word 0x04808018
	arm_func_end WSetMacAdrs

	arm_func_start InitializeParam
InitializeParam: // 0x027EB50C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027EB588 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r4, [r1, #0x3e0]
	mov r0, #0
	add r1, r1, #0x31c
	mov r2, #0x28
	bl MIi_CpuClear16
	mov r0, #0
	ldr r1, _027EB588 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x344
	mov r2, #0xc0
	bl MIi_CpuClear16
	ldr r2, _027EB588 // =0x0380FFF4
	ldr r0, [r2, #0]
	str r6, [r0, #0x31c]
	mov r0, r5, lsl #0x10
	mov r1, r0, lsr #0x10
	ldr r0, [r2, #0]
	add r0, r0, #0x300
	strh r1, [r0, #0x20]
	ldr r0, [r2, #0]
	add r0, r0, #0x300
	strh r1, [r0, #0x22]
	ldr r0, [r2, #0]
	str r4, [r0, #0x3e0]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EB588: .word 0x0380FFF4
	arm_func_end InitializeParam

	arm_func_start DiagBaseBand
DiagBaseBand: // 0x027EB58C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, #0
	ldr r0, _027EB878 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r0, [r0, #0xf8]
	cmp r0, #5
	ldreq r10, _027EB87C // =BBPDiagSkipAdrsES1
	ldrne r10, _027EB880 // =BBPDiagSkipAdrsRelease
	mov r6, #0
	mov r5, #0xff
	mvn r4, #0
	b _027EB5E0
_027EB5C4:
	mov r0, r6
	mov r1, r5
	bl BBP_Write
	cmp r0, r4
	moveq r9, #1
	beq _027EB84C
	add r6, r6, #1
_027EB5E0:
	cmp r6, #0x69
	blo _027EB5C4
	mov r4, #0
	mov r5, r4
	b _027EB630
_027EB5F4:
	mov r0, r5, lsl #1
	ldrh r0, [r10, r0]
	cmp r4, r0
	addeq r5, r5, #1
	beq _027EB62C
	mov r0, r4
	bl BBP_Read
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0xff
	beq _027EB62C
	cmp r9, #0x20
	add r9, r9, #1
	bhi _027EB84C
_027EB62C:
	add r4, r4, #1
_027EB630:
	cmp r4, #0x69
	blo _027EB5F4
	mov r5, #0
	mov r4, r5
_027EB640:
	mov r0, r5
	mov r1, r4
	bl BBP_Write
	add r5, r5, #1
	cmp r5, #0x69
	blo _027EB640
	mov r5, #0
	mov r4, r5
	b _027EB69C
_027EB664:
	mov r0, r4, lsl #1
	ldrh r0, [r10, r0]
	cmp r5, r0
	addeq r4, r4, #1
	beq _027EB698
	mov r0, r5
	bl BBP_Read
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	beq _027EB698
	cmp r9, #0x20
	add r9, r9, #1
	bhi _027EB84C
_027EB698:
	add r5, r5, #1
_027EB69C:
	cmp r5, #0x69
	blo _027EB664
	mov r5, #0x55
	mov r4, #0
_027EB6AC:
	mov r0, r4
	mov r1, r5
	bl BBP_Write
	add r4, r4, #1
	mvn r0, r5
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r4, #0x69
	blo _027EB6AC
	mov r5, #0x55
	mov r6, #0
	mov r4, r6
	b _027EB72C
_027EB6E0:
	mov r0, r4, lsl #1
	ldrh r0, [r10, r0]
	cmp r6, r0
	addeq r4, r4, #1
	beq _027EB718
	mov r0, r6
	bl BBP_Read
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, r5
	beq _027EB718
	cmp r9, #0x20
	add r9, r9, #1
	bhi _027EB84C
_027EB718:
	add r6, r6, #1
	mvn r0, r5
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
_027EB72C:
	cmp r6, #0x69
	blo _027EB6E0
	mov r4, #0xff
	mov r5, #0
_027EB73C:
	mov r0, r5
	mov r1, r4
	bl BBP_Write
	add r5, r5, #1
	sub r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r5, #0x69
	blo _027EB73C
	mov r5, #0xff
	mov r6, #0
	mov r4, r6
	b _027EB7B8
_027EB770:
	mov r0, r4, lsl #1
	ldrh r0, [r10, r0]
	cmp r6, r0
	addeq r4, r4, #1
	beq _027EB7A8
	mov r0, r6
	bl BBP_Read
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, r5
	beq _027EB7A8
	cmp r9, #0x20
	add r9, r9, #1
	bhi _027EB84C
_027EB7A8:
	add r6, r6, #1
	sub r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
_027EB7B8:
	cmp r6, #0x69
	blo _027EB770
	mov r6, #0
	mov r5, r6
	mov r4, #1
	mov r11, r6
	b _027EB844
_027EB7D4:
	mov r0, r5, lsl #1
	ldrh r0, [r10, r0]
	cmp r6, r0
	addeq r5, r5, #1
	beq _027EB840
	mov r7, r4
	mov r8, r11
	b _027EB838
_027EB7F4:
	mov r0, r6
	mov r1, r7
	bl BBP_Write
	mov r0, r6
	bl BBP_Read
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, r7
	beq _027EB824
	cmp r9, #0x20
	add r9, r9, #1
	bhi _027EB84C
_027EB824:
	mov r0, r7, lsl #1
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	add r8, r8, #1
_027EB838:
	cmp r8, #9
	blo _027EB7F4
_027EB840:
	add r6, r6, #1
_027EB844:
	cmp r6, #0x69
	blo _027EB7D4
_027EB84C:
	cmp r9, #0
	beq _027EB86C
	ldr r0, _027EB878 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0x3e]
	orr r1, r1, #8
	strh r1, [r0, #0x3e]
_027EB86C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027EB878: .word 0x0380FFF4
_027EB87C: .word BBPDiagSkipAdrsES1
_027EB880: .word BBPDiagSkipAdrsRelease
	arm_func_end DiagBaseBand

	arm_func_start DiagMacMemory
DiagMacMemory: // 0x027EB884
	mov r0, #0
	ldr r3, _027EB9F4 // =0x04804000
	ldr r1, _027EB9F8 // =0x0000FFFF
	mov ip, r0
_027EB894:
	mov r2, r1
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	strh r2, [r3], #2
	add ip, ip, #2
	cmp ip, #0x2000
	blo _027EB894
	ldr ip, _027EB9F4 // =0x04804000
	ldr r3, _027EB9F8 // =0x0000FFFF
	mov r2, #0
	b _027EB8F0
_027EB8C4:
	ldrh r1, [ip]
	cmp r1, r3
	beq _027EB8DC
	cmp r0, #0x20
	add r0, r0, #1
	bhi _027EB9D0
_027EB8DC:
	add r2, r2, #2
	add ip, ip, #2
	sub r1, r3, #1
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
_027EB8F0:
	cmp r2, #0x2000
	blo _027EB8C4
	ldr r3, _027EB9F4 // =0x04804000
	ldr r1, _027EB9FC // =0x00005A5A
	mov r2, #0
_027EB904:
	strh r1, [r3], #2
	add r2, r2, #2
	mvn r1, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r2, #0x2000
	blo _027EB904
	ldr ip, _027EB9F4 // =0x04804000
	ldr r3, _027EB9FC // =0x00005A5A
	mov r2, #0
	b _027EB95C
_027EB930:
	ldrh r1, [ip]
	cmp r1, r3
	beq _027EB948
	cmp r0, #0x20
	add r0, r0, #1
	bhi _027EB9D0
_027EB948:
	add r2, r2, #2
	add ip, ip, #2
	mvn r1, r3
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
_027EB95C:
	cmp r2, #0x2000
	blo _027EB930
	ldr r3, _027EB9F4 // =0x04804000
	ldr r1, _027EBA00 // =0x0000A5A5
	mov r2, #0
_027EB970:
	strh r1, [r3], #2
	add r2, r2, #2
	mvn r1, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r2, #0x2000
	blo _027EB970
	ldr ip, _027EB9F4 // =0x04804000
	ldr r3, _027EBA00 // =0x0000A5A5
	mov r2, #0
	b _027EB9C8
_027EB99C:
	ldrh r1, [ip]
	cmp r1, r3
	beq _027EB9B4
	cmp r0, #0x20
	add r0, r0, #1
	bhi _027EB9D0
_027EB9B4:
	add r2, r2, #2
	add ip, ip, #2
	mvn r1, r3
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
_027EB9C8:
	cmp r2, #0x2000
	blo _027EB99C
_027EB9D0:
	cmp r0, #0
	bxeq lr
	ldr r0, _027EBA04 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0x3e]
	orr r1, r1, #2
	strh r1, [r0, #0x3e]
	bx lr
	.align 2, 0
_027EB9F4: .word 0x04804000
_027EB9F8: .word 0x0000FFFF
_027EB9FC: .word 0x00005A5A
_027EBA00: .word 0x0000A5A5
_027EBA04: .word 0x0380FFF4
	arm_func_end DiagMacMemory

	arm_func_start DiagMacRegister
DiagMacRegister: // 0x027EBA08
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r3, #0
	mov r2, r3
	mov r1, r3
	ldr r0, _027EBBA4 // =test_reg
	ldr r5, _027EBBA8 // =test_pattern
	b _027EBA80
_027EBA28:
	mov ip, r1
	mov r6, r2, lsl #1
	b _027EBA74
_027EBA34:
	mov r4, ip, lsl #2
	ldrh r7, [r0, r4]
	ldrh r4, [r5, r6]
	add lr, r0, ip, lsl #2
	ldrh lr, [lr, #2]
	and r4, r4, lr
	add lr, r7, #0x4800000
	add lr, lr, #0x8000
	strh r4, [lr]
	ldrh lr, [lr]
	cmp lr, r4
	beq _027EBA70
	cmp r3, #0x20
	add r3, r3, #1
	bhi _027EBB78
_027EBA70:
	add ip, ip, #1
_027EBA74:
	cmp ip, #0x1b
	blo _027EBA34
	add r2, r2, #1
_027EBA80:
	cmp r2, #3
	blo _027EBA28
	mov r4, #0
	ldr r5, _027EBBAC // =0x00001234
	ldr r2, _027EBBA4 // =test_reg
	mov r1, r5
_027EBA98:
	mov ip, r4, lsl #2
	add r0, r2, r4, lsl #2
	ldrh r0, [r0, #2]
	and lr, r5, r0
	ldrh r0, [r2, ip]
	add r0, r0, #0x4800000
	add r0, r0, #0x8000
	strh lr, [r0]
	add r0, r5, r1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	add r4, r4, #1
	cmp r4, #0x1b
	blo _027EBA98
	mov r0, #0
	ldr r4, _027EBBAC // =0x00001234
	ldr lr, _027EBBA4 // =test_reg
	mov r1, r4
	b _027EBB28
_027EBAE4:
	mov r2, r0, lsl #2
	ldrh r2, [lr, r2]
	add r2, r2, #0x4800000
	add r2, r2, #0x8000
	ldrh ip, [r2]
	add r2, lr, r0, lsl #2
	ldrh r2, [r2, #2]
	and r2, r4, r2
	cmp ip, r2
	beq _027EBB18
	cmp r3, #0x20
	add r3, r3, #1
	bhi _027EBB78
_027EBB18:
	add r2, r4, r1
	mov r2, r2, lsl #0x10
	mov r4, r2, lsr #0x10
	add r0, r0, #1
_027EBB28:
	cmp r0, #0x1b
	blo _027EBAE4
	mov r4, #0
	ldr r2, _027EBBA4 // =test_reg
	mov r1, r4
	b _027EBB70
_027EBB40:
	mov r0, r4, lsl #2
	ldrh r0, [r2, r0]
	add r0, r0, #0x4800000
	add r0, r0, #0x8000
	strh r1, [r0]
	ldrh r0, [r0, #0]
	cmp r0, #0
	beq _027EBB6C
	cmp r3, #0x20
	add r3, r3, #1
	bhi _027EBB78
_027EBB6C:
	add r4, r4, #1
_027EBB70:
	cmp r4, #0x1b
	blo _027EBB40
_027EBB78:
	cmp r3, #0
	beq _027EBB98
	ldr r0, _027EBBB0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0x3e]
	orr r1, r1, #1
	strh r1, [r0, #0x3e]
_027EBB98:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027EBBA4: .word test_reg
_027EBBA8: .word test_pattern
_027EBBAC: .word 0x00001234
_027EBBB0: .word 0x0380FFF4
	arm_func_end DiagMacRegister

	arm_func_start ReleaseIntr
ReleaseIntr: // 0x027EBBB4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r0, #0x1000000
	mov r1, #0
	bl OS_SetIrqFunction
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end ReleaseIntr

	arm_func_start InitializeIntr
InitializeIntr: // 0x027EBBDC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0x1000000
	ldr r1, _027EBC04 // =WlIntr
	bl OS_SetIrqFunction
	mov r0, #0x1000000
	bl OS_EnableIrqMask
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EBC04: .word WlIntr
	arm_func_end InitializeIntr

	arm_func_start CheckKeyTxEndMain
CheckKeyTxEndMain: // 0x027EBC08
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r1, [r0, #0]
	cmp r1, #0
	beq _027EBC58
	ldr r2, [r0, #8]
	ldrh r1, [r2, #0]
	ands r1, r1, #1
	beq _027EBC58
	ldr r1, _027EBC68 // =0x00003FFF
	and r1, r2, r1
	mov r1, r1, lsr #1
	orr r2, r1, #0x8000
	ldr r1, _027EBC6C // =0x04808098
	ldrh r1, [r1, #0]
	cmp r2, r1
	beq _027EBC58
	bl TxEndKeyData
	mov r0, #1
	b _027EBC5C
_027EBC58:
	mov r0, #0
_027EBC5C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EBC68: .word 0x00003FFF
_027EBC6C: .word 0x04808098
	arm_func_end CheckKeyTxEndMain

	arm_func_start MultiPollRevicedClearSeq
MultiPollRevicedClearSeq: // 0x027EBC70
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027EBCC8 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027EBCCC // =0x0000042C
	add lr, r1, r0
	ldrh r1, [lr, #0xa4]
	ldr r0, _027EBCD0 // =0x0000FFFF
	cmp r1, r0
	beq _027EBCBC
	ldr ip, _027EBCD4 // =0x04808094
	ldrh r3, [ip]
	strh r1, [ip]
	ldr r2, _027EBCD8 // =0x04808030
	ldrh r1, [r2, #0]
	orr r1, r1, #0x80
	strh r1, [r2]
	strh r3, [ip]
	strh r0, [lr, #0xa4]
_027EBCBC:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EBCC8: .word 0x0380FFF4
_027EBCCC: .word 0x0000042C
_027EBCD0: .word 0x0000FFFF
_027EBCD4: .word 0x04808094
_027EBCD8: .word 0x04808030
	arm_func_end MultiPollRevicedClearSeq

	arm_func_start WlIntrRfWakeup
WlIntrRfWakeup: // 0x027EBCDC
	mov r1, #0x800
	ldr r0, _027EBCEC // =0x04808010
	strh r1, [r0]
	bx lr
	.align 2, 0
_027EBCEC: .word 0x04808010
	arm_func_end WlIntrRfWakeup

	arm_func_start CAM_InitElement
CAM_InitElement: // 0x027EBCF0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027EBDBC // =0x0380FFF4
	ldr r2, [r0, #0]
	ldr r1, [r2, #0x31c]
	mov r0, #0x1c
	mul r0, r6, r0
	add r4, r1, r0
	ldrh r0, [r1, r0]
	cmp r0, #0
	addeq r0, r2, #0x500
	ldreqh r1, [r0, #0x2c]
	addeq r1, r1, #1
	streqh r1, [r0, #0x2c]
	mov r0, #0
	mov r1, r4
	mov r2, #0x1a
	bl MIi_CpuClear16
	ldr r0, _027EBDBC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r2, [r0, #0x34]
	mov r1, #1
	mvn r1, r1, lsl r6
	and r1, r2, r1
	strh r1, [r0, #0x34]
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl CAM_SetPowerMgtMode
	mov r0, r6
	bl CAM_SetAwake
	add r0, r4, #4
	mov r1, r5
	bl WSetMacAdrs1
	ldr r0, _027EBDC0 // =0x0000FFFF
	strh r0, [r4, #0x14]
	ldr r0, _027EBDBC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xa6]
	strh r0, [r4, #0x10]
	ldrh r0, [r4, #0x1a]
	strh r0, [r4, #0x18]
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x20
	bl CAM_SetStaState
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EBDBC: .word 0x0380FFF4
_027EBDC0: .word 0x0000FFFF
	arm_func_end CAM_InitElement

	arm_func_start InitCAM
InitCAM: // 0x027EBDC4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r0, _027EBE44 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r5, [r1, #0x31c]
	ldr r0, _027EBE48 // =0x0000052C
	add r4, r1, r0
	add r0, r1, #0x300
	ldrh r9, [r0, #0x22]
	mov r10, #1
	mov r8, #0
	mov r7, #0x1a
	mov r6, #0x1c
	b _027EBE0C
_027EBDF8:
	mov r0, r8
	mla r1, r10, r6, r5
	mov r2, r7
	bl MIi_CpuClear16
	add r10, r10, #1
_027EBE0C:
	cmp r10, r9
	blo _027EBDF8
	mov r2, #1
	strh r2, [r4]
	mov r1, #0
	strh r1, [r4, #2]
	strh r2, [r4, #4]
	ldr r0, _027EBE4C // =0x0000FFFE
	strh r0, [r4, #6]
	strh r1, [r4, #0xc]
	strh r1, [r4, #8]
	strh r2, [r4, #0xe]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_027EBE44: .word 0x0380FFF4
_027EBE48: .word 0x0000052C
_027EBE4C: .word 0x0000FFFE
	arm_func_end InitCAM

	arm_func_start InitializeCAM
InitializeCAM: // 0x027EBE50
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _027EBEE8 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r5, [r0, #0x31c]
	add r0, r0, #0x300
	ldrh r4, [r0, #0x22]
	mov r0, #0
	mov r1, r5
	mov r2, #0x1c
	mul r2, r4, r2
	bl MIi_CpuClear16
	mov r0, #0
	ldr r1, _027EBEE8 // =0x0380FFF4
	ldr r2, [r1, #0]
	ldr r1, _027EBEEC // =0x0000052C
	add r1, r2, r1
	mov r2, #0x10
	bl MIi_CpuClear16
	ldr r2, _027EBEF0 // =0x0000FFFF
	strh r2, [r5, #0x1a]
	mov r3, #1
	mov r0, #0x1c
	b _027EBEBC
_027EBEB0:
	mla r1, r3, r0, r5
	strh r2, [r1, #0x1a]
	add r3, r3, #1
_027EBEBC:
	cmp r3, r4
	blo _027EBEB0
	mov r0, #0
	ldr r1, _027EBEF4 // =BC_ADRS
	bl CAM_InitElement
	mov r0, #0
	mov r1, #0x40
	bl CAM_SetStaState
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027EBEE8: .word 0x0380FFF4
_027EBEEC: .word 0x0000052C
_027EBEF0: .word 0x0000FFFF
_027EBEF4: .word BC_ADRS
	arm_func_end InitializeCAM

	arm_func_start CAM_Delete
CAM_Delete: // 0x027EBEF8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl DeleteTxFrames
	mov r3, #0
	ldr r2, _027EBF3C // =0x0380FFF4
	ldr r0, [r2, #0]
	ldr r1, [r0, #0x31c]
	mov r0, #0x1c
	mul r0, r4, r0
	strh r3, [r1, r0]
	ldr r0, [r2, #0]
	add r0, r0, #0x500
	ldrh r1, [r0, #0x2c]
	sub r1, r1, #1
	strh r1, [r0, #0x2c]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EBF3C: .word 0x0380FFF4
	arm_func_end CAM_Delete

	arm_func_start CAM_TimerTask
CAM_TimerTask: // 0x027EBF40
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	ldr r0, _027EC120 // =0x0380FFF4
	ldr r10, [r0, #0]
	ldr r0, [r10, #0x31c]
	add r9, r0, #0x1c
	add r0, r10, #0x500
	ldrh r6, [r0, #0x2c]
	mov r7, #0
	mov r8, #1
	mov r11, r8
	str r7, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	mov r4, #0x20
	str r8, [sp, #0x14]
	str r7, [sp, #0x18]
	str r8, [sp, #0x20]
	str r8, [sp, #0x10]
	str r7, [sp, #0x24]
	str r8, [sp, #0x1c]
	str r8, [sp, #0xc]
	b _027EC104
_027EBF9C:
	ldrh r0, [r9, #0]
	cmp r0, #0
	beq _027EC0F4
	ldrh r1, [r9, #0x18]
	cmp r1, #0
	beq _027EC0F0
	ldr r0, _027EC124 // =0x0000FFFF
	cmp r1, r0
	beq _027EC0F0
	sub r0, r1, #1
	strh r0, [r9, #0x18]
	ldrh r0, [r9, #0x18]
	cmp r0, #0
	bne _027EC0F0
	ldrh r0, [r9, #0]
	cmp r0, #0x20
	blo _027EC0D8
	mov r0, r8
	bl CAM_GetStaState
	mov r5, r0
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r4
	bl CAM_SetStaState
	mov r0, r8
	bl DeleteTxFrames
	add r0, r10, #0x300
	ldrh r1, [r0, #0x50]
	cmp r1, #1
	bne _027EC088
	cmp r5, #0x20
	bls _027EC0D8
	ldr r0, _027EC120 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r1, [r0, #0x34]
	orr r1, r1, r11, lsl r8
	strh r1, [r0, #0x34]
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr r1, [sp]
	bl CAM_SetPowerMgtMode
	mov r0, r8
	bl CAM_SetAwake
	add r0, r9, #4
	ldr r1, [sp, #4]
	ldr r2, [sp, #8]
	bl MakeDeAuthFrame
	cmp r0, #0
	beq _027EC078
	ldr r1, [sp, #0xc]
	strh r1, [r0]
	bl TxManCtrlFrame
	add r7, r7, #1
	b _027EC0FC
_027EC078:
	add r0, r9, #4
	ldr r1, [sp, #0x10]
	bl MLME_IssueDeAuthIndication
	b _027EC0D8
_027EC088:
	ldrh r0, [r0, #0xcc]
	cmp r8, r0
	bne _027EC0D8
	add r0, r9, #4
	ldr r1, [sp, #0x14]
	ldr r2, [sp, #0x18]
	bl MakeDeAuthFrame
	cmp r0, #0
	beq _027EC0C0
	ldr r1, [sp, #0x1c]
	strh r1, [r0]
	bl TxManCtrlFrame
	add r7, r7, #1
	b _027EC0FC
_027EC0C0:
	mov r0, r4
	bl WSetStaState
	bl WClearAids
	add r0, r9, #4
	ldr r1, [sp, #0x20]
	bl MLME_IssueDeAuthIndication
_027EC0D8:
	ldr r0, [sp, #0x24]
	strh r0, [r9]
	add r0, r10, #0x500
	ldrh r1, [r0, #0x2c]
	sub r1, r1, #1
	strh r1, [r0, #0x2c]
_027EC0F0:
	add r7, r7, #1
_027EC0F4:
	cmp r7, r6
	bhs _027EC114
_027EC0FC:
	add r8, r8, #1
	add r9, r9, #0x1c
_027EC104:
	add r0, r10, #0x300
	ldrh r0, [r0, #0x22]
	cmp r8, r0
	blo _027EBF9C
_027EC114:
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027EC120: .word 0x0380FFF4
_027EC124: .word 0x0000FFFF
	arm_func_end CAM_TimerTask

	arm_func_start CAM_ClrTIMElementBitmap
CAM_ClrTIMElementBitmap: // 0x027EC128
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	bl CAM_GetStaState
	cmp r0, #0x40
	bne _027EC1C4
	ldr r0, _027EC1CC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0xd8]
	ldr r0, _027EC1D0 // =0x0480425C
	add r6, r1, r0
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r4, r0
	cmp r5, #0
	bne _027EC184
	add r0, r6, #4
	bl WL_ReadByte
	and r1, r0, #0xfe
	add r0, r6, #4
	and r1, r1, #0xff
	bl WL_WriteByte
	b _027EC1BC
_027EC184:
	mov r0, r5
	bl CAM_GetAID
	mov r5, r0
	add r0, r6, #5
	add r6, r0, r5, lsr #3
	mov r0, r6
	bl WL_ReadByte
	mov r2, #1
	and r1, r5, #7
	mvn r1, r2, lsl r1
	and r1, r1, r0
	mov r0, r6
	and r1, r1, #0xff
	bl WL_WriteByte
_027EC1BC:
	mov r0, r4
	bl OS_EnableIrqMask
_027EC1C4:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EC1CC: .word 0x0380FFF4
_027EC1D0: .word 0x0480425C
	arm_func_end CAM_ClrTIMElementBitmap

	arm_func_start CAM_SetTIMElementBitmap
CAM_SetTIMElementBitmap: // 0x027EC1D4
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	bl CAM_GetStaState
	cmp r0, #0x40
	bne _027EC284
	ldr r0, _027EC28C // =0x0380FFF4
	ldr r2, [r0, #0]
	add r0, r2, #0x500
	ldrh r1, [r0, #0x34]
	mov r0, #1
	mov r0, r0, lsl r5
	ands r0, r1, r0
	bne _027EC284
	add r0, r2, #0x300
	ldrh r1, [r0, #0xd8]
	ldr r0, _027EC290 // =0x0480425C
	add r6, r1, r0
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r4, r0
	cmp r5, #0
	bne _027EC248
	add r0, r6, #4
	bl WL_ReadByte
	orr r1, r0, #1
	add r0, r6, #4
	and r1, r1, #0xff
	bl WL_WriteByte
	b _027EC27C
_027EC248:
	mov r0, r5
	bl CAM_GetAID
	mov r5, r0
	add r0, r6, #5
	add r6, r0, r5, lsr #3
	mov r0, r6
	bl WL_ReadByte
	mov r2, #1
	and r1, r5, #7
	orr r1, r0, r2, lsl r1
	mov r0, r6
	and r1, r1, #0xff
	bl WL_WriteByte
_027EC27C:
	mov r0, r4
	bl OS_EnableIrqMask
_027EC284:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EC28C: .word 0x0380FFF4
_027EC290: .word 0x0480425C
	arm_func_end CAM_SetTIMElementBitmap

	arm_func_start CAM_GetTbl
CAM_GetTbl: // 0x027EC294
	ldr r1, _027EC2AC // =0x0380FFF4
	ldr r1, [r1, #0]
	ldr r2, [r1, #0x31c]
	mov r1, #0x1c
	mla r0, r1, r0, r2
	bx lr
	.align 2, 0
_027EC2AC: .word 0x0380FFF4
	arm_func_end CAM_GetTbl

	arm_func_start CAM_GetFrameCount
CAM_GetFrameCount: // 0x027EC2B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CAM_GetTbl
	ldrh r0, [r0, #0x16]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CAM_GetFrameCount

	arm_func_start CAM_GetAID
CAM_GetAID: // 0x027EC2CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CAM_GetTbl
	ldrh r0, [r0, #2]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CAM_GetAID

	arm_func_start CAM_GetTxRate
CAM_GetTxRate: // 0x027EC2E8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CAM_GetTbl
	ldrh r0, [r0, #0x10]
	ands r0, r0, #2
	movne r0, #0x14
	moveq r0, #0xa
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CAM_GetTxRate

	arm_func_start CAM_GetLastSeqCtrl
CAM_GetLastSeqCtrl: // 0x027EC310
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CAM_GetTbl
	ldrh r0, [r0, #0x14]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CAM_GetLastSeqCtrl

	arm_func_start CAM_GetAuthSeed
CAM_GetAuthSeed: // 0x027EC32C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CAM_GetTbl
	ldrh r0, [r0, #0xe]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CAM_GetAuthSeed

	arm_func_start CAM_GetMacAdrs
CAM_GetMacAdrs: // 0x027EC348
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CAM_GetTbl
	add r0, r0, #4
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CAM_GetMacAdrs

	arm_func_start CAM_GetPowerMgtMode
CAM_GetPowerMgtMode: // 0x027EC364
	ldr r1, _027EC380 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x500
	ldrh r1, [r1, #0x2e]
	mov r0, r1, asr r0
	and r0, r0, #1
	bx lr
	.align 2, 0
_027EC380: .word 0x0380FFF4
	arm_func_end CAM_GetPowerMgtMode

	arm_func_start CAM_IsActive
CAM_IsActive: // 0x027EC384
	ldr r1, _027EC3A0 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x500
	ldrh r1, [r1, #0x30]
	mov r0, r1, asr r0
	and r0, r0, #1
	bx lr
	.align 2, 0
_027EC3A0: .word 0x0380FFF4
	arm_func_end CAM_IsActive

	arm_func_start CAM_GetStaState
CAM_GetStaState: // 0x027EC3A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl CAM_GetTbl
	ldrh r0, [r0, #0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end CAM_GetStaState

	arm_func_start CAM_ReleaseAID
CAM_ReleaseAID: // 0x027EC3C0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r1, _027EC430 // =0x0380FFF4
	ldr r5, [r1, #0]
	bl CAM_ClrTIMElementBitmap
	mov r0, r6
	bl CAM_GetAID
	movs r4, r0
	beq _027EC428
	mov r0, r6
	bl CAM_GetTbl
	mov r1, #0
	strh r1, [r0, #2]
	add r0, r5, #0x500
	ldrh r2, [r0, #0x3a]
	mov r1, #1
	mvn r1, r1, lsl r4
	and r1, r2, r1
	strh r1, [r0, #0x3a]
	ldrh r1, [r0, #0x38]
	sub r1, r1, #1
	strh r1, [r0, #0x38]
	ldrh r0, [r0, #0x38]
	cmp r0, #0
	bne _027EC428
	bl WDisableTmpttPowerSave
_027EC428:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EC430: .word 0x0380FFF4
	arm_func_end CAM_ReleaseAID

	arm_func_start CAM_AllocateAID
CAM_AllocateAID: // 0x027EC434
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r0, _027EC4DC // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027EC4E0 // =0x0000052C
	add r6, r1, r0
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r4, r0
	mov r5, #1
	mov r2, #2
	b _027EC4BC
_027EC468:
	ldrh r0, [r6, #0xe]
	ands r1, r0, r2
	bne _027EC4B4
	orr r0, r0, r2
	strh r0, [r6, #0xe]
	ldrh r0, [r6, #0xc]
	add r0, r0, #1
	strh r0, [r6, #0xc]
	ldrh r0, [r6, #0xc]
	cmp r0, #1
	bne _027EC498
	bl WEnableTmpttPowerSave
_027EC498:
	mov r0, r7
	bl CAM_GetTbl
	strh r5, [r0, #2]
	mov r0, r4
	bl OS_EnableIrqMask
	mov r0, r5
	b _027EC4D0
_027EC4B4:
	add r5, r5, #1
	mov r2, r2, lsl #1
_027EC4BC:
	cmp r5, #0x10
	blo _027EC468
	mov r0, r4
	bl OS_EnableIrqMask
	mov r0, #0
_027EC4D0:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027EC4DC: .word 0x0380FFF4
_027EC4E0: .word 0x0000052C
	arm_func_end CAM_AllocateAID

	arm_func_start CAM_UpdateLifeTime
CAM_UpdateLifeTime: // 0x027EC4E4
	mov r1, #0x1c
	ldr r2, _027EC504 // =0x0380FFF4
	ldr r2, [r2, #0]
	ldr r2, [r2, #0x31c]
	mla r1, r0, r1, r2
	ldrh r0, [r1, #0x1a]
	strh r0, [r1, #0x18]
	bx lr
	.align 2, 0
_027EC504: .word 0x0380FFF4
	arm_func_end CAM_UpdateLifeTime

	arm_func_start CAM_SetAuthSeed
CAM_SetAuthSeed: // 0x027EC508
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl CAM_GetTbl
	strh r4, [r0, #0xe]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CAM_SetAuthSeed

	arm_func_start CAM_SetLastSeqCtrl
CAM_SetLastSeqCtrl: // 0x027EC520
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl CAM_GetTbl
	strh r4, [r0, #0x14]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CAM_SetLastSeqCtrl

	arm_func_start CAM_SetSupRate
CAM_SetSupRate: // 0x027EC538
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl CAM_GetTbl
	strh r4, [r0, #0x10]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CAM_SetSupRate

	arm_func_start CAM_SetCapaInfo
CAM_SetCapaInfo: // 0x027EC550
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl CAM_GetTbl
	strh r4, [r0, #0xc]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CAM_SetCapaInfo

	arm_func_start CAM_SetAwake
CAM_SetAwake: // 0x027EC568
	ldr r1, _027EC588 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x500
	ldrh r3, [r1, #0x30]
	mov r2, #1
	orr r0, r3, r2, lsl r0
	strh r0, [r1, #0x30]
	bx lr
	.align 2, 0
_027EC588: .word 0x0380FFF4
	arm_func_end CAM_SetAwake

	arm_func_start CAM_SetDoze
CAM_SetDoze: // 0x027EC58C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl CAM_GetStaState
	cmp r0, #0x40
	bne _027EC5C0
	ldr r0, _027EC5C8 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r2, [r0, #0x30]
	mov r1, #1
	mvn r1, r1, lsl r4
	and r1, r2, r1
	strh r1, [r0, #0x30]
_027EC5C0:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EC5C8: .word 0x0380FFF4
	arm_func_end CAM_SetDoze

	arm_func_start CAM_SetPowerMgtMode
CAM_SetPowerMgtMode: // 0x027EC5CC
	ldr r2, _027EC620 // =0x0380FFF4
	ldr r3, [r2, #0]
	ldr r2, _027EC624 // =0x0000052C
	add ip, r3, r2
	ldrh r3, [ip, #2]
	mov r2, #1
	mvn r2, r2, lsl r0
	and r2, r3, r2
	orr r0, r2, r1, lsl r0
	strh r0, [ip, #2]
	ldrh r1, [ip, #2]
	ldrh r0, [ip, #6]
	mvn r0, r0
	ands r0, r1, r0
	movne r1, #8
	ldrne r0, _027EC628 // =0x048080AC
	strneh r1, [r0]
	moveq r1, #8
	ldreq r0, _027EC62C // =0x048080AE
	streqh r1, [r0]
	bx lr
	.align 2, 0
_027EC620: .word 0x0380FFF4
_027EC624: .word 0x0000052C
_027EC628: .word 0x048080AC
_027EC62C: .word 0x048080AE
	arm_func_end CAM_SetPowerMgtMode

	arm_func_start CAM_SetRSSI
CAM_SetRSSI: // 0x027EC630
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl CAM_GetTbl
	strh r4, [r0, #0xa]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CAM_SetRSSI

	arm_func_start CAM_SetStaState
CAM_SetStaState: // 0x027EC648
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r4, r0
	cmp r5, #0x40
	bhs _027EC6BC
	mov r0, r6
	bl CAM_SetAwake
	ldr r3, _027EC710 // =0x0380FFF4
	ldr r0, [r3, #0]
	add r0, r0, #0x500
	ldrh r2, [r0, #0x32]
	mov r1, #1
	orr r1, r2, r1, lsl r6
	strh r1, [r0, #0x32]
	ldr r0, [r3, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x50]
	cmp r0, #1
	bne _027EC6F4
	mov r0, r6
	bl CAM_GetAID
	cmp r0, #0
	beq _027EC6F4
	mov r0, r6
	bl CAM_ReleaseAID
	b _027EC6F4
_027EC6BC:
	ldr r0, _027EC710 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r2, [r0, #0x32]
	mov r1, #1
	mvn r1, r1, lsl r6
	and r1, r2, r1
	strh r1, [r0, #0x32]
	mov r0, r6
	bl CAM_GetPowerMgtMode
	cmp r0, #0
	beq _027EC6F4
	mov r0, r6
	bl CAM_SetDoze
_027EC6F4:
	mov r0, r6
	bl CAM_GetTbl
	strh r5, [r0]
	mov r0, r4
	bl OS_EnableIrqMask
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EC710: .word 0x0380FFF4
	arm_func_end CAM_SetStaState

	arm_func_start CAM_DecFrameCount
CAM_DecFrameCount: // 0x027EC714
	stmdb sp!, {r4, r5, r6, lr}
	ldrh r4, [r0, #2]
	mov r0, r4
	bl CAM_GetTbl
	mov r6, r0
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r5, r0
	ldr r0, _027EC77C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x50]
	cmp r0, #1
	bne _027EC760
	ldrh r0, [r6, #0x16]
	cmp r0, #1
	bne _027EC760
	mov r0, r4
	bl CAM_ClrTIMElementBitmap
_027EC760:
	ldrh r0, [r6, #0x16]
	sub r0, r0, #1
	strh r0, [r6, #0x16]
	mov r0, r5
	bl OS_EnableIrqMask
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EC77C: .word 0x0380FFF4
	arm_func_end CAM_DecFrameCount

	arm_func_start CAM_IncFrameCount
CAM_IncFrameCount: // 0x027EC780
	stmdb sp!, {r4, r5, r6, lr}
	ldrh r4, [r0, #2]
	mov r0, r4
	bl CAM_GetTbl
	mov r6, r0
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r5, r0
	ldr r0, _027EC80C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x50]
	cmp r0, #1
	bne _027EC7CC
	ldrh r0, [r6, #0x16]
	cmp r0, #0
	bne _027EC7CC
	mov r0, r4
	bl CAM_SetTIMElementBitmap
_027EC7CC:
	ldrh r0, [r6, #0x16]
	add r0, r0, #1
	strh r0, [r6, #0x16]
	mov r0, r5
	bl OS_EnableIrqMask
	ldr r0, _027EC80C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r1, [r0, #0x34]
	mov r0, #1
	mov r0, r0, lsl r4
	ands r0, r1, r0
	ldreqh r0, [r6, #0x1a]
	streqh r0, [r6, #0x18]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EC80C: .word 0x0380FFF4
	arm_func_end CAM_IncFrameCount

	arm_func_start CAM_AddBcFrame
CAM_AddBcFrame: // 0x027EC810
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	ldr r0, _027EC870 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r5, r0, #0x1ac
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r4, r0
	ldrh r0, [r5, #8]
	cmp r0, #0
	bne _027EC84C
	mov r0, #0
	bl CAM_SetTIMElementBitmap
_027EC84C:
	mov r0, r7
	mov r1, r5
	mov r2, r6
	bl MoveHeapBuf
	mov r0, r4
	bl OS_EnableIrqMask
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027EC870: .word 0x0380FFF4
	arm_func_end CAM_AddBcFrame

	arm_func_start CAM_SearchAdd
CAM_SearchAdd: // 0x027EC874
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r9, r0
	ldr r10, _027EC9B8 // =0x0380FFF4
	ldr r0, [r10, #0]
	add r8, r0, #0x31c
	ldrh r1, [r9, #0]
	ands r1, r1, #1
	movne r0, #0
	bne _027EC9B0
	add r1, r0, #0x500
	ldrh r1, [r1, #0x2c]
	cmp r1, #1
	bls _027EC928
	ldr r1, [r8, #0]
	add r7, r1, #0x1c
	mov r4, #0
	mov r5, r4
	mov r6, #1
	b _027EC910
_027EC8C0:
	ldrh r1, [r7, #0]
	cmp r1, #0
	beq _027EC900
	add r0, r7, #4
	mov r1, r9
	bl MatchMacAdrs
	cmp r0, #0
	movne r0, r6
	bne _027EC9B0
	add r5, r5, #1
	ldr r0, [r10, #0]
	add r1, r0, #0x500
	ldrh r1, [r1, #0x2c]
	cmp r5, r1
	blo _027EC908
	b _027EC91C
_027EC900:
	cmp r4, #0
	moveq r4, r6
_027EC908:
	add r6, r6, #1
	add r7, r7, #0x1c
_027EC910:
	ldrh r1, [r8, #6]
	cmp r6, r1
	blo _027EC8C0
_027EC91C:
	cmp r4, #0
	movne r6, r4
	b _027EC92C
_027EC928:
	mov r6, #1
_027EC92C:
	add r0, r0, #0x300
	ldrh r0, [r0, #0x22]
	cmp r6, r0
	blo _027EC9A0
	ldr r4, [r8, #0]
	mov r7, #0x10000
	mov r3, #1
	mov r6, #0
	ldrh r5, [r8, #6]
	mov r0, #0x1c
	b _027EC98C
_027EC958:
	mul r1, r3, r0
	add r2, r4, r1
	ldrh r1, [r4, r1]
	cmp r1, #0x30
	bhs _027EC988
	ldrh r1, [r2, #0x16]
	cmp r1, #0
	bne _027EC988
	ldrh r1, [r2, #0x18]
	cmp r7, r1
	movhi r7, r1
	movhi r6, r3
_027EC988:
	add r3, r3, #1
_027EC98C:
	cmp r3, r5
	blo _027EC958
	cmp r6, #0
	moveq r0, #0xff
	beq _027EC9B0
_027EC9A0:
	mov r0, r6
	mov r1, r9
	bl CAM_InitElement
	mov r0, r6
_027EC9B0:
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_027EC9B8: .word 0x0380FFF4
	arm_func_end CAM_SearchAdd

	arm_func_start CAM_Search
CAM_Search: // 0x027EC9BC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldrh r0, [r8, #0]
	ands r0, r0, #1
	movne r0, #0
	bne _027ECA58
	ldr r4, _027ECA60 // =0x0380FFF4
	ldr r0, [r4, #0]
	add r1, r0, #0x500
	ldrh r1, [r1, #0x2c]
	cmp r1, #1
	bls _027ECA54
	ldr r1, [r0, #0x31c]
	add r7, r1, #0x1c
	mov r5, #0
	mov r6, #1
	b _027ECA44
_027ECA00:
	ldrh r1, [r7, #0]
	cmp r1, #0
	beq _027ECA3C
	add r0, r7, #4
	mov r1, r8
	bl MatchMacAdrs
	cmp r0, #0
	movne r0, r6
	bne _027ECA58
	add r5, r5, #1
	ldr r0, [r4, #0]
	add r1, r0, #0x500
	ldrh r1, [r1, #0x2c]
	cmp r5, r1
	bhs _027ECA54
_027ECA3C:
	add r6, r6, #1
	add r7, r7, #0x1c
_027ECA44:
	add r1, r0, #0x300
	ldrh r1, [r1, #0x22]
	cmp r6, r1
	blo _027ECA00
_027ECA54:
	mov r0, #0xff
_027ECA58:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027ECA60: .word 0x0380FFF4
	arm_func_end CAM_Search

	arm_func_start InitializeCmdIf
InitializeCmdIf: // 0x027ECA64
	mov r1, #0
	ldr r0, _027ECA7C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x400
	strh r1, [r0, #0x28]
	bx lr
	.align 2, 0
_027ECA7C: .word 0x0380FFF4
	arm_func_end InitializeCmdIf

	arm_func_start SendMessageToWmTask
SendMessageToWmTask: // 0x027ECA80
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r6, _027ECAE4 // =0x0380FFF4
	ldr r0, [r6, #0]
	ldr r7, [r0, #0x1f4]
	mov r5, #0
	mvn r4, #0
	b _027ECAD0
_027ECAA0:
	ldr r0, [r0, #0x304]
	mov r1, r7
	mov r2, r5
	bl OS_SendMessage
	cmp r0, #0
	beq _027ECAD8
	ldr r0, [r6, #0]
	add r0, r0, #0x1f4
	mov r1, r7
	bl DeleteHeapBuf
	ldr r0, [r6, #0]
	ldr r7, [r0, #0x1f4]
_027ECAD0:
	cmp r7, r4
	bne _027ECAA0
_027ECAD8:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027ECAE4: .word 0x0380FFF4
	arm_func_end SendMessageToWmTask

	arm_func_start CMD_ReservedReqCmd
CMD_ReservedReqCmd: // 0x027ECAE8
	mov r0, #3
	bx lr
	arm_func_end CMD_ReservedReqCmd

	arm_func_start InitializeMLME
InitializeMLME: // 0x027ECAF0
	mov r0, #0
	ldr r1, _027ECB10 // =0x0380FFF4
	ldr r2, [r1, #0]
	ldr r1, _027ECB14 // =0x00000404
	add r1, r2, r1
	mov r2, #0x20
	ldr ip, _027ECB18 // =MIi_CpuClear16
	bx ip
	.align 2, 0
_027ECB10: .word 0x0380FFF4
_027ECB14: .word 0x00000404
_027ECB18: .word MIi_CpuClear16
	arm_func_end InitializeMLME

	arm_func_start MLME_IssueBeaconRecvIndication
MLME_IssueBeaconRecvIndication: // 0x027ECB1C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	ldr r0, _027ECC44 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r5, r1, #0x344
	add r0, r1, #0x188
	add r1, r1, #0x300
	ldrh r1, [r1, #0xe4]
	add r1, r1, #0x3e
	bl AllocateHeapBuf
	movs r4, r0
	bne _027ECB60
	mov r0, #1
	bl SetFatalErr
	mov r0, #0
	b _027ECC38
_027ECB60:
	mov r0, #0x8d
	strh r0, [r4, #0xc]
	ldrh r0, [r5, #0xa0]
	add r0, r0, #1
	mov r1, #2
	bl _s32_div_f
	add r0, r0, #0x16
	strh r0, [r4, #0xe]
	add r0, r4, #0x1f
	ldrh r1, [r6, #0x12]
	and r1, r1, #0xff
	bl WL_WriteByte
	add r0, r4, #0x1e
	ldrh r1, [r6, #0xe]
	and r1, r1, #0xff
	bl WL_WriteByte
	add r0, r4, #0x2e
	add r1, r6, #0x1e
	bl WSetMacAdrs1
	ldrh r0, [r5, #0xa0]
	strh r0, [r4, #0x16]
	ldrh r2, [r4, #0x16]
	cmp r2, #0
	beq _027ECC20
	ldrh r0, [r5, #0xa2]
	ands r0, r0, #1
	beq _027ECC10
	ldr r0, [r5, #0x9c]
	add r6, r0, #1
	add r5, r4, #0x3c
	mov r7, #0
	b _027ECC00
_027ECBE0:
	mov r0, r6
	bl WL_ReadByte
	mov r1, r0
	mov r0, r5
	bl WL_WriteByte
	add r6, r6, #1
	add r5, r5, #1
	add r7, r7, #1
_027ECC00:
	ldrh r0, [r4, #0x16]
	cmp r7, r0
	blo _027ECBE0
	b _027ECC20
_027ECC10:
	ldr r0, [r5, #0x9c]
	add r1, r4, #0x3c
	add r2, r2, #1
	bl MIi_CpuCopy16
_027ECC20:
	ldr r0, _027ECC44 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, r4
	bl SendMessageToWmDirect
	mov r0, #1
_027ECC38:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027ECC44: .word 0x0380FFF4
	arm_func_end MLME_IssueBeaconRecvIndication

	arm_func_start MLME_IssueBeaconSendIndication
MLME_IssueBeaconSendIndication: // 0x027ECC48
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027ECCAC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x10
	bl AllocateHeapBuf
	movs r1, r0
	bne _027ECC7C
	mov r0, #1
	bl SetFatalErr
	mov r0, #0
	b _027ECCA0
_027ECC7C:
	mov r0, #0x8c
	strh r0, [r1, #0xc]
	mov r0, #0
	strh r0, [r1, #0xe]
	ldr r0, _027ECCAC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	bl SendMessageToWmDirect
	mov r0, #1
_027ECCA0:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027ECCAC: .word 0x0380FFF4
	arm_func_end MLME_IssueBeaconSendIndication

	arm_func_start MLME_IssueBeaconLostIndication
MLME_IssueBeaconLostIndication: // 0x027ECCB0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _027ECD28 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x16
	bl AllocateHeapBuf
	movs r4, r0
	bne _027ECCE8
	mov r0, #1
	bl SetFatalErr
	mov r0, #0
	b _027ECD1C
_027ECCE8:
	mov r0, #0x8b
	strh r0, [r4, #0xc]
	mov r0, #3
	strh r0, [r4, #0xe]
	add r0, r4, #0x10
	mov r1, r5
	bl WSetMacAdrs1
	ldr r0, _027ECD28 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, r4
	bl SendMessageToWmDirect
	mov r0, #1
_027ECD1C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027ECD28: .word 0x0380FFF4
	arm_func_end MLME_IssueBeaconLostIndication

	arm_func_start MLME_IssueDisAssIndication
MLME_IssueDisAssIndication: // 0x027ECD2C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027ECDA4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x18
	bl AllocateHeapBuf
	movs r4, r0
	bne _027ECD64
	mov r0, #1
	bl SetFatalErr
	mov r0, #0
	b _027ECD9C
_027ECD64:
	mov r0, #0x88
	strh r0, [r4, #0xc]
	mov r0, #4
	strh r0, [r4, #0xe]
	add r0, r4, #0x10
	mov r1, r6
	bl WSetMacAdrs1
	strh r5, [r4, #0x16]
	ldr r0, _027ECDA4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, r4
	bl SendMessageToWmDirect
	mov r0, #1
_027ECD9C:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027ECDA4: .word 0x0380FFF4
	arm_func_end MLME_IssueDisAssIndication

	arm_func_start MLME_IssueReAssIndication
MLME_IssueReAssIndication: // 0x027ECDA8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	ldr r0, _027ECE94 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x3a
	bl AllocateHeapBuf
	movs r4, r0
	bne _027ECDE8
	mov r0, #1
	bl SetFatalErr
	mov r0, #0
	b _027ECE88
_027ECDE8:
	mov r0, #0x87
	strh r0, [r4, #0xc]
	mov r0, #0x15
	strh r0, [r4, #0xe]
	add r0, r4, #0x10
	mov r1, r7
	bl WSetMacAdrs1
	strh r6, [r4, #0x16]
	add r0, r5, #1
	bl WL_ReadByte
	strh r0, [r4, #0x18]
	mov r7, #0
	add r6, r5, #2
	add r5, r4, #0x1a
	b _027ECE44
_027ECE24:
	cmp r7, #0x20
	bhs _027ECE68
	add r0, r6, r7
	bl WL_ReadByte
	mov r1, r0
	add r0, r5, r7
	bl WL_WriteByte
	add r7, r7, #1
_027ECE44:
	ldrh r0, [r4, #0x18]
	cmp r7, r0
	blo _027ECE24
	b _027ECE68
_027ECE54:
	add r0, r4, #0x1a
	add r0, r0, r7
	mov r1, #0
	bl WL_WriteByte
	add r7, r7, #1
_027ECE68:
	cmp r7, #0x20
	blo _027ECE54
	ldr r0, _027ECE94 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, r4
	bl SendMessageToWmDirect
	mov r0, #1
_027ECE88:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027ECE94: .word 0x0380FFF4
	arm_func_end MLME_IssueReAssIndication

	arm_func_start MLME_IssueAssIndication
MLME_IssueAssIndication: // 0x027ECE98
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	ldr r0, _027ECF8C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x3a
	bl AllocateHeapBuf
	movs r4, r0
	bne _027ECED8
	mov r0, #1
	bl SetFatalErr
	mov r0, #0
	b _027ECF80
_027ECED8:
	mov r0, #0x86
	strh r0, [r4, #0xc]
	mov r0, #0x15
	strh r0, [r4, #0xe]
	add r0, r4, #0x10
	mov r1, r7
	bl WSetMacAdrs1
	ldr r0, _027ECF90 // =0x00000FFF
	and r0, r6, r0
	strh r0, [r4, #0x16]
	add r0, r5, #1
	bl WL_ReadByte
	strh r0, [r4, #0x18]
	mov r7, #0
	add r6, r5, #2
	add r5, r4, #0x1a
	b _027ECF3C
_027ECF1C:
	cmp r7, #0x20
	bhs _027ECF60
	add r0, r6, r7
	bl WL_ReadByte
	mov r1, r0
	add r0, r5, r7
	bl WL_WriteByte
	add r7, r7, #1
_027ECF3C:
	ldrh r0, [r4, #0x18]
	cmp r7, r0
	blo _027ECF1C
	b _027ECF60
_027ECF4C:
	add r0, r4, #0x1a
	add r0, r0, r7
	mov r1, #0
	bl WL_WriteByte
	add r7, r7, #1
_027ECF60:
	cmp r7, #0x20
	blo _027ECF4C
	ldr r0, _027ECF8C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, r4
	bl SendMessageToWmDirect
	mov r0, #1
_027ECF80:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027ECF8C: .word 0x0380FFF4
_027ECF90: .word 0x00000FFF
	arm_func_end MLME_IssueAssIndication

	arm_func_start MLME_IssueDeAuthIndication
MLME_IssueDeAuthIndication: // 0x027ECF94
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027ED00C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x18
	bl AllocateHeapBuf
	movs r4, r0
	bne _027ECFCC
	mov r0, #1
	bl SetFatalErr
	mov r0, #0
	b _027ED004
_027ECFCC:
	mov r0, #0x85
	strh r0, [r4, #0xc]
	mov r0, #4
	strh r0, [r4, #0xe]
	add r0, r4, #0x10
	mov r1, r6
	bl WSetMacAdrs1
	strh r5, [r4, #0x16]
	ldr r0, _027ED00C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, r4
	bl SendMessageToWmDirect
	mov r0, #1
_027ED004:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027ED00C: .word 0x0380FFF4
	arm_func_end MLME_IssueDeAuthIndication

	arm_func_start MLME_IssueAuthIndication
MLME_IssueAuthIndication: // 0x027ED010
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027ED088 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x18
	bl AllocateHeapBuf
	movs r4, r0
	bne _027ED048
	mov r0, #1
	bl SetFatalErr
	mov r0, #0
	b _027ED080
_027ED048:
	mov r0, #0x84
	strh r0, [r4, #0xc]
	mov r0, #4
	strh r0, [r4, #0xe]
	add r0, r4, #0x10
	mov r1, r6
	bl WSetMacAdrs1
	strh r5, [r4, #0x16]
	ldr r0, _027ED088 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, r4
	bl SendMessageToWmDirect
	mov r0, #1
_027ED080:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027ED088: .word 0x0380FFF4
	arm_func_end MLME_IssueAuthIndication

	arm_func_start IssueMlmeConfirm
IssueMlmeConfirm: // 0x027ED08C
	stmdb sp!, {r4, lr}
	ldr r0, _027ED0DC // =0x0380FFF4
	ldr r2, [r0, #0]
	add r4, r2, #0x17c
	ldr r0, _027ED0E0 // =0x00000424
	add r1, r2, r0
	ldrh r0, [r1, #4]
	bic r0, r0, #1
	strh r0, [r1, #4]
	add r0, r4, #0x84
	ldr r1, [r2, #0x424]
	bl SendMessageToWmDirect
	ldrh r0, [r4, #0x8c]
	cmp r0, #0
	beq _027ED0D4
	mov r0, #2
	mov r1, #0xb
	bl AddTask
_027ED0D4:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027ED0DC: .word 0x0380FFF4
_027ED0E0: .word 0x00000424
	arm_func_end IssueMlmeConfirm

	arm_func_start MLME_BeaconLostTask
MLME_BeaconLostTask: // 0x027ED0E4
	ldr r0, _027ED0FC // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027ED100 // =0x000003C6
	add r0, r1, r0
	ldr ip, _027ED104 // =MLME_IssueBeaconLostIndication
	bx ip
	.align 2, 0
_027ED0FC: .word 0x0380FFF4
_027ED100: .word 0x000003C6
_027ED104: .word MLME_IssueBeaconLostIndication
	arm_func_end MLME_BeaconLostTask

	arm_func_start MLME_MeasChanTimeOut
MLME_MeasChanTimeOut: // 0x027ED108
	mov r1, #0x83
	ldr r0, _027ED12C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x400
	strh r1, [r0, #4]
	mov r0, #2
	mov r1, #5
	ldr ip, _027ED130 // =AddTask
	bx ip
	.align 2, 0
_027ED12C: .word 0x0380FFF4
_027ED130: .word AddTask
	arm_func_end MLME_MeasChanTimeOut

	arm_func_start MLME_MeasChannelTask
MLME_MeasChannelTask: // 0x027ED134
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _027ED3A8 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r5, r1, #0x344
	ldr r0, _027ED3AC // =0x00000404
	add r4, r1, r0
	add r0, r1, #0x400
	ldrh r0, [r0, #4]
	sub r0, r0, #0x80
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _027ED384
_027ED168: // jump table
	b _027ED17C // case 0
	b _027ED1BC // case 1
	b _027ED27C // case 2
	b _027ED2A4 // case 3
	b _027ED314 // case 4
_027ED17C:
	mov r0, #0
	strh r0, [r4, #0x14]
	mov r0, #0x13
	bl BBP_Read
	strh r0, [r4, #0xe]
	mov r0, #0x35
	bl BBP_Read
	strh r0, [r4, #0x10]
	ldr r1, [r4, #0x18]
	ldrh r0, [r1, #0x12]
	ldrh r1, [r1, #0x14]
	bl WSetCCA_ED
	mov r0, #4
	strh r0, [r5, #0xc]
	mov r0, #0
	strh r0, [r4, #0x16]
_027ED1BC:
	mov r0, #0
	str r0, [r4, #4]
	str r0, [r4, #8]
	ldr r0, [r4, #0x18]
	add r1, r0, #0x18
	ldrh r0, [r4, #0x14]
	add r0, r1, r0
	bl WL_ReadByte
	movs r5, r0
	beq _027ED1F0
	ldrh r0, [r4, #0x14]
	cmp r0, #0x10
	blo _027ED1FC
_027ED1F0:
	mov r0, #0x84
	strh r0, [r4]
	b _027ED384
_027ED1FC:
	mov r0, #0
	bl FLASH_VerifyCheckSum
	cmp r0, #0
	movne r0, #0xe
	strneh r0, [r4, #0x16]
	movne r0, #0x84
	strneh r0, [r4]
	bne _027ED384
	ldrh r0, [r4, #0]
	cmp r0, #0x80
	bne _027ED254
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl WSetChannel
	bl WStart
	ldr r0, _027ED3B0 // =0x04808040
	ldrh r0, [r0, #0]
	strh r0, [r4, #0xc]
	mov r0, #0x8000
	bl WSetForcePowerState
	b _027ED264
_027ED254:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl WSetChannel
_027ED264:
	mov r0, #0x82
	strh r0, [r4]
	ldr r0, [r4, #0x18]
	ldrh r0, [r0, #0x16]
	ldr r1, _027ED3B4 // =MLME_MeasChanTimeOut
	bl SetupTimeOut
_027ED27C:
	ldr r0, [r4, #4]
	add r0, r0, #1
	str r0, [r4, #4]
	ldr r0, _027ED3B8 // =0x0480819C
	ldrh r0, [r0, #0]
	ands r0, r0, #1
	ldrne r0, [r4, #8]
	addne r0, r0, #0x64
	strne r0, [r4, #8]
	b _027ED384
_027ED2A4:
	ldr r0, [r4, #0x18]
	add r1, r0, #0x18
	ldrh r0, [r4, #0x14]
	add r0, r1, r0
	bl WL_ReadByte
	mov r5, r0
	mov r2, #0
	ldr r1, [r4, #4]
	cmp r1, #0
	beq _027ED2E8
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _027ED2E8
	bl _u32_div_f
	add r2, r0, #1
	cmp r2, #0x64
	movhi r2, #0x64
_027ED2E8:
	orr r2, r5, r2, lsl #8
	ldr r1, [r4, #0x1c]
	ldrh r0, [r4, #0x14]
	add r0, r1, r0, lsl #1
	strh r2, [r0, #8]
	ldrh r0, [r4, #0x14]
	add r0, r0, #1
	strh r0, [r4, #0x14]
	mov r0, #0x81
	strh r0, [r4]
	b _027ED384
_027ED314:
	bl WStop
	ldr r0, _027ED3A8 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x2e]
	strh r0, [r5, #0xc]
	mov r0, #0x13
	ldrh r1, [r4, #0xe]
	bl BBP_Write
	mov r0, #0x35
	ldrh r1, [r4, #0x10]
	bl BBP_Write
	ldrh r0, [r4, #0xc]
	bl WSetForcePowerState
	ldrh r1, [r4, #0x16]
	ldr r0, [r4, #0x1c]
	strh r1, [r0, #4]
	mov r1, #0
	strh r1, [r4]
	ldrh r2, [r4, #0x14]
	b _027ED378
_027ED368:
	ldr r0, [r4, #0x1c]
	add r0, r0, r2, lsl #1
	strh r1, [r0, #8]
	add r2, r2, #1
_027ED378:
	cmp r2, #0x10
	blo _027ED368
	bl IssueMlmeConfirm
_027ED384:
	ldrh r0, [r4, #0]
	cmp r0, #0
	beq _027ED39C
	mov r0, #2
	mov r1, #5
	bl AddTask
_027ED39C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027ED3A8: .word 0x0380FFF4
_027ED3AC: .word 0x00000404
_027ED3B0: .word 0x04808040
_027ED3B4: .word MLME_MeasChanTimeOut
_027ED3B8: .word 0x0480819C
	arm_func_end MLME_MeasChannelTask

	arm_func_start MLME_ReAssTimeOut
MLME_ReAssTimeOut: // 0x027ED3BC
	ldr r0, _027ED3F4 // =0x0380FFF4
	ldr r2, [r0, #0]
	ldr r0, _027ED3F8 // =0x00000404
	add r0, r2, r0
	mov r1, #7
	ldr r0, [r0, #0x1c]
	strh r1, [r0, #4]
	mov r1, #0x63
	add r0, r2, #0x400
	strh r1, [r0, #4]
	mov r0, #2
	mov r1, #4
	ldr ip, _027ED3FC // =AddTask
	bx ip
	.align 2, 0
_027ED3F4: .word 0x0380FFF4
_027ED3F8: .word 0x00000404
_027ED3FC: .word AddTask
	arm_func_end MLME_ReAssTimeOut

	arm_func_start MLME_ReAssTask
MLME_ReAssTask: // 0x027ED400
	stmdb sp!, {r4, lr}
	ldr r0, _027ED4B0 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027ED4B4 // =0x00000404
	add r4, r1, r0
	add r0, r1, #0x400
	ldrh r0, [r0, #4]
	cmp r0, #0x60
	beq _027ED430
	cmp r0, #0x63
	beq _027ED488
	b _027ED4A8
_027ED430:
	ldr r0, [r4, #0x18]
	add r0, r0, #0x10
	bl MakeReAssReqFrame
	cmp r0, #0
	bne _027ED468
	mov r1, #8
	ldr r0, [r4, #0x1c]
	strh r1, [r0, #4]
	mov r0, #0x63
	strh r0, [r4]
	mov r0, #2
	mov r1, #4
	bl AddTask
	b _027ED4A8
_027ED468:
	mov r1, #0x61
	strh r1, [r4]
	bl TxManCtrlFrame
	ldr r0, [r4, #0x18]
	ldrh r0, [r0, #0x18]
	ldr r1, _027ED4B8 // =MLME_ReAssTimeOut
	bl SetupTimeOut
	b _027ED4A8
_027ED488:
	mov r0, #1
	bl ClearQueuedPri
	mov r0, #1
	mov r1, #0
	bl MessageDeleteTx
	mov r0, #0
	strh r0, [r4]
	bl IssueMlmeConfirm
_027ED4A8:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027ED4B0: .word 0x0380FFF4
_027ED4B4: .word 0x00000404
_027ED4B8: .word MLME_ReAssTimeOut
	arm_func_end MLME_ReAssTask

	arm_func_start MLME_AssTimeOut
MLME_AssTimeOut: // 0x027ED4BC
	ldr r0, _027ED4F4 // =0x0380FFF4
	ldr r2, [r0, #0]
	ldr r0, _027ED4F8 // =0x00000404
	add r0, r2, r0
	mov r1, #7
	ldr r0, [r0, #0x1c]
	strh r1, [r0, #4]
	mov r1, #0x53
	add r0, r2, #0x400
	strh r1, [r0, #4]
	mov r0, #2
	mov r1, #3
	ldr ip, _027ED4FC // =AddTask
	bx ip
	.align 2, 0
_027ED4F4: .word 0x0380FFF4
_027ED4F8: .word 0x00000404
_027ED4FC: .word AddTask
	arm_func_end MLME_AssTimeOut

	arm_func_start MLME_AssTask
MLME_AssTask: // 0x027ED500
	stmdb sp!, {r4, lr}
	ldr r0, _027ED5B8 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027ED5BC // =0x00000404
	add r4, r1, r0
	add r0, r1, #0x400
	ldrh r0, [r0, #4]
	cmp r0, #0x50
	beq _027ED530
	cmp r0, #0x53
	beq _027ED588
	b _027ED5B0
_027ED530:
	ldr r0, [r4, #0x18]
	add r0, r0, #0x10
	bl MakeAssReqFrame
	cmp r0, #0
	bne _027ED568
	mov r1, #8
	ldr r0, [r4, #0x1c]
	strh r1, [r0, #4]
	mov r0, #0x53
	strh r0, [r4]
	mov r0, #2
	mov r1, #3
	bl AddTask
	b _027ED5B0
_027ED568:
	mov r1, #0x51
	strh r1, [r4]
	bl TxManCtrlFrame
	ldr r0, [r4, #0x18]
	ldrh r0, [r0, #0x18]
	ldr r1, _027ED5C0 // =MLME_AssTimeOut
	bl SetupTimeOut
	b _027ED5B0
_027ED588:
	mov r0, #1
	bl ResetTxqPri
	mov r0, #1
	bl ClearQueuedPri
	mov r0, #1
	mov r1, #0
	bl MessageDeleteTx
	mov r0, #0
	strh r0, [r4]
	bl IssueMlmeConfirm
_027ED5B0:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027ED5B8: .word 0x0380FFF4
_027ED5BC: .word 0x00000404
_027ED5C0: .word MLME_AssTimeOut
	arm_func_end MLME_AssTask

	arm_func_start MLME_AuthTimeOut
MLME_AuthTimeOut: // 0x027ED5C4
	ldr r0, _027ED5FC // =0x0380FFF4
	ldr r2, [r0, #0]
	ldr r0, _027ED600 // =0x00000404
	add r0, r2, r0
	mov r1, #7
	ldr r0, [r0, #0x1c]
	strh r1, [r0, #4]
	mov r1, #0x35
	add r0, r2, #0x400
	strh r1, [r0, #4]
	mov r0, #2
	mov r1, r0
	ldr ip, _027ED604 // =AddTask
	bx ip
	.align 2, 0
_027ED5FC: .word 0x0380FFF4
_027ED600: .word 0x00000404
_027ED604: .word AddTask
	arm_func_end MLME_AuthTimeOut

	arm_func_start MLME_AuthTask
MLME_AuthTask: // 0x027ED608
	stmdb sp!, {r4, lr}
	ldr r0, _027ED6E4 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027ED6E8 // =0x00000404
	add r4, r1, r0
	add r0, r1, #0x400
	ldrh r0, [r0, #4]
	cmp r0, #0x30
	beq _027ED638
	cmp r0, #0x35
	beq _027ED6B4
	b _027ED6DC
_027ED638:
	ldr r0, [r4, #0x18]
	add r0, r0, #0x10
	mov r1, #0
	mov r2, r1
	bl MakeAuthFrame
	cmp r0, #0
	bne _027ED678
	mov r1, #8
	ldr r0, [r4, #0x1c]
	strh r1, [r0, #4]
	mov r0, #0x35
	strh r0, [r4]
	mov r0, #2
	mov r1, r0
	bl AddTask
	b _027ED6DC
_027ED678:
	ldr r1, [r4, #0x18]
	ldrh r1, [r1, #0x16]
	strh r1, [r0, #0x2c]
	mov r1, #1
	strh r1, [r0, #0x2e]
	mov r1, #0
	strh r1, [r0, #0x30]
	mov r1, #0x31
	strh r1, [r4]
	bl TxManCtrlFrame
	ldr r0, [r4, #0x18]
	ldrh r0, [r0, #0x18]
	ldr r1, _027ED6EC // =MLME_AuthTimeOut
	bl SetupTimeOut
	b _027ED6DC
_027ED6B4:
	mov r0, #1
	bl ResetTxqPri
	mov r0, #1
	bl ClearQueuedPri
	mov r0, #1
	mov r1, #0
	bl MessageDeleteTx
	mov r0, #0
	strh r0, [r4]
	bl IssueMlmeConfirm
_027ED6DC:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027ED6E4: .word 0x0380FFF4
_027ED6E8: .word 0x00000404
_027ED6EC: .word MLME_AuthTimeOut
	arm_func_end MLME_AuthTask

	arm_func_start MLME_JoinTimeOut
MLME_JoinTimeOut: // 0x027ED6F0
	ldr r0, _027ED724 // =0x0380FFF4
	ldr r2, [r0, #0]
	ldr r0, _027ED728 // =0x00000404
	add r1, r2, r0
	mov r0, #7
	strh r0, [r1, #4]
	mov r1, #0x25
	add r0, r2, #0x400
	strh r1, [r0, #4]
	mov r0, #2
	mov r1, #1
	ldr ip, _027ED72C // =AddTask
	bx ip
	.align 2, 0
_027ED724: .word 0x0380FFF4
_027ED728: .word 0x00000404
_027ED72C: .word AddTask
	arm_func_end MLME_JoinTimeOut

	arm_func_start MLME_JoinTask
MLME_JoinTask: // 0x027ED730
	stmdb sp!, {r4, lr}
	ldr r0, _027ED7C8 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027ED7CC // =0x00000404
	add r4, r1, r0
	add r0, r1, #0x400
	ldrh r0, [r0, #4]
	cmp r0, #0x20
	beq _027ED760
	cmp r0, #0x25
	beq _027ED78C
	b _027ED7C0
_027ED760:
	bl WStart
	mov r0, #0
	strh r0, [r4, #4]
	strh r0, [r4, #6]
	mov r0, #0x21
	strh r0, [r4]
	ldr r0, [r4, #0x18]
	ldrh r0, [r0, #0x10]
	ldr r1, _027ED7D0 // =MLME_JoinTimeOut
	bl SetupTimeOut
	b _027ED7C0
_027ED78C:
	ldrh r1, [r4, #4]
	ldr r0, [r4, #0x1c]
	strh r1, [r0, #4]
	ldrh r1, [r4, #6]
	ldr r0, [r4, #0x1c]
	strh r1, [r0, #6]
	ldrh r0, [r4, #4]
	cmp r0, #0
	beq _027ED7B4
	bl WStop
_027ED7B4:
	mov r0, #0
	strh r0, [r4]
	bl IssueMlmeConfirm
_027ED7C0:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027ED7C8: .word 0x0380FFF4
_027ED7CC: .word 0x00000404
_027ED7D0: .word MLME_JoinTimeOut
	arm_func_end MLME_JoinTask

	arm_func_start MLME_ScanTimeOut
MLME_ScanTimeOut: // 0x027ED7D4
	ldr r0, _027ED830 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027ED834 // =0x00000404
	add r2, r1, r0
	ldrh r1, [r2, #0xa]
	ldrh r0, [r2, #0xc]
	add r0, r1, r0
	strh r0, [r2, #0xa]
	ldrh r1, [r2, #0xa]
	ldr r0, [r2, #0x18]
	ldrh r0, [r0, #0x4a]
	cmp r1, r0
	blo _027ED820
	ldrh r0, [r2, #6]
	cmp r0, #0x10
	movlo r0, #0x11
	strloh r0, [r2]
	movhs r0, #0x15
	strhsh r0, [r2]
_027ED820:
	mov r0, #2
	mov r1, #0
	ldr ip, _027ED838 // =AddTask
	bx ip
	.align 2, 0
_027ED830: .word 0x0380FFF4
_027ED834: .word 0x00000404
_027ED838: .word AddTask
	arm_func_end MLME_ScanTimeOut

	arm_func_start MLME_ScanTask
MLME_ScanTask: // 0x027ED83C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, _027EDA2C // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027EDA30 // =0x00000404
	add r6, r1, r0
	add r5, r1, #0x344
	mov r4, #0
	add r0, r1, #0x400
	ldrh r0, [r0, #4]
	sub r0, r0, #0x10
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _027EDA10
_027ED870: // jump table
	b _027ED888 // case 0
	b _027ED900 // case 1
	b _027ED998 // case 2
	b _027ED998 // case 3
	b _027EDA10 // case 4
	b _027ED9F0 // case 5
_027ED888:
	mov r0, #0x20
	bl WSetStaState
	mov r0, #2
	strh r0, [r5, #0xc]
	mov r1, r4
	ldr r0, [r6, #0x1c]
	strh r1, [r0, #8]
	ldr r0, [r6, #0x1c]
	strh r1, [r0, #6]
	strh r1, [r6, #6]
	strh r1, [r6, #8]
	ldr r1, [r6, #0x18]
	ldrh r0, [r1, #0x38]
	cmp r0, #0
	bne _027ED8EC
	ldrh r0, [r1, #0x4a]
	add r0, r0, #3
	mov r1, #4
	bl _s32_div_f
	strh r0, [r6, #0xc]
	ldrh r0, [r6, #0xc]
	cmp r0, #0xa
	movlo r0, #0xa
	strloh r0, [r6, #0xc]
	b _027ED8F4
_027ED8EC:
	ldrh r0, [r1, #0x4a]
	strh r0, [r6, #0xc]
_027ED8F4:
	mov r1, #0
	ldr r0, [r6, #0x1c]
	strh r1, [r0, #4]
_027ED900:
	ldr r0, [r6, #0x18]
	add r1, r0, #0x3a
	ldrh r0, [r6, #6]
	add r0, r1, r0
	bl WL_ReadByte
	movs r5, r0
	moveq r0, #0x15
	streqh r0, [r6]
	moveq r4, #1
	beq _027EDA10
	ldrh r0, [r6, #6]
	add r0, r0, #1
	strh r0, [r6, #6]
	mov r0, #0
	strh r0, [r6, #0xa]
	bl FLASH_VerifyCheckSum
	cmp r0, #0
	beq _027ED964
	mov r1, #0xe
	ldr r0, [r6, #0x1c]
	strh r1, [r0, #4]
	mov r0, #0x15
	strh r0, [r6]
	mov r4, #1
	b _027EDA10
_027ED964:
	ldrh r0, [r6, #0]
	cmp r0, #0x10
	bne _027ED984
	mov r0, r5
	mov r1, #0
	bl WSetChannel
	bl WStart
	b _027ED990
_027ED984:
	mov r0, r5
	mov r1, #0
	bl WSetChannel
_027ED990:
	mov r0, #0x12
	strh r0, [r6]
_027ED998:
	mov r0, #0x13
	strh r0, [r6]
	ldr r1, [r6, #0x18]
	ldrh r0, [r1, #0x38]
	cmp r0, #0
	bne _027ED9E0
	add r0, r1, #0x10
	bl MakeProbeReqFrame
	cmp r0, #0
	bne _027ED9DC
	mov r1, #8
	ldr r0, [r6, #0x1c]
	strh r1, [r0, #4]
	mov r0, #0x15
	strh r0, [r6]
	mov r4, #1
	b _027EDA10
_027ED9DC:
	bl TxManCtrlFrame
_027ED9E0:
	ldrh r0, [r6, #0xc]
	ldr r1, _027EDA34 // =MLME_ScanTimeOut
	bl SetupTimeOut
	b _027EDA10
_027ED9F0:
	strh r4, [r6]
	bl WStop
	ldr r0, _027EDA2C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x2e]
	strh r0, [r5, #0xc]
	bl IssueMlmeConfirm
_027EDA10:
	cmp r4, #0
	beq _027EDA24
	mov r0, #2
	mov r1, #0
	bl AddTask
_027EDA24:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EDA2C: .word 0x0380FFF4
_027EDA30: .word 0x00000404
_027EDA34: .word MLME_ScanTimeOut
	arm_func_end MLME_ScanTask

	arm_func_start MLME_MeasChanReqCmd
MLME_MeasChanReqCmd: // 0x027EDA38
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	mov r5, r1
	ldr r2, _027EDB18 // =0x0380FFF4
	ldr r1, [r2, #0]
	ldr r0, _027EDB1C // =0x00000404
	add r4, r1, r0
	mov r0, #0x12
	strh r0, [r5, #2]
	ldr r0, [r2, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x4c]
	cmp r0, #0x20
	movne r0, #1
	bne _027EDB10
	ldrh r0, [r6, #0x12]
	cmp r0, #3
	movhi r0, #5
	bhi _027EDB10
	ldrh r0, [r6, #0x14]
	cmp r0, #0x3f
	movhi r0, #5
	bhi _027EDB10
	ldrh r0, [r6, #0x16]
	cmp r0, #0
	moveq r0, #5
	beq _027EDB10
	cmp r0, #0x3e8
	movhi r0, #5
	bhi _027EDB10
	mov r8, #0
	add r7, r6, #0x18
	b _027EDAE0
_027EDABC:
	add r0, r7, r8
	bl WL_ReadByte
	cmp r0, #0
	beq _027EDAE8
	bl CheckEnableChannel
	cmp r0, #0
	moveq r0, #5
	beq _027EDB10
	add r8, r8, #1
_027EDAE0:
	cmp r8, #0x10
	blo _027EDABC
_027EDAE8:
	cmp r8, #0
	moveq r0, #5
	beq _027EDB10
	str r6, [r4, #0x18]
	str r5, [r4, #0x1c]
	mov r0, #0x80
	strh r0, [r4]
	strh r0, [r5, #4]
	bl MLME_MeasChannelTask
	mov r0, #0x80
_027EDB10:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027EDB18: .word 0x0380FFF4
_027EDB1C: .word 0x00000404
	arm_func_end MLME_MeasChanReqCmd

	arm_func_start MLME_StartReqCmd
MLME_StartReqCmd: // 0x027EDB20
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _027E.byte8 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r5, r0, #0x344
	add r4, r0, #0x31c
	mov r0, #1
	strh r0, [r1, #2]
	ldrh r0, [r4, #0x12]
	cmp r0, #1
	beq _027EDB58
	cmp r0, #0
	movne r0, #0xb
	bne _027E.byte0
_027EDB58:
	ldrh r0, [r5, #8]
	cmp r0, #0x20
	movne r0, #1
	bne _027E.byte0
	ldrh r0, [r6, #0x10]
	cmp r0, #0x20
	movhi r0, #5
	bhi _027E.byte0
	cmp r0, #0
	moveq r0, #5
	beq _027E.byte0
	ldrh r0, [r6, #0x32]
	cmp r0, #0xa
	movlo r0, #5
	blo _027E.byte0
	cmp r0, #0x3e8
	movhi r0, #5
	bhi _027E.byte0
	ldrh r0, [r6, #0x34]
	cmp r0, #0
	moveq r0, #5
	beq _027E.byte0
	cmp r0, #0xff
	movhi r0, #5
	bhi _027E.byte0
	ldrh r0, [r6, #0x36]
	ldr r1, _027E.byteC // =0x0000FFF0
	ands r1, r0, r1
	movne r0, #5
	bne _027E.byte0
	bl CheckEnableChannel
	cmp r0, #0
	moveq r0, #5
	beq _027E.byte0
	ldrh r1, [r6, #0x38]
	cmp r1, #0
	moveq r0, #5
	beq _027E.byte0
	mov r0, #0x1000
	rsb r0, r0, #0
	ands r1, r1, r0
	movne r0, #5
	bne _027E.byte0
	ldrh r1, [r6, #0x3a]
	cmp r1, #0
	moveq r0, #5
	beq _027E.byte0
	ands r0, r1, r0
	movne r0, #5
	bne _027E.byte0
	ldrh r0, [r6, #0x3c]
	cmp r0, #0x80
	movhi r0, #5
	bhi _027E.byte0
	mov r0, #0
	bl FLASH_VerifyCheckSum
	cmp r0, #0
	movne r0, #0xe
	bne _027E.byte0
	ldrh r0, [r4, #0x12]
	cmp r0, #0
	bne _027EDC5C
	ldr r0, _027EDCC0 // =BC_ADRS
	bl WSetBssid
	b _027EDC64
_027EDC5C:
	add r0, r4, #8
	bl WSetBssid
_027EDC64:
	ldrh r0, [r6, #0x10]
	add r1, r6, #0x12
	bl WSetSsid
	ldrh r0, [r6, #0x32]
	bl WSetBeaconPeriod
	ldrh r0, [r6, #0x34]
	bl WSetDTIMPeriod
	ldrh r0, [r6, #0x36]
	mov r1, #0
	bl WSetChannel
	add r0, r6, #0x38
	bl WSetRateSet
	ldrh r0, [r6, #0x3c]
	add r1, r6, #0x3e
	bl WInitGameInfo
	mov r0, #0
	strh r0, [r5, #0xa4]
	bl WStart
	mov r0, #0
_027E.byte0:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027E.byte8: .word 0x0380FFF4
_027E.byteC: .word 0x0000FFF0
_027EDCC0: .word BC_ADRS
	arm_func_end MLME_StartReqCmd

	arm_func_start MLME_DisAssReqCmd
MLME_DisAssReqCmd: // 0x027EDCC4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	ldr r2, _027EDDD4 // =0x0380FFF4
	ldr r1, [r2, #0]
	ldr r0, _027EDDD8 // =0x00000404
	add r5, r1, r0
	mov r0, #1
	strh r0, [r6, #2]
	ldr r1, [r2, #0]
	add r0, r1, #0x300
	ldrh r0, [r0, #0x2e]
	cmp r0, #0
	moveq r0, #0xb
	beq _027EDDC8
	cmp r0, #1
	beq _027EDD1C
	ldrh r0, [r7, #0x10]
	ands r0, r0, #1
	movne r0, #5
	bne _027EDDC8
_027EDD1C:
	add r0, r1, #0x300
	ldrh r0, [r0, #0x4c]
	cmp r0, #0x40
	movne r0, #1
	bne _027EDDC8
	add r0, r7, #0x10
	ldrh r1, [r7, #0x16]
	bl MakeDisAssFrame
	movs r4, r0
	moveq r0, #8
	beq _027EDDC8
	str r7, [r5, #0x18]
	str r6, [r5, #0x1c]
	str r4, [r5, #4]
	mov r0, #0x71
	strh r0, [r5]
	ldrh r0, [r7, #0x10]
	ands r0, r0, #1
	beq _027EDDB4
	ldr r1, _027EDDD4 // =0x0380FFF4
	ldr r0, [r1, #0]
	ldr r0, [r0, #0x3ec]
	strh r0, [r4, #4]
	ldr r0, [r1, #0]
	add r0, r0, #0x188
	sub r1, r4, #0x10
	bl CAM_AddBcFrame
	ldr r0, _027EDDD4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r1, [r0, #0x2e]
	ldrh r0, [r0, #0x32]
	mvn r0, r0
	ands r0, r1, r0
	bne _027EDDC4
	mov r0, #2
	bl TxqPri
	b _027EDDC4
_027EDDB4:
	add r0, r7, #0x10
	bl DeleteTxFrameByAdrs
	mov r0, r4
	bl TxManCtrlFrame
_027EDDC4:
	mov r0, #0x80
_027EDDC8:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027EDDD4: .word 0x0380FFF4
_027EDDD8: .word 0x00000404
	arm_func_end MLME_DisAssReqCmd

	arm_func_start MLME_ReAssReqCmd
MLME_ReAssReqCmd: // 0x027EDDDC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _027EDEA4 // =0x0380FFF4
	ldr lr, [r2]
	add r3, lr, #0x344
	ldr r2, _027EDEA8 // =0x00000404
	add r2, lr, r2
	mov ip, #3
	strh ip, [r1, #2]
	add ip, lr, #0x300
	ldrh ip, [ip, #0x2e]
	cmp ip, #3
	beq _027EDE1C
	cmp ip, #2
	movne r0, #0xb
	bne _027EDE98
_027EDE1C:
	ldrh ip, [r3, #8]
	cmp ip, #0x30
	movlo r0, #1
	blo _027EDE98
	ldrh ip, [r0, #0x10]
	ands ip, ip, #1
	movne r0, #5
	bne _027EDE98
	ldrh lr, [r0, #0x16]
	cmp lr, #1
	movlo r0, #5
	blo _027EDE98
	cmp lr, #0xff
	movhi r0, #5
	bhi _027EDE98
	ldrh ip, [r0, #0x18]
	cmp ip, #0x7d0
	movhi r0, #5
	bhi _027EDE98
	cmp ip, #0xa
	movlo r0, #5
	blo _027EDE98
	strh lr, [r3, #0x70]
	ldrh ip, [r0, #0x16]
	strh ip, [r3, #0x72]
	str r0, [r2, #0x18]
	str r1, [r2, #0x1c]
	mov r0, #0x60
	strh r0, [r2]
	bl MLME_ReAssTask
	mov r0, #0x80
_027EDE98:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EDEA4: .word 0x0380FFF4
_027EDEA8: .word 0x00000404
	arm_func_end MLME_ReAssReqCmd

	arm_func_start MLME_AssReqCmd
MLME_AssReqCmd: // 0x027EDEAC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	ldr r0, _027EDF8C // =0x0380FFF4
	ldr r1, [r0, #0]
	add r5, r1, #0x344
	ldr r0, _027EDF90 // =0x00000404
	add r4, r1, r0
	mov r0, #3
	strh r0, [r6, #2]
	add r0, r1, #0x300
	ldrh r0, [r0, #0x2e]
	cmp r0, #3
	beq _027EDEF4
	cmp r0, #2
	movne r0, #0xb
	bne _027EDF80
_027EDEF4:
	ldrh r0, [r5, #8]
	cmp r0, #0x30
	movlo r0, #1
	blo _027EDF80
	ldrh r0, [r7, #0x10]
	ands r0, r0, #1
	movne r0, #5
	bne _027EDF80
	ldrh r0, [r7, #0x16]
	cmp r0, #0
	moveq r0, #5
	beq _027EDF80
	cmp r0, #0xff
	movhi r0, #5
	bhi _027EDF80
	ldrh r0, [r7, #0x18]
	cmp r0, #0x7d0
	movhi r0, #5
	bhi _027EDF80
	cmp r0, #0xa
	movlo r0, #5
	blo _027EDF80
	mov r0, #0x30
	bl WSetStaState
	bl WClearAids
	ldrh r0, [r7, #0x16]
	strh r0, [r5, #0x70]
	ldrh r0, [r7, #0x16]
	strh r0, [r5, #0x72]
	str r7, [r4, #0x18]
	str r6, [r4, #0x1c]
	mov r0, #0x50
	strh r0, [r4]
	bl MLME_AssTask
	mov r0, #0x80
_027EDF80:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027EDF8C: .word 0x0380FFF4
_027EDF90: .word 0x00000404
	arm_func_end MLME_AssReqCmd

	arm_func_start MLME_DeAuthReqCmd
MLME_DeAuthReqCmd: // 0x027EDF94
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	ldr r2, _027EE0D4 // =0x0380FFF4
	ldr r1, [r2, #0]
	ldr r0, _027EE0D8 // =0x00000404
	add r5, r1, r0
	mov r0, #4
	strh r0, [r6, #2]
	ldr r2, [r2, #0]
	add r0, r2, #0x300
	ldrh r1, [r0, #0x2e]
	cmp r1, #3
	beq _027EDFE4
	cmp r1, #2
	beq _027EDFE4
	cmp r1, #1
	movne r0, #0xb
	bne _027EE0C8
_027EDFE4:
	add r0, r2, #0x300
	ldrh r0, [r0, #0x4c]
	cmp r0, #0x30
	movlo r0, #1
	blo _027EE0C8
	ldr r0, _027EE0DC // =0x0000FFFE
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _027EE020
	ldrh r0, [r7, #0x10]
	ands r0, r0, #1
	movne r0, #5
	bne _027EE0C8
_027EE020:
	add r0, r6, #6
	add r1, r7, #0x10
	bl WSetMacAdrs1
	add r0, r6, #6
	ldrh r1, [r7, #0x16]
	mov r2, #0
	bl MakeDeAuthFrame
	movs r4, r0
	moveq r0, #8
	beq _027EE0C8
	str r7, [r5, #0x18]
	str r6, [r5, #0x1c]
	str r4, [r5, #4]
	mov r0, #0x41
	strh r0, [r5]
	ldrh r0, [r7, #0x10]
	ands r0, r0, #1
	beq _027EE0B4
	ldr r1, _027EE0D4 // =0x0380FFF4
	ldr r0, [r1, #0]
	ldr r0, [r0, #0x3ec]
	strh r0, [r4, #4]
	ldr r0, [r1, #0]
	add r0, r0, #0x188
	sub r1, r4, #0x10
	bl CAM_AddBcFrame
	ldr r0, _027EE0D4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r1, [r0, #0x2e]
	ldrh r0, [r0, #0x32]
	mvn r0, r0
	ands r0, r1, r0
	bne _027EE0C4
	mov r0, #2
	bl TxqPri
	b _027EE0C4
_027EE0B4:
	add r0, r7, #0x10
	bl DeleteTxFrameByAdrs
	mov r0, r4
	bl TxManCtrlFrame
_027EE0C4:
	mov r0, #0x80
_027EE0C8:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027EE0D4: .word 0x0380FFF4
_027EE0D8: .word 0x00000404
_027EE0DC: .word 0x0000FFFE
	arm_func_end MLME_DeAuthReqCmd

	arm_func_start MLME_AuthReqCmd
MLME_AuthReqCmd: // 0x027EE0E0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027EE1B4 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r2, r1, #0x344
	ldr r0, _027EE1B8 // =0x00000404
	add r4, r1, r0
	mov r0, #6
	strh r0, [r5, #2]
	add r0, r1, #0x300
	ldrh r0, [r0, #0x2e]
	cmp r0, #3
	beq _027EE124
	cmp r0, #2
	movne r0, #0xb
	bne _027EE1AC
_027EE124:
	ldrh r0, [r2, #8]
	cmp r0, #0x20
	movlo r0, #1
	blo _027EE1AC
	ldrh r0, [r6, #0x10]
	ands r0, r0, #1
	movne r0, #5
	bne _027EE1AC
	ldrh r0, [r6, #0x16]
	cmp r0, #1
	movhi r0, #5
	bhi _027EE1AC
	ldrh r0, [r6, #0x18]
	cmp r0, #0x7d0
	movhi r0, #5
	bhi _027EE1AC
	cmp r0, #0xa
	movlo r0, #5
	blo _027EE1AC
	mov r0, #0x20
	bl WSetStaState
	str r6, [r4, #0x18]
	str r5, [r4, #0x1c]
	mov r0, #0x30
	strh r0, [r4]
	ldr r0, [r4, #0x18]
	ldrh r0, [r0, #0x16]
	strh r0, [r5, #0xe]
	add r0, r5, #8
	ldr r1, [r4, #0x18]
	add r1, r1, #0x10
	bl WSetMacAdrs1
	bl MLME_AuthTask
	mov r0, #0x80
_027EE1AC:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EE1B4: .word 0x0380FFF4
_027EE1B8: .word 0x00000404
	arm_func_end MLME_AuthReqCmd

	arm_func_start MLME_JoinReqCmd
MLME_JoinReqCmd: // 0x027EE1BC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027EE370 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r2, r1, #0x344
	ldr r0, _027EE374 // =0x00000404
	add r4, r1, r0
	mov r0, #5
	strh r0, [r5, #2]
	add r0, r1, #0x300
	ldrh r0, [r0, #0x2e]
	cmp r0, #3
	beq _027EE200
	cmp r0, #2
	movne r0, #0xb
	bne _027EE368
_027EE200:
	ldrh r0, [r2, #8]
	cmp r0, #0x20
	movlo r0, #1
	blo _027EE368
	mov r0, #0x20
	bl WSetStaState
	ldrh r0, [r6, #0x18]
	ands r0, r0, #1
	movne r0, #5
	bne _027EE368
	ldrh r0, [r6, #0x1e]
	cmp r0, #0
	moveq r0, #5
	beq _027EE368
	cmp r0, #0x20
	movhi r0, #5
	bhi _027EE368
	ldrh r0, [r6, #0x46]
	cmp r0, #0xa
	movlo r0, #5
	blo _027EE368
	cmp r0, #0x3e8
	movhi r0, #5
	bhi _027EE368
	ldrh r0, [r6, #0x48]
	cmp r0, #0xff
	movhi r0, #5
	bhi _027EE368
	ldrh r0, [r6, #0x4a]
	ldr r1, _027EE378 // =0x0000FFF0
	ands r1, r0, r1
	movne r0, #5
	bne _027EE368
	bl CheckEnableChannel
	cmp r0, #0
	moveq r0, #5
	beq _027EE368
	ldrh r2, [r6, #0x42]
	mov r0, #0x1000
	rsb r0, r0, #0
	ands r1, r2, r0
	movne r0, #5
	bne _027EE368
	ldrh r1, [r6, #0x44]
	ands r0, r1, r0
	movne r0, #5
	bne _027EE368
	cmp r2, #0
	moveq r0, #5
	beq _027EE368
	orrs r0, r1, r2
	moveq r0, #5
	beq _027EE368
	ldrh r0, [r6, #0x10]
	cmp r0, #0x7d0
	movhi r0, #5
	bhi _027EE368
	mov r0, #0
	bl FLASH_VerifyCheckSum
	cmp r0, #0
	movne r0, #0xe
	bne _027EE368
	ldrh r0, [r6, #0x40]
	ands r0, r0, #0x20
	beq _027EE310
	mov r0, #1
	bl WSetPreambleType
	b _027EE318
_027EE310:
	mov r0, #0
	bl WSetPreambleType
_027EE318:
	add r0, r6, #0x18
	bl WSetBssid
	ldrh r0, [r6, #0x1e]
	add r1, r6, #0x20
	bl WSetSsid
	ldrh r0, [r6, #0x46]
	bl WSetBeaconPeriod
	ldrh r0, [r6, #0x4a]
	mov r1, #0
	bl WSetChannel
	add r0, r6, #0x42
	bl WSetRateSet
	str r6, [r4, #0x18]
	str r5, [r4, #0x1c]
	mov r0, #0x20
	strh r0, [r4]
	mov r0, #2
	mov r1, #1
	bl AddTask
	mov r0, #0x80
_027EE368:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EE370: .word 0x0380FFF4
_027EE374: .word 0x00000404
_027EE378: .word 0x0000FFF0
	arm_func_end MLME_JoinReqCmd

	arm_func_start MLME_ScanReqCmd
MLME_ScanReqCmd: // 0x027EE37C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027EE4C0 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027EE4C4 // =0x00000404
	add r4, r1, r0
	ldrh r0, [r5, #2]
	sub r0, r0, #3
	strh r0, [r4, #4]
	mov r0, #3
	strh r0, [r5, #2]
	add r0, r1, #0x300
	ldrh r0, [r0, #0x2e]
	cmp r0, #1
	beq _027EE3D0
	cmp r0, #3
	beq _027EE3D0
	cmp r0, #2
	movne r0, #0xb
	bne _027EE4B8
_027EE3D0:
	ldr r0, _027EE4C0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x4c]
	cmp r0, #0x20
	movlo r0, #1
	blo _027EE4B8
	ldrh r0, [r6, #0x16]
	cmp r0, #0x20
	movhi r0, #5
	bhi _027EE4B8
	ldrh r0, [r6, #0x38]
	cmp r0, #1
	movhi r0, #5
	bhi _027EE4B8
	add r0, r6, #0x3a
	bl WL_ReadByte
	cmp r0, #0
	moveq r0, #5
	beq _027EE4B8
	ldrh r0, [r6, #0x4a]
	cmp r0, #0x3e8
	movhi r0, #5
	bhi _027EE4B8
	cmp r0, #0xa
	movlo r0, #5
	blo _027EE4B8
	ldrh r0, [r6, #0x4c]
	cmp r0, #0x10
	movhi r0, #5
	bhi _027EE4B8
	mov r8, #0
	add r7, r6, #0x3a
	b _027EE47C
_027EE458:
	add r0, r7, r8
	bl WL_ReadByte
	cmp r0, #0
	beq _027EE484
	bl CheckEnableChannel
	cmp r0, #0
	moveq r0, #5
	beq _027EE4B8
	add r8, r8, #1
_027EE47C:
	cmp r8, #0x10
	blo _027EE458
_027EE484:
	add r0, r6, #0x10
	bl WSetBssid
	ldrh r0, [r6, #0x16]
	add r1, r6, #0x18
	bl WSetSsid
	str r6, [r4, #0x18]
	str r5, [r4, #0x1c]
	mov r0, #0x10
	strh r0, [r4]
	mov r0, #2
	mov r1, #0
	bl AddTask
	mov r0, #0x80
_027EE4B8:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027EE4C0: .word 0x0380FFF4
_027EE4C4: .word 0x00000404
	arm_func_end MLME_ScanReqCmd

	arm_func_start MLME_PwrMgtReqCmd
MLME_PwrMgtReqCmd: // 0x027EE4C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #9
	strh r0, [r1, #2]
	ldrh r0, [r4, #0x10]
	cmp r0, #1
	movhi r0, #5
	bhi _027EE564
	ldrh r1, [r4, #0x12]
	cmp r1, #1
	movhi r0, #5
	bhi _027EE564
	ldrh r1, [r4, #0x14]
	cmp r1, #1
	movhi r0, #5
	bhi _027EE564
	bl WSetPowerMgtMode
	ldrh r0, [r4, #0x10]
	cmp r0, #1
	bne _027EE550
	ldrh r0, [r4, #0x12]
	cmp r0, #1
	bne _027EE530
	ldr r0, _027EE56C // =0x00008001
	bl WSetForcePowerState
	b _027EE538
_027EE530:
	mov r0, #0
	bl WSetForcePowerState
_027EE538:
	ldrh r1, [r4, #0x14]
	ldr r0, _027EE570 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	strh r1, [r0, #0x58]
	b _027EE560
_027EE550:
	mov r0, #0x8000
	bl WSetForcePowerState
	mov r0, #2
	bl WSetPowerState
_027EE560:
	mov r0, #0
_027EE564:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EE56C: .word 0x00008001
_027EE570: .word 0x0380FFF4
	arm_func_end MLME_PwrMgtReqCmd

	arm_func_start MLME_ResetReqCmd
MLME_ResetReqCmd: // 0x027EE574
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	strh r0, [r1, #2]
	ldrh r0, [r4, #0x10]
	cmp r0, #1
	movhi r0, #5
	bhi _027EE5AC
	bl WStop
	ldrh r0, [r4, #0x10]
	cmp r0, #1
	bne _027EE5A8
	bl WInitCounter
_027EE5A8:
	mov r0, #0
_027EE5AC:
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end MLME_ResetReqCmd

	arm_func_start PARAMGET_GameInfoReqCmd
PARAMGET_GameInfoReqCmd: // 0x027EE5B4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r1
	ldrh r0, [r4, #2]
	cmp r0, #1
	ldrhi r0, _027EE694 // =0x0380FFF4
	ldrhi r0, [r0, #0]
	addhi r0, r0, #0x300
	ldrhih r0, [r0, #0xe4]
	strhih r0, [r4, #6]
	ldr r0, _027EE694 // =0x0380FFF4
	ldr r3, [r0, #0]
	add r0, r3, #0x300
	ldrh r2, [r0, #0xe4]
	ldrh r1, [r4, #2]
	sub r1, r1, #2
	cmp r2, r1, lsl #1
	movgt r0, #4
	bgt _027EE688
	ldrh r2, [r4, #6]
	cmp r2, #0
	beq _027EE66C
	ldrh r0, [r0, #0xe6]
	ands r0, r0, #1
	beq _027EE65C
	ldr r0, [r3, #0x3e0]
	add r7, r0, #1
	add r6, r4, #8
	mov r5, #0
	b _027EE64C
_027EE62C:
	mov r0, r7
	bl WL_ReadByte
	mov r1, r0
	mov r0, r6
	bl WL_WriteByte
	add r6, r6, #1
	add r7, r7, #1
	add r5, r5, #1
_027EE64C:
	ldrh r0, [r4, #6]
	cmp r5, r0
	blo _027EE62C
	b _027EE66C
_027EE65C:
	ldr r0, [r3, #0x3e0]
	add r1, r4, #8
	add r2, r2, #1
	bl MIi_CpuCopy16
_027EE66C:
	ldrh r0, [r4, #6]
	add r0, r0, #1
	mov r1, #2
	bl _s32_div_f
	add r0, r0, #2
	strh r0, [r4, #2]
	mov r0, #0
_027EE688:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027EE694: .word 0x0380FFF4
	arm_func_end PARAMGET_GameInfoReqCmd

	arm_func_start PARAMGET_ListenIntervalReqCmd
PARAMGET_ListenIntervalReqCmd: // 0x027EE698
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE6BC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xb4]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EE6BC: .word 0x0380FFF4
	arm_func_end PARAMGET_ListenIntervalReqCmd

	arm_func_start PARAMGET_DTIMPeriodReqCmd
PARAMGET_DTIMPeriodReqCmd: // 0x027EE6C0
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE6E4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xb8]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EE6E4: .word 0x0380FFF4
	arm_func_end PARAMGET_DTIMPeriodReqCmd

	arm_func_start PARAMGET_BeaconPeriodReqCmd
PARAMGET_BeaconPeriodReqCmd: // 0x027EE6E8
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE70C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xb2]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EE70C: .word 0x0380FFF4
	arm_func_end PARAMGET_BeaconPeriodReqCmd

	arm_func_start PARAMGET_SSIDReqCmd
PARAMGET_SSIDReqCmd: // 0x027EE710
	mov r0, #0x12
	strh r0, [r1, #2]
	ldr r2, _027EE758 // =0x0380FFF4
	ldr r0, [r2, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x62]
	strh r0, [r1, #6]
	add r3, r1, #8
	ldr r0, [r2, #0]
	add r1, r0, #0x364
	mov r2, #0
_027EE73C:
	ldrh r0, [r1], #2
	strh r0, [r3], #2
	add r2, r2, #2
	cmp r2, #0x20
	blo _027EE73C
	mov r0, #0
	bx lr
	.align 2, 0
_027EE758: .word 0x0380FFF4
	arm_func_end PARAMGET_SSIDReqCmd

	arm_func_start PARAMGET_BSSIDReqCmd
PARAMGET_BSSIDReqCmd: // 0x027EE75C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #4
	strh r0, [r1, #2]
	add r0, r1, #6
	ldr r1, _027EE790 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x3a8
	bl WSetMacAdrs1
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EE790: .word 0x0380FFF4
	arm_func_end PARAMGET_BSSIDReqCmd

	arm_func_start PARAMGET_NullKeyModeReqCmd
PARAMGET_NullKeyModeReqCmd: // 0x027EE794
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE7CC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r2, [r0, #0x4c]
	cmp r2, #0x10
	movlo r0, #1
	ldrhsh r0, [r0, #0x3a]
	movhs r0, r0, lsl #0x18
	movhs r0, r0, lsr #0x1f
	strhsh r0, [r1, #6]
	movhs r0, #0
	bx lr
	.align 2, 0
_027EE7CC: .word 0x0380FFF4
	arm_func_end PARAMGET_NullKeyModeReqCmd

	arm_func_start PARAMGET_BcnSendRecvIndReqCmd
PARAMGET_BcnSendRecvIndReqCmd: // 0x027EE7D0
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE808 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r2, [r0, #0x4c]
	cmp r2, #0x10
	movlo r0, #1
	ldrhsh r0, [r0, #0x3a]
	movhs r0, r0, lsl #0x19
	movhs r0, r0, lsr #0x1f
	strhsh r0, [r1, #6]
	movhs r0, #0
	bx lr
	.align 2, 0
_027EE808: .word 0x0380FFF4
	arm_func_end PARAMGET_BcnSendRecvIndReqCmd

	arm_func_start PARAMGET_DiversityReqCmd
PARAMGET_DiversityReqCmd: // 0x027EE80C
	mov r0, #3
	strh r0, [r1, #2]
	ldr r3, _027EE868 // =0x0380FFF4
	ldr r0, [r3, #0]
	add r0, r0, #0x300
	ldrh r2, [r0, #0x4c]
	cmp r2, #0x10
	movlo r0, #1
	bxlo lr
	ldrh r0, [r0, #0x3a]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	strh r0, [r1, #6]
	ldr r0, [r3, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r2, r0, lsl #0x1a
	mov r2, r2, lsr #0x1f
	mov r0, r0, lsl #0x1c
	eor r0, r2, r0, lsr #31
	strh r0, [r1, #8]
	mov r0, #0
	bx lr
	.align 2, 0
_027EE868: .word 0x0380FFF4
	arm_func_end PARAMGET_DiversityReqCmd

	arm_func_start PARAMGET_MainAntennaReqCmd
PARAMGET_MainAntennaReqCmd: // 0x027EE86C
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE8A4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r2, [r0, #0x4c]
	cmp r2, #0x10
	movlo r0, #1
	ldrhsh r0, [r0, #0x3a]
	movhs r0, r0, lsl #0x1c
	movhs r0, r0, lsr #0x1f
	strhsh r0, [r1, #6]
	movhs r0, #0
	bx lr
	.align 2, 0
_027EE8A4: .word 0x0380FFF4
	arm_func_end PARAMGET_MainAntennaReqCmd

	arm_func_start PARAMGET_MaxConnReqCmd
PARAMGET_MaxConnReqCmd: // 0x027EE8A8
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE8D0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x22]
	sub r0, r0, #1
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EE8D0: .word 0x0380FFF4
	arm_func_end PARAMGET_MaxConnReqCmd

	arm_func_start PARAMGET_CCAModeEDThReqCmd
PARAMGET_CCAModeEDThReqCmd: // 0x027EE8D4
	stmdb sp!, {r4, lr}
	mov r4, r1
	mov r0, #4
	strh r0, [r4, #2]
	mov r0, #0x13
	bl BBP_Read
	strh r0, [r4, #6]
	mov r0, #0x35
	bl BBP_Read
	strh r0, [r4, #8]
	mov r0, #0x2e
	bl BBP_Read
	strh r0, [r4, #0xa]
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end PARAMGET_CCAModeEDThReqCmd

	arm_func_start PARAMGET_AuthAlgoReqCmd
PARAMGET_AuthAlgoReqCmd: // 0x027EE914
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE938 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x32]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EE938: .word 0x0380FFF4
	arm_func_end PARAMGET_AuthAlgoReqCmd

	arm_func_start PARAMGET_PreambleTypeReqCmd
PARAMGET_PreambleTypeReqCmd: // 0x027EE93C
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE968 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EE968: .word 0x0380FFF4
	arm_func_end PARAMGET_PreambleTypeReqCmd

	arm_func_start PARAMGET_SSIDMaskReqCmd
PARAMGET_SSIDMaskReqCmd: // 0x027EE96C
	mov r0, #0x11
	strh r0, [r1, #2]
	add r2, r1, #6
	ldr r0, _027EE9A4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r1, r0, #0x384
	mov r3, #0
_027EE988:
	ldrh r0, [r1], #2
	strh r0, [r2], #2
	add r3, r3, #1
	cmp r3, #0x10
	blo _027EE988
	mov r0, #0
	bx lr
	.align 2, 0
_027EE9A4: .word 0x0380FFF4
	arm_func_end PARAMGET_SSIDMaskReqCmd

	arm_func_start PARAMGET_ActiveZoneReqCmd
PARAMGET_ActiveZoneReqCmd: // 0x027EE9A8
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE9CC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3c]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EE9CC: .word 0x0380FFF4
	arm_func_end PARAMGET_ActiveZoneReqCmd

	arm_func_start PARAMGET_BeaconLostThReqCmd
PARAMGET_BeaconLostThReqCmd: // 0x027EE9D0
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EE9F4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xc2]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EE9F4: .word 0x0380FFF4
	arm_func_end PARAMGET_BeaconLostThReqCmd

	arm_func_start PARAMGET_ResBcSsidReqCmd
PARAMGET_ResBcSsidReqCmd: // 0x027EE9F8
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EEA24 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r0, r0, lsl #0x1e
	mov r0, r0, lsr #0x1f
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EEA24: .word 0x0380FFF4
	arm_func_end PARAMGET_ResBcSsidReqCmd

	arm_func_start PARAMGET_BeaconTypeReqCmd
PARAMGET_BeaconTypeReqCmd: // 0x027EEA28
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EEA54 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r0, r0, lsl #0x1f
	mov r0, r0, lsr #0x1f
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EEA54: .word 0x0380FFF4
	arm_func_end PARAMGET_BeaconTypeReqCmd

	arm_func_start PARAMGET_WepKeyIdReqCmd
PARAMGET_WepKeyIdReqCmd: // 0x027EEA58
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EEA7C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x36]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EEA7C: .word 0x0380FFF4
	arm_func_end PARAMGET_WepKeyIdReqCmd

	arm_func_start PARAMGET_WepModeReqCmd
PARAMGET_WepModeReqCmd: // 0x027EEA80
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EEAA4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x34]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EEAA4: .word 0x0380FFF4
	arm_func_end PARAMGET_WepModeReqCmd

	arm_func_start PARAMGET_RateReqCmd
PARAMGET_RateReqCmd: // 0x027EEAA8
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EEACC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x30]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EEACC: .word 0x0380FFF4
	arm_func_end PARAMGET_RateReqCmd

	arm_func_start PARAMGET_ModeReqCmd
PARAMGET_ModeReqCmd: // 0x027EEAD0
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EEAF4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x2e]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EEAF4: .word 0x0380FFF4
	arm_func_end PARAMGET_ModeReqCmd

	arm_func_start PARAMGET_EnableChannelReqCmd
PARAMGET_EnableChannelReqCmd: // 0x027EEAF8
	mov r0, #3
	strh r0, [r1, #2]
	ldr r2, _027EEB2C // =0x0380FFF4
	ldr r0, [r2, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x2c]
	strh r0, [r1, #6]
	ldr r0, [r2, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xbe]
	strh r0, [r1, #8]
	mov r0, #0
	bx lr
	.align 2, 0
_027EEB2C: .word 0x0380FFF4
	arm_func_end PARAMGET_EnableChannelReqCmd

	arm_func_start PARAMGET_RetryReqCmd
PARAMGET_RetryReqCmd: // 0x027EEB30
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EEB54 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x2a]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EEB54: .word 0x0380FFF4
	arm_func_end PARAMGET_RetryReqCmd

	arm_func_start PARAMGET_MacAdrsReqCmd
PARAMGET_MacAdrsReqCmd: // 0x027EEB58
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #4
	strh r0, [r1, #2]
	add r0, r1, #6
	ldr r1, _027EEB8C // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x324
	bl WSetMacAdrs1
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EEB8C: .word 0x0380FFF4
	arm_func_end PARAMGET_MacAdrsReqCmd

	arm_func_start PARAMGET_AllReqCmd
PARAMGET_AllReqCmd: // 0x027EEB90
	stmdb sp!, {r4, lr}
	mov r4, r1
	mov r0, #0x21
	strh r0, [r4, #2]
	add r0, r4, #6
	ldr r1, _027EECC4 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x324
	bl WSetMacAdrs1
	ldr r0, _027EECC4 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x2a]
	strh r1, [r4, #0xc]
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x2c]
	strh r1, [r4, #0xe]
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xbe]
	strh r1, [r4, #0x10]
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x2e]
	strh r1, [r4, #0x12]
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x30]
	strh r1, [r4, #0x14]
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x34]
	strh r1, [r4, #0x16]
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x36]
	strh r1, [r4, #0x18]
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x3a]
	mov r1, r1, lsl #0x1f
	mov r1, r1, lsr #0x1f
	strh r1, [r4, #0x1a]
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x3a]
	mov r1, r1, lsl #0x1e
	mov r1, r1, lsr #0x1f
	strh r1, [r4, #0x1c]
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xc2]
	strh r1, [r4, #0x1e]
	ldr r1, [r0, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x3c]
	strh r1, [r4, #0x20]
	ldr r0, [r0, #0]
	add r0, r0, #0x384
	add r1, r4, #0x22
	mov r2, #0x20
	bl MIi_CpuCopy16
	ldr r1, _027EECC4 // =0x0380FFF4
	ldr r0, [r1, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	strh r0, [r4, #0x42]
	ldr r0, [r1, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x32]
	strh r0, [r4, #0x44]
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EECC4: .word 0x0380FFF4
	arm_func_end PARAMGET_AllReqCmd

	arm_func_start PARAMSET_GameInfoReqCmd
PARAMSET_GameInfoReqCmd: // 0x027EECC8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r0, #1
	strh r0, [r1, #2]
	ldr r0, _027EED34 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x2e]
	cmp r0, #1
	movne r0, #0xb
	bne _027EED28
	ldrh r5, [r4, #0x10]
	add r0, r5, #1
	mov r1, #2
	bl _s32_div_f
	ldrh r1, [r4, #0xe]
	add r0, r0, #1
	cmp r1, r0
	movlt r0, #4
	blt _027EED28
	mov r0, r5
	add r1, r4, #0x12
	bl WSetGameInfo
_027EED28:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027EED34: .word 0x0380FFF4
	arm_func_end PARAMSET_GameInfoReqCmd

	arm_func_start PARAMSET_ListenIntervalReqCmd
PARAMSET_ListenIntervalReqCmd: // 0x027EED38
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #1
	strh r2, [r1, #2]
	ldr r1, _027EED80 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x2e]
	cmp r1, #2
	beq _027EED6C
	cmp r1, #3
	movne r0, #0xb
	bne _027EED74
_027EED6C:
	ldrh r0, [r0, #0x10]
	bl WSetListenInterval
_027EED74:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EED80: .word 0x0380FFF4
	arm_func_end PARAMSET_ListenIntervalReqCmd

	arm_func_start PARAMSET_DTIMPeriodReqCmd
PARAMSET_DTIMPeriodReqCmd: // 0x027EED84
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #1
	strh r2, [r1, #2]
	ldr r1, _027EEDC4 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x2e]
	cmp r1, #1
	movne r0, #0xb
	bne _027EEDB8
	ldrh r0, [r0, #0x10]
	bl WSetDTIMPeriod
_027EEDB8:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EEDC4: .word 0x0380FFF4
	arm_func_end PARAMSET_DTIMPeriodReqCmd

	arm_func_start PARAMSET_BeaconPeriodReqCmd
PARAMSET_BeaconPeriodReqCmd: // 0x027EEDC8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #1
	strh r2, [r1, #2]
	ldr r1, _027EEE08 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x2e]
	cmp r1, #1
	movne r0, #0xb
	bne _027EEDFC
	ldrh r0, [r0, #0x10]
	bl WSetBeaconPeriod
_027EEDFC:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EEE08: .word 0x0380FFF4
	arm_func_end PARAMSET_BeaconPeriodReqCmd

	arm_func_start PARAMSET_SSIDReqCmd
PARAMSET_SSIDReqCmd: // 0x027EEE0C
	mov r2, r0
	mov r0, #1
	strh r0, [r1, #2]
	ldrh r0, [r2, #0x10]
	add r1, r2, #0x12
	ldr ip, _027EEE28 // =WSetSsid
	bx ip
	.align 2, 0
_027EEE28: .word WSetSsid
	arm_func_end PARAMSET_SSIDReqCmd

	arm_func_start PARAMSET_BSSIDReqCmd
PARAMSET_BSSIDReqCmd: // 0x027EEE2C
	mov r2, #1
	strh r2, [r1, #2]
	add r0, r0, #0x10
	ldr ip, _027EEE40 // =WSetBssid
	bx ip
	.align 2, 0
_027EEE40: .word WSetBssid
	arm_func_end PARAMSET_BSSIDReqCmd

	arm_func_start PARAMSET_NullKeyModeReqCmd
PARAMSET_NullKeyModeReqCmd: // 0x027EEE44
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #1
	strh r2, [r1, #2]
	ldr r1, _027EEE88 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x10
	blo _027EEE78
	ldrh r0, [r0, #0x10]
	bl WSetNullKeyMode
	mov r2, r0
_027EEE78:
	mov r0, r2
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EEE88: .word 0x0380FFF4
	arm_func_end PARAMSET_NullKeyModeReqCmd

	arm_func_start PARAMSET_BcnSendRecvIndReqCmd
PARAMSET_BcnSendRecvIndReqCmd: // 0x027EEE8C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #1
	strh r2, [r1, #2]
	ldr r1, _027EEED0 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x10
	blo _027EEEC0
	ldrh r0, [r0, #0x10]
	bl WSetBeaconSendRecvIndicate
	mov r2, r0
_027EEEC0:
	mov r0, r2
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EEED0: .word 0x0380FFF4
	arm_func_end PARAMSET_BcnSendRecvIndReqCmd

	arm_func_start PARAMSET_DiversityReqCmd
PARAMSET_DiversityReqCmd: // 0x027EEED4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r0
	mov r0, #1
	strh r0, [r1, #2]
	ldr r1, _027EEF18 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x10
	blo _027EEF0C
	ldrh r0, [r2, #0x10]
	ldrh r1, [r2, #0x12]
	bl WSetDiversity
_027EEF0C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EEF18: .word 0x0380FFF4
	arm_func_end PARAMSET_DiversityReqCmd

	arm_func_start PARAMSET_MainAntennaReqCmd
PARAMSET_MainAntennaReqCmd: // 0x027EEF1C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #1
	strh r2, [r1, #2]
	ldr r1, _027EEF60 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x10
	blo _027EEF50
	ldrh r0, [r0, #0x10]
	bl WSetMainAntenna
	mov r2, r0
_027EEF50:
	mov r0, r2
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EEF60: .word 0x0380FFF4
	arm_func_end PARAMSET_MainAntennaReqCmd

	arm_func_start PARAMSET_MaxConnReqCmd
PARAMSET_MaxConnReqCmd: // 0x027EEF64
	mov r3, #1
	strh r3, [r1, #2]
	ldr r2, _027EEFB8 // =0x0380FFF4
	ldr r1, [r2, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x20
	movhi r0, r3
	bxhi lr
	ldrh r1, [r0, #0x10]
	add r1, r1, #1
	strh r1, [r0, #0x10]
	ldr r1, [r2, #0]
	ldrh r2, [r0, #0x10]
	add r0, r1, #0x300
	ldrh r1, [r0, #0x20]
	cmp r2, r1
	movhi r0, #5
	strlsh r2, [r0, #0x22]
	movls r0, #0
	bx lr
	.align 2, 0
_027EEFB8: .word 0x0380FFF4
	arm_func_end PARAMSET_MaxConnReqCmd

	arm_func_start PARAMSET_LifeTimeReqCmd
PARAMSET_LifeTimeReqCmd: // 0x027EEFBC
	stmdb sp!, {r4, lr}
	ldr ip, _027EF0C0 // =0x0380FFF4
	ldr r2, [ip]
	ldr r2, [r2, #0x31c]
	mov r3, #1
	strh r3, [r1, #2]
	ldrh r1, [r0, #0x10]
	ldr r3, [ip]
	add r3, r3, #0x300
	ldrh r3, [r3, #0x22]
	cmp r1, r3
	blo _027EEFFC
	ldr r3, _027EF0C4 // =0x0000FFFF
	cmp r1, r3
	movne r0, #5
	bne _027EF0B8
_027EEFFC:
	ldrh ip, [r0, #0x14]
	cmp ip, #0x3f
	bls _027EF018
	ldr r3, _027EF0C4 // =0x0000FFFF
	cmp ip, r3
	movne r0, #5
	bne _027EF0B8
_027EF018:
	ldr r3, _027EF0C4 // =0x0000FFFF
	cmp r1, r3
	bne _027EF06C
	mov r4, #1
	ldr ip, _027EF0C0 // =0x0380FFF4
	mov r3, #0x1c
	b _027EF054
_027EF034:
	mla lr, r4, r3, r2
	ldrh r1, [r0, #0x12]
	strh r1, [lr, #0x1a]
	ldrh r1, [lr, #0x18]
	cmp r1, #0
	ldrneh r1, [r0, #0x12]
	strneh r1, [lr, #0x18]
	add r4, r4, #1
_027EF054:
	ldr r1, [ip]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x22]
	cmp r4, r1
	blo _027EF034
	b _027EF0A4
_027EF06C:
	cmp r1, #0
	beq _027EF0A4
	ldrh lr, [r0, #0x12]
	mov r3, #0x1c
	mla ip, r1, r3, r2
	strh lr, [ip, #0x1a]
	add ip, r2, #0x18
	ldrh r1, [r0, #0x10]
	mul r2, r1, r3
	add r3, ip, r2
	ldrh r1, [ip, r2]
	cmp r1, #0
	ldrneh r1, [r0, #0x12]
	strneh r1, [r3]
_027EF0A4:
	ldrh r0, [r0, #0x14]
	cmp r0, #0
	beq _027EF0B4
	bl WSetFrameLifeTime
_027EF0B4:
	mov r0, #0
_027EF0B8:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EF0C0: .word 0x0380FFF4
_027EF0C4: .word 0x0000FFFF
	arm_func_end PARAMSET_LifeTimeReqCmd

	arm_func_start PARAMSET_CCAModeEDThReqCmd
PARAMSET_CCAModeEDThReqCmd: // 0x027EF0C8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #1
	strh r0, [r1, #2]
	ldrh r0, [r5, #0x14]
	cmp r0, #0x3f
	movhi r0, #5
	bhi _027EF110
	ldrh r0, [r5, #0x10]
	ldrh r1, [r5, #0x12]
	bl WSetCCA_ED
	movs r4, r0
	bne _027EF10C
	mov r0, #0x2e
	ldrh r1, [r5, #0x14]
	bl BBP_Write
_027EF10C:
	mov r0, r4
_027EF110:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end PARAMSET_CCAModeEDThReqCmd

	arm_func_start PARAMSET_AuthAlgoReqCmd
PARAMSET_AuthAlgoReqCmd: // 0x027EF11C
	mov r2, #1
	strh r2, [r1, #2]
	ldrh r0, [r0, #0x10]
	ldr ip, _027EF130 // =WSetAuthAlgo
	bx ip
	.align 2, 0
_027EF130: .word WSetAuthAlgo
	arm_func_end PARAMSET_AuthAlgoReqCmd

	arm_func_start PARAMSET_PreambleTypeReqCmd
PARAMSET_PreambleTypeReqCmd: // 0x027EF134
	mov r2, #1
	strh r2, [r1, #2]
	ldrh r0, [r0, #0x10]
	ldr ip, _027EF148 // =WSetPreambleType
	bx ip
	.align 2, 0
_027EF148: .word WSetPreambleType
	arm_func_end PARAMSET_PreambleTypeReqCmd

	arm_func_start PARAMSET_SSIDMaskReqCmd
PARAMSET_SSIDMaskReqCmd: // 0x027EF14C
	mov r2, #1
	strh r2, [r1, #2]
	add r0, r0, #0x10
	ldr ip, _027EF160 // =WSetSsidMask
	bx ip
	.align 2, 0
_027EF160: .word WSetSsidMask
	arm_func_end PARAMSET_SSIDMaskReqCmd

	arm_func_start PARAMSET_ActiveZoneReqCmd
PARAMSET_ActiveZoneReqCmd: // 0x027EF164
	mov r2, #1
	strh r2, [r1, #2]
	ldrh r0, [r0, #0x10]
	mov r1, #0
	ldr ip, _027EF17C // =WSetActiveZoneTime
	bx ip
	.align 2, 0
_027EF17C: .word WSetActiveZoneTime
	arm_func_end PARAMSET_ActiveZoneReqCmd

	arm_func_start PARAMSET_BeaconLostThReqCmd
PARAMSET_BeaconLostThReqCmd: // 0x027EF180
	mov r2, #1
	strh r2, [r1, #2]
	ldrh r0, [r0, #0x10]
	ldr ip, _027EF194 // =WSetBeaconLostThreshold
	bx ip
	.align 2, 0
_027EF194: .word WSetBeaconLostThreshold
	arm_func_end PARAMSET_BeaconLostThReqCmd

	arm_func_start PARAMSET_ResBcSsidReqCmd
PARAMSET_ResBcSsidReqCmd: // 0x027EF198
	mov r2, #1
	strh r2, [r1, #2]
	ldrh r0, [r0, #0x10]
	ldr ip, _027EF1AC // =WSetBcSsidResponse
	bx ip
	.align 2, 0
_027EF1AC: .word WSetBcSsidResponse
	arm_func_end PARAMSET_ResBcSsidReqCmd

	arm_func_start PARAMSET_BeaconTypeReqCmd
PARAMSET_BeaconTypeReqCmd: // 0x027EF1B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #1
	strh r2, [r1, #2]
	ldr r1, _027EF1F4 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x20
	bhi _027EF1E4
	ldrh r0, [r0, #0x10]
	bl WSetBeaconType
	mov r2, r0
_027EF1E4:
	mov r0, r2
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EF1F4: .word 0x0380FFF4
	arm_func_end PARAMSET_BeaconTypeReqCmd

	arm_func_start PARAMSET_WepKeyReqCmd
PARAMSET_WepKeyReqCmd: // 0x027EF1F8
	mov r2, #1
	strh r2, [r1, #2]
	add r0, r0, #0x10
	ldr ip, _027EF20C // =WSetWepKey
	bx ip
	.align 2, 0
_027EF20C: .word WSetWepKey
	arm_func_end PARAMSET_WepKeyReqCmd

	arm_func_start PARAMSET_WepKeyIdReqCmd
PARAMSET_WepKeyIdReqCmd: // 0x027EF210
	mov r2, #1
	strh r2, [r1, #2]
	ldrh r0, [r0, #0x10]
	ldr ip, _027EF224 // =WSetWepKeyId
	bx ip
	.align 2, 0
_027EF224: .word WSetWepKeyId
	arm_func_end PARAMSET_WepKeyIdReqCmd

	arm_func_start PARAMSET_WepModeReqCmd
PARAMSET_WepModeReqCmd: // 0x027EF228
	mov r2, #1
	strh r2, [r1, #2]
	ldrh r0, [r0, #0x10]
	ldr ip, _027EF23C // =WSetWepMode
	bx ip
	.align 2, 0
_027EF23C: .word WSetWepMode
	arm_func_end PARAMSET_WepModeReqCmd

	arm_func_start PARAMSET_RateReqCmd
PARAMSET_RateReqCmd: // 0x027EF240
	mov r2, #1
	strh r2, [r1, #2]
	ldrh r0, [r0, #0x10]
	ldr ip, _027EF254 // =WSetRate
	bx ip
	.align 2, 0
_027EF254: .word WSetRate
	arm_func_end PARAMSET_RateReqCmd

	arm_func_start PARAMSET_ModeReqCmd
PARAMSET_ModeReqCmd: // 0x027EF258
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, #1
	strh r3, [r1, #2]
	ldr r1, _027EF2B0 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r2, [r1, #0x4c]
	cmp r2, #0x20
	movhi r0, r3
	bhi _027EF2A4
	cmp r2, #0x20
	bne _027EF29C
	ldrh r1, [r1, #0x56]
	cmp r1, #0
	movne r0, r3
	bne _027EF2A4
_027EF29C:
	ldrh r0, [r0, #0x10]
	bl WSetMode
_027EF2A4:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EF2B0: .word 0x0380FFF4
	arm_func_end PARAMSET_ModeReqCmd

	arm_func_start PARAMSET_EnableChannelReqCmd
PARAMSET_EnableChannelReqCmd: // 0x027EF2B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #1
	strh r2, [r1, #2]
	ldr r1, _027EF2F8 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x10
	bne _027EF2E8
	ldrh r0, [r0, #0x10]
	bl WSetEnableChannel
	mov r2, r0
_027EF2E8:
	mov r0, r2
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EF2F8: .word 0x0380FFF4
	arm_func_end PARAMSET_EnableChannelReqCmd

	arm_func_start PARAMSET_RetryReqCmd
PARAMSET_RetryReqCmd: // 0x027EF2FC
	mov r2, #1
	strh r2, [r1, #2]
	ldrh r0, [r0, #0x10]
	ldr ip, _027EF310 // =WSetRetryLimit
	bx ip
	.align 2, 0
_027EF310: .word WSetRetryLimit
	arm_func_end PARAMSET_RetryReqCmd

	arm_func_start PARAMSET_MacAdrsReqCmd
PARAMSET_MacAdrsReqCmd: // 0x027EF314
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #1
	strh r2, [r1, #2]
	ldr r1, _027EF358 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x10
	bne _027EF348
	add r0, r0, #0x10
	bl WSetMacAdrs
	mov r2, r0
_027EF348:
	mov r0, r2
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EF358: .word 0x0380FFF4
	arm_func_end PARAMSET_MacAdrsReqCmd

	arm_func_start PARAMSET_AllReqCmd
PARAMSET_AllReqCmd: // 0x027EF35C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, #1
	strh r0, [r1, #2]
	ldr r1, _027EF44C // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0x10
	bne _027EF440
	add r0, r5, #0x10
	bl WSetMacAdrs
	mov r4, r0
	ldrh r0, [r5, #0x16]
	bl WSetRetryLimit
	orr r4, r4, r0
	ldrh r0, [r5, #0x18]
	bl WSetEnableChannel
	orr r4, r4, r0
	ldrh r0, [r5, #0x1c]
	bl WSetMode
	orr r4, r4, r0
	ldrh r0, [r5, #0x1e]
	bl WSetRate
	orr r4, r4, r0
	ldrh r0, [r5, #0x20]
	bl WSetWepMode
	orr r4, r4, r0
	ldrh r0, [r5, #0x22]
	bl WSetWepKeyId
	orr r4, r4, r0
	add r0, r5, #0x24
	bl WSetWepKey
	orr r4, r4, r0
	ldrh r0, [r5, #0x74]
	bl WSetBeaconType
	orr r4, r4, r0
	ldrh r0, [r5, #0x76]
	bl WSetBcSsidResponse
	orr r4, r4, r0
	ldrh r0, [r5, #0x78]
	bl WSetBeaconLostThreshold
	orr r4, r4, r0
	ldrh r0, [r5, #0x7a]
	mov r1, #0
	bl WSetActiveZoneTime
	orr r4, r4, r0
	add r0, r5, #0x7c
	bl WSetSsidMask
	orr r4, r4, r0
	ldrh r0, [r5, #0x9c]
	bl WSetPreambleType
	orr r4, r4, r0
	ldrh r0, [r5, #0x9e]
	bl WSetAuthAlgo
	orr r0, r4, r0
_027EF440:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027EF44C: .word 0x0380FFF4
	arm_func_end PARAMSET_AllReqCmd

	arm_func_start DEV_TestRxReqCmd
DEV_TestRxReqCmd: // 0x027EF450
	stmdb sp!, {r4, lr}
	ldr r2, _027EF4FC // =0x0380FFF4
	ldr r2, [r2, #0]
	add r4, r2, #0x344
	mov r3, #1
	strh r3, [r1, #2]
	ldrh r2, [r4, #8]
	and r1, r2, #0xf0
	cmp r1, #0x10
	movne r0, r3
	bne _027EF4F4
	ldrh r1, [r0, #0x10]
	cmp r1, #0
	beq _027EF4C8
	cmp r1, #1
	bne _027EF4F0
	cmp r2, #0x10
	movne r0, r3
	bne _027EF4F4
	ldrh r0, [r0, #0x12]
	mov r1, r3
	bl WSetChannel
	mov r0, #0
	strh r0, [r4, #0xc]
	bl WStart
	mov r0, #0x8000
	bl WSetForcePowerState
	mov r0, #0x11
	strh r0, [r4, #8]
	b _027EF4F0
_027EF4C8:
	cmp r2, #0x11
	bne _027EF4E0
	mov r0, #0
	bl WSetForcePowerState
	bl WStop
	b _027EF4E8
_027EF4E0:
	mov r0, r3
	b _027EF4F4
_027EF4E8:
	mov r0, #0x10
	strh r0, [r4, #8]
_027EF4F0:
	mov r0, #0
_027EF4F4:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EF4FC: .word 0x0380FFF4
	arm_func_end DEV_TestRxReqCmd

	arm_func_start IntrCarrierSuppresionSignal
IntrCarrierSuppresionSignal: // 0x027EF500
	ldr r0, _027EF580 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x5c]
	cmp r0, #0
	beq _027EF53C
	mov r1, #0
	ldr r0, _027EF584 // =0x04804000
	strh r1, [r0]
	strh r1, [r0, #4]
	ldr r1, _027EF588 // =0x048080A0
	ldrh r0, [r1, #0]
	orr r0, r0, #0x8000
	strh r0, [r1]
	bx lr
_027EF53C:
	mov r1, #1
	ldr r0, _027EF58C // =0x048080AC
	strh r1, [r0]
	mov r2, #0
	ldr r0, _027EF590 // =0x04808004
	strh r2, [r0]
	mov r1, #2
	ldr r0, _027EF594 // =0x04808012
	strh r1, [r0]
	ldr r1, _027EF598 // =0x0000FFFF
	ldr r0, _027EF59C // =0x04808010
	strh r1, [r0]
	ldr r0, _027EF5A0 // =0x04808194
	strh r2, [r0]
	ldr r0, _027EF5A4 // =0x04808040
	strh r2, [r0]
	bx lr
	.align 2, 0
_027EF580: .word 0x0380FFF4
_027EF584: .word 0x04804000
_027EF588: .word 0x048080A0
_027EF58C: .word 0x048080AC
_027EF590: .word 0x04808004
_027EF594: .word 0x04808012
_027EF598: .word 0x0000FFFF
_027EF59C: .word 0x04808010
_027EF5A0: .word 0x04808194
_027EF5A4: .word 0x04808040
	arm_func_end IntrCarrierSuppresionSignal

	arm_func_start CarrierSuppresionSignal
CarrierSuppresionSignal: // 0x027EF5A8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _027EF6C0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r4, r0, #0x344
	bl WStart
	bl WStop
	mov r0, #6
	bl BBP_Read
	strh r0, [r4, #0xac]
	ldrh r0, [r5, #0x12]
	cmp r0, #4
	bne _027EF5EC
	mov r0, #6
	mov r1, #0
	bl BBP_Write
_027EF5EC:
	mov r0, #0
	ldr r1, _027EF6C4 // =0x04804000
	mov r2, #0xc
	bl MIi_CpuClear16
	mov r0, #0x14
	ldr r1, _027EF6C4 // =0x04804000
	strh r0, [r1, #8]
	mov r0, #0x7d0
	strh r0, [r1, #0xa]
	add r2, r1, #0xc
	mov r3, #0
	ldr r1, _027EF6C8 // =0x00005555
	ldr r0, _027EF6CC // =0x000007EC
_027EF620:
	strh r1, [r2], #2
	add r3, r3, #2
	cmp r3, r0
	blo _027EF620
	mov r1, #8
	ldr r0, _027EF6C4 // =0x04804000
	strh r1, [r0, #0xc]
	mov r1, #6
	ldr r0, _027EF6D0 // =0x04808194
	strh r1, [r0]
	mov r0, #0x12
	strh r0, [r4, #8]
	mov r1, #1
	strh r1, [r4, #0x18]
	ldrh r0, [r5, #0x16]
	bl WSetChannel
	mov r1, #0x8000
	ldr r0, _027EF6D4 // =0x04808040
	strh r1, [r0]
	ldr r0, _027EF6D8 // =0x000005DC
	bl WWaitus
	mov r1, #2
	ldr r0, _027EF6DC // =0x04808012
	strh r1, [r0]
	mov r1, #1
	ldr r0, _027EF6E0 // =0x04808004
	strh r1, [r0]
	ldr r0, _027EF6E4 // =0x048080AE
	strh r1, [r0]
	ldr r1, _027EF6C4 // =0x04804000
	ldr r0, _027EF6E8 // =0x00003FFF
	and r0, r1, r0
	mov r0, r0, lsl #0xf
	mov r0, r0, lsr #0x10
	orr r1, r0, #0x8000
	ldr r0, _027EF6EC // =0x048080A0
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027EF6C0: .word 0x0380FFF4
_027EF6C4: .word 0x04804000
_027EF6C8: .word 0x00005555
_027EF6CC: .word 0x000007EC
_027EF6D0: .word 0x04808194
_027EF6D4: .word 0x04808040
_027EF6D8: .word 0x000005DC
_027EF6DC: .word 0x04808012
_027EF6E0: .word 0x04808004
_027EF6E4: .word 0x048080AE
_027EF6E8: .word 0x00003FFF
_027EF6EC: .word 0x048080A0
	arm_func_end CarrierSuppresionSignal

	arm_func_start DEV_TestSignalReqCmd
DEV_TestSignalReqCmd: // 0x027EF6F0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r0, _027EF940 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r4, r0, #0x344
	mov r0, #1
	strh r0, [r1, #2]
	ldrh r1, [r4, #8]
	and r1, r1, #0xf0
	cmp r1, #0x10
	bne _027EF934
	ldrh r0, [r5, #0x10]
	cmp r0, #1
	movhi r0, #5
	bhi _027EF934
	ldrh r0, [r5, #0x14]
	cmp r0, #0xa
	beq _027EF748
	cmp r0, #0x14
	movne r0, #5
	bne _027EF934
_027EF748:
	ldrh r0, [r5, #0x12]
	cmp r0, #4
	movhi r0, #5
	bhi _027EF934
	mov r0, #0
	bl FLASH_VerifyCheckSum
	cmp r0, #0
	movne r0, #0xe
	bne _027EF934
	ldrh r0, [r5, #0x10]
	cmp r0, #0
	beq _027EF8A0
	cmp r0, #1
	bne _027EF930
	ldrh r0, [r4, #8]
	cmp r0, #0x10
	movne r0, #1
	bne _027EF934
	mov r0, #0
	str r0, [sp]
	mov r0, #0x65
	mov r1, #1
	add r2, sp, #0
	bl FLASH_DirectRead
	ldr r6, [sp]
	mov r0, #1
	bl BBP_Read
	cmp r6, r0
	beq _027EF7D0
	mov r0, #1
	mov r1, r6
	bl BBP_Write
	ldr r0, _027EF944 // =0x00001388
	bl WWaitus
_027EF7D0:
	ldrh r0, [r5, #0x12]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _027EF930
_027EF7E0: // jump table
	b _027EF7F4 // case 0
	b _027EF7F4 // case 1
	b _027EF7F4 // case 2
	b _027EF894 // case 3
	b _027EF894 // case 4
_027EF7F4:
	mov r0, #0x11
	strh r0, [r4, #8]
	ldrh r0, [r5, #0x16]
	mov r1, #1
	bl WSetChannel
	mov r1, #0x8000
	ldr r0, _027EF948 // =0x04808040
	strh r1, [r0]
	ldr r0, _027EF94C // =0x000005DC
	bl WWaitus
	ldrh r0, [r5, #0x14]
	strh r0, [r4, #0x16]
	mov r0, #2
	bl BBP_Read
	str r0, [sp]
	ldrh r1, [r5, #0x12]
	cmp r1, #1
	orrls r0, r0, #0x10
	strls r0, [sp]
	ldrh r1, [r5, #0x14]
	ldr r0, _027EF950 // =0x048081A4
	strh r1, [r0]
	ldrh r1, [r5, #0x12]
	cmp r1, #1
	ldrne r0, _027EF954 // =0x048081A2
	strneh r1, [r0]
	bne _027EF878
	ldr r0, [sp]
	orr r0, r0, #0x20
	str r0, [sp]
	mov r1, #3
	ldr r0, _027EF954 // =0x048081A2
	strh r1, [r0]
_027EF878:
	mov r0, #2
	ldr r1, [sp]
	bl BBP_Write
	ldr r1, _027EF958 // =0x00000823
	ldr r0, _027EF95C // =0x048081A0
	strh r1, [r0]
	b _027EF930
_027EF894:
	mov r0, r5
	bl CarrierSuppresionSignal
	b _027EF930
_027EF8A0:
	ldrh r0, [r4, #8]
	cmp r0, #0x11
	bne _027EF8F0
	bl ClearPeriodicTimeOut
	mov r2, #0
	ldr r0, _027EF95C // =0x048081A0
	strh r2, [r0]
	mov r1, #1
	ldr r0, _027EF954 // =0x048081A2
	strh r1, [r0]
	ldr r0, _027EF948 // =0x04808040
	strh r2, [r0]
	mov r0, #2
	bl BBP_Read
	str r0, [sp]
	bic r1, r0, #0x30
	str r1, [sp]
	mov r0, #2
	bl BBP_Write
	b _027EF928
_027EF8F0:
	cmp r0, #0x12
	bne _027EF920
	mov r0, #0
	strh r0, [r4, #0x18]
	ldr r1, _027EF960 // =0x04808004
_027EF904:
	ldrh r0, [r1, #0]
	cmp r0, #0
	bne _027EF904
	mov r0, #6
	ldrh r1, [r4, #0xac]
	bl BBP_Write
	b _027EF928
_027EF920:
	mov r0, #1
	b _027EF934
_027EF928:
	mov r0, #0x10
	strh r0, [r4, #8]
_027EF930:
	mov r0, #0
_027EF934:
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027EF940: .word 0x0380FFF4
_027EF944: .word 0x00001388
_027EF948: .word 0x04808040
_027EF94C: .word 0x000005DC
_027EF950: .word 0x048081A4
_027EF954: .word 0x048081A2
_027EF958: .word 0x00000823
_027EF95C: .word 0x048081A0
_027EF960: .word 0x04808004
	arm_func_end DEV_TestSignalReqCmd

	arm_func_start DEV_GetStateReqCmd
DEV_GetStateReqCmd: // 0x027EF964
	mov r0, #2
	strh r0, [r1, #2]
	ldr r0, _027EF988 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x4c]
	strh r0, [r1, #6]
	mov r0, #0
	bx lr
	.align 2, 0
_027EF988: .word 0x0380FFF4
	arm_func_end DEV_GetStateReqCmd

	arm_func_start DEV_GetWlInfoReqCmd
DEV_GetWlInfoReqCmd: // 0x027EF98C
	stmdb sp!, {r4, lr}
	mov r4, r1
	ldr r0, _027EF9E4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x4c]
	cmp r0, #0
	moveq r0, #1
	beq _027EF9DC
	mov r0, #0x5c
	strh r0, [r4, #2]
	bl WUpdateCounter
	ldr r0, _027EF9E4 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027EF9E8 // =0x0000053C
	add r0, r1, r0
	add r1, r4, #8
	mov r2, #0xb4
	bl MIi_CpuCopy32
	mov r0, #0
_027EF9DC:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EF9E4: .word 0x0380FFF4
_027EF9E8: .word 0x0000053C
	arm_func_end DEV_GetWlInfoReqCmd

	arm_func_start DEV_GetVerInfoReqCmd
DEV_GetVerInfoReqCmd: // 0x027EF9EC
	stmdb sp!, {r4, lr}
	mov r4, r1
	mov r0, #9
	strh r0, [r4, #2]
	ldr r0, _027EFA88 // =wlVersion_3529
	add r1, r4, #6
	mov r2, #8
	bl MIi_CpuCopy16
	ldr r0, _027EFA8C // =0x04808000
	ldrh r0, [r0, #0]
	strh r0, [r4, #0xe]
	ldr r0, _027EFA90 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #0x8000
	moveq r0, #0x6d
	streqh r0, [r4, #0x10]
	ldreq r0, _027EFA94 // =0x0000933D
	streqh r0, [r4, #0x12]
	beq _027EFA54
	mov r0, #0
	bl BBP_Read
	strh r0, [r4, #0x10]
	bl CalcBbpCRC
	strh r0, [r4, #0x12]
_027EFA54:
	ldr r0, _027EFA90 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r0, r1, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #0x4000
	addne r0, r1, #0x500
	ldrneh r0, [r0, #0xf8]
	strneh r0, [r4, #0x14]
	moveq r0, #2
	streqh r0, [r4, #0x14]
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EFA88: .word wlVersion_3529
_027EFA8C: .word 0x04808000
_027EFA90: .word 0x0380FFF4
_027EFA94: .word 0x0000933D
	arm_func_end DEV_GetVerInfoReqCmd

	arm_func_start DEV_ClearWlInfoReqCmd
DEV_ClearWlInfoReqCmd: // 0x027EFA98
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027EFAD8 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x4c]
	cmp r0, #0
	moveq r0, #1
	beq _027EFACC
	mov r0, #1
	strh r0, [r1, #2]
	bl WInitCounter
	mov r0, #0
_027EFACC:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EFAD8: .word 0x0380FFF4
	arm_func_end DEV_ClearWlInfoReqCmd

	arm_func_start DEV_RebootReqCmd
DEV_RebootReqCmd: // 0x027EFADC
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	strh r0, [r1, #2]
	ldr r0, _027EFB1C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x4c]
	cmp r0, #0x20
	blo _027EFB08
	bl WStop
_027EFB08:
	bl WlessLibReboot
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EFB1C: .word 0x0380FFF4
	arm_func_end DEV_RebootReqCmd

	arm_func_start DEV_Class1ReqCmd
DEV_Class1ReqCmd: // 0x027EFB20
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	strh r0, [r1, #2]
	ldr r0, _027EFB7C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r1, [r0, #0x4c]
	cmp r1, #0x10
	beq _027EFB5C
	cmp r1, #0x20
	bne _027EFB6C
	ldrh r0, [r0, #0x56]
	cmp r0, #0
	bne _027EFB6C
_027EFB5C:
	mov r0, #0x20
	bl WSetStaState
	mov r0, #0
	b _027EFB70
_027EFB6C:
	mov r0, #1
_027EFB70:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EFB7C: .word 0x0380FFF4
	arm_func_end DEV_Class1ReqCmd

	arm_func_start DEV_IdleReqCmd
DEV_IdleReqCmd: // 0x027EFB80
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	strh r0, [r1, #2]
	ldr r1, _027EFBE0 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r2, [r1, #0x4c]
	cmp r2, #0x20
	bhi _027EFBD4
	ldrh r1, [r1, #0x56]
	cmp r1, #0
	bne _027EFBD4
	mov r0, #0
	bl FLASH_VerifyCheckSum
	cmp r0, #0
	movne r0, #0xe
	bne _027EFBD4
	mov r0, #0x10
	bl WSetStaState
	mov r0, #0
_027EFBD4:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EFBE0: .word 0x0380FFF4
	arm_func_end DEV_IdleReqCmd

	arm_func_start DEV_ShutdownReqCmd
DEV_ShutdownReqCmd: // 0x027EFBE4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #1
	strh r0, [r1, #2]
	ldr r1, _027EFC2C // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0x4c]
	cmp r1, #0
	beq _027EFC14
	cmp r1, #0x10
	bne _027EFC20
_027EFC14:
	mov r0, #0
	bl WSetStaState
	mov r0, #0
_027EFC20:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027EFC2C: .word 0x0380FFF4
	arm_func_end DEV_ShutdownReqCmd

	arm_func_start IssueMaDataConfirm
IssueMaDataConfirm: // 0x027EFC30
	ldrh r2, [r1, #0xe]
	add r2, r1, r2, lsl #1
	add r3, r2, #0x10
	ldrh r2, [r2, #0x10]
	strh r2, [r1, #0xc]
	mov r2, #2
	strh r2, [r3, #2]
	mov r2, #0
	strh r2, [r3, #4]
	ldrh r2, [r1, #0x18]
	strh r2, [r3, #6]
	ldr ip, _027EFC64 // =SendMessageToWmDirect
	bx ip
	.align 2, 0
_027EFC64: .word SendMessageToWmDirect
	arm_func_end IssueMaDataConfirm

	arm_func_start MA_ClrDataReqCmd
MA_ClrDataReqCmd: // 0x027EFC68
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	strh r0, [r1, #2]
	ldrh r0, [r4, #0x10]
	ands r0, r0, #1
	beq _027EFC88
	bl ClearTxKeyData
_027EFC88:
	ldrh r0, [r4, #0x10]
	ands r0, r0, #2
	beq _027EFC98
	bl ClearTxMp
_027EFC98:
	ldrh r0, [r4, #0x10]
	ands r0, r0, #4
	beq _027EFCA8
	bl ClearTxData
_027EFCA8:
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end MA_ClrDataReqCmd

	arm_func_start MA_TestDataReqCmd
MA_TestDataReqCmd: // 0x027EFCB4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	strh r0, [r1, #2]
	ldr r0, _027EFD10 // =0x0000FFFF
	strh r0, [r4, #0xc]
	add r0, r4, #0x10
	mov r1, #0
	strh r1, [r0, #2]
	ldrh r1, [r0, #6]
	strh r1, [r0, #0x12]
	bl CAM_IncFrameCount
	ldr r0, _027EFD14 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r0, r1, #0x200
	add r1, r1, #0x194
	mov r2, r4
	bl MoveHeapBuf
	mov r0, #0
	bl TxqPri
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027EFD10: .word 0x0000FFFF
_027EFD14: .word 0x0380FFF4
	arm_func_end MA_TestDataReqCmd

	arm_func_start MA_MpReqCmd
MA_MpReqCmd: // 0x027EFD18
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r0, _027F01D4 // =0x0380FFF4
	ldr r2, [r0, #0]
	add r0, r2, #0x344
	str r0, [sp]
	add r7, r2, #0x31c
	add r10, r2, #0x17c
	ldr r0, _027F01D8 // =0x0000042C
	add r9, r2, r0
	add r0, r2, #0x600
	ldrh r8, [r0, #0x90]
	mov r0, #1
	str r0, [sp, #4]
	strh r0, [r1, #2]
	ldrh r0, [r7, #0x12]
	cmp r0, #1
	movne r0, #0xb
	bne _027F01C8
	ldrh r0, [r9, #0x3c]
	cmp r0, #0
	movne r0, #8
	bne _027F01C8
	ldr r4, [r9, #0x44]
	ldrh r1, [r5, #0x10]
	ands r0, r1, #0x8000
	beq _027EFDCC
	ands r0, r1, #2
	ldreqh r0, [r9, #0x94]
	streqh r0, [r5, #0x14]
	ldrh r0, [r5, #0x10]
	ands r0, r0, #4
	ldreqh r0, [r9, #0xa0]
	streqh r0, [r5, #0x16]
	ldrh r0, [r5, #0x10]
	ands r0, r0, #8
	ldreqh r0, [r9, #0x96]
	streqh r0, [r5, #0x18]
	ldrh r0, [r5, #0x10]
	ands r0, r0, #0x10
	ldreqh r0, [r9, #0x9c]
	streqh r0, [r5, #0x1c]
	moveq r0, #0
	streq r0, [sp, #4]
_027EFDCC:
	ldrh r0, [r5, #0x1c]
	cmp r0, #0x204
	movhi r0, #5
	bhi _027F01C8
	mov r1, #2
	mov r6, #0
	b _027EFDFC
_027EFDE8:
	ldrh r0, [r5, #0x16]
	ands r0, r0, r1
	addne r6, r6, #1
	mov r0, r1, lsl #0x11
	mov r1, r0, lsr #0x10
_027EFDFC:
	cmp r1, #0
	bne _027EFDE8
	ldrh r0, [r5, #0x14]
	strh r0, [r9, #0x94]
	ldrh r2, [r5, #0x14]
	ands r0, r2, #0x8000
	beq _027EFE48
	ldr r0, _027F01DC // =0x00007FFF
	and r0, r2, r0
	strh r0, [r5, #0x14]
	ldrh r0, [r5, #0x14]
	sub r0, r0, #0xd0
	mov r2, r0, lsr #2
	mov r0, #0xea
	strh r0, [r4, #0xe]
	cmp r2, #0x10000
	bls _027EFE94
	mov r0, #5
	b _027F01C8
_027EFE48:
	ands r0, r8, #2
	movne r11, #1
	movne r1, #2
	movne r0, #6
	moveq r11, #0
	moveq r1, r11
	moveq r0, r11
	add r2, r2, r11
	ldr r3, _027F01E0 // =0x00000206
	add r3, r11, r3
	cmp r2, r3
	movhi r0, #5
	bhi _027F01C8
	mov r3, r2, lsl #2
	add r3, r3, #0xd0
	add r1, r1, r3
	strh r1, [r5, #0x14]
	add r0, r0, #0xea
	strh r0, [r4, #0xe]
_027EFE94:
	add r0, r2, #9
	bic r11, r0, #1
	mul r0, r11, r6
	str r0, [sp, #8]
	add r0, r10, #0xc
	ldr r1, [sp, #8]
	add r1, r1, #0x1a
	bl AllocateHeapBuf
	str r0, [r9, #0x90]
	ldr r0, [r9, #0x90]
	cmp r0, #0
	moveq r0, #8
	beq _027F01C8
	mov r0, #1
	strh r0, [r9, #0x3c]
	ldrh r0, [r9, #0x3e]
	add r0, r0, #1
	strh r0, [r9, #0x3e]
	ldrh r0, [r5, #0x18]
	strh r0, [r9, #0x96]
	ldrh r0, [r5, #0x16]
	strh r0, [r9, #0x98]
	mov r1, #0
	strh r1, [r9, #0x9a]
	ldrh r0, [r5, #0x1c]
	strh r0, [r9, #0x9c]
	ldrh r0, [r5, #0x12]
	strh r0, [r9, #0x9e]
	strh r1, [r4]
	ldrh r0, [r5, #0x16]
	strh r0, [r4, #2]
	strh r1, [r4, #4]
	mov r0, #0x14
	strh r0, [r4, #8]
	ldrh r0, [r5, #0x1c]
	add r0, r0, #0x22
	strh r0, [r4, #0xa]
	mov r0, #0x228
	strh r0, [r4, #0xc]
	ldrh r1, [r4, #0xe]
	ldrh r0, [r5, #0x14]
	add r0, r0, #0xa
	mla r1, r0, r6, r1
	strh r1, [r4, #0xe]
	add r0, r4, #0x10
	ldr r1, _027F01E4 // =MP_ADRS
	ldr r2, [sp]
	add r2, r2, #0x64
	add r3, r7, #8
	bl WSetMacAdrs3
	ldrh r0, [r5, #0x10]
	ands r0, r0, #0x8000
	beq _027EFF7C
	ldrh r1, [r4, #0x22]
	ldr r0, _027F01E8 // =0x0000FFFF
	cmp r1, r0
	movne r7, #0x4000
	bne _027EFF88
_027EFF7C:
	mov r7, #0
	ldr r0, _027F01E8 // =0x0000FFFF
	strh r0, [r4, #0x22]
_027EFF88:
	ldrh r0, [r5, #0x14]
	strh r0, [r4, #0x24]
	ldrh r0, [r5, #0x16]
	strh r0, [r4, #0x26]
	ldrh r0, [r5, #0x1e]
	strh r0, [r4, #0x28]
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _027EFFCC
	ldrh r0, [r5, #0x1c]
	cmp r0, #0
	beq _027EFFCC
	bl WUpdateCounter
	add r0, r4, #0x2a
	ldr r1, [r5, #0x20]
	ldrh r2, [r5, #0x1c]
	bl DMA_Write
_027EFFCC:
	ands r0, r8, #4
	beq _027EFFFC
	add r1, r4, #0x28
	ldrh r0, [r5, #0x1c]
	add r0, r0, #2
	add r0, r1, r0
	add r0, r0, #3
	bic r1, r0, #3
	ldr r0, _027F01EC // =0x0000B6B8
	strh r0, [r1]
	ldr r0, _027F01F0 // =0x00001D46
	strh r0, [r1, #2]
_027EFFFC:
	mov r1, #0x184
	ldr r0, [r9, #0x90]
	strh r1, [r0, #0xc]
	ldr r0, [sp, #8]
	add r0, r0, #0xb
	mov r1, r0, lsr #1
	ldr r0, [r9, #0x90]
	strh r1, [r0, #0xe]
	ldrh r1, [r5, #0x16]
	ldr r0, [r9, #0x90]
	strh r1, [r0, #0x10]
	ldr r0, [r9, #0x90]
	strh r6, [r0, #0x14]
	ldr r0, [r9, #0x90]
	strh r11, [r0, #0x16]
	mov r0, #0
	ldr r1, [r9, #0x90]
	strh r0, [r1, #0x18]
	ldr r1, [r9, #0x90]
	add r3, r1, #0x1a
	mov r2, #1
	mov r1, #2
	ldr r8, _027F01E8 // =0x0000FFFF
	b _027F0084
_027F005C:
	ldrh ip, [r5, #0x16]
	ands ip, ip, r1
	strneh r8, [r3]
	strneh r0, [r3, #2]
	strneh r0, [r3, #6]
	strneh r2, [r3, #4]
	addne r3, r3, r11
	mov r1, r1, lsl #0x11
	mov r1, r1, lsr #0x10
	add r2, r2, #1
_027F0084:
	cmp r1, #0
	bne _027F005C
	ldrh r1, [r5, #0x14]
	ldr r0, _027F01F4 // =0x048080C4
	strh r1, [r0]
	ldrh r1, [r4, #0xe]
	ldr r0, _027F01F8 // =0x048080C0
	strh r1, [r0]
	ldrh r0, [r5, #0x1a]
	rsb r8, r0, #0x10000
	ldrh r0, [r5, #0x18]
	cmp r0, #0
	bne _027F0128
	ldrh r0, [r5, #0x1c]
	add r0, r0, #0x22
	mov r0, r0, lsl #2
	add r2, r0, #0x60
	ldr r0, _027F01FC // =0x04808000
	ldrh r0, [r0, #0]
	cmp r0, #0x1440
	addne r2, r2, #0x3e8
	ldrh r0, [r5, #0x14]
	mul r1, r0, r6
	add r0, r1, #0x388
	add r0, r2, r0
	add r0, r0, #0x32
	mov r1, #0xa
	bl _u32_div_f
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _027F0200 // =0x04808118
	strh r5, [r1]
	ldr r1, _027F0204 // =0x00003FFF
	and r1, r4, r1
	mov r1, r1, lsr #1
	orr r1, r1, #0x8000
	orr r2, r1, r7
	ldr r1, _027F0208 // =0x04808090
	strh r2, [r1]
	bl OS_RestoreInterrupts
	b _027F01C4
_027F0128:
	bl OS_DisableInterrupts
	mov r6, r0
	ldr r0, _027F020C // =0x048080F8
	ldrh r0, [r0, #0]
	add r1, r8, r0
	ldr r0, _027F01E8 // =0x0000FFFF
	and r0, r1, r0
	mov r1, #0xa
	bl _u32_div_f
	ldrh r2, [r5, #0x18]
	add r1, r0, #3
	cmp r1, r2
	bhs _027F0194
	sub r0, r2, r0
	sub r1, r0, #1
	ldr r0, _027F0200 // =0x04808118
	strh r1, [r0]
	ldr r0, _027F0204 // =0x00003FFF
	and r0, r4, r0
	mov r0, r0, lsr #1
	orr r0, r0, #0x8000
	orr r1, r0, r7
	ldr r0, _027F0208 // =0x04808090
	strh r1, [r0]
	mov r0, r6
	bl OS_RestoreInterrupts
	b _027F01C4
_027F0194:
	mov r0, r6
	bl OS_RestoreInterrupts
	add r0, r10, #0xc
	ldr r1, [r9, #0x90]
	bl ReleaseHeapBuf
	mov r0, #0
	strh r0, [r9, #0x3c]
	ldrh r0, [r9, #0x3e]
	sub r0, r0, #1
	strh r0, [r9, #0x3e]
	mov r0, #5
	b _027F01C8
_027F01C4:
	mov r0, #0
_027F01C8:
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F01D4: .word 0x0380FFF4
_027F01D8: .word 0x0000042C
_027F01DC: .word 0x00007FFF
_027F01E0: .word 0x00000206
_027F01E4: .word MP_ADRS
_027F01E8: .word 0x0000FFFF
_027F01EC: .word 0x0000B6B8
_027F01F0: .word 0x00001D46
_027F01F4: .word 0x048080C4
_027F01F8: .word 0x048080C0
_027F01FC: .word 0x04808000
_027F0200: .word 0x04808118
_027F0204: .word 0x00003FFF
_027F0208: .word 0x04808090
_027F020C: .word 0x048080F8
	arm_func_end MA_MpReqCmd

	arm_func_start MA_KeyDataReqCmd
MA_KeyDataReqCmd: // 0x027F0210
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	ldr r0, _027F0398 // =0x0380FFF4
	ldr r3, [r0, #0]
	add r2, r3, #0x344
	add r8, r3, #0x31c
	ldr r0, _027F039C // =0x0000042C
	add r7, r3, r0
	add r0, r3, #0x600
	ldrh r6, [r0, #0x90]
	mov r9, #1
	strh r9, [r1, #2]
	ldrh r0, [r8, #0x12]
	cmp r0, #2
	movne r0, #0xb
	bne _027F038C
	ldrh r0, [r10, #0x10]
	cmp r0, #0x204
	movhi r0, #5
	bhi _027F038C
	ldrh r0, [r7, #0x50]
	cmp r0, #0
	moveq r9, #0
	mov r0, #0x14
	mul r4, r9, r0
	add r1, r7, #0x50
	add r11, r1, r4
	ldrh r1, [r1, r4]
	cmp r1, #0
	movne r0, #8
	bne _027F038C
	ldr r1, _027F03A0 // =0x04808094
	ldrh r1, [r1, #0]
	ands r1, r1, #0x8000
	movne r0, #8
	bne _027F038C
	add r1, r7, r4
	ldr r5, [r1, #0x58]
	mov r1, #0
	strh r1, [r5]
	strh r1, [r5, #4]
	strh r0, [r5, #8]
	ldrh r0, [r10, #0x10]
	add r0, r0, #0x1e
	strh r0, [r5, #0xa]
	mov r0, #0x118
	strh r0, [r5, #0xc]
	add r0, r5, #0x10
	add r1, r2, #0x64
	add r2, r8, #8
	ldr r3, _027F03A4 // =MPKEY_ADRS
	bl WSetMacAdrs3
	ldrh r0, [r10, #0x12]
	strh r0, [r5, #0x24]
	ldrh r0, [r10, #0x10]
	cmp r0, #0
	beq _027F0314
	cmp r9, #0
	bne _027F0304
	bl WUpdateCounter
_027F0304:
	add r0, r5, #0x26
	ldr r1, [r10, #0x14]
	ldrh r2, [r10, #0x10]
	bl DMA_Write
_027F0314:
	ands r0, r6, #4
	beq _027F0344
	add r1, r5, #0x24
	ldrh r0, [r10, #0x10]
	add r0, r0, #2
	add r0, r1, r0
	add r0, r0, #3
	bic r1, r0, #3
	ldr r0, _027F03A8 // =0x0000B6B8
	strh r0, [r1]
	ldr r0, _027F03AC // =0x00001D46
	strh r0, [r1, #2]
_027F0344:
	mov r0, #1
	strh r0, [r11]
	add r1, r7, #0x52
	ldrh r0, [r1, r4]
	add r0, r0, #1
	strh r0, [r1, r4]
	ldr r0, _027F03B0 // =0x00003FFF
	and r0, r5, r0
	mov r0, r0, lsr #1
	orr r1, r0, #0x8000
	ldr r0, _027F03A0 // =0x04808094
	strh r1, [r0]
	ldrh r0, [r8, #0x1e]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	bne _027F0388
	bl WSetKSID
_027F0388:
	mov r0, #0
_027F038C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F0398: .word 0x0380FFF4
_027F039C: .word 0x0000042C
_027F03A0: .word 0x04808094
_027F03A4: .word MPKEY_ADRS
_027F03A8: .word 0x0000B6B8
_027F03AC: .word 0x00001D46
_027F03B0: .word 0x00003FFF
	arm_func_end MA_KeyDataReqCmd

	arm_func_start MA_DataReqCmd
MA_DataReqCmd: // 0x027F03B4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r0, _027F0590 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r8, r0, #0x344
	add r7, r0, #0x31c
	add r6, r0, #0x17c
	add r5, r9, #0x10
	ldrh r1, [r9, #0x16]
	ldr r0, _027F0594 // =0x000005E4
	cmp r1, r0
	movhi r0, #5
	bhi _027F0584
	ldrh r0, [r7, #0x12]
	cmp r0, #1
	bne _027F0420
	add r0, r5, #0x18
	bl CAM_Search
	mov r4, r0
	cmp r4, #0xff
	beq _027F0418
	bl CAM_GetStaState
	cmp r0, #0x40
	beq _027F0424
_027F0418:
	mov r0, #0xa
	b _027F0584
_027F0420:
	ldrh r4, [r8, #0x88]
_027F0424:
	strh r4, [r5, #2]
	ldr r0, _027F0590 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x3ec]
	strh r0, [r5, #4]
	ldrh r1, [r5, #0xe]
	ands r0, r1, #0xff
	strneh r1, [r5, #0x10]
	movne r0, #0
	strneh r0, [r5, #0xe]
	bne _027F045C
	mov r0, r4
	bl CAM_GetTxRate
	strh r0, [r5, #0x10]
_027F045C:
	ldrh r0, [r5, #6]
	cmp r0, #0
	bne _027F0484
	ldrh r0, [r8, #0x8a]
	orr r0, r0, #0x40
	bic r0, r0, #0x4000
	strh r0, [r5, #0x14]
	mov r0, #0x1c
	strh r0, [r5, #0x12]
	b _027F04AC
_027F0484:
	ldrh r0, [r8, #0x8a]
	strh r0, [r5, #0x14]
	ldrh r0, [r7, #0x18]
	cmp r0, #0
	ldreqh r0, [r5, #6]
	addeq r0, r0, #0x1c
	streqh r0, [r5, #0x12]
	ldrneh r0, [r5, #6]
	addne r0, r0, #0x24
	strneh r0, [r5, #0x12]
_027F04AC:
	ldrh r0, [r7, #0x12]
	cmp r0, #1
	beq _027F04CC
	cmp r0, #2
	beq _027F0548
	cmp r0, #3
	beq _027F0548
	b _027F0580
_027F04CC:
	add r0, r5, #0x24
	add r1, r5, #0x1e
	bl WSetMacAdrs1
	add r0, r5, #0x1e
	add r1, r8, #0x64
	bl WSetMacAdrs1
	cmp r4, #0
	bne _027F0524
	add r0, r6, #0x84
	mov r1, r9
	bl CAM_AddBcFrame
	ldr r0, _027F0590 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r1, [r0, #0x2e]
	ldrh r0, [r0, #0x32]
	mvn r0, r0
	ands r0, r1, r0
	bne _027F0580
	mov r0, #2
	bl TxqPri
	b _027F0580
_027F0524:
	mov r0, r5
	bl CAM_IncFrameCount
	add r0, r6, #0x84
	add r1, r6, #0x18
	mov r2, r9
	bl MoveHeapBuf
	mov r0, #0
	bl TxqPri
	b _027F0580
_027F0548:
	add r0, r5, #0x24
	add r1, r5, #0x18
	bl WSetMacAdrs1
	add r0, r5, #0x18
	add r1, r8, #0x64
	bl WSetMacAdrs1
	mov r0, r5
	bl CAM_IncFrameCount
	add r0, r6, #0x84
	add r1, r6, #0x18
	mov r2, r9
	bl MoveHeapBuf
	mov r0, #0
	bl TxqPri
_027F0580:
	mov r0, #0x81
_027F0584:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027F0590: .word 0x0380FFF4
_027F0594: .word 0x000005E4
	arm_func_end MA_DataReqCmd

	arm_func_start SetGameInfoElement
SetGameInfoElement: // 0x027F0598
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	ldr r1, _027F06B4 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r6, r1, #0x344
	add r5, r1, #0x31c
	mov r4, #0
	mov r1, #0xdd
	bl WL_WriteByte
	add r0, r7, #1
	ldr r1, _027F06B4 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xe4]
	add r1, r1, #8
	and r1, r1, #0xff
	bl WL_WriteByte
	add r0, r7, #2
	mov r1, r4
	bl WL_WriteByte
	add r0, r7, #3
	mov r1, #9
	bl WL_WriteByte
	add r0, r7, #4
	mov r1, #0xbf
	bl WL_WriteByte
	add r0, r7, #5
	mov r1, r4
	bl WL_WriteByte
	add r0, r7, #6
	ldrh r1, [r5, #0x20]
	and r1, r1, #0xff
	bl WL_WriteByte
	add r0, r7, #7
	ldrh r1, [r5, #0x20]
	mov r1, r1, asr #8
	and r1, r1, #0xff
	bl WL_WriteByte
	ldr r0, _027F06B8 // =0x0380FFF0
	ldrh r5, [r0, #0]
	add r0, r7, #8
	and r1, r5, #0xff
	bl WL_WriteByte
	add r0, r7, #9
	mov r1, r5, lsr #8
	and r1, r1, #0xff
	bl WL_WriteByte
	add r4, r4, #0xa
	ldrh r0, [r6, #0xa0]
	cmp r0, #0
	beq _027F06A8
	ldr r5, [r6, #0x9c]
	ldrh r0, [r6, #0xa2]
	ands r0, r0, #1
	addne r5, r5, #1
	mov r8, #0
	b _027F069C
_027F067C:
	mov r0, r5
	bl WL_ReadByte
	mov r1, r0
	add r0, r7, r4
	bl WL_WriteByte
	add r4, r4, #1
	add r5, r5, #1
	add r8, r8, #1
_027F069C:
	ldrh r0, [r6, #0xa0]
	cmp r8, r0
	blo _027F067C
_027F06A8:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027F06B4: .word 0x0380FFF4
_027F06B8: .word 0x0380FFF0
	arm_func_end SetGameInfoElement

	arm_func_start SetDSParamSet
SetDSParamSet: // 0x027F06BC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #3
	bl WL_WriteByte
	add r0, r4, #1
	mov r1, #1
	bl WL_WriteByte
	add r0, r4, #2
	ldr r1, _027F0700 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x300
	ldrh r1, [r1, #0xbe]
	and r1, r1, #0xff
	bl WL_WriteByte
	mov r0, #3
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F0700: .word 0x0380FFF4
	arm_func_end SetDSParamSet

	arm_func_start SetSupRateSet
SetSupRateSet: // 0x027F0704
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r1, _027F07B4 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r8, r1, #0x344
	mov r7, #0
	mov r1, #1
	bl WL_WriteByte
	add r7, r7, #2
	mov r6, #0
	ldr r4, _027F07B8 // =RateBit2Element
	mov r5, #1
_027F0738:
	mov r1, r5, lsl r6
	ldrh r0, [r8, #0x62]
	ands r0, r0, r1
	beq _027F0788
	ldrh r0, [r8, #0x60]
	ands r0, r0, r1
	beq _027F0770
	add r0, r9, r7
	mov r1, r6, lsl #1
	ldrh r1, [r4, r1]
	orr r1, r1, #0x80
	and r1, r1, #0xff
	bl WL_WriteByte
	b _027F0784
_027F0770:
	add r0, r9, r7
	mov r1, r6, lsl #1
	ldrh r1, [r4, r1]
	and r1, r1, #0xff
	bl WL_WriteByte
_027F0784:
	add r7, r7, #1
_027F0788:
	add r6, r6, #1
	cmp r6, #0x10
	blo _027F0738
	add r0, r9, #1
	sub r1, r7, #2
	and r1, r1, #0xff
	bl WL_WriteByte
	mov r0, r7
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027F07B4: .word 0x0380FFF4
_027F07B8: .word RateBit2Element
	arm_func_end SetSupRateSet

	arm_func_start SetSSIDElement
SetSSIDElement: // 0x027F07BC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	ldr r1, _027F082C // =0x0380FFF4
	ldr r1, [r1, #0]
	add r5, r1, #0x344
	mov r8, #0
	ldrh r7, [r5, #0x1e]
	mov r1, r8
	bl WL_WriteByte
	add r0, r4, #1
	and r1, r7, #0xff
	bl WL_WriteByte
	add r8, r8, #2
	mov r6, #0
	add r5, r5, #0x20
	b _027F0818
_027F07FC:
	add r0, r5, r6
	bl WL_ReadByte
	mov r1, r0
	add r0, r4, r8
	bl WL_WriteByte
	add r8, r8, #1
	add r6, r6, #1
_027F0818:
	cmp r6, r7
	blo _027F07FC
	mov r0, r8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027F082C: .word 0x0380FFF4
	arm_func_end SetSSIDElement

	arm_func_start IsExistManFrame
IsExistManFrame: // 0x027F0830
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldr r0, _027F08A0 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r7, [r0, #0x1a0]
	mvn r6, #0
	b _027F0888
_027F0854:
	add r1, r7, #0x10
	ldrh r0, [r1, #0x14]
	cmp r0, r4
	bne _027F087C
	add r0, r1, #0x18
	mov r1, r5
	bl MatchMacAdrs
	cmp r0, #0
	movne r0, #1
	bne _027F0894
_027F087C:
	mov r0, r7
	bl GetHeapBufNextAdrs
	mov r7, r0
_027F0888:
	cmp r7, r6
	bne _027F0854
	mov r0, #0
_027F0894:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027F08A0: .word 0x0380FFF4
	arm_func_end IsExistManFrame

	arm_func_start InitManHeader
InitManHeader: // 0x027F08A4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r0, #0
	mov r1, r5
	mov r2, #0x2c
	bl MIi_CpuClear16
	bl WCalcManRate
	strh r0, [r5, #0x10]
	ldr r0, _027F08F4 // =0x0380FFF4
	ldr r3, [r0, #0]
	add r0, r5, #0x18
	mov r1, r4
	add r2, r3, #0x324
	add r3, r3, #0x3a8
	bl WSetMacAdrs3
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F08F4: .word 0x0380FFF4
	arm_func_end InitManHeader

	arm_func_start MakePsPollFrame
MakePsPollFrame: // 0x027F08F8
	ldr r2, _027F0944 // =0x0380FFF4
	ldr r1, [r2, #0]
	ldr r3, [r1, #0x45c]
	mov r1, #0
	strh r1, [r3]
	strh r1, [r3, #2]
	strh r1, [r3, #4]
	mov r1, #0x14
	strh r1, [r3, #0xa]
	mov r1, #0xa4
	strh r1, [r3, #0xc]
	orr r0, r0, #0xc000
	strh r0, [r3, #0xe]
	ldr r2, [r2, #0]
	add r0, r3, #0x10
	add r1, r2, #0x3a8
	add r2, r2, #0x324
	ldr ip, _027F0948 // =WSetMacAdrs2
	bx ip
	.align 2, 0
_027F0944: .word 0x0380FFF4
_027F0948: .word WSetMacAdrs2
	arm_func_end MakePsPollFrame

	arm_func_start MakeDeAuthFrame
MakeDeAuthFrame: // 0x027F094C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	cmp r2, #0
	bne _027F0970
	bl IsEnableManagement
	cmp r0, #0
	moveq r0, #0
	beq _027F09D8
_027F0970:
	ldr r0, _027F09E0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x36
	bl AllocateHeapBuf
	movs r4, r0
	bne _027F099C
	mov r0, #2
	bl SetFatalErr
	mov r0, r4
	b _027F09D8
_027F099C:
	ldr r0, _027F09E4 // =0x0000FFFF
	strh r0, [r4, #0xc]
	add r4, r4, #0x10
	mov r0, r4
	mov r1, r6
	bl InitManHeader
	strh r5, [r4, #0x2c]
	mov r0, #2
	strh r0, [r4, #6]
	ldrh r0, [r4, #6]
	add r0, r0, #0x1c
	strh r0, [r4, #0x12]
	mov r0, #0xc0
	strh r0, [r4, #0x14]
	mov r0, r4
_027F09D8:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F09E0: .word 0x0380FFF4
_027F09E4: .word 0x0000FFFF
	arm_func_end MakeDeAuthFrame

	arm_func_start MakeAuthFrame
MakeAuthFrame: // 0x027F09E8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	cmp r2, #0
	beq _027F0A0C
	bl IsEnableManagement
	cmp r0, #0
	moveq r0, #0
	beq _027F0A9C
_027F0A0C:
	ldr r0, _027F0AA4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	add r1, r5, #0x3d
	bl AllocateHeapBuf
	movs r4, r0
	bne _027F0A38
	mov r0, #2
	bl SetFatalErr
	mov r0, r4
	b _027F0A9C
_027F0A38:
	ldr r0, _027F0AA8 // =0x0000FFFF
	strh r0, [r4, #0xc]
	add r4, r4, #0x10
	mov r0, r4
	mov r1, r6
	bl InitManHeader
	cmp r5, #0
	beq _027F0A7C
	add r0, r4, #0x32
	mov r1, #0x10
	bl WL_WriteByte
	add r0, r4, #0x33
	and r1, r5, #0xff
	bl WL_WriteByte
	add r0, r5, #2
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
_027F0A7C:
	add r0, r5, #6
	strh r0, [r4, #6]
	ldrh r0, [r4, #6]
	add r0, r0, #0x1c
	strh r0, [r4, #0x12]
	mov r0, #0xb0
	strh r0, [r4, #0x14]
	mov r0, r4
_027F0A9C:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F0AA4: .word 0x0380FFF4
_027F0AA8: .word 0x0000FFFF
	arm_func_end MakeAuthFrame

	arm_func_start MakeProbeResFrame
MakeProbeResFrame: // 0x027F0AAC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _027F0B8C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r5, r0, #0x344
	bl IsEnableManagement
	cmp r0, #0
	moveq r0, #0
	beq _027F0B84
	ldr r0, _027F0B8C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	ldrh r1, [r5, #0xa0]
	add r1, r1, #0x78
	bl AllocateHeapBuf
	movs r4, r0
	bne _027F0B00
	mov r0, #2
	bl SetFatalErr
	mov r0, r4
	b _027F0B84
_027F0B00:
	ldr r0, _027F0B90 // =0x0000FFFF
	strh r0, [r4, #0xc]
	add r4, r4, #0x10
	mov r0, r4
	mov r1, r6
	bl InitManHeader
	ldrh r0, [r5, #0x6e]
	strh r0, [r4, #0x34]
	ldrh r0, [r5, #0x7c]
	strh r0, [r4, #0x36]
	add r0, r4, #0x38
	bl SetSSIDElement
	mov r5, r0
	add r0, r4, #0x38
	add r0, r0, r5
	bl SetSupRateSet
	add r5, r5, r0
	add r0, r4, #0x38
	add r0, r0, r5
	bl SetDSParamSet
	add r5, r5, r0
	add r0, r4, #0x38
	add r0, r0, r5
	bl SetGameInfoElement
	add r0, r5, r0
	add r0, r0, #0xc
	strh r0, [r4, #6]
	ldrh r0, [r4, #6]
	add r0, r0, #0x1c
	strh r0, [r4, #0x12]
	mov r0, #0x50
	strh r0, [r4, #0x14]
	mov r0, r4
_027F0B84:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F0B8C: .word 0x0380FFF4
_027F0B90: .word 0x0000FFFF
	arm_func_end MakeProbeResFrame

	arm_func_start MakeProbeReqFrame
MakeProbeReqFrame: // 0x027F0B94
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _027F0C1C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x5a
	bl AllocateHeapBuf
	movs r4, r0
	bne _027F0BC8
	mov r0, #2
	bl SetFatalErr
	mov r0, r4
	b _027F0C14
_027F0BC8:
	ldr r0, _027F0C20 // =0x0000FFFF
	strh r0, [r4, #0xc]
	add r5, r4, #0x10
	mov r0, r5
	mov r1, r6
	bl InitManHeader
	add r0, r5, #0x2c
	bl SetSSIDElement
	mov r4, r0
	add r0, r5, #0x2c
	add r0, r0, r4
	bl SetSupRateSet
	add r0, r4, r0
	strh r0, [r5, #6]
	add r0, r0, #0x1c
	strh r0, [r5, #0x12]
	mov r0, #0x40
	strh r0, [r5, #0x14]
	mov r0, r5
_027F0C14:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F0C1C: .word 0x0380FFF4
_027F0C20: .word 0x0000FFFF
	arm_func_end MakeProbeReqFrame

	arm_func_start MakeReAssResFrame
MakeReAssResFrame: // 0x027F0C24
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	mov r7, r1
	mov r6, r2
	ldr r0, _027F0D88 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x60
	bl AllocateHeapBuf
	movs r4, r0
	bne _027F0C64
	mov r0, #2
	bl SetFatalErr
	mov r0, r4
	b _027F0D7C
_027F0C64:
	ldr r0, _027F0D8C // =0x0000FFFF
	strh r0, [r4, #0xc]
	add r5, r4, #0x10
	cmp r7, #0
	bne _027F0C8C
	mov r0, r8
	bl CAM_AllocateAID
	movs r4, r0
	moveq r7, #0x13
	b _027F0C90
_027F0C8C:
	mov r4, #0
_027F0C90:
	mov r0, r8
	bl CAM_GetMacAdrs
	mov r1, r0
	mov r0, r5
	bl InitManHeader
	ldr r0, _027F0D88 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xc0]
	strh r0, [r5, #0x2c]
	strh r7, [r5, #0x2e]
	orr r0, r4, #0xc000
	strh r0, [r5, #0x30]
	add r0, r5, #0x32
	bl SetSupRateSet
	add r0, r0, #6
	strh r0, [r5, #6]
	ldrh r0, [r5, #6]
	add r0, r0, #0x1c
	strh r0, [r5, #0x12]
	mov r0, #0x30
	strh r0, [r5, #0x14]
	add r1, r5, #0x14
	ldrh r0, [r5, #0x12]
	add r8, r1, r0
	cmp r6, #0
	beq _027F0D60
	add r0, r6, #1
	bl WL_ReadByte
	mov r7, r0
	mov r0, r6
	bl WL_ReadByte
	mov r1, r0
	mov r0, r8
	bl WL_WriteByte
	add r0, r8, #1
	and r1, r7, #0xff
	bl WL_WriteByte
	add r8, r8, #2
	mov r9, #0
	add r4, r6, #2
	b _027F0D54
_027F0D38:
	add r0, r4, r9
	bl WL_ReadByte
	mov r1, r0
	mov r0, r8
	bl WL_WriteByte
	add r8, r8, #1
	add r9, r9, #1
_027F0D54:
	cmp r9, r7
	blo _027F0D38
	b _027F0D78
_027F0D60:
	mov r0, r8
	mov r1, #0
	bl WL_WriteByte
	add r0, r8, #1
	mov r1, #0
	bl WL_WriteByte
_027F0D78:
	mov r0, r5
_027F0D7C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027F0D88: .word 0x0380FFF4
_027F0D8C: .word 0x0000FFFF
	arm_func_end MakeReAssResFrame

	arm_func_start MakeAssResFrame
MakeAssResFrame: // 0x027F0D90
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	mov r7, r1
	mov r6, r2
	ldr r0, _027F0F00 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x60
	bl AllocateHeapBuf
	movs r4, r0
	bne _027F0DD0
	mov r0, #2
	bl SetFatalErr
	mov r0, r4
	b _027F0EF4
_027F0DD0:
	ldr r0, _027F0F04 // =0x0000FFFF
	strh r0, [r4, #0xc]
	add r5, r4, #0x10
	cmp r7, #0
	bne _027F0DF8
	mov r0, r8
	bl CAM_AllocateAID
	movs r4, r0
	moveq r7, #0x13
	b _027F0DFC
_027F0DF8:
	mov r4, #0
_027F0DFC:
	mov r0, r8
	bl CAM_GetMacAdrs
	mov r1, r0
	mov r0, r5
	bl InitManHeader
	ldr r0, _027F0F00 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0xc0]
	strh r0, [r5, #0x2c]
	strh r7, [r5, #0x2e]
	strh r4, [r5, #0x30]
	cmp r4, #0
	ldrneh r0, [r5, #0x30]
	orrne r0, r0, #0xc000
	strneh r0, [r5, #0x30]
	add r0, r5, #0x32
	bl SetSupRateSet
	add r0, r0, #6
	strh r0, [r5, #6]
	ldrh r0, [r5, #6]
	add r0, r0, #0x1c
	strh r0, [r5, #0x12]
	mov r0, #0x10
	strh r0, [r5, #0x14]
	add r1, r5, #0x14
	ldrh r0, [r5, #0x12]
	add r8, r1, r0
	cmp r6, #0
	beq _027F0ED8
	add r0, r6, #1
	bl WL_ReadByte
	mov r7, r0
	mov r0, r6
	bl WL_ReadByte
	mov r1, r0
	mov r0, r8
	bl WL_WriteByte
	add r0, r8, #1
	add r8, r8, #2
	and r1, r7, #0xff
	bl WL_WriteByte
	mov r9, #0
	add r4, r6, #2
	b _027F0ECC
_027F0EB0:
	add r0, r4, r9
	bl WL_ReadByte
	mov r1, r0
	mov r0, r8
	bl WL_WriteByte
	add r9, r9, #1
	add r8, r8, #1
_027F0ECC:
	cmp r9, r7
	blo _027F0EB0
	b _027F0EF0
_027F0ED8:
	mov r0, r8
	mov r1, #0
	bl WL_WriteByte
	add r0, r8, #1
	mov r1, #0
	bl WL_WriteByte
_027F0EF0:
	mov r0, r5
_027F0EF4:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027F0F00: .word 0x0380FFF4
_027F0F04: .word 0x0000FFFF
	arm_func_end MakeAssResFrame

	arm_func_start MakeReAssReqFrame
MakeReAssReqFrame: // 0x027F0F08
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _027F0FB8 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r5, r0, #0x344
	add r0, r0, #0x188
	mov r1, #0x64
	bl AllocateHeapBuf
	movs r4, r0
	bne _027F0F40
	mov r0, #2
	bl SetFatalErr
	mov r0, r4
	b _027F0FB0
_027F0F40:
	ldr r0, _027F0FBC // =0x0000FFFF
	strh r0, [r4, #0xc]
	add r4, r4, #0x10
	mov r0, r4
	mov r1, r6
	bl InitManHeader
	ldrh r0, [r5, #0x7c]
	strh r0, [r4, #0x2c]
	ldrh r0, [r5, #0x70]
	strh r0, [r4, #0x2e]
	add r0, r4, #0x30
	add r1, r5, #0x82
	bl WSetMacAdrs1
	add r0, r4, #0x36
	bl SetSSIDElement
	mov r5, r0
	add r0, r4, #0x36
	add r0, r0, r5
	bl SetSupRateSet
	add r0, r5, r0
	add r0, r0, #0xa
	strh r0, [r4, #6]
	ldrh r0, [r4, #6]
	add r0, r0, #0x1c
	strh r0, [r4, #0x12]
	mov r0, #0x20
	strh r0, [r4, #0x14]
	mov r0, r4
_027F0FB0:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F0FB8: .word 0x0380FFF4
_027F0FBC: .word 0x0000FFFF
	arm_func_end MakeReAssReqFrame

	arm_func_start MakeAssReqFrame
MakeAssReqFrame: // 0x027F0FC0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _027F1064 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r5, r0, #0x344
	add r0, r0, #0x188
	mov r1, #0x5e
	bl AllocateHeapBuf
	movs r4, r0
	bne _027F0FF8
	mov r0, #2
	bl SetFatalErr
	mov r0, r4
	b _027F105C
_027F0FF8:
	ldr r0, _027F1068 // =0x0000FFFF
	strh r0, [r4, #0xc]
	add r4, r4, #0x10
	mov r0, r4
	mov r1, r6
	bl InitManHeader
	ldrh r0, [r5, #0x7c]
	strh r0, [r4, #0x2c]
	ldrh r0, [r5, #0x70]
	strh r0, [r4, #0x2e]
	add r0, r4, #0x30
	bl SetSSIDElement
	mov r5, r0
	add r0, r4, #0x30
	add r0, r0, r5
	bl SetSupRateSet
	add r0, r5, r0
	add r0, r0, #4
	strh r0, [r4, #6]
	ldrh r0, [r4, #6]
	add r0, r0, #0x1c
	strh r0, [r4, #0x12]
	mov r0, #0
	strh r0, [r4, #0x14]
	mov r0, r4
_027F105C:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F1064: .word 0x0380FFF4
_027F1068: .word 0x0000FFFF
	arm_func_end MakeAssReqFrame

	arm_func_start MakeDisAssFrame
MakeDisAssFrame: // 0x027F106C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	ldr r0, _027F10E8 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	mov r1, #0x36
	bl AllocateHeapBuf
	movs r4, r0
	bne _027F10A4
	mov r0, #2
	bl SetFatalErr
	mov r0, r4
	b _027F10E0
_027F10A4:
	ldr r0, _027F10EC // =0x0000FFFF
	strh r0, [r4, #0xc]
	add r4, r4, #0x10
	mov r0, r4
	mov r1, r6
	bl InitManHeader
	strh r5, [r4, #0x2c]
	mov r0, #2
	strh r0, [r4, #6]
	ldrh r0, [r4, #6]
	add r0, r0, #0x1c
	strh r0, [r4, #0x12]
	mov r0, #0xa0
	strh r0, [r4, #0x14]
	mov r0, r4
_027F10E0:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F10E8: .word 0x0380FFF4
_027F10EC: .word 0x0000FFFF
	arm_func_end MakeDisAssFrame

	arm_func_start IsEnableManagement
IsEnableManagement: // 0x027F10F0
	ldr r0, _027F111C // =0x0380FFF4
	ldr r2, [r0, #0]
	add r0, r2, #0x100
	ldrh r1, [r0, #0xa8]
	add r0, r2, #0x500
	ldrh r0, [r0, #0x38]
	rsb r0, r0, #0x18
	cmp r1, r0
	movlt r0, #1
	movge r0, #0
	bx lr
	.align 2, 0
_027F111C: .word 0x0380FFF4
	arm_func_end IsEnableManagement

	arm_func_start UpdateGameInfoElement
UpdateGameInfoElement: // 0x027F1120
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _027F121C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r5, r0, #0x344
	ldr r0, [r0, #0x4ac]
	add r1, r0, #0x24
	ldrh r0, [r5, #0x96]
	add r4, r1, r0
	ldrh r2, [r5, #0xa0]
	cmp r2, #0
	beq _027F119C
	ldrh r0, [r5, #0xa2]
	ands r0, r0, #1
	beq _027F118C
	add r0, r4, #0xa
	sub r0, r0, #1
	ldr r1, [r5, #0x9c]
	add r2, r2, #2
	bl DMA_Write
	add r0, r4, #9
	ldr r1, _027F1220 // =0x0380FFF0
	ldrh r1, [r1, #0]
	mov r1, r1, asr #8
	and r1, r1, #0xff
	bl WL_WriteByte
	b _027F119C
_027F118C:
	add r0, r4, #0xa
	ldr r1, [r5, #0x9c]
	add r2, r2, #1
	bl DMA_Write
_027F119C:
	ldrh r0, [r5, #0x96]
	add r1, r0, #0x26
	ldrh r0, [r5, #0xa0]
	add r1, r1, r0
	ldr r0, _027F121C // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x4ac]
	strh r1, [r0, #0xa]
	add r0, r4, #1
	ldrh r1, [r5, #0xa0]
	add r1, r1, #8
	and r1, r1, #0xff
	bl WL_WriteByte
	ldr r0, _027F121C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #4
	beq _027F1208
	add r1, r4, #0xd
	ldrh r0, [r5, #0xa0]
	add r0, r1, r0
	bic r1, r0, #3
	ldr r0, _027F1224 // =0x0000B6B8
	strh r0, [r1]
	ldr r0, _027F1228 // =0x00001D46
	strh r0, [r1, #2]
_027F1208:
	mov r0, #0
	strh r0, [r5, #0xa4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F121C: .word 0x0380FFF4
_027F1220: .word 0x0380FFF0
_027F1224: .word 0x0000B6B8
_027F1228: .word 0x00001D46
	arm_func_end UpdateGameInfoElement

	arm_func_start MakeBeaconFrame
MakeBeaconFrame: // 0x027F122C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r0, _027F1580 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r10, [r0, #0x4ac]
	add r9, r0, #0x31c
	add r8, r0, #0x344
	mov r0, #0
	strh r0, [r10]
	strh r0, [r10, #2]
	strh r0, [r10, #4]
	strh r0, [r10, #6]
	bl WCalcManRate
	strh r0, [r10, #8]
	mov r0, #0x80
	strh r0, [r10, #0xc]
	mov r0, #0
	strh r0, [r10, #0xe]
	add r0, r10, #0x10
	ldr r1, _027F1584 // =BC_ADRS
	add r2, r9, #8
	mov r3, r2
	bl WSetMacAdrs3
	mov r1, #0
	strh r1, [r10, #0x22]
	add r7, r10, #0x24
	str r1, [r10, #0x24]
	str r1, [r7, #4]
	ldrh r0, [r8, #0x6e]
	strh r0, [r7, #8]
	ldrh r0, [r8, #0x7c]
	strh r0, [r7, #0xa]
	add r6, r7, #0xc
	ldrh r0, [r9, #0x1e]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	bne _027F132C
	sub r0, r6, r7
	strh r0, [r8, #0x92]
	mov r0, r6
	bl WL_WriteByte
	add r0, r6, #1
	add r6, r6, #2
	ldrh r1, [r8, #0x1e]
	and r1, r1, #0xff
	bl WL_WriteByte
	mov r5, #0
	add r4, r8, #0x20
	b _027F1308
_027F12EC:
	add r0, r4, r5
	bl WL_ReadByte
	mov r1, r0
	mov r0, r6
	bl WL_WriteByte
	add r6, r6, #1
	add r5, r5, #1
_027F1308:
	ldrh r0, [r8, #0x1e]
	cmp r5, r0
	blo _027F12EC
	mvn r0, #0
	sub r0, r0, r5
	add r0, r6, r0
	and r1, r5, #0xff
	bl WL_WriteByte
	b _027F1330
_027F132C:
	strh r1, [r8, #0x92]
_027F1330:
	mov r0, r6
	bl SetSupRateSet
	add r6, r6, r0
	mov r0, r6
	mov r1, #3
	bl WL_WriteByte
	add r0, r6, #1
	mov r1, #1
	bl WL_WriteByte
	add r0, r6, #2
	ldrh r1, [r8, #0x7a]
	and r1, r1, #0xff
	bl WL_WriteByte
	add r0, r6, #3
	sub r1, r0, r7
	strh r1, [r8, #0x94]
	ldrh r1, [r8, #0x94]
	add r2, r1, #2
	ldr r1, _027F1588 // =0x04808084
	strh r2, [r1]
	mov r1, #5
	bl WL_WriteByte
	add r0, r6, #4
	mov r1, #5
	bl WL_WriteByte
	add r0, r6, #5
	mov r1, #0
	bl WL_WriteByte
	add r0, r6, #6
	ldrh r1, [r8, #0x74]
	and r1, r1, #0xff
	bl WL_WriteByte
	add r0, r6, #7
	mov r1, #0
	bl WL_WriteByte
	add r0, r6, #8
	mov r1, #0
	bl WL_WriteByte
	add r0, r6, #9
	mov r1, #0
	bl WL_WriteByte
	add r0, r6, #0xa
	sub r1, r0, r7
	strh r1, [r8, #0x96]
	ldrh r1, [r8, #0x96]
	and r1, r1, #1
	strh r1, [r8, #0xa2]
	mov r1, #0xdd
	bl WL_WriteByte
	add r0, r6, #0xb
	ldrh r1, [r8, #0xa0]
	add r1, r1, #8
	and r1, r1, #0xff
	bl WL_WriteByte
	add r0, r6, #0xc
	mov r1, #0
	bl WL_WriteByte
	add r0, r6, #0xd
	mov r1, #9
	bl WL_WriteByte
	add r0, r6, #0xe
	mov r1, #0xbf
	bl WL_WriteByte
	add r0, r6, #0xf
	mov r1, #0
	bl WL_WriteByte
	ldrh r0, [r8, #0xe]
	cmp r0, #1
	bne _027F1470
	add r0, r6, #0x10
	ldrh r1, [r9, #0x20]
	and r1, r1, #0xff
	bl WL_WriteByte
	add r0, r6, #0x11
	add r6, r6, #0x12
	ldrh r1, [r9, #0x20]
	mov r1, r1, asr #8
	and r1, r1, #0xff
	bl WL_WriteByte
	b _027F148C
_027F1470:
	add r0, r6, #0x10
	mov r1, #0xff
	bl WL_WriteByte
	add r0, r6, #0x11
	add r6, r6, #0x12
	mov r1, #0xff
	bl WL_WriteByte
_027F148C:
	ldr r0, _027F158C // =0x0380FFF0
	ldrh r4, [r0, #0]
	mov r0, r6
	and r1, r4, #0xff
	bl WL_WriteByte
	add r0, r6, #1
	add r6, r6, #2
	mov r1, r4, lsr #8
	and r1, r1, #0xff
	bl WL_WriteByte
	ldr r5, [r8, #0x9c]
	mov r4, #0
	b _027F14E0
_027F14C0:
	mov r0, r5
	bl WL_ReadByte
	mov r1, r0
	mov r0, r6
	bl WL_WriteByte
	add r6, r6, #1
	add r5, r5, #1
	add r4, r4, #1
_027F14E0:
	ldrh r1, [r8, #0xa0]
	cmp r4, r1
	blo _027F14C0
	ldrh r0, [r8, #0xa2]
	cmp r0, #0
	beq _027F1534
	ldr r0, [r8, #0x9c]
	add r0, r0, r1
	sub r4, r0, #1
	mov r5, #0
	b _027F1528
_027F150C:
	mov r0, r4
	bl WL_ReadByte
	mov r1, r0
	add r0, r4, #1
	bl WL_WriteByte
	add r5, r5, #1
	sub r4, r4, #1
_027F1528:
	ldrh r0, [r8, #0xa0]
	cmp r5, r0
	blo _027F150C
_027F1534:
	ldr r0, _027F1580 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #4
	beq _027F1564
	add r0, r6, #3
	bic r1, r0, #3
	ldr r0, _027F1590 // =0x0000B6B8
	strh r0, [r1]
	ldr r0, _027F1594 // =0x00001D46
	strh r0, [r1, #2]
_027F1564:
	mov r0, #0
	strh r0, [r8, #0xa4]
	add r0, r6, #0x1c
	sub r0, r0, r7
	strh r0, [r10, #0xa]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_027F1580: .word 0x0380FFF4
_027F1584: .word BC_ADRS
_027F1588: .word 0x04808084
_027F158C: .word 0x0380FFF0
_027F1590: .word 0x0000B6B8
_027F1594: .word 0x00001D46
	arm_func_end MakeBeaconFrame

	arm_func_start StopBeaconFrame
StopBeaconFrame: // 0x027F1598
	ldr r0, _027F15B8 // =0x0380FFF4
	ldr r2, [r0, #0]
	mov r1, #0
	ldr r0, _027F15BC // =0x04808080
	strh r1, [r0]
	add r0, r2, #0x400
	strh r1, [r0, #0xa4]
	bx lr
	.align 2, 0
_027F15B8: .word 0x0380FFF4
_027F15BC: .word 0x04808080
	arm_func_end StopBeaconFrame

	arm_func_start StartBeaconFrame
StartBeaconFrame: // 0x027F15C0
	ldr r0, _027F15FC // =0x0380FFF4
	ldr r2, [r0, #0]
	ldr r0, _027F1600 // =0x000004A4
	add r3, r2, r0
	mov r1, #1
	add r0, r2, #0x400
	strh r1, [r0, #0xa4]
	ldr r1, [r3, #8]
	ldr r0, _027F1604 // =0x00003FFF
	and r0, r1, r0
	mov r0, r0, lsr #1
	orr r1, r0, #0x8000
	ldr r0, _027F1608 // =0x04808080
	strh r1, [r0]
	bx lr
	.align 2, 0
_027F15FC: .word 0x0380FFF4
_027F1600: .word 0x000004A4
_027F1604: .word 0x00003FFF
_027F1608: .word 0x04808080
	arm_func_end StartBeaconFrame

	arm_func_start TxPsPollFrame
TxPsPollFrame: // 0x027F160C
	stmdb sp!, {r4, lr}
	ldr r0, _027F1698 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027F169C // =0x00000454
	add r4, r1, r0
	ldrh r0, [r4, #2]
	add r0, r0, #1
	strh r0, [r4, #2]
	add r0, r1, #0x400
	ldrh r0, [r0, #0x54]
	cmp r0, #0
	movne r1, #0
	ldrne r0, [r4, #8]
	strneh r1, [r0, #4]
	bne _027F1690
	mov r0, #1
	strh r0, [r4]
	mov r1, #0
	ldr r0, [r4, #8]
	strh r1, [r0]
	ldr r0, [r4, #8]
	strh r1, [r0, #4]
	bl WCalcManRate
	ldr r1, [r4, #8]
	strh r0, [r1, #8]
	ldr r1, [r4, #8]
	ldr r0, _027F16A0 // =0x00003FFF
	and r0, r1, r0
	mov r0, r0, lsl #0xf
	mov r0, r0, lsr #0x10
	orr r1, r0, #0x8000
	ldr r0, _027F16A4 // =0x048080A8
	strh r1, [r0]
_027F1690:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F1698: .word 0x0380FFF4
_027F169C: .word 0x00000454
_027F16A0: .word 0x00003FFF
_027F16A4: .word 0x048080A8
	arm_func_end TxPsPollFrame

	arm_func_start SetManCtrlFrame
SetManCtrlFrame: // 0x027F16A8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x18
	bl CAM_Search
	strh r0, [r4, #2]
	ldrh r0, [r4, #2]
	cmp r0, #0xff
	moveq r0, #0
	streqh r0, [r4, #2]
	ldr r0, _027F1718 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x3ec]
	strh r0, [r4, #4]
	ldrh r0, [r4, #0x14]
	ands r0, r0, #0x4000
	ldrneh r0, [r4, #0x12]
	addne r0, r0, #8
	strneh r0, [r4, #0x12]
	mov r0, r4
	bl CAM_IncFrameCount
	ldr r0, _027F1718 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r0, r1, #0x188
	add r1, r1, #0x1a0
	sub r2, r4, #0x10
	bl MoveHeapBuf
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F1718: .word 0x0380FFF4
	arm_func_end SetManCtrlFrame

	arm_func_start TxManCtrlFrame
TxManCtrlFrame: // 0x027F171C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl SetManCtrlFrame
	mov r0, #1
	bl TxqPri
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end TxManCtrlFrame

	arm_func_start MessageDeleteTx
MessageDeleteTx: // 0x027F173C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	mov r0, #0xc
	mul r6, r10, r0
	ldr r0, _027F17D0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, r6
	ldr r8, [r0, #0x194]
	mvn r4, #0
	cmp r8, r4
	beq _027F17C4
	mov r5, #2
_027F1774:
	mov r0, r8
	bl GetHeapBufNextAdrs
	mov r11, r0
	add r7, r8, #0x10
	cmp r10, #2
	beq _027F1794
	mov r0, r7
	bl CAM_DecFrameCount
_027F1794:
	strh r5, [r7, #8]
	cmp r9, #0
	beq _027F17B8
	ldr r0, _027F17D0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x194
	add r0, r0, r6
	mov r1, r8
	bl IssueMaDataConfirm
_027F17B8:
	mov r8, r11
	cmp r11, r4
	bne _027F1774
_027F17C4:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F17D0: .word 0x0380FFF4
	arm_func_end MessageDeleteTx

	arm_func_start DeleteAllTxFrames
DeleteAllTxFrames: // 0x027F17D4
	stmdb sp!, {r4, lr}
	ldr r0, _027F18BC // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027F18C0 // =0x0000042C
	add r4, r1, r0
	add r0, r1, #0x300
	ldrh r0, [r0, #0x50]
	cmp r0, #1
	beq _027F180C
	cmp r0, #2
	beq _027F1868
	cmp r0, #3
	beq _027F1868
	b _027F1890
_027F180C:
	mov r0, #0
	mov r1, #1
	bl MessageDeleteTx
	mov r0, #1
	mov r1, #0
	bl MessageDeleteTx
	mov r0, #2
	mov r1, #1
	bl MessageDeleteTx
	ldrh r0, [r4, #0x3c]
	cmp r0, #0
	beq _027F18B4
	mov r0, #0
	strh r0, [r4, #0x3c]
	ldrh r0, [r4, #0x3e]
	sub r0, r0, #1
	strh r0, [r4, #0x3e]
	ldr r0, _027F18BC // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	ldr r1, [r4, #0x90]
	bl ReleaseHeapBuf
	b _027F18B4
_027F1868:
	mov r0, #0
	mov r1, #1
	bl MessageDeleteTx
	mov r0, #1
	mov r1, #0
	bl MessageDeleteTx
	mov r0, #2
	mov r1, #0
	bl MessageDeleteTx
	b _027F18B4
_027F1890:
	mov r0, #0
	mov r1, r0
	bl MessageDeleteTx
	mov r0, #1
	mov r1, #0
	bl MessageDeleteTx
	mov r0, #2
	mov r1, #0
	bl MessageDeleteTx
_027F18B4:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F18BC: .word 0x0380FFF4
_027F18C0: .word 0x0000042C
	arm_func_end DeleteAllTxFrames

	arm_func_start DeleteTxFrameByAdrs
DeleteTxFrameByAdrs: // 0x027F18C4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldrh r1, [r0, #0]
	ands r1, r1, #1
	beq _027F1908
	mov r5, #1
	ldr r4, _027F1964 // =0x0380FFF4
	b _027F18F0
_027F18E4:
	mov r0, r5
	bl DeleteTxFrames
	add r5, r5, #1
_027F18F0:
	ldr r0, [r4, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x22]
	cmp r5, r0
	blo _027F18E4
	b _027F1958
_027F1908:
	bl CAM_Search
	mov r4, r0
	cmp r4, #0xff
	beq _027F191C
	bl DeleteTxFrames
_027F191C:
	ldr r0, _027F1964 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x2e]
	cmp r0, #1
	bne _027F1958
	mov r0, r4
	bl CAM_GetStaState
	cmp r0, #0x40
	bne _027F1958
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x20
	bl CAM_SetStaState
	bl ClearTxKeyData
_027F1958:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F1964: .word 0x0380FFF4
	arm_func_end DeleteTxFrameByAdrs

	arm_func_start DeleteTxFrames
DeleteTxFrames: // 0x027F1968
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r11, r0
	mov r8, #0
	bl CAM_GetFrameCount
	cmp r0, #0
	beq _027F1A68
	mov r7, r8
	mov r0, #1
	str r0, [sp, #8]
	mov r4, #2
	str r7, [sp, #4]
_027F1998:
	mov r0, #0xc
	mul r5, r7, r0
	ldr r0, _027F1A74 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, r5
	ldr r10, [r0, #0x194]
	mvn r0, #0
	cmp r10, r0
	beq _027F1A5C
	mov r0, #0x14
	mul r6, r7, r0
_027F19C4:
	mov r0, r10
	bl GetHeapBufNextAdrs
	str r0, [sp]
	add r9, r10, #0x10
	ldrh r0, [r9, #2]
	cmp r0, r11
	bne _027F1A48
	cmp r7, #1
	beq _027F1A00
	ldr r0, _027F1A74 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r6, r0
	ldr r0, [r0, #0x438]
	cmp r9, r0
	bne _027F1A1C
_027F1A00:
	mov r0, r9
	bl CAM_DecFrameCount
	ldr r0, [sp, #4]
	strh r0, [r9, #2]
	mov r0, r9
	bl CAM_IncFrameCount
	b _027F1A48
_027F1A1C:
	strh r4, [r9, #8]
	mov r0, r9
	bl CAM_DecFrameCount
	ldr r0, _027F1A74 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x194
	add r0, r0, r5
	mov r1, r10
	bl IssueMaDataConfirm
	cmp r8, #0
	ldreq r8, [sp, #8]
_027F1A48:
	ldr r10, [sp]
	mvn r1, #0
	mov r0, r10
	cmp r0, r1
	bne _027F19C4
_027F1A5C:
	add r7, r7, #1
	cmp r7, #3
	blo _027F1998
_027F1A68:
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F1A74: .word 0x0380FFF4
	arm_func_end DeleteTxFrames

	arm_func_start ResetTxqPri
ResetTxqPri: // 0x027F1A78
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r0, _027F1B00 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027F1B04 // =0x0000042C
	add r5, r1, r0
	mov r0, #0x14
	mul r4, r7, r0
	add r6, r5, r4
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r2, r7, lsl #1
	ldr r1, _027F1B08 // =Pri2QBit
	ldrh r2, [r1, r2]
	ldr r1, _027F1B0C // =0x048080B4
	strh r2, [r1]
	ldrh r1, [r5, r4]
	cmp r1, #0
	beq _027F1AF0
	ldr r2, [r6, #0xc]
	ldrh r1, [r2, #0x14]
	ands r1, r1, #0x4000
	ldreq r1, [r6, #8]
	ldreqh r1, [r1, #4]
	streqh r1, [r2, #0xc]
	ldr r1, [r6, #8]
	ldrh r2, [r1, #0x22]
	ldr r1, [r6, #0xc]
	strh r2, [r1, #0x2a]
_027F1AF0:
	bl OS_EnableIrqMask
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027F1B00: .word 0x0380FFF4
_027F1B04: .word 0x0000042C
_027F1B08: .word Pri2QBit
_027F1B0C: .word 0x048080B4
	arm_func_end ResetTxqPri

	arm_func_start ClearQueuedPri
ClearQueuedPri: // 0x027F1B10
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _027F1B80 // =0x0380FFF4
	ldr r2, [r1, #0]
	ldr r1, _027F1B84 // =0x0000042C
	add r2, r2, r1
	mov r1, #0x14
	mul r1, r0, r1
	add r3, r2, r1
	ldrh r0, [r2, r1]
	cmp r0, #0
	beq _027F1B74
	ldr r0, [r3, #8]
	ldrh r1, [r0, #0]
	cmp r1, #0
	moveq r1, #2
	ldreq r0, [r3, #0xc]
	streqh r1, [r0, #8]
	ldrne r0, [r3, #0xc]
	strneh r1, [r0, #8]
	ldr r0, [r3, #0xc]
	mov r1, #0
	ldr r2, [r3, #0x10]
	mov lr, pc
	bx r2
_027F1B74:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027F1B80: .word 0x0380FFF4
_027F1B84: .word 0x0000042C
	arm_func_end ClearQueuedPri

	arm_func_start ClearTxData
ClearTxData: // 0x027F1B88
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _027F1C34 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027F1C38 // =0x0000042C
	add r5, r1, r0
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r4, r0
	ldr r0, _027F1C34 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x50]
	cmp r0, #1
	bne _027F1BF4
	mov r1, #9
	ldr r0, _027F1C3C // =0x048080B4
	strh r1, [r0]
	ldrh r0, [r5, #0x28]
	cmp r0, #0
	beq _027F1BE4
	mov r0, #2
	bl ClearQueuedPri
_027F1BE4:
	mov r0, #2
	mov r1, #1
	bl MessageDeleteTx
	b _027F1C00
_027F1BF4:
	mov r1, #1
	ldr r0, _027F1C3C // =0x048080B4
	strh r1, [r0]
_027F1C00:
	ldrh r0, [r5, #0]
	cmp r0, #0
	beq _027F1C14
	mov r0, #0
	bl ClearQueuedPri
_027F1C14:
	mov r0, #0
	mov r1, #1
	bl MessageDeleteTx
	mov r0, r4
	bl OS_EnableIrqMask
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F1C34: .word 0x0380FFF4
_027F1C38: .word 0x0000042C
_027F1C3C: .word 0x048080B4
	arm_func_end ClearTxData

	arm_func_start ClearTxMp
ClearTxMp: // 0x027F1C40
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _027F1C94 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027F1C98 // =0x0000042C
	add r5, r1, r0
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r4, r0
	mov r1, #2
	ldr r0, _027F1C9C // =0x048080B4
	strh r1, [r0]
	ldrh r0, [r5, #0x3c]
	cmp r0, #0
	beq _027F1C80
	bl WlIntrMpEndTask
_027F1C80:
	mov r0, r4
	bl OS_EnableIrqMask
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F1C94: .word 0x0380FFF4
_027F1C98: .word 0x0000042C
_027F1C9C: .word 0x048080B4
	arm_func_end ClearTxMp

	arm_func_start ClearTxKeyData
ClearTxKeyData: // 0x027F1CA0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _027F1D14 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027F1D18 // =0x0000042C
	add r5, r1, r0
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	mov r4, r0
	ldr r0, _027F1D14 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	bne _027F1CE8
	mov r0, #0
	bl WClearKSID
_027F1CE8:
	mov r1, #0xc0
	ldr r0, _027F1D1C // =0x048080B4
	strh r1, [r0]
	mov r0, #0
	strh r0, [r5, #0x50]
	strh r0, [r5, #0x64]
	mov r0, r4
	bl OS_EnableIrqMask
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F1D14: .word 0x0380FFF4
_027F1D18: .word 0x0000042C
_027F1D1C: .word 0x048080B4
	arm_func_end ClearTxKeyData

	arm_func_start TxEndKeyData
TxEndKeyData: // 0x027F1D20
	ldr r1, [r0, #8]
	ldrh r1, [r1, #4]
	ands r3, r1, #0xff
	ldr r1, _027F1D6C // =0x0380FFF4
	ldr r2, [r1, #0]
	ldr r1, _027F1D70 // =0x0000053C
	add r2, r2, r1
	ldreq r1, [r2, #0x6c]
	addeq r1, r1, #1
	streq r1, [r2, #0x6c]
	ldrne r1, [r2, #0x68]
	addne r1, r1, r3
	strne r1, [r2, #0x68]
	ldrh r1, [r0, #4]
	add r1, r1, #1
	strh r1, [r0, #4]
	mov r1, #0
	strh r1, [r0]
	bx lr
	.align 2, 0
_027F1D6C: .word 0x0380FFF4
_027F1D70: .word 0x0000053C
	arm_func_end TxEndKeyData

	arm_func_start TxqEndBroadCast
TxqEndBroadCast: // 0x027F1D74
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	ldr r1, _027F1E88 // =0x0380FFF4
	ldr r2, [r1, #0]
	add r5, r2, #0x17c
	add r4, r5, #0x30
	ldr r1, [r2, #0x550]
	add r1, r1, #1
	str r1, [r2, #0x550]
	ldrh r1, [r7, #0x14]
	mov r1, r1, lsl #0x1c
	movs r1, r1, lsr #0x1e
	bne _027F1DD4
	bl CAM_IncFrameCount
	mov r0, r4
	add r1, r5, #0x24
	sub r2, r7, #0x10
	bl MoveHeapBuf
	mov r0, r7
	mov r1, #0
	bl TxqEndManCtrl
	b _027F1DE0
_027F1DD4:
	mov r0, r4
	sub r1, r7, #0x10
	bl IssueMaDataConfirm
_027F1DE0:
	mov r2, #0
	ldr r1, _027F1E88 // =0x0380FFF4
	ldr r0, [r1, #0]
	add r0, r0, #0x400
	strh r2, [r0, #0x54]
	ldr r0, [r1, #0]
	ldr r0, [r0, #0x45c]
	ldrh r0, [r0, #0xc]
	mov r0, r0, lsl #0x12
	movs r0, r0, lsr #0x1f
	bne _027F1E54
	mov r1, #8
	ldr r0, _027F1E8C // =0x048080AC
	strh r1, [r0]
	mov r1, #5
	ldr r0, _027F1E90 // =0x048080AE
	strh r1, [r0]
	cmp r6, #0
	beq _027F1E54
	ldrh r0, [r5, #0x2c]
	cmp r0, #0
	beq _027F1E40
	mov r0, #1
	bl TxqPri
_027F1E40:
	ldrh r0, [r5, #0x20]
	cmp r0, #0
	beq _027F1E54
	mov r0, #0
	bl TxqPri
_027F1E54:
	ldrh r0, [r4, #8]
	cmp r0, #0
	beq _027F1E74
	cmp r6, #0
	beq _027F1E7C
	mov r0, #2
	bl TxqPri
	b _027F1E7C
_027F1E74:
	mov r0, #0
	bl CAM_ClrTIMElementBitmap
_027F1E7C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027F1E88: .word 0x0380FFF4
_027F1E8C: .word 0x048080AC
_027F1E90: .word 0x048080AE
	arm_func_end TxqEndBroadCast

	arm_func_start TxqEndPsPoll
TxqEndPsPoll: // 0x027F1E94
	ldr r1, _027F1F00 // =0x0380FFF4
	ldr r2, [r1, #0]
	ldr r1, _027F1F04 // =0x0000053C
	add r3, r2, r1
	ldr r2, [r3, #8]
	ldrh r1, [r0, #4]
	and r1, r1, #0xff
	add r1, r2, r1
	str r1, [r3, #8]
	ldrh r0, [r0, #0]
	ands r0, r0, #2
	ldrne r0, [r3, #4]
	addne r0, r0, #1
	strne r0, [r3, #4]
	bne _027F1EE8
	ldr r0, [r3, #0]
	add r0, r0, #1
	str r0, [r3]
	ldr r0, [r3, #0x10]
	add r0, r0, #1
	str r0, [r3, #0x10]
_027F1EE8:
	mov r1, #0
	ldr r0, _027F1F00 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x400
	strh r1, [r0, #0x54]
	bx lr
	.align 2, 0
_027F1F00: .word 0x0380FFF4
_027F1F04: .word 0x0000053C
	arm_func_end TxqEndPsPoll

	arm_func_start TxqEndManCtrl
TxqEndManCtrl: // 0x027F1F08
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	ldr r0, _027F2418 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r4, r1, #0x344
	ldr r0, _027F241C // =0x00000404
	add r8, r1, r0
	ldr r0, _027F2420 // =0x0000053C
	add r5, r1, r0
	add r7, r1, #0x1a0
	ldrh r6, [r10, #2]
	ldrh r0, [r10, #8]
	ands r0, r0, #2
	bne _027F1F9C
	ldr r0, [r5, #0]
	add r0, r0, #1
	str r0, [r5]
	ldrh r0, [r10, #0x18]
	ands r0, r0, #1
	ldrne r0, [r5, #0x14]
	addne r0, r0, #1
	strne r0, [r5, #0x14]
	ldreq r0, [r5, #0x10]
	addeq r0, r0, #1
	streq r0, [r5, #0x10]
	mov r0, r6
	bl CAM_GetPowerMgtMode
	cmp r0, #0
	beq _027F1FA8
	ldrh r0, [r10, #0x14]
	ands r0, r0, #0x2000
	bne _027F1FA8
	mov r0, r6
	bl CAM_SetDoze
	b _027F1FA8
_027F1F9C:
	ldr r0, [r5, #4]
	add r0, r0, #1
	str r0, [r5, #4]
_027F1FA8:
	ldrh r0, [r10, #0x14]
	mov r0, r0, lsl #0x11
	movs r0, r0, lsr #0x1f
	ldrne r0, [r5, #0x18]
	addne r0, r0, #1
	strne r0, [r5, #0x18]
	ldr r1, [r5, #8]
	ldrh r0, [r10, #0xc]
	and r0, r0, #0xff
	add r0, r1, r0
	str r0, [r5, #8]
	ldrh r0, [r10, #0x14]
	and r5, r0, #0xfc
	cmp r5, #0xa0
	bhi _027F200C
	cmp r5, #0xa0
	bhs _027F2188
	cmp r5, #0x10
	bhi _027F2000
	cmp r5, #0x10
	beq _027F20C4
	b _027F23C8
_027F2000:
	cmp r5, #0x30
	beq _027F20C4
	b _027F23C8
_027F200C:
	cmp r5, #0xb0
	bhi _027F2020
	cmp r5, #0xb0
	beq _027F202C
	b _027F23C8
_027F2020:
	cmp r5, #0xc0
	beq _027F2278
	b _027F23C8
_027F202C:
	cmp r6, #0
	beq _027F23C8
	ldrh r0, [r10, #8]
	ands r0, r0, #2
	bne _027F23C8
	ldrh r1, [r10, #0x2c]
	cmp r1, #0
	bne _027F2084
	ldrh r0, [r10, #0x2e]
	cmp r0, #2
	bne _027F2084
	ldrh r0, [r10, #0x30]
	cmp r0, #0
	bne _027F2084
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x30
	bl CAM_SetStaState
	add r0, r10, #0x18
	ldrh r1, [r10, #0x2c]
	bl MLME_IssueAuthIndication
	b _027F23C8
_027F2084:
	cmp r1, #1
	bne _027F23C8
	ldrh r0, [r10, #0x2e]
	cmp r0, #4
	bne _027F23C8
	ldrh r0, [r10, #0x30]
	cmp r0, #0
	bne _027F23C8
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x30
	bl CAM_SetStaState
	add r0, r10, #0x18
	ldrh r1, [r10, #0x2c]
	bl MLME_IssueAuthIndication
	b _027F23C8
_027F20C4:
	cmp r6, #0
	beq _027F23C8
	ldrh r0, [r10, #8]
	ands r0, r0, #2
	bne _027F2144
	ldrh r0, [r10, #0x2e]
	cmp r0, #0
	bne _027F23C8
	mov r0, r6
	bl CAM_GetStaState
	cmp r0, #0x30
	bne _027F23C8
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x40
	bl CAM_SetStaState
	cmp r5, #0x10
	bne _027F2128
	add r0, r10, #0x18
	ldrh r1, [r10, #0x30]
	add r3, r10, #0x14
	ldrh r2, [r10, #0x12]
	add r2, r3, r2
	bl MLME_IssueAssIndication
	b _027F23C8
_027F2128:
	add r0, r10, #0x18
	ldrh r1, [r10, #0x30]
	add r3, r10, #0x14
	ldrh r2, [r10, #0x12]
	add r2, r3, r2
	bl MLME_IssueReAssIndication
	b _027F23C8
_027F2144:
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl CAM_ReleaseAID
	add r0, r10, #0x18
	mov r1, #1
	mov r2, #0
	bl MakeDeAuthFrame
	cmp r0, #0
	beq _027F23C8
	mov r1, #2
	strh r1, [r0]
	cmp r9, #0
	beq _027F2180
	bl TxManCtrlFrame
	b _027F23C8
_027F2180:
	bl SetManCtrlFrame
	b _027F23C8
_027F2188:
	ldrh r0, [r4, #0xc]
	cmp r0, #1
	bne _027F2218
	cmp r6, #0
	beq _027F21C0
	mov r0, r6
	bl CAM_GetStaState
	cmp r0, #0x30
	bls _027F2230
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x30
	bl CAM_SetStaState
	b _027F2230
_027F21C0:
	ldrh r0, [r10, #0x18]
	ands r0, r0, #1
	beq _027F2230
	mov r6, #1
	mov r5, #0x30
	ldr r4, _027F2418 // =0x0380FFF4
	b _027F2200
_027F21DC:
	mov r0, r6
	bl CAM_GetStaState
	cmp r0, #0x30
	bls _027F21FC
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r5
	bl CAM_SetStaState
_027F21FC:
	add r6, r6, #1
_027F2200:
	ldr r0, [r4, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x22]
	cmp r6, r0
	blo _027F21DC
	b _027F2230
_027F2218:
	ldrh r0, [r4, #8]
	cmp r0, #0x30
	bls _027F2230
	mov r0, #0x30
	bl WSetStaState
	bl WClearAids
_027F2230:
	ldrh r0, [r8, #0]
	cmp r0, #0x71
	bne _027F23C8
	ldr r0, [r8, #4]
	cmp r10, r0
	bne _027F23C8
	ldrh r0, [r10, #8]
	ands r0, r0, #2
	moveq r1, #0
	ldreq r0, [r8, #0x1c]
	streqh r1, [r0, #4]
	movne r1, #0xc
	ldrne r0, [r8, #0x1c]
	strneh r1, [r0, #4]
	mov r0, #0
	strh r0, [r8]
	bl IssueMlmeConfirm
	b _027F23C8
_027F2278:
	ldrh r0, [r4, #0xc]
	cmp r0, #1
	bne _027F2308
	cmp r6, #0
	beq _027F22B0
	mov r0, r6
	bl CAM_GetStaState
	cmp r0, #0x20
	bls _027F2320
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x20
	bl CAM_SetStaState
	b _027F2320
_027F22B0:
	ldrh r0, [r10, #0x18]
	ands r0, r0, #1
	beq _027F2320
	mov r5, #1
	mov r4, #0x20
	ldr r11, _027F2418 // =0x0380FFF4
	b _027F22F0
_027F22CC:
	mov r0, r5
	bl CAM_GetStaState
	cmp r0, #0x20
	bls _027F22EC
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r4
	bl CAM_SetStaState
_027F22EC:
	add r5, r5, #1
_027F22F0:
	ldr r0, [r11, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x22]
	cmp r5, r0
	blo _027F22CC
	b _027F2320
_027F2308:
	ldrh r0, [r4, #8]
	cmp r0, #0x20
	bls _027F2320
	mov r0, #0x20
	bl WSetStaState
	bl WClearAids
_027F2320:
	ldrh r0, [r8, #0]
	cmp r0, #0x41
	bne _027F2364
	ldr r0, [r8, #4]
	cmp r10, r0
	bne _027F2364
	ldrh r0, [r10, #8]
	ands r0, r0, #2
	moveq r1, #0
	ldreq r0, [r8, #0x1c]
	streqh r1, [r0, #4]
	movne r1, #0xc
	ldrne r0, [r8, #0x1c]
	strneh r1, [r0, #4]
	mov r0, #0
	strh r0, [r8]
	bl IssueMlmeConfirm
_027F2364:
	ldrh r0, [r10, #0]
	cmp r0, #1
	bne _027F23B4
	cmp r6, #0
	beq _027F23A4
	ldr r0, _027F2418 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x500
	ldrh r2, [r0, #0x34]
	mov r1, #1
	mvn r1, r1, lsl r6
	and r1, r2, r1
	strh r1, [r0, #0x34]
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	bl CAM_Delete
_027F23A4:
	add r0, r10, #0x18
	mov r1, #1
	bl MLME_IssueDeAuthIndication
	b _027F23C8
_027F23B4:
	cmp r0, #2
	bne _027F23C8
	add r0, r10, #0x18
	ldrh r1, [r10, #0x2c]
	bl MLME_IssueDeAuthIndication
_027F23C8:
	mov r0, r10
	bl CAM_DecFrameCount
	mov r0, r7
	sub r1, r10, #0x10
	bl ReleaseHeapBuf
	mov r1, #0
	ldr r0, _027F2418 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x400
	strh r1, [r0, #0x40]
	cmp r9, #0
	beq _027F240C
	ldrh r0, [r7, #8]
	cmp r0, #0
	beq _027F240C
	mov r0, #1
	bl TxqPri
_027F240C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F2418: .word 0x0380FFF4
_027F241C: .word 0x00000404
_027F2420: .word 0x0000053C
	arm_func_end TxqEndManCtrl

	arm_func_start TxqEndData
TxqEndData: // 0x027F2424
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, r1
	ldr r1, _027F25B0 // =0x0380FFF4
	ldr r2, [r1, #0]
	add r7, r2, #0x194
	add r6, r2, #0x344
	ldr r1, _027F25B4 // =0x0000053C
	add r5, r2, r1
	sub r4, r9, #0x10
	bl CAM_DecFrameCount
	ldrh r0, [r9, #8]
	ands r0, r0, #2
	bne _027F24C4
	ldr r0, [r5, #0]
	add r0, r0, #1
	str r0, [r5]
	ldrh r0, [r9, #0x14]
	mov r0, r0, lsl #0x17
	movs r0, r0, lsr #0x1f
	beq _027F24A0
	ldrh r0, [r9, #0x24]
	ands r0, r0, #1
	ldrne r0, [r5, #0x14]
	addne r0, r0, #1
	strne r0, [r5, #0x14]
	ldreq r0, [r5, #0x10]
	addeq r0, r0, #1
	streq r0, [r5, #0x10]
	b _027F24D0
_027F24A0:
	ldrh r0, [r9, #0x18]
	ands r0, r0, #1
	ldrne r0, [r5, #0x14]
	addne r0, r0, #1
	strne r0, [r5, #0x14]
	ldreq r0, [r5, #0x10]
	addeq r0, r0, #1
	streq r0, [r5, #0x10]
	b _027F24D0
_027F24C4:
	ldr r0, [r5, #4]
	add r0, r0, #1
	str r0, [r5, #4]
_027F24D0:
	ldrh r0, [r9, #0x14]
	mov r0, r0, lsl #0x11
	movs r0, r0, lsr #0x1f
	ldrne r0, [r5, #0x18]
	addne r0, r0, #1
	strne r0, [r5, #0x18]
	mov r0, r7
	mov r1, r4
	bl IssueMaDataConfirm
	mov r1, #0
	ldr r0, _027F25B0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x400
	strh r1, [r0, #0x2c]
	ldrh r0, [r9, #2]
	bl CAM_GetPowerMgtMode
	cmp r0, #0
	beq _027F252C
	ldrh r0, [r9, #0x14]
	ands r0, r0, #0x2000
	bne _027F252C
	ldrh r0, [r9, #2]
	bl CAM_SetDoze
_027F252C:
	cmp r8, #0
	beq _027F25A4
	ldrh r0, [r7, #8]
	cmp r0, #0
	beq _027F254C
	mov r0, #0
	bl TxqPri
	b _027F25A4
_027F254C:
	ldrh r1, [r6, #0xc]
	ldr r0, _027F25B8 // =0x0000FFFE
	add r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bhi _027F25A4
	ldrh r0, [r6, #8]
	cmp r0, #0x40
	bne _027F25A4
	ldrh r0, [r6, #0xe]
	cmp r0, #0
	beq _027F25A4
	ldrh r0, [r6, #0x88]
	bl CAM_GetFrameCount
	cmp r0, #0
	bne _027F25A4
	ldrh r0, [r6, #0x8e]
	cmp r0, #0
	bne _027F25A4
	mov r0, #1
	bl WSetPowerState
_027F25A4:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_027F25B0: .word 0x0380FFF4
_027F25B4: .word 0x0000053C
_027F25B8: .word 0x0000FFFE
	arm_func_end TxqEndData

	arm_func_start CopyTxFrmToMacBuf
CopyTxFrmToMacBuf: // 0x027F25BC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	add r4, r5, #0x10
	ldrh r1, [r4, #0x14]
	ands r1, r1, #0x4000
	beq _027F269C
	ldr r0, _027F2714 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x50]
	cmp r0, #3
	bne _027F25F4
	bl WUpdateCounter
_027F25F4:
	ldrh r1, [r5, #0xc]
	ldr r0, _027F2718 // =0x0000FFFF
	cmp r1, r0
	bne _027F261C
	mov r0, r6
	add r1, r4, #8
	add r2, r4, #0x2c
	ldrh r3, [r4, #6]
	bl DMA_WepWriteHeaderData
	b _027F2630
_027F261C:
	mov r0, r6
	add r1, r4, #8
	ldr r2, [r4, #0x2c]
	ldrh r3, [r4, #6]
	bl DMA_WepWriteHeaderData
_027F2630:
	ldr r2, _027F271C // =0x04808044
	ldrh r1, [r2, #0]
	ldrh r0, [r2, #0]
	add r0, r1, r0, lsl #8
	strh r0, [r6, #0x24]
	ldrh r0, [r2, #0]
	and r2, r0, #0xff
	ldr r1, _027F2714 // =0x0380FFF4
	ldr r0, [r1, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x36]
	orr r0, r2, r0, lsl #14
	strh r0, [r6, #0x26]
	ldr r0, [r1, #0]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #8
	beq _027F26D0
	add r1, r6, #0xc
	ldrh r0, [r4, #0x12]
	add r0, r1, r0
	sub r0, r0, #7
	bic r1, r0, #1
	mov r0, #0
	strh r0, [r1]
	strh r0, [r1, #2]
	b _027F26D0
_027F269C:
	ldrh r2, [r5, #0xc]
	ldr r1, _027F2718 // =0x0000FFFF
	cmp r2, r1
	bne _027F26C0
	add r1, r4, #8
	ldrh r2, [r4, #6]
	add r2, r2, #0x24
	bl DMA_Write
	b _027F26D0
_027F26C0:
	add r1, r4, #8
	ldr r2, [r4, #0x2c]
	ldrh r3, [r4, #6]
	bl DMA_WriteHeaderData
_027F26D0:
	ldr r0, _027F2714 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #4
	beq _027F270C
	add r1, r6, #0xc
	ldrh r0, [r4, #0x12]
	add r0, r1, r0
	sub r0, r0, #1
	bic r1, r0, #3
	ldr r0, _027F2720 // =0x0000B6B8
	strh r0, [r1]
	ldr r0, _027F2724 // =0x00001D46
	strh r0, [r1, #2]
_027F270C:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F2714: .word 0x0380FFF4
_027F2718: .word 0x0000FFFF
_027F271C: .word 0x04808044
_027F2720: .word 0x0000B6B8
_027F2724: .word 0x00001D46
	arm_func_end CopyTxFrmToMacBuf

	arm_func_start TxqPri
TxqPri: // 0x027F2728
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r10, r0
	ldr r0, _027F2968 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r9, r1, #0x344
	ldr r0, _027F296C // =0x0000042C
	add r8, r1, r0
	mov r0, #0x14
	mla r7, r10, r0, r8
	add r1, r1, #0x194
	mov r0, #0xc
	mla r11, r10, r0, r1
	ldrh r0, [r11, #8]
	cmp r0, #0
	beq _027F295C
	mov r0, #0x1000000
	bl OS_DisableIrqMask
	str r0, [sp, #8]
	ldrh r1, [r7, #0]
	cmp r1, #0
	beq _027F2788
	bl OS_EnableIrqMask
	b _027F295C
_027F2788:
	ldr r0, [r11, #0]
	str r0, [sp, #4]
	mov r4, #2
	mov r0, #0
	str r0, [sp, #0xc]
_027F279C:
	mvn r1, #0
	ldr r0, [sp, #4]
	cmp r0, r1
	bne _027F27B8
	ldr r0, [sp, #8]
	bl OS_EnableIrqMask
	b _027F295C
_027F27B8:
	str r0, [sp]
	bl GetHeapBufNextAdrs
	str r0, [sp, #4]
	ldr r0, [sp]
	add r6, r0, #0x10
	ldrh r5, [r6, #2]
	ldr r1, [r9, #0xa8]
	ldrh r0, [r6, #4]
	sub r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	ldrh r1, [r9, #0x8c]
	cmp r2, r1
	bls _027F2800
	ldrh r0, [r6, #0x14]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1e
	bne _027F2808
_027F2800:
	cmp r2, r1, lsl #3
	bls _027F283C
_027F2808:
	ldrh r0, [r8, #0xae]
	add r0, r0, #1
	strh r0, [r8, #0xae]
	strh r4, [r6, #8]
	ldrh r0, [r7, #4]
	add r0, r0, #1
	strh r0, [r7, #4]
	mov r0, r6
	ldr r1, [sp, #0xc]
	ldr r2, [r7, #0x10]
	mov lr, pc
	bx r2
_27F2838: // 0x027F2838
	b _027F279C
_027F283C:
	cmp r10, #0
	beq _027F285C
	cmp r10, #1
	bne _027F2898
	mov r0, r5
	bl CAM_GetStaState
	cmp r0, #0x40
	bne _027F2898
_027F285C:
	mov r0, r5
	bl CAM_IsActive
	cmp r0, #0
	beq _027F279C
	mov r0, r5
	bl CAM_GetStaState
	cmp r0, #0x40
	beq _027F2898
	strh r4, [r6, #8]
	mov r0, r11
	sub r1, r6, #0x10
	bl IssueMaDataConfirm
	mov r0, r6
	bl CAM_DecFrameCount
	b _027F279C
_027F2898:
	mov r0, #1
	strh r0, [r7]
	ldrh r0, [r7, #2]
	add r0, r0, #1
	strh r0, [r7, #2]
	str r6, [r7, #0xc]
	ldr r4, [r7, #8]
	ldrh r0, [r9, #0x10]
	cmp r0, #0
	bne _027F28C8
	mov r0, #2
	bl WSetPowerState
_027F28C8:
	mov r0, r4
	ldr r1, [sp]
	bl CopyTxFrmToMacBuf
	ldrh r0, [r9, #0xc]
	cmp r0, #1
	bne _027F28F8
	mov r0, r5
	bl CAM_GetFrameCount
	cmp r0, #1
	ldrhih r0, [r4, #0xc]
	orrhi r0, r0, #0x2000
	strhih r0, [r4, #0xc]
_027F28F8:
	ldrh r3, [r6, #0x14]
	ldr r0, _027F2970 // =0x048080A0
	add r0, r0, r10, lsl #2
	ldr r1, _027F2974 // =0x00003FFF
	and r1, r4, r1
	mov r2, r1, lsr #1
	and r1, r3, #0xc
	cmp r1, #4
	moveq r1, r2, lsl #0x10
	moveq r1, r1, lsr #0x10
	orreq r1, r1, #0xa000
	streqh r1, [r0]
	beq _027F2954
	and r1, r3, #0xfc
	cmp r1, #0x50
	moveq r1, r2, lsl #0x10
	moveq r1, r1, lsr #0x10
	orreq r1, r1, #0x9000
	streqh r1, [r0]
	movne r1, r2, lsl #0x10
	movne r1, r1, lsr #0x10
	orrne r1, r1, #0x8000
	strneh r1, [r0]
_027F2954:
	ldr r0, [sp, #8]
	bl OS_EnableIrqMask
_027F295C:
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F2968: .word 0x0380FFF4
_027F296C: .word 0x0000042C
_027F2970: .word 0x048080A0
_027F2974: .word 0x00003FFF
	arm_func_end TxqPri

	arm_func_start DefragTimerTask
DefragTimerTask: // 0x027F2978
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r4, _027F29E8 // =0x0380FFF4
	ldr r1, [r4, #0]
	ldr r0, _027F29EC // =0x000004E4
	add r6, r1, r0
	mov r5, #0
	mov r7, #0x18
_027F2998:
	mul r0, r5, r7
	add r1, r6, r0
	ldrh r0, [r6, r0]
	cmp r0, #0
	beq _027F29D0
	sub r0, r0, #1
	strh r0, [r1]
	ldrh r0, [r1, #0]
	cmp r0, #0
	bne _027F29D0
	ldr r0, [r4, #0]
	add r0, r0, #0x188
	ldr r1, [r1, #0x14]
	bl ReleaseHeapBuf
_027F29D0:
	add r5, r5, #1
	cmp r5, #3
	blo _027F2998
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027F29E8: .word 0x0380FFF4
_027F29EC: .word 0x000004E4
	arm_func_end DefragTimerTask

	arm_func_start MoreDefragment
MoreDefragment: // 0x027F29F0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	mov r9, r1
	ldr r0, _027F2C24 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r8, r1, #0x17c
	ldr r0, _027F2C28 // =0x000004E4
	add r7, r1, r0
	ldrh r0, [r10, #8]
	sub r0, r0, #0x18
	strh r0, [r10, #8]
	mov r6, #0
	b _027F2AC8
_027F2A28:
	mov r0, #0x18
	mul r0, r6, r0
	str r0, [sp, #4]
	add r4, r7, r0
	ldrh r0, [r7, r0]
	cmp r0, #0
	beq _027F2AC4
	add r0, r4, #4
	mov r1, r9
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F2AC4
	add r0, r4, #0xa
	add r1, r9, #6
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F2AC4
	ldrh r0, [r9, #0xc]
	mov r1, r0, lsl #0x10
	mov r2, r1, lsr #0x14
	ldrh r1, [r4, #0x10]
	mov r1, r1, lsl #0x10
	cmp r2, r1, lsr #20
	bne _027F2AC4
	ldr r1, [sp, #4]
	add r2, r7, r1
	ldrh r1, [r2, #0x10]
	sub r11, r1, r0
	ands r0, r11, #0x80000000
	bne _027F2C18
	ldrh r0, [r2, #2]
	mul r0, r11, r0
	str r0, [sp]
	ldrh r1, [r10, #8]
	subs r5, r1, r0
	beq _027F2C18
	ands r0, r5, #0x80000000
	beq _027F2AD0
	b _027F2C18
_027F2AC4:
	add r6, r6, #1
_027F2AC8:
	cmp r6, #3
	blo _027F2A28
_027F2AD0:
	cmp r6, #3
	beq _027F2C18
	mov r0, #0x18
	mul r4, r6, r0
	add r0, r7, r4
	ldr r0, [r0, #0x14]
	add r6, r0, #0x10
	ldrh r1, [r6, #0x10]
	add r9, r1, r5
	ldr r0, _027F2C2C // =0x000005E4
	cmp r9, r0
	bls _027F2B18
	add r0, r8, #0xc
	sub r1, r6, #0x10
	bl ReleaseHeapBuf
	mov r0, #0
	strh r0, [r7, r4]
	b _027F2C18
_027F2B18:
	add r2, r10, #0x24
	ldr r0, [sp]
	add r0, r2, r0
	add r2, r6, #0x2c
	add r1, r2, r1
	add r2, r5, #1
	bl MIi_CpuCopy16
	strh r9, [r6, #0x10]
	ldrh r0, [r10, #0]
	and r0, r0, #0xf0
	mov r1, #0x10
	bl _s32_div_f
	add r2, r7, r4
	ldrh r3, [r2, #0x10]
	bic r1, r3, #0xf
	mov r4, r3, lsl #0x1c
	sub r3, r0, r11
	add r3, r3, r4, lsr #28
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	and r3, r3, #0xf
	orr r1, r1, r3
	strh r1, [r2, #0x10]
	ldr r1, _027F2C24 // =0x0380FFF4
	ldr r3, [r1, #0]
	ldr r1, [r3, #0x560]
	add r0, r1, r0
	str r0, [r3, #0x560]
	ldrh r0, [r10, #0]
	ands r0, r0, #0x100
	bne _027F2C18
	mov r0, #0
	strh r0, [r2]
	ldrh r0, [r6, #8]
	bic r0, r0, #0xf0
	add r0, r0, #0x10
	strh r0, [r6, #8]
	ldrh r0, [r6, #0x10]
	add r0, r0, #0x18
	strh r0, [r6, #0x10]
	ldrh r0, [r6, #8]
	ands r0, r0, #0xf
	beq _027F2BEC
	cmp r0, #8
	bne _027F2C0C
	add r0, r8, #0xc
	add r1, r8, #0x48
	sub r2, r6, #0x10
	bl MoveHeapBuf
	mov r0, #2
	mov r1, #6
	bl AddTask
	b _027F2C18
_027F2BEC:
	add r0, r8, #0xc
	add r1, r8, #0x60
	sub r2, r6, #0x10
	bl MoveHeapBuf
	mov r0, #1
	mov r1, #7
	bl AddTask
	b _027F2C18
_027F2C0C:
	add r0, r8, #0xc
	sub r1, r6, #0x10
	bl ReleaseHeapBuf
_027F2C18:
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F2C24: .word 0x0380FFF4
_027F2C28: .word 0x000004E4
_027F2C2C: .word 0x000005E4
	arm_func_end MoreDefragment

	arm_func_start NewDefragment
NewDefragment: // 0x027F2C30
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	ldr r0, _027F2E74 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027F2E78 // =0x000004E4
	add r8, r1, r0
	mvn r6, #0
	mov r7, #0
	add r0, r9, #6
	str r0, [sp]
	mov r11, #0x18
	b _027F2D78
_027F2C68:
	mul r5, r7, r11
	add r4, r8, r5
	ldrh r0, [r8, r5]
	cmp r0, #0
	beq _027F2D70
	add r0, r4, #4
	mov r1, r9
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F2D74
	add r0, r4, #0xa
	ldr r1, [sp]
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F2D74
	ldrh r0, [r9, #0xc]
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x14
	ldrh r0, [r4, #0x10]
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #20
	bne _027F2D74
	ldrh r0, [r10, #0]
	and r0, r0, #0xf0
	mov r1, #0x10
	bl _s32_div_f
	mov r6, r0
	ldrh r0, [r4, #0x10]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1c
	subs r0, r6, r0
	beq _027F2E68
	ands r0, r0, #0x80000000
	bne _027F2E68
	mov r0, r4
	ldr r0, [r0, #0x14]
	add r7, r0, #0x10
	ldrh r2, [r7, #0x10]
	ldrh r0, [r10, #8]
	sub r0, r0, r2
	subs r5, r0, #0x18
	beq _027F2E68
	ands r0, r5, #0x80000000
	bne _027F2E68
	add r0, r10, #0x24
	add r0, r0, r2
	add r1, r7, #0x2c
	add r1, r1, r2
	mov r2, r5
	bl MIi_CpuCopy16
	ldrh r0, [r7, #0x10]
	add r0, r0, r5
	strh r0, [r7, #0x10]
	ldrh r0, [r4, #0x10]
	bic r1, r0, #0xf
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0xf
	orr r0, r1, r0
	strh r0, [r4, #0x10]
	ldr r0, _027F2E74 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, [r1, #0x560]
	add r0, r0, r6
	str r0, [r1, #0x560]
	b _027F2E68
_027F2D70:
	mov r6, r7
_027F2D74:
	add r7, r7, #1
_027F2D78:
	cmp r7, #3
	blo _027F2C68
	mvn r0, #0
	cmp r6, r0
	beq _027F2E68
	ldr r0, _027F2E74 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	ldr r1, _027F2E7C // =0x00000622
	bl AllocateHeapBuf
	movs r5, r0
	beq _027F2E60
	mov r0, #0x18
	mul r4, r6, r0
	add r6, r8, r4
	mov r0, r9
	add r1, r6, #4
	mov r2, #0x10
	bl MIi_CpuCopy16
	mov r0, #5
	strh r0, [r8, r4]
	mov r0, r6
	str r5, [r0, #0x14]
	add r5, r5, #0x10
	mov r0, r10
	add r1, r5, #8
	ldrh r2, [r10, #8]
	add r2, r2, #0xc
	bl MIi_CpuCopy16
	ldr r0, _027F2E74 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x30c]
	bl MI_WaitDma
	ldrh r0, [r5, #8]
	and r0, r0, #0xf0
	mov r1, #0x10
	bl _s32_div_f
	mov r1, r0
	ldrh r0, [r6, #0x10]
	bic r2, r0, #0xf
	mov r0, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	and r0, r0, #0xf
	orr r0, r2, r0
	strh r0, [r6, #0x10]
	ldr r0, _027F2E74 // =0x0380FFF4
	ldr r2, [r0, #0]
	ldr r0, [r2, #0x560]
	add r0, r0, r1
	str r0, [r2, #0x560]
	ldrh r0, [r10, #8]
	sub r0, r0, #0x18
	strh r0, [r5, #0x10]
	ldrh r0, [r5, #0x10]
	bl _u32_div_f
	mov r1, r6
	strh r0, [r1, #2]
	b _027F2E68
_027F2E60:
	mov r0, #4
	bl SetFatalErr
_027F2E68:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F2E74: .word 0x0380FFF4
_027F2E78: .word 0x000004E4
_027F2E7C: .word 0x00000622
	arm_func_end NewDefragment

	arm_func_start DefragTask
DefragTask: // 0x027F2E80
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	ldr r0, _027F2F94 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r7, r1, #0x17c
	ldr r6, [r7, #0x6c]
	mvn r0, #0
	cmp r6, r0
	beq _027F2F88
	add r5, r6, #0x10
	add r0, r1, #0x300
	ldrh r0, [r0, #0x4c]
	cmp r0, #0x40
	bne _027F2F64
	ldrh r1, [r5, #0x10]
	ldr r0, _027F2F98 // =0x000005FC
	cmp r1, r0
	bhi _027F2F64
	ldrh r4, [r5, #0x14]
	ands r0, r4, #0x100
	beq _027F2EF8
	add r0, sp, #0
	add r1, r5, #0x24
	bl WSetMacAdrs1
	ands r0, r4, #0x200
	bne _027F2F64
	add r0, sp, #6
	add r1, r5, #0x1e
	bl WSetMacAdrs1
	b _027F2F28
_027F2EF8:
	add r0, sp, #0
	add r1, r5, #0x18
	bl WSetMacAdrs1
	ands r0, r4, #0x200
	beq _027F2F1C
	add r0, sp, #6
	add r1, r5, #0x24
	bl WSetMacAdrs1
	b _027F2F28
_027F2F1C:
	add r0, sp, #6
	add r1, r5, #0x1e
	bl WSetMacAdrs1
_027F2F28:
	ldrh r0, [r5, #0x2a]
	strh r0, [sp, #0xc]
	ands r0, r4, #0x400
	beq _027F2F58
	ldrh r0, [r5, #0x2a]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1c
	bne _027F2F58
	add r0, r5, #8
	add r1, sp, #0
	bl NewDefragment
	b _027F2F64
_027F2F58:
	add r0, r5, #8
	add r1, sp, #0
	bl MoreDefragment
_027F2F64:
	add r0, r7, #0x6c
	mov r1, r6
	bl ReleaseHeapBuf
	ldrh r0, [r7, #0x74]
	cmp r0, #0
	beq _027F2F88
	mov r0, #2
	mov r1, #9
	bl AddTask
_027F2F88:
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027F2F94: .word 0x0380FFF4
_027F2F98: .word 0x000005FC
	arm_func_end DefragTask

	arm_func_start CheckChallengeText
CheckChallengeText: // 0x027F2F9C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r0
	ldrh r0, [r4, #2]
	bl CAM_GetAuthSeed
	bl RND_seed
	add r5, r4, #0x34
	add r0, r4, #0x33
	bl WL_ReadByte
	mov r6, r0
	mov r7, #0
	mov r4, r6, lsr #1
	b _027F2FE8
_027F2FD0:
	bl RND_rand
	ldrh r1, [r5], #2
	cmp r1, r0
	movne r0, #0
	bne _027F3018
	add r7, r7, #1
_027F2FE8:
	cmp r7, r4
	blo _027F2FD0
	ands r0, r6, #1
	beq _027F3014
	bl RND_rand
	ldrh r1, [r5, #0]
	and r1, r1, #0xff
	and r0, r0, #0xff
	cmp r1, r0
	movne r0, #0
	bne _027F3018
_027F3014:
	mov r0, #1
_027F3018:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end CheckChallengeText

	arm_func_start SetChallengeText
SetChallengeText: // 0x027F3024
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	ldr r0, _027F3094 // =0x04808044
	ldrh r1, [r0, #0]
	ldrh r0, [r0, #0]
	add r0, r1, r0, lsl #8
	mov r0, r0, lsl #0x10
	movs r6, r0, lsr #0x10
	moveq r6, #1
	mov r0, r6
	bl RND_seed
	mov r0, r5
	mov r1, r6
	bl CAM_SetAuthSeed
	add r5, r4, #0x34
	add r0, r4, #0x33
	bl WL_ReadByte
	mov r4, r0
	mov r6, #0
	b _027F3084
_027F3078:
	bl RND_rand
	strh r0, [r5], #2
	add r6, r6, #2
_027F3084:
	cmp r6, r4
	blo _027F3078
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F3094: .word 0x04808044
	arm_func_end SetChallengeText

	arm_func_start RxManCtrlTask
RxManCtrlTask: // 0x027F3098
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r0, _027F33DC // =0x0380FFF4
	ldr r1, [r0, #0]
	add r9, r1, #0x17c
	ldr r0, _027F33E0 // =0x0000053C
	add r8, r1, r0
	add r0, r1, #0x300
	ldrh r7, [r0, #0x50]
	ldr r0, [r9, #0x60]
	str r0, [sp]
	mvn r1, #0
	cmp r0, r1
	beq _027F33D0
	add r6, r0, #0x10
	add r10, r6, #0x14
	ldrh r0, [r6, #0x18]
	ands r0, r0, #1
	ldrne r0, [r8, #0x2c]
	addne r0, r0, #1
	strne r0, [r8, #0x2c]
	ldreq r0, [r8, #0x28]
	addeq r0, r0, #1
	streq r0, [r8, #0x28]
	ldrh r0, [r6, #8]
	and r0, r0, #0xf0
	mov r1, #0x10
	bl _s32_div_f
	ldr r1, [r8, #0x24]
	sub r0, r0, #1
	add r0, r1, r0
	str r0, [r8, #0x24]
	ldrh r0, [r10, #0]
	mov r1, r0, lsl #0x1c
	mov r5, r1, lsr #0x1e
	mov r0, r0, lsl #0x18
	mov r4, r0, lsr #0x1c
	add r0, r10, #0xa
	bl CAM_SearchAdd
	mov r11, r0
	strh r11, [r6, #2]
	cmp r11, #0xff
	bne _027F3198
	mov r0, #0
	strh r0, [r6, #2]
	cmp r7, #1
	bne _027F33AC
	cmp r5, #0
	bne _027F33AC
	cmp r4, #0
	beq _027F318C
	cmp r4, #4
	beq _027F3180
	cmp r4, #0xb
	bne _027F33AC
	mov r0, r6
	bl RxAuthFrame
	b _027F33AC
_027F3180:
	mov r0, r6
	bl RxProbeReqFrame
	b _027F33AC
_027F318C:
	mov r0, r6
	bl RxAssReqFrame
	b _027F33AC
_027F3198:
	bl CAM_UpdateLifeTime
	mov r0, r11, lsl #0x10
	mov r0, r0, lsr #0x10
	ldrh r1, [r6, #0x12]
	and r1, r1, #0xff
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl CAM_SetRSSI
	cmp r5, #0
	bne _027F31F0
	ldrh r0, [r6, #0x2a]
	str r0, [sp, #4]
	mov r0, r11
	bl CAM_GetLastSeqCtrl
	ldr r1, [sp, #4]
	cmp r1, r0
	ldreq r0, [r8, #0x3c]
	addeq r0, r0, #1
	streq r0, [r8, #0x3c]
	beq _027F33AC
	mov r0, r11
	bl CAM_SetLastSeqCtrl
_027F31F0:
	cmp r7, #1
	beq _027F320C
	cmp r7, #2
	beq _027F32EC
	cmp r7, #3
	beq _027F32EC
	b _027F33AC
_027F320C:
	mov r0, r11, lsl #0x10
	mov r0, r0, lsr #0x10
	ldrh r1, [r10, #0]
	mov r1, r1, lsl #0x13
	mov r1, r1, lsr #0x1f
	bl CAM_SetPowerMgtMode
	cmp r5, #0
	bne _027F32D0
	cmp r4, #0xc
	addls pc, pc, r4, lsl #2
	b _027F33AC
_027F3238: // jump table
	b _027F3278 // case 0
	b _027F33AC // case 1
	b _027F3284 // case 2
	b _027F33AC // case 3
	b _027F3290 // case 4
	b _027F329C // case 5
	b _027F33AC // case 6
	b _027F33AC // case 7
	b _027F326C // case 8
	b _027F33AC // case 9
	b _027F32AC // case 10
	b _027F32B8 // case 11
	b _027F32C4 // case 12
_027F326C:
	mov r0, r6
	bl RxBeaconFrame
	b _027F33AC
_027F3278:
	mov r0, r6
	bl RxAssReqFrame
	b _027F33AC
_027F3284:
	mov r0, r6
	bl RxReAssReqFrame
	b _027F33AC
_027F3290:
	mov r0, r6
	bl RxProbeReqFrame
	b _027F33AC
_027F329C:
	mov r0, r6
	mov r1, #0
	bl RxProbeResFrame
	b _027F33AC
_027F32AC:
	mov r0, r6
	bl RxDisAssFrame
	b _027F33AC
_027F32B8:
	mov r0, r6
	bl RxAuthFrame
	b _027F33AC
_027F32C4:
	mov r0, r6
	bl RxDeAuthFrame
	b _027F33AC
_027F32D0:
	cmp r5, #1
	bne _027F33AC
	cmp r4, #0xa
	bne _027F33AC
	mov r0, r6
	bl RxPsPollFrame
	b _027F33AC
_027F32EC:
	cmp r5, #0
	bne _027F338C
	cmp r4, #0xc
	addls pc, pc, r4, lsl #2
	b _027F33AC
_027F3300: // jump table
	b _027F33AC // case 0
	b _027F3340 // case 1
	b _027F33AC // case 2
	b _027F334C // case 3
	b _027F33AC // case 4
	b _027F3358 // case 5
	b _027F33AC // case 6
	b _027F33AC // case 7
	b _027F3334 // case 8
	b _027F33AC // case 9
	b _027F3368 // case 10
	b _027F3374 // case 11
	b _027F3380 // case 12
_027F3334:
	mov r0, r6
	bl RxBeaconFrame
	b _027F33AC
_027F3340:
	mov r0, r6
	bl RxAssResFrame
	b _027F33AC
_027F334C:
	mov r0, r6
	bl RxReAssResFrame
	b _027F33AC
_027F3358:
	mov r0, r6
	mov r1, #0
	bl RxProbeResFrame
	b _027F33AC
_027F3368:
	mov r0, r6
	bl RxDisAssFrame
	b _027F33AC
_027F3374:
	mov r0, r6
	bl RxAuthFrame
	b _027F33AC
_027F3380:
	mov r0, r6
	bl RxDeAuthFrame
	b _027F33AC
_027F338C:
	cmp r5, #1
	bne _027F33AC
	cmp r4, #0xe
	beq _027F33A4
	cmp r4, #0xf
	bne _027F33AC
_027F33A4:
	mov r0, r6
	bl RxCfEndFrame
_027F33AC:
	add r0, r9, #0x60
	ldr r1, [sp]
	bl ReleaseHeapBuf
	ldrh r0, [r9, #0x68]
	cmp r0, #0
	beq _027F33D0
	mov r0, #1
	mov r1, #7
	bl AddTask
_027F33D0:
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F33DC: .word 0x0380FFF4
_027F33E0: .word 0x0000053C
	arm_func_end RxManCtrlTask

	arm_func_start ElementChecker
ElementChecker: // 0x027F33E4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r0, _027F3720 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r8, r0, #0x344
	ldr r7, [r9, #0]
	ldrh r0, [r8, #0x7a]
	strh r0, [r9, #0x12]
	ldrh r0, [r9, #0xc]
	ands r0, r0, #0x800
	ldrneh r0, [r9, #0xa]
	orrne r0, r0, #1
	strneh r0, [r9, #0xa]
	ldrh r6, [r9, #8]
	add r4, r9, #0xc
	add r11, r9, #0x14
	b _027F3690
_027F342C:
	mov r0, r7
	bl WL_ReadByte
	mov r10, r0
	add r0, r7, #1
	add r7, r7, #2
	bl WL_ReadByte
	mov r5, r0
	cmp r10, #6
	addls pc, pc, r10, lsl #2
	b _027F3470
_027F3454: // jump table
	b _027F347C // case 0
	b _027F34E8 // case 1
	b _027F3684 // case 2
	b _027F3554 // case 3
	b _027F35C8 // case 4
	b _027F35A8 // case 5
	b _027F3684 // case 6
_027F3470:
	cmp r10, #0xdd
	beq _027F35E8
	b _027F3668
_027F347C:
	cmp r5, #0x20
	bhi _027F3684
	ldrh r0, [r4, #0]
	orr r0, r0, #1
	strh r0, [r4]
	sub r0, r7, #2
	str r0, [r9, #0x1c]
	cmp r5, #0
	bne _027F34B8
	ldrh r0, [r9, #0xc]
	ands r0, r0, #0x800
	ldrneh r0, [r9, #0xa]
	orrne r0, r0, #1
	strneh r0, [r9, #0xa]
	bne _027F3684
_027F34B8:
	ldrh r0, [r9, #0xa]
	bic r0, r0, #1
	strh r0, [r9, #0xa]
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r7
	bl WCheckSSID
	cmp r0, #0
	ldrneh r0, [r9, #0xa]
	orrne r0, r0, #1
	strneh r0, [r9, #0xa]
	b _027F3684
_027F34E8:
	cmp r5, #1
	blo _027F3684
	ldrh r0, [r4, #0]
	orr r0, r0, #4
	strh r0, [r4]
	sub r0, r7, #2
	mov r1, r11
	bl WElement2RateSet
	ldrh r1, [r9, #0x14]
	ldrh r0, [r8, #0x60]
	ldrh r2, [r8, #0x62]
	orr r2, r0, r2
	mvn r2, r2
	ands r2, r1, r2
	bne _027F3544
	ldrh r2, [r9, #0x16]
	orr r1, r1, r2
	and r1, r0, r1
	cmp r0, r1
	ldreqh r0, [r9, #0xa]
	orreq r0, r0, #4
	streqh r0, [r9, #0xa]
	beq _027F3684
_027F3544:
	ldrh r0, [r9, #0xa]
	bic r0, r0, #4
	strh r0, [r9, #0xa]
	b _027F3684
_027F3554:
	cmp r5, #1
	blo _027F3684
	ldrh r0, [r4, #0]
	orr r0, r0, #2
	strh r0, [r4]
	mov r0, r7
	bl WL_ReadByte
	strh r0, [r9, #0x12]
	ldrh r1, [r9, #0x12]
	ldr r0, _027F3720 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x41c]
	ldrh r0, [r0, #0x4a]
	cmp r1, r0
	ldreqh r0, [r9, #0xa]
	orreq r0, r0, #2
	streqh r0, [r9, #0xa]
	ldrneh r0, [r9, #0xa]
	bicne r0, r0, #2
	strneh r0, [r9, #0xa]
	b _027F3684
_027F35A8:
	cmp r5, #3
	blo _027F3684
	ldrh r0, [r9, #0xc]
	orr r0, r0, #0x100
	strh r0, [r9, #0xc]
	sub r0, r7, #2
	str r0, [r9, #0x24]
	b _027F3684
_027F35C8:
	cmp r5, #6
	blo _027F3684
	ldrh r0, [r9, #0xc]
	orr r0, r0, #0x200
	strh r0, [r9, #0xc]
	sub r0, r7, #2
	str r0, [r9, #0x20]
	b _027F3684
_027F35E8:
	cmp r5, #8
	blo _027F3630
	mov r0, r7
	bl WL_ReadByte
	cmp r0, #0
	bne _027F3630
	add r0, r7, #1
	bl WL_ReadByte
	cmp r0, #9
	bne _027F3630
	add r0, r7, #2
	bl WL_ReadByte
	cmp r0, #0xbf
	bne _027F3630
	add r0, r7, #3
	bl WL_ReadByte
	cmp r0, #0
	beq _027F3650
_027F3630:
	ldrh r0, [r9, #0x18]
	add r0, r0, #1
	strh r0, [r9, #0x18]
	ldrh r1, [r9, #0x1a]
	add r0, r5, #2
	add r0, r1, r0
	strh r0, [r9, #0x1a]
	b _027F3684
_027F3650:
	ldrh r0, [r9, #0xc]
	orr r0, r0, #0x400
	strh r0, [r9, #0xc]
	sub r0, r7, #2
	str r0, [r9, #0x28]
	b _027F3684
_027F3668:
	ldrh r0, [r9, #0x18]
	add r0, r0, #1
	strh r0, [r9, #0x18]
	ldrh r1, [r9, #0x1a]
	add r0, r5, #2
	add r0, r1, r0
	strh r0, [r9, #0x1a]
_027F3684:
	add r7, r7, r5
	add r0, r5, #2
	sub r6, r6, r0
_027F3690:
	cmp r6, #0
	bgt _027F342C
	ldrh r0, [r9, #0xc]
	ands r0, r0, #8
	beq _027F36C8
	ldrh r0, [r8, #0x64]
	ands r0, r0, #1
	bne _027F36BC
	ldrh r0, [r9, #4]
	ands r0, r0, #0x8000
	beq _027F36C8
_027F36BC:
	ldrh r0, [r9, #0xa]
	orr r0, r0, #8
	strh r0, [r9, #0xa]
_027F36C8:
	ldrh r0, [r9, #0xc]
	ands r0, r0, #0x30
	beq _027F3714
	ldrh r0, [r9, #6]
	and r1, r0, #3
	ldrh r0, [r8, #0x7c]
	and r0, r0, #3
	cmp r1, r0
	ldreqh r0, [r9, #0xa]
	orreq r0, r0, #0x10
	streqh r0, [r9, #0xa]
	ldrh r0, [r9, #6]
	and r1, r0, #0x10
	ldrh r0, [r8, #0x7c]
	and r0, r0, #0x10
	cmp r1, r0
	ldreqh r0, [r9, #0xa]
	orreq r0, r0, #0x20
	streqh r0, [r9, #0xa]
_027F3714:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F3720: .word 0x0380FFF4
	arm_func_end ElementChecker

	arm_func_start RxCfEndFrame
RxCfEndFrame: // 0x027F3724
	bx lr
	arm_func_end RxCfEndFrame

	arm_func_start RxPsPollFrame
RxPsPollFrame: // 0x027F3728
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _027F378C // =0x0380FFF4
	ldr r1, [r1, #0]
	add r5, r1, #0x17c
	ldrh r4, [r0, #2]
	mov r0, r4
	bl CAM_GetStaState
	cmp r0, #0x40
	bne _027F3780
	mov r0, r4
	bl CAM_SetAwake
	ldrh r0, [r5, #0x2c]
	cmp r0, #0
	beq _027F376C
	mov r0, #1
	bl TxqPri
_027F376C:
	ldrh r0, [r5, #0x20]
	cmp r0, #0
	beq _027F3780
	mov r0, #0
	bl TxqPri
_027F3780:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F378C: .word 0x0380FFF4
	arm_func_end RxPsPollFrame

	arm_func_start RxDeAuthFrame
RxDeAuthFrame: // 0x027F3790
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, _027F3848 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r1, r0, #0x344
	ldrh r5, [r4, #2]
	ldrh r0, [r1, #0xc]
	cmp r0, #1
	beq _027F37CC
	cmp r0, #2
	beq _027F3804
	cmp r0, #3
	beq _027F3804
	b _027F383C
_027F37CC:
	mov r0, r5
	bl CAM_GetStaState
	cmp r0, #0x20
	bls _027F383C
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x20
	bl CAM_SetStaState
	add r0, r4, #0x1e
	ldrh r1, [r4, #0x2c]
	bl MLME_IssueDeAuthIndication
	mov r0, r5
	bl DeleteTxFrames
	b _027F383C
_027F3804:
	ldrh r0, [r1, #8]
	cmp r0, #0x20
	bls _027F383C
	add r0, r4, #0x1e
	add r1, r1, #0x82
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F383C
	mov r0, #0x20
	bl WSetStaState
	bl WClearAids
	add r0, r4, #0x1e
	ldrh r1, [r4, #0x2c]
	bl MLME_IssueDeAuthIndication
_027F383C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F3848: .word 0x0380FFF4
	arm_func_end RxDeAuthFrame

	arm_func_start RxAuthFrame
RxAuthFrame: // 0x027F384C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	ldr r0, _027F3D78 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r9, r1, #0x344
	ldr r0, _027F3D7C // =0x00000404
	add r8, r1, r0
	add r7, r10, #0x2c
	add r0, r1, #0x600
	ldrh r0, [r0, #0x90]
	ands r0, r0, #8
	beq _027F3900
	ldr r0, _027F3D80 // =0x0000042C
	add r2, r1, r0
	ldr r0, _027F3D84 // =0x048080B0
	ldrh r1, [r0, #0]
	ands r0, r1, #1
	beq _027F38A4
	ldrh r0, [r2, #0]
	cmp r0, #0
	bne _027F3900
_027F38A4:
	ands r0, r1, #4
	beq _027F38B8
	ldrh r0, [r2, #0x14]
	cmp r0, #0
	bne _027F3900
_027F38B8:
	ands r0, r1, #8
	beq _027F38CC
	ldrh r0, [r2, #0x28]
	cmp r0, #0
	bne _027F3900
_027F38CC:
	ldr r0, _027F3D88 // =0x0480819C
	ldrh r0, [r0, #0]
	ands r0, r0, #1
	bne _027F3900
	mov r2, #0
	ldr r1, _027F3D8C // =0x04808032
	strh r2, [r1]
	mov r0, #0x8000
	strh r0, [r1]
	ldr r0, _027F3D78 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x400
	strh r2, [r0, #0xde]
_027F3900:
	add r0, r10, #0x1e
	mov r1, #0xb0
	bl IsExistManFrame
	cmp r0, #0
	bne _027F3D6C
	mov r5, #0
	ldrh r0, [r7, #2]
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r11, r0, lsr #0x10
	ldrh r6, [r10, #2]
	cmp r6, #0
	moveq r4, #0x13
	moveq r5, #1
	beq _027F3D30
	ldrh r0, [r9, #0xc]
	cmp r0, #1
	bne _027F39B0
	mov r0, r6
	bl CAM_GetStaState
	cmp r0, #0x20
	bls _027F3974
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x20
	bl CAM_SetStaState
	add r0, r10, #0x1e
	mov r1, #1
	bl MLME_IssueDeAuthIndication
_027F3974:
	ldrh r0, [r10, #8]
	ands r0, r0, #0x400
	beq _027F39B0
	mov r0, r6
	bl CAM_GetAuthSeed
	cmp r0, #0
	beq _027F39B0
	mov r5, #1
	strh r5, [r7]
	mov r4, #0xf
	mov r11, #4
	mov r0, r6
	mov r1, #0
	bl CAM_SetAuthSeed
	b _027F3D30
_027F39B0:
	ldrh r0, [r7, #0]
	cmp r0, #0
	beq _027F39C8
	cmp r0, #1
	beq _027F3AC0
	b _027F3D20
_027F39C8:
	ldrh r1, [r9, #0xc]
	cmp r1, #1
	bne _027F39F4
	ldr r0, _027F3D78 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x32]
	cmp r0, #1
	moveq r4, #0xd
	moveq r5, #1
	beq _027F3D30
_027F39F4:
	cmp r1, #1
	bne _027F3A1C
	ldrh r0, [r7, #2]
	cmp r0, #1
	moveq r4, #0
	moveq r5, #1
	movne r4, #0xe
	movne r11, #2
	movne r5, #1
	b _027F3D30
_027F3A1C:
	cmp r1, #1
	beq _027F3D30
	ldrh r0, [r7, #2]
	cmp r0, #2
	bne _027F3D30
	ldr r1, [r8, #0x18]
	ldrh r0, [r1, #0x16]
	cmp r0, #0
	bne _027F3D30
	add r0, r1, #0x10
	add r1, r10, #0x1e
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F3D30
	ldrh r0, [r8, #0]
	cmp r0, #0x31
	bne _027F3D30
	bl ClearTimeOut
	ldrh r0, [r7, #4]
	cmp r0, #0
	bne _027F3A90
	mov r0, #0x30
	bl WSetStaState
	mov r1, #0
	ldr r0, [r8, #0x1c]
	strh r1, [r0, #4]
	ldr r0, [r8, #0x1c]
	strh r1, [r0, #6]
	b _027F3AA8
_027F3A90:
	mov r1, #0xc
	ldr r0, [r8, #0x1c]
	strh r1, [r0, #4]
	ldrh r1, [r7, #4]
	ldr r0, [r8, #0x1c]
	strh r1, [r0, #6]
_027F3AA8:
	mov r0, #0x35
	strh r0, [r8]
	mov r0, #2
	mov r1, r0
	bl AddTask
	b _027F3D30
_027F3AC0:
	ldrh r0, [r9, #0xc]
	cmp r0, #1
	bne _027F3BBC
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x20
	bl CAM_SetStaState
	ldrh r0, [r7, #2]
	cmp r0, #1
	bne _027F3B2C
	add r0, r10, #0x1e
	mov r1, #0x80
	mov r2, #1
	bl MakeAuthFrame
	movs r8, r0
	beq _027F3D30
	ldrh r0, [r7, #0]
	strh r0, [r8, #0x2c]
	strh r11, [r8, #0x2e]
	mov r0, #0
	strh r0, [r8, #0x30]
	mov r0, r6
	mov r1, r8
	bl SetChallengeText
	mov r0, r8
	bl TxManCtrlFrame
	b _027F3D30
_027F3B2C:
	cmp r0, #3
	bne _027F3BA0
	mov r0, r6
	bl CAM_GetStaState
	cmp r0, #0x20
	bne _027F3B54
	mov r0, r6
	bl CAM_GetAuthSeed
	cmp r0, #0
	bne _027F3B60
_027F3B54:
	mov r4, #1
	mov r5, r4
	b _027F3D30
_027F3B60:
	mov r0, r10
	bl CheckChallengeText
	cmp r0, #0
	bne _027F3B88
	mov r4, #0xf
	mov r5, #1
	mov r0, r6
	mov r1, #0
	bl CAM_SetAuthSeed
	b _027F3D30
_027F3B88:
	mov r0, r6
	mov r1, #0
	bl CAM_SetAuthSeed
	mov r4, #0
	mov r5, #1
	b _027F3D30
_027F3BA0:
	mov r0, r6
	mov r1, #0
	bl CAM_SetAuthSeed
	mov r4, #0xe
	mov r11, #2
	mov r5, #1
	b _027F3D30
_027F3BBC:
	ldr r1, [r8, #0x18]
	ldrh r0, [r1, #0x16]
	cmp r0, #1
	bne _027F3D30
	add r0, r1, #0x10
	add r1, r10, #0x1e
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F3D30
	ldrh r0, [r7, #2]
	cmp r0, #2
	bne _027F3CAC
	ldrh r0, [r8, #0]
	cmp r0, #0x31
	bne _027F3D30
	ldrh r0, [r7, #4]
	cmp r0, #0
	beq _027F3C40
	bl ClearTimeOut
	mov r0, #0x35
	strh r0, [r8]
	mov r1, #0xc
	ldr r0, [r8, #0x1c]
	strh r1, [r0, #4]
	ldrh r1, [r7, #4]
	ldr r0, [r8, #0x1c]
	strh r1, [r0, #6]
	mov r0, #2
	mov r1, r0
	bl AddTask
	mov r0, #0x20
	bl WSetStaState
	b _027F3D30
_027F3C40:
	mov r0, #0x33
	strh r0, [r8]
	add r0, r10, #0x33
	bl WL_ReadByte
	mov r1, r0
	add r0, r10, #0x1e
	mov r2, #1
	bl MakeAuthFrame
	movs r6, r0
	beq _027F3D30
	ldrh r0, [r6, #0x14]
	orr r0, r0, #0x4000
	strh r0, [r6, #0x14]
	add r0, r10, #0x2c
	add r1, r6, #0x2c
	ldrh r2, [r10, #6]
	add r2, r2, #1
	bl MIi_CpuCopy16
	ldrh r0, [r7, #0]
	strh r0, [r6, #0x2c]
	mov r0, #3
	strh r0, [r6, #0x2e]
	mov r0, #0
	strh r0, [r6, #0x30]
	mov r0, r6
	bl TxManCtrlFrame
	b _027F3D30
_027F3CAC:
	cmp r0, #4
	bne _027F3D30
	ldrh r0, [r8, #0]
	cmp r0, #0x33
	bne _027F3D30
	bl ClearTimeOut
	ldrh r0, [r7, #4]
	cmp r0, #0
	bne _027F3CF0
	mov r0, #0x30
	bl WSetStaState
	mov r1, #0
	ldr r0, [r8, #0x1c]
	strh r1, [r0, #4]
	ldr r0, [r8, #0x1c]
	strh r1, [r0, #6]
	b _027F3D08
_027F3CF0:
	mov r1, #0xc
	ldr r0, [r8, #0x1c]
	strh r1, [r0, #4]
	ldrh r1, [r7, #4]
	ldr r0, [r8, #0x1c]
	strh r1, [r0, #6]
_027F3D08:
	mov r0, #0x35
	strh r0, [r8]
	mov r0, #2
	mov r1, r0
	bl AddTask
	b _027F3D30
_027F3D20:
	ldrh r0, [r9, #0xc]
	cmp r0, #1
	moveq r4, #0xd
	moveq r5, #1
_027F3D30:
	cmp r5, #0
	beq _027F3D6C
	cmp r4, #0
	movne r2, #1
	moveq r2, #0
	add r0, r10, #0x1e
	mov r1, #0
	bl MakeAuthFrame
	cmp r0, #0
	beq _027F3D6C
	ldrh r1, [r7, #0]
	strh r1, [r0, #0x2c]
	strh r11, [r0, #0x2e]
	strh r4, [r0, #0x30]
	bl TxManCtrlFrame
_027F3D6C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F3D78: .word 0x0380FFF4
_027F3D7C: .word 0x00000404
_027F3D80: .word 0x0000042C
_027F3D84: .word 0x048080B0
_027F3D88: .word 0x0480819C
_027F3D8C: .word 0x04808032
	arm_func_end RxAuthFrame

	arm_func_start RxProbeResFrame
RxProbeResFrame: // 0x027F3D90
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r5, r0
	mov r10, r1
	ldr r0, _027F4174 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027F4178 // =0x00000404
	add r9, r1, r0
	add r0, r1, #0x400
	ldrh r0, [r0, #4]
	cmp r0, #0x13
	bne _027F4168
	ldr r8, [r9, #0x1c]
	add r4, r5, #0x2c
	ldr r0, [r9, #0x18]
	add r6, r0, #0x4e
	mov r7, #0
	add r11, r5, #0x24
	b _027F3E08
_027F3DDC:
	mov r0, r6
	mov r1, r11
	bl MatchMacAdrs
	cmp r0, #0
	ldrneh r1, [r8, #6]
	movne r0, #1
	orrne r0, r1, r0, lsl r7
	strneh r0, [r8, #6]
	bne _027F4168
	add r6, r6, #6
	add r7, r7, #1
_027F3E08:
	ldr r0, [r9, #0x18]
	ldrh r0, [r0, #0x4c]
	cmp r7, r0
	blo _027F3DDC
	add r7, r8, #0xa
	mov r6, #0
	add r11, r5, #0x24
	b _027F3E48
_027F3E28:
	mov r0, r11
	add r1, r7, #4
	bl MatchMacAdrs
	cmp r0, #0
	bne _027F4168
	ldrh r0, [r7, #0]
	add r7, r7, r0, lsl #1
	add r6, r6, #1
_027F3E48:
	ldrh r0, [r8, #8]
	cmp r6, r0
	blo _027F3E28
	mov r0, #0
	mov r1, r7
	mov r2, #0x40
	bl MIi_CpuClear16
	ldrh r6, [r5, #6]
	cmp r6, #0xc
	bls _027F4168
	cmp r10, #0
	bne _027F3EC4
	mov r0, #0
	add r1, sp, #8
	mov r2, #0x2c
	bl MIi_CpuClear32
	add r0, r4, #0xc
	str r0, [sp, #8]
	sub r0, r6, #0xc
	strh r0, [sp, #0x10]
	mov r0, #3
	strh r0, [sp, #0x12]
	mov r0, #0x38
	strh r0, [sp, #0x14]
	ldrh r0, [r5, #8]
	strh r0, [sp, #0xc]
	ldrh r0, [r4, #0xa]
	strh r0, [sp, #0xe]
	add r0, sp, #8
	bl ElementChecker
	add r10, sp, #8
_027F3EC4:
	ldr r0, [r10, #0x28]
	cmp r0, #0
	ldreqh r0, [r10, #0x1a]
	addeq r0, r0, #0x41
	moveq r0, r0, lsr #1
	streqh r0, [r7]
	beq _027F3F00
	add r0, r0, #1
	bl WL_ReadByte
	sub r0, r0, #8
	strh r0, [r7, #0x3c]
	ldrh r0, [r7, #0x3c]
	add r0, r0, #0x41
	mov r0, r0, lsr #1
	strh r0, [r7]
_027F3F00:
	ldrh r0, [r10, #0xa]
	and r0, r0, #1
	cmp r0, #1
	bne _027F415C
	ldr r0, _027F4174 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x400
	ldrh r1, [r0, #8]
	ldrh r0, [r7, #0]
	cmp r1, r0
	blo _027F415C
	ldrh r0, [r4, #0xa]
	strh r0, [r7, #0x2c]
	add r0, r7, #4
	add r1, r5, #0x24
	bl WSetMacAdrs1
	ldrh r0, [r4, #8]
	strh r0, [r7, #0x32]
	ldrh r0, [r5, #0x12]
	and r0, r0, #0xff
	strh r0, [r7, #2]
	ldr r0, [r10, #0x28]
	cmp r0, #0
	beq _027F3F9C
	mov r4, #0
	add r5, r7, #0x40
	b _027F3F8C
_027F3F6C:
	ldr r0, [r10, #0x28]
	add r0, r0, #0xa
	add r0, r0, r4
	bl WL_ReadByte
	mov r1, r0
	add r0, r5, r4
	bl WL_WriteByte
	add r4, r4, #1
_027F3F8C:
	ldrh r0, [r7, #0x3c]
	cmp r4, r0
	blo _027F3F6C
	b _027F4044
_027F3F9C:
	ldrh r0, [r10, #0x18]
	strh r0, [r7, #0x3e]
	ldrh r0, [r10, #0x18]
	cmp r0, #0
	beq _027F4044
	add r6, r4, #0xc
	add r11, r7, #0x40
	mov r5, #0
	str r5, [sp]
	b _027F4038
_027F3FC4:
	mov r0, r6
	bl WL_ReadByte
	mov r4, r0
	add r0, r6, #1
	bl WL_ReadByte
	cmp r4, #6
	bls _027F4030
	ldr r1, [r10, #0x28]
	cmp r6, r1
	beq _027F4030
	ldr r4, [sp]
	add r0, r0, #2
	str r0, [sp, #4]
	b _027F401C
_027F3FFC:
	mov r0, r6
	bl WL_ReadByte
	mov r1, r0
	mov r0, r11
	bl WL_WriteByte
	add r11, r11, #1
	add r6, r6, #1
	add r4, r4, #1
_027F401C:
	ldr r0, [sp, #4]
	cmp r4, r0
	blo _027F3FFC
	add r5, r5, #1
	b _027F4038
_027F4030:
	add r0, r0, #2
	add r6, r6, r0
_027F4038:
	ldrh r0, [r10, #0x18]
	cmp r5, r0
	blo _027F3FC4
_027F4044:
	ldr r0, [r10, #0x1c]
	cmp r0, #0
	beq _027F4098
	add r0, r0, #1
	bl WL_ReadByte
	strh r0, [r7, #0xa]
	mov r4, #0
	add r5, r7, #0xc
	b _027F4088
_027F4068:
	ldr r0, [r10, #0x1c]
	add r0, r0, #2
	add r0, r0, r4
	bl WL_ReadByte
	mov r1, r0
	add r0, r5, r4
	bl WL_WriteByte
	add r4, r4, #1
_027F4088:
	ldrh r0, [r7, #0xa]
	cmp r4, r0
	blo _027F4068
	b _027F40C0
_027F4098:
	mov r6, #0
	strh r6, [r7, #0xa]
	add r5, r7, #0xc
	mov r4, r6
_027F40A8:
	add r0, r5, r6
	mov r1, r4
	bl WL_WriteByte
	add r6, r6, #1
	cmp r6, #0x20
	blo _027F40A8
_027F40C0:
	ldrh r0, [r10, #0x14]
	strh r0, [r7, #0x2e]
	ldrh r0, [r10, #0x16]
	strh r0, [r7, #0x30]
	ldrh r0, [r10, #0x12]
	strh r0, [r7, #0x36]
	ldr r0, [r10, #0x20]
	cmp r0, #0
	beq _027F40F0
	add r0, r0, #3
	bl WL_ReadByte
	strh r0, [r7, #0x38]
_027F40F0:
	ldr r0, [r10, #0x24]
	cmp r0, #0
	beq _027F4108
	add r0, r0, #3
	bl WL_ReadByte
	strh r0, [r7, #0x34]
_027F4108:
	ldrh r1, [r8, #2]
	ldrh r0, [r7, #0]
	add r0, r1, r0
	strh r0, [r8, #2]
	ldrh r0, [r8, #8]
	add r0, r0, #1
	strh r0, [r8, #8]
	ldrh r1, [r9, #4]
	ldrh r0, [r7, #0]
	sub r0, r1, r0
	strh r0, [r9, #4]
	ldrh r0, [r9, #4]
	cmp r0, #0x20
	bhs _027F4168
	bl ClearTimeOut
	mov r0, #0x15
	strh r0, [r9]
	mov r0, #2
	mov r1, #0
	bl AddTask
	b _027F4168
_027F415C:
	add r0, r7, #4
	ldr r1, _027F417C // =NULL_ADRS
	bl WSetMacAdrs1
_027F4168:
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F4174: .word 0x0380FFF4
_027F4178: .word 0x00000404
_027F417C: .word NULL_ADRS
	arm_func_end RxProbeResFrame

	arm_func_start RxProbeReqFrame
RxProbeReqFrame: // 0x027F4180
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x30
	mov r4, r0
	add r0, r4, #0x1e
	mov r1, #0x50
	bl IsExistManFrame
	cmp r0, #0
	bne _027F4224
	ldrh r0, [r4, #0x24]
	ands r0, r0, #1
	bne _027F41B8
	ldrh r0, [r4, #8]
	ands r0, r0, #0x8000
	beq _027F4224
_027F41B8:
	mov r0, #0
	add r1, sp, #0
	mov r2, #0x2c
	bl MIi_CpuClear32
	add r0, r4, #0x2c
	str r0, [sp]
	ldrh r0, [r4, #6]
	strh r0, [sp, #8]
	ldr r0, _027F4230 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x300
	ldrh r0, [r0, #0x3a]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	moveq r0, #0x800
	streqh r0, [sp, #0xc]
	add r0, sp, #0
	bl ElementChecker
	ldrh r0, [sp, #0xa]
	and r0, r0, #1
	cmp r0, #1
	bne _027F4224
	add r0, r4, #0x1e
	bl MakeProbeResFrame
	cmp r0, #0
	beq _027F4224
	bl TxManCtrlFrame
_027F4224:
	add sp, sp, #0x30
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F4230: .word 0x0380FFF4
	arm_func_end RxProbeReqFrame

	arm_func_start RxReAssResFrame
RxReAssResFrame: // 0x027F4234
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r0, _027F435C // =0x0380FFF4
	ldr r1, [r0, #0]
	add r6, r1, #0x344
	ldr r0, _027F4360 // =0x00000404
	add r5, r1, r0
	add r4, r7, #0x2c
	ldrh r0, [r6, #0xc]
	cmp r0, #2
	beq _027F426C
	cmp r0, #3
	bne _027F4350
_027F426C:
	ldrh r0, [r5, #0]
	cmp r0, #0x61
	bne _027F4350
	ldr r0, [r5, #0x18]
	add r0, r0, #0x10
	add r1, r7, #0x1e
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F4350
	bl ClearTimeOut
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _027F42EC
	ldrh r1, [r4, #4]
	ldr r0, _027F4364 // =0x00000FFF
	and r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WSetAids
	ldrh r0, [r6, #0x6a]
	bl MakePsPollFrame
	add r0, r6, #0x82
	add r1, r7, #0x1e
	bl WSetMacAdrs1
	add r0, r7, #0x1e
	bl CAM_Search
	strh r0, [r6, #0x88]
	ldrh r0, [r6, #0x88]
	mov r1, #0x40
	bl CAM_SetStaState
	mov r0, #0x40
	bl WSetStaState
_027F42EC:
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _027F4318
	mov r1, #0
	ldr r0, [r5, #0x1c]
	strh r1, [r0, #4]
	ldr r0, [r5, #0x1c]
	strh r1, [r0, #6]
	mov r0, #0x40
	bl WSetStaState
	b _027F4330
_027F4318:
	mov r1, #0xc
	ldr r0, [r5, #0x1c]
	strh r1, [r0, #4]
	ldrh r1, [r4, #2]
	ldr r0, [r5, #0x1c]
	strh r1, [r0, #6]
_027F4330:
	ldrh r1, [r6, #0x6a]
	ldr r0, [r5, #0x1c]
	strh r1, [r0, #8]
	mov r0, #0x63
	strh r0, [r5]
	mov r0, #2
	mov r1, #4
	bl AddTask
_027F4350:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027F435C: .word 0x0380FFF4
_027F4360: .word 0x00000404
_027F4364: .word 0x00000FFF
	arm_func_end RxReAssResFrame

	arm_func_start RxReAssReqFrame
RxReAssReqFrame: // 0x027F4368
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x30
	mov r8, r0
	ldr r0, _027F450C // =0x0380FFF4
	ldr r7, [r0, #0]
	ldrh r5, [r8, #6]
	add r6, r8, #0x2c
	cmp r5, #0xa
	bls _027F4500
	add r0, r7, #0x300
	ldrh r0, [r0, #0x50]
	cmp r0, #1
	bne _027F4500
	add r0, r8, #0x1e
	mov r1, #0x30
	bl IsExistManFrame
	cmp r0, #0
	bne _027F4500
	ldrh r4, [r8, #2]
	mov r0, r4
	bl CAM_GetStaState
	cmp r0, #0x30
	bhs _027F43F8
	add r0, r8, #0x1e
	mov r1, #0xc0
	bl IsExistManFrame
	cmp r0, #0
	bne _027F4500
	add r0, r8, #0x1e
	mov r1, #6
	mov r2, #1
	bl MakeDeAuthFrame
	cmp r0, #0
	beq _027F4500
	bl TxManCtrlFrame
	b _027F4500
_027F43F8:
	mov r0, r4
	bl CAM_GetStaState
	cmp r0, #0x40
	bne _027F4424
	mov r0, r4
	mov r1, #0x30
	bl CAM_SetStaState
	add r0, r8, #0x1e
	mov r1, #1
	bl MLME_IssueDisAssIndication
	b _027F4434
_027F4424:
	mov r0, r4
	bl CAM_GetAID
	cmp r0, #0
	bne _027F4500
_027F4434:
	mov r0, #0
	add r1, sp, #0
	mov r2, #0x2c
	bl MIi_CpuClear32
	add r0, r6, #0xa
	str r0, [sp]
	sub r0, r5, #0xa
	strh r0, [sp, #8]
	mov r0, #0x800
	strh r0, [sp, #0xc]
	add r0, sp, #0
	bl ElementChecker
	ldrh r1, [r6, #0]
	ldr r0, _027F4510 // =0x0000FFC2
	ands r0, r1, r0
	bne _027F44AC
	add r0, r7, #0x300
	ldrh r2, [r0, #0x34]
	cmp r2, #0
	bne _027F4494
	mov r0, r1, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _027F44AC
_027F4494:
	cmp r2, #0
	beq _027F44B4
	ldrh r0, [r6, #0]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	bne _027F44B4
_027F44AC:
	mov r1, #0xa
	b _027F44E8
_027F44B4:
	mov r0, r4
	bl CAM_SetCapaInfo
	ldrh r1, [sp, #0xa]
	ands r0, r1, #1
	moveq r1, #1
	beq _027F44E8
	ands r0, r1, #4
	moveq r1, #0x12
	beq _027F44E8
	mov r0, r4
	ldrh r1, [sp, #0x16]
	bl CAM_SetSupRate
	mov r1, #0
_027F44E8:
	mov r0, r4
	ldr r2, [sp, #0x1c]
	bl MakeReAssResFrame
	cmp r0, #0
	beq _027F4500
	bl TxManCtrlFrame
_027F4500:
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027F450C: .word 0x0380FFF4
_027F4510: .word 0x0000FFC2
	arm_func_end RxReAssReqFrame

	arm_func_start RxAssResFrame
RxAssResFrame: // 0x027F4514
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r0, _027F4634 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r6, r1, #0x344
	ldr r0, _027F4638 // =0x00000404
	add r5, r1, r0
	add r4, r7, #0x2c
	ldrh r0, [r6, #0xc]
	cmp r0, #2
	beq _027F454C
	cmp r0, #3
	bne _027F4628
_027F454C:
	ldrh r0, [r5, #0]
	cmp r0, #0x51
	bne _027F4628
	ldr r0, [r5, #0x18]
	add r0, r0, #0x10
	add r1, r7, #0x1e
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F4628
	bl ClearTimeOut
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _027F45C4
	ldrh r1, [r4, #4]
	ldr r0, _027F463C // =0x00000FFF
	and r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WSetAids
	ldrh r0, [r6, #0x6a]
	bl MakePsPollFrame
	add r0, r6, #0x82
	add r1, r7, #0x1e
	bl WSetMacAdrs1
	add r0, r7, #0x1e
	bl CAM_Search
	strh r0, [r6, #0x88]
	ldrh r0, [r6, #0x88]
	mov r1, #0x40
	bl CAM_SetStaState
_027F45C4:
	ldrh r0, [r4, #2]
	cmp r0, #0
	bne _027F45F0
	mov r1, #0
	ldr r0, [r5, #0x1c]
	strh r1, [r0, #4]
	ldr r0, [r5, #0x1c]
	strh r1, [r0, #6]
	mov r0, #0x40
	bl WSetStaState
	b _027F4608
_027F45F0:
	mov r1, #0xc
	ldr r0, [r5, #0x1c]
	strh r1, [r0, #4]
	ldrh r1, [r4, #2]
	ldr r0, [r5, #0x1c]
	strh r1, [r0, #6]
_027F4608:
	ldrh r1, [r6, #0x6a]
	ldr r0, [r5, #0x1c]
	strh r1, [r0, #8]
	mov r0, #0x53
	strh r0, [r5]
	mov r0, #2
	mov r1, #3
	bl AddTask
_027F4628:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027F4634: .word 0x0380FFF4
_027F4638: .word 0x00000404
_027F463C: .word 0x00000FFF
	arm_func_end RxAssResFrame

	arm_func_start RxAssReqFrame
RxAssReqFrame: // 0x027F4640
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x30
	mov r8, r0
	ldr r0, _027F4814 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r7, r0, #0x31c
	ldrh r5, [r8, #6]
	add r6, r8, #0x2c
	cmp r5, #4
	bls _027F4808
	add r0, r0, #0x300
	ldrh r0, [r0, #0x50]
	cmp r0, #1
	bne _027F4808
	add r0, r8, #0x1e
	mov r1, #0x10
	bl IsExistManFrame
	cmp r0, #0
	bne _027F4808
	ldrh r4, [r8, #2]
	cmp r4, #0
	beq _027F46A8
	mov r0, r4
	bl CAM_GetStaState
	cmp r0, #0x30
	bhs _027F46DC
_027F46A8:
	add r0, r8, #0x1e
	mov r1, #0xc0
	bl IsExistManFrame
	cmp r0, #0
	bne _027F4808
	add r0, r8, #0x1e
	mov r1, #6
	mov r2, #1
	bl MakeDeAuthFrame
	cmp r0, #0
	beq _027F4808
	bl TxManCtrlFrame
	b _027F4808
_027F46DC:
	mov r0, r4
	bl CAM_GetStaState
	cmp r0, #0x40
	bne _027F4708
	mov r0, r4
	mov r1, #0x30
	bl CAM_SetStaState
	add r0, r8, #0x1e
	mov r1, #1
	bl MLME_IssueDisAssIndication
	b _027F4718
_027F4708:
	mov r0, r4
	bl CAM_GetAID
	cmp r0, #0
	bne _027F4808
_027F4718:
	mov r0, #0
	add r1, sp, #0
	mov r2, #0x2c
	bl MIi_CpuClear32
	add r0, r6, #4
	str r0, [sp]
	sub r0, r5, #4
	strh r0, [sp, #8]
	add r0, sp, #0
	bl ElementChecker
	ldrh r1, [r6, #0]
	ldr r0, _027F4818 // =0x0000FFC2
	ands r0, r1, r0
	bne _027F47B4
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _027F47B4
	ldrh r2, [r7, #0x18]
	cmp r2, #0
	bne _027F4778
	mov r0, r1, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _027F47B4
_027F4778:
	cmp r2, #0
	beq _027F4790
	ldrh r0, [r6, #0]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _027F47B4
_027F4790:
	ldrh r0, [r7, #0x1e]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _027F47BC
	ldrh r0, [r6, #0]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	bne _027F47BC
_027F47B4:
	mov r1, #0xa
	b _027F47F0
_027F47BC:
	mov r0, r4
	bl CAM_SetCapaInfo
	ldrh r1, [sp, #0xa]
	ands r0, r1, #1
	moveq r1, #1
	beq _027F47F0
	ands r0, r1, #4
	moveq r1, #0x12
	beq _027F47F0
	mov r0, r4
	ldrh r1, [sp, #0x16]
	bl CAM_SetSupRate
	mov r1, #0
_027F47F0:
	mov r0, r4
	ldr r2, [sp, #0x1c]
	bl MakeAssResFrame
	cmp r0, #0
	beq _027F4808
	bl TxManCtrlFrame
_027F4808:
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_027F4814: .word 0x0380FFF4
_027F4818: .word 0x0000FFC2
	arm_func_end RxAssReqFrame

	arm_func_start RxDisAssFrame
RxDisAssFrame: // 0x027F481C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, _027F490C // =0x0380FFF4
	ldr r0, [r0, #0]
	add r1, r0, #0x344
	ldrh r5, [r4, #2]
	ldrh r0, [r1, #0xc]
	cmp r0, #1
	beq _027F4858
	cmp r0, #2
	beq _027F48C8
	cmp r0, #3
	beq _027F48C8
	b _027F4900
_027F4858:
	mov r0, r5
	bl CAM_GetStaState
	cmp r0, #0x40
	bne _027F4890
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0x30
	bl CAM_SetStaState
	add r0, r4, #0x1e
	ldrh r1, [r4, #0x2c]
	bl MLME_IssueDisAssIndication
	mov r0, r5
	bl DeleteTxFrames
	b _027F4900
_027F4890:
	cmp r0, #0x30
	bne _027F48A8
	add r0, r4, #0x1e
	mov r1, #7
	bl MakeDisAssFrame
	b _027F48B8
_027F48A8:
	add r0, r4, #0x1e
	mov r1, #7
	mov r2, #1
	bl MakeDeAuthFrame
_027F48B8:
	cmp r0, #0
	beq _027F4900
	bl TxManCtrlFrame
	b _027F4900
_027F48C8:
	ldrh r0, [r1, #8]
	cmp r0, #0x40
	bne _027F4900
	add r0, r4, #0x1e
	add r1, r1, #0x82
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F4900
	mov r0, #0x30
	bl WSetStaState
	bl WClearAids
	add r0, r4, #0x1e
	ldrh r1, [r4, #0x2c]
	bl MLME_IssueDisAssIndication
_027F4900:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F490C: .word 0x0380FFF4
	arm_func_end RxDisAssFrame

	arm_func_start RxBeaconFrame
RxBeaconFrame: // 0x027F4910
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x44
	mov r10, r0
	ldr r0, _027F4F90 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r8, r1, #0x344
	ldr r0, _027F4F94 // =0x00000404
	add r7, r1, r0
	add r6, r1, #0x31c
	add r5, r1, #0x17c
	ldr r0, [r1, #0x570]
	add r0, r0, #1
	str r0, [r1, #0x570]
	add r0, r10, #0x1e
	bl CAM_SearchAdd
	mov r4, r0
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r0, [r10, #2]
	cmp r4, #0xff
	beq _027F4F84
	ldrh r1, [r10, #0x12]
	bl CAM_SetRSSI
	add r9, r10, #0x2c
	ldrh r11, [r10, #6]
	cmp r11, #0xc
	bls _027F4F84
	mov r0, #0
	add r1, sp, #0x18
	mov r2, #0x2c
	bl MIi_CpuClear32
	add r0, r9, #0xc
	str r0, [sp, #0x18]
	sub r0, r11, #0xc
	strh r0, [sp, #0x20]
	mov r0, #2
	strh r0, [sp, #0x22]
	ldrh r0, [r8, #0x1e]
	cmp r0, #0
	ldreqh r0, [sp, #0x22]
	orreq r0, r0, #1
	streqh r0, [sp, #0x22]
	mov r0, #0x38
	strh r0, [sp, #0x24]
	ldrh r0, [r10, #8]
	strh r0, [sp, #0x1c]
	ldrh r0, [r9, #0xa]
	strh r0, [sp, #0x1e]
	add r0, sp, #0x18
	bl ElementChecker
	ldr r9, [sp, #0x38]
	cmp r9, #0
	beq _027F4A10
	ldrh r0, [r10, #0x16]
	ands r0, r0, #0x8000
	beq _027F4A10
	add r0, r9, #6
	bl WL_ReadByte
	mov r11, r0
	add r0, r9, #7
	bl WL_ReadByte
	add r1, r11, r0, lsl #8
	ldr r0, _027F4F98 // =0x0480810C
	strh r1, [r0]
_027F4A10:
	ldrh r1, [r7, #0]
	cmp r1, #0x13
	bne _027F4A4C
	ldr r0, [r7, #0x18]
	ldrh r0, [r0, #0x38]
	cmp r0, #1
	bne _027F4A4C
	ldrh r0, [sp, #0x22]
	and r0, r0, #9
	cmp r0, #9
	bne _027F4F6C
	mov r0, r10
	add r1, sp, #0x18
	bl RxProbeResFrame
	b _027F4F6C
_027F4A4C:
	ldrh r0, [sp, #0x22]
	ands r0, r0, #8
	beq _027F4F6C
	cmp r1, #0x21
	bne _027F4BD4
	bl ClearTimeOut
	ldrh r0, [sp, #0x22]
	and r0, r0, #0x30
	cmp r0, #0x30
	movne r0, #0xc
	strneh r0, [r7, #4]
	movne r0, #0xa
	strneh r0, [r7, #6]
	bne _027F4BB0
	ldrh r0, [r10, #0x34]
	cmp r0, #0x3e8
	movhi r0, #0xc
	strhih r0, [r7, #4]
	movhi r0, #1
	strhih r0, [r7, #6]
	bhi _027F4BB0
	mov r1, #0
	strh r1, [r7, #4]
	ldrh r0, [sp, #0x24]
	ands r0, r0, #2
	beq _027F4AC8
	ldrh r0, [sp, #0x22]
	ands r0, r0, #2
	bne _027F4AC8
	ldrh r0, [sp, #0x2a]
	bl WSetChannel
_027F4AC8:
	mov r0, r4
	ldrh r1, [sp, #0x2e]
	bl CAM_SetSupRate
	ldrh r0, [r8, #0xc]
	cmp r0, #2
	bne _027F4B58
	ldr r9, [sp, #0x40]
	cmp r9, #0
	beq _027F4B40
	add r0, r9, #6
	bl WL_ReadByte
	mov r11, r0
	add r0, r9, #7
	bl WL_ReadByte
	add r0, r11, r0, lsl #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #1
	bl WSetActiveZoneTime
	ldr r0, [sp, #0x40]
	add r0, r0, #8
	bl WL_ReadByte
	mov r9, r0
	ldr r0, [sp, #0x40]
	add r0, r0, #9
	bl WL_ReadByte
	add r1, r9, r0, lsl #8
	ldr r0, _027F4F9C // =0x0380FFF0
	strh r1, [r0]
	b _027F4B58
_027F4B40:
	ldr r0, _027F4FA0 // =0x0000FFFF
	mov r1, #1
	bl WSetActiveZoneTime
	mov r1, #0
	ldr r0, _027F4F9C // =0x0380FFF0
	strh r1, [r0]
_027F4B58:
	ldr r0, [sp, #0x3c]
	add r0, r0, #3
	bl WL_ReadByte
	bl WSetDTIMPeriod
	ldr r0, [sp, #0x3c]
	add r0, r0, #2
	bl WL_ReadByte
	strh r0, [r8, #0x76]
	ldrh r0, [r10, #0x34]
	bl WSetBeaconPeriod
	mov r0, #1
	strh r0, [r8, #0x12]
	strh r0, [r8, #0x1a]
	ldrh r0, [r8, #0xc]
	cmp r0, #2
	moveq r1, #3
	ldreq r0, _027F4FA4 // =0x04808048
	streqh r1, [r0]
	ldr r1, _027F4FA8 // =0x04808038
	ldrh r0, [r1, #0]
	orr r0, r0, #1
	strh r0, [r1]
_027F4BB0:
	ldr r0, [r7, #0x1c]
	add r0, r0, #8
	add r1, r10, #0x1e
	bl WSetMacAdrs1
	mov r0, #0x25
	strh r0, [r7]
	mov r0, #2
	mov r1, #1
	bl AddTask
_027F4BD4:
	ldrh r0, [r8, #0xc]
	cmp r0, #2
	beq _027F4BEC
	cmp r0, #3
	beq _027F4CA8
	b _027F4F54
_027F4BEC:
	ldr r9, [sp, #0x40]
	cmp r9, #0
	beq _027F4CA8
	add r0, r9, #6
	bl WL_ReadByte
	mov r7, r0
	add r0, r9, #7
	bl WL_ReadByte
	add r0, r7, r0, lsl #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl WSetActiveZoneTime
	ldr r0, [sp, #0x40]
	add r0, r0, #8
	bl WL_ReadByte
	mov r7, r0
	ldr r0, [sp, #0x40]
	add r0, r0, #9
	bl WL_ReadByte
	add r1, r7, r0, lsl #8
	ldr r0, _027F4F9C // =0x0380FFF0
	strh r1, [r0]
	ldr r0, [sp, #0x40]
	add r0, r0, #1
	bl WL_ReadByte
	sub r0, r0, #8
	strh r0, [r8, #0xa0]
	ldrh r2, [r8, #0xa0]
	cmp r2, #0
	beq _027F4CA8
	ldr r1, [sp, #0x40]
	ands r0, r1, #1
	beq _027F4C90
	add r0, r1, #9
	ldr r1, [r8, #0x9c]
	add r2, r2, #2
	bl MIi_CpuCopy16
	mov r0, #1
	strh r0, [r8, #0xa2]
	b _027F4CA8
_027F4C90:
	add r0, r1, #0xa
	ldr r1, [r8, #0x9c]
	add r2, r2, #1
	bl MIi_CpuCopy16
	mov r0, #0
	strh r0, [r8, #0xa2]
_027F4CA8:
	mov r0, #0
	strh r0, [r8, #0x80]
	mov r0, r4
	bl CAM_UpdateLifeTime
	add r0, r10, #0x2c
	ldmia r0, {r2, r3}
	add r0, sp, #0
	stmia r0, {r2, r3}
	ldrh r0, [r8, #0x6e]
	mov r7, r0, lsl #0xa
	mov r4, #0
	ldr r0, [sp]
	ldr r1, [sp, #4]
	mov r2, r7
	mov r3, r4
	bl _ll_udiv
	str r0, [sp]
	str r1, [sp, #4]
	mov r2, #1
	adds r3, r0, r2
	adc r2, r1, #0
	str r3, [sp]
	str r2, [sp, #4]
	umull r1, r0, r3, r7
	mla r0, r3, r4, r0
	mla r0, r2, r7, r0
	str r1, [sp]
	str r0, [sp, #4]
	add r2, sp, #0
	ldrh r1, [r2, #6]
	ldr r0, _027F4FAC // =0x048080F6
	strh r1, [r0]
	ldrh r1, [r2, #4]
	ldr r0, _027F4FB0 // =0x048080F4
	strh r1, [r0]
	ldrh r1, [r2, #2]
	ldr r0, _027F4FB4 // =0x048080F2
	strh r1, [r0]
	ldrh r0, [r2, #0]
	orr r1, r0, #1
	ldr r0, _027F4FB8 // =0x048080F0
	strh r1, [r0]
	ldrh r0, [r8, #0xc]
	cmp r0, #2
	bne _027F4E4C
	ldrh r0, [r8, #0x1a]
	cmp r0, #0
	beq _027F4E4C
	ldr r1, [sp]
	ldr r0, [sp, #4]
	subs r1, r1, r7
	sbc r0, r0, r4
	str r1, [sp]
	str r0, [sp, #4]
	bl OS_DisableInterrupts
	ldr r7, _027F4FBC // =0x048080F8
	ldrh r1, [r7, #0]
	strh r1, [sp, #8]
	ldr r4, _027F4FC0 // =0x048080FA
	ldrh r1, [r4, #0]
	strh r1, [sp, #0xa]
	ldr r3, _027F4FC4 // =0x048080FC
	ldrh r1, [r3, #0]
	strh r1, [sp, #0xc]
	ldr r2, _027F4FC8 // =0x048080FE
	ldrh r1, [r2, #0]
	strh r1, [sp, #0xe]
	ldrh r1, [r7, #0]
	strh r1, [sp, #0x10]
	ldrh r1, [r4, #0]
	strh r1, [sp, #0x12]
	ldrh r1, [r3, #0]
	strh r1, [sp, #0x14]
	ldrh r1, [r2, #0]
	strh r1, [sp, #0x16]
	bl OS_RestoreInterrupts
	ldrh r1, [sp, #8]
	ldrh r0, [sp, #0x10]
	cmp r1, r0
	bhs _027F4E0C
	ldr r3, [sp, #8]
	ldr r2, [sp, #0xc]
	ldr r1, [sp]
	ldr r0, [sp, #4]
	subs r1, r3, r1
	sbc r0, r2, r0
	mov r1, r1, lsr #0xa
	orr r1, r1, r0, lsl #22
	b _027F4E2C
_027F4E0C:
	ldr r3, [sp, #0x10]
	ldr r2, [sp, #0x14]
	ldr r1, [sp]
	ldr r0, [sp, #4]
	subs r1, r3, r1
	sbc r0, r2, r0
	mov r1, r1, lsr #0xa
	orr r1, r1, r0, lsl #22
_027F4E2C:
	ldrh r0, [r6, #0x20]
	cmp r1, r0
	sublo r1, r0, r1
	ldrlo r0, _027F4FCC // =0x04808134
	strloh r1, [r0]
	movhs r1, #0
	ldrhs r0, _027F4FCC // =0x04808134
	strhsh r1, [r0]
_027F4E4C:
	ldrh r0, [r8, #8]
	cmp r0, #0x40
	bne _027F4F54
	ldr r1, [sp, #0x3c]
	cmp r1, #0
	beq _027F4F54
	ldrh r0, [r8, #0xe]
	cmp r0, #1
	bne _027F4F54
	add r0, r1, #2
	bl WL_ReadByte
	ldrh r1, [r8, #0x76]
	cmp r1, r0
	strneh r0, [r8, #0x76]
	mov r1, #0
	strh r1, [r8, #0x8e]
	cmp r0, #0
	bne _027F4EB0
	ldr r0, [sp, #0x3c]
	add r0, r0, #4
	bl WL_ReadByte
	ands r0, r0, #1
	ldrneh r0, [r8, #0x8e]
	orrne r0, r0, #1
	strneh r0, [r8, #0x8e]
_027F4EB0:
	ldr r0, [sp, #0x3c]
	add r0, r0, #4
	bl WL_ReadByte
	and r7, r0, #0xfe
	mov r4, r7, lsl #3
	ldr r0, [sp, #0x3c]
	add r0, r0, #1
	bl WL_ReadByte
	add r0, r7, r0
	sub r0, r0, #3
	mov r1, r0, lsl #3
	ldrh r0, [r8, #0x6a]
	cmp r4, r0
	bhi _027F4F28
	cmp r0, r1
	bhi _027F4F28
	sub r4, r0, r4
	ldr r0, [sp, #0x3c]
	add r0, r0, #5
	add r0, r0, r4, lsr #3
	bl WL_ReadByte
	mov r2, #1
	and r1, r4, #7
	mov r1, r2, lsl r1
	ands r0, r1, r0
	beq _027F4F28
	ldrh r0, [r8, #0x8e]
	orr r0, r0, #2
	strh r0, [r8, #0x8e]
	bl TxPsPollFrame
_027F4F28:
	ldrh r0, [r5, #0x20]
	cmp r0, #0
	bne _027F4F54
	ldrh r0, [r5, #0x2c]
	cmp r0, #0
	bne _027F4F54
	ldrh r0, [r8, #0x8e]
	cmp r0, #0
	bne _027F4F54
	mov r0, #1
	bl WSetPowerState
_027F4F54:
	ldrh r0, [r6, #0x1e]
	mov r0, r0, lsl #0x19
	movs r0, r0, lsr #0x1f
	beq _027F4F6C
	mov r0, r10
	bl MLME_IssueBeaconRecvIndication
_027F4F6C:
	ldr r2, [sp, #0x34]
	cmp r2, #0
	beq _027F4F84
	ldrh r0, [sp, #0x2a]
	mov r1, r10
	bl UpdateApList
_027F4F84:
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F4F90: .word 0x0380FFF4
_027F4F94: .word 0x00000404
_027F4F98: .word 0x0480810C
_027F4F9C: .word 0x0380FFF0
_027F4FA0: .word 0x0000FFFF
_027F4FA4: .word 0x04808048
_027F4FA8: .word 0x04808038
_027F4FAC: .word 0x048080F6
_027F4FB0: .word 0x048080F4
_027F4FB4: .word 0x048080F2
_027F4FB8: .word 0x048080F0
_027F4FBC: .word 0x048080F8
_027F4FC0: .word 0x048080FA
_027F4FC4: .word 0x048080FC
_027F4FC8: .word 0x048080FE
_027F4FCC: .word 0x04808134
	arm_func_end RxBeaconFrame

	arm_func_start RxMpAckFrame
RxMpAckFrame: // 0x027F4FD0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, _027F50A4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r5, r0, #0x344
	add r0, r0, #0x300
	ldrh r0, [r0, #0x4c]
	cmp r0, #0x40
	movne r0, #1
	bne _027F5098
	add r0, r4, #0x1e
	add r1, r5, #0x64
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F5024
	add r0, r4, #0x24
	add r1, r5, #0x82
	bl MatchMacAdrs
	cmp r0, #0
	bne _027F502C
_027F5024:
	mov r0, #1
	b _027F5098
_027F502C:
	ldrh r0, [r4, #0x10]
	sub r0, r0, #0x1c
	strh r0, [r4, #6]
	sub r1, r4, #0x10
	ldr r0, _027F50A8 // =0x00000185
	strh r0, [r1, #0xc]
	mov r0, #0x18
	strh r0, [r1, #0xe]
	ldrh r0, [r1, #0x18]
	ldr r2, _027F50AC // =0x04808094
	ldrh r2, [r2, #0]
	and ip, r2, #0x8000
	ldr r4, _027F50A4 // =0x0380FFF4
	ldr r2, [r4, #0]
	add r2, r2, #0x400
	ldrh r3, [r2, #0xe2]
	ldr r2, _027F50B0 // =0x04808098
	ldrh r2, [r2, #0]
	and r2, r2, #0x8000
	orr r2, r3, r2, asr #4
	orr r2, r2, ip, asr #3
	orr r0, r0, r2
	strh r0, [r1, #0x18]
	ldr r0, [r4, #0]
	add r0, r0, #0x188
	bl SendMessageToWmDirect
	mov r0, #0
_027F5098:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F50A4: .word 0x0380FFF4
_027F50A8: .word 0x00000185
_027F50AC: .word 0x04808094
_027F50B0: .word 0x04808098
	arm_func_end RxMpAckFrame

	arm_func_start RxKeyDataFrame
RxKeyDataFrame: // 0x027F50B4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r0, _027F5270 // =0x0380FFF4
	ldr r1, [r0, #0]
	ldr r0, _027F5274 // =0x0000042C
	add r6, r1, r0
	ldr r0, [r6, #0x90]
	add r5, r0, #0x10
	ldrh r0, [r6, #0x3c]
	cmp r0, #0
	beq _027F5264
	add r0, r7, #0x18
	add r1, r1, #0x3a8
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F5264
	ldrh r0, [r7, #0x10]
	sub r1, r0, #0x18
	ldrh r0, [r5, #6]
	sub r0, r0, #8
	cmp r1, r0
	bgt _027F5264
	add r0, r7, #0x1e
	bl CAM_Search
	mov r4, r0
	cmp r4, #0xff
	beq _027F5138
	cmp r4, #0
	beq _027F5174
	bl CAM_GetStaState
	cmp r0, #0x40
	beq _027F5174
_027F5138:
	add r0, r7, #0x1e
	mov r1, #0xc0
	bl IsExistManFrame
	cmp r0, #0
	bne _027F5264
	add r0, r7, #0x1e
	mov r1, #7
	mov r2, #0
	bl MakeDeAuthFrame
	cmp r0, #0
	beq _027F5264
	mov r1, #2
	strh r1, [r0]
	bl TxManCtrlFrame
	b _027F5264
_027F5174:
	cmp r4, #0
	beq _027F5264
	mov r0, r4, lsl #0x10
	mov r0, r0, lsr #0x10
	ldrh r1, [r7, #0x14]
	mov r1, r1, lsl #0x13
	mov r1, r1, lsr #0x1f
	bl CAM_SetPowerMgtMode
	mov r0, r4
	bl CAM_UpdateLifeTime
	mov r0, r4
	bl CAM_GetAID
	mov r1, #1
	mov r0, r1, lsl r0
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	ldrh r1, [r6, #0x9a]
	ands r0, r2, r1
	bne _027F5264
	ldrh r0, [r6, #0x98]
	ands r0, r2, r0
	beq _027F5264
	orr r0, r1, r2
	strh r0, [r6, #0x9a]
	ldrh r1, [r5, #0]
	mvn r0, r2
	and r0, r1, r0
	strh r0, [r5]
	add r4, r5, #0xa
	mov r0, r2, lsl #0xf
	mov r1, r0, lsr #0x10
	b _027F520C
_027F51F4:
	ldrh r0, [r6, #0x98]
	ands r0, r1, r0
	ldrneh r0, [r5, #6]
	addne r4, r4, r0
	mov r0, r1, lsl #0xf
	mov r1, r0, lsr #0x10
_027F520C:
	cmp r1, #1
	bne _027F51F4
	ldrh r0, [r7, #0x10]
	sub r0, r0, #0x18
	strh r0, [r4]
	add r0, r4, #3
	ldrh r1, [r7, #0x12]
	and r1, r1, #0xff
	and r1, r1, #0xff
	bl WL_WriteByte
	add r0, r4, #2
	ldrh r1, [r7, #0xe]
	and r1, r1, #0xff
	and r1, r1, #0xff
	bl WL_WriteByte
	ldrh r2, [r4, #0]
	cmp r2, #0
	beq _027F5264
	add r0, r7, #0x2c
	add r1, r4, #8
	add r2, r2, #1
	bl MIi_CpuCopy16
_027F5264:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027F5270: .word 0x0380FFF4
_027F5274: .word 0x0000042C
	arm_func_end RxKeyDataFrame

	arm_func_start RxMpFrame
RxMpFrame: // 0x027F5278
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, _027F53F4 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r5, r1, #0x344
	ldr r0, _027F53F8 // =0x000004DC
	add r4, r1, r0
	ldrh r0, [r5, #8]
	cmp r0, #0x40
	movne r0, #1
	bne _027F53EC
	add r0, r6, #0x1e
	add r1, r5, #0x64
	bl MatchMacAdrs
	cmp r0, #0
	beq _027F52CC
	add r0, r6, #0x24
	add r1, r5, #0x82
	bl MatchMacAdrs
	cmp r0, #0
	bne _027F52D4
_027F52CC:
	mov r0, #1
	b _027F53EC
_027F52D4:
	mov r1, #1
	ldrh r0, [r5, #0x6a]
	mov r0, r1, lsl r0
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	ldrh r0, [r6, #0x2e]
	ands r0, r1, r0
	moveq r0, #0
	streqh r0, [r4, #6]
	movne r0, #0x2000
	strneh r0, [r4, #6]
	ldr r0, _027F53FC // =0x04808098
	ldrh r1, [r0, #0]
	ands r0, r1, #0x8000
	beq _027F5338
	ldr r0, _027F5400 // =0x00007FFF
	and r0, r1, r0
	mov r0, r0, lsl #1
	add r0, r0, #0x4800000
	add r0, r0, #0x4000
	ldrh r0, [r0, #4]
	cmp r0, #0
	ldrneh r0, [r4, #6]
	orrne r0, r0, #0x4000
	strneh r0, [r4, #6]
_027F5338:
	ldrh r0, [r5, #0x88]
	bl CAM_UpdateLifeTime
	ldrh r0, [r6, #0x10]
	sub r0, r0, #0x1c
	strh r0, [r6, #6]
	sub r1, r6, #0x10
	ldr r0, _027F5404 // =0x00000182
	strh r0, [r1, #0xc]
	ldrh r0, [r6, #6]
	add r0, r0, #0x31
	mov r0, r0, lsr #1
	strh r0, [r1, #0xe]
	ldrh r3, [r1, #0x3e]
	mov r0, #0
	b _027F5384
_027F5374:
	ands r2, r3, #1
	addne r0, r0, #1
	mov r2, r3, lsl #0xf
	mov r3, r2, lsr #0x10
_027F5384:
	cmp r3, #0
	bne _027F5374
	ldrh r6, [r1, #0x18]
	ldr r2, _027F5408 // =0x04808094
	ldrh r2, [r2, #0]
	and r5, r2, #0x8000
	ldrh r3, [r4, #6]
	ldr r2, _027F53FC // =0x04808098
	ldrh r2, [r2, #0]
	and r2, r2, #0x8000
	orr r2, r3, r2, asr #4
	orr r2, r2, r5, asr #3
	orr r2, r6, r2
	strh r2, [r1, #0x18]
	ldrh r3, [r1, #0x1c]
	ldrh r2, [r1, #0x3c]
	add r2, r2, #0xa
	mul r2, r0, r2
	add r0, r2, #0xfc
	add r0, r3, r0, lsr #4
	strh r0, [r1, #0x1a]
	ldr r0, _027F53F4 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	bl SendMessageToWmDirect
	mov r0, #0
_027F53EC:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F53F4: .word 0x0380FFF4
_027F53F8: .word 0x000004DC
_027F53FC: .word 0x04808098
_027F5400: .word 0x00007FFF
_027F5404: .word 0x00000182
_027F5408: .word 0x04808094
	arm_func_end RxMpFrame

	arm_func_start RxDataFrameTask
RxDataFrameTask: // 0x027F540C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r0, _027F5714 // =0x0380FFF4
	ldr r1, [r0, #0]
	add r8, r1, #0x344
	add r7, r1, #0x17c
	ldr r0, _027F5718 // =0x0000053C
	add r6, r1, r0
	ldr r10, [r7, #0x48]
	mvn r0, #0
	cmp r10, r0
	beq _027F570C
	ldrh r0, [r8, #8]
	cmp r0, #0x40
	beq _027F5454
	add r0, r7, #0x48
	mov r1, r10
	bl ReleaseHeapBuf
	b _027F570C
_027F5454:
	add r9, r10, #0x10
	ldrh r0, [r9, #0x14]
	mov r0, r0, lsl #0x17
	movs r0, r0, lsr #0x1f
	beq _027F548C
	ldrh r0, [r9, #0x24]
	ands r0, r0, #1
	ldrne r0, [r6, #0x2c]
	addne r0, r0, #1
	strne r0, [r6, #0x2c]
	ldreq r0, [r6, #0x28]
	addeq r0, r0, #1
	streq r0, [r6, #0x28]
	b _027F54AC
_027F548C:
	ldrh r0, [r9, #0x18]
	ands r0, r0, #1
	ldrne r0, [r6, #0x2c]
	addne r0, r0, #1
	strne r0, [r6, #0x2c]
	ldreq r0, [r6, #0x28]
	addeq r0, r0, #1
	streq r0, [r6, #0x28]
_027F54AC:
	ldrh r0, [r9, #8]
	and r0, r0, #0xf0
	mov r1, #0x10
	bl _s32_div_f
	ldr r1, [r6, #0x24]
	sub r0, r0, #1
	add r0, r1, r0
	str r0, [r6, #0x24]
	mov r4, #1
	ldrh r0, [r8, #0xc]
	cmp r0, #1
	beq _027F54F0
	cmp r0, #2
	beq _027F55D0
	cmp r0, #3
	beq _027F55D0
	b _027F5678
_027F54F0:
	ldrh r0, [r9, #0x14]
	ands r0, r0, #1
	bne _027F5678
	add r0, r9, #0x1e
	bl CAM_Search
	mov r5, r0
	cmp r5, #0xff
	beq _027F551C
	bl CAM_GetStaState
	cmp r0, #0x40
	beq _027F5584
_027F551C:
	mov r0, r5
	bl CAM_GetStaState
	cmp r0, #0x30
	bne _027F5550
	add r0, r9, #0x1e
	mov r1, #0xa0
	bl IsExistManFrame
	cmp r0, #0
	bne _027F5678
	add r0, r9, #0x1e
	mov r1, #7
	bl MakeDisAssFrame
	b _027F5574
_027F5550:
	add r0, r9, #0x1e
	mov r1, #0xc0
	bl IsExistManFrame
	cmp r0, #0
	bne _027F5678
	add r0, r9, #0x1e
	mov r1, #7
	mov r2, #1
	bl MakeDeAuthFrame
_027F5574:
	cmp r0, #0
	beq _027F5678
	bl TxManCtrlFrame
	b _027F5678
_027F5584:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	ldrh r1, [r9, #0x14]
	mov r1, r1, lsl #0x13
	mov r1, r1, lsr #0x1f
	bl CAM_SetPowerMgtMode
	mov r0, r5
	bl CAM_GetLastSeqCtrl
	ldrh r1, [r9, #0x2a]
	cmp r1, r0
	ldreq r0, [r6, #0x3c]
	addeq r0, r0, #1
	streq r0, [r6, #0x3c]
	beq _027F5678
	add r0, r9, #0x18
	add r1, r9, #0x24
	bl WSetMacAdrs1
	mov r4, #0
	b _027F5678
_027F55D0:
	ldrh r2, [r9, #0x14]
	ands r1, r2, #1
	bne _027F5678
	ldrh r1, [r8, #0xe]
	cmp r1, #0
	beq _027F5644
	ands r1, r2, #0x2000
	bne _027F5644
	ldrh r1, [r9, #0x18]
	ands r1, r1, #1
	ldrneh r0, [r8, #0x8e]
	bicne r0, r0, #1
	strneh r0, [r8, #0x8e]
	bne _027F5618
	cmp r0, #3
	ldrneh r0, [r8, #0x8e]
	bicne r0, r0, #2
	strneh r0, [r8, #0x8e]
_027F5618:
	ldrh r0, [r8, #0x8e]
	cmp r0, #0
	bne _027F5644
	ldrh r0, [r7, #0x20]
	cmp r0, #0
	bne _027F5644
	ldrh r0, [r7, #0x2c]
	cmp r0, #0
	bne _027F5644
	mov r0, #1
	bl WSetPowerState
_027F5644:
	ldrh r5, [r8, #0x88]
	mov r0, r5
	bl CAM_GetLastSeqCtrl
	ldrh r1, [r9, #0x2a]
	cmp r1, r0
	ldreq r0, [r6, #0x3c]
	addeq r0, r0, #1
	streq r0, [r6, #0x3c]
	beq _027F5678
	add r0, r9, #0x1e
	add r1, r9, #0x24
	bl WSetMacAdrs1
	mov r4, #0
_027F5678:
	cmp r4, #0
	bne _027F56E8
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r0, [r9, #2]
	ldrh r1, [r9, #0x12]
	and r1, r1, #0xff
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl CAM_SetRSSI
	mov r0, r5
	ldrh r1, [r9, #0x2a]
	bl CAM_SetLastSeqCtrl
	mov r0, r5
	bl CAM_UpdateLifeTime
	ldrh r0, [r9, #0x10]
	sub r0, r0, #0x18
	strh r0, [r9, #6]
	mov r0, #0x180
	strh r0, [r10, #0xc]
	ldrh r0, [r9, #6]
	add r0, r0, #0x2d
	mov r0, r0, lsr #1
	strh r0, [r10, #0xe]
	add r0, r7, #0x48
	mov r1, r10
	bl SendMessageToWmDirect
	b _027F56F4
_027F56E8:
	add r0, r7, #0x48
	mov r1, r10
	bl ReleaseHeapBuf
_027F56F4:
	ldrh r0, [r7, #0x50]
	cmp r0, #0
	beq _027F570C
	mov r0, #2
	mov r1, #6
	bl AddTask
_027F570C:
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_027F5714: .word 0x0380FFF4
_027F5718: .word 0x0000053C
	arm_func_end RxDataFrameTask

	arm_func_start UpdateApListTask
UpdateApListTask: // 0x027F571C
	ldr r0, _027F5768 // =0x0380FFF4
	ldr r0, [r0, #0]
	add ip, r0, #0x23c
	mov r3, #0
	mov r0, r3
	add r2, ip, #0x30
_027F5734:
	ldrh r1, [ip, #0x30]
	cmp r1, #0
	beq _027F5758
	ldrh r1, [r2, #0]
	sub r1, r1, #1
	strh r1, [r2]
	ldrh r1, [ip, #0x30]
	cmp r1, #0
	streqh r0, [ip]
_027F5758:
	add r3, r3, #1
	cmp r3, #4
	blo _027F5734
	bx lr
	.align 2, 0
_027F5768: .word 0x0380FFF4
	arm_func_end UpdateApListTask

	arm_func_start InitApList
InitApList: // 0x027F576C
	mov r0, #0
	ldr r1, _027F5788 // =0x0380FFF4
	ldr r1, [r1, #0]
	add r1, r1, #0x23c
	mov r2, #0xc8
	ldr ip, _027F578C // =MIi_CpuClear16
	bx ip
	.align 2, 0
_027F5788: .word 0x0380FFF4
_027F578C: .word MIi_CpuClear16
	arm_func_end InitApList

	arm_func_start UpdateApList
UpdateApList: // 0x027F5790
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r11, r0
	mov r10, r1
	mov r9, r2
	ldr r0, _027F58E0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r8, r0, #0x23c
	add r0, r9, #1
	bl WL_ReadByte
	cmp r0, #0x20
	bhi _027F58D4
	mov r6, #4
	mov r5, r6
	mov r4, #0x400
	mov r7, #0
	add r0, r10, #0x24
	str r0, [sp]
	b _027F581C
_027F57DC:
	ldrh r0, [r8, #0]
	cmp r0, #0
	beq _027F5810
	add r0, r8, #6
	ldr r1, [sp]
	bl MatchMacAdrs
	cmp r0, #0
	bne _027F583C
	ldrh r0, [r8, #0x30]
	cmp r0, r4
	movlo r4, r0
	movlo r5, r7
	b _027F5814
_027F5810:
	mov r6, r7
_027F5814:
	add r7, r7, #1
	add r8, r8, #0x32
_027F581C:
	cmp r7, #4
	blo _027F57DC
	cmp r6, #4
	movne r7, r6
	bne _027F583C
	cmp r5, #4
	movne r7, r5
	beq _027F58D4
_027F583C:
	ldr r0, _027F58E0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r5, r0, #0x23c
	mov r2, #0x32
	mul r4, r7, r2
	add r6, r5, r4
	mov r0, #0
	mov r1, r6
	bl MIi_CpuClear16
	mov r0, #0x400
	strh r0, [r6, #0x30]
	ldrh r0, [r10, #0x12]
	and r0, r0, #0xff
	strh r0, [r5, r4]
	strh r11, [r6, #2]
	add r0, r6, #6
	add r1, r10, #0x24
	bl WSetMacAdrs1
	add r0, r9, #1
	bl WL_ReadByte
	strh r0, [r6, #0xc]
	mov r7, #0
	add r5, r9, #2
	add r4, r6, #0xe
	b _027F58B8
_027F58A0:
	add r0, r5, r7
	bl WL_ReadByte
	mov r1, r0
	add r0, r4, r7
	bl WL_WriteByte
	add r7, r7, #1
_027F58B8:
	ldrh r0, [r6, #0xc]
	cmp r7, r0
	blo _027F58A0
	ldrh r0, [r10, #0x34]
	strh r0, [r6, #0x2e]
	ldrh r0, [r10, #0x36]
	strh r0, [r6, #4]
_027F58D4:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_027F58E0: .word 0x0380FFF4
	arm_func_end UpdateApList

	arm_func_start FLASH_MakeImage
FLASH_MakeImage: // 0x027F58E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _027F59D0 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x314]
	bl SPI_Lock
	bl FLASH_Wait
	mov r0, #0
	str r0, [sp]
	mov r0, #0x2c
	mov r1, #2
	add r2, sp, #0
	bl NVRAM_ReadDataBytes
	ldr r0, _027F59D0 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x314]
	bl SPI_Unlock
	ldr r1, [sp]
	cmp r1, #0xa4
	blo _027F5940
	ldr r0, _027F59D4 // =0x000001D6
	cmp r1, r0
	bls _027F5948
_027F5940:
	mov r0, #0
	b _027F59C4
_027F5948:
	add r1, r1, #2
	str r1, [sp]
	ldr r0, _027F59D0 // =0x0380FFF4
	ldr r0, [r0, #0]
	add r0, r0, #0x188
	bl AllocateHeapBuf
	ldr r2, _027F59D0 // =0x0380FFF4
	ldr r1, [r2, #0]
	str r0, [r1, #0x318]
	ldr r1, [r2, #0]
	ldr r0, [r1, #0x318]
	cmp r0, #0
	moveq r0, #0
	beq _027F59C4
	add r0, r0, #0xc
	str r0, [r1, #0x318]
	ldr r0, [r2, #0]
	ldr r0, [r0, #0x314]
	bl SPI_Lock
	bl FLASH_Wait
	mov r0, #0x2a
	ldr r1, [sp]
	ldr r2, _027F59D0 // =0x0380FFF4
	ldr r2, [r2, #0]
	ldr r2, [r2, #0x318]
	bl NVRAM_ReadDataBytes
	ldr r0, _027F59D0 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x314]
	bl SPI_Unlock
	mov r0, #1
_027F59C4:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_027F59D0: .word 0x0380FFF4
_027F59D4: .word 0x000001D6
	arm_func_end FLASH_MakeImage

	arm_func_start FLASH_DirectRead
FLASH_DirectRead: // 0x027F59D8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	ldr r0, _027F5A24 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x314]
	bl SPI_Lock
	bl FLASH_Wait
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl NVRAM_ReadDataBytes
	ldr r0, _027F5A24 // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x314]
	bl SPI_Unlock
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F5A24: .word 0x0380FFF4
	arm_func_end FLASH_DirectRead

	arm_func_start FLASH_Read
FLASH_Read: // 0x027F5A28
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r5, r2
	ldr r1, _027F5A84 // =0x0380FFF4
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x318]
	cmp r1, #0
	beq _027F5A7C
	add r0, r1, r0
	sub r4, r0, #0x2a
	b _027F5A74
_027F5A54:
	mov r0, r4
	bl WL_ReadByte
	add r4, r4, #1
	mov r1, r0
	mov r0, r5
	bl WL_WriteByte
	add r5, r5, #1
	sub r6, r6, #1
_027F5A74:
	cmp r6, #0
	bne _027F5A54
_027F5A7C:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_027F5A84: .word 0x0380FFF4
	arm_func_end FLASH_Read

	arm_func_start FLASH_Wait
FLASH_Wait: // 0x027F5A88
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	add r4, sp, #0
_027F5A94:
	mov r0, r4
	bl NVRAM_ReadStatusRegister
	ldr r0, [sp]
	ands r0, r0, #0x20
	beq _027F5AB0
	bl NVRAM_SoftwareReset
	b _027F5A94
_027F5AB0:
	ldr r0, [sp]
	ands r0, r0, #1
	bne _027F5A94
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end FLASH_Wait

	arm_func_start FLASH_VerifyCheckSum
FLASH_VerifyCheckSum: // 0x027F5AC8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _027F5B6C // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r1, [r0, #0x318]
	ldrh r6, [r1, #2]
	cmp r6, #0xa4
	blo _027F5AF8
	ldr r0, _027F5B70 // =0x000001D6
	cmp r6, r0
	bls _027F5B00
_027F5AF8:
	mov r0, #2
	b _027F5B60
_027F5B00:
	add r7, r1, #2
	mov r4, #0
	b _027F5B30
_027F5B0C:
	mov r0, r7
	bl WL_ReadByte
	add r7, r7, #1
	and r0, r0, #0xff
	mov r1, r4, lsl #0x10
	mov r1, r1, lsr #0x10
	bl calc_NextCRC
	mov r4, r0
	sub r6, r6, #1
_027F5B30:
	cmp r6, #0
	bne _027F5B0C
	ldr r0, _027F5B6C // =0x0380FFF4
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x318]
	ldrh r1, [r0, #0]
	cmp r5, #0
	orrne r0, r1, r4, lsl #16
	strne r0, [r5]
	cmp r4, r1
	movne r0, #1
	moveq r0, #0
_027F5B60:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_027F5B6C: .word 0x0380FFF4
_027F5B70: .word 0x000001D6
	arm_func_end FLASH_VerifyCheckSum

	.rodata

.public WmspRequestFuncTable
WmspRequestFuncTable: // WmspRequestFuncTable
	.word WMSP_Initialize
	.word WMSP_Reset
	.word WMSP_End
	.word WMSP_Enable
	.word WMSP_Disable
	.word WMSP_PowerOn
	.word WMSP_PowerOff
	.word WMSP_SetParentParam
	.word WMSP_StartParent
	.word WMSP_EndParent
	.word WMSP_StartScan
	.word WMSP_EndScan
	.word WMSP_StartConnectEx
	.word WMSP_Disconnect
	.word WMSP_StartMP
	.word WMSP_SetMPData
	.word WMSP_EndMP
	.word WMSP_StartDCF
	.word WMSP_SetDCFData
	.word WMSP_EndDCF
	.word WMSP_SetWEPKey
	.word WmspRequestFuncDummy
	.word WmspRequestFuncDummy
	.word WmspRequestFuncDummy
	.word WMSP_SetGameInfo
	.word WMSP_SetBeaconTxRxInd
	.word WMSP_StartTestMode
	.word WMSP_StopTestMode
	.word WMSP_VAlarmSetMPData
	.word WMSP_SetLifeTime
	.word WMSP_MeasureChannel
	.word WMSP_InitWirelessCounter
	.word WMSP_GetWirelessCounter
	.word WMSP_SetEntry
	.word WMSP_AutoDeAuth
	.word WMSP_SetMPParameter
	.word WMSP_SetBeaconPeriod
	.word WMSP_AutoDisconnect
	.word WMSP_StartScanEx
	.word WMSP_SetWEPKeyEx
	.word WMSP_SetPowerSaveMode
	.word WMSP_StartTestRxMode
	.word WMSP_StopTestRxMode
	.word WMSP_KickNextMP_Parent
	.word WMSP_KickNextMP_Child
	.word WMSP_KickNextMP_Resume

.public pTaskFunc
pTaskFunc: // pTaskFunc
	.word MLME_ScanTask
	.word MLME_JoinTask
	.word MLME_AuthTask
	.word MLME_AssTask
	.word MLME_ReAssTask
	.word MLME_MeasChannelTask
	.word RxDataFrameTask
	.word RxManCtrlTask
	.word WlIntrTxBeaconTask
	.word DefragTask
	.word CAM_TimerTask
	.word RequestCmdTask
	.word LowestIdleTask
	.word MLME_BeaconLostTask
	.word WlIntrTxEndTask
	.word WlIntrRxEndTask
	.word WlIntrMpEndTask
	.word DefragTimerTask
	.word UpdateApListTask
	.word SendMessageToWmTask
	.word SetParentTbttTxqTask
	.word SendFatalErrMsgTask
	.word TerminateWlTask
	.word ReleaseWlTask

.public c_RateSet_3853
c_RateSet_3853: // 0x027F7E74
    .hword 3, 3

.public BC_ADRS
BC_ADRS: // 0x027F7E78
    .byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0, 0

.public MPKEY_ADRS
MPKEY_ADRS: // 0x027F7E80
    .byte 3, 9, 0xBF, 0, 0, 0x10, 0, 0

.public NULL_ADRS
NULL_ADRS: // 0x027F7E88
    .byte 0, 0, 0, 0, 0, 0, 0, 0

.public MP_ADRS
MP_ADRS: // 0x027F7E90
    .byte 3, 9, 0xBF, 0, 0, 0, 0, 0

.public RateBit2Element
RateBit2Element: // 0x027F7E98
    .hword 2, 4, 0xB, 0xC, 0x12, 0x16, 0x18, 0x24, 0x30, 0x48, 0x60, 0x6C, 0, 0, 0, 0

.public def_SsidMask
def_SsidMask: // 0x027F7EB8
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.public crc16_table
crc16_table: // 0x027F7ED8
    .hword 0, 0xCC01, 0xD801, 0x1400, 0xF001, 0x3C00, 0x2800, 0xE401, 0xA001, 0x6C00, 0x7800, 0xB401, 0x5000, 0x9C01, 0x8801, 0x4400

.public macTxRxRegAdrs
macTxRxRegAdrs: // 0x027F7EF8
    .hword 0x146, 0x148, 0x14A, 0x14C, 0x120, 0x122, 0x154, 0x144, 0x132, 0x132, 0x140, 0x142, 0x38, 0x124, 0x128, 0x150

.public def_WepKey
def_WepKey: // 0x027F7F18
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.public macInitRegs
macInitRegs: // 0x027F7F68
    .word 4, 8, 0xA, 0x12, 0xFFFF0010, 0x254, 0xFFFF00B4, 0x80
	.word 0x1008E, 0x88, 0x2A, 0x28, 0xE8, 0xEA, 0x100EE, 0x3F0300EC
	.word 0x101A2, 0x1A0, 0x8000110, 0x100BC, 0x300D4, 0x400D8
	.word 0x60200DA, 0x76, 0x1460130

.public RateElement2Bit
RateElement2Bit: // 0x027F7FCC
    .word 0xFF, 0x100FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0x30002
	.word 0xFF00FF, 0xFF00FF, 0x400FF, 0xFF00FF, 0x500FF, 0x600FF
	.word 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0x700FF
	.word 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0x800FF
	.word 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF
	.word 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0x900FF
	.word 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF
	.word 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xA00FF
	.word 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xB00FF
	.word 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF, 0xFF00FF

.public test_pattern
test_pattern: // 0x027F80BC
    .byte 0xFF, 0xFF, 0x5A, 0x5A, 0xA5, 0xA5, 0, 0

.public BBPDiagSkipAdrsES1
BBPDiagSkipAdrsES1: // 0x027F80C4
    .hword 2, 4, 5, 6, 7, 0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x26, 0x29, 0x2C, 0x2D, 0x2E, 0x2F, 0x30, 0x33, 0x34
	.hword 0x35, 0x36, 0x37, 0x65, 0, 0

.public BBPDiagSkipAdrsRelease
BBPDiagSkipAdrsRelease: // 0x027F80F8
    .hword 0, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x10, 0x11, 0x12, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x27, 0x4D
	.hword 0x5D, 0x5E, 0x5F, 0x60, 0x61, 0x64, 0x66, 0

.public test_reg
test_reg: // 0x027F8130
    .hword 6, 0x3F, 0x18, 0xFFFF, 0x1A, 0xFFFF, 0x1C, 0xFFFF
	.hword 0x20, 0xFFFF, 0x22, 0xFFFF, 0x24, 0xFFFF, 0x2A, 0x7FF
	.hword 0x50, 0xFFFF, 0x52, 0xFFFF, 0x56, 0xFFE, 0x58, 0x1FFE
	.hword 0x5A, 0xFFE, 0x5C, 0xFFF, 0x62, 0x1FFE, 0x64, 0xFFF
	.hword 0x68, 0x1FFE, 0x6C, 0xFFF, 0x74, 0x1FFE, 0x122, 0xFFFF
	.hword 0x124, 0xFFFF, 0x128, 0xFFFF, 0x130, 0xFFF, 0x132
	.hword 0x8FFF, 0x134, 0xFFFF, 0x140, 0xFFFF, 0x142, 0xFFFF

.public WlibCmdTbl_MA
WlibCmdTbl_MA: // 0x027F819C
	.word 0x20018, MA_DataReqCmd
	.word 0x10004, MA_KeyDataReqCmd
	.word 0x1000A, MA_MpReqCmd
	.word 0x1000C, MA_TestDataReqCmd
	.word 0x10001, MA_ClrDataReqCmd

.public WlibCmdTbl_PARAMGET2
WlibCmdTbl_PARAMGET2: // 0x027F81C4
	.word 0x40000, PARAMGET_BSSIDReqCmd
	.word 0x120000, PARAMGET_SSIDReqCmd
	.word 0x20000, PARAMGET_BeaconPeriodReqCmd
	.word 0x20000, PARAMGET_DTIMPeriodReqCmd
	.word 0x20000, PARAMGET_ListenIntervalReqCmd
	.word 0x10000, PARAMGET_GameInfoReqCmd

.public WlibCmdTbl_PARAMSET2
WlibCmdTbl_PARAMSET2: // 0x027F81F4
	.word 0x10003, PARAMSET_BSSIDReqCmd
	.word 0x10011, PARAMSET_SSIDReqCmd
	.word 0x10001, PARAMSET_BeaconPeriodReqCmd
	.word 0x10001, PARAMSET_DTIMPeriodReqCmd
	.word 0x10001, PARAMSET_ListenIntervalReqCmd
	.word 0x10000, PARAMSET_GameInfoReqCmd

.public WlibCmdTbl_MLME
WlibCmdTbl_MLME: // 0x027F8224
	.word 0x10001, MLME_ResetReqCmd
	.word 0x10003, MLME_PwrMgtReqCmd
	.word 0x23001F, MLME_ScanReqCmd
	.word 0x50022, MLME_JoinReqCmd
	.word 0x60005, MLME_AuthReqCmd
	.word 0x40004, MLME_DeAuthReqCmd
	.word 0x30005, MLME_AssReqCmd
	.word 0x30005, MLME_ReAssReqCmd
	.word 0x10004, MLME_DisAssReqCmd
	.word 0x10017, MLME_StartReqCmd
	.word 0x12000C, MLME_MeasChanReqCmd

.public WlibCmdTbl_DEV
WlibCmdTbl_DEV: // 0x027F827C
	.word 0x10000, CMD_ReservedReqCmd
	.word 0x10000, DEV_ShutdownReqCmd
	.word 0x10000, DEV_IdleReqCmd
	.word 0x10000, DEV_Class1ReqCmd
	.word 0x10000, DEV_RebootReqCmd
	.word 0x10000, DEV_ClearWlInfoReqCmd
	.word 0x90000, DEV_GetVerInfoReqCmd
	.word 0x5C0000, DEV_GetWlInfoReqCmd
	.word 0x20000, DEV_GetStateReqCmd
	.word 0x10004, DEV_TestSignalReqCmd
	.word 0x10002, DEV_TestRxReqCmd

.public WlibCmdTbl_PARAMGET
WlibCmdTbl_PARAMGET: // 0x027F82D4
	.word 0x210000, PARAMGET_AllReqCmd
	.word 0x40000, PARAMGET_MacAdrsReqCmd
	.word 0x20000, PARAMGET_RetryReqCmd
	.word 0x30000, PARAMGET_EnableChannelReqCmd
	.word 0x20000, PARAMGET_ModeReqCmd
	.word 0x20000, PARAMGET_RateReqCmd
	.word 0x20000, PARAMGET_WepModeReqCmd
	.word 0x20000, PARAMGET_WepKeyIdReqCmd
	.word 0x10000, CMD_ReservedReqCmd
	.word 0x20000, PARAMGET_BeaconTypeReqCmd
	.word 0x20000, PARAMGET_ResBcSsidReqCmd
	.word 0x20000, PARAMGET_BeaconLostThReqCmd
	.word 0x20000, PARAMGET_ActiveZoneReqCmd
	.word 0x110000, PARAMGET_SSIDMaskReqCmd
	.word 0x20000, PARAMGET_PreambleTypeReqCmd
	.word 0x20000, PARAMGET_AuthAlgoReqCmd
	.word 0x40000, PARAMGET_CCAModeEDThReqCmd
	.word 0x10000, CMD_ReservedReqCmd
	.word 0x20000, PARAMGET_MaxConnReqCmd
	.word 0x20000, PARAMGET_MainAntennaReqCmd
	.word 0x30000, PARAMGET_DiversityReqCmd
	.word 0x20000, PARAMGET_BcnSendRecvIndReqCmd
	.word 0x20000, PARAMGET_NullKeyModeReqCmd

.public WlibCmdTbl_PARAMSET
WlibCmdTbl_PARAMSET: // 0x027F838C
	.word 0x10048, PARAMSET_AllReqCmd
	.word 0x10003, PARAMSET_MacAdrsReqCmd
	.word 0x10001, PARAMSET_RetryReqCmd
	.word 0x10001, PARAMSET_EnableChannelReqCmd
	.word 0x10001, PARAMSET_ModeReqCmd
	.word 0x10001, PARAMSET_RateReqCmd
	.word 0x10001, PARAMSET_WepModeReqCmd
	.word 0x10001, PARAMSET_WepKeyIdReqCmd
	.word 0x10028, PARAMSET_WepKeyReqCmd
	.word 0x10001, PARAMSET_BeaconTypeReqCmd
	.word 0x10001, PARAMSET_ResBcSsidReqCmd
	.word 0x10001, PARAMSET_BeaconLostThReqCmd
	.word 0x10001, PARAMSET_ActiveZoneReqCmd
	.word 0x10010, PARAMSET_SSIDMaskReqCmd
	.word 0x10001, PARAMSET_PreambleTypeReqCmd
	.word 0x10001, PARAMSET_AuthAlgoReqCmd
	.word 0x10003, PARAMSET_CCAModeEDThReqCmd
	.word 0x10003, PARAMSET_LifeTimeReqCmd
	.word 0x10001, PARAMSET_MaxConnReqCmd
	.word 0x10001, PARAMSET_MainAntennaReqCmd
	.word 0x10002, PARAMSET_DiversityReqCmd
	.word 0x10001, PARAMSET_BcnSendRecvIndReqCmd
	.word 0x10001, PARAMSET_NullKeyModeReqCmd

.public wlVersion_3529
wlVersion_3529: // 0x027F8444
	.asciz "2.78.00"

.public Pri2QBit
Pri2QBit: // 0x027F844C
    .hword 1, 4, 8, 0

	.bss

.public _027F8454
_027F8454: // 0x027F8454
	.space 0x20
         
.public byte_27F8474
byte_27F8474: // 0x027F8474
	.space 8
           
.public byte_27F847C
byte_27F847C: // 0x027F847C
	.space 0x20
        
.public byte_27F849C
byte_27F849C: // 0x027F849C
	.space 0x10
       
.public byte_27F84AC
byte_27F84AC: // 0x027F84AC
	.space 0x20
          
.public byte_27F84CC
byte_27F84CC: // 0x027F84CC
	.space 0x10
        
.public byte_27F84DC
byte_27F84DC: // 0x027F84DC
	.space 0xF58
     
.public byte_27F9434
byte_27F9434: // 0x027F9434
	.space 0x128

.public byte_27F955C
byte_27F955C: // 0x027F955C
	.space 0x400

.public byte_27F995C
byte_27F995C: // 0x027F995C
	.space 0x2C

.public byte_27F9988
byte_27F9988: // 0x027F9988
	.space 0x3C
        
.public dword_27F99C4
dword_27F99C4: // 0x027F99C4
	.space 4

.public dword_27F99C8
dword_27F99C8: // 0x027F99C8
	.space 4
           
.public dword_27F99CC
dword_27F99CC: // 0x027F99CC
	.space 4
           
.public dword_27F99D0
dword_27F99D0: // 0x027F99D0
	.space 4
           
.public dword_27F99D4
dword_27F99D4: // 0x027F99D4
	.space 4
           
.public dword_27F99D8
dword_27F99D8: // 0x027F99D8
	.space 4
           
.public dword_27F99DC
dword_27F99DC: // 0x027F99DC
	.space 4
          
.public dword_27F99E0
dword_27F99E0: // 0x027F99E0
	.space 4
           
.public nvramw
nvramw: // 0x027F99E4
	.space 0x20
       
.public rtcInitialized
rtcInitialized: // 0x027F9A04
	.space 4
          
.public rtcWork
rtcWork: // 0x027F9A08
	.space 0x3B4
       