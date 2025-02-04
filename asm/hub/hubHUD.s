	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
HubHUD__TaskSingleton: // 0x02173A58
	.space 0x04

	.text

	arm_func_start HubHUD__Create
HubHUD__Create: // 0x02160040
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, _02160090 // =0x00001020
	mov r2, #0
	ldr r0, _02160094 // =HubHUD__Main
	ldr r1, _02160098 // =HubHUD__Destructor
	mov r3, r2
	str r4, [sp]
	mov r4, #0x10
	str r4, [sp, #4]
	bl HubHUD__CreateInternal
	ldr r1, _0216009C // =HubHUD__TaskSingleton
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	bl HubHUD__Func_216040C
	mov r0, #7
	str r0, [r4, #0x234]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160090: .word 0x00001020
_02160094: .word HubHUD__Main
_02160098: .word HubHUD__Destructor
_0216009C: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Create

	arm_func_start HubHUD__CreateInternal
HubHUD__CreateInternal: // 0x021600A0
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldrh lr, [sp, #0x18]
	ldrb ip, [sp, #0x1c]
	mov r4, #0x254
	str lr, [sp]
	str ip, [sp, #4]
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	bl GetTaskWork_
	mov r1, r0
	mov r0, #0x254
	bl _ZnwmPv
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	arm_func_end HubHUD__CreateInternal

	arm_func_start HubHUD__Func_21600E4
HubHUD__Func_21600E4: // 0x021600E4
	stmdb sp!, {r3, lr}
	ldr r0, _0216010C // =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyTask
	ldr r0, _0216010C // =HubHUD__TaskSingleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216010C: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_21600E4

	arm_func_start HubHUD__Func_2160110
HubHUD__Func_2160110: // 0x02160110
	stmdb sp!, {r4, r5, r6, lr}
	movs r6, r0
	ldr r0, _02160168 // =HubHUD__TaskSingleton
	mov r5, r1
	ldr r0, [r0, #0]
	moveq r5, #0
	bl GetTaskWork_
	mov r4, r0
	cmp r6, #0
	beq _02160148
	ldr r0, [r4, #0]
	orr r0, r0, #1
	str r0, [r4]
	b _02160158
_02160148:
	ldr r1, [r4, #0]
	bic r1, r1, #1
	str r1, [r4]
	bl HubHUD__Func_2160AE0
_02160158:
	mov r0, r4
	mov r1, r5
	bl HubHUD__Func_2160D10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02160168: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_2160110

	arm_func_start HubHUD__Func_216016C
HubHUD__Func_216016C: // 0x0216016C
	stmdb sp!, {r3, lr}
	ldr r0, _02160190 // =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	tst r0, #2
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02160190: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_216016C

	arm_func_start HubHUD__Func_2160194
HubHUD__Func_2160194: // 0x02160194
	stmdb sp!, {r3, lr}
	ldr r0, _021601B8 // =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r1, [r0, #0]
	bic r1, r1, #2
	str r1, [r0]
	bl HubHUD__Func_2160AE0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021601B8: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_2160194

	arm_func_start HubHUD__Func_21601BC
HubHUD__Func_21601BC: // 0x021601BC
	stmdb sp!, {r3, lr}
	ldr r0, _021601F4 // =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	tst r0, #2
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, _021601F8 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x20
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021601F4: .word HubHUD__TaskSingleton
_021601F8: .word padInput
	arm_func_end HubHUD__Func_21601BC

	arm_func_start HubHUD__Func_21601FC
HubHUD__Func_21601FC: // 0x021601FC
	stmdb sp!, {r3, lr}
	ldr r0, _02160234 // =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	tst r0, #2
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, _02160238 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x40
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02160234: .word HubHUD__TaskSingleton
_02160238: .word padInput
	arm_func_end HubHUD__Func_21601FC

	arm_func_start HubHUD__Func_216023C
HubHUD__Func_216023C: // 0x0216023C
	stmdb sp!, {r3, lr}
	ldr r0, _02160274 // =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	tst r0, #2
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, _02160278 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x10
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_02160274: .word HubHUD__TaskSingleton
_02160278: .word padInput
	arm_func_end HubHUD__Func_216023C

	arm_func_start HubHUD__Func_216027C
HubHUD__Func_216027C: // 0x0216027C
	stmdb sp!, {r3, lr}
	ldr r0, _021602B4 // =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0]
	tst r0, #2
	moveq r0, #0
	ldmeqia sp!, {r3, pc}
	ldr r0, _021602B8 // =padInput
	ldrh r0, [r0, #0]
	tst r0, #0x80
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021602B4: .word HubHUD__TaskSingleton
_021602B8: .word padInput
	arm_func_end HubHUD__Func_216027C

	arm_func_start HubHUD__Func_21602BC
HubHUD__Func_21602BC: // 0x021602BC
	stmdb sp!, {r3, lr}
	ldr r0, _021602D4 // =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0x244]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021602D4: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_21602BC

	arm_func_start HubHUD__Func_21602D8
HubHUD__Func_21602D8: // 0x021602D8
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _02160340 // =HubHUD__TaskSingleton
	mov r5, r0
	ldr r0, [r2, #0]
	mov r4, r1
	bl GetTaskWork_
	ldr r1, [r0, #0x244]
	cmp r1, #0
	beq _02160324
	cmp r5, #0
	addne r1, r0, #0x200
	ldrnesh r1, [r1, #0x48]
	strneh r1, [r5]
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r0, #0x200
	ldrsh r0, [r0, #0x4a]
	strh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
_02160324:
	cmp r5, #0
	movne r0, #0
	strneh r0, [r5]
	cmp r4, #0
	movne r0, #0
	strneh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02160340: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_21602D8

	arm_func_start HubHUD__Func_2160344
HubHUD__Func_2160344: // 0x02160344
	stmdb sp!, {r3, r4, r5, lr}
	ldr r2, _021603AC // =HubHUD__TaskSingleton
	mov r5, r0
	ldr r0, [r2, #0]
	mov r4, r1
	bl GetTaskWork_
	ldr r1, [r0, #0x244]
	cmp r1, #0
	beq _02160390
	cmp r5, #0
	addne r1, r0, #0x200
	ldrneh r1, [r1, #0x40]
	strneh r1, [r5]
	cmp r4, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r0, #0x200
	ldrh r0, [r0, #0x42]
	strh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
_02160390:
	cmp r5, #0
	movne r0, #0
	strneh r0, [r5]
	cmp r4, #0
	movne r0, #0
	strneh r0, [r4]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021603AC: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_2160344

	arm_func_start HubHUD__Func_21603B0
HubHUD__Func_21603B0: // 0x021603B0
	stmdb sp!, {r3, r4, r5, lr}
	movs r5, r0
	ldr r0, _021603EC // =HubHUD__TaskSingleton
	mov r4, r1
	ldr r0, [r0, #0]
	moveq r4, #0
	bl GetTaskWork_
	ldr r1, [r0, #0xcc]
	cmp r5, #0
	orrne r1, r1, #1
	biceq r1, r1, #1
	str r1, [r0, #0xcc]
	mov r1, r4
	bl HubHUD__Func_2160CC4
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021603EC: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_21603B0

	arm_func_start HubHUD__Func_21603F0
HubHUD__Func_21603F0: // 0x021603F0
	stmdb sp!, {r3, lr}
	ldr r0, _02160408 // =HubHUD__TaskSingleton
	ldr r0, [r0, #0]
	bl GetTaskWork_
	ldr r0, [r0, #0x238]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02160408: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_21603F0

	arm_func_start HubHUD__Func_216040C
HubHUD__Func_216040C: // 0x0216040C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #1
	bl _ZN10HubControl17GetFileFrom_ViActEt
	str r0, [r4, #0x24c]
	mov r0, #0
	bl _ZN10HubControl20GetFileFrom_ViActLocEt
	str r0, [r4, #0x250]
	mov r0, r4
	bl HubHUD__Func_2160450
	mov r0, r4
	bl HubHUD__Func_2160538
	mov r0, r4
	bl HubHUD__Func_216062C
	mov r0, #0
	str r0, [r4, #0x244]
	ldmia sp!, {r4, pc}
	arm_func_end HubHUD__Func_216040C

	arm_func_start HubHUD__Func_2160450
HubHUD__Func_2160450: // 0x02160450
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0xcc
	bl MIi_CpuClear32
	ldr r0, [r4, #0x24c]
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #1
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, _02160534 // =0x05000600
	add r0, r4, #4
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	ldr r1, [r4, #0x24c]
	mov r3, #4
	bl AnimatorSprite__Init
	mov r0, #0
	strh r0, [r4, #0x54]
	mov r0, #0x10
	strh r0, [r4, #0x58]
	ldr r0, [r4, #0x24c]
	mov r1, #3
	bl Sprite__GetSpriteSize3FromAnim
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #1
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, _02160534 // =0x05000600
	add r0, r4, #0x68
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	ldr r1, [r4, #0x24c]
	mov r2, #3
	mov r3, #0x204
	bl AnimatorSprite__Init
	mov r0, #1
	strh r0, [r4, #0xb8]
	mov r0, #0x10
	strh r0, [r4, #0xbc]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02160534: .word 0x05000600
	arm_func_end HubHUD__Func_2160450

	arm_func_start HubHUD__Func_2160538
HubHUD__Func_2160538: // 0x02160538
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x238]
	str r0, [r4, #0x23c]
	add r1, r4, #0xcc
	mov r2, #0xd0
	bl MIi_CpuClear32
	ldr r0, [r4, #0x250]
	add r5, r4, #0xd4
	bl Sprite__GetSpriteSize1
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, _02160624 // =0x05000200
	mov r0, #1
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r0, [sp, #0x18]
	mov r0, r5
	ldr r1, [r4, #0x250]
	mov r3, r2
	bl AnimatorSprite__Init
	mov r0, #2
	strh r0, [r5, #0x50]
	mov r0, #0x10
	strh r0, [r5, #0x54]
	add r5, r4, #0x138
	ldr r0, [r4, #0x250]
	bl Sprite__GetSpriteSize3
	mov r1, r0
	mov r0, #1
	bl VRAMSystem__AllocSpriteVram
	mov r3, #1
	str r3, [sp]
	mov r2, #0
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r1, _02160628 // =0x05000600
	mov r0, r5
	str r1, [sp, #0x10]
	str r2, [sp, #0x14]
	str r3, [sp, #0x18]
	ldr r1, [r4, #0x250]
	mov r3, r2
	bl AnimatorSprite__Init
	mov r0, #2
	strh r0, [r5, #0x50]
	mov r0, #0x10
	strh r0, [r5, #0x54]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02160624: .word 0x05000200
_02160628: .word 0x05000600
	arm_func_end HubHUD__Func_2160538

	arm_func_start HubHUD__Func_216062C
HubHUD__Func_216062C: // 0x0216062C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	add r0, r4, #0x19c
	bl TouchField__Init
	mov r1, #0
	ldr r0, _021606A0 // =HubHUD__Func_2160DCC
	strb r1, [r4, #0x1ac]
	str r0, [sp]
	ldr r2, _021606A4 // =TouchField__PointInRect
	mov r3, r1
	add r0, r4, #0x1b4
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	mov r1, #0
	ldr r0, _021606A8 // =HubHUD__Func_2160EC0
	str r1, [r4, #0x22c]
	str r0, [sp]
	ldr r2, _021606A4 // =TouchField__PointInRect
	mov r3, r1
	add r0, r4, #0x1ec
	str r1, [sp, #4]
	bl TouchField__InitAreaShape
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x230]
	bl HubHUD__Func_2160CA4
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_021606A0: .word HubHUD__Func_2160DCC
_021606A4: .word TouchField__PointInRect
_021606A8: .word HubHUD__Func_2160EC0
	arm_func_end HubHUD__Func_216062C

	arm_func_start HubHUD__Func_21606AC
HubHUD__Func_21606AC: // 0x021606AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl HubHUD__Func_216074C
	mov r0, r4
	bl HubHUD__Func_216070C
	mov r0, r4
	bl HubHUD__Func_21606CC
	ldmia sp!, {r4, pc}
	arm_func_end HubHUD__Func_21606AC

	arm_func_start HubHUD__Func_21606CC
HubHUD__Func_21606CC: // 0x021606CC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, #0
	add r7, r0, #4
	mov r5, r6
	mov r4, #0x64
_021606E0:
	mov r0, r7
	bl AnimatorSprite__Release
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl MIi_CpuClear32
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0x64
	blt _021606E0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end HubHUD__Func_21606CC

	arm_func_start HubHUD__Func_216070C
HubHUD__Func_216070C: // 0x0216070C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r6, #0
	add r7, r0, #0xd4
	mov r5, r6
	mov r4, #0x64
_02160720:
	mov r0, r7
	bl AnimatorSprite__Release
	mov r0, r5
	mov r1, r7
	mov r2, r4
	bl MIi_CpuClear32
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0x64
	blt _02160720
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end HubHUD__Func_216070C

	arm_func_start HubHUD__Func_216074C
HubHUD__Func_216074C: // 0x0216074C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #0x19c
	mov r0, #0
	mov r2, #0x18
	bl MIi_CpuClear32
	add r1, r4, #0x1b4
	mov r0, #0
	mov r2, #0x70
	bl MIi_CpuClear32
	add r1, r4, #0x224
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	ldmia sp!, {r4, pc}
	arm_func_end HubHUD__Func_216074C

	arm_func_start HubHUD__Main
HubHUD__Main: // 0x02160788
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x19c
	bl TouchField__Process
	mov r6, #0
	str r6, [r4, #0x238]
	str r6, [r4, #0x23c]
	ldr r0, [r4, #0]
	mov r5, r6
	tst r0, #1
	beq _02160804
	ldr r7, [r4, #0x224]
	tst r7, #1
	beq _02160804
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _021607F4
	tst r7, #4
	beq _021607EC
	ldr r0, [r4, #0x224]
	mov r5, #1
	bic r0, r0, #4
	mov r6, r5
	str r0, [r4, #0x224]
_021607EC:
	tst r7, #2
	movne r6, #1
_021607F4:
	ldr r0, _021608D4 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #0x400
	movne r5, #1
_02160804:
	cmp r5, #0
	bne _02160868
	ldr r0, [r4, #0xcc]
	tst r0, #1
	beq _02160868
	ldr r7, [r4, #0x228]
	tst r7, #1
	beq _02160868
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _02160854
	tst r7, #4
	beq _0216084C
	mov r6, #1
	str r6, [r4, #0x238]
	ldr r0, [r4, #0x228]
	bic r0, r0, #4
	str r0, [r4, #0x228]
_0216084C:
	tst r7, #2
	movne r6, #1
_02160854:
	ldr r0, _021608D4 // =padInput
	ldrh r0, [r0, #4]
	tst r0, #0x800
	movne r0, #1
	strne r0, [r4, #0x238]
_02160868:
	cmp r5, #0
	beq _021608A4
	ldr r1, [r4, #0]
	mov r0, #0
	orr r2, r1, #2
	mov r1, #1
	str r2, [r4]
	bl HubHUD__Func_21603B0
	mov r2, #0
	add r0, r4, #4
	mov r1, #2
	str r2, [r4, #0x244]
	bl AnimatorSprite__SetAnimation
	ldr r0, _021608D8 // =HubHUD__Main_21608DC
	bl SetCurrentTaskMainEvent
_021608A4:
	mov r0, r4
	bl HubHUD__Func_2160AF4
	mov r0, r4
	bl HubHUD__Func_2160B58
	mov r0, r4
	bl HubHUD__Func_2160C08
	mov r0, r4
	bl HubHUD__Func_2160C68
	cmp r6, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	bl _ZN10HubControl12Func_2157154Ev
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021608D4: .word padInput
_021608D8: .word HubHUD__Main_21608DC
	arm_func_end HubHUD__Main

	arm_func_start HubHUD__Main_21608DC
HubHUD__Main_21608DC: // 0x021608DC
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	add r0, r4, #0x19c
	bl TouchField__Process
	ldr r0, [r4, #0]
	mov r5, #0
	tst r0, #2
	moveq r5, #1
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _02160920
	ldr r0, [r4, #0x224]
	tst r0, #4
	bicne r0, r0, #4
	strne r0, [r4, #0x224]
	movne r5, #1
_02160920:
	ldr r1, _02160A88 // =padInput
	ldr r0, _02160A8C // =0x00000402
	ldrh r1, [r1, #4]
	tst r1, r0
	movne r5, #1
	cmp r5, #0
	beq _02160978
	ldr r1, [r4, #0]
	mov r0, #1
	bic r2, r1, #2
	mov r1, r0
	str r2, [r4]
	bl HubHUD__Func_21603B0
	ldr r0, _02160A90 // =HubHUD__Main
	bl SetCurrentTaskMainEvent
	mov r0, r4
	bl HubHUD__Func_2160AE0
	mov r1, #0
	add r0, r4, #4
	str r1, [r4, #0x244]
	bl AnimatorSprite__SetAnimation
	b _02160A68
_02160978:
	bl _ZN10HubControl12Func_2157178Ev
	cmp r0, #0
	beq _02160A60
	ldr r0, [r4, #0x224]
	tst r0, #2
	bne _02160A60
	ldr r0, [r4, #0x244]
	cmp r0, #0
	beq _02160A04
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _021609BC
	ldr r0, _02160A94 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	movne r0, #1
	bne _021609C0
_021609BC:
	mov r0, #0
_021609C0:
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4, #0x244]
	beq _02160A68
	ldr r1, _02160A94 // =touchInput
	add r0, r4, #0x200
	ldrh ip, [r1, #0x14]
	ldrh r2, [r0, #0x40]
	ldrh r3, [r1, #0x16]
	sub r1, ip, r2
	strh r1, [r0, #0x48]
	ldrh r1, [r0, #0x42]
	sub r1, r3, r1
	strh r1, [r0, #0x4a]
	strh ip, [r0, #0x40]
	strh r3, [r0, #0x42]
	b _02160A68
_02160A04:
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _02160A24
	ldr r0, _02160A94 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #1
	bne _02160A28
_02160A24:
	mov r0, #0
_02160A28:
	cmp r0, #0
	beq _02160A68
	mov r0, #1
	ldr r1, _02160A94 // =touchInput
	str r0, [r4, #0x244]
	ldrh r3, [r1, #0x1c]
	add r0, r4, #0x200
	mov r2, #0
	strh r3, [r0, #0x40]
	ldrh r1, [r1, #0x1e]
	strh r1, [r0, #0x42]
	strh r2, [r0, #0x48]
	strh r2, [r0, #0x4a]
	b _02160A68
_02160A60:
	mov r0, #0
	str r0, [r4, #0x244]
_02160A68:
	mov r0, r4
	bl HubHUD__Func_2160AF4
	mov r0, r4
	bl HubHUD__Func_2160B58
	mov r0, #0
	str r0, [r4, #0x238]
	str r0, [r4, #0x23c]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02160A88: .word padInput
_02160A8C: .word 0x00000402
_02160A90: .word HubHUD__Main
_02160A94: .word touchInput
	arm_func_end HubHUD__Main_21608DC

	arm_func_start HubHUD__Destructor
HubHUD__Destructor: // 0x02160A98
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl GetTaskWork_
	bl HubHUD__Func_21606AC
	mov r0, r4
	bl HubHUD__Func_2160AC4
	ldr r0, _02160AC0 // =HubHUD__TaskSingleton
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160AC0: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Destructor

	arm_func_start HubHUD__Func_2160AC4
HubHUD__Func_2160AC4: // 0x02160AC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x10]
	bl _ZdlPv
	mov r0, #0
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end HubHUD__Func_2160AC4

	arm_func_start HubHUD__Func_2160AE0
HubHUD__Func_2160AE0: // 0x02160AE0
	ldr ip, _02160AF0 // =AnimatorSprite__SetAnimation
	add r0, r0, #0x68
	mov r1, #3
	bx ip
	.align 2, 0
_02160AF0: .word AnimatorSprite__SetAnimation
	arm_func_end HubHUD__Func_2160AE0

	arm_func_start HubHUD__Func_2160AF4
HubHUD__Func_2160AF4: // 0x02160AF4
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	str r4, [sp]
	ldr r0, [r4, #0]
	tst r0, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r0, #0
	str r0, [sp, #4]
	ldr r1, _02160B54 // =HubHUD__Func_2160FC0
	add r2, sp, #0
	add r0, r4, #4
	bl AnimatorSprite__ProcessAnimation
	ldr r0, [r4, #0]
	tst r0, #2
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x68
	bl AnimatorSprite__ProcessAnimation
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02160B54: .word HubHUD__Func_2160FC0
	arm_func_end HubHUD__Func_2160AF4

	arm_func_start HubHUD__Func_2160B58
HubHUD__Func_2160B58: // 0x02160B58
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	tst r0, #1
	ldmeqia sp!, {r4, pc}
	add r0, r4, #4
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0]
	tst r0, #2
	ldmeqia sp!, {r4, pc}
	mov r0, #8
	mov r1, #0x1000
	mov r2, r1
	strh r0, [r4, #0x70]
	mov ip, #0x70
	add r0, r4, #0x68
	mov r3, #0xc000
	strh ip, [r4, #0x72]
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r0, #0x70
	strh r0, [r4, #0x70]
	mov r1, #8
	add r0, r4, #0x68
	strh r1, [r4, #0x72]
	bl AnimatorSprite__DrawFrame
	mov r0, #0xf8
	mov r1, #0x1000
	mov r2, r1
	strh r0, [r4, #0x70]
	mov ip, #0x50
	add r0, r4, #0x68
	mov r3, #0x4000
	strh ip, [r4, #0x72]
	bl AnimatorSprite__DrawFrameRotoZoom
	mov r0, #0x90
	strh r0, [r4, #0x70]
	mov r1, #0x1000
	mov r0, #0xb8
	strh r0, [r4, #0x72]
	add r0, r4, #0x68
	mov r2, r1
	mov r3, #0x8000
	bl AnimatorSprite__DrawFrameRotoZoom
	ldmia sp!, {r4, pc}
	arm_func_end HubHUD__Func_2160B58

	arm_func_start HubHUD__Func_2160C08
HubHUD__Func_2160C08: // 0x02160C08
	stmdb sp!, {r3, lr}
	sub sp, sp, #8
	ldr r1, _02160C60 // =renderCurrentDisplay
	str r0, [sp]
	ldr r1, [r1, #0]
	cmp r1, #1
	moveq r2, #1
	ldr r1, [r0, #0xcc]
	movne r2, #0
	tst r1, #1
	addeq sp, sp, #8
	ldmeqia sp!, {r3, pc}
	add r1, r0, #0xd4
	mov r0, #0x64
	mla r0, r2, r0, r1
	mov r3, #1
	ldr r1, _02160C64 // =HubHUD__Func_2160FC0
	add r2, sp, #0
	str r3, [sp, #4]
	bl AnimatorSprite__ProcessAnimation
	add sp, sp, #8
	ldmia sp!, {r3, pc}
	.align 2, 0
_02160C60: .word renderCurrentDisplay
_02160C64: .word HubHUD__Func_2160FC0
	arm_func_end HubHUD__Func_2160C08

	arm_func_start HubHUD__Func_2160C68
HubHUD__Func_2160C68: // 0x02160C68
	stmdb sp!, {r3, lr}
	ldr r1, _02160CA0 // =renderCurrentDisplay
	ldr r1, [r1, #0]
	cmp r1, #1
	moveq r2, #1
	ldr r1, [r0, #0xcc]
	movne r2, #0
	tst r1, #1
	ldmeqia sp!, {r3, pc}
	add r1, r0, #0xd4
	mov r0, #0x64
	mla r0, r2, r0, r1
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, pc}
	.align 2, 0
_02160CA0: .word renderCurrentDisplay
	arm_func_end HubHUD__Func_2160C68

	arm_func_start HubHUD__Func_2160CA4
HubHUD__Func_2160CA4: // 0x02160CA4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0
	bl HubHUD__Func_2160D10
	mov r0, r4
	mov r1, #0
	bl HubHUD__Func_2160CC4
	ldmia sp!, {r4, pc}
	arm_func_end HubHUD__Func_2160CA4

	arm_func_start HubHUD__Func_2160CC4
HubHUD__Func_2160CC4: // 0x02160CC4
	stmdb sp!, {r4, lr}
	cmp r1, #0
	mov r4, r0
	mov r1, #1
	beq _02160CE8
	mov r2, r1
	str r1, [r4, #0x228]
	bl HubHUD__Func_2160D40
	ldmia sp!, {r4, pc}
_02160CE8:
	mov r2, #0
	str r2, [r4, #0x228]
	bl HubHUD__Func_2160D40
	add r0, r4, #0xd4
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0x138
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, pc}
	arm_func_end HubHUD__Func_2160CC4

	arm_func_start HubHUD__Func_2160D10
HubHUD__Func_2160D10: // 0x02160D10
	stmdb sp!, {r3, lr}
	cmp r1, #0
	mov r1, #0
	beq _02160D30
	mov r2, #1
	str r2, [r0, #0x224]
	bl HubHUD__Func_2160D40
	ldmia sp!, {r3, pc}
_02160D30:
	mov r2, r1
	str r1, [r0, #0x224]
	bl HubHUD__Func_2160D40
	ldmia sp!, {r3, pc}
	arm_func_end HubHUD__Func_2160D10

	arm_func_start HubHUD__Func_2160D40
HubHUD__Func_2160D40: // 0x02160D40
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r4, r1
	add r0, r5, r4, lsl #2
	cmp r2, #0
	ldr r0, [r0, #0x22c]
	beq _02160D8C
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r1, r5, #0x1b4
	mov r0, #0x38
	mla r1, r4, r0, r1
	ldr r2, _02160DC8 // =0x0000FFFF
	add r0, r5, #0x19c
	bl TouchField__AddArea
	add r0, r5, r4, lsl #2
	mov r1, #1
	str r1, [r0, #0x22c]
	ldmia sp!, {r4, r5, r6, pc}
_02160D8C:
	cmp r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, #0x38
	mul r6, r4, r0
	add r1, r5, #0x1b4
	add r0, r5, #0x19c
	add r1, r1, r6
	bl TouchField__RemoveArea
	add r0, r5, r6
	mov r1, #0
	str r1, [r0, #0x1c8]
	str r1, [r0, #0x1cc]
	add r0, r5, r4, lsl #2
	str r1, [r0, #0x22c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02160DC8: .word 0x0000FFFF
	arm_func_end HubHUD__Func_2160D40

	arm_func_start HubHUD__Func_2160DCC
HubHUD__Func_2160DCC: // 0x02160DCC
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _02160EBC // =HubHUD__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	bl GetTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x224]
	ldr r0, [r5, #0x14]
	tst r1, #1
	beq _02160E00
	tst r0, #0x800
	beq _02160E14
_02160E00:
	ldr r0, [r4, #0x224]
	bic r0, r0, #4
	bic r0, r0, #2
	str r0, [r4, #0x224]
	ldmia sp!, {r4, r5, r6, pc}
_02160E14:
	ldr r0, [r6, #0]
	cmp r0, #0x400000
	bhi _02160E30
	bhs _02160E68
	cmp r0, #0x40000
	beq _02160E4C
	ldmia sp!, {r4, r5, r6, pc}
_02160E30:
	cmp r0, #0x2000000
	bhi _02160E40
	beq _02160E68
	ldmia sp!, {r4, r5, r6, pc}
_02160E40:
	cmp r0, #0x8000000
	beq _02160E88
	ldmia sp!, {r4, r5, r6, pc}
_02160E4C:
	orr r0, r1, #4
	bic r2, r0, #2
	add r0, r4, #4
	mov r1, #0
	str r2, [r4, #0x224]
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_02160E68:
	ldr r1, [r4, #0x224]
	add r0, r4, #4
	bic r1, r1, #4
	orr r2, r1, #2
	mov r1, #1
	str r2, [r4, #0x224]
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_02160E88:
	bic r0, r1, #4
	bic r0, r0, #2
	str r0, [r4, #0x224]
	bl HubHUD__Func_216016C
	cmp r0, #0
	add r0, r4, #4
	beq _02160EB0
	mov r1, #2
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_02160EB0:
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02160EBC: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_2160DCC

	arm_func_start HubHUD__Func_2160EC0
HubHUD__Func_2160EC0: // 0x02160EC0
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, _02160FBC // =HubHUD__TaskSingleton
	mov r6, r0
	ldr r0, [r2, #0]
	mov r5, r1
	bl GetTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x228]
	ldr r0, [r5, #0x14]
	tst r1, #1
	beq _02160EF4
	tst r0, #0x800
	beq _02160F08
_02160EF4:
	ldr r0, [r4, #0x228]
	bic r0, r0, #4
	bic r0, r0, #2
	str r0, [r4, #0x228]
	ldmia sp!, {r4, r5, r6, pc}
_02160F08:
	ldr r0, [r6, #0]
	cmp r0, #0x400000
	bhi _02160F24
	bhs _02160F68
	cmp r0, #0x40000
	beq _02160F40
	ldmia sp!, {r4, r5, r6, pc}
_02160F24:
	cmp r0, #0x2000000
	bhi _02160F34
	beq _02160F68
	ldmia sp!, {r4, r5, r6, pc}
_02160F34:
	cmp r0, #0x8000000
	beq _02160F94
	ldmia sp!, {r4, r5, r6, pc}
_02160F40:
	orr r0, r1, #4
	bic r2, r0, #2
	add r0, r4, #0xd4
	mov r1, #0
	str r2, [r4, #0x228]
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0x138
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_02160F68:
	ldr r1, [r4, #0x228]
	add r0, r4, #0xd4
	bic r1, r1, #4
	orr r2, r1, #2
	mov r1, #1
	str r2, [r4, #0x228]
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0x138
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
_02160F94:
	bic r0, r1, #4
	bic r2, r0, #2
	add r0, r4, #0xd4
	mov r1, #0
	str r2, [r4, #0x228]
	bl AnimatorSprite__SetAnimation
	add r0, r4, #0x138
	mov r1, #0
	bl AnimatorSprite__SetAnimation
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02160FBC: .word HubHUD__TaskSingleton
	arm_func_end HubHUD__Func_2160EC0

	arm_func_start HubHUD__Func_2160FC0
HubHUD__Func_2160FC0: // 0x02160FC0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	ldrh r1, [r0, #0]
	mov r4, r2
	cmp r1, #7
	addne sp, sp, #0x10
	ldmneia sp!, {r4, pc}
	add r1, sp, #0
	add r0, r0, #8
	mov r2, #8
	bl MIi_CpuCopy16
	ldmia r4, {r0, r1}
	add r2, r0, #0x1b4
	mov r0, #0x38
	mla r0, r1, r0, r2
	add r1, sp, #0
	bl TouchField__SetHitbox
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	arm_func_end HubHUD__Func_2160FC0