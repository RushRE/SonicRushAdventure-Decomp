	.include "asm/macros.inc"
	.include "global.inc"

.public VRAMSystem__GFXControl
.public VRAMSystem__VRAM_PALETTE_OBJ
.public VRAMSystem__VRAM_PALETTE_BG

	.text
    
	arm_func_start SeaMapView__GetMode
SeaMapView__GetMode: // 0x0203DCA4
	ldr r0, _0203DCB0 // =0x02134178
	ldr r0, [r0, #4]
	bx lr
	.align 2, 0
_0203DCB0: .word 0x02134178
	arm_func_end SeaMapView__GetMode

	arm_func_start SeaMapView__Func_203DCB4
SeaMapView__Func_203DCB4: // 0x0203DCB4
	ldr r0, _0203DCC0 // =0x02134178
	ldr r0, [r0, #8]
	bx lr
	.align 2, 0
_0203DCC0: .word 0x02134178
	arm_func_end SeaMapView__Func_203DCB4

	arm_func_start SeaMapView__IsActive
SeaMapView__IsActive: // 0x0203DCC4
	ldr r0, _0203DCDC // =0x02134178
	ldr r0, [r0]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_0203DCDC: .word 0x02134178
	arm_func_end SeaMapView__IsActive

	arm_func_start SeaMapView__Func_203DCE0
SeaMapView__Func_203DCE0: // 0x0203DCE0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	bl SeaMapView__GetWork
	mov r4, r0
	bl SeaMapManager__GetZoomInScale
	sub r0, r6, r0, lsl #7
	str r0, [r4, #0x10]
	bl SeaMapManager__GetZoomInScale
	mov r1, #0x60
	mul r1, r0, r1
	sub r1, r5, r1
	mov r0, #0
	str r1, [r4, #0x14]
	str r0, [r4, #0x1c]
	str r0, [r4, #0x18]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SeaMapView__Func_203DCE0

	arm_func_start SeaMapView__GetTouchArea
SeaMapView__GetTouchArea: // 0x0203DD24
	stmdb sp!, {r3, lr}
	ldr r0, _0203DD40 // =0x02134178
	ldr r0, [r0]
	bl GetTaskWork_
	add r0, r0, #0x358
	add r0, r0, #0x400
	ldmia sp!, {r3, pc}
	.align 2, 0
_0203DD40: .word 0x02134178
	arm_func_end SeaMapView__GetTouchArea

	arm_func_start SeaMapView__Func_203DD44
SeaMapView__Func_203DD44: // 0x0203DD44
	stmdb sp!, {r3, lr}
	bl SeaMapView__GetWork
	ldr r0, [r0, #0x79c]
	cmp r0, #0x1000
	movle r0, #1
	movgt r0, #0
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapView__Func_203DD44

	arm_func_start SeaMapView__InitZoomControl
SeaMapView__InitZoomControl: // 0x0203DD60
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	mov r4, r1
	mov r1, r5
	mov r0, #0
	mov r2, #8
	bl MIi_CpuClear16
	str r4, [r5]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapView__InitZoomControl

	arm_func_start SeaMapView__CanZoomIn
SeaMapView__CanZoomIn: // 0x0203DD84
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #4]
	ldr r2, [r5]
	ldr r1, _0203DEA0 // =VRAMSystem__GFXControl
	cmp r0, #0
	ldr r4, [r1, r2, lsl #2]
	beq _0203DDB4
	cmp r0, #1
	beq _0203DDFC
	cmp r0, #2
	beq _0203DE98
_0203DDB4:
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, #1
	str r0, [r4, #0x1c]
	mov r2, #0
	strb r2, [r4, #0x11]
	strb r2, [r4, #0x15]
	strb r2, [r4, #0x10]
	mov r1, #0xc0
	strb r1, [r4, #0x14]
	mov r1, #0xff
	strb r1, [r4, #0x18]
	strb r2, [r4, #0x1a]
	bl RenderCore_DisableWindowPlaneUpdate
	mov r0, #1
	strh r0, [r5, #4]
_0203DDFC:
	ldrb r0, [r4, #0x11]
	add r0, r0, #0xc
	strb r0, [r4, #0x11]
	ldrb r0, [r4, #0x15]
	add r0, r0, #9
	strb r0, [r4, #0x15]
	ldrb r0, [r4, #0x10]
	sub r0, r0, #0xc
	strb r0, [r4, #0x10]
	ldrb r0, [r4, #0x14]
	sub r0, r0, #9
	strb r0, [r4, #0x14]
	ldrb r2, [r4, #0x10]
	ldrb r0, [r4, #0x11]
	cmp r0, r2
	ldrlob r1, [r4, #0x15]
	ldrlob r0, [r4, #0x14]
	cmplo r1, r0
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	strb r2, [r4, #0x11]
	ldrb r1, [r4, #0x14]
	mov r0, #0
	strb r1, [r4, #0x15]
	bl RenderCore_DisableWindowPlaneUpdate
	ldr r0, [r5]
	cmp r0, #0
	bne _0203DE80
	mov r1, #0x4000000
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	str r0, [r1]
	b _0203DE90
_0203DE80:
	ldr r1, _0203DEA4 // =0x04001000
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	str r0, [r1]
_0203DE90:
	mov r0, #2
	strh r0, [r5, #4]
_0203DE98:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0203DEA0: .word VRAMSystem__GFXControl
_0203DEA4: .word 0x04001000
	arm_func_end SeaMapView__CanZoomIn

	arm_func_start SeaMapView__HandleZoomIn
SeaMapView__HandleZoomIn: // 0x0203DEA8
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #4]
	ldr r2, [r5]
	ldr r1, _0203DFC4 // =VRAMSystem__GFXControl
	cmp r0, #0
	ldr r4, [r1, r2, lsl #2]
	beq _0203DED8
	cmp r0, #1
	beq _0203DF58
	cmp r0, #2
	beq _0203DFBC
_0203DED8:
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, #1
	str r0, [r4, #0x1c]
	mov r2, #0
	strb r2, [r4, #0x11]
	strb r2, [r4, #0x15]
	strb r2, [r4, #0x10]
	mov r1, #0xc0
	strb r1, [r4, #0x14]
	strb r2, [r4, #0x18]
	mov r1, #0xff
	strb r1, [r4, #0x1a]
	bl RenderCore_DisableWindowPlaneUpdate
	ldr r0, [r5]
	cmp r0, #0
	bne _0203DF3C
	mov r1, #0x4000000
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
	b _0203DF50
_0203DF3C:
	ldr r1, _0203DFC8 // =0x04001000
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
_0203DF50:
	mov r0, #1
	strh r0, [r5, #4]
_0203DF58:
	ldrb r0, [r4, #0x11]
	add r0, r0, #0xc
	strb r0, [r4, #0x11]
	ldrb r0, [r4, #0x15]
	add r0, r0, #9
	strb r0, [r4, #0x15]
	ldrb r0, [r4, #0x10]
	sub r0, r0, #0xc
	strb r0, [r4, #0x10]
	ldrb r0, [r4, #0x14]
	sub r0, r0, #9
	strb r0, [r4, #0x14]
	ldrb r1, [r4, #0x11]
	ldrb r0, [r4, #0x10]
	cmp r1, r0
	ldrlob r1, [r4, #0x15]
	ldrlob r0, [r4, #0x14]
	cmplo r1, r0
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	mov r0, #0
	str r0, [r4, #0x1c]
	bl RenderCore_DisableWindowPlaneUpdate
	mov r0, #2
	strh r0, [r5, #4]
_0203DFBC:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0203DFC4: .word VRAMSystem__GFXControl
_0203DFC8: .word 0x04001000
	arm_func_end SeaMapView__HandleZoomIn

	arm_func_start SeaMapView__CanZoomOut
SeaMapView__CanZoomOut: // 0x0203DFCC
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #4]
	ldr r2, [r5]
	ldr r1, _0203E138 // =VRAMSystem__GFXControl
	cmp r0, #0
	ldr r4, [r1, r2, lsl #2]
	beq _0203DFFC
	cmp r0, #1
	beq _0203E070
	cmp r0, #2
	beq _0203E130
_0203DFFC:
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r1, #0x80
	strb r1, [r4, #0x11]
	mov r0, #0x60
	strb r0, [r4, #0x15]
	strb r1, [r4, #0x10]
	strb r0, [r4, #0x14]
	mov r0, #0
	strb r0, [r4, #0x18]
	mov r1, #0xff
	strb r1, [r4, #0x1a]
	ldrb r2, [r4, #0x11]
	mov r1, #1
	sub r2, r2, #0xc
	strb r2, [r4, #0x11]
	ldrb r2, [r4, #0x15]
	sub r2, r2, #9
	strb r2, [r4, #0x15]
	ldrb r2, [r4, #0x10]
	add r2, r2, #0xc
	strb r2, [r4, #0x10]
	ldrb r2, [r4, #0x14]
	add r2, r2, #9
	strb r2, [r4, #0x14]
	strh r1, [r5, #4]
	ldmia sp!, {r3, r4, r5, pc}
_0203E070:
	mov r0, #1
	str r0, [r4, #0x1c]
	ldrb r1, [r4, #0x11]
	sub r1, r1, #0xc
	strb r1, [r4, #0x11]
	ldrb r1, [r4, #0x15]
	sub r1, r1, #9
	strb r1, [r4, #0x15]
	ldrb r1, [r4, #0x10]
	add r1, r1, #0xc
	strb r1, [r4, #0x10]
	ldrb r1, [r4, #0x14]
	add r1, r1, #9
	strb r1, [r4, #0x14]
	ldrb r1, [r4, #0x15]
	cmp r1, #6
	bhi _0203E0B8
	bl RenderCore_DisableWindowPlaneUpdate
_0203E0B8:
	ldrb r1, [r4, #0x11]
	ldrb r0, [r4, #0x10]
	cmp r1, r0
	ldrlob r1, [r4, #0x15]
	ldrlob r0, [r4, #0x14]
	cmplo r1, r0
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	mov r0, #0
	strb r0, [r4, #0x11]
	mov r1, #0xff
	strb r1, [r4, #0x10]
	strb r0, [r4, #0x15]
	mov r1, #0xc0
	strb r1, [r4, #0x14]
	bl RenderCore_DisableWindowPlaneUpdate
	ldr r0, [r5]
	cmp r0, #0
	bne _0203E118
	mov r1, #0x4000000
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	str r0, [r1]
	b _0203E128
_0203E118:
	ldr r1, _0203E13C // =0x04001000
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	str r0, [r1]
_0203E128:
	mov r0, #2
	strh r0, [r5, #4]
_0203E130:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0203E138: .word VRAMSystem__GFXControl
_0203E13C: .word 0x04001000
	arm_func_end SeaMapView__CanZoomOut

	arm_func_start SeaMapView__HandleZoomOut
SeaMapView__HandleZoomOut: // 0x0203E140
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	ldrh r0, [r5, #4]
	ldr r2, [r5]
	ldr r1, _0203E260 // =VRAMSystem__GFXControl
	cmp r0, #0
	ldr r4, [r1, r2, lsl #2]
	beq _0203E170
	cmp r0, #1
	beq _0203E1F4
	cmp r0, #2
	beq _0203E258
_0203E170:
	add r1, r4, #0x10
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear16
	mov r0, #1
	str r0, [r4, #0x1c]
	mov r2, #0x80
	strb r2, [r4, #0x11]
	mov r1, #0x60
	strb r1, [r4, #0x15]
	strb r2, [r4, #0x10]
	strb r1, [r4, #0x14]
	mov r1, #0xff
	strb r1, [r4, #0x18]
	mov r1, #0
	strb r1, [r4, #0x1a]
	bl RenderCore_DisableWindowPlaneUpdate
	ldr r0, [r5]
	cmp r0, #0
	bne _0203E1D8
	mov r1, #0x4000000
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
	b _0203E1EC
_0203E1D8:
	ldr r1, _0203E264 // =0x04001000
	ldr r0, [r1]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1f00
	str r0, [r1]
_0203E1EC:
	mov r0, #1
	strh r0, [r5, #4]
_0203E1F4:
	ldrb r0, [r4, #0x11]
	sub r0, r0, #0xc
	strb r0, [r4, #0x11]
	ldrb r0, [r4, #0x15]
	sub r0, r0, #9
	strb r0, [r4, #0x15]
	ldrb r0, [r4, #0x10]
	add r0, r0, #0xc
	strb r0, [r4, #0x10]
	ldrb r0, [r4, #0x14]
	add r0, r0, #9
	strb r0, [r4, #0x14]
	ldrb r1, [r4, #0x11]
	ldrb r0, [r4, #0x10]
	cmp r1, r0
	ldrlob r1, [r4, #0x15]
	ldrlob r0, [r4, #0x14]
	cmplo r1, r0
	movlo r0, #0
	ldmloia sp!, {r3, r4, r5, pc}
	mov r0, #0
	str r0, [r4, #0x1c]
	bl RenderCore_DisableWindowPlaneUpdate
	mov r0, #2
	strh r0, [r5, #4]
_0203E258:
	mov r0, #1
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0203E260: .word VRAMSystem__GFXControl
_0203E264: .word 0x04001000
	arm_func_end SeaMapView__HandleZoomOut

	arm_func_start SeaMapView__GetWork
SeaMapView__GetWork: // 0x0203E268
	ldr r0, _0203E278 // =0x02134178
	ldr ip, _0203E27C // =GetTaskWork_
	ldr r0, [r0]
	bx ip
	.align 2, 0
_0203E278: .word 0x02134178
_0203E27C: .word GetTaskWork_
	arm_func_end SeaMapView__GetWork

	arm_func_start SeaMapView__InitView
SeaMapView__InitView: // 0x0203E280
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	sub sp, sp, #0x38
	mov sb, r0
	mov r8, r1
	mov r4, r2
	mov r5, r3
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0203E2D4
_0203E2AC: // jump table
	b _0203E2C4 // case 0
	b _0203E2C4 // case 1
	b _0203E2C4 // case 2
	b _0203E2C4 // case 3
	b _0203E2C4 // case 4
	b _0203E2C4 // case 5
_0203E2C4:
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	str r0, [sp, #0x20]
	b _0203E2DC
_0203E2D4:
	mov r0, #1
	str r0, [sp, #0x20]
_0203E2DC:
	bl SeaMapManager__GetWork
	str r0, [sp, #0x28]
	ldr r2, _0203E7BC // =0x000007B4
	mov r1, sb
	mov r0, #0
	bl MIi_CpuClear16
	str r8, [sb, #4]
	bl SeaMapManager__GetWork
	add r0, r0, #0x15c
	ldr r1, _0203E7C0 // =VRAMSystem__GFXControl
	str r0, [sb, #0xc]
	mvn r2, #0
	ldr r0, [r1, r8, lsl #2]
	str r2, [sb, #0x790]
	ldrsh r0, [r0, #0x58]
	cmp r4, #4
	strh r0, [sb, #8]
	bge _0203E338
	ldr r0, _0203E7C4 // =0x0210F794
	ldr r0, [r0, r4, lsl #2]
	mov r0, r0, lsl #0xc
	str r0, [sb, #0x798]
	str r0, [sb, #0x79c]
_0203E338:
	mov r0, sb
	bl SeaMapView__Func_203FE44
	ldr r0, [sb, #0xc]
	add r2, sb, #0x164
	ldr r0, [r0]
	mov r1, #0x26
	add r4, r2, #0x400
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	ldr r0, [sb, #4]
	bl VRAMSystem__AllocSpriteVram
	ldr r1, [sb, #4]
	mov r3, #0
	stmia sp, {r1, r3}
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	ldr r2, [sb, #4]
	ldr r0, _0203E7C8 // =VRAMSystem__VRAM_PALETTE_OBJ
	mov r1, #6
	ldr r2, [r0, r2, lsl #2]
	mov r0, r4
	str r2, [sp, #0x10]
	str r3, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr r1, [sb, #0xc]
	ldr r3, _0203E7CC // =0x00000814
	ldr r1, [r1]
	mov r2, #0x26
	bl AnimatorSprite__Init
	mov r0, #4
	cmp r5, #0
	strh r0, [r4, #0x50]
	addeq sp, sp, #0x38
	str r5, [sb]
	ldmeqia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	mov r0, sb
	bl SeaMapView__AllocateSprites
	mov r0, #0
	ldr r6, _0203E7D0 // =0x0210F82C
	ldr sl, _0203E7D4 // =0x0210F7A4
	str r0, [sp, #0x24]
	mov fp, r0
	add r5, sb, #0x44
_0203E3E4:
	ldr r0, [sp, #0x24]
	mov r2, #0
	cmp r0, #5
	bhs _0203E484
	ldrb r0, [r6]
	strh r0, [r5, #0xa2]
_0203E3FC:
	add r0, r6, r2
	ldrb r1, [r0, #0xc]
	add r0, r5, r2, lsl #1
	add r2, r2, #1
	strh r1, [r0, #0x9c]
	cmp r2, #3
	blo _0203E3FC
	str r8, [sp]
	mov r1, #0
	str r1, [sp, #4]
	ldr r0, [r6, #4]
	ldr r2, _0203E7C8 // =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, sb, r0, lsl #2
	ldr r0, [r0, #0x30]
	ldr r7, [r2, r8, lsl #2]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	str r7, [sp, #0x10]
	str r1, [sp, #0x14]
	ldrb r1, [r6, #1]
	mov r0, r5
	mov r3, #0x800
	str r1, [sp, #0x18]
	ldr r1, [sb, #0xc]
	ldrh r2, [r5, #0xa2]
	ldr r1, [r1]
	bl AnimatorSprite__Init
	ldrh r0, [r5, #0x9c]
	strh r0, [r5, #0x50]
	ldrsh r0, [r6, #8]
	strh r0, [r5, #8]
	ldrsh r0, [r6, #0xa]
	strh r0, [r5, #0xa]
	b _0203E55C
_0203E484:
	ldr r1, _0203E7D8 // =a8ajs
	sub r0, fp, #0x78
	add r4, r1, r0
	ldr r0, [sp, #0x20]
	ldrb r0, [r0, r4]
	strh r0, [r5, #0xa2]
_0203E49C:
	add r0, r4, r2
	ldrb r1, [r0, #0x14]
	add r0, r5, r2, lsl #1
	add r2, r2, #1
	strh r1, [r0, #0x9c]
	cmp r2, #3
	blo _0203E49C
	bl RenderCore_GetLanguagePtr
	ldrb r0, [r0]
	cmp r0, #5
	addls pc, pc, r0, lsl #2
	b _0203E4F0
_0203E4CC: // jump table
	b _0203E4E4 // case 0
	b _0203E4E4 // case 1
	b _0203E4E4 // case 2
	b _0203E4E4 // case 3
	b _0203E4E4 // case 4
	b _0203E4E4 // case 5
_0203E4E4:
	bl RenderCore_GetLanguagePtr
	ldrb r2, [r0]
	b _0203E4F4
_0203E4F0:
	mov r2, #1
_0203E4F4:
	str r8, [sp]
	mov r1, #0
	str r1, [sp, #4]
	ldr r0, [r4, #0xc]
	ldr r3, _0203E7C8 // =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, sb, r0, lsl #2
	ldr r7, [r3, r8, lsl #2]
	ldr r3, [r0, #0x30]
	mov r0, r5
	str r3, [sp, #8]
	str r1, [sp, #0xc]
	str r7, [sp, #0x10]
	str r1, [sp, #0x14]
	ldrb r1, [r4, #8]
	mov r3, #0x800
	str r1, [sp, #0x18]
	ldrb r2, [r4, r2]
	ldr r1, [sb, #0xc]
	ldr r1, [r1]
	bl AnimatorSprite__Init
	ldrh r0, [r5, #0x9c]
	strh r0, [r5, #0x50]
	ldrsh r0, [r4, #0x10]
	strh r0, [r5, #8]
	ldrsh r0, [r4, #0x12]
	strh r0, [r5, #0xa]
_0203E55C:
	add r2, sp, #0x30
	mov r0, r5
	mov r1, #0
	bl AnimatorSprite__GetBlockData
	ldr r1, [sl, #4]
	ldr r2, _0203E7DC // =TouchField__PointInRect
	stmia sp, {r1, sb}
	add r0, r5, #0x64
	add r1, r5, #8
	add r3, sp, #0x30
	bl TouchField__InitAreaShape
	ldr r0, [sp, #0x28]
	ldrh r2, [sl], #8
	add r0, r0, #0x13c
	add r1, r5, #0x64
	bl TouchField__AddArea
	mov r0, r5
	mov r1, #0
	bl SetSpriteButtonState
	ldr r0, [sp, #0x24]
	add r5, r5, #0xa4
	add r0, r0, #1
	add r6, r6, #0x10
	add fp, fp, #0x18
	str r0, [sp, #0x24]
	cmp r0, #8
	blo _0203E3E4
	mov r5, #0
	add r1, sp, #0x2c
	mov r4, #0x100
	mov r3, #0xc0
	strh r3, [sp, #0x36]
	add r0, sb, #0x358
	ldr r2, _0203E7E0 // =SeaMapView__TouchAreaCallback
	strh r5, [r1]
	strh r5, [r1, #2]
	strh r5, [sp, #0x30]
	strh r5, [sp, #0x32]
	strh r4, [sp, #0x34]
	str r2, [sp]
	ldr r2, _0203E7DC // =TouchField__PointInRect
	add r3, sp, #0x30
	add r0, r0, #0x400
	str sb, [sp, #4]
	bl TouchField__InitAreaShape
	ldr r0, [sp, #0x28]
	add r1, sb, #0x358
	add r0, r0, #0x13c
	add r1, r1, #0x400
	mov r2, #8
	bl TouchField__AddArea
	add r0, sb, #0x1c8
	ldr r1, _0203E7C8 // =VRAMSystem__VRAM_PALETTE_OBJ
	add r4, r0, #0x400
	ldr r0, [r1, r8, lsl #2]
	str r0, [sp, #0x1c]
	bl GetSpriteButtonCursorSprite
	mov r5, r0
	bl SeaMapView__GetCursorSpriteSize
	mov r1, r0
	mov r0, r8
	bl VRAMSystem__AllocSpriteVram
	str r8, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	str r3, [sp, #0x14]
	ldr r2, _0203E7E4 // =0x0210F774
	str r3, [sp, #0x18]
	ldrb r2, [r2]
	mov r1, r5
	mov r0, r4
	bl AnimatorSprite__Init
	ldr r1, _0203E7E4 // =0x0210F774
	mov r0, sb
	ldrb r2, [r1, #1]
	mvn r1, #0
	strh r2, [r4, #0x50]
	bl SeaMapView__InitTouchCursor
	mov sl, #0
	add r0, sb, #0x22c
	ldr r5, _0203E7E8 // =0x0210F776
	add r6, r0, #0x400
	mov fp, sl
_0203E6B8:
	bl GetSpriteButtonCursorSprite
	ldr r1, [sb, #0xc]
	mov r4, r0
	ldr r0, [r1]
	ldrb r1, [r5]
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r8
	bl VRAMSystem__AllocSpriteVram
	stmia sp, {r8, fp}
	str r0, [sp, #8]
	str fp, [sp, #0xc]
	str r7, [sp, #0x10]
	str fp, [sp, #0x14]
	str fp, [sp, #0x18]
	ldrb r2, [r5]
	mov r1, r4
	mov r0, r6
	mov r3, fp
	bl AnimatorSprite__Init
	ldrb r2, [r5, #1]
	mov r1, #0
	mov r0, r6
	strh r2, [r6, #0x50]
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	add sl, sl, #1
	add r5, r5, #2
	add r6, r6, #0x64
	cmp sl, #2
	blo _0203E6B8
	ldr r0, [sb, #0xc]
	add r2, sb, #0x2f4
	ldr r0, [r0]
	mov r1, #0x2e
	add r4, r2, #0x400
	bl Sprite__GetSpriteSize1FromAnim
	mov r1, r0
	mov r0, r8
	bl VRAMSystem__AllocSpriteVram
	str r8, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r0, [sp, #8]
	ldr r0, [sp, #0x1c]
	str r3, [sp, #0xc]
	str r0, [sp, #0x10]
	str r3, [sp, #0x14]
	mov r0, #5
	str r0, [sp, #0x18]
	ldr r1, [sb, #0xc]
	mov r0, r4
	ldr r1, [r1]
	mov r2, #0x2e
	bl AnimatorSprite__Init
	mov r1, #0
	mov r0, #4
	strh r0, [r4, #0x50]
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	bl AllocSndHandle
	str r0, [sb, #0x7a8]
	add sp, sp, #0x38
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	.align 2, 0
_0203E7BC: .word 0x000007B4
_0203E7C0: .word VRAMSystem__GFXControl
_0203E7C4: .word 0x0210F794
_0203E7C8: .word VRAMSystem__VRAM_PALETTE_OBJ
_0203E7CC: .word 0x00000814
_0203E7D0: .word 0x0210F82C
_0203E7D4: .word 0x0210F7A4
_0203E7D8: .word a8ajs
_0203E7DC: .word TouchField__PointInRect
_0203E7E0: .word SeaMapView__TouchAreaCallback
_0203E7E4: .word 0x0210F774
_0203E7E8: .word 0x0210F776
	arm_func_end SeaMapView__InitView

	arm_func_start SeaMapView__ReleaseAssets
SeaMapView__ReleaseAssets: // 0x0203E7EC
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	bl SeaMapManager__GetWork
	add r1, r5, #0x164
	mov r4, r0
	add r0, r1, #0x400
	bl AnimatorSprite__Release
	ldr r0, [r5]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r0, r5, #0x2f4
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	add r0, r5, #0x1c8
	add r0, r0, #0x400
	bl AnimatorSprite__Release
	add r0, r5, #0x22c
	add r7, r0, #0x400
	mov r6, #0
_0203E838:
	mov r0, r7
	bl AnimatorSprite__Release
	add r6, r6, #1
	cmp r6, #2
	add r7, r7, #0x64
	blo _0203E838
	mov r0, r5
	bl SeaMapView__ReleaseSprites
	add r1, r5, #0x358
	add r0, r4, #0x13c
	add r1, r1, #0x400
	bl TouchField__RemoveArea
	add r6, r5, #0xa8
	mov r7, #0
_0203E870:
	mov r1, r6
	add r0, r4, #0x13c
	bl TouchField__RemoveArea
	add r7, r7, #1
	cmp r7, #8
	add r6, r6, #0xa4
	blo _0203E870
	ldr r0, [r5, #0x7a8]
	bl FreeSndHandle
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SeaMapView__ReleaseAssets

	arm_func_start SeaMapView__Func_203E898
SeaMapView__Func_203E898: // 0x0203E898
	add r0, r0, #0x700
	mvn r1, #0x1d
	strh r1, [r0, #0xa4]
	bx lr
	arm_func_end SeaMapView__Func_203E898

	arm_func_start SeaMapView__Func_203E8A8
SeaMapView__Func_203E8A8: // 0x0203E8A8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0203E8CC
	ldr r0, _0203E90C // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	bne _0203E8DC
_0203E8CC:
	ldr r0, _0203E910 // =padInput
	ldrh r0, [r0]
	tst r0, #0xf0
	beq _0203E8E8
_0203E8DC:
	mov r0, r4
	bl SeaMapView__Func_203E898
	ldmia sp!, {r4, pc}
_0203E8E8:
	add r0, r4, #0x700
	ldrsh r1, [r0, #0xa4]
	add r1, r1, #1
	strh r1, [r0, #0xa4]
	ldrsh r1, [r0, #0xa4]
	cmp r1, #0xff
	movgt r1, #0
	strgth r1, [r0, #0xa4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0203E90C: .word touchInput
_0203E910: .word padInput
	arm_func_end SeaMapView__Func_203E8A8

	arm_func_start SeaMapView__Func_203E914
SeaMapView__Func_203E914: // 0x0203E914
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov r5, r0
	ldr r0, [r5, #0x79c]
	ldr r1, [r5, #0x798]
	bl FX_Div
	mov r4, r0
	mov r0, #0x1000
	mov r1, #3
	bl FX_DivS32
	mov r6, r0
	mov r0, r4
	mov r1, r6
	bl FX_Div
	mov r7, r0, asr #0xc
	cmp r7, #3
	addhs r0, r5, #0x700
	movhs r1, #0x3e0
	bhs _0203EA40
	mul r0, r7, r6
	mov r1, r6
	sub r0, r4, r0
	bl FX_Div
	ldr r1, _0203EB18 // =0x0210F77C
	mov r2, r7, lsl #1
	ldrh r6, [r1, r2]
	ldr r1, _0203EB1C // =0x0210F77A
	mov r0, r0, lsl #0x10
	ldrh sb, [r1, r2]
	mov r2, r6, asr #0xa
	and r7, r2, #0x1f
	mov r3, sb, asr #0xa
	and r2, r6, #0x1f
	mov r1, r6, asr #5
	and r6, r1, #0x1f
	mov r1, r7, lsl #0x10
	mov r8, sb, asr #5
	mov r2, r2, lsl #0x10
	and r3, r3, #0x1f
	mov r6, r6, lsl #0x10
	mov r7, r2, lsr #4
	mov r2, r6, lsr #4
	mov r1, r1, lsr #4
	mov r6, r0, asr #0x10
	and lr, sb, #0x1f
	sub r0, r1, r3, lsl #12
	and ip, r8, #0x1f
	sub r1, r7, lr, lsl #12
	sub r7, r2, ip, lsl #12
	smull r2, sb, r0, r6
	adds r2, r2, #0x800
	smull r8, r0, r1, r6
	adc sb, sb, #0
	adds r1, r8, #0x800
	mov r2, r2, lsr #0xc
	orr r2, r2, sb, lsl #20
	add r2, r2, r3, lsl #12
	smull r6, r3, r7, r6
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	adds r6, r6, #0x800
	add r7, r1, lr, lsl #12
	adc r0, r3, #0
	mov r1, r6, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, ip, lsl #12
	mov r0, r0, asr #0xc
	mov r0, r0, lsl #0x10
	mov r2, r2, asr #0xc
	mov r3, r0, lsr #0xb
	mov r1, r7, lsl #4
	mov r0, r2, lsl #0x10
	orr r1, r3, r1, lsr #16
	orr r1, r1, r0, lsr #6
	add r0, r5, #0x700
_0203EA40:
	strh r1, [r0, #0xa0]
	add r1, r5, #0x700
	ldrh lr, [r1, #0xa0]
	ldr r2, _0203EB20 // =VRAMSystem__VRAM_PALETTE_BG
	add r0, r5, #0x7a0
	mov r3, lr, asr #5
	and r3, r3, #0x1f
	mov r6, lr, asr #0xa
	and ip, r6, #0x1f
	mov r3, r3, asr #1
	and r6, lr, #0x1f
	mov r3, r3, lsl #5
	mov ip, ip, asr #1
	orr r3, r3, r6, asr #1
	orr r3, r3, ip, lsl #10
	strh r3, [r1, #0xa2]
	ldr r3, [r5, #4]
	mov r1, #1
	ldr r3, [r2, r3, lsl #2]
	mov r2, #0
	add r3, r3, #0xfe
	add r3, r3, #0x100
	bl QueueUncompressedPalette
	ldr r2, [r5, #4]
	ldr r1, _0203EB24 // =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, r5, #0x7a0
	ldr r2, [r1, r2, lsl #2]
	mov r1, #1
	add r3, r2, #0x9c
	mov r2, #0
	bl LoadUncompressedPalette
	add r0, r5, #0xa2
	ldr r2, [r5, #4]
	ldr r1, _0203EB24 // =VRAMSystem__VRAM_PALETTE_OBJ
	add r0, r0, #0x700
	ldr r2, [r1, r2, lsl #2]
	mov r1, #1
	add r3, r2, #0x9e
	mov r2, #0
	bl LoadUncompressedPalette
	ldr r0, _0203EB28 // =0x00000B34
	mov r1, #0
	umull r3, r2, r4, r0
	mla r2, r4, r1, r2
	mov r1, r4, asr #0x1f
	mla r2, r1, r0, r2
	adds r1, r3, #0x800
	adc r0, r2, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r1, #0xcc
	add r0, r0, #0x400
	str r0, [r5, #0x59c]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	.align 2, 0
_0203EB18: .word 0x0210F77C
_0203EB1C: .word 0x0210F77A
_0203EB20: .word VRAMSystem__VRAM_PALETTE_BG
_0203EB24: .word VRAMSystem__VRAM_PALETTE_OBJ
_0203EB28: .word 0x00000B34
	arm_func_end SeaMapView__Func_203E914

	arm_func_start SeaMapView__GetCursorSpriteSize
SeaMapView__GetCursorSpriteSize: // 0x0203EB2C
	stmdb sp!, {r3, lr}
	bl GetSpriteButtonCursorSprite
	ldr r1, _0203EB44 // =0x0210F774
	ldrb r1, [r1]
	bl Sprite__GetSpriteSize1FromAnim
	ldmia sp!, {r3, pc}
	.align 2, 0
_0203EB44: .word 0x0210F774
	arm_func_end SeaMapView__GetCursorSpriteSize

	arm_func_start SeaMapView__InitTouchCursor
SeaMapView__InitTouchCursor: // 0x0203EB48
	stmdb sp!, {r3, r4, r5, lr}
	add r0, r0, #0x1c8
	mvn r2, #0
	cmp r1, r2
	add r4, r0, #0x400
	bne _0203EB70
	ldr r0, [r4, #0x3c]
	orr r0, r0, #1
	str r0, [r4, #0x3c]
	ldmia sp!, {r3, r4, r5, pc}
_0203EB70:
	ldr r2, _0203EBAC // =0x0210F774
	mov r0, r4
	add r5, r2, r1, lsl #1
	ldrb r1, [r2, r1, lsl #1]
	bl AnimatorSprite__SetAnimation
	ldr r0, [r4, #0x3c]
	mov r1, #0
	bic r0, r0, #1
	str r0, [r4, #0x3c]
	ldrb r3, [r5, #1]
	mov r0, r4
	mov r2, r1
	strh r3, [r4, #0x50]
	bl AnimatorSprite__ProcessAnimation
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0203EBAC: .word 0x0210F774
	arm_func_end SeaMapView__InitTouchCursor

	arm_func_start SeaMapView__AllocateSprites
SeaMapView__AllocateSprites: // 0x0203EBB0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	add r1, r8, #0x30
	mov r0, #0
	mov r2, #0x14
	bl MIi_CpuClear32
	mov r5, #0
	ldr r6, _0203EC58 // =0x0210F82C
	ldr r4, _0203EC5C // =_0210F76C
	mov r7, r5
_0203EBD8:
	cmp r5, #5
	mov r0, r8
	mov r1, r5
	bhs _0203EBF4
	bl SeaMapView__Func_203ECA0
	ldr r1, [r6, #4]
	b _0203EC00
_0203EBF4:
	bl SeaMapView__Func_203ECF4
	add r1, r4, r7
	ldr r1, [r1, #0xc]
_0203EC00:
	add r2, r8, r1, lsl #2
	ldr r1, [r2, #0x30]
	add r5, r5, #1
	cmp r1, r0
	strlo r0, [r2, #0x30]
	cmp r5, #8
	add r6, r6, #0x10
	add r7, r7, #0x18
	blo _0203EBD8
	mov r4, #0
_0203EC28:
	add r0, r8, r4, lsl #2
	ldr r1, [r0, #0x30]
	cmp r1, #0
	beq _0203EC48
	ldr r0, [r8, #4]
	bl VRAMSystem__AllocSpriteVram
	add r1, r8, r4, lsl #2
	str r0, [r1, #0x30]
_0203EC48:
	add r4, r4, #1
	cmp r4, #5
	blo _0203EC28
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0203EC58: .word 0x0210F82C
_0203EC5C: .word _0210F76C
	arm_func_end SeaMapView__AllocateSprites

	arm_func_start SeaMapView__ReleaseSprites
SeaMapView__ReleaseSprites: // 0x0203EC60
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, #0
	mov r6, r0
	mov r4, r5
_0203EC70:
	add r0, r6, r5, lsl #2
	ldr r1, [r0, #0x30]
	cmp r1, #0
	beq _0203EC90
	ldr r0, [r6, #4]
	bl VRAMSystem__FreeSpriteVram
	add r0, r6, r5, lsl #2
	str r4, [r0, #0x30]
_0203EC90:
	add r5, r5, #1
	cmp r5, #5
	blo _0203EC70
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SeaMapView__ReleaseSprites

	arm_func_start SeaMapView__Func_203ECA0
SeaMapView__Func_203ECA0: // 0x0203ECA0
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0xc]
	ldr r4, _0203ECF0 // =0x0210F82C
	mov r5, r1
	ldrb r1, [r4, r5, lsl #4]
	ldr r0, [r0]
	bl Sprite__GetSpriteSize1FromAnim
	ldrb r1, [r4, r5, lsl #4]
	mov r4, r0
	ldr r2, [r6, #0xc]
	add r0, r1, #1
	mov r1, r0, lsl #0x10
	ldr r0, [r2]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize1FromAnim
	cmp r4, r0
	movlo r4, r0
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0203ECF0: .word 0x0210F82C
	arm_func_end SeaMapView__Func_203ECA0

	arm_func_start SeaMapView__Func_203ECF4
SeaMapView__Func_203ECF4: // 0x0203ECF4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	ldr r3, _0203ED64 // =a8ajs
	sub r2, r1, #5
	mov r1, #0x18
	mla r4, r2, r1, r3
	mov r5, #0
	mov r7, r0
	mov r6, r5
_0203ED14:
	ldrb r0, [r4, r6]
	ldr r2, [r7, #0xc]
	add r0, r0, #1
	mov r1, r0, lsl #0x10
	ldr r0, [r2]
	mov r1, r1, lsr #0x10
	bl Sprite__GetSpriteSize1FromAnim
	cmp r5, r0
	movlo r5, r0
	ldr r0, [r7, #0xc]
	ldrb r1, [r4, r6]
	ldr r0, [r0]
	bl Sprite__GetSpriteSize1FromAnim
	cmp r5, r0
	add r6, r6, #1
	movlo r5, r0
	cmp r6, #8
	blo _0203ED14
	mov r0, r5
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0203ED64: .word a8ajs
	arm_func_end SeaMapView__Func_203ECF4

	arm_func_start SeaMapView__IsButtonActive
SeaMapView__IsButtonActive: // 0x0203ED68
	mov r2, #0xa4
	mla r0, r1, r2, r0
	ldr r0, [r0, #0x80]
	tst r0, #1
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end SeaMapView__IsButtonActive

	arm_func_start SeaMapView__IsTouchAreaActive
SeaMapView__IsTouchAreaActive: // 0x0203ED84
	mov r2, #0xa4
	mla r0, r1, r2, r0
	ldr r0, [r0, #0xbc]
	tst r0, #0x40
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end SeaMapView__IsTouchAreaActive

	arm_func_start SeaMapView__EnableTouchArea
SeaMapView__EnableTouchArea: // 0x0203EDA0
	stmdb sp!, {r4, lr}
	add r3, r0, #0x44
	mov r0, #0xa4
	mla r4, r1, r0, r3
	cmp r2, #0
	mov r0, r4
	beq _0203EDD4
	mov r1, #0
	bl SetSpriteButtonState
	ldr r0, [r4, #0x78]
	bic r0, r0, #0x40
	str r0, [r4, #0x78]
	ldmia sp!, {r4, pc}
_0203EDD4:
	mov r1, #2
	bl SetSpriteButtonState
	ldr r0, [r4, #0x78]
	orr r0, r0, #0x40
	str r0, [r4, #0x78]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapView__EnableTouchArea

	arm_func_start SeaMapView__EnableButton
SeaMapView__EnableButton: // 0x0203EDEC
	stmdb sp!, {r4, r5, r6, lr}
	add r3, r0, #0x44
	mov r0, #0xa4
	mla r4, r1, r0, r3
	cmp r2, #0
	beq _0203EE50
	cmp r1, #5
	bge _0203EE20
	ldr r0, _0203EE78 // =0x0210F82C
	add r0, r0, r1, lsl #4
	ldrsh r5, [r0, #8]
	ldrsh r6, [r0, #0xa]
	b _0203EE38
_0203EE20:
	ldr r2, _0203EE7C // =a8ajs
	sub r1, r1, #5
	mov r0, #0x18
	mla r0, r1, r0, r2
	ldrsh r5, [r0, #0x10]
	ldrsh r6, [r0, #0x12]
_0203EE38:
	ldr r1, [r4, #0x3c]
	mov r0, r4
	bic r1, r1, #1
	str r1, [r4, #0x3c]
	bl AnimatorSprite__ProcessFrame
	b _0203EE64
_0203EE50:
	ldr r0, [r4, #0x3c]
	ldr r5, _0203EE80 // =0x000003E7
	orr r0, r0, #1
	mov r6, r5
	str r0, [r4, #0x3c]
_0203EE64:
	mov r0, r4
	mov r1, r5
	mov r2, r6
	bl SetSpriteButtonPosition
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0203EE78: .word 0x0210F82C
_0203EE7C: .word a8ajs
_0203EE80: .word 0x000003E7
	arm_func_end SeaMapView__EnableButton

	arm_func_start SeaMapView__EnableMultipleButtons
SeaMapView__EnableMultipleButtons: // 0x0203EE84
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, #0
_0203EE94:
	ldr r2, [r5, r4, lsl #2]
	mov r0, r6
	mov r1, r4
	bl SeaMapView__EnableButton
	add r4, r4, #1
	cmp r4, #8
	blo _0203EE94
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end SeaMapView__EnableMultipleButtons

	arm_func_start SeaMapView__SetButtonMode
SeaMapView__SetButtonMode: // 0x0203EEB4
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r1
	mov r1, #1
	mov r4, r0
	mov r2, r1
	bl SeaMapView__EnableButton
	mov r0, r4
	mov r1, #2
	mov r2, #1
	bl SeaMapView__EnableButton
	cmp r5, #0
	beq _0203EEF8
	cmp r5, #1
	beq _0203EF2C
	cmp r5, #2
	beq _0203EF60
	ldmia sp!, {r3, r4, r5, pc}
_0203EEF8:
	add r0, r4, #0xe8
	mov r1, #2
	bl SetSpriteButtonState
	ldr r1, [r4, #0x160]
	add r0, r4, #0x18c
	orr r1, r1, #0x40
	str r1, [r4, #0x160]
	mov r1, #0
	bl SetSpriteButtonState
	ldr r0, [r4, #0x204]
	bic r0, r0, #0x40
	str r0, [r4, #0x204]
	ldmia sp!, {r3, r4, r5, pc}
_0203EF2C:
	add r0, r4, #0xe8
	mov r1, #0
	bl SetSpriteButtonState
	ldr r1, [r4, #0x160]
	add r0, r4, #0x18c
	bic r1, r1, #0x40
	str r1, [r4, #0x160]
	mov r1, #0
	bl SetSpriteButtonState
	ldr r0, [r4, #0x204]
	bic r0, r0, #0x40
	str r0, [r4, #0x204]
	ldmia sp!, {r3, r4, r5, pc}
_0203EF60:
	add r0, r4, #0xe8
	mov r1, #0
	bl SetSpriteButtonState
	ldr r1, [r4, #0x160]
	add r0, r4, #0x18c
	bic r1, r1, #0x40
	str r1, [r4, #0x160]
	mov r1, #2
	bl SetSpriteButtonState
	ldr r0, [r4, #0x204]
	orr r0, r0, #0x40
	str r0, [r4, #0x204]
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapView__SetButtonMode

	arm_func_start SeaMapView__ProcessButtons
SeaMapView__ProcessButtons: // 0x0203EF94
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0203EFB8
	ldr r0, _0203F024 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
_0203EFB8:
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x154]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	ldr r6, _0203F028 // =0x0210F782
	ldr r5, _0203F02C // =padInput
	mov r7, #0
_0203EFD4:
	mov r0, r4
	mov r1, r7
	bl SeaMapView__IsButtonActive
	cmp r0, #0
	beq _0203F014
	mov r0, r4
	mov r1, r7
	bl SeaMapView__IsTouchAreaActive
	cmp r0, #0
	beq _0203F014
	mov r0, r7, lsl #1
	ldrh r1, [r5, #4]
	ldrh r0, [r6, r0]
	tst r1, r0
	strne r7, [r4, #0x790]
	ldmneia sp!, {r3, r4, r5, r6, r7, pc}
_0203F014:
	add r7, r7, #1
	cmp r7, #8
	blo _0203EFD4
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0203F024: .word touchInput
_0203F028: .word 0x0210F782
_0203F02C: .word padInput
	arm_func_end SeaMapView__ProcessButtons

	arm_func_start SeaMapView__SetZoomLevel
SeaMapView__SetZoomLevel: // 0x0203F030
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, lr}
	mov r4, r0
	mov sb, r1
	bl SeaMapView__SetButtonMode
	ldr r5, [r4, #0x10]
	ldr r6, [r4, #0x14]
	bl SeaMapManager__GetZoomInScale
	ldr r1, [r4, #0x10]
	add r7, r1, r0, lsl #7
	bl SeaMapManager__GetZoomInScale
	ldr r2, [r4, #0x14]
	mov r1, #0x60
	mla r8, r0, r1, r2
	mov r0, sb
	bl SeaMapManager__SetZoomLevel
	bl SeaMapManager__GetZoomInScale
	sub r7, r7, r0, lsl #7
	bl SeaMapManager__GetZoomInScale
	mov r1, #0x60
	mul r1, r0, r1
	sub r8, r8, r1
	bl SeaMapManager__GetZoomOutScale
	sub r1, r7, r5
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	ldr r2, [r4, #0x18]
	orr r1, r1, r0, lsl #20
	add r0, r2, r1
	str r0, [r4, #0x18]
	bl SeaMapManager__GetZoomOutScale
	sub r1, r8, r6
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	ldr r2, [r4, #0x1c]
	orr r1, r1, r0, lsl #20
	add r1, r2, r1
	mov r0, #0xf
	str r1, [r4, #0x1c]
	bl SeaMapManager__EnableDrawFlags
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, pc}
	arm_func_end SeaMapView__SetZoomLevel

	arm_func_start SeaMapView__ProcessPadInputs
SeaMapView__ProcessPadInputs: // 0x0203F0E0
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r0
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x154]
	cmp r0, #0
	beq _0203F1C8
	bl IsTouchInputEnabled
	cmp r0, #0
	beq _0203F114
	ldr r0, _0203F338 // =touchInput
	ldrh r0, [r0, #0x12]
	tst r0, #1
	bne _0203F1C8
_0203F114:
	bl SeaMapManager__GetWork
	ldr r0, [r0, #0x154]
	cmp r0, #0
	beq _0203F1C8
	ldr r0, _0203F33C // =padInput
	ldrh r0, [r0]
	tst r0, #0xf0
	beq _0203F1C8
	bl SeaMapManager__GetZoomInScale
	mov r2, #0
	mov r1, #0x6000
	umull r5, r3, r0, r1
	mla r3, r0, r2, r3
	mov r0, r0, asr #0x1f
	mla r3, r0, r1, r3
	str r2, [r4, #0x24]
	ldr r0, _0203F33C // =padInput
	str r2, [r4, #0x20]
	adds r5, r5, #0x800
	ldrh r1, [r0]
	adc r2, r3, #0
	mov r0, r5, lsr #0xc
	tst r1, #0x20
	ldrne r1, [r4, #0x10]
	orr r0, r0, r2, lsl #20
	subne r1, r1, r0
	strne r1, [r4, #0x10]
	ldr r1, _0203F33C // =padInput
	ldrh r1, [r1]
	tst r1, #0x10
	ldrne r1, [r4, #0x10]
	addne r1, r1, r0
	strne r1, [r4, #0x10]
	ldr r1, _0203F33C // =padInput
	ldrh r1, [r1]
	tst r1, #0x40
	ldrne r1, [r4, #0x14]
	subne r1, r1, r0
	strne r1, [r4, #0x14]
	ldr r1, _0203F33C // =padInput
	ldrh r1, [r1]
	tst r1, #0x80
	ldrne r1, [r4, #0x14]
	addne r0, r1, r0
	strne r0, [r4, #0x14]
_0203F1C8:
	bl SeaMapManager__GetZoomInScale
	ldr r2, [r4, #0x18]
	ldr r5, [r4, #0x10]
	smull r3, r2, r0, r2
	adds r3, r3, #0x800
	adc r2, r2, #0
	mov r3, r3, lsr #0xc
	orr r3, r3, r2, lsl #20
	add r2, r5, r3
	str r2, [r4, #0x10]
	ldr r3, [r4, #0x1c]
	ldr ip, [r4, #0x14]
	smull r5, r3, r0, r3
	adds r5, r5, #0x800
	adc r3, r3, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r3, lsl #20
	add r3, ip, r5
	mov r1, #0
	str r3, [r4, #0x14]
	str r1, [r4, #0x1c]
	str r1, [r4, #0x18]
	ldr r3, [r4, #0x20]
	ldr ip, [r4, #0x10]
	smull r5, r3, r0, r3
	adds r5, r5, #0x800
	adc r3, r3, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r3, lsl #20
	add r3, ip, r5
	str r3, [r4, #0x10]
	ldr r3, [r4, #0x24]
	ldr ip, [r4, #0x14]
	smull r5, r3, r0, r3
	adds r5, r5, #0x800
	adc r0, r3, #0
	mov r3, r5, lsr #0xc
	orr r3, r3, r0, lsl #20
	add r0, ip, r3
	str r0, [r4, #0x14]
	ldr r5, [r4, #0x20]
	ldr r0, _0203F340 // =0x00000CCC
	mov r3, r5, asr #0x1f
	umull lr, ip, r5, r0
	mla ip, r5, r1, ip
	adds r5, lr, #0x800
	mla ip, r3, r0, ip
	adc r3, ip, #0
	mov r5, r5, lsr #0xc
	orr r5, r5, r3, lsl #20
	str r5, [r4, #0x20]
	ldr ip, [r4, #0x24]
	mov r2, #0x800
	umull r5, lr, ip, r0
	mla lr, ip, r1, lr
	mov r1, ip, asr #0x1f
	mla lr, r1, r0, lr
	adds r1, r5, #0x800
	adc r0, lr, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	str r1, [r4, #0x24]
	ldr r0, [r4, #0x20]
	sub r3, r2, #0x20800
	cmp r0, r3
	movlt r0, r3
	blt _0203F2DC
	cmp r0, #0x20000
	movgt r0, #0x20000
_0203F2DC:
	str r0, [r4, #0x20]
	mov r0, #0x20000
	ldr r1, [r4, #0x24]
	rsb r0, r0, #0
	cmp r1, r0
	movlt r1, r0
	blt _0203F300
	cmp r1, #0x20000
	movgt r1, #0x20000
_0203F300:
	str r1, [r4, #0x24]
	ldr r0, [r4, #0x20]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0xcc
	movlt r0, #0
	strlt r0, [r4, #0x20]
	ldr r0, [r4, #0x24]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0xcc
	movlt r0, #0
	strlt r0, [r4, #0x24]
	ldmia sp!, {r3, r4, r5, pc}
	.align 2, 0
_0203F338: .word touchInput
_0203F33C: .word padInput
_0203F340: .word 0x00000CCC
	arm_func_end SeaMapView__ProcessPadInputs

	arm_func_start SeaMapView__Func_203F344
SeaMapView__Func_203F344: // 0x0203F344
	mov r1, #0
	str r1, [r0, #0x24]
	str r1, [r0, #0x20]
	str r1, [r0, #0x2c]
	str r1, [r0, #0x28]
	bx lr
	arm_func_end SeaMapView__Func_203F344

	arm_func_start SeaMapView__Func_203F35C
SeaMapView__Func_203F35C: // 0x0203F35C
	stmdb sp!, {r3, r4, r5, lr}
	cmp r1, #0
	movne r4, #3
	mov r5, r0
	moveq r4, #8
	bl SeaMapManager__GetWork
	add r1, r5, #0x358
	mov r2, r4
	add r0, r0, #0x13c
	add r1, r1, #0x400
	bl TouchField__UpdateAreaPriority
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapView__Func_203F35C

	arm_func_start SeaMapView__SetTouchAreaCallback
SeaMapView__SetTouchAreaCallback: // 0x0203F38C
	str r1, [r0, #0x764]
	bx lr
	arm_func_end SeaMapView__SetTouchAreaCallback

	arm_func_start SeaMapView__TouchAreaCallback2
SeaMapView__TouchAreaCallback2: // 0x0203F394
	bx lr
	arm_func_end SeaMapView__TouchAreaCallback2

	arm_func_start SeaMapView__TouchAreaCallback
SeaMapView__TouchAreaCallback: // 0x0203F398
	stmdb sp!, {r3, lr}
	ldr r3, [r0]
	ldr r1, [r1, #0x14]
	cmp r3, #0x400000
	beq _0203F3C0
	cmp r3, #0x800000
	beq _0203F438
	cmp r3, #0x1000000
	beq _0203F3E0
	ldmia sp!, {r3, pc}
_0203F3C0:
	mov r1, #0
	str r1, [r2, #0x24]
	str r1, [r2, #0x20]
	str r1, [r2, #0x2c]
	mov r0, r2
	str r1, [r2, #0x28]
	bl SeaMapView__InitTouchCursor
	ldmia sp!, {r3, pc}
_0203F3E0:
	tst r1, #0x800
	ldmneia sp!, {r3, pc}
	ldr r0, [r2, #0x28]
	mvn r1, #0
	str r0, [r2, #0x20]
	ldr r0, [r2, #0x2c]
	str r0, [r2, #0x24]
	ldr r0, [r2, #0x20]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x3000
	movlt r0, #0
	strlt r0, [r2, #0x20]
	ldr r0, [r2, #0x24]
	cmp r0, #0
	rsblt r0, r0, #0
	cmp r0, #0x3000
	movlt r0, #0
	strlt r0, [r2, #0x24]
	mov r0, r2
	bl SeaMapView__InitTouchCursor
	ldmia sp!, {r3, pc}
_0203F438:
	tst r1, #0x800
	ldmneia sp!, {r3, pc}
	ldrsh r1, [r0, #4]
	rsb r1, r1, #0
	mov r1, r1, lsl #0xc
	str r1, [r2, #0x28]
	ldrsh r1, [r0, #6]
	rsb r1, r1, #0
	mov r1, r1, lsl #0xc
	str r1, [r2, #0x2c]
	ldrsh r1, [r0, #4]
	rsb r1, r1, #0
	mov r1, r1, lsl #0xc
	str r1, [r2, #0x18]
	ldrsh r0, [r0, #6]
	rsb r0, r0, #0
	mov r0, r0, lsl #0xc
	str r0, [r2, #0x1c]
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapView__TouchAreaCallback

	arm_func_start SeaMapView__OnButtonPressed
SeaMapView__OnButtonPressed: // 0x0203F484
	stmdb sp!, {r3, lr}
	ldr r0, [r0]
	ldr r1, [r1, #0x14]
	cmp r0, #0x1000000
	bhi _0203F4B8
	bhs _0203F4F4
	cmp r0, #0x40000
	bhi _0203F4AC
	streq r3, [r2, #0x790]
	ldmia sp!, {r3, pc}
_0203F4AC:
	cmp r0, #0x400000
	beq _0203F4D4
	ldmia sp!, {r3, pc}
_0203F4B8:
	cmp r0, #0x2000000
	bhi _0203F4C8
	beq _0203F4D4
	ldmia sp!, {r3, pc}
_0203F4C8:
	cmp r0, #0x8000000
	beq _0203F4F4
	ldmia sp!, {r3, pc}
_0203F4D4:
	tst r1, #0x800
	ldmneia sp!, {r3, pc}
	add r1, r2, #0x44
	mov r0, #0xa4
	mla r0, r3, r0, r1
	mov r1, #1
	bl SetSpriteButtonState
	ldmia sp!, {r3, pc}
_0203F4F4:
	tst r1, #0x800
	ldmneia sp!, {r3, pc}
	add r1, r2, #0x44
	mov r0, #0xa4
	mla r0, r3, r0, r1
	mov r1, #0
	bl SetSpriteButtonState
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapView__OnButtonPressed

	arm_func_start SeaMapView__ButtonCallback1
SeaMapView__ButtonCallback1: // 0x0203F514
	ldr ip, _0203F520 // =SeaMapView__OnButtonPressed
	mov r3, #0
	bx ip
	.align 2, 0
_0203F520: .word SeaMapView__OnButtonPressed
	arm_func_end SeaMapView__ButtonCallback1

	arm_func_start SeaMapView__ButtonCallback2
SeaMapView__ButtonCallback2: // 0x0203F524
	ldr ip, _0203F530 // =SeaMapView__OnButtonPressed
	mov r3, #1
	bx ip
	.align 2, 0
_0203F530: .word SeaMapView__OnButtonPressed
	arm_func_end SeaMapView__ButtonCallback2

	arm_func_start SeaMapView__ButtonCallback3
SeaMapView__ButtonCallback3: // 0x0203F534
	ldr ip, _0203F540 // =SeaMapView__OnButtonPressed
	mov r3, #2
	bx ip
	.align 2, 0
_0203F540: .word SeaMapView__OnButtonPressed
	arm_func_end SeaMapView__ButtonCallback3

	arm_func_start SeaMapView__ButtonCallback4
SeaMapView__ButtonCallback4: // 0x0203F544
	ldr ip, _0203F550 // =SeaMapView__OnButtonPressed
	mov r3, #3
	bx ip
	.align 2, 0
_0203F550: .word SeaMapView__OnButtonPressed
	arm_func_end SeaMapView__ButtonCallback4

	arm_func_start SeaMapView__ButtonCallback5
SeaMapView__ButtonCallback5: // 0x0203F554
	ldr ip, _0203F560 // =SeaMapView__OnButtonPressed
	mov r3, #4
	bx ip
	.align 2, 0
_0203F560: .word SeaMapView__OnButtonPressed
	arm_func_end SeaMapView__ButtonCallback5

	arm_func_start SeaMapView__ButtonCallback6
SeaMapView__ButtonCallback6: // 0x0203F564
	ldr ip, _0203F570 // =SeaMapView__OnButtonPressed
	mov r3, #5
	bx ip
	.align 2, 0
_0203F570: .word SeaMapView__OnButtonPressed
	arm_func_end SeaMapView__ButtonCallback6

	arm_func_start SeaMapView__ButtonCallback7
SeaMapView__ButtonCallback7: // 0x0203F574
	ldr ip, _0203F580 // =SeaMapView__OnButtonPressed
	mov r3, #6
	bx ip
	.align 2, 0
_0203F580: .word SeaMapView__OnButtonPressed
	arm_func_end SeaMapView__ButtonCallback7

	arm_func_start SeaMapView__ButtonCallback8
SeaMapView__ButtonCallback8: // 0x0203F584
	ldr ip, _0203F590 // =SeaMapView__OnButtonPressed
	mov r3, #7
	bx ip
	.align 2, 0
_0203F590: .word SeaMapView__OnButtonPressed
	arm_func_end SeaMapView__ButtonCallback8

	arm_func_start SeaMapView__DrawPenMarker
SeaMapView__DrawPenMarker: // 0x0203F594
	stmdb sp!, {r4, lr}
	add r0, r0, #0x164
	add r4, r0, #0x400
	bl SeaMapManager__GetNodeCount
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl SeaMapManager__GetEndNode
	mov r1, r0
	ldrh r0, [r1, #8]
	ldrh r1, [r1, #0xa]
	add r2, r4, #8
	add r3, r4, #0xa
	bl SeaMapManager__Func_2043AD4
	mov r1, #0
	mov r0, r4
	mov r2, r1
	bl AnimatorSprite__ProcessAnimation
	mov r0, r4
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapView__DrawPenMarker

	arm_func_start SeaMapView__DrawButtons
SeaMapView__DrawButtons: // 0x0203F5E4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	add r5, r0, #0x44
	mov r4, #0
	add r0, r0, #0x2f4
	add r6, r0, #0x400
	mov r7, r4
_0203F5FC:
	ldr r0, [r5, #0x3c]
	tst r0, #1
	bne _0203F640
	mov r0, r5
	mov r1, r7
	mov r2, r7
	bl AnimatorSprite__ProcessAnimation
	mov r0, r5
	bl AnimatorSprite__DrawFrame
	cmp r4, #5
	blo _0203F640
	ldrsh r1, [r5, #8]
	mov r0, r6
	strh r1, [r6, #8]
	ldrsh r1, [r5, #0xa]
	strh r1, [r6, #0xa]
	bl AnimatorSprite__DrawFrame
_0203F640:
	add r4, r4, #1
	cmp r4, #8
	add r5, r5, #0xa4
	blo _0203F5FC
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SeaMapView__DrawButtons

	arm_func_start SeaMapView__DrawTouchCursor
SeaMapView__DrawTouchCursor: // 0x0203F654
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl IsTouchInputEnabled
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _0203F698 // =touchInput
	ldrh r0, [r1, #0x12]
	tst r0, #1
	ldmeqia sp!, {r4, pc}
	ldrh r2, [r1, #0x14]
	add r0, r4, #0x1c8
	add r0, r0, #0x400
	strh r2, [r0, #8]
	ldrh r1, [r1, #0x16]
	strh r1, [r0, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r4, pc}
	.align 2, 0
_0203F698: .word touchInput
	arm_func_end SeaMapView__DrawTouchCursor

	arm_func_start SeaMapView__DrawPadCursors
SeaMapView__DrawPadCursors: // 0x0203F69C
	stmdb sp!, {r3, r4, r5, lr}
	mov r5, r0
	add r0, r5, #0x700
	ldrsh r0, [r0, #0xa4]
	cmp r0, #0
	ldmltia sp!, {r3, r4, r5, pc}
	mov r0, r0, asr #5
	tst r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	add r0, r5, #0x22c
	add r4, r0, #0x400
	ldr r0, [r4, #0x3c]
	tst r0, #1
	bne _0203F718
	bic r0, r0, #0x100
	str r0, [r4, #0x3c]
	mov r0, #0x80
	strh r0, [r4, #8]
	mov r1, #0x20
	mov r0, r4
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x3c]
	mov r1, #0x80
	orr r0, r0, #0x100
	str r0, [r4, #0x3c]
	mov r0, r4
	strh r1, [r4, #8]
	mov r1, #0x90
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
_0203F718:
	add r4, r5, #0x690
	ldr r0, [r4, #0x3c]
	tst r0, #1
	ldmneia sp!, {r3, r4, r5, pc}
	bic r0, r0, #0x80
	str r0, [r4, #0x3c]
	mov r0, #0x20
	strh r0, [r4, #8]
	mov r1, #0x60
	mov r0, r4
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldr r0, [r4, #0x3c]
	mov r1, #0xe0
	orr r0, r0, #0x80
	str r0, [r4, #0x3c]
	mov r0, r4
	strh r1, [r4, #8]
	mov r1, #0x60
	strh r1, [r4, #0xa]
	bl AnimatorSprite__DrawFrame
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapView__DrawPadCursors

	arm_func_start SeaMapView__Func_203F770
SeaMapView__Func_203F770: // 0x0203F770
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x10]
	ldr r1, [r4, #0x14]
	bl SeaMapManager__Func_2043974
	bl SeaMapManager__GetXPos
	str r0, [r4, #0x10]
	bl SeaMapManager__GetYPos
	str r0, [r4, #0x14]
	ldmia sp!, {r4, pc}
	arm_func_end SeaMapView__Func_203F770

	arm_func_start SeaMapView__FadeToBlack
SeaMapView__FadeToBlack: // 0x0203F798
	ldr r1, [r0, #4]
	ldr r0, _0203F7F8 // =VRAMSystem__GFXControl
	ldr r2, [r0, r1, lsl #2]
	ldrsh r1, [r2, #0x58]
	cmp r1, #0
	bge _0203F7CC
	rsb r0, r1, #0
	cmp r0, #1
	addgt r0, r1, #1
	strgth r0, [r2, #0x58]
	movle r0, #0
	strleh r0, [r2, #0x58]
	b _0203F7E4
_0203F7CC:
	ble _0203F7E4
	cmp r1, #1
	subgt r0, r1, #1
	strgth r0, [r2, #0x58]
	movle r0, #0
	strleh r0, [r2, #0x58]
_0203F7E4:
	ldrsh r0, [r2, #0x58]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0203F7F8: .word VRAMSystem__GFXControl
	arm_func_end SeaMapView__FadeToBlack

	arm_func_start SeaMapView__FadeActiveScreen
SeaMapView__FadeActiveScreen: // 0x0203F7FC
	ldr r2, [r0, #4]
	ldr r1, _0203F860 // =VRAMSystem__GFXControl
	ldrsh r3, [r0, #8]
	ldr ip, [r1, r2, lsl #2]
	ldrsh r2, [ip, #0x58]
	cmp r2, r3
	bge _0203F830
	sub r1, r3, r2
	cmp r1, #1
	addgt r1, r2, #1
	strgth r1, [ip, #0x58]
	strleh r3, [ip, #0x58]
	b _0203F848
_0203F830:
	ble _0203F848
	sub r1, r2, r3
	cmp r1, #1
	subgt r1, r2, #1
	strgth r1, [ip, #0x58]
	strleh r3, [ip, #0x58]
_0203F848:
	ldrsh r1, [r0, #8]
	ldrsh r0, [ip, #0x58]
	cmp r1, r0
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0203F860: .word VRAMSystem__GFXControl
	arm_func_end SeaMapView__FadeActiveScreen

	arm_func_start SeaMapView__FadeOtherScreen
SeaMapView__FadeOtherScreen: // 0x0203F864
	ldr r1, [r0, #4]
	ldrsh r3, [r0, #8]
	cmp r1, #0
	ldreq ip, _0203F8CC // =renderCoreGFXControlB
	ldrne ip, _0203F8D0 // =renderCoreGFXControlA
	ldrsh r2, [ip, #0x58]
	cmp r2, r3
	bge _0203F89C
	sub r1, r3, r2
	cmp r1, #1
	addgt r1, r2, #1
	strgth r1, [ip, #0x58]
	strleh r3, [ip, #0x58]
	b _0203F8B4
_0203F89C:
	ble _0203F8B4
	sub r1, r2, r3
	cmp r1, #1
	subgt r1, r2, #1
	strgth r1, [ip, #0x58]
	strleh r3, [ip, #0x58]
_0203F8B4:
	ldrsh r1, [r0, #8]
	ldrsh r0, [ip, #0x58]
	cmp r1, r0
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0203F8CC: .word renderCoreGFXControlB
_0203F8D0: .word renderCoreGFXControlA
	arm_func_end SeaMapView__FadeOtherScreen

	arm_func_start SeaMapView__Func_203F8D4
SeaMapView__Func_203F8D4: // 0x0203F8D4
	stmdb sp!, {r3, lr}
	bl SeaMapManager__ClearUnknownPtr
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	beq _0203F8FC
	cmp r0, #1
	beq _0203F904
	cmp r0, #2
	beq _0203F90C
	b _0203F910
_0203F8FC:
	bl SeaMapView__Func_203F91C
	b _0203F910
_0203F904:
	bl SeaMapView__Func_203F9A4
	b _0203F910
_0203F90C:
	bl SeaMapView__Func_203FA24
_0203F910:
	mov r0, #8
	bl SeaMapManager__EnableDrawFlags
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapView__Func_203F8D4

	arm_func_start SeaMapView__Func_203F91C
SeaMapView__Func_203F91C: // 0x0203F91C
	stmdb sp!, {r3, r4, r5, r6, r7, r8, lr}
	sub sp, sp, #4
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	addlo sp, sp, #4
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, pc}
	bl SeaMapManager__GetStartNode
	mov r7, r0
	bl SeaMapManager__GetNextNode
	mov r6, #2
	mov r8, r0
	mov r5, r6
	mov r4, r6
_0203F950:
	str r6, [sp]
	ldrh r0, [r7, #8]
	ldrh r1, [r7, #0xa]
	ldrh r2, [r8, #8]
	ldrh r3, [r8, #0xa]
	bl SeaMapManager__Func_2044DCC
	ldrh r0, [r7, #8]
	ldrh r1, [r7, #0xa]
	mov r2, r5
	bl SeaMapManager__Func_2044E60
	ldrh r0, [r8, #8]
	ldrh r1, [r8, #0xa]
	mov r2, r4
	bl SeaMapManager__Func_2044E60
	mov r0, r8
	mov r7, r8
	bl SeaMapManager__GetNextNode
	movs r8, r0
	bne _0203F950
	add sp, sp, #4
	ldmia sp!, {r3, r4, r5, r6, r7, r8, pc}
	arm_func_end SeaMapView__Func_203F91C

	arm_func_start SeaMapView__Func_203F9A4
SeaMapView__Func_203F9A4: // 0x0203F9A4
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	ldmloia sp!, {r3, r4, r5, r6, r7, pc}
	bl SeaMapManager__GetStartNode
	mov r4, r0
	bl SeaMapManager__GetNextNode
	ldrh r1, [r4, #0xa]
	ldrh r2, [r4, #8]
	mov r4, r0
	mov r1, r1, lsl #0xf
	mov r0, r2, lsl #0xf
	mov r0, r0, lsr #0x10
	mov r1, r1, lsr #0x10
	mov r5, #1
_0203F9E0:
	ldrh r2, [r4, #8]
	ldrh r3, [r4, #0xa]
	mov r2, r2, lsl #0xf
	mov r3, r3, lsl #0xf
	mov r6, r2, lsr #0x10
	mov r7, r3, lsr #0x10
	mov r2, r6
	mov r3, r7
	str r5, [sp]
	bl SeaMapManager__Func_2044DCC
	mov r0, r4
	bl SeaMapManager__GetNextNode
	movs r4, r0
	mov r0, r6
	mov r1, r7
	bne _0203F9E0
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SeaMapView__Func_203F9A4

	arm_func_start SeaMapView__Func_203FA24
SeaMapView__Func_203FA24: // 0x0203FA24
	stmdb sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	ldmloia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	bl SeaMapManager__GetStartNode
	mov r4, r0
	bl SeaMapManager__GetNextNode
	mov r6, r0
	ldrh r0, [r4, #8]
	mov r1, #3
	bl FX_DivS32
	mov r2, r0, lsl #0x10
	ldrh r0, [r4, #0xa]
	mov r1, #3
	mov r7, r2, lsr #0x10
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r5, #3
	mov r8, r0, lsr #0x10
	mov fp, r5
	mov r4, #1
_0203FA78:
	ldrh r0, [r6, #8]
	mov r1, r5
	bl FX_DivS32
	mov r2, r0, lsl #0x10
	ldrh r0, [r6, #0xa]
	mov r1, fp
	mov sb, r2, lsr #0x10
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov sl, r0, lsr #0x10
	mov r0, r7
	mov r1, r8
	mov r2, sb
	mov r3, sl
	str r4, [sp]
	bl SeaMapManager__Func_2044DCC
	mov r0, r6
	bl SeaMapManager__GetNextNode
	movs r6, r0
	mov r7, sb
	mov r8, sl
	bne _0203FA78
	ldmia sp!, {r3, r4, r5, r6, r7, r8, sb, sl, fp, pc}
	arm_func_end SeaMapView__Func_203FA24

	arm_func_start SeaMapView__Func_203FAD4
SeaMapView__Func_203FAD4: // 0x0203FAD4
	stmdb sp!, {r3, lr}
	bl SeaMapManager__GetZoomLevel
	cmp r0, #0
	beq _0203FAF8
	cmp r0, #1
	beq _0203FB00
	cmp r0, #2
	beq _0203FB08
	ldmia sp!, {r3, pc}
_0203FAF8:
	bl SeaMapView__Func_203FB10
	ldmia sp!, {r3, pc}
_0203FB00:
	bl SeaMapView__Func_203FB78
	ldmia sp!, {r3, pc}
_0203FB08:
	bl SeaMapView__Func_203FBE8
	ldmia sp!, {r3, pc}
	arm_func_end SeaMapView__Func_203FAD4

	arm_func_start SeaMapView__Func_203FB10
SeaMapView__Func_203FB10: // 0x0203FB10
	stmdb sp!, {r3, r4, r5, lr}
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	ldmloia sp!, {r3, r4, r5, pc}
	bl SeaMapManager__GetEndNode
	mov r5, r0
	bl SeaMapManager__GetPrevNode
	mov r1, #2
	str r1, [sp]
	mov r4, r0
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	ldrh r2, [r5, #8]
	ldrh r3, [r5, #0xa]
	bl SeaMapManager__Func_2044DCC
	ldrh r0, [r4, #8]
	ldrh r1, [r4, #0xa]
	mov r2, #2
	bl SeaMapManager__Func_2044E60
	ldrh r0, [r5, #8]
	ldrh r1, [r5, #0xa]
	mov r2, #2
	bl SeaMapManager__Func_2044E60
	mov r0, #8
	bl SeaMapManager__EnableDrawFlags
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapView__Func_203FB10

	arm_func_start SeaMapView__Func_203FB78
SeaMapView__Func_203FB78: // 0x0203FB78
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #4
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	addlo sp, sp, #4
	ldmloia sp!, {r3, r4, pc}
	bl SeaMapManager__GetEndNode
	mov r4, r0
	bl SeaMapManager__GetPrevNode
	mov r1, #1
	str r1, [sp]
	ldrh r1, [r0, #0xa]
	ldrh ip, [r0, #8]
	ldrh r2, [r4, #8]
	ldrh r3, [r4, #0xa]
	mov r0, ip, lsl #0xf
	mov r1, r1, lsl #0xf
	mov r2, r2, lsl #0xf
	mov r3, r3, lsl #0xf
	mov r0, r0, lsr #0x10
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	mov r3, r3, lsr #0x10
	bl SeaMapManager__Func_2044DCC
	mov r0, #8
	bl SeaMapManager__EnableDrawFlags
	add sp, sp, #4
	ldmia sp!, {r3, r4, pc}
	arm_func_end SeaMapView__Func_203FB78

	arm_func_start SeaMapView__Func_203FBE8
SeaMapView__Func_203FBE8: // 0x0203FBE8
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl SeaMapManager__GetNodeCount
	cmp r0, #2
	ldmloia sp!, {r3, r4, r5, r6, r7, pc}
	bl SeaMapManager__GetEndNode
	mov r5, r0
	bl SeaMapManager__GetPrevNode
	mov r4, r0
	ldrh r0, [r4, #8]
	mov r1, #3
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r6, r0, lsr #0x10
	ldrh r0, [r4, #0xa]
	mov r1, #3
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
	ldrh r0, [r5, #8]
	mov r1, #3
	bl FX_DivS32
	mov r0, r0, lsl #0x10
	mov r7, r0, lsr #0x10
	ldrh r0, [r5, #0xa]
	mov r1, #3
	bl FX_DivS32
	mov r1, r4
	mov r2, r7
	mov r0, r0, lsl #0x10
	mov r3, r0, lsr #0x10
	mov r0, r6
	mov ip, #1
	str ip, [sp]
	bl SeaMapManager__Func_2044DCC
	mov r0, #8
	bl SeaMapManager__EnableDrawFlags
	ldmia sp!, {r3, r4, r5, r6, r7, pc}
	arm_func_end SeaMapView__Func_203FBE8

	arm_func_start SeaMapView__Func_203FC7C
SeaMapView__Func_203FC7C: // 0x0203FC7C
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x28
	mov r5, r0
	strh r1, [sp, #0x18]
	add r0, sp, #0x14
	add r1, sp, #0x16
	strh r2, [sp, #0x1a]
	mov r4, #0
	bl SeaMapManager__GetLastNodePosition
	ldrh r0, [sp, #0x18]
	ldrh r1, [sp, #0x14]
	cmp r1, r0
	ldreqh r2, [sp, #0x16]
	ldreqh r1, [sp, #0x1a]
	cmpeq r2, r1
	addeq sp, sp, #0x28
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
	ldrh r1, [sp, #0x1a]
	add r2, sp, #0x10
	add r3, sp, #0x12
	bl SeaMapManager__Func_2043BB4
	ldrh r0, [sp, #0x14]
	ldrh r1, [sp, #0x16]
	add r2, sp, #0xc
	add r3, sp, #0xe
	bl SeaMapManager__Func_2043BB4
	mov r0, #1
	str r0, [sp]
	add r1, sp, #0x10
	add r0, sp, #0x12
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldrh r0, [sp, #0x10]
	ldrh r1, [sp, #0x12]
	ldrh r2, [sp, #0xc]
	ldrh r3, [sp, #0xe]
	bl SeaMapCollision__HandleCollisions
	cmp r0, #0
	beq _0203FD58
	ldrh r0, [sp, #0x10]
	ldrh r1, [sp, #0x12]
	add r2, sp, #0x18
	add r3, sp, #0x1a
	mvn r4, #0
	bl SeaMapManager__Func_2043BD0
	ldrh r1, [sp, #0x14]
	ldrh r0, [sp, #0x18]
	cmp r1, r0
	ldrneh r1, [sp, #0x16]
	ldrneh r0, [sp, #0x1a]
	cmpne r1, r0
	addeq sp, sp, #0x28
	moveq r0, #1
	ldmeqia sp!, {r3, r4, r5, pc}
_0203FD58:
	ldrh r0, [sp, #0x18]
	ldrh r1, [sp, #0x1a]
	bl SeaMapManager__AddNode
	bl SeaMapManager__GetEndNode
	ldr r1, [r5, #0x79c]
	ldr r0, [r0, #0xc]
	cmp r1, r0
	bge _0203FE0C
	ldrh r3, [sp, #0x18]
	ldrh r0, [sp, #0x14]
	ldrh r2, [sp, #0x1a]
	ldrh r1, [sp, #0x16]
	sub r3, r3, r0
	mov r4, r3, lsl #0xc
	sub r1, r2, r1
	mov r3, r1, lsl #0xc
	add r0, sp, #0x1c
	mov r2, #0
	mov r1, r0
	str r4, [sp, #0x1c]
	str r3, [sp, #0x20]
	str r2, [sp, #0x24]
	bl VEC_Normalize
	ldr r1, [sp, #0x1c]
	ldr r0, [r5, #0x79c]
	ldrh r3, [sp, #0x14]
	smull r2, r0, r1, r0
	adds r1, r2, #0x800
	adc r0, r0, #0
	mov r1, r1, lsr #0xc
	orr r1, r1, r0, lsl #20
	add r0, r3, r1, asr #12
	strh r0, [sp, #0x18]
	ldr r2, [sp, #0x20]
	ldr r1, [r5, #0x79c]
	ldrh r4, [sp, #0x16]
	smull r3, r1, r2, r1
	adds r2, r3, #0x800
	adc r1, r1, #0
	mov r2, r2, lsr #0xc
	orr r2, r2, r1, lsl #20
	add r1, r4, r2, asr #12
	mov r0, #0
	strh r1, [sp, #0x1a]
	sub r4, r0, #2
_0203FE0C:
	bl SeaMapManager__RemoveNode
	ldrh r0, [sp, #0x18]
	ldrh r1, [sp, #0x1a]
	bl SeaMapManager__AddNode
	bl SeaMapManager__GetEndNode
	ldr r1, [r5, #0x79c]
	ldr r0, [r0, #0xc]
	subs r0, r1, r0
	str r0, [r5, #0x79c]
	movmi r0, #0
	strmi r0, [r5, #0x79c]
	mov r0, r4
	add sp, sp, #0x28
	ldmia sp!, {r3, r4, r5, pc}
	arm_func_end SeaMapView__Func_203FC7C

	arm_func_start SeaMapView__Func_203FE44
SeaMapView__Func_203FE44: // 0x0203FE44
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl SeaMapManager__RemoveAllNodes
	ldr r0, _0203FE7C // =0x02134178
	ldr r1, [r4, #0x798]
	ldr r0, [r0, #0xc]
	subs r0, r1, r0
	str r0, [r4, #0x79c]
	movmi r0, #0
	strmi r0, [r4, #0x79c]
	add r0, r4, #0x700
	mov r1, #0
	strh r1, [r0, #0x94]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0203FE7C: .word 0x02134178
	arm_func_end SeaMapView__Func_203FE44

	arm_func_start SeaMapView__Func_203FE80
SeaMapView__Func_203FE80: // 0x0203FE80
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x700
	ldrh r0, [r0, #0x94]
	bl SeaMapManager__Func_2045E58
	bl SeaMapManager__GetNodeCount
	add r1, r4, #0x700
	strh r0, [r1, #0x94]
	bl SeaMapManager__GetTotalDistance
	ldr r1, _0203FEC8 // =0x02134178
	ldr r2, [r4, #0x798]
	ldr r1, [r1, #0xc]
	sub r1, r2, r1
	subs r0, r1, r0
	str r0, [r4, #0x79c]
	movmi r0, #0
	strmi r0, [r4, #0x79c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0203FEC8: .word 0x02134178
	arm_func_end SeaMapView__Func_203FE80

	.rodata

_0210F76C: // 0x0210F76C
	.byte 0x1F, 0x00, 0x00, 0x00
	.byte 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x1F, 0x00, 0x1F, 0x02, 0xFF, 0x03
	.byte 0xE0, 0x03, 0x02, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x58, 0x00, 0x00, 0x00, 0xB0, 0x00, 0x00, 0x00, 0x90, 0x00, 0x00, 0x00
	.byte 0xB0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x14, 0xF5, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00
	.byte 0x24, 0xF5, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xF5, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00
	.byte 0x44, 0xF5, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x54, 0xF5, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00
	.byte 0x64, 0xF5, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x74, 0xF5, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00
	.byte 0x84, 0xF5, 0x03, 0x02
a8ajs: // 0x0210F7E4
	.asciz "/8AJS\\"
_0210F7EB:
	.byte 0x00, 0x04, 0x00, 0x00, 0x00
	.byte 0x02, 0x00, 0x00, 0x00, 0x80, 0x00, 0x52, 0x00, 0x01, 0x02, 0x03, 0x00, 0x32, 0x3B, 0x44, 0x4D
	.byte 0x56, 0x5F, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x80, 0x00, 0x72, 0x00
	.byte 0x01, 0x02, 0x03, 0x00, 0x35, 0x3E, 0x47, 0x50, 0x59, 0x62, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00
	.byte 0x02, 0x00, 0x00, 0x00, 0x80, 0x00, 0x52, 0x00, 0x01, 0x02, 0x03, 0x00, 0x04, 0x04, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x10, 0x00, 0xB0, 0x00, 0x01, 0x02, 0x03, 0x00, 0x10, 0x04, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0xF0, 0x00, 0xB0, 0x00, 0x01, 0x02, 0x03, 0x00, 0x13, 0x04, 0x00, 0x00
	.byte 0x04, 0x00, 0x00, 0x00, 0xD0, 0x00, 0xB0, 0x00, 0x01, 0x02, 0x03, 0x00, 0x0D, 0x04, 0x00, 0x00
	.byte 0x02, 0x00, 0x00, 0x00, 0x50, 0x00, 0xB4, 0x00, 0x01, 0x02, 0x03, 0x00, 0x0A, 0x04, 0x00, 0x00
	.byte 0x03, 0x00, 0x00, 0x00, 0x94, 0x00, 0xB4, 0x00, 0x01, 0x02, 0x03, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00, 0x0A, 0x00
	.byte 0x0B, 0x00, 0x0C, 0x00, 0x0D, 0x00, 0x0E, 0x00, 0x0F, 0x00, 0x10, 0x00, 0x12, 0x00, 0x13, 0x00
	.byte 0x14, 0x00, 0x15, 0x00, 0x16, 0x00, 0x17, 0x00, 0x18, 0x00, 0x1A, 0x00, 0x1B, 0x00, 0x1C, 0x00
	.byte 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x1D, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x20, 0x00
	.byte 0x21, 0x00, 0x22, 0x00, 0x23, 0x00, 0x24, 0x00, 0x25, 0x00, 0x26, 0x00, 0x27, 0x00, 0x17, 0x00
	.byte 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00
	.byte 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x0D, 0x00, 0x0E, 0x00, 0x0F, 0x00, 0x10, 0x00
	.byte 0x12, 0x00, 0x13, 0x00, 0x14, 0x00, 0x15, 0x00, 0x16, 0x00, 0x17, 0x00, 0x18, 0x00, 0x1A, 0x00
	.byte 0x1B, 0x00, 0x1C, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x1D, 0x00, 0x1E, 0x00
	.byte 0x1F, 0x00, 0x20, 0x00, 0x21, 0x00, 0x22, 0x00, 0x23, 0x00, 0x24, 0x00, 0x25, 0x00, 0x26, 0x00
	.byte 0x27, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00, 0x17, 0x00
	.byte 0x17, 0x00, 0x17, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00
	.byte 0x07, 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x11, 0x00, 0x00, 0x00
	.byte 0x15, 0x00, 0x00, 0x00, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00
	.byte 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x19, 0x00, 0x00, 0x00, 0x1A, 0x00, 0x00, 0x00, 0x1B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x00, 0x00, 0x00
	.byte 0x1D, 0x00, 0x00, 0x00, 0x1E, 0x00, 0x00, 0x00, 0x1F, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00
	.byte 0x21, 0x00, 0x00, 0x00, 0x22, 0x00, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00, 0x24, 0x00, 0x00, 0x00
	.byte 0x25, 0x00, 0x00, 0x00, 0x26, 0x00, 0x00, 0x00, 0x26, 0x00, 0x00, 0x00, 0x26, 0x00, 0x00, 0x00
	.byte 0x26, 0x00, 0x00, 0x00, 0x26, 0x00, 0x00, 0x00, 0x26, 0x00, 0x00, 0x00, 0x26, 0x00, 0x00, 0x00
	.byte 0x26, 0x00, 0x00, 0x00, 0x26, 0x00, 0x00, 0x00, 0x26, 0x00, 0x00, 0x00, 0x33, 0x00, 0x34, 0x00
	.byte 0x36, 0x00, 0x33, 0x00, 0x37, 0x00, 0x31, 0x00, 0x2E, 0x00, 0x2F, 0x00, 0x2E, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x37, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x39, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x38, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x3A, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x19, 0x03, 0x1A, 0x03
	.byte 0x1B, 0x03, 0x1C, 0x02, 0x1C, 0x02, 0x00, 0x00, 0x2F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x30, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x34, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
aGkosw: // 0x0210FA78
	.asciz "gkosw{"
_0210FA7F:
	.byte 0x00
	.byte 0x0F, 0x0F, 0x0F, 0x65, 0x69, 0x6D, 0x71, 0x75, 0x79, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x06, 0x40, 0x02, 0x00, 0x03, 0x20, 0x01, 0x00, 0x02, 0xC0, 0x00, 0x00, 0x10, 0x00, 0x00
	.byte 0x00, 0x08, 0x00, 0x00, 0x55, 0x05, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00
	.byte 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00
	.byte 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0x00
	.byte 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0xFF
	.byte 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01
	.byte 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00
	.byte 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x7D, 0x00, 0x7E, 0x00, 0x7F, 0x00, 0x8C, 0x00, 0x8F, 0x00, 0x90, 0x00, 0x93, 0x00, 0x8D, 0x00
	.byte 0x8E, 0x00, 0x91, 0x00, 0x92, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00
	.byte 0x04, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00
	.byte 0x08, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00
	.byte 0x0C, 0x00, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00
	.byte 0x10, 0x00, 0x00, 0x00, 0x11, 0x00, 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x13, 0x00, 0x00, 0x00
	.byte 0x14, 0x00, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00, 0x16, 0x00, 0x00, 0x00, 0x17, 0x00, 0x00, 0x00
	.byte 0x18, 0x00, 0x00, 0x00, 0x19, 0x00, 0x00, 0x00, 0x1A, 0x00, 0x00, 0x00, 0x1B, 0x00, 0x00, 0x00
	.byte 0x1C, 0x00, 0x00, 0x00, 0x1D, 0x00, 0x00, 0x00, 0x1E, 0x00, 0x00, 0x00, 0x1F, 0x00, 0x00, 0x00
	.byte 0x20, 0x00, 0x00, 0x00, 0x21, 0x00, 0x00, 0x00, 0x22, 0x00, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00
	.byte 0x24, 0x00, 0x00, 0x00, 0x25, 0x00, 0x00, 0x00, 0x26, 0x00, 0x00, 0x00, 0x27, 0x00, 0x00, 0x00
	.byte 0x28, 0x00, 0x00, 0x00, 0x29, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00
	.byte 0x06, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00
	.byte 0x0B, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00
	.byte 0x0E, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x11, 0x00, 0x00, 0x00
	.byte 0x13, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00, 0x17, 0x00, 0x00, 0x00
	.byte 0x18, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00
	.byte 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00
	.byte 0x06, 0x00, 0x00, 0x00, 0x19, 0x00, 0x00, 0x00, 0x1B, 0x00, 0x00, 0x00, 0x1C, 0x00, 0x00, 0x00
	.byte 0x1D, 0x00, 0x00, 0x00, 0x1E, 0x00, 0x00, 0x00, 0x1F, 0x00, 0x00, 0x00, 0x21, 0x00, 0x00, 0x00
	.byte 0x22, 0x00, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00, 0x23, 0x00, 0x00, 0x00, 0x24, 0x00, 0x00, 0x00
	.byte 0x25, 0x00, 0x00, 0x00, 0x26, 0x00, 0x00, 0x00, 0x27, 0x00, 0x00, 0x00