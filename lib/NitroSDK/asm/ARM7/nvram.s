	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start NvramCheckReadyToWrite
NvramCheckReadyToWrite: // 0x027F5B74
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r0, sp, #0
	bl NVRAM_ReadStatusRegister
	ldrh r1, [sp]
	ands r0, r1, #1
	movne r0, #0
	bne _027F5BA0
	ands r0, r1, #2
	movne r0, #1
	moveq r0, #0
_027F5BA0:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end NvramCheckReadyToWrite

	arm_func_start NvramCheckReadyToRead
NvramCheckReadyToRead: // 0x027F5BAC
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r0, sp, #0
	bl NVRAM_ReadStatusRegister
	ldrh r0, [sp]
	ands r0, r0, #1
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end NvramCheckReadyToRead

	arm_func_start NVRAM_ExecuteProcess
NVRAM_ExecuteProcess: // 0x027F5BD8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	bl OS_DisableInterrupts
	mov r5, r0
	mov r0, #1
	bl SPIi_CheckException
	cmp r0, #0
	bne _027F5C1C
	mov r0, r5
	bl OS_RestoreInterrupts
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #4
	bl SPIi_ReturnResult
	b _027F5EA8
_027F5C1C:
	mov r0, #1
	bl SPIi_GetException
	mov r0, r5
	bl OS_RestoreInterrupts
	ldr r0, [r4, #4]
	sub r0, r0, #0x20
	cmp r0, #0xd
	addls pc, pc, r0, lsl #2
	b _027F5E6C
_027F5C40: // jump table
	b _027F5C78 // case 0
	b _027F5C80 // case 1
	b _027F5C88 // case 2
	b _027F5C94 // case 3
	b _027F5CD4 // case 4
	b _027F5D14 // case 5
	b _027F5D5C // case 6
	b _027F5DA4 // case 7
	b _027F5DDC // case 8
	b _027F5E14 // case 9
	b _027F5E1C // case 10
	b _027F5E24 // case 11
	b _027F5E58 // case 12
	b _027F5E64 // case 13
_027F5C78:
	bl NVRAM_WriteEnable
	b _027F5E8C
_027F5C80:
	bl NVRAM_WriteDisable
	b _027F5E8C
_027F5C88:
	ldr r0, [r4, #0x10]
	bl NVRAM_ReadStatusRegister
	b _027F5E8C
_027F5C94:
	bl NvramCheckReadyToRead
	cmp r0, #0
	bne _027F5CC0
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SPIi_ReturnResult
	mov r0, #1
	bl SPIi_ReleaseException
	b _027F5EA8
_027F5CC0:
	ldr r0, [r4, #8]
	ldr r1, [r4, #0xc]
	ldr r2, [r4, #0x10]
	bl NVRAM_ReadDataBytes
	b _027F5E8C
_027F5CD4:
	bl NvramCheckReadyToRead
	cmp r0, #0
	bne _027F5D00
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SPIi_ReturnResult
	mov r0, #1
	bl SPIi_ReleaseException
	b _027F5EA8
_027F5D00:
	ldr r0, [r4, #8]
	ldr r1, [r4, #0xc]
	ldr r2, [r4, #0x10]
	bl NVRAM_ReadDataBytesAtHigherSpeed
	b _027F5E8C
_027F5D14:
	bl NvramCheckReadyToWrite
	cmp r0, #0
	bne _027F5D40
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SPIi_ReturnResult
	mov r0, #1
	bl SPIi_ReleaseException
	b _027F5EA8
_027F5D40:
	ldr r0, [r4, #8]
	ldr r1, [r4, #0xc]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ldr r2, [r4, #0x10]
	bl NVRAM_PageWrite
	b _027F5E8C
_027F5D5C:
	bl NvramCheckReadyToWrite
	cmp r0, #0
	bne _027F5D88
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SPIi_ReturnResult
	mov r0, #1
	bl SPIi_ReleaseException
	b _027F5EA8
_027F5D88:
	ldr r0, [r4, #8]
	ldr r1, [r4, #0xc]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	ldr r2, [r4, #0x10]
	bl NVRAM_PageProgram
	b _027F5E8C
_027F5DA4:
	bl NvramCheckReadyToWrite
	cmp r0, #0
	bne _027F5DD0
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SPIi_ReturnResult
	mov r0, #1
	bl SPIi_ReleaseException
	b _027F5EA8
_027F5DD0:
	ldr r0, [r4, #8]
	bl NVRAM_PageErase
	b _027F5E8C
_027F5DDC:
	bl NvramCheckReadyToWrite
	cmp r0, #0
	bne _027F5E08
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SPIi_ReturnResult
	mov r0, #1
	bl SPIi_ReleaseException
	b _027F5EA8
_027F5E08:
	ldr r0, [r4, #8]
	bl NVRAM_SectorErase
	b _027F5E8C
_027F5E14:
	bl NVRAM_DeepPowerDown
	b _027F5E8C
_027F5E1C:
	bl NVRAM_ReleaseFromDeepPowerDown
	b _027F5E8C
_027F5E24:
	bl NvramCheckReadyToWrite
	cmp r0, #0
	bne _027F5E50
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #3
	bl SPIi_ReturnResult
	mov r0, #1
	bl SPIi_ReleaseException
	b _027F5EA8
_027F5E50:
	bl NVRAM_ChipErase
	b _027F5E8C
_027F5E58:
	ldr r0, [r4, #0x10]
	bl NVRAM_ReadSiliconId
	b _027F5E8C
_027F5E64:
	bl NVRAM_SoftwareReset
	b _027F5E8C
_027F5E6C:
	mov r0, #1
	bl SPIi_ReleaseException
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #1
	bl SPIi_ReturnResult
	b _027F5EA8
_027F5E8C:
	ldr r0, [r4, #4]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, #0
	bl SPIi_ReturnResult
	mov r0, #1
	bl SPIi_ReleaseException
_027F5EA8:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end NVRAM_ExecuteProcess

	arm_func_start NVRAM_AnalyzeCommand
NVRAM_AnalyzeCommand: // 0x027F5EB4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ands r1, r0, #0x2000000
	beq _027F5EE4
	mov r5, #0
	mov lr, r5
	ldr r1, _027F6054 // =0x027F99E4
_027F5ED0:
	mov r4, r5, lsl #1
	strh lr, [r1, r4]
	add r5, r5, #1
	cmp r5, #0x10
	blt _027F5ED0
_027F5EE4:
	and r1, r0, #0xf0000
	mov r1, r1, lsr #0x10
	mov r4, r1, lsl #1
	ldr r1, _027F6054 // =0x027F99E4
	strh r0, [r1, r4]
	ands r0, r0, #0x1000000
	beq _027F6048
	ldrh r0, [r1]
	and r4, r0, #0xff00
	mov r4, r4, lsl #8
	mov r4, r4, lsr #0x10
	sub lr, r4, #0x22
	cmp lr, #0xa
	addls pc, pc, lr, lsl #2
	b _027F601C
_027F5F20: // jump table
	b _027F5F4C // case 0
	b _027F5F88 // case 1
	b _027F5F88 // case 2
	b _027F5FD0 // case 3
	b _027F5FD0 // case 4
	b _027F6010 // case 5
	b _027F6010 // case 6
	b _027F601C // case 7
	b _027F601C // case 8
	b _027F601C // case 9
	b _027F5F4C // case 10
_027F5F4C:
	ldrh ip, [r1, #4]
	and lr, ip, #0xff00
	and r0, r0, #0xff
	mov ip, r0, lsl #0x18
	ldrh r0, [r1, #2]
	orr r0, ip, r0, lsl #8
	orr ip, r0, lr, lsr #8
	cmp ip, #0x2000000
	blo _027F5F78
	cmp ip, #0x2800000
	blo _027F601C
_027F5F78:
	mov r0, r4
	mov r1, #2
	bl SPIi_ReturnResult
	b _027F6048
_027F5F88:
	ldrh r3, [r1, #8]
	ldrh r2, [r1, #0xa]
	orr ip, r2, r3, lsl #16
	cmp ip, #0x2000000
	blo _027F5FA4
	cmp ip, #0x2800000
	blo _027F5FB4
_027F5FA4:
	mov r0, r4
	mov r1, #2
	bl SPIi_ReturnResult
	b _027F6048
_027F5FB4:
	and r2, r0, #0xff
	ldrh r0, [r1, #2]
	orr r3, r0, r2, lsl #16
	ldrh r2, [r1, #4]
	ldrh r0, [r1, #6]
	orr r2, r0, r2, lsl #16
	b _027F601C
_027F5FD0:
	ldrh r3, [r1, #6]
	ldrh r2, [r1, #8]
	orr ip, r2, r3, lsl #16
	cmp ip, #0x2000000
	blo _027F5FEC
	cmp ip, #0x2800000
	blo _027F5FFC
_027F5FEC:
	mov r0, r4
	mov r1, #2
	bl SPIi_ReturnResult
	b _027F6048
_027F5FFC:
	and r2, r0, #0xff
	ldrh r0, [r1, #2]
	orr r3, r0, r2, lsl #16
	ldrh r2, [r1, #4]
	b _027F601C
_027F6010:
	and r3, r0, #0xff
	ldrh r0, [r1, #2]
	orr r3, r0, r3, lsl #16
_027F601C:
	str r2, [sp]
	str ip, [sp, #4]
	mov r0, #1
	mov r1, r4
	mov r2, #3
	bl SPIi_SetEntry
	cmp r0, #0
	bne _027F6048
	mov r0, r4
	mov r1, #4
	bl SPIi_ReturnResult
_027F6048:
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_027F6054: .word 0x027F99E4
	arm_func_end NVRAM_AnalyzeCommand

	arm_func_start NVRAM_Init
NVRAM_Init: // 0x027F6058
	mov r3, #0
	mov r2, r3
	ldr r0, _027F607C // =0x027F99E4
_027F6064:
	mov r1, r3, lsl #1
	strh r2, [r0, r1]
	add r3, r3, #1
	cmp r3, #0x10
	blt _027F6064
	bx lr
	.align 2, 0
_027F607C: .word 0x027F99E4
	arm_func_end NVRAM_Init

	arm_func_start NVRAM_SoftwareReset
NVRAM_SoftwareReset: // 0x027F6080
	ldr r1, _027F60B8 // =0x040001C0
_027F6084:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F6084
	mov r0, #0x8100
	strh r0, [r1]
	mov r1, #0xff
	ldr r0, _027F60BC // =0x040001C2
	strh r1, [r0]
	ldr r1, _027F60B8 // =0x040001C0
_027F60A8:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F60A8
	bx lr
	.align 2, 0
_027F60B8: .word 0x040001C0
_027F60BC: .word 0x040001C2
	arm_func_end NVRAM_SoftwareReset

	arm_func_start NVRAM_ReadSiliconId
NVRAM_ReadSiliconId: // 0x027F60C0
	ldr r2, _027F6154 // =0x040001C0
_027F60C4:
	ldrh r1, [r2]
	ands r1, r1, #0x80
	bne _027F60C4
	mov r1, #0x8900
	strh r1, [r2]
	mov r2, #0x9f
	ldr r1, _027F6158 // =0x040001C2
	strh r2, [r1]
	ldr r2, _027F6154 // =0x040001C0
_027F60E8:
	ldrh r1, [r2]
	ands r1, r1, #0x80
	bne _027F60E8
	mov r2, #0
	ldr r1, _027F6158 // =0x040001C2
	strh r2, [r1]
	ldr r3, _027F6154 // =0x040001C0
_027F6104:
	ldrh r1, [r3]
	ands r1, r1, #0x80
	bne _027F6104
	ldr r2, _027F6158 // =0x040001C2
	ldrh r1, [r2]
	and r1, r1, #0xff
	strb r1, [r0]
	mov r1, #0x8100
	strh r1, [r3]
	mov r1, #0
	strh r1, [r2]
	ldr r2, _027F6154 // =0x040001C0
_027F6134:
	ldrh r1, [r2]
	ands r1, r1, #0x80
	bne _027F6134
	ldr r1, _027F6158 // =0x040001C2
	ldrh r1, [r1]
	and r1, r1, #0xff
	strb r1, [r0, #1]
	bx lr
	.align 2, 0
_027F6154: .word 0x040001C0
_027F6158: .word 0x040001C2
	arm_func_end NVRAM_ReadSiliconId

	arm_func_start NVRAM_ChipErase
NVRAM_ChipErase: // 0x027F615C
	ldr r1, _027F6194 // =0x040001C0
_027F6160:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F6160
	mov r0, #0x8100
	strh r0, [r1]
	mov r1, #0xc7
	ldr r0, _027F6198 // =0x040001C2
	strh r1, [r0]
	ldr r1, _027F6194 // =0x040001C0
_027F6184:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F6184
	bx lr
	.align 2, 0
_027F6194: .word 0x040001C0
_027F6198: .word 0x040001C2
	arm_func_end NVRAM_ChipErase

	arm_func_start NVRAM_ReleaseFromDeepPowerDown
NVRAM_ReleaseFromDeepPowerDown: // 0x027F619C
	ldr r1, _027F61D4 // =0x040001C0
_027F61A0:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F61A0
	mov r0, #0x8100
	strh r0, [r1]
	mov r1, #0xab
	ldr r0, _027F61D8 // =0x040001C2
	strh r1, [r0]
	ldr r1, _027F61D4 // =0x040001C0
_027F61C4:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F61C4
	bx lr
	.align 2, 0
_027F61D4: .word 0x040001C0
_027F61D8: .word 0x040001C2
	arm_func_end NVRAM_ReleaseFromDeepPowerDown

	arm_func_start NVRAM_DeepPowerDown
NVRAM_DeepPowerDown: // 0x027F61DC
	ldr r1, _027F6214 // =0x040001C0
_027F61E0:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F61E0
	mov r0, #0x8100
	strh r0, [r1]
	mov r1, #0xb9
	ldr r0, _027F6218 // =0x040001C2
	strh r1, [r0]
	ldr r1, _027F6214 // =0x040001C0
_027F6204:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F6204
	bx lr
	.align 2, 0
_027F6214: .word 0x040001C0
_027F6218: .word 0x040001C2
	arm_func_end NVRAM_DeepPowerDown

	arm_func_start NVRAM_SectorErase
NVRAM_SectorErase: // 0x027F621C
	and r1, r0, #0xff0000
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	and r1, r0, #0xff00
	mov r1, r1, lsl #8
	mov r1, r1, lsr #0x10
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr ip, _027F62D8 // =0x040001C0
_027F6248:
	ldrh r3, [ip]
	ands r3, r3, #0x80
	bne _027F6248
	mov r3, #0x8900
	strh r3, [ip]
	mov ip, #0xd8
	ldr r3, _027F62DC // =0x040001C2
	strh ip, [r3]
	ldr ip, _027F62D8 // =0x040001C0
_027F626C:
	ldrh r3, [ip]
	ands r3, r3, #0x80
	bne _027F626C
	and r3, r2, #0xff
	ldr r2, _027F62DC // =0x040001C2
	strh r3, [r2]
	ldr r3, _027F62D8 // =0x040001C0
_027F6288:
	ldrh r2, [r3]
	ands r2, r2, #0x80
	bne _027F6288
	and r2, r1, #0xff
	ldr r1, _027F62DC // =0x040001C2
	strh r2, [r1]
	ldr r2, _027F62D8 // =0x040001C0
_027F62A4:
	ldrh r1, [r2]
	ands r1, r1, #0x80
	bne _027F62A4
	mov r1, #0x8100
	strh r1, [r2]
	and r1, r0, #0xff
	ldr r0, _027F62DC // =0x040001C2
	strh r1, [r0]
	ldr r1, _027F62D8 // =0x040001C0
_027F62C8:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F62C8
	bx lr
	.align 2, 0
_027F62D8: .word 0x040001C0
_027F62DC: .word 0x040001C2
	arm_func_end NVRAM_SectorErase

	arm_func_start NVRAM_PageErase
NVRAM_PageErase: // 0x027F62E0
	and r1, r0, #0xff0000
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r2, r1, lsr #0x10
	and r1, r0, #0xff00
	mov r1, r1, lsl #8
	mov r1, r1, lsr #0x10
	and r0, r0, #0xff
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldr ip, _027F639C // =0x040001C0
_027F630C:
	ldrh r3, [ip]
	ands r3, r3, #0x80
	bne _027F630C
	mov r3, #0x8900
	strh r3, [ip]
	mov ip, #0xdb
	ldr r3, _027F63A0 // =0x040001C2
	strh ip, [r3]
	ldr ip, _027F639C // =0x040001C0
_027F6330:
	ldrh r3, [ip]
	ands r3, r3, #0x80
	bne _027F6330
	and r3, r2, #0xff
	ldr r2, _027F63A0 // =0x040001C2
	strh r3, [r2]
	ldr r3, _027F639C // =0x040001C0
_027F634C:
	ldrh r2, [r3]
	ands r2, r2, #0x80
	bne _027F634C
	and r2, r1, #0xff
	ldr r1, _027F63A0 // =0x040001C2
	strh r2, [r1]
	ldr r2, _027F639C // =0x040001C0
_027F6368:
	ldrh r1, [r2]
	ands r1, r1, #0x80
	bne _027F6368
	mov r1, #0x8100
	strh r1, [r2]
	and r1, r0, #0xff
	ldr r0, _027F63A0 // =0x040001C2
	strh r1, [r0]
	ldr r1, _027F639C // =0x040001C0
_027F638C:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F638C
	bx lr
	.align 2, 0
_027F639C: .word 0x040001C0
_027F63A0: .word 0x040001C2
	arm_func_end NVRAM_PageErase

	arm_func_start NVRAM_PageProgram
NVRAM_PageProgram: // 0x027F63A4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	cmp r1, #1
	blo _027F64BC
	add r3, r0, r1
	sub r3, r3, #1
	mov r3, r3, lsr #8
	cmp r3, r0, lsr #8
	andhi r1, r0, #0xff
	rsbhi r1, r1, #0x100
	movhi r1, r1, lsl #0x10
	movhi r1, r1, lsr #0x10
	and r3, r0, #0xff0000
	mov r3, r3, lsr #0x10
	strh r3, [sp]
	and r3, r0, #0xff00
	mov r3, r3, lsr #8
	strh r3, [sp, #2]
	and r0, r0, #0xff
	strh r0, [sp, #4]
	ldr r3, _027F64C8 // =0x040001C0
_027F63F8:
	ldrh r0, [r3]
	ands r0, r0, #0x80
	bne _027F63F8
	mov r0, #0x8900
	strh r0, [r3]
	mov r0, #2
	ldr lr, _027F64CC // =0x040001C2
	strh r0, [lr]
	mov r4, #0
	add r3, sp, #0
	ldr ip, _027F64C8 // =0x040001C0
_027F6424:
	ldrh r0, [ip]
	ands r0, r0, #0x80
	bne _027F6424
	mov r0, r4, lsl #1
	ldrh r0, [r3, r0]
	and r0, r0, #0xff
	strh r0, [lr]
	add r4, r4, #1
	cmp r4, #3
	blt _027F6424
	mov ip, #0
	sub lr, r1, #1
	ldr r3, _027F64C8 // =0x040001C0
	ldr r0, _027F64CC // =0x040001C2
	b _027F647C
_027F6460:
	ldrh r1, [r3]
	ands r1, r1, #0x80
	bne _027F6460
	ldrb r1, [r2, ip]
	and r1, r1, #0xff
	strh r1, [r0]
	add ip, ip, #1
_027F647C:
	cmp ip, lr
	blt _027F6460
	ldr r1, _027F64C8 // =0x040001C0
_027F6488:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F6488
	mov r0, #0x8100
	strh r0, [r1]
	ldrb r0, [r2, ip]
	and r1, r0, #0xff
	ldr r0, _027F64CC // =0x040001C2
	strh r1, [r0]
	ldr r1, _027F64C8 // =0x040001C0
_027F64B0:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F64B0
_027F64BC:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F64C8: .word 0x040001C0
_027F64CC: .word 0x040001C2
	arm_func_end NVRAM_PageProgram

	arm_func_start NVRAM_PageWrite
NVRAM_PageWrite: // 0x027F64D0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	cmp r1, #1
	blo _027F65E8
	add r3, r0, r1
	sub r3, r3, #1
	mov r3, r3, lsr #8
	cmp r3, r0, lsr #8
	andhi r1, r0, #0xff
	rsbhi r1, r1, #0x100
	movhi r1, r1, lsl #0x10
	movhi r1, r1, lsr #0x10
	and r3, r0, #0xff0000
	mov r3, r3, lsr #0x10
	strh r3, [sp]
	and r3, r0, #0xff00
	mov r3, r3, lsr #8
	strh r3, [sp, #2]
	and r0, r0, #0xff
	strh r0, [sp, #4]
	ldr r3, _027F65F4 // =0x040001C0
_027F6524:
	ldrh r0, [r3]
	ands r0, r0, #0x80
	bne _027F6524
	mov r0, #0x8900
	strh r0, [r3]
	mov r0, #0xa
	ldr lr, _027F65F8 // =0x040001C2
	strh r0, [lr]
	mov r4, #0
	add r3, sp, #0
	ldr ip, _027F65F4 // =0x040001C0
_027F6550:
	ldrh r0, [ip]
	ands r0, r0, #0x80
	bne _027F6550
	mov r0, r4, lsl #1
	ldrh r0, [r3, r0]
	and r0, r0, #0xff
	strh r0, [lr]
	add r4, r4, #1
	cmp r4, #3
	blt _027F6550
	mov ip, #0
	sub lr, r1, #1
	ldr r3, _027F65F4 // =0x040001C0
	ldr r0, _027F65F8 // =0x040001C2
	b _027F65A8
_027F658C:
	ldrh r1, [r3]
	ands r1, r1, #0x80
	bne _027F658C
	ldrb r1, [r2, ip]
	and r1, r1, #0xff
	strh r1, [r0]
	add ip, ip, #1
_027F65A8:
	cmp ip, lr
	blt _027F658C
	ldr r1, _027F65F4 // =0x040001C0
_027F65B4:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F65B4
	mov r0, #0x8100
	strh r0, [r1]
	ldrb r0, [r2, ip]
	and r1, r0, #0xff
	ldr r0, _027F65F8 // =0x040001C2
	strh r1, [r0]
	ldr r1, _027F65F4 // =0x040001C0
_027F65DC:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F65DC
_027F65E8:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F65F4: .word 0x040001C0
_027F65F8: .word 0x040001C2
	arm_func_end NVRAM_PageWrite

	arm_func_start NVRAM_ReadDataBytesAtHigherSpeed
NVRAM_ReadDataBytesAtHigherSpeed: // 0x027F65FC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	cmp r1, #1
	blo _027F6724
	and r3, r0, #0xff0000
	mov r3, r3, lsr #0x10
	strh r3, [sp]
	and r3, r0, #0xff00
	mov r3, r3, lsr #8
	strh r3, [sp, #2]
	and r0, r0, #0xff
	strh r0, [sp, #4]
	ldr r3, _027F6730 // =0x040001C0
_027F6630:
	ldrh r0, [r3]
	ands r0, r0, #0x80
	bne _027F6630
	mov r0, #0x8900
	strh r0, [r3]
	mov r0, #0xb
	ldr ip, _027F6734 // =0x040001C2
	strh r0, [ip]
	mov lr, #0
	add r3, sp, #0
	ldr r4, _027F6730 // =0x040001C0
_027F665C:
	ldrh r0, [r4]
	ands r0, r0, #0x80
	bne _027F665C
	mov r0, lr, lsl #1
	ldrh r0, [r3, r0]
	and r0, r0, #0xff
	strh r0, [ip]
	add lr, lr, #1
	cmp lr, #3
	blt _027F665C
	ldr r3, _027F6730 // =0x040001C0
_027F6688:
	ldrh r0, [r3]
	ands r0, r0, #0x80
	bne _027F6688
	mov r3, #0
	ldr r0, _027F6734 // =0x040001C2
	strh r3, [r0]
	ldr r3, _027F6730 // =0x040001C0
_027F66A4:
	ldrh r0, [r3]
	ands r0, r0, #0x80
	bne _027F66A4
	mov r0, #0
	ldr ip, _027F6730 // =0x040001C0
	mov r4, r0
	ldr lr, _027F6734 // =0x040001C2
	sub r1, r1, #1
	b _027F66E8
_027F66C8:
	strh r4, [lr]
_027F66CC:
	ldrh r3, [ip]
	ands r3, r3, #0x80
	bne _027F66CC
	ldrh r3, [lr]
	and r3, r3, #0xff
	strb r3, [r2, r0]
	add r0, r0, #1
_027F66E8:
	cmp r0, r1
	blo _027F66C8
	mov r1, #0x8100
	ldr ip, _027F6730 // =0x040001C0
	strh r1, [ip]
	mov r3, #0
	ldr r1, _027F6734 // =0x040001C2
	strh r3, [r1]
_027F6708:
	ldrh r1, [ip]
	ands r1, r1, #0x80
	bne _027F6708
	ldr r1, _027F6734 // =0x040001C2
	ldrh r1, [r1]
	and r1, r1, #0xff
	strb r1, [r2, r0]
_027F6724:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F6730: .word 0x040001C0
_027F6734: .word 0x040001C2
	arm_func_end NVRAM_ReadDataBytesAtHigherSpeed

	arm_func_start NVRAM_ReadDataBytes
NVRAM_ReadDataBytes: // 0x027F6738
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	cmp r1, #1
	blo _027F6844
	and r3, r0, #0xff0000
	mov r3, r3, lsr #0x10
	strh r3, [sp]
	and r3, r0, #0xff00
	mov r3, r3, lsr #8
	strh r3, [sp, #2]
	and r0, r0, #0xff
	strh r0, [sp, #4]
	ldr r3, _027F6850 // =0x040001C0
_027F676C:
	ldrh r0, [r3]
	ands r0, r0, #0x80
	bne _027F676C
	mov r0, #0x8900
	strh r0, [r3]
	mov r0, #3
	ldr ip, _027F6854 // =0x040001C2
	strh r0, [ip]
	mov lr, #0
	add r3, sp, #0
	ldr r4, _027F6850 // =0x040001C0
_027F6798:
	ldrh r0, [r4]
	ands r0, r0, #0x80
	bne _027F6798
	mov r0, lr, lsl #1
	ldrh r0, [r3, r0]
	and r0, r0, #0xff
	strh r0, [ip]
	add lr, lr, #1
	cmp lr, #3
	blt _027F6798
	ldr r3, _027F6850 // =0x040001C0
_027F67C4:
	ldrh r0, [r3]
	ands r0, r0, #0x80
	bne _027F67C4
	mov r0, #0
	ldr ip, _027F6850 // =0x040001C0
	mov r4, r0
	ldr lr, _027F6854 // =0x040001C2
	sub r1, r1, #1
	b _027F6808
_027F67E8:
	strh r4, [lr]
_027F67EC:
	ldrh r3, [ip]
	ands r3, r3, #0x80
	bne _027F67EC
	ldrh r3, [lr]
	and r3, r3, #0xff
	strb r3, [r2, r0]
	add r0, r0, #1
_027F6808:
	cmp r0, r1
	blo _027F67E8
	mov r1, #0x8100
	ldr ip, _027F6850 // =0x040001C0
	strh r1, [ip]
	mov r3, #0
	ldr r1, _027F6854 // =0x040001C2
	strh r3, [r1]
_027F6828:
	ldrh r1, [ip]
	ands r1, r1, #0x80
	bne _027F6828
	ldr r1, _027F6854 // =0x040001C2
	ldrh r1, [r1]
	and r1, r1, #0xff
	strb r1, [r2, r0]
_027F6844:
	add sp, sp, #8
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_027F6850: .word 0x040001C0
_027F6854: .word 0x040001C2
	arm_func_end NVRAM_ReadDataBytes

	arm_func_start NVRAM_ReadStatusRegister
NVRAM_ReadStatusRegister: // 0x027F6858
	ldr r2, _027F68C4 // =0x040001C0
_027F685C:
	ldrh r1, [r2]
	ands r1, r1, #0x80
	bne _027F685C
	mov r1, #0x8900
	strh r1, [r2]
	mov r2, #5
	ldr r1, _027F68C8 // =0x040001C2
	strh r2, [r1]
	ldr r2, _027F68C4 // =0x040001C0
_027F6880:
	ldrh r1, [r2]
	ands r1, r1, #0x80
	bne _027F6880
	mov r1, #0x8100
	strh r1, [r2]
	mov r2, #0
	ldr r1, _027F68C8 // =0x040001C2
	strh r2, [r1]
	ldr r2, _027F68C4 // =0x040001C0
_027F68A4:
	ldrh r1, [r2]
	ands r1, r1, #0x80
	bne _027F68A4
	ldr r1, _027F68C8 // =0x040001C2
	ldrh r1, [r1]
	and r1, r1, #0xff
	strb r1, [r0]
	bx lr
	.align 2, 0
_027F68C4: .word 0x040001C0
_027F68C8: .word 0x040001C2
	arm_func_end NVRAM_ReadStatusRegister

	arm_func_start NVRAM_WriteDisable
NVRAM_WriteDisable: // 0x027F68CC
	ldr r1, _027F6904 // =0x040001C0
_027F68D0:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F68D0
	mov r0, #0x8100
	strh r0, [r1]
	mov r1, #4
	ldr r0, _027F6908 // =0x040001C2
	strh r1, [r0]
	ldr r1, _027F6904 // =0x040001C0
_027F68F4:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F68F4
	bx lr
	.align 2, 0
_027F6904: .word 0x040001C0
_027F6908: .word 0x040001C2
	arm_func_end NVRAM_WriteDisable

	arm_func_start NVRAM_WriteEnable
NVRAM_WriteEnable: // 0x027F690C
	ldr r1, _027F6944 // =0x040001C0
_027F6910:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F6910
	mov r0, #0x8100
	strh r0, [r1]
	mov r1, #6
	ldr r0, _027F6948 // =0x040001C2
	strh r1, [r0]
	ldr r1, _027F6944 // =0x040001C0
_027F6934:
	ldrh r0, [r1]
	ands r0, r0, #0x80
	bne _027F6934
	bx lr
	.align 2, 0
_027F6944: .word 0x040001C0
_027F6948: .word 0x040001C2
	arm_func_end NVRAM_WriteEnable
