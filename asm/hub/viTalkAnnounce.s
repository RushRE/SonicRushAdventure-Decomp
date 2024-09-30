	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start ViTalkAnnounce__Create
ViTalkAnnounce__Create: // 0x0216B6C0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r4, _0216B790 // =0x00001010
	mov r6, r0
	mov r2, #0
	ldr r0, _0216B794 // =ViTalkAnnounce__Main
	ldr r1, _0216B798 // =ViTalkAnnounce__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl ViTalkAnnounce__CreateInternal
	bl GetTaskWork_
	mov r5, r0
	strh r6, [r5]
	bl ViHubAreaPreview__Func_215A888
	ldr r0, _0216B79C // =0x03FF03FF
	ldr r1, _0216B7A0 // =0x06000800
	mov r2, #0x800
	bl MIi_CpuClear32
	ldr r1, _0216B7A4 // =0x06007FE0
	mov r0, #0
	mov r2, #0x20
	bl MIi_CpuClearFast
	ldrh r0, [r5, #0]
	bl ovl05_2152B64
	mov r4, r0
	bl HubControl__GetFileFrom_ViMsg
	ldrh r1, [r4, #0]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	add r0, r5, #4
	bl ViEvtCmnAnnounce__Func_216D088
	ldrh r0, [r5, #0]
	bl ViTalkAnnounce__Func_216B92C
	cmp r0, #0
	beq _0216B778
	mov r0, #0x3f
	bl ovl05_21543D4
	bl ovl05_21543EC
	ldrh r1, [r4, #2]
	add r0, r5, #4
	mov r2, #9
	bl ViEvtCmnAnnounce__Func_216D1F4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
_0216B778:
	ldrh r1, [r4, #2]
	add r0, r5, #4
	mov r2, #4
	bl ViEvtCmnAnnounce__Func_216D1F4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0216B790: .word 0x00001010
_0216B794: .word ViTalkAnnounce__Main
_0216B798: .word ViTalkAnnounce__Destructor
_0216B79C: .word 0x03FF03FF
_0216B7A0: .word 0x06000800
_0216B7A4: .word 0x06007FE0
	arm_func_end ViTalkAnnounce__Create

	arm_func_start ViTalkAnnounce__CreateInternal
ViTalkAnnounce__CreateInternal: // 0x0216B7A8
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldrh r4, [sp, #0x18]
	ldrb lr, [sp, #0x1c]
	mov ip, #0x154
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r1, r0
	mov r0, #0x154
	bl CPPHelpers__Alloc
	cmp r0, #0
	beq _0216B7EC
	add r0, r0, #4
	bl ViEvtCmnAnnounce__Constructor
_0216B7EC:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end ViTalkAnnounce__CreateInternal

	arm_func_start ViTalkAnnounce__Func_216B7F8
ViTalkAnnounce__Func_216B7F8: // 0x0216B7F8
	stmdb sp!, {r3, lr}
	add r0, r0, #4
	bl ViEvtCmnAnnounce__Func_216D194
	bl ViHubAreaPreview__Func_215A96C
	ldmia sp!, {r3, pc}
	arm_func_end ViTalkAnnounce__Func_216B7F8

	arm_func_start ViTalkAnnounce__Main
ViTalkAnnounce__Main: // 0x0216B80C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #4
	bl ViEvtCmnAnnounce__Func_216D208
	add r0, r4, #4
	bl ViEvtCmnAnnounce__Func_216D2E8
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldrh r0, [r4, #0]
	cmp r0, #0
	bne _0216B850
	mov r0, #0x11
	bl ViDockNpcGroup__Func_2168744
	mov r0, #0
	bl ViDockNpcGroup__Func_2168754
	b _0216B87C
_0216B850:
	cmp r0, #0xc
	bne _0216B86C
	mov r0, #0x15
	bl ViDockNpcGroup__Func_2168744
	mov r0, #0x1c
	bl ViDockNpcGroup__Func_2168754
	b _0216B87C
_0216B86C:
	mov r0, #0
	bl ViDockNpcGroup__Func_2168744
	mov r0, #0
	bl ViDockNpcGroup__Func_2168754
_0216B87C:
	ldrh r0, [r4, #0]
	cmp r0, #0x1d
	blo _0216B8BC
	cmp r0, #0x24
	bhi _0216B8BC
	sub r2, r0, #0x1d
	mov r1, r2, lsr #0x1f
	rsb r0, r1, r2, lsl #31
	add r1, r1, r0, ror #31
	add r0, r2, r2, lsr #31
	add r1, r1, #1
	mov r0, r0, lsl #0xf
	mov r1, r1, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r1, lsr #0x10
	bl SaveGame__Func_205BDC8
_0216B8BC:
	ldrh r0, [r4, #0]
	bl ViTalkAnnounce__Func_216B92C
	cmp r0, #0
	beq _0216B8D8
	bl ovl05_2154474
	mov r0, #0x7f
	bl ovl05_21543D4
_0216B8D8:
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
	arm_func_end ViTalkAnnounce__Main

	arm_func_start ViTalkAnnounce__Destructor
ViTalkAnnounce__Destructor: // 0x0216B8E0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl ViTalkAnnounce__Func_216B7F8
	mov r0, r4
	bl ViTalkAnnounce__Func_216B8FC
	ldmia sp!, {r4, pc}
	arm_func_end ViTalkAnnounce__Destructor

	arm_func_start ViTalkAnnounce__Func_216B8FC
ViTalkAnnounce__Func_216B8FC: // 0x0216B8FC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _0216B920
	add r0, r4, #4
	bl ViEvtCmnAnnounce__VTableFunc_216D040
	mov r0, r4
	bl CPPHelpers__Free
_0216B920:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViTalkAnnounce__Func_216B8FC

	arm_func_start ViTalkAnnounce__Func_216B92C
ViTalkAnnounce__Func_216B92C: // 0x0216B92C
	add r0, r0, #0xe5
	add r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	movls r0, #1
	movhi r0, #0
	bx lr
	arm_func_end ViTalkAnnounce__Func_216B92C
