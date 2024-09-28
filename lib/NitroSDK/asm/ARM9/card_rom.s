	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CARDi_GetRomAccessor
CARDi_GetRomAccessor: // 0x020F072C
	ldr r0, _020F0734 // =CARDi_ReadCard
	bx lr
	.align 2, 0
_020F0734: .word CARDi_ReadCard
	arm_func_end CARDi_GetRomAccessor

	arm_func_start CARD_WaitRomAsync
CARD_WaitRomAsync: // 0x020F0738
	ldr ip, _020F0740 // =CARDi_WaitAsync
	bx ip
	.align 2, 0
_020F0740: .word CARDi_WaitAsync
	arm_func_end CARD_WaitRomAsync

	arm_func_start CARD_Init
CARD_Init: // 0x020F0744
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, _020F07BC // =0x021500E0
	ldr r0, [ip, #0x114]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {lr}
	bxne lr
	mov r0, #1
	str r0, [ip, #0x114]
	mov r3, #0
	str r3, [ip, #0x24]
	ldr r0, [ip, #0x24]
	mvn r1, #0
	str r0, [ip, #0x20]
	ldr r2, [ip, #0x20]
	ldr r0, _020F07C0 // =0x02150700
	str r2, [ip, #0x1c]
	str r1, [ip, #0x28]
	str r3, [ip, #0x38]
	str r3, [ip, #0x3c]
	str r3, [r0]
	bl CARDi_InitCommon
	bl CARDi_GetRomAccessor
	ldr r1, _020F07C4 // =0x02150720
	str r0, [r1]
	bl CARD_InitPulledOutCallback
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F07BC: .word 0x021500E0
_020F07C0: .word 0x02150700
_020F07C4: .word 0x02150720
	arm_func_end CARD_Init

	arm_func_start CARDi_ReadRom
CARDi_ReadRom: // 0x020F07C8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r6, _020F08DC // =0x021500E0
	mov r10, r0
	mov r9, r1
	mov r8, r2
	mov r7, r3
	ldr r11, _020F08E0 // =0x02150720
	bl CARD_CheckEnabled
	bl OS_DisableInterrupts
	ldr r1, [r6, #0x114]
	mov r5, r0
	ands r0, r1, #4
	beq _020F0818
	add r4, r6, #0x10c
_020F0804:
	mov r0, r4
	bl OS_SleepThread
	ldr r0, [r6, #0x114]
	ands r0, r0, #4
	bne _020F0804
_020F0818:
	ldr r1, [r6, #0x114]
	ldr r0, [sp, #0x28]
	orr r1, r1, #4
	str r1, [r6, #0x114]
	ldr r1, [sp, #0x2c]
	str r0, [r6, #0x38]
	mov r0, r5
	str r1, [r6, #0x3c]
	bl OS_RestoreInterrupts
	ldr r0, _020F08E4 // =0x02150700
	str r10, [r6, #0x28]
	ldr r0, [r0]
	cmp r10, #3
	add r0, r9, r0
	str r0, [r6, #0x1c]
	str r8, [r6, #0x20]
	str r7, [r6, #0x24]
	bhi _020F0868
	mov r0, r10
	bl MI_StopDma
_020F0868:
	mov r0, r11
	bl CARDi_TryReadCardDma
	cmp r0, #0
	beq _020F089C
	ldr r0, [sp, #0x30]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bxne lr
	bl CARD_WaitRomAsync
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F089C:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	beq _020F08BC
	ldr r0, _020F08E8 // =CARDi_ReadRomSyncCore
	bl CARDi_SetTask
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F08BC:
	ldr r1, _020F08EC // =OSi_ThreadInfo
	mov r0, r6
	ldr r1, [r1, #4]
	str r1, [r6, #0x104]
	bl CARDi_ReadRomSyncCore
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F08DC: .word 0x021500E0
_020F08E0: .word 0x02150720
_020F08E4: .word 0x02150700
_020F08E8: .word CARDi_ReadRomSyncCore
_020F08EC: .word OSi_ThreadInfo
	arm_func_end CARDi_ReadRom

	arm_func_start CARDi_ReadRomSyncCore
CARDi_ReadRomSyncCore: // 0x020F08F0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r4, _020F0994 // =0x02150720
	mov r0, r4
	bl CARDi_ReadFromCache
	cmp r0, #0
	beq _020F0918
	ldr r1, [r4]
	mov r0, r4
	blx r1
_020F0918:
	ldr r7, _020F0998 // =0x021500E0
	bl CARDi_ReadRomIDCore
	bl CARDi_CheckPulledOut
	ldr r0, [r7]
	mov r1, #0
	str r1, [r0]
	ldr r6, [r7, #0x38]
	ldr r5, [r7, #0x3c]
	bl OS_DisableInterrupts
	ldr r1, [r7, #0x114]
	mov r4, r0
	bic r0, r1, #0x4c
	str r0, [r7, #0x114]
	add r0, r7, #0x10c
	bl OS_WakeupThread
	ldr r0, [r7, #0x114]
	ands r0, r0, #0x10
	beq _020F0968
	add r0, r7, #0x44
	bl OS_WakeupThreadDirect
_020F0968:
	mov r0, r4
	bl OS_RestoreInterrupts
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r5
	blx r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F0994: .word 0x02150720
_020F0998: .word 0x021500E0
	arm_func_end CARDi_ReadRomSyncCore

	arm_func_start CARDi_ReadRomIDCore
CARDi_ReadRomIDCore: // 0x020F099C
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r0, #0xb8000000
	mov r1, #0
	bl CARDi_SetRomOp
	ldr r1, _020F09F8 // _0211F9B4
	mov r0, #0x2000
	ldr r1, [r1]
	rsb r0, r0, #0
	ldr r2, [r1, #0x60]
	ldr r1, _020F09FC // =0x040001A4
	bic r2, r2, #0x7000000
	orr r2, r2, #0xa7000000
	and r0, r2, r0
	str r0, [r1]
_020F09D8:
	ldr r0, [r1]
	ands r0, r0, #0x800000
	beq _020F09D8
	ldr r0, _020F0A00 // =0x04100010
	ldr r0, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_020F09F8: .word _0211F9B4
_020F09FC: .word 0x040001A4
_020F0A00: .word 0x04100010
	arm_func_end CARDi_ReadRomIDCore

	arm_func_start CARDi_ReadCard
CARDi_ReadCard: // 0x020F0A04
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	ldr r9, _020F0AF8 // =0x021500E0
	add r7, r10, #0x20
	ldr r5, _020F0AFC // =0x04100010
	ldr r6, _020F0B00 // =0x040001A4
	mov r11, #0
	mov r0, #0x200
	rsb r4, r0, #0
_020F0A2C:
	ldr r0, [r9, #0x1c]
	and r1, r0, r4
	cmp r1, r0
	bne _020F0A54
	ldr r8, [r9, #0x20]
	ands r0, r8, #3
	bne _020F0A54
	ldr r0, [r9, #0x24]
	cmp r0, #0x200
	bhs _020F0A5C
_020F0A54:
	mov r8, r7
	str r1, [r10, #8]
_020F0A5C:
	mov r0, r1, lsr #8
	orr r0, r0, #0xb7000000
	mov r1, r1, lsl #0x18
	bl CARDi_SetRomOp
	ldr r1, [r10, #4]
	mov r0, r11
	str r1, [r6]
_020F0A78:
	ldr r2, [r6]
	ands r1, r2, #0x800000
	beq _020F0A94
	ldr r1, [r5]
	cmp r0, #0x200
	strlo r1, [r8, r0, lsl #2]
	addlo r0, r0, #1
_020F0A94:
	ands r1, r2, #0x80000000
	bne _020F0A78
	ldr r0, [r9, #0x20]
	cmp r8, r0
	bne _020F0ADC
	ldr r2, [r9, #0x1c]
	ldr r1, [r9, #0x20]
	ldr r0, [r9, #0x24]
	add r2, r2, #0x200
	add r1, r1, #0x200
	subs r0, r0, #0x200
	str r2, [r9, #0x1c]
	str r1, [r9, #0x20]
	str r0, [r9, #0x24]
	bne _020F0A2C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
_020F0ADC:
	mov r0, r10
	bl CARDi_ReadFromCache
	cmp r0, #0
	bne _020F0A2C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F0AF8: .word 0x021500E0
_020F0AFC: .word 0x04100010
_020F0B00: .word 0x040001A4
	arm_func_end CARDi_ReadCard

	arm_func_start CARDi_TryReadCardDma
CARDi_TryReadCardDma: // 0x020F0B04
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r11, _020F0C64 // =0x021500E0
	mov r7, #0
	ldr r9, [r11, #0x20]
	mov r10, r0
	mov r6, r7
	mov r5, r7
	mov r1, r7
	ands r4, r9, #0x1f
	ldr r8, [r11, #0x24]
	bne _020F0B40
	ldr r0, [r11, #0x28]
	cmp r0, #3
	movls r1, #1
_020F0B40:
	cmp r1, #0
	beq _020F0B94
	bl OS_GetDTCMAddress
	ldr r1, _020F0C68 // =objDiffAttrSet
	add r2, r9, r8
	cmp r2, r1
	mov r3, #1
	mov r1, #0
	bls _020F0B6C
	cmp r9, #0x2000000
	movlo r1, r3
_020F0B6C:
	cmp r1, #0
	bne _020F0B8C
	cmp r0, r2
	bhs _020F0B88
	add r0, r0, #0x4000
	cmp r0, r9
	bhi _020F0B8C
_020F0B88:
	mov r3, #0
_020F0B8C:
	cmp r3, #0
	moveq r5, #1
_020F0B94:
	cmp r5, #0
	beq _020F0BB0
	ldr r1, [r11, #0x1c]
	ldr r0, _020F0C6C // =0x000001FF
	orr r1, r1, r8
	ands r0, r1, r0
	moveq r6, #1
_020F0BB0:
	cmp r6, #0
	beq _020F0BC0
	cmp r8, #0
	movne r7, #1
_020F0BC0:
	ldr r0, _020F0C70 // _0211F9B4
	cmp r7, #0
	ldr r0, [r0]
	ldr r0, [r0, #0x60]
	bic r0, r0, #0x7000000
	orr r0, r0, #0xa1000000
	str r0, [r10, #4]
	beq _020F0C54
	bl OS_DisableInterrupts
	mov r5, r0
	mov r0, r9
	mov r1, r8
	bl IC_InvalidateRange
	cmp r4, #0
	beq _020F0C1C
	sub r9, r9, r4
	mov r0, r9
	mov r1, #0x20
	bl DC_StoreRange
	add r0, r9, r8
	mov r1, #0x20
	bl DC_StoreRange
	add r8, r8, #0x20
_020F0C1C:
	mov r0, r9
	mov r1, r8
	bl DC_InvalidateRange
	bl DC_WaitWriteBufferEmpty
	ldr r1, _020F0C74 // =CARDi_OnReadCard
	mov r0, #0x80000
	bl OS_SetIrqFunction
	mov r0, #0x80000
	bl OS_ResetRequestIrqMask
	mov r0, #0x80000
	bl OS_EnableIrqMask
	mov r0, r5
	bl OS_RestoreInterrupts
	bl CARDi_SetCardDma
_020F0C54:
	mov r0, r7
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_020F0C64: .word 0x021500E0
_020F0C68: .word objDiffAttrSet
_020F0C6C: .word 0x000001FF
_020F0C70: .word _0211F9B4
_020F0C74: .word CARDi_OnReadCard
	arm_func_end CARDi_TryReadCardDma

	arm_func_start CARDi_OnReadCard
CARDi_OnReadCard: // 0x020F0C78
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r0, _020F0D54 // =0x021500E0
	ldr r0, [r0, #0x28]
	bl MI_StopDma
	ldr r0, _020F0D54 // =0x021500E0
	ldr r3, [r0, #0x1c]
	ldr r2, [r0, #0x20]
	ldr r1, [r0, #0x24]
	add r3, r3, #0x200
	add r2, r2, #0x200
	subs r1, r1, #0x200
	str r3, [r0, #0x1c]
	str r2, [r0, #0x20]
	str r1, [r0, #0x24]
	bne _020F0D44
	mov r0, #0x80000
	bl OS_DisableIrqMask
	mov r0, #0x80000
	bl OS_ResetRequestIrqMask
	ldr r7, _020F0D54 // =0x021500E0
	bl CARDi_ReadRomIDCore
	bl CARDi_CheckPulledOut
	ldr r0, [r7]
	mov r1, #0
	str r1, [r0]
	ldr r6, [r7, #0x38]
	ldr r5, [r7, #0x3c]
	bl OS_DisableInterrupts
	ldr r1, [r7, #0x114]
	mov r4, r0
	bic r0, r1, #0x4c
	str r0, [r7, #0x114]
	add r0, r7, #0x10c
	bl OS_WakeupThread
	ldr r0, [r7, #0x114]
	ands r0, r0, #0x10
	beq _020F0D18
	add r0, r7, #0x44
	bl OS_WakeupThreadDirect
_020F0D18:
	mov r0, r4
	bl OS_RestoreInterrupts
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	bxeq lr
	mov r0, r5
	blx r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
_020F0D44:
	bl CARDi_SetCardDma
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_020F0D54: .word 0x021500E0
	arm_func_end CARDi_OnReadCard

	arm_func_start CARDi_SetCardDma
CARDi_SetCardDma: // 0x020F0D58
	stmdb sp!, {r4, lr}
	ldr r4, _020F0DA0 // =0x021500E0
	ldr r1, _020F0DA4 // =0x04100010
	ldr r0, [r4, #0x28]
	ldr r2, [r4, #0x20]
	mov r3, #0x200
	bl MIi_CardDmaCopy32
	ldr r1, [r4, #0x1c]
	mov r0, r1, lsr #8
	orr r0, r0, #0xb7000000
	mov r1, r1, lsl #0x18
	bl CARDi_SetRomOp
	ldr r0, _020F0DA8 // =0x02150720
	ldr r1, _020F0DAC // =0x040001A4
	ldr r0, [r0, #4]
	str r0, [r1]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_020F0DA0: .word 0x021500E0
_020F0DA4: .word 0x04100010
_020F0DA8: .word 0x02150720
_020F0DAC: .word 0x040001A4
	arm_func_end CARDi_SetCardDma

	arm_func_start CARDi_SetRomOp
CARDi_SetRomOp: // 0x020F0DB0
	ldr r3, _020F0E28 // =0x040001A4
_020F0DB4:
	ldr r2, [r3]
	ands r2, r2, #0x80000000
	bne _020F0DB4
	ldr r3, _020F0E2C // =0x040001A1
	mov ip, #0xc0
	ldr r2, _020F0E30 // =0x040001A8
	strb ip, [r3]
	mov ip, r0, lsr #0x18
	ldr r3, _020F0E34 // =0x040001A9
	strb ip, [r2]
	mov ip, r0, lsr #0x10
	ldr r2, _020F0E38 // =0x040001AA
	strb ip, [r3]
	mov ip, r0, lsr #8
	ldr r3, _020F0E3C // =0x040001AB
	strb ip, [r2]
	ldr r2, _020F0E40 // =0x040001AC
	strb r0, [r3]
	mov r3, r1, lsr #0x18
	ldr r0, _020F0E44 // =0x040001AD
	strb r3, [r2]
	mov r3, r1, lsr #0x10
	ldr r2, _020F0E48 // =0x040001AE
	strb r3, [r0]
	mov r3, r1, lsr #8
	ldr r0, _020F0E4C // =0x040001AF
	strb r3, [r2]
	strb r1, [r0]
	bx lr
	.align 2, 0
_020F0E28: .word 0x040001A4
_020F0E2C: .word 0x040001A1
_020F0E30: .word 0x040001A8
_020F0E34: .word 0x040001A9
_020F0E38: .word 0x040001AA
_020F0E3C: .word 0x040001AB
_020F0E40: .word 0x040001AC
_020F0E44: .word 0x040001AD
_020F0E48: .word 0x040001AE
_020F0E4C: .word 0x040001AF
	arm_func_end CARDi_SetRomOp

	arm_func_start CARDi_ReadFromCache
CARDi_ReadFromCache: // 0x020F0E50
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r5, _020F0EE4 // =0x021500E0
	mov r1, #0x200
	ldr r3, [r5, #0x1c]
	rsb r1, r1, #0
	ldr r2, [r0, #8]
	and r3, r3, r1
	cmp r3, r2
	bne _020F0EC8
	ldr r2, [r5, #0x1c]
	ldr r1, [r5, #0x24]
	sub r3, r2, r3
	rsb r4, r3, #0x200
	cmp r4, r1
	movhi r4, r1
	add r0, r0, #0x20
	ldr r1, [r5, #0x20]
	mov r2, r4
	add r0, r0, r3
	bl MI_CpuCopy8
	ldr r0, [r5, #0x1c]
	add r0, r0, r4
	str r0, [r5, #0x1c]
	ldr r0, [r5, #0x20]
	add r0, r0, r4
	str r0, [r5, #0x20]
	ldr r0, [r5, #0x24]
	sub r0, r0, r4
	str r0, [r5, #0x24]
_020F0EC8:
	ldr r0, [r5, #0x24]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_020F0EE4: .word 0x021500E0
	arm_func_end CARDi_ReadFromCache

	.data

_0211F9B4: // 0x0211F9B4
    .word 0x27FFE00
