	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWC_UpdateConnection
DWC_UpdateConnection: // 0x0208EF7C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWC_ProcessInet
	bl DWCi_CheckDisconnected
	cmp r0, #0
	beq _0208EFC4
	bl DWC_AC_GetApType
	mov r2, r0
	cmp r2, #0x63
	ldr r1, _0208EFD0 // =0xFFFF2D10
	movhi r2, #0x63
	mov r0, #8
	sub r1, r1, r2
	bl DWCi_SetError
	bl DWC_CleanupInet
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {pc}
_0208EFC4:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208EFD0: .word 0xFFFF2D10
	arm_func_end DWC_UpdateConnection

	arm_func_start DWC_GetLinkLevel
DWC_GetLinkLevel: // 0x0208EFD4
	ldr ip, _0208EFDC // =WCM_GetLinkLevel
	bx ip
	.align 2, 0
_0208EFDC: .word WCM_GetLinkLevel
	arm_func_end DWC_GetLinkLevel

	arm_func_start DWCi_CheckDisconnected
DWCi_CheckDisconnected: // 0x0208EFE0
	ldr r0, _0208F008 // =0x021439F0
	ldr r0, [r0]
	cmp r0, #0
	beq _0208F000
	ldrh r0, [r0, #4]
	cmp r0, #6
	moveq r0, #1
	bxeq lr
_0208F000:
	mov r0, #0
	bx lr
	.align 2, 0
_0208F008: .word 0x021439F0
	arm_func_end DWCi_CheckDisconnected

	arm_func_start DWC_CleanupInet
DWC_CleanupInet: // 0x0208F00C
	stmdb sp!, {r4, lr}
	ldr r0, _0208F068 // =0x021439F0
	ldr r1, [r0]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	ldrh r1, [r1, #4]
	cmp r1, #1
	moveq r1, #0
	streq r1, [r0]
	ldmeqia sp!, {r4, pc}
	bl DWC_AC_Destroy
	cmp r0, #0
	bne _0208F058
	mov r4, #0xa
_0208F044:
	mov r0, r4
	bl OS_Sleep
	bl DWC_AC_Destroy
	cmp r0, #0
	beq _0208F044
_0208F058:
	ldr r0, _0208F068 // =0x021439F0
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208F068: .word 0x021439F0
	arm_func_end DWC_CleanupInet

	arm_func_start DWC_GetInetStatus
DWC_GetInetStatus: // 0x0208F06C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0208F134 // =0x021439F0
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	ldrh r0, [r0, #4]
	cmp r0, #1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl DWC_AC_GetStatus
	mov r1, r0
	cmp r1, #5
	bne _0208F0D0
	ldr r1, _0208F134 // =0x021439F0
	mov r0, #4
	ldr r3, [r1]
	mov r2, #1
	strh r0, [r3, #4]
	ldr r1, [r1]
	add sp, sp, #4
	strh r2, [r1, #6]
	ldmia sp!, {pc}
_0208F0D0:
	cmp r1, #0
	bge _0208F128
	mvn r0, #9
	cmp r1, r0
	blt _0208F108
	sub r1, r1, #0x2bc
	mov r0, #9
	bl DWCi_SetError
	ldr r1, _0208F134 // =0x021439F0
	mov r0, #8
	ldr r1, [r1]
	add sp, sp, #4
	strh r0, [r1, #4]
	ldmia sp!, {pc}
_0208F108:
	mov r0, #5
	bl DWCi_SetError
	ldr r1, _0208F134 // =0x021439F0
	mov r0, #7
	ldr r1, [r1]
	add sp, sp, #4
	strh r0, [r1, #4]
	ldmia sp!, {pc}
_0208F128:
	mov r0, #2
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208F134: .word 0x021439F0
	arm_func_end DWC_GetInetStatus

	arm_func_start DWC_ProcessInet
DWC_ProcessInet: // 0x0208F138
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0208F1C8 // =0x021439F0
	ldr r1, [r0]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldrh r0, [r1, #4]
	cmp r0, #2
	bne _0208F178
	bl DWC_AC_Process
	ldr r1, _0208F1C8 // =0x021439F0
	add sp, sp, #4
	ldr r1, [r1]
	str r0, [r1]
	ldmia sp!, {pc}
_0208F178:
	cmp r0, #4
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldrh r0, [r1, #6]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl WCM_GetPhase
	cmp r0, #9
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _0208F1C8 // =0x021439F0
	mov r3, #0
	ldr r2, [r0]
	mov r1, #6
	strh r3, [r2, #6]
	ldr r0, [r0]
	strh r1, [r0, #4]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208F1C8: .word 0x021439F0
	arm_func_end DWC_ProcessInet

	arm_func_start DWC_CheckInet
DWC_CheckInet: // 0x0208F1CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0208F218 // =0x021439F0
	ldr r1, [r0]
	cmp r1, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	ldr r0, [r1]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
	mov r0, #3
	strh r0, [r1, #4]
	bl DWC_GetInetStatus
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208F218: .word 0x021439F0
	arm_func_end DWC_CheckInet

	arm_func_start DWC_ConnectInetAsync
DWC_ConnectInetAsync: // 0x0208F21C
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r0, _0208F2C0 // =0x021439F0
	ldr r0, [r0]
	cmp r0, #0
	beq _0208F2AC
	ldrh r0, [r0, #4]
	cmp r0, #1
	addne sp, sp, #0xc
	ldmneia sp!, {pc}
	add r0, sp, #0
	mov r1, #0
	mov r2, #0xc
	bl MI_CpuFill8
	ldr r0, _0208F2C0 // =0x021439F0
	ldr r3, _0208F2C4 // =DWC_Alloc
	ldr lr, [r0]
	ldr r2, _0208F2C8 // =DWC_Free
	ldrh ip, [lr, #8]
	add r0, sp, #0
	mov r1, #2
	strb ip, [sp, #8]
	ldrh ip, [lr, #0xa]
	strb ip, [sp, #9]
	str r3, [sp]
	str r2, [sp, #4]
	strh r1, [lr, #4]
	bl DWC_AC_Create
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {pc}
	mov r0, #9
	mvn r1, #5
	bl DWCi_SetError
	add sp, sp, #0xc
	ldmia sp!, {pc}
_0208F2AC:
	mov r0, #9
	mvn r1, #3
	bl DWCi_SetError
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0208F2C0: .word 0x021439F0
_0208F2C4: .word DWC_Alloc
_0208F2C8: .word DWC_Free
	arm_func_end DWC_ConnectInetAsync

	arm_func_start DWC_SetAuthServer
DWC_SetAuthServer: // 0x0208F2CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	beq _0208F2F4
	cmp r0, #1
	beq _0208F304
	cmp r0, #2
	beq _0208F314
	add sp, sp, #4
	ldmia sp!, {pc}
_0208F2F4:
	ldr r0, _0208F324 // =aHttpsNasTestNi
	bl DWC_Auth_SetCustomNas
	add sp, sp, #4
	ldmia sp!, {pc}
_0208F304:
	ldr r0, _0208F328 // =aHttpsNasDevNin
	bl DWC_Auth_SetCustomNas
	add sp, sp, #4
	ldmia sp!, {pc}
_0208F314:
	ldr r0, _0208F32C // =aHttpsNasNinten_1
	bl DWC_Auth_SetCustomNas
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208F324: .word aHttpsNasTestNi
_0208F328: .word aHttpsNasDevNin
_0208F32C: .word aHttpsNasNinten_1
	arm_func_end DWC_SetAuthServer

	arm_func_start DWC_InitInetEx
DWC_InitInetEx: // 0x0208F330
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _0208F38C // =0x021439F0
	mov r6, r0
	ldr r2, [r2]
	mov r5, r1
	mov r4, r3
	cmp r2, #0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, #0
	mov r2, #0xc
	bl MI_CpuFill8
	strh r5, [r6, #8]
	mov r0, #1
	strh r0, [r6, #0xa]
	strh r0, [r6, #4]
	mov r0, #0
	ldr r1, _0208F38C // =0x021439F0
	strh r0, [r6, #6]
	str r6, [r1]
	bl DWC_SetAuthServer
	mov r0, r4
	bl CPS_SetSslLowThreadPriority
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0208F38C: .word 0x021439F0
	arm_func_end DWC_InitInetEx

    .data
	
aHttpsNasTestNi: // 0x0211C178
	.asciz "https://nas.test.nintendowifi.net/ac"
	.align 4
	
aHttpsNasDevNin: // 0x0211C1A0
	.asciz "https://nas.dev.nintendowifi.net/ac"
	.align 4
	
aHttpsNasNinten_1: // 0x0211C1C4
	.asciz "https://nas.nintendowifi.net/ac"
	.align 4
