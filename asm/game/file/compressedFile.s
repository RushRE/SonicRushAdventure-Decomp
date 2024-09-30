	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start CompressedFile__Decompress
CompressedFile__Decompress: // 0x0205B6E8
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r10, r1
	mov r9, r2
	mov r7, #0
	mov r8, #1
	bl CompressedFile__GetCompressedSize
	mov r11, r0
	mov r0, r10
	mov r1, r11
	bl CompressedFile__AllocateMemIfNeeded
	mov r10, r0
	mov r0, r4
	bl CompressedFile__IsVisAnim
	cmp r0, #0
	beq _0205B76C
	mov r0, r4
	bl CompressedFile__GetVisCompressCount
	mov r8, r0
	cmp r8, #1
	bls _0205B76C
	cmp r9, #0
	mvnne r0, #0
	cmpne r9, r0
	bne _0205B76C
	mov r0, r4
	bl CompressedFile__Func_205B898
	mov r1, r0
	mov r0, r9
	bl CompressedFile__AllocateMemIfNeeded
	mov r9, r0
	mov r7, #1
_0205B76C:
	cmp r8, #0
	bne _0205B78C
	mov r0, r4
	bl CompressedFile__Func_205B8C0
	mov r1, r10
	mov r2, r11
	bl RenderCore_CPUCopy
	b _0205B7CC
_0205B78C:
	tst r8, #1
	mov r0, r4
	beq _0205B7B4
	bl CompressedFile__Func_205B8C0
	mov r1, r10
	mov r2, #2
	bl CompressedFile__HandleDecompression2
	str r10, [sp, #4]
	str r9, [sp]
	b _0205B7CC
_0205B7B4:
	bl CompressedFile__Func_205B8C0
	mov r1, r9
	mov r2, #2
	bl CompressedFile__HandleDecompression2
	str r9, [sp, #4]
	str r10, [sp]
_0205B7CC:
	subs r8, r8, #1
	beq _0205B81C
	ldr r0, [sp, #4]
	mov r6, #2
	add r5, sp, #4
	add r4, sp, #0
_0205B7E4:
	bl CompressedFile__Func_205B8C0
	ldr r1, [sp]
	mov r2, r6
	bl CompressedFile__HandleDecompression2
	ldr r2, [r5, #0]
	ldr r1, [sp]
	ldr r0, [r4, #0]
	eor r2, r2, r1
	eor r1, r0, r2
	eor r0, r2, r1
	str r1, [r4]
	str r0, [r5]
	subs r8, r8, #1
	bne _0205B7E4
_0205B81C:
	cmp r7, #0
	beq _0205B82C
	mov r0, r9
	bl _FreeHEAP_USER
_0205B82C:
	mov r0, r10
	mov r1, r11
	bl DC_StoreRange
	mov r0, r10
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end CompressedFile__Decompress

	arm_func_start CompressedFile__IsVisAnim
CompressedFile__IsVisAnim: // 0x0205B844
	ldr r1, [r0, #0]
	ldr r0, _0205B85C // =0x00534956
	cmp r1, r0
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_0205B85C: .word 0x00534956
	arm_func_end CompressedFile__IsVisAnim

	arm_func_start CompressedFile__GetVisCompressCount
CompressedFile__GetVisCompressCount: // 0x0205B860
	ldr r0, [r0, #4]
	mov r0, r0, lsl #4
	mov r0, r0, lsr #0x1c
	and r0, r0, #0xff
	bx lr
	arm_func_end CompressedFile__GetVisCompressCount

	arm_func_start CompressedFile__GetCompressedSize
CompressedFile__GetCompressedSize: // 0x0205B874
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl CompressedFile__IsVisAnim
	cmp r0, #0
	ldrne r0, [r4, #4]
	movne r0, r0, lsl #8
	ldreq r0, [r4, #0]
	mov r0, r0, lsr #8
	ldmia sp!, {r4, pc}
	arm_func_end CompressedFile__GetCompressedSize

	arm_func_start CompressedFile__Func_205B898
CompressedFile__Func_205B898: // 0x0205B898
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl CompressedFile__IsVisAnim
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #8]
	mov r0, r0, lsl #8
	mov r0, r0, lsr #8
	ldmia sp!, {r4, pc}
	arm_func_end CompressedFile__Func_205B898

	arm_func_start CompressedFile__Func_205B8C0
CompressedFile__Func_205B8C0: // 0x0205B8C0
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl CompressedFile__IsVisAnim
	cmp r0, #0
	addne r4, r4, #0xc
	mov r0, r4
	ldmia sp!, {r4, pc}
	arm_func_end CompressedFile__Func_205B8C0

	arm_func_start CompressedFile__AllocateMemIfNeeded
CompressedFile__AllocateMemIfNeeded: // 0x0205B8DC
	stmdb sp!, {r3, lr}
	cmp r0, #0
	beq _0205B8F8
	mvn r2, #0
	cmp r0, r2
	beq _0205B904
	ldmia sp!, {r3, pc}
_0205B8F8:
	mov r0, r1
	bl _AllocHeadHEAP_USER
	ldmia sp!, {r3, pc}
_0205B904:
	mov r0, r1
	bl _AllocTailHEAP_USER
	ldmia sp!, {r3, pc}
	arm_func_end CompressedFile__AllocateMemIfNeeded

	arm_func_start CompressedFile__HandleDecompression2
CompressedFile__HandleDecompression2: // 0x0205B910
	ldr ip, _0205B918 // =CompressedFile__HandleDecompression
	bx ip
	.align 2, 0
_0205B918: .word CompressedFile__HandleDecompression
	arm_func_end CompressedFile__HandleDecompression2

	arm_func_start CompressedFile__HandleDecompression
CompressedFile__HandleDecompression: // 0x0205B91C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr ip, [r6]
	mov r5, r1
	and r3, ip, #0xf0
	mov r4, r2
	cmp r3, #0x20
	bgt _0205B94C
	bge _0205B980
	cmp r3, #0x10
	beq _0205B968
	b _0205B9B8
_0205B94C:
	cmp r3, #0x30
	bgt _0205B95C
	beq _0205B988
	b _0205B9B8
_0205B95C:
	cmp r3, #0x80
	beq _0205B9A0
	b _0205B9B8
_0205B968:
	tst r4, #1
	beq _0205B978
	bl MI_UncompressLZ8
	b _0205B9C8
_0205B978:
	bl MI_UncompressLZ16
	b _0205B9C8
_0205B980:
	bl MI_UncompressHuffman
	b _0205B9C8
_0205B988:
	tst r4, #1
	beq _0205B998
	bl MI_UncompressRL8
	b _0205B9C8
_0205B998:
	bl MI_UncompressRL16
	b _0205B9C8
_0205B9A0:
	tst r4, #1
	beq _0205B9B0
	bl MI_UnfilterDiff8
	b _0205B9C8
_0205B9B0:
	bl MI_UnfilterDiff16
	b _0205B9C8
_0205B9B8:
	mov r1, r5
	add r0, r6, #4
	mov r2, ip, lsr #8
	bl RenderCore_CPUCopy
_0205B9C8:
	tst r4, #2
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #0]
	mov r0, r5
	mov r1, r1, lsr #8
	bl DC_StoreRange
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end CompressedFile__HandleDecompression