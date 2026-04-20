	.include "asm/macros.inc"
	.include "global.inc"

    .bss

.public whConfig_sChannelBusyRatio
whConfig_sChannelBusyRatio: // 0x02136400
	.space 0x02

.public whConfig_sConnectBitmap
whConfig_sConnectBitmap: // 0x02136402
	.space 0x02

.public whConfig_sChannelIndex
whConfig_sChannelIndex: // 0x02136404
	.space 0x02

.public whConfig_wmMaxParentSize
whConfig_wmMaxParentSize: // 0x02136406
	.space 0x02

.public whConfig_sMyAid
whConfig_sMyAid: // 0x02136408
	.space 0x02

.public whConfig_sChannel
whConfig_sChannel: // 0x0213640A
	.space 0x02

.public whConfig_wmMinDataSize
whConfig_wmMinDataSize: // 0x0213640C
	.space 0x02

.public whConfig_sChannelBitmap
whConfig_sChannelBitmap: // 0x0213640E
	.space 0x02

.public whConfig_wmMaxChildCount
whConfig_wmMaxChildCount: // 0x02136410
	.space 0x02

.public whConfig_sAutoConnectFlag
whConfig_sAutoConnectFlag: // 0x02136412
	.space 0x02

.public whConfig_wmMaxChildSize
whConfig_wmMaxChildSize: // 0x02136414
	.space 0x02
	.align 4

.public whConfig_dword_2136418
whConfig_dword_2136418: // 0x02136418
	.space 0x04

.public whConfig_sSysState
whConfig_sSysState: // 0x0213641C
	.space 0x04

.public whConfig_whAllocFunc
whConfig_whAllocFunc: // 0x02136420
	.space 0x04

.public whConfig_sReceiverFunc
whConfig_sReceiverFunc: // 0x02136424
	.space 0x04

.public whConfig_sScanCallback
whConfig_sScanCallback: // 0x02136428
	.space 0x04

.public whConfig_sConnectMode
whConfig_sConnectMode: // 0x0213642C
	.space 0x04

.public whConfig_sParentWEPKeyGenerator
whConfig_sParentWEPKeyGenerator: // 0x02136430
	.space 0x04

.public whConfig_sRecvBufferSize
whConfig_sRecvBufferSize: // 0x02136434
	.space 0x04

.public whConfig_sPictoCatchFlag
whConfig_sPictoCatchFlag: // 0x02136438
	.space 0x04

.public whConfig_sRand
whConfig_sRand: // 0x0213643C
	.space 0x04

.public whConfig_whFreeFunc
whConfig_whFreeFunc: // 0x02136440
	.space 0x04

.public whConfig_wh_trace
whConfig_wh_trace: // 0x02136444
	.space 0x04

.public whConfig_sSendBufferSize
whConfig_sSendBufferSize: // 0x02136448
	.space 0x04

.public whConfig_sErrCode
whConfig_sErrCode: // 0x0213644C
	.space 0x04

.public whConfig_sJudgeAcceptFunc
whConfig_sJudgeAcceptFunc: // 0x02136450
	.space 0x04

.public whConfig_dword_2136454
whConfig_dword_2136454: // 0x02136454
	.space 0x04

.public whConfig_dword_2136458
whConfig_dword_2136458: // 0x02136458
	.space 0x04

.public whConfig_dword_213645C
whConfig_dword_213645C: // 0x0213645C
	.space 0x04


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

    .text

	arm_func_start WH_GetWMErrCodeName
