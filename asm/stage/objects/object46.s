	.include "asm/macros.inc"
	.include "global.inc"
	
	.text

	arm_func_start Object46__Create
Object46__Create: // 0x02169B00
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x44
	ldr r3, _02169F34 // =0x000010F6
	mov sl, r0
	str r3, [sp]
	mov r0, #2
	mov r5, r1
	mov r4, r2
	mov r2, #0
	str r0, [sp, #4]
	ldr r6, _02169F38 // =0x00000714
	ldr r0, _02169F3C // =StageTask_Main
	ldr r1, _02169F40 // =DiveStand__Destructor
	mov r3, r2
	str r6, [sp, #8]
	bl TaskCreate_
	mov r6, r0
	mov r0, #0
	bl OS_GetArenaLo
	cmp r6, r0
	addeq sp, sp, #0x44
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, r6
	bl GetTaskWork_
	ldr r2, _02169F38 // =0x00000714
	mov r6, r0
	mov r1, #0
	bl MI_CpuFill8
	mov r0, r6
	mov r1, sl
	mov r2, r5
	mov r3, r4
	bl GameObject__InitFromObject
	mov r0, #0x400
	bl _AllocHeadHEAP_SYSTEM
	str r0, [r6, #0x480]
	mov r0, #0x1000
	str r0, [r6, #0x70c]
	ldr r0, [r6, #0x1c]
	add r8, r6, #0x368
	orr r0, r0, #0x2100
	str r0, [r6, #0x1c]
	mov r0, #0xa8
	bl GetObjectFileWork
	ldr r2, _02169F44 // =gameArchiveStage
	ldr r1, _02169F48 // =aActAcGmkDiveSt
	ldr r2, [r2]
	bl ObjDataLoad
	str r0, [r6, #0x364]
	mov r0, #0xac
	bl GetObjectFileWork
	mov r4, r0
	ldr r0, [r6, #0x364]
	mov r1, #0
	bl Sprite__GetPaletteSizeFromAnim
	mov r1, r0
	mov r0, r4
	bl ObjActionAllocPalette
	mov r7, #0
	mov sb, r0
	mov r4, r7
	mov fp, r7
	b _02169C60
_02169C00:
	add r0, r7, #0xa9
	bl GetObjectFileWork
	mov r5, r0
	mov r1, r7, lsl #0x10
	ldr r0, [r6, #0x364]
	mov r1, r1, lsr #0x10
	bl Sprite__GetTextureSizeFromAnim
	mov r1, r0
	mov r0, r5
	bl ObjActionAllocTexture
	str r4, [sp]
	stmib sp, {r0, sb}
	mov r3, r7, lsl #0x10
	ldr r2, [r6, #0x364]
	mov r0, r8
	mov r1, r4
	mov r3, r3, lsr #0x10
	bl AnimatorSprite3D__Init
	mov r0, r8
	mov r1, fp
	mov r2, fp
	bl AnimatorSprite3D__ProcessAnimation
	add r7, r7, #1
	add r8, r8, #0x104
_02169C60:
	cmp r7, #1
	blt _02169C00
	ldr r1, [r6, #0x18]
	mov r0, #0xa8
	orr r1, r1, #0x400000
	str r1, [r6, #0x18]
	bl GetObjectFileWork
	ldr r1, _02169F44 // =gameArchiveStage
	mov r3, r0
	ldr r1, [r1]
	ldr r2, _02169F48 // =aActAcGmkDiveSt
	str r1, [sp]
	mov r4, #0
	mov r0, r6
	add r1, r6, #0x168
	str r4, [sp, #4]
	bl ObjObjectAction2dBACLoad
	mov r0, #0xad
	bl GetObjectFileWork
	mov r2, r0
	mov r0, r6
	mov r1, #1
	bl ObjObjectActionAllocSprite
	mov r0, r6
	mov r1, #1
	mov r2, #0x3c
	bl ObjActionAllocSpritePalette
	mov r0, r6
	mov r1, #0x17
	bl StageTask__SetAnimatorOAMOrder
	mov r0, r6
	mov r1, #2
	bl StageTask__SetAnimatorPriority
	mov r0, r6
	mov r1, #1
	bl StageTask__SetAnimation
	ldr r1, [r6, #0x1a4]
	add r0, r6, #0x168
	orr r1, r1, #0x30
	str r1, [r6, #0x1a4]
	mov r1, r4
	mov r2, r1
	bl AnimatorSpriteDS__ProcessAnimation
	ldr r1, [r6, #0x1a4]
	add r0, r6, #0x6c
	orr r1, r1, #8
	str r1, [r6, #0x1a4]
	ldr r1, [r6, #0x20]
	add r0, r0, #0x400
	orr r1, r1, #0x1000
	str r1, [r6, #0x20]
	ldr r1, [r6, #0x480]
	mov r2, #0x400
	bl G3_BeginMakeDL
	mov r1, r4
	str r1, [sp]
	mov r0, #0x1f
	stmib sp, {r0, r1}
	add r0, r6, #0x6c
	add r0, r0, #0x400
	mov r2, r1
	mov r3, #3
	bl G3C_PolygonAttr
	ldr r1, [r6, #0x444]
	ldr r0, _02169F4C // =0x0001FFFF
	add r2, r6, #0x6c
	and r1, r1, r0
	add r0, r2, #0x400
	mov r2, #3
	bl G3C_TexPlttBase
	ldr r4, [r6, #0x43c]
	mov r3, #0
	str r3, [sp]
	mov r2, #1
	ldr r0, _02169F50 // =0x0007FFFF
	stmib sp, {r2, r3}
	add r1, r6, #0x6c
	and r4, r4, r0
	str r2, [sp, #0xc]
	add r0, r1, #0x400
	mov r1, #3
	str r4, [sp, #0x10]
	bl G3C_TexImageParam
	add r0, r6, #0x6c
	add r0, r0, #0x400
	mov r1, #3
	bl G3C_MtxMode
	add r0, sp, #0x14
	bl MTX_Identity43_
	add r0, r6, #0x6c
	add r1, sp, #0x14
	add r0, r0, #0x400
	bl G3C_LoadMtx43
	add r0, r6, #0x6c
	add r0, r0, #0x400
	mov r1, #1
	bl G3C_MtxMode
	str r6, [r6, #0x234]
	ldrh r0, [sl, #2]
	mov r4, #0xc0
	cmp r0, #0x8f
	bne _02169E14
	sub r1, r4, #0xd0
	mov r2, r1
	add r0, r6, #0x218
	mov r3, #0xd0
	str r4, [sp]
	bl ObjRect__SetBox2D
	b _02169E2C
_02169E14:
	mov r1, #0x10
	add r0, r6, #0x218
	sub r2, r1, #0x20
	sub r3, r1, #0xe0
	str r4, [sp]
	bl ObjRect__SetBox2D
_02169E2C:
	mov r1, #0
	mov r2, r1
	add r0, r6, #0x218
	bl ObjRect__SetAttackStat
	ldr r1, _02169F54 // =0x0000FFFE
	add r0, r6, #0x218
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r1, _02169F58 // =ovl00_216AB68
	mov r2, #0x10
	str r1, [r6, #0x23c]
	str r6, [r6, #0x274]
	add r0, r6, #0x258
	str r2, [sp]
	sub r1, r2, #0x18
	sub r2, r2, #0x20
	mov r3, #8
	bl ObjRect__SetBox2D
	ldr r1, [r6, #0x44]
	add r0, r6, #0x258
	mov r1, r1, asr #0xc
	str r1, [r6, #0x264]
	ldr r2, [r6, #0x48]
	mov r1, #0
	mov r2, r2, asr #0xc
	str r2, [r6, #0x268]
	ldr r3, [r6, #0x4c]
	mov r2, r1
	mov r3, r3, asr #0xc
	str r3, [r6, #0x26c]
	bl ObjRect__SetAttackStat
	ldr r1, _02169F54 // =0x0000FFFE
	add r0, r6, #0x258
	mov r2, #0
	bl ObjRect__SetDefenceStat
	ldr r0, _02169F5C // =ovl00_216AC14
	mov r2, #0
	str r0, [r6, #0x27c]
	ldr r1, [r6, #0x270]
	ldr r0, _02169F60 // =StageTask__DefaultDiffData
	orr r1, r1, #0x1400
	str r1, [r6, #0x270]
	str r2, [r6, #0x13c]
	str r0, [r6, #0x2fc]
	mov r1, #0xc0
	add r0, r6, #0x300
	strh r1, [r0, #8]
	mov r1, #0x10
	strh r1, [r0, #0xa]
	ldrh r0, [sl, #2]
	cmp r0, #0x8f
	addeq r0, r6, #0x200
	streqh r2, [r0, #0xf0]
	subne r1, r1, #0xd0
	addne r0, r6, #0x200
	strneh r1, [r0, #0xf0]
	add r0, r6, #0x200
	mov r1, #0
	strh r1, [r0, #0xf2]
	ldr r2, _02169F64 // =ovl00_216A894
	ldr r1, _02169F68 // =ovl00_216A020
	str r2, [r6, #0xfc]
	mov r0, r6
	str r1, [r6, #0xf4]
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_02169F34: .word 0x000010F6
_02169F38: .word 0x00000714
_02169F3C: .word StageTask_Main
_02169F40: .word DiveStand__Destructor
_02169F44: .word gameArchiveStage
_02169F48: .word aActAcGmkDiveSt
_02169F4C: .word 0x0001FFFF
_02169F50: .word 0x0007FFFF
_02169F54: .word 0x0000FFFE
_02169F58: .word ovl00_216AB68
_02169F5C: .word ovl00_216AC14
_02169F60: .word StageTask__DefaultDiffData
_02169F64: .word ovl00_216A894
_02169F68: .word ovl00_216A020
	arm_func_end Object46__Create

	arm_func_start DiveStand__Func_2169F6C
DiveStand__Func_2169F6C: // 0x02169F6C
	ldr r1, [r0, #0x354]
	bic r1, r1, #5
	str r1, [r0, #0x354]
	bx lr
	arm_func_end DiveStand__Func_2169F6C

	arm_func_start DiveStand__Destructor
DiveStand__Destructor: // 0x02169F7C
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	bl GetTaskWork_
	ldr r0, [r0, #0x480]
	bl _FreeHEAP_SYSTEM
	mov r0, #0xac
	bl GetObjectFileWork
	mov r5, r0
	ldrh r0, [r5, #4]
	sub r0, r0, #1
	strh r0, [r5, #4]
	ldrh r0, [r5, #4]
	cmp r0, #0
	bne _02169FC4
	ldr r0, [r5]
	bl VRAMSystem__FreePalette
	mov r0, #0
	str r0, [r5]
_02169FC4:
	mov r7, #0
	mov r5, r7
_02169FCC:
	add r0, r7, #0xa9
	bl GetObjectFileWork
	mov r6, r0
	ldrh r0, [r6, #4]
	sub r0, r0, #1
	strh r0, [r6, #4]
	ldrh r0, [r6, #4]
	cmp r0, #0
	bne _02169FFC
	ldr r0, [r6]
	bl VRAMSystem__FreeTexture
	str r5, [r6]
_02169FFC:
	add r7, r7, #1
	cmp r7, #2
	blt _02169FCC
	mov r0, #0xa8
	bl GetObjectFileWork
	bl ObjDataRelease
	mov r0, r4
	bl GameObject__Destructor
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end DiveStand__Destructor

	arm_func_start ovl00_216A020
ovl00_216A020: // 0x0216A020
	stmdb sp!, {r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x114
	ldr r1, _0216A880 // =gPlayer
	mov r8, r0
	ldr r1, [r1]
	ldr r2, [r8, #0x354]
	str r1, [sp, #8]
	ldr r3, [r1, #0x44]
	ldr r1, [r8, #0x44]
	tst r2, #1
	sub r5, r3, r1
	beq _0216A1B0
	ldr r1, [sp, #8]
	ldr r1, [r1, #0x6d8]
	cmp r1, r8
	bne _0216A1A8
	tst r2, #4
	ldrne r3, _0216A884 // =0x0000FD60
	mvnne r4, #0xf
	add r0, r8, #0x2b8
	add r1, r8, #0x308
	add r2, r0, #0x400
	ldreq r3, _0216A888 // =0x0000FEAB
	mvneq r4, #0x7f
	add r1, r1, #0x400
	mov r0, #0x16
	mov r7, #0
_0216A08C:
	ldr r6, [r8, #0x340]
	ldrh sb, [r6, #2]
	cmp sb, #0x8f
	bne _0216A0A8
	ldr r6, [r2]
	cmp r5, r6, lsl #3
	ble _0216A0BC
_0216A0A8:
	cmp sb, #0x95
	bne _0216A0D8
	ldr r6, [r2]
	cmp r5, r6, lsl #3
	blt _0216A0D8
_0216A0BC:
	ldrh r6, [r1]
	add r6, r6, #0x10
	strh r6, [r1]
	ldrsh r6, [r1]
	cmp r6, #0
	strgth r7, [r1]
	b _0216A108
_0216A0D8:
	ldrh r6, [r1]
	cmp r6, #0
	beq _0216A0FC
	add r6, r6, r4
	strh r6, [r1]
	ldrh r6, [r1]
	cmp r6, r3
	strloh r3, [r1]
	b _0216A108
_0216A0FC:
	add r0, r6, r4
	strh r0, [r1]
	b _0216A118
_0216A108:
	sub r2, r2, #0x18
	sub r1, r1, #2
	subs r0, r0, #1
	bpl _0216A08C
_0216A118:
	ldr r3, [r8, #0x354]
	tst r3, #4
	beq _0216A184
	add r1, r8, #0x700
	ldrh r0, [r1, #8]
	ldr r2, _0216A884 // =0x0000FD60
	cmp r0, r2
	addeq r0, r8, #0x600
	ldreqh r0, [r0, #0xdc]
	cmpeq r0, r2
	bne _0216A168
	ldr r0, [r8, #0x70c]
	cmp r0, #0x1800
	blt _0216A168
	bic r0, r3, #5
	orr r0, r0, #8
	str r0, [r8, #0x354]
	mov r0, #0x10
	strh r0, [r1, #0x10]
	b _0216A2BC
_0216A168:
	ldr r0, [r8, #0x70c]
	add r0, r0, #0x40
	str r0, [r8, #0x70c]
	cmp r0, #0x1800
	movgt r0, #0x1800
	strgt r0, [r8, #0x70c]
	b _0216A2BC
_0216A184:
	ldr r0, [r8, #0x70c]
	cmp r0, #0x1000
	ble _0216A2BC
	sub r0, r0, #0x40
	str r0, [r8, #0x70c]
	cmp r0, #0x1000
	movlt r0, #0x1000
	strlt r0, [r8, #0x70c]
	b _0216A2BC
_0216A1A8:
	bl DiveStand__Func_2169F6C
	b _0216A2BC
_0216A1B0:
	tst r2, #2
	beq _0216A29C
	ldr r2, [r8, #0x70c]
	mov r0, #0
	cmp r2, #0x1000
	sub r1, r0, #0x10
	ble _0216A1E0
	sub r2, r2, #0x40
	str r2, [r8, #0x70c]
	cmp r2, #0x1000
	movlt r2, #0x1000
	strlt r2, [r8, #0x70c]
_0216A1E0:
	ldr r2, [r8, #0x354]
	mov r7, #0
	tst r2, #8
	movne r1, r1, lsl #0x12
	add r2, r8, #0x2dc
	add r6, r2, #0x400
	movne r1, r1, asr #0x10
	mov r2, r7
	mov r4, #1
_0216A204:
	ldrh r3, [r6]
	cmp r3, #0
	beq _0216A228
	sub r0, r3, r1
	strh r0, [r6]
	ldrsh r3, [r6]
	mov r0, r4
	cmp r3, #0
	strgth r2, [r6]
_0216A228:
	add r7, r7, #1
	cmp r7, #0x17
	add r6, r6, #2
	blt _0216A204
	cmp r0, #0
	bne _0216A2BC
	ldr r0, [r8, #0x354]
	bic r0, r0, #2
	str r0, [r8, #0x354]
	tst r0, #8
	beq _0216A2BC
	ldr r0, [r8, #0x340]
	ldrsb r4, [r0, #6]
	ldrh r0, [r0, #2]
	mov r1, r4, lsl #0xb
	cmp r0, #0x95
	mov r0, #0x1800
	rsb r0, r0, #0
	mul r3, r4, r0
	add r2, r1, #0x2000
	ldr r0, [sp, #8]
	rsbeq r2, r2, #0
	mov r1, r8
	sub r3, r3, #0x7800
	bl Player__Func_2020420
	ldr r0, [sp, #8]
	mov r1, r8
	bl Player__Action_AllowTrickCombos
	b _0216A2BC
_0216A29C:
	ldr r0, [r8, #0x70c]
	cmp r0, #0x1000
	ble _0216A2BC
	sub r0, r0, #0x40
	str r0, [r8, #0x70c]
	cmp r0, #0x1000
	movlt r0, #0x1000
	strlt r0, [r8, #0x70c]
_0216A2BC:
	ldr r0, _0216A88C // =_02188580
	mov r4, #0
	add r6, sp, #0xfc
	add r3, sp, #0xf0
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	str r4, [r6]
	str r4, [r6, #4]
	str r4, [r6, #8]
	str r4, [sp, #0x10c]
	str r4, [sp, #0x110]
	ldr r0, [r8, #0x340]
	add r1, sp, #0xfc
	ldrh r0, [r0, #2]
	cmp r0, #0x8f
	ldr r0, [r8, #0x70c]
	streq r0, [sp, #0xc]
	streq r0, [sp, #0x108]
	rsbne r0, r0, #0
	strne r0, [sp, #0xc]
	strne r0, [sp, #0x108]
	add r0, r8, #0x84
	add r3, r0, #0x400
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, sp, #0xf0
	add r3, r8, #0x490
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, sp, #0x84
	bl MTX_Identity43_
	add r0, sp, #0x84
	add r1, sp, #0xb4
	mov r2, #0x30
	bl MIi_CpuCopy32
	add r0, sp, #0x84
	add r1, sp, #0x24
	mov r2, #0x30
	bl MIi_CpuCopy32
	ldr r1, [sp, #0x110]
	add r0, sp, #0x24
	str r1, [sp]
	ldr r2, [sp, #0x108]
	ldr r3, [sp, #0x10c]
	mov r1, r0
	bl MTX_TransApply43
	add r0, r8, #0x9c
	add r6, r0, #0x400
	add r0, r8, #0x2dc
	add r7, r0, #0x400
	ldr r0, [r8, #0x340]
	add r4, sp, #0x54
	ldrh r0, [r0, #2]
	cmp r0, #0x8f
	bne _0216A498
	ldr r0, [sp, #0xc]
	mov fp, #0
	mov r0, r0, asr #0x1f
	str r0, [sp, #0x10]
	mov r0, #0x1000
	rsb r0, r0, #0
	str r0, [sp, #0x1c]
_0216A3B4:
	add r0, sp, #0x84
	mov r1, r4
	mov r2, #0x30
	bl MIi_CpuCopy32
	ldrh r2, [r7]
	add r0, sp, #0x108
	add r1, sp, #0xb4
	mov r3, r2, asr #4
	ldr r2, _0216A890 // =FX_SinCosTable_
	add r2, r2, r3, lsl #2
	ldrsh lr, [r2, #2]
	ldr r3, [sp, #0xc]
	ldr r2, [sp, #0x1c]
	umull sl, sb, lr, r3
	ldr r3, [sp, #0x10]
	str r2, [sp, #0xe8]
	mla sb, lr, r3, sb
	mov r2, #0
	str r2, [sp, #0xec]
	ldr r3, [sp, #0xc]
	mov ip, lr, asr #0x1f
	mla sb, ip, r3, sb
	adds sl, sl, #0x800
	adc r3, sb, #0
	mov sb, sl, lsr #0xc
	orr sb, sb, r3, lsl #20
	mov r2, r6
	str sb, [sp, #0xe4]
	bl MTX_MultVec43
	add r0, sp, #0xe4
	add r1, sp, #0xb4
	add r2, r6, #0xc
	bl MTX_MultVec43
	ldrh r1, [r7], #2
	mov r0, r4
	mov r1, r1, asr #4
	mov r3, r1, lsl #1
	ldr r1, _0216A890 // =FX_SinCosTable_
	mov r2, r3, lsl #1
	ldrsh r1, [r1, r2]
	ldr r2, _0216A890 // =FX_SinCosTable_
	add r2, r2, r3, lsl #1
	ldrsh r2, [r2, #2]
	blx MTX_RotZ33_
	mov r0, r4
	add r1, sp, #0x24
	mov r2, r4
	bl MTX_Concat43
	add r1, sp, #0xb4
	mov r0, r4
	mov r2, r1
	bl MTX_Concat43
	add fp, fp, #1
	add r6, r6, #0x18
	cmp fp, #0x18
	blt _0216A3B4
	b _0216A5B4
_0216A498:
	ldr r0, [sp, #0xc]
	mov r0, r0, asr #0x1f
	str r0, [sp, #0x18]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, #0x1000
	rsb r0, r0, #0
	str r0, [sp, #0x20]
_0216A4B8:
	add r0, sp, #0x84
	mov r1, r4
	mov r2, #0x30
	bl MIi_CpuCopy32
	ldrh r2, [r7]
	ldr sl, [sp, #0xc]
	ldr ip, [sp, #0x18]
	mov r3, r2, asr #4
	ldr r2, _0216A890 // =FX_SinCosTable_
	add r0, sp, #0x108
	add r2, r2, r3, lsl #2
	ldrsh sb, [r2, #2]
	ldr r2, [sp, #0x20]
	add r1, sp, #0xb4
	umull fp, sl, sb, sl
	str r2, [sp, #0xe8]
	mov r2, #0
	str r2, [sp, #0xec]
	mla sl, sb, ip, sl
	mov r3, sb, asr #0x1f
	ldr sb, [sp, #0xc]
	mov r2, r6
	mla sl, r3, sb, sl
	adds sb, fp, #0x800
	adc r3, sl, #0
	mov sb, sb, lsr #0xc
	orr sb, sb, r3, lsl #20
	str sb, [sp, #0xe4]
	bl MTX_MultVec43
	add r0, sp, #0xe4
	add r1, sp, #0xb4
	add r2, r6, #0xc
	bl MTX_MultVec43
	ldrh r1, [r7], #2
	mov r0, r4
	rsb r1, r1, #0
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r1, r1, asr #4
	mov r3, r1, lsl #1
	ldr r1, _0216A890 // =FX_SinCosTable_
	mov r2, r3, lsl #1
	ldrsh r1, [r1, r2]
	ldr r2, _0216A890 // =FX_SinCosTable_
	add r2, r2, r3, lsl #1
	ldrsh r2, [r2, #2]
	blx MTX_RotZ33_
	mov r0, r4
	add r1, sp, #0x24
	mov r2, r4
	bl MTX_Concat43
	add r1, sp, #0xb4
	mov r0, r4
	mov r2, r1
	bl MTX_Concat43
	ldr r0, [sp, #4]
	add r6, r6, #0x18
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #0x18
	blt _0216A4B8
_0216A5B4:
	ldr r0, [r8, #0x6d0]
	ldr r1, [r8, #0x44]
	mov r0, r0, asr #9
	add r0, r0, r1, asr #12
	str r0, [r8, #0x264]
	ldr r0, [r8, #0x6d4]
	ldr r1, [r8, #0x48]
	mov r0, r0, asr #9
	rsb r0, r0, r1, asr #12
	str r0, [r8, #0x268]
	ldr r1, [r8, #0x44]
	ldr r0, [r8, #0x6d0]
	add r4, r8, #0x2d8
	add r0, r1, r0, lsl #3
	str r0, [r8, #0x8c]
	ldr r1, [r8, #0x48]
	ldr r0, [r8, #0x6d4]
	sub r0, r1, r0, lsl #3
	str r0, [r8, #0x90]
	ldr r0, [r8, #0x340]
	ldrh r0, [r0, #2]
	cmp r0, #0x8f
	bne _0216A668
	ldr r1, [sp, #8]
	ldr r3, [r8, #0x44]
	ldr r2, [r1, #0x44]
	sub r1, r3, #0x18000
	cmp r2, r1
	addlt sp, sp, #0x114
	ldmltia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	add r1, r3, #0xd8000
	cmp r2, r1
	addgt sp, sp, #0x114
	ldmgtia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r1, [sp, #8]
	ldr r3, [r8, #0x48]
	ldr r2, [r1, #0x48]
	sub r1, r3, #0x18000
	cmp r2, r1
	addlt sp, sp, #0x114
	ldmltia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	add r1, r3, #0xd8000
	cmp r2, r1
	addgt sp, sp, #0x114
	ldmgtia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_0216A668:
	cmp r0, #0x95
	bne _0216A6C8
	ldr r1, [sp, #8]
	ldr r3, [r8, #0x44]
	ldr r2, [r1, #0x44]
	add r1, r3, #0x18000
	cmp r2, r1
	addgt sp, sp, #0x114
	ldmgtia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	sub r1, r3, #0xd8000
	cmp r2, r1
	addlt sp, sp, #0x114
	ldmltia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	ldr r1, [sp, #8]
	ldr r3, [r8, #0x48]
	ldr r2, [r1, #0x48]
	sub r1, r3, #0x18000
	cmp r2, r1
	addlt sp, sp, #0x114
	ldmltia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	add r1, r3, #0xd8000
	cmp r2, r1
	addgt sp, sp, #0x114
	ldmgtia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
_0216A6C8:
	cmp r0, #0x8f
	bne _0216A6D8
	cmp r5, #0
	ble _0216A6E8
_0216A6D8:
	cmp r0, #0x95
	bne _0216A708
	cmp r5, #0
	blt _0216A708
_0216A6E8:
	cmp r0, #0x8f
	moveq r0, #0
	mvnne r0, #0xbf
	strh r0, [r4, #0x18]
	mov r0, #0
	strh r0, [r4, #0x1a]
	str r0, [r8, #0x28]
	b _0216A868
_0216A708:
	add r1, r8, #0x9c
	add r2, r8, #0x84
	add r6, r2, #0x400
	mov r7, #0
	cmp r0, #0x8f
	add r1, r1, #0x400
	ldr r2, [r8, #0x6c4]
	mov r0, r7
	bne _0216A7D0
	mov r2, r2, asr #9
	sub r2, r2, #0xc0
	strh r2, [r4, #0x18]
_0216A738:
	ldr r2, [r1]
	cmp r5, r2, lsl #3
	ble _0216A770
	add r2, r8, r0, lsl #1
	add r2, r2, #0x600
	ldrh r2, [r2, #0xdc]
	add r0, r0, #1
	mov r6, r1
	add r2, r7, r2
	mov r2, r2, lsl #0x10
	cmp r0, #0x18
	mov r7, r2, lsr #0x10
	add r1, r1, #0x18
	blt _0216A738
_0216A770:
	cmp r0, #0x18
	subge r6, r6, #0x18
	subge r1, r1, #0x18
	ldr sl, [r6]
	ldmia r1, {r0, r3}
	sub r1, r0, sl
	ldr r2, [r6, #4]
	sub r0, r5, sl, lsl #3
	sub sb, r3, r2
	mov r1, r1, lsl #3
	bl FX_Div
	smull r2, r1, r0, sb
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	ldr r2, [r6, #4]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	rsb r0, r0, #0
	mov r0, r0, asr #9
	strh r0, [r4, #0x1a]
	rsb r0, r7, #0x10000
	str r0, [r8, #0x28]
	b _0216A868
_0216A7D0:
	mov r2, r2, asr #9
	strh r2, [r4, #0x18]
_0216A7D8:
	ldr r2, [r1]
	cmp r5, r2, lsl #3
	bge _0216A810
	add r2, r8, r0, lsl #1
	add r2, r2, #0x600
	ldrh r2, [r2, #0xdc]
	add r0, r0, #1
	mov r6, r1
	add r2, r7, r2
	mov r2, r2, lsl #0x10
	cmp r0, #0x18
	mov r7, r2, lsr #0x10
	add r1, r1, #0x18
	blt _0216A7D8
_0216A810:
	cmp r0, #0x18
	subge r6, r6, #0x18
	subge r1, r1, #0x18
	ldr sl, [r6]
	ldmia r1, {r0, r3}
	sub r1, r0, sl
	ldr r2, [r6, #4]
	sub r0, r5, sl, lsl #3
	sub sb, r3, r2
	mov r1, r1, lsl #3
	bl FX_Div
	smull r2, r1, r0, sb
	adds r2, r2, #0x800
	adc r0, r1, #0
	mov r1, r2, lsr #0xc
	ldr r2, [r6, #4]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	rsb r0, r0, #0
	mov r0, r0, asr #9
	strh r0, [r4, #0x1a]
	str r7, [r8, #0x28]
_0216A868:
	ldrsh r0, [r4, #0x1a]
	ldr r1, [r8, #0x48]
	add r0, r1, r0, lsl #12
	str r0, [r8, #0x2c]
	add sp, sp, #0x114
	ldmia sp!, {r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0216A880: .word gPlayer
_0216A884: .word 0x0000FD60
_0216A888: .word 0x0000FEAB
_0216A88C: .word _02188580
_0216A890: .word FX_SinCosTable_
	arm_func_end ovl00_216A020

	arm_func_start ovl00_216A894
ovl00_216A894: // 0x0216A894
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, lr}
	sub sp, sp, #0xac
	bl GetCurrentTaskWork_
	mov r4, #0x8000
	ldr r1, _0216AB58 // =g_obj
	mov r3, #0x1000
	ldr r2, [r1]
	mov r7, r0
	str r4, [sp, #0x4c]
	str r4, [sp, #0x50]
	str r3, [sp, #0x54]
	cmp r2, #0x1000
	beq _0216A8E0
	smull r1, r0, r2, r4
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x4c]
_0216A8E0:
	ldr r0, _0216AB58 // =g_obj
	ldr r2, [r0, #4]
	cmp r2, #0x1000
	beq _0216A90C
	ldr r0, [sp, #0x50]
	smull r1, r0, r2, r0
	adds r1, r1, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x50]
_0216A90C:
	ldr r2, [sp, #0x4c]
	ldr r1, [sp, #0x50]
	mov r3, r2, lsl #5
	mov r2, r1, lsl #5
	ldr r0, [sp, #0x54]
	str r3, [sp, #0x4c]
	mov r1, r0, lsl #5
	add r0, sp, #0x1c
	str r2, [sp, #0x50]
	str r1, [sp, #0x54]
	bl MTX_Identity33_
	add r1, sp, #0x40
	add r2, sp, #0x58
	add r0, r7, #0x44
	mov r3, #0
	bl GameObject__Func_20282A8
	add r0, sp, #0x4c
	bl NNS_G3dGlbSetBaseScale
	ldr r1, _0216AB5C // =0x021472FC
	add r0, sp, #0x1c
	bl MI_Copy36B
	ldr r1, _0216AB60 // =NNS_G3dGlb
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
	add r0, r7, #0x6c
	add r6, r0, #0x400
	add r5, sp, #0x98
	ldmia r6!, {r0, r1, r2, r3}
	mov r4, r5
	stmia r5!, {r0, r1, r2, r3}
	ldr r1, [r6]
	mov r0, r4
	str r1, [r5]
	mov r1, #3
	bl G3C_Begin
	ldr r0, [r7, #0x340]
	ldr r1, _0216AB64 // =0x00007FFF
	ldrh r0, [r0, #2]
	cmp r0, #0x8f
	moveq sb, #0
	add r0, sp, #0x98
	movne sb, #0x7000
	bl G3C_Color
	add r0, r7, #0x84
	mov r8, #0
	add sl, r0, #0x400
	add r6, sp, #0x98
	mov r5, r8
	mov r4, #0x8000
_0216A9F4:
	mov r0, r6
	mov r1, sb
	mov r2, r5
	bl G3C_TexCoord
	ldmia sl, {r0, r2, r3}
	mov r0, r0, lsl #0xb
	mov r1, r0, asr #0x10
	mov r0, r2, lsl #0xb
	mov r2, r0, asr #0x10
	mov r0, r3, lsl #0xb
	mov r3, r0, asr #0x10
	mov r0, r6
	bl G3C_Vtx
	mov r0, r6
	mov r1, sb
	mov r2, r4
	bl G3C_TexCoord
	ldr r1, [sl, #0xc]
	ldr r2, [sl, #0x10]
	ldr r3, [sl, #0x14]
	mov r1, r1, lsl #0xb
	mov r2, r2, lsl #0xb
	mov r3, r3, lsl #0xb
	mov r0, r6
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, asr #0x10
	bl G3C_Vtx
	add r8, r8, #1
	add sl, sl, #0x18
	add sb, sb, #0x8000
	cmp r8, #0x19
	blt _0216A9F4
	add r0, sp, #0x98
	bl G3C_End
	add r0, sp, #0x98
	bl G3_EndMakeDL
	ldr r0, [r7, #0x480]
	mov r1, #0x400
	bl DC_FlushRange
	ldr r1, [sp, #0x98]
	tst r1, #3
	ldrne r0, [sp, #0xa0]
	ldrne r1, [sp, #0x9c]
	ldreq r0, [sp, #0xa0]
	sub r1, r1, r0
	ldr r0, [r7, #0x480]
	bl NNS_G3dGeSendDL
	ldr r0, [r7, #0x354]
	tst r0, #0xf
	addne sp, sp, #0xac
	ldmneia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	add r0, r7, #0x44
	add r3, sp, #0x10
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, [r7, #0x340]
	mov sb, #0x8000
	ldrh r0, [r0, #2]
	cmp r0, #0x8f
	bne _0216AAF8
	ldr r0, [sp, #0x10]
	add r0, r0, #0x3000
	str r0, [sp, #0x10]
	b _0216AB08
_0216AAF8:
	ldr r0, [sp, #0x10]
	rsb sb, sb, #0
	sub r0, r0, #0x4000
	str r0, [sp, #0x10]
_0216AB08:
	mov r8, #0
	add r6, r7, #0x20
	mov r5, r8
	add r4, sp, #0x10
_0216AB18:
	str r6, [sp]
	str r5, [sp, #4]
	mov r1, r4
	mov r2, r5
	mov r3, r5
	str r5, [sp, #8]
	add r0, r7, #0x168
	bl StageTask__Draw2DEx
	ldr r0, [sp, #0x10]
	add r8, r8, #1
	add r0, r0, sb
	str r0, [sp, #0x10]
	cmp r8, #0x18
	blt _0216AB18
	add sp, sp, #0xac
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, pc}
	.align 2, 0
_0216AB58: .word g_obj
_0216AB5C: .word 0x021472FC
_0216AB60: .word NNS_G3dGlb
_0216AB64: .word 0x00007FFF
	arm_func_end ovl00_216A894

	arm_func_start ovl00_216AB68
ovl00_216AB68: // 0x0216AB68
	stmdb sp!, {r4, lr}
	ldr r4, [r1, #0x1c]
	ldr r2, [r0, #0x1c]
	cmp r4, #0
	cmpne r2, #0
	ldmeqia sp!, {r4, pc}
	ldrh r3, [r2]
	cmp r3, #1
	ldreqb r3, [r2, #0x5d1]
	cmpeq r3, #0
	ldmneia sp!, {r4, pc}
	ldr r3, [r2, #0x6d8]
	cmp r3, r4
	ldmeqia sp!, {r4, pc}
	ldr r3, [r4, #0x354]
	tst r3, #2
	strne r4, [r4, #0x2d8]
	bne _0216ABCC
	ldr ip, [r2, #0x48]
	ldr r3, [r4, #0x48]
	add ip, ip, #0xd000
	cmp ip, r3
	movgt r3, #0
	strgt r3, [r4, #0x2d8]
	strle r4, [r4, #0x2d8]
_0216ABCC:
	ldr r3, [r2, #0x118]
	cmp r3, r4
	bne _0216ABE4
	ldr r3, [r2, #0x1c]
	tst r3, #1
	bne _0216ABEC
_0216ABE4:
	bl ObjRect__FuncNoHit
	ldmia sp!, {r4, pc}
_0216ABEC:
	mov r0, r2
	mov r1, r4
	bl Player__Gimmick_201FD7C
	ldr r1, [r4, #0x354]
	mov r0, #0
	orr r1, r1, #3
	bic r1, r1, #8
	str r1, [r4, #0x354]
	str r0, [r4, #0x2d8]
	ldmia sp!, {r4, pc}
	arm_func_end ovl00_216AB68

	arm_func_start ovl00_216AC14
ovl00_216AC14: // 0x0216AC14
	stmdb sp!, {r3, r4, r5, lr}
	ldr r4, [r1, #0x1c]
	ldr r5, [r0, #0x1c]
	cmp r4, #0
	cmpne r5, #0
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r2, [r5]
	cmp r2, #1
	ldreqb r2, [r5, #0x5d1]
	cmpeq r2, #0
	ldmneia sp!, {r3, r4, r5, pc}
	ldr r2, [r5, #0x6d8]
	cmp r2, r4
	beq _0216AC54
	bl ObjRect__FuncNoHit
	ldmia sp!, {r3, r4, r5, pc}
_0216AC54:
	mov r0, r5
	mov r1, r4
	bl Player__Func_20202E4
	ldr r1, [r4, #0x354]
	mov r0, r5
	orr r2, r1, #4
	mov r1, r4
	str r2, [r4, #0x354]
	bl Player__Action_AllowTrickCombos
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end ovl00_216AC14

	.rodata

_02188580: // 0x02188580
    .word 0, 0xFFFFF000, 0

	.data
	
aActAcGmkDiveSt: // 0x021893D8
	.asciz "/act/ac_gmk_dive_stand3d.bac"
	.align 4