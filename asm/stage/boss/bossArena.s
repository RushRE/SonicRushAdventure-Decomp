	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__VRAM_BG
.public VRAMSystem__VRAM_PALETTE_BG

	.bss

_0213414C: // 0x0213414C
    .space 0x04

	.text

	arm_func_start BossArena__Create
BossArena__Create: // 0x020396BC
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0xc
	mov r5, r0
	str r1, [sp]
	mov r0, #3
	mov r2, #0
	str r0, [sp, #4]
	ldr r4, _0203979C // =0x000004FC
	ldr r0, _020397A0 // =BossArena__Main
	ldr r1, _020397A4 // =BossArena__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	ldr r1, _020397A8 // =_0213414C
	str r0, [r1]
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _0203979C // =0x000004FC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	str r5, [r4]
	mov r5, #0
	ldr r1, _020397AC // =0x00002AAA
	str r5, [r4, #0x358]
	add r0, r4, #0x300
	strh r1, [r0, #0x5c]
	add r6, r4, #4
_0203972C:
	mov r0, r6
	bl BossArena__InitUnknown
	add r5, r5, #1
	cmp r5, #3
	add r6, r6, #0x11c
	blt _0203972C
	add r0, r4, #0xa8
	ldr r2, _020397B0 // =VRAMSystem__VRAM_PALETTE_BG
	ldr r1, _020397B4 // =VRAMSystem__VRAM_BG
	add ip, r0, #0x400
	mov r3, #0
	str r3, [ip, #0x10]
	ldr r0, [r2]
	str r3, [ip, #0x18]
	str r0, [ip, #0x1c]
	ldr r0, [r1]
	str r3, [ip, #0x20]
	str r0, [ip, #0x24]
	mov r0, #1
	str r0, [ip, #0x28]
	mov r1, #0x21
	mov r0, r4
	strh r1, [ip, #0x34]
	mov r1, #0x19
	strh r1, [ip, #0x36]
	bl BossArena__CallFunction2
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0203979C: .word 0x000004FC
_020397A0: .word BossArena__Main
_020397A4: .word BossArena__Destructor
_020397A8: .word _0213414C
_020397AC: .word 0x00002AAA
_020397B0: .word VRAMSystem__VRAM_PALETTE_BG
_020397B4: .word VRAMSystem__VRAM_BG
	arm_func_end BossArena__Create

	arm_func_start BossArena__Destroy
BossArena__Destroy: // 0x020397B8
	stmdb sp!, {r3, lr}
	ldr r0, _020397E0 // =_0213414C
	ldr r0, [r0]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	bl DestroyTask
	ldr r0, _020397E0 // =_0213414C
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, pc}
	.align 2, 0
_020397E0: .word _0213414C
	arm_func_end BossArena__Destroy

	arm_func_start BossArena__Func_20397E4
BossArena__Func_20397E4: // 0x020397E4
	stmdb sp!, {r3, lr}
	ldr r0, _020397FC // =_0213414C
	ldr r0, [r0]
	bl GetTaskWork_
	bl BossArena__CallFunction2
	ldmia sp!, {r3, pc}
	.align 2, 0
_020397FC: .word _0213414C
	arm_func_end BossArena__Func_20397E4

	arm_func_start BossArena__SetType
BossArena__SetType: // 0x02039800
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl BossArena__GetWork
	str r4, [r0]
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__SetType

	arm_func_start BossArena__GetType
BossArena__GetType: // 0x02039814
	stmdb sp!, {r3, lr}
	bl BossArena__GetWork
	ldr r0, [r0]
	ldmia sp!, {r3, pc}
	arm_func_end BossArena__GetType

	arm_func_start BossArena__GetCamera
BossArena__GetCamera: // 0x02039824
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl BossArena__GetWork
	add r1, r0, #4
	mov r0, #0x11c
	mla r0, r4, r0, r1
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__GetCamera

	arm_func_start BossArena__SetField358
BossArena__SetField358: // 0x02039840
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl BossArena__GetWork
	str r4, [r0, #0x358]
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__SetField358

	arm_func_start BossArena__SetField35C
BossArena__SetField35C: // 0x02039854
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl BossArena__GetWork
	add r0, r0, #0x300
	strh r4, [r0, #0x5c]
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__SetField35C

	arm_func_start BossArena__SetCameraType
BossArena__SetCameraType: // 0x0203986C
	str r1, [r0]
	bx lr
	arm_func_end BossArena__SetCameraType

	arm_func_start BossArena__GetCameraConfig2
BossArena__GetCameraConfig2: // 0x02039874
	add r0, r0, #4
	bx lr
	arm_func_end BossArena__GetCameraConfig2

	arm_func_start BossArena__GetCameraConfig
BossArena__GetCameraConfig: // 0x0203987C
	add r0, r0, #4
	bx lr
	arm_func_end BossArena__GetCameraConfig

	arm_func_start BossArena__SetCameraConfig
BossArena__SetCameraConfig: // 0x02039884
	ldr ip, _0203989C // =MIi_CpuCopy16
	mov r2, r0
	mov r0, r1
	add r1, r2, #4
	mov r2, #0x20
	bx ip
	.align 2, 0
_0203989C: .word MIi_CpuCopy16
	arm_func_end BossArena__SetCameraConfig

	arm_func_start BossArena__SetUpVector
BossArena__SetUpVector: // 0x020398A0
	add r3, r0, #0x54
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	bx lr
	arm_func_end BossArena__SetUpVector

	arm_func_start BossArena__SetNextPos
BossArena__SetNextPos: // 0x020398B0
	str r1, [r0, #0x60]
	str r2, [r0, #0x64]
	str r3, [r0, #0x68]
	bx lr
	arm_func_end BossArena__SetNextPos

	arm_func_start BossArena__SetTracker1TargetPos
BossArena__SetTracker1TargetPos: // 0x020398C0
	str r1, [r0, #0xac]
	str r2, [r0, #0xb0]
	str r3, [r0, #0xb4]
	bx lr
	arm_func_end BossArena__SetTracker1TargetPos

	arm_func_start BossArena__GetTracker1TargetPos
BossArena__GetTracker1TargetPos: // 0x020398D0
	cmp r1, #0
	ldrne ip, [r0, #0xac]
	strne ip, [r1]
	cmp r2, #0
	ldrne r1, [r0, #0xb0]
	strne r1, [r2]
	cmp r3, #0
	ldrne r0, [r0, #0xb4]
	strne r0, [r3]
	bx lr
	arm_func_end BossArena__GetTracker1TargetPos

	arm_func_start BossArena__SetTracker1TargetOffset
BossArena__SetTracker1TargetOffset: // 0x020398F8
	str r1, [r0, #0xe0]
	str r2, [r0, #0xe4]
	str r3, [r0, #0xe8]
	bx lr
	arm_func_end BossArena__SetTracker1TargetOffset

	arm_func_start BossArena__UpdateTracker1TargetPos
BossArena__UpdateTracker1TargetPos: // 0x02039908
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl BossArena__TrackTarget2
	add r0, r4, #0xac
	add r1, r4, #0xe0
	add r2, r4, #0xb8
	bl VEC_Add
	mov r0, #0
	str r0, [r4, #0xc8]
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__UpdateTracker1TargetPos

	arm_func_start BossArena__SetTracker1TargetWork
BossArena__SetTracker1TargetWork: // 0x02039930
	str r1, [r0, #0xd4]
	str r2, [r0, #0xd8]
	str r3, [r0, #0xdc]
	bx lr
	arm_func_end BossArena__SetTracker1TargetWork

	arm_func_start BossArena__SetTracker1UseObj3D
BossArena__SetTracker1UseObj3D: // 0x02039940
	str r1, [r0, #0xd0]
	bx lr
	arm_func_end BossArena__SetTracker1UseObj3D

	arm_func_start BossArena__SetTracker1Speed
BossArena__SetTracker1Speed: // 0x02039948
	strh r1, [r0, #0xc4]
	str r2, [r0, #0xcc]
	bx lr
	arm_func_end BossArena__SetTracker1Speed

	arm_func_start BossArena__SetTracker0TargetPos
BossArena__SetTracker0TargetPos: // 0x02039954
	str r1, [r0, #0x6c]
	str r2, [r0, #0x70]
	str r3, [r0, #0x74]
	bx lr
	arm_func_end BossArena__SetTracker0TargetPos

	arm_func_start BossArena__GetTracker0TargetPos
BossArena__GetTracker0TargetPos: // 0x02039964
	cmp r1, #0
	ldrne ip, [r0, #0x6c]
	strne ip, [r1]
	cmp r2, #0
	ldrne r1, [r0, #0x70]
	strne r1, [r2]
	cmp r3, #0
	ldrne r0, [r0, #0x74]
	strne r0, [r3]
	bx lr
	arm_func_end BossArena__GetTracker0TargetPos

	arm_func_start BossArena__UpdateTracker0TargetPos
BossArena__UpdateTracker0TargetPos: // 0x0203998C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl BossArena__TrackTarget1
	add r0, r4, #0x6c
	add r1, r4, #0xa0
	add r2, r4, #0x78
	bl VEC_Add
	mov r0, #0
	str r0, [r4, #0x88]
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__UpdateTracker0TargetPos

	arm_func_start BossArena__SetTracker0TargetWork
BossArena__SetTracker0TargetWork: // 0x020399B4
	str r1, [r0, #0x94]
	str r2, [r0, #0x98]
	str r3, [r0, #0x9c]
	bx lr
	arm_func_end BossArena__SetTracker0TargetWork

	arm_func_start BossArena__SetTracker0Speed
BossArena__SetTracker0Speed: // 0x020399C4
	strh r1, [r0, #0x84]
	str r2, [r0, #0x8c]
	bx lr
	arm_func_end BossArena__SetTracker0Speed

	arm_func_start BossArena__SetAmplitudeXZTarget
BossArena__SetAmplitudeXZTarget: // 0x020399D0
	str r1, [r0, #0xec]
	bx lr
	arm_func_end BossArena__SetAmplitudeXZTarget

	arm_func_start BossArena__ApplyAmplitudeXZTarget
BossArena__ApplyAmplitudeXZTarget: // 0x020399D8
	ldr r1, [r0, #0xec]
	str r1, [r0, #0xf0]
	bx lr
	arm_func_end BossArena__ApplyAmplitudeXZTarget

	arm_func_start BossArena__SetAmplitudeXZSpeed
BossArena__SetAmplitudeXZSpeed: // 0x020399E4
	strh r1, [r0, #0xf4]
	bx lr
	arm_func_end BossArena__SetAmplitudeXZSpeed

	arm_func_start BossArena__SetAmplitudeYTarget
BossArena__SetAmplitudeYTarget: // 0x020399EC
	str r1, [r0, #0x100]
	bx lr
	arm_func_end BossArena__SetAmplitudeYTarget

	arm_func_start BossArena__ApplyAmplitudeYTarget
BossArena__ApplyAmplitudeYTarget: // 0x020399F4
	ldr r1, [r0, #0x100]
	str r1, [r0, #0x104]
	bx lr
	arm_func_end BossArena__ApplyAmplitudeYTarget

	arm_func_start BossArena__SetAmplitudeYSpeed
BossArena__SetAmplitudeYSpeed: // 0x02039A00
	add r0, r0, #0x100
	strh r1, [r0, #8]
	bx lr
	arm_func_end BossArena__SetAmplitudeYSpeed

	arm_func_start BossArena__SetAngleTarget
BossArena__SetAngleTarget: // 0x02039A0C
	add r0, r0, #0x100
	strh r1, [r0, #0x14]
	bx lr
	arm_func_end BossArena__SetAngleTarget

	arm_func_start BossArena__GetAngleTarget
BossArena__GetAngleTarget: // 0x02039A18
	add r0, r0, #0x100
	ldrh r0, [r0, #0x14]
	bx lr
	arm_func_end BossArena__GetAngleTarget

	arm_func_start BossArena__ApplyAngleTarget
BossArena__ApplyAngleTarget: // 0x02039A24
	add r0, r0, #0x100
	ldrh r1, [r0, #0x14]
	strh r1, [r0, #0x16]
	bx lr
	arm_func_end BossArena__ApplyAngleTarget

	arm_func_start BossArena__SetAngleSpeed
BossArena__SetAngleSpeed: // 0x02039A34
	add r0, r0, #0x100
	strh r1, [r0, #0x18]
	bx lr
	arm_func_end BossArena__SetAngleSpeed

	arm_func_start BossArena__SetUnknown2Type
BossArena__SetUnknown2Type: // 0x02039A40
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl BossArena__GetWork
	mov r4, r0
	add r0, r4, #0x360
	bl BossArena__FreeMappings
	str r5, [r4, #0x360]
	cmp r5, #2
	ldmneia sp!, {r3, r4, r5, pc}
	add r0, r4, #0x360
	bl BossArena__AllocMappings
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossArena__SetUnknown2Type

	arm_func_start BossArena__GetUnknown2Animator
BossArena__GetUnknown2Animator: // 0x02039A70
	stmdb sp!, {r3, lr}
	bl BossArena__GetWork
	add r0, r0, #0x364
	ldmia sp!, {r3, pc}
	arm_func_end BossArena__GetUnknown2Animator

	arm_func_start BossArena__GetField4A8
BossArena__GetField4A8: // 0x02039A80
	stmdb sp!, {r3, lr}
	bl BossArena__GetWork
	add r0, r0, #0xa8
	add r0, r0, #0x400
	ldmia sp!, {r3, pc}
	arm_func_end BossArena__GetField4A8

	arm_func_start BossArena__Func_2039A94
BossArena__Func_2039A94: // 0x02039A94
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl BossArena__GetWork
	add r0, r0, #0x460
	strh r5, [r0, #0x94]
	strh r4, [r0, #0x96]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossArena__Func_2039A94

	arm_func_start BossArena__Func_2039AB4
BossArena__Func_2039AB4: // 0x02039AB4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	bl BossArena__GetWork
	add r0, r0, #0x460
	strh r5, [r0, #0x98]
	strh r4, [r0, #0x9a]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossArena__Func_2039AB4

	arm_func_start BossArena__Func_2039AD4
BossArena__Func_2039AD4: // 0x02039AD4
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0x24
	mov sl, r0
	mov sb, r2
	mov r0, r1
	add r2, sp, #0x18
	mov r1, sl
	mov r4, r3
	ldr r8, [sp, #0x4c]
	ldr r7, [sp, #0x58]
	bl VEC_Subtract
	add r1, sp, #0x18
	mov r0, sb
	add r2, sp, #0
	bl VEC_CrossProduct
	add r0, sp, #0
	mov r1, r0
	bl VEC_Normalize
	add r0, sp, #0x18
	add r1, sp, #0
	add r2, sp, #0xc
	bl VEC_CrossProduct
	add r0, sp, #0xc
	mov r1, r0
	bl VEC_Normalize
	mov r5, r4, asr #1
	ldr r1, [sp, #0xc]
	ldr r0, [sl]
	smull r2, r1, r5, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r0, r0, r2
	str r0, [r8]
	ldr r2, [sp, #0x10]
	ldr r1, [sl, #4]
	smull r3, r2, r5, r2
	adds r3, r3, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r1, r1, r3
	str r1, [r8, #4]
	ldr r3, [sp, #0x14]
	ldrh r6, [sp, #0x48]
	smull ip, r3, r5, r3
	adds ip, ip, #0x800
	rsb r1, r6, #0
	mov r1, r1, lsl #0xf
	ldr r2, [sl, #8]
	adc r3, r3, #0
	mov ip, ip, lsr #0xc
	orr ip, ip, r3, lsl #20
	add r2, r2, ip
	str r2, [r8, #8]
	ldr r3, [sp, #0x50]
	add r0, sp, #0
	mov r1, r1, lsr #0x10
	add r2, sp, #0x18
	mov r4, r5, asr #0x1f
	bl sub_20668A8
	ldr r1, [sp, #0x50]
	mov r0, r8
	mov r2, r1
	bl VEC_Add
	ldr ip, [sp, #0x54]
	ldmia sb, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r1, [sp, #0xc]
	ldr r0, [sl]
	smull r2, r1, r5, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r0, r0, r2
	str r0, [r7]
	ldr r1, [sp, #0x10]
	ldr r0, [sl, #4]
	smull r2, r1, r5, r1
	adds r2, r2, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	sub r0, r0, r2
	mov r8, #0
	mov r3, #0x800
	str r0, [r7, #4]
	ldr r2, [sp, #0x14]
	mov r1, r6, lsl #0xf
	mov r0, r2, asr #0x1f
	umull ip, r6, r5, r2
	mla r6, r5, r0, r6
	mla r6, r4, r2, r6
	adds r3, ip, r3
	mov r2, r3, lsr #0xc
	adc r0, r6, r8
	orr r2, r2, r0, lsl #20
	ldr r3, [sl, #8]
	add r0, sp, #0
	sub r4, r3, r2
	ldr r3, [sp, #0x5c]
	add r2, sp, #0x18
	mov r1, r1, lsr #0x10
	str r4, [r7, #8]
	bl sub_20668A8
	ldr r1, [sp, #0x5c]
	mov r0, r7
	mov r2, r1
	bl VEC_Add
	ldr r3, [sp, #0x60]
	ldmia sb, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add sp, sp, #0x24
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	arm_func_end BossArena__Func_2039AD4

	arm_func_start BossArena__Func_2039CA4
BossArena__Func_2039CA4: // 0x02039CA4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x34
	mov r5, r2
	mov r6, r1
	mov r4, r3
	mov r7, r0
	add r2, sp, #0x28
	mov r0, r4
	mov r1, r5
	bl VEC_Subtract
	ldr r0, [sp, #0x30]
	ldr r1, [sp, #0x28]
	bl FX_Atan2Idx
	mov r2, r0, asr #4
	ldrh r1, [sp, #0x48]
	ldrsh r3, [sp, #0x50]
	add r0, sp, #0x28
	mul r1, r2, r1
	add r2, r3, r1, asr #12
	add r1, sp, #0x10
	strh r2, [r7]
	bl VEC_Normalize
	mov r1, #0
	mov r0, #0x1000
	str r0, [sp, #4]
	str r1, [sp, #0x24]
	str r1, [sp, #0x20]
	str r1, [sp, #0x1c]
	str r1, [sp]
	str r1, [sp, #8]
	ldr r1, [r5, #4]
	add r0, sp, #0
	rsb r2, r1, #0
	add r1, sp, #0x10
	str r2, [sp, #0xc]
	bl sub_20670CC
	bl Math__Func_207B14C
	mov r1, r4
	mov r4, r0
	add r0, sp, #0
	bl sub_20670B4
	cmp r0, #0
	rsblt r0, r4, #0
	movlt r0, r0, lsl #0x10
	movlt r4, r0, lsr #0x10
	mov r0, r4, lsl #0x10
	mov r0, r0, asr #0x10
	rsb r0, r0, #0
	mov r0, r0, asr #2
	add r1, r0, #0x1000
	mov r2, r1, asr #1
	ldrh r0, [sp, #0x4c]
	ldrsh r1, [sp, #0x54]
	mul r0, r2, r0
	add r0, r1, r0, asr #12
	strh r0, [r6]
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end BossArena__Func_2039CA4

	arm_func_start BossArena__GetWork
BossArena__GetWork: // 0x02039D8C
	ldr r0, _02039D9C // =_0213414C
	ldr ip, _02039DA0 // =GetTaskWork_
	ldr r0, [r0]
	bx ip
	.align 2, 0
_02039D9C: .word _0213414C
_02039DA0: .word GetTaskWork_
	arm_func_end BossArena__GetWork

	arm_func_start BossArena__InitUnknown
BossArena__InitUnknown: // 0x02039DA4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x11c
	bl MIi_CpuClear16
	mov r0, #1
	str r0, [r4]
	ldr ip, _02039E34 // =0x00001555
	mov r2, #0x1000
	strh ip, [r4, #4]
	str r2, [r4, #8]
	mov r0, #0x800000
	str r0, [r4, #0xc]
	str ip, [r4, #0x10]
	mov r3, #0
	str r2, [r4, #0x14]
	str r3, [r4, #0x54]
	str r2, [r4, #0x58]
	str r3, [r4, #0x5c]
	mov r2, #0x200
	strh r2, [r4, #0xc4]
	mov r1, #0xc8000
	strh r2, [r4, #0x84]
	str r1, [r4, #0xf0]
	str r1, [r4, #0xec]
	mov r0, #0x3c000
	strh r2, [r4, #0xf4]
	str r0, [r4, #0x104]
	str r0, [r4, #0x100]
	add r0, r4, #0x100
	strh r2, [r0, #8]
	strh r3, [r0, #0x16]
	strh r3, [r0, #0x14]
	strh r2, [r0, #0x18]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02039E34: .word 0x00001555
	arm_func_end BossArena__InitUnknown

	arm_func_start BossArena__Func_2039E38
BossArena__Func_2039E38: // 0x02039E38
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	add r2, sp, #0
	add r1, r4, #0xc
	bl VEC_Subtract
	ldrsh r0, [r4, #0x18]
	ldr r1, [sp]
	ldr r2, [sp, #4]
	smull r3, r0, r1, r0
	adds r1, r3, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp]
	ldrsh r0, [r4, #0x18]
	ldr r1, [sp, #8]
	smull r3, r0, r2, r0
	adds r2, r3, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp, #4]
	ldrsh r0, [r4, #0x18]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #8]
	ldr r0, [r4, #0x20]
	cmp r0, #0
	ble _02039F90
	add r0, sp, #0
	bl VEC_Mag
	mov r5, r0
	cmp r5, #4
	ble _02039F04
	ldr r0, [sp]
	mov r1, r5
	bl FX_Div
	str r0, [sp]
	ldr r0, [sp, #4]
	mov r1, r5
	bl FX_Div
	str r0, [sp, #4]
	ldr r0, [sp, #8]
	mov r1, r5
	bl FX_Div
	str r0, [sp, #8]
	b _02039F14
_02039F04:
	mov r0, #0
	str r0, [sp, #8]
	str r0, [sp, #4]
	str r0, [sp]
_02039F14:
	ldr r1, [r4, #0x1c]
	cmp r1, r5
	strge r5, [r4, #0x1c]
	bge _02039F30
	ldr r0, [r4, #0x20]
	add r0, r1, r0
	str r0, [r4, #0x1c]
_02039F30:
	ldr r1, [sp]
	ldr r0, [r4, #0x1c]
	ldr r2, [sp, #4]
	smull r3, r0, r1, r0
	adds r1, r3, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp]
	ldr r0, [r4, #0x1c]
	ldr r1, [sp, #8]
	smull r3, r0, r2, r0
	adds r2, r3, #0x800
	adc r0, r0, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp, #4]
	ldr r0, [r4, #0x1c]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #8]
_02039F90:
	add r0, r4, #0xc
	add r1, sp, #0
	mov r2, r0
	bl VEC_Add
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end BossArena__Func_2039E38

	arm_func_start BossArena__Func_2039FA8
BossArena__Func_2039FA8: // 0x02039FA8
	ldr r3, [r0]
	ldr r2, [r0, #4]
	ldrsh r1, [r0, #8]
	sub r3, r3, r2
	ldr r2, [r0, #0x10]
	smull ip, r1, r3, r1
	adds r3, ip, #0x800
	adc r1, r1, #0
	mov r3, r3, lsr #0xc
	cmp r2, #0
	orr r3, r3, r1, lsl #20
	ble _02039FF0
	ldr r1, [r0, #0xc]
	cmp r1, r3
	addlt r1, r1, r2
	strlt r1, [r0, #0xc]
	strge r3, [r0, #0xc]
	ldr r3, [r0, #0xc]
_02039FF0:
	ldr r1, [r0, #4]
	add r1, r1, r3
	str r1, [r0, #4]
	bx lr
	arm_func_end BossArena__Func_2039FA8

	arm_func_start BossArena__Func_203A000
BossArena__Func_203A000: // 0x0203A000
	ldrh r3, [r0, #2]
	ldrh r1, [r0]
	ldrsh r2, [r0, #4]
	sub r1, r1, r3
	smulbb r1, r2, r1
	mov r1, r1, lsl #4
	add r1, r3, r1, lsr #16
	strh r1, [r0, #2]
	bx lr
	arm_func_end BossArena__Func_203A000

	arm_func_start BossArena__Func_203A024
BossArena__Func_203A024: // 0x0203A024
	stmdb sp!, {r4, r5, r6, lr}
	ldrh r4, [sp, #0x10]
	ldr r5, _0203A09C // =FX_SinCosTable_
	ldr ip, [r1]
	mov r4, r4, asr #4
	mov r6, r4, lsl #1
	mov r4, r6, lsl #1
	ldrsh r4, [r5, r4]
	add lr, r6, #1
	mov lr, lr, lsl #1
	smull r6, r4, r2, r4
	adds r6, r6, #0x800
	ldrsh lr, [r5, lr]
	adc r5, r4, #0
	mov r6, r6, lsr #0xc
	smull r4, lr, r2, lr
	adds r4, r4, #0x800
	orr r6, r6, r5, lsl #20
	add r2, ip, r6
	str r2, [r0]
	ldr ip, [r1, #4]
	adc r2, lr, #0
	add r3, ip, r3
	str r3, [r0, #4]
	mov r3, r4, lsr #0xc
	ldr r1, [r1, #8]
	orr r3, r3, r2, lsl #20
	add r1, r1, r3
	str r1, [r0, #8]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0203A09C: .word FX_SinCosTable_
	arm_func_end BossArena__Func_203A024

	arm_func_start BossArena__Func_203A0A0
BossArena__Func_203A0A0: // 0x0203A0A0
	add r0, r0, #0x100
	ldrh r0, [r0, #0x98]
	bx lr
	arm_func_end BossArena__Func_203A0A0

	arm_func_start BossArena__Func_203A0AC
BossArena__Func_203A0AC: // 0x0203A0AC
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x100
	ldrh r0, [r0, #0x9a]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x14c]
	bl GetBackgroundHeight
	add r1, r4, #0x100
	ldrh r1, [r1, #0x98]
	sub r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__Func_203A0AC

	arm_func_start BossArena__Main
BossArena__Main: // 0x0203A0E4
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	bl BossArena__CallFunction2
	ldmia sp!, {r3, pc}
	arm_func_end BossArena__Main

	arm_func_start BossArena__Destructor
BossArena__Destructor: // 0x0203A0F4
	stmdb sp!, {r4, lr}
	ldr r0, _0203A128 // =_0213414C
	ldr r0, [r0]
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #0x364
	bl AnimatorMDL__Release
	add r0, r4, #0x360
	bl BossArena__FreeMappings
	ldr r0, _0203A128 // =_0213414C
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0203A128: .word _0213414C
	arm_func_end BossArena__Destructor

	arm_func_start BossArena__CallFunction2
BossArena__CallFunction2: // 0x0203A12C
	stmdb sp!, {r3, lr}
	ldr r2, [r0]
	ldr r1, _0203A144 // =_0210F5CC
	ldr r1, [r1, r2, lsl #2]
	blx r1
	ldmia sp!, {r3, pc}
	.align 2, 0
_0203A144: .word _0210F5CC
	arm_func_end BossArena__CallFunction2

	arm_func_start BossArena__Func_203A148
BossArena__Func_203A148: // 0x0203A148
	stmdb sp!, {r4, lr}
	mov r2, #0x80000
	mov r4, r0
	str r2, [r4, #0x34]
	sub r1, r2, #0xe0000
	str r1, [r4, #0x38]
	mov r0, #0
	str r0, [r4, #0x3c]
	str r2, [r4, #0x28]
	str r1, [r4, #0x2c]
	ldrh r0, [r4, #8]
	ldr r2, _0203A1C4 // =FX_SinCosTable_
	mov r0, r0, asr #4
	mov r1, r0, lsl #1
	add r0, r1, #1
	mov r0, r0, lsl #1
	mov r1, r1, lsl #1
	ldrsh r0, [r2, r0]
	ldrsh r1, [r2, r1]
	bl FX_Div
	mov r1, #0x60
	mul r1, r0, r1
	str r1, [r4, #0x30]
	mov r1, #0
	str r1, [r4, #0x40]
	mov r0, #0x1000
	str r0, [r4, #0x44]
	add r0, r4, #8
	str r1, [r4, #0x48]
	bl Camera3D__LoadState
	ldmia sp!, {r4, pc}
	.align 2, 0
_0203A1C4: .word FX_SinCosTable_
	arm_func_end BossArena__Func_203A148

	arm_func_start BossArena__Func_203A1C8
BossArena__Func_203A1C8: // 0x0203A1C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #4
	bl BossArena__CallFunction1
	add r0, r4, #8
	bl Camera3D__LoadState
	add r0, r4, #0x360
	add r1, r4, #4
	bl BossArena__DrawBackground
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__Func_203A1C8

	arm_func_start BossArena__Func_203A1F0
BossArena__Func_203A1F0: // 0x0203A1F0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r1, r4, #4
	bl BossArena__CallFunction1
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldr r0, [r4, #0x358]
	rsbne r0, r0, #0
	mov r0, r0, asr #1
	str r0, [r4, #0x20]
	add r0, r4, #8
	bl Camera3D__LoadState
	add r0, r4, #0x360
	add r1, r4, #4
	bl BossArena__DrawBackground
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__Func_203A1F0

	arm_func_start BossArena__Func_203A230
BossArena__Func_203A230: // 0x0203A230
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x64
	mov r4, r0
	add r1, r4, #4
	bl BossArena__CallFunction1
	add r0, r4, #0x300
	ldrh r2, [r0, #0x5c]
	add r1, sp, #0x58
	add r0, sp, #0x4c
	str r2, [sp]
	str r1, [sp, #4]
	str r0, [sp, #8]
	add r1, sp, #0x40
	str r1, [sp, #0xc]
	add r0, sp, #0x34
	str r0, [sp, #0x10]
	add r1, sp, #0x28
	str r1, [sp, #0x14]
	add r0, sp, #0x1c
	str r0, [sp, #0x18]
	ldr r3, [r4, #0x358]
	add r0, r4, #0x28
	add r1, r4, #0x34
	add r2, r4, #0x40
	bl BossArena__Func_2039AD4
	add r0, r4, #0x120
	mov r1, #0
	bl BossArena__SetCameraType
	ldr r1, [sp, #0x58]
	ldr r2, [sp, #0x5c]
	ldr r3, [sp, #0x60]
	add r0, r4, #0x120
	bl BossArena__SetTracker0TargetPos
	ldr r1, [sp, #0x4c]
	ldr r2, [sp, #0x50]
	ldr r3, [sp, #0x54]
	add r0, r4, #0x120
	bl BossArena__SetTracker1TargetPos
	add r0, r4, #0x120
	add r1, sp, #0x40
	bl BossArena__SetUpVector
	add r0, r4, #0x23c
	mov r1, #0
	bl BossArena__SetCameraType
	ldr r1, [sp, #0x34]
	ldr r2, [sp, #0x38]
	ldr r3, [sp, #0x3c]
	add r0, r4, #0x23c
	bl BossArena__SetTracker0TargetPos
	ldr r1, [sp, #0x28]
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x30]
	add r0, r4, #0x23c
	bl BossArena__SetTracker1TargetPos
	add r0, r4, #0x23c
	add r1, sp, #0x1c
	bl BossArena__SetUpVector
	bl Camera3D__UseEngineA
	cmp r0, #0
	mov r0, r4
	beq _0203A348
	add r1, r4, #0x23c
	bl BossArena__CallFunction1
	add r5, r4, #0x120
	mov r0, r4
	mov r1, r5
	bl BossArena__CallFunction1
	add r0, r5, #4
	bl Camera3D__LoadState
	b _0203A368
_0203A348:
	add r1, r4, #0x120
	bl BossArena__CallFunction1
	add r5, r4, #0x23c
	mov r0, r4
	mov r1, r5
	bl BossArena__CallFunction1
	add r0, r5, #4
	bl Camera3D__LoadState
_0203A368:
	mov r1, r5
	add r0, r4, #0x360
	bl BossArena__DrawBackground
	add sp, sp, #0x64
	ldmia sp!, {r4, r5, pc}
	arm_func_end BossArena__Func_203A230

	arm_func_start BossArena__Func_203A37C
BossArena__Func_203A37C: // 0x0203A37C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r1, r5, #4
	bl BossArena__CallFunction1
	bl Camera3D__UseEngineA
	cmp r0, #0
	mov r0, r5
	beq _0203A3C0
	add r1, r5, #0x23c
	bl BossArena__CallFunction1
	add r4, r5, #0x120
	mov r0, r5
	mov r1, r4
	bl BossArena__CallFunction1
	add r0, r4, #4
	bl Camera3D__LoadState
	b _0203A3E0
_0203A3C0:
	add r1, r5, #0x120
	bl BossArena__CallFunction1
	add r4, r5, #0x23c
	mov r0, r5
	mov r1, r4
	bl BossArena__CallFunction1
	add r0, r4, #4
	bl Camera3D__LoadState
_0203A3E0:
	mov r1, r4
	add r0, r5, #0x360
	bl BossArena__DrawBackground
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end BossArena__Func_203A37C

	arm_func_start BossArena__DrawBackground
BossArena__DrawBackground: // 0x0203A3F0
	stmdb sp!, {r3, lr}
	ldr r2, [r0]
	cmp r2, #1
	beq _0203A40C
	cmp r2, #2
	beq _0203A414
	ldmia sp!, {r3, pc}
_0203A40C:
	bl BossArena__DrawBackground3D
	ldmia sp!, {r3, pc}
_0203A414:
	bl BossArena__DrawBackground2D
	ldmia sp!, {r3, pc}
	arm_func_end BossArena__DrawBackground

	arm_func_start BossArena__DrawBackground3D
BossArena__DrawBackground3D: // 0x0203A41C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r1, #0x24
	add r3, r4, #0x4c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #4
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #4
	bl AnimatorMDL__Draw
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__DrawBackground3D

	arm_func_start BossArena__DrawBackground2D
BossArena__DrawBackground2D: // 0x0203A448
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x28
	mov sl, r0
	mov r0, r1
	bl BossArena__GetCameraConfig2
	mov r1, #0x400
	str r1, [sp]
	mov r1, #0x240
	str r1, [sp, #4]
	add r2, sl, #0x100
	ldrsh r3, [r2, #0x94]
	mov r5, r0
	add r0, sp, #0x24
	str r3, [sp, #8]
	ldrsh r4, [r2, #0x96]
	add r1, sp, #0x26
	add r2, r5, #0x20
	add r3, r5, #0x2c
	str r4, [sp, #0xc]
	bl BossArena__Func_2039CA4
	ldr r0, [sl, #0x14c]
	bl GetBackgroundMappings
	add r4, r0, #4
	mov r0, sl
	bl BossArena__Func_203A0A0
	mov r5, r0, lsl #0x10
	mov r0, sl
	mov r8, r5, asr #0x10
	bl BossArena__Func_203A0AC
	add r0, r0, r5, asr #16
	mov r0, r0, lsl #0x10
	mov fp, r0, asr #0x10
	mov r5, #0
	sub r0, fp, #1
	mov r7, r5
	str r0, [sp, #0x20]
_0203A4D8:
	ldrsh r0, [sp, #0x26]
	add r2, r5, r0, asr #3
	cmp r8, r2
	movgt r2, r8
	bgt _0203A4F4
	cmp fp, r2
	ldrle r2, [sp, #0x20]
_0203A4F4:
	ldrsh r0, [sp, #0x24]
	ldr r1, [sl, #0x190]
	mov r0, r0, asr #3
	and r3, r0, #0x7f
	cmp r3, #0x5f
	bgt _0203A524
	add r0, r4, r2, lsl #8
	mov r2, #0x42
	add r0, r0, r3, lsl #1
	add r1, r1, r7
	bl MIi_CpuCopy16
	b _0203A558
_0203A524:
	add sb, r4, r2, lsl #8
	rsb r6, r3, #0x80
	add r0, sb, r3, lsl #1
	add r1, r1, r7
	mov r2, r6, lsl #1
	bl MIi_CpuCopy16
	ldr r1, [sl, #0x190]
	rsb r2, r6, #0x21
	add r1, r1, r7
	mov r0, sb
	add r1, r1, r6, lsl #1
	mov r2, r2, lsl #1
	bl MIi_CpuCopy16
_0203A558:
	add r5, r5, #1
	cmp r5, #0x19
	add r7, r7, #0x42
	blt _0203A4D8
	ldr r0, [sl, #0x190]
	ldr r1, _0203A628 // =0x00000672
	bl DC_StoreRange
	mov r1, #0
	str r1, [sp]
	ldr r2, [sl, #0x170]
	add r0, sl, #0x100
	str r2, [sp, #4]
	ldrh r4, [r0, #0x74]
	mov r2, r1
	mov r3, #0x21
	str r4, [sp, #8]
	ldrh r4, [r0, #0x76]
	str r4, [sp, #0xc]
	ldrh r4, [r0, #0x78]
	str r4, [sp, #0x10]
	ldrh r4, [r0, #0x7a]
	str r4, [sp, #0x14]
	ldrh r4, [r0, #0x7c]
	str r4, [sp, #0x18]
	ldrh r0, [r0, #0x7e]
	str r0, [sp, #0x1c]
	ldr r0, [sl, #0x190]
	bl Mappings__ReadMappingsCompressed
	bl Camera3D__GetTask
	cmp r0, #0
	beq _0203A5F4
	bl Camera3D__UseEngineA
	cmp r0, #0
	movne r4, #0
	moveq r4, #1
	bl Camera3D__GetWork
	mov r1, #0x5c
	mla r2, r4, r1, r0
	b _0203A5F8
_0203A5F4:
	ldr r2, _0203A62C // =renderCoreGFXControlA
_0203A5F8:
	ldrsh r1, [sp, #0x24]
	ldrb r0, [sl, #0x15c]
	and r1, r1, #7
	mov r0, r0, lsl #2
	strh r1, [r2, r0]
	ldrsh r1, [sp, #0x26]
	ldrb r0, [sl, #0x15c]
	and r1, r1, #7
	add r0, r2, r0, lsl #2
	strh r1, [r0, #2]
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0203A628: .word 0x00000672
_0203A62C: .word renderCoreGFXControlA
	arm_func_end BossArena__DrawBackground2D

	arm_func_start BossArena__AllocMappings
BossArena__AllocMappings: // 0x0203A630
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x190]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, _0203A654 // =0x00000672
	bl _AllocTailHEAP_SYSTEM
	str r0, [r4, #0x190]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0203A654: .word 0x00000672
	arm_func_end BossArena__AllocMappings

	arm_func_start BossArena__FreeMappings
BossArena__FreeMappings: // 0x0203A658
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x190]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl _FreeHEAP_SYSTEM
	mov r0, #0
	str r0, [r4, #0x190]
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__FreeMappings

	arm_func_start BossArena__TrackTarget1
BossArena__TrackTarget1: // 0x0203A67C
	ldr r1, [r0, #0x90]
	cmp r1, #0
	ldr r1, [r0, #0x94]
	beq _0203A6EC
	cmp r1, #0
	beq _0203A6A8
	ldr r2, [r1, #0x12c]
	ldr r1, [r0, #0xa0]
	ldr r2, [r2, #0x48]
	add r1, r2, r1
	str r1, [r0, #0x6c]
_0203A6A8:
	ldr r1, [r0, #0x98]
	cmp r1, #0
	beq _0203A6C8
	ldr r2, [r1, #0x12c]
	ldr r1, [r0, #0xa4]
	ldr r2, [r2, #0x4c]
	add r1, r2, r1
	str r1, [r0, #0x70]
_0203A6C8:
	ldr r1, [r0, #0x9c]
	cmp r1, #0
	bxeq lr
	ldr r2, [r1, #0x12c]
	ldr r1, [r0, #0xa8]
	ldr r2, [r2, #0x50]
	add r1, r2, r1
	str r1, [r0, #0x74]
	bx lr
_0203A6EC:
	cmp r1, #0
	beq _0203A704
	ldr r2, [r1, #0x44]
	ldr r1, [r0, #0xa0]
	add r1, r2, r1
	str r1, [r0, #0x6c]
_0203A704:
	ldr r1, [r0, #0x98]
	cmp r1, #0
	beq _0203A720
	ldr r2, [r0, #0xa4]
	ldr r1, [r1, #0x48]
	sub r1, r2, r1
	str r1, [r0, #0x70]
_0203A720:
	ldr r1, [r0, #0x9c]
	cmp r1, #0
	bxeq lr
	ldr r2, [r1, #0x4c]
	ldr r1, [r0, #0xa8]
	add r1, r2, r1
	str r1, [r0, #0x74]
	bx lr
	arm_func_end BossArena__TrackTarget1

	arm_func_start BossArena__TrackTarget2
BossArena__TrackTarget2: // 0x0203A740
	ldr r1, [r0, #0xd0]
	cmp r1, #0
	ldr r1, [r0, #0xd4]
	beq _0203A7B0
	cmp r1, #0
	beq _0203A76C
	ldr r2, [r1, #0x12c]
	ldr r1, [r0, #0xe0]
	ldr r2, [r2, #0x48]
	add r1, r2, r1
	str r1, [r0, #0xac]
_0203A76C:
	ldr r1, [r0, #0xd8]
	cmp r1, #0
	beq _0203A78C
	ldr r2, [r1, #0x12c]
	ldr r1, [r0, #0xe4]
	ldr r2, [r2, #0x4c]
	add r1, r2, r1
	str r1, [r0, #0xb0]
_0203A78C:
	ldr r1, [r0, #0xdc]
	cmp r1, #0
	bxeq lr
	ldr r2, [r1, #0x12c]
	ldr r1, [r0, #0xe8]
	ldr r2, [r2, #0x50]
	add r1, r2, r1
	str r1, [r0, #0xb4]
	bx lr
_0203A7B0:
	cmp r1, #0
	beq _0203A7C8
	ldr r2, [r1, #0x44]
	ldr r1, [r0, #0xe0]
	add r1, r2, r1
	str r1, [r0, #0xac]
_0203A7C8:
	ldr r1, [r0, #0xd8]
	cmp r1, #0
	beq _0203A7E4
	ldr r2, [r0, #0xe4]
	ldr r1, [r1, #0x48]
	sub r1, r2, r1
	str r1, [r0, #0xb0]
_0203A7E4:
	ldr r1, [r0, #0xdc]
	cmp r1, #0
	bxeq lr
	ldr r2, [r1, #0x4c]
	ldr r1, [r0, #0xe8]
	add r1, r2, r1
	str r1, [r0, #0xb4]
	bx lr
	arm_func_end BossArena__TrackTarget2

	arm_func_start BossArena__CallFunction1
BossArena__CallFunction1: // 0x0203A804
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	mov r5, r0
	mov r0, r4
	bl BossArena__TrackTarget1
	mov r0, r4
	bl BossArena__TrackTarget2
	ldr r2, [r4]
	ldr r1, _0203A85C // =BossArena__FuncTable
	mov r0, r5
	ldr r2, [r1, r2, lsl #2]
	mov r1, r4
	blx r2
	add r0, r4, #0x60
	add r3, r4, #0x48
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, #0
	str r0, [r4, #0x60]
	str r0, [r4, #0x64]
	str r0, [r4, #0x68]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0203A85C: .word BossArena__FuncTable
	arm_func_end BossArena__CallFunction1

	arm_func_start BossArena__Func_203A860
BossArena__Func_203A860: // 0x0203A860
	stmdb sp!, {r4, lr}
	mov r4, r1
	add r0, r4, #0x6c
	bl BossArena__Func_2039E38
	add r0, r4, #0x78
	add r3, r4, #0x24
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0xac
	bl BossArena__Func_2039E38
	add r0, r4, #0xb8
	add r3, r4, #0x30
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0x54
	add r3, r4, #0x3c
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldmia sp!, {r4, pc}
	arm_func_end BossArena__Func_203A860

	arm_func_start BossArena__Func_203A8AC
BossArena__Func_203A8AC: // 0x0203A8AC
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	mov r4, r1
	add r0, r4, #0xac
	bl BossArena__Func_2039E38
	add r0, r4, #0xb8
	add r3, r4, #0x30
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0xec
	bl BossArena__Func_2039FA8
	add r0, r4, #0x100
	bl BossArena__Func_2039FA8
	add r0, r4, #0x114
	bl BossArena__Func_203A000
	add r0, r4, #0x100
	ldrh r2, [r0, #0x16]
	add r0, r4, #0x6c
	add r1, r4, #0xb8
	str r2, [sp]
	ldr r2, [r4, #0xf0]
	ldr r3, [r4, #0x104]
	bl BossArena__Func_203A024
	add r0, r4, #0x6c
	bl BossArena__Func_2039E38
	add r0, r4, #0x78
	add lr, r4, #0x24
	add ip, r4, #0x54
	add r3, r4, #0x3c
	ldmia r0, {r0, r1, r2}
	stmia lr, {r0, r1, r2}
	ldmia ip, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end BossArena__Func_203A8AC

	.rodata

.public BossArena__explosionFXSpawnTime
BossArena__explosionFXSpawnTime: // 0x0210F5B8
	.word 90, 135, 150

BossArena__FuncTable: // 0x0210F5C4
	.word BossArena__Func_203A860
	.word BossArena__Func_203A8AC

_0210F5CC: // 0x0210F5CC
	.word BossArena__Func_203A148
	.word BossArena__Func_203A1C8
	.word BossArena__Func_203A1F0
	.word BossArena__Func_203A230
	.word BossArena__Func_203A37C