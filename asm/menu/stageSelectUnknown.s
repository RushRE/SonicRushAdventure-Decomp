	.include "asm/macros.inc"
	.include "global.inc"

	.text

	thumb_func_start StageSelectMenu__Unknown__Init
StageSelectMenu__Unknown__Init: // 0x02169A80
	push {r3, r4, r5, r6, r7, lr}
	mov r5, r0
	mov r6, r2
	mov r4, r1
	ldr r2, _02169B34 // =0x00000978
	mov r0, #0
	mov r1, r5
	mov r7, r3
	blx MIi_CpuClear16
	mov r0, #0x7d
	lsl r0, r0, #4
	mov r1, #0
	mov r2, r0
	str r1, [r5, r0]
	mov r1, #8
	add r2, #0x1c
	str r1, [r5, r2]
	mov r2, r0
	add r2, #8
	str r4, [r5, r2]
	mov r2, r0
	add r2, #0xc
	strb r6, [r5, r2]
	mov r2, r0
	add r2, #0xd
	strb r7, [r5, r2]
	lsl r2, r1, #9
	mov r1, r0
	add r1, #0x28
	strh r2, [r5, r1]
	mov r1, r0
	ldr r2, _02169B38 // =0xFFFFF000
	add r1, #0x2a
	strh r2, [r5, r1]
	mov r1, r0
	mov r2, #0xc
	add r1, #0x2c
	strh r2, [r5, r1]
	mov r1, r0
	mov r2, #3
	add r1, #0x2e
	strh r2, [r5, r1]
	mov r3, #0x10
	lsl r1, r3, #7
	strh r3, [r5, r1]
	mov r1, r0
	lsl r2, r2, #0xc
	add r1, #0x56
	strh r2, [r5, r1]
	mov r1, r0
	lsl r2, r3, #7
	add r1, #0x58
	strh r2, [r5, r1]
	mov r1, r0
	mov r2, #1
	add r1, #0x5c
	str r2, [r5, r1]
	mov r1, r0
	add r0, #0x34
	mov r2, #2
	add r1, #0x60
	add r0, r5, r0
	str r2, [r5, r1]
	blx TouchField__Init
	mov r1, #0x81
	lsl r1, r1, #4
	mov r2, #0
	str r2, [r5, r1]
	add r0, r1, #4
	strb r2, [r5, r0]
	add r0, r1, #6
	strb r2, [r5, r0]
	mov r0, r1
	add r0, #0xc
	strh r2, [r5, r0]
	mov r0, r1
	mov r2, #9
	add r0, #0xe
	strh r2, [r5, r0]
	mov r0, r1
	add r2, #0xf7
	add r0, #0x10
	strh r2, [r5, r0]
	mov r0, #0xc0
	add r1, #0x12
	strh r0, [r5, r1]
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02169B34: .word 0x00000978
_02169B38: .word 0xFFFFF000
	thumb_func_end StageSelectMenu__Unknown__Init

	thumb_func_start StageSelectMenu__Unknown__Release
StageSelectMenu__Unknown__Release: // 0x02169B3C
	push {r4, r5, r6, lr}
	mov r1, #0x7d
	mov r4, r0
	mov r2, #0
	lsl r1, r1, #4
	str r2, [r4, r1]
	bl StageSelectMenu__Unknown__Func_216A3C4
	ldr r0, _02169B70 // =0x00000834
	add r5, r4, r0
	ldr r0, _02169B74 // =0x00000978
	add r4, r4, r0
	cmp r5, r4
	beq _02169B6E
	mov r6, #0
_02169B5A:
	ldr r0, [r5]
	cmp r0, #0
	beq _02169B68
	add r0, r5, #4
	blx AnimatorSprite__Release
	str r6, [r5]
_02169B68:
	add r5, #0x6c
	cmp r5, r4
	bne _02169B5A
_02169B6E:
	pop {r4, r5, r6, pc}
	.align 2, 0
_02169B70: .word 0x00000834
_02169B74: .word 0x00000978
	thumb_func_end StageSelectMenu__Unknown__Release

	thumb_func_start StageSelectMenu__Unknown__Func_2169B78
