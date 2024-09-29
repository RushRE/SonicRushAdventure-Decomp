	.include "asm/macros.inc"
	.include "global.inc"

	.text

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
	bl STD_CopyLString
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
