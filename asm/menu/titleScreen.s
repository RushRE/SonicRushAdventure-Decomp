	.include "asm/macros.inc"
	.include "global.inc"

    .bss

_02162E8C: // 0x02162E8C
    .space 16 * 4 * 0x04
	.align 4

_02162F8C: // 0x02162F8C
    .space 0x02
	.align 4

	.text

arm_func_start TitleScreen__Init
TitleScreen__Init: // 0x021560FC
	ldr ip, _02156104 // =TitleScreen__Create
	bx ip
	.align 2, 0
_02156104: .word TitleScreen__Create
	arm_func_end TitleScreen__Init

	arm_func_start TitleScreen__Create
TitleScreen__Create: // 0x02156108
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	bl TitleScreen__Func_215619C
	mov r0, #0x2000
	mov r2, #0
	str r0, [sp]
	ldr r4, _02156190 // =0x000008CC
	ldr r0, _02156194 // =TitleScreen__Main
	ldr r1, _02156198 // =TitleScreen__Destructor
	mov r3, r2
	stmib sp, {r2, r4}
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _02156190 // =0x000008CC
	mov r1, r4
	mov r0, #0
	bl MIi_CpuClear16
	mov r0, r4
	bl TitleScreen__LoadAssets
	mov r0, r4
	bl TitleScreen__Func_2156434
	mov r0, r4
	bl TitleScreen__Func_21566F0
	mov r0, r4
	bl TitleScreenBackgroundView__Create
	mov r0, r4
	bl TitleScreenCopyrightIcon__Create
	mov r0, #4
	bl StartSamplingTouchInput
	mov r0, #2
	bl LoadSysSound
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}
	.align 2, 0
_02156190: .word 0x000008CC
_02156194: .word TitleScreen__Main
_02156198: .word TitleScreen__Destructor
	arm_func_end TitleScreen__Create

	arm_func_start TitleScreen__Func_215619C