WH_GetWMErrCodeName: // 0x02069B9C
	cmp r0, #0
	blt _02069BB4
	cmp r0, #0x17
	ldrlo r1, _02069BBC // =WH__errnames
	ldrlo r0, [r1, r0, lsl #2]
	bxlo lr
_02069BB4:
	ldr r0, _02069BC0 // =aNA_0
	bx lr
	.align 2, 0
_02069BBC: .word WH__errnames
_02069BC0: .word aNA_0
	arm_func_end WH_GetWMErrCodeName

	arm_func_start WH_GetWMStateCodeName
WH_GetWMStateCodeName: // 0x02069BC4
	cmp r0, #0x1b
	ldrlo r1, _02069BD8 // =WH__statenames
	ldrlo r0, [r1, r0, lsl #2]
	ldrhs r0, _02069BDC // =0x0211A5C4
	bx lr
	.align 2, 0
_02069BD8: .word WH__statenames
_02069BDC: .word 0x0211A5C4
	arm_func_end WH_GetWMStateCodeName

	arm_func_start WH_ChangeSysState
WH_ChangeSysState: // 0x02069BE0
	stmdb sp!, {r4, lr}
	ldr r1, _02069C34 // =whConfig_sChannelBusyRatio
	mov r4, r0
	ldr r3, [r1, #0x44]
	cmp r3, #0
	beq _02069C0C
	ldr r2, [r1, #0x1c]
	ldr r1, _02069C38 // =WH__sStateNames
	ldr r0, _02069C3C // =aS
	ldr r1, [r1, r2, lsl #2]
	blx r3
_02069C0C:
	ldr r0, _02069C34 // =whConfig_sChannelBusyRatio
	str r4, [r0, #0x1c]
	ldr r2, [r0, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _02069C38 // =WH__sStateNames
	ldr r0, _02069C40 // =aS_0
	ldr r1, [r1, r4, lsl #2]
	blx r2
	ldmia sp!, {r4, pc}
	.align 2, 0
_02069C34: .word whConfig_sChannelBusyRatio
_02069C38: .word WH__sStateNames
_02069C3C: .word aS
_02069C40: .word aS_0
	arm_func_end WH_ChangeSysState

	arm_func_start WH_SetError
WH_SetError: // 0x02069C44
	ldr r1, _02069C5C // =whConfig_sChannelBusyRatio
	ldr r2, [r1, #0x1c]
	sub r2, r2, #9
	cmp r2, #1
	strhi r0, [r1, #0x4c]
	bx lr
	.align 2, 0
_02069C5C: .word whConfig_sChannelBusyRatio
	arm_func_end WH_SetError

	arm_func_start WH_Alloc
WH_Alloc: // 0x02069C60
	stmdb sp!, {r3, lr}
	cmp r2, #0
	bne _02069C84
	ldr r0, _02069C9C // =whConfig_sChannelBusyRatio
	add r2, r1, #3
	ldr r1, [r0, #0x20]
	bic r0, r2, #3
	blx r1
	ldmia sp!, {r3, pc}
_02069C84:
	ldr r1, _02069C9C // =whConfig_sChannelBusyRatio
	mov r0, r2
	ldr r1, [r1, #0x40]
	blx r1
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069C9C: .word whConfig_sChannelBusyRatio
	arm_func_end WH_Alloc

	arm_func_start WH_Free
WH_Free: // 0x02069CA0
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #0]
	cmp r1, #0xe
	ldmneia sp!, {r3, pc}
	ldrh r0, [r0, #4]
	cmp r0, #0xa
	ldmneia sp!, {r3, pc}
	ldr r0, _02069CDC // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _02069CD4
	ldr r0, _02069CE0 // =aWhCallbackforw
	blx r1
_02069CD4:
	bl WFS_Start
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069CDC: .word whConfig_sChannelBusyRatio
_02069CE0: .word aWhCallbackforw
	arm_func_end WH_Free

	arm_func_start WH_StateInSetParentParam
WH_StateInSetParentParam: // 0x02069CE4
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _02069D1C // =WH_StateOutSetParentParam
	ldr r1, _02069D20 // =sParentParam
	bl WM_SetParentParameter
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069D1C: .word WH_StateOutSetParentParam
_02069D20: .word sParentParam
	arm_func_end WH_StateInSetParentParam

	arm_func_start WH_StateOutSetParentParam
WH_StateOutSetParentParam: // 0x02069D24
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _02069D44
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_02069D44:
	ldr r0, _02069D84 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x30]
	cmp r0, #0
	beq _02069D6C
	bl WH_StateInSetParentWEPKey
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_02069D6C:
	bl WH_StateInStartParent
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069D84: .word whConfig_sChannelBusyRatio
	arm_func_end WH_StateOutSetParentParam

	arm_func_start WH_StateInSetParentWEPKey
WH_StateInSetParentWEPKey: // 0x02069D88
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r1, _02069DD8 // =whConfig_sChannelBusyRatio
	ldr r0, _02069DDC // =sWEPKey
	ldr r2, [r1, #0x30]
	ldr r1, _02069DE0 // =sParentParam
	blx r2
	mov r1, r0
	ldr r0, _02069DE4 // =WH_StateOutSetParentWEPKey
	ldr r2, _02069DDC // =sWEPKey
	bl WM_SetWEPKey
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069DD8: .word whConfig_sChannelBusyRatio
_02069DDC: .word sWEPKey
_02069DE0: .word sParentParam
_02069DE4: .word WH_StateOutSetParentWEPKey
	arm_func_end WH_StateInSetParentWEPKey

	arm_func_start WH_StateOutSetParentWEPKey
WH_StateOutSetParentWEPKey: // 0x02069DE8
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _02069E08
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_02069E08:
	bl WH_StateInStartParent
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	arm_func_end WH_StateOutSetParentWEPKey

	arm_func_start WH_StateInStartParent
WH_StateInStartParent: // 0x02069E20
	stmdb sp!, {r3, lr}
	ldr r0, _02069E70 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	sub r0, r0, #4
	cmp r0, #2
	movls r0, #1
	ldmlsia sp!, {r3, pc}
	ldr r0, _02069E74 // =WH_StateOutStartParent
	bl WM_StartParent
	cmp r0, #2
	beq _02069E58
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_02069E58:
	ldr r1, _02069E70 // =whConfig_sChannelBusyRatio
	mov r0, #0
	strh r0, [r1, #8]
	mov r0, #1
	strh r0, [r1, #2]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02069E70: .word whConfig_sChannelBusyRatio
_02069E74: .word WH_StateOutStartParent
	arm_func_end WH_StateInStartParent

	arm_func_start WH_StateOutStartParent
WH_StateOutStartParent: // 0x02069E78
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	ldrh r1, [r4, #0x10]
	ldrh r0, [r4, #2]
	mov r2, #1
	mov r2, r2, lsl r1
	cmp r0, #0
	mov r5, r2, lsl #0x10
	beq _02069EAC
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, r4, r5, pc}
_02069EAC:
	ldrh r3, [r4, #8]
	cmp r3, #7
	bgt _02069EDC
	bge _02069EF8
	cmp r3, #2
	bgt _02069FF0
	cmp r3, #0
	blt _02069FF0
	beq _02069FD8
	cmp r3, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	b _02069FF0
_02069EDC:
	cmp r3, #9
	bgt _02069EEC
	beq _02069F84
	b _02069FF0
_02069EEC:
	cmp r3, #0x1a
	beq _02069FBC
	b _02069FF0
_02069EF8:
	ldr r0, _0206A010 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _02069F10
	ldr r0, _0206A014 // =aStartparentNew
	blx r2
_02069F10:
	ldr r0, _0206A010 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x50]
	cmp r1, #0
	beq _02069F54
	mov r0, r4
	blx r1
	cmp r0, #0
	bne _02069F54
	ldrh r1, [r4, #0x10]
	mov r0, #0
	bl WM_Disconnect
	cmp r0, #2
	ldmeqia sp!, {r3, r4, r5, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, r4, r5, pc}
_02069F54:
	ldr r0, _0206A010 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x2c]
	sub r0, r0, #6
	cmp r0, #1
	bhi _02069F70
	mov r0, r4
	bl WH_Free
_02069F70:
	ldr r0, _0206A010 // =whConfig_sChannelBusyRatio
	ldrh r1, [r0, #2]
	orr r1, r1, r5, lsr #16
	strh r1, [r0, #2]
	ldmia sp!, {r3, r4, r5, pc}
_02069F84:
	ldr r0, _0206A010 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _02069F9C
	ldr r0, _0206A018 // =aStartparentChi
	blx r2
_02069F9C:
	ldr r1, _0206A010 // =whConfig_sChannelBusyRatio
	mvn r2, r5, lsr #16
	ldrh r3, [r1, #2]
	mov r0, r4
	and r2, r3, r2
	strh r2, [r1, #2]
	bl WH_Free
	ldmia sp!, {r3, r4, r5, pc}
_02069FBC:
	ldr r0, _0206A010 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, _0206A01C // =aStartparentChi_0
	blx r2
	ldmia sp!, {r3, r4, r5, pc}
_02069FD8:
	bl WH_StateInStartParentMP
	cmp r0, #0
	ldmneia sp!, {r3, r4, r5, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, r4, r5, pc}
_02069FF0:
	ldr r0, _0206A010 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, _0206A020 // =aUnknownIndicat
	mov r1, r3
	blx r2
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206A010: .word whConfig_sChannelBusyRatio
_0206A014: .word aStartparentNew
_0206A018: .word aStartparentChi
_0206A01C: .word aStartparentChi_0
_0206A020: .word aUnknownIndicat
	arm_func_end WH_StateOutStartParent

	arm_func_start WH_StateInStartParentMP
WH_StateInStartParentMP: // 0x0206A024
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r0, _0206A0C0 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	cmp r0, #4
	cmpne r0, #6
	cmpne r0, #5
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	mov r0, #4
	bl WH_ChangeSysState
	ldr r0, _0206A0C0 // =whConfig_sChannelBusyRatio
	ldr r1, _0206A0C0 // =whConfig_sChannelBusyRatio
	ldrh r0, [r0, #0xb6]
	ldr r3, [r1, #0x48]
	cmp r0, #0
	movne r0, #0
	moveq r0, #1
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r3, lsl #0x10
	mov r0, r0, lsr #0x10
	stmia sp, {r0, r2}
	ldr r1, [r1, #0x34]
	ldr r0, _0206A0C4 // =WH_StateOutStartParentMP
	mov r2, r1, lsl #0x10
	ldr r1, _0206A0C8 // =sRecvBuffer
	ldr r3, _0206A0CC // =sSendBuffer
	mov r2, r2, lsr #0x10
	bl WM_StartMP
	cmp r0, #2
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A0C0: .word whConfig_sChannelBusyRatio
_0206A0C4: .word WH_StateOutStartParentMP
_0206A0C8: .word sRecvBuffer
_0206A0CC: .word sSendBuffer
	arm_func_end WH_StateInStartParentMP

	arm_func_start WH_StateOutStartParentMP
WH_StateOutStartParentMP: // 0x0206A0D0
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _0206A0F4
	mov r0, r1
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A0F4:
	ldrh r1, [r0, #4]
	sub r1, r1, #0xa
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0206A1F4
_0206A108: // jump table
	b _0206A118 // case 0
	ldmia sp!, {r3, pc} // case 1
	b _0206A1F4 // case 2
	b _0206A1F4 // case 3
_0206A118:
	ldr r2, _0206A214 // =whConfig_sChannelBusyRatio
	ldr r1, [r2, #0x2c]
	cmp r1, #2
	bne _0206A170
	ldr r0, [r2, #0x1c]
	cmp r0, #4
	bne _0206A164
	bl WH_StateInStartParentKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, _0206A214 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A158
	ldr r0, _0206A218 // =aWhStateinstart
	blx r1
_0206A158:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A164:
	cmp r0, #6
	bne _0206A1E8
	ldmia sp!, {r3, pc}
_0206A170:
	cmp r1, #4
	bne _0206A1CC
	ldrh r1, [r2, #0x10]
	mov r3, #1
	ldr r0, _0206A21C // =WMDataSharingInfo
	add r1, r1, #1
	mov r1, r3, lsl r1
	str r3, [sp]
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	ldrh r3, [r2, #0xc]
	mov r2, r1, lsr #0x10
	mov r1, #0xd
	bl WM_StartDataSharing
	cmp r0, #0
	beq _0206A1C0
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1C0:
	mov r0, #5
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1CC:
	cmp r1, #6
	bne _0206A1DC
	bl WH_Free
	b _0206A1E8
_0206A1DC:
	cmp r1, #7
	bne _0206A1E8
	bl WH_Free
_0206A1E8:
	mov r0, #4
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A1F4:
	ldr r1, _0206A214 // =whConfig_sChannelBusyRatio
	ldr r2, [r1, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	ldr r0, _0206A220 // =aUnknownIndicat
	blx r2
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A214: .word whConfig_sChannelBusyRatio
_0206A218: .word aWhStateinstart
_0206A21C: .word WMDataSharingInfo
_0206A220: .word aUnknownIndicat
	arm_func_end WH_StateOutStartParentMP

	arm_func_start WH_StateInStartParentKeyShare
WH_StateInStartParentKeyShare: // 0x0206A224
	stmdb sp!, {r3, lr}
	mov r0, #6
	bl WH_ChangeSysState
	ldr r0, _0206A254 // =sWMKeySetBuf
	mov r1, #0xd
	bl WM_StartKeySharing
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A254: .word sWMKeySetBuf
	arm_func_end WH_StateInStartParentKeyShare

	arm_func_start WH_StateInEndParentKeyShare
WH_StateInEndParentKeyShare: // 0x0206A258
	stmdb sp!, {r3, lr}
	ldr r0, _0206A2B0 // =sWMKeySetBuf
	bl WM_EndKeySharing
	cmp r0, #0
	beq _0206A278
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A278:
	bl WH_StateInEndParentMP
	cmp r0, #0
	bne _0206A2A8
	ldr r0, _0206A2B4 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A29C
	ldr r0, _0206A2B8 // =aWhStateinendpa
	blx r1
_0206A29C:
	bl WH_Reset
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A2A8:
	mov r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A2B0: .word sWMKeySetBuf
_0206A2B4: .word whConfig_sChannelBusyRatio
_0206A2B8: .word aWhStateinendpa
	arm_func_end WH_StateInEndParentKeyShare

	arm_func_start WH_StateInEndParentMP
WH_StateInEndParentMP: // 0x0206A2BC
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206A2E8 // =WH_StateOutEndParentMP
	bl WM_EndMP
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A2E8: .word WH_StateOutEndParentMP
	arm_func_end WH_StateInEndParentMP

	arm_func_start WH_StateOutEndParentMP
WH_StateOutEndParentMP: // 0x0206A2EC
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206A308
	bl WH_SetError
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206A308:
	bl WH_StateInEndParent
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, _0206A334 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A32C
	ldr r0, _0206A338 // =aWhStateinendpa_0
	blx r1
_0206A32C:
	bl WH_Reset
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A334: .word whConfig_sChannelBusyRatio
_0206A338: .word aWhStateinendpa_0
	arm_func_end WH_StateOutEndParentMP

	arm_func_start WH_StateInEndParent
WH_StateInEndParent: // 0x0206A33C
	stmdb sp!, {r3, lr}
	ldr r0, _0206A360 // =WH_StateOutEndParent
	bl WM_EndParent
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A360: .word WH_StateOutEndParent
	arm_func_end WH_StateInEndParent

	arm_func_start WH_StateOutEndParent
WH_StateOutEndParent: // 0x0206A364
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206A37C
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206A37C:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	arm_func_end WH_StateOutEndParent

	arm_func_start WH_ChildConnectAuto
WH_ChildConnectAuto: // 0x0206A388
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, r1
	mov r7, r0
	mov r5, r2
	mov r4, r3
	cmp r6, #7
	bne _0206A410
	ldr r0, _0206A518 // =whConfig_sChannelBusyRatio
	ldrh r1, [r0, #6]
	ldrh r0, [r0, #0x14]
	add r1, r1, #0x23
	add r0, r0, #0x21
	bic r1, r1, #0x1f
	bic r0, r0, #0x1f
	cmp r1, r0
	movle r1, r0
	ldr r0, _0206A518 // =whConfig_sChannelBusyRatio
	str r1, [r0, #0x48]
	ldrh r2, [r0, #0x14]
	ldrh r1, [r0, #0x10]
	ldrh r0, [r0, #6]
	add r2, r2, #0xe
	mul r1, r2, r1
	add r1, r1, #0x29
	bic r1, r1, #0x1f
	add r0, r0, #0x55
	bic r0, r0, #0x1f
	mov r1, r1, lsl #1
	cmp r1, r0, lsl #1
	mov r0, r0, lsl #1
	movle r1, r0
	ldr r0, _0206A518 // =whConfig_sChannelBusyRatio
	str r1, [r0, #0x34]
	b _0206A440
_0206A410:
	ldr r0, _0206A518 // =whConfig_sChannelBusyRatio
	ldrh r1, [r0, #0x10]
	ldrh r2, [r0, #0xc]
	add r1, r1, #1
	mul r1, r2, r1
	add r1, r1, #0x59
	bic r1, r1, #0x1f
	mov r3, r1, lsl #1
	add r1, r2, #0x21
	str r3, [r0, #0x34]
	bic r1, r1, #0x1f
	str r1, [r0, #0x48]
_0206A440:
	ldr r0, _0206A518 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206A45C
	ldr r1, [r0, #0x34]
	ldr r0, _0206A51C // =aRecvBufferSize
	blx r2
_0206A45C:
	ldr r0, _0206A518 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206A478
	ldr r1, [r0, #0x48]
	ldr r0, _0206A520 // =aSendBufferSize
	blx r2
_0206A478:
	mov r0, #2
	bl WH_ChangeSysState
	ldr r0, _0206A524 // =sBssDesc+0x00000020
	mov r3, #1
	strh r3, [r0, #0x16]
	ldrh r2, [r5, #4]
	ldr r0, _0206A518 // =whConfig_sChannelBusyRatio
	mov r1, #0
	strh r2, [r0, #0x8c]
	ldrh r2, [r5, #2]
	cmp r6, #7
	strh r2, [r0, #0x8a]
	ldrh r2, [r5, #0]
	strh r2, [r0, #0x88]
	str r6, [r0, #0x2c]
	str r7, [r0, #0x28]
	strh r4, [r0, #4]
	strh r1, [r0, #0x84]
	strh r3, [r0, #0x12]
	bne _0206A4F8
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A4DC
	ldr r0, _0206A528 // =aWfsInitchildCa
	blx r1
_0206A4DC:
	mov r1, #0
	ldr r2, _0206A52C // =WH_Alloc
	mov r3, r1
	mov r0, #1
	bl WFS_InitChild
	mov r0, #1
	bl WFS_SetDebugMode
_0206A4F8:
	bl WH_StateInStartScan
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0206A518: .word whConfig_sChannelBusyRatio
_0206A51C: .word aRecvBufferSize
_0206A520: .word aSendBufferSize
_0206A524: .word sBssDesc+0x00000020
_0206A528: .word aWfsInitchildCa
_0206A52C: .word WH_Alloc
	arm_func_end WH_ChildConnectAuto

	arm_func_start WH_StartScan
WH_StartScan: // 0x0206A530
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _0206A5B0 // =whConfig_sChannelBusyRatio
	mov r5, r0
	ldr r0, [r3, #0x1c]
	mov r4, r1
	mov r6, r2
	cmp r0, #1
	beq _0206A558
	bl OS_Terminate
	movs r0, #0
_0206A558:
	mov r0, #2
	bl WH_ChangeSysState
	ldr r0, _0206A5B0 // =whConfig_sChannelBusyRatio
	mov r1, #0
	str r5, [r0, #0x28]
	strh r6, [r0, #4]
	strh r1, [r0, #0x84]
	strh r1, [r0, #0x12]
	ldrh r1, [r4, #4]
	strh r1, [r0, #0x8c]
	ldrh r1, [r4, #2]
	strh r1, [r0, #0x8a]
	ldrh r1, [r4, #0]
	strh r1, [r0, #0x88]
	bl WH_StateInStartScan
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0206A5B0: .word whConfig_sChannelBusyRatio
	arm_func_end WH_StartScan

	arm_func_start WH_StateInStartScan
WH_StateInStartScan: // 0x0206A5B4
	stmdb sp!, {r3, lr}
	ldr r0, _0206A684 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	cmp r0, #2
	beq _0206A5D0
	bl OS_Terminate
	movs r0, #0
_0206A5D0:
	bl WM_GetAllowedChannel
	cmp r0, #0x8000
	bne _0206A5EC
	mov r0, #3
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A5EC:
	cmp r0, #0
	bne _0206A604
	mov r0, #0x16
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206A604:
	ldr r1, _0206A684 // =whConfig_sChannelBusyRatio
	ldrh r2, [r1, #4]
	cmp r2, #0
	bne _0206A648
	mov ip, #1
	mov r3, ip
_0206A61C:
	ldrh r2, [r1, #0x84]
	add r2, r2, #1
	strh r2, [r1, #0x84]
	ldrh r2, [r1, #0x84]
	cmp r2, #0x10
	strhih ip, [r1, #0x84]
	ldrh r2, [r1, #0x84]
	sub r2, r2, #1
	tst r0, r3, lsl r2
	bne _0206A64C
	b _0206A61C
_0206A648:
	strh r2, [r1, #0x84]
_0206A64C:
	bl WM_GetDispersionScanPeriod
	ldr r2, _0206A684 // =whConfig_sChannelBusyRatio
	ldr r3, _0206A688 // =sBssDesc
	strh r0, [r2, #0x86]
	ldr r0, _0206A68C // =WH_StateOutStartScan
	ldr r1, _0206A690 // =sScanParam
	str r3, [r2, #0x80]
	bl WM_StartScan
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A684: .word whConfig_sChannelBusyRatio
_0206A688: .word sBssDesc
_0206A68C: .word WH_StateOutStartScan
_0206A690: .word sScanParam
	arm_func_end WH_StateInStartScan

	arm_func_start WH_StateOutStartScan
WH_StateOutStartScan: // 0x0206A694
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0206A6C0
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0206A6C0:
	ldr ip, _0206A8B0 // =whConfig_sChannelBusyRatio
	ldr r0, [ip, #0x1c]
	cmp r0, #2
	beq _0206A6F8
	mov r0, #0
	strh r0, [ip, #0x12]
	bl WH_StateInEndScan
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0206A6F8:
	ldrh r0, [r4, #8]
	cmp r0, #3
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, pc}
	cmp r0, #4
	beq _0206A890
	cmp r0, #5
	bne _0206A890
	ldr r0, [ip, #0x44]
	cmp r0, #0
	beq _0206A754
	ldrb r1, [r4, #0xd]
	ldr r0, _0206A8B4 // =aWhStateoutstar
	str r1, [sp]
	ldrb r1, [r4, #0xe]
	str r1, [sp, #4]
	ldrb r1, [r4, #0xf]
	str r1, [sp, #8]
	ldrb r1, [r4, #0xa]
	ldrb r2, [r4, #0xb]
	ldrb r3, [r4, #0xc]
	ldr ip, [ip, #0x44]
	blx ip
_0206A754:
	ldr r0, _0206A8B8 // =sBssDesc
	mov r1, #0xc0
	bl DC_InvalidateRange
	ldr r0, _0206A8B0 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x38]
	cmp r0, #0
	beq _0206A7B8
	ldr r0, _0206A8B8 // =sBssDesc
	bl CHT_IsPictochatParent
	cmp r0, #0
	beq _0206A7B8
	ldr r0, _0206A8B0 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A798
	ldr r0, _0206A8BC // =aPictochatParen
	blx r1
_0206A798:
	ldr r0, _0206A8B0 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x28]
	cmp r2, #0
	beq _0206A890
	ldr r0, _0206A8B8 // =sBssDesc
	mov r1, r4
	blx r2
	b _0206A890
_0206A7B8:
	ldrh r0, [r4, #0x36]
	mov r1, #0
	cmp r0, #0x10
	blo _0206A7D4
	ldrh r0, [r4, #0x38]
	cmp r0, #1
	moveq r1, #1
_0206A7D4:
	cmp r1, #0
	beq _0206A7F0
	ldr r0, _0206A8B0 // =whConfig_sChannelBusyRatio
	ldr r2, [r4, #0x3c]
	ldr r1, [r0, #0xa8]
	cmp r2, r1
	beq _0206A80C
_0206A7F0:
	ldr r0, _0206A8B0 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A890
	ldr r0, _0206A8C0 // =aNotMyParentGgi
	blx r1
	b _0206A890
_0206A80C:
	ldrb r1, [r4, #0x43]
	and r1, r1, #3
	cmp r1, #1
	ldr r1, [r0, #0x44]
	beq _0206A834
	cmp r1, #0
	beq _0206A890
	ldr r0, _0206A8C4 // =aNotReceiveEntr
	blx r1
	b _0206A890
_0206A834:
	cmp r1, #0
	beq _0206A844
	ldr r0, _0206A8C8 // =aParentFind
	blx r1
_0206A844:
	ldr r0, _0206A8B0 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x28]
	cmp r2, #0
	beq _0206A860
	ldr r0, _0206A8B8 // =sBssDesc
	mov r1, r4
	blx r2
_0206A860:
	ldr r0, _0206A8B0 // =whConfig_sChannelBusyRatio
	ldrh r0, [r0, #0x12]
	cmp r0, #0
	beq _0206A890
	bl WH_StateInEndScan
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
_0206A890:
	bl WH_StateInStartScan
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r3, r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0206A8B0: .word whConfig_sChannelBusyRatio
_0206A8B4: .word aWhStateoutstar
_0206A8B8: .word sBssDesc
_0206A8BC: .word aPictochatParen
_0206A8C0: .word aNotMyParentGgi
_0206A8C4: .word aNotReceiveEntr
_0206A8C8: .word aParentFind
	arm_func_end WH_StateOutStartScan

	arm_func_start WH_EndScan
WH_EndScan: // 0x0206A8CC
	stmdb sp!, {r3, lr}
	ldr r1, _0206A8FC // =whConfig_sChannelBusyRatio
	ldr r0, [r1, #0x1c]
	cmp r0, #2
	movne r0, #0
	ldmneia sp!, {r3, pc}
	mov r2, #0
	mov r0, #3
	strh r2, [r1, #0x12]
	bl WH_ChangeSysState
	mov r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A8FC: .word whConfig_sChannelBusyRatio
	arm_func_end WH_EndScan

	arm_func_start WH_StateInEndScan
WH_StateInEndScan: // 0x0206A900
	stmdb sp!, {r3, lr}
	ldr r0, _0206A924 // =WH_StateOutEndScan
	bl WM_EndScan
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A924: .word WH_StateOutEndScan
	arm_func_end WH_StateInEndScan

	arm_func_start WH_StateOutEndScan
WH_StateOutEndScan: // 0x0206A928
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206A940
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206A940:
	mov r0, #1
	bl WH_ChangeSysState
	ldr r0, _0206A9AC // =whConfig_sChannelBusyRatio
	ldrh r1, [r0, #0x12]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, [r0, #0x18]
	cmp r0, #0
	beq _0206A97C
	bl WH_StateInSetChildWEPKey
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206A97C:
	bl WH_StateInStartChild
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, _0206A9AC // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206A9A0
	ldr r0, _0206A9B0 // =aWhStateoutends
	blx r1
_0206A9A0:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206A9AC: .word whConfig_sChannelBusyRatio
_0206A9B0: .word aWhStateoutends
	arm_func_end WH_StateOutEndScan

	arm_func_start WH_StateInSetChildWEPKey
WH_StateInSetChildWEPKey: // 0x0206A9B4
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r1, _0206AA04 // =whConfig_sChannelBusyRatio
	ldr r0, _0206AA08 // =sWEPKey
	ldr r2, [r1, #0x18]
	ldr r1, _0206AA0C // =sBssDesc
	blx r2
	mov r1, r0
	ldr r0, _0206AA10 // =WH_StateOutSetChildWEPKey
	ldr r2, _0206AA08 // =sWEPKey
	bl WM_SetWEPKey
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AA04: .word whConfig_sChannelBusyRatio
_0206AA08: .word sWEPKey
_0206AA0C: .word sBssDesc
_0206AA10: .word WH_StateOutSetChildWEPKey
	arm_func_end WH_StateInSetChildWEPKey

	arm_func_start WH_StateOutSetChildWEPKey
WH_StateOutSetChildWEPKey: // 0x0206AA14
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206AA34
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AA34:
	bl WH_StateInStartChild
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, _0206AA64 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AA58
	ldr r0, _0206AA68 // =aWhStateoutsetc
	blx r1
_0206AA58:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AA64: .word whConfig_sChannelBusyRatio
_0206AA68: .word aWhStateoutsetc
	arm_func_end WH_StateOutSetChildWEPKey

	arm_func_start WH_StateInStartChild
WH_StateInStartChild: // 0x0206AA6C
	stmdb sp!, {r3, lr}
	ldr r0, _0206AAFC // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	cmp r0, #4
	cmpne r0, #6
	cmpne r0, #5
	bne _0206AAA8
	ldr r0, _0206AAFC // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AAA0
	ldr r0, _0206AB00 // =aWhStateinstart_0
	blx r1
_0206AAA0:
	mov r0, #1
	ldmia sp!, {r3, pc}
_0206AAA8:
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206AAFC // =whConfig_sChannelBusyRatio
	ldr r1, _0206AB04 // =sBssDesc
	ldr r0, [r0, #0x18]
	ldr r2, _0206AB08 // =sConnectionSsid
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	mov r0, r0, lsl #0x10
	mov ip, r0, lsr #0x10
	ldr r0, _0206AB0C // =WH_StateOutStartChild
	mov r3, #1
	str ip, [sp]
	bl WM_StartConnectEx
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AAFC: .word whConfig_sChannelBusyRatio
_0206AB00: .word aWhStateinstart_0
_0206AB04: .word sBssDesc
_0206AB08: .word sConnectionSsid
_0206AB0C: .word WH_StateOutStartChild
	arm_func_end WH_StateInStartChild

	arm_func_start WH_StateOutStartChild
WH_StateOutStartChild: // 0x0206AB10
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0206AB74
	bl WH_SetError
	ldrh r0, [r4, #2]
	cmp r0, #0xc
	bne _0206AB40
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB40:
	cmp r0, #0xb
	bne _0206AB54
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB54:
	cmp r0, #1
	bne _0206AB68
	mov r0, #8
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB68:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AB74:
	ldrh r0, [r4, #8]
	cmp r0, #8
	ldmeqia sp!, {r4, pc}
	cmp r0, #7
	bne _0206ABE8
	ldr r0, _0206AC90 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206ABA0
	ldr r0, _0206AC94 // =aConnectToParen
	blx r1
_0206ABA0:
	mov r0, #4
	bl WH_ChangeSysState
	bl WH_StateInStartChildMP
	cmp r0, #0
	bne _0206ABD8
	ldr r0, _0206AC90 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206ABCC
	ldr r0, _0206AC98 // =aWhStateinstart_1
	blx r1
_0206ABCC:
	mov r0, #3
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206ABD8:
	ldrh r1, [r4, #0xa]
	ldr r0, _0206AC90 // =whConfig_sChannelBusyRatio
	strh r1, [r0, #8]
	ldmia sp!, {r4, pc}
_0206ABE8:
	cmp r0, #6
	ldmeqia sp!, {r4, pc}
	cmp r0, #9
	bne _0206AC38
	ldr r0, _0206AC90 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x2c]
	cmp r0, #7
	bne _0206AC0C
	bl WFS_End
_0206AC0C:
	ldr r0, _0206AC90 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AC24
	ldr r0, _0206AC9C // =aDisconnectedFr
	blx r1
_0206AC24:
	mov r0, #0x14
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206AC38:
	cmp r0, #0x1a
	bne _0206AC58
	ldr r0, _0206AC90 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x2c]
	cmp r0, #7
	ldmneia sp!, {r4, pc}
	bl WFS_End
	ldmia sp!, {r4, pc}
_0206AC58:
	ldr r1, _0206AC90 // =whConfig_sChannelBusyRatio
	ldr r1, [r1, #0x44]
	cmp r1, #0
	beq _0206AC84
	bl WH_GetWMStateCodeName
	ldr r3, _0206AC90 // =whConfig_sChannelBusyRatio
	mov r2, r0
	ldrh r1, [r4, #8]
	ldr r3, [r3, #0x44]
	ldr r0, _0206ACA0 // =aUnknownStateDS
	blx r3
_0206AC84:
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206AC90: .word whConfig_sChannelBusyRatio
_0206AC94: .word aConnectToParen
_0206AC98: .word aWhStateinstart_1
_0206AC9C: .word aDisconnectedFr
_0206ACA0: .word aUnknownStateDS
	arm_func_end WH_StateOutStartChild

	arm_func_start WH_StateInStartChildMP
WH_StateInStartChildMP: // 0x0206ACA4
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r2, _0206AD00 // =whConfig_sChannelBusyRatio
	mov r3, #1
	ldr r1, [r2, #0x48]
	ldr r0, _0206AD04 // =WH_StateOutStartChildMP
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	stmia sp, {r1, r3}
	ldr r2, [r2, #0x34]
	ldr r1, _0206AD08 // =sRecvBuffer
	mov r2, r2, lsl #0x10
	ldr r3, _0206AD0C // =sSendBuffer
	mov r2, r2, lsr #0x10
	bl WM_StartMP
	cmp r0, #2
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AD00: .word whConfig_sChannelBusyRatio
_0206AD04: .word WH_StateOutStartChildMP
_0206AD08: .word sRecvBuffer
_0206AD0C: .word sSendBuffer
	arm_func_end WH_StateInStartChildMP

	arm_func_start WH_StateOutStartChildMP
WH_StateOutStartChildMP: // 0x0206AD10
	stmdb sp!, {r3, lr}
	ldrh r1, [r0, #2]
	cmp r1, #0
	beq _0206AD44
	cmp r1, #0xf
	cmpne r1, #9
	cmpne r1, #0xd
	ldmeqia sp!, {r3, pc}
	mov r0, r1
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AD44:
	ldrh r1, [r0, #4]
	sub r1, r1, #0xa
	cmp r1, #3
	addls pc, pc, r1, lsl #2
	b _0206AE40
_0206AD58: // jump table
	b _0206AD68 // case 0
	b _0206AE40 // case 1
	ldmia sp!, {r3, pc} // case 2
	ldmia sp!, {r3, pc} // case 3
_0206AD68:
	ldr r2, _0206AE60 // =whConfig_sChannelBusyRatio
	ldr r1, [r2, #0x2c]
	cmp r1, #3
	bne _0206ADB8
	ldr r0, [r2, #0x1c]
	cmp r0, #6
	ldmeqia sp!, {r3, pc}
	cmp r0, #4
	bne _0206AE34
	bl WH_StateInStartChildKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	ldr r0, _0206AE60 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206ADB0
	ldr r0, _0206AE64 // =aWhStateinstart_2
	blx r1
_0206ADB0:
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206ADB8:
	cmp r1, #5
	bne _0206AE28
	ldrh r1, [r2, #0x10]
	mov r3, #1
	ldr r0, _0206AE68 // =WMDataSharingInfo
	add r1, r1, #1
	mov r1, r3, lsl r1
	str r3, [sp]
	sub r1, r1, #1
	mov r1, r1, lsl #0x10
	ldrh r3, [r2, #0xc]
	mov r2, r1, lsr #0x10
	mov r1, #0xd
	bl WM_StartDataSharing
	cmp r0, #0
	beq _0206AE04
	bl WH_SetError
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206AE04:
	ldr r0, _0206AE60 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206AE1C
	ldr r0, _0206AE6C // =aWhStateoutstar_0
	blx r1
_0206AE1C:
	mov r0, #5
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AE28:
	cmp r1, #7
	bne _0206AE34
	bl WH_Free
_0206AE34:
	mov r0, #4
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206AE40:
	ldr r1, _0206AE60 // =whConfig_sChannelBusyRatio
	ldr r2, [r1, #0x44]
	cmp r2, #0
	ldmeqia sp!, {r3, pc}
	ldrh r1, [r0, #4]
	ldr r0, _0206AE70 // =aUnknownIndicat
	blx r2
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AE60: .word whConfig_sChannelBusyRatio
_0206AE64: .word aWhStateinstart_2
_0206AE68: .word WMDataSharingInfo
_0206AE6C: .word aWhStateoutstar_0
_0206AE70: .word aUnknownIndicat
	arm_func_end WH_StateOutStartChildMP

	arm_func_start WH_StateInStartChildKeyShare
WH_StateInStartChildKeyShare: // 0x0206AE74
	stmdb sp!, {r3, lr}
	ldr r0, _0206AEC4 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	cmp r0, #6
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	cmp r0, #4
	movne r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #6
	bl WH_ChangeSysState
	ldr r0, _0206AEC8 // =sWMKeySetBuf
	mov r1, #0xd
	bl WM_StartKeySharing
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AEC4: .word whConfig_sChannelBusyRatio
_0206AEC8: .word sWMKeySetBuf
	arm_func_end WH_StateInStartChildKeyShare

	arm_func_start WH_StateInEndChildKeyShare
WH_StateInEndChildKeyShare: // 0x0206AECC
	stmdb sp!, {r3, lr}
	ldr r0, _0206AF1C // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	cmp r0, #6
	movne r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206AF20 // =sWMKeySetBuf
	bl WM_EndKeySharing
	cmp r0, #0
	beq _0206AF08
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206AF08:
	bl WH_StateInEndChildMP
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AF1C: .word whConfig_sChannelBusyRatio
_0206AF20: .word sWMKeySetBuf
	arm_func_end WH_StateInEndChildKeyShare

	arm_func_start WH_StateInEndChildMP
WH_StateInEndChildMP: // 0x0206AF24
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206AF50 // =WH_StateOutEndChildMP
	bl WM_EndMP
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AF50: .word WH_StateOutEndChildMP
	arm_func_end WH_StateInEndChildMP

	arm_func_start WH_StateOutEndChildMP
WH_StateOutEndChildMP: // 0x0206AF54
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206AF70
	bl WH_SetError
	bl WH_Finalize
	ldmia sp!, {r3, pc}
_0206AF70:
	bl WH_StateInEndChild
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	arm_func_end WH_StateOutEndChildMP

	arm_func_start WH_StateInEndChild
WH_StateInEndChild: // 0x0206AF88
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206AFBC // =WH_StateOutEndChild
	mov r1, #0
	bl WM_Disconnect
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	bl WH_Reset
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206AFBC: .word WH_StateOutEndChild
	arm_func_end WH_StateInEndChild

	arm_func_start WH_StateOutEndChild
WH_StateOutEndChild: // 0x0206AFC0
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206AFD8
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206AFD8:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	arm_func_end WH_StateOutEndChild

	arm_func_start WH_StateInReset
WH_StateInReset: // 0x0206AFE4
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206B010 // =WH_StateOutReset
	bl WM_Reset
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B010: .word WH_StateOutReset
	arm_func_end WH_StateInReset

	arm_func_start WH_StateOutReset
WH_StateOutReset: // 0x0206B014
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r1, [r4, #2]
	cmp r1, #0
	beq _0206B03C
	mov r0, #9
	bl WH_ChangeSysState
	ldrh r0, [r4, #2]
	bl WH_SetError
	ldmia sp!, {r4, pc}
_0206B03C:
	ldr r1, _0206B060 // =whConfig_sChannelBusyRatio
	ldr r1, [r1, #0x2c]
	sub r1, r1, #6
	cmp r1, #1
	bhi _0206B054
	bl WH_Free
_0206B054:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206B060: .word whConfig_sChannelBusyRatio
	arm_func_end WH_StateOutReset

	arm_func_start WH_StateInSetMPData
WH_StateInSetMPData: // 0x0206B064
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r3, _0206B0FC // =whConfig_sChannelBusyRatio
	mov r6, r0
	mov r5, r1
	ldr r1, [r3, #0x48]
	ldr r0, _0206B100 // =sSendBuffer
	mov r4, r2
	bl DC_FlushRange
	ldr r0, _0206B104 // =0x0000FFFF
	mov ip, #0xe
	str r0, [sp]
	ldr r0, _0206B108 // =WH_StateOutSetMPData
	mov r1, r4
	mov r2, r6
	mov r3, r5
	str ip, [sp, #4]
	mov ip, #2
	str ip, [sp, #8]
	bl WM_SetMPDataToPort
	cmp r0, #2
	beq _0206B0F0
	ldr r1, _0206B0FC // =whConfig_sChannelBusyRatio
	ldr r1, [r1, #0x44]
	cmp r1, #0
	beq _0206B0E4
	bl WH_GetWMErrCodeName
	ldr r2, _0206B0FC // =whConfig_sChannelBusyRatio
	mov r1, r0
	ldr r2, [r2, #0x44]
	ldr r0, _0206B10C // =aWhStateinsetmp
	blx r2
_0206B0E4:
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, pc}
_0206B0F0:
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0206B0FC: .word whConfig_sChannelBusyRatio
_0206B100: .word sSendBuffer
_0206B104: .word 0x0000FFFF
_0206B108: .word WH_StateOutSetMPData
_0206B10C: .word aWhStateinsetmp
	arm_func_end WH_StateInSetMPData

	arm_func_start WH_StateOutSetMPData
WH_StateOutSetMPData: // 0x0206B110
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	cmpne r0, #0xf
	beq _0206B130
	bl WH_SetError
	ldmia sp!, {r4, pc}
_0206B130:
	ldr r1, [r4, #0x20]
	cmp r1, #0
	beq _0206B14C
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	blx r1
_0206B14C:
	ldr r0, _0206B16C // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x2c]
	sub r0, r0, #6
	cmp r0, #1
	ldmhiia sp!, {r4, pc}
	mov r0, r4
	bl WH_Free
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206B16C: .word whConfig_sChannelBusyRatio
	arm_func_end WH_StateOutSetMPData

	arm_func_start WH_PortReceiveCallback
WH_PortReceiveCallback: // 0x0206B170
	stmdb sp!, {r3, lr}
	mov r1, r0
	ldrh r0, [r1, #2]
	cmp r0, #0
	beq _0206B18C
	bl WH_SetError
	ldmia sp!, {r3, pc}
_0206B18C:
	ldr r0, _0206B1D8 // =whConfig_sChannelBusyRatio
	ldr r3, [r0, #0x24]
	cmp r3, #0
	ldmeqia sp!, {r3, pc}
	ldrh r0, [r1, #4]
	cmp r0, #0x15
	bne _0206B1BC
	ldrh r0, [r1, #0x12]
	ldrh r2, [r1, #0x10]
	ldr r1, [r1, #0xc]
	blx r3
	ldmia sp!, {r3, pc}
_0206B1BC:
	cmp r0, #9
	ldmneia sp!, {r3, pc}
	ldrh r0, [r1, #0x12]
	mov r1, #0
	mov r2, r1
	blx r3
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B1D8: .word whConfig_sChannelBusyRatio
	arm_func_end WH_PortReceiveCallback

	arm_func_start WH_StateOutEnd
WH_StateOutEnd: // 0x0206B1DC
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206B1F8
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206B1F8:
	mov r0, #0
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	arm_func_end WH_StateOutEnd

	arm_func_start WH_SetGgid
WH_SetGgid: // 0x0206B204
	ldr r1, _0206B210 // =whConfig_sChannelBusyRatio
	str r0, [r1, #0xa8]
	bx lr
	.align 2, 0
_0206B210: .word whConfig_sChannelBusyRatio
	arm_func_end WH_SetGgid

	arm_func_start WH_SetSsid
WH_SetSsid: // 0x0206B214
	stmdb sp!, {r4, lr}
	mov r4, r1
	cmp r4, #0x18
	movhi r4, #0x18
	ldr r1, _0206B248 // =sConnectionSsid
	mov r2, r4
	bl MI_CpuCopy8
	ldr r0, _0206B248 // =sConnectionSsid
	rsb r2, r4, #0x18
	add r0, r0, r4
	mov r1, #0
	bl MI_CpuFill8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206B248: .word sConnectionSsid
	arm_func_end WH_SetSsid

	arm_func_start WH_SetUserGameInfo
WH_SetUserGameInfo: // 0x0206B24C
	ldr r2, _0206B25C // =whConfig_sChannelBusyRatio
	str r0, [r2, #0xa0]
	strh r1, [r2, #0xa4]
	bx lr
	.align 2, 0
_0206B25C: .word whConfig_sChannelBusyRatio
	arm_func_end WH_SetUserGameInfo

	arm_func_start WH_SetMaxChildCount
WH_SetMaxChildCount: // 0x0206B260
	ldr r1, _0206B26C // =whConfig_sChannelBusyRatio
	strh r0, [r1, #0x10]
	bx lr
	.align 2, 0
_0206B26C: .word whConfig_sChannelBusyRatio
	arm_func_end WH_SetMaxChildCount

	arm_func_start WH_SetMinDataSize
WH_SetMinDataSize: // 0x0206B270
	ldr r1, _0206B27C // =whConfig_sChannelBusyRatio
	strh r0, [r1, #0xc]
	bx lr
	.align 2, 0
_0206B27C: .word whConfig_sChannelBusyRatio
	arm_func_end WH_SetMinDataSize

	arm_func_start WH_SetMaxParentChildSize
WH_SetMaxParentChildSize: // 0x0206B280
	ldr r2, _0206B290 // =whConfig_sChannelBusyRatio
	strh r0, [r2, #6]
	strh r1, [r2, #0x14]
	bx lr
	.align 2, 0
_0206B290: .word whConfig_sChannelBusyRatio
	arm_func_end WH_SetMaxParentChildSize

	arm_func_start WH_GetConnectBitmap
WH_GetConnectBitmap: // 0x0206B294
	ldr r0, _0206B2A0 // =whConfig_sChannelBusyRatio
	ldrh r0, [r0, #2]
	bx lr
	.align 2, 0
_0206B2A0: .word whConfig_sChannelBusyRatio
	arm_func_end WH_GetConnectBitmap

	arm_func_start WH_GetSystemState
WH_GetSystemState: // 0x0206B2A4
	ldr r0, _0206B2B0 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	bx lr
	.align 2, 0
_0206B2B0: .word whConfig_sChannelBusyRatio
	arm_func_end WH_GetSystemState

	arm_func_start WH_GetErrorCode
WH_GetErrorCode: // 0x0206B2B4
	ldr r0, _0206B2C0 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x4c]
	bx lr
	.align 2, 0
_0206B2C0: .word whConfig_sChannelBusyRatio
	arm_func_end WH_GetErrorCode

	arm_func_start WH_StartMeasureChannel
WH_StartMeasureChannel: // 0x0206B2C4
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	add r0, sp, #0
	bl OS_GetMacAddress
	ldr r1, _0206B378 // =0x027FFC3C
	ldrh r0, [sp]
	ldr r2, [r1, #0]
	ldrh r1, [sp, #2]
	add r0, r0, r2
	ldrh r2, [sp, #4]
	add r1, r1, r0
	ldr r0, _0206B37C // =0x00010DCD
	add r1, r2, r1
	mul r0, r1, r0
	add r0, r0, #0x39
	ldr r1, _0206B380 // =whConfig_sChannelBusyRatio
	add r0, r0, #0x3000
	str r0, [r1, #0x3c]
	mov r0, #0
	strh r0, [r1, #0xa]
	mov r2, #0x65
	mov r0, #3
	strh r2, [r1]
	bl WH_ChangeSysState
	mov r0, #1
	bl WH_StateInMeasureChannel
	cmp r0, #0x18
	bne _0206B350
	mov r0, #0x18
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r3, pc}
_0206B350:
	cmp r0, #2
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B378: .word 0x027FFC3C
_0206B37C: .word 0x00010DCD
_0206B380: .word whConfig_sChannelBusyRatio
	arm_func_end WH_StartMeasureChannel

	arm_func_start WH_StateInMeasureChannel
WH_StateInMeasureChannel: // 0x0206B384
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl WM_GetAllowedChannel
	cmp r0, #0x8000
	bne _0206B3B0
	mov r0, #3
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #3
	ldmia sp!, {r4, pc}
_0206B3B0:
	cmp r0, #0
	bne _0206B3D0
	mov r0, #0x16
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0x18
	ldmia sp!, {r4, pc}
_0206B3D0:
	sub r1, r4, #1
	mov r2, #1
	tst r0, r2, lsl r1
	bne _0206B404
_0206B3E0:
	add r1, r4, #1
	mov r1, r1, lsl #0x10
	mov r4, r1, lsr #0x10
	cmp r4, #0x10
	movhi r0, #0x18
	ldmhiia sp!, {r4, pc}
	sub r1, r4, #1
	tst r0, r2, lsl r1
	beq _0206B3E0
_0206B404:
	ldr r0, _0206B41C // =WH_StateOutMeasureChannel
	mov r1, r4
	bl WHi_MeasureChannel
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206B41C: .word WH_StateOutMeasureChannel
	arm_func_end WH_StateInMeasureChannel

	arm_func_start WH_StateOutMeasureChannel
WH_StateOutMeasureChannel: // 0x0206B420
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldrh r0, [r4, #2]
	cmp r0, #0
	beq _0206B444
	bl WH_SetError
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206B444:
	ldr r0, _0206B4E4 // =whConfig_sChannelBusyRatio
	ldr r3, [r0, #0x44]
	cmp r3, #0
	beq _0206B464
	ldrh r1, [r4, #8]
	ldrh r2, [r4, #0xa]
	ldr r0, _0206B4E8 // =aChannelDBratio
	blx r3
_0206B464:
	ldr r0, _0206B4E4 // =whConfig_sChannelBusyRatio
	ldrh r3, [r4, #0xa]
	ldrh r1, [r0, #0]
	ldrh ip, [r4, #8]
	cmp r1, r3
	bls _0206B494
	sub r1, ip, #1
	mov r2, #1
	mov r1, r2, lsl r1
	strh r3, [r0]
	strh r1, [r0, #0xe]
	b _0206B4AC
_0206B494:
	bne _0206B4AC
	ldrh r3, [r0, #0xe]
	sub r1, ip, #1
	mov r2, #1
	orr r1, r3, r2, lsl r1
	strh r1, [r0, #0xe]
_0206B4AC:
	add r0, ip, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl WH_StateInMeasureChannel
	cmp r0, #0x18
	bne _0206B4D0
	mov r0, #7
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
_0206B4D0:
	cmp r0, #2
	ldmeqia sp!, {r4, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206B4E4: .word whConfig_sChannelBusyRatio
_0206B4E8: .word aChannelDBratio
	arm_func_end WH_StateOutMeasureChannel

	arm_func_start WHi_MeasureChannel
WHi_MeasureChannel: // 0x0206B4EC
	stmdb sp!, {r3, lr}
	mov r3, r1
	mov ip, #0x1e
	mov r1, #3
	mov r2, #0x11
	str ip, [sp]
	bl WM_MeasureChannel
	ldmia sp!, {r3, pc}
	arm_func_end WHi_MeasureChannel

	arm_func_start WH_GetMeasureChannel
WH_GetMeasureChannel: // 0x0206B50C
	stmdb sp!, {r3, lr}
	ldr r0, _0206B564 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	cmp r0, #7
	beq _0206B524
	bl OS_Terminate
_0206B524:
	mov r0, #1
	bl WH_ChangeSysState
	ldr r0, _0206B564 // =whConfig_sChannelBusyRatio
	ldrh r0, [r0, #0xe]
	bl WHi_SelectChannel
	ldr r1, _0206B564 // =whConfig_sChannelBusyRatio
	strh r0, [r1, #0xa]
	ldr r2, [r1, #0x44]
	cmp r2, #0
	beq _0206B558
	ldrh r1, [r1, #0xa]
	ldr r0, _0206B568 // =aDecidedChannel
	blx r2
_0206B558:
	ldr r0, _0206B564 // =whConfig_sChannelBusyRatio
	ldrh r0, [r0, #0xa]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B564: .word whConfig_sChannelBusyRatio
_0206B568: .word aDecidedChannel
	arm_func_end WH_GetMeasureChannel

	arm_func_start WHi_SelectChannel
WHi_SelectChannel: // 0x0206B56C
	stmdb sp!, {r3, lr}
	mov r3, #0
	mov r1, r3
	mov lr, r3
	mov ip, #1
_0206B580:
	tst r0, ip, lsl lr
	beq _0206B5A0
	add r3, lr, #1
	add r2, r1, #1
	mov r1, r3, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r1, asr #0x10
	mov r1, r2, lsr #0x10
_0206B5A0:
	add r2, lr, #1
	mov r2, r2, lsl #0x10
	mov lr, r2, asr #0x10
	cmp lr, #0x10
	blt _0206B580
	cmp r1, #1
	movls r0, r3
	ldmlsia sp!, {r3, pc}
	ldr ip, _0206B640 // =whConfig_sChannelBusyRatio
	ldr r3, _0206B644 // =0x00010DCD
	ldr lr, [ip, #0x3c]
	mov r2, #0
	mul r3, lr, r3
	add r3, r3, #0x39
	add lr, r3, #0x3000
	and r3, lr, #0xff
	mul r3, r1, r3
	mov r1, r3, lsl #8
	str lr, [ip, #0x3c]
	mov r3, r1, lsr #0x10
_0206B5F0:
	tst r0, #1
	beq _0206B61C
	cmp r3, #0
	bne _0206B610
	add r0, r2, #1
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	ldmia sp!, {r3, pc}
_0206B610:
	sub r1, r3, #1
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
_0206B61C:
	add r1, r2, #1
	mov r1, r1, lsl #0x10
	mov r0, r0, lsl #0xf
	mov r2, r1, asr #0x10
	cmp r2, #0x10
	mov r0, r0, lsr #0x10
	blt _0206B5F0
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B640: .word whConfig_sChannelBusyRatio
_0206B644: .word 0x00010DCD
	arm_func_end WHi_SelectChannel

	arm_func_start WH_Initialize
WH_Initialize: // 0x0206B648
	stmdb sp!, {r3, lr}
	ldr r3, _0206B6D0 // =whConfig_sChannelBusyRatio
	mov r1, #0
	str r1, [r3, #0x34]
	str r1, [r3, #0x48]
	str r1, [r3, #0x24]
	strh r1, [r3, #8]
	mov r0, #1
	strh r0, [r3, #2]
	str r1, [r3, #0x4c]
	str r1, [r3, #0xa0]
	ldr r0, _0206B6D4 // =sConnectionSsid
	mov r2, #0x18
	strh r1, [r3, #0xa4]
	bl MI_CpuFill8
	ldr r3, _0206B6D0 // =whConfig_sChannelBusyRatio
	mov r1, #0
	ldr r0, _0206B6D8 // =WMDataSharingInfo
	mov r2, #0x820
	str r1, [r3, #0x50]
	bl MI_CpuFill8
	ldr r0, _0206B6DC // =sDataSet
	mov r1, #0
	mov r2, #0x200
	bl MI_CpuFill8
	ldr r0, _0206B6E0 // =sWMKeySetBuf
	mov r1, #0
	mov r2, #0x820
	bl MI_CpuFill8
	bl WH_StateInInitialize
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B6D0: .word whConfig_sChannelBusyRatio
_0206B6D4: .word sConnectionSsid
_0206B6D8: .word WMDataSharingInfo
_0206B6DC: .word sDataSet
_0206B6E0: .word sWMKeySetBuf
	arm_func_end WH_Initialize

	arm_func_start WH_IndicateHandler
WH_IndicateHandler: // 0x0206B6E4
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #8
	ldmneia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	bl OS_Terminate
	arm_func_end WH_IndicateHandler

	arm_func_start sub_206b700
sub_206b700: // 0x0206B700
	ldmia sp!, {r3, pc}
	arm_func_end sub_206b700

	arm_func_start WH_StateInInitialize
WH_StateInInitialize: // 0x0206B704
	stmdb sp!, {r3, lr}
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206B740 // =sWmBuffer
	ldr r1, _0206B744 // =WH_StateOutInitialize
	mov r2, #2
	bl WM_Initialize
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	bl WH_SetError
	mov r0, #0xa
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B740: .word sWmBuffer
_0206B744: .word WH_StateOutInitialize
	arm_func_end WH_StateInInitialize

	arm_func_start WH_StateOutInitialize
WH_StateOutInitialize: // 0x0206B748
	stmdb sp!, {r3, lr}
	ldrh r0, [r0, #2]
	cmp r0, #0
	beq _0206B768
	bl WH_SetError
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206B768:
	ldr r0, _0206B794 // =WH_IndicateHandler
	bl WM_SetIndCallback
	cmp r0, #0
	beq _0206B788
	bl WH_SetError
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
_0206B788:
	mov r0, #1
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206B794: .word WH_IndicateHandler
	arm_func_end WH_StateOutInitialize

	arm_func_start WH_ParentConnect
WH_ParentConnect: // 0x0206B798
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	ldr r3, _0206B9EC // =whConfig_sChannelBusyRatio
	mov r6, r0
	ldr r0, [r3, #0x1c]
	mov r5, r1
	mov r4, r2
	cmp r0, #1
	beq _0206B7C4
	bl OS_Terminate
	movs r0, #0
_0206B7C4:
	cmp r6, #6
	bne _0206B838
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	ldrh r1, [r0, #6]
	ldrh r0, [r0, #0x14]
	add r1, r1, #0x23
	add r0, r0, #0x21
	bic r1, r1, #0x1f
	bic r0, r0, #0x1f
	cmp r1, r0
	movle r1, r0
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	str r1, [r0, #0x48]
	ldrh r2, [r0, #0x14]
	ldrh r1, [r0, #0x10]
	ldrh r0, [r0, #6]
	add r2, r2, #0xe
	mul r1, r2, r1
	add r1, r1, #0x29
	bic r1, r1, #0x1f
	add r0, r0, #0x55
	bic r0, r0, #0x1f
	mov r1, r1, lsl #1
	cmp r1, r0, lsl #1
	mov r0, r0, lsl #1
	movle r1, r0
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	str r1, [r0, #0x34]
	b _0206B870
_0206B838:
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	ldrh r2, [r0, #0xc]
	ldrh r1, [r0, #0x10]
	add r3, r2, #0xe
	mul ip, r3, r1
	add r1, r1, #1
	mul r1, r2, r1
	add r2, ip, #0x29
	bic r2, r2, #0x1f
	mov r2, r2, lsl #1
	add r1, r1, #0x27
	str r2, [r0, #0x34]
	bic r1, r1, #0x1f
	str r1, [r0, #0x48]
_0206B870:
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206B88C
	ldr r1, [r0, #0x34]
	ldr r0, _0206B9F0 // =aRecvBufferSize
	blx r2
_0206B88C:
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206B8A8
	ldr r1, [r0, #0x48]
	ldr r0, _0206B9F4 // =aSendBufferSize
	blx r2
_0206B8A8:
	ldr r1, _0206B9EC // =whConfig_sChannelBusyRatio
	mov r0, #3
	str r6, [r1, #0x2c]
	bl WH_ChangeSysState
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	strh r5, [r0, #0xac]
	strh r4, [r0, #0xd2]
	bl WM_GetDispersionBeaconPeriod
	ldr r1, _0206B9EC // =whConfig_sChannelBusyRatio
	cmp r6, #6
	strh r0, [r1, #0xb8]
	bne _0206B8EC
	ldrh r0, [r1, #6]
	strh r0, [r1, #0xd4]
	ldrh r0, [r1, #0x14]
	strh r0, [r1, #0xd6]
	b _0206B908
_0206B8EC:
	ldrh r0, [r1, #0x10]
	ldrh r2, [r1, #0xc]
	add r0, r0, #1
	mul r0, r2, r0
	add r0, r0, #4
	strh r0, [r1, #0xd4]
	strh r2, [r1, #0xd6]
_0206B908:
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	cmp r6, #6
	ldrh r1, [r0, #0x10]
	moveq r2, #1
	movne r2, #0
	strh r1, [r0, #0xb0]
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	mov r1, #0
	strh r2, [r0, #0xb6]
	strh r1, [r0, #0xb2]
	mov r2, #1
	strh r2, [r0, #0xae]
	cmp r6, #2
	movne r2, r1
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	cmp r6, #6
	strh r2, [r0, #0xb4]
	addls pc, pc, r6, lsl #2
	b _0206B9C4
_0206B954: // jump table
	b _0206B9B8 // case 0
	b _0206B9C4 // case 1
	b _0206B9B8 // case 2
	b _0206B9C4 // case 3
	b _0206B9B8 // case 4
	b _0206B9C4 // case 5
	b _0206B970 // case 6
_0206B970:
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206B984
	ldr r0, _0206B9F8 // =aWfsInitparentC
	blx r1
_0206B984:
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	mov r1, #0
	ldrh r0, [r0, #6]
	ldr r2, _0206B9FC // =WH_Alloc
	mov r3, r1
	stmia sp, {r0, r1}
	mov r0, #1
	str r0, [sp, #8]
	bl WFS_InitParent
	mov r0, #1
	bl WFS_SetDebugMode
	mov r0, #0
	bl WFS_EnableSync
_0206B9B8:
	bl WH_StateInSetParentParam
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
_0206B9C4:
	ldr r0, _0206B9EC // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206B9E0
	ldr r0, _0206BA00 // =aUnknownConnect
	mov r1, r6
	blx r2
_0206B9E0:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0206B9EC: .word whConfig_sChannelBusyRatio
_0206B9F0: .word aRecvBufferSize
_0206B9F4: .word aSendBufferSize
_0206B9F8: .word aWfsInitparentC
_0206B9FC: .word WH_Alloc
_0206BA00: .word aUnknownConnect
	arm_func_end WH_ParentConnect

	arm_func_start WH_ChildConnect
WH_ChildConnect: // 0x0206BA04
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _0206BBD8 // =whConfig_sChannelBusyRatio
	mov r5, r0
	ldr r0, [r2, #0x1c]
	mov r4, r1
	cmp r0, #1
	beq _0206BA28
	bl OS_Terminate
	movs r0, #0
_0206BA28:
	cmp r5, #7
	bne _0206BA9C
	ldr r0, _0206BBD8 // =whConfig_sChannelBusyRatio
	ldrh r1, [r0, #6]
	ldrh r0, [r0, #0x14]
	add r1, r1, #0x23
	add r0, r0, #0x21
	bic r1, r1, #0x1f
	bic r0, r0, #0x1f
	cmp r1, r0
	movle r1, r0
	ldr r0, _0206BBD8 // =whConfig_sChannelBusyRatio
	str r1, [r0, #0x48]
	ldrh r2, [r0, #0x14]
	ldrh r1, [r0, #0x10]
	ldrh r0, [r0, #6]
	add r2, r2, #0xe
	mul r1, r2, r1
	add r1, r1, #0x29
	bic r1, r1, #0x1f
	add r0, r0, #0x55
	bic r0, r0, #0x1f
	mov r1, r1, lsl #1
	cmp r1, r0, lsl #1
	mov r0, r0, lsl #1
	movle r1, r0
	ldr r0, _0206BBD8 // =whConfig_sChannelBusyRatio
	str r1, [r0, #0x34]
	b _0206BACC
_0206BA9C:
	ldr r0, _0206BBD8 // =whConfig_sChannelBusyRatio
	ldrh r1, [r0, #0x10]
	ldrh r2, [r0, #0xc]
	add r1, r1, #1
	mul r1, r2, r1
	add r1, r1, #0x59
	bic r1, r1, #0x1f
	mov r3, r1, lsl #1
	add r1, r2, #0x21
	str r3, [r0, #0x34]
	bic r1, r1, #0x1f
	str r1, [r0, #0x48]
_0206BACC:
	ldr r0, _0206BBD8 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BAE8
	ldr r1, [r0, #0x34]
	ldr r0, _0206BBDC // =aRecvBufferSize
	blx r2
_0206BAE8:
	ldr r0, _0206BBD8 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BB04
	ldr r1, [r0, #0x48]
	ldr r0, _0206BBE0 // =aSendBufferSize
	blx r2
_0206BB04:
	ldr r1, _0206BBD8 // =whConfig_sChannelBusyRatio
	mov r0, #3
	str r5, [r1, #0x2c]
	bl WH_ChangeSysState
	cmp r5, #7
	addls pc, pc, r5, lsl #2
	b _0206BBB4
_0206BB20: // jump table
	b _0206BBB4 // case 0
	b _0206BB74 // case 1
	b _0206BBB4 // case 2
	b _0206BB74 // case 3
	b _0206BBB4 // case 4
	b _0206BB74 // case 5
	b _0206BBB4 // case 6
	b _0206BB40 // case 7
_0206BB40:
	ldr r0, _0206BBD8 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206BB58
	ldr r0, _0206BBE4 // =aWfsInitchildCa
	blx r1
_0206BB58:
	mov r1, #0
	ldr r2, _0206BBE8 // =WH_Alloc
	mov r3, r1
	mov r0, #1
	bl WFS_InitChild
	mov r0, #1
	bl WFS_SetDebugMode
_0206BB74:
	ldr r1, _0206BBEC // =sBssDesc
	mov r0, r4
	mov r2, #0xc0
	bl MI_CpuCopy8
	ldr r0, _0206BBEC // =sBssDesc
	mov r1, #0xc0
	bl DC_FlushRange
	bl DC_WaitWriteBufferEmpty
	ldr r0, _0206BBD8 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x18]
	cmp r0, #0
	beq _0206BBAC
	bl WH_StateInSetChildWEPKey
	ldmia sp!, {r3, r4, r5, pc}
_0206BBAC:
	bl WH_StateInStartChild
	ldmia sp!, {r3, r4, r5, pc}
_0206BBB4:
	ldr r0, _0206BBD8 // =whConfig_sChannelBusyRatio
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BBD0
	ldr r0, _0206BBF0 // =aUnknownConnect
	mov r1, r5
	blx r2
_0206BBD0:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0206BBD8: .word whConfig_sChannelBusyRatio
_0206BBDC: .word aRecvBufferSize
_0206BBE0: .word aSendBufferSize
_0206BBE4: .word aWfsInitchildCa
_0206BBE8: .word WH_Alloc
_0206BBEC: .word sBssDesc
_0206BBF0: .word aUnknownConnect
	arm_func_end WH_ChildConnect

	arm_func_start WH_SetJudgeAcceptFunc
WH_SetJudgeAcceptFunc: // 0x0206BBF4
	ldr r1, _0206BC00 // =whConfig_sChannelBusyRatio
	str r0, [r1, #0x50]
	bx lr
	.align 2, 0
_0206BC00: .word whConfig_sChannelBusyRatio
	arm_func_end WH_SetJudgeAcceptFunc

	arm_func_start WH_SetReceiver
WH_SetReceiver: // 0x0206BC04
	stmdb sp!, {r3, lr}
	ldr r2, _0206BC4C // =whConfig_sChannelBusyRatio
	ldr r1, _0206BC50 // =WH_PortReceiveCallback
	str r0, [r2, #0x24]
	mov r0, #0xe
	mov r2, #0
	bl WM_SetPortCallback
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	ldr r0, _0206BC4C // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, _0206BC54 // =aWmNotInitializ
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206BC4C: .word whConfig_sChannelBusyRatio
_0206BC50: .word WH_PortReceiveCallback
_0206BC54: .word aWmNotInitializ
	arm_func_end WH_SetReceiver

	arm_func_start WH_SendData
WH_SendData: // 0x0206BC58
	ldr ip, _0206BC60 // =WH_StateInSetMPData
	bx ip
	.align 2, 0
_0206BC60: .word WH_StateInSetMPData
	arm_func_end WH_SendData

	arm_func_start WH_GetSharedDataAdr
WH_GetSharedDataAdr: // 0x0206BC64
	ldr ip, _0206BC78 // =WM_GetSharedDataAddress
	mov r2, r0
	ldr r0, _0206BC7C // =WMDataSharingInfo
	ldr r1, _0206BC80 // =sDataSet
	bx ip
	.align 2, 0
_0206BC78: .word WM_GetSharedDataAddress
_0206BC7C: .word WMDataSharingInfo
_0206BC80: .word sDataSet
	arm_func_end WH_GetSharedDataAdr

	arm_func_start WH_StepDS
WH_StepDS: // 0x0206BC84
	stmdb sp!, {r4, lr}
	mov r1, r0
	ldr r0, _0206BCF0 // =WMDataSharingInfo
	ldr r2, _0206BCF4 // =sDataSet
	bl WM_StepDataSharing
	mov r4, r0
	cmp r4, #7
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	cmp r4, #5
	bne _0206BCD8
	ldr r0, _0206BCF8 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x44]
	cmp r1, #0
	beq _0206BCC8
	ldr r0, _0206BCFC // =aWhStepdatashar
	blx r1
_0206BCC8:
	mov r0, r4
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r4, pc}
_0206BCD8:
	cmp r4, #0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	bl WH_SetError
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_0206BCF0: .word WMDataSharingInfo
_0206BCF4: .word sDataSet
_0206BCF8: .word whConfig_sChannelBusyRatio
_0206BCFC: .word aWhStepdatashar
	arm_func_end WH_StepDS

	arm_func_start WH_Reset
WH_Reset: // 0x0206BD00
	stmdb sp!, {r3, lr}
	bl WFS_End
	ldr r0, _0206BD44 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	cmp r0, #5
	bne _0206BD2C
	ldr r0, _0206BD48 // =WMDataSharingInfo
	bl WM_EndDataSharing
	cmp r0, #0
	beq _0206BD2C
	bl WH_SetError
_0206BD2C:
	bl WH_StateInReset
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	mov r0, #0xa
	bl WH_ChangeSysState
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206BD44: .word whConfig_sChannelBusyRatio
_0206BD48: .word WMDataSharingInfo
	arm_func_end WH_Reset

	arm_func_start WH_Finalize
WH_Finalize: // 0x0206BD4C
	stmdb sp!, {r3, lr}
	ldr r0, _0206BE90 // =whConfig_sChannelBusyRatio
	ldr r1, [r0, #0x1c]
	cmp r1, #1
	bne _0206BD78
	ldr r1, [r0, #0x44]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, _0206BE94 // =aAlreadyWhSysst
	blx r1
	ldmia sp!, {r3, pc}
_0206BD78:
	ldr r2, [r0, #0x44]
	cmp r2, #0
	beq _0206BD8C
	ldr r0, _0206BE98 // =aWhFinalizeStat
	blx r2
_0206BD8C:
	ldr r0, _0206BE90 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	cmp r0, #2
	bne _0206BDB0
	bl WH_EndScan
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BDB0:
	cmp r0, #6
	cmpne r0, #5
	cmpne r0, #4
	mov r0, #3
	beq _0206BDD0
	bl WH_ChangeSysState
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BDD0:
	bl WH_ChangeSysState
	ldr r0, _0206BE90 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x2c]
	cmp r0, #7
	addls pc, pc, r0, lsl #2
	ldmia sp!, {r3, pc}
_0206BDE8: // jump table
	b _0206BE7C // case 0
	b _0206BE38 // case 1
	b _0206BE4C // case 2
	b _0206BE08 // case 3
	b _0206BE64 // case 4
	b _0206BE20 // case 5
	b _0206BE60 // case 6
	b _0206BE1C // case 7
_0206BE08:
	bl WH_StateInEndChildKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE1C:
	bl WFS_End
_0206BE20:
	ldr r0, _0206BE9C // =WMDataSharingInfo
	bl WM_EndDataSharing
	cmp r0, #0
	beq _0206BE38
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE38:
	bl WH_StateInEndChildMP
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE4C:
	bl WH_StateInEndParentKeyShare
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE60:
	bl WFS_End
_0206BE64:
	ldr r0, _0206BE9C // =WMDataSharingInfo
	bl WM_EndDataSharing
	cmp r0, #0
	beq _0206BE7C
	bl WH_Reset
	ldmia sp!, {r3, pc}
_0206BE7C:
	bl WH_StateInEndParentMP
	cmp r0, #0
	ldmneia sp!, {r3, pc}
	bl WH_Reset
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206BE90: .word whConfig_sChannelBusyRatio
_0206BE94: .word aAlreadyWhSysst
_0206BE98: .word aWhFinalizeStat
_0206BE9C: .word WMDataSharingInfo
	arm_func_end WH_Finalize

	arm_func_start WH_End
WH_End: // 0x0206BEA0
	stmdb sp!, {r3, lr}
	ldr r0, _0206BEE4 // =whConfig_sChannelBusyRatio
	ldr r0, [r0, #0x1c]
	cmp r0, #1
	beq _0206BEB8
	bl OS_Terminate
_0206BEB8:
	mov r0, #3
	bl WH_ChangeSysState
	ldr r0, _0206BEE8 // =WH_StateOutEnd
	bl WM_End
	cmp r0, #2
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	mov r0, #9
	bl WH_ChangeSysState
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_0206BEE4: .word whConfig_sChannelBusyRatio
_0206BEE8: .word WH_StateOutEnd
	arm_func_end WH_End

	arm_func_start WH_GetCurrentAid
WH_GetCurrentAid: // 0x0206BEEC
	ldr r0, _0206BEF8 // =whConfig_sChannelBusyRatio
	ldrh r0, [r0, #8]
	bx lr
	.align 2, 0
_0206BEF8: .word whConfig_sChannelBusyRatio
	arm_func_end WH_GetCurrentAid

	.data

.public aNA
aNA: // 0x02119F0C
	.asciz "N/A"
	.align 4

aWhSysstateIdle: // 0x02119F10
	.asciz "WH_SYSSTATE_IDLE"
	.align 4

aWhSysstateBusy: // 0x02119F24
	.asciz "WH_SYSSTATE_BUSY"
	.align 4

aWhSysstateStop: // 0x02119F38
	.asciz "WH_SYSSTATE_STOP"
	.align 4

aWhSysstateErro: // 0x02119F4C
	.asciz "WH_SYSSTATE_ERROR"
	.align 4

aWmErrcodeFaile: // 0x02119F60
	.asciz "WM_ERRCODE_FAILED"
	.align 4

aWmErrcodeSucce: // 0x02119F74
	.asciz "WM_ERRCODE_SUCCESS"
	.align 4

aWmErrcodeNoDat: // 0x02119F88
	.asciz "WM_ERRCODE_NO_DATA"
	.align 4

aWmErrcodeTimeo: // 0x02119F9C
	.asciz "WM_ERRCODE_TIMEOUT"
	.align 4

aWmStatecodeMpI: // 0x02119FB0
	.asciz "WM_STATECODE_MP_IND"
	.align 4

aWhErrcodeNoRad: // 0x02119FC4
	.asciz "WH_ERRCODE_NO_RADIO"
	.align 4

aWmErrcodeNoChi: // 0x02119FD8
	.asciz "WM_ERRCODE_NO_CHILD"
	.align 4

aWmErrcodeNoEnt: // 0x02119FEC
	.asciz "WM_ERRCODE_NO_ENTRY"
	.align 4

aWmErrcodeDcfTe: // 0x0211A000
	.asciz "WM_ERRCODE_DCF_TEST"
	.align 4

aWmStatecodeDcf: // 0x0211A014
	.asciz "WM_STATECODE_DCF_IND"
	.align 4

aWmStatecodeUnk: // 0x0211A02C
	.asciz "WM_STATECODE_UNKNOWN"
	.align 4

aWhSysstateScan: // 0x0211A044
	.asciz "WH_SYSSTATE_SCANNING"
	.align 4

aWmErrcodeOpera: // 0x0211A05C
	.asciz "WM_ERRCODE_OPERATING"
	.align 4

aWmStatecodeMpS: // 0x0211A074
	.asciz "WM_STATECODE_MP_START"
	.align 4

aWmErrcodeNoDat_0: // 0x0211A08C
	.asciz "WM_ERRCODE_NO_DATASET"
	.align 4

aWmErrcodeFifoE: // 0x0211A0A4
	.asciz "WM_ERRCODE_FIFO_ERROR"
	.align 4

aWmErrcodeWmDis: // 0x0211A0BC
	.asciz "WM_ERRCODE_WM_DISABLE"
	.align 4

aWhSysstateConn: // 0x0211A0D4
	.asciz "WH_SYSSTATE_CONNECTED"
	.align 4

aWmStatecodeMpe: // 0x0211A0EC
	.asciz "WM_STATECODE_MPEND_IND"
	.align 4

aWmStatecodeMpa: // 0x0211A104
	.asciz "WM_STATECODE_MPACK_IND"
	.align 4

aWmStatecodeDcf_0: // 0x0211A11C
	.asciz "WM_STATECODE_DCF_START"
	.align 4

aWmStatecodePor: // 0x0211A134
	.asciz "WM_STATECODE_PORT_SEND"
	.align 4

aWmStatecodePor_0: // 0x0211A14C
	.asciz "WM_STATECODE_PORT_RECV"
	.align 4

aWmStatecodePor_1: // 0x0211A164
	.asciz "WM_STATECODE_PORT_INIT"
	.align 4

aWmErrcodeSendF: // 0x0211A17C
	.asciz "WM_ERRCODE_SEND_FAILED"
	.align 4

aWmErrcodeFlash: // 0x0211A194
	.asciz "WM_ERRCODE_FLASH_ERROR"
	.align 4

aWhSysstateKeys: // 0x0211A1AC
	.asciz "WH_SYSSTATE_KEYSHARING"
	.align 4

aWmStatecodeCon: // 0x0211A1C4
	.asciz "WM_STATECODE_CONNECTED"
	.align 4

aWmStatecodeFif: // 0x0211A1DC
	.asciz "WM_STATECODE_FIFO_ERROR"
	.align 4

aWhSysstateData: // 0x0211A1F4
	.asciz "WH_SYSSTATE_DATASHARING"
	.align 4

aWhErrcodeDisco: // 0x0211A20C
	.asciz "WH_ERRCODE_DISCONNECTED"
	.align 4

aWmStatecodeSca: // 0x0211A224
	.asciz "WM_STATECODE_SCAN_START"
	.align 4

aWmStatecodeBea: // 0x0211A23C
	.asciz "WM_STATECODE_BEACON_LOST"
	.align 4

aWmStatecodeBea_0: // 0x0211A258
	.asciz "WM_STATECODE_BEACON_RECV"
	.align 4

aWmStatecodeRea: // 0x0211A274
	.asciz "WM_STATECODE_REASSOCIATE"
	.align 4

aWmStatecodeInf: // 0x0211A290
	.asciz "WM_STATECODE_INFORMATION"
	.align 4

aWmErrcodeIlleg: // 0x0211A2AC
	.asciz "WM_ERRCODE_ILLEGAL_STATE"
	.align 4

aWmErrcodeInval: // 0x0211A2C8
	.asciz "WM_ERRCODE_INVALID_PARAM"
	.align 4

aWmErrcodeWlLen: // 0x0211A2E4
	.asciz "WM_ERRCODE_WL_LENGTH_ERR"
	.align 4

aWhSysstateConn_0: // 0x0211A300
	.asciz "WH_SYSSTATE_CONNECT_FAIL"
	.align 4

aWmStatecodeBea_1: // 0x0211A31C
	.asciz "WM_STATECODE_BEACON_SENT"
	.align 4

aWmStatecodeDis: // 0x0211A338
	.asciz "WM_STATECODE_DISCONNECTED"
	.align 4

aWmStatecodeDis_0: // 0x0211A354
	.asciz "WM_STATECODE_DISASSOCIATE"
	.align 4

aWmStatecodeAut: // 0x0211A370
	.asciz "WM_STATECODE_AUTHENTICATE"
	.align 4

aWmErrcodeOverM: // 0x0211A38C
	.asciz "WM_ERRCODE_OVER_MAX_ENTRY"
	.align 4

aWmStatecodePar: // 0x0211A3A8
	.asciz "WM_STATECODE_PARENT_START"
	.align 4

aWmStatecodePar_0: // 0x0211A3C4
	.asciz "WM_STATECODE_PARENT_FOUND"
	.align 4

aWmErrcodeSendQ: // 0x0211A3E0
	.asciz "WM_ERRCODE_SEND_QUEUE_FULL"
	.align 4

aWhSysstateMeas: // 0x0211A3FC
	.asciz "WH_SYSSTATE_MEASURECHANNEL"
	.align 4

aWmStatecodeCon_0: // 0x0211A418
	.asciz "WM_STATECODE_CONNECT_START"
	.align 4

aWmErrcodeWlInv: // 0x0211A434
	.asciz "WM_ERRCODE_WL_INVALID_PARAM"
	.align 4

aWhErrcodeParen: // 0x0211A450
	.asciz "WH_ERRCODE_PARENT_NOT_FOUND"
	.align 4

aWmErrcodeInval_0: // 0x0211A46C
	.asciz "WM_ERRCODE_INVALID_POLLBITMAP"
	.align 4

aWmStatecodePar_1: // 0x0211A48C
	.asciz "WM_STATECODE_PARENT_NOT_FOUND"
	.align 4

aWmStatecodeDis_1: // 0x0211A4AC
	.asciz "WM_STATECODE_DISCONNECTED_FROM_MYSELF"
	.align 4

.public WH__sStateNames
WH__sStateNames: // 0x0211A4D4
	.word aWhSysstateStop     // "WH_SYSSTATE_STOP"
	.word aWhSysstateIdle     // "WH_SYSSTATE_IDLE"
	.word aWhSysstateScan     // "WH_SYSSTATE_SCANNING"
	.word aWhSysstateBusy     // "WH_SYSSTATE_BUSY"
	.word aWhSysstateConn     // "WH_SYSSTATE_CONNECTED"
	.word aWhSysstateData     // "WH_SYSSTATE_DATASHARING"
	.word aWhSysstateKeys     // "WH_SYSSTATE_KEYSHARING"
	.word aWhSysstateMeas     // "WH_SYSSTATE_MEASURECHANNEL"
	.word aWhSysstateConn_0   // "WH_SYSSTATE_CONNECT_FAIL"
	.word aWhSysstateErro     // "WH_SYSSTATE_ERROR"

.public WH__errnames
WH__errnames:  // 0x0211A4FC
    .word aWmErrcodeSucce 	  // "WM_ERRCODE_SUCCESS"
	.word aWmErrcodeFaile     // "WM_ERRCODE_FAILED"
	.word aWmErrcodeOpera     // "WM_ERRCODE_OPERATING"
	.word aWmErrcodeIlleg     // "WM_ERRCODE_ILLEGAL_STATE"
	.word aWmErrcodeWmDis     // "WM_ERRCODE_WM_DISABLE"
	.word aWmErrcodeNoDat_0   // "WM_ERRCODE_NO_DATASET"
	.word aWmErrcodeInval     // "WM_ERRCODE_INVALID_PARAM"
	.word aWmErrcodeNoChi     // "WM_ERRCODE_NO_CHILD"
	.word aWmErrcodeFifoE     // "WM_ERRCODE_FIFO_ERROR"
	.word aWmErrcodeTimeo     // "WM_ERRCODE_TIMEOUT"
	.word aWmErrcodeSendQ     // "WM_ERRCODE_SEND_QUEUE_FULL"
	.word aWmErrcodeNoEnt     // "WM_ERRCODE_NO_ENTRY"
	.word aWmErrcodeOverM     // "WM_ERRCODE_OVER_MAX_ENTRY"
	.word aWmErrcodeInval_0   // "WM_ERRCODE_INVALID_POLLBITMAP"
	.word aWmErrcodeNoDat     // "WM_ERRCODE_NO_DATA"
	.word aWmErrcodeSendF     // "WM_ERRCODE_SEND_FAILED"
	.word aWmErrcodeDcfTe     // "WM_ERRCODE_DCF_TEST"
	.word aWmErrcodeWlInv     // "WM_ERRCODE_WL_INVALID_PARAM"
	.word aWmErrcodeWlLen     // "WM_ERRCODE_WL_LENGTH_ERR"
	.word aWmErrcodeFlash     // "WM_ERRCODE_FLASH_ERROR"
	.word aWhErrcodeDisco     // "WH_ERRCODE_DISCONNECTED"
	.word aWhErrcodeParen     // "WH_ERRCODE_PARENT_NOT_FOUND"
	.word aWhErrcodeNoRad     // "WH_ERRCODE_NO_RADIO"

.public WH__statenames
WH__statenames: // 0x0211A558
	.word aWmStatecodePar 	 // "WM_STATECODE_PARENT_START"
	.word aNA                // "N/A"
	.word aWmStatecodeBea_1  // "WM_STATECODE_BEACON_SENT"
	.word aWmStatecodeSca    // "WM_STATECODE_SCAN_START"
	.word aWmStatecodePar_1  // "WM_STATECODE_PARENT_NOT_FOUND"
	.word aWmStatecodePar_0  // "WM_STATECODE_PARENT_FOUND"
	.word aWmStatecodeCon_0  // "WM_STATECODE_CONNECT_START"
	.word aWmStatecodeCon    // "WM_STATECODE_CONNECTED"
	.word aWmStatecodeBea    // "WM_STATECODE_BEACON_LOST"
	.word aWmStatecodeDis    // "WM_STATECODE_DISCONNECTED"
	.word aWmStatecodeMpS    // "WM_STATECODE_MP_START"
	.word aWmStatecodeMpe    // "WM_STATECODE_MPEND_IND"
	.word aWmStatecodeMpI    // "WM_STATECODE_MP_IND"
	.word aWmStatecodeMpa    // "WM_STATECODE_MPACK_IND"
	.word aWmStatecodeDcf_0  // "WM_STATECODE_DCF_START"
	.word aWmStatecodeDcf    // "WM_STATECODE_DCF_IND"
	.word aWmStatecodeBea_0  // "WM_STATECODE_BEACON_RECV"
	.word aWmStatecodeDis_0  // "WM_STATECODE_DISASSOCIATE"
	.word aWmStatecodeRea    // "WM_STATECODE_REASSOCIATE"
	.word aWmStatecodeAut    // "WM_STATECODE_AUTHENTICATE"
	.word aWmStatecodePor    // "WM_STATECODE_PORT_SEND"
	.word aWmStatecodePor_0  // "WM_STATECODE_PORT_RECV"
	.word aWmStatecodeFif    // "WM_STATECODE_FIFO_ERROR"
	.word aWmStatecodeInf    // "WM_STATECODE_INFORMATION"
	.word aWmStatecodeUnk    // "WM_STATECODE_UNKNOWN"
	.word aWmStatecodePor_1  // "WM_STATECODE_PORT_INIT"
	.word aWmStatecodeDis_1  // "WM_STATECODE_DISCONNECTED_FROM_MYSELF"

aNA_0: // 0x0211A5C4
	.asciz "N/A"
    .align 4

aS: // 0x0211A5C8
	.asciz "%s -> "
    .align 4

.public aS_0
aS_0: // 0x211A5D0
	.asciz "%s\n"
    .align 4

aWhCallbackforw: // 0x0211A5D4
	.asciz "WH_CallbackForWFS : WFS_Start\n"
    .align 4

aStartparentNew: // 0x0211A5F4
	.asciz "StartParent - new child (aid 0x%x) connected\n"
    .align 4

aStartparentChi: // 0x0211A624
	.asciz "StartParent - child (aid 0x%x) disconnected\n"
    .align 4

aStartparentChi_0: // 0x0211A654
	.asciz "StartParent - child (aid 0x%x) disconnected from myself\n"
    .align 4

aUnknownIndicat: // 0x0211A690
	.asciz "unknown indicate, state = %d\n"
    .align 4

aWhStateinstart: // 0x0211A6B0
	.asciz "WH_StateInStartParentKeyShare failed\n"
    .align 4

aWhStateinendpa: // 0x0211A6D8
	.asciz "WH_StateInEndParentMP failed\n"
    .align 4

aWhStateinendpa_0: // 0x0211A6F8
	.asciz "WH_StateInEndParent failed\n"
    .align 4

aRecvBufferSize: // 0x0211A714
	.asciz "recv buffer size = %d\n"
    .align 4

aSendBufferSize: // 0x0211A72C
	.asciz "send buffer size = %d\n"
    .align 4

aWfsInitchildCa: // 0x0211A744
	.asciz "WFS_InitChild call\n"
    .align 4

aWhStateoutstar: // 0x0211A758
	.asciz "WH_StateOutStartScan : MAC=%02x%02x%02x%02x%02x%02x "
    .align 4

aPictochatParen: // 0x0211A790
	.asciz "pictochat parent find\n"
    .align 4

aNotMyParentGgi: // 0x0211A7A8
	.asciz "not my parent ggid \n"
    .align 4

aNotReceiveEntr: // 0x0211A7C0
	.asciz "not recieve entry\n"
    .align 4

aParentFind: // 0x0211A7D4
	.asciz "parent find\n"
    .align 4

aWhStateoutends: // 0x0211A7E4
	.asciz "WH_StateOutEndScan : startchild failed\n"
    .align 4

aWhStateoutsetc: // 0x0211A80C
	.asciz "WH_StateOutSetChildWEPKey : startchild failed\n"
    .align 4

aWhStateinstart_0: // 0x0211A83C
	.asciz "WH_StateInStartChild : already connected?\n"
    .align 4

aConnectToParen: // 0x0211A868
	.asciz "Connect to Parent\n"
    .align 4

aWhStateinstart_1: // 0x0211A87C
	.asciz "WH_StateInStartChildMP failed\n"
    .align 4

aDisconnectedFr: // 0x0211A89C
	.asciz "Disconnected from Parent\n"
    .align 4

aUnknownStateDS: // 0x0211A8B8
	.asciz "unknown state %d, %s\n"
    .align 4

aWhStateinstart_2: // 0x0211A8D0
	.asciz "WH_StateInStartChildKeyShare failed\n"
    .align 4

aWhStateoutstar_0: // 0x0211A8F8
	.asciz "WH_StateOutStartChildMP : WM_StartDataSharing OK\n"
    .align 4

aWhStateinsetmp: // 0x0211A92C
	.asciz "WH_StateInSetMPData failed - %s\n"
    .align 4

aChannelDBratio: // 0x0211A950
	.asciz "channel %d bratio = 0x%x\n"
    .align 4

aDecidedChannel: // 0x0211A96C
	.asciz "decided channel = %d\n"
    .align 4

aWfsInitparentC: // 0x0211A984
	.asciz "WFS_InitParent call\n"
    .align 4

aUnknownConnect: // 0x0211A99C
	.asciz "unknown connect mode %d\n"
    .align 4

aWmNotInitializ: // 0x0211A9B8
	.asciz "WM not Initialized\n"
    .align 4

aWhStepdatashar: // 0x0211A9CC
	.asciz "WH_StepDataSharing - Warning No DataSet\n"
    .align 4

aAlreadyWhSysst: // 0x0211A9F8
	.asciz "already WH_SYSSTATE_IDLE\n"
    .align 4

aWhFinalizeStat: // 0x0211AA14
	.asciz "WH_Finalize, state = %d\n"
    .align 4