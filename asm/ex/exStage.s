	.include "asm/macros.inc"
	.include "global.inc"

	.bss

exStageTask__dword_217862C: // 0x0217862C
    .space 0x04
	
exStageTask__Singleton: // 0x02178630
    .space 0x04
	
exStageTask__TaskSingleton: // 0x02178634
    .space 0x04
	
exStageTask__FileTable: // 0x02178638
    .space 0x04 * 3
	
	.text

	arm_func_start ovl09_217261C
ovl09_217261C: // 0x0217261C
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl ovl09_2161CB0
	ldr r0, _021727C8 // =aExtraExBb_11
	mov r1, #7
	mov r2, #0
	bl ReadFileFromBundle
	mov r5, r0
	ldr r0, [r5, #0]
	mov r0, r0, lsr #8
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _021727CC // =exStageTask__dword_217862C
	mov r0, r5
	str r1, [r2]
	bl RenderCore_CPUCopyCompressed
	mov r0, r5
	bl _FreeHEAP_USER
	mov r0, #6
	bl ovl09_21733D4
	ldr r1, _021727CC // =exStageTask__dword_217862C
	str r0, [r1, #0xc]
	mov r0, #8
	bl ovl09_21733D4
	ldr r1, _021727CC // =exStageTask__dword_217862C
	str r0, [r1, #0x10]
	mov r0, #7
	bl ovl09_21733D4
	ldr r1, _021727CC // =exStageTask__dword_217862C
	str r0, [r1, #0x14]
	ldr r0, [r1, #0]
	bl NNS_G3dResDefaultSetup
	ldr r0, _021727CC // =exStageTask__dword_217862C
	ldr r5, [r0, #0]
	mov r0, r5
	bl Asset3DSetup__GetTexSize
	bl _AllocHeadHEAP_USER
	mov r1, r0
	ldr r2, _021727CC // =exStageTask__dword_217862C
	mov r0, r5
	str r1, [r2]
	bl Asset3DSetup__GetTexture
	mov r0, r5
	bl _FreeHEAP_USER
	add r0, r4, #0x20
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #1
	str r3, [sp]
	add r0, r4, #0x20
	ldr r1, _021727CC // =exStageTask__dword_217862C
	mov r2, #0
	ldr r1, [r1, #0]
	bl AnimatorMDL__SetResource
	mov r1, #0
	str r1, [sp]
	add r0, r4, #0x20
	ldr r2, _021727CC // =exStageTask__dword_217862C
	mov r3, r1
	ldr r2, [r2, #0xc]
	bl AnimatorMDL__SetAnimation
	mov r3, #0
	str r3, [sp]
	add r0, r4, #0x20
	mov r1, #3
	ldr r2, _021727CC // =exStageTask__dword_217862C
	ldr r2, [r2, #0x10]
	bl AnimatorMDL__SetAnimation
	mov r3, #0
	ldr r0, _021727CC // =exStageTask__dword_217862C
	str r3, [sp]
	ldr r2, [r0, #0x14]
	add r0, r4, #0x20
	mov r1, #1
	bl AnimatorMDL__SetAnimation
	add r0, r4, #0x300
	mov r3, #0
	strh r3, [r0, #0x48]
	ldr r0, [r4, #0x104]
	mov r2, #1
	str r0, [r4, #0x344]
_02172760:
	mov r0, r2, lsl r3
	tst r0, #0xb
	beq _02172780
	add r0, r4, r3, lsl #1
	add r0, r0, #0x100
	ldrh r1, [r0, #0x2c]
	orr r1, r1, #2
	strh r1, [r0, #0x2c]
_02172780:
	add r3, r3, #1
	cmp r3, #5
	blo _02172760
	mov r0, #0
	strb r0, [r4]
	ldrb r2, [r4, #4]
	mov r1, #0x1000
	add r0, r4, #0x350
	orr r2, r2, #0x80
	strb r2, [r4, #4]
	str r1, [r4, #0x368]
	str r1, [r4, #0x36c]
	str r1, [r4, #0x370]
	ldr r1, _021727D0 // =0x00003FFC
	str r0, [r4, #0x18]
	add r0, r4, #0x300
	strh r1, [r0, #0x4a]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_021727C8: .word aExtraExBb_11
_021727CC: .word exStageTask__dword_217862C
_021727D0: .word 0x00003FFC
	arm_func_end ovl09_217261C

	arm_func_start ovl09_21727D4
ovl09_21727D4: // 0x021727D4
	stmdb sp!, {r4, lr}
	ldr r1, _02172854 // =exStageTask__dword_217862C
	mov r4, r0
	ldr r0, [r1, #0]
	cmp r0, #0
	beq _021727F0
	bl NNS_G3dResDefaultRelease
_021727F0:
	ldr r0, _02172854 // =exStageTask__dword_217862C
	ldr r0, [r0, #0xc]
	cmp r0, #0
	beq _02172804
	bl NNS_G3dResDefaultRelease
_02172804:
	ldr r0, _02172854 // =exStageTask__dword_217862C
	ldr r0, [r0, #0x10]
	cmp r0, #0
	beq _02172818
	bl NNS_G3dResDefaultRelease
_02172818:
	ldr r0, _02172854 // =exStageTask__dword_217862C
	ldr r0, [r0, #0x14]
	cmp r0, #0
	beq _0217282C
	bl NNS_G3dResDefaultRelease
_0217282C:
	ldr r1, _02172854 // =exStageTask__dword_217862C
	ldr r0, [r1, #0]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r1]
	beq _02172848
	bl _FreeHEAP_USER
_02172848:
	add r0, r4, #0x20
	bl AnimatorMDL__Release
	ldmia sp!, {r4, pc}
	.align 2, 0
_02172854: .word exStageTask__dword_217862C
	arm_func_end ovl09_21727D4

	arm_func_start exStageTask__Main
exStageTask__Main: // 0x02172858
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	bl GetCurrentTask
	ldr r1, _021728C4 // =exStageTask__dword_217862C
	str r0, [r1, #8]
	add r0, r4, #0xc
	bl ovl09_217261C
	add r0, r4, #0x398
	mov r1, #0xa000
	bl ovl09_21641E8
	add r0, r4, #0x398
	bl ovl09_2164218
	mov r0, #0x28000
	rsb r0, r0, #0
	str r0, [r4, #0x360]
	mov r1, #0
	str r1, [r4]
	mov r0, #0x1000
	str r0, [r4, #4]
	ldr r0, _021728C4 // =exStageTask__dword_217862C
	str r1, [r4, #8]
	str r4, [r0, #4]
	bl GetExTaskCurrent
	ldr r1, _021728C8 // =ovl09_21728FC
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_021728C4: .word exStageTask__dword_217862C
_021728C8: .word ovl09_21728FC
	arm_func_end exStageTask__Main

	arm_func_start exStageTask__Func8
exStageTask__Func8: // 0x021728CC
	ldr ip, _021728D4 // =GetExTaskWorkCurrent_
	bx ip
	.align 2, 0
_021728D4: .word GetExTaskWorkCurrent_
	arm_func_end exStageTask__Func8

	arm_func_start exStageTask__Destructor
exStageTask__Destructor: // 0x021728D8
	stmdb sp!, {r3, lr}
	bl GetExTaskWorkCurrent_
	add r0, r0, #0xc
	bl ovl09_21727D4
	ldr r0, _021728F8 // =exStageTask__dword_217862C
	mov r1, #0
	str r1, [r0, #8]
	ldmia sp!, {r3, pc}
	.align 2, 0
_021728F8: .word exStageTask__dword_217862C
	arm_func_end exStageTask__Destructor

	arm_func_start ovl09_21728FC
ovl09_21728FC: // 0x021728FC
	stmdb sp!, {r4, lr}
	bl GetExTaskWorkCurrent_
	mov r4, r0
	mov r0, #0x21c000
	ldr r2, [r4, #0x360]
	ldr r1, [r4, #4]
	rsb r0, r0, #0
	sub r1, r2, r1
	cmp r1, r0
	str r1, [r4, #0x360]
	addle r0, r0, #0x1f4000
	strle r0, [r4, #0x360]
	add r0, r4, #0xc
	bl ovl09_2162164
	add r0, r4, #0xc
	add r1, r4, #0x398
	bl ovl09_2164034
	bl Camera3D__UseEngineA
	ldr r1, [r4, #0x360]
	add r0, r4, #0xc
	add r1, r1, #0x33800
	add r1, r1, #0x1c0000
	str r1, [r4, #0x360]
	add r1, r4, #0x398
	bl ovl09_2164034
	ldr r0, [r4, #0x360]
	sub r0, r0, #0x33800
	sub r0, r0, #0x1c0000
	str r0, [r4, #0x360]
	bl GetExTaskCurrent
	ldr r0, [r0, #8]
	blx r0
	ldmia sp!, {r4, pc}
	arm_func_end ovl09_21728FC

	arm_func_start exStageTask__CreateEx
exStageTask__CreateEx: // 0x02172980
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, #0
	ldr r1, _021729D8 // =0x000004E8
	str r4, [sp]
	ldr r0, _021729DC // =aExstagetask
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r0, _021729E0 // =exStageTask__Main
	ldr r1, _021729E4 // =exStageTask__Destructor
	mov r2, #0x1800
	mov r3, #1
	str r4, [sp, #0xc]
	bl ExTaskCreate_
	mov r4, r0
	bl GetExTaskWork_
	mov r0, r4
	bl GetExTask
	ldr r1, _021729E8 // =exStageTask__Func8
	str r1, [r0, #8]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_021729D8: .word 0x000004E8
_021729DC: .word aExstagetask
_021729E0: .word exStageTask__Main
_021729E4: .word exStageTask__Destructor
_021729E8: .word exStageTask__Func8
	arm_func_end exStageTask__CreateEx

	arm_func_start ovl09_21729EC
ovl09_21729EC: // 0x021729EC
	stmdb sp!, {r3, lr}
	ldr r0, _02172A10 // =exStageTask__dword_217862C
	ldr r0, [r0, #8]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl GetExTask
	ldr r1, _02172A14 // =ExTask_State_Destroy
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02172A10: .word exStageTask__dword_217862C
_02172A14: .word ExTask_State_Destroy
	arm_func_end ovl09_21729EC

	.data

aExtraExBb_11: // 0x02175E8C
	.asciz "/extra/ex.bb"
	.align 4
	
aExstagetask: // 0x02175E9C
	.asciz "exStageTask"