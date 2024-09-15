	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start NNS_G3dReleaseMdlSet
NNS_G3dReleaseMdlSet: // 0x020CF830
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	ldrb r0, [r6, #9]
	mov r5, #0
	cmp r0, #0
	addls sp, sp, #4
	ldmlsia sp!, {r4, r5, r6, r7, pc}
	add r4, r6, #8
_020CF854:
	ldrh r0, [r6, #0xe]
	ldrh r1, [r4, r0]
	add r0, r4, r0
	mla r0, r1, r5, r0
	ldr r0, [r0, #4]
	add r7, r6, r0
	mov r0, r7
	bl NNS_G3dReleaseMdlTex
	mov r0, r7
	bl NNS_G3dReleaseMdlPltt
	ldrb r0, [r6, #9]
	add r5, r5, #1
	cmp r5, r0
	blo _020CF854
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end NNS_G3dReleaseMdlSet

	arm_func_start NNS_G3dBindMdlSet
NNS_G3dBindMdlSet: // 0x020CF894
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	ldrb r0, [r8, #9]
	mov r7, r1
	mov r5, #1
	cmp r0, #0
	mov r6, #0
	bls _020CF904
	add r4, r8, #8
_020CF8BC:
	ldrh r0, [r8, #0xe]
	mov r1, r7
	ldrh r2, [r4, r0]
	add r0, r4, r0
	mla r0, r2, r6, r0
	ldr r0, [r0, #4]
	add r9, r8, r0
	mov r0, r9
	bl NNS_G3dBindMdlTex
	and r5, r5, r0
	mov r0, r9
	mov r1, r7
	bl NNS_G3dBindMdlPltt
	ldrb r1, [r8, #9]
	add r6, r6, #1
	and r5, r5, r0
	cmp r6, r1
	blo _020CF8BC
_020CF904:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end NNS_G3dBindMdlSet

	arm_func_start NNS_G3dReleaseMdlPltt
NNS_G3dReleaseMdlPltt: // 0x020CF910
	ldr r2, [r0, #8]
	mov r1, #0
	add r2, r0, r2
	ldrh r0, [r2, #2]
	add ip, r2, r0
	ldrb r0, [ip, #1]
	cmp r0, #0
	bxls lr
_020CF930:
	ldrh r2, [ip, #6]
	ldrh r0, [ip, r2]
	add r2, ip, r2
	add r2, r2, #4
	mla r3, r0, r1, r2
	ldrb r0, [r3, #3]
	add r1, r1, #1
	ands r2, r0, #1
	bicne r0, r0, #1
	strneb r0, [r3, #3]
	ldrb r0, [ip, #1]
	cmp r1, r0
	blo _020CF930
	bx lr
	arm_func_end NNS_G3dReleaseMdlPltt

	arm_func_start NNS_G3dBindMdlPltt
NNS_G3dBindMdlPltt: // 0x020CF968
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r2, [r0, #8]
	mov r10, r1
	add r9, r0, r2
	ldrh r0, [r9, #2]
	mov r6, #1
	mov r7, #0
	add r8, r9, r0
	ldrb r0, [r8, #1]
	cmp r0, #0
	bls _020CFA0C
	mov r5, r7
	mov r4, r7
_020CF99C:
	ldrh r1, [r8, #6]
	ldrh r0, [r10, #0x34]
	add r2, r8, r1
	ldrh r1, [r2, #2]
	add r0, r10, r0
	add r1, r2, r1
	add r1, r1, r5
	bl NNS_G3dGetResDataByName
	movs r3, r0
	beq _020CF9F4
	ldrh r1, [r8, #6]
	ldrh r0, [r8, r1]
	add r1, r8, r1
	add r1, r1, #4
	mla r1, r0, r7, r1
	ldrb r0, [r1, #3]
	ands r0, r0, #1
	bne _020CF9F8
	mov r0, r9
	mov r2, r10
	bl bindMdlPltt_Internal_
	b _020CF9F8
_020CF9F4:
	mov r6, r4
_020CF9F8:
	ldrb r0, [r8, #1]
	add r7, r7, #1
	add r5, r5, #0x10
	cmp r7, r0
	blo _020CF99C
_020CFA0C:
	mov r0, r6
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end NNS_G3dBindMdlPltt

	arm_func_start bindMdlPltt_Internal_
bindMdlPltt_Internal_: // 0x020CFA14
	stmdb sp!, {r4, r5, r6, lr}
	ldrh r5, [r1]
	ldr r2, [r2, #0x2c]
	ldrh r4, [r3, #2]
	mov r2, r2, lsl #0x10
	add ip, r0, r5
	mov r5, r2, lsr #0x10
	ands r2, r4, #1
	ldrh r4, [r3]
	moveq r3, r5, lsl #0xf
	moveq r5, r3, lsr #0x10
	moveq r2, r4, lsl #0xf
	moveq r4, r2, lsr #0x10
	ldrb r3, [r1, #2]
	mov r2, #0
	cmp r3, #0
	bls _020CFA98
	add r3, r4, r5
	mov r3, r3, lsl #0x10
	add r6, r0, #4
	mov r4, r3, lsr #0x10
_020CFA68:
	ldrh r5, [r0, #0xa]
	ldrb r3, [ip, r2]
	add r2, r2, #1
	ldrh lr, [r6, r5]
	add r5, r6, r5
	mla r3, lr, r3, r5
	ldr r3, [r3, #4]
	add r3, r0, r3
	strh r4, [r3, #0x1c]
	ldrb r3, [r1, #2]
	cmp r2, r3
	blo _020CFA68
_020CFA98:
	ldrb r0, [r1, #3]
	orr r0, r0, #1
	strb r0, [r1, #3]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end bindMdlPltt_Internal_

	arm_func_start NNS_G3dReleaseMdlTex
NNS_G3dReleaseMdlTex: // 0x020CFAA8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, [r0, #8]
	mov r4, #0
	ldrh r1, [r0, r2]
	add r6, r0, r2
	add r5, r6, r1
	ldrb r0, [r5, #1]
	cmp r0, #0
	ldmlsia sp!, {r4, r5, r6, pc}
_020CFACC:
	ldrh r1, [r5, #6]
	ldrh r0, [r5, r1]
	add r1, r5, r1
	add r1, r1, #4
	mla r1, r0, r4, r1
	ldrb r0, [r1, #3]
	ands r0, r0, #1
	beq _020CFAF4
	mov r0, r6
	bl releaseMdlTex_Internal_
_020CFAF4:
	ldrb r0, [r5, #1]
	add r4, r4, #1
	cmp r4, r0
	blo _020CFACC
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_G3dReleaseMdlTex

	arm_func_start NNS_G3dBindMdlTex
NNS_G3dBindMdlTex: // 0x020CFB08
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r2, [r0, #8]
	mov r10, r1
	ldrh r1, [r0, r2]
	add r9, r0, r2
	mov r11, #1
	add r8, r9, r1
	ldrb r0, [r8, #1]
	mov r7, #0
	cmp r0, #0
	bls _020CFBB0
	mov r6, r7
	mov r4, r7
	add r5, r10, #0x3c
_020CFB44:
	ldrh r1, [r8, #6]
	mov r0, r5
	add r2, r8, r1
	ldrh r1, [r2, #2]
	add r1, r2, r1
	add r1, r1, r6
	bl NNS_G3dGetResDataByName
	movs r3, r0
	beq _020CFB98
	ldrh r1, [r8, #6]
	ldrh r0, [r8, r1]
	add r1, r8, r1
	add r1, r1, #4
	mla r1, r0, r7, r1
	ldrb r0, [r1, #3]
	ands r0, r0, #1
	bne _020CFB9C
	mov r0, r9
	mov r2, r10
	bl bindMdlTex_Internal_
	b _020CFB9C
_020CFB98:
	mov r11, r4
_020CFB9C:
	ldrb r0, [r8, #1]
	add r7, r7, #1
	add r6, r6, #0x10
	cmp r7, r0
	blo _020CFB44
_020CFBB0:
	mov r0, r11
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end NNS_G3dBindMdlTex

	arm_func_start releaseMdlTex_Internal_
releaseMdlTex_Internal_: // 0x020CFBBC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldrh r4, [r1]
	ldrb r2, [r1, #2]
	mov r3, #0
	add ip, r0, r4
	cmp r2, #0
	bls _020CFC2C
	add r2, r0, #4
	mov r5, #0x1000
	ldr lr, _020CFC40 // =0xC00F0000
_020CFBE8:
	ldrh r7, [r0, #0xa]
	ldrb r4, [ip, r3]
	add r3, r3, #1
	ldrh r6, [r2, r7]
	add r7, r2, r7
	mla r4, r6, r4, r7
	ldr r4, [r4, #4]
	add r6, r0, r4
	ldr r4, [r6, #0x14]
	and r4, r4, lr
	str r4, [r6, #0x14]
	str r5, [r6, #0x24]
	ldr r4, [r6, #0x24]
	str r4, [r6, #0x28]
	ldrb r4, [r1, #2]
	cmp r3, r4
	blo _020CFBE8
_020CFC2C:
	ldrb r0, [r1, #3]
	bic r0, r0, #1
	strb r0, [r1, #3]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020CFC40: .word 0xC00F0000
	arm_func_end releaseMdlTex_Internal_

	arm_func_start bindMdlTex_Internal_
bindMdlTex_Internal_: // 0x020CFC44
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r11, r1
	mov r9, r3
	ldr r1, [r9]
	mov r10, r0
	and r0, r1, #0x1c000000
	cmp r0, #0x14000000
	ldrh r3, [r11]
	ldrne r1, [r2, #8]
	mov r8, #0
	add r0, r10, r3
	str r0, [sp, #4]
	ldrne r0, _020CFD54 // =0x0000FFFF
	andne r0, r1, r0
	strne r0, [sp]
	ldreq r1, [r2, #0x18]
	ldreq r0, _020CFD54 // =0x0000FFFF
	andeq r0, r1, r0
	streq r0, [sp]
	ldrb r0, [r11, #2]
	cmp r0, #0
	bls _020CFD40
	mov r4, #0x1000
	add r5, r10, #4
_020CFCA8:
	ldrh r6, [r10, #0xa]
	ldr r0, [sp, #4]
	ldr r1, [r9]
	ldrb r2, [r0, r8]
	ldrh r3, [r5, r6]
	ldr r0, [sp]
	add r6, r5, r6
	add r0, r1, r0
	mla r1, r3, r2, r6
	ldr r1, [r1, #4]
	add r6, r10, r1
	ldr r1, [r6, #0x14]
	orr r0, r1, r0
	str r0, [r6, #0x14]
	ldr r3, [r9, #4]
	ldr r0, _020CFD58 // =0x000007FF
	ldrh r1, [r6, #0x20]
	and r2, r3, r0
	and r7, r0, r3, lsr #11
	cmp r2, r1
	moveq r0, r4
	beq _020CFD0C
	mov r0, r2, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Div
_020CFD0C:
	str r0, [r6, #0x24]
	ldrh r1, [r6, #0x22]
	cmp r7, r1
	moveq r0, r4
	beq _020CFD2C
	mov r0, r7, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Div
_020CFD2C:
	str r0, [r6, #0x28]
	ldrb r0, [r11, #2]
	add r8, r8, #1
	cmp r8, r0
	blo _020CFCA8
_020CFD40:
	ldrb r0, [r11, #3]
	orr r0, r0, #1
	strb r0, [r11, #3]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020CFD54: .word 0x0000FFFF
_020CFD58: .word 0x000007FF
	arm_func_end bindMdlTex_Internal_

	arm_func_start NNS_G3dPlttReleasePlttKey
NNS_G3dPlttReleasePlttKey: // 0x020CFD5C
	ldrh r2, [r0, #0x32]
	mov r1, #0
	bic r2, r2, #1
	strh r2, [r0, #0x32]
	ldr r2, [r0, #0x2c]
	str r1, [r0, #0x2c]
	mov r0, r2
	bx lr
	arm_func_end NNS_G3dPlttReleasePlttKey

	arm_func_start NNS_G3dPlttLoad
NNS_G3dPlttLoad: // 0x020CFD7C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r4, r1
	mov r5, r0
	beq _020CFD94
	bl GX_BeginLoadTexPltt
_020CFD94:
	ldrh r2, [r5, #0x30]
	ldr r0, [r5, #0x38]
	ldr r3, [r5, #0x2c]
	ldr r1, _020CFDDC // =0x0000FFFF
	add r0, r5, r0
	and r1, r3, r1
	mov r1, r1, lsl #3
	mov r2, r2, lsl #3
	bl GX_LoadTexPltt
	ldrh r0, [r5, #0x32]
	cmp r4, #0
	addeq sp, sp, #4
	orr r0, r0, #1
	strh r0, [r5, #0x32]
	ldmeqia sp!, {r4, r5, pc}
	bl GX_EndLoadTexPltt
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020CFDDC: .word 0x0000FFFF
	arm_func_end NNS_G3dPlttLoad

	arm_func_start NNS_G3dPlttSetPlttKey
NNS_G3dPlttSetPlttKey: // 0x020CFDE0
	str r1, [r0, #0x2c]
	bx lr
	arm_func_end NNS_G3dPlttSetPlttKey

	arm_func_start NNS_G3dPlttGetRequiredSize
NNS_G3dPlttGetRequiredSize: // 0x020CFDE8
	ldrh r0, [r0, #0x30]
	mov r0, r0, lsl #3
	bx lr
	arm_func_end NNS_G3dPlttGetRequiredSize

	arm_func_start NNS_G3dTexReleaseTexKey
NNS_G3dTexReleaseTexKey: // 0x020CFDF4
	ldrh ip, [r0, #0x10]
	mov r3, #0
	bic ip, ip, #1
	strh ip, [r0, #0x10]
	ldrh ip, [r0, #0x20]
	bic ip, ip, #1
	strh ip, [r0, #0x20]
	ldr ip, [r0, #8]
	str ip, [r1]
	str r3, [r0, #8]
	ldr r1, [r0, #0x18]
	str r1, [r2]
	str r3, [r0, #0x18]
	bx lr
	arm_func_end NNS_G3dTexReleaseTexKey

	arm_func_start NNS_G3dTexLoad
NNS_G3dTexLoad: // 0x020CFE2C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	movs r8, r1
	mov r9, r0
	beq _020CFE44
	bl GX_BeginLoadTex
_020CFE44:
	ldrh r0, [r9, #0xc]
	movs r2, r0, lsl #3
	beq _020CFE78
	ldr r1, [r9, #8]
	ldr r0, _020CFEF8 // =0x0000FFFF
	ldr r3, [r9, #0x14]
	and r1, r1, r0
	add r0, r9, r3
	mov r1, r1, lsl #3
	bl GX_LoadTex
	ldrh r0, [r9, #0x10]
	orr r0, r0, #1
	strh r0, [r9, #0x10]
_020CFE78:
	ldrh r0, [r9, #0x1c]
	movs r7, r0, lsl #3
	beq _020CFEE0
	ldr r1, [r9, #0x18]
	ldr r0, _020CFEF8 // =0x0000FFFF
	ldr r3, [r9, #0x24]
	and r4, r1, r0
	mov r5, r4, lsl #3
	ldr r6, [r9, #0x28]
	mov r1, r5
	mov r2, r7
	add r0, r9, r3
	add r6, r9, r6
	bl GX_LoadTex
	ldr r0, _020CFEFC // =0x0001FFFF
	and r1, r5, #0x40000
	and r0, r0, r4, lsl #3
	mov r0, r0, lsr #1
	add r2, r0, #0x20000
	mov r0, r6
	add r1, r2, r1, lsr #2
	mov r2, r7, lsr #1
	bl GX_LoadTex
	ldrh r0, [r9, #0x20]
	orr r0, r0, #1
	strh r0, [r9, #0x20]
_020CFEE0:
	cmp r8, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	bl GX_EndLoadTex
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020CFEF8: .word 0x0000FFFF
_020CFEFC: .word 0x0001FFFF
	arm_func_end NNS_G3dTexLoad

	arm_func_start NNS_G3dTexSetTexKey
NNS_G3dTexSetTexKey: // 0x020CFF00
	cmp r1, #0
	strne r1, [r0, #8]
	cmp r2, #0
	strne r2, [r0, #0x18]
	bx lr
	arm_func_end NNS_G3dTexSetTexKey

	arm_func_start NNS_G3dTex4x4GetRequiredSize
NNS_G3dTex4x4GetRequiredSize: // 0x020CFF14
	ldrh r0, [r0, #0x1c]
	mov r0, r0, lsl #3
	bx lr
	arm_func_end NNS_G3dTex4x4GetRequiredSize

	arm_func_start NNS_G3dTexGetRequiredSize
NNS_G3dTexGetRequiredSize: // 0x020CFF20
	ldrh r0, [r0, #0xc]
	mov r0, r0, lsl #3
	bx lr
	arm_func_end NNS_G3dTexGetRequiredSize

	arm_func_start NNS_G3dRenderObjResetCallBack
NNS_G3dRenderObjResetCallBack: // 0x020CFF2C
	mov r1, #0
	str r1, [r0, #0x20]
	strb r1, [r0, #0x24]
	strb r1, [r0, #0x25]
	bx lr
	arm_func_end NNS_G3dRenderObjResetCallBack

	arm_func_start NNS_G3dRenderObjSetCallBack
NNS_G3dRenderObjSetCallBack: // 0x020CFF40
	str r1, [r0, #0x20]
	ldr r1, [sp]
	strb r3, [r0, #0x24]
	strb r1, [r0, #0x25]
	bx lr
	arm_func_end NNS_G3dRenderObjSetCallBack

	arm_func_start NNS_G3dRenderObjRemoveAnmObj
NNS_G3dRenderObjRemoveAnmObj: // 0x020CFF54
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	add r0, r5, #8
	mov r4, r1
	bl removeLink_
	cmp r0, #0
	bne _020CFFA0
	mov r1, r4
	add r0, r5, #0x10
	bl removeLink_
	cmp r0, #0
	bne _020CFFA0
	mov r1, r4
	add r0, r5, #0x18
	bl removeLink_
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
_020CFFA0:
	ldr r0, [r5]
	orr r0, r0, #0x10
	str r0, [r5]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNS_G3dRenderObjRemoveAnmObj

	arm_func_start removeLink_
removeLink_: // 0x020CFFB4
	ldr r2, [r0]
	cmp r2, #0
	moveq r0, #0
	bxeq lr
	cmp r2, r1
	bne _020CFFE4
	ldr r3, [r2, #0x10]
	mov r2, #0
	str r3, [r0]
	str r2, [r1, #0x10]
	mov r0, #1
	bx lr
_020CFFE4:
	ldr r3, [r2, #0x10]
	cmp r3, #0
	beq _020D0020
_020CFFF0:
	cmp r3, r1
	bne _020D0010
	ldr r1, [r3, #0x10]
	mov r0, #0
	str r1, [r2, #0x10]
	str r0, [r3, #0x10]
	mov r0, #1
	bx lr
_020D0010:
	mov r2, r3
	ldr r3, [r3, #0x10]
	cmp r3, #0
	bne _020CFFF0
_020D0020:
	mov r0, #0
	bx lr
	arm_func_end removeLink_

	arm_func_start NNS_G3dRenderObjAddAnmObj
NNS_G3dRenderObjAddAnmObj: // 0x020D0028
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	ldr r2, [r4, #8]
	mov r5, r0
	ldrb r0, [r2]
	cmp r0, #0x4a
	beq _020D007C
	cmp r0, #0x4d
	beq _020D0060
	cmp r0, #0x56
	beq _020D0098
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020D0060:
	add r0, r5, #0x3c
	bl updateHintVec_
	mov r1, r4
	add r0, r5, #8
	bl addLink_
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020D007C:
	add r0, r5, #0x44
	bl updateHintVec_
	mov r1, r4
	add r0, r5, #0x10
	bl addLink_
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020D0098:
	add r0, r5, #0x4c
	bl updateHintVec_
	mov r1, r4
	add r0, r5, #0x18
	bl addLink_
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNS_G3dRenderObjAddAnmObj

	arm_func_start updateHintVec_
updateHintVec_: // 0x020D00B4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	mov r3, #1
	mov r4, #0
_020D00D0:
	ldrb r2, [r1, #0x19]
	mov r5, r4
	cmp r2, #0
	ble _020D0110
_020D00E0:
	add r2, r1, r5, lsl #1
	ldrh r2, [r2, #0x1a]
	ands r2, r2, #0x100
	movne lr, r5, asr #5
	andne r2, r5, #0x1f
	ldrne ip, [r0, lr, lsl #2]
	add r5, r5, #1
	orrne r2, ip, r3, lsl r2
	strne r2, [r0, lr, lsl #2]
	ldrb r2, [r1, #0x19]
	cmp r5, r2
	blt _020D00E0
_020D0110:
	ldr r1, [r1, #0x10]
	cmp r1, #0
	bne _020D00D0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end updateHintVec_

	arm_func_start addLink_
addLink_: // 0x020D0124
	ldr ip, [r0]
	cmp ip, #0
	streq r1, [r0]
	bxeq lr
	ldr r3, [ip, #0x10]
	cmp r3, #0
	bne _020D0184
	ldrb r3, [ip, #0x18]
	ldrb r2, [r1, #0x18]
	cmp r3, r2
	bls _020D017C
	ldr r2, [r1, #0x10]
	mov r3, r1
	cmp r2, #0
	beq _020D0170
_020D0160:
	ldr r3, [r3, #0x10]
	ldr r2, [r3, #0x10]
	cmp r2, #0
	bne _020D0160
_020D0170:
	str ip, [r3, #0x10]
	str r1, [r0]
	bx lr
_020D017C:
	str r1, [ip, #0x10]
	bx lr
_020D0184:
	cmp r3, #0
	beq _020D01D8
	ldrb r2, [r1, #0x18]
_020D0190:
	ldrb r0, [r3, #0x18]
	cmp r0, r2
	blo _020D01C8
	ldr r0, [r1, #0x10]
	mov r2, r1
	cmp r0, #0
	beq _020D01BC
_020D01AC:
	ldr r2, [r2, #0x10]
	ldr r0, [r2, #0x10]
	cmp r0, #0
	bne _020D01AC
_020D01BC:
	str r1, [ip, #0x10]
	str r3, [r2, #0x10]
	bx lr
_020D01C8:
	mov ip, r3
	ldr r3, [r3, #0x10]
	cmp r3, #0
	bne _020D0190
_020D01D8:
	str r1, [ip, #0x10]
	bx lr
	arm_func_end addLink_

	arm_func_start NNS_G3dRenderObjInit
NNS_G3dRenderObjInit: // 0x020D01E0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r1, r5
	mov r0, #0
	mov r2, #0x54
	bl MIi_CpuClear32
	ldr r0, _020D0230 // =NNS_G3dFuncBlendMatDefault
	ldr r1, _020D0234 // =NNS_G3dFuncBlendJntDefault
	ldr r2, [r0]
	ldr r0, _020D0238 // =NNS_G3dFuncBlendVisDefault
	str r2, [r5, #0xc]
	ldr r1, [r1]
	str r1, [r5, #0x14]
	ldr r0, [r0]
	str r0, [r5, #0x1c]
	str r4, [r5, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D0230: .word NNS_G3dFuncBlendMatDefault
_020D0234: .word NNS_G3dFuncBlendJntDefault
_020D0238: .word NNS_G3dFuncBlendVisDefault
	arm_func_end NNS_G3dRenderObjInit

	arm_func_start NNS_G3dAnmObjInit
NNS_G3dAnmObjInit: // 0x020D023C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov ip, #0
	str ip, [r0]
	str r1, [r0, #8]
	str ip, [r0, #0x10]
	mov r4, #0x7f
	strb r4, [r0, #0x18]
	mov r4, #0x1000
	str r4, [r0, #4]
	ldr lr, _020D02D0 // =NNS_G3dAnmFmtNum
	str r3, [r0, #0x14]
	ldr r6, [lr]
	cmp r6, #0
	addls sp, sp, #4
	ldmlsia sp!, {r4, r5, r6, r7, pc}
	ldrb r7, [r1]
	ldr r4, _020D02D4 // =NNS_G3dAnmObjInitFuncArray
_020D0284:
	ldrb r3, [r4, ip, lsl #3]
	mov r5, ip, lsl #3
	cmp r7, r3
	bne _020D02BC
	add r3, r4, r5
	ldrh lr, [r1, #2]
	ldrh r3, [r3, #2]
	cmp lr, r3
	bne _020D02BC
	ldr r3, _020D02D8 // =_0211F448
	ldr r3, [r3, r5]
	blx r3
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
_020D02BC:
	add ip, ip, #1
	cmp ip, r6
	blo _020D0284
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D02D0: .word NNS_G3dAnmFmtNum
_020D02D4: .word NNS_G3dAnmObjInitFuncArray
_020D02D8: .word 0x0211F448
	arm_func_end NNS_G3dAnmObjInit

	arm_func_start NNS_G3dAnmObjCalcSizeRequired
NNS_G3dAnmObjCalcSizeRequired: // 0x020D02DC
	ldrb r0, [r0]
	cmp r0, #0x4a
	beq _020D0310
	cmp r0, #0x4d
	beq _020D02FC
	cmp r0, #0x56
	beq _020D0310
	b _020D0324
_020D02FC:
	ldrb r0, [r1, #0x18]
	mov r0, r0, lsl #1
	add r0, r0, #0x1c
	bic r0, r0, #3
	bx lr
_020D0310:
	ldrb r0, [r1, #0x17]
	mov r0, r0, lsl #1
	add r0, r0, #0x1c
	bic r0, r0, #3
	bx lr
_020D0324:
	mov r0, #0
	bx lr
	arm_func_end NNS_G3dAnmObjCalcSizeRequired

	arm_func_start NNS_G3dGlbGetViewPort
NNS_G3dGlbGetViewPort: // 0x020D032C
	cmp r0, #0
	ldrne ip, _020D038C // =NNS_G3dGlb
	ldrne ip, [ip, #0xa0]
	andne ip, ip, #0xff
	strne ip, [r0]
	cmp r1, #0
	ldrne r0, _020D038C // =NNS_G3dGlb
	ldrne r0, [r0, #0xa0]
	movne r0, r0, lsr #8
	andne r0, r0, #0xff
	strne r0, [r1]
	cmp r2, #0
	ldrne r0, _020D038C // =NNS_G3dGlb
	ldrne r0, [r0, #0xa0]
	movne r0, r0, lsr #0x10
	andne r0, r0, #0xff
	strne r0, [r2]
	cmp r3, #0
	ldrne r0, _020D038C // =NNS_G3dGlb
	ldrne r0, [r0, #0xa0]
	movne r0, r0, lsr #0x18
	andne r0, r0, #0xff
	strne r0, [r3]
	bx lr
	.align 2, 0
_020D038C: .word NNS_G3dGlb
	arm_func_end NNS_G3dGlbGetViewPort

	arm_func_start NNS_G3dGlbGetView_UNKNOWN
NNS_G3dGlbGetView_UNKNOWN: // 0x020D0390
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x44
	ldr r0, _020D03F0 // =NNS_G3dGlb
	ldr r0, [r0, #0xfc]
	ands r0, r0, #0x40
	bne _020D03E4
	bl NNS_G3dGlbGetInvWV_ANOTHER_IDK
	mov r5, r0
	bl NNS_G3dGlbGetInvV
	mov r4, r0
	add r1, sp, #0
	mov r0, r5
	bl MTX_Copy43To44_
	ldr r2, _020D03F4 // =0x02147440
	add r1, sp, #0
	mov r0, r4
	bl MTX_Concat44
	ldr r0, _020D03F0 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	orr r1, r1, #0x40
	str r1, [r0, #0xfc]
_020D03E4:
	ldr r0, _020D03F4 // =0x02147440
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D03F0: .word NNS_G3dGlb
_020D03F4: .word 0x02147440
	arm_func_end NNS_G3dGlbGetView_UNKNOWN

	arm_func_start NNS_G3dGlbGetInvWV
NNS_G3dGlbGetInvWV: // 0x020D03F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020D0430 // =NNS_G3dGlb
	ldr r0, [r0, #0xfc]
	ands r0, r0, #0x80
	bne _020D0424
	bl calcSrtCameraMtx_
	ldr r0, _020D0430 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	orr r1, r1, #0x80
	str r1, [r0, #0xfc]
_020D0424:
	ldr r0, _020D0434 // =0x021473A0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D0430: .word NNS_G3dGlb
_020D0434: .word 0x021473A0
	arm_func_end NNS_G3dGlbGetInvWV

	arm_func_start NNS_G3dGlbGetWV
NNS_G3dGlbGetWV: // 0x020D0438
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020D0470 // =NNS_G3dGlb
	ldr r0, [r0, #0xfc]
	ands r0, r0, #0x80
	bne _020D0464
	bl calcSrtCameraMtx_
	ldr r0, _020D0470 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	orr r1, r1, #0x80
	str r1, [r0, #0xfc]
_020D0464:
	ldr r0, _020D0474 // =0x02147370
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D0470: .word NNS_G3dGlb
_020D0474: .word 0x02147370
	arm_func_end NNS_G3dGlbGetWV

	arm_func_start calcSrtCameraMtx_
calcSrtCameraMtx_: // 0x020D0478
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020D04C4 // =0x021472FC
	ldr r1, _020D04C8 // =0x0214728C
	ldr r2, _020D04CC // =0x02147370
	bl MTX_Concat43
	ldr r3, _020D04D0 // =NNS_G3dGlb
	ldr r0, _020D04CC // =0x02147370
	ldr r2, [r3, #0xf4]
	mov r1, r0
	str r2, [sp]
	ldr r2, [r3, #0xec]
	ldr r3, [r3, #0xf0]
	bl MTX_ScaleApply43
	ldr r0, _020D04CC // =0x02147370
	ldr r1, _020D04D4 // =0x021473A0
	bl MTX_Inverse43
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D04C4: .word 0x021472FC
_020D04C8: .word 0x0214728C
_020D04CC: .word 0x02147370
_020D04D0: .word NNS_G3dGlb
_020D04D4: .word 0x021473A0
	arm_func_end calcSrtCameraMtx_

	arm_func_start NNS_G3dGlbGetInvV
NNS_G3dGlbGetInvV: // 0x020D04D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020D0518 // =NNS_G3dGlb
	ldr r0, [r0, #0xfc]
	ands r0, r0, #0x10
	bne _020D050C
	ldr r0, _020D051C // =0x02147248
	ldr r1, _020D0520 // =0x02147400
	bl MTX_Inverse43_AnotherIDK
	ldr r0, _020D0518 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	orr r1, r1, #0x10
	str r1, [r0, #0xfc]
_020D050C:
	ldr r0, _020D0520 // =0x02147400
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D0518: .word NNS_G3dGlb
_020D051C: .word 0x02147248
_020D0520: .word 0x02147400
	arm_func_end NNS_G3dGlbGetInvV

	arm_func_start MTX_Inverse43_AnotherIDK
MTX_Inverse43_AnotherIDK: // 0x020D0524
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x54
	mov r11, r1
	add r1, sp, #0x14
	bl MI_Copy64B
	mov r0, r11
	bl MTX_Identity44_
	mov r4, #0
	str r4, [sp, #0x10]
	str r4, [sp, #4]
	str r4, [sp, #8]
	str r4, [sp, #0xc]
	str r4, [sp]
_020D0558:
	ldr r2, [sp]
	mov r1, r4
	mov r3, r4
	cmp r4, #4
	bge _020D0598
	add r0, sp, #0x14
	add r0, r0, r4, lsl #2
_020D0574:
	ldr r5, [r0, r3, lsl #4]
	cmp r5, #0
	rsblt r5, r5, #0
	cmp r5, r2
	movgt r1, r3
	add r3, r3, #1
	movgt r2, r5
	cmp r3, #4
	blt _020D0574
_020D0598:
	cmp r2, #0
	addeq sp, sp, #0x54
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r1, r4
	beq _020D05F4
	ldr r0, [sp, #4]
_020D05B4:
	add r2, sp, #0x14
	add r7, r2, r4, lsl #4
	add r3, r2, r1, lsl #4
	ldr r5, [r7, r0, lsl #2]
	ldr r2, [r3, r0, lsl #2]
	add r6, r11, r4, lsl #4
	str r2, [r7, r0, lsl #2]
	str r5, [r3, r0, lsl #2]
	add r3, r11, r1, lsl #4
	ldr r5, [r6, r0, lsl #2]
	ldr r2, [r3, r0, lsl #2]
	str r2, [r6, r0, lsl #2]
	str r5, [r3, r0, lsl #2]
	add r0, r0, #1
	cmp r0, #4
	blt _020D05B4
_020D05F4:
	add r0, sp, #0x14
	add r0, r0, r4, lsl #4
	ldr r0, [r0, r4, lsl #2]
	bl FX_InvFx64c
	ldr r3, [sp, #8]
	mov r2, r4, lsl #4
_020D060C:
	add r5, sp, #0x14
	add r9, r5, r2
	ldr r7, [r9, r3, lsl #2]
	mov r5, #0x80000000
	mov r6, r7, asr #0x1f
	umull ip, r10, r0, r7
	mla r10, r0, r6, r10
	mla r10, r1, r7, r10
	adds ip, ip, r5
	adc r6, r10, #0
	add r8, r11, r2
	str r6, [r9, r3, lsl #2]
	ldr r7, [r8, r3, lsl #2]
	umull r10, r9, r0, r7
	mov r6, r7, asr #0x1f
	mla r9, r0, r6, r9
	mla r9, r1, r7, r9
	adds r5, r10, r5
	adc r5, r9, #0
	str r5, [r8, r3, lsl #2]
	add r3, r3, #1
	cmp r3, #4
	blt _020D060C
	ldr r8, [sp, #0xc]
_020D066C:
	cmp r8, r4
	beq _020D06FC
	add r0, sp, #0x14
	add r0, r0, r4, lsl #2
	ldr r10, [r0, r8, lsl #4]
	ldr r7, [sp, #0x10]
	mov r9, r10, asr #0x1f
_020D0688:
	add r0, sp, #0x14
	add r0, r0, r4, lsl #4
	ldr r3, [r0, r7, lsl #2]
	add r0, sp, #0x14
	mov r2, r3, asr #0x1f
	umull lr, ip, r10, r3
	mla ip, r10, r2, ip
	add r6, r0, r8, lsl #4
	mla ip, r9, r3, ip
	mov r2, lr, lsr #0xc
	ldr r5, [r6, r7, lsl #2]
	orr r2, r2, ip, lsl #20
	subs r2, r5, r2
	add r0, r11, r4, lsl #4
	str r2, [r6, r7, lsl #2]
	ldr r2, [r0, r7, lsl #2]
	add r1, r11, r8, lsl #4
	mov r0, r2, asr #0x1f
	umull r5, r3, r10, r2
	mla r3, r10, r0, r3
	mla r3, r9, r2, r3
	mov r0, r5, lsr #0xc
	ldr r6, [r1, r7, lsl #2]
	orr r0, r0, r3, lsl #20
	subs r0, r6, r0
	str r0, [r1, r7, lsl #2]
	add r7, r7, #1
	cmp r7, #4
	blt _020D0688
_020D06FC:
	add r8, r8, #1
	cmp r8, #4
	blt _020D066C
	add r4, r4, #1
	cmp r4, #4
	blt _020D0558
	mov r0, #0
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end MTX_Inverse43_AnotherIDK

	arm_func_start NNS_G3dGlbGetInvWV_ANOTHER_IDK
NNS_G3dGlbGetInvWV_ANOTHER_IDK: // 0x020D0720
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020D0760 // =NNS_G3dGlb
	ldr r0, [r0, #0xfc]
	ands r0, r0, #8
	bne _020D0754
	ldr r0, _020D0764 // =0x0214728C
	ldr r1, _020D0768 // =0x02147340
	bl MTX_Inverse43
	ldr r0, _020D0760 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	orr r1, r1, #8
	str r1, [r0, #0xfc]
_020D0754:
	ldr r0, _020D0768 // =0x02147340
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D0760: .word NNS_G3dGlb
_020D0764: .word 0x0214728C
_020D0768: .word 0x02147340
	arm_func_end NNS_G3dGlbGetInvWV_ANOTHER_IDK

	arm_func_start NNS_G3dGlbPolygonAttr
NNS_G3dGlbPolygonAttr: // 0x020D076C
	orr r0, r0, r1, lsl #4
	ldr r1, [sp, #4]
	orr r0, r0, r2, lsl #6
	orr r0, r1, r0
	ldr r2, [sp]
	orr r1, r0, r3, lsl #24
	ldr r0, _020D0794 // =NNS_G3dGlb
	orr r1, r1, r2, lsl #16
	str r1, [r0, #0x9c]
	bx lr
	.align 2, 0
_020D0794: .word NNS_G3dGlb
	arm_func_end NNS_G3dGlbPolygonAttr

	arm_func_start NNS_G3dGlbLightColor
NNS_G3dGlbLightColor: // 0x020D0798
	ldr r2, _020D07A8 // =0x021472E8
	orr r1, r1, r0, lsl #30
	str r1, [r2, r0, lsl #2]
	bx lr
	.align 2, 0
_020D07A8: .word 0x021472E8
	arm_func_end NNS_G3dGlbLightColor

	arm_func_start NNS_G3dGlbLightVector
NNS_G3dGlbLightVector: // 0x020D07AC
	stmdb sp!, {r4, lr}
	ldr ip, _020D07D8 // =0x000003FF
	ldr lr, _020D07DC // =0x021472C0
	and r4, ip, r1, asr #3
	and r1, ip, r2, asr #3
	and r2, ip, r3, asr #3
	orr r1, r4, r1, lsl #10
	orr r1, r1, r2, lsl #20
	orr r1, r1, r0, lsl #30
	str r1, [lr, r0, lsl #2]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D07D8: .word 0x000003FF
_020D07DC: .word 0x021472C0
	arm_func_end NNS_G3dGlbLightVector

	arm_func_start NNS_G3dGlbSetBaseScale
NNS_G3dGlbSetBaseScale: // 0x020D07E0
	ldr r3, _020D0800 // =0x0214732C
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, _020D0804 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	bic r1, r1, #0xa4
	str r1, [r0, #0xfc]
	bx lr
	.align 2, 0
_020D0800: .word 0x0214732C
_020D0804: .word NNS_G3dGlb
	arm_func_end NNS_G3dGlbSetBaseScale

	arm_func_start NNS_G3dGlbSetBaseTrans
NNS_G3dGlbSetBaseTrans: // 0x020D0808
	ldr r3, _020D0828 // =0x02147320
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	ldr r0, _020D082C // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	bic r1, r1, #0xa4
	str r1, [r0, #0xfc]
	bx lr
	.align 2, 0
_020D0828: .word 0x02147320
_020D082C: .word NNS_G3dGlb
	arm_func_end NNS_G3dGlbSetBaseTrans

	arm_func_start NNS_G3dGlbFlushWVP
NNS_G3dGlbFlushWVP: // 0x020D0830
	stmdb sp!, {lr}
	sub sp, sp, #0x34
	ldr r0, _020D08F4 // =0x00001610
	ldr r1, _020D08F8 // =0x02147244
	mov r2, #0x11
	bl NNS_G3dGeBufferOP_N
	ldr r1, _020D08FC // =0x0214728C
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	ldr r0, _020D0900 // =0x00001B19
	ldr r1, _020D0904 // =0x021472FC
	mov r2, #0xf
	bl NNS_G3dGeBufferOP_N
	mov r3, #2
	add r1, sp, #0
	mov r0, #0x10
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	ldr r0, _020D0904 // =0x021472FC
	add r1, sp, #4
	bl MTX_Inverse33
	mov r0, #0x17
	add r1, sp, #4
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	ldr r0, _020D0908 // =NNS_G3dGlb
	ldr r1, _020D090C // =0x021472BC
	ldr r0, [r0, #0x7c]
	add r1, r1, #4
	mov r2, #0xe
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r0, #0x15
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	ldr r1, _020D0910 // =0x02147338
	mov r0, #0x2a
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r0, _020D0908 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	orr r1, r1, #1
	str r1, [r0, #0xfc]
	bic r1, r1, #2
	str r1, [r0, #0xfc]
	add sp, sp, #0x34
	ldmia sp!, {pc}
	.align 2, 0
_020D08F4: .word 0x00001610
_020D08F8: .word 0x02147244
_020D08FC: .word 0x0214728C
_020D0900: .word 0x00001B19
_020D0904: .word 0x021472FC
_020D0908: .word NNS_G3dGlb
_020D090C: .word 0x021472BC
_020D0910: .word 0x02147338
	arm_func_end NNS_G3dGlbFlushWVP

	arm_func_start NNS_G3dGlbFlushVP
NNS_G3dGlbFlushVP: // 0x020D0914
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020D0984 // =0x00001610
	ldr r1, _020D0988 // =0x02147244
	mov r2, #0x11
	bl NNS_G3dGeBufferOP_N
	ldr r1, _020D098C // =0x0214728C
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	mov r3, #2
	add r1, sp, #0
	mov r0, #0x10
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	ldr r1, _020D0990 // =0x021472BC
	mov r0, #0x15
	mov r2, #0x20
	bl NNS_G3dGeBufferOP_N
	ldr r0, _020D0994 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	bic r1, r1, #1
	str r1, [r0, #0xfc]
	orr r1, r1, #2
	str r1, [r0, #0xfc]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D0984: .word 0x00001610
_020D0988: .word 0x02147244
_020D098C: .word 0x0214728C
_020D0990: .word 0x021472BC
_020D0994: .word NNS_G3dGlb
	arm_func_end NNS_G3dGlbFlushVP

	arm_func_start NNS_G3dGlbFlushP
NNS_G3dGlbFlushP: // 0x020D0998
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020D09D0 // =NNS_G3dGlb
	mov r2, #0x3e
	ldr r0, [r1], #4
	bl NNS_G3dGeBufferOP_N
	ldr r0, _020D09D0 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	bic r1, r1, #1
	str r1, [r0, #0xfc]
	bic r1, r1, #2
	str r1, [r0, #0xfc]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D09D0: .word NNS_G3dGlb
	arm_func_end NNS_G3dGlbFlushP

	arm_func_start NNS_G3dGlbInit
NNS_G3dGlbInit: // 0x020D09D4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r8, _020D0AF0 // =0x17101610
	ldr r1, _020D0AF4 // =NNS_G3dGlb
	ldr r5, _020D0AF8 // =0x32323232
	ldr r4, _020D0AFC // =0x60293130
	ldr r3, _020D0B00 // =0x33333333
	ldr r2, _020D0B04 // =0x002A1B19
	mov r7, #0
	mov r6, #2
	ldr r0, _020D0B08 // =0x0214728C
	str r8, [r1]
	str r7, [r1, #4]
	str r6, [r1, #0x48]
	str r5, [r1, #0x7c]
	str r4, [r1, #0x90]
	str r3, [r1, #0xa4]
	str r2, [r1, #0xb8]
	bl MTX_Identity43_
	ldr r0, _020D0B0C // =0x02147248
	bl MTX_Identity44_
	mov r2, r7
	ldr r1, _020D0AF4 // =NNS_G3dGlb
	ldr r7, _020D0B10 // =0x4210C210
	ldr r0, _020D0B14 // =0x40000200
	ldr lr, _020D0B18 // =0x2D8B62D8
	ldr r9, _020D0B1C // =0x800001FF
	ldr r8, _020D0B20 // =0xC0080000
	ldr r6, _020D0B24 // =0x001F008F
	ldr r5, _020D0B28 // =0xBFFF0000
	ldr r4, _020D0B2C // =0x00007FFF
	ldr ip, _020D0B30 // =0x800003E0
	ldr r3, _020D0B34 // =0xC0007C00
	str r0, [r1, #0x84]
	str lr, [r1, #0x80]
	mov lr, #0x4000001f
	ldr r0, _020D0B38 // =0x021472FC
	str r9, [r1, #0x88]
	str r8, [r1, #0x8c]
	str r7, [r1, #0x94]
	str r7, [r1, #0x98]
	str r6, [r1, #0x9c]
	str r5, [r1, #0xa0]
	str r4, [r1, #0xa8]
	str lr, [r1, #0xac]
	str ip, [r1, #0xb0]
	str r3, [r1, #0xb4]
	str r2, [r1, #0xe0]
	str r2, [r1, #0xe4]
	str r2, [r1, #0xe8]
	bl MTX_Identity33_
	mov r3, #0x1000
	ldr r0, _020D0AF4 // =NNS_G3dGlb
	mov r2, #0
	rsb r1, r3, #0
	str r3, [r0, #0xec]
	str r3, [r0, #0xf0]
	str r3, [r0, #0xf4]
	str r2, [r0, #0xf8]
	str r2, [r0, #0xfc]
	str r2, [r0, #0x248]
	str r2, [r0, #0x244]
	str r2, [r0, #0x240]
	str r2, [r0, #0x254]
	str r2, [r0, #0x24c]
	str r3, [r0, #0x250]
	str r2, [r0, #0x25c]
	str r2, [r0, #0x258]
	str r1, [r0, #0x260]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020D0AF0: .word 0x17101610
_020D0AF4: .word NNS_G3dGlb
_020D0AF8: .word 0x32323232
_020D0AFC: .word 0x60293130
_020D0B00: .word 0x33333333
_020D0B04: .word 0x002A1B19
_020D0B08: .word 0x0214728C
_020D0B0C: .word 0x02147248
_020D0B10: .word 0x4210C210
_020D0B14: .word 0x40000200
_020D0B18: .word 0x2D8B62D8
_020D0B1C: .word 0x800001FF
_020D0B20: .word 0xC0080000
_020D0B24: .word 0x001F008F
_020D0B28: .word 0xBFFF0000
_020D0B2C: .word 0x00007FFF
_020D0B30: .word 0x800003E0
_020D0B34: .word 0xC0007C00
_020D0B38: .word 0x021472FC
	arm_func_end NNS_G3dGlbInit

	arm_func_start NNSi_G3dAnmBlendVis
NNSi_G3dAnmBlendVis: // 0x020D0B3C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r0, #0
	mov r6, r1
	str r0, [r7]
	add r4, sp, #0
	mov r5, r2, lsl #1
	mov r8, #1
_020D0B60:
	add r1, r5, r6
	ldrh r2, [r1, #0x1a]
	ands r1, r2, #0x100
	beq _020D0B98
	ldr r3, [r6, #0xc]
	mov r0, r4
	mov r1, r6
	and r2, r2, #0xff
	blx r3
	ldr r2, [r7]
	ldr r1, [sp]
	mov r0, r8
	orr r1, r2, r1
	str r1, [r7]
_020D0B98:
	ldr r6, [r6, #0x10]
	cmp r6, #0
	bne _020D0B60
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end NNSi_G3dAnmBlendVis

	arm_func_start NNSi_G3dAnmBlendJnt
NNSi_G3dAnmBlendJnt: // 0x020D0BAC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x5c
	mov r9, r1
	ldr r3, [r9, #0x10]
	mov r10, r0
	mov r8, r2
	cmp r3, #0
	bne _020D0C00
	add r2, r9, r8, lsl #1
	ldrh r4, [r2, #0x1a]
	and r2, r4, #0x300
	cmp r2, #0x100
	addne sp, sp, #0x5c
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r3, [r9, #0xc]
	and r2, r4, #0xff
	blx r3
	add sp, sp, #0x5c
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020D0C00:
	mov r7, #0
	mov r3, r7
	mov r4, r9
	mov r2, r8, lsl #1
_020D0C10:
	add r0, r2, r4
	ldrh r0, [r0, #0x1a]
	and r0, r0, #0x300
	cmp r0, #0x100
	ldreq r0, [r4, #4]
	moveq r1, r4
	ldr r4, [r4, #0x10]
	addeq r7, r7, r0
	addeq r3, r3, #1
	cmp r4, #0
	bne _020D0C10
	cmp r7, #0
	addeq sp, sp, #0x5c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r3, #1
	bne _020D0C78
	add r0, r1, r8, lsl #1
	ldrh r2, [r0, #0x1a]
	ldr r3, [r1, #0xc]
	mov r0, r10
	and r2, r2, #0xff
	blx r3
	add sp, sp, #0x5c
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020D0C78:
	mov r1, r10
	mov r0, #0
	mov r2, #0x58
	bl MIi_CpuClearFast
	mvn r0, #0
	str r0, [r10]
	add r5, sp, #0
	add r4, sp, #4
	add r11, sp, #0x10
_020D0C9C:
	add r0, r9, r8, lsl #1
	ldrh r2, [r0, #0x1a]
	and r0, r2, #0x300
	cmp r0, #0x100
	bne _020D0E44
	ldr r0, [r9, #4]
	cmp r0, #0
	ble _020D0E44
	ldr r3, [r9, #0xc]
	mov r0, r5
	mov r1, r9
	and r2, r2, #0xff
	blx r3
	cmp r7, #0x1000
	ldreq r6, [r9, #4]
	beq _020D0CEC
	ldr r0, [r9, #4]
	mov r1, r7
	bl FX_Div
	mov r6, r0
_020D0CEC:
	ldr r3, [sp]
	mov r1, r4
	mov r2, r6
	add r0, r10, #4
	and r3, r3, #1
	bl blendScaleVec_
	ldr r1, [sp]
	add r0, r10, #0x10
	and r3, r1, #8
	mov r1, r11
	mov r2, r6
	bl blendScaleVec_
	ldr r3, [sp]
	add r0, r10, #0x1c
	add r1, sp, #0x1c
	mov r2, r6
	and r3, r3, #0x10
	bl blendScaleVec_
	ldr r0, [sp]
	ands r0, r0, #4
	bne _020D0D94
	ldr r0, [sp, #0x4c]
	ldr r2, [r10, #0x4c]
	smull r1, r0, r6, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r10, #0x4c]
	ldr r0, [sp, #0x50]
	ldr r2, [r10, #0x50]
	smull r1, r0, r6, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r10, #0x50]
	ldr r0, [sp, #0x54]
	ldr r2, [r10, #0x54]
	smull r1, r0, r6, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r10, #0x54]
_020D0D94:
	ldr r0, [sp]
	ands r0, r0, #2
	bne _020D0E1C
	ldr r0, [sp, #0x28]
	ldr r1, [r10, #0x28]
	mul r0, r6, r0
	add r0, r1, r0, asr #12
	str r0, [r10, #0x28]
	ldr r0, [sp, #0x2c]
	ldr r1, [r10, #0x2c]
	mul r0, r6, r0
	add r0, r1, r0, asr #12
	str r0, [r10, #0x2c]
	ldr r0, [sp, #0x30]
	ldr r1, [r10, #0x30]
	mul r0, r6, r0
	add r0, r1, r0, asr #12
	str r0, [r10, #0x30]
	ldr r0, [sp, #0x34]
	ldr r1, [r10, #0x34]
	mul r0, r6, r0
	add r0, r1, r0, asr #12
	str r0, [r10, #0x34]
	ldr r0, [sp, #0x38]
	ldr r1, [r10, #0x38]
	mul r0, r6, r0
	add r0, r1, r0, asr #12
	str r0, [r10, #0x38]
	ldr r0, [sp, #0x3c]
	ldr r1, [r10, #0x3c]
	mul r0, r6, r0
	add r0, r1, r0, asr #12
	str r0, [r10, #0x3c]
	b _020D0E34
_020D0E1C:
	ldr r0, [r10, #0x28]
	add r0, r0, r6
	str r0, [r10, #0x28]
	ldr r0, [r10, #0x38]
	add r0, r0, r6
	str r0, [r10, #0x38]
_020D0E34:
	ldr r1, [r10]
	ldr r0, [sp]
	and r0, r1, r0
	str r0, [r10]
_020D0E44:
	ldr r9, [r9, #0x10]
	cmp r9, #0
	bne _020D0C9C
	add r0, r10, #0x28
	add r1, r10, #0x34
	add r2, r10, #0x40
	bl VEC_CrossProduct
	add r0, r10, #0x28
	mov r1, r0
	bl VEC_Normalize
	add r0, r10, #0x40
	mov r1, r0
	bl VEC_Normalize
	add r0, r10, #0x40
	add r1, r10, #0x28
	add r2, r10, #0x34
	bl VEC_CrossProduct
	mov r0, #1
	add sp, sp, #0x5c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end NNSi_G3dAnmBlendJnt

	arm_func_start blendScaleVec_
blendScaleVec_: // 0x020D0E94
	cmp r3, #0
	beq _020D0EC4
	ldr r1, [r0]
	add r1, r1, r2
	str r1, [r0]
	ldr r1, [r0, #4]
	add r1, r1, r2
	str r1, [r0, #4]
	ldr r1, [r0, #8]
	add r1, r1, r2
	str r1, [r0, #8]
	bx lr
_020D0EC4:
	ldr r3, [r1]
	ldr ip, [r0]
	mul r3, r2, r3
	add r3, ip, r3, asr #12
	str r3, [r0]
	ldr r3, [r1, #4]
	ldr ip, [r0, #4]
	mul r3, r2, r3
	add r3, ip, r3, asr #12
	str r3, [r0, #4]
	ldr r1, [r1, #8]
	ldr r3, [r0, #8]
	mul r1, r2, r1
	add r1, r3, r1, asr #12
	str r1, [r0, #8]
	bx lr
	arm_func_end blendScaleVec_

	arm_func_start NNSi_G3dAnmBlendMat
NNSi_G3dAnmBlendMat: // 0x020D0F04
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r5, r1
	mov r0, #0
	mov r4, r2, lsl #1
	mov r7, #1
_020D0F20:
	add r1, r4, r5
	ldrh r2, [r1, #0x1a]
	ands r1, r2, #0x100
	beq _020D0F48
	ldr r3, [r5, #0xc]
	mov r0, r6
	mov r1, r5
	and r2, r2, #0xff
	blx r3
	mov r0, r7
_020D0F48:
	ldr r5, [r5, #0x10]
	cmp r5, #0
	bne _020D0F20
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end NNSi_G3dAnmBlendMat

	arm_func_start NNSi_G3dFuncSbc_PRJMAP
NNSi_G3dFuncSbc_PRJMAP: // 0x020D0F5C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x80
	mov r5, r0
	ldr r1, [r5, #8]
	ands r0, r1, #0x200
	bne _020D12B0
	ands r0, r1, #1
	beq _020D12B0
	add r0, sp, #0x10
	mov r1, #0
	bl NNS_G3dGetCurrentMtx
	mov r0, #0x1e
	str r0, [sp]
	add r1, sp, #0
	mov r0, #0x13
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r2, [r5, #0xb0]
	ldr r0, [r2, #0x10]
	and r1, r0, #0xc0000000
	cmp r1, #0xc0000000
	beq _020D0FEC
	bic r0, r0, #0xc0000000
	str r0, [r2, #0x10]
	ldr r2, [r5, #0xb0]
	ldr r3, _020D12C4 // =_0211F4BC
	ldr r0, [r2, #0x10]
	ldr r1, _020D12C8 // =_0211F4C0
	orr r0, r0, #0xc0000000
	str r0, [r2, #0x10]
	ldr r2, [r5, #0xb0]
	ldr r0, [r3]
	ldr r4, [r2, #0x10]
	mov r2, #1
	str r4, [r3, #4]
	bl NNS_G3dGeBufferOP_N
_020D0FEC:
	ldr r0, [r5, #0x40]
	cmp r0, #0
	ldrneb r4, [r5, #0x99]
	moveq r4, #0
	cmp r4, #1
	bne _020D1038
	ldr r1, [r5, #8]
	mov r0, r5
	bic r1, r1, #0x40
	str r1, [r5, #8]
	ldr r1, [r5, #0x40]
	blx r1
	ldr r0, [r5, #0x40]
	cmp r0, #0
	ldrneb r4, [r5, #0x99]
	ldr r0, [r5, #8]
	moveq r4, #0
	and r0, r0, #0x40
	b _020D103C
_020D1038:
	mov r0, #0
_020D103C:
	cmp r0, #0
	bne _020D1080
	ldr r0, [r5, #0xb0]
	ldr r1, _020D12CC // =_0211F4EC
	ldrh r6, [r0, #0x2e]
	ldrh r3, [r0, #0x2c]
	mov r0, #0x16
	rsb r2, r6, #0
	mov lr, r3, lsl #0xf
	mov ip, r2, lsl #0xf
	mov r3, r6, lsl #0xf
	mov r2, #0x10
	str lr, [r1]
	str ip, [r1, #0x14]
	str lr, [r1, #0x30]
	str r3, [r1, #0x34]
	bl NNS_G3dGeBufferOP_N
_020D1080:
	cmp r4, #2
	bne _020D10BC
	ldr r1, [r5, #8]
	mov r0, r5
	bic r1, r1, #0x40
	str r1, [r5, #8]
	ldr r1, [r5, #0x40]
	blx r1
	ldr r0, [r5, #0x40]
	cmp r0, #0
	ldrneb r4, [r5, #0x99]
	ldr r0, [r5, #8]
	moveq r4, #0
	and r0, r0, #0x40
	b _020D10C0
_020D10BC:
	mov r0, #0
_020D10C0:
	cmp r0, #0
	bne _020D1124
	ldr ip, [r5, #0xd8]
	ldr r0, [r5]
	ldrh r2, [ip, #0xa]
	add r3, ip, #4
	ldrb r0, [r0, #1]
	ldrh r1, [r3, r2]
	add r2, r3, r2
	mla r0, r1, r0, r2
	ldr r0, [r0, #4]
	add r1, ip, r0
	ldrh r2, [r1, #0x1e]
	ands r0, r2, #0x2000
	beq _020D1124
	add r1, r1, #0x2c
	ands r0, r2, #2
	addeq r1, r1, #8
	ands r0, r2, #4
	addeq r1, r1, #4
	ands r0, r2, #8
	addeq r1, r1, #8
	mov r0, #0x18
	mov r2, #0x10
	bl NNS_G3dGeBufferOP_N
_020D1124:
	cmp r4, #3
	movne r0, #0
	bne _020D1150
	ldr r1, [r5, #8]
	mov r0, r5
	bic r1, r1, #0x40
	str r1, [r5, #8]
	ldr r1, [r5, #0x40]
	blx r1
	ldr r0, [r5, #8]
	and r0, r0, #0x40
_020D1150:
	cmp r0, #0
	bne _020D1280
	ldr r0, _020D12D0 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	ands r0, r1, #1
	beq _020D119C
	ldr r1, _020D12D4 // =0x02147320
	mov r0, #0x1c
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	ldr r1, _020D12D8 // =0x021472FC
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	add r1, sp, #0x10
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	b _020D11DC
_020D119C:
	ands r0, r1, #2
	beq _020D11B8
	add r1, sp, #0x10
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	b _020D11DC
_020D11B8:
	bl NNS_G3dGlbGetInvWV_ANOTHER_IDK
	mov r1, r0
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	add r1, sp, #0x10
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
_020D11DC:
	bl NNS_G3dGeFlushBuffer
	ldr r0, _020D12DC // =0x04000440
	mov r2, #0
	ldr r1, _020D12E0 // =0x04000444
	str r2, [r0]
	ldr r0, _020D12E4 // =0x04000454
	str r2, [r1]
	str r2, [r0]
	add r4, sp, #0x40
_020D1200:
	mov r0, r4
	bl G3X_GetClipMtx
	cmp r0, #0
	bne _020D1200
	ldr r1, _020D12E8 // =0x04000448
	mov r2, #1
	str r2, [r1]
	ldr r0, _020D12DC // =0x04000440
	mov r2, #3
	str r2, [r0]
	add r1, sp, #0x40
	mov r0, #0x16
	mov r2, #0x10
	bl NNS_G3dGeBufferOP_N
	ldr r1, [sp, #0x70]
	ldr r0, [sp, #0x74]
	mov r2, r1, asr #4
	mov r1, r0, asr #4
	mov r0, r2, lsl #8
	mov r1, r1, lsl #8
	mov r0, r0, asr #0x10
	mov r1, r1, asr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	orr r3, r2, r0, lsl #16
	add r1, sp, #4
	mov r0, #0x22
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
_020D1280:
	mov r3, #2
	add r1, sp, #8
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #8]
	bl NNS_G3dGeBufferOP_N
	mov r3, #0x1e
	add r1, sp, #0xc
	mov r0, #0x14
	mov r2, #1
	str r3, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
_020D12B0:
	ldr r0, [r5]
	add r0, r0, #3
	str r0, [r5]
	add sp, sp, #0x80
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020D12C4: .word 0x0211F4BC
_020D12C8: .word 0x0211F4C0
_020D12CC: .word 0x0211F4EC
_020D12D0: .word NNS_G3dGlb
_020D12D4: .word 0x02147320
_020D12D8: .word 0x021472FC
_020D12DC: .word 0x04000440
_020D12E0: .word 0x04000444
_020D12E4: .word 0x04000454
_020D12E8: .word 0x04000448
	arm_func_end NNSi_G3dFuncSbc_PRJMAP

	arm_func_start NNSi_G3dFuncSbc_ENVMAP
NNSi_G3dFuncSbc_ENVMAP: // 0x020D12EC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x44
	mov r7, r0
	ldr r1, [r7, #8]
	ands r0, r1, #0x200
	bne _020D15E4
	ands r0, r1, #1
	beq _020D15E4
	ldr r2, [r7, #0xb0]
	ldr r0, [r2, #0x10]
	and r1, r0, #0xc0000000
	cmp r1, #0x80000000
	beq _020D1358
	bic r0, r0, #0xc0000000
	str r0, [r2, #0x10]
	ldr r2, [r7, #0xb0]
	ldr r3, _020D15F8 // =_0211F4C4
	ldr r0, [r2, #0x10]
	ldr r1, _020D15FC // =_0211F4C8
	orr r0, r0, #0x80000000
	str r0, [r2, #0x10]
	ldr r2, [r7, #0xb0]
	ldr r0, [r3]
	ldr r4, [r2, #0x10]
	mov r2, #1
	str r4, [r3, #4]
	bl NNS_G3dGeBufferOP_N
_020D1358:
	mov r0, #3
	str r0, [sp]
	add r1, sp, #0
	mov r0, #0x10
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r0, [r7, #0x3c]
	cmp r0, #0
	ldrneb r6, [r7, #0x98]
	moveq r6, #0
	cmp r6, #1
	bne _020D13BC
	ldr r1, [r7, #8]
	mov r0, r7
	bic r1, r1, #0x40
	str r1, [r7, #8]
	ldr r1, [r7, #0x3c]
	blx r1
	ldr r0, [r7, #0x3c]
	cmp r0, #0
	ldrneb r6, [r7, #0x98]
	ldr r0, [r7, #8]
	moveq r6, #0
	and r0, r0, #0x40
	b _020D13C0
_020D13BC:
	mov r0, #0
_020D13C0:
	cmp r0, #0
	bne _020D1438
	ldr r0, [r7, #0xb0]
	add r1, sp, #0x38
	ldrh r4, [r0, #0x2e]
	ldrh r5, [r0, #0x2c]
	mov r3, #0x10000
	rsb r0, r4, #0
	mov ip, r0, lsl #0xf
	mov lr, r5, lsl #0xf
	mov r0, #0x1b
	mov r2, #3
	str lr, [sp, #0x38]
	str ip, [sp, #0x3c]
	str r3, [sp, #0x40]
	bl NNS_G3dGeBufferOP_N
	mov r0, r5, lsl #0x13
	mov r1, r4, lsl #0x13
	mov r0, r0, asr #0x10
	mov r1, r1, asr #0x10
	mov r0, r0, lsl #0x10
	mov r1, r1, lsl #0x10
	mov r2, r0, lsr #0x10
	mov r0, r1, lsr #0x10
	orr r3, r2, r0, lsl #16
	add r1, sp, #4
	mov r0, #0x22
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
_020D1438:
	cmp r6, #2
	bne _020D1474
	ldr r1, [r7, #8]
	mov r0, r7
	bic r1, r1, #0x40
	str r1, [r7, #8]
	ldr r1, [r7, #0x3c]
	blx r1
	ldr r0, [r7, #0x3c]
	cmp r0, #0
	ldrneb r6, [r7, #0x98]
	ldr r0, [r7, #8]
	moveq r6, #0
	and r0, r0, #0x40
	b _020D1478
_020D1474:
	mov r0, #0
_020D1478:
	cmp r0, #0
	bne _020D14DC
	ldr r4, [r7, #0xd8]
	ldr r0, [r7]
	ldrh r2, [r4, #0xa]
	add r3, r4, #4
	ldrb r0, [r0, #1]
	ldrh r1, [r3, r2]
	add r2, r3, r2
	mla r0, r1, r0, r2
	ldr r0, [r0, #4]
	add r1, r4, r0
	ldrh r2, [r1, #0x1e]
	ands r0, r2, #0x2000
	beq _020D14DC
	add r1, r1, #0x2c
	ands r0, r2, #2
	addeq r1, r1, #8
	ands r0, r2, #4
	addeq r1, r1, #4
	ands r0, r2, #8
	addeq r1, r1, #8
	mov r0, #0x18
	mov r2, #0x10
	bl NNS_G3dGeBufferOP_N
_020D14DC:
	cmp r6, #3
	movne r0, #0
	bne _020D1508
	ldr r1, [r7, #8]
	mov r0, r7
	bic r1, r1, #0x40
	str r1, [r7, #8]
	ldr r1, [r7, #0x3c]
	blx r1
	ldr r0, [r7, #8]
	and r0, r0, #0x40
_020D1508:
	cmp r0, #0
	bne _020D15CC
	mov r3, #2
	add r1, sp, #8
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #8]
	bl NNS_G3dGeBufferOP_N
	add r1, sp, #0x14
	mov r0, #0
	bl NNS_G3dGetCurrentMtx
	mov r3, #3
	add r1, sp, #0xc
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #0xc]
	bl NNS_G3dGeBufferOP_N
	ldr r0, _020D1600 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	ands r0, r1, #1
	beq _020D1590
	ldr r1, _020D1604 // =0x0214728C
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	ldr r1, _020D1608 // =0x021472FC
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	add r1, sp, #0x14
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	b _020D15CC
_020D1590:
	ands r0, r1, #2
	beq _020D15BC
	ldr r1, _020D1604 // =0x0214728C
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	add r1, sp, #0x14
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	b _020D15CC
_020D15BC:
	add r1, sp, #0x14
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
_020D15CC:
	mov r3, #2
	add r1, sp, #0x10
	mov r0, #0x10
	mov r2, #1
	str r3, [sp, #0x10]
	bl NNS_G3dGeBufferOP_N
_020D15E4:
	ldr r0, [r7]
	add r0, r0, #3
	str r0, [r7]
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D15F8: .word 0x0211F4C4
_020D15FC: .word 0x0211F4C8
_020D1600: .word NNS_G3dGlb
_020D1604: .word 0x0214728C
_020D1608: .word 0x021472FC
	arm_func_end NNSi_G3dFuncSbc_ENVMAP

	arm_func_start NNSi_G3dFuncSbc_POSSCALE
NNSi_G3dFuncSbc_POSSCALE: // 0x020D160C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, r0
	ldr r2, [r4, #8]
	ands r0, r2, #0x100
	bne _020D1660
	ands r0, r2, #0x200
	bne _020D1660
	cmp r1, #0
	ldreq r0, [r4, #0xe0]
	add r1, sp, #0
	streq r0, [sp, #8]
	streq r0, [sp, #4]
	streq r0, [sp]
	ldrne r0, [r4, #0xe4]
	mov r2, #3
	strne r0, [sp, #8]
	strne r0, [sp, #4]
	strne r0, [sp]
	mov r0, #0x1b
	bl NNS_G3dGeBufferOP_N
_020D1660:
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4]
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	arm_func_end NNSi_G3dFuncSbc_POSSCALE

	arm_func_start NNSi_G3dFuncSbc_CALLDL
NNSi_G3dFuncSbc_CALLDL: // 0x020D1674
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r0, [r5, #0x34]
	cmp r0, #0
	ldrneb r4, [r5, #0x96]
	moveq r4, #0
	cmp r4, #1
	bne _020D16C8
	ldr r1, [r5, #8]
	mov r0, r5
	bic r1, r1, #0x40
	str r1, [r5, #8]
	ldr r1, [r5, #0x34]
	blx r1
	ldr r0, [r5, #0x34]
	cmp r0, #0
	ldrneb r4, [r5, #0x96]
	ldr r0, [r5, #8]
	moveq r4, #0
	and r1, r0, #0x40
	b _020D16CC
_020D16C8:
	mov r1, #0
_020D16CC:
	ldr r0, [r5, #8]
	ands r0, r0, #0x100
	bne _020D1724
	cmp r1, #0
	bne _020D1724
	ldr r0, [r5]
	ldrb ip, [r0, #1]
	ldrb r3, [r0, #2]
	ldrb lr, [r0, #3]
	ldrb r2, [r0, #5]
	ldrb r1, [r0, #6]
	orr r3, ip, r3, lsl #8
	ldrb r6, [r0, #4]
	orr ip, r3, lr, lsl #16
	ldrb r3, [r0, #7]
	orr r1, r2, r1, lsl #8
	orr r6, ip, r6, lsl #24
	ldrb r2, [r0, #8]
	orr r1, r1, r3, lsl #16
	add r0, r0, r6
	orr r1, r1, r2, lsl #24
	bl NNS_G3dGeSendDL
_020D1724:
	cmp r4, #3
	bne _020D1744
	ldr r1, [r5, #8]
	mov r0, r5
	bic r1, r1, #0x40
	str r1, [r5, #8]
	ldr r1, [r5, #0x34]
	blx r1
_020D1744:
	ldr r0, [r5]
	add r0, r0, #9
	str r0, [r5]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNSi_G3dFuncSbc_CALLDL

	arm_func_start NNSi_G3dFuncSbc_NODEMIX
NNSi_G3dFuncSbc_NODEMIX: // 0x020D1754
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x8c
	ldr r1, [r0, #4]
	ldr r4, [r0]
	ldr r6, [r1, #4]
	ldrb r2, [r4, #2]
	ldr r3, [r6, #0x10]
	mov r10, #0
	str r0, [sp]
	str r2, [sp, #8]
	add r3, r6, r3
	add r1, sp, #0x34
	mov r0, r10
	mov r2, #0x54
	mov r9, r10
	str r3, [sp, #4]
	add r8, r4, #3
	bl MIi_CpuClearFast
	bl NNS_G3dGeFlushBuffer
	ldr r0, _020D1DA8 // =0x04000440
	mov r7, r10
	str r7, [r0]
	mov r0, #1
	ldr r2, _020D1DAC // =0x0400044C
	ldr r1, _020D1DB0 // =0x04000454
	str r0, [r2]
	str r0, [sp, #0x10]
	str r7, [r1]
	mov r1, #2
	ldr r0, _020D1DA8 // =0x04000440
	str r1, [sp, #0x14]
	str r1, [r0]
	ldr r0, [sp, #8]
	cmp r0, #0
	bls _020D1BC8
_020D17E0:
	ldrb r4, [r8, #1]
	mov r0, #0x64
	ldr r3, _020D1DB4 // =0x021488A8
	mul r0, r4, r0
	str r0, [sp, #0xc]
	ldr r0, [sp]
	mov r1, r4, lsr #5
	add r0, r0, r1, lsl #2
	ldr r1, [sp, #0x10]
	and r2, r4, #0x1f
	mov r1, r1, lsl r2
	ldr r11, [r0, #0xcc]
	ldr r2, [sp, #0xc]
	ands r11, r1, r11
	add r6, r3, r2
	bne _020D1854
	ldr r3, [r0, #0xcc]
	mov r2, #0x54
	orr r1, r3, r1
	str r1, [r0, #0xcc]
	ldr r0, [sp, #4]
	ldr r1, _020D1DB8 // =0x04000450
	mla r0, r4, r2, r0
	ldrb r2, [r8]
	str r2, [r1]
	ldr r2, [sp, #0x10]
	ldr r1, _020D1DA8 // =0x04000440
	str r2, [r1]
	bl G3_MultMtx43
_020D1854:
	cmp r7, #0
	beq _020D19FC
	ldr r2, [sp, #0x6c]
	ldr r1, [r5]
	str r2, [sp, #0x18]
	ldr r2, [sp, #0x70]
	mov r0, r1, asr #0x1f
	str r2, [sp, #0x1c]
	ldr r2, [sp, #0x74]
	ldr ip, [sp, #0x64]
	str r2, [sp, #0x20]
	ldr r2, [sp, #0x78]
	ldr lr, [sp, #0x68]
	str r2, [sp, #0x24]
	ldr r2, [sp, #0x7c]
	str r2, [sp, #0x28]
	ldr r2, [sp, #0x80]
	str r2, [sp, #0x2c]
	ldr r2, [sp, #0x84]
	str r2, [sp, #0x30]
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r0, r3, lsr #0xc
	orr r0, r0, r2, lsl #20
	adds r0, ip, r0
	str r0, [sp, #0x64]
	ldr r1, [r5, #4]
	mov r0, r1, asr #0x1f
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r0, r3, lsr #0xc
	orr r0, r0, r2, lsl #20
	adds r0, lr, r0
	str r0, [sp, #0x68]
	ldr r1, [r5, #8]
	mov r0, r1, asr #0x1f
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r1, r3, lsr #0xc
	ldr r0, [sp, #0x18]
	orr r1, r1, r2, lsl #20
	adds r0, r0, r1
	str r0, [sp, #0x6c]
	ldr r1, [r5, #0xc]
	mov r0, r1, asr #0x1f
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r1, r3, lsr #0xc
	ldr r0, [sp, #0x1c]
	orr r1, r1, r2, lsl #20
	adds r0, r0, r1
	str r0, [sp, #0x70]
	ldr r1, [r5, #0x10]
	mov r0, r1, asr #0x1f
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r1, r3, lsr #0xc
	ldr r0, [sp, #0x20]
	orr r1, r1, r2, lsl #20
	adds r0, r0, r1
	str r0, [sp, #0x74]
	ldr r1, [r5, #0x14]
	mov r0, r1, asr #0x1f
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r1, r3, lsr #0xc
	ldr r0, [sp, #0x24]
	orr r1, r1, r2, lsl #20
	adds r0, r0, r1
	str r0, [sp, #0x78]
	ldr r1, [r5, #0x18]
	mov r0, r1, asr #0x1f
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r1, r3, lsr #0xc
	ldr r0, [sp, #0x28]
	orr r1, r1, r2, lsl #20
	adds r0, r0, r1
	str r0, [sp, #0x7c]
	ldr r1, [r5, #0x1c]
	mov r0, r1, asr #0x1f
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r1, r3, lsr #0xc
	ldr r0, [sp, #0x2c]
	orr r1, r1, r2, lsl #20
	adds r0, r0, r1
	str r0, [sp, #0x80]
	ldr r1, [r5, #0x20]
	mov r0, r1, asr #0x1f
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r1, r3, lsr #0xc
	ldr r0, [sp, #0x30]
	orr r1, r1, r2, lsl #20
	adds r0, r0, r1
	str r0, [sp, #0x84]
_020D19FC:
	cmp r11, #0
	bne _020D1A34
_020D1A04:
	mov r0, r6
	bl G3X_GetClipMtx
	cmp r0, #0
	bne _020D1A04
	ldr r1, [sp, #0x14]
	ldr r0, _020D1DA8 // =0x04000440
	str r1, [r0]
	ldr r0, [sp, #4]
	mov r1, #0x54
	mla r0, r4, r1, r0
	add r0, r0, #0x30
	bl G3_MultMtx33
_020D1A34:
	ldrb r1, [r8, #2]
	ldr r2, [sp, #0x34]
	ldr r0, [r6]
	mov r10, r1, lsl #4
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r2, r1
	str r0, [sp, #0x34]
	mov r9, r10, asr #0x1f
	ldr r2, [sp, #0x38]
	ldr r0, [r6, #4]
	ldr r3, [sp, #0x3c]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r2, r1
	str r0, [sp, #0x38]
	ldr r0, [r6, #8]
	ldr r2, [sp, #0x40]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r3, r1
	str r0, [sp, #0x3c]
	ldr r0, [r6, #0x10]
	ldr r3, [sp, #0x44]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r2, r1
	str r0, [sp, #0x40]
	ldr r0, [r6, #0x14]
	ldr r2, [sp, #0x48]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r3, r1
	str r0, [sp, #0x44]
	ldr r0, [r6, #0x18]
	ldr r3, [sp, #0x4c]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r2, r1
	str r0, [sp, #0x48]
	ldr r0, [r6, #0x20]
	ldr r2, [sp, #0x50]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r3, r1
	str r0, [sp, #0x4c]
	ldr r0, [r6, #0x24]
	ldr r3, [sp, #0x54]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r2, r1
	str r0, [sp, #0x50]
	ldr r0, [r6, #0x28]
	ldr r2, [sp, #0x58]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r3, r1
	str r0, [sp, #0x54]
	ldr r0, [r6, #0x30]
	ldr r3, [sp, #0x5c]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r2, r1
	str r0, [sp, #0x58]
	ldr r0, [r6, #0x34]
	ldr r2, [sp, #0x60]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r3, r1
	str r0, [sp, #0x5c]
	ldr r0, [r6, #0x38]
	smull r1, r0, r10, r0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r0, r2, r1
	str r0, [sp, #0x60]
	cmp r11, #0
	ldr r1, _020D1DBC // =0x021488E8
	ldr r0, [sp, #0xc]
	add r5, r1, r0
	add r8, r8, #3
	bne _020D1BB8
_020D1BA8:
	mov r0, r5
	bl G3X_GetVectorMtx
	cmp r0, #0
	bne _020D1BA8
_020D1BB8:
	ldr r0, [sp, #8]
	add r7, r7, #1
	cmp r7, r0
	blo _020D17E0
_020D1BC8:
	ldr r1, [r5]
	ldr r4, [sp, #0x64]
	mov r0, r1, asr #0x1f
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r0, r3, lsr #0xc
	orr r0, r0, r2, lsl #20
	adds r0, r4, r0
	str r0, [sp, #0x64]
	ldr r1, [r5, #4]
	ldr r4, [sp, #0x68]
	mov r0, r1, asr #0x1f
	umull r3, r2, r10, r1
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	mov r0, r3, lsr #0xc
	orr r0, r0, r2, lsl #20
	adds r0, r4, r0
	str r0, [sp, #0x68]
	ldr r1, [r5, #8]
	ldr r4, [sp, #0x6c]
	umull r0, r2, r10, r1
	mov r3, r0, lsr #0xc
	mov r0, r1, asr #0x1f
	mla r2, r10, r0, r2
	mla r2, r9, r1, r2
	orr r3, r3, r2, lsl #20
	adds r0, r4, r3
	str r0, [sp, #0x6c]
	ldr r7, [r5, #0xc]
	ldr ip, [sp, #0x70]
	mov r6, r7, asr #0x1f
	umull r11, r8, r10, r7
	mla r8, r10, r6, r8
	mla r8, r9, r7, r8
	mov r6, r11, lsr #0xc
	orr r6, r6, r8, lsl #20
	adds r6, ip, r6
	str r6, [sp, #0x70]
	ldr r7, [r5, #0x10]
	ldr r4, [sp, #0x74]
	mov r6, r7, asr #0x1f
	umull r11, r8, r10, r7
	mla r8, r10, r6, r8
	mla r8, r9, r7, r8
	mov r6, r11, lsr #0xc
	orr r6, r6, r8, lsl #20
	adds r4, r4, r6
	str r4, [sp, #0x74]
	ldr r6, [r5, #0x14]
	ldr r3, [sp, #0x78]
	mov r4, r6, asr #0x1f
	umull r8, r7, r10, r6
	mla r7, r10, r4, r7
	mla r7, r9, r6, r7
	mov r4, r8, lsr #0xc
	orr r4, r4, r7, lsl #20
	adds r3, r3, r4
	str r3, [sp, #0x78]
	ldr r4, [r5, #0x18]
	ldr r2, [sp, #0x7c]
	mov r3, r4, asr #0x1f
	umull r7, r6, r10, r4
	mla r6, r10, r3, r6
	mla r6, r9, r4, r6
	mov r3, r7, lsr #0xc
	orr r3, r3, r6, lsl #20
	adds r2, r2, r3
	str r2, [sp, #0x7c]
	ldr r3, [r5, #0x1c]
	ldr r1, [sp, #0x80]
	mov r2, r3, asr #0x1f
	umull r6, r4, r10, r3
	mla r4, r10, r2, r4
	mla r4, r9, r3, r4
	mov r2, r6, lsr #0xc
	orr r2, r2, r4, lsl #20
	adds r1, r1, r2
	str r1, [sp, #0x80]
	ldr r2, [r5, #0x20]
	ldr lr, [sp, #0x84]
	mov r1, r2, asr #0x1f
	umull r4, r3, r10, r2
	mla r3, r10, r1, r3
	mla r3, r9, r2, r3
	mov r1, r4, lsr #0xc
	orr r1, r1, r3, lsl #20
	adds r1, lr, r1
	add r0, sp, #0x64
	str r1, [sp, #0x84]
	bl G3_LoadMtx43
	ldr r1, _020D1DA8 // =0x04000440
	mov r2, #1
	add r0, sp, #0x34
	str r2, [r1]
	bl G3_LoadMtx43
	ldr r3, _020D1DA8 // =0x04000440
	mov r0, #0
	str r0, [r3]
	ldr r1, _020D1DB8 // =0x04000450
	mov r2, #1
	mov r0, #2
	str r2, [r1]
	str r0, [r3]
	ldr r0, [sp]
	ldr r1, [r0]
	ldr r0, _020D1DAC // =0x0400044C
	ldrb r2, [r1, #1]
	mov r1, #3
	str r2, [r0]
	ldr r0, [sp]
	ldr r2, [r0]
	ldrb r0, [r2, #2]
	add r0, r0, #1
	mla r1, r0, r1, r2
	ldr r0, [sp]
	str r1, [r0]
	add sp, sp, #0x8c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020D1DA8: .word 0x04000440
_020D1DAC: .word 0x0400044C
_020D1DB0: .word 0x04000454
_020D1DB4: .word 0x021488A8
_020D1DB8: .word 0x04000450
_020D1DBC: .word 0x021488E8
	arm_func_end NNSi_G3dFuncSbc_NODEMIX

	arm_func_start NNSi_G3dFuncSbc_BBY
NNSi_G3dFuncSbc_BBY: // 0x020D1DC0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xcc
	mov r10, r0
	ldr r2, [r10, #8]
	mov r9, r1
	ands r0, r2, #0x200
	mov r7, #2
	ldr r6, _020D2124 // =_0211F5A4
	ldr r11, _020D2128 // =_0211F5B0
	ldr r5, _020D212C // =_0211F580
	beq _020D1E28
	cmp r9, #0x40
	beq _020D1DFC
	cmp r9, #0x60
	bne _020D1E00
_020D1DFC:
	add r7, r7, #1
_020D1E00:
	cmp r9, #0x20
	beq _020D1E10
	cmp r9, #0x60
	bne _020D1E14
_020D1E10:
	add r7, r7, #1
_020D1E14:
	ldr r0, [r10]
	add sp, sp, #0xcc
	add r0, r0, r7
	str r0, [r10]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020D1E28:
	cmp r9, #0x40
	beq _020D1E38
	cmp r9, #0x60
	bne _020D1E70
_020D1E38:
	add r7, r7, #1
	ands r0, r2, #0x100
	bne _020D1E70
	cmp r9, #0x40
	ldreq r0, [r10]
	add r1, sp, #0
	ldreqb r0, [r0, #2]
	mov r2, #1
	streq r0, [sp]
	ldrne r0, [r10]
	ldrneb r0, [r0, #3]
	strne r0, [sp]
	mov r0, #0x14
	bl NNS_G3dGeBufferOP_N
_020D1E70:
	ldr r0, [r10, #0x2c]
	cmp r0, #0
	ldrneb r8, [r10, #0x94]
	moveq r8, #0
	cmp r8, #1
	bne _020D1EBC
	ldr r1, [r10, #8]
	mov r0, r10
	bic r1, r1, #0x40
	str r1, [r10, #8]
	ldr r1, [r10, #0x2c]
	blx r1
	ldr r0, [r10, #0x2c]
	cmp r0, #0
	ldrneb r8, [r10, #0x94]
	ldr r0, [r10, #8]
	moveq r8, #0
	and r1, r0, #0x40
	b _020D1EC0
_020D1EBC:
	mov r1, #0
_020D1EC0:
	ldr r0, [r10, #8]
	ands r0, r0, #0x100
	bne _020D20A0
	cmp r1, #0
	bne _020D20A0
	bl NNS_G3dGeFlushBuffer
	ldr r2, _020D2130 // =0x00151110
	ldr r1, _020D2134 // =0x04000400
	mov r0, #0
	str r2, [r1]
	str r0, [r1]
	str r0, [r1]
	add r4, sp, #8
_020D1EF4:
	mov r0, r4
	bl G3X_GetClipMtx
	cmp r0, #0
	bne _020D1EF4
	ldr r0, _020D2138 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	ands r0, r1, #1
	beq _020D1F34
	bl NNS_G3dGlbGetWV
	add r1, sp, #0x48
	bl MTX_Copy43To44_
	add r0, sp, #8
	add r1, sp, #0x48
	mov r2, r0
	bl MTX_Concat44
	b _020D1F58
_020D1F34:
	ands r0, r1, #2
	beq _020D1F58
	ldr r0, _020D213C // =0x0214728C
	add r1, sp, #0x88
	bl MTX_Copy43To44_
	add r0, sp, #8
	add r1, sp, #0x88
	mov r2, r0
	bl MTX_Concat44
_020D1F58:
	ldr r1, [sp, #0x38]
	add r0, sp, #8
	str r1, [r6]
	ldr r1, [sp, #0x3c]
	str r1, [r6, #4]
	ldr r1, [sp, #0x40]
	str r1, [r6, #8]
	bl VEC_Mag
	str r0, [r11]
	add r0, sp, #0x18
	bl VEC_Mag
	str r0, [r11, #4]
	add r0, sp, #0x28
	bl VEC_Mag
	str r0, [r11, #8]
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	bne _020D1FAC
	ldr r0, [sp, #0x20]
	cmp r0, #0
	beq _020D1FD0
_020D1FAC:
	add r0, sp, #0x18
	add r1, r5, #0xc
	bl VEC_Normalize
	ldr r0, [r5, #0x14]
	rsb r0, r0, #0
	str r0, [r5, #0x1c]
	ldr r0, [r5, #0x10]
	str r0, [r5, #0x20]
	b _020D1FF0
_020D1FD0:
	add r0, sp, #0x28
	add r1, r5, #0x18
	bl VEC_Normalize
	ldr r0, [r5, #0x1c]
	rsb r0, r0, #0
	str r0, [r5, #0x14]
	ldr r0, [r5, #0x20]
	str r0, [r5, #0x10]
_020D1FF0:
	ldr r0, _020D2138 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	ands r0, r1, #1
	beq _020D2044
	ldr r3, _020D2140 // =0x00171012
	ldr r1, _020D2134 // =0x04000400
	ldr r0, _020D2144 // =_0211F578
	mov r2, #8
	str r3, [r1]
	bl MIi_CpuSend32
	bl NNS_G3dGlbGetInvWV
	ldr r1, _020D2134 // =0x04000400
	mov r2, #0x30
	bl MIi_CpuSend32
	ldr r2, _020D2148 // =0x00001B19
	ldr r1, _020D2134 // =0x04000400
	ldr r0, _020D212C // =_0211F580
	str r2, [r1]
	mov r2, #0x3c
	bl MIi_CpuSend32
	b _020D20A0
_020D2044:
	ands r0, r1, #2
	beq _020D2090
	ldr r3, _020D2140 // =0x00171012
	ldr r1, _020D2134 // =0x04000400
	ldr r0, _020D2144 // =_0211F578
	mov r2, #8
	str r3, [r1]
	bl MIi_CpuSend32
	bl NNS_G3dGlbGetInvWV_ANOTHER_IDK
	ldr r1, _020D2134 // =0x04000400
	mov r2, #0x30
	bl MIi_CpuSend32
	ldr r2, _020D2148 // =0x00001B19
	ldr r1, _020D2134 // =0x04000400
	ldr r0, _020D212C // =_0211F580
	str r2, [r1]
	mov r2, #0x3c
	bl MIi_CpuSend32
	b _020D20A0
_020D2090:
	ldr r0, _020D214C // =_0211F574
	ldr r1, _020D2134 // =0x04000400
	mov r2, #0x48
	bl MIi_CpuSend32
_020D20A0:
	cmp r8, #3
	movne r0, #0
	bne _020D20CC
	ldr r1, [r10, #8]
	mov r0, r10
	bic r1, r1, #0x40
	str r1, [r10, #8]
	ldr r1, [r10, #0x2c]
	blx r1
	ldr r0, [r10, #8]
	and r0, r0, #0x40
_020D20CC:
	cmp r9, #0x20
	beq _020D20DC
	cmp r9, #0x60
	bne _020D2110
_020D20DC:
	cmp r0, #0
	add r7, r7, #1
	bne _020D2110
	ldr r0, [r10, #8]
	ands r0, r0, #0x100
	bne _020D2110
	ldr r0, [r10]
	add r1, sp, #4
	ldrb r3, [r0, #2]
	mov r0, #0x13
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
_020D2110:
	ldr r0, [r10]
	add r0, r0, r7
	str r0, [r10]
	add sp, sp, #0xcc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020D2124: .word 0x0211F5A4
_020D2128: .word 0x0211F5B0
_020D212C: .word 0x0211F580
_020D2130: .word 0x00151110
_020D2134: .word 0x04000400
_020D2138: .word NNS_G3dGlb
_020D213C: .word 0x0214728C
_020D2140: .word 0x00171012
_020D2144: .word 0x0211F578
_020D2148: .word 0x00001B19
_020D214C: .word 0x0211F574
	arm_func_end NNSi_G3dFuncSbc_BBY

	arm_func_start NNSi_G3dFuncSbc_BB
NNSi_G3dFuncSbc_BB: // 0x020D2150
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0xc8
	mov r9, r0
	ldr r2, [r9, #8]
	mov r8, r1
	ands r0, r2, #0x200
	mov r6, #2
	ldr r5, _020D2454 // =_0211F55C
	ldr r4, _020D2458 // =_0211F568
	beq _020D21B4
	cmp r8, #0x40
	beq _020D2188
	cmp r8, #0x60
	bne _020D218C
_020D2188:
	add r6, r6, #1
_020D218C:
	cmp r8, #0x20
	beq _020D219C
	cmp r8, #0x60
	bne _020D21A0
_020D219C:
	add r6, r6, #1
_020D21A0:
	ldr r0, [r9]
	add sp, sp, #0xc8
	add r0, r0, r6
	str r0, [r9]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020D21B4:
	cmp r8, #0x40
	beq _020D21C4
	cmp r8, #0x60
	bne _020D21FC
_020D21C4:
	add r6, r6, #1
	ands r0, r2, #0x100
	bne _020D21FC
	cmp r8, #0x40
	ldreq r0, [r9]
	add r1, sp, #0
	ldreqb r0, [r0, #2]
	mov r2, #1
	streq r0, [sp]
	ldrne r0, [r9]
	ldrneb r0, [r0, #3]
	strne r0, [sp]
	mov r0, #0x14
	bl NNS_G3dGeBufferOP_N
_020D21FC:
	ldr r0, [r9, #0x28]
	cmp r0, #0
	ldrneb r7, [r9, #0x93]
	moveq r7, #0
	cmp r7, #1
	bne _020D2248
	ldr r1, [r9, #8]
	mov r0, r9
	bic r1, r1, #0x40
	str r1, [r9, #8]
	ldr r1, [r9, #0x28]
	blx r1
	ldr r0, [r9, #0x28]
	cmp r0, #0
	ldrneb r7, [r9, #0x93]
	ldr r0, [r9, #8]
	moveq r7, #0
	and r1, r0, #0x40
	b _020D224C
_020D2248:
	mov r1, #0
_020D224C:
	ldr r0, [r9, #8]
	ands r0, r0, #0x100
	bne _020D23D0
	cmp r1, #0
	bne _020D23D0
	bl NNS_G3dGeFlushBuffer
	ldr r2, _020D245C // =0x00151110
	ldr r1, _020D2460 // =0x04000400
	mov r0, #0
	str r2, [r1]
	str r0, [r1]
	str r0, [r1]
	add r10, sp, #8
_020D2280:
	mov r0, r10
	bl G3X_GetClipMtx
	cmp r0, #0
	bne _020D2280
	ldr r0, _020D2464 // =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	ands r0, r1, #1
	beq _020D22C0
	bl NNS_G3dGlbGetWV
	add r1, sp, #0x48
	bl MTX_Copy43To44_
	add r0, sp, #8
	add r1, sp, #0x48
	mov r2, r0
	bl MTX_Concat44
	b _020D22E4
_020D22C0:
	ands r0, r1, #2
	beq _020D22E4
	ldr r0, _020D2468 // =0x0214728C
	add r1, sp, #0x88
	bl MTX_Copy43To44_
	add r0, sp, #8
	add r1, sp, #0x88
	mov r2, r0
	bl MTX_Concat44
_020D22E4:
	ldr r1, [sp, #0x38]
	add r0, sp, #8
	str r1, [r5]
	ldr r1, [sp, #0x3c]
	str r1, [r5, #4]
	ldr r1, [sp, #0x40]
	str r1, [r5, #8]
	bl VEC_Mag
	str r0, [r4]
	add r0, sp, #0x18
	bl VEC_Mag
	str r0, [r4, #4]
	add r0, sp, #0x28
	bl VEC_Mag
	ldr r1, _020D2464 // =NNS_G3dGlb
	str r0, [r4, #8]
	ldr r1, [r1, #0xfc]
	ands r0, r1, #1
	beq _020D2374
	ldr r3, _020D246C // =0x00171012
	ldr r1, _020D2460 // =0x04000400
	ldr r0, _020D2470 // =_0211F530
	mov r2, #8
	str r3, [r1]
	bl MIi_CpuSend32
	bl NNS_G3dGlbGetInvWV
	ldr r1, _020D2460 // =0x04000400
	mov r2, #0x30
	bl MIi_CpuSend32
	ldr r2, _020D2474 // =0x00001B19
	ldr r1, _020D2460 // =0x04000400
	ldr r0, _020D2478 // =_0211F538
	str r2, [r1]
	mov r2, #0x3c
	bl MIi_CpuSend32
	b _020D23D0
_020D2374:
	ands r0, r1, #2
	beq _020D23C0
	ldr r3, _020D246C // =0x00171012
	ldr r1, _020D2460 // =0x04000400
	ldr r0, _020D2470 // =_0211F530
	mov r2, #8
	str r3, [r1]
	bl MIi_CpuSend32
	bl NNS_G3dGlbGetInvWV_ANOTHER_IDK
	ldr r1, _020D2460 // =0x04000400
	mov r2, #0x30
	bl MIi_CpuSend32
	ldr r2, _020D2474 // =0x00001B19
	ldr r1, _020D2460 // =0x04000400
	ldr r0, _020D2478 // =_0211F538
	str r2, [r1]
	mov r2, #0x3c
	bl MIi_CpuSend32
	b _020D23D0
_020D23C0:
	ldr r0, _020D247C // =_0211F52C
	ldr r1, _020D2460 // =0x04000400
	mov r2, #0x48
	bl MIi_CpuSend32
_020D23D0:
	cmp r7, #3
	movne r0, #0
	bne _020D23FC
	ldr r1, [r9, #8]
	mov r0, r9
	bic r1, r1, #0x40
	str r1, [r9, #8]
	ldr r1, [r9, #0x28]
	blx r1
	ldr r0, [r9, #8]
	and r0, r0, #0x40
_020D23FC:
	cmp r8, #0x20
	beq _020D240C
	cmp r8, #0x60
	bne _020D2440
_020D240C:
	cmp r0, #0
	add r6, r6, #1
	bne _020D2440
	ldr r0, [r9, #8]
	ands r0, r0, #0x100
	bne _020D2440
	ldr r0, [r9]
	add r1, sp, #4
	ldrb r3, [r0, #2]
	mov r0, #0x13
	mov r2, #1
	str r3, [sp, #4]
	bl NNS_G3dGeBufferOP_N
_020D2440:
	ldr r0, [r9]
	add r0, r0, r6
	str r0, [r9]
	add sp, sp, #0xc8
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020D2454: .word 0x0211F55C
_020D2458: .word 0x0211F568
_020D245C: .word 0x00151110
_020D2460: .word 0x04000400
_020D2464: .word NNS_G3dGlb
_020D2468: .word 0x0214728C
_020D246C: .word 0x00171012
_020D2470: .word 0x0211F530
_020D2474: .word 0x00001B19
_020D2478: .word 0x0211F538
_020D247C: .word 0x0211F52C
	arm_func_end NNSi_G3dFuncSbc_BB

	arm_func_start NNSi_G3dFuncSbc_NODEDESC
NNSi_G3dFuncSbc_NODEDESC: // 0x020D2480
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r10, r0
	ldr r0, [r10]
	mov r9, r1
	ldrb r4, [r0, #1]
	mov r7, #4
	strb r4, [r10, #0xae]
	ldr r0, [r10, #8]
	orr r0, r0, #0x10
	str r0, [r10, #8]
	ldr r1, [r10, #8]
	ands r0, r1, #0x400
	beq _020D2518
	cmp r9, #0x40
	beq _020D24C8
	cmp r9, #0x60
	bne _020D24CC
_020D24C8:
	add r7, r7, #1
_020D24CC:
	cmp r9, #0x20
	beq _020D24DC
	cmp r9, #0x60
	bne _020D2504
_020D24DC:
	add r7, r7, #1
	ands r0, r1, #0x100
	bne _020D2504
	ldr r0, [r10]
	add r1, sp, #8
	ldrb r3, [r0, #4]
	mov r0, #0x14
	mov r2, #1
	str r3, [sp, #8]
	bl NNS_G3dGeBufferOP_N
_020D2504:
	ldr r0, [r10]
	add sp, sp, #0x14
	add r0, r0, r7
	str r0, [r10]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020D2518:
	cmp r9, #0x40
	beq _020D2528
	cmp r9, #0x60
	bne _020D2564
_020D2528:
	cmp r9, #0x40
	ldreq r0, [r10]
	add r7, r7, #1
	ldreqb r0, [r0, #4]
	streq r0, [sp, #0xc]
	ldrne r0, [r10]
	ldrneb r0, [r0, #5]
	strne r0, [sp, #0xc]
	ldr r0, [r10, #8]
	ands r0, r0, #0x100
	bne _020D2564
	add r1, sp, #0xc
	mov r0, #0x14
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
_020D2564:
	add r0, r10, #0x12c
	str r0, [r10, #0xb4]
	ldr r0, [r10, #0x24]
	cmp r0, #0
	ldrneb r8, [r10, #0x92]
	moveq r8, #0
	cmp r8, #1
	bne _020D25B8
	ldr r1, [r10, #8]
	mov r0, r10
	bic r1, r1, #0x40
	str r1, [r10, #8]
	ldr r1, [r10, #0x24]
	blx r1
	ldr r0, [r10, #0x24]
	cmp r0, #0
	ldrneb r8, [r10, #0x92]
	ldr r0, [r10, #8]
	moveq r8, #0
	and r0, r0, #0x40
	b _020D25BC
_020D25B8:
	mov r0, #0
_020D25BC:
	cmp r0, #0
	bne _020D27C8
	ldr r0, [r10, #4]
	ldr r1, [r0, #0x34]
	cmp r1, #0
	beq _020D25F0
	mov r0, #0x58
	mla r6, r4, r0, r1
	ldr r0, [r10, #8]
	ands r0, r0, #0x80
	moveq r0, #1
	movne r0, #0
	b _020D25F8
_020D25F0:
	add r6, r10, #0x12c
	mov r0, #0
_020D25F8:
	cmp r0, #0
	bne _020D27C4
	mov r0, #0
	str r0, [r6]
	ldr r0, [r10, #4]
	ldr r1, [r0, #0x10]
	cmp r1, #0
	beq _020D2630
	ldr r3, [r0, #0x14]
	mov r0, r6
	mov r2, r4
	blx r3
	cmp r0, #0
	bne _020D27C4
_020D2630:
	ldr r2, [r10, #0xd4]
	ldrh r0, [r2, #6]
	ldrh r1, [r2, r0]
	add r0, r2, r0
	mla r0, r1, r4, r0
	ldr r1, [r0, #4]
	ldrh r0, [r2, r1]
	add r4, r2, r1
	add r5, r4, #4
	ands r0, r0, #1
	ldrne r0, [r6]
	orrne r0, r0, #4
	strne r0, [r6]
	bne _020D2684
	ldr r0, [r5]
	str r0, [r6, #0x4c]
	ldr r0, [r5, #4]
	str r0, [r6, #0x50]
	ldr r0, [r5, #8]
	add r5, r5, #0xc
	str r0, [r6, #0x54]
_020D2684:
	ldrh r1, [r4]
	ands r0, r1, #2
	ldrne r0, [r6]
	orrne r0, r0, #2
	strne r0, [r6]
	bne _020D27AC
	ands r0, r1, #8
	beq _020D2760
	and r1, r1, #0xf0
	mov r11, r1, asr #4
	ldrsh r1, [r5]
	add r0, r6, #0x28
	str r1, [sp]
	ldrsh r1, [r5, #2]
	str r1, [sp, #4]
	blx MI_Zero36B
	ldrh r0, [r4]
	add r1, r6, r11, lsl #2
	add r5, r5, #4
	ands r0, r0, #0x100
	movne r0, #0x1000
	rsbne r2, r0, #0
	moveq r2, #0x1000
	str r2, [r1, #0x28]
	ldr r0, _020D28B0 // =_02112844
	ldr r1, _020D28B4 // =_02112845
	ldrb r0, [r0, r11, lsl #2]
	add r2, r6, r0, lsl #2
	ldr r0, [sp]
	str r0, [r2, #0x28]
	ldrb r0, [r1, r11, lsl #2]
	add r1, r6, r0, lsl #2
	ldr r0, [sp, #4]
	str r0, [r1, #0x28]
	ldrh r0, [r4]
	ands r0, r0, #0x200
	ldrne r0, [sp, #4]
	rsbne r0, r0, #0
	strne r0, [sp, #4]
	ldr r0, _020D28B8 // =_02112846
	ldrb r0, [r0, r11, lsl #2]
	add r1, r6, r0, lsl #2
	ldr r0, [sp, #4]
	str r0, [r1, #0x28]
	ldrh r0, [r4]
	ands r0, r0, #0x400
	ldrne r0, [sp]
	rsbne r0, r0, #0
	strne r0, [sp]
	ldr r0, _020D28BC // =_02112847
	ldrb r0, [r0, r11, lsl #2]
	add r1, r6, r0, lsl #2
	ldr r0, [sp]
	str r0, [r1, #0x28]
	b _020D27AC
_020D2760:
	ldrsh r0, [r4, #2]
	str r0, [r6, #0x28]
	ldrsh r0, [r5]
	str r0, [r6, #0x2c]
	ldrsh r0, [r5, #2]
	str r0, [r6, #0x30]
	ldrsh r0, [r5, #4]
	str r0, [r6, #0x34]
	ldrsh r0, [r5, #6]
	str r0, [r6, #0x38]
	ldrsh r0, [r5, #8]
	str r0, [r6, #0x3c]
	ldrsh r0, [r5, #0xa]
	str r0, [r6, #0x40]
	ldrsh r0, [r5, #0xc]
	str r0, [r6, #0x44]
	ldrsh r0, [r5, #0xe]
	add r5, r5, #0x10
	str r0, [r6, #0x48]
_020D27AC:
	ldrh r3, [r4]
	ldr r2, [r10]
	ldr r4, [r10, #0xe8]
	mov r0, r6
	mov r1, r5
	blx r4
_020D27C4:
	str r6, [r10, #0xb4]
_020D27C8:
	cmp r8, #2
	bne _020D2804
	ldr r1, [r10, #8]
	mov r0, r10
	bic r1, r1, #0x40
	str r1, [r10, #8]
	ldr r1, [r10, #0x24]
	blx r1
	ldr r0, [r10, #0x24]
	cmp r0, #0
	ldrneb r8, [r10, #0x92]
	ldr r0, [r10, #8]
	moveq r8, #0
	and r0, r0, #0x40
	b _020D2808
_020D2804:
	mov r0, #0
_020D2808:
	cmp r0, #0
	bne _020D2828
	ldr r0, [r10, #8]
	ands r0, r0, #0x100
	bne _020D2828
	ldr r0, [r10, #0xb4]
	ldr r1, [r10, #0xec]
	blx r1
_020D2828:
	mov r0, #0
	str r0, [r10, #0xb4]
	cmp r8, #3
	bne _020D2858
	ldr r1, [r10, #8]
	mov r0, r10
	bic r1, r1, #0x40
	str r1, [r10, #8]
	ldr r1, [r10, #0x24]
	blx r1
	ldr r0, [r10, #8]
	and r0, r0, #0x40
_020D2858:
	cmp r9, #0x20
	beq _020D2868
	cmp r9, #0x60
	bne _020D289C
_020D2868:
	cmp r0, #0
	add r7, r7, #1
	bne _020D289C
	ldr r0, [r10, #8]
	ands r0, r0, #0x100
	bne _020D289C
	ldr r0, [r10]
	add r1, sp, #0x10
	ldrb r3, [r0, #4]
	mov r0, #0x13
	mov r2, #1
	str r3, [sp, #0x10]
	bl NNS_G3dGeBufferOP_N
_020D289C:
	ldr r0, [r10]
	add r0, r0, r7
	str r0, [r10]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020D28B0: .word 0x02112844
_020D28B4: .word 0x02112845
_020D28B8: .word 0x02112846
_020D28BC: .word 0x02112847
	arm_func_end NNSi_G3dFuncSbc_NODEDESC

	arm_func_start NNSi_G3dFuncSbc_SHP
NNSi_G3dFuncSbc_SHP: // 0x020D28C0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r3, [r4, #8]
	ands r2, r3, #0x200
	bne _020D291C
	ands r2, r3, #1
	beq _020D291C
	ands r2, r3, #2
	bne _020D291C
	ldr r5, [r4, #0xdc]
	ldr r3, [r4]
	ldrh r2, [r5, #6]
	ldrb r3, [r3, #1]
	ldr ip, _020D2930 // =_0211F4DC
	ldrh lr, [r5, r2]
	add r2, r5, r2
	mla r2, lr, r3, r2
	ldr r2, [r2, #4]
	ldrh lr, [r5, r2]
	add r2, r5, r2
	ldr ip, [ip, lr, lsl #2]
	blx ip
_020D291C:
	ldr r0, [r4]
	add r0, r0, #2
	str r0, [r4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D2930: .word 0x0211F4DC
	arm_func_end NNSi_G3dFuncSbc_SHP

	arm_func_start NNSi_G3dFuncSbc_SHP_InternalDefault
NNSi_G3dFuncSbc_SHP_InternalDefault: // 0x020D2934
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x20]
	mov r5, r2
	cmp r0, #0
	ldrneb r4, [r6, #0x91]
	moveq r4, #0
	cmp r4, #1
	bne _020D298C
	ldr r1, [r6, #8]
	mov r0, r6
	bic r1, r1, #0x40
	str r1, [r6, #8]
	ldr r1, [r6, #0x20]
	blx r1
	ldr r0, [r6, #0x20]
	cmp r0, #0
	ldrneb r4, [r6, #0x91]
	ldr r0, [r6, #8]
	moveq r4, #0
	and r0, r0, #0x40
	b _020D2990
_020D298C:
	mov r0, #0
_020D2990:
	cmp r0, #0
	bne _020D29B4
	ldr r0, [r6, #8]
	ands r0, r0, #0x100
	bne _020D29B4
	ldr r0, [r5, #8]
	ldr r1, [r5, #0xc]
	add r0, r5, r0
	bl NNS_G3dGeSendDL
_020D29B4:
	cmp r4, #2
	bne _020D29E4
	ldr r1, [r6, #8]
	mov r0, r6
	bic r1, r1, #0x40
	str r1, [r6, #8]
	ldr r1, [r6, #0x20]
	blx r1
	ldr r0, [r6, #0x20]
	cmp r0, #0
	ldrneb r4, [r6, #0x91]
	moveq r4, #0
_020D29E4:
	cmp r4, #3
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #8]
	mov r0, r6
	bic r1, r1, #0x40
	str r1, [r6, #8]
	ldr r1, [r6, #0x20]
	blx r1
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNSi_G3dFuncSbc_SHP_InternalDefault

	arm_func_start NNSi_G3dFuncSbc_MAT
NNSi_G3dFuncSbc_MAT: // 0x020D2A08
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r0
	ldr r5, [r4, #8]
	ands r0, r5, #0x200
	bne _020D2A74
	ldr r2, [r4]
	ands r0, r5, #1
	ldrb r3, [r2, #1]
	bne _020D2A40
	ands r0, r5, #8
	beq _020D2A40
	ldrb r0, [r4, #0xad]
	cmp r3, r0
	beq _020D2A74
_020D2A40:
	ldr r6, [r4, #0xd8]
	ldr ip, _020D2A84 // =_0211F4CC
	ldrh r2, [r6, #0xa]
	add r5, r6, #4
	mov r0, r4
	ldrh lr, [r5, r2]
	add r2, r5, r2
	mla r2, lr, r3, r2
	ldr r2, [r2, #4]
	ldrh lr, [r6, r2]
	add r2, r6, r2
	ldr ip, [ip, lr, lsl #2]
	blx ip
_020D2A74:
	ldr r0, [r4]
	add r0, r0, #2
	str r0, [r4]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020D2A84: .word 0x0211F4CC
	arm_func_end NNSi_G3dFuncSbc_MAT

	arm_func_start NNSi_G3dFuncSbc_MAT_InternalDefault
NNSi_G3dFuncSbc_MAT_InternalDefault: // 0x020D2A88
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x20
	mov r8, r0
	mov r6, r3
	strb r6, [r8, #0xad]
	ldr r3, [r8, #8]
	add r0, r8, #0xf4
	orr r3, r3, #8
	str r3, [r8, #8]
	str r0, [r8, #0xb0]
	ldr r0, [r8, #0x1c]
	mov r4, r1
	cmp r0, #0
	ldrneb r5, [r8, #0x90]
	mov r7, r2
	moveq r5, #0
	cmp r5, #1
	bne _020D2B04
	ldr r1, [r8, #8]
	mov r0, r8
	bic r1, r1, #0x40
	str r1, [r8, #8]
	ldr r1, [r8, #0x1c]
	blx r1
	ldr r0, [r8, #0x1c]
	cmp r0, #0
	ldrneb r5, [r8, #0x90]
	ldr r0, [r8, #8]
	moveq r5, #0
	and r0, r0, #0x40
	b _020D2B08
_020D2B04:
	mov r0, #0
_020D2B08:
	cmp r0, #0
	bne _020D2DBC
	ldr r0, [r8, #4]
	ldr r0, [r0, #0x38]
	cmp r0, #0
	beq _020D2B34
	ldr r1, [r8, #8]
	ands r1, r1, #0x80
	moveq r1, #0x38
	mlaeq r4, r6, r1, r0
	beq _020D2DB8
_020D2B34:
	cmp r4, #0x20
	beq _020D2B44
	cmp r4, #0x40
	bne _020D2B80
_020D2B44:
	mov r1, r6, lsr #5
	add r1, r8, r1, lsl #2
	and r2, r6, #0x1f
	mov r3, #1
	mov r2, r3, lsl r2
	ldr r1, [r1, #0xbc]
	ands r1, r2, r1
	beq _020D2B80
	cmp r0, #0
	movne r1, #0x38
	mlane r4, r6, r1, r0
	ldreq r1, _020D2ED4 // =0x021474A8
	moveq r0, #0x38
	mlaeq r4, r6, r0, r1
	b _020D2DB8
_020D2B80:
	cmp r0, #0
	beq _020D2BB8
	add r4, r8, #0xbc
	mov r3, r6, lsr #5
	ldr r2, [r4, r3, lsl #2]
	and r0, r6, #0x1f
	mov r1, #1
	orr r0, r2, r1, lsl r0
	str r0, [r4, r3, lsl #2]
	ldr r1, [r8, #4]
	mov r0, #0x38
	ldr r1, [r1, #0x38]
	mla r4, r6, r0, r1
	b _020D2BEC
_020D2BB8:
	cmp r4, #0x40
	addne r4, r8, #0xf4
	bne _020D2BEC
	add lr, r8, #0xbc
	mov ip, r6, lsr #5
	ldr r1, _020D2ED4 // =0x021474A8
	ldr r4, [lr, ip, lsl #2]
	mov r0, #0x38
	and r2, r6, #0x1f
	mov r3, #1
	orr r2, r4, r3, lsl r2
	mla r4, r6, r0, r1
	str r2, [lr, ip, lsl #2]
_020D2BEC:
	mov r0, #0
	str r0, [r4]
	ldr r3, [r8, #0xd8]
	ldrh r0, [r3, #0xa]
	add r2, r3, #4
	ldrh r1, [r2, r0]
	add r0, r2, r0
	mla r0, r1, r6, r0
	ldr r0, [r0, #4]
	ldr r1, _020D2ED8 // =NNS_G3dGlb
	add r0, r3, r0
	ldrh r0, [r0, #0x1e]
	ands r0, r0, #0x20
	ldrne r0, [r4]
	orrne r0, r0, #0x20
	strne r0, [r4]
	ldrh r2, [r7, #0x1e]
	ldr r0, _020D2EDC // =_02112824
	ldr ip, [r1, #0x94]
	mov r2, r2, asr #6
	and r2, r2, #7
	ldr lr, [r0, r2, lsl #2]
	ldr r2, [r7, #4]
	mvn r3, lr
	and r3, ip, r3
	and r2, r2, lr
	orr r2, r3, r2
	str r2, [r4, #4]
	ldrh ip, [r7, #0x1e]
	ldr r3, [r1, #0x98]
	ldr r2, [r7, #8]
	mov ip, ip, asr #9
	and ip, ip, #7
	ldr ip, [r0, ip, lsl #2]
	mvn r0, ip
	and r3, r3, r0
	and r0, r2, ip
	orr r0, r3, r0
	str r0, [r4, #8]
	ldr r3, [r7, #0x10]
	ldr r0, [r7, #0xc]
	ldr r2, [r1, #0x9c]
	mvn r1, r3
	and r1, r2, r1
	and r0, r0, r3
	orr r0, r1, r0
	str r0, [r4, #0xc]
	ldr r0, [r7, #0x14]
	str r0, [r4, #0x10]
	ldrh r0, [r7, #0x1c]
	str r0, [r4, #0x14]
	ldrh r1, [r7, #0x1e]
	ands r0, r1, #1
	beq _020D2D4C
	ands r1, r1, #2
	ldrne r1, [r4]
	add r0, r7, #0x2c
	orrne r1, r1, #1
	strne r1, [r4]
	bne _020D2CF0
	ldr r1, [r0]
	str r1, [r4, #0x18]
	ldr r1, [r0, #4]
	add r0, r0, #8
	str r1, [r4, #0x1c]
_020D2CF0:
	ldrh r1, [r7, #0x1e]
	ands r1, r1, #4
	ldrne r1, [r4]
	orrne r1, r1, #2
	strne r1, [r4]
	bne _020D2D1C
	ldrsh r1, [r0]
	strh r1, [r4, #0x20]
	ldrsh r1, [r0, #2]
	add r0, r0, #4
	strh r1, [r4, #0x22]
_020D2D1C:
	ldrh r1, [r7, #0x1e]
	ands r1, r1, #8
	ldreq r1, [r0]
	streq r1, [r4, #0x24]
	ldreq r0, [r0, #4]
	streq r0, [r4, #0x28]
	ldrne r0, [r4]
	orrne r0, r0, #4
	strne r0, [r4]
	ldr r0, [r4]
	orr r0, r0, #8
	str r0, [r4]
_020D2D4C:
	ldr r0, [r8, #4]
	ldr r1, [r0, #8]
	cmp r1, #0
	beq _020D2D8C
	mov r2, r6, lsr #5
	add r2, r0, r2, lsl #2
	and r3, r6, #0x1f
	mov ip, #1
	mov r3, ip, lsl r3
	ldr r2, [r2, #0x3c]
	ands r2, r3, r2
	beq _020D2D8C
	ldr r3, [r0, #0xc]
	mov r0, r4
	mov r2, r6
	blx r3
_020D2D8C:
	ldr r0, [r4]
	ands r0, r0, #0x18
	beq _020D2DB8
	ldrh r0, [r7, #0x20]
	strh r0, [r4, #0x2c]
	ldrh r0, [r7, #0x22]
	strh r0, [r4, #0x2e]
	ldr r0, [r7, #0x24]
	str r0, [r4, #0x30]
	ldr r0, [r7, #0x28]
	str r0, [r4, #0x34]
_020D2DB8:
	str r4, [r8, #0xb0]
_020D2DBC:
	cmp r5, #2
	bne _020D2DF8
	ldr r1, [r8, #8]
	mov r0, r8
	bic r1, r1, #0x40
	str r1, [r8, #8]
	ldr r1, [r8, #0x1c]
	blx r1
	ldr r0, [r8, #0x1c]
	cmp r0, #0
	ldrneb r5, [r8, #0x90]
	ldr r0, [r8, #8]
	moveq r5, #0
	and r0, r0, #0x40
	b _020D2DFC
_020D2DF8:
	mov r0, #0
_020D2DFC:
	cmp r0, #0
	bne _020D2EA8
	ldr r4, [r8, #0xb0]
	ldr r1, [r4, #0xc]
	ands r0, r1, #0x1f0000
	beq _020D2E9C
	ldr r0, [r4]
	ands r0, r0, #0x20
	bicne r0, r1, #0x1f0000
	strne r0, [r4, #0xc]
	ldr r0, [r8, #8]
	bic r0, r0, #2
	str r0, [r8, #8]
	ldr r0, [r8, #8]
	ands r0, r0, #0x100
	bne _020D2EA8
	ldr r0, _020D2EE0 // =0x00293130
	ldr r3, _020D2EE4 // =0x00002B2A
	str r0, [sp]
	ldr r2, [r4, #4]
	add r1, sp, #4
	str r2, [sp, #4]
	ldr r6, [r4, #8]
	mov r2, #6
	str r6, [sp, #8]
	ldr r6, [r4, #0xc]
	str r6, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r3, [r4, #0x10]
	str r3, [sp, #0x14]
	ldr r3, [r4, #0x14]
	str r3, [sp, #0x18]
	bl NNS_G3dGeBufferOP_N
	ldr r0, [r4]
	ands r0, r0, #0x18
	beq _020D2EA8
	ldr r1, [r8, #0xf0]
	mov r0, r4
	blx r1
	b _020D2EA8
_020D2E9C:
	ldr r0, [r8, #8]
	orr r0, r0, #2
	str r0, [r8, #8]
_020D2EA8:
	cmp r5, #3
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [r8, #8]
	mov r0, r8
	bic r1, r1, #0x40
	str r1, [r8, #8]
	ldr r1, [r8, #0x1c]
	blx r1
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020D2ED4: .word 0x021474A8
_020D2ED8: .word NNS_G3dGlb
_020D2EDC: .word 0x02112824
_020D2EE0: .word 0x00293130
_020D2EE4: .word 0x00002B2A
	arm_func_end NNSi_G3dFuncSbc_MAT_InternalDefault

	arm_func_start NNSi_G3dFuncSbc_MTX
NNSi_G3dFuncSbc_MTX: // 0x020D2EE8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r1, [r5, #8]
	ands r0, r1, #0x200
	bne _020D2FA8
	ands r0, r1, #1
	beq _020D2FA8
	ldr r0, [r5, #0x18]
	cmp r0, #0
	ldrneb r4, [r5, #0x8f]
	moveq r4, #0
	cmp r4, #1
	bne _020D2F54
	ldr r1, [r5, #8]
	mov r0, r5
	bic r1, r1, #0x40
	str r1, [r5, #8]
	ldr r1, [r5, #0x18]
	blx r1
	ldr r0, [r5, #0x18]
	cmp r0, #0
	ldrneb r4, [r5, #0x8f]
	ldr r0, [r5, #8]
	moveq r4, #0
	and r0, r0, #0x40
	b _020D2F58
_020D2F54:
	mov r0, #0
_020D2F58:
	cmp r0, #0
	bne _020D2F88
	ldr r0, [r5]
	ldrb r0, [r0, #1]
	str r0, [sp]
	ldr r0, [r5, #8]
	ands r0, r0, #0x100
	bne _020D2F88
	add r1, sp, #0
	mov r0, #0x14
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
_020D2F88:
	cmp r4, #3
	bne _020D2FA8
	ldr r1, [r5, #8]
	mov r0, r5
	bic r1, r1, #0x40
	str r1, [r5, #8]
	ldr r1, [r5, #0x18]
	blx r1
_020D2FA8:
	ldr r0, [r5]
	add r0, r0, #2
	str r0, [r5]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNSi_G3dFuncSbc_MTX

	arm_func_start NNSi_G3dFuncSbc_NODE
NNSi_G3dFuncSbc_NODE: // 0x020D2FBC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #8]
	ands r0, r0, #0x200
	bne _020D3134
	ldr r1, [r6]
	add r0, r6, #0x184
	ldrb r1, [r1, #1]
	strb r1, [r6, #0xac]
	ldr r1, [r6, #8]
	ldrb r4, [r6, #0xac]
	orr r1, r1, #4
	str r1, [r6, #8]
	str r0, [r6, #0xb8]
	ldr r0, [r6, #0x14]
	cmp r0, #0
	ldrneb r5, [r6, #0x8e]
	moveq r5, #0
	cmp r5, #1
	bne _020D3040
	ldr r1, [r6, #8]
	mov r0, r6
	bic r1, r1, #0x40
	str r1, [r6, #8]
	ldr r1, [r6, #0x14]
	blx r1
	ldr r0, [r6, #0x14]
	cmp r0, #0
	ldrneb r5, [r6, #0x8e]
	ldr r0, [r6, #8]
	moveq r5, #0
	and r0, r0, #0x40
	b _020D3044
_020D3040:
	mov r0, #0
_020D3044:
	cmp r0, #0
	bne _020D30A8
	ldr ip, [r6, #4]
	ldr r1, [ip, #0x18]
	cmp r1, #0
	beq _020D3094
	mov r0, r4, lsr #5
	add r0, ip, r0, lsl #2
	and r2, r4, #0x1f
	mov r3, #1
	mov r2, r3, lsl r2
	ldr r0, [r0, #0x4c]
	ands r0, r2, r0
	beq _020D3094
	ldr r0, [r6, #0xb8]
	ldr r3, [ip, #0x1c]
	mov r2, r4
	blx r3
	cmp r0, #0
	bne _020D30A8
_020D3094:
	ldr r1, [r6]
	ldr r0, [r6, #0xb8]
	ldrb r1, [r1, #2]
	and r1, r1, #1
	str r1, [r0]
_020D30A8:
	cmp r5, #2
	bne _020D30E4
	ldr r1, [r6, #8]
	mov r0, r6
	bic r1, r1, #0x40
	str r1, [r6, #8]
	ldr r1, [r6, #0x14]
	blx r1
	ldr r0, [r6, #0x14]
	cmp r0, #0
	ldrneb r5, [r6, #0x8e]
	ldr r0, [r6, #8]
	moveq r5, #0
	and r0, r0, #0x40
	b _020D30E8
_020D30E4:
	mov r0, #0
_020D30E8:
	cmp r0, #0
	bne _020D3114
	ldr r0, [r6, #0xb8]
	ldr r0, [r0]
	cmp r0, #0
	ldrne r0, [r6, #8]
	orrne r0, r0, #1
	strne r0, [r6, #8]
	ldreq r0, [r6, #8]
	biceq r0, r0, #1
	streq r0, [r6, #8]
_020D3114:
	cmp r5, #3
	bne _020D3134
	ldr r1, [r6, #8]
	mov r0, r6
	bic r1, r1, #0x40
	str r1, [r6, #8]
	ldr r1, [r6, #0x14]
	blx r1
_020D3134:
	ldr r0, [r6]
	add r0, r0, #3
	str r0, [r6]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNSi_G3dFuncSbc_NODE

	arm_func_start NNSi_G3dFuncSbc_RET
NNSi_G3dFuncSbc_RET: // 0x020D3144
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x10]
	cmp r1, #0
	beq _020D315C
	blx r1
_020D315C:
	ldr r0, [r4, #8]
	orr r0, r0, #0x20
	str r0, [r4, #8]
	ldmia sp!, {r4, pc}
	arm_func_end NNSi_G3dFuncSbc_RET

	arm_func_start NNSi_G3dFuncSbc_NOP
NNSi_G3dFuncSbc_NOP: // 0x020D316C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0xc]
	cmp r1, #0
	beq _020D3184
	blx r1
_020D3184:
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4]
	ldmia sp!, {r4, pc}
	arm_func_end NNSi_G3dFuncSbc_NOP

	arm_func_start NNS_G3dDraw
NNS_G3dDraw: // 0x020D3194
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x188
	mov r4, r0
	ldr r0, [r4]
	and r0, r0, #0x10
	cmp r0, #0x10
	bne _020D3228
	add r1, r4, #0x3c
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	add r1, r4, #0x44
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	add r1, r4, #0x4c
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear32
	ldr r1, [r4, #8]
	cmp r1, #0
	beq _020D31F4
	add r0, r4, #0x3c
	bl updateHintVec_RealOne
_020D31F4:
	ldr r1, [r4, #0x10]
	cmp r1, #0
	beq _020D3208
	add r0, r4, #0x44
	bl updateHintVec_RealOne
_020D3208:
	ldr r1, [r4, #0x18]
	cmp r1, #0
	beq _020D321C
	add r0, r4, #0x4c
	bl updateHintVec_RealOne
_020D321C:
	ldr r0, [r4]
	bic r0, r0, #0x10
	str r0, [r4]
_020D3228:
	ldr r2, _020D326C // =_021474A4
	ldr r0, [r2]
	cmp r0, #0
	beq _020D3248
	mov r1, r4
	bl G3dDrawInternal_
	add sp, sp, #0x188
	ldmia sp!, {r4, pc}
_020D3248:
	add r0, sp, #0
	mov r1, r4
	str r0, [r2]
	bl G3dDrawInternal_
	ldr r0, _020D326C // =_021474A4
	mov r1, #0
	str r1, [r0]
	add sp, sp, #0x188
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D326C: .word _021474A4
	arm_func_end NNS_G3dDraw

	arm_func_start updateHintVec_RealOne
updateHintVec_RealOne: // 0x020D3270
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	mov r3, #1
	mov r4, #0
_020D328C:
	ldrb r2, [r1, #0x19]
	mov r5, r4
	cmp r2, #0
	ble _020D32CC
_020D329C:
	add r2, r1, r5, lsl #1
	ldrh r2, [r2, #0x1a]
	ands r2, r2, #0x100
	movne lr, r5, asr #5
	andne r2, r5, #0x1f
	ldrne ip, [r0, lr, lsl #2]
	add r5, r5, #1
	orrne r2, ip, r3, lsl r2
	strne r2, [r0, lr, lsl #2]
	ldrb r2, [r1, #0x19]
	cmp r5, r2
	blt _020D329C
_020D32CC:
	ldr r1, [r1, #0x10]
	cmp r1, #0
	bne _020D328C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end updateHintVec_RealOne

	arm_func_start G3dDrawInternal_
G3dDrawInternal_: // 0x020D32E0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	mov r1, r5
	mov r0, #0
	mov r2, #0x188
	bl MIi_CpuClearFast
	mov r0, #1
	str r0, [r5, #0xc4]
	str r0, [r5, #8]
	ldr r0, [r4, #0x30]
	ldr r2, _020D345C // =NNS_G3dGetJointScale_FuncArray
	cmp r0, #0
	strne r0, [r5]
	ldreq r1, [r4, #4]
	ldreq r0, [r1, #4]
	addeq r0, r1, r0
	streq r0, [r5]
	str r4, [r5, #4]
	ldr r0, [r4, #4]
	ldr r1, _020D3460 // =NNS_G3dSendJointSRT_FuncArray
	add r0, r0, #0x40
	str r0, [r5, #0xd4]
	ldr ip, [r4, #4]
	ldr r0, _020D3464 // =NNS_G3dSendTexSRT_FuncArray
	ldr r3, [ip, #8]
	add r3, ip, r3
	str r3, [r5, #0xd8]
	ldr ip, [r4, #4]
	ldr r3, [ip, #0xc]
	add r3, ip, r3
	str r3, [r5, #0xdc]
	ldr r3, [r4, #4]
	ldrb r3, [r3, #0x15]
	ldr r2, [r2, r3, lsl #2]
	str r2, [r5, #0xe8]
	ldr r2, [r4, #4]
	ldrb r2, [r2, #0x15]
	ldr r1, [r1, r2, lsl #2]
	str r1, [r5, #0xec]
	ldr r1, [r4, #4]
	ldrb r1, [r1, #0x16]
	ldr r0, [r0, r1, lsl #2]
	str r0, [r5, #0xf0]
	ldr r0, [r4, #4]
	ldr r0, [r0, #0x1c]
	str r0, [r5, #0xe0]
	ldr r0, [r4, #4]
	ldr r0, [r0, #0x20]
	str r0, [r5, #0xe4]
	ldr r1, [r4, #0x20]
	cmp r1, #0
	beq _020D33DC
	ldrb r0, [r4, #0x24]
	cmp r0, #0x20
	bhs _020D33DC
	add r0, r5, r0, lsl #2
	str r1, [r0, #0xc]
	ldrb r0, [r4, #0x24]
	ldrb r1, [r4, #0x25]
	add r0, r5, r0
	strb r1, [r0, #0x8c]
_020D33DC:
	ldr r0, [r4]
	ands r0, r0, #1
	ldrne r0, [r5, #8]
	orrne r0, r0, #0x80
	strne r0, [r5, #8]
	ldr r0, [r4]
	ands r0, r0, #2
	ldrne r0, [r5, #8]
	orrne r0, r0, #0x100
	strne r0, [r5, #8]
	ldr r0, [r4]
	ands r0, r0, #4
	ldrne r0, [r5, #8]
	orrne r0, r0, #0x200
	strne r0, [r5, #8]
	ldr r0, [r4]
	ands r0, r0, #8
	ldrne r0, [r5, #8]
	orrne r0, r0, #0x400
	strne r0, [r5, #8]
	ldr r1, [r4, #0x28]
	cmp r1, #0
	beq _020D3440
	mov r0, r5
	blx r1
_020D3440:
	mov r0, r5
	bl G3dDrawInternal_Loop_
	ldr r0, [r4]
	bic r0, r0, #1
	str r0, [r4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D345C: .word NNS_G3dGetJointScale_FuncArray
_020D3460: .word NNS_G3dSendJointSRT_FuncArray
_020D3464: .word NNS_G3dSendTexSRT_FuncArray
	arm_func_end G3dDrawInternal_

	arm_func_start G3dDrawInternal_Loop_
G3dDrawInternal_Loop_: // 0x020D3468
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	ldr r6, _020D34B0 // =_0211F5BC
	add r4, r5, #8
_020D3478:
	ldr r1, [r4]
	mov r0, r5
	bic r1, r1, #0x40
	str r1, [r4]
	ldr r1, [r5]
	ldrb r3, [r1]
	and r1, r3, #0x1f
	ldr r2, [r6, r1, lsl #2]
	and r1, r3, #0xe0
	blx r2
	ldr r0, [r5, #8]
	ands r0, r0, #0x20
	beq _020D3478
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020D34B0: .word 0x0211F5BC
	arm_func_end G3dDrawInternal_Loop_

	arm_func_start NNS_G3dDraw1Mat1Shp
NNS_G3dDraw1Mat1Shp: // 0x020D34B4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x6c
	mov r6, r0
	ldr ip, [r6, #0x1c]
	mov r4, r1
	mov r5, r2
	mov r7, r3
	cmp ip, #0x1000
	beq _020D34F4
	add r1, sp, #0x54
	mov r0, #0x1b
	mov r2, #3
	str ip, [sp, #0x54]
	str ip, [sp, #0x58]
	str ip, [sp, #0x5c]
	bl NNS_G3dGeBufferOP_N
_020D34F4:
	cmp r7, #0
	beq _020D364C
	ldr r0, [r6, #8]
	add r3, r6, r0
	ldrh r0, [r3, #0xa]
	add r2, r3, #4
	ldrh r1, [r2, r0]
	add r0, r2, r0
	mla r0, r1, r4, r0
	ldr r0, [r0, #4]
	add r4, r3, r0
	ldr r0, [r4, #0xc]
	ands r0, r0, #0x1f0000
	addeq sp, sp, #0x6c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _020D36B0 // =0x00293130
	str r0, [sp]
	ldr r0, [r4, #4]
	str r0, [sp, #4]
	ldr r0, [r4, #8]
	str r0, [sp, #8]
	ldr r1, [r4, #0xc]
	str r1, [sp, #0xc]
	ldrh r0, [r4, #0x1e]
	ands r0, r0, #0x20
	bicne r0, r1, #0x1f0000
	ldr r1, _020D36B4 // =0x00002B2A
	strne r0, [sp, #0xc]
	str r1, [sp, #0x10]
	ldr r2, [r4, #0x14]
	ldr r0, [sp]
	str r2, [sp, #0x14]
	ldrh r3, [r4, #0x1c]
	add r1, sp, #4
	mov r2, #6
	str r3, [sp, #0x18]
	bl NNS_G3dGeBufferOP_N
	ldrh r0, [r4, #0x1e]
	ands r0, r0, #1
	beq _020D364C
	ldrb ip, [r6, #0x16]
	mov r3, #8
	ldr r1, _020D36B8 // =NNS_G3dSendTexSRT_FuncArray
	str r3, [sp, #0x1c]
	ldrh r2, [r4, #0x20]
	add r0, r4, #0x2c
	ldr r1, [r1, ip, lsl #2]
	strh r2, [sp, #0x48]
	ldrh r2, [r4, #0x22]
	strh r2, [sp, #0x4a]
	ldr r2, [r4, #0x24]
	str r2, [sp, #0x4c]
	ldr r2, [r4, #0x28]
	str r2, [sp, #0x50]
	ldrh r2, [r4, #0x1e]
	ands r2, r2, #2
	orrne r2, r3, #1
	strne r2, [sp, #0x1c]
	bne _020D35F4
	ldr r2, [r0]
	str r2, [sp, #0x34]
	ldr r2, [r0, #4]
	add r0, r0, #8
	str r2, [sp, #0x38]
_020D35F4:
	ldrh r2, [r4, #0x1e]
	ands r2, r2, #4
	ldrne r2, [sp, #0x1c]
	orrne r2, r2, #2
	strne r2, [sp, #0x1c]
	bne _020D3620
	ldrsh r2, [r0]
	strh r2, [sp, #0x3c]
	ldrsh r2, [r0, #2]
	add r0, r0, #4
	strh r2, [sp, #0x3e]
_020D3620:
	ldrh r2, [r4, #0x1e]
	ands r2, r2, #8
	ldreq r2, [r0]
	streq r2, [sp, #0x40]
	ldreq r0, [r0, #4]
	streq r0, [sp, #0x44]
	ldrne r0, [sp, #0x1c]
	orrne r0, r0, #4
	strne r0, [sp, #0x1c]
	add r0, sp, #0x1c
	blx r1
_020D364C:
	ldr r0, [r6, #0xc]
	add r2, r6, r0
	ldrh r0, [r2, #6]
	ldrh r1, [r2, r0]
	add r0, r2, r0
	mla r0, r1, r5, r0
	ldr r0, [r0, #4]
	add r2, r2, r0
	ldr r0, [r2, #8]
	ldr r1, [r2, #0xc]
	add r0, r2, r0
	bl NNS_G3dGeSendDL
	ldr r3, [r6, #0x20]
	cmp r3, #0x1000
	addeq sp, sp, #0x6c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	add r1, sp, #0x60
	mov r0, #0x1b
	mov r2, #3
	str r3, [sp, #0x60]
	str r3, [sp, #0x64]
	str r3, [sp, #0x68]
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x6c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D36B0: .word 0x00293130
_020D36B4: .word 0x00002B2A
_020D36B8: .word NNS_G3dSendTexSRT_FuncArray
	arm_func_end NNS_G3dDraw1Mat1Shp

	arm_func_start NNS_G3dGeBufferOP_N
NNS_G3dGeBufferOP_N: // 0x020D36BC
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _020D37A0 // =0x0214A1A8
	mov r6, r0
	ldr ip, [r3]
	mov r5, r1
	mov r4, r2
	cmp ip, #0
	beq _020D3774
	ldr r0, _020D37A4 // =0x0214A1AC
	ldr r0, [r0]
	cmp r0, #0
	beq _020D3748
	ldr r2, [ip]
	add r0, r2, #1
	add r1, r0, r4
	cmp r1, #0xc0
	bhi _020D3748
	str r0, [ip]
	ldr r0, [r3]
	cmp r4, #0
	add r0, r0, r2, lsl #2
	str r6, [r0, #4]
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r2, [r3]
	mov r0, r5
	ldr r1, [r2], #4
	add r1, r2, r1, lsl #2
	mov r2, r4, lsl #2
	bl MIi_CpuCopyFast
	ldr r0, _020D37A0 // =0x0214A1A8
	ldr r1, [r0]
	ldr r0, [r1]
	add r0, r0, r4
	str r0, [r1]
	ldmia sp!, {r4, r5, r6, pc}
_020D3748:
	ldr r0, [ip]
	cmp r0, #0
	beq _020D375C
	bl NNS_G3dGeFlushBuffer
	b _020D3788
_020D375C:
	ldr r0, _020D37A4 // =0x0214A1AC
	ldr r0, [r0]
	cmp r0, #0
	beq _020D3788
	bl NNS_G3dGeWaitSendDL
	b _020D3788
_020D3774:
	ldr r0, _020D37A4 // =0x0214A1AC
	ldr r0, [r0]
	cmp r0, #0
	beq _020D3788
	bl NNS_G3dGeWaitSendDL
_020D3788:
	ldr r1, _020D37A8 // =0x04000400
	mov r0, r5
	mov r2, r4, lsl #2
	str r6, [r1]
	bl MIi_CpuSend32
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020D37A0: .word 0x0214A1A8
_020D37A4: .word 0x0214A1AC
_020D37A8: .word 0x04000400
	arm_func_end NNS_G3dGeBufferOP_N

	arm_func_start NNS_G3dGeSendDL
NNS_G3dGeSendDL: // 0x020D37AC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r5, r0
	cmp r4, #0x100
	blo _020D37D8
	ldr r1, _020D385C // =_0211F778
	mvn r0, #0
	ldr r1, [r1]
	cmp r1, r0
	bne _020D37F4
_020D37D8:
	mov r2, r4, lsr #2
	ldr r0, [r5]
	add r1, r5, #4
	sub r2, r2, #1
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020D37F4:
	bl NNS_G3dGeFlushBuffer
	ldr r0, _020D3860 // =0x0214A1B0
	ldr r1, _020D3864 // =0x0214A1AC
	ldr r0, [r0]
	mov r2, #1
	str r2, [r1]
	cmp r0, #0
	beq _020D3838
	ldr r0, _020D385C // =_0211F778
	str r1, [sp]
	ldr r0, [r0]
	ldr r3, _020D3868 // =simpleUnlock_
	mov r1, r5
	mov r2, r4
	bl MI_SendGXCommandAsyncFast
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020D3838:
	ldr r0, _020D385C // =_0211F778
	str r1, [sp]
	ldr r0, [r0]
	ldr r3, _020D3868 // =simpleUnlock_
	mov r1, r5
	mov r2, r4
	bl MI_SendGXCommandAsync
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D385C: .word 0x0211F778
_020D3860: .word 0x0214A1B0
_020D3864: .word 0x0214A1AC
_020D3868: .word simpleUnlock_
	arm_func_end NNS_G3dGeSendDL

	arm_func_start NNS_G3dGeUseFastDma
NNS_G3dGeUseFastDma: // 0x020D386C
	ldr r1, _020D3878 // =0x0214A1B0
	str r0, [r1]
	bx lr
	.align 2, 0
_020D3878: .word 0x0214A1B0
	arm_func_end NNS_G3dGeUseFastDma

	arm_func_start simpleUnlock_
simpleUnlock_: // 0x020D387C
	mov r1, #0
	str r1, [r0]
	bx lr
	arm_func_end simpleUnlock_

	arm_func_start NNS_G3dGeWaitSendDL
NNS_G3dGeWaitSendDL: // 0x020D3888
	ldr r0, _020D389C // =0x0214A1AC
_020D388C:
	ldr r1, [r0]
	cmp r1, #0
	bne _020D388C
	bx lr
	.align 2, 0
_020D389C: .word 0x0214A1AC
	arm_func_end NNS_G3dGeWaitSendDL

	arm_func_start NNS_G3dGeFlushBuffer
NNS_G3dGeFlushBuffer: // 0x020D38A0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020D3908 // =0x0214A1AC
	ldr r0, [r0]
	cmp r0, #0
	beq _020D38BC
	bl NNS_G3dGeWaitSendDL
_020D38BC:
	ldr r0, _020D390C // =0x0214A1A8
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r2, [r0]
	cmp r2, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r1, _020D3910 // =0x04000400
	add r0, r0, #4
	mov r2, r2, lsl #2
	bl MIi_CpuSend32
	ldr r0, _020D390C // =0x0214A1A8
	mov r1, #0
	ldr r0, [r0]
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D3908: .word 0x0214A1AC
_020D390C: .word 0x0214A1A8
_020D3910: .word 0x04000400
	arm_func_end NNS_G3dGeFlushBuffer

	arm_func_start NNS_G3dScrPosToWorldLine
NNS_G3dScrPosToWorldLine: // 0x020D3914
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r6, r0
	mov r5, r1
	mov r11, r2
	mov r7, r3
	add r0, sp, #0x14
	add r1, sp, #0x18
	add r2, sp, #0x1c
	add r3, sp, #0x20
	bl NNS_G3dGlbGetViewPort
	ldr r1, [sp, #0x20]
	ldr r0, [sp, #0x18]
	ldr r2, [sp, #0x14]
	sub r4, r1, r0
	ldr r1, [sp, #0x1c]
	sub r0, r6, r2
	sub r1, r1, r2
	mov r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Div
	rsb r1, r4, #0
	mov r4, r0
	ldr r0, [sp, #0x18]
	mov r1, r1, lsl #0xc
	add r0, r5, r0
	sub r0, r0, #0xbf
	mov r0, r0, lsl #0xc
	bl FX_Div
	cmp r4, #0
	blt _020D39A8
	cmp r0, #0
	blt _020D39A8
	cmp r4, #0x1000
	bgt _020D39A8
	cmp r0, #0x1000
	ble _020D39B4
_020D39A8:
	mvn r1, #0
	str r1, [sp]
	b _020D39BC
_020D39B4:
	mov r1, #0
	str r1, [sp]
_020D39BC:
	sub r1, r4, #0x800
	sub r0, r0, #0x800
	mov r9, r1, lsl #1
	mov r8, r0, lsl #1
	bl NNS_G3dGlbGetView_UNKNOWN
	mov r6, r0
	ldr r0, [r6, #0x1c]
	ldr r1, [r6, #0xc]
	smull r2, r0, r8, r0
	smlal r2, r0, r9, r1
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	ldr r0, [r6, #0x3c]
	ldr r1, [r6, #0x2c]
	add r0, r0, r2
	str r0, [sp, #4]
	sub r0, r0, r1
	bl FX_InvAsync
	ldr r0, [r6, #0x10]
	ldr r2, [r6]
	smull r3, r0, r8, r0
	smlal r3, r0, r9, r2
	mov r2, r3, lsr #0xc
	orr r2, r2, r0, lsl #20
	ldr r4, [r6, #0x30]
	ldr r3, [r6, #4]
	add r5, r4, r2
	ldr r2, [r6, #0x14]
	ldr r1, [r6, #0x34]
	smull r4, r2, r8, r2
	smlal r4, r2, r9, r3
	mov r3, r4, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r4, r1, r3
	ldr r1, [r6, #0x18]
	ldr r2, [r6, #8]
	smull r3, r1, r8, r1
	smlal r3, r1, r9, r2
	mov r2, r3, lsr #0xc
	ldr r0, [r6, #0x38]
	orr r2, r2, r1, lsl #20
	cmp r7, #0
	add r8, r0, r2
	beq _020D3A9C
	ldr r0, [r6, #0x20]
	ldr r3, [r6, #0x24]
	add r0, r5, r0
	str r0, [sp, #0xc]
	add r0, r4, r3
	str r0, [sp, #0x10]
	ldr r2, [r6, #0x28]
	ldr r1, [r6, #0x2c]
	ldr r0, [sp, #4]
	add r10, r8, r2
	add r0, r0, r1
	str r0, [sp, #8]
_020D3A9C:
	ldr r2, [r6, #0x20]
	ldr r1, [r6, #0x24]
	ldr r0, [r6, #0x28]
	sub r5, r5, r2
	sub r4, r4, r1
	sub r8, r8, r0
	bl FX_GetDivResultFx64c
	mov r6, r0
	mov r9, r1
	cmp r7, #0
	beq _020D3AD0
	ldr r0, [sp, #8]
	bl FX_InvAsync
_020D3AD0:
	mov r0, r5, asr #0x1f
	umull r2, r1, r6, r5
	mla r1, r6, r0, r1
	mla r1, r9, r5, r1
	mov r0, #0x80000000
	adds r2, r2, r0
	adc r1, r1, #0
	str r1, [r11]
	umull r1, r2, r6, r4
	adds r1, r1, r0
	mov r1, r4, asr #0x1f
	mla r2, r6, r1, r2
	mla r2, r9, r4, r2
	adc r1, r2, #0
	str r1, [r11, #4]
	mov r1, r8, asr #0x1f
	umull r3, r2, r6, r8
	adds r0, r3, r0
	mla r2, r6, r1, r2
	mla r2, r9, r8, r2
	adc r0, r2, #0
	str r0, [r11, #8]
	cmp r7, #0
	beq _020D3B9C
	bl FX_GetDivResultFx64c
	ldr r2, [sp, #0xc]
	umull r9, r5, r0, r2
	mov r3, r2, asr #0x1f
	ldr r2, [sp, #0x10]
	mla r5, r0, r3, r5
	mov r3, #0x80000000
	mov r4, r2, asr #0x1f
	umull r8, r6, r0, r2
	adds r2, r9, r3
	ldr r2, [sp, #0xc]
	mla r6, r0, r4, r6
	mla r5, r1, r2, r5
	adc r4, r5, #0
	str r4, [r7]
	mov r2, r10, asr #0x1f
	umull r5, r4, r0, r10
	mla r4, r0, r2, r4
	adds r0, r8, r3
	ldr r0, [sp, #0x10]
	mla r4, r1, r10, r4
	mla r6, r1, r0, r6
	adc r2, r6, #0
	adds r0, r5, r3
	str r2, [r7, #4]
	adc r0, r4, #0
	str r0, [r7, #8]
_020D3B9C:
	ldr r0, [sp]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end NNS_G3dScrPosToWorldLine

	arm_func_start NNS_G3dWorldPosToScrPos
NNS_G3dWorldPosToScrPos: // 0x020D3BA8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x1c
	mov r5, r1
	mov r4, r2
	ldr r6, _020D3D34 // =0x02147248
	ldr r1, _020D3D38 // =0x0214728C
	add r2, sp, #0x10
	bl MTX_MultVec43
	ldr r1, [sp, #0x14]
	ldr r0, [r6, #0x1c]
	ldr r2, [sp, #0x10]
	smull r8, r7, r1, r0
	ldr r0, [r6, #0xc]
	ldr r3, [sp, #0x18]
	smlal r8, r7, r2, r0
	ldr r1, [r6, #0x2c]
	ldr r0, [r6, #0x3c]
	smlal r8, r7, r3, r1
	mov r1, r8, lsr #0xc
	orr r1, r1, r7, lsl #20
	add r0, r1, r0
	bl FX_InvAsync
	ldr r2, [sp, #0x14]
	ldr r1, [r6, #0x10]
	ldr r0, [r6, #0x14]
	smull lr, r8, r2, r1
	smull ip, r9, r2, r0
	ldr r1, [sp, #0x10]
	ldr r3, [r6]
	ldr r0, [sp, #0x18]
	smlal lr, r8, r1, r3
	ldr r7, [r6, #0x20]
	ldr r2, [r6, #0x30]
	smlal lr, r8, r0, r7
	mov r3, lr, lsr #0xc
	orr r3, r3, r8, lsl #20
	add r7, r3, r2
	ldr r3, [r6, #4]
	ldr r8, [r6, #0x24]
	smlal ip, r9, r1, r3
	smlal ip, r9, r0, r8
	mov r0, ip, lsr #0xc
	ldr r2, [r6, #0x34]
	orr r0, r0, r9, lsl #20
	add r6, r0, r2
	bl FX_GetDivResultFx64c
	mov r2, r7, asr #0x1f
	umull r9, lr, r0, r7
	mla lr, r0, r2, lr
	mov r3, #0x80000000
	mla lr, r1, r7, lr
	adds r9, r9, r3
	adc r2, lr, #0
	add r2, r2, #0x1000
	add r2, r2, r2, lsr #31
	mov r7, r2, asr #1
	umull lr, r2, r0, r6
	mov ip, r6, asr #0x1f
	mla r2, r0, ip, r2
	mla r2, r1, r6, r2
	adds r3, lr, r3
	adc r0, r2, #0
	add r0, r0, #0x1000
	add r0, r0, r0, lsr #31
	mov r8, #0
	mov r6, r0, asr #1
	cmp r7, #0
	blt _020D3CD0
	cmp r6, #0
	blt _020D3CD0
	cmp r7, #0x1000
	bgt _020D3CD0
	cmp r6, #0x1000
	ble _020D3CD4
_020D3CD0:
	mvn r8, #0
_020D3CD4:
	add r0, sp, #0
	add r1, sp, #4
	add r2, sp, #8
	add r3, sp, #0xc
	bl NNS_G3dGlbGetViewPort
	ldr r2, [sp]
	ldr r0, [sp, #8]
	ldr ip, [sp, #0xc]
	sub r0, r0, r2
	mul r0, r7, r0
	add r1, r0, #0x800
	ldr r3, [sp, #4]
	add r1, r2, r1, asr #12
	sub r0, ip, r3
	mul r0, r6, r0
	str r1, [r5]
	ldr r1, [sp, #4]
	add r0, r0, #0x800
	rsb r1, r1, #0xbf
	sub r1, r1, r0, asr #12
	mov r0, r8
	str r1, [r4]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020D3D34: .word 0x02147248
_020D3D38: .word 0x0214728C
	arm_func_end NNS_G3dWorldPosToScrPos

	arm_func_start NNS_G3dResDefaultRelease
NNS_G3dResDefaultRelease: // 0x020D3D3C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	ldr r2, [r5]
	ldr r1, _020D3E7C // =0x30415642
	cmp r2, r1
	bhi _020D3D9C
	cmp r2, r1
	addhs sp, sp, #0xc
	ldmhsia sp!, {r4, r5, pc}
	ldr r0, _020D3E80 // =0x30414D42
	cmp r2, r0
	bhi _020D3D8C
	cmp r2, r0
	addhs sp, sp, #0xc
	ldmhsia sp!, {r4, r5, pc}
	ldr r0, _020D3E84 // =0x30414342
	add sp, sp, #0xc
	cmp r2, r0
	ldmia sp!, {r4, r5, pc}
_020D3D8C:
	ldr r0, _020D3E88 // =0x30415442
	add sp, sp, #0xc
	cmp r2, r0
	ldmia sp!, {r4, r5, pc}
_020D3D9C:
	ldr r1, _020D3E8C // =0x30505442
	cmp r2, r1
	bhi _020D3DC8
	cmp r2, r1
	addhs sp, sp, #0xc
	ldmhsia sp!, {r4, r5, pc}
	ldr r1, _020D3E90 // =0x30444D42
	cmp r2, r1
	beq _020D3DDC
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
_020D3DC8:
	ldr r0, _020D3E94 // =0x30585442
	cmp r2, r0
	beq _020D3DFC
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
_020D3DDC:
	bl NNS_G3dGetMdlSet
	mov r4, r0
	mov r0, r5
	bl NNS_G3dGetTex
	cmp r0, #0
	beq _020D3DFC
	mov r0, r4
	bl NNS_G3dReleaseMdlSet
_020D3DFC:
	mov r0, r5
	bl NNS_G3dGetTex
	movs r5, r0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, pc}
	bl NNS_G3dPlttReleasePlttKey
	mov r4, r0
	add r1, sp, #0
	add r2, sp, #4
	mov r0, r5
	bl NNS_G3dTexReleaseTexKey
	cmp r4, #0
	beq _020D3E40
	ldr r1, _020D3E98 // =NNS_GfdDefaultFuncFreePlttVram
	mov r0, r4
	ldr r1, [r1]
	blx r1
_020D3E40:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _020D3E58
	ldr r1, _020D3E9C // =NNS_GfdDefaultFuncFreeTexVram
	ldr r1, [r1]
	blx r1
_020D3E58:
	ldr r0, [sp]
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, _020D3E9C // =NNS_GfdDefaultFuncFreeTexVram
	ldr r1, [r1]
	blx r1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D3E7C: .word 0x30415642
_020D3E80: .word 0x30414D42
_020D3E84: .word 0x30414342
_020D3E88: .word 0x30415442
_020D3E8C: .word 0x30505442
_020D3E90: .word 0x30444D42
_020D3E94: .word 0x30585442
_020D3E98: .word NNS_GfdDefaultFuncFreePlttVram
_020D3E9C: .word NNS_GfdDefaultFuncFreeTexVram
	arm_func_end NNS_G3dResDefaultRelease

	arm_func_start NNS_G3dResDefaultSetup
NNS_G3dResDefaultSetup: // 0x020D3EA0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r1, [r5]
	ldr r0, _020D40CC // =0x30415642
	cmp r1, r0
	bhi _020D3EF8
	cmp r1, r0
	bhs _020D40B4
	ldr r0, _020D40D0 // =0x30414D42
	cmp r1, r0
	bhi _020D3EE8
	cmp r1, r0
	bhs _020D40B4
	ldr r0, _020D40D4 // =0x30414342
	cmp r1, r0
	beq _020D40B4
	b _020D40C0
_020D3EE8:
	ldr r0, _020D40D8 // =0x30415442
	cmp r1, r0
	beq _020D40B4
	b _020D40C0
_020D3EF8:
	ldr r0, _020D40DC // =0x30505442
	cmp r1, r0
	bhi _020D3F1C
	cmp r1, r0
	bhs _020D40B4
	ldr r0, _020D40E0 // =0x30444D42
	cmp r1, r0
	beq _020D3F28
	b _020D40C0
_020D3F1C:
	ldr r0, _020D40E4 // =0x30585442
	cmp r1, r0
	bne _020D40C0
_020D3F28:
	mov r11, #1
	mov r0, r5
	mov r9, r11
	mov r8, r11
	bl NNS_G3dGetTex
	movs r4, r0
	beq _020D4080
	bl NNS_G3dTexGetRequiredSize
	mov r7, r0
	mov r0, r4
	bl NNS_G3dTex4x4GetRequiredSize
	mov r6, r0
	mov r0, r4
	bl NNS_G3dPlttGetRequiredSize
	mov r10, r0
	cmp r7, #0
	beq _020D3F90
	ldr r0, _020D40E8 // =NNS_GfdDefaultFuncAllocTexVram
	mov r1, #0
	ldr r3, [r0]
	mov r0, r7
	mov r2, r1
	blx r3
	movs r7, r0
	moveq r11, #0
	b _020D3F94
_020D3F90:
	mov r7, #0
_020D3F94:
	cmp r6, #0
	beq _020D3FC0
	ldr r1, _020D40E8 // =NNS_GfdDefaultFuncAllocTexVram
	mov r0, r6
	ldr r3, [r1]
	mov r1, #1
	mov r2, #0
	blx r3
	movs r6, r0
	moveq r9, #0
	b _020D3FC4
_020D3FC0:
	mov r6, #0
_020D3FC4:
	cmp r10, #0
	beq _020D3FF4
	ldr r1, _020D40EC // =NNS_GfdDefaultFuncAllocPlttVram
	ldrh r2, [r4, #0x20]
	ldr r3, [r1]
	mov r0, r10
	and r1, r2, #0x8000
	mov r2, #0
	blx r3
	movs r10, r0
	moveq r8, #0
	b _020D3FF8
_020D3FF4:
	mov r10, #0
_020D3FF8:
	cmp r11, #0
	beq _020D4010
	cmp r9, #0
	beq _020D4010
	cmp r8, #0
	bne _020D404C
_020D4010:
	ldr r1, _020D40F0 // =NNS_GfdDefaultFuncFreePlttVram
	mov r0, r10
	ldr r1, [r1]
	blx r1
	ldr r1, _020D40F4 // =NNS_GfdDefaultFuncFreeTexVram
	mov r0, r6
	ldr r1, [r1]
	blx r1
	ldr r1, _020D40F4 // =NNS_GfdDefaultFuncFreeTexVram
	mov r0, r7
	ldr r1, [r1]
	blx r1
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020D404C:
	mov r0, r4
	mov r1, r7
	mov r2, r6
	bl NNS_G3dTexSetTexKey
	mov r0, r4
	mov r1, r10
	bl NNS_G3dPlttSetPlttKey
	mov r0, r4
	mov r1, #1
	bl NNS_G3dTexLoad
	mov r0, r4
	mov r1, #1
	bl NNS_G3dPlttLoad
_020D4080:
	ldr r1, [r5]
	ldr r0, _020D40E0 // =0x30444D42
	cmp r1, r0
	bne _020D40A8
	mov r0, r5
	bl NNS_G3dGetMdlSet
	cmp r4, #0
	beq _020D40A8
	mov r1, r4
	bl NNS_G3dBindMdlSet
_020D40A8:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020D40B4:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020D40C0:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020D40CC: .word 0x30415642
_020D40D0: .word 0x30414D42
_020D40D4: .word 0x30414342
_020D40D8: .word 0x30415442
_020D40DC: .word 0x30505442
_020D40E0: .word 0x30444D42
_020D40E4: .word 0x30585442
_020D40E8: .word NNS_GfdDefaultFuncAllocTexVram
_020D40EC: .word NNS_GfdDefaultFuncAllocPlttVram
_020D40F0: .word NNS_GfdDefaultFuncFreePlttVram
_020D40F4: .word NNS_GfdDefaultFuncFreeTexVram
	arm_func_end NNS_G3dResDefaultSetup

	arm_func_start NNS_G3dInit
NNS_G3dInit: // 0x020D40F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl G3X_Init
	bl NNS_G3dGlbInit
	ldr r1, _020D4124 // =0x04000600
	ldr r0, [r1]
	bic r0, r0, #0xc0000000
	orr r0, r0, #0x80000000
	str r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D4124: .word 0x04000600
	arm_func_end NNS_G3dInit

	arm_func_start NNS_G3dGetCurrentMtx
NNS_G3dGetCurrentMtx: // 0x020D4128
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x40
	mov r6, r0
	mov r5, r1
	bl NNS_G3dGeFlushBuffer
	ldr r0, _020D41B8 // =0x04000440
	mov r2, #0
	ldr r1, _020D41BC // =0x04000444
	str r2, [r0]
	ldr r0, _020D41C0 // =0x04000454
	str r2, [r1]
	str r2, [r0]
	cmp r6, #0
	beq _020D4180
	add r4, sp, #0
_020D4164:
	mov r0, r4
	bl G3X_GetClipMtx
	cmp r0, #0
	bne _020D4164
	add r0, sp, #0
	mov r1, r6
	bl MTX_Copy44To43_
_020D4180:
	cmp r5, #0
	beq _020D4198
_020D4188:
	mov r0, r5
	bl G3X_GetVectorMtx
	cmp r0, #0
	bne _020D4188
_020D4198:
	ldr r1, _020D41C4 // =0x04000448
	mov r2, #1
	ldr r0, _020D41B8 // =0x04000440
	str r2, [r1]
	mov r1, #2
	str r1, [r0]
	add sp, sp, #0x40
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020D41B8: .word 0x04000440
_020D41BC: .word 0x04000444
_020D41C0: .word 0x04000454
_020D41C4: .word 0x04000448
	arm_func_end NNS_G3dGetCurrentMtx

	arm_func_start NNS_G3dFreeRecBufferMat
NNS_G3dFreeRecBufferMat: // 0x020D41C8
	ldr ip, _020D41D0 // =NNS_FndFreeToAllocator
	bx ip
	.align 2, 0
_020D41D0: .word NNS_FndFreeToAllocator
	arm_func_end NNS_G3dFreeRecBufferMat

	arm_func_start NNS_G3dAllocRecBufferMat
NNS_G3dAllocRecBufferMat: // 0x020D41D4
	ldrb r2, [r1, #0x18]
	mov r1, #0x38
	ldr ip, _020D41E8 // =NNS_FndAllocFromAllocator
	mul r1, r2, r1
	bx ip
	.align 2, 0
_020D41E8: .word NNS_FndAllocFromAllocator
	arm_func_end NNS_G3dAllocRecBufferMat

	arm_func_start NNS_G3dFreeRecBufferJnt
NNS_G3dFreeRecBufferJnt: // 0x020D41EC
	ldr ip, _020D41F4 // =NNS_FndFreeToAllocator
	bx ip
	.align 2, 0
_020D41F4: .word NNS_FndFreeToAllocator
	arm_func_end NNS_G3dFreeRecBufferJnt

	arm_func_start NNS_G3dAllocRecBufferJnt
NNS_G3dAllocRecBufferJnt: // 0x020D41F8
	ldrb r2, [r1, #0x17]
	mov r1, #0x58
	ldr ip, _020D420C // =NNS_FndAllocFromAllocator
	mul r1, r2, r1
	bx ip
	.align 2, 0
_020D420C: .word NNS_FndAllocFromAllocator
	arm_func_end NNS_G3dAllocRecBufferJnt

	arm_func_start NNS_G3dFreeAnmObj
NNS_G3dFreeAnmObj: // 0x020D4210
	ldr ip, _020D4218 // =NNS_FndFreeToAllocator
	bx ip
	.align 2, 0
_020D4218: .word NNS_FndFreeToAllocator
	arm_func_end NNS_G3dFreeAnmObj

	arm_func_start NNS_G3dAllocAnmObj
NNS_G3dAllocAnmObj: // 0x020D421C
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, r1
	mov r1, r2
	bl NNS_G3dAnmObjCalcSizeRequired
	mov r1, r0
	mov r0, r4
	bl NNS_FndAllocFromAllocator
	ldmia sp!, {r4, pc}
	arm_func_end NNS_G3dAllocAnmObj

	arm_func_start NNS_G3dMdlSetMdlDepthTestCondAll
NNS_G3dMdlSetMdlDepthTestCondAll: // 0x020D4240
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #0x18]
	mov r5, r1
	mov r4, #0
	cmp r0, #0
	ldmlsia sp!, {r4, r5, r6, pc}
_020D425C:
	mov r0, r6
	mov r1, r4
	mov r2, r5
	bl NNS_G3dMdlSetMdlDepthTestCond
	ldrb r0, [r6, #0x18]
	add r4, r4, #1
	cmp r4, r0
	blo _020D425C
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_G3dMdlSetMdlDepthTestCondAll

	arm_func_start NNS_G3dMdlSetMdlAlphaAll
NNS_G3dMdlSetMdlAlphaAll: // 0x020D4280
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #0x18]
	mov r5, r1
	mov r4, #0
	cmp r0, #0
	ldmlsia sp!, {r4, r5, r6, pc}
_020D429C:
	mov r0, r6
	mov r1, r4
	mov r2, r5
	bl NNS_G3dMdlSetMdlAlpha
	ldrb r0, [r6, #0x18]
	add r4, r4, #1
	cmp r4, r0
	blo _020D429C
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_G3dMdlSetMdlAlphaAll

	arm_func_start NNS_G3dMdlSetMdlPolygonIDAll
NNS_G3dMdlSetMdlPolygonIDAll: // 0x020D42C0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #0x18]
	mov r5, r1
	mov r4, #0
	cmp r0, #0
	ldmlsia sp!, {r4, r5, r6, pc}
_020D42DC:
	mov r0, r6
	mov r1, r4
	mov r2, r5
	bl NNS_G3dMdlSetMdlPolygonID
	ldrb r0, [r6, #0x18]
	add r4, r4, #1
	cmp r4, r0
	blo _020D42DC
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_G3dMdlSetMdlPolygonIDAll

	arm_func_start NNS_G3dMdlSetMdlSpecAll
NNS_G3dMdlSetMdlSpecAll: // 0x020D4300
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldrb r0, [r6, #0x18]
	mov r5, r1
	mov r4, #0
	cmp r0, #0
	ldmlsia sp!, {r4, r5, r6, pc}
_020D431C:
	mov r0, r6
	mov r1, r4
	mov r2, r5
	bl NNS_G3dMdlSetMdlSpec
	ldrb r0, [r6, #0x18]
	add r4, r4, #1
	cmp r4, r0
	blo _020D431C
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNS_G3dMdlSetMdlSpecAll

	arm_func_start NNS_G3dMdlGetMdlAlpha
NNS_G3dMdlGetMdlAlpha: // 0x020D4340
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, [r0, #8]
	ldr r2, _020D438C // =0x7FFF0000
	add lr, r0, r3
	ldrh r0, [lr, #0xa]
	add ip, lr, #4
	ldrh r3, [ip, r0]
	add r0, ip, r0
	mla r0, r3, r1, r0
	ldr r0, [r0, #4]
	add r0, lr, r0
	ldr r0, [r0, #8]
	and r0, r0, r2
	mov r0, r0, lsr #0x10
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D438C: .word 0x7FFF0000
	arm_func_end NNS_G3dMdlGetMdlAlpha

	arm_func_start NNS_G3dMdlSetMdlDepthTestCond
NNS_G3dMdlSetMdlDepthTestCond: // 0x020D4390
	ldr r3, [r0, #8]
	cmp r2, #0
	add ip, r0, r3
	ldrh r0, [ip, #0xa]
	add r3, ip, #4
	ldrh r2, [r3, r0]
	add r0, r3, r0
	mla r0, r2, r1, r0
	ldr r0, [r0, #4]
	add r1, ip, r0
	ldrne r0, [r1, #0xc]
	orrne r0, r0, #0x4000
	strne r0, [r1, #0xc]
	ldreq r0, [r1, #0xc]
	biceq r0, r0, #0x4000
	streq r0, [r1, #0xc]
	bx lr
	arm_func_end NNS_G3dMdlSetMdlDepthTestCond

	arm_func_start NNS_G3dMdlSetMdlAlpha
NNS_G3dMdlSetMdlAlpha: // 0x020D43D4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, [r0, #8]
	add lr, r0, r3
	ldrh r0, [lr, #0xa]
	add ip, lr, #4
	ldrh r3, [ip, r0]
	add r0, ip, r0
	mla r0, r3, r1, r0
	ldr r0, [r0, #4]
	add r1, lr, r0
	ldr r0, [r1, #0xc]
	bic r0, r0, #0x1f0000
	orr r0, r0, r2, lsl #16
	str r0, [r1, #0xc]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_G3dMdlSetMdlAlpha

	arm_func_start NNS_G3dMdlSetMdlPolygonID
NNS_G3dMdlSetMdlPolygonID: // 0x020D4418
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, [r0, #8]
	add lr, r0, r3
	ldrh r0, [lr, #0xa]
	add ip, lr, #4
	ldrh r3, [ip, r0]
	add r0, ip, r0
	mla r0, r3, r1, r0
	ldr r0, [r0, #4]
	add r1, lr, r0
	ldr r0, [r1, #0xc]
	bic r0, r0, #0x3f000000
	orr r0, r0, r2, lsl #24
	str r0, [r1, #0xc]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_G3dMdlSetMdlPolygonID

	arm_func_start NNS_G3dMdlSetMdlCullMode
NNS_G3dMdlSetMdlCullMode: // 0x020D445C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, [r0, #8]
	add lr, r0, r3
	ldrh r0, [lr, #0xa]
	add ip, lr, #4
	ldrh r3, [ip, r0]
	add r0, ip, r0
	mla r0, r3, r1, r0
	ldr r0, [r0, #4]
	add r1, lr, r0
	ldr r0, [r1, #0xc]
	bic r0, r0, #0xf
	orr r0, r0, r2
	str r0, [r1, #0xc]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNS_G3dMdlSetMdlCullMode

	arm_func_start NNS_G3dMdlSetMdlEmi
NNS_G3dMdlSetMdlEmi: // 0x020D44A0
	stmdb sp!, {r4, lr}
	ldr ip, [r0, #8]
	ldr r3, _020D44E0 // =0x8000FFFF
	add r4, r0, ip
	ldrh r0, [r4, #0xa]
	add lr, r4, #4
	ldrh ip, [lr, r0]
	add r0, lr, r0
	mla r0, ip, r1, r0
	ldr r0, [r0, #4]
	add r1, r4, r0
	ldr r0, [r1, #8]
	and r0, r0, r3
	orr r0, r0, r2, lsl #16
	str r0, [r1, #8]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D44E0: .word 0x8000FFFF
	arm_func_end NNS_G3dMdlSetMdlEmi

	arm_func_start NNS_G3dMdlSetMdlSpec
NNS_G3dMdlSetMdlSpec: // 0x020D44E4
	stmdb sp!, {r4, lr}
	ldr ip, [r0, #8]
	mov r3, #0x8000
	add r4, r0, ip
	ldrh ip, [r4, #0xa]
	add lr, r4, #4
	rsb r0, r3, #0
	ldrh r3, [lr, ip]
	add ip, lr, ip
	mla r1, r3, r1, ip
	ldr r1, [r1, #4]
	add r3, r4, r1
	ldr r1, [r3, #4]
	and r0, r1, r0
	orr r0, r0, r2
	str r0, [r3, #4]
	ldmia sp!, {r4, pc}
	arm_func_end NNS_G3dMdlSetMdlSpec

	arm_func_start NNSi_G3dModifyPolygonAttrMask
NNSi_G3dModifyPolygonAttrMask: // 0x020D4528
	stmdb sp!, {r4, r5, r6, lr}
	ldrb r4, [r0, #0x18]
	ldr r3, [r0, #8]
	mov lr, #0
	cmp r4, #0
	add ip, r0, r3
	ldmlsia sp!, {r4, r5, r6, pc}
	mvn r3, r2
	add r0, ip, #4
_020D454C:
	ldrh r5, [ip, #0xa]
	cmp r1, #0
	ldrh r6, [r0, r5]
	add r5, r0, r5
	mla r5, r6, lr, r5
	ldr r5, [r5, #4]
	add lr, lr, #1
	add r6, ip, r5
	ldrne r5, [r6, #0x10]
	orrne r5, r5, r2
	strne r5, [r6, #0x10]
	ldreq r5, [r6, #0x10]
	andeq r5, r5, r3
	streq r5, [r6, #0x10]
	cmp lr, r4
	blo _020D454C
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNSi_G3dModifyPolygonAttrMask

	arm_func_start NNS_G3dGetTex
NNS_G3dGetTex: // 0x020D4590
	ldrh r2, [r0, #0xc]
	ldrh r1, [r0, #0xe]
	add r3, r0, r2
	cmp r1, #1
	bne _020D45C0
	ldr r2, [r0]
	ldr r1, _020D45CC // =0x30585442
	cmp r2, r1
	ldreq r1, [r3]
	addeq r0, r0, r1
	movne r0, #0
	bx lr
_020D45C0:
	ldr r1, [r3, #4]
	add r0, r0, r1
	bx lr
	.align 2, 0
_020D45CC: .word 0x30585442
	arm_func_end NNS_G3dGetTex

	arm_func_start NNS_G3dGetMdlSet
NNS_G3dGetMdlSet: // 0x020D45D0
	ldrh r1, [r0, #0xc]
	ldr r1, [r0, r1]
	add r0, r0, r1
	bx lr
	arm_func_end NNS_G3dGetMdlSet

	arm_func_start NNS_G3dGetResDictIdxByName
NNS_G3dGetResDictIdxByName: // 0x020D45E0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldrb r2, [r0, #1]
	cmp r2, #0x10
	bhs _020D4678
	cmp r2, #0
	ldr lr, [r1]
	ldr ip, [r1, #4]
	ldr r3, [r1, #8]
	ldr r2, [r1, #0xc]
	mov r4, #0
	bls _020D4728
	ldrh r5, [r0, #6]
	mov r1, r4
	add r6, r0, r5
	ldrh r5, [r6, #2]
	add r6, r6, r5
_020D4624:
	ldr r5, [r6, r1]
	add r7, r6, r1
	cmp r5, lr
	bne _020D4660
	ldr r5, [r7, #4]
	cmp r5, ip
	bne _020D4660
	ldr r5, [r7, #8]
	cmp r5, r3
	bne _020D4660
	ldr r5, [r7, #0xc]
	cmp r5, r2
	addeq sp, sp, #4
	moveq r0, r4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020D4660:
	ldrb r5, [r0, #1]
	add r4, r4, #1
	add r1, r1, #0x10
	cmp r4, r5
	blo _020D4624
	b _020D4728
_020D4678:
	add r3, r0, #8
	ldrb r2, [r3, #1]
	cmp r2, #0
	beq _020D4728
	ldrb r5, [r3, r2, lsl #2]
	ldrb r4, [r3]
	add r2, r3, r2, lsl #2
	cmp r4, r5
	bls _020D46CC
_020D469C:
	mov r4, r5, asr #5
	ldr ip, [r1, r4, lsl #2]
	and r4, r5, #0x1f
	mov r4, ip, lsr r4
	and r4, r4, #1
	add r4, r2, r4
	ldrb ip, [r4, #1]
	ldrb r4, [r2]
	ldrb r5, [r3, ip, lsl #2]
	add r2, r3, ip, lsl #2
	cmp r4, r5
	bhi _020D469C
_020D46CC:
	ldrh r4, [r0, #6]
	ldr r3, [r1]
	add ip, r0, r4
	ldrh r4, [ip, #2]
	ldrb r0, [r2, #3]
	add r4, ip, r4
	ldr r2, [r4, r0, lsl #4]
	add r4, r4, r0, lsl #4
	cmp r2, r3
	bne _020D4728
	ldr r3, [r4, #4]
	ldr r2, [r1, #4]
	cmp r3, r2
	bne _020D4728
	ldr r3, [r4, #8]
	ldr r2, [r1, #8]
	cmp r3, r2
	bne _020D4728
	ldr r2, [r4, #0xc]
	ldr r1, [r1, #0xc]
	cmp r2, r1
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020D4728:
	mvn r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end NNS_G3dGetResDictIdxByName

	arm_func_start NNS_G3dGetResDataByName
NNS_G3dGetResDataByName: // 0x020D4734
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldrb r2, [r0, #1]
	cmp r2, #0x10
	bhs _020D47E0
	cmp r2, #0
	ldr lr, [r1]
	ldr ip, [r1, #4]
	ldr r3, [r1, #8]
	ldr r2, [r1, #0xc]
	mov r4, #0
	bls _020D4898
	ldrh r5, [r0, #6]
	mov r1, r4
	add r6, r0, r5
	ldrh r5, [r6, #2]
	add r6, r6, r5
_020D4778:
	ldr r5, [r6, r1]
	add r7, r6, r1
	cmp r5, lr
	bne _020D47C8
	ldr r5, [r7, #4]
	cmp r5, ip
	bne _020D47C8
	ldr r5, [r7, #8]
	cmp r5, r3
	bne _020D47C8
	ldr r5, [r7, #0xc]
	cmp r5, r2
	bne _020D47C8
	ldrh r2, [r0, #6]
	add sp, sp, #4
	ldrh r1, [r0, r2]
	add r0, r0, r2
	add r0, r0, #4
	mla r0, r1, r4, r0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020D47C8:
	ldrb r5, [r0, #1]
	add r4, r4, #1
	add r1, r1, #0x10
	cmp r4, r5
	blo _020D4778
	b _020D4898
_020D47E0:
	add r3, r0, #8
	ldrb r2, [r3, #1]
	cmp r2, #0
	beq _020D4898
	ldrb r5, [r3, r2, lsl #2]
	ldrb r4, [r3]
	add r2, r3, r2, lsl #2
	cmp r4, r5
	bls _020D4834
_020D4804:
	mov r4, r5, asr #5
	ldr ip, [r1, r4, lsl #2]
	and r4, r5, #0x1f
	mov r4, ip, lsr r4
	and r4, r4, #1
	add r4, r2, r4
	ldrb ip, [r4, #1]
	ldrb r4, [r2]
	ldrb r5, [r3, ip, lsl #2]
	add r2, r3, ip, lsl #2
	cmp r4, r5
	bhi _020D4804
_020D4834:
	ldrh r4, [r0, #6]
	ldrb r2, [r2, #3]
	ldr r3, [r1]
	add r0, r0, r4
	ldrh r4, [r0, #2]
	add ip, r0, r4
	ldr r4, [ip, r2, lsl #4]
	add ip, ip, r2, lsl #4
	cmp r4, r3
	bne _020D4898
	ldr r4, [ip, #4]
	ldr r3, [r1, #4]
	cmp r4, r3
	bne _020D4898
	ldr r4, [ip, #8]
	ldr r3, [r1, #8]
	cmp r4, r3
	bne _020D4898
	ldr r3, [ip, #0xc]
	ldr r1, [r1, #0xc]
	cmp r3, r1
	ldreqh r1, [r0], #4
	addeq sp, sp, #4
	mlaeq r0, r1, r2, r0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020D4898:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end NNS_G3dGetResDataByName

	arm_func_start NNSi_G3dGetTexPatAnmDataByIdx
NNSi_G3dGetTexPatAnmDataByIdx: // 0x020D48A4
	ldrh r3, [r0, #0x12]
	add r0, r0, #0xc
	ldrh r2, [r0, r3]
	add r0, r0, r3
	add r0, r0, #4
	mla r0, r2, r1, r0
	bx lr
	arm_func_end NNSi_G3dGetTexPatAnmDataByIdx

	arm_func_start NNSi_G3dGetTexPatAnmFV
NNSi_G3dGetTexPatAnmFV: // 0x020D48C0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r2
	bl NNSi_G3dGetTexPatAnmDataByIdx
	ldrsh r1, [r0, #4]
	ldrh r3, [r0, #6]
	mul r2, r1, r4
	add r3, r5, r3
	mov r2, r2, lsr #0xc
	b _020D48F0
_020D48EC:
	sub r2, r2, #1
_020D48F0:
	cmp r2, #0
	beq _020D4908
	mov r1, r2, lsl #2
	ldrh r1, [r3, r1]
	cmp r1, r4
	bhs _020D48EC
_020D4908:
	ldrh r1, [r0]
	b _020D4914
_020D4910:
	add r2, r2, #1
_020D4914:
	add r0, r2, #1
	cmp r0, r1
	bhs _020D4930
	add r0, r3, r2, lsl #2
	ldrh r0, [r0, #4]
	cmp r0, r4
	bls _020D4910
_020D4930:
	add r0, r3, r2, lsl #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNSi_G3dGetTexPatAnmFV

	arm_func_start NNSi_G3dGetTexPatAnmPlttNameByIdx
NNSi_G3dGetTexPatAnmPlttNameByIdx: // 0x020D493C
	ldrh r2, [r0, #0xa]
	add r0, r0, r2
	add r0, r0, r1, lsl #4
	bx lr
	arm_func_end NNSi_G3dGetTexPatAnmPlttNameByIdx

	arm_func_start NNSi_G3dGetTexPatAnmTexNameByIdx
NNSi_G3dGetTexPatAnmTexNameByIdx: // 0x020D494C
	ldrh r2, [r0, #8]
	add r0, r0, r2
	add r0, r0, r1, lsl #4
	bx lr
	arm_func_end NNSi_G3dGetTexPatAnmTexNameByIdx

	arm_func_start NNS_G3dGetAnmByIdx
NNS_G3dGetAnmByIdx: // 0x020D495C
	ldrh r2, [r0, #0xc]
	ldr r2, [r0, r2]
	add ip, r0, r2
	ldrh r2, [ip, #0xe]
	add r3, ip, #8
	ldrh r0, [r3, r2]
	add r2, r3, r2
	add r2, r2, #4
	mul r1, r0, r1
	adds r0, r2, r1
	ldrne r0, [r0]
	addne r0, ip, r0
	moveq r0, #0
	bx lr
	arm_func_end NNS_G3dGetAnmByIdx

	arm_func_start getRotDataByIdx_
getRotDataByIdx_: // 0x020D4994
	stmdb sp!, {r4, lr}
	ands r4, r3, #0x8000
	beq _020D4A74
	mov r2, #0
	str r2, [r0, #0x20]
	ldr r4, [r0, #0x20]
	ldr r2, _020D4B18 // =0x00007FFF
	str r4, [r0, #0x1c]
	ldr r4, [r0, #0x1c]
	and r3, r3, r2
	str r4, [r0, #0x18]
	ldr r4, [r0, #0x18]
	mov r2, #3
	str r4, [r0, #0x14]
	ldr r4, [r0, #0x14]
	mul r2, r3, r2
	str r4, [r0, #0x10]
	ldr r4, [r0, #0x10]
	mov r3, r2, lsl #1
	str r4, [r0, #0xc]
	ldr r4, [r0, #0xc]
	add r2, r1, r2, lsl #1
	str r4, [r0, #8]
	ldr r4, [r0, #8]
	str r4, [r0, #4]
	ldr r4, [r0, #4]
	str r4, [r0]
	ldrsh r4, [r1, r3]
	ldrsh ip, [r2, #2]
	ldrsh r3, [r2, #4]
	and r1, r4, #0xf
	ands r4, r4, #0x10
	movne lr, #0x1000
	rsbne lr, lr, #0
	moveq lr, #0x1000
	str lr, [r0, r1, lsl #2]
	ldr r4, _020D4B1C // =_02112868
	ldr lr, _020D4B20 // =_02112869
	ldrb r4, [r4, r1, lsl #2]
	str ip, [r0, r4, lsl #2]
	ldrb lr, [lr, r1, lsl #2]
	str r3, [r0, lr, lsl #2]
	ldrsh lr, [r2]
	ands lr, lr, #0x20
	ldr lr, _020D4B24 // =_0211286A
	rsbne r3, r3, #0
	ldrb lr, [lr, r1, lsl #2]
	str r3, [r0, lr, lsl #2]
	ldrsh r2, [r2]
	ands r2, r2, #0x40
	ldr r2, _020D4B28 // =_0211286B
	rsbne ip, ip, #0
	ldrb r1, [r2, r1, lsl #2]
	str ip, [r0, r1, lsl #2]
	mov r0, #0
	ldmia sp!, {r4, pc}
_020D4A74:
	ldr r1, _020D4B18 // =0x00007FFF
	mov ip, #5
	and r1, r3, r1
	mul r3, r1, ip
	add r1, r2, r3, lsl #1
	ldrsh lr, [r1, #8]
	mov ip, r3, lsl #1
	mov r3, lr, asr #3
	str r3, [r0, #0x10]
	ldrsh ip, [r2, ip]
	and r2, lr, #7
	mov r2, r2, lsl #0x10
	mov r3, ip, asr #3
	str r3, [r0]
	ldrsh r3, [r1, #2]
	and ip, ip, #7
	orr lr, ip, r2, asr #13
	mov r2, r3, asr #3
	str r2, [r0, #4]
	ldrsh ip, [r1, #4]
	mov r2, lr, lsl #0x10
	and lr, r3, #7
	mov r3, ip, asr #3
	str r3, [r0, #8]
	ldrsh r3, [r1, #6]
	orr r1, lr, r2, asr #13
	mov r1, r1, lsl #0x10
	and r2, ip, #7
	orr r1, r2, r1, asr #13
	mov r1, r1, lsl #0x10
	and r2, r3, #7
	orr r1, r2, r1, asr #13
	mov r1, r1, lsl #0x10
	mov r1, r1, asr #0x10
	mov r2, r3, asr #3
	mov r1, r1, lsl #0x13
	str r2, [r0, #0xc]
	mov r1, r1, asr #0x13
	str r1, [r0, #0x14]
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D4B18: .word 0x00007FFF
_020D4B1C: .word 0x02112868
_020D4B20: .word 0x02112869
_020D4B24: .word 0x0211286A
_020D4B28: .word 0x0211286B
	arm_func_end getRotDataByIdx_

	arm_func_start getRotDataEx_
getRotDataEx_: // 0x020D4B2C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x48
	ldrh r4, [r3, #4]
	ldr r5, [r3, #0xc]
	ldr r8, [r3, #0x10]
	ldr r7, [r2, #4]
	mov ip, r1, asr #0xc
	sub r4, r4, #1
	mov r6, r0
	cmp ip, r4
	add r5, r3, r5
	add r4, r3, r8
	add r8, r3, r7
	ldr r7, [r2]
	bne _020D4C14
	ands r0, r7, #0xc0000000
	beq _020D4B84
	ands r0, r7, #0x40000000
	andne r0, ip, #1
	addne ip, r0, ip, lsr #1
	andeq r0, ip, #3
	addeq ip, r0, ip, lsr #2
_020D4B84:
	ldr r0, [r3, #8]
	ands r0, r0, #2
	movne r7, #0
	bne _020D4C88
	mov r0, ip, lsl #1
	ldrh r3, [r8, r0]
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl getRotDataByIdx_
	cmp r0, #0
	addeq sp, sp, #0x48
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r9, [r6, #0x14]
	ldr r5, [r6, #4]
	ldr r4, [r6, #0x10]
	ldr r2, [r6, #8]
	mul r1, r5, r9
	mul r0, r2, r4
	sub r0, r1, r0
	ldr r7, [r6, #0xc]
	ldr r8, [r6]
	mov r3, r0, asr #0xc
	mul r1, r2, r7
	mul r0, r8, r9
	sub r2, r1, r0
	mul r1, r8, r4
	mul r0, r5, r7
	sub r0, r1, r0
	str r3, [r6, #0x18]
	mov r1, r2, asr #0xc
	str r1, [r6, #0x1c]
	mov r0, r0, asr #0xc
	add sp, sp, #0x48
	str r0, [r6, #0x20]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020D4C14:
	ands r0, r7, #0xc0000000
	beq _020D4C84
	ldr r0, _020D4E58 // =0x1FFF0000
	ands r2, r7, #0x40000000
	and r0, r7, r0
	mov r0, r0, lsr #0x10
	beq _020D4C58
	cmp ip, r0
	movhs ip, r0, lsr #1
	addhs r7, ip, #1
	bhs _020D4C88
	ldr r0, _020D4E5C // =0x00001FFF
	mov ip, ip, lsr #1
	add r7, ip, #1
	and r10, r1, r0
	mov r9, #2
	b _020D4C94
_020D4C58:
	cmp ip, r0
	andhs r0, ip, #3
	addhs ip, r0, ip, lsr #2
	addhs r7, ip, #1
	bhs _020D4C88
	ldr r0, _020D4E60 // =0x00003FFF
	mov ip, ip, lsr #2
	add r7, ip, #1
	and r10, r1, r0
	mov r9, #4
	b _020D4C94
_020D4C84:
	add r7, ip, #1
_020D4C88:
	ldr r0, _020D4E64 // =0x00000FFF
	mov r9, #1
	and r10, r1, r0
_020D4C94:
	mov r0, ip, lsl #1
	ldrh r3, [r8, r0]
	add r0, sp, #0
	mov r1, r5
	mov r2, r4
	bl getRotDataByIdx_
	mov r1, r7, lsl #1
	ldrh r3, [r8, r1]
	orr r7, r0, #0
	add r0, sp, #0x24
	mov r1, r5
	mov r2, r4
	bl getRotDataByIdx_
	ldr r3, [sp]
	ldr r1, [sp, #0x24]
	mul r2, r3, r9
	sub r1, r1, r3
	mul r1, r10, r1
	add r1, r2, r1, asr #12
	str r1, [r6]
	ldr r3, [sp, #4]
	ldr r1, [sp, #0x28]
	mul r2, r3, r9
	sub r1, r1, r3
	mul r1, r10, r1
	add r1, r2, r1, asr #12
	str r1, [r6, #4]
	ldr r3, [sp, #8]
	ldr r1, [sp, #0x2c]
	mul r2, r3, r9
	sub r1, r1, r3
	mul r1, r10, r1
	add r1, r2, r1, asr #12
	str r1, [r6, #8]
	ldr r3, [sp, #0xc]
	ldr r1, [sp, #0x30]
	mul r2, r3, r9
	sub r1, r1, r3
	mul r1, r10, r1
	add r1, r2, r1, asr #12
	str r1, [r6, #0xc]
	ldr r2, [sp, #0x10]
	ldr r1, [sp, #0x34]
	orr r7, r7, r0
	sub r0, r1, r2
	mul r1, r2, r9
	mul r0, r10, r0
	add r0, r1, r0, asr #12
	str r0, [r6, #0x10]
	ldr r2, [sp, #0x14]
	ldr r0, [sp, #0x38]
	mul r1, r2, r9
	sub r0, r0, r2
	mul r0, r10, r0
	add r2, r1, r0, asr #12
	mov r0, r6
	mov r1, r6
	str r2, [r6, #0x14]
	bl VEC_Normalize
	add r0, r6, #0xc
	mov r1, r0
	bl VEC_Normalize
	cmp r7, #0
	bne _020D4DFC
	ldr r3, [sp, #0x18]
	ldr r1, [sp, #0x3c]
	mul r2, r3, r9
	sub r1, r1, r3
	mul r1, r10, r1
	add r1, r2, r1, asr #12
	str r1, [r6, #0x18]
	ldr r3, [sp, #0x1c]
	ldr r1, [sp, #0x40]
	mul r2, r3, r9
	sub r1, r1, r3
	mul r1, r10, r1
	add r1, r2, r1, asr #12
	str r1, [r6, #0x1c]
	ldr r3, [sp, #0x20]
	ldr r1, [sp, #0x44]
	mul r2, r3, r9
	sub r1, r1, r3
	mul r1, r10, r1
	add r2, r2, r1, asr #12
	add r0, r6, #0x18
	mov r1, r0
	str r2, [r6, #0x20]
	bl VEC_Normalize
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020D4DFC:
	ldr r9, [r6, #0x14]
	ldr r5, [r6, #4]
	ldr r8, [r6]
	ldr r4, [r6, #0x10]
	ldr r2, [r6, #8]
	ldr r7, [r6, #0xc]
	mul r1, r5, r9
	mul r0, r2, r4
	sub r0, r1, r0
	mov r3, r0, asr #0xc
	mul r1, r2, r7
	mul r0, r8, r9
	sub r2, r1, r0
	mul r1, r8, r4
	mul r0, r5, r7
	sub r0, r1, r0
	str r3, [r6, #0x18]
	mov r1, r2, asr #0xc
	str r1, [r6, #0x1c]
	mov r0, r0, asr #0xc
	str r0, [r6, #0x20]
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020D4E58: .word 0x1FFF0000
_020D4E5C: .word 0x00001FFF
_020D4E60: .word 0x00003FFF
_020D4E64: .word 0x00000FFF
	arm_func_end getRotDataEx_

	arm_func_start getRotData_
getRotData_: // 0x020D4E68
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x4c
	ldr r5, [r3, #0xc]
	ldr r4, [r3, #0x10]
	ldr ip, [r2]
	ldr r2, [r2, #4]
	mov r6, r0
	mov r0, r1, asr #0xc
	add r5, r3, r5
	add r4, r3, r4
	add r8, r3, r2
	ands r1, ip, #0xc0000000
	beq _020D51D4
	ldr r1, _020D5254 // =0x1FFF0000
	ands r2, ip, #0x40000000
	and r1, ip, r1
	mov r2, r1, lsr #0x10
	beq _020D4ED8
	ands r1, r0, #1
	beq _020D4ED0
	cmp r0, r2
	movhi r0, r2, lsr #1
	addhi r0, r0, #1
	bhi _020D51D4
	mov r7, r0, lsr #1
	b _020D507C
_020D4ED0:
	mov r0, r0, lsr #1
	b _020D51D4
_020D4ED8:
	ands r1, r0, #3
	beq _020D5074
	cmp r0, r2
	addhi r0, r1, r2, lsr #2
	bhi _020D51D4
	ands r1, r0, #1
	beq _020D506C
	ands r1, r0, #2
	movne r9, r0, lsr #2
	addne r0, r9, #1
	moveq r0, r0, lsr #2
	addeq r9, r0, #1
	mov r0, r0, lsl #1
	ldrh r3, [r8, r0]
	mov r0, r6
	mov r1, r5
	mov r2, r4
	mov r7, #0
	bl getRotDataByIdx_
	mov r1, r9, lsl #1
	ldrh r3, [r8, r1]
	orr r7, r7, r0
	add r0, sp, #0
	mov r1, r5
	mov r2, r4
	bl getRotDataByIdx_
	ldr r3, [sp]
	ldr r1, [r6]
	mov r2, #3
	mla r3, r1, r2, r3
	str r3, [r6]
	ldr r3, [sp, #4]
	ldr r1, [r6, #4]
	orr r7, r7, r0
	mla r0, r1, r2, r3
	str r0, [r6, #4]
	ldr r3, [sp, #8]
	ldr r1, [r6, #8]
	mov r0, r6
	mla r3, r1, r2, r3
	str r3, [r6, #8]
	ldr r4, [sp, #0xc]
	ldr r3, [r6, #0xc]
	mov r1, r6
	mla r4, r3, r2, r4
	str r4, [r6, #0xc]
	ldr r4, [sp, #0x10]
	ldr r3, [r6, #0x10]
	mla r4, r3, r2, r4
	str r4, [r6, #0x10]
	ldr r4, [sp, #0x14]
	ldr r3, [r6, #0x14]
	mla r2, r3, r2, r4
	str r2, [r6, #0x14]
	bl VEC_Normalize
	add r0, r6, #0xc
	mov r1, r0
	bl VEC_Normalize
	cmp r7, #0
	bne _020D5010
	ldr r1, [sp, #0x18]
	ldr r0, [r6, #0x18]
	mov r2, #3
	mla r1, r0, r2, r1
	str r1, [r6, #0x18]
	ldr r3, [sp, #0x1c]
	ldr r1, [r6, #0x1c]
	add r0, r6, #0x18
	mla r3, r1, r2, r3
	str r3, [r6, #0x1c]
	ldr r4, [sp, #0x20]
	ldr r3, [r6, #0x20]
	mov r1, r0
	mla r2, r3, r2, r4
	str r2, [r6, #0x20]
	bl VEC_Normalize
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020D5010:
	ldr ip, [r6, #0x14]
	ldr r5, [r6, #4]
	ldr r4, [r6, #0x10]
	ldr r2, [r6, #8]
	mul r1, r5, ip
	mul r0, r2, r4
	sub r0, r1, r0
	ldr r7, [r6, #0xc]
	ldr r8, [r6]
	mov r3, r0, asr #0xc
	mul r1, r2, r7
	mul r0, r8, ip
	sub r2, r1, r0
	mul r1, r8, r4
	mul r0, r5, r7
	sub r0, r1, r0
	str r3, [r6, #0x18]
	mov r1, r2, asr #0xc
	str r1, [r6, #0x1c]
	mov r0, r0, asr #0xc
	add sp, sp, #0x4c
	str r0, [r6, #0x20]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020D506C:
	mov r7, r0, lsr #2
	b _020D507C
_020D5074:
	mov r0, r0, lsr #2
	b _020D51D4
_020D507C:
	mov r0, r7, lsl #1
	ldrh r3, [r8, r0]
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl getRotDataByIdx_
	add r1, r8, r7, lsl #1
	ldrh r3, [r1, #2]
	orr r7, r0, #0
	add r0, sp, #0x24
	mov r1, r5
	mov r2, r4
	bl getRotDataByIdx_
	ldr r2, [r6]
	ldr r1, [sp, #0x24]
	orr r7, r7, r0
	add r0, r2, r1
	str r0, [r6]
	ldr r2, [r6, #4]
	ldr r1, [sp, #0x28]
	mov r0, r6
	add r1, r2, r1
	str r1, [r6, #4]
	ldr r3, [r6, #8]
	ldr r2, [sp, #0x2c]
	mov r1, r6
	add r2, r3, r2
	str r2, [r6, #8]
	ldr r3, [r6, #0xc]
	ldr r2, [sp, #0x30]
	add r2, r3, r2
	str r2, [r6, #0xc]
	ldr r3, [r6, #0x10]
	ldr r2, [sp, #0x34]
	add r2, r3, r2
	str r2, [r6, #0x10]
	ldr r3, [r6, #0x14]
	ldr r2, [sp, #0x38]
	add r2, r3, r2
	str r2, [r6, #0x14]
	bl VEC_Normalize
	add r0, r6, #0xc
	mov r1, r0
	bl VEC_Normalize
	cmp r7, #0
	bne _020D5178
	ldr r2, [r6, #0x18]
	ldr r1, [sp, #0x3c]
	add r0, r6, #0x18
	add r1, r2, r1
	str r1, [r6, #0x18]
	ldr r3, [r6, #0x1c]
	ldr r2, [sp, #0x40]
	mov r1, r0
	add r2, r3, r2
	str r2, [r6, #0x1c]
	ldr r3, [r6, #0x20]
	ldr r2, [sp, #0x44]
	add r2, r3, r2
	str r2, [r6, #0x20]
	bl VEC_Normalize
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020D5178:
	ldr ip, [r6, #0x14]
	ldr r5, [r6, #4]
	ldr r4, [r6, #0x10]
	ldr r2, [r6, #8]
	mul r1, r5, ip
	mul r0, r2, r4
	sub r0, r1, r0
	ldr r7, [r6, #0xc]
	ldr r8, [r6]
	mov r3, r0, asr #0xc
	mul r1, r2, r7
	mul r0, r8, ip
	sub r2, r1, r0
	mul r1, r8, r4
	mul r0, r5, r7
	sub r0, r1, r0
	str r3, [r6, #0x18]
	mov r1, r2, asr #0xc
	str r1, [r6, #0x1c]
	mov r0, r0, asr #0xc
	add sp, sp, #0x4c
	str r0, [r6, #0x20]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020D51D4:
	mov r0, r0, lsl #1
	ldrh r3, [r8, r0]
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl getRotDataByIdx_
	cmp r0, #0
	addeq sp, sp, #0x4c
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr ip, [r6, #0x14]
	ldr r5, [r6, #4]
	ldr r8, [r6]
	ldr r4, [r6, #0x10]
	ldr r2, [r6, #8]
	ldr r7, [r6, #0xc]
	mul r1, r5, ip
	mul r0, r2, r4
	sub r0, r1, r0
	mov r3, r0, asr #0xc
	mul r1, r2, r7
	mul r0, r8, ip
	sub r2, r1, r0
	mul r1, r8, r4
	mul r0, r5, r7
	sub r0, r1, r0
	str r3, [r6, #0x18]
	mov r1, r2, asr #0xc
	str r1, [r6, #0x1c]
	mov r0, r0, asr #0xc
	str r0, [r6, #0x20]
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020D5254: .word 0x1FFF0000
	arm_func_end getRotData_

	arm_func_start getScaleDataEx_
getScaleDataEx_: // 0x020D5258
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldrh r4, [r3, #4]
	ldr r6, [r2, #4]
	mov r5, r1, asr #0xc
	sub r4, r4, #1
	cmp r5, r4
	add r6, r3, r6
	ldr r2, [r2]
	bne _020D52EC
	ands r4, r2, #0xc0000000
	beq _020D529C
	ands r4, r2, #0x40000000
	andne r4, r5, #1
	addne r5, r4, r5, lsr #1
	andeq r4, r5, #3
	addeq r5, r4, r5, lsr #2
_020D529C:
	ldr r3, [r3, #8]
	ands r3, r3, #2
	movne r4, #0
	bne _020D5368
	ands r1, r2, #0x20000000
	ldreq r2, [r6, r5, lsl #3]
	addeq r1, r6, r5, lsl #3
	streq r2, [r0]
	ldreq r1, [r1, #4]
	addeq sp, sp, #4
	streq r1, [r0, #4]
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r1, r5, lsl #2
	ldrsh r2, [r6, r1]
	add r1, r6, r5, lsl #2
	add sp, sp, #4
	str r2, [r0]
	ldrsh r1, [r1, #2]
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, r6, r7, pc}
_020D52EC:
	ands r3, r2, #0xc0000000
	beq _020D5364
	ldr r3, _020D53F4 // =0x1FFF0000
	ands r4, r2, #0x40000000
	and r3, r2, r3
	mov r3, r3, lsr #0x10
	beq _020D5334
	cmp r5, r3
	movhs r5, r3, lsr #1
	addhs r4, r5, #1
	bhs _020D5368
	ldr r3, _020D53F8 // =0x00001FFF
	mov r5, r5, lsr #1
	add r4, r5, #1
	and lr, r1, r3
	mov ip, #2
	mov r3, #1
	b _020D5378
_020D5334:
	cmp r5, r3
	andhs r3, r5, #3
	addhs r5, r3, r5, lsr #2
	addhs r4, r5, #1
	bhs _020D5368
	ldr r3, _020D53FC // =0x00003FFF
	mov r5, r5, lsr #2
	add r4, r5, #1
	and lr, r1, r3
	mov ip, #4
	mov r3, #2
	b _020D5378
_020D5364:
	add r4, r5, #1
_020D5368:
	ldr r3, _020D5400 // =0x00000FFF
	mov ip, #1
	and lr, r1, r3
	mov r3, #0
_020D5378:
	ands r1, r2, #0x20000000
	beq _020D53A4
	mov r2, r5, lsl #2
	add r1, r6, r5, lsl #2
	mov r5, r4, lsl #2
	add r4, r6, r4, lsl #2
	ldrsh r2, [r6, r2]
	ldrsh r1, [r1, #2]
	ldrsh r5, [r6, r5]
	ldrsh r4, [r4, #2]
	b _020D53BC
_020D53A4:
	add r1, r6, r5, lsl #3
	add r7, r6, r4, lsl #3
	ldr r2, [r6, r5, lsl #3]
	ldr r1, [r1, #4]
	ldr r5, [r6, r4, lsl #3]
	ldr r4, [r7, #4]
_020D53BC:
	sub r5, r5, r2
	sub r4, r4, r1
	mul r6, r2, ip
	mul r2, lr, r5
	add r2, r6, r2, asr #12
	mov r5, r2, asr r3
	mul r2, r1, ip
	mul r1, lr, r4
	add r1, r2, r1, asr #12
	mov r1, r1, asr r3
	str r5, [r0]
	str r1, [r0, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020D53F4: .word 0x1FFF0000
_020D53F8: .word 0x00001FFF
_020D53FC: .word 0x00003FFF
_020D5400: .word 0x00000FFF
	arm_func_end getScaleDataEx_

	arm_func_start getScaleData_
getScaleData_: // 0x020D5404
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, [r2, #4]
	ldr ip, [r2]
	mov r1, r1, asr #0xc
	add r3, r3, r4
	ands r2, ip, #0xc0000000
	beq _020D5564
	ldr r2, _020D5618 // =0x1FFF0000
	ands r4, ip, #0x40000000
	and r2, ip, r2
	mov r4, r2, lsr #0x10
	beq _020D5460
	ands r2, r1, #1
	beq _020D5458
	cmp r1, r4
	movhi r1, r4, lsr #1
	addhi r1, r1, #1
	bhi _020D5564
	mov r2, r1, lsr #1
	b _020D55A4
_020D5458:
	mov r1, r1, lsr #1
	b _020D5564
_020D5460:
	ands r2, r1, #3
	beq _020D5560
	cmp r1, r4
	addhi r1, r2, r4, lsr #2
	bhi _020D5564
	ands r2, r1, #1
	beq _020D5558
	ands r2, r1, #2
	movne r1, r1, lsr #2
	addne r2, r1, #1
	moveq r2, r1, lsr #2
	addeq r1, r2, #1
	ands r4, ip, #0x20000000
	beq _020D54E0
	mov r5, r2, lsl #2
	mov r4, r1, lsl #2
	ldrsh ip, [r3, r5]
	ldrsh r5, [r3, r4]
	add r2, r3, r2, lsl #2
	add r4, ip, ip, lsl #1
	add r4, r5, r4
	mov r4, r4, asr #2
	str r4, [r0]
	add r1, r3, r1, lsl #2
	ldrsh r3, [r2, #2]
	ldrsh r2, [r1, #2]
	add sp, sp, #4
	add r1, r3, r3, lsl #1
	add r1, r2, r1
	mov r1, r1, asr #2
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, pc}
_020D54E0:
	ldr r5, [r3, r2, lsl #3]
	ldr r4, [r3, r1, lsl #3]
	mov ip, r5, asr #0x1f
	mov ip, ip, lsl #1
	mov lr, r5, lsl #1
	orr ip, ip, r5, lsr #31
	adds lr, lr, r5
	adc ip, ip, r5, asr #31
	adds lr, lr, r4
	adc ip, ip, r4, asr #31
	mov lr, lr, lsr #2
	orr lr, lr, ip, lsl #30
	str lr, [r0]
	add r2, r3, r2, lsl #3
	ldr ip, [r2, #4]
	add r1, r3, r1, lsl #3
	mov r2, ip, asr #0x1f
	mov r2, r2, lsl #1
	mov r3, ip, lsl #1
	ldr r1, [r1, #4]
	orr r2, r2, ip, lsr #31
	adds r3, r3, ip
	adc r2, r2, ip, asr #31
	adds r3, r3, r1
	adc r1, r2, r1, asr #31
	mov r2, r3, lsr #2
	orr r2, r2, r1, lsl #30
	str r2, [r0, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020D5558:
	mov r2, r1, lsr #2
	b _020D55A4
_020D5560:
	mov r1, r1, lsr #2
_020D5564:
	ands r2, ip, #0x20000000
	ldreq r2, [r3, r1, lsl #3]
	addeq r1, r3, r1, lsl #3
	streq r2, [r0]
	ldreq r1, [r1, #4]
	addeq sp, sp, #4
	streq r1, [r0, #4]
	ldmeqia sp!, {r4, r5, pc}
	mov r2, r1, lsl #2
	ldrsh r2, [r3, r2]
	add r1, r3, r1, lsl #2
	add sp, sp, #4
	str r2, [r0]
	ldrsh r1, [r1, #2]
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, pc}
_020D55A4:
	ands r1, ip, #0x20000000
	beq _020D55E4
	mov r1, r2, lsl #2
	add ip, r3, r2, lsl #2
	ldrsh r2, [r3, r1]
	ldrsh r1, [ip, #4]
	add sp, sp, #4
	add r1, r2, r1
	mov r1, r1, asr #1
	str r1, [r0]
	ldrsh r2, [ip, #2]
	ldrsh r1, [ip, #6]
	add r1, r2, r1
	mov r1, r1, asr #1
	str r1, [r0, #4]
	ldmia sp!, {r4, r5, pc}
_020D55E4:
	add ip, r3, r2, lsl #3
	ldr r2, [r3, r2, lsl #3]
	ldr r1, [ip, #8]
	add r1, r2, r1
	mov r1, r1, asr #1
	str r1, [r0]
	ldr r2, [ip, #4]
	ldr r1, [ip, #0xc]
	add r1, r2, r1
	mov r1, r1, asr #1
	str r1, [r0, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D5618: .word 0x1FFF0000
	arm_func_end getScaleData_

	arm_func_start getTransDataEx_
getTransDataEx_: // 0x020D561C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldrh r4, [r3, #4]
	ldr lr, [r2, #4]
	mov ip, r1, asr #0xc
	sub r4, r4, #1
	cmp ip, r4
	add r4, r3, lr
	ldr lr, [r2]
	bne _020D56C4
	ands r2, lr, #0xc0000000
	beq _020D5660
	ands r2, lr, #0x40000000
	andne r2, ip, #1
	addne ip, r2, ip, lsr #1
	andeq r2, ip, #3
	addeq ip, r2, ip, lsr #2
_020D5660:
	ldr r2, [r3, #8]
	ands r2, r2, #2
	beq _020D56A4
	ldr r2, _020D577C // =0x00000FFF
	ands r3, lr, #0x20000000
	and r3, r1, r2
	movne r1, ip, lsl #1
	ldrnesh r2, [r4, r1]
	ldrnesh r1, [r4]
	add sp, sp, #4
	ldreq r2, [r4, ip, lsl #2]
	ldreq r1, [r4]
	sub r1, r1, r2
	mul r1, r3, r1
	add r1, r2, r1, asr #12
	str r1, [r0]
	ldmia sp!, {r4, r5, pc}
_020D56A4:
	ands r1, lr, #0x20000000
	movne r1, ip, lsl #1
	ldrnesh r1, [r4, r1]
	add sp, sp, #4
	strne r1, [r0]
	ldreq r1, [r4, ip, lsl #2]
	streq r1, [r0]
	ldmia sp!, {r4, r5, pc}
_020D56C4:
	ands r2, lr, #0xc0000000
	beq _020D572C
	ldr r2, _020D5780 // =0x1FFF0000
	ands r3, lr, #0x40000000
	and r2, lr, r2
	mov r2, r2, lsr #0x10
	beq _020D5704
	cmp ip, r2
	movhs ip, r2, lsr #1
	bhs _020D572C
	ldr r2, _020D5784 // =0x00001FFF
	mov ip, ip, lsr #1
	and r5, r1, r2
	mov r2, #2
	mov r1, #1
	b _020D573C
_020D5704:
	cmp ip, r2
	andhs r2, ip, #3
	addhs ip, r2, ip, lsr #2
	bhs _020D572C
	ldr r2, _020D5788 // =0x00003FFF
	mov ip, ip, lsr #2
	and r5, r1, r2
	mov r2, #4
	mov r1, #2
	b _020D573C
_020D572C:
	ldr r3, _020D577C // =0x00000FFF
	mov r2, #1
	and r5, r1, r3
	mov r1, #0
_020D573C:
	ands r3, lr, #0x20000000
	addne r3, r4, ip, lsl #1
	movne lr, ip, lsl #1
	ldrnesh ip, [r4, lr]
	ldrnesh r3, [r3, #2]
	addeq r3, r4, ip, lsl #2
	ldreq ip, [r4, ip, lsl #2]
	ldreq r3, [r3, #4]
	mul r4, ip, r2
	sub r3, r3, ip
	mul r2, r5, r3
	add r2, r4, r2, asr #12
	mov r1, r2, asr r1
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D577C: .word 0x00000FFF
_020D5780: .word 0x1FFF0000
_020D5784: .word 0x00001FFF
_020D5788: .word 0x00003FFF
	arm_func_end getTransDataEx_

	arm_func_start getTransData_
getTransData_: // 0x020D578C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, [r2, #4]
	ldr r2, [r2]
	mov r1, r1, asr #0xc
	add r3, r3, ip
	ands ip, r2, #0xc0000000
	beq _020D58E0
	ldr ip, _020D5900 // =0x1FFF0000
	ands lr, r2, #0x40000000
	and ip, r2, ip
	mov lr, ip, lsr #0x10
	beq _020D57E8
	ands ip, r1, #1
	beq _020D57E0
	cmp r1, lr
	movhi r1, lr, lsr #1
	addhi r1, r1, #1
	bhi _020D58E0
	mov ip, r1, lsr #1
	b _020D5894
_020D57E0:
	mov r1, r1, lsr #1
	b _020D58E0
_020D57E8:
	ands ip, r1, #3
	beq _020D588C
	cmp r1, lr
	addhi r1, ip, lr, lsr #2
	bhi _020D58E0
	ands ip, r1, #1
	beq _020D5884
	ands ip, r1, #2
	movne lr, r1, lsr #2
	addne ip, lr, #1
	moveq ip, r1, lsr #2
	addeq lr, ip, #1
	ands r1, r2, #0x20000000
	beq _020D5848
	mov r2, ip, lsl #1
	mov r1, lr, lsl #1
	ldrsh ip, [r3, r2]
	ldrsh r2, [r3, r1]
	mov r1, #3
	add sp, sp, #4
	smlabb r1, ip, r1, r2
	mov r1, r1, asr #2
	str r1, [r0]
	ldmia sp!, {pc}
_020D5848:
	ldr ip, [r3, ip, lsl #2]
	ldr r1, [r3, lr, lsl #2]
	mov r2, ip, asr #0x1f
	mov r2, r2, lsl #1
	mov r3, ip, lsl #1
	orr r2, r2, ip, lsr #31
	adds r3, r3, ip
	adc r2, r2, ip, asr #31
	adds r3, r3, r1
	adc r1, r2, r1, asr #31
	mov r2, r3, lsr #2
	orr r2, r2, r1, lsl #30
	str r2, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
_020D5884:
	mov ip, r1, lsr #2
	b _020D5894
_020D588C:
	mov r1, r1, lsr #2
	b _020D58E0
_020D5894:
	ands r1, r2, #0x20000000
	beq _020D58C0
	mov r2, ip, lsl #1
	add r1, r3, ip, lsl #1
	ldrsh r2, [r3, r2]
	ldrsh r1, [r1, #2]
	add sp, sp, #4
	add r1, r2, r1
	mov r1, r1, asr #1
	str r1, [r0]
	ldmia sp!, {pc}
_020D58C0:
	add r1, r3, ip, lsl #2
	ldr r2, [r3, ip, lsl #2]
	ldr r1, [r1, #4]
	mov r2, r2, asr #1
	add r1, r2, r1, asr #1
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
_020D58E0:
	ands r2, r2, #0x20000000
	movne r1, r1, lsl #1
	ldrnesh r1, [r3, r1]
	strne r1, [r0]
	ldreq r1, [r3, r1, lsl #2]
	streq r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D5900: .word 0x1FFF0000
	arm_func_end getTransData_

	arm_func_start getJntSRTAnmResult_
getJntSRTAnmResult_: // 0x020D5904
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x34
	mov r9, r0
	add r0, r9, r1, lsl #1
	ldrh r0, [r0, #0x14]
	mov r7, r3
	mov r8, r2
	ldr r5, [r9, r0]
	add r1, r9, r0
	ands r0, r5, #1
	movne r0, #7
	strne r0, [r7]
	bne _020D5CA8
	ldr r0, _020D5CDC // =0x00000FFF
	add r4, r1, #4
	ands r0, r8, r0
	beq _020D5958
	ldr r0, [r9, #8]
	ands r0, r0, #1
	movne r6, #1
	bne _020D595C
_020D5958:
	mov r6, #0
_020D595C:
	mov r0, #0
	str r0, [r7]
	ands r0, r5, #6
	bne _020D5A54
	ands r0, r5, #8
	bne _020D59B0
	cmp r6, #0
	beq _020D5994
	mov r1, r8
	mov r2, r4
	mov r3, r9
	add r0, r7, #0x4c
	bl getTransDataEx_
	b _020D59A8
_020D5994:
	mov r1, r8
	mov r2, r4
	mov r3, r9
	add r0, r7, #0x4c
	bl getTransData_
_020D59A8:
	add r4, r4, #8
	b _020D59B8
_020D59B0:
	ldr r0, [r4], #4
	str r0, [r7, #0x4c]
_020D59B8:
	ands r0, r5, #0x10
	bne _020D59FC
	cmp r6, #0
	beq _020D59E0
	mov r1, r8
	mov r2, r4
	mov r3, r9
	add r0, r7, #0x50
	bl getTransDataEx_
	b _020D59F4
_020D59E0:
	mov r1, r8
	mov r2, r4
	mov r3, r9
	add r0, r7, #0x50
	bl getTransData_
_020D59F4:
	add r4, r4, #8
	b _020D5A04
_020D59FC:
	ldr r0, [r4], #4
	str r0, [r7, #0x50]
_020D5A04:
	ands r0, r5, #0x20
	bne _020D5A48
	cmp r6, #0
	beq _020D5A2C
	mov r1, r8
	mov r2, r4
	mov r3, r9
	add r0, r7, #0x54
	bl getTransDataEx_
	b _020D5A40
_020D5A2C:
	mov r1, r8
	mov r2, r4
	mov r3, r9
	add r0, r7, #0x54
	bl getTransData_
_020D5A40:
	add r4, r4, #8
	b _020D5A70
_020D5A48:
	ldr r0, [r4], #4
	str r0, [r7, #0x54]
	b _020D5A70
_020D5A54:
	ands r0, r5, #2
	ldrne r0, [r7]
	orrne r0, r0, #4
	strne r0, [r7]
	bne _020D5A70
	mov r0, r7
	bl getMdlTrans_
_020D5A70:
	ands r0, r5, #0xc0
	bne _020D5B3C
	ands r0, r5, #0x100
	bne _020D5ABC
	cmp r6, #0
	beq _020D5AA0
	mov r1, r8
	mov r2, r4
	mov r3, r9
	add r0, r7, #0x28
	bl getRotDataEx_
	b _020D5AB4
_020D5AA0:
	mov r1, r8
	mov r2, r4
	mov r3, r9
	add r0, r7, #0x28
	bl getRotData_
_020D5AB4:
	add r4, r4, #8
	b _020D5B58
_020D5ABC:
	ldr r1, [r9, #0xc]
	ldr r2, [r9, #0x10]
	ldr r3, [r4]
	add r0, r7, #0x28
	add r1, r9, r1
	add r2, r9, r2
	bl getRotDataByIdx_
	cmp r0, #0
	beq _020D5B34
	ldr ip, [r7, #0x3c]
	ldr r0, [r7, #0x2c]
	ldr r3, [r7, #0x28]
	ldr r11, [r7, #0x38]
	ldr r1, [r7, #0x30]
	ldr r2, [r7, #0x34]
	mul r10, r0, ip
	mul lr, r1, r11
	sub r10, r10, lr
	mov r10, r10, asr #0xc
	mul lr, r1, r2
	mul r1, r3, ip
	sub r1, lr, r1
	mul r11, r3, r11
	mul r2, r0, r2
	sub r0, r11, r2
	str r10, [r7, #0x40]
	mov r1, r1, asr #0xc
	str r1, [r7, #0x44]
	mov r0, r0, asr #0xc
	str r0, [r7, #0x48]
_020D5B34:
	add r4, r4, #4
	b _020D5B58
_020D5B3C:
	ands r0, r5, #0x40
	ldrne r0, [r7]
	orrne r0, r0, #2
	strne r0, [r7]
	bne _020D5B58
	mov r0, r7
	bl getMdlRot_
_020D5B58:
	ands r0, r5, #0x600
	bne _020D5C84
	ands r0, r5, #0x800
	bne _020D5BB0
	cmp r6, #0
	beq _020D5B88
	add r0, sp, #0
	mov r1, r8
	mov r2, r4
	mov r3, r9
	bl getScaleDataEx_
	b _020D5B9C
_020D5B88:
	add r0, sp, #0
	mov r1, r8
	mov r2, r4
	mov r3, r9
	bl getScaleData_
_020D5B9C:
	ldr r1, [sp]
	ldr r0, [sp, #4]
	str r1, [sp, #0x18]
	str r0, [sp, #0x24]
	b _020D5BC0
_020D5BB0:
	ldr r0, [r4]
	str r0, [sp, #0x18]
	ldr r0, [r4, #4]
	str r0, [sp, #0x24]
_020D5BC0:
	ands r0, r5, #0x1000
	bne _020D5C10
	cmp r6, #0
	beq _020D5BE8
	add r0, sp, #8
	mov r1, r8
	mov r3, r9
	add r2, r4, #8
	bl getScaleDataEx_
	b _020D5BFC
_020D5BE8:
	add r0, sp, #8
	mov r1, r8
	mov r3, r9
	add r2, r4, #8
	bl getScaleData_
_020D5BFC:
	ldr r1, [sp, #8]
	ldr r0, [sp, #0xc]
	str r1, [sp, #0x1c]
	str r0, [sp, #0x28]
	b _020D5C20
_020D5C10:
	ldr r0, [r4, #8]
	str r0, [sp, #0x1c]
	ldr r0, [r4, #0xc]
	str r0, [sp, #0x28]
_020D5C20:
	ands r0, r5, #0x2000
	bne _020D5C70
	cmp r6, #0
	beq _020D5C48
	add r0, sp, #0x10
	mov r1, r8
	mov r3, r9
	add r2, r4, #0x10
	bl getScaleDataEx_
	b _020D5C5C
_020D5C48:
	add r0, sp, #0x10
	mov r1, r8
	mov r3, r9
	add r2, r4, #0x10
	bl getScaleData_
_020D5C5C:
	ldr r1, [sp, #0x10]
	ldr r0, [sp, #0x14]
	str r1, [sp, #0x20]
	str r0, [sp, #0x2c]
	b _020D5CA8
_020D5C70:
	ldr r0, [r4, #0x10]
	str r0, [sp, #0x20]
	ldr r0, [r4, #0x14]
	str r0, [sp, #0x2c]
	b _020D5CA8
_020D5C84:
	ands r0, r5, #0x200
	ldrne r0, [r7]
	orrne r0, r0, #1
	strne r0, [r7]
	bne _020D5CA8
	mov r0, r7
	bl getMdlScale_
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020D5CA8:
	ldr r0, [r7]
	add r1, sp, #0x18
	ands r0, r0, #1
	ldr r0, _020D5CE0 // =_021474A4
	movne r3, #4
	ldr r4, [r0]
	moveq r3, #0
	ldr r2, [r4]
	ldr r4, [r4, #0xe8]
	mov r0, r7
	blx r4
	add sp, sp, #0x34
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020D5CDC: .word 0x00000FFF
_020D5CE0: .word _021474A4
	arm_func_end getJntSRTAnmResult_

	arm_func_start getMdlRot_
getMdlRot_: // 0x020D5CE4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r1, _020D5E24 // =_021474A4
	mov r8, r0
	ldr r0, [r1]
	ldr r3, [r0, #0xd4]
	ldr r0, [r0]
	ldrh r2, [r3, #6]
	ldrb r0, [r0, #1]
	ldrh r1, [r3, r2]
	add r2, r3, r2
	mla r0, r1, r0, r2
	ldr r0, [r0, #4]
	ldrh r2, [r3, r0]
	add r4, r3, r0
	add r1, r4, #4
	ands r0, r2, #1
	addeq r1, r1, #0xc
	ands r0, r2, #2
	bne _020D5E14
	ands r0, r2, #8
	beq _020D5DC8
	and r2, r2, #0xf0
	add r0, r8, #0x28
	mov r5, r2, asr #4
	ldrsh r7, [r1]
	ldrsh r6, [r1, #2]
	blx MI_Zero36B
	ldrh r0, [r4]
	add r1, r8, r5, lsl #2
	ands r0, r0, #0x100
	movne r0, #0x1000
	rsbne r2, r0, #0
	moveq r2, #0x1000
	ldr r0, _020D5E28 // =_02112868
	str r2, [r1, #0x28]
	ldrb r1, [r0, r5, lsl #2]
	ldr r0, _020D5E2C // =_02112869
	add r1, r8, r1, lsl #2
	str r7, [r1, #0x28]
	ldrb r0, [r0, r5, lsl #2]
	add r0, r8, r0, lsl #2
	str r6, [r0, #0x28]
	ldrh r0, [r4]
	ands r0, r0, #0x200
	ldr r0, _020D5E30 // =_0211286A
	rsbne r6, r6, #0
	ldrb r0, [r0, r5, lsl #2]
	add r0, r8, r0, lsl #2
	str r6, [r0, #0x28]
	ldrh r0, [r4]
	ands r0, r0, #0x400
	ldr r0, _020D5E34 // =_0211286B
	rsbne r7, r7, #0
	ldrb r0, [r0, r5, lsl #2]
	add r0, r8, r0, lsl #2
	str r7, [r0, #0x28]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020D5DC8:
	ldrsh r0, [r4, #2]
	str r0, [r8, #0x28]
	ldrsh r0, [r1]
	str r0, [r8, #0x2c]
	ldrsh r0, [r1, #2]
	str r0, [r8, #0x30]
	ldrsh r0, [r1, #4]
	str r0, [r8, #0x34]
	ldrsh r0, [r1, #6]
	str r0, [r8, #0x38]
	ldrsh r0, [r1, #8]
	str r0, [r8, #0x3c]
	ldrsh r0, [r1, #0xa]
	str r0, [r8, #0x40]
	ldrsh r0, [r1, #0xc]
	str r0, [r8, #0x44]
	ldrsh r0, [r1, #0xe]
	str r0, [r8, #0x48]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020D5E14:
	ldr r0, [r8]
	orr r0, r0, #2
	str r0, [r8]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020D5E24: .word _021474A4
_020D5E28: .word 0x02112868
_020D5E2C: .word 0x02112869
_020D5E30: .word 0x0211286A
_020D5E34: .word 0x0211286B
	arm_func_end getMdlRot_

	arm_func_start getMdlScale_
getMdlScale_: // 0x020D5E38
	stmdb sp!, {r4, lr}
	ldr r1, _020D5E98 // =_021474A4
	ldr ip, [r1]
	ldr r4, [ip, #0xd4]
	ldr r2, [ip]
	ldrh lr, [r4, #6]
	ldrb r1, [r2, #1]
	ldrh r3, [r4, lr]
	add lr, r4, lr
	mla r1, r3, r1, lr
	ldr r1, [r1, #4]
	ldrh r3, [r4, r1]
	add r1, r4, r1
	add r1, r1, #4
	ands lr, r3, #1
	addeq r1, r1, #0xc
	ands lr, r3, #2
	bne _020D5E8C
	ands lr, r3, #8
	addne r1, r1, #4
	addeq r1, r1, #0x10
_020D5E8C:
	ldr ip, [ip, #0xe8]
	blx ip
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D5E98: .word _021474A4
	arm_func_end getMdlScale_

	arm_func_start getMdlTrans_
getMdlTrans_: // 0x020D5E9C
	ldr r1, _020D5F00 // =_021474A4
	ldr r1, [r1]
	ldr ip, [r1, #0xd4]
	ldr r1, [r1]
	ldrh r3, [ip, #6]
	ldrb r1, [r1, #1]
	ldrh r2, [ip, r3]
	add r3, ip, r3
	mla r1, r2, r1, r3
	ldr r2, [r1, #4]
	ldrh r1, [ip, r2]
	add r2, ip, r2
	ands r1, r1, #1
	ldrne r1, [r0]
	orrne r1, r1, #4
	strne r1, [r0]
	bxne lr
	ldr r1, [r2, #4]
	add r2, r2, #4
	str r1, [r0, #0x4c]
	ldr r1, [r2, #4]
	str r1, [r0, #0x50]
	ldr r1, [r2, #8]
	str r1, [r0, #0x54]
	bx lr
	.align 2, 0
_020D5F00: .word _021474A4
	arm_func_end getMdlTrans_

	arm_func_start NNSi_G3dAnmCalcNsBca
NNSi_G3dAnmCalcNsBca: // 0x020D5F04
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r0
	ldr r0, [r1, #8]
	ldr ip, [r1]
	ldrh r1, [r0, #4]
	mov r1, r1, lsl #0xc
	cmp ip, r1
	subge ip, r1, #1
	bge _020D5F34
	cmp ip, #0
	movlt ip, #0
_020D5F34:
	mov r1, r2
	mov r2, ip
	bl getJntSRTAnmResult_
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNSi_G3dAnmCalcNsBca

	arm_func_start NNSi_G3dAnmObjInitNsBca
NNSi_G3dAnmObjInitNsBca: // 0x020D5F48
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldr r0, _020D5FD0 // =NNS_G3dFuncAnmJntNsBcaDefault
	str r4, [r5, #8]
	ldr r0, [r0]
	add r1, r5, #0x1a
	str r0, [r5, #0xc]
	ldrb r2, [r2, #0x17]
	mov r0, #0
	strb r2, [r5, #0x19]
	ldrb r2, [r5, #0x19]
	mov r2, r2, lsl #1
	bl MIi_CpuClear16
	ldrh r0, [r4, #6]
	add r2, r4, #0x14
	mov r3, #0
	cmp r0, #0
	addls sp, sp, #4
	ldmlsia sp!, {r4, r5, pc}
_020D5F9C:
	mov r0, r3, lsl #1
	ldrh r1, [r2, r0]
	add r0, r5, r3, lsl #1
	add r3, r3, #1
	ldr r1, [r4, r1]
	mov r1, r1, lsr #0x18
	orr r1, r1, #0x100
	strh r1, [r0, #0x1a]
	ldrh r0, [r4, #6]
	cmp r3, r0
	blo _020D5F9C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D5FD0: .word NNS_G3dFuncAnmJntNsBcaDefault
	arm_func_end NNSi_G3dAnmObjInitNsBca

	arm_func_start NNSi_G3dAnmCalcNsBma
NNSi_G3dAnmCalcNsBma: // 0x020D5FD4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r7, [r1, #8]
	mov r2, r2, lsl #0x10
	ldrh r4, [r7, #0xe]
	add r5, r7, #8
	ldr r6, [r1]
	ldrh r3, [r5, r4]
	mov r1, r2, lsr #0x10
	add r2, r5, r4
	mul r4, r3, r1
	add r3, r2, #4
	mov r6, r6, asr #0xc
	mov r8, r0
	ldr r1, [r3, r4]
	mov r0, r7
	mov r2, r6
	add r5, r3, r4
	bl GetMatColAnmuAlphaValue_
	mov r4, r0
	ldr r1, [r5, #4]
	mov r0, r7
	mov r2, r6
	bl GetMatColAnmuAlphaValue_
	ldr r1, [r8, #4]
	mov r2, r6
	and r1, r1, #0x8000
	orr r1, r1, r4
	orr r0, r1, r0, lsl #16
	str r0, [r8, #4]
	mov r0, r7
	ldr r1, [r5, #0xc]
	bl GetMatColAnmuAlphaValue_
	mov r4, r0
	mov r0, r7
	ldr r1, [r5, #8]
	mov r2, r6
	bl GetMatColAnmuAlphaValue_
	mov r2, r6
	ldr r1, [r8, #8]
	and r1, r1, #0x8000
	orr r0, r1, r0
	orr r0, r0, r4, lsl #16
	str r0, [r8, #8]
	mov r0, r7
	ldr r1, [r5, #0x10]
	bl GetMatColAnm_
	ldr r1, [r8, #0xc]
	bic r1, r1, #0x1f0000
	orr r0, r1, r0, lsl #16
	str r0, [r8, #0xc]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end NNSi_G3dAnmCalcNsBma

	arm_func_start NNSi_G3dAnmObjInitNsBma
NNSi_G3dAnmObjInitNsBma: // 0x020D60A0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r3, _020D6148 // =NNS_G3dFuncAnmMatNsBmaDefault
	ldr r4, [r2, #8]
	ldr r3, [r3]
	mov r9, r0
	str r3, [r9, #0xc]
	ldrb r0, [r2, #0x18]
	mov r8, r1
	add r4, r2, r4
	strb r0, [r9, #0x19]
	ldrb r2, [r9, #0x19]
	add r1, r9, #0x1a
	mov r0, #0
	mov r2, r2, lsl #1
	bl MIi_CpuClear16
	ldrb r0, [r8, #9]
	mov r7, #0
	cmp r0, #0
	addls sp, sp, #4
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r6, r7
	add r5, r8, #8
	add r4, r4, #4
_020D6100:
	ldrh r1, [r8, #0xe]
	mov r0, r4
	add r2, r5, r1
	ldrh r1, [r2, #2]
	add r1, r2, r1
	add r1, r1, r6
	bl NNS_G3dGetResDictIdxByName
	cmp r0, #0
	orrge r1, r7, #0x100
	addge r0, r9, r0, lsl #1
	strgeh r1, [r0, #0x1a]
	ldrb r0, [r8, #9]
	add r7, r7, #1
	add r6, r6, #0x10
	cmp r7, r0
	blo _020D6100
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020D6148: .word NNS_G3dFuncAnmMatNsBmaDefault
	arm_func_end NNSi_G3dAnmObjInitNsBma

	arm_func_start GetMatColAnm_
GetMatColAnm_: // 0x020D614C
	ands r3, r1, #0x20000000
	movne r0, r1, lsl #0x10
	movne r0, r0, lsr #0x10
	bxne lr
	ldr r3, _020D6238 // =0x0000FFFF
	ands ip, r1, #0xc0000000
	and r3, r1, r3
	add r0, r0, r3
	ldreqb r0, [r0, r2]
	bxeq lr
	ldr r3, _020D623C // =0x1FFF0000
	ands ip, r1, #0x40000000
	and r1, r1, r3
	mov r3, r1, lsr #0x10
	beq _020D61C4
	ands r1, r2, #1
	beq _020D61BC
	cmp r2, r3
	addhi r0, r0, r3, lsr #1
	ldrhib r0, [r0, #1]
	bxhi lr
	add r1, r0, r2, lsr #1
	ldrb r2, [r0, r2, lsr #1]
	ldrb r0, [r1, #1]
	add r0, r2, r0
	mov r0, r0, lsl #0xf
	mov r0, r0, lsr #0x10
	bx lr
_020D61BC:
	ldrb r0, [r0, r2, lsr #1]
	bx lr
_020D61C4:
	ands r1, r2, #3
	beq _020D6230
	cmp r2, r3
	addhi r0, r0, r3, lsr #2
	ldrhib r0, [r1, r0]
	bxhi lr
	ands r1, r2, #1
	beq _020D6214
	ands r1, r2, #2
	movne r1, r2, lsr #2
	addne r2, r1, #1
	moveq r2, r2, lsr #2
	addeq r1, r2, #1
	ldrb r2, [r0, r2]
	ldrb r1, [r0, r1]
	mov r0, #3
	mla r0, r2, r0, r1
	mov r0, r0, lsl #0xe
	mov r0, r0, lsr #0x10
	bx lr
_020D6214:
	add r1, r0, r2, lsr #2
	ldrb r2, [r0, r2, lsr #2]
	ldrb r0, [r1, #1]
	add r0, r2, r0
	mov r0, r0, lsl #0xf
	mov r0, r0, lsr #0x10
	bx lr
_020D6230:
	ldrb r0, [r0, r2, lsr #2]
	bx lr
	.align 2, 0
_020D6238: .word 0x0000FFFF
_020D623C: .word 0x1FFF0000
	arm_func_end GetMatColAnm_

	arm_func_start GetMatColAnmuAlphaValue_
GetMatColAnmuAlphaValue_: // 0x020D6240
	stmdb sp!, {lr}
	sub sp, sp, #4
	ands r3, r1, #0x20000000
	movne r0, r1, lsl #0x10
	addne sp, sp, #4
	movne r0, r0, lsr #0x10
	ldmneia sp!, {pc}
	ldr r3, _020D63C0 // =0x0000FFFF
	ands ip, r1, #0xc0000000
	and r3, r1, r3
	add r0, r0, r3
	moveq r1, r2, lsl #1
	addeq sp, sp, #4
	ldreqh r0, [r0, r1]
	ldmeqia sp!, {pc}
	ldr r3, _020D63C4 // =0x1FFF0000
	ands ip, r1, #0x40000000
	and r1, r1, r3
	mov r3, r1, lsr #0x10
	beq _020D62C8
	ands r1, r2, #1
	beq _020D62B8
	cmp r2, r3
	bichi r1, r3, #1
	addhi r0, r0, r1
	addhi sp, sp, #4
	ldrhih r0, [r0, #2]
	ldmhiia sp!, {pc}
	mov r1, r2, lsr #1
	b _020D6374
_020D62B8:
	bic r1, r2, #1
	add sp, sp, #4
	ldrh r0, [r0, r1]
	ldmia sp!, {pc}
_020D62C8:
	ands r1, r2, #3
	beq _020D6360
	cmp r2, r3
	movhi r2, r3, lsr #2
	movhi r1, r1, lsl #1
	addhi r0, r0, r2, lsl #1
	addhi sp, sp, #4
	ldrhih r0, [r1, r0]
	ldmhiia sp!, {pc}
	ands r1, r2, #1
	beq _020D6358
	ands r1, r2, #2
	movne r1, r2, lsr #2
	addne r2, r1, #1
	moveq r2, r2, lsr #2
	addeq r1, r2, #1
	mov r2, r2, lsl #1
	mov r1, r1, lsl #1
	ldrh ip, [r0, r2]
	ldrh lr, [r0, r1]
	ldr r0, _020D63C8 // =0x00007C1F
	and r3, ip, #0x3e0
	and r2, lr, #0x3e0
	mov r1, #3
	mla r2, r3, r1, r2
	and ip, ip, r0
	and r3, lr, r0
	mla r1, ip, r1, r3
	mov r2, r2, lsr #2
	and r1, r0, r1, lsr #2
	and r0, r2, #0x3e0
	orr r0, r1, r0
	mov r0, r0, lsl #0x10
	add sp, sp, #4
	mov r0, r0, lsr #0x10
	ldmia sp!, {pc}
_020D6358:
	mov r1, r2, lsr #2
	b _020D6374
_020D6360:
	mov r1, r2, lsr #2
	mov r1, r1, lsl #1
	add sp, sp, #4
	ldrh r0, [r0, r1]
	ldmia sp!, {pc}
_020D6374:
	mov r2, r1, lsl #1
	add r1, r0, r1, lsl #1
	ldrh r3, [r0, r2]
	ldrh ip, [r1, #2]
	ldr r0, _020D63C8 // =0x00007C1F
	and r2, r3, #0x3e0
	and r1, ip, #0x3e0
	add r1, r2, r1
	mov r1, r1, lsr #1
	and r3, r3, r0
	and r2, ip, r0
	add r2, r3, r2
	and r2, r0, r2, lsr #1
	and r0, r1, #0x3e0
	orr r0, r2, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020D63C0: .word 0x0000FFFF
_020D63C4: .word 0x1FFF0000
_020D63C8: .word 0x00007C1F
	arm_func_end GetMatColAnmuAlphaValue_

	arm_func_start NNSi_G3dAnmCalcNsBta
NNSi_G3dAnmCalcNsBta: // 0x020D63CC
	stmdb sp!, {r4, lr}
	ldr ip, [r1]
	mov r4, r0
	mov r2, r2, lsl #0x10
	ldr r0, [r1, #8]
	mov r1, r2, lsr #0x10
	mov r3, r4
	mov r2, ip, asr #0xc
	bl GetTexSRTAnm_
	ldr r0, [r4, #0x10]
	bic r0, r0, #0xc0000000
	str r0, [r4, #0x10]
	ldr r0, [r4, #0x10]
	orr r0, r0, #0x40000000
	str r0, [r4, #0x10]
	ldr r0, [r4]
	orr r0, r0, #8
	str r0, [r4]
	ldmia sp!, {r4, pc}
	arm_func_end NNSi_G3dAnmCalcNsBta

	arm_func_start NNSi_G3dAnmObjInitNsBta
NNSi_G3dAnmObjInitNsBta: // 0x020D6418
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r3, _020D64C0 // =NNS_G3dFuncAnmMatNsBtaDefault
	ldr r4, [r2, #8]
	ldr r3, [r3]
	mov r9, r0
	str r3, [r9, #0xc]
	ldrb r0, [r2, #0x18]
	mov r8, r1
	add r4, r2, r4
	strb r0, [r9, #0x19]
	ldrb r2, [r9, #0x19]
	add r1, r9, #0x1a
	mov r0, #0
	mov r2, r2, lsl #1
	bl MIi_CpuClear16
	ldrb r0, [r8, #9]
	mov r7, #0
	cmp r0, #0
	addls sp, sp, #4
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r6, r7
	add r5, r8, #8
	add r4, r4, #4
_020D6478:
	ldrh r1, [r8, #0xe]
	mov r0, r4
	add r2, r5, r1
	ldrh r1, [r2, #2]
	add r1, r2, r1
	add r1, r1, r6
	bl NNS_G3dGetResDictIdxByName
	cmp r0, #0
	orrge r1, r7, #0x100
	addge r0, r9, r0, lsl #1
	strgeh r1, [r0, #0x1a]
	ldrb r0, [r8, #9]
	add r7, r7, #1
	add r6, r6, #0x10
	cmp r7, r0
	blo _020D6478
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020D64C0: .word NNS_G3dFuncAnmMatNsBtaDefault
	arm_func_end NNSi_G3dAnmObjInitNsBta

	arm_func_start GetTexSRTAnm_
GetTexSRTAnm_: // 0x020D64C4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	ldrh r4, [r8, #0xe]
	add r5, r8, #8
	mov r6, r3
	ldrh r3, [r5, r4]
	add r4, r5, r4
	add r4, r4, #4
	mla r5, r3, r1, r4
	mov r7, r2
	ldr r1, [r5, #0x18]
	ldr r2, [r5, #0x1c]
	mov r3, r7
	ldr r4, [r6]
	bl GetTexSRTAnmVectorVal_
	mov r9, r0
	ldr r1, [r5, #0x20]
	mov r0, r8
	ldr r2, [r5, #0x24]
	mov r3, r7
	bl GetTexSRTAnmVectorVal_
	cmp r9, #0
	bne _020D6530
	cmp r0, #0
	orreq r4, r4, #4
	beq _020D653C
_020D6530:
	str r9, [r6, #0x24]
	str r0, [r6, #0x28]
	bic r4, r4, #4
_020D653C:
	ldr r1, [r5, #0x10]
	ldr r2, [r5, #0x14]
	mov r0, r8
	mov r3, r7
	bl GetTexSRTAnmSinCosVal_
	cmp r0, #0x10000000
	strneh r0, [r6, #0x20]
	movne r0, r0, lsr #0x10
	strneh r0, [r6, #0x22]
	orreq r4, r4, #2
	ldr r1, [r5]
	ldr r2, [r5, #4]
	mov r0, r8
	mov r3, r7
	bicne r4, r4, #2
	bl GetTexSRTAnmVectorVal_
	mov r9, r0
	ldr r1, [r5, #8]
	ldr r2, [r5, #0xc]
	mov r0, r8
	mov r3, r7
	bl GetTexSRTAnmVectorVal_
	cmp r9, #0x1000
	bne _020D65A8
	cmp r0, #0x1000
	orreq r4, r4, #1
	beq _020D65B4
_020D65A8:
	str r9, [r6, #0x18]
	str r0, [r6, #0x1c]
	bic r4, r4, #1
_020D65B4:
	str r4, [r6]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end GetTexSRTAnm_

	arm_func_start GetTexSRTAnmSinCosVal_
GetTexSRTAnmSinCosVal_: // 0x020D65C0
	ands ip, r1, #0x20000000
	movne r0, r2
	bxne lr
	add r0, r0, r2
	ands r2, r1, #0xc0000000
	beq _020D668C
	ldr r2, _020D66C8 // =0x0000FFFF
	ands ip, r1, #0x40000000
	and r2, r1, r2
	beq _020D6610
	ands r1, r3, #1
	beq _020D6608
	cmp r3, r2
	movhi r1, r2, lsr #1
	addhi r3, r1, #1
	bhi _020D668C
	mov r2, r3, lsr #1
	b _020D6694
_020D6608:
	mov r3, r3, lsr #1
	b _020D668C
_020D6610:
	ands r1, r3, #3
	beq _020D6688
	cmp r3, r2
	addhi r3, r1, r2, lsr #2
	bhi _020D668C
	ands r1, r3, #1
	beq _020D6680
	ands r1, r3, #2
	movne r1, r3, lsr #2
	addne r2, r1, #1
	moveq r2, r3, lsr #2
	addeq r1, r2, #1
	mov ip, r2, lsl #2
	add r3, r0, r2, lsl #2
	mov r2, r1, lsl #2
	add r1, r0, r1, lsl #2
	ldrsh ip, [r0, ip]
	ldrsh r2, [r0, r2]
	mov r0, #3
	ldrsh r3, [r3, #2]
	ldrsh r1, [r1, #2]
	mla r2, ip, r0, r2
	mla r1, r3, r0, r1
	ldr r0, _020D66C8 // =0x0000FFFF
	mov r1, r1, asr #2
	and r0, r0, r2, asr #2
	orr r0, r0, r1, lsl #16
	bx lr
_020D6680:
	mov r2, r3, lsr #2
	b _020D6694
_020D6688:
	mov r3, r3, lsr #2
_020D668C:
	ldr r0, [r0, r3, lsl #2]
	bx lr
_020D6694:
	add r1, r0, r2, lsl #2
	mov r2, r2, lsl #2
	ldrsh ip, [r0, r2]
	ldrsh r3, [r1, #4]
	ldrsh r2, [r1, #2]
	ldrsh r1, [r1, #6]
	ldr r0, _020D66C8 // =0x0000FFFF
	add r3, ip, r3
	add r1, r2, r1
	and r2, r0, r3, asr #1
	mov r0, r1, asr #1
	orr r0, r2, r0, lsl #16
	bx lr
	.align 2, 0
_020D66C8: .word 0x0000FFFF
	arm_func_end GetTexSRTAnmSinCosVal_

	arm_func_start GetTexSRTAnmVectorVal_
GetTexSRTAnmVectorVal_: // 0x020D66CC
	ands ip, r1, #0x20000000
	movne r0, r2
	bxne lr
	add r0, r0, r2
	ands r2, r1, #0xc0000000
	beq _020D6784
	ldr r2, _020D67C4 // =0x0000FFFF
	ands ip, r1, #0x40000000
	and ip, r1, r2
	beq _020D671C
	ands r2, r3, #1
	beq _020D6714
	cmp r3, ip
	movhi r2, ip, lsr #1
	addhi r3, r2, #1
	bhi _020D6784
	mov r3, r3, lsr #1
	b _020D6798
_020D6714:
	mov r3, r3, lsr #1
	b _020D6784
_020D671C:
	ands r2, r3, #3
	beq _020D6780
	cmp r3, ip
	addhi r3, r2, ip, lsr #2
	bhi _020D6784
	ands r2, r3, #1
	beq _020D6778
	ands r2, r3, #2
	movne r3, r3, lsr #2
	addne r2, r3, #1
	moveq r2, r3, lsr #2
	addeq r3, r2, #1
	ands r1, r1, #0x10000000
	movne r2, r2, lsl #1
	movne r1, r3, lsl #1
	ldrnesh r2, [r0, r2]
	ldrnesh r1, [r0, r1]
	ldreq r2, [r0, r2, lsl #2]
	ldreq r1, [r0, r3, lsl #2]
	mov r0, #3
	mla r0, r2, r0, r1
	mov r0, r0, asr #2
	bx lr
_020D6778:
	mov r3, r3, lsr #2
	b _020D6798
_020D6780:
	mov r3, r3, lsr #2
_020D6784:
	ands r1, r1, #0x10000000
	movne r1, r3, lsl #1
	ldrnesh r0, [r0, r1]
	ldreq r0, [r0, r3, lsl #2]
	bx lr
_020D6798:
	ands r1, r1, #0x10000000
	movne r2, r3, lsl #1
	addne r1, r0, r3, lsl #1
	ldrnesh r2, [r0, r2]
	ldrnesh r0, [r1, #2]
	addeq r1, r0, r3, lsl #2
	ldreq r2, [r0, r3, lsl #2]
	ldreq r0, [r1, #4]
	add r0, r2, r0
	mov r0, r0, asr #1
	bx lr
	.align 2, 0
_020D67C4: .word 0x0000FFFF
	arm_func_end GetTexSRTAnmVectorVal_

	arm_func_start NNSi_G3dAnmCalcNsBtp
NNSi_G3dAnmCalcNsBtp: // 0x020D67C8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r1
	ldr r3, [r6]
	ldr r5, [r6, #8]
	mov r1, r2, lsl #0x10
	mov r2, r3, lsl #4
	mov r7, r0
	mov r0, r5
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	bl NNSi_G3dGetTexPatAnmFV
	mov r4, r0
	ldrb r1, [r4, #2]
	mov r0, r5
	bl NNSi_G3dGetTexPatAnmTexNameByIdx
	mov r1, r0
	ldr r0, [r6, #0x14]
	mov r2, r7
	bl SetTexParamaters_
	ldrb r1, [r4, #3]
	cmp r1, #0xff
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r5
	bl NNSi_G3dGetTexPatAnmPlttNameByIdx
	mov r1, r0
	ldr r0, [r6, #0x14]
	mov r2, r7
	bl SetPlttParamaters_
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end NNSi_G3dAnmCalcNsBtp

	arm_func_start SetPlttParamaters_
SetPlttParamaters_: // 0x020D6848
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldrh r0, [r5, #0x34]
	mov r4, r2
	add r0, r5, r0
	bl NNS_G3dGetResDataByName
	ldr r1, [r5, #0x2c]
	ldrh r2, [r0, #2]
	mov r1, r1, lsl #0x10
	mov r3, r1, lsr #0x10
	ands r1, r2, #1
	ldrh r0, [r0]
	moveq r1, r3, lsl #0xf
	moveq r3, r1, lsr #0x10
	moveq r0, r0, lsl #0xf
	moveq r0, r0, lsr #0x10
	add r0, r0, r3
	str r0, [r4, #0x14]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end SetPlttParamaters_

	arm_func_start SetTexParamaters_
SetTexParamaters_: // 0x020D689C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	add r0, r5, #0x3c
	mov r4, r2
	bl NNS_G3dGetResDataByName
	ldr r1, [r0]
	ldr r3, [r4, #0x10]
	and r1, r1, #0x1c000000
	cmp r1, #0x14000000
	ldrne r2, [r5, #8]
	ldrne r1, _020D6974 // =0x0000FFFF
	andne r5, r2, r1
	ldreq r2, [r5, #0x18]
	ldreq r1, _020D6974 // =0x0000FFFF
	andeq r5, r2, r1
	ldr r1, _020D6978 // =0xC00F0000
	ldr r2, _020D697C // =0x000007FF
	and r1, r3, r1
	str r1, [r4, #0x10]
	ldr r1, [r0]
	ldr r3, [r4, #0x10]
	add r1, r1, r5
	orr r1, r3, r1
	str r1, [r4, #0x10]
	ldr r3, [r0, #4]
	ldr r1, _020D6980 // =0x003FF800
	and r3, r3, r2
	strh r3, [r4, #0x2c]
	ldr r3, [r0, #4]
	and r1, r3, r1
	mov r1, r1, lsr #0xb
	strh r1, [r4, #0x2e]
	ldr r3, [r0, #4]
	ldrh r1, [r4, #0x2c]
	and r0, r3, r2
	and r5, r2, r3, lsr #11
	cmp r0, r1
	moveq r0, #0x1000
	beq _020D6948
	mov r0, r0, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Div
_020D6948:
	str r0, [r4, #0x30]
	ldrh r1, [r4, #0x2e]
	cmp r5, r1
	moveq r0, #0x1000
	beq _020D6968
	mov r0, r5, lsl #0xc
	mov r1, r1, lsl #0xc
	bl FX_Div
_020D6968:
	str r0, [r4, #0x34]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020D6974: .word 0x0000FFFF
_020D6978: .word 0xC00F0000
_020D697C: .word 0x000007FF
_020D6980: .word 0x003FF800
	arm_func_end SetTexParamaters_

	arm_func_start NNSi_G3dAnmObjInitNsBtp
NNSi_G3dAnmObjInitNsBtp: // 0x020D6984
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r3, _020D6A30 // =NNS_G3dFuncAnmMatNsBtpDefault
	ldr r4, [r2, #8]
	ldr r3, [r3]
	mov r9, r0
	str r3, [r9, #0xc]
	ldrb r0, [r2, #0x18]
	mov r8, r1
	add r4, r2, r4
	strb r0, [r9, #0x19]
	str r8, [r9, #8]
	ldrb r2, [r9, #0x19]
	add r1, r9, #0x1a
	mov r0, #0
	mov r2, r2, lsl #1
	bl MIi_CpuClear16
	ldrb r0, [r8, #0xd]
	mov r7, #0
	cmp r0, #0
	addls sp, sp, #4
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r6, r7
	add r5, r8, #0xc
	add r4, r4, #4
_020D69E8:
	ldrh r1, [r8, #0x12]
	mov r0, r4
	add r2, r5, r1
	ldrh r1, [r2, #2]
	add r1, r2, r1
	add r1, r1, r6
	bl NNS_G3dGetResDictIdxByName
	cmp r0, #0
	orrge r1, r7, #0x100
	addge r0, r9, r0, lsl #1
	strgeh r1, [r0, #0x1a]
	ldrb r0, [r8, #0xd]
	add r7, r7, #1
	add r6, r6, #0x10
	cmp r7, r0
	blo _020D69E8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020D6A30: .word NNS_G3dFuncAnmMatNsBtpDefault
	arm_func_end NNSi_G3dAnmObjInitNsBtp

	arm_func_start NNSi_G3dAnmCalcNsBva
NNSi_G3dAnmCalcNsBva: // 0x020D6A34
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr lr, [r1, #8]
	ldr r3, [r1]
	ldrh r1, [lr, #6]
	mov ip, r3, asr #0xc
	mov r3, #1
	mla r2, ip, r1, r2
	mov r1, r2, lsr #5
	add r1, lr, r1, lsl #2
	ldr r1, [r1, #0xc]
	and r2, r2, #0x1f
	and r1, r1, r3, lsl r2
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end NNSi_G3dAnmCalcNsBva

	arm_func_start NNSi_G3dAnmObjInitNsBva
NNSi_G3dAnmObjInitNsBva: // 0x020D6A74
	ldr r3, _020D6ABC // =NNS_G3dFuncAnmVisNsBvaDefault
	mov ip, #0
	ldr r3, [r3]
	str r3, [r0, #0xc]
	ldrb r2, [r2, #0x17]
	strb r2, [r0, #0x19]
	str r1, [r0, #8]
	ldrb r1, [r0, #0x19]
	cmp r1, #0
	bxls lr
_020D6A9C:
	orr r2, ip, #0x100
	add r1, r0, ip, lsl #1
	strh r2, [r1, #0x1a]
	ldrb r1, [r0, #0x19]
	add ip, ip, #1
	cmp ip, r1
	blo _020D6A9C
	bx lr
	.align 2, 0
_020D6ABC: .word NNS_G3dFuncAnmVisNsBvaDefault
	arm_func_end NNSi_G3dAnmObjInitNsBva

	arm_func_start NNSi_G3dSendJointSRTBasic
NNSi_G3dSendJointSRTBasic: // 0x020D6AC0
	ands r2, r3, #4
	ldrne r1, [r0]
	orrne r1, r1, #1
	strne r1, [r0]
	bne _020D6AEC
	ldr r2, [r1]
	str r2, [r0, #4]
	ldr r2, [r1, #4]
	str r2, [r0, #8]
	ldr r1, [r1, #8]
	str r1, [r0, #0xc]
_020D6AEC:
	ldr r1, [r0]
	orr r1, r1, #0x18
	str r1, [r0]
	bx lr
	arm_func_end NNSi_G3dSendJointSRTBasic

	arm_func_start NNSi_G3dGetJointScaleBasic
NNSi_G3dGetJointScaleBasic: // 0x020D6AFC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4]
	ands r0, r1, #4
	bne _020D6B40
	ands r0, r1, #2
	bne _020D6B2C
	add r1, r4, #0x28
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	b _020D6B58
_020D6B2C:
	add r1, r4, #0x4c
	mov r0, #0x1c
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	b _020D6B58
_020D6B40:
	ands r0, r1, #2
	bne _020D6B58
	add r1, r4, #0x28
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
_020D6B58:
	ldr r0, [r4]
	ands r0, r0, #1
	ldmneia sp!, {r4, pc}
	add r1, r4, #4
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	ldmia sp!, {r4, pc}
	arm_func_end NNSi_G3dGetJointScaleBasic

	arm_func_start NNSi_G3dSendTexSRTMaya
NNSi_G3dSendTexSRTMaya: // 0x020D6B78
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x50
	mov r4, r0
	ldr r0, [r4]
	mov r1, #0
	ands r0, r0, #8
	ldrne r0, _020D6CB4 // =0x00101610
	mov r3, #3
	strne r0, [sp]
	ldreq r0, _020D6CB8 // =0x00101810
	mov r2, #2
	streq r0, [sp]
	mov r0, #0x1000
	str r0, [sp, #0x44]
	str r3, [sp, #4]
	str r2, [sp, #0x48]
	str r1, [sp, #0x40]
	str r1, [sp, #0x34]
	str r1, [sp, #0x30]
	str r1, [sp, #0x2c]
	str r1, [sp, #0x28]
	str r1, [sp, #0x24]
	str r1, [sp, #0x20]
	str r1, [sp, #0x14]
	str r1, [sp, #0x10]
	ldr r1, [r4]
	ldr r0, _020D6CBC // =_0211F63C
	and r1, r1, #7
	ldr r2, [r0, r1, lsl #2]
	add r0, sp, #8
	mov r1, r4
	blx r2
	ldr r3, [r4, #0x30]
	cmp r3, #0x1000
	beq _020D6C48
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	smull r2, r0, r3, r0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp, #8]
	ldr r2, [r4, #0x30]
	ldr r0, [sp, #0x38]
	smull r3, r1, r2, r1
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [sp, #0xc]
	ldr r1, [r4, #0x30]
	smull r2, r0, r1, r0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x38]
_020D6C48:
	ldr r3, [r4, #0x34]
	cmp r3, #0x1000
	beq _020D6C98
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	smull r2, r0, r3, r0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp, #0x18]
	ldr r2, [r4, #0x34]
	ldr r0, [sp, #0x3c]
	smull r3, r1, r2, r1
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [sp, #0x1c]
	ldr r1, [r4, #0x34]
	smull r2, r0, r1, r0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x3c]
_020D6C98:
	add r1, sp, #0
	ldr r0, [sp]
	add r1, r1, #4
	mov r2, #0x12
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x50
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D6CB4: .word 0x00101610
_020D6CB8: .word 0x00101810
_020D6CBC: .word 0x0211F63C
	arm_func_end NNSi_G3dSendTexSRTMaya

	arm_func_start texmtxCalc_flagTRS_Maya
texmtxCalc_flagTRS_Maya: // 0x020D6CC0
	mov r2, #0x1000
	str r2, [r0]
	mov r1, #0
	str r1, [r0, #4]
	str r1, [r0, #0x10]
	str r2, [r0, #0x14]
	str r1, [r0, #0x30]
	str r1, [r0, #0x34]
	bx lr
	arm_func_end texmtxCalc_flagTRS_Maya

	arm_func_start texmtxCalc_flagTR_Maya
texmtxCalc_flagTR_Maya: // 0x020D6CE4
	ldr r2, [r1, #0x18]
	mov ip, #0
	str r2, [r0]
	ldr r2, [r1, #0x1c]
	str r2, [r0, #0x14]
	str ip, [r0, #4]
	str ip, [r0, #0x30]
	ldr r2, [r1, #0x1c]
	ldrh r3, [r1, #0x2e]
	mov r1, r2, lsl #1
	rsb r1, r1, #0
	add r1, r1, #0x2000
	mul r1, r3, r1
	mov r1, r1, lsl #3
	str r1, [r0, #0x34]
	str ip, [r0, #0x10]
	bx lr
	arm_func_end texmtxCalc_flagTR_Maya

	arm_func_start texmtxCalc_flagTS_Maya
texmtxCalc_flagTS_Maya: // 0x020D6D28
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r1
	ldrh r2, [r5, #0x2c]
	ldrh r1, [r5, #0x2e]
	mov r6, r0
	mov r4, r2, lsl #0xc
	mov r7, r1, lsl #0xc
	mov r0, r7
	mov r1, r4
	bl FX_DivAsync
	ldrsh r0, [r5, #0x22]
	str r0, [r6]
	ldrsh r0, [r5, #0x22]
	str r0, [r6, #0x14]
	bl FX_GetDivResult
	ldrsh r2, [r5, #0x20]
	mov r1, r7
	rsb r2, r2, #0
	mul r0, r2, r0
	mov r2, r0, asr #0xc
	mov r0, r4
	str r2, [r6, #4]
	bl FX_DivAsync
	ldrsh r1, [r5, #0x20]
	ldrsh r0, [r5, #0x22]
	ldrh r2, [r5, #0x2c]
	add r0, r1, r0
	rsb r0, r0, #0
	add r0, r0, #0x1000
	mul r0, r2, r0
	mov r0, r0, lsl #3
	str r0, [r6, #0x30]
	ldrsh r1, [r5, #0x20]
	ldrsh r0, [r5, #0x22]
	ldrh r2, [r5, #0x2e]
	sub r0, r1, r0
	add r0, r0, #0x1000
	mul r0, r2, r0
	mov r0, r0, lsl #3
	str r0, [r6, #0x34]
	bl FX_GetDivResult
	ldrsh r1, [r5, #0x20]
	mul r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r6, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end texmtxCalc_flagTS_Maya

	arm_func_start texmtxCalc_flagT_Maya
texmtxCalc_flagT_Maya: // 0x020D6DE8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r1
	ldrh r2, [r9, #0x2c]
	ldrh r1, [r9, #0x2e]
	mov r10, r0
	mov r8, r2, lsl #0xc
	mov r11, r1, lsl #0xc
	mov r0, r11
	mov r1, r8
	bl FX_DivAsync
	ldrsh r5, [r9, #0x22]
	ldr r3, [r9, #0x18]
	ldrsh r0, [r9, #0x20]
	ldr r4, [r9, #0x1c]
	smull r2, r1, r3, r5
	mov r6, r2, lsr #0xc
	orr r6, r6, r1, lsl #20
	smull r2, r1, r3, r0
	mov r7, r2, lsr #0xc
	orr r7, r7, r1, lsl #20
	smull r3, r2, r4, r0
	smull r1, r0, r4, r5
	mov r5, r3, lsr #0xc
	orr r5, r5, r2, lsl #20
	mov r4, r1, lsr #0xc
	orr r4, r4, r0, lsl #20
	str r6, [r10]
	str r4, [r10, #0x14]
	bl FX_GetDivResult
	mov r1, r11
	rsb r2, r5, #0
	mul r0, r2, r0
	mov r0, r0, asr #0xc
	str r0, [r10, #4]
	mov r0, r8
	bl FX_DivAsync
	sub r1, r5, r4
	add r0, r7, r6
	ldrh r3, [r9, #0x2c]
	ldr r2, [r9, #0x18]
	sub r0, r2, r0
	mul r0, r3, r0
	mov r0, r0, lsl #3
	str r0, [r10, #0x30]
	ldrh r2, [r9, #0x2e]
	ldr r0, [r9, #0x1c]
	sub r0, r1, r0
	add r0, r0, #0x2000
	mul r0, r2, r0
	mov r0, r0, lsl #3
	str r0, [r10, #0x34]
	bl FX_GetDivResult
	mul r0, r7, r0
	mov r0, r0, asr #0xc
	str r0, [r10, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end texmtxCalc_flagT_Maya

	arm_func_start texmtxCalc_flagRS_Maya
texmtxCalc_flagRS_Maya: // 0x020D6ED0
	mov r2, #0x1000
	str r2, [r0]
	str r2, [r0, #0x14]
	mov ip, #0
	str ip, [r0, #4]
	ldrh r2, [r1, #0x2c]
	ldr r3, [r1, #0x24]
	mul r2, r3, r2
	rsb r2, r2, #0
	mov r2, r2, lsl #4
	str r2, [r0, #0x30]
	ldrh r2, [r1, #0x2e]
	ldr r1, [r1, #0x28]
	mul r2, r1, r2
	mov r1, r2, lsl #4
	str r1, [r0, #0x34]
	str ip, [r0, #0x10]
	bx lr
	arm_func_end texmtxCalc_flagRS_Maya

	arm_func_start texmtxCalc_flagR_Maya
texmtxCalc_flagR_Maya: // 0x020D6F18
	stmdb sp!, {r4, lr}
	ldr r3, [r1, #0x18]
	mov r2, #0
	str r3, [r0]
	ldr r3, [r1, #0x1c]
	str r3, [r0, #0x14]
	str r2, [r0, #4]
	ldr r4, [r1, #0x18]
	ldr r3, [r1, #0x24]
	ldrh lr, [r1, #0x2c]
	smull ip, r3, r4, r3
	mov r4, ip, lsr #8
	orr r4, r4, r3, lsl #24
	rsb r3, r4, #0
	mul r3, lr, r3
	str r3, [r0, #0x30]
	ldr r4, [r1, #0x1c]
	ldr ip, [r1, #0x28]
	mov r3, r4, lsl #1
	smull lr, ip, r4, ip
	rsb r4, r3, #0
	mov r3, lr, lsr #8
	ldrh lr, [r1, #0x2e]
	add r1, r4, #0x2000
	orr r3, r3, ip, lsl #24
	mul r4, lr, r1
	mul r1, lr, r3
	add r1, r1, r4, lsl #3
	str r1, [r0, #0x34]
	str r2, [r0, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end texmtxCalc_flagR_Maya

	arm_func_start texmtxCalc_flagS_Maya
texmtxCalc_flagS_Maya: // 0x020D6F94
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r1
	ldrh r2, [r5, #0x2c]
	ldrh r1, [r5, #0x2e]
	mov r6, r0
	mov r4, r2, lsl #0xc
	mov r7, r1, lsl #0xc
	mov r0, r7
	mov r1, r4
	bl FX_DivAsync
	ldrsh r0, [r5, #0x22]
	str r0, [r6]
	ldrsh r0, [r5, #0x22]
	str r0, [r6, #0x14]
	bl FX_GetDivResult
	ldrsh r2, [r5, #0x20]
	mov r1, r7
	rsb r2, r2, #0
	mul r0, r2, r0
	mov r2, r0, asr #0xc
	mov r0, r4
	str r2, [r6, #4]
	bl FX_DivAsync
	ldrsh r2, [r5, #0x20]
	ldrsh r1, [r5, #0x22]
	ldrh r3, [r5, #0x2c]
	ldr r0, [r5, #0x24]
	add r1, r2, r1
	rsb r1, r1, #0
	add r1, r1, #0x1000
	mul r2, r3, r1
	mul r1, r0, r3
	mov r0, r2, lsl #3
	sub r0, r0, r1, lsl #4
	str r0, [r6, #0x30]
	ldrsh r2, [r5, #0x20]
	ldrsh r1, [r5, #0x22]
	ldrh r3, [r5, #0x2e]
	ldr r0, [r5, #0x28]
	sub r1, r2, r1
	add r1, r1, #0x1000
	mul r2, r3, r1
	mul r1, r0, r3
	mov r0, r2, lsl #3
	add r0, r0, r1, lsl #4
	str r0, [r6, #0x34]
	bl FX_GetDivResult
	ldrsh r1, [r5, #0x20]
	mul r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r6, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end texmtxCalc_flagS_Maya

	arm_func_start texmtxCalc_flag_Maya
texmtxCalc_flag_Maya: // 0x020D706C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r1
	ldrh r2, [r9, #0x2c]
	ldrh r1, [r9, #0x2e]
	mov r10, r0
	mov r8, r2, lsl #0xc
	mov r11, r1, lsl #0xc
	mov r0, r11
	mov r1, r8
	bl FX_DivAsync
	ldrsh r5, [r9, #0x22]
	ldr r3, [r9, #0x18]
	ldrsh r0, [r9, #0x20]
	ldr r4, [r9, #0x1c]
	smull r2, r1, r3, r5
	mov r6, r2, lsr #0xc
	orr r6, r6, r1, lsl #20
	smull r2, r1, r3, r0
	mov r7, r2, lsr #0xc
	orr r7, r7, r1, lsl #20
	smull r3, r2, r4, r0
	smull r1, r0, r4, r5
	mov r5, r3, lsr #0xc
	orr r5, r5, r2, lsl #20
	mov r4, r1, lsr #0xc
	orr r4, r4, r0, lsl #20
	str r6, [r10]
	str r4, [r10, #0x14]
	bl FX_GetDivResult
	mov r1, r11
	rsb r2, r5, #0
	mul r0, r2, r0
	mov r0, r0, asr #0xc
	str r0, [r10, #4]
	mov r0, r8
	bl FX_DivAsync
	sub r1, r5, r4
	add r2, r7, r6
	ldr r5, [r9, #0x18]
	ldrh r0, [r9, #0x2c]
	sub r3, r5, r2
	ldr r2, [r9, #0x24]
	mul r4, r0, r3
	smull r3, r2, r5, r2
	mov r4, r4, lsl #3
	mov r3, r3, lsr #8
	orr r3, r3, r2, lsl #24
	mul r2, r0, r3
	sub r0, r4, r2
	str r0, [r10, #0x30]
	ldr r4, [r9, #0x1c]
	ldrh r3, [r9, #0x2e]
	sub r0, r1, r4
	add r0, r0, #0x2000
	mul r2, r3, r0
	ldr r0, [r9, #0x28]
	smull r1, r0, r4, r0
	mov r1, r1, lsr #8
	orr r1, r1, r0, lsl #24
	mul r0, r3, r1
	add r0, r0, r2, lsl #3
	str r0, [r10, #0x34]
	bl FX_GetDivResult
	mul r0, r7, r0
	mov r0, r0, asr #0xc
	str r0, [r10, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end texmtxCalc_flag_Maya

	arm_func_start NNSi_G3dSendJointSRTMaya
NNSi_G3dSendJointSRTMaya: // 0x020D7180
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov ip, r0
	ands r0, r3, #4
	ldrb r3, [r2, #3]
	beq _020D71D4
	ldr r1, [ip]
	ands r0, r3, #2
	orr r0, r1, #1
	str r0, [ip]
	beq _020D724C
	ldr r0, _020D72C0 // =_021474A4
	ldrb r7, [r2, #1]
	ldr r0, [r0]
	mov r1, #1
	add r6, r0, #0xc4
	mov r5, r7, lsr #5
	ldr r4, [r6, r5, lsl #2]
	and r0, r7, #0x1f
	orr r0, r4, r1, lsl r0
	str r0, [r6, r5, lsl #2]
	b _020D724C
_020D71D4:
	ldr r4, [r1]
	ands r0, r3, #2
	str r4, [ip, #4]
	ldr r0, [r1, #4]
	str r0, [ip, #8]
	ldr r0, [r1, #8]
	str r0, [ip, #0xc]
	beq _020D724C
	ldr lr, _020D72C0 // =_021474A4
	ldrb r0, [r2, #1]
	ldr r4, [lr]
	mov lr, #0x18
	add r8, r4, #0xc4
	mov r7, r0, lsr #5
	and r4, r0, #0x1f
	mov r5, #1
	mvn r4, r5, lsl r4
	ldr r6, [r8, r7, lsl #2]
	mul r5, r0, lr
	and r0, r6, r4
	str r0, [r8, r7, lsl #2]
	ldr r4, [r1, #0xc]
	ldr r0, _020D72C4 // =0x021482B4
	ldr lr, _020D72C8 // =0x021482B8
	str r4, [r0, r5]
	ldr r4, [r1, #0x10]
	ldr r0, _020D72CC // =0x021482BC
	str r4, [lr, r5]
	ldr r1, [r1, #0x14]
	str r1, [r0, r5]
_020D724C:
	ands r0, r3, #1
	beq _020D72B0
	ldrb r0, [r2, #2]
	ldr r2, [ip]
	ldr r1, _020D72C0 // =_021474A4
	orr r2, r2, #0x20
	str r2, [ip]
	ldr r2, [r1]
	mov r1, r0, lsr #5
	add r1, r2, r1, lsl #2
	and r2, r0, #0x1f
	mov r3, #1
	mov r2, r3, lsl r2
	ldr r1, [r1, #0xc4]
	ands r1, r2, r1
	ldrne r0, [ip]
	orrne r0, r0, #8
	strne r0, [ip]
	bne _020D72B0
	ldr r2, _020D72C4 // =0x021482B4
	mov r1, #0x18
	mla r1, r0, r1, r2
	add r3, ip, #0x10
	ldmia r1, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
_020D72B0:
	ldr r0, [ip]
	orr r0, r0, #0x10
	str r0, [ip]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020D72C0: .word _021474A4
_020D72C4: .word 0x021482B4
_020D72C8: .word 0x021482B8
_020D72CC: .word 0x021482BC
	arm_func_end NNSi_G3dSendJointSRTMaya

	arm_func_start NNSi_G3dGetJointScaleMaya
NNSi_G3dGetJointScaleMaya: // 0x020D72D0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r1, [r5]
	mov r4, #0
	ands r0, r1, #4
	moveq r4, #1
	ands r0, r1, #0x20
	beq _020D7328
	ands r0, r1, #8
	bne _020D7328
	cmp r4, #0
	beq _020D7318
	add r1, r5, #0x4c
	mov r0, #0x1c
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	mov r4, #0
_020D7318:
	add r1, r5, #0x10
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
_020D7328:
	ldr r0, [r5]
	ands r0, r0, #2
	bne _020D7364
	cmp r4, #0
	beq _020D7350
	add r1, r5, #0x28
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	b _020D737C
_020D7350:
	add r1, r5, #0x28
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	b _020D737C
_020D7364:
	cmp r4, #0
	beq _020D737C
	add r1, r5, #0x4c
	mov r0, #0x1c
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
_020D737C:
	ldr r0, [r5]
	ands r0, r0, #1
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	add r1, r5, #4
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end NNSi_G3dGetJointScaleMaya

	arm_func_start NNSi_G3dSendTexSRTSi3d
NNSi_G3dSendTexSRTSi3d: // 0x020D73A4
	stmdb sp!, {lr}
	sub sp, sp, #0x3c
	ldr r1, [r0]
	mov r3, #0
	ands r1, r1, #8
	ldrne r1, _020D7560 // =0x00101710
	mov r2, #3
	strne r1, [sp]
	ldreq r1, _020D7564 // =0x00101910
	str r3, [sp, #0x34]
	streq r1, [sp]
	mov r1, #2
	str r1, [sp, #0x38]
	str r3, [sp, #0x28]
	str r3, [sp, #0x24]
	str r3, [sp, #0x20]
	str r3, [sp, #0x1c]
	str r3, [sp, #0x14]
	str r3, [sp, #0x10]
	str r3, [sp, #0xc]
	str r2, [sp, #4]
	ldr r2, [r0]
	ands r1, r2, #4
	beq _020D7434
	str r3, [sp, #0x2c]
	str r3, [sp, #0x30]
	ldr r1, [r0]
	ands r1, r1, #1
	movne r1, #0x1000
	strne r1, [sp, #8]
	strne r1, [sp, #0x18]
	ldreq r1, [r0, #0x18]
	streq r1, [sp, #8]
	ldreq r1, [r0, #0x1c]
	streq r1, [sp, #0x18]
	b _020D74D4
_020D7434:
	ands r1, r2, #1
	beq _020D747C
	ldr r2, [r0, #0x24]
	ldrh r1, [r0, #0x2c]
	mov r2, r2, lsl #4
	rsb r2, r2, #0
	mul r1, r2, r1
	str r1, [sp, #0x2c]
	ldr r2, [r0, #0x28]
	ldrh r1, [r0, #0x2e]
	mov r2, r2, lsl #4
	rsb r2, r2, #0
	mul r3, r2, r1
	mov r1, #0x1000
	str r3, [sp, #0x30]
	str r1, [sp, #8]
	str r1, [sp, #0x18]
	b _020D74D4
_020D747C:
	ldr r2, [r0, #0x18]
	ldr r1, [r0, #0x24]
	ldrh ip, [r0, #0x2c]
	smull r3, r1, r2, r1
	mov r2, r3, lsr #8
	orr r2, r2, r1, lsl #24
	rsb r1, r2, #0
	mul r1, ip, r1
	str r1, [sp, #0x2c]
	ldr r2, [r0, #0x1c]
	ldr r1, [r0, #0x28]
	ldrh ip, [r0, #0x2e]
	smull r3, r1, r2, r1
	mov r2, r3, lsr #8
	orr r2, r2, r1, lsl #24
	rsb r1, r2, #0
	mul r1, ip, r1
	str r1, [sp, #0x30]
	ldr r1, [r0, #0x18]
	str r1, [sp, #8]
	ldr r1, [r0, #0x1c]
	str r1, [sp, #0x18]
_020D74D4:
	ldr ip, [r0, #0x30]
	cmp ip, #0x1000
	beq _020D750C
	ldr r2, [sp, #8]
	ldr r1, [sp, #0x2c]
	smull r3, r2, ip, r2
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [sp, #8]
	ldr r2, [r0, #0x30]
	smull r3, r1, r2, r1
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [sp, #0x2c]
_020D750C:
	ldr ip, [r0, #0x34]
	cmp ip, #0x1000
	beq _020D7544
	ldr r2, [sp, #0x18]
	ldr r1, [sp, #0x30]
	smull r3, r2, ip, r2
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [sp, #0x18]
	ldr r0, [r0, #0x34]
	smull r2, r1, r0, r1
	mov r0, r2, lsr #0xc
	orr r0, r0, r1, lsl #20
	str r0, [sp, #0x30]
_020D7544:
	add r1, sp, #0
	ldr r0, [sp]
	add r1, r1, #4
	mov r2, #0xe
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x3c
	ldmia sp!, {pc}
	.align 2, 0
_020D7560: .word 0x00101710
_020D7564: .word 0x00101910
	arm_func_end NNSi_G3dSendTexSRTSi3d

	arm_func_start NNSi_G3dSendJointSRTSi3d
NNSi_G3dSendJointSRTSi3d: // 0x020D7568
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r5, r0
	ands r0, r3, #4
	ldrb r4, [r2, #1]
	ldrb r0, [r2, #2]
	beq _020D7608
	ldr r2, [r5]
	ldr r1, _020D7774 // =_021474A4
	orr r2, r2, #1
	str r2, [r5]
	ldr r3, [r1]
	mov r1, r0, lsr #5
	add r1, r3, r1, lsl #2
	and r2, r0, #0x1f
	mov r6, #1
	mov r2, r6, lsl r2
	ldr r1, [r1, #0xc4]
	ands r1, r2, r1
	beq _020D75DC
	add r3, r3, #0xc4
	mov r2, r4, lsr #5
	ldr r1, [r3, r2, lsl #2]
	and r0, r4, #0x1f
	orr r0, r1, r6, lsl r0
	str r0, [r3, r2, lsl #2]
	ldr r0, [r5]
	orr r0, r0, #0x18
	str r0, [r5]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020D75DC:
	ldr r1, _020D7778 // =0x021482A8
	mov r2, #0x18
	mla r6, r0, r2, r1
	mla r1, r4, r2, r1
	mov r0, r6
	bl MIi_CpuCopy32
	mov r0, r6
	add r1, r5, #0x10
	mov r2, #0x18
	bl MIi_CpuCopy32
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020D7608:
	ldr r3, [r1]
	ldr r2, _020D7774 // =_021474A4
	str r3, [r5, #4]
	ldr r3, [r1, #4]
	mov r7, r0, lsr #5
	str r3, [r5, #8]
	ldr r3, [r1, #8]
	and r8, r0, #0x1f
	str r3, [r5, #0xc]
	ldr r6, [r2]
	mov r3, #1
	add r2, r6, r7, lsl #2
	mov r7, r3, lsl r8
	ldr r2, [r2, #0xc4]
	ands r2, r7, r2
	beq _020D7694
	ldr r3, _020D7778 // =0x021482A8
	mov r2, #0x18
	mov r0, r1
	mla r1, r4, r2, r3
	bl MIi_CpuCopy32
	ldr r0, _020D7774 // =_021474A4
	mov r2, r4, lsr #5
	ldr r1, [r0]
	and r0, r4, #0x1f
	add r3, r1, #0xc4
	mov r1, #1
	mvn r0, r1, lsl r0
	ldr r1, [r3, r2, lsl #2]
	and r0, r1, r0
	str r0, [r3, r2, lsl #2]
	ldr r0, [r5]
	orr r0, r0, #0x18
	str r0, [r5]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020D7694:
	mov r2, #0x18
	mul ip, r0, r2
	and r7, r4, #0x1f
	ldr r0, _020D7778 // =0x021482A8
	add r6, r6, #0xc4
	mov lr, r4, lsr #5
	mvn r7, r3, lsl r7
	ldr r8, [r6, lr, lsl #2]
	mul r3, r4, r2
	and r4, r8, r7
	str r4, [r6, lr, lsl #2]
	ldr r7, [r1]
	ldr r4, [r0, ip]
	ldr r6, _020D777C // =0x021482AC
	smull r8, r4, r7, r4
	mov r7, r8, lsr #0xc
	orr r7, r7, r4, lsl #20
	str r7, [r0, r3]
	ldr r8, [r1, #4]
	ldr r4, [r6, ip]
	ldr r7, _020D7780 // =0x021482B0
	smull lr, r4, r8, r4
	mov r8, lr, lsr #0xc
	orr r8, r8, r4, lsl #20
	str r8, [r6, r3]
	ldr r8, [r1, #8]
	ldr r4, [r7, ip]
	ldr r6, _020D7784 // =0x021482B4
	smull lr, r4, r8, r4
	mov r8, lr, lsr #0xc
	orr r8, r8, r4, lsl #20
	str r8, [r7, r3]
	ldr r7, [r1, #0xc]
	ldr r4, [r6, ip]
	ldr lr, _020D7788 // =0x021482B8
	smull r8, r4, r7, r4
	mov r7, r8, lsr #0xc
	orr r7, r7, r4, lsl #20
	str r7, [r6, r3]
	ldr r7, [r1, #0x10]
	ldr r4, [lr, ip]
	ldr r6, _020D778C // =0x021482BC
	smull r8, r4, r7, r4
	add r0, r0, ip
	mov r7, r8, lsr #0xc
	orr r7, r7, r4, lsl #20
	str r7, [lr, r3]
	ldr lr, [r1, #0x14]
	ldr r4, [r6, ip]
	add r1, r5, #0x10
	smull r5, r4, lr, r4
	mov r5, r5, lsr #0xc
	orr r5, r5, r4, lsl #20
	str r5, [r6, r3]
	bl MIi_CpuCopy32
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020D7774: .word _021474A4
_020D7778: .word 0x021482A8
_020D777C: .word 0x021482AC
_020D7780: .word 0x021482B0
_020D7784: .word 0x021482B4
_020D7788: .word 0x021482B8
_020D778C: .word 0x021482BC
	arm_func_end NNSi_G3dSendJointSRTSi3d

	arm_func_start NNSi_G3dGetJointScaleSi3d
NNSi_G3dGetJointScaleSi3d: // 0x020D7790
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r6, r0
	ldr r0, [r6]
	mov r5, #0
	ands r4, r0, #0x18
	bne _020D77BC
	add r1, r6, #0x1c
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
_020D77BC:
	ldr r0, [r6]
	ands r0, r0, #4
	bne _020D782C
	cmp r4, #0
	movne r5, #1
	bne _020D782C
	ldr r2, [r6, #0x4c]
	ldr r0, [r6, #0x10]
	add r1, sp, #0
	smull r3, r0, r2, r0
	mov r2, r3, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp]
	ldr r3, [r6, #0x50]
	ldr r2, [r6, #0x14]
	mov r0, #0x1c
	smull ip, r2, r3, r2
	mov r3, ip, lsr #0xc
	orr r3, r3, r2, lsl #20
	str r3, [sp, #4]
	ldr ip, [r6, #0x54]
	ldr r3, [r6, #0x18]
	mov r2, #3
	smull lr, r3, ip, r3
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	str ip, [sp, #8]
	bl NNS_G3dGeBufferOP_N
_020D782C:
	ldr r0, [r6]
	ands r0, r0, #2
	bne _020D7868
	cmp r5, #0
	beq _020D7854
	add r1, r6, #0x28
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	b _020D7880
_020D7854:
	add r1, r6, #0x28
	mov r0, #0x1a
	mov r2, #9
	bl NNS_G3dGeBufferOP_N
	b _020D7880
_020D7868:
	cmp r5, #0
	beq _020D7880
	add r1, r6, #0x4c
	mov r0, #0x1c
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
_020D7880:
	cmp r4, #0
	bne _020D7898
	add r1, r6, #0x10
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
_020D7898:
	ldr r0, [r6]
	ands r0, r0, #1
	addne sp, sp, #0x10
	ldmneia sp!, {r4, r5, r6, pc}
	add r1, r6, #4
	mov r0, #0x1b
	mov r2, #3
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end NNSi_G3dGetJointScaleSi3d

	arm_func_start NNSi_G3dSendTexSRT3dsMax
NNSi_G3dSendTexSRT3dsMax: // 0x020D78C0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x50
	mov r4, r0
	ldr r0, [r4]
	mov r1, #0
	ands r0, r0, #8
	ldrne r0, _020D79FC // =0x00101610
	mov r3, #3
	strne r0, [sp]
	ldreq r0, _020D7A00 // =0x00101810
	mov r2, #2
	streq r0, [sp]
	mov r0, #0x1000
	str r0, [sp, #0x44]
	str r3, [sp, #4]
	str r2, [sp, #0x48]
	str r1, [sp, #0x40]
	str r1, [sp, #0x34]
	str r1, [sp, #0x30]
	str r1, [sp, #0x2c]
	str r1, [sp, #0x28]
	str r1, [sp, #0x24]
	str r1, [sp, #0x20]
	str r1, [sp, #0x14]
	str r1, [sp, #0x10]
	ldr r1, [r4]
	ldr r0, _020D7A04 // =_0211F65C
	and r1, r1, #7
	ldr r2, [r0, r1, lsl #2]
	add r0, sp, #8
	mov r1, r4
	blx r2
	ldr r3, [r4, #0x30]
	cmp r3, #0x1000
	beq _020D7990
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	smull r2, r0, r3, r0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp, #8]
	ldr r2, [r4, #0x30]
	ldr r0, [sp, #0x38]
	smull r3, r1, r2, r1
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [sp, #0xc]
	ldr r1, [r4, #0x30]
	smull r2, r0, r1, r0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x38]
_020D7990:
	ldr r3, [r4, #0x34]
	cmp r3, #0x1000
	beq _020D79E0
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	smull r2, r0, r3, r0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp, #0x18]
	ldr r2, [r4, #0x34]
	ldr r0, [sp, #0x3c]
	smull r3, r1, r2, r1
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [sp, #0x1c]
	ldr r1, [r4, #0x34]
	smull r2, r0, r1, r0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x3c]
_020D79E0:
	add r1, sp, #0
	ldr r0, [sp]
	add r1, r1, #4
	mov r2, #0x12
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x50
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D79FC: .word 0x00101610
_020D7A00: .word 0x00101810
_020D7A04: .word 0x0211F65C
	arm_func_end NNSi_G3dSendTexSRT3dsMax

	arm_func_start texmtxCalc_flagTRS_3DSMax
texmtxCalc_flagTRS_3DSMax: // 0x020D7A08
	mov r2, #0x1000
	str r2, [r0]
	mov r1, #0
	str r1, [r0, #4]
	str r1, [r0, #0x10]
	str r2, [r0, #0x14]
	str r1, [r0, #0x30]
	str r1, [r0, #0x34]
	bx lr
	arm_func_end texmtxCalc_flagTRS_3DSMax

	arm_func_start texmtxCalc_flagTR_3DSMax
texmtxCalc_flagTR_3DSMax: // 0x020D7A2C
	ldr r2, [r1, #0x18]
	mov ip, #0
	str r2, [r0]
	ldr r2, [r1, #0x1c]
	str r2, [r0, #0x14]
	str ip, [r0, #4]
	ldr r3, [r1, #0x18]
	ldrh r2, [r1, #0x2c]
	rsb r3, r3, #0x1000
	mul r2, r3, r2
	mov r2, r2, lsl #3
	str r2, [r0, #0x30]
	ldr r2, [r1, #0x1c]
	ldrh r1, [r1, #0x2e]
	rsb r2, r2, #0x1000
	mul r1, r2, r1
	mov r1, r1, lsl #3
	str r1, [r0, #0x34]
	str ip, [r0, #0x10]
	bx lr
	arm_func_end texmtxCalc_flagTR_3DSMax

	arm_func_start texmtxCalc_flagTS_3DSMax
texmtxCalc_flagTS_3DSMax: // 0x020D7A7C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r1
	ldrh r2, [r5, #0x2c]
	ldrh r1, [r5, #0x2e]
	mov r6, r0
	mov r4, r2, lsl #0xc
	mov r7, r1, lsl #0xc
	mov r0, r7
	mov r1, r4
	bl FX_DivAsync
	ldrsh r0, [r5, #0x22]
	str r0, [r6]
	ldrsh r0, [r5, #0x22]
	str r0, [r6, #0x14]
	bl FX_GetDivResult
	ldrsh r2, [r5, #0x20]
	mov r1, r7
	mul r0, r2, r0
	mov r2, r0, asr #0xc
	mov r0, r4
	str r2, [r6, #4]
	bl FX_DivAsync
	ldrh r2, [r5, #0x2c]
	ldrh r1, [r5, #0x2e]
	ldrsh r4, [r5, #0x22]
	rsb r0, r2, #0
	rsb r1, r1, #0
	mov r0, r0, lsl #0xb
	ldrsh r3, [r5, #0x20]
	mov r1, r1, lsl #0xb
	smull r7, lr, r4, r0
	smull ip, r4, r3, r1
	subs r7, r7, ip
	sbc r3, lr, r4
	mov r4, r7, lsr #8
	orr r4, r4, r3, lsl #24
	add r2, r4, r2, lsl #15
	str r2, [r6, #0x30]
	ldrsh r2, [r5, #0x22]
	ldrsh r3, [r5, #0x20]
	ldrh ip, [r5, #0x2e]
	smull r4, r1, r2, r1
	smlal r4, r1, r3, r0
	mov r0, r4, lsr #8
	orr r0, r0, r1, lsl #24
	add r0, r0, ip, lsl #15
	str r0, [r6, #0x34]
	bl FX_GetDivResult
	ldrsh r1, [r5, #0x20]
	rsb r1, r1, #0
	mul r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r6, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end texmtxCalc_flagTS_3DSMax

	arm_func_start texmtxCalc_flagT_3DSMax
texmtxCalc_flagT_3DSMax: // 0x020D7B5C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r1
	ldrh r2, [r9, #0x2c]
	ldrh r1, [r9, #0x2e]
	mov r10, r0
	mov r8, r2, lsl #0xc
	mov r11, r1, lsl #0xc
	mov r0, r11
	mov r1, r8
	bl FX_DivAsync
	ldrsh r0, [r9, #0x22]
	ldr r3, [r9, #0x18]
	ldrsh r5, [r9, #0x20]
	ldr r4, [r9, #0x1c]
	smull r2, r1, r3, r0
	mov r7, r2, lsr #0xc
	orr r7, r7, r1, lsl #20
	smull r2, r1, r3, r5
	mov r6, r2, lsr #0xc
	orr r6, r6, r1, lsl #20
	smull r3, r2, r4, r0
	smull r1, r0, r4, r5
	mov r5, r3, lsr #0xc
	orr r5, r5, r2, lsl #20
	mov r4, r1, lsr #0xc
	orr r4, r4, r0, lsl #20
	str r7, [r10]
	str r5, [r10, #0x14]
	bl FX_GetDivResult
	mov r1, r11
	mul r0, r4, r0
	mov r0, r0, asr #0xc
	str r0, [r10, #4]
	mov r0, r8
	bl FX_DivAsync
	ldrh r3, [r9, #0x2c]
	ldrh r1, [r9, #0x2e]
	rsb r0, r3, #0
	rsb r1, r1, #0
	mov r2, r1, lsl #0xb
	mov r11, r0, lsl #0xb
	smull r1, r0, r7, r11
	smull r8, r7, r5, r2
	smlal r8, r7, r4, r11
	mov r4, r8, lsr #8
	orr r4, r4, r7, lsl #24
	smull r5, r2, r6, r2
	subs r1, r1, r5
	sbc r0, r0, r2
	mov r1, r1, lsr #8
	orr r1, r1, r0, lsl #24
	add r0, r1, r3, lsl #15
	str r0, [r10, #0x30]
	ldrh r0, [r9, #0x2e]
	add r0, r4, r0, lsl #15
	str r0, [r10, #0x34]
	bl FX_GetDivResult
	rsb r1, r6, #0
	mul r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r10, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end texmtxCalc_flagT_3DSMax

	arm_func_start texmtxCalc_flagRS_3DSMax
texmtxCalc_flagRS_3DSMax: // 0x020D7C5C
	mov r2, #0x1000
	str r2, [r0]
	str r2, [r0, #0x14]
	mov ip, #0
	str ip, [r0, #4]
	ldr r3, [r1, #0x24]
	ldrh r2, [r1, #0x2c]
	rsb r3, r3, #0
	mul r2, r3, r2
	mov r2, r2, lsl #4
	str r2, [r0, #0x30]
	ldrh r2, [r1, #0x2e]
	ldr r1, [r1, #0x28]
	mul r2, r1, r2
	mov r1, r2, lsl #4
	str r1, [r0, #0x34]
	str ip, [r0, #0x10]
	bx lr
	arm_func_end texmtxCalc_flagRS_3DSMax

	arm_func_start texmtxCalc_flagR_3DSMax
texmtxCalc_flagR_3DSMax: // 0x020D7CA4
	stmdb sp!, {r4, r5, r6, lr}
	ldr r2, [r1, #0x18]
	mov r3, #0
	str r2, [r0]
	ldr r2, [r1, #0x1c]
	str r2, [r0, #0x14]
	str r3, [r0, #4]
	ldrh r5, [r1, #0x2c]
	ldr ip, [r1, #0x24]
	ldrh r2, [r1, #0x2e]
	mul lr, ip, r5
	rsb ip, r5, #0
	mov ip, ip, lsl #0xb
	ldr r4, [r1, #0x18]
	sub ip, ip, lr
	smull lr, ip, r4, ip
	ldr r6, [r1, #0x28]
	mov r4, lr, lsr #8
	orr r4, r4, ip, lsl #24
	add r4, r4, r5, lsl #15
	str r4, [r0, #0x30]
	mul r4, r6, r2
	rsb r5, r2, #0
	ldr r2, [r1, #0x1c]
	add r4, r4, r5, lsl #11
	smull lr, ip, r2, r4
	mov r2, lr, lsr #8
	ldrh r1, [r1, #0x2e]
	orr r2, r2, ip, lsl #24
	add r1, r2, r1, lsl #15
	str r1, [r0, #0x34]
	str r3, [r0, #0x10]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end texmtxCalc_flagR_3DSMax

	arm_func_start texmtxCalc_flagS_3DSMax
texmtxCalc_flagS_3DSMax: // 0x020D7D28
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r1
	ldrh r2, [r5, #0x2c]
	ldrh r1, [r5, #0x2e]
	mov r6, r0
	mov r4, r2, lsl #0xc
	mov r7, r1, lsl #0xc
	mov r0, r7
	mov r1, r4
	bl FX_DivAsync
	ldrsh r0, [r5, #0x22]
	str r0, [r6]
	ldrsh r0, [r5, #0x22]
	str r0, [r6, #0x14]
	bl FX_GetDivResult
	ldrsh r2, [r5, #0x20]
	mov r1, r7
	mul r0, r2, r0
	mov r2, r0, asr #0xc
	mov r0, r4
	str r2, [r6, #4]
	bl FX_DivAsync
	ldrh r2, [r5, #0x2c]
	ldrh r7, [r5, #0x2e]
	ldr r1, [r5, #0x28]
	ldr r0, [r5, #0x24]
	rsb r4, r2, #0
	mul r3, r1, r7
	rsb r1, r7, #0
	add r1, r3, r1, lsl #11
	ldrsh r3, [r5, #0x20]
	mov r7, r4, lsl #0xb
	mul r4, r0, r2
	sub r0, r7, r4
	ldrsh lr, [r5, #0x22]
	smull ip, r4, r3, r1
	smull r7, r3, lr, r0
	subs r7, r7, ip
	sbc r3, r3, r4
	mov r4, r7, lsr #8
	orr r4, r4, r3, lsl #24
	add r2, r4, r2, lsl #15
	str r2, [r6, #0x30]
	ldrsh r2, [r5, #0x22]
	ldrsh r3, [r5, #0x20]
	ldrh ip, [r5, #0x2e]
	smull r4, r1, r2, r1
	smlal r4, r1, r3, r0
	mov r0, r4, lsr #8
	orr r0, r0, r1, lsl #24
	add r0, r0, ip, lsl #15
	str r0, [r6, #0x34]
	bl FX_GetDivResult
	ldrsh r1, [r5, #0x20]
	rsb r1, r1, #0
	mul r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r6, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end texmtxCalc_flagS_3DSMax

	arm_func_start texmtxCalc_flag_3DSMax
texmtxCalc_flag_3DSMax: // 0x020D7E1C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r1
	ldrh r2, [r9, #0x2c]
	ldrh r1, [r9, #0x2e]
	mov r10, r0
	mov r8, r2, lsl #0xc
	mov r11, r1, lsl #0xc
	mov r0, r11
	mov r1, r8
	bl FX_DivAsync
	ldrsh r0, [r9, #0x22]
	ldr r3, [r9, #0x18]
	ldrsh r5, [r9, #0x20]
	ldr r4, [r9, #0x1c]
	smull r2, r1, r3, r0
	mov r7, r2, lsr #0xc
	orr r7, r7, r1, lsl #20
	smull r2, r1, r3, r5
	mov r6, r2, lsr #0xc
	orr r6, r6, r1, lsl #20
	smull r3, r2, r4, r0
	smull r1, r0, r4, r5
	mov r5, r3, lsr #0xc
	orr r5, r5, r2, lsl #20
	mov r4, r1, lsr #0xc
	orr r4, r4, r0, lsl #20
	str r7, [r10]
	str r5, [r10, #0x14]
	bl FX_GetDivResult
	mov r1, r11
	mul r0, r4, r0
	mov r0, r0, asr #0xc
	str r0, [r10, #4]
	mov r0, r8
	bl FX_DivAsync
	ldrh r1, [r9, #0x2c]
	ldrh r8, [r9, #0x2e]
	ldr r2, [r9, #0x28]
	rsb r0, r1, #0
	mul r3, r2, r8
	rsb r2, r8, #0
	add r8, r3, r2, lsl #11
	mov r0, r0, lsl #0xb
	smull r3, r2, r5, r8
	smull r8, r5, r6, r8
	ldr r11, [r9, #0x24]
	mul ip, r11, r1
	sub r0, r0, ip
	smlal r3, r2, r4, r0
	smull r4, r0, r7, r0
	subs r4, r4, r8
	sbc r0, r0, r5
	mov r4, r4, lsr #8
	orr r4, r4, r0, lsl #24
	add r0, r4, r1, lsl #15
	str r0, [r10, #0x30]
	ldrh r1, [r9, #0x2e]
	mov r0, r3, lsr #8
	orr r0, r0, r2, lsl #24
	add r0, r0, r1, lsl #15
	str r0, [r10, #0x34]
	bl FX_GetDivResult
	rsb r1, r6, #0
	mul r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r10, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end texmtxCalc_flag_3DSMax

	arm_func_start NNSi_G3dSendTexSRTXsi
NNSi_G3dSendTexSRTXsi: // 0x020D7F30
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x50
	mov r4, r0
	ldr r0, [r4]
	mov r3, #3
	ands r0, r0, #8
	ldrne r0, _020D80B0 // =0x00101610
	mov r2, #2
	strne r0, [sp]
	ldreq r0, _020D80B4 // =0x00101810
	mov r1, #0x1000
	streq r0, [sp]
	mov r0, #0
	str r3, [sp, #4]
	str r2, [sp, #0x48]
	str r1, [sp, #0x44]
	str r0, [sp, #0x40]
	str r0, [sp, #0x34]
	str r0, [sp, #0x30]
	str r0, [sp, #0x2c]
	str r0, [sp, #0x28]
	str r0, [sp, #0x24]
	str r0, [sp, #0x20]
	str r0, [sp, #0x14]
	str r0, [sp, #0x10]
	ldr r0, [r4]
	ands r0, r0, #1
	strne r1, [r4, #0x1c]
	ldrne r0, [r4, #0x1c]
	strne r0, [r4, #0x18]
	ldr r0, [r4]
	ands r0, r0, #2
	movne r0, #0x1000
	strneh r0, [r4, #0x22]
	movne r0, #0
	strneh r0, [r4, #0x20]
	ldr r0, [r4]
	ands r0, r0, #4
	movne r0, #0
	strne r0, [r4, #0x28]
	ldrne r0, [r4, #0x28]
	strne r0, [r4, #0x24]
	ldr r1, [r4]
	ldr r0, _020D80B8 // =_0211F67C
	and r1, r1, #7
	ldr r2, [r0, r1, lsl #2]
	add r0, sp, #8
	mov r1, r4
	blx r2
	ldr r3, [r4, #0x30]
	cmp r3, #0x1000
	beq _020D8044
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
	smull r2, r0, r3, r0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp, #8]
	ldr r2, [r4, #0x30]
	ldr r0, [sp, #0x38]
	smull r3, r1, r2, r1
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [sp, #0xc]
	ldr r1, [r4, #0x30]
	smull r2, r0, r1, r0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x38]
_020D8044:
	ldr r3, [r4, #0x34]
	cmp r3, #0x1000
	beq _020D8094
	ldr r0, [sp, #0x18]
	ldr r1, [sp, #0x1c]
	smull r2, r0, r3, r0
	mov r2, r2, lsr #0xc
	orr r2, r2, r0, lsl #20
	str r2, [sp, #0x18]
	ldr r2, [r4, #0x34]
	ldr r0, [sp, #0x3c]
	smull r3, r1, r2, r1
	mov r2, r3, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [sp, #0x1c]
	ldr r1, [r4, #0x34]
	smull r2, r0, r1, r0
	mov r1, r2, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [sp, #0x3c]
_020D8094:
	add r1, sp, #0
	ldr r0, [sp]
	add r1, r1, #4
	mov r2, #0x12
	bl NNS_G3dGeBufferOP_N
	add sp, sp, #0x50
	ldmia sp!, {r4, pc}
	.align 2, 0
_020D80B0: .word 0x00101610
_020D80B4: .word 0x00101810
_020D80B8: .word 0x0211F67C
	arm_func_end NNSi_G3dSendTexSRTXsi

	arm_func_start texmtxCalc_flagTRS_XSi
texmtxCalc_flagTRS_XSi: // 0x020D80BC
	mov r2, #0x1000
	str r2, [r0]
	mov r1, #0
	str r1, [r0, #4]
	str r1, [r0, #0x10]
	str r2, [r0, #0x14]
	str r1, [r0, #0x30]
	str r1, [r0, #0x34]
	bx lr
	arm_func_end texmtxCalc_flagTRS_XSi

	arm_func_start texmtxCalc_flagTR_XSi
texmtxCalc_flagTR_XSi: // 0x020D80E0
	ldr r2, [r1, #0x18]
	mov r3, #0
	str r2, [r0]
	ldr r2, [r1, #0x1c]
	str r2, [r0, #0x14]
	str r3, [r0, #4]
	str r3, [r0, #0x30]
	ldrh r2, [r1, #0x2e]
	ldr r1, [r1, #0x1c]
	rsb r2, r2, #0
	sub r1, r1, #0x1000
	mul r1, r2, r1
	mov r1, r1, lsl #4
	str r1, [r0, #0x34]
	str r3, [r0, #0x10]
	bx lr
	arm_func_end texmtxCalc_flagTR_XSi

	arm_func_start texmtxCalc_flagTS_XSi
texmtxCalc_flagTS_XSi: // 0x020D8120
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r1
	ldrh r2, [r5, #0x2c]
	ldrh r1, [r5, #0x2e]
	mov r6, r0
	mov r4, r2, lsl #0xc
	mov r7, r1, lsl #0xc
	mov r0, r7
	mov r1, r4
	bl FX_DivAsync
	ldrsh r0, [r5, #0x22]
	str r0, [r6]
	ldrsh r0, [r5, #0x22]
	str r0, [r6, #0x14]
	bl FX_GetDivResult
	ldrsh r2, [r5, #0x20]
	mov r1, r7
	mul r0, r2, r0
	mov r2, r0, asr #0xc
	mov r0, r4
	str r2, [r6, #4]
	bl FX_DivAsync
	ldrh r1, [r5, #0x2c]
	ldrsh r0, [r5, #0x20]
	mul r0, r1, r0
	mov r0, r0, lsl #4
	str r0, [r6, #0x30]
	ldrh r1, [r5, #0x2e]
	ldrsh r0, [r5, #0x22]
	rsb r1, r1, #0
	sub r0, r0, #0x1000
	mul r0, r1, r0
	mov r0, r0, lsl #4
	str r0, [r6, #0x34]
	bl FX_GetDivResult
	ldrsh r1, [r5, #0x20]
	rsb r1, r1, #0
	mul r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r6, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end texmtxCalc_flagTS_XSi

	arm_func_start texmtxCalc_flagT_XSi
texmtxCalc_flagT_XSi: // 0x020D81CC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r1
	ldrh r2, [r9, #0x2c]
	ldrh r1, [r9, #0x2e]
	mov r10, r0
	mov r8, r2, lsl #0xc
	mov r11, r1, lsl #0xc
	mov r0, r11
	mov r1, r8
	bl FX_DivAsync
	ldrsh r3, [r9, #0x22]
	ldr r0, [r9, #0x18]
	ldrsh r7, [r9, #0x20]
	ldr r5, [r9, #0x1c]
	smull r2, r1, r0, r3
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	str r2, [r10]
	smull r2, r1, r5, r3
	mov r4, r2, lsr #0xc
	orr r4, r4, r1, lsl #20
	smull r2, r1, r0, r7
	mov r6, r2, lsr #0xc
	orr r6, r6, r1, lsl #20
	str r4, [r10, #0x14]
	bl FX_GetDivResult
	smull r2, r1, r5, r7
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	mul r0, r2, r0
	mov r0, r0, asr #0xc
	str r0, [r10, #4]
	mov r0, r8
	mov r1, r11
	bl FX_DivAsync
	sub r0, r4, #0x1000
	ldrh r1, [r9, #0x2c]
	mul r2, r1, r6
	mov r1, r2, lsl #4
	str r1, [r10, #0x30]
	ldrh r1, [r9, #0x2e]
	rsb r1, r1, #0
	mul r0, r1, r0
	mov r0, r0, lsl #4
	str r0, [r10, #0x34]
	bl FX_GetDivResult
	rsb r1, r6, #0
	mul r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r10, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end texmtxCalc_flagT_XSi

	arm_func_start texmtxCalc_flagRS_XSi
texmtxCalc_flagRS_XSi: // 0x020D82A0
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #0x1000
	str r2, [r0]
	str r2, [r0, #0x14]
	mov lr, #0
	str lr, [r0, #4]
	ldr r2, [r1, #0x24]
	ldrh r3, [r1, #0x2c]
	rsb r2, r2, #0
	ldr ip, [r1, #0x28]
	mul r2, r3, r2
	mov r2, r2, lsl #4
	str r2, [r0, #0x30]
	ldrh r1, [r1, #0x2e]
	rsb r2, ip, #0
	rsb r1, r1, #0
	mul r2, r1, r2
	mov r1, r2, lsl #4
	str r1, [r0, #0x34]
	str lr, [r0, #0x10]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end texmtxCalc_flagRS_XSi

	arm_func_start texmtxCalc_flagR_XSi
texmtxCalc_flagR_XSi: // 0x020D82FC
	stmdb sp!, {r4, lr}
	ldr r3, [r1, #0x18]
	mov r2, #0
	str r3, [r0]
	ldr r3, [r1, #0x1c]
	str r3, [r0, #0x14]
	str r2, [r0, #4]
	ldr ip, [r1, #0x24]
	ldr r3, [r1, #0x18]
	ldr r4, [r1, #0x28]
	smull lr, r3, ip, r3
	mov ip, lr, lsr #0xc
	orr ip, ip, r3, lsl #20
	ldrh lr, [r1, #0x2c]
	rsb r3, ip, #0
	ldr ip, [r1, #0x1c]
	rsb r4, r4, #0
	mul r3, lr, r3
	smull lr, ip, r4, ip
	mov r3, r3, lsl #4
	str r3, [r0, #0x30]
	mov r4, lr, lsr #0xc
	ldrh r3, [r1, #0x2e]
	ldr r1, [r1, #0x1c]
	orr r4, r4, ip, lsl #20
	add r1, r1, r4
	rsb r3, r3, #0
	sub r1, r1, #0x1000
	mul r1, r3, r1
	mov r1, r1, lsl #4
	str r1, [r0, #0x34]
	str r2, [r0, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end texmtxCalc_flagR_XSi

	arm_func_start texmtxCalc_flagS_XSi
texmtxCalc_flagS_XSi: // 0x020D8380
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r1
	ldrh r2, [r5, #0x2c]
	ldrh r1, [r5, #0x2e]
	mov r6, r0
	mov r4, r2, lsl #0xc
	mov r7, r1, lsl #0xc
	mov r0, r7
	mov r1, r4
	bl FX_DivAsync
	ldrsh r0, [r5, #0x22]
	str r0, [r6]
	ldrsh r0, [r5, #0x22]
	str r0, [r6, #0x14]
	bl FX_GetDivResult
	ldrsh r2, [r5, #0x20]
	mov r1, r7
	mul r0, r2, r0
	mov r2, r0, asr #0xc
	mov r0, r4
	str r2, [r6, #4]
	bl FX_DivAsync
	ldrsh lr, [r5, #0x20]
	ldr r4, [r5, #0x28]
	ldrsh r0, [r5, #0x22]
	ldr ip, [r5, #0x24]
	smull r3, r2, r4, lr
	smlal r3, r2, ip, r0
	smull r1, r0, r4, r0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	sub r4, lr, r3
	smull r3, r2, ip, lr
	subs r1, r3, r1
	sbc r0, r2, r0
	ldrh r2, [r5, #0x2c]
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	mul r0, r2, r4
	mov r0, r0, lsl #4
	str r0, [r6, #0x30]
	ldrsh r0, [r5, #0x22]
	ldrh r2, [r5, #0x2e]
	add r0, r0, r1
	rsb r1, r2, #0
	sub r0, r0, #0x1000
	mul r0, r1, r0
	mov r0, r0, lsl #4
	str r0, [r6, #0x34]
	bl FX_GetDivResult
	ldrsh r1, [r5, #0x20]
	rsb r1, r1, #0
	mul r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r6, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end texmtxCalc_flagS_XSi

	arm_func_start texmtxCalc_flag_XSi
texmtxCalc_flag_XSi: // 0x020D8468
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r6, r1
	ldrh r2, [r6, #0x2c]
	ldrh r1, [r6, #0x2e]
	mov r7, r0
	mov r10, r2, lsl #0xc
	mov r11, r1, lsl #0xc
	mov r0, r11
	mov r1, r10
	bl FX_DivAsync
	ldrsh r3, [r6, #0x22]
	ldr r0, [r6, #0x18]
	ldrsh r9, [r6, #0x20]
	smull r2, r1, r0, r3
	mov r2, r2, lsr #0xc
	ldr r8, [r6, #0x1c]
	orr r2, r2, r1, lsl #20
	str r2, [r7]
	smull r2, r1, r8, r3
	mov r4, r2, lsr #0xc
	orr r4, r4, r1, lsl #20
	smull r2, r1, r0, r9
	mov r5, r2, lsr #0xc
	orr r5, r5, r1, lsl #20
	str r4, [r7, #0x14]
	bl FX_GetDivResult
	smull r2, r1, r8, r9
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	mul r0, r2, r0
	mov r0, r0, asr #0xc
	str r0, [r7, #4]
	mov r0, r10
	mov r1, r11
	bl FX_DivAsync
	ldr lr, [r6, #0x1c]
	ldrsh r2, [r6, #0x20]
	ldr r8, [r6, #0x24]
	ldr r0, [r6, #0x28]
	smull r10, r9, r8, r2
	ldrh r1, [r6, #0x2c]
	smull r3, r2, r0, r2
	ldrsh ip, [r6, #0x22]
	str r1, [sp]
	mov r11, lr, asr #0x1f
	smlal r3, r2, r8, ip
	smull r8, ip, r0, ip
	subs r8, r10, r8
	sbc r0, r9, ip
	mov r9, r8, lsr #0xc
	mov ip, r3, lsr #0xc
	orr r9, r9, r0, lsl #20
	mov r3, r2, asr #0xc
	orr ip, ip, r2, lsl #20
	umull r10, r2, r9, lr
	mla r2, r9, r11, r2
	mov r8, r0, asr #0xc
	mla r2, r8, lr, r2
	ldr r1, [r6, #0x18]
	mov r8, r10, lsr #0xc
	orr r8, r8, r2, lsl #20
	add r2, r4, r8
	mov r0, r1, asr #0x1f
	umull r8, r4, ip, r1
	mla r4, ip, r0, r4
	mla r4, r3, r1, r4
	mov r0, r8, lsr #0xc
	orr r0, r0, r4, lsl #20
	sub r1, r5, r0
	ldr r0, [sp]
	sub r2, r2, #0x1000
	mul r1, r0, r1
	mov r0, r1, lsl #4
	str r0, [r7, #0x30]
	ldrh r0, [r6, #0x2e]
	rsb r0, r0, #0
	mul r1, r0, r2
	mov r0, r1, lsl #4
	str r0, [r7, #0x34]
	bl FX_GetDivResult
	rsb r1, r5, #0
	mul r0, r1, r0
	mov r0, r0, asr #0xc
	str r0, [r7, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end texmtxCalc_flag_XSi

	.data

.public NNS_GfdDefaultFuncAllocTexVram
NNS_GfdDefaultFuncAllocTexVram: // 0x0211F410
    .word AllocTexVram_
	
.public NNS_GfdDefaultFuncFreeTexVram
NNS_GfdDefaultFuncFreeTexVram: // 0x0211F414
    .word FreeTexVram_
	
.public NNS_GfdDefaultFuncAllocPlttVram
NNS_GfdDefaultFuncAllocPlttVram: // 0x0211F418
    .word AllocPlttVram_
	
.public NNS_GfdDefaultFuncFreePlttVram
NNS_GfdDefaultFuncFreePlttVram: // 0x0211F41C
    .word FreePlttVram_
	
.public NNS_G3dAnmFmtNum
NNS_G3dAnmFmtNum: // 0x0211F420
    .word 5
	
.public NNS_G3dFuncAnmVisNsBvaDefault
NNS_G3dFuncAnmVisNsBvaDefault: // 0x0211F424
    .word NNSi_G3dAnmCalcNsBva
	
.public NNS_G3dFuncAnmJntNsBcaDefault
NNS_G3dFuncAnmJntNsBcaDefault: // 0x0211F428
    .word NNSi_G3dAnmCalcNsBca
	
.public NNS_G3dFuncAnmMatNsBtaDefault
NNS_G3dFuncAnmMatNsBtaDefault: // 0x0211F42C
    .word NNSi_G3dAnmCalcNsBta
	
.public NNS_G3dFuncAnmMatNsBtpDefault
NNS_G3dFuncAnmMatNsBtpDefault: // 0x0211F430
    .word NNSi_G3dAnmCalcNsBtp
	
.public NNS_G3dFuncAnmMatNsBmaDefault
NNS_G3dFuncAnmMatNsBmaDefault: // 0x0211F434
    .word NNSi_G3dAnmCalcNsBma
	
.public NNS_G3dFuncBlendVisDefault
NNS_G3dFuncBlendVisDefault: // 0x0211F438
    .word NNSi_G3dAnmBlendVis
	
.public NNS_G3dFuncBlendJntDefault
NNS_G3dFuncBlendJntDefault: // 0x0211F43C
    .word NNSi_G3dAnmBlendJnt
	
.public NNS_G3dFuncBlendMatDefault
NNS_G3dFuncBlendMatDefault: // 0x0211F440
    .word NNSi_G3dAnmBlendMat
	
.public NNS_G3dAnmObjInitFuncArray
NNS_G3dAnmObjInitFuncArray: // 0x0211F444
	.byte 0x4D
	.byte 0
	.hword 0x4D41
	.word NNSi_G3dAnmObjInitNsBma

	.byte 0x4D
	.byte 0
	.hword 0x5450
	.word NNSi_G3dAnmObjInitNsBtp

	.byte 0x4D
	.byte 0
	.hword 0x5441
	.word NNSi_G3dAnmObjInitNsBta

	.byte 0x56
	.byte 0
	.hword 0x5641
	.word NNSi_G3dAnmObjInitNsBva

	.byte 0x4A
	.byte 0
	.hword 0x4341
	.word NNSi_G3dAnmObjInitNsBca

.public _0211F46C
_0211F46C: // 0x0211F46C
    .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

NNS_G3dSendJointSRT_FuncArray: // 0x0211F494
    .word NNSi_G3dGetJointScaleBasic, NNSi_G3dGetJointScaleMaya, NNSi_G3dGetJointScaleSi3d

NNS_G3dGetJointScale_FuncArray: // 0x0211F4A0
    .word NNSi_G3dSendJointSRTBasic, NNSi_G3dSendJointSRTMaya, NNSi_G3dSendJointSRTSi3d

NNS_G3dSendTexSRT_FuncArray: // 0x0211F4AC
    .word NNSi_G3dSendTexSRTMaya, NNSi_G3dSendTexSRTSi3d, NNSi_G3dSendTexSRT3dsMax, NNSi_G3dSendTexSRTXsi

_0211F4BC: // 0x0211F4BC
    .word 42
	
_0211F4C0: // 0x0211F4C0
    .word 0
	
_0211F4C4: // 0x0211F4C4
    .word 42
	
_0211F4C8: // 0x0211F4C8
    .word 0
	
_0211F4CC: // 0x0211F4CC
    .word NNSi_G3dFuncSbc_MAT_InternalDefault
	
_0211F4D0: // 0x0211F4D0
    .word 0, 0, 0
	
    .word NNSi_G3dFuncSbc_SHP_InternalDefault
	
_0211F4E0: // 0x0211F4E0
    .word 0, 0, 0

_0211F4EC: // 0x0211F4EC
    .word 0
	
_0211F4F0: // 0x0211F4F0
    .word 0, 0, 0, 0

_0211F500: // 0x0211F500
    .word 0, 0, 0, 0, 0, 0x10000, 0
	
_0211F51C: // 0x0211F51C
    .word 0
	
_0211F520: // 0x0211F520
    .word 0, 0, 0x10000

_0211F52C:
	.byte 0x12, 0x10, 0x17, 0x1B

_0211F530: // 0x0211F530
    .word 1, 2
	
_0211F538: // 0x0211F538
    .word 0x1000, 0, 0, 0, 0x1000, 0, 0, 0, 0x1000
	
_0211F55C: // 0x0211F55C
    .word 0
	
_0211F560: // 0x0211F560
    .word 0
	
_0211F564: // 0x0211F564
    .word 0
	
_0211F568: // 0x0211F568
    .word 0
	
_0211F56C: // 0x0211F56C
    .word 0
	
_0211F570: // 0x0211F570
    .word 0

_0211F574: // 0x0211F574
    .byte 0x12, 0x10, 0x17, 0x1B

_0211F578: // 0x0211F578
    .word 1, 2

_0211F580: // 0x0211F580
    .word 0x1000
	
_0211F584: // 0x0211F584
    .word 0

_0211F588: // 0x0211F588
    .word 0

_0211F58C: // 0x0211F58C
    .word 0
	
_0211F590: // 0x0211F590
    .word 0x1000
	
_0211F594: // 0x0211F594
    .word 0

_0211F598: // 0x0211F598
    .word 0

_0211F59C: // 0x0211F59C
    .word 0
	
_0211F5A0: // 0x0211F5A0
    .word 0x1000
	
_0211F5A4: // 0x0211F5A4
    .word 0
	
_0211F5A8: // 0x0211F5A8
    .word 0
	
_0211F5AC: // 0x0211F5AC
    .word 0
	
_0211F5B0: // 0x0211F5B0
    .word 0
	
_0211F5B4: // 0x0211F5B4
    .word 0
	
_0211F5B8: // 0x0211F5B8
    .word 0
	
NNS_G3dFuncSbcTable: // 0x0211F5BC
    .word NNSi_G3dFuncSbc_NOP, NNSi_G3dFuncSbc_RET, NNSi_G3dFuncSbc_NODE
	.word NNSi_G3dFuncSbc_MTX, NNSi_G3dFuncSbc_MAT, NNSi_G3dFuncSbc_SHP
	.word NNSi_G3dFuncSbc_NODEDESC, NNSi_G3dFuncSbc_BB, NNSi_G3dFuncSbc_BBY
	.word NNSi_G3dFuncSbc_NODEMIX, NNSi_G3dFuncSbc_CALLDL, NNSi_G3dFuncSbc_POSSCALE
	.word NNSi_G3dFuncSbc_ENVMAP, NNSi_G3dFuncSbc_PRJMAP

_0211F5F4: // 0x0211F5F4
    .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

_0211F63C: // 0x0211F63C
    .word texmtxCalc_flag_Maya, texmtxCalc_flagS_Maya, texmtxCalc_flagR_Maya, texmtxCalc_flagRS_Maya
	.word texmtxCalc_flagT_Maya, texmtxCalc_flagTS_Maya, texmtxCalc_flagTR_Maya, texmtxCalc_flagTRS_Maya

_0211F65C: // 0x0211F65C
    .word texmtxCalc_flag_3DSMax, texmtxCalc_flagS_3DSMax, texmtxCalc_flagR_3DSMax, texmtxCalc_flagRS_3DSMax
	.word texmtxCalc_flagT_3DSMax, texmtxCalc_flagTS_3DSMax, texmtxCalc_flagTR_3DSMax, texmtxCalc_flagTRS_3DSMax

_0211F67C: // 0x0211F67C
    .word texmtxCalc_flag_XSi, texmtxCalc_flagS_XSi, texmtxCalc_flagR_XSi, texmtxCalc_flagRS_XSi
	.word texmtxCalc_flagT_XSi, texmtxCalc_flagTS_XSi, texmtxCalc_flagTR_XSi, texmtxCalc_flagTRS_XSi