TitleScreen__Func_215619C: // 0x0215619C
	stmdb sp!, {r3, lr}
	bl VRAMSystem__Reset
	mov r0, #3
	bl VRAMSystem__SetupTextureBank
	mov r0, #0x40
	bl VRAMSystem__SetupTexturePalBank
	mov r0, #0x10
	bl VRAMSystem__SetupBGBank
	mov r0, #0x400
	str r0, [sp]
	ldr r1, _02156308 // =0x00100010
	mov r0, #0x20
	mov r2, #0x40
	mov r3, #0
	bl VRAMSystem__SetupOBJBank
	ldr lr, _0215630C // =0x04000304
	ldr r0, _02156310 // =0xFFFFFDF1
	ldrh r1, [lr]
	ldr r2, _02156314 // =renderCurrentDisplay
	mov r3, #1
	and r0, r1, r0
	orr r0, r0, #0xe
	orr r0, r0, #0x200
	strh r0, [lr]
	ldrh ip, [lr]
	ldr r0, _02156318 // =renderCoreGFXControlA
	mov r1, #0x10
	orr ip, ip, #0x8000
	strh ip, [lr]
	str r3, [r2]
	strh r1, [r0, #0x58]
	sub r0, lr, #0x298
	bl GXx_SetMasterBrightness_
	mov r0, #1
	mov r1, #0
	mov r2, r0
	bl GX_SetGraphicsMode
	mov r3, #0x4000000
	ldr r1, [r3]
	mov r0, #0
	bic r1, r1, #0x38000000
	str r1, [r3]
	ldr r2, [r3]
	ldr r1, _02156318 // =renderCoreGFXControlA
	bic r2, r2, #0x7000000
	str r2, [r3]
	ldrh r2, [r3, #0xc]
	and r2, r2, #0x43
	orr r2, r2, #0x1880
	strh r2, [r3, #0xc]
	strh r0, [r1, #2]
	strh r0, [r1]
	strh r0, [r1, #6]
	strh r0, [r1, #4]
	strh r0, [r1, #0xa]
	strh r0, [r1, #8]
	strh r0, [r1, #0xe]
	strh r0, [r1, #0xc]
	ldrh r1, [r3, #8]
	bic r1, r1, #3
	orr r1, r1, #3
	strh r1, [r3, #8]
	ldrh r1, [r3, #0xa]
	bic r1, r1, #3
	orr r1, r1, #2
	strh r1, [r3, #0xa]
	ldrh r1, [r3, #0xc]
	bic r1, r1, #3
	orr r1, r1, #1
	strh r1, [r3, #0xc]
	ldrh ip, [r3, #0xe]
	ldr r1, _0215631C // =VRAMSystem__VRAM_BG
	mov r2, #0x10000
	bic ip, ip, #3
	strh ip, [r3, #0xe]
	ldr ip, [r3]
	ldr r1, [r1]
	bic ip, ip, #0x1f00
	orr ip, ip, #0x1500
	str ip, [r3]
	bl MIi_CpuClear16
	ldr r2, _02156320 // =renderCoreGFXControlB
	mov r1, #0x10
	ldr r0, _02156324 // =0x0400106C
	strh r1, [r2, #0x58]
	bl GXx_SetMasterBrightness_
	ldr r1, _02156328 // =0x04001000
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	str r0, [r1]
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156308: .word 0x00100010
_0215630C: .word 0x04000304
_02156310: .word 0xFFFFFDF1
_02156314: .word renderCurrentDisplay
_02156318: .word renderCoreGFXControlA
_0215631C: .word VRAMSystem__VRAM_BG
_02156320: .word renderCoreGFXControlB
_02156324: .word 0x0400106C
_02156328: .word 0x04001000
	arm_func_end TitleScreen__Func_215619C

	arm_func_start TitleScreen__LoadAssets
TitleScreen__LoadAssets: // 0x0215632C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _02156410 // =aNarcDmtiLz7Nar
	mov r1, #0
	bl FSRequestFileSync
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	str r0, [r5]
	mov r1, r0
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	ldr r0, _02156414 // =aNarcDmopPldmLz_0
	mov r1, #0
	bl FSRequestFileSync
	mov r4, r0
	ldr r0, [r4]
	mov r0, r0, lsr #8
	bl _AllocTailHEAP_USER
	str r0, [r5, #4]
	ldr r1, [r5, #4]
	mov r0, r4
	bl RenderCore_CPUCopyCompressed
	mov r0, r4
	bl _FreeHEAP_USER
	ldr r0, [r5, #4]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	str r0, [r5, #8]
	ldr r0, [r5, #4]
	mov r1, #2
	bl FileUnknown__GetAOUFile
	str r0, [r5, #0xc]
	ldr r0, [r5, #4]
	mov r1, #3
	bl FileUnknown__GetAOUFile
	str r0, [r5, #0x10]
	ldr r0, [r5, #4]
	mov r1, #4
	bl FileUnknown__GetAOUFile
	str r0, [r5, #0x14]
	ldr r0, [r5, #4]
	mov r1, #5
	bl FileUnknown__GetAOUFile
	str r0, [r5, #0x1c]
	ldr r0, [r5, #4]
	mov r1, #6
	bl FileUnknown__GetAOUFile
	str r0, [r5, #0x20]
	ldr r0, [r5, #4]
	mov r1, #0xc
	bl FileUnknown__GetAOUFile
	str r0, [r5, #0x24]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_02156410: .word aNarcDmtiLz7Nar
_02156414: .word aNarcDmopPldmLz_0
	arm_func_end TitleScreen__LoadAssets

	arm_func_start TitleScreen__Func_2156418
TitleScreen__Func_2156418: // 0x02156418
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4]
	bl _FreeHEAP_USER
	ldr r0, [r4, #4]
	bl _FreeHEAP_USER
	ldmia sp!, {r4, pc}
	arm_func_end TitleScreen__Func_2156418

	arm_func_start TitleScreen__Func_2156434
TitleScreen__Func_2156434: // 0x02156434
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r5, r0
	add r4, r5, #8
	ldr r6, [r4, #0x1c]
	ldr r1, _0215669C // =0x001FFFFE
	mov r0, r6
	bl LoadDrawState
	mov r0, r6
	add r1, r4, #0x80
	bl GetDrawStateCameraView
	mov r0, r6
	add r1, r4, #0x80
	bl GetDrawStateCameraProjection
	ldr ip, [r4, #0x90]
	mov r1, #0
	mov r2, ip, asr #0x1f
	mov r0, #0x500
	umull r6, r3, ip, r0
	mla r3, ip, r1, r3
	mla r3, r2, r0, r3
	adds r1, r6, #0x800
	adc r0, r3, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, ip, r1
	str r0, [r4, #0xd0]
	ldr r5, [r5, #8]
	mov r0, r5
	bl NNS_G3dResDefaultSetup
	add r0, r4, #0x218
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	str r2, [sp]
	add r0, r4, #0x218
	mov r1, r5
	mov r3, r2
	bl AnimatorMDL__SetResource
	add r0, r4, #0x35c
	mov r1, #0
	bl AnimatorMDL__Init
	mov r1, r5
	mov r3, #0
	str r3, [sp]
	add r0, r4, #0x35c
	mov r2, #1
	bl AnimatorMDL__SetResource
	ldr r6, [r4, #4]
	mov r0, r6
	bl NNS_G3dResDefaultSetup
	add r0, r4, #0xd4
	mov r1, #0
	bl AnimatorMDL__Init
	mov r2, #0
	str r2, [sp]
	add r0, r4, #0xd4
	mov r1, r6
	mov r3, r2
	bl AnimatorMDL__SetResource
	add r0, r4, #0x4a0
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	str r3, [sp]
	add r0, r4, #0x4a0
	mov r1, r6
	mov r2, #1
	bl AnimatorMDL__SetResource
	add r5, r4, #0x1e4
	add r0, r5, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	mov r1, r6
	add r0, r5, #0x400
	mov r2, #2
	str r3, [sp]
	bl AnimatorMDL__SetResource
	add r5, r4, #0x328
	add r0, r5, #0x400
	mov r1, #0
	bl AnimatorMDL__Init
	mov r3, #0
	mov r1, r6
	add r0, r5, #0x400
	mov r2, #3
	str r3, [sp]
	bl AnimatorMDL__SetResource
	mov r7, #0
	add r8, r4, #0xd4
	mov r6, r7
	mov r5, #1
_021565A8:
	str r6, [sp]
	str r5, [sp, #4]
	ldr r2, [r4, #8]
	mov r0, r8
	mov r1, r6
	add r3, r7, #0x31
	bl TitleScreen__Func_21568B8
	add r7, r7, #1
	cmp r7, #6
	add r8, r8, #0x144
	blt _021565A8
	mov r0, #0
	str r0, [sp]
	mov r1, #1
	str r1, [sp, #4]
	add r0, r4, #0x328
	ldr r2, [r4, #0xc]
	add r0, r0, #0x400
	mov r3, #5
	bl TitleScreen__Func_21568B8
	mov r0, #0
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r4, #0x14]
	add r0, r4, #0x218
	mov r1, #3
	mov r3, #0xc
	bl TitleScreen__Func_21568B8
	mov r0, #0
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	ldr r2, [r4, #0x18]
	add r0, r4, #0x218
	mov r1, #4
	mov r3, #0x11
	bl TitleScreen__Func_21568B8
	mov r0, #4
	strb r0, [r4, #0xde]
	mov r0, #3
	str r0, [sp]
	ldr r1, _021566A0 // =TitleScreen__Func_215690C
	add r0, r4, #0x164
	mov r2, #0
	mov r3, #6
	bl NNS_G3dRenderObjSetCallBack
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x168]
	ldr r1, _021566A4 // =aNodeCamera_ovl04
	mov r2, #0x1e
	bl TitleScreen__Func_21569C0
	mov r3, #0
	str r3, [sp]
	ldr r0, [r4, #0x168]
	ldr r1, _021566A8 // =aNodeTarget_ovl04
	mov r2, #0x1d
	bl TitleScreen__Func_21569C0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0215669C: .word 0x001FFFFE
_021566A0: .word TitleScreen__Func_215690C
_021566A4: .word aNodeCamera_ovl04
_021566A8: .word aNodeTarget_ovl04
	arm_func_end TitleScreen__Func_2156434

	arm_func_start TitleScreen__Func_21566AC
TitleScreen__Func_21566AC: // 0x021566AC
	stmdb sp!, {r4, r5, r6, lr}
	add r5, r0, #8
	add r6, r5, #0xd4
	mov r4, #0
_021566BC:
	mov r0, r6
	bl AnimatorMDL__Release
	add r4, r4, #1
	cmp r4, #6
	add r6, r6, #0x144
	blt _021566BC
	mov r4, #0
_021566D8:
	ldr r0, [r5, r4, lsl #2]
	bl NNS_G3dResDefaultRelease
	add r4, r4, #1
	cmp r4, #2
	blt _021566D8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end TitleScreen__Func_21566AC

	arm_func_start TitleScreen__Func_21566F0
TitleScreen__Func_21566F0: // 0x021566F0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r0
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02156734
_02156710: // jump table
	b _02156728 // case 0
	b _02156728 // case 1
	b _02156728 // case 2
	b _02156728 // case 3
	b _02156728 // case 4
	b _02156728 // case 5
_02156728:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _02156738
_02156734:
	mov r0, #1
_02156738:
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02156780
_02156744: // jump table
	b _0215675C // case 0
	b _02156770 // case 1
	b _02156770 // case 2
	b _02156770 // case 3
	b _02156770 // case 4
	b _02156770 // case 5
_0215675C:
	ldr r0, [r4]
	mov r1, #0
	bl FileUnknown__GetAOUFile
	mov r5, r0
	b _02156780
_02156770:
	ldr r0, [r4]
	mov r1, #1
	bl FileUnknown__GetAOUFile
	mov r5, r0
_02156780:
	mov r1, #2
	add r0, r4, #0x84
	str r1, [sp]
	mov r2, #0x20
	mov r1, r5
	str r2, [sp, #4]
	mov ip, #0x18
	add r0, r0, #0x800
	mov r2, #0x28
	mov r3, #0
	str ip, [sp, #8]
	bl InitBackground
	add r0, r4, #0x84
	add r0, r0, #0x800
	bl DrawBackground
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end TitleScreen__Func_21566F0

	arm_func_start TitleScreen__Func_21567C4
TitleScreen__Func_21567C4: // 0x021567C4
	bx lr
	arm_func_end TitleScreen__Func_21567C4

	arm_func_start TitleScreen__Func_21567C8
TitleScreen__Func_21567C8: // 0x021567C8
	stmdb sp!, {r3, lr}
	mov r0, #1
	bl ClearTaskScope
	mov r0, #0
	bl ClearTaskScope
	ldmia sp!, {r3, pc}
	arm_func_end TitleScreen__Func_21567C8

	arm_func_start TitleScreen__Func_21567E0
TitleScreen__Func_21567E0: // 0x021567E0
	stmdb sp!, {r4, lr}
	movs r4, r0
	beq _02156804
	cmp r4, #1
	bne _02156804
	ldr r1, _02156814 // =gameState
	mov r0, #0
	strb r0, [r1, #0xdc]
	bl SaveGame__Func_205B9F0
_02156804:
	mov r0, r4
	bl RequestSysEventChange
	bl NextSysEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156814: .word gameState
	arm_func_end TitleScreen__Func_21567E0

	arm_func_start TitleScreen__Func_2156818
TitleScreen__Func_2156818: // 0x02156818
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	bl Camera3D__GetWork
	mov r4, r0
	bl Camera3D__GetWork
	mov r1, #0x10000
	rsb r1, r1, #0
	cmp r5, r1
	movlt r5, r1
	blt _02156848
	cmp r5, #0x10000
	movgt r5, #0x10000
_02156848:
	mov r1, r5, lsl #4
	mov r1, r1, asr #0x10
	strh r1, [r4, #0x58]
	strh r1, [r0, #0xb4]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TitleScreen__Func_2156818

	arm_func_start TitleScreen__Func_215685C
TitleScreen__Func_215685C: // 0x0215685C
	stmdb sp!, {r3, lr}
	ldr r1, _021568B0 // =padInput
	ldrh r1, [r1, #4]
	tst r1, #9
	movne r0, #1
	ldmneia sp!, {r3, pc}
	ldr r1, [r0, #0x880]
	cmp r1, #0
	subne r1, r1, #1
	strne r1, [r0, #0x880]
	bne _021568A8
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _021568A8
	ldr r0, _021568B4 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #4
	movne r0, #1
	ldmneia sp!, {r3, pc}
_021568A8:
	mov r0, #0
	ldmia sp!, {r3, pc}
	.align 2, 0
_021568B0: .word padInput
_021568B4: .word touchInput
	arm_func_end TitleScreen__Func_215685C

	arm_func_start TitleScreen__Func_21568B8
TitleScreen__Func_21568B8: // 0x021568B8
	stmdb sp!, {r3, r4, r5, lr}
	ldr ip, [sp, #0x10]
	mov r5, r0
	mov r4, r1
	str ip, [sp]
	bl AnimatorMDL__SetAnimation
	ldr r0, [sp, #0x14]
	add r2, r5, #0x10c
	cmp r0, #0
	moveq r1, r4, lsl #1
	ldreqh r0, [r2, r1]
	biceq r0, r0, #2
	beq _021568F8
	mov r1, r4, lsl #1
	ldrh r0, [r2, r1]
	orr r0, r0, #2
_021568F8:
	strh r0, [r2, r1]
	add r0, r5, r4, lsl #2
	mov r1, #0x1000
	str r1, [r0, #0x11c]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TitleScreen__Func_21568B8

	arm_func_start TitleScreen__Func_215690C
TitleScreen__Func_215690C: // 0x0215690C
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #4
	ldr r1, _021569B8 // =_02162F8C
	ldr r2, [r0, #4]
	ldrh r5, [r1]
	ldr lr, [r2, #4]
	ldr r3, _021569BC // =_02162E8C
	cmp r5, #0
	mov ip, #0
	bls _02156978
	mvn r2, #0
_02156938:
	ldr r1, [r3, ip, lsl #4]
	add r4, r3, ip, lsl #4
	cmp r1, lr
	bne _02156964
	ldr r1, [r0, #8]
	tst r1, #0x10
	ldrneb r6, [r0, #0xae]
	ldrh r1, [r4, #4]
	moveq r6, r2
	cmp r1, r6
	beq _02156978
_02156964:
	add r1, ip, #1
	mov r1, r1, lsl #0x10
	cmp r5, r1, lsr #16
	mov ip, r1, lsr #0x10
	bhi _02156938
_02156978:
	cmp ip, r5
	addeq sp, sp, #4
	ldmeqia sp!, {r3, r4, r5, r6, pc}
	ldr r2, [r4, #8]
	cmp r2, #0
	beq _02156998
	ldr r1, [r4, #0xc]
	blx r2
_02156998:
	ldrh r3, [r4, #6]
	add r1, sp, #0
	mov r0, #0x13
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_021569B8: .word _02162F8C
_021569BC: .word _02162E8C
	arm_func_end TitleScreen__Func_215690C

	arm_func_start TitleScreen__Func_21569C0
TitleScreen__Func_21569C0: // 0x021569C0
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr ip, _02156A08 // =_02162F8C
	ldr r6, _02156A0C // =_02162E8C
	ldrh r7, [ip]
	mov r5, r0
	mov r4, r2
	add r2, r7, #1
	strh r2, [ip]
	mov r9, r3
	add r8, r6, r7, lsl #4
	bl TitleScreen__Func_2156A10
	str r5, [r6, r7, lsl #4]
	strh r0, [r8, #4]
	strh r4, [r8, #6]
	ldr r0, [sp, #0x20]
	str r9, [r8, #8]
	str r0, [r8, #0xc]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_02156A08: .word _02162F8C
_02156A0C: .word _02162E8C
	arm_func_end TitleScreen__Func_21569C0

	arm_func_start TitleScreen__Func_2156A10
TitleScreen__Func_2156A10: // 0x02156A10
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x10
	mov r5, r0
	mov r4, r1
	add r0, sp, #0
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	add r0, sp, #0
	mov r1, r4
	bl STD_CopyString
	add r1, sp, #0
	add r0, r5, #0x40
	bl NNS_G3dGetResDictIdxByName
	add sp, sp, #0x10
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TitleScreen__Func_2156A10

	arm_func_start TitleScreen__Func_2156A50
TitleScreen__Func_2156A50: // 0x02156A50
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #8
	mov r4, r1
	mov r5, r0
	mov r3, #2
	add r1, sp, #4
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
	add r1, sp, #0
	mov r0, #0x14
	mov r2, #1
	str r5, [sp]
	bl NNS_G3dGeBufferOP_N
	mov r0, r4
	mov r1, #0
	bl NNS_G3dGetCurrentMtx
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TitleScreen__Func_2156A50

	arm_func_start TitleScreen__Destructor
TitleScreen__Destructor: // 0x02156AA0
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	bl StopSysStream
	bl ReleaseSysSound
	bl StopSamplingTouchInput
	mov r0, r4
	bl TitleScreen__Func_21567C4
	mov r0, r4
	bl TitleScreen__Func_21566AC
	mov r0, r4
	bl TitleScreen__Func_2156418
	ldmia sp!, {r4, pc}
	arm_func_end TitleScreen__Destructor

	arm_func_start TitleScreen__Main
TitleScreen__Main: // 0x02156AD4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl Camera3D__Create
	mov r0, #0x10000
	str r0, [r4, #0x878]
	bl TitleScreen__Func_2156818
	mov r2, #5
	mov r0, #2
	mov r1, #1
	str r2, [r4, #0x880]
	bl PlaySysStream
	bl Camera3D__GetWork
	mov r1, #0
	strb r1, [r0, #0x6d]
	strb r1, [r0, #0x6c]
	strb r1, [r0, #0x71]
	strb r1, [r0, #0x70]
	strb r1, [r0, #0x74]
	mov r1, #0x3b
	strb r1, [r0, #0x76]
	mov r1, #1
	str r1, [r0, #0x78]
	ldr r0, _02156B3C // =TitleScreen__Main_2156B40
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156B3C: .word TitleScreen__Main_2156B40
	arm_func_end TitleScreen__Main

	arm_func_start TitleScreen__Main_2156B40
TitleScreen__Main_2156B40: // 0x02156B40
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r1, [r4, #0x878]
	sub r1, r1, #0x400
	str r1, [r4, #0x878]
	cmp r1, #0
	ble _02156B6C
	bl TitleScreen__Func_215685C
	cmp r0, #0
	beq _02156B90
_02156B6C:
	mov r0, #0
	str r0, [r4, #0x878]
	ldr r1, [r4, #0x874]
	ldr r0, _02156B9C // =TitleScreen__Main_2156BA0
	orr r1, r1, #4
	str r1, [r4, #0x874]
	mov r1, #0x4b0
	str r1, [r4, #0x87c]
	bl SetCurrentTaskMainEvent
_02156B90:
	ldr r0, [r4, #0x878]
	bl TitleScreen__Func_2156818
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156B9C: .word TitleScreen__Main_2156BA0
	arm_func_end TitleScreen__Main_2156B40

	arm_func_start TitleScreen__Main_2156BA0
TitleScreen__Main_2156BA0: // 0x02156BA0
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x87c]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #0x87c]
	bne _02156BE0
	ldr r0, [r4, #0x874]
	tst r0, #1
	bne _02156BE0
	orr r1, r0, #0x40
	orr r1, r1, #0x80
	ldr r0, _02156C0C // =TitleScreen__Main_2156C10
	str r1, [r4, #0x874]
	bl SetCurrentTaskMainEvent
_02156BE0:
	ldr r0, [r4, #0x874]
	tst r0, #2
	beq _02156BF4
	ldr r0, _02156C0C // =TitleScreen__Main_2156C10
	bl SetCurrentTaskMainEvent
_02156BF4:
	ldr r0, [r4, #0x874]
	tst r0, #8
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl TitleScreenPressStart__Create
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156C0C: .word TitleScreen__Main_2156C10
	arm_func_end TitleScreen__Main_2156BA0

	arm_func_start TitleScreen__Main_2156C10
TitleScreen__Main_2156C10: // 0x02156C10
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #0
	str r1, [r0, #0x878]
	mov r0, r1
	bl TitleScreen__Func_2156818
	ldr r0, _02156C34 // =TitleScreen__Main_2156C38
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156C34: .word TitleScreen__Main_2156C38
	arm_func_end TitleScreen__Main_2156C10

	arm_func_start TitleScreen__Main_2156C38
TitleScreen__Main_2156C38: // 0x02156C38
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0x874]
	tst r0, #0x40
	ldr r0, [r4, #0x878]
	addne r0, r0, #0x800
	subeq r0, r0, #0x800
	str r0, [r4, #0x878]
	mov r0, #0x10000
	ldr r1, [r4, #0x878]
	rsb r0, r0, #0
	cmp r1, r0
	ble _02156C78
	cmp r1, #0x10000
	blt _02156C94
_02156C78:
	ldr r0, [r4, #0x874]
	tst r0, #0x40
	mov r0, #0x10000
	rsbeq r0, r0, #0
	str r0, [r4, #0x878]
	ldr r0, _02156CA0 // =TitleScreen__Main_2156CA4
	bl SetCurrentTaskMainEvent
_02156C94:
	ldr r0, [r4, #0x878]
	bl TitleScreen__Func_2156818
	ldmia sp!, {r4, pc}
	.align 2, 0
_02156CA0: .word TitleScreen__Main_2156CA4
	arm_func_end TitleScreen__Main_2156C38

	arm_func_start TitleScreen__Main_2156CA4
TitleScreen__Main_2156CA4: // 0x02156CA4
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl Camera3D__Destroy
	ldr r0, [r4, #0x874]
	tst r0, #0x40
	beq _02156CCC
	mov r0, #0
	bl TitleScreen__Func_21567E0
	b _02156CD4
_02156CCC:
	mov r0, #1
	bl TitleScreen__Func_21567E0
_02156CD4:
	bl TitleScreen__Func_21567C8
	ldmia sp!, {r4, pc}
	arm_func_end TitleScreen__Main_2156CA4

	arm_func_start TitleScreenBackgroundView__Create
TitleScreenBackgroundView__Create: // 0x02156CDC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r1, #0x3000
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	ldr r0, _02156D38 // =TitleScreenBackgroundView__Main
	ldr r1, _02156D3C // =TitleScreenBackgroundView__Destructor
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #4
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #4
	bl MIi_CpuClear16
	str r5, [r4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02156D38: .word TitleScreenBackgroundView__Main
_02156D3C: .word TitleScreenBackgroundView__Destructor
	arm_func_end TitleScreenBackgroundView__Create

	arm_func_start TitleScreenBackgroundView__Destructor
TitleScreenBackgroundView__Destructor: // 0x02156D40
	bx lr
	arm_func_end TitleScreenBackgroundView__Destructor

	arm_func_start TitleScreenBackgroundView__Main
TitleScreenBackgroundView__Main: // 0x02156D44
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r0, _02156D58 // =TitleScreenBackgroundView__Main_2156D5C
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156D58: .word TitleScreenBackgroundView__Main_2156D5C
	arm_func_end TitleScreenBackgroundView__Main

	arm_func_start TitleScreenBackgroundView__Main_2156D5C
TitleScreenBackgroundView__Main_2156D5C: // 0x02156D5C
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	ldr r4, [r0]
	add r0, r4, #0xdc
	bl AnimatorMDL__ProcessAnimation
	add r0, r4, #0xdc
	bl AnimatorMDL__Draw
	add r1, r4, #0x28
	mov r0, #0x1e
	bl TitleScreen__Func_2156A50
	add r1, r4, #0x58
	mov r0, #0x1d
	bl TitleScreen__Func_2156A50
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldr r1, [r4, #0xd8]
	addne r0, r4, #0x4c
	rsbne r1, r1, #0
	addeq r0, r4, #0x4c
	str r1, [r4, #0xa0]
	add r3, r4, #0xa8
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0x7c
	add r3, r4, #0xb4
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add r0, r4, #0x88
	bl Camera3D__LoadState
	add r5, r4, #0x220
	mov r4, #1
_02156DD8:
	ldr r0, [r5, #4]
	tst r0, #1
	bne _02156DF4
	mov r0, r5
	bl AnimatorMDL__ProcessAnimation
	mov r0, r5
	bl AnimatorMDL__Draw
_02156DF4:
	add r4, r4, #1
	cmp r4, #6
	add r5, r5, #0x144
	blt _02156DD8
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end TitleScreenBackgroundView__Main_2156D5C

	arm_func_start TitleScreenCopyrightIcon__Create
TitleScreenCopyrightIcon__Create: // 0x02156E08
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	mov r1, #0x3000
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	ldr r0, _02156F90 // =TitleScreenCopyrightIcon__Main
	ldr r1, _02156F94 // =TitleScreenCopyrightIcon__Destructor
	mov r3, r2
	str r4, [sp, #4]
	mov r4, #0xd0
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0xd0
	bl MIi_CpuClear16
	str r5, [r4]
	ldr r0, [r5]
	mov r1, #2
	bl FileUnknown__GetAOUFile
	mov r6, r0
	bl Sprite__GetSpriteSize2
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r6
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r3, _02156F98 // =0x05000200
	add r0, r4, #8
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r3, #0x800
	bl AnimatorSprite__Init
	mov r0, #0
	strh r0, [r4, #0x58]
	strh r0, [r4, #0x10]
	mov r0, #0xb0
	strh r0, [r4, #0x12]
	ldr r0, [r5]
	mov r1, #3
	bl FileUnknown__GetAOUFile
	mov r5, r0
	bl Sprite__GetSpriteSize2
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r5
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r3, _02156F98 // =0x05000200
	add r0, r4, #0x6c
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	mov r3, #0x800
	bl AnimatorSprite__Init
	mov r0, #1
	strh r0, [r4, #0xbc]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02156F58
_02156F34: // jump table
	b _02156F4C // case 0
	b _02156F4C // case 1
	b _02156F4C // case 2
	b _02156F4C // case 3
	b _02156F4C // case 4
	b _02156F4C // case 5
_02156F4C:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _02156F5C
_02156F58:
	mov r0, #1
_02156F5C:
	cmp r0, #0
	movne r0, #0xe6
	strneh r0, [r4, #0x74]
	movne r0, #0x73
	addne sp, sp, #0x1c
	strneh r0, [r4, #0x76]
	ldmneia sp!, {r3, r4, r5, r6, pc}
	mov r0, #0xe8
	strh r0, [r4, #0x74]
	mov r0, #0x67
	strh r0, [r4, #0x76]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_02156F90: .word TitleScreenCopyrightIcon__Main
_02156F94: .word TitleScreenCopyrightIcon__Destructor
_02156F98: .word 0x05000200
	arm_func_end TitleScreenCopyrightIcon__Create

	arm_func_start TitleScreenCopyrightIcon__Destructor
TitleScreenCopyrightIcon__Destructor: // 0x02156F9C
	stmdb sp!, {r4, lr}
	bl GetTaskWork_
	mov r4, r0
	add r0, r4, #8
	bl AnimatorSprite__Release
	add r0, r4, #0x6c
	bl AnimatorSprite__Release
	ldmia sp!, {r4, pc}
	arm_func_end TitleScreenCopyrightIcon__Destructor

	arm_func_start TitleScreenCopyrightIcon__Main
TitleScreenCopyrightIcon__Main: // 0x02156FBC
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	mov r1, #0x3c
	str r1, [r0, #4]
	ldr r2, [r0]
	ldr r1, [r2, #0x874]
	orr r1, r1, #0x10
	str r1, [r2, #0x874]
	ldr r2, [r0]
	ldr r0, _02156FF8 // =TitleScreenCopyrightIcon__Main_2156FFC
	ldr r1, [r2, #0x874]
	orr r1, r1, #0x20
	str r1, [r2, #0x874]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r3, pc}
	.align 2, 0
_02156FF8: .word TitleScreenCopyrightIcon__Main_2156FFC
	arm_func_end TitleScreenCopyrightIcon__Main

	arm_func_start TitleScreenCopyrightIcon__Main_2156FFC
TitleScreenCopyrightIcon__Main_2156FFC: // 0x02156FFC
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4]
	ldr r0, [r0, #0x874]
	tst r0, #0x10
	beq _0215703C
	mov r1, #0
	mov r2, r1
	add r0, r4, #8
	bl AnimatorSprite__ProcessAnimation
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _0215703C
	add r0, r4, #8
	bl AnimatorSprite__DrawFrame
_0215703C:
	ldr r0, [r4]
	ldr r0, [r0, #0x874]
	tst r0, #0x20
	beq _02157070
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x6c
	bl AnimatorSprite__ProcessAnimation
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _02157070
	add r0, r4, #0x6c
	bl AnimatorSprite__DrawFrame
_02157070:
	ldr r2, [r4]
	ldr r1, [r2, #0x874]
	tst r1, #4
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #4]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #4]
	ldmneia sp!, {r4, pc}
	ldr r0, _021570A8 // =TitleScreenCopyrightIcon__Main_21570AC
	orr r1, r1, #8
	str r1, [r2, #0x874]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_021570A8: .word TitleScreenCopyrightIcon__Main_21570AC
	arm_func_end TitleScreenCopyrightIcon__Main_2156FFC

	arm_func_start TitleScreenCopyrightIcon__Main_21570AC
TitleScreenCopyrightIcon__Main_21570AC: // 0x021570AC
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r0, r4, #8
	bl AnimatorSprite__ProcessAnimation
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _021570DC
	add r0, r4, #8
	bl AnimatorSprite__DrawFrame
_021570DC:
	mov r1, #0
	mov r2, r1
	add r0, r4, #0x6c
	bl AnimatorSprite__ProcessAnimation
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x6c
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end TitleScreenCopyrightIcon__Main_21570AC

	arm_func_start TitleScreenPressStart__Create
TitleScreenPressStart__Create: // 0x02157104
	stmdb sp!, {r3, r4, r5, r6, lr}
	sub sp, sp, #0x1c
	mov r1, #0x3000
	mov r5, r0
	mov r2, #0
	str r1, [sp]
	mov r4, #1
	str r4, [sp, #4]
	mov r4, #0x6c
	ldr r0, _0215721C // =TitleScreenPressStart__Main
	ldr r1, _02157220 // =TitleScreenPressStart__Destructor
	mov r3, r2
	str r4, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	mov r1, r4
	mov r0, #0
	mov r2, #0x6c
	bl MIi_CpuClear16
	str r5, [r4]
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _02157190
_0215716C: // jump table
	b _02157184 // case 0
	b _02157184 // case 1
	b _02157184 // case 2
	b _02157184 // case 3
	b _02157184 // case 4
	b _02157184 // case 5
_02157184:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	b _02157194
_02157190:
	mov r0, #1
_02157194:
	add r0, r0, #4
	mov r1, r0, lsl #0x10
	ldr r0, [r5]
	mov r1, r1, lsr #0x10
	bl FileUnknown__GetAOUFile
	mov r6, r0
	bl Sprite__GetSpriteSize2
	mov r1, r0
	mov r0, #0
	bl VRAMSystem__AllocSpriteVram
	mov r1, r6
	mov r2, #0
	str r2, [sp]
	str r2, [sp, #4]
	str r0, [sp, #8]
	str r2, [sp, #0xc]
	ldr r3, _02157224 // =0x05000200
	add r0, r4, #8
	str r3, [sp, #0x10]
	str r2, [sp, #0x14]
	str r2, [sp, #0x18]
	ldr r3, _02157228 // =0x00000804
	bl AnimatorSprite__Init
	mov r0, #2
	strh r0, [r4, #0x58]
	mov r0, #0x80
	strh r0, [r4, #0x10]
	mov r0, #0x58
	strh r0, [r4, #0x12]
	ldr r0, [r5, #0x874]
	bic r0, r0, #8
	str r0, [r5, #0x874]
	add sp, sp, #0x1c
	ldmia sp!, {r3, r4, r5, r6, pc}
	.align 2, 0
_0215721C: .word TitleScreenPressStart__Main
_02157220: .word TitleScreenPressStart__Destructor
_02157224: .word 0x05000200
_02157228: .word 0x00000804
	arm_func_end TitleScreenPressStart__Create

	arm_func_start TitleScreenPressStart__Destructor
TitleScreenPressStart__Destructor: // 0x0215722C
	stmdb sp!, {r3, lr}
	bl GetTaskWork_
	add r0, r0, #8
	bl AnimatorSprite__Release
	ldmia sp!, {r3, pc}
	arm_func_end TitleScreenPressStart__Destructor

	arm_func_start TitleScreenPressStart__Main
TitleScreenPressStart__Main: // 0x02157240
	ldr ip, _0215724C // =SetCurrentTaskMainEvent
	ldr r0, _02157250 // =TitleScreenPressStart__Main_2157254
	bx ip
	.align 2, 0
_0215724C: .word SetCurrentTaskMainEvent
_02157250: .word TitleScreenPressStart__Main_2157254
	arm_func_end TitleScreenPressStart__Main

	arm_func_start TitleScreenPressStart__Main_2157254
TitleScreenPressStart__Main_2157254: // 0x02157254
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r0, r4, #8
	bl AnimatorSprite__ProcessAnimation
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02157284
	add r0, r4, #8
	bl AnimatorSprite__DrawFrame
_02157284:
	ldr r0, [r4]
	bl TitleScreen__Func_215685C
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4]
	ldr r0, [r0, #0x874]
	tst r0, #0x80
	ldmneia sp!, {r4, pc}
	add r0, r4, #8
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	mov r0, #0x1e
	str r0, [r4, #4]
	ldr r2, [r4]
	mov r0, #0
	ldr r1, [r2, #0x874]
	orr r1, r1, #1
	str r1, [r2, #0x874]
	bl PlaySysSfx
	mov r0, #0x3c
	bl FadeSysStream
	ldr r0, _021572E4 // =TitleScreenPressStart__Main_21572E8
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_021572E4: .word TitleScreenPressStart__Main_21572E8
	arm_func_end TitleScreenPressStart__Main_2157254

	arm_func_start TitleScreenPressStart__Main_21572E8
TitleScreenPressStart__Main_21572E8: // 0x021572E8
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r0, r4, #8
	bl AnimatorSprite__ProcessAnimation
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02157318
	add r0, r4, #8
	bl AnimatorSprite__DrawFrame
_02157318:
	ldr r0, [r4, #4]
	cmp r0, #0
	subne r0, r0, #1
	strne r0, [r4, #4]
	ldmneia sp!, {r4, pc}
	ldr r2, [r4]
	ldr r0, _02157348 // =TitleScreenPressStart__Main_215734C
	ldr r1, [r2, #0x874]
	orr r1, r1, #2
	str r1, [r2, #0x874]
	bl SetCurrentTaskMainEvent
	ldmia sp!, {r4, pc}
	.align 2, 0
_02157348: .word TitleScreenPressStart__Main_215734C
	arm_func_end TitleScreenPressStart__Main_21572E8

	arm_func_start TitleScreenPressStart__Main_215734C
TitleScreenPressStart__Main_215734C: // 0x0215734C
	stmdb sp!, {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	mov r1, #0
	mov r2, r1
	add r0, r4, #8
	bl AnimatorSprite__ProcessAnimation
	bl Camera3D__UseEngineA
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	add r0, r4, #8
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end TitleScreenPressStart__Main_215734C

    .data

aNarcDmtiLz7Nar: // 0x02162A38
	.asciz "/narc/dmti_lz7.narc"
	.align 4

aNarcDmopPldmLz_0: // 0x02162A4C
	.asciz "/narc/dmop_pldm_lz7.narc"
	.align 4

aNodeCamera_ovl04: // 0x02162A68
	.asciz "node_camera"
	.align 4

aNodeTarget_ovl04: // 0x02162A74
	.asciz "node_target"
	.align 4