StageSelectMenu__Unknown__Func_2169B78: // 0x02169B78
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x38
	mov r5, r0
	ldr r0, _02169CF0 // =0x000007D4
	str r1, [sp, #0x24]
	str r1, [r5, r0]
	mov r1, r0
	add r1, #0x1e
	strh r2, [r5, r1]
	mov r1, r0
	add r1, #0x1c
	ldrh r2, [r5, r1]
	mov r1, #0x19
	lsl r1, r1, #4
	mul r1, r2
	add r7, r5, r1
	mov r1, r0
	add r1, #0x4c
	ldrh r2, [r5, r1]
	mov r1, r0
	add r1, #0x48
	ldrh r1, [r5, r1]
	str r3, [sp, #0x28]
	mov r4, r5
	sub r2, r2, r1
	lsr r1, r2, #0x1f
	add r1, r2, r1
	asr r1, r1, #1
	str r1, [sp, #0x30]
	mov r1, r0
	add r1, #0x4e
	add r0, #0x4a
	ldrh r1, [r5, r1]
	ldrh r0, [r5, r0]
	sub r0, r1, r0
	str r0, [sp, #0x34]
	mov r0, #0
	str r0, [sp, #0x2c]
	cmp r5, r7
	beq _02169C06
	mov r6, r0
_02169BCA:
	ldr r0, _02169CF4 // =0x0000081C
	ldrh r1, [r5, r0]
	ldr r0, [sp, #0x30]
	add r1, r1, r0
	mov r0, r4
	add r0, #0xa2
	strh r1, [r0]
	mov r1, #0x7f
	lsl r1, r1, #4
	ldrh r1, [r5, r1]
	mov r0, r6
	sub r1, r1, #1
	blx _s32_div_f
	ldr r1, _02169CF8 // =0x0000081E
	ldrh r1, [r5, r1]
	add r1, r1, r0
	mov r0, r4
	add r0, #0xa4
	strh r1, [r0]
	mov r0, #0x19
	lsl r0, r0, #4
	add r4, r4, r0
	ldr r0, [sp, #0x34]
	add r6, r6, r0
	ldr r0, [sp, #0x2c]
	add r0, r0, #1
	str r0, [sp, #0x2c]
	cmp r4, r7
	bne _02169BCA
_02169C06:
	ldr r0, [sp, #0x24]
	mov r1, #1
	tst r0, r1
	beq _02169C40
	mov r0, r5
	mov r1, #0
	cmp r5, r7
	beq _02169C36
	mov r6, #0xa4
	mov r3, r6
	add r3, #0xec
_02169C1C:
	mov r2, #0xa2
	ldrsh r4, [r0, r2]
	mov r2, r0
	add r2, #0x40
	strh r4, [r2]
	mov r2, r0
	ldrsh r4, [r0, r6]
	add r2, #0x42
	add r0, r0, r3
	strh r4, [r2]
	add r1, r1, #1
	cmp r0, r7
	bne _02169C1C
_02169C36:
	mov r0, #0x7d
	mov r1, #2
	lsl r0, r0, #4
	str r1, [r5, r0]
	b _02169CD0
_02169C40:
	mov r4, r5
	mov r6, #0
	cmp r5, r7
	beq _02169CC8
_02169C48:
	mov r0, #0xa2
	ldrsh r1, [r4, r0]
	mov r0, r4
	add r0, #0x40
	strh r1, [r0]
	mov r0, #0xa4
	ldrsh r1, [r4, r0]
	mov r0, r4
	add r0, #0x42
	add r1, #0xc0
	strh r1, [r0]
	mov r0, #0x7f
	lsl r0, r0, #4
	ldrh r0, [r5, r0]
	add r1, r6, #1
	cmp r1, r0
	bne _02169C6E
	ldr r2, _02169CFC // =StageSelectMenu__Unknown__Func_216A668
	b _02169C70
_02169C6E:
	ldr r2, _02169D00 // =StageSelectMenu__Unknown__Func_216A754
_02169C70:
	mov r0, #0xa4
	ldrsh r3, [r4, r0]
	ldr r0, _02169D04 // =0x000007FE
	ldrh r0, [r5, r0]
	mov r1, r0
	mul r1, r6
	lsl r0, r1, #0x10
	lsr r0, r0, #0x10
	str r0, [sp]
	ldr r0, _02169D08 // =0x000007FC
	mov r1, #2
	ldrh r0, [r5, r0]
	str r0, [sp, #4]
	ldr r0, _02169D0C // =Task__Unknown204BE48__LerpValue
	str r0, [sp, #8]
	ldr r0, _02169D10 // =0x000007F8
	ldrsh r0, [r5, r0]
	str r0, [sp, #0xc]
	str r2, [sp, #0x10]
	ldr r0, _02169D14 // =0x000007DE
	str r4, [sp, #0x14]
	ldrb r0, [r5, r0]
	mov r2, r3
	add r2, #0xc0
	str r0, [sp, #0x18]
	mov r0, #0x7e
	lsl r0, r0, #4
	ldrh r0, [r5, r0]
	str r0, [sp, #0x1c]
	ldr r0, _02169D18 // =0x000007DF
	ldrb r0, [r5, r0]
	str r0, [sp, #0x20]
	mov r0, r4
	add r0, #0x42
	blx Task__Unknown204BE48__Create
	mov r1, #0x63
	lsl r1, r1, #2
	str r0, [r4, r1]
	add r0, r1, #4
	add r4, r4, r0
	add r6, r6, #1
	cmp r4, r7
	bne _02169C48
_02169CC8:
	mov r0, #0x7d
	mov r1, #1
	lsl r0, r0, #4
	str r1, [r5, r0]
_02169CD0:
	ldr r1, _02169D1C // =0x000007EC
	mov r2, #0
	mov r0, r1
	str r2, [r5, r1]
	add r0, #8
	str r2, [r5, r0]
	mov r2, r1
	ldr r0, [sp, #0x28]
	sub r2, #8
	str r0, [r5, r2]
	ldr r2, [sp, #0x50]
	sub r0, r1, #4
	str r2, [r5, r0]
	add sp, #0x38
	pop {r3, r4, r5, r6, r7, pc}
	nop
_02169CF0: .word 0x000007D4
_02169CF4: .word 0x0000081C
_02169CF8: .word 0x0000081E
_02169CFC: .word StageSelectMenu__Unknown__Func_216A668
_02169D00: .word StageSelectMenu__Unknown__Func_216A754
_02169D04: .word 0x000007FE
_02169D08: .word 0x000007FC
_02169D0C: .word Task__Unknown204BE48__LerpValue
_02169D10: .word 0x000007F8
_02169D14: .word 0x000007DE
_02169D18: .word 0x000007DF
_02169D1C: .word 0x000007EC
	thumb_func_end StageSelectMenu__Unknown__Func_2169B78

	thumb_func_start StageSelectMenu__Unknown__Func_2169D20
StageSelectMenu__Unknown__Func_2169D20: // 0x02169D20
	push {r4, lr}
	mov r4, r0
	bl StageSelectMenu__Unknown__Func_216A504
	ldr r2, _02169D50 // =0x000007EC
	ldr r0, [r4, r2]
	cmp r0, #4
	beq _02169D4C
	cmp r0, #5
	beq _02169D4C
	mov r0, #5
	str r0, [r4, r2]
	mov r0, r2
	sub r0, #8
	ldr r3, [r4, r0]
	cmp r3, #0
	beq _02169D4C
	sub r2, r2, #4
	ldr r2, [r4, r2]
	mov r0, #3
	mov r1, r4
	blx r3
_02169D4C:
	pop {r4, pc}
	nop
_02169D50: .word 0x000007EC
	thumb_func_end StageSelectMenu__Unknown__Func_2169D20

	thumb_func_start StageSelectMenu__Unknown__Process
StageSelectMenu__Unknown__Process: // 0x02169D54
	push {r3, r4, r5, r6, r7, lr}
	mov r1, #0x7d
	mov r5, r0
	lsl r1, r1, #4
	ldr r0, [r5, r1]
	cmp r0, #0
	bne _02169D64
	b _0216A00C
_02169D64:
	mov r0, r1
	add r0, #0x20
	ldrh r0, [r5, r0]
	cmp r0, #0
	beq _02169E38
	mov r0, r1
	add r0, #0x64
	add r1, #0x64
	add r2, r5, r0
	ldr r0, [r5, r1]
	cmp r0, #0
	beq _02169D86
	mov r1, #0
	add r0, r2, #4
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
_02169D86:
	ldr r0, _0216A010 // =0x0000090C
	add r1, r5, r0
	ldr r0, [r1]
	cmp r0, #0
	beq _02169D9A
	add r0, r1, #4
	mov r1, #0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
_02169D9A:
	mov r0, #0x7f
	lsl r0, r0, #4
	ldrh r1, [r5, r0]
	mov r0, #0x19
	lsl r0, r0, #4
	mul r0, r1
	add r6, r5, r0
	mov r4, r5
	cmp r5, r6
	beq _02169E22
	mov r7, #0x12
	lsl r7, r7, #4
_02169DB2:
	mov r0, r4
	add r0, #0xb4
	ldr r0, [r0]
	mov r1, r4
	add r1, #0xb4
	cmp r0, #0
	beq _02169DCA
	add r0, r1, #4
	mov r1, #0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
_02169DCA:
	mov r0, #0x12
	lsl r0, r0, #4
	add r1, r4, r0
	ldr r0, [r4, r7]
	cmp r0, #0
	beq _02169DE0
	add r0, r1, #4
	mov r1, #0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
_02169DE0:
	mov r0, r4
	add r0, #0xac
	ldr r3, [r0]
	cmp r3, #0
	beq _02169DF6
	mov r2, r4
	add r2, #0xb0
	ldr r2, [r2]
	mov r0, #5
	mov r1, r4
	blx r3
_02169DF6:
	mov r0, r4
	mov r1, #0
	add r0, #0x38
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	mov r0, r4
	add r0, #0xac
	ldr r3, [r0]
	cmp r3, #0
	beq _02169E18
	mov r2, r4
	add r2, #0xb0
	ldr r2, [r2]
	mov r0, #6
	mov r1, r4
	blx r3
_02169E18:
	mov r0, #0x19
	lsl r0, r0, #4
	add r4, r4, r0
	cmp r4, r6
	bne _02169DB2
_02169E22:
	mov r0, #0x8a
	lsl r0, r0, #4
	add r1, r5, r0
	ldr r0, [r1]
	cmp r0, #0
	beq _02169E38
	add r0, r1, #4
	mov r1, #0
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
_02169E38:
	mov r2, #0x7d
	lsl r2, r2, #4
	ldr r0, [r5, r2]
	cmp r0, #1
	beq _02169E6A
	cmp r0, #3
	beq _02169E4C
	cmp r0, #4
	bne _02169EAE
	pop {r3, r4, r5, r6, r7, pc}
_02169E4C:
	mov r0, r2
	add r0, #0x24
	ldr r0, [r5, r0]
	add r1, r0, #1
	mov r0, r2
	add r0, #0x24
	str r1, [r5, r0]
	mov r0, r2
	add r0, #0x30
	ldrh r1, [r5, r0]
	mov r0, r2
	add r0, #0x24
	ldr r0, [r5, r0]
	cmp r1, r0
	blt _02169E6C
_02169E6A:
	b _0216A00C
_02169E6C:
	mov r0, r2
	add r0, #0x14
	ldr r3, [r5, r0]
	cmp r3, #0
	beq _02169E80
	add r2, #0x18
	ldr r2, [r5, r2]
	mov r0, #2
	mov r1, r5
	blx r3
_02169E80:
	ldr r0, _0216A014 // =0x000007F2
	ldrh r1, [r5, r0]
	mov r0, #0x19
	lsl r0, r0, #4
	mov r2, r1
	mul r2, r0
	add r0, r5, r2
	add r0, #0xac
	ldr r3, [r0]
	cmp r3, #0
	beq _02169EA2
	add r1, r5, r2
	add r2, r5, r2
	add r2, #0xb0
	ldr r2, [r2]
	mov r0, #3
	blx r3
_02169EA2:
	ldr r1, _0216A018 // =0x000007D4
	mov r0, r5
	ldr r1, [r5, r1]
	bl StageSelectMenu__Unknown__Func_216A504
	pop {r3, r4, r5, r6, r7, pc}
_02169EAE:
	ldr r0, _0216A01C // =padInput
	mov r3, r2
	add r3, #0x5c
	ldrh r1, [r0, #4]
	ldr r3, [r5, r3]
	tst r3, r1
	beq _02169EC4
	mov r0, r5
	bl StageSelectMenu__Unknown__Func_216A764
	pop {r3, r4, r5, r6, r7, pc}
_02169EC4:
	mov r3, r2
	add r3, #0x60
	ldr r3, [r5, r3]
	tst r1, r3
	beq _02169ED6
	mov r0, r5
	bl StageSelectMenu__Unknown__Func_216A7CC
	pop {r3, r4, r5, r6, r7, pc}
_02169ED6:
	mov r1, r2
	add r1, #0x22
	ldrh r6, [r5, r1]
	ldr r1, _0216A020 // =touchInput
	ldrh r3, [r1, #0x12]
	mov r1, #3
	tst r1, r3
	bne _02169F38
	ldrh r1, [r0, #8]
	mov r0, #0x40
	tst r0, r1
	beq _02169F0E
	mov r0, r2
	add r0, #0x22
	ldrh r0, [r5, r0]
	sub r1, r0, #1
	mov r0, r2
	add r0, #0x22
	strh r1, [r5, r0]
	cmp r6, #0
	bne _02169F38
	mov r0, r2
	add r0, #0x20
	ldrh r0, [r5, r0]
	add r2, #0x22
	sub r0, r0, #1
	strh r0, [r5, r2]
	b _02169F38
_02169F0E:
	mov r0, #0x80
	tst r0, r1
	beq _02169F38
	mov r0, r2
	add r0, #0x22
	ldrh r0, [r5, r0]
	add r1, r0, #1
	mov r0, r2
	add r0, #0x22
	strh r1, [r5, r0]
	mov r0, r2
	add r0, #0x20
	ldrh r1, [r5, r0]
	mov r0, r2
	add r0, #0x22
	ldrh r0, [r5, r0]
	cmp r1, r0
	bhi _02169F38
	mov r0, #0
	add r2, #0x22
	strh r0, [r5, r2]
_02169F38:
	ldr r0, _0216A024 // =0x00000804
	add r0, r5, r0
	blx TouchField__Process
	ldr r0, _0216A014 // =0x000007F2
	ldrh r1, [r5, r0]
	cmp r6, r1
	beq _02169FD4
	mov r0, #0x19
	lsl r0, r0, #4
	mov r4, r1
	mul r4, r0
	add r1, r5, r4
	add r1, #0x9c
	add r0, r5, r4
	ldrh r1, [r1]
	add r0, #0x38
	blx AnimatorSprite__SetAnimation
	add r0, r5, r4
	mov r1, #0
	add r0, #0x38
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	add r0, r5, r4
	thumb_func_end StageSelectMenu__Unknown__Process

	thumb_func_start StageSelectMenu__Unknown__Func_2169F6C
StageSelectMenu__Unknown__Func_2169F6C: // 0x02169F6C
	add r0, #0xac
	ldr r3, [r0]
	cmp r3, #0
	beq _02169F80
	add r1, r5, r4
	mov r2, r1
	add r2, #0xb0
	ldr r2, [r2]
	mov r0, #0
	blx r3
_02169F80:
	mov r0, #0x19
	lsl r0, r0, #4
	mov r4, r6
	mul r4, r0
	add r1, r5, r4
	add r1, #0x9e
	add r0, r5, r4
	ldrh r1, [r1]
	add r0, #0x38
	blx AnimatorSprite__SetAnimation
	add r0, r5, r4
	mov r1, #0
	add r0, #0x38
	mov r2, r1
	blx AnimatorSprite__ProcessAnimation
	add r0, r5, r4
	add r0, #0xac
	ldr r3, [r0]
	cmp r3, #0
	beq _02169FB8
	add r1, r5, r4
	mov r2, r1
	add r2, #0xb0
	ldr r2, [r2]
	mov r0, #1
	blx r3
_02169FB8:
	ldr r2, _0216A028 // =0x00000824
	mov r0, #0
	strh r0, [r5, r2]
	mov r0, r2
	sub r0, #0x40
	ldr r3, [r5, r0]
	cmp r3, #0
	beq _0216A00C
	sub r2, #0x3c
	ldr r2, [r5, r2]
	mov r0, #6
	mov r1, r5
	blx r3
	pop {r3, r4, r5, r6, r7, pc}
_02169FD4:
	mov r1, r0
	add r1, #0x32
	ldrsh r2, [r5, r1]
	mov r1, r0
	add r1, #0x34
	ldrsh r1, [r5, r1]
	cmp r2, r1
	bge _0216A00C
	mov r1, r0
	add r1, #0x32
	ldrsh r2, [r5, r1]
	mov r1, r0
	add r1, #0x36
	ldrsh r1, [r5, r1]
	add r2, r2, r1
	mov r1, r0
	add r1, #0x32
	strh r2, [r5, r1]
	mov r1, r0
	add r1, #0x34
	ldrsh r2, [r5, r1]
	mov r1, r0
	add r1, #0x32
	ldrsh r1, [r5, r1]
	cmp r2, r1
	bge _0216A00C
	add r0, #0x32
	strh r2, [r5, r0]
_0216A00C:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216A010: .word 0x0000090C
_0216A014: .word 0x000007F2
_0216A018: .word 0x000007D4
_0216A01C: .word padInput
_0216A020: .word touchInput
_0216A024: .word 0x00000804
_0216A028: .word 0x00000824
	thumb_func_end StageSelectMenu__Unknown__Func_2169F6C

	thumb_func_start StageSelectMenu__Unknown__Draw
StageSelectMenu__Unknown__Draw: // 0x0216A02C
	push {r3, r4, r5, r6, r7, lr}
	mov r1, #0x7d
	mov r6, r0
	lsl r1, r1, #4
	ldr r0, [r6, r1]
	cmp r0, #0
	bne _0216A03C
	b _0216A1AE
_0216A03C:
	mov r0, r1
	add r0, #0x20
	ldrh r0, [r6, r0]
	cmp r0, #0
	bne _0216A048
	b _0216A1AE
_0216A048:
	mov r0, r1
	add r0, #0x22
	ldrh r2, [r6, r0]
	mov r0, #0x19
	lsl r0, r0, #4
	mul r0, r2
	add r7, r6, r0
	mov r0, r1
	add r0, #0x64
	add r1, #0x64
	add r2, r6, r0
	ldr r0, [r6, r1]
	cmp r0, #0
	beq _0216A06A
	add r0, r2, #4
	blx AnimatorSprite__DrawFrame
_0216A06A:
	mov r0, #0x7f
	lsl r0, r0, #4
	ldrh r1, [r6, r0]
	mov r0, #0x19
	lsl r0, r0, #4
	mul r0, r1
	add r0, r6, r0
	str r0, [sp]
	mov r4, r6
	cmp r6, r0
	beq _0216A13C
_0216A080:
	cmp r7, r4
	bne _0216A08C
	ldr r0, _0216A1B0 // =0x00000824
	ldrsh r0, [r6, r0]
	asr r5, r0, #0xc
	b _0216A08E
_0216A08C:
	mov r5, #0
_0216A08E:
	mov r0, #0x7d
	lsl r0, r0, #4
	ldr r0, [r6, r0]
	cmp r0, #2
	beq _0216A09C
	cmp r0, #3
	bne _0216A0CE
_0216A09C:
	cmp r7, r4
	bne _0216A0BA
	mov r0, #0xa2
	ldrsh r0, [r4, r0]
	sub r1, r0, r5
	mov r0, r4
	add r0, #0x40
	strh r1, [r0]
	mov r0, #0xa4
	ldrsh r0, [r4, r0]
	sub r1, r0, r5
	mov r0, r4
	add r0, #0x42
	strh r1, [r0]
	b _0216A0CE
_0216A0BA:
	mov r0, #0xa2
	ldrsh r1, [r4, r0]
	mov r0, r4
	add r0, #0x40
	strh r1, [r0]
	mov r0, #0xa4
	ldrsh r1, [r4, r0]
	mov r0, r4
	add r0, #0x42
	strh r1, [r0]
_0216A0CE:
	mov r0, r4
	add r0, #0x38
	blx AnimatorSprite__DrawFrame
	mov r0, r4
	add r0, #0xb4
	mov r1, r4
	ldr r0, [r0]
	add r1, #0xb4
	cmp r0, #0
	beq _0216A102
	mov r0, #0x40
	mov r2, #0x68
	ldrsh r0, [r4, r0]
	ldrsh r2, [r1, r2]
	add r0, r0, r2
	strh r0, [r1, #0xc]
	mov r0, #0x42
	mov r2, #0x6a
	ldrsh r0, [r4, r0]
	ldrsh r2, [r1, r2]
	add r0, r0, r2
	strh r0, [r1, #0xe]
	add r0, r1, #4
	blx AnimatorSprite__DrawFrame
_0216A102:
	mov r0, #0x12
	lsl r0, r0, #4
	add r1, r4, r0
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0216A130
	mov r2, #0x40
	mov r0, #0x68
	ldrsh r2, [r4, r2]
	ldrsh r0, [r1, r0]
	add r2, r2, r5
	add r0, r0, r2
	strh r0, [r1, #0xc]
	mov r2, #0x42
	mov r0, #0x6a
	ldrsh r2, [r4, r2]
	ldrsh r0, [r1, r0]
	add r2, r2, r5
	add r0, r0, r2
	strh r0, [r1, #0xe]
	add r0, r1, #4
	blx AnimatorSprite__DrawFrame
_0216A130:
	mov r0, #0x19
	lsl r0, r0, #4
	add r4, r4, r0
	ldr r0, [sp]
	cmp r4, r0
	bne _0216A080
_0216A13C:
	mov r1, #0x7d
	lsl r1, r1, #4
	ldr r0, [r6, r1]
	cmp r0, #2
	beq _0216A150
	cmp r0, #3
	beq _0216A17C
	cmp r0, #4
	beq _0216A17C
	pop {r3, r4, r5, r6, r7, pc}
_0216A150:
	mov r0, r1
	add r1, #0xd0
	add r0, #0xd0
	ldr r1, [r6, r1]
	add r0, r6, r0
	cmp r1, #0
	beq _0216A17C
	mov r1, #0xa2
	ldrsh r2, [r7, r1]
	mov r1, #0x68
	ldrsh r1, [r0, r1]
	add r1, r2, r1
	strh r1, [r0, #0xc]
	mov r1, #0xa4
	ldrsh r2, [r7, r1]
	mov r1, #0x6a
	ldrsh r1, [r0, r1]
	add r1, r2, r1
	strh r1, [r0, #0xe]
	add r0, r0, #4
	blx AnimatorSprite__DrawFrame
_0216A17C:
	ldr r0, _0216A1B4 // =0x0000090C
	add r1, r6, r0
	ldr r2, [r1]
	cmp r2, #0
	beq _0216A1AE
	sub r0, #0xe8
	mov r2, #0x68
	ldrsh r0, [r6, r0]
	ldrsh r3, [r1, r2]
	mov r2, #0x40
	ldrsh r2, [r7, r2]
	asr r0, r0, #0xc
	add r2, r2, r0
	add r2, r3, r2
	strh r2, [r1, #0xc]
	mov r2, #0x6a
	ldrsh r3, [r1, r2]
	mov r2, #0x42
	ldrsh r2, [r7, r2]
	add r0, r2, r0
	add r0, r3, r0
	strh r0, [r1, #0xe]
	add r0, r1, #4
	blx AnimatorSprite__DrawFrame
_0216A1AE:
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216A1B0: .word 0x00000824
_0216A1B4: .word 0x0000090C
	thumb_func_end StageSelectMenu__Unknown__Draw

	thumb_func_start StageSelectMenu__Unknown__Func_216A1B8
StageSelectMenu__Unknown__Func_216A1B8: // 0x0216A1B8
	push {r3, r4}
	ldr r4, _0216A1D4 // =0x0000081C
	strh r1, [r0, r4]
	add r1, r4, #2
	strh r2, [r0, r1]
	add r1, r4, #4
	strh r3, [r0, r1]
	ldr r1, _0216A1D8 // =0xFFFFFFF8
	add r1, sp
	ldrh r2, [r1, #0x10]
	add r1, r4, #6
	strh r2, [r0, r1]
	pop {r3, r4}
	bx lr
	.align 2, 0
_0216A1D4: .word 0x0000081C
_0216A1D8: .word 0xFFFFFFF8
	thumb_func_end StageSelectMenu__Unknown__Func_216A1B8

	thumb_func_start StageSelectMenu__Unknown__Func_216A1DC
StageSelectMenu__Unknown__Func_216A1DC: // 0x0216A1DC
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	str r1, [sp, #0x14]
	mov r1, #0x7f
	mov r5, r0
	str r3, [sp, #0x18]
	lsl r1, r1, #4
	ldrh r6, [r5, r1]
	mov r0, #0x19
	lsl r0, r0, #4
	mov r4, r6
	mul r4, r0
	add r0, r5, r4
	add r0, #0x9c
	strh r2, [r0]
	add r6, r5, r4
	ldr r0, [sp, #0x18]
	add r6, #0x9e
	strh r0, [r6]
	add r0, sp, #0x28
	ldrh r6, [r0, #0x10]
	add r0, r5, r4
	add r0, #0xa0
	strh r6, [r0]
	add r0, r5, r4
	add r0, #0xa8
	str r5, [r0]
	add r7, r5, r4
	ldr r0, [sp, #0x50]
	add r7, #0xac
	str r0, [r7]
	add r7, r5, r4
	ldr r0, [sp, #0x54]
	add r7, #0xb0
	str r0, [r7]
	mov r0, #0
	str r6, [sp]
	mvn r0, r0
	str r0, [sp, #4]
	sub r1, #0x18
	ldr r0, [sp, #0x14]
	ldr r1, [r5, r1]
	bl StageSelectMenu__Func_215E8EC
	ldr r3, _0216A2C0 // =0x000007D8
	ldr r1, [r5, r3]
	str r1, [sp]
	str r0, [sp, #4]
	add r0, sp, #0x28
	ldrb r0, [r0, #0x14]
	str r0, [sp, #8]
	add r0, r3, #4
	ldrb r0, [r5, r0]
	str r0, [sp, #0xc]
	add r0, r3, #5
	ldrb r1, [r5, r0]
	mov r0, r3
	add r0, #0x18
	ldrh r0, [r5, r0]
	add r3, #0x2c
	lsl r0, r0, #1
	add r0, r1, r0
	add r0, r0, #2
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #0x10]
	add r0, r5, r4
	ldr r1, [sp, #0x14]
	ldr r2, [sp, #0x18]
	add r0, #0x38
	blx SpriteUnknown__Func_204C90C
	ldr r0, _0216A2C4 // =StageSelectMenu__Unknown__Func_216A634
	mov r2, #0
	str r0, [sp]
	add r0, r5, r4
	mov r1, r0
	add r1, #0x38
	mov r3, r2
	str r5, [sp, #4]
	blx TouchField__InitAreaSprite
	add r0, sp, #0x28
	mov r1, #0x18
	ldrsh r1, [r0, r1]
	add r2, sp, #0x1c
	strh r1, [r2]
	mov r1, #0x1c
	ldrsh r1, [r0, r1]
	strh r1, [r2, #2]
	mov r1, #0x20
	ldrsh r1, [r0, r1]
	strh r1, [r2, #4]
	mov r1, #0x24
	ldrsh r0, [r0, r1]
	add r1, sp, #0x1c
	strh r0, [r2, #6]
	add r0, r5, r4
	blx TouchField__SetAreaHitbox
	ldr r0, _0216A2C8 // =0x00000804
	ldr r2, _0216A2CC // =0x0000FFFF
	add r0, r5, r0
	add r1, r5, r4
	blx TouchField__AddArea
	mov r1, #0x7f
	lsl r1, r1, #4
	ldrh r0, [r5, r1]
	add r2, r0, #1
	strh r2, [r5, r1]
	add sp, #0x24
	pop {r4, r5, r6, r7, pc}
	nop
_0216A2C0: .word 0x000007D8
_0216A2C4: .word StageSelectMenu__Unknown__Func_216A634
_0216A2C8: .word 0x00000804
_0216A2CC: .word 0x0000FFFF
	thumb_func_end StageSelectMenu__Unknown__Func_216A1DC

	thumb_func_start StageSelectMenu__Unknown__Func_216A2D0
StageSelectMenu__Unknown__Func_216A2D0: // 0x0216A2D0
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	mov r5, r0
	mov r0, #0x19
	mov r6, r1
	lsl r0, r0, #4
	mul r0, r6
	add r4, r5, r0
	add r0, r5, r0
	str r3, [sp, #0x14]
	mov r1, #1
	add r0, #0xb4
	str r1, [r0]
	mov r7, r2
	ldr r1, _0216A344 // =0x000007D8
	ldr r2, [sp, #0x14]
	ldr r1, [r5, r1]
	mov r0, r7
	add r4, #0xb4
	blx SpriteUnknown__Func_204C3CC
	ldr r3, _0216A344 // =0x000007D8
	ldr r1, [r5, r3]
	str r1, [sp]
	str r0, [sp, #4]
	add r0, sp, #0x20
	ldrb r0, [r0, #0x10]
	str r0, [sp, #8]
	add r0, r3, #4
	ldrb r0, [r5, r0]
	str r0, [sp, #0xc]
	add r0, r3, #5
	ldrb r1, [r5, r0]
	lsl r0, r6, #1
	add r3, #0x2c
	add r0, r1, r0
	add r0, r0, #1
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #0x10]
	ldr r2, [sp, #0x14]
	add r0, r4, #4
	mov r1, r7
	blx SpriteUnknown__Func_204C90C
	add r1, sp, #0x20
	mov r0, #0x14
	ldrsh r2, [r1, r0]
	mov r0, r4
	add r0, #0x68
	strh r2, [r0]
	mov r0, #0x18
	ldrsh r0, [r1, r0]
	add r4, #0x6a
	strh r0, [r4]
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216A344: .word 0x000007D8
	thumb_func_end StageSelectMenu__Unknown__Func_216A2D0

	thumb_func_start StageSelectMenu__Unknown__Func_216A348
StageSelectMenu__Unknown__Func_216A348: // 0x0216A348
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	mov r7, r2
	mov r2, #0x19
	mov r6, r1
	mov r5, r0
	lsl r2, r2, #4
	mov r0, r6
	mul r0, r2
	mov r1, r2
	add r0, r5, r0
	sub r1, #0x70
	add r4, r0, r1
	str r3, [sp, #0x14]
	mov r1, #1
	sub r2, #0x70
	str r1, [r0, r2]
	ldr r1, _0216A3C0 // =0x000007D8
	ldr r2, [sp, #0x14]
	ldr r1, [r5, r1]
	mov r0, r7
	blx SpriteUnknown__Func_204C3CC
	ldr r3, _0216A3C0 // =0x000007D8
	ldr r1, [r5, r3]
	str r1, [sp]
	str r0, [sp, #4]
	add r0, sp, #0x20
	ldrb r0, [r0, #0x10]
	str r0, [sp, #8]
	add r0, r3, #4
	ldrb r0, [r5, r0]
	str r0, [sp, #0xc]
	add r0, r3, #5
	ldrb r1, [r5, r0]
	lsl r0, r6, #1
	add r3, #0x2c
	add r0, r1, r0
	add r0, r0, #1
	lsl r0, r0, #0x18
	lsr r0, r0, #0x18
	str r0, [sp, #0x10]
	ldr r2, [sp, #0x14]
	add r0, r4, #4
	mov r1, r7
	blx SpriteUnknown__Func_204C90C
	add r1, sp, #0x20
	mov r0, #0x14
	ldrsh r2, [r1, r0]
	mov r0, r4
	add r0, #0x68
	strh r2, [r0]
	mov r0, #0x18
	ldrsh r0, [r1, r0]
	add r4, #0x6a
	strh r0, [r4]
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216A3C0: .word 0x000007D8
	thumb_func_end StageSelectMenu__Unknown__Func_216A348

	thumb_func_start StageSelectMenu__Unknown__Func_216A3C4
StageSelectMenu__Unknown__Func_216A3C4: // 0x0216A3C4
	push {r3, r4, r5, r6, r7, lr}
	mov r6, r0
	mov r0, #0x7f
	lsl r0, r0, #4
	ldrh r1, [r6, r0]
	cmp r1, #0
	beq _0216A454
	mov r0, #0x19
	lsl r0, r0, #4
	mul r0, r1
	add r7, r6, r0
	mov r4, r6
	cmp r6, r7
	beq _0216A448
_0216A3E0:
	mov r1, r4
	add r1, #0xa8
	mov r0, #0
	str r0, [r1]
	mov r0, #0x63
	lsl r0, r0, #2
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0216A3FE
	blx DestroyTask
	mov r0, #0x63
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r4, r0]
_0216A3FE:
	ldr r0, _0216A458 // =0x00000804
	mov r1, r4
	add r0, r6, r0
	blx TouchField__RemoveArea
	mov r0, r4
	add r0, #0xb4
	mov r5, r4
	ldr r0, [r0]
	add r5, #0xb4
	cmp r0, #0
	beq _0216A420
	add r0, r5, #4
	blx AnimatorSprite__Release
	mov r0, #0
	str r0, [r5]
_0216A420:
	mov r0, #0x12
	lsl r0, r0, #4
	add r5, r4, r0
	ldr r0, [r4, r0]
	cmp r0, #0
	beq _0216A436
	add r0, r5, #4
	blx AnimatorSprite__Release
	mov r0, #0
	str r0, [r5]
_0216A436:
	mov r0, r4
	add r0, #0x38
	blx AnimatorSprite__Release
	mov r0, #0x19
	lsl r0, r0, #4
	add r4, r4, r0
	cmp r4, r7
	bne _0216A3E0
_0216A448:
	mov r0, #0x7f
	mov r1, #0
	lsl r0, r0, #4
	strh r1, [r6, r0]
	add r0, r0, #2
	strh r1, [r6, r0]
_0216A454:
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216A458: .word 0x00000804
	thumb_func_end StageSelectMenu__Unknown__Func_216A3C4

	thumb_func_start StageSelectMenu__Unknown__SetAnimator
StageSelectMenu__Unknown__SetAnimator: // 0x0216A45C
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x18
	mov r7, r2
	mov r5, r0
	str r3, [sp, #0x14]
	ldr r2, _0216A4E8 // =0x00000834
	mov r0, r1
	mov r3, #0x6c
	add r1, r5, r2
	mul r3, r0
	add r4, r1, r3
	cmp r0, #0
	beq _0216A480
	cmp r0, #1
	beq _0216A48C
	cmp r0, #2
	beq _0216A492
	b _0216A49C
_0216A480:
	sub r2, #0x57
	ldrb r0, [r5, r2]
	add r0, #0xc
	lsl r0, r0, #0x18
	lsr r6, r0, #0x18
	b _0216A49C
_0216A48C:
	sub r2, #0x57
	ldrb r6, [r5, r2]
	b _0216A49C
_0216A492:
	sub r2, #0x57
	ldrb r0, [r5, r2]
	add r0, #0xb
	lsl r0, r0, #0x18
	lsr r6, r0, #0x18
_0216A49C:
	mov r0, #1
	str r0, [r4]
	ldr r1, _0216A4EC // =0x000007D8
	ldr r2, [sp, #0x14]
	ldr r1, [r5, r1]
	mov r0, r7
	blx SpriteUnknown__Func_204C3CC
	ldr r3, _0216A4EC // =0x000007D8
	ldr r1, [r5, r3]
	str r1, [sp]
	str r0, [sp, #4]
	add r0, sp, #0x20
	ldrb r0, [r0, #0x10]
	mov r1, r7
	str r0, [sp, #8]
	add r0, r3, #4
	ldrb r0, [r5, r0]
	add r3, #0x2c
	str r0, [sp, #0xc]
	str r6, [sp, #0x10]
	ldr r2, [sp, #0x14]
	add r0, r4, #4
	blx SpriteUnknown__Func_204C90C
	add r1, sp, #0x20
	mov r0, #0x14
	ldrsh r2, [r1, r0]
	mov r0, r4
	add r0, #0x68
	strh r2, [r0]
	mov r0, #0x18
	ldrsh r0, [r1, r0]
	add r4, #0x6a
	strh r0, [r4]
	add sp, #0x18
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216A4E8: .word 0x00000834
_0216A4EC: .word 0x000007D8
	thumb_func_end StageSelectMenu__Unknown__SetAnimator

	thumb_func_start StageSelectMenu__Unknown__Func_216A4F0
StageSelectMenu__Unknown__Func_216A4F0: // 0x0216A4F0
	ldr r1, _0216A500 // =0x0000082C
	mov r2, #1
	str r2, [r0, r1]
	mov r2, #2
	add r1, r1, #4
	str r2, [r0, r1]
	bx lr
	nop
_0216A500: .word 0x0000082C
	thumb_func_end StageSelectMenu__Unknown__Func_216A4F0

	thumb_func_start StageSelectMenu__Unknown__Func_216A504
StageSelectMenu__Unknown__Func_216A504: // 0x0216A504
	push {r3, r4, r5, r6, r7, lr}
	sub sp, #0x28
	mov r5, r0
	mov r0, #0x7f
	lsl r0, r0, #4
	ldrh r3, [r5, r0]
	add r0, r0, #2
	mov r2, #0x19
	ldrh r0, [r5, r0]
	lsl r2, r2, #4
	mov r4, r3
	mul r4, r2
	mul r2, r0
	add r0, r5, r2
	str r0, [sp, #0x24]
	mov r0, #2
	add r7, r5, r4
	tst r0, r1
	beq _0216A560
	mov r1, r5
	mov r2, #0
	cmp r5, r7
	beq _0216A554
	mov r4, #0xa4
	mov r0, r4
	add r0, #0xec
_0216A538:
	mov r3, #0xa2
	ldrsh r6, [r1, r3]
	mov r3, r1
	add r3, #0x40
	strh r6, [r3]
	ldrsh r6, [r1, r4]
	mov r3, r1
	add r3, #0x42
	add r6, #0xc0
	add r1, r1, r0
	strh r6, [r3]
	add r2, r2, #1
	cmp r1, r7
	bne _0216A538
_0216A554:
	mov r0, #0x7d
	mov r1, #0
	lsl r0, r0, #4
	add sp, #0x28
	str r1, [r5, r0]
	pop {r3, r4, r5, r6, r7, pc}
_0216A560:
	mov r4, r5
	mov r6, #0
	cmp r5, r7
	beq _0216A604
_0216A568:
	ldr r0, [sp, #0x24]
	cmp r0, r4
	bne _0216A588
	ldr r0, _0216A610 // =0x00000824
	mov r1, #0xa2
	ldrsh r0, [r5, r0]
	ldrsh r1, [r4, r1]
	asr r0, r0, #0xc
	sub r2, r1, r0
	mov r1, r4
	add r1, #0x40
	strh r2, [r1]
	mov r1, #0xa4
	ldrsh r1, [r4, r1]
	sub r1, r1, r0
	b _0216A596
_0216A588:
	mov r0, #0xa2
	ldrsh r1, [r4, r0]
	mov r0, r4
	add r0, #0x40
	strh r1, [r0]
	mov r0, #0xa4
	ldrsh r1, [r4, r0]
_0216A596:
	mov r0, r4
	add r0, #0x42
	strh r1, [r0]
	cmp r6, #0
	bne _0216A5A4
	ldr r0, _0216A614 // =StageSelectMenu__Unknown__Func_216A6E4
	b _0216A5A6
_0216A5A4:
	ldr r0, _0216A618 // =StageSelectMenu__Unknown__Func_216A754
_0216A5A6:
	mov r1, #0x42
	ldrsh r3, [r4, r1]
	ldr r1, _0216A61C // =0x000007FE
	ldrh r2, [r5, r1]
	sub r1, #0xe
	ldrh r1, [r5, r1]
	sub r1, r1, #1
	sub r1, r1, r6
	mul r1, r2
	lsl r1, r1, #0x10
	lsr r1, r1, #0x10
	str r1, [sp]
	ldr r1, _0216A620 // =0x000007FC
	mov r2, r3
	ldrh r1, [r5, r1]
	add r3, #0xc0
	str r1, [sp, #4]
	ldr r1, _0216A624 // =Task__Unknown204BE48__LerpValue
	str r1, [sp, #8]
	ldr r1, _0216A628 // =0x000007FA
	ldrsh r1, [r5, r1]
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	ldr r0, _0216A62C // =0x000007DE
	str r4, [sp, #0x14]
	ldrb r0, [r5, r0]
	mov r1, #2
	str r0, [sp, #0x18]
	mov r0, #0x7e
	lsl r0, r0, #4
	ldrh r0, [r5, r0]
	str r0, [sp, #0x1c]
	ldr r0, _0216A630 // =0x000007DF
	ldrb r0, [r5, r0]
	str r0, [sp, #0x20]
	mov r0, r4
	add r0, #0x42
	blx Task__Unknown204BE48__Create
	mov r1, #0x63
	lsl r1, r1, #2
	str r0, [r4, r1]
	add r0, r1, #4
	add r4, r4, r0
	add r6, r6, #1
	cmp r4, r7
	bne _0216A568
_0216A604:
	mov r0, #0x7d
	mov r1, #4
	lsl r0, r0, #4
	str r1, [r5, r0]
	add sp, #0x28
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216A610: .word 0x00000824
_0216A614: .word StageSelectMenu__Unknown__Func_216A6E4
_0216A618: .word StageSelectMenu__Unknown__Func_216A754
_0216A61C: .word 0x000007FE
_0216A620: .word 0x000007FC
_0216A624: .word Task__Unknown204BE48__LerpValue
_0216A628: .word 0x000007FA
_0216A62C: .word 0x000007DE
_0216A630: .word 0x000007DF
	thumb_func_end StageSelectMenu__Unknown__Func_216A504

	thumb_func_start StageSelectMenu__Unknown__Func_216A634
StageSelectMenu__Unknown__Func_216A634: // 0x0216A634
	push {r3, r4, r5, lr}
	mov r5, r1
	ldr r1, [r0]
	mov r0, #1
	lsl r0, r0, #0x12
	mov r4, r2
	cmp r1, r0
	beq _0216A64C
	lsl r0, r0, #4
	cmp r1, r0
	beq _0216A652
	pop {r3, r4, r5, pc}
_0216A64C:
	mov r0, r4
	bl StageSelectMenu__Unknown__Func_216A764
_0216A652:
	mov r1, #0x19
	sub r0, r5, r4
	lsl r1, r1, #4
	blx _s32_div_f
	ldr r1, _0216A664 // =0x000007F2
	strh r0, [r4, r1]
	pop {r3, r4, r5, pc}
	nop
_0216A664: .word 0x000007F2
	thumb_func_end StageSelectMenu__Unknown__Func_216A634

	thumb_func_start StageSelectMenu__Unknown__Func_216A668
StageSelectMenu__Unknown__Func_216A668: // 0x0216A668
	push {r3, r4, r5, r6, r7, lr}
	str r2, [sp]
	add r2, #0xa8
	mov r6, r0
	mov r7, r1
	ldr r5, [r2]
	cmp r6, #5
	bne _0216A6CE
	ldr r0, _0216A6DC // =0x000007F2
	ldrh r1, [r5, r0]
	mov r0, #0x19
	lsl r0, r0, #4
	mov r4, r1
	mul r4, r0
	add r1, r5, r4
	add r1, #0x9c
	ldrh r1, [r1]
	add r0, r5, r4
	add r0, #0x38
	blx AnimatorSprite__SetAnimation
	add r0, r5, r4
	add r0, #0xac
	ldr r3, [r0]
	cmp r3, #0
	beq _0216A6A8
	add r1, r5, r4
	mov r2, r1
	add r2, #0xb0
	ldr r2, [r2]
	mov r0, #0
	blx r3
_0216A6A8:
	ldr r2, _0216A6E0 // =0x00000824
	mov r0, #0
	mov r1, r2
	strh r0, [r5, r2]
	mov r3, #2
	sub r1, #0x54
	str r3, [r5, r1]
	mov r1, r2
	sub r1, #0x30
	str r0, [r5, r1]
	mov r1, r2
	sub r1, #0x40
	ldr r3, [r5, r1]
	cmp r3, #0
	beq _0216A6CE
	sub r2, #0x3c
	ldr r2, [r5, r2]
	mov r1, r5
	blx r3
_0216A6CE:
	ldr r2, [sp]
	mov r0, r6
	mov r1, r7
	bl StageSelectMenu__Unknown__Func_216A754
	pop {r3, r4, r5, r6, r7, pc}
	nop
_0216A6DC: .word 0x000007F2
_0216A6E0: .word 0x00000824
	thumb_func_end StageSelectMenu__Unknown__Func_216A668

	thumb_func_start StageSelectMenu__Unknown__Func_216A6E4
StageSelectMenu__Unknown__Func_216A6E4: // 0x0216A6E4
	push {r3, r4, r5, r6, r7, lr}
	mov r7, r2
	mov r5, r0
	mov r0, r7
	add r0, #0xa8
	mov r6, r1
	ldr r4, [r0]
	cmp r5, #5
	bne _0216A744
	ldr r1, _0216A750 // =0x000007F2
	mov r2, #0x19
	ldrh r0, [r4, r1]
	lsl r2, r2, #4
	mul r2, r0
	sub r0, r1, #6
	ldr r0, [r4, r0]
	cmp r0, #5
	beq _0216A71E
	add r0, r4, r2
	add r0, #0xac
	ldr r3, [r0]
	cmp r3, #0
	beq _0216A71E
	add r1, r4, r2
	add r2, r4, r2
	add r2, #0xb0
	ldr r2, [r2]
	mov r0, #4
	blx r3
_0216A71E:
	mov r2, #0x7d
	lsl r2, r2, #4
	mov r1, #0
	mov r0, r2
	str r1, [r4, r2]
	add r0, #0x24
	str r1, [r4, r0]
	mov r0, r2
	add r0, #0x14
	ldr r3, [r4, r0]
	cmp r3, #0
	beq _0216A744
	mov r0, r2
	add r0, #0x1c
	add r2, #0x18
	ldr r0, [r4, r0]
	ldr r2, [r4, r2]
	mov r1, r4
	blx r3
_0216A744:
	mov r0, r5
	mov r1, r6
	mov r2, r7
	bl StageSelectMenu__Unknown__Func_216A754
	pop {r3, r4, r5, r6, r7, pc}
	.align 2, 0
_0216A750: .word 0x000007F2
	thumb_func_end StageSelectMenu__Unknown__Func_216A6E4

	thumb_func_start StageSelectMenu__Unknown__Func_216A754
StageSelectMenu__Unknown__Func_216A754: // 0x0216A754
	cmp r0, #5
	bne _0216A760
	mov r0, #0x63
	mov r1, #0
	lsl r0, r0, #2
	str r1, [r2, r0]
_0216A760:
	bx lr
	.align 2, 0
	thumb_func_end StageSelectMenu__Unknown__Func_216A754

	thumb_func_start StageSelectMenu__Unknown__Func_216A764
StageSelectMenu__Unknown__Func_216A764: // 0x0216A764
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0216A7C4 // =0x000007F2
	ldrh r1, [r5, r0]
	mov r0, #0x19
	lsl r0, r0, #4
	mov r4, r1
	mul r4, r0
	add r1, r5, r4
	add r1, #0xa0
	add r0, r5, r4
	ldrh r1, [r1]
	add r0, #0x38
	blx AnimatorSprite__SetAnimation
	add r0, r5, r4
	add r0, #0xac
	ldr r3, [r0]
	cmp r3, #0
	beq _0216A798
	add r1, r5, r4
	mov r2, r1
	add r2, #0xb0
	ldr r2, [r2]
	mov r0, #2
	blx r3
_0216A798:
	ldr r2, _0216A7C8 // =0x000007EC
	mov r0, #4
	str r0, [r5, r2]
	mov r0, r2
	mov r1, #3
	sub r0, #0x1c
	str r1, [r5, r0]
	mov r0, r2
	mov r1, #0
	add r0, #8
	str r1, [r5, r0]
	mov r0, r2
	sub r0, #8
	ldr r3, [r5, r0]
	cmp r3, #0
	beq _0216A7C2
	sub r2, r2, #4
	ldr r2, [r5, r2]
	mov r0, #1
	mov r1, r5
	blx r3
_0216A7C2:
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216A7C4: .word 0x000007F2
_0216A7C8: .word 0x000007EC
	thumb_func_end StageSelectMenu__Unknown__Func_216A764

	thumb_func_start StageSelectMenu__Unknown__Func_216A7CC
StageSelectMenu__Unknown__Func_216A7CC: // 0x0216A7CC
	push {r3, r4, r5, lr}
	mov r5, r0
	ldr r0, _0216A82C // =0x000007F2
	ldrh r1, [r5, r0]
	mov r0, #0x19
	lsl r0, r0, #4
	mov r4, r1
	mul r4, r0
	add r1, r5, r4
	add r1, #0x9e
	add r0, r5, r4
	ldrh r1, [r1]
	add r0, #0x38
	blx AnimatorSprite__SetAnimation
	add r0, r5, r4
	add r0, #0xac
	ldr r3, [r0]
	cmp r3, #0
	beq _0216A800
	add r1, r5, r4
	mov r2, r1
	add r2, #0xb0
	ldr r2, [r2]
	mov r0, #1
	blx r3
_0216A800:
	ldr r1, _0216A830 // =0x00000824
	mov r0, #0
	strh r0, [r5, r1]
	sub r1, #0x50
	ldr r1, [r5, r1]
	mov r0, r5
	bl StageSelectMenu__Unknown__Func_216A504
	ldr r2, _0216A834 // =0x000007EC
	mov r0, #5
	str r0, [r5, r2]
	mov r0, r2
	sub r0, #8
	ldr r3, [r5, r0]
	cmp r3, #0
	beq _0216A82A
	sub r2, r2, #4
	ldr r2, [r5, r2]
	mov r0, #3
	mov r1, r5
	blx r3
_0216A82A:
	pop {r3, r4, r5, pc}
	.align 2, 0
_0216A82C: .word 0x000007F2
_0216A830: .word 0x00000824
_0216A834: .word 0x000007EC
	thumb_func_end StageSelectMenu__Unknown__Func_216A7CC
