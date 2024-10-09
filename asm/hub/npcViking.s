	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start NpcViking__Create
NpcViking__Create: // 0x0217109C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, _021710F8 // =0x00001010
	mov r2, #0
	ldr r0, _021710FC // =NpcViking__Main
	ldr r1, _02171100 // =NpcViking__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl NpcViking__CreateInternal
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x490
	mov r1, #0x800
	bl InitThreadWorker
	ldr r1, _02171104 // =NpcViking__ThreadFunc
	mov r2, r4
	add r0, r4, #0x490
	mov r3, #0x14
	bl CreateThreadWorker
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021710F8: .word 0x00001010
_021710FC: .word NpcViking__Main
_02171100: .word NpcViking__Destructor
_02171104: .word NpcViking__ThreadFunc
	arm_func_end NpcViking__Create

	arm_func_start NpcViking__CreateInternal
NpcViking__CreateInternal: // 0x02171108
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldrh lr, [sp, #0x18]
	ldrb ip, [sp, #0x1c]
	ldr r4, _0217114C // =0x0000055C
	str lr, [sp]
	str ip, [sp, #4]
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r1, r0
	ldr r0, _0217114C // =0x0000055C
	bl _ZnwmPv
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_0217114C: .word 0x0000055C
	arm_func_end NpcViking__CreateInternal

	arm_func_start NpcViking__Func_2171150
NpcViking__Func_2171150: // 0x02171150
	ldr r2, _02171184 // =0x0217320C
	mov ip, #0
_02171158:
	mov r3, ip, lsl #2
	ldrh r1, [r2, r3]
	cmp r0, r1
	ldreq r0, _02171188 // =0x0217320E
	ldreqh r0, [r0, r3]
	bxeq lr
	add ip, ip, #1
	cmp ip, #5
	blt _02171158
	mov r0, #0
	bx lr
	.align 2, 0
_02171184: .word 0x0217320C
_02171188: .word 0x0217320E
	arm_func_end NpcViking__Func_2171150

	arm_func_start NpcViking__ThreadFunc
NpcViking__ThreadFunc: // 0x0217118C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl HubControl__GetFileFrom_ViMsg
	mov r1, #0x11
	bl FileUnknown__GetAOUFile
	str r0, [r4, #0x48c]
	mov r0, r4
	add r1, r4, #0x400
	mov r2, #0x46
	strh r2, [r1, #0x84]
	bl NpcViking__Func_21711C4
	mov r0, r4
	bl NpcViking__Func_21711D0
	ldmia sp!, {r4, pc}
	arm_func_end NpcViking__ThreadFunc

	arm_func_start NpcViking__Func_21711C4
NpcViking__Func_21711C4: // 0x021711C4
	ldr ip, _021711CC // =ViHubAreaPreview__Func_215A888
	bx ip
	.align 2, 0
_021711CC: .word ViHubAreaPreview__Func_215A888
	arm_func_end NpcViking__Func_21711C4

	arm_func_start NpcViking__Func_21711D0
NpcViking__Func_21711D0: // 0x021711D0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2c
	mov r10, r0
	add r0, r10, #0x400
	ldrh r0, [r0, #0x84]
	mov r0, r0, lsl #2
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r10, #0x480]
	add r4, r10, #0x400
	ldrh r0, [r4, #0x84]
	mov r6, #0
	cmp r0, #0
	ble _02171264
	ldr r9, _02171304 // =0x02173220
	mov r8, r6
	mov r11, #0x46
	mov r5, r6
_02171214:
	ldr r1, [r10, #0x480]
	mov r0, r6, lsl #0x10
	mov r0, r0, lsr #0x10
	strh r5, [r1, r8]
	add r7, r1, r8
	bl NpcViking__Func_21714EC
	cmp r0, #0
	streqh r11, [r7, #2]
	beq _0217124C
	ldrh r0, [r7, #0]
	orr r0, r0, #1
	strh r0, [r7]
	ldrh r0, [r9, #2]
	strh r0, [r7, #2]
_0217124C:
	ldrh r0, [r4, #0x84]
	add r6, r6, #1
	add r8, r8, #4
	cmp r6, r0
	add r9, r9, #6
	blt _02171214
_02171264:
	bl HubControl__GetField54
	str r0, [sp]
	ldr r1, [r10, #0x48c]
	add r0, r10, #0x400
	str r1, [sp, #4]
	ldr r1, [r10, #0x480]
	str r1, [sp, #8]
	ldrh r0, [r0, #0x84]
	strh r0, [sp, #0xc]
	bl NpcViking__Func_217154C
	strh r0, [sp, #0xe]
	mov r1, #2
	mov r0, #0
	strh r1, [sp, #0x22]
	bl HubControl__GetFileFrom_ViActLoc
	str r0, [sp, #0x10]
	mov r0, #3
	bl HubControl__GetFileFrom_ViAct
	str r0, [sp, #0x14]
	mov r0, #5
	bl HubControl__GetFileFrom_ViAct
	str r0, [sp, #0x18]
	mov r0, #0xb
	bl HubControl__GetFileFrom_ViAct
	str r0, [sp, #0x1c]
	mov r0, #6
	strh r0, [sp, #0x20]
	mov r0, #0
	strh r0, [sp, #0x24]
	mov r0, #5
	strh r0, [sp, #0x26]
	mov r0, #3
	strh r0, [sp, #0x28]
	mov r0, r10
	bl NpcOptions__Func_216EDCC
	mov r0, r10
	add r1, sp, #0
	bl NpcOptions__Func_216EDF8
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02171304: .word 0x02173220
	arm_func_end NpcViking__Func_21711D0

	arm_func_start NpcViking__Func_2171308
NpcViking__Func_2171308: // 0x02171308
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x490
	bl ReleaseThreadWorker
	mov r0, r4
	bl NpcViking__Func_2171338
	mov r0, r4
	bl NpcViking__Func_217132C
	ldmia sp!, {r4, pc}
	arm_func_end NpcViking__Func_2171308

	arm_func_start NpcViking__Func_217132C
NpcViking__Func_217132C: // 0x0217132C
	ldr ip, _02171334 // =ViHubAreaPreview__Func_215A96C
	bx ip
	.align 2, 0
_02171334: .word ViHubAreaPreview__Func_215A96C
	arm_func_end NpcViking__Func_217132C

	arm_func_start NpcViking__Func_2171338
NpcViking__Func_2171338: // 0x02171338
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl NpcOptions__Func_216EE98
	ldr r0, [r4, #0x480]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0x480]
	ldmia sp!, {r4, pc}
	arm_func_end NpcViking__Func_2171338

	arm_func_start NpcViking__Main
NpcViking__Main: // 0x02171360
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x490
	bl IsThreadWorkerFinished
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _021713A8 // =gameState+0x00000100
	mov r0, r4
	ldrh r1, [r1, #0x40]
	mov r2, #1
	bl NpcOptions__Func_216EEC0
	ldr r1, _021713A8 // =gameState+0x00000100
	mov r2, #0
	ldr r0, _021713AC // =NpcViking__Func_21713B0
	strh r2, [r1, #0x40]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_021713A8: .word gameState+0x00000100
_021713AC: .word NpcViking__Func_21713B0
	arm_func_end NpcViking__Main

	arm_func_start NpcViking__Func_21713B0
NpcViking__Func_21713B0: // 0x021713B0
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl NpcOptions__Func_216EF50
	mov r0, r4
	bl NpcOptions__Func_216EF80
	cmp r0, #0
	beq _021713E4
	mov r0, #1
	bl ViDock__Func_215E4BC
	ldr r0, _02171400 // =NpcViking__Func_2171404
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
_021713E4:
	mov r0, r4
	bl NpcOptions__Func_216EF78
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	bl ViDock__Func_215E4BC
	ldmia sp!, {r4, pc}
	.align 2, 0
_02171400: .word NpcViking__Func_2171404
	arm_func_end NpcViking__Func_21713B0

	arm_func_start NpcViking__Func_2171404
NpcViking__Func_2171404: // 0x02171404
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl NpcOptions__Func_216EF50
	mov r0, r4
	bl NpcOptions__Func_216EFC0
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl NpcOptions__Func_216EF88
	cmp r0, #0
	beq _02171460
	mov r0, r4
	bl NpcOptions__Func_216EFDC
	mov r1, #6
	mul r2, r0, r1
	ldr r1, _021714A8 // =0x02173220
	mov r0, r4
	ldrh r4, [r1, r2]
	bl NpcOptions__Func_216EFDC
	ldr r1, _021714AC // =gameState+0x00000100
	strh r0, [r1, #0x40]
	b _02171470
_02171460:
	ldr r0, _021714AC // =gameState+0x00000100
	mov r1, #0
	ldr r4, _021714B0 // =0x0000FFFF
	strh r1, [r0, #0x40]
_02171470:
	bl DestroyCurrentTask
	ldr r0, _021714B0 // =0x0000FFFF
	cmp r4, r0
	beq _02171494
	mov r0, #0x14
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	mov r0, r4
	bl _ZN15CViDockNpcGroup12Func_2168754El
	ldmia sp!, {r4, pc}
_02171494:
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168744Em
	mov r0, #0
	bl _ZN15CViDockNpcGroup12Func_2168754El
	ldmia sp!, {r4, pc}
	.align 2, 0
_021714A8: .word 0x02173220
_021714AC: .word gameState+0x00000100
_021714B0: .word 0x0000FFFF
	arm_func_end NpcViking__Func_2171404

	arm_func_start NpcViking__Destructor
NpcViking__Destructor: // 0x021714B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl NpcViking__Func_2171308
	mov r0, r4
	bl NpcViking__Func_21714D0
	ldmia sp!, {r4, pc}
	arm_func_end NpcViking__Destructor

	arm_func_start NpcViking__Func_21714D0
NpcViking__Func_21714D0: // 0x021714D0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x10]
	bl _ZdlPv
	mov r0, #0
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end NpcViking__Func_21714D0

	arm_func_start NpcViking__Func_21714EC
NpcViking__Func_21714EC: // 0x021714EC
	stmdb sp!, {r3, lr}
	mov r1, #6
	mul r2, r0, r1
	ldr r0, _02171544 // =0x02173224
	ldr r1, _02171548 // =0x0000FFFF
	ldrh r0, [r0, r2]
	cmp r0, r1
	moveq r0, #1
	ldmeqia sp!, {r3, pc}
	sub r1, r1, #1
	cmp r0, r1
	bne _02171530
	bl SaveGame__GetGameProgress
	cmp r0, #0x27
	movge r0, #1
	movlt r0, #0
	ldmia sp!, {r3, pc}
_02171530:
	bl SaveGame__GetMissionStatus
	cmp r0, #3
	moveq r0, #1
	movne r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02171544: .word 0x02173224
_02171548: .word 0x0000FFFF
	arm_func_end NpcViking__Func_21714EC

	arm_func_start NpcViking__Func_217154C
NpcViking__Func_217154C: // 0x0217154C
	ldr r0, _021715BC // =gameState
	ldr r0, [r0, #0xcc]
	mov r0, r0, lsl #0x10
	movs ip, r0, lsr #0x10
	moveq r0, #0
	bxeq lr
	ldr r1, _021715C0 // =0x0217320C
	mov r3, #4
_0217156C:
	add r0, r1, r3, lsl #2
	ldrh r0, [r0, #2]
	mov r2, r3, lsl #2
	cmp ip, r0
	ldreqh ip, [r1, r2]
	subs r3, r3, #1
	bpl _0217156C
	ldr r1, _021715C4 // =0x02173220
	mov r2, #0
_02171590:
	ldrh r0, [r1, #0]
	cmp ip, r0
	moveq r0, r2, lsl #0x10
	moveq r0, r0, lsr #0x10
	bxeq lr
	add r2, r2, #1
	cmp r2, #0x46
	add r1, r1, #6
	blt _02171590
	mov r0, #0
	bx lr
	.align 2, 0
_021715BC: .word gameState
_021715C0: .word 0x0217320C
_021715C4: .word 0x02173220
	arm_func_end NpcViking__Func_217154C
