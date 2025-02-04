	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CreateViDockNpcTalk
CreateViDockNpcTalk: // 0x021687AC
	ldr ip, _021687B4 // =ViDockNpcTalk__Create
	bx ip
	.align 2, 0
_021687B4: .word ViDockNpcTalk__Create
	arm_func_end CreateViDockNpcTalk

	arm_func_start ViDockNpcTalk__Create
ViDockNpcTalk__Create: // 0x021687B8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	ldr r4, _0216896C // =0x00001010
	mov r7, r0
	mov r2, #0
	ldr r0, _02168970 // =Task__OV05Unknown216897C__Main
	ldr r1, _02168974 // =Task__OV05Unknown216897C__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl Task__OV05Unknown216897C__CreateInternal
	bl GetTaskWork_
	mov r4, r0
	strh r7, [r4]
	bl ViDock__Func_215E06C
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	bl _ZN10HubControl12Func_215A888Ev
	ldrh r0, [r4, #0]
	cmp r0, #0
	bne _02168848
	bl ViDock__Func_215E0CC
	mov r5, r0
	bl TalkHelpers__Func_2153650
	strh r0, [sp, #8]
	mov r0, r5
	bl TalkHelpers__GetInteractionID_2
	strh r0, [sp, #0xa]
	mov r0, r5
	bl TalkHelpers__GetInteractionID2
	strh r0, [sp, #0xc]
	mov r0, r5
	bl TalkHelpers__GetInteractionID
	strh r0, [sp, #0xe]
	b _02168858
_02168848:
	bl DockHelpers__GetNpcMessageInfo
	add r1, sp, #8
	mov r2, #8
	bl MIi_CpuCopy16
_02168858:
	ldrh r8, [sp, #0xe]
	ldr r0, _02168978 // =0x0000FFFF
	mov r1, #0
	cmp r8, r0
	beq _021688A8
	cmp r7, #0
	subne r0, r7, #1
	movne r0, r0, lsl #0x10
	movne r7, r0, lsr #0x10
	bne _021688A8
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [sp, #8]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldr r3, _02168978 // =0x0000FFFF
	mov r2, r8
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D680
	mov r6, #0
	mov r1, #1
_021688A8:
	cmp r1, #0
	bne _02168948
	ldrh r0, [r4, #0]
	mov r6, #0
	cmp r0, #0
	bne _021688DC
	mov r0, r5
	bl TalkHelpers__Func_21536D8
	strh r0, [sp, #0xe]
	ldrh r1, [sp, #0xe]
	ldr r0, _02168978 // =0x0000FFFF
	cmp r1, r0
	movne r6, #1
_021688DC:
	cmp r6, #0
	beq _02168910
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [sp, #8]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldrh r2, [sp, #0xe]
	ldrh r3, [sp, #0xc]
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D680
	mov r6, #0
	bl ViDock__Func_215E098
	b _02168948
_02168910:
	bl _ZN10HubControl21GetFileFrom_ViMsgCtrlEv
	ldrh r1, [sp, #8]
	bl FileUnknown__GetAOUFile
	mov r1, r0
	ldrh r2, [sp, #0xa]
	ldrh r3, [sp, #0xc]
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D680
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D778
	mov r1, r0
	mov r0, r7
	bl FX_ModS32
	mov r6, r0
_02168948:
	mov r1, r6, lsl #0x10
	add r0, r4, #4
	mov r1, r1, lsr #0x10
	bl ViEvtCmnTalk__Func_216D7D0
	mov r0, #1
	mov r1, r0
	bl ViDock__Func_215E340
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0216896C: .word 0x00001010
_02168970: .word Task__OV05Unknown216897C__Main
_02168974: .word Task__OV05Unknown216897C__Destructor
_02168978: .word 0x0000FFFF
	arm_func_end ViDockNpcTalk__Create

	arm_func_start Task__OV05Unknown216897C__CreateInternal
Task__OV05Unknown216897C__CreateInternal: // 0x0216897C
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldrh r4, [sp, #0x18]
	ldrb lr, [sp, #0x1c]
	ldr ip, _021689CC // =0x000004BC
	stmia sp, {r4, lr}
	str ip, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r1, r0
	ldr r0, _021689CC // =0x000004BC
	bl _ZnwmPv
	cmp r0, #0
	beq _021689C0
	add r0, r0, #4
	bl ViEvtCmnTalk__Constructor
_021689C0:
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_021689CC: .word 0x000004BC
	arm_func_end Task__OV05Unknown216897C__CreateInternal

	arm_func_start Task__OV05Unknown216897C__Func_21689D0
Task__OV05Unknown216897C__Func_21689D0: // 0x021689D0
	stmdb sp!, {r3, lr}
	add r0, r0, #4
	bl ViEvtCmnTalk__Func_216D72C
	bl _ZN10HubControl12Func_215A96CEv
	ldmia sp!, {r3, pc}
	arm_func_end Task__OV05Unknown216897C__Func_21689D0

	arm_func_start Task__OV05Unknown216897C__Main
Task__OV05Unknown216897C__Main: // 0x021689E4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D81C
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D888
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D8A4
	bl _ZN15CViDockNpcGroup12SetSelectionEl
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D89C
	cmp r0, #0x16
	addls pc, pc, r0, lsl #2
	b _02168BE0
_02168A28: // jump table
	b _02168BE0 // case 0
	b _02168A84 // case 1
	b _02168A90 // case 2
	b _02168AAC // case 3
	b _02168AB8 // case 4
	b _02168AC4 // case 5
	b _02168AD0 // case 6
	b _02168ADC // case 7
	b _02168B4C // case 8
	b _02168AE8 // case 9
	b _02168AF4 // case 10
	b _02168B00 // case 11
	b _02168B0C // case 12
	b _02168B18 // case 13
	b _02168B24 // case 14
	b _02168B30 // case 15
	b _02168B58 // case 16
	b _02168B64 // case 17
	b _02168BE0 // case 18
	b _02168B70 // case 19
	b _02168B7C // case 20
	b _02168B98 // case 21
	b _02168BB4 // case 22
_02168A84:
	mov r0, #3
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168A90:
	mov r0, #4
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	bl _ZN10HubControl12Func_215B4E0Ev
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl _ZN15CViDockNpcGroup12SetSelectionEl
	b _02168BE8
_02168AAC:
	mov r0, #7
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168AB8:
	mov r0, #8
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168AC4:
	mov r0, #0xc
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168AD0:
	mov r0, #0xd
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168ADC:
	mov r0, #0x13
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168AE8:
	mov r0, #0
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168AF4:
	mov r0, #0x16
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168B00:
	mov r0, #5
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168B0C:
	mov r0, #0x17
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168B18:
	mov r0, #0x18
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168B24:
	mov r0, #0x19
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168B30:
	mov r0, #7
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D8A4
	add r0, r0, #5
	bl _ZN15CViDockNpcGroup12SetSelectionEl
	b _02168BE8
_02168B4C:
	mov r0, #0xa
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168B58:
	mov r0, #0xb
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168B64:
	mov r0, #0x1a
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168B70:
	mov r0, #0x1c
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168B7C:
	mov r0, #0x1d
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	bl _ZN10HubControl12Func_215B978Ev
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bl _ZN15CViDockNpcGroup12SetSelectionEl
	b _02168BE8
_02168B98:
	mov r0, #7
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D8A4
	add r0, r0, #0x1d
	bl _ZN15CViDockNpcGroup12SetSelectionEl
	b _02168BE8
_02168BB4:
	add r0, r4, #4
	bl ViEvtCmnTalk__Func_216D8A4
	mov r4, r0
	bl SaveGame__GetProgressFlags_0x100000
	cmp r0, #0
	bne _02168BD4
	mov r0, r4
	bl SaveGame__SetProgressFlags_0x100000
_02168BD4:
	mov r0, #0
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
	b _02168BE8
_02168BE0:
	mov r0, #0
	bl _ZN15CViDockNpcGroup13SetTalkActionEm
_02168BE8:
	bl DestroyCurrentTask
	ldmia sp!, {r4, pc}
	arm_func_end Task__OV05Unknown216897C__Main

	arm_func_start Task__OV05Unknown216897C__Destructor
Task__OV05Unknown216897C__Destructor: // 0x02168BF0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl Task__OV05Unknown216897C__Func_21689D0
	mov r0, r4
	bl Task__OV05Unknown216897C__Func_2168C0C
	ldmia sp!, {r4, pc}
	arm_func_end Task__OV05Unknown216897C__Destructor

	arm_func_start Task__OV05Unknown216897C__Func_2168C0C
Task__OV05Unknown216897C__Func_2168C0C: // 0x02168C0C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #0x10]
	cmp r4, #0
	beq _02168C30
	add r0, r4, #4
	bl ViEvtCmnTalk__VTableFunc_216D618
	mov r0, r4
	bl _ZdlPv
_02168C30:
	mov r0, #0
	str r0, [r5, #0x10]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Task__OV05Unknown216897C__Func_2168C0C
