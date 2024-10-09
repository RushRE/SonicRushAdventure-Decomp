	.include "asm/macros.inc"
	.include "global.inc"

	.public _ZTVN10__cxxabiv117__class_type_infoE
	.public _ZTVN10__cxxabiv120__si_class_type_infoE

	.bss
	
ViNpcGroup__Value_2173A5C: // 0x02173A5C
	.space 0x04

	.text

	arm_func_start ViDockNpcGroup__Constructor
ViDockNpcGroup__Constructor: // 0x02168398
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, _021683C8 // =_ZTV15CViDockNpcGroup+0x08
	add r0, r4, #0x10
	str r1, [r4]
	bl Vi3dArrow__Constructor
	mov r1, #0
	str r1, [r4, #4]
	str r1, [r4, #8]
	mov r0, r4
	str r1, [r4, #0xc]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021683C8: .word _ZTV15CViDockNpcGroup+0x08
	arm_func_end ViDockNpcGroup__Constructor

	arm_func_start ViDockNpcGroup__VTableFunc_21683CC
ViDockNpcGroup__VTableFunc_21683CC: // 0x021683CC
	stmdb sp!, {r4, lr}
	ldr r1, _021683F0 // =_ZTV15CViDockNpcGroup+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockNpcGroup__Func_2168424
	add r0, r4, #0x10
	bl Vi3dArrow__VTableFunc_2168268
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_021683F0: .word _ZTV15CViDockNpcGroup+0x08
	arm_func_end ViDockNpcGroup__VTableFunc_21683CC

	arm_func_start ViDockNpcGroup__VTableFunc_21683F4
ViDockNpcGroup__VTableFunc_21683F4: // 0x021683F4
	stmdb sp!, {r4, lr}
	ldr r1, _02168420 // =_ZTV15CViDockNpcGroup+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockNpcGroup__Func_2168424
	add r0, r4, #0x10
	bl Vi3dArrow__VTableFunc_2168268
	mov r0, r4
	bl CPPHelpers__Free
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168420: .word _ZTV15CViDockNpcGroup+0x08
	arm_func_end ViDockNpcGroup__VTableFunc_21683F4

	arm_func_start ViDockNpcGroup__Func_2168424
ViDockNpcGroup__Func_2168424: // 0x02168424
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0x10
	bl Vi3dArrow__Func_2168358
	ldr r1, [r5, #8]
	cmp r1, #0
	moveq r1, #0
	cmp r1, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	mov r4, #0
_0216844C:
	mov r0, r5
	bl ViDockNpcGroup__Func_21684D0
	ldr r1, [r5, #8]
	cmp r1, #0
	moveq r1, r4
	cmp r1, #0
	bne _0216844C
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViDockNpcGroup__Func_2168424

	arm_func_start ViDockNpcGroup__Func_216846C
ViDockNpcGroup__Func_216846C: // 0x0216846C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r0, #0x340
	bl CPPHelpers__HeapAllocHead_System
	movs r4, r0
	beq _02168488
	bl ViDockNpc__Constructor
_02168488:
	ldr r0, [r5, #8]
	cmp r0, #0
	mov r0, #0
	streq r0, [r4, #0x338]
	streq r0, [r4, #0x33c]
	streq r4, [r5, #8]
	beq _021684B8
	str r0, [r4, #0x338]
	ldr r0, [r5, #0xc]
	str r0, [r4, #0x33c]
	ldr r0, [r5, #0xc]
	str r4, [r0, #0x338]
_021684B8:
	str r4, [r5, #0xc]
	ldr r1, [r5, #4]
	mov r0, r4
	add r1, r1, #1
	str r1, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViDockNpcGroup__Func_216846C

	arm_func_start ViDockNpcGroup__Func_21684D0
ViDockNpcGroup__Func_21684D0: // 0x021684D0
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	ldr r1, [r4, #0x33c]
	mov r5, r0
	ldr r0, [r4, #0x338]
	cmp r1, #0
	strne r0, [r1, #0x338]
	streq r0, [r5, #8]
	ldr r1, [r4, #0x338]
	ldr r0, [r4, #0x33c]
	cmp r1, #0
	strne r0, [r1, #0x33c]
	streq r0, [r5, #0xc]
	cmp r4, #0
	beq _0216851C
	mov r0, r4
	bl ViDockNpc__VTableFunc_2166BD8
	mov r0, r4
	bl CPPHelpers__Free
_0216851C:
	ldr r0, [r5, #4]
	sub r0, r0, #1
	str r0, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViDockNpcGroup__Func_21684D0

	arm_func_start ViDockNpcGroup__Func_216852C
ViDockNpcGroup__Func_216852C: // 0x0216852C
	ldr r0, [r1, #0x338]
	cmp r0, #0
	moveq r0, #0
	bx lr
	arm_func_end ViDockNpcGroup__Func_216852C

	arm_func_start ViDockNpcGroup__Func_216853C
ViDockNpcGroup__Func_216853C: // 0x0216853C
	ldr ip, _02168548 // =Vi3dArrow__LoadAssets
	add r0, r0, #0x10
	bx ip
	.align 2, 0
_02168548: .word Vi3dArrow__LoadAssets
	arm_func_end ViDockNpcGroup__Func_216853C

	arm_func_start ViDockNpcGroup__Func_216854C
ViDockNpcGroup__Func_216854C: // 0x0216854C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r4, [r5, #8]
	cmp r4, #0
	moveq r4, #0
	cmp r4, #0
	beq _02168584
_02168568:
	mov r0, r4
	bl Vi3dObject__Func_2167ADC
	mov r0, r5
	mov r1, r4
	bl ViDockNpcGroup__Func_216852C
	movs r4, r0
	bne _02168568
_02168584:
	add r0, r5, #0x10
	bl Vi3dObject__Func_2167ADC
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ViDockNpcGroup__Func_216854C

	arm_func_start ViDockNpcGroup__Func_2168590
ViDockNpcGroup__Func_2168590: // 0x02168590
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #8]
	mov r5, r1
	cmp r4, #0
	moveq r4, #0
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, pc}
_021685B0:
	ldr r0, [r4, #0x300]
	cmp r0, #7
	cmpne r0, #8
	bne _021685F0
	mov r0, r4
	mov r1, r5
	bl ViDockNpc__Func_216737C
	cmp r0, #0
	beq _021685F0
	add r0, r4, #8
	bl CPPHelpers__Func_2085F9C
	mov r1, r0
	add r0, r6, #0x18
	bl CPPHelpers__VEC_Copy_Alt
	add r0, r6, #0x10
	bl Vi3dObject__Func_2167B98
_021685F0:
	mov r0, r6
	mov r1, r4
	bl ViDockNpcGroup__Func_216852C
	movs r4, r0
	bne _021685B0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ViDockNpcGroup__Func_2168590

	arm_func_start ViDockNpcGroup__Func_2168608
ViDockNpcGroup__Func_2168608: // 0x02168608
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r9, r0
	ldr r4, [r9, #8]
	mov r8, r1
	cmp r4, #0
	moveq r4, #0
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x20]
	cmp r4, #0
	beq _0216866C
_02168634:
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	str r5, [sp]
	bl ViDockNpc__Func_216710C
	cmp r0, #0
	movne r0, r4
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, r9
	mov r1, r4
	bl ViDockNpcGroup__Func_216852C
	movs r4, r0
	bne _02168634
_0216866C:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end ViDockNpcGroup__Func_2168608

	arm_func_start ViDockNpcGroup__Func_2168674
ViDockNpcGroup__Func_2168674: // 0x02168674
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	mov r8, r1
	ldr r1, [sp, #0x24]
	mov r9, r0
	mov r7, r2
	mov r6, r3
	cmp r1, #0
	ldr r5, [sp, #0x20]
	beq _021686A4
	bl ViDockNpcGroup__Func_216852C
	mov r4, r0
	b _021686B0
_021686A4:
	ldr r4, [r9, #8]
	cmp r4, #0
	moveq r4, #0
_021686B0:
	cmp r4, #0
	beq _021686F0
_021686B8:
	mov r0, r4
	mov r1, r8
	mov r2, r7
	mov r3, r6
	str r5, [sp]
	bl ViDockNpc__Func_2167244
	cmp r0, #0
	movne r0, r4
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	mov r0, r9
	mov r1, r4
	bl ViDockNpcGroup__Func_216852C
	movs r4, r0
	bne _021686B8
_021686F0:
	mov r0, #0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	arm_func_end ViDockNpcGroup__Func_2168674

	arm_func_start ViDockNpcGroup__Func_21686F8
ViDockNpcGroup__Func_21686F8: // 0x021686F8
	stmdb sp!, {r3, lr}
	ldr r2, _0216871C // =_02173968
	mov ip, #0x20
	ldr r3, [r2, r0, lsl #2]
	ldr r2, _02168720 // =ViDockNpcGroup__talkAction
	mov r0, r1
	str ip, [r2]
	blx r3
	ldmia sp!, {r3, pc}
	.align 2, 0
_0216871C: .word _02173968
_02168720: .word ViDockNpcGroup__talkAction
	arm_func_end ViDockNpcGroup__Func_21686F8

	arm_func_start ViDockNpcGroup__Func_2168724
ViDockNpcGroup__Func_2168724: // 0x02168724
	ldr r0, _02168730 // =ViDockNpcGroup__talkAction
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_02168730: .word ViDockNpcGroup__talkAction
	arm_func_end ViDockNpcGroup__Func_2168724

	arm_func_start ViDockNpcGroup__Func_2168734
ViDockNpcGroup__Func_2168734: // 0x02168734
	ldr r0, _02168740 // =ViNpcGroup__Value_2173A5C
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_02168740: .word ViNpcGroup__Value_2173A5C
	arm_func_end ViDockNpcGroup__Func_2168734

	arm_func_start ViDockNpcGroup__Func_2168744
ViDockNpcGroup__Func_2168744: // 0x02168744
	ldr r1, _02168750 // =ViDockNpcGroup__talkAction
	str r0, [r1]
	bx lr
	.align 2, 0
_02168750: .word ViDockNpcGroup__talkAction
	arm_func_end ViDockNpcGroup__Func_2168744

	arm_func_start ViDockNpcGroup__Func_2168754
ViDockNpcGroup__Func_2168754: // 0x02168754
	ldr r1, _02168760 // =ViNpcGroup__Value_2173A5C
	str r0, [r1]
	bx lr
	.align 2, 0
_02168760: .word ViNpcGroup__Value_2173A5C
	arm_func_end ViDockNpcGroup__Func_2168754

	arm_func_start ViDockNpcGroup__Func_2168764
ViDockNpcGroup__Func_2168764: // 0x02168764
	stmdb sp!, {r4, lr}
	ldr r0, _02168794 // =gameState
	ldr r0, [r0, #0x7c]
	cmp r0, #0
	moveq r4, #7
	beq _02168788
	mov r4, #6
	bl ovl05_2154014
	bl ovl05_2153E4C
_02168788:
	mov r0, r4
	bl Task__OV05Unknown216897C__Create
	ldmia sp!, {r4, pc}
	.align 2, 0
_02168794: .word gameState
	arm_func_end ViDockNpcGroup__Func_2168764

	arm_func_start ViDockNpcGroup__Func_2168798
ViDockNpcGroup__Func_2168798: // 0x02168798
	bx lr
	arm_func_end ViDockNpcGroup__Func_2168798

	arm_func_start ViDockNpcGroup__Func_216879C
ViDockNpcGroup__Func_216879C: // 0x0216879C
	ldr r1, _021687A8 // =ViDockNpcGroup__talkAction
	str r0, [r1]
	bx lr
	.align 2, 0
_021687A8: .word ViDockNpcGroup__talkAction
	arm_func_end ViDockNpcGroup__Func_216879C

	.data

.public _ZTI15CViDockNpcGroup
_ZTI15CViDockNpcGroup: // 0x02173938
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS15CViDockNpcGroup
	
.public _ZTV15CViDockNpcGroup
_ZTV15CViDockNpcGroup: // 0x02173940
    .word 0, _ZTI15CViDockNpcGroup
    .word ViDockNpcGroup__VTableFunc_21683CC, ViDockNpcGroup__VTableFunc_21683F4

.public _ZTS15CViDockNpcGroup
_ZTS15CViDockNpcGroup: // 0x02173950
	.asciz "15CViDockNpcGroup"
	.align 4

.public ViDockNpcGroup__talkAction
ViDockNpcGroup__talkAction:
	.word 0x20
	
.public _02173968
_02173968:
	.word Task__OV05Unknown216897C__Create
	.word Task__OV05Unknown2168C48__Create
	.word ViTalkPurchase__Create
	.word ViTalkList__Create
	.word ViDockNpcGroup__Func_2168764
	.word ViTalkList__Func_216B6B4
	.word ViDockNpcGroup__Func_2168798
	.word NpcOptions__Create
	.word NpcViking__Create
	.word NpcMission__Create
	.word ViDockNpcGroup__Func_216879C