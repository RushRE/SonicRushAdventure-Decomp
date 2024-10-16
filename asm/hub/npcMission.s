	.include "asm/macros.inc"
	.include "global.inc"

	.public _ZTVN10__cxxabiv117__class_type_infoE
	.public _ZTVN10__cxxabiv120__si_class_type_infoE

	.text

	arm_func_start NpcMission__Create
NpcMission__Create: // 0x021715C8
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr ip, _02171648 // =0x00001010
	mov r5, r0
	mov r2, #0
	str ip, [sp]
	mov ip, #0x10
	ldr r0, _0217164C // =NpcMission__Main
	ldr r1, _02171650 // =NpcMission__Destructor
	mov r3, r2
	str ip, [sp, #4]
	bl NpcMission__CreateInternal
	bl GetTaskWork_
	mov r4, r0
	cmp r5, #0
	moveq r0, #0
	movne r0, #1
	str r0, [r4, #0x4b8]
	mov r0, r4
	bl NpcMission__Func_21716AC
	add r0, r4, #0xbc
	add r0, r0, #0x400
	mov r1, #0x800
	bl InitThreadWorker
	add r0, r4, #0xbc
	ldr r1, _02171654 // =NpcMission__ThreadFunc
	mov r2, r4
	add r0, r0, #0x400
	mov r3, #0x14
	bl CreateThreadWorker
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02171648: .word 0x00001010
_0217164C: .word NpcMission__Main
_02171650: .word NpcMission__Destructor
_02171654: .word NpcMission__ThreadFunc
	arm_func_end NpcMission__Create

	arm_func_start NpcMission__CreateInternal
NpcMission__CreateInternal: // 0x02171658
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldrh r4, [sp, #0x18]
	ldrb lr, [sp, #0x1c]
	ldr ip, _021716A4 // =0x00000588
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r1, r0
	ldr r0, _021716A4 // =0x00000588
	bl _ZnwmPv
	cmp r0, #0
	beq _02171698
	bl ViEvtCmnTalk__Constructor
_02171698:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021716A4: .word 0x00000588
	arm_func_end NpcMission__CreateInternal

	arm_func_start NpcMission__ThreadFunc
NpcMission__ThreadFunc: // 0x021716A8
	bx lr
	arm_func_end NpcMission__ThreadFunc

	arm_func_start NpcMission__Func_21716AC
NpcMission__Func_21716AC: // 0x021716AC
	ldr ip, _021716B4 // =ViHubAreaPreview__Func_215A888
	bx ip
	.align 2, 0
_021716B4: .word ViHubAreaPreview__Func_215A888
	arm_func_end NpcMission__Func_21716AC

	arm_func_start NpcMission__Func_21716B8
NpcMission__Func_21716B8: // 0x021716B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0xbc
	add r0, r0, #0x400
	bl JoinThreadWorker
	add r0, r4, #0xbc
	add r0, r0, #0x400
	bl ReleaseThreadWorker
	mov r0, r4
	bl ViEvtCmnTalk__Func_216D72C
	mov r0, r4
	bl NpcMission__Func_21716EC
	ldmia sp!, {r4, pc}
	arm_func_end NpcMission__Func_21716B8

	arm_func_start NpcMission__Func_21716EC
NpcMission__Func_21716EC: // 0x021716EC
	ldr ip, _021716F4 // =ViHubAreaPreview__Func_215A96C
	bx ip
	.align 2, 0
_021716F4: .word ViHubAreaPreview__Func_215A96C
	arm_func_end NpcMission__Func_21716EC

	arm_func_start NpcMission__Main
NpcMission__Main: // 0x021716F8
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0xbc
	add r0, r0, #0x400
	bl IsThreadWorkerFinished
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldr r0, [r4, #0x4b8]
	cmp r0, #0
	moveq r5, #1
	movne r5, #0
	bl HubControl__GetFileFrom_ViMsgCtrl
	mov r1, #0xe
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldr r3, _02171760 // =0x0000FFFF
	mov r0, r4
	mov r2, r5
	bl ViEvtCmnTalk__Func_216D680
	mov r0, r4
	mov r1, #0
	bl ViEvtCmnTalk__Func_216D7D0
	ldr r0, _02171764 // =NpcMission__Main_2171768
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02171760: .word 0x0000FFFF
_02171764: .word NpcMission__Main_2171768
	arm_func_end NpcMission__Main

	arm_func_start NpcMission__Main_2171768
NpcMission__Main_2171768: // 0x02171768
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl ViEvtCmnTalk__Func_216D81C
	mov r0, r4
	bl ViEvtCmnTalk__Func_216D888
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl ViEvtCmnTalk__Func_216D89C
	cmp r0, #0x12
	bne _021717C8
	mov r0, r4
	bl ViEvtCmnTalk__Func_216D8A4
	cmp r0, #0
	bne _021717B4
	mov r0, #0x1b
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	b _021717D0
_021717B4:
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	mov r0, #0
	bl SaveGame__GsExit
	b _021717D0
_021717C8:
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168744Em
_021717D0:
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168754El
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
	arm_func_end NpcMission__Main_2171768

	arm_func_start NpcMission__Destructor
NpcMission__Destructor: // 0x021717E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl NpcMission__Func_21716B8
	mov r0, r4
	bl NpcMission__Func_21717FC
	ldmia sp!, {r4, pc}
	arm_func_end NpcMission__Destructor

	arm_func_start NpcMission__Func_21717FC
NpcMission__Func_21717FC: // 0x021717FC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _02171820
	mov r0, r4
	bl ViEvtCmnTalk__VTableFunc_216D618
	mov r0, r4
	bl _ZdlPv
_02171820:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end NpcMission__Func_21717FC