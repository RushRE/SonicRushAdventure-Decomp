	.include "asm/macros.inc"
	.include "global.inc"
	
	.section .version,4

	.public _version_NINTENDO_WiFi
_version_NINTENDO_WiFi: ; 0x02000BC4
	.asciz "[SDK+NINTENDO:WiFi1.3.30000.0611120346]"
	.align 4

	.public _version_UBIQUITOUS_CPS
_version_UBIQUITOUS_CPS: ; 0x02000BEC
	.asciz "[SDK+UBIQUITOUS:CPS]"
	.align 4

	.public _version_UBIQUITOUS_SSL
_version_UBIQUITOUS_SSL: ; 0x02000C04
	.asciz "[SDK+UBIQUITOUS:SSL]"
	.align 4

	.bss

.public _02145638
_02145638:
	.space 0x1BF8

	.text

	arm_func_start sub_20BB70C
sub_20BB70C: // 0x020BB70C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20CC8AC
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20BB70C

	arm_func_start sub_20BB730
sub_20BB730: // 0x020BB730
	ldr r0, _020BB744 // =0x02145644
	ldr r1, [r0]
	orr r1, r1, #2
	str r1, [r0]
	bx lr
	.align 2, 0
_020BB744: .word 0x02145644
	arm_func_end sub_20BB730

	arm_func_start sub_20BB748
sub_20BB748: // 0x020BB748
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
	arm_func_end sub_20BB748

	arm_func_start sub_20BB7C4
sub_20BB7C4: // 0x020BB7C4
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
	ldr r3, _020BB924 // =sub_20BB70C
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
	ldr r1, _020BB934 // =sub_20BB730
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
	ldr r0, _020BB93C // =sub_20BB748
	str r1, [r5]
	str r0, [r5, #0xc]
_020BB8E4:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	moveq r0, #0xb
	bl sub_20C3CE4
	ldr r0, _020BB940 // =sub_20C36B8
	bl sub_20CC818
	ldr r0, _020BB944 // =sub_20BD818
	bl sub_20C3D80
	mov r0, r5
	bl sub_20C3DF0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020BB918: .word _02145638
_020BB91C: .word 0x0214564C
_020BB920: .word 0x0214563C
_020BB924: .word sub_20BB70C
_020BB928: .word 0x0211F180
_020BB92C: .word 0x0214587C
_020BB930: .word 0x02145644
_020BB934: .word sub_20BB730
_020BB938: .word 0x02145640
_020BB93C: .word sub_20BB748
_020BB940: .word sub_20C36B8
_020BB944: .word sub_20BD818
	arm_func_end sub_20BB7C4

	arm_func_start sub_20BB948
sub_20BB948: // 0x020BB948
	stmdb sp!, {r4, lr}
	ldr r0, _020BB980 // =_02145638
	ldr r0, [r0]
	ldr r0, [r0, #0x20]
	bl sub_20BBCD0
	movs r4, r0
	bmi _020BB974
	ldr r0, _020BB984 // =0x0211F198
	bl sub_20BC0C8
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
	arm_func_end sub_20BB948

	arm_func_start sub_20BB98C
sub_20BB98C: // 0x020BB98C
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
	bl sub_20BB7C4
	bl sub_20BB948
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BB9C8: .word _version_NINTENDO_WiFi
_020BB9CC: .word _02145638
	arm_func_end sub_20BB98C

	arm_func_start sub_20BB9D0
sub_20BB9D0: // 0x020BB9D0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	add r6, sp, #0
	mov r4, #0
	mov r5, #1
_020BB9E8:
	mov r0, r9
	mov r1, r6
	mov r2, r5
	bl OS_ReadMessage
	ldr r0, [sp]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	ldr r1, [r0]
	blx r1
	mov r7, r0
	bl OS_DisableInterrupts
	mov r8, r0
	bl OS_DisableScheduler
	mov r0, r9
	mov r1, r4
	mov r2, r4
	bl OS_ReceiveMessage
	ldr r0, [sp]
	ldr r0, [r0, #4]
	cmp r0, #0
	strne r7, [r0, #0x6c]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _020BBA60
	mov r1, r7
	mov r2, r4
	bl OS_SendMessage
_020BBA60:
	ldr r0, [sp]
	bl sub_20BBBBC
	bl OS_EnableScheduler
	mov r0, r8
	bl OS_RestoreInterrupts
	b _020BB9E8
	arm_func_end sub_20BB9D0

	arm_func_start sub_20BBA78
sub_20BBA78: // 0x020BBA78
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20BBA78

	arm_func_start sub_20BBA84
sub_20BBA84: // 0x020BBA84
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl sub_20BBBA8
	mov r1, r4
	bl sub_20BBAC0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20BBA84

	arm_func_start sub_20BBAA0
sub_20BBAA0: // 0x020BBAA0
	ldr ip, _020BBAAC // =sub_20BBAC0
	ldr r0, [r0, #0x68]
	bx ip
	.align 2, 0
_020BBAAC: .word sub_20BBAC0
	arm_func_end sub_20BBAA0

	arm_func_start sub_20BBAB0
sub_20BBAB0: // 0x020BBAB0
	ldr ip, _020BBABC // =sub_20BBAC0
	ldr r0, [r0, #0x64]
	bx ip
	.align 2, 0
_020BBABC: .word sub_20BBAC0
	arm_func_end sub_20BBAB0

	arm_func_start sub_20BBAC0
sub_20BBAC0: // 0x020BBAC0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x2c
	mov r4, r1
	ldrsb r2, [r4, #0xd]
	mov r5, r0
	cmp r2, #1
	bne _020BBB14
	add r0, sp, #8
	add r1, sp, #4
	mov r2, #1
	bl OS_InitMessageQueue
	add r2, sp, #8
	mov r0, r5
	mov r1, r4
	str r2, [r4, #8]
	bl sub_20BBB50
	add r0, sp, #8
	add r1, sp, #0
	mov r2, #1
	bl OS_ReceiveMessage
	b _020BBB24
_020BBB14:
	mov r2, #0
	str r2, [r4, #8]
	bl sub_20BBB50
	str r0, [sp]
_020BBB24:
	ldr r0, [sp]
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20BBAC0

	arm_func_start sub_20BBB34
sub_20BBB34: // 0x020BBB34
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl sub_20BBBA8
	mov r1, r4
	bl sub_20BBB50
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20BBB34

	arm_func_start sub_20BBB50
sub_20BBB50: // 0x020BBB50
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r1
	beq _020BBB6C
	ldrsb r1, [r5, #0xd]
	ands r1, r1, #1
	beq _020BBB74
_020BBB6C:
	mov r2, #1
	b _020BBB78
_020BBB74:
	mov r2, #0
_020BBB78:
	mov r1, r5
	bl OS_SendMessage
	movs r4, r0
	bne _020BBB90
	mov r0, r5
	bl sub_20BBBBC
_020BBB90:
	cmp r4, #0
	movne r0, #0
	mvneq r0, #0x29
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20BBB50

	arm_func_start sub_20BBBA8
sub_20BBBA8: // 0x020BBBA8
	ldr r1, [r0, #0x64]
	cmp r1, #0
	ldreq r1, [r0, #0x68]
	mov r0, r1
	bx lr
	arm_func_end sub_20BBBA8

	arm_func_start sub_20BBBBC
sub_20BBBBC: // 0x020BBBBC
	stmdb sp!, {lr}
	sub sp, sp, #4
	movs r1, r0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r0, _020BBBEC // =0x02145680
	mov r2, #0
	bl OS_SendMessage
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020BBBEC: .word 0x02145680
	arm_func_end sub_20BBBBC

	arm_func_start sub_20BBBF0
sub_20BBBF0: // 0x020BBBF0
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r2
	mov r6, r0
	mov r0, r4
	mov r5, r1
	bl sub_20BBC38
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	str r6, [r0]
	str r5, [r0, #4]
	mov r1, #0
	str r1, [r0, #8]
	ldrsb r1, [r5, #0x73]
	strb r1, [r0, #0xc]
	strb r4, [r0, #0xd]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20BBBF0

	arm_func_start sub_20BBC38
sub_20BBC38: // 0x020BBC38
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, r0
	ldr r0, _020BBC68 // =0x02145680
	add r1, sp, #0
	bl OS_ReceiveMessage
	cmp r0, #0
	ldrne r0, [sp]
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020BBC68: .word 0x02145680
	arm_func_end sub_20BBC38

	arm_func_start sub_20BBC6C
sub_20BBC6C: // 0x020BBC6C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020BBCC4 // =0x02145680
	ldr r1, [r0, #0x1c]
	ldr r0, [r0, #0x14]
	cmp r1, r0
	addlt sp, sp, #4
	mvnlt r0, #0
	ldmltia sp!, {lr}
	bxlt lr
	ldr r0, _020BBCC8 // =_02145638
	ldr r1, _020BBCCC // =0x0214567C
	ldr r2, [r0]
	ldr r0, [r1]
	ldr r1, [r2, #0x1c]
	blx r1
	ldr r1, _020BBCCC // =0x0214567C
	mov r0, #0
	str r0, [r1]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020BBCC4: .word 0x02145680
_020BBCC8: .word _02145638
_020BBCCC: .word 0x0214567C
	arm_func_end sub_20BBC6C

	arm_func_start sub_20BBCD0
sub_20BBCD0: // 0x020BBCD0
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r0, #0x2c
	mul r1, r4, r0
	ldr r0, _020BBD60 // =_02145638
	mov r2, r4, lsl #2
	add r2, r2, #3
	ldr r0, [r0]
	add r1, r1, #3
	bic r5, r2, #3
	bic r2, r1, #3
	ldr r1, [r0, #0x18]
	add r0, r2, r5
	blx r1
	movs r6, r0
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r0, _020BBD64 // =0x02145680
	mov r1, r6
	mov r2, r4
	bl OS_InitMessageQueue
	cmp r4, #0
	add r5, r6, r5
	ble _020BBD4C
_020BBD34:
	mov r0, r5
	bl sub_20BBBBC
	sub r4, r4, #1
	cmp r4, #0
	add r5, r5, #0x2c
	bgt _020BBD34
_020BBD4C:
	ldr r1, _020BBD68 // =0x0214567C
	mov r0, #0
	str r6, [r1]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020BBD60: .word _02145638
_020BBD64: .word 0x02145680
_020BBD68: .word 0x0214567C
	arm_func_end sub_20BBCD0

	arm_func_start sub_20BBD6C
sub_20BBD6C: // 0x020BBD6C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r2
	mov r7, r0
	mov r0, r5
	mov r6, r1
	bl sub_20BBF1C
	add r4, r7, r0
	ldrb r2, [r5, #3]
	mov r0, r6
	mov r1, r7
	bl OS_InitMessageQueue
	add r0, r6, #0xe0
	bl OS_InitMutex
	ldrh r2, [r5]
	add r0, r6, #0x20
	ldr r1, _020BBDE0 // =sub_20BB9D0
	str r2, [sp]
	ldrb ip, [r5, #2]
	mov r2, r6
	mov r3, r4
	str ip, [sp, #4]
	bl OS_CreateThread
	add r0, r6, #0x20
	bl OS_WakeupThreadDirect
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020BBDE0: .word sub_20BB9D0
	arm_func_end sub_20BBD6C

	arm_func_start sub_20BBDE4
sub_20BBDE4: // 0x020BBDE4
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r2, #0
	moveq r0, #0
	str r0, [r1, #4]
	mov r0, r2
	str r2, [r1]
	bl sub_20BE0C4
	add r0, r4, r0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20BBDE4

	arm_func_start sub_20BBE10
sub_20BBE10: // 0x020BBE10
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r1
	ldrsb r1, [r6]
	mov r7, r0
	add r4, r7, #0x80
	strb r1, [r7, #0x73]
	ldrsb r0, [r6, #1]
	strb r0, [r7, #0x72]
	ldrh r0, [r6, #2]
	cmp r0, #0
	beq _020BBE98
	str r4, [r7, #0x64]
	ldrh r2, [r6, #4]
	mov r1, r4
	add r0, r4, #0x114
	strh r2, [r4, #0xfc]
	add r2, r6, #0x10
	mov r5, r4
	bl sub_20BBD6C
	ldrh r2, [r6, #2]
	add r1, r7, #0x3c
	bl sub_20BBDE4
	ldrh r2, [r6, #8]
	add r1, r7, #0x50
	bl sub_20BBDE4
	ldrh r3, [r6, #0xe]
	add r1, r5, #0x100
	mov r2, #0
	strh r3, [r1, #0xa]
	str r2, [r5, #0x110]
	ldr r1, [r5, #0x110]
	mov r4, r0
	str r1, [r5, #0x10c]
_020BBE98:
	ldrh r0, [r6, #6]
	cmp r0, #0
	ldreq r0, _020BBF18 // =0x02145648
	ldreq r0, [r0]
	ldreq r0, [r0, #0x68]
	streq r0, [r7, #0x68]
	beq _020BBF08
	str r4, [r7, #0x68]
	mov r1, r4
	str r7, [r4, #0x10c]
	add r0, r4, #0x110
	add r2, r6, #0x14
	mov r5, r4
	bl sub_20BBD6C
	ldrh r2, [r6, #6]
	add r1, r7, #0x48
	bl sub_20BBDE4
	ldrh r2, [r6, #0xa]
	add r1, r7, #0x58
	bl sub_20BBDE4
	ldrh r2, [r6, #0xc]
	add r1, r4, #0xf8
	bl sub_20BBDE4
	mov r1, #0
	str r1, [r5, #0x108]
	ldr r1, [r5, #0x108]
	mov r4, r0
	str r1, [r5, #0x104]
_020BBF08:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020BBF18: .word 0x02145648
	arm_func_end sub_20BBE10

	arm_func_start sub_20BBF1C
sub_20BBF1C: // 0x020BBF1C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldrb r0, [r5, #3]
	mov r0, r0, lsl #2
	bl sub_20BE0C4
	mov r4, r0
	ldrh r0, [r5]
	bl sub_20BE0C4
	add r0, r4, r0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20BBF1C

	arm_func_start sub_20BBF50
sub_20BBF50: // 0x020BBF50
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldrh r0, [r5, #2]
	mov r4, #0x80
	cmp r0, #0
	beq _020BBF90
	add r4, r4, #0x114
	bl sub_20BE0C4
	add r4, r4, r0
	ldrh r0, [r5, #8]
	bl sub_20BE0C4
	add r4, r4, r0
	add r0, r5, #0x10
	bl sub_20BBF1C
	add r4, r4, r0
_020BBF90:
	ldrh r0, [r5, #6]
	cmp r0, #0
	beq _020BBFCC
	add r4, r4, #0x110
	bl sub_20BE0C4
	add r4, r4, r0
	ldrh r0, [r5, #0xa]
	bl sub_20BE0C4
	add r4, r4, r0
	ldrh r0, [r5, #0xc]
	bl sub_20BE0C4
	add r4, r4, r0
	add r0, r5, #0x14
	bl sub_20BBF1C
	add r4, r4, r0
_020BBFCC:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20BBF50

	arm_func_start sub_20BBFDC
sub_20BBFDC: // 0x020BBFDC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	bl sub_20BBF50
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _020BC04C // =_02145638
	mov r5, r0
	ldr r1, [r1]
	mov r0, r4
	ldr r1, [r1, #0x18]
	blx r1
	movs r6, r0
	beq _020BC034
	mov r2, r4
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r6
	mov r1, r7
	bl sub_20BBE10
	mov r0, r6
	bl sub_20BE1EC
_020BC034:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020BC04C: .word _02145638
	arm_func_end sub_20BBFDC

	arm_func_start sub_20BC050
sub_20BC050: // 0x020BC050
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #4]
	mov r0, r4
	bl sub_20C0C84
	ldrsb r0, [r4, #0x73]
	ldr r1, [r4, #0x68]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020BC0B0
_020BC074: // jump table
	b _020BC088 // case 0
	b _020BC098 // case 1
	b _020BC0AC // case 2
	b _020BC0B0 // case 3
	b _020BC088 // case 4
_020BC088:
	add r0, r1, #0x20
	bl sub_20C0B68
	bl sub_20C0BA0
	b _020BC0B0
_020BC098:
	bl sub_20C0BA0
	bl sub_20C0C44
	ldr r0, _020BC0C4 // =sub_20BC6A8
	bl sub_20C0B04
	b _020BC0B0
_020BC0AC:
	bl sub_20C0C44
_020BC0B0:
	mov r0, #1
	strh r0, [r4, #0x70]
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BC0C4: .word sub_20BC6A8
	arm_func_end sub_20BC050

	arm_func_start sub_20BC0C8
sub_20BC0C8: // 0x020BC0C8
	stmdb sp!, {r4, lr}
	bl sub_20BBFDC
	movs r4, r0
	mvneq r0, #0x30
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, _020BC108 // =sub_20BC050
	mov r1, r4
	mov r2, #1
	bl sub_20BBBF0
	mov r1, r0
	mov r0, r4
	bl sub_20BBA84
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BC108: .word sub_20BC050
	arm_func_end sub_20BC0C8

	arm_func_start sub_20BC10C
sub_20BC10C: // 0x020BC10C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r4, [r6, #4]
	ldr r5, [r4, #0x64]
	add r0, r5, #0xe0
	bl OS_LockMutex
	mov r1, #0
	ldrh r0, [r6, #0x10]
	mov r2, r1
	bl sub_20C0BD4
	bl sub_20C0AB0
	mov r2, #0
	add r0, sp, #0
	add r1, sp, #4
	str r2, [r5, #0xf8]
	bl sub_20C093C
	ldrh r2, [sp]
	ldr r1, [r6, #0x14]
	strh r2, [r1]
	ldr r1, [r6, #0x18]
	str r0, [r1]
	ldrsh r1, [r4, #0x70]
	add r0, r5, #0xe0
	orr r1, r1, #4
	strh r1, [r4, #0x70]
	bl OS_UnlockMutex
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20BC10C

	arm_func_start sub_20BC188
sub_20BC188: // 0x020BC188
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl sub_20BE100
	cmp r0, #0
	mvnne r0, #0x1b
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	cmp r6, #0
	mov r1, #0
	beq _020BC1C4
	ldrsh r0, [r6, #0x70]
	ands r0, r0, #1
	movne r1, #1
_020BC1C4:
	cmp r1, #0
	mvneq r0, #0x26
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldrsh r0, [r6, #0x70]
	ands r0, r0, #2
	mvnne r0, #0x1b
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	ldrsb r0, [r6, #0x73]
	mov r1, #1
	cmp r0, #0
	beq _020BC200
	cmp r0, #4
	movne r1, #0
_020BC200:
	cmp r1, #0
	mvneq r0, #0x1b
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldrsb r2, [r6, #0x72]
	cmp r2, #1
	mvnne r0, #5
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	ldrh r0, [r6, #0x74]
	cmp r0, #0
	mvneq r0, #0x1b
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r0, _020BC274 // =sub_20BC10C
	mov r1, r6
	bl sub_20BBBF0
	mov r1, r0
	ldrh r2, [r6, #0x74]
	mov r0, r6
	strh r2, [r1, #0x10]
	str r5, [r1, #0x14]
	str r4, [r1, #0x18]
	ldrsh r2, [r6, #0x70]
	orr r2, r2, #2
	strh r2, [r6, #0x70]
	bl sub_20BBAB0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020BC274: .word sub_20BC10C
	arm_func_end sub_20BC188

	arm_func_start sub_20BC278
sub_20BC278: // 0x020BC278
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl sub_20BE100
	cmp r0, #0
	addne sp, sp, #4
	mvnne r0, #0x1b
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	cmp r6, #0
	mov r1, #0
	beq _020BC2BC
	ldrsh r0, [r6, #0x70]
	ands r0, r0, #1
	movne r1, #1
_020BC2BC:
	cmp r1, #0
	addeq sp, sp, #4
	mvneq r0, #0x26
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldrsh r0, [r6, #0x70]
	ands r0, r0, #2
	addne sp, sp, #4
	mvnne r0, #0x1b
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldrsb r0, [r6, #0x73]
	mov r1, #1
	cmp r0, #0
	beq _020BC300
	cmp r0, #4
	movne r1, #0
_020BC300:
	cmp r1, #0
	addeq sp, sp, #4
	mvneq r0, #0x1b
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldrsb r0, [r6, #0x72]
	cmp r0, #1
	addne sp, sp, #4
	mvnne r0, #5
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldr r0, _020BC380 // =0x0211F180
	bl sub_20BC0C8
	movs r7, r0
	addmi sp, sp, #4
	ldmmiia sp!, {r4, r5, r6, r7, lr}
	bxmi lr
	ldrh r1, [r6, #0x74]
	bl sub_20BC60C
	cmp r0, #0
	addlt sp, sp, #4
	ldmltia sp!, {r4, r5, r6, r7, lr}
	bxlt lr
	mov r0, r7
	mov r1, r5
	mov r2, r4
	bl sub_20BC188
	cmp r0, #0
	movge r0, r7
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020BC380: .word 0x0211F180
	arm_func_end sub_20BC278

	arm_func_start sub_20BC384
sub_20BC384: // 0x020BC384
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20BE100
	cmp r0, #0
	mvnne r0, #0x1b
	ldmneia sp!, {r4, lr}
	bxne lr
	cmp r4, #0
	mov r1, #0
	beq _020BC3B8
	ldrsh r0, [r4, #0x70]
	ands r0, r0, #1
	movne r1, #1
_020BC3B8:
	cmp r1, #0
	mvneq r0, #0x26
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrsh r0, [r4, #0x70]
	ands r0, r0, #2
	mvnne r0, #0x1b
	ldmneia sp!, {r4, lr}
	bxne lr
	ldrsb r0, [r4, #0x73]
	mov r1, #1
	cmp r0, #0
	beq _020BC3F4
	cmp r0, #4
	movne r1, #0
_020BC3F4:
	cmp r1, #0
	mvneq r0, #0x1b
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrsb r0, [r4, #0x72]
	cmp r0, #1
	moveq r0, #0
	mvnne r0, #5
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20BC384

	arm_func_start sub_20BC41C
sub_20BC41C: // 0x020BC41C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r4, [r7, #4]
	mov r5, #0
	ldr r6, [r4, #0x64]
	add r0, r6, #0xe0
	bl OS_LockMutex
	ldrh r0, [r7, #0x10]
	ldrh r1, [r7, #0x12]
	ldr r2, [r7, #0x14]
	bl sub_20C0BD4
	mov r0, r5
	str r0, [r6, #0xf8]
	ldrsb r0, [r7, #0xc]
	cmp r0, #0
	beq _020BC468
	cmp r0, #4
	bne _020BC470
_020BC468:
	bl sub_20C0990
	mov r5, r0
_020BC470:
	add r0, r6, #0xe0
	bl OS_UnlockMutex
	cmp r5, #0
	ldrnesh r1, [r4, #0x70]
	mvnne r0, #0x4b
	moveq r0, #0
	orrne r1, r1, #0x40
	strneh r1, [r4, #0x70]
	ldreqsh r1, [r4, #0x70]
	orreq r1, r1, #4
	streqh r1, [r4, #0x70]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20BC41C

	arm_func_start sub_20BC4A8
sub_20BC4A8: // 0x020BC4A8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrsb r2, [r4, #0x72]
	ldr r0, _020BC504 // =sub_20BC41C
	mov r1, r4
	bl sub_20BBBF0
	movs r1, r0
	mvneq r0, #0x20
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrh r2, [r4, #0x74]
	mov r0, r4
	strh r2, [r1, #0x10]
	ldrh r2, [r4, #0x76]
	strh r2, [r1, #0x12]
	ldr r2, [r4, #0x78]
	str r2, [r1, #0x14]
	ldrsh r2, [r4, #0x70]
	orr r2, r2, #2
	strh r2, [r4, #0x70]
	bl sub_20BBAB0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BC504: .word sub_20BC41C
	arm_func_end sub_20BC4A8

	arm_func_start sub_20BC508
sub_20BC508: // 0x020BC508
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl sub_20BE100
	cmp r0, #0
	bne _020BC530
	ldrsh r0, [r6, #0x70]
	ands r0, r0, #8
	beq _020BC53C
_020BC530:
	mvn r0, #0x1b
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020BC53C:
	cmp r6, #0
	mov r1, #0
	beq _020BC554
	ldrsh r0, [r6, #0x70]
	ands r0, r0, #1
	movne r1, #1
_020BC554:
	cmp r1, #0
	mvneq r0, #0x26
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldrsb r0, [r6, #0x73]
	mov r1, #1
	cmp r0, #0
	beq _020BC57C
	cmp r0, #4
	movne r1, #0
_020BC57C:
	cmp r1, #0
	beq _020BC5F4
	ldrsh r0, [r6, #0x70]
	ands r0, r0, #4
	beq _020BC5A8
	ldrsb r0, [r6, #0x72]
	cmp r0, #1
	mvneq r0, #0x1d
	movne r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020BC5A8:
	ldrsh r0, [r6, #0x70]
	ands r0, r0, #2
	beq _020BC5D0
	ldrsh r0, [r6, #0x70]
	ands r0, r0, #0x40
	ldrne r0, [r6, #0x6c]
	ldreq r0, _020BC608 // =_0211F164
	ldreq r0, [r0]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020BC5D0:
	strh r5, [r6, #0x76]
	mov r0, r6
	str r4, [r6, #0x78]
	bl sub_20BC4A8
	ldrsb r1, [r6, #0x72]
	cmp r1, #1
	mvnne r0, #0x19
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020BC5F4:
	strh r5, [r6, #0x76]
	str r4, [r6, #0x78]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020BC608: .word _0211F164
	arm_func_end sub_20BC508

	arm_func_start sub_20BC60C
sub_20BC60C: // 0x020BC60C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r5, r1
	bl sub_20BE100
	cmp r0, #0
	addne sp, sp, #4
	mvnne r0, #0x1b
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	cmp r4, #0
	mov r1, #0
	beq _020BC64C
	ldrsh r0, [r4, #0x70]
	ands r0, r0, #1
	movne r1, #1
_020BC64C:
	cmp r1, #0
	addeq sp, sp, #4
	mvneq r0, #0x26
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldrsh r0, [r4, #0x70]
	ands r0, r0, #2
	addne sp, sp, #4
	mvnne r0, #6
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	strh r5, [r4, #0x74]
	ldrsb r0, [r4, #0x73]
	cmp r0, #1
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	mov r0, r4
	bl sub_20BC4A8
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20BC60C

	arm_func_start sub_20BC6A8
sub_20BC6A8: // 0x020BC6A8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r7, r2
	ldr r6, [r7, #0x64]
	mov r9, r0
	mov r8, r1
	bl OS_DisableInterrupts
	add r1, r6, #0x100
	ldrh r2, [r1, #8]
	ldrh r1, [r1, #0xa]
	mov r4, r0
	add r0, r2, r8
	cmp r1, r0
	blo _020BC770
	ldr r1, _020BC7C0 // =_02145638
	add r0, r8, #0xc
	ldr r1, [r1]
	ldr r1, [r1, #0x18]
	blx r1
	movs r5, r0
	beq _020BC75C
	add r1, r6, #0x100
	ldrh r3, [r1, #8]
	mov r2, #0
	mov r0, r9
	add r3, r3, r8
	strh r3, [r1, #8]
	str r2, [r5]
	strh r8, [r5, #4]
	ldrh r3, [r7, #0x18]
	mov r2, r8
	add r1, r5, #0xc
	strh r3, [r5, #6]
	ldr r3, [r7, #0x1c]
	str r3, [r5, #8]
	bl MI_CpuCopy8
	ldr r0, [r6, #0x100]
	cmp r0, #0
	ldrne r0, [r6, #0x100]
	strne r5, [r0]
	str r5, [r6, #0x100]
	ldr r0, [r6, #0x104]
	cmp r0, #0
	streq r5, [r6, #0x104]
	b _020BC780
_020BC75C:
	ldr r0, _020BC7C4 // =0x021456A0
	ldr r1, [r0]
	add r1, r1, #1
	str r1, [r0]
	b _020BC780
_020BC770:
	ldr r0, _020BC7C4 // =0x021456A0
	ldr r1, [r0, #4]
	add r1, r1, #1
	str r1, [r0, #4]
_020BC780:
	ldrh r0, [r7, #0x74]
	cmp r0, #0
	ldreqh r0, [r7, #0xa]
	streqh r0, [r7, #0x74]
	ldrh r1, [r7, #0x1a]
	add r0, r6, #0x10c
	strh r1, [r7, #0x18]
	ldr r1, [r7, #0x20]
	str r1, [r7, #0x1c]
	bl OS_WakeupThread
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020BC7C0: .word _02145638
_020BC7C4: .word 0x021456A0
	arm_func_end sub_20BC6A8

	arm_func_start sub_20BC7C8
sub_20BC7C8: // 0x020BC7C8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r10, r0
	ldr r9, [r10, #0x64]
	str r1, [sp]
	ldr r0, [r9, #0x104]
	str r2, [sp, #4]
	str r3, [sp, #8]
	bl OS_DisableInterrupts
	ldr r8, [r9, #0x104]
	str r0, [sp, #0xc]
	cmp r8, #0
	bne _020BC868
	ldr r0, [sp, #0x3c]
	and r7, r0, #1
	add r6, r9, #0x10c
	mov r4, #1
	mov r5, #0
_020BC810:
	cmp r7, #0
	mvneq r11, #5
	beq _020BC868
	mov r0, r6
	bl OS_SleepThread
	mov r0, r10
	bl sub_20BE100
	cmp r0, #0
	bne _020BC854
	mov r1, r5
	cmp r10, #0
	beq _020BC84C
	ldrsh r0, [r10, #0x70]
	ands r0, r0, #1
	movne r1, r4
_020BC84C:
	cmp r1, #0
	bne _020BC85C
_020BC854:
	mvn r11, #0x37
	b _020BC868
_020BC85C:
	ldr r8, [r9, #0x104]
	cmp r8, #0
	beq _020BC810
_020BC868:
	cmp r8, #0
	beq _020BC8FC
	ldrh r1, [r8, #4]
	ldr r0, [sp, #4]
	cmp r0, r1
	strgt r1, [sp, #4]
	ldr r1, [sp]
	ldr r2, [sp, #4]
	add r0, r8, #0xc
	bl MI_CpuCopy8
	ldr r0, [sp, #8]
	cmp r0, #0
	ldrneh r1, [r8, #6]
	strneh r1, [r0]
	ldr r1, [sp, #0x38]
	cmp r1, #0
	ldrne r0, [r8, #8]
	strne r0, [r1]
	ldrsb r0, [r9, #0xfe]
	ldrh r11, [r8, #4]
	cmp r0, #0
	bne _020BC8FC
	ldr r0, [r8]
	ldr r1, _020BC914 // =_02145638
	str r0, [r9, #0x104]
	ldr r0, [r8]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r9, #0x100]
	ldr r1, [r1]
	mov r0, r8
	ldr r1, [r1, #0x1c]
	blx r1
	add r0, r9, #0x100
	ldrh r1, [r0, #8]
	sub r1, r1, r11
	strh r1, [r0, #8]
_020BC8FC:
	ldr r0, [sp, #0xc]
	bl OS_RestoreInterrupts
	mov r0, r11
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020BC914: .word _02145638
	arm_func_end sub_20BC7C8

	arm_func_start sub_20BC918
sub_20BC918: // 0x020BC918
	stmdb sp!, {r4, r5, r6, lr}
	ldr r6, [r0, #0x64]
	bl OS_DisableInterrupts
	ldr r4, [r6, #0xf8]
	mov r5, r0
	cmp r4, #0
	beq _020BC944
	mov r1, #0
	mov r0, r4
	str r1, [r6, #0xf8]
	bl sub_20C0588
_020BC944:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20BC918

	arm_func_start sub_20BC958
sub_20BC958: // 0x020BC958
	ldr ip, _020BC964 // =sub_20BC918
	ldr r0, [r0, #4]
	bx ip
	.align 2, 0
_020BC964: .word sub_20BC918
	arm_func_end sub_20BC958

	arm_func_start sub_20BC968
sub_20BC968: // 0x020BC968
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x64]
	ldrh r0, [r1, #0xfc]
	ldr r1, [r1, #0xf8]
	cmp r1, r0
	movlt r0, #0
	ldmltia sp!, {r4, lr}
	bxlt lr
	ldr r0, _020BC9BC // =sub_20BC958
	mov r1, r4
	mov r2, #0
	bl sub_20BBBF0
	movs r1, r0
	mvneq r0, #0x20
	ldmeqia sp!, {r4, lr}
	bxeq lr
	mov r0, r4
	bl sub_20BBAB0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BC9BC: .word sub_20BC958
	arm_func_end sub_20BC968

	arm_func_start sub_20BC9C0
sub_20BC9C0: // 0x020BC9C0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	ldr r9, [r0, #4]
	ldr r1, [r0, #0x10]
	ldr r8, [r9, #0x64]
	str r1, [sp, #4]
	ldr r1, [r0, #0x18]
	ldr r10, [r0, #0x14]
	ldr r0, [r0, #0x1c]
	ldr r7, [r8, #0xf8]
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	add r11, sp, #0x10
	mov r5, #0
	mov r6, #1
	mov r4, #0xa
_020BCA00:
	mov r0, r11
	bl sub_20C0694
	cmp r0, #0
	beq _020BCA5C
	ldr r1, [sp, #0x10]
	sub r1, r1, r7
	cmp r1, #0
	bgt _020BCA5C
	ldrsb r0, [r9, #0x73]
	mov r1, r6
	cmp r0, #0
	beq _020BCA38
	cmp r0, #4
	movne r1, r5
_020BCA38:
	cmp r1, #0
	beq _020BCA50
	ldrb r0, [r9, #8]
	cmp r0, #4
	movne r0, #0
	bne _020BCA5C
_020BCA50:
	mov r0, r4
	bl OS_Sleep
	b _020BCA00
_020BCA5C:
	ldrsb r1, [r9, #0x73]
	cmp r1, #4
	bne _020BCAAC
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldr r1, [sp, #0x10]
	cmp r10, r1
	movhi r10, r1
	ldr r1, [sp, #4]
	mov r2, r10
	bl MI_CpuCopy8
	mov r0, r10
	bl sub_20C0588
	add sp, sp, #0x14
	mov r0, r10
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020BCAAC:
	cmp r0, #0
	moveq r4, #0
	beq _020BCAD8
	ldr r4, [sp, #0xc]
	ldr r1, [sp, #4]
	ldr r3, [sp, #8]
	mov r0, r9
	mov r2, r10
	str r4, [sp]
	bl sub_20BCBFC
	mov r4, r0
_020BCAD8:
	cmp r4, #0
	addle sp, sp, #0x14
	movle r0, r4
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxle lr
	ldrh r0, [r8, #0xfc]
	ldr r1, [r8, #0xf8]
	cmp r1, r0
	blt _020BCB04
	mov r0, r9
	bl sub_20BC918
_020BCB04:
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end sub_20BC9C0

	arm_func_start sub_20BCB14
sub_20BCB14: // 0x020BCB14
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	ldr r0, _020BCB68 // =sub_20BC9C0
	mov r1, r7
	mov r2, #1
	mov r4, r3
	bl sub_20BBBF0
	mov r1, r0
	str r6, [r1, #0x10]
	str r5, [r1, #0x14]
	ldr r2, [sp, #0x18]
	str r4, [r1, #0x18]
	mov r0, r7
	str r2, [r1, #0x1c]
	bl sub_20BBAB0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020BCB68: .word sub_20BC9C0
	arm_func_end sub_20BCB14

	arm_func_start sub_20BCB6C
sub_20BCB6C: // 0x020BCB6C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, [r0, #0x64]
	ldr r5, [r0, #0xc4]
	ldr r4, [r0, #0xf8]
	ldr r0, [r5, #0x44]
	subs lr, r0, r4
	bmi _020BCBD0
	ldrh ip, [r5, #0xa]
	ldr r0, [sp, #0x10]
	cmp lr, #0
	strh ip, [r2]
	ldrh r2, [r5, #0x18]
	strh r2, [r3]
	ldr r2, [r5, #0x1c]
	str r2, [r0]
	str lr, [r1]
	bne _020BCBE8
	ldrb r0, [r5, #8]
	cmp r0, #4
	beq _020BCBE8
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020BCBD0:
	mvn r0, #0
	str r0, [r1]
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020BCBE8:
	ldr r0, [r5, #0x40]
	add r0, r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20BCB6C

	arm_func_start sub_20BCBFC
sub_20BCBFC: // 0x020BCBFC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x14
	mov r9, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	bl OS_DisableInterrupts
	add r1, sp, #0xc
	mov r5, r0
	str r1, [sp]
	add r1, sp, #8
	mov r0, r9
	add r2, sp, #4
	add r3, sp, #6
	bl sub_20BCB6C
	cmp r0, #0
	beq _020BCCA0
	ldr r4, [sp, #8]
	cmp r4, #0
	mvneq r4, #5
	beq _020BCCBC
	ldrsb r1, [r9, #0x73]
	cmp r7, r4
	movgt r7, r4
	mov r2, #1
	cmp r1, #0
	beq _020BCC70
	cmp r1, #4
	movne r2, #0
_020BCC70:
	cmp r2, #0
	mov r1, r8
	mov r2, r7
	movne r4, r7
	bl MI_CpuCopy8
	ldr r1, [r9, #0x64]
	ldrsb r0, [r1, #0xfe]
	cmp r0, #0
	ldreq r0, [r1, #0xf8]
	addeq r0, r0, r4
	streq r0, [r1, #0xf8]
	b _020BCCBC
_020BCCA0:
	ldr r0, [sp, #8]
	cmp r0, #0
	ldrsh r0, [r9, #0x70]
	moveq r4, #0
	mvnne r4, #0x1b
	bic r0, r0, #6
	strh r0, [r9, #0x70]
_020BCCBC:
	cmp r4, #0
	blt _020BCCF4
	cmp r6, #0
	beq _020BCCE4
	ldr r1, [sp, #0x30]
	cmp r1, #0
	ldrneh r0, [sp, #6]
	strneh r0, [r6]
	ldrne r0, [sp, #0xc]
	strne r0, [r1]
_020BCCE4:
	ldrh r0, [r9, #0x74]
	cmp r0, #0
	ldreqh r0, [sp, #4]
	streqh r0, [r9, #0x74]
_020BCCF4:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20BCBFC

	arm_func_start sub_20BCD0C
sub_20BCD0C: // 0x020BCD0C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldrsb ip, [r7, #0x73]
	mov r6, r1
	mov r5, r2
	mov r4, r3
	cmp ip, #4
	bne _020BCD48
	ldr r4, [sp, #0x18]
	str r4, [sp]
	bl sub_20BCB14
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020BCD48:
	ldr ip, [sp, #0x18]
	str ip, [sp]
	bl sub_20BCBFC
	mvn r1, #5
	cmp r0, r1
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldr r1, [sp, #0x1c]
	ands r1, r1, #1
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr ip, [sp, #0x18]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str ip, [sp]
	bl sub_20BCB14
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20BCD0C

	arm_func_start sub_20BCDA4
sub_20BCDA4: // 0x020BCDA4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r5, [sp, #0x28]
	mov r7, r0
	ands r0, r5, #2
	ldr r5, [r7, #0x64]
	beq _020BCDCC
	cmp r5, #0
	movne r6, #1
	bne _020BCDD0
_020BCDCC:
	mov r6, #0
_020BCDD0:
	cmp r6, #0
	ldrnesb r4, [r5, #0xfe]
	movne r0, #1
	strneb r0, [r5, #0xfe]
	ldrsb r0, [r7, #0x73]
	cmp r0, #1
	bne _020BCE0C
	ldr r0, [sp, #0x20]
	ldr ip, [sp, #0x24]
	str r0, [sp]
	mov r0, r7
	str ip, [sp, #4]
	bl sub_20BC7C8
	mov r8, r0
	b _020BCE34
_020BCE0C:
	ldr r0, [sp, #0x20]
	ldr ip, [sp, #0x24]
	str r0, [sp]
	mov r0, r7
	str ip, [sp, #4]
	bl sub_20BCD0C
	movs r8, r0
	bmi _020BCE34
	mov r0, r7
	bl sub_20BC968
_020BCE34:
	cmp r6, #0
	strneb r4, [r5, #0xfe]
	mov r0, r8
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20BCDA4

	arm_func_start sub_20BCE4C
sub_20BCE4C: // 0x020BCE4C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r9, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	bl sub_20BE100
	cmp r0, #0
	addne sp, sp, #0xc
	mvnne r0, #0x1b
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	ldr r0, [sp, #0x2c]
	ands r0, r0, #4
	bne _020BCE94
	ldrsb r0, [r9, #0x72]
	cmp r0, #0
	bne _020BCEB4
_020BCE94:
	ldrsb r0, [r9, #0x73]
	cmp r0, #4
	addeq sp, sp, #0xc
	mvneq r0, #0x1b
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	mov r4, #0
	b _020BCED0
_020BCEB4:
	bl OS_GetProcMode
	cmp r0, #0x12
	addeq sp, sp, #0xc
	mvneq r0, #0x1b
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	mov r4, #1
_020BCED0:
	cmp r9, #0
	mov r1, #0
	beq _020BCEE8
	ldrsh r0, [r9, #0x70]
	ands r0, r0, #1
	movne r1, #1
_020BCEE8:
	cmp r1, #0
	addeq sp, sp, #0xc
	mvneq r0, #0x26
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	ldrsb r0, [r9, #0x73]
	mov r1, #1
	cmp r0, #0
	beq _020BCF14
	cmp r0, #4
	movne r1, #0
_020BCF14:
	cmp r1, #0
	beq _020BCF44
	ldrsh r0, [r9, #0x70]
	ands r0, r0, #4
	beq _020BCF34
	ldrsh r0, [r9, #0x70]
	ands r0, r0, #8
	beq _020BCF44
_020BCF34:
	add sp, sp, #0xc
	mvn r0, #0x37
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020BCF44:
	ands r0, r4, #1
	ldr r5, [r9, #0x64]
	bne _020BCF70
	add r0, r5, #0xe0
	bl OS_TryLockMutex
	cmp r0, #0
	bne _020BCF78
	add sp, sp, #0xc
	mvn r0, #5
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020BCF70:
	add r0, r5, #0xe0
	bl OS_LockMutex
_020BCF78:
	ldr r0, [sp, #0x28]
	ldr ip, [sp, #0x2c]
	str r0, [sp]
	str r4, [sp, #4]
	mov r0, r9
	mov r1, r8
	mov r2, r7
	mov r3, r6
	str ip, [sp, #8]
	bl sub_20BCDA4
	mov r4, r0
	add r0, r5, #0xe0
	bl OS_UnlockMutex
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20BCE4C

	arm_func_start sub_20BCFBC
sub_20BCFBC: // 0x020BCFBC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r2
	ldr r5, [r6, #0x14]
	ldr r4, [r6, #0x1c]
	cmp r5, r1
	mov r7, r0
	movgt r5, r1
	movgt r4, #0
	bgt _020BCFF0
	sub r0, r1, r5
	cmp r4, r0
	movgt r4, r0
_020BCFF0:
	cmp r5, #0
	ble _020BD020
	ldr r0, [r6, #0x10]
	mov r1, r7
	mov r2, r5
	bl MI_CpuCopy8
	ldr r0, [r6, #0x10]
	add r0, r0, r5
	str r0, [r6, #0x10]
	ldr r0, [r6, #0x14]
	sub r0, r0, r5
	str r0, [r6, #0x14]
_020BD020:
	cmp r4, #0
	ble _020BD050
	ldr r0, [r6, #0x18]
	mov r2, r4
	add r1, r7, r5
	bl MI_CpuCopy8
	ldr r0, [r6, #0x18]
	add r0, r0, r4
	str r0, [r6, #0x18]
	ldr r0, [r6, #0x1c]
	sub r0, r0, r4
	str r0, [r6, #0x1c]
_020BD050:
	add r0, r5, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20BCFBC

	arm_func_start sub_20BD060
sub_20BD060: // 0x020BD060
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _020BD114 // =OSi_ThreadInfo
	mov r4, r0
	ldr r0, [r1, #4]
	ldr r5, [r0, #0xa4]
	bl OS_DisableInterrupts
	cmp r5, #0
	beq _020BD0CC
	ldrh r3, [r5, #0x2e]
	cmp r3, #0
	beq _020BD0BC
	ldrh r2, [r5, #0x2c]
	cmp r2, #0
	beq _020BD0BC
	ldr r1, _020BD118 // =0x0214564C
	cmp r3, r2
	ldr r1, [r1, #0x24]
	movgt r3, r2
	cmp r3, r1
	movgt r3, r1
	mov r5, r3, lsl #1
	b _020BD0D8
_020BD0BC:
	ldr r1, _020BD118 // =0x0214564C
	ldr r1, [r1, #0x24]
	mov r5, r1, lsl #1
	b _020BD0D8
_020BD0CC:
	ldr r1, _020BD118 // =0x0214564C
	ldr r1, [r1, #0x24]
	mov r5, r1, lsl #1
_020BD0D8:
	bl OS_RestoreInterrupts
	cmp r5, #0
	ble _020BD104
	mov r0, r4
	mov r1, r5
	bl _s32_div_f
	cmp r0, #0
	mulgt r0, r5, r0
	addgt sp, sp, #4
	ldmgtia sp!, {r4, r5, lr}
	bxgt lr
_020BD104:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020BD114: .word OSi_ThreadInfo
_020BD118: .word 0x0214564C
	arm_func_end sub_20BD060

	arm_func_start sub_20BD11C
sub_20BD11C: // 0x020BD11C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	ldr r7, [r8, #4]
	mov r4, #0
	ldrsb r0, [r7, #0x73]
	ldr r6, [r7, #0x68]
	mov r1, #1
	cmp r0, #0
	beq _020BD14C
	cmp r0, #4
	movne r1, r4
_020BD14C:
	cmp r1, #0
	beq _020BD160
	ldrsh r0, [r7, #0x70]
	ands r0, r0, #4
	beq _020BD234
_020BD160:
	ldr r2, [r8, #0x28]
	cmp r2, #0
	beq _020BD178
	ldrh r0, [r8, #0x24]
	ldrh r1, [r8, #0x26]
	bl sub_20C0BD4
_020BD178:
	ldrsb r1, [r7, #0x73]
	mov r0, #1
	cmp r1, #0
	beq _020BD190
	cmp r1, #4
	movne r0, #0
_020BD190:
	cmp r0, #0
	movne r2, #0x36
	moveq r2, #0x2a
	ldr r0, [r7, #0x4c]
	cmp r1, #0
	add r5, r0, r2
	beq _020BD1B4
	cmp r1, #4
	bne _020BD1C8
_020BD1B4:
	ldr r0, [r7, #0x48]
	sub r0, r0, r2
	bl sub_20BD060
	mov r9, r0
	b _020BD1D0
_020BD1C8:
	ldr r0, [r7, #0x48]
	sub r9, r0, r2
_020BD1D0:
	mov r0, r5
	mov r1, r9
	mov r2, r8
	bl sub_20BCFBC
	mov r1, r0
	cmp r1, #0
	ble _020BD238
	mov r0, r5
	bl sub_20C008C
	cmp r0, #0
	bgt _020BD22C
	ldrsb r0, [r7, #0x73]
	mov r1, #1
	cmp r0, #0
	beq _020BD214
	cmp r0, #4
	movne r1, #0
_020BD214:
	cmp r1, #0
	ldrnesh r0, [r7, #0x70]
	mvn r4, #0x4b
	bicne r0, r0, #0xe
	strneh r0, [r7, #0x70]
	b _020BD238
_020BD22C:
	add r4, r4, r0
	b _020BD1D0
_020BD234:
	mvn r4, #0x4b
_020BD238:
	ldrh r2, [r8, #0x20]
	add r1, r6, #0x100
	add r0, r6, #0x104
	strh r2, [r1, #2]
	bl OS_WakeupThread
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20BD11C

	arm_func_start sub_20BD25C
sub_20BD25C: // 0x020BD25C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r6, [r9, #0x68]
	mov r4, r1
	mov r8, r2
	ldr r1, [r6, #0x10c]
	ldr r2, [sp, #0x28]
	ldr r0, _020BD3F4 // =sub_20BD11C
	mov r7, r3
	bl sub_20BBBF0
	movs r5, r0
	addeq sp, sp, #4
	mvneq r0, #0x20
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	ldr r0, [sp, #0x28]
	ands r0, r0, #1
	beq _020BD2BC
	ldrsb r0, [r9, #0x73]
	cmp r0, #1
	movne r0, #3
	strneb r0, [r5, #0xd]
	bne _020BD2C4
_020BD2BC:
	mov r0, #0
	strb r0, [r5, #0xd]
_020BD2C4:
	ldr r2, [r6, #0xf8]
	add r1, r7, r8
	cmp r1, r2
	ldr r3, [r6, #0xfc]
	bge _020BD2F8
	add r0, r3, r7
	str r0, [r5, #0x10]
	str r8, [r5, #0x14]
	mov r0, #0
	str r0, [r5, #0x18]
	mov r7, r1
	str r0, [r5, #0x1c]
	b _020BD330
_020BD2F8:
	add r0, r3, r7
	str r0, [r5, #0x10]
	sub r0, r2, r7
	str r0, [r5, #0x14]
	str r3, [r5, #0x18]
	ldr r0, [r5, #0x14]
	sub r0, r8, r0
	str r0, [r5, #0x1c]
	ldr r7, [r5, #0x1c]
	ldr r0, [r5, #0x14]
	ldr r1, [r5, #0x18]
	mov r2, r7
	add r0, r4, r0
	bl MI_CpuCopy8
_020BD330:
	ldr r1, [r5, #0x10]
	ldr r2, [r5, #0x14]
	mov r0, r4
	bl MI_CpuCopy8
	add r0, r6, #0x100
	ldrh r4, [r0]
	strh r7, [r5, #0x20]
	ldrh r1, [r5, #0x20]
	strh r1, [r0]
	ldrsb r0, [r9, #0x73]
	cmp r0, #1
	bne _020BD3C0
	ldrh r0, [r9, #0x74]
	cmp r0, #0
	bne _020BD37C
	bl sub_20C0CE8
	strh r0, [r9, #0x74]
	ldrh r0, [r9, #0x74]
	strh r0, [r9, #0xa]
_020BD37C:
	ldrh r0, [r9, #0x74]
	strh r0, [r5, #0x24]
	ldr r1, [r9, #0x78]
	cmp r1, #0
	beq _020BD39C
	ldr r0, [sp, #0x24]
	cmp r0, #0
	beq _020BD3B0
_020BD39C:
	ldr r1, [sp, #0x24]
	ldrh r0, [sp, #0x20]
	str r1, [r5, #0x28]
	strh r0, [r5, #0x26]
	b _020BD3C8
_020BD3B0:
	str r1, [r5, #0x28]
	ldrh r0, [r9, #0x76]
	strh r0, [r5, #0x26]
	b _020BD3C8
_020BD3C0:
	mov r0, #0
	str r0, [r5, #0x28]
_020BD3C8:
	ldr r0, [r6, #0x10c]
	mov r1, r5
	bl sub_20BBAA0
	cmp r0, #0
	addne r0, r6, #0x100
	movne r8, #0
	strneh r4, [r0]
	mov r0, r8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020BD3F4: .word sub_20BD11C
	arm_func_end sub_20BD25C

	arm_func_start sub_20BD3F8
sub_20BD3F8: // 0x020BD3F8
	ldr r2, [r0, #0x68]
	add r0, r2, #0x100
	ldrh r1, [r0]
	ldrh r0, [r0, #2]
	ldr r2, [r2, #0xf8]
	sub r0, r0, r1
	subs r0, r0, #1
	addmi r0, r0, r2
	bx lr
	arm_func_end sub_20BD3F8

	arm_func_start sub_20BD41C
sub_20BD41C: // 0x020BD41C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	mov r8, r2
	cmp r8, r9
	mov r11, r3
	ldr r7, [r10, #0x68]
	movgt r8, r9
	bl OS_DisableInterrupts
	ldr r1, [sp, #0x28]
	str r0, [sp]
	and r5, r1, #1
	add r4, r7, #0x104
_020BD454:
	mov r0, r10
	bl sub_20BD3F8
	mov r6, r0
	cmp r6, r8
	blt _020BD480
	add r0, r7, #0x100
	ldrh r0, [r0]
	cmp r6, r9
	movge r6, r9
	str r0, [r11]
	b _020BD498
_020BD480:
	cmp r5, #0
	moveq r6, #0
	beq _020BD498
	mov r0, r4
	bl OS_SleepThread
	b _020BD454
_020BD498:
	ldr r0, [sp]
	bl OS_RestoreInterrupts
	mov r0, r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end sub_20BD41C

	arm_func_start sub_20BD4B0
sub_20BD4B0: // 0x020BD4B0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	ldr r4, [r10, #0x68]
	ldrsb r0, [r10, #0x73]
	ldr r4, [r4, #0x10c]
	mov r9, r1
	cmp r0, #1
	ldr r0, [r4, #0x48]
	mov r8, r2
	str r3, [sp, #0xc]
	ldr r7, [sp, #0x40]
	ldr r6, [sp, #0x44]
	mov r4, #0
	bne _020BD50C
	sub r0, r0, #0x2a
	cmp r8, r0
	addgt sp, sp, #0x1c
	mvngt r0, #0x22
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxgt lr
	str r8, [sp, #0x10]
	b _020BD51C
_020BD50C:
	sub r0, r0, #0x36
	str r0, [sp, #0x10]
	cmp r8, r0
	strle r8, [sp, #0x10]
_020BD51C:
	cmp r8, #0
	ble _020BD5B8
	and r11, r6, #1
_020BD528:
	ldr r2, [sp, #0x10]
	mov r0, r10
	mov r1, r8
	add r3, sp, #0x14
	str r6, [sp]
	bl sub_20BD41C
	mov r5, r0
	cmp r5, #0
	ble _020BD590
	ldr r0, [sp, #0xc]
	mov r1, r9
	str r0, [sp]
	str r7, [sp, #4]
	str r6, [sp, #8]
	ldr r3, [sp, #0x14]
	mov r0, r10
	mov r2, r5
	bl sub_20BD25C
	cmp r0, #0
	addle sp, sp, #0x1c
	mvnle r0, #5
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxle lr
	add r9, r9, r5
	sub r8, r8, r5
	add r4, r4, r5
_020BD590:
	cmp r11, #0
	bne _020BD5B0
	cmp r5, #0
	bgt _020BD5B8
	add sp, sp, #0x1c
	mvn r0, #5
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020BD5B0:
	cmp r8, #0
	bgt _020BD528
_020BD5B8:
	mov r0, r4
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end sub_20BD4B0

	arm_func_start sub_20BD5C8
sub_20BD5C8: // 0x020BD5C8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	bl sub_20BE100
	cmp r0, #0
	addne sp, sp, #8
	mvnne r0, #0x1b
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	cmp r8, #0
	mov r1, #0
	beq _020BD610
	ldrsh r0, [r8, #0x70]
	ands r0, r0, #1
	movne r1, #1
_020BD610:
	cmp r1, #0
	addeq sp, sp, #8
	mvneq r0, #0x26
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldrsb r0, [r8, #0x73]
	mov r1, #1
	cmp r0, #0
	beq _020BD63C
	cmp r0, #4
	movne r1, #0
_020BD63C:
	cmp r1, #0
	beq _020BD66C
	ldrsh r0, [r8, #0x70]
	ands r0, r0, #4
	beq _020BD65C
	ldrsh r0, [r8, #0x70]
	ands r0, r0, #8
	beq _020BD66C
_020BD65C:
	add sp, sp, #8
	mvn r0, #0x37
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020BD66C:
	ldr r0, [sp, #0x24]
	ldr r4, [r8, #0x68]
	ands r0, r0, #4
	bne _020BD688
	ldrsb r0, [r8, #0x72]
	cmp r0, #0
	bne _020BD6AC
_020BD688:
	add r0, r4, #0xe0
	bl OS_TryLockMutex
	cmp r0, #0
	addeq sp, sp, #8
	mvneq r0, #5
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	mov ip, #0
	b _020BD6B8
_020BD6AC:
	add r0, r4, #0xe0
	bl OS_LockMutex
	mov ip, #1
_020BD6B8:
	ldr r1, [sp, #0x20]
	mov r0, r8
	str r1, [sp]
	mov r1, r7
	mov r2, r6
	mov r3, r5
	str ip, [sp, #4]
	bl sub_20BD4B0
	mov r5, r0
	add r0, r4, #0xe0
	bl OS_UnlockMutex
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20BD5C8

	arm_func_start sub_20BD6F4
sub_20BD6F4: // 0x020BD6F4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0, #4]
	mov r1, #1
	ldrsb r0, [r0, #0x73]
	cmp r0, #0
	beq _020BD718
	cmp r0, #4
	movne r1, #0
_020BD718:
	cmp r1, #0
	beq _020BD724
	bl sub_20C089C
_020BD724:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20BD6F4

	arm_func_start sub_20BD734
sub_20BD734: // 0x020BD734
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl sub_20BE100
	cmp r0, #0
	addne sp, sp, #4
	mvnne r0, #0x1b
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	cmp r4, #0
	mov r1, #0
	beq _020BD770
	ldrsh r0, [r4, #0x70]
	ands r0, r0, #1
	movne r1, #1
_020BD770:
	cmp r1, #0
	addeq sp, sp, #4
	mvneq r0, #0x26
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldrsh r0, [r4, #0x70]
	ands r0, r0, #4
	beq _020BD79C
	ldrsh r0, [r4, #0x70]
	ands r0, r0, #8
	beq _020BD7AC
_020BD79C:
	add sp, sp, #4
	mvn r0, #0x37
	ldmia sp!, {r4, r5, lr}
	bx lr
_020BD7AC:
	ldrsh r0, [r4, #0x70]
	orr r0, r0, #8
	strh r0, [r4, #0x70]
	ldr r5, [r4, #0x68]
	cmp r5, #0
	beq _020BD804
	ldr r1, [r5, #0x10c]
	cmp r1, #0
	beq _020BD804
	ldrsb r2, [r4, #0x72]
	ldr r0, _020BD814 // =sub_20BD6F4
	bl sub_20BBBF0
	movs r1, r0
	addeq sp, sp, #4
	mvneq r0, #0x20
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r0, [r5, #0x10c]
	bl sub_20BBAA0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
_020BD804:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020BD814: .word sub_20BD6F4
	arm_func_end sub_20BD734

	arm_func_start sub_20BD818
sub_20BD818: // 0x020BD818
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	ldr r4, _020BD85C // =0x021456AC
	mov r5, r0
	ldr r0, [r4]
	cmp r0, #0
	beq _020BD848
_020BD838:
	bl sub_20BD910
	ldr r0, [r4]
	cmp r0, #0
	bne _020BD838
_020BD848:
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020BD85C: .word 0x021456AC
	arm_func_end sub_20BD818

	arm_func_start sub_20BD860
sub_20BD860: // 0x020BD860
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	movs r8, r0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	add r0, r8, #0x20
	bl OS_JoinThread
	bl OS_DisableInterrupts
	mov r7, r0
	bl OS_DisableScheduler
	add r1, sp, #0
	mov r0, r8
	mov r2, #0
	bl OS_ReceiveMessage
	cmp r0, #0
	beq _020BD8F4
	add r4, sp, #0
	mvn r6, #0xa
	mov r5, #0
_020BD8B0:
	ldr r0, [sp]
	cmp r0, #0
	beq _020BD8DC
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _020BD8D4
	mov r1, r6
	mov r2, r5
	bl OS_SendMessage
_020BD8D4:
	ldr r0, [sp]
	bl sub_20BBBBC
_020BD8DC:
	mov r0, r8
	mov r1, r4
	mov r2, r5
	bl OS_ReceiveMessage
	cmp r0, #0
	bne _020BD8B0
_020BD8F4:
	bl OS_EnableScheduler
	bl OS_RescheduleThread
	mov r0, r7
	bl OS_RestoreInterrupts
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20BD860

	arm_func_start sub_20BD910
sub_20BD910: // 0x020BD910
	stmdb sp!, {r4, r5, r6, lr}
	movs r4, r0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r0, #0
	strh r0, [r4, #0x70]
	ldrsb r1, [r4, #0x73]
	mov r2, #1
	cmp r1, #0
	beq _020BD940
	cmp r1, #4
	movne r2, r0
_020BD940:
	cmp r2, #0
	beq _020BD95C
	ldr r0, [r4, #0x68]
	bl sub_20BD860
	ldr r0, [r4, #0x64]
	bl sub_20BD860
	b _020BD9DC
_020BD95C:
	cmp r1, #1
	bne _020BD9CC
	ldr r0, [r4, #0x64]
	ldr r0, [r0, #0x104]
	cmp r0, #0
	beq _020BD994
	ldr r5, _020BDA18 // =_02145638
_020BD978:
	ldr r1, [r5]
	ldr r6, [r0]
	ldr r1, [r1, #0x1c]
	blx r1
	mov r0, r6
	cmp r6, #0
	bne _020BD978
_020BD994:
	ldr r0, [r4, #0x64]
	mov r1, #0
	add r0, r0, #0x100
	strh r1, [r0, #8]
	ldr r0, [r4, #0x64]
	str r1, [r0, #0x100]
	ldr r0, [r4, #0x64]
	str r1, [r0, #0x104]
	ldr r0, [r4, #0x64]
	add r0, r0, #0x10c
	bl OS_WakeupThread
	ldr r0, [r4, #0x64]
	bl sub_20BD860
	b _020BD9DC
_020BD9CC:
	cmp r1, #2
	bne _020BD9DC
	ldr r0, [r4, #0x68]
	bl sub_20BD860
_020BD9DC:
	bl OS_DisableInterrupts
	mov r5, r0
	mov r0, r4
	bl sub_20BE1AC
	mov r0, r4
	bl sub_20BE148
	ldr r1, _020BDA18 // =_02145638
	mov r0, r4
	ldr r1, [r1]
	ldr r1, [r1, #0x1c]
	blx r1
	mov r0, r5
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020BDA18: .word _02145638
	arm_func_end sub_20BD910

	arm_func_start sub_20BDA1C
sub_20BDA1C: // 0x020BDA1C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, [r0, #4]
	mov r1, #1
	ldrsb r0, [r4, #0x73]
	cmp r0, #0
	beq _020BDA40
	cmp r0, #4
	movne r1, #0
_020BDA40:
	cmp r1, #0
	beq _020BDA60
	ldr r0, [r4, #0x68]
	add r0, r0, #0x20
	bl OS_JoinThread
	bl sub_20C089C
	bl sub_20C0808
	bl sub_20C0B80
_020BDA60:
	bl sub_20C0C6C
	ldrsh r0, [r4, #0x70]
	mov r1, #0
	bic r0, r0, #6
	strh r0, [r4, #0x70]
	ldrsb r0, [r4, #0x73]
	cmp r0, #2
	ldreq r0, [r4, #0x68]
	ldrne r0, [r4, #0x64]
	bl sub_20BBB50
	bl OS_DisableInterrupts
	mov r5, r0
	mov r0, r4
	bl sub_20BE1AC
	mov r0, r4
	bl sub_20BE1C4
	mov r0, r5
	bl OS_RestoreInterrupts
	ldrsh r1, [r4, #0x70]
	mov r0, #0
	orr r1, r1, #0x20
	strh r1, [r4, #0x70]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20BDA1C

	arm_func_start sub_20BDAC4
sub_20BDAC4: // 0x020BDAC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r4, #0
	mvnle r0, #0x1b
	ldmleia sp!, {r4, lr}
	bxle lr
	bl sub_20BE0D0
	cmp r0, #0
	mvnne r0, #0x19
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r0, r4
	bl sub_20BE100
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	cmp r4, #0
	mov r1, #0
	beq _020BDB20
	ldrsh r0, [r4, #0x70]
	ands r0, r0, #1
	movne r1, #1
_020BDB20:
	cmp r1, #0
	mvneq r0, #0x26
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrsh r0, [r4, #0x70]
	ands r0, r0, #0x10
	mvnne r0, #0x19
	ldmneia sp!, {r4, lr}
	bxne lr
	ldrsh r0, [r4, #0x70]
	mov r1, #1
	orr r0, r0, #0x18
	strh r0, [r4, #0x70]
	ldrsb r0, [r4, #0x73]
	cmp r0, #0
	beq _020BDB68
	cmp r0, #4
	movne r1, #0
_020BDB68:
	cmp r1, #0
	beq _020BDB7C
	ldr r0, [r4, #0x68]
	mov r1, #0
	bl sub_20BBB50
_020BDB7C:
	ldr r0, _020BDBAC // =sub_20BDA1C
	mov r1, r4
	mov r2, #1
	bl sub_20BBBF0
	mov r1, r0
	mov r2, #0
	mov r0, r4
	str r2, [r1, #8]
	bl sub_20BBB34
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BDBAC: .word sub_20BDA1C
	arm_func_end sub_20BDAC4

	arm_func_start sub_20BDBB0
sub_20BDBB0: // 0x020BDBB0
	stmdb sp!, {r4, lr}
	movs r4, r0
	bmi _020BDBE0
	bl sub_20BE100
	cmp r0, #0
	beq _020BDBE0
	mov r0, r4
	bl sub_20BE0D0
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
_020BDBE0:
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20BDBB0

	arm_func_start sub_20BDBEC
sub_20BDBEC: // 0x020BDBEC
	stmdb sp!, {r4, lr}
	ldr r0, _020BDC68 // =0x02145648
	ldr r0, [r0]
	cmp r0, #0
	beq _020BDC40
	bl sub_20BDC6C
	movs r4, r0
	bne _020BDC38
	ldr r0, _020BDC68 // =0x02145648
	ldr r0, [r0]
	bl sub_20BDAC4
	ldr r0, _020BDC68 // =0x02145648
	ldr r0, [r0]
	bl sub_20BDBB0
	cmp r0, #0
	ldrne r0, _020BDC68 // =0x02145648
	movne r1, #0
	strne r1, [r0]
	mvn r4, #0x19
_020BDC38:
	bl sub_20BD818
	b _020BDC5C
_020BDC40:
	bl sub_20C3D90
	cmp r0, #0
	mvneq r4, #0x19
	beq _020BDC5C
	mov r0, #0
	bl sub_20CC818
	mov r4, #0
_020BDC5C:
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BDC68: .word 0x02145648
	arm_func_end sub_20BDBEC

	arm_func_start sub_20BDC6C
sub_20BDC6C: // 0x020BDC6C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r4, _020BDD14 // =0x02145648
	ldr r5, _020BDD18 // =0x021456A8
_020BDC78:
	bl OS_DisableInterrupts
	ldr r6, [r5]
	cmp r6, #0
	beq _020BDCAC
	ldr r2, [r4]
_020BDC8C:
	cmp r6, r2
	beq _020BDCA0
	ldrsh r1, [r6, #0x70]
	ands r1, r1, #0x10
	beq _020BDCAC
_020BDCA0:
	ldr r6, [r6, #0x7c]
	cmp r6, #0
	bne _020BDC8C
_020BDCAC:
	bl OS_RestoreInterrupts
	cmp r6, #0
	beq _020BDCC4
	mov r0, r6
	bl sub_20BDAC4
	b _020BDC78
_020BDCC4:
	ldr r0, _020BDD18 // =0x021456A8
	ldr r1, [r0]
	cmp r1, #0
	beq _020BDCF0
	ldr r0, _020BDD14 // =0x02145648
	ldr r0, [r0]
	cmp r1, r0
	bne _020BDD08
	ldr r0, [r1, #0x7c]
	cmp r0, #0
	bne _020BDD08
_020BDCF0:
	ldr r0, _020BDD1C // =0x021456AC
	ldr r0, [r0]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
_020BDD08:
	mvn r0, #0x19
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020BDD14: .word 0x02145648
_020BDD18: .word 0x021456A8
_020BDD1C: .word 0x021456AC
	arm_func_end sub_20BDC6C

	arm_func_start sub_20BDD20
sub_20BDD20: // 0x020BDD20
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _020BDDC0 // =0x02145640
	ldr r0, [r1]
	cmp r0, #0
	ldreq r0, _020BDDC4 // =0x0214587C
	ldreq r0, [r0]
	streq r0, [r1]
	bl sub_20BDBEC
	mvn r4, #0x19
	cmp r0, r4
	bne _020BDD68
	mov r5, #0x64
_020BDD54:
	mov r0, r5
	bl OS_Sleep
	bl sub_20BDBEC
	cmp r0, r4
	beq _020BDD54
_020BDD68:
	bl sub_20BBC6C
	movs r4, r0
	bmi _020BDDB0
	bl sub_20C3D20
	mov r0, #0
	bl sub_20C3D80
	ldr r0, _020BDDC8 // =_02145638
	ldr r1, [r0]
	ldr r0, [r1, #0x28]
	cmp r0, #0
	bne _020BDDA4
	ldr r0, _020BDDCC // =0x0214564C
	ldr r1, [r1, #0x1c]
	ldr r0, [r0, #0x1c]
	blx r1
_020BDDA4:
	ldr r0, _020BDDC8 // =_02145638
	mov r1, #0
	str r1, [r0]
_020BDDB0:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020BDDC0: .word 0x02145640
_020BDDC4: .word 0x0214587C
_020BDDC8: .word _02145638
_020BDDCC: .word 0x0214564C
	arm_func_end sub_20BDD20

	arm_func_start sub_20BDDD0
sub_20BDDD0: // 0x020BDDD0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020BDE38 // =0x0214587C
	ldr r2, [r0]
	cmp r2, #0
	bne _020BDE14
	ldr r0, _020BDE3C // =0x02145644
	ldr r0, [r0]
	and r0, r0, #3
	cmp r0, #1
	bne _020BDE24
	bl OS_GetProcMode
	cmp r0, #0x12
	beq _020BDE24
	mov r0, #0xa
	bl OS_Sleep
	b _020BDE24
_020BDE14:
	ldr r0, _020BDE40 // =0x02145640
	ldr r1, [r0]
	cmp r1, #0
	streq r2, [r0]
_020BDE24:
	ldr r0, _020BDE38 // =0x0214587C
	ldr r0, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020BDE38: .word 0x0214587C
_020BDE3C: .word 0x02145644
_020BDE40: .word 0x02145640
	arm_func_end sub_20BDDD0

	arm_func_start sub_20BDE44
sub_20BDE44: // 0x020BDE44
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl sub_20BDDD0
	cmp r0, #0
	ldrne r1, _020BDE7C // =0x02145894
	mvneq r0, #0x26
	movne r0, #0
	strne r5, [r1]
	strne r4, [r1, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020BDE7C: .word 0x02145894
	arm_func_end sub_20BDE44

	arm_func_start sub_20BDE80
sub_20BDE80: // 0x020BDE80
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _020BDEDC // =0x02145894
	mov r5, r0
	ldr r7, [r1]
	mov r2, #0
	ldr r6, [r1, #4]
	mov r0, r4
	str r2, [r1]
	str r2, [r1, #4]
	bl sub_20BEB68
	ldr r1, _020BDEDC // =0x02145894
	mov r4, r0
	mov r0, r5
	str r7, [r1]
	str r6, [r1, #4]
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020BDEDC: .word 0x02145894
	arm_func_end sub_20BDE80

	arm_func_start sub_20BDEE0
sub_20BDEE0: // 0x020BDEE0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x64
	movs r4, r0
	addeq sp, sp, #0x64
	moveq r0, #0
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r1, _020BDF8C // =_02145638
	mov r0, #0xfd0
	ldr r1, [r1]
	ldr r1, [r1, #0x18]
	blx r1
	movs r5, r0
	addeq sp, sp, #0x64
	moveq r0, #0
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	add r0, sp, #0
	mov r1, #0
	mov r2, #0x64
	bl MI_CpuFill8
	ldr r3, _020BDF90 // =0x00000B68
	ldr r1, _020BDF94 // =0x00000466
	add r2, r5, r3
	add r0, sp, #0
	str r5, [sp, #0x40]
	str r3, [sp, #0x3c]
	str r2, [sp, #0x4c]
	str r1, [sp, #0x48]
	bl sub_20C0C84
	mov r0, r4
	bl sub_20BEB68
	mov r4, r0
	bl sub_20C0C6C
	ldr r1, _020BDF8C // =_02145638
	mov r0, r5
	ldr r1, [r1]
	ldr r1, [r1, #0x1c]
	blx r1
	mov r0, r4
	add sp, sp, #0x64
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020BDF8C: .word _02145638
_020BDF90: .word 0x00000B68
_020BDF94: .word 0x00000466
	arm_func_end sub_20BDEE0

	arm_func_start sub_20BDF98
sub_20BDF98: // 0x020BDF98
	ldr r2, [r0, #0x64]
	mov r3, #0
	cmp r2, #0
	beq _020BDFE0
	ldrsb r1, [r0, #0x73]
	cmp r1, #1
	bne _020BDFC4
	ldr r0, [r2, #0x104]
	cmp r0, #0
	ldrneh r3, [r0, #4]
	b _020BDFE0
_020BDFC4:
	cmp r1, #0
	beq _020BDFD4
	cmp r1, #4
	bne _020BDFE0
_020BDFD4:
	ldr r1, [r0, #0x44]
	ldr r0, [r2, #0xf8]
	sub r3, r1, r0
_020BDFE0:
	mov r0, r3
	bx lr
	arm_func_end sub_20BDF98

	arm_func_start sub_20BDFE8
sub_20BDFE8: // 0x020BDFE8
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, #0
	mov r5, r0
	bl sub_20BE100
	cmp r0, #0
	orrne r4, r4, #0x80
	bne _020BE0B8
	ldrsh r0, [r5, #0x70]
	ands r0, r0, #0x40
	ldrsb r0, [r5, #0x73]
	orrne r4, r4, #0x20
	cmp r0, #1
	beq _020BE028
	ldrsh r0, [r5, #0x70]
	ands r0, r0, #4
	beq _020BE058
_020BE028:
	bl OS_DisableInterrupts
	mov r6, r0
	mov r0, r5
	bl sub_20BDF98
	cmp r0, #0
	mov r0, r5
	orrgt r4, r4, #1
	bl sub_20BD3F8
	cmp r0, #0
	mov r0, r6
	orrgt r4, r4, #8
	bl OS_RestoreInterrupts
_020BE058:
	ldrsb r0, [r5, #0x73]
	mov r1, #1
	cmp r0, #0
	beq _020BE070
	cmp r0, #4
	movne r1, #0
_020BE070:
	cmp r1, #0
	beq _020BE0B8
	ldrsh r0, [r5, #0x70]
	ands r0, r0, #4
	beq _020BE0A0
	ldrb r0, [r5, #8]
	cmp r0, #4
	beq _020BE0A0
	ands r0, r4, #1
	ldreqsh r0, [r5, #0x70]
	biceq r0, r0, #6
	streqh r0, [r5, #0x70]
_020BE0A0:
	ldrsh r0, [r5, #0x70]
	ands r0, r0, #2
	bne _020BE0B8
	ldrsh r0, [r5, #0x70]
	ands r0, r0, #4
	orreq r4, r4, #0x40
_020BE0B8:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20BDFE8

	arm_func_start sub_20BE0C4
sub_20BE0C4: // 0x020BE0C4
	add r0, r0, #3
	bic r0, r0, #3
	bx lr
	arm_func_end sub_20BE0C4

	arm_func_start sub_20BE0D0
sub_20BE0D0: // 0x020BE0D0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, r0
	ldr r0, _020BE0FC // =0x021456AC
	bl sub_20BE160
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020BE0FC: .word 0x021456AC
	arm_func_end sub_20BE0D0

	arm_func_start sub_20BE100
sub_20BE100: // 0x020BE100
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, r0
	cmp r1, #0
	ble _020BE124
	ldr r0, _020BE144 // =0x021456A8
	bl sub_20BE160
	cmp r0, #0
	bne _020BE134
_020BE124:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {lr}
	bx lr
_020BE134:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020BE144: .word 0x021456A8
	arm_func_end sub_20BE100

	arm_func_start sub_20BE148
sub_20BE148: // 0x020BE148
	ldr ip, _020BE158 // =sub_20BE18C
	mov r1, r0
	ldr r0, _020BE15C // =0x021456AC
	bx ip
	.align 2, 0
_020BE158: .word sub_20BE18C
_020BE15C: .word 0x021456AC
	arm_func_end sub_20BE148

	arm_func_start sub_20BE160
sub_20BE160: // 0x020BE160
	ldr r2, [r0]
	cmp r2, #0
	beq _020BE184
_020BE16C:
	cmp r2, r1
	bxeq lr
	add r0, r2, #0x7c
	ldr r2, [r2, #0x7c]
	cmp r2, #0
	bne _020BE16C
_020BE184:
	mov r0, #0
	bx lr
	arm_func_end sub_20BE160

	arm_func_start sub_20BE18C
sub_20BE18C: // 0x020BE18C
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl sub_20BE160
	cmp r0, #0
	ldrne r1, [r4, #0x7c]
	strne r1, [r0]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20BE18C

	arm_func_start sub_20BE1AC
sub_20BE1AC: // 0x020BE1AC
	ldr ip, _020BE1BC // =sub_20BE18C
	mov r1, r0
	ldr r0, _020BE1C0 // =0x021456A8
	bx ip
	.align 2, 0
_020BE1BC: .word sub_20BE18C
_020BE1C0: .word 0x021456A8
	arm_func_end sub_20BE1AC

	arm_func_start sub_20BE1C4
sub_20BE1C4: // 0x020BE1C4
	ldr ip, _020BE1D4 // =sub_20BE1DC
	mov r1, r0
	ldr r0, _020BE1D8 // =0x021456AC
	bx ip
	.align 2, 0
_020BE1D4: .word sub_20BE1DC
_020BE1D8: .word 0x021456AC
	arm_func_end sub_20BE1C4

	arm_func_start sub_20BE1DC
sub_20BE1DC: // 0x020BE1DC
	ldr r2, [r0]
	str r2, [r1, #0x7c]
	str r1, [r0]
	bx lr
	arm_func_end sub_20BE1DC

	arm_func_start sub_20BE1EC
sub_20BE1EC: // 0x020BE1EC
	ldr ip, _020BE1FC // =sub_20BE1DC
	mov r1, r0
	ldr r0, _020BE200 // =0x021456A8
	bx ip
	.align 2, 0
_020BE1FC: .word sub_20BE1DC
_020BE200: .word 0x021456A8
	arm_func_end sub_20BE1EC

	arm_func_start sub_20BE204
sub_20BE204: // 0x020BE204
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r9, r2
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #8]
	mov r0, #0
	mov r8, r3
	mvn r2, #0
	cmp r8, r2
	cmpeq r9, r2
	movne r11, #1
	mov r10, r1
	moveq r11, #0
	str r0, [sp, #4]
_020BE240:
	ldr r5, [sp, #4]
	ldr r7, [sp]
	mov r6, r5
	cmp r10, #0
	bls _020BE280
_020BE254:
	ldrsh r1, [r7, #4]
	ldr r0, [r7]
	orr r4, r1, #0xe0
	bl sub_20BDFE8
	ands r0, r4, r0
	strh r0, [r7, #6]
	add r6, r6, #1
	addne r5, r5, #1
	cmp r6, r10
	add r7, r7, #8
	blo _020BE254
_020BE280:
	cmp r5, #0
	bgt _020BE2B8
	cmp r11, #0
	beq _020BE2A0
	mov r1, #0
	subs r0, r1, r9
	sbcs r0, r1, r8
	bge _020BE2B8
_020BE2A0:
	ldr r0, [sp, #8]
	bl OS_Sleep
	ldr r0, _020BE2C8 // =0x0000020B
	subs r9, r9, r0
	sbc r8, r8, #0
	b _020BE240
_020BE2B8:
	mov r0, r5
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020BE2C8: .word 0x0000020B
	arm_func_end sub_20BE204

	arm_func_start sub_20BE2CC
sub_20BE2CC: // 0x020BE2CC
	mov r2, r0, lsr #0x18
	strb r2, [r1]
	mov r2, r0, lsr #0x10
	strb r2, [r1, #1]
	mov r2, r0, lsr #8
	strb r2, [r1, #2]
	strb r0, [r1, #3]
	bx lr
	arm_func_end sub_20BE2CC

	arm_func_start sub_20BE2EC
sub_20BE2EC: // 0x020BE2EC
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	cmp r0, #2
	mov r4, r2
	addne sp, sp, #0x18
	movne r0, #0
	ldmneia sp!, {r4, lr}
	bxne lr
	cmp r3, #0x10
	addlo sp, sp, #0x18
	movlo r0, #0
	ldmloia sp!, {r4, lr}
	bxlo lr
	mov r0, r1
	add r1, sp, #0xc
	mov r2, #4
	bl MI_CpuCopy8
	ldr r0, [sp, #0xc]
	add r1, sp, #0x10
	bl sub_20BE2CC
	ldrb r1, [sp, #0x12]
	ldr r2, _020BE378 // =aDDDD
	mov r0, r4
	str r1, [sp]
	ldrb r3, [sp, #0x11]
	mov r1, #0x10
	str r3, [sp, #4]
	ldrb r3, [sp, #0x10]
	str r3, [sp, #8]
	ldrb r3, [sp, #0x13]
	bl OS_SNPrintf
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BE378: .word aDDDD
	arm_func_end sub_20BE2EC

	arm_func_start sub_20BE37C
sub_20BE37C: // 0x020BE37C
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl sub_20BDE80
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	mov r2, r0, lsr #0x18
	mov r1, r0, lsr #8
	mov r3, r0, lsl #8
	mov ip, r0, lsl #0x18
	and r2, r2, #0xff
	and r0, r1, #0xff00
	and r1, r3, #0xff0000
	orr r0, r2, r0
	and r2, ip, #0xff000000
	orr r0, r1, r0
	orr r0, r2, r0
	str r0, [r4]
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20BE37C

	arm_func_start sub_20BE3D4
sub_20BE3D4: // 0x020BE3D4
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020BE408 // =0x021456D4
	add r1, sp, #8
	mov r0, #2
	mov r3, #0x10
	bl sub_20BE2EC
	ldr r0, _020BE408 // =0x021456D4
	add sp, sp, #4
	ldmia sp!, {lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020BE408: .word 0x021456D4
	arm_func_end sub_20BE3D4

	arm_func_start sub_20BE40C
sub_20BE40C: // 0x020BE40C
	ldr ip, _020BE414 // =sub_20BDD20
	bx ip
	.align 2, 0
_020BE414: .word sub_20BDD20
	arm_func_end sub_20BE40C

	arm_func_start sub_20BE418
sub_20BE418: // 0x020BE418
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, [r0, #0xc]
	ldr ip, _020BE588 // =0x021456E4
	cmp r1, #1
	moveq r1, #1
	movne r1, #0
	str r1, [ip]
	ldr r6, [r0, #0x10]
	ldr r5, _020BE58C // =sub_20BE5DC
	mov r2, r6, lsr #0x18
	mov r1, r6, lsr #8
	mov r3, r6, lsl #8
	and r2, r2, #0xff
	and r1, r1, #0xff00
	mov r6, r6, lsl #0x18
	orr r1, r2, r1
	and r3, r3, #0xff0000
	orr r1, r3, r1
	and r2, r6, #0xff000000
	orr r1, r2, r1
	str r1, [ip, #4]
	ldr r7, [r0, #0x14]
	ldr r4, _020BE590 // =sub_20BE59C
	mov r2, r7, lsr #0x18
	mov r1, r7, lsr #8
	mov r6, r7, lsl #8
	and r2, r2, #0xff
	and r1, r1, #0xff00
	mov r7, r7, lsl #0x18
	orr r1, r2, r1
	and r6, r6, #0xff0000
	and r2, r7, #0xff000000
	orr r1, r6, r1
	orr r1, r2, r1
	str r1, [ip, #8]
	ldr r1, [r0, #0x18]
	ldr r3, _020BE594 // =0x021456B8
	mov r7, r1, lsr #0x18
	mov r6, r1, lsr #8
	mov r8, r1, lsl #8
	and r7, r7, #0xff
	and r6, r6, #0xff00
	mov r1, r1, lsl #0x18
	orr r6, r7, r6
	and r8, r8, #0xff0000
	and r7, r1, #0xff000000
	orr r1, r8, r6
	orr r1, r7, r1
	str r1, [ip, #0xc]
	ldr r1, [r0, #0x1c]
	ldr r2, _020BE598 // =0x021456B4
	mov r7, r1, lsr #0x18
	mov r6, r1, lsr #8
	mov r8, r1, lsl #8
	and r7, r7, #0xff
	and r6, r6, #0xff00
	mov r1, r1, lsl #0x18
	orr r6, r7, r6
	and r8, r8, #0xff0000
	and r7, r1, #0xff000000
	orr r1, r8, r6
	orr r1, r7, r1
	str r1, [ip, #0x10]
	ldr r1, [r0, #0x20]
	mov lr, #0x40
	mov r7, r1, lsr #0x18
	mov r6, r1, lsr #8
	mov r8, r1, lsl #8
	and r7, r7, #0xff
	and r6, r6, #0xff00
	mov r1, r1, lsl #0x18
	orr r6, r7, r6
	and r8, r8, #0xff0000
	and r7, r1, #0xff000000
	orr r1, r8, r6
	orr r1, r7, r1
	str r5, [ip, #0x18]
	str r4, [ip, #0x1c]
	str r1, [ip, #0x14]
	ldr r1, [r0, #4]
	str r1, [r3]
	ldr r1, [r0, #8]
	str lr, [ip, #0x20]
	str r1, [r2]
	ldr r1, [r0, #0x2c]
	str r1, [ip, #0x30]
	ldr r1, [r0, #0x30]
	mov r0, ip
	str r1, [ip, #0x34]
	bl sub_20BB98C
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020BE588: .word 0x021456E4
_020BE58C: .word sub_20BE5DC
_020BE590: .word sub_20BE59C
_020BE594: .word 0x021456B8
_020BE598: .word 0x021456B4
	arm_func_end sub_20BE418

	arm_func_start sub_20BE59C
sub_20BE59C: // 0x020BE59C
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r1, _020BE5D8 // =0x021456B4
	ldr r2, [r0, #-4]
	ldr r3, [r1]
	sub r1, r0, #4
	mov r0, #0
	blx r3
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020BE5D8: .word 0x021456B4
	arm_func_end sub_20BE59C

	arm_func_start sub_20BE5DC
sub_20BE5DC: // 0x020BE5DC
	stmdb sp!, {r4, lr}
	ldr r1, _020BE608 // =0x021456B8
	add r4, r0, #4
	ldr r2, [r1]
	mov r1, r4
	mov r0, #0
	blx r2
	cmp r0, #0
	strne r4, [r0], #4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BE608: .word 0x021456B8
	arm_func_end sub_20BE5DC

	arm_func_start sub_20BE60C
sub_20BE60C: // 0x020BE60C
	cmp r0, #0
	mvneq r0, #0
	bxeq lr
	cmp r1, #3
	beq _020BE62C
	cmp r1, #4
	beq _020BE640
	b _020BE654
_020BE62C:
	ldrsb r0, [r0, #0x72]
	cmp r0, #1
	moveq r0, #0
	movne r0, #4
	bx lr
_020BE640:
	ands r1, r2, #4
	movne r1, #0
	strneb r1, [r0, #0x72]
	moveq r1, #1
	streqb r1, [r0, #0x72]
_020BE654:
	mov r0, #0
	bx lr
	arm_func_end sub_20BE60C

	arm_func_start sub_20BE65C
sub_20BE65C: // 0x020BE65C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r1
	add r1, sp, #0
	add r2, sp, #4
	bl sub_20BC278
	cmp r0, #0
	addlt sp, sp, #8
	ldmltia sp!, {r4, lr}
	bxlt lr
	ldrh r1, [sp]
	mov r2, r1, asr #8
	mov r1, r1, lsl #8
	and r2, r2, #0xff
	and r1, r1, #0xff00
	orr r1, r2, r1
	strh r1, [r4, #2]
	ldr ip, [sp, #4]
	mov r2, ip, lsr #0x18
	mov r1, ip, lsr #8
	mov r3, ip, lsl #8
	mov ip, ip, lsl #0x18
	and r2, r2, #0xff
	and r1, r1, #0xff00
	and r3, r3, #0xff0000
	orr r1, r2, r1
	and r2, ip, #0xff000000
	orr r1, r3, r1
	orr r1, r2, r1
	str r1, [r4, #4]
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20BE65C

	arm_func_start sub_20BE6E0
sub_20BE6E0: // 0x020BE6E0
	ldr ip, _020BE6E8 // =sub_20BC384
	bx ip
	.align 2, 0
_020BE6E8: .word sub_20BC384
	arm_func_end sub_20BE6E0

	arm_func_start sub_20BE6EC
sub_20BE6EC: // 0x020BE6EC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr ip, [r1]
	ldr r0, [r0]
	mov r2, ip, lsr #0x18
	mov r4, r0, lsr #0x18
	mov lr, r0, lsr #8
	mov r1, ip, lsr #8
	mov r5, r0, lsl #8
	mov r3, ip, lsl #8
	mov r0, r0, lsl #0x18
	mov ip, ip, lsl #0x18
	and r4, r4, #0xff
	and lr, lr, #0xff00
	and r2, r2, #0xff
	and r1, r1, #0xff00
	and r5, r5, #0xff0000
	orr r4, r4, lr
	and r3, r3, #0xff0000
	orr r1, r2, r1
	and lr, r0, #0xff000000
	orr r0, r5, r4
	and r2, ip, #0xff000000
	orr r1, r3, r1
	orr r0, lr, r0
	orr r1, r2, r1
	bl sub_20BDE44
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20BE6EC

	arm_func_start SO_GetHostID
SO_GetHostID: // 0x020BE764
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20BDDD0
	mov r2, r0, lsr #0x18
	mov r1, r0, lsr #8
	mov r3, r0, lsl #8
	mov ip, r0, lsl #0x18
	and r2, r2, #0xff
	and r0, r1, #0xff00
	and r1, r3, #0xff0000
	orr r0, r2, r0
	and r2, ip, #0xff000000
	orr r0, r1, r0
	orr r0, r2, r0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end SO_GetHostID

	arm_func_start sub_20BE7A8
sub_20BE7A8: // 0x020BE7A8
	stmdb sp!, {r4, r5, r6, lr}
	movs r5, r0
	mov r4, r1
	mvneq r0, #0x26
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	bl sub_20BDDD0
	cmp r5, #0
	ldrneh r1, [r5, #0x74]
	mov r2, r0, lsr #0x18
	mov r6, #8
	moveq r1, #0
	cmp r0, #0
	moveq r1, #0
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r5, r3, asr #8
	mov lr, r3, lsl #8
	strb r6, [r4]
	mov r6, #2
	mov r1, r0, lsr #8
	mov r3, r0, lsl #8
	mov ip, r0, lsl #0x18
	and r0, r1, #0xff00
	and r2, r2, #0xff
	orr r0, r2, r0
	and r1, r3, #0xff0000
	and r5, r5, #0xff
	and lr, lr, #0xff00
	strb r6, [r4, #1]
	orr r3, r5, lr
	and r2, ip, #0xff000000
	orr r0, r1, r0
	strh r3, [r4, #2]
	orr r0, r2, r0
	str r0, [r4, #4]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20BE7A8

	arm_func_start sub_20BE844
sub_20BE844: // 0x020BE844
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl sub_20BDEE0
	movs r4, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r0, _020BE8FC // =0x0214571C
	ldr r2, _020BE900 // =0x00000101
	mov r1, #0
	bl MI_CpuFill8
	ldr r0, _020BE8FC // =0x0214571C
	ldr r2, _020BE900 // =0x00000101
	mov r1, r5
	bl STD_SearchString
	mov r1, r4, lsr #0x18
	mov r0, r4, lsr #8
	mov r2, r4, lsl #8
	mov r3, r4, lsl #0x18
	and r1, r1, #0xff
	and r0, r0, #0xff00
	and r2, r2, #0xff0000
	orr r0, r1, r0
	and r3, r3, #0xff000000
	orr r1, r2, r0
	ldr r5, _020BE8FC // =0x0214571C
	ldr r0, _020BE904 // =0x021456C4
	ldr ip, _020BE908 // =0x021456BC
	mov r4, #0
	ldr r2, _020BE90C // =0x021456B0
	orr r1, r3, r1
	mov lr, #2
	mov r3, #4
	str r5, [r0]
	str r4, [r0, #4]
	strh lr, [r0, #8]
	strh r3, [r0, #0xa]
	str ip, [r0, #0xc]
	str r2, [ip]
	str r4, [ip, #4]
	str r1, [r2]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020BE8FC: .word 0x0214571C
_020BE900: .word 0x00000101
_020BE904: .word 0x021456C4
_020BE908: .word 0x021456BC
_020BE90C: .word 0x021456B0
	arm_func_end sub_20BE844

	arm_func_start SOC_Close
SOC_Close: // 0x020BE910
	ldr ip, _020BE918 // =sub_20BDAC4
	bx ip
	.align 2, 0
_020BE918: .word sub_20BDAC4
	arm_func_end SOC_Close

	arm_func_start sub_20BE91C
sub_20BE91C: // 0x020BE91C
	ldr ip, _020BE924 // =sub_20BD734
	bx ip
	.align 2, 0
_020BE924: .word sub_20BD734
	arm_func_end sub_20BE91C

	arm_func_start sub_20BE928
sub_20BE928: // 0x020BE928
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r5, [sp, #0x20]
	cmp r5, #0
	moveq r5, #0
	moveq r4, r5
	beq _020BE994
	ldrh r4, [r5, #2]
	ldr r6, [r5, #4]
	mov r7, r4, asr #8
	mov ip, r4, lsl #8
	mov r4, r6, lsr #0x18
	mov lr, r6, lsr #8
	mov r5, r6, lsl #8
	mov r6, r6, lsl #0x18
	and r7, r7, #0xff
	and ip, ip, #0xff00
	orr r7, r7, ip
	and r4, r4, #0xff
	and lr, lr, #0xff00
	and r5, r5, #0xff0000
	orr r4, r4, lr
	mov ip, r7, lsl #0x10
	orr r4, r5, r4
	and r6, r6, #0xff000000
	mov r5, ip, lsr #0x10
	orr r4, r6, r4
_020BE994:
	str r4, [sp]
	str r3, [sp, #4]
	mov r3, r5
	bl sub_20BD5C8
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20BE928

	arm_func_start sub_20BE9B0
sub_20BE9B0: // 0x020BE9B0
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov ip, #0
	str ip, [sp]
	str r3, [sp, #4]
	mov r3, ip
	bl sub_20BD5C8
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20BE9B0

	arm_func_start sub_20BE9D8
sub_20BE9D8: // 0x020BE9D8
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	add ip, sp, #0xc
	str ip, [sp]
	str r3, [sp, #4]
	add r3, sp, #8
	bl sub_20BCE4C
	cmp r0, #0
	addlt sp, sp, #0x14
	ldmltia sp!, {lr}
	bxlt lr
	ldr r1, [sp, #0x18]
	cmp r1, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {lr}
	bxeq lr
	ldrh r2, [sp, #8]
	mov r3, r2, asr #8
	mov r2, r2, lsl #8
	and r3, r3, #0xff
	and r2, r2, #0xff00
	orr r2, r3, r2
	strh r2, [r1, #2]
	ldr lr, [sp, #0xc]
	mov r3, lr, lsr #0x18
	mov r2, lr, lsr #8
	mov ip, lr, lsl #8
	mov lr, lr, lsl #0x18
	and r3, r3, #0xff
	and r2, r2, #0xff00
	and ip, ip, #0xff0000
	orr r2, r3, r2
	and r3, lr, #0xff000000
	orr r2, ip, r2
	orr r2, r3, r2
	str r2, [r1, #4]
	add sp, sp, #0x14
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20BE9D8

	arm_func_start sub_20BEA74
sub_20BEA74: // 0x020BEA74
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov ip, #0
	str ip, [sp]
	str r3, [sp, #4]
	mov r3, ip
	bl sub_20BCE4C
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20BEA74

	arm_func_start sub_20BEA9C
sub_20BEA9C: // 0x020BEA9C
	stmdb sp!, {r4, lr}
	ldrh r2, [r1, #2]
	ldr lr, [r1, #4]
	mov r4, r2, asr #8
	mov r1, r2, lsl #8
	mov r3, lr, lsr #0x18
	mov r2, lr, lsr #8
	mov ip, lr, lsl #8
	mov lr, lr, lsl #0x18
	and r4, r4, #0xff
	and r1, r1, #0xff00
	orr r1, r4, r1
	mov r1, r1, lsl #0x10
	and r3, r3, #0xff
	and r2, r2, #0xff00
	and ip, ip, #0xff0000
	orr r2, r3, r2
	and r3, lr, #0xff000000
	orr r2, ip, r2
	mov r1, r1, lsr #0x10
	orr r2, r3, r2
	bl sub_20BC508
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20BEA9C

	arm_func_start sub_20BEAFC
sub_20BEAFC: // 0x020BEAFC
	ldrh r1, [r1, #2]
	ldr ip, _020BEB24 // =sub_20BC60C
	mov r2, r1, asr #8
	mov r1, r1, lsl #8
	and r2, r2, #0xff
	and r1, r1, #0xff00
	orr r1, r2, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bx ip
	.align 2, 0
_020BEB24: .word sub_20BC60C
	arm_func_end sub_20BEAFC

	arm_func_start sub_20BEB28
sub_20BEB28: // 0x020BEB28
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #1
	bne _020BEB4C
	ldr r0, _020BEB60 // =0x0211F180
	bl sub_20BC0C8
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020BEB4C:
	ldr r0, _020BEB64 // =0x0211F168
	bl sub_20BC0C8
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020BEB60: .word 0x0211F180
_020BEB64: .word 0x0211F168
	arm_func_end sub_20BEB28

	arm_func_start sub_20BEB68
sub_20BEB68: // 0x020BEB68
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r6, _020BECA8 // =0x0214589C
	mov r9, #0
	ldr r11, [r6, #8]
	ldr r2, [r6]
	ldr r1, [r6, #4]
	umull r5, r4, r11, r2
	mla r4, r11, r1, r4
	ldr r10, [r6, #0xc]
	ldr r3, [r6, #0x10]
	mla r4, r10, r2, r4
	adds r5, r3, r5
	ldr r1, [r6, #0x14]
	umull r8, r7, r11, r5
	adc r4, r1, r4
	mla r7, r11, r4, r7
	mla r7, r10, r5, r7
	mov r2, r9, lsl #0x10
	adds r8, r3, r8
	str r5, [r6]
	adc r5, r1, r7
	mov r3, r9, lsl #0x10
	orr r2, r2, r4, lsr #16
	str r4, [r6, #4]
	orr r3, r3, r5, lsr #16
	add r1, sp, #4
	mov r10, r0
	strh r2, [sp, #8]
	str r8, [r6]
	str r5, [r6, #4]
	strh r3, [sp, #0xa]
	bl sub_20BED1C
	cmp r0, #0
	ldrne r0, [sp, #4]
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	mov r0, #1
	ldr r6, _020BECAC // =0x02145894
	strb r0, [sp]
	strb r0, [sp, #1]
	add r5, sp, #8
	mov r4, r9
	mov r11, r9
_020BEC1C:
	mov r8, r11
	add r7, sp, #0
_020BEC24:
	ldrb r0, [r7]
	cmp r0, #0
	beq _020BEC68
	mov r0, r8, lsl #1
	ldrh r2, [r5, r0]
	ldr r1, [r6, r8, lsl #2]
	mov r0, r10
	bl sub_20BECB0
	str r0, [sp, #4]
	cmp r0, #0
	beq _020BEC5C
	mvn r1, #0
	cmp r0, r1
	bne _020BEC84
_020BEC5C:
	mvn r1, #0
	cmp r0, r1
	streqb r4, [r7]
_020BEC68:
	add r8, r8, #1
	cmp r8, #2
	add r7, r7, #1
	blt _020BEC24
	add r9, r9, #1
	cmp r9, #3
	blt _020BEC1C
_020BEC84:
	ldr r1, [sp, #4]
	mvn r0, #0
	cmp r1, r0
	moveq r0, #0
	streq r0, [sp, #4]
	ldr r0, [sp, #4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020BECA8: .word 0x0214589C
_020BECAC: .word 0x02145894
	arm_func_end sub_20BEB68

	arm_func_start sub_20BECB0
sub_20BECB0: // 0x020BECB0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	movs r5, r1
	mov r6, r0
	mov r4, r2
	addeq sp, sp, #8
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	bl sub_20C0BA0
	bl sub_20C0C44
	mov r2, r5
	mov r0, #0
	mov r1, #0x35
	bl sub_20C0BD4
	mov r0, r6
	mov r2, r4
	mov r3, #0
	str r3, [sp]
	mov r1, #1
	bl sub_20BEE00
	mov r4, r0
	bl sub_20C0B80
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20BECB0

	arm_func_start sub_20BED1C
sub_20BED1C: // 0x020BED1C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r6, #0
	mov r8, r0
	mov r7, r1
	mov r5, r6
	add r4, sp, #0
_020BED38:
	mov r0, r8
	mov r1, r4
	mov r6, r6, lsl #8
	bl sub_20BEDCC
	ldr r2, [sp]
	cmp r8, r2
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	mov r8, r2
	cmp r0, #0xff
	bhi _020BED98
	cmp r5, #3
	beq _020BED84
	ldrb r1, [r2]
	add r8, r2, #1
	cmp r1, #0x2e
	bne _020BED98
_020BED84:
	cmp r5, #3
	bne _020BEDA8
	ldrb r1, [r8]
	cmp r1, #0
	beq _020BEDA8
_020BED98:
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020BEDA8:
	add r5, r5, #1
	cmp r5, #4
	orr r6, r6, r0
	blt _020BED38
	str r6, [r7]
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20BED1C

	arm_func_start sub_20BEDCC
sub_20BEDCC: // 0x020BEDCC
	str r0, [r1]
	mov ip, #0
	mov r2, #0xa
_020BEDD8:
	ldrb r3, [r0]
	sub r3, r3, #0x30
	and r3, r3, #0xff
	cmp r3, #9
	mlals ip, r2, ip, r3
	addls r0, r0, #1
	strls r0, [r1]
	bls _020BEDD8
	mov r0, ip
	bx lr
	arm_func_end sub_20BEDCC

	arm_func_start sub_20BEE00
sub_20BEE00: // 0x020BEE00
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x4c
	mov r9, r2
	mov r2, r9, asr #8
	mov r10, r1
	orr r1, r2, r9, lsl #8
	strh r1, [sp, #0x10]
	cmp r10, #0x20
	mov r5, #0
	movne r1, #1
	strneh r1, [sp, #0x12]
	ldreq r1, _020BF0B0 // =0x00001001
	strh r5, [sp, #0x16]
	streqh r1, [sp, #0x12]
	mov r1, #0x100
	strh r1, [sp, #0x14]
	add r1, sp, #0x1c
	strh r5, [sp, #0x18]
	strh r5, [sp, #0x1a]
	str r5, [sp, #0xc]
	ldrb r6, [r0], #1
	str r3, [sp]
	ldr r8, [sp, #0x70]
	add r2, r1, #1
	cmp r6, #0
	beq _020BEEC0
	add r4, sp, #0x10
_020BEE6C:
	cmp r6, #0x2e
	beq _020BEEA0
	sub r3, r2, r4
	cmp r3, #0x3c
	addge sp, sp, #0x4c
	mvnge r0, #0
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxge lr
	strb r6, [r2], #1
	ldr r3, [sp, #0xc]
	add r3, r3, #1
	str r3, [sp, #0xc]
	b _020BEEB4
_020BEEA0:
	ldr r3, [sp, #0xc]
	strb r3, [r1]
	mov r1, r2
	str r5, [sp, #0xc]
	add r2, r2, #1
_020BEEB4:
	ldrb r6, [r0], #1
	cmp r6, #0
	bne _020BEE6C
_020BEEC0:
	ldr r0, [sp, #0xc]
	mov r3, #0
	strb r0, [r1]
	strb r3, [r2]
	mov r0, r10, lsr #8
	strb r0, [r2, #1]
	strb r10, [r2, #2]
	strb r3, [r2, #3]
	mov r3, #1
	add r0, sp, #0x10
	add r1, r2, #5
	sub r1, r1, r0
	strb r3, [r2, #4]
	bl sub_20C008C
	mov r6, #0
	bl OS_GetTick
	mov r5, r0, lsr #0x10
	mov r0, #2
	str r0, [sp, #8]
	mov r0, #1
	orr r5, r5, r1, lsl #16
	str r0, [sp, #4]
	mvn r11, #0
	b _020BF06C
_020BEF20:
	bl sub_20BFFF8
	cmp r0, #0
	bne _020BEF34
	bl sub_20C40B8
	b _020BF06C
_020BEF34:
	add r0, sp, #0xc
	bl sub_20C0694
	ldr r1, [sp, #0xc]
	cmp r1, #0xc
	bls _020BF064
	ldrh r3, [r0]
	mov r2, r3, asr #8
	orr r2, r2, r3, lsl #8
	mov r2, r2, lsl #0x10
	cmp r9, r2, lsr #16
	bne _020BF064
	ldrb r2, [r0, #3]
	and r2, r2, #0xf
	cmp r2, #3
	moveq r6, r11
	beq _020BF064
	cmp r2, #0
	bne _020BF064
	ldrb r2, [r0, #4]
	add r4, r0, r1
	ldrb r1, [r0, #5]
	add r0, r0, #0xc
	orr r1, r1, r2, lsl #8
	mov r1, r1, lsl #0x10
	movs r1, r1, lsr #0x10
	sub r7, r1, #1
	beq _020BEFB4
_020BEFA0:
	bl sub_20BF0B8
	cmp r7, #0
	add r0, r0, #4
	sub r7, r7, #1
	bne _020BEFA0
_020BEFB4:
	cmp r0, r4
	bhs _020BF064
_020BEFBC:
	bl sub_20BF0B8
	ldrb r7, [r0, #8]
	ldrb r1, [r0, #9]
	ldrb r3, [r0]
	ldrb r2, [r0, #1]
	orr r1, r1, r7, lsl #8
	mov r1, r1, lsl #0x10
	orr r3, r2, r3, lsl #8
	mov r2, r1, lsr #0x10
	mov r1, r3, lsl #0x10
	cmp r10, r1, lsr #16
	bne _020BF054
	cmp r10, #0xc
	beq _020BF034
	add r1, r0, #6
	add r3, r1, r2
	add r4, r0, #8
	ldrb r1, [r1, r2]
	ldrb r0, [r3, #1]
	add r3, r4, r2
	ldrb r2, [r4, r2]
	orr r0, r0, r1, lsl #8
	ldrb r1, [r3, #1]
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	orr r0, r1, r2, lsl #8
	mov r1, r3, lsl #0x10
	mov r0, r0, lsl #0x10
	orr r6, r1, r0, lsr #16
	b _020BF064
_020BF034:
	cmp r2, r8
	ldrhi r6, [sp, #8]
	bhi _020BF064
	ldr r1, [sp]
	add r0, r0, #0xa
	bl MI_CpuCopy8
	ldr r6, [sp, #4]
	b _020BF064
_020BF054:
	add r1, r2, #0xa
	add r0, r0, r1
	cmp r0, r4
	blo _020BEFBC
_020BF064:
	ldr r0, [sp, #0xc]
	bl sub_20C0588
_020BF06C:
	ldr r0, _020BF0B4 // =0x02145874
	ldr r0, [r0]
	blx r0
	cmp r0, #0
	beq _020BF0A0
	cmp r6, #0
	bne _020BF0A0
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	sub r0, r0, r5
	cmp r0, #0xf
	blt _020BEF20
_020BF0A0:
	mov r0, r6
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020BF0B0: .word 0x00001001
_020BF0B4: .word 0x02145874
	arm_func_end sub_20BEE00

	arm_func_start sub_20BF0B8
sub_20BF0B8: // 0x020BF0B8
	ldrb r2, [r0], #1
	cmp r2, #0
	bxeq lr
_020BF0C4:
	and r1, r2, #0xc0
	cmp r1, #0xc0
	addeq r0, r0, #1
	bxeq lr
	add r0, r0, r2
	ldrb r2, [r0], #1
	cmp r2, #0
	bne _020BF0C4
	bx lr
	arm_func_end sub_20BF0B8

	arm_func_start sub_20BF0E8
sub_20BF0E8: // 0x020BF0E8
	stmdb sp!, {r4, lr}
	bl sub_20C0BA0
	bl sub_20C0C44
	ldr r1, _020BF150 // =0x0214584C
	mov r0, #0x44
	ldr r2, [r1]
	mov r1, #0x43
	bl sub_20C0BD4
	ldr r4, _020BF154 // =0x02145BC2
	mov r1, #7
	mov r0, r4
	mov r2, #0
	bl sub_20BF8C8
	mov r1, #0xff
	add r2, r0, #1
	strb r1, [r0]
	mov r0, #0
	mov r1, #0x12c
	sub r3, r2, r4
	bl sub_20BF888
	sub r1, r0, r4
	mov r0, r4
	bl sub_20C008C
	bl sub_20C0B80
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BF150: .word 0x0214584C
_020BF154: .word 0x02145BC2
	arm_func_end sub_20BF0E8

	arm_func_start sub_20BF158
sub_20BF158: // 0x020BF158
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r5, r0
	bl sub_20C0BA0
	bl sub_20C0C44
	cmp r4, #1
	bne _020BF190
	ldr r1, _020BF274 // =0x0214584C
	mov r0, #0x44
	ldr r2, [r1]
	mov r1, #0x43
	bl sub_20C0BD4
	b _020BF1A0
_020BF190:
	mov r0, #0x44
	mov r1, #0x43
	mvn r2, #0
	bl sub_20C0BD4
_020BF1A0:
	mov r6, #0
_020BF1A4:
	mov r0, r4
	bl sub_20BF6A4
	mov r1, r6
	bl sub_20BF2E4
	movs r7, r0
	bne _020BF1C8
	add r6, r6, #1
	cmp r6, #4
	blt _020BF1A4
_020BF1C8:
	bl sub_20C0B80
	cmp r7, #2
	bne _020BF20C
	ldr r0, _020BF278 // =0x02145878
	mov r1, #3
	ldr r3, [r0]
	ldr r2, _020BF27C // =0x02145864
	mov r3, r3, lsr #1
	str r3, [r5]
	ldr r3, [r0]
	add sp, sp, #4
	mul r1, r3, r1
	mov r1, r1, lsr #3
	str r1, [r2]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020BF20C:
	ldr r1, _020BF27C // =0x02145864
	cmp r4, #1
	ldr r0, [r1]
	mov r0, r0, lsr #1
	str r0, [r1]
	str r0, [r5]
	beq _020BF234
	cmp r4, #2
	beq _020BF258
	b _020BF264
_020BF234:
	cmp r0, #0x3c
	bhs _020BF264
	mov r2, #1
	ldr r0, _020BF278 // =0x02145878
	str r2, [r5]
	ldr r0, [r0]
	mov r0, r0, lsr #3
	str r0, [r1]
	b _020BF264
_020BF258:
	cmp r0, #0x3c
	movlo r0, #1
	strlo r0, [r5]
_020BF264:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020BF274: .word 0x0214584C
_020BF278: .word 0x02145878
_020BF27C: .word 0x02145864
	arm_func_end sub_20BF158

	arm_func_start sub_20BF280
sub_20BF280: // 0x020BF280
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl sub_20C0BA0
	bl sub_20C0C44
	mov r0, #0x44
	mov r1, #0x43
	mvn r2, #0
	bl sub_20C0BD4
	mov r4, #0
_020BF2A4:
	bl sub_20BF7C0
	mov r1, r4
	bl sub_20BF2E4
	mov r5, r0
	cmp r5, #1
	beq _020BF2C8
	add r4, r4, #1
	cmp r4, #4
	blt _020BF2A4
_020BF2C8:
	bl sub_20C0B80
	cmp r5, #1
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20BF280

	arm_func_start sub_20BF2E4
sub_20BF2E4: // 0x020BF2E4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	add r2, r1, #1
	mov r1, #0xf
	mul r1, r2, r1
	str r1, [sp, #8]
	str r0, [sp]
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	str r0, [sp, #4]
	orr r0, r0, r1, lsl #16
	mov r4, #0
	str r0, [sp, #4]
	mov r0, #3
	mov r9, r4
	ldr r5, _020BF680 // =0x02145894
	mov r7, #2
	mov r8, #1
	ldr r11, _020BF684 // =0x02145858
	ldr r6, _020BF688 // =0x02145848
	str r0, [sp, #0xc]
	b _020BF634
_020BF33C:
	bl sub_20BFFF8
	cmp r0, #0
	bne _020BF350
	bl sub_20C40B8
	b _020BF634
_020BF350:
	add r0, sp, #0x10
	bl sub_20C0694
	mov r10, r0
	ldr r0, [sp, #0x10]
	cmp r0, #0xf0
	bls _020BF62C
	ldrb r0, [r10]
	cmp r0, #2
	bne _020BF62C
	ldrh r1, [r10, #6]
	ldrh r2, [r10, #4]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r1, r0, lsl #0x10
	mov r0, r2, asr #8
	orr r0, r0, r2, lsl #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	orr r1, r0, r1, lsr #16
	ldr r0, [sp]
	cmp r0, r1
	bne _020BF62C
	ldr r1, _020BF68C // =0x0214588C
	add r0, r10, #0x1c
	bl sub_20C39FC
	cmp r0, #0
	bne _020BF62C
	ldrb r3, [r10, #0x10]
	ldrb r0, [r10, #0x11]
	ldrb r2, [r10, #0x12]
	ldrb r1, [r10, #0x13]
	orr r0, r0, r3, lsl #8
	mov r0, r0, lsl #0x10
	orr r1, r1, r2, lsl #8
	mov r0, r0, lsr #0x10
	mov r2, r0, lsl #0x10
	mov r0, r1, lsl #0x10
	orr r0, r2, r0, lsr #16
	ldrb r2, [r10, #0xec]
	ldr r1, [sp, #0x10]
	ldr r4, [sp, #0xc]
	add r1, r10, r1
	cmp r2, #0x63
	bne _020BF62C
	ldrb r2, [r10, #0xed]
	cmp r2, #0x82
	bne _020BF62C
	ldrb r2, [r10, #0xee]
	cmp r2, #0x53
	bne _020BF62C
	add r2, r10, #0xf0
	ldrb r3, [r10, #0xef]
	cmp r3, #0x63
	bne _020BF62C
	b _020BF618
_020BF430:
	cmp r3, #0
	beq _020BF618
	cmp r3, #0x33
	bgt _020BF474
	cmp r3, #0x33
	bge _020BF570
	cmp r3, #6
	bgt _020BF60C
	cmp r3, #1
	blt _020BF60C
	cmp r3, #1
	beq _020BF494
	cmp r3, #3
	beq _020BF4C8
	cmp r3, #6
	beq _020BF4FC
	b _020BF60C
_020BF474:
	cmp r3, #0x35
	bgt _020BF488
	cmp r3, #0x35
	beq _020BF5A8
	b _020BF60C
_020BF488:
	cmp r3, #0x36
	beq _020BF5D8
	b _020BF60C
_020BF494:
	ldrb lr, [r2, #1]
	ldrb ip, [r2, #2]
	ldrb r10, [r2, #3]
	ldrb r3, [r2, #4]
	orr ip, ip, lr, lsl #8
	mov ip, ip, lsl #0x10
	orr r3, r3, r10, lsl #8
	mov r10, ip, lsr #0x10
	mov r10, r10, lsl #0x10
	mov r3, r3, lsl #0x10
	orr r3, r10, r3, lsr #16
	str r3, [r6]
	b _020BF60C
_020BF4C8:
	ldrb lr, [r2, #1]
	ldrb ip, [r2, #2]
	ldrb r10, [r2, #3]
	ldrb r3, [r2, #4]
	orr ip, ip, lr, lsl #8
	mov ip, ip, lsl #0x10
	orr r3, r3, r10, lsl #8
	mov r10, ip, lsr #0x10
	mov r10, r10, lsl #0x10
	mov r3, r3, lsl #0x10
	orr r3, r10, r3, lsr #16
	str r3, [r11]
	b _020BF60C
_020BF4FC:
	ldrb r3, [r2]
	cmp r3, #8
	strlo r9, [r5, #4]
	blo _020BF53C
	ldrb lr, [r2, #5]
	ldrb ip, [r2, #6]
	ldrb r10, [r2, #7]
	ldrb r3, [r2, #8]
	orr ip, ip, lr, lsl #8
	mov ip, ip, lsl #0x10
	orr r3, r3, r10, lsl #8
	mov r10, ip, lsr #0x10
	mov r10, r10, lsl #0x10
	mov r3, r3, lsl #0x10
	orr r3, r10, r3, lsr #16
	str r3, [r5, #4]
_020BF53C:
	ldrb lr, [r2, #1]
	ldrb ip, [r2, #2]
	ldrb r10, [r2, #3]
	ldrb r3, [r2, #4]
	orr ip, ip, lr, lsl #8
	mov ip, ip, lsl #0x10
	orr r3, r3, r10, lsl #8
	mov r10, ip, lsr #0x10
	mov r10, r10, lsl #0x10
	mov r3, r3, lsl #0x10
	orr r3, r10, r3, lsr #16
	str r3, [r5]
	b _020BF60C
_020BF570:
	ldrb lr, [r2, #1]
	ldrb ip, [r2, #2]
	ldrb r10, [r2, #3]
	ldrb r3, [r2, #4]
	orr ip, ip, lr, lsl #8
	mov ip, ip, lsl #0x10
	orr r3, r3, r10, lsl #8
	mov r10, ip, lsr #0x10
	mov r10, r10, lsl #0x10
	mov r3, r3, lsl #0x10
	orr r10, r10, r3, lsr #16
	ldr r3, _020BF690 // =0x02145878
	str r10, [r3]
	b _020BF60C
_020BF5A8:
	ldrb r3, [r2, #1]
	cmp r3, #2
	beq _020BF5C8
	cmp r3, #5
	ldreq r3, _020BF694 // =0x0214587C
	moveq r4, r7
	streq r0, [r3]
	b _020BF60C
_020BF5C8:
	ldr r3, _020BF698 // =0x02145860
	mov r4, r8
	str r0, [r3]
	b _020BF60C
_020BF5D8:
	ldrb lr, [r2, #1]
	ldrb ip, [r2, #2]
	ldrb r10, [r2, #3]
	ldrb r3, [r2, #4]
	orr ip, ip, lr, lsl #8
	mov ip, ip, lsl #0x10
	orr r3, r3, r10, lsl #8
	mov r10, ip, lsr #0x10
	mov r10, r10, lsl #0x10
	mov r3, r3, lsl #0x10
	orr r10, r10, r3, lsr #16
	ldr r3, _020BF69C // =0x0214584C
	str r10, [r3]
_020BF60C:
	ldrb r3, [r2]
	add r3, r3, #1
	add r2, r2, r3
_020BF618:
	cmp r2, r1
	bhs _020BF62C
	ldrb r3, [r2], #1
	cmp r3, #0xff
	bne _020BF430
_020BF62C:
	ldr r0, [sp, #0x10]
	bl sub_20C0588
_020BF634:
	ldr r0, _020BF6A0 // =0x02145874
	ldr r0, [r0]
	blx r0
	cmp r0, #0
	beq _020BF670
	cmp r4, #0
	bne _020BF670
	bl OS_GetTick
	mov r2, r0, lsr #0x10
	ldr r0, [sp, #4]
	orr r2, r2, r1, lsl #16
	sub r1, r2, r0
	ldr r0, [sp, #8]
	cmp r1, r0
	blt _020BF33C
_020BF670:
	mov r0, r4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020BF680: .word 0x02145894
_020BF684: .word 0x02145858
_020BF688: .word 0x02145848
_020BF68C: .word 0x0214588C
_020BF690: .word 0x02145878
_020BF694: .word 0x0214587C
_020BF698: .word 0x02145860
_020BF69C: .word 0x0214584C
_020BF6A0: .word 0x02145874
	arm_func_end sub_20BF2E4

	arm_func_start sub_20BF6A4
sub_20BF6A4: // 0x020BF6A4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, _020BF7B4 // =0x02145BC2
	mov r5, r0
	add r2, sp, #0
	mov r0, r4
	mov r1, #3
	bl sub_20BF8C8
	mov ip, r0
	cmp r5, #0
	bne _020BF778
	mov r0, #0x32
	strb r0, [ip]
	mov r0, #4
	ldr r3, _020BF7B8 // =0x02145860
	strb r0, [ip, #1]
	ldr r1, [r3]
	mov lr, #0x36
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #8
	strb r1, [ip, #2]
	ldr r1, [r3]
	ldr r2, _020BF7BC // =0x0214584C
	mov r1, r1, lsr #0x10
	strb r1, [ip, #3]
	ldr r1, [r3]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #8
	strb r1, [ip, #4]
	ldr r1, [r3]
	strb r1, [ip, #5]
	strb lr, [ip, #6]
	strb r0, [ip, #7]
	ldr r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #8
	strb r0, [ip, #8]
	ldr r0, [r2]
	mov r0, r0, lsr #0x10
	strb r0, [ip, #9]
	ldr r0, [r2]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #8
	strb r0, [ip, #0xa]
	ldr r0, [r2]
	strb r0, [ip, #0xb]
	add ip, ip, #0xc
_020BF778:
	add r2, ip, #1
	mov lr, #0xff
	sub r3, r2, r4
	mov r0, #0
	mov r1, #0x12c
	strb lr, [ip]
	bl sub_20BF888
	mov r1, r0
	mov r0, r4
	sub r1, r1, r4
	bl sub_20C008C
	ldr r0, [sp]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020BF7B4: .word 0x02145BC2
_020BF7B8: .word 0x02145860
_020BF7BC: .word 0x0214584C
	arm_func_end sub_20BF6A4

	arm_func_start sub_20BF7C0
sub_20BF7C0: // 0x020BF7C0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, _020BF880 // =0x02145BC2
	add r2, sp, #0
	mov r0, r4
	mov r1, #1
	bl sub_20BF8C8
	ldr r1, _020BF884 // =0x02145860
	mov ip, r0
	ldr r0, [r1]
	cmp r0, #0
	beq _020BF844
	mov r0, #0x32
	strb r0, [ip]
	mov r0, #4
	strb r0, [ip, #1]
	ldr r0, [r1]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #8
	strb r0, [ip, #2]
	ldr r0, [r1]
	mov r0, r0, lsr #0x10
	strb r0, [ip, #3]
	ldr r0, [r1]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r0, r0, asr #8
	strb r0, [ip, #4]
	ldr r0, [r1]
	strb r0, [ip, #5]
	add ip, ip, #6
_020BF844:
	add r2, ip, #1
	mov lr, #0xff
	sub r3, r2, r4
	mov r0, #0
	mov r1, #0x12c
	strb lr, [ip]
	bl sub_20BF888
	mov r1, r0
	mov r0, r4
	sub r1, r1, r4
	bl sub_20C008C
	ldr r0, [sp]
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BF880: .word 0x02145BC2
_020BF884: .word 0x02145860
	arm_func_end sub_20BF7C0

	arm_func_start sub_20BF888
sub_20BF888: // 0x020BF888
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov ip, r0
	mov r5, r2
	cmp r3, r1
	bhs _020BF8B8
	sub r4, r1, r3
	mov r0, r5
	mov r1, ip
	mov r2, r4
	bl MI_CpuFill8
	add r5, r5, r4
_020BF8B8:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20BF888

	arm_func_start sub_20BF8C8
sub_20BF8C8: // 0x020BF8C8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r1
	mov r4, r2
	mov r1, #0
	mov r2, #0xec
	mov r6, r0
	bl MI_CpuFill8
	ldr r0, _020BFA44 // =0x00000101
	mov r1, #6
	strh r0, [r6]
	ldr r0, _020BFA48 // =0x0214589C
	strb r1, [r6, #2]
	ldr r3, [r0, #8]
	ldr r2, [r0]
	ldr r1, [r0, #4]
	umull lr, ip, r3, r2
	mla ip, r3, r1, ip
	ldr r1, [r0, #0xc]
	ldr r7, [r0, #0x10]
	mla ip, r1, r2, ip
	adds r3, r7, lr
	ldr r1, [r0, #0x14]
	str r3, [r0]
	adc r1, r1, ip
	str r1, [r0, #4]
	mov r0, r1, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	cmp r4, #0
	mov r2, r3, asr #8
	mov r0, r1, lsl #0x10
	strne r1, [r4]
	mov r1, r0, lsr #0x10
	orr r2, r2, r3, lsl #8
	mov r0, r1, asr #8
	strh r2, [r6, #4]
	orr r0, r0, r1, lsl #8
	strh r0, [r6, #6]
	ldr r2, _020BFA4C // =0x0214587C
	ldr r0, _020BFA50 // =0x0214588C
	ldr r1, [r2]
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r1, r3, asr #8
	orr r1, r1, r3, lsl #8
	strh r1, [r6, #0xc]
	ldr r2, [r2]
	add r1, r6, #0x1c
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	mov r2, r3, asr #8
	orr r3, r2, r3, lsl #8
	mov r2, #6
	strh r3, [r6, #0xe]
	bl MI_CpuCopy8
	ldr r0, _020BFA54 // =0x00008263
	ldr r1, _020BFA58 // =0x00006353
	strh r0, [r6, #0xec]
	strh r1, [r6, #0xee]
	ldr r0, _020BFA5C // =0x00000135
	mov r1, #7
	strh r0, [r6, #0xf0]
	strb r5, [r6, #0xf2]
	mov r0, #0x3d
	strb r0, [r6, #0xf3]
	strb r1, [r6, #0xf4]
	mov r3, #1
	ldr r0, _020BFA50 // =0x0214588C
	add r1, r6, #0xf6
	mov r2, #6
	strb r3, [r6, #0xf5]
	bl MI_CpuCopy8
	mov r1, #0xc
	strb r1, [r6, #0xfc]
	mov r2, #0xa
	ldr r0, _020BFA60 // =aNintendods
	add r1, r6, #0xfe
	strb r2, [r6, #0xfd]
	bl MI_CpuCopy8
	mov r1, #0x37
	strb r1, [r6, #0x108]
	mov r2, #3
	ldr r0, _020BFA64 // =0x0000010D
	strb r2, [r6, #0x109]
	mov r1, #1
	strb r1, [r6, #0x10a]
	strb r2, [r6, #0x10b]
	mov r1, #6
	strb r1, [r6, #0x10c]
	add r0, r6, r0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020BFA44: .word 0x00000101
_020BFA48: .word 0x0214589C
_020BFA4C: .word 0x0214587C
_020BFA50: .word 0x0214588C
_020BFA54: .word 0x00008263
_020BFA58: .word 0x00006353
_020BFA5C: .word 0x00000135
_020BFA60: .word aNintendods
_020BFA64: .word 0x0000010D
	arm_func_end sub_20BF8C8

	arm_func_start sub_20BFA68
sub_20BFA68: // 0x020BFA68
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x54
	ldr r3, _020BFE9C // =0x02145870
	mov r1, #0
	ldr r0, _020BFEA0 // =0x02145950
	mov r2, #0x64
	str r1, [r3]
	bl MI_CpuFill8
	ldr r0, _020BFEA0 // =0x02145950
	mov r3, #0x180
	ldr r2, _020BFEA4 // =0x02145D18
	ldr r1, _020BFEA8 // =0x02145B98
	str r3, [r0, #0x3c]
	str r2, [r0, #0x40]
	str r3, [r0, #0x48]
	str r1, [r0, #0x4c]
	bl sub_20C0C84
	mov r0, #1
	str r0, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0x50]
	mov r1, r0
	ldr r0, _020BFEAC // =0x02145838
	ldr r5, [sp, #4]
	str r1, [r0]
	mov r0, #0
	str r0, [sp]
	mov r6, r0
	mov r10, r0
	mov r4, r0
	mov r11, r0
	mov r0, #2
	str r0, [sp, #0x14]
	ldr r0, [sp]
	str r0, [sp, #0x18]
	str r0, [sp, #0x1c]
	mov r0, r5
	str r0, [sp, #0x38]
	ldr r0, [sp]
	str r0, [sp, #0x3c]
	mov r0, r5
	str r0, [sp, #0x40]
	mov r0, #3
	str r0, [sp, #0x20]
	ldr r0, [sp]
	str r0, [sp, #0x30]
	mov r0, r5
	str r0, [sp, #0x34]
	str r0, [sp, #0x2c]
	str r0, [sp, #0x28]
	str r0, [sp, #0x24]
	str r0, [sp, #0x10]
	ldr r0, [sp]
	str r0, [sp, #0x44]
	mov r0, #0x69
	str r0, [sp, #0x48]
	ldr r0, [sp]
	str r0, [sp, #0x4c]
	mov r0, #0x3e8
	str r0, [sp, #0xc]
_020BFB58:
	ldr r0, [sp, #0xc]
	bl OS_Sleep
	ldr r0, _020BFE9C // =0x02145870
	ldr r0, [r0]
	cmp r0, #0
	bne _020BFE6C
	bl OS_GetTick
	mov r9, r0, lsr #0x10
	ldr r0, _020BFEB0 // =0x02145874
	orr r9, r9, r1, lsl #16
	ldr r0, [r0]
	blx r0
	cmp r0, #0
	beq _020BFCB8
	ldr r0, [sp, #0x50]
	subs r0, r0, #1
	str r0, [sp, #0x50]
	bne _020BFCD8
	ldr r0, _020BFEB4 // =0x0214583C
	ldr r0, [r0]
	ands r0, r0, #1
	beq _020BFBCC
	ldr r0, [sp]
	cmp r0, #0
	bne _020BFCD8
	bl sub_20BFED4
	ldr r0, [sp, #0x10]
	str r0, [sp]
	b _020BFCD8
_020BFBCC:
	ldr r0, [sp]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _020BFCD8
_020BFBDC: // jump table
	b _020BFBEC // case 0
	b _020BFC44 // case 1
	b _020BFC6C // case 2
	b _020BFCD8 // case 3
_020BFBEC:
	ldr r0, [sp, #8]
	cmp r0, #0
	ldrne r1, [sp, #0x14]
	ldrne r0, _020BFEAC // =0x02145838
	strne r1, [r0]
	ldrne r0, [sp, #0x18]
	strne r0, [sp, #8]
	bl sub_20BF280
	cmp r0, #0
	beq _020BFC28
	ldr r1, [sp, #0x1c]
	add r0, sp, #0x50
	bl sub_20BF158
	cmp r0, #0
	bne _020BFC38
_020BFC28:
	bl sub_20BFED4
	ldr r0, [sp, #0x20]
	str r0, [sp]
	b _020BFCD8
_020BFC38:
	ldr r0, [sp, #0x24]
	str r0, [sp]
	b _020BFCD8
_020BFC44:
	ldr r1, [sp, #0x28]
	add r0, sp, #0x50
	bl sub_20BF158
	cmp r0, #0
	bne _020BFCD8
	ldr r0, [sp, #0x50]
	cmp r0, #0x3c
	ldrlo r0, [sp, #0x14]
	strlo r0, [sp]
	b _020BFCD8
_020BFC6C:
	ldr r1, [sp, #0x14]
	add r0, sp, #0x50
	bl sub_20BF158
	cmp r0, #0
	ldrne r0, [sp, #0x2c]
	strne r0, [sp]
	bne _020BFCD8
	ldr r0, [sp, #0x50]
	cmp r0, #0x3c
	bhs _020BFCD8
	ldr r0, [sp, #0x20]
	bl sub_20C40F4
	ldr r0, [sp, #0x34]
	str r0, [sp, #0x50]
	ldr r0, [sp, #0x30]
	str r0, [sp]
	ldr r0, [sp, #0x34]
	str r0, [sp, #4]
	b _020BFCD8
_020BFCB8:
	ldr r0, [sp, #0x38]
	bl sub_20C40F4
	ldr r0, [sp, #0x40]
	str r0, [sp, #0x50]
	ldr r0, [sp, #0x3c]
	str r0, [sp]
	ldr r0, [sp, #0x40]
	str r0, [sp, #4]
_020BFCD8:
	ldr r1, [sp, #0x44]
	ldr r0, _020BFEB8 // =0x021458F0
_020BFCE0:
	ldr r2, [r0]
	cmp r2, #0
	beq _020BFD08
	ldrh r2, [r0, #0xa]
	sub r2, r9, r2
	mov r2, r2, lsl #0x10
	mov r3, r2, asr #0x10
	ldr r2, _020BFEBC // =0x000003BD
	cmp r3, r2
	strgt r6, [r0]
_020BFD08:
	add r0, r0, #0xc
	add r1, r1, #1
	cmp r1, #8
	blt _020BFCE0
	ldr r0, _020BFEC0 // =0x02145858
	ldr r0, [r0]
	cmp r0, #0
	beq _020BFD44
	ldr r1, [sp, #4]
	subs r1, r1, #1
	str r1, [sp, #4]
	bne _020BFD44
	bl sub_20C3394
	ldr r0, [sp, #0x48]
	str r0, [sp, #4]
_020BFD44:
	ldr r0, _020BFEC4 // =OSi_ThreadInfo
	ldr r7, [r0, #8]
	cmp r7, #0
	beq _020BFE04
_020BFD54:
	ldr r1, [r7, #0xa4]
	cmp r1, #0
	beq _020BFDF8
	ldr r0, [r1]
	cmp r0, #0
	beq _020BFDF8
	ldrb r0, [r1, #8]
	cmp r0, #3
	bne _020BFDA0
	ldr r2, [r1, #0x10]
	sub r2, r9, r2
	cmp r2, #0x27
	ble _020BFDA0
	strb r5, [r1, #8]
	ldrh r0, [r1, #0x1a]
	strh r0, [r1, #0x18]
	ldr r0, [r1, #0x20]
	str r0, [r1, #0x1c]
	b _020BFDF8
_020BFDA0:
	cmp r0, #2
	bne _020BFDD8
	ldr r2, [r1, #0x10]
	sub r2, r9, r2
	cmp r2, #0x27
	ble _020BFDD8
	ldr r0, [r1, #4]
	cmp r0, #1
	bne _020BFDF8
	strb r4, [r1, #8]
	str r4, [r1, #4]
	ldr r0, [r1]
	bl OS_WakeupThreadDirect
	b _020BFDF8
_020BFDD8:
	cmp r0, #4
	beq _020BFDF8
	ldr r0, [r1, #4]
	cmp r0, #2
	bne _020BFDF8
	str r10, [r1, #4]
	ldr r0, [r1]
	bl OS_WakeupThreadDirect
_020BFDF8:
	ldr r7, [r7, #0x68]
	cmp r7, #0
	bne _020BFD54
_020BFE04:
	ldr r7, [sp, #0x4c]
	ldr r8, _020BFEC8 // =0x02145E98
_020BFE0C:
	ldrh r0, [r8, #4]
	cmp r0, #0
	beq _020BFE3C
	ldr r0, [r8, #0x2c]
	sub r0, r9, r0
	cmp r0, #0xef
	ble _020BFE3C
	ldr r1, _020BFECC // =0x0214586C
	ldr r0, [r8, #0x34]
	ldr r1, [r1]
	blx r1
	strh r11, [r8, #4]
_020BFE3C:
	add r8, r8, #0x38
	add r7, r7, #1
	cmp r7, #8
	blt _020BFE0C
	mov r0, r9
	bl sub_20C4258
	ldr r0, _020BFED0 // =0x02145868
	ldr r0, [r0]
	cmp r0, #0
	beq _020BFB58
	blx r0
	b _020BFB58
_020BFE6C:
	ldr r0, _020BFEB4 // =0x0214583C
	ldr r0, [r0]
	ands r0, r0, #1
	bne _020BFE8C
	ldr r0, [sp]
	cmp r0, #3
	beq _020BFE8C
	bl sub_20BF0E8
_020BFE8C:
	bl sub_20C0C6C
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020BFE9C: .word 0x02145870
_020BFEA0: .word 0x02145950
_020BFEA4: .word 0x02145D18
_020BFEA8: .word 0x02145B98
_020BFEAC: .word 0x02145838
_020BFEB0: .word 0x02145874
_020BFEB4: .word 0x0214583C
_020BFEB8: .word 0x021458F0
_020BFEBC: .word 0x000003BD
_020BFEC0: .word 0x02145858
_020BFEC4: .word OSi_ThreadInfo
_020BFEC8: .word 0x02145E98
_020BFECC: .word 0x0214586C
_020BFED0: .word 0x02145868
	arm_func_end sub_20BFA68

	arm_func_start sub_20BFED4
sub_20BFED4: // 0x020BFED4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r0, _020BFF98 // =0x02145844
	ldr r0, [r0]
	blx r0
	ldr r0, _020BFF9C // =0x0214587C
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	bl sub_20C3394
	mov r0, #0x64
	bl OS_Sleep
	ldr r0, _020BFF9C // =0x0214587C
	ldr r0, [r0]
	bl sub_20C3394
	bl OS_GetTick
	mov r4, r0, lsr #0x10
	orr r4, r4, r1, lsl #16
	ldr r6, _020BFFA0 // =0x02145824
	mov r7, #0x64
	ldr r5, _020BFFA4 // =0x02145874
	b _020BFF5C
_020BFF34:
	ldrb r0, [r6]
	cmp r0, #0
	beq _020BFF54
	mov r0, #4
	bl sub_20C40F4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020BFF54:
	mov r0, r7
	bl OS_Sleep
_020BFF5C:
	ldr r0, [r5]
	blx r0
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	sub r0, r0, r4
	cmp r0, #0x17
	blt _020BFF34
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020BFF98: .word 0x02145844
_020BFF9C: .word 0x0214587C
_020BFFA0: .word 0x02145824
_020BFFA4: .word 0x02145874
	arm_func_end sub_20BFED4

	arm_func_start sub_20BFFA8
sub_20BFFA8: // 0x020BFFA8
	stmdb sp!, {r4, lr}
	ldr r0, _020BFFF4 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r4, [r0, #0xa4]
	cmp r4, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r1, [r4, #0x60]
	cmp r1, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	mov r2, #0
	ldr r0, [r4, #0x5c]
	mov r3, r2
	bl sub_20C0144
	mov r0, #0
	str r0, [r4, #0x60]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020BFFF4: .word OSi_ThreadInfo
	arm_func_end sub_20BFFA8

	arm_func_start sub_20BFFF8
sub_20BFFF8: // 0x020BFFF8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020C0088 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r0, [r0, #0xa4]
	cmp r0, #0
	beq _020C0078
	ldrb r1, [r0, #9]
	cmp r1, #0
	beq _020C0030
	bl sub_20C4594
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C0030:
	ldr r1, [r0, #0x44]
	cmp r1, #0
	bne _020C0058
	ldrb r0, [r0, #8]
	cmp r0, #4
	beq _020C0058
	add r0, r0, #0xf6
	and r0, r0, #0xff
	cmp r0, #1
	bhi _020C0068
_020C0058:
	add sp, sp, #4
	mov r0, r1
	ldmia sp!, {lr}
	bx lr
_020C0068:
	add sp, sp, #4
	mvn r0, #0
	ldmia sp!, {lr}
	bx lr
_020C0078:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C0088: .word OSi_ThreadInfo
	arm_func_end sub_20BFFF8

	arm_func_start sub_20C008C
sub_20C008C: // 0x020C008C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r3, _020C0140 // =OSi_ThreadInfo
	mov r2, r0
	ldr r4, [r3, #4]
	mov r3, r1
	ldr r5, [r4, #0xa4]
	cmp r5, #0
	beq _020C0130
	ldr r4, [r5, #0x60]
	cmp r4, #0
	beq _020C0118
	ldr r0, [r5, #0x5c]
	mov r1, r4
	bl sub_20C0144
	ldr r1, [r5, #0x60]
	mov r4, r0
	cmp r4, r1
	movhs r0, #0
	strhs r0, [r5, #0x60]
	addhs sp, sp, #4
	subhs r0, r4, r1
	ldmhsia sp!, {r4, r5, lr}
	bxhs lr
	ldr r0, [r5, #0x5c]
	sub r2, r1, r4
	add r1, r0, r4
	bl memmove
	ldr r1, [r5, #0x60]
	add sp, sp, #4
	sub r1, r1, r4
	mov r0, #0
	str r1, [r5, #0x60]
	ldmia sp!, {r4, r5, lr}
	bx lr
_020C0118:
	mov r2, #0
	mov r3, r2
	bl sub_20C0144
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
_020C0130:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C0140: .word OSi_ThreadInfo
	arm_func_end sub_20C008C

	arm_func_start sub_20C0144
sub_20C0144: // 0x020C0144
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr ip, _020C0228 // =OSi_ThreadInfo
	mov r7, r1
	ldr ip, [ip, #4]
	mov r6, r2
	ldr r4, [ip, #0xa4]
	mov r5, r3
	cmp r4, #0
	beq _020C0218
	ldrb ip, [r4, #8]
	cmp ip, #0xa
	bne _020C01A8
	cmp r7, #0
	beq _020C0188
	mov r2, r4
	bl sub_20C2B5C
_020C0188:
	cmp r5, #0
	beq _020C01A0
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20C2B5C
_020C01A0:
	add r0, r7, r5
	b _020C0200
_020C01A8:
	cmp ip, #0xb
	bne _020C01E0
	cmp r7, #0
	beq _020C01C0
	mov r2, r4
	bl sub_20C2C9C
_020C01C0:
	cmp r5, #0
	beq _020C01D8
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20C2C9C
_020C01D8:
	add r0, r7, r5
	b _020C0200
_020C01E0:
	ldrb ip, [r4, #9]
	cmp ip, #0
	beq _020C01F8
	str r4, [sp]
	bl sub_20C443C
	b _020C0200
_020C01F8:
	str r4, [sp]
	bl sub_20C0230
_020C0200:
	ldr r1, _020C022C // =0x02145820
	ldrb r1, [r1]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
_020C0218:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020C0228: .word OSi_ThreadInfo
_020C022C: .word 0x02145820
	arm_func_end sub_20C0144

	arm_func_start sub_20C0230
sub_20C0230: // 0x020C0230
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r4, #0
	mov r10, r0
	ldr r8, [sp, #0x40]
	mov r0, r4
	str r4, [sp, #0xc]
	mov r9, r1
	mov r11, r2
	str r3, [sp, #8]
	mov r6, r4
	str r0, [r8, #0x34]
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	orr r0, r0, r1, lsl #16
	str r0, [sp, #0x10]
	mov r0, r6
	str r0, [sp, #0x18]
	mov r0, #1
	ldr r4, _020C0448 // =0x02145874
	str r0, [sp, #0x14]
	b _020C03F8
_020C028C:
	ldr r7, [r8, #0x28]
	ldr r3, [sp, #8]
	str r8, [sp]
	mov r0, r10
	mov r1, r9
	mov r2, r11
	str r6, [sp, #4]
	bl sub_20C044C
	bl OS_GetTick
	mov r5, r0, lsr #0x10
	orr r5, r5, r1, lsl #16
_020C02B8:
	bl sub_20C40B8
	ldr r0, [r4]
	blx r0
	cmp r0, #0
	beq _020C0314
	ldrb r0, [r8, #8]
	cmp r0, #4
	bne _020C0314
	ldr r1, [r8, #0x28]
	ldr r0, [r8, #0x30]
	cmp r1, r0
	beq _020C0314
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	sub r0, r0, r5
	cmp r0, #0xf
	bge _020C0314
	cmp r6, #0
	beq _020C02B8
	ldrh r0, [r8, #0x2c]
	cmp r0, #0
	beq _020C02B8
_020C0314:
	ldr r0, [r8, #0x30]
	subs r7, r0, r7
	ldr r0, [sp, #0xc]
	add r0, r0, r7
	str r0, [sp, #0xc]
	beq _020C0340
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	str r0, [sp, #0x10]
	orr r0, r0, r1, lsl #16
	str r0, [sp, #0x10]
_020C0340:
	ldr r0, [r8, #0x30]
	str r0, [r8, #0x28]
	ldrb r0, [r8, #8]
	cmp r0, #4
	bne _020C03C8
	ldrh r0, [r8, #0x2c]
	cmp r0, #0
	bne _020C03C8
	cmp r7, #0
	bne _020C03C8
	cmp r6, #0
	bne _020C03CC
	bl OS_GetTick
	mov r5, r0, lsr #0x10
	orr r5, r5, r1, lsl #16
	b _020C0390
_020C0380:
	bl sub_20C40B8
	ldrh r0, [r8, #0x2c]
	cmp r0, #0
	bne _020C03B8
_020C0390:
	ldr r0, [r4]
	blx r0
	cmp r0, #0
	beq _020C03B8
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	sub r0, r0, r5
	cmp r0, #0xf
	blt _020C0380
_020C03B8:
	ldrh r0, [r8, #0x2c]
	cmp r0, #0
	ldreq r6, [sp, #0x14]
	b _020C03CC
_020C03C8:
	ldr r6, [sp, #0x18]
_020C03CC:
	cmp r7, r9
	addlo r10, r10, r7
	sublo r9, r9, r7
	blo _020C03F8
	sub r1, r7, r9
	add r10, r11, r1
	ldr r0, [sp, #8]
	ldr r11, [sp, #0x18]
	sub r9, r0, r1
	mov r0, r11
	str r0, [sp, #8]
_020C03F8:
	ldr r0, [r4]
	blx r0
	cmp r0, #0
	beq _020C0438
	cmp r9, #0
	beq _020C0438
	ldrb r0, [r8, #8]
	cmp r0, #4
	bne _020C0438
	bl OS_GetTick
	mov r2, r0, lsr #0x10
	ldr r0, [sp, #0x10]
	orr r2, r2, r1, lsl #16
	sub r0, r2, r0
	cmp r0, #0x9f
	blt _020C028C
_020C0438:
	ldr r0, [sp, #0xc]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C0448: .word 0x02145874
	arm_func_end sub_20C0230

	arm_func_start sub_20C044C
sub_20C044C: // 0x020C044C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r2
	mov r4, r3
	ldr r2, [sp, #0x10]
	ldr r3, [sp, #0x14]
	bl sub_20C04A8
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	cmp r4, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	ldr r2, [sp, #0x10]
	mov r0, r5
	mov r1, r4
	mov r3, #0
	bl sub_20C04A8
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C044C

	arm_func_start sub_20C04A8
sub_20C04A8: // 0x020C04A8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r8, r2
	ldr r11, [r8, #0x34]
	mov r10, r0
	movs r0, r3
	mov r0, r11, lsl #1
	movne r6, #1
	add r5, r0, #4
	mov r0, #0x18
	str r3, [sp, #4]
	mov r9, r1
	ldreqh r6, [r8, #0x2c]
	mov r4, #0
	str r0, [sp, #8]
	b _020C0560
_020C04E8:
	ldr r0, _020C0584 // =0x02145828
	ldrh r7, [r8, #0x2e]
	ldrh r0, [r0]
	ldr r1, [r8, #0x34]
	cmp r7, r6
	movhs r7, r6
	cmp r0, r7
	movlo r7, r0
	ldr r0, [sp, #4]
	cmp r0, #0
	biceq r7, r7, #1
	cmp r9, r7
	sub r0, r1, r11
	movlo r7, r9
	adds r0, r5, r0
	moveq r7, r4
	mov r11, r1
	sub r5, r0, #1
	cmp r7, #0
	beq _020C0574
	ldr r3, [sp, #8]
	mov r0, r10
	mov r1, r7
	mov r2, r8
	str r4, [sp]
	sub r6, r6, r7
	bl sub_20C28D4
	bl OS_YieldThread
	add r10, r10, r7
	sub r9, r9, r7
_020C0560:
	cmp r9, #0
	beq _020C0574
	ldrb r0, [r8, #8]
	cmp r0, #4
	beq _020C04E8
_020C0574:
	mov r0, r7
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C0584: .word 0x02145828
	arm_func_end sub_20C04A8

	arm_func_start sub_20C0588
sub_20C0588: // 0x020C0588
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020C05D8 // =OSi_ThreadInfo
	ldr r1, [r1, #4]
	ldr r1, [r1, #0xa4]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldrb r2, [r1, #9]
	cmp r2, #0
	beq _020C05C8
	bl sub_20C4794
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C05C8:
	bl sub_20C05DC
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C05D8: .word OSi_ThreadInfo
	arm_func_end sub_20C0588

	arm_func_start sub_20C05DC
sub_20C05DC: // 0x020C05DC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r7, r0
	bl OS_DisableInterrupts
	ldr r2, [r4, #0x44]
	ldr r1, [r4, #0x3c]
	mov r6, r0
	cmp r2, r1
	mov r5, #0
	bne _020C0610
	cmp r7, #0
	movne r5, #1
_020C0610:
	cmp r7, r2
	movhs r0, #0
	strhs r0, [r4, #0x44]
	bhs _020C0634
	ldr r0, [r4, #0x40]
	sub r2, r2, r7
	add r1, r0, r7
	str r2, [r4, #0x44]
	bl memmove
_020C0634:
	mov r0, r6
	bl OS_RestoreInterrupts
	ldrb r0, [r4, #8]
	cmp r0, #0xa
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	cmp r0, #0xb
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _020C067C
	cmp r5, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
_020C067C:
	mov r0, r4
	mov r1, #0x1b
	bl sub_20C1FE0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C05DC

	arm_func_start sub_20C0694
sub_20C0694: // 0x020C0694
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020C0718 // =OSi_ThreadInfo
	ldr r1, [r1, #4]
	ldr r1, [r1, #0xa4]
	cmp r1, #0
	beq _020C0700
	ldrb r2, [r1, #8]
	add r2, r2, #0xf6
	and r2, r2, #0xff
	cmp r2, #1
	bhi _020C06D4
	bl sub_20C07A8
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C06D4:
	ldrb r2, [r1, #9]
	cmp r2, #0
	beq _020C06F0
	bl sub_20C47EC
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C06F0:
	bl sub_20C071C
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C0700:
	mov r1, #0
	str r1, [r0]
	mov r0, r1
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C0718: .word OSi_ThreadInfo
	arm_func_end sub_20C0694

	arm_func_start sub_20C071C
sub_20C071C: // 0x020C071C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r1
	ldr r1, [r4, #0x44]
	mov r5, r0
	cmp r1, #0
	bne _020C0784
	ldrb r0, [r4, #8]
	cmp r0, #4
	bne _020C0784
	bl OS_DisableInterrupts
	mov r8, r0
	mov r7, #2
	mov r6, #0
	b _020C0760
_020C0754:
	mov r0, r6
	str r7, [r4, #4]
	bl OS_SleepThread
_020C0760:
	ldr r0, [r4, #0x44]
	cmp r0, #0
	bne _020C0778
	ldrb r0, [r4, #8]
	cmp r0, #4
	beq _020C0754
_020C0778:
	mov r0, r8
	bl OS_RestoreInterrupts
	b _020C0788
_020C0784:
	bl OS_YieldThread
_020C0788:
	ldr r0, [r4, #0x44]
	str r0, [r5]
	ldr r0, [r5]
	cmp r0, #0
	ldrne r0, [r4, #0x40]
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C071C

	arm_func_start sub_20C07A8
sub_20C07A8: // 0x020C07A8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r1
	mov r9, r0
	bl OS_DisableInterrupts
	ldr r7, [r8, #0x44]
	mov r6, r0
	cmp r7, #0
	bne _020C07EC
	mov r5, #3
	mov r4, #0
_020C07D4:
	mov r0, r4
	str r5, [r8, #4]
	bl OS_SleepThread
	ldr r7, [r8, #0x44]
	cmp r7, #0
	beq _020C07D4
_020C07EC:
	mov r0, r6
	bl OS_RestoreInterrupts
	str r7, [r9]
	ldr r0, [r8, #0x40]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20C07A8

	arm_func_start sub_20C0808
sub_20C0808: // 0x020C0808
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, _020C0894 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r4, [r0, #0xa4]
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldrb r0, [r4, #9]
	cmp r0, #0
	beq _020C0838
	mov r0, r4
	bl sub_20C437C
_020C0838:
	bl OS_GetTick
	mov r6, r0, lsr #0x10
	orr r6, r6, r1, lsl #16
	ldr r5, _020C0898 // =0x02145874
	b _020C0850
_020C084C:
	bl sub_20C40B8
_020C0850:
	ldr r0, [r5]
	blx r0
	cmp r0, #0
	beq _020C0884
	ldrb r0, [r4, #8]
	cmp r0, #0
	beq _020C0884
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	sub r0, r0, r6
	cmp r0, #0x27
	blt _020C084C
_020C0884:
	mov r0, #0
	strb r0, [r4, #8]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C0894: .word OSi_ThreadInfo
_020C0898: .word 0x02145874
	arm_func_end sub_20C0808

	arm_func_start sub_20C089C
sub_20C089C: // 0x020C089C
	stmdb sp!, {r4, lr}
	ldr r0, _020C08DC // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r4, [r0, #0xa4]
	cmp r4, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldrb r0, [r4, #9]
	cmp r0, #0
	beq _020C08CC
	mov r0, r4
	bl sub_20C43B8
_020C08CC:
	mov r0, r4
	bl sub_20C08E0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C08DC: .word OSi_ThreadInfo
	arm_func_end sub_20C089C

	arm_func_start sub_20C08E0
sub_20C08E0: // 0x020C08E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_YieldThread
	ldrb r1, [r4, #8]
	add r0, r1, #0xfd
	and r0, r0, #0xff
	cmp r0, #1
	bhi _020C091C
	mov r0, r4
	mov r1, #0x19
	bl sub_20C1FCC
	mov r0, #7
	strb r0, [r4, #8]
	ldmia sp!, {r4, lr}
	bx lr
_020C091C:
	cmp r1, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	mov r0, r4
	mov r1, #0x1a
	bl sub_20C1FE0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C08E0

	arm_func_start sub_20C093C
sub_20C093C: // 0x020C093C
	ldr r2, _020C098C // =OSi_ThreadInfo
	ldr r2, [r2, #4]
	ldr r3, [r2, #0xa4]
	cmp r3, #0
	beq _020C0984
	ldrb r2, [r3, #8]
	cmp r2, #4
	beq _020C0964
	cmp r2, #0xa
	bne _020C0984
_020C0964:
	cmp r0, #0
	ldrneh r2, [r3, #0x18]
	strneh r2, [r0]
	cmp r1, #0
	ldrne r0, [r3, #0x14]
	strne r0, [r1]
	ldr r0, [r3, #0x1c]
	bx lr
_020C0984:
	mov r0, #0
	bx lr
	.align 2, 0
_020C098C: .word OSi_ThreadInfo
	arm_func_end sub_20C093C

	arm_func_start sub_20C0990
sub_20C0990: // 0x020C0990
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020C09E8 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r0, [r0, #0xa4]
	cmp r0, #0
	beq _020C09D8
	ldrb r1, [r0, #9]
	cmp r1, #0
	beq _020C09C8
	bl sub_20C48D0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C09C8:
	bl sub_20C09EC
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C09D8:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C09E8: .word OSi_ThreadInfo
	arm_func_end sub_20C0990

	arm_func_start sub_20C09EC
sub_20C09EC: // 0x020C09EC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	bl sub_20C0C98
	mov r8, r0
	mov r9, #0
	mov r11, r9
	mov r4, #1
	mov r6, #2
	mov r5, #0x18
_020C0A14:
	str r8, [r10, #0x28]
	strb r6, [r10, #8]
	bl OS_GetTick
	mov r2, r0, lsr #0x10
	orr r2, r2, r1, lsl #16
	str r2, [r10, #0x10]
	mov r0, r10
	mov r1, r6
	mov r2, r5
	bl sub_20C1FF4
	bl OS_DisableInterrupts
	mov r7, r0
	ldr r0, _020C0AAC // =0x0214587C
	ldr r0, [r0]
	cmp r0, #0
	beq _020C0A60
	mov r0, r11
	str r4, [r10, #4]
	bl OS_SleepThread
_020C0A60:
	mov r0, r7
	bl OS_RestoreInterrupts
	ldrb r0, [r10, #8]
	cmp r0, #4
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldr r0, _020C0AAC // =0x0214587C
	ldr r0, [r0]
	cmp r0, #0
	beq _020C0A9C
	add r9, r9, #1
	cmp r9, #3
	blo _020C0A14
_020C0A9C:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C0AAC: .word 0x0214587C
	arm_func_end sub_20C09EC

	arm_func_start sub_20C0AB0
sub_20C0AB0: // 0x020C0AB0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020C0B00 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r0, [r0, #0xa4]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldrb r1, [r0, #9]
	cmp r1, #0
	beq _020C0AF0
	bl sub_20C4A28
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C0AF0:
	bl sub_20C0B20
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C0B00: .word OSi_ThreadInfo
	arm_func_end sub_20C0AB0

	arm_func_start sub_20C0B04
sub_20C0B04: // 0x020C0B04
	ldr r1, _020C0B1C // =OSi_ThreadInfo
	ldr r1, [r1, #4]
	ldr r1, [r1, #0xa4]
	cmp r1, #0
	strne r0, [r1, #0x38]
	bx lr
	.align 2, 0
_020C0B1C: .word OSi_ThreadInfo
	arm_func_end sub_20C0B04

	arm_func_start sub_20C0B20
sub_20C0B20: // 0x020C0B20
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl sub_20C0C98
	str r0, [r5, #0x28]
	mov r0, #1
	strb r0, [r5, #8]
	bl OS_DisableInterrupts
	mov r4, r0
	mov r1, #1
	mov r0, #0
	str r1, [r5, #4]
	bl OS_SleepThread
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C0B20

	arm_func_start sub_20C0B68
sub_20C0B68: // 0x020C0B68
	ldr r1, _020C0B7C // =OSi_ThreadInfo
	ldr r1, [r1, #4]
	ldr r1, [r1, #0xa4]
	str r1, [r0, #0xa4]
	bx lr
	.align 2, 0
_020C0B7C: .word OSi_ThreadInfo
	arm_func_end sub_20C0B68

	arm_func_start sub_20C0B80
sub_20C0B80: // 0x020C0B80
	ldr r0, _020C0B9C // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r1, [r0, #0xa4]
	cmp r1, #0
	movne r0, #0
	strne r0, [r1]
	bx lr
	.align 2, 0
_020C0B9C: .word OSi_ThreadInfo
	arm_func_end sub_20C0B80

	arm_func_start sub_20C0BA0
sub_20C0BA0: // 0x020C0BA0
	ldr r0, _020C0BD0 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r1, [r0, #0xa4]
	cmp r1, #0
	bxeq lr
	str r0, [r1]
	mov r0, #0
	strb r0, [r1, #8]
	str r0, [r1, #0x44]
	str r0, [r1, #0x60]
	str r0, [r1, #0x38]
	bx lr
	.align 2, 0
_020C0BD0: .word OSi_ThreadInfo
	arm_func_end sub_20C0BA0

	arm_func_start sub_20C0BD4
sub_20C0BD4: // 0x020C0BD4
	stmdb sp!, {r4, lr}
	ldr r3, _020C0C38 // =OSi_ThreadInfo
	ldr r3, [r3, #4]
	ldr r4, [r3, #0xa4]
	cmp r4, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r3, _020C0C3C // =0x7F000001
	cmp r2, r3
	ldreq r2, _020C0C40 // =0x0214587C
	ldreq r2, [r2]
	cmp r0, #0
	strh r1, [r4, #0x1a]
	ldrh r1, [r4, #0x1a]
	strh r1, [r4, #0x18]
	str r2, [r4, #0x20]
	ldr r1, [r4, #0x20]
	str r1, [r4, #0x1c]
	strneh r0, [r4, #0xa]
	ldmneia sp!, {r4, lr}
	bxne lr
	bl sub_20C0CE8
	strh r0, [r4, #0xa]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C0C38: .word OSi_ThreadInfo
_020C0C3C: .word 0x7F000001
_020C0C40: .word 0x0214587C
	arm_func_end sub_20C0BD4

	arm_func_start sub_20C0C44
sub_20C0C44: // 0x020C0C44
	ldr r0, _020C0C68 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r1, [r0, #0xa4]
	cmp r1, #0
	movne r0, #0xa
	strneb r0, [r1, #8]
	movne r0, #0
	strne r0, [r1, #0x44]
	bx lr
	.align 2, 0
_020C0C68: .word OSi_ThreadInfo
	arm_func_end sub_20C0C44

	arm_func_start sub_20C0C6C
sub_20C0C6C: // 0x020C0C6C
	ldr r0, _020C0C80 // =OSi_ThreadInfo
	mov r1, #0
	ldr r0, [r0, #4]
	str r1, [r0, #0xa4]
	bx lr
	.align 2, 0
_020C0C80: .word OSi_ThreadInfo
	arm_func_end sub_20C0C6C

	arm_func_start sub_20C0C84
sub_20C0C84: // 0x020C0C84
	ldr r1, _020C0C94 // =OSi_ThreadInfo
	ldr r1, [r1, #4]
	str r0, [r1, #0xa4]
	bx lr
	.align 2, 0
_020C0C94: .word OSi_ThreadInfo
	arm_func_end sub_20C0C84

	arm_func_start sub_20C0C98
sub_20C0C98: // 0x020C0C98
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020C0CE4 // =0x0214589C
	ldr r3, [r1, #8]
	ldr r2, [r1]
	ldr r0, [r1, #4]
	umull lr, ip, r3, r2
	mla ip, r3, r0, ip
	ldr r0, [r1, #0xc]
	ldr r3, [r1, #0x10]
	mla ip, r0, r2, ip
	adds r2, r3, lr
	ldr r0, [r1, #0x14]
	str r2, [r1]
	adc r0, r0, ip
	str r0, [r1, #4]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C0CE4: .word 0x0214589C
	arm_func_end sub_20C0C98

	arm_func_start sub_20C0CE8
sub_20C0CE8: // 0x020C0CE8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r0, _020C0D8C // =OSi_ThreadInfo
	ldr r6, [r0, #8]
	ldr r2, _020C0D90 // =0x02145834
	mov r4, #0x400
	mov r3, #1
	mov r5, #0
	ldr r1, _020C0D94 // =0x00001388
_020C0D08:
	ldrh ip, [r2]
	mov r0, r5
	add ip, ip, #1
	strh ip, [r2]
	ldrh ip, [r2]
	cmp ip, #0x400
	blo _020C0D2C
	cmp ip, r1
	blo _020C0D30
_020C0D2C:
	strh r4, [r2]
_020C0D30:
	mov r8, r6
	cmp r6, #0
	beq _020C0D74
	ldrh r7, [r2]
_020C0D40:
	ldr lr, [r8, #0xa4]
	cmp lr, #0
	beq _020C0D68
	ldr ip, [lr]
	cmp ip, #0
	beq _020C0D68
	ldrh ip, [lr, #0xa]
	cmp ip, r7
	moveq r0, r3
	beq _020C0D74
_020C0D68:
	ldr r8, [r8, #0x68]
	cmp r8, #0
	bne _020C0D40
_020C0D74:
	cmp r0, #0
	bne _020C0D08
	ldr r0, _020C0D90 // =0x02145834
	ldrh r0, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C0D8C: .word OSi_ThreadInfo
_020C0D90: .word 0x02145834
_020C0D94: .word 0x00001388
	arm_func_end sub_20C0CE8

	arm_func_start sub_20C0D98
sub_20C0D98: // 0x020C0D98
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r5, _020C0E08 // =0x00000806
	add r4, sp, #0
_020C0DA8:
	mov r0, r4
	bl sub_20C35D8
	ldr r3, [sp]
	cmp r3, #0x22
	bls _020C0E00
	ldrh r2, [r0, #0xc]
	mov r1, r2, asr #8
	orr r1, r1, r2, lsl #8
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	cmp r1, #0x800
	beq _020C0DE4
	cmp r1, r5
	beq _020C0DF4
	b _020C0E00
_020C0DE4:
	add r0, r0, #0xe
	sub r1, r3, #0xe
	bl sub_20C0E0C
	b _020C0E00
_020C0DF4:
	add r0, r0, #0xe
	sub r1, r3, #0xe
	bl sub_20C2670
_020C0E00:
	bl sub_20C3578
	b _020C0DA8
	.align 2, 0
_020C0E08: .word 0x00000806
	arm_func_end sub_20C0D98

	arm_func_start sub_20C0E0C
sub_20C0E0C: // 0x020C0E0C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r0
	ldrh ip, [r4, #0xc]
	ldrh r6, [r4, #0x10]
	ldrh r2, [r4, #0xe]
	ldrh r0, [r4, #0x12]
	mov r5, r6, asr #8
	mov r3, ip, asr #8
	orr r5, r5, r6, lsl #8
	orr ip, r3, ip, lsl #8
	mov r3, r5, lsl #0x10
	mov r5, r0, asr #8
	mov ip, ip, lsl #0x10
	mov lr, r2, asr #8
	mov r6, r3, lsr #0x10
	orr r0, r5, r0, lsl #8
	mov r3, ip, lsr #0x10
	orr r2, lr, r2, lsl #8
	mov r5, r6, lsl #0x10
	mov r0, r0, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r2, r2, lsl #0x10
	orr r0, r5, r0, lsr #16
	orr r2, r3, r2, lsr #16
	mov r5, r1
	cmp r0, r2
	beq _020C0F4C
	bl sub_20C3A28
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldrh r1, [r4, #2]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	cmp r5, r0, lsr #16
	addlo sp, sp, #8
	ldmloia sp!, {r4, r5, r6, lr}
	bxlo lr
	ldrb r1, [r4]
	mov r0, r4
	and r1, r1, #0xf
	mov r1, r1, lsl #2
	bl sub_20C3BE0
	ldr r1, _020C0FFC // =0x0000FFFF
	cmp r0, r1
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	ldrh r2, [r4, #0x10]
	ldrh ip, [r4, #0x12]
	ldr r1, _020C1000 // =0x0214587C
	mov r0, r2, asr #8
	orr r0, r0, r2, lsl #8
	mov r0, r0, lsl #0x10
	mov r2, ip, asr #8
	mov r3, r0, lsr #0x10
	orr r0, r2, ip, lsl #8
	mov r2, r3, lsl #0x10
	mov r0, r0, lsl #0x10
	ldr r1, [r1]
	orr r0, r2, r0, lsr #16
	cmp r1, r0
	bne _020C0F4C
	ldrh r2, [r4, #0xc]
	ldrh ip, [r4, #0xe]
	sub r0, r4, #8
	mov r1, r2, asr #8
	orr r1, r1, r2, lsl #8
	mov r1, r1, lsl #0x10
	mov r2, ip, asr #8
	mov r3, r1, lsr #0x10
	orr r1, r2, ip, lsl #8
	mov r2, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r1, r2, r1, lsr #16
	mov r2, #1
	bl sub_20C3188
_020C0F4C:
	add r1, sp, #0
	mov r0, r4
	bl sub_20C1008
	movs r4, r0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldrh r2, [r4, #2]
	ldrb r3, [r4]
	ldrb ip, [r4, #9]
	mov r1, r2, asr #8
	orr r1, r1, r2, lsl #8
	mov r1, r1, lsl #0x10
	and r3, r3, #0xf
	mov r2, r1, lsr #0x10
	cmp ip, #0x11
	add r1, r4, r3, lsl #2
	sub r2, r2, r3, lsl #2
	bne _020C0FA0
	bl sub_20C1318
	b _020C0FCC
_020C0FA0:
	ldr r3, _020C1000 // =0x0214587C
	ldr r3, [r3]
	cmp r3, #0
	beq _020C0FCC
	cmp ip, #1
	bne _020C0FC0
	bl sub_20C233C
	b _020C0FCC
_020C0FC0:
	cmp ip, #6
	bne _020C0FCC
	bl sub_20C1534
_020C0FCC:
	ldr r0, [sp]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r1, _020C1004 // =0x0214586C
	sub r0, r4, #0xe
	ldr r1, [r1]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C0FFC: .word 0x0000FFFF
_020C1000: .word 0x0214587C
_020C1004: .word 0x0214586C
	arm_func_end sub_20C0E0C

	arm_func_start sub_20C1008
sub_20C1008: // 0x020C1008
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r6, #0
	mov r10, r0
	str r6, [r1]
	ldrh r3, [r10, #6]
	str r1, [sp]
	ldr r2, _020C1300 // =0x00003FFF
	mov r1, r3, asr #8
	orr r1, r1, r3, lsl #8
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	str r1, [sp, #4]
	ands r1, r1, r2
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldrh r1, [r10, #0xc]
	ldrh r3, [r10, #0xe]
	ldrb r4, [r10]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	mov r1, r3, asr #8
	mov r2, r0, lsr #0x10
	orr r0, r1, r3, lsl #8
	and r3, r4, #0xf
	ldrh r9, [r10, #4]
	mov r2, r2, lsl #0x10
	mov r1, r0, lsl #0x10
	ldr r5, _020C1304 // =0x02145E98
	mov r0, r6
	mov r7, r3, lsl #2
	orr r4, r2, r1, lsr #16
_020C1090:
	ldrh r2, [r5, #4]
	cmp r2, #0
	beq _020C10B4
	ldr r1, [r5]
	cmp r1, r4
	bne _020C10B4
	ldrh r1, [r5, #6]
	cmp r1, r9
	beq _020C10D4
_020C10B4:
	cmp r2, #0
	bne _020C10C4
	cmp r6, #0
	moveq r6, r5
_020C10C4:
	add r0, r0, #1
	cmp r0, #8
	add r5, r5, #0x38
	blo _020C1090
_020C10D4:
	ldrh r2, [r10, #2]
	cmp r0, #8
	ldr r1, _020C1308 // =0x00001FFF
	mov r0, r2, asr #8
	orr r0, r0, r2, lsl #8
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	ldr r0, [sp, #4]
	and r8, r0, r1
	sub r0, r2, r7
	str r0, [sp, #8]
	mov r0, r8, lsl #3
	str r0, [sp, #0xc]
	ldr r0, [sp, #8]
	add r11, r0, r8, lsl #3
	bne _020C11AC
	cmp r6, #0
	beq _020C1124
	cmp r11, #0x1000
	bls _020C1134
_020C1124:
	add sp, sp, #0x14
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020C1134:
	ldr r1, _020C130C // =0x02145840
	ldr r0, _020C1310 // =0x0000100E
	ldr r1, [r1]
	add r0, r7, r0
	mov r5, r6
	blx r1
	str r0, [r6, #0x34]
	ldr r0, [r6, #0x34]
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	str r4, [r6]
	strh r9, [r6, #6]
	mov r0, #0
	strh r0, [r6, #8]
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	str r0, [r6, #0x2c]
	ldr r1, [r6, #0x34]
	mov r0, r10
	add r1, r1, #0xe
	add r1, r1, r7
	str r1, [r6, #0x30]
	ldr r1, [r6, #0x34]
	mov r2, r7
	add r1, r1, #0xe
	bl MI_CpuCopy8
_020C11AC:
	ldrh r0, [r5, #4]
	cmp r0, #8
	beq _020C11C0
	cmp r11, #0x1000
	bls _020C11E8
_020C11C0:
	mov r0, #0
	strh r0, [r5, #4]
	ldr r1, _020C1314 // =0x0214586C
	ldr r0, [r5, #0x34]
	ldr r1, [r1]
	blx r1
	add sp, sp, #0x14
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020C11E8:
	ldr r0, [sp, #8]
	ldr r2, [sp, #8]
	add r0, r0, #7
	add r1, r8, r0, lsr #3
	ldr r0, [sp, #4]
	ands r0, r0, #0x2000
	streqh r11, [r5, #0xa]
	streqh r1, [r5, #8]
	ldrh r3, [r5, #4]
	add r0, r10, r7
	add r3, r5, r3, lsl #1
	strh r8, [r3, #0xc]
	ldrh r3, [r5, #4]
	add r3, r5, r3, lsl #1
	strh r1, [r3, #0x1c]
	ldrh r1, [r5, #4]
	add r1, r1, #1
	strh r1, [r5, #4]
	ldr r3, [r5, #0x30]
	ldr r1, [sp, #0xc]
	add r1, r3, r1
	bl MI_CpuCopy8
	ldrh r6, [r5, #8]
	cmp r6, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldrh r7, [r5, #4]
	mov r3, #0
	mov r4, r3
	cmp r7, #0
	bls _020C12A0
	mov r0, r3
_020C1270:
	add r2, r5, r4, lsl #1
	ldrh r1, [r2, #0xc]
	cmp r1, r3
	bhi _020C1294
	ldrh r1, [r2, #0x1c]
	cmp r3, r1
	movlo r3, r1
	movlo r4, r0
	blo _020C1298
_020C1294:
	add r4, r4, #1
_020C1298:
	cmp r4, r7
	blo _020C1270
_020C12A0:
	cmp r3, r6
	addlo sp, sp, #0x14
	movlo r0, #0
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxlo lr
	ldr r0, [r5, #0x34]
	ldrh r3, [r5, #0xa]
	ldrb r1, [r0, #0xe]
	add r0, r0, #0xe
	mov r2, #0
	and r1, r1, #0xf
	add r1, r3, r1, lsl #2
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	mov r1, r3, asr #8
	orr r1, r1, r3, lsl #8
	strh r1, [r0, #2]
	strh r2, [r5, #4]
	ldr r1, [sp]
	mov r2, #1
	str r2, [r1]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C1300: .word 0x00003FFF
_020C1304: .word 0x02145E98
_020C1308: .word 0x00001FFF
_020C130C: .word 0x02145840
_020C1310: .word 0x0000100E
_020C1314: .word 0x0214586C
	arm_func_end sub_20C1008

	arm_func_start sub_20C1318
sub_20C1318: // 0x020C1318
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	ldrh r1, [r6, #6]
	mov r7, r0
	mov r5, r2
	cmp r1, #0
	beq _020C1354
	mov r0, r6
	mov r1, r5
	mov r2, r7
	mov r3, #0x11
	bl sub_20C3B84
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
_020C1354:
	bl OS_DisableInterrupts
	ldr r1, _020C1530 // =OSi_ThreadInfo
	mov r8, r0
	ldr r2, [r1, #8]
	cmp r2, #0
	beq _020C1520
	mvn ip, #0
_020C1370:
	ldr r4, [r2, #0xa4]
	cmp r4, #0
	beq _020C1514
	ldr r0, [r4]
	cmp r0, #0
	beq _020C1514
	ldrb r0, [r4, #8]
	cmp r0, #0xa
	bne _020C1514
	ldrh r3, [r6, #2]
	ldrh r1, [r4, #0xa]
	mov r0, r3, asr #8
	orr r0, r0, r3, lsl #8
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	bne _020C1514
	ldrh r3, [r4, #0x18]
	cmp r3, #0
	beq _020C13D4
	ldrh r1, [r6]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	cmp r3, r0, lsr #16
	bne _020C1514
_020C13D4:
	ldr r1, [r4, #0x1c]
	cmp r1, #0
	beq _020C141C
	cmp r1, ip
	beq _020C141C
	ldrh lr, [r7, #0xc]
	ldrh r0, [r7, #0xe]
	mov r3, lr, asr #8
	orr r3, r3, lr, lsl #8
	mov r3, r3, lsl #0x10
	mov lr, r0, asr #8
	mov r3, r3, lsr #0x10
	orr r0, lr, r0, lsl #8
	mov r3, r3, lsl #0x10
	mov r0, r0, lsl #0x10
	orr r0, r3, r0, lsr #16
	cmp r1, r0
	bne _020C1514
_020C141C:
	ldrh r1, [r7, #0x10]
	ldrh r3, [r7, #0x12]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	mov r1, r3, asr #8
	mov r2, r0, lsr #0x10
	orr r0, r1, r3, lsl #8
	mov r1, r2, lsl #0x10
	mov r0, r0, lsl #0x10
	orr r0, r1, r0, lsr #16
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	bne _020C1498
	ldrh r1, [r7, #0xc]
	ldrh r3, [r7, #0xe]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	mov r1, r3, asr #8
	mov r2, r0, lsr #0x10
	orr r0, r1, r3, lsl #8
	mov r1, r2, lsl #0x10
	mov r0, r0, lsl #0x10
	orr r0, r1, r0, lsr #16
	str r0, [r4, #0x1c]
	ldrh r1, [r6]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	strh r0, [r4, #0x18]
_020C1498:
	ldr r0, [r4, #0x44]
	cmp r0, #0
	bne _020C1520
	ldr r1, [r4, #0x3c]
	sub r0, r5, #8
	cmp r0, r1
	strhi r1, [r4, #0x44]
	strls r0, [r4, #0x44]
	ldr r1, [r4, #0x40]
	ldr r2, [r4, #0x44]
	add r0, r6, #8
	bl MI_CpuCopy8
	ldr r0, [r4, #4]
	cmp r0, #3
	bne _020C14E8
	mov r0, #0
	str r0, [r4, #4]
	ldr r0, [r4]
	bl OS_WakeupThreadDirect
	b _020C1520
_020C14E8:
	ldr r3, [r4, #0x38]
	cmp r3, #0
	beq _020C1520
	ldr r0, [r4, #0x40]
	ldr r1, [r4, #0x44]
	mov r2, r4
	blx r3
	cmp r0, #0
	movne r0, #0
	strne r0, [r4, #0x44]
	b _020C1520
_020C1514:
	ldr r2, [r2, #0x68]
	cmp r2, #0
	bne _020C1370
_020C1520:
	mov r0, r8
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C1530: .word OSi_ThreadInfo
	arm_func_end sub_20C1318

	arm_func_start sub_20C1534
sub_20C1534: // 0x020C1534
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r0, r5
	mov r1, r4
	mov r2, r6
	mov r3, #6
	bl sub_20C3B84
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	ldrb r0, [r5, #0xc]
	ldrb r2, [r5, #0xd]
	and r1, r0, #0xf0
	mov r0, r1, asr #1
	add r0, r1, r0, lsr #30
	and r1, r2, #0x17
	cmp r1, #0x10
	sub r4, r4, r0, asr #2
	bgt _020C15B4
	cmp r1, #0x10
	bge _020C1620
	cmp r1, #2
	bgt _020C1650
	cmp r1, #1
	blt _020C1650
	cmp r1, #1
	beq _020C1638
	cmp r1, #2
	beq _020C15D8
	b _020C1650
_020C15B4:
	cmp r1, #0x12
	bgt _020C1650
	cmp r1, #0x11
	blt _020C1650
	cmp r1, #0x11
	beq _020C1620
	cmp r1, #0x12
	beq _020C15FC
	b _020C1650
_020C15D8:
	ands r0, r2, #0x28
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20C1C0C
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C15FC:
	ands r0, r2, #0x28
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20C1AF8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C1620:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20C17D0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C1638:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20C16D0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C1650:
	ands r0, r2, #4
	beq _020C166C
	mov r0, r6
	mov r1, r5
	bl sub_20C1688
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C166C:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	mov r3, #0
	bl sub_20C1E90
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C1534

	arm_func_start sub_20C1688
sub_20C1688: // 0x020C1688
	stmdb sp!, {r4, lr}
	bl sub_20C2124
	movs r4, r0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	bl OS_YieldThread
	mov r1, #0
	strb r1, [r4, #8]
	ldr r0, [r4, #4]
	sub r0, r0, #1
	cmp r0, #1
	ldmhiia sp!, {r4, lr}
	bxhi lr
	str r1, [r4, #4]
	ldr r0, [r4]
	bl OS_WakeupThreadDirect
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C1688

	arm_func_start sub_20C16D0
sub_20C16D0: // 0x020C16D0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl sub_20C2124
	movs r4, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldrb r1, [r4, #8]
	cmp r1, #4
	beq _020C1788
	cmp r1, #7
	beq _020C1718
	cmp r1, #8
	beq _020C1740
	b _020C17B0
_020C1718:
	ldr r2, [r4, #0x24]
	mov r1, #0
	add r2, r2, #1
	str r2, [r4, #0x24]
	bl sub_20C1FE0
	mov r0, #9
	add sp, sp, #4
	strb r0, [r4, #8]
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020C1740:
	ldr r2, [r4, #0x24]
	mov r1, #0
	add r2, r2, #1
	str r2, [r4, #0x24]
	bl sub_20C1FE0
	mov r1, #0
	strb r1, [r4, #8]
	ldr r0, [r4, #4]
	cmp r0, #2
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	str r1, [r4, #4]
	ldr r0, [r4]
	bl OS_WakeupThreadDirect
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020C1788:
	ldr r2, [r4, #0x24]
	mov r1, #0
	add r2, r2, #1
	str r2, [r4, #0x24]
	bl sub_20C1FCC
	mov r0, #6
	add sp, sp, #4
	strb r0, [r4, #8]
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020C17B0:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, #0
	bl sub_20C1E90
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C16D0

	arm_func_start sub_20C17D0
sub_20C17D0: // 0x020C17D0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	mov r7, r1
	mov r6, r2
	bl sub_20C2124
	movs r5, r0
	bne _020C1810
	mov r0, r8
	mov r1, r7
	mov r2, r6
	mov r3, #0
	bl sub_20C1E90
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020C1810:
	ldrh r3, [r7, #8]
	ldrh r1, [r7, #0xa]
	ldrb r4, [r7, #0xd]
	mov r2, r3, asr #8
	orr r2, r2, r3, lsl #8
	mov r2, r2, lsl #0x10
	mov r3, r1, asr #8
	mov r2, r2, lsr #0x10
	orr r1, r3, r1, lsl #8
	mov r2, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r1, r2, r1, lsr #16
	str r1, [r5, #0x30]
	ldrh r9, [r7, #4]
	ldrh r1, [r7, #6]
	ldrb r3, [r5, #8]
	mov r2, r9, asr #8
	orr r2, r2, r9, lsl #8
	mov r2, r2, lsl #0x10
	mov r9, r1, asr #8
	mov r2, r2, lsr #0x10
	orr r1, r9, r1, lsl #8
	mov r2, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	cmp r3, #4
	orr r2, r2, r1, lsr #16
	bne _020C189C
	ldr r1, [r5, #0x24]
	cmp r1, r2
	beq _020C189C
	mov r1, #0
	bl sub_20C1FE0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020C189C:
	ldrh r1, [r7, #0xe]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	strh r0, [r5, #0x2c]
	ldrb r0, [r5, #8]
	cmp r0, #9
	addls pc, pc, r0, lsl #2
	b _020C1ACC
_020C18BC: // jump table
	b _020C18E4 // case 0
	b _020C1ACC // case 1
	b _020C18E4 // case 2
	b _020C18FC // case 3
	b _020C1928 // case 4
	b _020C1ACC // case 5
	b _020C1AA8 // case 6
	b _020C1A34 // case 7
	b _020C1A34 // case 8
	b _020C1AA8 // case 9
_020C18E4:
	mov r0, r8
	mov r1, r7
	mov r2, r6
	mov r3, #0
	bl sub_20C1E90
	b _020C1AE8
_020C18FC:
	mov r0, #4
	strb r0, [r5, #8]
	ldr r0, [r5, #4]
	cmp r0, #1
	bne _020C1920
	mov r0, #0
	str r0, [r5, #4]
	ldr r0, [r5]
	bl OS_WakeupThreadDirect
_020C1920:
	cmp r6, #0
	beq _020C1AE8
_020C1928:
	ldr r0, [r5, #0x34]
	add r0, r0, #1
	str r0, [r5, #0x34]
	ldr r1, [r5, #0x3c]
	ldr r0, [r5, #0x44]
	sub r0, r1, r0
	cmp r6, r0
	movhi r9, #0
	movhi r6, r0
	movls r9, #1
	cmp r6, #0
	beq _020C19C4
	bl OS_DisableInterrupts
	ldrb r1, [r7, #0xc]
	ldr ip, [r5, #0x40]
	ldr r3, [r5, #0x44]
	and r2, r1, #0xf0
	mov r1, r2, asr #1
	add r1, r2, r1, lsr #30
	mov r8, r0
	mov r2, r6
	add r0, r7, r1, asr #2
	add r1, ip, r3
	bl MI_CpuCopy8
	ldr r1, [r5, #0x44]
	mov r0, r8
	add r1, r1, r6
	str r1, [r5, #0x44]
	ldr r1, [r5, #0x24]
	add r1, r1, r6
	str r1, [r5, #0x24]
	bl OS_RestoreInterrupts
	ldr r0, [r5, #4]
	cmp r0, #2
	bne _020C19C4
	mov r0, #0
	str r0, [r5, #4]
	ldr r0, [r5]
	bl OS_WakeupThreadDirect
_020C19C4:
	cmp r9, #0
	beq _020C1A1C
	ands r0, r4, #1
	beq _020C1A1C
	mov r0, #6
	strb r0, [r5, #8]
	ldr r1, [r5, #0x24]
	mov r0, r5
	add r2, r1, #1
	mov r1, #0
	str r2, [r5, #0x24]
	bl sub_20C1FCC
	cmp r6, #0
	bne _020C1AE8
	ldr r0, [r5, #4]
	cmp r0, #2
	bne _020C1AE8
	mov r0, #0
	str r0, [r5, #4]
	ldr r0, [r5]
	bl OS_WakeupThreadDirect
	b _020C1AE8
_020C1A1C:
	cmp r6, #0
	beq _020C1AE8
	mov r0, r5
	mov r1, #0
	bl sub_20C1FE0
	b _020C1AE8
_020C1A34:
	ands r0, r4, #1
	beq _020C1A7C
	ldr r1, [r5, #0x24]
	add r0, r6, #1
	add r2, r1, r0
	mov r0, r5
	mov r1, #0
	str r2, [r5, #0x24]
	bl sub_20C1FE0
	mov r1, #0
	strb r1, [r5, #8]
	ldr r0, [r5, #4]
	cmp r0, #2
	bne _020C1AE8
	str r1, [r5, #4]
	ldr r0, [r5]
	bl OS_WakeupThreadDirect
	b _020C1AE8
_020C1A7C:
	cmp r6, #0
	beq _020C1A9C
	ldr r1, [r5, #0x24]
	mov r0, r5
	add r2, r1, r6
	mov r1, #0
	str r2, [r5, #0x24]
	bl sub_20C1FE0
_020C1A9C:
	mov r0, #8
	strb r0, [r5, #8]
	b _020C1AE8
_020C1AA8:
	mov r1, #0
	strb r1, [r5, #8]
	ldr r0, [r5, #4]
	cmp r0, #2
	bne _020C1AE8
	str r1, [r5, #4]
	ldr r0, [r5]
	bl OS_WakeupThreadDirect
	b _020C1AE8
_020C1ACC:
	ands r0, r4, #1
	ldrne r0, [r5, #0x24]
	mov r1, #0
	addne r0, r0, #1
	strne r0, [r5, #0x24]
	mov r0, r5
	bl sub_20C1FE0
_020C1AE8:
	bl OS_YieldThread
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20C17D0

	arm_func_start sub_20C1AF8
sub_20C1AF8: // 0x020C1AF8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r5, r1
	mov r6, r2
	bl sub_20C2124
	movs r4, r0
	beq _020C1B24
	ldrb r0, [r4, #8]
	cmp r0, #2
	beq _020C1B44
_020C1B24:
	mov r0, r7
	mov r1, r5
	mov r2, r6
	mov r3, #0
	bl sub_20C1E90
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020C1B44:
	bl OS_YieldThread
	ldrh r2, [r5, #4]
	ldrh ip, [r5, #6]
	mov r0, r5
	mov r1, r2, asr #8
	orr r1, r1, r2, lsl #8
	mov r1, r1, lsl #0x10
	mov r2, ip, asr #8
	mov r3, r1, lsr #0x10
	orr r1, r2, ip, lsl #8
	mov r2, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r1, r2, r1, lsr #16
	add r1, r1, #1
	str r1, [r4, #0x24]
	ldrh r3, [r5, #8]
	ldrh lr, [r5, #0xa]
	mov r1, r4
	mov r2, r3, asr #8
	orr r2, r2, r3, lsl #8
	mov r2, r2, lsl #0x10
	mov r3, lr, asr #8
	mov ip, r2, lsr #0x10
	orr r2, r3, lr, lsl #8
	mov r3, ip, lsl #0x10
	mov r2, r2, lsl #0x10
	orr r2, r3, r2, lsr #16
	str r2, [r4, #0x30]
	ldrh r3, [r5, #0xe]
	mov r2, r3, asr #8
	orr r2, r2, r3, lsl #8
	strh r2, [r4, #0x2c]
	bl sub_20C20A0
	mov r0, r4
	mov r1, #0
	bl sub_20C1FE0
	mov r0, #4
	strb r0, [r4, #8]
	ldr r0, [r4, #4]
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	mov r0, #0
	str r0, [r4, #4]
	ldr r0, [r4]
	bl OS_WakeupThreadDirect
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C1AF8

	arm_func_start sub_20C1C0C
sub_20C1C0C: // 0x020C1C0C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r0
	ldrh ip, [r4, #0x10]
	ldrh r7, [r4, #0xc]
	ldrh r3, [r4, #0x12]
	mov r5, ip, asr #8
	mov r6, r7, asr #8
	orr r5, r5, ip, lsl #8
	orr r6, r6, r7, lsl #8
	mov ip, r6, lsl #0x10
	ldrh r0, [r4, #0xe]
	mov lr, r5, lsl #0x10
	mov r5, r3, asr #8
	mov r6, r0, asr #8
	mov r7, ip, lsr #0x10
	orr r0, r6, r0, lsl #8
	orr r3, r5, r3, lsl #8
	mov ip, lr, lsr #0x10
	mov r6, r7, lsl #0x10
	mov r0, r0, lsl #0x10
	mov r5, ip, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r7, r1
	orr r1, r5, r3, lsr #16
	orr r0, r6, r0, lsr #16
	mov r5, r2
	bl sub_20C2438
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r4
	mov r1, r7
	mov r2, r5
	bl sub_20C1D10
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	mov r0, r4
	mov r1, r7
	bl sub_20C225C
	movs r2, r0
	beq _020C1CD8
	mov r0, r4
	mov r1, r7
	bl sub_20C1DA0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020C1CD8:
	bl OS_YieldThread
	mov r0, r4
	mov r1, r7
	bl sub_20C225C
	movs r2, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r4
	mov r1, r7
	bl sub_20C1DA0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C1C0C

	arm_func_start sub_20C1D10
sub_20C1D10: // 0x020C1D10
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	bl sub_20C2124
	movs r2, r0
	beq _020C1D94
	ldrb r0, [r2, #8]
	cmp r0, #1
	bne _020C1D48
	mov r0, r6
	mov r1, r5
	bl sub_20C1DA0
	b _020C1D88
_020C1D48:
	add r0, r0, #0xfd
	and r0, r0, #0xff
	cmp r0, #1
	bhi _020C1D74
	ldr r1, [r2, #0x28]
	mov r0, r6
	sub r3, r1, #1
	mov r1, r5
	str r3, [r2, #0x28]
	bl sub_20C1DA0
	b _020C1D88
_020C1D74:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	mov r3, #0
	bl sub_20C1E90
_020C1D88:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C1D94:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C1D10

	arm_func_start sub_20C1DA0
sub_20C1DA0: // 0x020C1DA0
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r2
	mov r2, #3
	mov r6, r0
	mov r5, r1
	strb r2, [r4, #8]
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	str r0, [r4, #0x10]
	ldrh r2, [r6, #0x10]
	ldrh r3, [r6, #0x12]
	mov r0, r5
	mov r1, r2, asr #8
	orr r1, r1, r2, lsl #8
	mov r1, r1, lsl #0x10
	mov r2, r3, asr #8
	orr r2, r2, r3, lsl #8
	mov r1, r1, lsr #0x10
	mov r3, r1, lsl #0x10
	mov r1, r2, lsl #0x10
	orr r1, r3, r1, lsr #16
	str r1, [r4, #0x14]
	ldrh r3, [r5]
	mov r1, r4
	mov r2, r3, asr #8
	orr r2, r2, r3, lsl #8
	strh r2, [r4, #0x18]
	ldrh r3, [r6, #0xc]
	ldrh r6, [r6, #0xe]
	mov r2, r3, asr #8
	orr r2, r2, r3, lsl #8
	mov r2, r2, lsl #0x10
	mov r3, r6, asr #8
	orr r3, r3, r6, lsl #8
	mov r2, r2, lsr #0x10
	mov r6, r2, lsl #0x10
	mov r2, r3, lsl #0x10
	orr r2, r6, r2, lsr #16
	str r2, [r4, #0x1c]
	ldrh r3, [r5, #4]
	ldrh r6, [r5, #6]
	mov r2, r3, asr #8
	orr r2, r2, r3, lsl #8
	mov r2, r2, lsl #0x10
	mov r3, r6, asr #8
	mov r5, r2, lsr #0x10
	orr r2, r3, r6, lsl #8
	mov r3, r5, lsl #0x10
	mov r2, r2, lsl #0x10
	orr r2, r3, r2, lsr #16
	add r2, r2, #1
	str r2, [r4, #0x24]
	bl sub_20C20A0
	mov r0, r4
	mov r1, #0x12
	mov r2, #0
	bl sub_20C1FF4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C1DA0

	arm_func_start sub_20C1E90
sub_20C1E90: // 0x020C1E90
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r4, _020C1FC8 // =0x021459B4
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r0, r4
	mov r1, #0
	mov r2, #0x64
	mov r5, r3
	bl MI_CpuFill8
	ldrh r2, [r7, #2]
	mov r1, r4
	mov r0, r2, asr #8
	orr r0, r0, r2, lsl #8
	strh r0, [r1, #0xa]
	ldrh r2, [r7]
	mov r0, r2, asr #8
	orr r0, r0, r2, lsl #8
	strh r0, [r1, #0x18]
	ldrh r2, [r8, #0xc]
	ldrh r8, [r8, #0xe]
	mov r0, r2, asr #8
	orr r0, r0, r2, lsl #8
	mov r0, r0, lsl #0x10
	mov r2, r8, asr #8
	mov r3, r0, lsr #0x10
	orr r0, r2, r8, lsl #8
	mov r2, r3, lsl #0x10
	mov r0, r0, lsl #0x10
	orr r0, r2, r0, lsr #16
	str r0, [r1, #0x1c]
	ldrb r0, [r7, #0xd]
	ands r0, r0, #0x10
	beq _020C1F60
	ldrh r2, [r7, #8]
	ldrh r6, [r7, #0xa]
	mov r0, r4
	mov r1, r2, asr #8
	orr r1, r1, r2, lsl #8
	mov r1, r1, lsl #0x10
	mov r2, r6, asr #8
	mov r3, r1, lsr #0x10
	orr r1, r2, r6, lsl #8
	mov r2, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r3, r2, r1, lsr #16
	mov r2, r5
	mov r1, #4
	str r3, [r4, #0x28]
	bl sub_20C1FF4
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020C1F60:
	mov r0, #0
	str r0, [r4, #0x28]
	ldrh r1, [r7, #4]
	ldrh r3, [r7, #6]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	mov r1, r3, asr #8
	mov r2, r0, lsr #0x10
	orr r0, r1, r3, lsl #8
	mov r1, r2, lsl #0x10
	mov r0, r0, lsl #0x10
	orr r0, r1, r0, lsr #16
	add r0, r6, r0
	str r0, [r4, #0x24]
	ldrb r0, [r7, #0xd]
	mov r2, r5
	mov r1, #0x14
	ands r0, r0, #3
	ldrne r0, [r4, #0x24]
	addne r0, r0, #1
	strne r0, [r4, #0x24]
	mov r0, r4
	bl sub_20C1FF4
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C1FC8: .word 0x021459B4
	arm_func_end sub_20C1E90

	arm_func_start sub_20C1FCC
sub_20C1FCC: // 0x020C1FCC
	ldr ip, _020C1FDC // =sub_20C1FF4
	mov r2, r1
	mov r1, #0x11
	bx ip
	.align 2, 0
_020C1FDC: .word sub_20C1FF4
	arm_func_end sub_20C1FCC

	arm_func_start sub_20C1FE0
sub_20C1FE0: // 0x020C1FE0
	ldr ip, _020C1FF0 // =sub_20C1FF4
	mov r2, r1
	mov r1, #0x10
	bx ip
	.align 2, 0
_020C1FF0: .word sub_20C1FF4
	arm_func_end sub_20C1FE0

	arm_func_start sub_20C1FF4
sub_20C1FF4: // 0x020C1FF4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r0, [r6, #0x1c]
	mov r5, r1
	mov r4, r2
	bl sub_20C2070
	cmp r0, #0
	bne _020C202C
	ldr r0, _020C2068 // =OSi_ThreadInfo
	ldr r1, _020C206C // =0x02145AD8
	ldr r0, [r0, #4]
	cmp r0, r1
	beq _020C2050
_020C202C:
	mov r0, #0
	mov r1, r0
	mov r2, r6
	mov r3, r5
	str r4, [sp]
	bl sub_20C28D4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C2050:
	ldr r0, [r6, #0x1c]
	bl sub_20C3B0C
	bl sub_20C3394
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C2068: .word OSi_ThreadInfo
_020C206C: .word 0x02145AD8
	arm_func_end sub_20C1FF4

	arm_func_start sub_20C2070
sub_20C2070: // 0x020C2070
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20C3B0C
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {lr}
	bxeq lr
	bl sub_20C3494
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C2070

	arm_func_start sub_20C20A0
sub_20C20A0: // 0x020C20A0
	mov r2, #0x218
	strh r2, [r1, #0x2e]
	ldrb r2, [r0, #0xc]
	add r3, r0, #0x14
	and r2, r2, #0xf0
	mov r0, r2, asr #1
	add r0, r2, r0, lsr #30
	mov r0, r0, asr #2
	subs r0, r0, #0x14
	sub ip, r0, #1
	bxeq lr
_020C20CC:
	ldrb r0, [r3], #1
	cmp r0, #0
	bxeq lr
	cmp r0, #1
	beq _020C2114
	cmp r0, #2
	bne _020C2104
	ldrb r2, [r3, #1]
	ldrb r0, [r3, #2]
	add r3, r3, #3
	sub ip, ip, #3
	orr r0, r0, r2, lsl #8
	strh r0, [r1, #0x2e]
	b _020C2114
_020C2104:
	ldrb r0, [r3]
	sub r0, r0, #1
	sub ip, ip, r0
	add r3, r3, r0
_020C2114:
	cmp ip, #0
	sub ip, ip, #1
	bne _020C20CC
	bx lr
	arm_func_end sub_20C20A0

	arm_func_start sub_20C2124
sub_20C2124: // 0x020C2124
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r2, _020C219C // =OSi_ThreadInfo
	mov r7, r0
	ldr r4, [r2, #8]
	mov r6, r1
	cmp r4, #0
	beq _020C218C
_020C2144:
	ldr r5, [r4, #0xa4]
	cmp r5, #0
	beq _020C2180
	ldr r0, [r5]
	cmp r0, #0
	beq _020C2180
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl sub_20C21A0
	cmp r0, #0
	addne sp, sp, #4
	movne r0, r5
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
_020C2180:
	ldr r4, [r4, #0x68]
	cmp r4, #0
	bne _020C2144
_020C218C:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020C219C: .word OSi_ThreadInfo
	arm_func_end sub_20C2124

	arm_func_start sub_20C21A0
sub_20C21A0: // 0x020C21A0
	stmdb sp!, {r4, r5, r6, lr}
	ldrb r4, [r2, #8]
	mov ip, #0
	mov r3, ip
	mov r6, ip
	mov r5, ip
	cmp r4, #0xa
	beq _020C21C8
	cmp r4, #0xb
	movne r5, #1
_020C21C8:
	cmp r5, #0
	beq _020C21EC
	ldrh lr, [r1, #2]
	ldrh r5, [r2, #0xa]
	mov r4, lr, asr #8
	orr r4, r4, lr, lsl #8
	mov lr, r4, lsl #0x10
	cmp r5, lr, lsr #16
	moveq r6, #1
_020C21EC:
	cmp r6, #0
	beq _020C2210
	ldrh r4, [r1]
	ldrh lr, [r2, #0x18]
	mov r1, r4, asr #8
	orr r1, r1, r4, lsl #8
	mov r1, r1, lsl #0x10
	cmp lr, r1, lsr #16
	moveq r3, #1
_020C2210:
	cmp r3, #0
	beq _020C2250
	ldrh r1, [r0, #0xc]
	ldrh lr, [r0, #0xe]
	ldr r3, [r2, #0x1c]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	mov r1, lr, asr #8
	mov r2, r0, lsr #0x10
	orr r0, r1, lr, lsl #8
	mov r1, r2, lsl #0x10
	mov r0, r0, lsl #0x10
	orr r0, r1, r0, lsr #16
	cmp r3, r0
	moveq ip, #1
_020C2250:
	mov r0, ip
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C21A0

	arm_func_start sub_20C225C
sub_20C225C: // 0x020C225C
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _020C2338 // =OSi_ThreadInfo
	ldr r3, [r2, #8]
	cmp r3, #0
	beq _020C232C
_020C2270:
	ldr ip, [r3, #0xa4]
	cmp ip, #0
	beq _020C2320
	ldr r2, [ip]
	cmp r2, #0
	beq _020C2320
	ldrb r2, [ip, #8]
	cmp r2, #1
	bne _020C2320
	ldrh r5, [r1, #2]
	ldrh r4, [ip, #0xa]
	mov r2, r5, asr #8
	orr r2, r2, r5, lsl #8
	mov r2, r2, lsl #0x10
	cmp r4, r2, lsr #16
	bne _020C2320
	ldrh r5, [ip, #0x18]
	cmp r5, #0
	beq _020C22D4
	ldrh r4, [r1]
	mov r2, r4, asr #8
	orr r2, r2, r4, lsl #8
	mov r2, r2, lsl #0x10
	cmp r5, r2, lsr #16
	bne _020C2320
_020C22D4:
	ldr r2, [ip, #0x1c]
	cmp r2, #0
	beq _020C2314
	ldrh r5, [r0, #0xc]
	ldrh r6, [r0, #0xe]
	mov r4, r5, asr #8
	orr r4, r4, r5, lsl #8
	mov lr, r4, lsl #0x10
	mov r4, r6, asr #8
	mov lr, lr, lsr #0x10
	orr r4, r4, r6, lsl #8
	mov r5, lr, lsl #0x10
	mov lr, r4, lsl #0x10
	orr r4, r5, lr, lsr #16
	cmp r2, r4
	bne _020C2320
_020C2314:
	mov r0, ip
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C2320:
	ldr r3, [r3, #0x68]
	cmp r3, #0
	bne _020C2270
_020C232C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C2338: .word OSi_ThreadInfo
	arm_func_end sub_20C225C

	arm_func_start sub_20C233C
sub_20C233C: // 0x020C233C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r1
	mov r4, r2
	mov r6, r0
	mov r0, r5
	mov r1, r4
	bl sub_20C3BE0
	ldr r1, _020C2434 // =0x0000FFFF
	cmp r0, r1
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldrh ip, [r6, #0x10]
	ldrh r7, [r6, #0xc]
	ldrh r0, [r6, #0xe]
	ldrh r1, [r6, #0x12]
	mov r3, r7, asr #8
	mov lr, r0, asr #8
	orr r0, lr, r0, lsl #8
	mov r2, ip, asr #8
	orr r7, r3, r7, lsl #8
	orr r3, r2, ip, lsl #8
	mov r2, r7, lsl #0x10
	mov ip, r1, asr #8
	orr r1, ip, r1, lsl #8
	mov r3, r3, lsl #0x10
	mov r7, r2, lsr #0x10
	mov r2, r3, lsr #0x10
	mov r3, r7, lsl #0x10
	mov r0, r0, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r0, r3, r0, lsr #16
	orr r1, r2, r1, lsr #16
	bl sub_20C2438
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldrb r0, [r5]
	cmp r0, #0
	beq _020C23FC
	cmp r0, #8
	beq _020C2418
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020C23FC:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20C2468
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020C2418:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20C2580
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020C2434: .word 0x0000FFFF
	arm_func_end sub_20C233C

	arm_func_start sub_20C2438
sub_20C2438: // 0x020C2438
	cmp r0, #0
	beq _020C2460
	mvn r2, #0
	cmp r0, r2
	beq _020C2460
	cmp r1, #0
	beq _020C2460
	cmp r1, r2
	movne r0, #1
	bxne lr
_020C2460:
	mov r0, #0
	bx lr
	arm_func_end sub_20C2438

	arm_func_start sub_20C2468
sub_20C2468: // 0x020C2468
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl OS_DisableInterrupts
	ldr r1, _020C257C // =OSi_ThreadInfo
	mov r8, r0
	ldr r2, [r1, #8]
	cmp r2, #0
	beq _020C256C
_020C2490:
	ldr r4, [r2, #0xa4]
	cmp r4, #0
	beq _020C2560
	ldr r3, [r4]
	cmp r3, #0
	beq _020C2560
	ldrb r0, [r4, #8]
	cmp r0, #0xb
	bne _020C2560
	ldrh r1, [r6, #4]
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, r1
	bne _020C2560
	ldrh r1, [r4, #0xa]
	ldrh r0, [r6, #6]
	cmp r1, r0
	bne _020C2560
	ldr r0, [r4, #0x44]
	cmp r0, #0
	bne _020C2560
	ldrh ip, [r7, #0xc]
	ldrh r1, [r7, #0xe]
	ldr r0, [r4, #0x1c]
	mov r3, ip, asr #8
	orr r3, r3, ip, lsl #8
	mov r3, r3, lsl #0x10
	mov ip, r1, asr #8
	mov r3, r3, lsr #0x10
	orr r1, ip, r1, lsl #8
	mov r3, r3, lsl #0x10
	mov r1, r1, lsl #0x10
	orr r1, r3, r1, lsr #16
	cmp r0, r1
	bne _020C2560
	ldr r1, [r4, #0x3c]
	sub r0, r5, #8
	cmp r0, r1
	strhi r1, [r4, #0x44]
	strls r0, [r4, #0x44]
	ldr r1, [r4, #0x40]
	ldr r2, [r4, #0x44]
	add r0, r6, #8
	bl MI_CpuCopy8
	ldr r0, [r4, #4]
	cmp r0, #3
	bne _020C256C
	mov r0, #0
	str r0, [r4, #4]
	ldr r0, [r4]
	bl OS_WakeupThreadDirect
	b _020C256C
_020C2560:
	ldr r2, [r2, #0x68]
	cmp r2, #0
	bne _020C2490
_020C256C:
	mov r0, r8
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C257C: .word OSi_ThreadInfo
	arm_func_end sub_20C2468

	arm_func_start sub_20C2580
sub_20C2580: // 0x020C2580
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r6, r0
	ldrh r3, [r6, #0xc]
	ldrh r4, [r6, #0xe]
	mov r5, r1
	mov r0, r3, asr #8
	orr r0, r0, r3, lsl #8
	mov r0, r0, lsl #0x10
	mov r1, r4, asr #8
	mov r3, r0, lsr #0x10
	orr r0, r1, r4, lsl #8
	mov r1, r3, lsl #0x10
	mov r0, r0, lsl #0x10
	orr r0, r1, r0, lsr #16
	mov r4, r2
	bl sub_20C3B0C
	movs r7, r0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	bl sub_20C3494
	cmp r0, #0
	bne _020C25F4
	mov r0, r7
	bl sub_20C3394
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020C25F4:
	mov r2, #0
	strb r2, [r5]
	mov r0, r5
	mov r1, r4
	strh r2, [r5, #2]
	bl sub_20C3BE0
	mov r1, r0, asr #8
	orr r0, r1, r0, lsl #8
	strh r0, [r5, #2]
	ldrh r1, [r6, #0xc]
	ldrh r6, [r6, #0xe]
	mov r2, #0
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	mov r1, r6, asr #8
	mov r3, r0, lsr #0x10
	orr r0, r1, r6, lsl #8
	mov r1, r3, lsl #0x10
	mov r0, r0, lsl #0x10
	orr r6, r1, r0, lsr #16
	mov r0, r5
	mov r1, r4
	mov r3, r2
	str r6, [sp]
	mov r4, #1
	str r4, [sp, #4]
	bl sub_20C2D58
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C2580

	arm_func_start sub_20C2670
sub_20C2670: // 0x020C2670
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	cmp r1, #0x1c
	mov r6, r0
	addlo sp, sp, #4
	ldmloia sp!, {r4, r5, r6, r7, lr}
	bxlo lr
	ldr r1, _020C2818 // =0x0214588C
	add r0, r6, #8
	bl sub_20C39FC
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr r0, _020C281C // =0x0214587C
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldrh r0, [r6]
	cmp r0, #0x100
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldrh r0, [r6, #2]
	cmp r0, #8
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldrh r1, [r6, #4]
	ldr r0, _020C2820 // =0x00000406
	cmp r1, r0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldrh r1, [r6, #6]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	cmp r4, #1
	beq _020C272C
	cmp r4, #2
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
_020C272C:
	ldrh r1, [r6, #0xe]
	ldrh r5, [r6, #0x10]
	ldr r2, _020C281C // =0x0214587C
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r1, r5, asr #8
	orr r0, r1, r5, lsl #8
	mov r1, r0, lsl #0x10
	mov r3, r3, lsl #0x10
	orr r1, r3, r1, lsr #16
	ldr r0, [r2]
	ldrh r3, [r6, #0x18]
	ldrh lr, [r6, #0x1a]
	cmp r1, r0
	mov r2, r3, asr #8
	orr r2, r2, r3, lsl #8
	mov r2, r2, lsl #0x10
	moveq r5, #1
	mov r3, lr, asr #8
	mov ip, r2, lsr #0x10
	orr r2, r3, lr, lsl #8
	mov r3, ip, lsl #0x10
	mov r2, r2, lsl #0x10
	orr r2, r3, r2, lsr #16
	movne r5, #0
	cmp r0, r2
	moveq r7, #1
	movne r7, #0
	cmp r5, #0
	bne _020C27B8
	mov r2, r7
	add r0, r6, #8
	bl sub_20C3188
_020C27B8:
	cmp r4, #1
	bne _020C27DC
	cmp r7, #0
	beq _020C27DC
	mov r0, r6
	bl sub_20C2828
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020C27DC:
	cmp r4, #2
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	cmp r7, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	cmp r5, #0
	ldrne r0, _020C2824 // =0x02145824
	movne r1, #1
	strneb r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020C2818: .word 0x0214588C
_020C281C: .word 0x0214587C
_020C2820: .word 0x00000406
_020C2824: .word 0x02145824
	arm_func_end sub_20C2670

	arm_func_start sub_20C2828
sub_20C2828: // 0x020C2828
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r3, #0x200
	add r0, r4, #8
	add r1, r4, #0x12
	mov r2, #0xa
	strh r3, [r4, #6]
	bl MI_CpuCopy8
	ldr r0, _020C28CC // =0x0214588C
	add r1, r4, #8
	mov r2, #6
	bl MI_CpuCopy8
	ldr r3, _020C28D0 // =0x0214587C
	add r0, r4, #0x12
	ldr r2, [r3]
	sub r1, r4, #0xe
	mov r2, r2, lsr #0x10
	mov r2, r2, lsl #0x10
	mov ip, r2, lsr #0x10
	mov r2, ip, asr #8
	orr r2, r2, ip, lsl #8
	strh r2, [r4, #0xe]
	ldr r3, [r3]
	mov r2, #6
	mov r3, r3, lsl #0x10
	mov ip, r3, lsr #0x10
	mov r3, ip, asr #8
	orr r3, r3, ip, lsl #8
	strh r3, [r4, #0x10]
	bl MI_CpuCopy8
	ldr r0, _020C28CC // =0x0214588C
	sub r1, r4, #8
	mov r2, #6
	bl MI_CpuCopy8
	sub r0, r4, #0xe
	mov r1, #0x2a
	mov r2, #0
	mov r3, r2
	bl sub_20C398C
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C28CC: .word 0x0214588C
_020C28D0: .word 0x0214587C
	arm_func_end sub_20C2828

	arm_func_start sub_20C28D4
sub_20C28D4: // 0x020C28D4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r7, r2
	ldrb r2, [r7, #8]
	mov r9, r0
	mov r8, r1
	cmp r2, #0
	mov r6, r3
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	ldr r0, _020C2B48 // =OSi_ThreadInfo
	ldr r3, _020C2B4C // =0x0214587C
	ldr r1, _020C2B50 // =0x02145AD8
	ldr r0, [r0, #4]
	ldr ip, [r3]
	cmp r0, r1
	ldreq r4, _020C2B54 // =0x021458D6
	ldrne r0, [r7, #0x4c]
	addne r4, r0, #0x22
	ands r0, r6, #2
	movne r5, #0x18
	moveq r5, #0x14
	add r1, r5, r8
	mov r2, r1, lsl #0x10
	mov r1, ip, lsr #0x10
	mov r1, r1, lsl #0x10
	mov ip, r1, lsr #0x10
	mov r1, ip, asr #8
	orr r1, r1, ip, lsl #8
	strh r1, [r4, #-0xc]
	ldr r1, [r3]
	mov ip, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	mov r1, r2, asr #8
	orr r1, r1, r2, lsl #8
	strh r1, [r4, #-0xa]
	ldr r1, [r7, #0x1c]
	mov r3, ip, asr #8
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	mov r1, r2, asr #8
	orr r1, r1, r2, lsl #8
	strh r1, [r4, #-8]
	ldr r1, [r7, #0x1c]
	mov r2, r5, lsr #2
	mov r1, r1, lsl #0x10
	mov lr, r1, lsr #0x10
	mov r1, lr, asr #8
	orr r1, r1, lr, lsl #8
	strh r1, [r4, #-6]
	mov r1, #0x600
	strh r1, [r4, #-4]
	orr r1, r3, ip, lsl #8
	strh r1, [r4, #-2]
	ldrh ip, [r7, #0xa]
	cmp r0, #0
	mov r2, r2, lsl #4
	mov r3, ip, asr #8
	orr r3, r3, ip, lsl #8
	strh r3, [r4]
	ldrh r3, [r7, #0x18]
	mov r1, #0
	mov r0, r3, asr #8
	orr r0, r0, r3, lsl #8
	strh r0, [r4, #2]
	ldr r0, [r7, #0x28]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r3, asr #8
	orr r0, r0, r3, lsl #8
	strh r0, [r4, #4]
	ldr r0, [r7, #0x28]
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r3, asr #8
	orr r0, r0, r3, lsl #8
	strh r0, [r4, #6]
	ldr r0, [r7, #0x24]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r3, asr #8
	orr r0, r0, r3, lsl #8
	strh r0, [r4, #8]
	ldr r0, [r7, #0x24]
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r3, asr #8
	orr r0, r0, r3, lsl #8
	strh r0, [r4, #0xa]
	strb r2, [r4, #0xc]
	strb r6, [r4, #0xd]
	ldr r2, [r7, #0x3c]
	ldr r0, [r7, #0x44]
	sub r0, r2, r0
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r2, asr #8
	orr r0, r0, r2, lsl #8
	strh r0, [r4, #0xe]
	strh r1, [r4, #0x10]
	strh r1, [r4, #0x12]
	beq _020C2AC0
	ldr r1, _020C2B58 // =0x02145828
	ldrh r0, [r1]
	add r0, r0, #0x2040000
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r2, asr #8
	orr r0, r0, r2, lsl #8
	strh r0, [r4, #0x14]
	ldrh r0, [r1]
	add r0, r0, #0x2040000
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	strh r0, [r4, #0x16]
_020C2AC0:
	sub r0, r4, #0xc
	add r1, r5, #0xc
	mov r2, #0
	bl sub_20C3C24
	mov r2, r0
	mov r0, r9
	mov r1, r8
	bl sub_20C3C24
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl sub_20C3C08
	mov r3, r0, asr #8
	orr r0, r3, r0, lsl #8
	strh r0, [r4, #0x10]
	mov r0, r4
	ldr r4, [r7, #0x1c]
	mov r3, #6
	str r4, [sp]
	str r3, [sp, #4]
	mov r1, r5
	mov r2, r9
	mov r3, r8
	bl sub_20C2D58
	ands r0, r6, #3
	ldr r0, [r7, #0x28]
	add r1, r7, #0x28
	add r0, r0, r8
	str r0, [r7, #0x28]
	ldrne r0, [r1]
	addne r0, r0, #1
	strne r0, [r1]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020C2B48: .word OSi_ThreadInfo
_020C2B4C: .word 0x0214587C
_020C2B50: .word 0x02145AD8
_020C2B54: .word 0x021458D6
_020C2B58: .word 0x02145828
	arm_func_end sub_20C28D4

	arm_func_start sub_20C2B5C
sub_20C2B5C: // 0x020C2B5C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r7, _020C2C98 // =0x0214587C
	mov r5, r2
	ldr r2, [r7]
	mov r6, r1
	mov r1, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	ldr r3, [r5, #0x4c]
	mov r1, r2, asr #8
	add r4, r3, #0x22
	orr r1, r1, r2, lsl #8
	strh r1, [r4, #-0xc]
	ldr r1, [r7]
	add r2, r6, #8
	mov r1, r1, lsl #0x10
	mov r7, r1, lsr #0x10
	mov r1, r7, asr #8
	orr r1, r1, r7, lsl #8
	strh r1, [r4, #-0xa]
	ldr r1, [r5, #0x1c]
	mov r2, r2, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r7, r1, lsr #0x10
	mov r1, r7, asr #8
	orr r1, r1, r7, lsl #8
	strh r1, [r4, #-8]
	ldr r1, [r5, #0x1c]
	mov r2, r2, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r7, r1, lsr #0x10
	mov r1, r7, asr #8
	orr r7, r1, r7, lsl #8
	mov r1, r2, asr #8
	strh r7, [r4, #-6]
	mov r7, #0x1100
	strh r7, [r4, #-4]
	orr r1, r1, r2, lsl #8
	strh r1, [r4, #4]
	ldrh r1, [r4, #4]
	mov r7, r0
	sub r0, r4, #0xc
	strh r1, [r4, #-2]
	ldrh lr, [r5, #0x18]
	mov r2, #0
	mov r1, #0x14
	mov ip, lr, asr #8
	orr ip, ip, lr, lsl #8
	strh ip, [r4, #2]
	ldrh lr, [r5, #0xa]
	mov ip, lr, asr #8
	orr ip, ip, lr, lsl #8
	strh ip, [r3, #0x22]
	strh r2, [r4, #6]
	bl sub_20C3C24
	mov r2, r0
	mov r0, r7
	mov r1, r6
	bl sub_20C3C24
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl sub_20C3C08
	mov r2, r7
	mov r3, r6
	mov r1, r0, asr #8
	orr r0, r1, r0, lsl #8
	strh r0, [r4, #6]
	ldr r1, [r5, #0x1c]
	mov r0, r4
	str r1, [sp]
	mov r1, #0x11
	str r1, [sp, #4]
	mov r1, #8
	bl sub_20C2D58
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020C2C98: .word 0x0214587C
	arm_func_end sub_20C2B5C

	arm_func_start sub_20C2C9C
sub_20C2C9C: // 0x020C2C9C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r5, r2
	ldr r3, [r5, #0x4c]
	mov r6, r1
	mov r1, #8
	ldr r2, _020C2D50 // =OSi_ThreadInfo
	strh r1, [r3, #0x22]
	ldr r2, [r2, #4]
	add r4, r3, #0x22
	strh r2, [r4, #4]
	mov r2, #0
	ldr r3, _020C2D54 // =0x0214582C
	strh r2, [r4, #2]
	ldrh lr, [r3]
	mov r7, r0
	mov r0, r4
	strh lr, [r5, #0xa]
	ldrh ip, [r3]
	add ip, ip, #1
	strh ip, [r3]
	strh lr, [r4, #6]
	bl sub_20C3C24
	mov r2, r0
	mov r0, r7
	mov r1, r6
	bl sub_20C3C24
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl sub_20C3C08
	mov r2, r7
	mov r3, r6
	mov r1, r0, asr #8
	orr r0, r1, r0, lsl #8
	strh r0, [r4, #2]
	ldr r1, [r5, #0x1c]
	mov r0, r4
	str r1, [sp]
	mov r1, #1
	str r1, [sp, #4]
	mov r1, #8
	bl sub_20C2D58
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020C2D50: .word OSi_ThreadInfo
_020C2D54: .word 0x0214582C
	arm_func_end sub_20C2C9C

	arm_func_start sub_20C2D58
sub_20C2D58: // 0x020C2D58
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	mov r0, #0x45
	strb r0, [r10, #-0x14]
	mov r5, #0
	ldr r0, _020C2F68 // =0x02145830
	strb r5, [r10, #-0x13]
	ldrh r7, [r0]
	ldr r6, [sp, #0x30]
	ldrb r4, [sp, #0x34]
	add r7, r7, #1
	strh r7, [r0]
	ldrh r9, [r0]
	mov r0, r6, lsr #0x10
	mov r7, #0x80
	mov r8, r9, asr #8
	orr r8, r8, r9, lsl #8
	strh r8, [r10, #-0x10]
	strb r7, [r10, #-0xc]
	ldr r7, _020C2F6C // =0x0214587C
	strb r4, [r10, #-0xb]
	ldr r8, [r7]
	mov r4, r0, lsl #0x10
	mov r0, r8, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	mov r0, r8, asr #8
	orr r0, r0, r8, lsl #8
	strh r0, [r10, #-8]
	ldr r0, [r7]
	mov r8, r4, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	mov r4, r7, asr #8
	mov r0, r6, lsl #0x10
	orr r9, r4, r7, lsl #8
	mov r7, r8, asr #8
	mov r4, r0, lsr #0x10
	mov r0, r4, asr #8
	strh r9, [r10, #-6]
	orr r7, r7, r8, lsl #8
	ldr r11, _020C2F70 // =0x000005C8
	mov r9, r1
	strh r7, [r10, #-4]
	orr r0, r0, r4, lsl #8
	mov r8, r2
	mov r7, r3
	strh r0, [r10, #-2]
	cmp r9, r11
	bls _020C2ED0
	mov r4, r10
	cmp r9, r11
	bls _020C2E70
	str r5, [sp, #8]
_020C2E34:
	ldr r1, [sp, #8]
	mov r0, r10
	mov r2, r4
	mov r3, r11
	str r6, [sp]
	orr ip, r5, #0x2000
	str ip, [sp, #4]
	bl sub_20C2F74
	add r0, r5, #0xb9
	sub r9, r9, r11
	mov r0, r0, lsl #0x10
	cmp r9, r11
	add r4, r4, r11
	mov r5, r0, lsr #0x10
	bhi _020C2E34
_020C2E70:
	cmp r9, #0
	beq _020C2ED0
	cmp r7, #0
	beq _020C2EA4
	mov r0, r10
	mov r2, r4
	mov r3, r9
	str r6, [sp]
	orr r4, r5, #0x2000
	mov r1, #0
	str r4, [sp, #4]
	bl sub_20C2F74
	b _020C2EC0
_020C2EA4:
	str r6, [sp]
	mov r0, r10
	mov r2, r4
	mov r3, r9
	mov r1, #0
	str r5, [sp, #4]
	bl sub_20C2F74
_020C2EC0:
	add r0, r5, r9, lsr #3
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	mov r9, #0
_020C2ED0:
	ldr r0, _020C2F70 // =0x000005C8
	add r1, r9, r7
	cmp r1, r0
	bls _020C2F30
	mov r11, #0
_020C2EE4:
	ldr r0, _020C2F70 // =0x000005C8
	mov r1, r9
	sub r4, r0, r9
	mov r0, r10
	mov r2, r8
	mov r3, r4
	str r6, [sp]
	orr r9, r5, #0x2000
	str r9, [sp, #4]
	bl sub_20C2F74
	add r0, r5, #0xb9
	mov r1, r0, lsl #0x10
	ldr r0, _020C2F70 // =0x000005C8
	sub r7, r7, r4
	mov r9, r11
	cmp r7, r0
	add r8, r8, r4
	mov r5, r1, lsr #0x10
	bhi _020C2EE4
_020C2F30:
	adds r0, r9, r7
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	str r6, [sp]
	mov r0, r10
	mov r1, r9
	mov r2, r8
	mov r3, r7
	str r5, [sp, #4]
	bl sub_20C2F74
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C2F68: .word 0x02145830
_020C2F6C: .word 0x0214587C
_020C2F70: .word 0x000005C8
	arm_func_end sub_20C2D58

	arm_func_start sub_20C2F74
sub_20C2F74: // 0x020C2F74
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r7, r1
	mov r5, r3
	add r1, r7, #0x14
	add r1, r1, r5
	ldr r3, [sp, #0x24]
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	mov r1, r3, lsl #0x10
	mov r3, r4, asr #8
	mov r1, r1, lsr #0x10
	mov r8, r0
	orr r3, r3, r4, lsl #8
	mov r0, r1, asr #8
	strh r3, [r8, #-0x12]
	orr r0, r0, r1, lsl #8
	strh r0, [r8, #-0xe]
	mov r3, #0
	sub r0, r8, #0x14
	mov r1, #0x14
	mov r6, r2
	strh r3, [r8, #-0xa]
	ldr r4, [sp, #0x20]
	bl sub_20C3BE0
	mov r2, r0, asr #8
	ldr r1, _020C309C // =0x7F000001
	orr r0, r2, r0, lsl #8
	strh r0, [r8, #-0xa]
	cmp r4, r1
	beq _020C3020
	ldr r0, _020C30A0 // =0x0214587C
	ldr r0, [r0]
	cmp r4, r0
	beq _020C3020
	mov r2, r6
	mov r3, r5
	str r4, [sp]
	mov ip, #0x800
	sub r0, r8, #0x14
	add r1, r7, #0x14
	str ip, [sp, #4]
	bl sub_20C30AC
_020C3020:
	ldr r0, _020C309C // =0x7F000001
	cmp r4, r0
	beq _020C3054
	ldr r0, _020C30A0 // =0x0214587C
	ldr r0, [r0]
	cmp r4, r0
	beq _020C3054
	mov r0, r4
	bl sub_20C3AB0
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
_020C3054:
	ldr r0, _020C30A4 // =0x0211F1D4
	sub r1, r8, #0x1c
	mov r2, #8
	bl MI_CpuCopy8
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r0, _020C30A8 // =0x0214588C
	str r6, [sp]
	mov r1, r0
	str r5, [sp, #4]
	sub r2, r8, #0x1c
	add r3, r7, #0x1c
	bl sub_20C371C
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C309C: .word 0x7F000001
_020C30A0: .word 0x0214587C
_020C30A4: .word 0x0211F1D4
_020C30A8: .word 0x0214588C
	arm_func_end sub_20C2F74

	arm_func_start sub_20C30AC
sub_20C30AC: // 0x020C30AC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldrh r5, [sp, #0x1c]
	ldr r4, [sp, #0x18]
	mov r8, r0
	mov r0, r5, asr #8
	orr ip, r0, r5, lsl #8
	mov r0, r4
	mov r7, r1
	mov r6, r2
	mov r5, r3
	strh ip, [r8, #-2]
	bl sub_20C3AB0
	cmp r0, #0
	bne _020C3128
	mov r0, r4
	bl sub_20C3B0C
	movs r4, r0
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	bl sub_20C3494
	cmp r0, #0
	bne _020C310C
	mov r0, r4
	bl sub_20C3308
_020C310C:
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	sub r1, r8, #0xe
	mov r2, #6
	bl MI_CpuCopy8
	b _020C3158
_020C3128:
	mov r0, #1
	strb r0, [r8, #-0xe]
	mov r1, #0
	mov r0, r4, lsr #0x10
	strb r1, [r8, #-0xd]
	mov r1, #0x5e
	strb r1, [r8, #-0xc]
	and r0, r0, #0x7f
	strb r0, [r8, #-0xb]
	mov r0, r4, lsr #8
	strb r0, [r8, #-0xa]
	strb r4, [r8, #-9]
_020C3158:
	ldr r0, _020C3184 // =0x0214588C
	sub r1, r8, #8
	mov r2, #6
	bl MI_CpuCopy8
	mov r2, r6
	mov r3, r5
	sub r0, r8, #0xe
	add r1, r7, #0xe
	bl sub_20C398C
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C3184: .word 0x0214588C
	arm_func_end sub_20C30AC

	arm_func_start sub_20C3188
sub_20C3188: // 0x020C3188
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r3, _020C32F8 // =0x7F000001
	mov r6, r1
	cmp r6, r3
	mov r7, r0
	mov r4, r2
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr r0, _020C32FC // =0x0214587C
	ldr r0, [r0]
	cmp r6, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r6
	bl sub_20C3B34
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r6
	bl sub_20C3AB0
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	mov r0, r0, lsl #0x10
	ldr r1, _020C3300 // =0x021458F0
	mov r5, r0, lsr #0x10
	mov r2, #0
_020C3214:
	ldr r0, [r1]
	cmp r6, r0
	bne _020C3254
	mov r0, #0xc
	mul r4, r2, r0
	ldr r0, _020C3300 // =0x021458F0
	ldr r3, _020C3304 // =0x021458FA
	add r1, r0, r4
	mov r0, r7
	add r1, r1, #4
	mov r2, #6
	strh r5, [r3, r4]
	bl MI_CpuCopy8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020C3254:
	add r2, r2, #1
	cmp r2, #8
	add r1, r1, #0xc
	blo _020C3214
	cmp r4, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov ip, #0
	ldr r4, _020C3300 // =0x021458F0
	mov r0, ip
	mov r3, ip
_020C3284:
	ldr r1, [r4]
	cmp r1, #0
	moveq r0, r3
	beq _020C32C0
	ldrh r1, [r4, #0xa]
	add r4, r4, #0xc
	sub r1, r5, r1
	mov r1, r1, lsl #0x10
	mov r2, r1, asr #0x10
	cmp r2, ip
	movgt r0, r3
	add r3, r3, #1
	movgt ip, r1, lsr #0x10
	cmp r3, #8
	blo _020C3284
_020C32C0:
	mov r1, #0xc
	mul r4, r0, r1
	ldr r3, _020C3300 // =0x021458F0
	mov r0, r7
	add r1, r3, r4
	add r1, r1, #4
	mov r2, #6
	str r6, [r3, r4]
	bl MI_CpuCopy8
	ldr r0, _020C3304 // =0x021458FA
	strh r5, [r0, r4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020C32F8: .word 0x7F000001
_020C32FC: .word 0x0214587C
_020C3300: .word 0x021458F0
_020C3304: .word 0x021458FA
	arm_func_end sub_20C3188

	arm_func_start sub_20C3308
sub_20C3308: // 0x020C3308
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, #0
	ldr r4, _020C3390 // =0x0214587C
	mov r6, r8
	mov r5, #0x64
_020C3324:
	mov r0, r9
	bl sub_20C3394
	mov r7, r6
_020C3330:
	ldr r0, [r4]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	mov r0, r5
	bl OS_Sleep
	mov r0, r9
	bl sub_20C3494
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxne lr
	add r7, r7, #1
	cmp r7, #0x14
	blo _020C3330
	add r8, r8, #1
	cmp r8, #8
	blo _020C3324
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020C3390: .word 0x0214587C
	arm_func_end sub_20C3308

	arm_func_start sub_20C3394
sub_20C3394: // 0x020C3394
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x30
	mov r4, r0
	add r0, sp, #0
	mov r1, #0
	mov r2, #0x2a
	bl MI_CpuFill8
	add r0, sp, #0
	mov r1, #0xff
	mov r2, #6
	bl MI_CpuFill8
	ldr r0, _020C3484 // =0x0214588C
	add r1, sp, #6
	mov r2, #6
	bl MI_CpuCopy8
	mov r0, #1
	ldr r1, _020C3488 // =0x00000608
	strb r0, [sp, #0xf]
	strh r1, [sp, #0xc]
	strb r0, [sp, #0x15]
	mov r0, #8
	ldr r1, _020C348C // =0x00000406
	strb r0, [sp, #0x10]
	strh r1, [sp, #0x12]
	ldr r0, _020C3484 // =0x0214588C
	add r1, sp, #0x16
	mov r2, #6
	bl MI_CpuCopy8
	ldr r0, _020C3490 // =0x0214587C
	mov r1, r4, lsr #0x10
	ldr r3, [r0]
	mov r0, r1, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r4, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r3, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	mov r0, r3, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r4, asr #8
	orr r0, r0, r4, lsl #8
	strh r0, [sp, #0x1c]
	mov r0, r3, asr #8
	orr r0, r0, r3, lsl #8
	strh r0, [sp, #0x1e]
	mov r0, r2, asr #8
	orr r0, r0, r2, lsl #8
	strh r0, [sp, #0x26]
	mov r0, r1, asr #8
	orr r0, r0, r1, lsl #8
	mov r2, #0
	strh r0, [sp, #0x28]
	add r0, sp, #0
	mov r1, #0x2a
	mov r3, r2
	bl sub_20C398C
	add sp, sp, #0x30
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C3484: .word 0x0214588C
_020C3488: .word 0x00000608
_020C348C: .word 0x00000406
_020C3490: .word 0x0214587C
	arm_func_end sub_20C3394

	arm_func_start sub_20C3494
sub_20C3494: // 0x020C3494
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	bl OS_DisableInterrupts
	ldr r1, _020C3560 // =0x7F000001
	mov r4, r0
	cmp r7, r1
	mov r5, #0
	beq _020C34C8
	ldr r0, _020C3564 // =0x0214587C
	ldr r0, [r0]
	cmp r7, r0
	bne _020C34D0
_020C34C8:
	ldr r5, _020C3568 // =0x0214588C
	b _020C3548
_020C34D0:
	mov r0, r7
	bl sub_20C3AC4
	cmp r0, #0
	bne _020C34F0
	mov r0, r7
	bl sub_20C3AB0
	cmp r0, #0
	beq _020C34F8
_020C34F0:
	ldr r5, _020C356C // =0x0211F1C0
	b _020C3548
_020C34F8:
	ldr r1, _020C3570 // =0x021458F0
	mov r6, r5
_020C3500:
	ldr r0, [r1]
	cmp r7, r0
	bne _020C3538
	bl OS_GetTick
	mov r2, #0xc
	mul r3, r6, r2
	ldr r2, _020C3570 // =0x021458F0
	mov r5, r0, lsr #0x10
	add r0, r2, r3
	ldr r2, _020C3574 // =0x021458FA
	orr r5, r5, r1, lsl #16
	strh r5, [r2, r3]
	add r5, r0, #4
	b _020C3548
_020C3538:
	add r6, r6, #1
	cmp r6, #8
	add r1, r1, #0xc
	blo _020C3500
_020C3548:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020C3560: .word 0x7F000001
_020C3564: .word 0x0214587C
_020C3568: .word 0x0214588C
_020C356C: .word 0x0211F1C0
_020C3570: .word 0x021458F0
_020C3574: .word 0x021458FA
	arm_func_end sub_20C3494

	arm_func_start sub_20C3578
sub_20C3578: // 0x020C3578
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	ldr r2, _020C35CC // =0x0214585C
	ldr r1, _020C35D0 // =0x02145884
	ldr lr, [r2]
	ldr ip, [r1]
	ldr r3, [r2]
	ldr r1, _020C35D4 // =0x02145888
	ldrh r3, [ip, r3]
	add r3, lr, r3
	str r3, [r2]
	ldr r3, [r2]
	ldr r1, [r1]
	cmp r3, r1
	movhs r1, #0
	strhs r1, [r2]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C35CC: .word 0x0214585C
_020C35D0: .word 0x02145884
_020C35D4: .word 0x02145888
	arm_func_end sub_20C3578

	arm_func_start sub_20C35D8
sub_20C35D8: // 0x020C35D8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r6, r0
	bl OS_DisableInterrupts
	ldr r10, _020C36A0 // =0x0214585C
	ldr r9, _020C36A4 // =0x2145854
	ldr r2, [r10]
	ldr r1, [r9]
	mov r5, r0
	cmp r2, r1
	bne _020C3630
	ldr r8, _020C36A8 // =OSi_ThreadInfo
	ldr r7, _020C36AC // =0x02145880
	mov r4, #0
_020C360C:
	ldr r1, [r8, #4]
	mov r0, r4
	str r1, [r7]
	bl OS_SleepThread
	str r4, [r7]
	ldr r1, [r10]
	ldr r0, [r9]
	cmp r1, r0
	beq _020C360C
_020C3630:
	mov r0, r5
	bl OS_RestoreInterrupts
	ldr r0, _020C36B0 // =0x02145884
	ldr r5, [r0]
	ldr r0, _020C36A0 // =0x0214585C
	ldr r1, _020C36B4 // =0x02145888
	mov r3, #0
_020C364C:
	ldr r4, [r1]
	ldr r2, [r0]
	sub r2, r4, r2
	cmp r2, #2
	strlo r3, [r0]
	ldr r2, [r0]
	ldrh r2, [r5, r2]
	cmp r2, #0
	streq r3, [r0]
	cmp r2, #0
	beq _020C364C
	sub r0, r2, #2
	ldr r1, _020C36B0 // =0x02145884
	str r0, [r6]
	ldr r0, _020C36A0 // =0x0214585C
	ldr r1, [r1]
	ldr r0, [r0]
	add r0, r1, r0
	add r0, r0, #2
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020C36A0: .word 0x0214585C
_020C36A4: .word 0x2145854
_020C36A8: .word OSi_ThreadInfo
_020C36AC: .word 0x02145880
_020C36B0: .word 0x02145884
_020C36B4: .word 0x02145888
	arm_func_end sub_20C35D8

	arm_func_start sub_20C36B8
sub_20C36B8: // 0x020C36B8
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov ip, #0
	str ip, [sp]
	str ip, [sp, #4]
	bl sub_20C371C
	ldr r0, _020C3718 // =0x02145880
	ldr r1, [r0]
	cmp r1, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {lr}
	bxeq lr
	ldr r0, [r0]
	bl OS_IsThreadTerminated
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {lr}
	bxne lr
	ldr r0, _020C3718 // =0x02145880
	ldr r0, [r0]
	bl OS_WakeupThreadDirect
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C3718: .word 0x02145880
	arm_func_end sub_20C36B8

	arm_func_start sub_20C371C
sub_20C371C: // 0x020C371C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r4, _020C3974 // =0x02145884
	mov r7, r0
	ldr r0, [r4]
	mov r6, r2
	mov r5, r3
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r2, _020C3978 // =0x02145888
	ldr r2, [r2]
	cmp r2, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	ldr r2, [sp, #0x1c]
	add r2, r5, r2
	cmp r2, #8
	ldmloia sp!, {r4, r5, r6, r7, r8, lr}
	bxlo lr
	ldr r3, _020C397C // =0x000005E4
	cmp r2, r3
	ldmhiia sp!, {r4, r5, r6, r7, r8, lr}
	bxhi lr
	ldr r3, _020C3980 // =0x0211F1D4
	ldrb r8, [r6]
	ldrb r4, [r3]
	cmp r8, r4
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	ldrb r8, [r6, #1]
	ldrb r4, [r3, #1]
	cmp r8, r4
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	ldrb r4, [r6, #2]
	ldrb r3, [r3, #2]
	cmp r4, r3
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	ldrb r3, [r6, #6]
	cmp r3, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	ldrb r3, [r6, #7]
	cmp r3, #0
	beq _020C37E0
	cmp r3, #6
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
_020C37E0:
	ldr r4, _020C3984 // =0x2145854
	add r2, r2, #9
	bic r2, r2, #1
	ldr lr, [r4]
	mov r3, r2, lsl #0x10
	ldr ip, _020C3988 // =0x0214585C
	ldr r8, [r4]
	ldr r4, [ip]
	mov r2, r3, lsr #0x10
	cmp r8, r4
	add r4, lr, r3, lsr #16
	bhs _020C3820
	ldr r3, [ip]
	cmp r3, r4
	ldmlsia sp!, {r4, r5, r6, r7, r8, lr}
	bxls lr
_020C3820:
	ldr r3, _020C3978 // =0x02145888
	ldr r8, [r3]
	cmp r4, r8
	bne _020C384C
	ldr r3, _020C3988 // =0x0214585C
	mov r4, #0
	ldr r3, [r3]
	cmp r3, #0
	bne _020C3870
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020C384C:
	ldr r3, [r3]
	cmp r4, r3
	bls _020C3870
	ldr r3, _020C3988 // =0x0214585C
	mov r4, r2
	ldr r3, [r3]
	cmp r3, r2
	ldmlsia sp!, {r4, r5, r6, r7, r8, lr}
	bxls lr
_020C3870:
	ldr ip, _020C3984 // =0x2145854
	ldr r3, _020C3978 // =0x02145888
	ldr lr, [ip]
	ldr r8, [r3]
	add lr, lr, r2
	cmp lr, r8
	bls _020C38B4
	ldr r8, [r3]
	ldr r3, [ip]
	sub r3, r8, r3
	cmp r3, #2
	ldrhs r3, [ip]
	movhs r8, #0
	strhsh r8, [r0, r3]
	ldr r0, _020C3984 // =0x2145854
	mov r3, #0
	str r3, [r0]
_020C38B4:
	ldr ip, _020C3974 // =0x02145884
	ldr r3, _020C3984 // =0x2145854
	ldr r8, [ip]
	ldr lr, [r3]
	mov r0, r1
	strh r2, [r8, lr]
	ldr ip, [ip]
	ldr r1, [r3]
	mov r2, #6
	add r1, ip, r1
	add r1, r1, #2
	bl MI_CpuCopy8
	ldr r1, _020C3974 // =0x02145884
	ldr r0, _020C3984 // =0x2145854
	ldr r2, [r1]
	ldr r1, [r0]
	mov r0, r7
	add r1, r2, r1
	add r1, r1, #8
	mov r2, #6
	bl MI_CpuCopy8
	ldr r1, _020C3974 // =0x02145884
	ldr r0, _020C3984 // =0x2145854
	ldr r2, [r1]
	ldr r1, [r0]
	add r0, r6, #6
	add r1, r2, r1
	add r1, r1, #0xe
	sub r2, r5, #6
	bl MI_CpuCopy8
	ldr r0, [sp, #0x18]
	cmp r0, #0
	beq _020C3964
	ldr r2, [sp, #0x1c]
	cmp r2, #0
	beq _020C3964
	ldr r3, _020C3974 // =0x02145884
	ldr r1, _020C3984 // =0x2145854
	ldr r3, [r3]
	ldr r1, [r1]
	add r1, r3, r1
	add r1, r1, #8
	add r1, r1, r5
	bl MI_CpuCopy8
_020C3964:
	ldr r0, _020C3984 // =0x2145854
	str r4, [r0]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C3974: .word 0x02145884
_020C3978: .word 0x02145888
_020C397C: .word 0x000005E4
_020C3980: .word 0x0211F1D4
_020C3984: .word 0x2145854
_020C3988: .word 0x0214585C
	arm_func_end sub_20C371C

	arm_func_start sub_20C398C
sub_20C398C: // 0x020C398C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	add r1, r6, r5
	mov r4, r3
	cmp r1, r2
	beq _020C39B4
	mov r0, r2
	mov r2, r4
	bl MI_CpuCopy8
_020C39B4:
	ldr r0, _020C39F4 // =0x0211F1D4
	add r1, r6, #6
	mov r2, #6
	bl MI_CpuCopy8
	add r2, r5, r4
	mov r0, r6
	add r1, r6, #6
	sub r2, r2, #6
	bl sub_20CC6A0
	cmp r0, #0
	movlt r1, #1
	ldr r0, _020C39F8 // =0x02145820
	movge r1, #0
	strb r1, [r0]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C39F4: .word 0x0211F1D4
_020C39F8: .word 0x02145820
	arm_func_end sub_20C398C

	arm_func_start sub_20C39FC
sub_20C39FC: // 0x020C39FC
	mov ip, #0
_020C3A00:
	ldrh r3, [r0], #2
	ldrh r2, [r1], #2
	cmp r3, r2
	movne r0, #1
	bxne lr
	add ip, ip, #1
	cmp ip, #3
	blt _020C3A00
	mov r0, #0
	bx lr
	arm_func_end sub_20C39FC

	arm_func_start sub_20C3A28
sub_20C3A28: // 0x020C3A28
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _020C3AA8 // =0x0214587C
	mov r5, #1
	ldr r1, [r1]
	mov r6, r0
	mov r4, r5
	mov r2, r5
	mov r0, r5
	cmp r1, #0
	beq _020C3A58
	cmp r6, r1
	movne r0, #0
_020C3A58:
	cmp r0, #0
	bne _020C3A6C
	ldr r0, _020C3AAC // =0x7F000001
	cmp r6, r0
	movne r2, #0
_020C3A6C:
	cmp r2, #0
	bne _020C3A84
	mov r0, r6
	bl sub_20C3AC4
	cmp r0, #0
	moveq r4, #0
_020C3A84:
	cmp r4, #0
	bne _020C3A9C
	mov r0, r6
	bl sub_20C3AB0
	cmp r0, #0
	moveq r5, #0
_020C3A9C:
	mov r0, r5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C3AA8: .word 0x0214587C
_020C3AAC: .word 0x7F000001
	arm_func_end sub_20C3A28

	arm_func_start sub_20C3AB0
sub_20C3AB0: // 0x020C3AB0
	and r0, r0, #0xf0000000
	cmp r0, #0xe0000000
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end sub_20C3AB0

	arm_func_start sub_20C3AC4
sub_20C3AC4: // 0x020C3AC4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, #0
	bl sub_20C3B34
	cmp r0, #0
	beq _020C3AF8
	ldr r0, _020C3B08 // =0x02145848
	ldr r0, [r0]
	mvn r1, r0
	and r0, r1, r5
	cmp r1, r0
	moveq r4, #1
_020C3AF8:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C3B08: .word 0x02145848
	arm_func_end sub_20C3AC4

	arm_func_start sub_20C3B0C
sub_20C3B0C: // 0x020C3B0C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20C3B34
	cmp r0, #0
	ldreq r0, _020C3B30 // =0x02145858
	ldreq r4, [r0]
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C3B30: .word 0x02145858
	arm_func_end sub_20C3B0C

	arm_func_start sub_20C3B34
sub_20C3B34: // 0x020C3B34
	mvn r1, #0
	cmp r0, r1
	mov ip, #1
	beq _020C3B70
	ldr r1, _020C3B78 // =0x7F000001
	cmp r0, r1
	beq _020C3B70
	ldr r2, _020C3B7C // =0x02145848
	ldr r1, _020C3B80 // =0x0214587C
	ldr r3, [r2]
	ldr r1, [r1]
	and r2, r0, r3
	and r0, r1, r3
	cmp r2, r0
	movne ip, #0
_020C3B70:
	mov r0, ip
	bx lr
	.align 2, 0
_020C3B78: .word 0x7F000001
_020C3B7C: .word 0x02145848
_020C3B80: .word 0x0214587C
	arm_func_end sub_20C3B34

	arm_func_start sub_20C3B84
sub_20C3B84: // 0x020C3B84
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r2
	mov r2, r3
	mov r5, r1
	bl sub_20C3C24
	mov r2, r0
	add r0, r4, #0xc
	mov r1, #8
	bl sub_20C3C24
	add r1, r0, r5
	ands r0, r1, #0x10000
	ldrne r0, _020C3BDC // =0x0000FFFF
	addne r1, r1, #1
	andne r1, r1, r0
	ldr r0, _020C3BDC // =0x0000FFFF
	cmp r1, r0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C3BDC: .word 0x0000FFFF
	arm_func_end sub_20C3B84

	arm_func_start sub_20C3BE0
sub_20C3BE0: // 0x020C3BE0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #0
	bl sub_20C3C24
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl sub_20C3C08
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C3BE0

	arm_func_start sub_20C3C08
sub_20C3C08: // 0x020C3C08
	ldr r1, _020C3C20 // =0x0000FFFF
	eor r0, r0, r1
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	moveq r0, r1
	bx lr
	.align 2, 0
_020C3C20: .word 0x0000FFFF
	arm_func_end sub_20C3C08

	arm_func_start sub_20C3C24
sub_20C3C24: // 0x020C3C24
	ands r3, r0, #1
	beq _020C3C5C
	cmp r1, #1
	bls _020C3CB0
_020C3C34:
	ldrb ip, [r0]
	ldrb r3, [r0, #1]
	sub r1, r1, #2
	cmp r1, #1
	orr r3, r3, ip, lsl #8
	mov r3, r3, lsl #0x10
	add r2, r2, r3, lsr #16
	add r0, r0, #2
	bhi _020C3C34
	b _020C3CB0
_020C3C5C:
	mov r2, r2, lsl #0x10
	mov r3, r2, lsr #0x10
	mov r2, r3, asr #8
	orr r2, r2, r3, lsl #8
	mov r2, r2, lsl #0x10
	cmp r1, #1
	mov r2, r2, lsr #0x10
	bls _020C3C94
_020C3C7C:
	ldrh r3, [r0]
	sub r1, r1, #2
	cmp r1, #1
	add r2, r2, r3
	add r0, r0, #2
	bhi _020C3C7C
_020C3C94:
	ldr r3, _020C3CD8 // =0x00FF00FF
	ldr ip, _020C3CDC // =0xFF00FF00
	and r3, r3, r2, lsr #8
	and r2, ip, r2, lsl #8
	orr r3, r3, r2
	mov r2, r3, lsr #0x10
	orr r2, r2, r3, lsl #16
_020C3CB0:
	cmp r1, #0
	ldrneb r0, [r0]
	addne r2, r2, r0, lsl #8
	ldr r0, _020C3CE0 // =0x0000FFFF
	and r0, r2, r0
	add r0, r0, r2, lsr #16
	add r0, r0, r0, lsr #16
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_020C3CD8: .word 0x00FF00FF
_020C3CDC: .word 0xFF00FF00
_020C3CE0: .word 0x0000FFFF
	arm_func_end sub_20C3C24

	arm_func_start sub_20C3CE4
sub_20C3CE4: // 0x020C3CE4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, _020C3D14 // =_0211F1BC
	ldr r0, _020C3D18 // =0x02145AD8
	mov r1, r4
	str r4, [r2]
	bl OS_SetThreadPriority
	ldr r0, _020C3D1C // =0x02145A18
	mov r1, r4
	bl OS_SetThreadPriority
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C3D14: .word _0211F1BC
_020C3D18: .word 0x02145AD8
_020C3D1C: .word 0x02145A18
	arm_func_end sub_20C3CE4

	arm_func_start sub_20C3D20
sub_20C3D20: // 0x020C3D20
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20C3D90
	ldr r0, _020C3D6C // =0x02145A18
	bl OS_JoinThread
	ldr r0, _020C3D70 // =0x02145AD8
	bl OS_DestroyThread
	ldr r1, _020C3D74 // =0x02145880
	mov r0, #0
	str r0, [r1]
	bl sub_20C40F4
	ldr r1, _020C3D78 // =0x02145884
	mov r2, #0
	ldr r0, _020C3D7C // =0x02145888
	str r2, [r1]
	str r2, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C3D6C: .word 0x02145A18
_020C3D70: .word 0x02145AD8
_020C3D74: .word 0x02145880
_020C3D78: .word 0x02145884
_020C3D7C: .word 0x02145888
	arm_func_end sub_20C3D20

	arm_func_start sub_20C3D80
sub_20C3D80: // 0x020C3D80
	ldr r1, _020C3D8C // =0x02145868
	str r0, [r1]
	bx lr
	.align 2, 0
_020C3D8C: .word 0x02145868
	arm_func_end sub_20C3D80

	arm_func_start sub_20C3D90
sub_20C3D90: // 0x020C3D90
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	mov r5, r0
	ldr r0, _020C3DE8 // =0x02145A18
	bl OS_IsThreadTerminated
	movs r4, r0
	bne _020C3DD0
	ldr r1, _020C3DEC // =0x02145870
	ldr r0, [r1]
	cmp r0, #0
	bne _020C3DD0
	ldr r0, _020C3DE8 // =0x02145A18
	mov r2, #1
	str r2, [r1]
	bl OS_WakeupThreadDirect
_020C3DD0:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C3DE8: .word 0x02145A18
_020C3DEC: .word 0x02145870
	arm_func_end sub_20C3D90

	arm_func_start sub_20C3DF0
sub_20C3DF0: // 0x020C3DF0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, _020C4030 // =_version_UBIQUITOUS_CPS
	bl OSi_ReferSymbol
	ldr ip, [r4, #0x14]
	ldr r6, [r4, #0x18]
	mov r1, #0
	cmp r6, r1
	cmpeq ip, r1
	beq _020C3E48
	ldr r0, _020C4034 // =0x0214589C
	ldr r5, _020C4038 // =0x6C078965
	ldr r3, _020C403C // =0x5D588B65
	ldr r2, _020C4040 // =0x00269EC3
	str ip, [r0]
	str r6, [r0, #4]
	str r5, [r0, #8]
	str r3, [r0, #0xc]
	str r2, [r0, #0x10]
	str r1, [r0, #0x14]
	b _020C3E78
_020C3E48:
	bl OS_GetTick
	ldr r2, _020C4034 // =0x0214589C
	ldr ip, _020C4038 // =0x6C078965
	ldr r6, _020C403C // =0x5D588B65
	ldr r5, _020C4040 // =0x00269EC3
	mov r3, #0
	str r0, [r2]
	str r1, [r2, #4]
	str ip, [r2, #8]
	str r6, [r2, #0xc]
	str r5, [r2, #0x10]
	str r3, [r2, #0x14]
_020C3E78:
	ldr r2, [r4, #4]
	cmp r2, #0
	beq _020C3EA8
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _020C3EA8
	ldr r1, _020C4044 // =0x02145840
	ldr r0, _020C4048 // =0x0214586C
	str r2, [r1]
	ldr r1, [r4, #8]
	str r1, [r0]
	b _020C3EBC
_020C3EA8:
	ldr r2, _020C404C // =sub_20C40B4
	ldr r1, _020C4044 // =0x02145840
	ldr r0, _020C4048 // =0x0214586C
	str r2, [r1]
	str r2, [r0]
_020C3EBC:
	ldr r1, [r4]
	ldr r0, _020C4050 // =0x0214583C
	ldr ip, _020C4034 // =0x0214589C
	str r1, [r0]
	ldr r1, [r4, #0x24]
	ldr r3, [ip, #8]
	cmp r1, #0
	ldrne r0, _020C4054 // =0x02145828
	strneh r1, [r0]
	ldreq r1, _020C4058 // =0x000005B4
	ldreq r0, _020C4054 // =0x02145828
	streqh r1, [r0]
	ldr r2, [r4, #0x28]
	ldr r1, _020C405C // =0x02145860
	ldr r0, _020C4060 // =0x02145850
	str r2, [r1]
	ldr r1, [r4, #0x2c]
	ldr r2, [ip]
	str r1, [r0]
	ldr r1, [r4, #0xc]
	umull lr, r5, r3, r2
	cmp r1, #0
	ldrne r0, _020C4064 // =0x02145844
	strne r1, [r0]
	ldreq r1, _020C404C // =sub_20C40B4
	ldreq r0, _020C4064 // =0x02145844
	streq r1, [r0]
	ldr r1, [r4, #0x10]
	cmp r1, #0
	ldrne r0, _020C4068 // =0x02145874
	strne r1, [r0]
	ldreq r1, _020C406C // =sub_20C40AC
	ldreq r0, _020C4068 // =0x02145874
	streq r1, [r0]
	ldr r1, [ip, #4]
	ldr r0, _020C4070 // =0x00000F88
	mla r5, r3, r1, r5
	ldr r1, [ip, #0xc]
	ldr r3, [ip, #0x10]
	mla r5, r1, r2, r5
	adds r2, r3, lr
	ldr r1, [ip, #0x14]
	mov r3, #0
	adc r1, r1, r5
	umull lr, r5, r1, r0
	mla r5, r1, r3, r5
	mla r5, r3, r0, r5
	ldr r6, [r4, #0x1c]
	ldr r0, _020C4074 // =0x02145884
	ldr lr, _020C4078 // =0x02145888
	str r6, [r0]
	ldr r4, [r4, #0x20]
	ldr r0, _020C407C // =0x0214585C
	str r4, [lr]
	str r3, [r0]
	ldr lr, _020C4080 // =0x2145854
	ldr r4, _020C4084 // =0x02145834
	add r5, r5, #0x400
	ldr r0, _020C4088 // =0x0214588C
	str r3, [lr]
	str r2, [ip]
	str r1, [ip, #4]
	strh r5, [r4]
	bl OS_GetMacAddress
	ldr r0, _020C408C // =0x02145824
	mov r2, #0
	strb r2, [r0]
	mov r1, #0x800
	str r1, [sp]
	ldr r0, _020C4090 // =_0211F1BC
	ldr r1, _020C4094 // =sub_20C0D98
	ldr r4, [r0]
	ldr r0, _020C4098 // =0x02145AD8
	ldr r3, _020C409C // =0x02147060
	str r4, [sp, #4]
	bl OS_CreateThread
	mov r1, #0x800
	ldr r0, _020C4090 // =_0211F1BC
	str r1, [sp]
	ldr r1, [r0]
	ldr r0, _020C40A0 // =0x02145A18
	str r1, [sp, #4]
	ldr r1, _020C40A4 // =sub_20BFA68
	ldr r3, _020C40A8 // =0x02146860
	mov r2, #0
	bl OS_CreateThread
	ldr r0, _020C4098 // =0x02145AD8
	bl OS_WakeupThreadDirect
	ldr r0, _020C40A0 // =0x02145A18
	bl OS_WakeupThreadDirect
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C4030: .word _version_UBIQUITOUS_CPS
_020C4034: .word 0x0214589C
_020C4038: .word 0x6C078965
_020C403C: .word 0x5D588B65
_020C4040: .word 0x00269EC3
_020C4044: .word 0x02145840
_020C4048: .word 0x0214586C
_020C404C: .word sub_20C40B4
_020C4050: .word 0x0214583C
_020C4054: .word 0x02145828
_020C4058: .word 0x000005B4
_020C405C: .word 0x02145860
_020C4060: .word 0x02145850
_020C4064: .word 0x02145844
_020C4068: .word 0x02145874
_020C406C: .word sub_20C40AC
_020C4070: .word 0x00000F88
_020C4074: .word 0x02145884
_020C4078: .word 0x02145888
_020C407C: .word 0x0214585C
_020C4080: .word 0x2145854
_020C4084: .word 0x02145834
_020C4088: .word 0x0214588C
_020C408C: .word 0x02145824
_020C4090: .word _0211F1BC
_020C4094: .word sub_20C0D98
_020C4098: .word 0x02145AD8
_020C409C: .word 0x02147060
_020C40A0: .word 0x02145A18
_020C40A4: .word sub_20BFA68
_020C40A8: .word 0x02146860
	arm_func_end sub_20C3DF0

	arm_func_start sub_20C40AC
sub_20C40AC: // 0x020C40AC
	mov r0, #1
	bx lr
	arm_func_end sub_20C40AC

	arm_func_start sub_20C40B4
sub_20C40B4: // 0x020C40B4
	bx lr
	arm_func_end sub_20C40B4

	arm_func_start sub_20C40B8
sub_20C40B8: // 0x020C40B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020C40F0 // =0x02145850
	ldr r0, [r0]
	cmp r0, #0
	bne _020C40E0
	bl OS_YieldThread
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C40E0:
	bl OS_Sleep
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C40F0: .word 0x02145850
	arm_func_end sub_20C40B8

	arm_func_start sub_20C40F4
sub_20C40F4: // 0x020C40F4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r1, _020C4214 // =0x0214587C
	ldr r5, _020C4218 // =0x02145838
	ldr r1, [r1]
	ldr r3, _020C421C // =0x02145894
	cmp r1, #0
	mov r1, #0
	movne r6, #1
	ldr ip, _020C4220 // =0x02145848
	ldr r2, _020C4224 // =0x0214584C
	moveq r6, #0
	ldr lr, _020C4214 // =0x0214587C
	ldr r4, _020C4228 // =0x02145858
	cmp r6, #0
	str r1, [ip]
	str r1, [r3]
	str r1, [r3, #4]
	str r1, [r2]
	addeq sp, sp, #4
	str r0, [r5]
	str r1, [lr]
	str r1, [r4]
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	ldr r0, _020C422C // =0x021458F0
	mov r2, #0x60
	bl MI_CpuFill8
	ldr r0, _020C4230 // =OSi_ThreadInfo
	ldr r5, [r0, #8]
	cmp r5, #0
	beq _020C41C8
	mov r4, #0
_020C4178:
	ldr r1, [r5, #0xa4]
	cmp r1, #0
	beq _020C41BC
	ldr r0, [r1]
	cmp r0, #0
	beq _020C41BC
	ldrb r0, [r1, #8]
	cmp r0, #0xa
	beq _020C41A4
	cmp r0, #0xb
	strneb r4, [r1, #8]
_020C41A4:
	ldr r0, [r1, #4]
	cmp r0, #0
	beq _020C41BC
	str r4, [r1, #4]
	ldr r0, [r1]
	bl OS_WakeupThreadDirect
_020C41BC:
	ldr r5, [r5, #0x68]
	cmp r5, #0
	bne _020C4178
_020C41C8:
	ldr r6, _020C4234 // =0x02145E98
	mov r7, #0
	ldr r4, _020C4238 // =0x0214586C
	mov r5, r7
_020C41D8:
	ldrh r0, [r6, #4]
	cmp r0, #0
	beq _020C41F4
	ldr r0, [r6, #0x34]
	ldr r1, [r4]
	blx r1
	strh r5, [r6, #4]
_020C41F4:
	add r7, r7, #1
	cmp r7, #8
	add r6, r6, #0x38
	blt _020C41D8
	bl sub_20C423C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020C4214: .word 0x0214587C
_020C4218: .word 0x02145838
_020C421C: .word 0x02145894
_020C4220: .word 0x02145848
_020C4224: .word 0x0214584C
_020C4228: .word 0x02145858
_020C422C: .word 0x021458F0
_020C4230: .word OSi_ThreadInfo
_020C4234: .word 0x02145E98
_020C4238: .word 0x0214586C
	arm_func_end sub_20C40F4

	arm_func_start sub_20C423C
sub_20C423C: // 0x020C423C
	ldr ip, _020C4250 // =MI_CpuFill8
	ldr r0, _020C4254 // =0x0214707C
	mov r1, #0
	mov r2, #0x170
	bx ip
	.align 2, 0
_020C4250: .word MI_CpuFill8
_020C4254: .word 0x0214707C
	arm_func_end sub_20C423C

	arm_func_start sub_20C4258
sub_20C4258: // 0x020C4258
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r4, _020C433C // =0x0214707C
	mov r6, #0
	mov r2, r6
	ldr r1, _020C4340 // =0x000003BD
_020C4274:
	ldrb r3, [r4, #0x5a]
	cmp r3, #0
	beq _020C4290
	ldr r3, [r4, #0x50]
	sub r3, r5, r3
	cmp r3, r1
	strgtb r2, [r4, #0x5a]
_020C4290:
	add r6, r6, #1
	cmp r6, #4
	add r4, r4, #0x5c
	blt _020C4274
	bl OS_RestoreInterrupts
	ldr r0, _020C4344 // =OSi_ThreadInfo
	ldr r4, [r0, #8]
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r6, #0
_020C42BC:
	ldr r1, [r4, #0xa4]
	cmp r1, #0
	beq _020C4328
	ldr r0, [r1]
	cmp r0, #0
	beq _020C4328
	ldrb r0, [r1, #9]
	cmp r0, #0
	beq _020C4328
	ldrb r0, [r1, #8]
	cmp r0, #4
	bne _020C4328
	ldr r0, [r1, #0xc]
	ldrb r0, [r0, #0x455]
	cmp r0, #8
	bhs _020C4328
	ldr r0, [r1, #0x10]
	sub r0, r5, r0
	cmp r0, #0xef
	ble _020C4328
	ldr r0, [r1, #4]
	cmp r0, #2
	bne _020C4328
	strb r6, [r1, #8]
	str r6, [r1, #4]
	ldr r0, [r1]
	bl OS_WakeupThreadDirect
_020C4328:
	ldr r4, [r4, #0x68]
	cmp r4, #0
	bne _020C42BC
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C433C: .word 0x0214707C
_020C4340: .word 0x000003BD
_020C4344: .word OSi_ThreadInfo
	arm_func_end sub_20C4258

	arm_func_start sub_20C4348
sub_20C4348: // 0x020C4348
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _020C4374 // =_version_UBIQUITOUS_SSL
	bl OSi_ReferSymbol
	ldr r0, _020C4378 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	ldr r0, [r0, #0xa4]
	cmp r0, #0
	strneb r4, [r0, #9]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C4374: .word _version_UBIQUITOUS_SSL
_020C4378: .word OSi_ThreadInfo
	arm_func_end sub_20C4348

	arm_func_start sub_20C437C
sub_20C437C: // 0x020C437C
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #0xc]
	mov r0, #0
	strb r0, [r4, #0x455]
	ldr r0, [r4, #0x824]
	cmp r0, #0
	beq _020C43A4
	ldr r1, _020C43B4 // =0x0214586C
	ldr r1, [r1]
	blx r1
_020C43A4:
	mov r0, #0
	str r0, [r4, #0x824]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C43B4: .word 0x0214586C
	arm_func_end sub_20C437C

	arm_func_start sub_20C43B8
sub_20C43B8: // 0x020C43B8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r5, r0
	ldr r4, [r5, #0xc]
	ldrb r0, [r4, #0x455]
	cmp r0, #8
	bne _020C4428
	mov ip, #0
	mov r6, #0x15
	mov lr, #3
	mov r3, #2
	mov r2, #1
	add r1, sp, #4
	mov r0, r4
	strb r6, [sp, #4]
	strb lr, [sp, #5]
	strb ip, [sp, #6]
	strb ip, [sp, #7]
	strb r3, [sp, #8]
	strb r2, [sp, #9]
	strb ip, [sp, #0xa]
	bl sub_20C5A50
	mov r2, #0
	mov r1, r0
	add r0, sp, #4
	mov r3, r2
	str r5, [sp]
	bl sub_20C0230
_020C4428:
	mov r0, #0
	strb r0, [r4, #0x455]
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C43B8

	arm_func_start sub_20C443C
sub_20C443C: // 0x020C443C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r4, [sp, #0x48]
	mov r9, r1
	mov r1, r4
	mov r10, r0
	mov r0, #0
	ldr r1, [r1, #0xc]
	str r0, [sp, #8]
	str r0, [sp, #0x1c]
	str r0, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, #0x17
	str r0, [sp, #0xc]
	mov r0, #3
	str r4, [sp, #0x48]
	str r1, [sp, #4]
	mov r8, r2
	add r6, r9, r3
	str r0, [sp, #0x10]
_020C448C:
	ldr r0, _020C4588 // =0x00000B4F
	ldr r1, _020C458C // =0x02145840
	cmp r6, r0
	movgt r5, r0
	movle r5, r6
	ldr r1, [r1]
	add r0, r5, #0x19
	blx r1
	movs r7, r0
	beq _020C4578
	cmp r9, r5
	movhs r4, r5
	movlo r4, r9
	mov r0, r10
	add r1, r7, #5
	mov r2, r4
	sub r11, r5, r4
	bl MI_CpuCopy8
	add r1, r7, #5
	mov r0, r8
	add r1, r1, r4
	mov r2, r11
	add r10, r10, r4
	sub r9, r9, r4
	bl MI_CpuCopy8
	ldr r0, [sp, #0xc]
	mov r1, r7
	strb r0, [r7]
	ldr r0, [sp, #0x10]
	add r8, r8, r11
	strb r0, [r7, #1]
	ldr r0, [sp, #0x14]
	strb r0, [r7, #2]
	mov r0, r5, asr #8
	strb r0, [r7, #3]
	ldr r0, [sp, #4]
	strb r5, [r7, #4]
	bl sub_20C5A50
	ldr r1, [sp, #0x48]
	ldr r2, [sp, #0x18]
	mov r4, r0
	str r1, [sp]
	mov r0, r7
	mov r1, r4
	mov r3, r2
	bl sub_20C0230
	cmp r0, r4
	ldr r1, _020C4590 // =0x0214586C
	mov r0, r7
	ldr r1, [r1]
	ldrlo r5, [sp, #0x1c]
	blx r1
	ldr r0, [sp, #8]
	subs r6, r6, r5
	add r0, r0, r5
	str r0, [sp, #8]
	beq _020C4578
	cmp r5, #0
	bne _020C448C
_020C4578:
	ldr r0, [sp, #8]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C4588: .word 0x00000B4F
_020C458C: .word 0x02145840
_020C4590: .word 0x0214586C
	arm_func_end sub_20C443C

	arm_func_start sub_20C4594
sub_20C4594: // 0x020C4594
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r4, [r5, #0xc]
	ldr r0, [r4, #0x824]
	cmp r0, #0
	beq _020C45BC
	ldrb r0, [r4, #0x456]
	cmp r0, #0
	bne _020C45C4
_020C45BC:
	mov r0, r5
	bl sub_20C4630
_020C45C4:
	ldr r1, [r4, #0x824]
	cmp r1, #0
	beq _020C45F0
	ldrb r0, [r4, #0x456]
	cmp r0, #0
	ldrne r1, [r4, #0x828]
	ldrne r0, [r4, #0x82c]
	addne sp, sp, #4
	subne r0, r1, r0
	ldmneia sp!, {r4, r5, lr}
	bxne lr
_020C45F0:
	cmp r1, #0
	bne _020C4620
	ldrb r0, [r5, #8]
	cmp r0, #4
	bne _020C4610
	ldrb r0, [r4, #0x455]
	cmp r0, #9
	bne _020C4620
_020C4610:
	add sp, sp, #4
	mvn r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020C4620:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C4594

	arm_func_start sub_20C4630
sub_20C4630: // 0x020C4630
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0xc]
	ldr r0, [r4, #0x824]
	cmp r0, #0
	bne _020C46E0
	ldr r0, [r5, #0x44]
	cmp r0, #5
	addlo sp, sp, #8
	ldmloia sp!, {r4, r5, r6, lr}
	bxlo lr
	add r0, sp, #0
	mov r1, r5
	bl sub_20C071C
	ldrb r2, [r0, #3]
	ldrb r0, [r0, #4]
	ldr r1, _020C478C // =0x00004805
	add r0, r0, r2, lsl #8
	add r0, r0, #5
	str r0, [sp]
	cmp r0, r1
	movhi r0, #9
	addhi sp, sp, #8
	strhib r0, [r4, #0x455]
	ldmhiia sp!, {r4, r5, r6, lr}
	bxhi lr
	ldr r1, _020C4790 // =0x02145840
	ldr r1, [r1]
	blx r1
	str r0, [r4, #0x824]
	ldr r0, [r4, #0x824]
	cmp r0, #0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r4, #0x455]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r1, [sp]
	mov r0, #0
	str r1, [r4, #0x828]
	str r0, [r4, #0x82c]
	strb r0, [r4, #0x456]
	b _020C46F4
_020C46E0:
	ldr r0, [r5, #0x44]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
_020C46F4:
	add r0, sp, #0
	mov r1, r5
	bl sub_20C071C
	ldr r3, [r4, #0x828]
	ldr r2, [r4, #0x82c]
	ldr r1, [sp]
	sub r2, r3, r2
	cmp r1, r2
	strhs r2, [sp]
	movhs r6, #1
	ldr r3, [r4, #0x824]
	ldr r1, [r4, #0x82c]
	ldr r2, [sp]
	add r1, r3, r1
	movlo r6, #0
	bl MI_CpuCopy8
	ldr r0, [sp]
	mov r1, r5
	bl sub_20C05DC
	cmp r6, #0
	beq _020C4770
	ldr r1, [r4, #0x824]
	mov r0, r4
	bl sub_20C5744
	ldrb r0, [r4, #0x456]
	add sp, sp, #8
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x824]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C4770:
	ldr r1, [r4, #0x82c]
	ldr r0, [sp]
	add r0, r1, r0
	str r0, [r4, #0x82c]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C478C: .word 0x00004805
_020C4790: .word 0x02145840
	arm_func_end sub_20C4630

	arm_func_start sub_20C4794
sub_20C4794: // 0x020C4794
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0xc]
	ldr r2, [r4, #0x828]
	ldr r1, [r4, #0x82c]
	sub r2, r2, r1
	cmp r0, r2
	blo _020C47D8
	ldr r0, [r4, #0x824]
	cmp r0, #0
	beq _020C47C8
	ldr r1, _020C47E8 // =0x0214586C
	ldr r1, [r1]
	blx r1
_020C47C8:
	mov r0, #0
	str r0, [r4, #0x824]
	ldmia sp!, {r4, lr}
	bx lr
_020C47D8:
	add r0, r1, r0
	str r0, [r4, #0x82c]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C47E8: .word 0x0214586C
	arm_func_end sub_20C4794

	arm_func_start sub_20C47EC
sub_20C47EC: // 0x020C47EC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldr r4, [r5, #0xc]
	mov r6, r0
	ldr ip, [r4, #0x824]
	cmp ip, #0
	beq _020C4874
	ldrb r0, [r4, #0x456]
	cmp r0, #0
	bne _020C4874
	ldr r3, [r4, #0x82c]
	ldr r1, [r4, #0x828]
	mov r2, r5
	add r0, ip, r3
	sub r1, r1, r3
	bl sub_20C59D0
	cmp r0, #0
	beq _020C4858
	ldr r1, _020C48CC // =0x0214586C
	ldr r0, [r4, #0x824]
	ldr r1, [r1]
	blx r1
	mov r0, #0
	str r0, [r4, #0x824]
	str r0, [r6]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C4858:
	ldr r1, [r4, #0x824]
	mov r0, r4
	bl sub_20C5744
	ldrb r0, [r4, #0x456]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x824]
_020C4874:
	ldr r0, [r4, #0x824]
	cmp r0, #0
	bne _020C48A8
_020C4880:
	mov r0, r5
	bl sub_20C5584
	cmp r0, #9
	moveq r0, #0
	streq r0, [r6]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r0, [r4, #0x824]
	cmp r0, #0
	beq _020C4880
_020C48A8:
	ldr r1, [r4, #0x828]
	ldr r0, [r4, #0x82c]
	sub r0, r1, r0
	str r0, [r6]
	ldr r1, [r4, #0x824]
	ldr r0, [r4, #0x82c]
	add r0, r1, r0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C48CC: .word 0x0214586C
	arm_func_end sub_20C47EC

	arm_func_start sub_20C48D0
sub_20C48D0: // 0x020C48D0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldrb r1, [r5, #8]
	ldr r4, [r5, #0xc]
	cmp r1, #4
	beq _020C4904
	bl sub_20C09EC
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, lr}
	bxne lr
_020C4904:
	mov r1, #0
	strb r1, [r4, #0x455]
	str r1, [r4, #0x1d4]
	add r0, r4, #0x2ec
	strb r1, [r4, #0x454]
	bl sub_20C8228
	add r0, r4, #0x3a4
	bl sub_20C7BE8
	mov r0, r5
	bl sub_20C4938
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C48D0

	arm_func_start sub_20C4938
sub_20C4938: // 0x020C4938
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r4, [r5, #0xc]
	bl sub_20C4E40
_020C494C:
	mov r0, r5
	bl sub_20C5584
	cmp r0, #9
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	cmp r0, #4
	beq _020C497C
	ldrb r0, [r4, #0x31]
	cmp r0, #0
	beq _020C494C
_020C497C:
	ldrb r0, [r4, #0x31]
	cmp r0, #0
	beq _020C49B8
	mov r0, r4
	bl sub_20C61B8
	mov r0, r5
	bl sub_20C4B50
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	mov r0, r5
	bl sub_20C4FF0
	b _020C4A10
_020C49B8:
	mov r0, r5
	bl sub_20C4B88
	mov r0, r4
	bl sub_20C63C0
	ldrb r0, [r4, #0x30]
	cmp r0, #0
	beq _020C49E4
	ldrh r2, [r5, #0x18]
	ldr r1, [r5, #0x1c]
	mov r0, r4
	bl sub_20C7864
_020C49E4:
	mov r0, r4
	bl sub_20C61B8
	mov r0, r5
	bl sub_20C4FF0
	mov r0, r5
	bl sub_20C4B50
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, lr}
	bxne lr
_020C4A10:
	mov r0, #8
	strb r0, [r4, #0x455]
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C4938

	arm_func_start sub_20C4A28
sub_20C4A28: // 0x020C4A28
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r8, [r9, #0xc]
	add r5, r8, #0x2ec
	add r4, r8, #0x3a4
	mov r7, #0
	mov r6, #1
_020C4A48:
	mov r0, r9
	bl sub_20C0B20
	strb r7, [r8, #0x455]
	str r7, [r8, #0x1d4]
	mov r0, r5
	strb r6, [r8, #0x454]
	bl sub_20C8228
	mov r0, r4
	bl sub_20C7BE8
	mov r0, r9
	bl sub_20C4AB4
	cmp r0, #0
	moveq r0, #8
	addeq sp, sp, #4
	streqb r0, [r8, #0x455]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	mov r0, r9
	bl sub_20C08E0
	ldrh r0, [r9, #0x1a]
	strh r0, [r9, #0x18]
	ldr r0, [r9, #0x20]
	str r0, [r9, #0x1c]
	b _020C4A48
	arm_func_end sub_20C4A28

	arm_func_start sub_20C4AA8
sub_20C4AA8: // 0x020C4AA8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20C4AA8

	arm_func_start sub_20C4AB4
sub_20C4AB4: // 0x020C4AB4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20C5584
	cmp r0, #1
	movne r0, #1
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r0, r4
	bl sub_20C5150
	cmp r0, #0
	beq _020C4B0C
	ldr r0, [r4, #0xc]
	bl sub_20C61B8
	mov r0, r4
	bl sub_20C4FF0
	mov r0, r4
	bl sub_20C4B50
	cmp r0, #0
	beq _020C4B44
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020C4B0C:
	mov r0, r4
	bl sub_20C5584
	cmp r0, #5
	movne r0, #1
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r0, r4
	bl sub_20C4B50
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r0, r4
	bl sub_20C4FF0
_020C4B44:
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C4AB4

	arm_func_start sub_20C4B50
sub_20C4B50: // 0x020C4B50
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20C5584
	cmp r0, #7
	movne r0, #1
	ldmneia sp!, {r4, lr}
	bxne lr
	mov r0, r4
	bl sub_20C5584
	cmp r0, #6
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C4B50

	arm_func_start sub_20C4B88
sub_20C4B88: // 0x020C4B88
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r11, r0
	ldr r10, [r11, #0xc]
	mov r0, #3
	strb r0, [r10]
	mov r0, #0
	strb r0, [r10, #1]
	add r0, r10, #2
	mov r1, #0x2e
	bl sub_20C543C
	ldr r4, [r10, #0x594]
	ldr r0, _020C4E30 // =0x02145840
	mov r1, r4, lsl #1
	ldr r2, [r0]
	add r1, r1, r1, lsr #31
	mov r0, r4
	mov r6, r1, asr #1
	blx r2
	movs r5, r0
	moveq r0, #9
	addeq sp, sp, #0xc
	streqb r0, [r10, #0x455]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	mov r0, #0
	strb r0, [r5]
	mov r2, #2
	add r0, r5, #2
	sub r1, r4, #0x33
	strb r2, [r5, #1]
	bl sub_20C543C
	add r1, r5, r4
	mov r0, r10
	sub r3, r4, #0x31
	mov r7, #0
	sub r1, r1, #0x30
	mov r2, #0x30
	strb r7, [r5, r3]
	bl MI_CpuCopy8
	ldr r1, _020C4E30 // =0x02145840
	mov r0, r6, lsl #3
	ldr r1, [r1]
	blx r1
	movs r9, r0
	bne _020C4C64
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r5
	ldr r1, [r1]
	blx r1
	mov r0, #9
	add sp, sp, #0xc
	strb r0, [r10, #0x455]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020C4C64:
	add r0, r9, r6, lsl #1
	add r8, r0, r6, lsl #1
	mov r1, r5
	mov r2, r4
	mov r3, r6
	str r0, [sp, #4]
	add r7, r8, r6, lsl #1
	bl sub_20C8BAC
	ldr r1, _020C4E38 // =0x00000598
	ldr r2, [r10, #0x5a0]
	mov r0, r8
	add r1, r10, r1
	mov r3, r6
	bl sub_20C8BAC
	ldr r1, _020C4E3C // =0x00000494
	mov r0, r7
	mov r2, r4
	add r1, r10, r1
	mov r3, r6
	bl sub_20C8BAC
	bl sub_20C7748
	mov r3, r6
	mov r6, r0
	ldr r1, [sp, #4]
	mov r2, r8
	mov r0, r9
	str r7, [sp]
	bl sub_20C90D8
	mov r0, r6
	bl sub_20C7710
	ldr r1, _020C4E30 // =0x02145840
	add r0, r4, #0x49
	ldr r1, [r1]
	blx r1
	movs r6, r0
	bne _020C4D28
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r5
	ldr r1, [r1]
	blx r1
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r9
	ldr r1, [r1]
	blx r1
	mov r0, #9
	add sp, sp, #0xc
	strb r0, [r10, #0x455]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020C4D28:
	mov r0, #0x16
	strb r0, [r6]
	mov r1, #3
	add r0, r4, #4
	strb r1, [r6, #1]
	mov r1, #0
	strb r1, [r6, #2]
	mov r1, r0, asr #8
	strb r1, [r6, #3]
	add r2, r6, #9
	strb r0, [r6, #4]
	mov r0, #0x10
	strb r0, [r6, #5]
	mov r0, r4, asr #0x10
	strb r0, [r6, #6]
	mov r0, r4, asr #8
	strb r0, [r6, #7]
	mov r0, r2
	strb r4, [r6, #8]
	ands r1, r4, #1
	beq _020C4D94
	add r0, r4, r4, lsr #31
	mov r0, r0, asr #1
	mov r0, r0, lsl #1
	ldrh r1, [r9, r0]
	add r0, r2, #1
	strb r1, [r2]
_020C4D94:
	add r1, r4, r4, lsr #31
	mov r1, r1, asr #1
	subs r7, r1, #1
	bmi _020C4DCC
_020C4DA4:
	mov r3, r7, lsl #1
	ldrh r1, [r9, r3]
	add r2, r0, #1
	subs r7, r7, #1
	mov r1, r1, asr #8
	strb r1, [r0]
	ldrh r1, [r9, r3]
	add r0, r0, #2
	strb r1, [r2]
	bpl _020C4DA4
_020C4DCC:
	mov r2, #0
	mov r0, r6
	mov r3, r2
	add r1, r4, #9
	str r11, [sp]
	bl sub_20C0230
	mov r0, r10
	add r1, r6, #5
	add r2, r4, #4
	bl sub_20C59A0
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r9
	ldr r1, [r1]
	blx r1
	ldr r1, _020C4E34 // =0x0214586C
	mov r0, r5
	ldr r1, [r1]
	blx r1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C4E30: .word 0x02145840
_020C4E34: .word 0x0214586C
_020C4E38: .word 0x00000598
_020C4E3C: .word 0x00000494
	arm_func_end sub_20C4B88

	arm_func_start sub_20C4E40
sub_20C4E40: // 0x020C4E40
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _020C4FE4 // =0x02145840
	mov r8, r0
	ldr r1, [r1]
	mov r0, #0x98
	ldr r7, [r8, #0xc]
	blx r1
	movs r6, r0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r7, #0x455]
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	mov r0, #3
	strb r0, [r6, #9]
	add r5, r6, #9
	mov r0, #0
	strb r0, [r5, #1]
	bl sub_20C77B8
	mov r1, r0, lsr #0x18
	strb r1, [r7, #0x34]
	mov r1, r0, lsr #0x10
	strb r1, [r7, #0x35]
	mov r1, r0, lsr #8
	strb r1, [r7, #0x36]
	strb r0, [r7, #0x37]
	add r0, r7, #0x38
	mov r1, #0x1c
	bl sub_20C543C
	add r0, r7, #0x34
	add r1, r5, #2
	mov r2, #0x20
	bl MI_CpuCopy8
	ldrh r2, [r8, #0x18]
	ldr r1, [r8, #0x1c]
	mov r0, r7
	bl sub_20C7964
	ldrb r0, [r7, #0x30]
	cmp r0, #0
	moveq r0, #0
	streqb r0, [r5, #0x22]
	addeq r5, r5, #0x23
	beq _020C4F08
	mov r2, #0x20
	add r0, r7, #0x74
	add r1, r5, #0x23
	strb r2, [r5, #0x22]
	bl MI_CpuCopy8
	add r5, r5, #0x43
_020C4F08:
	mov r4, #0
	strb r4, [r5]
	mov r0, #4
	strb r0, [r5, #1]
	ldr r2, _020C4FE8 // =0x0211F1E0
	add r5, r5, #2
_020C4F20:
	mov r3, r4, lsl #1
	ldrh r0, [r2, r3]
	add r4, r4, #1
	add r1, r5, #1
	mov r0, r0, asr #8
	strb r0, [r5]
	ldrh r0, [r2, r3]
	cmp r4, #2
	add r5, r5, #2
	strb r0, [r1]
	blo _020C4F20
	mov r3, #1
	mov r2, #0
	strb r3, [r5]
	add r0, r5, #2
	sub r0, r0, r6
	sub r4, r0, #5
	strb r2, [r5, #1]
	sub r1, r4, #4
	mov r0, #0x16
	strb r0, [r6]
	mov r0, #3
	strb r0, [r6, #1]
	strb r2, [r6, #2]
	mov r0, r4, asr #8
	strb r0, [r6, #3]
	strb r4, [r6, #4]
	strb r3, [r6, #5]
	mov r0, r1, asr #0x10
	strb r0, [r6, #6]
	mov r0, r1, asr #8
	strb r0, [r6, #7]
	strb r1, [r6, #8]
	mov r0, r6
	mov r3, r2
	add r1, r4, #5
	str r8, [sp]
	bl sub_20C0230
	mov r0, r7
	mov r2, r4
	add r1, r6, #5
	bl sub_20C59A0
	ldr r1, _020C4FEC // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C4FE4: .word 0x02145840
_020C4FE8: .word 0x0211F1E0
_020C4FEC: .word 0x0214586C
	arm_func_end sub_20C4E40

	arm_func_start sub_20C4FF0
sub_20C4FF0: // 0x020C4FF0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r1, _020C5148 // =0x02145840
	mov r6, r0
	ldr r1, [r1]
	mov r0, #0x83
	ldr r5, [r6, #0xc]
	blx r1
	movs r4, r0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r5, #0x455]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r0, #0x14
	strb r0, [r4]
	mov r0, #3
	strb r0, [r4, #1]
	mov r1, #0
	strb r1, [r4, #2]
	strb r1, [r4, #3]
	mov r3, #1
	strb r3, [r4, #4]
	add r0, r5, #0x1cc
	mov r2, #8
	strb r3, [r4, #5]
	bl MI_CpuFill8
	mov r0, #0x16
	strb r0, [r4, #6]
	mov r0, #3
	strb r0, [r4, #7]
	mov r1, #0
	strb r1, [r4, #8]
	strb r1, [r4, #9]
	mov r0, #0x28
	strb r0, [r4, #0xa]
	mov r0, #0x14
	strb r0, [r4, #0xb]
	strb r1, [r4, #0xc]
	strb r1, [r4, #0xd]
	mov r3, #0x24
	add r0, r5, #0x3a4
	add r1, r5, #0x3fc
	mov r2, #0x58
	strb r3, [r4, #0xe]
	bl MI_CpuCopy8
	mov r0, r5
	add r1, r4, #0xf
	mov r2, #0
	bl sub_20C6090
	add r0, r5, #0x3fc
	add r1, r5, #0x3a4
	mov r2, #0x58
	bl MI_CpuCopy8
	add r0, r5, #0x2ec
	add r1, r5, #0x348
	mov r2, #0x5c
	bl MI_CpuCopy8
	mov r0, r5
	add r1, r4, #0x1f
	mov r2, #0
	bl sub_20C5FA8
	add r0, r5, #0x348
	add r1, r5, #0x2ec
	mov r2, #0x5c
	bl MI_CpuCopy8
	mov r0, r5
	add r1, r4, #0xb
	mov r2, #0x28
	bl sub_20C59A0
	mov r0, r5
	add r1, r4, #6
	bl sub_20C5A50
	mov r2, #0
	add r1, r0, #6
	mov r0, r4
	mov r3, r2
	str r6, [sp]
	bl sub_20C0230
	ldr r1, _020C514C // =0x0214586C
	mov r0, r4
	ldr r1, [r1]
	blx r1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C5148: .word 0x02145840
_020C514C: .word 0x0214586C
	arm_func_end sub_20C4FF0

	arm_func_start sub_20C5150
sub_20C5150: // 0x020C5150
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r7, [r9, #0xc]
	ldr r4, [r7, #0x820]
	cmp r4, #0
	ldrne r8, [r4]
	moveq r8, #0
	bl sub_20C77B8
	mov r1, r0, lsr #0x18
	strb r1, [r7, #0x54]
	mov r1, r0, lsr #0x10
	strb r1, [r7, #0x55]
	mov r1, r0, lsr #8
	strb r1, [r7, #0x56]
	strb r0, [r7, #0x57]
	add r0, r7, #0x58
	mov r1, #0x1c
	bl sub_20C543C
	ldr r1, _020C53BC // =0x02145840
	add r0, r8, #0x9d
	ldr r1, [r1]
	blx r1
	movs r6, r0
	moveq r0, #9
	streqb r0, [r7, #0x455]
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	mov r0, #2
	add r5, r6, #5
	strb r0, [r6, #5]
	mov r3, #0
	strb r3, [r5, #1]
	strb r3, [r5, #2]
	mov r0, #0x46
	strb r0, [r5, #3]
	mov r0, #3
	strb r0, [r5, #4]
	add r0, r7, #0x54
	add r1, r5, #6
	mov r2, #0x20
	strb r3, [r5, #5]
	bl MI_CpuCopy8
	mov r2, #0x20
	strb r2, [r5, #0x26]
	ldrb r0, [r7, #0x30]
	cmp r0, #0
	beq _020C5234
	add r0, r7, #0x74
	add r1, r5, #0x27
	bl MI_CpuCopy8
	mov r0, #1
	strb r0, [r7, #0x31]
	add r5, r5, #0x47
	b _020C5294
_020C5234:
	add r0, r5, #0x27
	mov r1, #0x1c
	bl sub_20C543C
	ldr r0, _020C53C0 // =0x02147064
	add r2, r5, #0x46
	ldr r3, [r0]
	add r1, r7, #0x74
	mov r0, r3, lsr #0x18
	strb r0, [r5, #0x43]
	mov r0, r3, lsr #0x10
	strb r0, [r5, #0x44]
	mov r0, r3, lsr #8
	strb r0, [r5, #0x45]
	add r5, r5, #0x47
	sub r0, r5, #0x20
	strb r3, [r2]
	mov r2, #0x20
	bl MI_CpuCopy8
	ldr r0, _020C53C0 // =0x02147064
	mov r1, #0
	ldr r2, [r0]
	add r2, r2, #1
	str r2, [r0]
	strb r1, [r7, #0x31]
_020C5294:
	ldrh r2, [r7, #0x32]
	mov r0, #0
	mov r2, r2, asr #8
	strb r2, [r5]
	ldrh r2, [r7, #0x32]
	strb r2, [r5, #1]
	strb r0, [r5, #2]
	ldrb r0, [r7, #0x31]
	add r5, r5, #3
	cmp r0, #0
	bne _020C5348
	cmp r8, #0
	beq _020C532C
	mov r0, #0xb
	add r2, r8, #6
	strb r0, [r5]
	mov r0, r2, asr #0x10
	strb r0, [r5, #1]
	mov r0, r2, asr #8
	strb r0, [r5, #2]
	add r1, r8, #3
	strb r2, [r5, #3]
	mov r0, r1, asr #0x10
	strb r0, [r5, #4]
	mov r0, r1, asr #8
	strb r0, [r5, #5]
	strb r1, [r5, #6]
	mov r0, r8, asr #0x10
	strb r0, [r5, #7]
	mov r0, r8, asr #8
	strb r0, [r5, #8]
	strb r8, [r5, #9]
	add r5, r5, #0xa
	ldr r0, [r4, #4]
	mov r1, r5
	mov r2, r8
	bl MI_CpuCopy8
	add r5, r5, r8
_020C532C:
	mov r0, #0xe
	strb r0, [r5]
	mov r1, #0
	strb r1, [r5, #1]
	strb r1, [r5, #2]
	strb r1, [r5, #3]
	add r5, r5, #4
_020C5348:
	mov r0, #0x16
	sub r1, r5, r6
	sub r4, r1, #5
	strb r0, [r6]
	mov r0, #3
	strb r0, [r6, #1]
	mov r0, #0
	strb r0, [r6, #2]
	mov r0, r4, asr #8
	strb r0, [r6, #3]
	mov r0, r7
	mov r2, r4
	add r1, r6, #5
	strb r4, [r6, #4]
	bl sub_20C59A0
	mov r2, #0
	mov r0, r6
	mov r3, r2
	add r1, r4, #5
	str r9, [sp]
	bl sub_20C0230
	ldr r1, _020C53C4 // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	ldrb r0, [r7, #0x31]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020C53BC: .word 0x02145840
_020C53C0: .word 0x02147064
_020C53C4: .word 0x0214586C
	arm_func_end sub_20C5150

	arm_func_start sub_20C53C8
sub_20C53C8: // 0x020C53C8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x60
	mov r6, r0
	add r0, sp, #0
	mov r5, r1
	bl sub_20C8228
	bl OS_DisableInterrupts
	mov r4, r0
	ldr r1, _020C5434 // =0x02147068
	add r0, sp, #0
	mov r2, #0x14
	bl sub_20C8168
	mov r1, r6
	mov r2, r5
	add r0, sp, #0
	bl sub_20C8168
	ldr r1, _020C5434 // =0x02147068
	add r0, sp, #0
	bl sub_20C80F4
	mov r0, r4
	bl OS_RestoreInterrupts
	ldr r0, _020C5438 // =0x02147060
	mov r1, #1
	strb r1, [r0]
	add sp, sp, #0x60
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C5434: .word 0x02147068
_020C5438: .word 0x02147060
	arm_func_end sub_20C53C8

	arm_func_start sub_20C543C
sub_20C543C: // 0x020C543C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x7c
	ldr r2, _020C5574 // =0x02147060
	mov r10, r0
	ldrb r0, [r2]
	mov r9, r1
	cmp r0, #0
	bne _020C54A4
	ldr r2, _020C5578 // =0x0214589C
	add r0, sp, #4
	ldr r4, [r2, #8]
	ldr r3, [r2]
	ldr r1, [r2, #4]
	umull r6, r5, r4, r3
	mla r5, r4, r1, r5
	ldr r1, [r2, #0xc]
	ldr r4, [r2, #0x10]
	mla r5, r1, r3, r5
	adds r4, r4, r6
	ldr r3, [r2, #0x14]
	mov r1, #4
	adc r3, r3, r5
	str r4, [r2]
	str r3, [r2, #4]
	str r3, [sp, #4]
	bl sub_20C53C8
_020C54A4:
	cmp r9, #0
	mov r7, #0
	addle sp, sp, #0x7c
	mov r1, #0x14
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxle lr
	add r6, sp, #0x1c
	mov r11, r1
	str r7, [sp]
	mov r5, #1
	mov r4, #0x13
_020C54D0:
	cmp r1, #0x14
	bne _020C5548
	mov r0, r6
	bl sub_20C8228
	bl OS_DisableInterrupts
	mov r8, r0
	ldr r1, _020C557C // =0x02147068
	mov r0, r6
	mov r2, r11
	bl sub_20C8168
	mov r0, r6
	add r1, sp, #8
	bl sub_20C80B8
	ldr r2, _020C5580 // =0x0214707B
	mov ip, r5
	mov lr, r4
	add r3, sp, #0x1b
_020C5514:
	ldrb r1, [r2]
	ldrb r0, [r3], #-1
	subs lr, lr, #1
	add r0, r1, r0
	add r0, ip, r0
	strb r0, [r2]
	mov ip, r0, lsr #8
	sub r2, r2, #1
	bpl _020C5514
	str r0, [sp, #4]
	mov r0, r8
	bl OS_RestoreInterrupts
	ldr r1, [sp]
_020C5548:
	add r0, sp, #8
	ldrb r0, [r0, r1]
	add r1, r1, #1
	cmp r0, #0
	strneb r0, [r10, r7]
	addne r7, r7, #1
	cmp r7, r9
	blt _020C54D0
	add sp, sp, #0x7c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C5574: .word 0x02147060
_020C5578: .word 0x0214589C
_020C557C: .word 0x02147068
_020C5580: .word 0x0214707B
	arm_func_end sub_20C543C

	arm_func_start sub_20C5584
sub_20C5584: // 0x020C5584
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	ldr r4, [r5, #0xc]
	add r6, sp, #0
_020C5598:
	mov r0, r6
	mov r1, r5
	bl sub_20C071C
	ldr r1, [sp]
	cmp r1, #0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r4, #0x455]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	cmp r1, #5
	blo _020C5598
	ldrb r1, [r0]
	cmp r1, #0x80
	bne _020C5690
	ldrb r1, [r4, #0x454]
	cmp r1, #0
	beq _020C5684
	ldrb r1, [r4, #0x455]
	cmp r1, #0
	bne _020C5684
	ldrb r2, [r0, #1]
	mov r1, r5
	mov r0, #2
	str r2, [sp]
	bl sub_20C05DC
	ldr r1, _020C5738 // =0x02145840
	ldr r0, [sp]
	ldr r1, [r1]
	blx r1
	movs r6, r0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r4, #0x455]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r1, [sp]
	mov r2, r5
	bl sub_20C59D0
	cmp r0, #0
	bne _020C5658
	ldrb r0, [r6]
	cmp r0, #1
	bne _020C5658
	mov r0, r4
	add r1, r6, #1
	bl sub_20C67D0
	b _020C5660
_020C5658:
	mov r0, #9
	strb r0, [r4, #0x455]
_020C5660:
	ldr r2, [sp]
	mov r0, r4
	mov r1, r6
	bl sub_20C59A0
	ldr r1, _020C573C // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	b _020C5728
_020C5684:
	mov r0, #9
	strb r0, [r4, #0x455]
	b _020C5728
_020C5690:
	ldrb r2, [r0, #3]
	ldrb r0, [r0, #4]
	ldr r1, _020C5740 // =0x00004805
	add r0, r0, r2, lsl #8
	add r0, r0, #5
	str r0, [sp]
	cmp r0, r1
	movhi r0, #9
	addhi sp, sp, #8
	strhib r0, [r4, #0x455]
	ldmhiia sp!, {r4, r5, r6, lr}
	bxhi lr
	ldr r1, _020C5738 // =0x02145840
	ldr r1, [r1]
	blx r1
	movs r6, r0
	moveq r0, #9
	addeq sp, sp, #8
	streqb r0, [r4, #0x455]
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r1, [sp]
	mov r2, r5
	bl sub_20C59D0
	cmp r0, #0
	beq _020C571C
	ldr r1, _020C573C // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	mov r0, #9
	add sp, sp, #8
	strb r0, [r4, #0x455]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C571C:
	mov r0, r4
	mov r1, r6
	bl sub_20C5744
_020C5728:
	ldrb r0, [r4, #0x455]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C5738: .word 0x02145840
_020C573C: .word 0x0214586C
_020C5740: .word 0x00004805
	arm_func_end sub_20C5584

	arm_func_start sub_20C5744
sub_20C5744: // 0x020C5744
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldrb r0, [r8, #0x455]
	mov r7, r1
	cmp r0, #9
	bne _020C5774
	ldr r1, _020C599C // =0x0214586C
	mov r0, r7
	ldr r1, [r1]
	blx r1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020C5774:
	ldrb r2, [r7, #3]
	ldrb r1, [r7, #4]
	add r0, r0, #0xf9
	and r0, r0, #0xff
	add r1, r1, r2, lsl #8
	cmp r0, #1
	add r5, r1, #5
	ldrb r4, [r7]
	bhi _020C57A0
	cmp r4, #0x15
	bne _020C57B0
_020C57A0:
	cmp r4, #0x15
	bne _020C57C0
	cmp r5, #7
	bls _020C57C0
_020C57B0:
	mov r0, r8
	mov r1, r7
	bl sub_20C5C64
	mov r5, r0
_020C57C0:
	sub r0, r4, #0x14
	cmp r0, #3
	add r6, r7, #5
	sub r5, r5, #5
	addls pc, pc, r0, lsl #2
	b _020C597C
_020C57D8: // jump table
	b _020C57E8 // case 0
	b _020C5818 // case 1
	b _020C582C // case 2
	b _020C5958 // case 3
_020C57E8:
	ldr r0, [r8, #0x1d4]
	cmp r0, #0
	moveq r0, #9
	streqb r0, [r8, #0x455]
	beq _020C5984
	add r0, r8, #0x2e4
	mov r1, #0
	mov r2, #8
	bl MI_CpuFill8
	mov r0, #7
	strb r0, [r8, #0x455]
	b _020C5984
_020C5818:
	ldrb r0, [r6]
	cmp r0, #2
	moveq r0, #9
	streqb r0, [r8, #0x455]
	b _020C5984
_020C582C:
	ldrb r1, [r6, #1]
	ldrb r0, [r6, #2]
	ldrb r3, [r6]
	ldrb r2, [r6, #3]
	mov r1, r1, lsl #0x10
	add r0, r1, r0, lsl #8
	cmp r3, #0xb
	add r4, r2, r0
	add r6, r6, #4
	bgt _020C5880
	cmp r3, #0xb
	bge _020C58F4
	cmp r3, #2
	bgt _020C5920
	cmp r3, #1
	blt _020C5920
	cmp r3, #1
	beq _020C58AC
	cmp r3, #2
	beq _020C58E4
	b _020C5920
_020C5880:
	cmp r3, #0x14
	bgt _020C5920
	cmp r3, #0xe
	blt _020C5920
	cmp r3, #0xe
	beq _020C5904
	cmp r3, #0x10
	beq _020C58D4
	cmp r3, #0x14
	beq _020C5910
	b _020C5920
_020C58AC:
	ldrb r0, [r8, #0x454]
	cmp r0, #0
	beq _020C5928
	ldrb r0, [r8, #0x455]
	cmp r0, #0
	bne _020C5928
	mov r0, r8
	mov r1, r6
	bl sub_20C672C
	b _020C5928
_020C58D4:
	mov r0, r8
	mov r1, r6
	bl sub_20C6178
	b _020C5928
_020C58E4:
	mov r0, r8
	mov r1, r6
	bl sub_20C6970
	b _020C5928
_020C58F4:
	mov r0, r8
	mov r1, r6
	bl sub_20C6A38
	b _020C5928
_020C5904:
	mov r0, #4
	strb r0, [r8, #0x455]
	b _020C5928
_020C5910:
	mov r0, r8
	mov r1, r6
	bl sub_20C5EE0
	b _020C5928
_020C5920:
	mov r0, #9
	strb r0, [r8, #0x455]
_020C5928:
	mov r0, r8
	sub r1, r6, #4
	add r2, r4, #4
	bl sub_20C59A0
	add r0, r4, #4
	add r6, r6, r4
	subs r5, r5, r0
	beq _020C5984
	ldrb r0, [r8, #0x455]
	cmp r0, #9
	bne _020C582C
	b _020C5984
_020C5958:
	str r7, [r8, #0x824]
	mov r0, #5
	str r0, [r8, #0x82c]
	add r0, r5, #5
	str r0, [r8, #0x828]
	mov r0, #1
	strb r0, [r8, #0x456]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020C597C:
	mov r0, #9
	strb r0, [r8, #0x455]
_020C5984:
	ldr r1, _020C599C // =0x0214586C
	mov r0, r7
	ldr r1, [r1]
	blx r1
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C599C: .word 0x0214586C
	arm_func_end sub_20C5744

	arm_func_start sub_20C59A0
sub_20C59A0: // 0x020C59A0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	add r0, r6, #0x2ec
	bl sub_20C8168
	mov r1, r5
	mov r2, r4
	add r0, r6, #0x3a4
	bl sub_20C7B28
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C59A0

	arm_func_start sub_20C59D0
sub_20C59D0: // 0x020C59D0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	add r4, sp, #0
_020C59E8:
	mov r0, r4
	mov r1, r5
	bl sub_20C071C
	ldr r1, [sp]
	cmp r1, #0
	addeq sp, sp, #4
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	cmp r1, r6
	strhi r6, [sp]
	ldr r2, [sp]
	mov r1, r7
	bl MI_CpuCopy8
	ldr r0, [sp]
	mov r1, r5
	bl sub_20C05DC
	ldr r0, [sp]
	sub r6, r6, r0
	cmp r6, #0
	add r7, r7, r0
	bgt _020C59E8
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C59D0

	arm_func_start sub_20C5A50
sub_20C5A50: // 0x020C5A50
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x30
	mov r5, r1
	mov r6, r0
	ldrh r0, [r6, #0x32]
	ldrb r3, [r5, #3]
	ldrb r2, [r5, #4]
	add r1, r5, #5
	cmp r0, #4
	add r4, r2, r3, lsl #8
	add r8, r1, r4
	beq _020C5A8C
	cmp r0, #5
	beq _020C5B60
	b _020C5C30
_020C5A8C:
	add r7, r6, #0x3fc
	mov r0, r7
	bl sub_20C7BE8
	ldr r1, [r6, #0xbc]
	mov r0, r7
	mov r2, #0x10
	bl sub_20C7B28
	add r0, sp, #0
	mov r1, #0x36
	mov r2, #0x30
	bl MI_CpuFill8
	mov r0, r7
	add r1, sp, #0
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r7
	add r1, r6, #0x1cc
	mov r2, #8
	bl sub_20C7B28
	mov r0, r7
	mov r1, r5
	mov r2, #1
	bl sub_20C7B28
	mov r0, r7
	add r1, r5, #3
	add r2, r4, #2
	bl sub_20C7B28
	mov r0, r7
	mov r1, r8
	bl sub_20C7AB4
	mov r0, r7
	bl sub_20C7BE8
	ldr r1, [r6, #0xbc]
	mov r0, r7
	mov r2, #0x10
	bl sub_20C7B28
	add r0, sp, #0
	mov r1, #0x5c
	mov r2, #0x30
	bl MI_CpuFill8
	mov r0, r7
	add r1, sp, #0
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r7
	mov r1, r8
	mov r2, #0x10
	bl sub_20C7B28
	mov r0, r7
	mov r1, r8
	bl sub_20C7AB4
	add r4, r4, #0x10
	b _020C5C30
_020C5B60:
	add r7, r6, #0x348
	mov r0, r7
	bl sub_20C8228
	ldr r1, [r6, #0xbc]
	mov r0, r7
	mov r2, #0x14
	bl sub_20C8168
	add r0, sp, #0
	mov r1, #0x36
	mov r2, #0x28
	bl MI_CpuFill8
	mov r0, r7
	add r1, sp, #0
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r7
	add r1, r6, #0x1cc
	mov r2, #8
	bl sub_20C8168
	mov r0, r7
	mov r1, r5
	mov r2, #1
	bl sub_20C8168
	mov r0, r7
	add r1, r5, #3
	add r2, r4, #2
	bl sub_20C8168
	mov r0, r7
	mov r1, r8
	bl sub_20C80F4
	mov r0, r7
	bl sub_20C8228
	ldr r1, [r6, #0xbc]
	mov r0, r7
	mov r2, #0x14
	bl sub_20C8168
	add r0, sp, #0
	mov r1, #0x5c
	mov r2, #0x28
	bl MI_CpuFill8
	mov r0, r7
	add r1, sp, #0
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r7
	mov r1, r8
	mov r2, #0x14
	bl sub_20C8168
	mov r0, r7
	mov r1, r8
	bl sub_20C80F4
	add r4, r4, #0x14
_020C5C30:
	mov r0, r4, asr #8
	strb r0, [r5, #3]
	mov r2, r4
	add r0, r6, #0xc8
	add r1, r5, #5
	strb r4, [r5, #4]
	bl sub_20C8A28
	add r0, r6, #0x1d4
	bl sub_20C5EBC
	add r0, r4, #5
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C5A50

	arm_func_start sub_20C5C64
sub_20C5C64: // 0x020C5C64
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x44
	mov r6, r1
	ldrb r3, [r6, #3]
	ldrb r2, [r6, #4]
	mov r7, r0
	add r1, r6, #5
	add r2, r2, r3, lsl #8
	bl sub_20C5EA0
	ldrh r1, [r7, #0x32]
	mov r5, r0
	cmp r1, #4
	beq _020C5CA4
	cmp r1, #5
	beq _020C5D88
	b _020C5E68
_020C5CA4:
	sub r5, r5, #0x10
	mov r0, r5, asr #8
	strb r0, [r6, #3]
	add r4, r7, #0x3fc
	mov r0, r4
	strb r5, [r6, #4]
	bl sub_20C7BE8
	ldr r1, [r7, #0x1d4]
	mov r0, r4
	mov r2, #0x10
	bl sub_20C7B28
	add r0, sp, #0x14
	mov r1, #0x36
	mov r2, #0x30
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0x14
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r4
	add r1, r7, #0x2e4
	mov r2, #8
	bl sub_20C7B28
	mov r0, r4
	mov r1, r6
	mov r2, #1
	bl sub_20C7B28
	mov r0, r4
	add r1, r6, #3
	add r2, r5, #2
	bl sub_20C7B28
	mov r0, r4
	add r1, sp, #0
	bl sub_20C7AB4
	mov r0, r4
	bl sub_20C7BE8
	ldr r1, [r7, #0x1d4]
	mov r0, r4
	mov r2, #0x10
	bl sub_20C7B28
	add r0, sp, #0x14
	mov r1, #0x5c
	mov r2, #0x30
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0x14
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x10
	bl sub_20C7B28
	mov r0, r4
	add r1, sp, #0
	bl sub_20C7AB4
	mov r4, #0x10
	b _020C5E68
_020C5D88:
	sub r5, r5, #0x14
	mov r0, r5, asr #8
	strb r0, [r6, #3]
	add r4, r7, #0x348
	mov r0, r4
	strb r5, [r6, #4]
	bl sub_20C8228
	ldr r1, [r7, #0x1d4]
	mov r0, r4
	mov r2, #0x14
	bl sub_20C8168
	add r0, sp, #0x14
	mov r1, #0x36
	mov r2, #0x28
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0x14
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r4
	add r1, r7, #0x2e4
	mov r2, #8
	bl sub_20C8168
	mov r0, r4
	mov r1, r6
	mov r2, #1
	bl sub_20C8168
	mov r0, r4
	add r1, r6, #3
	add r2, r5, #2
	bl sub_20C8168
	mov r0, r4
	add r1, sp, #0
	bl sub_20C80F4
	mov r0, r4
	bl sub_20C8228
	ldr r1, [r7, #0x1d4]
	mov r0, r4
	mov r2, #0x14
	bl sub_20C8168
	add r0, sp, #0x14
	mov r1, #0x5c
	mov r2, #0x28
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0x14
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x14
	bl sub_20C8168
	mov r0, r4
	add r1, sp, #0
	bl sub_20C80F4
	mov r4, #0x14
_020C5E68:
	add r0, r6, #5
	add r1, sp, #0
	mov r2, r4
	add r0, r0, r5
	bl memcmp
	cmp r0, #0
	movne r0, #9
	strneb r0, [r7, #0x455]
	add r0, r7, #0x2ec
	bl sub_20C5EBC
	add r0, r5, #5
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C5C64

	arm_func_start sub_20C5EA0
sub_20C5EA0: // 0x020C5EA0
	stmdb sp!, {r4, lr}
	add r0, r0, #0x1e0
	mov r4, r2
	bl sub_20C8A28
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C5EA0

	arm_func_start sub_20C5EBC
sub_20C5EBC: // 0x020C5EBC
	mov r2, #8
_020C5EC0:
	ldrb r1, [r0, #-1]!
	add r1, r1, #1
	ands r1, r1, #0xff
	strb r1, [r0]
	bxne lr
	subs r2, r2, #1
	bne _020C5EC0
	bx lr
	arm_func_end sub_20C5EBC

	arm_func_start sub_20C5EE0
sub_20C5EE0: // 0x020C5EE0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	mov r4, r1
	add r0, r5, #0x3a4
	add r1, r5, #0x3fc
	mov r2, #0x58
	bl MI_CpuCopy8
	add r1, sp, #0
	mov r0, r5
	mov r2, #1
	bl sub_20C6090
	add r0, r5, #0x3fc
	add r1, r5, #0x3a4
	mov r2, #0x58
	bl MI_CpuCopy8
	add r1, sp, #0
	mov r0, r4
	mov r2, #0x10
	bl memcmp
	cmp r0, #0
	movne r0, #9
	addne sp, sp, #0x14
	strneb r0, [r5, #0x455]
	ldmneia sp!, {r4, r5, lr}
	bxne lr
	add r0, r5, #0x2ec
	add r1, r5, #0x348
	mov r2, #0x5c
	bl MI_CpuCopy8
	add r1, sp, #0
	mov r0, r5
	mov r2, #1
	bl sub_20C5FA8
	add r0, r5, #0x348
	add r1, r5, #0x2ec
	mov r2, #0x5c
	bl MI_CpuCopy8
	add r1, sp, #0
	add r0, r4, #0x10
	mov r2, #0x14
	bl memcmp
	cmp r0, #0
	movne r0, #9
	strneb r0, [r5, #0x455]
	moveq r0, #6
	streqb r0, [r5, #0x455]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C5EE0

	arm_func_start sub_20C5FA8
sub_20C5FA8: // 0x020C5FA8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x28
	mov r6, r0
	ldrb r0, [r6, #0x454]
	mov r5, r1
	add r4, r6, #0x2ec
	eors r0, r0, r2
	beq _020C5FDC
	ldr r1, _020C6088 // =aSrvr
	mov r0, r4
	mov r2, #4
	bl sub_20C8168
	b _020C5FEC
_020C5FDC:
	ldr r1, _020C608C // =aClnt
	mov r0, r4
	mov r2, #4
	bl sub_20C8168
_020C5FEC:
	mov r0, r4
	mov r1, r6
	mov r2, #0x30
	bl sub_20C8168
	add r0, sp, #0
	mov r1, #0x36
	mov r2, #0x28
	bl MI_CpuFill8
	add r1, sp, #0
	mov r0, r4
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	bl sub_20C80F4
	mov r0, r4
	bl sub_20C8228
	mov r1, r6
	mov r0, r4
	mov r2, #0x30
	bl sub_20C8168
	add r0, sp, #0
	mov r1, #0x5c
	mov r2, #0x28
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x28
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	mov r2, #0x14
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	bl sub_20C80F4
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C6088: .word aSrvr
_020C608C: .word aClnt
	arm_func_end sub_20C5FA8

	arm_func_start sub_20C6090
sub_20C6090: // 0x020C6090
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x30
	mov r6, r0
	ldrb r0, [r6, #0x454]
	mov r5, r1
	add r4, r6, #0x3a4
	eors r0, r0, r2
	beq _020C60C4
	ldr r1, _020C6170 // =aSrvr
	mov r0, r4
	mov r2, #4
	bl sub_20C7B28
	b _020C60D4
_020C60C4:
	ldr r1, _020C6174 // =aClnt
	mov r0, r4
	mov r2, #4
	bl sub_20C7B28
_020C60D4:
	mov r0, r4
	mov r1, r6
	mov r2, #0x30
	bl sub_20C7B28
	add r0, sp, #0
	mov r1, #0x36
	mov r2, #0x30
	bl MI_CpuFill8
	add r1, sp, #0
	mov r0, r4
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r4
	mov r1, r5
	bl sub_20C7AB4
	mov r0, r4
	bl sub_20C7BE8
	mov r1, r6
	mov r0, r4
	mov r2, #0x30
	bl sub_20C7B28
	add r0, sp, #0
	mov r1, #0x5c
	mov r2, #0x30
	bl MI_CpuFill8
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r4
	mov r1, r5
	mov r2, #0x10
	bl sub_20C7B28
	mov r0, r4
	mov r1, r5
	bl sub_20C7AB4
	add sp, sp, #0x30
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C6170: .word aSrvr
_020C6174: .word aClnt
	arm_func_end sub_20C6090

	arm_func_start sub_20C6178
sub_20C6178: // 0x020C6178
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x81c]
	bl sub_20C64CC
	mov r0, r4
	bl sub_20C63C0
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl sub_20C7864
	mov r0, r4
	bl sub_20C61B8
	mov r0, #5
	strb r0, [r4, #0x455]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C6178

	arm_func_start sub_20C61B8
sub_20C61B8: // 0x020C61B8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r10, r0
	ldrh r0, [r10, #0x32]
	cmp r0, #4
	beq _020C61EC
	cmp r0, #5
	moveq r0, #0x14
	streq r0, [sp]
	moveq r0, #0x10
	streq r0, [sp, #4]
	moveq r2, #0
	b _020C61FC
_020C61EC:
	mov r0, #0x10
	str r0, [sp]
	str r0, [sp, #4]
	mov r2, #0
_020C61FC:
	ldr r1, [sp]
	ldr r0, [sp, #4]
	mov r9, #0
	add r0, r1, r0
	add r0, r2, r0
	mov r0, r0, lsl #1
	str r0, [sp, #8]
	cmp r0, #0
	ble _020C6314
	mov r0, #0x20
	str r0, [sp, #0x10]
	mov r0, #0x14
	mov r6, r9
	add r5, sp, #0x18
	str r9, [sp, #0xc]
	mov r4, #1
	mov r11, #0x30
	str r0, [sp, #0x14]
_020C6244:
	add r7, r10, #0x348
	mov r0, r7
	bl sub_20C8228
	add r0, r9, #0x41
	strb r0, [sp, #0x18]
	add r0, r9, #1
	ldr r8, [sp, #0xc]
	cmp r0, #0
	ble _020C6288
_020C6268:
	mov r0, r7
	mov r1, r5
	mov r2, r4
	bl sub_20C8168
	add r8, r8, #1
	add r0, r9, #1
	cmp r8, r0
	blt _020C6268
_020C6288:
	mov r0, r7
	mov r1, r10
	mov r2, r11
	bl sub_20C8168
	ldr r2, [sp, #0x10]
	mov r0, r7
	add r1, r10, #0x54
	bl sub_20C8168
	ldr r2, [sp, #0x10]
	mov r0, r7
	add r1, r10, #0x34
	bl sub_20C8168
	mov r0, r7
	add r1, sp, #0x19
	bl sub_20C80F4
	add r7, r10, #0x3fc
	mov r0, r7
	bl sub_20C7BE8
	mov r0, r7
	mov r1, r10
	mov r2, r11
	bl sub_20C7B28
	ldr r2, [sp, #0x14]
	mov r0, r7
	add r1, sp, #0x19
	bl sub_20C7B28
	add r1, r10, #0x74
	mov r0, r7
	add r1, r1, r6
	bl sub_20C7AB4
	ldr r0, [sp, #8]
	add r6, r6, #0x10
	cmp r6, r0
	add r9, r9, #1
	blt _020C6244
_020C6314:
	ldrb r0, [r10, #0x454]
	cmp r0, #0
	beq _020C635C
	add r1, r10, #0x74
	str r1, [r10, #0x1d4]
	ldr r0, [sp]
	ldr r2, [r10, #0x1d4]
	add r1, r1, r0
	add r0, r2, r0, lsl #1
	str r0, [r10, #0x1d8]
	str r1, [r10, #0xbc]
	ldr r1, [r10, #0xbc]
	ldr r0, [sp]
	add r1, r1, r0
	ldr r0, [sp, #4]
	add r0, r1, r0
	str r0, [r10, #0xc0]
	b _020C6394
_020C635C:
	add r1, r10, #0x74
	str r1, [r10, #0xbc]
	ldr r0, [sp]
	ldr r2, [r10, #0xbc]
	add r1, r1, r0
	add r0, r2, r0, lsl #1
	str r0, [r10, #0xc0]
	str r1, [r10, #0x1d4]
	ldr r1, [r10, #0x1d4]
	ldr r0, [sp]
	add r1, r1, r0
	ldr r0, [sp, #4]
	add r0, r1, r0
	str r0, [r10, #0x1d8]
_020C6394:
	ldr r1, [r10, #0x1d8]
	add r0, r10, #0x1e0
	mov r2, #0x10
	bl sub_20C8A98
	ldr r1, [r10, #0xc0]
	add r0, r10, #0xc8
	mov r2, #0x10
	bl sub_20C8A98
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end sub_20C61B8

	arm_func_start sub_20C63C0
sub_20C63C0: // 0x020C63C0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x30
	mov r4, r0
	ldr r1, _020C6418 // =aA
	add r0, sp, #0
	mov r2, r4
	bl sub_20C6424
	ldr r1, _020C641C // =aBb
	add r0, sp, #0x10
	mov r2, r4
	bl sub_20C6424
	ldr r1, _020C6420 // =aCcc
	add r0, sp, #0x20
	mov r2, r4
	bl sub_20C6424
	add r0, sp, #0
	mov r1, r4
	mov r2, #0x30
	bl MI_CpuCopy8
	add sp, sp, #0x30
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C6418: .word aA
_020C641C: .word aBb
_020C6420: .word aCcc
	arm_func_end sub_20C63C0

	arm_func_start sub_20C6424
sub_20C6424: // 0x020C6424
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r5, r2
	add r4, r5, #0x348
	mov r7, r0
	mov r6, r1
	mov r0, r4
	bl sub_20C8228
	mov r0, r6
	bl strlen
	mov r2, r0
	mov r1, r6
	mov r0, r4
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	mov r2, #0x30
	bl sub_20C8168
	mov r0, r4
	add r1, r5, #0x34
	mov r2, #0x40
	bl sub_20C8168
	mov r0, r4
	add r1, sp, #0
	bl sub_20C80F4
	add r4, r5, #0x3fc
	mov r0, r4
	bl sub_20C7BE8
	mov r1, r5
	mov r0, r4
	mov r2, #0x30
	bl sub_20C7B28
	mov r0, r4
	add r1, sp, #0
	mov r2, #0x14
	bl sub_20C7B28
	mov r0, r4
	mov r1, r7
	bl sub_20C7AB4
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C6424

	arm_func_start sub_20C64CC
sub_20C64CC: // 0x020C64CC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	movs r10, r2
	str r0, [sp, #8]
	mov r11, r1
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldr r0, [r10]
	cmp r0, #0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	mov r0, r0, lsl #1
	add r0, r0, r0, lsr #31
	mov r0, r0, asr #1
	add r9, r0, #1
	mov r0, #0x14
	mul r0, r9, r0
	ldr r1, _020C6724 // =0x02145840
	ldr r1, [r1]
	blx r1
	movs r8, r0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	add r7, r8, r9, lsl #1
	add r6, r7, r9, lsl #1
	add r1, r6, r9, lsl #1
	str r1, [sp, #0xc]
	add r1, r1, r9, lsl #1
	add r5, r1, r9, lsl #1
	str r1, [sp, #0x10]
	ldr r2, [r10]
	add r4, r5, r9, lsl #1
	mov r1, r11
	mov r3, r9
	add r11, r4, r9, lsl #1
	bl sub_20C8BAC
	ldr r1, [r10, #0x1c]
	ldr r2, [r10, #0x18]
	mov r0, r7
	mov r3, r9
	bl sub_20C8BAC
	ldr r1, [r10, #0xc]
	ldr r2, [r10, #8]
	mov r0, r5
	mov r3, r9
	bl sub_20C8BAC
	bl sub_20C7748
	str r0, [sp, #0x14]
	ldr r0, [sp, #0xc]
	str r5, [sp]
	mov r1, r8
	mov r2, r7
	mov r3, r9
	bl sub_20C8C0C
	ldr r1, [r10, #0x24]
	ldr r2, [r10, #0x20]
	mov r0, r7
	mov r3, r9
	bl sub_20C8BAC
	ldr r1, [r10, #0x14]
	ldr r2, [r10, #0x10]
	mov r0, r5
	mov r3, r9
	bl sub_20C8BAC
	ldr r0, [sp, #0x10]
	mov r1, r8
	mov r2, r7
	mov r3, r9
	str r5, [sp]
	bl sub_20C8C0C
	ldr r0, [sp, #0x14]
	bl sub_20C7710
	ldr r1, [sp, #0xc]
	ldr r2, [sp, #0x10]
	mov r0, r8
	mov r3, r9
	bl sub_20C9818
	ldr r1, [r10, #0x2c]
	ldr r2, [r10, #0x28]
	mov r0, r7
	mov r3, r9
	bl sub_20C8BAC
	mov r0, r6
	mov r1, r8
	mov r2, r7
	mov r3, r9
	bl sub_20C9664
	ldr r1, [r10, #0x14]
	ldr r2, [r10, #0x10]
	mov r0, r7
	mov r3, r9
	bl sub_20C8BAC
	mov r0, r8
	mov r1, r6
	mov r2, r7
	mov r3, r9
	bl sub_20C9664
	ldr r2, [sp, #0x10]
	mov r0, r6
	mov r1, r8
	mov r3, r9
	bl sub_20C998C
	ldr r1, [r10, #4]
	ldr r2, [r10]
	mov r0, r7
	mov r3, r9
	bl sub_20C8BAC
	mov r0, r6
	mov r1, r9
	bl sub_20C9A38
	cmp r0, #0
	bge _020C66D8
	mov r0, r6
	mov r1, r9
	bl sub_20C98D0
	str r9, [sp]
	mov r1, r6
	mov r2, r7
	mov r3, r4
	mov r0, #0
	str r11, [sp, #4]
	bl sub_20C929C
	mov r0, r4
	mov r1, r7
	mov r2, r4
	mov r3, r9
	bl sub_20C9818
	b _020C66F4
_020C66D8:
	str r9, [sp]
	mov r1, r6
	mov r2, r7
	mov r3, r4
	mov r0, #0
	str r11, [sp, #4]
	bl sub_20C929C
_020C66F4:
	ldr r0, [sp, #8]
	mov r1, r4
	mov r3, r9
	mov r2, #0x30
	bl sub_20C8B64
	ldr r1, _020C6728 // =0x0214586C
	mov r0, r8
	ldr r1, [r1]
	blx r1
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C6724: .word 0x02145840
_020C6728: .word 0x0214586C
	arm_func_end sub_20C64CC

	arm_func_start sub_20C672C
sub_20C672C: // 0x020C672C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r4, r0
	ldrb r0, [r6]
	ldrb r1, [r6, #1]
	bl sub_20C68A8
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	add r0, r6, #2
	add r1, r4, #0x34
	mov r2, #0x20
	bl MI_CpuCopy8
	ldrb r5, [r6, #0x22]
	add r6, r6, #0x23
	cmp r5, #0x20
	movne r0, #0
	strneb r0, [r4, #0x30]
	bne _020C6790
	mov r0, r6
	add r1, r4, #0x74
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r0, r4
	bl sub_20C7A0C
_020C6790:
	add r0, r6, r5
	ldrb r1, [r0, #1]
	ldrb r3, [r6, r5]
	add r0, r0, #2
	mov r2, #2
	add r1, r1, r3, lsl #8
	add r1, r1, r1, lsr #31
	mov r1, r1, asr #1
	bl sub_20C68B8
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	strh r0, [r4, #0x32]
	movne r0, #1
	strneb r0, [r4, #0x455]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C672C

	arm_func_start sub_20C67D0
sub_20C67D0: // 0x020C67D0
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	ldrb r0, [r5]
	ldrb r1, [r5, #1]
	bl sub_20C68A8
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldrb r2, [r5, #2]
	ldrb r1, [r5, #3]
	ldr r3, _020C68A4 // =0x55555556
	add r0, r5, #8
	add r4, r1, r2, lsl #8
	smull r2, r1, r3, r4
	add r1, r1, r4, lsr #31
	mov r2, #3
	bl sub_20C68B8
	mov r0, r0, lsl #0x10
	movs r0, r0, lsr #0x10
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	strh r0, [r6, #0x32]
	ldrb ip, [r5, #4]
	ldrb r0, [r5, #5]
	ldrb r3, [r5, #6]
	ldrb r2, [r5, #7]
	mov r1, #0
	add ip, r0, ip, lsl #8
	add r0, r4, #8
	add r4, r2, r3, lsl #8
	add r0, r0, ip
	strb r1, [r6, #0x30]
	cmp r4, #0x20
	add r5, r5, r0
	blt _020C6874
	mov r0, r5
	add r1, r6, #0x34
	mov r2, #0x20
	bl MI_CpuCopy8
	b _020C6894
_020C6874:
	add r0, r6, #0x34
	rsb r2, r4, #0x20
	bl MI_CpuFill8
	add r1, r6, #0x54
	mov r0, r5
	mov r2, r4
	sub r1, r1, r4
	bl MI_CpuCopy8
_020C6894:
	mov r0, #1
	strb r0, [r6, #0x455]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C68A4: .word 0x55555556
	arm_func_end sub_20C67D0

	arm_func_start sub_20C68A8
sub_20C68A8: // 0x020C68A8
	cmp r0, #3
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end sub_20C68A8

	arm_func_start sub_20C68B8
sub_20C68B8: // 0x020C68B8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, #0
	ldr r4, _020C6918 // =0x0211F1E0
_020C68D0:
	mov r0, r5, lsl #1
	ldrh r3, [r4, r0]
	mov r0, r8
	mov r1, r7
	mov r2, r6
	bl sub_20C691C
	cmp r0, #0
	ldrne r0, _020C6918 // =0x0211F1E0
	movne r1, r5, lsl #1
	ldrneh r0, [r0, r1]
	ldmneia sp!, {r4, r5, r6, r7, r8, lr}
	bxne lr
	add r5, r5, #1
	cmp r5, #2
	blo _020C68D0
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C6918: .word 0x0211F1E0
	arm_func_end sub_20C68B8

	arm_func_start sub_20C691C
sub_20C691C: // 0x020C691C
	stmdb sp!, {r4, lr}
	cmp r1, #0
	mov r4, #0
	ble _020C6964
_020C692C:
	ldrb lr, [r0]
	ldrb ip, [r0, #1]
	cmp r2, #3
	add lr, ip, lr, lsl #8
	ldreqb ip, [r0, #2]
	addeq lr, ip, lr, lsl #8
	cmp lr, r3
	moveq r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r4, r4, #1
	cmp r4, r1
	add r0, r0, r2
	blt _020C692C
_020C6964:
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C691C

	arm_func_start sub_20C6970
sub_20C6970: // 0x020C6970
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r5, r1
	add r0, r5, #2
	add r1, r6, #0x54
	mov r2, #0x20
	bl MI_CpuCopy8
	add r0, r5, #0x22
	ldrb r7, [r6, #0x30]
	add r5, r5, #0x23
	ldrb r4, [r0]
	cmp r7, #0
	beq _020C69D0
	cmp r4, #0x20
	bne _020C69D0
	mov r1, r5
	add r0, r6, #0x74
	mov r2, #0x20
	bl memcmp
	cmp r0, #0
	moveq r0, #1
	streqb r0, [r6, #0x31]
	beq _020C6A10
_020C69D0:
	cmp r7, #0
	beq _020C69E0
	mov r0, r6
	bl sub_20C77F4
_020C69E0:
	cmp r4, #0
	moveq r0, #0
	streqb r0, [r6, #0x30]
	beq _020C6A08
	mov r0, r5
	add r1, r6, #0x74
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r0, #1
	strb r0, [r6, #0x30]
_020C6A08:
	mov r0, #0
	strb r0, [r6, #0x31]
_020C6A10:
	add r0, r5, r4
	ldrb r2, [r5, r4]
	ldrb r1, [r0, #1]
	mov r0, #2
	add r1, r1, r2, lsl #8
	strh r1, [r6, #0x32]
	strb r0, [r6, #0x455]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C6970

	arm_func_start sub_20C6A38
sub_20C6A38: // 0x020C6A38
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r1, [sp, #0x4c]
	mov r10, r0
	ldrb r4, [r1, #2]
	ldrb r3, [r1]
	ldrb r2, [r1, #1]
	add r0, r1, #3
	mvn r1, #0
	str r0, [sp, #0x4c]
	add r2, r2, r3, lsl #8
	add r0, sp, #0x14
	str r1, [r10, #0x45c]
	add r7, r4, r2, lsl #8
	bl RTC_GetDate
	mov r8, #0
	ldr r0, [sp, #0x14]
	ldr r2, [sp, #0x1c]
	add r1, r0, #0x7d0
	ldr r0, [sp, #0x18]
	mov r1, r1, lsl #0x10
	add r0, r1, r0, lsl #8
	add r0, r2, r0
	str r0, [r10, #0x80c]
	strb r8, [r10, #0x6b0]
	str r8, [r10, #0x5a0]
	ldr r0, [r10, #0x5a0]
	mov r6, r8
	str r0, [r10, #0x594]
	add r0, r10, #0x7b0
	str r0, [sp, #4]
	mov r0, #1
	str r8, [sp, #8]
	mov r4, r8
	mov r11, #2
	str r0, [sp, #0xc]
	mvn r5, #0
_020C6AD0:
	ldr r1, [sp, #0x4c]
	mov r0, r10
	ldrb r2, [r1, #2]
	ldrb ip, [r1]
	ldrb r3, [r1, #1]
	add r9, r1, #3
	add r1, sp, #0x4c
	str r9, [sp, #0x4c]
	str r5, [r10, #0x458]
	strb r4, [r10, #0x5ad]
	strb r4, [r10, #0x5ac]
	strb r4, [r10, #0x5af]
	strb r4, [r10, #0x6b0]
	strb r4, [r10, #0x5b0]
	strb r4, [r10, #0x7b0]
	add r3, r3, ip, lsl #8
	ldr r9, [sp, #0x4c]
	add r3, r2, r3, lsl #8
	add r2, r3, #3
	str r9, [r10, #0x804]
	str r3, [r10, #0x808]
	sub r7, r7, r2
	mov r2, r4
	mov r3, r4
	str r8, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	bne _020C6B58
	ldr r0, [r10, #0x594]
	cmp r0, #0x33
	blo _020C6B58
	ldr r0, [r10, #0x5a0]
	cmp r0, #0
	bne _020C6B70
_020C6B58:
	mov r0, #9
	add sp, sp, #0x24
	strb r0, [r10, #0x455]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
_020C6B70:
	mov r0, r10
	bl sub_20C6D18
	mov r8, r0
	cmp r6, #0
	bne _020C6BA0
	ldr r0, [r10, #0x800]
	cmp r0, #0
	beq _020C6BA0
	ldr r1, [sp, #4]
	bl sub_20C6C74
	cmp r0, #0
	orrne r8, r8, #0x4000
_020C6BA0:
	and r9, r8, #0xff
	cmp r9, #1
	bne _020C6C10
	cmp r7, #0
	beq _020C6C10
	ldr r1, [sp, #0x4c]
	ldr r2, [sp, #8]
	add r1, r1, #3
	str r1, [sp, #0x10]
	ldr r1, [sp, #8]
	mov r0, r10
	strb r1, [r10, #0x5ad]
	add r1, sp, #0x10
	mov r3, r2
	str r11, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	movne r0, #9
	addne sp, sp, #0x24
	strneb r0, [r10, #0x455]
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	addne sp, sp, #0x10
	bxne lr
	mov r0, r10
	add r1, r10, #0x480
	bl sub_20C6E18
	bic r1, r8, #0xff
	orr r8, r1, r0
_020C6C10:
	ldr r3, [r10, #0x810]
	cmp r3, #0
	beq _020C6C30
	mov r0, r8
	mov r1, r10
	mov r2, r6
	blx r3
	mov r8, r0
_020C6C30:
	cmp r9, #0
	add r6, r6, #1
	beq _020C6C50
	cmp r8, #0
	bne _020C6C50
	cmp r7, #0
	ldrne r8, [sp, #0xc]
	bne _020C6AD0
_020C6C50:
	cmp r8, #0
	moveq r0, #3
	streqb r0, [r10, #0x455]
	movne r0, #9
	strneb r0, [r10, #0x455]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20C6A38

	arm_func_start sub_20C6C74
sub_20C6C74: // 0x020C6C74
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	b _020C6C94
_020C6C84:
	cmp r1, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
_020C6C94:
	ldrsb r0, [r5], #1
	ldrsb r1, [r6], #1
	cmp r1, r0
	beq _020C6C84
	cmp r0, #0x2a
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, lr}
	bxne lr
	sub r6, r6, #1
	mov r0, r6
	bl sub_20C6CF0
	mov r4, r0
	mov r0, r5
	bl sub_20C6CF0
	cmp r0, r4
	movgt r0, #1
	ldmgtia sp!, {r4, r5, r6, lr}
	bxgt lr
	sub r0, r4, r0
	add r6, r6, r0
	b _020C6C94
	arm_func_end sub_20C6C74

	arm_func_start sub_20C6CE8
sub_20C6CE8: // 0x020C6CE8
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C6CE8

	arm_func_start sub_20C6CF0
sub_20C6CF0: // 0x020C6CF0
	mov r2, r0
	b _020C6CFC
_020C6CF8:
	add r0, r0, #1
_020C6CFC:
	ldrsb r1, [r0]
	cmp r1, #0x2e
	beq _020C6D10
	cmp r1, #0
	bne _020C6CF8
_020C6D10:
	sub r0, r0, r2
	bx lr
	arm_func_end sub_20C6CF0

	arm_func_start sub_20C6D18
sub_20C6D18: // 0x020C6D18
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldrb r0, [r5, #0x5af]
	ldr r1, [r5, #0x45c]
	cmp r0, #0
	movne r4, #0
	moveq r4, #0x8000
	mvn r0, #0
	cmp r1, r0
	orreq r0, r4, #4
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	ldr r0, [r5, #0x458]
	cmp r0, #3
	beq _020C6D60
	cmp r0, #4
	beq _020C6D9C
	b _020C6DD8
_020C6D60:
	add r6, r5, #0x3fc
	mov r0, r6
	bl sub_20C7BE8
	ldr r1, [r5, #0x460]
	ldr r2, [r5, #0x464]
	mov r0, r6
	sub r2, r2, r1
	bl sub_20C7B28
	ldr r1, _020C6E14 // =0x00000468
	mov r0, r6
	add r1, r5, r1
	bl sub_20C7AB4
	mov r0, #0x10
	str r0, [r5, #0x47c]
	b _020C6DE4
_020C6D9C:
	add r6, r5, #0x348
	mov r0, r6
	bl sub_20C8228
	ldr r1, [r5, #0x460]
	ldr r2, [r5, #0x464]
	mov r0, r6
	sub r2, r2, r1
	bl sub_20C8168
	ldr r1, _020C6E14 // =0x00000468
	mov r0, r6
	add r1, r5, r1
	bl sub_20C80F4
	mov r0, #0x14
	str r0, [r5, #0x47c]
	b _020C6DE4
_020C6DD8:
	orr r0, r4, #3
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020C6DE4:
	mov r0, r5
	add r1, r5, #0x5b0
	bl sub_20C7684
	movs r1, r0
	orreq r0, r4, #1
	ldmeqia sp!, {r4, r5, r6, lr}
	bxeq lr
	mov r0, r5
	bl sub_20C6E18
	orr r0, r4, r0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020C6E14: .word 0x00000468
	arm_func_end sub_20C6D18

	arm_func_start sub_20C6E18
sub_20C6E18: // 0x020C6E18
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #8
	mov r8, r0
	ldr r0, [r8, #0x5a4]
	mov r7, r1
	cmp r0, #0
	beq _020C6E70
	ldr r0, [r8, #0x5a8]
	cmp r0, #0
	beq _020C6E70
	ldr r0, [r7, #0x10]
	cmp r0, #0
	beq _020C6E70
	ldr r0, [r7, #0xc]
	cmp r0, #0
	beq _020C6E70
	ldr r0, [r7, #8]
	cmp r0, #0
	beq _020C6E70
	ldr r0, [r7, #4]
	cmp r0, #0
	bne _020C6E80
_020C6E70:
	add sp, sp, #8
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
_020C6E80:
	mov r0, r0, lsl #1
	ldr r1, _020C6FE8 // =0x02145840
	add r0, r0, r0, lsr #31
	mov r4, r0, asr #1
	ldr r1, [r1]
	mov r0, r4, lsl #3
	blx r1
	movs r6, r0
	addeq sp, sp, #8
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bxeq lr
	add r5, r6, r4, lsl #1
	add r10, r5, r4, lsl #1
	ldr r1, [r8, #0x5a4]
	ldr r2, [r8, #0x5a8]
	mov r0, r5
	mov r3, r4
	add r9, r10, r4, lsl #1
	bl sub_20C8BAC
	ldr r1, [r7, #0x10]
	ldr r2, [r7, #0xc]
	mov r0, r10
	mov r3, r4
	bl sub_20C8BAC
	mov r0, r9
	ldr r1, [r7, #8]
	ldr r2, [r7, #4]
	mov r3, r4
	bl sub_20C8BAC
	bl sub_20C7748
	str r9, [sp]
	mov r2, r10
	mov r9, r0
	mov r0, r6
	mov r1, r5
	mov r3, r4
	bl sub_20C90D8
	mov r0, r9
	bl sub_20C7710
	mov r0, r5
	mov r1, r6
	ldr r2, [r7, #4]
	mov r3, r4
	bl sub_20C8B64
	ldrb r0, [r6, r4, lsl #1]
	mov r4, #0
	cmp r0, #0
	bne _020C6F50
	ldrb r0, [r5, #1]
	cmp r0, #1
	beq _020C6F58
_020C6F50:
	mov r4, #2
	b _020C6FC8
_020C6F58:
	ldr r3, [r7, #4]
	mov r2, #2
	cmp r3, #2
	ble _020C6F80
_020C6F68:
	ldrb r0, [r5, r2]
	cmp r0, #0xff
	bne _020C6F80
	add r2, r2, #1
	cmp r2, r3
	blt _020C6F68
_020C6F80:
	add r1, r2, #1
	cmp r1, r3
	bge _020C6FC4
	ldrb r0, [r5, r2]
	cmp r0, #0
	bne _020C6FC4
	ldrb r0, [r5, r1]
	cmp r0, #0x30
	bne _020C6FC4
	ldr r0, _020C6FEC // =0x00000468
	ldr r2, [r8, #0x47c]
	add r1, r5, r3
	add r0, r8, r0
	sub r1, r1, r2
	bl memcmp
	cmp r0, #0
	beq _020C6FC8
_020C6FC4:
	mov r4, #2
_020C6FC8:
	ldr r1, _020C6FF0 // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_020C6FE8: .word 0x02145840
_020C6FEC: .word 0x00000468
_020C6FF0: .word 0x0214586C
	arm_func_end sub_20C6E18

	arm_func_start sub_20C6FF4
sub_20C6FF4: // 0x020C6FF4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	str r1, [sp, #4]
	ldr r1, [r1]
	mov r9, r0
	str r1, [sp, #8]
	add r0, r1, #1
	str r0, [sp, #8]
	add r0, sp, #8
	mov r5, r2
	mov r4, r3
	ldr r8, [sp, #0x30]
	ldrb r6, [r1]
	bl sub_20C7634
	movs r7, r0
	bmi _020C703C
	cmp r7, #0x7d0
	ble _020C704C
_020C703C:
	add sp, sp, #0xc
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020C704C:
	and r1, r6, #0x1f
	cmp r1, #0x18
	addls pc, pc, r1, lsl #2
	b _020C748C
_020C705C: // jump table
	b _020C748C // case 0
	b _020C748C // case 1
	b _020C70C0 // case 2
	b _020C71B8 // case 3
	b _020C748C // case 4
	b _020C748C // case 5
	b _020C7238 // case 6
	b _020C748C // case 7
	b _020C748C // case 8
	b _020C748C // case 9
	b _020C748C // case 10
	b _020C748C // case 11
	b _020C72D0 // case 12
	b _020C748C // case 13
	b _020C748C // case 14
	b _020C748C // case 15
	b _020C73A4 // case 16
	b _020C7434 // case 17
	b _020C748C // case 18
	b _020C72D0 // case 19
	b _020C72D0 // case 20
	b _020C748C // case 21
	b _020C72D0 // case 22
	b _020C7350 // case 23
	b _020C7350 // case 24
_020C70C0:
	ldrb r0, [r9, #0x5ad]
	cmp r0, #0
	beq _020C71A8
	cmp r4, #0
	bne _020C713C
	ldr r0, [sp, #8]
	ldrb r1, [r0]
	cmp r1, #0
	bne _020C7100
_020C70E4:
	ldr r1, [sp, #8]
	sub r7, r7, #1
	add r0, r1, #1
	str r0, [sp, #8]
	ldrb r1, [r1, #1]
	cmp r1, #0
	beq _020C70E4
_020C7100:
	cmp r8, #0
	beq _020C711C
	cmp r8, #2
	streq r7, [r9, #0x484]
	ldreq r0, [sp, #8]
	streq r0, [r9, #0x488]
	b _020C71A8
_020C711C:
	cmp r7, #0x100
	bgt _020C71A8
	ldr r1, _020C7514 // =0x00000494
	mov r2, r7
	add r1, r9, r1
	bl MI_CpuCopy8
	str r7, [r9, #0x594]
	b _020C71A8
_020C713C:
	cmp r4, #1
	bne _020C71A8
	ldr r0, [sp, #8]
	ldrb r1, [r0]
	cmp r1, #0
	bne _020C7170
_020C7154:
	ldr r1, [sp, #8]
	sub r7, r7, #1
	add r0, r1, #1
	str r0, [sp, #8]
	ldrb r1, [r1, #1]
	cmp r1, #0
	beq _020C7154
_020C7170:
	cmp r8, #0
	beq _020C718C
	cmp r8, #2
	streq r7, [r9, #0x48c]
	ldreq r0, [sp, #8]
	streq r0, [r9, #0x490]
	b _020C71A8
_020C718C:
	cmp r7, #8
	bgt _020C71A8
	ldr r1, _020C7518 // =0x00000598
	mov r2, r7
	add r1, r9, r1
	bl MI_CpuCopy8
	str r7, [r9, #0x5a0]
_020C71A8:
	ldr r0, [sp, #8]
	add r0, r0, r7
	str r0, [sp, #8]
	b _020C74F8
_020C71B8:
	cmp r5, #1
	bne _020C71D8
	cmp r8, #2
	ldrne r1, [sp, #8]
	subne r0, r7, #1
	addne r1, r1, #1
	strne r1, [r9, #0x5a4]
	strne r0, [r9, #0x5a8]
_020C71D8:
	ldrb r0, [r9, #0x5ad]
	cmp r0, #0
	beq _020C7228
	ldr r0, [sp, #8]
	add r1, sp, #8
	add r0, r0, #1
	str r0, [sp, #8]
	mov r0, r9
	mov r2, r5
	mov r3, #0
	str r8, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	mov r0, #0
	strb r0, [r9, #0x5ad]
	b _020C74F8
_020C7228:
	ldr r0, [sp, #8]
	add r0, r0, r7
	str r0, [sp, #8]
	b _020C74F8
_020C7238:
	ldr r5, [sp, #8]
	mov r6, #0
	ldr r10, _020C751C // =0x0211F21C
_020C7244:
	ldr r4, [r10, r6, lsl #2]
	mov r0, r4
	bl strlen
	mov r2, r0
	mov r0, r5
	mov r1, r4
	bl memcmp
	cmp r0, #0
	bne _020C72B4
	cmp r6, #5
	addls pc, pc, r6, lsl #2
	b _020C72C0
_020C7274: // jump table
	b _020C72C0 // case 0
	b _020C728C // case 1
	b _020C728C // case 2
	b _020C729C // case 3
	b _020C729C // case 4
	b _020C72A8 // case 5
_020C728C:
	cmp r8, #0
	streq r6, [r9, #0x45c]
	strb r6, [r9, #0x5ad]
	b _020C72C0
_020C729C:
	cmp r8, #2
	strne r6, [r9, #0x458]
	b _020C72C0
_020C72A8:
	cmp r8, #2
	strneb r6, [r9, #0x5ae]
	b _020C72C0
_020C72B4:
	add r6, r6, #1
	cmp r6, #6
	blt _020C7244
_020C72C0:
	ldr r0, [sp, #8]
	add r0, r0, r7
	str r0, [sp, #8]
	b _020C74F8
_020C72D0:
	cmp r8, #2
	beq _020C7338
	ldrb r0, [r9, #0x5ac]
	cmp r0, #0
	beq _020C7328
	ldr r1, [sp, #8]
	mov r2, r7
	add r0, r9, #0x6b0
	bl sub_20C75B0
	ldrb r0, [r9, #0x5ae]
	cmp r0, #5
	bne _020C7338
	cmp r7, #0x4f
	bgt _020C7338
	ldr r0, [sp, #8]
	mov r2, r7
	add r1, r9, #0x7b0
	bl MI_CpuCopy8
	add r0, r9, r7
	mov r1, #0
	strb r1, [r0, #0x7b0]
	b _020C7338
_020C7328:
	ldr r1, [sp, #8]
	mov r2, r7
	add r0, r9, #0x5b0
	bl sub_20C75B0
_020C7338:
	mov r0, #0
	strb r0, [r9, #0x5ae]
	ldr r0, [sp, #8]
	add r0, r0, r7
	str r0, [sp, #8]
	b _020C74F8
_020C7350:
	cmp r8, #2
	beq _020C738C
	ldr r0, [sp, #8]
	bl sub_20C7520
	cmp r4, #0
	bne _020C737C
	ldr r1, [r9, #0x80c]
	cmp r1, r0
	movhs r0, #1
	strhsb r0, [r9, #0x5af]
	b _020C738C
_020C737C:
	ldr r1, [r9, #0x80c]
	cmp r1, r0
	movhi r0, #0
	strhib r0, [r9, #0x5af]
_020C738C:
	ldr r1, [sp, #8]
	mov r0, #1
	add r1, r1, r7
	str r1, [sp, #8]
	strb r0, [r9, #0x5ac]
	b _020C74F8
_020C73A4:
	cmp r5, #0
	bne _020C73C0
	cmp r4, #0
	bne _020C73C0
	cmp r8, #2
	ldrne r0, [sp, #8]
	strne r0, [r9, #0x460]
_020C73C0:
	ldr r0, [sp, #8]
	mov r10, #0
	add r7, r0, r7
	cmp r0, r7
	bhs _020C7418
	add r11, sp, #8
	add r6, r5, #1
_020C73DC:
	mov r0, r9
	mov r1, r11
	mov r2, r6
	mov r3, r10
	str r8, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	add r10, r10, #1
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	ldr r0, [sp, #8]
	cmp r0, r7
	blo _020C73DC
_020C7418:
	cmp r5, #1
	bne _020C74F8
	cmp r4, #0
	bne _020C74F8
	cmp r8, #2
	strne r0, [r9, #0x464]
	b _020C74F8
_020C7434:
	ldr r0, [sp, #8]
	add r6, r0, r7
	cmp r0, r6
	bhs _020C74F8
	add r7, r5, #1
	add r4, sp, #8
	mov r5, #0
_020C7450:
	mov r0, r9
	mov r1, r4
	mov r2, r7
	mov r3, r5
	str r8, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	ldr r0, [sp, #8]
	cmp r0, r6
	blo _020C7450
	b _020C74F8
_020C748C:
	cmp r6, #0xa0
	bne _020C74EC
	ldr r0, [sp, #8]
	add r6, r0, r7
	cmp r0, r6
	bhs _020C74F8
	add r7, r5, #1
	add r4, sp, #8
	mov r5, #0
_020C74B0:
	mov r0, r9
	mov r1, r4
	mov r2, r7
	mov r3, r5
	str r8, [sp]
	bl sub_20C6FF4
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	ldr r0, [sp, #8]
	cmp r0, r6
	blo _020C74B0
	b _020C74F8
_020C74EC:
	ldr r0, [sp, #8]
	add r0, r0, r7
	str r0, [sp, #8]
_020C74F8:
	ldr r2, [sp, #8]
	ldr r1, [sp, #4]
	mov r0, #0
	str r2, [r1]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C7514: .word 0x00000494
_020C7518: .word 0x00000598
_020C751C: .word 0x0211F21C
	arm_func_end sub_20C6FF4

	arm_func_start sub_20C7520
sub_20C7520: // 0x020C7520
	stmdb sp!, {r4, lr}
	ldrb ip, [r0, #1]
	ldrb r3, [r0]
	mov r2, #0xa
	cmp r1, #0x17
	mla r1, r3, r2, ip
	sub lr, r1, #0x210
	add r0, r0, #2
	bne _020C7558
	cmp lr, #0x32
	ldrhs r1, _020C75AC // =0x0000076C
	addlo r4, lr, #0x7d0
	addhs r4, lr, r1
	b _020C7574
_020C7558:
	ldrb ip, [r0, #1]
	ldrb r3, [r0]
	mov r1, #0x64
	add r0, r0, #2
	mla r2, r3, r2, ip
	sub r2, r2, #0x210
	mla r4, lr, r1, r2
_020C7574:
	ldrb ip, [r0, #1]
	ldrb r3, [r0]
	mov r1, #0xa
	ldrb r2, [r0, #3]
	ldrb r0, [r0, #2]
	mla ip, r3, r1, ip
	mla r1, r0, r1, r2
	mov r2, r4, lsl #0x10
	sub r0, ip, #0x210
	add r2, r2, r0, lsl #8
	sub r0, r1, #0x210
	add r0, r2, r0
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C75AC: .word 0x0000076C
	arm_func_end sub_20C7520

	arm_func_start sub_20C75B0
sub_20C75B0: // 0x020C75B0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrsb r3, [r0]
	mov lr, r0
	cmp r3, #0
	beq _020C7608
_020C75C8:
	ldrsb r3, [r0, #1]!
	cmp r3, #0
	bne _020C75C8
	sub r3, r0, lr
	cmp r3, #0xff
	addge sp, sp, #4
	ldmgeia sp!, {lr}
	bxge lr
	mov r3, #0x2c
	strb r3, [r0]
	mov r3, #0x20
	strb r3, [r0, #1]
	add r0, r0, #2
	b _020C7608
_020C7600:
	ldrsb r3, [r1], #1
	strb r3, [r0], #1
_020C7608:
	cmp r2, #0
	sub r2, r2, #1
	beq _020C7620
	sub r3, r0, lr
	cmp r3, #0xff
	blt _020C7600
_020C7620:
	mov r1, #0
	strb r1, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C75B0

	arm_func_start sub_20C7634
sub_20C7634: // 0x020C7634
	ldr r1, [r0]
	ldrb r3, [r1]
	add ip, r1, #1
	ands r1, r3, #0x80
	beq _020C7678
	ands r1, r3, #0x7f
	sub r2, r1, #1
	mov r3, #0
	beq _020C7678
_020C7658:
	ands r1, r3, #0xff000000
	mvnne r0, #0
	bxne lr
	ldrb r1, [ip], #1
	cmp r2, #0
	sub r2, r2, #1
	add r3, r1, r3, lsl #8
	bne _020C7658
_020C7678:
	str ip, [r0]
	mov r0, r3
	bx lr
	arm_func_end sub_20C7634

	arm_func_start sub_20C7684
sub_20C7684: // 0x020C7684
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r4, [r0, #0x818]
	mov r7, r1
	cmp r4, #0
	mov r6, #0
	ble _020C76D4
	ldr r5, [r0, #0x814]
_020C76A4:
	ldr r0, [r5, r6, lsl #2]
	mov r1, r7
	ldr r0, [r0]
	bl strcmp
	cmp r0, #0
	addeq sp, sp, #4
	ldreq r0, [r5, r6, lsl #2]
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	add r6, r6, #1
	cmp r6, r4
	blt _020C76A4
_020C76D4:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C7684

	arm_func_start sub_20C76E4
sub_20C76E4: // 0x020C76E4
	ldr r2, _020C770C // =OSi_ThreadInfo
	ldr r2, [r2, #4]
	ldr r2, [r2, #0xa4]
	cmp r2, #0
	bxeq lr
	ldr r2, [r2, #0xc]
	cmp r2, #0
	strne r0, [r2, #0x814]
	strne r1, [r2, #0x818]
	bx lr
	.align 2, 0
_020C770C: .word OSi_ThreadInfo
	arm_func_end sub_20C76E4

	arm_func_start sub_20C7710
sub_20C7710: // 0x020C7710
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, r0
	cmp r1, #0x20
	addhs sp, sp, #4
	ldmhsia sp!, {lr}
	bxhs lr
	ldr r0, _020C7744 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	bl OS_SetThreadPriority
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C7744: .word OSi_ThreadInfo
	arm_func_end sub_20C7710

	arm_func_start sub_20C7748
sub_20C7748: // 0x020C7748
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _020C77A0 // =0x0211F1E8
	ldr r0, [r0]
	cmp r0, #0x20
	addhs sp, sp, #4
	mvnhs r0, #0
	ldmhsia sp!, {r4, r5, lr}
	bxhs lr
	ldr r0, _020C77A4 // =OSi_ThreadInfo
	ldr r5, [r0, #4]
	mov r0, r5
	bl OS_GetThreadPriority
	ldr r1, _020C77A0 // =0x0211F1E8
	mov r4, r0
	ldr r1, [r1]
	mov r0, r5
	bl OS_SetThreadPriority
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C77A0: .word 0x0211F1E8
_020C77A4: .word OSi_ThreadInfo
	arm_func_end sub_20C7748

	arm_func_start CPS_SetSslLowThreadPriority
CPS_SetSslLowThreadPriority: // 0x020C77A8
	ldr r1, _020C77B4 // =0x0211F1E8
	str r0, [r1]
	bx lr
	.align 2, 0
_020C77B4: .word 0x0211F1E8
	arm_func_end CPS_SetSslLowThreadPriority

	arm_func_start sub_20C77B8
sub_20C77B8: // 0x020C77B8
	stmdb sp!, {lr}
	sub sp, sp, #0x1c
	add r0, sp, #0
	bl RTC_GetDate
	add r0, sp, #0x10
	bl RTC_GetTime
	add r0, sp, #0
	add r1, sp, #0x10
	bl RTC_ConvertDateTimeToSecond
	ldr r1, _020C77F0 // =0x386D4380
	add r0, r0, r1
	add sp, sp, #0x1c
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C77F0: .word 0x386D4380
	arm_func_end sub_20C77B8

	arm_func_start sub_20C77F4
sub_20C77F4: // 0x020C77F4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r6, _020C7860 // =0x0214707C
	mov r7, r0
	mov r8, #0
	add r5, r4, #0x74
	mov r4, #0x20
_020C7814:
	ldrb r0, [r6, #0x5a]
	cmp r0, #0
	beq _020C7840
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl memcmp
	cmp r0, #0
	moveq r0, #0
	streqb r0, [r6, #0x5a]
	beq _020C7850
_020C7840:
	add r8, r8, #1
	cmp r8, #4
	add r6, r6, #0x5c
	blt _020C7814
_020C7850:
	mov r0, r7
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C7860: .word 0x0214707C
	arm_func_end sub_20C77F4

	arm_func_start sub_20C7864
sub_20C7864: // 0x020C7864
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, r1
	mov r7, r2
	bl OS_DisableInterrupts
	mov r5, r0
	bl OS_GetTick
	ldr r6, _020C7960 // =0x0214707C
	mov r4, r0, lsr #0x10
	mov r3, #0
	mov ip, r3
	mov r2, r6
	orr r4, r4, r1, lsl #16
	mvn r0, #0
_020C78A0:
	ldrb r1, [r2, #0x5a]
	cmp r1, #0
	beq _020C78D8
	cmp r8, #0
	beq _020C78D8
	ldr lr, [r2, #0x54]
	cmp r8, lr
	bne _020C78D8
	cmp r7, #0
	beq _020C78D8
	ldrh lr, [r2, #0x58]
	cmp r7, lr
	moveq r6, r2
	beq _020C7918
_020C78D8:
	mvn lr, #0
	cmp r3, lr
	beq _020C7908
	cmp r1, #0
	moveq r3, r0
	moveq r6, r2
	beq _020C7908
	ldr r1, [r2, #0x50]
	sub r1, r4, r1
	cmp r1, r3
	movhi r3, r1
	movhi r6, r2
_020C7908:
	add ip, ip, #1
	cmp ip, #4
	add r2, r2, #0x5c
	blt _020C78A0
_020C7918:
	mov r1, r6
	add r0, r9, #0x74
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r0, r9
	add r1, r6, #0x20
	mov r2, #0x30
	bl MI_CpuCopy8
	str r4, [r6, #0x50]
	mov r0, #1
	strb r0, [r6, #0x5a]
	str r8, [r6, #0x54]
	mov r0, r5
	strh r7, [r6, #0x58]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020C7960: .word 0x0214707C
	arm_func_end sub_20C7864

	arm_func_start sub_20C7964
sub_20C7964: // 0x020C7964
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	bl OS_DisableInterrupts
	mov r1, #0
	ldr r4, _020C7A08 // =0x0214707C
	mov r5, r0
	strb r1, [r8, #0x30]
_020C7988:
	ldrb r0, [r4, #0x5a]
	cmp r0, #0
	beq _020C79E8
	ldr r0, [r4, #0x54]
	cmp r0, r7
	bne _020C79E8
	ldrh r0, [r4, #0x58]
	cmp r0, r6
	bne _020C79E8
	mov r0, r4
	add r1, r8, #0x74
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r1, r8
	add r0, r4, #0x20
	mov r2, #0x30
	bl MI_CpuCopy8
	bl OS_GetTick
	mov r0, r0, lsr #0x10
	orr r0, r0, r1, lsl #16
	str r0, [r4, #0x50]
	mov r0, #1
	strb r0, [r8, #0x30]
	b _020C79F8
_020C79E8:
	add r1, r1, #1
	cmp r1, #4
	add r4, r4, #0x5c
	blt _020C7988
_020C79F8:
	mov r0, r5
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020C7A08: .word 0x0214707C
	arm_func_end sub_20C7964

	arm_func_start sub_20C7A0C
sub_20C7A0C: // 0x020C7A0C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r7, r0
	bl OS_DisableInterrupts
	mov r6, #0
	ldr r4, _020C7AB0 // =0x0214707C
	mov r5, r0
	strb r6, [r7, #0x30]
	add r9, r7, #0x74
	mov r8, #0x20
_020C7A34:
	ldrb r0, [r4, #0x5a]
	cmp r0, #0
	beq _020C7A8C
	ldr r0, [r4, #0x54]
	cmp r0, #0
	bne _020C7A8C
	ldrh r0, [r4, #0x58]
	cmp r0, #0
	bne _020C7A8C
	mov r0, r4
	mov r1, r9
	mov r2, r8
	bl memcmp
	cmp r0, #0
	bne _020C7A8C
	mov r1, r7
	add r0, r4, #0x20
	mov r2, #0x30
	bl MI_CpuCopy8
	mov r0, #1
	strb r0, [r7, #0x30]
	b _020C7A9C
_020C7A8C:
	add r6, r6, #1
	cmp r6, #4
	add r4, r4, #0x5c
	blt _020C7A34
_020C7A9C:
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_020C7AB0: .word 0x0214707C
	arm_func_end sub_20C7A0C

	arm_func_start sub_20C7AB4
sub_20C7AB4: // 0x020C7AB4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r0, r4
	add r1, r5, #0x10
	mov r2, #8
	bl sub_20C80A0
	ldr r0, [r5, #0x10]
	ldr r1, _020C7B24 // =_0211F290
	mov r0, r0, lsr #3
	and r0, r0, #0x3f
	cmp r0, #0x38
	rsblt r2, r0, #0x38
	rsbge r2, r0, #0x78
	mov r0, r5
	bl sub_20C7B28
	mov r0, r5
	mov r1, r4
	mov r2, #8
	bl sub_20C7B28
	mov r0, r4
	mov r1, r5
	mov r2, #0x10
	bl sub_20C80A0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C7B24: .word _0211F290
	arm_func_end sub_20C7AB4

	arm_func_start sub_20C7B28
sub_20C7B28: // 0x020C7B28
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldr r3, [r8, #0x10]
	mov r6, r2
	add r0, r3, r6, lsl #3
	str r0, [r8, #0x10]
	ldr r0, [r8, #0x10]
	mov r2, r3, lsr #3
	cmp r0, r6, lsl #3
	ldrlo r0, [r8, #0x14]
	and r4, r2, #0x3f
	addlo r0, r0, #1
	strlo r0, [r8, #0x14]
	ldr r0, [r8, #0x14]
	rsb r5, r4, #0x40
	add r0, r0, r6, lsr #29
	mov r7, r1
	str r0, [r8, #0x14]
	cmp r6, r5
	blo _020C7BC8
	add r1, r8, #0x18
	mov r0, r7
	mov r2, r5
	add r1, r1, r4
	bl MI_CpuCopy8
	mov r0, r8
	add r1, r8, #0x18
	mov r4, #0
	bl sub_20C7C34
	add r0, r5, #0x3f
	cmp r0, r6
	bhs _020C7BCC
_020C7BA8:
	mov r0, r8
	add r1, r7, r5
	bl sub_20C7C34
	add r5, r5, #0x40
	add r0, r5, #0x3f
	cmp r0, r6
	blo _020C7BA8
	b _020C7BCC
_020C7BC8:
	mov r5, #0
_020C7BCC:
	add r1, r8, #0x18
	add r0, r7, r5
	add r1, r1, r4
	sub r2, r6, r5
	bl MI_CpuCopy8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C7B28

	arm_func_start sub_20C7BE8
sub_20C7BE8: // 0x020C7BE8
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r2, #0x58
	mov r4, r0
	bl MI_CpuFill8
	ldr r1, _020C7C24 // =0x67452301
	ldr r0, _020C7C28 // =0xEFCDAB89
	str r1, [r4]
	ldr r1, _020C7C2C // =0x98BADCFE
	str r0, [r4, #4]
	ldr r0, _020C7C30 // =0x10325476
	str r1, [r4, #8]
	str r0, [r4, #0xc]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C7C24: .word 0x67452301
_020C7C28: .word 0xEFCDAB89
_020C7C2C: .word 0x98BADCFE
_020C7C30: .word 0x10325476
	arm_func_end sub_20C7BE8

	arm_func_start sub_20C7C34
sub_20C7C34: // 0x020C7C34
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x44
	str r0, [sp]
	ldr r3, [sp]
	add r0, sp, #4
	mov r2, #0x40
	ldr r7, [r3]
	ldr r6, [r3, #4]
	ldr r5, [r3, #8]
	ldr r4, [r3, #0xc]
	bl sub_20C8088
	ldr r2, _020C8080 // =byte_211F250
	mov r3, #0
	ldr r1, _020C8084 // =_0211F2D0
	mov r11, r3
	add r0, sp, #4
	mov r10, r2
_020C7C78:
	ldrb r9, [r2]
	add r8, r3, #1
	eor ip, r5, r4
	and ip, r6, ip
	eor ip, r4, ip
	ldr r9, [r0, r9, lsl #2]
	ldr lr, [r1, r3, lsl #2]
	add r9, ip, r9
	add r9, lr, r9
	add r9, r7, r9
	mov r7, r9, lsl #7
	orr r7, r7, r9, lsr #25
	ldrb r9, [r10, r8]
	add r7, r6, r7
	ldr r8, [r1, r8, lsl #2]
	ldr r9, [r0, r9, lsl #2]
	eor ip, r6, r5
	and ip, r7, ip
	eor ip, r5, ip
	add r9, ip, r9
	add r9, r8, r9
	add r8, r3, #2
	add r9, r4, r9
	mov r4, r9, lsl #0xc
	orr r4, r4, r9, lsr #20
	add r4, r7, r4
	ldr r9, [r1, r8, lsl #2]
	ldrb ip, [r10, r8]
	eor r8, r7, r6
	and r8, r4, r8
	eor r8, r6, r8
	ldr lr, [r0, ip, lsl #2]
	add ip, r3, #3
	add r8, r8, lr
	add r8, r9, r8
	add r8, r5, r8
	mov r5, r8, lsl #0x11
	orr r5, r5, r8, lsr #15
	add r5, r4, r5
	ldr r9, [r1, ip, lsl #2]
	ldrb ip, [r10, ip]
	eor r8, r4, r7
	and r8, r5, r8
	eor r8, r7, r8
	ldr ip, [r0, ip, lsl #2]
	add r2, r2, #4
	add r8, r8, ip
	add r8, r9, r8
	add r8, r6, r8
	mov r6, r8, lsl #0x16
	orr r6, r6, r8, lsr #10
	add r6, r5, r6
	add r3, r3, #4
	add r11, r11, #1
	cmp r11, #4
	blt _020C7C78
	add r8, r10, r3
	mov r2, #0
	ldr r1, _020C8084 // =_0211F2D0
	add r0, sp, #4
	ldr lr, _020C8080 // =byte_211F250
_020C7D6C:
	ldrb r10, [r8]
	add r9, r3, #1
	eor r11, r6, r5
	and r11, r4, r11
	eor r11, r5, r11
	ldr r10, [r0, r10, lsl #2]
	ldr ip, [r1, r3, lsl #2]
	add r10, r11, r10
	add r10, ip, r10
	add r10, r7, r10
	mov r7, r10, lsl #5
	orr r7, r7, r10, lsr #27
	ldrb r10, [lr, r9]
	add r7, r6, r7
	ldr r9, [r1, r9, lsl #2]
	ldr r10, [r0, r10, lsl #2]
	eor r11, r7, r6
	and r11, r5, r11
	eor r11, r6, r11
	add r10, r11, r10
	add r10, r9, r10
	add r9, r3, #2
	add r10, r4, r10
	mov r4, r10, lsl #9
	orr r4, r4, r10, lsr #23
	add r4, r7, r4
	ldr ip, [r1, r9, lsl #2]
	ldrb r9, [lr, r9]
	eor r10, r4, r7
	and r10, r6, r10
	eor r11, r7, r10
	ldr r10, [r0, r9, lsl #2]
	add r9, r3, #3
	add r10, r11, r10
	add r10, ip, r10
	add r10, r5, r10
	mov r5, r10, lsl #0xe
	orr r5, r5, r10, lsr #18
	add r5, r4, r5
	ldr r10, [r1, r9, lsl #2]
	ldrb r11, [lr, r9]
	eor r9, r5, r4
	and r9, r7, r9
	eor r9, r4, r9
	ldr r11, [r0, r11, lsl #2]
	add r8, r8, #4
	add r9, r9, r11
	add r9, r10, r9
	add r9, r6, r9
	mov r6, r9, lsl #0x14
	orr r6, r6, r9, lsr #12
	add r6, r5, r6
	add r3, r3, #4
	add r2, r2, #1
	cmp r2, #4
	blt _020C7D6C
	add r8, lr, r3
	mov lr, #0
	ldr r2, _020C8084 // =_0211F2D0
	add r0, sp, #4
_020C7E5C:
	ldrb r1, [r8]
	eor ip, r6, r5
	add lr, lr, #1
	ldr r11, [r0, r1, lsl #2]
	eor ip, r4, ip
	ldr r1, [r2, r3, lsl #2]
	add r11, ip, r11
	add r1, r1, r11
	add r7, r7, r1
	mov r1, r7, lsl #4
	orr r1, r1, r7, lsr #28
	add r7, r6, r1
	add r10, r3, #1
	ldr r1, _020C8080 // =byte_211F250
	ldr ip, [r2, r10, lsl #2]
	ldrb r1, [r1, r10]
	eor r10, r7, r6
	eor r11, r5, r10
	ldr r10, [r0, r1, lsl #2]
	add r9, r3, #2
	add r10, r11, r10
	add r10, ip, r10
	add r4, r4, r10
	ldr r10, _020C8080 // =byte_211F250
	ldr r1, [r2, r9, lsl #2]
	ldrb r9, [r10, r9]
	mov r10, r4, lsl #0xb
	orr r4, r10, r4, lsr #21
	add r4, r7, r4
	eor r10, r4, r7
	ldr r9, [r0, r9, lsl #2]
	eor r10, r6, r10
	add r9, r10, r9
	add r1, r1, r9
	add r5, r5, r1
	add r10, r3, #3
	ldr r9, _020C8080 // =byte_211F250
	mov r1, r5, lsl #0x10
	ldrb r9, [r9, r10]
	orr r1, r1, r5, lsr #16
	add r5, r4, r1
	ldr r1, [r2, r10, lsl #2]
	eor r10, r5, r4
	ldr r9, [r0, r9, lsl #2]
	eor r10, r7, r10
	add r9, r10, r9
	add r1, r1, r9
	add r6, r6, r1
	mov r1, r6, lsl #0x17
	orr r1, r1, r6, lsr #9
	add r8, r8, #4
	add r6, r5, r1
	add r3, r3, #4
	cmp lr, #4
	blt _020C7E5C
	ldr r0, _020C8080 // =byte_211F250
	ldr r1, _020C8084 // =_0211F2D0
	add r8, r0, r3
	ldr lr, _020C8080 // =byte_211F250
	mov r2, #0
	add r0, sp, #4
_020C7F50:
	ldrb r10, [r8]
	add r9, r3, #1
	mvn r11, r4
	orr r11, r6, r11
	eor r11, r5, r11
	ldr r10, [r0, r10, lsl #2]
	ldr ip, [r1, r3, lsl #2]
	add r10, r11, r10
	add r10, ip, r10
	add r10, r7, r10
	mov r7, r10, lsl #6
	orr r7, r7, r10, lsr #26
	ldrb r10, [lr, r9]
	add r7, r6, r7
	ldr r9, [r1, r9, lsl #2]
	ldr r10, [r0, r10, lsl #2]
	mvn r11, r5
	orr r11, r7, r11
	eor r11, r6, r11
	add r10, r11, r10
	add r10, r9, r10
	add r9, r3, #2
	add r10, r4, r10
	mov r4, r10, lsl #0xa
	orr r4, r4, r10, lsr #22
	add r4, r7, r4
	ldr ip, [r1, r9, lsl #2]
	ldrb r9, [lr, r9]
	mvn r10, r6
	orr r10, r4, r10
	eor r11, r7, r10
	ldr r10, [r0, r9, lsl #2]
	add r9, r3, #3
	add r10, r11, r10
	add r10, ip, r10
	add r10, r5, r10
	mov r5, r10, lsl #0xf
	orr r5, r5, r10, lsr #17
	add r5, r4, r5
	ldr r10, [r1, r9, lsl #2]
	ldrb r11, [lr, r9]
	mvn r9, r7
	orr r9, r5, r9
	eor r9, r4, r9
	ldr r11, [r0, r11, lsl #2]
	add r8, r8, #4
	add r9, r9, r11
	add r9, r10, r9
	add r9, r6, r9
	mov r6, r9, lsl #0x15
	orr r6, r6, r9, lsr #11
	add r6, r5, r6
	add r3, r3, #4
	add r2, r2, #1
	cmp r2, #4
	blt _020C7F50
	ldr r0, [sp]
	ldr r0, [r0]
	add r1, r0, r7
	ldr r0, [sp]
	str r1, [r0]
	ldr r0, [r0, #4]
	add r1, r0, r6
	ldr r0, [sp]
	str r1, [r0, #4]
	ldr r0, [r0, #8]
	add r1, r0, r5
	ldr r0, [sp]
	str r1, [r0, #8]
	ldr r0, [r0, #0xc]
	add r1, r0, r4
	ldr r0, [sp]
	str r1, [r0, #0xc]
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C8080: .word byte_211F250
_020C8084: .word _0211F2D0
	arm_func_end sub_20C7C34

	arm_func_start sub_20C8088
sub_20C8088: // 0x020C8088
	ldr ip, _020C809C // =MI_CpuCopy8
	mov r3, r0
	mov r0, r1
	mov r1, r3
	bx ip
	.align 2, 0
_020C809C: .word MI_CpuCopy8
	arm_func_end sub_20C8088

	arm_func_start sub_20C80A0
sub_20C80A0: // 0x020C80A0
	ldr ip, _020C80B4 // =MI_CpuCopy8
	mov r3, r0
	mov r0, r1
	mov r1, r3
	bx ip
	.align 2, 0
_020C80B4: .word MI_CpuCopy8
	arm_func_end sub_20C80A0

	arm_func_start sub_20C80B8
sub_20C80B8: // 0x020C80B8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	ldr r1, _020C80F0 // =0x0211F3D1
	mov r5, r0
	mov r2, #0x2c
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	mov r2, #0x14
	bl sub_20C898C
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C80F0: .word 0x0211F3D1
	arm_func_end sub_20C80B8

	arm_func_start sub_20C80F4
sub_20C80F4: // 0x020C80F4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r0, r4
	add r1, r5, #0x14
	mov r2, #8
	bl sub_20C898C
	ldr r0, [r5, #0x18]
	ldr r1, _020C8164 // =_0211F3D0
	mov r0, r0, lsr #3
	and r0, r0, #0x3f
	cmp r0, #0x38
	rsblt r2, r0, #0x38
	rsbge r2, r0, #0x78
	mov r0, r5
	bl sub_20C8168
	mov r0, r5
	mov r1, r4
	mov r2, #8
	bl sub_20C8168
	mov r0, r4
	mov r1, r5
	mov r2, #0x14
	bl sub_20C898C
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020C8164: .word _0211F3D0
	arm_func_end sub_20C80F4

	arm_func_start sub_20C8168
sub_20C8168: // 0x020C8168
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	ldr r3, [r8, #0x18]
	mov r6, r2
	add r0, r3, r6, lsl #3
	str r0, [r8, #0x18]
	ldr r0, [r8, #0x18]
	mov r2, r3, lsr #3
	cmp r0, r6, lsl #3
	ldrlo r0, [r8, #0x14]
	and r4, r2, #0x3f
	addlo r0, r0, #1
	strlo r0, [r8, #0x14]
	ldr r0, [r8, #0x14]
	rsb r5, r4, #0x40
	add r0, r0, r6, lsr #29
	mov r7, r1
	str r0, [r8, #0x14]
	cmp r6, r5
	blo _020C8208
	add r1, r8, #0x1c
	mov r0, r7
	mov r2, r5
	add r1, r1, r4
	bl MI_CpuCopy8
	mov r0, r8
	add r1, r8, #0x1c
	mov r4, #0
	bl sub_20C8280
	add r0, r5, #0x3f
	cmp r0, r6
	bhs _020C820C
_020C81E8:
	mov r0, r8
	add r1, r7, r5
	bl sub_20C8280
	add r5, r5, #0x40
	add r0, r5, #0x3f
	cmp r0, r6
	blo _020C81E8
	b _020C820C
_020C8208:
	mov r5, #0
_020C820C:
	add r1, r8, #0x1c
	add r0, r7, r5
	add r1, r1, r4
	sub r2, r6, r5
	bl MI_CpuCopy8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C8168

	arm_func_start sub_20C8228
sub_20C8228: // 0x020C8228
	stmdb sp!, {r4, lr}
	mov r1, #0
	mov r2, #0x5c
	mov r4, r0
	bl MI_CpuFill8
	ldr r0, _020C826C // =0x67452301
	ldr r1, _020C8270 // =0xEFCDAB89
	str r0, [r4]
	ldr r0, _020C8274 // =0x98BADCFE
	str r1, [r4, #4]
	ldr r1, _020C8278 // =0x10325476
	str r0, [r4, #8]
	ldr r0, _020C827C // =0xC3D2E1F0
	str r1, [r4, #0xc]
	str r0, [r4, #0x10]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C826C: .word 0x67452301
_020C8270: .word 0xEFCDAB89
_020C8274: .word 0x98BADCFE
_020C8278: .word 0x10325476
_020C827C: .word 0xC3D2E1F0
	arm_func_end sub_20C8228

	arm_func_start sub_20C8280
sub_20C8280: // 0x020C8280
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x54
	str r0, [sp]
	ldr r3, [sp]
	add r0, sp, #0x10
	mov r2, #0x40
	ldr r6, [r3]
	ldr r7, [r3, #4]
	ldr r8, [r3, #8]
	ldr r5, [r3, #0xc]
	ldr r4, [r3, #0x10]
	bl sub_20C8928
	mov r2, #0
	ldr r3, _020C8918 // =0x5A827999
	mov r0, r2
	add r1, sp, #0x10
_020C82C0:
	eor r9, r8, r5
	mov r10, r6, lsl #5
	and r9, r7, r9
	orr r10, r10, r6, lsr #27
	eor r9, r5, r9
	mov r11, r7, lsl #0x1e
	orr r7, r11, r7, lsr #2
	eor r11, r7, r8
	add r9, r10, r9
	ldr ip, [r1, r2, lsl #2]
	and r10, r6, r11
	add r9, ip, r9
	add r9, r9, r3
	add r4, r4, r9
	add r9, r2, #1
	ldr r9, [r1, r9, lsl #2]
	eor r10, r8, r10
	mov r11, r4, lsl #5
	orr r11, r11, r4, lsr #27
	add r10, r11, r10
	add r10, r9, r10
	mov r9, r6, lsl #0x1e
	add r10, r10, r3
	add r5, r5, r10
	orr r6, r9, r6, lsr #2
	add r9, r2, #2
	ldr r10, [r1, r9, lsl #2]
	mov r9, r5, lsl #5
	orr r9, r9, r5, lsr #27
	eor r11, r6, r7
	and r11, r4, r11
	eor r11, r7, r11
	add r9, r9, r11
	add r9, r10, r9
	add r9, r9, r3
	add r8, r8, r9
	mov r9, r4, lsl #0x1e
	orr r4, r9, r4, lsr #2
	add r9, r2, #3
	ldr r10, [r1, r9, lsl #2]
	mov r9, r8, lsl #5
	orr r9, r9, r8, lsr #27
	eor r11, r4, r6
	and r11, r5, r11
	eor r11, r6, r11
	add r9, r9, r11
	add r9, r10, r9
	add r9, r9, r3
	add r7, r7, r9
	mov r9, r5, lsl #0x1e
	orr r5, r9, r5, lsr #2
	add r9, r2, #4
	ldr r10, [r1, r9, lsl #2]
	mov r9, r7, lsl #5
	orr r9, r9, r7, lsr #27
	eor r11, r5, r4
	and r11, r8, r11
	eor r11, r4, r11
	add r9, r9, r11
	add r9, r10, r9
	add r9, r9, r3
	add r6, r6, r9
	mov r9, r8, lsl #0x1e
	orr r8, r9, r8, lsr #2
	add r2, r2, #5
	add r0, r0, #1
	cmp r0, #3
	blt _020C82C0
	eor r0, r8, r5
	mov r2, r6, lsl #5
	and r0, r7, r0
	orr r3, r2, r6, lsr #27
	eor r0, r5, r0
	add r3, r3, r0
	ldr r9, [sp, #0x4c]
	ldr r0, _020C8918 // =0x5A827999
	add r3, r9, r3
	add r3, r3, r0
	mov r2, r7, lsl #0x1e
	orr r9, r2, r7, lsr #2
	mov r0, #0
	add r4, r4, r3
	bl sub_20C89E4
	eor r1, r9, r8
	mov r3, r4, lsl #5
	and r1, r6, r1
	mov r2, r6, lsl #0x1e
	orr r3, r3, r4, lsr #27
	eor r1, r8, r1
	add r1, r3, r1
	add r3, r1, r0
	ldr r0, _020C8918 // =0x5A827999
	add r1, sp, #0x10
	add r3, r3, r0
	orr r10, r2, r6, lsr #2
	mov r0, #1
	add r5, r5, r3
	bl sub_20C89E4
	eor r1, r10, r9
	mov r2, r5, lsl #5
	and r1, r4, r1
	orr r2, r2, r5, lsr #27
	eor r1, r9, r1
	add r1, r2, r1
	add r2, r1, r0
	ldr r0, _020C8918 // =0x5A827999
	mov r1, r4, lsl #0x1e
	add r0, r2, r0
	orr r6, r1, r4, lsr #2
	add r8, r8, r0
	add r1, sp, #0x10
	mov r0, #2
	bl sub_20C89E4
	mov r1, r8, lsl #5
	orr r2, r1, r8, lsr #27
	eor r1, r6, r10
	and r1, r5, r1
	eor r1, r10, r1
	add r1, r2, r1
	add r2, r1, r0
	ldr r0, _020C8918 // =0x5A827999
	mov r1, r5, lsl #0x1e
	add r0, r2, r0
	orr r7, r1, r5, lsr #2
	add r9, r9, r0
	mov r0, #3
	add r1, sp, #0x10
	bl sub_20C89E4
	mov r1, r9, lsl #5
	orr r2, r1, r9, lsr #27
	eor r1, r7, r6
	and r1, r8, r1
	eor r1, r6, r1
	add r1, r2, r1
	add r2, r1, r0
	ldr r0, _020C8918 // =0x5A827999
	mov r1, r8, lsl #0x1e
	add r0, r2, r0
	add r10, r10, r0
	mov r0, #0
	ldr r4, _020C891C // =0x6ED9EBA1
	orr r8, r1, r8, lsr #2
	mov r5, #4
	str r0, [sp, #0xc]
	add r11, sp, #0x10
_020C8504:
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	mov r2, r10, lsl #5
	eor r1, r9, r8
	orr r2, r2, r10, lsr #27
	eor r1, r7, r1
	add r1, r2, r1
	add r0, r1, r0
	add r1, r0, r4
	mov r0, r9, lsl #0x1e
	add r6, r6, r1
	orr r9, r0, r9, lsr #2
	add r0, r5, #1
	mov r1, r11
	bl sub_20C89E4
	mov r1, r6, lsl #5
	orr r2, r1, r6, lsr #27
	eor r1, r10, r9
	eor r1, r8, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r7, r7, r0
	mov r0, r10, lsl #0x1e
	orr r10, r0, r10, lsr #2
	add r0, r5, #2
	and r5, r0, #0xf
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	mov r1, r7, lsl #5
	orr r2, r1, r7, lsr #27
	eor r1, r6, r10
	eor r1, r9, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r8, r8, r0
	mov r0, r6, lsl #0x1e
	orr r6, r0, r6, lsr #2
	add r0, r5, #1
	mov r1, r11
	bl sub_20C89E4
	mov r1, r8, lsl #5
	orr r2, r1, r8, lsr #27
	eor r1, r7, r6
	eor r1, r10, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r9, r9, r0
	mov r0, r7, lsl #0x1e
	orr r7, r0, r7, lsr #2
	add r0, r5, #2
	mov r1, r11
	bl sub_20C89E4
	mov r1, r9, lsl #5
	orr r2, r1, r9, lsr #27
	eor r1, r8, r7
	eor r1, r6, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r10, r10, r0
	mov r0, r8, lsl #0x1e
	orr r8, r0, r8, lsr #2
	ldr r0, [sp, #0xc]
	add r5, r5, #3
	add r0, r0, #1
	str r0, [sp, #0xc]
	cmp r0, #4
	blt _020C8504
	mov r0, #0
	ldr r4, _020C8920 // =0x8F1BBCDC
	str r0, [sp, #8]
	add r11, sp, #0x10
_020C8638:
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	orr r2, r8, r7
	mov r1, r10, lsl #5
	and r3, r9, r2
	and r2, r8, r7
	orr r1, r1, r10, lsr #27
	orr r2, r3, r2
	add r1, r1, r2
	add r1, r1, r0
	mov r0, r9, lsl #0x1e
	add r1, r1, r4
	add r6, r6, r1
	orr r9, r0, r9, lsr #2
	add r0, r5, #1
	mov r1, r11
	bl sub_20C89E4
	orr r2, r9, r8
	mov r1, r6, lsl #5
	and r3, r10, r2
	and r2, r9, r8
	orr r1, r1, r6, lsr #27
	orr r2, r3, r2
	add r1, r1, r2
	add r0, r1, r0
	add r0, r0, r4
	add r7, r7, r0
	mov r0, r10, lsl #0x1e
	orr r10, r0, r10, lsr #2
	add r0, r5, #2
	mov r1, r11
	bl sub_20C89E4
	orr r2, r10, r9
	mov r1, r7, lsl #5
	and r3, r6, r2
	and r2, r10, r9
	orr r1, r1, r7, lsr #27
	orr r2, r3, r2
	add r1, r1, r2
	add r0, r1, r0
	add r0, r0, r4
	add r8, r8, r0
	mov r0, r6, lsl #0x1e
	orr r6, r0, r6, lsr #2
	add r0, r5, #3
	and r5, r0, #0xf
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	orr r2, r6, r10
	mov r1, r8, lsl #5
	and r3, r7, r2
	and r2, r6, r10
	orr r1, r1, r8, lsr #27
	orr r2, r3, r2
	add r1, r1, r2
	add r0, r1, r0
	add r0, r0, r4
	add r9, r9, r0
	mov r0, r7, lsl #0x1e
	orr r7, r0, r7, lsr #2
	add r0, r5, #1
	mov r1, r11
	bl sub_20C89E4
	orr r2, r7, r6
	mov r1, r9, lsl #5
	and r3, r8, r2
	and r2, r7, r6
	orr r1, r1, r9, lsr #27
	orr r2, r3, r2
	add r1, r1, r2
	add r0, r1, r0
	add r0, r0, r4
	add r10, r10, r0
	mov r0, r8, lsl #0x1e
	orr r8, r0, r8, lsr #2
	ldr r0, [sp, #8]
	add r5, r5, #2
	add r0, r0, #1
	str r0, [sp, #8]
	cmp r0, #4
	blt _020C8638
	mov r0, #0
	ldr r4, _020C8924 // =0xCA62C1D6
	str r0, [sp, #4]
	add r11, sp, #0x10
_020C8794:
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	mov r2, r10, lsl #5
	eor r1, r9, r8
	orr r2, r2, r10, lsr #27
	eor r1, r7, r1
	add r1, r2, r1
	add r0, r1, r0
	add r1, r0, r4
	mov r0, r9, lsl #0x1e
	add r6, r6, r1
	orr r9, r0, r9, lsr #2
	add r0, r5, #1
	mov r1, r11
	bl sub_20C89E4
	mov r1, r6, lsl #5
	orr r2, r1, r6, lsr #27
	eor r1, r10, r9
	eor r1, r8, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r7, r7, r0
	mov r0, r10, lsl #0x1e
	orr r10, r0, r10, lsr #2
	add r0, r5, #2
	mov r1, r11
	bl sub_20C89E4
	mov r1, r7, lsl #5
	orr r2, r1, r7, lsr #27
	eor r1, r6, r10
	eor r1, r9, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r8, r8, r0
	mov r0, r6, lsl #0x1e
	orr r6, r0, r6, lsr #2
	add r0, r5, #3
	mov r1, r11
	bl sub_20C89E4
	mov r1, r8, lsl #5
	orr r2, r1, r8, lsr #27
	eor r1, r7, r6
	eor r1, r10, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r9, r9, r0
	mov r0, r7, lsl #0x1e
	orr r7, r0, r7, lsr #2
	add r0, r5, #4
	and r5, r0, #0xf
	mov r0, r5
	mov r1, r11
	bl sub_20C89E4
	mov r1, r9, lsl #5
	orr r2, r1, r9, lsr #27
	eor r1, r8, r7
	eor r1, r6, r1
	add r1, r2, r1
	add r0, r1, r0
	add r0, r0, r4
	add r10, r10, r0
	mov r0, r8, lsl #0x1e
	orr r8, r0, r8, lsr #2
	ldr r0, [sp, #4]
	add r5, r5, #1
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #4
	blt _020C8794
	ldr r0, [sp]
	ldr r0, [r0]
	add r1, r0, r10
	ldr r0, [sp]
	str r1, [r0]
	ldr r0, [r0, #4]
	add r1, r0, r9
	ldr r0, [sp]
	str r1, [r0, #4]
	ldr r0, [r0, #8]
	add r1, r0, r8
	ldr r0, [sp]
	str r1, [r0, #8]
	ldr r0, [r0, #0xc]
	add r1, r0, r7
	ldr r0, [sp]
	str r1, [r0, #0xc]
	ldr r0, [r0, #0x10]
	add r1, r0, r6
	ldr r0, [sp]
	str r1, [r0, #0x10]
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C8918: .word 0x5A827999
_020C891C: .word 0x6ED9EBA1
_020C8920: .word 0x8F1BBCDC
_020C8924: .word 0xCA62C1D6
	arm_func_end sub_20C8280

	arm_func_start sub_20C8928
sub_20C8928: // 0x020C8928
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	cmp r2, #0
	addls sp, sp, #4
	mov r3, #0
	ldmlsia sp!, {r4, r5, lr}
	bxls lr
_020C8944:
	add ip, r3, #1
	ldrb lr, [r1, r3]
	add r4, r3, #2
	add r5, r3, #3
	ldrb ip, [r1, ip]
	mov lr, lr, lsl #0x18
	add r3, r3, #4
	ldrb r4, [r1, r4]
	orr ip, lr, ip, lsl #16
	ldrb lr, [r1, r5]
	orr r4, ip, r4, lsl #8
	cmp r3, r2
	orr r4, lr, r4
	str r4, [r0], #4
	blo _020C8944
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20C8928

	arm_func_start sub_20C898C
sub_20C898C: // 0x020C898C
	stmdb sp!, {lr}
	sub sp, sp, #4
	movs ip, r2, lsr #2
	mov lr, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
_020C89A8:
	ldr r3, [r1], #4
	add lr, lr, #1
	mov r2, r3, lsr #0x18
	strb r2, [r0]
	mov r2, r3, lsr #0x10
	strb r2, [r0, #1]
	mov r2, r3, lsr #8
	strb r2, [r0, #2]
	strb r3, [r0, #3]
	cmp lr, ip
	add r0, r0, #4
	blo _020C89A8
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C898C

	arm_func_start sub_20C89E4
sub_20C89E4: // 0x020C89E4
	add r2, r0, #0xd
	add ip, r0, #2
	and r3, r2, #0xf
	eor r2, r0, #8
	and ip, ip, #0xf
	ldr r3, [r1, r3, lsl #2]
	ldr r2, [r1, r2, lsl #2]
	ldr ip, [r1, ip, lsl #2]
	eor r2, r3, r2
	ldr r3, [r1, r0, lsl #2]
	eor r2, ip, r2
	eor r3, r3, r2
	mov r2, r3, lsl #1
	orr r2, r2, r3, lsr #31
	str r2, [r1, r0, lsl #2]
	ldr r0, [r1, r0, lsl #2]
	bx lr
	arm_func_end sub_20C89E4

	arm_func_start sub_20C8A28
sub_20C8A28: // 0x020C8A28
	stmdb sp!, {r4, r5, r6, lr}
	cmp r2, #0
	add r3, r0, #2
	ldrb lr, [r0]
	ldrb ip, [r0, #1]
	mov r4, #0
	ble _020C8A88
_020C8A44:
	add r5, lr, #1
	and lr, r5, #0xff
	ldrb r6, [r3, lr]
	add r5, ip, r6
	and ip, r5, #0xff
	ldrb r5, [r3, ip]
	strb r5, [r3, lr]
	add r5, r6, r5
	strb r6, [r3, ip]
	and r5, r5, #0xff
	ldrb r6, [r1, r4]
	ldrb r5, [r3, r5]
	eor r5, r6, r5
	strb r5, [r1, r4]
	add r4, r4, #1
	cmp r4, r2
	blt _020C8A44
_020C8A88:
	strb lr, [r0]
	strb ip, [r0, #1]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C8A28

	arm_func_start sub_20C8A98
sub_20C8A98: // 0x020C8A98
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r3, #0
	strb r3, [r0]
	strb r3, [r0, #1]
	add r7, r0, #2
_020C8AB0:
	strb r3, [r7, r3]
	add r3, r3, #1
	cmp r3, #0x100
	blt _020C8AB0
	mov r5, #0
	mov r6, r5
	mov r4, r5
	mov r0, r5
_020C8AD0:
	ldrb lr, [r7, r4]
	ldrb ip, [r1, r5]
	add r3, r5, #1
	and r5, r3, #0xff
	add r3, lr, ip
	add r3, r6, r3
	and r6, r3, #0xff
	ldrb r3, [r7, r6]
	cmp r5, r2
	movge r5, r0
	strb r3, [r7, r4]
	add r4, r4, #1
	strb lr, [r7, r6]
	cmp r4, #0x100
	blt _020C8AD0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C8A98

	arm_func_start sub_20C8B18
sub_20C8B18: // 0x020C8B18
	ldrh r1, [r0]
	mov r0, #0
	bx lr
	arm_func_end sub_20C8B18

	arm_func_start sub_20C8B24
sub_20C8B24: // 0x020C8B24
	ldrh r1, [r0]
	ldrh r0, [r0, #-2]
	mov r0, r0, lsl #0x10
	bx lr
	arm_func_end sub_20C8B24

	arm_func_start sub_20C8B34
sub_20C8B34: // 0x020C8B34
	ldrh r1, [r0]
	ldrh r2, [r0, #-2]
	ldrh r3, [r0, #-4]
	orr r0, r3, r2, lsl #16
	bx lr
	arm_func_end sub_20C8B34

	arm_func_start sub_20C8B48
sub_20C8B48: // 0x020C8B48
	ldrh r2, [r0]
	ldrh r3, [r0, #-2]
	orr r1, r3, r2, lsl #16
	ldrh r2, [r0, #-4]
	ldrh r3, [r0, #-6]
	orr r0, r3, r2, lsl #16
	bx lr
	arm_func_end sub_20C8B48

	arm_func_start sub_20C8B64
sub_20C8B64: // 0x020C8B64
	sub r3, r2, #1
	cmp r2, #1
	add r0, r0, r3
	ble _020C8B9C
_020C8B74:
	ldrh r3, [r1]
	sub r2, r2, #2
	sub ip, r0, #1
	strb r3, [r0]
	ldrh r3, [r1], #2
	cmp r2, #1
	sub r0, r0, #2
	mov r3, r3, asr #8
	strb r3, [ip]
	bgt _020C8B74
_020C8B9C:
	cmp r2, #0
	ldrgth r1, [r1]
	strgtb r1, [r0]
	bx lr
	arm_func_end sub_20C8B64

	arm_func_start sub_20C8BAC
sub_20C8BAC: // 0x020C8BAC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r5, r2
	mov r2, r3, lsl #1
	mov r1, #0
	mov r4, r0
	bl MI_CpuFill8
	sub r0, r5, #1
	cmp r5, #1
	add r6, r6, r0
	ble _020C8BF8
_020C8BD8:
	ldrb r1, [r6]
	ldrb r0, [r6, #-1]
	sub r5, r5, #2
	cmp r5, #1
	add r0, r1, r0, lsl #8
	strh r0, [r4], #2
	sub r6, r6, #2
	bgt _020C8BD8
_020C8BF8:
	cmp r5, #0
	ldrgtb r0, [r6]
	strgth r0, [r4]
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end sub_20C8BAC

	arm_func_start sub_20C8C0C
sub_20C8C0C: // 0x020C8C0C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r10, r3
	mov r3, #0x16
	mul r4, r10, r3
	ldr r3, _020C8E3C // =0x02145840
	mov r11, r0
	ldr r3, [r3]
	mov r0, r4
	ldr r9, [sp, #0x58]
	str r1, [sp, #0x14]
	str r2, [sp, #0x18]
	blx r3
	str r0, [sp, #0x1c]
	cmp r0, #0
	addeq sp, sp, #0x34
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	mov r2, r4
	mov r1, #0
	bl MI_CpuFill8
	ldr r0, [sp, #0x1c]
	mov r1, r10
	add r6, r0, r10, lsl #1
	add r0, r6, r10, lsl #1
	add r5, r0, r10, lsl #1
	add r4, r5, r10, lsl #1
	str r0, [sp, #0x20]
	add r0, r4, r10, lsl #1
	str r0, [sp, #0x24]
	add r7, r0, r10, lsl #1
	mov r0, r9
	bl sub_20C9A7C
	mov r8, r0
	ldr r0, [sp, #0x1c]
	mov r2, #1
	mov r1, r8, lsl #1
	strh r2, [r0, r1]
	ldr r0, [sp, #0x20]
	ldr r1, [sp, #0x1c]
	str r0, [sp]
	mov r0, r6
	mov r2, r9
	mov r3, r10
	bl sub_20C8F88
	ldr r1, [sp, #0x1c]
	mov r0, r5
	mov r2, r6
	mov r3, r10
	bl sub_20C9664
	mov r0, r6
	mov r1, r5
	mov r2, #1
	mov r3, r10
	bl sub_20C97A4
	str r10, [sp]
	mov r0, r6
	mov r1, r6
	mov r2, r9
	mov r3, #0
	str r7, [sp, #4]
	bl sub_20C929C
	ldr r1, [sp, #0x14]
	ldr r0, [sp, #0x20]
	ldr r2, [sp, #0x1c]
	mov r3, r10
	bl sub_20C9664
	ldr r1, [sp, #0x20]
	str r10, [sp]
	mov r0, #0
	mov r2, r9
	mov r3, r1
	str r7, [sp, #4]
	bl sub_20C929C
	str r10, [sp]
	ldr r1, [sp, #0x1c]
	mov r0, #0
	mov r2, r9
	mov r3, r11
	str r7, [sp, #4]
	bl sub_20C929C
	movs r0, r8, lsl #4
	mov r7, #0
	str r0, [sp, #0x28]
	beq _020C8DF8
	mov r0, #1
	str r0, [sp, #0x2c]
	mov r0, #0x8000
	str r0, [sp, #0x30]
_020C8D70:
	str r8, [sp]
	str r9, [sp, #4]
	str r6, [sp, #8]
	str r5, [sp, #0xc]
	ldr r1, [sp, #0x24]
	ldr r2, [sp, #0x2c]
	mov r0, r11
	mov r3, r10
	str r4, [sp, #0x10]
	bl sub_20C8E44
	ldr r0, [sp, #0x30]
	and r1, r7, #0xf
	mov r0, r0, lsr r1
	sub r1, r8, r7, asr #4
	sub r1, r1, #1
	mov r2, r1, lsl #1
	ldr r1, [sp, #0x18]
	ldrh r1, [r1, r2]
	ands r0, r0, r1
	beq _020C8DE8
	str r8, [sp]
	str r9, [sp, #4]
	str r6, [sp, #8]
	str r5, [sp, #0xc]
	ldr r1, [sp, #0x24]
	ldr r2, [sp, #0x20]
	mov r0, r11
	mov r3, r10
	str r4, [sp, #0x10]
	bl sub_20C8E44
_020C8DE8:
	ldr r0, [sp, #0x28]
	add r7, r7, #1
	cmp r7, r0
	blo _020C8D70
_020C8DF8:
	str r8, [sp]
	str r9, [sp, #4]
	str r6, [sp, #8]
	str r5, [sp, #0xc]
	ldr r1, [sp, #0x24]
	mov r0, r11
	mov r3, r10
	mov r2, #0
	str r4, [sp, #0x10]
	bl sub_20C8E44
	ldr r1, _020C8E40 // =0x0214586C
	ldr r0, [sp, #0x1c]
	ldr r1, [r1]
	blx r1
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C8E3C: .word 0x02145840
_020C8E40: .word 0x0214586C
	arm_func_end sub_20C8C0C

	arm_func_start sub_20C8E44
sub_20C8E44: // 0x020C8E44
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r5, r3
	mov r7, r5, lsl #1
	mov r8, r2
	mov r2, r7
	mov r6, r0
	mov r9, r1
	ldr r4, [sp, #0x20]
	bl MI_CpuCopy8
	cmp r8, #1
	bne _020C8E88
	mov r0, r6
	mov r1, r9
	mov r2, r5
	bl sub_20C9494
	b _020C8EA4
_020C8E88:
	cmp r8, #0
	beq _020C8EA4
	mov r0, r6
	mov r1, r9
	mov r2, r8
	mov r3, r5
	bl sub_20C9664
_020C8EA4:
	ldr r0, [sp, #0x2c]
	ldr r2, [sp, #0x28]
	mov r1, r6
	mov r3, r4
	bl sub_20C9664
	sub r1, r5, r4
	ldr r0, [sp, #0x2c]
	mov r8, r1, lsl #1
	mov r2, r8
	add r0, r0, r4, lsl #1
	mov r1, #0
	bl MI_CpuFill8
	ldr r0, [sp, #0x30]
	ldr r1, [sp, #0x2c]
	ldr r2, [sp, #0x24]
	mov r3, r5
	bl sub_20C9664
	mov r0, r6
	mov r1, r6
	ldr r2, [sp, #0x30]
	mov r3, r5
	bl sub_20C998C
	mov r2, r8
	mov r0, r6
	add r1, r6, r4, lsl #1
	bl memmove
	add r0, r6, r5, lsl #1
	sub r0, r0, r4, lsl #1
	mov r2, r4, lsl #1
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r6
	ldr r1, [sp, #0x24]
	mov r2, r5
	bl sub_20C9768
	cmp r0, #0
	beq _020C8F4C
	cmp r0, #1
	beq _020C8F68
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020C8F4C:
	mov r0, r6
	mov r2, r7
	mov r1, #0
	bl MI_CpuFill8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020C8F68:
	ldr r2, [sp, #0x24]
	mov r0, r6
	mov r1, r6
	mov r3, r5
	bl sub_20C9818
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end sub_20C8E44

	arm_func_start sub_20C8F88
sub_20C8F88: // 0x020C8F88
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	ldr r9, [sp, #0x38]
	mov r10, r3
	add r11, r9, r10, lsl #1
	add r8, r11, r10, lsl #1
	add r7, r8, r10, lsl #1
	add r6, r7, r10, lsl #1
	add r5, r6, r10, lsl #1
	str r0, [sp, #8]
	mov r0, r1
	add r1, r5, r10, lsl #1
	str r1, [sp, #0x10]
	mov r4, r10, lsl #1
	str r2, [sp, #0xc]
	mov r1, r9
	mov r2, r4
	bl MI_CpuCopy8
	ldr r0, [sp, #0xc]
	mov r1, r8
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, #1
	strh r0, [r8, r4]
	mov r0, r9
	mov r1, r10
	bl sub_20C9A38
	cmp r0, #0
	ble _020C9098
_020C8FFC:
	ldr r3, [sp, #0x10]
	str r10, [sp]
	str r3, [sp, #4]
	mov r0, r11
	mov r1, r8
	mov r2, r9
	mov r3, r5
	bl sub_20C929C
	mov r0, r9
	mov r1, r8
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, r5
	mov r1, r9
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, r5
	mov r1, r11
	mov r2, r7
	mov r3, r10
	bl sub_20C9664
	mov r0, r5
	mov r1, r6
	mov r2, r5
	mov r3, r10
	bl sub_20C9818
	mov r0, r7
	mov r1, r6
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl MI_CpuCopy8
	mov r0, r9
	mov r1, r10
	bl sub_20C9A38
	cmp r0, #0
	bgt _020C8FFC
_020C9098:
	ldr r2, [sp, #0xc]
	mov r0, r6
	mov r1, r6
	mov r3, r10
	bl sub_20C998C
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #8]
	ldr r4, [sp, #0x10]
	str r10, [sp]
	mov r1, r6
	mov r0, #0
	str r4, [sp, #4]
	bl sub_20C929C
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end sub_20C8F88

	arm_func_start sub_20C90D8
sub_20C90D8: // 0x020C90D8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	ldr r4, _020C9294 // =0x02145840
	mov r8, r3
	ldr r3, [r4]
	mov r10, r0
	mov r0, r8, lsl #3
	ldr r7, [sp, #0x40]
	str r1, [sp, #8]
	mov r9, r2
	blx r3
	movs r6, r0
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	sub r1, r8, #1
	add r0, r10, #2
	mov r2, r1, lsl #1
	mov r1, #0
	add r11, r6, r8, lsl #1
	bl MI_CpuFill8
	mov r2, #1
	mov r0, r9
	mov r1, r8
	strh r2, [r10]
	bl sub_20C9A7C
	sub r0, r8, r0
	mov r5, r0, lsl #4
	mov r4, r8, lsl #4
	cmp r5, r4
	bhs _020C919C
	mov r0, #0x8000
_020C9158:
	sub r1, r8, r5, asr #4
	sub r1, r1, #1
	mov r1, r1, lsl #1
	and r2, r5, #0xf
	ldrh r1, [r9, r1]
	mov r2, r0, lsr r2
	ands r1, r2, r1
	beq _020C9190
	ldr r0, [sp, #8]
	mov r1, r10
	mov r2, r8, lsl #1
	bl MI_CpuCopy8
	add r5, r5, #1
	b _020C919C
_020C9190:
	add r5, r5, #1
	cmp r5, r4
	blo _020C9158
_020C919C:
	cmp r5, r4
	bhs _020C9278
	mov r0, r8, lsl #1
	str r0, [sp, #0xc]
	mov r0, #0
	str r0, [sp, #0x10]
	mov r0, #0x8000
	str r0, [sp, #0x14]
_020C91BC:
	mov r0, r6
	mov r1, r10
	mov r2, r8
	bl sub_20C9494
	ldr r2, [sp, #0xc]
	mov r0, r6
	mov r1, r10
	bl MI_CpuCopy8
	cmp r7, #0
	beq _020C9200
	ldr r0, [sp, #0x10]
	str r8, [sp]
	mov r1, r10
	mov r2, r7
	mov r3, r10
	str r11, [sp, #4]
	bl sub_20C929C
_020C9200:
	sub r0, r8, r5, asr #4
	sub r0, r0, #1
	mov r1, r0, lsl #1
	ldr r0, [sp, #0x14]
	and r2, r5, #0xf
	mov r2, r0, lsr r2
	ldrh r0, [r9, r1]
	ands r0, r2, r0
	beq _020C926C
	ldr r2, [sp, #8]
	mov r0, r6
	mov r1, r10
	mov r3, r8
	bl sub_20C9664
	ldr r2, [sp, #0xc]
	mov r0, r6
	mov r1, r10
	bl MI_CpuCopy8
	cmp r7, #0
	beq _020C926C
	ldr r0, [sp, #0x10]
	str r8, [sp]
	mov r1, r10
	mov r2, r7
	mov r3, r10
	str r11, [sp, #4]
	bl sub_20C929C
_020C926C:
	add r5, r5, #1
	cmp r5, r4
	blo _020C91BC
_020C9278:
	ldr r1, _020C9298 // =0x0214586C
	mov r0, r6
	ldr r1, [r1]
	blx r1
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C9294: .word 0x02145840
_020C9298: .word 0x0214586C
	arm_func_end sub_20C90D8

	arm_func_start sub_20C929C
sub_20C929C: // 0x020C929C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	ldr r9, [sp, #0x48]
	ldr r6, [sp, #0x4c]
	str r1, [sp, #4]
	add r5, r6, r9, lsl #1
	str r0, [sp]
	mov r10, r2
	mov r0, r5
	mov r2, r9, lsl #2
	mov r1, #0
	str r3, [sp, #8]
	add r4, r5, r9, lsl #1
	bl MI_CpuFill8
	ldr r0, [sp, #4]
	mov r1, r9
	bl sub_20C9A7C
	mov r11, r0
	mov r0, r10
	mov r1, r9
	bl sub_20C9A7C
	mov r7, r0
	cmp r11, #0
	ble _020C9444
	cmp r7, #0
	ble _020C9444
	sub r0, r9, r11
	add r0, r7, r0
	sub r8, r0, #1
	cmp r8, r9
	blt _020C932C
	ldr r0, [sp, #4]
	mov r1, r4
	mov r2, r9, lsl #1
	bl MI_CpuCopy8
	b _020C9444
_020C932C:
	ldr r0, [sp, #4]
	add r1, r5, r8, lsl #1
	mov r2, r11, lsl #1
	bl MI_CpuCopy8
	cmp r7, #2
	ble _020C9360
	add r0, r10, r7, lsl #1
	sub r0, r0, #2
	mov r7, r7, lsl #1
	bl sub_20C8B34
	str r0, [sp, #0x14]
	str r1, [sp, #0x10]
	b _020C939C
_020C9360:
	cmp r7, #1
	ble _020C9384
	add r0, r10, r7, lsl #1
	sub r0, r0, #2
	mov r7, r7, lsl #1
	bl sub_20C8B24
	str r0, [sp, #0x14]
	str r1, [sp, #0x10]
	b _020C939C
_020C9384:
	add r0, r10, r7, lsl #1
	sub r0, r0, #2
	mov r7, r7, lsl #1
	bl sub_20C8B18
	str r0, [sp, #0x14]
	str r1, [sp, #0x10]
_020C939C:
	cmp r8, r9
	bge _020C9444
	mov r0, r9, lsl #1
	sub r0, r0, #1
	mov r11, r0, lsl #1
	add r0, r4, r7
	str r0, [sp, #0x1c]
_020C93B8:
	mov r1, r5
	add r0, r5, #2
	mov r2, r11
	bl memmove
	ldr r0, [sp, #0x1c]
	bl sub_20C8B48
	ldr r2, [sp, #0x14]
	ldr r3, [sp, #0x10]
	bl _ll_udiv
	mov r7, r0
	ldr r0, _020C9490 // =0x0000FFFF
	cmp r7, r0
	movhi r7, r0
_020C93EC:
	mov r2, r7, lsl #0x10
	mov r0, r6
	mov r1, r10
	mov r2, r2, lsr #0x10
	mov r3, r9
	bl sub_20C95E0
	mov r0, r4
	mov r1, r6
	mov r2, r9
	bl sub_20C9768
	cmp r0, #0
	sublt r7, r7, #1
	blt _020C93EC
	mov r0, r4
	mov r1, r4
	mov r2, r6
	mov r3, r9
	bl sub_20C9818
	strh r7, [r5]
	add r8, r8, #1
	cmp r8, r9
	blt _020C93B8
_020C9444:
	ldr r0, [sp]
	cmp r0, #0
	beq _020C9460
	ldr r1, [sp]
	mov r0, r5
	mov r2, r9, lsl #1
	bl MI_CpuCopy8
_020C9460:
	ldr r0, [sp, #8]
	cmp r0, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxeq lr
	ldr r1, [sp, #8]
	mov r0, r4
	mov r2, r9, lsl #1
	bl MI_CpuCopy8
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C9490: .word 0x0000FFFF
	arm_func_end sub_20C929C

	arm_func_start sub_20C9494
sub_20C9494: // 0x020C9494
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r1
	mov r8, r2
	mov r10, r0
	mov r0, r9
	mov r1, r8
	bl sub_20C9A7C
	mov r11, r0
	mov r0, r11, lsl #1
	cmp r0, r8
	bge _020C94D8
	sub r1, r8, r0
	add r0, r10, r0, lsl #1
	mov r2, r1, lsl #1
	mov r1, #0
	bl MI_CpuFill8
_020C94D8:
	cmp r11, #0
	mov r1, #0
	ble _020C9530
	mov r0, r1
	sub r4, r8, #1
_020C94EC:
	cmp r0, r8
	bge _020C9530
	mov r2, r1, lsl #1
	ldrh r5, [r9, r2]
	mov r2, r0, lsl #1
	cmp r0, r4
	mul r3, r5, r5
	strh r3, [r10, r2]
	beq _020C9530
	add r2, r0, #1
	add r1, r1, #1
	mov r3, r3, lsr #0x10
	mov r2, r2, lsl #1
	strh r3, [r10, r2]
	cmp r1, r11
	add r0, r0, #2
	blt _020C94EC
_020C9530:
	cmp r11, #0
	mov r6, #0
	addle sp, sp, #4
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxle lr
_020C9544:
	add r7, r6, #1
	b _020C95B0
_020C954C:
	mov r1, r7, lsl #1
	mov r0, r6, lsl #1
	ldrh r1, [r9, r1]
	ldrh r0, [r9, r0]
	mul r4, r1, r0
	ldr r0, _020C95DC // =0x7FFF8000
	cmp r4, r0
	bhi _020C9584
	mov r0, r10
	mov r2, r5
	mov r3, r8
	mov r1, r4, lsl #1
	bl sub_20C9720
	b _020C95AC
_020C9584:
	mov r0, r10
	mov r1, r4
	mov r2, r5
	mov r3, r8
	bl sub_20C9720
	mov r0, r10
	mov r1, r4
	mov r2, r5
	mov r3, r8
	bl sub_20C9720
_020C95AC:
	add r7, r7, #1
_020C95B0:
	cmp r7, r11
	bge _020C95C4
	add r5, r6, r7
	cmp r5, r8
	blt _020C954C
_020C95C4:
	add r6, r6, #1
	cmp r6, r11
	blt _020C9544
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020C95DC: .word 0x7FFF8000
	arm_func_end sub_20C9494

	arm_func_start sub_20C95E0
sub_20C95E0: // 0x020C95E0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r1
	mov r4, r3
	mov r7, r0
	mov r0, r6
	mov r1, r4
	mov r5, r2
	bl sub_20C9A7C
	mov r3, #0
	mov ip, r3
	cmp r0, #0
	ble _020C9634
_020C9614:
	mov r2, ip, lsl #1
	ldrh r1, [r6, r2]
	add ip, ip, #1
	cmp ip, r0
	mla r1, r5, r1, r3
	strh r1, [r7, r2]
	mov r3, r1, lsr #0x10
	blt _020C9614
_020C9634:
	cmp ip, r4
	movlt r0, ip, lsl #1
	addlt ip, ip, #1
	sub r1, r4, ip
	strlth r3, [r7, r0]
	mov r2, r1, lsl #1
	add r0, r7, ip, lsl #1
	mov r1, #0
	bl MI_CpuFill8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20C95E0

	arm_func_start sub_20C9664
sub_20C9664: // 0x020C9664
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r8, r3
	mov r10, r1
	mov r9, r2
	mov r2, r8, lsl #1
	mov r1, #0
	mov r11, r0
	bl MI_CpuFill8
	mov r0, r10
	mov r1, r8
	bl sub_20C9A7C
	mov r5, r0
	mov r0, r9
	mov r1, r8
	bl sub_20C9A7C
	str r0, [sp]
	cmp r0, #0
	mov r7, #0
	addle sp, sp, #0xc
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxle lr
	str r7, [sp, #4]
_020C96C0:
	ldr r6, [sp, #4]
	sub r4, r8, r7
	b _020C96F4
_020C96CC:
	mov r1, r6, lsl #1
	mov r0, r7, lsl #1
	ldrh r2, [r10, r1]
	ldrh r1, [r9, r0]
	mov r0, r11
	mov r3, r8
	mul r1, r2, r1
	add r2, r7, r6
	bl sub_20C9720
	add r6, r6, #1
_020C96F4:
	cmp r6, r5
	bge _020C9704
	cmp r6, r4
	blt _020C96CC
_020C9704:
	ldr r0, [sp]
	add r7, r7, #1
	cmp r7, r0
	blt _020C96C0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	arm_func_end sub_20C9664

	arm_func_start sub_20C9720
sub_20C9720: // 0x020C9720
	stmdb sp!, {lr}
	sub sp, sp, #4
	b _020C9744
_020C972C:
	mov lr, r2, lsl #1
	ldrh ip, [r0, lr]
	add r2, r2, #1
	add r1, r1, ip
	strh r1, [r0, lr]
	mov r1, r1, lsr #0x10
_020C9744:
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	cmp r2, r3
	blt _020C972C
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C9720

	arm_func_start sub_20C9768
sub_20C9768: // 0x020C9768
	subs ip, r2, #1
	bmi _020C979C
_020C9770:
	mov r2, ip, lsl #1
	ldrh r3, [r1, r2]
	ldrh r2, [r0, r2]
	cmp r2, r3
	movhi r0, #1
	bxhi lr
	cmp r2, r3
	mvnlo r0, #0
	bxlo lr
	subs ip, ip, #1
	bpl _020C9770
_020C979C:
	mov r0, #0
	bx lr
	arm_func_end sub_20C9768

	arm_func_start sub_20C97A4
sub_20C97A4: // 0x020C97A4
	stmdb sp!, {r4, lr}
	cmp r3, #0
	mov r4, #0
	ble _020C97DC
_020C97B4:
	mov lr, r4, lsl #1
	ldrh ip, [r1, lr]
	sub ip, ip, r2
	mov r2, ip, lsr #0x10
	strh ip, [r0, lr]
	ands r2, r2, #1
	beq _020C97DC
	add r4, r4, #1
	cmp r4, r3
	blt _020C97B4
_020C97DC:
	cmp r0, r1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r4, r4, #1
	cmp r4, r3
	ldmgeia sp!, {r4, lr}
	bxge lr
_020C97F8:
	mov ip, r4, lsl #1
	ldrh r2, [r1, ip]
	add r4, r4, #1
	cmp r4, r3
	strh r2, [r0, ip]
	blt _020C97F8
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C97A4

	arm_func_start sub_20C9818
sub_20C9818: // 0x020C9818
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r1
	mov r5, r3
	mov r8, r0
	mov r6, r2
	mov r0, r7
	mov r1, r5
	bl sub_20C9A7C
	mov r4, r0
	mov r0, r6
	mov r1, r5
	bl sub_20C9A7C
	cmp r4, r0
	movlt r4, r0
	mov r3, #0
	cmp r4, r5
	addne r4, r4, #1
	mov ip, r3
	b _020C9884
_020C9864:
	mov r2, ip, lsl #1
	ldrh r1, [r7, r2]
	ldrh r0, [r6, r2]
	add ip, ip, #1
	sub r0, r1, r0
	add r0, r3, r0
	strh r0, [r8, r2]
	mov r3, r0, asr #0x10
_020C9884:
	cmp ip, r4
	blt _020C9864
	cmp ip, r5
	bge _020C989C
	cmp r3, #0
	bne _020C9864
_020C989C:
	cmp r8, r7
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r8, r6
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	sub r1, r5, ip
	add r0, r8, ip, lsl #1
	mov r2, r1, lsl #1
	mov r1, #0
	bl MI_CpuFill8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C9818

	arm_func_start sub_20C98D0
sub_20C98D0: // 0x020C98D0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r1
	cmp r3, #0
	mov ip, #0
	ble _020C9904
_020C98E8:
	mov r2, ip, lsl #1
	ldrh r1, [r0, r2]
	add ip, ip, #1
	cmp ip, r3
	mvn r1, r1
	strh r1, [r0, r2]
	blt _020C98E8
_020C9904:
	mov r1, r0
	mov r2, #1
	bl sub_20C991C
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C98D0

	arm_func_start sub_20C991C
sub_20C991C: // 0x020C991C
	stmdb sp!, {r4, lr}
	cmp r3, #0
	mov r4, #0
	ble _020C9950
_020C992C:
	mov lr, r4, lsl #1
	ldrh ip, [r1, lr]
	add r2, r2, ip
	strh r2, [r0, lr]
	movs r2, r2, lsr #0x10
	beq _020C9950
	add r4, r4, #1
	cmp r4, r3
	blt _020C992C
_020C9950:
	cmp r0, r1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r4, r4, #1
	cmp r4, r3
	ldmgeia sp!, {r4, lr}
	bxge lr
_020C996C:
	mov ip, r4, lsl #1
	ldrh r2, [r1, ip]
	add r4, r4, #1
	cmp r4, r3
	strh r2, [r0, ip]
	blt _020C996C
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20C991C

	arm_func_start sub_20C998C
sub_20C998C: // 0x020C998C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r1
	mov r5, r3
	mov r8, r0
	mov r6, r2
	mov r0, r7
	mov r1, r5
	bl sub_20C9A7C
	mov r4, r0
	mov r0, r6
	mov r1, r5
	bl sub_20C9A7C
	cmp r4, r0
	movlt r4, r0
	cmp r4, r5
	addne r4, r4, #1
	mov r3, #0
	mov ip, r3
	cmp r4, #0
	ble _020C9A04
_020C99DC:
	mov r2, ip, lsl #1
	ldrh r1, [r7, r2]
	ldrh r0, [r6, r2]
	add ip, ip, #1
	cmp ip, r4
	add r0, r1, r0
	add r0, r3, r0
	strh r0, [r8, r2]
	mov r3, r0, lsr #0x10
	blt _020C99DC
_020C9A04:
	cmp r8, r7
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r8, r6
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	sub r1, r5, ip
	add r0, r8, ip, lsl #1
	mov r2, r1, lsl #1
	mov r1, #0
	bl MI_CpuFill8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end sub_20C998C

	arm_func_start sub_20C9A38
sub_20C9A38: // 0x020C9A38
	stmdb sp!, {lr}
	sub sp, sp, #4
	sub r2, r1, #1
	mov r2, r2, lsl #1
	ldrh r2, [r0, r2]
	ands r2, r2, #0x8000
	addne sp, sp, #4
	mvnne r0, #0
	ldmneia sp!, {lr}
	bxne lr
	bl sub_20C9A7C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20C9A38

	arm_func_start sub_20C9A7C
sub_20C9A7C: // 0x020C9A7C
	b _020C9A84
_020C9A80:
	sub r1, r1, #1
_020C9A84:
	cmp r1, #0
	beq _020C9AA0
	sub r2, r1, #1
	mov r2, r2, lsl #1
	ldrh r2, [r0, r2]
	cmp r2, #0
	beq _020C9A80
_020C9AA0:
	mov r0, r1
	bx lr
	arm_func_end sub_20C9A7C

	arm_func_start sub_20C9AA8
sub_20C9AA8: // 0x020C9AA8
	mov r1, r0
	mov r0, #0
	mov r3, #1
_020C9AB4:
	clz r2, r1
	rsbs r2, r2, #0x1f
	bxlo lr
	bic r1, r1, r3, lsl r2
	add r0, r0, #1
	b _020C9AB4
	arm_func_end sub_20C9AA8

	arm_func_start sub_20C9ACC
sub_20C9ACC: // 0x020C9ACC
	clz r0, r0
	bx lr
	arm_func_end sub_20C9ACC

	arm_func_start sub_20C9AD4
sub_20C9AD4: // 0x020C9AD4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldrh r0, [r0, #2]
	cmp r0, #0
	bne _020C9DDC
	ldr r2, _020C9E04 // =0x021471EC
	mov r0, #0
	ldr r1, [r2]
	add r1, r1, #0x2000
	strb r0, [r1, #0x26b]
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r0, [r1, #0x82]
	ldr r3, [r2]
	add r1, r3, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #0xd
	addls pc, pc, r1, lsl #2
	b _020C9DA8
_020C9B20: // jump table
	b _020C9DA8 // case 0
	b _020C9DA8 // case 1
	b _020C9DA8 // case 2
	b _020C9DA8 // case 3
	b _020C9DA8 // case 4
	b _020C9B58 // case 5
	b _020C9B58 // case 6
	b _020C9B80 // case 7
	b _020C9BA8 // case 8
	b _020C9CD0 // case 9
	b _020C9D00 // case 10
	b _020C9DA8 // case 11
	b _020C9CD0 // case 12
	b _020C9D30 // case 13
_020C9B58:
	mov r0, #3
	bl sub_20CAC94
	mov r1, #0
	ldr r3, _020C9E08 // =0x000008F5
	mov r2, r1
	mov r0, #1
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9B80:
	mov r0, #3
	bl sub_20CAC94
	mov r0, #0
	ldr r3, _020C9E0C // =0x000008FB
	mov r1, r0
	mov r2, r0
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9BA8:
	add r1, r3, #0x2200
	ldrh r4, [r1, #0xf8]
	strh r0, [r1, #0xf8]
	cmp r4, #0x12
	bne _020C9CA0
	ldr r1, [r2]
	add r1, r1, #0x2100
	ldrh r3, [r1, #0x70]
	and ip, r3, #0x24
	cmp ip, #0x24
	beq _020C9CA0
	orr r3, r3, #0x24
	strh r3, [r1, #0x70]
	ldr r2, [r2]
	add r1, r2, #0x2000
	ldr r3, [r1, #0x264]
	and r1, r3, #0xc0000
	cmp r1, #0xc0000
	moveq r0, #1
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	and r1, r3, #0x30000
	cmp r1, #0x30000
	movne r3, #1
	add r1, r2, #0x2140
	ldr r0, _020C9E10 // =sub_20CA1A0
	moveq r3, #0
	mov r2, #0
	str ip, [sp]
	bl WM_StartConnectEx
	cmp r0, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r4, lr}
	bxeq lr
	cmp r0, #3
	beq _020C9C70
	cmp r0, #8
	bne _020C9C70
	mov r0, #0xc
	bl sub_20CAC94
	ldr r0, _020C9E04 // =0x021471EC
	ldr r3, _020C9E14 // =0x0000091C
	ldr r0, [r0]
	mov r2, r4
	add r1, r0, #0x2140
	mov r0, #1
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9C70:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020C9E04 // =0x021471EC
	ldr r3, _020C9E18 // =0x00000925
	ldr r0, [r0]
	mov r2, r4
	add r1, r0, #0x2140
	mov r0, #7
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9CA0:
	mov r0, #3
	bl sub_20CAC94
	ldr r0, _020C9E04 // =0x021471EC
	ldr r3, _020C9E1C // =0x0000092D
	ldr r0, [r0]
	mov r2, r4
	add r1, r0, #0x2140
	mov r0, #1
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9CD0:
	mov r0, #3
	bl sub_20CAC94
	ldr r0, _020C9E04 // =0x021471EC
	ldr r3, _020C9E20 // =0x00000935
	ldr r1, [r0]
	mov r0, #0
	add r1, r1, #0x2140
	mov r2, #1
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9D00:
	mov r0, #3
	bl sub_20CAC94
	ldr r1, _020C9E04 // =0x021471EC
	mov r0, #0
	ldr r1, [r1]
	ldr r3, _020C9E24 // =0x0000093C
	mov r2, r0
	add r1, r1, #0x2140
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9D30:
	ldr r0, _020C9E28 // =sub_20CA7C4
	bl sub_20F2D48
	cmp r0, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r4, lr}
	bxeq lr
	cmp r0, #3
	beq _020C9D80
	cmp r0, #8
	bne _020C9D80
	mov r0, #0xc
	bl sub_20CAC94
	mov r1, #0
	ldr r3, _020C9E2C // =0x0000094A
	mov r2, r1
	mov r0, #1
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9D80:
	mov r0, #0xb
	bl sub_20CAC94
	mov r1, #0
	ldr r3, _020C9E30 // =0x00000953
	mov r2, r1
	mov r0, #7
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9DA8:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020C9E04 // =0x021471EC
	ldr r3, _020C9E34 // =0x00000959
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2000
	ldr r2, [r1, #0x260]
	mov r1, #0
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
_020C9DDC:
	mov r0, #0xb
	bl sub_20CAC94
	mov r1, #0
	mov r2, r1
	mov r0, #7
	mov r3, #0x960
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020C9E04: .word 0x021471EC
_020C9E08: .word 0x000008F5
_020C9E0C: .word 0x000008FB
_020C9E10: .word sub_20CA1A0
_020C9E14: .word 0x0000091C
_020C9E18: .word 0x00000925
_020C9E1C: .word 0x0000092D
_020C9E20: .word 0x00000935
_020C9E24: .word 0x0000093C
_020C9E28: .word sub_20CA7C4
_020C9E2C: .word 0x0000094A
_020C9E30: .word 0x00000953
_020C9E34: .word 0x00000959
	arm_func_end sub_20C9AD4

	arm_func_start sub_20C9E38
sub_20C9E38: // 0x020C9E38
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020C9F50
_020C9E50: // jump table
	b _020C9E64 // case 0
	b _020C9F38 // case 1
	b _020C9F50 // case 2
	b _020C9F38 // case 3
	b _020C9F50 // case 4
_020C9E64:
	ldr r0, _020C9F80 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #0xc
	bne _020C9E94
	mov r0, #0xa
	bl sub_20CAC94
	bl sub_20CAB84
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C9E94:
	ldr r0, _020C9F84 // =sub_20CA0B4
	mov r1, #0
	bl WM_Disconnect
	cmp r0, #2
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	cmp r0, #3
	beq _020C9EF0
	cmp r0, #8
	bne _020C9F08
	mov r0, #0xc
	bl sub_20CAC94
	ldr r0, _020C9F80 // =0x021471EC
	ldr r3, _020C9F88 // =0x000008B4
	ldr r1, [r0]
	mov r0, #1
	add r1, r1, #0x2140
	mov r2, #0
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C9EF0:
	mov r0, #0xa
	bl sub_20CAC94
	bl sub_20CAB84
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C9F08:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r1, _020C9F80 // =0x021471EC
	mov r0, #7
	ldr r1, [r1]
	mov r2, #0
	add r1, r1, #0x2140
	mov r3, #0x8c0
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C9F38:
	mov r0, #0xa
	bl sub_20CAC94
	bl sub_20CAB84
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020C9F50:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020C9F80 // =0x021471EC
	ldr r3, _020C9F8C // =0x000008D3
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2140
	mov r2, #0
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020C9F80: .word 0x021471EC
_020C9F84: .word sub_20CA0B4
_020C9F88: .word 0x000008B4
_020C9F8C: .word 0x000008D3
	arm_func_end sub_20C9E38

	arm_func_start sub_20C9F90
sub_20C9F90: // 0x020C9F90
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _020C9FAC
	cmp r0, #4
	b _020CA078
_020C9FAC:
	ldrh r0, [r4, #4]
	cmp r0, #0xe
	beq _020C9FC4
	cmp r0, #0xf
	beq _020CA01C
	b _020CA04C
_020C9FC4:
	ldr r0, _020CA0A4 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #0xc
	bne _020C9FF0
	mov r0, #8
	bl sub_20CAC94
	bl sub_20CAB84
	ldmia sp!, {r4, lr}
	bx lr
_020C9FF0:
	mov r0, #9
	bl sub_20CAC94
	ldr r1, _020CA0A4 // =0x021471EC
	mov r0, #0
	ldr r1, [r1]
	ldr r3, _020CA0A8 // =0x00000872
	mov r2, r0
	add r1, r1, #0x2140
	bl sub_20CAD98
	ldmia sp!, {r4, lr}
	bx lr
_020CA01C:
	ldr r0, [r4, #8]
	ldrh r0, [r0, #0xe]
	mov r0, r0, asr #8
	and r0, r0, #0xff
	bl sub_20CCA2C
	ldr r0, [r4, #8]
	mov r1, #0x620
	bl DC_InvalidateRange
	ldr r0, [r4, #8]
	bl sub_20CC990
	ldmia sp!, {r4, lr}
	bx lr
_020CA04C:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020CA0A4 // =0x021471EC
	ldrh r2, [r4, #4]
	ldr r0, [r0]
	ldr r3, _020CA0AC // =0x00000881
	add r1, r0, #0x2140
	mov r0, #7
	bl sub_20CAD98
	ldmia sp!, {r4, lr}
	bx lr
_020CA078:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020CA0A4 // =0x021471EC
	ldr r3, _020CA0B0 // =0x0000088C
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2140
	mov r2, #0
	bl sub_20CAD98
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CA0A4: .word 0x021471EC
_020CA0A8: .word 0x00000872
_020CA0AC: .word 0x00000881
_020CA0B0: .word 0x0000088C
	arm_func_end sub_20C9F90

	arm_func_start sub_20CA0B4
sub_20CA0B4: // 0x020CA0B4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020CA164
_020CA0CC: // jump table
	b _020CA0E0 // case 0
	b _020CA14C // case 1
	b _020CA164 // case 2
	b _020CA14C // case 3
	b _020CA164 // case 4
_020CA0E0:
	ldr r0, _020CA194 // =0x021471EC
	ldr r1, [r0]
	add r0, r1, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #0xc
	bne _020CA110
	mov r0, #0xa
	bl sub_20CAC94
	bl sub_20CAB84
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA110:
	add r1, r1, #0x2200
	mov r2, #0
	mov r0, #3
	strh r2, [r1, #0x82]
	bl sub_20CAC94
	ldr r1, _020CA194 // =0x021471EC
	mov r0, #0
	ldr r1, [r1]
	ldr r3, _020CA198 // =0x0000083D
	mov r2, r0
	add r1, r1, #0x2140
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA14C:
	mov r0, #0xa
	bl sub_20CAC94
	bl sub_20CAB84
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA164:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020CA194 // =0x021471EC
	ldr r3, _020CA19C // =0x0000084F
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2140
	mov r2, #0
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CA194: .word 0x021471EC
_020CA198: .word 0x0000083D
_020CA19C: .word 0x0000084F
	arm_func_end sub_20CA0B4

	arm_func_start sub_20CA1A0
sub_20CA1A0: // 0x020CA1A0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0xc
	addls pc, pc, r0, lsl #2
	b _020CA3E8
_020CA1B8: // jump table
	b _020CA1EC // case 0
	b _020CA3C0 // case 1
	b _020CA3E8 // case 2
	b _020CA3E8 // case 3
	b _020CA3E8 // case 4
	b _020CA3E8 // case 5
	b _020CA3D4 // case 6
	b _020CA3E8 // case 7
	b _020CA3E8 // case 8
	b _020CA3E8 // case 9
	b _020CA3E8 // case 10
	b _020CA3D4 // case 11
	b _020CA3D4 // case 12
_020CA1EC:
	ldrh r0, [r4, #8]
	cmp r0, #9
	bgt _020CA22C
	cmp r0, #0
	addge pc, pc, r0, lsl #2
	b _020CA394
_020CA204: // jump table
	b _020CA394 // case 0
	b _020CA394 // case 1
	b _020CA394 // case 2
	b _020CA394 // case 3
	b _020CA394 // case 4
	b _020CA394 // case 5
	b _020CA40C // case 6
	b _020CA2B4 // case 7
	b _020CA23C // case 8
	b _020CA23C // case 9
_020CA22C:
	cmp r0, #0x1a
	ldmeqia sp!, {r4, lr}
	bxeq lr
	b _020CA394
_020CA23C:
	ldr r1, _020CA414 // =0x021471EC
	ldr r2, [r1]
	add r0, r2, #0x2000
	ldr r0, [r0, #0x260]
	sub r0, r0, #8
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020CA40C
_020CA25C: // jump table
	b _020CA27C // case 0
	b _020CA28C // case 1
	b _020CA270 // case 2
	b _020CA40C // case 3
	b _020CA2A8 // case 4
_020CA270:
	add r0, r2, #0x2200
	mov r1, #0
	strh r1, [r0, #0x82]
_020CA27C:
	mov r0, #0xc
	bl sub_20CAC94
	ldmia sp!, {r4, lr}
	bx lr
_020CA28C:
	add r0, r2, #0x2200
	mov r2, #0
	strh r2, [r0, #0x82]
	ldr r0, [r1]
	mov r1, #6
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
_020CA2A8:
	bl sub_20CAB84
	ldmia sp!, {r4, lr}
	bx lr
_020CA2B4:
	ldr r1, _020CA414 // =0x021471EC
	ldr r3, [r1]
	add r0, r3, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #0xc
	bne _020CA2E0
	mov r0, #8
	bl sub_20CAC94
	bl sub_20CAB84
	ldmia sp!, {r4, lr}
	bx lr
_020CA2E0:
	ldrh r2, [r4, #0xa]
	cmp r2, #1
	blo _020CA388
	ldr r0, _020CA418 // =0x000007D7
	cmp r2, r0
	bhi _020CA388
	add r0, r3, #0x2200
	strh r2, [r0, #0x82]
	ldr r1, [r1]
	ldr r0, _020CA41C // =sub_20C9F90
	add r1, r1, #0x1500
	mov r2, #0x620
	bl sub_20F346C
	cmp r0, #2
	ldmeqia sp!, {r4, lr}
	bxeq lr
	cmp r0, #3
	beq _020CA35C
	cmp r0, #8
	bne _020CA35C
	mov r0, #0xc
	bl sub_20CAC94
	ldr r0, _020CA414 // =0x021471EC
	ldr r3, _020CA420 // =0x000007ED
	ldr r1, [r0]
	mov r0, #1
	add r1, r1, #0x2140
	mov r2, #0
	bl sub_20CAD98
	ldmia sp!, {r4, lr}
	bx lr
_020CA35C:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020CA414 // =0x021471EC
	ldr r3, _020CA424 // =0x000007F6
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2140
	mov r2, #0
	bl sub_20CAD98
	ldmia sp!, {r4, lr}
	bx lr
_020CA388:
	bl sub_20CAB84
	ldmia sp!, {r4, lr}
	bx lr
_020CA394:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020CA414 // =0x021471EC
	ldrh r2, [r4, #8]
	ldr r0, [r0]
	ldr r3, _020CA428 // =0x00000804
	add r1, r0, #0x2140
	mov r0, #7
	bl sub_20CAD98
	ldmia sp!, {r4, lr}
	bx lr
_020CA3C0:
	ldr r0, _020CA414 // =0x021471EC
	ldrh r1, [r4, #0xe]
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0xf8]
_020CA3D4:
	mov r0, #8
	bl sub_20CAC94
	bl sub_20CAB84
	ldmia sp!, {r4, lr}
	bx lr
_020CA3E8:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020CA414 // =0x021471EC
	ldr r3, _020CA42C // =0x0000081B
	ldr r1, [r0]
	mov r0, #7
	add r1, r1, #0x2140
	mov r2, #0
	bl sub_20CAD98
_020CA40C:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CA414: .word 0x021471EC
_020CA418: .word 0x000007D7
_020CA41C: .word sub_20C9F90
_020CA420: .word 0x000007ED
_020CA424: .word 0x000007F6
_020CA428: .word 0x00000804
_020CA42C: .word 0x0000081B
	arm_func_end sub_20CA1A0

	arm_func_start sub_20CA430
sub_20CA430: // 0x020CA430
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r0, [r0, #2]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020CA494
_020CA448: // jump table
	b _020CA45C // case 0
	b _020CA484 // case 1
	b _020CA494 // case 2
	b _020CA494 // case 3
	b _020CA494 // case 4
_020CA45C:
	mov r0, #3
	bl sub_20CAC94
	mov r0, #0
	ldr r3, _020CA4BC // =0x00000783
	mov r1, r0
	mov r2, r0
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA484:
	bl sub_20CAB84
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA494:
	mov r0, #0xb
	bl sub_20CAC94
	mov r1, #0
	ldr r3, _020CA4C0 // =0x00000793
	mov r2, r1
	mov r0, #7
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CA4BC: .word 0x00000783
_020CA4C0: .word 0x00000793
	arm_func_end sub_20CA430

	arm_func_start sub_20CA4C4
sub_20CA4C4: // 0x020CA4C4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r5, r0
	ldrh r0, [r5, #2]
	mov r4, #0x14
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020CA770
_020CA4E4: // jump table
	b _020CA4F8 // case 0
	b _020CA760 // case 1
	b _020CA770 // case 2
	b _020CA770 // case 3
	b _020CA770 // case 4
_020CA4F8:
	ldr r0, _020CA798 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #5
	bne _020CA52C
	mov r0, #6
	bl sub_20CAC94
	mov r0, #0
	ldr r3, _020CA79C // =0x00000704
	mov r1, r0
	mov r2, r0
	bl sub_20CAD98
_020CA52C:
	ldr r1, _020CA798 // =0x021471EC
	ldr r2, [r1]
	add r0, r2, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #6
	beq _020CA558
	cmp r0, #7
	beq _020CA6D0
	cmp r0, #0xd
	beq _020CA6E0
	b _020CA6F0
_020CA558:
	add r0, r2, #0x2200
	mov r2, #7
	strh r2, [r0, #0x80]
	ldrh r0, [r5, #8]
	cmp r0, #5
	bne _020CA5E4
	ldr r0, [r1]
	add r1, r0, #0x2200
	add r0, r0, #0x2000
	ldrh r1, [r1, #0x8c]
	ldr r0, [r0, #0x288]
	bl DC_InvalidateRange
	ldrh r0, [r5, #0xe]
	mov r4, #0
	cmp r0, #0
	ble _020CA5E4
	ldr r8, _020CA7A0 // =0x0000071A
	mov r6, r4
	mov r7, #7
_020CA5A4:
	add r0, r5, r4, lsl #1
	add r2, r5, r4, lsl #2
	ldrh r1, [r0, #0x50]
	ldr r0, [r2, #0x10]
	bl sub_20CC2F4
	str r8, [sp]
	add r0, r5, r4, lsl #2
	ldr r2, [r0, #0x10]
	mov r0, r7
	mov r1, r6
	mov r3, r5
	bl sub_20CAD3C
	ldrh r0, [r5, #0xe]
	add r4, r4, #1
	cmp r4, r0
	blt _020CA5A4
_020CA5E4:
	ldr r0, _020CA798 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r1, [r0, #0x264]
	and r0, r1, #0xc00000
	cmp r0, #0xc00000
	bne _020CA650
	ldr r0, _020CA7A4 // =0x00003FFE
	and r0, r1, r0
	bl sub_20C9AA8
	movs r1, r0
	beq _020CA650
	ldr r0, _020CA798 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r6, [r0, #0x284]
	mov r0, r6
	bl _u32_div_f
	cmp r1, #0
	bne _020CA650
	ldr r4, _020CA7A8 // =0x00000728
	mov r1, #0
	mov r2, r6
	mov r3, r1
	mov r0, #8
	str r4, [sp]
	bl sub_20CAD3C
_020CA650:
	ldrh r0, [r5, #0xa]
	bl sub_20C9ACC
	rsb r0, r0, #0x20
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl sub_20CADE8
	ldr r1, _020CA798 // =0x021471EC
	mov r2, #1
	mov r2, r2, lsl r0
	ldr r0, [r1]
	mov r2, r2, asr #1
	add r0, r0, #0x2200
	strh r2, [r0, #0x8e]
	ldr r0, [r1]
	add r1, r0, #0x2200
	add r0, r0, #0x2000
	ldrh r1, [r1, #0x8c]
	ldr r0, [r0, #0x288]
	bl DC_InvalidateRange
	ldr r3, _020CA798 // =0x021471EC
	ldr r2, _020CA7AC // =0x00002288
	ldr r1, [r3]
	ldr r0, _020CA7B0 // =sub_20CA4C4
	add r1, r1, #0x2000
	ldr r4, [r1, #0x284]
	add r4, r4, #1
	str r4, [r1, #0x284]
	ldr r1, [r3]
	add r1, r1, r2
	bl sub_20F27B8
	mov r4, r0
	b _020CA6F0
_020CA6D0:
	ldr r0, _020CA7B4 // =sub_20CA430
	bl WM_EndScan
	mov r4, r0
	b _020CA6F0
_020CA6E0:
	bl sub_20CAB84
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CA6F0:
	cmp r4, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, lr}
	bxeq lr
	cmp r4, #3
	beq _020CA738
	cmp r4, #8
	bne _020CA738
	mov r0, #0xc
	bl sub_20CAC94
	mov r1, #0
	ldr r3, _020CA7B8 // =0x00000753
	mov r2, r1
	mov r0, #1
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CA738:
	mov r0, #0xb
	bl sub_20CAC94
	mov r1, #0
	ldr r3, _020CA7BC // =0x0000075C
	mov r2, r1
	mov r0, #7
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CA760:
	bl sub_20CAB84
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CA770:
	mov r0, #0xb
	bl sub_20CAC94
	mov r1, #0
	ldr r3, _020CA7C0 // =0x0000076D
	mov r2, r1
	mov r0, #7
	bl sub_20CAD98
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020CA798: .word 0x021471EC
_020CA79C: .word 0x00000704
_020CA7A0: .word 0x0000071A
_020CA7A4: .word 0x00003FFE
_020CA7A8: .word 0x00000728
_020CA7AC: .word 0x00002288
_020CA7B0: .word sub_20CA4C4
_020CA7B4: .word sub_20CA430
_020CA7B8: .word 0x00000753
_020CA7BC: .word 0x0000075C
_020CA7C0: .word 0x0000076D
	arm_func_end sub_20CA4C4

	arm_func_start sub_20CA7C4
sub_20CA7C4: // 0x020CA7C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r1, [r0, #2]
	mov r2, #0x14
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	b _020CAA68
_020CA7E0: // jump table
	b _020CA7F4 // case 0
	b _020CAA28 // case 1
	b _020CAA68 // case 2
	b _020CAA68 // case 3
	b _020CAA68 // case 4
_020CA7F4:
	ldrh r0, [r0]
	cmp r0, #0x19
	bgt _020CA830
	cmp r0, #0x19
	bge _020CA910
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _020CA988
_020CA814: // jump table
	b _020CA988 // case 0
	b _020CA988 // case 1
	b _020CA988 // case 2
	b _020CA850 // case 3
	b _020CA860 // case 4
	b _020CA8C4 // case 5
	b _020CA8EC // case 6
_020CA830:
	cmp r0, #0x1d
	bgt _020CA844
	cmp r0, #0x1d
	beq _020CA8FC
	b _020CA988
_020CA844:
	cmp r0, #0x27
	beq _020CA938
	b _020CA988
_020CA850:
	ldr r0, _020CAAA8 // =sub_20CA7C4
	bl sub_20F2D90
	mov r2, r0
	b _020CA988
_020CA860:
	bl sub_20F1AE4
	cmp r0, #0
	beq _020CA874
	cmp r0, #4
	b _020CA89C
_020CA874:
	mov r0, #1
	bl sub_20CAC94
	mov r0, #0
	ldr r3, _020CAAAC // =0x00000663
	mov r1, r0
	mov r2, r0
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA89C:
	mov r0, #0xb
	bl sub_20CAC94
	mov r1, #0
	ldr r3, _020CAAB0 // =0x0000066C
	mov r2, r1
	mov r0, #7
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA8C4:
	mov r0, #3
	bl sub_20CAC94
	mov r0, #0
	ldr r3, _020CAAB4 // =0x00000673
	mov r1, r0
	mov r2, r0
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA8EC:
	ldr r0, _020CAAA8 // =sub_20CA7C4
	bl sub_20F2DD8
	mov r2, r0
	b _020CA988
_020CA8FC:
	ldr r0, _020CAAA8 // =sub_20CA7C4
	mov r1, #0
	bl sub_20F438C
	mov r2, r0
	b _020CA988
_020CA910:
	ldr r1, _020CAAB8 // =0x021471EC
	ldr r0, _020CAAA8 // =sub_20CA7C4
	ldr r3, [r1]
	add r2, r3, #0x2000
	ldrb r1, [r2, #0x250]
	ldrb r2, [r2, #0x251]
	add r3, r3, #0x2200
	bl sub_20F44C4
	mov r2, r0
	b _020CA988
_020CA938:
	ldr r0, _020CAAB8 // =0x021471EC
	ldr r2, [r0]
	add r0, r2, #0x2000
	ldr r1, [r0, #0x264]
	and r0, r1, #0xc0000
	cmp r0, #0xc0000
	moveq r0, #1
	movne r0, #0
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	and r1, r1, #0x30000
	cmp r1, #0x30000
	movne r3, #1
	add r1, r2, #0x2140
	ldr r0, _020CAABC // =sub_20CA1A0
	moveq r3, #0
	mov r2, #0
	str ip, [sp]
	bl WM_StartConnectEx
	mov r2, r0
_020CA988:
	cmp r2, #2
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	cmp r2, #3
	beq _020CA9E8
	cmp r2, #8
	bne _020CA9E8
	mov r0, #0xc
	bl sub_20CAC94
	ldr r0, _020CAAB8 // =0x021471EC
	ldr r3, _020CAAC0 // =0x000006AF
	ldr r1, [r0]
	mov r2, #0
	add r0, r1, #0x2200
	ldrsh r0, [r0, #0x80]
	cmp r0, #5
	addeq r1, r1, #0x2140
	movne r1, #0
	mov r0, #1
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CA9E8:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020CAAB8 // =0x021471EC
	ldr r3, _020CAAC4 // =0x000006B8
	ldr r1, [r0]
	mov r2, #0
	add r0, r1, #0x2200
	ldrsh r0, [r0, #0x80]
	cmp r0, #5
	addeq r1, r1, #0x2140
	movne r1, #0
	mov r0, #7
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CAA28:
	mov r0, #0xc
	bl sub_20CAC94
	ldr r0, _020CAAB8 // =0x021471EC
	ldr r3, _020CAAC8 // =0x000006DE
	ldr r1, [r0]
	mov r2, #0
	add r0, r1, #0x2200
	ldrsh r0, [r0, #0x80]
	cmp r0, #5
	addeq r1, r1, #0x2140
	movne r1, #0
	mov r0, #1
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CAA68:
	mov r0, #0xb
	bl sub_20CAC94
	ldr r0, _020CAAB8 // =0x021471EC
	ldr r3, _020CAACC // =0x000006E8
	ldr r1, [r0]
	mov r2, #0
	add r0, r1, #0x2200
	ldrsh r0, [r0, #0x80]
	cmp r0, #5
	addeq r1, r1, #0x2140
	movne r1, #0
	mov r0, #7
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CAAA8: .word sub_20CA7C4
_020CAAAC: .word 0x00000663
_020CAAB0: .word 0x0000066C
_020CAAB4: .word 0x00000673
_020CAAB8: .word 0x021471EC
_020CAABC: .word sub_20CA1A0
_020CAAC0: .word 0x000006AF
_020CAAC4: .word 0x000006B8
_020CAAC8: .word 0x000006DE
_020CAACC: .word 0x000006E8
	arm_func_end sub_20CA7C4

	arm_func_start sub_20CAAD0
sub_20CAAD0: // 0x020CAAD0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r1, [r0, #2]
	cmp r1, #8
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldrh r1, [r0, #4]
	cmp r1, #0x16
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldrh r0, [r0, #6]
	cmp r0, #0x25
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r0, _020CAB80 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r0, [r0, #0x260]
	sub r0, r0, #8
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020CAB74
_020CAB34: // jump table
	b _020CAB48 // case 0
	b _020CAB5C // case 1
	b _020CAB6C // case 2
	b _020CAB74 // case 3
	b _020CAB5C // case 4
_020CAB48:
	mov r0, #0xc
	bl sub_20CAC94
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CAB5C:
	bl sub_20CAB84
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CAB6C:
	mov r0, #0xc
	bl sub_20CAC94
_020CAB74:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CAB80: .word 0x021471EC
	arm_func_end sub_20CAAD0

	arm_func_start sub_20CAB84
sub_20CAB84: // 0x020CAB84
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020CABF4 // =0x021471EC
	ldr r0, [r0]
	add r1, r0, #0x2000
	ldrb r0, [r1, #0x26b]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r0, _020CABF8 // =sub_20C9AD4
	mov r2, #1
	strb r2, [r1, #0x26b]
	bl WM_Reset
	cmp r0, #2
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	mov r0, #0xb
	bl sub_20CAC94
	mov r1, #0
	mov r2, r1
	mov r0, #7
	mov r3, #0x610
	bl sub_20CAD98
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CABF4: .word 0x021471EC
_020CABF8: .word sub_20C9AD4
	arm_func_end sub_20CAB84

	arm_func_start sub_20CABFC
sub_20CABFC: // 0x020CABFC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20CC904
	bl sub_20CAC18
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20CABFC

	arm_func_start sub_20CAC18
sub_20CAC18: // 0x020CAC18
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl OS_DisableInterrupts
	ldr r2, _020CAC84 // =0x021471EC
	ldr r1, _020CAC88 // =0x000022CC
	ldr r2, [r2]
	mov r4, r0
	add r0, r2, r1
	bl OS_CancelAlarm
	ldr r0, _020CAC84 // =0x021471EC
	ldr ip, [r0]
	add r0, ip, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #9
	bne _020CAC70
	ldr r0, _020CAC88 // =0x000022CC
	ldr r1, _020CAC8C // =0x022F5341
	mov r2, #0
	ldr r3, _020CAC90 // =sub_20CABFC
	add r0, ip, r0
	str r2, [sp]
	bl OS_SetAlarm
_020CAC70:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CAC84: .word 0x021471EC
_020CAC88: .word 0x000022CC
_020CAC8C: .word 0x022F5341
_020CAC90: .word sub_20CABFC
	arm_func_end sub_20CAC18

	arm_func_start sub_20CAC94
sub_20CAC94: // 0x020CAC94
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020CAD2C // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	add r0, r1, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #9
	bne _020CACD4
	cmp r5, #9
	beq _020CACD4
	ldr r0, _020CAD30 // =0x000022CC
	add r0, r1, r0
	bl OS_CancelAlarm
_020CACD4:
	ldr r0, _020CAD2C // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	ldr r1, [r0, #0x260]
	cmp r1, #0xb
	strne r5, [r0, #0x260]
	cmp r5, #9
	bne _020CAD18
	mov r2, #0
	ldr r0, _020CAD2C // =0x021471EC
	str r2, [sp]
	ldr r5, [r0]
	ldr r0, _020CAD30 // =0x000022CC
	ldr r1, _020CAD34 // =0x022F5341
	ldr r3, _020CAD38 // =sub_20CABFC
	add r0, r5, r0
	bl OS_SetAlarm
_020CAD18:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CAD2C: .word 0x021471EC
_020CAD30: .word 0x000022CC
_020CAD34: .word 0x022F5341
_020CAD38: .word sub_20CABFC
	arm_func_end sub_20CAC94

	arm_func_start sub_20CAD3C
sub_20CAD3C: // 0x020CAD3C
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr ip, _020CAD94 // =0x021471EC
	ldr ip, [ip]
	add ip, ip, #0x2000
	ldr lr, [ip, #0x27c]
	cmp lr, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {lr}
	bxeq lr
	ldr lr, [sp, #0x18]
	strh r0, [sp]
	str r2, [sp, #4]
	str r3, [sp, #8]
	str lr, [sp, #0xc]
	strh r1, [sp, #2]
	ldr r1, [ip, #0x27c]
	add r0, sp, #0
	blx r1
	add sp, sp, #0x14
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CAD94: .word 0x021471EC
	arm_func_end sub_20CAD3C

	arm_func_start sub_20CAD98
sub_20CAD98: // 0x020CAD98
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr ip, _020CADE4 // =0x021471EC
	mov r5, r0
	ldr r0, [ip]
	mov r4, r1
	add r1, r0, #0x2200
	ldrsh r0, [r1, #0x80]
	mov ip, #0
	mov lr, r2
	strh ip, [r1, #0x80]
	str r3, [sp]
	mov r1, r5
	mov r2, r4
	mov r3, lr
	bl sub_20CAD3C
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CADE4: .word 0x021471EC
	arm_func_end sub_20CAD98

	arm_func_start sub_20CADE8
sub_20CADE8: // 0x020CADE8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _020CAE80 // =0x021471EC
	mov r2, r0
	ldr r1, [r1]
	mov r3, #0
	add r1, r1, #0x2000
	ldr r1, [r1, #0x264]
	mov r6, #1
	ldr r5, _020CAE84 // =0x4EC4EC4F
	ldr r4, _020CAE88 // =0x0000000D
_020CAE10:
	smull ip, lr, r5, r2
	mov lr, lr, asr #2
	mov ip, r2, lsr #0x1f
	add lr, ip, lr
	smull ip, lr, r4, lr
	sub lr, r2, ip
	add ip, lr, #1
	mov ip, r6, lsl ip
	ands ip, r1, ip
	bne _020CAE48
	add r3, r3, #1
	cmp r3, #0xd
	add r2, r2, #1
	blt _020CAE10
_020CAE48:
	ldr r1, _020CAE84 // =0x4EC4EC4F
	add r3, r0, r3
	smull r0, r4, r1, r3
	mov r4, r4, asr #2
	mov r0, r3, lsr #0x1f
	ldr r2, _020CAE88 // =0x0000000D
	add r4, r0, r4
	smull r0, r1, r2, r4
	sub r4, r3, r0
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020CAE80: .word 0x021471EC
_020CAE84: .word 0x4EC4EC4F
_020CAE88: .word 0x0000000D
	arm_func_end sub_20CADE8

	arm_func_start sub_20CAE8C
sub_20CAE8C: // 0x020CAE8C
	ldr r0, _020CAEA4 // =0x021471EC
	ldr r1, _020CAEA8 // =0x00AAA082
	ldr r0, [r0]
	add r0, r0, #0x2000
	str r1, [r0, #0x264]
	bx lr
	.align 2, 0
_020CAEA4: .word 0x021471EC
_020CAEA8: .word 0x00AAA082
	arm_func_end sub_20CAE8C

	arm_func_start sub_20CAEAC
sub_20CAEAC: // 0x020CAEAC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r0, r2
	mov r4, r1
	bl sub_20CB1A4
	ldr r2, _020CB050 // =0x021471EC
	mov r3, #0x400
	ldr r1, [r2]
	mov r0, #0
	add ip, r1, #0x1500
	add r1, r1, #0x2000
	str ip, [r1, #0x288]
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r3, [r1, #0x8c]
	bl sub_20CADE8
	ldr r1, _020CB050 // =0x021471EC
	mov r2, #1
	mov r2, r2, lsl r0
	ldr r0, [r1]
	mov r2, r2, asr #1
	add r0, r0, #0x2200
	strh r2, [r0, #0x8e]
	ldr r0, [r1]
	add r0, r0, #0x2200
	ldrh r0, [r0, #0x68]
	cmp r0, #0
	bne _020CAF24
	bl WM_GetDispersionScanPeriod
_020CAF24:
	ldr r2, _020CB050 // =0x021471EC
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r0, [r1, #0x90]
	ldr r1, [r2]
	add r0, r1, #0x2000
	ldr r0, [r0, #0x264]
	and r0, r0, #0x300000
	cmp r0, #0x300000
	movne r2, #1
	moveq r2, #0
	add r0, r1, #0x2200
	strh r2, [r0, #0x98]
	cmp r5, #0
	bne _020CAF80
	ldr r0, _020CB050 // =0x021471EC
	ldr r1, _020CB054 // =0x00002292
	ldr r2, [r0]
	ldr r0, _020CB058 // =0x0211279C
	add r1, r2, r1
	mov r2, #6
	bl MI_CpuCopy8
	b _020CAF9C
_020CAF80:
	ldr r0, _020CB050 // =0x021471EC
	ldr r1, _020CB054 // =0x00002292
	ldr r2, [r0]
	mov r0, r5
	add r1, r2, r1
	mov r2, #6
	bl MI_CpuCopy8
_020CAF9C:
	cmp r4, #0
	beq _020CAFB0
	ldr r0, _020CB05C // =0x021127A4
	cmp r4, r0
	bne _020CAFE4
_020CAFB0:
	ldr r0, _020CB050 // =0x021471EC
	ldr r1, _020CB060 // =0x0000229C
	ldr r2, [r0]
	ldr r0, _020CB05C // =0x021127A4
	add r1, r2, r1
	mov r2, #0x20
	bl MI_CpuCopy8
	ldr r0, _020CB050 // =0x021471EC
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x9a]
	b _020CB030
_020CAFE4:
	ldr r0, _020CB050 // =0x021471EC
	ldr r1, _020CB060 // =0x0000229C
	ldr r2, [r0]
	mov r0, r4
	add r1, r2, r1
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r1, #0
_020CB004:
	ldrb r0, [r4]
	cmp r0, #0
	beq _020CB020
	add r1, r1, #1
	cmp r1, #0x20
	add r4, r4, #1
	blt _020CB004
_020CB020:
	ldr r0, _020CB050 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x9a]
_020CB030:
	ldr r0, _020CB050 // =0x021471EC
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, #0x2000
	str r1, [r0, #0x284]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CB050: .word 0x021471EC
_020CB054: .word 0x00002292
_020CB058: .word 0x0211279C
_020CB05C: .word 0x021127A4
_020CB060: .word 0x0000229C
	arm_func_end sub_20CAEAC

	arm_func_start sub_20CB064
sub_20CB064: // 0x020CB064
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	mov r4, r1
	bne _020CB0B8
	ldr r1, _020CB190 // =0x021471EC
	mov r3, #3
	ldr r0, [r1]
	mov r2, #0
	add r0, r0, #0x2000
	str r3, [r0, #0x26c]
	ldr r0, [r1]
	add r0, r0, #0x2000
	str r2, [r0, #0x270]
	ldr r0, [r1]
	add r0, r0, #0x2000
	str r2, [r0, #0x274]
	ldr r0, [r1]
	add r0, r0, #0x2000
	str r2, [r0, #0x278]
	b _020CB174
_020CB0B8:
	ldr r1, _020CB190 // =0x021471EC
	ldr r2, [r5]
	ldr r0, [r1]
	and r2, r2, #3
	add r0, r0, #0x2000
	str r2, [r0, #0x26c]
	ldr r3, [r5, #4]
	ldr r0, [r5, #8]
	and r2, r3, #3
	rsb r2, r2, #4
	and r2, r2, #3
	add r2, r2, #0xc
	cmp r2, r0
	bls _020CB110
	ldr r0, [r1]
	mov r2, #0
	add r0, r0, #0x2000
	str r2, [r0, #0x270]
	ldr r0, [r1]
	add r0, r0, #0x2000
	str r2, [r0, #0x274]
	b _020CB160
_020CB110:
	ldr r0, [r1]
	add r2, r3, #3
	bic r2, r2, #3
	add r0, r0, #0x2000
	str r2, [r0, #0x270]
	ldr r2, [r5, #4]
	ldr r0, [r1]
	and r2, r2, #3
	rsb r2, r2, #4
	ldr r3, [r5, #8]
	and r2, r2, #3
	sub r2, r3, r2
	add r0, r0, #0x2000
	str r2, [r0, #0x274]
	ldr r0, [r1]
	mov r1, #0
	add r2, r0, #0x2000
	ldr r0, [r2, #0x270]
	ldr r2, [r2, #0x274]
	bl MI_CpuFill8
_020CB160:
	ldr r0, _020CB190 // =0x021471EC
	ldr r1, [r5, #0xc]
	ldr r0, [r0]
	add r0, r0, #0x2000
	str r1, [r0, #0x278]
_020CB174:
	ldr r0, _020CB190 // =0x021471EC
	ldr r0, [r0]
	add r0, r0, #0x2000
	str r4, [r0, #0x27c]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CB190: .word 0x021471EC
	arm_func_end sub_20CB064

	arm_func_start sub_20CB194
sub_20CB194: // 0x020CB194
	ldr r0, _020CB1A0 // =0x021471EC
	ldr r0, [r0]
	bx lr
	.align 2, 0
_020CB1A0: .word 0x021471EC
	arm_func_end sub_20CB194

	arm_func_start sub_20CB1A4
sub_20CB1A4: // 0x020CB1A4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	ldr r1, _020CB248 // =0x021471EC
	mov r2, #0
	ldr r1, [r1]
	add r3, r1, #0x2000
	cmp r1, #0
	ldr r4, [r3, #0x264]
	bne _020CB1E4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB1E4:
	ands r3, r5, #0x8000
	beq _020CB200
	ldr r3, _020CB24C // =0x00003FFE
	orr r2, r2, r3
	ands r3, r5, r3
	ldreq r3, _020CB250 // =0x0000A082
	orreq r5, r5, r3
_020CB200:
	ands r3, r5, #0x20000
	orrne r2, r2, #0x10000
	ands r3, r5, #0x80000
	orrne r2, r2, #0x40000
	ands r3, r5, #0x200000
	orrne r2, r2, #0x100000
	ands r3, r5, #0x800000
	orrne r2, r2, #0x400000
	mvn r2, r2
	and r2, r4, r2
	orr r2, r5, r2
	add r1, r1, #0x2000
	str r2, [r1, #0x264]
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CB248: .word 0x021471EC
_020CB24C: .word 0x00003FFE
_020CB250: .word 0x0000A082
	arm_func_end sub_20CB1A4

	arm_func_start WCM_GetPhase
WCM_GetPhase: // 0x020CB254
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020CB284 // =0x021471EC
	mov r4, #0
	ldr r1, [r1]
	cmp r1, #0
	addne r1, r1, #0x2000
	ldrne r4, [r1, #0x260]
	bl OS_RestoreInterrupts
	mov r0, r4
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CB284: .word 0x021471EC
	arm_func_end WCM_GetPhase

	arm_func_start sub_20CB288
sub_20CB288: // 0x020CB288
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	ldr r1, _020CB4D8 // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CB2BC
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB2BC:
	add r1, r1, #0x2000
	ldr r2, [r1, #0x260]
	cmp r2, #0xd
	addls pc, pc, r2, lsl #2
	b _020CB364
_020CB2D0: // jump table
	b _020CB364 // case 0
	b _020CB31C // case 1
	b _020CB364 // case 2
	b _020CB37C // case 3
	b _020CB364 // case 4
	b _020CB364 // case 5
	b _020CB330 // case 6
	b _020CB364 // case 7
	b _020CB364 // case 8
	b _020CB37C // case 9
	b _020CB364 // case 10
	b _020CB364 // case 11
	b _020CB37C // case 12
	b _020CB308 // case 13
_020CB308:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB31C:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB330:
	mov r0, #0xd
	bl sub_20CAC94
	ldr r1, _020CB4D8 // =0x021471EC
	mov r0, r4
	ldr r1, [r1]
	mov r2, #9
	add r1, r1, #0x2200
	strh r2, [r1, #0x80]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #3
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB364:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB37C:
	ldrb r0, [r1, #0x26b]
	cmp r0, #1
	bne _020CB3A8
	mov r0, #0xd
	bl sub_20CAC94
	ldr r0, _020CB4D8 // =0x021471EC
	mov r1, #9
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB4C0
_020CB3A8:
	bl sub_20F13C8
	mov r5, r0
	mov r1, #2
	bl DC_InvalidateRange
	ldrh r0, [r5]
	cmp r0, #0
	beq _020CB3D8
	cmp r0, #1
	beq _020CB418
	cmp r0, #2
	beq _020CB424
	b _020CB430
_020CB3D8:
	bl sub_20F1AE4
	cmp r0, #0
	bne _020CB44C
	mov r0, #1
	bl sub_20CAC94
	ldr r1, _020CB4D8 // =0x021471EC
	mov r0, r4
	ldr r1, [r1]
	mov r2, #0
	add r1, r1, #0x2200
	strh r2, [r1, #0x80]
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB418:
	ldr r0, _020CB4DC // =sub_20CA7C4
	bl sub_20F2DD8
	b _020CB44C
_020CB424:
	ldr r0, _020CB4DC // =sub_20CA7C4
	bl sub_20F2D48
	b _020CB44C
_020CB430:
	ldr r1, _020CB4D8 // =0x021471EC
	ldr r0, _020CB4E0 // =sub_20C9AD4
	ldr r1, [r1]
	mov r2, #1
	add r1, r1, #0x2000
	strb r2, [r1, #0x26b]
	bl WM_Reset
_020CB44C:
	cmp r0, #2
	beq _020CB468
	cmp r0, #3
	beq _020CB4A0
	cmp r0, #8
	beq _020CB488
	b _020CB4A0
_020CB468:
	mov r0, #0xd
	bl sub_20CAC94
	ldr r0, _020CB4D8 // =0x021471EC
	mov r1, #9
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB4C0
_020CB488:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB4A0:
	mov r0, #0xb
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #7
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CB4C0:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CB4D8: .word 0x021471EC
_020CB4DC: .word sub_20CA7C4
_020CB4E0: .word sub_20C9AD4
	arm_func_end sub_20CB288

	arm_func_start sub_20CB4E4
sub_20CB4E4: // 0x020CB4E4
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020CB614 // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CB510
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CB510:
	add r1, r1, #0x2000
	ldr r2, [r1, #0x260]
	cmp r2, #3
	beq _020CB540
	cmp r2, #9
	beq _020CB560
	cmp r2, #0xa
	bne _020CB550
	bl OS_RestoreInterrupts
	mov r0, #2
	ldmia sp!, {r4, lr}
	bx lr
_020CB540:
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_020CB550:
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CB560:
	ldrb r0, [r1, #0x26b]
	cmp r0, #1
	bne _020CB58C
	mov r0, #0xa
	bl sub_20CAC94
	ldr r0, _020CB614 // =0x021471EC
	mov r1, #6
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB600
_020CB58C:
	ldr r0, _020CB618 // =sub_20C9E38
	bl sub_20F3308
	cmp r0, #2
	beq _020CB5B0
	cmp r0, #3
	beq _020CB5E4
	cmp r0, #8
	beq _020CB5D0
	b _020CB5E4
_020CB5B0:
	mov r0, #0xa
	bl sub_20CAC94
	ldr r0, _020CB614 // =0x021471EC
	mov r1, #6
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB600
_020CB5D0:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #4
	ldmia sp!, {r4, lr}
	bx lr
_020CB5E4:
	mov r0, #0xb
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, lr}
	bx lr
_020CB600:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CB614: .word 0x021471EC
_020CB618: .word sub_20C9E38
	arm_func_end sub_20CB4E4

	arm_func_start sub_20CB61C
sub_20CB61C: // 0x020CB61C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl OS_DisableInterrupts
	ldr r2, _020CB870 // =0x021471EC
	mov r4, r0
	ldr ip, [r2]
	cmp ip, #0
	bne _020CB65C
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB65C:
	add r1, ip, #0x2000
	ldr r3, [r1, #0x260]
	cmp r3, #3
	beq _020CB680
	cmp r3, #8
	beq _020CB790
	cmp r3, #9
	beq _020CB7A4
	b _020CB7B8
_020CB680:
	cmp r7, #0
	bne _020CB69C
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB69C:
	ldrh r3, [r7, #0x3c]
	cmp r3, #0
	beq _020CB6BC
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB6BC:
	cmp r6, #0
	beq _020CB744
	ldrb r3, [r6]
	cmp r3, #4
	bhs _020CB6DC
	ldrb r0, [r6, #1]
	cmp r0, #4
	blo _020CB6F4
_020CB6DC:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB6F4:
	strb r3, [r1, #0x250]
	ldr r0, [r2]
	ldrb r1, [r6, #1]
	add r0, r0, #0x2000
	strb r1, [r0, #0x251]
	ldr r1, [r2]
	add r0, r1, #0x2000
	ldrb r0, [r0, #0x250]
	cmp r0, #0
	bne _020CB730
	add r0, r1, #0x2200
	mov r1, #0
	mov r2, #0x50
	bl MI_CpuFill8
	b _020CB754
_020CB730:
	add r0, r6, #2
	add r1, r1, #0x2200
	mov r2, #0x50
	bl MI_CpuCopy8
	b _020CB754
_020CB744:
	add r0, ip, #0x2200
	mov r1, #0
	mov r2, #0x52
	bl MI_CpuFill8
_020CB754:
	ldr r1, _020CB870 // =0x021471EC
	mov r0, r7
	ldr r1, [r1]
	mov r2, #0xc0
	add r1, r1, #0x2140
	bl MI_CpuCopy8
	ldr r1, _020CB870 // =0x021471EC
	mov r0, r5
	ldr r1, [r1]
	add r1, r1, #0x2100
	ldrh r2, [r1, #0x6e]
	orr r2, r2, #3
	strh r2, [r1, #0x70]
	bl sub_20CB1A4
	b _020CB7CC
_020CB790:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB7A4:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB7B8:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB7CC:
	ldr r1, _020CB874 // =0x0000FFFF
	ldr r0, _020CB878 // =sub_20CA7C4
	mov r3, r1
	mov r2, #0x50
	str r1, [sp]
	bl WM_SetLifeTime
	cmp r0, #2
	beq _020CB800
	cmp r0, #3
	beq _020CB838
	cmp r0, #8
	beq _020CB820
	b _020CB838
_020CB800:
	mov r0, #8
	bl sub_20CAC94
	ldr r0, _020CB870 // =0x021471EC
	mov r1, #5
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB858
_020CB820:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB838:
	mov r0, #0xb
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #7
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB858:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020CB870: .word 0x021471EC
_020CB874: .word 0x0000FFFF
_020CB878: .word sub_20CA7C4
	arm_func_end sub_20CB61C

	arm_func_start sub_20CB87C
sub_20CB87C: // 0x020CB87C
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020CB930 // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CB8A8
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CB8A8:
	add r1, r1, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #3
	beq _020CB8FC
	cmp r1, #6
	beq _020CB8CC
	cmp r1, #7
	beq _020CB8EC
	b _020CB90C
_020CB8CC:
	mov r0, #7
	bl sub_20CAC94
	ldr r0, _020CB930 // =0x021471EC
	mov r1, #4
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CB91C
_020CB8EC:
	bl OS_RestoreInterrupts
	mov r0, #2
	ldmia sp!, {r4, lr}
	bx lr
_020CB8FC:
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_020CB90C:
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CB91C:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CB930: .word 0x021471EC
	arm_func_end sub_20CB87C

	arm_func_start sub_20CB934
sub_20CB934: // 0x020CB934
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl OS_DisableInterrupts
	ldr r1, _020CBAE0 // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CB974
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB974:
	add r1, r1, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #3
	beq _020CB9FC
	cmp r1, #5
	beq _020CB998
	cmp r1, #6
	beq _020CB9C0
	b _020CB9E8
_020CB998:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl sub_20CAEAC
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB9C0:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl sub_20CAEAC
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB9E8:
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CB9FC:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl sub_20CAEAC
	ldr r0, _020CBAE0 // =0x021471EC
	ldr r0, [r0]
	add r1, r0, #0x2200
	add r0, r0, #0x2000
	ldrh r1, [r1, #0x8c]
	ldr r0, [r0, #0x288]
	bl DC_InvalidateRange
	ldr r3, _020CBAE0 // =0x021471EC
	ldr r2, _020CBAE4 // =0x00002288
	ldr r1, [r3]
	ldr r0, _020CBAE8 // =sub_20CA4C4
	add r1, r1, #0x2000
	ldr r5, [r1, #0x284]
	add r5, r5, #1
	str r5, [r1, #0x284]
	ldr r1, [r3]
	add r1, r1, r2
	bl sub_20F27B8
	cmp r0, #2
	beq _020CBA70
	cmp r0, #3
	beq _020CBAA8
	cmp r0, #8
	beq _020CBA90
	b _020CBAA8
_020CBA70:
	mov r0, #5
	bl sub_20CAC94
	ldr r0, _020CBAE0 // =0x021471EC
	mov r1, #3
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CBAC8
_020CBA90:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CBAA8:
	mov r0, #0xb
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #7
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020CBAC8:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020CBAE0: .word 0x021471EC
_020CBAE4: .word 0x00002288
_020CBAE8: .word sub_20CA4C4
	arm_func_end sub_20CB934

	arm_func_start sub_20CBAEC
sub_20CBAEC: // 0x020CBAEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	beq _020CBB04
	cmp r1, #0
	bne _020CBB14
_020CBB04:
	bl sub_20CB87C
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
_020CBB14:
	bl sub_20CB934
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20CBAEC

	arm_func_start sub_20CBB24
sub_20CBB24: // 0x020CBB24
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	ldr r1, _020CBC28 // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CBB50
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CBB50:
	add r1, r1, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #1
	beq _020CBB80
	cmp r1, #3
	beq _020CBBA0
	cmp r1, #4
	bne _020CBB90
	bl OS_RestoreInterrupts
	mov r0, #2
	ldmia sp!, {r4, lr}
	bx lr
_020CBB80:
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, lr}
	bx lr
_020CBB90:
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
_020CBBA0:
	ldr r0, _020CBC2C // =sub_20CA7C4
	bl sub_20F2D48
	cmp r0, #2
	beq _020CBBC4
	cmp r0, #3
	beq _020CBBF8
	cmp r0, #8
	beq _020CBBE4
	b _020CBBF8
_020CBBC4:
	mov r0, #4
	bl sub_20CAC94
	ldr r0, _020CBC28 // =0x021471EC
	mov r1, #2
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CBC14
_020CBBE4:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #4
	ldmia sp!, {r4, lr}
	bx lr
_020CBBF8:
	mov r0, #0xb
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, lr}
	bx lr
_020CBC14:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CBC28: .word 0x021471EC
_020CBC2C: .word sub_20CA7C4
	arm_func_end sub_20CBB24

	arm_func_start sub_20CBC30
sub_20CBC30: // 0x020CBC30
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl OS_DisableInterrupts
	ldr r1, _020CBE5C // =0x021471EC
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _020CBC64
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBC64:
	add r1, r1, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #1
	beq _020CBC88
	cmp r1, #2
	beq _020CBC98
	cmp r1, #3
	beq _020CBCA8
	b _020CBCB8
_020CBC88:
	mov r0, r6
	mov r1, r5
	bl sub_20CB064
	b _020CBCC8
_020CBC98:
	bl OS_RestoreInterrupts
	mov r0, #2
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBCA8:
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBCB8:
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBCC8:
	ldr r0, _020CBE5C // =0x021471EC
	ldr r0, [r0]
	add r1, r0, #0x2000
	ldr r1, [r1, #0x26c]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	bl sub_20F1D60
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _020CBD3C
_020CBCF0: // jump table
	b _020CBD58 // case 0
	b _020CBD3C // case 1
	b _020CBD3C // case 2
	b _020CBD0C // case 3
	b _020CBD28 // case 4
	b _020CBD3C // case 5
	b _020CBD3C // case 6
_020CBD0C:
	mov r0, #0xb
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBD28:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBD3C:
	mov r0, #0xb
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBD58:
	bl WM_GetAllowedChannel
	cmp r0, #0
	bne _020CBDA0
	bl sub_20F1AE4
	cmp r0, #0
	beq _020CBD8C
	mov r0, #0xb
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBD8C:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBDA0:
	ldr r0, _020CBE60 // =sub_20CAAD0
	bl WM_SetIndCallback
	cmp r0, #0
	beq _020CBDCC
	mov r0, #0xb
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBDCC:
	ldr r0, _020CBE64 // =sub_20CA7C4
	bl sub_20F2E20
	cmp r0, #2
	beq _020CBDF0
	cmp r0, #3
	beq _020CBE2C
	cmp r0, #8
	beq _020CBE10
	b _020CBE2C
_020CBDF0:
	mov r0, #2
	bl sub_20CAC94
	ldr r0, _020CBE5C // =0x021471EC
	mov r1, #1
	ldr r0, [r0]
	add r0, r0, #0x2200
	strh r1, [r0, #0x80]
	b _020CBE48
_020CBE10:
	mov r0, #0xc
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBE2C:
	mov r0, #0xb
	bl sub_20CAC94
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #7
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBE48:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #3
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020CBE5C: .word 0x021471EC
_020CBE60: .word sub_20CAAD0
_020CBE64: .word sub_20CA7C4
	arm_func_end sub_20CBC30

	arm_func_start sub_20CBE68
sub_20CBE68: // 0x020CBE68
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	ldr r2, _020CBED8 // =0x021471EC
	ldr r1, [r2]
	cmp r1, #0
	bne _020CBE98
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {lr}
	bx lr
_020CBE98:
	add r1, r1, #0x2000
	ldr r1, [r1, #0x260]
	cmp r1, #1
	beq _020CBEBC
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {lr}
	bx lr
_020CBEBC:
	mov r1, #0
	str r1, [r2]
	bl OS_RestoreInterrupts
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CBED8: .word 0x021471EC
	arm_func_end sub_20CBE68

	arm_func_start sub_20CBEDC
sub_20CBEDC: // 0x020CBEDC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl OS_DisableInterrupts
	ldr r2, _020CC004 // =0x021471EC
	mov r4, r0
	ldr r1, [r2]
	cmp r1, #0
	beq _020CBF10
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBF10:
	cmp r6, #0
	bne _020CBF28
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBF28:
	ands r1, r6, #0x1f
	beq _020CBF40
	bl OS_RestoreInterrupts
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBF40:
	cmp r5, #0x2300
	bhs _020CBF58
	bl OS_RestoreInterrupts
	mov r0, #6
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
_020CBF58:
	str r6, [r2]
	add r0, r6, #0x2000
	mov r1, #1
	str r1, [r0, #0x260]
	ldr r1, [r2]
	mov r0, #0
	add r1, r1, #0x2200
	strh r0, [r1, #0x80]
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r0, [r1, #0x68]
	ldr r1, [r2]
	add r1, r1, #0x2000
	strb r0, [r1, #0x26a]
	ldr r1, [r2]
	add r1, r1, #0x2000
	strb r0, [r1, #0x26b]
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r0, [r1, #0x82]
	ldr r1, [r2]
	add r1, r1, #0x2200
	strh r0, [r1, #0xf8]
	bl sub_20CAE8C
	bl sub_20CC9D8
	bl OS_IsTickAvailable
	cmp r0, #0
	bne _020CBFCC
	bl OS_InitTick
_020CBFCC:
	bl OS_IsAlarmAvailable
	cmp r0, #0
	bne _020CBFDC
	bl OS_InitAlarm
_020CBFDC:
	ldr r1, _020CC004 // =0x021471EC
	ldr r0, _020CC008 // =0x000022CC
	ldr r1, [r1]
	add r0, r1, r0
	bl OS_CreateAlarm
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	.align 2, 0
_020CC004: .word 0x021471EC
_020CC008: .word 0x000022CC
	arm_func_end sub_20CBEDC

	arm_func_start sub_20CC00C
sub_20CC00C: // 0x020CC00C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20CB194
	add r1, r0, #0x2000
	cmp r4, #0
	ldr r0, [r1, #0x270]
	ldmeqia sp!, {r4, lr}
	bxeq lr
	cmp r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r1, [r1, #0x274]
	cmp r1, #0xc
	ldmlsia sp!, {r4, lr}
	bxls lr
	ldr r3, [r0, #4]
	cmp r3, #0
	beq _020CC09C
_020CC054:
	cmp r3, r4
	bne _020CC090
	ldr r2, [r3, #8]
	cmp r2, #0
	ldrne r1, [r3, #0xc]
	strne r1, [r2, #0xc]
	ldreq r1, [r3, #0xc]
	streq r1, [r0, #4]
	ldr r2, [r3, #0xc]
	cmp r2, #0
	ldrne r1, [r3, #8]
	strne r1, [r2, #8]
	ldreq r1, [r3, #8]
	streq r1, [r0, #8]
	b _020CC09C
_020CC090:
	ldr r3, [r3, #0xc]
	cmp r3, #0
	bne _020CC054
_020CC09C:
	mov r1, #0
	str r1, [r4, #0xc]
	ldr r1, [r0, #8]
	str r1, [r4, #8]
	str r4, [r0, #8]
	ldr r1, [r4, #8]
	cmp r1, #0
	strne r4, [r1, #0xc]
	streq r4, [r0, #4]
	cmp r3, #0
	ldreq r1, [r0]
	streq r1, [r4, #4]
	ldreq r1, [r0]
	addeq r1, r1, #1
	streq r1, [r0]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20CC00C

	arm_func_start sub_20CC0E0
sub_20CC0E0: // 0x020CC0E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20CB194
	add r1, r0, #0x2000
	ldr r2, [r1, #0x270]
	mov r0, #0
	cmp r2, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r1, [r1, #0x274]
	cmp r1, #0xc
	ldmlsia sp!, {r4, lr}
	bxls lr
	ldr r0, [r2, #4]
	cmp r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
_020CC124:
	ldr r1, [r0, #4]
	cmp r1, r4
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _020CC124
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20CC0E0

	arm_func_start sub_20CC148
sub_20CC148: // 0x020CC148
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl sub_20CB194
	add r0, r0, #0x2000
	cmp r5, #0
	mov r4, #0
	ldr r1, [r0, #0x270]
	addeq sp, sp, #4
	moveq r0, r4
	ldmeqia sp!, {r4, r5, lr}
	bxeq lr
	cmp r1, #0
	beq _020CC1BC
	ldr r0, [r0, #0x274]
	cmp r0, #0xc
	bls _020CC1BC
	ldr r4, [r1, #4]
	cmp r4, #0
	beq _020CC1BC
_020CC198:
	add r0, r4, #0x10
	mov r1, r5
	add r0, r0, #4
	bl sub_20CCBD4
	cmp r0, #0
	bne _020CC1BC
	ldr r4, [r4, #0xc]
	cmp r4, #0
	bne _020CC198
_020CC1BC:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20CC148

	arm_func_start sub_20CC1CC
sub_20CC1CC: // 0x020CC1CC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20CB194
	add r0, r0, #0x2000
	ldr r1, [r0, #0x270]
	cmp r1, #0
	beq _020CC200
	ldr r0, [r0, #0x274]
	cmp r0, #0xc
	addhi sp, sp, #4
	ldrhi r0, [r1, #4]
	ldmhiia sp!, {lr}
	bxhi lr
_020CC200:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20CC1CC

	arm_func_start sub_20CC210
sub_20CC210: // 0x020CC210
	stmdb sp!, {r4, lr}
	bl sub_20CB194
	add r2, r0, #0x2000
	ldr r1, [r2, #0x270]
	mov r0, #0
	cmp r1, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r3, [r2, #0x274]
	cmp r3, #0xc
	ldmlsia sp!, {r4, lr}
	bxls lr
	ldr r2, _020CC2F0 // =0x4EC4EC4F
	sub r3, r3, #0xc
	umull r2, r4, r3, r2
	movs r4, r4, lsr #6
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r2, [r1]
	cmp r4, r2
	ldmlsia sp!, {r4, lr}
	bxls lr
	mov lr, r0
	cmp r4, #0
	bls _020CC29C
	add ip, r1, #0xc
	mov r2, #0xd0
_020CC27C:
	mul r0, lr, r2
	ldrb r3, [ip, r0]
	add r0, ip, r0
	cmp r3, #0
	beq _020CC29C
	add lr, lr, #1
	cmp lr, r4
	blo _020CC27C
_020CC29C:
	cmp lr, r4
	ldmhsia sp!, {r4, lr}
	bxhs lr
	mov r2, #1
	strb r2, [r0]
	ldr r3, [r1]
	mov r2, #0
	str r3, [r0, #4]
	str r2, [r0, #0xc]
	ldr r2, [r1, #8]
	str r2, [r0, #8]
	str r0, [r1, #8]
	ldr r2, [r0, #8]
	cmp r2, #0
	strne r0, [r2, #0xc]
	streq r0, [r1, #4]
	ldr r2, [r1]
	add r2, r2, #1
	str r2, [r1]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CC2F0: .word 0x4EC4EC4F
	arm_func_end sub_20CC210

	arm_func_start sub_20CC2F4
sub_20CC2F4: // 0x020CC2F4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl sub_20CB194
	movs r7, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	add r0, r7, #0x2000
	ldrb r0, [r0, #0x26a]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	ldrh r0, [r5, #0x3c]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, lr}
	bxne lr
	add r0, r5, #4
	bl sub_20CC148
	movs r6, r0
	bne _020CC35C
	bl sub_20CC210
	mov r6, r0
_020CC35C:
	cmp r6, #0
	bne _020CC37C
	add r0, r7, #0x2000
	ldr r0, [r0, #0x278]
	cmp r0, #1
	bne _020CC37C
	bl sub_20CC1CC
	mov r6, r0
_020CC37C:
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r5
	add r1, r6, #0x10
	mov r2, #0xc0
	strh r4, [r6, #2]
	bl MIi_CpuCopyFast
	mov r0, r6
	bl sub_20CC00C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end sub_20CC2F4

	arm_func_start sub_20CC3B4
sub_20CC3B4: // 0x020CC3B4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl OS_DisableInterrupts
	mov r5, r0
	bl sub_20CB194
	cmp r0, #0
	bne _020CC3EC
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CC3EC:
	mov r0, r4
	bl sub_20CC0E0
	movs r4, r0
	bne _020CC414
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CC414:
	mov r0, r5
	bl OS_RestoreInterrupts
	add r0, r4, #0x10
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20CC3B4

	arm_func_start sub_20CC42C
sub_20CC42C: // 0x020CC42C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl OS_DisableInterrupts
	mov r4, r0
	bl sub_20CB194
	cmp r0, #0
	bne _020CC464
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CC464:
	cmp r5, #0
	beq _020CC490
	add r1, r0, #0x2000
	ldrb r1, [r1, #0x26a]
	add r0, r0, #0x2000
	cmp r1, #0
	movne r5, #1
	mov r1, #1
	moveq r5, #0
	strb r1, [r0, #0x26a]
	b _020CC4B0
_020CC490:
	add r1, r0, #0x2000
	ldrb r1, [r1, #0x26a]
	add r0, r0, #0x2000
	cmp r1, #0
	movne r5, #1
	mov r1, #0
	moveq r5, #0
	strb r1, [r0, #0x26a]
_020CC4B0:
	mov r0, r4
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20CC42C

	arm_func_start sub_20CC4C8
sub_20CC4C8: // 0x020CC4C8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	mov r5, r0
	bl sub_20CB194
	cmp r0, #0
	mov r4, #0
	bne _020CC500
	mov r0, r5
	bl OS_RestoreInterrupts
	add sp, sp, #4
	mov r0, r4
	ldmia sp!, {r4, r5, lr}
	bx lr
_020CC500:
	add r0, r0, #0x2000
	ldr r1, [r0, #0x270]
	cmp r1, #0
	beq _020CC51C
	ldr r0, [r0, #0x274]
	cmp r0, #0xc
	ldrhi r4, [r1]
_020CC51C:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end sub_20CC4C8

	arm_func_start sub_20CC534
sub_20CC534: // 0x020CC534
	stmdb sp!, {r4, lr}
	bl OS_DisableInterrupts
	mov r4, r0
	bl sub_20CB194
	cmp r0, #0
	bne _020CC55C
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
_020CC55C:
	add r1, r0, #0x2000
	ldr r0, [r1, #0x270]
	cmp r0, #0
	beq _020CC580
	ldr r2, [r1, #0x274]
	cmp r2, #0
	ble _020CC580
	mov r1, #0
	bl MI_CpuFill8
_020CC580:
	mov r0, r4
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end sub_20CC534

	arm_func_start sub_20CC590
sub_20CC590: // 0x020CC590
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0, #8]
	ldr r1, _020CC5E8 // =OS_IrqHandler
	cmp r2, r1
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r1, [r0, #0xc]
	sub r1, r1, #1
	str r1, [r0, #0xc]
	ldr r1, [r0, #0xc]
	cmp r1, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	mov r1, #0
	str r1, [r0, #8]
	bl OS_WakeupThread
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CC5E8: .word OS_IrqHandler
	arm_func_end sub_20CC590

	arm_func_start sub_20CC5EC
sub_20CC5EC: // 0x020CC5EC
	ldr r2, [r0, #8]
	cmp r2, #0
	bne _020CC614
	ldr r1, _020CC634 // =OS_IrqHandler
	str r1, [r0, #8]
	ldr r1, [r0, #0xc]
	add r1, r1, #1
	str r1, [r0, #0xc]
	mov r0, #1
	bx lr
_020CC614:
	ldr r1, _020CC634 // =OS_IrqHandler
	cmp r2, r1
	ldreq r1, [r0, #0xc]
	addeq r1, r1, #1
	streq r1, [r0, #0xc]
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_020CC634: .word OS_IrqHandler
	arm_func_end sub_20CC5EC

	arm_func_start sub_20CC638
sub_20CC638: // 0x020CC638
	ldr ip, _020CC644 // =sub_20CC590
	ldr r0, _020CC648 // =0x021471FC
	bx ip
	.align 2, 0
_020CC644: .word sub_20CC590
_020CC648: .word 0x021471FC
	arm_func_end sub_20CC638

	arm_func_start sub_20CC64C
sub_20CC64C: // 0x020CC64C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh r1, [r0]
	cmp r1, #0x12
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldrh r2, [r0, #2]
	ldr r1, _020CC698 // =0x021471F0
	str r2, [r1, #0x24]
	ldrh r0, [r0, #2]
	cmp r0, #0
	bne _020CC684
	bl sub_20CAC18
_020CC684:
	ldr r0, _020CC69C // =0x021471F4
	bl OS_WakeupThread
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CC698: .word 0x021471F0
_020CC69C: .word 0x021471F4
	arm_func_end sub_20CC64C

	arm_func_start sub_20CC6A0
sub_20CC6A0: // 0x020CC6A0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, r2
	bl OS_DisableInterrupts
	mov r5, r0
	bl sub_20CB194
	cmp r0, #0
	bne _020CC6D8
	mov r0, r5
	bl OS_RestoreInterrupts
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CC6D8:
	ldr r0, _020CC808 // =0x021471FC
	bl OS_LockMutex
	bl sub_20CB194
	movs r4, r0
	bne _020CC708
	ldr r0, _020CC808 // =0x021471FC
	bl OS_UnlockMutex
	mov r0, r5
	bl OS_RestoreInterrupts
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CC708:
	add r0, r4, #0x2000
	ldr r1, [r0, #0x260]
	cmp r1, #9
	bne _020CC724
	ldrb r0, [r0, #0x26b]
	cmp r0, #1
	bne _020CC740
_020CC724:
	ldr r0, _020CC808 // =0x021471FC
	bl OS_UnlockMutex
	mov r0, r5
	bl OS_RestoreInterrupts
	mvn r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CC740:
	mov r0, r7
	mov r2, r6
	add r1, r4, #0xf00
	bl MI_CpuCopy8
	mov r3, r6, lsl #0x10
	ldr r0, _020CC80C // =sub_20CC64C
	mov r1, r8
	add r2, r4, #0xf00
	mov r3, r3, lsr #0x10
	bl sub_20F3390
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _020CC798
_020CC774: // jump table
	b _020CC798 // case 0
	b _020CC798 // case 1
	b _020CC7B4 // case 2
	b _020CC798 // case 3
	b _020CC798 // case 4
	b _020CC798 // case 5
	b _020CC798 // case 6
	b _020CC798 // case 7
	b _020CC798 // case 8
_020CC798:
	ldr r0, _020CC808 // =0x021471FC
	bl OS_UnlockMutex
	mov r0, r5
	bl OS_RestoreInterrupts
	mvn r0, #4
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CC7B4:
	ldr r0, _020CC810 // =0x021471F4
	bl OS_SleepThread
	ldr r0, _020CC814 // =0x021471F0
	ldr r0, [r0, #0x24]
	cmp r0, #0
	beq _020CC7EC
	cmp r0, #1
	ldr r0, _020CC808 // =0x021471FC
	bl OS_UnlockMutex
	mov r0, r5
	bl OS_RestoreInterrupts
	mvn r0, #4
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
_020CC7EC:
	ldr r0, _020CC808 // =0x021471FC
	bl OS_UnlockMutex
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r6
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_020CC808: .word 0x021471FC
_020CC80C: .word sub_20CC64C
_020CC810: .word 0x021471F4
_020CC814: .word 0x021471F0
	arm_func_end sub_20CC6A0

	arm_func_start sub_20CC818
sub_20CC818: // 0x020CC818
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_DisableInterrupts
	ldr r1, _020CC838 // =0x021471F0
	str r4, [r1, #0x28]
	bl OS_RestoreInterrupts
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CC838: .word 0x021471F0
	arm_func_end sub_20CC818

	arm_func_start sub_20CC83C
sub_20CC83C: // 0x020CC83C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, #0
	mov r4, r0
	mov r6, r7
	bl sub_20CB194
	mov r5, r0
	bl OS_DisableInterrupts
	cmp r5, #0
	beq _020CC88C
	add r1, r5, #0x2000
	ldr r2, [r1, #0x260]
	cmp r2, #9
	bne _020CC88C
	ldrb r1, [r1, #0x26b]
	cmp r1, #0
	addeq r2, r5, #0x2100
	ldreq r1, _020CC8A8 // =0x0000214C
	ldreqh r6, [r2, #0x4a]
	addeq r7, r5, r1
_020CC88C:
	bl OS_RestoreInterrupts
	cmp r4, #0
	strneh r6, [r4]
	mov r0, r7
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020CC8A8: .word 0x0000214C
	arm_func_end sub_20CC83C

	arm_func_start sub_20CC8AC
sub_20CC8AC: // 0x020CC8AC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, #0
	bl sub_20CB194
	mov r4, r0
	bl OS_DisableInterrupts
	cmp r4, #0
	beq _020CC8EC
	add r1, r4, #0x2000
	ldr r2, [r1, #0x260]
	cmp r2, #9
	bne _020CC8EC
	ldrb r1, [r1, #0x26b]
	cmp r1, #0
	ldreq r1, _020CC900 // =0x00002144
	addeq r5, r4, r1
_020CC8EC:
	bl OS_RestoreInterrupts
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020CC900: .word 0x00002144
	arm_func_end sub_20CC8AC

	arm_func_start sub_20CC904
sub_20CC904: // 0x020CC904
	stmdb sp!, {r4, lr}
	bl sub_20CB194
	movs r4, r0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	add r0, r4, #0x2000
	ldr r1, [r0, #0x260]
	cmp r1, #9
	ldmneia sp!, {r4, lr}
	bxne lr
	ldrb r0, [r0, #0x26b]
	cmp r0, #1
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, _020CC984 // =0x021471FC
	bl sub_20CC5EC
	cmp r0, #0
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r1, _020CC988 // =0x00002144
	ldr r0, _020CC98C // =sub_20CC638
	add r1, r4, r1
	add r2, r4, #0xf00
	mov r3, #0
	bl sub_20F3390
	cmp r0, #2
	ldmeqia sp!, {r4, lr}
	bxeq lr
	ldr r0, _020CC984 // =0x021471FC
	bl sub_20CC590
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020CC984: .word 0x021471FC
_020CC988: .word 0x00002144
_020CC98C: .word sub_20CC638
	arm_func_end sub_20CC904

	arm_func_start sub_20CC990
sub_20CC990: // 0x020CC990
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020CC9D4 // =0x021471F0
	mov r2, r0
	ldr ip, [r1, #0x28]
	cmp ip, #0
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	bxeq lr
	ldrh r3, [r2, #6]
	add r0, r2, #0x1e
	add r1, r2, #0x18
	add r2, r2, #0x2c
	blx ip
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CC9D4: .word 0x021471F0
	arm_func_end sub_20CC990

	arm_func_start sub_20CC9D8
sub_20CC9D8: // 0x020CC9D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020CCA24 // =0x021471F0
	ldrb r0, [r1]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	ldr r0, _020CCA28 // =0x021471FC
	mov r2, #0
	mov r3, #1
	strb r3, [r1]
	str r2, [r1, #0x24]
	str r2, [r1, #8]
	str r2, [r1, #4]
	bl OS_InitMutex
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CCA24: .word 0x021471F0
_020CCA28: .word 0x021471FC
	arm_func_end sub_20CC9D8

	arm_func_start sub_20CCA2C
sub_20CCA2C: // 0x020CCA2C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, _020CCAA4 // =0x0214721C
	ands r1, r0, #2
	ldrb ip, [r2]
	movne r0, r0, asr #2
	andne lr, r0, #0xff
	moveq r0, r0, asr #2
	addeq r0, r0, #0x19
	andeq lr, r0, #0xff
	mov r1, ip, lsr #0x1f
	rsb r0, r1, ip, lsl #28
	cmp ip, #0x10
	ldr r3, _020CCAA8 // =0x02147220
	add r0, r1, r0, ror #28
	strb lr, [r3, r0]
	addlo r0, ip, #1
	strlob r0, [r2]
	addlo sp, sp, #4
	ldmloia sp!, {lr}
	bxlo lr
	add r0, ip, #1
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #28
	add r0, r1, r0, ror #28
	add r0, r0, #0x10
	strb r0, [r2]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CCAA4: .word 0x0214721C
_020CCAA8: .word 0x02147220
	arm_func_end sub_20CCA2C

	arm_func_start sub_20CCAAC
sub_20CCAAC: // 0x020CCAAC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20CCAEC
	mov r1, #0
	cmp r0, #0x1c
	movhs r1, #3
	bhs _020CCADC
	cmp r0, #0x16
	movhs r1, #2
	bhs _020CCADC
	cmp r0, #0x10
	movhs r1, #1
_020CCADC:
	mov r0, r1
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end sub_20CCAAC

	arm_func_start sub_20CCAEC
sub_20CCAEC: // 0x020CCAEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020CCB7C // =0x0214721C
	mov r0, #0
	ldrb r1, [r1]
	cmp r1, #0x10
	bls _020CCB38
	ldr r2, _020CCB80 // =0x02147220
	mov r3, r0
_020CCB10:
	ldrb r1, [r2]
	add r3, r3, #1
	cmp r3, #0x10
	add r0, r0, r1
	add r2, r2, #1
	blt _020CCB10
	mov r1, r0, asr #3
	add r0, r0, r1, lsr #28
	mov r0, r0, asr #4
	b _020CCB6C
_020CCB38:
	cmp r1, #0
	beq _020CCB6C
	mov r3, r0
	cmp r1, #0
	ble _020CCB68
	ldr ip, _020CCB80 // =0x02147220
_020CCB50:
	ldrb r2, [ip]
	add r3, r3, #1
	cmp r3, r1
	add r0, r0, r2
	add ip, ip, #1
	blt _020CCB50
_020CCB68:
	bl _s32_div_f
_020CCB6C:
	and r0, r0, #0xff
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020CCB7C: .word 0x0214721C
_020CCB80: .word 0x02147220
	arm_func_end sub_20CCAEC

	arm_func_start WCM_GetLinkLevel
WCM_GetLinkLevel: // 0x020CCB84
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl OS_DisableInterrupts
	mov r5, r0
	bl sub_20CB194
	cmp r0, #0
	mov r4, #0
	beq _020CCBBC
	add r0, r0, #0x2000
	ldr r0, [r0, #0x260]
	cmp r0, #9
	bne _020CCBBC
	bl sub_20CCAAC
	mov r4, r0
_020CCBBC:
	mov r0, r5
	bl OS_RestoreInterrupts
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end WCM_GetLinkLevel

	arm_func_start sub_20CCBD4
sub_20CCBD4: // 0x020CCBD4
	mov ip, #0
_020CCBD8:
	ldrb r3, [r0, ip]
	ldrb r2, [r1, ip]
	cmp r3, r2
	movne r0, #0
	bxne lr
	add ip, ip, #1
	cmp ip, #6
	blt _020CCBD8
	mov r0, #1
	bx lr
	arm_func_end sub_20CCBD4

	arm_func_start sub_20CCC00
sub_20CCC00: // 0x020CCC00
	ldr ip, _020CCC08 // =DGT_Hash1GetDigest_R
	bx ip
	.align 2, 0
_020CCC08: .word DGT_Hash1GetDigest_R
	arm_func_end sub_20CCC00

	arm_func_start sub_20CCC0C
sub_20CCC0C: // 0x020CCC0C
	ldr ip, _020CCC14 // =DGT_Hash1SetSource
	bx ip
	.align 2, 0
_020CCC14: .word DGT_Hash1SetSource
	arm_func_end sub_20CCC0C

	arm_func_start sub_20CCC18
sub_20CCC18: // 0x020CCC18
	ldr ip, _020CCC20 // =DGT_Hash1Reset
	bx ip
	.align 2, 0
_020CCC20: .word DGT_Hash1Reset
	arm_func_end sub_20CCC18