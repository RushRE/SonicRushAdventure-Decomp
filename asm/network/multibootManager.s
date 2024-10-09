	.include "asm/macros.inc"
	.include "global.inc"
	
.public gameState

.public _02133988
.public _02133990

	.bss
	
.public MultibootManager__sVars
MultibootManager__sVars: // 0x02135EB8
	.space 0x08 
	
.public WirelessManager__sVars
WirelessManager__sVars: // 0x02135EC0
	.space 0x18 
	
.public WirelessManager__sendBufferQueue
WirelessManager__sendBufferQueue: // 0x002135ED8
	.space 18 * 0x4
	
.public Task__Unknown20673B0__byte_2135F20
Task__Unknown20673B0__byte_2135F20: // 02135F20
	.space 32 * 0x1
	
.public WirelessManager__gameInfo
WirelessManager__gameInfo: // 0x02135F40
	.space 0x80
	
.public WirelessManager__sendBuffer
WirelessManager__sendBuffer: // 0x02135FC0
	.space 128 * 0x04 
	
.public word_21361C0
word_21361C0: // 0x021361C0
	.space 144 * 0x04

.public whConfig
whConfig: // 0x02136400
	.space 0x60 // WHConfig
	
.public sWEPKey
sWEPKey: // 0x02136460
	.space 16 * 0x02
	
.public sScanParam
sScanParam: // 0x02136480
	.space 0x20 // WMScanParam
	
.public sParentParam
sParentParam: // 0x021364A0
	.space 0x40 // WMParentParam
	
.public sBssDesc
sBssDesc: // 0x021364E0
	.space 0xC0 // WMBssDesc
	
.public sDataSet
sDataSet: // 0x021365A0
	.space 0x200 // WMDataSet
	
.public sWMKeySetBuf
sWMKeySetBuf: // 0x021367A0
	.space 0x820 // WMKeySetBuf
	
.public WMDataSharingInfo
WMDataSharingInfo: // 0x02136FC0
	.space 0x820 // WMDataSharingInfo
	
.public sConnectionSsid
sConnectionSsid: // 0x021377E0
	.space 32 * 0x01
	
.public sSendBuffer
sSendBuffer: // 0x02137800
	.space 544 * 0x01
	
.public sRecvBuffer
sRecvBuffer: // 0x02137A20
	.space 0x480 * 0x01
	
.public sWmBuffer
sWmBuffer: // 0x02137EA0
	.space 0xF00 * 0x01
	
.public wfsi_work
wfsi_work: // 0x02138DA0
	.space 0x4 // WFSWork*
	
.public WFS__init_flag
WFS__init_flag: // 0x02138DA4
	.space 0x4
	
.public wfsi_debug_enable
wfsi_debug_enable: // 0x02138DA8
	.space 0x4
	
.public wfsi_task
wfsi_task: // 0x02138DAC
	.space 0x4CC // WFSiTask
	
.public sFilebuf
sFilebuf: // 0x02139278
	.space 0x4 // u8*
	
.public dword_213927C
dword_213927C: // 0x0213927C
	.space 0x4
	
.public sCWork
sCWork: // 0x02139280
	.space 0x4 // u32*
	
.public mbpState
mbpState: // 0x02139284
	.space 0x0E // MBPState
	
.public childInfo
childInfo: // 0x02139292
	.space 15 * 0x1E

	.text

	arm_func_start MultibootManager__Create
