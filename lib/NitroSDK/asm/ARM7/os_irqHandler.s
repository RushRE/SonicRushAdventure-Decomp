	.include "asm/macros.inc"
	.include "global.inc"
	
	.public OS_IRQTable

	.text

	arm_func_start OS_IrqHandler
OS_IrqHandler: // 0x037FB9D4
	stmdb sp!, {lr}
	mov ip, #0x4000000
	add ip, ip, #0x210
	ldr r1, [ip, #-8]
	cmp r1, #0
	ldmeqia sp!, {pc}
	ldmia ip, {r1, r2}
	ands r1, r1, r2
	ldmeqia sp!, {pc}
	mov r3, #1
	mov r0, #0
_037FBA00:
	ands r2, r1, r3, lsl r0
	addeq r0, r0, #1
	beq _037FBA00
	str r2, [ip, #4]
	ldr r1, _037FBA20 // =OS_IRQTable
	ldr r0, [r1, r0, lsl #2]
	ldr lr, _037FBA24 // =OS_IrqHandler_ThreadSwitch
	bx r0
	.align 2, 0
_037FBA20: .word OS_IRQTable
_037FBA24: .word OS_IrqHandler_ThreadSwitch
	arm_func_end OS_IrqHandler

	arm_func_start OS_IrqHandler_ThreadSwitch
OS_IrqHandler_ThreadSwitch: // 0x037FBA28
	ldr ip, _037FBB44 // =_038083A4
	mov r3, #0
	ldr ip, [ip]
	mov r2, #1
	cmp ip, #0
	beq _037FBA78
_037FBA40:
	str r2, [ip, #0x48]
	str r3, [ip, #0x5c]
	str r3, [ip, #0x60]
	ldr r0, [ip, #0x64]
	str r3, [ip, #0x64]
	mov ip, r0
	cmp ip, #0
	bne _037FBA40
	ldr ip, _037FBB44 // =_038083A4
	str r3, [ip]
	str r3, [ip, #4]
	ldr ip, _037FBB48 // =0x03808434
	mov r1, #1
	strh r1, [ip]
_037FBA78:
	ldr ip, _037FBB48 // =0x03808434
	ldrh r1, [ip]
	cmp r1, #0
	ldreq pc, [sp], #4
	mov r1, #0
	strh r1, [ip]
	mov r3, #0xd2
	msr cpsr_c, r3
	add r2, ip, #8
	ldr r1, [r2]
_037FBAA0:
	cmp r1, #0
	ldrneh r0, [r1, #0x48]
	cmpne r0, #1
	ldrne r1, [r1, #0x4c]
	bne _037FBAA0
	cmp r1, #0
	bne _037FBAC8
_037FBABC:
	mov r3, #0x92
	msr cpsr_c, r3
	ldr pc, [sp], #4
_037FBAC8:
	ldr r0, [ip, #4]
	cmp r1, r0
	beq _037FBABC
	ldr r3, [ip, #0xc]
	cmp r3, #0
	beq _037FBAF0
	stmdb sp!, {r0, r1, ip}
	mov lr, pc
	bx r3
_37FBAEC: // 0x037FBAEC
	ldmia sp!, {r0, r1, ip}
_037FBAF0:
	str r1, [ip, #4]
	mrs r2, spsr
	str r2, [r0, #0]!
	ldmib sp!, {r2, r3}
	stmib r0!, {r2, r3}
	ldmib sp!, {r2, r3, ip, lr}
	stmib r0!, {r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, ip, sp, lr} ^
	stmib r0!, {lr}
	mov r3, #0xd3
	msr cpsr_c, r3
	stmib r0!, {sp}
	ldr sp, [r1, #0x44]
	mov r3, #0xd2
	msr cpsr_c, r3
	ldr r2, [r1, #0]!
	msr spsr_fc, r2
	ldr lr, [r1, #0x40]
	ldmib r1!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, ip, sp, lr} ^
	mov r0, r0
	stmda sp!, {r0, r1, r2, r3, ip, lr}
	ldmia sp!, {pc}
	.align 2, 0
_037FBB44: .word _038083A4
_037FBB48: .word 0x03808434
	arm_func_end OS_IrqHandler_ThreadSwitch

	.bss
	
.public _038083A4
_038083A4:
	.space 0x08

.public OSi_IrqCallbackInfo
OSi_IrqCallbackInfo: // 0x038083AC
	.space 0x6C

.public isInitialized_3171
isInitialized_3171: // 0x03808418
	.space 4

.public OSi_StackForDestructor
OSi_StackForDestructor: // 0x0380841C
	.space 4

.public OSi_RescheduleCount
OSi_RescheduleCount: // 0x03808420
	.space 4

.public OSi_ThreadIdCount
OSi_ThreadIdCount: // 0x03808424
	.space 4

.public OSi_SystemCallbackInSwitchThread
OSi_SystemCallbackInSwitchThread: // 0x03808428
	.space 4

.public OSi_CurrentThreadPtr
OSi_CurrentThreadPtr: // 0x0380842C
	.space 4

.public OSi_IsThreadInitialized
OSi_IsThreadInitialized: // 0x03808430
	.space 4

.public OSi_ThreadInfo
OSi_ThreadInfo: // 0x03808434
	.space 0x10

.public OSi_IdleThread
OSi_IdleThread: // 0x03808444
	.space 0xA4

.public OSi_LauncherThread
OSi_LauncherThread: // 0x038084E8
	.space 0xA4

.public OSi_Initialized
OSi_Initialized: // 0x0380858C
	.space 4

.public OSiHeapInfo
OSiHeapInfo: // 0x03808590
	.space 0x24

.public OSi_TimerReserved
OSi_TimerReserved: // 0x038085B4
	.space 4

.public OSi_UseTick
OSi_UseTick: // 0x038085B8
	.space 4

.public OSi_NeedResetTimer
OSi_NeedResetTimer: // 0x038085BC
	.space 4

.public OSi_TickCounter
OSi_TickCounter: // 0x038085C0
	.space 8

.public OSi_UseAlarm
OSi_UseAlarm: // 0x038085C8
	.space 4

.public OSi_AlarmQueue
OSi_AlarmQueue: // 0x038085CC
	.space 8

.public OSi_UseVAlarm
OSi_UseVAlarm: // 0x038085D4
	.space 4

.public OSi_PreviousVCount
OSi_PreviousVCount: // 0x038085D8
	.space 4

.public OSi_VFrameCount
OSi_VFrameCount: // 0x038085DC
	.space 4

.public OSi_VAlarmQueue
OSi_VAlarmQueue: // 0x038085E0
	.space 8

.public OSi_IsInitReset
OSi_IsInitReset: // 0x038085E8
	.space 4

.public OSi_IsResetOccurred
OSi_IsResetOccurred: // 0x038085EC
	.space 4

.public FifoCtrlInit
FifoCtrlInit: // 0x038085F0
	.space 4

.public FifoRecvCallbackTable
FifoRecvCallbackTable: // 0x038085F4
	.space 0x80

.public PADi_XYButtonAvailable
PADi_XYButtonAvailable: // 0x03808674
	.space 4

.public PADi_XYButtonAlarm
PADi_XYButtonAlarm: // 0x03808678
	.space 0x2C

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

.public CARDi_EnableFlag
CARDi_EnableFlag: // 0x03809DC4
	.space 0x1C

.public cardi_common
cardi_common: // 0x03809DE0
	.space 0x220

.public cardi_thread_stack
cardi_thread_stack: // 0x0380A000
	.space 0x400

.public status_checked_3333
status_checked_3333: // 0x0380A400
	.space 4

.public cardi_param
cardi_param: // 0x0380A404
	.space 0x10

.public cardi_rom_base
cardi_rom_base: // 0x0380A414
	.space 0xC

.public rom_stat
rom_stat: // 0x0380A420
	.space 0x220

.public isCardPullOut
isCardPullOut: // 0x0380A640
	.space 4

.public isInitialized_3152
isInitialized_3152: // 0x0380A644
	.space 4

.public detectPullOut
detectPullOut: // 0x0380A648
	.space 4

.public spiInitialized
spiInitialized: // 0x0380A64C
	.space 4

.public spiWork
spiWork: // 0x0380A650
	.space 0x49C

.public valid_cnt_3256
valid_cnt_3256: // 0x0380AAEC
	.space 4

.public invalid_cnt_3255
invalid_cnt_3255: // 0x0380AAF0
	.space 4

.public tpw
tpw: // 0x0380AAF4
	.space 0xD4

.public last_touch_flg
last_touch_flg: // 0x0380ABC8
	.space 4

.public PMi_KeyPattern
PMi_KeyPattern: // 0x0380ABCC
	.space 4

.public PMi_TriggerBL
PMi_TriggerBL: // 0x0380ABD0
	.space 4

.public PMi_Initialized
PMi_Initialized: // 0x0380ABD4
	.space 4

.public PMi_Work
PMi_Work: // 0x0380ABD8
	.space 0x2C

.public PMi_BlinkCounter
PMi_BlinkCounter: // 0x0380AC04
	.space 4

.public PMi_BlinkPatternNo
PMi_BlinkPatternNo: // 0x0380AC08
	.space 4

.public wvrStatus
wvrStatus: // 0x0380AC0C
	.space 4

.public wvrVramImageBuf
wvrVramImageBuf: // 0x0380AC10
	.space 4

.public wvrHeapHandle
wvrHeapHandle: // 0x0380AC14
	.space 4

.public wvrThread
wvrThread: // 0x0380AC18
	.space 0xA4

.public wvrWlStaElement
wvrWlStaElement: // 0x0380ACBC
	.space 0x1C0

.public wvrWlStack
wvrWlStack: // 0x0380AE7C
	.space 0x600

.public wvrWlWork
wvrWlWork: // 0x0380B47C
	.space 0x700

.public micw
micw: // 0x0380BB7C
	.space 0x3C

.public micIntrInfo
micIntrInfo: // 0x0380BBB8
	.space 0x10

.public CTRDGi_Work
CTRDGi_Work: // 0x0380BBC8
	.space 4

.public lock_id
lock_id: // 0x0380BBCC
	.space 4

.public current_vib
current_vib: // 0x0380BBD0
	.space 4

.public isInitialized_3175
isInitialized_3175: // 0x0380BBD4
	.space 4

.public isCartridgePullOut_3293
isCartridgePullOut_3293: // 0x0380BBD8
	.space 4

.public skipCheck_3295
skipCheck_3295: // 0x0380BBDC
	.space 4

.public isInitialized_3164
isInitialized_3164: // 0x0380BBE0
	.space 4

.public ctw_sp
ctw_sp: // 0x0380BBE4
	.space 0x18

.public pulse_edge_alarm
pulse_edge_alarm: // 0x0380BBFC
	.space 0x2C

.public wmspRequestThread
wmspRequestThread: // 0x0380BC28
	.space 0xA4

.public wmspIndicateThread
wmspIndicateThread: // 0x0380BCCC
	.space 0xA4

.public wmspMPAckAlarm
wmspMPAckAlarm: // 0x0380BD70
	.space 0x2C

.public wmspMPIntervalAlarm
wmspMPIntervalAlarm: // 0x0380BD9C
	.space 0x2C

.public wmspVAlarm
wmspVAlarm: // 0x0380BDC8
	.space 0x28