	.include "asm/macros.inc"
	.include "global.inc"

	.public _ZTVN10__cxxabiv117__class_type_infoE
	.public _ZTVN10__cxxabiv120__si_class_type_infoE

	.text

	arm_func_start ViDockNpc__Constructor
ViDockNpc__Constructor: // 0x02166B98
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl ViDockNpc__Func_2167384
	ldr r0, _02166BD4 // =_ZTV10CViDockNpc+0x08
	mov r1, #0
	str r0, [r4]
	str r1, [r4, #0x314]
	str r1, [r4, #0x318]
	str r1, [r4, #0x31c]
	str r1, [r4, #0x320]
	mov r0, r4
	str r1, [r4, #0x324]
	bl ViDockNpc__Func_2166F10
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166BD4: .word _ZTV10CViDockNpc+0x08
	arm_func_end ViDockNpc__Constructor

	arm_func_start ViDockNpc__VTableFunc_2166BD8
ViDockNpc__VTableFunc_2166BD8: // 0x02166BD8
	stmdb sp!, {r4, lr}
	ldr r1, _02166BFC // =_ZTV10CViDockNpc+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockNpc__Func_2166F10
	mov r0, r4
	bl Vi3dObject__Func_216761C
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166BFC: .word _ZTV10CViDockNpc+0x08
	arm_func_end ViDockNpc__VTableFunc_2166BD8

	arm_func_start ViDockNpc__VTableFunc_2166C00
ViDockNpc__VTableFunc_2166C00: // 0x02166C00
	stmdb sp!, {r4, lr}
	ldr r1, _02166C2C // =_ZTV10CViDockNpc+0x08
	mov r4, r0
	str r1, [r4]
	bl ViDockNpc__Func_2166F10
	mov r0, r4
	bl Vi3dObject__Func_216761C
	mov r0, r4
	bl _ZdlPv
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02166C2C: .word _ZTV10CViDockNpc+0x08
	arm_func_end ViDockNpc__VTableFunc_2166C00

	arm_func_start ViDockNpc__LoadAssets
ViDockNpc__LoadAssets: // 0x02166C30
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r4, r1
	mov r7, r0
	mov r6, r2
	mov r5, r3
	bl ViDockNpc__Func_2166F10
	mov r0, r4, lsl #0x10
	str r4, [r7, #0x300]
	mov r0, r0, lsr #0x10
	bl DockHelpers__GetNpcConfig
	ldrh r2, [r0, #0]
	add r0, r7, #0x300
	mov r1, #0xc
	strh r2, [r0, #0x12]
	mul r0, r2, r1
	ldr r3, _02166EF4 // =ViDockNpc__AssetInfoList
	sub r2, r1, #0xd
	add r4, r3, r0
	ldrb r3, [r3, r0]
	ldr r1, _02166EF8 // =0x02173074
	ldr r0, _02166EFC // =aBbViNpcBb_ovl05
	mov r3, r3, lsl #1
	ldrh r1, [r1, r3]
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r7, #0x314]
	ldrb r3, [r4, #1]
	ldr r1, _02166F00 // =ViDockNpc__JointAnimList
	ldr r0, _02166EFC // =aBbViNpcBb_ovl05
	mov r3, r3, lsl #1
	ldrh r1, [r1, r3]
	mvn r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r7, #0x318]
	ldrb r1, [r4, #2]
	cmp r1, #0xff
	beq _02166CE0
	ldr r0, _02166F04 // =0x02173058
	mov r1, r1, lsl #1
	ldrh r1, [r0, r1]
	ldr r0, _02166EFC // =aBbViNpcBb_ovl05
	mvn r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r7, #0x31c]
_02166CE0:
	ldrb r1, [r4, #3]
	cmp r1, #0xff
	beq _02166D08
	ldr r0, _02166F04 // =0x02173058
	mov r1, r1, lsl #1
	ldrh r1, [r0, r1]
	ldr r0, _02166EFC // =aBbViNpcBb_ovl05
	mvn r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r7, #0x320]
_02166D08:
	ldrb r1, [r4, #4]
	cmp r1, #0xff
	beq _02166D30
	ldr r0, _02166F04 // =0x02173058
	mov r1, r1, lsl #1
	ldrh r1, [r0, r1]
	ldr r0, _02166EFC // =aBbViNpcBb_ovl05
	mvn r2, #0
	bl BundleFileUnknown__LoadFileFromBundle
	str r0, [r7, #0x324]
_02166D30:
	ldrb r1, [r4, #7]
	mov r0, #0xc
	ldr r2, _02166F08 // =0x0217305C
	smulbb r1, r1, r0
	ldr r0, [r2, r1]
	add r1, r2, r1
	str r0, [r7, #0x328]
	ldr r0, [r1, #4]
	mov r2, #0
	str r0, [r7, #0x32c]
	ldr r0, [r1, #8]
	str r0, [r7, #0x330]
	ldrb r0, [r4, #8]
	cmp r0, #0xff
	str r2, [sp]
	bne _02166DC8
	ldr r0, [r7, #0x318]
	ldr r1, _02166F0C // =0x0000FFFF
	stmib sp, {r0, r2}
	ldr r3, [r7, #0x31c]
	mov r0, r7
	str r3, [sp, #0xc]
	ldr ip, [r7, #0x324]
	mov r3, r2
	str ip, [sp, #0x10]
	ldr ip, [r7, #0x320]
	str ip, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r7, #0x314]
	bl Vi3dObject__Func_216763C
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldrb r1, [r4, #5]
	mov r0, r7
	mov r2, #1
	bl Vi3dObject__Func_2167900
	b _02166E38
_02166DC8:
	ldr r0, [r7, #0x318]
	mov r1, #1
	stmib sp, {r0, r2}
	ldr r3, [r7, #0x31c]
	mov r0, r7
	str r3, [sp, #0xc]
	ldr ip, [r7, #0x324]
	mov r3, r2
	str ip, [sp, #0x10]
	ldr ip, [r7, #0x320]
	str ip, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [r7, #0x314]
	bl Vi3dObject__Func_216763C
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldrb r1, [r4, #5]
	mov r0, r7
	mov r2, #1
	bl Vi3dObject__Func_2167900
	mov r3, #0
	str r3, [sp]
	str r3, [sp, #4]
	ldrb r1, [r4, #8]
	mov r0, r7
	mov r2, #1
	bl Vi3dObject__Func_2167958
_02166E38:
	ldr r0, [r7, #0x31c]
	cmp r0, #0
	beq _02166E60
	mov r1, #0
	str r1, [sp]
	mov r0, r7
	mov r3, r1
	mov r2, #1
	str r1, [sp, #4]
	bl Vi3dObject__Func_21679B0
_02166E60:
	ldr r0, [r7, #0x320]
	cmp r0, #0
	beq _02166E88
	mov r1, #0
	str r1, [sp]
	mov r0, r7
	mov r3, r1
	mov r2, #1
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167A80
_02166E88:
	ldr r0, [r7, #0x324]
	cmp r0, #0
	beq _02166EB0
	mov r1, #0
	str r1, [sp]
	mov r0, r7
	mov r3, r1
	mov r2, #1
	str r1, [sp, #4]
	bl Vi3dObject__Func_2167A0C
_02166EB0:
	mov r1, r6
	add r0, r7, #8
	bl CPPHelpers__VEC_Copy_Alt
	strh r5, [r7, #0x38]
	ldrh r1, [r7, #0x38]
	mov r2, #0x5b0
	add r0, r7, #0x300
	strh r1, [r7, #0x3a]
	ldr r3, [r7, #4]
	ldr r1, [sp, #0x30]
	orr r3, r3, #1
	str r3, [r7, #4]
	strh r2, [r7, #0x3e]
	strh r5, [r0, #0x10]
	str r1, [r7, #0x334]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_02166EF4: .word ViDockNpc__AssetInfoList
_02166EF8: .word 0x02173074
_02166EFC: .word aBbViNpcBb_ovl05
_02166F00: .word ViDockNpc__JointAnimList
_02166F04: .word 0x02173058
_02166F08: .word 0x0217305C
_02166F0C: .word 0x0000FFFF
	arm_func_end ViDockNpc__LoadAssets

	arm_func_start ViDockNpc__Func_2166F10
ViDockNpc__Func_2166F10: // 0x02166F10
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl Vi3dObject__Func_21677C4
	ldr r0, [r4, #0x314]
	cmp r0, #0
	beq _02166F34
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x314]
_02166F34:
	ldr r0, [r4, #0x318]
	cmp r0, #0
	beq _02166F4C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x318]
_02166F4C:
	ldr r0, [r4, #0x31c]
	cmp r0, #0
	beq _02166F64
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x31c]
_02166F64:
	ldr r0, [r4, #0x320]
	cmp r0, #0
	beq _02166F7C
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x320]
_02166F7C:
	ldr r0, [r4, #0x324]
	cmp r0, #0
	beq _02166F94
	bl _FreeHEAP_USER
	mov r0, #0
	str r0, [r4, #0x324]
_02166F94:
	mov r0, #0xc
	mov r1, #0
	str r0, [r4, #0x304]
	str r1, [r4, #0x308]
	sub r0, r1, #1
	str r0, [r4, #0x30c]
	str r1, [r4, #0x328]
	str r1, [r4, #0x32c]
	str r1, [r4, #0x330]
	add r0, r4, #0x300
	strh r1, [r0, #0x10]
	mov r1, #0xe
	strh r1, [r0, #0x12]
	ldmia sp!, {r4, pc}
	arm_func_end ViDockNpc__Func_2166F10

	arm_func_start ViDockNpc__Func_2166FCC
ViDockNpc__Func_2166FCC: // 0x02166FCC
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x334]
	mov r2, #1
	cmp r0, #0
	strneh r1, [r4, #0x38]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	add r0, r4, #0x300
	ldrh r1, [r0, #0x12]
	mov r0, #0xc
	mul r3, r1, r0
	ldr r1, _02167060 // =0x021730AE
	mov r0, r4
	ldrb r1, [r1, r3]
	mov r3, r2
	bl Vi3dObject__Func_2167900
	add r0, r4, #0x300
	ldrh r2, [r0, #0x12]
	mov r0, #0xc
	ldr r1, _02167064 // =0x021730B1
	mul r0, r2, r0
	ldrb r1, [r1, r0]
	cmp r1, #0xff
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov ip, #0
	mov r2, #1
	str ip, [sp]
	mov r0, r4
	mov r3, r2
	str ip, [sp, #4]
	bl Vi3dObject__Func_2167958
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167060: .word 0x021730AE
_02167064: .word 0x021730B1
	arm_func_end ViDockNpc__Func_2166FCC

	arm_func_start ViDockNpc__Func_2167068
ViDockNpc__Func_2167068: // 0x02167068
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	ldr r0, [r4, #0x334]
	mov r2, #1
	cmp r0, #0
	addne r0, r4, #0x300
	ldrneh r0, [r0, #0x10]
	strneh r0, [r4, #0x38]
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	add r0, r4, #0x300
	ldrh r1, [r0, #0x12]
	mov r0, #0xc
	mul r3, r1, r0
	ldr r1, _02167104 // =0x021730AD
	mov r0, r4
	ldrb r1, [r1, r3]
	mov r3, r2
	bl Vi3dObject__Func_2167900
	add r0, r4, #0x300
	ldrh r2, [r0, #0x12]
	mov r0, #0xc
	ldr r1, _02167108 // =0x021730B0
	mul r0, r2, r0
	ldrb r1, [r1, r0]
	cmp r1, #0xff
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov ip, #0
	mov r2, #1
	str ip, [sp]
	mov r0, r4
	mov r3, r2
	str ip, [sp, #4]
	bl Vi3dObject__Func_2167958
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_02167104: .word 0x021730AD
_02167108: .word 0x021730B0
	arm_func_end ViDockNpc__Func_2167068

	arm_func_start ViDockNpc__Func_216710C
ViDockNpc__Func_216710C: // 0x0216710C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r5, r2
	ldr r2, [r5, #0]
	mov r4, r3
	str r2, [r4]
	ldr r2, [r5, #4]
	mov r6, r1
	str r2, [r4, #4]
	ldr r1, [r5, #8]
	mov r7, r0
	str r1, [r4, #8]
	ldr r1, [r6, #0]
	ldr r0, [r5, #0]
	cmp r1, r0
	ldreq r1, [r6, #4]
	ldreq r0, [r5, #4]
	cmpeq r1, r0
	ldreq r1, [r6, #8]
	ldreq r0, [r5, #8]
	cmpeq r1, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r9, [sp, #0x20]
	ldr r1, [r7, #0x328]
	ldr r0, [r7, #0x330]
	smull r2, r3, r1, r9
	adds r8, r2, #0x800
	smull r2, r1, r0, r9
	adc r3, r3, #0
	adds r0, r2, #0x800
	mov r9, r8, lsr #0xc
	adc r1, r1, #0
	mov r8, r0, lsr #0xc
	add r0, r7, #8
	orr r9, r9, r3, lsl #20
	orr r8, r8, r1, lsl #20
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #0]
	add r0, r7, #8
	sub r10, r1, r9
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #0]
	add r0, r7, #8
	add r9, r9, r1
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #8]
	add r0, r7, #8
	sub r7, r1, r8
	bl CPPHelpers__Func_2085F9C
	ldr r1, [r0, #8]
	ldr r0, [r5, #0]
	add r1, r8, r1
	cmp r0, r10
	ble _02167200
	cmp r0, r9
	bge _02167200
	ldr r0, [r5, #8]
	cmp r0, r7
	ble _02167200
	cmp r0, r1
	blt _02167208
_02167200:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_02167208:
	ldr r0, [r6, #0]
	cmp r0, r10
	strle r10, [r4]
	ble _0216723C
	cmp r0, r9
	strge r9, [r4]
	bge _0216723C
	ldr r0, [r6, #8]
	cmp r0, r7
	strle r7, [r4, #8]
	ble _0216723C
	cmp r0, r1
	strge r1, [r4, #8]
_0216723C:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end ViDockNpc__Func_216710C

	arm_func_start ViDockNpc__Func_2167244
ViDockNpc__Func_2167244: // 0x02167244
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r9, r0
	mov r8, r1
	add r0, r9, #8
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x20]
	bl CPPHelpers__Func_2085F9C
	ldr r2, [r0, #0]
	ldr r1, [r8, #0]
	add r0, r9, #8
	sub r4, r2, r1
	bl CPPHelpers__Func_2085F9C
	add r2, r9, #0x300
	ldr r10, [r0, #8]
	ldr r0, [r8, #8]
	smull r3, r1, r4, r4
	sub ip, r10, r0
	adds r3, r3, #0x800
	ldrh r2, [r2, #0x12]
	mov r9, #0xc
	smull lr, r0, ip, ip
	mul r8, r2, r9
	ldr r2, _02167370 // =0x021730AF
	mov r3, r3, lsr #0xc
	ldrb r8, [r2, r8]
	adc r2, r1, #0
	adds r1, lr, #0x800
	smulbb r8, r8, r9
	ldr r9, _02167374 // =0x0217305C
	adc r10, r0, #0
	mov r1, r1, lsr #0xc
	add lr, r9, r8
	ldr r0, [r9, r8]
	ldr r8, [lr, #8]
	orr r3, r3, r2, lsl #20
	orr r1, r1, r10, lsl #20
	cmp r0, r8
	movlt r0, r8
	add r1, r3, r1
	smull r3, r2, r0, r6
	adds r3, r3, #0x800
	mov r0, #0
	adc r2, r2, r0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r6, r3, r3, asr #1
	smull r3, r2, r6, r6
	adds r3, r3, #0x800
	adc r2, r2, r0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	cmp r1, r3
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r7, asr #4
	mov r2, r0, lsl #1
	ldr r1, _02167378 // =FX_SinCosTable_
	mov r0, r2, lsl #1
	ldrsh r0, [r1, r0]
	add r2, r2, #1
	mov r2, r2, lsl #1
	muls r0, r4, r0
	ldrsh r0, [r1, r2]
	bmi _0216734C
	muls r0, ip, r0
	bpl _0216735C
_0216734C:
	cmp r5, #0
	movne r0, #0
	strne r0, [r5]
	b _02167368
_0216735C:
	cmp r5, #0
	movne r0, #1
	strne r0, [r5]
_02167368:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_02167370: .word 0x021730AF
_02167374: .word 0x0217305C
_02167378: .word FX_SinCosTable_
	arm_func_end ViDockNpc__Func_2167244

	arm_func_start ViDockNpc__Func_216737C
ViDockNpc__Func_216737C: // 0x0216737C
	mov r0, #1
	bx lr
	arm_func_end ViDockNpc__Func_216737C

	arm_func_start ViDockNpc__Func_2167384
ViDockNpc__Func_2167384: // 0x02167384
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	ldr r1, _021674A4 // =0x021738E8
	add r0, r4, #8
	str r1, [r4]
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x14
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x20
	bl CPPHelpers__Func_2085EE8
	add r0, r4, #0x2c
	bl CPPHelpers__Func_2085EE8
	mov r1, #0
	add r0, sp, #0xc
	mov r2, r1
	mov r3, r1
	str r1, [r4, #4]
	bl CPPHelpers__VEC_Set
	add r0, r4, #8
	add r1, sp, #0xc
	bl CPPHelpers__Func_2085FA8
	add r0, r4, #0x14
	add r1, r4, #8
	bl CPPHelpers__Func_2085FA8
	mov r1, #0x1000
	add r0, sp, #0
	mov r2, r1
	mov r3, r1
	bl CPPHelpers__VEC_Set
	add r0, r4, #0x20
	add r1, sp, #0
	bl CPPHelpers__Func_2085FA8
	add r0, r4, #0x2c
	add r1, r4, #0x20
	bl CPPHelpers__Func_2085FA8
	mov r1, #0
	strh r1, [r4, #0x38]
	strh r1, [r4, #0x3a]
	ldrh r3, [r4, #0x38]
	ldr r2, _021674A8 // =0x0000FFFF
	add r0, r4, #0x100
	strh r3, [r4, #0x3c]
	strh r1, [r4, #0x3e]
	strh r1, [r4, #0x40]
	strh r1, [r4, #0x42]
	strh r2, [r0, #0x88]
	strh r2, [r0, #0x8a]
	strh r2, [r0, #0x8c]
	strh r2, [r0, #0x8e]
	strh r2, [r0, #0x90]
	strh r2, [r0, #0x92]
	add r0, r4, #0x200
	strh r2, [r0, #0xd8]
	strh r2, [r0, #0xda]
	str r1, [r4, #0x2dc]
	str r1, [r4, #0x2e0]
	str r1, [r4, #0x2e4]
	str r1, [r4, #0x2e8]
	str r1, [r4, #0x2ec]
	str r1, [r4, #0x2f0]
	str r1, [r4, #0x2f4]
	str r1, [r4, #0x2f8]
	add r0, r4, #0x44
	str r1, [r4, #0x2fc]
	bl AnimatorMDL__Init
	add r0, r4, #0x194
	mov r1, #0
	bl AnimatorMDL__Init
	mov r0, r4
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	.align 2, 0
_021674A4: .word 0x021738E8
_021674A8: .word 0x0000FFFF
	arm_func_end ViDockNpc__Func_2167384
	
	.rodata

.public ovl05_02173040
ovl05_02173040: // 0x02173040
    .word 0x2000, 0x800, 0x20
	.word 0x2000, 0x800, 0x100

.public ViDockNpc__MaterialAnimlList
ViDockNpc__MaterialAnimlList: // 0x02173058
	.hword 0x1B, 0x00
	
.public ovl05_0217305C
ovl05_0217305C: // 0x0217305C
    .word 0x6000, 0x6000, 0x6000
	.word 0xC000, 0x8000, 0xC000

.public ViDockNpc__ModelList
ViDockNpc__ModelList: // 0x02173074
	.hword 0x00
	.hword 0x02
	.hword 0x04
	.hword 0x06
	.hword 0x08
	.hword 0x0A
	.hword 0x0C
	.hword 0x0E
	.hword 0x10
	.hword 0x12
	.hword 0x14
	.hword 0x16
	.hword 0x19
	
.public ViDockNpc__JointAnimList
ViDockNpc__JointAnimList: // 0x0217308E
	.hword 0x01
	.hword 0x03
	.hword 0x05
	.hword 0x07
	.hword 0x09
	.hword 0x0B
	.hword 0x0D
	.hword 0x0F
	.hword 0x11
	.hword 0x13
	.hword 0x15
	.hword 0x17
	.hword 0x1A

.public ViDockNpc__AssetInfoList
ViDockNpc__AssetInfoList: // 0x021730A8
	.byte 0, 0, 0xFF, 0xFF, 0xFF, 0, 1, 0, 2, 3, 0, 0
	.byte 1, 1, 0xFF, 0xFF, 0xFF, 0, 1, 0, 0xFF, 0xFF, 0, 0
	.byte 2, 2, 0xFF, 0xFF, 0xFF, 0, 1, 0, 0xFF, 0xFF, 0, 0
	.byte 3, 3, 0xFF, 0xFF, 0xFF, 0, 0, 1, 0xFF, 0xFF, 0, 0
	.byte 4, 4, 0xFF, 0xFF, 0xFF, 0, 0, 0, 0xFF, 0xFF, 0, 0
	.byte 5, 5, 0xFF, 0xFF, 0xFF, 0, 0, 0, 0xFF, 0xFF, 0, 0
	.byte 6, 6, 0xFF, 0xFF, 0xFF, 0, 0, 0, 0xFF, 0xFF, 0, 0
	.byte 7, 7, 0xFF, 0xFF, 0xFF, 0, 0, 0, 0xFF, 0xFF, 0, 0
	.byte 8, 8, 0xFF, 0xFF, 0xFF, 0, 0, 0, 0xFF, 0xFF, 0, 0
	.byte 9, 9, 0xFF, 0xFF, 0xFF, 0, 0, 0, 0xFF, 0xFF, 0, 0
	.byte 0xA, 0xA, 0xFF, 0xFF, 0xFF, 0, 0, 0, 0xFF, 0xFF, 0, 0
	.byte 0xB, 0xB, 0xFF, 0, 0xFF, 0, 0, 0, 0xFF, 0xFF, 0, 0
	.byte 0xC, 0xC, 0, 0xFF, 0xFF, 0, 0, 0, 0xFF, 0xFF, 0, 0

aBbViNpcBb_ovl05: // 0x02173144
	.asciz "bb/vi_npc.bb"
	.align 4

.public ovl05_02173154
ovl05_02173154: // 0x02173154                     
	.word 0x400

	.data

.public _ZTI11CVi3dObject_0
_ZTI11CVi3dObject_0: // 0x02173874
    .word _ZTVN10__cxxabiv117__class_type_infoE+8, _ZTS11CVi3dObject

.public _ZTI10CViDockNpc
_ZTI10CViDockNpc: // 0x0217387C
    .word _ZTVN10__cxxabiv120__si_class_type_infoE+8, _ZTS10CViDockNpc, _ZTI11CVi3dObject

.public _ZTS10CViDockNpc
_ZTS10CViDockNpc: // 0x02173888
	.asciz "10CViDockNpc"
	.align 4

.public _ZTV10CViDockNpc
_ZTV10CViDockNpc: // 0x02173898
    .word 0, _ZTI10CViDockNpc
    .word ViDockNpc__VTableFunc_2166BD8, ViDockNpc__VTableFunc_2166C00