MultibootManager__Create: // 0x02060BD0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r0, #0x1000
	mov r2, #0
	str r0, [sp]
	ldr r0, _02060C90 // =MultibootManager__Main
	ldr r1, _02060C94 // =MultibootManager__Destructor
	mov r3, r2
	str r2, [sp, #4]
	mov r4, #0x350
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _02060C98 // =MultibootManager__sVars
	str r0, [r1, #4]
	bl GetTaskWork_
	mov r4, r0
	bl WirelessManager__GetField8
	cmp r0, #0
	beq _02060C34
	mov r0, r4
	bl MultibootManager__Func_2061C84
	mov r0, r4
	bl MultibootManager__Func_2061D1C
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_02060C34:
	bl GetINetManagerStatus
	cmp r0, #0
	beq _02060C58
	mov r0, r4
	bl MultibootManager__Func_2061C84
	mov r0, r4
	bl MultibootManager__Func_2061E04
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_02060C58:
	ldr r1, _02060C98 // =MultibootManager__sVars
	mov r2, #0
	mov r0, r4
	str r2, [r1]
	bl MultibootManager__Func_2061C84
	mov r0, #1
	mov r1, #3
	bl WirelessManager__InitAllocator
	mov r0, r4
	bl MultibootManager__Func_2061F20
	mov r0, #3
	str r0, [r4, #0x38]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02060C90: .word MultibootManager__Main
_02060C94: .word MultibootManager__Destructor
_02060C98: .word MultibootManager__sVars
	arm_func_end MultibootManager__Create

	arm_func_start MultibootManager__Func_2060C9C
MultibootManager__Func_2060C9C: // 0x02060C9C
	stmdb sp!, {r3, lr}
	ldr r0, _02060CC4 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyTask
	ldr r0, _02060CC4 // =MultibootManager__sVars
	mov r1, #0
	str r1, [r0, #4]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02060CC4: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060C9C

	arm_func_start MultibootManager__Func_2060CC8
MultibootManager__Func_2060CC8: // 0x02060CC8
	stmdb sp!, {r3, lr}
	ldr r0, _02060CEC // =MultibootManager__sVars
	ldr r0, [r0, #4]
	cmp r0, #0
	moveq r0, #0x18
	ldmeqia sp!, {r3, pc}
	bl GetTaskWork_
	ldr r0, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02060CEC: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060CC8

	arm_func_start MultibootManager__Func_2060CF0
MultibootManager__Func_2060CF0: // 0x02060CF0
	stmdb sp!, {r3, lr}
	ldr r0, _02060D08 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02060D08: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060CF0

	arm_func_start MultibootManager__Func_2060D0C
MultibootManager__Func_2060D0C: // 0x02060D0C
	stmdb sp!, {r3, lr}
	ldr r0, _02060D24 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x10]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02060D24: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060D0C

	arm_func_start MultibootManager__Func_2060D28
MultibootManager__Func_2060D28: // 0x02060D28
	ldr ip, _02060D30 // =MultibootManager__CheckUsingNetwork
	bx ip
	.align 2, 0
_02060D30: .word MultibootManager__CheckUsingNetwork
	arm_func_end MultibootManager__Func_2060D28

	arm_func_start MultibootManager__Func_2060D34
MultibootManager__Func_2060D34: // 0x02060D34
	stmdb sp!, {r3, lr}
	bl MultibootManager__Func_2063AF0
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MultibootManager__Func_2060D34

	arm_func_start MultibootManager__Func_2060D4C
MultibootManager__Func_2060D4C: // 0x02060D4C
	stmdb sp!, {r3, lr}
	ldr r0, _02060D70 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r1, [r0, #0]
	cmp r1, #3
	movge r0, #0
	addlt r0, r0, #0x3c
	ldmia sp!, {r3, pc}
	.align 2, 0
_02060D70: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060D4C

	arm_func_start MultibootManager__Func_2060D74
MultibootManager__Func_2060D74: // 0x02060D74
	stmdb sp!, {r3, lr}
	ldr r0, _02060D98 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r1, [r0, #0]
	cmp r1, #3
	movge r0, #0
	ldrlth r0, [r0, #0x4c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02060D98: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060D74

	arm_func_start MultibootManager__Func_2060D9C
MultibootManager__Func_2060D9C: // 0x02060D9C
	stmdb sp!, {r3, lr}
	ldr r0, _02060DC0 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r1, [r0, #0]
	cmp r1, #3
	movge r0, #0
	ldrlt r0, [r0, #0x54]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02060DC0: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060D9C

	arm_func_start MultibootManager__Func_2060DC4
MultibootManager__Func_2060DC4: // 0x02060DC4
	stmdb sp!, {r3, lr}
	ldr r0, _02060DDC // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r0, [r0, #0x38]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02060DDC: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060DC4

	arm_func_start MultibootManager__Func_2060DE0
MultibootManager__Func_2060DE0: // 0x02060DE0
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02060E6C // =MultibootManager__sVars
	mov r5, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	mov r4, r0
	mov r1, #0
	str r1, [r4]
	mov r0, #1
	str r0, [r4, #4]
	str r0, [r4, #8]
	str r0, [r4, #0x10]
	cmp r5, #0
	movne r0, r1
	str r5, [r4, #0x38]
	bl MultibootManager__Func_2063B0C
	ldr r0, _02060E70 // =0x0000FFFF
	add r1, r4, #0x14
	mov r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	bl MultibootManager__Func_2063994
	mov r0, #0
	bl MultibootManager__Func_2063A74
	bl WirelessManager__ClearSendBuffer
	bl MultibootManager__Func_2067B50
	mov r0, r4
	bl MultibootManager__Func_20639F8
	mov r0, #1
	str r0, [r4, #0x28]
	ldr r0, _02060E6C // =MultibootManager__sVars
	ldr r1, _02060E74 // =MultibootManager__Main_2061F4C
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02060E6C: .word MultibootManager__sVars
_02060E70: .word 0x0000FFFF
_02060E74: .word MultibootManager__Main_2061F4C
	arm_func_end MultibootManager__Func_2060DE0

	arm_func_start MultibootManager__Func_2060E78
MultibootManager__Func_2060E78: // 0x02060E78
	stmdb sp!, {r4, lr}
	ldr r0, _02060EC8 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	bl WirelessManager__GetField8
	cmp r0, #2
	bne _02060EA8
	bl WirelessManager__Func_20681D0
	mov r0, #3
	str r0, [r4, #8]
	ldmia sp!, {r4, pc}
_02060EA8:
	bl WirelessManager__GetField8
	cmp r0, #1
	moveq r0, #1
	streq r0, [r4, #8]
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl MultibootManager__Func_20634D4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02060EC8: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060E78

	arm_func_start MultibootManager__Func_2060ECC
MultibootManager__Func_2060ECC: // 0x02060ECC
	stmdb sp!, {r4, lr}
	ldr r0, _02060F00 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__Func_2061C20
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl MultibootManager__Func_20631A0
	ldr r0, [r4, #0x38]
	bl MultibootManager__Func_2060DE0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02060F00: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060ECC

	arm_func_start MultibootManager__Func_2060F04
MultibootManager__Func_2060F04: // 0x02060F04
	stmdb sp!, {r4, lr}
	ldr r0, _02060F94 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0
	str r0, [r4]
	mov r1, #1
	str r1, [r4, #4]
	mov r1, #4
	str r1, [r4, #8]
	str r0, [r4, #0x10]
	mov r3, #3
	add r1, r4, #0x64
	mov r2, #0x140
	str r3, [r4, #0x38]
	bl MIi_CpuClear32
	ldr r0, _02060F98 // =0x0000FFFF
	add r1, r4, #0x14
	mov r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	bl MultibootManager__Func_2063994
	mov r0, #0
	bl MultibootManager__Func_2063A74
	bl WirelessManager__ClearSendBuffer
	bl MultibootManager__Func_2067B50
	mov r0, r4
	bl MultibootManager__Func_20639F8
	mov r0, #1
	str r0, [r4, #0x28]
	ldr r0, _02060F94 // =MultibootManager__sVars
	ldr r1, _02060F9C // =MultibootManager__Main_2062104
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02060F94: .word MultibootManager__sVars
_02060F98: .word 0x0000FFFF
_02060F9C: .word MultibootManager__Main_2062104
	arm_func_end MultibootManager__Func_2060F04

	arm_func_start MultibootManager__Func_2060FA0
MultibootManager__Func_2060FA0: // 0x02060FA0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r0, _02061078 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r8, r0
	bl WirelessManager__GetField8
	cmp r0, #4
	bne _0206106C
	add r1, r8, #0x64
	mov r0, #0
	mov r2, #0x140
	bl MIi_CpuClear32
	mov r7, #0
	bl MultibootManager__Func_20679A8
	cmp r0, #0
	ldmleia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r9, r8, #0x68
	add r10, r8, #0x80
	mov r5, #1
	mov r4, #0x18
	mov r11, #6
_02060FF4:
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MultibootManager__Func_20679B4
	mov r6, r0
	ldr r0, [r6, #0xc0]
	cmp r0, #0x258
	bls _02061020
	mov r0, r7, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MultibootManager__Func_20679C0
	b _0206105C
_02061020:
	mov r1, r9
	mov r2, r4
	add r0, r6, #0x50
	str r5, [r8, #0x64]
	bl MIi_CpuCopy32
	mov r1, r10
	mov r2, r11
	add r0, r6, #4
	bl MI_CpuCopy8
	ldrh r0, [r6, #0xc4]
	add r9, r9, #0x28
	add r10, r10, #0x28
	strh r0, [r8, #0x86]
	add r8, r8, #0x28
	add r7, r7, #1
_0206105C:
	bl MultibootManager__Func_20679A8
	cmp r7, r0
	blt _02060FF4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0206106C:
	mov r0, r8
	bl MultibootManager__Func_2063510
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02061078: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2060FA0

	arm_func_start MultibootManager__Func_206107C
MultibootManager__Func_206107C: // 0x0206107C
	stmdb sp!, {r3, lr}
	ldr r0, _020610B8 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r2, #0
_02061090:
	ldr r1, [r0, #0x64]
	cmp r1, #0
	beq _020610AC
	add r2, r2, #1
	cmp r2, #8
	add r0, r0, #0x28
	blt _02061090
_020610AC:
	mov r0, r2, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r3, pc}
	.align 2, 0
_020610B8: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_206107C

	arm_func_start MultibootManager__Func_20610BC
MultibootManager__Func_20610BC: // 0x020610BC
	stmdb sp!, {r4, lr}
	ldr r1, _020610F4 // =MultibootManager__sVars
	mov r4, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	mov r1, #0x28
	mul r2, r4, r1
	add r1, r0, r2
	ldr r1, [r1, #0x64]
	tst r1, #1
	addne r0, r0, #0x68
	addne r0, r0, r2
	moveq r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_020610F4: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_20610BC

	arm_func_start MultibootManager__Func_20610F8
MultibootManager__Func_20610F8: // 0x020610F8
	stmdb sp!, {r4, lr}
	ldr r1, _02061128 // =MultibootManager__sVars
	mov r4, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	mov r1, #0x28
	mla r1, r4, r1, r0
	ldr r0, [r1, #0x64]
	tst r0, #1
	ldrneh r0, [r1, #0x7a]
	moveq r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02061128: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_20610F8

	arm_func_start MultibootManager__Func_206112C
MultibootManager__Func_206112C: // 0x0206112C
	stmdb sp!, {r4, lr}
	ldr r1, _0206115C // =MultibootManager__sVars
	mov r4, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	mov r1, #0x28
	mla r1, r4, r1, r0
	ldr r0, [r1, #0x64]
	tst r0, #1
	ldrne r0, [r1, #0x7c]
	moveq r0, #3
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206115C: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_206112C

	arm_func_start MultibootManager__Func_2061160
MultibootManager__Func_2061160: // 0x02061160
	stmdb sp!, {r4, lr}
	ldr r1, _02061190 // =MultibootManager__sVars
	mov r4, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	mov r1, #0x28
	mla r1, r4, r1, r0
	ldr r0, [r1, #0x64]
	tst r0, #1
	ldrneh r0, [r1, #0x86]
	moveq r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02061190: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061160

	arm_func_start MultibootManager__Func_2061194
MultibootManager__Func_2061194: // 0x02061194
	stmdb sp!, {r3, lr}
	ldr r0, _020611AC // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_020611AC: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061194

	arm_func_start MultibootManager__Func_20611B0
MultibootManager__Func_20611B0: // 0x020611B0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr r1, _02061294 // =MultibootManager__sVars
	mov r4, r0
	ldr r0, [r1, #4]
	mov r11, #0
	bl GetTaskWork_
	mov r1, #0x28
	mul r10, r4, r1
	mov r6, r0
	add r0, r6, r10
	ldr r0, [r0, #0x64]
	tst r0, #2
	bne _0206128C
	bl WirelessManager__GetField8
	cmp r0, #4
	beq _020611F8
	mov r0, r6
	bl MultibootManager__Func_2063510
_020611F8:
	bl MultibootManager__Func_20679A8
	mov r7, r0
	cmp r7, #0
	mov r8, #0
	ble _0206128C
	add r5, r6, #0x80
	add r4, r6, #0x68
	add r9, r6, r10
_02061218:
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MultibootManager__Func_20679B4
	add r1, r0, #4
	add r0, r5, r10
	bl MultibootManager__Func_20637BC
	cmp r0, #0
	beq _02061280
	mov r2, #0x10
	add r0, r4, r10
	add r1, r6, #0x3c
	bl MIi_CpuCopy16
	ldrh r2, [r9, #0x7a]
	add r0, r5, r10
	add r1, r6, #0x4e
	strh r2, [r6, #0x4c]
	mov r2, #6
	bl MI_CpuCopy8
	ldr r1, [r9, #0x7c]
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	str r1, [r6, #0x38]
	bl MultibootManager__Func_20679CC
	mov r0, #5
	str r0, [r6, #8]
	mov r11, #1
_02061280:
	add r8, r8, #1
	cmp r8, r7
	blt _02061218
_0206128C:
	mov r0, r11
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02061294: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_20611B0

	arm_func_start MultibootManager__Func_2061298
MultibootManager__Func_2061298: // 0x02061298
	stmdb sp!, {r4, lr}
	ldr r0, _020612D0 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #4
	str r0, [r4, #8]
	bl MultibootManager__Func_2061C20
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl MultibootManager__Func_20631BC
	bl MultibootManager__Func_2060F04
	ldmia sp!, {r4, pc}
	.align 2, 0
_020612D0: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061298

	arm_func_start MultibootManager__Func_20612D4
MultibootManager__Func_20612D4: // 0x020612D4
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02061354 // =MultibootManager__sVars
	mov r5, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #1
	str r0, [r4]
	mov r1, #2
	str r1, [r4, #4]
	mov r1, #6
	str r1, [r4, #8]
	str r0, [r4, #0x10]
	cmp r5, #0
	movne r0, #0
	str r5, [r4, #0x38]
	bl MultibootManager__Func_2063B0C
	ldr r0, _02061358 // =0x0000FFFF
	add r1, r4, #0x14
	mov r2, #4
	bl MIi_CpuClear16
	mov r0, r4
	bl MultibootManager__Func_2063994
	mov r0, #1
	bl MultibootManager__Func_2063A74
	mov r1, #1
	str r1, [r4, #0x28]
	ldr r0, _02061354 // =MultibootManager__sVars
	ldr r1, _0206135C // =MultibootManager__Main_20622E4
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02061354: .word MultibootManager__sVars
_02061358: .word 0x0000FFFF
_0206135C: .word MultibootManager__Main_20622E4
	arm_func_end MultibootManager__Func_20612D4

	arm_func_start MultibootManager__Func_2061360
MultibootManager__Func_2061360: // 0x02061360
	stmdb sp!, {r4, lr}
	ldr r0, _020613B8 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	mov r0, #8
	str r0, [r4, #8]
	bl WirelessManager__GetField8
	cmp r0, #2
	bne _02061398
	bl WirelessManager__Func_20681D0
	mov r0, #8
	str r0, [r4, #8]
	ldmia sp!, {r4, pc}
_02061398:
	bl WirelessManager__GetField8
	cmp r0, #1
	moveq r0, #6
	streq r0, [r4, #8]
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl MultibootManager__Func_20635C4
	ldmia sp!, {r4, pc}
	.align 2, 0
_020613B8: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061360

	arm_func_start MultibootManager__Func_20613BC
MultibootManager__Func_20613BC: // 0x020613BC
	stmdb sp!, {r4, lr}
	ldr r0, _020613E0 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__Func_206321C
	ldr r0, [r4, #0x38]
	bl MultibootManager__Func_20612D4
	ldmia sp!, {r4, pc}
	.align 2, 0
_020613E0: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_20613BC

	arm_func_start MultibootManager__Func_20613E4
MultibootManager__Func_20613E4: // 0x020613E4
	stmdb sp!, {r4, lr}
	ldr r0, _02061470 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	str r0, [r4]
	mov r1, #4
	str r1, [r4, #4]
	mov r1, #0xb
	mov r0, r4
	str r1, [r4, #8]
	bl MultibootManager__Func_2063994
	mov r0, #1
	str r0, [r4, #0x28]
	bl WirelessManager__ClearSendBuffer
	bl MultibootManager__Func_2067B50
	mov r0, r4
	bl MultibootManager__Func_20639F8
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _0206145C
	ldr r0, _02061470 // =MultibootManager__sVars
	ldr r1, _02061474 // =MultibootManager__Main_2062484
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
_0206145C:
	ldr r0, _02061470 // =MultibootManager__sVars
	ldr r1, _02061478 // =MultibootManager__Main_2062550
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02061470: .word MultibootManager__sVars
_02061474: .word MultibootManager__Main_2062484
_02061478: .word MultibootManager__Main_2062550
	arm_func_end MultibootManager__Func_20613E4

	arm_func_start MultibootManager__Func_206147C
MultibootManager__Func_206147C: // 0x0206147C
	stmdb sp!, {r4, lr}
	ldr r0, _02061500 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	str r0, [r4]
	mov r1, #5
	str r1, [r4, #4]
	mov r1, #0xd
	mov r0, r4
	str r1, [r4, #8]
	bl MultibootManager__Func_2063994
	mov r0, #1
	str r0, [r4, #0x28]
	mov r0, #0
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _020614EC
	ldr r0, _02061500 // =MultibootManager__sVars
	ldr r1, _02061504 // =MultibootManager__Main_2062614
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
_020614EC:
	ldr r0, _02061500 // =MultibootManager__sVars
	ldr r1, _02061508 // =MultibootManager__Main_20626BC
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02061500: .word MultibootManager__sVars
_02061504: .word MultibootManager__Main_2062614
_02061508: .word MultibootManager__Main_20626BC
	arm_func_end MultibootManager__Func_206147C

	arm_func_start MultibootManager__Func_206150C
MultibootManager__Func_206150C: // 0x0206150C
	stmdb sp!, {r4, lr}
	ldr r0, _02061634 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	ldr r1, [r4, #8]
	cmp r1, #0
	bne _02061534
	bl MultibootManager__Func_2061F20
	ldmia sp!, {r4, pc}
_02061534:
	bl MultibootManager__Func_206318C
	cmp r0, #0
	beq _0206154C
	mov r0, r4
	bl MultibootManager__Func_2061F20
	ldmia sp!, {r4, pc}
_0206154C:
	ldr r0, [r4, #0]
	cmp r0, #2
	beq _02061610
	ldr r0, [r4, #0x10]
	cmp r0, #0
	ldr r0, [r4, #4]
	beq _020615BC
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _020615B0
_02061574: // jump table
	b _020615B0 // case 0
	b _0206158C // case 1
	b _020615A4 // case 2
	b _020615B0 // case 3
	b _0206158C // case 4
	b _02061598 // case 5
_0206158C:
	mov r0, r4
	bl MultibootManager__Func_20631A0
	ldmia sp!, {r4, pc}
_02061598:
	mov r0, r4
	bl MultibootManager__Func_20631D8
	ldmia sp!, {r4, pc}
_020615A4:
	mov r0, r4
	bl MultibootManager__Func_206321C
	ldmia sp!, {r4, pc}
_020615B0:
	mov r0, r4
	bl MultibootManager__Func_2061F20
	ldmia sp!, {r4, pc}
_020615BC:
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02061604
_020615C8: // jump table
	b _02061604 // case 0
	b _020615E0 // case 1
	b _020615F8 // case 2
	b _02061604 // case 3
	b _020615E0 // case 4
	b _020615EC // case 5
_020615E0:
	mov r0, r4
	bl MultibootManager__Func_20631BC
	ldmia sp!, {r4, pc}
_020615EC:
	mov r0, r4
	bl MultibootManager__Func_2063200
	ldmia sp!, {r4, pc}
_020615F8:
	mov r0, r4
	bl MultibootManager__Func_2061F20
	ldmia sp!, {r4, pc}
_02061604:
	mov r0, r4
	bl MultibootManager__Func_2061F20
	ldmia sp!, {r4, pc}
_02061610:
	bl DWC_CloseConnectionsAsync
	bl DestroyDataTransferManager
	bl DestroyConnectionManager
	bl DestroyMatchManager
	mov r0, #0
	bl DestroyINetManager
	mov r0, r4
	bl MultibootManager__Func_2061F20
	ldmia sp!, {r4, pc}
	.align 2, 0
_02061634: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_206150C

	arm_func_start MultibootManager__Func_2061638
MultibootManager__Func_2061638: // 0x02061638
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl InitNetwork
	cmp r0, #3
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MultibootManager__Func_2061638

	arm_func_start MultibootManager__Func_2061654
MultibootManager__Func_2061654: // 0x02061654
	stmdb sp!, {r4, lr}
	ldr r0, _020616BC // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	mov r1, #2
	str r1, [r4]
	mov r1, #3
	str r1, [r4, #4]
	mov r1, #0xf
	str r1, [r4, #8]
	mov r2, #1
	str r2, [r4, #0x10]
	mov r1, #0
	strh r1, [r4, #0x14]
	strh r2, [r4, #0x16]
	bl MultibootManager__Func_2063994
	mov r0, #0
	bl MultibootManager__Func_2063A74
	mov r1, #1
	ldr r0, _020616BC // =MultibootManager__sVars
	str r1, [r4, #0x28]
	ldr r0, [r0, #4]
	ldr r1, _020616C0 // =MultibootManager__Main_206278C
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_020616BC: .word MultibootManager__sVars
_020616C0: .word MultibootManager__Main_206278C
	arm_func_end MultibootManager__Func_2061654

	arm_func_start MultibootManager__Func_20616C4
MultibootManager__Func_20616C4: // 0x020616C4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x28
	ldr r2, _020617E8 // =MultibootManager__sVars
	mov r5, r0
	ldr r0, [r2, #4]
	mov r6, r1
	bl GetTaskWork_
	mov r4, r0
	mov r0, #0x12
	str r0, [r4, #8]
	mov r0, #1
	str r0, [r4, #0x30c]
	str r6, [r4, #0x38]
	bl SaveGame__GetOnlineScore_
	str r0, [r4, #0x300]
	ldr r0, _020617EC // =mbRom
	ldr r3, [r4, #0x38]
	ldr r2, _020617F0 // =0x02119DB8
	ldr r1, [r0, #0]
	ldr r2, [r2, r3, lsl #2]
	mov r0, #0
	bl DWC_AddMatchKeyString
	ldr r1, _020617EC // =mbRom
	mov r0, #0
	ldr r1, [r1, #4]
	add r2, r4, #0x300
	bl DWC_AddMatchKeyInt
	mov r0, #0
	cmp r5, #0
	str r0, [r4, #0x304]
	moveq r0, #1
	bl MultibootManager__Func_2063AC0
	bl MultibootManager__Func_2063AF0
	cmp r0, #0
	bne _020617B4
	ldr r1, _020617EC // =mbRom
	add r0, sp, #8
	ldr r1, [r1, #0]
	bl STD_CopyString
	ldr r1, _020617F4 // =_02119E6C
	add r0, sp, #8
	bl STD_ConcatenateString
	ldr r2, [r4, #0x38]
	ldr r1, _020617F0 // =0x02119DB8
	add r0, sp, #8
	ldr r1, [r1, r2, lsl #2]
	bl STD_ConcatenateString
	ldr r1, _020617F8 // =_02119E74
	add r0, sp, #8
	bl STD_ConcatenateString
	ldr r1, _020617FC // =MultibootManager__Func_20633D0
	mov r0, #0
	str r1, [sp]
	str r0, [sp, #4]
	mov r0, #2
	mov r1, r0
	mov r2, #0x108
	add r3, sp, #8
	bl CreateConnectionManagerForAnybody
	b _020617D0
_020617B4:
	mov r0, #2
	mov r4, #0
	ldr r3, _02061800 // =MultibootManager__Func_2063474
	mov r1, r0
	mov r2, #0x108
	str r4, [sp]
	bl CreateConnectionManagerForFriends
_020617D0:
	ldr r0, _020617E8 // =MultibootManager__sVars
	ldr r1, _02061804 // =MultibootManager__Main_2062904
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020617E8: .word MultibootManager__sVars
_020617EC: .word mbRom
_020617F0: .word 0x02119DB8
_020617F4: .word _02119E6C
_020617F8: .word _02119E74
_020617FC: .word MultibootManager__Func_20633D0
_02061800: .word MultibootManager__Func_2063474
_02061804: .word MultibootManager__Main_2062904
	arm_func_end MultibootManager__Func_20616C4

	arm_func_start MultibootManager__Func_2061808
MultibootManager__Func_2061808: // 0x02061808
	stmdb sp!, {r3, lr}
	ldr r0, _02061820 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	bl DWC_CancelMatching
	ldmia sp!, {r3, pc}
	.align 2, 0
_02061820: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061808

	arm_func_start MultibootManager__Func_2061824
MultibootManager__Func_2061824: // 0x02061824
	stmdb sp!, {r4, lr}
	ldr r0, _02061880 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #8]
	cmp r0, #0x14
	beq _02061858
	cmp r0, #0x13
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0xc]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
_02061858:
	bl DWC_CloseConnectionsAsync
	bl DestroyDataTransferManager
	bl DestroyConnectionManager
	mov r1, #0x11
	ldr r0, _02061880 // =MultibootManager__sVars
	str r1, [r4, #8]
	ldr r0, [r0, #4]
	ldr r1, _02061884 // =MultibootManager__Main_2062FB8
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02061880: .word MultibootManager__sVars
_02061884: .word MultibootManager__Main_2062FB8
	arm_func_end MultibootManager__Func_2061824

	arm_func_start MultibootManager__Func_2061888
MultibootManager__Func_2061888: // 0x02061888
	stmdb sp!, {r4, lr}
	ldr r1, _020618A4 // =MultibootManager__sVars
	mov r4, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	str r4, [r0, #0x30c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020618A4: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061888

	arm_func_start MultibootManager__Func_20618A8
MultibootManager__Func_20618A8: // 0x020618A8
	stmdb sp!, {r3, lr}
	ldr r0, _020618E8 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r1, #0x13
	str r1, [r0, #8]
	mov r2, #0
	str r2, [r0, #0x28]
	ldr r1, _020618E8 // =MultibootManager__sVars
	str r2, [r0, #0x308]
	mov r2, #1
	str r2, [r0, #0xc]
	ldr r0, [r1, #4]
	ldr r1, _020618EC // =MultibootManager__Main_2062CCC
	bl SetTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_020618E8: .word MultibootManager__sVars
_020618EC: .word MultibootManager__Main_2062CCC
	arm_func_end MultibootManager__Func_20618A8

	arm_func_start MultibootManager__Func_20618F0
MultibootManager__Func_20618F0: // 0x020618F0
	ldr ip, _020618FC // =DWC_CheckHasProfile
	ldr r0, _02061900 // =saveGame+0x00000E50
	bx ip
	.align 2, 0
_020618FC: .word DWC_CheckHasProfile
_02061900: .word saveGame+0x00000E50
	arm_func_end MultibootManager__Func_20618F0

	arm_func_start MultibootManager__Func_2061904
MultibootManager__Func_2061904: // 0x02061904
	ldr ip, _02061910 // =DWC_CheckValidConsole
	ldr r0, _02061914 // =saveGame+0x00000E50
	bx ip
	.align 2, 0
_02061910: .word DWC_CheckValidConsole
_02061914: .word saveGame+0x00000E50
	arm_func_end MultibootManager__Func_2061904

	arm_func_start MultibootManager__Func_2061918
MultibootManager__Func_2061918: // 0x02061918
	stmdb sp!, {r3, lr}
	bl DWC_GetIngamesnCheckResult
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	cmp r0, #2
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MultibootManager__Func_2061918

	arm_func_start MultibootManager__Func_206193C
MultibootManager__Func_206193C: // 0x0206193C
	stmdb sp!, {r4, lr}
	ldr r0, _020619B0 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	ldrb r0, [r4, #0x1e]
	add r0, r0, #1
	strb r0, [r4, #0x1e]
	ldr r0, [r4, #4]
	cmp r0, #3
	bne _02061990
	bl GetDataTransferSendBuffer
	mov r1, #0x78
	strb r1, [r0]
	ldrb r2, [r4, #0x1e]
	mov r1, #1
	strb r2, [r0, #2]
	ldrb r2, [r4, #0x1a]
	strb r2, [r0, #3]
	str r1, [r4, #0x2c]
	ldmia sp!, {r4, pc}
_02061990:
	bl WirelessManager__GetSendBuffer
	mov r1, #0x78
	strb r1, [r0]
	ldrb r1, [r4, #0x1e]
	strb r1, [r0, #2]
	ldrb r1, [r4, #0x1a]
	strb r1, [r0, #3]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020619B0: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_206193C

	arm_func_start MultibootManager__Func_20619B4
MultibootManager__Func_20619B4: // 0x020619B4
	stmdb sp!, {r4, lr}
	ldr r0, _02061A20 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	ldr r0, [r4, #8]
	cmp r0, #0x14
	ldreq r0, [r4, #0x30c]
	cmpeq r0, #0
	bne _020619EC
	bl DWC_GetNumConnectionHost
	cmp r0, #1
	movle r0, #1
	ldmleia sp!, {r4, pc}
_020619EC:
	ldrb r2, [r4, #0x18]
	ldrb r0, [r4, #0x1e]
	cmp r2, r0
	movne r0, #0
	ldmneia sp!, {r4, pc}
	ldrb r1, [r4, #0x19]
	cmp r2, r1
	addne r0, r2, #1
	andne r0, r0, #0xff
	cmpne r0, r1
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02061A20: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_20619B4

	arm_func_start MultibootManager__Func_2061A24
MultibootManager__Func_2061A24: // 0x02061A24
	stmdb sp!, {r4, lr}
	ldr r0, _02061A94 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	ldr r1, [r4, #4]
	cmp r1, #3
	bne _02061A54
	bl MultibootManager__Func_2063A4C
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
_02061A54:
	ldr r0, [r4, #0x10]
	ldrb r1, [r4, #0x1a]
	cmp r0, #0
	ldrb r0, [r4, #0x1b]
	beq _02061A78
	cmp r1, r0
	bne _02061A8C
	mov r0, #1
	ldmia sp!, {r4, pc}
_02061A78:
	add r1, r1, #1
	and r1, r1, #0xff
	cmp r1, r0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
_02061A8C:
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02061A94: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061A24

	arm_func_start MultibootManager__Func_2061A98
MultibootManager__Func_2061A98: // 0x02061A98
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r2, _02061B38 // =MultibootManager__sVars
	mov r6, r0
	ldr r0, [r2, #4]
	mov r5, r1
	bl GetTaskWork_
	mov r4, r0
	ldrb r0, [r4, #0x1a]
	add r0, r0, #1
	strb r0, [r4, #0x1a]
	ldr r0, [r4, #4]
	cmp r0, #3
	bne _02061B04
	bl GetDataTransferSendBuffer
	mov r7, r0
	mov r0, #0x78
	strb r0, [r7]
	ldrb r3, [r4, #0x1a]
	mov r0, r6
	mov r2, r5
	add r1, r7, #4
	strb r3, [r7, #3]
	bl MI_CpuCopy8
	mov r0, #1
	str r0, [r4, #0x2c]
	str r5, [r4, #0x34]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
_02061B04:
	bl WirelessManager__GetSendBuffer
	mov r7, r0
	bl WirelessManager__GetSendBuffer
	mov r1, r0
	mov r0, #0x78
	strb r0, [r7]
	ldrb r3, [r4, #0x1a]
	mov r0, r6
	mov r2, r5
	add r1, r1, #4
	strb r3, [r7, #3]
	bl MI_CpuCopy8
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_02061B38: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061A98

	arm_func_start MultibootManager__Func_2061B3C
MultibootManager__Func_2061B3C: // 0x02061B3C
	stmdb sp!, {r3, r4, r5, lr}
	ldr r0, _02061BD0 // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r4, r0
	ldrb r0, [r4, #0x1a]
	add r0, r0, #1
	strb r0, [r4, #0x1a]
	ldr r0, [r4, #4]
	cmp r0, #3
	bne _02061BA0
	bl GetDataTransferSendBuffer
	mov r1, #0x78
	strb r1, [r0]
	ldrb r3, [r4, #0x1a]
	mov r1, #0
	mov r2, #0x3c
	strb r3, [r0, #3]
	add r0, r0, #4
	bl MI_CpuFill8
	mov r0, #1
	str r0, [r4, #0x2c]
	mov r0, #0x3c
	str r0, [r4, #0x34]
	ldmia sp!, {r3, r4, r5, pc}
_02061BA0:
	bl WirelessManager__GetSendBuffer
	mov r5, r0
	bl WirelessManager__GetSendBuffer
	mov r1, #0x78
	strb r1, [r5]
	ldrb r3, [r4, #0x1a]
	add r0, r0, #4
	mov r1, #0
	mov r2, #0x3c
	strb r3, [r5, #3]
	bl MI_CpuFill8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02061BD0: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061B3C

	arm_func_start MultibootManager__Func_2061BD4
MultibootManager__Func_2061BD4: // 0x02061BD4
	stmdb sp!, {r3, lr}
	ldr r0, _02061BEC // =MultibootManager__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	add r0, r0, #0x314
	ldmia sp!, {r3, pc}
	.align 2, 0
_02061BEC: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061BD4

	arm_func_start MultibootManager__Func_2061BF0
MultibootManager__Func_2061BF0: // 0x02061BF0
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02061C1C // =MultibootManager__sVars
	mov r5, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	mov r4, r0
	bl MultibootManager__Func_2063708
	cmp r5, #0
	movne r0, #0x19
	strne r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02061C1C: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2061BF0

	arm_func_start MultibootManager__Func_2061C20
MultibootManager__Func_2061C20: // 0x02061C20
	stmdb sp!, {r3, lr}
	bl WirelessManager__GetField8
	cmp r0, #6
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x13
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl MultibootManager__Func_2060CC8
	cmp r0, #0x14
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MultibootManager__Func_2061C20

	arm_func_start MultibootManager__Func_2061C58
MultibootManager__Func_2061C58: // 0x02061C58
	stmdb sp!, {r3, lr}
	bl DWC_CloseConnectionsAsync
	bl DestroyLeaderboardsManager
	bl DestroyNdManager
	bl DestroyStorageManager
	bl DestroyDataTransferManager
	bl DestroyConnectionManager
	bl DestroyMatchManager
	mov r0, #0
	bl DestroyINetManager
	ldmia sp!, {r3, pc}
	arm_func_end MultibootManager__Func_2061C58

	arm_func_start MultibootManager__Func_2061C84
MultibootManager__Func_2061C84: // 0x02061C84
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x350
	bl MIi_CpuClear32
	mov r2, #4
	str r2, [r4]
	mov r3, #0
	str r3, [r4, #4]
	mov r0, #0x16
	str r0, [r4, #8]
	mov r1, #1
	str r1, [r4, #0x10]
	str r3, [r4, #0x28]
	str r3, [r4, #0x2c]
	str r3, [r4, #0x34]
	mov r0, #3
	str r0, [r4, #0x38]
	rsb r0, r1, #0x10000
	add r1, r4, #0x14
	str r3, [r4, #0x308]
	bl MIi_CpuClear16
	mov r0, r4
	bl MultibootManager__Func_2063994
	mov r0, r4
	bl MultibootManager__Func_20639D8
	mov r0, r4
	bl MultibootManager__Func_20639F8
	mov r0, #0
	str r0, [r4, #0xc]
	str r0, [r4, #0x20]
	bl MultibootManager__Func_2063B3C
	cmp r0, #0
	movne r0, #0
	moveq r0, #1
	str r0, [r4, #0x38]
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Func_2061C84

	arm_func_start MultibootManager__Func_2061D1C
MultibootManager__Func_2061D1C: // 0x02061D1C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	str r0, [r4]
	bl MultibootManager__Func_2063B3C
	cmp r0, #0
	movne r0, #0
	moveq r0, #1
	str r0, [r4, #0x38]
	bl WirelessManager__GetField8
	cmp r0, #6
	beq _02061D80
	mov r0, #0
	ldr r1, _02061DF4 // =gameState
	str r0, [r4, #8]
	str r0, [r1, #0x164]
	bl MultibootManager__Func_206789C
	ldr r0, _02061DF8 // =MultibootManager__sVars
	ldr r1, _02061DFC // =MultibootManager__Main_Error
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
_02061D80:
	bl WH_GetCurrentAid
	strh r0, [r4, #0x14]
	ldrh r0, [r4, #0x14]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	str r0, [r4, #0x10]
	bl WirelessManager__Func_20681F8
	ldrh r1, [r4, #0x14]
	bl MultibootManager__Func_2063778
	strh r0, [r4, #0x16]
	bl WirelessManager__ClearSendBuffer
	bl MultibootManager__Func_2067B50
	mov r0, r4
	bl MultibootManager__Func_20639F8
	mov r0, #4
	str r0, [r4, #4]
	mov r0, #0xb
	str r0, [r4, #8]
	mov r0, #0
	str r0, [r4, #0x28]
	str r0, [r4, #0x308]
	mov r1, #1
	str r1, [r4, #0xc]
	ldr r0, _02061DF8 // =MultibootManager__sVars
	ldr r1, _02061E00 // =MultibootManager__Main_2062A2C
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02061DF4: .word gameState
_02061DF8: .word MultibootManager__sVars
_02061DFC: .word MultibootManager__Main_Error
_02061E00: .word MultibootManager__Main_2062A2C
	arm_func_end MultibootManager__Func_2061D1C

	arm_func_start MultibootManager__Func_2061E04
MultibootManager__Func_2061E04: // 0x02061E04
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #2
	str r0, [r4]
	mov r0, #3
	str r0, [r4, #4]
	bl GetINetManagerStatus
	cmp r0, #3
	beq _02061E4C
	bl GetMatchManagerStatus
	cmp r0, #3
	beq _02061E4C
	bl GetConnectionManagerStatus
	cmp r0, #4
	beq _02061E4C
	bl DWC_UpdateConnection
	cmp r0, #0
	beq _02061E5C
_02061E4C:
	mov r0, r4
	mov r1, #0
	bl MultibootManager__Func_20635FC
	ldmia sp!, {r4, pc}
_02061E5C:
	bl DWC_GetNumConnectionHost
	cmp r0, #1
	bgt _02061E84
	mov r1, #0x11
	str r1, [r4, #8]
	ldr r0, _02061F14 // =MultibootManager__sVars
	ldr r1, _02061F18 // =MultibootManager__Main_2062FB8
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
_02061E84:
	mov r0, #1
	str r0, [r4, #0x30c]
	bl MultibootManager__Func_2063B3C
	cmp r0, #0
	movne r0, #0
	moveq r0, #1
	str r0, [r4, #0x38]
	bl DWC_GetMyAID
	strh r0, [r4, #0x14]
	ldrh r0, [r4, #0x14]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	str r0, [r4, #0x10]
	bl DWC_GetAIDBitmap
	ldrh r1, [r4, #0x14]
	bl MultibootManager__Func_2063778
	strh r0, [r4, #0x16]
	bl ClearDataTransferSendBuffer
	bl ClearDataTransferAllBuffers
	mov r0, r4
	bl MultibootManager__Func_20639F8
	mov r1, #0x13
	mov r0, r4
	str r1, [r4, #8]
	bl MultibootManager__Func_2063994
	mov r0, #0
	str r0, [r4, #0x28]
	str r0, [r4, #0x308]
	mov r1, #1
	str r1, [r4, #0xc]
	ldr r0, _02061F14 // =MultibootManager__sVars
	ldr r1, _02061F1C // =MultibootManager__Main_2062CCC
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02061F14: .word MultibootManager__sVars
_02061F18: .word MultibootManager__Main_2062FB8
_02061F1C: .word MultibootManager__Main_2062CCC
	arm_func_end MultibootManager__Func_2061E04

	arm_func_start MultibootManager__Func_2061F20
MultibootManager__Func_2061F20: // 0x02061F20
	stmdb sp!, {r3, lr}
	bl MultibootManager__Func_2061C84
	ldr r0, _02061F3C // =MultibootManager__sVars
	ldr r1, _02061F40 // =MultibootManager__Main
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02061F3C: .word MultibootManager__sVars
_02061F40: .word MultibootManager__Main
	arm_func_end MultibootManager__Func_2061F20

	arm_func_start MultibootManager__Main
MultibootManager__Main: // 0x02061F44
	bx lr
	arm_func_end MultibootManager__Main

	arm_func_start MultibootManager__Main_Error
MultibootManager__Main_Error: // 0x02061F48
	bx lr
	arm_func_end MultibootManager__Main_Error

	arm_func_start MultibootManager__Main_2061F4C
MultibootManager__Main_2061F4C: // 0x02061F4C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02061F9C
	add r0, sp, #4
	bl MultibootManager__Func_20637E8
	ldr r0, [r4, #0x38]
	add r3, sp, #4
	str r0, [sp, #0x18]
	mov r5, #0x18
	mov r0, #0
	mov r1, #1
	mov r2, #0x40
	str r5, [sp]
	bl WirelessManager__Create
	mov r0, #0
	str r0, [r4, #0x28]
_02061F9C:
	bl WirelessManager__GetField8
	cmp r0, #7
	bne _02061FC0
	ldr r4, [r4, #0x38]
	bl MultibootManager__Func_206150C
	mov r0, r4
	bl MultibootManager__Func_2060DE0
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
_02061FC0:
	ldr r1, [r4, #8]
	cmp r1, #1
	beq _02061FE4
	cmp r1, #2
	beq _02062078
	cmp r1, #3
	beq _020620A8
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
_02061FE4:
	cmp r0, #2
	bne _0206205C
	bl WH_GetCurrentAid
	strh r0, [r4, #0x14]
	bl WirelessManager__Func_20681F8
	ldrh r1, [r4, #0x14]
	bl MultibootManager__Func_2063778
	strh r0, [r4, #0x16]
	ldrh r0, [r4, #0x16]
	ldr r1, _020620FC // =0x0000FFFF
	cmp r0, r1
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, pc}
	bl MultibootManager__Func_2067A18
	mov r5, r0
	add r0, r5, #6
	add r1, r4, #0x3c
	mov r2, #0x10
	bl MIi_CpuCopy16
	ldrh r0, [r5, #0x18]
	strh r0, [r4, #0x4c]
	ldrh r0, [r4, #0x16]
	bl MultibootManager__Func_2067A18
	add r1, r4, #0x4e
	mov r2, #6
	bl MI_CpuCopy8
	mov r0, #2
	add sp, sp, #0x1c
	str r0, [r4, #8]
	ldmia sp!, {r4, r5, pc}
_0206205C:
	cmp r0, #1
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r4
	bl MultibootManager__Func_20634D4
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
_02062078:
	cmp r0, #2
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, pc}
	cmp r0, #1
	moveq r0, #1
	addeq sp, sp, #0x1c
	streq r0, [r4, #8]
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r4
	bl MultibootManager__Func_20634D4
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
_020620A8:
	cmp r0, #6
	bne _020620CC
	bl MultibootManager__Func_2063B58
	mov r1, #0
	ldr r0, _02062100 // =MultibootManager__Main_2062A2C
	str r1, [r4, #0xc]
	bl SetCurrentTaskMainEvent
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
_020620CC:
	cmp r0, #2
	addeq sp, sp, #0x1c
	ldmeqia sp!, {r4, r5, pc}
	cmp r0, #1
	moveq r0, #1
	addeq sp, sp, #0x1c
	streq r0, [r4, #8]
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r4
	bl MultibootManager__Func_20634D4
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020620FC: .word 0x0000FFFF
_02062100: .word MultibootManager__Main_2062A2C
	arm_func_end MultibootManager__Main_2061F4C

	arm_func_start MultibootManager__Main_2062104
MultibootManager__Main_2062104: // 0x02062104
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	bl GetCurrentTaskWork_
	mov r5, r0
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _0206214C
	add r0, sp, #8
	bl MultibootManager__Func_20637E8
	mov r4, #0x14
	add r3, sp, #8
	mov r0, #0
	mov r1, #1
	mov r2, #0x40
	str r4, [sp]
	bl WirelessManager__Create2
	mov r0, #0
	str r0, [r5, #0x28]
_0206214C:
	bl WirelessManager__GetField8
	str r0, [sp, #4]
	cmp r0, #7
	bne _0206216C
	bl MultibootManager__Func_206150C
	bl MultibootManager__Func_2060F04
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0206216C:
	ldr r0, [r5, #8]
	cmp r0, #4
	cmpne r0, #5
	addne sp, sp, #0x1c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	bl MultibootManager__Func_20679A8
	mov r7, #0
	mov r6, r0
	mov r9, r5
	add r10, r5, #0x80
	mov r11, r7
_02062198:
	ldr r0, [r9, #0x64]
	tst r0, #1
	beq _02062214
	tst r0, #2
	bne _02062200
	mov r8, r11
	cmp r6, #0
	ble _020621F0
_020621B8:
	mov r0, r8, lsl #0x10
	mov r0, r0, lsr #0x10
	bl MultibootManager__Func_20679B4
	mov r4, r0
	mov r0, r10
	add r1, r4, #4
	bl MultibootManager__Func_20637BC
	cmp r0, #0
	ldrneh r0, [r4, #0xc4]
	strneh r0, [r9, #0x86]
	bne _020621F0
	add r8, r8, #1
	cmp r8, r6
	blt _020621B8
_020621F0:
	cmp r8, r6
	ldrge r0, [r9, #0x64]
	orrge r0, r0, #2
	strge r0, [r9, #0x64]
_02062200:
	add r7, r7, #1
	cmp r7, #8
	add r9, r9, #0x28
	add r10, r10, #0x28
	blt _02062198
_02062214:
	ldr r0, [r5, #8]
	cmp r0, #5
	addne sp, sp, #0x1c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #4]
	cmp r0, #6
	bne _02062264
	bl WH_GetCurrentAid
	strh r0, [r5, #0x14]
	bl WirelessManager__Func_20681F8
	ldrh r1, [r5, #0x14]
	bl MultibootManager__Func_2063778
	strh r0, [r5, #0x16]
	bl MultibootManager__Func_2063B6C
	mov r1, #0
	ldr r0, _020622E0 // =MultibootManager__Main_2062A2C
	str r1, [r5, #0xc]
	bl SetCurrentTaskMainEvent
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02062264:
	mov r6, r5
	add r7, r5, #0x80
	mov r4, #0
_02062270:
	ldr r0, [r6, #0x64]
	tst r0, #1
	moveq r4, #8
	beq _020622C0
	mov r0, r7
	add r1, r5, #0x4e
	bl MultibootManager__Func_20637BC
	cmp r0, #0
	beq _020622AC
	mov r0, #0x28
	mla r0, r4, r0, r5
	ldr r0, [r0, #0x64]
	tst r0, #2
	movne r4, #8
	b _020622C0
_020622AC:
	add r4, r4, #1
	cmp r4, #8
	add r6, r6, #0x28
	add r7, r7, #0x28
	blt _02062270
_020622C0:
	cmp r4, #8
	addlt sp, sp, #0x1c
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r5
	bl MultibootManager__Func_20631BC
	bl MultibootManager__Func_2060F04
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020622E0: .word MultibootManager__Main_2062A2C
	arm_func_end MultibootManager__Main_2062104

	arm_func_start MultibootManager__Main_20622E4
MultibootManager__Main_20622E4: // 0x020622E4
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x28]
	cmp r1, #0
	beq _02062314
	bl MultibootManager__Func_2063874
	add r0, r4, #0x1a4
	mov r1, #0
	bl Task__Unknown2067FA0__Create
	mov r0, #0
	str r0, [r4, #0x28]
_02062314:
	bl WirelessManager__GetField8
	ldr r1, [r4, #8]
	cmp r1, #0xa
	beq _02062340
	cmp r0, #7
	bne _02062340
	ldr r4, [r4, #0x38]
	bl MultibootManager__Func_206150C
	mov r0, r4
	bl MultibootManager__Func_20612D4
	ldmia sp!, {r3, r4, r5, pc}
_02062340:
	cmp r1, #0xa
	addls pc, pc, r1, lsl #2
	ldmia sp!, {r3, r4, r5, pc}
_0206234C: // jump table
	ldmia sp!, {r3, r4, r5, pc} // case 0
	ldmia sp!, {r3, r4, r5, pc} // case 1
	ldmia sp!, {r3, r4, r5, pc} // case 2
	ldmia sp!, {r3, r4, r5, pc} // case 3
	ldmia sp!, {r3, r4, r5, pc} // case 4
	ldmia sp!, {r3, r4, r5, pc} // case 5
	b _02062378 // case 6
	b _02062414 // case 7
	b _02062438 // case 8
	b _02062438 // case 9
	b _02062468 // case 10
_02062378:
	cmp r0, #2
	bne _02062400
	bl WH_GetCurrentAid
	strh r0, [r4, #0x14]
	bl WirelessManager__Func_20681F8
	ldrh r1, [r4, #0x14]
	bl MultibootManager__Func_2063778
	strh r0, [r4, #0x16]
	ldrh r0, [r4, #0x16]
	ldr r1, _0206247C // =0x0000FFFF
	cmp r0, r1
	ldmeqia sp!, {r3, r4, r5, pc}
	bl WirelessManager__Func_20681A0
	mov r5, r0
	add r0, r5, #2
	add r1, r4, #0x3c
	mov r2, #0x10
	bl MIi_CpuCopy16
	ldrb r0, [r5, #1]
	strh r0, [r4, #0x4c]
	ldrh r0, [r4, #0x4c]
	cmp r0, #8
	bls _020623E4
	ldr r1, _02062480 // =0x00002026
	mov r0, #8
	strh r1, [r4, #0x4a]
	strh r0, [r4, #0x4c]
_020623E4:
	add r0, r5, #0x16
	add r1, r4, #0x4e
	mov r2, #6
	bl MI_CpuCopy8
	mov r0, #7
	str r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, pc}
_02062400:
	cmp r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl MultibootManager__Func_20635C4
	ldmia sp!, {r3, r4, r5, pc}
_02062414:
	cmp r0, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	cmp r0, #1
	moveq r0, #6
	streq r0, [r4, #8]
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl MultibootManager__Func_20635C4
	ldmia sp!, {r3, r4, r5, pc}
_02062438:
	cmp r0, #6
	bne _02062450
	mov r0, #0xa
	str r0, [r4, #8]
	bl MultibootManager__Func_2063BA8
	ldmia sp!, {r3, r4, r5, pc}
_02062450:
	cmp r0, #2
	cmpne r0, #3
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl MultibootManager__Func_20635C4
	ldmia sp!, {r3, r4, r5, pc}
_02062468:
	cmp r0, #6
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	bl MultibootManager__Func_20635C4
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206247C: .word 0x0000FFFF
_02062480: .word 0x00002026
	arm_func_end MultibootManager__Main_20622E4

	arm_func_start MultibootManager__Main_2062484
MultibootManager__Main_2062484: // 0x02062484
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _020624CC
	add r0, sp, #4
	bl MultibootManager__Func_20637E8
	bl MultibootManager__Func_2063BBC
	mov ip, #0x14
	add r3, sp, #4
	mov r1, #0
	mov r2, #0x40
	str ip, [sp]
	bl Task__Unknown20674C4__Create
	mov r0, #0
	str r0, [r4, #0x28]
_020624CC:
	bl WirelessManager__GetField8
	cmp r0, #7
	bne _020624E8
	mov r0, r4
	bl MultibootManager__Func_20634D4
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
_020624E8:
	ldr r1, [r4, #8]
	cmp r1, #0xb
	addne sp, sp, #0x18
	ldmneia sp!, {r4, pc}
	cmp r0, #6
	addne sp, sp, #0x18
	ldmneia sp!, {r4, pc}
	bl WH_GetCurrentAid
	strh r0, [r4, #0x14]
	bl WirelessManager__Func_20681F8
	ldrh r1, [r4, #0x14]
	bl MultibootManager__Func_2063778
	strh r0, [r4, #0x16]
	bl MultibootManager__Func_2063B58
	mov r0, #0
	str r0, [r4, #0x308]
	mov r1, #1
	ldr r0, _02062548 // =MultibootManager__sVars
	str r1, [r4, #0xc]
	ldr r0, [r0, #4]
	ldr r1, _0206254C // =MultibootManager__Main_2062A2C
	bl SetTaskMainEvent
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	.align 2, 0
_02062548: .word MultibootManager__sVars
_0206254C: .word MultibootManager__Main_2062A2C
	arm_func_end MultibootManager__Main_2062484

	arm_func_start MultibootManager__Main_2062550
MultibootManager__Main_2062550: // 0x02062550
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02062590
	add r0, sp, #0
	bl MultibootManager__Func_20637E8
	bl MultibootManager__Func_2063BC8
	add r2, sp, #0
	mov r1, #0x40
	mov r3, #0x14
	bl WirelessManager__Create3
	mov r0, #0
	str r0, [r4, #0x28]
_02062590:
	bl WirelessManager__GetField8
	cmp r0, #7
	bne _020625AC
	mov r0, r4
	bl MultibootManager__Func_2063510
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
_020625AC:
	ldr r1, [r4, #8]
	cmp r1, #0xb
	addne sp, sp, #0x14
	ldmneia sp!, {r3, r4, pc}
	cmp r0, #6
	addne sp, sp, #0x14
	ldmneia sp!, {r3, r4, pc}
	bl WH_GetCurrentAid
	strh r0, [r4, #0x14]
	bl WirelessManager__Func_20681F8
	ldrh r1, [r4, #0x14]
	bl MultibootManager__Func_2063778
	strh r0, [r4, #0x16]
	bl MultibootManager__Func_2063B6C
	mov r0, #0
	str r0, [r4, #0x308]
	mov r1, #1
	ldr r0, _0206260C // =MultibootManager__sVars
	str r1, [r4, #0xc]
	ldr r0, [r0, #4]
	ldr r1, _02062610 // =MultibootManager__Main_2062A2C
	bl SetTaskMainEvent
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0206260C: .word MultibootManager__sVars
_02062610: .word MultibootManager__Main_2062A2C
	arm_func_end MultibootManager__Main_2062550

	arm_func_start MultibootManager__Main_2062614
MultibootManager__Main_2062614: // 0x02062614
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02062664
	add r0, sp, #8
	bl MultibootManager__Func_20637E8
	bl MultibootManager__Func_2063BBC
	add r1, sp, #8
	str r1, [sp]
	mov ip, #0x14
	mov r1, #0
	mov r2, #0x200
	mov r3, #0x10
	str ip, [sp, #4]
	bl WirelessManager__Create4
	mov r0, #0
	str r0, [r4, #0x28]
_02062664:
	bl WirelessManager__GetField8
	cmp r0, #7
	bne _02062680
	mov r0, r4
	bl MultibootManager__Func_206354C
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
_02062680:
	ldr r1, [r4, #8]
	cmp r1, #0xd
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, pc}
	cmp r0, #6
	addne sp, sp, #0x1c
	ldmneia sp!, {r3, r4, pc}
	mov r0, #0xe
	str r0, [r4, #8]
	bl MultibootManager__Func_2063B80
	ldr r0, _020626B8 // =MultibootManager__Main_2062F44
	bl SetCurrentTaskMainEvent
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_020626B8: .word MultibootManager__Main_2062F44
	arm_func_end MultibootManager__Main_2062614

	arm_func_start MultibootManager__Main_20626BC
MultibootManager__Main_20626BC: // 0x020626BC
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02062704
	add r0, sp, #4
	bl MultibootManager__Func_20637E8
	bl MultibootManager__Func_2063BC8
	mov ip, #0x14
	add r3, sp, #4
	mov r1, #0x200
	mov r2, #0x10
	str ip, [sp]
	bl WirelessManager__Create5
	mov r0, #0
	str r0, [r4, #0x28]
_02062704:
	bl WirelessManager__GetField8
	ldr r1, [r4, #0x24]
	cmp r0, #7
	add r1, r1, #1
	str r1, [r4, #0x24]
	bne _02062750
	ldr r0, [r4, #0x24]
	cmp r0, #0x1e0
	bhs _02062740
	mov r0, #0
	bl WirelessManager__Func_2067DF4
	mov r0, #1
	add sp, sp, #0x18
	str r0, [r4, #0x28]
	ldmia sp!, {r4, pc}
_02062740:
	mov r0, r4
	bl MultibootManager__Func_2063588
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
_02062750:
	ldr r1, [r4, #8]
	cmp r1, #0xd
	addne sp, sp, #0x18
	ldmneia sp!, {r4, pc}
	cmp r0, #6
	addne sp, sp, #0x18
	ldmneia sp!, {r4, pc}
	mov r0, #0xe
	str r0, [r4, #8]
	bl MultibootManager__Func_2063B94
	ldr r0, _02062788 // =MultibootManager__Main_2062F94
	bl SetCurrentTaskMainEvent
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	.align 2, 0
_02062788: .word MultibootManager__Main_2062F94
	arm_func_end MultibootManager__Main_20626BC

	arm_func_start MultibootManager__Main_206278C
MultibootManager__Main_206278C: // 0x0206278C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _020627B0
	bl CreateINetManager
	mov r0, #0
	str r0, [r4, #0x28]
_020627B0:
	bl GetINetManagerStatus
	cmp r0, #3
	bne _020627CC
	mov r0, r4
	mov r1, #1
	bl MultibootManager__Func_20635FC
	ldmia sp!, {r4, pc}
_020627CC:
	ldr r0, [r4, #8]
	cmp r0, #0xf
	bne _02062800
	bl GetINetManagerStatus
	cmp r0, #2
	ldmneia sp!, {r4, pc}
	mov r1, #0x10
	str r1, [r4, #8]
	mov r1, #1
	ldr r0, _02062810 // =MultibootManager__Main_2062814
	str r1, [r4, #0x28]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
_02062800:
	mov r0, r4
	mov r1, #1
	bl MultibootManager__Func_20635FC
	ldmia sp!, {r4, pc}
	.align 2, 0
_02062810: .word MultibootManager__Main_2062814
	arm_func_end MultibootManager__Main_206278C

	arm_func_start MultibootManager__Main_2062814
MultibootManager__Main_2062814: // 0x02062814
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x14
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x28]
	cmp r0, #0
	beq _02062870
	ldr r0, _020628F0 // =saveGame
	add r1, sp, #0
	mov r2, #0x10
	bl MIi_CpuCopy16
	mov ip, #0
	ldr r0, _020628F4 // =saveGame+0x00000E50
	ldr r1, _020628F8 // =saveGame+0x00000E90
	add r3, sp, #0
	mov r2, #0x1e
	strh ip, [sp, #0x10]
	bl CreateMatchManager
	ldr r0, _020628FC // =SaveGame__DeleteFriendCallback
	mov r1, #0
	bl SetMatchFriendDeleteCallback
	mov r0, #0
	str r0, [r4, #0x28]
_02062870:
	bl GetINetManagerStatus
	cmp r0, #3
	beq _02062894
	bl GetMatchManagerStatus
	cmp r0, #3
	beq _02062894
	bl DWC_UpdateConnection
	cmp r0, #0
	beq _020628A8
_02062894:
	mov r0, r4
	mov r1, #1
	bl MultibootManager__Func_20635FC
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
_020628A8:
	ldr r0, [r4, #8]
	cmp r0, #0x10
	bne _020628DC
	bl GetMatchManagerStatus
	cmp r0, #2
	addne sp, sp, #0x14
	ldmneia sp!, {r3, r4, pc}
	ldr r0, _02062900 // =MultibootManager__Main_2062FB8
	mov r1, #0x11
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
_020628DC:
	mov r0, r4
	mov r1, #1
	bl MultibootManager__Func_20635FC
	add sp, sp, #0x14
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_020628F0: .word saveGame
_020628F4: .word saveGame+0x00000E50
_020628F8: .word saveGame+0x00000E90
_020628FC: .word SaveGame__DeleteFriendCallback
_02062900: .word MultibootManager__Main_2062FB8
	arm_func_end MultibootManager__Main_2062814

	arm_func_start MultibootManager__Main_2062904
MultibootManager__Main_2062904: // 0x02062904
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl GetINetManagerStatus
	cmp r0, #3
	beq _02062940
	bl GetMatchManagerStatus
	cmp r0, #3
	beq _02062940
	bl GetConnectionManagerStatus
	cmp r0, #4
	beq _02062940
	bl DWC_UpdateConnection
	cmp r0, #0
	beq _02062950
_02062940:
	mov r0, r4
	mov r1, #0
	bl MultibootManager__Func_20635FC
	ldmia sp!, {r4, pc}
_02062950:
	ldr r0, [r4, #0x304]
	cmp r0, #0x4b0
	addlo r0, r0, #1
	strlo r0, [r4, #0x304]
	ldr r0, [r4, #8]
	cmp r0, #0x12
	bne _02062A14
	bl GetConnectionManagerStatus
	cmp r0, #3
	bne _020629F0
	bl DestroyConnectionManager
	mov r0, #0x13
	str r0, [r4, #8]
	mov r0, #0
	str r0, [r4, #0x2c]
	str r0, [r4, #0x34]
	bl ClearDataTransferSendBuffer
	bl ClearDataTransferAllBuffers
	mov r0, r4
	bl MultibootManager__Func_20639F8
	mov r0, r4
	bl MultibootManager__Func_2063A2C
	bl DWC_GetMyAID
	strh r0, [r4, #0x14]
	ldrh r0, [r4, #0x14]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	str r0, [r4, #0x10]
	bl DWC_GetAIDBitmap
	ldrh r1, [r4, #0x14]
	bl MultibootManager__Func_2063778
	strh r0, [r4, #0x16]
	bl CreateDataTransferManager
	mov r1, #0
	str r1, [r4, #0x308]
	ldr r0, _02062A24 // =MultibootManager__Main_2062CCC
	str r1, [r4, #0xc]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
_020629F0:
	bl GetConnectionManagerStatus
	cmp r0, #2
	ldmneia sp!, {r4, pc}
	bl DestroyConnectionManager
	mov r1, #0x11
	ldr r0, _02062A28 // =MultibootManager__Main_2062FB8
	str r1, [r4, #8]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
_02062A14:
	mov r0, r4
	mov r1, #1
	bl MultibootManager__Func_20635FC
	ldmia sp!, {r4, pc}
	.align 2, 0
_02062A24: .word MultibootManager__Main_2062CCC
_02062A28: .word MultibootManager__Main_2062FB8
	arm_func_end MultibootManager__Main_2062904

	arm_func_start MultibootManager__Main_2062A2C
MultibootManager__Main_2062A2C: // 0x02062A2C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x30
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__Func_2063034
	cmp r0, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x308]
	cmp r0, #0x1e
	bhi _02062A88
	bhs _02062B28
	cmp r0, #0xa
	bhi _02062A78
	bhs _02062AD4
	cmp r0, #0
	beq _02062AC8
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062A78:
	cmp r0, #0x14
	beq _02062AEC
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062A88:
	cmp r0, #0x32
	bhi _02062AA4
	bhs _02062BE8
	cmp r0, #0x28
	beq _02062BD0
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062AA4:
	cmp r0, #0x3c
	bhi _02062AB8
	beq _02062C10
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062AB8:
	cmp r0, #0x3e8
	beq _02062C28
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062AC8:
	bl MultibootManager__Func_206193C
	mov r0, #0xa
	str r0, [r4, #0x308]
_02062AD4:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	movne r0, #0x14
	add sp, sp, #0x30
	strne r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062AEC:
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, pc}
	add r1, sp, #0
	mov r0, r4
	bl MultibootManager__Func_2063834
	add r0, sp, #0
	mov r1, #0x30
	bl MultibootManager__Func_2061A98
	bl MultibootManager__Func_206193C
	mov r0, #0x1e
	add sp, sp, #0x30
	str r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062B28:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, pc}
	bl MultibootManager__Func_2061BD4
	mov r5, r0
	add r1, r4, #0x3c
	mov r2, #0x10
	bl MIi_CpuCopy16
	ldrh r2, [r5, #0x12]
	add r0, r5, #0x14
	add r1, r4, #0x4e
	strh r2, [r4, #0x4c]
	mov r2, #6
	bl MI_CpuCopy8
	ldr r0, [r5, #0x20]
	str r0, [r4, #0x54]
	bl MultibootManager__Func_2060D28
	cmp r0, #0
	mov r2, #0xc
	bne _02062B8C
	add r0, r5, #0x24
	add r1, r4, #0x58
	bl MI_CpuCopy8
	b _02062B98
_02062B8C:
	add r0, r4, #0x58
	mov r1, #0
	bl MI_CpuFill8
_02062B98:
	ldr r0, [r4, #0x10]
	cmp r0, #0
	ldreq r0, [r5, #0x1c]
	streq r0, [r4, #0x38]
	ldr r0, [r4, #0x38]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bl MultibootManager__Func_2063B0C
	bl MultibootManager__Func_206193C
	mov r0, #0x28
	add sp, sp, #0x30
	str r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062BD0:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	movne r0, #0x32
	add sp, sp, #0x30
	strne r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062BE8:
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, pc}
	bl MultibootManager__Func_2061B3C
	bl MultibootManager__Func_206193C
	mov r0, #0x3c
	add sp, sp, #0x30
	str r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062C10:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	movne r0, #0x3e8
	add sp, sp, #0x30
	strne r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062C28:
	mov r0, #4
	str r0, [r4, #4]
	mov r0, #0xc
	str r0, [r4, #8]
	mov r0, #0
	str r0, [r4, #0x308]
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _02062C58
	ldr r0, _02062CC4 // =MultibootManager__Main_2062F1C
	bl SetCurrentTaskMainEvent
	b _02062C60
_02062C58:
	ldr r0, _02062CC8 // =MultibootManager__Main_2062F30
	bl SetCurrentTaskMainEvent
_02062C60:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	addne sp, sp, #0x30
	ldmneia sp!, {r3, r4, r5, pc}
	ldrh r2, [r4, #0x4c]
	add r0, r4, #0x58
	add r1, r4, #0x3c
	bl MultibootManager__Func_2063BD4
	cmp r0, #0
	bne _02062CB4
	ldr r0, [r4, #0x10]
	cmp r0, #0
	mov r0, r4
	beq _02062CA0
	bl MultibootManager__Func_20634D4
	b _02062CA4
_02062CA0:
	bl MultibootManager__Func_2063510
_02062CA4:
	mov r0, #0x19
	add sp, sp, #0x30
	str r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, pc}
_02062CB4:
	mov r0, #1
	str r0, [r4, #0xc]
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02062CC4: .word MultibootManager__Main_2062F1C
_02062CC8: .word MultibootManager__Main_2062F30
	arm_func_end MultibootManager__Main_2062A2C

	arm_func_start MultibootManager__Main_2062CCC
MultibootManager__Main_2062CCC: // 0x02062CCC
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x30
	bl GetCurrentTaskWork_
	mov r4, r0
	bl MultibootManager__Func_2063248
	cmp r0, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x308]
	cmp r0, #0x1e
	bhi _02062D28
	bhs _02062DC8
	cmp r0, #0xa
	bhi _02062D18
	bhs _02062D74
	cmp r0, #0
	beq _02062D68
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062D18:
	cmp r0, #0x14
	beq _02062D8C
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062D28:
	cmp r0, #0x32
	bhi _02062D44
	bhs _02062E44
	cmp r0, #0x28
	beq _02062E2C
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062D44:
	cmp r0, #0x3c
	bhi _02062D58
	beq _02062E6C
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062D58:
	cmp r0, #0x3e8
	beq _02062E84
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062D68:
	bl MultibootManager__Func_206193C
	mov r0, #0xa
	str r0, [r4, #0x308]
_02062D74:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	movne r0, #0x14
	add sp, sp, #0x30
	strne r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062D8C:
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, pc}
	add r1, sp, #0
	mov r0, r4
	bl MultibootManager__Func_2063834
	add r0, sp, #0
	mov r1, #0x30
	bl MultibootManager__Func_2061A98
	bl MultibootManager__Func_206193C
	mov r0, #0x1e
	add sp, sp, #0x30
	str r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062DC8:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, pc}
	bl MultibootManager__Func_2061BD4
	mov r5, r0
	add r1, r4, #0x3c
	mov r2, #0x10
	bl MIi_CpuCopy16
	ldrh r3, [r5, #0x12]
	add r0, r5, #0x24
	add r1, r4, #0x58
	mov r2, #0xc
	strh r3, [r4, #0x4c]
	bl MI_CpuCopy8
	add r0, r5, #0x14
	add r1, r4, #0x4e
	mov r2, #6
	bl MI_CpuCopy8
	ldr r1, [r5, #0x20]
	mov r0, #0x28
	str r1, [r4, #0x54]
	add sp, sp, #0x30
	str r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062E2C:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	movne r0, #0x32
	add sp, sp, #0x30
	strne r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062E44:
	bl MultibootManager__Func_2061A24
	cmp r0, #0
	addeq sp, sp, #0x30
	ldmeqia sp!, {r3, r4, r5, pc}
	bl MultibootManager__Func_2061B3C
	bl MultibootManager__Func_206193C
	mov r0, #0x3c
	add sp, sp, #0x30
	str r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062E6C:
	bl MultibootManager__Func_20619B4
	cmp r0, #0
	movne r0, #0x3e8
	add sp, sp, #0x30
	strne r0, [r4, #0x308]
	ldmia sp!, {r3, r4, r5, pc}
_02062E84:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bne _02062ED0
	bl MultibootManager__Func_2063AF0
	cmp r0, #0
	beq _02062ED0
	ldrh r2, [r4, #0x4c]
	add r0, r4, #0x58
	add r1, r4, #0x3c
	bl MultibootManager__Func_2063BD4
	cmp r0, #0
	bne _02062ED0
	mov r0, r4
	mov r1, #1
	bl MultibootManager__Func_20635FC
	mov r0, #0x19
	add sp, sp, #0x30
	str r0, [r4, #8]
	ldmia sp!, {r3, r4, r5, pc}
_02062ED0:
	mov r0, #0x14
	str r0, [r4, #8]
	mov r0, #0
	str r0, [r4, #0x308]
	mov r0, #1
	str r0, [r4, #0xc]
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _02062F04
	ldr r0, _02062F14 // =MultibootManager__Main_2062FF8
	bl SetCurrentTaskMainEvent
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
_02062F04:
	ldr r0, _02062F18 // =MultibootManager__Main_206300C
	bl SetCurrentTaskMainEvent
	add sp, sp, #0x30
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02062F14: .word MultibootManager__Main_2062FF8
_02062F18: .word MultibootManager__Main_206300C
	arm_func_end MultibootManager__Main_2062CCC

	arm_func_start MultibootManager__Main_2062F1C
MultibootManager__Main_2062F1C: // 0x02062F1C
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	bl MultibootManager__Func_2063034
	cmp r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MultibootManager__Main_2062F1C

	arm_func_start MultibootManager__Main_2062F30
MultibootManager__Main_2062F30: // 0x02062F30
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	bl MultibootManager__Func_2063034
	cmp r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MultibootManager__Main_2062F30

	arm_func_start MultibootManager__Main_2062F44
MultibootManager__Main_2062F44: // 0x02062F44
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl WirelessManager__GetField8
	cmp r0, #7
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl MultibootManager__Func_206354C
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Main_2062F44

	arm_func_start MultibootManager__Main_2062F68
MultibootManager__Main_2062F68: // 0x02062F68
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl WH_GetConnectBitmap
	bics r0, r0, #1
	ldmneia sp!, {r4, pc}
	mov r0, #0
	bl WirelessManager__Func_2067DF4
	mov r0, r4
	bl MultibootManager__Func_2061F20
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Main_2062F68

	arm_func_start MultibootManager__Main_2062F94
MultibootManager__Main_2062F94: // 0x02062F94
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl WirelessManager__GetField8
	cmp r0, #7
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl MultibootManager__Func_2063588
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Main_2062F94

	arm_func_start MultibootManager__Main_2062FB8
MultibootManager__Main_2062FB8: // 0x02062FB8
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl GetINetManagerStatus
	cmp r0, #3
	beq _02062FE8
	bl GetMatchManagerStatus
	cmp r0, #3
	beq _02062FE8
	bl DWC_UpdateConnection
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
_02062FE8:
	mov r0, r4
	mov r1, #0
	bl MultibootManager__Func_20635FC
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Main_2062FB8

	arm_func_start MultibootManager__Main_2062FF8
MultibootManager__Main_2062FF8: // 0x02062FF8
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	bl MultibootManager__Func_2063248
	cmp r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MultibootManager__Main_2062FF8

	arm_func_start MultibootManager__Main_206300C
MultibootManager__Main_206300C: // 0x0206300C
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	bl MultibootManager__Func_2063248
	cmp r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end MultibootManager__Main_206300C

	arm_func_start MultibootManager__Destructor
MultibootManager__Destructor: // 0x02063020
	ldr r0, _02063030 // =MultibootManager__sVars
	arm_func_end MultibootManager__Destructor

	arm_func_start MultibootManager__Func_2063024
MultibootManager__Func_2063024: // 0x02063024
	mov r1, #0
	str r1, [r0, #4]
	bx lr
	.align 2, 0
_02063030: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2063024

	arm_func_start MultibootManager__Func_2063034
MultibootManager__Func_2063034: // 0x02063034
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	mov r5, #0
	bl WirelessManager__GetField8
	cmp r0, #7
	beq _02063058
	ldr r0, [r4, #0x20]
	cmp r0, #0x258
	blo _0206305C
_02063058:
	mov r5, #1
_0206305C:
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _02063078
	bl WH_GetConnectBitmap
	bl WirelessManager__Func_2068284
	cmp r0, #2
	movlo r5, #1
_02063078:
	cmp r5, #0
	beq _020630DC
	ldr r0, [r4, #0x10]
	cmp r0, #0
	ldr r0, [r4, #8]
	beq _020630B8
	cmp r0, #3
	bne _020630AC
	ldr r4, [r4, #0x38]
	bl MultibootManager__Func_206150C
	mov r0, r4
	bl MultibootManager__Func_2060DE0
	b _020630D4
_020630AC:
	mov r0, r4
	bl MultibootManager__Func_20634D4
	b _020630D4
_020630B8:
	cmp r0, #5
	bne _020630CC
	bl MultibootManager__Func_206150C
	bl MultibootManager__Func_2060F04
	b _020630D4
_020630CC:
	mov r0, r4
	bl MultibootManager__Func_2063510
_020630D4:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
_020630DC:
	bl WirelessManager__GetSendBuffer
	mov r1, #0x78
	strb r1, [r0]
	ldrb r1, [r4, #0x1e]
	strb r1, [r0, #2]
	ldrb r1, [r4, #0x1a]
	strb r1, [r0, #3]
	ldrb r1, [r4, #0x1c]
	add r1, r1, #1
	strb r1, [r4, #0x1c]
	and r1, r1, #0xff
	strb r1, [r0, #1]
	ldrh r0, [r4, #0x14]
	bl WirelessManager__GetRecieveBuffer
	ldrb r1, [r0, #0]
	cmp r1, #0x78
	ldreqb r0, [r0, #2]
	streqb r0, [r4, #0x18]
	ldrh r0, [r4, #0x16]
	bl WirelessManager__GetRecieveBuffer
	ldrb r1, [r0, #0]
	cmp r1, #0x78
	bne _02063178
	ldrb r1, [r0, #2]
	strb r1, [r4, #0x19]
	ldrb r1, [r0, #3]
	strb r1, [r4, #0x1b]
	ldrb r2, [r0, #1]
	ldrb r1, [r4, #0x1d]
	cmp r1, r2
	strneb r2, [r4, #0x1d]
	movne r1, #0
	ldreq r1, [r4, #0x20]
	mov r2, #0x40
	addeq r1, r1, #1
	str r1, [r4, #0x20]
	add r1, r4, #0x310
	bl MIi_CpuCopy32
	b _02063184
_02063178:
	ldr r0, [r4, #0x20]
	add r0, r0, #1
	str r0, [r4, #0x20]
_02063184:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end MultibootManager__Func_2063034

	arm_func_start MultibootManager__Func_206318C
MultibootManager__Func_206318C: // 0x0206318C
	ldr r0, [r0, #4]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end MultibootManager__Func_206318C

	arm_func_start MultibootManager__Func_20631A0
MultibootManager__Func_20631A0: // 0x020631A0
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	bl MultibootManager__Func_206789C
	mov r0, r4
	bl MultibootManager__Func_2061F20
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Func_20631A0

	arm_func_start MultibootManager__Func_20631BC
MultibootManager__Func_20631BC: // 0x020631BC
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	bl MultibootManager__Func_206789C
	mov r0, r4
	bl MultibootManager__Func_2061F20
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Func_20631BC

	arm_func_start MultibootManager__Func_20631D8
MultibootManager__Func_20631D8: // 0x020631D8
	ldr r1, _020631F4 // =MultibootManager__sVars
	mov r2, #0x15
	str r2, [r0, #8]
	ldr r0, [r1, #4]
	ldr ip, _020631F8 // =SetTaskMainEvent
	ldr r1, _020631FC // =MultibootManager__Main_2062F68
	bx ip
	.align 2, 0
_020631F4: .word MultibootManager__sVars
_020631F8: .word SetTaskMainEvent
_020631FC: .word MultibootManager__Main_2062F68
	arm_func_end MultibootManager__Func_20631D8

	arm_func_start MultibootManager__Func_2063200
MultibootManager__Func_2063200: // 0x02063200
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	bl WirelessManager__Func_2067DF4
	mov r0, r4
	bl MultibootManager__Func_2061F20
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Func_2063200

	arm_func_start MultibootManager__Func_206321C
MultibootManager__Func_206321C: // 0x0206321C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WirelessManager__Func_2068060
	mov r0, r4
	bl MultibootManager__Func_2061F20
	bl MultibootManager__Func_2063B3C
	cmp r0, #0
	movne r0, #0
	moveq r0, #1
	str r0, [r4, #0x38]
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Func_206321C

	arm_func_start MultibootManager__Func_2063248
MultibootManager__Func_2063248: // 0x02063248
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetINetManagerStatus
	cmp r0, #3
	beq _02063280
	bl GetMatchManagerStatus
	cmp r0, #3
	beq _02063280
	bl DWC_UpdateConnection
	cmp r0, #0
	bne _02063280
	ldr r0, [r4, #0x20]
	cmp r0, #0x258
	blo _02063294
_02063280:
	mov r0, r4
	mov r1, #0
	bl MultibootManager__Func_20635FC
	mov r0, #0
	ldmia sp!, {r4, pc}
_02063294:
	ldr r0, [r4, #0x30c]
	cmp r0, #0
	beq _020632C0
	bl DWC_GetNumConnectionHost
	cmp r0, #1
	bgt _020632C0
	mov r0, r4
	mov r1, #0
	bl MultibootManager__Func_20635FC
	mov r0, #0
	ldmia sp!, {r4, pc}
_020632C0:
	ldr r0, [r4, #0x2c]
	cmp r0, #0
	bne _020632DC
	mov r0, r4
	bl MultibootManager__Func_2063A60
	cmp r0, #0
	beq _02063348
_020632DC:
	bl GetDataTransferSendBuffer
	mov r1, #0x78
	strb r1, [r0]
	ldrb r1, [r4, #0x1e]
	mov ip, #1
	mov r2, #0
	strb r1, [r0, #2]
	ldrb r1, [r4, #0x1a]
	strb r1, [r0, #3]
	ldrb r1, [r4, #0x1c]
	add r1, r1, #1
	strb r1, [r4, #0x1c]
	and r1, r1, #0xff
	strb r1, [r0, #1]
	ldrh r0, [r4, #0x16]
	ldr r1, [r4, #0x34]
	ldrh r3, [r4, #0x14]
	mov r0, ip, lsl r0
	orr r0, r0, ip, lsl r3
	add r1, r1, #4
	bl SetDataTransferConfig
	mov r1, #0
	str r1, [r4, #0x2c]
	mov r0, r4
	str r1, [r4, #0x34]
	bl MultibootManager__Func_2063A2C
	b _02063350
_02063348:
	mov r0, r4
	bl MultibootManager__Func_2063A38
_02063350:
	ldrh r0, [r4, #0x14]
	bl GetDataTransferRecieveBuffer
	ldrb r1, [r0, #0]
	cmp r1, #0x78
	ldreqb r0, [r0, #2]
	streqb r0, [r4, #0x18]
	ldrh r0, [r4, #0x16]
	bl GetDataTransferRecieveBuffer
	ldrb r1, [r0, #0]
	cmp r1, #0x78
	bne _020633BC
	ldrb r1, [r0, #2]
	strb r1, [r4, #0x19]
	ldrb r1, [r0, #3]
	strb r1, [r4, #0x1b]
	ldrb r2, [r0, #1]
	ldrb r1, [r4, #0x1d]
	cmp r1, r2
	strneb r2, [r4, #0x1d]
	movne r1, #0
	ldreq r1, [r4, #0x20]
	mov r2, #0x40
	addeq r1, r1, #1
	str r1, [r4, #0x20]
	add r1, r4, #0x310
	bl MIi_CpuCopy32
	b _020633C8
_020633BC:
	ldr r0, [r4, #0x20]
	add r0, r0, #1
	str r0, [r4, #0x20]
_020633C8:
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Func_2063248

	arm_func_start MultibootManager__Func_20633D0
MultibootManager__Func_20633D0: // 0x020633D0
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _02063460 // =MultibootManager__sVars
	mov r5, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	ldr r1, _02063464 // =mbRom
	mov r4, r0
	ldr r1, [r1, #4]
	mov r0, r5
	mvn r2, #0
	bl DWC_GetMatchIntValue
	cmp r0, #0
	mvnlt r0, #0
	ldmltia sp!, {r3, r4, r5, pc}
	ldr r1, [r4, #0x300]
	ldr r2, [r4, #0x304]
	subs r1, r0, r1
	ldr r0, _02063468 // =0x0001869F
	rsbmi r1, r1, #0
	cmp r1, r0
	movgt r1, r0
	cmp r2, #0x258
	bhs _0206343C
	cmp r1, #0x3e8
	ldrlt r0, _0206346C // =0x007FFFFF
	movge r0, #0
	ldmia sp!, {r3, r4, r5, pc}
_0206343C:
	cmp r2, #0x4b0
	bhs _02063458
	ldr r0, _02063470 // =0x00000BB8
	cmp r1, r0
	ldrlt r0, _0206346C // =0x007FFFFF
	movge r0, #0
	ldmia sp!, {r3, r4, r5, pc}
_02063458:
	ldr r0, _0206346C // =0x007FFFFF
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02063460: .word MultibootManager__sVars
_02063464: .word mbRom
_02063468: .word 0x0001869F
_0206346C: .word 0x007FFFFF
_02063470: .word 0x00000BB8
	arm_func_end MultibootManager__Func_20633D0

	arm_func_start MultibootManager__Func_2063474
MultibootManager__Func_2063474: // 0x02063474
	stmdb sp!, {r3, r4, r5, lr}
	ldr r1, _020634C0 // =MultibootManager__sVars
	mov r5, r0
	ldr r0, [r1, #4]
	bl GetTaskWork_
	ldr r1, _020634C4 // =mbRom
	mov r4, r0
	ldr r1, [r1, #0]
	ldr r2, _020634C8 // =aNone
	mov r0, r5
	bl DWC_GetMatchStringValue
	ldr r2, [r4, #0x38]
	ldr r1, _020634CC // =0x02119DB8
	ldr r1, [r1, r2, lsl #2]
	bl STD_CompareString
	cmp r0, #0
	mvnne r0, #0
	ldreq r0, _020634D0 // =0x007FFFFF
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_020634C0: .word MultibootManager__sVars
_020634C4: .word mbRom
_020634C8: .word aNone
_020634CC: .word 0x02119DB8
_020634D0: .word 0x007FFFFF
	arm_func_end MultibootManager__Func_2063474

	arm_func_start MultibootManager__Func_20634D4
MultibootManager__Func_20634D4: // 0x020634D4
	stmdb sp!, {r3, lr}
	mov r2, #0
	str r2, [r0, #8]
	ldr r1, _02063504 // =gameState
	mov r0, r2
	str r2, [r1, #0x164]
	bl MultibootManager__Func_206789C
	ldr r0, _02063508 // =MultibootManager__sVars
	ldr r1, _0206350C // =MultibootManager__Main_Error
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02063504: .word gameState
_02063508: .word MultibootManager__sVars
_0206350C: .word MultibootManager__Main_Error
	arm_func_end MultibootManager__Func_20634D4

	arm_func_start MultibootManager__Func_2063510
MultibootManager__Func_2063510: // 0x02063510
	stmdb sp!, {r3, lr}
	mov r2, #0
	str r2, [r0, #8]
	ldr r1, _02063540 // =gameState
	mov r0, r2
	str r2, [r1, #0x164]
	bl MultibootManager__Func_206789C
	ldr r0, _02063544 // =MultibootManager__sVars
	ldr r1, _02063548 // =MultibootManager__Main_Error
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02063540: .word gameState
_02063544: .word MultibootManager__sVars
_02063548: .word MultibootManager__Main_Error
	arm_func_end MultibootManager__Func_2063510

	arm_func_start MultibootManager__Func_206354C
MultibootManager__Func_206354C: // 0x0206354C
	stmdb sp!, {r3, lr}
	mov r2, #0
	str r2, [r0, #8]
	ldr r1, _0206357C // =gameState
	mov r0, r2
	str r2, [r1, #0x164]
	bl WirelessManager__Func_2067DF4
	ldr r0, _02063580 // =MultibootManager__sVars
	ldr r1, _02063584 // =MultibootManager__Main_Error
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206357C: .word gameState
_02063580: .word MultibootManager__sVars
_02063584: .word MultibootManager__Main_Error
	arm_func_end MultibootManager__Func_206354C

	arm_func_start MultibootManager__Func_2063588
MultibootManager__Func_2063588: // 0x02063588
	stmdb sp!, {r3, lr}
	mov r2, #0
	str r2, [r0, #8]
	ldr r1, _020635B8 // =gameState
	mov r0, r2
	str r2, [r1, #0x164]
	bl WirelessManager__Func_2067DF4
	ldr r0, _020635BC // =MultibootManager__sVars
	ldr r1, _020635C0 // =MultibootManager__Main_Error
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_020635B8: .word gameState
_020635BC: .word MultibootManager__sVars
_020635C0: .word MultibootManager__Main_Error
	arm_func_end MultibootManager__Func_2063588

	arm_func_start MultibootManager__Func_20635C4
MultibootManager__Func_20635C4: // 0x020635C4
	stmdb sp!, {r3, lr}
	mov r2, #0
	ldr r1, _020635F0 // =gameState
	str r2, [r0, #8]
	str r2, [r1, #0x164]
	bl WirelessManager__Func_2068060
	ldr r0, _020635F4 // =MultibootManager__sVars
	ldr r1, _020635F8 // =MultibootManager__Main_Error
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_020635F0: .word gameState
_020635F4: .word MultibootManager__sVars
_020635F8: .word MultibootManager__Main_Error
	arm_func_end MultibootManager__Func_20635C4

	arm_func_start MultibootManager__Func_20635FC
MultibootManager__Func_20635FC: // 0x020635FC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r2, #0
	str r2, [r0, #8]
	mov r4, r1
	ldr r2, _020636F8 // =gameState
	mov r3, #1
	ldr r0, _020636FC // =gameState+0x00000160
	add r1, sp, #0
	str r3, [r2, #0x164]
	bl DWC_GetLastErrorEx
	bl DWC_ClearError
	bl DWC_GetInetStatus
	cmp r0, #4
	movne r4, #1
	bl GetINetManagerStatus
	cmp r0, #2
	movne r4, #1
	bl GetMatchManagerStatus
	cmp r0, #2
	movne r4, #1
	bl DWC_UpdateConnection
	cmp r0, #0
	ldr r0, [sp]
	movne r4, #1
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	b _020636BC
_0206366C: // jump table
	b _0206368C // case 0
	b _020636BC // case 1
	b _020636BC // case 2
	b _0206368C // case 3
	b _0206368C // case 4
	b _0206368C // case 5
	b _020636BC // case 6
	b _020636BC // case 7
_0206368C:
	bl DWC_CloseConnectionsAsync
	bl DestroyLeaderboardsManager
	bl DestroyNdManager
	bl DestroyStorageManager
	bl DestroyDataTransferManager
	bl DestroyConnectionManager
	cmp r4, #0
	beq _020636E0
	bl DestroyMatchManager
	mov r0, #0
	bl DestroyINetManager
	b _020636E0
_020636BC:
	bl DWC_CloseConnectionsAsync
	bl DestroyLeaderboardsManager
	bl DestroyNdManager
	bl DestroyStorageManager
	bl DestroyDataTransferManager
	bl DestroyConnectionManager
	bl DestroyMatchManager
	mov r0, #0
	bl DestroyINetManager
_020636E0:
	ldr r0, _02063700 // =MultibootManager__sVars
	ldr r1, _02063704 // =MultibootManager__Main_Error
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_020636F8: .word gameState
_020636FC: .word gameState+0x00000160
_02063700: .word MultibootManager__sVars
_02063704: .word MultibootManager__Main_Error
	arm_func_end MultibootManager__Func_20635FC

	arm_func_start MultibootManager__Func_2063708
MultibootManager__Func_2063708: // 0x02063708
	stmdb sp!, {r3, lr}
	mov r1, #0
	str r1, [r0, #8]
	ldr r2, _02063768 // =gameState
	mov r3, #1
	ldr r0, _0206376C // =gameState+0x00000160
	add r1, sp, #0
	str r3, [r2, #0x164]
	bl DWC_GetLastErrorEx
	bl DWC_ClearError
	bl DWC_CloseConnectionsAsync
	bl DestroyLeaderboardsManager
	bl DestroyNdManager
	bl DestroyStorageManager
	bl DestroyDataTransferManager
	bl DestroyConnectionManager
	bl DestroyMatchManager
	mov r0, #0
	bl DestroyINetManager
	ldr r0, _02063770 // =MultibootManager__sVars
	ldr r1, _02063774 // =MultibootManager__Main_Error
	ldr r0, [r0, #4]
	bl SetTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02063768: .word gameState
_0206376C: .word gameState+0x00000160
_02063770: .word MultibootManager__sVars
_02063774: .word MultibootManager__Main_Error
	arm_func_end MultibootManager__Func_2063708

	arm_func_start MultibootManager__Func_2063778
MultibootManager__Func_2063778: // 0x02063778
	cmp r1, #0x20
	ldrhs r0, _020637B8 // =0x0000FFFF
	bxhs lr
	mov r3, #0
	mov r2, #1
_0206378C:
	cmp r3, r1
	beq _020637A4
	tst r0, r2, lsl r3
	movne r0, r3, lsl #0x10
	movne r0, r0, lsr #0x10
	bxne lr
_020637A4:
	add r3, r3, #1
	cmp r3, #0x20
	blt _0206378C
	ldr r0, _020637B8 // =0x0000FFFF
	bx lr
	.align 2, 0
_020637B8: .word 0x0000FFFF
	arm_func_end MultibootManager__Func_2063778

	arm_func_start MultibootManager__Func_20637BC
MultibootManager__Func_20637BC: // 0x020637BC
	mov ip, #0
_020637C0:
	ldrb r3, [r0, ip]
	ldrb r2, [r1, ip]
	cmp r3, r2
	movne r0, #0
	bxne lr
	add ip, ip, #1
	cmp ip, #6
	blt _020637C0
	mov r0, #1
	bx lr
	arm_func_end MultibootManager__Func_20637BC

	arm_func_start MultibootManager__Func_20637E8
MultibootManager__Func_20637E8: // 0x020637E8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, _02063830 // =saveGame
	mov r1, r5
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, r4
	bl SaveGame__GetPlayerNameLength
	strh r0, [r5, #0x12]
	ldrh r2, [r5, #0x12]
	cmp r2, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r4
	mov r1, r5
	mov r2, r2, lsl #1
	bl MIi_CpuCopy16
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02063830: .word saveGame
	arm_func_end MultibootManager__Func_20637E8

	arm_func_start MultibootManager__Func_2063834
MultibootManager__Func_2063834: // 0x02063834
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	mov r5, r0
	mov r0, r4
	bl MultibootManager__Func_20637E8
	add r0, r4, #0x14
	bl OS_GetMacAddress
	ldr r0, [r5, #0x38]
	str r0, [r4, #0x1c]
	bl SaveGame__GetOnlineScore
	str r0, [r4, #0x20]
	ldr r0, _02063870 // =saveGame+0x00000E50
	add r1, r4, #0x24
	bl DWC_CreateExchangeToken
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02063870: .word saveGame+0x00000E50
	arm_func_end MultibootManager__Func_2063834

	arm_func_start MultibootManager__Func_2063874
MultibootManager__Func_2063874: // 0x02063874
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x1a4
	mov r0, #0
	mov r2, #0x3c
	bl MIi_CpuClear16
	ldr r0, _0206397C // =mbRom
	ldr r0, [r0, #8]
	str r0, [r4, #0x1a4]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _020638D0
_020638AC: // jump table
	b _020638C4 // case 0
	b _020638C4 // case 1
	b _020638C4 // case 2
	b _020638C4 // case 3
	b _020638C4 // case 4
	b _020638C4 // case 5
_020638C4:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _020638D4
_020638D0:
	mov r1, #1
_020638D4:
	ldr r0, _02063980 // =MultibootManager__gameNameList
	mov r2, #0x60
	mla r0, r1, r2, r0
	add r1, r4, #0x1e0
	bl MIi_CpuCopy16
	add r0, r4, #0x1e0
	str r0, [r4, #0x1a8]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0, #0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02063928
_02063904: // jump table
	b _0206391C // case 0
	b _0206391C // case 1
	b _0206391C // case 2
	b _0206391C // case 3
	b _0206391C // case 4
	b _0206391C // case 5
_0206391C:
	bl RenderCore_GetLanguagePtr
	ldrb r1, [r0, #0]
	b _0206392C
_02063928:
	mov r1, #1
_0206392C:
	ldr r0, _02063984 // =MultibootManager__gameDescList
	mov r2, #0xc0
	mla r0, r1, r2, r0
	add r1, r4, #0x240
	bl MIi_CpuCopy16
	add r0, r4, #0x240
	str r0, [r4, #0x1ac]
	ldr r1, [r4, #0x38]
	ldr r0, _02063988 // =0x02119DB0
	ldr r2, _0206398C // =0x02119DA8
	ldr r0, [r0, r1, lsl #2]
	ldr r1, _02063990 // =0x00400342
	str r0, [r4, #0x1b0]
	ldr r3, [r4, #0x38]
	mov r0, #2
	ldr r2, [r2, r3, lsl #2]
	str r2, [r4, #0x1b4]
	str r1, [r4, #0x1b8]
	strb r0, [r4, #0x1bc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206397C: .word mbRom
_02063980: .word MultibootManager__gameNameList
_02063984: .word MultibootManager__gameDescList
_02063988: .word 0x02119DB0
_0206398C: .word 0x02119DA8
_02063990: .word 0x00400342
	arm_func_end MultibootManager__Func_2063874

	arm_func_start MultibootManager__Func_2063994
MultibootManager__Func_2063994: // 0x02063994
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x18
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear16
	add r1, r4, #0x1a
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear16
	add r1, r4, #0x1c
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear16
	mov r0, #0
	strb r0, [r4, #0x1e]
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Func_2063994

	arm_func_start MultibootManager__Func_20639D8
MultibootManager__Func_20639D8: // 0x020639D8
	mov r1, #0
	strh r1, [r0, #0x3c]
	strh r1, [r0, #0x4c]
	ldr ip, _020639F4 // =MI_CpuFill8
	add r0, r0, #0x4e
	mov r2, #6
	bx ip
	.align 2, 0
_020639F4: .word MI_CpuFill8
	arm_func_end MultibootManager__Func_20639D8

	arm_func_start MultibootManager__Func_20639F8
MultibootManager__Func_20639F8: // 0x020639F8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x310
	mov r0, #0
	mov r2, #0x40
	bl MIi_CpuClear32
	mov r0, #0x78
	strb r0, [r4, #0x310]
	mov r0, #0
	strb r0, [r4, #0x312]
	strb r0, [r4, #0x313]
	strb r0, [r4, #0x311]
	ldmia sp!, {r4, pc}
	arm_func_end MultibootManager__Func_20639F8

	arm_func_start MultibootManager__Func_2063A2C
MultibootManager__Func_2063A2C: // 0x02063A2C
	mov r1, #0x10
	str r1, [r0, #0x30]
	bx lr
	arm_func_end MultibootManager__Func_2063A2C

	arm_func_start MultibootManager__Func_2063A38
MultibootManager__Func_2063A38: // 0x02063A38
	ldr r1, [r0, #0x30]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x30]
	bx lr
	arm_func_end MultibootManager__Func_2063A38

	arm_func_start MultibootManager__Func_2063A4C
MultibootManager__Func_2063A4C: // 0x02063A4C
	ldr r0, [r0, #0x30]
	cmp r0, #0xc
	movls r0, #1
	movhi r0, #0
	bx lr
	arm_func_end MultibootManager__Func_2063A4C

	arm_func_start MultibootManager__Func_2063A60
MultibootManager__Func_2063A60: // 0x02063A60
	ldr r0, [r0, #0x30]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end MultibootManager__Func_2063A60

	arm_func_start MultibootManager__Func_2063A74
MultibootManager__Func_2063A74: // 0x02063A74
	cmp r0, #0
	ldreq r0, _02063AA0 // =MultibootManager__sVars
	ldreq r1, [r0, #0]
	biceq r1, r1, #1
	streq r1, [r0]
	bxeq lr
	ldr r0, _02063AA0 // =MultibootManager__sVars
	ldr r1, [r0, #0]
	orr r1, r1, #1
	str r1, [r0]
	bx lr
	.align 2, 0
_02063AA0: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2063A74

	arm_func_start MultibootManager__CheckUsingNetwork
MultibootManager__CheckUsingNetwork: // 0x02063AA4
	ldr r0, _02063ABC // =MultibootManager__sVars
	ldr r0, [r0, #0]
	tst r0, #1
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02063ABC: .word MultibootManager__sVars
	arm_func_end MultibootManager__CheckUsingNetwork

	arm_func_start MultibootManager__Func_2063AC0
MultibootManager__Func_2063AC0: // 0x02063AC0
	cmp r0, #0
	ldreq r0, _02063AEC // =MultibootManager__sVars
	ldreq r1, [r0, #0]
	biceq r1, r1, #2
	streq r1, [r0]
	bxeq lr
	ldr r0, _02063AEC // =MultibootManager__sVars
	ldr r1, [r0, #0]
	orr r1, r1, #2
	str r1, [r0]
	bx lr
	.align 2, 0
_02063AEC: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2063AC0

	arm_func_start MultibootManager__Func_2063AF0
MultibootManager__Func_2063AF0: // 0x02063AF0
	ldr r0, _02063B08 // =MultibootManager__sVars
	ldr r0, [r0, #0]
	tst r0, #2
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02063B08: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2063AF0

	arm_func_start MultibootManager__Func_2063B0C
MultibootManager__Func_2063B0C: // 0x02063B0C
	cmp r0, #0
	ldreq r0, _02063B38 // =MultibootManager__sVars
	ldreq r1, [r0, #0]
	biceq r1, r1, #4
	streq r1, [r0]
	bxeq lr
	ldr r0, _02063B38 // =MultibootManager__sVars
	ldr r1, [r0, #0]
	orr r1, r1, #4
	str r1, [r0]
	bx lr
	.align 2, 0
_02063B38: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2063B0C

	arm_func_start MultibootManager__Func_2063B3C
MultibootManager__Func_2063B3C: // 0x02063B3C
	ldr r0, _02063B54 // =MultibootManager__sVars
	ldr r0, [r0, #0]
	tst r0, #4
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_02063B54: .word MultibootManager__sVars
	arm_func_end MultibootManager__Func_2063B3C

	arm_func_start MultibootManager__Func_2063B58
MultibootManager__Func_2063B58: // 0x02063B58
	ldr ip, _02063B64 // =MultibootManager__Func_2067A48
	ldr r0, _02063B68 // =_02133988
	bx ip
	.align 2, 0
_02063B64: .word MultibootManager__Func_2067A48
_02063B68: .word _02133988
	arm_func_end MultibootManager__Func_2063B58

	arm_func_start MultibootManager__Func_2063B6C
MultibootManager__Func_2063B6C: // 0x02063B6C
	ldr ip, _02063B78 // =MultibootManager__Func_2067A88
	ldr r0, _02063B7C // =_02133990
	bx ip
	.align 2, 0
_02063B78: .word MultibootManager__Func_2067A88
_02063B7C: .word _02133990
	arm_func_end MultibootManager__Func_2063B6C

	arm_func_start MultibootManager__Func_2063B80
MultibootManager__Func_2063B80: // 0x02063B80
	ldr ip, _02063B8C // =WirelessManager__Func_2067F00
	ldr r0, _02063B90 // =_02133988
	bx ip
	.align 2, 0
_02063B8C: .word WirelessManager__Func_2067F00
_02063B90: .word _02133988
	arm_func_end MultibootManager__Func_2063B80

	arm_func_start MultibootManager__Func_2063B94
MultibootManager__Func_2063B94: // 0x02063B94
	ldr ip, _02063BA0 // =WirelessManager__Func_2067F40
	ldr r0, _02063BA4 // =_02133990
	bx ip
	.align 2, 0
_02063BA0: .word WirelessManager__Func_2067F40
_02063BA4: .word _02133990
	arm_func_end MultibootManager__Func_2063B94

	arm_func_start MultibootManager__Func_2063BA8
MultibootManager__Func_2063BA8: // 0x02063BA8
	ldr ip, _02063BB4 // =WirelessManager__Func_2068160
	ldr r0, _02063BB8 // =_02133988
	bx ip
	.align 2, 0
_02063BB4: .word WirelessManager__Func_2068160
_02063BB8: .word _02133988
	arm_func_end MultibootManager__Func_2063BA8

	arm_func_start MultibootManager__Func_2063BBC
MultibootManager__Func_2063BBC: // 0x02063BBC
	ldr r0, _02063BC4 // =_02133988
	bx lr
	.align 2, 0
_02063BC4: .word _02133988
	arm_func_end MultibootManager__Func_2063BBC

	arm_func_start MultibootManager__Func_2063BC8
MultibootManager__Func_2063BC8: // 0x02063BC8
	ldr r0, _02063BD0 // =_02133990
	bx lr
	.align 2, 0
_02063BD0: .word _02133990
	arm_func_end MultibootManager__Func_2063BC8

	arm_func_start MultibootManager__Func_2063BD4
MultibootManager__Func_2063BD4: // 0x02063BD4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl DWC_IsValidFriendData
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r0, r5
	bl SaveGame__GetFriendIndex
	ldr r1, _02063C3C // =0x0000FFFF
	cmp r0, r1
	beq _02063C0C
	bl SaveGame__MoveFriendToFront
	b _02063C28
_02063C0C:
	bl SaveGame__GetFriendCount
	cmp r0, #0x1e
	blo _02063C20
	mov r0, #0x1d
	bl SaveGame__DeleteFriend
_02063C20:
	mov r0, r5
	bl SaveGame__AddFriend
_02063C28:
	mov r0, r4
	bl SaveGame__SetFrontFriendName
	mov r0, #3
	bl TrySaveGameData
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02063C3C: .word 0x0000FFFF
	arm_func_end MultibootManager__Func_2063BD4

	.rodata

// might be part of sysSound, might be part of multibootManager, idk...
// needs to be force included it seems
_02110F44: // 0x02110F44
    .word 0x7FFFFF, 0x1869F

// char16[6][0x30]
.public MultibootManager__gameNameList
MultibootManager__gameNameList: // 0x02110F4C
    .byte 0xBD, 0x30, 0xCB, 0x30, 0xC3, 0x30, 0xAF, 0x30, 0x20
    .byte 0, 0xE9, 0x30, 0xC3, 0x30, 0xB7, 0x30, 0xE5, 0x30
    .byte 0x20, 0, 0xA2, 0x30, 0xC9, 0x30, 0xD9, 0x30, 0xF3
    .byte 0x30, 0xC1, 0x30, 0xE3, 0x30, 0xFC, 0x30, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0x53, 0, 0x4F, 0, 0x4E, 0
    .byte 0x49, 0, 0x43, 0, 0x20, 0, 0x52, 0, 0x55, 0, 0x53
    .byte 0, 0x48, 0, 0x20, 0, 0x41, 0, 0x44, 0, 0x56, 0, 0x45
    .byte 0, 0x4E, 0, 0x54, 0, 0x55, 0, 0x52, 0, 0x45, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0x53, 0, 0x4F, 0, 0x4E, 0, 0x49, 0, 0x43
    .byte 0, 0x20, 0, 0x52, 0, 0x55, 0, 0x53, 0, 0x48, 0, 0x20
    .byte 0, 0x41, 0, 0x44, 0, 0x56, 0, 0x45, 0, 0x4E, 0, 0x54
    .byte 0, 0x55, 0, 0x52, 0, 0x45, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x53
    .byte 0, 0x4F, 0, 0x4E, 0, 0x49, 0, 0x43, 0, 0x20, 0, 0x52
    .byte 0, 0x55, 0, 0x53, 0, 0x48, 0, 0x20, 0, 0x41, 0, 0x44
    .byte 0, 0x56, 0, 0x45, 0, 0x4E, 0, 0x54, 0, 0x55, 0, 0x52
    .byte 0, 0x45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x53, 0, 0x4F, 0, 0x4E
    .byte 0, 0x49, 0, 0x43, 0, 0x20, 0, 0x52, 0, 0x55, 0, 0x53
    .byte 0, 0x48, 0, 0x20, 0, 0x41, 0, 0x44, 0, 0x56, 0, 0x45
    .byte 0, 0x4E, 0, 0x54, 0, 0x55, 0, 0x52, 0, 0x45, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0x53, 0, 0x4F, 0, 0x4E, 0, 0x49, 0, 0x43
    .byte 0, 0x20, 0, 0x52, 0, 0x55, 0, 0x53, 0, 0x48, 0, 0x20
    .byte 0, 0x41, 0, 0x44, 0, 0x56, 0, 0x45, 0, 0x4E, 0, 0x54
    .byte 0, 0x55, 0, 0x52, 0, 0x45, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

// char16[6][0x60]
.public MultibootManager__gameDescList
MultibootManager__gameDescList: // 0x0211118C
    .byte 0x75, 0x30, 0x5F, 0x30, 0x8A, 0x30, 0x67, 0x30, 0x5F
    .byte 0x30, 0x44, 0x30, 0x5B, 0x30, 0x93, 0x30, 1, 0xFF
    .byte 0xA, 0, 0x61, 0x30, 0x87, 0x30, 0x46, 0x30, 0x4A, 0x30
    .byte 0x93, 0x30, 0x5D, 0x30, 0x4F, 0x30, 0xD0, 0x30, 0xC8
    .byte 0x30, 0xEB, 0x30, 0x4B, 0x30, 0x44, 0x30, 0x57, 0x30
    .byte 0x60, 0x30, 1, 0xFF, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x42, 0, 0x41
    .byte 0, 0x54, 0, 0x54, 0, 0x4C, 0, 0x45, 0, 0x20, 0, 0x47
    .byte 0, 0x41, 0, 0x4D, 0, 0x45, 0, 0x20, 0, 0x28, 0, 0x32
    .byte 0, 0x50, 0, 0x29, 0, 0x21, 0, 0x20, 0, 0xA, 0, 0x4C
    .byte 0, 0x45, 0, 0x54, 0, 0x27, 0, 0x53, 0, 0x20, 0, 0x43
    .byte 0, 0x4F, 0, 0x4D, 0, 0x50, 0, 0x45, 0, 0x54, 0, 0x45
    .byte 0, 0x21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x4D, 0, 0x4F, 0
    .byte 0x44, 0, 0x45, 0, 0x20, 0, 0x43, 0, 0x4F, 0, 0x4D
    .byte 0, 0x42, 0, 0x41, 0, 0x54, 0, 0x20, 0, 0x28, 0, 0x32
    .byte 0, 0x4A, 0, 0x29, 0, 0xA, 0, 0xC0, 0, 0x20, 0, 0x4C
    .byte 0, 0x27, 0, 0x20, 0, 0x41, 0, 0x54, 0, 0x54, 0, 0x41
    .byte 0, 0x51, 0, 0x55, 0, 0x45, 0, 0x20, 0, 0x21, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x4B, 0, 0x41, 0, 0x4D
    .byte 0, 0x50, 0, 0x46, 0, 0x53, 0, 0x50, 0, 0x49, 0, 0x45
    .byte 0, 0x4C, 0, 0x20, 0, 0x28, 0, 0x32, 0, 0x53, 0, 0x50
    .byte 0, 0x29, 0, 0x21, 0, 0xA, 0, 0x4C, 0, 0x41, 0, 0x53
    .byte 0, 0x53, 0, 0x20, 0, 0x55, 0, 0x4E, 0, 0x53, 0, 0x20
    .byte 0, 0x4B, 0, 0xC4, 0, 0x4D, 0, 0x50, 0, 0x46, 0, 0x45
    .byte 0, 0x4E, 0, 0x21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x42, 0, 0x41, 0, 0x54
    .byte 0, 0x54, 0, 0x41, 0, 0x47, 0, 0x4C, 0, 0x49, 0, 0x41
    .byte 0, 0x20, 0, 0x28, 0, 0x32, 0, 0x47, 0, 0x29, 0, 0x21
    .byte 0, 0xA, 0, 0x50, 0, 0x52, 0, 0x45, 0, 0x50, 0, 0x41
    .byte 0, 0x52, 0, 0x49, 0, 0x41, 0, 0x4D, 0, 0x4F, 0, 0x43
    .byte 0, 0x49, 0, 0x21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0xA1, 0, 0x42, 0, 0x41, 0, 0x54, 0
    .byte 0x41, 0, 0x4C, 0, 0x4C, 0, 0x41, 0, 0x20, 0, 0x28
    .byte 0, 0x32, 0, 0x4A, 0, 0x29, 0, 0x21, 0, 0xA, 0, 0xA1
    .byte 0, 0x41, 0, 0x20, 0, 0x43, 0, 0x4F, 0, 0x4D, 0, 0x50
    .byte 0, 0x45, 0, 0x54, 0, 0x49, 0, 0x52, 0, 0x21, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    .byte 0

	.data
	
// MBRomInfo mbRom
.public mbRom
mbRom: // 0x02119D9C
	.word aDpKeyMode
	.word aDpKeyScore
	.word aMbContestSrl
	.word aBannerContestR, aBannerContestR_0
	.word aBannerContestR_1, aBannerContestR_2
	.word aDpRace, aDpRing

aDpRace: // 0x02119DC0
	.asciz "dp_race"

aDpRing: // 0x02119DC8
	.asciz "dp_ring"

aDpKeyMode: // 0x02119DD0
	.asciz "dp_key_mode"

aDpKeyScore: // 0x02119DDC
	.asciz "dp_key_score"
	.align 4

aMbContestSrl: // 0x02119DEC
	.asciz "/mb/contest.srl"

aBannerContestR_2: // 0x02119DFC
	.asciz "/banner/contest_ring.nbfc"
	.align 4

aBannerContestR: // 0x02119E18
	.asciz "/banner/contest_race.nbfp"
	.align 4

aBannerContestR_0: // 0x02119E34
	.asciz "/banner/contest_ring.nbfp"
	.align 4

aBannerContestR_1: // 0x02119E50
	.asciz "/banner/contest_race.nbfc"
	.align 4

_02119E6C:
	.asciz " = '"
	.align 4

_02119E74:
	.asciz "'"
	.align 4

aNone: // 0x02119E78
	.asciz "none"
	.align 4