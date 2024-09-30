	.include "asm/macros.inc"
	.include "global.inc"

	.bss

_02151D08: // 0x02151D08
	.space 0xEC

	.text
	
	arm_func_start MBi_CommCallParentError
MBi_CommCallParentError: // 0x020F6D58
	stmdb sp!, {lr}
	sub sp, sp, #4
	strh r1, [sp]
	add r2, sp, #0
	mov r1, #0xd
	bl MBi_CommChangeParentStateCallbackOnly
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end MBi_CommCallParentError

	arm_func_start IsChildAidValid
IsChildAidValid: // 0x020F6D7C
	cmp r0, #1
	blo _020F6D90
	cmp r0, #0xf
	movls r0, #1
	bxls lr
_020F6D90:
	mov r0, #0
	bx lr
	arm_func_end IsChildAidValid

	arm_func_start MBi_calc_nextsendblock
MBi_calc_nextsendblock: // 0x020F6D98
	cmp r1, r0
	movls r1, r0
	mov r0, r1
	bx lr
	arm_func_end MBi_calc_nextsendblock

	arm_func_start MBi_calc_sendblock
MBi_calc_sendblock: // 0x020F6DA8
	ldr r1, _020F6E20 // =_02151D08
	mov r2, #1
	mov r2, r2, lsl r0
	ldr r1, [r1, #0]
	ands r1, r1, r2
	bxeq lr
	ldr r2, _020F6E24 // =0x2151DBC
	ldr r1, _020F6E28 // =0x000005D4
	ldr r2, [r2, #0]
	mla r3, r0, r1, r2
	add r0, r3, #0x1000
	ldrb r0, [r0, #0xd52]
	cmp r0, #0
	bxeq lr
	add r0, r3, #0x1d00
	ldrh r1, [r0, #0x4c]
	cmp r1, #0
	bxeq lr
	ldrh r2, [r0, #0x48]
	ldrh ip, [r0, #0x4a]
	cmp ip, r2
	bhi _020F6E14
	add r1, ip, #2
	cmp r2, r1
	addle r1, r2, #1
	strleh r1, [r0, #0x48]
	bxle lr
_020F6E14:
	add r0, r3, #0x1d00
	strh ip, [r0, #0x48]
	bx lr
	.align 2, 0
_020F6E20: .word _02151D08
_020F6E24: .word 0x2151DBC
_020F6E28: .word 0x000005D4
	arm_func_end MBi_calc_sendblock

	arm_func_start MBi_CommParentSendData
MBi_CommParentSendData: // 0x020F6E2C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	add r1, sp, #0
	mov r0, #0
	mov r2, #0xa
	bl MIi_CpuClear16
	mov ip, #1
	ldr r0, _020F6FB0 // =0x2151DBC
	mov r4, ip
	ldr r3, [r0, #0]
	mov r5, ip
	mov r0, ip
	mov r1, ip
	mov r2, ip
_020F6E64:
	sub lr, ip, #1
	add lr, r3, lr, lsl #2
	add lr, lr, #0x1000
	ldr lr, [lr, #0x4e8]
	cmp lr, #0xb
	addls pc, pc, lr, lsl #2
	b _020F6EFC
_020F6E80: // jump table
	b _020F6EFC // case 0
	b _020F6EFC // case 1
	b _020F6EB0 // case 2
	b _020F6EFC // case 3
	b _020F6ED0 // case 4
	b _020F6EC0 // case 5
	b _020F6EFC // case 6
	b _020F6EFC // case 7
	b _020F6EE0 // case 8
	b _020F6EFC // case 9
	b _020F6EFC // case 10
	b _020F6EF0 // case 11
_020F6EB0:
	ldrh lr, [sp]
	orr lr, lr, r2, lsl ip
	strh lr, [sp]
	b _020F6EFC
_020F6EC0:
	ldrh lr, [sp, #2]
	orr lr, lr, r1, lsl ip
	strh lr, [sp, #2]
	b _020F6EFC
_020F6ED0:
	ldrh lr, [sp, #4]
	orr lr, lr, r0, lsl ip
	strh lr, [sp, #4]
	b _020F6EFC
_020F6EE0:
	ldrh lr, [sp, #6]
	orr lr, lr, r5, lsl ip
	strh lr, [sp, #6]
	b _020F6EFC
_020F6EF0:
	ldrh lr, [sp, #8]
	orr lr, lr, r4, lsl ip
	strh lr, [sp, #8]
_020F6EFC:
	add ip, ip, #1
	mov ip, ip, lsl #0x10
	mov ip, ip, lsr #0x10
	cmp ip, #0xf
	bls _020F6E64
	ldrh r1, [sp, #6]
	cmp r1, #0
	beq _020F6F28
	mov r0, #5
	bl MBi_CommParentSendMsg
	b _020F6F88
_020F6F28:
	ldrh r1, [sp]
	cmp r1, #0
	beq _020F6F40
	mov r0, #1
	bl MBi_CommParentSendMsg
	b _020F6F88
_020F6F40:
	ldrh r1, [sp, #8]
	cmp r1, #0
	beq _020F6F58
	mov r0, #6
	bl MBi_CommParentSendMsg
	b _020F6F88
_020F6F58:
	ldrh r1, [sp, #4]
	cmp r1, #0
	beq _020F6F70
	mov r0, #2
	bl MBi_CommParentSendMsg
	b _020F6F88
_020F6F70:
	ldrh r0, [sp, #2]
	cmp r0, #0
	beq _020F6F84
	bl MBi_CommParentSendDLFileInfo
	b _020F6F88
_020F6F84:
	bl MBi_CommParentSendBlock
_020F6F88:
	cmp r0, #0x15
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	ldr r1, _020F6FB4 // =0x0000FFFF
	mov r0, #0
	bl MBi_CommParentSendMsg
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F6FB0: .word 0x2151DBC
_020F6FB4: .word 0x0000FFFF
	arm_func_end MBi_CommParentSendData

	arm_func_start MBi_CommParentSendBlock
MBi_CommParentSendBlock: // 0x020F6FB8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	ldr r5, _020F7264 // =0x2151DBC
	ldr r0, [r5, #0]
	add r0, r0, #0x1000
	ldrb r0, [r0, #0x524]
	cmp r0, #0
	addeq sp, sp, #0x1c
	moveq r0, #0x15
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr r4, _020F7268 // =0x000005D4
	mov r1, #0
_020F6FEC:
	ldr r0, [r5, #0]
	add r3, r0, #0x1000
	ldrb r0, [r3, #0x525]
	add r0, r0, #1
	mov r2, r0, lsr #0x1f
	rsb r0, r2, r0, lsl #28
	add r0, r2, r0, ror #28
	strb r0, [r3, #0x525]
	ldr r2, [r5, #0]
	add r0, r2, #0x1000
	ldrb r0, [r0, #0x525]
	mla r3, r0, r4, r2
	add r2, r3, #0x1000
	ldrb r2, [r2, #0xd52]
	cmp r2, #0
	beq _020F703C
	add r2, r3, #0x1d00
	ldrh r2, [r2, #0x4c]
	cmp r2, #0
	bne _020F704C
_020F703C:
	add r1, r1, #1
	and r1, r1, #0xff
	cmp r1, #0x10
	blo _020F6FEC
_020F704C:
	cmp r1, #0x10
	addeq sp, sp, #0x1c
	moveq r0, #0x15
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	bl MBi_calc_sendblock
	ldr r0, _020F7264 // =0x2151DBC
	ldr r1, _020F7268 // =0x000005D4
	ldr r6, [r0, #0]
	ldr r2, _020F726C // =0x00001D2C
	add r0, r6, #0x1000
	ldrb r0, [r0, #0x525]
	ldr r3, _020F7270 // =0x00001788
	add r4, r6, r2
	mul r5, r0, r1
	add r0, r6, r5
	add r0, r0, #0x1d00
	ldrh r2, [r0, #0x48]
	add r3, r6, r3
	add r0, sp, #8
	add r1, r4, r5
	add r3, r3, r5
	bl MBi_get_blockinfo
	cmp r0, #0
	addeq sp, sp, #0x1c
	moveq r0, #0x15
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr r0, _020F7264 // =0x2151DBC
	mov r2, #4
	ldr r1, [r0, #0]
	strb r2, [sp]
	add r2, r1, #0x1000
	ldrb r4, [r2, #0x525]
	ldr r3, _020F7268 // =0x000005D4
	add r0, sp, #0
	strh r4, [sp, #2]
	ldrb r4, [r2, #0x525]
	mla r2, r4, r3, r1
	add r2, r2, #0x1d00
	ldrh r2, [r2, #0x48]
	strh r2, [sp, #4]
	bl MBi_MakeParentSendBuffer
	ldr r1, _020F7264 // =0x2151DBC
	ldr r4, _020F7268 // =0x000005D4
	ldr r5, [r1, #0]
	ldrb r1, [sp, #0x14]
	add r2, r5, #0x1000
	ldrb r2, [r2, #0x525]
	ldr r6, [sp, #0x10]
	ldr r3, [sp, #0xc]
	mla r5, r2, r4, r5
	add r2, r5, r1, lsl #2
	add r4, r5, #0x1000
	add r2, r2, #0x1000
	ldr r5, [r4, #0xd58]
	ldr r2, [r2, #0xd2c]
	ldr r1, [r5, r1, lsl #2]
	sub r2, r6, r2
	add r7, r2, r1
	ldr r6, [r4, #0xd54]
	mov r2, r0
	mov r0, r6
	mov r1, r7
	bl MBi_TryLoadCache
	cmp r0, #0
	bne _020F722C
	ldr r1, _020F7264 // =0x2151DBC
	ldr r0, _020F7274 // =0x00007CE0
	ldr r1, [r1, #0]
	add r5, r1, r0
	mov r0, r5
	bl MBi_IsTaskBusy
	cmp r0, #0
	bne _020F721C
	ldr r0, [r6, #0]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r6]
	bne _020F721C
	add lr, r6, #0x30
	mov r4, #0
	mov ip, r4
	mov r3, lr
_020F719C:
	add r0, lr, ip, lsl #4
	ldr r0, [r0, #0xc]
	mov r2, ip, lsl #4
	cmp r0, #2
	bne _020F71CC
	cmp r4, #0
	beq _020F71C8
	ldr r1, [r4, #0]
	ldr r0, [lr, r2]
	cmp r1, r0
	bls _020F71CC
_020F71C8:
	mov r4, r3
_020F71CC:
	add ip, ip, #1
	cmp ip, #4
	add r3, r3, #0x10
	blt _020F719C
	cmp r4, #0
	bne _020F71E8
	bl OS_Terminate
_020F71E8:
	mov r0, #2
	str r0, [r6]
	mov r0, #1
	str r0, [r4, #0xc]
	bic r0, r7, #0x1f
	str r0, [r4]
	str r4, [r5, #0x10]
	ldr r1, _020F7278 // =MBi_ReloadCache
	mov r0, r5
	mov r2, #0
	mov r3, #4
	str r6, [r5, #0x14]
	bl MBi_SetTask
_020F721C:
	add sp, sp, #0x1c
	mov r0, #0x15
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F722C:
	ldr r0, _020F7264 // =0x2151DBC
	ldr r4, [sp, #0xc]
	ldr r2, [r0, #0]
	ldr r1, _020F7268 // =0x000005D4
	add r0, r2, #0x1000
	ldrb r3, [r0, #0x525]
	add r0, r4, #6
	mla r1, r3, r1, r2
	add r1, r1, #0x1d00
	ldrh r1, [r1, #0x4c]
	bl MBi_BlockHeaderEnd
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F7264: .word 0x2151DBC
_020F7268: .word 0x000005D4
_020F726C: .word 0x00001D2C
_020F7270: .word 0x00001788
_020F7274: .word 0x00007CE0
_020F7278: .word MBi_ReloadCache
	arm_func_end MBi_CommParentSendBlock

	arm_func_start MBi_ReloadCache
MBi_ReloadCache: // 0x020F727C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x4c
	ldr r5, [r0, #0x14]
	ldr r4, [r0, #0x10]
	add r0, sp, #4
	bl FS_InitFile
	ldr r1, [r5, #0x14]
	add r0, r5, #0x10
	ldr r5, [r4, #0]
	bl FS_FindArchive
	mvn r1, #0
	str r1, [sp]
	ldr r2, [r4, #4]
	mov r1, r0
	add r3, r5, r2
	add r0, sp, #4
	mov r2, r5
	bl FS_OpenFileDirect
	cmp r0, #0
	beq _020F72F4
	ldr r1, [r4, #8]
	ldr r2, [r4, #4]
	add r0, sp, #4
	bl FS_ReadFile
	ldr r1, [r4, #4]
	cmp r1, r0
	moveq r0, #2
	streq r0, [r4, #0xc]
	add r0, sp, #4
	bl FS_CloseFile
_020F72F4:
	ldr r0, [r4, #0xc]
	cmp r0, #2
	movne r0, #0
	strne r0, [r4]
	movne r0, #2
	strne r0, [r4, #0xc]
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end MBi_ReloadCache

	arm_func_start MBi_CommParentSendDLFileInfo
MBi_CommParentSendDLFileInfo: // 0x020F7318
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r4, #0
	add r0, sp, #6
	mov r1, r4
	mov r2, #0x10
	mvn r5, #0
	bl MI_CpuFill8
	ldr r1, _020F74B8 // =0x2151DBC
	mov r0, #1
	ldr r1, [r1, #0]
	add ip, sp, #6
_020F7348:
	sub r3, r0, #1
	add r2, r1, r3, lsl #2
	add r2, r2, #0x1000
	ldr r2, [r2, #0x4e8]
	cmp r2, #5
	bne _020F7378
	add r2, r1, r3
	add r2, r2, #0x1500
	ldrsb r3, [r2, #0x26]
	ldrb r2, [ip, r3]
	add r2, r2, #1
	strb r2, [ip, r3]
_020F7378:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0xf
	bls _020F7348
	ldr r2, _020F74BC // _0211F9D0
	mov r0, #0
	ldrb r3, [r2, #0]
	add lr, sp, #6
	ldr ip, _020F74C0 // =0x000005D4
_020F73A0:
	add r2, r3, #1
	mov r3, r2, lsr #0x1f
	rsb r2, r3, r2, lsl #28
	add r2, r3, r2, ror #28
	and r3, r2, #0xff
	mla r2, r3, ip, r1
	add r2, r2, #0x1000
	ldrb r2, [r2, #0xd52]
	cmp r2, #0
	beq _020F73DC
	ldrb r2, [lr, r3]
	cmp r2, #0
	movne r0, r3, lsl #0x18
	movne r5, r0, asr #0x18
	bne _020F73EC
_020F73DC:
	add r0, r0, #1
	and r0, r0, #0xff
	cmp r0, #0x10
	blo _020F73A0
_020F73EC:
	mvn r0, #0
	cmp r5, r0
	addeq sp, sp, #0x1c
	moveq r0, #0x15
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r2, _020F74BC // _0211F9D0
	mov r0, #1
	strb r5, [r2]
	mov r3, r0
_020F7414:
	sub ip, r0, #1
	add r2, r1, ip, lsl #2
	add r2, r2, #0x1000
	ldr r2, [r2, #0x4e8]
	cmp r2, #5
	bne _020F7448
	add r2, r1, ip
	add r2, r2, #0x1500
	ldrsb r2, [r2, #0x26]
	cmp r5, r2
	orreq r2, r4, r3, lsl r0
	moveq r2, r2, lsl #0x10
	moveq r4, r2, lsr #0x10
_020F7448:
	add r0, r0, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #0xf
	bls _020F7414
	mov r2, #3
	add r0, sp, #0
	strb r2, [sp]
	strh r5, [sp, #2]
	bl MBi_MakeParentSendBuffer
	movs r1, r0
	beq _020F7498
	ldr r2, _020F74B8 // =0x2151DBC
	ldr r0, _020F74C4 // =0x00001788
	ldr r3, [r2, #0]
	ldr r2, _020F74C0 // =0x000005D4
	add r0, r3, r0
	mla r0, r5, r2, r0
	mov r2, #0xe4
	bl MI_CpuCopy8
_020F7498:
	ldr r0, _020F74B8 // =0x2151DBC
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0xea
	bl MBi_BlockHeaderEnd
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F74B8: .word 0x2151DBC
_020F74BC: .word _0211F9D0
_020F74C0: .word 0x000005D4
_020F74C4: .word 0x00001788
	arm_func_end MBi_CommParentSendDLFileInfo

	arm_func_start MBi_CommParentSendMsg
MBi_CommParentSendMsg: // 0x020F74C8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r2, _020F7508 // =0x2151DBC
	mov r4, r1
	ldr r1, [r2, #0]
	strb r0, [sp]
	add r0, sp, #0
	bl MBi_MakeParentSendBuffer
	ldr r0, _020F7508 // =0x2151DBC
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #6
	bl MBi_BlockHeaderEnd
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F7508: .word 0x2151DBC
	arm_func_end MBi_CommParentSendMsg

	arm_func_start MBi_CommParentRecvData
MBi_CommParentRecvData: // 0x020F750C
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r6, #0
	ldr r2, _020F75B4 // =0x2151DBC
	mov r3, r6
	ldr r1, _020F75B8 // =0x000005D4
_020F7524:
	ldr r0, [r2, #0]
	mla r5, r6, r1, r0
	add r0, r5, #0x1000
	ldrb r0, [r0, #0xd52]
	cmp r0, #0
	addne r0, r5, #0x1d00
	strneh r3, [r0, #0x4a]
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0x10
	blo _020F7524
	ldr r0, _020F75BC // =_02151D08
	mov r1, #0
	str r1, [r0]
	mov r6, #1
	ldr r5, _020F75C0 // =0x0000FFFF
_020F7568:
	mov r0, r4
	mov r1, r6
	bl WM_ReadMPData
	cmp r0, #0
	beq _020F7598
	ldrh r1, [r0, #0]
	cmp r1, r5
	beq _020F7598
	cmp r1, #0
	beq _020F7598
	mov r1, r6
	bl MBi_CommParentRecvDataPerChild
_020F7598:
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	cmp r6, #0xf
	bls _020F7568
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020F75B4: .word 0x2151DBC
_020F75B8: .word 0x000005D4
_020F75BC: .word _02151D08
_020F75C0: .word 0x0000FFFF
	arm_func_end MBi_CommParentRecvData

	arm_func_start MBi_CommParentRecvDataPerChild
MBi_CommParentRecvDataPerChild: // 0x020F75C4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x38
	movs r7, r1
	addeq sp, sp, #0x38
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r7, #0xf
	addhi sp, sp, #0x38
	ldmhiia sp!, {r4, r5, r6, r7, r8, lr}
	bxhi lr
	add r1, sp, #0
	mov r2, r7
	add r0, r0, #0xa
	bl MBi_SetRecvBufferFromChild
	ldr r3, _020F7AC8 // =0x2151DBC
	ldrb r8, [sp]
	ldr r2, [r3, #0]
	sub r4, r7, #1
	add r1, r2, r4, lsl #2
	add r1, r1, #0x1000
	ldr r6, [r1, #0x4e8]
	mov r5, r0
	cmp r8, #0xb
	addls pc, pc, r8, lsl #2
	b _020F7ABC
_020F7628: // jump table
	b _020F7ABC // case 0
	b _020F7ABC // case 1
	b _020F7ABC // case 2
	b _020F7ABC // case 3
	b _020F7ABC // case 4
	b _020F7ABC // case 5
	b _020F7ABC // case 6
	b _020F7658 // case 7
	b _020F78E4 // case 8
	b _020F79A0 // case 9
	b _020F7A1C // case 10
	b _020F7ABC // case 11
_020F7658:
	cmp r6, #2
	bne _020F76FC
	cmp r5, #0
	addeq sp, sp, #0x38
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	add r1, sp, #0x14
	mov r2, #0x1d
	bl MI_CpuCopy8
	ldr r3, _020F7AC8 // =0x2151DBC
	mov r0, r4
	ldr r1, [r3, #0]
	ldr r2, [sp, #0x14]
	add r1, r1, r0, lsl #2
	add r1, r1, #0x1000
	str r2, [r1, #0x4a8]
	ldr r1, [r3, #0]
	mov r2, #0x16
	add r1, r1, r0, lsl #1
	mul r8, r0, r2
	ldrh ip, [sp, #0x2e]
	add r1, r1, #0x1400
	add r0, sp, #0x18
	strh ip, [r1, #0x8a]
	ldr r1, [r3, #0]
	add r1, r1, #0x1340
	add r1, r1, r8
	bl MI_CpuCopy8
	ldr r0, _020F7AC8 // =0x2151DBC
	and r1, r7, #0xff
	ldr r0, [r0, #0]
	and r2, r1, #0xf
	add ip, r0, #0x1340
	ldrb r3, [ip, r8]
	mov r0, r7
	mov r1, #0xa
	bic r3, r3, #0xf0
	orr r2, r3, r2, lsl #4
	strb r2, [ip, r8]
	add r2, sp, #0x18
	bl MBi_CommChangeParentState
_020F76FC:
	cmp r6, #0xa
	addne sp, sp, #0x38
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	ldrb r8, [r5, #0x1c]
	mov r2, #0
	cmp r8, #0x10
	bhs _020F7758
	ldr r0, _020F7AC8 // =0x2151DBC
	ldr r1, _020F7ACC // =0x000005D4
	ldr r0, [r0, #0]
	mla r6, r8, r1, r0
	add r1, r6, #0x1000
	ldrb r3, [r1, #0xd52]
	cmp r3, #0
	beq _020F7758
	add r3, r0, r4, lsl #2
	ldr r1, [r1, #0xd40]
	add r3, r3, #0x1000
	ldr r5, [r3, #0x4a8]
	ldr r3, [r1, #0x14]
	cmp r5, r3
	beq _020F7774
_020F7758:
	ldr r0, _020F7AC8 // =0x2151DBC
	mov r1, #4
	ldr r0, [r0, #0]
	add r0, r0, r4, lsl #1
	add r0, r0, #0x1700
	strh r1, [r0, #0x54]
	b _020F77D8
_020F7774:
	add r3, r6, #0x1d00
	ldrh r6, [r3, #0x4e]
	mov ip, r2
	mov r5, #1
_020F7784:
	mov r3, r5, lsl ip
	ands r3, r3, r6
	add r3, ip, #1
	addne r2, r2, #1
	and ip, r3, #0xff
	andne r2, r2, #0xff
	cmp ip, #0x10
	blo _020F7784
	ldrb r1, [r1, #0x18]
	cmp r2, r1
	blo _020F77D8
	add r1, r0, r4, lsl #1
	add r3, r1, #0x1700
	mov r2, #0
	mov r0, r7
	mov r1, #0xb
	strh r2, [r3, #0x54]
	bl MBi_CommChangeParentState
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F77D8:
	ldr r3, _020F7AC8 // =0x2151DBC
	ldr r2, [r3, #0]
	add r0, r2, r4, lsl #1
	add r4, r0, #0x1700
	ldrh r0, [r4, #0x54]
	cmp r0, #3
	beq _020F7808
	cmp r0, #4
	beq _020F78C4
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F7808:
	add r0, r2, #0x1500
	mov r1, #1
	ldrh r0, [r0, #0x36]
	mov r6, r1, lsl r7
	ands r0, r0, r6
	addne sp, sp, #0x38
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	add r0, r2, #0x1000
	ldrb r2, [r0, #0x535]
	ldr r1, _020F7ACC // =0x000005D4
	sub r5, r7, #1
	add r2, r2, #1
	strb r2, [r0, #0x535]
	ldr r0, [r3, #0]
	mul r4, r8, r1
	add r1, r0, #0x1500
	ldrh ip, [r1, #0x36]
	mov r0, r7
	mov r2, #0
	orr r7, ip, r6
	strh r7, [r1, #0x36]
	ldr r7, [r3, #0]
	mov r1, #5
	add r7, r7, r5
	add r7, r7, #0x1000
	strb r8, [r7, #0x526]
	ldr r7, [r3, #0]
	add r7, r7, r4
	add r7, r7, #0x1d00
	ldrh r8, [r7, #0x4e]
	orr r8, r8, r6
	strh r8, [r7, #0x4e]
	ldr r7, [r3, #0]
	add r4, r7, r4
	add r4, r4, #0x1d00
	ldrh r7, [r4, #0x50]
	orr r6, r7, r6
	strh r6, [r4, #0x50]
	ldr r3, [r3, #0]
	add r3, r3, r5, lsl #1
	add r3, r3, #0x1700
	strh r2, [r3, #0x54]
	bl MBi_CommChangeParentState
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F78C4:
	mov r2, #0
	mov r0, r7
	mov r1, #4
	strh r2, [r4, #0x54]
	bl MBi_CommChangeParentState
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F78E4:
	cmp r6, #5
	bne _020F7908
	mov r0, r7
	mov r1, #0xe
	mov r2, #0
	bl MBi_CommChangeParentState
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F7908:
	cmp r6, #0xe
	addne sp, sp, #0x38
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	add r0, r2, r4, lsl #1
	add r0, r0, #0x1700
	ldrh r0, [r0, #0x54]
	mov r5, r4, lsl #1
	cmp r0, #2
	addne sp, sp, #0x38
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	add r0, r2, r4
	add r0, r0, #0x1000
	ldrb r1, [r0, #0x526]
	ldr r0, _020F7ACC // =0x000005D4
	mov r6, #1
	mul r4, r1, r0
	add r0, r2, r4
	add r1, r0, #0x1d00
	ldrh r8, [r1, #0x4c]
	mov r2, #0
	mov r0, r7
	orr r6, r8, r6, lsl r7
	strh r6, [r1, #0x4c]
	ldr r6, [r3, #0]
	mov r1, #6
	add r4, r6, r4
	add r4, r4, #0x1d00
	strh r2, [r4, #0x48]
	ldr r3, [r3, #0]
	add r3, r3, r5
	add r3, r3, #0x1700
	strh r2, [r3, #0x54]
	bl MBi_CommChangeParentState
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F79A0:
	cmp r6, #6
	addne sp, sp, #0x38
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	add r0, r2, r4
	add r0, r0, #0x1000
	ldrb r5, [r0, #0x526]
	cmp r5, #0xff
	addeq sp, sp, #0x38
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r0, _020F7ACC // =0x000005D4
	ldrh r1, [sp, #2]
	mul r4, r5, r0
	add r0, r2, r4
	add r0, r0, #0x1d00
	ldrh r0, [r0, #0x4a]
	bl MBi_calc_nextsendblock
	ldr r1, _020F7AC8 // =0x2151DBC
	ldr r2, _020F7AD0 // =_02151D08
	ldr r1, [r1, #0]
	mov r3, #1
	add r1, r1, r4
	add r1, r1, #0x1d00
	strh r0, [r1, #0x4a]
	ldr r0, [r2, #0]
	add sp, sp, #0x38
	orr r0, r0, r3, lsl r5
	str r0, [r2]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F7A1C:
	cmp r6, #6
	bne _020F7A7C
	add r0, r2, r4
	add r0, r0, #0x1000
	ldrb r3, [r0, #0x526]
	cmp r3, #0xff
	addeq sp, sp, #0x38
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r0, _020F7ACC // =0x000005D4
	mov r1, #1
	mla r0, r3, r0, r2
	add r3, r0, #0x1d00
	ldrh r2, [r3, #0x4c]
	mvn r0, r1, lsl r7
	and r4, r2, r0
	mov r0, r7
	mov r1, #7
	mov r2, #0
	strh r4, [r3, #0x4c]
	bl MBi_CommChangeParentState
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020F7A7C:
	cmp r6, #7
	addne sp, sp, #0x38
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	add r0, r2, r4, lsl #1
	add r3, r0, #0x1700
	ldrh r0, [r3, #0x54]
	cmp r0, #5
	addne sp, sp, #0x38
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	mov r2, #0
	mov r0, r7
	mov r1, #8
	strh r2, [r3, #0x54]
	bl MBi_CommChangeParentState
_020F7ABC:
	add sp, sp, #0x38
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020F7AC8: .word 0x2151DBC
_020F7ACC: .word 0x000005D4
_020F7AD0: .word _02151D08
	arm_func_end MBi_CommParentRecvDataPerChild

	arm_func_start MBi_CommParentCallback
MBi_CommParentCallback: // 0x020F7AD4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r6, r0
	mov r4, r1
	cmp r6, #0x19
	bgt _020F7B38
	cmp r6, #0x19
	bge _020F7D80
	cmp r6, #0x11
	bgt _020F7B2C
	cmp r6, #0x11
	bge _020F7F38
	cmp r6, #3
	bgt _020F7F38
	cmp r6, #0
	blt _020F7F38
	cmp r6, #0
	beq _020F7B74
	cmp r6, #1
	beq _020F7B98
	cmp r6, #3
	beq _020F7D74
	b _020F7F38
_020F7B2C:
	cmp r6, #0x15
	beq _020F7B60
	b _020F7F38
_020F7B38:
	cmp r6, #0xff
	bgt _020F7B54
	cmp r6, #0xff
	bge _020F7E24
	cmp r6, #0x1c
	beq _020F7D88
	b _020F7F38
_020F7B54:
	cmp r6, #0x100
	beq _020F7E94
	b _020F7F38
_020F7B60:
	mov r2, r4
	mov r0, #0
	mov r1, #1
	bl MBi_CommChangeParentState
	b _020F7F38
_020F7B74:
	ldrh r0, [r4, #0x10]
	cmp r0, #0
	beq _020F7F38
	cmp r0, #0x10
	bhs _020F7F38
	mov r2, r4
	mov r1, #2
	bl MBi_CommChangeParentState
	b _020F7F38
_020F7B98:
	ldrh r0, [r4, #0x10]
	cmp r0, #0
	beq _020F7F38
	cmp r0, #0x10
	bhs _020F7F38
	ldr r2, _020F7F8C // =0x2151DBC
	sub r0, r0, #1
	ldr r3, [r2, #0]
	mov r1, #0
	add r0, r3, r0, lsl #1
	add r0, r0, #0x1400
	strh r1, [r0, #0x8a]
	ldrh r3, [r4, #0x10]
	ldr r5, [r2, #0]
	ldr r0, _020F7F90 // =0x000014A8
	sub r2, r3, #1
	add r0, r5, r0
	add r0, r0, r2, lsl #2
	mov r2, #4
	bl MI_CpuFill8
	ldr r0, _020F7F8C // =0x2151DBC
	ldrh r1, [r4, #0x10]
	ldr r0, [r0, #0]
	mov r2, #0x16
	add r0, r0, #0x1340
	sub r1, r1, #1
	mla r0, r1, r2, r0
	mov r1, #0
	bl MI_CpuFill8
	ldrh r0, [r4, #0x10]
	bl MBi_ClearParentPieceBuffer
	ldrh r1, [r4, #0x10]
	ldr r0, _020F7F8C // =0x2151DBC
	mov r3, #0
	ldr r2, [r0, #0]
	sub r1, r1, #1
	add r1, r2, r1, lsl #1
	add r1, r1, #0x1700
	strh r3, [r1, #0x54]
	ldrh r8, [r4, #0x10]
	ldr r5, [r0, #0]
	mvn r1, #0
	sub r7, r8, #1
	add r2, r5, r7
	add r2, r2, #0x1500
	ldrsb r3, [r2, #0x26]
	cmp r3, r1
	beq _020F7CC0
	ldr r2, _020F7F94 // =0x000005D4
	and r3, r3, #0xff
	mul r2, r3, r2
	add r3, r5, r2
	add r9, r3, #0x1d00
	mov r5, #1
	ldrh r10, [r9, #0x4e]
	mvn r3, r5, lsl r8
	and r10, r10, r3
	strh r10, [r9, #0x4e]
	ldr r9, [r0, #0]
	add r9, r9, r2
	add r9, r9, #0x1d00
	ldrh r10, [r9, #0x50]
	orr r5, r10, r5, lsl r8
	strh r5, [r9, #0x50]
	ldr r5, [r0, #0]
	add r5, r5, r7
	add r5, r5, #0x1000
	strb r1, [r5, #0x526]
	ldr r0, [r0, #0]
	add r0, r0, r2
	add r0, r0, #0x1d00
	ldrh r1, [r0, #0x4c]
	and r1, r1, r3
	strh r1, [r0, #0x4c]
_020F7CC0:
	ldr r1, _020F7F8C // =0x2151DBC
	ldrh r2, [r4, #0x10]
	ldr r7, [r1, #0]
	mov r3, #1
	add r0, r7, #0x1500
	ldrh r5, [r0, #0x36]
	mov r0, r3, lsl r2
	ands r0, r5, r0
	beq _020F7D10
	add r0, r7, #0x1000
	ldrb r2, [r0, #0x535]
	sub r2, r2, #1
	strb r2, [r0, #0x535]
	ldr r0, [r1, #0]
	ldrh r1, [r4, #0x10]
	add r0, r0, #0x1500
	ldrh r2, [r0, #0x36]
	mvn r1, r3, lsl r1
	and r1, r2, r1
	strh r1, [r0, #0x36]
_020F7D10:
	ldrh r0, [r4, #0x10]
	ldr r1, _020F7F8C // =0x2151DBC
	ldr r2, [r1, #0]
	sub r1, r0, #1
	add r1, r2, r1, lsl #2
	add r1, r1, #0x1000
	ldr r1, [r1, #0x4e8]
	cmp r1, #8
	bne _020F7D40
	mov r1, #9
	mov r2, #0
	bl MBi_CommChangeParentState
_020F7D40:
	ldrh r0, [r4, #0x10]
	mov r2, r4
	mov r1, #3
	bl MBi_CommChangeParentState
	ldrh r1, [r4, #0x10]
	ldr r0, _020F7F8C // =0x2151DBC
	mov r3, #0
	ldr r2, [r0, #0]
	sub r0, r1, #1
	add r0, r2, r0, lsl #2
	add r0, r0, #0x1000
	str r3, [r0, #0x4e8]
	b _020F7F38
_020F7D74:
	mov r0, r4
	bl MBi_CommParentRecvData
	b _020F7F38
_020F7D80:
	bl MBi_CommParentSendData
	b _020F7F38
_020F7D88:
	mov r5, #0
	ldr r9, _020F7F8C // =0x2151DBC
	ldr r7, _020F7F98 // =0x0000186C
	ldr r8, _020F7F94 // =0x000005D4
	mov r10, r5
_020F7D9C:
	mul r4, r5, r8
	ldr r1, [r9, #0]
	add r2, r1, r4
	add r0, r2, #0x1000
	ldrb r0, [r0, #0xd52]
	cmp r0, #0
	beq _020F7DEC
	add r0, r2, #0x1d00
	ldrh r3, [r0, #0x50]
	cmp r3, #0
	beq _020F7DEC
	ldrh r2, [r0, #0x4e]
	add r0, r1, r7
	add r0, r0, r4
	add r1, r1, #0x1340
	bl MB_UpdateGameInfoMember
	ldr r0, [r9, #0]
	add r0, r0, r4
	add r0, r0, #0x1d00
	strh r10, [r0, #0x50]
_020F7DEC:
	add r0, r5, #1
	and r5, r0, #0xff
	cmp r5, #0x10
	blo _020F7D9C
	bl MBi_GetGgid
	mov r5, r0
	bl MBi_GetTgid
	mov r4, r0
	bl MBi_GetAttribute
	mov r2, r0
	mov r0, r5
	mov r1, r4
	bl MB_SendGameInfoBeacon
	b _020F7F38
_020F7E24:
	ldrh r0, [r4, #2]
	cmp r0, #0xf
	addls pc, pc, r0, lsl #2
	b _020F7E84
_020F7E34: // jump table
	b _020F7E84 // case 0
	b _020F7E74 // case 1
	b _020F7E84 // case 2
	b _020F7E84 // case 3
	b _020F7E74 // case 4
	b _020F7E74 // case 5
	b _020F7E74 // case 6
	b _020F7E84 // case 7
	b _020F7E74 // case 8
	b _020F7E74 // case 9
	b _020F7E84 // case 10
	b _020F7E84 // case 11
	b _020F7E84 // case 12
	b _020F7E84 // case 13
	b _020F7E84 // case 14
	b _020F7E84 // case 15
_020F7E74:
	mov r0, #0
	mov r1, #9
	bl MBi_CommCallParentError
	b _020F7F38
_020F7E84:
	mov r0, #0
	mov r1, #8
	bl MBi_CommCallParentError
	b _020F7F38
_020F7E94:
	ldrh r0, [r4, #0]
	cmp r0, #0x1d
	addls pc, pc, r0, lsl #2
	b _020F7F2C
_020F7EA4: // jump table
	b _020F7F1C // case 0
	b _020F7F2C // case 1
	b _020F7F2C // case 2
	b _020F7F2C // case 3
	b _020F7F2C // case 4
	b _020F7F2C // case 5
	b _020F7F2C // case 6
	b _020F7F1C // case 7
	b _020F7F1C // case 8
	b _020F7F2C // case 9
	b _020F7F2C // case 10
	b _020F7F2C // case 11
	b _020F7F2C // case 12
	b _020F7F1C // case 13
	b _020F7F1C // case 14
	b _020F7F1C // case 15
	b _020F7F2C // case 16
	b _020F7F1C // case 17
	b _020F7F1C // case 18
	b _020F7F2C // case 19
	b _020F7F2C // case 20
	b _020F7F1C // case 21
	b _020F7F2C // case 22
	b _020F7F2C // case 23
	b _020F7F2C // case 24
	b _020F7F1C // case 25
	b _020F7F2C // case 26
	b _020F7F2C // case 27
	b _020F7F2C // case 28
	b _020F7F1C // case 29
_020F7F1C:
	mov r0, #0
	mov r1, #9
	bl MBi_CommCallParentError
	b _020F7F38
_020F7F2C:
	mov r0, #0
	mov r1, #8
	bl MBi_CommCallParentError
_020F7F38:
	cmp r6, #0x11
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bxne lr
	ldr r1, _020F7F8C // =0x2151DBC
	mov r0, #0
	ldr r1, [r1, #0]
	mov r2, #0x7d00
	add r3, r1, #0x1000
	ldr r4, [r3, #0x4e4]
	bl MIi_CpuClearFast
	ldr r1, _020F7F8C // =0x2151DBC
	mov r0, #0
	str r0, [r1]
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bxeq lr
	mov r2, r0
	mov r1, #0xc
	blx r4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020F7F8C: .word 0x2151DBC
_020F7F90: .word 0x000014A8
_020F7F94: .word 0x000005D4
_020F7F98: .word 0x0000186C
	arm_func_end MBi_CommParentCallback

	arm_func_start MBi_CommChangeParentStateCallbackOnly
MBi_CommChangeParentStateCallbackOnly: // 0x020F7F9C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, _020F7FD4 // =0x2151DBC
	ldr r3, [r3, #0]
	add r3, r3, #0x1000
	ldr r3, [r3, #0x4e4]
	cmp r3, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	blx r3
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F7FD4: .word 0x2151DBC
	arm_func_end MBi_CommChangeParentStateCallbackOnly

	arm_func_start MBi_CommChangeParentState
MBi_CommChangeParentState: // 0x020F7FD8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl IsChildAidValid
	cmp r0, #0
	beq _020F800C
	ldr r0, _020F8024 // =0x2151DBC
	sub r1, r6, #1
	ldr r0, [r0, #0]
	add r0, r0, r1, lsl #2
	add r0, r0, #0x1000
	str r5, [r0, #0x4e8]
_020F800C:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl MBi_CommChangeParentStateCallbackOnly
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020F8024: .word 0x2151DBC
	arm_func_end MBi_CommChangeParentState

	arm_func_start MB_CommResponseRequest
MB_CommResponseRequest: // 0x020F8028
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r1
	mov r7, r0
	bl OS_DisableInterrupts
	mov r4, r0
	cmp r5, #3
	addls pc, pc, r5, lsl #2
	b _020F808C
_020F804C: // jump table
	b _020F805C // case 0
	b _020F8068 // case 1
	b _020F8074 // case 2
	b _020F8080 // case 3
_020F805C:
	mov r5, #0xa
	mov r6, #4
	b _020F80A4
_020F8068:
	mov r5, #0xa
	mov r6, #3
	b _020F80A4
_020F8074:
	mov r5, #0xe
	mov r6, #2
	b _020F80A4
_020F8080:
	mov r5, #7
	mov r6, #5
	b _020F80A4
_020F808C:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F80A4:
	ldr r0, _020F8120 // =0x2151DBC
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _020F8108
	mov r0, r7
	bl IsChildAidValid
	cmp r0, #0
	beq _020F8108
	ldr r0, _020F8120 // =0x2151DBC
	sub r2, r7, #1
	ldr r1, [r0, #0]
	add r0, r1, r2, lsl #2
	add r0, r0, #0x1000
	ldr r0, [r0, #0x4e8]
	cmp r5, r0
	bne _020F8108
	add r0, r1, r2, lsl #1
	add r1, r0, #0x1700
	mov r0, r4
	strh r6, [r1, #0x54]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F8108:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F8120: .word 0x2151DBC
	arm_func_end MB_CommResponseRequest

	arm_func_start MB_CommIsBootable
MB_CommIsBootable: // 0x020F8124
	stmdb sp!, {r4, lr}
	ldr r1, _020F817C // =0x2151DBC
	mov r4, r0
	ldr r1, [r1, #0]
	cmp r1, #0
	beq _020F8170
	bl IsChildAidValid
	cmp r0, #0
	beq _020F8170
	ldr r0, _020F817C // =0x2151DBC
	sub r1, r4, #1
	ldr r0, [r0, #0]
	add r0, r0, r1, lsl #2
	add r0, r0, #0x1000
	ldr r0, [r0, #0x4e8]
	cmp r0, #7
	moveq r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
_020F8170:
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F817C: .word 0x2151DBC
	arm_func_end MB_CommIsBootable

	arm_func_start MB_CommGetChildUser
MB_CommGetChildUser: // 0x020F8180
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020F8214 // =0x2151DBC
	mov r4, r0
	ldr r0, [r1, #0]
	cmp r0, #0
	beq _020F81FC
	mov r0, r5
	bl IsChildAidValid
	cmp r0, #0
	beq _020F81FC
	ldr r0, _020F8214 // =0x2151DBC
	sub r3, r5, #1
	ldr ip, [r0]
	ldr r1, _020F8218 // =0x00001772
	add r0, ip, #0x1340
	mov r2, #0x16
	mla r0, r3, r2, r0
	add r1, ip, r1
	bl MI_CpuCopy8
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r1, _020F8214 // =0x2151DBC
	ldr r0, _020F8218 // =0x00001772
	ldr r1, [r1, #0]
	add sp, sp, #4
	add r0, r1, r0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F81FC:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F8214: .word 0x2151DBC
_020F8218: .word 0x00001772
	arm_func_end MB_CommGetChildUser

	arm_func_start MB_CommSetParentStateCallback
MB_CommSetParentStateCallback: // 0x020F821C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _020F8244 // =0x2151DBC
	ldr r1, [r1, #0]
	add r1, r1, #0x1000
	str r4, [r1, #0x4e4]
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F8244: .word 0x2151DBC
	arm_func_end MB_CommSetParentStateCallback

	arm_func_start MB_IsAbleToLoad
MB_IsAbleToLoad: // 0x020F8248
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, _020F834C // _02117000
	ldr r3, [r3, r0, lsl #2]
	cmp r3, #0
	beq _020F8270
	cmp r3, #1
	beq _020F8280
	cmp r3, #2
	bne _020F832C
_020F8270:
	bl MBi_IsAbleToRecv
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020F8280:
	cmp r1, #0x2000000
	blo _020F82F8
	ldr r0, _020F8350 // =0x023FE800
	cmp r1, r0
	bhs _020F82F8
	cmp r1, #0x2300000
	add r1, r1, r2
	bhs _020F82B4
	cmp r1, #0x2300000
	addhi sp, sp, #4
	movhi r0, #0
	ldmhiia sp!, {lr}
	bxhi lr
_020F82B4:
	cmp r1, #0x2300000
	addls sp, sp, #4
	movls r0, #1
	ldmlsia sp!, {lr}
	bxls lr
	ldr r0, _020F8350 // =0x023FE800
	cmp r1, r0
	bhs _020F82E8
	cmp r2, #0x40000
	addls sp, sp, #4
	movls r0, #1
	ldmlsia sp!, {lr}
	bxls lr
_020F82E8:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {lr}
	bx lr
_020F82F8:
	ldr r0, _020F8354 // =0x037F8000
	cmp r1, r0
	blo _020F833C
	ldr r0, _020F8358 // =0x0380F000
	cmp r1, r0
	bhs _020F833C
	add r1, r1, r2
	cmp r1, r0
	movls r0, #1
	add sp, sp, #4
	movhi r0, #0
	ldmia sp!, {lr}
	bx lr
_020F832C:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {lr}
	bx lr
_020F833C:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F834C: .word _02117000
_020F8350: .word 0x023FE800
_020F8354: .word 0x037F8000
_020F8358: .word 0x0380F000
	arm_func_end MB_IsAbleToLoad

	arm_func_start MBi_IsAbleToRecv
MBi_IsAbleToRecv: // 0x020F835C
	ldr r3, _020F8400 // _02117000
	ldr r0, [r3, r0, lsl #2]
	cmp r0, #0
	beq _020F83A0
	cmp r0, #1
	beq _020F83BC
	cmp r0, #2
	bne _020F83F0
	ldr r0, _020F8404 // =0x027FFE00
	cmp r1, r0
	blo _020F83F8
	ldr r0, _020F8408 // =0x027FFF60
	add r1, r1, r2
	cmp r1, r0
	bhi _020F83F8
	mov r0, #1
	bx lr
_020F83A0:
	cmp r1, #0x2000000
	blo _020F83F8
	add r0, r1, r2
	cmp r0, #0x22c0000
	bhi _020F83F8
	mov r0, #1
	bx lr
_020F83BC:
	cmp r1, #0x22c0000
	blo _020F83D4
	add r0, r1, r2
	cmp r0, #0x2300000
	movls r0, #1
	bxls lr
_020F83D4:
	cmp r1, #0x2000000
	blo _020F83F8
	add r0, r1, r2
	cmp r0, #0x2300000
	bhi _020F83F8
	mov r0, #1
	bx lr
_020F83F0:
	mov r0, #0
	bx lr
_020F83F8:
	mov r0, #0
	bx lr
	.align 2, 0
_020F8400: .word _02117000
_020F8404: .word 0x027FFE00
_020F8408: .word 0x027FFF60
	arm_func_end MBi_IsAbleToRecv

	arm_func_start MBi_get_blockinfo
MBi_get_blockinfo: // 0x020F840C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldrh r4, [r1, #0x12]
	cmp r2, r4
	addhs sp, sp, #4
	movhs r0, #0
	ldmhsia sp!, {r4, r5, lr}
	bxhs lr
	mov ip, #2
_020F8430:
	add r4, r1, ip, lsl #1
	ldrh r4, [r4, #0xc]
	cmp r2, r4
	bhs _020F8450
	sub r4, ip, #1
	mov ip, r4, lsl #0x18
	movs ip, ip, asr #0x18
	bpl _020F8430
_020F8450:
	cmp ip, #0
	addlt sp, sp, #4
	movlt r0, #0
	ldmltia sp!, {r4, r5, lr}
	bxlt lr
	ldr r4, _020F84DC // =0x2151DBC
	add r5, r1, ip, lsl #1
	ldr lr, [r4]
	ldrh r5, [r5, #0xc]
	add lr, lr, #0x1000
	ldr lr, [lr, #0x318]
	sub r5, r2, r5
	mul r2, r5, lr
	add r3, r3, #0xc
	add r5, r3, ip, lsl #4
	ldr r3, [r5, #8]
	sub r3, r3, r2
	str r3, [r0, #4]
	ldr r3, [r4, #0]
	ldr r4, [r0, #4]
	add r3, r3, #0x1000
	ldr r3, [r3, #0x318]
	cmp r4, r3
	strhi r3, [r0, #4]
	ldr r1, [r1, ip, lsl #2]
	add r1, r2, r1
	str r1, [r0, #8]
	ldr r1, [r5, #0]
	add r1, r2, r1
	str r1, [r0]
	strb ip, [r0, #0xc]
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F84DC: .word 0x2151DBC
	arm_func_end MBi_get_blockinfo

	arm_func_start MBi_MakeBlockInfoTable
MBi_MakeBlockInfoTable: // 0x020F84E0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r5, r0
	add r4, r5, #0xc
	cmp r1, #0
	mov r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bxeq lr
	mov r2, r0
_020F8500:
	str r0, [r5, r2, lsl #2]
	add r3, r1, r2, lsl #4
	add r2, r2, #1
	ldr r3, [r3, #0x14]
	and r2, r2, #0xff
	cmp r2, #3
	add r0, r0, r3
	blo _020F8500
	mov r8, #0
	strh r8, [r4]
	ldr r6, _020F85B8 // =0x2151DBC
	add r7, r1, #0xc
_020F8530:
	ldr r0, [r6, #0]
	add r10, r7, r8, lsl #4
	add r0, r0, #0x1000
	ldr r1, [r0, #0x318]
	ldr r9, [r10, #8]
	add r0, r9, r1
	sub r0, r0, #1
	bl _u32_div_f
	mov r1, r8, lsl #1
	ldrh r3, [r4, r1]
	mov r2, r0, lsl #0x10
	ldr r1, [r10, #4]
	add r2, r3, r2, lsr #16
	mov r3, r2, lsl #0x10
	mov r2, r9
	mov r0, r8
	mov r9, r3, lsr #0x10
	bl MB_IsAbleToLoad
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bxeq lr
	cmp r8, #2
	addlo r0, r8, #1
	movlo r0, r0, lsl #1
	strloh r9, [r4, r0]
	add r0, r8, #1
	and r8, r0, #0xff
	strhsh r9, [r5, #0x12]
	cmp r8, #3
	blo _020F8530
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020F85B8: .word 0x2151DBC
	arm_func_end MBi_MakeBlockInfoTable

	arm_func_start MBi_SetSegmentInfo
MBi_SetSegmentInfo: // 0x020F85BC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r1, [r1, #0]
	mov r7, r2
	mov r6, r3
	cmp r1, #0
	beq _020F85F4
	cmp r1, #1
	beq _020F8658
	cmp r1, #2
	beq _020F8734
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F85F4:
	ldr r2, [r0, #0x28]
	add r3, r0, #0x28
	cmp r2, #0x2000000
	blo _020F8648
	cmp r2, #0x22c0000
	bhs _020F8648
	ldr r1, [r3, #4]
	add r0, r2, r1
	cmp r0, #0x22c0000
	bhi _020F8648
	str r1, [r7, #8]
	ldr r0, [r3, #0]
	add sp, sp, #4
	str r0, [r7, #4]
	ldr r0, [r7, #4]
	str r0, [r7]
	ldr r0, [r7, #0xc]
	bic r0, r0, #1
	str r0, [r7, #0xc]
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F8648:
	bl OS_Terminate
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F8658:
	add r4, r0, #0x38
	ldr r2, [r0, #0x38]
	ldr r1, [r4, #4]
	mov ip, #0
	mov r5, ip
	cmp r2, #0x2000000
	add r3, r2, r1
	blo _020F86A8
	ldr r0, _020F8764 // =0x023FE800
	cmp r2, r0
	bhs _020F86A8
	cmp r3, #0x2300000
	bls _020F86D4
	cmp r3, r0
	bhs _020F86A0
	cmp r1, #0x40000
	movls r5, #1
	bls _020F86D4
_020F86A0:
	mov ip, #1
	b _020F86D4
_020F86A8:
	ldr r0, _020F8768 // =0x037F8000
	cmp r2, r0
	blo _020F86D0
	ldr r0, _020F876C // =0x0380F000
	cmp r2, r0
	bhs _020F86D0
	cmp r3, r0
	movls r5, #1
	movhi ip, #1
	b _020F86D4
_020F86D0:
	mov ip, #1
_020F86D4:
	cmp ip, #1
	bne _020F86E0
	bl OS_Terminate
_020F86E0:
	ldr r0, [r4, #4]
	cmp r5, #0
	str r0, [r7, #8]
	ldr r0, [r4, #0]
	str r0, [r7, #4]
	ldreq r0, [r7, #4]
	streq r0, [r7]
	beq _020F8718
	ldr r0, [r6, #0]
	str r0, [r7]
	ldr r1, [r6, #0]
	ldr r0, [r7, #8]
	add r0, r1, r0
	str r0, [r6]
_020F8718:
	ldr r0, [r7, #0xc]
	add sp, sp, #4
	bic r0, r0, #1
	orr r0, r0, #1
	str r0, [r7, #0xc]
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F8734:
	mov r1, #0x160
	ldr r0, _020F8770 // =0x027FFE00
	str r1, [r7, #8]
	str r0, [r7, #4]
	ldr r0, [r7, #4]
	str r0, [r7]
	ldr r0, [r7, #0xc]
	bic r0, r0, #1
	str r0, [r7, #0xc]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F8764: .word 0x023FE800
_020F8768: .word 0x037F8000
_020F876C: .word 0x0380F000
_020F8770: .word 0x027FFE00
	arm_func_end MBi_SetSegmentInfo

	arm_func_start MBi_MakeDownloadFileInfo
MBi_MakeDownloadFileInfo: // 0x020F8774
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r2, #0x22c0000
	mov r5, r1
	str r2, [sp]
	mov r6, r0
	ldr r0, [r5, #0x24]
	ldr r4, _020F87F4 // _02117000
	str r0, [r6]
	ldr r0, [r5, #0x34]
	add r8, r5, #0x160
	str r0, [r6, #4]
	add r10, r6, #0xc
	mov r9, #0
	add r7, sp, #0
_020F87B0:
	mov r0, r5
	mov r1, r4
	mov r2, r10
	mov r3, r7
	bl MBi_SetSegmentInfo
	add r9, r9, #1
	cmp r9, #3
	add r10, r10, #0x10
	add r4, r4, #4
	blt _020F87B0
	mov r0, r8
	add r1, r6, #0x3c
	mov r2, #0x88
	bl MI_CpuCopy8
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020F87F4: .word _02117000
	arm_func_end MBi_MakeDownloadFileInfo

	arm_func_start MB_UnregisterFile
MB_UnregisterFile: // 0x020F87F8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, r1
	mov r6, #0xff
	bl OS_DisableInterrupts
	mov r5, r0
	bl MBi_IsStarted
	cmp r0, #0
	bne _020F8838
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020F8838:
	ldr r0, _020F8AB0 // =0x2151DBC
	ldr r0, [r0, #0]
	add r1, r0, #0x1000
	ldrb r1, [r1, #0x524]
	add r1, r1, #1
	cmp r1, #0x10
	ble _020F886C
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020F886C:
	ldr r1, _020F8AB4 // =0x000005D4
	mov r4, #0
_020F8874:
	mla r2, r4, r1, r0
	add r2, r2, #0x1000
	ldr r3, [r2, #0xd40]
	cmp r3, r9
	bne _020F88A0
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020F88A0:
	ldrb r2, [r2, #0xd52]
	cmp r2, #0
	moveq r6, r4
	beq _020F88C0
	add r2, r4, #1
	and r4, r2, #0xff
	cmp r4, #0x10
	blo _020F8874
_020F88C0:
	cmp r4, #0x10
	bne _020F88E0
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020F88E0:
	ldr r1, _020F8AB4 // =0x000005D4
	ldr r2, _020F8AB0 // =0x2151DBC
	mul r4, r6, r1
	add r0, r0, r4
	add r0, r0, #0x1000
	str r9, [r0, #0xd40]
	ldr r2, [r2, #0]
	ldr r0, _020F8AB8 // =0x00001788
	mov r1, r8
	add r0, r2, r0
	add r7, r0, r4
	mov r0, r7
	bl MBi_MakeDownloadFileInfo
	add r0, r9, #0x1c
	add r1, r7, #0xc4
	mov r2, #0x20
	bl MI_CpuCopy8
	ldr r1, _020F8AB0 // =0x2151DBC
	ldr r0, _020F8ABC // =0x00001D2C
	ldr r2, [r1, #0]
	mov r1, r7
	add r0, r2, r0
	add r0, r0, r4
	bl MBi_MakeBlockInfoTable
	cmp r0, #0
	bne _020F8960
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020F8960:
	ldr r1, _020F8AB0 // =0x2151DBC
	ldr r0, _020F8AC0 // =0x0000186C
	ldr r2, [r1, #0]
	mov r1, r9
	add r0, r2, r0
	add r0, r0, r4
	add r2, r2, #0x1300
	bl sub_20F98C0
	ldr r2, _020F8AB0 // =0x2151DBC
	ldr r1, _020F8AC0 // =0x0000186C
	ldr r0, [r2, #0]
	add r0, r0, r4
	add r0, r0, #0x1000
	strb r6, [r0, #0xd21]
	ldr r0, [r2, #0]
	add r0, r0, r1
	add r0, r0, r4
	bl sub_20F971C
	ldr r0, _020F8AC4 // =0x02151D0C
	ldr r1, _020F8AB0 // =0x2151DBC
	ldrb r7, [r0, #0]
	ldr r3, [r1, #0]
	mov r2, #1
	add r6, r7, #1
	add r3, r3, r4
	strb r6, [r0]
	add r0, r3, #0x1000
	strb r7, [r0, #0xd1f]
	ldr r0, [r1, #0]
	add r3, r8, #0x1e8
	add r0, r0, r4
	add r0, r0, #0x1d00
	strh r2, [r0, #0x4e]
	ldr r0, [r1, #0]
	add r2, r8, #0x258
	add r0, r0, r4
	add r0, r0, #0x1000
	str r8, [r0, #0xd44]
	ldr r0, [r1, #0]
	add r0, r0, r4
	add r0, r0, #0x1000
	str r3, [r0, #0xd54]
	ldr r0, [r1, #0]
	add r0, r0, r4
	add r0, r0, #0x1000
	str r2, [r0, #0xd58]
	ldr r0, [r1, #0]
	add r0, r0, r4
	add r0, r0, #0x1000
	ldr r0, [r0, #0xd54]
	ldr r0, [r0, #0x6c]
	cmp r0, #0
	beq _020F8A6C
	bl MBi_IsTaskAvailable
	cmp r0, #0
	bne _020F8A6C
	ldr r1, _020F8AB0 // =0x2151DBC
	ldr r0, _020F8AC8 // =0x00007CE0
	ldr r1, [r1, #0]
	add r0, r1, r0
	bl MBi_InitTaskInfo
	ldr r1, _020F8AB0 // =0x2151DBC
	ldr r0, _020F8ACC // =0x000074E0
	ldr r2, [r1, #0]
	mov r1, #0x800
	add r0, r2, r0
	bl MBi_InitTaskThread
_020F8A6C:
	ldr r2, _020F8AB0 // =0x2151DBC
	mov r3, #1
	ldr r1, [r2, #0]
	mov r0, r5
	add r1, r1, r4
	add r1, r1, #0x1000
	strb r3, [r1, #0xd52]
	ldr r1, [r2, #0]
	add r1, r1, #0x1000
	ldrb r2, [r1, #0x524]
	add r2, r2, #1
	strb r2, [r1, #0x524]
	bl OS_RestoreInterrupts
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020F8AB0: .word 0x2151DBC
_020F8AB4: .word 0x000005D4
_020F8AB8: .word 0x00001788
_020F8ABC: .word 0x00001D2C
_020F8AC0: .word 0x0000186C
_020F8AC4: .word 0x02151D0C
_020F8AC8: .word 0x00007CE0
_020F8ACC: .word 0x000074E0
	arm_func_end MB_UnregisterFile

	arm_func_start MBi_ReadSegmentHeader
MBi_ReadSegmentHeader: // 0x020F8AD0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, r1
	ldr ip, [r0]
	ldr r1, [r0, #0xc]
	cmp lr, #0x4000
	movlo lr, #0x4000
	cmp r2, #0x8000
	movhi r2, #0x8000
	cmp lr, ip
	add r1, ip, r1
	movlo lr, ip
	cmp r2, r1
	movhi r2, r1
	cmp lr, r2
	addhs sp, sp, #4
	ldmhsia sp!, {lr}
	bxhs lr
	cmp r3, #0
	beq _020F8B40
	ldr r0, [r0, #8]
	sub r2, r2, lr
	add r0, r0, lr
	mov r1, #0
	bl MI_CpuFill8
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020F8B40:
	ldr r3, [r0, #4]
	ldr r1, [r0, #8]
	add r0, r3, lr
	add r1, r1, lr
	sub r2, r2, lr
	bl MI_CpuCopy8
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end MBi_ReadSegmentHeader

	arm_func_start MB_ReadSegment
MB_ReadSegment: // 0x020F8B64
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x6c
	str r2, [sp, #4]
	cmp r2, #0x164
	mov r2, #0
	mov r10, r0
	mov r9, r1
	str r2, [sp, #8]
	blo _020F8FA8
	ldr r8, [sp, #4]
	mov r7, r9
	str r2, [sp, #0xc]
	mov r6, r2
	mov r5, r2
	cmp r10, #0
	add r7, r7, #0x160
	sub r8, r8, #0x160
	beq _020F8BD8
	ldr r4, [r10, #0x2c]
	ldr r3, [r10, #0x24]
	mov r2, #0x160
	sub r11, r4, r3
	bl FS_ReadFile
	cmp r0, #0x160
	ldr r4, [r9, #0x80]
	movlt r8, r5
	cmp r4, #0
	moveq r4, #0x1000000
	b _020F8C50
_020F8BD8:
	ldr r0, _020F8FB8 // =0x027FFE00
	mov r1, #1
	ldr r4, [r0, #0x80]
	add r0, sp, #0x20
	cmp r4, #0
	moveq r4, #0x1000000
	str r1, [sp, #0xc]
	bl FS_InitFile
	ldr r0, _020F8FBC // _0211F9D8
	mov r1, #3
	bl FS_FindArchive
	mov r1, r0
	mvn r0, #0
	str r0, [sp]
	add r0, sp, #0x20
	mov r2, #0
	add r3, r4, #0x88
	bl FS_OpenFileDirect
	ldr r2, [sp, #0x4c]
	ldr r1, [sp, #0x44]
	ldr r0, _020F8FB8 // =0x027FFE00
	sub r11, r2, r1
	mov r1, r9
	mov r2, #0x160
	add r10, sp, #0x20
	bl MI_CpuCopy8
	ldr r1, [r9, #0x60]
	ldr r0, _020F8FC0 // =0x00406000
	orr r0, r1, r0
	str r0, [r9, #0x60]
_020F8C50:
	cmp r8, #0x88
	movlo r8, #0
	blo _020F8C84
	mov r0, r10
	add r1, r11, r4
	mov r2, #0
	bl FS_SeekFile
	mov r0, r10
	mov r1, r7
	mov r2, #0x88
	bl FS_ReadFile
	add r7, r7, #0x88
	sub r8, r8, #0x88
_020F8C84:
	cmp r8, #0x70
	blo _020F8CF4
	mov r0, r7
	mov r6, r7
	bl MBi_InitCache
	add r7, r7, #0x70
	sub r8, r8, #0x70
	mov r0, #3
	str r0, [sp]
	mov r0, r6
	mov r1, #0
	mov r2, #0x160
	mov r3, r9
	bl MBi_AttachCacheBuffer
	ldr r0, [r10, #8]
	mov r4, #0
	b _020F8CCC
_020F8CC8:
	add r4, r4, #1
_020F8CCC:
	cmp r4, #3
	bge _020F8CE0
	ldrsb r1, [r0, r4]
	cmp r1, #0
	bne _020F8CC8
_020F8CE0:
	mov r2, r4
	add r1, r6, #0x10
	bl MI_CpuCopy8
	str r4, [r6, #0x14]
	b _020F8CF8
_020F8CF4:
	mov r8, #0
_020F8CF8:
	cmp r8, #0x10
	movlo r8, #0
	blo _020F8D40
	mov r0, #0
	str r0, [r7]
	ldr r0, [r10, #0x24]
	ldr r1, [r9, #0x20]
	add r0, r11, r0
	add r0, r1, r0
	str r0, [r7, #4]
	ldr r0, [r10, #0x24]
	ldr r1, [r9, #0x30]
	add r0, r11, r0
	add r0, r1, r0
	mov r5, r7
	str r0, [r7, #8]
	add r7, r7, #0x10
	sub r8, r8, #0x10
_020F8D40:
	ldr r1, [r9, #0x2c]
	ldr r0, [r9, #0x3c]
	add r0, r1, r0
	cmp r8, r0
	blo _020F8DEC
	ldr r4, [r10, #0x24]
	ldr r1, [r5, #4]
	mov r0, r10
	sub r1, r1, r4
	mov r2, #0
	bl FS_SeekFile
	ldr r2, [r9, #0x2c]
	mov r0, r10
	mov r1, r7
	bl FS_ReadFile
	mov r0, #3
	str r0, [sp]
	ldr r1, [r5, #4]
	ldr r2, [r9, #0x2c]
	mov r0, r6
	mov r3, r7
	bl MBi_AttachCacheBuffer
	ldr r1, [r9, #0x2c]
	mov r0, r10
	add r7, r7, r1
	ldr r1, [r5, #8]
	mov r2, #0
	sub r1, r1, r4
	bl FS_SeekFile
	ldr r2, [r9, #0x3c]
	mov r0, r10
	mov r1, r7
	bl FS_ReadFile
	mov r0, #3
	str r0, [sp]
	ldr r1, [r5, #8]
	ldr r2, [r9, #0x3c]
	mov r3, r7
	mov r0, r6
	bl MBi_AttachCacheBuffer
	mov r0, #1
	str r0, [sp, #8]
	b _020F8EC0
_020F8DEC:
	cmp r8, #0xcc00
	blo _020F8EC0
	ldr r4, [r10, #0x24]
	ldr r5, [r5, #4]
	mov r0, r10
	sub r1, r5, r4
	mov r2, #0
	bl FS_SeekFile
	mov r0, r10
	mov r1, r7
	mov r2, #0x4400
	bl FS_ReadFile
	mov r0, #3
	str r0, [sp]
	mov r0, r6
	mov r1, r5
	mov r2, #0x4400
	mov r3, r7
	bl MBi_AttachCacheBuffer
	add r1, r5, #0x4400
	mov r0, r10
	sub r1, r1, r4
	mov r2, #0
	bl FS_SeekFile
	mov r0, r10
	add r1, r7, #0x4400
	mov r2, #0x4400
	bl FS_ReadFile
	mov r0, #2
	str r0, [sp]
	mov r0, r6
	add r1, r5, #0x4400
	mov r2, #0x4400
	add r3, r7, #0x4400
	bl MBi_AttachCacheBuffer
	add r1, r5, #0x8800
	mov r0, r10
	sub r1, r1, r4
	mov r2, #0
	bl FS_SeekFile
	mov r0, r10
	add r1, r7, #0x8800
	mov r2, #0x4400
	bl FS_ReadFile
	mov r0, #2
	str r0, [sp]
	add r1, r5, #0x8800
	add r3, r7, #0x8800
	mov r0, r6
	mov r2, #0x4400
	bl MBi_AttachCacheBuffer
	mov r0, #1
	str r0, [sp, #8]
_020F8EC0:
	mov r0, r10
	mov r1, r11
	mov r2, #0
	bl FS_SeekFile
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _020F8F90
	add r0, sp, #0x20
	bl FS_CloseFile
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _020F8F90
	ldr r1, [r9, #0x20]
	ldr r0, _020F8FC4 // _0211F9D4
	str r1, [sp, #0x10]
	ldr r2, [r9, #0x28]
	ldr r1, [r9, #0x20]
	ldr r4, [r0, #0]
	sub r0, r2, r1
	str r0, [sp, #0x14]
	ldr r2, [r6, #0x48]
	ldr r1, [r9, #0x20]
	add r0, sp, #0x10
	sub r1, r2, r1
	str r1, [sp, #0x18]
	ldr r1, [sp, #4]
	mov r2, #0x8000
	str r1, [sp, #0x1c]
	mov r1, #0x4000
	mov r3, #1
	bl MBi_ReadSegmentHeader
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _020F8F78
	add r7, sp, #0x10
	mov r5, #0
_020F8F50:
	ldr r1, [r4, #0]
	ldr r2, [r4, #4]
	mov r0, r7
	mov r3, r5
	add r2, r1, r2
	bl MBi_ReadSegmentHeader
	add r4, r4, #8
	ldr r0, [r4, #4]
	cmp r0, #0
	bne _020F8F50
_020F8F78:
	ldr r1, [r9, #0x28]
	ldr r2, _020F8FC8 // =_start_AutoloadDoneCallback
	ldr r3, [r6, #0x48]
	ldr r0, _020F8FCC // =0xE12FFF1E
	sub r1, r2, r1
	str r0, [r3, r1]
_020F8F90:
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _020F8FA8
	ldr r1, [sp, #4]
	mov r0, r9
	bl DC_FlushRange
_020F8FA8:
	ldr r0, [sp, #8]
	add sp, sp, #0x6c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F8FB8: .word 0x027FFE00
_020F8FBC: .word _0211F9D8
_020F8FC0: .word 0x00406000
_020F8FC4: .word _0211F9D4
_020F8FC8: .word _start_AutoloadDoneCallback
_020F8FCC: .word 0xE12FFF1E
	arm_func_end MB_ReadSegment

	arm_func_start MB_GetSegmentLength
MB_GetSegmentLength: // 0x020F8FD0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x64
	mov r6, #0
	movs r7, r0
	mov r5, r6
	beq _020F901C
	ldr ip, [r7, #0x2c]
	ldr r3, [r7, #0x24]
	add r1, sp, #0
	mov r2, #0x60
	sub r4, ip, r3
	bl FS_ReadFile
	cmp r0, #0x60
	mov r0, r7
	mov r1, r4
	mov r2, #0
	addhs r6, sp, #0
	bl FS_SeekFile
	b _020F9020
_020F901C:
	ldr r6, _020F9050 // =0x027FFE00
_020F9020:
	cmp r6, #0
	beq _020F9040
	ldr r1, [r6, #0x2c]
	ldr r0, [r6, #0x3c]
	add r1, r1, #0x268
	add r5, r1, r0
	cmp r5, #0x10000
	movlo r5, #0x10000
_020F9040:
	mov r0, r5
	add sp, sp, #0x64
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F9050: .word 0x027FFE00
	arm_func_end MB_GetSegmentLength

	arm_func_start MBi_calc_cksum
MBi_calc_cksum: // 0x020F9054
	mov r2, r1, asr #1
	cmp r2, #0
	mov r3, #0
	ble _020F9078
_020F9064:
	ldrh r1, [r0], #2
	sub r2, r2, #1
	cmp r2, #0
	add r3, r3, r1
	bgt _020F9064
_020F9078:
	ldr r0, _020F9098 // =0x0000FFFF
	and r1, r3, r0
	add r1, r1, r3, lsr #16
	add r1, r1, r1, lsr #16
	eor r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_020F9098: .word 0x0000FFFF
	arm_func_end MBi_calc_cksum

	arm_func_start MBi_BlockHeaderEnd
MBi_BlockHeaderEnd: // 0x020F909C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r4, r2
	add r2, r6, #0x1f
	mov r5, r1
	mov r0, r4
	bic r1, r2, #0x1f
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl MBi_SendMP
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end MBi_BlockHeaderEnd

	arm_func_start MBi_SendVolatBeacon
MBi_SendVolatBeacon: // 0x020F90D8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	ldr r3, _020F9360 // =0x02151D18
	str r0, [sp, #8]
	ldr r0, [r3, #4]
	ldrb r3, [r3, #0xe]
	ldrb r0, [r0, #0x4b4]
	str r1, [sp, #0xc]
	str r2, [sp, #0x10]
	cmp r3, r0
	beq _020F9108
	bl MBi_InitSendVolatBeacon
_020F9108:
	ldr r3, _020F9364 // =0x02151D40
	ldr r1, _020F9360 // =0x02151D18
	ldrb r2, [r3, #4]
	ldr r0, [r1, #4]
	ldrb r5, [r1, #0x11]
	bic r2, r2, #3
	orr r2, r2, #2
	strb r2, [r3, #4]
	ldrb r4, [r0, #0x4b3]
	ldrb r2, [r1, #0xe]
	ldrb r7, [r3, #4]
	strb r4, [r3, #5]
	strb r2, [r3, #6]
	ldr r4, [r0, #0x4b8]
	ldr r2, _020F9368 // =0x02151D10
	str r4, [r3]
	ldrb r6, [r0, #0x4b5]
	add r4, r5, #1
	bic r7, r7, #0xfc
	and r6, r6, #0x3f
	orr r6, r7, r6, lsl #2
	strb r6, [r3, #4]
	strb r4, [r1, #0x11]
	strb r5, [r3, #7]
	ldrb r4, [r0, #0x358]
	add r1, r0, #0x300
	ldr r2, [r2, #0]
	strb r4, [r3, #0xa]
	ldrh r4, [r1, #0x5a]
	cmp r2, #0
	strh r4, [r3, #0xc]
	ldrh r1, [r1, #0x5c]
	strh r1, [r3, #0xe]
	bne _020F91A8
	ldr r1, _020F936C // =0x02151D14
	ldr r1, [r1, #0]
	cmp r1, #0
	beq _020F91A8
	ldr r0, [r0, #0x4b8]
	blx r1
_020F91A8:
	ldr r0, _020F9360 // =0x02151D18
	ldr r1, _020F9364 // =0x02151D40
	ldr r2, [r0, #4]
	mov r3, #0
_020F91B8:
	ldrb r0, [r2, #0x4a8]
	add r3, r3, #1
	cmp r3, #8
	strb r0, [r1, #0x68]
	add r2, r2, #1
	add r1, r1, #1
	blt _020F91B8
	ldr r1, _020F9370 // =0x02151D50
	mov r0, #0
	mov r2, #0x58
	bl MIi_CpuClear16
	ldr r0, _020F9360 // =0x02151D18
	mov r10, #0
	ldr r1, [r0, #4]
	ldr r9, _020F9370 // =0x02151D50
	add r0, r1, #0x400
	add r1, r1, #0x300
	ldrh r2, [r0, #0xb0]
	ldrh r0, [r1, #0x5a]
	mov r5, r10
	mov r8, r10
	eor r0, r2, r0
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r11, #0x16
	mov r4, #2
_020F9220:
	mov r6, r4, lsl r5
	ands r0, r7, r6
	beq _020F9274
	ldr r0, _020F9360 // =0x02151D18
	mov r1, r9
	ldr r2, [r0, #4]
	ldr r0, _020F9374 // =0x0000035E
	add r0, r2, r0
	add r0, r0, r8
	mov r2, r11
	bl MIi_CpuCopy16
	ldr r0, _020F9360 // =0x02151D18
	add r10, r10, #1
	ldr r0, [r0, #4]
	add r9, r9, #0x16
	add r0, r0, #0x400
	ldrh r1, [r0, #0xb0]
	cmp r10, #4
	orr r1, r1, r6
	strh r1, [r0, #0xb0]
	beq _020F9284
_020F9274:
	add r5, r5, #1
	cmp r5, #0xf
	add r8, r8, #0x16
	blt _020F9220
_020F9284:
	cmp r10, #4
	bhs _020F92A4
	mov r0, #0x16
	mul r1, r10, r0
	ldr r2, _020F9370 // =0x02151D50
	ldrb r0, [r2, r1]
	bic r0, r0, #0xf0
	strb r0, [r2, r1]
_020F92A4:
	ldr r2, _020F9364 // =0x02151D40
	mov r3, #0
	ldr r0, _020F9378 // =0x02151D48
	mov r1, #0x68
	strh r3, [r2, #8]
	bl MBi_calc_cksum
	ldr r2, _020F9360 // =0x02151D18
	ldr r1, _020F9364 // =0x02151D40
	ldr r3, [r2, #4]
	strh r0, [r1, #8]
	add r0, r3, #0x400
	add r1, r3, #0x300
	ldrh r3, [r0, #0xb0]
	ldrh r0, [r1, #0x5a]
	ldr r1, _020F9364 // =0x02151D40
	cmp r3, r0
	moveq r0, #1
	streqb r0, [r2, #0xc]
	ldr r0, [sp, #0x10]
	ldr r3, [sp, #8]
	orr r2, r0, #3
	ldr r0, [sp, #0xc]
	and r4, r2, #0xff
	str r0, [sp]
	mov r0, #0
	mov r2, #0x70
	str r4, [sp, #4]
	bl WM_SetGameInfo
	ldr r0, _020F9368 // =0x02151D10
	ldr r0, [r0, #0]
	cmp r0, #1
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	ldr r0, _020F936C // =0x02151D14
	ldr r1, [r0, #0]
	cmp r1, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldr r0, _020F9360 // =0x02151D18
	ldr r0, [r0, #4]
	ldr r0, [r0, #0x4b8]
	blx r1
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F9360: .word 0x02151D18
_020F9364: .word 0x02151D40
_020F9368: .word 0x02151D10
_020F936C: .word 0x02151D14
_020F9370: .word 0x02151D50
_020F9374: .word 0x0000035E
_020F9378: .word 0x02151D48
	arm_func_end MBi_SendVolatBeacon

	arm_func_start MBi_InitSendVolatBeacon
MBi_InitSendVolatBeacon: // 0x020F937C
	ldr r1, _020F93A8 // =0x02151D18
	mov r3, #1
	ldr r0, [r1, #4]
	mov r2, #5
	add r0, r0, #0x400
	strh r3, [r0, #0xb0]
	ldr r0, [r1, #4]
	ldrb r0, [r0, #0x4b4]
	strb r0, [r1, #0xe]
	strb r2, [r1, #0xc]
	bx lr
	.align 2, 0
_020F93A8: .word 0x02151D18
	arm_func_end MBi_InitSendVolatBeacon

	arm_func_start MBi_SendFixedBeacon
MBi_SendFixedBeacon: // 0x020F93AC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r3, _020F9514 // =0x02151D18
	mov r6, r0
	ldr r0, [r3, #4]
	ldr r3, [r3, #8]
	add r7, r0, #0x358
	add r0, r3, #0x62
	cmp r0, r7
	mov r5, r1
	ldrls r0, _020F9518 // =0x02151D40
	movls r1, #0x62
	mov r4, r2
	strlsb r1, [r0, #0xc]
	bls _020F940C
	ldr r0, _020F9518 // =0x02151D40
	sub r1, r7, r3
	strb r1, [r0, #0xc]
	ldrb r2, [r0, #0xc]
	ldr r1, _020F951C // =0x02151D4E
	mov r0, #0
	add r1, r1, r2
	rsb r2, r2, #0x62
	bl MIi_CpuClear16
_020F940C:
	ldr r0, _020F9518 // =0x02151D40
	ldr r1, _020F9514 // =0x02151D18
	ldrb r2, [r0, #0xc]
	ldr r0, [r1, #8]
	ldr r1, _020F951C // =0x02151D4E
	bl MIi_CpuCopy16
	ldr r3, _020F9514 // =0x02151D18
	ldr r2, _020F9518 // =0x02151D40
	ldrb r8, [r3, #0xf]
	ldrb r1, [r3, #0x10]
	ldrb r7, [r2, #4]
	strb r8, [r2, #0xa]
	ldr r0, [r3, #4]
	strb r1, [r2, #0xb]
	ldrb r1, [r0, #0x4b2]
	bic r7, r7, #3
	ldrb r8, [r3, #0xe]
	and r1, r1, #3
	orr r1, r7, r1
	strb r1, [r2, #4]
	ldrb ip, [r0, #0x4b3]
	ldrb r1, [r2, #4]
	ldrb r7, [r3, #0x11]
	strb ip, [r2, #5]
	strb r8, [r2, #6]
	ldr r8, [r0, #0x4b8]
	bic r1, r1, #0xfc
	str r8, [r2]
	ldrb r0, [r0, #0x4b5]
	add lr, r7, #1
	mov ip, #0
	and r0, r0, #0x3f
	orr r8, r1, r0, lsl #2
	ldr r0, _020F9520 // =0x02151D48
	mov r1, #0x68
	strb r8, [r2, #4]
	strb lr, [r3, #0x11]
	strb r7, [r2, #7]
	strh ip, [r2, #8]
	bl MBi_calc_cksum
	ldr r1, _020F9514 // =0x02151D18
	ldr r2, _020F9518 // =0x02151D40
	ldrb ip, [r1, #0xf]
	strh r0, [r2, #8]
	ldrb r3, [r1, #0x10]
	add r0, ip, #1
	strb r0, [r1, #0xf]
	ldrb r0, [r1, #0xf]
	mov r2, #0x70
	cmp r0, r3
	ldrlo r0, [r1, #8]
	mov r3, r6
	addlo r0, r0, #0x62
	strlo r0, [r1, #8]
	movhs r0, #4
	strhsb r0, [r1, #0xc]
	orr r0, r4, #3
	and r4, r0, #0xff
	str r5, [sp]
	ldr r1, _020F9518 // =0x02151D40
	mov r0, #0
	str r4, [sp, #4]
	bl WM_SetGameInfo
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020F9514: .word 0x02151D18
_020F9518: .word 0x02151D40
_020F951C: .word 0x02151D4E
_020F9520: .word 0x02151D48
	arm_func_end MBi_SendFixedBeacon

	arm_func_start MBi_InitSendFixedBeacon
MBi_InitSendFixedBeacon: // 0x020F9524
	ldr r0, _020F956C // =0x02151D18
	ldrb r1, [r0, #0xc]
	cmp r1, #2
	bxne lr
	ldr r2, [r0, #4]
	ldrb r1, [r2, #0x4b2]
	cmp r1, #0
	moveq r1, #9
	streqb r1, [r0, #0x10]
	streq r2, [r0, #8]
	addne r1, r2, #0x220
	movne r2, #4
	strne r1, [r0, #8]
	strneb r2, [r0, #0x10]
	ldr r0, _020F956C // =0x02151D18
	mov r1, #3
	strb r1, [r0, #0xc]
	bx lr
	.align 2, 0
_020F956C: .word 0x02151D18
	arm_func_end MBi_InitSendFixedBeacon

	arm_func_start MBi_ReadyBeaconSendStatus
MBi_ReadyBeaconSendStatus: // 0x020F9570
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r0, _020F9614 // =0x02151D18
	ldr r1, [r0, #0]
	cmp r1, #0
	bne _020F95C4
	bl MBi_GetGgid
	mov r4, r0
	bl MBi_GetTgid
	str r0, [sp]
	mov ip, #8
	ldr r1, _020F9618 // =0x02151D40
	mov r3, r4
	mov r0, #0
	mov r2, #0x70
	str ip, [sp, #4]
	bl WM_SetGameInfo
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_020F95C4:
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _020F95E0
	ldr r0, [r0, #0x4bc]
	cmp r0, #0
	beq _020F95E0
	mov r1, r0
_020F95E0:
	ldr r0, _020F9614 // =0x02151D18
	str r1, [r0, #4]
	bl MBi_ClearSendStatus
	ldr r1, _020F9614 // =0x02151D18
	mov r2, #2
	ldr r3, [r1, #4]
	mov r0, #1
	ldrb r3, [r3, #0x4b4]
	strb r3, [r1, #0xe]
	strb r2, [r1, #0xc]
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F9614: .word 0x02151D18
_020F9618: .word 0x02151D40
	arm_func_end MBi_ReadyBeaconSendStatus

	arm_func_start MB_SendGameInfoBeacon
MB_SendGameInfoBeacon: // 0x020F961C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	ldr r4, _020F96C0 // =0x02151D18
_020F9634:
	ldrb r0, [r4, #0xc]
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _020F9634
_020F9644: // jump table
	b _020F9660 // case 0
	b _020F9660 // case 1
	b _020F9678 // case 2
	b _020F9680 // case 3
	b _020F969C // case 4
	b _020F96A4 // case 5
	b _020F9634 // case 6
_020F9660:
	bl MBi_ReadyBeaconSendStatus
	cmp r0, #0
	bne _020F9634
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F9678:
	bl MBi_InitSendFixedBeacon
	b _020F9634
_020F9680:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl MBi_SendFixedBeacon
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F969C:
	bl MBi_InitSendVolatBeacon
	b _020F9634
_020F96A4:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl MBi_SendVolatBeacon
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F96C0: .word 0x02151D18
	arm_func_end MB_SendGameInfoBeacon

	arm_func_start MBi_ClearSendStatus
MBi_ClearSendStatus: // 0x020F96C4
	ldr r0, _020F96E4 // =0x02151D18
	mov r1, #0
	strb r1, [r0, #0xd]
	strb r1, [r0, #0xe]
	strb r1, [r0, #0xf]
	strb r1, [r0, #0x10]
	strb r1, [r0, #0x11]
	bx lr
	.align 2, 0
_020F96E4: .word 0x02151D18
	arm_func_end MBi_ClearSendStatus

	arm_func_start MB_InitSendGameInfoStatus
MB_InitSendGameInfoStatus: // 0x020F96E8
	ldr r1, _020F9710 // =0x02151D18
	mov r3, #0
	ldr r0, _020F9714 // =0x02151D14
	mov r2, #1
	ldr ip, _020F9718 // =MBi_ClearSendStatus
	str r3, [r1]
	str r3, [r1, #4]
	strb r2, [r1, #0xc]
	str r3, [r0]
	bx ip
	.align 2, 0
_020F9710: .word 0x02151D18
_020F9714: .word 0x02151D14
_020F9718: .word MBi_ClearSendStatus
	arm_func_end MB_InitSendGameInfoStatus

	arm_func_start sub_20F971C
sub_20F971C: // 0x020F971C
	ldr r1, _020F975C // =0x02151D18
	ldr r2, [r1, #0]
	cmp r2, #0
	streq r0, [r1]
	beq _020F9750
	ldr r1, [r2, #0x4bc]
	cmp r1, #0
	beq _020F974C
_020F973C:
	mov r2, r1
	ldr r1, [r1, #0x4bc]
	cmp r1, #0
	bne _020F973C
_020F974C:
	str r0, [r2, #0x4bc]
_020F9750:
	mov r1, #0
	str r1, [r0, #0x4bc]
	bx lr
	.align 2, 0
_020F975C: .word 0x02151D18
	arm_func_end sub_20F971C

	arm_func_start sub_20F9760
sub_20F9760: // 0x020F9760
	ldrh r1, [r0], #2
	mov r2, #0
	cmp r1, #0
	beq _020F9780
_020F9770:
	ldrh r1, [r0], #2
	add r2, r2, #1
	cmp r1, #0
	bne _020F9770
_020F9780:
	mov r0, r2
	bx lr
	arm_func_end sub_20F9760

	arm_func_start MB_UpdateGameInfoMember
MB_UpdateGameInfoMember: // 0x020F9788
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r4, _020F9804 // =0x0000035E
	mov r6, r0
	mov r5, r2
	mov r0, r1
	ldr r2, _020F9808 // =0x0000014A
	add r1, r6, r4
	mov r4, r3
	mov r7, #1
	bl MIi_CpuCopy16
	mov r2, #0
	mov r1, #2
_020F97BC:
	mov r0, r1, lsl r2
	ands r0, r5, r0
	addne r0, r7, #1
	add r2, r2, #1
	andne r7, r0, #0xff
	cmp r2, #0xf
	blt _020F97BC
	strb r7, [r6, #0x358]
	orr r1, r5, #1
	add r0, r6, #0x300
	strh r1, [r0, #0x5a]
	strh r4, [r0, #0x5c]
	ldrb r0, [r6, #0x4b4]
	add r0, r0, #1
	strb r0, [r6, #0x4b4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F9804: .word 0x0000035E
_020F9808: .word 0x0000014A
	arm_func_end MB_UpdateGameInfoMember

	arm_func_start sub_20F980C
sub_20F980C: // 0x020F980C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x48
	cmp r2, #0
	movne r4, #0x200
	moveq r4, #0x20
	mov r6, r0
	mov r5, r1
	cmp r2, #0
	addne r5, r5, #0x20
	cmp r6, #0
	addeq sp, sp, #0x48
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	add r0, sp, #0
	bl FS_InitFile
	add r0, sp, #0
	mov r1, r6
	bl FS_OpenFile
	cmp r0, #0
	addeq sp, sp, #0x48
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r1, [sp, #0x28]
	ldr r0, [sp, #0x24]
	sub r0, r1, r0
	cmp r4, r0
	beq _020F9898
	add r0, sp, #0
	bl FS_CloseFile
	add sp, sp, #0x48
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020F9898:
	add r0, sp, #0
	mov r1, r5
	mov r2, r4
	bl FS_ReadFile
	add r0, sp, #0
	bl FS_CloseFile
	mov r0, #1
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20F980C

	arm_func_start sub_20F98C0
sub_20F98C0: // 0x020F98C0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r1, r6
	mov r0, #0
	mov r2, #0x4c0
	bl MIi_CpuClear16
	mov r0, #0
	strb r0, [r6, #0x4b2]
	ldr r0, [r5, #0xc]
	mov r1, r6
	mov r2, #1
	bl sub_20F980C
	cmp r0, #0
	moveq r7, #1
	ldr r0, [r5, #0x10]
	mov r1, r6
	mov r2, #0
	movne r7, #0
	bl sub_20F980C
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	orrs r0, r7, r0
	beq _020F9944
	mov r3, #1
	mov r1, r6
	mov r0, #0
	mov r2, #0x220
	strb r3, [r6, #0x4b2]
	bl MIi_CpuClearFast
_020F9944:
	ldr r0, [r5, #0x14]
	cmp r4, #0
	str r0, [r6, #0x4b8]
	beq _020F9964
	mov r0, r4
	add r1, r6, #0x220
	mov r2, #0x16
	bl MIi_CpuCopy16
_020F9964:
	ldrb r0, [r5, #0x18]
	strb r0, [r6, #0x236]
	ldr r0, [r5, #4]
	bl sub_20F9760
	mov r2, r0, lsl #0x11
	ldr r0, [r5, #4]
	add r1, r6, #0x238
	mov r2, r2, lsr #0x10
	bl MIi_CpuCopy16
	ldr r0, [r5, #8]
	add r1, r6, #0x298
	mov r2, #0xc0
	bl MIi_CpuCopy16
	mov r1, #1
	strb r1, [r6, #0x358]
	add r0, r6, #0x300
	strh r1, [r0, #0x5a]
	add r0, r6, #0x400
	strh r1, [r0, #0xb0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20F98C0

	arm_func_start MBi_CheckWmErrcode
MBi_CheckWmErrcode: // 0x020F99BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #2
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r2, _020F9A10 // =0x02151DB8
	strh r0, [sp]
	ldr r0, [r2, #0]
	strh r1, [sp, #2]
	ldr r2, [r0, #0x51c]
	add r1, sp, #0
	mov r0, #0xff
	blx r2
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F9A10: .word 0x02151DB8
	arm_func_end MBi_CheckWmErrcode

	arm_func_start MBi_IsStarted
MBi_IsStarted: // 0x020F9A14
	ldr r0, _020F9A30 // =0x02151DB8
	ldr r0, [r0, #0]
	ldrb r0, [r0, #0x50d]
	cmp r0, #1
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_020F9A30: .word 0x02151DB8
	arm_func_end MBi_IsStarted

	arm_func_start MBi_GetAttribute
MBi_GetAttribute: // 0x020F9A34
	ldr r0, _020F9A90 // =0x02151DB8
	ldr r1, [r0, #0]
	ldrh r0, [r1, #0x12]
	cmp r0, #0
	ldrh r0, [r1, #0xe]
	movne r2, #2
	moveq r2, #0
	cmp r0, #0
	movne r3, #1
	ldrh r0, [r1, #0x14]
	moveq r3, #0
	cmp r0, #0
	movne ip, #4
	ldrh r0, [r1, #0x16]
	moveq ip, #0
	cmp r0, #0
	movne r1, #8
	orr r0, r3, r2
	moveq r1, #0
	orr r0, ip, r0
	orr r0, r1, r0
	and r0, r0, #0xff
	bx lr
	.align 2, 0
_020F9A90: .word 0x02151DB8
	arm_func_end MBi_GetAttribute

	arm_func_start MBi_GetTgid
MBi_GetTgid: // 0x020F9A94
	ldr r0, _020F9AA4 // =0x02151DB8
	ldr r0, [r0, #0]
	ldrh r0, [r0, #0xc]
	bx lr
	.align 2, 0
_020F9AA4: .word 0x02151DB8
	arm_func_end MBi_GetTgid

	arm_func_start MBi_GetGgid
MBi_GetGgid: // 0x020F9AA8
	ldr r0, _020F9AB8 // =0x02151DB8
	ldr r0, [r0, #0]
	ldr r0, [r0, #8]
	bx lr
	.align 2, 0
_020F9AB8: .word 0x02151DB8
	arm_func_end MBi_GetGgid

	arm_func_start MBi_SendMP
MBi_SendMP: // 0x020F9ABC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr ip, _020F9BB8 // =0x02151DB8
	mov r3, r1, lsl #0x10
	ldr r5, [ip]
	mov ip, r2, lsl #0x10
	add lr, r5, #0x500
	ldrh r4, [lr, #0x28]
	mov r1, r0
	mov r2, r3, lsr #0x10
	cmp r4, #0
	mov r4, ip, lsr #0x10
	beq _020F9AFC
	ldrh r0, [lr, #0x26]
	cmp r0, #1
	bne _020F9B0C
_020F9AFC:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F9B0C:
	ldrh r0, [lr, #0x24]
	cmp r0, #1
	beq _020F9B24
	cmp r0, #2
	beq _020F9B70
	b _020F9BA8
_020F9B24:
	ldrh r0, [lr, #0x2c]
	cmp r0, #0
	moveq r0, #0x3e8
	movne r0, #0
	mov r3, r0, lsl #0x10
	str r4, [sp]
	ldr r0, [r5, #0x508]
	mov r3, r3, lsr #0x10
	bl MBi_SetMPData
	cmp r0, #2
	ldreq r1, _020F9BB8 // =0x02151DB8
	moveq r2, #1
	ldreq r1, [r1, #0]
	add sp, sp, #4
	streqb r2, [r1, #0x50c]
	cmp r0, #2
	moveq r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F9B70:
	ldr r0, _020F9BBC // =MBi_ChildCallback
	mov r3, #0
	str r4, [sp]
	bl MBi_SetMPData
	cmp r0, #2
	ldreq r1, _020F9BB8 // =0x02151DB8
	moveq r2, #1
	ldreq r1, [r1, #0]
	add sp, sp, #4
	streqb r2, [r1, #0x50c]
	cmp r0, #2
	moveq r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020F9BA8:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F9BB8: .word 0x02151DB8
_020F9BBC: .word MBi_ChildCallback
	arm_func_end MBi_SendMP

	arm_func_start MBi_SetMPData
MBi_SetMPData: // 0x020F9BC0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	ldrh r4, [sp, #0x18]
	mov r3, r2
	mov r2, r1
	str r4, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #3
	mov r1, #0
	str r4, [sp, #8]
	bl WM_SetMPDataToPort
	mov r4, r0
	mov r1, r4
	mov r0, #0xf
	bl MBi_CheckWmErrcode
	mov r0, r4
	add sp, sp, #0x10
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end MBi_SetMPData

	arm_func_start MBi_SetMaxScanTime
MBi_SetMaxScanTime: // 0x020F9C10
	ldr r1, _020F9C1C // =0x02151DC0
	strh r0, [r1, #6]
	bx lr
	.align 2, 0
_020F9C1C: .word 0x02151DC0
	arm_func_end MBi_SetMaxScanTime

	arm_func_start MB_DisconnectChild
MB_DisconnectChild: // 0x020F9C20
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _020F9DBC // =MBi_ParentCallback
	mov r1, r5
	bl WM_Disconnect
	cmp r5, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	cmp r5, #0x10
	addhs sp, sp, #4
	ldmhsia sp!, {r4, r5, r6, r7, lr}
	bxhs lr
	ldr r2, _020F9DC0 // =0x2151DBC
	sub r4, r5, #1
	ldr r0, [r2, #0]
	mov r1, #0
	add r0, r0, r4, lsl #1
	add r0, r0, #0x1400
	strh r1, [r0, #0x8a]
	ldr r3, [r2, #0]
	ldr r0, _020F9DC4 // =0x000014A8
	mov r2, #4
	add r0, r3, r0
	add r0, r0, r4, lsl #2
	bl MI_CpuFill8
	ldr r0, _020F9DC0 // =0x2151DBC
	mov r2, #0x16
	ldr r0, [r0, #0]
	mov r1, #0
	add r0, r0, #0x1340
	mla r0, r4, r2, r0
	bl MI_CpuFill8
	mov r0, r5
	bl MBi_ClearParentPieceBuffer
	ldr lr, _020F9DC0 // =0x2151DBC
	mov r2, #0
	ldr r1, [lr]
	mvn r0, #0
	add r1, r1, r4, lsl #1
	add r1, r1, #0x1700
	strh r2, [r1, #0x54]
	ldr r3, [lr]
	add r1, r3, r4
	add r1, r1, #0x1500
	ldrsb r2, [r1, #0x26]
	cmp r2, r0
	beq _020F9D50
	ldr r1, _020F9DC8 // =0x000005D4
	and r2, r2, #0xff
	mul r1, r2, r1
	add r2, r3, r1
	add ip, r2, #0x1d00
	mov r3, #1
	ldrh r6, [ip, #0x4e]
	mvn r2, r3, lsl r5
	and r6, r6, r2
	strh r6, [ip, #0x4e]
	ldr r7, [lr]
	mov r6, r4
	add r7, r7, r1
	add ip, r7, #0x1d00
	ldrh r7, [ip, #0x50]
	orr r3, r7, r3, lsl r5
	strh r3, [ip, #0x50]
	ldr r3, [lr]
	add r3, r3, r6
	add r3, r3, #0x1000
	strb r0, [r3, #0x526]
	ldr r0, [lr]
	add r0, r0, r1
	add r0, r0, #0x1d00
	ldrh r1, [r0, #0x4c]
	and r1, r1, r2
	strh r1, [r0, #0x4c]
_020F9D50:
	ldr r1, _020F9DC0 // =0x2151DBC
	mov r0, #1
	ldr r2, [r1, #0]
	mov r5, r0, lsl r5
	add r0, r2, #0x1500
	ldrh r0, [r0, #0x36]
	ands r0, r0, r5
	beq _020F9D98
	add r0, r2, #0x1000
	ldrb r3, [r0, #0x535]
	mvn r2, r5
	sub r3, r3, #1
	strb r3, [r0, #0x535]
	ldr r0, [r1, #0]
	add r0, r0, #0x1500
	ldrh r1, [r0, #0x36]
	and r1, r1, r2
	strh r1, [r0, #0x36]
_020F9D98:
	ldr r0, _020F9DC0 // =0x2151DBC
	mov r1, #0
	ldr r0, [r0, #0]
	add r0, r0, r4, lsl #2
	add r0, r0, #0x1000
	str r1, [r0, #0x4e8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F9DBC: .word MBi_ParentCallback
_020F9DC0: .word 0x2151DBC
_020F9DC4: .word 0x000014A8
_020F9DC8: .word 0x000005D4
	arm_func_end MB_DisconnectChild

	arm_func_start MB_EndToIdle
MB_EndToIdle: // 0x020F9DCC
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020F9E08 // =0x2151DBC
	mov r4, r0
	ldr r0, [r1, #0]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x320]
	cmp r0, #0
	bne _020F9DF4
	bl OS_Terminate
_020F9DF4:
	bl MBi_CommEnd
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F9E08: .word 0x2151DBC
	arm_func_end MB_EndToIdle

	arm_func_start MB_End
MB_End: // 0x020F9E0C
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020F9E48 // =0x2151DBC
	mov r4, r0
	ldr r0, [r1, #0]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x320]
	cmp r0, #0
	beq _020F9E34
	bl OS_Terminate
_020F9E34:
	bl MBi_CommEnd
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F9E48: .word 0x2151DBC
	arm_func_end MB_End

	arm_func_start MBi_CommEnd
MBi_CommEnd: // 0x020F9E4C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, #1
	bl OS_DisableInterrupts
	ldr r1, _020F9ECC // =0x02151DB8
	mov r4, r0
	ldr r2, [r1, #0]
	add r0, r2, #0x500
	ldrh r0, [r0, #0x26]
	cmp r0, #0
	bne _020F9EB4
	mov r0, #0
	str r0, [r2, #0x5e4]
	ldr r0, [r1, #0]
	mov r1, r5
	add r0, r0, #0x500
	strh r1, [r0, #0x26]
	bl MBi_IsTaskAvailable
	cmp r0, #0
	beq _020F9EAC
	ldr r0, _020F9ED0 // =MBi_OnReset
	bl MBi_EndTaskThread
	mov r5, #0
	b _020F9EB4
_020F9EAC:
	bl MBi_CallReset
	mov r5, r0
_020F9EB4:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F9ECC: .word 0x02151DB8
_020F9ED0: .word MBi_OnReset
	arm_func_end MBi_CommEnd

	arm_func_start MBi_OnReset
MBi_OnReset: // 0x020F9ED4
	ldr ip, _020F9EDC // =MBi_CallReset
	bx ip
	.align 2, 0
_020F9EDC: .word MBi_CallReset
	arm_func_end MBi_OnReset

	arm_func_start MBi_CallReset
MBi_CallReset: // 0x020F9EE0
	stmdb sp!, {r4, lr}
	ldr r0, _020F9F18 // =0x02151DB8
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x508]
	bl WM_Reset
	mov r4, r0
	mov r1, r4
	mov r0, #1
	bl MBi_CheckWmErrcode
	cmp r4, #2
	moveq r4, #0
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F9F18: .word 0x02151DB8
	arm_func_end MBi_CallReset

	arm_func_start MB_StartParentFromIdle
MB_StartParentFromIdle: // 0x020F9F1C
	ldr r1, _020F9F38 // =0x2151DBC
	ldr ip, _020F9F3C // =sub_20F9F64
	ldr r1, [r1, #0]
	mov r2, #1
	add r1, r1, #0x1000
	str r2, [r1, #0x320]
	bx ip
	.align 2, 0
_020F9F38: .word 0x2151DBC
_020F9F3C: .word sub_20F9F64
	arm_func_end MB_StartParentFromIdle

	arm_func_start MB_StartParent
MB_StartParent: // 0x020F9F40
	ldr r1, _020F9F5C // =0x2151DBC
	ldr ip, _020F9F60 // =sub_20F9F64
	ldr r1, [r1, #0]
	mov r2, #0
	add r1, r1, #0x1000
	str r2, [r1, #0x320]
	bx ip
	.align 2, 0
_020F9F5C: .word 0x2151DBC
_020F9F60: .word sub_20F9F64
	arm_func_end MB_StartParent

	arm_func_start sub_20F9F64
sub_20F9F64: // 0x020F9F64
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _020FA14C // =0x02151DB8
	ldr r2, _020FA150 // =0x2151DBC
	ldr r3, [r1, #0]
	ldr r1, _020FA154 // =0x00007D1F
	strh r4, [r3, #0x32]
	ldr r3, [r2, #0]
	ldr r2, _020FA158 // =0x02151DB4
	add r1, r3, r1
	bic r1, r1, #0x1f
	mov r4, r0
	str r1, [r2]
	add r0, r3, #0x1000
	ldr r5, [r0, #0x4e4]
	ldr r2, _020FA15C // =0x000069C0
	add r1, r3, #0x1340
	mov r0, #0
	bl MIi_CpuClear16
	mov r0, r5
	bl MB_CommSetParentStateCallback
	ldr r1, _020FA14C // =0x02151DB8
	ldr r0, _020FA150 // =0x2151DBC
	ldr r3, [r1, #0]
	ldr r2, [r0, #0]
	add r0, r3, #0x500
	ldrh r3, [r0, #0]
	add r0, r2, #0x1000
	sub r2, r3, #6
	str r2, [r0, #0x318]
	ldr r0, [r1, #0]
	add r0, r0, #0x500
	ldrh r0, [r0, #2]
	bl MBi_SetChildMPMaxSize
	ldr r1, _020FA150 // =0x2151DBC
	ldr r0, _020FA160 // =0x00001538
	ldr r1, [r1, #0]
	add r0, r1, r0
	bl MBi_SetParentPieceBuffer
	mov r5, #0
	ldr r2, _020FA150 // =0x2151DBC
	mov r0, r5
	mvn r3, #0
_020FA018:
	ldr r1, [r2, #0]
	add r1, r1, r5, lsl #2
	add r1, r1, #0x1000
	str r0, [r1, #0x4e8]
	ldr r1, [r2, #0]
	add r1, r1, r5
	add r1, r1, #0x1000
	add r5, r5, #1
	strb r3, [r1, #0x526]
	cmp r5, #0xf
	blt _020FA018
	ldr r1, [r2, #0]
	ldr r3, _020FA164 // =0x00001788
	add r1, r1, #0x1000
	strb r0, [r1, #0x524]
	ldr r1, [r2, #0]
	ldr r2, _020FA168 // =0x00005D40
	add r1, r1, r3
	bl MIi_CpuClear16
	ldr r1, _020FA150 // =0x2151DBC
	ldr r0, _020FA16C // =0x00001754
	ldr r2, [r1, #0]
	mov r1, #0
	add r0, r2, r0
	mov r2, #0x1e
	bl MI_CpuFill8
	ldr r2, _020FA14C // =0x02151DB8
	mov r3, #1
	ldr r0, [r2, #0]
	ldr r1, _020FA170 // =MBi_CommParentCallback
	add r0, r0, #0x500
	strh r3, [r0, #0x24]
	ldr r0, [r2, #0]
	ldr r3, _020FA174 // =MBi_ParentCallback
	str r1, [r0, #0x51c]
	ldr r0, [r2, #0]
	mov r1, #0xf
	str r3, [r0, #0x508]
	ldr r3, [r2, #0]
	add r0, r3, #0x500
	ldrh r0, [r0, #0]
	strh r0, [r3, #0x34]
	ldr r0, [r2, #0]
	ldrh r3, [r0, #0x34]
	add r0, r0, #0x500
	add r3, r3, #0x23
	bic r3, r3, #0x1f
	strh r3, [r0, #0x18]
	ldr r3, [r2, #0]
	add r0, r3, #0x500
	ldrh r0, [r0, #2]
	strh r0, [r3, #0x36]
	ldr r0, [r2, #0]
	ldrh r2, [r0, #0x36]
	add r0, r0, #0x500
	add r2, r2, #0xe
	mul r1, r2, r1
	add r1, r1, #0x29
	bic r1, r1, #0x1f
	mov r1, r1, lsl #1
	strh r1, [r0, #0x1a]
	bl MB_InitSendGameInfoStatus
	bl MBi_StartCommon
	mov r5, r0
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0xf
	mov r1, #1
	bl PXI_IsCallbackReady
	ldr r1, _020FA150 // =0x2151DBC
	ldr r1, [r1, #0]
	add r1, r1, #0x7000
	str r0, [r1, #0x4c8]
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020FA14C: .word 0x02151DB8
_020FA150: .word 0x2151DBC
_020FA154: .word 0x00007D1F
_020FA158: .word 0x02151DB4
_020FA15C: .word 0x000069C0
_020FA160: .word 0x00001538
_020FA164: .word 0x00001788
_020FA168: .word 0x00005D40
_020FA16C: .word 0x00001754
_020FA170: .word MBi_CommParentCallback
_020FA174: .word MBi_ParentCallback
	arm_func_end sub_20F9F64

	arm_func_start MBi_StartCommon
MBi_StartCommon: // 0x020FA178
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _020FA268 // =0x02151DB8
	mov r3, #0
	ldr r1, [r2, #0]
	mov r0, #0xa
	add r1, r1, #0x500
	strh r3, [r1, #0x28]
	ldr r1, [r2, #0]
	add r1, r1, #0x500
	strh r3, [r1, #0x2a]
	ldr r1, [r2, #0]
	add r1, r1, #0x500
	strh r3, [r1, #0x26]
	ldr r1, [r2, #0]
	add r1, r1, #0x500
	strh r3, [r1, #0x48]
	bl MBi_SetMaxScanTime
	ldr r0, _020FA26C // =0x2151DBC
	ldr r0, [r0, #0]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x320]
	cmp r0, #0
	bne _020FA238
	ldr r6, _020FA270 // =0x02151DB4
	ldr r5, _020FA268 // =0x02151DB8
	ldr r4, _020FA274 // =0x02151DB0
_020FA1E0:
	ldr r1, [r5, #0]
	ldrh r2, [r4, #0]
	ldr r0, [r6, #0]
	ldr r1, [r1, #0x508]
	bl WM_Initialize
	cmp r0, #4
	beq _020FA1E0
	cmp r0, #2
	movne r0, #8
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	ldr r0, _020FA268 // =0x02151DB8
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x508]
	bl WM_SetIndCallback
	ldr r0, _020FA268 // =0x02151DB8
	mov r2, #1
	ldr r1, [r0, #0]
	mov r0, #0
	strb r2, [r1, #0x50d]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020FA238:
	ldr r0, _020FA268 // =0x02151DB8
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x508]
	bl WM_SetIndCallback
	ldr r0, _020FA268 // =0x02151DB8
	mov r1, #1
	ldr r0, [r0, #0]
	strb r1, [r0, #0x50d]
	bl MBi_OnInitializeDone
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020FA268: .word 0x02151DB8
_020FA26C: .word 0x2151DBC
_020FA270: .word 0x02151DB4
_020FA274: .word 0x02151DB0
	arm_func_end MBi_StartCommon

	arm_func_start MB_SetParentCommParam
MB_SetParentCommParam: // 0x020FA278
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	bl OS_DisableInterrupts
	ldr r1, _020FA318 // =0x02151DB8
	mov r6, r0
	ldr r1, [r1, #0]
	ldrb r1, [r1, #0x50d]
	cmp r1, #0
	beq _020FA2B0
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020FA2B0:
	mov r0, r5
	mov r2, r4
	mov r1, #8
	bl MBi_IsCommSizeValid
	cmp r0, #0
	bne _020FA2DC
	mov r0, r6
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020FA2DC:
	ldr r2, _020FA318 // =0x02151DB8
	mov r0, r6
	ldr r1, [r2, #0]
	mov r3, #8
	strh r4, [r1, #0x10]
	ldr r1, [r2, #0]
	add r1, r1, #0x500
	strh r5, [r1]
	ldr r1, [r2, #0]
	add r1, r1, #0x500
	strh r3, [r1, #2]
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020FA318: .word 0x02151DB8
	arm_func_end MB_SetParentCommParam

	arm_func_start MBi_IsCommSizeValid
MBi_IsCommSizeValid: // 0x020FA31C
	ldr r3, _020FA380 // =0x000001FE
	cmp r0, r3
	bhi _020FA330
	cmp r0, #0xe4
	bhs _020FA338
_020FA330:
	mov r0, #0
	bx lr
_020FA338:
	cmp r1, #0x10
	bhi _020FA348
	cmp r1, #8
	bhs _020FA350
_020FA348:
	mov r0, #0
	bx lr
_020FA350:
	add r1, r1, #0x20
	mov r3, r1, lsl #2
	ldr r1, _020FA384 // =0x0000014A
	add r0, r0, #0x26
	add r1, r1, r0, lsl #2
	add r0, r3, #0x70
	mla r1, r2, r0, r1
	ldr r0, _020FA388 // =0x000015E0
	cmp r1, r0
	movlt r0, #1
	movge r0, #0
	bx lr
	.align 2, 0
_020FA380: .word 0x000001FE
_020FA384: .word 0x0000014A
_020FA388: .word 0x000015E0
	arm_func_end MBi_IsCommSizeValid

	arm_func_start MB_Init
MB_Init: // 0x020FA38C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r4, _020FA594 // =0x2151DBC
	mov r9, r1
	ldr r1, [r4, #0]
	mov r8, r2
	mov r7, r3
	cmp r1, #0
	beq _020FA3CC
	add r1, r1, #0x1300
	ldrh r1, [r1, #0x16]
	cmp r1, #0
	addne sp, sp, #4
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
_020FA3CC:
	add r1, r0, #0x1f
	ldr r0, _020FA598 // =0x00001E1F
	bic r6, r1, #0x1f
	add r0, r6, r0
	cmp r7, #0x10000
	bic r5, r0, #0x1f
	bne _020FA3F0
	bl WM_GetNextTgid
	mov r7, r0
_020FA3F0:
	bl OS_DisableInterrupts
	ldr ip, _020FA59C // =0x02151DB8
	ldr r3, _020FA594 // =0x2151DBC
	mov r4, r0
	ldr r1, [sp, #0x20]
	ldr r0, _020FA5A0 // =0x02151DB0
	ldr r2, _020FA5A4 // =0x0000FFFF
	strh r1, [r0]
	ldr r0, _020FA5A8 // _0211F9E8
	ldr r1, _020FA5AC // _0211F9DC
	strh r2, [r0]
	mov r2, #5
	ldr r0, _020FA5B0 // _0211F9E0
	strh r2, [r1]
	mov r2, #0x28
	ldr r1, _020FA5B4 // _0211F9E4
	strh r2, [r0]
	ldr r0, _020FA5B8 // _0211F9F0
	strh r2, [r1]
	mov r2, #1
	mov r1, r6
	str r2, [r0]
	mov r0, #0
	mov r2, #0x1e00
	str r6, [ip]
	str r5, [r3]
	bl MIi_CpuClear32
	mov r1, r5
	mov r0, #0
	mov r2, #0x1340
	bl MIi_CpuClear16
	ldrb r0, [r9, #1]
	add r1, r6, #0x530
	mov r2, #0
	cmp r0, #0
	ble _020FA49C
_020FA480:
	add r0, r9, r2, lsl #1
	ldrh r0, [r0, #2]
	add r2, r2, #1
	strh r0, [r1], #2
	ldrb r0, [r9, #1]
	cmp r2, r0
	blt _020FA480
_020FA49C:
	ldr r0, _020FA5BC // =0x00000538
	mov r3, #0
	add ip, r6, r0
	ldr r0, _020FA5C0 // _0211F9EC
_020FA4AC:
	ldr r2, [r0, #0]
	ldrh r1, [r2, #0]
	cmp r1, #0
	beq _020FA4D8
	add r1, r2, #2
	str r1, [r0]
	ldrh r1, [r2, #0]
	add r3, r3, #1
	cmp r3, #0x10
	strh r1, [ip], #2
	blt _020FA4AC
_020FA4D8:
	mov r0, r9
	add r1, r5, #0x1300
	mov r2, #0x16
	bl MI_CpuCopy8
	ldrb r0, [r9, #1]
	mov r2, #0
	cmp r0, #0xa
	addlo r0, r5, r0, lsl #1
	addlo r0, r0, #0x1300
	movlo r1, #0
	strloh r1, [r0, #2]
	add r0, r6, #0x500
	mov r1, #0x100
	strh r1, [r0]
	mov r1, #8
	strh r1, [r0, #2]
	strh r2, [r0, #0x18]
	strh r2, [r0, #0x1a]
	mov r1, #1
	strh r1, [r0, #0x2c]
	add r0, r5, #0x400
	str r0, [r6, #0x504]
	strh r2, [r6, #0xe]
	strh r2, [r6, #0x12]
	strh r1, [r6, #0x16]
	strh r2, [r6, #0x14]
	str r8, [r6, #8]
	strh r7, [r6, #0xc]
	bl MBi_GetBeaconPeriodDispersion
	add r0, r0, #0xc8
	strh r0, [r6, #0x18]
	mov r0, #0xf
	strh r0, [r6, #0x10]
	mov r3, #0
	strb r3, [r6, #0x50c]
	strb r3, [r6, #0x50d]
	add r1, r5, #0x1300
	mov r2, #1
	strh r2, [r1, #0x16]
	add r1, r5, #0x1000
	mov r0, r4
	str r3, [r1, #0x31c]
	bl OS_RestoreInterrupts
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020FA594: .word 0x2151DBC
_020FA598: .word 0x00001E1F
_020FA59C: .word 0x02151DB8
_020FA5A0: .word 0x02151DB0
_020FA5A4: .word 0x0000FFFF
_020FA5A8: .word _0211F9E8
_020FA5AC: .word _0211F9DC
_020FA5B0: .word _0211F9E0
_020FA5B4: .word _0211F9E4
_020FA5B8: .word _0211F9F0
_020FA5BC: .word 0x00000538
_020FA5C0: .word _0211F9EC
	arm_func_end MB_Init

	arm_func_start MBi_GetBeaconPeriodDispersion
MBi_GetBeaconPeriodDispersion: // 0x020FA5C4
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	add r0, sp, #0
	bl OS_GetMacAddress
	mov r2, #0
	add r1, sp, #0
	mov r3, r2
_020FA5E0:
	ldrb r0, [r1, #0]
	add r2, r2, #1
	cmp r2, #6
	add r3, r3, r0
	add r1, r1, #1
	blt _020FA5E0
	ldr r1, _020FA630 // =0x027FFC3C
	mov r0, #7
	ldr r2, [r1, #0]
	ldr r1, _020FA634 // =0xCCCCCCCD
	add r2, r3, r2
	mul r3, r2, r0
	umull r1, r0, r3, r1
	ldr r2, _020FA638 // =0x00000014
	mov r0, r0, lsr #4
	umull r0, r1, r2, r0
	sub r0, r3, r0
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020FA630: .word 0x027FFC3C
_020FA634: .word 0xCCCCCCCD
_020FA638: .word 0x00000014
	arm_func_end MBi_GetBeaconPeriodDispersion

	arm_func_start MBi_ChildCallback
MBi_ChildCallback: // 0x020FA63C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x20
	mov r6, r0
	ldrh r0, [r6, #0]
	ldr r1, _020FAEB0 // =0x02151DB8
	cmp r0, #0x1d
	ldr r5, [r1, #0]
	bgt _020FA6C8
	cmp r0, #0x1d
	bge _020FA750
	cmp r0, #0x15
	addls pc, pc, r0, lsl #2
	b _020FAE94
_020FA670: // jump table
	b _020FA6D4 // case 0
	b _020FAD64 // case 1
	b _020FADD0 // case 2
	b _020FAE94 // case 3
	b _020FAE94 // case 4
	b _020FAE94 // case 5
	b _020FAE94 // case 6
	b _020FAE94 // case 7
	b _020FAE94 // case 8
	b _020FAE94 // case 9
	b _020FA7F4 // case 10
	b _020FAA7C // case 11
	b _020FAAD4 // case 12
	b _020FAE94 // case 13
	b _020FAC6C // case 14
	b _020FACF4 // case 15
	b _020FAE94 // case 16
	b _020FAE94 // case 17
	b _020FAE94 // case 18
	b _020FAE94 // case 19
	b _020FAE94 // case 20
	b _020FAE38 // case 21
_020FA6C8:
	cmp r0, #0x80
	beq _020FAE68
	b _020FAE94
_020FA6D4:
	ldrh r0, [r6, #2]
	cmp r0, #0
	beq _020FA6FC
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x100
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FA6FC:
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x15
	blx r2
	ldr r0, _020FAEB4 // _0211F9E4
	ldr r1, _020FAEB8 // _0211F9E8
	ldrh r3, [r0, #0]
	ldr r2, _020FAEBC // _0211F9E0
	ldr r0, _020FAEC0 // _0211F9DC
	str r3, [sp]
	ldrh r3, [r0, #0]
	ldrh r1, [r1, #0]
	ldrh r2, [r2, #0]
	ldr r0, _020FAEC4 // =MBi_ChildCallback
	bl WM_SetLifeTime
	mov r1, r0
	mov r0, #0x1d
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FA750:
	ldrh r0, [r6, #2]
	cmp r0, #0
	beq _020FA778
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x100
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FA778:
	ldr r0, _020FAEC8 // =0x02151DC0
	add r2, r5, #0x440
	ldrh r1, [r0, #4]
	str r2, [r0]
	mov r2, #1
	cmp r1, #0
	moveq r1, #1
	streqh r1, [r0, #4]
	ldr r0, _020FAEC8 // =0x02151DC0
	ldrh r1, [r0, #6]
	cmp r1, #0
	moveq r1, #0xc8
	streqh r1, [r0, #6]
	ldr r1, _020FAEC8 // =0x02151DC0
	mov r0, #0xff
	strb r0, [r1, #8]
	strb r0, [r1, #9]
	strb r0, [r1, #0xa]
	strb r0, [r1, #0xb]
	strb r0, [r1, #0xc]
	strb r0, [r1, #0xd]
	str r2, [r5, #0x5e4]
	ldr r0, _020FAEC4 // =MBi_ChildCallback
	str r2, [r5, #0x5e8]
	bl WM_StartScan
	mov r1, r0
	mov r0, #0xa
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FA7F4:
	ldrh r0, [r6, #2]
	cmp r0, #0
	beq _020FA81C
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x100
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FA81C:
	ldrh r0, [r6, #8]
	cmp r0, #3
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r0, #4
	beq _020FA9F8
	cmp r0, #5
	bne _020FAA60
	add r0, r5, #0x500
	ldrh r0, [r0, #0xe0]
	add r3, r5, #0x600
	mov r4, #0
	cmp r0, #0
	ble _020FA930
	ldrb r1, [r6, #0xa]
	mov r2, r3
_020FA860:
	ldrb r7, [r2, #0xca]
	cmp r1, r7
	bne _020FA920
	ldrb r8, [r6, #0xb]
	ldrb r7, [r2, #0xcb]
	cmp r8, r7
	bne _020FA920
	ldrb r8, [r6, #0xc]
	ldrb r7, [r2, #0xcc]
	cmp r8, r7
	bne _020FA920
	ldrb r8, [r6, #0xd]
	ldrb r7, [r2, #0xcd]
	cmp r8, r7
	bne _020FA920
	ldrb r8, [r6, #0xe]
	ldrb r7, [r2, #0xce]
	cmp r8, r7
	bne _020FA920
	ldrb r8, [r6, #0xf]
	ldrb r7, [r2, #0xcf]
	cmp r8, r7
	bne _020FA920
	mov r0, #0x180
	mul r7, r4, r0
	add r0, r3, r7
	ldrh r1, [r6, #0x36]
	add r8, r6, #0x38
	add lr, r0, #0xf8
	strh r1, [r0, #0xf6]
	mov ip, #8
_020FA8DC:
	ldmia r8!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	subs ip, ip, #1
	bne _020FA8DC
	add r0, r5, #0x600
	add r7, r0, r7
	mov r0, r7
	mov r1, #0xc0
	bl DC_InvalidateRange
	ldr r0, _020FAECC // =0x02151DB0
	mov r2, r7
	ldrh r0, [r0, #0]
	add r1, r5, #0x440
	mov r3, #0xc0
	bl MI_DmaCopy16
	str r4, [r5, #0x5ec]
	b _020FA990
_020FA920:
	add r4, r4, #1
	cmp r4, r0
	add r2, r2, #0x180
	blt _020FA860
_020FA930:
	cmp r4, #0x10
	bge _020FA990
	mov r0, #0x180
	mul r7, r4, r0
	add r1, r3, r7
	mov r0, r6
	add ip, r4, #1
	add r3, r5, #0x500
	add r1, r1, #0xc0
	mov r2, #0xb8
	strh ip, [r3, #0xe0]
	bl MIi_CpuCopy16
	add r0, r5, #0x600
	add r7, r0, r7
	mov r0, r7
	mov r1, #0xc0
	bl DC_InvalidateRange
	ldr r0, _020FAECC // =0x02151DB0
	mov r2, r7
	ldrh r0, [r0, #0]
	add r1, r5, #0x440
	mov r3, #0xc0
	bl MI_DmaCopy16
	str r4, [r5, #0x5ec]
_020FA990:
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #4
	blx r2
	ldr r0, [r5, #0x5e4]
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r0, [r5, #0x5e8]
	cmp r0, #0
	beq _020FA9D4
	ldr r0, _020FAEC8 // =0x02151DC0
	bl changeScanChannel
	cmp r0, #0
	bne _020FA9D4
	bl MBi_CommEnd
_020FA9D4:
	ldr r0, _020FAEC4 // =MBi_ChildCallback
	ldr r1, _020FAEC8 // =0x02151DC0
	bl WM_StartScan
	mov r1, r0
	mov r0, #0xa
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FA9F8:
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #5
	blx r2
	ldr r0, [r5, #0x5e4]
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r0, [r5, #0x5e8]
	cmp r0, #0
	beq _020FAA3C
	ldr r0, _020FAEC8 // =0x02151DC0
	bl changeScanChannel
	cmp r0, #0
	bne _020FAA3C
	bl MBi_CommEnd
_020FAA3C:
	ldr r0, _020FAEC4 // =MBi_ChildCallback
	ldr r1, _020FAEC8 // =0x02151DC0
	bl WM_StartScan
	mov r1, r0
	mov r0, #0xa
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAA60:
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x100
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAA7C:
	ldrh r0, [r6, #2]
	cmp r0, #0
	beq _020FAAA4
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x100
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAAA4:
	mov r2, #0
	str r2, [sp]
	ldr r1, [r5, #0x520]
	ldr r0, _020FAEC4 // =MBi_ChildCallback
	mov r3, #1
	bl WM_StartConnectEx
	mov r1, r0
	mov r0, #0xc
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAAD4:
	ldrh r0, [r6, #2]
	cmp r0, #0
	beq _020FAB08
	add r0, r5, #0x500
	mov r1, #0
	strh r1, [r0, #0xe0]
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0xb
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAB08:
	ldrh r0, [r6, #8]
	cmp r0, #9
	bgt _020FAB38
	cmp r0, #6
	blt _020FAC50
	cmp r0, #6
	beq _020FAB4C
	cmp r0, #7
	beq _020FAB6C
	cmp r0, #9
	beq _020FAC24
	b _020FAC50
_020FAB38:
	cmp r0, #0x1a
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	b _020FAC50
_020FAB4C:
	add r0, r5, #0x500
	mov r1, #0
	strh r1, [r0, #0x2a]
	mov r1, #1
	strh r1, [r0, #0x28]
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAB6C:
	ldrh r2, [r6, #0xa]
	add r0, r5, #0x500
	mov r1, r6
	strh r2, [r0, #0xe2]
	ldr r2, [r5, #0x51c]
	mov r0, #6
	blx r2
	ldr r1, _020FAED0 // =MBi_ChildPortCallback
	add r3, r5, #0x500
	mov r0, #1
	mov r2, #0
	strh r0, [r3, #0x2a]
	bl WM_SetPortCallback
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	add r0, r5, #0x500
	ldrh r0, [r0, #0x2c]
	add r1, r5, #0x500
	ldrh r2, [r1, #0x18]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r2, [sp]
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #0xc]
	str r0, [sp, #0x10]
	mov r0, #1
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	ldrh r2, [r1, #0x1a]
	ldr r1, [r5, #0x504]
	ldr r0, _020FAEC4 // =MBi_ChildCallback
	add r3, r5, #0x40
	bl WM_StartMPEx
	mov r1, r0
	mov r0, #0xe
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAC24:
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0xa
	blx r2
	add r0, r5, #0x500
	mov r1, #0
	strh r1, [r0, #0x2a]
	strh r1, [r0, #0x28]
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAC50:
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x100
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAC6C:
	ldrh r0, [r6, #4]
	cmp r0, #0xa
	beq _020FAC9C
	cmp r0, #0xc
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r0, #0xd
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	b _020FACD8
_020FAC9C:
	add r0, r5, #0x500
	mov r1, #1
	strh r1, [r0, #0x28]
	bl MBi_IsSendEnabled
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r2, [r5, #0x51c]
	mov r0, #0x19
	mov r1, #0
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FACD8:
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x100
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FACF4:
	mov r0, #0
	strb r0, [r5, #0x50c]
	ldrh r0, [r6, #2]
	cmp r0, #0
	bne _020FAD1C
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #8
	blx r2
	b _020FAD48
_020FAD1C:
	cmp r0, #9
	bne _020FAD38
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x29
	blx r2
	b _020FAD48
_020FAD38:
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x12
	blx r2
_020FAD48:
	ldr r2, [r5, #0x51c]
	mov r0, #0x19
	mov r1, #0
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAD64:
	ldrh r0, [r6, #2]
	cmp r0, #0
	beq _020FAD98
	add r0, r5, #0x500
	mov r1, #0
	strh r1, [r0, #0x26]
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x100
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAD98:
	add r0, r5, #0x500
	mov r2, #0
	strh r2, [r0, #0x2a]
	ldr r1, [r1, #0]
	ldr r0, _020FAEC4 // =MBi_ChildCallback
	add r1, r1, #0x500
	strh r2, [r1, #0x28]
	bl WM_End
	mov r1, r0
	mov r0, #2
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FADD0:
	ldrh r0, [r6, #2]
	cmp r0, #0
	beq _020FAE04
	add r0, r5, #0x500
	mov r1, #0
	strh r1, [r0, #0x26]
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x100
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAE04:
	mov r2, #0
	ldr r0, _020FAED4 // =0x2151DBC
	strb r2, [r5, #0x50d]
	ldr r0, [r0, #0]
	mov r1, r6
	add r0, r0, #0x1300
	strh r2, [r0, #0x16]
	ldr r2, [r5, #0x51c]
	mov r0, #0x11
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAE38:
	bl MBi_IsSendEnabled
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r2, [r5, #0x51c]
	mov r0, #0x19
	mov r1, #0
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAE68:
	ldrh r0, [r6, #4]
	cmp r0, #0x16
	beq _020FAE84
	add sp, sp, #0x20
	cmp r0, #0x17
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAE84:
	bl OS_Terminate
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020FAE94:
	ldr r2, [r5, #0x51c]
	mov r1, r6
	mov r0, #0x100
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020FAEB0: .word 0x02151DB8
_020FAEB4: .word _0211F9E4
_020FAEB8: .word _0211F9E8
_020FAEBC: .word _0211F9E0
_020FAEC0: .word _0211F9DC
_020FAEC4: .word MBi_ChildCallback
_020FAEC8: .word 0x02151DC0
_020FAECC: .word 0x02151DB0
_020FAED0: .word MBi_ChildPortCallback
_020FAED4: .word 0x2151DBC
	arm_func_end MBi_ChildCallback

	arm_func_start MBi_ChildPortCallback
MBi_ChildPortCallback: // 0x020FAED8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, r0
	ldrh r0, [r1, #2]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldrh r0, [r1, #4]
	cmp r0, #0x15
	bgt _020FAF4C
	cmp r0, #0x15
	bge _020FAF8C
	cmp r0, #9
	addgt sp, sp, #4
	ldmgtia sp!, {lr}
	bxgt lr
	cmp r0, #7
	addlt sp, sp, #4
	ldmltia sp!, {lr}
	bxlt lr
	cmp r0, #7
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	add sp, sp, #4
	cmp r0, #9
	ldmia sp!, {lr}
	bx lr
_020FAF4C:
	cmp r0, #0x1a
	addgt sp, sp, #4
	ldmgtia sp!, {lr}
	bxgt lr
	cmp r0, #0x19
	addlt sp, sp, #4
	ldmltia sp!, {lr}
	bxlt lr
	cmp r0, #0x19
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	add sp, sp, #4
	cmp r0, #0x1a
	ldmia sp!, {lr}
	bx lr
_020FAF8C:
	ldr r2, _020FAFAC // =0x02151DB8
	mov r0, #9
	ldr r2, [r2, #0]
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020FAFAC: .word 0x02151DB8
	arm_func_end MBi_ChildPortCallback

	arm_func_start MBi_ParentCallback
MBi_ParentCallback: // 0x020FAFB0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	mov r4, r0
	ldrh r0, [r4, #0]
	cmp r0, #0x19
	bgt _020FB01C
	cmp r0, #0x19
	bge _020FB110
	cmp r0, #0xf
	addls pc, pc, r0, lsl #2
	b _020FB7F0
_020FAFDC: // jump table
	b _020FB03C // case 0
	b _020FB5AC // case 1
	b _020FB65C // case 2
	b _020FB7F0 // case 3
	b _020FB7F0 // case 4
	b _020FB7F0 // case 5
	b _020FB7F0 // case 6
	b _020FB0D4 // case 7
	b _020FB168 // case 8
	b _020FB7F0 // case 9
	b _020FB7F0 // case 10
	b _020FB7F0 // case 11
	b _020FB7F0 // case 12
	b _020FB6DC // case 13
	b _020FB3F8 // case 14
	b _020FB49C // case 15
_020FB01C:
	cmp r0, #0x1d
	bgt _020FB030
	cmp r0, #0x1d
	beq _020FB07C
	b _020FB7F0
_020FB030:
	cmp r0, #0x80
	beq _020FB71C
	b _020FB7F0
_020FB03C:
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _020FB06C
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x100
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB06C:
	bl MBi_OnInitializeDone
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB07C:
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _020FB0AC
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x100
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB0AC:
	ldr r1, _020FB814 // =0x02151DB8
	ldr r0, _020FB818 // =MBi_ParentCallback
	ldr r1, [r1, #0]
	bl WM_SetParentParameter
	mov r1, r0
	mov r0, #7
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB0D4:
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x15
	ldr r2, [r2, #0x51c]
	blx r2
	ldr r0, _020FB818 // =MBi_ParentCallback
	mov r1, #1
	bl WM_SetBeaconIndication
	mov r1, r0
	mov r0, #0x19
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB110:
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _020FB140
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x100
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB140:
	ldr r1, _020FB81C // _0211F9F0
	ldr r0, _020FB818 // =MBi_ParentCallback
	ldr r1, [r1, #0]
	bl WMi_StartParentEx
	mov r1, r0
	mov r0, #8
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB168:
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _020FB198
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x100
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB198:
	ldrh r0, [r4, #8]
	cmp r0, #7
	bgt _020FB1D0
	cmp r0, #7
	bge _020FB224
	cmp r0, #2
	bgt _020FB3D4
	cmp r0, #0
	blt _020FB3D4
	cmp r0, #0
	beq _020FB1F8
	cmp r0, #2
	beq _020FB398
	b _020FB3D4
_020FB1D0:
	cmp r0, #9
	bgt _020FB1E4
	cmp r0, #9
	beq _020FB358
	b _020FB3D4
_020FB1E4:
	cmp r0, #0x1a
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, lr}
	bxeq lr
	b _020FB3D4
_020FB1F8:
	ldr r1, _020FB814 // =0x02151DB8
	mov r2, #0
	ldr r0, [r1, #0]
	add sp, sp, #0x20
	add r0, r0, #0x500
	strh r2, [r0, #0x2a]
	ldr r0, [r1, #0]
	add r0, r0, #0x500
	strh r2, [r0, #0x28]
	ldmia sp!, {r4, lr}
	bx lr
_020FB224:
	ldr r2, _020FB814 // =0x02151DB8
	ldr r0, [r2, #0]
	add r0, r0, #0x500
	ldrh r1, [r0, #0x26]
	cmp r1, #1
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrh lr, [r0, #0x2a]
	ldrh r3, [r4, #0x10]
	mov ip, #1
	mov r1, r4
	orr r3, lr, ip, lsl r3
	strh r3, [r0, #0x2a]
	ldr r2, [r2, #0]
	mov r0, #0
	ldr r2, [r2, #0x51c]
	blx r2
	ldr r1, _020FB814 // =0x02151DB8
	ldr r0, [r1, #0]
	add r0, r0, #0x500
	ldrh r0, [r0, #0x28]
	cmp r0, #0
	bne _020FB320
	ldr r0, _020FB820 // =0x2151DBC
	ldr r0, [r0, #0]
	add r0, r0, #0x1000
	ldr r2, [r0, #0x31c]
	cmp r2, #0
	bne _020FB320
	mov r2, #1
	str r2, [r0, #0x31c]
	ldr r0, [r1, #0]
	ldr r1, _020FB814 // =0x02151DB8
	add r0, r0, #0x500
	ldrh r0, [r0, #0x2c]
	ldr ip, [r1]
	mov r1, #1
	cmp r0, #0
	movne r2, #0
	mov r0, r2, lsl #0x10
	mov r3, r0, lsr #0x10
	add r0, ip, #0x500
	ldrh r4, [r0, #0x18]
	mov r2, #0
	str r4, [sp]
	str r3, [sp, #4]
	str r2, [sp, #8]
	str r2, [sp, #0xc]
	str r2, [sp, #0x10]
	str r1, [sp, #0x14]
	str r1, [sp, #0x18]
	ldrh r2, [r0, #0x1a]
	ldr r1, [ip, #0x504]
	ldr r0, _020FB818 // =MBi_ParentCallback
	add r3, ip, #0x40
	bl WM_StartMPEx
	mov r1, r0
	mov r0, #0xe
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB320:
	bl MBi_IsSendEnabled
	cmp r0, #0
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r1, _020FB814 // =0x02151DB8
	mov r0, #0x19
	ldr r2, [r1, #0]
	mov r1, #0
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB358:
	ldr r2, _020FB814 // =0x02151DB8
	ldrh r3, [r4, #0x10]
	ldr r1, [r2, #0]
	mov r0, #1
	add r1, r1, #0x500
	ldrh ip, [r1, #0x2a]
	mvn r3, r0, lsl r3
	and r3, ip, r3
	strh r3, [r1, #0x2a]
	ldr r2, [r2, #0]
	mov r1, r4
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB398:
	ldr r0, _020FB814 // =0x02151DB8
	ldr r1, [r0, #0]
	add r0, r1, #0x500
	ldrh r0, [r0, #0x26]
	cmp r0, #1
	addeq sp, sp, #0x20
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r2, [r1, #0x51c]
	mov r1, r4
	mov r0, #0x1c
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB3D4:
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x100
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB3F8:
	ldr r0, _020FB820 // =0x2151DBC
	mov r1, #0
	ldr r0, [r0, #0]
	add r0, r0, #0x1000
	str r1, [r0, #0x31c]
	ldrh r0, [r4, #4]
	cmp r0, #0xa
	beq _020FB424
	cmp r0, #0xb
	beq _020FB454
	b _020FB478
_020FB424:
	ldr r3, _020FB814 // =0x02151DB8
	mov r4, #1
	ldr r2, [r3, #0]
	mov r0, #0x19
	add r2, r2, #0x500
	strh r4, [r2, #0x28]
	ldr r2, [r3, #0]
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB454:
	ldr r0, _020FB814 // =0x02151DB8
	ldr r1, [r4, #8]
	ldr r2, [r0, #0]
	mov r0, #3
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB478:
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x100
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB49C:
	ldr r0, _020FB820 // =0x2151DBC
	ldr r1, [r0, #0]
	add r0, r1, #0x7000
	ldr r0, [r0, #0x4c8]
	cmp r0, #0
	beq _020FB4F8
	mov r3, #0
	mov r2, r3
_020FB4BC:
	add r0, r1, r2, lsl #2
	add r0, r0, #0x1000
	ldr r0, [r0, #0x4e8]
	cmp r0, #0
	beq _020FB4DC
	add r3, r3, #1
	cmp r3, #2
	bhs _020FB4E8
_020FB4DC:
	add r2, r2, #1
	cmp r2, #0xf
	blo _020FB4BC
_020FB4E8:
	cmp r3, #1
	bne _020FB4F8
	ldr r0, _020FB824 // =0x000032C8
	bl OS_SpinWait
_020FB4F8:
	ldr r0, _020FB814 // =0x02151DB8
	mov r2, #0
	ldr r1, [r0, #0]
	strb r2, [r1, #0x50c]
	ldrh r1, [r4, #2]
	cmp r1, #0
	bne _020FB54C
	ldr r0, [r0, #0]
	mov r1, r4
	ldr r2, [r0, #0x51c]
	mov r0, #2
	blx r2
	ldr r1, _020FB814 // =0x02151DB8
	mov r0, #0x19
	ldr r2, [r1, #0]
	mov r1, #0
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB54C:
	cmp r1, #0xa
	bne _020FB574
	ldr r0, [r0, #0]
	mov r1, r4
	ldr r2, [r0, #0x51c]
	mov r0, #0x2a
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB574:
	ldr r0, [r0, #0]
	mov r1, r4
	ldr r2, [r0, #0x51c]
	mov r0, #0x13
	blx r2
	ldr r1, _020FB814 // =0x02151DB8
	mov r0, #0x19
	ldr r2, [r1, #0]
	mov r1, #0
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB5AC:
	ldr r0, _020FB820 // =0x2151DBC
	ldr r0, [r0, #0]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x320]
	cmp r0, #0
	bne _020FB644
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _020FB604
	ldr r2, _020FB814 // =0x02151DB8
	mov r3, #0
	ldr r0, [r2, #0]
	mov r1, r4
	add r0, r0, #0x500
	strh r3, [r0, #0x26]
	ldr r2, [r2, #0]
	mov r0, #0x100
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB604:
	ldr r2, _020FB814 // =0x02151DB8
	mov r3, #0
	ldr r1, [r2, #0]
	ldr r0, _020FB818 // =MBi_ParentCallback
	add r1, r1, #0x500
	strh r3, [r1, #0x2a]
	ldr r1, [r2, #0]
	add r1, r1, #0x500
	strh r3, [r1, #0x28]
	bl WM_End
	mov r1, r0
	mov r0, #2
	bl MBi_CheckWmErrcode
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB644:
	mov r1, #0
	mov r2, r1
	mov r0, #1
	bl WM_SetPortCallback
	mov r0, #0
	bl WM_SetIndCallback
_020FB65C:
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _020FB69C
	ldr r2, _020FB814 // =0x02151DB8
	mov r3, #0
	ldr r0, [r2, #0]
	mov r1, r4
	add r0, r0, #0x500
	strh r3, [r0, #0x26]
	ldr r2, [r2, #0]
	mov r0, #0x100
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB69C:
	ldr r2, _020FB814 // =0x02151DB8
	mov r3, #0
	ldr r1, [r2, #0]
	ldr r0, _020FB820 // =0x2151DBC
	strb r3, [r1, #0x50d]
	ldr r0, [r0, #0]
	mov r1, r4
	add r0, r0, #0x1300
	strh r3, [r0, #0x16]
	ldr r2, [r2, #0]
	mov r0, #0x11
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB6DC:
	ldrh r0, [r4, #2]
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, lr}
	bxne lr
	ldr r0, _020FB814 // =0x02151DB8
	ldrh r1, [r4, #0xa]
	ldr r0, [r0, #0]
	add sp, sp, #0x20
	add r0, r0, #0x500
	ldrh r2, [r0, #0x2a]
	mvn r1, r1
	and r1, r2, r1
	strh r1, [r0, #0x2a]
	ldmia sp!, {r4, lr}
	bx lr
_020FB71C:
	ldrh r0, [r4, #4]
	sub r0, r0, #0x10
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _020FB808
_020FB730: // jump table
	b _020FB750 // case 0
	b _020FB774 // case 1
	b _020FB798 // case 2
	b _020FB7BC // case 3
	b _020FB808 // case 4
	b _020FB808 // case 5
	b _020FB7E0 // case 6
	b _020FB808 // case 7
_020FB750:
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x1d
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB774:
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x1f
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB798:
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x20
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB7BC:
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x21
	ldr r2, [r2, #0x51c]
	blx r2
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB7E0:
	bl OS_Terminate
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
_020FB7F0:
	ldr r0, _020FB814 // =0x02151DB8
	mov r1, r4
	ldr r2, [r0, #0]
	mov r0, #0x100
	ldr r2, [r2, #0x51c]
	blx r2
_020FB808:
	add sp, sp, #0x20
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020FB814: .word 0x02151DB8
_020FB818: .word MBi_ParentCallback
_020FB81C: .word _0211F9F0
_020FB820: .word 0x2151DBC
_020FB824: .word 0x000032C8
	arm_func_end MBi_ParentCallback

	arm_func_start MBi_OnInitializeDone
MBi_OnInitializeDone: // 0x020FB828
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020FB888 // =MBi_ParentCallback
	bl WM_SetIndCallback
	mov r1, r0
	mov r0, #0x80
	bl MBi_CheckWmErrcode
	ldr r0, _020FB88C // _0211F9E4
	ldr r1, _020FB890 // _0211F9E8
	ldrh r3, [r0, #0]
	ldr r2, _020FB894 // _0211F9E0
	ldr r0, _020FB898 // _0211F9DC
	str r3, [sp]
	ldrh r1, [r1, #0]
	ldrh r2, [r2, #0]
	ldrh r3, [r0, #0]
	ldr r0, _020FB888 // =MBi_ParentCallback
	bl WM_SetLifeTime
	mov r1, r0
	mov r0, #0x1d
	bl MBi_CheckWmErrcode
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020FB888: .word MBi_ParentCallback
_020FB88C: .word _0211F9E4
_020FB890: .word _0211F9E8
_020FB894: .word _0211F9E0
_020FB898: .word _0211F9DC
	arm_func_end MBi_OnInitializeDone

	arm_func_start MBi_IsSendEnabled
MBi_IsSendEnabled: // 0x020FB89C
	ldr r1, _020FB900 // =0x02151DB8
	mov r0, #0
	ldr r2, [r1, #0]
	mov ip, r0
	add r1, r2, #0x500
	ldrh r1, [r1, #0x28]
	mov r3, r0
	cmp r1, #1
	bne _020FB8CC
	ldrb r1, [r2, #0x50c]
	cmp r1, #0
	moveq r3, #1
_020FB8CC:
	cmp r3, #0
	beq _020FB8E4
	add r1, r2, #0x500
	ldrh r1, [r1, #0x26]
	cmp r1, #0
	moveq ip, #1
_020FB8E4:
	cmp ip, #0
	bxeq lr
	add r1, r2, #0x500
	ldrh r1, [r1, #0x2a]
	cmp r1, #0
	movne r0, #1
	bx lr
	.align 2, 0
_020FB900: .word 0x02151DB8
	arm_func_end MBi_IsSendEnabled

	arm_func_start changeScanChannel
changeScanChannel: // 0x020FB904
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WM_GetAllowedChannel
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrh r3, [r4, #4]
	mov ip, #0
	mov lr, r3
	mov r2, #1
_020FB930:
	sub r1, lr, #1
	mov r1, r2, lsl r1
	ands r1, r0, r1
	beq _020FB94C
	cmp r3, lr
	strneh lr, [r4, #4]
	bne _020FB974
_020FB94C:
	add r1, ip, #1
	mov r1, r1, lsl #0x10
	cmp lr, #0x10
	mov ip, r1, lsr #0x10
	moveq r1, r2
	addne r1, lr, #1
	mov r1, r1, lsl #0x10
	cmp ip, #0x10
	mov lr, r1, lsr #0x10
	blo _020FB930
_020FB974:
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end changeScanChannel

	arm_func_start MBi_TryLoadCache
MBi_TryLoadCache: // 0x020FB980
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	mov r5, #0
	bl OS_DisableInterrupts
	add r2, r9, #0x30
	add r1, r9, #0x70
	mov r4, r0
	cmp r2, r1
	bhs _020FBA0C
_020FB9B4:
	ldr r0, [r2, #0xc]
	cmp r0, #2
	blo _020FBA00
	ldr r0, [r2, #0]
	subs r0, r8, r0
	bmi _020FBA00
	ldr r3, [r2, #4]
	add ip, r0, r6
	cmp ip, r3
	bhi _020FBA00
	ldr r3, [r2, #8]
	mov r1, r7
	mov r2, r6
	add r0, r3, r0
	bl MI_CpuCopy8
	mov r0, #0
	str r0, [r9]
	mov r5, #1
	b _020FBA0C
_020FBA00:
	add r2, r2, #0x10
	cmp r2, r1
	blo _020FB9B4
_020FBA0C:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end MBi_TryLoadCache

	arm_func_start MBi_AttachCacheBuffer
MBi_AttachCacheBuffer: // 0x020FBA24
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r9, r1
	mov r8, r2
	mov r7, r3
	bl OS_DisableInterrupts
	mov r6, r0
	add r5, r4, #0x30
	add r4, r4, #0x70
_020FBA4C:
	cmp r5, r4
	blo _020FBA58
	bl OS_Terminate
_020FBA58:
	ldr r0, [r5, #0xc]
	cmp r0, #0
	bne _020FBA7C
	str r9, [r5]
	str r8, [r5, #4]
	ldr r0, [sp, #0x20]
	str r7, [r5, #8]
	str r0, [r5, #0xc]
	b _020FBA84
_020FBA7C:
	add r5, r5, #0x10
	b _020FBA4C
_020FBA84:
	mov r0, r6
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end MBi_AttachCacheBuffer

	arm_func_start MBi_InitCache
MBi_InitCache: // 0x020FBA98
	ldr ip, _020FBAA8 // =MI_CpuFill8
	mov r1, #0
	mov r2, #0x70
	bx ip
	.align 2, 0
_020FBAA8: .word MI_CpuFill8
	arm_func_end MBi_InitCache

	arm_func_start MBi_EndTaskThread
MBi_EndTaskThread: // 0x020FBAAC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	bl MBi_IsTaskAvailable
	cmp r0, #0
	beq _020FBAE8
	ldr r0, _020FBAFC // =0x02151DE0
	mov r1, #0
	ldr r0, [r0, #0]
	mov r2, r5
	mov r3, r1
	add r0, r0, #0xc4
	bl MBi_SetTask
_020FBAE8:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020FBAFC: .word 0x02151DE0
	arm_func_end MBi_EndTaskThread

	arm_func_start MBi_SetTask
MBi_SetTask: // 0x020FBB00
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r4, _020FBC8C // =0x02151DE0
	mov r9, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	ldr r5, [r4, #0]
	bl MBi_IsTaskAvailable
	cmp r0, #0
	bne _020FBB30
	bl OS_Terminate
_020FBB30:
	ldr r0, [r9, #4]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _020FBB44
	bl OS_Terminate
_020FBB44:
	cmp r6, #0x1f
	bls _020FBB90
	mov r0, r5
	bl OS_GetThreadPriority
	cmp r6, #0x20
	bne _020FBB6C
	cmp r0, #0
	subne r6, r0, #1
	moveq r6, #0
	b _020FBB90
_020FBB6C:
	cmp r6, #0x21
	bne _020FBB84
	cmp r0, #0x1f
	addlo r6, r0, #1
	movhs r6, #0x1f
	b _020FBB90
_020FBB84:
	cmp r6, #0x22
	moveq r6, r0
	movne r6, #0x1f
_020FBB90:
	bl OS_DisableInterrupts
	ldr r2, [r9, #4]
	bic r1, r6, #0x80000000
	bic r2, r2, #1
	orr r2, r2, #1
	str r2, [r9, #4]
	ldr r2, [r9, #4]
	mov r4, r0
	and r0, r2, #1
	orr r0, r0, r1, lsl #1
	str r0, [r9, #4]
	str r8, [r9, #8]
	str r7, [r9, #0xc]
	ldr r0, [r5, #0xc0]
	cmp r0, #0
	bne _020FBBF4
	add r0, r5, #0xc4
	cmp r9, r0
	ldreq r0, _020FBC8C // =0x02151DE0
	moveq r1, #0
	streq r1, [r0]
	mov r0, r5
	str r9, [r5, #0xc0]
	bl OS_WakeupThreadDirect
	b _020FBC78
_020FBBF4:
	add r0, r5, #0xc4
	cmp r9, r0
	ldr r2, [r5, #0xc0]
	bne _020FBC34
	ldr r0, [r2, #0]
	cmp r0, #0
	beq _020FBC20
_020FBC10:
	mov r2, r0
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _020FBC10
_020FBC20:
	ldr r0, _020FBC8C // =0x02151DE0
	str r9, [r2]
	mov r1, #0
	str r1, [r0]
	b _020FBC78
_020FBC34:
	ldr r0, [r2, #4]
	mov r0, r0, lsr #1
	cmp r0, r6
	bls _020FBC54
	str r9, [r5, #0xc0]
	str r2, [r9]
	b _020FBC78
_020FBC50:
	mov r2, r1
_020FBC54:
	ldr r1, [r2, #0]
	cmp r1, #0
	beq _020FBC70
	ldr r0, [r1, #4]
	mov r0, r0, lsr #1
	cmp r0, r6
	bls _020FBC50
_020FBC70:
	str r1, [r9]
	str r9, [r2]
_020FBC78:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020FBC8C: .word 0x02151DE0
	arm_func_end MBi_SetTask

	arm_func_start MBi_IsTaskBusy
MBi_IsTaskBusy: // 0x020FBC90
	ldr r0, [r0, #4]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end MBi_IsTaskBusy

	arm_func_start MBi_InitTaskInfo
MBi_InitTaskInfo: // 0x020FBCA8
	ldr ip, _020FBCB8 // =MI_CpuFill8
	mov r1, #0
	mov r2, #0x20
	bx ip
	.align 2, 0
_020FBCB8: .word MI_CpuFill8
	arm_func_end MBi_InitTaskInfo

	arm_func_start MBi_IsTaskAvailable
MBi_IsTaskAvailable: // 0x020FBCBC
	ldr r0, _020FBCD4 // =0x02151DE0
	ldr r0, [r0, #0]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_020FBCD4: .word 0x02151DE0
	arm_func_end MBi_IsTaskAvailable

	arm_func_start MBi_InitTaskThread
MBi_InitTaskThread: // 0x020FBCD8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r6, r1
	bl OS_DisableInterrupts
	ldr r1, _020FBD58 // =0x02151DE0
	mov r4, r0
	ldr r0, [r1, #0]
	cmp r0, #0
	bne _020FBD44
	add r0, r5, #0xc4
	str r5, [r1]
	bl MBi_InitTaskInfo
	sub r0, r6, #0xe4
	mov lr, #0
	str lr, [r5, #0xc0]
	bic ip, r0, #3
	add r3, r5, #0xe4
	str ip, [sp]
	ldr r1, _020FBD5C // =MBi_TaskThread
	mov r0, r5
	mov r2, r5
	add r3, r3, ip
	str lr, [sp, #4]
	bl OS_CreateThread
	mov r0, r5
	bl OS_WakeupThreadDirect
_020FBD44:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020FBD58: .word 0x02151DE0
_020FBD5C: .word MBi_TaskThread
	arm_func_end MBi_InitTaskThread

	arm_func_start MBi_TaskThread
MBi_TaskThread: // 0x020FBD60
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	add r9, r8, #0xc4
	mov r4, #0
_020FBD74:
	bl OS_DisableInterrupts
	ldr r1, [r8, #0xc0]
	mov r5, r0
	cmp r1, #0
	bne _020FBDA8
_020FBD88:
	mov r0, r8
	mov r1, r4
	bl OS_SetThreadPriority
	mov r0, r4
	bl OS_SleepThread
	ldr r0, [r8, #0xc0]
	cmp r0, #0
	beq _020FBD88
_020FBDA8:
	ldr r7, [r8, #0xc0]
	ldr r1, [r8, #0xc0]
	mov r0, r8
	ldr r1, [r1, #0]
	str r1, [r8, #0xc0]
	ldr r1, [r7, #4]
	mov r1, r1, lsr #1
	bl OS_SetThreadPriority
	mov r0, r5
	bl OS_RestoreInterrupts
	ldr r1, [r7, #8]
	cmp r1, #0
	beq _020FBDE4
	mov r0, r7
	blx r1
_020FBDE4:
	bl OS_DisableInterrupts
	mov r6, r0
	mov r0, r8
	ldr r5, [r7, #0xc]
	bl OS_GetThreadPriority
	ldr r1, [r8, #0xc0]
	cmp r1, #0
	moveq r1, r4
	beq _020FBE24
	ldr r1, [r8, #0xc0]
	ldr r1, [r1, #4]
	cmp r0, r1, lsr #1
	ldrlo r1, [r8, #0xc0]
	ldrlo r1, [r1, #4]
	movlo r1, r1, lsr #1
	movhs r1, r0
_020FBE24:
	cmp r1, r0
	beq _020FBE34
	mov r0, r8
	bl OS_SetThreadPriority
_020FBE34:
	str r4, [r7]
	ldr r0, [r7, #4]
	cmp r5, #0
	bic r0, r0, #1
	str r0, [r7, #4]
	beq _020FBE54
	mov r0, r7
	blx r5
_020FBE54:
	cmp r7, r9
	beq _020FBE68
	mov r0, r6
	bl OS_RestoreInterrupts
	b _020FBD74
_020FBE68:
	bl OS_ExitThread
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end MBi_TaskThread

	arm_func_start MB_IsGetAllRequestData
MB_IsGetAllRequestData: // 0x020FBE78
	ldr r1, _020FBED0 // =0x02151DE8
	mov ip, #0
	ldr r2, [r1, #4]
	cmp r2, #0
	ble _020FBEC8
	ldr r1, _020FBED4 // =0x02151DE4
	sub r0, r0, #1
	ldr r1, [r1, #0]
	add r0, r1, r0, lsl #2
	ldr r3, [r0, #0x1e0]
	mov r1, #1
_020FBEA4:
	mov r0, r1, lsl ip
	ands r0, r0, r3
	moveq r0, #0
	bxeq lr
	add r0, ip, #1
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	cmp ip, r2
	blt _020FBEA4
_020FBEC8:
	mov r0, #1
	bx lr
	.align 2, 0
_020FBED0: .word 0x02151DE8
_020FBED4: .word 0x02151DE4
	arm_func_end MB_IsGetAllRequestData

	arm_func_start MBi_ReceiveRequestDataPiece
MBi_ReceiveRequestDataPiece: // 0x020FBED8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r2, _020FBF80 // =0x02151DE4
	mov r7, r1
	ldr r3, [r2, #0]
	cmp r3, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr r1, _020FBF84 // =0x02151DE8
	ldrb r4, [r0, #2]
	ldr r2, [r1, #4]
	cmp r4, r2
	addgt sp, sp, #4
	movgt r0, #0
	ldmgtia sp!, {r4, r5, r6, r7, lr}
	bxgt lr
	sub r6, r7, #1
	ldr r2, [r1, #0]
	add r1, r3, r6, lsl #5
	mla r1, r4, r2, r1
	add r0, r0, #3
	mov r5, r6, lsl #5
	bl MI_CpuCopy8
	ldr r0, _020FBF80 // =0x02151DE4
	mov r1, #1
	ldr r2, [r0, #0]
	mov r0, r7
	add r3, r2, #0x1e0
	ldr r2, [r3, r6, lsl #2]
	orr r1, r2, r1, lsl r4
	str r1, [r3, r6, lsl #2]
	bl MB_IsGetAllRequestData
	cmp r0, #0
	ldrne r0, _020FBF80 // =0x02151DE4
	ldrne r0, [r0, #0]
	addne r0, r0, r5
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020FBF80: .word 0x02151DE4
_020FBF84: .word 0x02151DE8
	arm_func_end MBi_ReceiveRequestDataPiece

	arm_func_start MBi_SetRecvBufferFromChild
MBi_SetRecvBufferFromChild: // 0x020FBF88
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #0]
	mov r5, r1
	mov r4, r2
	strb r0, [r5]
	ldrb r0, [r5, #0]
	cmp r0, #7
	beq _020FBFC0
	cmp r0, #8
	beq _020FC02C
	cmp r0, #9
	beq _020FC058
	b _020FC0A4
_020FBFC0:
	mov r0, r4
	bl MB_IsGetAllRequestData
	cmp r0, #0
	ldrne r0, _020FC0BC // =0x02151DE4
	subne r1, r4, #1
	ldrne r0, [r0, #0]
	addne r0, r0, r1, lsl #5
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	ldrb r1, [r6, #1]
	ldr r0, _020FC0C0 // =0x02151DE8
	strb r1, [r5, #2]
	ldrb r2, [r5, #2]
	ldr r1, [r0, #4]
	cmp r2, r1
	movgt r0, #0
	ldmgtia sp!, {r4, r5, r6, lr}
	bxgt lr
	ldr r2, [r0, #0]
	add r0, r6, #2
	add r1, r5, #3
	bl MI_CpuCopy8
	mov r0, r5
	mov r1, r4
	bl MBi_ReceiveRequestDataPiece
	mov r4, r0
	b _020FC0B0
_020FC02C:
	ldrb r0, [r6, #1]
	add r4, r6, #3
	and r0, r0, #0xff
	strh r0, [r5, #2]
	ldrb r0, [r6, #2]
	ldrh r1, [r5, #2]
	mov r0, r0, lsl #8
	and r0, r0, #0xff00
	orr r0, r1, r0
	strh r0, [r5, #2]
	b _020FC0B0
_020FC058:
	ldrb r0, [r6, #1]
	add r4, r6, #3
	ldr r1, _020FC0C0 // =0x02151DE8
	and r0, r0, #0xff
	strh r0, [r5, #2]
	ldrb r2, [r6, #2]
	ldrh r3, [r5, #2]
	mov r0, r4
	mov r2, r2, lsl #8
	and r2, r2, #0xff00
	orr r2, r3, r2
	strh r2, [r5, #2]
	ldr r2, [r1, #0]
	add r1, r5, #4
	bl MI_CpuCopy8
	ldr r0, _020FC0C0 // =0x02151DE8
	ldr r0, [r0, #0]
	add r4, r4, r0
	b _020FC0B0
_020FC0A4:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020FC0B0:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020FC0BC: .word 0x02151DE4
_020FC0C0: .word 0x02151DE8
	arm_func_end MBi_SetRecvBufferFromChild

	arm_func_start MBi_MakeParentSendBuffer
MBi_MakeParentSendBuffer: // 0x020FC0C4
	ldrb r3, [r0, #0]
	mov r2, r1
	add r2, r2, #1
	strb r3, [r1]
	ldrb r1, [r0, #0]
	cmp r1, #6
	addls pc, pc, r1, lsl #2
	b _020FC13C
_020FC0E4: // jump table
	b _020FC13C // case 0
	b _020FC144 // case 1
	b _020FC144 // case 2
	b _020FC144 // case 3
	b _020FC100 // case 4
	b _020FC144 // case 5
	b _020FC144 // case 6
_020FC100:
	ldrh r3, [r0, #2]
	add r1, r2, #3
	strb r3, [r2]
	ldrh r3, [r0, #2]
	and r3, r3, #0xff00
	mov r3, r3, asr #8
	strb r3, [r2, #1]
	ldrh r3, [r0, #4]
	strb r3, [r2, #2]
	ldrh r0, [r0, #4]
	add r2, r2, #4
	and r0, r0, #0xff00
	mov r0, r0, asr #8
	strb r0, [r1]
	b _020FC144
_020FC13C:
	mov r0, #0
	bx lr
_020FC144:
	mov r0, r2
	bx lr
	arm_func_end MBi_MakeParentSendBuffer

	arm_func_start MBi_ClearParentPieceBuffer
MBi_ClearParentPieceBuffer: // 0x020FC14C
	stmdb sp!, {r4, lr}
	ldr r1, _020FC194 // =0x02151DE4
	ldr r1, [r1, #0]
	cmp r1, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	sub r4, r0, #1
	add r0, r1, r4, lsl #5
	mov r1, #0
	mov r2, #0x1e
	bl MI_CpuFill8
	ldr r0, _020FC194 // =0x02151DE4
	mov r1, #0
	ldr r0, [r0, #0]
	add r0, r0, r4, lsl #2
	str r1, [r0, #0x1e0]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020FC194: .word 0x02151DE4
	arm_func_end MBi_ClearParentPieceBuffer

	arm_func_start MBi_SetParentPieceBuffer
MBi_SetParentPieceBuffer: // 0x020FC198
	ldr r3, _020FC1B0 // =0x02151DE4
	ldr ip, _020FC1B4 // =MI_CpuFill8
	mov r1, #0
	mov r2, #0x21c
	str r0, [r3]
	bx ip
	.align 2, 0
_020FC1B0: .word 0x02151DE4
_020FC1B4: .word MI_CpuFill8
	arm_func_end MBi_SetParentPieceBuffer

	arm_func_start MBi_SetChildMPMaxSize
MBi_SetChildMPMaxSize: // 0x020FC1B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020FC1F0 // =0x02151DE8
	sub r1, r0, #2
	mov r0, #0x1e
	str r1, [r2]
	bl _s32_div_f
	ldr r1, _020FC1F0 // =0x02151DE8
	mov r2, #0x1e
	str r0, [r1, #4]
	str r2, [r1, #8]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020FC1F0: .word 0x02151DE8
	arm_func_end MBi_SetChildMPMaxSize

	.rodata

.public _02117000
_02117000:
	.byte 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	
_0211700C:
	.byte 0x00, 0x40, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

	.data
	
_0211F9D0: // 0x0211F9D0
	.byte 0xFF
	.align 4

_0211F9D4: // 0x0211F9D4
    .word _0211700C
	
_0211F9D8: // 0x0211F9D8
    .word 0x6D6F72
	
_0211F9DC: // 0x0211F9DC
    .hword 5
	.align 4

_0211F9E0: // 0x0211F9E0
    .hword 0x28
	.align 4

_0211F9E4: // 0x0211F9E4
    .hword 0x28
	.align 4

_0211F9E8: // 0x0211F9E8
    .hword 0xFFFF
	.align 4

_0211F9EC: // 0x0211F9EC
    .word aMultiboot // "multiboot"

_0211F9F0: // 0x0211F9F0
    .word 1

aMultiboot: // 0x0211F9F4
	.byte 0x6D, 0x00, 0x75, 0x00, 0x6C, 0x00, 0x74, 0x00, 0x69, 0x00, 0x62, 0x00
	.byte 0x6F, 0x00, 0x6F, 0x00, 0x74, 0x00, 0x00, 0x00