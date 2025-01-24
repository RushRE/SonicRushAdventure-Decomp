	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start ovl09_215592C
ovl09_215592C: // 0x0215592C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl exBossEffectFireTask__Create
	add r0, r4, #0x6c
	mov r1, #0xc
	bl ovl09_2154370
	add r0, r4, #0x3f8
	bl ovl09_21641F0
	bl GetExTaskCurrent
	ldr r1, _02155964 // =ovl09_2155968
	str r1, [r0]
	bl ovl09_2155968
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155964: .word ovl09_2155968
	arm_func_end ovl09_215592C

	arm_func_start ovl09_2155968
ovl09_2155968: // 0x02155968
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _02155994
	bl ovl09_21559B8
	ldmia sp!, {r4, pc}
_02155994:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2155968

	arm_func_start ovl09_21559B8
ovl09_21559B8: // 0x021559B8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0xd
	bl ovl09_2154370
	add r0, r4, #0x3f8
	bl ovl09_21641F0
	mov r2, #0xc9
	sub r1, r2, #0xca
	mov r0, #0
	stmia sp, {r0, r2}
	mov r2, r1
	mov r3, r1
	bl PlaySfxEx
	bl ovl09_21581C0
	bl GetExTaskCurrent
	ldr r1, _02155A14 // =ovl09_2155A18
	str r1, [r0]
	bl ovl09_2155A18
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155A14: .word ovl09_2155A18
	arm_func_end ovl09_21559B8

	arm_func_start ovl09_2155A18
