	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start DWCi_RankingValidateKey
DWCi_RankingValidateKey: // 0x0209E4F4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr ip, _0209E5FC // =_0211C3EC
	mov lr, #0
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	str lr, [ip, #8]
	bl strlen
	cmp r0, #0x20
	addhs sp, sp, #4
	movhs r0, #0
	ldmhsia sp!, {r4, r5, r6, r7, pc}
	mov r0, r6
	bl strlen
	cmp r0, #0x14
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	sub r0, r5, #5
	ands r0, r0, #7
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ands r0, r4, #1
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r2, #0
	mov r3, r2
	ldr r0, [sp, #0x18]
_0209E574:
	mov r1, r0, lsr r3
	and r1, r1, #1
	cmp r1, #1
	add r3, r3, #1
	addeq r2, r2, #1
	cmp r3, #0x20
	blt _0209E574
	cmp r2, #1
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0209E600 // =0x0211C3F8
	mov r1, r7
	mov r2, #0x20
	bl memcpy
	ldr r3, _0209E604 // =0x0211C418
	mov r2, #0xa
_0209E5B8:
	ldrb r1, [r6], #1
	ldrb r0, [r6], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _0209E5B8
	ldr r1, _0209E5FC // =_0211C3EC
	ldr r3, [sp, #0x18]
	ldr r2, [sp, #0x1c]
	mov r0, #1
	str r5, [r1, #0x40]
	str r4, [r1, #0x44]
	str r3, [r1, #0x48]
	str r2, [r1, #0x4c]
	str r0, [r1, #8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209E5FC: .word _0211C3EC
_0209E600: .word 0x0211C3F8
_0209E604: .word 0x0211C418
	arm_func_end DWCi_RankingValidateKey

	arm_func_start DWCi_RankingSessionGetAsync
DWCi_RankingSessionGetAsync: // 0x0209E608
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x4c
	ldr r4, _0209E83C // =_0211C3EC
	mov r10, r0
	ldr r0, [r4, #8]
	ldr r6, [sp, #0x70]
	cmp r0, #1
	mov r9, r1
	mov r8, r2
	mov r7, r3
	addne sp, sp, #0x4c
	movne r0, #3
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r4, #0x50]
	cmp r1, #0
	beq _0209E660
	mov r0, #0
	mov r2, r0
	bl DWC_Free
	mov r0, r4
	mov r1, #0
	str r1, [r0, #0x50]
_0209E660:
	ldr r0, [r6]
	add r0, r0, #0x18
	bl sub_209F0A8
	mov r5, r0
	ldr r0, _0209E840 // =aData_0
	bl strlen
	mov r4, r0
	ldr r0, _0209E844 // =a00000000000000
	bl strlen
	mov r11, r0
	ldr r0, _0209E848 // =aHash
	bl strlen
	str r0, [sp, #0x10]
	mov r0, r8
	add r1, sp, #0x38
	mov r2, #0xa
	bl itoa
	bl strlen
	str r0, [sp, #0x14]
	ldr r0, _0209E84C // =aPid
	bl strlen
	str r0, [sp, #0x18]
	ldr r0, _0209E850 // =aWebClientGetAs
	bl strlen
	str r0, [sp, #0x1c]
	ldr r0, _0209E854 // =0x02144D1C
	ldr r0, [r0]
	bl strlen
	str r0, [sp, #0x20]
	ldr r0, _0209E858 // =0x0211C3F8
	bl strlen
	ldr r1, [sp, #0x20]
	add r1, r1, r0
	ldr r0, [sp, #0x1c]
	add r1, r0, r1
	ldr r0, [sp, #0x18]
	add r1, r0, r1
	ldr r0, [sp, #0x14]
	add r1, r0, r1
	ldr r0, [sp, #0x10]
	add r0, r0, r1
	add r0, r11, r0
	add r0, r4, r0
	add r0, r5, r0
	add r1, r0, #1
	mov r0, #0
	bl DWC_Alloc
	ldr r1, _0209E83C // =_0211C3EC
	cmp r0, #0
	str r0, [r1, #0x50]
	addeq sp, sp, #0x4c
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, _0209E850 // =aWebClientGetAs
	ldr r1, _0209E844 // =a00000000000000
	str r2, [sp]
	str r8, [sp, #4]
	str r1, [sp, #8]
	ldr r2, _0209E85C // =_0211C4C4
	ldr r1, _0209E854 // =0x02144D1C
	str r2, [sp, #0xc]
	ldr r2, [r1]
	ldr r1, _0209E860 // =aSSSPidDHashSDa
	ldr r3, _0209E858 // =0x0211C3F8
	bl sprintf
	ldr r0, _0209E83C // =_0211C3EC
	ldr r4, [r0, #0x50]
	mov r0, r4
	bl strlen
	add r2, r4, r0
	ldr r1, _0209E83C // =_0211C3EC
	ldr r0, _0209E840 // =aData_0
	str r2, [r1, #0x58]
	bl strlen
	mov r4, r0
	ldr r0, _0209E844 // =a00000000000000
	bl strlen
	ldr r5, _0209E83C // =_0211C3EC
	str r8, [sp, #0x24]
	ldr r3, [r5, #0x58]
	str r7, [sp, #0x28]
	sub r3, r3, r4
	sub r0, r3, r0
	str r9, [sp, #0x2c]
	str r10, [sp, #0x30]
	str r0, [r5, #0x54]
	ldr r0, [r6]
	add r1, sp, #0x24
	str r0, [sp, #0x34]
	ldr r0, [r6]
	mov r2, #0x14
	str r0, [sp]
	ldr r0, [r5, #0x58]
	add r3, r6, #4
	bl sub_209ECF4
	cmp r0, #2
	bne _0209E810
	mov r1, r5
	mov r0, #0
	ldr r1, [r1, #0x50]
	mov r2, r0
	bl DWC_Free
	mov r0, r5
	mov r1, #0
	str r1, [r0, #0x50]
	add sp, sp, #0x4c
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0209E810:
	ldr r0, _0209E848 // =aHash
	bl strlen
	mov r1, r5
	ldr r3, [r1, #0x54]
	mov r4, #0
	strb r4, [r3, -r0]
	mov r2, #4
	mov r0, r4
	str r2, [r1]
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0209E83C: .word _0211C3EC
_0209E840: .word aData_0
_0209E844: .word a00000000000000
_0209E848: .word aHash
_0209E84C: .word aPid
_0209E850: .word aWebClientGetAs
_0209E854: .word 0x02144D1C
_0209E858: .word 0x0211C3F8
_0209E85C: .word _0211C4C4
_0209E860: .word aSSSPidDHashSDa
	arm_func_end DWCi_RankingSessionGetAsync

	arm_func_start DWCi_RankingSessionPutAsync
DWCi_RankingSessionPutAsync: // 0x0209E864
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x44
	ldr r4, _0209EA8C // =_0211C3EC
	mov r10, r0
	ldr r0, [r4, #8]
	mov r9, r1
	cmp r0, #1
	mov r8, r2
	mov r7, r3
	addne sp, sp, #0x44
	movne r0, #3
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r4, #0x50]
	cmp r1, #0
	beq _0209E8B8
	mov r0, #0
	mov r2, r0
	bl DWC_Free
	mov r0, r4
	mov r1, #0
	str r1, [r0, #0x50]
_0209E8B8:
	ldr r0, [sp, #0x6c]
	add r0, r0, #0x18
	bl sub_209F0A8
	mov r6, r0
	ldr r0, _0209EA90 // =aData_0
	bl strlen
	mov r5, r0
	ldr r0, _0209EA94 // =a00000000000000
	bl strlen
	mov r4, r0
	ldr r0, _0209EA98 // =aHash
	bl strlen
	mov r11, r0
	mov r0, r9
	add r1, sp, #0x34
	mov r2, #0xa
	bl itoa
	bl strlen
	str r0, [sp, #0x10]
	ldr r0, _0209EA9C // =aPid
	bl strlen
	str r0, [sp, #0x14]
	ldr r0, _0209EAA0 // =aWebClientPutAs
	bl strlen
	str r0, [sp, #0x18]
	ldr r0, _0209EAA4 // =0x02144D1C
	ldr r0, [r0]
	bl strlen
	str r0, [sp, #0x1c]
	ldr r0, _0209EAA8 // =0x0211C3F8
	bl strlen
	ldr r1, [sp, #0x1c]
	add r1, r1, r0
	ldr r0, [sp, #0x18]
	add r1, r0, r1
	ldr r0, [sp, #0x14]
	add r1, r0, r1
	ldr r0, [sp, #0x10]
	add r0, r0, r1
	add r0, r11, r0
	add r0, r4, r0
	add r0, r5, r0
	add r0, r6, r0
	add r1, r0, #1
	mov r0, #0
	bl DWC_Alloc
	ldr r1, _0209EA8C // =_0211C3EC
	cmp r0, #0
	str r0, [r1, #0x50]
	addeq sp, sp, #0x44
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, _0209EAA0 // =aWebClientPutAs
	ldr r1, _0209EA94 // =a00000000000000
	str r2, [sp]
	str r9, [sp, #4]
	str r1, [sp, #8]
	ldr r2, _0209EAAC // =_0211C4C4
	ldr r1, _0209EAA4 // =0x02144D1C
	str r2, [sp, #0xc]
	ldr r2, [r1]
	ldr r1, _0209EAB0 // =aSSSPidDHashSDa
	ldr r3, _0209EAA8 // =0x0211C3F8
	bl sprintf
	ldr r0, _0209EA8C // =_0211C3EC
	ldr r4, [r0, #0x50]
	mov r0, r4
	bl strlen
	add r2, r4, r0
	ldr r1, _0209EA8C // =_0211C3EC
	ldr r0, _0209EA90 // =aData_0
	str r2, [r1, #0x58]
	bl strlen
	mov r4, r0
	ldr r0, _0209EA94 // =a00000000000000
	bl strlen
	ldr r1, _0209EA8C // =_0211C3EC
	ldr r2, [sp, #0x6c]
	ldr r3, [r1, #0x58]
	str r9, [sp, #0x20]
	sub r3, r3, r4
	sub r0, r3, r0
	str r8, [sp, #0x24]
	str r10, [sp, #0x28]
	str r7, [sp, #0x2c]
	str r2, [sp, #0x30]
	str r0, [r1, #0x54]
	str r2, [sp]
	ldr r0, [r1, #0x58]
	ldr r3, [sp, #0x68]
	add r1, sp, #0x20
	mov r2, #0x14
	bl sub_209ECF4
	cmp r0, #2
	bne _0209EA60
	ldr r1, _0209EA8C // =_0211C3EC
	mov r0, #0
	ldr r1, [r1, #0x50]
	mov r2, r0
	bl DWC_Free
	ldr r0, _0209EA8C // =_0211C3EC
	mov r1, #0
	str r1, [r0, #0x50]
	add sp, sp, #0x44
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0209EA60:
	ldr r0, _0209EA98 // =aHash
	bl strlen
	ldr r1, _0209EA8C // =_0211C3EC
	mov r4, #0
	ldr r3, [r1, #0x54]
	mov r2, #4
	strb r4, [r3, -r0]
	mov r0, r4
	str r2, [r1]
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0209EA8C: .word _0211C3EC
_0209EA90: .word aData_0
_0209EA94: .word a00000000000000
_0209EA98: .word aHash
_0209EA9C: .word aPid
_0209EAA0: .word aWebClientPutAs
_0209EAA4: .word 0x02144D1C
_0209EAA8: .word 0x0211C3F8
_0209EAAC: .word _0211C4C4
_0209EAB0: .word aSSSPidDHashSDa
	arm_func_end DWCi_RankingSessionPutAsync

	arm_func_start DWCi_RankingSessionGetResponse
DWCi_RankingSessionGetResponse: // 0x0209EAB4
	ldr r1, _0209EAC8 // =_0211C3EC
	ldr r2, [r1, #0x60]
	str r2, [r0]
	ldr r0, [r1, #0x5c]
	bx lr
	.align 2, 0
_0209EAC8: .word _0211C3EC
	arm_func_end DWCi_RankingSessionGetResponse

	arm_func_start DWCi_RankingSessionShutdown
DWCi_RankingSessionShutdown: // 0x0209EACC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0209EB40 // =_0211C3EC
	ldr r1, [r0, #0x50]
	cmp r1, #0
	beq _0209EAFC
	mov r0, #0
	mov r2, r0
	bl DWC_Free
	ldr r0, _0209EB40 // =_0211C3EC
	mov r1, #0
	str r1, [r0, #0x50]
_0209EAFC:
	ldr r0, _0209EB40 // =_0211C3EC
	ldr r1, [r0, #0x5c]
	cmp r1, #0
	beq _0209EB28
	mov r0, #0
	mov r2, r0
	bl DWC_Free
	ldr r0, _0209EB40 // =_0211C3EC
	mov r1, #0
	str r1, [r0, #0x60]
	str r1, [r0, #0x5c]
_0209EB28:
	bl DWC_ShutdownGHTTP
	ldr r0, _0209EB40 // =_0211C3EC
	mov r1, #2
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209EB40: .word _0211C3EC
	arm_func_end DWCi_RankingSessionShutdown

	arm_func_start DWCi_RankingSessionCancel
DWCi_RankingSessionCancel: // 0x0209EB44
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0209EB74 // =_0211C3EC
	ldr r0, [r0, #4]
	cmp r0, #0
	blt _0209EB60
	bl DWC_CancelGHTTPRequest
_0209EB60:
	ldr r0, _0209EB74 // =_0211C3EC
	mov r1, #0
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209EB74: .word _0211C3EC
	arm_func_end DWCi_RankingSessionCancel

	arm_func_start DWCi_RankingSessionProcess
DWCi_RankingSessionProcess: // 0x0209EB78
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r0, _0209EC74 // =_0211C3EC
	ldr r1, [r0]
	cmp r1, #8
	addls pc, pc, r1, lsl #2
	b _0209EC64
_0209EB94: // jump table
	b _0209EC64 // case 0
	b _0209EC64 // case 1
	b _0209EC64 // case 2
	b _0209EC64 // case 3
	b _0209EBB8 // case 4
	b _0209EBF8 // case 5
	b _0209EC10 // case 6
	b _0209EC50 // case 7
	b _0209EC64 // case 8
_0209EBB8:
	ldr r2, _0209EC78 // =sub_209EEA4
	mov r1, #0
	str r2, [sp]
	str r1, [sp, #4]
	ldr r0, [r0, #0x50]
	ldr r3, _0209EC7C // =sub_209F0A4
	mov r2, r1
	bl DWC_GetGHTTPDataEx
	ldr r1, _0209EC74 // =_0211C3EC
	cmp r0, #0
	str r0, [r1, #4]
	movge r0, #5
	strge r0, [r1]
	movlt r0, #1
	strlt r0, [r1]
	b _0209EC64
_0209EBF8:
	bl DWC_ProcessGHTTP
	cmp r0, #0
	ldreq r0, _0209EC74 // =_0211C3EC
	moveq r1, #1
	streq r1, [r0]
	b _0209EC64
_0209EC10:
	ldr r2, _0209EC78 // =sub_209EEA4
	mov r1, #0
	str r2, [sp]
	str r1, [sp, #4]
	ldr r0, [r0, #0x50]
	ldr r3, _0209EC7C // =sub_209F0A4
	mov r2, r1
	bl DWC_GetGHTTPDataEx
	ldr r1, _0209EC74 // =_0211C3EC
	cmp r0, #0
	str r0, [r1, #4]
	movge r0, #7
	strge r0, [r1]
	movlt r0, #1
	strlt r0, [r1]
	b _0209EC64
_0209EC50:
	bl DWC_ProcessGHTTP
	cmp r0, #0
	ldreq r0, _0209EC74 // =_0211C3EC
	moveq r1, #1
	streq r1, [r0]
_0209EC64:
	ldr r0, _0209EC74 // =_0211C3EC
	ldr r0, [r0]
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0209EC74: .word _0211C3EC
_0209EC78: .word sub_209EEA4
_0209EC7C: .word sub_209F0A4
	arm_func_end DWCi_RankingSessionProcess

	arm_func_start DWCi_RankingSessionInitialize
DWCi_RankingSessionInitialize: // 0x0209EC80
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0209ECE4 // =_0211C3EC
	mov r2, #0
	mvn r3, #0
	cmp r0, #0
	str r3, [r1, #4]
	str r2, [r1, #0x50]
	str r2, [r1, #0x54]
	str r2, [r1, #0x58]
	str r2, [r1, #0x5c]
	str r2, [r1, #0x60]
	ldrne r1, _0209ECE8 // =aHttpGamestats2
	ldrne r0, _0209ECEC // =0x02144D1C
	strne r1, [r0]
	ldreq r1, _0209ECF0 // =aHttpSdkdevGame
	ldreq r0, _0209ECEC // =0x02144D1C
	streq r1, [r0]
	mov r0, #0
	bl DWC_InitGHTTP
	ldr r0, _0209ECE4 // =_0211C3EC
	mov r1, #3
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209ECE4: .word _0211C3EC
_0209ECE8: .word aHttpGamestats2
_0209ECEC: .word 0x02144D1C
_0209ECF0: .word aHttpSdkdevGame
	arm_func_end DWCi_RankingSessionInitialize

	arm_func_start sub_209ECF4
sub_209ECF4: // 0x0209ECF4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r7, [sp, #0x28]
	mov r9, r2
	add r4, r7, r9
	mov r10, r1
	mov r5, #0
	mov r11, r0
	mov r0, r5
	add r1, r4, #4
	mov r8, r3
	bl DWC_Alloc
	movs r6, r0
	addeq sp, sp, #4
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r9, #0
	mov r2, r5
	bls _0209ED58
_0209ED40:
	ldrb r1, [r10, r2]
	add r0, r2, #4
	add r2, r2, #1
	strb r1, [r6, r0]
	cmp r2, r9
	blo _0209ED40
_0209ED58:
	cmp r7, #0
	mov r2, #0
	bls _0209ED80
	add r3, r6, r9
_0209ED68:
	ldrb r1, [r8, r2]
	add r0, r3, r2
	add r2, r2, #1
	strb r1, [r0, #4]
	cmp r2, r7
	blo _0209ED68
_0209ED80:
	cmp r4, #0
	mov r1, #0
	bls _0209EDA4
_0209ED8C:
	add r0, r1, #4
	ldrb r0, [r6, r0]
	add r1, r1, #1
	cmp r1, r4
	add r5, r5, r0
	blo _0209ED8C
_0209EDA4:
	mov r0, r5
	bl sub_209EE90
	cmp r4, #0
	mov r7, #0
	bls _0209EDD8
_0209EDB8:
	bl sub_209EE48
	add r2, r7, #4
	ldrb r1, [r6, r2]
	add r7, r7, #1
	cmp r7, r4
	eor r0, r1, r0
	strb r0, [r6, r2]
	blo _0209EDB8
_0209EDD8:
	ldr r0, _0209EE44 // =_0211C3EC
	add r4, r4, #4
	ldr r1, [r0, #0x4c]
	mov r0, r6
	eor r5, r5, r1
	mov r1, r5, lsr #0x18
	strb r1, [r6]
	mov r1, r5, lsr #0x10
	strb r1, [r6, #1]
	mov r1, r5, lsr #8
	strb r1, [r6, #2]
	mov r1, r11
	mov r2, r4
	mov r3, #2
	strb r5, [r6, #3]
	bl sub_20A0268
	mov r0, #0
	mov r1, r6
	mov r2, r0
	bl DWC_Free
	mov r0, r4
	bl sub_209F0A8
	mov r1, #0
	strb r1, [r11, r0]
	mov r0, r1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0209EE44: .word _0211C3EC
	arm_func_end sub_209ECF4

	arm_func_start sub_209EE48
sub_209EE48: // 0x0209EE48
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _0209EE88 // =_0211C3EC
	ldr r0, _0209EE8C // =0x02144D18
	ldr r3, [r1, #0x44]
	ldr r2, [r1, #0x40]
	ldr r0, [r0]
	ldr r1, [r1, #0x48]
	mla r0, r2, r0, r3
	bl _u32_div_f
	ldr r0, _0209EE8C // =0x02144D18
	mov r2, r1, asr #0x10
	str r1, [r0]
	and r0, r2, #0xff
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209EE88: .word _0211C3EC
_0209EE8C: .word 0x02144D18
	arm_func_end sub_209EE48

	arm_func_start sub_209EE90
sub_209EE90: // 0x0209EE90
	ldr r1, _0209EEA0 // =0x02144D18
	orr r0, r0, r0, lsl #16
	str r0, [r1]
	bx lr
	.align 2, 0
_0209EEA0: .word 0x02144D18
	arm_func_end sub_209EE90

	arm_func_start sub_209EEA4
sub_209EEA4: // 0x0209EEA4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x48
	ldr r3, _0209F090 // =_0211C3EC
	mvn ip, #0
	ldr r6, [r3]
	mov r5, r0
	cmp r6, #1
	mov r4, r1
	str ip, [r3, #4]
	addeq sp, sp, #0x48
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r2, #0
	bne _0209F080
	cmp r6, #5
	beq _0209EEF0
	cmp r6, #7
	beq _0209F004
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, pc}
_0209EEF0:
	cmp r4, #0x20
	bne _0209EFE4
	ldr r0, [r3, #0x54]
	ldr r3, _0209F094 // =a0123456789abcd_0
	add ip, sp, #0x34
	add r4, r0, #0x14
	mov r2, #8
_0209EF0C:
	ldrb r1, [r3], #1
	ldrb r0, [r3], #1
	subs r2, r2, #1
	strb r1, [ip], #1
	strb r0, [ip], #1
	bne _0209EF0C
	ldrb r0, [r3]
	ldr r3, _0209F098 // =0x0211C418
	add r6, sp, #0
	strb r0, [ip]
	mov r2, #0xa
_0209EF38:
	ldrb r1, [r3], #1
	ldrb r0, [r3], #1
	subs r2, r2, #1
	strb r1, [r6], #1
	strb r0, [r6], #1
	bne _0209EF38
	add r0, sp, #0x14
	mov r1, r5
	mov r2, #0x20
	bl memcpy
	add r1, sp, #0
	mov r0, r4
	mov r2, #0x34
	bl MATH_CalcSHA1
	mov r2, #0
	ldr r3, _0209F090 // =_0211C3EC
	mov r1, r2
	mov r0, #1
	add r6, sp, #0x34
_0209EF84:
	ldrb lr, [r4, r2]
	ldr ip, [r3, #0x54]
	mov lr, lr, asr #4
	ldrsb lr, [r6, lr]
	strb lr, [ip, r1]
	ldrb lr, [r4, r2]
	add r2, r2, #1
	ldr ip, [r3, #0x54]
	and lr, lr, #0xf
	ldrsb lr, [r6, lr]
	cmp r2, #0x14
	add r1, r1, #2
	strb lr, [ip, r0]
	add r0, r0, #2
	blt _0209EF84
	ldr r0, _0209F09C // =aHash
	bl strlen
	ldr r1, _0209F090 // =_0211C3EC
	mov r4, #0x26
	ldr r3, [r1, #0x54]
	mov r2, #6
	strb r4, [r3, -r0]
	str r2, [r1]
	b _0209EFEC
_0209EFE4:
	mov r0, #1
	str r0, [r3]
_0209EFEC:
	mov r0, #0
	mov r1, r5
	mov r2, r0
	bl DWC_Free
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, pc}
_0209F004:
	ldr r0, _0209F0A0 // =aError
	bl strlen
	mov r2, r0
	ldr r1, _0209F0A0 // =aError
	mov r0, r5
	bl strncmp
	cmp r0, #0
	bne _0209F048
	mov r0, #0
	mov r1, r5
	mov r2, r0
	bl DWC_Free
	ldr r0, _0209F090 // =_0211C3EC
	mov r1, #1
	str r1, [r0]
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, pc}
_0209F048:
	ldr r0, _0209F090 // =_0211C3EC
	ldr r1, [r0, #0x5c]
	cmp r1, #0
	beq _0209F064
	mov r0, #0
	mov r2, r0
	bl DWC_Free
_0209F064:
	ldr r0, _0209F090 // =_0211C3EC
	mov r1, #8
	str r1, [r0]
	add sp, sp, #0x48
	str r5, [r0, #0x5c]
	str r4, [r0, #0x60]
	ldmia sp!, {r4, r5, r6, pc}
_0209F080:
	mov r0, #1
	str r0, [r3]
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209F090: .word _0211C3EC
_0209F094: .word a0123456789abcd_0
_0209F098: .word 0x0211C418
_0209F09C: .word aHash
_0209F0A0: .word aError
	arm_func_end sub_209EEA4

	arm_func_start sub_209F0A4
sub_209F0A4: // 0x0209F0A4
	bx lr
	arm_func_end sub_209F0A4

	arm_func_start sub_209F0A8
sub_209F0A8: // 0x0209F0A8
	ldr r1, _0209F0E0 // =0xAAAAAAAB
	ldr r3, _0209F0E4 // =0x00000003
	umull r1, r2, r0, r1
	mov r2, r2, lsr #1
	umull r1, r2, r3, r2
	subs r2, r0, r1
	ldr r1, _0209F0E0 // =0xAAAAAAAB
	movne r3, #1
	umull r1, r2, r0, r1
	moveq r3, #0
	mov r2, r2, lsr #1
	add r0, r3, r2
	mov r0, r0, lsl #2
	bx lr
	.align 2, 0
_0209F0E0: .word 0xAAAAAAAB
_0209F0E4: .word 0x00000003
	arm_func_end sub_209F0A8

	.rodata

a0123456789abcd_0: // 0x0211264C
	.asciz "0123456789abcdef"
	.align 4

	.data
	
.public _0211C3EC
_0211C3EC:
	.byte 0x02, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

aData_0: // 0x0211C450
	.asciz "&data="
	.align 4
	
a00000000000000: // 0x0211C458
	.asciz "0000000000000000000000000000000000000000"
	.align 4
	
aHash: // 0x0211C484
	.asciz "&hash="
	.align 4
	
aPid: // 0x0211C48C
	.asciz "?pid="
	.align 4
	
aWebClientGetAs: // 0x0211C494
	.asciz "/web/client/get.asp"
	.align 4
	
aSSSPidDHashSDa: // 0x0211C4A8
	.asciz "%s%s%s?pid=%d&hash=%s&data="
	.align 4

_0211C4C4:
	.byte 0x00, 0x00, 0x00, 0x00
	
aWebClientPutAs: // 0x0211C4C8
	.asciz "/web/client/put.asp"
	.align 4
	
aHttpGamestats2: // 0x0211C4DC
	.asciz "http://gamestats2.gs.nintendowifi.net/"
	.align 4
	
aHttpSdkdevGame: // 0x0211C504
	.asciz "http://sdkdev.gamespy.com/games/"
	.align 4

aError: // 0x0211C528
	.asciz "error:"
	.align 4