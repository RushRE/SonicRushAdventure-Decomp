	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
.public exHitCheckTask__unk_2177420
exHitCheckTask__unk_2177420: // 0x02177420
	.space 0x70

.public exHitCheckTask__dword_2177490
exHitCheckTask__dword_2177490: // 0x02177490
    .space 0x128
	
	.text

	arm_func_start exHitCheckTask__Func_216AD9C
exHitCheckTask__Func_216AD9C: // 0x0216AD9C
	cmp r0, #0
	bxle lr
	ldr r1, _0216ADB8 // =exHitCheckTask__unk_2177420
	ldrsh r2, [r1, #0]
	cmp r2, #0
	strleh r0, [r1]
	bx lr
	.align 2, 0
_0216ADB8: .word exHitCheckTask__unk_2177420
	arm_func_end exHitCheckTask__Func_216AD9C

	arm_func_start exHitCheckTask__Func_216ADBC
exHitCheckTask__Func_216ADBC: // 0x0216ADBC
	ldr r0, _0216ADD4 // =exHitCheckTask__unk_2177420
	ldrsh r0, [r0, #0]
	cmp r0, #0
	movgt r0, #1
	movle r0, #0
	bx lr
	.align 2, 0
_0216ADD4: .word exHitCheckTask__unk_2177420
	arm_func_end exHitCheckTask__Func_216ADBC

	arm_func_start exHitCheckTask__Func_216ADD8
exHitCheckTask__Func_216ADD8: // 0x0216ADD8
	ldr r0, _0216ADF0 // =exHitCheckTask__unk_2177420
	ldrsh r1, [r0, #0]
	cmp r1, #0
	subgt r1, r1, #1
	strgth r1, [r0]
	bx lr
	.align 2, 0
_0216ADF0: .word exHitCheckTask__unk_2177420
	arm_func_end exHitCheckTask__Func_216ADD8

	arm_func_start exHitCheckTask__InitHitChecker
exHitCheckTask__InitHitChecker: // 0x0216ADF4
	ldr ip, _0216AE04 // =MI_CpuFill8
	mov r1, #0
	mov r2, #0x1c
	bx ip
	.align 2, 0
_0216AE04: .word MI_CpuFill8
	arm_func_end exHitCheckTask__InitHitChecker

	arm_func_start exHitCheckTask__CheckBoxOverlap
exHitCheckTask__CheckBoxOverlap: // 0x0216AE08
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r4, [r0, #0xc]
	ldr r2, [r1, #0xc]
	ldr ip, [r0]
	ldr r7, [r0, #4]
	ldmia r4, {r3, r6}
	sub r0, r3, ip
	ldr lr, [r1]
	ldr r5, [r1, #4]
	add ip, r3, ip
	add r4, r6, r7
	sub r3, r6, r7
	ldr r1, [r2, #0]
	sub r0, r0, lr
	cmp r0, r1
	add r4, r5, r4
	add r0, lr, ip
	sub r3, r3, r5
	bge _0216AE70
	cmp r0, r1
	ldrgt r0, [r2, #4]
	cmpgt r4, r0
	ble _0216AE70
	cmp r3, r0
	movlt r0, #1
	ldmltia sp!, {r3, r4, r5, r6, r7, pc}
_0216AE70:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end exHitCheckTask__CheckBoxOverlap

	arm_func_start exHitCheckTask__AddHitCheck
exHitCheckTask__AddHitCheck: // 0x0216AE78
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	bl GetExSystemFlag_2178650
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6b]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _0216AEE0
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	bne _0216AF3C
_0216AEE0:
	ldrb r0, [r4, #0]
	cmp r0, #4
	bne _0216AF34
	ldrb r0, [r4, #4]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0216AF34
	ldr r0, _0216B248 // =_02175D74
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216AF2C
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldr r2, _0216B250 // =0x021774B8
	ldrh r3, [r0, #4]
	add r1, r3, #1
	str r4, [r2, r3, lsl #2]
	strh r1, [r0, #4]
	b _0216AF34
_0216AF2C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216AF34:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216AF3C:
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldrh r1, [r0, #4]
	cmp r1, #0x40
	ldrhs r0, _0216B248 // =_02175D74
	movhs r2, #0
	strhs r2, [r0, #0x10]
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldrh r2, [r0, #8]
	cmp r2, #0xa
	ldrhs r0, _0216B248 // =_02175D74
	movhs r3, #0
	strhs r3, [r0, #0xc]
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldrh r3, [r0, #0xa]
	cmp r3, #5
	ldrhs r0, _0216B248 // =_02175D74
	movhs r5, #0
	strhs r5, [r0]
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldrh ip, [r0, #6]
	cmp ip, #0xa
	ldrhs r0, _0216B248 // =_02175D74
	movhs r5, #0
	strhs r5, [r0, #8]
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldrh lr, [r0, #2]
	cmp lr, #0xa
	ldrhs r0, _0216B248 // =_02175D74
	movhs r5, #0
	strhs r5, [r0, #4]
	ldrb r0, [r4, #0]
	cmp r0, #1
	bne _0216B084
	ldrb r0, [r4, #1]
	mov r5, r0, lsl #0x1f
	mov r5, r5, lsr #0x1f
	cmp r5, #1
	movne r0, r0, lsl #0x18
	movne r0, r0, lsr #0x1f
	cmpne r0, #1
	beq _0216B050
	ldrb r0, [r4, #2]
	mov r5, r0, lsl #0x1f
	mov r5, r5, lsr #0x1f
	cmp r5, #1
	movne r5, r0, lsl #0x1e
	movne r5, r5, lsr #0x1f
	cmpne r5, #1
	movne r5, r0, lsl #0x1d
	movne r5, r5, lsr #0x1f
	cmpne r5, #1
	movne r5, r0, lsl #0x1b
	movne r5, r5, lsr #0x1f
	cmpne r5, #1
	movne r5, r0, lsl #0x1a
	movne r5, r5, lsr #0x1f
	cmpne r5, #1
	movne r0, r0, lsl #0x18
	movne r0, r0, lsr #0x1f
	cmpne r0, #1
	beq _0216B050
	ldrb r0, [r4, #3]
	mov r5, r0, lsl #0x1f
	mov r5, r5, lsr #0x1f
	cmp r5, #1
	movne r0, r0, lsl #0x1e
	movne r0, r0, lsr #0x1f
	cmpne r0, #1
	bne _0216B084
_0216B050:
	ldr r0, _0216B248 // =_02175D74
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216B07C
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldr r6, _0216B250 // =0x021774B8
	ldrh r5, [r0, #4]
	str r4, [r6, r1, lsl #2]
	add r1, r5, #1
	strh r1, [r0, #4]
	b _0216B084
_0216B07C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B084:
	ldrb r0, [r4, #0]
	cmp r0, #5
	bne _0216B0D8
	ldrb r0, [r4, #4]
	mov r0, r0, lsl #0x1b
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0216B0D8
	ldr r0, _0216B248 // =_02175D74
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216B0D0
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldr r5, _0216B250 // =0x021774B8
	ldrh r6, [r0, #4]
	add r1, r6, #1
	str r4, [r5, r6, lsl #2]
	strh r1, [r0, #4]
	b _0216B0D8
_0216B0D0:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B0D8:
	ldrb r0, [r4, #0]
	cmp r0, #2
	bne _0216B1EC
	ldrb r0, [r4, #3]
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0216B12C
	ldr r0, _0216B248 // =_02175D74
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _0216B124
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldr r2, _0216B254 // =0x0217742C
	ldrh r1, [r0, #0xa]
	str r4, [r2, r3, lsl #2]
	add r1, r1, #1
	strh r1, [r0, #0xa]
	b _0216B1EC
_0216B124:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B12C:
	ldrb r0, [r4, #4]
	mov r1, r0, lsl #0x1e
	mov r1, r1, lsr #0x1f
	cmp r1, #1
	bne _0216B174
	ldr r0, _0216B248 // =_02175D74
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _0216B16C
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldr r2, _0216B258 // =0x02177468
	ldrh r1, [r0, #6]
	str r4, [r2, ip, lsl #2]
	add r1, r1, #1
	strh r1, [r0, #6]
	b _0216B1EC
_0216B16C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B174:
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0216B1B8
	ldr r0, _0216B248 // =_02175D74
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0216B1B0
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldr r2, _0216B25C // =0x02177440
	ldrh r1, [r0, #2]
	str r4, [r2, lr, lsl #2]
	add r1, r1, #1
	strh r1, [r0, #2]
	b _0216B1EC
_0216B1B0:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B1B8:
	ldr r0, _0216B248 // =_02175D74
	ldr r0, [r0, #0xc]
	cmp r0, #0
	beq _0216B1E4
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldr r3, _0216B260 // =exHitCheckTask__dword_2177490
	ldrh r1, [r0, #8]
	str r4, [r3, r2, lsl #2]
	add r1, r1, #1
	strh r1, [r0, #8]
	b _0216B1EC
_0216B1E4:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B1EC:
	ldrb r0, [r4, #0]
	cmp r0, #4
	bne _0216B240
	ldrb r0, [r4, #4]
	mov r0, r0, lsl #0x1c
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	bne _0216B240
	ldr r0, _0216B248 // =_02175D74
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _0216B238
	ldr r0, _0216B24C // =exHitCheckTask__unk_2177420
	ldr r2, _0216B250 // =0x021774B8
	ldrh r3, [r0, #4]
	add r1, r3, #1
	str r4, [r2, r3, lsl #2]
	strh r1, [r0, #4]
	b _0216B240
_0216B238:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_0216B240:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216B248: .word _02175D74
_0216B24C: .word exHitCheckTask__unk_2177420
_0216B250: .word 0x021774B8
_0216B254: .word 0x0217742C
_0216B258: .word 0x02177468
_0216B25C: .word 0x02177440
_0216B260: .word exHitCheckTask__dword_2177490
	arm_func_end exHitCheckTask__AddHitCheck

	arm_func_start exHitCheckTask__CheckArenaBounds
exHitCheckTask__CheckArenaBounds: // 0x0216B264
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #4
	ldmloia sp!, {r4, pc}
	ldrb r0, [r4, #6]
	bic r1, r0, #0x40
	and r0, r1, #0xff
	bic r0, r0, #0x80
	strb r0, [r4, #6]
	ldrb r0, [r4, #7]
	bic r2, r0, #1
	and r0, r2, #0xff
	bic r1, r0, #2
	and r0, r1, #0xff
	strb r2, [r4, #7]
	bic r0, r0, #4
	strb r0, [r4, #7]
	ldr r0, [r4, #0x354]
	cmp r0, #0x11000
	ble _0216B2D8
	mov r0, #0x11000
	str r0, [r4, #0x354]
	ldrb r0, [r4, #6]
	orr r1, r0, #0x80
	and r0, r1, #0xff
	orr r0, r0, #0x40
	strb r0, [r4, #6]
_0216B2D8:
	mov r0, #0x20000
	ldr r1, [r4, #0x354]
	rsb r0, r0, #0
	cmp r1, r0
	bge _0216B30C
	str r0, [r4, #0x354]
	ldrb r0, [r4, #7]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r4, #7]
	ldrb r0, [r4, #6]
	orr r0, r0, #0x40
	strb r0, [r4, #6]
_0216B30C:
	mov r0, #0x46000
	ldr r1, [r4, #0x350]
	rsb r0, r0, #0
	cmp r1, r0
	bge _0216B33C
	str r0, [r4, #0x350]
	ldrb r0, [r4, #7]
	orr r0, r0, #2
	strb r0, [r4, #7]
	ldrb r0, [r4, #6]
	orr r0, r0, #0x40
	strb r0, [r4, #6]
_0216B33C:
	ldr r0, [r4, #0x350]
	cmp r0, #0x46000
	ldmleia sp!, {r4, pc}
	mov r0, #0x46000
	str r0, [r4, #0x350]
	ldrb r0, [r4, #7]
	orr r0, r0, #4
	strb r0, [r4, #7]
	ldrb r0, [r4, #6]
	orr r0, r0, #0x40
	strb r0, [r4, #6]
	ldmia sp!, {r4, pc}
	arm_func_end exHitCheckTask__CheckArenaBounds

	arm_func_start exHitCheckTask__Func_216B36C
exHitCheckTask__Func_216B36C: // 0x0216B36C
	bx lr
	arm_func_end exHitCheckTask__Func_216B36C

	arm_func_start exHitCheckTask__Func_216B370
exHitCheckTask__Func_216B370: // 0x0216B370
	bx lr
	arm_func_end exHitCheckTask__Func_216B370

	arm_func_start exHitCheckTask__ArenaCheckForModel
exHitCheckTask__ArenaCheckForModel: // 0x0216B374
	stmdb sp!, {r3, lr}
	ldrb r1, [r0, #0]
	add r1, r1, #0xfe
	and r1, r1, #0xff
	cmp r1, #1
	ldmhiia sp!, {r3, pc}
	ldrb r1, [r0, #3]
	mov r2, r1, lsl #0x1c
	movs r2, r2, lsr #0x1f
	bne _0216B3A8
	mov r1, r1, lsl #0x1a
	movs r1, r1, lsr #0x1f
	ldmeqia sp!, {r3, pc}
_0216B3A8:
	bl exHitCheckTask__CheckArenaBounds
	ldmia sp!, {r3, pc}
	arm_func_end exHitCheckTask__ArenaCheckForModel

	arm_func_start exHitCheckTask__DoArenaBoundsCheck
exHitCheckTask__DoArenaBoundsCheck: // 0x0216B3B0
	stmdb sp!, {r3, lr}
	cmp r1, #2
	bne _0216B3C4
	bl exHitCheckTask__Func_216B36C
	ldmia sp!, {r3, pc}
_0216B3C4:
	cmp r1, #1
	bne _0216B3D4
	bl exHitCheckTask__ArenaCheckForModel
	ldmia sp!, {r3, pc}
_0216B3D4:
	cmp r1, #3
	ldmneia sp!, {r3, pc}
	bl exHitCheckTask__Func_216B370
	ldmia sp!, {r3, pc}
	arm_func_end exHitCheckTask__DoArenaBoundsCheck

	arm_func_start exHitCheckTask__DoHitChecks
exHitCheckTask__DoHitChecks: // 0x0216B3E4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bl GetExSuperSonicWorker
	mov r7, r0
	bl GetExBurningBlazeWorker
	mov r8, r0
	bl exBossHelpers__GetBossAssets
	bl GetExSystemFlag_2178650
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl exPlayerAdminTask__GetUnknown2
	ldrb r0, [r0, #0x6b]
	mov r0, r0, lsl #0x1d
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #0xb
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #7
	beq _0216B450
	bl GetExSystemStatus
	ldrb r0, [r0, #3]
	cmp r0, #9
	bne _0216B604
_0216B450:
	ldrb r0, [r7, #0]
	cmp r0, #2
	bne _0216B528
	ldr r6, _0216C3A0 // =exHitCheckTask__unk_2177420
	mov r5, #0
	ldrh r0, [r6, #4]
	cmp r0, #0
	bls _0216B528
	ldr r4, _0216C3A4 // =0x021774B8
_0216B474:
	ldr r1, [r4, r5, lsl #2]
	ldrb r0, [r1, #6]
	mov r0, r0, lsl #0x1f
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _0216B510
	ldr r0, [r1, #0x18]
	ldr r0, [r0, #8]
	cmp r0, #0x41000
	bgt _0216B4A4
	cmp r0, #0x32000
	bge _0216B4AC
_0216B4A4:
	cmp r0, #0
	bne _0216B510
_0216B4AC:
	add r0, r7, #0xc
	add r1, r1, #0xc
	bl exHitCheckTask__CheckBoxOverlap
	cmp r0, #0
	beq _0216B510
	ldr r0, [r4, r5, lsl #2]
	ldrb r1, [r0, #4]
	mov r1, r1, lsl #0x1c
	movs r1, r1, lsr #0x1f
	beq _0216B510
	ldrb r1, [r7, #6]
	mov r1, r1, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216B510
	ldrb r1, [r0, #6]
	bic r1, r1, #1
	orr r1, r1, #1
	strb r1, [r0, #6]
	ldrb r0, [r7, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r7, #6]
	ldrb r0, [r7, #7]
	orr r0, r0, #8
	strb r0, [r7, #7]
_0216B510:
	ldrh r1, [r6, #4]
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _0216B474
_0216B528:
	ldrb r0, [r8, #0]
	cmp r0, #2
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r6, _0216C3A0 // =exHitCheckTask__unk_2177420
	mov r5, #0
	ldrh r0, [r6, #4]
	cmp r0, #0
	ldmlsia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r4, _0216C3A4 // =0x021774B8
_0216B54C:
	ldr r1, [r4, r5, lsl #2]
	ldrb r0, [r1, #6]
	mov r0, r0, lsl #0x1f
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _0216B5E8
	ldr r0, [r1, #0x18]
	ldr r0, [r0, #8]
	cmp r0, #0x41000
	bgt _0216B57C
	cmp r0, #0x32000
	bge _0216B584
_0216B57C:
	cmp r0, #0
	bne _0216B5E8
_0216B584:
	add r0, r8, #0xc
	add r1, r1, #0xc
	bl exHitCheckTask__CheckBoxOverlap
	cmp r0, #0
	beq _0216B5E8
	ldr r0, [r4, r5, lsl #2]
	ldrb r1, [r0, #4]
	mov r1, r1, lsl #0x1c
	movs r1, r1, lsr #0x1f
	beq _0216B5E8
	ldrb r1, [r8, #6]
	mov r1, r1, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216B5E8
	ldrb r1, [r0, #6]
	bic r1, r1, #1
	orr r1, r1, #1
	strb r1, [r0, #6]
	ldrb r0, [r8, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r8, #6]
	ldrb r0, [r8, #7]
	orr r0, r0, #8
	strb r0, [r8, #7]
_0216B5E8:
	ldrh r1, [r6, #4]
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _0216B54C
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0216B604:
	cmp r7, #0
	cmpne r8, #0
	ldrne r1, _0216C3A0 // =exHitCheckTask__unk_2177420
	ldrneh r0, [r1, #4]
	cmpne r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrh r1, [r1, #0xa]
	cmp r1, #0
	beq _0216B940
	cmp r0, #0
	mov r10, #0
	bls _0216B940
_0216B634:
	ldr r0, _0216C3A4 // =0x021774B8
	ldr r2, [r0, r10, lsl #2]
	ldr r0, [r2, #0x18]
	ldr r0, [r0, #8]
	cmp r0, #0x41000
	bgt _0216B654
	cmp r0, #0x32000
	bge _0216B65C
_0216B654:
	cmp r0, #0
	bne _0216B924
_0216B65C:
	ldrb r0, [r2, #0]
	cmp r0, #1
	cmpne r0, #5
	bne _0216B924
	cmp r1, #0
	mov r9, #0
	bls _0216B924
	mov r11, #2
	ldr r5, _0216C3A4 // =0x021774B8
	ldr r6, _0216C3A8 // =0x0217742C
	mov r4, r11
_0216B688:
	ldr r0, [r6, r9, lsl #2]
	ldr r1, [r5, r10, lsl #2]
	add r0, r0, #0xc
	add r1, r1, #0xc
	bl exHitCheckTask__CheckBoxOverlap
	cmp r0, #0
	beq _0216B908
	ldr r1, [r5, r10, lsl #2]
	ldrb r0, [r1, #1]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _0216B774
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #1
	bne _0216B718
	ldr r1, [r6, r9, lsl #2]
	ldrsh r0, [r1, #8]
	cmp r0, #0x12
	bne _0216B908
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r10, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r0, [r5, r10, lsl #2]
	strb r4, [r0]
	ldr r1, [r6, r9, lsl #2]
	ldr r0, [r5, r10, lsl #2]
	ldrsh r1, [r1, #8]
	strh r1, [r0, #8]
	b _0216B908
_0216B718:
	bl GetExSystemStatus
	ldrb r0, [r0, #0]
	cmp r0, #2
	ldreq r1, [r6, r9, lsl #2]
	ldreqsh r0, [r1, #8]
	cmpeq r0, #0x15
	bne _0216B908
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r10, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r0, [r5, r10, lsl #2]
	strb r11, [r0]
	ldr r1, [r6, r9, lsl #2]
	ldr r0, [r5, r10, lsl #2]
	ldrsh r1, [r1, #8]
	strh r1, [r0, #8]
	b _0216B908
_0216B774:
	ldrb r0, [r1, #2]
	mov r2, r0, lsl #0x1e
	movs r2, r2, lsr #0x1f
	bne _0216B790
	mov r2, r0, lsl #0x1d
	movs r2, r2, lsr #0x1f
	beq _0216B7D8
_0216B790:
	ldr r1, [r6, r9, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r10, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r10, lsl #2]
	mov r0, #2
	strb r0, [r1]
	ldr r1, [r6, r9, lsl #2]
	ldr r0, [r5, r10, lsl #2]
	ldrsh r1, [r1, #8]
	strh r1, [r0, #8]
	b _0216B908
_0216B7D8:
	mov r2, r0, lsl #0x1a
	movs r2, r2, lsr #0x1f
	beq _0216B82C
	ldr r1, [r6, r9, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r10, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r10, lsl #2]
	mov r0, #2
	strb r0, [r1]
	ldr r1, [r6, r9, lsl #2]
	ldr r0, [r5, r10, lsl #2]
	ldrsh r1, [r1, #8]
	strh r1, [r0, #8]
	b _0216B908
_0216B82C:
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _0216B880
	ldr r1, [r6, r9, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r10, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r10, lsl #2]
	mov r0, #2
	strb r0, [r1]
	ldr r1, [r6, r9, lsl #2]
	ldr r0, [r5, r10, lsl #2]
	ldrsh r1, [r1, #8]
	strh r1, [r0, #8]
	b _0216B908
_0216B880:
	ldrb r0, [r1, #3]
	mov r1, r0, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _0216B8A8
	ldr r1, [r6, r9, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	b _0216B908
_0216B8A8:
	mov r0, r0, lsl #0x1e
	ldr r1, [r6, r9, lsl #2]
	movs r0, r0, lsr #0x1f
	ldrb r0, [r1, #6]
	beq _0216B8CC
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	b _0216B908
_0216B8CC:
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r10, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r10, lsl #2]
	mov r0, #2
	strb r0, [r1]
	ldr r1, [r6, r9, lsl #2]
	ldr r0, [r5, r10, lsl #2]
	ldrsh r1, [r1, #8]
	strh r1, [r0, #8]
_0216B908:
	ldr r0, _0216C3A0 // =exHitCheckTask__unk_2177420
	ldrh r1, [r0, #0xa]
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r9, r0, lsr #0x10
	bhi _0216B688
_0216B924:
	ldr r0, _0216C3A0 // =exHitCheckTask__unk_2177420
	add r2, r10, #1
	ldrh r0, [r0, #4]
	mov r2, r2, lsl #0x10
	mov r10, r2, lsr #0x10
	cmp r0, r2, lsr #16
	bhi _0216B634
_0216B940:
	ldr r1, _0216C3A0 // =exHitCheckTask__unk_2177420
	ldrh r1, [r1, #6]
	cmp r1, #0
	beq _0216BA88
	cmp r0, #0
	mov r6, #0
	bls _0216BA88
_0216B95C:
	ldr r0, _0216C3A4 // =0x021774B8
	ldr r2, [r0, r6, lsl #2]
	ldr r0, [r2, #0x18]
	ldr r0, [r0, #8]
	cmp r0, #0x41000
	bgt _0216B97C
	cmp r0, #0x32000
	bge _0216B984
_0216B97C:
	cmp r0, #0
	bne _0216BA6C
_0216B984:
	ldrb r0, [r2, #0]
	cmp r0, #1
	bne _0216BA6C
	cmp r1, #0
	mov r9, #0
	bls _0216BA6C
	ldr r5, _0216C3AC // =0x02177468
	ldr r4, _0216C3A4 // =0x021774B8
	ldr r10, _0216C3A0 // =exHitCheckTask__unk_2177420
_0216B9A8:
	ldr r0, [r5, r9, lsl #2]
	ldr r1, [r4, r6, lsl #2]
	add r0, r0, #0xc
	add r1, r1, #0xc
	bl exHitCheckTask__CheckBoxOverlap
	cmp r0, #0
	beq _0216BA54
	ldr r0, [r4, r6, lsl #2]
	ldrb r2, [r0, #2]
	mov r1, r2, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216BA54
	mov r1, r2, lsl #0x1d
	movs r1, r1, lsr #0x1f
	bne _0216BA54
	mov r1, r2, lsl #0x1a
	movs r1, r1, lsr #0x1f
	bne _0216BA54
	mov r1, r2, lsl #0x18
	movs r1, r1, lsr #0x1f
	bne _0216BA54
	ldrb r0, [r0, #3]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _0216BA54
	ldr r1, [r5, r9, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r4, r6, lsl #2]
	ldrb r0, [r1, #6]
	orr r0, r0, #2
	strb r0, [r1, #6]
	ldr r1, [r4, r6, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r9, lsl #2]
	ldr r0, [r4, r6, lsl #2]
	ldrsh r1, [r1, #8]
	strh r1, [r0, #8]
_0216BA54:
	ldrh r1, [r10, #6]
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r9, r0, lsr #0x10
	bhi _0216B9A8
_0216BA6C:
	ldr r0, _0216C3A0 // =exHitCheckTask__unk_2177420
	add r2, r6, #1
	ldrh r0, [r0, #4]
	mov r2, r2, lsl #0x10
	mov r6, r2, lsr #0x10
	cmp r0, r2, lsr #16
	bhi _0216B95C
_0216BA88:
	ldr r1, _0216C3A0 // =exHitCheckTask__unk_2177420
	ldrh r1, [r1, #2]
	cmp r1, #0
	beq _0216BC3C
	cmp r0, #0
	mov r6, #0
	bls _0216BC3C
_0216BAA4:
	ldr r0, _0216C3A4 // =0x021774B8
	ldr r2, [r0, r6, lsl #2]
	ldr r0, [r2, #0x18]
	ldr r0, [r0, #8]
	cmp r0, #0x41000
	bgt _0216BAC4
	cmp r0, #0x32000
	bge _0216BACC
_0216BAC4:
	cmp r0, #0
	bne _0216BC20
_0216BACC:
	ldrb r0, [r2, #0]
	cmp r0, #1
	cmpne r0, #5
	bne _0216BC20
	cmp r1, #0
	mov r9, #0
	bls _0216BC20
	ldr r4, _0216C3A4 // =0x021774B8
	ldr r5, _0216C3B0 // =0x02177440
	ldr r10, _0216C3A0 // =exHitCheckTask__unk_2177420
_0216BAF4:
	ldr r0, [r5, r9, lsl #2]
	ldr r1, [r4, r6, lsl #2]
	add r0, r0, #0xc
	add r1, r1, #0xc
	bl exHitCheckTask__CheckBoxOverlap
	cmp r0, #0
	beq _0216BC08
	ldr r0, [r4, r6, lsl #2]
	ldrb r2, [r0, #2]
	mov r1, r2, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216BB30
	mov r1, r2, lsl #0x1d
	movs r1, r1, lsr #0x1f
	beq _0216BB48
_0216BB30:
	ldr r1, [r5, r9, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	b _0216BC08
_0216BB48:
	mov r1, r2, lsl #0x1b
	movs r1, r1, lsr #0x1f
	beq _0216BB6C
	ldr r1, [r5, r9, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	b _0216BC08
_0216BB6C:
	mov r1, r2, lsl #0x1a
	movs r1, r1, lsr #0x1f
	beq _0216BBB0
	ldrb r1, [r0, #6]
	bic r1, r1, #1
	orr r1, r1, #1
	strb r1, [r0, #6]
	ldr r1, [r5, r9, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r9, lsl #2]
	ldr r0, [r4, r6, lsl #2]
	ldrsh r1, [r1, #8]
	strh r1, [r0, #8]
	b _0216BC08
_0216BBB0:
	ldrb r0, [r0, #3]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _0216BC08
	ldr r1, [r5, r9, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r4, r6, lsl #2]
	ldrb r0, [r1, #6]
	orr r0, r0, #2
	strb r0, [r1, #6]
	ldr r1, [r4, r6, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldr r1, [r5, r9, lsl #2]
	ldr r0, [r4, r6, lsl #2]
	ldrsh r1, [r1, #8]
	strh r1, [r0, #8]
_0216BC08:
	ldrh r1, [r10, #2]
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r9, r0, lsr #0x10
	bhi _0216BAF4
_0216BC20:
	ldr r0, _0216C3A0 // =exHitCheckTask__unk_2177420
	add r2, r6, #1
	ldrh r0, [r0, #4]
	mov r2, r2, lsl #0x10
	mov r6, r2, lsr #0x10
	cmp r0, r2, lsr #16
	bhi _0216BAA4
_0216BC3C:
	ldrb r1, [r7, #0]
	cmp r1, #2
	bne _0216C018
	cmp r0, #0
	mov r5, #0
	bls _0216C018
	ldr r4, _0216C3A4 // =0x021774B8
	ldr r6, _0216C3A0 // =exHitCheckTask__unk_2177420
_0216BC5C:
	ldr r1, [r4, r5, lsl #2]
	ldrb r0, [r1, #6]
	mov r0, r0, lsl #0x1f
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _0216C000
	ldr r0, [r1, #0x18]
	ldr r0, [r0, #8]
	cmp r0, #0x41000
	bgt _0216BC8C
	cmp r0, #0x32000
	bge _0216BC94
_0216BC8C:
	cmp r0, #0
	bne _0216C000
_0216BC94:
	add r0, r7, #0xc
	add r1, r1, #0xc
	bl exHitCheckTask__CheckBoxOverlap
	cmp r0, #0
	beq _0216C000
	ldr r2, [r4, r5, lsl #2]
	ldrb r1, [r2, #4]
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _0216BD00
	ldrb r0, [r7, #6]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _0216C000
	bl exPlayerAdminTask__GetUnknown2
	ldrsh r0, [r0, #0x20]
	cmp r0, #0
	ble _0216BCF0
	ldr r1, [r4, r5, lsl #2]
	ldrb r0, [r1, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
_0216BCF0:
	ldrb r0, [r7, #6]
	orr r0, r0, #2
	strb r0, [r7, #6]
	b _0216C000
_0216BD00:
	ldrb r0, [r2, #1]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _0216BD4C
	ldrb r0, [r7, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C000
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C000
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r7, #6]
	orr r0, r0, #2
	strb r0, [r7, #6]
	b _0216C000
_0216BD4C:
	ldrb r0, [r2, #2]
	mov r3, r0, lsl #0x1f
	movs r3, r3, lsr #0x1f
	beq _0216BD98
	ldrb r0, [r7, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C000
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C000
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r7, #6]
	orr r0, r0, #2
	strb r0, [r7, #6]
	b _0216C000
_0216BD98:
	mov r3, r0, lsl #0x1e
	movs r3, r3, lsr #0x1f
	beq _0216BDE0
	ldrb r0, [r7, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C000
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C000
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r7, #6]
	orr r0, r0, #2
	strb r0, [r7, #6]
	b _0216C000
_0216BDE0:
	mov r3, r0, lsl #0x1d
	movs r3, r3, lsr #0x1f
	beq _0216BE28
	ldrb r0, [r7, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C000
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C000
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r7, #6]
	orr r0, r0, #2
	strb r0, [r7, #6]
	b _0216C000
_0216BE28:
	mov r3, r0, lsl #0x1b
	movs r3, r3, lsr #0x1f
	beq _0216BE70
	ldrb r0, [r7, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C000
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C000
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r7, #6]
	orr r0, r0, #2
	strb r0, [r7, #6]
	b _0216C000
_0216BE70:
	mov r3, r0, lsl #0x1a
	movs r3, r3, lsr #0x1f
	beq _0216BEB4
	ldrb r0, [r7, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C000
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C000
	ldrb r0, [r2, #6]
	orr r0, r0, #0x10
	strb r0, [r2, #6]
	ldrb r0, [r7, #6]
	orr r0, r0, #2
	strb r0, [r7, #6]
	b _0216C000
_0216BEB4:
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _0216BF10
	ldrb r0, [r7, #6]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _0216C000
	bl exPlayerAdminTask__GetUnknown2
	ldrsh r0, [r0, #0x20]
	ldr r1, [r4, r5, lsl #2]
	cmp r0, #0
	ldrb r0, [r1, #6]
	ble _0216BEF4
	orr r0, r0, #0x10
	strb r0, [r1, #6]
	b _0216C000
_0216BEF4:
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r1, #6]
	ldrb r0, [r7, #6]
	orr r0, r0, #2
	strb r0, [r7, #6]
	b _0216C000
_0216BF10:
	ldrb r0, [r2, #3]
	mov r3, r0, lsl #0x1f
	movs r3, r3, lsr #0x1f
	beq _0216BF5C
	ldrb r0, [r7, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C000
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C000
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r7, #6]
	orr r0, r0, #2
	strb r0, [r7, #6]
	b _0216C000
_0216BF5C:
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _0216BF94
	ldrb r0, [r7, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C000
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C000
	ldrb r0, [r7, #6]
	orr r0, r0, #4
	strb r0, [r7, #6]
	b _0216C000
_0216BF94:
	mov r0, r1, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _0216BFE0
	ldrb r0, [r7, #6]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _0216C000
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r7, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r7, #6]
	ldrb r0, [r7, #7]
	orr r0, r0, #8
	strb r0, [r7, #7]
	b _0216C000
_0216BFE0:
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r7, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r7, #6]
_0216C000:
	ldrh r1, [r6, #4]
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r5, r0, lsr #0x10
	bhi _0216BC5C
_0216C018:
	ldrb r0, [r7, #6]
	bic r0, r0, #8
	strb r0, [r7, #6]
	ldrb r0, [r8, #0]
	cmp r0, #2
	bne _0216C390
	ldr r4, _0216C3A0 // =exHitCheckTask__unk_2177420
	mov r6, #0
	ldrh r0, [r4, #4]
	cmp r0, #0
	bls _0216C390
	ldr r5, _0216C3A4 // =0x021774B8
_0216C048:
	ldr r1, [r5, r6, lsl #2]
	ldrb r0, [r1, #6]
	mov r0, r0, lsl #0x1f
	mov r0, r0, lsr #0x1f
	cmp r0, #1
	beq _0216C378
	ldr r0, [r1, #0x18]
	ldr r0, [r0, #8]
	cmp r0, #0x41000
	bgt _0216C078
	cmp r0, #0x32000
	bge _0216C080
_0216C078:
	cmp r0, #0
	bne _0216C378
_0216C080:
	add r0, r8, #0xc
	add r1, r1, #0xc
	bl exHitCheckTask__CheckBoxOverlap
	cmp r0, #0
	beq _0216C378
	ldr r2, [r5, r6, lsl #2]
	ldrb r1, [r2, #4]
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _0216C0D4
	ldrb r0, [r8, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C378
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C378
	ldrb r0, [r8, #6]
	orr r0, r0, #2
	strb r0, [r8, #6]
	b _0216C378
_0216C0D4:
	ldrb r0, [r2, #2]
	mov r3, r0, lsl #0x1b
	movs r3, r3, lsr #0x1f
	beq _0216C120
	ldrb r0, [r8, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C378
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C378
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r8, #6]
	orr r0, r0, #2
	strb r0, [r8, #6]
	b _0216C378
_0216C120:
	ldrb r3, [r2, #1]
	mov r3, r3, lsl #0x18
	movs r3, r3, lsr #0x1f
	beq _0216C16C
	ldrb r0, [r8, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C378
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C378
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r8, #6]
	orr r0, r0, #2
	strb r0, [r8, #6]
	b _0216C378
_0216C16C:
	mov r3, r0, lsl #0x1e
	movs r3, r3, lsr #0x1f
	beq _0216C1B4
	ldrb r0, [r8, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C378
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C378
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r8, #6]
	orr r0, r0, #2
	strb r0, [r8, #6]
	b _0216C378
_0216C1B4:
	mov r3, r0, lsl #0x1d
	movs r3, r3, lsr #0x1f
	beq _0216C1FC
	ldrb r0, [r8, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C378
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C378
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r8, #6]
	orr r0, r0, #2
	strb r0, [r8, #6]
	b _0216C378
_0216C1FC:
	mov r3, r0, lsl #0x1a
	movs r3, r3, lsr #0x1f
	beq _0216C240
	ldrb r0, [r8, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C378
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C378
	ldrb r0, [r2, #6]
	orr r0, r0, #0x10
	strb r0, [r2, #6]
	ldrb r0, [r8, #6]
	orr r0, r0, #2
	strb r0, [r8, #6]
	b _0216C378
_0216C240:
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1f
	beq _0216C288
	ldrb r0, [r8, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C378
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C378
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r8, #6]
	orr r0, r0, #2
	strb r0, [r8, #6]
	b _0216C378
_0216C288:
	ldrb r0, [r2, #3]
	mov r3, r0, lsl #0x1f
	movs r3, r3, lsr #0x1f
	beq _0216C2D4
	ldrb r0, [r8, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C378
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C378
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r8, #6]
	orr r0, r0, #2
	strb r0, [r8, #6]
	b _0216C378
_0216C2D4:
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _0216C30C
	ldrb r0, [r8, #6]
	mov r1, r0, lsl #0x1e
	movs r1, r1, lsr #0x1f
	bne _0216C378
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	bne _0216C378
	ldrb r0, [r8, #6]
	orr r0, r0, #4
	strb r0, [r8, #6]
	b _0216C378
_0216C30C:
	mov r0, r1, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _0216C358
	ldrb r0, [r8, #6]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	bne _0216C378
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r8, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r8, #6]
	ldrb r0, [r8, #7]
	orr r0, r0, #8
	strb r0, [r8, #7]
	b _0216C378
_0216C358:
	ldrb r0, [r2, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r2, #6]
	ldrb r0, [r8, #6]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r8, #6]
_0216C378:
	ldrh r1, [r4, #4]
	add r0, r6, #1
	mov r0, r0, lsl #0x10
	cmp r1, r0, lsr #16
	mov r6, r0, lsr #0x10
	bhi _0216C048
_0216C390:
	ldrb r0, [r8, #6]
	bic r0, r0, #8
	strb r0, [r8, #6]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0216C3A0: .word exHitCheckTask__unk_2177420
_0216C3A4: .word 0x021774B8
_0216C3A8: .word 0x0217742C
_0216C3AC: .word 0x02177468
_0216C3B0: .word 0x02177440
	arm_func_end exHitCheckTask__DoHitChecks

	arm_func_start exHitCheckTask__Main
exHitCheckTask__Main: // 0x0216C3B4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, _0216C3E8 // =exHitCheckTask__unk_2177420
	mov r1, #0
	strh r1, [r0, #4]
	strh r1, [r0, #0xa]
	strh r1, [r0, #6]
	strh r1, [r0, #8]
	strh r1, [r0, #2]
	bl GetExTaskCurrent
	ldr r1, _0216C3EC // =exHitCheckTask__Main_Active
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216C3E8: .word exHitCheckTask__unk_2177420
_0216C3EC: .word exHitCheckTask__Main_Active
	arm_func_end exHitCheckTask__Main

	arm_func_start exHitCheckTask__Func8
exHitCheckTask__Func8: // 0x0216C3F0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _0216C44C // =_02175D74
	mov r2, #1
	str r2, [r1, #0x10]
	str r2, [r1]
	str r2, [r1, #8]
	str r2, [r1, #0xc]
	str r2, [r1, #4]
	ldr r0, _0216C450 // =exHitCheckTask__unk_2177420
	mov r1, #0
	strh r1, [r0, #4]
	strh r1, [r0, #0xa]
	strh r1, [r0, #6]
	strh r1, [r0, #8]
	strh r1, [r0, #2]
	bl GetExSystemFlag_2178650
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _0216C454 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216C44C: .word _02175D74
_0216C450: .word exHitCheckTask__unk_2177420
_0216C454: .word ExTask_State_Destroy
	arm_func_end exHitCheckTask__Func8

	arm_func_start exHitCheckTask__Destructor
exHitCheckTask__Destructor: // 0x0216C458
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r1, _0216C49C // =_02175D74
	mov r2, #1
	str r2, [r1, #0x10]
	str r2, [r1]
	str r2, [r1, #8]
	str r2, [r1, #0xc]
	ldr r0, _0216C4A0 // =exHitCheckTask__unk_2177420
	str r2, [r1, #4]
	mov r1, #0
	strh r1, [r0, #4]
	strh r1, [r0, #0xa]
	strh r1, [r0, #6]
	strh r1, [r0, #8]
	strh r1, [r0, #2]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216C49C: .word _02175D74
_0216C4A0: .word exHitCheckTask__unk_2177420
	arm_func_end exHitCheckTask__Destructor

	arm_func_start exHitCheckTask__Main_Active
exHitCheckTask__Main_Active: // 0x0216C4A4
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl exHitCheckTask__DoHitChecks
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end exHitCheckTask__Main_Active

	arm_func_start exHitCheckTask__Create
exHitCheckTask__Create: // 0x0216C4C0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	str r4, [sp]
	mov r1, #1
	ldr r0, _0216C518 // =aExhitchecktask
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _0216C51C // =exHitCheckTask__Main
	ldr r1, _0216C520 // =exHitCheckTask__Destructor
	ldr r2, _0216C524 // =0x0000EFFD
	mov r3, #3
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r0, r4
	bl GetExTask
	ldr r1, _0216C528 // =exHitCheckTask__Func8
	str r1, [r0, #8]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0216C518: .word aExhitchecktask
_0216C51C: .word exHitCheckTask__Main
_0216C520: .word exHitCheckTask__Destructor
_0216C524: .word 0x0000EFFD
_0216C528: .word exHitCheckTask__Func8
	arm_func_end exHitCheckTask__Create

	.data
	
_02175D74: // 0x02175D74
    .word 1, 1, 1, 1, 1

aExhitchecktask: // 0x02175D88
	.asciz "exHitCheckTask"