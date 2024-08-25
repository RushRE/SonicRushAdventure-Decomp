	.include "asm/macros.inc"
	.include "global.inc"

	.bss
	
_0218A390: // 0x0218A390
	.space 0x04
	
	.text

	arm_func_start Trampoline3D__Create
Trampoline3D__Create: // 0x02179028
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x4c
	mov r7, r0
	ldrb r0, [r7, #9]
	mov r6, r1
	mov r5, r2
	bl Trampoline3D__Func_2179FD0
	cmp r0, #0
	addeq sp, sp, #0x4c
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	ldr r0, _0217958C // =0x000010F6
	mov r2, #0
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	ldr r4, _02179590 // =0x000005E4
	ldr r0, _02179594 // =StageTask_Main
	ldr r1, _02179598 // =Trampoline3D__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	mov r4, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r4, r0
	addeq sp, sp, #0x4c
	moveq r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, pc}
	mov r0, r4
	bl GetTaskWork_
	ldr r2, _02179590 // =0x000005E4
	mov r4, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r4
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl GameObject__InitFromObject
	ldrh r1, [r7, #4]
	add r0, r4, #0x500
	and r1, r1, #1
	strh r1, [r0, #0xcc]
	ldrb r0, [r7, #8]
	mov r0, r0, lsl #0x10
	str r0, [r4, #0x5c4]
	cmp r0, #0x200000
	movgt r0, #0x200000
	strgt r0, [r4, #0x5c4]
	bgt _02179100
	cmp r0, #0x40000
	movlt r0, #0x40000
	strlt r0, [r4, #0x5c4]
_02179100:
	add r0, r4, #0x500
	ldrh r2, [r0, #0xcc]
	ldr r1, _0217959C // =_021898E0
	ldr r0, [r4, #0x5c4]
	ldrsb r1, [r1, r2]
	mov r0, r0, asr #3
	mul r0, r1, r0
	str r0, [r4, #0x5c8]
	ldrh r0, [r7, #4]
	tst r0, #0x80
	ldrne r0, [r4, #0x5c8]
	rsbne r0, r0, #0
	strne r0, [r4, #0x5c8]
	mov r0, #0x400
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r4, #0x47c]
	ldr r1, [r4, #0x1c]
	ldr r0, _021795A0 // =_0218874C
	orr r1, r1, #0x2100
	str r1, [r4, #0x1c]
	ldrh r3, [r0]
	ldrh r2, [r0, #2]
	ldrh r1, [r0, #4]
	mov r0, #0x5f
	strh r3, [sp, #0x14]
	strh r2, [sp, #0x16]
	strh r1, [sp, #0x18]
	bl GetObjectFileWork
	ldr r2, _021795A4 // =gameArchiveStage
	ldr r1, _021795A8 // =aActAcGmkTrampo
	ldr r2, [r2]
	bl ObjDataLoad
	mov r8, r0
	mov r0, #0x61
	bl GetObjectFileWork
	mov r5, r0
	mov r0, r8
	mov r1, #0
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, r0
	mov r0, r5
	bl ObjActionAllocPalette
	mov r6, r0
	mov r0, #0x60
	bl GetObjectFileWork
	mov r5, r0
	mov r0, r8
	mov r1, #0
	bl Sprite__GetTextureSizeFromAnim
	mov r1, r0
	mov r0, r5
	bl ObjActionAllocTexture
	mov r1, #0
	str r1, [sp]
	stmib sp, {r0, r6}
	mov r2, r8
	add r0, r4, #0x364
	mov r3, r1
	bl AnimatorSprite3D__Init
	mov r1, #0
	add r0, r4, #0x364
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	add r0, r4, #0x500
	ldrh r0, [r0, #0xcc]
	cmp r0, #0
	moveq r5, #0
	beq _02179220
	ldrh r0, [r7, #4]
	tst r0, #0x80
	movne r5, #2
	moveq r5, #1
_02179220:
	ldr r1, [r4, #0x18]
	mov r0, #0x5f
	orr r1, r1, #0x400000
	str r1, [r4, #0x18]
	bl GetObjectFileWork
	ldr r1, _021795A4 // =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, _021795A8 // =aActAcGmkTrampo
	str r1, [sp]
	mov r6, #0
	mov r0, r4
	add r1, r4, #0x168
	str r6, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, r5, lsl #1
	add r0, r0, #0x62
	bl GetObjectFileWork
	mov r2, r0
	mov r3, r5, lsl #1
	add r1, sp, #0x14
	ldrh r1, [r1, r3]
	mov r0, r4
	bl ObjObjectActionAllocSprite
	bl GetCurrentZoneID
	add r5, r5, #1
	cmp r0, #5
	mov r1, r5, lsl #0x10
	bne _021792A8
	mov r0, r4
	mov r1, r1, lsr #0x10
	mov r2, #0x61
	bl ObjActionAllocSpritePalette
	b _021792B8
_021792A8:
	mov r0, r4
	mov r1, r1, lsr #0x10
	mov r2, #0x59
	bl ObjActionAllocSpritePalette
_021792B8:
	mov r0, r4
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r4
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r1, r5, lsl #0x10
	mov r0, r4
	mov r1, r1, lsr #0x10
	bl StageTask__SetAnimation
	ldr r1, [r4, #0x1a4]
	add r0, r4, #0x168
	orr r1, r1, #0x30
	str r1, [r4, #0x1a4]
	mov r1, #0
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	ldr r1, [r4, #0x1a4]
	add r0, r4, #0x68
	orr r1, r1, #8
	str r1, [r4, #0x1a4]
	ldr r1, [r4, #0x20]
	add r0, r0, #0x400
	orr r1, r1, #0x1000
	str r1, [r4, #0x20]
	ldr r1, [r4, #0x47c]
	mov r2, #0x400
	bl G3_BeginMakeDL
	mov r1, #0
	str r1, [sp]
	mov r0, #0x1f
	stmib sp, {r0, r1}
	add r0, r4, #0x68
	add r0, r0, #0x400
	mov r2, r1
	mov r3, #3
	bl G3C_PolygonAttr
	add r0, r4, #0x68
	ldr r3, [r4, #0x440]
	ldr r1, _021795AC // =0x0001FFFF
	add r0, r0, #0x400
	mov r2, #3
	and r1, r3, r1
	bl G3C_TexPlttBase
	mov r3, #0
	mov r2, #1
	str r3, [sp]
	stmib sp, {r2, r3}
	str r2, [sp, #0xc]
	ldr r1, [r4, #0x438]
	rsb r0, r2, #0x80000
	and r0, r1, r0
	str r0, [sp, #0x10]
	add r0, r4, #0x68
	add r0, r0, #0x400
	mov r1, #3
	bl G3C_TexImageParam
	add r0, r4, #0x68
	add r0, r0, #0x400
	mov r1, #3
	bl G3C_MtxMode
	add r0, sp, #0x1c
	bl MTX_Identity43_
	add r0, r4, #0x68
	add r0, r0, #0x400
	add r1, sp, #0x1c
	bl G3C_LoadMtx43
	add r0, r4, #0x68
	add r0, r0, #0x400
	mov r1, #1
	bl G3C_MtxMode
	add r0, r4, #0x1b8
	add r1, r4, #0x44
	add r3, r0, #0x400
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldrh r0, [r7, #2]
	cmp r0, #0xc8
	bne _02179414
	ldr r1, [r3]
	ldr r0, [r4, #0x5c4]
	sub r0, r1, r0
	str r0, [r3]
	ldr r1, [r4, #0x5bc]
	ldr r0, [r4, #0x5c8]
	sub r0, r1, r0
	str r0, [r4, #0x5bc]
_02179414:
	mov r3, #0
	str r3, [r4, #0x480]
	str r3, [r4, #0x484]
	str r3, [r4, #0x48c]
	sub r0, r3, #0x8000
	str r0, [r4, #0x490]
	ldr r0, [r4, #0x5c4]
	sub r1, r3, #0x8000
	str r0, [r4, #0x588]
	ldr r2, [r4, #0x5c8]
	mov r0, r4
	rsb r2, r2, #0
	str r2, [r4, #0x58c]
	str r3, [r4, #0x590]
	ldr r2, [r4, #0x5c4]
	str r2, [r4, #0x594]
	ldr r2, [r4, #0x5c8]
	sub r1, r1, r2
	str r1, [r4, #0x598]
	str r3, [r4, #0x59c]
	bl Trampoline3D__Func_217991C
	ldrh r2, [r7, #4]
	ldr r3, [r4, #0x5b8]
	ldr r0, [r4, #0x44]
	tst r2, #0x80
	sub r0, r3, r0
	mov r0, r0, lsl #4
	ldr r1, [r4, #0x5c4]
	mov r0, r0, asr #0x10
	add r1, r0, r1, asr #12
	mov r1, r1, lsl #0x10
	mov r1, r1, asr #0x10
	ldr r5, [r4, #0x5bc]
	ldr r2, [r4, #0x48]
	beq _021794C0
	sub r2, r5, r2
	mov r2, r2, lsl #4
	ldr r3, [r4, #0x5c8]
	mov r7, r2, asr #0x10
	add r2, r7, r3, asr #12
	mov r2, r2, lsl #0x10
	mov r5, r2, asr #0x10
	b _021794DC
_021794C0:
	sub r2, r5, r2
	mov r2, r2, lsl #4
	ldr r3, [r4, #0x5c8]
	mov r5, r2, asr #0x10
	add r2, r5, r3, asr #12
	mov r2, r2, lsl #0x10
	mov r7, r2, asr #0x10
_021794DC:
	add r6, r5, #0x18
	sub r5, r0, #0x10
	add r3, r1, #0x10
	sub r2, r7, #0x18
	mov r1, r5, lsl #0x10
	mov r0, r6, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r5, r0, asr #0x10
	str r4, [r4, #0x234]
	add r0, r4, #0x218
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, asr #0x10
	str r5, [sp]
	bl ObjRect__SetBox2D
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _021795B0 // =0x0000FFFE
	add r0, r4, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _021795B4 // =Trampoline3D__OnDefend
	str r0, [r4, #0x23c]
	ldr r0, [r4, #0x230]
	orr r0, r0, #0x80
	str r0, [r4, #0x230]
	ldr r0, [r4, #0x5c4]
	ldrsh r1, [r4, #0xc]
	mov r0, r0, asr #0xc
	add r0, r0, #0x56
	mov r0, r0, lsl #0x10
	cmp r1, r0, asr #16
	mov r0, r0, asr #0x10
	strlth r0, [r4, #0xc]
	ldr r0, _021795B8 // =Trampoline3D__Draw
	ldr r1, _021795BC // =Trampoline3D__State_2179664
	str r0, [r4, #0xfc]
	mov r0, r4
	str r1, [r4, #0xf4]
	add sp, sp, #0x4c
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0217958C: .word 0x000010F6
_02179590: .word 0x000005E4
_02179594: .word StageTask_Main
_02179598: .word Trampoline3D__Destructor
_0217959C: .word _021898E0
_021795A0: .word _0218874C
_021795A4: .word gameArchiveStage
_021795A8: .word aActAcGmkTrampo
_021795AC: .word 0x0001FFFF
_021795B0: .word 0x0000FFFE
_021795B4: .word Trampoline3D__OnDefend
_021795B8: .word Trampoline3D__Draw
_021795BC: .word Trampoline3D__State_2179664
	arm_func_end Trampoline3D__Create

	arm_func_start Trampoline3D__Destructor
Trampoline3D__Destructor: // 0x021795C0
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl GetTaskWork_
	mov r5, r0
	ldr r0, [r5, #0x340]
	ldrb r0, [r0, #9]
	bl Trampoline3D__Func_2179FF8
	ldr r0, [r5, #0x47c]
	bl _FreeHEAP_SYSTEM
	mov r0, #0x61
	bl GetObjectFileWork
	mov r5, r0
	ldrh r0, [r5, #4]
	sub r0, r0, #1
	strh r0, [r5, #4]
	ldrh r0, [r5, #4]
	cmp r0, #0
	bne _02179618
	ldr r0, [r5]
	bl VRAMSystem__FreePalette
	mov r0, #0
	str r0, [r5]
_02179618:
	mov r0, #0x60
	bl GetObjectFileWork
	mov r5, r0
	ldrh r0, [r5, #4]
	sub r0, r0, #1
	strh r0, [r5, #4]
	ldrh r0, [r5, #4]
	cmp r0, #0
	bne _0217964C
	ldr r0, [r5]
	bl VRAMSystem__FreeTexture
	mov r0, #0
	str r0, [r5]
_0217964C:
	mov r0, #0x5f
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Trampoline3D__Destructor

	arm_func_start Trampoline3D__State_2179664
Trampoline3D__State_2179664: // 0x02179664
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0xc
	mov r3, r0
	ldr r2, [r3, #0x35c]
	mov r0, #0
	cmp r2, #0
	beq _021796E8
	ldr r1, [r2, #0x6d8]
	cmp r1, r3
	moveq r0, r2
	beq _021796E8
	str r0, [r3, #0x35c]
	str r3, [r3, #0x234]
	ldr r1, [r3, #0x230]
	bic r1, r1, #0x800
	str r1, [r3, #0x230]
	ldr r1, [r3, #0x354]
	orr r1, r1, #1
	str r1, [r3, #0x354]
	ldr r4, [r3, #0x5bc]
	ldr r2, [r3, #0x4fc]
	ldr r1, [r3, #0x5e0]
	sub r2, r4, r2
	sub r2, r2, r1
	str r2, [r3, #0x5d0]
	ldr r1, [r3, #0x5c8]
	add r1, r2, r1, asr #1
	str r1, [r3, #0x5d4]
	str r0, [r3, #0x5dc]
	ldr r1, [r3, #0x5d0]
	mov r1, r1, asr #3
	rsb r1, r1, #0
	str r1, [r3, #0x5d8]
_021796E8:
	cmp r0, #0
	beq _02179840
	add r0, r0, #0x44
	add r4, sp, #0
	ldmia r0, {r0, r1, r2}
	stmia r4, {r0, r1, r2}
	ldr r0, [sp, #4]
	ldr r1, [sp]
	add r0, r0, #0xd000
	str r0, [sp, #4]
	ldr r0, [r3, #0x5b8]
	add r6, r3, #0x18
	sub r0, r1, r0
	sub r0, r0, #0x4000
	str r0, [r3, #0x4f8]
	ldr r0, [sp, #4]
	ldr r1, [r3, #0x5bc]
	mov r5, #1
	sub r1, r0, r1
	rsb r1, r1, #0
	str r1, [r3, #0x4fc]
	ldr r1, [r3, #0x4f8]
	str r1, [r3, #0x504]
	ldr r1, [r3, #0x4fc]
	sub r1, r1, #0x8000
	str r1, [r3, #0x508]
	ldr r2, [sp]
	ldr r1, [r3, #0x5b8]
	sub r1, r2, r1
	add r1, r1, #0x4000
	str r1, [r3, #0x510]
	ldr r1, [r3, #0x5bc]
	sub r0, r0, r1
	rsb r0, r0, #0
	str r0, [r3, #0x514]
	ldr r0, [r3, #0x510]
	str r0, [r3, #0x51c]
	ldr r0, [r3, #0x514]
	sub r0, r0, #0x8000
	str r0, [r3, #0x520]
	ldr r7, [r3, #0x510]
	ldr r4, [r3, #0x588]
	ldr sl, [r3, #0x4f8]
	ldr r2, [r3, #0x480]
	sub lr, r7, r4
	ldr sb, [r3, #0x4fc]
	ldr r8, [r3, #0x484]
	ldr r1, [r3, #0x514]
	ldr r0, [r3, #0x58c]
	mov r7, #0x18
	sub ip, sb, r8
	sub r2, sl, r2
	sub r4, r1, r0
	mov r8, r7
_021797C0:
	ldr r1, [r6, #0x468]
	rsb r0, r5, #0xc
	add r1, r1, r2, asr r5
	str r1, [r6, #0x480]
	ldr r1, [r6, #0x46c]
	rsb sb, r5, #0xb
	add r1, r1, ip, asr r5
	str r1, [r6, #0x484]
	ldr sl, [r6, #0x480]
	mla r1, r0, r7, r3
	str sl, [r6, #0x48c]
	ldr sl, [r6, #0x484]
	mla r0, sb, r8, r3
	sub sb, sl, #0x8000
	str sb, [r6, #0x490]
	ldr sb, [r1, #0x480]
	add r6, r6, #0x18
	add sb, sb, lr, asr r5
	str sb, [r0, #0x480]
	ldr r1, [r1, #0x484]
	add r1, r1, r4, asr r5
	str r1, [r0, #0x484]
	ldr r1, [r0, #0x480]
	add r5, r5, #1
	str r1, [r0, #0x48c]
	ldr r1, [r0, #0x484]
	cmp r5, #5
	sub r1, r1, #0x8000
	str r1, [r0, #0x490]
	blt _021797C0
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
_02179840:
	ldr r0, [r3, #0x354]
	tst r0, #1
	addeq sp, sp, #0xc
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	ldr r2, [r3, #0x5dc]
	ldr r1, [r3, #0x5d8]
	mov r0, #1
	add r2, r2, r1
	str r2, [r3, #0x5dc]
	ldr r1, [r3, #0x5d4]
	add r1, r1, r2
	str r1, [r3, #0x5d4]
	ldr r5, [r3, #0x5d8]
	cmp r5, #0
	bge _021798D0
	ldr r2, [r3, #0x5d4]
	ldr r1, [r3, #0x5c8]
	cmp r2, r1, asr #1
	bgt _021798F8
	rsb r1, r5, #0
	movs r1, r1, asr #1
	str r1, [r3, #0x5d8]
	rsbmi r1, r1, #0
	cmp r1, #0x800
	bgt _021798B8
	ldr r1, [r3, #0x354]
	mov r0, #0
	bic r1, r1, #1
	str r1, [r3, #0x354]
	b _021798F8
_021798B8:
	mov r1, #0
	str r1, [r3, #0x5dc]
	ldr r1, [r3, #0x5d0]
	mov r1, r1, asr #1
	str r1, [r3, #0x5d0]
	b _021798F8
_021798D0:
	ldr r2, [r3, #0x5c8]
	ldr r1, [r3, #0x5d0]
	ldr r4, [r3, #0x5d4]
	add r1, r1, r2, asr #1
	cmp r4, r1
	blt _021798F8
	rsb r1, r5, #0
	str r1, [r3, #0x5d8]
	mov r1, #0
	str r1, [r3, #0x5dc]
_021798F8:
	cmp r0, #0
	mov r0, r3
	beq _02179910
	bl Trampoline3D__Func_2179998
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
_02179910:
	bl Trampoline3D__Func_217991C
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	arm_func_end Trampoline3D__State_2179664

	arm_func_start Trampoline3D__Func_217991C
Trampoline3D__Func_217991C: // 0x0217991C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, [r5, #0x5c4]
	mov r1, #0xb
	bl FX_DivS32
	ldr r1, [r5, #0x5c8]
	mov r4, r0
	rsb r0, r1, #0
	mov r1, #0xb
	bl FX_DivS32
	add r1, r5, #0x98
	add ip, r5, #0x480
	add r3, r1, #0x400
	mov r2, #1
_02179954:
	ldr r1, [ip]
	add r2, r2, #1
	add r1, r1, r4
	str r1, [r3]
	ldr r1, [ip, #4]
	mov ip, r3
	add r1, r1, r0
	str r1, [r3, #4]
	ldr r1, [r3]
	cmp r2, #0xb
	str r1, [r3, #0xc]
	ldr r1, [r3, #4]
	sub r1, r1, #0x8000
	str r1, [r3, #0x10]
	add r3, r3, #0x18
	blt _02179954
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end Trampoline3D__Func_217991C

	arm_func_start Trampoline3D__Func_2179998
Trampoline3D__Func_2179998: // 0x02179998
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	ldr r2, [r0, #0x5c8]
	ldr r1, [r0, #0x5d4]
	rsb r2, r2, #0
	ldr r3, [r0, #0x5c4]
	add r1, r1, r2, asr #1
	mov r5, r2, asr #1
	mov r7, r3, asr #1
	rsb r4, r1, #0
	mov r3, r4, asr #1
	mov r6, r0
	mov r1, r7, asr #1
	sub ip, r7, r7, asr #1
	mov r2, r5, asr #1
	sub lr, r5, r5, asr #1
	sub r4, r4, r4, asr #1
	mov r5, #0
	mov r7, #0x18
_021799E0:
	ldr r8, [r6, #0x480]
	rsb sb, r5, #0xb
	add r8, r1, r8
	str r8, [r6, #0x498]
	ldr sl, [r6, #0x484]
	rsb r8, r5, #0xa
	add sl, r2, sl
	add sl, r3, sl
	str sl, [r6, #0x49c]
	mov sl, #0x18
	mla sl, sb, sl, r0
	ldr fp, [r6, #0x498]
	mla sb, r8, r7, r0
	str fp, [r6, #0x4a4]
	ldr fp, [r6, #0x49c]
	add r5, r5, #1
	sub r8, fp, #0x8000
	str r8, [r6, #0x4a8]
	ldr r8, [sl, #0x480]
	add r6, r6, #0x18
	sub r1, r8, r1
	str r1, [sb, #0x480]
	ldr r8, [sl, #0x484]
	mov r1, ip, asr #1
	sub r2, r8, r2
	add r2, r3, r2
	str r2, [sb, #0x484]
	ldr r3, [sb, #0x480]
	mov r2, lr, asr #1
	str r3, [sb, #0x48c]
	ldr r8, [sb, #0x484]
	mov r3, r4, asr #1
	sub r8, r8, #0x8000
	str r8, [sb, #0x490]
	sub ip, ip, ip, asr #1
	sub lr, lr, lr, asr #1
	sub r4, r4, r4, asr #1
	cmp r5, #5
	blt _021799E0
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end Trampoline3D__Func_2179998

	arm_func_start Trampoline3D__Draw
Trampoline3D__Draw: // 0x02179A80
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0xac
	bl GetCurrentTaskWork_
	mov r3, #0x1000
	ldr r1, _02179D48 // =g_obj
	mov r6, r0
	ldr r2, [r1]
	str r3, [sp, #0x4c]
	str r3, [sp, #0x50]
	str r3, [sp, #0x54]
	cmp r2, #0x1000
	beq _02179AC8
	smull r1, r0, r2, r3
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x4c]
_02179AC8:
	ldr r0, _02179D48 // =g_obj
	ldr r2, [r0, #4]
	cmp r2, #0x1000
	beq _02179AF4
	ldr r0, [sp, #0x50]
	smull r1, r0, r2, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x50]
_02179AF4:
	ldr r2, [sp, #0x4c]
	ldr r1, [sp, #0x50]
	mov r3, r2, lsl #7
	mov r2, r1, lsl #7
	ldr r0, [sp, #0x54]
	str r3, [sp, #0x4c]
	mov r1, r0, lsl #7
	add r0, sp, #0x1c
	str r2, [sp, #0x50]
	str r1, [sp, #0x54]
	bl MTX_Identity33_
	add r0, r6, #0x1b8
	add r1, sp, #0x40
	add r2, sp, #0x58
	add r0, r0, #0x400
	mov r3, #0
	bl GameObject__Func_20282A8
	add r0, sp, #0x4c
	bl NNS_G3dGlbSetBaseScale
	ldr r1, _02179D4C // =0x021472FC
	add r0, sp, #0x1c
	bl MI_Copy36B
	ldr r1, _02179D50 // =NNS_G3dGlb
	add r0, sp, #0x40
	ldr r2, [r1, #0xfc]
	bic r2, r2, #0xa4
	str r2, [r1, #0xfc]
	bl NNS_G3dGlbSetBaseTrans
	mov r2, #1
	mov r0, #0x10
	add r1, sp, #0xc
	str r2, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
	bl NNS_G3dGlbFlushP
	add r0, r6, #0x68
	add r7, r0, #0x400
	add r5, sp, #0x98
	ldmia r7!, {r0, r1, r2, r3}
	mov r4, r5
	stmia r5!, {r0, r1, r2, r3}
	ldr r1, [r7]
	mov r0, r4
	str r1, [r5]
	mov r1, #3
	bl G3C_Begin
	ldr r1, _02179D54 // =0x00007FFF
	mov r0, r4
	mov r8, #0
	bl G3C_Color
	mov r5, r4
	ldr sb, [r6, #0x480]
	add sl, r6, #0x480
	mov r7, r8
	mov r4, r8
	mov fp, #0x8000
_02179BD0:
	ldr r3, [sl]
	mov r0, r5
	sub r1, r3, sb
	add r8, r8, r1
	mov r1, r8
	mov r2, r4
	mov sb, r3
	bl G3C_TexCoord
	ldmia sl, {r1, r2, r3}
	mov r1, r1, lsl #9
	mov r2, r2, lsl #9
	mov r3, r3, lsl #9
	mov r0, r5
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, asr #0x10
	bl G3C_Vtx
	mov r0, r5
	mov r1, r8
	mov r2, fp
	bl G3C_TexCoord
	ldr r1, [sl, #0xc]
	ldr r2, [sl, #0x10]
	ldr r3, [sl, #0x14]
	mov r1, r1, lsl #9
	mov r2, r2, lsl #9
	mov r3, r3, lsl #9
	mov r0, r5
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, asr #0x10
	bl G3C_Vtx
	add r7, r7, #1
	add sl, sl, #0x18
	cmp r7, #0xc
	blt _02179BD0
	add r0, sp, #0x98
	bl G3C_End
	add r0, sp, #0x98
	bl G3_EndMakeDL
	ldr r0, [r6, #0x47c]
	mov r1, #0x400
	bl DC_FlushRange
	ldr r1, [sp, #0x98]
	tst r1, #3
	ldrne r0, [sp, #0xa0]
	ldrne r1, [sp, #0x9c]
	ldreq r0, [sp, #0xa0]
	sub r1, r1, r0
	ldr r0, [r6, #0x47c]
	bl NNS_G3dGeSendDL
	add r0, r6, #0x1b8
	add r0, r0, #0x400
	add r3, sp, #0x10
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r6, #0x500
	ldr r1, [r6, #0x340]
	ldrh r3, [r0, #0xcc]
	ldrh r0, [r1, #4]
	ldr r2, _02179D58 // =_021898E0
	mov r8, #0
	ldrsb r1, [r2, r3]
	tst r0, #0x80
	ldr r0, [r6, #0x5c4]
	mov sb, r1, lsl #0xd
	mov r0, r0, asr #0x10
	rsbne sb, sb, #0
	cmp r0, #0
	addle sp, sp, #0xac
	ldmleia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	add r7, r6, #0x20
	mov r5, r8
	add r4, sp, #0x10
_02179CF8:
	str r7, [sp]
	str r5, [sp, #4]
	mov r1, r4
	mov r2, r5
	mov r3, r5
	str r5, [sp, #8]
	add r0, r6, #0x168
	bl StageTask__Draw2DEx
	ldr r1, [sp, #0x10]
	ldr r0, [sp, #0x14]
	add r1, r1, #0x10000
	add r0, r0, sb
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	ldr r0, [r6, #0x5c4]
	add r8, r8, #1
	cmp r8, r0, asr #16
	blt _02179CF8
	add sp, sp, #0xac
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02179D48: .word g_obj
_02179D4C: .word 0x021472FC
_02179D50: .word NNS_G3dGlb
_02179D54: .word 0x00007FFF
_02179D58: .word _021898E0
	arm_func_end Trampoline3D__Draw

	arm_func_start Trampoline3D__OnDefend
Trampoline3D__OnDefend: // 0x02179D5C
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x24
	ldr r5, [r1, #0x1c]
	ldr r4, [r0, #0x1c]
	cmp r5, #0
	cmpne r4, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldrh r2, [r4]
	cmp r2, #1
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r2, [r4, #0x1c]
	tst r2, #0x10
	beq _02179DB0
	ldr r2, [r4, #0x9c]
	cmp r2, #0
	blt _02179DB0
	ldr r2, [r4, #0x6d8]
	cmp r2, #0
	beq _02179DBC
_02179DB0:
	bl ObjRect__FuncNoHit
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_02179DBC:
	add r2, r5, #0x500
	ldrh r8, [r2, #0xcc]
	ldr r2, [r4, #0x44]
	ldr r6, [r4, #0x8c]
	str r2, [sp]
	ldr r3, [sp]
	ldr r2, [r4, #0x48]
	ldr r7, [r4, #0x90]
	sub r6, r6, r3
	mov r3, #0
	cmp r8, #0
	sub r7, r7, r2
	str r3, [sp, #4]
	beq _02179E24
	cmp r8, #1
	bne _02179E2C
	ldr r3, [r5, #0x340]
	ldrh r3, [r3, #4]
	ands r3, r3, #0x80
	beq _02179E14
	cmp r6, #0
	bge _02179E24
_02179E14:
	cmp r3, #0
	bne _02179E2C
	cmp r6, #0
	bgt _02179E2C
_02179E24:
	mov r6, r6, lsl #4
	mov r7, r7, lsl #4
_02179E2C:
	ldr r3, [r5, #0x5c8]
	ldr r8, [r5, #0x5c4]
	rsb ip, r3, #0
	smull r3, sb, r6, ip
	adds sl, r3, #0x800
	rsb lr, r8, #0
	smull r8, r3, r7, lr
	adc sb, sb, #0
	adds r8, r8, #0x800
	mov sl, sl, lsr #0xc
	adc r3, r3, #0
	mov r8, r8, lsr #0xc
	orr r8, r8, r3, lsl #20
	mov r3, lr, asr #0x1f
	str r3, [sp, #8]
	mov r3, r7, asr #0x1f
	str r3, [sp, #0xc]
	mov r3, ip, asr #0x1f
	orr sl, sl, sb, lsl #20
	str r3, [sp, #0x1c]
	mov r3, r6, asr #0x1f
	subs r8, sl, r8
	str r3, [sp, #0x10]
	beq _02179F84
	ldr r3, [r5, #0x5bc]
	add r2, r2, #0xc000
	sub r3, r3, r2
	ldr sb, [r5, #0x5b8]
	ldr r2, [sp]
	mov fp, r3, asr #0x1f
	sub r2, sb, r2
	str r2, [sp, #0x14]
	mov r2, r2, asr #0x1f
	ldr sb, [sp, #0x14]
	str r2, [sp, #0x20]
	umull sl, r2, sb, ip
	str sl, [sp, #0x18]
	mov sl, sb
	ldr sb, [sp, #0x1c]
	mla r2, sl, sb, r2
	ldr sb, [sp, #0x20]
	ldr sl, [sp, #0x18]
	mla r2, sb, ip, r2
	adds sb, sl, #0x800
	mov sl, sb, lsr #0xc
	adc r2, r2, #0
	orr sl, sl, r2, lsl #20
	ldr r2, [sp, #8]
	umull ip, sb, r3, lr
	mla sb, r3, r2, sb
	adds r2, ip, #0x800
	mla sb, fp, lr, sb
	adc sb, sb, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, sb, lsl #20
	sub r2, sl, r2
	ldr ip, [sp, #0x10]
	umull sl, sb, r3, r6
	mla sb, r3, ip, sb
	mla sb, fp, r6, sb
	adds r6, sl, #0x800
	ldr sl, [sp, #0x14]
	adc r3, sb, #0
	mov sb, r6, lsr #0xc
	orr sb, sb, r3, lsl #20
	umull r6, r3, sl, r7
	mov fp, sl
	ldr sl, [sp, #0xc]
	mla r3, fp, sl, r3
	ldr sl, [sp, #0x20]
	mla r3, sl, r7, r3
	adds r7, r6, #0x800
	adc r3, r3, #0
	cmp r8, #0
	mov r6, r7, lsr #0xc
	orr r6, r6, r3, lsl #20
	sub r3, sb, r6
	rsblt r8, r8, #0
	rsblt r2, r2, #0
	rsblt r3, r3, #0
	cmp r2, #0
	cmpge r8, r2
	cmpge r3, #0
	cmpge r8, r3
	movge r2, #1
	strge r2, [sp, #4]
_02179F84:
	ldr r2, [sp, #4]
	cmp r2, #0
	beq _02179FC4
	mov r0, r4
	mov r1, r5
	str r4, [r5, #0x35c]
	bl Player__Gimmick_2021E9C
	mov r0, #0
	str r0, [r5, #0x234]
	ldr r0, [r5, #0x230]
	add sp, sp, #0x24
	orr r0, r0, #0x800
	str r0, [r5, #0x230]
	ldr r0, [r4, #0x48]
	str r0, [r5, #0x5e0]
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_02179FC4:
	bl ObjRect__FuncNoHit
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end Trampoline3D__OnDefend

	arm_func_start Trampoline3D__Func_2179FD0
Trampoline3D__Func_2179FD0: // 0x02179FD0
	ldr r1, _02179FF4 // =_0218A390
	mov r3, #1
	ldr r2, [r1]
	tst r2, r3, lsl r0
	movne r0, #0
	orreq r2, r2, r3, lsl r0
	moveq r0, r3
	streq r2, [r1]
	bx lr
	.align 2, 0
_02179FF4: .word _0218A390
	arm_func_end Trampoline3D__Func_2179FD0

	arm_func_start Trampoline3D__Func_2179FF8
Trampoline3D__Func_2179FF8: // 0x02179FF8
	ldr r1, _0217A014 // =_0218A390
	mov r2, #1
	mvn r0, r2, lsl r0
	ldr r2, [r1]
	and r0, r2, r0
	str r0, [r1]
	bx lr
	.align 2, 0
_0217A014: .word _0218A390
	arm_func_end Trampoline3D__Func_2179FF8

	.rodata

_0218874C: // 0x0218874C
    .hword 1, 2, 2
	.align 4

	.data
	
_021898E0:
	.byte 0x00, 0xFE, 0x00, 0x00

aActAcGmkTrampo: // 0x021898E4
	.asciz "/act/ac_gmk_trampoline3d.bac"
	.align 4