	.include "asm/macros.inc"
	.include "global.inc"
	
	.section .version,4

	.public _version_NINTENDO_WiFi
_version_NINTENDO_WiFi: ; 0x02000BC4
	.asciz "[SDK+NINTENDO:WiFi1.3.30000.0611120346]"
	.align 4

	.bss

.public _02145638
_02145638:
	.space 0x1BF8

	.text

	arm_func_start SOCL_LinkIsOn
SOCL_LinkIsOn: // 0x020BB70C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl WCM_GetApMacAddress
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SOCL_LinkIsOn

	arm_func_start SOCLi_DhcpTimeout
SOCLi_DhcpTimeout: // 0x020BB730
	ldr r0, _020BB744 // =0x02145644
	ldr r1, [r0]
	orr r1, r1, #2
	str r1, [r0]
	bx lr
	.align 2, 0
_020BB744: .word 0x02145644
	arm_func_end SOCLi_DhcpTimeout

	arm_func_start SOCLi_SetMyIP
SOCLi_SetMyIP: // 0x020BB748
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020BB7AC // =_02145638
	ldr r0, _020BB7B0 // =0x02145644
	ldr lr, [r1]
	ldr r3, [r0]
	ldr ip, [lr, #4]
	ldr r2, _020BB7B4 // =0x0214587C
	ldr r1, _020BB7B8 // =0x02145848
	str ip, [r2]
	ldr ip, [lr, #8]
	ldr r2, _020BB7BC // =0x02145858
	str ip, [r1]
	ldr ip, [lr, #0xc]
	ldr r1, _020BB7C0 // =0x02145894
	str ip, [r2]
	ldr ip, [lr, #0x10]
	orr r2, r3, #2
	str ip, [r1]
	ldr r3, [lr, #0x14]
	str r3, [r1, #4]
	str r2, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020BB7AC: .word _02145638
_020BB7B0: .word 0x02145644
_020BB7B4: .word 0x0214587C
_020BB7B8: .word 0x02145848
_020BB7BC: .word 0x02145858
_020BB7C0: .word 0x02145894
	arm_func_end SOCLi_SetMyIP

	arm_func_start SOCLi_StartupCPS
SOCLi_StartupCPS: // 0x020BB7C4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _020BB918 // =_02145638
	ldr r5, _020BB91C // =0x0214564C
	ldr r4, [r0]
	mov r0, r5
	mov r1, #0
	mov r2, #0x30
	bl MI_CpuFill8
	ldr r0, _020BB920 // =0x0214563C
	ldr r2, [r4, #0x18]
	mov r1, r5
	str r2, [r1, #4]
	ldr ip, [r4, #0x1c]
	mov r2, #0
	ldr r3, _020BB924 // =SOCL_LinkIsOn
	ldr r0, [r0]
	str ip, [r1, #8]
	str r3, [r1, #0x10]
	str r2, [r1, #0x14]
	str r2, [r1, #0x18]
	str r0, [r1, #0x2c]
	ldr r0, [r4, #0x24]
	cmp r0, #0
	strne r0, [r5, #0x20]
	moveq r0, #0x4000
	streq r0, [r5, #0x20]
	ldr r0, [r4, #0x28]
	cmp r0, #0
	strne r0, [r5, #0x1c]
	bne _020BB858
	ldr r1, _020BB918 // =_02145638
	ldr r0, [r5, #0x20]
	ldr r1, [r1]
	ldr r1, [r1, #0x18]
	blx r1
	str r0, [r5, #0x1c]
_020BB858:
	ldr r0, [r4, #0x30]
	ldr ip, [r4, #0x34]
	cmp r0, #0
	moveq r0, #0x240
	cmp ip, #0
	sub r2, r0, #0x28
	moveq ip, #0x10c0
	add r0, ip, ip, lsr #31
	str r2, [r5, #0x24]
	ldr r1, _020BB928 // =0x0211F180
	mov r3, r0, asr #1
	ldr r0, _020BB92C // =0x0214587C
	mov r2, #0
	strh ip, [r1, #2]
	strh r3, [r1, #4]
	str r2, [r0]
	ldr r0, [r4]
	cmp r0, #0
	beq _020BB8CC
	ldr r0, _020BB930 // =0x02145644
	mov r1, #1
	str r1, [r0]
	ldr r1, _020BB934 // =SOCLi_DhcpTimeout
	str r2, [r5]
	ldr r0, _020BB938 // =0x02145640
	str r1, [r5, #0xc]
	ldr r0, [r0]
	str r0, [r5, #0x28]
	b _020BB8E4
_020BB8CC:
	ldr r0, _020BB930 // =0x02145644
	mov r1, #1
	str r2, [r0]
	ldr r0, _020BB93C // =SOCLi_SetMyIP
	str r1, [r5]
	str r0, [r5, #0xc]
_020BB8E4:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	moveq r0, #0xb
	bl CPS_SetThreadPriority
	ldr r0, _020BB940 // =CPSi_RecvCallbackFunc
	bl WCM_SetRecvDCFCallback
	ldr r0, _020BB944 // =SOCLi_TrashSocket
	bl CPS_SetScavengerCallback
	mov r0, r5
	bl CPS_Startup
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020BB918: .word _02145638
_020BB91C: .word 0x0214564C
_020BB920: .word 0x0214563C
_020BB924: .word SOCL_LinkIsOn
_020BB928: .word 0x0211F180
_020BB92C: .word 0x0214587C
_020BB930: .word 0x02145644
_020BB934: .word SOCLi_DhcpTimeout
_020BB938: .word 0x02145640
_020BB93C: .word SOCLi_SetMyIP
_020BB940: .word CPSi_RecvCallbackFunc
_020BB944: .word SOCLi_TrashSocket
	arm_func_end SOCLi_StartupCPS

	arm_func_start SOCLi_StartupSOCL
SOCLi_StartupSOCL: // 0x020BB948
	stmdb sp!, {r4, lr}
	ldr r0, _020BB980 // =_02145638
	ldr r0, [r0]
	ldr r0, [r0, #0x20]
	bl SOCLi_StartupCommandPacketQueue
	movs r4, r0
	bmi _020BB974
	ldr r0, _020BB984 // =0x0211F198
	bl SOCL_UdpSendSocket
	ldr r1, _020BB988 // =0x02145648
	str r0, [r1]
_020BB974:
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BB980: .word _02145638
_020BB984: .word 0x0211F198
_020BB988: .word 0x02145648
	arm_func_end SOCLi_StartupSOCL

	arm_func_start SOCL_Startup
SOCL_Startup: // 0x020BB98C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _020BB9C8 // =_version_NINTENDO_WiFi
	bl OSi_ReferSymbol
	ldr r0, _020BB9CC // =_02145638
	ldr r1, [r0]
	cmp r1, #0
	movne r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	str r4, [r0]
	bl SOCLi_StartupCPS
	bl SOCLi_StartupSOCL
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BB9C8: .word _version_NINTENDO_WiFi
_020BB9CC: .word _02145638
	arm_func_end SOCL_Startup