ovl09_2155A18: // 0x02155A18
	stmdb sp!, {r3, r4, r5, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	ldr r0, [r4, #0x3b0]
	ldr r0, [r0, #0]
	cmp r0, #0xf000
	blt _02155AEC
	ldr ip, _02155B28 // =_mt_math_rand
	ldr r0, _02155B2C // =0x00196225
	ldr r2, [ip]
	ldr r1, _02155B30 // =0x3C6EF35F
	ldr r3, _02155B34 // =0x51EB851F
	mla lr, r2, r0, r1
	mov r0, lr, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r1, r2, lsr #0x1f
	smull r2, r5, r3, r2
	add r5, r1, r5, asr #5
	mov r3, #0x64
	smull r1, r2, r3, r5
	rsb r5, r1, r0, lsr #16
	cmp r5, #0x3c
	str lr, [ip]
	movge r0, #0x168
	strgeh r0, [r4, #0x58]
	bge _02155AAC
	bge _02155AA0
	cmp r5, #0x28
	movge r0, #0x258
	strgeh r0, [r4, #0x58]
	bge _02155AAC
_02155AA0:
	cmp r5, #0x28
	movlt r0, #0xb4
	strlth r0, [r4, #0x58]
_02155AAC:
	mov r5, #0
_02155AB0:
	strh r5, [r4, #0x66]
	bl exBossFireDoraTask__Create
	add r0, r5, #1
	mov r0, r0, lsl #0x10
	mov r5, r0, lsr #0x10
	cmp r5, #3
	blo _02155AB0
	bl exBossEffectShotTask__Create
	mov r0, #0
	strh r0, [r4, #0x66]
	bl GetExTaskCurrent
	ldr r1, _02155B38 // =ovl09_2155B3C
	str r1, [r0]
	bl ovl09_2155B3C
	ldmia sp!, {r3, r4, r5, pc}
_02155AEC:
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _02155B04
	bl ovl09_2155B8C
	ldmia sp!, {r3, r4, r5, pc}
_02155B04:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02155B28: .word _mt_math_rand
_02155B2C: .word 0x00196225
_02155B30: .word 0x3C6EF35F
_02155B34: .word 0x51EB851F
_02155B38: .word ovl09_2155B3C
	arm_func_end ovl09_2155A18

	arm_func_start ovl09_2155B3C
ovl09_2155B3C: // 0x02155B3C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _02155B68
	bl ovl09_2155B8C
	ldmia sp!, {r4, pc}
_02155B68:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2155B3C

	arm_func_start ovl09_2155B8C
ovl09_2155B8C: // 0x02155B8C
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	mov r1, #0xe
	bl ovl09_2154370
	add r0, r4, #0x3f8
	bl ovl09_21641F0
	bl GetExTaskCurrent
	ldr r1, _02155BC0 // =ovl09_2155BC4
	str r1, [r0]
	bl ovl09_2155BC4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155BC0: .word ovl09_2155BC4
	arm_func_end ovl09_2155B8C

	arm_func_start ovl09_2155BC4
ovl09_2155BC4: // 0x02155BC4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #0x6c
	bl ovl09_2162164
	add r0, r4, #0x6c
	bl ovl09_21623F8
	cmp r0, #0
	beq _02155BF0
	bl ovl09_2155C14
	ldmia sp!, {r4, pc}
_02155BF0:
	add r0, r4, #0x6c
	bl ovl09_216AE78
	add r0, r4, #0x6c
	add r1, r4, #0x3f8
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_2155BC4

	arm_func_start ovl09_2155C14
ovl09_2155C14: // 0x02155C14
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	ldr r0, [r0, #0x548]
	blx r0
	ldmia sp!, {r3, pc}
	arm_func_end ovl09_2155C14

	arm_func_start ovl09_2155C28
ovl09_2155C28: // 0x02155C28
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	ldr r1, _02155E5C // =0x02175FC4
	mov r4, r0
	str r4, [r1, #0x10]
	ldr r0, [r1, #0x5c]
	cmp r0, #0
	ldrne r0, [r1, #0x3c]
	cmpne r0, #0
	beq _02155CA4
	bl _GetHeapTotalSizeHEAP_USER
	ldr r1, _02155E5C // =0x02175FC4
	ldr r1, [r1, #0x5c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl VRAMSystem__GetTextureUnknown
	ldr r1, _02155E5C // =0x02175FC4
	ldr r1, [r1, #0x3c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl _GetHeapUnallocatedSizeHEAP_SYSTEM
	ldr r1, _02155E5C // =0x02175FC4
	ldr r1, [r1, #0x5c]
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
_02155CA4:
	mov r0, r4
	bl ovl09_2161CB0
	ldr r0, _02155E5C // =0x02175FC4
	ldrsh r0, [r0, #6]
	cmp r0, #0
	bne _02155D38
	mov r1, #0x21
	ldr r0, _02155E60 // =aExtraExBb_2
	sub r2, r1, #0x22
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	ldr r1, _02155E5C // =0x02175FC4
	mov r0, r0, lsr #8
	str r0, [r1, #0x5c]
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _02155E5C // =0x02175FC4
	mov r0, r5
	str r1, [r2, #0x90]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #0x57
	bl ovl09_21733D4
	ldr r1, _02155E5C // =0x02175FC4
	mov r2, #0
	str r0, [r1, #0xbc]
	mov r0, #0x58
	str r2, [r1, #0xdc]
	bl ovl09_21733D4
	ldr r1, _02155E5C // =0x02175FC4
	mov r2, #3
	str r0, [r1, #0xc0]
	str r2, [r1, #0xe0]
	ldr r0, [r1, #0x90]
	bl Asset3DSetup__Create
_02155D38:
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	ldr r0, _02155E5C // =0x02175FC4
	str r2, [sp]
	ldr r1, [r0, #0x90]
	mov r3, r2
	add r0, r4, #0x20
	bl AnimatorMDL__SetResource
	mov r8, #0
	ldr r6, _02155E64 // =0x021760A0
	ldr r5, _02155E68 // =0x02176080
	mov r7, r8
_02155D70:
	str r7, [sp]
	ldr r1, [r6, r8, lsl #2]
	ldr r2, [r5, r8, lsl #2]
	mov r3, r7
	add r0, r4, #0x20
	bl AnimatorMDL__SetAnimation
	add r0, r8, #1
	mov r0, r0, lsl #0x10
	mov r8, r0, lsr #0x10
	cmp r8, #2
	blo _02155D70
	ldr r1, _02155E5C // =0x02175FC4
	add r0, r4, #0x300
	ldr r2, [r1, #0xdc]
	mov r3, #0
	strh r2, [r0, #0x48]
	ldr r0, [r1, #0xdc]
	mov r2, #1
	add r0, r4, r0, lsl #2
	ldr r0, [r0, #0x104]
	str r0, [r4, #0x344]
_02155DC4:
	mov r0, r2, lsl r3
	tst r0, #9
	beq _02155DE4
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02155DE4:
	add r3, r3, #1
	cmp r3, #5
	blo _02155DC4
	mov r3, #0
	str r3, [r4, #0x358]
	mov r0, #0x1000
	str r0, [r4, #0x368]
	str r0, [r4, #0x36c]
	ldr r2, _02155E6C // =0x0000BFF4
	str r0, [r4, #0x370]
	add r0, r4, #0x300
	ldr r1, _02155E70 // =0x00007FF8
	strh r2, [r0, #0x4a]
	strh r1, [r0, #0x4e]
	strb r3, [r4]
	ldrb r2, [r4, #4]
	add r0, r4, #0x350
	ldr r1, _02155E5C // =0x02175FC4
	orr r2, r2, #0x40
	strb r2, [r4, #4]
	str r3, [r4, #0xc]
	str r3, [r4, #0x10]
	str r3, [r4, #0x14]
	str r0, [r4, #0x18]
	ldrsh r2, [r1, #6]
	mov r0, #1
	add r2, r2, #1
	strh r2, [r1, #6]
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_02155E5C: .word 0x02175FC4
_02155E60: .word aExtraExBb_2
_02155E64: .word 0x021760A0
_02155E68: .word 0x02176080
_02155E6C: .word 0x0000BFF4
_02155E70: .word 0x00007FF8
	arm_func_end ovl09_2155C28

	arm_func_start ovl09_2155E74
ovl09_2155E74: // 0x02155E74
	stmdb sp!, {r4, lr}
	ldr r1, _02155F00 // =0x02175FC4
	mov r4, r0
	ldrsh r0, [r1, #6]
	cmp r0, #1
	bgt _02155EE4
	ldr r0, [r1, #0x90]
	cmp r0, #0
	beq _02155E9C
	bl NNS_G3dResDefaultRelease
_02155E9C:
	ldr r0, _02155F00 // =0x02175FC4
	ldr r0, [r0, #0xbc]
	cmp r0, #0
	beq _02155EB0
	bl NNS_G3dResDefaultRelease
_02155EB0:
	ldr r0, _02155F00 // =0x02175FC4
	ldr r0, [r0, #0xc0]
	cmp r0, #0
	beq _02155EC4
	bl NNS_G3dResDefaultRelease
_02155EC4:
	ldr r0, _02155F00 // =0x02175FC4
	ldr r0, [r0, #0x90]
	cmp r0, #0
	beq _02155ED8
	bl _FreeHEAP_USER
_02155ED8:
	ldr r0, _02155F00 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x90]
_02155EE4:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldr r0, _02155F00 // =0x02175FC4
	ldrsh r1, [r0, #6]
	sub r1, r1, #1
	strh r1, [r0, #6]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155F00: .word 0x02175FC4
	arm_func_end ovl09_2155E74

	arm_func_start exBossEffectHitTask__Main
exBossEffectHitTask__Main: // 0x02155F04
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _02155F78 // =0x02175FC4
	str r0, [r1, #0x9c]
	add r0, r4, #4
	bl ovl09_2155C28
	add r0, r4, #0x390
	mov r1, #0xa800
	bl exDrawReqTask__SetConfigPriority
	add r0, r4, #0x390
	bl ovl09_21641F0
	ldr r1, [r4, #0x4e0]
	ldr r0, _02155F78 // =0x02175FC4
	ldr r2, [r1, #0x3c8]
	mov r1, #1
	str r2, [r4, #0x354]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3cc]
	str r2, [r4, #0x358]
	ldr r2, [r4, #0x4e0]
	ldr r2, [r2, #0x3d0]
	str r2, [r4, #0x35c]
	str r1, [r0, #0x18]
	bl GetExTaskCurrent
	ldr r1, _02155F7C // =ovl09_2155FE4
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02155F78: .word 0x02175FC4
_02155F7C: .word ovl09_2155FE4
	arm_func_end exBossEffectHitTask__Main

	arm_func_start exBossEffectHitTask__Func8
exBossEffectHitTask__Func8: // 0x02155F80
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	bl ovl09_2172AE0
	cmp r0, #0
	beq _02155FA0
	bl GetExTaskCurrent
	ldr r1, _02155FBC // =ExTask_State_Destroy
	str r1, [r0]
_02155FA0:
	bl ovl09_2154C28
	cmp r0, #1
	ldmneia sp!, {r3, pc}
	bl GetExTaskCurrent
	ldr r1, _02155FBC // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155FBC: .word ExTask_State_Destroy
	arm_func_end exBossEffectHitTask__Func8

	arm_func_start exBossEffectHitTask__Destructor
exBossEffectHitTask__Destructor: // 0x02155FC0
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #4
	bl ovl09_2155E74
	ldr r0, _02155FE0 // =0x02175FC4
	mov r1, #0
	str r1, [r0, #0x9c]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02155FE0: .word 0x02175FC4
	arm_func_end exBossEffectHitTask__Destructor

	arm_func_start ovl09_2155FE4
ovl09_2155FE4: // 0x02155FE4
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	add r0, r4, #4
	bl ovl09_2162164
	bl ovl09_215F014
	cmp r0, #0
	bne _02156014
	bl GetExTaskCurrent
	ldr r1, _02156050 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156014:
	add r0, r4, #4
	bl ovl09_21623F8
	cmp r0, #0
	beq _02156034
	bl GetExTaskCurrent
	ldr r1, _02156050 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r4, pc}
_02156034:
	add r0, r4, #4
	add r1, r4, #0x390
	bl ovl09_2164034
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156050: .word ExTask_State_Destroy
	arm_func_end ovl09_2155FE4

	arm_func_start exBossEffectHitTask__Create
exBossEffectHitTask__Create: // 0x02156054
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _021560CC // =0x000004E4
	str r4, [sp]
	ldr r0, _021560D0 // =aExbosseffecthi
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021560D4 // =exBossEffectHitTask__Main
	ldr r1, _021560D8 // =exBossEffectHitTask__Destructor
	mov r2, #0x3100
	mov r3, #5
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r5, r0
	bl GetExTaskWork_
	ldr r2, _021560CC // =0x000004E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	bl ovl09_215F014
	bl GetExTaskWork_
	str r0, [r4, #0x4e0]
	mov r0, r5
	bl GetExTask
	ldr r1, _021560DC // =exBossEffectHitTask__Func8
	str r1, [r0, #8]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021560CC: .word 0x000004E4
_021560D0: .word aExbosseffecthi
_021560D4: .word exBossEffectHitTask__Main
_021560D8: .word exBossEffectHitTask__Destructor
_021560DC: .word exBossEffectHitTask__Func8
	arm_func_end exBossEffectHitTask__Create

	.data
	
aExtraExBb_2: // 0x02173FC4
	.asciz "/extra/ex.bb"
	.align 4
	
aExbosseffecthi: // 0x02173FD4
	.asciz "exBossEffectHitTask"