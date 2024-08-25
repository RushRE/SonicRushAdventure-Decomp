	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start TruckSpike3D__Create
TruckSpike3D__Create: // 0x0217056C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	mov r3, #0x1800
	mov r7, r0
	mov r6, r1
	mov r5, r2
	str r3, [sp]
	mov r0, #2
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _021706F8 // =0x00000484
	ldr r0, _021706FC // =StageTask_Main
	ldr r1, _02170700 // =GameObject__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, _021706F8 // =0x00000484
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xc0
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	orr r1, r1, #0x100
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x18]
	orr r1, r1, #0x10
	str r1, [r4, #0x18]
	bl GetObjectFileWork
	mov r1, #0x10
	str r1, [sp]
	str r0, [sp, #4]
	ldr r1, _02170704 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1]
	add r1, r4, #0x370
	str r2, [sp, #8]
	ldr r2, _02170708 // =aActAcGmkTruckS
	mov r3, #0x800
	bl ObjObjectAction3dBACLoad
	mov r0, #0x1d
	strb r0, [r4, #0x37a]
	mov r0, #7
	strb r0, [r4, #0x37b]
	ldr r1, [r4, #0x464]
	add r0, r4, #0x370
	orr r1, r1, #0x8000
	str r1, [r4, #0x464]
	mov r1, #0
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	ldr r1, [r4, #0x43c]
	mov r0, #0x1800
	orr r1, r1, #0x10
	str r1, [r4, #0x43c]
	str r0, [r4, #0x38]
	str r0, [r4, #0x3c]
	str r0, [r4, #0x40]
	str r4, [r4, #0x274]
	mov r0, #0x10
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r3, #8
	str r3, [sp, #8]
	add r0, r4, #0x258
	sub r1, r3, #0x18
	sub r2, r3, #0x28
	sub r3, r3, #0x10
	bl ObjRect__SetBox3D
	add r0, r4, #0x258
	ldr r1, _0217070C // =0x0000FFFF
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	ldr r0, [r4, #0x270]
	ldr r1, _02170710 // =TruckSpike3D__State_2170714
	orr r0, r0, #4
	orr r0, r0, #0x400
	str r0, [r4, #0x270]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_021706F8: .word 0x00000484
_021706FC: .word StageTask_Main
_02170700: .word GameObject__Destructor
_02170704: .word gameArchiveStage
_02170708: .word aActAcGmkTruckS
_0217070C: .word 0x0000FFFF
_02170710: .word TruckSpike3D__State_2170714
	arm_func_end TruckSpike3D__Create

	arm_func_start TruckSpike3D__State_2170714
TruckSpike3D__State_2170714: // 0x02170714
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr r2, _02170788 // =g_obj
	ldr r3, [r0, #0xd8]
	ldr r2, [r2, #0x10]
	ldr lr, [r0, #0x9c]
	smull ip, r2, r3, r2
	adds r3, ip, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r3, lr, r3
	str r3, [r0, #0x9c]
	ldr r2, [r0, #0xdc]
	cmp r3, r2
	strgt r2, [r0, #0x9c]
	ldr r3, [r0, #0x368]
	ldr r2, [r0, #0x9c]
	add r2, r3, r2
	str r2, [r0, #0x368]
	ldr r1, [r1, #0xe80]
	add r1, r1, #0x15000
	cmp r1, r2
	movle r1, #0x3d00
	rsble r1, r1, #0
	strle r1, [r0, #0x9c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02170788: .word g_obj
	arm_func_end TruckSpike3D__State_2170714

	.data
	
aActAcGmkTruckS: // 0x021896DC
	.asciz "/act/ac_gmk_truck_spike3d.bac"
	.align 4