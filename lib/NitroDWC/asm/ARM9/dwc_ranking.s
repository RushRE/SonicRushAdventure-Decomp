	.include "asm/macros.inc"
	.include "global.inc"

	.public _0211AE44

	.text

	arm_func_start DWC_RnkResGetTotal
DWC_RnkResGetTotal: // 0x0209CCAC
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, r0
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #0x10
	movne r0, #1
	ldmneia sp!, {r4, pc}
	add r0, sp, #0
	bl DWCi_RankingGetResponse
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, pc}
	cmp r4, #0
	ldrne r1, [sp, #8]
	moveq r0, #2
	ldrne r1, [r1, #4]
	movne r0, #0
	strne r1, [r4]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	arm_func_end DWC_RnkResGetTotal

	arm_func_start DWC_RnkResGetOrder
DWC_RnkResGetOrder: // 0x0209CD00
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, r0
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #0x10
	movne r0, #1
	ldmneia sp!, {r4, pc}
	add r0, sp, #0
	bl DWCi_RankingGetResponse
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, pc}
	cmp r4, #0
	addeq sp, sp, #0x10
	moveq r0, #2
	ldmeqia sp!, {r4, pc}
	ldr r0, [sp, #4]
	cmp r0, #0
	ldreq r1, [sp, #8]
	movne r0, #0xf
	ldreq r1, [r1]
	moveq r0, #0
	streq r1, [r4]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	arm_func_end DWC_RnkResGetOrder

	arm_func_start DWC_RnkResGetRowCount
DWC_RnkResGetRowCount: // 0x0209CD68
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, r0
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #0x10
	movne r0, #1
	ldmneia sp!, {r4, pc}
	add r0, sp, #0
	bl DWCi_RankingGetResponse
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, pc}
	cmp r4, #0
	addeq sp, sp, #0x10
	moveq r0, #2
	ldmeqia sp!, {r4, pc}
	ldr r0, [sp, #4]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0209CDD8
_0209CDBC: // jump table
	b _0209CDCC // case 0
	b _0209CDD8 // case 1
	b _0209CDD8 // case 2
	b _0209CDD8 // case 3
_0209CDCC:
	add sp, sp, #0x10
	mov r0, #0xf
	ldmia sp!, {r4, pc}
_0209CDD8:
	ldr r1, [sp, #8]
	mov r0, #0
	ldr r1, [r1]
	str r1, [r4]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	arm_func_end DWC_RnkResGetRowCount

	arm_func_start DWC_RnkResGetRow
DWC_RnkResGetRow: // 0x0209CDF0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r4, r1
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, pc}
	add r0, sp, #0
	bl DWCi_RankingGetResponse
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, pc}
	ldr r0, [sp, #4]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _0209CE54
_0209CE38: // jump table
	b _0209CE48 // case 0
	b _0209CE54 // case 1
	b _0209CE54 // case 2
	b _0209CE54 // case 3
_0209CE48:
	add sp, sp, #0xc
	mov r0, #0xf
	ldmia sp!, {r4, r5, pc}
_0209CE54:
	cmp r5, #0
	addeq sp, sp, #0xc
	moveq r0, #2
	ldmeqia sp!, {r4, r5, pc}
	ldr r2, [sp, #8]
	ldr r0, [r2]
	cmp r4, r0
	addhs sp, sp, #0xc
	movhs r0, #2
	ldmhsia sp!, {r4, r5, pc}
	cmp r4, #0
	add ip, r2, #8
	sub r4, r4, #1
	beq _0209CEA4
_0209CE8C:
	ldr r0, [ip, #0x14]
	add r1, ip, #0x18
	cmp r4, #0
	add ip, r1, r0
	sub r4, r4, #1
	bne _0209CE8C
_0209CEA4:
	ldr r0, [sp]
	ldr r1, [ip, #0x14]
	add lr, ip, #0x18
	add r1, lr, r1
	add r0, r2, r0
	cmp r1, r0
	addhi sp, sp, #0xc
	movhi r0, #2
	ldmhiia sp!, {r4, r5, pc}
	mov r4, r5
	ldmia ip!, {r0, r1, r2, r3}
	stmia r4!, {r0, r1, r2, r3}
	ldmia ip, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	str lr, [r5, #0x18]
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end DWC_RnkResGetRow

	arm_func_start DWC_RnkGetState
DWC_RnkGetState: // 0x0209CEEC
	ldr r0, _0209CEF8 // =0x02144320
	ldr r0, [r0]
	bx lr
	.align 2, 0
_0209CEF8: .word 0x02144320
	arm_func_end DWC_RnkGetState

	arm_func_start DWC_RnkProcess
DWC_RnkProcess: // 0x0209CEFC
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {pc}
	ldr r0, _0209CFA4 // =0x02144320
	ldr r0, [r0]
	cmp r0, #2
	beq _0209CF38
	cmp r0, #3
	addne sp, sp, #4
	movne r0, #0xe
	ldmneia sp!, {pc}
_0209CF38:
	bl DWCi_RankingSessionProcess
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _0209CF98
_0209CF48: // jump table
	b _0209CF7C // case 0
	b _0209CF6C // case 1
	b _0209CF98 // case 2
	b _0209CF98 // case 3
	b _0209CF98 // case 4
	b _0209CF98 // case 5
	b _0209CF98 // case 6
	b _0209CF98 // case 7
	b _0209CF8C // case 8
_0209CF6C:
	ldr r0, _0209CFA4 // =0x02144320
	mov r1, #5
	str r1, [r0]
	b _0209CF98
_0209CF7C:
	ldr r0, _0209CFA4 // =0x02144320
	mov r1, #5
	str r1, [r0]
	b _0209CF98
_0209CF8C:
	ldr r0, _0209CFA4 // =0x02144320
	mov r1, #4
	str r1, [r0]
_0209CF98:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209CFA4: .word 0x02144320
	arm_func_end DWC_RnkProcess

	arm_func_start DWC_RnkCancelProcess
DWC_RnkCancelProcess: // 0x0209CFA8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {pc}
	ldr r0, _0209D000 // =0x02144320
	ldr r0, [r0]
	cmp r0, #2
	beq _0209CFE4
	cmp r0, #3
	addne sp, sp, #4
	movne r0, #0xd
	ldmneia sp!, {pc}
_0209CFE4:
	bl DWCi_RankingSessionCancel
	ldr r0, _0209D000 // =0x02144320
	mov r1, #5
	str r1, [r0]
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209D000: .word 0x02144320
	arm_func_end DWC_RnkCancelProcess

	arm_func_start DWC_RnkGetScoreAsync
DWC_RnkGetScoreAsync: // 0x0209D004
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0209D208 // =0x02144320
	ldr r0, [r0]
	cmp r0, #1
	beq _0209D050
	cmp r0, #4
	addne sp, sp, #4
	movne r0, #0xa
	ldmneia sp!, {r4, r5, r6, r7, pc}
_0209D050:
	cmp r6, #0x64
	bhi _0209D060
	cmp r4, #0
	bne _0209D06C
_0209D060:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D06C:
	cmp r7, #3
	addls pc, pc, r7, lsl #2
	b _0209D1AC
_0209D078: // jump table
	b _0209D088 // case 0
	b _0209D0BC // case 1
	b _0209D10C // case 2
	b _0209D15C // case 3
_0209D088:
	ldr r0, [r4]
	cmp r0, #8
	addne sp, sp, #4
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0209D1AC
	cmp r0, #1
	beq _0209D1AC
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D0BC:
	ldr r0, [r4]
	cmp r0, #0xc
	addne sp, sp, #4
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0209D0EC
	cmp r0, #1
	addne sp, sp, #4
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, pc}
_0209D0EC:
	ldr r0, [r4, #8]
	cmp r0, #0xa
	bhi _0209D100
	cmp r0, #0
	bne _0209D1AC
_0209D100:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D10C:
	ldr r0, [r4]
	cmp r0, #0xc
	addne sp, sp, #4
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0209D13C
	cmp r0, #1
	addne sp, sp, #4
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, pc}
_0209D13C:
	ldr r0, [r4, #8]
	cmp r0, #0xa
	bhi _0209D150
	cmp r0, #1
	bhi _0209D1AC
_0209D150:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D15C:
	ldr r0, [r4]
	cmp r0, #0x10c
	addne sp, sp, #4
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _0209D18C
	cmp r0, #1
	addne sp, sp, #4
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, pc}
_0209D18C:
	ldr r0, [r4, #8]
	cmp r0, #0x41
	bhi _0209D1A0
	cmp r0, #1
	bhi _0209D1AC
_0209D1A0:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D1AC:
	ldr r0, _0209D208 // =0x02144320
	str r4, [sp]
	ldr r2, [r0, #4]
	mov r0, r7
	mov r1, r6
	mov r3, r5
	bl DWCi_RankingSessionGetAsync
	cmp r0, #2
	beq _0209D1E4
	cmp r0, #3
	bne _0209D1F0
	add sp, sp, #4
	mov r0, #0xb
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D1E4:
	add sp, sp, #4
	mov r0, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D1F0:
	ldr r0, _0209D208 // =0x02144320
	mov r1, #3
	str r1, [r0]
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209D208: .word 0x02144320
	arm_func_end DWC_RnkGetScoreAsync

	arm_func_start DWC_RnkPutScoreAsync
DWC_RnkPutScoreAsync: // 0x0209D20C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0209D2F4 // =0x02144320
	ldr r0, [r0]
	cmp r0, #1
	beq _0209D258
	cmp r0, #4
	addne sp, sp, #0xc
	movne r0, #7
	ldmneia sp!, {r4, r5, r6, r7, pc}
_0209D258:
	cmp r7, #0x64
	bhi _0209D26C
	ldr r0, [sp, #0x20]
	cmp r0, #0x300
	bls _0209D278
_0209D26C:
	add sp, sp, #0xc
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D278:
	cmp r4, #0
	bne _0209D290
	cmp r0, #0
	addne sp, sp, #0xc
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, pc}
_0209D290:
	ldr r1, [sp, #0x20]
	str r4, [sp]
	ldr r0, _0209D2F4 // =0x02144320
	str r1, [sp, #4]
	ldr r1, [r0, #4]
	mov r0, r7
	mov r2, r6
	mov r3, r5
	bl DWCi_RankingSessionPutAsync
	cmp r0, #2
	beq _0209D2D0
	cmp r0, #3
	bne _0209D2DC
	add sp, sp, #0xc
	mov r0, #8
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D2D0:
	add sp, sp, #0xc
	mov r0, #9
	ldmia sp!, {r4, r5, r6, r7, pc}
_0209D2DC:
	ldr r0, _0209D2F4 // =0x02144320
	mov r1, #2
	str r1, [r0]
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209D2F4: .word 0x02144320
	arm_func_end DWC_RnkPutScoreAsync

	arm_func_start DWC_RnkShutdown
DWC_RnkShutdown: // 0x0209D2F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl DWCi_RankingSessionShutdown
	ldr r1, _0209D318 // =0x02144320
	mov r0, #0
	str r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0209D318: .word 0x02144320
	arm_func_end DWC_RnkShutdown

	arm_func_start DWC_RnkInitialize
DWC_RnkInitialize: // 0x0209D31C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x28
	add r3, sp, #0x1d
	mov r2, #0
	strb r2, [r3]
	strb r2, [r3, #1]
	strb r2, [r3, #2]
	strb r2, [r3, #3]
	strb r2, [r3, #4]
	strb r2, [r3, #5]
	strb r2, [r3, #6]
	strb r2, [r3, #7]
	mov r5, r0
	mov r4, r1
	strb r2, [r3, #8]
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, _0209D4D8 // =0x02144320
	ldr r0, [r0]
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #3
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r4
	bl DWC_CheckUserData
	cmp r0, #0
	beq _0209D3A4
	mov r0, r4
	bl DWC_CheckHasProfile
	cmp r0, #0
	bne _0209D3B0
_0209D3A4:
	add sp, sp, #0x28
	mov r0, #6
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209D3B0:
	mov r0, r5
	bl strlen
	cmp r0, #0x54
	addhs sp, sp, #0x28
	movhs r0, #4
	ldmhsia sp!, {r4, r5, r6, r7, r8, pc}
	add r0, sp, #8
	mov r1, r5
	mov r2, #0x14
	bl strncpy
	mov r3, #0
	add r0, sp, #0x1d
	add r1, r5, #0x14
	mov r2, #8
	strb r3, [sp, #0x1c]
	bl strncpy
	mov r1, #0
	mov r2, #0x10
	bl strtoul
	mov r8, r0
	add r0, sp, #0x1d
	add r1, r5, #0x1c
	mov r2, #8
	bl strncpy
	mov r1, #0
	mov r2, #0x10
	bl strtoul
	mov r7, r0
	add r0, sp, #0x1d
	add r1, r5, #0x24
	mov r2, #8
	bl strncpy
	mov r1, #0
	mov r2, #0x10
	bl strtoul
	mov r6, r0
	add r0, sp, #0x1d
	add r1, r5, #0x2c
	mov r2, #8
	bl strncpy
	mov r1, #0
	mov r2, #0x10
	bl strtoul
	str r6, [sp]
	str r0, [sp, #4]
	mov r2, r8
	mov r3, r7
	add r0, r5, #0x34
	add r1, sp, #8
	bl DWCi_RankingValidateKey
	cmp r0, #0
	addeq sp, sp, #0x28
	moveq r0, #5
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, _0209D4DC // =_0211AE44
	ldr r3, [r4, #0x1c]
	ldr r2, _0209D4D8 // =0x02144320
	ldr r0, [r0]
	ldr r1, _0209D4E0 // =aHttpsNasNinten_2
	str r3, [r2, #4]
	bl strcmp
	cmp r0, #0
	bne _0209D4B8
	mov r0, #1
	bl DWCi_RankingSessionInitialize
	b _0209D4C0
_0209D4B8:
	mov r0, #0
	bl DWCi_RankingSessionInitialize
_0209D4C0:
	ldr r0, _0209D4D8 // =0x02144320
	mov r1, #1
	str r1, [r0]
	mov r0, #0
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0209D4D8: .word 0x02144320
_0209D4DC: .word _0211AE44
_0209D4E0: .word aHttpsNasNinten_2
	arm_func_end DWC_RnkInitialize

	arm_func_start DWCi_RankingGetResponse
DWCi_RankingGetResponse: // 0x0209D4E4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl DWCi_IsError
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, pc}
	ldr r0, _0209D54C // =0x02144320
	ldr r0, [r0]
	cmp r0, #4
	addne sp, sp, #8
	movne r0, #0x10
	ldmneia sp!, {r4, pc}
	add r0, sp, #0
	bl DWCi_RankingSessionGetResponse
	ldr r1, [sp]
	cmp r1, #0
	moveq r0, #0x11
	strne r1, [r4]
	ldrne r1, [r0], #4
	strne r1, [r4, #4]
	strne r0, [r4, #8]
	movne r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209D54C: .word 0x02144320
	arm_func_end DWCi_RankingGetResponse

	.data
	
aHttpsNasNinten_2: // 0x0211C390
	.asciz "https://nas.nintendowifi.net/ac"
	.align 4
