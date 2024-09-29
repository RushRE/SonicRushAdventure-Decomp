	.include "asm/macros.inc"
	.include "global.inc"

	.text

	thumb_func_start SailSea__Create
SailSea__Create: // 0x0215F944
	push {r3, r4, lr}
	sub sp, #0xc
	mov r0, #2
	lsl r0, r0, #0xa
	str r0, [sp]
	mov r0, #3
	str r0, [sp, #4]
	ldr r0, _0215F9CC // =0x00000B88
	mov r2, #0
	str r0, [sp, #8]
	ldr r0, _0215F9D0 // =SailSea__Main
	ldr r1, _0215F9D4 // =SailSea__Destructor
	mov r3, r2
	bl TaskCreate_
	bl GetTaskWork_
	mov r4, r0
	ldr r2, _0215F9CC // =0x00000B88
	mov r0, #0
	mov r1, r4
	bl MIi_CpuClear16
	mov r0, #3
	lsl r0, r0, #8
	str r0, [r4, #0x14]
	mov r0, #1
	lsl r0, r0, #0xc
	str r0, [r4, #0x1c]
	mov r0, #0x40
	str r0, [r4, #0x18]
	mov r0, #0x30
	str r0, [r4, #0x20]
	mov r0, #0x48
	str r0, [r4, #0x24]
	bl SailManager__GetShipType
	cmp r0, #3
	bhi _0215F9B8
	add r0, r0, r0
	add r0, pc
	ldrh r0, [r0, #6]
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	add pc, r0
_0215F99E: // jump table
	.hword _0215F9A6 - _0215F99E - 2 // case 0
	.hword _0215F9AE - _0215F99E - 2 // case 1
	.hword _0215F9A6 - _0215F99E - 2 // case 2
	.hword _0215F9AE - _0215F99E - 2 // case 3
_0215F9A6:
	ldr r0, [r4, #0x18]
	asr r0, r0, #2
	str r0, [r4, #0x18]
	b _0215F9B8
_0215F9AE:
	ldr r0, [r4, #0x20]
	lsl r0, r0, #3
	str r0, [r4, #0x20]
	mov r0, #0
	str r0, [r4, #0x24]
_0215F9B8:
	mov r0, r4
	bl SailSea__LoadSprites
	mov r0, r4
	bl SailSea__Func_215FB98
	mov r0, r4
	add sp, #0xc
	pop {r3, r4, pc}
	nop
_0215F9CC: .word 0x00000B88
_0215F9D0: .word SailSea__Main
_0215F9D4: .word SailSea__Destructor
	thumb_func_end SailSea__Create

	thumb_func_start SailSea__Func_215F9D8
SailSea__Func_215F9D8: // 0x0215F9D8
	push {r4, r5, lr}
	sub sp, #0x3c
	mov r5, r0
	bl SailManager__GetWork
	asr r2, r5, #0x1f
	lsl r3, r2, #0x12
	lsr r1, r5, #0xe
	add r0, #0x94
	orr r3, r1
	mov r1, #2
	ldr r4, [r0]
	mov r0, #0
	lsl r2, r5, #0x12
	lsl r1, r1, #0xa
	add r2, r2, r1
	adc r3, r0
	lsl r1, r3, #0x14
	lsr r2, r2, #0xc
	orr r2, r1
	str r2, [sp, #0x34]
	str r0, [sp, #0x30]
	str r0, [sp, #0x38]
	ldrh r0, [r4, #0x10]
	ldr r3, _0215FA4C // =FX_SinCosTable_
	asr r0, r0, #4
	lsl r2, r0, #1
	lsl r1, r2, #1
	add r2, r2, #1
	lsl r2, r2, #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, sp, #0
	bl MTX_RotZ43_
	add r0, sp, #0x30
	add r1, sp, #0
	mov r2, r0
	bl MTX_MultVec43
	add r0, r4, #4
	add r1, sp, #0x30
	mov r2, r0
	bl VEC_Add
	ldr r1, [r4, #4]
	ldr r0, _0215FA50 // =0x00FFFFFF
	and r1, r0
	str r1, [r4, #4]
	ldr r1, [r4, #8]
	and r1, r0
	str r1, [r4, #8]
	ldr r1, [r4, #0xc]
	and r0, r1
	str r0, [r4, #0xc]
	add sp, #0x3c
	pop {r4, r5, pc}
	nop
_0215FA4C: .word FX_SinCosTable_
_0215FA50: .word 0x00FFFFFF
	thumb_func_end SailSea__Func_215F9D8

	thumb_func_start SailSea__Func_215FA54
SailSea__Func_215FA54: // 0x0215FA54
	push {r4, lr}
	mov r4, r0
	bl SailManager__GetWork
	add r0, #0x94
	ldr r1, [r0]
	strh r4, [r1, #0x10]
	ldrh r0, [r1, #0x10]
	strh r0, [r1, #0x10]
	pop {r4, pc}
	thumb_func_end SailSea__Func_215FA54

	thumb_func_start SailSea__Destructor
SailSea__Destructor: // 0x0215FA68
	push {r3, lr}
	bl GetTaskWork_
	bl SailSea__ReleaseSprites
	pop {r3, pc}
	thumb_func_end SailSea__Destructor

	thumb_func_start SailSea__Main
SailSea__Main: // 0x0215FA74
	push {r4, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl SailManager__GetShipType
	cmp r0, #3
	beq _0215FA8A
	mov r0, r4
	bl SailSea__Func_215FD68
_0215FA8A:
	mov r0, r4
	bl SailSea__Draw
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4]
	pop {r4, pc}
	thumb_func_end SailSea__Main

	thumb_func_start SailSea__LoadSprites
SailSea__LoadSprites: // 0x0215FA98
	push {r4, r5, r6, r7, lr}
	sub sp, #0xc
	mov r7, #0x26
	mov r5, r0
	lsl r7, r7, #6
	bl SailManager__GetArchive
	mov r2, r0
	ldr r1, _0215FB74 // =aSbSeaTexBac
	mov r0, #0
	bl ObjDataLoad
	mov r4, r0
	bl SailManager__GetShipType
	cmp r0, #3
	beq _0215FAF4
	mov r0, r4
	bl Sprite__GetTextureSize
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r6, r0
	mov r0, r4
	bl Sprite__GetPaletteSize
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r1, #0
	str r1, [sp]
	str r6, [sp, #4]
	str r0, [sp, #8]
	add r0, r5, r7
	mov r2, r4
	mov r3, r1
	bl AnimatorSprite3D__Init
	mov r1, #0
	add r0, r5, r7
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
_0215FAF4:
	mov r0, r4
	ldr r6, _0215FB78 // =0x00000A84
	bl Sprite__GetPaletteSize
	mov r1, #0
	bl VRAMSystem__AllocPalette
	mov r7, r0
	mov r0, r4
	bl Sprite__GetTextureSize
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	mov r1, #0
	bl VRAMSystem__AllocTexture
	mov r1, #0
	str r1, [sp]
	str r0, [sp, #4]
	add r0, r5, r6
	mov r2, r4
	mov r3, r1
	str r7, [sp, #8]
	bl AnimatorSprite3D__Init
	bl SailManager__GetShipType
	cmp r0, #3
	beq _0215FB64
	add r0, r5, r6
	add r0, #0x90
	ldr r0, [r0]
	cmp r0, #1
	beq _0215FB42
	cmp r0, #2
	beq _0215FB4E
	cmp r0, #3
	beq _0215FB5A
	b _0215FB64
_0215FB42:
	add r0, r5, r6
	add r0, #0x90
	mov r1, #1
	bl AnimatorSprite__SetAnimation
	b _0215FB64
_0215FB4E:
	add r0, r5, r6
	add r0, #0x90
	mov r1, #1
	bl AnimatorSpriteDS__SetAnimation
	b _0215FB64
_0215FB5A:
	add r0, r5, r6
	add r0, #0x90
	mov r1, #1
	bl AnimatorSpriteDS__SetAnimation2
_0215FB64:
	mov r1, #0
	add r0, r5, r6
	mov r2, r1
	bl AnimatorSprite3D__ProcessAnimation
	add sp, #0xc
	pop {r4, r5, r6, r7, pc}
	nop
_0215FB74: .word aSbSeaTexBac
_0215FB78: .word 0x00000A84
	thumb_func_end SailSea__LoadSprites

	thumb_func_start SailSea__ReleaseSprites
SailSea__ReleaseSprites: // 0x0215FB7C
	push {r4, lr}
	mov r4, r0
	ldr r0, _0215FB94 // =0x00000A84
	add r0, r4, r0
	bl AnimatorSprite3D__Release
	mov r0, #0x26
	lsl r0, r0, #6
	add r0, r4, r0
	bl AnimatorSprite3D__Release
	pop {r4, pc}
	.align 2, 0
_0215FB94: .word 0x00000A84
	thumb_func_end SailSea__ReleaseSprites

	thumb_func_start SailSea__Func_215FB98
SailSea__Func_215FB98: // 0x0215FB98
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r4, r0
	mov r5, #0
	bl SailManager__GetShipType
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #8]
	mov r0, r5
	str r0, [sp, #0xc]
_0215FBAE:
	ldr r0, [sp, #0xc]
	mov r1, #0
	sub r0, r0, #6
	lsl r2, r0, #0xc
	ldr r0, [sp, #0xc]
	str r0, [sp, #0x10]
	sub r0, #8
	str r0, [sp, #0x10]
	neg r0, r0
	str r0, [sp]
	lsl r0, r2, #0x10
	asr r0, r0, #0x10
	mov ip, r0
_0215FBC8:
	mov r0, #0xa
	mul r0, r5
	sub r2, r1, #3
	add r0, r4, r0
	lsl r2, r2, #0xc
	strh r2, [r0, #0x28]
	mov r2, #0x40
	strh r2, [r0, #0x2a]
	mov r2, ip
	strh r2, [r0, #0x2c]
	lsl r2, r1, #6
	sub r2, #0xc0
	strh r2, [r0, #0x2e]
	ldr r0, [sp, #0x10]
	cmp r0, #0
	bge _0215FBEA
	ldr r0, [sp]
_0215FBEA:
	mov r2, #0xa
	mul r2, r5
	sub r0, r0, #2
	add r3, r4, r2
	lsl r0, r0, #6
	strh r0, [r3, #0x30]
	mov r0, #0x96
	ldrh r2, [r3, #0x28]
	lsl r0, r0, #2
	strh r2, [r3, r0]
	ldrh r2, [r3, #0x2a]
	add r0, r0, #2
	strh r2, [r3, r0]
	mov r0, #0x97
	ldrh r2, [r3, #0x2c]
	lsl r0, r0, #2
	strh r2, [r3, r0]
	ldrh r2, [r3, #0x2e]
	add r0, r0, #2
	strh r2, [r3, r0]
	mov r0, #0x26
	ldrh r2, [r3, #0x30]
	lsl r0, r0, #4
	strh r2, [r3, r0]
	sub r0, r0, #6
	ldrsh r2, [r3, r0]
	ldr r0, [r4, #0x20]
	sub r2, r2, r0
	ldr r0, _0215FD48 // =0x0000025A
	strh r2, [r3, r0]
	ldrh r2, [r3, #0x28]
	ldr r0, _0215FD4C // =0x00000488
	strh r2, [r3, r0]
	ldrh r2, [r3, #0x2a]
	add r0, r0, #2
	strh r2, [r3, r0]
	ldrh r2, [r3, #0x2c]
	ldr r0, _0215FD50 // =0x0000048C
	strh r2, [r3, r0]
	ldrh r2, [r3, #0x2e]
	add r0, r0, #2
	strh r2, [r3, r0]
	mov r0, #0x49
	ldrh r2, [r3, #0x30]
	lsl r0, r0, #4
	strh r2, [r3, r0]
	sub r0, r0, #6
	ldrsh r2, [r3, r0]
	ldr r0, [r4, #0x24]
	add r2, r2, r0
	ldr r0, _0215FD54 // =0x0000048A
	strh r2, [r3, r0]
	mov r0, #0x2c
	ldrsh r6, [r3, r0]
	mov r0, #0x2a
	ldrsh r7, [r3, r0]
	mov r2, #0x28
	mov r0, #0xc
	ldrsh r3, [r3, r2]
	mul r0, r5
	mov r2, #0x6e
	add r0, r4, r0
	lsl r2, r2, #4
	str r3, [r0, r2]
	add r2, r2, #4
	str r7, [r0, r2]
	ldr r2, _0215FD58 // =0x000006E8
	str r6, [r0, r2]
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	add r0, r1, #1
	lsl r0, r0, #0x10
	lsr r1, r0, #0x10
	cmp r1, #7
	blo _0215FBC8
	ldr r0, [sp, #0xc]
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0xc]
	cmp r0, #8
	blo _0215FBAE
	ldr r1, _0215FD5C // =_0218BC14
	ldr r0, [sp, #8]
	ldrb r0, [r1, r0]
	add r0, r0, #1
	sub r0, r0, #6
	lsl r0, r0, #0x1c
	asr r1, r0, #0x10
	mov r0, #6
	lsl r0, r0, #0xc
	add r0, r1, r0
	mov r1, #8
	bl FX_DivS32
	lsl r0, r0, #0x10
	asr r0, r0, #0x10
	mov r3, #0
	str r0, [sp, #4]
	ldr r1, _0215FD50 // =0x0000048C
	mov r7, r3
	mov r0, #0xa
_0215FCB8:
	ldr r6, [sp, #4]
	mov r5, #0
	mov r2, r6
	mov r6, #6
	mul r2, r7
	lsl r6, r6, #0xc
	sub r2, r2, r6
	lsl r2, r2, #0x10
	asr r2, r2, #0x10
_0215FCCA:
	mov r6, r3
	add r5, r5, #1
	mul r6, r0
	add r3, r3, #1
	lsl r5, r5, #0x10
	add r6, r4, r6
	lsl r3, r3, #0x10
	lsr r5, r5, #0x10
	lsr r3, r3, #0x10
	strh r2, [r6, r1]
	cmp r5, #7
	blo _0215FCCA
	add r2, r7, #1
	lsl r2, r2, #0x10
	lsr r7, r2, #0x10
	cmp r7, #8
	blo _0215FCB8
	ldr r1, _0215FD60 // =0x000006B8
	ldr r5, _0215FD64 // =0xFFFFC000
	mov r2, #0x9f
	strh r5, [r4, r1]
	mvn r2, r2
	add r0, r1, #2
	strh r2, [r4, r0]
	mov r0, #0x2c
	ldrsh r6, [r4, r0]
	add r3, r1, #4
	strh r6, [r4, r3]
	mov r3, #1
	mov r6, r1
	lsl r3, r3, #0xe
	add r6, #0xa
	strh r3, [r4, r6]
	mov r6, r1
	add r6, #0xc
	strh r2, [r4, r6]
	mov r2, r1
	ldrsh r6, [r4, r0]
	add r2, #0xe
	strh r6, [r4, r2]
	mov r2, r1
	add r2, #0x14
	strh r5, [r4, r2]
	mov r2, #0x22
	mov r5, r1
	lsl r2, r2, #8
	add r5, #0x16
	strh r2, [r4, r5]
	mov r5, r1
	ldrsh r6, [r4, r0]
	add r5, #0x18
	strh r6, [r4, r5]
	mov r5, r1
	add r5, #0x1e
	strh r3, [r4, r5]
	mov r3, r1
	add r3, #0x20
	strh r2, [r4, r3]
	ldrsh r0, [r4, r0]
	add r1, #0x22
	strh r0, [r4, r1]
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_0215FD48: .word 0x0000025A
_0215FD4C: .word 0x00000488
_0215FD50: .word 0x0000048C
_0215FD54: .word 0x0000048A
_0215FD58: .word 0x000006E8
_0215FD5C: .word _0218BC14
_0215FD60: .word 0x000006B8
_0215FD64: .word 0xFFFFC000
	thumb_func_end SailSea__Func_215FB98

	thumb_func_start SailSea__Func_215FD68
SailSea__Func_215FD68: // 0x0215FD68
	push {r4, r5, r6, lr}
	sub sp, #0x20
	mov r6, r0
	mov r0, #0
	str r0, [sp, #0x1c]
_0215FD72:
	ldr r1, [r6]
	ldr r0, [r6, #0x14]
	mov r2, r1
	mul r2, r0
	ldr r1, [r6, #0x1c]
	ldr r0, [sp, #0x1c]
	mov r5, #0
	mul r1, r0
	add r0, r2, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	lsl r1, r0, #2
	ldr r0, _0215FED4 // =FX_SinCosTable_
	ldrsh r0, [r0, r1]
	str r0, [sp, #0xc]
	asr r0, r0, #0x1f
	str r0, [sp, #0x10]
	ldr r0, [sp, #0xc]
	lsr r1, r0, #0x1d
	ldr r0, [sp, #0x10]
	lsl r2, r0, #3
	ldr r0, [sp, #0xc]
	orr r2, r1
	lsl r1, r0, #3
	mov r0, #2
	lsl r0, r0, #0xa
	add r0, r1, r0
	adc r2, r5
	lsr r0, r0, #0xc
	lsl r1, r2, #0x14
	str r0, [sp, #0x18]
	orr r0, r1
	str r0, [sp, #0x18]
	ldr r0, [sp, #0x1c]
	mov r1, #0xa
	mul r1, r0
	add r0, r6, r1
	str r0, [sp, #0x14]
_0215FDC4:
	cmp r5, #3
	blo _0215FDFA
	ldr r4, [r6, #0x18]
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	asr r1, r4, #0x1f
	mov r0, r4
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _0215FED8 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	add r0, r4, r1
	mov r1, #7
	mov r2, r5
	mul r2, r1
	mov r1, #0xa
	mov r3, r2
	mul r3, r1
	ldr r1, [sp, #0x14]
	add r1, r1, r3
	strh r0, [r1, #0x2a]
_0215FDFA:
	asr r0, r5, #1
	add r1, r0, #6
	mov r0, #2
	lsl r0, r0, #0xa
	asr r0, r1
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	asr r1, r0, #0x1f
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _0215FED8 // =0x00000000
	adc r1, r0
	lsr r0, r2, #0xc
	lsl r1, r1, #0x14
	str r0, [sp]
	orr r0, r1
	str r0, [sp]
	mov r0, #7
	mov r1, r5
	mul r1, r0
	mov r0, #0xa
	mov r2, r1
	mul r2, r0
	ldr r0, [sp, #0x14]
	add r4, r0, r2
	mov r0, #0x28
	ldrsh r1, [r4, r0]
	ldr r0, [sp]
	add r0, r1, r0
	strh r0, [r4, #0x28]
	mov r0, #0x2c
	ldrsh r1, [r4, r0]
	ldr r0, [sp, #0x18]
	add r0, r1, r0
	strh r0, [r4, #0x2c]
	cmp r5, #2
	blo _0215FE74
	ldr r0, [r6, #0x18]
	ldr r2, [sp, #0xc]
	ldr r3, [sp, #0x10]
	asr r1, r0, #0x1f
	str r0, [sp, #8]
	bl _ull_mul
	mov r2, #2
	lsl r2, r2, #0xa
	add r2, r0, r2
	ldr r0, _0215FED8 // =0x00000000
	adc r1, r0
	lsl r0, r1, #0x14
	lsr r1, r2, #0xc
	orr r1, r0
	ldr r0, [sp, #8]
	add r1, r0, r1
	ldr r0, [r6, #0x20]
	sub r1, r1, r0
	ldr r0, _0215FEDC // =0x0000025A
	strh r1, [r4, r0]
_0215FE74:
	mov r0, #7
	mov r1, r5
	mul r1, r0
	mov r2, r1
	mov r0, #0xa
	mul r2, r0
	ldr r0, [sp, #0x14]
	mov r1, #0x96
	add r0, r0, r2
	lsl r1, r1, #2
	ldrsh r2, [r0, r1]
	ldr r1, [sp]
	sub r2, r2, r1
	mov r1, #0x96
	lsl r1, r1, #2
	strh r2, [r0, r1]
	add r1, r1, #4
	ldrsh r2, [r0, r1]
	ldr r1, [sp, #0x18]
	sub r2, r2, r1
	mov r1, #0x97
	lsl r1, r1, #2
	strh r2, [r0, r1]
	mov r1, #0x2a
	ldrsh r2, [r0, r1]
	ldr r1, _0215FEE0 // =0x0000048A
	strh r2, [r0, r1]
	ldr r1, [r6, #0x24]
	mov r2, r2
	add r2, r2, r1
	ldr r1, _0215FEE0 // =0x0000048A
	strh r2, [r0, r1]
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	cmp r5, #8
	blo _0215FDC4
	ldr r0, [sp, #0x1c]
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0x1c]
	cmp r0, #7
	bhs _0215FECE
	b _0215FD72
_0215FECE:
	add sp, #0x20
	pop {r4, r5, r6, pc}
	nop
_0215FED4: .word FX_SinCosTable_
_0215FED8: .word 0x00000000
_0215FEDC: .word 0x0000025A
_0215FEE0: .word 0x0000048A
	thumb_func_end SailSea__Func_215FD68

	thumb_func_start SailSea__Draw
SailSea__Draw: // 0x0215FEE4
	push {r4, lr}
	sub sp, #0xd0
	mov r4, r0
	add r1, sp, #0xc4
	mov r0, #0
	str r0, [r1]
	str r0, [r1, #4]
	ldr r3, _021600C4 // =_0218BC18
	str r0, [r1, #8]
	ldmia r3!, {r0, r1}
	add r2, sp, #0xb8
	stmia r2!, {r0, r1}
	ldr r0, [r3]
	str r0, [r2]
	add r0, sp, #0x94
	bl MTX_Identity33_
	add r0, sp, #0xb8
	bl NNS_G3dGlbSetBaseScale
	mov r0, #0x12
	ldrh r1, [r4, #0x10]
	ldrsh r0, [r4, r0]
	ldr r3, _021600C8 // =FX_SinCosTable_
	add r0, r1, r0
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	lsl r2, r0, #1
	lsl r1, r2, #1
	add r2, r2, #1
	lsl r2, r2, #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, sp, #0x94
	bl MTX_RotY33_
	ldr r1, _021600CC // =0x021472FC
	add r0, sp, #0x94
	bl MI_Copy36B
	ldr r1, _021600D0 // =0x021472C0
	mov r0, #0xa4
	ldr r2, [r1, #0x7c]
	bic r2, r0
	add r0, sp, #0xc4
	str r2, [r1, #0x7c]
	bl NNS_G3dGlbSetBaseTrans
	mov r0, #3
	str r0, [sp, #0x30]
	mov r0, #0x10
	add r1, sp, #0x30
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x64
	bl MTX_Identity43_
	add r0, sp, #0x34
	bl MTX_Identity43_
	mov r0, #0x12
	ldrh r1, [r4, #0x10]
	ldrsh r0, [r4, r0]
	ldr r3, _021600C8 // =FX_SinCosTable_
	add r0, r1, r0
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	asr r0, r0, #4
	lsl r2, r0, #1
	lsl r1, r2, #1
	add r2, r2, #1
	lsl r2, r2, #1
	ldrsh r1, [r3, r1]
	ldrsh r2, [r3, r2]
	add r0, sp, #0x64
	bl MTX_RotZ43_
	ldr r0, [r4, #0xc]
	str r0, [sp]
	add r0, sp, #0x34
	ldr r2, [r4, #4]
	ldr r3, [r4, #8]
	mov r1, r0
	bl MTX_TransApply43
	add r0, sp, #0x64
	add r1, sp, #0x34
	mov r2, r0
	bl MTX_Concat43
	mov r0, #0x17
	add r1, sp, #0x64
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	mov r2, #1
	mov r0, #0x10
	add r1, sp, #0x2c
	str r2, [sp, #0x2c]
	bl NNS_G3dGeBufferOP_N
	bl NNS_G3dGlbFlushVP
	mov r0, #2
	lsl r0, r0, #0x1c
	str r0, [sp, #0x28]
	mov r0, #0x2a
	add r1, sp, #0x28
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r1, _021600D4 // =0x00000488
	mov r0, r4
	add r1, r4, r1
	mov r2, #2
	bl SailSea__Func_2160104
	bl SailManager__GetShipType
	cmp r0, #3
	beq _0216002C
	ldr r0, _021600D8 // =0x1F0C8880
	add r1, sp, #0x24
	str r0, [sp, #0x24]
	mov r0, #0x29
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	ldr r0, _021600DC // =0x00000A5C
	mov r2, #1
	ldr r1, [r4, r0]
	ldr r0, _021600E0 // =0x0001FFFF
	and r0, r1
	lsr r0, r0, #4
	str r0, [sp, #0x20]
	mov r0, #0x2b
	add r1, sp, #0x20
	bl NNS_G3dGeBufferOP_N
	ldr r0, _021600E4 // =0x00000A54
	mov r2, #1
	ldr r1, [r4, r0]
	ldr r0, _021600E8 // =0x0007FFFF
	and r0, r1
	lsr r1, r0, #3
	ldr r0, _021600EC // =0x4DB30000
	orr r0, r1
	str r0, [sp, #0x1c]
	mov r0, #0x2a
	add r1, sp, #0x1c
	bl NNS_G3dGeBufferOP_N
	mov r1, r4
	mov r0, r4
	add r1, #0x28
	mov r2, #1
	bl SailSea__Func_2160104
_0216002C:
	ldr r0, _021600F0 // =0x1F1F8080
	add r1, sp, #0x18
	str r0, [sp, #0x18]
	mov r0, #0x29
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #0xb6
	lsl r0, r0, #4
	ldr r1, [r4, r0]
	ldr r0, _021600E0 // =0x0001FFFF
	mov r2, #1
	and r0, r1
	lsr r0, r0, #4
	str r0, [sp, #0x14]
	mov r0, #0x2b
	add r1, sp, #0x14
	bl NNS_G3dGeBufferOP_N
	ldr r0, _021600F4 // =0x00000B58
	mov r2, #1
	ldr r1, [r4, r0]
	ldr r0, _021600E8 // =0x0007FFFF
	and r0, r1
	lsr r1, r0, #3
	ldr r0, _021600EC // =0x4DB30000
	orr r0, r1
	str r0, [sp, #0x10]
	mov r0, #0x2a
	add r1, sp, #0x10
	bl NNS_G3dGeBufferOP_N
	mov r1, #0x96
	lsl r1, r1, #2
	mov r0, r4
	add r1, r4, r1
	mov r2, #0
	bl SailSea__Func_2160104
	ldr r0, _021600F8 // =0x1F1F0080
	add r1, sp, #0xc
	str r0, [sp, #0xc]
	mov r0, #0x29
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #2
	lsl r0, r0, #0x1c
	str r0, [sp, #8]
	mov r0, #0x2a
	add r1, sp, #8
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, r4
	bl SailSea__Func_21602CC
	ldr r0, _021600FC // =0x001F0083
	add r1, sp, #4
	str r0, [sp, #4]
	mov r0, #0x29
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	mov r0, #1
	bl SailSea__Func_2160534
	mov r1, #1
	str r1, [sp]
	ldr r2, _02160100 // =0x00007FFF
	mov r1, #0x1f
	mov r3, #0
	bl G3X_SetClearColor
	add sp, #0xd0
	pop {r4, pc}
	.align 2, 0
_021600C4: .word _0218BC18
_021600C8: .word FX_SinCosTable_
_021600CC: .word 0x021472FC
_021600D0: .word 0x021472C0
_021600D4: .word 0x00000488
_021600D8: .word 0x1F0C8880
_021600DC: .word 0x00000A5C
_021600E0: .word 0x0001FFFF
_021600E4: .word 0x00000A54
_021600E8: .word 0x0007FFFF
_021600EC: .word 0x4DB30000
_021600F0: .word 0x1F1F8080
_021600F4: .word 0x00000B58
_021600F8: .word 0x1F1F0080
_021600FC: .word 0x001F0083
_02160100: .word 0x00007FFF
	thumb_func_end SailSea__Draw

	thumb_func_start SailSea__Func_2160104
SailSea__Func_2160104: // 0x02160104
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x100
	str r2, [sp]
	mov r0, #0
	mov r7, r1
	ldr r3, _021602BC // =_0218BC24
	str r0, [sp, #0xc]
	add r2, sp, #0x20
	mov r1, #0x1c
_02160116:
	ldrb r0, [r3]
	add r3, r3, #1
	strb r0, [r2]
	add r2, r2, #1
	sub r1, r1, #1
	bne _02160116
	bl SailManager__GetShipType
	lsl r0, r0, #0x18
	lsr r4, r0, #0x18
	ldr r0, [sp]
	cmp r0, #2
	bne _02160144
	mov r0, #2
	bl SailSea__Func_2160534
	str r0, [sp, #0x1c]
	mov r0, #0x20
	add r1, sp, #0x1c
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	b _02160156
_02160144:
	mov r0, #0
	bl SailSea__Func_2160534
	str r0, [sp, #0x18]
	mov r0, #0x20
	add r1, sp, #0x18
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
_02160156:
	ldr r0, [sp]
	cmp r0, #1
	bne _02160162
	ldr r0, _021602C0 // =_0218BC14
	ldrb r0, [r0, r4]
	str r0, [sp, #0xc]
_02160162:
	ldr r0, [sp, #0xc]
	cmp r0, #7
	blt _0216016A
	b _021602B8
_0216016A:
	mov r0, #7
	add r1, sp, #0x20
	mul r0, r4
	add r0, r1, r0
	str r0, [sp, #8]
_02160174:
	ldr r0, [sp]
	cmp r0, #2
	bne _021601A2
	ldr r0, [sp, #0xc]
	lsl r1, r0, #2
	mov r0, #0x1f
	sub r0, r0, r1
	cmp r0, #0
	bgt _02160188
	b _021602B8
_02160188:
	lsl r1, r0, #0x10
	ldr r0, _021602C4 // =0x20000080
	mov r2, #1
	orr r0, r1
	str r0, [sp, #0x14]
	mov r0, #0x29
	add r1, sp, #0x14
	bl NNS_G3dGeBufferOP_N
	mov r0, #7
	mov r5, #0
	mov ip, r0
	b _021601B8
_021601A2:
	ldr r1, [sp, #8]
	ldr r0, [sp, #0xc]
	ldrb r1, [r1, r0]
	mov r0, #7
	sub r0, r0, r1
	lsl r0, r0, #0xf
	lsr r5, r0, #0x10
	add r0, r5, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	mov ip, r0
_021601B8:
	mov r0, ip
	sub r0, r0, r5
	cmp r0, #1
	ble _021602B8
	mov r0, ip
	mov r4, #0
	cmp r5, r0
	bhs _02160288
	ldr r0, [sp, #0xc]
	mov r1, #7
	mul r1, r0
	str r1, [sp, #4]
	add r3, sp, #0x3c
_021601D2:
	ldr r0, _021602C8 // =0x23222322
	lsl r1, r4, #2
	str r0, [r3, r1]
	add r0, r4, #1
	lsl r0, r0, #0x10
	lsr r2, r0, #0x10
	ldr r0, [sp, #4]
	mov r1, #0xa
	add r0, r5, r0
	mov r6, r0
	mul r6, r1
	add r1, r7, r6
	mov r4, #8
	mov r0, #6
	ldrsh r4, [r1, r4]
	ldrsh r0, [r1, r0]
	lsl r4, r4, #0x14
	lsl r0, r0, #0x14
	asr r4, r4, #0x10
	asr r0, r0, #0x10
	lsl r4, r4, #0x10
	lsl r0, r0, #0x10
	lsr r4, r4, #0x10
	lsr r0, r0, #0x10
	lsl r4, r4, #0x10
	orr r4, r0
	lsl r0, r2, #2
	str r4, [r3, r0]
	add r0, r2, #1
	lsl r0, r0, #0x10
	ldrh r4, [r1, #2]
	lsr r2, r0, #0x10
	ldrh r0, [r7, r6]
	lsl r4, r4, #0x10
	orr r4, r0
	lsl r0, r2, #2
	str r4, [r3, r0]
	add r0, r2, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	ldrh r2, [r1, #4]
	lsl r0, r4, #2
	str r2, [r3, r0]
	add r0, r4, #1
	lsl r0, r0, #0x10
	mov r4, #0x4e
	lsr r2, r0, #0x10
	mov r0, #0x4c
	ldrsh r4, [r1, r4]
	ldrsh r0, [r1, r0]
	lsl r4, r4, #0x14
	lsl r0, r0, #0x14
	asr r4, r4, #0x10
	asr r0, r0, #0x10
	lsl r4, r4, #0x10
	lsl r0, r0, #0x10
	lsr r4, r4, #0x10
	lsr r0, r0, #0x10
	lsl r4, r4, #0x10
	orr r4, r0
	lsl r0, r2, #2
	str r4, [r3, r0]
	add r0, r2, #1
	lsl r0, r0, #0x10
	mov r4, r1
	lsr r2, r0, #0x10
	mov r0, r1
	add r4, #0x48
	add r0, #0x46
	ldrh r4, [r4]
	ldrh r0, [r0]
	add r1, #0x4a
	lsl r4, r4, #0x10
	orr r4, r0
	lsl r0, r2, #2
	str r4, [r3, r0]
	add r0, r2, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	ldrh r2, [r1]
	lsl r1, r0, #2
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r4, r0, #0x10
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r0, ip
	str r2, [r3, r1]
	cmp r5, r0
	blo _021601D2
_02160288:
	mov r0, #3
	str r0, [sp, #0x10]
	mov r0, #0x40
	add r1, sp, #0x10
	mov r2, #1
	bl NNS_G3dGeBufferOP_N
	add r0, sp, #0x3c
	lsl r1, r4, #2
	bl NNS_G3dGeSendDL
	mov r1, #0
	mov r0, #0x41
	mov r2, r1
	bl NNS_G3dGeBufferOP_N
	ldr r0, [sp, #0xc]
	add r0, r0, #1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp, #0xc]
	cmp r0, #7
	bge _021602B8
	b _02160174
_021602B8:
	add sp, #0x100
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_021602BC: .word _0218BC24
_021602C0: .word _0218BC14
_021602C4: .word 0x20000080
_021602C8: .word 0x23222322
	thumb_func_end SailSea__Func_2160104

	thumb_func_start SailSea__Func_21602CC
SailSea__Func_21602CC: // 0x021602CC
	push {r4, r5, r6, lr}
	sub sp, #0x28
	mov r6, r0
	ldr r0, _021603D8 // =0x000006B8
	mov r1, #0
	add r4, r6, r0
	ldr r0, _021603DC // =0x24242040
	str r0, [sp]
	mov r0, #3
	str r0, [sp, #4]
	add r0, r1, #2
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r0, #2
	bl SailSea__Func_2160534
	lsl r2, r5, #2
	add r1, sp, #0
	str r0, [r1, r2]
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r0, #4
	ldrsh r0, [r4, r0]
	asr r0, r0, #6
	lsl r0, r0, #0x16
	lsr r3, r0, #2
	ldr r0, _021603D8 // =0x000006B8
	ldrsh r0, [r6, r0]
	mov r6, #2
	ldrsh r6, [r4, r6]
	asr r2, r0, #6
	ldr r0, _021603E0 // =0x000003FF
	asr r6, r6, #6
	lsl r6, r6, #0x16
	and r2, r0
	lsr r6, r6, #0xc
	orr r2, r6
	orr r3, r2
	lsl r2, r5, #2
	str r3, [r1, r2]
	add r2, r5, #1
	mov r5, #0xa
	ldrsh r5, [r4, r5]
	lsl r2, r2, #0x10
	lsr r3, r2, #0x10
	asr r5, r5, #6
	and r0, r5
	mov r5, #0xc
	mov r2, #0xe
	ldrsh r5, [r4, r5]
	ldrsh r2, [r4, r2]
	asr r5, r5, #6
	asr r2, r2, #6
	lsl r5, r5, #0x16
	lsl r2, r2, #0x16
	lsr r5, r5, #0xc
	lsr r2, r2, #2
	orr r0, r5
	orr r2, r0
	lsl r0, r3, #2
	str r2, [r1, r0]
	add r0, r3, #1
	lsl r0, r0, #0x10
	lsr r3, r0, #0x10
	ldr r2, _021603E4 // =0x41242420
	lsl r0, r3, #2
	str r2, [r1, r0]
	add r0, r3, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r0, #1
	bl SailSea__Func_2160534
	lsl r2, r5, #2
	add r1, sp, #0
	str r0, [r1, r2]
	add r0, r5, #1
	lsl r0, r0, #0x10
	lsr r5, r0, #0x10
	mov r0, #0x18
	ldrsh r0, [r4, r0]
	mov r6, #0x16
	ldrsh r6, [r4, r6]
	asr r0, r0, #6
	lsl r0, r0, #0x16
	lsr r3, r0, #2
	mov r0, #0x14
	ldrsh r0, [r4, r0]
	asr r6, r6, #6
	lsl r6, r6, #0x16
	asr r2, r0, #6
	ldr r0, _021603E0 // =0x000003FF
	lsr r6, r6, #0xc
	and r2, r0
	orr r2, r6
	orr r3, r2
	lsl r2, r5, #2
	str r3, [r1, r2]
	add r2, r5, #1
	mov r5, #0x1e
	ldrsh r5, [r4, r5]
	lsl r2, r2, #0x10
	lsr r3, r2, #0x10
	asr r5, r5, #6
	mov r2, #0x22
	and r0, r5
	ldrsh r2, [r4, r2]
	mov r5, #0x20
	ldrsh r4, [r4, r5]
	asr r2, r2, #6
	lsl r2, r2, #0x16
	asr r4, r4, #6
	lsl r4, r4, #0x16
	lsr r4, r4, #0xc
	lsr r2, r2, #2
	orr r0, r4
	orr r2, r0
	lsl r0, r3, #2
	str r2, [r1, r0]
	add r0, r3, #1
	lsl r0, r0, #0x10
	lsr r3, r0, #0x10
	mov r2, #0
	lsl r0, r3, #2
	str r2, [r1, r0]
	mov r0, r1
	add r1, r3, #1
	lsl r1, r1, #0x10
	lsr r1, r1, #0xe
	bl NNS_G3dGeSendDL
	add sp, #0x28
	pop {r4, r5, r6, pc}
	.align 2, 0
_021603D8: .word 0x000006B8
_021603DC: .word 0x24242040
_021603E0: .word 0x000003FF
_021603E4: .word 0x41242420
	thumb_func_end SailSea__Func_21602CC

	thumb_func_start SailSea__Func_21603E8
SailSea__Func_21603E8: // 0x021603E8
	push {r4, r5, r6, r7, lr}
	sub sp, #0x14
	mov r5, r0
	mov r6, r1
	str r2, [sp, #0x10]
	str r3, [sp]
	bl SailManager__GetWork
	add r0, #0x94
	ldr r4, [r0]
	ldr r0, [r5, #8]
	ldr r1, [r5]
	str r0, [sp, #4]
	mov r0, #3
	lsl r0, r0, #0x10
	add r0, r1, r0
	mov r1, #1
	lsl r1, r1, #0x10
	bl FX_Div
	asr r5, r0, #0xc
	mov r1, #6
	ldr r0, [sp, #4]
	lsl r1, r1, #0x10
	add r0, r0, r1
	mov r1, #1
	lsl r1, r1, #0x10
	bl FX_Div
	asr r3, r0, #0xc
	cmp r5, #0
	bge _0216042A
	mov r5, #0
_0216042A:
	cmp r3, #0
	bge _02160430
	mov r3, #0
_02160430:
	cmp r5, #6
	blt _02160436
	mov r5, #5
_02160436:
	cmp r3, #7
	blt _0216043C
	mov r3, #6
_0216043C:
	mov r0, #7
	mul r0, r3
	str r0, [sp, #8]
	add r2, r5, r0
	mov r0, #0xc
	mul r0, r2
	ldr r1, _021604D4 // =0x000006E8
	add r0, r4, r0
	mov ip, r0
	ldr r0, [r0, r1]
	mov r7, r1
	lsl r0, r0, #4
	str r0, [sp, #0xc]
	mov r0, #0xa
	mul r0, r2
	add r2, r4, r0
	ldr r0, _021604D8 // =0x0000025A
	sub r7, #8
	ldrsh r0, [r2, r0]
	mov r2, ip
	ldr r2, [r2, r7]
	lsl r0, r0, #4
	lsl r2, r2, #4
	str r2, [r6]
	str r0, [r6, #4]
	ldr r0, [sp, #0xc]
	add r2, r3, #1
	str r0, [r6, #8]
	mov r0, #7
	mul r0, r2
	add r0, r5, r0
	mov r2, #0xc
	mov r6, #0xa
	mul r2, r0
	mul r6, r0
	add r2, r4, r2
	ldr r3, [r2, r1]
	ldr r0, _021604D8 // =0x0000025A
	add r6, r4, r6
	ldrsh r0, [r6, r0]
	mov r6, r1
	sub r6, #8
	ldr r2, [r2, r6]
	lsl r0, r0, #4
	lsl r6, r2, #4
	ldr r2, [sp, #0x10]
	lsl r3, r3, #4
	str r6, [r2]
	str r0, [r2, #4]
	mov r0, r2
	str r3, [r0, #8]
	add r2, r5, #1
	ldr r0, [sp, #8]
	mov r5, #0xa
	add r0, r2, r0
	mov r2, #0xc
	mul r2, r0
	add r2, r4, r2
	ldr r3, [r2, r1]
	mul r5, r0
	sub r1, #8
	ldr r1, [r2, r1]
	ldr r0, _021604D8 // =0x0000025A
	add r4, r4, r5
	ldrsh r0, [r4, r0]
	lsl r2, r1, #4
	ldr r1, [sp]
	lsl r0, r0, #4
	str r2, [r1]
	str r0, [r1, #4]
	lsl r3, r3, #4
	mov r0, r1
	str r3, [r0, #8]
	mov r0, #1
	add sp, #0x14
	pop {r4, r5, r6, r7, pc}
	.align 2, 0
_021604D4: .word 0x000006E8
_021604D8: .word 0x0000025A
	thumb_func_end SailSea__Func_21603E8

	thumb_func_start SailSea__GetSurfacePosition
SailSea__GetSurfacePosition: // 0x021604DC
	push {r3, r4, r5, lr}
	sub sp, #0x58
	add r1, sp, #0x24
	add r2, sp, #0x18
	add r3, sp, #0xc
	mov r4, r0
	bl SailSea__Func_21603E8
	cmp r0, #0
	beq _0216052E
	mov r5, r4
	ldmia r5!, {r0, r1}
	add r3, sp, #0
	mov r2, r3
	stmia r3!, {r0, r1}
	ldr r0, [r5]
	str r0, [r3]
	mov r0, #1
	ldr r1, [sp, #4]
	lsl r0, r0, #0xc
	add r0, r1, r0
	str r0, [sp, #4]
	mov r1, r2
	mov r0, r4
	add r2, sp, #0x30
	bl Unknown2066510__Func_2066F88
	add r0, sp, #0x48
	add r1, sp, #0x24
	add r2, sp, #0x18
	add r3, sp, #0xc
	bl Unknown2066510__Func_2066FD0
	add r0, sp, #0x48
	add r1, sp, #0x30
	add r2, sp, #0
	bl Unknown2066510__Func_20670F8
	ldr r0, [sp, #4]
	add sp, #0x58
	pop {r3, r4, r5, pc}
_0216052E:
	mov r0, #0
	add sp, #0x58
	pop {r3, r4, r5, pc}
	thumb_func_end SailSea__GetSurfacePosition

	thumb_func_start SailSea__Func_2160534
SailSea__Func_2160534: // 0x02160534
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	mov r4, r0
	bl SailManager__GetWork
	str r0, [sp, #8]
	bl SailManager__GetWork
	add r0, #0x98
	ldr r0, [r0]
	cmp r4, #0
	str r0, [sp, #4]
	beq _02160556
	cmp r4, #1
	beq _02160600
	cmp r4, #2
	beq _0216064A
_02160556:
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02160588
	mov r0, #6
	lsl r0, r0, #0xe
	str r0, [sp, #0x14]
	mov r0, #0x1f
	lsl r0, r0, #0xc
	str r0, [sp, #0x10]
	mov r0, #0x1d
	lsl r0, r0, #0xc
	mov r1, #5
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x14]
	lsl r1, r1, #0xc
	mov r3, #1
	mov r7, #0x12
	mov r4, #0xe
	lsl r3, r3, #0x10
	lsl r7, r7, #0xc
	lsr r5, r0, #3
	lsl r4, r4, #0xc
	lsl r6, r1, #2
	b _021605A0
_02160588:
	mov r1, #0x1f
	lsl r1, r1, #0xc
	mov r3, #7
	lsl r3, r3, #0xe
	mov r5, #6
	lsl r5, r5, #0xe
	str r1, [sp, #0x14]
	str r1, [sp, #0x10]
	mov r7, r3
	str r3, [sp, #0xc]
	mov r4, r5
	mov r6, r5
_021605A0:
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _02160688
	add r0, #0xbc
	str r0, [sp, #4]
	ldr r0, [r0]
	cmp r0, #0
	beq _02160688
	ldr r2, [sp, #0x14]
	add r7, r7, r0
	add r2, r2, r0
	str r2, [sp, #0x14]
	mov r2, #0x1f
	add r4, r4, r0
	add r1, r1, r0
	add r3, r3, r0
	add r5, r5, r0
	ldr r0, [sp, #0x14]
	lsl r2, r2, #0xc
	cmp r0, r2
	ble _021605CC
	str r2, [sp, #0x14]
_021605CC:
	mov r0, #0x1f
	lsl r0, r0, #0xc
	cmp r7, r0
	ble _021605D6
	mov r7, r0
_021605D6:
	mov r0, #0x1f
	lsl r0, r0, #0xc
	cmp r4, r0
	ble _021605E0
	mov r4, r0
_021605E0:
	mov r0, #0x1f
	lsl r0, r0, #0xc
	cmp r1, r0
	ble _021605EA
	mov r1, r0
_021605EA:
	mov r0, #0x1f
	lsl r0, r0, #0xc
	cmp r3, r0
	ble _021605F4
	mov r3, r0
_021605F4:
	mov r0, #0x1f
	lsl r0, r0, #0xc
	cmp r5, r0
	ble _02160688
	mov r5, r0
	b _02160688
_02160600:
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02160626
	mov r1, #2
	lsl r1, r1, #0xe
	mov r0, #0x1f
	lsl r0, r0, #0xc
	mov r7, #0x1b
	mov r6, #3
	str r1, [sp, #0x14]
	str r0, [sp, #0x10]
	lsl r3, r1, #1
	lsl r7, r7, #0xc
	str r0, [sp, #0xc]
	lsr r5, r1, #1
	mov r4, r1
	lsl r6, r6, #0xe
	b _02160688
_02160626:
	mov r1, #2
	lsl r1, r1, #0xe
	lsl r0, r1, #1
	str r0, [sp, #0x14]
	mov r0, #6
	lsl r0, r0, #0xe
	str r0, [sp, #0x10]
	lsr r7, r0, #1
	mov r0, #0x12
	lsl r0, r0, #0xc
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x10]
	mov r4, #0xa
	ldr r3, [sp, #0x14]
	lsr r5, r0, #2
	lsl r4, r4, #0xc
	ldr r6, [sp, #0xc]
	b _02160688
_0216064A:
	bl SailManager__GetShipType
	cmp r0, #3
	beq _02160672
	mov r1, #0x1f
	lsl r1, r1, #0xc
	mov r0, #1
	lsl r0, r0, #0xe
	mov r7, #0x12
	mov r5, #3
	mov r4, #0xe
	str r1, [sp, #0x14]
	str r1, [sp, #0x10]
	mov r3, r1
	lsl r7, r7, #0xc
	str r0, [sp, #0xc]
	lsl r5, r5, #0xe
	lsl r4, r4, #0xc
	lsl r6, r0, #2
	b _02160688
_02160672:
	mov r1, #6
	lsl r1, r1, #0xc
	mov r3, #1
	lsl r3, r3, #0xe
	str r1, [sp, #0x14]
	str r1, [sp, #0x10]
	mov r7, r3
	str r3, [sp, #0xc]
	mov r5, r3
	mov r4, r3
	mov r6, r3
_02160688:
	ldr r0, [sp, #8]
	ldr r2, [r0, #0x4c]
	ldr r0, _021607B4 // =0x000002EE
	cmp r2, r0
	ble _02160758
	ble _021606CC
	ldr r0, _021607B8 // =0x0000041A
	cmp r2, r0
	bgt _021606CC
	ldr r0, _021607B4 // =0x000002EE
	sub r2, r2, r0
	mov r0, #0xd
	mul r0, r2
	lsl r0, r0, #0x10
	lsr r7, r0, #0x10
	mov r0, r1
	mov r1, r5
	mov r2, r7
	bl ObjAlphaSet
	mov r5, r0
	ldr r0, [sp, #0x14]
	mov r1, r4
	mov r2, r7
	bl ObjAlphaSet
	mov r4, r0
	ldr r0, [sp, #0x10]
	mov r1, r6
	mov r2, r7
	bl ObjAlphaSet
	mov r6, r0
	b _02160758
_021606CC:
	ldr r0, _021607BC // =0x000009F6
	cmp r2, r0
	bgt _021606DA
	mov r5, r1
	ldr r4, [sp, #0x14]
	ldr r6, [sp, #0x10]
	b _02160758
_021606DA:
	ble _02160712
	add r0, #0x96
	cmp r2, r0
	bgt _02160712
	ldr r0, _021607BC // =0x000009F6
	sub r2, r2, r0
	mov r0, #0x1b
	mul r0, r2
	lsl r0, r0, #0x10
	lsr r6, r0, #0x10
	mov r0, r3
	mov r2, r6
	bl ObjAlphaSet
	mov r5, r0
	ldr r1, [sp, #0x14]
	mov r0, r7
	mov r2, r6
	bl ObjAlphaSet
	mov r4, r0
	ldr r0, [sp, #0xc]
	ldr r1, [sp, #0x10]
	mov r2, r6
	bl ObjAlphaSet
	mov r6, r0
	b _02160758
_02160712:
	ldr r1, _021607C0 // =0x00000A8C
	cmp r2, r1
	bgt _02160720
	mov r5, r3
	mov r4, r7
	ldr r6, [sp, #0xc]
	b _02160758
_02160720:
	ble _02160758
	ldr r0, _021607C4 // =0x00000BB8
	cmp r2, r0
	bgt _02160758
	sub r1, r2, r1
	mov r0, #0xd
	mul r0, r1
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	str r0, [sp]
	ldr r2, [sp]
	mov r0, r5
	mov r1, r3
	bl ObjAlphaSet
	mov r5, r0
	ldr r2, [sp]
	mov r0, r4
	mov r1, r7
	bl ObjAlphaSet
	mov r4, r0
	ldr r1, [sp, #0xc]
	ldr r2, [sp]
	mov r0, r6
	bl ObjAlphaSet
	mov r6, r0
_02160758:
	ldr r0, [sp, #8]
	ldr r0, [r0, #0x50]
	cmp r0, #0
	beq _0216079C
	lsl r0, r0, #0x17
	lsr r2, r0, #0x10
	mov r0, #1
	lsl r0, r0, #0xc
	cmp r2, r0
	bls _0216076E
	mov r2, r0
_0216076E:
	mov r0, #1
	lsl r0, r0, #0xe
	mov r1, #0
	bl ObjAlphaSet
	sub r5, r5, r0
	sub r4, r4, r0
	sub r6, r6, r0
	mov r0, #1
	lsl r0, r0, #0xe
	cmp r5, r0
	bge _02160788
	mov r5, r0
_02160788:
	mov r0, #1
	lsl r0, r0, #0xe
	cmp r4, r0
	bge _02160792
	mov r4, r0
_02160792:
	mov r0, #1
	lsl r0, r0, #0xe
	cmp r6, r0
	bge _0216079C
	mov r6, r0
_0216079C:
	asr r0, r6, #0xc
	lsl r2, r0, #0xa
	asr r0, r4, #0xc
	asr r1, r5, #0xc
	lsl r0, r0, #5
	orr r0, r1
	orr r0, r2
	lsl r0, r0, #0x10
	lsr r0, r0, #0x10
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	nop
_021607B4: .word 0x000002EE
_021607B8: .word 0x0000041A
_021607BC: .word 0x000009F6
_021607C0: .word 0x00000A8C
_021607C4: .word 0x00000BB8
	thumb_func_end SailSea__Func_2160534

	.rodata

_0218BC14: // 0x0218BC14
    .byte 5, 4, 5, 4

_0218BC18: // 0x0218BC18
    .word 0x10000, 0x10000, 0x10000

_0218BC24: // 0x0218BC24
    .byte 7, 7, 5, 5, 5, 3, 3, 7, 7, 7, 7, 5, 5, 5, 7, 7, 5, 5, 5, 3, 3, 7, 7, 7, 7, 5, 5, 5

	.data

aSbSeaTexBac: // 0x0218CE98
	.asciz "sb_sea_tex.bac"
	.align 4