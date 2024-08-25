	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start TruckBomb3D__Create
TruckBomb3D__Create: // 0x02170290
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
	ldr r4, _0217042C // =0x00000484
	ldr r0, _02170430 // =StageTask_Main
	ldr r1, _02170434 // =GameObject__Destructor
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
	ldr r2, _0217042C // =0x00000484
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldr r1, [r4, #0x1c]
	mov r0, #0xbf
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
	ldr r1, _02170438 // =gameArchiveStage
	mov r0, r4
	ldr r2, [r1]
	add r1, r4, #0x370
	str r2, [sp, #8]
	ldr r2, _0217043C // =aActAcGmkTruckB_1
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
	ldr r1, _02170440 // =0x0000FFFF
	mov r2, #0xff
	bl ObjRect__SetDefenceStat
	ldr r1, [r4, #0x270]
	ldr r0, _02170444 // =TruckBomb3D__OnHit_217050C
	orr r1, r1, #4
	orr r1, r1, #0x400
	str r1, [r4, #0x270]
	str r0, [r4, #0x278]
	ldrsb r0, [r7, #6]
	cmp r0, #0
	ldrne r0, _02170448 // =TruckBomb3D__State_217044C
	strne r0, [r4, #0xf4]
	mov r0, r4
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0217042C: .word 0x00000484
_02170430: .word StageTask_Main
_02170434: .word GameObject__Destructor
_02170438: .word gameArchiveStage
_0217043C: .word aActAcGmkTruckB_1
_02170440: .word 0x0000FFFF
_02170444: .word TruckBomb3D__OnHit_217050C
_02170448: .word TruckBomb3D__State_217044C
	arm_func_end TruckBomb3D__Create

	arm_func_start TruckBomb3D__State_217044C
TruckBomb3D__State_217044C: // 0x0217044C
	stmdb sp!, {r3, lr}
	ldr r1, [r0, #0x11c]
	cmp r1, #0
	ldmeqia sp!, {r3, pc}
	ldr lr, [r0, #0x354]
	tst lr, #1
	beq _021704D0
	ldr r2, _02170508 // =g_obj
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
	ldmgtia sp!, {r3, pc}
	str r1, [r0, #0x368]
	mov r1, #0
	str r1, [r0, #0xf4]
	ldmia sp!, {r3, pc}
_021704D0:
	ldr r3, [r1, #0x4c]
	ldr r2, [r0, #0x4c]
	ldr ip, [r1, #0x44]
	sub r1, r3, r2
	mov r2, r1, asr #0xc
	mul r1, r2, r2
	ldr r2, [r0, #0x44]
	sub r2, ip, r2
	mov r2, r2, asr #0xc
	mla r1, r2, r2, r1
	cmp r1, #0xe100
	orrle r1, lr, #1
	strle r1, [r0, #0x354]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02170508: .word g_obj
	arm_func_end TruckBomb3D__State_217044C

	arm_func_start TruckBomb3D__OnHit_217050C
TruckBomb3D__OnHit_217050C: // 0x0217050C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	ldr r4, [r0, #0x1c]
	ldr r5, [r1, #0x1c]
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r3, r4, r5, pc}
	mov ip, #0x28
	sub r1, ip, #0x29
	mov r0, #0
	mov r2, r1
	mov r3, r1
	stmia sp, {r0, ip}
	bl PlaySfxEx
	mov r1, #0
	mov r0, r5
	sub r2, r1, #0x10000
	mov r3, #2
	bl CreateEffectExplosion
	ldr r0, [r4, #0x18]
	orr r0, r0, #0xa
	str r0, [r4, #0x18]
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TruckBomb3D__OnHit_217050C

	.data
	
aActAcGmkTruckB_1: // 0x021896BC
	.asciz "/act/ac_gmk_truck_bomb3d.bac"
	.align 4