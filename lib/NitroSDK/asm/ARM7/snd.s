	.include "asm/macros.inc"
	.include "global.inc"

	.bss

.public sSurroundDecay
sSurroundDecay: // 0x038086A4
	.space 4

.public sOrgPan
sOrgPan: // 0x038086A8
	.space 0x10

.public sOrgVolume
sOrgVolume: // 0x038086B8
	.space 0x10

.public initialized_3150
initialized_3150: // 0x038086C8
	.space 4

.public sndMesgBuffer
sndMesgBuffer: // 0x038086CC
	.space 0x20

.public sndMesgQueue
sndMesgQueue: // 0x038086EC
	.space 0x20

.public sndAlarm
sndAlarm: // 0x0380870C
	.space 0x2C

.public sndThread
sndThread: // 0x03808738
	.space 0xA4

.public sndStack
sndStack: // 0x038087DC
	.space 0x400

.public sWeakLockChannel
sWeakLockChannel: // 0x03808BDC
	.space 4

.public sLockChannel
sLockChannel: // 0x03808BE0
	.space 4

.public sMmlPrintEnable
sMmlPrintEnable: // 0x03808BE4
	.space 4

.public seqCache
seqCache: // 0x03808BE8
	.space 0x18

.public SNDi_SharedWork
SNDi_SharedWork: // 0x03808C00
	.space 4

.public SNDi_Work
SNDi_Work: // 0x03808C04
	.space 0x1180

.public sCommandMesgQueue
sCommandMesgQueue: // 0x03809D84
	.space 0x20

.public sCommandMesgBuffer
sCommandMesgBuffer: // 0x03809DA4
	.space 0x20

	.text

	arm_func_start SND_SetOutputSelector
SND_SetOutputSelector: // 0x037FEE1C
	ldr ip, _037FEE50 // =0x04000501
	ldrb ip, [ip]
	ands ip, ip, #0x80
	movne ip, #1
	moveq ip, #0
	mov ip, ip, lsl #7
	orr r3, ip, r3, lsl #5
	orr r2, r3, r2, lsl #4
	orr r1, r2, r1, lsl #2
	orr r1, r0, r1
	ldr r0, _037FEE50 // =0x04000501
	strb r1, [r0]
	bx lr
	.align 2, 0
_037FEE50: .word 0x04000501
	arm_func_end SND_SetOutputSelector

	arm_func_start SND_SetMasterVolume
SND_SetMasterVolume: // 0x037FEE54
	ldr r1, _037FEE60 // =0x04000500
	strb r0, [r1]
	bx lr
	.align 2, 0
_037FEE60: .word 0x04000500
	arm_func_end SND_SetMasterVolume

	arm_func_start SND_EndSleep
SND_EndSleep: // 0x037FEE64
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _037FEEA4 // =0x04000304
	ldrh r0, [r1, #0]
	orr r0, r0, #1
	strh r0, [r1]
	mov r0, #1
	bl PMi_SetControl
	mov r0, #0x100
	bl SVC_SoundBiasSet_ARM
	ldr r0, _037FEEA8 // =0x0007AB80
	bl OS_SpinWait
	bl SND_Enable
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FEEA4: .word 0x04000304
_037FEEA8: .word 0x0007AB80
	arm_func_end SND_EndSleep

	arm_func_start SVC_SoundBiasSet_ARM
SVC_SoundBiasSet_ARM: // 0x037FEEAC
	ldr ip, _037FEEB4 // =SVC_SoundBiasSet
	bx ip
	.align 2, 0
_037FEEB4: .word SVC_SoundBiasSet
	arm_func_end SVC_SoundBiasSet_ARM

	arm_func_start SND_BeginSleep
SND_BeginSleep: // 0x037FEEB8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl SND_Disable
	mov r0, #0x80
	bl SVC_SoundBiasReset_ARM
	mov r0, #0x40000
	bl OS_SpinWait
	mov r0, #1
	bl PMi_ResetControl
	ldr r1, _037FEEF8 // =0x04000304
	ldrh r0, [r1, #0]
	bic r0, r0, #1
	strh r0, [r1]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FEEF8: .word 0x04000304
	arm_func_end SND_BeginSleep

	arm_func_start SVC_SoundBiasReset_ARM
SVC_SoundBiasReset_ARM: // 0x037FEEFC
	ldr ip, _037FEF04 // =SVC_SoundBiasReset
	bx ip
	.align 2, 0
_037FEF04: .word SVC_SoundBiasReset
	arm_func_end SVC_SoundBiasReset_ARM

	arm_func_start SND_Shutdown
SND_Shutdown: // 0x037FEF08
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl SND_Disable
	mov r5, #0
	mov r4, #1
_037FEF1C:
	mov r0, r5
	mov r1, r4
	bl SND_StopChannel
	add r5, r5, #1
	cmp r5, #0x10
	blt _037FEF1C
	mov r1, #0
	ldr r0, _037FEF54 // =0x04000508
	strb r1, [r0]
	ldr r0, _037FEF58 // =0x04000509
	strb r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FEF54: .word 0x04000508
_037FEF58: .word 0x04000509
	arm_func_end SND_Shutdown

	arm_func_start SND_Disable
SND_Disable: // 0x037FEF5C
	ldr r1, _037FEF70 // =0x04000501
	ldrb r0, [r1, #0]
	bic r0, r0, #0x80
	strb r0, [r1]
	bx lr
	.align 2, 0
_037FEF70: .word 0x04000501
	arm_func_end SND_Disable

	arm_func_start SND_Enable
SND_Enable: // 0x037FEF74
	ldr r1, _037FEF88 // =0x04000501
	ldrb r0, [r1, #0]
	orr r0, r0, #0x80
	strb r0, [r1]
	bx lr
	.align 2, 0
_037FEF88: .word 0x04000501
	arm_func_end SND_Enable

	arm_func_start SND_CalcSurroundDecay
SND_CalcSurroundDecay: // 0x037FEF8C
	cmp r1, #0x18
	bge _037FEFBC
	ldr r2, _037FEFF0 // =sSurroundDecay
	ldr r3, [r2, #0]
	ldr r2, _037FEFF4 // =0x00007FFF
	sub r2, r2, r3
	add r1, r1, #0x28
	mul r1, r3, r1
	add r1, r1, r2, lsl #6
	mul r1, r0, r1
	mov r0, r1, asr #0x15
	bx lr
_037FEFBC:
	cmp r1, #0x68
	bxle lr
	ldr r2, _037FEFF0 // =sSurroundDecay
	ldr ip, [r2]
	ldr r2, _037FEFF4 // =0x00007FFF
	add r3, ip, r2
	rsb r2, ip, #0
	sub r1, r1, #0x28
	mul r1, r2, r1
	add r1, r1, r3, lsl #6
	mul r1, r0, r1
	mov r0, r1, asr #0x15
	bx lr
	.align 2, 0
_037FEFF0: .word sSurroundDecay
_037FEFF4: .word 0x00007FFF
	arm_func_end SND_CalcSurroundDecay

	arm_func_start SNDi_SetSurroundDecay
SNDi_SetSurroundDecay: // 0x037FEFF8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, _037FF050 // =sSurroundDecay
	str r0, [r1]
	mov r4, #0
	ldr r6, _037FF054 // =sOrgVolume
	mov r7, #1
	ldr r5, _037FF058 // =0x0000FFF5
_037FF014:
	mov r0, r7, lsl r4
	ands r0, r0, r5
	beq _037FF03C
	mov r8, r4, lsl #4
	add r0, r8, #0x4000000
	ldrb r1, [r0, #0x402]
	ldrb r0, [r6, r4]
	bl SND_CalcSurroundDecay
	add r1, r8, #0x4000000
	strb r0, [r1, #0x400]
_037FF03C:
	add r4, r4, #1
	cmp r4, #0x10
	blt _037FF014
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_037FF050: .word sSurroundDecay
_037FF054: .word sOrgVolume
_037FF058: .word 0x0000FFF5
	arm_func_end SNDi_SetSurroundDecay

	arm_func_start SND_GetChannelControl
SND_GetChannelControl: // 0x037FF05C
	mov r0, r0, lsl #4
	add r0, r0, #0x4000000
	ldr r0, [r0, #0x400]
	bx lr
	arm_func_end SND_GetChannelControl

	arm_func_start SND_SetMasterPan
SND_SetMasterPan: // 0x037FF06C
	ldr r1, _037FF0C8 // =sMasterPan
	str r0, [r1]
	cmp r0, #0
	blt _037FF0A0
	mov r2, #0
	and r1, r0, #0xff
_037FF084:
	mov r0, r2, lsl #4
	add r0, r0, #0x4000000
	strb r1, [r0, #0x402]
	add r2, r2, #1
	cmp r2, #0x10
	blt _037FF084
	bx lr
_037FF0A0:
	mov r3, #0
	ldr r2, _037FF0CC // =sOrgPan
_037FF0A8:
	ldrb r1, [r2, r3]
	mov r0, r3, lsl #4
	add r0, r0, #0x4000000
	strb r1, [r0, #0x402]
	add r3, r3, #1
	cmp r3, #0x10
	blt _037FF0A8
	bx lr
	.align 2, 0
_037FF0C8: .word sMasterPan
_037FF0CC: .word sOrgPan
	arm_func_end SND_SetMasterPan

	arm_func_start SND_IsChannelActive
SND_IsChannelActive: // 0x037FF0D0
	mov r0, r0, lsl #4
	add r0, r0, #0x4000000
	ldrb r0, [r0, #0x403]
	ands r0, r0, #0x80
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end SND_IsChannelActive

	arm_func_start SND_SetChannelPan
SND_SetChannelPan: // 0x037FF0EC
	stmdb sp!, {r4, lr}
	ldr r2, _037FF154 // =sOrgPan
	strb r1, [r2, r0]
	ldr r2, _037FF158 // =sMasterPan
	ldr r2, [r2, #0]
	cmp r2, #0
	movge r1, r2
	mov r4, r0, lsl #4
	add r2, r4, #0x4000000
	strb r1, [r2, #0x402]
	ldr r2, _037FF15C // =sSurroundDecay
	ldr r2, [r2, #0]
	cmp r2, #0
	ble _037FF14C
	mov r2, #1
	mov r3, r2, lsl r0
	ldr r2, _037FF160 // =0x0000FFF5
	ands r2, r3, r2
	beq _037FF14C
	ldr r2, _037FF164 // =sOrgVolume
	ldrb r0, [r2, r0]
	bl SND_CalcSurroundDecay
	add r1, r4, #0x4000000
	strb r0, [r1, #0x400]
_037FF14C:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FF154: .word sOrgPan
_037FF158: .word sMasterPan
_037FF15C: .word sSurroundDecay
_037FF160: .word 0x0000FFF5
_037FF164: .word sOrgVolume
	arm_func_end SND_SetChannelPan

	arm_func_start SND_SetChannelTimer
SND_SetChannelTimer: // 0x037FF168
	rsb r1, r1, #0x10000
	mov r0, r0, lsl #4
	add r0, r0, #0x4000000
	add r0, r0, #0x400
	strh r1, [r0, #8]
	bx lr
	arm_func_end SND_SetChannelTimer

	arm_func_start SND_SetChannelVolume
SND_SetChannelVolume: // 0x037FF180
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r2
	ldr r0, _037FF1F8 // =sOrgVolume
	strb r1, [r0, r5]
	ldr r0, _037FF1FC // =sSurroundDecay
	ldr r0, [r0, #0]
	cmp r0, #0
	ble _037FF1D8
	mov r0, #1
	mov r2, r0, lsl r5
	ldr r0, _037FF200 // =0x0000FFF5
	ands r0, r2, r0
	beq _037FF1D8
	mov r0, r5, lsl #4
	add r0, r0, #0x4000000
	ldrb r2, [r0, #0x402]
	mov r0, r1
	mov r1, r2
	bl SND_CalcSurroundDecay
	mov r1, r0
_037FF1D8:
	orr r1, r1, r4, lsl #8
	mov r0, r5, lsl #4
	add r0, r0, #0x4000000
	add r0, r0, #0x400
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FF1F8: .word sOrgVolume
_037FF1FC: .word sSurroundDecay
_037FF200: .word 0x0000FFF5
	arm_func_end SND_SetChannelVolume

	arm_func_start SND_StopChannel
SND_StopChannel: // 0x037FF204
	mov r3, r0, lsl #4
	ldr r2, _037FF22C // =0x04000400
	add ip, r2, r0, lsl #4
	add r0, r3, #0x4000000
	ldr r0, [r0, #0x400]
	bic r2, r0, #0x80000000
	ands r0, r1, #1
	orrne r2, r2, #0x8000
	str r2, [ip]
	bx lr
	.align 2, 0
_037FF22C: .word 0x04000400
	arm_func_end SND_StopChannel

	arm_func_start SND_SetupChannelNoise
SND_SetupChannelNoise: // 0x037FF230
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x18]
	mov r4, r0, lsl #4
	ldr r2, _037FF2CC // =sOrgPan
	strb r5, [r2, r0]
	ldr r2, _037FF2D0 // =sMasterPan
	ldr r2, [r2, #0]
	cmp r2, #0
	movge r5, r2
	ldr r2, _037FF2D4 // =sOrgVolume
	strb r1, [r2, r0]
	ldr r2, _037FF2D8 // =sSurroundDecay
	ldr r2, [r2, #0]
	cmp r2, #0
	ble _037FF29C
	mov r2, #1
	mov r2, r2, lsl r0
	ldr r0, _037FF2DC // =0x0000FFF5
	ands r0, r2, r0
	beq _037FF29C
	mov r0, r1
	mov r1, r5
	bl SND_CalcSurroundDecay
	mov r1, r0
_037FF29C:
	mov r0, r5, lsl #0x10
	orr r0, r0, #0x60000000
	orr r0, r0, r7, lsl #8
	orr r1, r1, r0
	add r0, r4, #0x4000000
	str r1, [r0, #0x400]
	rsb r1, r6, #0x10000
	add r0, r0, #0x400
	strh r1, [r0, #8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037FF2CC: .word sOrgPan
_037FF2D0: .word sMasterPan
_037FF2D4: .word sOrgVolume
_037FF2D8: .word sSurroundDecay
_037FF2DC: .word 0x0000FFF5
	arm_func_end SND_SetupChannelNoise

	arm_func_start SND_SetupChannelPsg
SND_SetupChannelPsg: // 0x037FF2E0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r1
	mov r6, r3
	ldr r5, [sp, #0x1c]
	mov r4, r0, lsl #4
	ldr r1, _037FF384 // =sOrgPan
	strb r5, [r1, r0]
	ldr r1, _037FF388 // =sMasterPan
	ldr r1, [r1, #0]
	cmp r1, #0
	movge r5, r1
	ldr r1, _037FF38C // =sOrgVolume
	strb r2, [r1, r0]
	ldr r1, _037FF390 // =sSurroundDecay
	ldr r1, [r1, #0]
	cmp r1, #0
	ble _037FF34C
	mov r1, #1
	mov r1, r1, lsl r0
	ldr r0, _037FF394 // =0x0000FFF5
	ands r0, r1, r0
	beq _037FF34C
	mov r0, r2
	mov r1, r5
	bl SND_CalcSurroundDecay
	mov r2, r0
_037FF34C:
	mov r0, r7, lsl #0x18
	orr r0, r0, #0x60000000
	orr r0, r0, r5, lsl #16
	orr r0, r0, r6, lsl #8
	orr r1, r2, r0
	add r0, r4, #0x4000000
	str r1, [r0, #0x400]
	ldr r1, [sp, #0x18]
	rsb r1, r1, #0x10000
	add r0, r0, #0x400
	strh r1, [r0, #8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_037FF384: .word sOrgPan
_037FF388: .word sMasterPan
_037FF38C: .word sOrgVolume
_037FF390: .word sSurroundDecay
_037FF394: .word 0x0000FFF5
	arm_func_end SND_SetupChannelPsg

	arm_func_start SND_SetupChannelPcm
SND_SetupChannelPcm: // 0x037FF398
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r1
	mov r7, r2
	mov r6, r3
	ldr r1, [sp, #0x20]
	ldr r5, [sp, #0x2c]
	mov r4, r0, lsl #4
	ldr r2, _037FF454 // =sOrgPan
	strb r5, [r2, r0]
	ldr r2, _037FF458 // =sMasterPan
	ldr r2, [r2, #0]
	cmp r2, #0
	movge r5, r2
	ldr r2, _037FF45C // =sOrgVolume
	strb r1, [r2, r0]
	ldr r2, _037FF460 // =sSurroundDecay
	ldr r2, [r2, #0]
	cmp r2, #0
	ble _037FF408
	mov r2, #1
	mov r2, r2, lsl r0
	ldr r0, _037FF464 // =0x0000FFF5
	ands r0, r2, r0
	beq _037FF408
	mov r0, r1
	mov r1, r5
	bl SND_CalcSurroundDecay
	mov r1, r0
_037FF408:
	ldr r2, [sp, #0x24]
	mov r0, r7, lsl #0x1d
	orr r0, r0, r6, lsl #27
	orr r0, r0, r5, lsl #16
	orr r0, r0, r2, lsl #8
	orr r0, r1, r0
	add r1, r4, #0x4000000
	str r0, [r1, #0x400]
	ldr r0, [sp, #0x28]
	rsb r2, r0, #0x10000
	add r0, r1, #0x400
	strh r2, [r0, #8]
	ldr r2, [sp, #0x18]
	strh r2, [r0, #0xa]
	ldr r0, [sp, #0x1c]
	str r0, [r1, #0x40c]
	str r8, [r1, #0x404]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_037FF454: .word sOrgPan
_037FF458: .word sMasterPan
_037FF45C: .word sOrgVolume
_037FF460: .word sSurroundDecay
_037FF464: .word 0x0000FFF5
	arm_func_end SND_SetupChannelPcm

	arm_func_start SND_CalcRandom
SND_CalcRandom: // 0x037FF468
	ldr r2, _037FF490 // =u_3210
	ldr r3, [r2, #0]
	ldr r0, _037FF494 // =0x0019660D
	ldr r1, _037FF498 // =0x3C6EF35F
	mla r0, r3, r0, r1
	str r0, [r2]
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	.align 2, 0
_037FF490: .word u_3210
_037FF494: .word 0x0019660D
_037FF498: .word 0x3C6EF35F
	arm_func_end SND_CalcRandom

	arm_func_start SND_SinIdx
SND_SinIdx: // 0x037FF49C
	cmp r0, #0x20
	ldrlt r1, _037FF504 // =SinTable
	ldrltsb r0, [r1, r0]
	bxlt lr
	cmp r0, #0x40
	rsblt r1, r0, #0x40
	ldrlt r0, _037FF504 // =SinTable
	ldrltsb r0, [r0, r1]
	bxlt lr
	cmp r0, #0x60
	bge _037FF4E4
	sub r1, r0, #0x40
	ldr r0, _037FF504 // =SinTable
	ldrsb r0, [r0, r1]
	rsb r0, r0, #0
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	bx lr
_037FF4E4:
	sub r0, r0, #0x60
	rsb r1, r0, #0x20
	ldr r0, _037FF504 // =SinTable
	ldrsb r0, [r0, r1]
	rsb r0, r0, #0
	mov r0, r0, lsl #0x18
	mov r0, r0, asr #0x18
	bx lr
	.align 2, 0
_037FF504: .word SinTable
	arm_func_end SND_SinIdx

	arm_func_start SND_CalcChannelVolume
SND_CalcChannelVolume: // 0x037FF508
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _037FF578 // =0xFFFFFD2D
	cmp r4, r0
	movlt r4, r0
	blt _037FF528
	cmp r4, #0
	movgt r4, #0
_037FF528:
	ldr r0, _037FF57C // =0x000002D3
	add r0, r4, r0
	bl SVC_GetVolumeTable_ARM
	mvn r1, #0xef
	cmp r4, r1
	movlt r1, #3
	blt _037FF564
	mvn r1, #0x77
	cmp r4, r1
	movlt r1, #2
	blt _037FF564
	mvn r1, #0x3b
	cmp r4, r1
	movlt r1, #1
	movge r1, #0
_037FF564:
	orr r0, r0, r1, lsl #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FF578: .word 0xFFFFFD2D
_037FF57C: .word 0x000002D3
	arm_func_end SND_CalcChannelVolume

	arm_func_start SVC_GetVolumeTable_ARM
SVC_GetVolumeTable_ARM: // 0x037FF580
	ldr ip, _037FF588 // =SVC_GetVolumeTable
	bx ip
	.align 2, 0
_037FF588: .word SVC_GetVolumeTable
	arm_func_end SVC_GetVolumeTable_ARM

	arm_func_start SND_CalcTimer
SND_CalcTimer: // 0x037FF58C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, #0
	rsb r0, r1, #0
	b _037FF5AC
_037FF5A4:
	sub r4, r4, #1
	add r0, r0, #0x300
_037FF5AC:
	cmp r0, #0
	blt _037FF5A4
	b _037FF5C0
_037FF5B8:
	add r4, r4, #1
	sub r0, r0, #0x300
_037FF5C0:
	cmp r0, #0x300
	bge _037FF5B8
	bl SVC_GetPitchTable_ARM
	mov r2, #0
	mov r1, #0x10000
	adds lr, r0, r1
	adc ip, r2, #0
	mov r3, r5, asr #0x1f
	umull r1, r0, lr, r5
	mla r0, lr, r3, r0
	mla r0, ip, r5, r0
	sub lr, r4, #0x10
	cmp lr, #0
	bgt _037FF618
	rsb r2, lr, #0
	mov r3, r0, lsr r2
	mov r5, r1, lsr r2
	rsb r1, r2, #0x20
	orr r5, r5, r0, lsl r1
	sub r1, r2, #0x20
	orr r5, r5, r0, lsr r1
	b _037FF674
_037FF618:
	cmp lr, #0x20
	bge _037FF66C
	mvn r5, #0
	rsb r4, lr, #0x20
	mov ip, r5, lsl r4
	rsb r3, r4, #0x20
	orr ip, ip, r5, lsr r3
	sub r3, r4, #0x20
	orr ip, ip, r5, lsl r3
	and r3, r0, ip
	and r5, r1, r5, lsl r4
	cmp r3, r2
	cmpeq r5, r2
	ldrne r0, _037FF6B0 // =0x0000FFFF
	bne _037FF6A4
	mov r5, r1, lsl lr
	mov r3, r0, lsl lr
	orr r3, r3, r1, lsr r4
	sub r0, lr, #0x20
	orr r3, r3, r1, lsl r0
	b _037FF674
_037FF66C:
	ldr r0, _037FF6B0 // =0x0000FFFF
	b _037FF6A4
_037FF674:
	mov r1, #0
	mov r0, #0x10
	cmp r3, r1
	cmpeq r5, r0
	movlo r5, r0
	blo _037FF69C
	ldr r0, _037FF6B0 // =0x0000FFFF
	cmp r3, r1
	cmpeq r5, r0
	movhi r5, r0
_037FF69C:
	mov r0, r5, lsl #0x10
	mov r0, r0, lsr #0x10
_037FF6A4:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_037FF6B0: .word 0x0000FFFF
	arm_func_end SND_CalcTimer

	arm_func_start SVC_GetPitchTable_ARM
SVC_GetPitchTable_ARM: // 0x037FF6B4
	ldr ip, _037FF6BC // =SVC_GetPitchTable
	bx ip
	.align 2, 0
_037FF6BC: .word SVC_GetPitchTable
	arm_func_end SVC_GetPitchTable_ARM

	arm_func_start SndThread
SndThread: // 0x037FF6C0
	stmdb sp!, {r4, r5, r6, lr}
	bl SND_InitIntervalTimer
	bl SND_ExChannelInit
	bl SND_SeqInit
	bl SND_AlarmInit
	bl SND_Enable
	mov r0, #0
	mov r1, r0
	mov r2, r0
	mov r3, r0
	bl SND_SetOutputSelector
	mov r0, #0x7f
	bl SND_SetMasterVolume
	bl SND_StartIntervalTimer
	mov r4, #1
	mov r5, #0
_037FF700:
	mov r6, r5
	bl SND_WaitForIntervalTimer
	cmp r0, #1
	beq _037FF718
	cmp r0, #2
	b _037FF71C
_037FF718:
	mov r6, r4
_037FF71C:
	bl SND_UpdateExChannel
	bl SND_CommandProc
	mov r0, r6
	bl SND_SeqMain
	mov r0, r6
	bl SND_ExChannelMain
	bl SND_UpdateSharedWork
	bl SND_CalcRandom
	b _037FF700
	arm_func_end SndThread

	arm_func_start SndAlarmCallback
SndAlarmCallback: // 0x037FF740
	ldr r0, _037FF754 // =sndMesgQueue
	mov r1, #1
	mov r2, #0
	ldr ip, _037FF758 // =OS_SendMessage
	bx ip
	.align 2, 0
_037FF754: .word sndMesgQueue
_037FF758: .word OS_SendMessage
	arm_func_end SndAlarmCallback

	arm_func_start SNDi_UnlockMutex
SNDi_UnlockMutex: // 0x037FF75C
	bx lr
	arm_func_end SNDi_UnlockMutex

	arm_func_start SNDi_LockMutex
SNDi_LockMutex: // 0x037FF760
	bx lr
	arm_func_end SNDi_LockMutex

	arm_func_start SND_SendWakeupMessage
SND_SendWakeupMessage: // 0x037FF764
	ldr r0, _037FF778 // =sndMesgQueue
	mov r1, #2
	mov r2, #0
	ldr ip, _037FF77C // =OS_SendMessage
	bx ip
	.align 2, 0
_037FF778: .word sndMesgQueue
_037FF77C: .word OS_SendMessage
	arm_func_end SND_SendWakeupMessage

	arm_func_start SND_WaitForIntervalTimer
SND_WaitForIntervalTimer: // 0x037FF780
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _037FF7A8 // =sndMesgQueue
	add r1, sp, #0
	mov r2, #1
	bl OS_ReceiveMessage
	ldr r0, [sp]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FF7A8: .word sndMesgQueue
	arm_func_end SND_WaitForIntervalTimer

	arm_func_start SND_StopIntervalTimer
SND_StopIntervalTimer: // 0x037FF7AC
	ldr r0, _037FF7B8 // =sndAlarm
	ldr ip, _037FF7BC // =OS_CancelAlarm
	bx ip
	.align 2, 0
_037FF7B8: .word sndAlarm
_037FF7BC: .word OS_CancelAlarm
	arm_func_end SND_StopIntervalTimer

	arm_func_start SND_StartIntervalTimer
SND_StartIntervalTimer: // 0x037FF7C0
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	bl OS_GetTick
	mov ip, r0
	ldr r0, _037FF80C // =SndAlarmCallback
	str r0, [sp, #4]
	mov r0, #0
	str r0, [sp, #8]
	ldr r3, _037FF810 // =0x00000AA8
	str r0, [sp]
	ldr r0, _037FF814 // =sndAlarm
	mov r2, #0x10000
	adds ip, ip, r2
	adc r2, r1, #0
	mov r1, ip
	bl OS_SetPeriodicAlarm
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FF80C: .word SndAlarmCallback
_037FF810: .word 0x00000AA8
_037FF814: .word sndAlarm
	arm_func_end SND_StartIntervalTimer

	arm_func_start SND_InitIntervalTimer
SND_InitIntervalTimer: // 0x037FF818
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _037FF844 // =sndMesgQueue
	ldr r1, _037FF848 // =sndMesgBuffer
	mov r2, #8
	bl OS_InitMessageQueue
	ldr r0, _037FF84C // =sndAlarm
	bl OS_CreateAlarm
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FF844: .word sndMesgQueue
_037FF848: .word sndMesgBuffer
_037FF84C: .word sndAlarm
	arm_func_end SND_InitIntervalTimer

	arm_func_start SND_CreateThread
SND_CreateThread: // 0x037FF850
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov r1, #0x400
	str r1, [sp]
	str r0, [sp, #4]
	ldr r0, _037FF88C // =sndThread
	ldr r1, _037FF890 // =SndThread
	mov r2, #0
	ldr r3, _037FF894 // =sWeakLockChannel
	bl OS_CreateThread
	ldr r0, _037FF88C // =sndThread
	bl OS_WakeupThreadDirect
	add sp, sp, #0xc
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FF88C: .word sndThread
_037FF890: .word SndThread
_037FF894: .word sWeakLockChannel
	arm_func_end SND_CreateThread

	arm_func_start SND_Init
SND_Init: // 0x037FF898
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _037FF8CC // =initialized_3150
	ldr r1, [r0, #0]
	cmp r1, #0
	bne _037FF8C4
	mov r1, #1
	str r1, [r0]
	bl SND_CommandInit
	mov r0, r4
	bl SND_CreateThread
_037FF8C4:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FF8CC: .word initialized_3150
	arm_func_end SND_Init

	arm_func_start SND_IsCaptureActive
SND_IsCaptureActive: // 0x037FF8D0
	add r0, r0, #0x4000000
	ldrb r0, [r0, #0x508]
	ands r0, r0, #0x80
	movne r0, #1
	moveq r0, #0
	bx lr
	arm_func_end SND_IsCaptureActive

	arm_func_start SND_SetupCapture
SND_SetupCapture: // 0x037FF8E8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0, lsl #3
	ldr ip, [sp, #0x10]
	cmp ip, #0
	movne r5, #0
	moveq r5, #1
	ldr lr, [sp, #0x18]
	ldr ip, [sp, #0x14]
	mov r1, r1, lsl #3
	orr r1, r1, r5, lsl #2
	orr r1, r1, ip, lsl #1
	orr r1, lr, r1
	add r0, r0, #0x4000000
	strb r1, [r0, #0x508]
	add r0, r4, #0x4000000
	str r2, [r0, #0x510]
	add r0, r0, #0x500
	strh r3, [r0, #0x14]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end SND_SetupCapture

	arm_func_start LfoMain
LfoMain: // 0x037FF940
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	add r0, r6, #0x28
	bl SND_GetLfoValue
	mov r4, r0
	mov ip, r0, asr #0x1f
	mov r3, #0
	cmp ip, r3
	cmpeq r0, r3
	beq _037FF9C0
	ldrb r1, [r6, #0x28]
	cmp r1, #0
	beq _037FF9AC
	cmp r1, #1
	beq _037FF994
	cmp r1, #2
	moveq ip, ip, lsl #6
	orreq ip, ip, r0, lsr #26
	moveq r4, r0, lsl #6
	b _037FF9B8
_037FF994:
	mov r2, #0x3c
	umull r4, r1, r0, r2
	mla r1, r0, r3, r1
	mla r1, ip, r2, r1
	mov ip, r1
	b _037FF9B8
_037FF9AC:
	mov ip, ip, lsl #6
	orr ip, ip, r0, lsr #26
	mov r4, r0, lsl #6
_037FF9B8:
	mov r4, r4, lsr #0xe
	orr r4, r4, ip, lsl #18
_037FF9C0:
	cmp r5, #0
	beq _037FF9D0
	add r0, r6, #0x28
	bl SND_UpdateLfo
_037FF9D0:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end LfoMain

	arm_func_start SweepMain
SweepMain: // 0x037FF9DC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r5, r1
	ldrsh r3, [r4, #0x32]
	cmp r3, #0
	moveq r0, #0
	beq _037FFA40
	ldr r0, [r4, #0x14]
	ldr r2, [r4, #0x18]
	cmp r0, r2
	movge r0, #0
	bge _037FFA40
	sub r0, r2, r0
	smull r0, r1, r3, r0
	mov r3, r2, asr #0x1f
	bl _ll_sdiv
	cmp r5, #0
	beq _037FFA40
	ldrb r1, [r4, #3]
	mov r1, r1, lsl #0x1d
	movs r1, r1, lsr #0x1f
	ldrne r1, [r4, #0x14]
	addne r1, r1, #1
	strne r1, [r4, #0x14]
_037FFA40:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end SweepMain

	arm_func_start CompareExChannelVolume
CompareExChannelVolume: // 0x037FFA4C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh lr, [r0, #0x24]
	and r2, lr, #0xff
	ldrh ip, [r1, #0x24]
	and r0, ip, #0xff
	mov r2, r2, lsl #4
	mov r3, r0, lsl #4
	ldr r1, _037FFAA8 // =_03807F2C
	ldrb r0, [r1, lr, asr #8]
	mov r2, r2, asr r0
	ldrb r0, [r1, ip, asr #8]
	mov r0, r3, asr r0
	cmp r2, r0
	beq _037FFA98
	cmp r2, r0
	movlt r0, #1
	mvnge r0, #0
	b _037FFA9C
_037FFA98:
	mov r0, #0
_037FFA9C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FFAA8: .word _03807F2C
	arm_func_end CompareExChannelVolume

	arm_func_start StartExChannel
StartExChannel: // 0x037FFAAC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _037FFAF4 // =0xFFFE9680
	str r0, [r4, #0x10]
	mov r0, #0
	strb r0, [r4, #2]
	str r1, [r4, #0x34]
	add r0, r4, #0x28
	bl SND_StartLfo
	ldrb r0, [r4, #3]
	orr r0, r0, #2
	strb r0, [r4, #3]
	ldrb r0, [r4, #3]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r4, #3]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_037FFAF4: .word 0xFFFE9680
	arm_func_end StartExChannel

	arm_func_start InitAllocExChannel
InitAllocExChannel: // 0x037FFAF8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov ip, #0
	str ip, [r4, #0x50]
	str r1, [r4, #0x48]
	str r2, [r4, #0x4c]
	str ip, [r4, #0x34]
	strb r3, [r4, #0x22]
	mov r1, #0x7f
	strh r1, [r4, #0x24]
	ldrb r2, [r4, #3]
	bic r2, r2, #2
	strb r2, [r4, #3]
	ldrb r2, [r4, #3]
	orr r2, r2, #4
	strb r2, [r4, #3]
	mov r2, #0x3c
	strb r2, [r4, #8]
	strb r2, [r4, #5]
	strb r1, [r4, #9]
	strb ip, [r4, #0xa]
	strh ip, [r4, #0xc]
	strh ip, [r4, #6]
	strh ip, [r4, #0xe]
	strb ip, [r4, #0xb]
	strb r1, [r4, #4]
	strh ip, [r4, #0x32]
	str ip, [r4, #0x18]
	str ip, [r4, #0x14]
	bl SND_SetExChannelAttack
	mov r0, r4
	mov r1, #0x7f
	bl SND_SetExChannelDecay
	mov r0, r4
	mov r1, #0x7f
	bl SND_SetExChannelSustain
	mov r0, r4
	mov r1, #0x7f
	bl SND_SetExChannelRelease
	add r0, r4, #0x28
	bl SND_InitLfoParam
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end InitAllocExChannel

	arm_func_start CalcRelease
CalcRelease: // 0x037FFBA4
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, r0
	cmp r1, #0x7f
	ldreq r0, _037FFC00 // =0x0000FFFF
	beq _037FFBF4
	cmp r1, #0x7e
	moveq r0, #0x3c00
	beq _037FFBF4
	cmp r1, #0x32
	movlt r0, r1, lsl #1
	addlt r0, r0, #1
	movlt r0, r0, lsl #0x10
	movlt r0, r0, lsr #0x10
	blt _037FFBF4
	mov r0, #0x1e00
	rsb r1, r1, #0x7e
	bl _s32_div_f
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
_037FFBF4:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_037FFC00: .word 0x0000FFFF
	arm_func_end CalcRelease

	arm_func_start SND_GetLfoValue
SND_GetLfoValue: // 0x037FFC04
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrb r0, [r4, #2]
	cmp r0, #0
	moveq r0, #0
	beq _037FFC4C
	ldrh r1, [r4, #6]
	ldrh r0, [r4, #4]
	cmp r1, r0
	movlo r0, #0
	blo _037FFC4C
	ldrh r0, [r4, #8]
	mov r0, r0, lsr #8
	bl SND_SinIdx
	ldrb r2, [r4, #3]
	ldrb r1, [r4, #2]
	mul r0, r1, r0
	mul r0, r2, r0
_037FFC4C:
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end SND_GetLfoValue

	arm_func_start SND_UpdateLfo
SND_UpdateLfo: // 0x037FFC54
	ldrh r2, [r0, #6]
	ldrh r1, [r0, #4]
	cmp r2, r1
	addlo r1, r2, #1
	strloh r1, [r0, #6]
	bxlo lr
	ldrh r2, [r0, #8]
	ldrb r1, [r0, #1]
	mov r3, r1, lsl #6
	add r1, r2, r1, lsl #6
	mov r2, r1, lsr #8
	b _037FFC88
_037FFC84:
	sub r2, r2, #0x80
_037FFC88:
	cmp r2, #0x80
	bhs _037FFC84
	ldrh r1, [r0, #8]
	add r1, r1, r3
	strh r1, [r0, #8]
	ldrh r1, [r0, #8]
	and r1, r1, #0xff
	strh r1, [r0, #8]
	ldrh r1, [r0, #8]
	orr r1, r1, r2, lsl #8
	strh r1, [r0, #8]
	bx lr
	arm_func_end SND_UpdateLfo

	arm_func_start SND_StartLfo
SND_StartLfo: // 0x037FFCB8
	mov r1, #0
	strh r1, [r0, #8]
	strh r1, [r0, #6]
	bx lr
	arm_func_end SND_StartLfo

	arm_func_start SND_InitLfoParam
SND_InitLfoParam: // 0x037FFCC8
	mov r2, #0
	strb r2, [r0]
	strb r2, [r0, #2]
	mov r1, #1
	strb r1, [r0, #3]
	mov r1, #0x10
	strb r1, [r0, #1]
	strh r2, [r0, #4]
	bx lr
	arm_func_end SND_InitLfoParam

	arm_func_start SND_InvalidateWave
SND_InvalidateWave: // 0x037FFCEC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, #0
	mov r9, r5
	ldr r4, _037FFD70 // =SNDi_Work
	mov r8, #0x54
_037FFD0C:
	mla r2, r5, r8, r4
	ldrb r1, [r2, #3]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _037FFD54
	ldrb r0, [r2, #1]
	cmp r0, #0
	bne _037FFD54
	ldr r0, [r2, #0x44]
	cmp r7, r0
	bhi _037FFD54
	cmp r0, r6
	bhi _037FFD54
	bic r0, r1, #2
	strb r0, [r2, #3]
	mov r0, r5
	mov r1, r9
	bl SND_StopChannel
_037FFD54:
	add r0, r5, #1
	and r5, r0, #0xff
	cmp r5, #0x10
	blo _037FFD0C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_037FFD70: .word SNDi_Work
	arm_func_end SND_InvalidateWave

	arm_func_start SND_GetLockedChannel
SND_GetLockedChannel: // 0x037FFD74
	ands r0, r0, #1
	ldrne r0, _037FFD8C // =sWeakLockChannel
	ldrne r0, [r0, #0]
	ldreq r0, _037FFD90 // =sLockChannel
	ldreq r0, [r0, #0]
	bx lr
	.align 2, 0
_037FFD8C: .word sWeakLockChannel
_037FFD90: .word sLockChannel
	arm_func_end SND_GetLockedChannel

	arm_func_start SND_UnlockChannel
SND_UnlockChannel: // 0x037FFD94
	ands r1, r1, #1
	ldreq r1, _037FFDC8 // =sLockChannel
	ldreq r2, [r1, #0]
	mvneq r0, r0
	andeq r0, r2, r0
	streq r0, [r1]
	bxeq lr
	ldr r1, _037FFDCC // =sWeakLockChannel
	ldr r2, [r1, #0]
	mvn r0, r0
	and r0, r2, r0
	str r0, [r1]
	bx lr
	.align 2, 0
_037FFDC8: .word sLockChannel
_037FFDCC: .word sWeakLockChannel
	arm_func_end SND_UnlockChannel

	arm_func_start SND_LockChannel
SND_LockChannel: // 0x037FFDD0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	mov r7, r10
	mov r6, #0
	mov r11, r6
	str r6, [sp]
	mov r4, r6
	mov r5, #1
	b _037FFE7C
_037FFDFC:
	ands r0, r7, #1
	beq _037FFE74
	mov r1, #0x54
	ldr r0, _037FFEBC // =SNDi_Work
	mla r8, r6, r1, r0
	ldr r0, _037FFEC0 // =sLockChannel
	ldr r1, [r0, #0]
	mov r0, r5, lsl r6
	ands r0, r1, r0
	bne _037FFE74
	ldr r3, [r8, #0x48]
	cmp r3, #0
	beq _037FFE44
	mov r0, r8
	mov r1, r11
	ldr r2, [r8, #0x4c]
	mov lr, pc
	bx r3
_037FFE44:
	mov r0, r6
	ldr r1, [sp]
	bl SND_StopChannel
	strb r4, [r8, #0x22]
	mov r0, r8
	bl SND_FreeExChannel
	ldrb r0, [r8, #3]
	bic r0, r0, #0xf8
	strb r0, [r8, #3]
	ldrb r0, [r8, #3]
	bic r0, r0, #1
	strb r0, [r8, #3]
_037FFE74:
	add r6, r6, #1
	mov r7, r7, lsr #1
_037FFE7C:
	cmp r6, #0x10
	bge _037FFE8C
	cmp r7, #0
	bne _037FFDFC
_037FFE8C:
	ands r0, r9, #1
	ldrne r0, _037FFEC4 // =sWeakLockChannel
	ldrne r1, [r0, #0]
	orrne r1, r1, r10
	strne r1, [r0]
	ldreq r0, _037FFEC0 // =sLockChannel
	ldreq r1, [r0, #0]
	orreq r1, r1, r10
	streq r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_037FFEBC: .word SNDi_Work
_037FFEC0: .word sLockChannel
_037FFEC4: .word sWeakLockChannel
	arm_func_end SND_LockChannel

	arm_func_start SND_StopUnlockedChannel
SND_StopUnlockedChannel: // 0x037FFEC8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r8, #0
	mov r6, r8
	mov r5, r8
	mov r4, r8
	ldr r11, _037FFF88 // =SNDi_Work
	mov r7, #1
	b _037FFF6C
_037FFEF0:
	ands r0, r10, #1
	beq _037FFF64
	mov r0, #0x54
	mla r9, r8, r0, r11
	ldr r0, _037FFF8C // =sLockChannel
	ldr r1, [r0, #0]
	mov r0, r7, lsl r8
	ands r0, r1, r0
	bne _037FFF64
	ldr r3, [r9, #0x48]
	cmp r3, #0
	beq _037FFF34
	mov r0, r9
	mov r1, r6
	ldr r2, [r9, #0x4c]
	mov lr, pc
	bx r3
_037FFF34:
	mov r0, r8
	mov r1, r5
	bl SND_StopChannel
	strb r4, [r9, #0x22]
	mov r0, r9
	bl SND_FreeExChannel
	ldrb r0, [r9, #3]
	bic r0, r0, #0xf8
	strb r0, [r9, #3]
	ldrb r0, [r9, #3]
	bic r0, r0, #1
	strb r0, [r9, #3]
_037FFF64:
	add r8, r8, #1
	mov r10, r10, lsr #1
_037FFF6C:
	cmp r8, #0x10
	bge _037FFF7C
	cmp r10, #0
	bne _037FFEF0
_037FFF7C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_037FFF88: .word SNDi_Work
_037FFF8C: .word sLockChannel
	arm_func_end SND_StopUnlockedChannel

	arm_func_start SND_FreeExChannel
SND_FreeExChannel: // 0x037FFF90
	cmp r0, #0
	movne r1, #0
	strne r1, [r0, #0x48]
	strne r1, [r0, #0x4c]
	bx lr
	arm_func_end SND_FreeExChannel

	arm_func_start SND_AllocExChannel
SND_AllocExChannel: // 0x037FFFA4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	mov r11, r3
	ldr r0, _038000CC // =sLockChannel
	ldr r0, [r0, #0]
	mvn r0, r0
	and r10, r10, r0
	cmp r2, #0
	ldreq r0, _038000D0 // =sWeakLockChannel
	ldreq r0, [r0, #0]
	mvneq r0, r0
	andeq r10, r10, r0
	mov r8, #0
	mov r7, r8
	mov r5, #1
	mov r4, #0x54
_037FFFEC:
	ldr r0, _038000D4 // =0x03807F30
	ldrb r1, [r0, r7]
	mov r0, r5, lsl r1
	ands r0, r10, r0
	beq _03800044
	ldr r0, _038000D8 // =SNDi_Work
	mla r6, r1, r4, r0
	cmp r8, #0
	moveq r8, r6
	beq _03800044
	ldrb r1, [r8, #0x22]
	ldrb r0, [r6, #0x22]
	cmp r0, r1
	bhi _03800044
	cmp r0, r1
	bne _03800040
	mov r0, r8
	mov r1, r6
	bl CompareExChannelVolume
	cmp r0, #0
	bge _03800044
_03800040:
	mov r8, r6
_03800044:
	add r7, r7, #1
	cmp r7, #0x10
	blt _037FFFEC
	cmp r8, #0
	moveq r0, #0
	beq _038000C0
	ldrb r0, [r8, #0x22]
	cmp r9, r0
	movlt r0, #0
	blt _038000C0
	ldr r3, [r8, #0x48]
	cmp r3, #0
	beq _0380008C
	mov r0, r8
	mov r1, #0
	ldr r2, [r8, #0x4c]
	mov lr, pc
	bx r3
_0380008C:
	ldrb r0, [r8, #3]
	bic r0, r0, #0xf8
	orr r0, r0, #0x10
	strb r0, [r8, #3]
	ldrb r0, [r8, #3]
	bic r0, r0, #1
	strb r0, [r8, #3]
	mov r0, r8
	mov r1, r11
	ldr r2, [sp, #0x28]
	mov r3, r9
	bl InitAllocExChannel
	mov r0, r8
_038000C0:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_038000CC: .word sLockChannel
_038000D0: .word sWeakLockChannel
_038000D4: .word 0x03807F30
_038000D8: .word SNDi_Work
	arm_func_end SND_AllocExChannel

	arm_func_start SND_IsExChannelActive
SND_IsExChannelActive: // 0x038000DC
	ldrb r0, [r0, #3]
	mov r0, r0, lsl #0x1f
	mov r0, r0, lsr #0x1f
	bx lr
	arm_func_end SND_IsExChannelActive

	arm_func_start SND_ReleaseExChannel
SND_ReleaseExChannel: // 0x038000EC
	mov r1, #3
	strb r1, [r0, #2]
	bx lr
	arm_func_end SND_ReleaseExChannel

	arm_func_start SND_SetExChannelRelease
SND_SetExChannelRelease: // 0x038000F8
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	bl CalcRelease
	strh r0, [r4, #0x20]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end SND_SetExChannelRelease

	arm_func_start SND_SetExChannelSustain
SND_SetExChannelSustain: // 0x03800114
	strb r1, [r0, #0x1d]
	bx lr
	arm_func_end SND_SetExChannelSustain

	arm_func_start SND_SetExChannelDecay
SND_SetExChannelDecay: // 0x0380011C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	bl CalcRelease
	strh r0, [r4, #0x1e]
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end SND_SetExChannelDecay

	arm_func_start SND_SetExChannelAttack
SND_SetExChannelAttack: // 0x03800138
	cmp r1, #0x6d
	rsblt r1, r1, #0xff
	strltb r1, [r0, #0x1c]
	rsbge r2, r1, #0x7f
	ldrge r1, _03800158 // =0x03807F40
	ldrgeb r1, [r1, r2]
	strgeb r1, [r0, #0x1c]
	bx lr
	.align 2, 0
_03800158: .word 0x03807F40
	arm_func_end SND_SetExChannelAttack

	arm_func_start SND_UpdateExChannelEnvelope
SND_UpdateExChannelEnvelope: // 0x0380015C
	cmp r1, #0
	beq _03800200
	ldrb r1, [r0, #2]
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _03800200
_03800174: // jump table
	b _03800184 // case 0
	b _038001B4 // case 1
	b _03800200 // case 2
	b _038001F0 // case 3
_03800184:
	ldr r1, [r0, #0x10]
	rsb r2, r1, #0
	ldrb r1, [r0, #0x1c]
	mul r1, r2, r1
	mov r1, r1, asr #8
	rsb r1, r1, #0
	str r1, [r0, #0x10]
	ldr r1, [r0, #0x10]
	cmp r1, #0
	moveq r1, #1
	streqb r1, [r0, #2]
	b _03800200
_038001B4:
	ldrb r1, [r0, #0x1d]
	mov r2, r1, lsl #1
	ldr r1, _0380020C // =0x03807E2C
	ldrsh r1, [r1, r2]
	mov r3, r1, lsl #7
	ldr r2, [r0, #0x10]
	ldrh r1, [r0, #0x1e]
	sub r1, r2, r1
	str r1, [r0, #0x10]
	ldr r1, [r0, #0x10]
	cmp r1, r3
	strle r3, [r0, #0x10]
	movle r1, #2
	strleb r1, [r0, #2]
	b _03800200
_038001F0:
	ldr r2, [r0, #0x10]
	ldrh r1, [r0, #0x20]
	sub r1, r2, r1
	str r1, [r0, #0x10]
_03800200:
	ldr r0, [r0, #0x10]
	mov r0, r0, asr #7
	bx lr
	.align 2, 0
_0380020C: .word 0x03807E2C
	arm_func_end SND_UpdateExChannelEnvelope

	arm_func_start SND_StartExChannelNoise
SND_StartExChannelNoise: // 0x03800210
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrb r2, [r0, #0]
	cmp r2, #0xe
	movlo r0, #0
	blo _0380024C
	cmp r2, #0xf
	movhi r0, #0
	bhi _0380024C
	mov r2, #2
	strb r2, [r0, #1]
	ldr r2, _03800258 // =0x00001F46
	strh r2, [r0, #0x3c]
	bl StartExChannel
	mov r0, #1
_0380024C:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03800258: .word 0x00001F46
	arm_func_end SND_StartExChannelNoise

	arm_func_start SND_StartExChannelPsg
SND_StartExChannelPsg: // 0x0380025C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrb r3, [r0, #0]
	cmp r3, #8
	movlo r0, #0
	blo _038002A0
	cmp r3, #0xd
	movhi r0, #0
	bhi _038002A0
	mov r3, #1
	strb r3, [r0, #1]
	str r1, [r0, #0x44]
	ldr r1, _038002AC // =0x00001F46
	strh r1, [r0, #0x3c]
	mov r1, r2
	bl StartExChannel
	mov r0, #1
_038002A0:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_038002AC: .word 0x00001F46
	arm_func_end SND_StartExChannelPsg

	arm_func_start SND_StartExChannelPcm
SND_StartExChannelPcm: // 0x038002B0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov lr, r2
	mov r0, #0
	strb r0, [r4, #1]
	add ip, r4, #0x38
	ldmia r1, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	str lr, [r4, #0x44]
	mov r0, r4
	mov r1, r3
	bl StartExChannel
	mov r0, #1
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end SND_StartExChannelPcm

	arm_func_start SND_ExChannelMain
SND_ExChannelMain: // 0x038002EC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r6, r0
	mov r4, #0
	mov r11, r4
	mov r7, #1
	str r4, [sp, #8]
	mov r0, #0x7f
	str r0, [sp, #0x14]
	str r4, [sp, #0x10]
	str r4, [sp, #0xc]
	str r4, [sp, #4]
	str r4, [sp]
_03800320:
	ldr r8, [sp]
	mov r10, r8
	mov r9, r8
	mov r1, #0x54
	ldr r0, _038005F4 // =SNDi_Work
	mla r5, r4, r1, r0
	ldrb r1, [r5, #3]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _038005DC
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _03800384
	bic r0, r1, #0xf8
	mov r1, r1, lsl #0x18
	mov r1, r1, lsr #0x1b
	orr r1, r1, #1
	and r1, r1, #0xff
	and r1, r1, #0x1f
	orr r0, r0, r1, lsl #3
	strb r0, [r5, #3]
	ldrb r0, [r5, #3]
	bic r0, r0, #2
	strb r0, [r5, #3]
	b _038003D0
_03800384:
	mov r0, r4
	bl SND_IsChannelActive
	cmp r0, #0
	bne _038003D0
	ldr r3, [r5, #0x48]
	cmp r3, #0
	streqb r11, [r5, #0x22]
	beq _038003B8
	mov r0, r5
	mov r1, r7
	ldr r2, [r5, #0x4c]
	mov lr, pc
	bx r3
_038003B8:
	ldr r0, [sp, #4]
	strh r0, [r5, #0x24]
	ldrb r0, [r5, #3]
	bic r0, r0, #1
	strb r0, [r5, #3]
	b _038005DC
_038003D0:
	ldrb r0, [r5, #9]
	mov r1, r0, lsl #1
	ldr r0, _038005F8 // =0x03807E2C
	ldrsh r0, [r0, r1]
	add r8, r8, r0
	ldrb r1, [r5, #8]
	ldrb r0, [r5, #5]
	sub r0, r1, r0
	add r10, r10, r0, lsl #6
	mov r0, r5
	mov r1, r6
	bl SND_UpdateExChannelEnvelope
	add r8, r8, r0
	mov r0, r5
	mov r1, r6
	bl SweepMain
	add r2, r10, r0
	ldrsh r0, [r5, #0xc]
	add r1, r8, r0
	ldrsh r0, [r5, #6]
	add r8, r1, r0
	ldrsh r0, [r5, #0xe]
	add r10, r2, r0
	mov r0, r5
	mov r1, r6
	bl LfoMain
	ldrb r1, [r5, #0x28]
	cmp r1, #0
	beq _0380046C
	cmp r1, #1
	beq _03800458
	cmp r1, #2
	addeq r9, r9, r0
	b _03800470
_03800458:
	mov r1, #0x8000
	rsb r1, r1, #0
	cmp r8, r1
	addgt r8, r8, r0
	b _03800470
_0380046C:
	add r10, r10, r0
_03800470:
	ldrsb r0, [r5, #0xa]
	add r9, r9, r0
	ldrb r0, [r5, #4]
	cmp r0, #0x7f
	mulne r0, r9, r0
	addne r0, r0, #0x40
	movne r9, r0, asr #7
	ldrsb r0, [r5, #0xb]
	add r9, r9, r0
	ldrb r0, [r5, #2]
	cmp r0, #3
	bne _038004FC
	ldr r0, _038005FC // =0xFFFFFD2D
	cmp r8, r0
	bgt _038004FC
	ldrb r0, [r5, #3]
	bic r0, r0, #0xf8
	orr r0, r0, #0x10
	strb r0, [r5, #3]
	ldr r3, [r5, #0x48]
	cmp r3, #0
	ldreq r0, [sp, #8]
	streqb r0, [r5, #0x22]
	beq _038004E4
	mov r0, r5
	mov r1, r7
	ldr r2, [r5, #0x4c]
	mov lr, pc
	bx r3
_038004E4:
	ldr r0, [sp, #0xc]
	strh r0, [r5, #0x24]
	ldrb r0, [r5, #3]
	bic r0, r0, #1
	strb r0, [r5, #3]
	b _038005DC
_038004FC:
	mov r0, r8
	bl SND_CalcChannelVolume
	mov r8, r0
	ldrh r0, [r5, #0x3c]
	mov r1, r10
	bl SND_CalcTimer
	ldrb r1, [r5, #1]
	cmp r1, #1
	ldreq r1, _03800600 // =0x0000FFFC
	andeq r0, r0, r1
	moveq r0, r0, lsl #0x10
	moveq r0, r0, lsr #0x10
	adds r9, r9, #0x40
	ldrmi r9, [sp, #0x10]
	bmi _03800540
	cmp r9, #0x7f
	ldrgt r9, [sp, #0x14]
_03800540:
	ldrh r1, [r5, #0x24]
	cmp r8, r1
	beq _03800574
	strh r8, [r5, #0x24]
	ldrb r2, [r5, #3]
	bic r1, r2, #0xf8
	mov r2, r2, lsl #0x18
	mov r2, r2, lsr #0x1b
	orr r2, r2, #8
	and r2, r2, #0xff
	and r2, r2, #0x1f
	orr r1, r1, r2, lsl #3
	strb r1, [r5, #3]
_03800574:
	ldrh r1, [r5, #0x26]
	cmp r0, r1
	beq _038005A8
	strh r0, [r5, #0x26]
	ldrb r0, [r5, #3]
	bic r1, r0, #0xf8
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1b
	orr r0, r0, #4
	and r0, r0, #0xff
	and r0, r0, #0x1f
	orr r0, r1, r0, lsl #3
	strb r0, [r5, #3]
_038005A8:
	ldrb r0, [r5, #0x23]
	cmp r9, r0
	beq _038005DC
	strb r9, [r5, #0x23]
	ldrb r0, [r5, #3]
	bic r1, r0, #0xf8
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1b
	orr r0, r0, #0x10
	and r0, r0, #0xff
	and r0, r0, #0x1f
	orr r0, r1, r0, lsl #3
	strb r0, [r5, #3]
_038005DC:
	add r4, r4, #1
	cmp r4, #0x10
	blt _03800320
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_038005F4: .word SNDi_Work
_038005F8: .word 0x03807E2C
_038005FC: .word 0xFFFFFD2D
_03800600: .word 0x0000FFFC
	arm_func_end SND_ExChannelMain

	arm_func_start SND_UpdateExChannel
SND_UpdateExChannel: // 0x03800604
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x18
	mov r8, #0
	mov r4, #2
	mov r5, #1
	mov r6, r8
	ldr r7, _038007EC // =SNDi_Work
	mov r10, #0x54
_03800624:
	mla r9, r8, r10, r7
	ldrb r0, [r9, #3]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1b
	beq _03800784
	ands r0, r0, #2
	beq _0380064C
	mov r0, r8
	mov r1, r6
	bl SND_StopChannel
_0380064C:
	ldrb r0, [r9, #3]
	mov r0, r0, lsl #0x18
	mov r1, r0, lsr #0x1b
	ands r0, r1, #1
	beq _03800728
	ldrb r0, [r9, #1]
	cmp r0, #0
	beq _03800680
	cmp r0, #1
	beq _038006D8
	cmp r0, #2
	beq _03800704
	b _03800784
_03800680:
	ldrb r0, [r9, #0x39]
	cmp r0, #0
	movne r3, r5
	moveq r3, r4
	ldrh r1, [r9, #0x24]
	ldrh r0, [r9, #0x3e]
	str r0, [sp]
	ldr r0, [r9, #0x40]
	str r0, [sp, #4]
	and r0, r1, #0xff
	str r0, [sp, #8]
	mov r0, r1, asr #8
	str r0, [sp, #0xc]
	ldrh r0, [r9, #0x26]
	str r0, [sp, #0x10]
	ldrb r0, [r9, #0x23]
	str r0, [sp, #0x14]
	mov r0, r8
	ldr r1, [r9, #0x44]
	ldrb r2, [r9, #0x38]
	bl SND_SetupChannelPcm
	b _03800784
_038006D8:
	ldrh r3, [r9, #0x24]
	ldrh r0, [r9, #0x26]
	str r0, [sp]
	ldrb r0, [r9, #0x23]
	str r0, [sp, #4]
	mov r0, r8
	ldr r1, [r9, #0x44]
	and r2, r3, #0xff
	mov r3, r3, asr #8
	bl SND_SetupChannelPsg
	b _03800784
_03800704:
	ldrh r2, [r9, #0x24]
	ldrb r0, [r9, #0x23]
	str r0, [sp]
	mov r0, r8
	and r1, r2, #0xff
	mov r2, r2, asr #8
	ldrh r3, [r9, #0x26]
	bl SND_SetupChannelNoise
	b _03800784
_03800728:
	ands r0, r1, #4
	beq _0380073C
	mov r0, r8
	ldrh r1, [r9, #0x26]
	bl SND_SetChannelTimer
_0380073C:
	ldrb r0, [r9, #3]
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1b
	ands r0, r0, #8
	beq _03800764
	ldrh r2, [r9, #0x24]
	mov r0, r8
	and r1, r2, #0xff
	mov r2, r2, asr #8
	bl SND_SetChannelVolume
_03800764:
	ldrb r0, [r9, #3]
	mov r0, r0, lsl #0x18
	mov r0, r0, lsr #0x1b
	ands r0, r0, #0x10
	beq _03800784
	mov r0, r8
	ldrb r1, [r9, #0x23]
	bl SND_SetChannelPan
_03800784:
	add r8, r8, #1
	cmp r8, #0x10
	blt _03800624
	mov r5, #0
	ldr r3, _038007EC // =SNDi_Work
	mov r1, #0x54
_0380079C:
	mla r4, r5, r1, r3
	ldrb r0, [r4, #3]
	mov r0, r0, lsl #0x18
	movs r0, r0, lsr #0x1b
	beq _038007D4
	ands r0, r0, #1
	movne r0, r5, lsl #4
	addne r0, r0, #0x4000000
	ldrneb r2, [r0, #0x403]
	orrne r2, r2, #0x80
	strneb r2, [r0, #0x403]
	ldrb r0, [r4, #3]
	bic r0, r0, #0xf8
	strb r0, [r4, #3]
_038007D4:
	add r5, r5, #1
	cmp r5, #0x10
	blt _0380079C
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_038007EC: .word SNDi_Work
	arm_func_end SND_UpdateExChannel

	arm_func_start SND_ExChannelInit
SND_ExChannelInit: // 0x038007F0
	mov ip, #0
	ldr r2, _03800844 // =SNDi_Work
	mov r0, #0x54
_038007FC:
	mul r1, ip, r0
	add r3, r2, r1
	strb ip, [r2, r1]
	ldrb r1, [r3, #3]
	bic r1, r1, #0xf8
	strb r1, [r3, #3]
	ldrb r1, [r3, #3]
	bic r1, r1, #1
	strb r1, [r3, #3]
	add ip, ip, #1
	cmp ip, #0x10
	blt _038007FC
	mov r1, #0
	ldr r0, _03800848 // =sLockChannel
	str r1, [r0]
	ldr r0, _0380084C // =sWeakLockChannel
	str r1, [r0]
	bx lr
	.align 2, 0
_03800844: .word SNDi_Work
_03800848: .word sLockChannel
_0380084C: .word sWeakLockChannel
	arm_func_end SND_ExChannelInit

	arm_func_start SetTrackMute
SetTrackMute: // 0x03800850
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r2, #3
	addls pc, pc, r2, lsl #2
	b _038008C8
_03800864: // jump table
	b _03800874 // case 0
	b _03800884 // case 1
	b _03800894 // case 2
	b _038008AC // case 3
_03800874:
	ldrb r0, [r4, #0]
	bic r0, r0, #4
	strb r0, [r4]
	b _038008C8
_03800884:
	ldrb r0, [r4, #0]
	orr r0, r0, #4
	strb r0, [r4]
	b _038008C8
_03800894:
	ldrb r2, [r4, #0]
	orr r2, r2, #4
	strb r2, [r4]
	mvn r2, #0
	bl ReleaseTrackChannelAll
	b _038008C8
_038008AC:
	ldrb r2, [r4, #0]
	orr r2, r2, #4
	strb r2, [r4]
	mov r2, #0x7f
	bl ReleaseTrackChannelAll
	mov r0, r4
	bl FreeTrackChannelAll
_038008C8:
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end SetTrackMute

	arm_func_start AllocTrack
AllocTrack: // 0x038008D0
	mov r0, #0
	ldr r3, _03800910 // =0x03809384
	b _03800900
_038008DC:
	add ip, r3, r0, lsl #6
	ldrb r1, [r3, r0, lsl #6]
	mov r2, r1, lsl #0x1f
	movs r2, r2, lsr #0x1f
	biceq r1, r1, #1
	orreq r1, r1, #1
	streqb r1, [ip]
	bxeq lr
	add r0, r0, #1
_03800900:
	cmp r0, #0x20
	blt _038008DC
	mvn r0, #0
	bx lr
	.align 2, 0
_03800910: .word 0x03809384
	arm_func_end AllocTrack

	arm_func_start GetVariablePtr
GetVariablePtr: // 0x03800914
	ldr r2, _03800954 // =SNDi_SharedWork
	ldr r2, [r2, #0]
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r1, #0x10
	addge r2, r2, #0x260
	subge r0, r1, #0x10
	addge r0, r2, r0, lsl #1
	bxge lr
	add r3, r2, #0x20
	ldrb r2, [r0, #1]
	mov r0, #0x24
	mla r0, r2, r0, r3
	add r0, r0, r1, lsl #1
	bx lr
	.align 2, 0
_03800954: .word SNDi_SharedWork
	arm_func_end GetVariablePtr

	arm_func_start PlayerSeqMain
PlayerSeqMain: // 0x03800958
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r7, r1
	mov r6, #0
	mov r5, r6
	mov r4, #1
_03800970:
	mov r0, r8
	mov r1, r5
	bl GetPlayerTrack
	cmp r0, #0
	beq _038009B8
	ldr r1, [r0, #0x28]
	cmp r1, #0
	beq _038009B8
	mov r1, r8
	mov r2, r5
	mov r3, r7
	bl TrackSeqMain
	cmp r0, #0
	moveq r6, r4
	beq _038009B8
	mov r0, r8
	mov r1, r5
	bl ClosePlayerTrack
_038009B8:
	add r5, r5, #1
	cmp r5, #0x10
	blt _03800970
	cmp r6, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	arm_func_end PlayerSeqMain

	arm_func_start TrackSeqMain
TrackSeqMain: // 0x038009D8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r9, r0
	mov r8, r1
	str r3, [sp, #4]
	ldr r2, [r9, #0x3c]
	b _03800A2C
_038009F4:
	ldr r0, [r2, #0x34]
	cmp r0, #0
	subgt r0, r0, #1
	strgt r0, [r2, #0x34]
	ldrb r0, [r2, #3]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _03800A28
	ldr r1, [r2, #0x14]
	ldr r0, [r2, #0x18]
	cmp r1, r0
	addlt r0, r1, #1
	strlt r0, [r2, #0x14]
_03800A28:
	ldr r2, [r2, #0x50]
_03800A2C:
	cmp r2, #0
	bne _038009F4
	ldrb r1, [r9, #0]
	mov r0, r1, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _03800A5C
	ldr r0, [r9, #0x3c]
	cmp r0, #0
	movne r0, #0
	bne _03801394
	bic r0, r1, #0x10
	strb r0, [r9]
_03800A5C:
	ldr r0, [r9, #0x20]
	cmp r0, #0
	ble _03800A80
	sub r0, r0, #1
	str r0, [r9, #0x20]
	ldr r0, [r9, #0x20]
	cmp r0, #0
	movgt r0, #0
	bgt _03801394
_03800A80:
	ldr r0, [r9, #0x28]
	bl InitCache
	add r0, r9, #0x28
	str r0, [sp, #0x1c]
	mov r0, #2
	str r0, [sp, #0x20]
	mov r0, #0x7f
	str r0, [sp, #0x24]
	mov r11, #0
	mvn r0, #0
	str r0, [sp, #0x28]
	mov r10, #1
	mov r0, #3
	str r0, [sp, #0x14]
	mov r0, #4
	str r0, [sp, #0x18]
	b _03801374
_03800AC4:
	mov r4, r11
	mov r6, r10
	ldr r0, [r9, #0x28]
	bl GetByteCache
	mov r7, r0
	ldr r0, [r9, #0x28]
	add r0, r0, #1
	str r0, [r9, #0x28]
	cmp r7, #0xa2
	bne _03800B10
	ldr r0, [r9, #0x28]
	bl GetByteCache
	mov r7, r0
	ldr r0, [r9, #0x28]
	add r0, r0, #1
	str r0, [r9, #0x28]
	ldrb r0, [r9, #0]
	mov r0, r0, lsl #0x19
	mov r6, r0, lsr #0x1f
_03800B10:
	cmp r7, #0xa0
	bne _03800B3C
	ldr r0, [r9, #0x28]
	bl GetByteCache
	mov r7, r0
	ldr r0, [r9, #0x28]
	add r0, r0, #1
	str r0, [r9, #0x28]
	ldr r0, [sp, #0x14]
	str r0, [sp, #8]
	mov r4, r10
_03800B3C:
	cmp r7, #0xa1
	bne _03800B68
	ldr r0, [r9, #0x28]
	bl GetByteCache
	mov r7, r0
	ldr r0, [r9, #0x28]
	add r0, r0, #1
	str r0, [r9, #0x28]
	ldr r0, [sp, #0x18]
	str r0, [sp, #8]
	mov r4, r10
_03800B68:
	ands r0, r7, #0x80
	bne _03800C3C
	ldr r0, [r9, #0x28]
	bl GetByteCache
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0]
	add r1, r0, #1
	ldr r0, [sp, #0x1c]
	str r1, [r0]
	cmp r4, #0
	ldrne r2, [sp, #8]
	ldreq r2, [sp, #0x20]
	mov r0, r9
	mov r1, r8
	bl ReadArg
	mov r5, r0
	ldrsb r0, [r9, #0x13]
	add r4, r7, r0
	cmp r6, #0
	beq _03801374
	cmp r4, #0
	movlt r4, r11
	blt _03800BD0
	cmp r4, #0x7f
	ldrgt r4, [sp, #0x24]
_03800BD0:
	ldrb r0, [r9, #0]
	mov r0, r0, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _03800C10
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _03800C10
	cmp r5, #0
	movgt r0, r5
	ldrle r0, [sp, #0x28]
	str r0, [sp]
	mov r0, r9
	mov r1, r8
	mov r2, r4
	ldr r3, [sp, #0xc]
	bl NoteOnCommandProc
_03800C10:
	strb r4, [r9, #0x14]
	ldrb r0, [r9, #0]
	mov r0, r0, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _03801374
	str r5, [r9, #0x20]
	cmp r5, #0
	ldreqb r0, [r9, #0]
	orreq r0, r0, #0x10
	streqb r0, [r9]
	b _03801374
_03800C3C:
	and r0, r7, #0xf0
	cmp r0, #0xc0
	bgt _03800C78
	cmp r0, #0xc0
	bge _03800DC8
	cmp r0, #0x90
	bgt _03800C6C
	cmp r0, #0x90
	bge _03800CE8
	cmp r0, #0x80
	beq _03800CA0
	b _03801374
_03800C6C:
	cmp r0, #0xb0
	beq _03801078
	b _03801374
_03800C78:
	cmp r0, #0xe0
	bgt _03800C94
	cmp r0, #0xe0
	bge _03801024
	cmp r0, #0xd0
	beq _03800DC8
	b _03801374
_03800C94:
	cmp r0, #0xf0
	beq _038012D0
	b _03801374
_03800CA0:
	cmp r4, #0
	ldrne r2, [sp, #8]
	ldreq r2, [sp, #0x20]
	mov r0, r9
	mov r1, r8
	bl ReadArg
	cmp r6, #0
	beq _03801374
	cmp r7, #0x80
	beq _03800CD4
	cmp r7, #0x81
	beq _03800CDC
	b _03801374
_03800CD4:
	str r0, [r9, #0x20]
	b _03801374
_03800CDC:
	cmp r0, #0x10000
	strlth r0, [r9, #2]
	b _03801374
_03800CE8:
	cmp r7, #0x93
	beq _03800D04
	cmp r7, #0x94
	beq _03800D68
	cmp r7, #0x95
	beq _03800D84
	b _03801374
_03800D04:
	ldr r0, [r9, #0x28]
	bl GetByteCache
	mov r4, r0
	ldr r0, [r9, #0x28]
	add r0, r0, #1
	str r0, [r9, #0x28]
	mov r0, r9
	bl Read24
	mov r5, r0
	cmp r6, #0
	beq _03801374
	mov r0, r8
	mov r1, r4
	bl GetPlayerTrack
	movs r4, r0
	beq _03801374
	cmp r4, r9
	beq _03801374
	mov r1, r8
	bl CloseTrack
	mov r0, r4
	ldr r1, [r9, #0x24]
	mov r2, r5
	bl StartTrack
	b _03801374
_03800D68:
	mov r0, r9
	bl Read24
	cmp r6, #0
	ldrne r1, [r9, #0x24]
	addne r0, r1, r0
	strne r0, [r9, #0x28]
	b _03801374
_03800D84:
	mov r0, r9
	bl Read24
	cmp r6, #0
	beq _03801374
	ldrb r1, [r9, #0x3b]
	cmp r1, #3
	bhs _03801374
	ldr r2, [r9, #0x28]
	add r1, r9, r1, lsl #2
	str r2, [r1, #0x2c]
	ldrb r1, [r9, #0x3b]
	add r1, r1, #1
	strb r1, [r9, #0x3b]
	ldr r1, [r9, #0x24]
	add r0, r1, r0
	str r0, [r9, #0x28]
	b _03801374
_03800DC8:
	cmp r4, #0
	ldrne r2, [sp, #8]
	moveq r2, r11
	mov r0, r9
	mov r1, r8
	bl ReadArg
	strb r0, [sp, #0x2c]
	cmp r6, #0
	beq _03801374
	sub r0, r7, #0xc0
	cmp r0, #0x17
	addls pc, pc, r0, lsl #2
	b _03801374
_03800DFC: // jump table
	b _03800FF4 // case 0
	b _03800E5C // case 1
	b _03800E74 // case 2
	b _03800FDC // case 3
	b _03800FE8 // case 4
	b _03800E80 // case 5
	b _03800E8C // case 6
	b _03800E98 // case 7
	b _03800F58 // case 8
	b _03800FA0 // case 9
	b _03800EC0 // case 10
	b _03800ECC // case 11
	b _03800ED8 // case 12
	b _03800EE4 // case 13
	b _03800FC0 // case 14
	b _03800EB4 // case 15
	b _03800EF0 // case 16
	b _03800EFC // case 17
	b _03800F08 // case 18
	b _03800F14 // case 19
	b _03800F20 // case 20
	b _03800E68 // case 21
	b _03801004 // case 22
	b _03800F8C // case 23
_03800E5C:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #4]
	b _03801374
_03800E68:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #5]
	b _03801374
_03800E74:
	ldrb r0, [sp, #0x2c]
	strb r0, [r8, #5]
	b _03801374
_03800E80:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #7]
	b _03801374
_03800E8C:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #0x12]
	b _03801374
_03800E98:
	ldrb r0, [r9, #0]
	bic r1, r0, #2
	ldrb r0, [sp, #0x2c]
	and r0, r0, #1
	orr r0, r1, r0, lsl #1
	strb r0, [r9]
	b _03801374
_03800EB4:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #0x15]
	b _03801374
_03800EC0:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #0x1a]
	b _03801374
_03800ECC:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #0x19]
	b _03801374
_03800ED8:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #0x18]
	b _03801374
_03800EE4:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #0x1b]
	b _03801374
_03800EF0:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #0xe]
	b _03801374
_03800EFC:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #0xf]
	b _03801374
_03800F08:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #0x10]
	b _03801374
_03800F14:
	ldrb r0, [sp, #0x2c]
	strb r0, [r9, #0x11]
	b _03801374
_03800F20:
	ldrb r0, [r9, #0x3b]
	cmp r0, #3
	bhs _03801374
	ldr r1, [r9, #0x28]
	add r0, r9, r0, lsl #2
	str r1, [r0, #0x2c]
	ldrb r1, [sp, #0x2c]
	ldrb r0, [r9, #0x3b]
	add r0, r9, r0
	strb r1, [r0, #0x38]
	ldrb r0, [r9, #0x3b]
	add r0, r0, #1
	strb r0, [r9, #0x3b]
	b _03801374
_03800F58:
	ldrb r0, [r9, #0]
	bic r1, r0, #8
	ldrb r0, [sp, #0x2c]
	and r0, r0, #1
	orr r0, r1, r0, lsl #3
	strb r0, [r9]
	mov r0, r9
	mov r1, r8
	ldr r2, [sp, #0x28]
	bl ReleaseTrackChannelAll
	mov r0, r9
	bl FreeTrackChannelAll
	b _03801374
_03800F8C:
	mov r0, r9
	mov r1, r8
	ldrb r2, [sp, #0x2c]
	bl SetTrackMute
	b _03801374
_03800FA0:
	ldrb r1, [sp, #0x2c]
	ldrsb r0, [r9, #0x13]
	add r0, r1, r0
	strb r0, [r9, #0x14]
	ldrb r0, [r9, #0]
	orr r0, r0, #0x20
	strb r0, [r9]
	b _03801374
_03800FC0:
	ldrb r0, [r9, #0]
	bic r1, r0, #0x20
	ldrb r0, [sp, #0x2c]
	and r0, r0, #1
	orr r0, r1, r0, lsl #5
	strb r0, [r9]
	b _03801374
_03800FDC:
	ldrsb r0, [sp, #0x2c]
	strb r0, [r9, #0x13]
	b _03801374
_03800FE8:
	ldrsb r0, [sp, #0x2c]
	strb r0, [r9, #6]
	b _03801374
_03800FF4:
	ldrb r0, [sp, #0x2c]
	sub r0, r0, #0x40
	strb r0, [r9, #8]
	b _03801374
_03801004:
	ldr r0, _038013A0 // =sMmlPrintEnable
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _03801374
	mov r0, r8
	ldrb r1, [sp, #0x2c]
	bl GetVariablePtr
	b _03801374
_03801024:
	cmp r4, #0
	ldrne r2, [sp, #8]
	moveq r2, r10
	mov r0, r9
	mov r1, r8
	bl ReadArg
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	cmp r6, #0
	beq _03801374
	cmp r7, #0xe0
	beq _03801070
	cmp r7, #0xe1
	beq _03801068
	cmp r7, #0xe3
	streqh r0, [r9, #0x16]
	b _03801374
_03801068:
	strh r0, [r8, #0x18]
	b _03801374
_03801070:
	strh r0, [r9, #0x1c]
	b _03801374
_03801078:
	ldr r0, [r9, #0x28]
	bl GetByteCache
	str r0, [sp, #0x10]
	ldr r0, [r9, #0x28]
	add r0, r0, #1
	str r0, [r9, #0x28]
	cmp r4, #0
	ldrne r2, [sp, #8]
	moveq r2, r10
	mov r0, r9
	mov r1, r8
	bl ReadArg
	mov r0, r0, lsl #0x10
	mov r5, r0, asr #0x10
	mov r0, r8
	ldr r1, [sp, #0x10]
	bl GetVariablePtr
	mov r4, r0
	cmp r6, #0
	beq _03801374
	cmp r4, #0
	beq _03801374
	sub r0, r7, #0xb0
	cmp r0, #0xd
	addls pc, pc, r0, lsl #2
	b _03801374
_038010E0: // jump table
	b _03801118 // case 0
	b _03801120 // case 1
	b _03801130 // case 2
	b _03801140 // case 3
	b _03801150 // case 4
	b _0380116C // case 5
	b _03801190 // case 6
	b _03801374 // case 7
	b _038011C8 // case 8
	b _038011F4 // case 9
	b _03801220 // case 10
	b _0380124C // case 11
	b _03801278 // case 12
	b _038012A4 // case 13
_03801118:
	strh r5, [r4]
	b _03801374
_03801120:
	ldrsh r0, [r4, #0]
	add r0, r0, r5
	strh r0, [r4]
	b _03801374
_03801130:
	ldrsh r0, [r4, #0]
	sub r0, r0, r5
	strh r0, [r4]
	b _03801374
_03801140:
	ldrsh r0, [r4, #0]
	mul r1, r0, r5
	strh r1, [r4]
	b _03801374
_03801150:
	cmp r5, #0
	beq _03801374
	ldrsh r0, [r4, #0]
	mov r1, r5
	bl _s32_div_f
	strh r0, [r4]
	b _03801374
_0380116C:
	cmp r5, #0
	ldrgesh r0, [r4, #0]
	movge r0, r0, lsl r5
	strgeh r0, [r4]
	ldrltsh r1, [r4, #0]
	rsblt r0, r5, #0
	movlt r0, r1, asr r0
	strlth r0, [r4]
	b _03801374
_03801190:
	mov r6, r11
	cmp r5, #0
	movlt r6, r10
	rsblt r0, r5, #0
	movlt r0, r0, lsl #0x10
	movlt r5, r0, asr #0x10
	bl SND_CalcRandom
	add r1, r5, #1
	mul r1, r0, r1
	mov r0, r1, asr #0x10
	cmp r6, #0
	rsbne r0, r0, #0
	strh r0, [r4]
	b _03801374
_038011C8:
	ldrsh r0, [r4, #0]
	cmp r0, r5
	moveq r2, r10
	movne r2, r11
	ldrb r0, [r9, #0]
	bic r1, r0, #0x40
	and r0, r2, #0xff
	and r0, r0, #1
	orr r0, r1, r0, lsl #6
	strb r0, [r9]
	b _03801374
_038011F4:
	ldrsh r0, [r4, #0]
	cmp r0, r5
	movge r2, r10
	movlt r2, r11
	ldrb r0, [r9, #0]
	bic r1, r0, #0x40
	and r0, r2, #0xff
	and r0, r0, #1
	orr r0, r1, r0, lsl #6
	strb r0, [r9]
	b _03801374
_03801220:
	ldrsh r0, [r4, #0]
	cmp r0, r5
	movgt r2, r10
	movle r2, r11
	ldrb r0, [r9, #0]
	bic r1, r0, #0x40
	and r0, r2, #0xff
	and r0, r0, #1
	orr r0, r1, r0, lsl #6
	strb r0, [r9]
	b _03801374
_0380124C:
	ldrsh r0, [r4, #0]
	cmp r0, r5
	movle r2, r10
	movgt r2, r11
	ldrb r0, [r9, #0]
	bic r1, r0, #0x40
	and r0, r2, #0xff
	and r0, r0, #1
	orr r0, r1, r0, lsl #6
	strb r0, [r9]
	b _03801374
_03801278:
	ldrsh r0, [r4, #0]
	cmp r0, r5
	movlt r2, r10
	movge r2, r11
	ldrb r0, [r9, #0]
	bic r1, r0, #0x40
	and r0, r2, #0xff
	and r0, r0, #1
	orr r0, r1, r0, lsl #6
	strb r0, [r9]
	b _03801374
_038012A4:
	ldrsh r0, [r4, #0]
	cmp r0, r5
	movne r2, r10
	moveq r2, r11
	ldrb r0, [r9, #0]
	bic r1, r0, #0x40
	and r0, r2, #0xff
	and r0, r0, #1
	orr r0, r1, r0, lsl #6
	strb r0, [r9]
	b _03801374
_038012D0:
	cmp r6, #0
	beq _03801374
	sub r0, r7, #0xfc
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _03801374
_038012E8: // jump table
	b _03801320 // case 0
	b _038012F8 // case 1
	b _03801374 // case 2
	b _0380136C // case 3
_038012F8:
	ldrb r0, [r9, #0x3b]
	cmp r0, #0
	beq _03801374
	sub r0, r0, #1
	strb r0, [r9, #0x3b]
	ldrb r0, [r9, #0x3b]
	add r0, r9, r0, lsl #2
	ldr r0, [r0, #0x2c]
	str r0, [r9, #0x28]
	b _03801374
_03801320:
	ldrb r0, [r9, #0x3b]
	cmp r0, #0
	beq _03801374
	sub r1, r0, #1
	add r2, r9, r1
	ldrb r0, [r2, #0x38]
	cmp r0, #0
	beq _03801350
	sub r0, r0, #1
	ands r0, r0, #0xff
	streqb r1, [r9, #0x3b]
	beq _03801374
_03801350:
	strb r0, [r2, #0x38]
	ldrb r0, [r9, #0x3b]
	sub r0, r0, #1
	add r0, r9, r0, lsl #2
	ldr r0, [r0, #0x2c]
	str r0, [r9, #0x28]
	b _03801374
_0380136C:
	mvn r0, #0
	b _03801394
_03801374:
	ldr r0, [r9, #0x20]
	cmp r0, #0
	bne _03801390
	ldrb r0, [r9, #0]
	mov r0, r0, lsl #0x1b
	movs r0, r0, lsr #0x1f
	beq _03800AC4
_03801390:
	mov r0, #0
_03801394:
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_038013A0: .word sMmlPrintEnable
	arm_func_end TrackSeqMain

	arm_func_start NoteOnCommandProc
NoteOnCommandProc: // 0x038013A4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x18
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	mov r4, #0
	ldrb r0, [r8, #0]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	beq _038013E0
	ldr r4, [r8, #0x3c]
	cmp r4, #0
	strneb r6, [r4, #8]
	strneb r5, [r4, #9]
_038013E0:
	cmp r4, #0
	bne _038014D4
	ldr r0, [r7, #0x20]
	ldrh r1, [r8, #2]
	mov r2, r6
	add r3, sp, #8
	bl SND_ReadInstData
	cmp r0, #0
	beq _0380159C
	ldrb r0, [sp, #8]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _03801440
_03801414: // jump table
	b _03801440 // case 0
	b _03801428 // case 1
	b _03801430 // case 2
	b _03801438 // case 3
	b _03801428 // case 4
_03801428:
	ldr r1, _038015A8 // =0x0000FFFF
	b _03801444
_03801430:
	mov r1, #0x3f00
	b _03801444
_03801438:
	mov r1, #0xc000
	b _03801444
_03801440:
	b _0380159C
_03801444:
	ldrh r0, [r8, #0x1e]
	and r0, r1, r0
	str r8, [sp]
	ldrb r2, [r7, #4]
	ldrb r1, [r8, #0x12]
	add r1, r2, r1
	ldrb r2, [r8, #0]
	mov r2, r2, lsl #0x18
	mov r2, r2, lsr #0x1f
	ldr r3, _038015AC // =ChannelCallback
	bl SND_AllocExChannel
	movs r4, r0
	beq _0380159C
	ldrb r0, [r8, #0]
	mov r0, r0, lsl #0x1c
	movs r0, r0, lsr #0x1f
	mvnne r3, #0
	ldreq r3, [sp, #0x30]
	ldr r0, [r7, #0x20]
	str r0, [sp]
	add r0, sp, #8
	str r0, [sp, #4]
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl SND_NoteOn
	cmp r0, #0
	bne _038014C8
	mov r0, #0
	strb r0, [r4, #0x22]
	mov r0, r4
	bl SND_FreeExChannel
	b _0380159C
_038014C8:
	ldr r0, [r8, #0x3c]
	str r0, [r4, #0x50]
	str r4, [r8, #0x3c]
_038014D4:
	ldrb r1, [r8, #0xe]
	cmp r1, #0xff
	beq _038014E8
	mov r0, r4
	bl SND_SetExChannelAttack
_038014E8:
	ldrb r1, [r8, #0xf]
	cmp r1, #0xff
	beq _038014FC
	mov r0, r4
	bl SND_SetExChannelDecay
_038014FC:
	ldrb r1, [r8, #0x10]
	cmp r1, #0xff
	beq _03801510
	mov r0, r4
	bl SND_SetExChannelSustain
_03801510:
	ldrb r1, [r8, #0x11]
	cmp r1, #0xff
	beq _03801524
	mov r0, r4
	bl SND_SetExChannelRelease
_03801524:
	ldrsh r0, [r8, #0x16]
	strh r0, [r4, #0x32]
	ldrb r0, [r8, #0]
	mov r0, r0, lsl #0x1a
	movs r0, r0, lsr #0x1f
	beq _03801554
	ldrsh r1, [r4, #0x32]
	ldrb r0, [r8, #0x14]
	sub r0, r0, r6
	mov r0, r0, lsl #0x16
	add r0, r1, r0, asr #16
	strh r0, [r4, #0x32]
_03801554:
	ldrb r0, [r8, #0x15]
	cmp r0, #0
	bne _03801578
	ldr r0, [sp, #0x30]
	str r0, [r4, #0x18]
	ldrb r0, [r4, #3]
	bic r0, r0, #4
	strb r0, [r4, #3]
	b _03801594
_03801578:
	mul r1, r0, r0
	ldrsh r0, [r4, #0x32]
	cmp r0, #0
	rsblt r0, r0, #0
	mul r0, r1, r0
	mov r0, r0, asr #0xb
	str r0, [r4, #0x18]
_03801594:
	mov r0, #0
	str r0, [r4, #0x14]
_0380159C:
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_038015A8: .word 0x0000FFFF
_038015AC: .word ChannelCallback
	arm_func_end NoteOnCommandProc

	arm_func_start UpdatePlayerChannel
UpdatePlayerChannel: // 0x038015B0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, #0
	mov r4, #1
_038015C0:
	mov r0, r6
	mov r1, r5
	bl GetPlayerTrack
	cmp r0, #0
	beq _038015E0
	mov r1, r6
	mov r2, r4
	bl UpdateTrackChannel
_038015E0:
	add r5, r5, #1
	cmp r5, #0x10
	blt _038015C0
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end UpdatePlayerChannel

	arm_func_start UpdateTrackChannel
UpdateTrackChannel: // 0x038015F4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r11, r2
	ldrb r0, [r1, #5]
	mov r0, r0, lsl #1
	ldr r4, _03801750 // =0x03807E2C
	ldrsh r3, [r4, r0]
	ldrb r0, [r10, #4]
	mov r0, r0, lsl #1
	ldrsh r2, [r4, r0]
	ldrb r0, [r10, #5]
	mov r0, r0, lsl #1
	ldrsh r0, [r4, r0]
	add r0, r2, r0
	add r3, r3, r0
	ldrsh r2, [r10, #0xa]
	ldrsh r0, [r1, #6]
	add r2, r2, r0
	ldrsb r4, [r10, #6]
	ldrb r0, [r10, #7]
	mov r0, r0, lsl #6
	mul r1, r4, r0
	ldrsh r0, [r10, #0xc]
	add r0, r0, r1, asr #7
	ldrsb r1, [r10, #8]
	ldrb r4, [r10, #1]
	cmp r4, #0x7f
	mulne r4, r1, r4
	addne r1, r4, #0x40
	movne r1, r1, asr #7
	ldrsb r4, [r10, #9]
	add r1, r1, r4
	mov r4, #0x8000
	rsb r4, r4, #0
	cmp r3, r4
	movlt r3, r4
	mov r4, #0x8000
	rsb r4, r4, #0
	cmp r2, r4
	movlt r2, r4
	mvn r4, #0x7f
	cmp r1, r4
	movlt r1, r4
	blt _038016B0
	cmp r1, #0x7f
	movgt r1, #0x7f
_038016B0:
	ldr r9, [r10, #0x3c]
	mov r4, #1
	mov r3, r3, lsl #0x10
	mov r7, r3, asr #0x10
	mov r0, r0, lsl #0x10
	mov r6, r0, asr #0x10
	mov r0, r1, lsl #0x18
	mov r5, r0, asr #0x18
	mov r0, r2, lsl #0x10
	mov r8, r0, asr #0x10
	b _0380173C
_038016DC:
	strh r8, [r9, #6]
	ldrb r0, [r9, #2]
	cmp r0, #3
	beq _03801738
	strh r7, [r9, #0xc]
	strh r6, [r9, #0xe]
	strb r5, [r9, #0xb]
	ldrb r0, [r10, #1]
	strb r0, [r9, #4]
	ldrh r0, [r10, #0x18]
	strh r0, [r9, #0x28]
	ldrh r0, [r10, #0x1a]
	strh r0, [r9, #0x2a]
	ldrh r0, [r10, #0x1c]
	strh r0, [r9, #0x2c]
	ldr r0, [r9, #0x34]
	cmp r0, #0
	bne _03801738
	cmp r11, #0
	beq _03801738
	strb r4, [r9, #0x22]
	mov r0, r9
	bl SND_ReleaseExChannel
_03801738:
	ldr r9, [r9, #0x50]
_0380173C:
	cmp r9, #0
	bne _038016DC
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_03801750: .word 0x03807E2C
	arm_func_end UpdateTrackChannel

	arm_func_start ChannelCallback
ChannelCallback: // 0x03801754
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r2
	cmp r1, #1
	bne _03801778
	mov r1, #0
	strb r1, [r5, #0x22]
	bl SND_FreeExChannel
_03801778:
	ldr r1, [r4, #0x3c]
	cmp r1, r5
	ldreq r0, [r5, #0x50]
	streq r0, [r4, #0x3c]
	beq _038017B0
	b _038017A4
_03801790:
	cmp r0, r5
	ldreq r0, [r5, #0x50]
	streq r0, [r1, #0x50]
	beq _038017B0
	mov r1, r0
_038017A4:
	ldr r0, [r1, #0x50]
	cmp r0, #0
	bne _03801790
_038017B0:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end ChannelCallback

	arm_func_start FinishPlayer
FinishPlayer: // 0x038017BC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, #0
_038017CC:
	mov r0, r5
	mov r1, r4
	bl ClosePlayerTrack
	add r4, r4, #1
	cmp r4, #0x10
	blt _038017CC
	ldrb r0, [r5, #0]
	bic r0, r0, #1
	strb r0, [r5]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end FinishPlayer

	arm_func_start ClosePlayerTrack
ClosePlayerTrack: // 0x038017FC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl GetPlayerTrack
	cmp r0, #0
	beq _03801840
	mov r1, r5
	bl CloseTrack
	add r3, r5, #8
	ldr r2, _0380184C // =0x03809384
	ldrb r1, [r3, r4]
	ldrb r0, [r2, r1, lsl #6]
	bic r0, r0, #1
	strb r0, [r2, r1, lsl #6]
	mov r0, #0xff
	strb r0, [r3, r4]
_03801840:
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_0380184C: .word 0x03809384
	arm_func_end ClosePlayerTrack

	arm_func_start CloseTrack
CloseTrack: // 0x03801850
	stmdb sp!, {r4, lr}
	mov r4, r0
	mvn r2, #0
	bl ReleaseTrackChannelAll
	mov r0, r4
	bl FreeTrackChannelAll
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end CloseTrack

	arm_func_start GetPlayerTrack
GetPlayerTrack: // 0x03801870
	cmp r1, #0xf
	movgt r0, #0
	bxgt lr
	add r0, r0, r1
	ldrb r1, [r0, #8]
	cmp r1, #0xff
	moveq r0, #0
	ldrne r0, _03801898 // =0x03809384
	addne r0, r0, r1, lsl #6
	bx lr
	.align 2, 0
_03801898: .word 0x03809384
	arm_func_end GetPlayerTrack

	arm_func_start PlayerTempoMain
PlayerTempoMain: // 0x0380189C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r5, #0
	add r1, r6, #0x1c
	b _038018C4
_038018B4:
	ldrh r0, [r1, #0]
	sub r0, r0, #0xf0
	strh r0, [r1]
	add r5, r5, #1
_038018C4:
	ldrh r0, [r6, #0x1c]
	cmp r0, #0xf0
	bhs _038018B4
	mov r4, #0
	mov r7, #1
	b _03801900
_038018DC:
	mov r0, r6
	mov r1, r7
	bl PlayerSeqMain
	cmp r0, #0
	beq _038018FC
	mov r0, r6
	bl FinishPlayer
	b _03801908
_038018FC:
	add r4, r4, #1
_03801900:
	cmp r4, r5
	blt _038018DC
_03801908:
	ldr r0, _03801958 // =SNDi_SharedWork
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _03801934
	add r3, r0, #0x40
	ldrb r1, [r6, #1]
	mov r0, #0x24
	mul r2, r1, r0
	ldr r0, [r3, r2]
	add r0, r0, r4
	str r0, [r3, r2]
_03801934:
	ldrh r2, [r6, #0x18]
	ldrh r0, [r6, #0x1a]
	mul r1, r2, r0
	ldrh r0, [r6, #0x1c]
	add r0, r0, r1, asr #8
	strh r0, [r6, #0x1c]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_03801958: .word SNDi_SharedWork
	arm_func_end PlayerTempoMain

	arm_func_start FreeTrackChannelAll
FreeTrackChannelAll: // 0x0380195C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r4, [r5, #0x3c]
	b _0380197C
_03801970:
	mov r0, r4
	bl SND_FreeExChannel
	ldr r4, [r4, #0x50]
_0380197C:
	cmp r4, #0
	bne _03801970
	mov r0, #0
	str r0, [r5, #0x3c]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end FreeTrackChannelAll

	arm_func_start ReleaseTrackChannelAll
ReleaseTrackChannelAll: // 0x03801998
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r7, r2
	mov r2, #0
	bl UpdateTrackChannel
	ldr r6, [r4, #0x3c]
	and r5, r7, #0xff
	mov r4, #1
	b _038019F4
_038019C0:
	mov r0, r6
	bl SND_IsExChannelActive
	cmp r0, #0
	beq _038019F0
	cmp r7, #0
	blt _038019E4
	mov r0, r6
	mov r1, r5
	bl SND_SetExChannelRelease
_038019E4:
	strb r4, [r6, #0x22]
	mov r0, r6
	bl SND_ReleaseExChannel
_038019F0:
	ldr r6, [r6, #0x50]
_038019F4:
	cmp r6, #0
	bne _038019C0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end ReleaseTrackChannelAll

	arm_func_start InitPlayer
InitPlayer: // 0x03801A08
	stmdb sp!, {r4, lr}
	ldrb r2, [r0, #0]
	bic r2, r2, #4
	strb r2, [r0]
	str r1, [r0, #0x20]
	mov r1, #0x78
	strh r1, [r0, #0x18]
	mov r1, #0x100
	strh r1, [r0, #0x1a]
	mov r1, #0xf0
	strh r1, [r0, #0x1c]
	mov r1, #0x7f
	strb r1, [r0, #5]
	mov r3, #0
	strh r3, [r0, #6]
	mov r1, #0x40
	strb r1, [r0, #4]
	mov r2, #0xff
_03801A50:
	add r1, r0, r3
	strb r2, [r1, #8]
	add r3, r3, #1
	cmp r3, #0x10
	blt _03801A50
	ldr r2, _03801AB4 // =SNDi_SharedWork
	ldr r3, [r2, #0]
	cmp r3, #0
	beq _03801AAC
	mov r4, #0
	ldrb ip, [r0, #1]
	mov r1, #0x24
	mla r3, ip, r1, r3
	str r4, [r3, #0x40]
	mvn lr, #0
_03801A8C:
	ldr r3, [r2, #0]
	ldrb ip, [r0, #1]
	mla r3, ip, r1, r3
	add r3, r3, r4, lsl #1
	strh lr, [r3, #0x20]
	add r4, r4, #1
	cmp r4, #0x10
	blt _03801A8C
_03801AAC:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03801AB4: .word SNDi_SharedWork
	arm_func_end InitPlayer

	arm_func_start StartTrack
StartTrack: // 0x03801AB8
	str r1, [r0, #0x24]
	ldr r1, [r0, #0x24]
	add r1, r1, r2
	str r1, [r0, #0x28]
	bx lr
	arm_func_end StartTrack

	arm_func_start InitTrack
InitTrack: // 0x03801ACC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x24]
	str r0, [r4, #0x28]
	ldrb r1, [r4, #0]
	orr r1, r1, #2
	strb r1, [r4]
	ldrb r1, [r4, #0]
	bic r1, r1, #4
	strb r1, [r4]
	ldrb r1, [r4, #0]
	bic r1, r1, #8
	strb r1, [r4]
	ldrb r1, [r4, #0]
	bic r1, r1, #0x10
	strb r1, [r4]
	ldrb r1, [r4, #0]
	bic r1, r1, #0x20
	strb r1, [r4]
	ldrb r1, [r4, #0]
	orr r1, r1, #0x40
	strb r1, [r4]
	ldrb r1, [r4, #0]
	bic r1, r1, #0x80
	strb r1, [r4]
	strb r0, [r4, #0x3b]
	strh r0, [r4, #2]
	mov r1, #0x40
	strb r1, [r4, #0x12]
	mov r2, #0x7f
	strb r2, [r4, #4]
	strb r2, [r4, #5]
	strh r0, [r4, #0xa]
	strb r0, [r4, #8]
	strb r0, [r4, #9]
	strb r0, [r4, #6]
	strh r0, [r4, #0xc]
	mov r1, #0xff
	strb r1, [r4, #0xe]
	strb r1, [r4, #0xf]
	strb r1, [r4, #0x10]
	strb r1, [r4, #0x11]
	strb r2, [r4, #1]
	mov r1, #2
	strb r1, [r4, #7]
	mov r1, #0x3c
	strb r1, [r4, #0x14]
	strb r0, [r4, #0x15]
	strh r0, [r4, #0x16]
	strb r0, [r4, #0x13]
	ldr r0, _03801BBC // =0x0000FFFF
	strh r0, [r4, #0x1e]
	add r0, r4, #0x18
	bl SND_InitLfoParam
	mov r0, #0
	str r0, [r4, #0x20]
	str r0, [r4, #0x3c]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03801BBC: .word 0x0000FFFF
	arm_func_end InitTrack

	arm_func_start ReadArg
ReadArg: // 0x03801BC0
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	mov r6, r1
	cmp r2, #4
	addls pc, pc, r2, lsl #2
	b _03801C7C
_03801BD8: // jump table
	b _03801BEC // case 0
	b _03801C08 // case 1
	b _03801C14 // case 2
	b _03801C4C // case 3
	b _03801C20 // case 4
_03801BEC:
	ldr r0, [r4, #0x28]
	bl GetByteCache
	mov r5, r0
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	b _03801C7C
_03801C08:
	bl Read16
	mov r5, r0
	b _03801C7C
_03801C14:
	bl ReadVar
	mov r5, r0
	b _03801C7C
_03801C20:
	ldr r0, [r4, #0x28]
	bl GetByteCache
	mov r1, r0
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	mov r0, r6
	bl GetVariablePtr
	cmp r0, #0
	ldrnesh r5, [r0, #0]
	b _03801C7C
_03801C4C:
	bl Read16
	mov r5, r0, lsl #0x10
	mov r0, r4
	bl Read16
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	bl SND_CalcRandom
	sub r1, r4, r5, asr #16
	add r1, r1, #1
	mul r1, r0, r1
	mov r0, r1, asr #0x10
	add r5, r0, r5, asr #16
_03801C7C:
	mov r0, r5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end ReadArg

	arm_func_start ReadVar
ReadVar: // 0x03801C88
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, #0
	add r4, r6, #0x28
_03801C98:
	ldr r0, [r6, #0x28]
	bl GetByteCache
	ldr r1, [r4, #0]
	add r1, r1, #1
	str r1, [r4]
	and r1, r0, #0x7f
	orr r5, r1, r5, lsl #7
	ands r0, r0, #0x80
	bne _03801C98
	mov r0, r5
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end ReadVar

	arm_func_start Read24
Read24: // 0x03801CC8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x28]
	bl GetByteCache
	mov r5, r0
	ldr r0, [r4, #0x28]
	add r0, r0, #1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x28]
	bl GetByteCache
	ldr r1, [r4, #0x28]
	add r1, r1, #1
	str r1, [r4, #0x28]
	orr r5, r5, r0, lsl #8
	ldr r0, [r4, #0x28]
	bl GetByteCache
	ldr r1, [r4, #0x28]
	add r1, r1, #1
	str r1, [r4, #0x28]
	orr r0, r5, r0, lsl #16
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end Read24

	arm_func_start Read16
Read16: // 0x03801D28
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, [r5, #0x28]
	bl GetByteCache
	mov r4, r0
	ldr r0, [r5, #0x28]
	add r0, r0, #1
	str r0, [r5, #0x28]
	ldr r0, [r5, #0x28]
	bl GetByteCache
	ldr r1, [r5, #0x28]
	add r1, r1, #1
	str r1, [r5, #0x28]
	orr r0, r4, r0, lsl #8
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end Read16

	arm_func_start GetByteCache
GetByteCache: // 0x03801D78
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, _03801DC0 // =seqCache
	ldr r1, [r0, #0]
	cmp r4, r1
	blo _03801D9C
	ldr r0, [r0, #4]
	cmp r4, r0
	blo _03801DA4
_03801D9C:
	mov r0, r4
	bl InitCache
_03801DA4:
	ldr r0, _03801DC0 // =seqCache
	ldr r0, [r0, #0]
	sub r1, r4, r0
	ldr r0, _03801DC4 // =0x03808BF0
	ldrb r0, [r0, r1]
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03801DC0: .word seqCache
_03801DC4: .word 0x03808BF0
	arm_func_end GetByteCache

	arm_func_start InitCache
InitCache: // 0x03801DC8
	bic r2, r0, #3
	ldr r0, _03801E00 // =seqCache
	str r2, [r0]
	add r1, r2, #0x10
	str r1, [r0, #4]
	ldr r1, [r2, #0]
	str r1, [r0, #8]
	ldr r1, [r2, #4]
	str r1, [r0, #0xc]
	ldr r1, [r2, #8]
	str r1, [r0, #0x10]
	ldr r1, [r2, #0xc]
	str r1, [r0, #0x14]
	bx lr
	.align 2, 0
_03801E00: .word seqCache
	arm_func_end InitCache

	arm_func_start SNDi_SetTrackParam
SNDi_SetTrackParam: // 0x03801E04
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r1
	mov r9, r2
	mov r8, r3
	ldr r7, [sp, #0x28]
	ldr r2, _03801EA4 // =0x03809144
	mov r1, #0x24
	mla r11, r0, r1, r2
	mov r6, #0
	mov r0, r8, lsl #0x10
	mov r4, r0, lsr #0x10
	and r5, r8, #0xff
	b _03801E88
_03801E3C:
	ands r0, r10, #1
	beq _03801E80
	mov r0, r11
	mov r1, r6
	bl GetPlayerTrack
	cmp r0, #0
	beq _03801E80
	cmp r7, #1
	beq _03801E74
	cmp r7, #2
	beq _03801E7C
	cmp r7, #4
	streq r8, [r0, r9]
	b _03801E80
_03801E74:
	strb r5, [r0, r9]
	b _03801E80
_03801E7C:
	strh r4, [r0, r9]
_03801E80:
	add r6, r6, #1
	mov r10, r10, lsr #1
_03801E88:
	cmp r6, #0x10
	bge _03801E98
	cmp r10, #0
	bne _03801E3C
_03801E98:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_03801EA4: .word 0x03809144
	arm_func_end SNDi_SetTrackParam

	arm_func_start SNDi_SetPlayerParam
SNDi_SetPlayerParam: // 0x03801EA8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr lr, _03801EF0 // =0x03809144
	mov ip, #0x24
	mla ip, r0, ip, lr
	cmp r3, #1
	beq _03801ED8
	cmp r3, #2
	beq _03801EE0
	cmp r3, #4
	streq r2, [ip, r1]
	b _03801EE4
_03801ED8:
	strb r2, [ip, r1]
	b _03801EE4
_03801EE0:
	strh r2, [ip, r1]
_03801EE4:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03801EF0: .word 0x03809144
	arm_func_end SNDi_SetPlayerParam

	arm_func_start SND_InvalidateBank
SND_InvalidateBank: // 0x03801EF4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r0
	mov r6, r1
	mov r5, #0
	ldr r4, _03801F50 // =0x03809144
	mov r8, #0x24
_03801F0C:
	mul r1, r5, r8
	add r0, r4, r1
	ldrb r1, [r4, r1]
	mov r1, r1, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _03801F3C
	ldr r1, [r0, #0x20]
	cmp r7, r1
	bhi _03801F3C
	cmp r1, r6
	bhi _03801F3C
	bl FinishPlayer
_03801F3C:
	add r5, r5, #1
	cmp r5, #0x10
	blt _03801F0C
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_03801F50: .word 0x03809144
	arm_func_end SND_InvalidateBank

	arm_func_start SND_InvalidateSeq
SND_InvalidateSeq: // 0x03801F54
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	mov r7, #0
	mov r5, r7
	ldr r11, _03801FEC // =0x03809144
	mov r4, #0x24
_03801F74:
	mul r0, r7, r4
	add r8, r11, r0
	ldrb r0, [r11, r0]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _03801FD4
	mov r6, r5
	b _03801FCC
_03801F94:
	mov r0, r8
	mov r1, r6
	bl GetPlayerTrack
	cmp r0, #0
	beq _03801FC8
	ldr r0, [r0, #0x28]
	cmp r10, r0
	bhi _03801FC8
	cmp r0, r9
	bhi _03801FC8
	mov r0, r8
	bl FinishPlayer
	b _03801FD4
_03801FC8:
	add r6, r6, #1
_03801FCC:
	cmp r6, #0x10
	blt _03801F94
_03801FD4:
	add r7, r7, #1
	cmp r7, #0x10
	blt _03801F74
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
	.align 2, 0
_03801FEC: .word 0x03809144
	arm_func_end SND_InvalidateSeq

	arm_func_start SND_SetTrackAllocatableChannel
SND_SetTrackAllocatableChannel: // 0x03801FF0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r1
	ldr r3, _03802064 // =0x03809144
	mov r1, #0x24
	mla r5, r0, r1, r3
	mov r4, #0
	mov r0, r2, lsl #0x10
	mov r7, r0, lsr #0x10
	b _03802048
_03802018:
	ands r0, r6, #1
	beq _03802040
	mov r0, r5
	mov r1, r4
	bl GetPlayerTrack
	cmp r0, #0
	strneh r7, [r0, #0x1e]
	ldrneb r1, [r0, #0]
	orrne r1, r1, #0x80
	strneb r1, [r0]
_03802040:
	add r4, r4, #1
	mov r6, r6, lsr #1
_03802048:
	cmp r4, #0x10
	bge _03802058
	cmp r6, #0
	bne _03802018
_03802058:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_03802064: .word 0x03809144
	arm_func_end SND_SetTrackAllocatableChannel

	arm_func_start SND_SetTrackMute
SND_SetTrackMute: // 0x03802068
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r1
	mov r6, r2
	ldr r2, _038020D8 // =0x03809144
	mov r1, #0x24
	mla r5, r0, r1, r2
	mov r4, #0
	b _038020BC
_0380208C:
	ands r0, r7, #1
	beq _038020B4
	mov r0, r5
	mov r1, r4
	bl GetPlayerTrack
	cmp r0, #0
	beq _038020B4
	mov r1, r5
	mov r2, r6
	bl SetTrackMute
_038020B4:
	add r4, r4, #1
	mov r7, r7, lsr #1
_038020BC:
	cmp r4, #0x10
	bge _038020CC
	cmp r7, #0
	bne _0380208C
_038020CC:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_038020D8: .word 0x03809144
	arm_func_end SND_SetTrackMute

	arm_func_start SND_SkipSeq
SND_SkipSeq: // 0x038020DC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r1
	ldr r2, _038021A0 // =0x03809144
	mov r1, #0x24
	mla r5, r0, r1, r2
	mov r8, #0
	mov r4, #0x7f
_038020F8:
	mov r0, r5
	mov r1, r8
	bl GetPlayerTrack
	movs r7, r0
	beq _03802120
	mov r1, r5
	mov r2, r4
	bl ReleaseTrackChannelAll
	mov r0, r7
	bl FreeTrackChannelAll
_03802120:
	add r8, r8, #1
	cmp r8, #0x10
	blt _038020F8
	bl SND_StopIntervalTimer
	mov r4, #0
	mov r7, r4
	b _03802160
_0380213C:
	mov r0, r5
	mov r1, r7
	bl PlayerSeqMain
	cmp r0, #0
	beq _0380215C
	mov r0, r5
	bl FinishPlayer
	b _03802168
_0380215C:
	add r4, r4, #1
_03802160:
	cmp r4, r6
	blo _0380213C
_03802168:
	bl SND_StartIntervalTimer
	ldr r0, _038021A4 // =SNDi_SharedWork
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _03802198
	add r3, r0, #0x40
	ldrb r1, [r5, #1]
	mov r0, #0x24
	mul r2, r1, r0
	ldr r0, [r3, r2]
	add r0, r0, r4
	str r0, [r3, r2]
_03802198:
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_038021A0: .word 0x03809144
_038021A4: .word SNDi_SharedWork
	arm_func_end SND_SkipSeq

	arm_func_start SND_PauseSeq
SND_PauseSeq: // 0x038021A8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r5, _03802228 // =0x03809144
	mov r2, #0x24
	mul r3, r0, r2
	add r4, r5, r3
	ldrb r0, [r5, r3]
	bic r2, r0, #4
	and r0, r1, #0xff
	and r0, r0, #1
	orr r0, r2, r0, lsl #2
	strb r0, [r5, r3]
	cmp r1, #0
	beq _0380221C
	mov r7, #0
	mov r5, #0x7f
_038021E8:
	mov r0, r4
	mov r1, r7
	bl GetPlayerTrack
	movs r6, r0
	beq _03802210
	mov r1, r4
	mov r2, r5
	bl ReleaseTrackChannelAll
	mov r0, r6
	bl FreeTrackChannelAll
_03802210:
	add r7, r7, #1
	cmp r7, #0x10
	blt _038021E8
_0380221C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_03802228: .word 0x03809144
	arm_func_end SND_PauseSeq

	arm_func_start SND_StopSeq
SND_StopSeq: // 0x0380222C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, _03802280 // =0x03809144
	mov r0, #0x24
	mul r1, r4, r0
	add r0, r2, r1
	ldrb r1, [r2, r1]
	mov r1, r1, lsl #0x1f
	movs r1, r1, lsr #0x1f
	beq _03802278
	bl FinishPlayer
	ldr r0, _03802284 // =SNDi_SharedWork
	ldr r2, [r0, #0]
	cmp r2, #0
	ldrne r1, [r2, #4]
	movne r0, #1
	mvnne r0, r0, lsl r4
	andne r0, r1, r0
	strne r0, [r2, #4]
_03802278:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_03802280: .word 0x03809144
_03802284: .word SNDi_SharedWork
	arm_func_end SND_StopSeq

	arm_func_start SND_StartSeq
SND_StartSeq: // 0x03802288
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SND_PrepareSeq
	mov r0, r4
	bl SND_StartPreparedSeq
	ldmia sp!, {r4, lr}
	bx lr
	arm_func_end SND_StartSeq

	arm_func_start SND_StartPreparedSeq
SND_StartPreparedSeq: // 0x038022A4
	ldr r2, _038022C0 // =0x03809144
	mov r1, #0x24
	mul r1, r0, r1
	ldrb r0, [r2, r1]
	orr r0, r0, #2
	strb r0, [r2, r1]
	bx lr
	.align 2, 0
_038022C0: .word 0x03809144
	arm_func_end SND_StartPreparedSeq

	arm_func_start SND_PrepareSeq
SND_PrepareSeq: // 0x038022C4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r8, r1
	mov r6, r2
	mov r5, r3
	ldr r1, _0380240C // =0x03809144
	mov r0, #0x24
	mul r0, r4, r0
	add r7, r1, r0
	ldrb r0, [r1, r0]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _03802304
	mov r0, r7
	bl FinishPlayer
_03802304:
	mov r0, r7
	mov r1, r5
	bl InitPlayer
	bl AllocTrack
	movs r9, r0
	bmi _03802400
	ldr r0, _03802410 // =0x03809384
	add r5, r0, r9, lsl #6
	mov r0, r5
	bl InitTrack
	mov r0, r5
	mov r1, r8
	mov r2, r6
	bl StartTrack
	strb r9, [r7, #8]
	ldr r0, [r5, #0x28]
	bl InitCache
	ldr r0, [r5, #0x28]
	bl GetByteCache
	add r2, r5, #0x28
	ldr r1, [r5, #0x28]
	add r1, r1, #1
	str r1, [r5, #0x28]
	cmp r0, #0xfe
	ldrne r0, [r2, #0]
	subne r0, r0, #1
	strne r0, [r2]
	bne _038023C8
	mov r0, r5
	bl Read16
	mov r0, r0, lsl #0xf
	mov r5, r0, lsr #0x10
	mov r6, #1
	ldr r8, _03802410 // =0x03809384
	b _038023C0
_03802390:
	ands r0, r5, #1
	beq _038023B4
	bl AllocTrack
	movs r9, r0
	bmi _038023C8
	add r0, r8, r9, lsl #6
	bl InitTrack
	add r0, r7, r6
	strb r9, [r0, #8]
_038023B4:
	add r6, r6, #1
	mov r0, r5, lsl #0xf
	mov r5, r0, lsr #0x10
_038023C0:
	cmp r5, #0
	bne _03802390
_038023C8:
	ldrb r0, [r7, #0]
	bic r0, r0, #1
	orr r0, r0, #1
	strb r0, [r7]
	ldrb r0, [r7, #0]
	bic r0, r0, #2
	strb r0, [r7]
	ldr r0, _03802414 // =SNDi_SharedWork
	ldr r2, [r0, #0]
	cmp r2, #0
	ldrne r1, [r2, #4]
	movne r0, #1
	orrne r0, r1, r0, lsl r4
	strne r0, [r2, #4]
_03802400:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_0380240C: .word 0x03809144
_03802410: .word 0x03809384
_03802414: .word SNDi_SharedWork
	arm_func_end SND_PrepareSeq

	arm_func_start SND_SeqMain
SND_SeqMain: // 0x03802418
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r8, r0
	mov r5, #0
	mov r6, r5
	mov r10, #1
	ldr r4, _038024B0 // =0x03809144
	mov r9, #0x24
_03802434:
	mul r0, r6, r9
	add r7, r4, r0
	ldrb r1, [r4, r0]
	mov r0, r1, lsl #0x1f
	movs r0, r0, lsr #0x1f
	beq _0380248C
	mov r0, r1, lsl #0x1e
	movs r0, r0, lsr #0x1f
	beq _0380247C
	cmp r8, #0
	beq _03802474
	mov r0, r1, lsl #0x1d
	movs r0, r0, lsr #0x1f
	bne _03802474
	mov r0, r7
	bl PlayerTempoMain
_03802474:
	mov r0, r7
	bl UpdatePlayerChannel
_0380247C:
	ldrb r0, [r7, #0]
	mov r0, r0, lsl #0x1f
	movs r0, r0, lsr #0x1f
	orrne r5, r5, r10, lsl r6
_0380248C:
	add r6, r6, #1
	cmp r6, #0x10
	blt _03802434
	ldr r0, _038024B4 // =SNDi_SharedWork
	ldr r0, [r0, #0]
	cmp r0, #0
	strne r5, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bx lr
	.align 2, 0
_038024B0: .word 0x03809144
_038024B4: .word SNDi_SharedWork
	arm_func_end SND_SeqMain

	arm_func_start SND_SeqInit
SND_SeqInit: // 0x038024B8
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov lr, #0
	ldr r3, _0380251C // =0x03809144
	mov r0, #0x24
_038024CC:
	mul r2, lr, r0
	add ip, r3, r2
	ldrb r1, [r3, r2]
	bic r1, r1, #1
	strb r1, [r3, r2]
	strb lr, [ip, #1]
	add lr, lr, #1
	cmp lr, #0x10
	blt _038024CC
	mov r2, #0
	ldr r1, _03802520 // =0x03809384
_038024F8:
	ldrb r0, [r1, r2, lsl #6]
	bic r0, r0, #1
	strb r0, [r1, r2, lsl #6]
	add r2, r2, #1
	cmp r2, #0x20
	blt _038024F8
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_0380251C: .word 0x03809144
_03802520: .word 0x03809384
	arm_func_end SND_SeqInit

	arm_func_start GetWaveData
GetWaveData: // 0x03802524
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r0, r0, r1, lsl #3
	ldr r0, [r0, #0x18]
	cmp r0, #0
	moveq r0, #0
	beq _03802558
	ldr r1, [r0, #0x38]
	cmp r2, r1
	movhs r0, #0
	bhs _03802558
	mov r1, r2
	bl SND_GetWaveDataAddress
_03802558:
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	arm_func_end GetWaveData

	arm_func_start SND_NoteOn
SND_NoteOn: // 0x03802564
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r8, r1
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x24]
	ldrb r4, [r5, #0xa]
	cmp r4, #0xff
	mvneq r6, #0
	moveq r4, #0
	ldrb r0, [r5, #0]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _03802620
_038025A0: // jump table
	b _03802620 // case 0
	b _038025B4 // case 1
	b _038025FC // case 2
	b _03802610 // case 3
	b _038025B4 // case 4
_038025B4:
	cmp r0, #1
	ldrneh r1, [r5, #4]
	ldrneh r0, [r5, #2]
	orrne r1, r0, r1, lsl #16
	bne _038025DC
	ldr r0, [sp, #0x20]
	ldrh r1, [r5, #4]
	ldrh r2, [r5, #2]
	bl GetWaveData
	mov r1, r0
_038025DC:
	cmp r1, #0
	moveq r0, #0
	beq _03802624
	mov r0, r9
	add r2, r1, #0xc
	mov r3, r6
	bl SND_StartExChannelPcm
	b _03802624
_038025FC:
	mov r0, r9
	ldrh r1, [r5, #2]
	mov r2, r6
	bl SND_StartExChannelPsg
	b _03802624
_03802610:
	mov r0, r9
	mov r1, r6
	bl SND_StartExChannelNoise
	b _03802624
_03802620:
	mov r0, #0
_03802624:
	cmp r0, #0
	moveq r0, #0
	beq _03802680
	strb r8, [r9, #8]
	ldrb r0, [r5, #6]
	strb r0, [r9, #5]
	strb r7, [r9, #9]
	mov r0, r9
	ldrb r1, [r5, #7]
	bl SND_SetExChannelAttack
	mov r0, r9
	ldrb r1, [r5, #8]
	bl SND_SetExChannelDecay
	mov r0, r9
	ldrb r1, [r5, #9]
	bl SND_SetExChannelSustain
	mov r0, r9
	mov r1, r4
	bl SND_SetExChannelRelease
	ldrb r0, [r5, #0xb]
	sub r0, r0, #0x40
	strb r0, [r9, #0xa]
	mov r0, #1
_03802680:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	arm_func_end SND_NoteOn

	arm_func_start SND_GetWaveDataAddress
SND_GetWaveDataAddress: // 0x0380268C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl SNDi_LockMutex
	add r0, r5, r4, lsl #2
	ldr r4, [r0, #0x3c]
	cmp r4, #0
	beq _038026BC
	cmp r4, #0x2000000
	addlo r4, r5, r4
	b _038026C0
_038026BC:
	mov r4, #0
_038026C0:
	bl SNDi_UnlockMutex
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	arm_func_end SND_GetWaveDataAddress

	arm_func_start SND_ReadInstData
SND_ReadInstData: // 0x038026D4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	movs r7, r1
	mov r5, r2
	mov r4, r3
	movmi r0, #0
	bmi _0380284C
	bl SNDi_LockMutex
	ldr r0, [r6, #0x38]
	cmp r7, r0
	blo _03802710
	bl SNDi_UnlockMutex
	mov r0, #0
	b _0380284C
_03802710:
	add r0, r6, r7, lsl #2
	ldr r3, [r0, #0x3c]
	strb r3, [r4]
	ldrb r0, [r4, #0]
	cmp r0, #0x11
	addls pc, pc, r0, lsl #2
	b _03802838
_0380272C: // jump table
	b _03802838 // case 0
	b _03802774 // case 1
	b _03802774 // case 2
	b _03802774 // case 3
	b _03802774 // case 4
	b _03802774 // case 5
	b _03802838 // case 6
	b _03802838 // case 7
	b _03802838 // case 8
	b _03802838 // case 9
	b _03802838 // case 10
	b _03802838 // case 11
	b _03802838 // case 12
	b _03802838 // case 13
	b _03802838 // case 14
	b _03802838 // case 15
	b _03802794 // case 16
	b _038027E4 // case 17
_03802774:
	add r3, r6, r3, lsr #8
	add r2, r4, #2
	mov r1, #5
_03802780:
	ldrh r0, [r3], #2
	strh r0, [r2], #2
	subs r1, r1, #1
	bne _03802780
	b _03802844
_03802794:
	add r2, r6, r3, lsr #8
	ldrb r1, [r2, #1]
	ldrb r0, [r6, r3, lsr #8]
	cmp r5, r0
	blt _038027B0
	cmp r5, r1
	ble _038027BC
_038027B0:
	bl SNDi_UnlockMutex
	mov r0, #0
	b _0380284C
_038027BC:
	sub r1, r5, r0
	mov r0, #0xc
	mla r0, r1, r0, r2
	add r2, r0, #2
	mov r1, #6
_038027D0:
	ldrh r0, [r2], #2
	strh r0, [r4], #2
	subs r1, r1, #1
	bne _038027D0
	b _03802844
_038027E4:
	mov r2, #0
	add r1, r6, r3, lsr #8
	b _03802808
_038027F0:
	add r2, r2, #1
	cmp r2, #8
	blt _03802808
	bl SNDi_UnlockMutex
	mov r0, #0
	b _0380284C
_03802808:
	ldrb r0, [r1, r2]
	cmp r5, r0
	bgt _038027F0
	mov r0, #0xc
	mla r0, r2, r0, r1
	add r2, r0, #8
	mov r1, #6
_03802824:
	ldrh r0, [r2], #2
	strh r0, [r4], #2
	subs r1, r1, #1
	bne _03802824
	b _03802844
_03802838:
	bl SNDi_UnlockMutex
	mov r0, #0
	b _0380284C
_03802844:
	bl SNDi_UnlockMutex
	mov r0, #1
_0380284C:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end SND_ReadInstData

	arm_func_start SND_UpdateSharedWork
SND_UpdateSharedWork: // 0x03802858
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, #0
	mov r4, r5
	ldr r0, _038028F4 // =SNDi_SharedWork
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _038028E8
	mov r7, r5
	mov r6, #1
_03802880:
	mov r0, r7
	bl SND_IsChannelActive
	cmp r0, #0
	orrne r0, r5, r6, lsl r7
	movne r0, r0, lsl #0x10
	movne r5, r0, lsr #0x10
	add r7, r7, #1
	cmp r7, #0x10
	blt _03802880
	mov r0, #0
	bl SND_IsCaptureActive
	cmp r0, #0
	orrne r0, r4, #1
	movne r0, r0, lsl #0x10
	movne r4, r0, lsr #0x10
	mov r0, #1
	bl SND_IsCaptureActive
	cmp r0, #0
	orrne r0, r4, #2
	movne r0, r0, lsl #0x10
	movne r4, r0, lsr #0x10
	ldr r0, _038028F4 // =SNDi_SharedWork
	ldr r1, [r0, #0]
	strh r5, [r1, #8]
	ldr r0, [r0, #0]
	strh r4, [r0, #0xa]
_038028E8:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_038028F4: .word SNDi_SharedWork
	arm_func_end SND_UpdateSharedWork

	arm_func_start SND_SetPlayerGlobalVariable
SND_SetPlayerGlobalVariable: // 0x038028F8
	ldr r2, _03802910 // =SNDi_SharedWork
	ldr r2, [r2, #0]
	add r0, r2, r0, lsl #1
	add r0, r0, #0x200
	strh r1, [r0, #0x60]
	bx lr
	.align 2, 0
_03802910: .word SNDi_SharedWork
	arm_func_end SND_SetPlayerGlobalVariable

	arm_func_start SND_SetPlayerLocalVariable
SND_SetPlayerLocalVariable: // 0x03802914
	ldr r3, _03802930 // =SNDi_SharedWork
	ldr ip, [r3]
	mov r3, #0x24
	mla r3, r0, r3, ip
	add r0, r3, r1, lsl #1
	strh r2, [r0, #0x20]
	bx lr
	.align 2, 0
_03802930: .word SNDi_SharedWork
	arm_func_end SND_SetPlayerLocalVariable

	arm_func_start AlarmHandler
AlarmHandler: // 0x03802934
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, #7
	mov r4, #0
_03802944:
	mov r0, r5
	mov r1, r6
	mov r2, r4
	bl PXI_SendWordByFifo
	cmp r0, #0
	blt _03802944
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end AlarmHandler

	arm_func_start SND_StopAlarm
SND_StopAlarm: // 0x03802964
	stmdb sp!, {r4, lr}
	ldr r1, _038029A0 // =0x03809B84
	add r4, r1, r0, lsl #6
	ldrb r0, [r1, r0, lsl #6]
	cmp r0, #0
	beq _03802998
	add r0, r4, #0x14
	bl OS_CancelAlarm
	ldrb r0, [r4, #1]
	add r0, r0, #1
	strb r0, [r4, #1]
	mov r0, #0
	strb r0, [r4]
_03802998:
	ldmia sp!, {r4, lr}
	bx lr
	.align 2, 0
_038029A0: .word 0x03809B84
	arm_func_end SND_StopAlarm

	arm_func_start SND_StartAlarm
SND_StartAlarm: // 0x038029A4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldr r0, _03802A64 // =0x03809B84
	add r5, r0, r4, lsl #6
	ldrb r0, [r0, r4, lsl #6]
	cmp r0, #0
	beq _038029D4
	add r0, r5, #0x14
	bl OS_CancelAlarm
	mov r0, #0
	strb r0, [r5]
_038029D4:
	ldr r9, [r5, #4]
	ldr r8, [r5, #8]
	ldr r7, [r5, #0xc]
	ldr r6, [r5, #0x10]
	ldrb r0, [r5, #1]
	orr r4, r4, r0, lsl #8
	add r0, r5, #0x14
	bl OS_CreateAlarm
	mov r0, #0
	cmp r6, r0
	cmpeq r7, r0
	bne _03802A20
	str r4, [sp]
	add r0, r5, #0x14
	mov r1, r9
	mov r2, r8
	ldr r3, _03802A68 // =AlarmHandler
	bl OS_SetAlarm
	b _03802A50
_03802A20:
	bl OS_GetTick
	mov r2, r0
	ldr r0, _03802A68 // =AlarmHandler
	str r0, [sp, #4]
	str r4, [sp, #8]
	mov r3, r7
	str r6, [sp]
	add r0, r5, #0x14
	adds r4, r9, r2
	adc r2, r8, r1
	mov r1, r4
	bl OS_SetPeriodicAlarm
_03802A50:
	mov r0, #1
	strb r0, [r5]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_03802A64: .word 0x03809B84
_03802A68: .word AlarmHandler
	arm_func_end SND_StartAlarm

	arm_func_start SND_SetupAlarm
SND_SetupAlarm: // 0x03802A6C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r1
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x18]
	ldr r1, _03802AC4 // =0x03809B84
	add r4, r1, r0, lsl #6
	ldrb r0, [r1, r0, lsl #6]
	cmp r0, #0
	beq _03802AA4
	add r0, r4, #0x14
	bl OS_CancelAlarm
	mov r0, #0
	strb r0, [r4]
_03802AA4:
	str r8, [r4, #4]
	str r7, [r4, #8]
	str r6, [r4, #0xc]
	str r5, [r4, #0x10]
	ldr r0, [sp, #0x1c]
	strb r0, [r4, #1]
	ldmia sp!, {r4, r5, r6, r7, r8, lr}
	bx lr
	.align 2, 0
_03802AC4: .word 0x03809B84
	arm_func_end SND_SetupAlarm

	arm_func_start SND_AlarmInit
SND_AlarmInit: // 0x03802AC8
	mov r3, #0
	mov r2, r3
	ldr r1, _03802AF0 // =SNDi_Work
_03802AD4:
	add r0, r1, r3, lsl #6
	strb r2, [r0, #0xf80]
	strb r2, [r0, #0xf81]
	add r3, r3, #1
	cmp r3, #8
	blt _03802AD4
	bx lr
	.align 2, 0
_03802AF0: .word SNDi_Work
	arm_func_end SND_AlarmInit

	arm_func_start SND_ReadDriverInfo
SND_ReadDriverInfo: // 0x03802AF4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _03802B5C // =SNDi_Work
	mov r1, r5
	mov r2, #0x1180
	bl MIi_CpuCopy32
	ldr r1, _03802B5C // =SNDi_Work
	add r0, r5, #0x1000
	str r1, [r0, #0x1c0]
	mov r4, #0
_03802B20:
	mov r0, r4
	bl SND_GetChannelControl
	add r1, r5, r4, lsl #2
	add r1, r1, #0x1000
	str r0, [r1, #0x180]
	add r4, r4, #1
	cmp r4, #0x10
	blt _03802B20
	mov r0, #0
	bl SND_GetLockedChannel
	add r1, r5, #0x1000
	str r0, [r1, #0x1c4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_03802B5C: .word SNDi_Work
	arm_func_end SND_ReadDriverInfo

	arm_func_start SND_StopTimer
SND_StopTimer: // 0x03802B60
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r9, r2
	mov r5, r3
	bl OS_DisableInterrupts
	mov r4, r0
	mov r8, #0
	b _03802BA0
_03802B88:
	ands r0, r9, #1
	beq _03802B98
	mov r0, r8
	bl SND_StopAlarm
_03802B98:
	add r8, r8, #1
	mov r9, r9, lsr #1
_03802BA0:
	cmp r8, #8
	bge _03802BB0
	cmp r9, #0
	bne _03802B88
_03802BB0:
	mov r8, #0
	b _03802BD4
_03802BB8:
	ands r0, r7, #1
	beq _03802BCC
	mov r0, r8
	mov r1, r5
	bl SND_StopChannel
_03802BCC:
	add r8, r8, #1
	mov r7, r7, lsr #1
_03802BD4:
	cmp r8, #0x10
	bge _03802BE4
	cmp r7, #0
	bne _03802BB8
_03802BE4:
	ands r0, r6, #1
	movne r1, #0
	ldrne r0, _03802C1C // =0x04000508
	strneb r1, [r0]
	ands r0, r6, #2
	movne r1, #0
	ldrne r0, _03802C20 // =0x04000509
	strneb r1, [r0]
	mov r0, r4
	bl OS_RestoreInterrupts
	bl SND_UpdateSharedWork
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_03802C1C: .word 0x04000508
_03802C20: .word 0x04000509
	arm_func_end SND_StopTimer

	arm_func_start SND_StartTimer
SND_StartTimer: // 0x03802C24
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl OS_DisableInterrupts
	mov r4, r0
	mov r2, #0
	b _03802C68
_03802C48:
	ands r0, r7, #1
	movne r0, r2, lsl #4
	addne r0, r0, #0x4000000
	ldrneb r1, [r0, #0x403]
	orrne r1, r1, #0x80
	strneb r1, [r0, #0x403]
	add r2, r2, #1
	mov r7, r7, lsr #1
_03802C68:
	cmp r2, #0x10
	bge _03802C78
	cmp r7, #0
	bne _03802C48
_03802C78:
	ands r0, r6, #1
	beq _03802CB0
	ands r0, r6, #2
	ldreq r1, _03802D0C // =0x04000508
	ldreqb r0, [r1, #0]
	orreq r0, r0, #0x80
	streqb r0, [r1]
	beq _03802CC4
	ldr r2, _03802D0C // =0x04000508
	ldrh r1, [r2, #0]
	ldr r0, _03802D10 // =0x00008080
	orr r0, r1, r0
	strh r0, [r2]
	b _03802CC4
_03802CB0:
	ands r0, r6, #2
	ldrne r1, _03802D14 // =0x04000509
	ldrneb r0, [r1, #0]
	orrne r0, r0, #0x80
	strneb r0, [r1]
_03802CC4:
	mov r6, #0
	b _03802CE4
_03802CCC:
	ands r0, r5, #1
	beq _03802CDC
	mov r0, r6
	bl SND_StartAlarm
_03802CDC:
	add r6, r6, #1
	mov r5, r5, lsr #1
_03802CE4:
	cmp r6, #8
	bge _03802CF4
	cmp r5, #0
	bne _03802CCC
_03802CF4:
	mov r0, r4
	bl OS_RestoreInterrupts
	bl SND_UpdateSharedWork
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	.align 2, 0
_03802D0C: .word 0x04000508
_03802D10: .word 0x00008080
_03802D14: .word 0x04000509
	arm_func_end SND_StartTimer

	arm_func_start SNDi_SetChannelPan
SNDi_SetChannelPan: // 0x03802D18
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, #0
	b _03802D48
_03802D2C:
	ands r0, r6, #1
	beq _03802D40
	mov r0, r4
	mov r1, r5
	bl SND_SetChannelPan
_03802D40:
	add r4, r4, #1
	mov r6, r6, lsr #1
_03802D48:
	cmp r4, #0x10
	bge _03802D58
	cmp r6, #0
	bne _03802D2C
_03802D58:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end SNDi_SetChannelPan

	arm_func_start SNDi_SetChannelVolume
SNDi_SetChannelVolume: // 0x03802D60
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, #0
	b _03802D9C
_03802D7C:
	ands r0, r7, #1
	beq _03802D94
	mov r0, r4
	mov r1, r6
	mov r2, r5
	bl SND_SetChannelVolume
_03802D94:
	add r4, r4, #1
	mov r7, r7, lsr #1
_03802D9C:
	cmp r4, #0x10
	bge _03802DAC
	cmp r7, #0
	bne _03802D7C
_03802DAC:
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
	arm_func_end SNDi_SetChannelVolume

	arm_func_start SNDi_SetChannelTimer
SNDi_SetChannelTimer: // 0x03802DB8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, #0
	b _03802DE8
_03802DCC:
	ands r0, r6, #1
	beq _03802DE0
	mov r0, r4
	mov r1, r5
	bl SND_SetChannelTimer
_03802DE0:
	add r4, r4, #1
	mov r6, r6, lsr #1
_03802DE8:
	cmp r4, #0x10
	bge _03802DF8
	cmp r6, #0
	bne _03802DCC
_03802DF8:
	ldmia sp!, {r4, r5, r6, lr}
	bx lr
	arm_func_end SNDi_SetChannelTimer

	arm_func_start SND_InitPXI
SND_InitPXI: // 0x03802E00
	mov r0, #7
	ldr r1, _03802E10 // =SND_PxiFifoCallback
	ldr ip, _03802E14 // =PXI_SetFifoRecvCallback
	bx ip
	.align 2, 0
_03802E10: .word SND_PxiFifoCallback
_03802E14: .word PXI_SetFifoRecvCallback
	arm_func_end SND_InitPXI

	arm_func_start SND_PxiFifoCallback
SND_PxiFifoCallback: // 0x03802E18
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r1
	bl OS_DisableInterrupts
	mov r4, r0
	cmp r5, #0x2000000
	blo _03802E48
	ldr r0, _03802E68 // =sCommandMesgQueue
	mov r1, r5
	mov r2, #0
	bl OS_SendMessage
	b _03802E54
_03802E48:
	cmp r5, #0
	bne _03802E54
	bl SND_SendWakeupMessage
_03802E54:
	mov r0, r4
	bl OS_RestoreInterrupts
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	bx lr
	.align 2, 0
_03802E68: .word sCommandMesgQueue
	arm_func_end SND_PxiFifoCallback

	arm_func_start SND_CommandProc
SND_CommandProc: // 0x03802E6C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x34
	ldr r7, _038032D4 // =SNDi_SharedWork
	ldr r9, _038032D8 // =sCommandMesgQueue
	add r8, sp, #0x18
	mov r4, #0
	ldr r6, _038032DC // =0x0000FFFF
	ldr r5, _038032E0 // =0x003FFFFF
	b _038032B0
_03802E90:
	ldr lr, [sp, #0x18]
	b _03803298
_03802E98:
	add ip, sp, #0x1c
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr, {r0, r1}
	stmia ip, {r0, r1}
	ldr r0, [sp, #0x20]
	cmp r0, #0x21
	addls pc, pc, r0, lsl #2
	b _03803294
_03802EBC: // jump table
	b _03802F44 // case 0
	b _03802F5C // case 1
	b _03802F68 // case 2
	b _03802F80 // case 3
	b _03802F8C // case 4
	b _03802F9C // case 5
	b _03802FAC // case 6
	b _03802FC4 // case 7
	b _03802FEC // case 8
	b _03803000 // case 9
	b _03803014 // case 10
	b _03803030 // case 11
	b _03803048 // case 12
	b _03803060 // case 13
	b _03803118 // case 14
	b _03803184 // case 15
	b _038031B8 // case 16
	b _03803078 // case 17
	b _038030C0 // case 18
	b _038030E4 // case 19
	b _038030F4 // case 20
	b _03803108 // case 21
	b _038031E4 // case 22
	b _038031F0 // case 23
	b _038031FC // case 24
	b _03803208 // case 25
	b _03803220 // case 26
	b _03803230 // case 27
	b _03803240 // case 28
	b _03803280 // case 29
	b _03803250 // case 30
	b _03803260 // case 31
	b _03803270 // case 32
	b _0380328C // case 33
_03802F44:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x30]
	bl SND_StartSeq
	b _03803294
_03802F5C:
	ldr r0, [sp, #0x24]
	bl SND_StopSeq
	b _03803294
_03802F68:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x30]
	bl SND_PrepareSeq
	b _03803294
_03802F80:
	ldr r0, [sp, #0x24]
	bl SND_StartPreparedSeq
	b _03803294
_03802F8C:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	bl SND_PauseSeq
	b _03803294
_03802F9C:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	bl SND_SkipSeq
	b _03803294
_03802FAC:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x30]
	bl SNDi_SetPlayerParam
	b _03803294
_03802FC4:
	ldr r1, [sp, #0x24]
	mov r0, r1, lsr #0x18
	and r0, r0, #0xff
	str r0, [sp]
	bic r0, r1, #0xff000000
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x30]
	bl SNDi_SetTrackParam
	b _03803294
_03802FEC:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	bl SND_SetTrackMute
	b _03803294
_03803000:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	bl SND_SetTrackAllocatableChannel
	b _03803294
_03803014:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	mov r2, r2, lsl #0x10
	mov r2, r2, asr #0x10
	bl SND_SetPlayerLocalVariable
	b _03803294
_03803030:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	mov r1, r1, lsl #0x10
	mov r1, r1, asr #0x10
	bl SND_SetPlayerGlobalVariable
	b _03803294
_03803048:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x30]
	bl SND_StartTimer
	b _03803294
_03803060:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x30]
	bl SND_StopTimer
	b _03803294
_03803078:
	ldr r1, [sp, #0x2c]
	mov r0, r1, lsr #0x1d
	and r0, r0, #1
	str r0, [sp]
	mov r0, r1, lsr #0x1c
	and r0, r0, #1
	str r0, [sp, #4]
	mov r0, r1, lsr #0x1b
	and r0, r0, #1
	str r0, [sp, #8]
	mov r0, r1, lsr #0x1f
	and r0, r0, #1
	mov r1, r1, lsr #0x1e
	and r1, r1, #1
	ldr r2, [sp, #0x24]
	ldr r3, [sp, #0x28]
	bl SND_SetupCapture
	b _03803294
_038030C0:
	ldr r0, [sp, #0x30]
	str r0, [sp, #4]
	ldr r3, [sp, #0x2c]
	str r4, [sp]
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	mov r2, #0
	bl SND_SetupAlarm
	b _03803294
_038030E4:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	bl SNDi_SetChannelTimer
	b _03803294
_038030F4:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	bl SNDi_SetChannelVolume
	b _03803294
_03803108:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	bl SNDi_SetChannelPan
	b _03803294
_03803118:
	ldr r3, [sp, #0x30]
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x2c]
	and r2, r3, r6
	str r2, [sp]
	and r2, r0, r5
	str r2, [sp, #4]
	mov r2, r0, lsr #0x18
	and r2, r2, #0x7f
	str r2, [sp, #8]
	mov r0, r0, lsr #0x16
	and r0, r0, #3
	str r0, [sp, #0xc]
	and r0, r6, r1, lsr #16
	str r0, [sp, #0x10]
	mov r0, r3, lsr #0x10
	and r0, r0, #0x7f
	str r0, [sp, #0x14]
	and r0, r1, r6
	ldr r1, [sp, #0x28]
	bic r1, r1, #0xf8000000
	mov r2, r3, lsr #0x18
	and r2, r2, #3
	mov r3, r3, lsr #0x1a
	and r3, r3, #3
	bl SND_SetupChannelPcm
	b _03803294
_03803184:
	ldr r1, [sp, #0x2c]
	ldr r3, [sp, #0x28]
	and r0, r6, r1, lsr #8
	str r0, [sp]
	and r0, r1, #0x7f
	str r0, [sp, #4]
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x30]
	and r2, r3, #0x7f
	mov r3, r3, lsr #8
	and r3, r3, #3
	bl SND_SetupChannelPsg
	b _03803294
_038031B8:
	ldr r3, [sp, #0x2c]
	ldr r2, [sp, #0x28]
	and r0, r3, #0x7f
	str r0, [sp]
	ldr r0, [sp, #0x24]
	and r1, r2, #0x7f
	mov r2, r2, lsr #8
	and r2, r2, #3
	and r3, r6, r3, lsr #8
	bl SND_SetupChannelNoise
	b _03803294
_038031E4:
	ldr r0, [sp, #0x24]
	bl SNDi_SetSurroundDecay
	b _03803294
_038031F0:
	ldr r0, [sp, #0x24]
	bl SND_SetMasterVolume
	b _03803294
_038031FC:
	ldr r0, [sp, #0x24]
	bl SND_SetMasterPan
	b _03803294
_03803208:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x30]
	bl SND_SetOutputSelector
	b _03803294
_03803220:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	bl SND_LockChannel
	b _03803294
_03803230:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	bl SND_UnlockChannel
	b _03803294
_03803240:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	bl SND_StopUnlockedChannel
	b _03803294
_03803250:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	bl SND_InvalidateSeq
	b _03803294
_03803260:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	bl SND_InvalidateBank
	b _03803294
_03803270:
	ldr r0, [sp, #0x24]
	ldr r1, [sp, #0x28]
	bl SND_InvalidateWave
	b _03803294
_03803280:
	ldr r0, [sp, #0x24]
	str r0, [r7]
	b _03803294
_0380328C:
	ldr r0, [sp, #0x24]
	bl SND_ReadDriverInfo
_03803294:
	ldr lr, [sp, #0x1c]
_03803298:
	cmp lr, #0
	bne _03802E98
	ldr r1, [r7, #0]
	ldr r0, [r1, #0]
	add r0, r0, #1
	str r0, [r1]
_038032B0:
	mov r0, r9
	mov r1, r8
	mov r2, r4
	bl OS_ReceiveMessage
	cmp r0, #0
	bne _03802E90
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
	.align 2, 0
_038032D4: .word SNDi_SharedWork
_038032D8: .word sCommandMesgQueue
_038032DC: .word 0x0000FFFF
_038032E0: .word 0x003FFFFF
	arm_func_end SND_CommandProc

	arm_func_start SND_CommandInit
SND_CommandInit: // 0x038032E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _03803318 // =sCommandMesgQueue
	ldr r1, _0380331C // =sCommandMesgBuffer
	mov r2, #8
	bl OS_InitMessageQueue
	bl SND_InitPXI
	mov r1, #0
	ldr r0, _03803320 // =SNDi_SharedWork
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	bx lr
	.align 2, 0
_03803318: .word sCommandMesgQueue
_0380331C: .word sCommandMesgBuffer
_03803320: .word SNDi_SharedWork
	arm_func_end SND_CommandInit

	.rodata

.public SinTable
SinTable: // 0x03807E08
	.byte 0x00, 0x06, 0x0C, 0x13, 0x19, 0x1F, 0x25, 0x2B
	.byte 0x31, 0x36, 0x3C, 0x41, 0x47, 0x4C, 0x51, 0x55, 0x5A, 0x5E, 0x62, 0x66, 0x6A, 0x6D, 0x70, 0x73
	.byte 0x75, 0x78, 0x7A, 0x7B, 0x7D, 0x7E, 0x7E, 0x7F, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x80, 0x2E, 0xFD
	.byte 0x2F, 0xFD, 0x75, 0xFD, 0xA7, 0xFD, 0xCE, 0xFD, 0xEE, 0xFD, 0x09, 0xFE, 0x20, 0xFE, 0x34, 0xFE
	.byte 0x46, 0xFE, 0x57, 0xFE, 0x66, 0xFE, 0x74, 0xFE, 0x81, 0xFE, 0x8D, 0xFE, 0x98, 0xFE, 0xA3, 0xFE
	.byte 0xAD, 0xFE, 0xB6, 0xFE, 0xBF, 0xFE, 0xC7, 0xFE, 0xCF, 0xFE, 0xD7, 0xFE, 0xDF, 0xFE, 0xE6, 0xFE
	.byte 0xEC, 0xFE, 0xF3, 0xFE, 0xF9, 0xFE, 0xFF, 0xFE

_03807E68: // 0x03807E68
	.byte 0x05, 0xFF, 0x0B, 0xFF, 0x11, 0xFF, 0x16, 0xFF
	.byte 0x1B, 0xFF, 0x20, 0xFF, 0x25, 0xFF, 0x2A, 0xFF, 0x2E, 0xFF, 0x33, 0xFF, 0x37, 0xFF, 0x3C, 0xFF
	.byte 0x40, 0xFF, 0x44, 0xFF, 0x48, 0xFF, 0x4C, 0xFF, 0x50, 0xFF, 0x53, 0xFF, 0x57, 0xFF, 0x5B, 0xFF
	.byte 0x5E, 0xFF, 0x62, 0xFF, 0x65, 0xFF, 0x68, 0xFF, 0x6B, 0xFF, 0x6F, 0xFF, 0x72, 0xFF, 0x75, 0xFF
	.byte 0x78, 0xFF, 0x7B, 0xFF, 0x7E, 0xFF, 0x81, 0xFF, 0x83, 0xFF, 0x86, 0xFF, 0x89, 0xFF, 0x8C, 0xFF
	.byte 0x8E, 0xFF, 0x91, 0xFF, 0x93, 0xFF, 0x96, 0xFF, 0x99, 0xFF, 0x9B, 0xFF, 0x9D, 0xFF, 0xA0, 0xFF
	.byte 0xA2, 0xFF, 0xA5, 0xFF, 0xA7, 0xFF, 0xA9, 0xFF, 0xAB, 0xFF, 0xAE, 0xFF, 0xB0, 0xFF, 0xB2, 0xFF
	.byte 0xB4, 0xFF, 0xB6, 0xFF, 0xB8, 0xFF, 0xBA, 0xFF, 0xBC, 0xFF, 0xBE, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF
	.byte 0xC4, 0xFF, 0xC6, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF, 0xCC, 0xFF, 0xCE, 0xFF, 0xCF, 0xFF, 0xD1, 0xFF
	.byte 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD8, 0xFF, 0xDA, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDF, 0xFF
	.byte 0xE1, 0xFF, 0xE2, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF, 0xE7, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEC, 0xFF
	.byte 0xED, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF2, 0xFF, 0xF3, 0xFF, 0xF5, 0xFF, 0xF6, 0xFF, 0xF8, 0xFF
	.byte 0xF9, 0xFF, 0xFA, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF, 0xFF, 0xFF, 0x00, 0x00

.public _03807F2C
_03807F2C: // 0x03807F2C
	.byte 0x00, 0x01, 0x02, 0x04
	.byte 0x04, 0x05, 0x06, 0x07, 0x02, 0x00, 0x03, 0x01, 0x08, 0x09, 0x0A, 0x0B, 0x0E, 0x0C, 0x0F, 0x0D
	.byte 0x00, 0x01, 0x05, 0x0E, 0x1A, 0x26, 0x33, 0x3F, 0x49, 0x54, 0x5C, 0x64, 0x6D, 0x74, 0x7B, 0x7F
	.byte 0x84, 0x89, 0x8F, 0x00, 0xC7, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00
	.byte 0x40, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00
	
_03807F68: // 0x03807F68
	.byte 0x00, 0x00, 0x00, 0x01, 0x18, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x08, 0x00, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x14, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x04, 0x00, 0x12, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
	.byte 0x10, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00
	.byte 0x00, 0x01, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00
	.byte 0x00, 0x04, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00
	.byte 0x00, 0x10, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00
	.byte 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x10, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x40, 0x00, 0x16, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x02, 0x00, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x17, 0x00, 0x00, 0x00

	.data
	
.public sMasterPan
sMasterPan: // 0x38082F4
	.word 0xFFFFFFFF
	
.public u_3210
u_3210: // 0x038082F8
	.word 0x12345678