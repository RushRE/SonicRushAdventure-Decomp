	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start GSIAvailableCheckThink
GSIAvailableCheckThink: // 0x0209F0E8
	stmdb sp!, {lr}
	sub sp, sp, #0x5c
	ldr r0, _0209F21C // =0x02144DA4
	mov r2, #8
	ldr r0, [r0, #0]
	mvn r1, #0
	cmp r0, r1
	ldreq r1, _0209F220 // =0x02144D20
	moveq r0, #1
	str r2, [sp, #0x10]
	streq r0, [r1]
	addeq sp, sp, #0x5c
	ldmeqia sp!, {pc}
	bl sub_20A0974
	cmp r0, #0
	beq _0209F1BC
	add r0, sp, #8
	str r0, [sp]
	add r1, sp, #0x10
	str r1, [sp, #4]
	ldr r0, _0209F21C // =0x02144DA4
	add r1, sp, #0x18
	ldr r0, [r0, #0]
	mov r2, #0x40
	mov r3, #0
	bl sub_20A0688
	mov r1, r0
	add r0, sp, #0x18
	add r2, sp, #8
	add r3, sp, #0x14
	bl sub_209F224
	cmp r0, #0
	bne _0209F1BC
	ldr r0, _0209F21C // =0x02144DA4
	ldr r0, [r0, #0]
	bl sub_20A07E4
	ldr r1, [sp, #0x14]
	ands r0, r1, #1
	ldrne r0, _0209F220 // =0x02144D20
	movne r1, #2
	strne r1, [r0]
	bne _0209F1AC
	ands r0, r1, #2
	ldrne r0, _0209F220 // =0x02144D20
	movne r1, #3
	strne r1, [r0]
	ldreq r0, _0209F220 // =0x02144D20
	moveq r1, #1
	streq r1, [r0]
_0209F1AC:
	ldr r0, _0209F220 // =0x02144D20
	add sp, sp, #0x5c
	ldr r0, [r0, #0]
	ldmia sp!, {pc}
_0209F1BC:
	bl sub_20A0CA4
	ldr r1, _0209F21C // =0x02144DA4
	ldr r2, [r1, #0x50]
	add r2, r2, #0x7d0
	cmp r0, r2
	bls _0209F210
	ldr r0, [r1, #0x54]
	cmp r0, #1
	bne _0209F1FC
	ldr r0, [r1, #0]
	bl sub_20A07E4
	ldr r1, _0209F220 // =0x02144D20
	mov r0, #1
	str r0, [r1]
	add sp, sp, #0x5c
	ldmia sp!, {pc}
_0209F1FC:
	bl sub_209F3D8
	ldr r0, _0209F21C // =0x02144DA4
	ldr r1, [r0, #0x54]
	add r1, r1, #1
	str r1, [r0, #0x54]
_0209F210:
	mov r0, #0
	add sp, sp, #0x5c
	ldmia sp!, {pc}
	.align 2, 0
_0209F21C: .word 0x02144DA4
_0209F220: .word 0x02144D20
	arm_func_end GSIAvailableCheckThink

	arm_func_start sub_209F224
sub_209F224: // 0x0209F224
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	cmp r1, #7
	mov r6, r2
	mov r4, r3
	movlt r0, #1
	ldmltia sp!, {r4, r5, r6, pc}
	ldr r1, _0209F2D4 // =0x02144DAC
	add r0, r6, #4
	mov r2, #4
	bl memcmp
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, _0209F2D8 // =0x02144DA4
	ldrh r1, [r6, #2]
	ldrh r0, [r0, #6]
	cmp r1, r0
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, _0209F2DC // =0x0211C530
	mov r0, r5
	mov r2, #3
	bl memcmp
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	ldrsb r2, [r5, #3]
	ldrsb r0, [r5, #4]
	ldrsb r1, [r5, #5]
	mov r3, r2, lsl #0x18
	mov r2, r0, lsl #0x10
	ldrsb r0, [r5, #6]
	mov r1, r1, lsl #8
	and r3, r3, #0xff000000
	and r2, r2, #0xff0000
	orr r2, r3, r2
	and r1, r1, #0xff00
	orr r1, r2, r1
	and r0, r0, #0xff
	orr r0, r1, r0
	str r0, [r4]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209F2D4: .word 0x02144DAC
_0209F2D8: .word 0x02144DA4
_0209F2DC: .word 0x0211C530
	arm_func_end sub_209F224

	arm_func_start GSIStartAvailableCheckA
GSIStartAvailableCheckA: // 0x0209F2E0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x44
	mov r4, r0
	ldr r0, _0209F3BC // =0x02144D64
	mov r1, r4
	bl strcpy
	ldr r0, _0209F3C0 // =0x02144DA4
	mvn r1, #0
	str r1, [r0]
	bl sub_20A0C94
	ldr r0, _0209F3C4 // =0x02144D24
	ldrsb r5, [r0, #0]
	cmp r5, #0
	bne _0209F328
	ldr r1, _0209F3C8 // =aSAvailableGsNi
	add r0, sp, #0
	mov r2, r4
	bl sprintf
_0209F328:
	cmp r5, #0
	ldrne r0, _0209F3C4 // =0x02144D24
	ldr r1, _0209F3CC // =0x00006CFC
	ldr r2, _0209F3D0 // =0x02144DA8
	addeq r0, sp, #0
	bl sub_209F428
	cmp r0, #0
	addeq sp, sp, #0x44
	ldmeqia sp!, {r4, r5, pc}
	mov r0, #2
	mov r1, r0
	mov r2, #0
	bl sub_20A0800
	ldr r2, _0209F3C0 // =0x02144DA4
	mvn r1, #0
	cmp r0, r1
	str r0, [r2]
	addeq sp, sp, #0x44
	ldmeqia sp!, {r4, r5, pc}
	mov r1, #9
	mov r0, r4
	strb r1, [r2, #0xc]
	bl strlen
	mov r5, r0
	ldr r0, _0209F3D4 // =0x02144DB5
	mov r1, r4
	add r2, r5, #1
	bl memcpy
	ldr r0, _0209F3C0 // =0x02144DA4
	add r1, r5, #6
	str r1, [r0, #0x4c]
	bl sub_209F3D8
	ldr r0, _0209F3C0 // =0x02144DA4
	mov r1, #0
	str r1, [r0, #0x54]
	add sp, sp, #0x44
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0209F3BC: .word 0x02144D64
_0209F3C0: .word 0x02144DA4
_0209F3C4: .word 0x02144D24
_0209F3C8: .word aSAvailableGsNi
_0209F3CC: .word 0x00006CFC
_0209F3D0: .word 0x02144DA8
_0209F3D4: .word 0x02144DB5
	arm_func_end GSIStartAvailableCheckA

	arm_func_start sub_209F3D8
sub_209F3D8: // 0x0209F3D8
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r1, _0209F41C // =0x02144DA8
	mov r0, #8
	str r1, [sp]
	ldr r1, _0209F420 // =0x02144DA4
	str r0, [sp, #4]
	ldr r0, [r1, #0]
	ldr r2, [r1, #0x4c]
	ldr r1, _0209F424 // =0x02144DB0
	mov r3, #0
	bl sub_20A061C
	bl sub_20A0CA4
	ldr r1, _0209F420 // =0x02144DA4
	str r0, [r1, #0x50]
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0209F41C: .word 0x02144DA8
_0209F420: .word 0x02144DA4
_0209F424: .word 0x02144DB0
	arm_func_end sub_209F3D8

	arm_func_start sub_209F428
sub_209F428: // 0x0209F428
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r3, r1, asr #8
	mov r1, r1, lsl #8
	mov r4, r2
	mov ip, #2
	and r2, r3, #0xff
	and r1, r1, #0xff00
	strb ip, [r4, #1]
	orr r1, r2, r1
	strh r1, [r4, #2]
	mov r5, r0
	bl sub_20A0580
	str r0, [r4, #4]
	ldr r1, [r4, #4]
	mvn r0, #0
	cmp r1, r0
	bne _0209F4A0
	mov r0, r5
	bl sub_20BE844
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r0, #0xc]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0]
	str r0, [r4, #4]
_0209F4A0:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_209F428

	arm_func_start sub_209F4AC
sub_209F4AC: // 0x0209F4AC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r7, [sp, #0x2c]
	mov r6, #0
	str r0, [sp]
	mov r10, r1
	mov r9, r3
	str r6, [r7]
	subs r5, r2, #1
	ldr r8, [sp, #0x28]
	bmi _0209F50C
	mov r11, #1
_0209F4DC:
	add r0, r6, r5
	mov r4, r0, asr #1
	mla r0, r4, r9, r10
	ldr r1, [sp]
	blx r8
	cmp r0, #0
	streq r11, [r7]
	cmp r0, #0
	addlt r6, r4, #1
	subge r5, r4, #1
	cmp r6, r5
	ble _0209F4DC
_0209F50C:
	mla r0, r6, r9, r10
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end sub_209F4AC

	arm_func_start sub_209F518
sub_209F518: // 0x0209F518
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r8, r2
	mov r10, r0
	mov r9, r1
	mov r7, r3
	cmp r8, #0
	ldr r6, [sp, #0x20]
	mov r5, #0
	ble _0209F568
	mov r4, r5
_0209F540:
	mov r0, r10
	add r1, r9, r4
	blx r6
	cmp r0, #0
	mlaeq r0, r7, r5, r9
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	add r5, r5, #1
	cmp r5, r8
	add r4, r4, r7
	blt _0209F540
_0209F568:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end sub_209F518

	arm_func_start sub_209F570
sub_209F570: // 0x0209F570
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl ArrayLength
	subs r4, r0, #1
	addmi sp, sp, #4
	ldmmiia sp!, {r4, r5, pc}
_0209F58C:
	mov r0, r5
	mov r1, r4
	bl ArrayDeleteAt
	subs r4, r4, #1
	bpl _0209F58C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_209F570

	arm_func_start ArrayMapBackwards
ArrayMapBackwards: // 0x0209F5A8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r7, r1
	mov r8, r0
	mov r6, r2
	bne _0209F5D0
	ldr r0, _0209F610 // =0x0211C558
	ldr r1, _0209F614 // =aDarrayC
	ldr r3, _0209F618 // =0x00000121
	mov r2, #0
	bl __msl_assertion_failed
_0209F5D0:
	ldr r0, [r8, #0]
	subs r5, r0, #1
	bmi _0209F608
_0209F5DC:
	mov r0, r8
	mov r1, r5
	bl ArrayNth
	mov r1, r6
	mov r4, r0
	blx r7
	cmp r0, #0
	moveq r0, r4
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	subs r5, r5, #1
	bpl _0209F5DC
_0209F608:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0209F610: .word 0x0211C558
_0209F614: .word aDarrayC
_0209F618: .word 0x00000121
	arm_func_end ArrayMapBackwards

	arm_func_start ArrayMap
ArrayMap: // 0x0209F61C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r6, r1
	mov r7, r0
	mov r5, r2
	bne _0209F648
	ldr r0, _0209F67C // =0x0211C558
	ldr r1, _0209F680 // =aDarrayC
	mov r2, #0
	mov r3, #0x104
	bl __msl_assertion_failed
_0209F648:
	ldr r0, [r7, #0]
	subs r4, r0, #1
	addmi sp, sp, #4
	ldmmiia sp!, {r4, r5, r6, r7, pc}
_0209F658:
	mov r0, r7
	mov r1, r4
	bl ArrayNth
	mov r1, r5
	blx r6
	subs r4, r4, #1
	bpl _0209F658
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209F67C: .word 0x0211C558
_0209F680: .word aDarrayC
	arm_func_end ArrayMap

	arm_func_start ArraySearch
ArraySearch: // 0x0209F684
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov ip, #1
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	str ip, [sp, #8]
	beq _0209F6B4
	ldr r8, [r7, #0]
	cmp r8, #0
	bne _0209F6C0
_0209F6B4:
	add sp, sp, #0x10
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209F6C0:
	ldr r1, [sp, #0x28]
	cmp r1, #0
	beq _0209F6F8
	mov r1, r4
	bl ArrayNth
	add r1, sp, #8
	str r5, [sp]
	str r1, [sp, #4]
	mov r1, r0
	ldr r3, [r7, #8]
	mov r0, r6
	sub r2, r8, r4
	bl sub_209F4AC
	b _0209F718
_0209F6F8:
	mov r1, r4
	bl ArrayNth
	str r5, [sp]
	mov r1, r0
	ldr r3, [r7, #8]
	mov r0, r6
	sub r2, r8, r4
	bl sub_209F518
_0209F718:
	cmp r0, #0
	beq _0209F744
	ldr r1, [sp, #8]
	cmp r1, #0
	beq _0209F744
	ldr r2, [r7, #0x14]
	ldr r1, [r7, #8]
	sub r0, r0, r2
	bl _s32_div_f
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0209F744:
	mvn r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end ArraySearch

	arm_func_start sub_209F750
sub_209F750: // 0x0209F750
	ldr ip, _0209F76C // =qsort
	mov r2, r0
	mov r3, r1
	ldr r0, [r2, #0x14]
	ldr r1, [r2, #0]
	ldr r2, [r2, #8]
	bx ip
	.align 2, 0
_0209F76C: .word qsort
	arm_func_end sub_209F750

	arm_func_start ArrayReplaceAt
ArrayReplaceAt: // 0x0209F770
	stmdb sp!, {r4, r5, r6, lr}
	movs r4, r2
	mov r6, r0
	mov r5, r1
	bmi _0209F790
	ldr r0, [r6, #0]
	cmp r4, r0
	blt _0209F7A4
_0209F790:
	ldr r0, _0209F7C4 // =aN0NArrayCount
	ldr r1, _0209F7C8 // =aDarrayC
	mov r2, #0
	mov r3, #0xd3
	bl __msl_assertion_failed
_0209F7A4:
	mov r0, r6
	mov r1, r4
	bl sub_209FC88
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_209FC00
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209F7C4: .word aN0NArrayCount
_0209F7C8: .word aDarrayC
	arm_func_end ArrayReplaceAt

	arm_func_start ArrayDeleteAt
ArrayDeleteAt: // 0x0209F7CC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r4, r1
	mov r5, r0
	bmi _0209F7EC
	ldr r0, [r5, #0]
	cmp r4, r0
	blt _0209F800
_0209F7EC:
	ldr r0, _0209F820 // =aN0NArrayCount
	ldr r1, _0209F824 // =aDarrayC
	mov r2, #0
	mov r3, #0xca
	bl __msl_assertion_failed
_0209F800:
	mov r0, r5
	mov r1, r4
	bl sub_209FC88
	mov r0, r5
	mov r1, r4
	bl sub_209F828
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0209F820: .word aN0NArrayCount
_0209F824: .word aDarrayC
	arm_func_end ArrayDeleteAt

	arm_func_start sub_209F828
sub_209F828: // 0x0209F828
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r1
	mov r4, r0
	bmi _0209F848
	ldr r0, [r4, #0]
	cmp r7, r0
	blt _0209F85C
_0209F848:
	ldr r0, _0209F8B4 // =aN0NArrayCount
	ldr r1, _0209F8B8 // =aDarrayC
	mov r2, #0
	mov r3, #0xc0
	bl __msl_assertion_failed
_0209F85C:
	ldr r0, [r4, #0]
	sub r6, r0, #1
	cmp r7, r6
	bge _0209F8A0
	mov r0, r4
	mov r1, r7
	bl ArrayNth
	mov r5, r0
	mov r0, r4
	add r1, r7, #1
	bl ArrayNth
	mov r1, r0
	ldr r3, [r4, #8]
	sub r0, r6, r7
	mul r2, r3, r0
	mov r0, r5
	bl memmove
_0209F8A0:
	ldr r0, [r4, #0]
	sub r0, r0, #1
	str r0, [r4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209F8B4: .word aN0NArrayCount
_0209F8B8: .word aDarrayC
	arm_func_end sub_209F828

	arm_func_start sub_209F8BC
sub_209F8BC: // 0x0209F8BC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	movs r4, r2
	mov r6, r0
	mov r5, r1
	bne _0209F8E8
	ldr r0, _0209F930 // =aComparator
	ldr r1, _0209F934 // =aDarrayC
	mov r2, #0
	mov r3, #0xb7
	bl __msl_assertion_failed
_0209F8E8:
	add r0, sp, #8
	str r4, [sp]
	str r0, [sp, #4]
	ldr r1, [r6, #0x14]
	ldr r2, [r6, #0]
	ldr r3, [r6, #8]
	mov r0, r5
	bl sub_209F4AC
	ldr r2, [r6, #0x14]
	ldr r1, [r6, #8]
	sub r0, r0, r2
	bl _s32_div_f
	mov r2, r0
	mov r0, r6
	mov r1, r5
	bl sub_209F938
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209F930: .word aComparator
_0209F934: .word aDarrayC
	arm_func_end sub_209F8BC

	arm_func_start sub_209F938
sub_209F938: // 0x0209F938
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r4, r2
	mov r6, r0
	mov r5, r1
	bmi _0209F958
	ldr r0, [r6, #0]
	cmp r4, r0
	ble _0209F96C
_0209F958:
	ldr r0, _0209F9E8 // =aN0NArrayCount_0
	ldr r1, _0209F9EC // =aDarrayC
	mov r2, #0
	mov r3, #0xa7
	bl __msl_assertion_failed
_0209F96C:
	ldr r1, [r6, #0]
	ldr r0, [r6, #4]
	cmp r1, r0
	bne _0209F984
	mov r0, r6
	bl sub_209FC2C
_0209F984:
	ldr r0, [r6, #0]
	add r0, r0, #1
	str r0, [r6]
	ldr r0, [r6, #0]
	sub r8, r0, #1
	cmp r4, r8
	bge _0209F9D4
	mov r0, r6
	add r1, r4, #1
	bl ArrayNth
	mov r7, r0
	mov r0, r6
	mov r1, r4
	bl ArrayNth
	mov r1, r0
	ldr r3, [r6, #8]
	sub r0, r8, r4
	mul r2, r3, r0
	mov r0, r7
	bl memmove
_0209F9D4:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_209FC00
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0209F9E8: .word aN0NArrayCount_0
_0209F9EC: .word aDarrayC
	arm_func_end sub_209F938

	arm_func_start ArrayAppend
ArrayAppend: // 0x0209F9F0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	mov r4, r1
	bne _0209FA18
	ldr r0, _0209FA3C // =aArray
	ldr r1, _0209FA40 // =aDarrayC
	mov r2, #0
	mov r3, #0xa0
	bl __msl_assertion_failed
_0209FA18:
	cmp r5, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r2, [r5, #0]
	mov r0, r5
	mov r1, r4
	bl sub_209F938
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0209FA3C: .word aArray
_0209FA40: .word aDarrayC
	arm_func_end ArrayAppend

	arm_func_start ArrayNth
ArrayNth: // 0x0209FA44
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r4, r1
	mov r5, r0
	bmi _0209FA64
	ldr r0, [r5, #0]
	cmp r4, r0
	blt _0209FA78
_0209FA64:
	ldr r0, _0209FAAC // =aN0NArrayCount
	ldr r1, _0209FAB0 // =aDarrayC
	mov r2, #0
	mov r3, #0x94
	bl __msl_assertion_failed
_0209FA78:
	cmp r4, #0
	blt _0209FA8C
	ldr r0, [r5, #0]
	cmp r4, r0
	blt _0209FA98
_0209FA8C:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_0209FA98:
	ldr r0, [r5, #0x14]
	ldr r1, [r5, #8]
	mla r0, r1, r4, r0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0209FAAC: .word aN0NArrayCount
_0209FAB0: .word aDarrayC
	arm_func_end ArrayNth

	arm_func_start ArrayLength
ArrayLength: // 0x0209FAB4
	ldr r0, [r0, #0]
	bx lr
	arm_func_end ArrayLength

	arm_func_start ArrayFree
ArrayFree: // 0x0209FABC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	bne _0209FAE0
	ldr r0, _0209FB24 // =aArray
	ldr r1, _0209FB28 // =aDarrayC
	mov r2, #0
	mov r3, #0x69
	bl __msl_assertion_failed
_0209FAE0:
	ldr r0, [r5, #0]
	mov r4, #0
	cmp r0, #0
	ble _0209FB0C
_0209FAF0:
	mov r0, r5
	mov r1, r4
	bl sub_209FC88
	ldr r0, [r5, #0]
	add r4, r4, #1
	cmp r4, r0
	blt _0209FAF0
_0209FB0C:
	ldr r0, [r5, #0x14]
	bl DWCi_GsFree
	mov r0, r5
	bl DWCi_GsFree
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0209FB24: .word aArray
_0209FB28: .word aDarrayC
	arm_func_end ArrayFree

	arm_func_start sub_209FB2C
sub_209FB2C: // 0x0209FB2C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r0, #0x18
	mov r6, r1
	mov r5, r2
	bl DWCi_GsMalloc
	movs r4, r0
	bne _0209FB64
	ldr r0, _0209FBF0 // =aArray
	ldr r1, _0209FBF4 // =aDarrayC
	mov r2, #0
	mov r3, #0x52
	bl __msl_assertion_failed
_0209FB64:
	cmp r7, #0
	bne _0209FB80
	ldr r0, _0209FBF8 // =aElemsize
	ldr r1, _0209FBF4 // =aDarrayC
	mov r2, #0
	mov r3, #0x53
	bl __msl_assertion_failed
_0209FB80:
	mov r0, #0
	cmp r6, #0
	moveq r6, #8
	str r0, [r4]
	str r6, [r4, #4]
	str r7, [r4, #8]
	str r6, [r4, #0xc]
	str r5, [r4, #0x10]
	ldr r1, [r4, #4]
	cmp r1, #0
	beq _0209FBE0
	ldr r0, [r4, #8]
	mul r0, r1, r0
	bl DWCi_GsMalloc
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x14]
	cmp r0, #0
	bne _0209FBE4
	ldr r0, _0209FBFC // =aArrayList
	ldr r1, _0209FBF4 // =aDarrayC
	mov r2, #0
	mov r3, #0x5e
	bl __msl_assertion_failed
	b _0209FBE4
_0209FBE0:
	str r0, [r4, #0x14]
_0209FBE4:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209FBF0: .word aArray
_0209FBF4: .word aDarrayC
_0209FBF8: .word aElemsize
_0209FBFC: .word aArrayList
	arm_func_end sub_209FB2C

	arm_func_start sub_209FC00
sub_209FC00: // 0x0209FC00
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r5, r0
	mov r1, r2
	bl ArrayNth
	ldr r2, [r5, #8]
	mov r1, r4
	bl memcpy
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_209FC00

	arm_func_start sub_209FC2C
sub_209FC2C: // 0x0209FC2C
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #4]
	ldr r0, [r4, #0xc]
	add r0, r1, r0
	str r0, [r4, #4]
	ldr r2, [r4, #4]
	ldr r1, [r4, #8]
	ldr r0, [r4, #0x14]
	mul r1, r2, r1
	bl DWCi_GsRealloc
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x14]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, _0209FC80 // =aArrayList
	ldr r1, _0209FC84 // =aDarrayC
	mov r2, #0
	mov r3, #0x41
	bl __msl_assertion_failed
	ldmia sp!, {r4, pc}
	.align 2, 0
_0209FC80: .word aArrayList
_0209FC84: .word aDarrayC
	arm_func_end sub_209FC2C

	arm_func_start sub_209FC88
sub_209FC88: // 0x0209FC88
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0x10]
	cmp r2, #0
	ldmeqia sp!, {r4, pc}
	bl ArrayNth
	ldr r1, [r4, #0x10]
	blx r1
	ldmia sp!, {r4, pc}
	arm_func_end sub_209FC88

	arm_func_start TableMapSafe2
TableMapSafe2: // 0x0209FCAC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r6, r1
	mov r7, r0
	mov r5, r2
	bne _0209FCD8
	ldr r0, _0209FD24 // =_0211C5D4
	ldr r1, _0209FD28 // =aHashtableC
	mov r2, #0
	mov r3, #0xd3
	bl __msl_assertion_failed
_0209FCD8:
	ldr r0, [r7, #4]
	mov r4, #0
	cmp r0, #0
	ble _0209FD18
_0209FCE8:
	ldr r0, [r7, #0]
	mov r1, r6
	ldr r0, [r0, r4, lsl #2]
	mov r2, r5
	bl ArrayMapBackwards
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r7, #4]
	add r4, r4, #1
	cmp r4, r0
	blt _0209FCE8
_0209FD18:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209FD24: .word _0211C5D4
_0209FD28: .word aHashtableC
	arm_func_end TableMapSafe2

	arm_func_start TableMap
TableMap: // 0x0209FD2C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r6, r1
	mov r7, r0
	mov r5, r2
	bne _0209FD58
	ldr r0, _0209FD98 // =_0211C5D4
	ldr r1, _0209FD9C // =aHashtableC
	mov r2, #0
	mov r3, #0xb6
	bl __msl_assertion_failed
_0209FD58:
	ldr r0, [r7, #4]
	mov r4, #0
	cmp r0, #0
	addle sp, sp, #4
	ldmleia sp!, {r4, r5, r6, r7, pc}
_0209FD6C:
	ldr r0, [r7, #0]
	mov r1, r6
	ldr r0, [r0, r4, lsl #2]
	mov r2, r5
	bl ArrayMap
	ldr r0, [r7, #4]
	add r4, r4, #1
	cmp r4, r0
	blt _0209FD6C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0209FD98: .word _0211C5D4
_0209FD9C: .word aHashtableC
	arm_func_end TableMap

	arm_func_start TableLookup
TableLookup: // 0x0209FDA0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	movs r6, r0
	mov r5, r1
	bne _0209FDC8
	ldr r0, _0209FE34 // =aTable
	ldr r1, _0209FE38 // =aHashtableC
	mov r2, #0
	mov r3, #0x94
	bl __msl_assertion_failed
_0209FDC8:
	cmp r6, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #4]
	ldr r2, [r6, #0xc]
	mov r0, r5
	blx r2
	mov r3, #0
	str r3, [sp]
	ldr r1, [r6, #0]
	mov r4, r0
	ldr r0, [r1, r4, lsl #2]
	ldr r2, [r6, #0x10]
	mov r1, r5
	bl ArraySearch
	mov r1, r0
	mvn r0, #0
	cmp r1, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0]
	ldr r0, [r0, r4, lsl #2]
	bl ArrayNth
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209FE34: .word aTable
_0209FE38: .word aHashtableC
	arm_func_end TableLookup

	arm_func_start TableRemove
TableRemove: // 0x0209FE3C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	movs r6, r0
	mov r5, r1
	bne _0209FE64
	ldr r0, _0209FED4 // =aTable
	ldr r1, _0209FED8 // =aHashtableC
	mov r2, #0
	mov r3, #0x82
	bl __msl_assertion_failed
_0209FE64:
	cmp r6, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #4]
	ldr r2, [r6, #0xc]
	mov r0, r5
	blx r2
	mov r3, #0
	str r3, [sp]
	ldr r1, [r6, #0]
	mov r4, r0
	ldr r0, [r1, r4, lsl #2]
	ldr r2, [r6, #0x10]
	mov r1, r5
	bl ArraySearch
	mov r1, r0
	mvn r0, #0
	cmp r1, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0]
	ldr r0, [r0, r4, lsl #2]
	bl ArrayDeleteAt
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209FED4: .word aTable
_0209FED8: .word aHashtableC
	arm_func_end TableRemove

	arm_func_start TableEnter
TableEnter: // 0x0209FEDC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	movs r6, r0
	mov r5, r1
	bne _0209FF04
	ldr r0, _0209FF80 // =aTable
	ldr r1, _0209FF84 // =aHashtableC
	mov r2, #0
	mov r3, #0x71
	bl __msl_assertion_failed
_0209FF04:
	cmp r6, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r6, #4]
	ldr r2, [r6, #0xc]
	mov r0, r5
	blx r2
	mov r3, #0
	str r3, [sp]
	ldr r1, [r6, #0]
	mov r4, r0
	ldr r0, [r1, r4, lsl #2]
	ldr r2, [r6, #0x10]
	mov r1, r5
	bl ArraySearch
	mov r2, r0
	mvn r0, #0
	cmp r2, r0
	bne _0209FF68
	ldr r0, [r6, #0]
	mov r1, r5
	ldr r0, [r0, r4, lsl #2]
	bl ArrayAppend
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
_0209FF68:
	ldr r0, [r6, #0]
	mov r1, r5
	ldr r0, [r0, r4, lsl #2]
	bl ArrayReplaceAt
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209FF80: .word aTable
_0209FF84: .word aHashtableC
	arm_func_end TableEnter

	arm_func_start TableCount
TableCount: // 0x0209FF88
	stmdb sp!, {r4, r5, r6, lr}
	movs r6, r0
	mov r4, #0
	bne _0209FFAC
	ldr r0, _0209FFF0 // =aTable
	ldr r1, _0209FFF4 // =aHashtableC
	mov r2, r4
	mov r3, #0x61
	bl __msl_assertion_failed
_0209FFAC:
	cmp r6, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #4]
	mov r5, #0
	cmp r0, #0
	ble _0209FFE8
_0209FFC8:
	ldr r0, [r6, #0]
	ldr r0, [r0, r5, lsl #2]
	bl ArrayLength
	ldr r1, [r6, #4]
	add r5, r5, #1
	cmp r5, r1
	add r4, r4, r0
	blt _0209FFC8
_0209FFE8:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0209FFF0: .word aTable
_0209FFF4: .word aHashtableC
	arm_func_end TableCount

	arm_func_start TableFree
TableFree: // 0x0209FFF8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	bne _020A001C
	ldr r0, _020A006C // =aTable
	ldr r1, _020A0070 // =aHashtableC
	mov r2, #0
	mov r3, #0x51
	bl __msl_assertion_failed
_020A001C:
	cmp r5, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r5, #4]
	mov r4, #0
	cmp r0, #0
	ble _020A0054
_020A0038:
	ldr r0, [r5, #0]
	ldr r0, [r0, r4, lsl #2]
	bl ArrayFree
	ldr r0, [r5, #4]
	add r4, r4, #1
	cmp r4, r0
	blt _020A0038
_020A0054:
	ldr r0, [r5, #0]
	bl DWCi_GsFree
	mov r0, r5
	bl DWCi_GsFree
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A006C: .word aTable
_020A0070: .word aHashtableC
	arm_func_end TableFree

	arm_func_start TableNew2
TableNew2: // 0x020A0074
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	movs r7, r3
	mov r10, r0
	mov r9, r1
	mov r8, r2
	ldr r6, [sp, #0x24]
	bne _020A00A4
	ldr r0, _020A0198 // =aHashfn
	ldr r1, _020A019C // =aHashtableC
	mov r2, #0
	mov r3, #0x38
	bl __msl_assertion_failed
_020A00A4:
	ldr r0, [sp, #0x20]
	cmp r0, #0
	bne _020A00C4
	ldr r0, _020A01A0 // =aCompfn
	ldr r1, _020A019C // =aHashtableC
	mov r2, #0
	mov r3, #0x39
	bl __msl_assertion_failed
_020A00C4:
	cmp r10, #0
	bne _020A00E0
	ldr r0, _020A01A4 // =aElemsize_0
	ldr r1, _020A019C // =aHashtableC
	mov r2, #0
	mov r3, #0x3a
	bl __msl_assertion_failed
_020A00E0:
	cmp r9, #0
	bne _020A00FC
	ldr r0, _020A01A8 // =aNbuckets
	ldr r1, _020A019C // =aHashtableC
	mov r2, #0
	mov r3, #0x3b
	bl __msl_assertion_failed
_020A00FC:
	mov r0, #0x14
	bl DWCi_GsMalloc
	movs r5, r0
	bne _020A0120
	ldr r0, _020A01AC // =aTable
	ldr r1, _020A019C // =aHashtableC
	mov r2, #0
	mov r3, #0x3e
	bl __msl_assertion_failed
_020A0120:
	mov r0, r9, lsl #2
	bl DWCi_GsMalloc
	str r0, [r5]
	ldr r0, [r5, #0]
	cmp r0, #0
	bne _020A014C
	ldr r0, _020A01B0 // =aTableBuckets
	ldr r1, _020A019C // =aHashtableC
	mov r2, #0
	mov r3, #0x41
	bl __msl_assertion_failed
_020A014C:
	cmp r9, #0
	mov r4, #0
	ble _020A017C
_020A0158:
	mov r0, r10
	mov r1, r8
	mov r2, r6
	bl sub_209FB2C
	ldr r1, [r5, #0]
	str r0, [r1, r4, lsl #2]
	add r4, r4, #1
	cmp r4, r9
	blt _020A0158
_020A017C:
	str r9, [r5, #4]
	ldr r0, [sp, #0x20]
	str r6, [r5, #8]
	str r0, [r5, #0x10]
	mov r0, r5
	str r7, [r5, #0xc]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020A0198: .word aHashfn
_020A019C: .word aHashtableC
_020A01A0: .word aCompfn
_020A01A4: .word aElemsize_0
_020A01A8: .word aNbuckets
_020A01AC: .word aTable
_020A01B0: .word aTableBuckets
	arm_func_end TableNew2

	arm_func_start TableNew
TableNew: // 0x020A01B4
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr ip, [sp, #0x10]
	str r3, [sp]
	mov r3, r2
	mov r2, #4
	str ip, [sp, #4]
	bl TableNew2
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end TableNew

	arm_func_start sub_20A01DC
sub_20A01DC: // 0x020A01DC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x68
	mov r6, r0
	add r0, sp, #0x10
	mov r5, r1
	mov r4, r2
	bl MD5Init
	add r0, sp, #0x10
	mov r1, r6
	mov r2, r5
	bl MD5Update
	add r0, sp, #0
	add r1, sp, #0x10
	bl MD5Final
	add r0, sp, #0
	mov r1, r4
	bl MD5Print
	add sp, sp, #0x68
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20A01DC

	arm_func_start MD5Print
MD5Print: // 0x020A0228
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, #0
	mov r8, r0
	mov r7, r1
	mov r5, r6
	ldr r4, _020A0264 // =0x0211C624
_020A0240:
	ldrb r2, [r8, r6]
	mov r1, r4
	add r0, r7, r5
	bl sprintf
	add r6, r6, #1
	cmp r6, #0x10
	add r5, r5, #2
	blo _020A0240
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020A0264: .word 0x0211C624
	arm_func_end MD5Print

	arm_func_start sub_20A0268
sub_20A0268: // 0x020A0268
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r7, r1
	mov r6, r2
	mov r10, r0
	mov r4, r7
	mov r9, r6
	cmp r3, #1
	beq _020A0294
	cmp r3, #2
	beq _020A029C
	b _020A02A4
_020A0294:
	ldr r5, _020A0390 // =0x02112660
	b _020A02A8
_020A029C:
	ldr r5, _020A0394 // =0x02112664
	b _020A02A8
_020A02A4:
	ldr r5, _020A0398 // =0x02112668
_020A02A8:
	cmp r6, #0
	ble _020A02E0
	mov r8, #3
_020A02B4:
	cmp r6, #3
	movge r2, r8
	movlt r2, r6
	mov r0, r10
	mov r1, r7
	bl sub_20A03A4
	sub r9, r9, #3
	cmp r9, #0
	add r7, r7, #4
	add r10, r10, #3
	bgt _020A02B4
_020A02E0:
	ldr r1, _020A039C // =0x55555556
	ldr r2, _020A03A0 // =0x00000003
	smull r0, r3, r1, r6
	add r3, r3, r6, lsr #31
	smull r0, r1, r2, r3
	sub r3, r6, r0
	mov r1, r7
	cmp r3, #1
	subeq r1, r7, #2
	beq _020A0310
	cmp r3, #2
	subeq r1, r7, #1
_020A0310:
	mov r0, #0
	strb r0, [r7]
	cmp r7, r4
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A0320:
	sub r7, r7, #1
	cmp r7, r1
	ldrhssb r0, [r5, #2]
	strhsb r0, [r7]
	bhs _020A0384
	ldrsb r0, [r7, #0]
	cmp r0, #0x19
	addle r0, r0, #0x41
	strleb r0, [r7]
	ble _020A0384
	cmp r0, #0x33
	addle r0, r0, #0x47
	strleb r0, [r7]
	ble _020A0384
	cmp r0, #0x3d
	suble r0, r0, #4
	strleb r0, [r7]
	ble _020A0384
	cmp r0, #0x3e
	ldreqsb r0, [r5, #0]
	streqb r0, [r7]
	beq _020A0384
	cmp r0, #0x3f
	ldreqsb r0, [r5, #1]
	streqb r0, [r7]
_020A0384:
	cmp r7, r4
	bhi _020A0320
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020A0390: .word 0x02112660
_020A0394: .word 0x02112664
_020A0398: .word 0x02112668
_020A039C: .word 0x55555556
_020A03A0: .word 0x00000003
	arm_func_end sub_20A0268

	arm_func_start sub_20A03A4
sub_20A03A4: // 0x020A03A4
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r2, #0
	mov lr, #0
	ble _020A03D0
	add ip, sp, #0
_020A03BC:
	ldrsb r3, [r0, lr]
	add lr, lr, #1
	cmp lr, r2
	strb r3, [ip], #1
	blt _020A03BC
_020A03D0:
	cmp lr, #3
	bge _020A03F4
	add r0, sp, #0
	add r2, r0, lr
	mov r0, #0
_020A03E4:
	add lr, lr, #1
	cmp lr, #3
	strb r0, [r2], #1
	blt _020A03E4
_020A03F4:
	ldrb r0, [sp]
	mov r0, r0, asr #2
	strb r0, [r1]
	ldrb r2, [sp]
	ldrb r0, [sp, #1]
	and r2, r2, #3
	mov r2, r2, lsl #4
	orr r0, r2, r0, asr #4
	strb r0, [r1, #1]
	ldrb r2, [sp, #1]
	ldrb r0, [sp, #2]
	and r2, r2, #0xf
	mov r2, r2, lsl #2
	orr r0, r2, r0, asr #6
	strb r0, [r1, #2]
	ldrb r0, [sp, #2]
	and r0, r0, #0x3f
	strb r0, [r1, #3]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A03A4

	arm_func_start sub_20A0444
sub_20A0444: // 0x020A0444
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	subs r4, r1, r5
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	bl sub_20A0490
	mov r1, r4
	bl _s32_div_f
	add r0, r1, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20A0444

	arm_func_start sub_20A0474
sub_20A0474: // 0x020A0474
	cmp r0, #0
	bicne r1, r0, #0x80000000
	ldr r0, _020A048C // =0x0211C62C
	moveq r1, #1
	str r1, [r0]
	bx lr
	.align 2, 0
_020A048C: .word 0x0211C62C
	arm_func_end sub_20A0474

	arm_func_start sub_20A0490
sub_20A0490: // 0x020A0490
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020A04B4 // =0x0211C62C
	ldr r0, [r0, #0]
	bl sub_20A04B8
	ldr r1, _020A04B4 // =0x0211C62C
	str r0, [r1]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A04B4: .word 0x0211C62C
	arm_func_end sub_20A0490

	arm_func_start sub_20A04B8
sub_20A04B8: // 0x020A04B8
	ldr r1, _020A0504 // =0x0000FFFF
	ldr r2, _020A0508 // =0x000041A7
	mov r3, r0, lsr #0x10
	and r1, r0, r1
	mul ip, r3, r2
	mul r2, r1, r2
	ldr r0, _020A050C // =0x00007FFF
	mvn r1, #0x80000000
	and r0, ip, r0
	add r0, r2, r0, lsl #16
	cmp r0, r1
	bichi r0, r0, #0x80000000
	addhi r0, r0, #1
	add r0, r0, ip, lsr #15
	mvn r1, #0x80000000
	cmp r0, r1
	bichi r0, r0, #0x80000000
	addhi r0, r0, #1
	bx lr
	.align 2, 0
_020A0504: .word 0x0000FFFF
_020A0508: .word 0x000041A7
_020A050C: .word 0x00007FFF
	arm_func_end sub_20A04B8

	arm_func_start sub_20A0510
sub_20A0510: // 0x020A0510
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl OS_IsTickAvailable
	cmp r0, #1
	beq _020A0538
	ldr r0, _020A0560 // =aOsIstickavaila
	ldr r1, _020A0564 // =aNonportC
	ldr r3, _020A0568 // =0x00000667
	mov r2, #0
	bl __msl_assertion_failed
_020A0538:
	bl OS_GetTick
	mov r1, r1, lsl #6
	orr r1, r1, r0, lsr #26
	ldr r2, _020A056C // =0x01FF6210
	mov r0, r0, lsl #6
	mov r3, #0
	bl _ll_udiv
	cmp r4, #0
	strne r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A0560: .word aOsIstickavaila
_020A0564: .word aNonportC
_020A0568: .word 0x00000667
_020A056C: .word 0x01FF6210
	arm_func_end sub_20A0510

	arm_func_start WSAGetLastError
WSAGetLastError: // 0x020A0570
	ldr r0, _020A057C // =0x02144E00
	ldr r0, [r0, #0]
	bx lr
	.align 2, 0
_020A057C: .word 0x02144E00
	arm_func_end WSAGetLastError

	arm_func_start sub_20A0580
sub_20A0580: // 0x020A0580
	stmdb sp!, {lr}
	sub sp, sp, #4
	add r1, sp, #0
	bl sub_20BE37C
	cmp r0, #0
	mvneq r0, #0
	ldrne r0, [sp]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A0580

	arm_func_start sub_20A05A4
sub_20A05A4: // 0x020A05A4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r2
	ldr r2, [r4, #0]
	mov r5, r1
	strb r2, [r5]
	bl sub_20BE7A8
	ldrb r2, [r5, #0]
	mvn r1, #0
	str r2, [r4]
	bl sub_20A081C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20A05A4

	arm_func_start sub_20A05D8
sub_20A05D8: // 0x020A05D8
	ldr ip, _020A05E8 // =sub_20A081C
	mov r0, #0
	mvn r1, #0
	bx ip
	.align 2, 0
_020A05E8: .word sub_20A081C
	arm_func_end sub_20A05D8

	arm_func_start sub_20A05EC
sub_20A05EC: // 0x020A05EC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, [sp, #8]
	mov r0, r3
	ldr r2, [r1, #0]
	mov r1, #0
	bl MI_CpuFill8
	mov r0, #0
	mvn r1, #0
	bl sub_20A081C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A05EC

	arm_func_start sub_20A061C
sub_20A061C: // 0x020A061C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	ldr r5, [sp, #0x20]
	add r6, sp, #4
	mov r4, #4
_020A0630:
	ldrb lr, [r5], #1
	ldrb ip, [r5], #1
	subs r4, r4, #1
	strb lr, [r6], #1
	strb ip, [r6], #1
	bne _020A0630
	ldr lr, [sp, #0x24]
	add ip, sp, #4
	strb lr, [sp, #4]
	str ip, [sp]
	bl SOC_SendTo
	mvn r1, #0
	bl sub_20A081C
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20A061C

	arm_func_start sub_20A066C
sub_20A066C: // 0x020A066C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20BE9B0
	mvn r1, #0
	bl sub_20A081C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A066C

	arm_func_start sub_20A0688
sub_20A0688: // 0x020A0688
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, [sp, #0x14]
	ldr r5, [sp, #0x10]
	ldr ip, [r4]
	strb ip, [r5]
	str r5, [sp]
	bl sub_20BE9D8
	ldrb r2, [r5, #0]
	mvn r1, #0
	str r2, [r4]
	bl sub_20A081C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20A0688

	arm_func_start sub_20A06C0
sub_20A06C0: // 0x020A06C0
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20BEA74
	mvn r1, #0
	bl sub_20A081C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A06C0

	arm_func_start sub_20A06DC
sub_20A06DC: // 0x020A06DC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r2
	ldr r2, [r4, #0]
	mov r5, r1
	strb r2, [r5]
	bl sub_20BE65C
	ldrb r2, [r5, #0]
	mvn r1, #0
	str r2, [r4]
	bl sub_20A081C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20A06DC

	arm_func_start sub_20A0710
sub_20A0710: // 0x020A0710
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20BE6E0
	mvn r1, #0
	bl sub_20A081C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A0710

	arm_func_start sub_20A072C
sub_20A072C: // 0x020A072C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	add r4, sp, #0
	mov lr, #4
_020A073C:
	ldrb ip, [r1], #1
	ldrb r3, [r1], #1
	subs lr, lr, #1
	strb ip, [r4], #1
	strb r3, [r4], #1
	bne _020A073C
	add r1, sp, #0
	strb r2, [sp]
	bl sub_20BEA9C
	mvn r1, #0
	bl sub_20A081C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end sub_20A072C

	arm_func_start sub_20A0770
sub_20A0770: // 0x020A0770
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldrh r3, [r1, #2]
	cmp r3, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r4, sp, #0
	mov lr, #4
_020A0794:
	ldrb ip, [r1], #1
	ldrb r3, [r1], #1
	subs lr, lr, #1
	strb ip, [r4], #1
	strb r3, [r4], #1
	bne _020A0794
	add r1, sp, #0
	strb r2, [sp]
	bl SOC_Bind
	mvn r1, #0
	bl sub_20A081C
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end sub_20A0770

	arm_func_start sub_20A07C8
sub_20A07C8: // 0x020A07C8
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20BE91C
	mvn r1, #0
	bl sub_20A081C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A07C8

	arm_func_start sub_20A07E4
sub_20A07E4: // 0x020A07E4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl SOC_Close
	mvn r1, #0
	bl sub_20A081C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A07E4

	arm_func_start sub_20A0800
sub_20A0800: // 0x020A0800
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl SOC_Socket
	mvn r1, #0
	bl sub_20A081C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A0800

	arm_func_start sub_20A081C
sub_20A081C: // 0x020A081C
	cmp r0, #0
	ldrlt r2, _020A0830 // =0x02144E00
	strlt r0, [r2]
	movlt r0, r1
	bx lr
	.align 2, 0
_020A0830: .word 0x02144E00
	arm_func_end sub_20A081C

	arm_func_start sub_20A0834
sub_20A0834: // 0x020A0834
	ldr r3, [r0, #0]
	mov r1, r3, lsr #0x18
	mov r0, r3, lsr #8
	mov r2, r3, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	mov r3, r3, lsl #0x18
	orr r0, r1, r0
	and r2, r2, #0xff0000
	and r1, r3, #0xff000000
	orr r0, r2, r0
	orr r1, r1, r0
	mov r0, r1, lsr #0x18
	and r2, r0, #0xff
	mov r0, r1, lsr #0x10
	and r0, r0, #0xff
	cmp r2, #0xa
	moveq r0, #1
	bxeq lr
	cmp r2, #0xac
	bne _020A089C
	cmp r0, #0x10
	blt _020A089C
	cmp r0, #0x1f
	movle r0, #1
	bxle lr
_020A089C:
	cmp r2, #0xc0
	bne _020A08B0
	cmp r0, #0xa8
	moveq r0, #1
	bxeq lr
_020A08B0:
	mov r0, #0
	bx lr
	arm_func_end sub_20A0834

	arm_func_start sub_20A08B8
sub_20A08B8: // 0x020A08B8
	stmdb sp!, {r4, lr}
	ldr r4, _020A0930 // =aLocalhost
	ldr r1, _020A0934 // =0x02144E04
	ldr lr, _020A0938 // =0x02144DFC
	ldr r2, _020A093C // =0x02144E28
	mov ip, #2
	mov r3, #0
	ldr r0, _020A0940 // =0x02144E14
	str r4, [r1]
	str lr, [r1, #4]
	strh ip, [r1, #8]
	strh r3, [r1, #0xa]
	str r2, [r1, #0xc]
	str r3, [r0]
	bl sub_20BDDD0
	ldr r1, _020A0940 // =0x02144E14
	bl sub_20BE2CC
	ldr r2, _020A0940 // =0x02144E14
	ldr r0, [r2, #0]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, _020A093C // =0x02144E28
	mov r3, #0
	ldr r0, _020A0934 // =0x02144E04
	mov ip, #4
	str r2, [r1]
	strh ip, [r0, #0xa]
	str r3, [r1, #4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A0930: .word aLocalhost
_020A0934: .word 0x02144E04
_020A0938: .word 0x02144DFC
_020A093C: .word 0x02144E28
_020A0940: .word 0x02144E14
	arm_func_end sub_20A08B8

	arm_func_start sub_20A0944
sub_20A0944: // 0x020A0944
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r1, #0
	add r2, sp, #0
	mov r3, r1
	str r1, [sp]
	bl sub_20A09A4
	cmp r0, #1
	ldreq r0, [sp]
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A0944

	arm_func_start sub_20A0974
sub_20A0974: // 0x020A0974
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r2, #0
	add r1, sp, #0
	mov r3, r2
	str r2, [sp]
	bl sub_20A09A4
	cmp r0, #1
	ldreq r0, [sp]
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20A0974

	arm_func_start sub_20A09A4
sub_20A09A4: // 0x020A09A4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	movs r6, r1
	mov r1, #0
	strh r1, [sp, #4]
	str r0, [sp]
	ldrnesh r0, [sp, #4]
	mov r5, r2
	mov r2, #0
	orrne r0, r0, #1
	strneh r0, [sp, #4]
	cmp r5, #0
	ldrnesh r0, [sp, #4]
	mov r4, r3
	mov r3, r2
	orrne r0, r0, #8
	strneh r0, [sp, #4]
	add r0, sp, #0
	mov r1, #1
	strh r2, [sp, #6]
	bl SOC_Poll
	cmp r0, #0
	addlt sp, sp, #8
	mvnlt r0, #0
	ldmltia sp!, {r4, r5, r6, pc}
	cmp r6, #0
	beq _020A0A34
	cmp r0, #0
	ble _020A0A2C
	ldrsh r1, [sp, #6]
	ands r1, r1, #0x41
	movne r1, #1
	strne r1, [r6]
	bne _020A0A34
_020A0A2C:
	mov r1, #0
	str r1, [r6]
_020A0A34:
	cmp r5, #0
	beq _020A0A60
	cmp r0, #0
	ble _020A0A58
	ldrsh r1, [sp, #6]
	ands r1, r1, #8
	movne r1, #1
	strne r1, [r5]
	bne _020A0A60
_020A0A58:
	mov r1, #0
	str r1, [r5]
_020A0A60:
	cmp r4, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r0, #0
	ble _020A0A8C
	ldrsh r1, [sp, #6]
	ands r1, r1, #0x20
	movne r1, #1
	addne sp, sp, #8
	strne r1, [r4]
	ldmneia sp!, {r4, r5, r6, pc}
_020A0A8C:
	mov r1, #0
	str r1, [r4]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20A09A4

	arm_func_start sub_20A0A9C
sub_20A0A9C: // 0x020A0A9C
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov r1, #4
	str r1, [sp, #8]
	add ip, sp, #8
	ldr r1, _020A0ADC // =0x0000FFFF
	ldr r2, _020A0AE0 // =0x00001001
	add r3, sp, #4
	str ip, [sp]
	bl sub_20A05EC
	mvn r1, #0
	cmp r0, r1
	ldrne r1, [sp, #4]
	mov r0, r1
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_020A0ADC: .word 0x0000FFFF
_020A0AE0: .word 0x00001001
	arm_func_end sub_20A0A9C

	arm_func_start sub_20A0AE4
sub_20A0AE4: // 0x020A0AE4
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov r1, #4
	str r1, [sp, #8]
	add ip, sp, #8
	ldr r1, _020A0B24 // =0x0000FFFF
	ldr r2, _020A0B28 // =0x00001002
	add r3, sp, #4
	str ip, [sp]
	bl sub_20A05EC
	mvn r1, #0
	cmp r0, r1
	ldrne r1, [sp, #4]
	mov r0, r1
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_020A0B24: .word 0x0000FFFF
_020A0B28: .word 0x00001002
	arm_func_end sub_20A0AE4

	arm_func_start sub_20A0B2C
sub_20A0B2C: // 0x020A0B2C
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020A0B70 // =0x0000FFFF
	mov ip, #4
	ldr r2, _020A0B74 // =0x00001001
	add r3, sp, #0xc
	str ip, [sp]
	bl sub_20A05D8
	mvn r1, #0
	cmp r0, r1
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020A0B70: .word 0x0000FFFF
_020A0B74: .word 0x00001001
	arm_func_end sub_20A0B2C

	arm_func_start sub_20A0B78
sub_20A0B78: // 0x020A0B78
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020A0BBC // =0x0000FFFF
	mov ip, #4
	ldr r2, _020A0BC0 // =0x00001002
	add r3, sp, #0xc
	str ip, [sp]
	bl sub_20A05D8
	mvn r1, #0
	cmp r0, r1
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020A0BBC: .word 0x0000FFFF
_020A0BC0: .word 0x00001002
	arm_func_end sub_20A0B78

	arm_func_start sub_20A0BC4
sub_20A0BC4: // 0x020A0BC4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r1, #3
	mov r2, #0
	mov r5, r0
	bl sub_20BE60C
	cmp r4, #0
	bicne r2, r0, #4
	orreq r2, r0, #4
	mov r0, r5
	mov r1, #4
	bl sub_20BE60C
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20A0BC4

	arm_func_start sub_20A0C0C
sub_20A0C0C: // 0x020A0C0C
	ldrsb r3, [r0, #0]
	mov r2, r0
	cmp r3, #0
	beq _020A0C44
	ldr r1, _020A0C4C // =_0211704C
_020A0C20:
	cmp r3, #0
	blt _020A0C34
	cmp r3, #0x80
	bge _020A0C34
	ldrb r3, [r1, r3]
_020A0C34:
	strb r3, [r0]
	ldrsb r3, [r0, #1]!
	cmp r3, #0
	bne _020A0C20
_020A0C44:
	mov r0, r2
	bx lr
	.align 2, 0
_020A0C4C: .word _0211704C
	arm_func_end sub_20A0C0C

	arm_func_start sub_20A0C50
sub_20A0C50: // 0x020A0C50
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	bl strlen
	add r0, r0, #1
	bl DWCi_GsMalloc
	movs r4, r0
	beq _020A0C84
	mov r1, r5
	bl strcpy
_020A0C84:
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20A0C50

	arm_func_start sub_20A0C90
sub_20A0C90: // 0x020A0C90
	bx lr
	arm_func_end sub_20A0C90

	arm_func_start sub_20A0C94
sub_20A0C94: // 0x020A0C94
	bx lr
	arm_func_end sub_20A0C94

	arm_func_start sub_20A0C98
sub_20A0C98: // 0x020A0C98
	ldr ip, _020A0CA0 // =OS_Sleep
	bx ip
	.align 2, 0
_020A0CA0: .word OS_Sleep
	arm_func_end sub_20A0C98

	arm_func_start sub_20A0CA4
sub_20A0CA4: // 0x020A0CA4
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl OS_IsTickAvailable
	cmp r0, #1
	beq _020A0CCC
	ldr r0, _020A0CF0 // =aOsIstickavaila
	ldr r1, _020A0CF4 // =aNonportC
	ldr r3, _020A0CF8 // =0x00000109
	mov r2, #0
	bl __msl_assertion_failed
_020A0CCC:
	bl OS_GetTick
	mov r1, r1, lsl #6
	orr r1, r1, r0, lsr #26
	ldr r2, _020A0CFC // =0x000082EA
	mov r0, r0, lsl #6
	mov r3, #0
	bl _ll_udiv
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A0CF0: .word aOsIstickavaila
_020A0CF4: .word aNonportC
_020A0CF8: .word 0x00000109
_020A0CFC: .word 0x000082EA
	arm_func_end sub_20A0CA4

	arm_func_start sub_20A0D00
sub_20A0D00: // 0x020A0D00
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r0
	mov r6, r1
	mov r5, r2
	bne _020A0D2C
	ldr r0, _020A0DB8 // =aBufferinNull
	ldr r1, _020A0DBC // =aGhttpbufferC
	ldr r3, _020A0DC0 // =0x000001B7
	mov r2, #0
	bl __msl_assertion_failed
_020A0D2C:
	cmp r5, #0
	bne _020A0D48
	ldr r0, _020A0DC4 // =aLenNull
	ldr r1, _020A0DBC // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x1b8
	bl __msl_assertion_failed
_020A0D48:
	ldr r4, [r5, #0]
	cmp r4, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r3, [r7, #0x10]
	ldr r0, [r7, #0xc]
	sub r0, r0, r3
	cmp r0, #0
	addle sp, sp, #4
	movle r0, #0
	ldmleia sp!, {r4, r5, r6, r7, pc}
	ldr r1, [r7, #4]
	cmp r4, r0
	movge r4, r0
	mov r0, r6
	mov r2, r4
	add r1, r1, r3
	bl memcpy
	mov r0, #0
	strb r0, [r6, r4]
	str r4, [r5]
	ldr r1, [r7, #0x10]
	mov r0, #1
	add r1, r1, r4
	str r1, [r7, #0x10]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A0DB8: .word aBufferinNull
_020A0DBC: .word aGhttpbufferC
_020A0DC0: .word 0x000001B7
_020A0DC4: .word aLenNull
	arm_func_end sub_20A0D00

	arm_func_start sub_20A0DC8
sub_20A0DC8: // 0x020A0DC8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r8, r0
	add r6, sp, #0
	add r5, sp, #4
	add r4, r8, #0x60
	mov r7, #0
	mvn r9, #0
_020A0DE8:
	ldr r0, [r8, #0x48]
	mov r1, r7
	mov r2, r6
	mov r3, r5
	bl sub_20A09A4
	cmp r0, r9
	beq _020A0E10
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _020A0E38
_020A0E10:
	mov r0, #1
	str r0, [r8, #0xfc]
	mov r0, #5
	str r0, [r8, #0x38]
	ldr r0, [r8, #0x48]
	bl WSAGetLastError
	str r0, [r8, #0x4c]
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020A0E38:
	ldr r0, [sp]
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r3, [r8, #0x60]
	ldr r1, [r8, #0x54]
	ldr r2, [r8, #0x5c]
	mov r0, r8
	add r1, r1, r3
	sub r2, r2, r3
	bl sub_20A17DC
	cmp r0, r9
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r1, [r4, #0]
	add r0, r1, r0
	str r0, [r4]
	ldr r1, [r8, #0x60]
	ldr r0, [r8, #0x5c]
	cmp r1, r0
	blt _020A0DE8
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end sub_20A0DC8

	arm_func_start sub_20A0EA0
sub_20A0EA0: // 0x020A0EA0
	stmdb sp!, {r4, lr}
	movs r4, r0
	bne _020A0EC0
	ldr r0, _020A0ED8 // =aBuffer
	ldr r1, _020A0EDC // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x16c
	bl __msl_assertion_failed
_020A0EC0:
	mov r1, #0
	str r1, [r4, #0xc]
	str r1, [r4, #0x10]
	ldr r0, [r4, #4]
	strb r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A0ED8: .word aBuffer
_020A0EDC: .word aGhttpbufferC
	arm_func_end sub_20A0EA0

	arm_func_start sub_20A0EE0
sub_20A0EE0: // 0x020A0EE0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r2, r1
	mov r4, r0
	ldr r1, _020A0F14 // =0x0211C6A0
	add r0, sp, #0
	bl sprintf
	add r1, sp, #0
	mov r0, r4
	mov r2, #0
	bl sub_20A1008
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A0F14: .word 0x0211C6A0
	arm_func_end sub_20A0EE0

	arm_func_start sub_20A0F18
sub_20A0F18: // 0x020A0F18
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	movs r4, r0
	strb r1, [sp]
	bne _020A0F40
	ldr r0, _020A0F68 // =aBuffer
	ldr r1, _020A0F6C // =aGhttpbufferC
	ldr r3, _020A0F70 // =0x00000131
	mov r2, #0
	bl __msl_assertion_failed
_020A0F40:
	cmp r4, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r1, sp, #0
	mov r0, r4
	mov r2, #1
	bl sub_20A1008
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A0F68: .word aBuffer
_020A0F6C: .word aGhttpbufferC
_020A0F70: .word 0x00000131
	arm_func_end sub_20A0F18

	arm_func_start sub_20A0F74
sub_20A0F74: // 0x020A0F74
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r2
	mov r2, #0
	mov r5, r0
	bl sub_20A1008
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, _020A1000 // =0x0211C6A4
	mov r0, r5
	mov r2, #2
	bl sub_20A1008
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r5
	mov r1, r4
	mov r2, #0
	bl sub_20A1008
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, _020A1004 // =0x0211C6A8
	mov r0, r5
	mov r2, #2
	bl sub_20A1008
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A1000: .word 0x0211C6A4
_020A1004: .word 0x0211C6A8
	arm_func_end sub_20A0F74

	arm_func_start sub_20A1008
sub_20A1008: // 0x020A1008
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	ldr r5, [r7, #0]
	bne _020A1038
	ldr r0, _020A12B4 // =aBuffer
	ldr r1, _020A12B8 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0xb7
	bl __msl_assertion_failed
_020A1038:
	cmp r6, #0
	bne _020A1054
	ldr r0, _020A12BC // =0x0211C6AC
	ldr r1, _020A12B8 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0xb8
	bl __msl_assertion_failed
_020A1054:
	ldr r0, [sp, #0x28]
	cmp r0, #0
	bge _020A1074
	ldr r0, _020A12C0 // =aDatalen0
	ldr r1, _020A12B8 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0xb9
	bl __msl_assertion_failed
_020A1074:
	cmp r7, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	addeq sp, sp, #0x10
	bxeq lr
	cmp r6, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldr r0, [sp, #0x28]
	cmp r0, #0
	addlt sp, sp, #0xc
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, lr}
	addlt sp, sp, #0x10
	bxlt lr
	cmp r0, #0
	bne _020A10D4
	mov r0, r6
	bl strlen
	str r0, [sp, #0x28]
_020A10D4:
	ldr r0, [r7, #0x20]
	cmp r0, #1
	bne _020A11DC
	ldr r0, [r5, #0x168]
	cmp r0, #0
	bne _020A1100
	ldr r0, _020A12C4 // =aConnectionEncr
	ldr r1, _020A12B8 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0xce
	bl __msl_assertion_failed
_020A1100:
	ldr r2, [r7, #8]
	ldr r1, [r7, #0xc]
	add r0, sp, #8
	sub r1, r2, r1
	str r1, [sp, #8]
	ldr r2, [r7, #4]
	ldr r1, [r7, #0xc]
	add r3, sp, #0x28
	add r1, r2, r1
	str r1, [sp]
	str r0, [sp, #4]
	ldr r4, [r5, #0x17c]
	mov r0, r5
	mov r2, r6
	add r1, r5, #0x164
	blx r4
	mov r4, r0
	cmp r4, #2
	bne _020A11C0
	ldr r0, [r7, #0x18]
	cmp r0, #0
	beq _020A1184
	ldr r0, [r7, #0]
	mov r1, #1
	str r1, [r0, #0xfc]
	ldr r0, [r7, #0]
	mov r1, #2
	str r1, [r0, #0x38]
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	add sp, sp, #0x10
	bx lr
_020A1184:
	ldr r1, [r7, #0x14]
	mov r0, r7
	bl sub_20A1564
	cmp r0, #0
	beq _020A11D0
	ldr r0, [r7, #0]
	mov r2, #1
	str r2, [r0, #0xfc]
	ldr r1, [r7, #0]
	add sp, sp, #0xc
	str r2, [r1, #0x38]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	add sp, sp, #0x10
	bx lr
_020A11C0:
	ldr r1, [r7, #0xc]
	ldr r0, [sp, #8]
	add r0, r1, r0
	str r0, [r7, #0xc]
_020A11D0:
	cmp r4, #2
	beq _020A1100
	b _020A12A0
_020A11DC:
	ldr r2, [r7, #0xc]
	ldr r1, [sp, #0x28]
	ldr r0, [r7, #8]
	add r4, r2, r1
	cmp r4, r0
	blt _020A1274
_020A11F4:
	ldr r0, [r7, #0x18]
	cmp r0, #0
	beq _020A122C
	ldr r0, [r7, #0]
	mov r1, #1
	str r1, [r0, #0xfc]
	ldr r0, [r7, #0]
	mov r1, #2
	str r1, [r0, #0x38]
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	add sp, sp, #0x10
	bx lr
_020A122C:
	ldr r1, [r7, #0x14]
	mov r0, r7
	bl sub_20A1564
	cmp r0, #0
	bne _020A1268
	ldr r0, [r7, #0]
	mov r2, #1
	str r2, [r0, #0xfc]
	ldr r1, [r7, #0]
	add sp, sp, #0xc
	str r2, [r1, #0x38]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, lr}
	add sp, sp, #0x10
	bx lr
_020A1268:
	ldr r0, [r7, #8]
	cmp r4, r0
	bge _020A11F4
_020A1274:
	ldr r3, [r7, #4]
	ldr r0, [r7, #0xc]
	ldr r2, [sp, #0x28]
	mov r1, r6
	add r0, r3, r0
	bl memcpy
	str r4, [r7, #0xc]
	ldr r1, [r7, #4]
	ldr r0, [r7, #0xc]
	mov r2, #0
	strb r2, [r1, r0]
_020A12A0:
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020A12B4: .word aBuffer
_020A12B8: .word aGhttpbufferC
_020A12BC: .word 0x0211C6AC
_020A12C0: .word aDatalen0
_020A12C4: .word aConnectionEncr
	arm_func_end sub_20A1008

	arm_func_start sub_20A12C8
sub_20A12C8: // 0x020A12C8
	stmdb sp!, {r4, lr}
	movs r4, r0
	bne _020A12E8
	ldr r0, _020A1320 // =aBuffer
	ldr r1, _020A1324 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x9b
	bl __msl_assertion_failed
_020A12E8:
	cmp r4, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #4]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x1c]
	cmp r1, #0
	bne _020A130C
	bl DWCi_GsFree
_020A130C:
	mov r0, r4
	mov r1, #0
	mov r2, #0x24
	bl memset
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A1320: .word aBuffer
_020A1324: .word aGhttpbufferC
	arm_func_end sub_20A12C8

	arm_func_start sub_20A1328
sub_20A1328: // 0x020A1328
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bne _020A1358
	ldr r0, _020A1424 // =aConnection_0
	ldr r1, _020A1428 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x74
	bl __msl_assertion_failed
_020A1358:
	cmp r6, #0
	bne _020A1374
	ldr r0, _020A142C // =aBuffer
	ldr r1, _020A1428 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x75
	bl __msl_assertion_failed
_020A1374:
	cmp r5, #0
	bne _020A1390
	ldr r0, _020A1430 // =aUserbuffer
	ldr r1, _020A1428 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x76
	bl __msl_assertion_failed
_020A1390:
	cmp r4, #0
	bgt _020A13AC
	ldr r0, _020A1434 // =aSize0
	ldr r1, _020A1428 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x77
	bl __msl_assertion_failed
_020A13AC:
	cmp r7, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r6, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r5, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r4, #0
	addle sp, sp, #4
	movle r0, #0
	ldmleia sp!, {r4, r5, r6, r7, pc}
	str r7, [r6]
	str r5, [r6, #4]
	str r4, [r6, #8]
	mov r2, #0
	str r2, [r6, #0xc]
	str r2, [r6, #0x14]
	mov r0, #1
	str r0, [r6, #0x18]
	str r0, [r6, #0x1c]
	str r2, [r6, #0x20]
	ldr r1, [r6, #4]
	strb r2, [r1]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A1424: .word aConnection_0
_020A1428: .word aGhttpbufferC
_020A142C: .word aBuffer
_020A1430: .word aUserbuffer
_020A1434: .word aSize0
	arm_func_end sub_20A1328

	arm_func_start sub_20A1438
sub_20A1438: // 0x020A1438
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bne _020A1468
	ldr r0, _020A1550 // =aConnection_0
	ldr r1, _020A1554 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x43
	bl __msl_assertion_failed
_020A1468:
	cmp r6, #0
	bne _020A1484
	ldr r0, _020A1558 // =aBuffer
	ldr r1, _020A1554 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x44
	bl __msl_assertion_failed
_020A1484:
	cmp r5, #0
	bgt _020A14A0
	ldr r0, _020A155C // =aInitialsize0
	ldr r1, _020A1554 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x45
	bl __msl_assertion_failed
_020A14A0:
	cmp r4, #0
	bgt _020A14BC
	ldr r0, _020A1560 // =aSizeincrement0
	ldr r1, _020A1554 // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x46
	bl __msl_assertion_failed
_020A14BC:
	cmp r7, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r6, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r5, #0
	addle sp, sp, #4
	movle r0, #0
	ldmleia sp!, {r4, r5, r6, r7, pc}
	cmp r4, #0
	addle sp, sp, #4
	movle r0, #0
	ldmleia sp!, {r4, r5, r6, r7, pc}
	str r7, [r6]
	mov r2, #0
	str r2, [r6, #4]
	str r2, [r6, #8]
	str r2, [r6, #0xc]
	str r2, [r6, #0x10]
	str r4, [r6, #0x14]
	str r2, [r6, #0x18]
	str r2, [r6, #0x1c]
	mov r0, r6
	mov r1, r5
	str r2, [r6, #0x20]
	bl sub_20A1564
	cmp r0, #0
	moveq r0, #0
	ldrne r0, [r6, #4]
	movne r1, #0
	strneb r1, [r0]
	movne r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A1550: .word aConnection_0
_020A1554: .word aGhttpbufferC
_020A1558: .word aBuffer
_020A155C: .word aInitialsize0
_020A1560: .word aSizeincrement0
	arm_func_end sub_20A1438

	arm_func_start sub_20A1564
sub_20A1564: // 0x020A1564
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	mov r4, r1
	bne _020A158C
	ldr r0, _020A15F8 // =aBuffer
	ldr r1, _020A15FC // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x20
	bl __msl_assertion_failed
_020A158C:
	cmp r4, #0
	bgt _020A15A8
	ldr r0, _020A1600 // =aSizeincrement0
	ldr r1, _020A15FC // =aGhttpbufferC
	mov r2, #0
	mov r3, #0x21
	bl __msl_assertion_failed
_020A15A8:
	cmp r5, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	cmp r4, #0
	addle sp, sp, #4
	movle r0, #0
	ldmleia sp!, {r4, r5, pc}
	ldr r1, [r5, #8]
	ldr r0, [r5, #4]
	add r4, r1, r4
	mov r1, r4
	bl DWCi_GsRealloc
	cmp r0, #0
	moveq r0, #0
	strne r0, [r5, #4]
	strne r4, [r5, #8]
	movne r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A15F8: .word aBuffer
_020A15FC: .word aGhttpbufferC
_020A1600: .word aSizeincrement0
	arm_func_end sub_20A1564

	arm_func_start sub_20A1604
sub_20A1604: // 0x020A1604
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	movs r4, r0
	bne _020A1628
	ldr r0, _020A166C // =aConnection_1
	ldr r1, _020A1670 // =aGhttpcallbacks
	mov r2, #0
	mov r3, #0x5e
	bl __msl_assertion_failed
_020A1628:
	ldr r0, [r4, #0x150]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x140]
	bl ArrayLength
	str r0, [sp]
	ldr r0, [r4, #0x44]
	str r0, [sp, #4]
	ldr r0, [r4, #4]
	ldr r1, [r4, #0x148]
	ldr r2, [r4, #0x14c]
	ldr r3, [r4, #0x144]
	ldr ip, [r4, #0x150]
	blx ip
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A166C: .word aConnection_1
_020A1670: .word aGhttpcallbacks
	arm_func_end sub_20A1604

	arm_func_start sub_20A1674
sub_20A1674: // 0x020A1674
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	movs r6, r0
	mov r5, r1
	mov r4, r2
	bne _020A16A0
	ldr r0, _020A16E4 // =aConnection_1
	ldr r1, _020A16E8 // =aGhttpcallbacks
	mov r2, #0
	mov r3, #0x45
	bl __msl_assertion_failed
_020A16A0:
	ldr ip, [r6, #0x3c]
	cmp ip, #0
	addeq sp, sp, #0x10
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0x100]
	mov r2, r5
	str r0, [sp]
	ldr r0, [r6, #0x104]
	mov r3, r4
	str r0, [sp, #4]
	ldr r0, [r6, #0x44]
	str r0, [sp, #8]
	ldr r0, [r6, #4]
	ldr r1, [r6, #0x10]
	blx ip
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A16E4: .word aConnection_1
_020A16E8: .word aGhttpcallbacks
	arm_func_end sub_20A1674

	arm_func_start sub_20A16EC
sub_20A16EC: // 0x020A16EC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	bne _020A1710
	ldr r0, _020A1770 // =aConnection_1
	ldr r1, _020A1774 // =aGhttpcallbacks
	mov r2, #0
	mov r3, #0x1b
	bl __msl_assertion_failed
_020A1710:
	ldr ip, [r5, #0x40]
	cmp ip, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r5, #0xc]
	cmp r0, #0
	movne r4, #0
	movne r3, r4
	ldreq r4, [r5, #0xc0]
	ldreq r3, [r5, #0x100]
	ldr r0, [r5, #0x44]
	mov r2, r4
	str r0, [sp]
	ldr r0, [r5, #4]
	ldr r1, [r5, #0x38]
	blx ip
	cmp r4, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	cmp r0, #0
	moveq r0, #1
	streq r0, [r5, #0xd8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A1770: .word aConnection_1
_020A1774: .word aGhttpcallbacks
	arm_func_end sub_20A16EC

	arm_func_start sub_20A1778
sub_20A1778: // 0x020A1778
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r3, [r6, #0x5c]
	mov r5, r1
	mov r4, r2
	cmp r3, #0
	mov r3, #0
	bne _020A17BC
	bl sub_20A17DC
	mov r3, r0
	mvn r0, #0
	cmp r3, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r3, r4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, pc}
_020A17BC:
	add r0, r6, #0x50
	add r1, r5, r3
	sub r2, r4, r3
	bl sub_20A1008
	cmp r0, #0
	moveq r0, #0
	movne r0, #2
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20A1778

	arm_func_start sub_20A17DC
sub_20A17DC: // 0x020A17DC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x48]
	mov r3, #0
	bl sub_20A066C
	mvn r1, #0
	cmp r0, r1
	bne _020A184C
	ldr r0, [r4, #0x48]
	bl WSAGetLastError
	mvn r1, #5
	cmp r0, r1
	beq _020A1828
	mvn r1, #0x19
	cmp r0, r1
	beq _020A1828
	mvn r1, #0x4b
	cmp r0, r1
	bne _020A1830
_020A1828:
	mov r0, #0
	ldmia sp!, {r4, pc}
_020A1830:
	mov r1, #1
	str r1, [r4, #0xfc]
	mov r1, #5
	str r1, [r4, #0x38]
	str r0, [r4, #0x4c]
	mvn r0, #0
	ldmia sp!, {r4, pc}
_020A184C:
	ldr r1, [r4, #0x10]
	cmp r1, #4
	ldreq r1, [r4, #0x148]
	addeq r1, r1, r0
	streq r1, [r4, #0x148]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20A17DC

	arm_func_start sub_20A1864
sub_20A1864: // 0x020A1864
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r5, r2
	ldr r2, [r5, #0]
	ldr r0, [r7, #0x134]
	mov r6, r1
	cmp r0, #0
	sub r4, r2, #1
	beq _020A18C4
	bl sub_20A0CA4
	ldr r1, _020A1AA4 // =0x0211C768
	ldr r2, [r7, #0x138]
	ldr r1, [r1, #0]
	add r1, r2, r1
	cmp r0, r1
	addlo sp, sp, #4
	movlo r0, #1
	ldmloia sp!, {r4, r5, r6, r7, pc}
	ldr r1, _020A1AA8 // =0x0211C76C
	str r0, [r7, #0x138]
	ldr r0, [r1, #0]
	cmp r4, r0
	movge r4, r0
_020A18C4:
	ldr r1, [r7, #0x84]
	ldr r0, [r7, #0x80]
	cmp r1, r0
	bge _020A190C
	mov r1, r6
	mov r2, r5
	add r0, r7, #0x74
	bl sub_20A0D00
	ldr r1, [r7, #0x84]
	ldr r0, [r7, #0x80]
	add sp, sp, #4
	cmp r1, r0
	ldreq r0, [r7, #0xf8]
	streq r0, [r7, #0x80]
	ldreq r0, [r7, #0xf8]
	streq r0, [r7, #0x84]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020A190C:
	ldr r0, [r7, #0x48]
	mov r1, r6
	mov r2, r4
	mov r3, #0
	bl sub_20A06C0
	mov r2, r0
	mvn r0, #0
	str r2, [sp]
	cmp r2, r0
	bne _020A1990
	ldr r0, [r7, #0x48]
	bl WSAGetLastError
	mvn r1, #5
	cmp r0, r1
	beq _020A1960
	mvn r1, #0x19
	cmp r0, r1
	beq _020A1960
	mvn r1, #0x4b
	cmp r0, r1
	bne _020A196C
_020A1960:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020A196C:
	mov r2, #1
	str r2, [r7, #0xfc]
	mov r1, #5
	str r1, [r7, #0x38]
	str r0, [r7, #0x4c]
	add sp, sp, #4
	str r2, [r7, #0x130]
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, pc}
_020A1990:
	cmp r2, #0
	moveq r0, #1
	streq r0, [r7, #0x130]
	addeq sp, sp, #4
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r7, #0x168]
	cmp r0, #0
	beq _020A1A80
	mov r1, r6
	add r0, r7, #0x98
	bl sub_20A1008
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r7
	bl sub_20A1AAC
	cmp r0, #0
	bne _020A19FC
	mov r0, #1
	str r0, [r7, #0xfc]
	mov r0, #0x11
	str r0, [r7, #0x38]
	add sp, sp, #4
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, pc}
_020A19FC:
	ldr r1, [r7, #0x80]
	ldr r0, [r7, #0x84]
	sub r0, r1, r0
	cmp r0, #0
	movle r0, #0
	strleb r0, [r6]
	strle r0, [r5]
	addle sp, sp, #4
	movle r0, #1
	ldmleia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r5, #0]
	add r2, sp, #0
	sub r3, r0, #1
	mov r1, r6
	add r0, r7, #0x74
	str r3, [sp]
	bl sub_20A0D00
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r1, [r7, #0x84]
	ldr r0, [r7, #0x80]
	cmp r1, r0
	ldreq r0, [r7, #0xf8]
	streq r0, [r7, #0x80]
	ldreq r0, [r7, #0xf8]
	streq r0, [r7, #0x84]
	ldr r2, [sp]
	cmp r2, #0
	addle sp, sp, #4
	movle r0, #1
	ldmleia sp!, {r4, r5, r6, r7, pc}
_020A1A80:
	mov r0, #0
	strb r0, [r6, r2]
	ldr r1, [sp]
	str r1, [r5]
	ldr r1, [sp]
	cmp r1, #0
	movle r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A1AA4: .word 0x0211C768
_020A1AA8: .word 0x0211C76C
	arm_func_end sub_20A1864

	arm_func_start sub_20A1AAC
sub_20A1AAC: // 0x020A1AAC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x14
	mov r1, #0
	mov r4, r0
	str r1, [sp, #8]
	str r1, [sp, #0xc]
	add r8, sp, #0xc
	add r6, sp, #8
	add r5, r4, #0x74
	add r7, r4, #0x164
_020A1AD4:
	ldr ip, [r4, #0xa8]
	ldr r0, [r4, #0xa4]
	ldr r2, [r4, #0x9c]
	sub r0, r0, ip
	str r0, [sp, #8]
	ldr r3, [r4, #0x80]
	ldr r0, [r4, #0x7c]
	ldr r1, [r4, #0x78]
	sub r0, r0, r3
	str r0, [sp, #0xc]
	add r0, r1, r3
	str r0, [sp]
	str r8, [sp, #4]
	ldr r9, [r4, #0x180]
	mov r0, r4
	mov r1, r7
	mov r3, r6
	add r2, r2, ip
	blx r9
	mov r9, r0
	cmp r9, #2
	bne _020A1B48
	ldr r1, [r4, #0x88]
	mov r0, r5
	bl sub_20A1564
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020A1B48:
	cmp r9, #2
	bne _020A1B5C
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _020A1AD4
_020A1B5C:
	ldr r1, [r4, #0xa8]
	ldr r0, [sp, #8]
	add r0, r1, r0
	str r0, [r4, #0xa8]
	ldr r1, [r4, #0x80]
	ldr r0, [sp, #0xc]
	add r0, r1, r0
	str r0, [r4, #0x80]
	ldr r1, [r4, #0xa8]
	cmp r1, #0xff
	ble _020A1BBC
	ldr r0, [r4, #0xa4]
	subs r5, r0, r1
	bne _020A1BA0
	add r0, r4, #0x98
	bl sub_20A0EA0
	b _020A1BBC
_020A1BA0:
	ldr r0, [r4, #0x9c]
	mov r2, r5
	add r1, r0, r1
	bl memmove
	mov r0, #0
	str r0, [r4, #0xa8]
	str r5, [r4, #0xa4]
_020A1BBC:
	cmp r9, #3
	addne sp, sp, #0x14
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r0, #1
	str r0, [r4, #0xfc]
	mov r0, #0x11
	str r0, [r4, #0x38]
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end sub_20A1AAC

	arm_func_start sub_20A1BE8
sub_20A1BE8: // 0x020A1BE8
	bx lr
	arm_func_end sub_20A1BE8

	arm_func_start sub_20A1BEC
sub_20A1BEC: // 0x020A1BEC
	bx lr
	arm_func_end sub_20A1BEC

	arm_func_start sub_20A1BF0
sub_20A1BF0: // 0x020A1BF0
	bx lr
	arm_func_end sub_20A1BF0

	arm_func_start sub_20A1BF4
sub_20A1BF4: // 0x020A1BF4
	bx lr
	arm_func_end sub_20A1BF4

	arm_func_start sub_20A1BF8
sub_20A1BF8: // 0x020A1BF8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, _020A1C74 // =0x02144E54
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _020A1C78 // =sub_20A1EAC
	bl sub_20A1D84
	ldr r5, _020A1C7C // =0x02144E48
	mov r6, #0
	ldr r0, [r5, #0]
	cmp r0, #0
	ble _020A1C48
	ldr r4, _020A1C74 // =0x02144E54
_020A1C2C:
	ldr r0, [r4, #0]
	ldr r0, [r0, r6, lsl #2]
	bl DWCi_GsFree
	ldr r0, [r5, #0]
	add r6, r6, #1
	cmp r6, r0
	blt _020A1C2C
_020A1C48:
	ldr r0, _020A1C74 // =0x02144E54
	ldr r0, [r0, #0]
	bl DWCi_GsFree
	ldr r2, _020A1C74 // =0x02144E54
	mov r3, #0
	ldr r1, _020A1C7C // =0x02144E48
	ldr r0, _020A1C80 // =0x02144E4C
	str r3, [r2]
	str r3, [r1]
	str r3, [r0]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A1C74: .word 0x02144E54
_020A1C78: .word sub_20A1EAC
_020A1C7C: .word 0x02144E48
_020A1C80: .word 0x02144E4C
	arm_func_end sub_20A1BF8

	arm_func_start sub_20A1C84
sub_20A1C84: // 0x020A1C84
	stmdb sp!, {r4, lr}
	movs r4, r0
	bne _020A1CA4
	ldr r0, _020A1D70 // =aConnection_2
	ldr r1, _020A1D74 // =aGhttpconnectio
	ldr r3, _020A1D78 // =0x00000132
	mov r2, #0
	bl __msl_assertion_failed
_020A1CA4:
	ldr r0, [r4, #0x108]
	cmp r0, #0
	bne _020A1CC4
	ldr r0, _020A1D7C // =aConnectionRedi
	ldr r1, _020A1D74 // =aGhttpconnectio
	ldr r3, _020A1D80 // =0x00000133
	mov r2, #0
	bl __msl_assertion_failed
_020A1CC4:
	mov r0, #0
	str r0, [r4, #0x10]
	ldr r0, [r4, #0x14]
	bl DWCi_GsFree
	ldr r1, [r4, #0x108]
	mov r0, #0
	str r1, [r4, #0x14]
	str r0, [r4, #0x108]
	ldr r0, [r4, #0x18]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x18]
	str r0, [r4, #0x1c]
	strh r0, [r4, #0x20]
	ldr r0, [r4, #0x24]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x24]
	ldr r0, [r4, #0x48]
	mov r1, #2
	bl sub_20A07C8
	ldr r0, [r4, #0x48]
	bl sub_20A07E4
	mvn r1, #0
	add r0, r4, #0x50
	str r1, [r4, #0x48]
	bl sub_20A0EA0
	add r0, r4, #0x74
	bl sub_20A0EA0
	add r0, r4, #0x98
	bl sub_20A0EA0
	mov r0, #0
	str r0, [r4, #0xe4]
	str r0, [r4, #0xe8]
	str r0, [r4, #0xec]
	str r0, [r4, #0xf0]
	str r0, [r4, #0xf4]
	str r0, [r4, #0xf8]
	str r0, [r4, #0x130]
	ldr r0, [r4, #0x10c]
	add r0, r0, #1
	str r0, [r4, #0x10c]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A1D70: .word aConnection_2
_020A1D74: .word aGhttpconnectio
_020A1D78: .word 0x00000132
_020A1D7C: .word aConnectionRedi
_020A1D80: .word 0x00000133
	arm_func_end sub_20A1C84

	arm_func_start sub_20A1D84
sub_20A1D84: // 0x020A1D84
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r1, _020A1DF4 // =0x02144E4C
	mov r5, r0
	ldr r0, [r1, #0]
	cmp r0, #0
	addle sp, sp, #4
	ldmleia sp!, {r4, r5, r6, r7, pc}
	bl sub_20A1BEC
	ldr r7, _020A1DF8 // =0x02144E48
	mov r4, #0
	ldr r0, [r7, #0]
	cmp r0, #0
	ble _020A1DE8
	ldr r6, _020A1DFC // =0x02144E54
_020A1DC0:
	ldr r0, [r6, #0]
	ldr r0, [r0, r4, lsl #2]
	ldr r1, [r0, #0]
	cmp r1, #0
	beq _020A1DD8
	blx r5
_020A1DD8:
	ldr r0, [r7, #0]
	add r4, r4, #1
	cmp r4, r0
	blt _020A1DC0
_020A1DE8:
	bl sub_20A1BE8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A1DF4: .word 0x02144E4C
_020A1DF8: .word 0x02144E48
_020A1DFC: .word 0x02144E54
	arm_func_end sub_20A1D84

	arm_func_start sub_20A1E00
sub_20A1E00: // 0x020A1E00
	stmdb sp!, {r4, lr}
	movs r4, r0
	bpl _020A1E20
	ldr r0, _020A1E90 // =aRequest0
	ldr r1, _020A1E94 // =aGhttpconnectio
	ldr r3, _020A1E98 // =0x00000101
	mov r2, #0
	bl __msl_assertion_failed
_020A1E20:
	ldr r0, _020A1E9C // =0x02144E48
	ldr r0, [r0, #0]
	cmp r4, r0
	blt _020A1E44
	ldr r0, _020A1EA0 // =aRequestGhiconn
	ldr r1, _020A1E94 // =aGhttpconnectio
	ldr r3, _020A1EA4 // =0x00000102
	mov r2, #0
	bl __msl_assertion_failed
_020A1E44:
	bl sub_20A1BEC
	cmp r4, #0
	blt _020A1E60
	ldr r0, _020A1E9C // =0x02144E48
	ldr r0, [r0, #0]
	cmp r4, r0
	blt _020A1E6C
_020A1E60:
	bl sub_20A1BE8
	mov r0, #0
	ldmia sp!, {r4, pc}
_020A1E6C:
	ldr r0, _020A1EA8 // =0x02144E54
	ldr r0, [r0, #0]
	ldr r4, [r0, r4, lsl #2]
	ldr r0, [r4, #0]
	cmp r0, #0
	moveq r4, #0
	bl sub_20A1BE8
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A1E90: .word aRequest0
_020A1E94: .word aGhttpconnectio
_020A1E98: .word 0x00000101
_020A1E9C: .word 0x02144E48
_020A1EA0: .word aRequestGhiconn
_020A1EA4: .word 0x00000102
_020A1EA8: .word 0x02144E54
	arm_func_end sub_20A1E00

	arm_func_start sub_20A1EAC
sub_20A1EAC: // 0x020A1EAC
	stmdb sp!, {r4, lr}
	movs r4, r0
	bne _020A1ECC
	ldr r0, _020A2074 // =aConnection_2
	ldr r1, _020A2078 // =aGhttpconnectio
	mov r2, #0
	mov r3, #0xb3
	bl __msl_assertion_failed
_020A1ECC:
	ldr r0, [r4, #4]
	cmp r0, #0
	bge _020A1EEC
	ldr r0, _020A207C // =aConnectionRequ
	ldr r1, _020A2078 // =aGhttpconnectio
	mov r2, #0
	mov r3, #0xb4
	bl __msl_assertion_failed
_020A1EEC:
	ldr r0, _020A2080 // =0x02144E48
	ldr r1, [r4, #4]
	ldr r0, [r0, #0]
	cmp r1, r0
	blt _020A1F14
	ldr r0, _020A2084 // =aConnectionRequ_0
	ldr r1, _020A2078 // =aGhttpconnectio
	mov r2, #0
	mov r3, #0xb5
	bl __msl_assertion_failed
_020A1F14:
	ldr r0, [r4, #0]
	cmp r0, #0
	bne _020A1F34
	ldr r0, _020A2088 // =aConnectionInus
	ldr r1, _020A2078 // =aGhttpconnectio
	mov r2, #0
	mov r3, #0xb6
	bl __msl_assertion_failed
_020A1F34:
	cmp r4, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #4]
	cmp r1, #0
	movlt r0, #0
	ldmltia sp!, {r4, pc}
	ldr r0, _020A2080 // =0x02144E48
	ldr r0, [r0, #0]
	cmp r1, r0
	movge r0, #0
	ldmgeia sp!, {r4, pc}
	bl sub_20A1BEC
	ldr r0, [r4, #0x14]
	bl DWCi_GsFree
	ldr r0, [r4, #0x18]
	bl DWCi_GsFree
	ldr r0, [r4, #0x24]
	bl DWCi_GsFree
	ldr r0, [r4, #0x28]
	bl DWCi_GsFree
	ldr r0, [r4, #0x108]
	bl DWCi_GsFree
	ldr r0, [r4, #0x15c]
	bl DWCi_GsFree
	ldr r0, [r4, #0x48]
	mvn r1, #0
	cmp r0, r1
	beq _020A1FC8
	mov r1, #2
	bl sub_20A07C8
	ldr r0, [r4, #0x48]
	bl sub_20A07E4
_020A1FC8:
	add r0, r4, #0x50
	bl sub_20A12C8
	add r0, r4, #0x74
	bl sub_20A12C8
	add r0, r4, #0x98
	bl sub_20A12C8
	add r0, r4, #0xbc
	bl sub_20A12C8
	ldr r0, [r4, #0x140]
	cmp r0, #0
	beq _020A1FFC
	mov r0, r4
	bl sub_20A3240
_020A1FFC:
	ldr r0, [r4, #0x13c]
	cmp r0, #0
	beq _020A2024
	bl sub_20A38D0
	cmp r0, #0
	beq _020A2024
	ldr r0, [r4, #0x13c]
	bl sub_20A38B4
	mov r0, #0
	str r0, [r4, #0x13c]
_020A2024:
	ldr r0, [r4, #0x16c]
	cmp r0, #0
	beq _020A2050
	ldr r2, [r4, #0x178]
	cmp r2, #0
	beq _020A2048
	mov r0, r4
	add r1, r4, #0x164
	blx r2
_020A2048:
	mov r0, #0
	str r0, [r4, #0x16c]
_020A2050:
	mov r1, #0
	ldr r0, _020A208C // =0x02144E4C
	str r1, [r4]
	ldr r1, [r0, #0]
	sub r1, r1, #1
	str r1, [r0]
	bl sub_20A1BE8
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A2074: .word aConnection_2
_020A2078: .word aGhttpconnectio
_020A207C: .word aConnectionRequ
_020A2080: .word 0x02144E48
_020A2084: .word aConnectionRequ_0
_020A2088: .word aConnectionInus
_020A208C: .word 0x02144E4C
	arm_func_end sub_20A1EAC

	arm_func_start sub_20A2090
sub_20A2090: // 0x020A2090
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl sub_20A1BEC
	bl sub_20A2240
	mov r5, r0
	mvn r0, #0
	cmp r5, r0
	bne _020A20C0
	bl sub_20A1BE8
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020A20C0:
	ldr r0, _020A2234 // =0x02144E54
	mov r1, #0
	ldr r0, [r0, #0]
	mov r2, #0x184
	ldr r4, [r0, r5, lsl #2]
	mov r0, r4
	bl memset
	mov r0, #1
	str r0, [r4]
	ldr r0, _020A2238 // =0x02144E50
	str r5, [r4, #4]
	ldr r2, [r0, #0]
	mov ip, #0
	add r1, r2, #1
	str r1, [r0]
	str r2, [r4, #8]
	str ip, [r4, #0xc]
	str ip, [r4, #0x10]
	str ip, [r4, #0x14]
	str ip, [r4, #0x18]
	str ip, [r4, #0x1c]
	strh ip, [r4, #0x20]
	str ip, [r4, #0x24]
	str ip, [r4, #0x28]
	str ip, [r4, #0x2c]
	str ip, [r4, #0x30]
	str ip, [r4, #0x34]
	str ip, [r4, #0x38]
	str ip, [r4, #0x3c]
	str ip, [r4, #0x40]
	str ip, [r4, #0x44]
	mvn r0, #0
	str r0, [r4, #0x48]
	str ip, [r4, #0x4c]
	str ip, [r4, #0xe0]
	str ip, [r4, #0xe4]
	str ip, [r4, #0xe8]
	str ip, [r4, #0xec]
	str ip, [r4, #0xf0]
	str ip, [r4, #0xf4]
	str ip, [r4, #0xf8]
	str ip, [r4, #0xfc]
	str ip, [r4, #0x100]
	str r0, [r4, #0x104]
	str ip, [r4, #0x108]
	str ip, [r4, #0x10c]
	str ip, [r4, #0x110]
	str ip, [r4, #0x12c]
	str ip, [r4, #0x134]
	str ip, [r4, #0x138]
	str ip, [r4, #0x13c]
	mov r0, #0x1f4
	str r0, [r4, #0x158]
	add r0, r4, #0x100
	mov r1, #0x50
	strh r1, [r0, #0x60]
	str ip, [r4, #0x15c]
	mov r0, r4
	add r1, r4, #0x50
	mov r2, #0x800
	mov r3, #0x1000
	str ip, [r4, #0x164]
	bl sub_20A1438
	cmp r0, #0
	beq _020A21D8
	mov r2, #0x800
	mov r0, r4
	mov r3, r2
	add r1, r4, #0x74
	bl sub_20A1438
_020A21D8:
	cmp r0, #0
	beq _020A21F4
	mov r0, r4
	add r1, r4, #0x98
	mov r2, #0x800
	mov r3, #0x400
	bl sub_20A1438
_020A21F4:
	cmp r0, #0
	bne _020A2214
	mov r0, r4
	bl sub_20A1EAC
	bl sub_20A1BE8
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020A2214:
	ldr r0, _020A223C // =0x02144E4C
	ldr r1, [r0, #0]
	add r1, r1, #1
	str r1, [r0]
	bl sub_20A1BE8
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A2234: .word 0x02144E54
_020A2238: .word 0x02144E50
_020A223C: .word 0x02144E4C
	arm_func_end sub_20A2090

	arm_func_start sub_20A2240
sub_20A2240: // 0x020A2240
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr r1, _020A2368 // =0x02144E48
	mov r0, #0
	ldr r2, [r1, #0]
	cmp r2, #0
	ble _020A2284
	ldr r1, _020A236C // =0x02144E54
	ldr r3, [r1, #0]
_020A2264:
	ldr r1, [r3, r0, lsl #2]
	ldr r1, [r1, #0]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r0, r0, #1
	cmp r0, r2
	blt _020A2264
_020A2284:
	ldr r0, _020A2370 // =0x02144E4C
	ldr r0, [r0, #0]
	cmp r0, r2
	beq _020A22A8
	ldr r0, _020A2374 // =aGhinumconnecti
	ldr r1, _020A2378 // =aGhttpconnectio
	mov r2, #0
	mov r3, #0x33
	bl __msl_assertion_failed
_020A22A8:
	ldr r1, _020A2368 // =0x02144E48
	ldr r0, _020A236C // =0x02144E54
	ldr r7, [r1, #0]
	ldr r0, [r0, #0]
	add r6, r7, #4
	mov r1, r6, lsl #2
	bl DWCi_GsRealloc
	cmp r0, #0
	addeq sp, sp, #4
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r8, _020A236C // =0x02144E54
	mov r5, r7
	str r0, [r8]
	cmp r7, r6
	bge _020A2354
	mov r9, #0
	mov r4, #0x184
_020A22F0:
	mov r0, r4
	bl DWCi_GsMalloc
	ldr r1, [r8, #0]
	str r0, [r1, r5, lsl #2]
	ldr r0, [r8, #0]
	ldr r0, [r0, r5, lsl #2]
	cmp r0, #0
	bne _020A2344
	sub r5, r5, #1
	cmp r5, r7
	blt _020A2338
	ldr r4, _020A236C // =0x02144E54
_020A2320:
	ldr r0, [r4, #0]
	ldr r0, [r0, r5, lsl #2]
	bl DWCi_GsFree
	sub r5, r5, #1
	cmp r5, r7
	bge _020A2320
_020A2338:
	add sp, sp, #4
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020A2344:
	add r5, r5, #1
	str r9, [r0]
	cmp r5, r6
	blt _020A22F0
_020A2354:
	ldr r1, _020A2368 // =0x02144E48
	mov r0, r7
	str r6, [r1]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020A2368: .word 0x02144E48
_020A236C: .word 0x02144E54
_020A2370: .word 0x02144E4C
_020A2374: .word aGhinumconnecti
_020A2378: .word aGhttpconnectio
	arm_func_end sub_20A2240

	arm_func_start ghttpCancelRequest
ghttpCancelRequest: // 0x020A237C
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20A1E00
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl sub_20A1EAC
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end ghttpCancelRequest

	arm_func_start ghttpThink
ghttpThink: // 0x020A23A0
	ldr ip, _020A23AC // =sub_20A1D84
	ldr r0, _020A23B0 // =sub_20A26E0
	bx ip
	.align 2, 0
_020A23AC: .word sub_20A1D84
_020A23B0: .word sub_20A26E0
	arm_func_end ghttpThink

	arm_func_start ghttpGetExA
ghttpGetExA: // 0x020A23B4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	beq _020A23D8
	ldrsb r0, [r8, #0]
	cmp r0, #0
	bne _020A23EC
_020A23D8:
	ldr r0, _020A25FC // =aUrlUrl0
	ldr r1, _020A2600 // =aGhttpmainC
	mov r2, #0
	mov r3, #0x128
	bl __msl_assertion_failed
_020A23EC:
	cmp r5, #0
	bge _020A2408
	ldr r0, _020A2604 // =aBuffersize0
	ldr r1, _020A2600 // =aGhttpmainC
	ldr r3, _020A2608 // =0x00000129
	mov r2, #0
	bl __msl_assertion_failed
_020A2408:
	cmp r6, #0
	beq _020A242C
	cmp r5, #0
	bne _020A242C
	ldr r0, _020A260C // =aBufferBuffersi
	ldr r1, _020A2600 // =aGhttpmainC
	ldr r3, _020A2610 // =0x0000012A
	mov r2, #0
	bl __msl_assertion_failed
_020A242C:
	cmp r8, #0
	beq _020A2440
	ldrsb r0, [r8, #0]
	cmp r0, #0
	bne _020A2448
_020A2440:
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A2448:
	cmp r5, #0
	mvnlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r6, #0
	beq _020A2468
	cmp r5, #0
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_020A2468:
	ldr r0, _020A2614 // =0x02144E58
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _020A247C
	bl ghttpStartup
_020A247C:
	bl sub_20A2090
	movs r4, r0
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r1, #0
	mov r0, r8
	str r1, [r4, #0xc]
	bl sub_20A0C50
	str r0, [r4, #0x14]
	ldr r0, [r4, #0x14]
	cmp r0, #0
	bne _020A24BC
	mov r0, r4
	bl sub_20A1EAC
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A24BC:
	cmp r7, #0
	beq _020A24F8
	ldrsb r0, [r7, #0]
	cmp r0, #0
	beq _020A24F8
	mov r0, r7
	bl sub_20A0C50
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x28]
	cmp r0, #0
	bne _020A24F8
	mov r0, r4
	bl sub_20A1EAC
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A24F8:
	ldr r1, [sp, #0x18]
	ldr r0, [sp, #0x20]
	str r1, [r4, #0x13c]
	str r0, [r4, #0x30]
	ldr r1, [sp, #0x24]
	ldr r0, [sp, #0x28]
	str r1, [r4, #0x3c]
	str r0, [r4, #0x40]
	ldr r1, [sp, #0x2c]
	ldr r0, [sp, #0x1c]
	str r1, [r4, #0x44]
	str r0, [r4, #0x134]
	cmp r6, #0
	movne r0, #1
	moveq r0, #0
	str r0, [r4, #0xe0]
	ldr r0, [r4, #0xe0]
	cmp r0, #0
	beq _020A255C
	mov r0, r4
	mov r2, r6
	mov r3, r5
	add r1, r4, #0xbc
	bl sub_20A1328
	b _020A2570
_020A255C:
	mov r2, #0x800
	mov r0, r4
	mov r3, r2
	add r1, r4, #0xbc
	bl sub_20A1438
_020A2570:
	cmp r0, #0
	bne _020A2588
	mov r0, r4
	bl sub_20A1EAC
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A2588:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	beq _020A25B4
	mov r0, r4
	bl sub_20A32BC
	cmp r0, #0
	bne _020A25B4
	mov r0, r4
	bl sub_20A1EAC
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A25B4:
	ldr r0, [sp, #0x20]
	cmp r0, #0
	beq _020A25F4
	mov r0, r4
	bl sub_20A26E0
	cmp r0, #0
	bne _020A25EC
	mov r5, #0xa
_020A25D4:
	mov r0, r5
	bl sub_20A0C98
	mov r0, r4
	bl sub_20A26E0
	cmp r0, #0
	beq _020A25D4
_020A25EC:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A25F4:
	ldr r0, [r4, #4]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020A25FC: .word aUrlUrl0
_020A2600: .word aGhttpmainC
_020A2604: .word aBuffersize0
_020A2608: .word 0x00000129
_020A260C: .word aBufferBuffersi
_020A2610: .word 0x0000012A
_020A2614: .word 0x02144E58
	arm_func_end ghttpGetExA

	arm_func_start ghttpCleanup
ghttpCleanup: // 0x020A2618
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20A1BEC
	ldr r0, _020A2678 // =0x02144E58
	ldr r1, [r0, #0]
	subs r1, r1, #1
	str r1, [r0]
	bne _020A266C
	bl sub_20A1BF8
	ldr r0, _020A267C // =0x02144E44
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _020A265C
	bl DWCi_GsFree
	ldr r0, _020A267C // =0x02144E44
	mov r1, #0
	str r1, [r0]
_020A265C:
	bl sub_20A1BE8
	bl sub_20A1BF0
	add sp, sp, #4
	ldmia sp!, {pc}
_020A266C:
	bl sub_20A1BE8
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A2678: .word 0x02144E58
_020A267C: .word 0x02144E44
	arm_func_end ghttpCleanup

	arm_func_start ghttpStartup
ghttpStartup: // 0x020A2680
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20A1BEC
	ldr r0, _020A26D4 // =0x02144E58
	ldr r1, [r0, #0]
	add r1, r1, #1
	str r1, [r0]
	cmp r1, #1
	bne _020A26C8
	bl sub_20A1BF4
	ldr r1, _020A26D8 // =0x0211C76C
	mov r3, #0x7d
	ldr r0, _020A26DC // =0x0211C768
	mov r2, #0xfa
	str r3, [r1]
	str r2, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
_020A26C8:
	bl sub_20A1BE8
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A26D4: .word 0x02144E58
_020A26D8: .word 0x0211C76C
_020A26DC: .word 0x0211C768
	arm_func_end ghttpStartup

	arm_func_start sub_20A26E0
sub_20A26E0: // 0x020A26E0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r4, r0
	bne _020A2704
	ldr r0, _020A2844 // =aConnection_3
	ldr r1, _020A2848 // =aGhttpmainC
	mov r2, #0
	mov r3, #0x5b
	bl __msl_assertion_failed
_020A2704:
	ldr r0, [r4, #4]
	bl sub_20A1E00
	cmp r0, r4
	beq _020A2728
	ldr r0, _020A284C // =aGhirequesttoco
	ldr r1, _020A2848 // =aGhttpmainC
	mov r2, #0
	mov r3, #0x5c
	bl __msl_assertion_failed
_020A2728:
	ldr r0, [r4, #0x12c]
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, pc}
	mov r0, #1
	str r0, [r4, #0x12c]
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _020A2758
	mov r0, r4
	bl sub_20A4CD4
_020A2758:
	ldr r0, [r4, #0x10]
	cmp r0, #1
	bne _020A276C
	mov r0, r4
	bl sub_20A4A78
_020A276C:
	ldr r0, [r4, #0x10]
	cmp r0, #2
	bne _020A2780
	mov r0, r4
	bl sub_20A491C
_020A2780:
	ldr r0, [r4, #0x10]
	cmp r0, #3
	bne _020A2794
	mov r0, r4
	bl sub_20A469C
_020A2794:
	ldr r0, [r4, #0x10]
	cmp r0, #4
	bne _020A27A8
	mov r0, r4
	bl sub_20A4604
_020A27A8:
	ldr r0, [r4, #0x10]
	cmp r0, #5
	bne _020A27BC
	mov r0, r4
	bl sub_20A4584
_020A27BC:
	ldr r0, [r4, #0x10]
	cmp r0, #6
	bne _020A27D0
	mov r0, r4
	bl sub_20A4304
_020A27D0:
	ldr r0, [r4, #0x10]
	cmp r0, #7
	bne _020A27E4
	mov r0, r4
	bl sub_20A39D0
_020A27E4:
	ldr r0, [r4, #0x10]
	cmp r0, #8
	bne _020A27F8
	mov r0, r4
	bl sub_20A38D8
_020A27F8:
	ldr r0, [r4, #0x108]
	cmp r0, #0
	beq _020A280C
	mov r0, r4
	bl sub_20A1C84
_020A280C:
	ldr r5, [r4, #0xfc]
	cmp r5, #0
	moveq r0, #0
	streq r0, [r4, #0x12c]
	beq _020A2838
	mov r0, r4
	bl sub_20A2850
	mov r0, r4
	bl sub_20A16EC
	mov r0, r4
	bl sub_20A1EAC
_020A2838:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A2844: .word aConnection_3
_020A2848: .word aGhttpmainC
_020A284C: .word aGhirequesttoco
	arm_func_end sub_20A26E0

	arm_func_start sub_20A2850
sub_20A2850: // 0x020A2850
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr lr, [r0, #0xec]
	ldr r3, _020A2928 // =0x51EB851F
	mov r1, lr, lsr #0x1f
	smull r2, ip, r3, lr
	mov ip, ip, asr #5
	add ip, r1, ip
	cmp ip, #5
	addls pc, pc, ip, lsl #2
	b _020A2920
_020A287C: // jump table
	b _020A2920 // case 0
	b _020A2894 // case 1
	b _020A2894 // case 2
	b _020A2894 // case 3
	b _020A289C // case 4
	b _020A2918 // case 5
_020A2894:
	add sp, sp, #4
	ldmia sp!, {pc}
_020A289C:
	ldr r1, _020A292C // =0x00000191
	sub r1, lr, r1
	cmp r1, #9
	addls pc, pc, r1, lsl #2
	b _020A2908
_020A28B0: // jump table
	b _020A28D8 // case 0
	b _020A2908 // case 1
	b _020A28E8 // case 2
	b _020A28F8 // case 3
	b _020A2908 // case 4
	b _020A2908 // case 5
	b _020A2908 // case 6
	b _020A2908 // case 7
	b _020A2908 // case 8
	b _020A28F8 // case 9
_020A28D8:
	mov r1, #9
	str r1, [r0, #0x38]
	add sp, sp, #4
	ldmia sp!, {pc}
_020A28E8:
	mov r1, #0xa
	str r1, [r0, #0x38]
	add sp, sp, #4
	ldmia sp!, {pc}
_020A28F8:
	mov r1, #0xb
	str r1, [r0, #0x38]
	add sp, sp, #4
	ldmia sp!, {pc}
_020A2908:
	mov r1, #8
	str r1, [r0, #0x38]
	add sp, sp, #4
	ldmia sp!, {pc}
_020A2918:
	mov r1, #0xc
	str r1, [r0, #0x38]
_020A2920:
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A2928: .word 0x51EB851F
_020A292C: .word 0x00000191
	arm_func_end sub_20A2850

	arm_func_start sub_20A2930
sub_20A2930: // 0x020A2930
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	movs r10, r0
	bne _020A2954
	ldr r0, _020A2B8C // =aConnection_4
	ldr r1, _020A2B90 // =aGhttppostC
	ldr r3, _020A2B94 // =0x00000404
	mov r2, #0
	bl __msl_assertion_failed
_020A2954:
	ldr r0, [r10, #0x13c]
	cmp r0, #0
	bne _020A2974
	ldr r0, _020A2B98 // =aConnectionPost
	ldr r1, _020A2B90 // =aGhttppostC
	ldr r3, _020A2B9C // =0x00000405
	mov r2, #0
	bl __msl_assertion_failed
_020A2974:
	ldr r0, [r10, #0x140]
	cmp r0, #0
	bne _020A2994
	ldr r0, _020A2BA0 // =aConnectionPost_0
	ldr r1, _020A2B90 // =aGhttppostC
	ldr r3, _020A2BA4 // =0x00000406
	mov r2, #0
	bl __msl_assertion_failed
_020A2994:
	ldr r0, [r10, #0x13c]
	ldr r0, [r0, #0]
	bl ArrayLength
	mov r4, r0
	ldr r0, [r10, #0x140]
	bl ArrayLength
	cmp r4, r0
	beq _020A29C8
	ldr r0, _020A2BA8 // =aArraylengthCon
	ldr r1, _020A2B90 // =aGhttppostC
	ldr r3, _020A2BAC // =0x00000407
	mov r2, #0
	bl __msl_assertion_failed
_020A29C8:
	ldr r0, [r10, #0x144]
	cmp r0, #0
	bge _020A29E8
	ldr r0, _020A2BB0 // =aConnectionPost_1
	ldr r1, _020A2B90 // =aGhttppostC
	ldr r3, _020A2BB4 // =0x00000408
	mov r2, #0
	bl __msl_assertion_failed
_020A29E8:
	ldr r0, [r10, #0x140]
	bl ArrayLength
	ldr r1, [r10, #0x144]
	cmp r1, r0
	ble _020A2A10
	ldr r0, _020A2BB8 // =aConnectionPost_2
	ldr r1, _020A2B90 // =aGhttppostC
	ldr r3, _020A2BBC // =0x00000409
	mov r2, #0
	bl __msl_assertion_failed
_020A2A10:
	ldr r0, [r10, #0x140]
	add r9, r10, #0x140
	bl ArrayLength
	ldr r1, [r10, #0x5c]
	mov r7, r0
	cmp r1, #0
	beq _020A2A78
	mov r0, r10
	bl sub_20A0DC8
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r10, #0x60]
	ldr r0, [r10, #0x5c]
	cmp r1, r0
	addlt sp, sp, #4
	movlt r0, #2
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r10, #0x50
	bl sub_20A0EA0
	ldr r0, [r10, #0x144]
	cmp r0, r7
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A2A78:
	ldr r1, [r9, #4]
	cmp r1, r7
	bge _020A2B3C
	ldr r6, _020A2BC0 // =aPoststate
	ldr r11, _020A2B90 // =aGhttppostC
	mov r5, #0
	mov r4, #1
_020A2A94:
	ldr r0, [r9, #0]
	bl ArrayNth
	movs r8, r0
	bne _020A2AB8
	ldr r3, _020A2BC4 // =0x0000042F
	mov r0, r6
	mov r1, r11
	mov r2, r5
	bl __msl_assertion_failed
_020A2AB8:
	ldr r0, [r9, #4]
	mov r1, r10
	cmp r0, #0
	moveq r2, r4
	movne r2, r5
	mov r0, r8
	bl sub_20A2BD4
	cmp r0, #0
	bne _020A2B14
	ldr r0, [r10, #0xfc]
	cmp r0, #0
	beq _020A2AF4
	ldr r0, [r10, #0x38]
	cmp r0, #0
	bne _020A2B08
_020A2AF4:
	ldr r0, _020A2BC8 // =aConnectionComp
	ldr r1, _020A2B90 // =aGhttppostC
	ldr r3, _020A2BCC // =0x0000043B
	mov r2, #0
	bl __msl_assertion_failed
_020A2B08:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A2B14:
	cmp r0, #2
	addeq sp, sp, #4
	moveq r0, #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r9, #4]
	add r0, r0, #1
	str r0, [r9, #4]
	ldr r1, [r9, #4]
	cmp r1, r7
	blt _020A2A94
_020A2B3C:
	ldr r0, [r10, #0x13c]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	beq _020A2B74
	ldr r0, _020A2BD0 // =aQr4g823s23d7d1
	bl strlen
	mov r2, r0
	ldr r1, _020A2BD0 // =aQr4g823s23d7d1
	mov r0, r10
	bl sub_20A1778
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A2B74:
	ldr r0, [r10, #0x5c]
	cmp r0, #0
	movne r0, #2
	moveq r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A2B8C: .word aConnection_4
_020A2B90: .word aGhttppostC
_020A2B94: .word 0x00000404
_020A2B98: .word aConnectionPost
_020A2B9C: .word 0x00000405
_020A2BA0: .word aConnectionPost_0
_020A2BA4: .word 0x00000406
_020A2BA8: .word aArraylengthCon
_020A2BAC: .word 0x00000407
_020A2BB0: .word aConnectionPost_1
_020A2BB4: .word 0x00000408
_020A2BB8: .word aConnectionPost_2
_020A2BBC: .word 0x00000409
_020A2BC0: .word aPoststate
_020A2BC4: .word 0x0000042F
_020A2BC8: .word aConnectionComp
_020A2BCC: .word 0x0000043B
_020A2BD0: .word aQr4g823s23d7d1
	arm_func_end sub_20A2930

	arm_func_start sub_20A2BD4
sub_20A2BD4: // 0x020A2BD4
	stmdb sp!, {r4, r5, r6, lr}
	ldr ip, _020A2DB0 // =0x00000808
	sub sp, sp, ip
	mov r6, r0
	ldr r3, [r6, #4]
	mvn r0, #0
	mov r5, r1
	mov r4, r2
	cmp r3, r0
	bne _020A2D34
	mov r2, #0
	str r2, [r6, #4]
	ldr r0, [r5, #0x13c]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _020A2C6C
	ldr r0, [r6, #0]
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _020A2C34
	ldr r0, _020A2DB4 // =aStateDataTypeG
	ldr r1, _020A2DB8 // =aGhttppostC
	ldr r3, _020A2DBC // =0x000003A9
	bl __msl_assertion_failed
_020A2C34:
	cmp r4, #0
	beq _020A2C54
	ldr r1, [r6, #0]
	add r0, sp, #8
	ldr r2, [r1, #4]
	ldr r1, _020A2DC0 // =0x0211CA78
	bl sprintf
	b _020A2CF4
_020A2C54:
	ldr r1, [r6, #0]
	add r0, sp, #8
	ldr r2, [r1, #4]
	ldr r1, _020A2DC4 // =0x0211CA7C
	bl sprintf
	b _020A2CF4
_020A2C6C:
	ldr r3, [r6, #0]
	ldr r1, [r3, #0]
	cmp r1, #0
	bne _020A2C9C
	cmp r4, #0
	ldrne r2, _020A2DC8 // =aQr4g823s23d7d1_0
	ldr r3, [r3, #4]
	ldreq r2, _020A2DCC // =aQr4g823s23d7d1_1
	ldr r1, _020A2DD0 // =aScontentDispos
	add r0, sp, #8
	bl sprintf
	b _020A2CF4
_020A2C9C:
	sub r0, r1, #1
	cmp r0, #1
	bhi _020A2CE4
	cmp r1, #1
	ldreq r1, [r3, #0xc]
	ldreq r0, [r3, #0x10]
	ldrne r1, [r3, #0x10]
	ldrne r0, [r3, #0x14]
	cmp r4, #0
	str r1, [sp]
	str r0, [sp, #4]
	ldrne r2, _020A2DC8 // =aQr4g823s23d7d1_0
	ldr r3, [r3, #4]
	ldreq r2, _020A2DCC // =aQr4g823s23d7d1_1
	ldr r1, _020A2DD4 // =aScontentDispos_0
	add r0, sp, #8
	bl sprintf
	b _020A2CF4
_020A2CE4:
	ldr r0, _020A2DD8 // =0x0211CB5C
	ldr r1, _020A2DB8 // =aGhttppostC
	mov r3, #0x3dc
	bl __msl_assertion_failed
_020A2CF4:
	add r0, sp, #8
	bl strlen
	mov r2, r0
	add r1, sp, #8
	mov r0, r5
	bl sub_20A1778
	cmp r0, #0
	ldreq ip, _020A2DB0 // =0x00000808
	moveq r0, #0
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r0, #2
	ldreq ip, _020A2DB0 // =0x00000808
	moveq r0, #2
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, pc}
_020A2D34:
	ldr r0, [r6, #0]
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _020A2D5C
	mov r0, r6
	mov r1, r5
	bl sub_20A3044
	ldr ip, _020A2DB0 // =0x00000808
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, pc}
_020A2D5C:
	cmp r0, #1
	bne _020A2D7C
	mov r0, r6
	mov r1, r5
	bl sub_20A2ED8
	ldr ip, _020A2DB0 // =0x00000808
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, pc}
_020A2D7C:
	cmp r0, #2
	beq _020A2D98
	ldr r0, _020A2DDC // =aStateDataTypeG_0
	ldr r1, _020A2DB8 // =aGhttppostC
	ldr r3, _020A2DE0 // =0x000003F5
	mov r2, #0
	bl __msl_assertion_failed
_020A2D98:
	mov r0, r6
	mov r1, r5
	bl sub_20A2DE4
	ldr ip, _020A2DB0 // =0x00000808
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A2DB0: .word 0x00000808
_020A2DB4: .word aStateDataTypeG
_020A2DB8: .word aGhttppostC
_020A2DBC: .word 0x000003A9
_020A2DC0: .word 0x0211CA78
_020A2DC4: .word 0x0211CA7C
_020A2DC8: .word aQr4g823s23d7d1_0
_020A2DCC: .word aQr4g823s23d7d1_1
_020A2DD0: .word aScontentDispos
_020A2DD4: .word aScontentDispos_0
_020A2DD8: .word 0x0211CB5C
_020A2DDC: .word aStateDataTypeG_0
_020A2DE0: .word 0x000003F5
	arm_func_end sub_20A2BD4

	arm_func_start sub_20A2DE4
sub_20A2DE4: // 0x020A2DE4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, [r5, #4]
	mov r4, r1
	cmp r0, #0
	bge _020A2E14
	ldr r0, _020A2EC4 // =aStatePos0
	ldr r1, _020A2EC8 // =aGhttppostC
	ldr r3, _020A2ECC // =0x0000036E
	mov r2, #0
	bl __msl_assertion_failed
_020A2E14:
	ldr r0, [r5, #0]
	ldr r1, [r0, #0xc]
	cmp r1, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r5, #4]
	cmp r0, r1
	blt _020A2E4C
	ldr r0, _020A2ED0 // =aStatePosStateD
	ldr r1, _020A2EC8 // =aGhttppostC
	ldr r3, _020A2ED4 // =0x00000375
	mov r2, #0
	bl __msl_assertion_failed
_020A2E4C:
	ldr r1, [r5, #0]
	ldr r3, [r5, #4]
	ldr r0, [r1, #0xc]
	ldr r1, [r1, #8]
	sub r2, r0, r3
	cmp r2, #0x8000
	movge r2, #0x8000
	mov r0, r4
	add r1, r1, r3
	bl sub_20A17DC
	mvn r1, #0
	cmp r0, r1
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, [r5, #4]
	add r1, r1, r0
	str r1, [r5, #4]
	ldr r2, [r5, #0]
	ldr r1, [r5, #4]
	ldr r2, [r2, #0xc]
	cmp r2, r1
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
	cmp r0, #0
	bne _020A2E4C
	mov r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A2EC4: .word aStatePos0
_020A2EC8: .word aGhttppostC
_020A2ECC: .word 0x0000036E
_020A2ED0: .word aStatePosStateD
_020A2ED4: .word 0x00000375
	arm_func_end sub_20A2DE4

	arm_func_start sub_20A2ED8
sub_20A2ED8: // 0x020A2ED8
	stmdb sp!, {r4, r5, lr}
	ldr ip, _020A3028 // =0x00001004
	sub sp, sp, ip
	mov r5, r0
	ldr r0, [r5, #4]
	mov r4, r1
	cmp r0, #0
	bge _020A2F0C
	ldr r0, _020A302C // =aStatePos0
	ldr r1, _020A3030 // =aGhttppostC
	ldr r3, _020A3034 // =0x00000336
	mov r2, #0
	bl __msl_assertion_failed
_020A2F0C:
	ldr r1, [r5, #4]
	ldr r0, [r5, #0xc]
	cmp r1, r0
	blt _020A2F30
	ldr r0, _020A3038 // =aStatePosStateS
	ldr r1, _020A3030 // =aGhttppostC
	ldr r3, _020A303C // =0x00000337
	mov r2, #0
	bl __msl_assertion_failed
_020A2F30:
	ldr r0, [r5, #8]
	bl ftell
	ldr r1, [r5, #4]
	cmp r1, r0
	beq _020A2F58
	ldr r0, _020A3040 // =aStatePosIntFte
	ldr r1, _020A3030 // =aGhttppostC
	mov r2, #0
	mov r3, #0x338
	bl __msl_assertion_failed
_020A2F58:
	ldr r3, [r5, #8]
	add r0, sp, #0
	mov r1, #1
	mov r2, #0x1000
	bl fread
	mov r2, r0
	cmp r2, #0
	bgt _020A2F98
	ldr ip, _020A3028 // =0x00001004
	mov r0, #1
	str r0, [r4, #0xfc]
	mov r0, #0xe
	str r0, [r4, #0x38]
	add sp, sp, ip
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020A2F98:
	ldr r0, [r5, #4]
	add r0, r0, r2
	str r0, [r5, #4]
	ldr r1, [r5, #4]
	ldr r0, [r5, #0xc]
	cmp r1, r0
	ble _020A2FD4
	ldr ip, _020A3028 // =0x00001004
	mov r0, #1
	str r0, [r4, #0xfc]
	mov r0, #0xe
	str r0, [r4, #0x38]
	add sp, sp, ip
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020A2FD4:
	add r1, sp, #0
	mov r0, r4
	bl sub_20A1778
	cmp r0, #0
	ldreq ip, _020A3028 // =0x00001004
	moveq r0, #0
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, pc}
	ldr r2, [r5, #4]
	ldr r1, [r5, #0xc]
	cmp r2, r1
	ldreq ip, _020A3028 // =0x00001004
	moveq r0, #1
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, pc}
	cmp r0, #1
	beq _020A2F58
	mov r0, #2
	ldr ip, _020A3028 // =0x00001004
	add sp, sp, ip
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A3028: .word 0x00001004
_020A302C: .word aStatePos0
_020A3030: .word aGhttppostC
_020A3034: .word 0x00000336
_020A3038: .word aStatePosStateS
_020A303C: .word 0x00000337
_020A3040: .word aStatePosIntFte
	arm_func_end sub_20A2ED8

	arm_func_start sub_20A3044
sub_20A3044: // 0x020A3044
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #4]
	mov r10, r1
	cmp r0, #0
	bge _020A3074
	ldr r0, _020A3218 // =aStatePos0
	ldr r1, _020A321C // =aGhttppostC
	ldr r3, _020A3220 // =0x000002E7
	mov r2, #0
	bl __msl_assertion_failed
_020A3074:
	ldr r0, [r4, #0]
	ldr r1, [r0, #0xc]
	cmp r1, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r4, #4]
	cmp r0, r1
	blt _020A30AC
	ldr r0, _020A3224 // =aStatePosStateD_0
	ldr r1, _020A321C // =aGhttppostC
	ldr r3, _020A3228 // =0x000002EE
	mov r2, #0
	bl __msl_assertion_failed
_020A30AC:
	ldr r0, [r10, #0x13c]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	bne _020A31C4
	ldr r1, [r4, #0]
	ldr r0, [r1, #0x10]
	cmp r0, #0
	beq _020A31C4
	ldr r0, _020A322C // =0x0211266C
	ldr r7, [r1, #8]
	ldrb r3, [r0, #0]
	ldrb r2, [r0, #1]
	ldrb r1, [r0, #2]
	ldrb r0, [r0, #3]
	strb r3, [sp]
	strb r2, [sp, #1]
	strb r1, [sp, #2]
	strb r0, [sp, #3]
	ldrsb r8, [r7, #0]
	mov r9, #0
	cmp r8, #0
	beq _020A31B8
	mov r11, r9
	mov r4, #3
	mov r5, #0x2b
_020A3110:
	ldr r0, _020A3230 // =aAbcdefghijklmn
	mov r1, r8
	bl strchr
	cmp r0, #0
	beq _020A3134
	mov r1, r8
	add r0, r10, #0x50
	bl sub_20A0F18
	b _020A31A8
_020A3134:
	cmp r8, #0x20
	bne _020A314C
	mov r1, r5
	add r0, r10, #0x50
	bl sub_20A0F18
	b _020A31A8
_020A314C:
	mov r0, r8, asr #3
	add r0, r8, r0, lsr #28
	mov r6, r0, asr #4
	cmp r6, #0x10
	blt _020A3174
	ldr r0, _020A3234 // =aC1616
	ldr r1, _020A321C // =aGhttppostC
	ldr r3, _020A3238 // =0x0000030D
	mov r2, r11
	bl __msl_assertion_failed
_020A3174:
	ldr r0, _020A323C // =a0123456789abcd_1
	mov r1, r8, lsr #0x1f
	ldrsb r2, [r0, r6]
	rsb r0, r1, r8, lsl #28
	add r1, r1, r0, ror #28
	ldr r0, _020A323C // =a0123456789abcd_1
	strb r2, [sp, #1]
	ldrsb r2, [r0, r1]
	add r1, sp, #0
	add r0, r10, #0x50
	strb r2, [sp, #2]
	mov r2, r4
	bl sub_20A1008
_020A31A8:
	add r9, r9, #1
	ldrsb r8, [r7, r9]
	cmp r8, #0
	bne _020A3110
_020A31B8:
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A31C4:
	ldr r1, [r4, #0]
	ldr r0, [r4, #4]
	ldr r2, [r1, #0xc]
	ldr r1, [r1, #8]
	sub r5, r2, r0
	mov r0, r10
	mov r2, r5
	bl sub_20A17DC
	mvn r1, #0
	cmp r0, r1
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r4, #4]
	cmp r0, r5
	add r0, r1, r0
	str r0, [r4, #4]
	moveq r0, #1
	movne r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A3218: .word aStatePos0
_020A321C: .word aGhttppostC
_020A3220: .word 0x000002E7
_020A3224: .word aStatePosStateD_0
_020A3228: .word 0x000002EE
_020A322C: .word 0x0211266C
_020A3230: .word aAbcdefghijklmn
_020A3234: .word aC1616
_020A3238: .word 0x0000030D
_020A323C: .word a0123456789abcd_1
	arm_func_end sub_20A3044

	arm_func_start sub_20A3240
sub_20A3240: // 0x020A3240
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x140]
	cmp r0, #0
	beq _020A3294
	bl ArrayLength
	mov r4, r0
	cmp r4, #0
	mov r5, #0
	ble _020A3284
_020A3268:
	ldr r0, [r6, #0x140]
	mov r1, r5
	bl ArrayNth
	bl sub_20A3450
	add r5, r5, #1
	cmp r5, r4
	blt _020A3268
_020A3284:
	ldr r0, [r6, #0x140]
	bl ArrayFree
	mov r0, #0
	str r0, [r6, #0x140]
_020A3294:
	ldr r0, [r6, #0x13c]
	cmp r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r0, #0x10]
	cmp r1, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl sub_20A38B4
	mov r0, #0
	str r0, [r6, #0x13c]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20A3240

	arm_func_start sub_20A32BC
sub_20A32BC: // 0x020A32BC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r4, r0
	ldr r0, [r4, #0x13c]
	cmp r0, #0
	bne _020A32E8
	ldr r0, _020A3440 // =aConnectionPost
	ldr r1, _020A3444 // =aGhttppostC
	mov r2, #0
	mov r3, #0x278
	bl __msl_assertion_failed
_020A32E8:
	ldr r0, [r4, #0x13c]
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #0
	str r0, [r4, #0x144]
	str r0, [r4, #0x148]
	str r0, [r4, #0x14c]
	ldr r0, [r4, #0x13c]
	ldr r0, [r0, #4]
	str r0, [r4, #0x150]
	ldr r0, [r4, #0x13c]
	ldr r0, [r0, #8]
	str r0, [r4, #0x154]
	ldr r0, [r4, #0x13c]
	ldr r0, [r0, #0]
	bl ArrayLength
	mov r7, r0
	mov r1, r7
	mov r0, #0x10
	mov r2, #0
	bl sub_209FB2C
	str r0, [r4, #0x140]
	ldr r0, [r4, #0x140]
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r7, #0
	mov r8, #0
	ble _020A33F4
	add r6, sp, #0
	mov r5, r8
_020A3370:
	ldr r0, [r4, #0x13c]
	mov r1, r8
	ldr r0, [r0, #0]
	bl ArrayNth
	str r5, [r6]
	str r5, [r6, #4]
	str r5, [r6, #8]
	str r5, [r6, #0xc]
	str r0, [sp]
	mov r0, r6
	bl sub_20A34B8
	cmp r0, #0
	bne _020A33DC
	subs r8, r8, #1
	bmi _020A33C4
_020A33AC:
	ldr r0, [r4, #0x140]
	mov r1, r8
	bl ArrayNth
	bl sub_20A3450
	subs r8, r8, #1
	bpl _020A33AC
_020A33C4:
	ldr r0, [r4, #0x140]
	bl ArrayFree
	mov r0, #0
	add sp, sp, #0x10
	str r0, [r4, #0x140]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A33DC:
	ldr r0, [r4, #0x140]
	mov r1, r6
	bl ArrayAppend
	add r8, r8, #1
	cmp r8, r7
	blt _020A3370
_020A33F4:
	ldr r0, [r4, #0x13c]
	ldr r0, [r0, #0]
	bl ArrayLength
	mov r5, r0
	ldr r0, [r4, #0x140]
	bl ArrayLength
	cmp r5, r0
	beq _020A3428
	ldr r0, _020A3448 // =aArraylengthCon
	ldr r1, _020A3444 // =aGhttppostC
	ldr r3, _020A344C // =0x000002B1
	mov r2, #0
	bl __msl_assertion_failed
_020A3428:
	mov r0, r4
	bl sub_20A3568
	str r0, [r4, #0x14c]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020A3440: .word aConnectionPost
_020A3444: .word aGhttppostC
_020A3448: .word aArraylengthCon
_020A344C: .word 0x000002B1
	arm_func_end sub_20A32BC

	arm_func_start sub_20A3450
sub_20A3450: // 0x020A3450
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	ldr r0, [r0, #0]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	cmp r0, #1
	bne _020A348C
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _020A3480
	bl fclose
_020A3480:
	mov r0, #0
	str r0, [r4, #8]
	ldmia sp!, {r4, pc}
_020A348C:
	cmp r0, #2
	ldmeqia sp!, {r4, pc}
	ldr r0, _020A34AC // =0x0211CB5C
	ldr r1, _020A34B0 // =aGhttppostC
	ldr r3, _020A34B4 // =0x00000269
	mov r2, #0
	bl __msl_assertion_failed
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A34AC: .word 0x0211CB5C
_020A34B0: .word aGhttppostC
_020A34B4: .word 0x00000269
	arm_func_end sub_20A3450

	arm_func_start sub_20A34B8
sub_20A34B8: // 0x020A34B8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0]
	mvn r0, #0
	ldr r1, [r1, #0]
	str r0, [r4, #4]
	cmp r1, #0
	beq _020A3558
	cmp r1, #1
	bne _020A3534
	ldr r0, [r4, #8]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r2, #2
	bl fseek
	cmp r0, #0
	movne r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #8]
	bl ftell
	str r0, [r4, #0xc]
	ldr r1, [r4, #0xc]
	mvn r0, #0
	cmp r1, r0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #8]
	bl rewind
	b _020A3558
_020A3534:
	cmp r1, #2
	beq _020A3558
	ldr r0, _020A3560 // =0x0211CB5C
	ldr r1, _020A3564 // =aGhttppostC
	mov r2, #0
	mov r3, #0x244
	bl __msl_assertion_failed
	mov r0, #0
	ldmia sp!, {r4, pc}
_020A3558:
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A3560: .word 0x0211CB5C
_020A3564: .word aGhttppostC
	arm_func_end sub_20A34B8

	arm_func_start sub_20A3568
sub_20A3568: // 0x020A3568
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r4, [r5, #0x13c]
	cmp r4, #0
	bne _020A3594
	ldr r0, _020A35D0 // =0x0211CCB8
	ldr r1, _020A35D4 // =aGhttppostC
	mov r2, #0
	mov r3, #0x20c
	bl __msl_assertion_failed
_020A3594:
	cmp r4, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r4, #0xc]
	cmp r0, #0
	beq _020A35C0
	mov r0, r5
	bl sub_20A35D8
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020A35C0:
	mov r0, r5
	bl sub_20A37A4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A35D0: .word 0x0211CCB8
_020A35D4: .word aGhttppostC
	arm_func_end sub_20A3568

	arm_func_start sub_20A35D8
sub_20A35D8: // 0x020A35D8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r1, _020A3780 // =0x02144E68
	mov r8, r0
	ldr r0, [r1, #0]
	ldr r7, [r8, #0x13c]
	cmp r0, #0
	mov r4, #0
	bne _020A3630
	ldr r0, _020A3784 // =aQr4g823s23d7d1_2
	bl strlen
	ldr r5, _020A3780 // =0x02144E68
	ldr r3, _020A3788 // =0x02144E64
	add r10, r0, #0x2f
	ldr r2, _020A378C // =0x02144E60
	add r9, r0, #0x4c
	ldr r1, _020A3790 // =0x02144E5C
	add r6, r0, #4
	str r0, [r5]
	str r10, [r3]
	str r9, [r2]
	str r6, [r1]
_020A3630:
	ldr r0, [r7, #0]
	bl ArrayLength
	mov r5, r0
	cmp r5, #0
	mov r6, #0
	ble _020A376C
	mov r11, r6
	mov r9, #0x1ec
_020A3650:
	ldr r0, [r7, #0]
	mov r1, r6
	bl ArrayNth
	mov r10, r0
	ldr r0, [r10, #0]
	cmp r0, #0
	bne _020A3690
	ldr r0, _020A3788 // =0x02144E64
	ldr r1, [r0, #0]
	ldr r0, [r10, #4]
	add r4, r4, r1
	bl strlen
	add r1, r4, r0
	ldr r0, [r10, #0xc]
	add r4, r1, r0
	b _020A3760
_020A3690:
	cmp r0, #1
	bne _020A36FC
	ldr r0, _020A378C // =0x02144E60
	ldr r1, [r0, #0]
	ldr r0, [r10, #4]
	add r4, r4, r1
	bl strlen
	add r4, r4, r0
	ldr r0, [r10, #0xc]
	bl strlen
	add r4, r4, r0
	ldr r0, [r10, #0x10]
	bl strlen
	add r4, r4, r0
	ldr r0, [r8, #0x140]
	mov r1, r6
	bl ArrayNth
	movs r10, r0
	bne _020A36F0
	ldr r0, _020A3794 // =aState
	ldr r1, _020A3798 // =aGhttppostC
	mov r2, r11
	mov r3, r9
	bl __msl_assertion_failed
_020A36F0:
	ldr r0, [r10, #0xc]
	add r4, r4, r0
	b _020A3760
_020A36FC:
	cmp r0, #2
	bne _020A3740
	ldr r0, _020A378C // =0x02144E60
	ldr r1, [r0, #0]
	ldr r0, [r10, #4]
	add r4, r4, r1
	bl strlen
	add r4, r4, r0
	ldr r0, [r10, #0x10]
	bl strlen
	add r4, r4, r0
	ldr r0, [r10, #0x14]
	bl strlen
	add r1, r4, r0
	ldr r0, [r10, #0xc]
	add r4, r1, r0
	b _020A3760
_020A3740:
	ldr r0, _020A379C // =0x0211CB5C
	ldr r1, _020A3798 // =aGhttppostC
	ldr r3, _020A37A0 // =0x000001F9
	mov r2, #0
	bl __msl_assertion_failed
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A3760:
	add r6, r6, #1
	cmp r6, r5
	blt _020A3650
_020A376C:
	ldr r0, _020A3790 // =0x02144E5C
	ldr r0, [r0, #0]
	add r0, r4, r0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A3780: .word 0x02144E68
_020A3784: .word aQr4g823s23d7d1_2
_020A3788: .word 0x02144E64
_020A378C: .word 0x02144E60
_020A3790: .word 0x02144E5C
_020A3794: .word aState
_020A3798: .word aGhttppostC
_020A379C: .word 0x0211CB5C
_020A37A0: .word 0x000001F9
	arm_func_end sub_20A35D8

	arm_func_start sub_20A37A4
sub_20A37A4: // 0x020A37A4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r10, [r0, #0x13c]
	mov r6, #0
	ldr r0, [r10, #0]
	bl ArrayLength
	movs r7, r0
	addeq sp, sp, #4
	moveq r0, r6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r7, #0
	mov r8, r6
	ble _020A3840
	ldr r11, _020A3850 // =aDataTypeGhistr
	mov r5, r8
	mov r4, #0x1b0
_020A37E4:
	ldr r0, [r10, #0]
	mov r1, r8
	bl ArrayNth
	mov r9, r0
	ldr r0, [r9, #0]
	cmp r0, #0
	beq _020A3814
	ldr r1, _020A3854 // =aGhttppostC
	mov r0, r11
	mov r2, r5
	mov r3, r4
	bl __msl_assertion_failed
_020A3814:
	ldr r0, [r9, #4]
	bl strlen
	add r8, r8, #1
	ldr r1, [r9, #0xc]
	add r2, r6, r0
	ldr r0, [r9, #0x14]
	add r1, r2, r1
	add r0, r1, r0, lsl #1
	cmp r8, r7
	add r6, r0, #1
	blt _020A37E4
_020A3840:
	sub r0, r7, #1
	add r0, r6, r0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A3850: .word aDataTypeGhistr
_020A3854: .word aGhttppostC
	arm_func_end sub_20A37A4

	arm_func_start sub_20A3858
sub_20A3858: // 0x020A3858
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #0x13c]
	cmp r4, #0
	bne _020A387C
	ldr r0, _020A389C // =0x0211CCB8
	ldr r1, _020A38A0 // =aGhttppostC
	ldr r3, _020A38A4 // =0x00000192
	mov r2, #0
	bl __msl_assertion_failed
_020A387C:
	cmp r4, #0
	ldreq r0, _020A38A8 // =_0211CD08
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0xc]
	cmp r0, #0
	ldrne r0, _020A38AC // =aMultipartFormD
	ldreq r0, _020A38B0 // =aApplicationXWw
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A389C: .word 0x0211CCB8
_020A38A0: .word aGhttppostC
_020A38A4: .word 0x00000192
_020A38A8: .word _0211CD08
_020A38AC: .word aMultipartFormD
_020A38B0: .word aApplicationXWw
	arm_func_end sub_20A3858

	arm_func_start sub_20A38B4
sub_20A38B4: // 0x020A38B4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	bl ArrayFree
	mov r0, r4
	bl DWCi_GsFree
	ldmia sp!, {r4, pc}
	arm_func_end sub_20A38B4

	arm_func_start sub_20A38D0
sub_20A38D0: // 0x020A38D0
	ldr r0, [r0, #0x10]
	bx lr
	arm_func_end sub_20A38D0

	arm_func_start sub_20A38D8
sub_20A38D8: // 0x020A38D8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr ip, _020A39CC // =0x00002008
	sub sp, sp, ip
	mov r5, r0
	bl sub_20A0CA4
	mov r4, r0
	mov r1, #0
	mov r8, #0x2000
	add r7, sp, #4
	add r6, sp, #0
	b _020A39A0
_020A3904:
	mov r0, r5
	mov r1, r7
	mov r2, r6
	str r8, [sp]
	bl sub_20A1864
	cmp r0, #3
	ldreq ip, _020A39CC // =0x00002008
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r0, #1
	ldreq ip, _020A39CC // =0x00002008
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r0, #2
	bne _020A3978
	mov r0, #1
	str r0, [r5, #0xfc]
	ldr r1, [r5, #0x104]
	cmp r1, #0
	ldrle ip, _020A39CC // =0x00002008
	addle sp, sp, ip
	ldmleia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r5, #0x100]
	ldr ip, _020A39CC // =0x00002008
	cmp r0, r1
	movlt r0, #0xf
	add sp, sp, ip
	strlt r0, [r5, #0x38]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A3978:
	ldr r2, [sp]
	mov r0, r5
	mov r1, r7
	bl sub_20A3E9C
	cmp r0, #0
	ldreq ip, _020A39CC // =0x00002008
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	bl sub_20A0CA4
	sub r1, r0, r4
_020A39A0:
	ldr r0, [r5, #0xfc]
	cmp r0, #0
	ldrne ip, _020A39CC // =0x00002008
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r5, #0x158]
	cmp r1, r0
	blo _020A3904
	ldr ip, _020A39CC // =0x00002008
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020A39CC: .word 0x00002008
	arm_func_end sub_20A38D8

	arm_func_start sub_20A39D0
sub_20A39D0: // 0x020A39D0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr ip, _020A3E74 // =0x00001018
	sub sp, sp, ip
	mov r3, #0x1000
	add r1, sp, #0x13
	add r2, sp, #4
	mov r6, r0
	str r3, [sp, #4]
	bl sub_20A1864
	mov r4, r0
	cmp r4, #3
	ldreq ip, _020A3E74 // =0x00001018
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	cmp r4, #1
	bne _020A3A28
	ldr r1, [r6, #0x84]
	ldr r0, [r6, #0x80]
	cmp r1, r0
	ldreq ip, _020A3E74 // =0x00001018
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A3A28:
	cmp r4, #0
	bne _020A3A50
	ldr r2, [sp, #4]
	add r1, sp, #0x13
	add r0, r6, #0x74
	bl sub_20A1008
	cmp r0, #0
	ldreq ip, _020A3E74 // =0x00001018
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A3A50:
	ldr r2, [r6, #0x84]
	ldr r0, [r6, #0x78]
	ldr r1, _020A3E78 // =0x0211CD74
	add r5, r0, r2
	mov r0, r5
	str r2, [r6, #0xf4]
	bl strstr
	cmp r0, #0
	bne _020A3A80
	ldr r1, _020A3E7C // =0x0211CD7C
	mov r0, r5
	bl strstr
_020A3A80:
	cmp r0, #0
	beq _020A3E3C
	mov r1, #0
	strb r1, [r0, #2]
	ldr r7, [r6, #0x78]
	add r3, r0, #2
	ldr r1, [r6, #0x80]
	sub r2, r3, r7
	str r2, [r6, #0x80]
	ldr r2, [r6, #0x78]
	add r4, r0, #4
	sub r0, r3, r2
	str r0, [r6, #0xf8]
	ldr r0, [r6, #0xf8]
	sub r8, r4, r7
	str r0, [r6, #0x84]
	ldr r2, [r6, #0xec]
	ldr r3, _020A3E80 // =0x51EB851F
	mov r0, r2, lsr #0x1f
	smull r2, r7, r3, r2
	mov r7, r7, asr #5
	add r7, r0, r7
	cmp r7, #1
	sub r10, r1, r8
	bne _020A3B38
	cmp r10, #0
	beq _020A3B0C
	ldr r0, [r6, #0x78]
	mov r1, r4
	add r2, r10, #1
	bl memmove
	str r10, [r6, #0x80]
	mov r0, #0
	str r0, [r6, #0x84]
	b _020A3B14
_020A3B0C:
	add r0, r6, #0x74
	bl sub_20A0EA0
_020A3B14:
	mov r1, #0
	mov r3, #6
	mov r0, r6
	mov r2, r1
	str r3, [r6, #0x10]
	bl sub_20A1674
	ldr ip, _020A3E74 // =0x00001018
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A3B38:
	cmp r7, #3
	bne _020A3CA4
	ldr r0, [r6, #0x10c]
	cmp r0, #0xa
	ldrgt ip, _020A3E74 // =0x00001018
	movgt r0, #1
	strgt r0, [r6, #0xfc]
	movgt r0, #0xb
	addgt sp, sp, ip
	strgt r0, [r6, #0x38]
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r1, _020A3E84 // =aLocation
	mov r0, r5
	bl strstr
	cmp r0, #0
	beq _020A3CA4
	add r4, r0, #9
	ldr r1, _020A3E88 // =_0211714C
	mov r2, #0
	b _020A3B8C
_020A3B88:
	add r4, r4, #1
_020A3B8C:
	ldrsb r0, [r4, #0]
	cmp r0, #0
	blt _020A3BA0
	cmp r0, #0x80
	blt _020A3BA8
_020A3BA0:
	mov r0, r2
	b _020A3BB4
_020A3BA8:
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	and r0, r0, #0x100
_020A3BB4:
	cmp r0, #0
	bne _020A3B88
	mov r3, r4
	ldr r1, _020A3E88 // =_0211714C
	mov r2, #0
	b _020A3BD0
_020A3BCC:
	add r3, r3, #1
_020A3BD0:
	ldrsb r0, [r3, #0]
	cmp r0, #0
	beq _020A3C08
	cmp r0, #0
	blt _020A3BEC
	cmp r0, #0x80
	blt _020A3BF4
_020A3BEC:
	mov r0, r2
	b _020A3C00
_020A3BF4:
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	and r0, r0, #0x100
_020A3C00:
	cmp r0, #0
	beq _020A3BCC
_020A3C08:
	mov r0, #0
	strb r0, [r3]
	ldrsb r0, [r4, #0]
	cmp r0, #0x2f
	bne _020A3C78
	ldr r0, [r6, #0x18]
	bl strlen
	mov r5, r0
	mov r0, r4
	bl strlen
	add r1, r5, #0xe
	add r0, r1, r0
	bl DWCi_GsMalloc
	str r0, [r6, #0x108]
	ldr r0, [r6, #0x108]
	ldr r1, _020A3E8C // =aHttpSDS
	cmp r0, #0
	moveq r0, #1
	streq r0, [r6, #0xfc]
	streq r0, [r6, #0x38]
	str r4, [sp]
	ldrh r3, [r6, #0x20]
	ldr r0, [r6, #0x108]
	ldr r2, [r6, #0x18]
	bl sprintf
	ldr ip, _020A3E74 // =0x00001018
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A3C78:
	mov r0, r4
	bl sub_20A0C50
	str r0, [r6, #0x108]
	ldr r0, [r6, #0x108]
	ldr ip, _020A3E74 // =0x00001018
	cmp r0, #0
	moveq r0, #1
	streq r0, [r6, #0xfc]
	add sp, sp, ip
	streq r0, [r6, #0x38]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A3CA4:
	ldr r1, _020A3E90 // =aContentLength_1
	mov r0, r5
	bl strstr
	movs r9, r0
	beq _020A3D8C
	ldr r7, _020A3E94 // =a2147483647
	add r3, sp, #8
	mov r2, #5
_020A3CC4:
	ldrb r1, [r7], #1
	ldrb r0, [r7], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _020A3CC4
	ldrb r1, [r7, #0]
	add r8, r9, #0x10
	add r0, sp, #8
	mov r7, r8
	strb r1, [r3]
	bl strlen
	b _020A3CFC
_020A3CF8:
	add r7, r7, #1
_020A3CFC:
	cmp r7, #0
	beq _020A3D28
	ldrsb r1, [r7, #0]
	cmp r1, #0
	beq _020A3D28
	cmp r1, #0xa
	beq _020A3D28
	cmp r1, #0xd
	beq _020A3D28
	cmp r1, #0x20
	bne _020A3CF8
_020A3D28:
	sub r2, r7, r8
	cmp r2, r0
	ldrgt ip, _020A3E74 // =0x00001018
	movgt r0, #1
	strgt r0, [r6, #0xfc]
	movgt r0, #0x10
	addgt sp, sp, ip
	strgt r0, [r6, #0x38]
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	cmp r0, r2
	bne _020A3D80
	add r1, sp, #8
	mov r0, r8
	bl strncmp
	cmp r0, #0
	ldrge ip, _020A3E74 // =0x00001018
	movge r0, #1
	strge r0, [r6, #0xfc]
	movge r0, #0x10
	addge sp, sp, ip
	strge r0, [r6, #0x38]
	ldmgeia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A3D80:
	mov r0, r8
	bl atoi
	str r0, [r6, #0x104]
_020A3D8C:
	ldr r1, _020A3E98 // =aTransferEncodi
	mov r0, r5
	bl strstr
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	str r0, [r6, #0x110]
	ldr r0, [r6, #0x110]
	cmp r0, #0
	movne r0, #0
	strneb r0, [r6, #0x114]
	strne r0, [r6, #0x120]
	strne r0, [r6, #0x124]
	strne r0, [r6, #0x128]
	ldr r0, [r6, #0xc]
	sub r0, r0, #3
	cmp r0, #1
	ldrls ip, _020A3E74 // =0x00001018
	movls r0, #1
	addls sp, sp, ip
	strls r0, [r6, #0xfc]
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, #8
	str r0, [r6, #0x10]
	cmp r9, #0
	beq _020A3E10
	ldr r0, [r6, #0x104]
	cmp r0, #0
	ldreq ip, _020A3E74 // =0x00001018
	moveq r0, #1
	addeq sp, sp, ip
	streq r0, [r6, #0xfc]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A3E10:
	cmp r10, #0
	ldrle ip, _020A3E74 // =0x00001018
	addle sp, sp, ip
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, r6
	mov r1, r4
	mov r2, r10
	bl sub_20A3E9C
	ldr ip, _020A3E74 // =0x00001018
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A3E3C:
	cmp r4, #2
	ldrne ip, _020A3E74 // =0x00001018
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r0, #1
	str r0, [r6, #0xfc]
	mov r0, #7
	str r0, [r6, #0x38]
	ldr r0, [r6, #0x48]
	bl WSAGetLastError
	str r0, [r6, #0x4c]
	ldr ip, _020A3E74 // =0x00001018
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020A3E74: .word 0x00001018
_020A3E78: .word 0x0211CD74
_020A3E7C: .word 0x0211CD7C
_020A3E80: .word 0x51EB851F
_020A3E84: .word aLocation
_020A3E88: .word _0211714C
_020A3E8C: .word aHttpSDS
_020A3E90: .word aContentLength_1
_020A3E94: .word a2147483647
_020A3E98: .word aTransferEncodi
	arm_func_end sub_20A39D0

	arm_func_start sub_20A3E9C
sub_20A3E9C: // 0x020A3E9C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	movs r6, r0
	mov r5, r1
	mov r4, r2
	bne _020A3EC8
	ldr r0, _020A40E0 // =aConnection_5
	ldr r1, _020A40E4 // =aGhttpprocessC
	ldr r3, _020A40E8 // =0x0000035D
	mov r2, #0
	bl __msl_assertion_failed
_020A3EC8:
	cmp r5, #0
	bne _020A3EE4
	ldr r0, _020A40EC // =0x0211CDE4
	ldr r1, _020A40E4 // =aGhttpprocessC
	ldr r3, _020A40F0 // =0x0000035E
	mov r2, #0
	bl __msl_assertion_failed
_020A3EE4:
	cmp r4, #0
	bgt _020A3F00
	ldr r0, _020A40F4 // =aLen0
	ldr r1, _020A40E4 // =aGhttpprocessC
	ldr r3, _020A40F8 // =0x0000035F
	mov r2, #0
	bl __msl_assertion_failed
_020A3F00:
	ldr r0, [r6, #0x110]
	cmp r0, #0
	beq _020A40C8
	cmp r4, #0
	ble _020A40BC
	mov r0, #2
	str r0, [sp, #4]
	mov r0, #1
	add r8, r6, #0x124
	mov r10, #0xa
	mov r7, #0
	str r0, [sp]
	mov r11, #3
_020A3F34:
	ldr r0, [r6, #0x128]
	cmp r0, #0
	bne _020A3FDC
	mov r0, r5
	mov r1, r10
	bl strchr
	movs r9, r0
	beq _020A3FC0
	mov r0, r6
	mov r1, r5
	sub r2, r9, r5
	bl sub_20A4104
	add r1, r9, #1
	sub r2, r1, r5
	mov r0, r6
	mov r5, r1
	sub r4, r4, r2
	bl sub_20A41E0
	str r0, [r6, #0x124]
	ldr r1, [r6, #0x124]
	mvn r0, #0
	cmp r1, r0
	bne _020A3FAC
	mov r0, #1
	str r0, [r6, #0xfc]
	mov r0, #7
	str r0, [r6, #0x38]
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A3FAC:
	cmp r1, #0
	ldrne r0, [sp]
	streq r11, [r6, #0x128]
	strne r0, [r6, #0x128]
	b _020A40B4
_020A3FC0:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20A4104
	add sp, sp, #0xc
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A3FDC:
	cmp r0, #1
	bne _020A4038
	ldr r9, [r6, #0x124]
	mov r0, r6
	cmp r9, r4
	movge r9, r4
	mov r1, r5
	mov r2, r9
	bl sub_20A4240
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r8, #0]
	add r5, r5, r9
	sub r0, r0, r9
	str r0, [r8]
	ldr r0, [r6, #0x124]
	sub r4, r4, r9
	cmp r0, #0
	ldreq r0, [sp, #4]
	streq r0, [r6, #0x128]
	b _020A40B4
_020A4038:
	cmp r0, #2
	bne _020A4080
	mov r0, r5
	mov r1, r10
	bl strchr
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	strb r7, [r6, #0x114]
	str r7, [r6, #0x120]
	add r0, r0, #1
	sub r1, r0, r5
	str r7, [r6, #0x124]
	mov r5, r0
	str r7, [r6, #0x128]
	sub r4, r4, r1
	b _020A40B4
_020A4080:
	cmp r0, #3
	moveq r0, #1
	addeq sp, sp, #0xc
	streq r0, [r6, #0xfc]
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _020A40FC // =_0211CDF4
	ldr r1, _020A40E4 // =aGhttpprocessC
	ldr r3, _020A4100 // =0x000003E3
	mov r2, #0
	bl __msl_assertion_failed
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A40B4:
	cmp r4, #0
	bgt _020A3F34
_020A40BC:
	add sp, sp, #0xc
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A40C8:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20A4240
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A40E0: .word aConnection_5
_020A40E4: .word aGhttpprocessC
_020A40E8: .word 0x0000035D
_020A40EC: .word 0x0211CDE4
_020A40F0: .word 0x0000035E
_020A40F4: .word aLen0
_020A40F8: .word 0x0000035F
_020A40FC: .word _0211CDF4
_020A4100: .word 0x000003E3
	arm_func_end sub_20A3E9C

	arm_func_start sub_20A4104
sub_20A4104: // 0x020A4104
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r4, r0
	mov r7, r1
	mov r6, r2
	bne _020A4130
	ldr r0, _020A41C8 // =aConnection_5
	ldr r1, _020A41CC // =aGhttpprocessC
	ldr r3, _020A41D0 // =0x00000333
	mov r2, #0
	bl __msl_assertion_failed
_020A4130:
	cmp r7, #0
	bne _020A414C
	ldr r0, _020A41D4 // =0x0211CDE4
	ldr r1, _020A41CC // =aGhttpprocessC
	mov r2, #0
	mov r3, #0x334
	bl __msl_assertion_failed
_020A414C:
	cmp r6, #0
	bge _020A4168
	ldr r0, _020A41D8 // =aLen0_0
	ldr r1, _020A41CC // =aGhttpprocessC
	ldr r3, _020A41DC // =0x00000335
	mov r2, #0
	bl __msl_assertion_failed
_020A4168:
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r3, [r4, #0x120]
	cmp r3, #0xa
	addge sp, sp, #4
	ldmgeia sp!, {r4, r5, r6, r7, pc}
	rsb r5, r3, #0xa
	cmp r5, r6
	movge r5, r6
	add r0, r4, #0x114
	mov r1, r7
	mov r2, r5
	add r0, r0, r3
	bl memcpy
	ldr r0, [r4, #0x120]
	mov r1, #0
	add r0, r0, r5
	str r0, [r4, #0x120]
	ldr r0, [r4, #0x120]
	add r0, r4, r0
	strb r1, [r0, #0x114]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A41C8: .word aConnection_5
_020A41CC: .word aGhttpprocessC
_020A41D0: .word 0x00000333
_020A41D4: .word 0x0211CDE4
_020A41D8: .word aLen0_0
_020A41DC: .word 0x00000335
	arm_func_end sub_20A4104

	arm_func_start sub_20A41E0
sub_20A41E0: // 0x020A41E0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, [r0, #0x120]
	add r4, r0, #0x114
	cmp r1, #0
	bne _020A420C
	ldr r0, _020A4230 // =0x0211CE04
	ldr r1, _020A4234 // =aGhttpprocessC
	ldr r3, _020A4238 // =0x00000321
	mov r2, #0
	bl __msl_assertion_failed
_020A420C:
	ldr r1, _020A423C // =0x0211CE08
	add r2, sp, #0
	mov r0, r4
	bl sscanf
	cmp r0, #1
	mvnne r0, #0
	ldreq r0, [sp]
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A4230: .word 0x0211CE04
_020A4234: .word aGhttpprocessC
_020A4238: .word 0x00000321
_020A423C: .word 0x0211CE08
	arm_func_end sub_20A41E0

	arm_func_start sub_20A4240
sub_20A4240: // 0x020A4240
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x100]
	mov lr, #0
	add r0, r0, r2
	str r0, [r4, #0x100]
	ldr r3, [r4, #0x100]
	ldr r0, [r4, #0x104]
	mov ip, lr
	cmp r3, r0
	beq _020A4278
	ldr r0, [r4, #0x130]
	cmp r0, #0
	beq _020A4280
_020A4278:
	mov r0, #1
	str r0, [r4, #0xfc]
_020A4280:
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bne _020A42AC
	add r0, r4, #0xbc
	bl sub_20A1008
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr lr, [r4, #0xc0]
	ldr ip, [r4, #0xc8]
	b _020A42EC
_020A42AC:
	cmp r0, #1
	bne _020A42E0
	cmp r2, #0
	beq _020A42D4
	mov r0, #1
	str r0, [r4, #0xfc]
	mov r0, #0xd
	str r0, [r4, #0x38]
	mov r0, #0
	ldmia sp!, {r4, pc}
_020A42D4:
	mov lr, r1
	mov ip, r2
	b _020A42EC
_020A42E0:
	cmp r0, #2
	moveq lr, r1
	moveq ip, r2
_020A42EC:
	mov r0, r4
	mov r1, lr
	mov r2, ip
	bl sub_20A1674
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end sub_20A4240

	arm_func_start sub_20A4304
sub_20A4304: // 0x020A4304
	stmdb sp!, {r4, r5, lr}
	ldr ip, _020A442C // =0x00000404
	sub sp, sp, ip
	mov r3, #0x400
	add r1, sp, #4
	add r2, sp, #0
	mov r4, r0
	str r3, [sp]
	bl sub_20A1864
	mov r5, r0
	cmp r5, #3
	ldreq ip, _020A442C // =0x00000404
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, pc}
	cmp r5, #1
	bne _020A435C
	ldr r1, [r4, #0x84]
	ldr r0, [r4, #0x80]
	cmp r1, r0
	ldreq ip, _020A442C // =0x00000404
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, pc}
_020A435C:
	cmp r5, #0
	bne _020A4384
	ldr r2, [sp]
	add r1, sp, #4
	add r0, r4, #0x74
	bl sub_20A1008
	cmp r0, #0
	ldreq ip, _020A442C // =0x00000404
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, pc}
_020A4384:
	ldr r0, [r4, #0x78]
	ldr r1, _020A4430 // =0x0211CE0C
	bl strstr
	cmp r0, #0
	beq _020A43F4
	mov r1, #0
	strb r1, [r0]
	ldr r1, [r4, #0x78]
	sub r5, r0, r1
	add r1, r5, #1
	mov r0, r4
	str r1, [r4, #0xf8]
	bl sub_20A4434
	cmp r0, #0
	ldreq ip, _020A442C // =0x00000404
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, pc}
	add r3, r5, #2
	mov r1, #0
	str r3, [r4, #0x84]
	mov r3, #7
	mov r0, r4
	mov r2, r1
	str r3, [r4, #0x10]
	bl sub_20A1674
	ldr ip, _020A442C // =0x00000404
	add sp, sp, ip
	ldmia sp!, {r4, r5, pc}
_020A43F4:
	cmp r5, #2
	ldrne ip, _020A442C // =0x00000404
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, pc}
	mov r0, #1
	str r0, [r4, #0xfc]
	mov r0, #7
	str r0, [r4, #0x38]
	ldr r0, [r4, #0x48]
	bl WSAGetLastError
	str r0, [r4, #0x4c]
	ldr ip, _020A442C // =0x00000404
	add sp, sp, ip
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A442C: .word 0x00000404
_020A4430: .word 0x0211CE0C
	arm_func_end sub_20A4304

	arm_func_start sub_20A4434
sub_20A4434: // 0x020A4434
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	movs r4, r0
	bne _020A4458
	ldr r0, _020A4568 // =aConnection_5
	ldr r1, _020A456C // =aGhttpprocessC
	ldr r3, _020A4570 // =0x0000024E
	mov r2, #0
	bl __msl_assertion_failed
_020A4458:
	ldr r0, [r4, #0x80]
	cmp r0, #0
	bgt _020A4478
	ldr r0, _020A4574 // =aConnectionRecv
	ldr r1, _020A456C // =aGhttpprocessC
	ldr r3, _020A4578 // =0x0000024F
	mov r2, #0
	bl __msl_assertion_failed
_020A4478:
	add r1, sp, #0x10
	str r1, [sp]
	add r0, sp, #0x14
	str r0, [sp, #4]
	ldr r0, [r4, #0x78]
	ldr r1, _020A457C // =aHttpDDDN
	add r2, sp, #8
	add r3, sp, #0xc
	bl sscanf
	mov r3, #0
	mov ip, #1
	ldr r2, _020A4580 // =_0211714C
	b _020A44B8
_020A44AC:
	ldr r1, [sp, #0x14]
	add r1, r1, #1
	str r1, [sp, #0x14]
_020A44B8:
	ldr lr, [r4, #0x78]
	ldr r1, [sp, #0x14]
	ldrsb lr, [lr, r1]
	cmp lr, #0
	beq _020A44FC
	mov r1, ip
	cmp lr, #0
	blt _020A44E0
	cmp lr, #0x80
	movlt r1, r3
_020A44E0:
	cmp r1, #0
	movne r1, r3
	moveq r1, lr, lsl #1
	ldreqh r1, [r2, r1]
	andeq r1, r1, #0x100
	cmp r1, #0
	bne _020A44AC
_020A44FC:
	cmp r0, #3
	bne _020A4524
	ldr r1, [sp, #8]
	cmp r1, #1
	blt _020A4524
	ldr r0, [sp, #0x10]
	cmp r0, #0x64
	blt _020A4524
	cmp r0, #0x258
	blt _020A4540
_020A4524:
	mov r0, #1
	str r0, [r4, #0xfc]
	mov r0, #7
	str r0, [r4, #0x38]
	add sp, sp, #0x18
	mov r0, #0
	ldmia sp!, {r4, pc}
_020A4540:
	str r1, [r4, #0xe4]
	ldr r1, [sp, #0xc]
	mov r0, #1
	str r1, [r4, #0xe8]
	ldr r1, [sp, #0x10]
	str r1, [r4, #0xec]
	ldr r1, [sp, #0x14]
	str r1, [r4, #0xf0]
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A4568: .word aConnection_5
_020A456C: .word aGhttpprocessC
_020A4570: .word 0x0000024E
_020A4574: .word aConnectionRecv
_020A4578: .word 0x0000024F
_020A457C: .word aHttpDDDN
_020A4580: .word _0211714C
	arm_func_end sub_20A4434

	arm_func_start sub_20A4584
sub_20A4584: // 0x020A4584
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r2, #0
	ldr r0, [r4, #0x48]
	add r1, sp, #0
	mov r3, r2
	bl sub_20A09A4
	mvn r1, #0
	cmp r0, r1
	bne _020A45D4
	mov r0, #1
	str r0, [r4, #0xfc]
	mov r0, #5
	str r0, [r4, #0x38]
	ldr r0, [r4, #0x48]
	bl WSAGetLastError
	add sp, sp, #8
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, pc}
_020A45D4:
	ldr r0, [sp]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r3, #6
	mov r0, r4
	mov r2, r1
	str r3, [r4, #0x10]
	bl sub_20A1674
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end sub_20A4584

	arm_func_start sub_20A4604
sub_20A4604: // 0x020A4604
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0x148]
	bl sub_20A2930
	movs r5, r0
	bne _020A4654
	ldr r0, [r6, #0xfc]
	cmp r0, #0
	beq _020A4634
	ldr r0, [r6, #0x38]
	cmp r0, #0
	bne _020A4648
_020A4634:
	ldr r0, _020A4694 // =aConnectionComp_0
	ldr r1, _020A4698 // =aGhttpprocessC
	mov r2, #0
	mov r3, #0x200
	bl __msl_assertion_failed
_020A4648:
	mov r0, r6
	bl sub_20A3240
	ldmia sp!, {r4, r5, r6, pc}
_020A4654:
	ldr r0, [r6, #0x148]
	cmp r4, r0
	beq _020A4668
	mov r0, r6
	bl sub_20A1604
_020A4668:
	cmp r5, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl sub_20A3240
	mov r1, #0
	mov r3, #5
	mov r0, r6
	mov r2, r1
	str r3, [r6, #0x10]
	bl sub_20A1674
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A4694: .word aConnectionComp_0
_020A4698: .word aGhttpprocessC
	arm_func_end sub_20A4604

	arm_func_start sub_20A469C
sub_20A469C: // 0x020A469C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	ldr r0, [r5, #0x5c]
	cmp r0, #0
	bne _020A487C
	ldr r0, [r5, #0x13c]
	add r4, r5, #0x50
	cmp r0, #0
	ldrne r1, _020A48DC // =aPost_0
	bne _020A46D8
	ldr r0, [r5, #0xc]
	cmp r0, #3
	ldreq r1, _020A48E0 // =aHead
	ldrne r1, _020A48E4 // =0x0211CE7C
_020A46D8:
	mov r0, r4
	mov r2, #0
	bl sub_20A1008
	ldr r0, [r5, #0x15c]
	cmp r0, #0
	bne _020A4700
	ldr r0, _020A48E8 // =0x02144E44
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _020A4714
_020A4700:
	ldr r1, [r5, #0x14]
	mov r0, r4
	mov r2, #0
	bl sub_20A1008
	b _020A4724
_020A4714:
	ldr r1, [r5, #0x24]
	mov r0, r4
	mov r2, #0
	bl sub_20A1008
_020A4724:
	ldr r1, _020A48EC // =aHttp11
	mov r0, r4
	mov r2, #0
	bl sub_20A1008
	ldrh r0, [r5, #0x20]
	cmp r0, #0x50
	bne _020A4754
	ldr r2, [r5, #0x18]
	ldr r1, _020A48F0 // =_0211CE90
	mov r0, r4
	bl sub_20A0F74
	b _020A479C
_020A4754:
	ldr r1, _020A48F4 // =aHost_0
	mov r0, r4
	mov r2, #0
	bl sub_20A1008
	ldr r1, [r5, #0x18]
	mov r0, r4
	mov r2, #0
	bl sub_20A1008
	mov r0, r4
	mov r1, #0x3a
	bl sub_20A0F18
	ldrh r1, [r5, #0x20]
	mov r0, r4
	bl sub_20A0EE0
	mov r0, r4
	ldr r1, _020A48F8 // =0x0211CE0C
	mov r2, #2
	bl sub_20A1008
_020A479C:
	ldr r0, [r5, #0x28]
	cmp r0, #0
	beq _020A47B8
	ldr r1, _020A48FC // =aUserAgent_0
	bl strstr
	cmp r0, #0
	bne _020A47C8
_020A47B8:
	ldr r1, _020A48FC // =aUserAgent_0
	ldr r2, _020A4900 // =aGamespyhttp10
	mov r0, r4
	bl sub_20A0F74
_020A47C8:
	ldr r0, [r5, #0x34]
	cmp r0, #0
	beq _020A47E8
	ldr r1, _020A4904 // =aConnection_6
	ldr r2, _020A4908 // =aKeepAlive
	mov r0, r4
	bl sub_20A0F74
	b _020A47F8
_020A47E8:
	ldr r1, _020A4904 // =aConnection_6
	ldr r2, _020A490C // =aClose_0
	mov r0, r4
	bl sub_20A0F74
_020A47F8:
	ldr r0, [r5, #0x13c]
	cmp r0, #0
	beq _020A483C
	ldr r2, [r5, #0x14c]
	ldr r1, _020A4910 // =0x0211CEDC
	add r0, sp, #0
	bl sprintf
	ldr r1, _020A4914 // =aContentLength_2
	add r2, sp, #0
	mov r0, r4
	bl sub_20A0F74
	mov r0, r5
	bl sub_20A3858
	mov r2, r0
	ldr r1, _020A4918 // =aContentType
	mov r0, r4
	bl sub_20A0F74
_020A483C:
	ldr r1, [r5, #0x28]
	cmp r1, #0
	beq _020A4854
	mov r0, r4
	mov r2, #0
	bl sub_20A1008
_020A4854:
	ldr r1, _020A48F8 // =0x0211CE0C
	mov r0, r4
	mov r2, #2
	bl sub_20A1008
	add r0, r5, #0x50
	cmp r4, r0
	beq _020A487C
	ldr r1, [r4, #4]
	ldr r2, [r4, #0xc]
	bl sub_20A1008
_020A487C:
	mov r0, r5
	bl sub_20A0DC8
	cmp r0, #0
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, [r5, #0x60]
	ldr r0, [r5, #0x5c]
	cmp r1, r0
	addlt sp, sp, #0x14
	ldmltia sp!, {r4, r5, pc}
	add r0, r5, #0x50
	bl sub_20A0EA0
	ldr r0, [r5, #0x13c]
	mov r1, #0
	cmp r0, #0
	movne r0, #4
	strne r0, [r5, #0x10]
	moveq r0, #5
	streq r0, [r5, #0x10]
	mov r0, r5
	mov r2, r1
	bl sub_20A1674
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A48DC: .word aPost_0
_020A48E0: .word aHead
_020A48E4: .word 0x0211CE7C
_020A48E8: .word 0x02144E44
_020A48EC: .word aHttp11
_020A48F0: .word _0211CE90
_020A48F4: .word aHost_0
_020A48F8: .word 0x0211CE0C
_020A48FC: .word aUserAgent_0
_020A4900: .word aGamespyhttp10
_020A4904: .word aConnection_6
_020A4908: .word aKeepAlive
_020A490C: .word aClose_0
_020A4910: .word 0x0211CEDC
_020A4914: .word aContentLength_2
_020A4918: .word aContentType
	arm_func_end sub_20A469C

	arm_func_start sub_20A491C
sub_20A491C: // 0x020A491C
	stmdb sp!, {r4, lr}
	ldr ip, _020A4A64 // =0x00000408
	sub sp, sp, ip
	mov r4, r0
	ldr r1, [r4, #0x168]
	cmp r1, #0
	bne _020A498C
	ldr r0, [r4, #0x14]
	ldr r1, _020A4A68 // =aHttps_0
	mov r2, #8
	bl strncmp
	cmp r0, #0
	ldreq ip, _020A4A64 // =0x00000408
	moveq r0, #1
	streq r0, [r4, #0xfc]
	moveq r0, #0x11
	addeq sp, sp, ip
	streq r0, [r4, #0x38]
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r3, #3
	mov r0, r4
	mov r2, r1
	str r3, [r4, #0x10]
	bl sub_20A1674
	ldr ip, _020A4A64 // =0x00000408
	add sp, sp, ip
	ldmia sp!, {r4, pc}
_020A498C:
	ldr r1, [r4, #0x170]
	cmp r1, #0
	beq _020A49B8
	mov r1, #0
	mov r3, #3
	mov r2, r1
	str r3, [r4, #0x10]
	bl sub_20A1674
	ldr ip, _020A4A64 // =0x00000408
	add sp, sp, ip
	ldmia sp!, {r4, pc}
_020A49B8:
	ldr r1, [r4, #0x16c]
	cmp r1, #0
	bne _020A49F8
	ldr r2, [r4, #0x174]
	add r1, r4, #0x164
	blx r2
	cmp r0, #3
	bne _020A49F8
	ldr r0, _020A4A6C // =_0211CDF4
	ldr r1, _020A4A70 // =aGhttpprocessC
	ldr r3, _020A4A74 // =0x00000146
	mov r2, #0
	bl __msl_assertion_failed
	ldr ip, _020A4A64 // =0x00000408
	add sp, sp, ip
	ldmia sp!, {r4, pc}
_020A49F8:
	ldr r1, [r4, #0x60]
	ldr r0, [r4, #0x5c]
	cmp r1, r0
	bge _020A4A40
	mov r0, r4
	bl sub_20A0DC8
	cmp r0, #0
	ldreq ip, _020A4A64 // =0x00000408
	addeq sp, sp, ip
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x60]
	ldr r0, [r4, #0x5c]
	cmp r1, r0
	ldrlt ip, _020A4A64 // =0x00000408
	addlt sp, sp, ip
	ldmltia sp!, {r4, pc}
	add r0, r4, #0x50
	bl sub_20A0EA0
_020A4A40:
	mov r3, #0x400
	add r1, sp, #4
	add r2, sp, #0
	mov r0, r4
	str r3, [sp]
	bl sub_20A1864
	ldr ip, _020A4A64 // =0x00000408
	add sp, sp, ip
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A4A64: .word 0x00000408
_020A4A68: .word aHttps_0
_020A4A6C: .word _0211CDF4
_020A4A70: .word aGhttpprocessC
_020A4A74: .word 0x00000146
	arm_func_end sub_20A491C

	arm_func_start sub_20A4A78
sub_20A4A78: // 0x020A4A78
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	mov r4, r0
	ldr r1, [r4, #0x48]
	mvn r0, #0
	cmp r1, r0
	bne _020A4C30
	mov r0, #2
	mov r1, #1
	mov r2, #0
	bl sub_20A0800
	str r0, [r4, #0x48]
	ldr r0, [r4, #0x48]
	mvn r1, #0
	cmp r0, r1
	bne _020A4ADC
	mov r0, #1
	str r0, [r4, #0xfc]
	mov r0, #5
	str r0, [r4, #0x38]
	ldr r0, [r4, #0x48]
	bl WSAGetLastError
	add sp, sp, #0x10
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, pc}
_020A4ADC:
	mov r1, #0
	bl sub_20A0BC4
	cmp r0, #0
	bne _020A4B10
	mov r0, #1
	str r0, [r4, #0xfc]
	mov r0, #5
	str r0, [r4, #0x38]
	ldr r0, [r4, #0x48]
	bl WSAGetLastError
	add sp, sp, #0x10
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, pc}
_020A4B10:
	ldr r0, [r4, #0x134]
	cmp r0, #0
	beq _020A4B2C
	ldr r1, _020A4CC8 // =0x0211C76C
	ldr r0, [r4, #0x48]
	ldr r1, [r1, #0]
	bl sub_20A0B78
_020A4B2C:
	add r1, sp, #0
	mov r0, #0
	str r0, [r1]
	str r0, [r1, #4]
	mov r0, #2
	strb r0, [sp, #1]
	ldr r0, [r4, #0x15c]
	cmp r0, #0
	beq _020A4B74
	add r0, r4, #0x100
	ldrh r0, [r0, #0x60]
	mov r1, r0, asr #8
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	strh r0, [sp, #2]
	b _020A4BC4
_020A4B74:
	ldr r0, _020A4CCC // =0x02144E44
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _020A4BA8
	ldr r0, _020A4CD0 // =0x02144E40
	ldrh r0, [r0, #0]
	mov r1, r0, asr #8
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	strh r0, [sp, #2]
	b _020A4BC4
_020A4BA8:
	ldrh r0, [r4, #0x20]
	mov r1, r0, asr #8
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	strh r0, [sp, #2]
_020A4BC4:
	ldr r0, [r4, #0x1c]
	add r1, sp, #0
	str r0, [sp, #4]
	ldr r0, [r4, #0x48]
	mov r2, #8
	bl sub_20A072C
	mvn r1, #0
	cmp r0, r1
	bne _020A4C30
	ldr r0, [r4, #0x48]
	bl WSAGetLastError
	mvn r1, #5
	cmp r0, r1
	beq _020A4C30
	mvn r1, #0x19
	cmp r0, r1
	beq _020A4C30
	mvn r1, #0x4b
	cmp r0, r1
	beq _020A4C30
	mov r1, #1
	str r1, [r4, #0xfc]
	mov r1, #6
	str r1, [r4, #0x38]
	add sp, sp, #0x10
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, pc}
_020A4C30:
	ldr r0, [r4, #0x48]
	add r2, sp, #8
	add r3, sp, #0xc
	mov r1, #0
	bl sub_20A09A4
	cmp r0, #0
	movgt r1, #1
	movle r1, #0
	mvn r0, #0
	cmp r1, r0
	beq _020A4C68
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _020A4C98
_020A4C68:
	mov r0, #1
	str r0, [r4, #0xfc]
	mov r0, #6
	cmp r1, #0
	addne sp, sp, #0x10
	str r0, [r4, #0x38]
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x48]
	bl WSAGetLastError
	add sp, sp, #0x10
	str r0, [r4, #0x4c]
	ldmia sp!, {r4, pc}
_020A4C98:
	ldr r0, [sp, #8]
	cmp r0, #0
	addeq sp, sp, #0x10
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	mov r3, #2
	mov r0, r4
	mov r2, r1
	str r3, [r4, #0x10]
	bl sub_20A1674
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A4CC8: .word 0x0211C76C
_020A4CCC: .word 0x02144E44
_020A4CD0: .word 0x02144E40
	arm_func_end sub_20A4A78

	arm_func_start sub_20A4CD4
sub_20A4CD4: // 0x020A4CD4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r1, #0
	mov r4, r0
	mov r2, r1
	bl sub_20A1674
	bl sub_20A0C94
	mov r0, r4
	bl sub_20A4DA4
	cmp r0, #0
	moveq r0, #1
	streq r0, [r4, #0xfc]
	moveq r0, #3
	addeq sp, sp, #4
	streq r0, [r4, #0x38]
	ldmeqia sp!, {r4, r5, pc}
	ldr r5, [r4, #0x15c]
	cmp r5, #0
	bne _020A4D30
	ldr r0, _020A4DA0 // =0x02144E44
	ldr r5, [r0, #0]
	cmp r5, #0
	ldreq r5, [r4, #0x18]
_020A4D30:
	mov r0, r5
	bl sub_20A0580
	str r0, [r4, #0x1c]
	ldr r1, [r4, #0x1c]
	mvn r0, #0
	cmp r1, r0
	bne _020A4D80
	mov r0, r5
	bl sub_20BE844
	cmp r0, #0
	moveq r0, #1
	streq r0, [r4, #0xfc]
	moveq r0, #4
	addeq sp, sp, #4
	streq r0, [r4, #0x38]
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r0, #0xc]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0]
	str r0, [r4, #0x1c]
_020A4D80:
	mov r1, #0
	mov r3, #1
	mov r0, r4
	mov r2, r1
	str r3, [r4, #0x10]
	bl sub_20A1674
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A4DA0: .word 0x02144E44
	arm_func_end sub_20A4CD4

	arm_func_start sub_20A4DA4
sub_20A4DA4: // 0x020A4DA4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	movs r7, r0
	bne _020A4DC8
	ldr r0, _020A4F60 // =aConnection_5
	ldr r1, _020A4F64 // =aGhttpprocessC
	mov r2, #0
	mov r3, #0x25
	bl __msl_assertion_failed
_020A4DC8:
	cmp r7, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r7, #0x14]
	cmp r0, #0
	bne _020A4DF8
	ldr r0, _020A4F68 // =aConnectionUrl
	ldr r1, _020A4F64 // =aGhttpprocessC
	mov r2, #0
	mov r3, #0x2b
	bl __msl_assertion_failed
_020A4DF8:
	ldr r6, [r7, #0x14]
	cmp r6, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r1, _020A4F6C // =aHttp_0
	mov r0, r6
	mov r2, #7
	bl strncmp
	cmp r0, #0
	addeq r6, r6, #7
	moveq r4, #0
	beq _020A4E58
	ldr r1, _020A4F70 // =aHttps_0
	mov r0, r6
	mov r2, #8
	bl strncmp
	cmp r0, #0
	addeq r6, r6, #8
	moveq r4, #1
	beq _020A4E58
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020A4E58:
	ldr r1, _020A4F74 // =_0211CF24
	mov r0, r6
	bl strspn
	mov r8, r0
	ldrsb r5, [r6, r8]
	mov r1, #0
	mov r0, r6
	strb r1, [r6, r8]
	add r9, r6, r8
	bl sub_20A0C50
	str r0, [r7, #0x18]
	ldr r0, [r7, #0x18]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	strb r5, [r9]
	ldrsb r0, [r6, r8]!
	cmp r0, #0x3a
	bne _020A4EE4
	add r6, r6, #1
	mov r0, r6
	bl atoi
	strh r0, [r7, #0x20]
	ldrh r0, [r7, #0x20]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020A4ECC:
	ldrsb r0, [r6, #1]!
	cmp r0, #0
	beq _020A4EF8
	cmp r0, #0x2f
	bne _020A4ECC
	b _020A4EF8
_020A4EE4:
	cmp r4, #0
	ldrne r0, _020A4F78 // =0x000001BB
	strneh r0, [r7, #0x20]
	moveq r0, #0x50
	streqh r0, [r7, #0x20]
_020A4EF8:
	ldrsb r0, [r6, #0]
	cmp r0, #0
	ldreq r6, _020A4F7C // =0x0211CF28
	mov r0, r6
	bl sub_20A0C50
	str r0, [r7, #0x24]
	ldr r6, [r7, #0x24]
	mov r1, #0x20
	mov r0, r6
	bl strchr
	cmp r0, #0
	beq _020A4F4C
	mov r5, #0x2b
	mov r4, #0x20
_020A4F30:
	strb r5, [r0]
	ldr r6, [r7, #0x24]
	mov r1, r4
	mov r0, r6
	bl strchr
	cmp r0, #0
	bne _020A4F30
_020A4F4C:
	cmp r6, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020A4F60: .word aConnection_5
_020A4F64: .word aGhttpprocessC
_020A4F68: .word aConnectionUrl
_020A4F6C: .word aHttp_0
_020A4F70: .word aHttps_0
_020A4F74: .word _0211CF24
_020A4F78: .word 0x000001BB
_020A4F7C: .word 0x0211CF28
	arm_func_end sub_20A4DA4

	arm_func_start gpSendBuddyMessageA
gpSendBuddyMessageA: // 0x020A4F80
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov r3, r2
	cmp r0, #0
	beq _020A4FA0
	ldr ip, [r0]
	cmp ip, #0
	bne _020A4FAC
_020A4FA0:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A4FAC:
	ldr r2, [ip, #0x108]
	cmp r2, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	ldr r2, [ip, #0x1d8]
	cmp r2, #4
	bne _020A4FE0
	ldr r1, _020A500C // =aTheConnectionH
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A4FE0:
	cmp r3, #0
	bne _020A4FFC
	ldr r1, _020A5010 // =aInvalidMessage
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A4FFC:
	mov r2, #1
	bl sub_20A6720
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A500C: .word aTheConnectionH
_020A5010: .word aInvalidMessage
	arm_func_end gpSendBuddyMessageA

	arm_func_start sub_20A5014
sub_20A5014: // 0x020A5014
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x204
	movs r7, r0
	mov r6, r1
	mov r5, r3
	beq _020A5038
	ldr r4, [r7, #0]
	cmp r4, #0
	bne _020A5044
_020A5038:
	add sp, sp, #0x204
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, pc}
_020A5044:
	ldr r1, [r4, #0x108]
	cmp r1, #0
	addne sp, sp, #0x204
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r1, [r4, #0x1d8]
	cmp r1, #4
	bne _020A5078
	ldr r1, _020A5228 // =aTheConnectionH
	bl sub_20AFBA8
	add sp, sp, #0x204
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, pc}
_020A5078:
	cmp r2, #0
	bne _020A5094
	ldr r1, _020A522C // =aInvalidStatuss
	bl sub_20AFBA8
	add sp, sp, #0x204
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, pc}
_020A5094:
	cmp r5, #0
	bne _020A50B0
	ldr r1, _020A5230 // =aInvalidLocatio
	bl sub_20AFBA8
	add sp, sp, #0x204
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, pc}
_020A50B0:
	mov r1, r2
	add r0, sp, #0
	mov r2, #0x100
	bl sub_20B0098
	ldrsb r0, [sp]
	cmp r0, #0
	beq _020A50EC
	add r2, sp, #0
	mov r1, #0x2f
_020A50D4:
	ldrsb r0, [r2, #0]
	cmp r0, #0x5c
	streqb r1, [r2]
	ldrsb r0, [r2, #1]!
	cmp r0, #0
	bne _020A50D4
_020A50EC:
	add r0, sp, #0x100
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	add r0, sp, #0x100
	ldrsb r0, [r0, #0]
	cmp r0, #0
	beq _020A512C
	add r2, sp, #0x100
	mov r1, #0x2f
_020A5114:
	ldrsb r0, [r2, #0]
	cmp r0, #0x5c
	streqb r1, [r2]
	ldrsb r0, [r2, #1]!
	cmp r0, #0
	bne _020A5114
_020A512C:
	ldr r0, [r4, #0x214]
	cmp r6, r0
	bne _020A5168
	add r0, sp, #0
	add r1, r4, #0x218
	bl strcmp
	cmp r0, #0
	bne _020A5168
	add r0, sp, #0x100
	add r1, r4, #0x318
	bl strcmp
	cmp r0, #0
	addeq sp, sp, #0x204
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020A5168:
	add r1, sp, #0
	add r0, r4, #0x218
	mov r2, #0x100
	str r6, [r4, #0x214]
	bl sub_20B0098
	add r1, sp, #0x100
	add r0, r4, #0x318
	mov r2, #0x100
	bl sub_20B0098
	ldr r2, _020A5234 // =aStatus
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r7
	mov r2, r6
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A5238 // =aSesskey
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x198]
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A523C // =aStatstring
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r7
	add r1, r4, #0x1f4
	add r2, sp, #0
	bl sub_20A7C58
	ldr r2, _020A5240 // =aLocstring
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r7
	add r1, r4, #0x1f4
	add r2, sp, #0x100
	bl sub_20A7C58
	ldr r2, _020A5244 // =aFinal
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, #0
	add sp, sp, #0x204
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A5228: .word aTheConnectionH
_020A522C: .word aInvalidStatuss
_020A5230: .word aInvalidLocatio
_020A5234: .word aStatus
_020A5238: .word aSesskey
_020A523C: .word aStatstring
_020A5240: .word aLocstring
_020A5244: .word aFinal
	arm_func_end sub_20A5014

	arm_func_start gpDeleteBuddy
gpDeleteBuddy: // 0x020A5248
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	beq _020A5264
	ldr r3, [r0, #0]
	cmp r3, #0
	bne _020A5270
_020A5264:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A5270:
	ldr r2, [r3, #0x108]
	cmp r2, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	ldr r2, [r3, #0x1d8]
	cmp r2, #4
	bne _020A52A4
	ldr r1, _020A52B8 // =aTheConnectionH
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A52A4:
	bl sub_20A646C
	cmp r0, #0
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A52B8: .word aTheConnectionH
	arm_func_end gpDeleteBuddy

	arm_func_start gpIsBuddy
gpIsBuddy: // 0x020A52BC
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	beq _020A52D8
	ldr r2, [r0, #0]
	cmp r2, #0
	bne _020A52E4
_020A52D8:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020A52E4:
	ldr r2, [r2, #0x108]
	cmp r2, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	add r2, sp, #0
	bl sub_20AD2A4
	cmp r0, #0
	beq _020A5320
	ldr r0, [sp]
	ldr r0, [r0, #8]
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {pc}
_020A5320:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end gpIsBuddy

	arm_func_start gpGetBuddyIndex
gpGetBuddyIndex: // 0x020A532C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r2
	cmp r0, #0
	beq _020A534C
	ldr r2, [r0, #0]
	cmp r2, #0
	bne _020A5358
_020A534C:
	add sp, sp, #8
	mov r0, #2
	ldmia sp!, {r4, pc}
_020A5358:
	ldr r2, [r2, #0x108]
	cmp r2, #0
	movne r0, #0
	addne sp, sp, #8
	strne r0, [r4]
	ldmneia sp!, {r4, pc}
	add r2, sp, #0
	bl sub_20AD2A4
	cmp r0, #0
	beq _020A5398
	ldr r0, [sp]
	ldr r0, [r0, #8]
	cmp r0, #0
	ldrne r0, [r0, #0]
	strne r0, [r4]
	bne _020A53A0
_020A5398:
	mvn r0, #0
	str r0, [r4]
_020A53A0:
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end gpGetBuddyIndex

	arm_func_start gpGetBuddyStatus
gpGetBuddyStatus: // 0x020A53AC
	stmdb sp!, {r4, r5, r6, lr}
	movs r5, r0
	mov r4, r2
	beq _020A53C8
	ldr r3, [r5, #0]
	cmp r3, #0
	bne _020A53D0
_020A53C8:
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020A53D0:
	ldr r2, [r3, #0x108]
	cmp r2, #0
	beq _020A53F4
	mov r0, r4
	mov r1, #0
	mov r2, #0x210
	bl memset
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020A53F4:
	cmp r4, #0
	bne _020A540C
	ldr r1, _020A54DC // =aInvalidStatus
	bl sub_20AFBA8
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020A540C:
	cmp r1, #0
	ldr r2, [r3, #0x430]
	blt _020A5420
	cmp r1, r2
	blt _020A5434
_020A5420:
	ldr r1, _020A54E0 // =aInvalidIndex
	mov r0, r5
	bl sub_20AFBA8
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020A5434:
	bl sub_20AD0EC
	movs r6, r0
	bne _020A5454
	ldr r1, _020A54E0 // =aInvalidIndex
	mov r0, r5
	bl sub_20AFBA8
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020A5454:
	ldr r5, [r6, #8]
	cmp r5, #0
	bne _020A5474
	ldr r0, _020A54E4 // =aBuddystatus
	ldr r1, _020A54E8 // =_0211D018
	ldr r3, _020A54EC // =0x000005CF
	mov r2, #0
	bl __msl_assertion_failed
_020A5474:
	ldr r0, [r6, #0]
	str r0, [r4]
	ldr r0, [r5, #4]
	str r0, [r4, #4]
	ldr r1, [r5, #8]
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r1]
	beq _020A54A4
	add r0, r4, #8
	mov r2, #0x100
	bl sub_20B0098
_020A54A4:
	ldr r1, [r5, #0xc]
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r1]
	beq _020A54C4
	add r0, r4, #0x108
	mov r2, #0x100
	bl sub_20B0098
_020A54C4:
	ldr r1, [r5, #0x10]
	mov r0, #0
	str r1, [r4, #0x208]
	ldr r1, [r5, #0x14]
	str r1, [r4, #0x20c]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A54DC: .word aInvalidStatus
_020A54E0: .word aInvalidIndex
_020A54E4: .word aBuddystatus
_020A54E8: .word _0211D018
_020A54EC: .word 0x000005CF
	arm_func_end gpGetBuddyStatus

	arm_func_start gpGetNumBuddies
gpGetNumBuddies: // 0x020A54F0
	cmp r0, #0
	beq _020A5504
	ldr r2, [r0, #0]
	cmp r2, #0
	bne _020A550C
_020A5504:
	mov r0, #2
	bx lr
_020A550C:
	ldr r0, [r2, #0x108]
	cmp r0, #0
	movne r0, #0
	strne r0, [r1]
	ldreq r2, [r2, #0x430]
	moveq r0, #0
	streq r2, [r1]
	bx lr
	arm_func_end gpGetNumBuddies

	arm_func_start gpDenyBuddyRequest
gpDenyBuddyRequest: // 0x020A552C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r4, r0
	beq _020A5548
	ldr r5, [r4, #0]
	cmp r5, #0
	bne _020A5554
_020A5548:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, pc}
_020A5554:
	ldr r2, [r5, #0x108]
	cmp r2, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, pc}
	ldr r2, [r5, #0x1d8]
	cmp r2, #4
	bne _020A5588
	ldr r1, _020A5608 // =aTheConnectionH
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, pc}
_020A5588:
	add r2, sp, #0
	bl sub_20AD2A4
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, [sp]
	ldr r0, [r1, #0x14]
	sub r0, r0, #1
	str r0, [r1, #0x14]
	ldr r0, [r5, #0x100]
	cmp r0, #0
	bne _020A55FC
	ldr r1, [sp]
	ldr r0, [r1, #0x14]
	cmp r0, #0
	bgt _020A55FC
	ldr r0, [r1, #0x10]
	bl DWCi_GsFree
	ldr r0, [sp]
	mov r1, #0
	str r1, [r0, #0x10]
	ldr r0, [sp]
	bl sub_20AD0A8
	cmp r0, #0
	beq _020A55FC
	ldr r1, [sp]
	mov r0, r4
	bl sub_20AD25C
_020A55FC:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A5608: .word aTheConnectionH
	arm_func_end gpDenyBuddyRequest

	arm_func_start gpAuthBuddyRequest
gpAuthBuddyRequest: // 0x020A560C
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	beq _020A5628
	ldr r3, [r0, #0]
	cmp r3, #0
	bne _020A5634
_020A5628:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A5634:
	ldr r2, [r3, #0x108]
	cmp r2, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	ldr r2, [r3, #0x1d8]
	cmp r2, #4
	bne _020A5668
	ldr r1, _020A5674 // =aTheConnectionH
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A5668:
	bl sub_20A6640
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A5674: .word aTheConnectionH
	arm_func_end gpAuthBuddyRequest

	arm_func_start sub_20A5678
sub_20A5678: // 0x020A5678
	stmdb sp!, {r4, r5, r6, lr}
	ldr ip, _020A57D4 // =0x00000408
	sub sp, sp, ip
	movs r6, r0
	mov r5, r1
	beq _020A569C
	ldr r4, [r6, #0]
	cmp r4, #0
	bne _020A56AC
_020A569C:
	ldr ip, _020A57D4 // =0x00000408
	mov r0, #2
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, pc}
_020A56AC:
	ldr r1, [r4, #0x108]
	cmp r1, #0
	ldrne ip, _020A57D4 // =0x00000408
	movne r0, #0
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, [r4, #0x1d8]
	cmp r1, #4
	bne _020A56E8
	ldr r1, _020A57D8 // =aTheConnectionH
	bl sub_20AFBA8
	ldr ip, _020A57D4 // =0x00000408
	mov r0, #2
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, pc}
_020A56E8:
	cmp r2, #0
	bne _020A5708
	ldr r1, _020A57DC // =aInvalidReason
	bl sub_20AFBA8
	ldr ip, _020A57D4 // =0x00000408
	mov r0, #2
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, pc}
_020A5708:
	mov r1, r2
	ldr r2, _020A57E0 // =0x00000401
	add r0, sp, #0
	bl sub_20B0098
	ldrsb r0, [sp]
	cmp r0, #0
	beq _020A5744
	add r2, sp, #0
	mov r1, #0x2f
_020A572C:
	ldrsb r0, [r2, #0]
	cmp r0, #0x5c
	streqb r1, [r2]
	ldrsb r0, [r2, #1]!
	cmp r0, #0
	bne _020A572C
_020A5744:
	ldr r2, _020A57E4 // =aAddbuddy
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, _020A57E8 // =aSesskey
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x198]
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A57EC // =aNewprofileid
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r2, r5
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A57F0 // =aReason
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	add r2, sp, #0
	bl sub_20A7C58
	ldr r2, _020A57F4 // =aFinal
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, #0
	ldr ip, _020A57D4 // =0x00000408
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A57D4: .word 0x00000408
_020A57D8: .word aTheConnectionH
_020A57DC: .word aInvalidReason
_020A57E0: .word 0x00000401
_020A57E4: .word aAddbuddy
_020A57E8: .word aSesskey
_020A57EC: .word aNewprofileid
_020A57F0: .word aReason
_020A57F4: .word aFinal
	arm_func_end sub_20A5678

	arm_func_start sub_20A57F8
sub_20A57F8: // 0x020A57F8
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	beq _020A5814
	ldr ip, [r0]
	cmp ip, #0
	bne _020A5820
_020A5814:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A5820:
	ldr r3, [ip, #0x108]
	cmp r3, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	ldr r3, [ip, #0x1d8]
	cmp r3, #4
	bne _020A5854
	ldr r1, _020A5860 // =aTheConnectionH
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A5854:
	bl sub_20A9D74
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A5860: .word aTheConnectionH
	arm_func_end sub_20A57F8

	arm_func_start gpGetInfo
gpGetInfo: // 0x020A5864
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x20c
	movs r5, r0
	beq _020A5888
	ldr r4, [r5, #0]
	cmp r4, #0
	beq _020A5888
	cmp r1, #0
	bne _020A5894
_020A5888:
	add sp, sp, #0x20c
	mov r0, #2
	ldmia sp!, {r4, r5, pc}
_020A5894:
	ldr lr, [sp, #0x218]
	cmp lr, #0
	bne _020A58B4
	ldr r1, _020A5944 // =aNoCallback
	bl sub_20AFBA8
	add sp, sp, #0x20c
	mov r0, #2
	ldmia sp!, {r4, r5, pc}
_020A58B4:
	ldr ip, [r4, #0x108]
	cmp ip, #0
	beq _020A590C
	mov r0, #0
	add lr, sp, #8
	mov r1, r0
	mov r2, r0
	mov r3, r0
	mov ip, #0x10
_020A58D8:
	stmia lr!, {r0, r1, r2, r3}
	stmia lr!, {r0, r1, r2, r3}
	subs ip, ip, #1
	bne _020A58D8
	ldr r2, [sp, #0x21c]
	str r0, [lr]
	ldr r3, [sp, #0x218]
	add r1, sp, #8
	mov r0, r5
	blx r3
	add sp, sp, #0x20c
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020A590C:
	ldr ip, [r4, #0x1d8]
	cmp ip, #4
	bne _020A592C
	ldr r1, _020A5948 // =aTheConnectionH
	bl sub_20AFBA8
	add sp, sp, #0x20c
	mov r0, #2
	ldmia sp!, {r4, r5, pc}
_020A592C:
	ldr ip, [sp, #0x21c]
	str lr, [sp]
	str ip, [sp, #4]
	bl sub_20A9B20
	add sp, sp, #0x20c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A5944: .word aNoCallback
_020A5948: .word aTheConnectionH
	arm_func_end gpGetInfo

	arm_func_start gpProfileSearchA
gpProfileSearchA: // 0x020A594C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x30
	cmp r0, #0
	beq _020A5968
	ldr r4, [r0, #0]
	cmp r4, #0
	bne _020A5974
_020A5968:
	add sp, sp, #0x30
	mov r0, #2
	ldmia sp!, {r4, pc}
_020A5974:
	ldr ip, [sp, #0x48]
	cmp ip, #0
	bne _020A5994
	ldr r1, _020A5A14 // =aNoCallback
	bl sub_20AFBA8
	add sp, sp, #0x30
	mov r0, #2
	ldmia sp!, {r4, pc}
_020A5994:
	ldr r4, [r4, #0x108]
	cmp r4, #0
	beq _020A59D4
	add r1, sp, #0x1c
	mov r4, #0
	str r4, [r1]
	str r4, [r1, #4]
	str r4, [r1, #8]
	ldr r2, [sp, #0x4c]
	ldr r3, _020A5A18 // =0x00000601
	str r4, [r1, #0xc]
	str r3, [sp, #0x24]
	blx ip
	add sp, sp, #0x30
	mov r0, r4
	ldmia sp!, {r4, pc}
_020A59D4:
	ldr r4, [sp, #0x38]
	ldr lr, [sp, #0x3c]
	str r4, [sp]
	ldr r4, [sp, #0x40]
	str lr, [sp, #4]
	str r4, [sp, #8]
	mov r4, #0
	ldr lr, [sp, #0x44]
	str r4, [sp, #0xc]
	str lr, [sp, #0x10]
	ldr lr, [sp, #0x4c]
	str ip, [sp, #0x14]
	str lr, [sp, #0x18]
	bl sub_20AF42C
	add sp, sp, #0x30
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A5A14: .word aNoCallback
_020A5A18: .word 0x00000601
	arm_func_end gpProfileSearchA

	arm_func_start gpDisconnect
gpDisconnect: // 0x020A5A1C
	stmdb sp!, {r4, lr}
	movs r4, r0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	ldr r1, [r1, #0x108]
	cmp r1, #0
	ldmneia sp!, {r4, pc}
	mov r1, #1
	bl sub_20A82B0
	mov r0, r4
	bl sub_20A617C
	ldmia sp!, {r4, pc}
	arm_func_end gpDisconnect

	arm_func_start gpConnectPreAuthenticatedA
gpConnectPreAuthenticatedA: // 0x020A5A54
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x48
	movs lr, r0
	beq _020A5A70
	ldr ip, [lr]
	cmp ip, #0
	bne _020A5A7C
_020A5A70:
	add sp, sp, #0x48
	mov r0, #2
	ldmia sp!, {r4, pc}
_020A5A7C:
	cmp r1, #0
	beq _020A5A90
	ldrsb r4, [r1, #0]
	cmp r4, #0
	bne _020A5A9C
_020A5A90:
	add sp, sp, #0x48
	mov r0, #2
	ldmia sp!, {r4, pc}
_020A5A9C:
	cmp r2, #0
	beq _020A5AB0
	ldrsb r4, [r2, #0]
	cmp r4, #0
	bne _020A5ABC
_020A5AB0:
	add sp, sp, #0x48
	mov r0, #2
	ldmia sp!, {r4, pc}
_020A5ABC:
	ldr r4, [sp, #0x54]
	cmp r4, #0
	bne _020A5ADC
	ldr r1, _020A5B70 // =aNoCallback
	bl sub_20AFBA8
	add sp, sp, #0x48
	mov r0, #2
	ldmia sp!, {r4, pc}
_020A5ADC:
	ldr ip, [ip, #0x108]
	cmp ip, #0
	beq _020A5B24
	add r3, sp, #0x24
	mov r0, #0
	mov r2, r3
	mov r1, r0
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2, {r0, r1}
	ldr r2, [sp, #0x58]
	mov r0, lr
	mov r1, r3
	blx r4
	add sp, sp, #0x48
	mov r0, #0
	ldmia sp!, {r4, pc}
_020A5B24:
	ldr lr, _020A5B74 // =0x0211D058
	mov ip, #0
	str lr, [sp]
	str r1, [sp, #4]
	str r2, [sp, #8]
	str ip, [sp, #0xc]
	str r3, [sp, #0x10]
	ldr r1, [sp, #0x50]
	str ip, [sp, #0x14]
	str r1, [sp, #0x18]
	ldr ip, [sp, #0x58]
	str r4, [sp, #0x1c]
	mov r1, lr
	mov r2, lr
	mov r3, lr
	str ip, [sp, #0x20]
	bl sub_20A932C
	add sp, sp, #0x48
	ldmia sp!, {r4, pc}
	.align 2, 0
_020A5B70: .word aNoCallback
_020A5B74: .word 0x0211D058
	arm_func_end gpConnectPreAuthenticatedA

	arm_func_start gpSetCallback
gpSetCallback: // 0x020A5B78
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	beq _020A5B94
	ldr ip, [r0]
	cmp ip, #0
	bne _020A5BA0
_020A5B94:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A5BA0:
	cmp r1, #0
	blt _020A5BB0
	cmp r1, #6
	blt _020A5BC4
_020A5BB0:
	ldr r1, _020A5BDC // =aInvalidFunc
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A5BC4:
	add r0, ip, r1, lsl #3
	str r2, [r0, #0x1a4]
	str r3, [r0, #0x1a8]
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A5BDC: .word aInvalidFunc
	arm_func_end gpSetCallback

	arm_func_start gpProcess
gpProcess: // 0x020A5BE0
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	beq _020A5BFC
	ldr r1, [r0, #0]
	cmp r1, #0
	bne _020A5C08
_020A5BFC:
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {pc}
_020A5C08:
	ldr r1, [r1, #0x108]
	cmp r1, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {pc}
	mov r1, #0
	bl sub_20A5C9C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end gpProcess

	arm_func_start gpDestroy
gpDestroy: // 0x020A5C2C
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r1, [r0, #0]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl sub_20A62DC
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end gpDestroy

	arm_func_start gpInitialize
gpInitialize: // 0x020A5C5C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, _020A5C98 // =0x02144D20
	ldr r3, [r3, #0]
	cmp r3, #1
	addne sp, sp, #4
	movne r0, #2
	ldmneia sp!, {pc}
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #2
	ldmeqia sp!, {pc}
	bl sub_20A6324
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020A5C98: .word 0x02144D20
	arm_func_end gpInitialize

	arm_func_start sub_20A5C9C
sub_20A5C9C: // 0x020A5C9C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	ldr r7, [r10, #0]
	mov r9, r1
	ldr r0, [r7, #0x1d8]
	mov r6, #0
	cmp r0, #4
	bls _020A5CD4
	ldr r0, _020A5E44 // =aIconnectionCon
	ldr r1, _020A5E48 // =aGpiC
	ldr r3, _020A5E4C // =0x000001B6
	mov r2, r6
	bl __msl_assertion_failed
_020A5CD4:
	ldr r0, [r7, #0x1d8]
	cmp r0, #1
	bne _020A5D70
	mov r4, #0
	mov r5, #1
	mov r11, #0xa
_020A5CEC:
	mov r0, r10
	bl sub_20A853C
	movs r6, r0
	bne _020A5D14
	cmp r9, #0
	beq _020A5D14
	ldr r0, [r7, #0x1d8]
	cmp r0, #1
	moveq r8, r5
	beq _020A5D18
_020A5D14:
	mov r8, r4
_020A5D18:
	cmp r8, #0
	beq _020A5D28
	mov r0, r11
	bl sub_20A0C98
_020A5D28:
	cmp r8, #0
	bne _020A5CEC
	cmp r6, #0
	beq _020A5D70
	add r1, sp, #0
	mov r0, r10
	mov r2, #1
	bl sub_20AB8F4
	cmp r0, #0
	ldrne r0, [sp]
	movne r1, #4
	strne r1, [r0, #0x1c]
	bne _020A5D70
	ldr r0, _020A5E50 // =0x0211D16C
	ldr r1, _020A5E48 // =aGpiC
	mov r2, #0
	mov r3, #0x1dc
	bl __msl_assertion_failed
_020A5D70:
	ldr r0, [r7, #0x1d8]
	sub r0, r0, #2
	cmp r0, #1
	bhi _020A5DA8
	cmp r6, #0
	bne _020A5D94
	mov r0, r10
	bl sub_20A5E54
	mov r6, r0
_020A5D94:
	cmp r6, #0
	bne _020A5DA8
	mov r0, r10
	bl sub_20AC418
	mov r6, r0
_020A5DA8:
	cmp r6, #0
	bne _020A5DBC
	mov r0, r10
	bl sub_20AD630
	mov r6, r0
_020A5DBC:
	ldr r1, [r7, #0x424]
	str r1, [sp]
	cmp r1, #0
	beq _020A5E08
_020A5DCC:
	ldr r0, [r1, #0x1c]
	cmp r0, #0
	ldreq r0, [r1, #0x20]
	streq r0, [sp]
	beq _020A5DFC
	mov r0, r10
	bl sub_20ABB00
	ldr r1, [sp]
	mov r0, r10
	ldr r2, [r1, #0x20]
	str r2, [sp]
	bl sub_20AB940
_020A5DFC:
	ldr r1, [sp]
	cmp r1, #0
	bne _020A5DCC
_020A5E08:
	mov r0, r10
	mov r1, r9
	bl sub_20A7E2C
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r7, #0x41c]
	cmp r0, #0
	beq _020A5E38
	mov r0, r10
	mov r1, #0
	bl sub_20A82B0
_020A5E38:
	mov r0, r6
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A5E44: .word aIconnectionCon
_020A5E48: .word aGpiC
_020A5E4C: .word 0x000001B6
_020A5E50: .word 0x0211D16C
	arm_func_end sub_20A5C9C

	arm_func_start sub_20A5E54
sub_20A5E54: // 0x020A5E54
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r11, #0
	mov r5, r0
	str r11, [sp, #0x18]
	ldr r4, [r5, #0]
	mov r0, #0x800
	str r0, [sp, #8]
	add r9, r4, #0x1f0
	add r8, r4, #0x1e4
	mov r10, #1
	mov r0, #4
	str r0, [sp, #0xc]
	mov r6, #0xa
_020A5E8C:
	mov r0, r5
	add r1, r4, #0x1f4
	bl sub_20AAAB4
	ldr r0, _020A6150 // =0x0211D170
	str r10, [sp]
	str r0, [sp, #4]
	ldr r1, [r4, #0x1d4]
	mov r0, r5
	add r2, r4, #0x1f4
	add r3, sp, #0x18
	bl sub_20A7568
	cmp r0, #0
	addne sp, sp, #0x1c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, sp, #0x18
	str r0, [sp]
	ldr r0, _020A6150 // =0x0211D170
	add r2, r4, #0x1dc
	str r0, [sp, #4]
	ldr r1, [r4, #0x1d4]
	mov r0, r5
	add r3, sp, #0x14
	bl sub_20A76E8
	cmp r0, #0
	beq _020A5F28
	cmp r0, #3
	addne sp, sp, #0x1c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r2, _020A6154 // =aThereWasAnErro
	mov r0, r5
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r5
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x1c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A5F28:
	ldr r0, [r4, #0x1dc]
	ldr r1, _020A6158 // =aFinal_0
	bl strstr
	movs r7, r0
	beq _020A60EC
_020A5F3C:
	strb r11, [r7]
	ldr r1, _020A615C // =aCmdS
	ldr r2, [r4, #0x1dc]
	mov r0, r5
	bl sub_20B008C
	ldr r0, [r4, #0x1dc]
	sub r1, r7, r0
	str r1, [sp, #0x14]
	ldr r0, [r4, #0x1f0]
	cmp r1, r0
	ble _020A5FB0
	cmp r1, #0x800
	ldrlt r1, [sp, #8]
	ldr r0, [r9, #0]
	add r0, r0, r1
	str r0, [r9]
	ldr r1, [r4, #0x1f0]
	ldr r0, [r4, #0x1ec]
	add r1, r1, #1
	bl DWCi_GsRealloc
	cmp r0, #0
	bne _020A5FAC
	ldr r1, _020A6160 // =aOutOfMemory
	mov r0, r5
	bl sub_20AFBA8
	add sp, sp, #0x1c
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A5FAC:
	str r0, [r4, #0x1ec]
_020A5FB0:
	ldr r2, [sp, #0x14]
	ldr r0, [r4, #0x1ec]
	ldr r1, [r4, #0x1dc]
	add r2, r2, #1
	bl memcpy
	ldr r0, [r4, #0x1dc]
	add r1, r7, #7
	ldr r2, [r8, #0]
	sub r0, r1, r0
	sub r0, r2, r0
	str r0, [r8]
	ldr r2, [r4, #0x1e4]
	ldr r0, [r4, #0x1dc]
	add r2, r2, #1
	bl memmove
	ldr r7, [r4, #0x1ec]
	ldr r1, _020A6164 // =0x0211D1C4
	mov r0, r7
	bl strstr
	cmp r0, #0
	beq _020A605C
	add r0, r0, #4
	bl atoi
	mov r7, r0
	mov r0, r5
	add r1, sp, #0x10
	mov r2, r7
	bl sub_20AB8F4
	cmp r0, #0
	bne _020A603C
	ldr r1, _020A6168 // =aNoMatchingOper
	mov r2, r7
	mov r0, r5
	bl sub_20B008C
	b _020A60D8
_020A603C:
	mov r0, r5
	ldr r1, [sp, #0x10]
	ldr r2, [r4, #0x1ec]
	bl sub_20AB80C
	cmp r0, #0
	beq _020A60D8
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A605C:
	mov r1, r7
	mov r0, r5
	mov r2, r10
	bl sub_20AFFB4
	cmp r0, #0
	addne sp, sp, #0x1c
	movne r0, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r7, [r4, #0x1ec]
	ldr r1, _020A616C // =0x0211D1F4
	ldr r2, [sp, #0xc]
	mov r0, r7
	bl strncmp
	cmp r0, #0
	bne _020A60B4
	mov r1, r7
	mov r0, r5
	bl sub_20A6904
	cmp r0, #0
	beq _020A60D8
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A60B4:
	ldr r1, _020A6170 // =0x0211D1FC
	mov r0, r7
	mov r2, r6
	bl strncmp
	cmp r0, #0
	beq _020A60D8
	ldr r1, _020A6174 // =aReceivedAnUnre
	mov r0, r5
	bl sub_20B008C
_020A60D8:
	ldr r0, [r4, #0x1dc]
	ldr r1, _020A6158 // =aFinal_0
	bl strstr
	movs r7, r0
	bne _020A5F3C
_020A60EC:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	beq _020A6124
	ldr r2, _020A6178 // =aTheServerHasCl
	mov r0, r5
	mov r1, #7
	bl sub_20AFBBC
	mov r0, r5
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x1c
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6124:
	mov r0, r5
	bl sub_20AB8B4
	movs r7, r0
	beq _020A613C
	mov r0, r6
	bl sub_20A0C98
_020A613C:
	cmp r7, #0
	bne _020A5E8C
	mov r0, #0
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A6150: .word 0x0211D170
_020A6154: .word aThereWasAnErro
_020A6158: .word aFinal_0
_020A615C: .word aCmdS
_020A6160: .word aOutOfMemory
_020A6164: .word 0x0211D1C4
_020A6168: .word aNoMatchingOper
_020A616C: .word 0x0211D1F4
_020A6170: .word 0x0211D1FC
_020A6174: .word aReceivedAnUnre
_020A6178: .word aTheServerHasCl
	arm_func_end sub_20A5E54

	arm_func_start sub_20A617C
sub_20A617C: // 0x020A617C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r4, [r5, #0]
	mov r1, #0
	strb r1, [r4, #0x110]
	strb r1, [r4, #0x12f]
	strb r1, [r4, #0x144]
	mvn r0, #0
	str r0, [r4, #0x1d4]
	str r1, [r4, #0x1d8]
	str r1, [r4, #0x1e4]
	str r1, [r4, #0x1e8]
	str r1, [r4, #0x1e0]
	ldr r0, [r4, #0x1dc]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x1dc]
	str r0, [r4, #0x1dc]
	str r0, [r4, #0x1f0]
	ldr r0, [r4, #0x1ec]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x1ec]
	str r0, [r4, #0x1ec]
	str r0, [r4, #0x1fc]
	str r0, [r4, #0x200]
	str r0, [r4, #0x1f8]
	ldr r0, [r4, #0x1f4]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x1f4]
	str r0, [r4, #0x1f4]
	str r0, [r4, #0x448]
	str r0, [r4, #0x44c]
	str r0, [r4, #0x444]
	ldr r0, [r4, #0x440]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x440]
	str r0, [r4, #0x440]
	str r0, [r4, #0x458]
	str r0, [r4, #0x45c]
	str r0, [r4, #0x454]
	ldr r0, [r4, #0x450]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x450]
	str r0, [r4, #0x450]
	mvn r0, #0
	str r0, [r4, #0x204]
	mov r0, #2
	str r0, [r4, #0x20c]
	ldr r1, [r4, #0x424]
	cmp r1, #0
	beq _020A6270
_020A625C:
	mov r0, r5
	bl sub_20AB940
	ldr r1, [r4, #0x424]
	cmp r1, #0
	bne _020A625C
_020A6270:
	mov r2, #0
	str r2, [r4, #0x424]
	ldr r1, _020A62BC // =sub_20A62C0
	mov r0, r5
	str r2, [r4, #0x430]
	bl sub_20AD148
	mov r0, #0
	str r0, [r4, #0x19c]
	str r0, [r4, #0x1a0]
	str r0, [r4, #0x198]
	str r0, [r4, #0x210]
	str r0, [r4, #0x41c]
	str r0, [r4, #0x434]
	mvn r1, #0
	str r1, [r4, #0x214]
	strb r0, [r4, #0x218]
	strb r0, [r4, #0x318]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A62BC: .word sub_20A62C0
	arm_func_end sub_20A617C

	arm_func_start sub_20A62C0
sub_20A62C0: // 0x020A62C0
	mov r0, #0
	str r0, [r1, #8]
	str r0, [r1, #0x10]
	str r0, [r1, #0x14]
	str r0, [r1, #0x18]
	mov r0, #1
	bx lr
	arm_func_end sub_20A62C0

	arm_func_start sub_20A62DC
sub_20A62DC: // 0x020A62DC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r4, [r5, #0]
	mov r1, #1
	bl sub_20A82B0
	ldr r0, [r4, #0x460]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x460]
	ldr r0, [r4, #0x428]
	bl TableFree
	mov r0, r4
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r5]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20A62DC

	arm_func_start sub_20A6324
sub_20A6324: // 0x020A6324
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	mov r0, #0
	str r0, [r6]
	mov r0, #0x490
	mov r5, r1
	mov r4, r2
	bl DWCi_GsMalloc
	str r0, [sp]
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r1, #0
	mov r2, #0x490
	bl memset
	ldr r0, [sp]
	mov r3, #0
	strb r3, [r0]
	ldr r0, [sp]
	mov r2, #1
	str r3, [r0, #0x418]
	ldr r1, [sp]
	add r0, sp, #0
	str r2, [r1, #0x100]
	ldr r1, [sp]
	str r3, [r1, #0x104]
	ldr r1, [sp]
	str r3, [r1, #0x108]
	ldr r1, [sp]
	str r3, [r1, #0x10c]
	ldr r1, [sp]
	str r5, [r1, #0x46c]
	ldr r1, [sp]
	str r4, [r1, #0x470]
	bl sub_20AD52C
	cmp r0, #0
	bne _020A63DC
	ldr r0, [sp]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [sp]
	add sp, sp, #8
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_020A63DC:
	ldr r0, [sp]
	mov r1, #0
	str r1, [r0, #0x420]
	mov r3, r1
_020A63EC:
	ldr r0, [sp]
	add r0, r0, r1, lsl #3
	str r3, [r0, #0x1a4]
	ldr r0, [sp]
	add r0, r0, r1, lsl #3
	add r1, r1, #1
	str r3, [r0, #0x1a8]
	cmp r1, #6
	blt _020A63EC
	ldr r2, [sp]
	ldr r1, _020A6468 // =aGpiinitialize
	add r0, sp, #0
	str r3, [r2, #0x460]
	bl sub_20B008C
	add r0, sp, #0
	bl sub_20A617C
	movs r4, r0
	beq _020A6448
	add r0, sp, #0
	bl sub_20A62DC
	add sp, sp, #8
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
_020A6448:
	bl sub_20A0C94
	bl sub_20A0CA4
	bl srand
	ldr r1, [sp]
	mov r0, #0
	str r1, [r6]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A6468: .word aGpiinitialize
	arm_func_end sub_20A6324

	arm_func_start sub_20A646C
sub_20A646C: // 0x020A646C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	add r2, sp, #0
	ldr r5, [r6, #0]
	bl sub_20AD2A4
	cmp r0, #0
	bne _020A64A4
	ldr r1, _020A65F4 // =aInvalidProfile
	mov r0, r6
	bl sub_20AFBA8
	add sp, sp, #8
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020A64A4:
	ldr r2, _020A65F8 // =aDelbuddy
	mov r0, r6
	add r1, r5, #0x1f4
	bl sub_20A7C58
	ldr r2, _020A65FC // =aSesskey_0
	mov r0, r6
	add r1, r5, #0x1f4
	bl sub_20A7C58
	ldr r2, [r5, #0x198]
	mov r0, r6
	add r1, r5, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A6600 // =aDelprofileid
	mov r0, r6
	add r1, r5, #0x1f4
	bl sub_20A7C58
	mov r0, r6
	add r1, r5, #0x1f4
	ldr r2, [sp]
	ldr r2, [r2, #0]
	bl sub_20A7C20
	mov r0, r6
	add r1, r5, #0x1f4
	ldr r2, _020A6604 // =aFinal_1
	bl sub_20A7C58
	ldr r0, [sp]
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _020A65E8
	ldr r4, [r0, #0]
	cmp r4, #0
	bge _020A6538
	ldr r0, _020A6608 // =aIndex0
	ldr r1, _020A660C // =aGpibuddyC
	ldr r3, _020A6610 // =0x000001FD
	mov r2, #0
	bl __msl_assertion_failed
_020A6538:
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r0, [r0, #8]
	bl DWCi_GsFree
	ldr r0, [sp]
	mov r1, #0
	ldr r0, [r0, #8]
	str r1, [r0, #8]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	ldr r0, [r0, #0xc]
	bl DWCi_GsFree
	ldr r0, [sp]
	mov r1, #0
	ldr r0, [r0, #8]
	str r1, [r0, #0xc]
	ldr r0, [sp]
	ldr r0, [r0, #8]
	bl DWCi_GsFree
	ldr r0, [sp]
	mov r1, #0
	str r1, [r0, #8]
	ldr r0, [sp]
	bl sub_20AD0A8
	cmp r0, #0
	beq _020A65AC
	ldr r1, [sp]
	mov r0, r6
	bl sub_20AD25C
_020A65AC:
	ldr r0, [r5, #0x430]
	sub r0, r0, #1
	str r0, [r5, #0x430]
	ldr r0, [r5, #0x430]
	cmp r0, #0
	bge _020A65D8
	ldr r0, _020A6614 // =aIconnectionPro
	ldr r1, _020A660C // =aGpibuddyC
	mov r2, #0
	mov r3, #0x204
	bl __msl_assertion_failed
_020A65D8:
	ldr r1, _020A6618 // =sub_20A661C
	mov r0, r6
	mov r2, r4
	bl sub_20AD148
_020A65E8:
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A65F4: .word aInvalidProfile
_020A65F8: .word aDelbuddy
_020A65FC: .word aSesskey_0
_020A6600: .word aDelprofileid
_020A6604: .word aFinal_1
_020A6608: .word aIndex0
_020A660C: .word aGpibuddyC
_020A6610: .word 0x000001FD
_020A6614: .word aIconnectionPro
_020A6618: .word sub_20A661C
	arm_func_end sub_20A646C

	arm_func_start sub_20A661C
sub_20A661C: // 0x020A661C
	ldr r1, [r1, #8]
	cmp r1, #0
	beq _020A6638
	ldr r0, [r1, #0]
	cmp r0, r2
	subgt r0, r0, #1
	strgt r0, [r1]
_020A6638:
	mov r0, #1
	bx lr
	arm_func_end sub_20A661C

	arm_func_start sub_20A6640
sub_20A6640: // 0x020A6640
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	add r2, sp, #0
	ldr r5, [r4, #0]
	bl sub_20AD2A4
	cmp r0, #0
	bne _020A6678
	ldr r1, _020A671C // =aInvalidProfile
	mov r0, r4
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, pc}
_020A6678:
	ldr r1, [sp]
	ldr r0, [r1, #0x10]
	cmp r0, #0
	bne _020A66A0
	ldr r1, _020A671C // =aInvalidProfile
	mov r0, r4
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #2
	ldmia sp!, {r4, r5, pc}
_020A66A0:
	mov r0, r4
	bl sub_20A7318
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	ldr r1, [sp]
	ldr r0, [r1, #0x14]
	sub r0, r0, #1
	str r0, [r1, #0x14]
	ldr r0, [r5, #0x100]
	cmp r0, #0
	bne _020A6710
	ldr r1, [sp]
	ldr r0, [r1, #0x14]
	cmp r0, #0
	bgt _020A6710
	ldr r0, [r1, #0x10]
	bl DWCi_GsFree
	ldr r0, [sp]
	mov r1, #0
	str r1, [r0, #0x10]
	ldr r0, [sp]
	bl sub_20AD0A8
	cmp r0, #0
	beq _020A6710
	ldr r1, [sp]
	mov r0, r4
	bl sub_20AD25C
_020A6710:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A671C: .word aInvalidProfile
	arm_func_end sub_20A6640

	arm_func_start sub_20A6720
sub_20A6720: // 0x020A6720
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bl sub_20AC3DC
	movs r8, r0
	bne _020A67F8
	add r2, sp, #0
	mov r0, r7
	mov r1, r6
	bl sub_20AD2A4
	cmp r0, #0
	beq _020A6778
	ldr r0, [sp]
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _020A6778
	ldr r0, [r0, #0x14]
	cmp r0, #0
	bne _020A6794
_020A6778:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl sub_20A681C
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A6794:
	mov r0, r7
	mov r1, r6
	mov r2, #1
	bl sub_20AC330
	movs r8, r0
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [sp]
	ldr r0, [r0, #0x18]
	cmp r0, #0
	bne _020A67E0
	mov r0, r7
	mov r1, r8
	bl sub_20AC2CC
	cmp r0, #0
	beq _020A67F8
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A67E0:
	mov r0, r7
	mov r1, r8
	bl sub_20AC134
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_020A67F8:
	mov r0, r7
	mov r1, r8
	mov r2, r5
	mov r3, r4
	bl sub_20ABFA8
	cmp r0, #0
	moveq r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end sub_20A6720

	arm_func_start sub_20A681C
sub_20A681C: // 0x020A681C
	stmdb sp!, {r4, r5, r6, r7, lr}
	ldr ip, _020A68E8 // =0x00000DB4
	sub sp, sp, ip
	mov r7, r0
	mov r5, r2
	mov r6, r1
	ldr r2, _020A68EC // =0x00000DAD
	add r0, sp, #0
	mov r1, r3
	ldr r4, [r7, #0]
	bl sub_20B0098
	ldr r2, _020A68F0 // =0x0211D308
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r7
	mov r2, r5
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A68F4 // =aSesskey_0
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x198]
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A68F8 // =0x0211D310
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r2, r6
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A68FC // =aMsg
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r7
	add r1, r4, #0x1f4
	add r2, sp, #0
	bl sub_20A7C58
	ldr r2, _020A6900 // =aFinal_1
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, #0
	ldr ip, _020A68E8 // =0x00000DB4
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A68E8: .word 0x00000DB4
_020A68EC: .word 0x00000DAD
_020A68F0: .word 0x0211D308
_020A68F4: .word aSesskey_0
_020A68F8: .word 0x0211D310
_020A68FC: .word aMsg
_020A6900: .word aFinal_1
	arm_func_end sub_20A681C

	arm_func_start sub_20A6904
sub_20A6904: // 0x020A6904
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr ip, _020A72D4 // =0x0000113C
	sub sp, sp, ip
	mov r4, r1
	mov r10, r0
	ldr r1, _020A72D8 // =0x0211D308
	add r2, sp, #0x38
	mov r0, r4
	mov r3, #0x1000
	ldr r6, [r10, #0]
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A6968
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6968:
	add r0, sp, #0x38
	bl atoi
	mov r5, r0
	ldr r1, _020A72E0 // =0x0211D34C
	add r2, sp, #0x38
	mov r0, r4
	mov r3, #0x1000
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A69C0
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A69C0:
	add r0, sp, #0x38
	bl atoi
	mov r8, r0
	ldr r1, _020A72E4 // =aDate_0
	add r2, sp, #0x38
	mov r0, r4
	mov r3, #0x1000
	bl sub_20AFEAC
	cmp r0, #0
	beq _020A69F8
	add r0, sp, #0x38
	bl atoi
	mov r9, r0
	b _020A6A04
_020A69F8:
	mov r0, #0
	bl sub_20A0510
	mov r9, r0
_020A6A04:
	cmp r5, #0x64
	bgt _020A6A38
	cmp r5, #0x64
	bge _020A6D34
	cmp r5, #2
	bgt _020A72C4
	cmp r5, #1
	blt _020A72C4
	cmp r5, #1
	beq _020A6A5C
	cmp r5, #2
	beq _020A6B70
	b _020A72C4
_020A6A38:
	cmp r5, #0x66
	bgt _020A72C4
	cmp r5, #0x65
	blt _020A72C4
	cmp r5, #0x65
	beq _020A70C4
	cmp r5, #0x66
	beq _020A7264
	b _020A72C4
_020A6A5C:
	ldr r1, [r6, #0x1bc]
	ldr r0, [r6, #0x1c0]
	cmp r1, #0
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	beq _020A72C4
	mov r0, #0xc
	bl DWCi_GsMalloc
	movs r5, r0
	bne _020A6AA0
	ldr r1, _020A72E8 // =aOutOfMemory_0
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6AA0:
	ldr r1, _020A72EC // =aMsg
	add r2, sp, #0x38
	mov r0, r4
	mov r3, #0x1000
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A6AEC
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6AEC:
	add r0, sp, #0x38
	bl strlen
	add r0, r0, #1
	bl DWCi_GsMalloc
	str r0, [r5, #8]
	ldr r0, [r5, #8]
	cmp r0, #0
	bne _020A6B28
	ldr r1, _020A72E8 // =aOutOfMemory_0
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6B28:
	add r1, sp, #0x38
	bl strcpy
	str r8, [r5]
	str r9, [r5, #4]
	mov r0, #0
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	add r1, sp, #8
	mov r0, r10
	mov r3, r5
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020A72C4
	ldr ip, _020A72D4 // =0x0000113C
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6B70:
	mov r0, r10
	mov r1, r8
	bl sub_20AD2E0
	movs r5, r0
	bne _020A6BA0
	ldr r1, _020A72E8 // =aOutOfMemory_0
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6BA0:
	ldr r1, _020A72EC // =aMsg
	add r2, sp, #0x38
	mov r0, r4
	mov r3, #0x1000
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A6BEC
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6BEC:
	ldr r1, _020A72F0 // =aSigned
	add r0, sp, #0x38
	bl strstr
	movs r4, r0
	bne _020A6C30
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6C30:
	mov r1, #0
	add r0, r4, #8
	strb r1, [r4]
	bl strlen
	cmp r0, #0x20
	beq _020A6C78
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6C78:
	ldr r0, [r5, #0x10]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r5, #0x10]
	add r0, r4, #8
	bl sub_20A0C50
	str r0, [r5, #0x10]
	ldr r0, [r5, #0x14]
	add r0, r0, #1
	str r0, [r5, #0x14]
	ldr r1, [r6, #0x1ac]
	ldr r0, [r6, #0x1b0]
	cmp r1, #0
	str r1, [sp, #0x20]
	str r0, [sp, #0x24]
	beq _020A72C4
	ldr r0, _020A72F4 // =0x0000040C
	bl DWCi_GsMalloc
	movs r4, r0
	bne _020A6CE4
	ldr r1, _020A72E8 // =aOutOfMemory_0
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6CE4:
	ldr r2, _020A72F8 // =0x00000401
	add r1, sp, #0x38
	add r0, r4, #8
	bl sub_20B0098
	str r8, [r4]
	str r9, [r4, #4]
	mov r0, #0
	str r0, [sp]
	mov r0, #6
	str r0, [sp, #4]
	add r1, sp, #0x20
	mov r0, r10
	mov r3, r4
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020A72C4
	ldr ip, _020A72D4 // =0x0000113C
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6D34:
	mov r0, r10
	mov r1, r8
	bl sub_20AD2E0
	movs r5, r0
	bne _020A6D64
	ldr r1, _020A72E8 // =aOutOfMemory_0
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6D64:
	ldr r0, [r5, #8]
	cmp r0, #0
	bne _020A6DD8
	mov r0, #0x18
	bl DWCi_GsMalloc
	str r0, [r5, #8]
	ldr r2, [r5, #8]
	cmp r2, #0
	bne _020A6DA4
	ldr r1, _020A72E8 // =aOutOfMemory_0
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6DA4:
	mov r1, #6
	mov r0, #0
_020A6DAC:
	strb r0, [r2], #1
	strb r0, [r2], #1
	strb r0, [r2], #1
	strb r0, [r2], #1
	subs r1, r1, #1
	bne _020A6DAC
	ldr r1, [r6, #0x430]
	add r0, r1, #1
	str r0, [r6, #0x430]
	ldr r0, [r5, #8]
	str r1, [r0]
_020A6DD8:
	ldr r1, _020A72EC // =aMsg
	add r2, sp, #0x38
	mov r0, r4
	mov r3, #0x1000
	ldr r7, [r5, #8]
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A6E28
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6E28:
	ldr r1, _020A72FC // =0x0211D374
	add r0, sp, #0x38
	add r2, sp, #0x28
	mov r3, #0x10
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A6E74
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6E74:
	add r0, sp, #0x28
	bl atoi
	str r0, [r7, #4]
	ldr r0, [r7, #8]
	bl DWCi_GsFree
	mov r0, #0
	add r2, sp, #0x1000
	str r0, [r7, #8]
	ldr r1, _020A7300 // =0x0211D378
	add r0, sp, #0x38
	add r2, r2, #0x38
	mov r3, #0x100
	bl sub_20AFEAC
	cmp r0, #0
	addeq r0, sp, #0x1000
	moveq r1, #0
	addeq r0, r0, #8
	streqb r1, [r0, #0x30]
	add r0, sp, #0x1000
	add r0, r0, #0x38
	bl sub_20A0C50
	str r0, [r7, #8]
	ldr r0, [r7, #8]
	cmp r0, #0
	bne _020A6EF4
	ldr r1, _020A72E8 // =aOutOfMemory_0
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6EF4:
	ldr r0, [r7, #0xc]
	bl DWCi_GsFree
	add r2, sp, #0x1000
	mov r4, #0
	ldr r1, _020A7304 // =0x0211D380
	add r0, sp, #0x38
	add r2, r2, #0x38
	mov r3, #0x100
	str r4, [r7, #0xc]
	bl sub_20AFEAC
	cmp r0, #0
	addeq r0, sp, #0x1000
	moveq r1, r4
	addeq r0, r0, #8
	streqb r1, [r0, #0x30]
	add r0, sp, #0x1000
	add r0, r0, #0x38
	bl sub_20A0C50
	str r0, [r7, #0xc]
	ldr r0, [r7, #0xc]
	cmp r0, #0
	bne _020A6F68
	ldr r1, _020A72E8 // =aOutOfMemory_0
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A6F68:
	ldr r1, _020A7308 // =0x0211D388
	add r0, sp, #0x38
	add r2, sp, #0x28
	mov r3, #0x10
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [r7, #0x10]
	beq _020A6FE8
	add r0, sp, #0x28
	bl atoi
	mov r5, r0
	add r0, sp, #0x28
	bl atoi
	mov r4, r0
	add r0, sp, #0x28
	bl atoi
	mov r11, r0
	add r0, sp, #0x28
	bl atoi
	mov r1, r11, lsr #0x18
	mov r0, r0, lsr #8
	mov r2, r4, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	mov r3, r5, lsl #0x18
	orr r0, r1, r0
	and r2, r2, #0xff0000
	and r1, r3, #0xff000000
	orr r0, r2, r0
	orr r0, r1, r0
	str r0, [r7, #0x10]
_020A6FE8:
	ldr r1, _020A730C // =0x0211D390
	add r0, sp, #0x38
	add r2, sp, #0x28
	mov r3, #0x10
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [r7, #0x14]
	beq _020A703C
	add r0, sp, #0x28
	bl atoi
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, asr #8
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	str r0, [r7, #0x14]
_020A703C:
	ldr r1, [r6, #0x1b4]
	ldr r0, [r6, #0x1b8]
	cmp r1, #0
	str r1, [sp, #0x18]
	str r0, [sp, #0x1c]
	beq _020A72C4
	mov r0, #0xc
	bl DWCi_GsMalloc
	movs r3, r0
	bne _020A7080
	ldr r1, _020A72E8 // =aOutOfMemory_0
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A7080:
	str r8, [r3]
	ldr r1, [r7, #0]
	mov r0, #0
	str r1, [r3, #8]
	str r9, [r3, #4]
	str r0, [sp]
	mov r0, #5
	str r0, [sp, #4]
	add r1, sp, #0x18
	mov r0, r10
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020A72C4
	ldr ip, _020A72D4 // =0x0000113C
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A70C4:
	ldr r1, _020A72EC // =aMsg
	add r2, sp, #0x38
	mov r0, r4
	mov r3, #0x1000
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A7110
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A7110:
	ldr r1, _020A730C // =0x0211D390
	add r0, sp, #0x38
	bl strstr
	cmp r0, #0
	bne _020A7154
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A7154:
	ldrsb r1, [r0, #3]
	cmp r1, #0
	bne _020A7190
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A7190:
	add r0, r0, #3
	bl atoi
	mov r4, r0
	ldr r1, _020A7310 // =0x0211D394
	add r0, sp, #0x38
	bl strstr
	movs r1, r0
	addeq r0, sp, #0x1000
	moveq r1, #0
	addeq r0, r0, #8
	streqb r1, [r0, #0x30]
	beq _020A71D4
	add r0, sp, #0x1000
	add r0, r0, #0x38
	add r1, r1, #3
	mov r2, #0x100
	bl sub_20B0098
_020A71D4:
	ldr r1, [r6, #0x1c4]
	ldr r0, [r6, #0x1c8]
	cmp r1, #0
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	beq _020A72C4
	mov r0, #0x108
	bl DWCi_GsMalloc
	movs r5, r0
	bne _020A7218
	ldr r1, _020A72E8 // =aOutOfMemory_0
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A7218:
	add r1, sp, #0x1000
	str r8, [r5]
	add r1, r1, #0x38
	add r0, r5, #8
	str r4, [r5, #4]
	bl strcpy
	mov r0, #0
	str r0, [sp]
	str r0, [sp, #4]
	add r1, sp, #0x10
	mov r0, r10
	mov r3, r5
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020A72C4
	ldr ip, _020A72D4 // =0x0000113C
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A7264:
	ldr r1, _020A72EC // =aMsg
	add r2, sp, #0x38
	mov r0, r4
	mov r3, #0x1000
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A72B0
	ldr r2, _020A72DC // =aUnexpectedData
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020A72D4 // =0x0000113C
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A72B0:
	ldr r3, _020A7314 // =0x0211D398
	mov r0, r10
	mov r1, r8
	mov r2, #0x67
	bl sub_20A6720
_020A72C4:
	mov r0, #0
	ldr ip, _020A72D4 // =0x0000113C
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A72D4: .word 0x0000113C
_020A72D8: .word 0x0211D308
_020A72DC: .word aUnexpectedData
_020A72E0: .word 0x0211D34C
_020A72E4: .word aDate_0
_020A72E8: .word aOutOfMemory_0
_020A72EC: .word aMsg
_020A72F0: .word aSigned
_020A72F4: .word 0x0000040C
_020A72F8: .word 0x00000401
_020A72FC: .word 0x0211D374
_020A7300: .word 0x0211D378
_020A7304: .word 0x0211D380
_020A7308: .word 0x0211D388
_020A730C: .word 0x0211D390
_020A7310: .word 0x0211D394
_020A7314: .word 0x0211D398
	arm_func_end sub_20A6904

	arm_func_start sub_20A7318
sub_20A7318: // 0x020A7318
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0]
	ldr r2, _020A73AC // =aAuthadd
	mov r5, r1
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, _020A73B0 // =aSesskey_0
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x198]
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A73B4 // =aFromprofileid
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	ldr r2, [r5, #0]
	bl sub_20A7C20
	mov r0, r6
	add r1, r4, #0x1f4
	ldr r2, _020A73B8 // =aSig
	bl sub_20A7C58
	ldr r2, [r5, #0x10]
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	ldr r2, _020A73BC // =aFinal_1
	bl sub_20A7C58
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A73AC: .word aAuthadd
_020A73B0: .word aSesskey_0
_020A73B4: .word aFromprofileid
_020A73B8: .word aSig
_020A73BC: .word aFinal_1
	arm_func_end sub_20A7318

	arm_func_start sub_20A73C0
sub_20A73C0: // 0x020A73C0
	stmdb sp!, {r4, lr}
	movs r4, r1
	beq _020A73E4
	ldr r0, [r4, #0]
	cmp r0, #0
	beq _020A73E4
	ldr r1, [r4, #0xc]
	cmp r1, #0
	bne _020A73EC
_020A73E4:
	mov r0, #0
	ldmia sp!, {r4, pc}
_020A73EC:
	ldr r0, [r4, #8]
	sub r0, r0, r1
	str r0, [r4, #8]
	ldr r2, [r4, #8]
	cmp r2, #0
	beq _020A7414
	ldr r0, [r4, #0]
	ldr r1, [r4, #0xc]
	add r1, r0, r1
	bl memmove
_020A7414:
	ldr r2, [r4, #0]
	ldr r1, [r4, #8]
	mov r0, #0
	strb r0, [r2, r1]
	str r0, [r4, #0xc]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20A73C0

	arm_func_start sub_20A742C
sub_20A742C: // 0x020A742C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r5, r2
	mov r0, #0
	mov r6, r1
	str r0, [r5]
	ldr r1, [r6, #8]
	mov r7, r3
	cmp r1, #5
	addlt sp, sp, #0x14
	ldmltia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r6, #0]
	mov r1, #0xa
	bl strchr
	movs r4, r0
	beq _020A7550
	ldr r1, _020A755C // =aMsg_0
	sub r0, r4, #5
	mov r2, #5
	bl strncmp
	cmp r0, #0
	addne sp, sp, #0x14
	movne r0, #3
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, #0
	strb r0, [r4]
	ldr r0, [r6, #0]
	ldr r1, _020A7560 // =0x0211D3C8
	add r2, sp, #0
	mov r3, #0x10
	bl sub_20AFEAC
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	add r0, sp, #0
	bl atoi
	str r0, [r7]
	ldr r0, [r6, #0]
	ldr r1, _020A7564 // =aLen_0
	add r2, sp, #0
	mov r3, #0x10
	bl sub_20AFEAC
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	add r0, sp, #0
	bl atoi
	ldr r2, [r6, #0]
	add r1, r0, #1
	sub r2, r4, r2
	ldr r3, [r6, #8]
	add r2, r1, r2
	cmp r3, r2
	ble _020A7548
	ldrsb r2, [r4, r1]
	cmp r2, #0
	addne sp, sp, #0x14
	movne r0, #3
	ldmneia sp!, {r4, r5, r6, r7, pc}
	add r3, r4, #1
	ldr r2, [sp, #0x28]
	str r3, [r5]
	str r0, [r2]
	ldr r0, [r6, #0]
	sub r0, r4, r0
	add r0, r1, r0
	add r0, r0, #1
	str r0, [r6, #0xc]
	b _020A7550
_020A7548:
	mov r0, #0xa
	strb r0, [r4]
_020A7550:
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A755C: .word aMsg_0
_020A7560: .word 0x0211D3C8
_020A7564: .word aLen_0
	arm_func_end sub_20A742C

	arm_func_start sub_20A7568
sub_20A7568: // 0x020A7568
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x1c
	mov r10, r0
	str r2, [sp, #0xc]
	mov r9, r1
	str r3, [sp, #0x10]
	movs r0, r2
	ldr r8, [sp, #0x44]
	bne _020A75A0
	ldr r0, _020A76C8 // =aOutputbufferNu
	ldr r1, _020A76CC // =aGpibufferC
	ldr r3, _020A76D0 // =0x000001B9
	mov r2, #0
	bl __msl_assertion_failed
_020A75A0:
	ldr r0, [sp, #0xc]
	mov r7, #0
	ldr r11, [r0, #8]
	ldr r4, [r0, #0xc]
	ldr r5, [r0, #0]
	subs r6, r11, r4
	addeq sp, sp, #0x1c
	moveq r0, r7
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A75C4:
	add r1, sp, #0x14
	str r1, [sp]
	add r0, sp, #0x18
	str r0, [sp, #4]
	add r2, r4, r7
	mov r0, r10
	mov r1, r9
	mov r3, r6
	add r2, r5, r2
	str r8, [sp, #8]
	bl sub_20A7B24
	cmp r0, #0
	addne sp, sp, #0x1c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x18]
	cmp r0, #0
	addne r7, r7, r0
	subne r6, r6, r0
	cmp r0, #0
	beq _020A761C
	cmp r6, #0
	bne _020A75C4
_020A761C:
	ldr r0, [sp, #0x40]
	cmp r0, #0
	beq _020A7648
	cmp r7, #0
	ble _020A764C
	mov r0, r5
	add r1, r5, r7
	add r2, r6, #1
	bl memmove
	sub r11, r11, r7
	b _020A764C
_020A7648:
	add r4, r4, r7
_020A764C:
	cmp r11, #0
	bge _020A7668
	ldr r0, _020A76D4 // =aLen0_1
	ldr r1, _020A76CC // =aGpibufferC
	ldr r3, _020A76D8 // =0x000001DE
	mov r2, #0
	bl __msl_assertion_failed
_020A7668:
	cmp r4, #0
	bge _020A7684
	ldr r0, _020A76DC // =aPos0
	ldr r1, _020A76CC // =aGpibufferC
	ldr r3, _020A76E0 // =0x000001DF
	mov r2, #0
	bl __msl_assertion_failed
_020A7684:
	cmp r4, r11
	ble _020A76A0
	ldr r0, _020A76E4 // =aPosLen
	ldr r1, _020A76CC // =aGpibufferC
	mov r2, #0
	mov r3, #0x1e0
	bl __msl_assertion_failed
_020A76A0:
	ldr r0, [sp, #0xc]
	str r11, [r0, #8]
	str r4, [r0, #0xc]
	ldr r0, [sp, #0x10]
	cmp r0, #0
	ldrne r1, [sp, #0x14]
	strne r1, [r0]
	mov r0, #0
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A76C8: .word aOutputbufferNu
_020A76CC: .word aGpibufferC
_020A76D0: .word 0x000001B9
_020A76D4: .word aLen0_1
_020A76D8: .word 0x000001DE
_020A76DC: .word aPos0
_020A76E0: .word 0x000001DF
_020A76E4: .word aPosLen
	arm_func_end sub_20A7568

	arm_func_start sub_20A76E8
sub_20A76E8: // 0x020A76E8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r11, r0
	ldr r0, [sp, #0x3c]
	mov r10, r1
	mvn r1, #0
	str r2, [sp]
	str r3, [sp, #4]
	cmp r10, r1
	str r0, [sp, #0x3c]
	bne _020A7728
	ldr r0, _020A78E4 // =aSockInvalidSoc
	ldr r1, _020A78E8 // =aGpibufferC
	mov r2, #0
	mov r3, #0x150
	bl __msl_assertion_failed
_020A7728:
	ldr r0, [sp]
	cmp r0, #0
	bne _020A7748
	ldr r0, _020A78EC // =aInputbufferNul
	ldr r1, _020A78E8 // =aGpibufferC
	ldr r3, _020A78F0 // =0x00000151
	mov r2, #0
	bl __msl_assertion_failed
_020A7748:
	ldr r0, [sp, #4]
	cmp r0, #0
	bne _020A7768
	ldr r0, _020A78F4 // =aBytesreadNull
	ldr r1, _020A78E8 // =aGpibufferC
	ldr r3, _020A78F8 // =0x00000152
	mov r2, #0
	bl __msl_assertion_failed
_020A7768:
	ldr r0, [sp, #0x38]
	cmp r0, #0
	bne _020A7788
	ldr r0, _020A78FC // =aConnclosedNull
	ldr r1, _020A78E8 // =aGpibufferC
	ldr r3, _020A7900 // =0x00000153
	mov r2, #0
	bl __msl_assertion_failed
_020A7788:
	ldr r0, [sp]
	mov r5, #0
	ldr r9, [r0, #0]
	ldr r8, [r0, #8]
	ldr r7, [r0, #4]
	mov r0, #1
	mov r4, r5
	str r5, [sp, #8]
	str r5, [sp, #0x10]
	str r0, [sp, #0xc]
_020A77B0:
	add r0, r8, #0x800
	cmp r0, r7
	ble _020A77EC
	mov r7, r0
	add r1, r0, #1
	mov r0, r9
	bl DWCi_GsRealloc
	movs r9, r0
	bne _020A77EC
	ldr r1, _020A7904 // =aOutOfMemory_1
	mov r0, r11
	bl sub_20AFBA8
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A77EC:
	ldr r3, [sp, #8]
	mov r0, r10
	add r1, r9, r8
	sub r2, r7, r8
	bl sub_20A06C0
	mov r6, r0
	mvn r0, #0
	cmp r6, r0
	bne _020A7854
	mov r0, r10
	bl WSAGetLastError
	mvn r1, #5
	cmp r0, r1
	beq _020A7878
	mvn r1, #0x19
	cmp r0, r1
	beq _020A7878
	mvn r1, #0x4b
	cmp r0, r1
	beq _020A7878
	ldr r1, _020A7908 // =aThereWasAnErro_0
	mov r0, r11
	bl sub_20AFBA8
	add sp, sp, #0x14
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A7854:
	cmp r6, #0
	addne r8, r8, r6
	addne r5, r5, r6
	bne _020A7878
	ldr r1, _020A790C // =aRecvxxxxSConne
	ldr r2, [sp, #0x3c]
	mov r0, r11
	ldr r4, [sp, #0xc]
	bl sub_20B008C
_020A7878:
	ldr r0, [sp, #0x10]
	strb r0, [r9, r8]
	mvn r0, #0
	cmp r6, r0
	beq _020A789C
	cmp r4, #0
	bne _020A789C
	cmp r5, #0x20000
	blt _020A77B0
_020A789C:
	cmp r5, #0
	beq _020A78B8
	ldr r1, _020A7910 // =aRecvtotlSD
	ldr r2, [sp, #0x3c]
	mov r0, r11
	mov r3, r5
	bl sub_20B008C
_020A78B8:
	ldr r0, [sp]
	ldr r1, [sp, #0x38]
	str r9, [r0]
	str r8, [r0, #8]
	str r7, [r0, #4]
	ldr r0, [sp, #4]
	str r5, [r0]
	str r4, [r1]
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A78E4: .word aSockInvalidSoc
_020A78E8: .word aGpibufferC
_020A78EC: .word aInputbufferNul
_020A78F0: .word 0x00000151
_020A78F4: .word aBytesreadNull
_020A78F8: .word 0x00000152
_020A78FC: .word aConnclosedNull
_020A7900: .word 0x00000153
_020A7904: .word aOutOfMemory_1
_020A7908: .word aThereWasAnErro_0
_020A790C: .word aRecvxxxxSConne
_020A7910: .word aRecvtotlSD
	arm_func_end sub_20A76E8

	arm_func_start sub_20A7914
sub_20A7914: // 0x020A7914
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r2
	mov r6, r0
	mov r5, r1
	mov r0, r4
	bl strlen
	mov r3, r0
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20A7944
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20A7914

	arm_func_start sub_20A7944
sub_20A7944: // 0x020A7944
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r9, r1
	ldr r1, [r9, #0x28]
	mov r10, r0
	mov r8, r2
	mov r7, r3
	cmp r1, #0
	bne _020A797C
	ldr r0, _020A7A3C // =aPeerOutputbuff
	ldr r1, _020A7A40 // =aGpibufferC
	mov r2, #0
	mov r3, #0xfb
	bl __msl_assertion_failed
_020A797C:
	cmp r7, #0
	mov r6, #0
	addeq sp, sp, #0x14
	moveq r0, r6
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r9, #0x30]
	ldr r0, [r9, #0x34]
	subs r0, r1, r0
	bne _020A7A08
	ldr r0, [r9, #0x38]
	bl ArrayLength
	cmp r0, #0
	bne _020A7A08
	ldr r11, _020A7A44 // =0x0211D50C
	add r5, sp, #0xc
	add r4, sp, #0x10
_020A79BC:
	str r5, [sp]
	str r4, [sp, #4]
	str r11, [sp, #8]
	ldr r1, [r9, #8]
	mov r0, r10
	mov r3, r7
	add r2, r8, r6
	bl sub_20A7B24
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x10]
	cmp r0, #0
	addne r6, r6, r0
	subne r7, r7, r0
	cmp r0, #0
	beq _020A7A08
	cmp r7, #0
	bne _020A79BC
_020A7A08:
	cmp r7, #0
	beq _020A7A30
	mov r0, r10
	mov r3, r7
	add r1, r9, #0x28
	add r2, r8, r6
	bl sub_20A7C88
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020A7A30:
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A7A3C: .word aPeerOutputbuff
_020A7A40: .word aGpibufferC
_020A7A44: .word 0x0211D50C
	arm_func_end sub_20A7944

	arm_func_start sub_20A7A48
sub_20A7A48: // 0x020A7A48
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r4, r1
	ldr r1, [r4, #0x28]
	mov r5, r0
	cmp r1, #0
	bne _020A7A7C
	ldr r0, _020A7B18 // =aPeerOutputbuff
	ldr r1, _020A7B1C // =aGpibufferC
	mov r2, #0
	mov r3, #0xde
	bl __msl_assertion_failed
_020A7A7C:
	ldr r1, [r4, #0x30]
	ldr r0, [r4, #0x34]
	subs r0, r1, r0
	bne _020A7AF8
	ldr r0, [r4, #0x38]
	bl ArrayLength
	cmp r0, #0
	bne _020A7AF8
	add r0, sp, #0xc
	str r0, [sp]
	add r1, sp, #0x10
	ldr r0, _020A7B20 // =0x0211D50C
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr r1, [r4, #8]
	add r2, sp, #0x28
	mov r0, r5
	mov r3, #1
	bl sub_20A7B24
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, lr}
	addne sp, sp, #0x10
	bxne lr
	ldr r0, [sp, #0x10]
	cmp r0, #0
	addne sp, sp, #0x14
	movne r0, #0
	ldmneia sp!, {r4, r5, lr}
	addne sp, sp, #0x10
	bxne lr
_020A7AF8:
	ldrsb r2, [sp, #0x28]
	mov r0, r5
	add r1, r4, #0x28
	bl sub_20A7D90
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020A7B18: .word aPeerOutputbuff
_020A7B1C: .word aGpibufferC
_020A7B20: .word 0x0211D50C
	arm_func_end sub_20A7A48

	arm_func_start sub_20A7B24
sub_20A7B24: // 0x020A7B24
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r1
	mov r7, r0
	mov r1, r2
	mov r2, r3
	mov r0, r8
	mov r3, #0
	ldr r6, [sp, #0x18]
	ldr r5, [sp, #0x1c]
	ldr r4, [sp, #0x20]
	bl sub_20A066C
	mvn r1, #0
	cmp r0, r1
	bne _020A7BDC
	mov r0, r8
	bl WSAGetLastError
	mvn r1, #5
	cmp r0, r1
	beq _020A7BCC
	mvn r1, #0x19
	cmp r0, r1
	beq _020A7BCC
	mvn r1, #0x4b
	cmp r0, r1
	beq _020A7BCC
	ldrsb r0, [r4, #0]
	cmp r0, #0x50
	bne _020A7BA4
	ldrsb r0, [r4, #1]
	cmp r0, #0x52
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_020A7BA4:
	ldr r2, _020A7C18 // =aThereWasAnErro_1
	mov r0, r7
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r7
	mov r1, #3
	mov r2, #0
	bl sub_20A81BC
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A7BCC:
	mov r0, #0
	str r0, [r5]
	str r0, [r6]
	b _020A7C10
_020A7BDC:
	cmp r0, #0
	strne r0, [r5]
	movne r0, #0
	strne r0, [r6]
	bne _020A7C10
	ldr r1, _020A7C1C // =aSendxxxxSConne
	mov r0, r7
	mov r2, r4
	bl sub_20B008C
	mov r0, #0
	str r0, [r5]
	mov r0, #1
	str r0, [r6]
_020A7C10:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020A7C18: .word aThereWasAnErro_1
_020A7C1C: .word aSendxxxxSConne
	arm_func_end sub_20A7B24

	arm_func_start sub_20A7C20
sub_20A7C20: // 0x020A7C20
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r4, r1
	mov r5, r0
	ldr r1, _020A7C54 // =0x0211D4E4
	add r0, sp, #0
	bl sprintf
	add r2, sp, #0
	mov r0, r5
	mov r1, r4
	bl sub_20A7C58
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A7C54: .word 0x0211D4E4
	arm_func_end sub_20A7C20

	arm_func_start sub_20A7C58
sub_20A7C58: // 0x020A7C58
	stmdb sp!, {r4, r5, r6, lr}
	mov r4, r2
	mov r6, r0
	mov r5, r1
	mov r0, r4
	bl strlen
	mov r3, r0
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20A7C88
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20A7C58

	arm_func_start sub_20A7C88
sub_20A7C88: // 0x020A7C88
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	movs r8, r2
	mov r10, r0
	mov r9, r1
	mov r7, r3
	bne _020A7CB4
	ldr r0, _020A7D7C // =aStringNull
	ldr r1, _020A7D80 // =aGpibufferC
	mov r2, #0
	mov r3, #0x51
	bl __msl_assertion_failed
_020A7CB4:
	cmp r7, #0
	bge _020A7CD0
	ldr r0, _020A7D84 // =aStringlen0
	ldr r1, _020A7D80 // =aGpibufferC
	mov r2, #0
	mov r3, #0x52
	bl __msl_assertion_failed
_020A7CD0:
	cmp r9, #0
	bne _020A7CEC
	ldr r0, _020A7D88 // =aOutputbufferNu
	ldr r1, _020A7D80 // =aGpibufferC
	mov r2, #0
	mov r3, #0x53
	bl __msl_assertion_failed
_020A7CEC:
	cmp r8, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r6, [r9, #8]
	ldr r5, [r9, #4]
	ldr r4, [r9, #0]
	sub r0, r5, r6
	cmp r0, r7
	bge _020A7D48
	cmp r7, #0x800
	movlt r0, #0x800
	movge r0, r7
	add r5, r5, r0
	mov r0, r4
	add r1, r5, #1
	bl DWCi_GsRealloc
	movs r4, r0
	bne _020A7D48
	ldr r1, _020A7D8C // =aOutOfMemory_1
	mov r0, r10
	bl sub_20AFBA8
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A7D48:
	mov r1, r8
	mov r2, r7
	add r0, r4, r6
	bl memcpy
	add r1, r6, r7
	mov r0, #0
	strb r0, [r4, r1]
	ldr r1, [r9, #8]
	add r1, r1, r7
	str r1, [r9, #8]
	str r5, [r9, #4]
	str r4, [r9]
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020A7D7C: .word aStringNull
_020A7D80: .word aGpibufferC
_020A7D84: .word aStringlen0
_020A7D88: .word aOutputbufferNu
_020A7D8C: .word aOutOfMemory_1
	arm_func_end sub_20A7C88

	arm_func_start sub_20A7D90
sub_20A7D90: // 0x020A7D90
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r4, r1
	mov r8, r0
	mov r7, r2
	bne _020A7DB8
	ldr r0, _020A7E20 // =aOutputbufferNu
	ldr r1, _020A7E24 // =aGpibufferC
	mov r2, #0
	mov r3, #0x25
	bl __msl_assertion_failed
_020A7DB8:
	ldr r6, [r4, #8]
	ldr r5, [r4, #4]
	ldr r0, [r4, #0]
	cmp r5, r6
	bne _020A7DF4
	add r5, r5, #0x800
	add r1, r5, #1
	bl DWCi_GsRealloc
	cmp r0, #0
	bne _020A7DF4
	ldr r1, _020A7E28 // =aOutOfMemory_1
	mov r0, r8
	bl sub_20AFBA8
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A7DF4:
	strb r7, [r0, r6]
	add r1, r6, #1
	mov r2, #0
	strb r2, [r0, r1]
	ldr r1, [r4, #8]
	add r1, r1, #1
	str r1, [r4, #8]
	str r5, [r4, #4]
	str r0, [r4]
	mov r0, r2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020A7E20: .word aOutputbufferNu
_020A7E24: .word aGpibufferC
_020A7E28: .word aOutOfMemory_1
	arm_func_end sub_20A7D90

	arm_func_start sub_20A7E2C
sub_20A7E2C: // 0x020A7E2C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r10, r0
	movs r9, r1
	ldr r8, [r10, #0]
	beq _020A7ED0
	ldr r7, [r8, #0x438]
	ldr r6, [r8, #0x43c]
	mov r5, #0
	str r5, [r8, #0x438]
	mov r1, r7
	str r5, [r8, #0x43c]
	cmp r7, #0
	beq _020A7EAC
_020A7E60:
	ldr r0, [r1, #0x10]
	ldr r4, [r1, #0x14]
	cmp r0, r9
	beq _020A7E7C
	ldr r0, [r1, #0xc]
	cmp r0, #1
	bne _020A7E9C
_020A7E7C:
	mov r0, r10
	cmp r5, #0
	strne r4, [r5, #0x14]
	moveq r7, r4
	cmp r6, r1
	moveq r6, r5
	bl sub_20A7F1C
	b _020A7EA0
_020A7E9C:
	mov r5, r1
_020A7EA0:
	mov r1, r4
	cmp r4, #0
	bne _020A7E60
_020A7EAC:
	ldr r0, [r8, #0x438]
	cmp r0, #0
	ldrne r0, [r8, #0x43c]
	strne r7, [r0, #0x14]
	strne r6, [r8, #0x43c]
	streq r7, [r8, #0x438]
	streq r6, [r8, #0x43c]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020A7ED0:
	ldr r1, [r8, #0x438]
	cmp r1, #0
	beq _020A7F14
	mov r4, #0
_020A7EE0:
	str r4, [r8, #0x438]
	str r4, [r8, #0x43c]
	cmp r1, #0
	beq _020A7F08
_020A7EF0:
	ldr r5, [r1, #0x14]
	mov r0, r10
	bl sub_20A7F1C
	mov r1, r5
	cmp r5, #0
	bne _020A7EF0
_020A7F08:
	ldr r1, [r8, #0x438]
	cmp r1, #0
	bne _020A7EE0
_020A7F14:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	arm_func_end sub_20A7E2C

	arm_func_start sub_20A7F1C
sub_20A7F1C: // 0x020A7F1C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r7, r1
	ldr r1, [r7, #0]
	mov r4, r0
	cmp r1, #0
	bne _020A7F48
	ldr r0, _020A8104 // =aDataCallbackCa
	ldr r1, _020A8108 // =aGpicallbackC
	mov r2, #0
	mov r3, #0x6e
	bl __msl_assertion_failed
_020A7F48:
	ldr r0, [r7, #8]
	cmp r0, #0
	bne _020A7F68
	ldr r0, _020A810C // =aDataArgNull
	ldr r1, _020A8108 // =aGpicallbackC
	mov r2, #0
	mov r3, #0x6f
	bl __msl_assertion_failed
_020A7F68:
	ldr r1, [r7, #8]
	ldr r2, [r7, #4]
	ldr r3, [r7, #0]
	mov r0, r4
	blx r3
	ldr r0, [r7, #0xc]
	cmp r0, #2
	bne _020A7FA4
	ldr r0, [r7, #8]
	ldr r0, [r0, #8]
	bl DWCi_GsFree
	ldr r0, [r7, #8]
	mov r1, #0
	str r1, [r0, #8]
	b _020A80E8
_020A7FA4:
	cmp r0, #3
	bne _020A8024
	ldr r5, [r7, #8]
	mov r6, #0
	ldr r0, [r5, #0x38]
	cmp r0, #0
	ble _020A8000
	mov r4, r6
	mov r8, r6
_020A7FC8:
	ldr r0, [r5, #0x3c]
	ldr r0, [r0, r6, lsl #2]
	bl DWCi_GsFree
	ldr r0, [r5, #0x3c]
	str r4, [r0, r6, lsl #2]
	ldr r0, [r5, #0x40]
	ldr r0, [r0, r6, lsl #2]
	bl DWCi_GsFree
	ldr r0, [r5, #0x40]
	str r8, [r0, r6, lsl #2]
	ldr r0, [r5, #0x38]
	add r6, r6, #1
	cmp r6, r0
	blt _020A7FC8
_020A8000:
	ldr r0, [r5, #0x3c]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r5, #0x3c]
	ldr r0, [r5, #0x40]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r5, #0x40]
	b _020A80E8
_020A8024:
	cmp r0, #4
	bne _020A8044
	ldr r4, [r7, #8]
	ldr r0, [r4, #0xc]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0xc]
	b _020A80E8
_020A8044:
	cmp r0, #7
	bne _020A806C
	ldr r4, [r7, #8]
	ldr r0, [r4, #0x10]
	cmp r0, #0
	beq _020A80E8
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x10]
	b _020A80E8
_020A806C:
	cmp r0, #8
	bne _020A8094
	ldr r4, [r7, #8]
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _020A80E8
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #8]
	b _020A80E8
_020A8094:
	cmp r0, #9
	bne _020A80E8
	ldr r4, [r7, #8]
	mov r5, #0
	ldr r0, [r4, #4]
	cmp r0, #0
	ble _020A80D8
	mov r6, r5
_020A80B4:
	ldr r0, [r4, #8]
	ldr r0, [r0, r5, lsl #2]
	bl DWCi_GsFree
	ldr r0, [r4, #8]
	str r6, [r0, r5, lsl #2]
	ldr r0, [r4, #4]
	add r5, r5, #1
	cmp r5, r0
	blt _020A80B4
_020A80D8:
	ldr r0, [r4, #8]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #8]
_020A80E8:
	ldr r0, [r7, #8]
	bl DWCi_GsFree
	mov r1, #0
	mov r0, r7
	str r1, [r7, #8]
	bl DWCi_GsFree
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020A8104: .word aDataCallbackCa
_020A8108: .word aGpicallbackC
_020A810C: .word aDataArgNull
	arm_func_end sub_20A7F1C

	arm_func_start sub_20A8110
sub_20A8110: // 0x020A8110
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r0, #0x18
	mov r5, r3
	ldr r4, [r6, #0]
	bl DWCi_GsMalloc
	cmp r0, #0
	bne _020A8150
	ldr r1, _020A81B8 // =aOutOfMemory_2
	mov r0, r6
	bl sub_20AFBA8
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
_020A8150:
	ldr r3, [sp, #0x14]
	ldr r2, [sp, #0x18]
	ldr r1, [sp, #0x20]
	str r3, [r0]
	str r2, [r0, #4]
	str r5, [r0, #8]
	cmp r1, #0
	ldrne r1, [r1, #0x18]
	ldr r2, [sp, #0x24]
	strne r1, [r0, #0x10]
	moveq r1, #0
	streq r1, [r0, #0x10]
	mov r1, #0
	str r2, [r0, #0xc]
	str r1, [r0, #0x14]
	ldr r1, [r4, #0x438]
	cmp r1, #0
	streq r0, [r4, #0x438]
	ldr r1, [r4, #0x43c]
	cmp r1, #0
	strne r0, [r1, #0x14]
	str r0, [r4, #0x43c]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
	.align 2, 0
_020A81B8: .word aOutOfMemory_2
	arm_func_end sub_20A8110

	arm_func_start sub_20A81BC
sub_20A81BC: // 0x020A81BC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r4, r0
	ldr r5, [r4, #0]
	mov r7, r1
	mov r6, r2
	cmp r5, #0
	bne _020A81F0
	ldr r0, _020A82A0 // =aIconnectionNul
	ldr r1, _020A82A4 // =aGpicallbackC
	mov r2, #0
	mov r3, #0x23
	bl __msl_assertion_failed
_020A81F0:
	cmp r7, #0
	bne _020A820C
	ldr r0, _020A82A8 // =aResultGpNoErro
	ldr r1, _020A82A4 // =aGpicallbackC
	mov r2, #0
	mov r3, #0x24
	bl __msl_assertion_failed
_020A820C:
	cmp r6, #1
	beq _020A8230
	cmp r6, #0
	beq _020A8230
	ldr r0, _020A82AC // =aFatalGpFatalFa
	ldr r1, _020A82A4 // =aGpicallbackC
	mov r2, #0
	mov r3, #0x25
	bl __msl_assertion_failed
_020A8230:
	cmp r6, #1
	moveq r0, #1
	streq r0, [r5, #0x41c]
	ldr r1, [r5, #0x1a4]
	ldr r0, [r5, #0x1a8]
	cmp r1, #0
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	addeq sp, sp, #0x14
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, #0x10
	bl DWCi_GsMalloc
	movs r3, r0
	strne r7, [r3]
	strne r6, [r3, #0xc]
	ldrne r0, [r5, #0x418]
	add r1, sp, #8
	strne r0, [r3, #4]
	strne r5, [r3, #8]
	mov r0, #0
	str r0, [sp]
	mov r0, #1
	str r0, [sp, #4]
	mov r0, r4
	ldmia r1, {r1, r2}
	bl sub_20A8110
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A82A0: .word aIconnectionNul
_020A82A4: .word aGpicallbackC
_020A82A8: .word aResultGpNoErro
_020A82AC: .word aFatalGpFatalFa
	arm_func_end sub_20A81BC

	arm_func_start sub_20A82B0
sub_20A82B0: // 0x020A82B0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r5, r0
	ldr r4, [r5, #0]
	ldr r2, [r4, #0x1d8]
	cmp r2, #4
	addeq sp, sp, #0x10
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r2, #0
	beq _020A839C
	cmp r1, #0
	beq _020A8314
	cmp r2, #3
	bne _020A8314
	ldr r2, _020A8464 // =aLogoutSesskey
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x198]
	mov r0, r5
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A8468 // =aFinal_2
	mov r0, r5
	add r1, r4, #0x1f4
	bl sub_20A7C58
_020A8314:
	mov r1, #1
	ldr r0, _020A846C // =_0211D688
	str r1, [sp]
	str r0, [sp, #4]
	ldr r1, [r4, #0x1d4]
	add r3, sp, #8
	mov r0, r5
	add r2, r4, #0x1f4
	bl sub_20A7568
	ldr r0, [r4, #0x1d4]
	mvn r1, #0
	cmp r0, r1
	beq _020A8360
	mov r1, #2
	bl sub_20A07C8
	ldr r0, [r4, #0x1d4]
	bl sub_20A07E4
	mvn r0, #0
	str r0, [r4, #0x1d4]
_020A8360:
	ldr r0, [r4, #0x204]
	mvn r1, #0
	cmp r0, r1
	beq _020A8388
	mov r1, #2
	bl sub_20A07C8
	ldr r0, [r4, #0x204]
	bl sub_20A07E4
	mvn r0, #0
	str r0, [r4, #0x204]
_020A8388:
	mov r0, #4
	str r0, [r4, #0x1d8]
	mov r0, #0
	str r0, [r4, #0x19c]
	str r0, [r4, #0x1a0]
_020A839C:
	ldr r0, [r4, #0x1dc]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x1dc]
	ldr r0, [r4, #0x1ec]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x1ec]
	ldr r0, [r4, #0x1f4]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x1f4]
	ldr r0, [r4, #0x440]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x440]
	ldr r0, [r4, #0x450]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x450]
	ldr r1, [r4, #0x424]
	cmp r1, #0
	beq _020A840C
_020A83F8:
	mov r0, r5
	bl sub_20AB940
	ldr r1, [r4, #0x424]
	cmp r1, #0
	bne _020A83F8
_020A840C:
	mov r0, #0
	str r0, [r4, #0x424]
	ldr r6, [r4, #0x434]
	cmp r6, #0
	beq _020A8438
_020A8420:
	mov r1, r6
	ldr r6, [r6, #0x3c]
	mov r0, r5
	bl sub_20AC69C
	cmp r6, #0
	bne _020A8420
_020A8438:
	mov r6, #0
	str r6, [r4, #0x434]
	ldr r4, _020A8470 // =sub_20A8474
_020A8444:
	mov r0, r5
	mov r1, r4
	mov r2, r6
	bl sub_20AD148
	cmp r0, #0
	beq _020A8444
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A8464: .word aLogoutSesskey
_020A8468: .word aFinal_2
_020A846C: .word _0211D688
_020A8470: .word sub_20A8474
	arm_func_end sub_20A82B0

	arm_func_start sub_20A8474
sub_20A8474: // 0x020A8474
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldr r1, [r5, #8]
	mov r6, r0
	cmp r1, #0
	ldr r4, [r6, #0]
	beq _020A84D8
	ldr r0, [r4, #0x104]
	cmp r0, #0
	bne _020A84D8
	ldr r0, [r1, #8]
	bl DWCi_GsFree
	ldr r0, [r5, #8]
	mov r1, #0
	str r1, [r0, #8]
	ldr r0, [r5, #8]
	ldr r0, [r0, #0xc]
	bl DWCi_GsFree
	ldr r0, [r5, #8]
	mov r1, #0
	str r1, [r0, #0xc]
	ldr r0, [r5, #8]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r5, #8]
_020A84D8:
	ldr r0, [r5, #0x10]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r5, #0x10]
	ldr r0, [r5, #0x18]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r5, #0x18]
	str r0, [r5, #0x14]
	ldr r0, [r5, #0xc]
	cmp r0, #0
	beq _020A8520
	ldr r0, [r4, #0x104]
	cmp r0, #1
	bne _020A8534
	ldr r0, [r5, #8]
	cmp r0, #0
	bne _020A8534
_020A8520:
	mov r0, r6
	mov r1, r5
	bl sub_20AD25C
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020A8534:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20A8474

	arm_func_start sub_20A853C
sub_20A853C: // 0x020A853C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r4, [r5, #0]
	add r2, sp, #0
	ldr r1, [r4, #0x1d4]
	bl sub_20AFDB8
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	ldr r0, [sp]
	cmp r0, #4
	bne _020A859C
	ldr r1, _020A85DC // =0x00000107
	ldr r2, _020A85E0 // =aTheServerHasRe
	mov r0, r5
	bl sub_20AFBBC
	mov r0, r5
	mov r1, #4
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #4
	mov r0, #4
	ldmia sp!, {r4, r5, pc}
_020A859C:
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	cmp r0, #3
	beq _020A85C8
	ldr r0, _020A85E4 // =aStateGpiConnec
	ldr r1, _020A85E8 // =aGpiconnectC
	ldr r3, _020A85EC // =0x000002EF
	mov r2, #0
	bl __msl_assertion_failed
_020A85C8:
	mov r0, #2
	str r0, [r4, #0x1d8]
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020A85DC: .word 0x00000107
_020A85E0: .word aTheServerHasRe
_020A85E4: .word aStateGpiConnec
_020A85E8: .word aGpiconnectC
_020A85EC: .word 0x000002EF
	arm_func_end sub_20A853C

	arm_func_start sub_20A85F0
sub_20A85F0: // 0x020A85F0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x2a0
	mov r6, r2
	mov r8, r0
	mov r7, r1
	mov r1, r6
	mov r2, #0
	ldr r5, [r8, #0]
	bl sub_20AFFB4
	cmp r0, #0
	beq _020A86F0
	ldr r2, [r5, #0x418]
	ldr r0, _020A8C7C // =0x00000106
	cmp r2, r0
	bne _020A8650
	ldr r1, [r5, #0x1a0]
	cmp r1, #0
	beq _020A8650
	mov r0, r8
	bl sub_20AD270
	mov r0, #0
	str r0, [r5, #0x19c]
	str r0, [r5, #0x1a0]
	b _020A8684
_020A8650:
	ldr r0, _020A8C80 // =0x00000201
	cmp r2, r0
	bne _020A8684
	ldr r1, _020A8C84 // =aPid_0
	add r2, sp, #0x4e
	mov r0, r6
	mov r3, #0x200
	bl sub_20AFEAC
	cmp r0, #0
	beq _020A8684
	add r0, sp, #0x4e
	bl atoi
	str r0, [r5, #0x1a0]
_020A8684:
	ldr r1, _020A8C88 // =aFatal
	mov r0, r6
	bl strstr
	cmp r0, #0
	beq _020A86C4
	ldr r1, [r5, #0x418]
	mov r0, r8
	mov r2, r5
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #4
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A86C4:
	ldr r1, [r5, #0x418]
	mov r0, r8
	mov r2, r5
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #4
	mov r2, #0
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A86F0:
	ldr r0, [r7, #0x14]
	ldr r4, [r7, #4]
	cmp r0, #1
	beq _020A8714
	cmp r0, #2
	beq _020A8904
	cmp r0, #3
	beq _020A87F4
	b _020A8C70
_020A8714:
	ldr r1, _020A8C8C // =aLc1
	mov r0, r6
	mov r2, #5
	bl strncmp
	cmp r0, #0
	beq _020A8758
	ldr r2, _020A8C90 // =aUnexpectedData_0
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A8758:
	ldr r1, _020A8C94 // =aChallenge_0
	mov r0, r6
	mov r2, r4
	mov r3, #0x80
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A87A0
	ldr r2, _020A8C90 // =aUnexpectedData_0
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A87A0:
	ldr r0, [r4, #0x304]
	cmp r0, #0
	beq _020A87D0
	mov r0, r8
	mov r1, r4
	bl sub_20A8CD8
	cmp r0, #0
	addne sp, sp, #0x2a0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #3
	str r0, [r7, #0x14]
	b _020A8C70
_020A87D0:
	mov r0, r8
	mov r1, r4
	bl sub_20A8F74
	cmp r0, #0
	addne sp, sp, #0x2a0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #2
	str r0, [r7, #0x14]
	b _020A8C70
_020A87F4:
	ldr r1, _020A8C98 // =aNur
	mov r0, r6
	mov r2, #5
	bl strncmp
	cmp r0, #0
	beq _020A8838
	ldr r2, _020A8C90 // =aUnexpectedData_0
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A8838:
	ldr r1, _020A8C9C // =aUserid_0
	add r2, sp, #0x4e
	mov r0, r6
	mov r3, #0x200
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A8880
	ldr r2, _020A8CA0 // =aUnexepectedDat
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A8880:
	add r0, sp, #0x4e
	bl atoi
	str r0, [r5, #0x19c]
	ldr r1, _020A8CA4 // =aProfileid
	add r2, sp, #0x4e
	mov r0, r6
	mov r3, #0x200
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A88D4
	ldr r2, _020A8CA0 // =aUnexepectedDat
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A88D4:
	add r0, sp, #0x4e
	bl atoi
	str r0, [r5, #0x1a0]
	mov r0, r8
	mov r1, r4
	bl sub_20A8F74
	cmp r0, #0
	addne sp, sp, #0x2a0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, #2
	str r0, [r7, #0x14]
	b _020A8C70
_020A8904:
	ldr r1, _020A8CA8 // =aLc2
	mov r0, r6
	mov r2, #5
	bl strncmp
	cmp r0, #0
	beq _020A8948
	ldr r2, _020A8C90 // =aUnexpectedData_0
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A8948:
	ldr r1, _020A8CAC // =aSesskey_1
	add r2, sp, #0x4e
	mov r0, r6
	mov r3, #0x200
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A8990
	ldr r2, _020A8CA0 // =aUnexepectedDat
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A8990:
	add r0, sp, #0x4e
	bl atoi
	str r0, [r5, #0x198]
	ldr r1, _020A8C9C // =aUserid_0
	add r2, sp, #0x4e
	mov r0, r6
	mov r3, #0x200
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A89E4
	ldr r2, _020A8CA0 // =aUnexepectedDat
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A89E4:
	add r0, sp, #0x4e
	bl atoi
	str r0, [r5, #0x19c]
	ldr r1, _020A8CA4 // =aProfileid
	add r2, sp, #0x4e
	mov r0, r6
	mov r3, #0x200
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A8A38
	ldr r2, _020A8CA0 // =aUnexepectedDat
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A8A38:
	add r0, sp, #0x4e
	bl atoi
	str r0, [r5, #0x1a0]
	ldr r1, _020A8CB0 // =aUniquenick
	add r2, sp, #0x39
	mov r0, r6
	mov r3, #0x15
	bl sub_20AFEAC
	ldr r2, _020A8CB4 // =0x00000474
	cmp r0, #0
	moveq r0, #0
	streqb r0, [sp, #0x39]
	ldr r1, _020A8CB8 // =0x0211D7A4
	mov r0, r6
	add r2, r5, r2
	mov r3, #0x19
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streqb r0, [r5, #0x474]
	ldrsb r0, [r4, #0xc2]
	cmp r0, #0
	addne r0, r4, #0xc2
	bne _020A8AD0
	add r0, r5, #0x100
	ldrsb r0, [r0, #0x2f]
	cmp r0, #0
	ldrne r0, _020A8CBC // =0x0000012F
	addne r0, r5, r0
	bne _020A8AD0
	add r0, sp, #0x200
	ldr r1, _020A8CC0 // =aSS_0
	add r0, r0, #0x4e
	add r2, r5, #0x110
	add r3, r5, #0x144
	bl sprintf
	add r0, sp, #0x200
	add r0, r0, #0x4e
_020A8AD0:
	str r0, [sp]
	str r4, [sp, #4]
	add r2, r4, #0x80
	str r2, [sp, #8]
	add r2, r4, #0xa1
	ldr r1, _020A8CC4 // =aSSSSSS
	ldr r3, _020A8CC8 // =asc_211D7C4
	add r0, sp, #0x4e
	str r2, [sp, #0xc]
	bl sprintf
	add r0, sp, #0x4e
	bl strlen
	mov r1, r0
	add r0, sp, #0x4e
	add r2, sp, #0x18
	bl sub_20A01DC
	ldr r1, _020A8CCC // =aProof
	mov r0, r6
	add r2, sp, #0x4e
	mov r3, #0x200
	bl sub_20AFEAC
	cmp r0, #0
	bne _020A8B58
	ldr r2, _020A8CA0 // =aUnexepectedDat
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A8B58:
	add r0, sp, #0x18
	add r1, sp, #0x4e
	mov r2, #0x20
	bl memcmp
	cmp r0, #0
	beq _020A8B9C
	ldr r2, _020A8CD0 // =aCouldNotAuthen
	mov r0, r8
	mov r1, #0x108
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x2a0
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A8B9C:
	ldr r0, [r5, #0x100]
	cmp r0, #0
	beq _020A8BC4
	ldr r1, [r5, #0x1a0]
	mov r0, r8
	bl sub_20AD2E0
	ldr r1, [r5, #0x1a0]
	str r1, [r0]
	ldr r1, [r5, #0x19c]
	str r1, [r0, #4]
_020A8BC4:
	mov r0, #3
	str r0, [r5, #0x1d8]
	ldr r1, [r7, #0xc]
	ldr r0, [r7, #0x10]
	cmp r1, #0
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	beq _020A8C64
	mov r0, #0x20
	bl DWCi_GsMalloc
	movs r4, r0
	bne _020A8C0C
	ldr r1, _020A8CD4 // =aOutOfMemory_3
	mov r0, r8
	bl sub_20AFBA8
	add sp, sp, #0x2a0
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A8C0C:
	mov r1, #0
	mov r2, #0x20
	bl memset
	ldr r1, [r5, #0x1a0]
	mov r0, #0
	str r1, [r4, #4]
	str r0, [r4]
	add r1, sp, #0x39
	add r0, r4, #8
	mov r2, #0x15
	bl sub_20B0098
	str r7, [sp]
	mov r0, #0
	str r0, [sp, #4]
	add r1, sp, #0x10
	mov r0, r8
	mov r3, r4
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	addne sp, sp, #0x2a0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_020A8C64:
	mov r0, r8
	mov r1, r7
	bl sub_20AB940
_020A8C70:
	mov r0, #0
	add sp, sp, #0x2a0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020A8C7C: .word 0x00000106
_020A8C80: .word 0x00000201
_020A8C84: .word aPid_0
_020A8C88: .word aFatal
_020A8C8C: .word aLc1
_020A8C90: .word aUnexpectedData_0
_020A8C94: .word aChallenge_0
_020A8C98: .word aNur
_020A8C9C: .word aUserid_0
_020A8CA0: .word aUnexepectedDat
_020A8CA4: .word aProfileid
_020A8CA8: .word aLc2
_020A8CAC: .word aSesskey_1
_020A8CB0: .word aUniquenick
_020A8CB4: .word 0x00000474
_020A8CB8: .word 0x0211D7A4
_020A8CBC: .word 0x0000012F
_020A8CC0: .word aSS_0
_020A8CC4: .word aSSSSSS
_020A8CC8: .word asc_211D7C4
_020A8CCC: .word aProof
_020A8CD0: .word aCouldNotAuthen
_020A8CD4: .word aOutOfMemory_3
	arm_func_end sub_20A85F0

	arm_func_start sub_20A8CD8
sub_20A8CD8: // 0x020A8CD8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xec
	mov r11, r0
	ldr r4, [r11, #0]
	ldr r0, _020A8F34 // =0x00000177
	mov r5, r1
	add r0, r4, r0
	bl strlen
	mov r9, r0
	ldr r0, _020A8F38 // =0x79707367
	bl sub_20A0474
	cmp r9, #0
	mov r10, #0
	bls _020A8D4C
	add r8, sp, #0
	mov r7, r10
	mov r6, #0xff
_020A8D1C:
	mov r0, r7
	mov r1, r6
	bl sub_20A0444
	add r1, r4, r10
	add r1, r1, #0x100
	add r10, r10, #1
	ldrsb r1, [r1, #0x77]
	mov r0, r0, lsl #0x18
	cmp r10, r9
	eor r0, r1, r0, asr #24
	strb r0, [r8], #1
	blo _020A8D1C
_020A8D4C:
	add r0, sp, #0
	mov r6, #0
	add r1, sp, #0x1f
	mov r2, r9
	mov r3, #1
	strb r6, [r0, r10]
	bl sub_20A0268
	ldr r2, _020A8F3C // =aNewuser
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, _020A8F40 // =aEmail
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r11
	add r1, r4, #0x1f4
	add r2, r4, #0x144
	bl sub_20A7C58
	ldr r2, _020A8F44 // =aNick
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r11
	add r1, r4, #0x1f4
	add r2, r4, #0x110
	bl sub_20A7C58
	ldr r2, _020A8F48 // =aPasswordenc
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r11
	add r1, r4, #0x1f4
	add r2, sp, #0x1f
	bl sub_20A7C58
	ldr r2, _020A8F4C // =aProductid
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x46c]
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A8F50 // =aGamename
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, _020A8F54 // =0x02144D64
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, _020A8F58 // =aNamespaceid
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x470]
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A8F5C // =aUniquenick
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, _020A8F60 // =0x0000012F
	mov r0, r11
	add r1, r4, #0x1f4
	add r2, r4, r2
	bl sub_20A7C58
	add r0, r5, #0x200
	ldrsb r0, [r0, #0xc2]
	cmp r0, #0
	beq _020A8F08
	ldr r0, _020A8F64 // =0x000002C2
	add r0, r5, r0
	bl strlen
	mov r10, r0
	ldr r0, _020A8F38 // =0x79707367
	bl sub_20A0474
	cmp r10, #0
	mov r8, r6
	bls _020A8ECC
	add r9, sp, #0x4c
	mov r7, r8
	mov r6, #0xff
_020A8E9C:
	mov r0, r7
	mov r1, r6
	bl sub_20A0444
	add r1, r5, r8
	add r1, r1, #0x200
	add r8, r8, #1
	ldrsb r1, [r1, #0xc2]
	mov r0, r0, lsl #0x18
	cmp r8, r10
	eor r0, r1, r0, asr #24
	strb r0, [r9], #1
	blo _020A8E9C
_020A8ECC:
	add r0, sp, #0x4c
	mov r5, #0
	add r1, sp, #0x8d
	mov r2, r10
	mov r3, #1
	strb r5, [r0, r8]
	bl sub_20A0268
	ldr r2, _020A8F68 // =aCdkeyenc
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	add r2, sp, #0x8d
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
_020A8F08:
	ldr r2, _020A8F6C // =aId1
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, _020A8F70 // =aFinal_2
	mov r0, r11
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, #0
	add sp, sp, #0xec
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020A8F34: .word 0x00000177
_020A8F38: .word 0x79707367
_020A8F3C: .word aNewuser
_020A8F40: .word aEmail
_020A8F44: .word aNick
_020A8F48: .word aPasswordenc
_020A8F4C: .word aProductid
_020A8F50: .word aGamename
_020A8F54: .word 0x02144D64
_020A8F58: .word aNamespaceid
_020A8F5C: .word aUniquenick
_020A8F60: .word 0x0000012F
_020A8F64: .word 0x000002C2
_020A8F68: .word aCdkeyenc
_020A8F6C: .word aId1
_020A8F70: .word aFinal_2
	arm_func_end sub_20A8CD8

	arm_func_start sub_20A8F74
sub_20A8F74: // 0x020A8F74
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x28c
	mov r5, r1
	mov r6, r0
	add r0, r5, #0x80
	mov r1, #0x20
	ldr r4, [r6, #0]
	bl sub_20A9904
	add r0, r5, #0x100
	ldrsb r0, [r0, #0xc2]
	cmp r0, #0
	ldrne r0, _020A92D0 // =0x000001C2
	addne r7, r5, r0
	ldreq r0, _020A92D4 // =0x00000177
	addeq r7, r4, r0
	mov r0, r7
	bl strlen
	mov r1, r0
	mov r0, r7
	add r2, r5, #0xa1
	bl sub_20A01DC
	ldrsb r0, [r5, #0xc2]
	cmp r0, #0
	addne r0, r5, #0xc2
	bne _020A9010
	add r0, r4, #0x100
	ldrsb r0, [r0, #0x2f]
	cmp r0, #0
	ldrne r0, _020A92D8 // =0x0000012F
	addne r0, r4, r0
	bne _020A9010
	add r0, sp, #0x200
	ldr r1, _020A92DC // =aSS_0
	add r0, r0, #0x35
	add r2, r4, #0x110
	add r3, r4, #0x144
	bl sprintf
	add r0, sp, #0x200
	add r0, r0, #0x35
_020A9010:
	str r0, [sp]
	add r0, r5, #0x80
	str r0, [sp, #4]
	ldr r1, _020A92E0 // =aSSSSSS
	ldr r3, _020A92E4 // =asc_211D7C4
	add r0, sp, #0x35
	str r5, [sp, #8]
	add r2, r5, #0xa1
	str r2, [sp, #0xc]
	bl sprintf
	add r0, sp, #0x35
	bl strlen
	mov r1, r0
	add r0, sp, #0x35
	add r2, sp, #0x14
	bl sub_20A01DC
	ldr r0, [r4, #0x100]
	cmp r0, #0
	beq _020A908C
	add r3, sp, #0x10
	mov r0, r6
	add r1, r4, #0x110
	add r2, r4, #0x144
	bl sub_20AD1B0
	ldr r0, [sp, #0x10]
	cmp r0, #0
	ldrne r0, [r0, #4]
	strne r0, [r4, #0x19c]
	ldrne r0, [sp, #0x10]
	ldrne r0, [r0, #0]
	strne r0, [r4, #0x1a0]
_020A908C:
	ldr r2, _020A92E8 // =aLogin_0
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, _020A92EC // =aChallenge_0
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	add r2, r5, #0x80
	bl sub_20A7C58
	ldrsb r0, [r5, #0xc2]
	cmp r0, #0
	beq _020A90EC
	ldr r2, _020A92F0 // =aAuthtoken
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	add r2, r5, #0xc2
	bl sub_20A7C58
	b _020A9164
_020A90EC:
	add r0, r4, #0x100
	ldrsb r0, [r0, #0x2f]
	cmp r0, #0
	beq _020A9124
	ldr r2, _020A92F4 // =aUniquenick
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, _020A92D8 // =0x0000012F
	mov r0, r6
	add r1, r4, #0x1f4
	add r2, r4, r2
	bl sub_20A7C58
	b _020A9164
_020A9124:
	ldr r2, _020A92F8 // =aUser
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	add r2, r4, #0x110
	bl sub_20A7C58
	ldr r2, _020A92FC // =0x0211D8B4
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	add r2, r4, #0x144
	bl sub_20A7C58
_020A9164:
	ldr r0, [r4, #0x19c]
	cmp r0, #0
	beq _020A9190
	ldr r2, _020A9300 // =aUserid_0
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x19c]
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C20
_020A9190:
	ldr r0, [r4, #0x1a0]
	cmp r0, #0
	beq _020A91BC
	ldr r2, _020A9304 // =aProfileid
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x1a0]
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C20
_020A91BC:
	ldr r2, _020A9308 // =aResponse
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	add r2, sp, #0x14
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r0, [r4, #0x10c]
	cmp r0, #1
	bne _020A91F8
	ldr r2, _020A930C // =aFirewall1
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
_020A91F8:
	ldr r2, _020A9310 // =aPort
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r1, [r4, #0x208]
	mov r0, r6
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, asr #8
	mov r1, r1, lsl #8
	and r2, r2, #0xff
	and r1, r1, #0xff00
	orr r1, r2, r1
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r2, r1, lsl #0x10
	add r1, r4, #0x1f4
	mov r2, r2, asr #0x10
	bl sub_20A7C20
	ldr r2, _020A9314 // =aProductid
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x46c]
	mov r0, r6
	add r1, r4, #0x1f4
	bl sub_20A7C20
	mov r0, r6
	add r1, r4, #0x1f4
	ldr r2, _020A9318 // =aGamename
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	ldr r2, _020A931C // =0x02144D64
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	ldr r2, _020A9320 // =aNamespaceid
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	ldr r2, [r4, #0x470]
	bl sub_20A7C20
	mov r0, r6
	add r1, r4, #0x1f4
	ldr r2, _020A9324 // =aId1
	bl sub_20A7C58
	mov r0, r6
	add r1, r4, #0x1f4
	ldr r2, _020A9328 // =aFinal_2
	bl sub_20A7C58
	mov r0, #0
	add sp, sp, #0x28c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A92D0: .word 0x000001C2
_020A92D4: .word 0x00000177
_020A92D8: .word 0x0000012F
_020A92DC: .word aSS_0
_020A92E0: .word aSSSSSS
_020A92E4: .word asc_211D7C4
_020A92E8: .word aLogin_0
_020A92EC: .word aChallenge_0
_020A92F0: .word aAuthtoken
_020A92F4: .word aUniquenick
_020A92F8: .word aUser
_020A92FC: .word 0x0211D8B4
_020A9300: .word aUserid_0
_020A9304: .word aProfileid
_020A9308: .word aResponse
_020A930C: .word aFirewall1
_020A9310: .word aPort
_020A9314: .word aProductid
_020A9318: .word aGamename
_020A931C: .word 0x02144D64
_020A9320: .word aNamespaceid
_020A9324: .word aId1
_020A9328: .word aFinal_2
	arm_func_end sub_20A8F74

	arm_func_start sub_20A932C
sub_20A932C: // 0x020A932C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r8, r0
	ldr r4, [r8, #0]
	mov r7, r1
	ldr r1, [r4, #0x1d8]
	mov r6, r2
	mov r5, r3
	cmp r1, #4
	bne _020A9364
	bl sub_20A617C
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_020A9364:
	ldr r0, [r4, #0x1d8]
	cmp r0, #0
	beq _020A9388
	ldr r1, _020A9568 // =aInvalidConnect
	mov r0, r8
	bl sub_20AFBA8
	add sp, sp, #0x10
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A9388:
	ldr r0, [sp, #0x38]
	cmp r0, #0
	beq _020A93A8
	cmp r0, #1
	bne _020A93B4
	mov r0, #1
	str r0, [r4, #0x10c]
	b _020A93CC
_020A93A8:
	mov r0, #0
	str r0, [r4, #0x10c]
	b _020A93CC
_020A93B4:
	ldr r1, _020A956C // =aInvalidFirewal
	mov r0, r8
	bl sub_20AFBA8
	add sp, sp, #0x10
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A93CC:
	mov r3, #1
	mov r1, r7
	add r0, r4, #0x110
	mov r2, #0x1f
	str r3, [r4, #0x10c]
	bl sub_20B0098
	ldr r0, _020A9570 // =0x0000012F
	mov r1, r6
	add r0, r4, r0
	mov r2, #0x15
	bl sub_20B0098
	mov r1, r5
	add r0, r4, #0x144
	mov r2, #0x33
	bl sub_20B0098
	ldr r0, _020A9574 // =0x00000177
	ldr r1, [sp, #0x28]
	add r0, r4, r0
	mov r2, #0x1f
	bl sub_20B0098
	add r0, r4, #0x144
	bl sub_20A0C0C
	mov r0, #0x308
	bl DWCi_GsMalloc
	movs r4, r0
	bne _020A944C
	ldr r1, _020A9578 // =aOutOfMemory_3
	mov r0, r8
	bl sub_20AFBA8
	add sp, sp, #0x10
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A944C:
	mov r1, #0
	mov r2, #0x308
	bl memset
	ldr r0, [sp, #0x3c]
	ldr r1, [sp, #0x2c]
	str r0, [r4, #0x304]
	ldrsb r0, [r1, #0]
	cmp r0, #0
	beq _020A94A0
	ldr r0, [sp, #0x30]
	ldrsb r0, [r0, #0]
	cmp r0, #0
	beq _020A94A0
	add r0, r4, #0xc2
	mov r2, #0x100
	bl sub_20B0098
	ldr r0, _020A957C // =0x000001C2
	ldr r1, [sp, #0x30]
	add r0, r4, r0
	mov r2, #0x100
	bl sub_20B0098
_020A94A0:
	ldr r1, [sp, #0x34]
	cmp r1, #0
	beq _020A94BC
	ldr r0, _020A9580 // =0x000002C2
	mov r2, #0x41
	add r0, r4, r0
	bl sub_20B0098
_020A94BC:
	ldr r1, [sp, #0x40]
	ldr r0, [sp, #0x44]
	str r1, [sp]
	str r0, [sp, #4]
	ldr r5, [sp, #0x48]
	add r3, sp, #0xc
	mov r0, r8
	mov r2, r4
	mov r1, #0
	str r5, [sp, #8]
	bl sub_20ABA48
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [sp, #0xc]
	mov r0, r8
	bl sub_20A9584
	movs r4, r0
	beq _020A9534
	ldr r1, [sp, #0xc]
	mov r0, r8
	str r4, [r1, #0x1c]
	ldr r1, [sp, #0xc]
	bl sub_20ABB00
	mov r0, r8
	mov r1, #0
	bl sub_20A82B0
	add sp, sp, #0x10
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A9534:
	ldr r1, [sp, #0xc]
	ldr r0, [r1, #8]
	cmp r0, #0
	beq _020A955C
	ldr r1, [r1, #0x18]
	mov r0, r8
	bl sub_20A5C9C
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_020A955C:
	mov r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020A9568: .word aInvalidConnect
_020A956C: .word aInvalidFirewal
_020A9570: .word 0x0000012F
_020A9574: .word 0x00000177
_020A9578: .word aOutOfMemory_3
_020A957C: .word 0x000001C2
_020A9580: .word 0x000002C2
	arm_func_end sub_20A932C

	arm_func_start sub_20A9584
sub_20A9584: // 0x020A9584
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r6, r0
	ldr r4, [r6, #0]
	mov r5, r1
	ldr r0, [r4, #0x10c]
	cmp r0, #0
	bne _020A972C
	mov r0, #2
	mov r1, #1
	mov r2, #0
	bl sub_20A0800
	str r0, [r4, #0x204]
	ldr r0, [r4, #0x204]
	mvn r1, #0
	cmp r0, r1
	bne _020A95F4
	ldr r2, _020A98D8 // =aThereWasAnErro_2
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x10
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020A95F4:
	mov r1, #0
	bl sub_20A0BC4
	cmp r0, #0
	bne _020A9630
	ldr r2, _020A98DC // =aThereWasAnErro_3
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x10
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020A9630:
	add r1, sp, #0
	mov r0, #0
	str r0, [r1]
	str r0, [r1, #4]
	mov r0, #2
	strb r0, [sp, #1]
	ldr r0, [r4, #0x204]
	mov r2, #8
	bl sub_20A0770
	mvn r1, #0
	cmp r0, r1
	bne _020A968C
	ldr r2, _020A98E0 // =aThereWasAnErro_4
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x10
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020A968C:
	ldr r0, [r4, #0x204]
	mov r1, #5
	bl sub_20A0710
	mvn r1, #0
	cmp r0, r1
	bne _020A96D0
	ldr r2, _020A98E4 // =aThereWasAnErro_5
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x10
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020A96D0:
	mov r0, #8
	str r0, [sp, #8]
	ldr r0, [r4, #0x204]
	add r1, sp, #0
	add r2, sp, #8
	bl sub_20A05A4
	mvn r1, #0
	cmp r0, r1
	bne _020A9720
	ldr r2, _020A98E8 // =aThereWasAnErro_6
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x10
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020A9720:
	ldrh r0, [sp, #2]
	str r0, [r4, #0x208]
	b _020A973C
_020A972C:
	mvn r0, #0
	str r0, [r4, #0x204]
	mov r0, #0
	str r0, [r4, #0x208]
_020A973C:
	mov r0, #2
	mov r1, #1
	mov r2, #0
	bl sub_20A0800
	str r0, [r4, #0x1d4]
	ldr r0, [r4, #0x1d4]
	mvn r1, #0
	cmp r0, r1
	bne _020A978C
	ldr r2, _020A98D8 // =aThereWasAnErro_2
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x10
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020A978C:
	mov r1, #0
	bl sub_20A0BC4
	cmp r0, #0
	bne _020A97C8
	ldr r2, _020A98DC // =aThereWasAnErro_3
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x10
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020A97C8:
	ldr r0, _020A98EC // =aGpcmGsNintendo
	bl sub_20BE844
	cmp r0, #0
	bne _020A9804
	ldr r2, _020A98F0 // =aCouldNotResolv
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x10
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020A9804:
	add r1, sp, #0
	mov r2, #0
	str r2, [r1]
	str r2, [r1, #4]
	mov r1, #2
	strb r1, [sp, #1]
	ldr r0, [r0, #0xc]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0]
	str r0, [sp, #4]
	cmp r0, #0
	bne _020A9844
	ldr r0, _020A98F4 // =aAddressSinAddr
	ldr r1, _020A98F8 // =aGpiconnectC
	mov r3, #0x90
	bl __msl_assertion_failed
_020A9844:
	ldr r0, _020A98FC // =0x0000CC74
	add r1, sp, #0
	strh r0, [sp, #2]
	ldr r0, [r4, #0x1d4]
	mov r2, #8
	bl sub_20A072C
	mvn r1, #0
	cmp r0, r1
	bne _020A98C0
	ldr r0, [r4, #0x1d4]
	bl WSAGetLastError
	mvn r1, #5
	cmp r0, r1
	beq _020A98C0
	mvn r1, #0x19
	cmp r0, r1
	beq _020A98C0
	mvn r1, #0x4b
	cmp r0, r1
	beq _020A98C0
	ldr r2, _020A9900 // =aThereWasAnErro_7
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x10
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020A98C0:
	mov r0, #1
	str r0, [r5, #0x14]
	str r0, [r4, #0x1d8]
	mov r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020A98D8: .word aThereWasAnErro_2
_020A98DC: .word aThereWasAnErro_3
_020A98E0: .word aThereWasAnErro_4
_020A98E4: .word aThereWasAnErro_5
_020A98E8: .word aThereWasAnErro_6
_020A98EC: .word aGpcmGsNintendo
_020A98F0: .word aCouldNotResolv
_020A98F4: .word aAddressSinAddr
_020A98F8: .word aGpiconnectC
_020A98FC: .word 0x0000CC74
_020A9900: .word aThereWasAnErro_7
	arm_func_end sub_20A9584

	arm_func_start sub_20A9904
sub_20A9904: // 0x020A9904
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r1
	mov r9, r0
	cmp r8, #0
	mov r7, #0
	ble _020A995C
	ldr r6, _020A996C // =aAbcdefghijklmn_0
	ldr r5, _020A9970 // =0x08421085
	ldr r4, _020A9974 // =0x0000003E
_020A992C:
	bl rand
	umull r1, r2, r0, r5
	sub r1, r0, r2
	add r2, r2, r1, lsr #1
	mov r2, r2, lsr #5
	umull r1, r2, r4, r2
	sub r2, r0, r1
	ldrsb r0, [r6, r2]
	strb r0, [r9, r7]
	add r7, r7, #1
	cmp r7, r8
	blt _020A992C
_020A995C:
	mov r0, #0
	strb r0, [r9, r7]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020A996C: .word aAbcdefghijklmn_0
_020A9970: .word 0x08421085
_020A9974: .word 0x0000003E
	arm_func_end sub_20A9904

	arm_func_start sub_20A9978
sub_20A9978: // 0x020A9978
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0xc]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r0, #0]
	bl DWCi_GsFree
	ldr r0, [r4, #0xc]
	mov r1, #0
	str r1, [r0]
	ldr r0, [r4, #0xc]
	ldr r0, [r0, #4]
	bl DWCi_GsFree
	ldr r0, [r4, #0xc]
	mov r1, #0
	str r1, [r0, #4]
	ldr r0, [r4, #0xc]
	ldr r0, [r0, #8]
	bl DWCi_GsFree
	ldr r0, [r4, #0xc]
	mov r1, #0
	str r1, [r0, #8]
	ldr r0, [r4, #0xc]
	ldr r0, [r0, #0xc]
	bl DWCi_GsFree
	ldr r0, [r4, #0xc]
	mov r1, #0
	str r1, [r0, #0xc]
	ldr r0, [r4, #0xc]
	ldr r0, [r0, #0x10]
	bl DWCi_GsFree
	ldr r0, [r4, #0xc]
	mov r1, #0
	str r1, [r0, #0x10]
	ldr r0, [r4, #0xc]
	ldr r0, [r0, #0x14]
	bl DWCi_GsFree
	ldr r0, [r4, #0xc]
	mov r1, #0
	str r1, [r0, #0x14]
	ldr r0, [r4, #0xc]
	ldr r0, [r0, #0xc8]
	bl DWCi_GsFree
	ldr r0, [r4, #0xc]
	mov r1, #0
	str r1, [r0, #0xc8]
	ldr r0, [r4, #0xc]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0xc]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20A9978

	arm_func_start sub_20A9A44
sub_20A9A44: // 0x020A9A44
	stmdb sp!, {r4, r5, r6, lr}
	ldr r0, [r0, #0]
	mov r5, r1
	ldr r0, [r0, #0x100]
	mov r4, r2
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r5
	bl sub_20A9978
	mov r0, #0xf0
	bl DWCi_GsMalloc
	str r0, [r5, #0xc]
	ldr r6, [r5, #0xc]
	cmp r6, #0
	beq _020A9B0C
	mov lr, r4
	mov ip, #0xf
_020A9A8C:
	ldmia lr!, {r0, r1, r2, r3}
	stmia r6!, {r0, r1, r2, r3}
	subs ip, ip, #1
	bne _020A9A8C
	ldr r0, [r4, #0]
	bl sub_20A0C50
	ldr r1, [r5, #0xc]
	str r0, [r1]
	ldr r0, [r4, #4]
	bl sub_20A0C50
	ldr r1, [r5, #0xc]
	str r0, [r1, #4]
	ldr r0, [r4, #8]
	bl sub_20A0C50
	ldr r1, [r5, #0xc]
	str r0, [r1, #8]
	ldr r0, [r4, #0xc]
	bl sub_20A0C50
	ldr r1, [r5, #0xc]
	str r0, [r1, #0xc]
	ldr r0, [r4, #0x10]
	bl sub_20A0C50
	ldr r1, [r5, #0xc]
	str r0, [r1, #0x10]
	ldr r0, [r4, #0x14]
	bl sub_20A0C50
	ldr r1, [r5, #0xc]
	str r0, [r1, #0x14]
	ldr r0, [r4, #0xc8]
	bl sub_20A0C50
	ldr r1, [r5, #0xc]
	str r0, [r1, #0xc8]
_020A9B0C:
	ldr r0, [r5, #0xc]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20A9A44

	arm_func_start sub_20A9B20
sub_20A9B20: // 0x020A9B20
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x20
	mov r8, r0
	ldr r0, [r8, #0]
	mov r4, #0
	str r4, [sp, #0x10]
	ldr r5, [sp, #0x38]
	cmp r2, #1
	ldr r0, [r0, #0x100]
	moveq r4, #1
	cmp r0, #0
	moveq r4, #0
	mov r7, r1
	mov r6, r3
	cmp r5, #0
	beq _020A9C50
	cmp r4, #0
	beq _020A9C50
	add r2, sp, #0xc
	mov r0, r8
	mov r1, r7
	bl sub_20AD2A4
	cmp r0, #0
	beq _020A9C50
	ldr r0, [sp, #0xc]
	ldr r0, [r0, #0xc]
	cmp r0, #0
	beq _020A9C50
	mov r0, #0x204
	bl DWCi_GsMalloc
	movs r4, r0
	bne _020A9BB8
	ldr r1, _020A9CD0 // =aOutOfMemory_4
	mov r0, r8
	bl sub_20AFBA8
	add sp, sp, #0x20
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020A9BB8:
	ldr r0, [sp, #0xc]
	mov r1, r4
	ldr r0, [r0, #0xc]
	bl sub_20AB390
	mov r2, #0
	str r2, [r4]
	str r7, [r4, #4]
	ldr r7, [sp, #0x3c]
	str r5, [sp, #0x14]
	str r7, [sp, #0x18]
	mov r0, #1
	str r0, [sp]
	str r5, [sp, #4]
	add r3, sp, #0x10
	mov r0, r8
	mov r1, #2
	str r7, [sp, #8]
	bl sub_20ABA48
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r2, [sp, #0x10]
	mov r0, #0
	ldr r5, [r2, #0x18]
	add r1, sp, #0x14
	str r2, [sp]
	str r0, [sp, #4]
	mov r0, r8
	mov r3, r4
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [sp, #0x10]
	mov r0, r8
	bl sub_20AB940
	b _020A9CA4
_020A9C50:
	str r6, [sp]
	ldr r4, [sp, #0x3c]
	str r5, [sp, #4]
	add r3, sp, #0x10
	mov r0, r8
	mov r1, #2
	mov r2, #0
	str r4, [sp, #8]
	bl sub_20ABA48
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [sp, #0x10]
	mov r0, r8
	ldr r5, [r1, #0x18]
	mov r1, r7
	mov r2, r5
	bl sub_20A9CD4
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_020A9CA4:
	cmp r6, #0
	beq _020A9CC4
	mov r0, r8
	mov r1, r5
	bl sub_20A5C9C
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_020A9CC4:
	mov r0, #0
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020A9CD0: .word aOutOfMemory_4
	arm_func_end sub_20A9B20

	arm_func_start sub_20A9CD4
sub_20A9CD4: // 0x020A9CD4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r4, [r7, #0]
	mov r5, r2
	mov r6, r1
	ldr r2, _020A9D64 // =aGetprofileSess
	add r1, r4, #0x1f4
	bl sub_20A7C58
	ldr r2, [r4, #0x198]
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C20
	ldr r2, _020A9D68 // =aProfileid_0
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C58
	mov r2, r6
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C20
	mov r0, r7
	add r1, r4, #0x1f4
	ldr r2, _020A9D6C // =_0211DAD0
	bl sub_20A7C58
	mov r2, r5
	mov r0, r7
	add r1, r4, #0x1f4
	bl sub_20A7C20
	mov r0, r7
	add r1, r4, #0x1f4
	ldr r2, _020A9D70 // =aFinal_3
	bl sub_20A7C58
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020A9D64: .word aGetprofileSess
_020A9D68: .word aProfileid_0
_020A9D6C: .word _0211DAD0
_020A9D70: .word aFinal_3
	arm_func_end sub_20A9CD4

	arm_func_start sub_20A9D74
sub_20A9D74: // 0x020A9D74
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x100
	mov r6, r0
	movs r5, r2
	ldr r4, [r6, #0]
	bne _020A9DA0
	ldr r1, _020AA4CC // =aInvalidValue
	bl sub_20AFBA8
	add sp, sp, #0x100
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020A9DA0:
	sub r1, r1, #0x700
	cmp r1, #0x1e
	addls pc, pc, r1, lsl #2
	b _020AA4A8
_020A9DB0: // jump table
	b _020A9E2C // case 0
	b _020A9E8C // case 1
	b _020A9EF0 // case 2
	b _020A9F58 // case 3
	b _020A9FBC // case 4
	b _020A9FEC // case 5
	b _020AA178 // case 6
	b _020AA01C // case 7
	b _020AA04C // case 8
	b _020AA07C // case 9
	b _020AA4A8 // case 10
	b _020AA0D4 // case 11
	b _020AA4A8 // case 12
	b _020AA1A8 // case 13
	b _020AA1D0 // case 14
	b _020AA1F8 // case 15
	b _020AA228 // case 16
	b _020AA250 // case 17
	b _020AA280 // case 18
	b _020AA4A8 // case 19
	b _020AA2A8 // case 20
	b _020AA2D0 // case 21
	b _020AA2F8 // case 22
	b _020AA328 // case 23
	b _020AA358 // case 24
	b _020AA388 // case 25
	b _020AA3B8 // case 26
	b _020AA3E8 // case 27
	b _020AA418 // case 28
	b _020AA448 // case 29
	b _020AA478 // case 30
_020A9E2C:
	ldrsb r1, [r5, #0]
	cmp r1, #0
	bne _020A9E4C
	ldr r1, _020AA4CC // =aInvalidValue
	bl sub_20AFBA8
	add sp, sp, #0x100
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020A9E4C:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x1f
	bl sub_20B0098
	add r1, sp, #0
	add r0, r4, #0x110
	mov r2, #0x1f
	bl sub_20B0098
	ldr r1, _020AA4D0 // =aNick_0
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020A9E8C:
	ldrsb r1, [r5, #0]
	cmp r1, #0
	bne _020A9EAC
	ldr r1, _020AA4CC // =aInvalidValue
	bl sub_20AFBA8
	add sp, sp, #0x100
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020A9EAC:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x15
	bl sub_20B0098
	ldr r0, _020AA4D4 // =0x0000012F
	add r1, sp, #0
	add r0, r4, r0
	mov r2, #0x15
	bl sub_20B0098
	ldr r1, _020AA4D8 // =aUniquenick_0
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020A9EF0:
	ldrsb r1, [r5, #0]
	cmp r1, #0
	bne _020A9F10
	ldr r1, _020AA4CC // =aInvalidValue
	bl sub_20AFBA8
	add sp, sp, #0x100
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020A9F10:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x33
	bl sub_20B0098
	add r0, sp, #0
	bl sub_20A0C0C
	add r1, sp, #0
	add r0, r4, #0x144
	mov r2, #0x33
	bl sub_20B0098
	ldr r1, _020AA4DC // =aEmail_0
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA34
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020A9F58:
	ldrsb r1, [r5, #0]
	cmp r1, #0
	bne _020A9F78
	ldr r1, _020AA4CC // =aInvalidValue
	bl sub_20AFBA8
	add sp, sp, #0x100
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020A9F78:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x1f
	bl sub_20B0098
	ldr r0, _020AA4E0 // =0x00000177
	add r1, sp, #0
	add r0, r4, r0
	mov r2, #0x1f
	bl sub_20B0098
	ldr r1, _020AA4E4 // =aPassword
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA34
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020A9FBC:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x1f
	bl sub_20B0098
	ldr r1, _020AA4E8 // =aFirstname
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020A9FEC:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x1f
	bl sub_20B0098
	ldr r1, _020AA4EC // =aLastname
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA01C:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x4c
	bl sub_20B0098
	ldr r1, _020AA4F0 // =aHomepage
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA04C:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0xb
	bl sub_20B0098
	ldr r1, _020AA4F4 // =aZipcode
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA07C:
	mov r0, r5
	bl strlen
	cmp r0, #2
	beq _020AA0A4
	ldr r1, _020AA4F8 // =aInvalidCountry
	mov r0, r6
	bl sub_20AFBA8
	add sp, sp, #0x100
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020AA0A4:
	add r0, sp, #0
	mov r1, r5
	mov r2, #3
	bl sub_20B0098
	ldr r1, _020AA4FC // =aCountrycode
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA0D4:
	ldrsb r1, [r5, #0]
	cmp r1, #0
	blt _020AA0F0
	cmp r1, #0x80
	bge _020AA0F0
	ldr r0, _020AA500 // =_021170CC
	ldrb r1, [r0, r1]
_020AA0F0:
	mov r0, r1, lsl #0x18
	mov r0, r0, asr #0x18
	cmp r0, #0x4d
	bne _020AA11C
	ldr r0, _020AA504 // =0x0211DB94
	add r2, sp, #0
	ldrb r1, [r0, #0]
	ldrb r0, [r0, #1]
	strb r1, [r2]
	strb r0, [r2, #1]
	b _020AA158
_020AA11C:
	cmp r0, #0x46
	bne _020AA140
	ldr r0, _020AA508 // =0x0211DB98
	add r2, sp, #0
	ldrb r1, [r0, #0]
	ldrb r0, [r0, #1]
	strb r1, [r2]
	strb r0, [r2, #1]
	b _020AA158
_020AA140:
	ldr r0, _020AA50C // =0x0211DB9C
	add r2, sp, #0
	ldrb r1, [r0, #0]
	ldrb r0, [r0, #1]
	strb r1, [r2]
	strb r0, [r2, #1]
_020AA158:
	ldr r1, _020AA510 // =aSex
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA178:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA514 // =aIcquin
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA1A8:
	mov r0, r5
	bl atoi
	mov r2, r0
	ldr r1, _020AA518 // =0x0000070D
	mov r0, r6
	bl sub_20AA55C
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA1D0:
	mov r0, r5
	bl atoi
	mov r2, r0
	ldr r1, _020AA51C // =0x0000070E
	mov r0, r6
	bl sub_20AA55C
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA1F8:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA520 // =aVideocard1stri
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA228:
	mov r0, r5
	bl atoi
	mov r2, r0
	mov r0, r6
	mov r1, #0x710
	bl sub_20AA55C
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA250:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA524 // =aVideocard2stri
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA280:
	mov r0, r5
	bl atoi
	mov r2, r0
	ldr r1, _020AA528 // =0x00000712
	mov r0, r6
	bl sub_20AA55C
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA2A8:
	mov r0, r5
	bl atoi
	mov r2, r0
	ldr r1, _020AA52C // =0x00000714
	mov r0, r6
	bl sub_20AA55C
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA2D0:
	mov r0, r5
	bl atoi
	mov r2, r0
	ldr r1, _020AA530 // =0x00000715
	mov r0, r6
	bl sub_20AA55C
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA2F8:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA534 // =aOsstring
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA328:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x33
	bl sub_20B0098
	ldr r1, _020AA538 // =aAim
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA358:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA53C // =aPic
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA388:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA540 // =aOcc
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA3B8:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA544 // =aInd
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA3E8:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA548 // =aInc
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA418:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA54C // =aMar
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA448:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA550 // =aChc
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA478:
	add r0, sp, #0
	mov r1, r5
	mov r2, #0x100
	bl sub_20B0098
	ldr r1, _020AA554 // =0x0211DC20
	add r2, sp, #0
	mov r0, r6
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA4C0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
_020AA4A8:
	ldr r1, _020AA558 // =aInvalidInfo
	mov r0, r6
	bl sub_20AFBA8
	add sp, sp, #0x100
	mov r0, #2
	ldmia sp!, {r4, r5, r6, pc}
_020AA4C0:
	mov r0, #0
	add sp, sp, #0x100
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020AA4CC: .word aInvalidValue
_020AA4D0: .word aNick_0
_020AA4D4: .word 0x0000012F
_020AA4D8: .word aUniquenick_0
_020AA4DC: .word aEmail_0
_020AA4E0: .word 0x00000177
_020AA4E4: .word aPassword
_020AA4E8: .word aFirstname
_020AA4EC: .word aLastname
_020AA4F0: .word aHomepage
_020AA4F4: .word aZipcode
_020AA4F8: .word aInvalidCountry
_020AA4FC: .word aCountrycode
_020AA500: .word _021170CC
_020AA504: .word 0x0211DB94
_020AA508: .word 0x0211DB98
_020AA50C: .word 0x0211DB9C
_020AA510: .word aSex
_020AA514: .word aIcquin
_020AA518: .word 0x0000070D
_020AA51C: .word 0x0000070E
_020AA520: .word aVideocard1stri
_020AA524: .word aVideocard2stri
_020AA528: .word 0x00000712
_020AA52C: .word 0x00000714
_020AA530: .word 0x00000715
_020AA534: .word aOsstring
_020AA538: .word aAim
_020AA53C: .word aPic
_020AA540: .word aOcc
_020AA544: .word aInd
_020AA548: .word aInc
_020AA54C: .word aMar
_020AA550: .word aChc
_020AA554: .word 0x0211DC20
_020AA558: .word aInvalidInfo
	arm_func_end sub_20A9D74

	arm_func_start sub_20AA55C
sub_20AA55C: // 0x020AA55C
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	ldr r3, _020AA9C4 // =0x00000706
	mov r4, r0
	sub r1, r1, r3
	cmp r1, #0x18
	addls pc, pc, r1, lsl #2
	b _020AA9A0
_020AA57C: // jump table
	b _020AA6B4 // case 0
	b _020AA9A0 // case 1
	b _020AA5E0 // case 2
	b _020AA9A0 // case 3
	b _020AA9A0 // case 4
	b _020AA628 // case 5
	b _020AA6E0 // case 6
	b _020AA70C // case 7
	b _020AA738 // case 8
	b _020AA9A0 // case 9
	b _020AA770 // case 10
	b _020AA9A0 // case 11
	b _020AA7A8 // case 12
	b _020AA7E0 // case 13
	b _020AA80C // case 14
	b _020AA838 // case 15
	b _020AA9A0 // case 16
	b _020AA9A0 // case 17
	b _020AA86C // case 18
	b _020AA898 // case 19
	b _020AA8C4 // case 20
	b _020AA8F0 // case 21
	b _020AA91C // case 22
	b _020AA948 // case 23
	b _020AA974 // case 24
_020AA5E0:
	cmp r2, #0
	bge _020AA5FC
	ldr r1, _020AA9C8 // =aInvalidZipcode
	bl sub_20AFBA8
	add sp, sp, #0x10
	mov r0, #2
	ldmia sp!, {r4, pc}
_020AA5FC:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AA9D0 // =aZipcode
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA628:
	cmp r2, #0x500
	beq _020AA64C
	ldr r1, _020AA9D4 // =0x00000501
	cmp r2, r1
	beq _020AA668
	ldr r1, _020AA9D8 // =0x00000502
	cmp r2, r1
	beq _020AA684
	b _020AA6A0
_020AA64C:
	ldr r1, _020AA9DC // =aSex
	ldr r2, _020AA9E0 // =0x0211DB94
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA668:
	ldr r1, _020AA9DC // =aSex
	ldr r2, _020AA9E4 // =0x0211DB98
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA684:
	ldr r1, _020AA9DC // =aSex
	ldr r2, _020AA9E8 // =0x0211DB9C
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA6A0:
	ldr r1, _020AA9EC // =aInvalidSex
	bl sub_20AFBA8
	add sp, sp, #0x10
	mov r0, #2
	ldmia sp!, {r4, pc}
_020AA6B4:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AA9F0 // =aIcquin
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA6E0:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AA9F4 // =aCpubrandid
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA34
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA70C:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AA9F8 // =aCpuspeed
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA34
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA738:
	mov r0, r2, asr #3
	add r2, r2, r0, lsr #28
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	mov r2, r2, asr #4
	bl sprintf
	ldr r1, _020AA9FC // =aMemory
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA34
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA770:
	mov r0, r2, asr #1
	add r2, r2, r0, lsr #30
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	mov r2, r2, asr #2
	bl sprintf
	ldr r1, _020AAA00 // =aVideocard1ram
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA34
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA7A8:
	mov r0, r2, asr #1
	add r2, r2, r0, lsr #30
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	mov r2, r2, asr #2
	bl sprintf
	ldr r1, _020AAA04 // =aVideocard2ram
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA34
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA7E0:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AAA08 // =aConnectionid
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA34
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA80C:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AAA0C // =aConnectionspee
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA34
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA838:
	ldr r1, _020AA9CC // =_0211DAE0
	cmp r2, #0
	movne r2, #1
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AAA10 // =aHasnetwork
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA34
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA86C:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AAA14 // =aPic
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA898:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AAA18 // =aOcc
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA8C4:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AAA1C // =aInd
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA8F0:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AAA20 // =aInc
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA91C:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AAA24 // =aMar
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA948:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AAA28 // =aChc
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA974:
	ldr r1, _020AA9CC // =_0211DAE0
	add r0, sp, #0
	bl sprintf
	ldr r1, _020AAA2C // =0x0211DC20
	add r2, sp, #0
	mov r0, r4
	bl sub_20AAA74
	cmp r0, #0
	beq _020AA9B8
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
_020AA9A0:
	ldr r1, _020AAA30 // =aInvalidInfo
	mov r0, r4
	bl sub_20AFBA8
	add sp, sp, #0x10
	mov r0, #2
	ldmia sp!, {r4, pc}
_020AA9B8:
	mov r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_020AA9C4: .word 0x00000706
_020AA9C8: .word aInvalidZipcode
_020AA9CC: .word _0211DAE0
_020AA9D0: .word aZipcode
_020AA9D4: .word 0x00000501
_020AA9D8: .word 0x00000502
_020AA9DC: .word aSex
_020AA9E0: .word 0x0211DB94
_020AA9E4: .word 0x0211DB98
_020AA9E8: .word 0x0211DB9C
_020AA9EC: .word aInvalidSex
_020AA9F0: .word aIcquin
_020AA9F4: .word aCpubrandid
_020AA9F8: .word aCpuspeed
_020AA9FC: .word aMemory
_020AAA00: .word aVideocard1ram
_020AAA04: .word aVideocard2ram
_020AAA08: .word aConnectionid
_020AAA0C: .word aConnectionspee
_020AAA10: .word aHasnetwork
_020AAA14: .word aPic
_020AAA18: .word aOcc
_020AAA1C: .word aInd
_020AAA20: .word aInc
_020AAA24: .word aMar
_020AAA28: .word aChc
_020AAA2C: .word 0x0211DC20
_020AAA30: .word aInvalidInfo
	arm_func_end sub_20AA55C

	arm_func_start sub_20AAA34
sub_20AAA34: // 0x020AAA34
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0]
	mov r5, r2
	mov r2, r1
	add r1, r4, #0x450
	bl sub_20A7C58
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r6
	mov r2, r5
	add r1, r4, #0x450
	bl sub_20A7C58
	cmp r0, #0
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20AAA34

	arm_func_start sub_20AAA74
sub_20AAA74: // 0x020AAA74
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0]
	mov r5, r2
	mov r2, r1
	add r1, r4, #0x440
	bl sub_20A7C58
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r6
	mov r2, r5
	add r1, r4, #0x440
	bl sub_20A7C58
	cmp r0, #0
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20AAA74

	arm_func_start sub_20AAAB4
sub_20AAAB4: // 0x020AAAB4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r4, [r6, #0]
	mov r5, r1
	ldr r2, [r4, #0x448]
	cmp r2, #0
	ble _020AAB10
	ldr r2, _020AAB6C // =aUpdateproSessk
	bl sub_20A7C58
	ldr r2, [r4, #0x198]
	mov r0, r6
	mov r1, r5
	bl sub_20A7C20
	ldr r2, [r4, #0x440]
	mov r0, r6
	mov r1, r5
	bl sub_20A7C58
	ldr r2, _020AAB70 // =aFinal_3
	mov r0, r6
	mov r1, r5
	bl sub_20A7C58
	mov r0, #0
	str r0, [r4, #0x448]
_020AAB10:
	ldr r0, [r4, #0x458]
	cmp r0, #0
	ble _020AAB64
	ldr r2, _020AAB74 // =aUpdateuiSesske
	mov r0, r6
	mov r1, r5
	bl sub_20A7C58
	ldr r2, [r4, #0x198]
	mov r0, r6
	mov r1, r5
	bl sub_20A7C20
	ldr r2, [r4, #0x450]
	mov r0, r6
	mov r1, r5
	bl sub_20A7C58
	ldr r2, _020AAB70 // =aFinal_3
	mov r0, r6
	mov r1, r5
	bl sub_20A7C58
	mov r0, #0
	str r0, [r4, #0x458]
_020AAB64:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020AAB6C: .word aUpdateproSessk
_020AAB70: .word aFinal_3
_020AAB74: .word aUpdateuiSesske
	arm_func_end sub_20AAAB4

	arm_func_start sub_20AAB78
sub_20AAB78: // 0x020AAB78
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x26c
	mov r4, r2
	mov r10, r0
	mov r11, r1
	mov r1, r4
	mov r2, #1
	ldr r8, [r10, #0]
	bl sub_20AFFB4
	cmp r0, #0
	addne sp, sp, #0x26c
	movne r0, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AB304 // =_0211DCF4
	mov r0, r4
	mov r2, #4
	bl strncmp
	cmp r0, #0
	beq _020AABF0
	ldr r2, _020AB308 // =aUnexpectedData_1
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x26c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AABF0:
	ldr r1, _020AB30C // =aProfileid_0
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	bne _020AAC38
	ldr r2, _020AB308 // =aUnexpectedData_1
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x26c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AAC38:
	add r0, sp, #0x14
	bl atoi
	mov r9, r0
	cmp r9, #0
	bgt _020AAC60
	ldr r0, _020AB310 // =aProfileid0
	ldr r1, _020AB314 // =aGpiinfoC
	ldr r3, _020AB318 // =0x0000015A
	mov r2, #0
	bl __msl_assertion_failed
_020AAC60:
	add r2, sp, #8
	mov r0, r10
	mov r1, r9
	bl sub_20AD2A4
	mov r0, #0
	add r6, sp, #0x12c
	mov r1, r0
	mov r2, r0
	mov r3, r0
	mov r5, #7
_020AAC88:
	stmia r6!, {r0, r1, r2, r3}
	stmia r6!, {r0, r1, r2, r3}
	subs r5, r5, #1
	bne _020AAC88
	stmia r6!, {r0, r1, r2, r3}
	add r3, sp, #0x73
	add r1, sp, #0xbb
	add r2, sp, #0x54
	add r5, sp, #0x88
	add r0, sp, #0xda
	str r3, [sp, #0x130]
	add r3, sp, #0x21c
	str r1, [sp, #0x138]
	str r5, [sp, #0x134]
	add r5, sp, #0xf9
	str r0, [sp, #0x13c]
	str r3, [sp, #0x140]
	ldr r1, _020AB31C // =aNick_0
	mov r0, r4
	mov r3, #0x1f
	str r2, [sp, #0x12c]
	str r5, [sp, #0x1f4]
	bl sub_20AFEAC
	cmp r0, #0
	ldreq r0, [sp, #0x12c]
	moveq r1, #0
	streqb r1, [r0]
	ldr r2, [sp, #0x130]
	ldr r1, _020AB320 // =aUniquenick_0
	mov r0, r4
	mov r3, #0x15
	bl sub_20AFEAC
	cmp r0, #0
	ldreq r0, [sp, #0x130]
	moveq r1, #0
	streqb r1, [r0]
	ldr r2, [sp, #0x134]
	ldr r1, _020AB324 // =aEmail_0
	mov r0, r4
	mov r3, #0x33
	bl sub_20AFEAC
	cmp r0, #0
	ldreq r0, [sp, #0x134]
	moveq r1, #0
	streqb r1, [r0]
	ldr r2, [sp, #0x138]
	ldr r1, _020AB328 // =aFirstname
	mov r0, r4
	mov r3, #0x1f
	bl sub_20AFEAC
	cmp r0, #0
	ldreq r0, [sp, #0x138]
	moveq r1, #0
	streqb r1, [r0]
	ldr r2, [sp, #0x13c]
	ldr r1, _020AB32C // =aLastname
	mov r0, r4
	mov r3, #0x1f
	bl sub_20AFEAC
	cmp r0, #0
	ldreq r0, [sp, #0x13c]
	moveq r1, #0
	streqb r1, [r0]
	ldr r1, _020AB330 // =aIcquin
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	mvneq r0, #0
	streq r0, [sp, #0x144]
	beq _020AADB4
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x144]
_020AADB4:
	ldr r2, [sp, #0x140]
	ldr r1, _020AB334 // =aHomepage
	mov r0, r4
	mov r3, #0x4c
	bl sub_20AFEAC
	cmp r0, #0
	ldreq r0, [sp, #0x140]
	moveq r1, #0
	streqb r1, [r0]
	ldr r1, _020AB338 // =aZipcode
	add r2, sp, #0x148
	mov r0, r4
	mov r3, #0xb
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	add r2, sp, #0x100
	streqb r0, [sp, #0x148]
	ldr r1, _020AB33C // =aCountrycode
	add r2, r2, #0x53
	mov r0, r4
	mov r3, #3
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streqb r0, [sp, #0x153]
	ldr r1, _020AB340 // =aLon
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x158]
	beq _020AAE50
	add r0, sp, #0x14
	bl atof
	bl _d2f
	str r0, [sp, #0x158]
_020AAE50:
	ldr r1, _020AB344 // =aLat
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x15c]
	beq _020AAE84
	add r0, sp, #0x14
	bl atof
	bl _d2f
	str r0, [sp, #0x15c]
_020AAE84:
	ldr r1, _020AB348 // =aLoc
	add r2, sp, #0x160
	mov r0, r4
	mov r3, #0x80
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streqb r0, [sp, #0x160]
	ldr r1, _020AB34C // =aBirthday
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x1e0]
	streq r0, [sp, #0x1e4]
	streq r0, [sp, #0x1e8]
	beq _020AAF00
	add r0, sp, #0x14
	bl atoi
	add r5, sp, #0x1e8
	mov r1, r0
	add r2, sp, #0x1e0
	add r3, sp, #0x1e4
	mov r0, r10
	str r5, [sp]
	bl sub_20AB594
	cmp r0, #0
	addne sp, sp, #0x26c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AAF00:
	ldr r1, _020AB350 // =aSex
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	ldreq r0, _020AB354 // =0x00000502
	streq r0, [sp, #0x1ec]
	beq _020AAF4C
	ldrsb r0, [sp, #0x14]
	cmp r0, #0x30
	moveq r0, #0x500
	streq r0, [sp, #0x1ec]
	beq _020AAF4C
	cmp r0, #0x31
	ldreq r0, _020AB358 // =0x00000501
	streq r0, [sp, #0x1ec]
	ldrne r0, _020AB354 // =0x00000502
	strne r0, [sp, #0x1ec]
_020AAF4C:
	ldr r1, _020AB35C // =aPmask
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	mvneq r0, #0
	streq r0, [sp, #0x1f0]
	beq _020AAF7C
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x1f0]
_020AAF7C:
	ldr r2, [sp, #0x1f4]
	ldr r1, _020AB360 // =aAim
	mov r0, r4
	mov r3, #0x33
	bl sub_20AFEAC
	cmp r0, #0
	ldreq r0, [sp, #0x1f4]
	moveq r1, #0
	streqb r1, [r0]
	ldr r1, _020AB364 // =aPic
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x1f8]
	beq _020AAFD0
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x1f8]
_020AAFD0:
	ldr r1, _020AB368 // =aOcc
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x1fc]
	beq _020AB000
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x1fc]
_020AB000:
	ldr r1, _020AB36C // =aInd
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x200]
	beq _020AB030
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x200]
_020AB030:
	ldr r1, _020AB370 // =aInc
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x204]
	beq _020AB060
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x204]
_020AB060:
	ldr r1, _020AB374 // =aMar
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x208]
	beq _020AB090
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x208]
_020AB090:
	ldr r1, _020AB378 // =aChc
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x20c]
	beq _020AB0C0
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x20c]
_020AB0C0:
	ldr r1, _020AB37C // =0x0211DC20
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x210]
	beq _020AB0F0
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x210]
_020AB0F0:
	ldr r1, _020AB380 // =_0211DD68
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x214]
	beq _020AB120
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x214]
_020AB120:
	ldr r1, _020AB384 // =aConn
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streq r0, [sp, #0x218]
	beq _020AB150
	add r0, sp, #0x14
	bl atoi
	str r0, [sp, #0x218]
_020AB150:
	ldr r1, _020AB388 // =aSig_0
	add r2, sp, #0x14
	mov r0, r4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	bne _020AB198
	ldr r2, _020AB308 // =aUnexpectedData_1
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x26c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AB198:
	ldr r7, [r8, #0x434]
	ldr r6, [r8, #0x100]
	cmp r7, #0
	beq _020AB1F8
	mov r5, #0x66
	mov r4, #1
_020AB1B0:
	ldr r0, [r7, #0xc]
	cmp r0, r9
	bne _020AB1EC
	ldr r0, [r7, #0]
	cmp r0, #0x65
	bne _020AB1EC
	ldr r0, [sp, #8]
	cmp r0, #0
	bne _020AB1E4
	mov r0, r10
	mov r1, r9
	bl sub_20AD2E0
	str r0, [sp, #8]
_020AB1E4:
	mov r6, r4
	str r5, [r7]
_020AB1EC:
	ldr r7, [r7, #0x3c]
	cmp r7, #0
	bne _020AB1B0
_020AB1F8:
	ldr r0, [sp, #8]
	cmp r0, #0
	bne _020AB220
	ldr r0, [r8, #0x100]
	cmp r0, #0
	beq _020AB220
	mov r0, r10
	mov r1, r9
	bl sub_20AD2E0
	str r0, [sp, #8]
_020AB220:
	cmp r6, #0
	beq _020AB250
	ldr r0, [sp, #8]
	ldr r0, [r0, #0x18]
	bl DWCi_GsFree
	ldr r1, [sp, #8]
	mov r2, #0
	add r0, sp, #0x14
	str r2, [r1, #0x18]
	bl sub_20A0C50
	ldr r1, [sp, #8]
	str r0, [r1, #0x18]
_020AB250:
	ldr r0, [r8, #0x100]
	cmp r0, #0
	beq _020AB26C
	ldr r1, [sp, #8]
	add r2, sp, #0x12c
	mov r0, r10
	bl sub_20A9A44
_020AB26C:
	ldr r1, [r11, #0xc]
	ldr r0, [r11, #0x10]
	cmp r1, #0
	str r1, [sp, #0xc]
	str r0, [sp, #0x10]
	beq _020AB2EC
	mov r0, #0x204
	bl DWCi_GsMalloc
	movs r4, r0
	bne _020AB2AC
	ldr r1, _020AB38C // =aOutOfMemory_4
	mov r0, r10
	bl sub_20AFBA8
	add sp, sp, #0x26c
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AB2AC:
	add r0, sp, #0x12c
	mov r1, r4
	bl sub_20AB390
	mov r0, #0
	str r0, [r4]
	str r9, [r4, #4]
	str r11, [sp]
	str r0, [sp, #4]
	add r1, sp, #0xc
	mov r0, r10
	mov r3, r4
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	addne sp, sp, #0x26c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AB2EC:
	mov r0, r10
	mov r1, r11
	bl sub_20AB940
	mov r0, #0
	add sp, sp, #0x26c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020AB304: .word _0211DCF4
_020AB308: .word aUnexpectedData_1
_020AB30C: .word aProfileid_0
_020AB310: .word aProfileid0
_020AB314: .word aGpiinfoC
_020AB318: .word 0x0000015A
_020AB31C: .word aNick_0
_020AB320: .word aUniquenick_0
_020AB324: .word aEmail_0
_020AB328: .word aFirstname
_020AB32C: .word aLastname
_020AB330: .word aIcquin
_020AB334: .word aHomepage
_020AB338: .word aZipcode
_020AB33C: .word aCountrycode
_020AB340: .word aLon
_020AB344: .word aLat
_020AB348: .word aLoc
_020AB34C: .word aBirthday
_020AB350: .word aSex
_020AB354: .word 0x00000502
_020AB358: .word 0x00000501
_020AB35C: .word aPmask
_020AB360: .word aAim
_020AB364: .word aPic
_020AB368: .word aOcc
_020AB36C: .word aInd
_020AB370: .word aInc
_020AB374: .word aMar
_020AB378: .word aChc
_020AB37C: .word 0x0211DC20
_020AB380: .word _0211DD68
_020AB384: .word aConn
_020AB388: .word aSig_0
_020AB38C: .word aOutOfMemory_4
	arm_func_end sub_20AAB78

	arm_func_start sub_20AB390
sub_20AB390: // 0x020AB390
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldr r1, [r5, #0]
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r4, #8]
	beq _020AB3C0
	add r0, r4, #8
	mov r2, #0x1f
	bl sub_20B0098
_020AB3C0:
	ldr r1, [r5, #4]
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r4, #0x27]
	beq _020AB3E0
	add r0, r4, #0x27
	mov r2, #0x15
	bl sub_20B0098
_020AB3E0:
	ldr r1, [r5, #8]
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r4, #0x3c]
	beq _020AB400
	add r0, r4, #0x3c
	mov r2, #0x33
	bl sub_20B0098
_020AB400:
	ldr r1, [r5, #0xc]
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r4, #0x6f]
	beq _020AB420
	add r0, r4, #0x6f
	mov r2, #0x1f
	bl sub_20B0098
_020AB420:
	ldr r1, [r5, #0x10]
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r4, #0x8e]
	beq _020AB440
	add r0, r4, #0x8e
	mov r2, #0x1f
	bl sub_20B0098
_020AB440:
	ldr r1, [r5, #0x14]
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r4, #0xad]
	beq _020AB460
	add r0, r4, #0xad
	mov r2, #0x4c
	bl sub_20B0098
_020AB460:
	ldr r3, [r5, #0x18]
	add r0, r4, #0x100
	add r1, r5, #0x1c
	mov r2, #0xb
	str r3, [r4, #0xfc]
	bl sub_20B0098
	ldr r0, _020AB590 // =0x0000010B
	add r1, r5, #0x27
	add r0, r4, r0
	mov r2, #3
	bl sub_20B0098
	ldr r0, [r5, #0x2c]
	adds r1, r5, #0x34
	str r0, [r4, #0x110]
	ldr r0, [r5, #0x30]
	str r0, [r4, #0x114]
	moveq r0, #0
	streqb r0, [r4, #0x118]
	beq _020AB4B8
	add r0, r4, #0x118
	mov r2, #0x80
	bl sub_20B0098
_020AB4B8:
	ldr r0, [r5, #0xb4]
	str r0, [r4, #0x198]
	ldr r0, [r5, #0xb8]
	str r0, [r4, #0x19c]
	ldr r0, [r5, #0xbc]
	str r0, [r4, #0x1a0]
	ldr r0, [r5, #0xc0]
	str r0, [r4, #0x1a4]
	ldr r0, [r5, #0xc4]
	str r0, [r4, #0x1a8]
	ldr r1, [r5, #0xc8]
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r4, #0x1ac]
	beq _020AB500
	add r0, r4, #0x1ac
	mov r2, #0x33
	bl sub_20B0098
_020AB500:
	ldr r0, [r5, #0x18]
	str r0, [r4, #0xfc]
	ldr r0, [r5, #0x2c]
	str r0, [r4, #0x110]
	ldr r0, [r5, #0x30]
	str r0, [r4, #0x114]
	ldr r0, [r5, #0xb4]
	str r0, [r4, #0x198]
	ldr r0, [r5, #0xb8]
	str r0, [r4, #0x19c]
	ldr r0, [r5, #0xbc]
	str r0, [r4, #0x1a0]
	ldr r0, [r5, #0xc0]
	str r0, [r4, #0x1a4]
	ldr r0, [r5, #0xc4]
	str r0, [r4, #0x1a8]
	ldr r0, [r5, #0xcc]
	str r0, [r4, #0x1e0]
	ldr r0, [r5, #0xd0]
	str r0, [r4, #0x1e4]
	ldr r0, [r5, #0xd4]
	str r0, [r4, #0x1e8]
	ldr r0, [r5, #0xd8]
	str r0, [r4, #0x1ec]
	ldr r0, [r5, #0xdc]
	str r0, [r4, #0x1f0]
	ldr r0, [r5, #0xe0]
	str r0, [r4, #0x1f4]
	ldr r0, [r5, #0xe4]
	str r0, [r4, #0x1f8]
	ldr r0, [r5, #0xe8]
	str r0, [r4, #0x1fc]
	ldr r0, [r5, #0xec]
	str r0, [r4, #0x200]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020AB590: .word 0x0000010B
	arm_func_end sub_20AB390

	arm_func_start sub_20AB594
sub_20AB594: // 0x020AB594
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldr ip, _020AB634 // =0x0000FFFF
	mov r4, r1, asr #0x18
	mov lr, r1, asr #0x10
	and r7, r4, #0xff
	mov r4, r0
	and r6, lr, #0xff
	and r5, r1, ip
	mov r9, r2
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r8, r3
	bl sub_20AB644
	cmp r0, #0
	bne _020AB5EC
	ldr r0, _020AB638 // =aGpiisvaliddate
	ldr r1, _020AB63C // =aGpiinfoC
	mov r2, #0
	mov r3, #0xb7
	bl __msl_assertion_failed
_020AB5EC:
	mov r0, r7
	mov r1, r6
	mov r2, r5
	bl sub_20AB644
	cmp r0, #0
	strne r7, [r9]
	ldrne r0, [sp, #0x20]
	strne r6, [r8]
	strne r5, [r0]
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r1, _020AB640 // =aInvalidDate
	mov r0, r4
	bl sub_20AFBA8
	mov r0, #2
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020AB634: .word 0x0000FFFF
_020AB638: .word aGpiisvaliddate
_020AB63C: .word aGpiinfoC
_020AB640: .word aInvalidDate
	arm_func_end sub_20AB594

	arm_func_start sub_20AB644
sub_20AB644: // 0x020AB644
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	cmp r0, #0
	bne _020AB66C
	cmp r1, #0
	bne _020AB66C
	cmp r2, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
_020AB66C:
	cmp r0, #0
	blt _020AB684
	cmp r1, #0
	blt _020AB684
	cmp r2, #0
	bge _020AB690
_020AB684:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020AB690:
	cmp r1, #0xc
	addls pc, pc, r1, lsl #2
	b _020AB788
_020AB69C: // jump table
	b _020AB6D0 // case 0
	b _020AB6E4 // case 1
	b _020AB70C // case 2
	b _020AB6E4 // case 3
	b _020AB6F8 // case 4
	b _020AB6E4 // case 5
	b _020AB6F8 // case 6
	b _020AB6E4 // case 7
	b _020AB6E4 // case 8
	b _020AB6F8 // case 9
	b _020AB6E4 // case 10
	b _020AB6F8 // case 11
	b _020AB6E4 // case 12
_020AB6D0:
	cmp r0, #0
	beq _020AB794
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020AB6E4:
	cmp r0, #0x1f
	ble _020AB794
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020AB6F8:
	cmp r0, #0x1e
	ble _020AB794
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020AB70C:
	mov r4, r2, lsr #0x1f
	rsb r3, r4, r2, lsl #30
	adds r3, r4, r3, ror #30
	bne _020AB73C
	ldr ip, _020AB7F8 // =0x51EB851F
	ldr lr, _020AB7FC // =0x00000064
	smull r3, r5, ip, r2
	mov r5, r5, asr #5
	add r5, r4, r5
	smull r3, ip, lr, r5
	subs r5, r2, r3
	bne _020AB760
_020AB73C:
	ldr lr, _020AB7F8 // =0x51EB851F
	mov r3, r2, lsr #0x1f
	smull ip, r4, lr, r2
	mov r4, r4, asr #7
	ldr lr, _020AB800 // =0x00000190
	add r4, r3, r4
	smull r3, ip, lr, r4
	subs r4, r2, r3
	bne _020AB774
_020AB760:
	cmp r0, #0x1d
	ble _020AB794
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020AB774:
	cmp r0, #0x1c
	ble _020AB794
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020AB788:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020AB794:
	ldr r3, _020AB804 // =0x0000076C
	cmp r2, r3
	addlt sp, sp, #4
	movlt r0, #0
	ldmltia sp!, {r4, r5, pc}
	ldr r3, _020AB808 // =0x0000081F
	cmp r2, r3
	addgt sp, sp, #4
	movgt r0, #0
	ldmgtia sp!, {r4, r5, pc}
	cmp r2, r3
	bne _020AB7EC
	cmp r1, #6
	addgt sp, sp, #4
	movgt r0, #0
	ldmgtia sp!, {r4, r5, pc}
	cmp r1, #6
	bne _020AB7EC
	cmp r0, #6
	addgt sp, sp, #4
	movgt r0, #0
	ldmgtia sp!, {r4, r5, pc}
_020AB7EC:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020AB7F8: .word 0x51EB851F
_020AB7FC: .word 0x00000064
_020AB800: .word 0x00000190
_020AB804: .word 0x0000076C
_020AB808: .word 0x0000081F
	arm_func_end sub_20AB644

	arm_func_start sub_20AB80C
sub_20AB80C: // 0x020AB80C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r1
	ldr r3, [r5, #0]
	mov r4, #0
	cmp r3, #4
	addls pc, pc, r3, lsl #2
	b _020AB870
_020AB82C: // jump table
	b _020AB840 // case 0
	b _020AB84C // case 1
	b _020AB858 // case 2
	b _020AB870 // case 3
	b _020AB864 // case 4
_020AB840:
	bl sub_20A85F0
	mov r4, r0
	b _020AB890
_020AB84C:
	bl sub_20AD3CC
	mov r4, r0
	b _020AB890
_020AB858:
	bl sub_20AAB78
	mov r4, r0
	b _020AB890
_020AB864:
	bl sub_20AFAA4
	mov r4, r0
	b _020AB890
_020AB870:
	ldr r1, _020AB8A4 // =aGpiprocessoper
	mov r2, r3
	bl sub_20B008C
	ldr r0, _020AB8A8 // =0x0211DDF0
	ldr r1, _020AB8AC // =aGpioperationC
	ldr r3, _020AB8B0 // =0x00000146
	mov r2, #0
	bl __msl_assertion_failed
_020AB890:
	cmp r4, #0
	strne r4, [r5, #0x1c]
	mov r0, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020AB8A4: .word aGpiprocessoper
_020AB8A8: .word 0x0211DDF0
_020AB8AC: .word aGpioperationC
_020AB8B0: .word 0x00000146
	arm_func_end sub_20AB80C

	arm_func_start sub_20AB8B4
sub_20AB8B4: // 0x020AB8B4
	ldr r0, [r0, #0]
	ldr r1, [r0, #0x424]
	cmp r1, #0
	beq _020AB8EC
_020AB8C4:
	ldr r0, [r1, #8]
	cmp r0, #0
	beq _020AB8E0
	ldr r0, [r1, #0]
	cmp r0, #3
	movne r0, #1
	bxne lr
_020AB8E0:
	ldr r1, [r1, #0x20]
	cmp r1, #0
	bne _020AB8C4
_020AB8EC:
	mov r0, #0
	bx lr
	arm_func_end sub_20AB8B4

	arm_func_start sub_20AB8F4
sub_20AB8F4: // 0x020AB8F4
	ldr r0, [r0, #0]
	ldr r3, [r0, #0x424]
	cmp r3, #0
	beq _020AB92C
_020AB904:
	ldr r0, [r3, #0x18]
	cmp r0, r2
	bne _020AB920
	cmp r1, #0
	strne r3, [r1]
	mov r0, #1
	bx lr
_020AB920:
	ldr r3, [r3, #0x20]
	cmp r3, #0
	bne _020AB904
_020AB92C:
	cmp r1, #0
	movne r0, #0
	strne r0, [r1]
	mov r0, #0
	bx lr
	arm_func_end sub_20AB8F4

	arm_func_start sub_20AB940
sub_20AB940: // 0x020AB940
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, [r0]
	mov r3, #0
	ldr r2, [ip, #0x424]
	cmp r2, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
_020AB960:
	cmp r2, r1
	bne _020AB988
	cmp r3, #0
	ldreq r2, [r2, #0x20]
	streq r2, [ip, #0x424]
	ldrne r2, [r1, #0x20]
	strne r2, [r3, #0x20]
	bl sub_20AB9A0
	add sp, sp, #4
	ldmia sp!, {pc}
_020AB988:
	mov r3, r2
	ldr r2, [r2, #0x20]
	cmp r2, #0
	bne _020AB960
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20AB940

	arm_func_start sub_20AB9A0
sub_20AB9A0: // 0x020AB9A0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r1
	ldr r1, [r5, #0]
	ldr r2, [r0, #0]
	cmp r1, #3
	bne _020ABA20
	ldr r0, [r2, #0x210]
	ldr r4, [r5, #4]
	sub r0, r0, #1
	str r0, [r2, #0x210]
	ldr r0, [r2, #0x210]
	cmp r0, #0
	bge _020AB9EC
	ldr r0, _020ABA40 // =aIconnectionNum
	ldr r1, _020ABA44 // =aGpioperationC
	mov r2, #0
	mov r3, #0xb6
	bl __msl_assertion_failed
_020AB9EC:
	ldr r0, [r4, #4]
	mov r1, #2
	bl sub_20A07C8
	ldr r0, [r4, #4]
	bl sub_20A07E4
	ldr r0, [r4, #0x18]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x18]
	ldr r0, [r4, #8]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #8]
_020ABA20:
	ldr r0, [r5, #4]
	bl DWCi_GsFree
	mov r1, #0
	mov r0, r5
	str r1, [r5, #4]
	bl DWCi_GsFree
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020ABA40: .word aIconnectionNum
_020ABA44: .word aGpioperationC
	arm_func_end sub_20AB9A0

	arm_func_start sub_20ABA48
sub_20ABA48: // 0x020ABA48
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r0
	mov r0, #0x24
	mov r7, r1
	mov r6, r2
	mov r5, r3
	ldr r4, [r8, #0]
	bl DWCi_GsMalloc
	cmp r0, #0
	bne _020ABA84
	ldr r1, _020ABAFC // =aOutOfMemory_5
	mov r0, r8
	bl sub_20AFBA8
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020ABA84:
	str r7, [r0]
	ldr r1, [sp, #0x18]
	str r6, [r0, #4]
	str r1, [r0, #8]
	mov r1, #0
	str r1, [r0, #0x14]
	cmp r7, #0
	moveq r1, #1
	streq r1, [r0, #0x18]
	beq _020ABACC
	ldr r2, [r4, #0x20c]
	add r1, r2, #1
	str r1, [r4, #0x20c]
	str r2, [r0, #0x18]
	ldr r1, [r4, #0x20c]
	cmp r1, #2
	movlt r1, #2
	strlt r1, [r4, #0x20c]
_020ABACC:
	mov r3, #0
	ldr r2, [sp, #0x1c]
	str r3, [r0, #0x1c]
	ldr r1, [sp, #0x20]
	str r2, [r0, #0xc]
	str r1, [r0, #0x10]
	ldr r1, [r4, #0x424]
	str r1, [r0, #0x20]
	str r0, [r4, #0x424]
	str r0, [r5]
	mov r0, r3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020ABAFC: .word aOutOfMemory_5
	arm_func_end sub_20ABA48

	arm_func_start sub_20ABB00
sub_20ABB00: // 0x020ABB00
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	movs r7, r0
	mov r6, r1
	ldr r5, [r7, #0]
	bne _020ABB2C
	ldr r0, _020ABE24 // =aConnectionNull
	ldr r1, _020ABE28 // =aGpioperationC
	mov r2, #0
	mov r3, #0x22
	bl __msl_assertion_failed
_020ABB2C:
	ldr r0, [r7, #0]
	cmp r0, #0
	bne _020ABB4C
	ldr r0, _020ABE2C // =aConnectionNull_0
	ldr r1, _020ABE28 // =aGpioperationC
	mov r2, #0
	mov r3, #0x23
	bl __msl_assertion_failed
_020ABB4C:
	cmp r6, #0
	bne _020ABB68
	ldr r0, _020ABE30 // =aOperationNull
	ldr r1, _020ABE28 // =aGpioperationC
	mov r2, #0
	mov r3, #0x24
	bl __msl_assertion_failed
_020ABB68:
	ldr r1, [r6, #0xc]
	ldr r0, [r6, #0x10]
	cmp r1, #0
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	beq _020ABE18
	ldr r0, [r6, #0]
	cmp r0, #4
	addls pc, pc, r0, lsl #2
	b _020ABE04
_020ABB90: // jump table
	b _020ABBA4 // case 0
	b _020ABC2C // case 1
	b _020ABCA8 // case 2
	b _020ABD14 // case 3
	b _020ABD98 // case 4
_020ABBA4:
	mov r0, #0x20
	bl DWCi_GsMalloc
	movs r4, r0
	bne _020ABBCC
	ldr r1, _020ABE34 // =aOutOfMemory_5
	mov r0, r7
	bl sub_20AFBA8
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ABBCC:
	mov r1, #0
	mov r2, #0x20
	bl memset
	ldr r1, [r6, #0x1c]
	ldr r0, _020ABE38 // =0x00000201
	str r1, [r4]
	ldr r1, [r5, #0x418]
	mov r3, r4
	cmp r1, r0
	ldreq r1, [r5, #0x1a0]
	moveq r0, #0
	streq r1, [r4, #4]
	streq r0, [r5, #0x1a0]
	str r6, [sp]
	mov r0, #0
	str r0, [sp, #4]
	add r1, sp, #8
	mov r0, r7
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020ABE18
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ABC2C:
	mov r0, #8
	bl DWCi_GsMalloc
	movs r3, r0
	bne _020ABC54
	ldr r1, _020ABE34 // =aOutOfMemory_5
	mov r0, r7
	bl sub_20AFBA8
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ABC54:
	mov r2, #0
	strb r2, [r3]
	strb r2, [r3, #1]
	strb r2, [r3, #2]
	strb r2, [r3, #3]
	strb r2, [r3, #4]
	strb r2, [r3, #5]
	strb r2, [r3, #6]
	strb r2, [r3, #7]
	ldr r0, [r6, #0x1c]
	add r1, sp, #8
	str r0, [r3]
	str r6, [sp]
	str r2, [sp, #4]
	mov r0, r7
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020ABE18
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ABCA8:
	mov r0, #0x204
	bl DWCi_GsMalloc
	movs r4, r0
	bne _020ABCD0
	ldr r1, _020ABE34 // =aOutOfMemory_5
	mov r0, r7
	bl sub_20AFBA8
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ABCD0:
	mov r1, #0
	mov r2, #0x204
	bl memset
	ldr r1, [r6, #0x1c]
	mov r0, #0
	str r1, [r4]
	str r6, [sp]
	str r0, [sp, #4]
	add r1, sp, #8
	mov r0, r7
	mov r3, r4
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020ABE18
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ABD14:
	mov r0, #0x10
	bl DWCi_GsMalloc
	movs r3, r0
	bne _020ABD3C
	ldr r1, _020ABE34 // =aOutOfMemory_5
	mov r0, r7
	bl sub_20AFBA8
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ABD3C:
	mov r2, r3
	mov r1, #4
	mov r0, #0
_020ABD48:
	strb r0, [r2], #1
	strb r0, [r2], #1
	strb r0, [r2], #1
	strb r0, [r2], #1
	subs r1, r1, #1
	bne _020ABD48
	ldr r1, [r6, #0x1c]
	mov r0, #0
	str r1, [r3]
	str r0, [r3, #0xc]
	str r6, [sp]
	str r0, [sp, #4]
	add r1, sp, #8
	mov r0, r7
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020ABE18
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ABD98:
	mov r0, #4
	bl DWCi_GsMalloc
	movs r3, r0
	bne _020ABDC0
	ldr r1, _020ABE34 // =aOutOfMemory_5
	mov r0, r7
	bl sub_20AFBA8
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ABDC0:
	mov r2, #0
	strb r2, [r3]
	strb r2, [r3, #1]
	strb r2, [r3, #2]
	strb r2, [r3, #3]
	ldr r0, [r6, #0x1c]
	add r1, sp, #8
	str r0, [r3]
	str r6, [sp]
	str r2, [sp, #4]
	mov r0, r7
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020ABE18
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ABE04:
	ldr r0, _020ABE3C // =0x0211DDF0
	ldr r1, _020ABE28 // =aGpioperationC
	mov r2, #0
	mov r3, #0x6b
	bl __msl_assertion_failed
_020ABE18:
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020ABE24: .word aConnectionNull
_020ABE28: .word aGpioperationC
_020ABE2C: .word aConnectionNull_0
_020ABE30: .word aOperationNull
_020ABE34: .word aOutOfMemory_5
_020ABE38: .word 0x00000201
_020ABE3C: .word 0x0211DDF0
	arm_func_end sub_20ABB00

	arm_func_start sub_20ABE40
sub_20ABE40: // 0x020ABE40
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x24
	movs r6, r1
	mov r7, r0
	mov r5, r2
	mov r4, r3
	bne _020ABE70
	ldr r0, _020ABF14 // =aPeerNull
	ldr r1, _020ABF18 // =aGpipeerC
	ldr r3, _020ABF1C // =0x00000389
	mov r2, #0
	bl __msl_assertion_failed
_020ABE70:
	mvn r0, #0
	cmp r5, #0
	ldreq r5, _020ABF20 // =0x0211DE8C
	cmp r4, r0
	bne _020ABE90
	mov r0, r5
	bl strlen
	mov r4, r0
_020ABE90:
	ldr r1, _020ABF24 // =aLenDMsg
	add r0, sp, #0
	mov r2, r4
	bl sprintf
	add r2, sp, #0
	mov r0, r7
	mov r1, r6
	bl sub_20A7914
	cmp r0, #0
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl sub_20A7944
	cmp r0, #0
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, r7
	mov r1, r6
	mov r2, #0
	bl sub_20A7A48
	cmp r0, #0
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, #0
	bl sub_20A0510
	add r0, r0, #0x12c
	str r0, [r6, #0x10]
	mov r0, #0
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020ABF14: .word aPeerNull
_020ABF18: .word aGpipeerC
_020ABF1C: .word 0x00000389
_020ABF20: .word 0x0211DE8C
_020ABF24: .word aLenDMsg
	arm_func_end sub_20ABE40

	arm_func_start sub_20ABF28
sub_20ABF28: // 0x020ABF28
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x4c
	mov r9, r0
	mov r8, r1
	mov r7, r2
	cmp r3, #0
	ldr r6, [r3, #4]
	ldr r5, [r3, #0]
	ldr r4, [r3, #8]
	bne _020ABF64
	ldr r0, _020ABF98 // =aTransferid
	ldr r1, _020ABF9C // =aGpipeerC
	ldr r3, _020ABFA0 // =0x00000376
	mov r2, #0
	bl __msl_assertion_failed
_020ABF64:
	ldr r1, _020ABFA4 // =aMDXferDUU
	str r6, [sp]
	add r0, sp, #8
	mov r2, r7
	mov r3, r5
	str r4, [sp, #4]
	bl sprintf
	add r2, sp, #8
	mov r0, r9
	mov r1, r8
	bl sub_20A7914
	add sp, sp, #0x4c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020ABF98: .word aTransferid
_020ABF9C: .word aGpipeerC
_020ABFA0: .word 0x00000376
_020ABFA4: .word aMDXferDUU
	arm_func_end sub_20ABF28

	arm_func_start sub_20ABFA8
sub_20ABFA8: // 0x020ABFA8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x18
	movs r7, r1
	mov r8, r0
	mov r6, r2
	mov r5, r3
	bne _020ABFD8
	ldr r0, _020AC118 // =aPeerNull
	ldr r1, _020AC11C // =aGpipeerC
	mov r2, #0
	mov r3, #0x340
	bl __msl_assertion_failed
_020ABFD8:
	cmp r5, #0
	bne _020ABFF4
	ldr r0, _020AC120 // =aMessageNull
	ldr r1, _020AC11C // =aGpipeerC
	ldr r3, _020AC124 // =0x00000341
	mov r2, #0
	bl __msl_assertion_failed
_020ABFF4:
	mov r0, r5
	bl strlen
	add r1, sp, #0
	mov r2, #0
	str r2, [r1]
	str r2, [r1, #4]
	str r2, [r1, #8]
	str r2, [r1, #0xc]
	str r2, [r1, #0x10]
	str r2, [r1, #0x14]
	mov r4, r0
	ldr r2, _020AC128 // =_0211DED0
	mov r0, r8
	str r6, [sp, #0x10]
	bl sub_20A7C58
	cmp r0, #0
	addne sp, sp, #0x18
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	add r1, sp, #0
	mov r0, r8
	mov r2, r6
	bl sub_20A7C20
	cmp r0, #0
	addne sp, sp, #0x18
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r2, _020AC12C // =aLen_1
	add r1, sp, #0
	mov r0, r8
	bl sub_20A7C58
	cmp r0, #0
	addne sp, sp, #0x18
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	add r1, sp, #0
	mov r0, r8
	mov r2, r4
	bl sub_20A7C20
	cmp r0, #0
	addne sp, sp, #0x18
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r2, _020AC130 // =aMsg_1
	add r1, sp, #0
	mov r0, r8
	bl sub_20A7C58
	cmp r0, #0
	addne sp, sp, #0x18
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr ip, [sp, #8]
	add r1, sp, #0
	mov r0, r8
	mov r2, r5
	mov r3, r4
	str ip, [sp, #0x14]
	bl sub_20A7C88
	cmp r0, #0
	addne sp, sp, #0x18
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	add r1, sp, #0
	mov r0, r8
	mov r2, #0
	bl sub_20A7D90
	cmp r0, #0
	addne sp, sp, #0x18
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r7, #0x38]
	add r1, sp, #0
	bl ArrayAppend
	mov r0, #0
	bl sub_20A0510
	add r0, r0, #0x12c
	str r0, [r7, #0x10]
	mov r0, #0
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020AC118: .word aPeerNull
_020AC11C: .word aGpipeerC
_020AC120: .word aMessageNull
_020AC124: .word 0x00000341
_020AC128: .word _0211DED0
_020AC12C: .word aLen_1
_020AC130: .word aMsg_1
	arm_func_end sub_20ABFA8

	arm_func_start sub_20AC134
sub_20AC134: // 0x020AC134
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r1
	ldr r1, [r4, #0xc]
	add r2, sp, #8
	mov r5, r0
	bl sub_20AD2A4
	cmp r0, #0
	bne _020AC170
	ldr r1, _020AC2BC // =aErrorConnectin
	mov r0, r5
	bl sub_20AFBA8
	add sp, sp, #0xc
	mov r0, #3
	ldmia sp!, {r4, r5, pc}
_020AC170:
	mov r0, #2
	mov r1, #1
	mov r2, #0
	bl sub_20A0800
	str r0, [r4, #8]
	ldr r0, [r4, #8]
	mvn r1, #0
	cmp r0, r1
	bne _020AC1C0
	ldr r2, _020AC2C0 // =aThereWasAnErro_8
	mov r0, r5
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r5
	mov r1, #3
	mov r2, #0
	bl sub_20A81BC
	add sp, sp, #0xc
	mov r0, #3
	ldmia sp!, {r4, r5, pc}
_020AC1C0:
	mov r1, #0
	bl sub_20A0BC4
	cmp r0, #0
	bne _020AC1FC
	ldr r2, _020AC2C4 // =aThereWasAnErro_9
	mov r0, r5
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r5
	mov r1, #3
	mov r2, #0
	bl sub_20A81BC
	add sp, sp, #0xc
	mov r0, #3
	ldmia sp!, {r4, r5, pc}
_020AC1FC:
	ldr r0, [r4, #8]
	bl sub_20AC510
	add r1, sp, #0
	mov r0, #0
	str r0, [r1]
	str r0, [r1, #4]
	mov r0, #2
	ldr r3, [sp, #8]
	strb r0, [sp, #1]
	ldr r0, [r3, #8]
	mov r2, #8
	ldr r0, [r0, #0x10]
	str r0, [sp, #4]
	ldr r0, [r3, #8]
	ldr r0, [r0, #0x14]
	strh r0, [sp, #2]
	ldr r0, [r4, #8]
	bl sub_20A072C
	mvn r1, #0
	cmp r0, r1
	bne _020AC2A8
	ldr r0, [r4, #8]
	bl WSAGetLastError
	mvn r1, #5
	cmp r0, r1
	beq _020AC2A8
	mvn r1, #0x19
	cmp r0, r1
	beq _020AC2A8
	mvn r1, #0x4b
	cmp r0, r1
	beq _020AC2A8
	ldr r2, _020AC2C8 // =aThereWasAnErro_10
	mov r0, r5
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r5
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0xc
	mov r0, #3
	ldmia sp!, {r4, r5, pc}
_020AC2A8:
	mov r0, #0x67
	str r0, [r4]
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020AC2BC: .word aErrorConnectin
_020AC2C0: .word aThereWasAnErro_8
_020AC2C4: .word aThereWasAnErro_9
_020AC2C8: .word aThereWasAnErro_10
	arm_func_end sub_20AC134

	arm_func_start sub_20AC2CC
sub_20AC2CC: // 0x020AC2CC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r2, #0
	str r2, [sp]
	mov r4, r1
	str r2, [sp, #4]
	add r3, sp, #0xc
	mov r1, #2
	mov r5, r0
	str r2, [sp, #8]
	bl sub_20ABA48
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, pc}
	ldr r0, [sp, #0xc]
	ldr r1, [r4, #0xc]
	ldr r2, [r0, #0x18]
	mov r0, r5
	bl sub_20A9CD4
	cmp r0, #0
	moveq r0, #0x65
	streq r0, [r4]
	moveq r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20AC2CC

	arm_func_start sub_20AC330
sub_20AC330: // 0x020AC330
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r5, [r0, #0]
	mov r0, #0x40
	mov r7, r1
	mov r6, r2
	bl DWCi_GsMalloc
	movs r4, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r1, #0
	mov r2, #0x40
	bl memset
	mov r0, #0x64
	str r0, [r4]
	str r6, [r4, #4]
	mvn r0, #0
	str r0, [r4, #8]
	mov r0, #0
	str r7, [r4, #0xc]
	bl sub_20A0510
	add r0, r0, #0x12c
	str r0, [r4, #0x10]
	ldr r3, [r5, #0x434]
	ldr r2, _020AC3BC // =sub_20AC3C0
	mov r0, #0x18
	mov r1, #0
	str r3, [r4, #0x3c]
	bl sub_209FB2C
	str r0, [r4, #0x38]
	mov r0, r4
	str r4, [r5, #0x434]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020AC3BC: .word sub_20AC3C0
	arm_func_end sub_20AC330

	arm_func_start sub_20AC3C0
sub_20AC3C0: // 0x020AC3C0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20AC3C0

	arm_func_start sub_20AC3DC
sub_20AC3DC: // 0x020AC3DC
	ldr r0, [r0, #0]
	ldr r0, [r0, #0x434]
	cmp r0, #0
	beq _020AC410
_020AC3EC:
	ldr r2, [r0, #0xc]
	cmp r2, r1
	bne _020AC404
	ldr r2, [r0, #0]
	cmp r2, #0x69
	bxeq lr
_020AC404:
	ldr r0, [r0, #0x3c]
	cmp r0, #0
	bne _020AC3EC
_020AC410:
	mov r0, #0
	bx lr
	arm_func_end sub_20AC3DC

	arm_func_start sub_20AC418
sub_20AC418: // 0x020AC418
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r7, [r4, #0]
	mvn r1, #0
	ldr r0, [r7, #0x204]
	cmp r0, r1
	beq _020AC4A4
	bl sub_20A0974
	cmp r0, #0
	beq _020AC4A4
	mov r1, #0
	ldr r0, [r7, #0x204]
	mov r2, r1
	bl sub_20A06DC
	mov r6, r0
	mvn r1, #0
	cmp r6, r1
	beq _020AC4A4
	mov r0, r4
	mov r2, #0
	bl sub_20AC330
	movs r5, r0
	beq _020AC49C
	mov r0, #0x68
	str r0, [r5]
	mov r0, r6
	str r6, [r5, #8]
	mov r1, #0
	bl sub_20A0BC4
	ldr r0, [r5, #8]
	bl sub_20AC510
	b _020AC4A4
_020AC49C:
	mov r0, r6
	bl sub_20A07E4
_020AC4A4:
	ldr r6, [r7, #0x434]
	cmp r6, #0
	beq _020AC504
	mov r5, #0
_020AC4B4:
	mov r0, r4
	mov r1, r6
	ldr r7, [r6, #0x3c]
	bl sub_20AC6FC
	ldr r1, [r6, #0]
	cmp r1, #0x6a
	beq _020AC4EC
	cmp r0, #0
	bne _020AC4EC
	mov r0, r5
	bl sub_20A0510
	ldr r1, [r6, #0x10]
	cmp r0, r1
	ble _020AC4F8
_020AC4EC:
	mov r0, r4
	mov r1, r6
	bl sub_20AC588
_020AC4F8:
	mov r6, r7
	cmp r7, #0
	bne _020AC4B4
_020AC504:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20AC418

	arm_func_start sub_20AC510
sub_20AC510: // 0x020AC510
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r1, #0x4000
	bl sub_20A0B78
	mov r0, r4
	mov r1, #0x8000
	bl sub_20A0B78
	mov r0, r4
	mov r1, #0x10000
	bl sub_20A0B78
	mov r0, r4
	mov r1, #0x20000
	bl sub_20A0B78
	mov r0, r4
	mov r1, #0x40000
	bl sub_20A0B78
	mov r0, r4
	mov r1, #0x4000
	bl sub_20A0B2C
	mov r0, r4
	mov r1, #0x8000
	bl sub_20A0B2C
	mov r0, r4
	mov r1, #0x10000
	bl sub_20A0B2C
	mov r0, r4
	bl sub_20A0AE4
	mov r0, r4
	bl sub_20A0A9C
	ldmia sp!, {r4, pc}
	arm_func_end sub_20AC510

	arm_func_start sub_20AC588
sub_20AC588: // 0x020AC588
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	movs r4, r1
	ldr r6, [r5, #0]
	bne _020AC5B0
	ldr r0, _020AC684 // =aPeerNull
	ldr r1, _020AC688 // =aGpipeerC
	ldr r3, _020AC68C // =0x00000213
	mov r2, #0
	bl __msl_assertion_failed
_020AC5B0:
	ldr r1, [r6, #0x434]
	cmp r1, r4
	ldreq r0, [r4, #0x3c]
	streq r0, [r6, #0x434]
	beq _020AC614
	ldr r0, [r1, #0x3c]
	cmp r0, r4
	beq _020AC60C
_020AC5D0:
	cmp r0, #0
	bne _020AC5FC
	ldr r0, _020AC690 // =_0211DF84
	ldr r1, _020AC688 // =aGpipeerC
	ldr r3, _020AC694 // =0x00000225
	mov r2, #0
	bl __msl_assertion_failed
	ldr r1, _020AC698 // =aTriedToRemoveP
	mov r0, r5
	bl sub_20B008C
	ldmia sp!, {r4, r5, r6, pc}
_020AC5FC:
	mov r1, r0
	ldr r0, [r0, #0x3c]
	cmp r0, r4
	bne _020AC5D0
_020AC60C:
	ldr r0, [r4, #0x3c]
	str r0, [r1, #0x3c]
_020AC614:
	ldr r0, [r4, #0x38]
	bl ArrayLength
	cmp r0, #0
	beq _020AC674
	mov r6, #0
_020AC628:
	ldr r0, [r4, #0x38]
	mov r1, r6
	bl ArrayNth
	ldr r2, [r0, #0x10]
	cmp r2, #0x64
	bge _020AC658
	ldr ip, [r0]
	ldr r3, [r0, #0x14]
	ldr r1, [r4, #0xc]
	mov r0, r5
	add r3, ip, r3
	bl sub_20A681C
_020AC658:
	ldr r0, [r4, #0x38]
	mov r1, r6
	bl ArrayDeleteAt
	ldr r0, [r4, #0x38]
	bl ArrayLength
	cmp r0, #0
	bne _020AC628
_020AC674:
	mov r0, r5
	mov r1, r4
	bl sub_20AC69C
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020AC684: .word aPeerNull
_020AC688: .word aGpipeerC
_020AC68C: .word 0x00000213
_020AC690: .word _0211DF84
_020AC694: .word 0x00000225
_020AC698: .word aTriedToRemoveP
	arm_func_end sub_20AC588

	arm_func_start sub_20AC69C
sub_20AC69C: // 0x020AC69C
	stmdb sp!, {r4, lr}
	mov r4, r1
	ldr r0, [r4, #8]
	mov r1, #2
	bl sub_20A07C8
	ldr r0, [r4, #8]
	bl sub_20A07E4
	ldr r0, [r4, #0x18]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x28]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x38]
	cmp r0, #0
	beq _020AC6F0
	bl ArrayFree
	mov r0, #0
	str r0, [r4, #0x38]
_020AC6F0:
	mov r0, r4
	bl DWCi_GsFree
	ldmia sp!, {r4, pc}
	arm_func_end sub_20AC69C

	arm_func_start sub_20AC6FC
sub_20AC6FC: // 0x020AC6FC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldr r1, [r5, #0]
	mov r6, r0
	cmp r1, #0x64
	mov r4, #0
	bne _020AC72C
	ldr r0, _020AC794 // =aPeerStateGpiPe
	ldr r1, _020AC798 // =aGpipeerC
	ldr r3, _020AC79C // =0x000001D9
	mov r2, r4
	bl __msl_assertion_failed
_020AC72C:
	ldr r0, [r5, #0]
	cmp r0, #0x69
	beq _020AC768
	ldr r0, [r5, #4]
	cmp r0, #0
	beq _020AC758
	mov r0, r6
	mov r1, r5
	bl sub_20ACD44
	mov r4, r0
	b _020AC768
_020AC758:
	mov r0, r6
	mov r1, r5
	bl sub_20ACAF8
	mov r4, r0
_020AC768:
	cmp r4, #0
	bne _020AC78C
	ldr r0, [r5, #0]
	cmp r0, #0x69
	bne _020AC78C
	mov r0, r6
	mov r1, r5
	bl sub_20AC7A0
	mov r4, r0
_020AC78C:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020AC794: .word aPeerStateGpiPe
_020AC798: .word aGpipeerC
_020AC79C: .word 0x000001D9
	arm_func_end sub_20AC6FC

	arm_func_start sub_20AC7A0
sub_20AC7A0: // 0x020AC7A0
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x24
	mov r6, r1
	ldr r1, [r6, #0x30]
	mov r7, r0
	cmp r1, #0
	ldr r5, [r7, #0]
	beq _020AC808
	mov r2, #1
	str r2, [sp]
	ldr r1, _020ACA1C // =0x0211DFD4
	add r3, sp, #0xc
	str r1, [sp, #4]
	ldr r1, [r6, #8]
	add r2, r6, #0x28
	bl sub_20A7568
	ldr r1, [sp, #0xc]
	cmp r1, #0
	bne _020AC7F4
	cmp r0, #0
	beq _020AC808
_020AC7F4:
	mov r0, #0x6a
	str r0, [r6]
	add sp, sp, #0x24
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020AC808:
	ldr r0, [r6, #0x30]
	cmp r0, #0
	bne _020AC840
	mov r0, r7
	mov r1, r6
	bl sub_20ACA28
	cmp r0, #0
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r6, #0]
	cmp r0, #0x6a
	addeq sp, sp, #0x24
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020AC840:
	add r1, sp, #0xc
	ldr r0, _020ACA1C // =0x0211DFD4
	str r1, [sp]
	str r0, [sp, #4]
	ldr r1, [r6, #8]
	add r3, sp, #8
	mov r0, r7
	add r2, r6, #0x18
	bl sub_20A76E8
	cmp r0, #0
	movne r0, #0x6a
	strne r0, [r6]
	addne sp, sp, #0x24
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [sp, #8]
	cmp r0, #0
	ble _020AC898
	mov r0, #0
	bl sub_20A0510
	add r0, r0, #0x12c
	str r0, [r6, #0x10]
_020AC898:
	add r4, sp, #0x20
	add r2, sp, #0x18
	add r3, sp, #0x1c
	mov r0, r7
	add r1, r6, #0x18
	str r4, [sp]
	bl sub_20A742C
	cmp r0, #0
	addne sp, sp, #0x24
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r1, [sp, #0x18]
	cmp r1, #0
	beq _020AC9F4
	ldr r2, [sp, #0x1c]
	cmp r2, #0x66
	bgt _020AC8EC
	cmp r2, #0x66
	bge _020AC9B4
	cmp r2, #1
	beq _020AC920
	b _020AC9E8
_020AC8EC:
	sub r0, r2, #0xc8
	cmp r0, #8
	addls pc, pc, r0, lsl #2
	b _020AC9E8
_020AC8FC: // jump table
	b _020AC9CC // case 0
	b _020AC9CC // case 1
	b _020AC9CC // case 2
	b _020AC9CC // case 3
	b _020AC9CC // case 4
	b _020AC9CC // case 5
	b _020AC9CC // case 6
	b _020AC9CC // case 7
	b _020AC9CC // case 8
_020AC920:
	ldr r1, [r5, #0x1bc]
	ldr r0, [r5, #0x1c0]
	cmp r1, #0
	str r1, [sp, #0x10]
	str r0, [sp, #0x14]
	beq _020AC9E8
	mov r0, #0xc
	bl DWCi_GsMalloc
	movs r4, r0
	bne _020AC960
	ldr r1, _020ACA20 // =aOutOfMemory_6
	mov r0, r7
	bl sub_20AFBA8
	add sp, sp, #0x24
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020AC960:
	ldr r0, [r6, #0xc]
	str r0, [r4]
	ldr r0, [sp, #0x18]
	bl sub_20A0C50
	str r0, [r4, #8]
	mov r0, #0
	bl sub_20A0510
	str r0, [r4, #4]
	mov r0, #0
	str r0, [sp]
	mov r0, #2
	str r0, [sp, #4]
	add r1, sp, #0x10
	mov r0, r7
	mov r3, r4
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020AC9E8
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, pc}
_020AC9B4:
	ldr r1, [r6, #0xc]
	ldr r3, _020ACA24 // =0x0211DFE8
	mov r0, r7
	mov r2, #0x67
	bl sub_20A6720
	b _020AC9E8
_020AC9CC:
	str r1, [sp]
	ldr r1, [sp, #0x20]
	mov r0, r7
	str r1, [sp, #4]
	ldr r3, [r6, #0x18]
	mov r1, r6
	bl sub_20AF97C
_020AC9E8:
	mov r0, r7
	add r1, r6, #0x18
	bl sub_20A73C0
_020AC9F4:
	ldr r0, [sp, #0x18]
	cmp r0, #0
	bne _020AC898
	ldr r0, [sp, #0xc]
	cmp r0, #0
	movne r0, #0x6a
	strne r0, [r6]
	mov r0, #0
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020ACA1C: .word 0x0211DFD4
_020ACA20: .word aOutOfMemory_6
_020ACA24: .word 0x0211DFE8
	arm_func_end sub_20AC7A0

	arm_func_start sub_20ACA28
sub_20ACA28: // 0x020ACA28
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r8, r1
	ldr r1, [r8, #0x30]
	mov r9, r0
	cmp r1, #0
	addne sp, sp, #0xc
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r8, #0x38]
	bl ArrayLength
	cmp r0, #0
	beq _020ACAE8
	ldr r5, _020ACAF4 // =0x0211DFD4
	add r4, sp, #8
	mov r7, #0
_020ACA68:
	ldr r0, [r8, #0x38]
	mov r1, r7
	bl ArrayNth
	mov r6, r0
	str r7, [sp]
	str r5, [sp, #4]
	ldr r1, [r8, #8]
	mov r0, r9
	mov r2, r6
	mov r3, r4
	bl sub_20A7568
	ldr r1, [sp, #8]
	cmp r1, #0
	bne _020ACAA8
	cmp r0, #0
	beq _020ACABC
_020ACAA8:
	mov r0, #0x6a
	str r0, [r8]
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020ACABC:
	ldr r1, [r6, #0xc]
	ldr r0, [r6, #8]
	cmp r1, r0
	bne _020ACAE8
	ldr r0, [r8, #0x38]
	mov r1, r7
	bl ArrayDeleteAt
	ldr r0, [r8, #0x38]
	bl ArrayLength
	cmp r0, #0
	bne _020ACA68
_020ACAE8:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020ACAF4: .word 0x0211DFD4
	arm_func_end sub_20ACA28

	arm_func_start sub_20ACAF8
sub_20ACAF8: // 0x020ACAF8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x184
	mov r5, r1
	ldr r1, [r5, #0]
	mov r6, r0
	cmp r1, #0x68
	ldr r4, [r6, #0]
	beq _020ACB2C
	ldr r0, _020ACD14 // =aPeerStateGpiPe_0
	ldr r1, _020ACD18 // =aGpipeerC
	mov r2, #0
	mov r3, #0xc1
	bl __msl_assertion_failed
_020ACB2C:
	add r1, sp, #0xc
	ldr r0, _020ACD1C // =0x0211DFD4
	str r1, [sp]
	str r0, [sp, #4]
	ldr r1, [r5, #8]
	add r3, sp, #8
	mov r0, r6
	add r2, r5, #0x18
	bl sub_20A76E8
	cmp r0, #0
	addne sp, sp, #0x184
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [sp, #0xc]
	cmp r0, #0
	movne r0, #0x6a
	strne r0, [r5]
	addne sp, sp, #0x184
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r5, #0x18]
	ldr r1, _020ACD20 // =aFinal_4
	bl strstr
	cmp r0, #0
	beq _020ACD08
	mov r1, #0
	strb r1, [r0]
	ldr r7, [r5, #0x18]
	ldr r1, _020ACD24 // =aAuth
	mov r0, r7
	mov r2, #6
	bl strncmp
	cmp r0, #0
	bne _020ACCEC
	ldr r1, _020ACD28 // =aPid_1
	add r2, sp, #0x10
	mov r0, r7
	mov r3, #0x10
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0x6a
	streq r0, [r5]
	addeq sp, sp, #0x184
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	add r0, sp, #0x10
	bl atoi
	mov r7, r0
	ldr r0, [r5, #0x18]
	ldr r1, _020ACD2C // =aNick_1
	add r2, sp, #0x20
	mov r3, #0x1f
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0x6a
	streq r0, [r5]
	addeq sp, sp, #0x184
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r5, #0x18]
	ldr r1, _020ACD30 // =aSig_1
	add r2, sp, #0x3f
	mov r3, #0x21
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0x6a
	streq r0, [r5]
	addeq sp, sp, #0x184
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	str r7, [sp]
	ldr r2, _020ACD34 // =0x00000177
	ldr r3, [r4, #0x1a0]
	ldr r1, _020ACD38 // =aSDD
	add r0, sp, #0x81
	add r2, r4, r2
	bl sprintf
	add r0, sp, #0x81
	bl strlen
	mov r1, r0
	add r0, sp, #0x81
	add r2, sp, #0x60
	bl sub_20A01DC
	add r0, sp, #0x3f
	add r1, sp, #0x60
	bl strcmp
	cmp r0, #0
	beq _020ACCBC
	ldr r2, _020ACD3C // =aAnack
	mov r0, r6
	add r1, r5, #0x28
	bl sub_20A7C58
	ldr r2, _020ACD20 // =aFinal_4
	mov r0, r6
	add r1, r5, #0x28
	bl sub_20A7C58
	mov r0, #0x6a
	str r0, [r5]
	add sp, sp, #0x184
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ACCBC:
	ldr r2, _020ACD40 // =aAack
	mov r0, r6
	add r1, r5, #0x28
	bl sub_20A7C58
	ldr r2, _020ACD20 // =aFinal_4
	mov r0, r6
	add r1, r5, #0x28
	bl sub_20A7C58
	mov r0, #0x69
	str r0, [r5]
	str r7, [r5, #0xc]
	b _020ACD00
_020ACCEC:
	mov r0, #0x6a
	str r0, [r5]
	add sp, sp, #0x184
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ACD00:
	mov r0, #0
	str r0, [r5, #0x20]
_020ACD08:
	mov r0, #0
	add sp, sp, #0x184
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020ACD14: .word aPeerStateGpiPe_0
_020ACD18: .word aGpipeerC
_020ACD1C: .word 0x0211DFD4
_020ACD20: .word aFinal_4
_020ACD24: .word aAuth
_020ACD28: .word aPid_1
_020ACD2C: .word aNick_1
_020ACD30: .word aSig_1
_020ACD34: .word 0x00000177
_020ACD38: .word aSDD
_020ACD3C: .word aAnack
_020ACD40: .word aAack
	arm_func_end sub_20ACAF8

	arm_func_start sub_20ACD44
sub_20ACD44: // 0x020ACD44
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r6, r1
	ldr r2, [r6, #0]
	mov r7, r0
	sub r2, r2, #0x65
	ldr r5, [r7, #0]
	cmp r2, #3
	addls pc, pc, r2, lsl #2
	b _020AD008
_020ACD6C: // jump table
	b _020AD01C // case 0
	b _020ACD7C // case 1
	b _020ACD90 // case 2
	b _020ACF14 // case 3
_020ACD7C:
	bl sub_20AC134
	cmp r0, #0
	beq _020AD01C
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ACD90:
	ldr r1, [r6, #8]
	add r2, sp, #8
	bl sub_20AFDB8
	cmp r0, #0
	addne sp, sp, #0x1c
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [sp, #8]
	cmp r0, #4
	bne _020ACDCC
	ldr r1, _020AD074 // =aErrorConnectin
	mov r0, r7
	bl sub_20AFBA8
	add sp, sp, #0x1c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ACDCC:
	cmp r0, #3
	bne _020AD01C
	ldr r1, [r6, #0xc]
	add r2, sp, #0x14
	mov r0, r7
	mov r4, #1
	bl sub_20AD2A4
	cmp r0, #0
	bne _020ACE08
	ldr r1, _020AD074 // =aErrorConnectin
	mov r0, r7
	bl sub_20AFBA8
	add sp, sp, #0x1c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ACE08:
	ldr r2, _020AD078 // =aAuth
	mov r0, r7
	add r1, r6, #0x28
	bl sub_20A7C58
	ldr r2, _020AD07C // =aPid_1
	mov r0, r7
	add r1, r6, #0x28
	bl sub_20A7C58
	ldr r2, [r5, #0x1a0]
	mov r0, r7
	add r1, r6, #0x28
	bl sub_20A7C20
	ldr r2, _020AD080 // =aNick_1
	mov r0, r7
	add r1, r6, #0x28
	bl sub_20A7C58
	mov r0, r7
	add r1, r6, #0x28
	add r2, r5, #0x110
	bl sub_20A7C58
	mov r0, r7
	add r1, r6, #0x28
	ldr r2, _020AD084 // =aSig_1
	bl sub_20A7C58
	mov r0, r7
	add r1, r6, #0x28
	ldr r2, [sp, #0x14]
	ldr r2, [r2, #0x18]
	bl sub_20A7C58
	mov r0, r7
	add r1, r6, #0x28
	ldr r2, _020AD088 // =aFinal_4
	bl sub_20A7C58
	ldr r3, [r5, #0x434]
	cmp r3, #0
	beq _020ACECC
	ldr r2, [r6, #0xc]
	mov r0, #0
_020ACEA0:
	ldr r1, [r3, #0xc]
	cmp r1, r2
	bne _020ACEC0
	cmp r3, r6
	beq _020ACEC0
	ldr r1, [r3, #0]
	cmp r1, #0x67
	movle r4, r0
_020ACEC0:
	ldr r3, [r3, #0x3c]
	cmp r3, #0
	bne _020ACEA0
_020ACECC:
	cmp r4, #0
	beq _020ACF08
	ldr r0, [sp, #0x14]
	ldr r0, [r0, #0x18]
	bl DWCi_GsFree
	ldr r0, [sp, #0x14]
	mov r1, #0
	str r1, [r0, #0x18]
	ldr r0, [sp, #0x14]
	bl sub_20AD0A8
	cmp r0, #0
	beq _020ACF08
	ldr r1, [sp, #0x14]
	mov r0, r7
	bl sub_20AD25C
_020ACF08:
	mov r0, #0x68
	str r0, [r6]
	b _020AD01C
_020ACF14:
	add r2, sp, #0x10
	str r2, [sp]
	ldr r1, _020AD08C // =0x0211DFD4
	add r3, sp, #0xc
	str r1, [sp, #4]
	ldr r1, [r6, #8]
	add r2, r6, #0x18
	bl sub_20A76E8
	cmp r0, #0
	addne sp, sp, #0x1c
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r6, #0x18]
	ldr r1, _020AD088 // =aFinal_4
	bl strstr
	cmp r0, #0
	beq _020AD01C
	mov r1, #0
	strb r1, [r0]
	ldr r4, [r6, #0x18]
	ldr r1, _020AD090 // =aAnack
	mov r0, r4
	mov r2, #7
	bl strncmp
	cmp r0, #0
	bne _020ACFC4
	ldr r0, [r6, #0x14]
	add r0, r0, #1
	str r0, [r6, #0x14]
	ldr r0, [r6, #0x14]
	cmp r0, #1
	ble _020ACFA8
	ldr r1, _020AD094 // =aErrorGettingBu
	mov r0, r7
	bl sub_20AFBA8
	add sp, sp, #0x1c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ACFA8:
	mov r0, r7
	mov r1, r6
	bl sub_20AC2CC
	cmp r0, #0
	beq _020ACFF4
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ACFC4:
	ldr r1, _020AD098 // =aAack
	mov r0, r4
	mov r2, #6
	bl strncmp
	cmp r0, #0
	beq _020ACFF4
	ldr r1, _020AD09C // =aErrorParsingBu
	mov r0, r7
	bl sub_20AFBA8
	add sp, sp, #0x1c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, pc}
_020ACFF4:
	mov r0, #0x69
	str r0, [r6]
	mov r0, #0
	str r0, [r6, #0x20]
	b _020AD01C
_020AD008:
	ldr r0, _020AD0A0 // =_0211DF84
	ldr r1, _020AD0A4 // =aGpipeerC
	mov r2, #0
	mov r3, #0x9f
	bl __msl_assertion_failed
_020AD01C:
	ldr r0, [r6, #0x30]
	cmp r0, #0
	ble _020AD068
	mov r1, #1
	ldr r0, _020AD08C // =0x0211DFD4
	str r1, [sp]
	str r0, [sp, #4]
	ldr r1, [r6, #8]
	add r3, sp, #0x10
	mov r0, r7
	add r2, r6, #0x28
	bl sub_20A7568
	ldr r1, [sp, #0x10]
	cmp r1, #0
	bne _020AD060
	cmp r0, #0
	beq _020AD068
_020AD060:
	mov r0, #0x6a
	str r0, [r6]
_020AD068:
	mov r0, #0
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020AD074: .word aErrorConnectin
_020AD078: .word aAuth
_020AD07C: .word aPid_1
_020AD080: .word aNick_1
_020AD084: .word aSig_1
_020AD088: .word aFinal_4
_020AD08C: .word 0x0211DFD4
_020AD090: .word aAnack
_020AD094: .word aErrorGettingBu
_020AD098: .word aAack
_020AD09C: .word aErrorParsingBu
_020AD0A0: .word _0211DF84
_020AD0A4: .word aGpipeerC
	arm_func_end sub_20ACD44

	arm_func_start sub_20AD0A8
sub_20AD0A8: // 0x020AD0A8
	cmp r0, #0
	beq _020AD0E4
	ldr r1, [r0, #0xc]
	cmp r1, #0
	bne _020AD0E4
	ldr r1, [r0, #8]
	cmp r1, #0
	bne _020AD0E4
	ldr r1, [r0, #0x18]
	cmp r1, #0
	bne _020AD0E4
	ldr r0, [r0, #0x10]
	cmp r0, #0
	moveq r0, #1
	bxeq lr
_020AD0E4:
	mov r0, #0
	bx lr
	arm_func_end sub_20AD0A8

	arm_func_start sub_20AD0EC
sub_20AD0EC: // 0x020AD0EC
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	str r1, [sp]
	mov r3, #0
	ldr r1, _020AD118 // =sub_20AD11C
	add r2, sp, #0
	str r3, [sp, #4]
	bl sub_20AD148
	ldr r0, [sp, #4]
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_020AD118: .word sub_20AD11C
	arm_func_end sub_20AD0EC

	arm_func_start sub_20AD11C
sub_20AD11C: // 0x020AD11C
	ldr r0, [r1, #8]
	cmp r0, #0
	beq _020AD140
	ldr r3, [r2, #0]
	ldr r0, [r0, #0]
	cmp r3, r0
	streq r1, [r2, #4]
	moveq r0, #0
	bxeq lr
_020AD140:
	mov r0, #1
	bx lr
	arm_func_end sub_20AD11C

	arm_func_start sub_20AD148
sub_20AD148: // 0x020AD148
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r3, [r0, #0]
	str r1, [sp, #4]
	str r2, [sp, #8]
	str r0, [sp]
	ldr r0, [r3, #0x428]
	ldr r1, _020AD184 // =sub_20AD188
	add r2, sp, #0
	bl TableMapSafe2
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_020AD184: .word sub_20AD188
	arm_func_end sub_20AD148

	arm_func_start sub_20AD188
sub_20AD188: // 0x020AD188
	stmdb sp!, {lr}
	sub sp, sp, #4
	mov ip, r0
	ldr r0, [r1, #0]
	ldr r2, [r1, #8]
	ldr r3, [r1, #4]
	mov r1, ip
	blx r3
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20AD188

	arm_func_start sub_20AD1B0
sub_20AD1B0: // 0x020AD1B0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x10
	str r1, [sp]
	mov ip, #0
	str r2, [sp, #4]
	mov r4, r3
	ldr r1, _020AD1F8 // =sub_20AD1FC
	add r2, sp, #0
	str ip, [sp, #0xc]
	str r4, [sp, #8]
	bl sub_20AD148
	ldr r0, [sp, #0xc]
	cmp r0, #0
	moveq r0, #0
	streq r0, [r4]
	mov r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, pc}
	.align 2, 0
_020AD1F8: .word sub_20AD1FC
	arm_func_end sub_20AD1B0

	arm_func_start sub_20AD1FC
sub_20AD1FC: // 0x020AD1FC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	ldr r4, [r6, #0xc]
	mov r5, r2
	cmp r4, #0
	beq _020AD254
	ldr r0, [r5, #0]
	ldr r1, [r4, #0]
	bl strcmp
	cmp r0, #0
	bne _020AD254
	ldr r0, [r5, #4]
	ldr r1, [r4, #8]
	bl strcmp
	cmp r0, #0
	bne _020AD254
	ldr r1, [r5, #8]
	mov r0, #1
	str r6, [r1]
	str r0, [r5, #0xc]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020AD254:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20AD1FC

	arm_func_start sub_20AD25C
sub_20AD25C: // 0x020AD25C
	ldr r0, [r0, #0]
	ldr ip, _020AD26C // =TableRemove
	ldr r0, [r0, #0x428]
	bx ip
	.align 2, 0
_020AD26C: .word TableRemove
	arm_func_end sub_20AD25C

	arm_func_start sub_20AD270
sub_20AD270: // 0x020AD270
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	add r2, sp, #0
	ldr r4, [r0, #0]
	bl sub_20AD2A4
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x428]
	ldr r1, [sp]
	bl TableRemove
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end sub_20AD270

	arm_func_start sub_20AD2A4
sub_20AD2A4: // 0x020AD2A4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x20
	ldr r0, [r0, #0]
	mov r4, r2
	str r1, [sp]
	ldr r0, [r0, #0x428]
	add r1, sp, #0
	bl TableLookup
	cmp r4, #0
	strne r0, [r4]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x20
	ldmia sp!, {r4, pc}
	arm_func_end sub_20AD2A4

	arm_func_start sub_20AD2E0
sub_20AD2E0: // 0x020AD2E0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r5, r0
	ldr r2, [r5, #0]
	ldr r0, _020AD3BC // =0x00000428
	mov r4, r1
	cmp r4, #0
	add r6, r2, r0
	bgt _020AD318
	ldr r0, _020AD3C0 // =aId0
	ldr r1, _020AD3C4 // =aGpiprofileC
	ldr r3, _020AD3C8 // =0x000002B5
	mov r2, #0
	bl __msl_assertion_failed
_020AD318:
	cmp r4, #0
	addle sp, sp, #0x20
	movle r0, #0
	ldmleia sp!, {r4, r5, r6, pc}
	add r2, sp, #0
	mov r0, r5
	mov r1, r4
	bl sub_20AD2A4
	cmp r0, #0
	ldrne r0, [sp]
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
	add r1, sp, #4
	mov r0, #0
	str r0, [r1]
	str r0, [r1, #4]
	str r0, [r1, #8]
	str r0, [r1, #0xc]
	str r0, [r1, #0x10]
	str r0, [r1, #0x14]
	str r0, [r1, #0x18]
	str r4, [sp, #4]
	str r0, [sp, #8]
	str r0, [sp, #0x10]
	str r0, [sp, #0x14]
	str r0, [sp, #0x1c]
	str r0, [sp, #0x18]
	ldr r0, [r6, #0]
	bl TableEnter
	ldr r0, [r6, #4]
	add r2, sp, #0
	add r3, r0, #1
	mov r0, r5
	mov r1, r4
	str r3, [r6, #4]
	bl sub_20AD2A4
	cmp r0, #0
	ldrne r0, [sp]
	moveq r0, #0
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020AD3BC: .word 0x00000428
_020AD3C0: .word aId0
_020AD3C4: .word aGpiprofileC
_020AD3C8: .word 0x000002B5
	arm_func_end sub_20AD2E0

	arm_func_start sub_20AD3CC
sub_20AD3CC: // 0x020AD3CC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	mov r6, r2
	mov r4, r1
	mov r1, r6
	mov r2, #1
	mov r5, r0
	bl sub_20AFFB4
	cmp r0, #0
	addne sp, sp, #0x20
	movne r0, #4
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, _020AD51C // =aNpr
	mov r0, r6
	mov r2, #5
	bl strncmp
	cmp r0, #0
	beq _020AD440
	ldr r2, _020AD520 // =aUnexpectedData_2
	mov r0, r5
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r5
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x20
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020AD440:
	ldr r1, _020AD524 // =aProfileid_1
	add r2, sp, #0x10
	mov r0, r6
	mov r3, #0x10
	bl sub_20AFEAC
	cmp r0, #0
	bne _020AD488
	ldr r2, _020AD520 // =aUnexpectedData_2
	mov r0, r5
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r5
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x20
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020AD488:
	add r0, sp, #0x10
	bl atoi
	ldr r2, [r4, #0xc]
	ldr r1, [r4, #0x10]
	mov r6, r0
	str r2, [sp, #8]
	str r1, [sp, #0xc]
	cmp r2, #0
	beq _020AD504
	mov r0, #8
	bl DWCi_GsMalloc
	movs r3, r0
	bne _020AD4D4
	ldr r1, _020AD528 // =aOutOfMemory_7
	mov r0, r5
	bl sub_20AFBA8
	add sp, sp, #0x20
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_020AD4D4:
	str r6, [r3, #4]
	mov r0, #0
	str r0, [r3]
	str r4, [sp]
	str r0, [sp, #4]
	add r1, sp, #8
	mov r0, r5
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
_020AD504:
	mov r0, r5
	mov r1, r4
	bl sub_20AB940
	mov r0, #0
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020AD51C: .word aNpr
_020AD520: .word aUnexpectedData_2
_020AD524: .word aProfileid_1
_020AD528: .word aOutOfMemory_7
	arm_func_end sub_20AD3CC

	arm_func_start sub_20AD52C
sub_20AD52C: // 0x020AD52C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r4, [r0, #0]
	mov r1, #0
	str r1, [r4, #0x430]
	str r1, [r4, #0x42c]
	ldr r0, _020AD57C // =sub_20AD588
	ldr r2, _020AD580 // =sub_20AD614
	str r0, [sp]
	ldr r3, _020AD584 // =sub_20AD604
	mov r0, #0x1c
	mov r1, #4
	bl TableNew
	str r0, [r4, #0x428]
	ldr r0, [r4, #0x428]
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020AD57C: .word sub_20AD588
_020AD580: .word sub_20AD614
_020AD584: .word sub_20AD604
	arm_func_end sub_20AD52C

	arm_func_start sub_20AD588
sub_20AD588: // 0x020AD588
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #8]
	cmp r0, #0
	beq _020AD5D8
	ldr r0, [r0, #8]
	bl DWCi_GsFree
	ldr r0, [r4, #8]
	mov r1, #0
	str r1, [r0, #8]
	ldr r0, [r4, #8]
	ldr r0, [r0, #0xc]
	bl DWCi_GsFree
	ldr r0, [r4, #8]
	mov r1, #0
	str r1, [r0, #0xc]
	ldr r0, [r4, #8]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #8]
_020AD5D8:
	mov r0, r4
	bl sub_20A9978
	ldr r0, [r4, #0x10]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x10]
	ldr r0, [r4, #0x18]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r4, #0x18]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20AD588

	arm_func_start sub_20AD604
sub_20AD604: // 0x020AD604
	ldr r2, [r0, #0]
	ldr r0, [r1, #0]
	sub r0, r2, r0
	bx lr
	arm_func_end sub_20AD604

	arm_func_start sub_20AD614
sub_20AD614: // 0x020AD614
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0, #0]
	bl _s32_div_f
	mov r0, r1
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20AD614

	arm_func_start sub_20AD630
sub_20AD630: // 0x020AD630
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	ldr r9, [r10, #0]
	mov r6, #0
	ldr r0, [r9, #0x210]
	cmp r0, #0
	ble _020AD770
	mov r0, r0, lsl #2
	bl DWCi_GsMalloc
	movs r8, r0
	bne _020AD678
	ldr r1, _020AD77C // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AD678:
	ldr r7, [r9, #0x424]
	cmp r7, #0
	beq _020AD6F4
	ldr r11, _020AD780 // =aNumIconnection
	mov r5, r6
	mov r4, #1
_020AD690:
	ldr r0, [r7, #0]
	cmp r0, #3
	bne _020AD6E8
	ldr r0, [r7, #0x14]
	cmp r0, #5
	beq _020AD6E8
	ldr r0, [r7, #4]
	ldr r0, [r0, #0x13c]
	cmp r0, #0
	bne _020AD6E8
	ldr r0, [r9, #0x210]
	cmp r6, r0
	blt _020AD6D8
	ldr r1, _020AD784 // =aGpisearchC
	ldr r3, _020AD788 // =0x00000563
	mov r0, r11
	mov r2, r5
	bl __msl_assertion_failed
_020AD6D8:
	str r7, [r8, r6, lsl #2]
	ldr r0, [r7, #4]
	add r6, r6, #1
	str r4, [r0, #0x13c]
_020AD6E8:
	ldr r7, [r7, #0x20]
	cmp r7, #0
	bne _020AD690
_020AD6F4:
	cmp r6, #0
	mov r4, #0
	ble _020AD724
_020AD700:
	ldr r1, [r8, r4, lsl #2]
	mov r0, r10
	bl sub_20AD78C
	cmp r0, #0
	ldrne r1, [r8, r4, lsl #2]
	add r4, r4, #1
	strne r0, [r1, #0x1c]
	cmp r4, r6
	blt _020AD700
_020AD724:
	cmp r6, #0
	mov r4, #0
	ble _020AD768
	mov r5, r4
_020AD734:
	ldr r0, [r8, r4, lsl #2]
	mov r1, r4, lsl #2
	ldr r0, [r0, #4]
	str r5, [r0, #0x13c]
	ldr r0, [r0, #0x140]
	cmp r0, #0
	beq _020AD75C
	ldr r1, [r8, r1]
	mov r0, r10
	bl sub_20AB940
_020AD75C:
	add r4, r4, #1
	cmp r4, r6
	blt _020AD734
_020AD768:
	mov r0, r8
	bl DWCi_GsFree
_020AD770:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020AD77C: .word aOutOfMemory_8
_020AD780: .word aNumIconnection
_020AD784: .word aGpisearchC
_020AD788: .word 0x00000563
	arm_func_end sub_20AD630

	arm_func_start sub_20AD78C
sub_20AD78C: // 0x020AD78C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr ip, _020AE670 // =0x000004EC
	sub sp, sp, ip
	mov r10, r0
	ldr r0, [r10, #0]
	str r1, [sp, #0x1c]
	ldr r1, [r1, #8]
	str r0, [sp, #0x24]
	ldr r0, [sp, #0x1c]
	cmp r1, #0
	movne r4, #1
	ldr r9, [r0, #4]
	moveq r4, #0
_020AD7C0:
	mov r1, #1
	ldr r0, _020AE674 // =_0211E178
	str r1, [sp]
	str r0, [sp, #4]
	ldr r1, [r9, #4]
	add r3, sp, #0xa0
	mov r0, r10
	add r2, r9, #0x18
	bl sub_20A7568
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x1c]
	ldr r0, [r0, #0x14]
	cmp r0, #1
	bne _020ADE30
	ldr r1, [r9, #4]
	add r2, sp, #0x8c
	mov r0, r10
	bl sub_20AFDB8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [sp, #0x8c]
	cmp r0, #4
	bne _020AD860
	ldr r1, _020AE678 // =0x00000D01
	ldr r2, _020AE67C // =aCouldNotConnec
	mov r0, r10
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #4
	mov r2, #0
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #4
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AD860:
	cmp r0, #3
	bne _020AF3C0
	ldr r0, [r9, #0]
	cmp r0, #1
	bne _020ADA28
	ldr r2, _020AE680 // =aSearch
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, _020AE684 // =aSesskey_2
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r0, [sp, #0x24]
	add r1, r9, #0x18
	ldr r2, [r0, #0x198]
	mov r0, r10
	bl sub_20A7C20
	ldr r2, _020AE688 // =aProfileid_2
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [sp, #0x24]
	mov r0, r10
	ldr r2, [r2, #0x1a0]
	add r1, r9, #0x18
	bl sub_20A7C20
	ldr r2, _020AE68C // =aNamespaceid_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [sp, #0x24]
	mov r0, r10
	ldr r2, [r2, #0x470]
	add r1, r9, #0x18
	bl sub_20A7C20
	ldrsb r0, [r9, #0x28]
	cmp r0, #0
	beq _020AD91C
	ldr r2, _020AE690 // =aNick_2
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x28
	bl sub_20A7C58
_020AD91C:
	ldrsb r0, [r9, #0x47]
	cmp r0, #0
	beq _020AD948
	ldr r2, _020AE694 // =aUniquenick_1
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x47
	bl sub_20A7C58
_020AD948:
	ldrsb r0, [r9, #0x5c]
	cmp r0, #0
	beq _020AD974
	ldr r2, _020AE698 // =aEmail_1
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x5c
	bl sub_20A7C58
_020AD974:
	ldrsb r0, [r9, #0x8f]
	cmp r0, #0
	beq _020AD9A0
	ldr r2, _020AE69C // =aFirstname_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x8f
	bl sub_20A7C58
_020AD9A0:
	ldrsb r0, [r9, #0xae]
	cmp r0, #0
	beq _020AD9CC
	ldr r2, _020AE6A0 // =aLastname_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0xae
	bl sub_20A7C58
_020AD9CC:
	ldr r0, [r9, #0x130]
	cmp r0, #0
	beq _020AD9F8
	ldr r2, _020AE6A4 // =aIcquin_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [r9, #0x130]
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C20
_020AD9F8:
	ldr r0, [r9, #0x134]
	cmp r0, #0
	ble _020ADDF0
	ldr r2, _020AE6A8 // =aSkip
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [r9, #0x134]
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C20
	b _020ADDF0
_020ADA28:
	cmp r0, #2
	bne _020ADA64
	ldr r2, _020AE6AC // =aValid
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, _020AE698 // =aEmail_1
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x5c
	bl sub_20A7C58
	b _020ADDF0
_020ADA64:
	cmp r0, #3
	bne _020ADAE4
	ldr r2, _020AE6B0 // =aNicks
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, _020AE698 // =aEmail_1
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x5c
	bl sub_20A7C58
	ldr r2, _020AE6B4 // =aPass
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0xcd
	bl sub_20A7C58
	ldr r2, _020AE68C // =aNamespaceid_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [sp, #0x24]
	mov r0, r10
	ldr r2, [r2, #0x470]
	add r1, r9, #0x18
	bl sub_20A7C20
	b _020ADDF0
_020ADAE4:
	cmp r0, #4
	bne _020ADB68
	ldr r2, _020AE6B8 // =aPmatch
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, _020AE684 // =aSesskey_2
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r0, [sp, #0x24]
	add r1, r9, #0x18
	ldr r2, [r0, #0x198]
	mov r0, r10
	bl sub_20A7C20
	ldr r2, _020AE688 // =aProfileid_2
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [sp, #0x24]
	mov r0, r10
	ldr r2, [r2, #0x1a0]
	add r1, r9, #0x18
	bl sub_20A7C20
	ldr r2, _020AE6BC // =aProductid_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [r9, #0x138]
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C20
	b _020ADDF0
_020ADB68:
	cmp r0, #5
	bne _020ADBE4
	ldr r2, _020AE6C0 // =aCheck
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, _020AE690 // =aNick_2
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x28
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	ldr r2, _020AE698 // =aEmail_1
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x5c
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	ldr r2, _020AE6B4 // =aPass
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0xcd
	bl sub_20A7C58
	b _020ADDF0
_020ADBE4:
	cmp r0, #6
	bne _020ADCF4
	ldr r2, _020AE6C4 // =aNewuser_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, _020AE690 // =aNick_2
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x28
	bl sub_20A7C58
	ldr r2, _020AE698 // =aEmail_1
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x5c
	bl sub_20A7C58
	ldr r2, _020AE6B4 // =aPass
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0xcd
	bl sub_20A7C58
	ldr r2, _020AE6C8 // =aProductid_1
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [sp, #0x24]
	mov r0, r10
	ldr r2, [r2, #0x46c]
	add r1, r9, #0x18
	bl sub_20A7C20
	ldr r2, _020AE68C // =aNamespaceid_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [sp, #0x24]
	mov r0, r10
	ldr r2, [r2, #0x470]
	add r1, r9, #0x18
	bl sub_20A7C20
	ldr r2, _020AE694 // =aUniquenick_1
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x47
	bl sub_20A7C58
	ldrsb r0, [r9, #0xec]
	cmp r0, #0
	beq _020ADDF0
	ldr r2, _020AE6CC // =aCdkey
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0xec
	bl sub_20A7C58
	b _020ADDF0
_020ADCF4:
	cmp r0, #7
	bne _020ADD7C
	ldr r2, _020AE6D0 // =aOthers
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, _020AE684 // =aSesskey_2
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r0, [sp, #0x24]
	add r1, r9, #0x18
	ldr r2, [r0, #0x198]
	mov r0, r10
	bl sub_20A7C20
	ldr r2, _020AE688 // =aProfileid_2
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [sp, #0x24]
	mov r0, r10
	ldr r2, [r2, #0x1a0]
	add r1, r9, #0x18
	bl sub_20A7C20
	ldr r2, _020AE68C // =aNamespaceid_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [sp, #0x24]
	mov r0, r10
	ldr r2, [r2, #0x470]
	add r1, r9, #0x18
	bl sub_20A7C20
	b _020ADDF0
_020ADD7C:
	cmp r0, #8
	bne _020ADDDC
	ldr r2, _020AE6D4 // =aUniquesearch
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, _020AE6D8 // =aPreferrednick
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	mov r0, r10
	add r1, r9, #0x18
	add r2, r9, #0x47
	bl sub_20A7C58
	ldr r2, _020AE68C // =aNamespaceid_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, [sp, #0x24]
	mov r0, r10
	ldr r2, [r2, #0x470]
	add r1, r9, #0x18
	bl sub_20A7C20
	b _020ADDF0
_020ADDDC:
	ldr r0, _020AE6DC // =_0211E2AC
	ldr r1, _020AE6E0 // =aGpisearchC
	ldr r3, _020AE6E4 // =0x00000275
	mov r2, #0
	bl __msl_assertion_failed
_020ADDF0:
	ldr r2, _020AE6E8 // =aGamename_0
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, _020AE6EC // =0x02144D64
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r2, _020AE6F0 // =aFinal_5
	mov r0, r10
	add r1, r9, #0x18
	bl sub_20A7C58
	ldr r0, [sp, #0x1c]
	mov r1, #4
	str r1, [r0, #0x14]
	b _020AF3C0
_020ADE30:
	cmp r0, #4
	bne _020AF3C0
	add r1, sp, #0xa0
	ldr r0, _020AE674 // =_0211E178
	str r1, [sp]
	str r0, [sp, #4]
	ldr r1, [r9, #4]
	add r3, sp, #0x9c
	mov r0, r10
	add r2, r9, #8
	bl sub_20A76E8
	cmp r0, #0
	beq _020ADEA4
	cmp r0, #3
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AE678 // =0x00000D01
	ldr r2, _020AE6F4 // =aThereWasAnErro_11
	mov r0, r10
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #0
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020ADEA4:
	ldr r0, [r9, #8]
	ldr r1, _020AE6F0 // =aFinal_5
	bl strstr
	cmp r0, #0
	beq _020AF3C0
	mov r0, #0
	str r0, [sp, #0x90]
	ldr r0, [sp, #0x1c]
	mov r1, #5
	str r1, [r0, #0x14]
	ldr r1, [r9, #8]
	mov r0, r10
	mov r2, #1
	bl sub_20AFFB4
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	movne r0, #1
	strne r0, [r9, #0x140]
	addne sp, sp, ip
	movne r0, #4
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r9, #0]
	cmp r0, #1
	bne _020AE2BC
	mov r0, #0
	str r0, [sp, #0x20]
	str r0, [sp, #0xdc]
	str r0, [sp, #0xe0]
	str r0, [sp, #0xe8]
	mov r0, #1
	str r0, [sp, #0x3c]
	mov r0, #0x33
	str r0, [sp, #0x50]
	mov r0, #0x15
	str r0, [sp, #0x4c]
	mov r0, #0x600
	str r0, [sp, #0x38]
	ldr r0, [sp, #0x20]
	ldr r1, _020AE6F8 // =0x00000601
	str r0, [sp, #0x40]
	mov r0, #0xac
	str r0, [sp, #0x44]
	ldr r0, [sp, #0x20]
	str r1, [sp, #0xe4]
	add r5, sp, #0xec
	add r6, sp, #0x2ec
	mov r4, #0x1f
	str r0, [sp, #0x48]
_020ADF64:
	str r6, [sp]
	ldr r1, [r9, #8]
	mov r0, r10
	add r2, sp, #0x90
	mov r3, r5
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AE6FC // =aBsrdone
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AE000
	str r6, [sp]
	ldr r1, [r9, #8]
	mov r0, r10
	add r2, sp, #0x90
	mov r3, r5
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AE700 // =_0211E2F8
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020ADFF4
	ldr r1, _020AE6DC // =_0211E2AC
	mov r0, r6
	bl strcmp
	cmp r0, #0
	ldrne r0, [sp, #0x38]
	strne r0, [sp, #0xe4]
_020ADFF4:
	ldr r0, [sp, #0x3c]
	str r0, [sp, #0x20]
	b _020AE1EC
_020AE000:
	ldr r1, _020AE704 // =0x0211E300
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AE1BC
	ldr r1, [sp, #0xe0]
	ldr r0, [sp, #0xe8]
	add r2, r1, #1
	mov r1, #0xac
	mul r1, r2, r1
	str r2, [sp, #0xe0]
	bl DWCi_GsRealloc
	movs r8, r0
	str r8, [sp, #0xe8]
	bne _020AE058
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE058:
	ldr r1, [sp, #0xe0]
	mov r0, #0xac
	sub r1, r1, #1
	mul r11, r1, r0
	add r7, r8, r11
	ldr r1, [sp, #0x40]
	ldr r2, [sp, #0x44]
	mov r0, r7
	bl memset
	mov r0, r6
	bl atoi
	str r0, [r8, r11]
	ldr r8, [sp, #0x48]
_020AE08C:
	ldr r11, [sp, #0x90]
	mov r0, r10
	str r6, [sp]
	ldr r1, [r9, #8]
	add r2, sp, #0x90
	mov r3, r5
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AE70C // =0x0211E304
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AE0E0
	add r0, r7, #4
	mov r1, r6
	mov r2, r4
	bl sub_20B0098
	b _020AE1B0
_020AE0E0:
	ldr r1, _020AE710 // =aUniquenick_2
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AE108
	ldr r2, [sp, #0x4c]
	add r0, r7, #0x23
	mov r1, r6
	bl sub_20B0098
	b _020AE1B0
_020AE108:
	ldr r1, _020AE714 // =aFirstname_1
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AE130
	add r0, r7, #0x38
	mov r1, r6
	mov r2, r4
	bl sub_20B0098
	b _020AE1B0
_020AE130:
	ldr r1, _020AE718 // =aLastname_1
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AE158
	add r0, r7, #0x57
	mov r1, r6
	mov r2, r4
	bl sub_20B0098
	b _020AE1B0
_020AE158:
	ldr r1, _020AE71C // =aEmail_2
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AE180
	ldr r2, [sp, #0x50]
	add r0, r7, #0x76
	mov r1, r6
	bl sub_20B0098
	b _020AE1B0
_020AE180:
	ldr r1, _020AE704 // =0x0211E300
	mov r0, r5
	bl strcmp
	cmp r0, #0
	beq _020AE1A8
	ldr r1, _020AE6FC // =aBsrdone
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AE1B0
_020AE1A8:
	ldr r8, [sp, #0x3c]
	str r11, [sp, #0x90]
_020AE1B0:
	cmp r8, #0
	beq _020AE08C
	b _020AE1EC
_020AE1BC:
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE1EC:
	ldr r0, [sp, #0x20]
	cmp r0, #0
	beq _020ADF64
	ldr r0, [sp, #0x1c]
	ldr r4, [sp, #0xe4]
	ldr r3, [r0, #0xc]
	ldr r2, [r0, #0x10]
	cmp r3, #0
	str r3, [sp, #0x94]
	str r2, [sp, #0x98]
	beq _020AE224
	add r1, sp, #0xdc
	mov r0, r10
	blx r3
_020AE224:
	cmp r4, #0x600
	bne _020AE2A8
	ldr r0, [sp, #0xe4]
	cmp r0, #0x600
	bne _020AE2A8
	add r0, r9, #0x8f
	str r0, [sp]
	add r0, r9, #0xae
	str r0, [sp, #4]
	ldr r1, [r9, #0x130]
	mov r0, r10
	str r1, [sp, #8]
	ldr r3, [sp, #0xe0]
	ldr r2, [r9, #0x134]
	add r1, r9, #0x28
	add r2, r3, r2
	str r2, [sp, #0xc]
	ldr r2, [sp, #0x1c]
	ldr r3, [r2, #8]
	add r2, r9, #0x47
	str r3, [sp, #0x10]
	ldr r3, [sp, #0x1c]
	ldr r4, [r3, #0xc]
	add r3, r9, #0x5c
	str r4, [sp, #0x14]
	ldr r4, [sp, #0x1c]
	ldr r4, [r4, #0x10]
	str r4, [sp, #0x18]
	bl sub_20AF42C
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE2A8:
	ldr r0, [sp, #0xe8]
	bl DWCi_GsFree
	mov r0, #0
	str r0, [sp, #0xe8]
	b _020AF3B4
_020AE2BC:
	cmp r0, #2
	bne _020AE3E8
	ldr r0, [sp, #0x1c]
	ldr r1, [r0, #0xc]
	ldr r0, [r0, #0x10]
	cmp r1, #0
	str r1, [sp, #0xd4]
	str r0, [sp, #0xd8]
	beq _020AF3B4
	add r0, sp, #0x2ec
	str r0, [sp]
	ldr r1, [r9, #8]
	add r2, sp, #0x90
	add r3, sp, #0xec
	mov r0, r10
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AE724 // =0x0211E360
	add r0, sp, #0xec
	bl strcmp
	cmp r0, #0
	beq _020AE350
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE350:
	mov r0, #0x3c
	bl DWCi_GsMalloc
	movs r4, r0
	bne _020AE37C
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE37C:
	mov r0, #0
	str r0, [r4]
	add r0, r4, #4
	add r1, r9, #0x5c
	mov r2, #0x33
	bl sub_20B0098
	add r0, sp, #0x28c
	ldrsb r0, [r0, #0x60]
	add r1, sp, #0xd4
	mov r3, r4
	cmp r0, #0x30
	moveq r0, #0
	streq r0, [r4, #0x38]
	movne r0, #1
	strne r0, [r4, #0x38]
	ldr r0, [sp, #0x1c]
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	mov r0, r10
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020AF3B4
	ldr ip, _020AE670 // =0x000004EC
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE3E8:
	cmp r0, #3
	bne _020AE7B8
	ldr r0, [sp, #0x1c]
	ldr r1, [r0, #0xc]
	ldr r0, [r0, #0x10]
	cmp r1, #0
	str r1, [sp, #0xcc]
	str r0, [sp, #0xd0]
	beq _020AF3B4
	mov r0, #0x44
	bl DWCi_GsMalloc
	movs r8, r0
	bne _020AE438
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE438:
	mov r2, #0
	add r0, r8, #4
	add r1, r9, #0x5c
	str r2, [r8]
	bl strcpy
	mov r1, #0
	str r1, [r8, #0x38]
	str r1, [r8, #0x3c]
	add r0, sp, #0x2ec
	str r1, [r8, #0x40]
	str r0, [sp]
	ldr r1, [r9, #8]
	add r2, sp, #0x90
	add r3, sp, #0xec
	mov r0, r10
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AE728 // =0x0211E364
	add r0, sp, #0xec
	bl strcmp
	cmp r0, #0
	beq _020AE4CC
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE4CC:
	mov r0, #1
	mov r7, #0
	add r6, sp, #0xec
	add r11, sp, #0x2ec
	mov r5, #0x1f
	mov r4, #0x15
	str r0, [sp, #0x54]
_020AE4E8:
	str r11, [sp]
	ldr r1, [r9, #8]
	mov r0, r10
	add r2, sp, #0x90
	mov r3, r6
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AE70C // =0x0211E304
	mov r0, r6
	bl strcmp
	cmp r0, #0
	bne _020AE5C0
	ldr r0, [r8, #0x3c]
	ldr r1, [r8, #0x38]
	add r1, r1, #1
	mov r1, r1, lsl #2
	bl DWCi_GsRealloc
	cmp r0, #0
	bne _020AE55C
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE55C:
	str r0, [r8, #0x3c]
	mov r0, r5
	bl DWCi_GsMalloc
	cmp r0, #0
	bne _020AE58C
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE58C:
	ldr r3, [r8, #0x3c]
	ldr r2, [r8, #0x38]
	mov r1, r11
	str r0, [r3, r2, lsl #2]
	ldr r3, [r8, #0x3c]
	ldr r0, [r8, #0x38]
	mov r2, r5
	ldr r0, [r3, r0, lsl #2]
	bl sub_20B0098
	ldr r0, [r8, #0x38]
	add r0, r0, #1
	str r0, [r8, #0x38]
	b _020AE778
_020AE5C0:
	ldr r1, _020AE710 // =aUniquenick_2
	mov r0, r6
	bl strcmp
	cmp r0, #0
	bne _020AE730
	ldr r0, [r8, #0x38]
	cmp r0, #0
	ble _020AE778
	mov r1, r0, lsl #2
	ldr r0, [r8, #0x40]
	bl DWCi_GsRealloc
	cmp r0, #0
	bne _020AE610
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE610:
	str r0, [r8, #0x40]
	mov r0, r4
	bl DWCi_GsMalloc
	cmp r0, #0
	bne _020AE640
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE640:
	ldr r3, [r8, #0x40]
	ldr r2, [r8, #0x38]
	mov r1, r11
	sub r2, r2, #1
	str r0, [r3, r2, lsl #2]
	ldr r3, [r8, #0x40]
	ldr r0, [r8, #0x38]
	mov r2, r4
	sub r0, r0, #1
	ldr r0, [r3, r0, lsl #2]
	bl sub_20B0098
	b _020AE778
	.align 2, 0
_020AE670: .word 0x000004EC
_020AE674: .word _0211E178
_020AE678: .word 0x00000D01
_020AE67C: .word aCouldNotConnec
_020AE680: .word aSearch
_020AE684: .word aSesskey_2
_020AE688: .word aProfileid_2
_020AE68C: .word aNamespaceid_0
_020AE690: .word aNick_2
_020AE694: .word aUniquenick_1
_020AE698: .word aEmail_1
_020AE69C: .word aFirstname_0
_020AE6A0: .word aLastname_0
_020AE6A4: .word aIcquin_0
_020AE6A8: .word aSkip
_020AE6AC: .word aValid
_020AE6B0: .word aNicks
_020AE6B4: .word aPass
_020AE6B8: .word aPmatch
_020AE6BC: .word aProductid_0
_020AE6C0: .word aCheck
_020AE6C4: .word aNewuser_0
_020AE6C8: .word aProductid_1
_020AE6CC: .word aCdkey
_020AE6D0: .word aOthers
_020AE6D4: .word aUniquesearch
_020AE6D8: .word aPreferrednick
_020AE6DC: .word _0211E2AC
_020AE6E0: .word aGpisearchC
_020AE6E4: .word 0x00000275
_020AE6E8: .word aGamename_0
_020AE6EC: .word 0x02144D64
_020AE6F0: .word aFinal_5
_020AE6F4: .word aThereWasAnErro_11
_020AE6F8: .word 0x00000601
_020AE6FC: .word aBsrdone
_020AE700: .word _0211E2F8
_020AE704: .word 0x0211E300
_020AE708: .word aOutOfMemory_8
_020AE70C: .word 0x0211E304
_020AE710: .word aUniquenick_2
_020AE714: .word aFirstname_1
_020AE718: .word aLastname_1
_020AE71C: .word aEmail_2
_020AE720: .word aErrorReadingFr
_020AE724: .word 0x0211E360
_020AE728: .word 0x0211E364
_020AE72C: .word aNdone
_020AE730:
	ldr r1, _020AE72C // =aNdone
	mov r0, r6
	bl strcmp
	cmp r0, #0
	ldreq r7, [sp, #0x54]
	beq _020AE778
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE778:
	cmp r7, #0
	beq _020AE4E8
	ldr r0, [sp, #0x1c]
	add r1, sp, #0xcc
	str r0, [sp]
	mov r0, #3
	str r0, [sp, #4]
	mov r0, r10
	mov r3, r8
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020AF3B4
	ldr ip, _020AE670 // =0x000004EC
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE7B8:
	cmp r0, #4
	bne _020AEA9C
	ldr r0, [sp, #0x1c]
	ldr r1, [r0, #0xc]
	ldr r0, [r0, #0x10]
	cmp r1, #0
	str r1, [sp, #0xc4]
	str r0, [sp, #0xc8]
	beq _020AF3B4
	mov r0, #0x10
	bl DWCi_GsMalloc
	str r0, [sp, #0x28]
	cmp r0, #0
	bne _020AE80C
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE80C:
	mov r0, #0
	str r0, [sp, #0x34]
	ldr r1, [r9, #0x138]
	ldr r0, [sp, #0x28]
	add r4, sp, #0xec
	str r1, [r0, #4]
	ldr r1, [sp, #0x34]
	add r5, sp, #0x2ec
	str r1, [r0]
	str r1, [r0, #8]
	str r1, [r0, #0xc]
	mov r0, #0x1f
	str r0, [sp, #0x68]
	mov r0, #0x100
	str r0, [sp, #0x64]
	mov r0, r1
	str r0, [sp, #0x58]
	mov r0, #0x128
	str r0, [sp, #0x5c]
	mov r0, r1
	mov r11, #1
	str r0, [sp, #0x60]
_020AE864:
	str r5, [sp]
	ldr r1, [r9, #8]
	mov r0, r10
	add r2, sp, #0x90
	mov r3, r4
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AF3E8 // =aPsrdone
	mov r0, r4
	bl strcmp
	cmp r0, #0
	streq r11, [sp, #0x34]
	beq _020AEA58
	ldr r1, _020AF3EC // =_0211E378
	mov r0, r4
	bl strcmp
	cmp r0, #0
	bne _020AEA28
	ldr r0, [sp, #0x28]
	mov r2, #0x128
	ldr r0, [r0, #8]
	add r1, r0, #1
	ldr r0, [sp, #0x28]
	str r1, [r0, #8]
	ldr r1, [sp, #0x28]
	ldr r0, [r0, #0xc]
	ldr r3, [r1, #8]
	mul r1, r3, r2
	bl DWCi_GsRealloc
	ldr r1, [sp, #0x28]
	str r0, [r1, #0xc]
	mov r0, r1
	ldr r6, [r0, #0xc]
	cmp r6, #0
	bne _020AE918
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AE918:
	ldr r1, [r0, #8]
	mov r0, #0x128
	sub r1, r1, #1
	mul r7, r1, r0
	add r8, r6, r7
	ldr r1, [sp, #0x58]
	ldr r2, [sp, #0x5c]
	mov r0, r8
	bl memset
	mov r0, r5
	str r11, [r8, #0x24]
	bl atoi
	str r0, [r6, r7]
	ldr r7, [sp, #0x60]
_020AE950:
	ldr r6, [sp, #0x90]
	mov r0, r10
	str r5, [sp]
	ldr r1, [r9, #8]
	add r2, sp, #0x90
	mov r3, r4
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AF3F0 // =aStatus_0
	mov r0, r4
	bl strcmp
	cmp r0, #0
	bne _020AE9A4
	ldr r2, [sp, #0x64]
	add r0, r8, #0x28
	mov r1, r5
	bl sub_20B0098
	b _020AE9C8
_020AE9A4:
	ldr r1, _020AE70C // =0x0211E304
	mov r0, r4
	bl strcmp
	cmp r0, #0
	bne _020AE9C8
	ldr r2, [sp, #0x68]
	add r0, r8, #4
	mov r1, r5
	bl sub_20B0098
_020AE9C8:
	ldr r1, _020AF3F4 // =aStatuscode
	mov r0, r4
	bl strcmp
	cmp r0, #0
	bne _020AE9EC
	mov r0, r5
	bl atoi
	str r0, [r8, #0x24]
	b _020AEA1C
_020AE9EC:
	ldr r1, _020AF3EC // =_0211E378
	mov r0, r4
	bl strcmp
	cmp r0, #0
	beq _020AEA14
	ldr r1, _020AF3E8 // =aPsrdone
	mov r0, r4
	bl strcmp
	cmp r0, #0
	bne _020AEA1C
_020AEA14:
	str r6, [sp, #0x90]
	mov r7, r11
_020AEA1C:
	cmp r7, #0
	beq _020AE950
	b _020AEA58
_020AEA28:
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AEA58:
	ldr r0, [sp, #0x34]
	cmp r0, #0
	beq _020AE864
	ldr r0, [sp, #0x1c]
	ldr r3, [sp, #0x28]
	str r0, [sp]
	mov r0, #4
	str r0, [sp, #4]
	add r1, sp, #0xc4
	mov r0, r10
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020AF3B4
	ldr ip, _020AE670 // =0x000004EC
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AEA9C:
	cmp r0, #5
	bne _020AEC0C
	ldr r0, [sp, #0x1c]
	ldr r1, [r0, #0xc]
	ldr r0, [r0, #0x10]
	cmp r1, #0
	str r1, [sp, #0xbc]
	str r0, [sp, #0xc0]
	beq _020AF3B4
	add r0, sp, #0x2ec
	str r0, [sp]
	ldr r1, [r9, #8]
	add r2, sp, #0x90
	add r3, sp, #0xec
	mov r0, r10
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AF3F8 // =0x0211E390
	add r0, sp, #0xec
	bl strcmp
	cmp r0, #0
	beq _020AEB30
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AEB30:
	add r0, sp, #0x2ec
	bl atoi
	movs r5, r0
	ldrne r0, [sp, #0x24]
	movne r4, #0
	strne r5, [r0, #0x418]
	bne _020AEBA4
	ldr r0, [r9, #8]
	ldr r1, _020AF3FC // =aPid_2
	add r2, sp, #0x2ec
	mov r3, #0x200
	bl sub_20AFEAC
	cmp r0, #0
	bne _020AEB98
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AEB98:
	add r0, sp, #0x2ec
	bl atoi
	mov r4, r0
_020AEBA4:
	mov r0, #8
	bl DWCi_GsMalloc
	movs r3, r0
	bne _020AEBD0
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AEBD0:
	str r5, [r3]
	ldr r0, [sp, #0x1c]
	str r4, [r3, #4]
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	add r1, sp, #0xbc
	mov r0, r10
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020AF3B4
	ldr ip, _020AE670 // =0x000004EC
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AEC0C:
	cmp r0, #6
	bne _020AED84
	ldr r0, [sp, #0x1c]
	ldr r1, [r0, #0xc]
	ldr r0, [r0, #0x10]
	cmp r1, #0
	str r1, [sp, #0xb4]
	str r0, [sp, #0xb8]
	beq _020AF3B4
	add r0, sp, #0x2ec
	str r0, [sp]
	ldr r1, [r9, #8]
	add r2, sp, #0x90
	add r3, sp, #0xec
	mov r0, r10
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AF400 // =0x0211E39C
	add r0, sp, #0xec
	bl strcmp
	cmp r0, #0
	beq _020AECA0
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AECA0:
	add r0, sp, #0x2ec
	bl atoi
	movs r5, r0
	ldrne r0, [sp, #0x24]
	ldr r1, _020AF3FC // =aPid_2
	strne r5, [r0, #0x418]
	ldr r0, [r9, #8]
	add r2, sp, #0x2ec
	mov r3, #0x200
	bl sub_20AFEAC
	cmp r0, #0
	bne _020AED10
	cmp r5, #0
	bne _020AED08
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AED08:
	mov r4, #0
	b _020AED1C
_020AED10:
	add r0, sp, #0x2ec
	bl atoi
	mov r4, r0
_020AED1C:
	mov r0, #8
	bl DWCi_GsMalloc
	movs r3, r0
	bne _020AED48
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AED48:
	str r5, [r3]
	ldr r0, [sp, #0x1c]
	str r4, [r3, #4]
	str r0, [sp]
	mov r0, #0
	str r0, [sp, #4]
	add r1, sp, #0xb4
	mov r0, r10
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020AF3B4
	ldr ip, _020AE670 // =0x000004EC
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AED84:
	cmp r0, #7
	bne _020AF130
	ldr r0, [sp, #0x1c]
	ldr r1, [r0, #0xc]
	ldr r0, [r0, #0x10]
	cmp r1, #0
	str r1, [sp, #0xac]
	str r0, [sp, #0xb0]
	beq _020AF3B4
	mov r0, #0xc
	bl DWCi_GsMalloc
	str r0, [sp, #0x2c]
	cmp r0, #0
	bne _020AEDD8
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AEDD8:
	mov r2, #0
	str r2, [r0]
	str r2, [r0, #4]
	str r2, [r0, #8]
	add r1, sp, #0x2ec
	str r1, [sp]
	ldr r1, [r9, #8]
	add r2, sp, #0x90
	add r3, sp, #0xec
	mov r0, r10
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AF404 // =aOthers_0
	add r0, sp, #0xec
	bl strcmp
	cmp r0, #0
	beq _020AEE58
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AEE58:
	mov r0, #0
	str r0, [sp, #0x30]
	mov r0, #1
	str r0, [sp, #0x6c]
	mov r0, #0x33
	str r0, [sp, #0x80]
	mov r0, #0x15
	str r0, [sp, #0x7c]
	ldr r0, [sp, #0x30]
	add r5, sp, #0xec
	str r0, [sp, #0x70]
	mov r0, #0xac
	str r0, [sp, #0x74]
	ldr r0, [sp, #0x30]
	add r6, sp, #0x2ec
	mov r4, #0x1f
	str r0, [sp, #0x78]
_020AEE9C:
	str r6, [sp]
	ldr r1, [r9, #8]
	mov r0, r10
	add r2, sp, #0x90
	mov r3, r5
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AF408 // =aOdone
	mov r0, r5
	bl strcmp
	cmp r0, #0
	ldreq r0, [sp, #0x6c]
	streq r0, [sp, #0x30]
	beq _020AF0EC
	ldr r1, _020AF40C // =0x0211E3B0
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AF0BC
	ldr r1, [sp, #0x2c]
	ldr r0, [sp, #0x2c]
	ldr r2, [r1, #4]
	mov r1, #0xac
	add r2, r2, #1
	mul r1, r2, r1
	ldr r0, [r0, #8]
	bl DWCi_GsRealloc
	cmp r0, #0
	bne _020AEF38
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AEF38:
	ldr r1, [sp, #0x2c]
	ldr r2, [sp, #0x74]
	str r0, [r1, #8]
	mov r0, r1
	ldr r1, [r0, #4]
	ldr r7, [r0, #8]
	mov r0, #0xac
	mul r11, r1, r0
	add r8, r7, r11
	ldr r1, [sp, #0x70]
	mov r0, r8
	bl memset
	ldr r0, [sp, #0x2c]
	ldr r1, [r0, #4]
	mov r0, r6
	add r2, r1, #1
	ldr r1, [sp, #0x2c]
	str r2, [r1, #4]
	bl atoi
	str r0, [r7, r11]
	ldr r7, [sp, #0x78]
_020AEF8C:
	ldr r11, [sp, #0x90]
	mov r0, r10
	str r6, [sp]
	ldr r1, [r9, #8]
	add r2, sp, #0x90
	mov r3, r5
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AE70C // =0x0211E304
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AEFE0
	add r0, r8, #4
	mov r1, r6
	mov r2, r4
	bl sub_20B0098
	b _020AF0B0
_020AEFE0:
	ldr r1, _020AE710 // =aUniquenick_2
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AF008
	ldr r2, [sp, #0x7c]
	add r0, r8, #0x23
	mov r1, r6
	bl sub_20B0098
	b _020AF0B0
_020AF008:
	ldr r1, _020AF410 // =aFirst
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AF030
	add r0, r8, #0x38
	mov r1, r6
	mov r2, r4
	bl sub_20B0098
	b _020AF0B0
_020AF030:
	ldr r1, _020AF414 // =0x0211E3BC
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AF058
	add r0, r8, #0x57
	mov r1, r6
	mov r2, r4
	bl sub_20B0098
	b _020AF0B0
_020AF058:
	ldr r1, _020AE71C // =aEmail_2
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AF080
	ldr r2, [sp, #0x80]
	add r0, r8, #0x76
	mov r1, r6
	bl sub_20B0098
	b _020AF0B0
_020AF080:
	ldr r1, _020AF40C // =0x0211E3B0
	mov r0, r5
	bl strcmp
	cmp r0, #0
	beq _020AF0A8
	ldr r1, _020AF408 // =aOdone
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AF0B0
_020AF0A8:
	ldr r7, [sp, #0x6c]
	str r11, [sp, #0x90]
_020AF0B0:
	cmp r7, #0
	beq _020AEF8C
	b _020AF0EC
_020AF0BC:
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AF0EC:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	beq _020AEE9C
	ldr r0, [sp, #0x1c]
	ldr r3, [sp, #0x2c]
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	add r1, sp, #0xac
	mov r0, r10
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020AF3B4
	ldr ip, _020AE670 // =0x000004EC
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AF130:
	cmp r0, #8
	bne _020AF3A0
	ldr r0, [sp, #0x1c]
	ldr r1, [r0, #0xc]
	ldr r0, [r0, #0x10]
	cmp r1, #0
	str r1, [sp, #0xa4]
	str r0, [sp, #0xa8]
	beq _020AF3B4
	mov r0, #0xc
	mov r8, #0
	bl DWCi_GsMalloc
	movs r7, r0
	bne _020AF184
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AF184:
	mov r1, r8
	str r1, [r7]
	str r1, [r7, #4]
	add r0, sp, #0x2ec
	str r1, [r7, #8]
	str r0, [sp]
	ldr r1, [r9, #8]
	add r2, sp, #0x90
	add r3, sp, #0xec
	mov r0, r10
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AF418 // =0x0211E3C4
	add r0, sp, #0xec
	bl strcmp
	cmp r0, #0
	beq _020AF204
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AF204:
	add r0, sp, #0x2ec
	bl atoi
	str r0, [r7, #4]
	ldr r0, [r7, #4]
	mov r0, r0, lsl #2
	bl DWCi_GsMalloc
	str r0, [r7, #8]
	ldr r0, [r7, #8]
	cmp r0, #0
	bne _020AF248
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AF248:
	mov r6, r8
	mov r0, #1
	add r5, sp, #0xec
	add r11, sp, #0x2ec
	mov r4, #0x15
	str r6, [sp, #0x84]
	str r0, [sp, #0x88]
_020AF264:
	str r11, [sp]
	ldr r1, [r9, #8]
	mov r0, r10
	add r2, sp, #0x90
	mov r3, r5
	bl sub_20AFBE8
	cmp r0, #0
	ldrne ip, _020AE670 // =0x000004EC
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020AE70C // =0x0211E304
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AF2F0
	mov r0, r4
	bl DWCi_GsMalloc
	ldr r1, [r7, #8]
	str r0, [r1, r8, lsl #2]
	ldr r0, [r7, #8]
	ldr r0, [r0, r8, lsl #2]
	cmp r0, #0
	bne _020AF2DC
	ldr r1, _020AE708 // =aOutOfMemory_8
	mov r0, r10
	bl sub_20AFBA8
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #1
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AF2DC:
	mov r1, r11
	mov r2, r4
	bl sub_20B0098
	add r8, r8, #1
	b _020AF360
_020AF2F0:
	ldr r1, _020AF41C // =aUsdone
	mov r0, r5
	bl strcmp
	cmp r0, #0
	bne _020AF330
	ldr r0, [r7, #4]
	cmp r8, r0
	beq _020AF324
	ldr r0, _020AF420 // =aCountArgNumsug
	ldr r1, _020AE6E0 // =aGpisearchC
	ldr r2, [sp, #0x84]
	ldr r3, _020AF424 // =0x00000515
	bl __msl_assertion_failed
_020AF324:
	str r8, [r7, #4]
	ldr r6, [sp, #0x88]
	b _020AF360
_020AF330:
	ldr r2, _020AE720 // =aErrorReadingFr
	mov r0, r10
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r10
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	ldr ip, _020AE670 // =0x000004EC
	mov r0, #3
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AF360:
	cmp r6, #0
	beq _020AF264
	ldr r0, [sp, #0x1c]
	add r1, sp, #0xa4
	str r0, [sp]
	mov r0, #9
	str r0, [sp, #4]
	mov r0, r10
	mov r3, r7
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	beq _020AF3B4
	ldr ip, _020AE670 // =0x000004EC
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020AF3A0:
	ldr r0, _020AE6DC // =_0211E2AC
	ldr r1, _020AE6E0 // =aGpisearchC
	ldr r3, _020AF428 // =0x0000052A
	mov r2, #0
	bl __msl_assertion_failed
_020AF3B4:
	mov r0, #1
	str r0, [r9, #0x140]
	mov r4, #0
_020AF3C0:
	cmp r4, #0
	beq _020AF3D0
	mov r0, #0xa
	bl sub_20A0C98
_020AF3D0:
	cmp r4, #0
	bne _020AD7C0
	mov r0, #0
	ldr ip, _020AE670 // =0x000004EC
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020AF3E8: .word aPsrdone
_020AF3EC: .word _0211E378
_020AF3F0: .word aStatus_0
_020AF3F4: .word aStatuscode
_020AF3F8: .word 0x0211E390
_020AF3FC: .word aPid_2
_020AF400: .word 0x0211E39C
_020AF404: .word aOthers_0
_020AF408: .word aOdone
_020AF40C: .word 0x0211E3B0
_020AF410: .word aFirst
_020AF414: .word 0x0211E3BC
_020AF418: .word 0x0211E3C4
_020AF41C: .word aUsdone
_020AF420: .word aCountArgNumsug
_020AF424: .word 0x00000515
_020AF428: .word 0x0000052A
	arm_func_end sub_20AD78C

	arm_func_start sub_20AF42C
sub_20AF42C: // 0x020AF42C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	movs r8, r1
	mov r9, r0
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x28]
	ldr r4, [sp, #0x2c]
	beq _020AF45C
	ldrsb r0, [r8, #0]
	cmp r0, #0
	bne _020AF4D0
_020AF45C:
	cmp r6, #0
	beq _020AF470
	ldrsb r0, [r6, #0]
	cmp r0, #0
	bne _020AF4D0
_020AF470:
	cmp r5, #0
	beq _020AF484
	ldrsb r0, [r5, #0]
	cmp r0, #0
	bne _020AF4D0
_020AF484:
	cmp r4, #0
	beq _020AF498
	ldrsb r0, [r4, #0]
	cmp r0, #0
	bne _020AF4D0
_020AF498:
	ldr r0, [sp, #0x30]
	cmp r0, #0
	bne _020AF4D0
	cmp r7, #0
	beq _020AF4B8
	ldrsb r0, [r7, #0]
	cmp r0, #0
	bne _020AF4D0
_020AF4B8:
	ldr r1, _020AF614 // =aNoSearchCriter
	mov r0, r9
	bl sub_20AFBA8
	add sp, sp, #0xc
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020AF4D0:
	add r1, sp, #4
	mov r0, r9
	mov r2, #1
	bl sub_20AF6AC
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	cmp r8, #0
	ldreq r0, [sp, #4]
	moveq r1, #0
	streqb r1, [r0, #0x28]
	beq _020AF514
	ldr r0, [sp, #4]
	mov r1, r8
	add r0, r0, #0x28
	mov r2, #0x1f
	bl sub_20B0098
_020AF514:
	cmp r7, #0
	ldreq r0, [sp, #4]
	moveq r1, #0
	streqb r1, [r0, #0x47]
	beq _020AF53C
	ldr r0, [sp, #4]
	mov r1, r7
	add r0, r0, #0x47
	mov r2, #0x15
	bl sub_20B0098
_020AF53C:
	cmp r6, #0
	ldreq r0, [sp, #4]
	moveq r1, #0
	streqb r1, [r0, #0x5c]
	beq _020AF564
	ldr r0, [sp, #4]
	mov r1, r6
	add r0, r0, #0x5c
	mov r2, #0x33
	bl sub_20B0098
_020AF564:
	ldr r0, [sp, #4]
	add r0, r0, #0x5c
	bl sub_20A0C0C
	cmp r5, #0
	ldreq r0, [sp, #4]
	moveq r1, #0
	streqb r1, [r0, #0x8f]
	beq _020AF598
	ldr r0, [sp, #4]
	mov r1, r5
	add r0, r0, #0x8f
	mov r2, #0x1f
	bl sub_20B0098
_020AF598:
	cmp r4, #0
	ldreq r0, [sp, #4]
	moveq r1, #0
	streqb r1, [r0, #0xae]
	beq _020AF5C0
	ldr r0, [sp, #4]
	mov r1, r4
	add r0, r0, #0xae
	mov r2, #0x1f
	bl sub_20B0098
_020AF5C0:
	ldr r0, [sp, #0x34]
	ldr r2, [sp, #0x30]
	ldr r1, [sp, #4]
	cmp r0, #0
	movlt r0, #0
	strlt r0, [sp, #0x34]
	str r2, [r1, #0x130]
	ldr r2, [sp, #0x34]
	ldr r1, [sp, #4]
	ldr r0, [sp, #0x40]
	str r2, [r1, #0x134]
	str r0, [sp]
	ldr r1, [sp, #4]
	ldr r2, [sp, #0x38]
	ldr r3, [sp, #0x3c]
	mov r0, r9
	bl sub_20AF618
	cmp r0, #0
	moveq r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020AF614: .word aNoSearchCriter
	arm_func_end sub_20AF42C

	arm_func_start sub_20AF618
sub_20AF618: // 0x020AF618
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r5, r0
	ldr r4, [r5, #0]
	ldr ip, [sp, #0x20]
	ldr lr, [r4, #0x210]
	add lr, lr, #1
	str lr, [r4, #0x210]
	str r2, [sp]
	str r3, [sp, #4]
	mov r2, r1
	add r3, sp, #0xc
	mov r1, #3
	str ip, [sp, #8]
	bl sub_20ABA48
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, pc}
	ldr r1, [sp, #0xc]
	mov r0, r5
	bl sub_20AF770
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, pc}
	ldr r1, [sp, #0xc]
	ldr r0, [r1, #8]
	cmp r0, #0
	beq _020AF6A0
	ldr r1, [r1, #0x18]
	mov r0, r5
	bl sub_20A5C9C
	cmp r0, #0
	addne sp, sp, #0x14
	ldmneia sp!, {r4, r5, pc}
_020AF6A0:
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20AF618

	arm_func_start sub_20AF6AC
sub_20AF6AC: // 0x020AF6AC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r0
	mov r0, #0x144
	mov r5, r1
	mov r7, r2
	bl DWCi_GsMalloc
	movs r4, r0
	bne _020AF6E8
	ldr r1, _020AF76C // =aOutOfMemory_8
	mov r0, r6
	bl sub_20AFBA8
	add sp, sp, #4
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020AF6E8:
	mov r1, #0
	mov r2, #0x144
	bl memset
	str r7, [r4]
	mvn r0, #0
	str r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #8]
	str r0, [r4, #0x10]
	str r0, [r4, #0x14]
	str r0, [r4, #0xc]
	str r0, [r4, #0x20]
	str r0, [r4, #0x24]
	mov r0, #0x1000
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x1c]
	add r0, r0, #1
	bl DWCi_GsMalloc
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x18]
	cmp r0, #0
	movne r0, #0
	strne r0, [r4, #0x13c]
	strne r0, [r4, #0x140]
	addne sp, sp, #4
	strne r4, [r5]
	ldmneia sp!, {r4, r5, r6, r7, pc}
	ldr r1, _020AF76C // =aOutOfMemory_8
	mov r0, r6
	bl sub_20AFBA8
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020AF76C: .word aOutOfMemory_8
	arm_func_end sub_20AF6AC

	arm_func_start sub_20AF770
sub_20AF770: // 0x020AF770
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r1
	ldr r4, [r5, #4]
	mov r1, #0x1000
	str r1, [r4, #0xc]
	ldr r1, [r4, #0xc]
	mov r6, r0
	add r0, r1, #1
	bl DWCi_GsMalloc
	str r0, [r4, #8]
	ldr r0, [r4, #8]
	cmp r0, #0
	bne _020AF7C0
	ldr r1, _020AF958 // =aOutOfMemory_8
	mov r0, r6
	bl sub_20AFBA8
	add sp, sp, #8
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_020AF7C0:
	mov r0, #2
	mov r1, #1
	mov r2, #0
	bl sub_20A0800
	str r0, [r4, #4]
	ldr r0, [r4, #4]
	mvn r1, #0
	cmp r0, r1
	bne _020AF810
	ldr r2, _020AF95C // =aThereWasAnErro_12
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #8
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020AF810:
	mov r1, #0
	bl sub_20A0BC4
	cmp r0, #0
	bne _020AF84C
	ldr r2, _020AF960 // =aThereWasAnErro_13
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #8
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020AF84C:
	ldr r0, _020AF964 // =aGpspGsNintendo
	bl sub_20BE844
	cmp r0, #0
	bne _020AF888
	ldr r2, _020AF968 // =aCouldNotResolv_0
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #8
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020AF888:
	add r1, sp, #0
	mov r2, #0
	str r2, [r1]
	str r2, [r1, #4]
	mov r1, #2
	strb r1, [sp, #1]
	ldr r0, [r0, #0xc]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0]
	str r0, [sp, #4]
	cmp r0, #0
	bne _020AF8C8
	ldr r0, _020AF96C // =aAddressSinAddr_0
	ldr r1, _020AF970 // =aGpisearchC
	mov r3, #0x59
	bl __msl_assertion_failed
_020AF8C8:
	ldr r0, _020AF974 // =0x0000CD74
	add r1, sp, #0
	strh r0, [sp, #2]
	ldr r0, [r4, #4]
	mov r2, #8
	bl sub_20A072C
	mvn r1, #0
	cmp r0, r1
	bne _020AF944
	ldr r0, [r4, #4]
	bl WSAGetLastError
	mvn r1, #5
	cmp r0, r1
	beq _020AF944
	mvn r1, #0x19
	cmp r0, r1
	beq _020AF944
	mvn r1, #0x4b
	cmp r0, r1
	beq _020AF944
	ldr r2, _020AF978 // =aThereWasAnErro_14
	mov r0, r6
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #8
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020AF944:
	mov r0, #1
	str r0, [r5, #0x14]
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020AF958: .word aOutOfMemory_8
_020AF95C: .word aThereWasAnErro_12
_020AF960: .word aThereWasAnErro_13
_020AF964: .word aGpspGsNintendo
_020AF968: .word aCouldNotResolv_0
_020AF96C: .word aAddressSinAddr_0
_020AF970: .word aGpisearchC
_020AF974: .word 0x0000CD74
_020AF978: .word aThereWasAnErro_14
	arm_func_end sub_20AF770

	arm_func_start sub_20AF97C
sub_20AF97C: // 0x020AF97C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x54
	mov r4, r1
	mov r5, r0
	mov r0, r3
	ldr r1, _020AF9F8 // =aXfer
	add r2, sp, #4
	mov r3, #0x40
	bl sub_20AFEAC
	cmp r0, #0
	addeq sp, sp, #0x54
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, _020AF9FC // =aDUU
	add ip, sp, #0x4c
	add r0, sp, #4
	add r2, sp, #0x44
	add r3, sp, #0x48
	str ip, [sp]
	bl sscanf
	cmp r0, #3
	addne sp, sp, #0x54
	ldmneia sp!, {r4, r5, pc}
	mov ip, #0
	add r1, sp, #0x44
	mov r0, r5
	mov r2, r4
	mov r3, #2
	str ip, [sp]
	bl sub_20AFA00
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020AF9F8: .word aXfer
_020AF9FC: .word aDUU
	arm_func_end sub_20AF97C

	arm_func_start sub_20AFA00
sub_20AFA00: // 0x020AFA00
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	ldr ip, [sp, #0x30]
	mov r5, r2
	mov r6, r0
	cmp ip, #0
	ldreq r0, _020AFA9C // =0x0211E4EC
	mov lr, r1
	mov r4, r3
	streq r0, [sp, #0x30]
	mov r0, r6
	mov r1, r5
	mov r3, lr
	mov r2, #0xc9
	bl sub_20ABF28
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, _020AFAA0 // =aVersionDResult
	add r0, sp, #0
	mov r3, r4
	mov r2, #1
	bl sprintf
	add r2, sp, #0
	mov r0, r6
	mov r1, r5
	bl sub_20A7914
	cmp r0, #0
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r2, [sp, #0x30]
	mov r0, r6
	mov r1, r5
	mvn r3, #0
	bl sub_20ABE40
	cmp r0, #0
	moveq r0, #0
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020AFA9C: .word 0x0211E4EC
_020AFAA0: .word aVersionDResult
	arm_func_end sub_20AFA00

	arm_func_start sub_20AFAA4
sub_20AFAA4: // 0x020AFAA4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r4, r2
	mov r5, r1
	mov r1, r4
	mov r2, #1
	mov r6, r0
	bl sub_20AFFB4
	cmp r0, #0
	addne sp, sp, #0x10
	movne r0, #4
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, _020AFB9C // =0x0211E508
	mov r0, r4
	mov r2, #4
	bl strncmp
	cmp r0, #0
	beq _020AFB18
	ldr r2, _020AFBA0 // =aUnexpectedData_3
	mov r0, r6
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r6
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0x10
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020AFB18:
	ldr r1, [r5, #0xc]
	ldr r0, [r5, #0x10]
	cmp r1, #0
	str r1, [sp, #8]
	str r0, [sp, #0xc]
	beq _020AFB84
	mov r0, #4
	bl DWCi_GsMalloc
	movs r3, r0
	bne _020AFB58
	ldr r1, _020AFBA4 // =aOutOfMemory_9
	mov r0, r6
	bl sub_20AFBA8
	add sp, sp, #0x10
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_020AFB58:
	mov r0, #0
	str r0, [r3]
	str r5, [sp]
	str r0, [sp, #4]
	add r1, sp, #8
	mov r0, r6
	ldmia r1, {r1, r2}
	bl sub_20A8110
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, r5, r6, pc}
_020AFB84:
	mov r0, r6
	mov r1, r5
	bl sub_20AB940
	mov r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020AFB9C: .word 0x0211E508
_020AFBA0: .word aUnexpectedData_3
_020AFBA4: .word aOutOfMemory_9
	arm_func_end sub_20AFAA4

	arm_func_start sub_20AFBA8
sub_20AFBA8: // 0x020AFBA8
	ldr ip, _020AFBB8 // =sub_20B0098
	ldr r0, [r0, #0]
	mov r2, #0x100
	bx ip
	.align 2, 0
_020AFBB8: .word sub_20B0098
	arm_func_end sub_20AFBA8

	arm_func_start sub_20AFBBC
sub_20AFBBC: // 0x020AFBBC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r4, [r0, #0]
	mov r5, r1
	mov r1, r2
	mov r0, r4
	mov r2, #0x100
	bl sub_20B0098
	str r5, [r4, #0x418]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20AFBBC

	arm_func_start sub_20AFBE8
sub_20AFBE8: // 0x020AFBE8
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r7, r1
	mov r8, r0
	mov r6, r2
	mov r5, r3
	ldr r4, [sp, #0x18]
	bne _020AFC18
	ldr r0, _020AFD94 // =aBufferNull
	ldr r1, _020AFD98 // =aGpiutilityC
	ldr r3, _020AFD9C // =0x00000199
	mov r2, #0
	bl __msl_assertion_failed
_020AFC18:
	cmp r5, #0
	bne _020AFC34
	ldr r0, _020AFDA0 // =aKeyNull
	ldr r1, _020AFD98 // =aGpiutilityC
	ldr r3, _020AFDA4 // =0x0000019A
	mov r2, #0
	bl __msl_assertion_failed
_020AFC34:
	cmp r4, #0
	bne _020AFC50
	ldr r0, _020AFDA8 // =aValueNull
	ldr r1, _020AFD98 // =aGpiutilityC
	ldr r3, _020AFDAC // =0x0000019B
	mov r2, #0
	bl __msl_assertion_failed
_020AFC50:
	ldr r1, [r6, #0]
	ldrsb r0, [r7, r1]
	add r3, r7, r1
	cmp r0, #0x5c
	beq _020AFC8C
	ldr r2, _020AFDB0 // =aParseError
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020AFC8C:
	ldrsb r2, [r3, #1]
	add r7, r3, #2
	mov r1, #0
	cmp r2, #0x5c
	beq _020AFD18
	ldr r0, _020AFDB4 // =0x000001FF
_020AFCA4:
	cmp r2, #0
	bne _020AFCD4
	ldr r2, _020AFDB0 // =aParseError
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020AFCD4:
	cmp r1, r0
	bne _020AFD04
	ldr r2, _020AFDB0 // =aParseError
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020AFD04:
	strb r2, [r5], #1
	ldrsb r2, [r7], #1
	add r1, r1, #1
	cmp r2, #0x5c
	bne _020AFCA4
_020AFD18:
	mov r2, #0
	strb r2, [r5]
	ldr r0, _020AFDB4 // =0x000001FF
	b _020AFD60
_020AFD28:
	cmp r2, r0
	bne _020AFD58
	ldr r2, _020AFDB0 // =aParseError
	mov r0, r8
	mov r1, #1
	bl sub_20AFBBC
	mov r0, r8
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020AFD58:
	strb r1, [r4], #1
	add r2, r2, #1
_020AFD60:
	ldrsb r1, [r7], #1
	cmp r1, #0x5c
	beq _020AFD74
	cmp r1, #0
	bne _020AFD28
_020AFD74:
	mov r0, #0
	strb r0, [r4]
	sub r1, r7, r3
	ldr r2, [r6, #0]
	sub r1, r1, #1
	add r1, r2, r1
	str r1, [r6]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020AFD94: .word aBufferNull
_020AFD98: .word aGpiutilityC
_020AFD9C: .word 0x00000199
_020AFDA0: .word aKeyNull
_020AFDA4: .word 0x0000019A
_020AFDA8: .word aValueNull
_020AFDAC: .word 0x0000019B
_020AFDB0: .word aParseError
_020AFDB4: .word 0x000001FF
	arm_func_end sub_20AFBE8

	arm_func_start sub_20AFDB8
sub_20AFDB8: // 0x020AFDB8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov ip, #0
	mov r4, r2
	mov r5, r0
	mov r0, r1
	add r2, sp, #0
	add r3, sp, #4
	mov r1, ip
	str ip, [sp]
	str ip, [sp, #4]
	bl sub_20A09A4
	mvn r1, #0
	cmp r0, r1
	bne _020AFE2C
	ldr r1, _020AFE9C // =aErrorConnectin_0
	mov r0, r5
	bl sub_20B008C
	ldr r2, _020AFEA0 // =aThereWasAnErro_15
	mov r0, r5
	mov r1, #5
	bl sub_20AFBBC
	mov r0, r5
	mov r1, #3
	mov r2, #1
	bl sub_20A81BC
	add sp, sp, #0xc
	mov r0, #3
	ldmia sp!, {r4, r5, pc}
_020AFE2C:
	cmp r0, #0
	ble _020AFE8C
	ldr r0, [sp, #4]
	cmp r0, #0
	beq _020AFE60
	ldr r1, _020AFEA4 // =aConnectionReje
	mov r0, r5
	bl sub_20B008C
	mov r0, #4
	str r0, [r4]
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020AFE60:
	ldr r0, [sp]
	cmp r0, #0
	beq _020AFE8C
	ldr r1, _020AFEA8 // =aConnectionAcce
	mov r0, r5
	bl sub_20B008C
	mov r0, #3
	str r0, [r4]
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020AFE8C:
	mov r0, #0
	str r0, [r4]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020AFE9C: .word aErrorConnectin_0
_020AFEA0: .word aThereWasAnErro_15
_020AFEA4: .word aConnectionReje
_020AFEA8: .word aConnectionAcce
	arm_func_end sub_20AFDB8

	arm_func_start sub_20AFEAC
sub_20AFEAC: // 0x020AFEAC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	movs r5, r0
	mov r8, r1
	mov r4, r2
	mov r7, r3
	bne _020AFED8
	ldr r0, _020AFF94 // =aCommandNull
	ldr r1, _020AFF98 // =aGpiutilityC
	ldr r3, _020AFF9C // =0x0000010D
	mov r2, #0
	bl __msl_assertion_failed
_020AFED8:
	cmp r8, #0
	bne _020AFEF4
	ldr r0, _020AFFA0 // =aKeyNull
	ldr r1, _020AFF98 // =aGpiutilityC
	ldr r3, _020AFFA4 // =0x0000010E
	mov r2, #0
	bl __msl_assertion_failed
_020AFEF4:
	cmp r4, #0
	bne _020AFF10
	ldr r0, _020AFFA8 // =aValueNull
	ldr r1, _020AFF98 // =aGpiutilityC
	ldr r3, _020AFFAC // =0x0000010F
	mov r2, #0
	bl __msl_assertion_failed
_020AFF10:
	cmp r7, #0
	bgt _020AFF2C
	ldr r0, _020AFFB0 // =aLen0_2
	ldr r1, _020AFF98 // =aGpiutilityC
	mov r2, #0
	mov r3, #0x110
	bl __msl_assertion_failed
_020AFF2C:
	ldrsb r6, [r8, #0]
	mov r0, r5
	mov r1, r8
	bl strstr
	movs r5, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r8
	bl strlen
	add r3, r5, r0
	sub r0, r7, #1
	mov r2, #0
	b _020AFF68
_020AFF60:
	strb r1, [r4, r2]
	add r2, r2, #1
_020AFF68:
	cmp r2, r0
	bge _020AFF84
	ldrsb r1, [r3, r2]
	cmp r1, #0
	beq _020AFF84
	cmp r1, r6
	bne _020AFF60
_020AFF84:
	mov r0, #0
	strb r0, [r4, r2]
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020AFF94: .word aCommandNull
_020AFF98: .word aGpiutilityC
_020AFF9C: .word 0x0000010D
_020AFFA0: .word aKeyNull
_020AFFA4: .word 0x0000010E
_020AFFA8: .word aValueNull
_020AFFAC: .word 0x0000010F
_020AFFB0: .word aLen0_2
	arm_func_end sub_20AFEAC

	arm_func_start sub_20AFFB4
sub_20AFFB4: // 0x020AFFB4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r6, r1
	mov r7, r0
	mov r5, r2
	ldr r1, _020B007C // =aError_0
	mov r0, r6
	mov r2, #7
	ldr r4, [r7, #0]
	bl strncmp
	cmp r0, #0
	bne _020B0070
	ldr r1, _020B0080 // =aErr
	add r2, sp, #0
	mov r0, r6
	mov r3, #0x10
	bl sub_20AFEAC
	cmp r0, #0
	beq _020B000C
	add r0, sp, #0
	bl atoi
	str r0, [r4, #0x418]
_020B000C:
	ldr r1, _020B0084 // =aErrmsg
	mov r0, r6
	mov r2, r4
	mov r3, #0x100
	bl sub_20AFEAC
	cmp r0, #0
	moveq r0, #0
	streqb r0, [r4]
	cmp r5, #0
	beq _020B0064
	ldr r1, _020B0088 // =aFatal_0
	mov r0, r6
	bl strstr
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	cmp r0, #0
	movne r2, #1
	moveq r2, #0
	mov r0, r7
	mov r1, #4
	bl sub_20A81BC
_020B0064:
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B0070:
	mov r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B007C: .word aError_0
_020B0080: .word aErr
_020B0084: .word aErrmsg
_020B0088: .word aFatal_0
	arm_func_end sub_20AFFB4

	arm_func_start sub_20B008C
sub_20B008C: // 0x020B008C
	stmdb sp!, {r0, r1, r2, r3}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20B008C

	arm_func_start sub_20B0098
sub_20B0098: // 0x020B0098
	stmdb sp!, {r4, r5, r6, lr}
	movs r6, r0
	mov r5, r1
	mov r4, r2
	bne _020B00C0
	ldr r0, _020B00FC // =aDestNull
	ldr r1, _020B0100 // =aGpiutilityC
	mov r2, #0
	mov r3, #0x2f
	bl __msl_assertion_failed
_020B00C0:
	cmp r5, #0
	bne _020B00DC
	ldr r0, _020B0104 // =aSrcNull
	ldr r1, _020B0100 // =aGpiutilityC
	mov r2, #0
	mov r3, #0x30
	bl __msl_assertion_failed
_020B00DC:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl strncpy
	add r0, r6, r4
	mov r1, #0
	strb r1, [r0, #-1]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B00FC: .word aDestNull
_020B0100: .word aGpiutilityC
_020B0104: .word aSrcNull
	arm_func_end sub_20B0098

	arm_func_start sub_20B0108
sub_20B0108: // 0x020B0108
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x24
	ldr r0, _020B01DC // =0x02144E74
	ldr r0, [r0, #0]
	cmp r0, #0
	addeq sp, sp, #0x24
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	bl ArrayLength
	subs r4, r0, #1
	bmi _020B01BC
	ldr r5, _020B01E0 // =0x0211267C
	add r3, sp, #0x14
	mov r2, #8
_020B013C:
	ldrb r1, [r5], #1
	ldrb r0, [r5], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _020B013C
	ldr r9, _020B01E4 // =0x0211E688
	ldr r5, _020B01E8 // =0x0211E674
	add r8, sp, #4
	mov r7, #0xf
	mov r6, #0
_020B0168:
	add ip, sp, #0x14
	add r3, sp, #4
	mov r2, #8
_020B0174:
	ldrb r1, [ip], #1
	ldrb r0, [ip], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _020B0174
	mov r0, r8
	mov r1, r7
	str r9, [r5]
	bl sub_20B0974
	mov r0, r4
	mov r1, r6
	mov r2, r6
	mov r3, r8
	str r6, [sp]
	bl sub_20B01EC
	subs r4, r4, #1
	bpl _020B0168
_020B01BC:
	ldr r0, _020B01DC // =0x02144E74
	ldr r0, [r0, #0]
	bl ArrayFree
	ldr r0, _020B01DC // =0x02144E74
	mov r1, #0
	str r1, [r0]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020B01DC: .word 0x02144E74
_020B01E0: .word 0x0211267C
_020B01E4: .word 0x0211E688
_020B01E8: .word 0x0211E674
	arm_func_end sub_20B0108

	arm_func_start sub_20B01EC
sub_20B01EC: // 0x020B01EC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	addmi sp, sp, #0x14
	ldmmiia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _020B030C // =0x02144E74
	ldr r0, [r0, #0]
	bl ArrayLength
	cmp r7, r0
	addge sp, sp, #0x14
	ldmgeia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _020B030C // =0x02144E74
	mov r1, r7
	ldr r0, [r0, #0]
	bl ArrayNth
	mov r3, r0
	ldr ip, [r3, #0x18]
	cmp ip, #0
	beq _020B02F4
	ldr r0, [r3, #0]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _020B02F4
_020B0254: // jump table
	b _020B0264 // case 0
	b _020B0284 // case 1
	b _020B02B8 // case 2
	b _020B02E0 // case 3
_020B0264:
	ldr r0, [r3, #0x14]
	mov r2, r6
	str r0, [sp]
	ldr r0, [r3, #4]
	ldr r1, [r3, #8]
	mov r3, r4
	blx ip
	b _020B02F4
_020B0284:
	str r6, [sp]
	str r5, [sp, #4]
	ldr r0, [sp, #0x28]
	str r4, [sp, #8]
	str r0, [sp, #0xc]
	ldr r0, [r3, #0x14]
	str r0, [sp, #0x10]
	ldr r0, [r3, #4]
	ldr r1, [r3, #8]
	ldr r2, [r3, #0xc]
	ldr r3, [r3, #0x10]
	blx ip
	b _020B02F4
_020B02B8:
	str r6, [sp]
	str r5, [sp, #4]
	ldr r0, [r3, #0x14]
	str r0, [sp, #8]
	ldr r0, [r3, #4]
	ldr r1, [r3, #8]
	ldr r2, [r3, #0xc]
	ldr r3, [r3, #0x10]
	blx ip
	b _020B02F4
_020B02E0:
	ldr r0, [r3, #4]
	ldr r1, [r3, #8]
	ldr r3, [r3, #0x14]
	mov r2, r6
	blx ip
_020B02F4:
	ldr r0, _020B030C // =0x02144E74
	mov r1, r7
	ldr r0, [r0, #0]
	bl ArrayDeleteAt
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B030C: .word 0x02144E74
	arm_func_end sub_20B01EC

	arm_func_start sub_20B0310
sub_20B0310: // 0x020B0310
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r9, r1
	mov r10, r0
	mov r7, r9
	bl sub_20B07F8
	mov r8, r0
	ldr r5, _020B0390 // =0x0211E678
	ldr r4, _020B0394 // =0x0211E674
	b _020B0378
_020B0334:
	sub r6, r8, r10
	mov r0, r10
	mov r1, r6
	str r5, [r4]
	bl sub_20B0974
	mov r0, r10
	mov r1, r6
	bl sub_20B0398
	add r0, r6, #7
	sub r9, r9, r0
	cmp r9, #0
	add r10, r8, #7
	ble _020B0378
	mov r0, r10
	mov r1, r9
	bl sub_20B07F8
	mov r8, r0
_020B0378:
	cmp r9, #0
	ble _020B0388
	cmp r8, #0
	bne _020B0334
_020B0388:
	sub r0, r7, r9
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020B0390: .word 0x0211E678
_020B0394: .word 0x0211E674
	arm_func_end sub_20B0310

	arm_func_start sub_20B0398
sub_20B0398: // 0x020B0398
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	ldr r1, _020B048C // =aPauthr
	mov r5, r0
	mov r3, #0
	mov r2, #8
	strb r3, [r5, r4]
	bl strncmp
	cmp r0, #0
	bne _020B03D8
	mov r0, r5
	mov r1, r4
	bl sub_20B06BC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020B03D8:
	ldr r1, _020B0490 // =aGetpidr
	mov r0, r5
	mov r2, #9
	bl strncmp
	cmp r0, #0
	bne _020B0404
	mov r0, r5
	mov r1, r4
	bl sub_20B0624
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020B0404:
	ldr r1, _020B0490 // =aGetpidr
	mov r0, r5
	mov r2, #9
	bl strncmp
	cmp r0, #0
	bne _020B0430
	mov r0, r5
	mov r1, r4
	bl sub_20B0624
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020B0430:
	ldr r1, _020B0494 // =aGetpdr
	mov r0, r5
	mov r2, #8
	bl strncmp
	cmp r0, #0
	bne _020B045C
	mov r0, r5
	mov r1, r4
	bl sub_20B0540
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020B045C:
	ldr r1, _020B0498 // =aSetpdr
	mov r0, r5
	mov r2, #8
	bl strncmp
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl sub_20B049C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B048C: .word aPauthr
_020B0490: .word aGetpidr
_020B0494: .word aGetpdr
_020B0498: .word aSetpdr
	arm_func_end sub_20B0398

	arm_func_start sub_20B049C
sub_20B049C: // 0x020B049C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r1, _020B0530 // =aSetpdr_0
	mov r7, r0
	bl sub_20B0884
	bl atoi
	mov r6, r0
	ldr r1, _020B0534 // =0x0211E6D0
	mov r0, r7
	bl sub_20B0884
	bl atoi
	mov r5, r0
	ldr r1, _020B0538 // =0x0211E6D4
	mov r0, r7
	bl sub_20B0884
	bl atoi
	mov r4, r0
	ldr r1, _020B053C // =0x0211E6D8
	mov r0, r7
	bl sub_20B0884
	bl atoi
	mov r1, r4
	mov r4, r0
	mov r2, r5
	mov r0, #2
	bl sub_20B076C
	mvn r1, #0
	cmp r0, r1
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r3, #0
	mov r1, r6
	mov r2, r4
	str r3, [sp]
	bl sub_20B01EC
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B0530: .word aSetpdr_0
_020B0534: .word 0x0211E6D0
_020B0538: .word 0x0211E6D4
_020B053C: .word 0x0211E6D8
	arm_func_end sub_20B049C

	arm_func_start sub_20B0540
sub_20B0540: // 0x020B0540
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r1, _020B0608 // =aGetpdr_0
	mov r4, r0
	bl sub_20B0884
	bl atoi
	mov r7, r0
	ldr r1, _020B060C // =0x0211E6D4
	mov r0, r4
	bl sub_20B0884
	bl atoi
	mov r6, r0
	ldr r1, _020B0610 // =0x0211E6D0
	mov r0, r4
	bl sub_20B0884
	bl atoi
	mov r5, r0
	ldr r1, _020B0614 // =0x0211E6D8
	mov r0, r4
	bl sub_20B0884
	bl atoi
	mov r2, r5
	mov r5, r0
	mov r1, r6
	mov r0, #1
	bl sub_20B076C
	mov r8, r0
	mvn r0, #0
	cmp r8, r0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, _020B0618 // =aLength
	mov r0, r4
	bl sub_20B0884
	bl atoi
	mov r6, r0
	ldr r1, _020B061C // =aData_3
	mov r0, r4
	bl strstr
	cmp r0, #0
	ldreq r3, _020B0620 // =0x0211E6F4
	moveq r6, #0
	addne r3, r0, #6
	mov r0, r8
	mov r1, r7
	mov r2, r5
	str r6, [sp]
	bl sub_20B01EC
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020B0608: .word aGetpdr_0
_020B060C: .word 0x0211E6D4
_020B0610: .word 0x0211E6D0
_020B0614: .word 0x0211E6D8
_020B0618: .word aLength
_020B061C: .word aData_3
_020B0620: .word 0x0211E6F4
	arm_func_end sub_20B0540

	arm_func_start sub_20B0624
sub_20B0624: // 0x020B0624
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _020B06B0 // =aGetpidr_0
	mov r5, r0
	bl sub_20B0884
	bl atoi
	mov r4, r0
	ldr r1, _020B06B4 // =0x0211E6D4
	mov r0, r5
	bl sub_20B0884
	bl atoi
	mov r1, r0
	mov r0, #3
	mov r2, #0
	bl sub_20B076C
	mov r5, r0
	mvn r0, #0
	cmp r5, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, _020B06B8 // =0x02144E74
	mov r1, r5
	ldr r0, [r0, #0]
	bl ArrayNth
	cmp r4, #0
	movgt r1, #1
	mov r2, #0
	str r4, [r0, #8]
	movle r1, #0
	mov r0, r5
	mov r3, r2
	str r2, [sp]
	bl sub_20B01EC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B06B0: .word aGetpidr_0
_020B06B4: .word 0x0211E6D4
_020B06B8: .word 0x02144E74
	arm_func_end sub_20B0624

	arm_func_start sub_20B06BC
sub_20B06BC: // 0x020B06BC
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r1, _020B075C // =aPauthr_0
	mov r6, r0
	bl sub_20B0884
	bl atoi
	mov r5, r0
	ldr r1, _020B0760 // =0x0211E6D4
	mov r0, r6
	bl sub_20B0884
	bl atoi
	mov r4, r0
	ldr r1, _020B0764 // =aErrmsg_0
	mov r0, r6
	bl sub_20B0884
	mov r1, r4
	mov r4, r0
	mov r0, #0
	mov r2, r0
	bl sub_20B076C
	mov r6, r0
	mvn r0, #0
	cmp r6, r0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _020B0768 // =0x02144E74
	mov r1, r6
	ldr r0, [r0, #0]
	bl ArrayNth
	cmp r5, #0
	movgt r1, #1
	str r5, [r0, #8]
	mov r2, #0
	movle r1, #0
	mov r0, r6
	mov r3, r4
	str r2, [sp]
	bl sub_20B01EC
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B075C: .word aPauthr_0
_020B0760: .word 0x0211E6D4
_020B0764: .word aErrmsg_0
_020B0768: .word 0x02144E74
	arm_func_end sub_20B06BC

	arm_func_start sub_20B076C
sub_20B076C: // 0x020B076C
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr r3, _020B07F4 // =0x02144E74
	mov r7, r0
	ldr r0, [r3, #0]
	mov r6, r1
	cmp r0, #0
	mov r5, r2
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r4, #0
	bl ArrayLength
	cmp r0, #0
	ble _020B07EC
	ldr r8, _020B07F4 // =0x02144E74
_020B07A4:
	ldr r0, [r8, #0]
	mov r1, r4
	bl ArrayNth
	ldr r1, [r0, #0]
	cmp r1, r7
	bne _020B07D8
	ldr r1, [r0, #4]
	cmp r1, r6
	bne _020B07D8
	ldr r0, [r0, #8]
	cmp r0, r5
	moveq r0, r4
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_020B07D8:
	ldr r0, [r8, #0]
	add r4, r4, #1
	bl ArrayLength
	cmp r4, r0
	blt _020B07A4
_020B07EC:
	mvn r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020B07F4: .word 0x02144E74
	arm_func_end sub_20B076C

	arm_func_start sub_20B07F8
sub_20B07F8: // 0x020B07F8
	sub r2, r1, #6
	mov r3, r0
	cmp r2, #0
	ble _020B0870
_020B0808:
	ldrsb r1, [r3, #0]
	cmp r1, #0x5c
	bne _020B0860
	ldrsb r1, [r3, #1]
	cmp r1, #0x66
	bne _020B0860
	ldrsb r1, [r3, #2]
	cmp r1, #0x69
	bne _020B0860
	ldrsb r1, [r3, #3]
	cmp r1, #0x6e
	bne _020B0860
	ldrsb r1, [r3, #4]
	cmp r1, #0x61
	bne _020B0860
	ldrsb r1, [r3, #5]
	cmp r1, #0x6c
	bne _020B0860
	ldrsb r1, [r3, #6]
	cmp r1, #0x5c
	moveq r0, r3
	bxeq lr
_020B0860:
	add r3, r3, #1
	sub r1, r3, r0
	cmp r1, r2
	blt _020B0808
_020B0870:
	mov r0, #0
	bx lr
	arm_func_end sub_20B07F8

	arm_func_start sub_20B0878
sub_20B0878: // 0x020B0878
	ldr ip, _020B0880 // =sub_20A0974
	bx ip
	.align 2, 0
_020B0880: .word sub_20A0974
	arm_func_end sub_20B0878

	arm_func_start sub_20B0884
sub_20B0884: // 0x020B0884
	stmdb sp!, {lr}
	sub sp, sp, #4
	bl sub_20B08A4
	cmp r0, #0
	ldreq r0, _020B08A0 // =0x0211E6F4
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020B08A0: .word 0x0211E6F4
	arm_func_end sub_20B0884

	arm_func_start sub_20B08A4
sub_20B08A4: // 0x020B08A4
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x100
	ldr lr, _020B0964 // =0x0211268C
	add ip, sp, #0
	mov r4, r0
	mov r3, #0x80
_020B08BC:
	ldrb r2, [lr], #1
	ldrb r0, [lr], #1
	subs r3, r3, #1
	strb r2, [ip], #1
	strb r0, [ip], #1
	bne _020B08BC
	ldr r2, _020B0968 // =0x02144E7C
	add r0, sp, #0
	ldr r3, [r2, #0]
	eor r3, r3, #1
	str r3, [r2]
	bl strcat
	ldr r1, _020B096C // =0x0211E710
	add r0, sp, #0
	bl strcat
	add r1, sp, #0
	mov r0, r4
	bl strstr
	movs r4, r0
	addeq sp, sp, #0x100
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, sp, #0
	bl strlen
	ldr r1, _020B0968 // =0x02144E7C
	ldr r2, _020B0970 // =0x02145084
	ldr r1, [r1, #0]
	add r3, r4, r0
	add r0, r2, r1, lsl #8
	mov r2, r0
	b _020B0940
_020B0938:
	ldrsb r1, [r3], #1
	strb r1, [r2], #1
_020B0940:
	ldrsb r1, [r3, #0]
	cmp r1, #0
	beq _020B0954
	cmp r1, #0x5c
	bne _020B0938
_020B0954:
	mov r1, #0
	strb r1, [r2]
	add sp, sp, #0x100
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B0964: .word 0x0211268C
_020B0968: .word 0x02144E7C
_020B096C: .word 0x0211E710
_020B0970: .word 0x02145084
	arm_func_end sub_20B08A4

	arm_func_start sub_20B0974
sub_20B0974: // 0x020B0974
	stmdb sp!, {r4, lr}
	ldr r2, _020B09B8 // =0x0211E674
	mov r4, #0
	cmp r1, #0
	ldr lr, [r2]
	ldmleia sp!, {r4, pc}
_020B098C:
	ldrsb ip, [r0, r4]
	ldrsb r3, [lr]
	eor r3, ip, r3
	strb r3, [r0, r4]
	ldrsb r3, [lr, #1]!
	add r4, r4, #1
	cmp r3, #0
	ldreq lr, [r2]
	cmp r4, r1
	blt _020B098C
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B09B8: .word 0x0211E674
	arm_func_end sub_20B0974

	arm_func_start DWC__PersistThink
DWC__PersistThink: // 0x020B09BC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	ldr r0, _020B0B04 // =_0211E670
	mvn r1, #0
	ldr r0, [r0, #0]
	cmp r0, r1
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r1, _020B0B08 // =0x02144E78
	ldr r1, [r1, #0]
	cmp r1, #5
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl sub_20B0878
	cmp r0, #0
	beq _020B0AE8
	ldr r8, _020B0B0C // =0x02144E70
	ldr r10, _020B0B10 // =0x02144E80
	ldr r9, _020B0B14 // =0x02144E6C
	ldr r7, _020B0B04 // =_0211E670
	mov r6, #0x100
	mov r5, #0
_020B0A10:
	ldr r1, [r10, #0]
	ldr r0, [r9, #0]
	sub r0, r1, r0
	cmp r0, #0x80
	bge _020B0A54
	cmp r1, #0x100
	strlt r6, [r10]
	movge r0, r1, lsl #1
	strge r0, [r10]
	ldr r1, [r10, #0]
	ldr r0, [r8, #0]
	add r1, r1, #1
	bl DWCi_GsRealloc
	str r0, [r8]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020B0A54:
	ldr r4, [r9, #0]
	ldr r1, [r8, #0]
	ldr r2, [r10, #0]
	ldr r0, [r7, #0]
	mov r3, r5
	add r1, r1, r4
	sub r2, r2, r4
	bl sub_20A06C0
	cmp r0, #0
	bgt _020B0A88
	bl CloseStatsConnection
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020B0A88:
	ldr r2, [r9, #0]
	ldr r1, [r8, #0]
	add r0, r2, r0
	str r0, [r9]
	strb r5, [r1, r0]
	ldr r0, [r8, #0]
	ldr r1, [r9, #0]
	bl sub_20B0310
	ldr r1, [r9, #0]
	mov r4, r0
	cmp r4, r1
	streq r5, [r9]
	beq _020B0AD8
	ldr r0, [r8, #0]
	sub r2, r1, r4
	add r1, r0, r4
	bl memmove
	ldr r0, [r9, #0]
	sub r0, r0, r4
	str r0, [r9]
_020B0AD8:
	ldr r0, [r7, #0]
	bl sub_20B0878
	cmp r0, #0
	bne _020B0A10
_020B0AE8:
	ldr r1, _020B0B04 // =_0211E670
	mvn r0, #0
	ldr r1, [r1, #0]
	cmp r1, r0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020B0B04: .word _0211E670
_020B0B08: .word 0x02144E78
_020B0B0C: .word 0x02144E70
_020B0B10: .word 0x02144E80
_020B0B14: .word 0x02144E6C
	arm_func_end DWC__PersistThink

	arm_func_start DWC__IsStatsConnected
DWC__IsStatsConnected: // 0x020B0B18
	ldr r1, _020B0B34 // =_0211E670
	mvn r0, #0
	ldr r1, [r1, #0]
	cmp r1, r0
	movne r0, #1
	moveq r0, #0
	bx lr
	.align 2, 0
_020B0B34: .word _0211E670
	arm_func_end DWC__IsStatsConnected

	arm_func_start CloseStatsConnection
CloseStatsConnection: // 0x020B0B38
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020B0BB4 // =_0211E670
	mvn r1, #0
	ldr r0, [r0, #0]
	cmp r0, r1
	beq _020B0B68
	mov r1, #2
	bl sub_20A07C8
	ldr r0, _020B0BB4 // =_0211E670
	ldr r0, [r0, #0]
	bl sub_20A07E4
_020B0B68:
	ldr r0, _020B0BB4 // =_0211E670
	mvn r1, #0
	str r1, [r0]
	bl sub_20B0108
	ldr r0, _020B0BB8 // =0x02144E70
	ldr r0, [r0, #0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl DWCi_GsFree
	ldr r2, _020B0BB8 // =0x02144E70
	mov r3, #0
	ldr r1, _020B0BBC // =0x02144E80
	ldr r0, _020B0BC0 // =0x02144E6C
	str r3, [r2]
	str r3, [r1]
	str r3, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020B0BB4: .word _0211E670
_020B0BB8: .word 0x02144E70
_020B0BBC: .word 0x02144E80
_020B0BC0: .word 0x02144E6C
	arm_func_end CloseStatsConnection

	arm_func_start sub_20B0BC4
sub_20B0BC4: // 0x020B0BC4
	mov ip, #0
_020B0BC8:
	cmp ip, #0
	beq _020B0BEC
	cmp ip, #0xd
	beq _020B0BEC
	ldrb r3, [r0, ip]
	ldrb r2, [r1, ip]
	cmp r3, r2
	movne r0, #0
	bxne lr
_020B0BEC:
	add ip, ip, #1
	cmp ip, #0x20
	blt _020B0BC8
	mov r0, #1
	bx lr
	arm_func_end sub_20B0BC4

	arm_func_start sub_20B0C00
sub_20B0C00: // 0x020B0C00
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, _020B0D28 // =a3b8dd8995f7c40
	mov r4, r1
	bl strlen
	mov r8, r0
	mov r0, r4
	bl sub_20B0E78
	mov r10, #0
	mov r11, r0
	mov r7, r10
_020B0C30:
	cmp r11, #0
	beq _020B0C48
	cmp r10, #0
	beq _020B0C48
	cmp r10, #0xd
	bne _020B0C78
_020B0C48:
	bl rand
	ldr r1, _020B0D2C // =0x2C0B02C1
	smull r2, r3, r1, r0
	mov r3, r3, asr #4
	mov r1, r0, lsr #0x1f
	add r3, r1, r3
	ldr r1, _020B0D30 // =0x0000005D
	smull r2, r3, r1, r3
	sub r3, r0, r2
	add r0, r3, #0x21
	strb r0, [r5, r10]
	b _020B0D08
_020B0C78:
	cmp r10, #1
	beq _020B0C88
	cmp r10, #0xe
	bne _020B0C90
_020B0C88:
	ldrsb r9, [r4, r10]
	b _020B0C98
_020B0C90:
	sub r0, r10, #1
	ldrsb r9, [r4, r0]
_020B0C98:
	ldrb r6, [r4, r10]
	mov r1, r8
	add r0, r10, r6
	bl _s32_div_f
	mul r0, r9, r7
	mov r9, r1
	mov r1, r8
	bl _s32_div_f
	ldr r0, _020B0D28 // =a3b8dd8995f7c40
	ldrsb r3, [r0, r9]
	ldrsb r2, [r0, r1]
	mla r0, r10, r6, r3
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #27
	add r0, r1, r0, ror #27
	ldrb r0, [r4, r0]
	eor r0, r0, r2
	bl abs
	ldr r1, _020B0D2C // =0x2C0B02C1
	smull r2, r3, r1, r0
	mov r3, r3, asr #4
	mov r1, r0, lsr #0x1f
	add r3, r1, r3
	ldr r1, _020B0D30 // =0x0000005D
	smull r2, r3, r1, r3
	sub r3, r0, r2
	add r0, r3, #0x21
	strb r0, [r5, r10]
_020B0D08:
	ldr r0, _020B0D34 // =0x00004647
	add r10, r10, #1
	cmp r10, #0x20
	add r7, r7, r0
	blt _020B0C30
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B0D28: .word a3b8dd8995f7c40
_020B0D2C: .word 0x2C0B02C1
_020B0D30: .word 0x0000005D
_020B0D34: .word 0x00004647
	arm_func_end sub_20B0C00

	arm_func_start sub_20B0D38
sub_20B0D38: // 0x020B0D38
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	movs r10, r0
	bne _020B0D5C
	ldr r0, _020B0E68 // =aBuffer_0
	ldr r1, _020B0E6C // =aGt2authC
	mov r2, #0
	mov r3, #0x2b
	bl __msl_assertion_failed
_020B0D5C:
	bl sub_20A0CA4
	bl srand
	bl rand
	ldr r1, _020B0E70 // =0x2C0B02C1
	mov r2, r0, lsr #0x1f
	smull r3, r4, r1, r0
	mov r8, #0
	mov r4, r4, asr #4
	mov r9, #1
	ldr r1, _020B0E74 // =0x0000005D
	add r4, r2, r4
	smull r2, r3, r1, r4
	sub r4, r0, r2
	add r0, r4, #0x21
	strb r0, [r10]
	mov r5, r8
	mov r6, r9
	mov r11, r8
	mov r4, r9
_020B0DA8:
	sub r0, r9, #1
	ldrb r2, [r10, r0]
	ldrb r3, [r10, #0]
	add r7, r10, r9
	cmp r2, r3
	eor r2, r9, r2
	movlo r0, r6
	and r2, r2, #1
	movhs r0, r5
	cmp r3, #0x4f
	movlo r1, r4
	and r3, r3, #1
	eor r2, r8, r2
	movhs r1, r11
	eor r2, r3, r2
	eor r1, r2, r1
	eor r8, r1, r0
	bl rand
	ldr r2, _020B0E70 // =0x2C0B02C1
	cmp r8, #0
	smull r3, r1, r2, r0
	mov r1, r1, asr #4
	mov r2, r0, lsr #0x1f
	add r1, r2, r1
	ldr r2, _020B0E74 // =0x0000005D
	smull r1, r3, r2, r1
	sub r1, r0, r1
	add r0, r1, #0x21
	strb r0, [r10, r9]
	beq _020B0E2C
	ldrb r0, [r7, #0]
	ands r0, r0, #1
	beq _020B0E44
_020B0E2C:
	cmp r8, #0
	bne _020B0E50
	ldrb r0, [r7, #0]
	and r0, r0, #1
	cmp r0, #1
	bne _020B0E50
_020B0E44:
	ldrb r0, [r7, #0]
	add r0, r0, #1
	strb r0, [r7]
_020B0E50:
	add r9, r9, #1
	cmp r9, #0x20
	blt _020B0DA8
	mov r0, r10
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B0E68: .word aBuffer_0
_020B0E6C: .word aGt2authC
_020B0E70: .word 0x2C0B02C1
_020B0E74: .word 0x0000005D
	arm_func_end sub_20B0D38

	arm_func_start sub_20B0E78
sub_20B0E78: // 0x020B0E78
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	ldrb r4, [r0, #0]
	mov r6, #0
	mov r5, #1
	and lr, r4, #1
	mov r3, r6
	mov ip, r5
	mov r1, r6
	mov r2, r5
_020B0EA0:
	sub r7, r5, #1
	ldrb r9, [r0, r7]
	cmp r9, r4
	eor r9, r5, r9
	movlo r7, ip
	and r9, r9, #1
	movhs r7, r3
	cmp r4, #0x4f
	movlo r8, r2
	eor r6, r6, r9
	movhs r8, r1
	eor r6, lr, r6
	eor r6, r6, r8
	eors r6, r6, r7
	beq _020B0EE8
	ldrb r7, [r0, r5]
	ands r7, r7, #1
	beq _020B0F00
_020B0EE8:
	cmp r6, #0
	bne _020B0F0C
	ldrb r7, [r0, r5]
	and r7, r7, #1
	cmp r7, #1
	bne _020B0F0C
_020B0F00:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B0F0C:
	add r5, r5, #1
	cmp r5, #0x20
	blt _020B0EA0
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end sub_20B0E78

	arm_func_start sub_20B0F24
sub_20B0F24: // 0x020B0F24
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mvn r1, #0
	mov r6, r0
	cmp r5, r1
	ldreq r0, [r6, #8]
	mov r4, r2
	subeq r5, r0, r4
	ldr r0, [r6, #8]
	cmp r5, r0
	ble _020B0F64
	ldr r0, _020B0FB4 // =aStartBufferLen
	ldr r1, _020B0FB8 // =aGt2bufferC
	mov r2, #0
	mov r3, #0x4f
	bl __msl_assertion_failed
_020B0F64:
	ldr r0, [r6, #8]
	sub r0, r0, r5
	cmp r4, r0
	ble _020B0F88
	ldr r0, _020B0FBC // =aShortenbyBuffe
	ldr r1, _020B0FB8 // =aGt2bufferC
	mov r2, #0
	mov r3, #0x50
	bl __msl_assertion_failed
_020B0F88:
	ldr r0, [r6, #0]
	ldr r1, [r6, #8]
	add r0, r0, r5
	sub r2, r1, r5
	add r1, r0, r4
	sub r2, r2, r4
	bl memmove
	ldr r0, [r6, #8]
	sub r0, r0, r4
	str r0, [r6, #8]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B0FB4: .word aStartBufferLen
_020B0FB8: .word aGt2bufferC
_020B0FBC: .word aShortenbyBuffe
	arm_func_end sub_20B0F24

	arm_func_start sub_20B0FC0
sub_20B0FC0: // 0x020B0FC0
	stmdb sp!, {r4, r5, r6, lr}
	movs r5, r1
	mov r6, r0
	mov r4, r2
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r4, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mvn r0, #0
	cmp r4, r0
	bne _020B0FF4
	mov r0, r5
	bl strlen
	mov r4, r0
_020B0FF4:
	ldr r1, [r6, #8]
	ldr r0, [r6, #4]
	add r1, r1, r4
	cmp r1, r0
	ble _020B101C
	ldr r0, _020B1044 // =aBufferLenLenBu
	ldr r1, _020B1048 // =aGt2bufferC
	mov r2, #0
	mov r3, #0x40
	bl __msl_assertion_failed
_020B101C:
	ldr r3, [r6, #0]
	ldr r0, [r6, #8]
	mov r1, r5
	mov r2, r4
	add r0, r3, r0
	bl memcpy
	ldr r0, [r6, #8]
	add r0, r0, r4
	str r0, [r6, #8]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B1044: .word aBufferLenLenBu
_020B1048: .word aGt2bufferC
	arm_func_end sub_20B0FC0

	arm_func_start sub_20B104C
sub_20B104C: // 0x020B104C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r2, [r5, #8]
	ldr r0, [r5, #4]
	add r2, r2, #2
	mov r4, r1
	cmp r2, r0
	ble _020B1084
	ldr r0, _020B10B8 // =aBufferLen2Buff
	ldr r1, _020B10BC // =aGt2bufferC
	mov r2, #0
	mov r3, #0x2e
	bl __msl_assertion_failed
_020B1084:
	ldr r2, [r5, #8]
	mov r1, r4, asr #8
	add r0, r2, #1
	str r0, [r5, #8]
	ldr r0, [r5, #0]
	strb r1, [r0, r2]
	ldr r1, [r5, #8]
	add r0, r1, #1
	str r0, [r5, #8]
	ldr r0, [r5, #0]
	strb r4, [r0, r1]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B10B8: .word aBufferLen2Buff
_020B10BC: .word aGt2bufferC
	arm_func_end sub_20B104C

	arm_func_start sub_20B10C0
sub_20B10C0: // 0x020B10C0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r2, [r5, #8]
	ldr r0, [r5, #4]
	mov r4, r1
	cmp r2, r0
	blt _020B10F4
	ldr r0, _020B1110 // =aBufferLenBuffe
	ldr r1, _020B1114 // =aGt2bufferC
	mov r2, #0
	mov r3, #0x23
	bl __msl_assertion_failed
_020B10F4:
	ldr r1, [r5, #8]
	add r0, r1, #1
	str r0, [r5, #8]
	ldr r0, [r5, #0]
	strb r4, [r0, r1]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B1110: .word aBufferLenBuffe
_020B1114: .word aGt2bufferC
	arm_func_end sub_20B10C0

	arm_func_start sub_20B1118
sub_20B1118: // 0x020B1118
	ldr r1, [r0, #4]
	ldr r0, [r0, #8]
	sub r0, r1, r0
	bx lr
	arm_func_end sub_20B1118

	arm_func_start sub_20B1128
sub_20B1128: // 0x020B1128
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r5, r0
	mov r0, r4
	bl DWCi_GsMalloc
	str r0, [r5]
	ldr r0, [r5, #0]
	cmp r0, #0
	moveq r0, #0
	strne r4, [r5, #4]
	movne r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B1128

	arm_func_start sub_20B1160
sub_20B1160: // 0x020B1160
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ldr r4, [sp, #0x24]
	mov r6, r2
	mov r2, #0
	movs r8, r0
	mov r7, r1
	mov r5, r3
	str r2, [r4]
	bne _020B1198
	ldr r0, _020B124C // =aSocket
	ldr r1, _020B1250 // =aGt2callbackC
	ldr r3, _020B1254 // =0x00000197
	bl __msl_assertion_failed
_020B1198:
	cmp r8, #0
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [r8, #0x30]
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [sp, #0x20]
	cmp r0, #0
	beq _020B11D0
	cmp r5, #0
	bne _020B11D8
_020B11D0:
	mov r5, #0
	str r5, [sp, #0x20]
_020B11D8:
	ldr r1, [r8, #0x1c]
	ldr r0, [sp, #0x20]
	add r1, r1, #1
	str r1, [r8, #0x1c]
	str r0, [sp]
	ldr ip, [r8, #0x30]
	mov r0, r8
	mov r1, r7
	mov r2, r6
	mov r3, r5
	blx ip
	str r0, [r4]
	ldr r0, [r8, #0x1c]
	sub r0, r0, #1
	str r0, [r8, #0x1c]
	ldr r0, [r8, #0x14]
	cmp r0, #0
	beq _020B1240
	ldr r0, [r8, #0x1c]
	cmp r0, #0
	bne _020B1240
	mov r0, r8
	bl sub_20B46C0
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020B1240:
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020B124C: .word aSocket
_020B1250: .word aGt2callbackC
_020B1254: .word 0x00000197
	arm_func_end sub_20B1160

	arm_func_start sub_20B1258
sub_20B1258: // 0x020B1258
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bne _020B1288
	ldr r0, _020B1378 // =aSocket
	ldr r1, _020B137C // =aGt2callbackC
	mov r2, #0
	mov r3, #0x160
	bl __msl_assertion_failed
_020B1288:
	cmp r7, #0
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [sp, #0x2c]
	cmp r0, #0
	ldrne ip, [r7, #0x28]
	ldreq ip, [r7, #0x2c]
	cmp ip, #0
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [sp, #0x28]
	cmp r0, #0
	beq _020B12D0
	ldr r0, [sp, #0x24]
	cmp r0, #0
	bne _020B12DC
_020B12D0:
	mov r0, #0
	str r0, [sp, #0x24]
	str r0, [sp, #0x28]
_020B12DC:
	ldr r0, [r7, #0x1c]
	cmp r6, #0
	add r0, r0, #1
	str r0, [r7, #0x1c]
	ldrne r0, [r6, #0x24]
	ldr r1, [sp, #0x20]
	addne r0, r0, #1
	strne r0, [r6, #0x24]
	str r1, [sp]
	ldr r0, [sp, #0x24]
	ldr lr, [sp, #0x28]
	str r0, [sp, #4]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	str lr, [sp, #8]
	blx ip
	ldr r0, [r7, #0x1c]
	cmp r6, #0
	sub r0, r0, #1
	str r0, [r7, #0x1c]
	ldrne r0, [r6, #0x24]
	subne r0, r0, #1
	strne r0, [r6, #0x24]
	ldr r0, [r7, #0x14]
	cmp r0, #0
	beq _020B136C
	ldr r0, [r7, #0x1c]
	cmp r0, #0
	bne _020B136C
	mov r0, r7
	bl sub_20B46C0
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B136C:
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B1378: .word aSocket
_020B137C: .word aGt2callbackC
	arm_func_end sub_20B1258

	arm_func_start sub_20B1380
sub_20B1380: // 0x020B1380
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bne _020B13B0
	ldr r0, _020B1484 // =aConnection_7
	ldr r1, _020B1488 // =aGt2callbackC
	ldr r3, _020B148C // =0x0000012D
	mov r2, #0
	bl __msl_assertion_failed
_020B13B0:
	cmp r7, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r7, #0x9c]
	mov r1, r6
	bl ArrayNth
	movs lr, r0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r4, #0
	beq _020B13EC
	cmp r5, #0
	bne _020B13F4
_020B13EC:
	mov r5, #0
	mov r4, r5
_020B13F4:
	ldr r0, [r7, #0x24]
	ldr r2, [sp, #0x18]
	add r0, r0, #1
	str r0, [r7, #0x24]
	ldr ip, [r7, #8]
	mov r0, r7
	ldr r3, [ip, #0x1c]
	mov r1, r6
	add r3, r3, #1
	str r3, [ip, #0x1c]
	str r2, [sp]
	ldr r6, [lr]
	mov r2, r5
	mov r3, r4
	blx r6
	ldr r0, [r7, #0x24]
	sub r0, r0, #1
	str r0, [r7, #0x24]
	ldr r1, [r7, #8]
	ldr r0, [r1, #0x1c]
	sub r0, r0, #1
	str r0, [r1, #0x1c]
	ldr r0, [r7, #8]
	ldr r1, [r0, #0x14]
	cmp r1, #0
	beq _020B1478
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	bne _020B1478
	bl sub_20B46C0
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B1478:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B1484: .word aConnection_7
_020B1488: .word aGt2callbackC
_020B148C: .word 0x0000012D
	arm_func_end sub_20B1380

	arm_func_start sub_20B1490
sub_20B1490: // 0x020B1490
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bne _020B14C0
	ldr r0, _020B1594 // =aConnection_7
	ldr r1, _020B1598 // =aGt2callbackC
	ldr r3, _020B159C // =0x00000101
	mov r2, #0
	bl __msl_assertion_failed
_020B14C0:
	cmp r7, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r7, #0x98]
	mov r1, r6
	bl ArrayNth
	movs lr, r0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r4, #0
	beq _020B14FC
	cmp r5, #0
	bne _020B1504
_020B14FC:
	mov r5, #0
	mov r4, r5
_020B1504:
	ldr r0, [r7, #0x24]
	ldr r2, [sp, #0x18]
	add r0, r0, #1
	str r0, [r7, #0x24]
	ldr ip, [r7, #8]
	mov r0, r7
	ldr r3, [ip, #0x1c]
	mov r1, r6
	add r3, r3, #1
	str r3, [ip, #0x1c]
	str r2, [sp]
	ldr r6, [lr]
	mov r2, r5
	mov r3, r4
	blx r6
	ldr r0, [r7, #0x24]
	sub r0, r0, #1
	str r0, [r7, #0x24]
	ldr r1, [r7, #8]
	ldr r0, [r1, #0x1c]
	sub r0, r0, #1
	str r0, [r1, #0x1c]
	ldr r0, [r7, #8]
	ldr r1, [r0, #0x14]
	cmp r1, #0
	beq _020B1588
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	bne _020B1588
	bl sub_20B46C0
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B1588:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B1594: .word aConnection_7
_020B1598: .word aGt2callbackC
_020B159C: .word 0x00000101
	arm_func_end sub_20B1490

	arm_func_start sub_20B15A0
sub_20B15A0: // 0x020B15A0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r4, r0
	mov r5, r1
	bne _020B15C8
	ldr r0, _020B166C // =aConnection_7
	ldr r1, _020B1670 // =aGt2callbackC
	mov r2, #0
	mov r3, #0xd9
	bl __msl_assertion_failed
_020B15C8:
	cmp r4, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r4, #0x34]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, [r4, #0x24]
	mov r0, r4
	add r1, r1, #1
	str r1, [r4, #0x24]
	ldr r3, [r4, #8]
	mov r1, r5
	ldr r2, [r3, #0x1c]
	add r2, r2, #1
	str r2, [r3, #0x1c]
	ldr r2, [r4, #0x34]
	blx r2
	ldr r0, [r4, #0x24]
	sub r0, r0, #1
	str r0, [r4, #0x24]
	ldr r1, [r4, #8]
	ldr r0, [r1, #0x1c]
	sub r0, r0, #1
	str r0, [r1, #0x1c]
	ldr r0, [r4, #8]
	ldr r1, [r0, #0x14]
	cmp r1, #0
	beq _020B1660
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	bne _020B1660
	bl sub_20B46C0
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020B1660:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B166C: .word aConnection_7
_020B1670: .word aGt2callbackC
	arm_func_end sub_20B15A0

	arm_func_start sub_20B1674
sub_20B1674: // 0x020B1674
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r4, r0
	mov r5, r1
	bne _020B169C
	ldr r0, _020B1740 // =aConnection_7
	ldr r1, _020B1744 // =aGt2callbackC
	mov r2, #0
	mov r3, #0xba
	bl __msl_assertion_failed
_020B169C:
	cmp r4, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r4, #0x30]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, [r4, #0x24]
	mov r0, r4
	add r1, r1, #1
	str r1, [r4, #0x24]
	ldr r3, [r4, #8]
	mov r1, r5
	ldr r2, [r3, #0x1c]
	add r2, r2, #1
	str r2, [r3, #0x1c]
	ldr r2, [r4, #0x30]
	blx r2
	ldr r0, [r4, #0x24]
	sub r0, r0, #1
	str r0, [r4, #0x24]
	ldr r1, [r4, #8]
	ldr r0, [r1, #0x1c]
	sub r0, r0, #1
	str r0, [r1, #0x1c]
	ldr r0, [r4, #8]
	ldr r1, [r0, #0x14]
	cmp r1, #0
	beq _020B1734
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	bne _020B1734
	bl sub_20B46C0
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, pc}
_020B1734:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B1740: .word aConnection_7
_020B1744: .word aGt2callbackC
	arm_func_end sub_20B1674

	arm_func_start sub_20B1748
sub_20B1748: // 0x020B1748
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bne _020B1778
	ldr r0, _020B183C // =aConnection_7
	ldr r1, _020B1840 // =aGt2callbackC
	mov r2, #0
	mov r3, #0x94
	bl __msl_assertion_failed
_020B1778:
	cmp r7, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r7, #0x2c]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r5, #0
	beq _020B17AC
	cmp r6, #0
	bne _020B17B4
_020B17AC:
	mov r6, #0
	mov r5, r6
_020B17B4:
	ldr r1, [r7, #0x24]
	mov r0, r7
	add r1, r1, #1
	str r1, [r7, #0x24]
	ldr ip, [r7, #8]
	mov r1, r6
	ldr r3, [ip, #0x1c]
	mov r2, r5
	add r3, r3, #1
	str r3, [ip, #0x1c]
	ldr r5, [r7, #0x2c]
	mov r3, r4
	blx r5
	ldr r0, [r7, #0x24]
	sub r0, r0, #1
	str r0, [r7, #0x24]
	ldr r1, [r7, #8]
	ldr r0, [r1, #0x1c]
	sub r0, r0, #1
	str r0, [r1, #0x1c]
	ldr r0, [r7, #8]
	ldr r1, [r0, #0x14]
	cmp r1, #0
	beq _020B1830
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	bne _020B1830
	bl sub_20B46C0
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B1830:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B183C: .word aConnection_7
_020B1840: .word aGt2callbackC
	arm_func_end sub_20B1748

	arm_func_start sub_20B1844
sub_20B1844: // 0x020B1844
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bne _020B1874
	ldr r0, _020B193C // =aConnection_7
	ldr r1, _020B1940 // =aGt2callbackC
	mov r2, #0
	mov r3, #0x69
	bl __msl_assertion_failed
_020B1874:
	cmp r7, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	str r6, [r7, #0x18]
	ldr r0, [r7, #0x28]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r4, #0
	beq _020B18AC
	cmp r5, #0
	bne _020B18B4
_020B18AC:
	mov r5, #0
	mov r4, r5
_020B18B4:
	ldr r1, [r7, #0x24]
	mov r0, r7
	add r1, r1, #1
	str r1, [r7, #0x24]
	ldr ip, [r7, #8]
	mov r1, r6
	ldr r3, [ip, #0x1c]
	mov r2, r5
	add r3, r3, #1
	str r3, [ip, #0x1c]
	ldr r5, [r7, #0x28]
	mov r3, r4
	blx r5
	ldr r0, [r7, #0x24]
	sub r0, r0, #1
	str r0, [r7, #0x24]
	ldr r1, [r7, #8]
	ldr r0, [r1, #0x1c]
	sub r0, r0, #1
	str r0, [r1, #0x1c]
	ldr r0, [r7, #8]
	ldr r1, [r0, #0x14]
	cmp r1, #0
	beq _020B1930
	ldr r1, [r0, #0x1c]
	cmp r1, #0
	bne _020B1930
	bl sub_20B46C0
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B1930:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B193C: .word aConnection_7
_020B1940: .word aGt2callbackC
	arm_func_end sub_20B1844

	arm_func_start sub_20B1944
sub_20B1944: // 0x020B1944
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	beq _020B1968
	cmp r6, #0
	bne _020B197C
_020B1968:
	ldr r0, _020B1A68 // =aSocketConnecti
	ldr r1, _020B1A6C // =aGt2callbackC
	mov r2, #0
	mov r3, #0x3d
	bl __msl_assertion_failed
_020B197C:
	cmp r7, #0
	beq _020B198C
	cmp r6, #0
	bne _020B1998
_020B198C:
	add sp, sp, #0xc
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B1998:
	ldr r0, [r7, #0x20]
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [sp, #0x28]
	cmp r0, #0
	beq _020B19C4
	ldr r0, [sp, #0x24]
	cmp r0, #0
	bne _020B19D0
_020B19C4:
	mov r0, #0
	str r0, [sp, #0x24]
	str r0, [sp, #0x28]
_020B19D0:
	ldr r1, [r7, #0x1c]
	ldr r0, [sp, #0x20]
	add r1, r1, #1
	str r1, [r7, #0x1c]
	ldr r2, [r6, #0x24]
	ldr r1, [sp, #0x24]
	add r2, r2, #1
	str r2, [r6, #0x24]
	str r0, [sp]
	ldr r0, [sp, #0x28]
	str r1, [sp, #4]
	str r0, [sp, #8]
	ldr ip, [r7, #0x20]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	blx ip
	ldr r0, [r7, #0x1c]
	sub r0, r0, #1
	str r0, [r7, #0x1c]
	ldr r0, [r6, #0x24]
	sub r0, r0, #1
	str r0, [r6, #0x24]
	ldr r0, [r7, #0x14]
	cmp r0, #0
	beq _020B1A5C
	ldr r0, [r7, #0x1c]
	cmp r0, #0
	bne _020B1A5C
	mov r0, r7
	bl sub_20B46C0
	add sp, sp, #0xc
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B1A5C:
	mov r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B1A68: .word aSocketConnecti
_020B1A6C: .word aGt2callbackC
	arm_func_end sub_20B1944

	arm_func_start sub_20B1A70
sub_20B1A70: // 0x020B1A70
	stmdb sp!, {r4, lr}
	movs r4, r0
	bne _020B1A90
	ldr r0, _020B1B00 // =aSocket
	ldr r1, _020B1B04 // =aGt2callbackC
	mov r2, #0
	mov r3, #0x1b
	bl __msl_assertion_failed
_020B1A90:
	cmp r4, #0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x24]
	cmp r0, #0
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0x1c]
	mov r0, r4
	add r1, r1, #1
	str r1, [r4, #0x1c]
	ldr r1, [r4, #0x24]
	blx r1
	ldr r0, [r4, #0x1c]
	sub r0, r0, #1
	str r0, [r4, #0x1c]
	ldr r0, [r4, #0x14]
	cmp r0, #0
	beq _020B1AF8
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	bne _020B1AF8
	mov r0, r4
	bl sub_20B46C0
	mov r0, #0
	ldmia sp!, {r4, pc}
_020B1AF8:
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B1B00: .word aSocket
_020B1B04: .word aGt2callbackC
	arm_func_end sub_20B1A70

	arm_func_start sub_20B1B08
sub_20B1B08: // 0x020B1B08
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x38]
	cmp r0, #0
	beq _020B1B20
	bl DWCi_GsFree
_020B1B20:
	ldr r0, [r4, #0x44]
	cmp r0, #0
	beq _020B1B30
	bl DWCi_GsFree
_020B1B30:
	ldr r0, [r4, #0x50]
	cmp r0, #0
	beq _020B1B40
	bl DWCi_GsFree
_020B1B40:
	ldr r0, [r4, #0x5c]
	cmp r0, #0
	beq _020B1B50
	bl ArrayFree
_020B1B50:
	ldr r0, [r4, #0x60]
	cmp r0, #0
	beq _020B1B60
	bl ArrayFree
_020B1B60:
	ldr r0, [r4, #0x98]
	cmp r0, #0
	beq _020B1B70
	bl ArrayFree
_020B1B70:
	ldr r0, [r4, #0x9c]
	cmp r0, #0
	beq _020B1B80
	bl ArrayFree
_020B1B80:
	mov r0, r4
	bl DWCi_GsFree
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B1B08

	arm_func_start sub_20B1B8C
sub_20B1B8C: // 0x020B1B8C
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, [sp, #8]
	ldr r0, [r1, #0xc]
	cmp r0, #7
	addeq sp, sp, #4
	ldmeqia sp!, {lr}
	addeq sp, sp, #0x10
	bxeq lr
	mov r0, #7
	str r0, [r1, #0xc]
	ldr r0, [sp, #8]
	add r1, sp, #8
	ldr r0, [r0, #8]
	ldr r0, [r0, #0xc]
	bl TableRemove
	ldr r0, [sp, #8]
	add r1, sp, #8
	ldr r0, [r0, #8]
	ldr r0, [r0, #0x10]
	bl ArrayAppend
	add sp, sp, #4
	ldmia sp!, {lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20B1B8C

	arm_func_start sub_20B1BF4
sub_20B1BF4: // 0x020B1BF4
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r1, #0
	beq _020B1C34
	ldr r1, [r4, #0xc]
	cmp r1, #7
	ldmgeia sp!, {r4, pc}
	bl sub_20B1B8C
	mov r0, r4
	bl sub_20B251C
	mov r0, r4
	mov r1, #0
	bl sub_20B1674
	mov r0, r4
	bl sub_20B43B0
	ldmia sp!, {r4, pc}
_020B1C34:
	mov r1, #6
	str r1, [r4, #0xc]
	bl sub_20B2768
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B1BF4

	arm_func_start sub_20B1C44
sub_20B1C44: // 0x020B1C44
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	bl sub_20B1DC4
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl sub_20B1CC0
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl sub_20B1D4C
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r5
	mov r1, r4
	bl sub_20B1D00
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B1C44

	arm_func_start sub_20B1CC0
sub_20B1CC0: // 0x020B1CC0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r3, [r0, #0x88]
	ldr r2, _020B1CFC // =0x00007530
	sub r1, r1, r3
	cmp r1, r2
	bls _020B1CF0
	bl sub_20B270C
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
_020B1CF0:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020B1CFC: .word 0x00007530
	arm_func_end sub_20B1CC0

	arm_func_start sub_20B1D00
sub_20B1D00: // 0x020B1D00
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0, #0x90]
	cmp r2, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	ldr r2, [r0, #0x94]
	sub r1, r1, r2
	cmp r1, #0x64
	bls _020B1D40
	bl sub_20B25D8
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
_020B1D40:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20B1D00

	arm_func_start sub_20B1D4C
sub_20B1D4C: // 0x020B1D4C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r0, [r7, #0x60]
	mov r6, r1
	bl ArrayLength
	mov r4, r0
	cmp r4, #0
	mov r5, #0
	ble _020B1DB8
_020B1D74:
	ldr r0, [r7, #0x60]
	mov r1, r5
	bl ArrayNth
	mov r1, r0
	ldr r0, [r1, #0xc]
	sub r0, r6, r0
	cmp r0, #0x3e8
	bls _020B1DAC
	mov r0, r7
	bl sub_20B2454
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020B1DAC:
	add r5, r5, #1
	cmp r5, r4
	blt _020B1D74
_020B1DB8:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20B1D4C

	arm_func_start sub_20B1DC4
sub_20B1DC4: // 0x020B1DC4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r2, [r4, #0xc]
	cmp r2, #5
	bge _020B1E5C
	ldr r0, [r4, #0x10]
	mov r3, #0
	cmp r0, #0
	beq _020B1E08
	ldr r2, [r4, #0x20]
	cmp r2, #0
	beq _020B1E24
	ldr r0, [r4, #0x1c]
	sub r0, r1, r0
	cmp r0, r2
	movhi r3, #1
	b _020B1E24
_020B1E08:
	cmp r2, #4
	bge _020B1E24
	ldr r2, [r4, #0x1c]
	ldr r0, _020B1E64 // =0x0000EA60
	sub r1, r1, r2
	cmp r1, r0
	movhi r3, #1
_020B1E24:
	cmp r3, #0
	beq _020B1E5C
	mov r0, r4
	bl sub_20B251C
	mov r0, r4
	bl sub_20B1B8C
	mov r2, #0
	mov r0, r4
	mov r3, r2
	mov r1, #6
	bl sub_20B1844
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
_020B1E5C:
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B1E64: .word 0x0000EA60
	arm_func_end sub_20B1DC4

	arm_func_start sub_20B1E68
sub_20B1E68: // 0x020B1E68
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	str r2, [sp]
	mov r3, r1
	ldrh r2, [r4, #4]
	ldr r0, [r4, #8]
	ldr r1, [r4, #0]
	bl sub_20B4200
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	bl sub_20A0CA4
	str r0, [r4, #0x88]
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B1E68

	arm_func_start sub_20B1EB0
sub_20B1EB0: // 0x020B1EB0
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #0
	str r0, [r4, #0x14]
	ldr r0, [r4, #0xc]
	cmp r0, #4
	ldmneia sp!, {r4, lr}
	addne sp, sp, #0x10
	bxne lr
	add r0, sp, #0xc
	add r1, sp, #0x10
	bl sub_20B49D0
	ldr r1, [sp, #0xc]
	ldr r2, [sp, #0x10]
	mov r0, r4
	bl sub_20B27C4
	mov r0, #6
	str r0, [r4, #0xc]
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20B1EB0

	arm_func_start sub_20B1F08
sub_20B1F08: // 0x020B1F08
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r2, [r5, #0x14]
	mov r4, r1
	cmp r2, #0
	movne r0, #0
	addne sp, sp, #4
	strne r0, [r5, #0x14]
	ldmneia sp!, {r4, r5, pc}
	mov r2, #0
	str r2, [r5, #0x14]
	ldr r1, [r5, #0xc]
	cmp r1, #4
	addne sp, sp, #4
	movne r0, r2
	ldmneia sp!, {r4, r5, pc}
	bl sub_20B2838
	mov r0, #5
	cmp r4, #0
	str r0, [r5, #0xc]
	addne ip, r5, #0x28
	ldmneia r4, {r0, r1, r2, r3}
	stmneia ip, {r0, r1, r2, r3}
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B1F08

	arm_func_start sub_20B1F74
sub_20B1F74: // 0x020B1F74
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	mov r5, r0
	add r0, sp, #0x34
	add r1, sp, #0x38
	mov r4, r3
	bl sub_20B49D0
	ldr r0, [sp, #0x38]
	cmp r0, #0
	ble _020B1FD8
	bl DWCi_GsMalloc
	str r0, [r5, #0x38]
	ldr r0, [r5, #0x38]
	cmp r0, #0
	addeq sp, sp, #0x24
	moveq r0, #1
	ldmeqia sp!, {r4, r5, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldr r1, [sp, #0x34]
	ldr r2, [sp, #0x38]
	bl memcpy
	ldr r0, [sp, #0x38]
	str r0, [r5, #0x3c]
_020B1FD8:
	cmp r4, #0
	addne ip, r5, #0x28
	ldmneia r4, {r0, r1, r2, r3}
	stmneia ip, {r0, r1, r2, r3}
	add r0, sp, #0
	bl sub_20B0D38
	add r1, sp, #0
	add r0, r5, #0x68
	bl sub_20B0C00
	add r1, sp, #0
	mov r0, r5
	bl sub_20B29A8
	mov r0, #0
	str r0, [r5, #0xc]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20B1F74

	arm_func_start sub_20B2020
sub_20B2020: // 0x020B2020
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl sub_20B4484
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0]
	mov r1, #2
	str r1, [r0, #0xc]
	ldr r1, [r4, #0]
	mov r0, #0
	str r0, [r1, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B2020

	arm_func_start sub_20B2050
sub_20B2050: // 0x020B2050
	stmdb sp!, {r4, lr}
	mov r4, r1
	bl sub_20B4484
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r1, [r4, #0]
	mov r0, #0
	str r0, [r1, #0xc]
	ldr r1, [r4, #0]
	mov r2, #1
	str r2, [r1, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B2050

	arm_func_start gt2GetConnectionData
gt2GetConnectionData: // 0x020B2080
	stmdb sp!, {r4, lr}
	movs r4, r0
	bne _020B20A0
	ldr r0, _020B20A8 // =aConnection_8
	ldr r1, _020B20AC // =aGt2mainC
	ldr r3, _020B20B0 // =0x000001AA
	mov r2, #0
	bl __msl_assertion_failed
_020B20A0:
	ldr r0, [r4, #0x40]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B20A8: .word aConnection_8
_020B20AC: .word aGt2mainC
_020B20B0: .word 0x000001AA
	arm_func_end gt2GetConnectionData

	arm_func_start sub_20B20B4
sub_20B20B4: // 0x020B20B4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	mov r4, r1
	bne _020B20DC
	ldr r0, _020B20E8 // =aConnection_8
	ldr r1, _020B20EC // =aGt2mainC
	ldr r3, _020B20F0 // =0x000001A3
	mov r2, #0
	bl __msl_assertion_failed
_020B20DC:
	str r4, [r5, #0x40]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B20E8: .word aConnection_8
_020B20EC: .word aGt2mainC
_020B20F0: .word 0x000001A3
	arm_func_end sub_20B20B4

	arm_func_start gt2SetUnrecognizedMessageCallback
gt2SetUnrecognizedMessageCallback: // 0x020B20F4
	str r1, [r0, #0x30]
	bx lr
	arm_func_end gt2SetUnrecognizedMessageCallback

	arm_func_start gt2GetSocketSOCKET
gt2GetSocketSOCKET: // 0x020B20FC
	ldr r0, [r0, #0]
	bx lr
	arm_func_end gt2GetSocketSOCKET

	arm_func_start gt2GetOutgoingBufferFreeSpace
gt2GetOutgoingBufferFreeSpace: // 0x020B2104
	ldr r1, [r0, #0x54]
	ldr r0, [r0, #0x58]
	sub r0, r1, r0
	bx lr
	arm_func_end gt2GetOutgoingBufferFreeSpace

	arm_func_start gt2GetLocalPort
gt2GetLocalPort: // 0x020B2114
	ldrh r0, [r0, #8]
	bx lr
	arm_func_end gt2GetLocalPort

	arm_func_start gt2CloseAllConnections
gt2CloseAllConnections: // 0x020B211C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020B2164 // =0x02145284
	ldr r2, [r1, #0]
	cmp r2, #1
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	mov r2, #1
	str r2, [r1]
	ldr r0, [r0, #0xc]
	ldr r1, _020B2168 // =sub_20B216C
	mov r2, #0
	bl TableMap
	ldr r0, _020B2164 // =0x02145284
	mov r1, #0
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020B2164: .word 0x02145284
_020B2168: .word sub_20B216C
	arm_func_end gt2CloseAllConnections

	arm_func_start sub_20B216C
sub_20B216C: // 0x020B216C
	ldr ip, _020B2178 // =gt2CloseConnectionHard
	ldr r0, [r0, #0]
	bx ip
	.align 2, 0
_020B2178: .word gt2CloseConnectionHard
	arm_func_end sub_20B216C

	arm_func_start gt2CloseConnectionHard
gt2CloseConnectionHard: // 0x020B217C
	ldr ip, _020B2188 // =sub_20B1BF4
	mov r1, #1
	bx ip
	.align 2, 0
_020B2188: .word sub_20B1BF4
	arm_func_end gt2CloseConnectionHard

	arm_func_start sub_20B218C
sub_20B218C: // 0x020B218C
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, [r5, #0xc]
	mov r4, r3
	cmp r0, #5
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, lr}
	addne sp, sp, #0x10
	bxne lr
	add r0, sp, #0x14
	add r1, sp, #0x18
	bl sub_20B49D0
	ldr r0, [r5, #0x98]
	bl ArrayLength
	cmp r0, #0
	beq _020B21FC
	str r4, [sp]
	ldr r2, [sp, #0x14]
	ldr r3, [sp, #0x18]
	mov r0, r5
	mov r1, #0
	bl sub_20B1490
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
_020B21FC:
	ldr r1, [sp, #0x14]
	ldr r2, [sp, #0x18]
	mov r0, r5
	mov r3, r4
	bl sub_20B242C
	add sp, sp, #4
	ldmia sp!, {r4, r5, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20B218C

	arm_func_start sub_20B2220
sub_20B2220: // 0x020B2220
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r6, r0
	mov r5, r1
	mov r0, r2
	add r1, sp, #8
	add r2, sp, #0
	mov r4, r3
	bl sub_20B4A1C
	cmp r0, #0
	beq _020B2264
	ldr r2, [sp, #8]
	cmp r2, #0
	beq _020B2264
	ldrh r3, [sp]
	cmp r3, #0
	bne _020B2270
_020B2264:
	add sp, sp, #0x10
	mov r0, #4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020B2270:
	mov r1, r2, lsr #0x18
	mov r0, r2, lsr #8
	mov r7, r2, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	mov ip, r2, lsl #0x18
	orr r0, r1, r0
	and r7, r7, #0xff0000
	and r1, ip, #0xff000000
	orr r0, r7, r0
	orr r0, r1, r0
	and r0, r0, #0xe0000000
	cmp r0, #0xe0000000
	addeq sp, sp, #0x10
	moveq r0, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r1, sp, #4
	mov r0, r6
	bl sub_20B2050
	cmp r0, #0
	addne sp, sp, #0x10
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [sp, #0x2c]
	ldr r0, [sp, #4]
	ldr r2, [sp, #0x28]
	str r1, [r0, #0x20]
	ldr r0, [sp, #4]
	ldr r3, [sp, #0x30]
	mov r1, r4
	bl sub_20B1F74
	movs r4, r0
	beq _020B2304
	ldr r0, [sp, #4]
	bl sub_20B43B0
	add sp, sp, #0x10
	mov r0, r4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020B2304:
	ldr r0, [sp, #0x34]
	cmp r0, #0
	bne _020B2328
	cmp r5, #0
	ldrne r0, [sp, #4]
	add sp, sp, #0x10
	strne r0, [r5]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020B2328:
	ldr r1, [sp, #4]
	ldr r0, [r1, #0x24]
	add r0, r0, #1
	str r0, [r1, #0x24]
	mov r4, #0
	mov r7, #1
_020B2340:
	mov r0, r6
	bl gt2Think
	ldr r0, [sp, #4]
	ldr r0, [r0, #0xc]
	cmp r0, #5
	movge r8, r7
	movlt r8, r4
	cmp r8, #0
	bne _020B236C
	mov r0, r7
	bl sub_20A0C98
_020B236C:
	cmp r8, #0
	beq _020B2340
	ldr r1, [sp, #4]
	ldr r0, [r1, #0x24]
	sub r0, r0, #1
	str r0, [r1, #0x24]
	ldr r1, [sp, #4]
	ldr r0, [r1, #0xc]
	cmp r0, #5
	streq r1, [r5]
	ldr r0, [sp, #4]
	ldr r0, [r0, #0x18]
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end sub_20B2220

	arm_func_start sub_20B23A4
sub_20B23A4: // 0x020B23A4
	ldr ip, _020B23AC // =sub_20B1EB0
	bx ip
	.align 2, 0
_020B23AC: .word sub_20B1EB0
	arm_func_end sub_20B23A4

	arm_func_start sub_20B23B0
sub_20B23B0: // 0x020B23B0
	ldr ip, _020B23B8 // =sub_20B1F08
	bx ip
	.align 2, 0
_020B23B8: .word sub_20B1F08
	arm_func_end sub_20B23B0

	arm_func_start gt2Listen
gt2Listen: // 0x020B23BC
	ldr ip, _020B23C4 // =sub_20B46B8
	bx ip
	.align 2, 0
_020B23C4: .word sub_20B46B8
	arm_func_end gt2Listen

	arm_func_start gt2Think
gt2Think: // 0x020B23C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20B2C54
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl sub_20B4164
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl sub_20B4120
	ldmia sp!, {r4, pc}
	arm_func_end gt2Think

	arm_func_start gt2CloseSocket
gt2CloseSocket: // 0x020B23F8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl gt2CloseAllConnections
	mov r0, r4
	bl sub_20B46C0
	ldmia sp!, {r4, pc}
	arm_func_end gt2CloseSocket

	arm_func_start gt2CreateSocket
gt2CreateSocket: // 0x020B2410
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr ip, [sp, #8]
	str ip, [sp]
	bl sub_20B4704
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end gt2CreateSocket

	arm_func_start sub_20B242C
sub_20B242C: // 0x020B242C
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r3, #0
	beq _020B2448
	bl sub_20B2A18
	add sp, sp, #4
	ldmia sp!, {pc}
_020B2448:
	bl sub_20B2640
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20B242C

	arm_func_start sub_20B2454
sub_20B2454: // 0x020B2454
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	mov r5, r1
	ldr r1, [r5, #0]
	ldrh r2, [r4, #0x66]
	ldr r0, [r4, #0x50]
	add r1, r1, #5
	bl sub_20B40B0
	ldr r3, [r4, #0x50]
	ldr r1, [r5, #0]
	ldr r2, [r5, #4]
	mov r0, r4
	add r1, r3, r1
	bl sub_20B1E68
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r4, #0x88]
	str r0, [r5, #0xc]
	ldr r0, [r5, #0]
	ldr r1, [r4, #0x50]
	add r0, r0, #2
	ldrb r0, [r1, r0]
	cmp r0, #2
	ldreq r0, [r4, #0x88]
	streq r0, [r4, #0x8c]
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B2454

	arm_func_start sub_20B24D0
sub_20B24D0: // 0x020B24D0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r4, _020B2518 // =0x0211E84C
	add r3, sp, #4
	ldrb r5, [r4, #0]
	ldrb r4, [r4, #1]
	mov lr, #0x68
	mov ip, #3
	strb r5, [r3]
	strb r4, [r3, #1]
	strb lr, [sp, #6]
	str ip, [sp]
	bl sub_20B4200
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B2518: .word 0x0211E84C
	arm_func_end sub_20B24D0

	arm_func_start sub_20B251C
sub_20B251C: // 0x020B251C
	ldr ip, _020B2534 // =sub_20B24D0
	mov r1, r0
	ldrh r2, [r1, #4]
	ldr r0, [r1, #8]
	ldr r1, [r1, #0]
	bx ip
	.align 2, 0
_020B2534: .word sub_20B24D0
	arm_func_end sub_20B251C

	arm_func_start sub_20B2538
sub_20B2538: // 0x020B2538
	ldr ip, _020B2548 // =sub_20B1E68
	mov r3, #0x67
	strb r3, [r1, #2]
	bx ip
	.align 2, 0
_020B2548: .word sub_20B1E68
	arm_func_end sub_20B2538

	arm_func_start sub_20B254C
sub_20B254C: // 0x020B254C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr r3, _020B25D4 // =0x0211E84C
	mov r4, r0
	ldrb ip, [r3]
	ldrb r3, [r3, #1]
	add r0, sp, #0
	mov r7, r1
	strb ip, [r0]
	mov r6, r2
	strb r3, [r0, #1]
	mov r3, #0x65
	mov r2, r7
	mov r5, #0
	mov r1, #3
	strb r3, [sp, #2]
	bl sub_20B40B0
	cmp r7, r6
	add r5, r5, #5
	beq _020B25B0
	add r0, sp, #0
	mov r1, r5
	mov r2, r6
	bl sub_20B40B0
	add r5, r5, #2
_020B25B0:
	add r1, sp, #0
	mov r0, r4
	mov r2, r5
	bl sub_20B1E68
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B25D4: .word 0x0211E84C
	arm_func_end sub_20B254C

	arm_func_start sub_20B25D8
sub_20B25D8: // 0x020B25D8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _020B263C // =0x0211E84C
	mov r4, r0
	ldrb r3, [r1, #0]
	ldrb r2, [r1, #1]
	add r0, sp, #0
	mov r1, #0x64
	strb r3, [r0]
	strb r2, [r0, #1]
	strb r1, [sp, #2]
	ldrh r2, [r4, #0x66]
	mov r1, #3
	bl sub_20B40B0
	add r1, sp, #0
	mov r0, r4
	mov r2, #5
	bl sub_20B1E68
	cmp r0, #0
	moveq r0, #0
	movne r0, #0
	strne r0, [r4, #0x90]
	movne r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B263C: .word 0x0211E84C
	arm_func_end sub_20B25D8

	arm_func_start sub_20B2640
sub_20B2640: // 0x020B2640
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r2
	mov r8, r0
	mov r7, r1
	cmp r6, #2
	blt _020B2670
	ldr r1, _020B2708 // =0x0211E84C
	mov r0, r7
	mov r2, #2
	bl memcmp
	cmp r0, #0
	beq _020B2690
_020B2670:
	mov r0, r8
	mov r1, r7
	mov r2, r6
	bl sub_20B1E68
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020B2690:
	add r5, r6, #2
	add r0, r8, #0x50
	bl sub_20B1118
	cmp r0, r5
	movlt r0, #1
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	ldr ip, [r8, #0x50]
	ldr r3, [r8, #0x58]
	ldr r1, _020B2708 // =0x0211E84C
	add r0, r8, #0x50
	mov r2, #2
	add r4, ip, r3
	bl sub_20B0FC0
	mov r1, r7
	mov r2, r6
	add r0, r8, #0x50
	bl sub_20B0FC0
	mov r0, r8
	mov r1, r4
	mov r2, r5
	bl sub_20B1E68
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r2, r5
	add r0, r8, #0x50
	mvn r1, #0
	bl sub_20B0F24
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020B2708: .word 0x0211E84C
	arm_func_end sub_20B2640

	arm_func_start sub_20B270C
sub_20B270C: // 0x020B270C
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r1, #7
	add r3, sp, #0
	mov r2, r1
	mov r4, r0
	bl sub_20B2B0C
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl sub_20B2A8C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B270C

	arm_func_start sub_20B2768
sub_20B2768: // 0x020B2768
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	add r3, sp, #0
	mov r1, #6
	mov r2, #7
	mov r4, r0
	bl sub_20B2B0C
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl sub_20B2A8C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B2768

	arm_func_start sub_20B27C4
sub_20B27C4: // 0x020B27C4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r2
	mov r5, r1
	add r3, sp, #0
	add r2, r4, #7
	mov r1, #5
	mov r6, r0
	bl sub_20B2B0C
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, r5
	mov r2, r4
	add r0, r6, #0x50
	bl sub_20B0FC0
	mov r0, r6
	bl sub_20B2A8C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B27C4

	arm_func_start sub_20B2838
sub_20B2838: // 0x020B2838
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	add r3, sp, #0
	mov r1, #4
	mov r2, #7
	mov r4, r0
	bl sub_20B2B0C
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl sub_20B2A8C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B2838

	arm_func_start sub_20B2894
sub_20B2894: // 0x020B2894
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r3
	mov r6, r1
	mov r5, r2
	add r3, sp, #0
	add r2, r4, #0x27
	mov r1, #3
	mov r7, r0
	bl sub_20B2B0C
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r1, r6
	add r0, r7, #0x50
	mov r2, #0x20
	bl sub_20B0FC0
	mov r1, r5
	mov r2, r4
	add r0, r7, #0x50
	bl sub_20B0FC0
	mov r0, r7
	bl sub_20B2A8C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20B2894

	arm_func_start sub_20B291C
sub_20B291C: // 0x020B291C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r1
	mov r4, r2
	add r3, sp, #0
	mov r1, #2
	mov r2, #0x47
	mov r6, r0
	bl sub_20B2B0C
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, r5
	add r0, r6, #0x50
	mov r2, #0x20
	bl sub_20B0FC0
	mov r1, r4
	add r0, r6, #0x50
	mov r2, #0x20
	bl sub_20B0FC0
	mov r0, r6
	bl sub_20B2A8C
	cmp r0, #0
	ldrne r1, [r6, #0x88]
	moveq r0, #0
	movne r0, #1
	strne r1, [r6, #0x8c]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B291C

	arm_func_start sub_20B29A8
sub_20B29A8: // 0x020B29A8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	add r3, sp, #0
	mov r1, #1
	mov r2, #0x27
	mov r5, r0
	bl sub_20B2B0C
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, pc}
	mov r1, r4
	add r0, r5, #0x50
	mov r2, #0x20
	bl sub_20B0FC0
	mov r0, r5
	bl sub_20B2A8C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B29A8

	arm_func_start sub_20B2A18
sub_20B2A18: // 0x020B2A18
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r4, r2
	mov r5, r1
	add r3, sp, #0
	add r2, r4, #7
	mov r1, #0
	mov r6, r0
	bl sub_20B2B0C
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [sp]
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r1, r5
	mov r2, r4
	add r0, r6, #0x50
	bl sub_20B0FC0
	mov r0, r6
	bl sub_20B2A8C
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B2A18

	arm_func_start sub_20B2A8C
sub_20B2A8C: // 0x020B2A8C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, [r5, #0x60]
	bl ArrayLength
	mov r4, r0
	cmp r4, #0
	bgt _020B2AC0
	ldr r0, _020B2B00 // =aLen0_3
	ldr r1, _020B2B04 // =aGt2messageC
	ldr r3, _020B2B08 // =0x00000475
	mov r2, #0
	bl __msl_assertion_failed
_020B2AC0:
	ldr r0, [r5, #0x60]
	sub r1, r4, #1
	bl ArrayNth
	ldr r3, [r5, #0x50]
	ldr r1, [r0, #0]
	ldr r2, [r0, #4]
	mov r0, r5
	add r1, r3, r1
	bl sub_20B1E68
	cmp r0, #0
	moveq r0, #0
	movne r0, #0
	strne r0, [r5, #0x90]
	movne r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B2B00: .word aLen0_3
_020B2B04: .word aGt2messageC
_020B2B08: .word 0x00000475
	arm_func_end sub_20B2A8C

	arm_func_start sub_20B2B0C
sub_20B2B0C: // 0x020B2B0C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	mov r5, r2
	add r0, r7, #0x50
	mov r6, r1
	mov r4, r3
	bl sub_20B1118
	cmp r0, r5
	bge _020B2B54
	mov r0, r7
	bl sub_20B3FCC
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	add sp, sp, #4
	strne r0, [r4]
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B2B54:
	ldrh r1, [r7, #0x64]
	mov r0, r7
	mov r2, r5
	bl sub_20B2BE0
	cmp r0, #0
	bne _020B2B8C
	mov r0, r7
	bl sub_20B3FCC
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	add sp, sp, #4
	strne r0, [r4]
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B2B8C:
	ldr r1, _020B2BDC // =0x0211E84C
	add r0, r7, #0x50
	mov r2, #2
	bl sub_20B0FC0
	add r0, r7, #0x50
	and r1, r6, #0xff
	bl sub_20B10C0
	ldrh r1, [r7, #0x64]
	add r0, r7, #0x50
	add r2, r1, #1
	strh r2, [r7, #0x64]
	bl sub_20B104C
	ldrh r1, [r7, #0x66]
	add r0, r7, #0x50
	bl sub_20B104C
	mov r0, #0
	str r0, [r4]
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B2BDC: .word 0x0211E84C
	arm_func_end sub_20B2B0C

	arm_func_start sub_20B2BE0
sub_20B2BE0: // 0x020B2BE0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	add r4, sp, #0
	mov r3, #0
	str r3, [r4]
	str r3, [r4, #4]
	str r3, [r4, #8]
	mov r5, r0
	str r3, [r4, #0xc]
	ldr r0, [r5, #0x58]
	str r0, [sp]
	str r2, [sp, #4]
	strh r1, [sp, #8]
	bl sub_20A0CA4
	str r0, [sp, #0xc]
	ldr r0, [r5, #0x60]
	bl ArrayLength
	mov r4, r0
	ldr r0, [r5, #0x60]
	add r1, sp, #0
	bl ArrayAppend
	ldr r0, [r5, #0x60]
	bl ArrayLength
	add r1, r4, #1
	cmp r1, r0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B2BE0

	arm_func_start sub_20B2C54
sub_20B2C54: // 0x020B2C54
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr ip, _020B2DA0 // =0x000005F4
	sub sp, sp, ip
	mov r10, r0
	ldr r0, [r10, #0]
	bl sub_20A0974
	cmp r0, #0
	beq _020B2D90
	ldr r11, _020B2DA4 // =0x000005DC
	add r6, sp, #0x14
	add r8, sp, #8
	add r7, sp, #0x10
	mov r9, #8
	mov r5, #0
	mvn r4, #0xe
_020B2C90:
	str r9, [sp, #0x10]
	str r8, [sp]
	str r7, [sp, #4]
	ldr r0, [r10, #0]
	mov r1, r6
	mov r2, r11
	mov r3, r5
	bl sub_20A0688
	mov r2, r0
	mvn r0, #0
	cmp r2, r0
	bne _020B2D38
	ldr r0, [r10, #0]
	bl WSAGetLastError
	cmp r0, r4
	bne _020B2D14
	ldrh r2, [sp, #0xa]
	ldr r1, [sp, #0xc]
	mov r0, r10
	mov r3, r2, asr #8
	mov r2, r2, lsl #8
	and r3, r3, #0xff
	and r2, r2, #0xff00
	orr r2, r3, r2
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	bl sub_20B2DA8
	cmp r0, #0
	bne _020B2D80
	ldr ip, _020B2DA0 // =0x000005F4
	mov r0, #0
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020B2D14:
	mvn r1, #0x22
	cmp r0, r1
	beq _020B2D80
	mov r0, r10
	bl sub_20B40E4
	ldr ip, _020B2DA0 // =0x000005F4
	mov r0, #0
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020B2D38:
	ldrh ip, [sp, #0xa]
	mov r0, r10
	mov r1, r6
	mov r3, ip, asr #8
	mov ip, ip, lsl #8
	and r3, r3, #0xff
	and ip, ip, #0xff00
	orr r3, r3, ip
	mov r3, r3, lsl #0x10
	mov r3, r3, lsr #0x10
	str r3, [sp]
	ldr r3, [sp, #0xc]
	bl sub_20B2EA8
	cmp r0, #0
	ldreq ip, _020B2DA0 // =0x000005F4
	moveq r0, #0
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020B2D80:
	ldr r0, [r10, #0]
	bl sub_20A0974
	cmp r0, #0
	bne _020B2C90
_020B2D90:
	mov r0, #1
	ldr ip, _020B2DA0 // =0x000005F4
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B2DA0: .word 0x000005F4
_020B2DA4: .word 0x000005DC
	arm_func_end sub_20B2C54

	arm_func_start sub_20B2DA8
sub_20B2DA8: // 0x020B2DA8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r7, r0
	mov r6, r1
	mov r5, r2
	bl sub_20B4930
	ldr r1, [r7, #0x2c]
	mov r4, r0
	cmp r1, #0
	beq _020B2E0C
	mov r0, #1
	str r0, [sp]
	mov ip, #0
	str ip, [sp, #4]
	str ip, [sp, #8]
	mov r0, r7
	mov r1, r4
	mov r2, r6
	mov r3, r5
	str ip, [sp, #0xc]
	bl sub_20B1258
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020B2E0C:
	cmp r4, #0
	addeq sp, sp, #0x14
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bne _020B2E7C
	ldr r0, [r4, #0x20]
	cmp r0, #0
	beq _020B2E4C
	bl sub_20A0CA4
	ldr r2, [r4, #0x1c]
	ldr r1, [r4, #0x20]
	sub r0, r0, r2
	cmp r0, r1
	bhs _020B2E58
_020B2E4C:
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B2E58:
	mov r0, r4
	mov r1, #6
	mov r2, #1
	bl sub_20B400C
	cmp r0, #0
	bne _020B2E9C
	add sp, sp, #0x14
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B2E7C:
	mov r0, r4
	mov r1, #2
	mov r2, #1
	bl sub_20B400C
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
_020B2E9C:
	mov r0, #1
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20B2DA8

	arm_func_start sub_20B2EA8
sub_20B2EA8: // 0x020B2EA8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x1c
	ldr r5, [sp, #0x38]
	mov r6, r3
	mov r8, r1
	mov r7, r2
	mov r1, r6
	mov r2, r5
	mov r9, r0
	bl sub_20B4930
	str r0, [sp, #0x10]
	ldr r0, [r9, #0x2c]
	cmp r0, #0
	beq _020B2F18
	mov r0, #0
	str r0, [sp]
	str r8, [sp, #4]
	str r7, [sp, #8]
	str r0, [sp, #0xc]
	ldr r1, [sp, #0x10]
	mov r0, r9
	mov r2, r6
	mov r3, r5
	bl sub_20B1258
	cmp r0, #0
	addeq sp, sp, #0x1c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B2F18:
	cmp r7, #2
	ble _020B2F3C
	ldr r1, _020B3164 // =0x0211E84C
	mov r0, r8
	mov r2, #2
	bl memcmp
	cmp r0, #0
	moveq r4, #1
	beq _020B2F40
_020B2F3C:
	mov r4, #0
_020B2F40:
	ldr r0, [sp, #0x10]
	cmp r0, #0
	bne _020B3048
	add ip, sp, #0x14
	str r7, [sp]
	mov r0, r9
	mov r1, r6
	mov r2, r5
	mov r3, r8
	str ip, [sp, #4]
	bl sub_20B1160
	cmp r0, #0
	addeq sp, sp, #0x1c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [sp, #0x14]
	cmp r0, #0
	addne sp, sp, #0x1c
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	cmp r4, #0
	beq _020B2FA4
	ldrb r0, [r8, #2]
	cmp r0, #1
	beq _020B2FE4
_020B2FA4:
	cmp r4, #0
	beq _020B2FB8
	ldrb r0, [r8, #2]
	cmp r0, #0x68
	beq _020B2FD8
_020B2FB8:
	mov r0, r9
	mov r1, r6
	mov r2, r5
	bl sub_20B24D0
	cmp r0, #0
	addeq sp, sp, #0x1c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B2FD8:
	add sp, sp, #0x1c
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B2FE4:
	ldr r0, [r9, #0x20]
	cmp r0, #0
	addeq sp, sp, #0x1c
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r1, sp, #0x10
	mov r0, r9
	mov r2, r6
	mov r3, r5
	bl sub_20B2020
	cmp r0, #0
	beq _020B3048
	cmp r0, #5
	beq _020B303C
	mov r0, r9
	mov r1, r6
	mov r2, r5
	bl sub_20B24D0
	cmp r0, #0
	addeq sp, sp, #0x1c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B303C:
	add sp, sp, #0x1c
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B3048:
	ldr r5, [sp, #0x10]
	ldr r0, [r5, #0xc]
	cmp r0, #7
	bne _020B3090
	cmp r4, #0
	beq _020B306C
	ldrb r0, [r8, #2]
	cmp r0, #0x68
	beq _020B3084
_020B306C:
	mov r0, r5
	bl sub_20B251C
	cmp r0, #0
	addeq sp, sp, #0x1c
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B3084:
	add sp, sp, #0x1c
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B3090:
	cmp r4, #0
	beq _020B30C0
	cmp r7, #4
	blt _020B30C0
	ldr r1, _020B3164 // =0x0211E84C
	add r0, r8, #2
	mov r2, #2
	bl memcmp
	cmp r0, #0
	addeq r8, r8, #2
	subeq r7, r7, #2
	moveq r4, #0
_020B30C0:
	cmp r4, #0
	bne _020B30EC
	mov r0, r5
	mov r1, r8
	mov r2, r7
	bl sub_20B3E28
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x1c
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B30EC:
	ldrb r1, [r8, #2]
	cmp r1, #0
	bge _020B3114
	mov r0, r5
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x1c
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B3114:
	cmp r1, #8
	bge _020B3140
	mov r0, r5
	mov r2, r8
	mov r3, r7
	bl sub_20B3474
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x1c
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B3140:
	mov r0, r5
	mov r2, r8
	mov r3, r7
	bl sub_20B3168
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020B3164: .word 0x0211E84C
	arm_func_end sub_20B2EA8

	arm_func_start sub_20B3168
sub_20B3168: // 0x020B3168
	stmdb sp!, {lr}
	sub sp, sp, #4
	cmp r1, #0x64
	add lr, r2, #3
	sub ip, r3, #3
	bne _020B31A0
	mov r1, lr
	mov r2, ip
	bl sub_20B3428
	cmp r0, #0
	bne _020B3234
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B31A0:
	cmp r1, #0x65
	bne _020B31C8
	mov r1, lr
	mov r2, ip
	bl sub_20B333C
	cmp r0, #0
	bne _020B3234
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B31C8:
	cmp r1, #0x66
	bne _020B31F0
	mov r1, r2
	mov r2, r3
	bl sub_20B3330
	cmp r0, #0
	bne _020B3234
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B31F0:
	cmp r1, #0x67
	bne _020B3218
	mov r1, lr
	mov r2, ip
	bl sub_20B3284
	cmp r0, #0
	bne _020B3234
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B3218:
	cmp r1, #0x68
	bne _020B3234
	bl sub_20B3240
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
_020B3234:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20B3168

	arm_func_start sub_20B3240
sub_20B3240: // 0x020B3240
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, [r0, #0xc]
	cmp r1, #7
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {pc}
	cmp r1, #6
	moveq r2, #0
	movne r2, #1
	mov r1, #2
	bl sub_20B400C
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20B3240

	arm_func_start sub_20B3284
sub_20B3284: // 0x020B3284
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x34]
	mov r5, r1
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, pc}
	cmp r2, #8
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, pc}
	ldr r1, _020B332C // =0x0211E850
	mov r0, r5
	mov r2, #4
	bl memcmp
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #1
	ldmneia sp!, {r4, r5, pc}
	add r2, r5, #4
	ldrb r1, [r5, #4]
	ldrb r0, [r2, #1]
	add r3, sp, #0
	strb r1, [r3]
	strb r0, [r3, #1]
	ldrb r1, [r2, #2]
	ldrb r0, [r2, #3]
	strb r1, [r3, #2]
	strb r0, [r3, #3]
	bl sub_20A0CA4
	mov r2, r0
	ldr r1, [sp]
	mov r0, r4
	sub r1, r2, r1
	bl sub_20B15A0
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B332C: .word 0x0211E850
	arm_func_end sub_20B3284

	arm_func_start sub_20B3330
sub_20B3330: // 0x020B3330
	ldr ip, _020B3338 // =sub_20B2538
	bx ip
	.align 2, 0
_020B3338: .word sub_20B2538
	arm_func_end sub_20B3330

	arm_func_start sub_20B333C
sub_20B333C: // 0x020B333C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r6, r1
	mov r4, r0
	mov r0, r6
	mov r1, #0
	mov r5, r2
	bl sub_20B40C4
	mov r9, r0
	cmp r5, #2
	moveq r8, r9
	beq _020B33A4
	cmp r5, #4
	bne _020B3388
	mov r0, r6
	mov r1, #2
	bl sub_20B40C4
	mov r8, r0
	b _020B33A4
_020B3388:
	mov r0, r4
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #4
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B33A4:
	ldr r0, [r4, #0x60]
	bl ArrayLength
	mov r7, r0
	cmp r7, #0
	mov r6, #0
	ble _020B341C
_020B33BC:
	ldr r0, [r4, #0x60]
	mov r1, r6
	bl ArrayNth
	mov r5, r0
	ldrh r0, [r5, #8]
	mov r1, r9
	bl sub_20B40A0
	cmp r0, #0
	blt _020B3410
	ldrh r0, [r5, #8]
	mov r1, r8
	bl sub_20B40A0
	cmp r0, #0
	bgt _020B3410
	mov r0, r4
	mov r1, r5
	bl sub_20B2454
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B3410:
	add r6, r6, #1
	cmp r6, r7
	blt _020B33BC
_020B341C:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end sub_20B333C

	arm_func_start sub_20B3428
sub_20B3428: // 0x020B3428
	stmdb sp!, {r4, lr}
	mov r4, r0
	cmp r2, #2
	beq _020B344C
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, pc}
_020B344C:
	mov r0, r1
	mov r1, #0
	bl sub_20B40C4
	mov r1, r0
	mov r0, r4
	bl sub_20B3EBC
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B3428

	arm_func_start sub_20B3474
sub_20B3474: // 0x020B3474
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r6, r3
	mov r4, r0
	mov r8, r1
	mov r7, r2
	cmp r6, #7
	bge _020B34AC
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x10
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020B34AC:
	mov r0, r7
	mov r1, #3
	bl sub_20B40C4
	mov r5, r0
	mov r0, r7
	mov r1, #5
	bl sub_20B40C4
	mov r1, r0
	mov r0, r4
	bl sub_20B3EBC
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldrh r1, [r4, #0x66]
	cmp r5, r1
	bne _020B3538
	mov r0, r4
	bl sub_20B35C0
	mov r0, r4
	mov r1, r8
	add r2, r7, #7
	sub r3, r6, #7
	bl sub_20B38C4
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r4
	bl sub_20B35E8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x10
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020B3538:
	mov r0, r5
	bl sub_20B40A0
	cmp r0, #0
	bge _020B355C
	mov r0, r4
	bl sub_20B35C0
	add sp, sp, #0x10
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020B355C:
	sub r0, r6, #7
	str r0, [sp]
	add ip, sp, #8
	mov r0, r4
	mov r1, r8
	mov r2, r5
	add r3, r7, #7
	str ip, [sp, #4]
	bl sub_20B3700
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r0, [sp, #8]
	cmp r0, #0
	beq _020B35B4
	mov r0, r4
	bl sub_20B3FCC
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_020B35B4:
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end sub_20B3474

	arm_func_start sub_20B35C0
sub_20B35C0: // 0x020B35C0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x90]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	mov r0, #1
	str r0, [r4, #0x90]
	bl sub_20A0CA4
	str r0, [r4, #0x94]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B35C0

	arm_func_start sub_20B35E8
sub_20B35E8: // 0x020B35E8
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
_020B35F0:
	ldr r0, [r6, #0x5c]
	bl ArrayLength
	subs r5, r0, #1
	bmi _020B3664
_020B3600:
	ldr r0, [r6, #0x5c]
	mov r1, r5
	bl ArrayNth
	mov r4, r0
	ldrh r1, [r4, #0xc]
	ldrh r0, [r6, #0x66]
	cmp r1, r0
	bne _020B365C
	ldr ip, [r6, #0x44]
	ldr r2, [r4, #0]
	ldr r1, [r4, #8]
	ldr r3, [r4, #4]
	mov r0, r6
	add r2, ip, r2
	bl sub_20B38C4
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r6
	mov r1, r4
	mov r2, r5
	bl sub_20B366C
	b _020B35F0
_020B365C:
	subs r5, r5, #1
	bpl _020B3600
_020B3664:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B35E8

	arm_func_start sub_20B366C
sub_20B366C: // 0x020B366C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r0, [r9, #0x5c]
	ldr r7, [r1, #0]
	ldr r6, [r1, #4]
	mov r1, r2
	mov r8, #0
	bl ArrayDeleteAt
	ldr r0, [r9, #0x5c]
	bl ArrayLength
	mov r5, r0
	cmp r5, #0
	mov r4, r8
	ble _020B36E8
_020B36A8:
	ldr r0, [r9, #0x5c]
	mov r1, r4
	bl ArrayNth
	ldr r1, [r0, #0]
	cmp r1, r7
	ble _020B36DC
	sub r1, r1, r6
	str r1, [r0]
	ldr r1, [r0, #0]
	ldr r0, [r0, #4]
	add r0, r1, r0
	cmp r8, r0
	movle r8, r0
_020B36DC:
	add r4, r4, #1
	cmp r4, r5
	blt _020B36A8
_020B36E8:
	mov r1, r7
	mov r2, r6
	add r0, r9, #0x44
	bl sub_20B0F24
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end sub_20B366C

	arm_func_start sub_20B3700
sub_20B3700: // 0x020B3700
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x10
	mov r9, r0
	ldr r0, [r9, #0x5c]
	mov r8, r1
	mov r7, r2
	mov r6, r3
	ldr r5, [sp, #0x34]
	bl ArrayLength
	mov r4, r0
	cmp r4, #0
	mov r10, #0
	ble _020B3778
_020B3734:
	ldr r0, [r9, #0x5c]
	mov r1, r10
	bl ArrayNth
	ldrh r0, [r0, #0xc]
	cmp r0, r7
	moveq r0, #0
	streq r0, [r5]
	addeq sp, sp, #0x10
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	mov r1, r7
	bl sub_20B40A0
	cmp r0, #0
	bgt _020B3778
	add r10, r10, #1
	cmp r10, r4
	blt _020B3734
_020B3778:
	add r0, r9, #0x44
	bl sub_20B1118
	ldr r2, [sp, #0x30]
	cmp r0, r2
	movlt r0, #1
	addlt sp, sp, #0x10
	strlt r0, [r5]
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, [r9, #0x4c]
	add r1, sp, #0
	str r2, [sp, #4]
	str r8, [sp, #8]
	strh r7, [sp, #0xc]
	str r0, [sp]
	ldr r0, [r9, #0x5c]
	ldr r2, _020B38AC // =sub_20B38B0
	bl sub_209F8BC
	ldr r0, [r9, #0x5c]
	bl ArrayLength
	add r1, r4, #1
	cmp r1, r0
	movne r0, #1
	addne sp, sp, #0x10
	strne r0, [r5]
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r2, [sp, #0x30]
	mov r1, r6
	add r0, r9, #0x44
	bl sub_20B0FC0
	cmp r4, #0
	bne _020B3820
	sub r0, r7, #1
	mov r2, r0, lsl #0x10
	ldrh r1, [r9, #0x66]
	mov r0, r9
	mov r2, r2, lsr #0x10
	bl sub_20B254C
	cmp r0, #0
	bne _020B3898
	add sp, sp, #0x10
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020B3820:
	ldr r0, [r9, #0x5c]
	mov r1, r4
	bl ArrayNth
	ldrh r0, [r0, #0xc]
	cmp r0, r7
	bne _020B3898
	ldr r0, [r9, #0x5c]
	sub r1, r4, #1
	bl ArrayNth
	mov r4, r0
	ldrh r1, [r4, #0xc]
	mov r0, r7
	bl sub_20B40A0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	cmp r0, #1
	bls _020B3898
	ldrh r1, [r4, #0xc]
	sub r0, r7, #1
	mov r2, r0, lsl #0x10
	add r0, r1, #1
	mov r1, r0, lsl #0x10
	mov r0, r9
	mov r1, r1, lsr #0x10
	mov r2, r2, lsr #0x10
	bl sub_20B254C
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020B3898:
	mov r0, #0
	str r0, [r5]
	mov r0, #1
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020B38AC: .word sub_20B38B0
	arm_func_end sub_20B3700

	arm_func_start sub_20B38B0
sub_20B38B0: // 0x020B38B0
	ldr ip, _020B38C0 // =sub_20B40A0
	ldrh r0, [r0, #0xc]
	ldrh r1, [r1, #0xc]
	bx ip
	.align 2, 0
_020B38C0: .word sub_20B40A0
	arm_func_end sub_20B38B0

	arm_func_start sub_20B38C4
sub_20B38C4: // 0x020B38C4
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrh ip, [r0, #0x66]
	cmp r1, #0
	add ip, ip, #1
	strh ip, [r0, #0x66]
	bne _020B3900
	mov r1, r2
	mov r2, r3
	bl sub_20B3D78
	cmp r0, #0
	bne _020B39DC
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B3900:
	cmp r1, #1
	bne _020B3928
	mov r1, r2
	mov r2, r3
	bl sub_20B3CE0
	cmp r0, #0
	bne _020B39DC
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B3928:
	cmp r1, #2
	bne _020B3950
	mov r1, r2
	mov r2, r3
	bl sub_20B3C04
	cmp r0, #0
	bne _020B39DC
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B3950:
	cmp r1, #3
	bne _020B3978
	mov r1, r2
	mov r2, r3
	bl sub_20B3AF0
	cmp r0, #0
	bne _020B39DC
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B3978:
	cmp r1, #4
	bne _020B3998
	bl sub_20B3A98
	cmp r0, #0
	bne _020B39DC
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B3998:
	cmp r1, #5
	bne _020B39C0
	mov r1, r2
	mov r2, r3
	bl sub_20B3A2C
	cmp r0, #0
	bne _020B39DC
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B39C0:
	cmp r1, #6
	bne _020B39DC
	bl sub_20B39E8
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {pc}
_020B39DC:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20B38C4

	arm_func_start sub_20B39E8
sub_20B39E8: // 0x020B39E8
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20B251C
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0xc]
	mov r1, #2
	cmp r0, #6
	moveq r2, #0
	movne r2, #1
	mov r0, r4
	bl sub_20B400C
	cmp r0, #0
	moveq r0, #0
	movne r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B39E8

	arm_func_start sub_20B3A2C
sub_20B3A2C: // 0x020B3A2C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r3, [r6, #0xc]
	mov r5, r1
	mov r4, r2
	cmp r3, #1
	beq _020B3A5C
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020B3A5C:
	bl sub_20B1B8C
	mov r0, r6
	bl sub_20B251C
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r6
	mov r2, r5
	mov r3, r4
	mov r1, #2
	bl sub_20B1844
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B3A2C

	arm_func_start sub_20B3A98
sub_20B3A98: // 0x020B3A98
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, [r0, #0xc]
	cmp r1, #1
	beq _020B3AC4
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #4
	moveq r0, #0
	ldmia sp!, {pc}
_020B3AC4:
	mov r1, #0
	mov ip, #5
	mov r2, r1
	mov r3, r1
	str ip, [r0, #0xc]
	bl sub_20B1844
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20B3A98

	arm_func_start sub_20B3AF0
sub_20B3AF0: // 0x020B3AF0
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r6, r0
	ldr r3, [r6, #0xc]
	mov r5, r1
	mov r4, r2
	cmp r3, #3
	beq _020B3B28
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x10
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020B3B28:
	cmp r4, #0x20
	bge _020B3B48
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x10
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020B3B48:
	mov r0, r5
	add r1, r6, #0x68
	bl sub_20B0BC4
	cmp r0, #0
	bne _020B3B78
	mov r0, r6
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x10
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020B3B78:
	ldr r0, [r6, #8]
	ldr r0, [r0, #0x20]
	cmp r0, #0
	bne _020B3BB4
	mov r0, r6
	bl sub_20B251C
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl sub_20B1B8C
	add sp, sp, #0x10
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
_020B3BB4:
	mov r0, #4
	str r0, [r6, #0xc]
	bl sub_20A0CA4
	ldr r2, [r6, #0x8c]
	add r1, r5, #0x20
	sub r0, r0, r2
	str r0, [sp]
	str r1, [sp, #4]
	sub r0, r4, #0x20
	str r0, [sp, #8]
	ldrh r3, [r6, #4]
	ldr r0, [r6, #8]
	ldr r2, [r6, #0]
	mov r1, r6
	bl sub_20B1944
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B3AF0

	arm_func_start sub_20B3C04
sub_20B3C04: // 0x020B3C04
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x24
	mov r5, r0
	ldr r3, [r5, #0xc]
	mov r4, r1
	cmp r3, #0
	beq _020B3C38
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x24
	moveq r0, #0
	ldmia sp!, {r4, r5, pc}
_020B3C38:
	cmp r2, #0x40
	bge _020B3C58
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x24
	moveq r0, #0
	ldmia sp!, {r4, r5, pc}
_020B3C58:
	mov r0, r4
	add r1, r5, #0x68
	bl sub_20B0BC4
	cmp r0, #0
	bne _020B3C88
	mov r0, r5
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x24
	moveq r0, #0
	ldmia sp!, {r4, r5, pc}
_020B3C88:
	add r0, sp, #0
	add r1, r4, #0x20
	bl sub_20B0C00
	ldr r2, [r5, #0x38]
	ldr r3, [r5, #0x3c]
	add r1, sp, #0
	mov r0, r5
	bl sub_20B2894
	cmp r0, #0
	addeq sp, sp, #0x24
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r5, #0x38]
	cmp r0, #0
	beq _020B3CD0
	bl DWCi_GsFree
	mov r0, #0
	str r0, [r5, #0x38]
_020B3CD0:
	mov r0, #1
	str r0, [r5, #0xc]
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B3C04

	arm_func_start sub_20B3CE0
sub_20B3CE0: // 0x020B3CE0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x40
	mov r4, r0
	ldr r3, [r4, #0xc]
	cmp r3, #2
	beq _020B3D10
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x40
	moveq r0, #0
	ldmia sp!, {r4, pc}
_020B3D10:
	cmp r2, #0x20
	bge _020B3D30
	bl sub_20B3FF8
	cmp r0, #0
	movne r0, #1
	add sp, sp, #0x40
	moveq r0, #0
	ldmia sp!, {r4, pc}
_020B3D30:
	add r0, sp, #0
	bl sub_20B0C00
	add r0, sp, #0x20
	bl sub_20B0D38
	add r1, sp, #0x20
	add r0, r4, #0x68
	bl sub_20B0C00
	add r1, sp, #0
	add r2, sp, #0x20
	mov r0, r4
	bl sub_20B291C
	cmp r0, #0
	moveq r0, #0
	movne r0, #3
	strne r0, [r4, #0xc]
	movne r0, #1
	add sp, sp, #0x40
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B3CE0

	arm_func_start sub_20B3D78
sub_20B3D78: // 0x020B3D78
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r3, [r6, #0xc]
	mov r5, r1
	mov r4, r2
	cmp r3, #5
	beq _020B3DB8
	cmp r3, #6
	beq _020B3DB8
	bl sub_20B3FF8
	cmp r0, #0
	bne _020B3E1C
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020B3DB8:
	ldr r0, [r6, #0x9c]
	bl ArrayLength
	cmp r0, #0
	beq _020B3DF8
	mov ip, #1
	mov r0, r6
	mov r2, r5
	mov r3, r4
	mov r1, #0
	str ip, [sp]
	bl sub_20B1380
	cmp r0, #0
	movne r0, #1
	add sp, sp, #8
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020B3DF8:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	mov r3, #1
	bl sub_20B1748
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
_020B3E1C:
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B3D78

	arm_func_start sub_20B3E28
sub_20B3E28: // 0x020B3E28
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r0, [r6, #0xc]
	mov r5, r1
	mov r4, r2
	cmp r0, #5
	beq _020B3E58
	cmp r0, #6
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
_020B3E58:
	ldr r0, [r6, #0x9c]
	bl ArrayLength
	cmp r0, #0
	beq _020B3E94
	mov r1, #0
	mov r0, r6
	mov r2, r5
	mov r3, r4
	str r1, [sp]
	bl sub_20B1380
	cmp r0, #0
	movne r0, #1
	add sp, sp, #8
	moveq r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020B3E94:
	mov r0, r6
	mov r1, r5
	mov r2, r4
	mov r3, #0
	bl sub_20B1748
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B3E28

	arm_func_start sub_20B3EBC
sub_20B3EBC: // 0x020B3EBC
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r0, [r4, #0x60]
	mov r7, r1
	bl ArrayLength
	movs r6, r0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r6, #0
	mov r5, #0
	ble _020B3F1C
_020B3EF0:
	ldr r0, [r4, #0x60]
	mov r1, r5
	bl ArrayNth
	ldrh r0, [r0, #8]
	mov r1, r7
	bl sub_20B40A0
	cmp r0, #0
	bge _020B3F1C
	add r5, r5, #1
	cmp r5, r6
	blt _020B3EF0
_020B3F1C:
	cmp r5, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r5, #0
	sub r5, r5, #1
	beq _020B3F50
_020B3F38:
	ldr r0, [r4, #0x60]
	mov r1, r5
	bl ArrayDeleteAt
	cmp r5, #0
	sub r5, r5, #1
	bne _020B3F38
_020B3F50:
	ldr r0, [r4, #0x60]
	bl ArrayLength
	movs r6, r0
	moveq r0, #0
	streq r0, [r4, #0x58]
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #0x60]
	mov r1, #0
	bl ArrayNth
	cmp r6, #0
	ldr r7, [r0, #0]
	mov r5, #0
	ble _020B3FB0
_020B3F8C:
	ldr r0, [r4, #0x60]
	mov r1, r5
	bl ArrayNth
	ldr r1, [r0, #0]
	add r5, r5, #1
	sub r1, r1, r7
	str r1, [r0]
	cmp r5, r6
	blt _020B3F8C
_020B3FB0:
	mov r2, r7
	add r0, r4, #0x50
	mov r1, #0
	bl sub_20B0F24
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20B3EBC

	arm_func_start sub_20B3FCC
sub_20B3FCC: // 0x020B3FCC
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20B251C
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	mov r1, #1
	mov r2, #4
	bl sub_20B400C
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B3FCC

	arm_func_start sub_20B3FF8
sub_20B3FF8: // 0x020B3FF8
	ldr ip, _020B4008 // =sub_20B400C
	mov r1, #7
	mov r2, #2
	bx ip
	.align 2, 0
_020B4008: .word sub_20B400C
	arm_func_end sub_20B3FF8

	arm_func_start sub_20B400C
sub_20B400C: // 0x020B400C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r3, [r6, #0xc]
	mov r5, r1
	mov r4, r2
	cmp r3, #5
	bge _020B4074
	ldr r1, [r6, #0x10]
	cmp r1, #0
	beq _020B405C
	bl sub_20B1B8C
	mov r2, #0
	mov r0, r6
	mov r1, r5
	mov r3, r2
	bl sub_20B1844
	cmp r0, #0
	bne _020B4098
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020B405C:
	cmp r3, #4
	moveq r0, #1
	streq r0, [r6, #0x14]
	mov r0, r6
	bl sub_20B1B8C
	b _020B4098
_020B4074:
	cmp r3, #7
	beq _020B4098
	bl sub_20B1B8C
	mov r0, r6
	mov r1, r4
	bl sub_20B1674
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
_020B4098:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B400C

	arm_func_start sub_20B40A0
sub_20B40A0: // 0x020B40A0
	sub r0, r0, r1
	mov r0, r0, lsl #0x10
	mov r0, r0, asr #0x10
	bx lr
	arm_func_end sub_20B40A0

	arm_func_start sub_20B40B0
sub_20B40B0: // 0x020B40B0
	mov r3, r2, asr #8
	strb r3, [r0, r1]
	add r1, r1, #1
	strb r2, [r0, r1]
	bx lr
	arm_func_end sub_20B40B0

	arm_func_start sub_20B40C4
sub_20B40C4: // 0x020B40C4
	ldrb r2, [r0, r1]
	add r1, r1, #1
	ldrb r1, [r0, r1]
	mov r0, r2, lsl #8
	and r0, r0, #0xff00
	mov r0, r0, lsl #0x10
	orr r0, r1, r0, lsr #16
	bx lr
	arm_func_end sub_20B40C4

	arm_func_start sub_20B40E4
sub_20B40E4: // 0x020B40E4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x18]
	cmp r1, #0
	ldmneia sp!, {r4, pc}
	mov r1, #1
	str r1, [r4, #0x18]
	bl gt2CloseAllConnections
	mov r0, r4
	bl sub_20B1A70
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl sub_20B46C0
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B40E4

	arm_func_start sub_20B4120
sub_20B4120: // 0x020B4120
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, [r5, #0x10]
	bl ArrayLength
	subs r4, r0, #1
	addmi sp, sp, #4
	ldmmiia sp!, {r4, r5, pc}
_020B4140:
	ldr r0, [r5, #0x10]
	mov r1, r4
	bl ArrayNth
	ldr r0, [r0, #0]
	bl sub_20B43B0
	subs r4, r4, #1
	bpl _020B4140
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B4120

	arm_func_start sub_20B4164
sub_20B4164: // 0x020B4164
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	bl sub_20A0CA4
	str r0, [sp]
	ldr r0, [r4, #0xc]
	ldr r1, _020B419C // =sub_20B41A0
	add r2, sp, #0
	bl TableMapSafe2
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B419C: .word sub_20B41A0
	arm_func_end sub_20B4164

	arm_func_start sub_20B41A0
sub_20B41A0: // 0x020B41A0
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #0]
	ldr r1, [r1, #0]
	ldr r0, [r4, #0xc]
	cmp r0, #7
	beq _020B41CC
	mov r0, r4
	bl sub_20B1C44
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
_020B41CC:
	ldr r0, [r4, #0xc]
	cmp r0, #7
	bne _020B41F8
	ldr r0, [r4, #0x14]
	cmp r0, #0
	bne _020B41F8
	ldr r0, [r4, #0x24]
	cmp r0, #0
	bne _020B41F8
	mov r0, r4
	bl sub_20B43B0
_020B41F8:
	mov r0, #1
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B41A0

	arm_func_start sub_20B4200
sub_20B4200: // 0x020B4200
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x18
	mov r6, r0
	mov r5, r1
	add r0, sp, #0x34
	add r1, sp, #0x38
	mov r4, r2
	bl sub_20B49D0
	ldr r0, [r6, #0]
	bl sub_20A0944
	cmp r0, #0
	addeq sp, sp, #0x18
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, lr}
	addeq sp, sp, #0x10
	bxeq lr
	mov r1, r4, asr #8
	mov r0, r4, lsl #8
	add ip, sp, #0x10
	mov r3, #0
	str r3, [ip]
	str r3, [ip, #4]
	mov r2, #2
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	strh r0, [sp, #0x12]
	strb r2, [sp, #0x11]
	str r5, [sp, #0x14]
	str ip, [sp]
	mov r0, #8
	str r0, [sp, #4]
	ldr r0, [r6, #0]
	ldr r1, [sp, #0x34]
	ldr r2, [sp, #0x38]
	bl sub_20A061C
	mvn r1, #0
	cmp r0, r1
	bne _020B4334
	ldr r0, [r6, #0]
	bl WSAGetLastError
	mvn r1, #0xe
	cmp r0, r1
	bne _020B42E0
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20B2DA8
	cmp r0, #0
	bne _020B439C
	add sp, sp, #0x18
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
_020B42E0:
	mvn r1, #0x29
	cmp r0, r1
	beq _020B42F8
	mvn r1, #5
	cmp r0, r1
	bne _020B430C
_020B42F8:
	add sp, sp, #0x18
	mov r0, #1
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
_020B430C:
	mvn r1, #0x22
	cmp r0, r1
	beq _020B439C
	mov r0, r6
	bl sub_20B40E4
	add sp, sp, #0x18
	mov r0, #0
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
_020B4334:
	ldr r0, [r6, #0x28]
	cmp r0, #0
	beq _020B439C
	mov r0, r6
	mov r1, r5
	mov r2, r4
	bl sub_20B4930
	mov r1, #0
	str r1, [sp]
	ldr r2, [sp, #0x34]
	mov r1, r0
	str r2, [sp, #4]
	ldr ip, [sp, #0x38]
	mov r3, r4
	mov r0, r6
	mov r2, r5
	str ip, [sp, #8]
	mov r4, #1
	str r4, [sp, #0xc]
	bl sub_20B1258
	cmp r0, #0
	addeq sp, sp, #0x18
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, lr}
	addeq sp, sp, #0x10
	bxeq lr
_020B439C:
	mov r0, #1
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20B4200

	arm_func_start sub_20B43B0
sub_20B43B0: // 0x020B43B0
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, [sp, #0x10]
	ldr r0, [r1, #0x14]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	addne sp, sp, #0x10
	bxne lr
	ldr r0, [r1, #0x24]
	cmp r0, #0
	ldmneia sp!, {r4, r5, r6, lr}
	addne sp, sp, #0x10
	bxne lr
	ldr r0, [r1, #0xc]
	cmp r0, #7
	bne _020B4468
	ldr r0, [r1, #8]
	ldr r0, [r0, #0x10]
	bl ArrayLength
	mov r6, r0
	mov r5, #0
	cmp r6, #0
	ldmleia sp!, {r4, r5, r6, lr}
	addle sp, sp, #0x10
	bxle lr
_020B4414:
	ldr r4, [sp, #0x10]
	mov r1, r5
	ldr r0, [r4, #8]
	ldr r0, [r0, #0x10]
	bl ArrayNth
	ldr r0, [r0, #0]
	cmp r4, r0
	bne _020B4450
	ldr r0, [r4, #8]
	mov r1, r5
	ldr r0, [r0, #0x10]
	bl ArrayDeleteAt
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
_020B4450:
	add r5, r5, #1
	cmp r5, r6
	blt _020B4414
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
_020B4468:
	ldr r0, [r1, #8]
	add r1, sp, #0x10
	ldr r0, [r0, #0xc]
	bl TableRemove
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20B43B0

	arm_func_start sub_20B4484
sub_20B4484: // 0x020B4484
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r3
	mov r5, r2
	mov r6, r1
	mov r3, #0
	mov r1, r5
	mov r2, r4
	mov r7, r0
	str r3, [sp]
	bl sub_20B4930
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #5
	ldmneia sp!, {r4, r5, r6, r7, pc}
	bl sub_20B46A8
	str r0, [sp]
	cmp r0, #0
	beq _020B4624
	mov r1, #0
	mov r2, #0xa0
	bl memset
	ldr r0, [sp]
	str r5, [r0]
	ldr r0, [sp]
	strh r4, [r0, #4]
	ldr r0, [sp]
	str r7, [r0, #8]
	bl sub_20A0CA4
	ldr r2, [sp]
	mov r1, #0
	str r0, [r2, #0x1c]
	ldr r2, [sp]
	ldr r0, [r2, #0x1c]
	str r0, [r2, #0x88]
	ldr r0, [sp]
	strh r1, [r0, #0x64]
	ldr r0, [sp]
	strh r1, [r0, #0x66]
	ldr r0, [sp]
	ldr r1, [r7, #0x3c]
	add r0, r0, #0x44
	bl sub_20B1128
	cmp r0, #0
	beq _020B4624
	ldr r0, [sp]
	ldr r1, [r7, #0x38]
	add r0, r0, #0x50
	bl sub_20B1128
	cmp r0, #0
	beq _020B4624
	mov r0, #0x10
	mov r1, #0x40
	mov r2, #0
	bl sub_209FB2C
	ldr r1, [sp]
	str r0, [r1, #0x5c]
	ldr r0, [sp]
	ldr r0, [r0, #0x5c]
	cmp r0, #0
	beq _020B4624
	mov r0, #0x10
	mov r1, #0x40
	mov r2, #0
	bl sub_209FB2C
	ldr r1, [sp]
	str r0, [r1, #0x60]
	ldr r0, [sp]
	ldr r0, [r0, #0x60]
	cmp r0, #0
	beq _020B4624
	mov r0, #4
	mov r1, #2
	mov r2, #0
	bl sub_209FB2C
	ldr r1, [sp]
	str r0, [r1, #0x98]
	ldr r0, [sp]
	ldr r0, [r0, #0x98]
	cmp r0, #0
	beq _020B4624
	mov r0, #4
	mov r1, #2
	mov r2, #0
	bl sub_209FB2C
	ldr r1, [sp]
	str r0, [r1, #0x9c]
	ldr r0, [sp]
	ldr r0, [r0, #0x9c]
	cmp r0, #0
	beq _020B4624
	ldr r0, [r7, #0xc]
	add r1, sp, #0
	bl TableEnter
	mov r0, r7
	mov r1, r5
	mov r2, r4
	bl sub_20B4930
	str r0, [r6]
	ldr r0, [r6, #0]
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, pc}
_020B4624:
	ldr r0, [sp]
	cmp r0, #0
	beq _020B469C
	ldr r0, [r0, #0x44]
	bl DWCi_GsFree
	ldr r0, [sp]
	ldr r0, [r0, #0x50]
	bl DWCi_GsFree
	ldr r0, [sp]
	ldr r0, [r0, #0x5c]
	cmp r0, #0
	beq _020B4658
	bl ArrayFree
_020B4658:
	ldr r0, [sp]
	ldr r0, [r0, #0x60]
	cmp r0, #0
	beq _020B466C
	bl ArrayFree
_020B466C:
	ldr r0, [sp]
	ldr r0, [r0, #0x98]
	cmp r0, #0
	beq _020B4680
	bl ArrayFree
_020B4680:
	ldr r0, [sp]
	ldr r0, [r0, #0x9c]
	cmp r0, #0
	beq _020B4694
	bl ArrayFree
_020B4694:
	ldr r0, [sp]
	bl DWCi_GsFree
_020B469C:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20B4484

	arm_func_start sub_20B46A8
sub_20B46A8: // 0x020B46A8
	ldr ip, _020B46B4 // =DWCi_GsMalloc
	mov r0, #0xa0
	bx ip
	.align 2, 0
_020B46B4: .word DWCi_GsMalloc
	arm_func_end sub_20B46A8

	arm_func_start sub_20B46B8
sub_20B46B8: // 0x020B46B8
	str r1, [r0, #0x20]
	bx lr
	arm_func_end sub_20B46B8

	arm_func_start sub_20B46C0
sub_20B46C0: // 0x020B46C0
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	movne r0, #1
	strne r0, [r4, #0x14]
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0]
	bl sub_20A07E4
	ldr r0, [r4, #0xc]
	bl TableFree
	ldr r0, [r4, #0x10]
	bl ArrayFree
	mov r0, r4
	bl DWCi_GsFree
	bl sub_20A0C90
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B46C0

	arm_func_start sub_20B4704
sub_20B4704: // 0x020B4704
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x1c
	mov r4, r1
	mov r6, r3
	mov r5, r0
	mov r7, r2
	bl sub_20A0C94
	cmp r6, #0
	moveq r6, #0x10000
	cmp r7, #0
	add r1, sp, #0x14
	add r2, sp, #8
	mov r0, r4
	moveq r7, #0x10000
	bl sub_20B4A1C
	cmp r0, #0
	addeq sp, sp, #0x1c
	moveq r0, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, #0x44
	bl DWCi_GsMalloc
	movs r4, r0
	addeq sp, sp, #0x1c
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r1, #0
	mov r2, #0x44
	bl memset
	mvn r0, #0
	str r0, [r4]
	str r6, [r4, #0x3c]
	ldr r1, [sp, #0x30]
	str r7, [r4, #0x38]
	ldr r0, _020B4924 // =sub_20B4978
	str r1, [r4, #0x24]
	str r0, [sp]
	mov r0, #0
	ldr r3, _020B4928 // =sub_20B49A8
	str r0, [sp, #4]
	mov r0, #4
	mov r1, #0x20
	mov r2, #2
	bl TableNew2
	str r0, [r4, #0xc]
	ldr r0, [r4, #0xc]
	cmp r0, #0
	bne _020B47D4
	mov r0, r4
	bl DWCi_GsFree
	add sp, sp, #0x1c
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B47D4:
	mov r0, #4
	ldr r2, _020B492C // =sub_20B4968
	mov r1, r0
	bl sub_209FB2C
	str r0, [r4, #0x10]
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _020B4810
	ldr r0, [r4, #0xc]
	bl TableFree
	mov r0, r4
	bl DWCi_GsFree
	add sp, sp, #0x1c
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B4810:
	mov r0, #2
	mov r1, r0
	mov r2, #0
	bl sub_20A0800
	str r0, [r4]
	ldr r1, [r4, #0]
	mvn r0, #0
	cmp r1, r0
	bne _020B4858
	ldr r0, [r4, #0xc]
	bl TableFree
	ldr r0, [r4, #0x10]
	bl ArrayFree
	mov r0, r4
	bl DWCi_GsFree
	add sp, sp, #0x1c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B4858:
	add r1, sp, #0xc
	mov r0, #0
	str r0, [r1]
	str r0, [r1, #4]
	ldrh r0, [sp, #8]
	ldr r3, [sp, #0x14]
	mov ip, #2
	mov r2, r0, asr #8
	mov r0, r0, lsl #8
	and r2, r2, #0xff
	and r0, r0, #0xff00
	orr r0, r2, r0
	strb ip, [sp, #0xd]
	str r3, [sp, #0x10]
	strh r0, [sp, #0xe]
	ldr r0, [r4, #0]
	mov r2, #8
	bl sub_20A0770
	mvn r1, #0
	cmp r0, r1
	bne _020B48D8
	ldr r0, [r4, #0]
	bl sub_20A07E4
	ldr r0, [r4, #0xc]
	bl TableFree
	ldr r0, [r4, #0x10]
	bl ArrayFree
	mov r0, r4
	bl DWCi_GsFree
	add sp, sp, #0x1c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B48D8:
	mov r0, #8
	str r0, [sp, #0x18]
	ldr r0, [r4, #0]
	add r1, sp, #0xc
	add r2, sp, #0x18
	bl sub_20A05A4
	ldr r1, [sp, #0x10]
	mov r0, #0
	str r1, [r4, #4]
	ldrh r1, [sp, #0xe]
	mov r2, r1, asr #8
	mov r1, r1, lsl #8
	and r2, r2, #0xff
	and r1, r1, #0xff00
	orr r1, r2, r1
	strh r1, [r4, #8]
	str r4, [r5]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B4924: .word sub_20B4978
_020B4928: .word sub_20B49A8
_020B492C: .word sub_20B4968
	arm_func_end sub_20B4704

	arm_func_start sub_20B4930
sub_20B4930: // 0x020B4930
	stmdb sp!, {lr}
	sub sp, sp, #0xa4
	add r3, sp, #4
	str r1, [sp, #4]
	strh r2, [sp, #8]
	str r3, [sp]
	ldr r0, [r0, #0xc]
	add r1, sp, #0
	bl TableLookup
	cmp r0, #0
	ldrne r0, [r0, #0]
	moveq r0, #0
	add sp, sp, #0xa4
	ldmia sp!, {pc}
	arm_func_end sub_20B4930
	
	arm_func_start sub_20B4968
sub_20B4968: // 0x020B4930
	ldr ip, _020B4974 // =sub_20B1B08
	ldr r0, [r0, #0]
	bx ip
	.align 2, 0
_020B4974: .word sub_20B1B08
	arm_func_end sub_20B4968

	arm_func_start sub_20B4978
sub_20B4978: // 0x020B4978
	ldr r3, [r0, #0]
	ldr r2, [r1, #0]
	ldr r0, [r3, #0]
	ldr r1, [r2, #0]
	cmp r0, r1
	subne r0, r0, r1
	ldreqh r1, [r3, #4]
	ldreqh r0, [r2, #4]
	subeq r0, r1, r0
	moveq r0, r0, lsl #0x10
	moveq r0, r0, asr #0x10
	bx lr
	arm_func_end sub_20B4978

	arm_func_start sub_20B49A8
sub_20B49A8: // 0x020B49A8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r2, [r0, #0]
	ldrh r0, [r2, #4]
	ldr r2, [r2, #0]
	mul r0, r2, r0
	bl _u32_div_f
	mov r0, r1
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20B49A8

	arm_func_start sub_20B49D0
sub_20B49D0: // 0x020B49D0
	stmdb sp!, {r4, lr}
	ldr r2, [r0, #0]
	mov r4, r1
	cmp r2, #0
	ldreq r2, _020B4A18 // =0x0211E870
	moveq r1, #0
	streq r2, [r0]
	streq r1, [r4]
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #0]
	mvn r0, #0
	cmp r1, r0
	ldmneia sp!, {r4, pc}
	mov r0, r2
	bl strlen
	add r0, r0, #1
	str r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B4A18: .word 0x0211E870
	arm_func_end sub_20B49D0

	arm_func_start sub_20B4A1C
sub_20B4A1C: // 0x020B4A1C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x104
	movs r8, r0
	mov r7, r1
	mov r6, r2
	beq _020B4A40
	ldrsb r1, [r8, #0]
	cmp r1, #0
	bne _020B4A4C
_020B4A40:
	mov r5, #0
	mov r4, r5
	b _020B4B78
_020B4A4C:
	mov r1, #0x3a
	bl strchr
	movs r4, r0
	moveq r4, #0
	beq _020B4B34
	cmp r4, r8
	moveq r8, #0
	moveq r5, r8
	beq _020B4AAC
	sub r9, r4, r8
	cmp r9, #0x100
	blt _020B4A90
	ldr r0, _020B4B94 // =aLenGti2StackHo
	ldr r1, _020B4B98 // =aGt2utilityC
	mov r2, #0
	mov r3, #0x81
	bl __msl_assertion_failed
_020B4A90:
	add r0, sp, #0
	mov r1, r8
	mov r2, r9
	bl memcpy
	add r8, sp, #0
	mov r0, #0
	strb r0, [r8, r9]
_020B4AAC:
	ldrsb r0, [r4, #1]
	add r3, r4, #1
	cmp r0, #0
	beq _020B4B04
	ldr r1, _020B4B9C // =_0211714C
	mov r2, #0
_020B4AC4:
	cmp r0, #0
	blt _020B4AD4
	cmp r0, #0x80
	blt _020B4ADC
_020B4AD4:
	mov r0, r2
	b _020B4AE8
_020B4ADC:
	mov r0, r0, lsl #1
	ldrh r0, [r1, r0]
	and r0, r0, #8
_020B4AE8:
	cmp r0, #0
	addeq sp, sp, #0x104
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldrsb r0, [r3, #1]!
	cmp r0, #0
	bne _020B4AC4
_020B4B04:
	add r0, r4, #1
	bl atoi
	cmp r0, #0
	blt _020B4B20
	ldr r1, _020B4BA0 // =0x0000FFFF
	cmp r0, r1
	ble _020B4B2C
_020B4B20:
	add sp, sp, #0x104
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B4B2C:
	mov r0, r0, lsl #0x10
	mov r4, r0, lsr #0x10
_020B4B34:
	cmp r8, #0
	beq _020B4B78
	mov r0, r8
	bl sub_20A0580
	mov r5, r0
	mvn r0, #0
	cmp r5, r0
	bne _020B4B78
	mov r0, r8
	bl sub_20BE844
	cmp r0, #0
	addeq sp, sp, #0x104
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r0, #0xc]
	ldr r0, [r0, #0]
	ldr r5, [r0, #0]
_020B4B78:
	cmp r7, #0
	strne r5, [r7]
	cmp r6, #0
	strneh r4, [r6]
	mov r0, #1
	add sp, sp, #0x104
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020B4B94: .word aLenGti2StackHo
_020B4B98: .word aGt2utilityC
_020B4B9C: .word _0211714C
_020B4BA0: .word 0x0000FFFF
	arm_func_end sub_20B4A1C

	arm_func_start gt2AddressToString
gt2AddressToString: // 0x020B4BA4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r2
	mov r4, r1
	bne _020B4BD4
	ldr r2, _020B4C58 // =0x02145288
	ldr r3, _020B4C5C // =0x0214528C
	ldr ip, [r2]
	mov r1, #0x16
	eor ip, ip, #1
	mla r5, ip, r1, r3
	str ip, [r2]
_020B4BD4:
	cmp r0, #0
	beq _020B4C2C
	str r0, [sp]
	cmp r4, #0
	beq _020B4C0C
	add r0, sp, #0
	ldmia r0, {r0}
	bl sub_20BE3D4
	mov r2, r0
	ldr r1, _020B4C60 // =aSD
	mov r0, r5
	mov r3, r4
	bl sprintf
	b _020B4C4C
_020B4C0C:
	add r0, sp, #0
	ldmia r0, {r0}
	bl sub_20BE3D4
	mov r2, r0
	ldr r1, _020B4C64 // =0x0211E8AC
	mov r0, r5
	bl sprintf
	b _020B4C4C
_020B4C2C:
	cmp r4, #0
	moveq r0, #0
	streqb r0, [r5]
	beq _020B4C4C
	ldr r1, _020B4C68 // =0x0211E8B0
	mov r0, r5
	mov r2, r4
	bl sprintf
_020B4C4C:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B4C58: .word 0x02145288
_020B4C5C: .word 0x0214528C
_020B4C60: .word aSD
_020B4C64: .word 0x0211E8AC
_020B4C68: .word 0x0211E8B0
	arm_func_end gt2AddressToString

	arm_func_start sub_20B4C6C
sub_20B4C6C: // 0x020B4C6C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x2c
	mov r6, r0
	mov r7, r1
	mov r5, r2
	bl sub_20B5A34
	cmp r0, #0
	addeq sp, sp, #0x2c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldrb r4, [r6, #7]
	cmp r4, #5
	beq _020B4CA4
	cmp r4, #7
	bne _020B4D40
_020B4CA4:
	cmp r7, #0x14
	addlt sp, sp, #0x2c
	ldmltia sp!, {r4, r5, r6, r7, pc}
	add r3, sp, #0
	mov r2, #0xa
_020B4CB8:
	ldrb r1, [r6], #1
	ldrb r0, [r6], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _020B4CB8
	ldr r3, [sp, #8]
	mov r1, r3, lsr #0x18
	mov r0, r3, lsr #8
	mov r2, r3, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	mov r3, r3, lsl #0x18
	orr r0, r1, r0
	and r2, r2, #0xff0000
	and r1, r3, #0xff000000
	orr r0, r2, r0
	orr r0, r1, r0
	bl sub_20B5BC8
	cmp r0, #0
	addeq sp, sp, #0x2c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	cmp r4, #5
	bne _020B4D2C
	add r1, sp, #0
	mov r2, r5
	bl sub_20B4FC0
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B4D2C:
	add r1, sp, #0
	mov r2, r5
	bl sub_20B4ED8
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B4D40:
	cmp r7, #0x15
	addlt sp, sp, #0x2c
	ldmltia sp!, {r4, r5, r6, r7, pc}
	add r3, sp, #0x14
	mov r2, #0xa
_020B4D54:
	ldrb r1, [r6], #1
	ldrb r0, [r6], #1
	subs r2, r2, #1
	strb r1, [r3], #1
	strb r0, [r3], #1
	bne _020B4D54
	ldrb r0, [r6, #0]
	strb r0, [r3]
	ldr r3, [sp, #0x1c]
	mov r1, r3, lsr #0x18
	mov r0, r3, lsr #8
	mov r2, r3, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	mov r3, r3, lsl #0x18
	orr r0, r1, r0
	and r2, r2, #0xff0000
	and r1, r3, #0xff000000
	orr r0, r2, r0
	orr r0, r1, r0
	bl sub_20B5BC8
	cmp r0, #0
	addeq sp, sp, #0x2c
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	add r1, sp, #0x14
	mov r2, r5
	bl sub_20B4DC8
	add sp, sp, #0x2c
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20B4C6C

	arm_func_start sub_20B4DC8
sub_20B4DC8: // 0x020B4DC8
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r3, r1
	ldrb r1, [r3, #7]
	mov r4, r0
	cmp r1, #1
	beq _020B4DF4
	cmp r1, #2
	beq _020B4E90
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_020B4DF4:
	ldrb r0, [r3, #0xc]
	cmp r0, #2
	addhi sp, sp, #8
	ldmhiia sp!, {r4, pc}
	add r0, r4, r0, lsl #2
	mov r1, #1
	str r1, [r0, #0x14]
	ldr r0, [r4, #0x10]
	cmp r0, #0
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r0, [r4, #0x18]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r1, [r4, #4]
	mvn r0, #0
	cmp r1, r0
	beq _020B4E60
	ldr r0, [r4, #0x14]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
_020B4E60:
	mov r0, #1
	str r0, [r4, #0x10]
	bl sub_20A0CA4
	ldr r1, _020B4ED4 // =0x00002710
	add r0, r0, r1
	str r0, [r4, #0x28]
	ldr r0, [r4, #0x10]
	ldr r1, [r4, #0x3c]
	ldr r2, [r4, #0x34]
	blx r2
	add sp, sp, #8
	ldmia sp!, {r4, pc}
_020B4E90:
	mov r0, #3
	strb r0, [r3, #7]
	ldrh r0, [r2, #2]
	mov ip, #0x15
	mov r1, r0, asr #8
	mov r0, r0, lsl #8
	str ip, [sp]
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	mov ip, r0, lsl #0x10
	ldr r1, [r2, #4]
	ldr r0, [r4, #0]
	mov r2, ip, lsr #0x10
	bl sub_20B59E0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B4ED4: .word 0x00002710
	arm_func_end sub_20B4DC8

	arm_func_start sub_20B4ED8
sub_20B4ED8: // 0x020B4ED8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r3, [r5, #0x10]
	mov r4, r2
	cmp r3, #2
	addlt sp, sp, #4
	ldmltia sp!, {r4, r5, pc}
	ldr r3, [r4, #4]
	mov r2, #1
	str r3, [r5, #0x2c]
	ldrh r3, [r4, #2]
	mov ip, r3, asr #8
	mov r3, r3, lsl #8
	and ip, ip, #0xff
	and r3, r3, #0xff00
	orr r3, ip, r3
	strh r3, [r5, #0x30]
	strb r2, [r5, #0x32]
	ldrb r2, [r1, #0x12]
	cmp r2, #0
	bne _020B4F3C
	bl sub_20B55CC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020B4F3C:
	ldr r2, [r5, #0x10]
	cmp r2, #2
	bne _020B4FA0
	ldrb r1, [r5, #0x33]
	cmp r1, #0
	bne _020B4F58
	bl sub_20B55CC
_020B4F58:
	mov r0, #3
	str r0, [r5, #0x10]
	bl sub_20A0CA4
	ldr r1, _020B4FBC // =0x00001388
	mvn r2, #0
	add r0, r0, r1
	str r0, [r5, #0x28]
	ldr r1, [r5, #4]
	cmp r1, r2
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r3, [r5, #0x3c]
	ldr r5, [r5, #0x38]
	mov r2, r4
	mov r0, #0
	blx r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020B4FA0:
	ldrb r1, [r1, #0x13]
	cmp r1, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	bl sub_20B55CC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B4FBC: .word 0x00001388
	arm_func_end sub_20B4ED8

	arm_func_start sub_20B4FC0
sub_20B4FC0: // 0x020B4FC0
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r1
	ldrb r1, [r5, #0x13]
	mov r4, r0
	cmp r1, #0
	bne _020B4FE4
	mov r1, r2
	bl sub_20B5090
_020B4FE4:
	ldr r0, [r4, #0x10]
	cmp r0, #2
	addge sp, sp, #4
	ldmgeia sp!, {r4, r5, pc}
	ldrb r1, [r5, #0x13]
	cmp r1, #0
	beq _020B503C
	mov r0, #3
	cmp r1, #1
	moveq r0, #1
	beq _020B5018
	cmp r1, #2
	moveq r0, #2
_020B5018:
	ldr r3, [r4, #0x3c]
	ldr ip, [r4, #0x38]
	mvn r1, #0
	mov r2, #0
	blx ip
	ldr r0, [r4, #8]
	bl NNCancel
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020B503C:
	ldr r0, [r5, #0xc]
	mov r1, #0
	str r0, [r4, #0x2c]
	ldrh r2, [r5, #0x10]
	mov r0, #2
	mov r3, r2, asr #8
	mov r2, r2, lsl #8
	and r3, r3, #0xff
	and r2, r2, #0xff00
	orr r2, r3, r2
	strh r2, [r4, #0x30]
	str r1, [r4, #0x20]
	str r0, [r4, #0x10]
	ldr r0, [r4, #0x10]
	ldr r1, [r4, #0x3c]
	ldr r2, [r4, #0x34]
	blx r2
	mov r0, r4
	bl sub_20B55CC
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B4FC0

	arm_func_start sub_20B5090
sub_20B5090: // 0x020B5090
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x20
	ldr r6, _020B5158 // =0x0211E8B4
	add r3, sp, #4
	ldrb ip, [r6]
	ldrb r2, [r6, #1]
	mov r5, #2
	mov r4, #6
	strb ip, [r3]
	strb r2, [r3, #1]
	ldrb lr, [r6, #2]
	ldrb ip, [r6, #3]
	mov r2, #0x15
	strb lr, [r3, #2]
	strb ip, [r3, #3]
	ldrb lr, [r6, #4]
	ldrb ip, [r6, #5]
	strb lr, [r3, #4]
	strb ip, [r3, #5]
	strb r5, [sp, #0xa]
	strb r4, [sp, #0xb]
	ldr r4, [r0, #0xc]
	strb r4, [sp, #0x11]
	ldr r5, [r0, #8]
	mov lr, r5, lsr #0x18
	mov ip, r5, lsr #8
	mov r4, r5, lsl #8
	mov r5, r5, lsl #0x18
	and lr, lr, #0xff
	and ip, ip, #0xff00
	and r4, r4, #0xff0000
	orr ip, lr, ip
	and r5, r5, #0xff000000
	orr r4, r4, ip
	orr r4, r5, r4
	str r4, [sp, #0xc]
	ldrh lr, [r1, #2]
	str r2, [sp]
	mov ip, lr, asr #8
	mov r2, lr, lsl #8
	and ip, ip, #0xff
	and r2, r2, #0xff00
	orr r2, ip, r2
	mov r2, r2, lsl #0x10
	ldr r0, [r0, #0]
	ldr r1, [r1, #4]
	mov r2, r2, lsr #0x10
	bl sub_20B59E0
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B5158: .word 0x0211E8B4
	arm_func_end sub_20B5090

	arm_func_start NNThink
NNThink: // 0x020B515C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _020B51AC // =0x021452C8
	ldr r0, [r0, #0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	bl ArrayLength
	subs r5, r0, #1
	addmi sp, sp, #4
	ldmmiia sp!, {r4, r5, pc}
	ldr r4, _020B51AC // =0x021452C8
_020B518C:
	ldr r0, [r4, #0]
	mov r1, r5
	bl ArrayNth
	bl sub_20B51B0
	subs r5, r5, #1
	bpl _020B518C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B51AC: .word 0x021452C8
	arm_func_end NNThink

	arm_func_start sub_20B51B0
sub_20B51B0: // 0x020B51B0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x20
	mov r1, #8
	mov r9, r0
	str r1, [sp, #0x10]
	ldr r1, [r9, #0x10]
	cmp r1, #4
	bne _020B51DC
	bl sub_20B5A98
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
_020B51DC:
	ldr r0, [r9, #0]
	mvn r10, #0
	cmp r0, r10
	beq _020B5258
	ldr r6, _020B53A4 // =0x021452CC
	add r8, sp, #8
	add r7, sp, #0x10
	mov r5, #0x200
	mov r4, #0
_020B5200:
	bl sub_20A0974
	cmp r0, #0
	beq _020B5258
	str r8, [sp]
	str r7, [sp, #4]
	ldr r0, [r9, #0]
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl sub_20A0688
	mov r1, r0
	cmp r1, r10
	beq _020B5258
	mov r0, r6
	mov r2, r8
	bl sub_20B4C6C
	ldr r0, [r9, #0x10]
	cmp r0, #4
	beq _020B5258
	ldr r0, [r9, #0]
	cmp r0, r10
	bne _020B5200
_020B5258:
	ldr r0, [r9, #0x10]
	cmp r0, #0
	beq _020B526C
	cmp r0, #2
	bne _020B52D8
_020B526C:
	bl sub_20A0CA4
	ldr r1, [r9, #0x28]
	cmp r0, r1
	bls _020B52D8
	ldr r1, [r9, #0x20]
	ldr r0, [r9, #0x24]
	cmp r1, r0
	ble _020B52B0
	ldr r3, [r9, #0x3c]
	ldr r4, [r9, #0x38]
	mov r0, #2
	mvn r1, #0
	mov r2, #0
	blx r4
	ldr r0, [r9, #8]
	bl NNCancel
	b _020B52D8
_020B52B0:
	add r0, r1, #1
	str r0, [r9, #0x20]
	ldr r0, [r9, #0x10]
	cmp r0, #0
	bne _020B52D0
	mov r0, r9
	bl sub_20B56EC
	b _020B52D8
_020B52D0:
	mov r0, r9
	bl sub_20B55CC
_020B52D8:
	ldr r0, [r9, #0x10]
	cmp r0, #3
	bne _020B5358
	bl sub_20A0CA4
	ldr r1, [r9, #0x28]
	cmp r0, r1
	bls _020B5358
	ldr r1, [r9, #4]
	mvn r0, #0
	cmp r1, r0
	bne _020B5350
	mov r0, #2
	strb r0, [sp, #0x15]
	ldrh r1, [r9, #0x30]
	add r2, sp, #0x14
	mov r0, #0
	mov r3, r1, asr #8
	mov r1, r1, lsl #8
	and r3, r3, #0xff
	and r1, r1, #0xff00
	orr r1, r3, r1
	strh r1, [sp, #0x16]
	ldr r1, [r9, #0x2c]
	str r1, [sp, #0x18]
	ldr r1, [r9, #0]
	ldr r3, [r9, #0x3c]
	ldr r4, [r9, #0x38]
	blx r4
	mvn r0, #0
	str r0, [r9]
_020B5350:
	ldr r0, [r9, #8]
	bl NNCancel
_020B5358:
	ldr r0, [r9, #0x10]
	cmp r0, #1
	addne sp, sp, #0x20
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	bl sub_20A0CA4
	ldr r1, [r9, #0x28]
	cmp r0, r1
	addls sp, sp, #0x20
	ldmlsia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r3, [r9, #0x3c]
	ldr r4, [r9, #0x38]
	mov r0, #1
	mvn r1, #0
	mov r2, #0
	blx r4
	ldr r0, [r9, #8]
	bl NNCancel
	add sp, sp, #0x20
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020B53A4: .word 0x021452CC
	arm_func_end sub_20B51B0

	arm_func_start NNCancel
NNCancel: // 0x020B53A8
	stmdb sp!, {r4, lr}
	bl sub_20B5BC8
	movs r4, r0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0]
	mvn r1, #0
	cmp r0, r1
	beq _020B53CC
	bl sub_20A07E4
_020B53CC:
	mvn r0, #0
	str r0, [r4]
	mov r0, #4
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end NNCancel

	arm_func_start NNBeginNegotiationWithSocket
NNBeginNegotiationWithSocket: // 0x020B53E0
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	ldr ip, _020B54A8 // =0x02144D20
	mov r8, r0
	ldr r0, [ip]
	mov r7, r1
	cmp r0, #1
	mov r6, r2
	mov r5, r3
	movne r0, #2
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	bl sub_20B54AC
	cmp r0, #0
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	bl sub_20B5B00
	movs r4, r0
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	str r8, [r4, #4]
	str r6, [r4, #0xc]
	str r7, [r4, #8]
	ldr r1, [sp, #0x18]
	str r5, [r4, #0x34]
	mov r0, #2
	ldr r2, [sp, #0x1c]
	str r1, [r4, #0x38]
	mov r1, r0
	str r2, [r4, #0x3c]
	mov r2, #0
	bl sub_20A0800
	str r0, [r4]
	mov r0, #0
	str r0, [r4, #0x20]
	strb r0, [r4, #0x32]
	strb r0, [r4, #0x33]
	str r0, [r4, #0x2c]
	strh r0, [r4, #0x30]
	str r0, [r4, #0x24]
	ldr r1, [r4, #0]
	mvn r0, #0
	cmp r1, r0
	bne _020B5498
	mov r0, r4
	bl sub_20B5A98
	mov r0, #2
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020B5498:
	mov r0, r4
	bl sub_20B56EC
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020B54A8: .word 0x02144D20
	arm_func_end NNBeginNegotiationWithSocket

	arm_func_start sub_20B54AC
sub_20B54AC: // 0x020B54AC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020B553C // =0x021452C4
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _020B54DC
	ldr r0, _020B5540 // =0x021452BC
	ldr r1, _020B5544 // =aNatneg1GsNinte
	ldr r0, [r0, #0]
	bl sub_20B5554
	ldr r1, _020B553C // =0x021452C4
	str r0, [r1]
_020B54DC:
	ldr r0, _020B5548 // =0x021452C0
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _020B5504
	ldr r0, _020B554C // =0x021452B8
	ldr r1, _020B5550 // =aNatneg2GsNinte
	ldr r0, [r0, #0]
	bl sub_20B5554
	ldr r1, _020B5548 // =0x021452C0
	str r0, [r1]
_020B5504:
	ldr r0, _020B553C // =0x021452C4
	ldr r0, [r0, #0]
	cmp r0, #0
	beq _020B5524
	ldr r0, _020B5548 // =0x021452C0
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _020B5530
_020B5524:
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {pc}
_020B5530:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020B553C: .word 0x021452C4
_020B5540: .word 0x021452BC
_020B5544: .word aNatneg1GsNinte
_020B5548: .word 0x021452C0
_020B554C: .word 0x021452B8
_020B5550: .word aNatneg2GsNinte
	arm_func_end sub_20B54AC

	arm_func_start sub_20B5554
sub_20B5554: // 0x020B5554
	stmdb sp!, {lr}
	sub sp, sp, #0x84
	cmp r0, #0
	bne _020B5580
	ldr r2, _020B558C // =aSS_1
	str r1, [sp]
	ldr r3, _020B5590 // =0x02144D64
	add r0, sp, #4
	mov r1, #0x80
	bl snprintf
	add r0, sp, #4
_020B5580:
	bl sub_20B5594
	add sp, sp, #0x84
	ldmia sp!, {pc}
	.align 2, 0
_020B558C: .word aSS_1
_020B5590: .word 0x02144D64
	arm_func_end sub_20B5554

	arm_func_start sub_20B5594
sub_20B5594: // 0x020B5594
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20A0580
	mvn r1, #0
	cmp r0, r1
	ldmneia sp!, {r4, pc}
	mov r0, r4
	bl sub_20BE844
	cmp r0, #0
	moveq r0, #0
	ldrne r0, [r0, #0xc]
	ldrne r0, [r0, #0]
	ldrne r0, [r0, #0]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B5594

	arm_func_start sub_20B55CC
sub_20B55CC: // 0x020B55CC
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x1c
	ldr lr, _020B56E8 // =0x0211E8B4
	add r5, sp, #4
	ldrb r4, [lr]
	ldrb r3, [lr, #1]
	mov r2, #2
	mov r1, #7
	strb r4, [r5]
	strb r3, [r5, #1]
	ldrb ip, [lr, #2]
	ldrb r3, [lr, #3]
	mov r4, r0
	strb ip, [r5, #2]
	strb r3, [r5, #3]
	ldrb r3, [lr, #4]
	ldrb r0, [lr, #5]
	strb r3, [r5, #4]
	strb r0, [r5, #5]
	strb r2, [sp, #0xa]
	strb r1, [sp, #0xb]
	ldr r3, [r4, #8]
	mov r1, r3, lsr #0x18
	mov r0, r3, lsr #8
	mov r2, r3, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	mov r3, r3, lsl #0x18
	orr r0, r1, r0
	and r2, r2, #0xff0000
	and r1, r3, #0xff000000
	orr r0, r2, r0
	orr r0, r1, r0
	str r0, [sp, #0xc]
	ldr r0, [r4, #0x2c]
	add r3, sp, #4
	str r0, [sp, #0x10]
	ldrh r0, [r4, #0x30]
	mov r1, r0, asr #8
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	strh r0, [sp, #0x14]
	ldrb r0, [r4, #0x32]
	mvn r1, #0
	strb r0, [sp, #0x16]
	ldr r0, [r4, #0x10]
	cmp r0, #2
	movne r0, #1
	moveq r0, #0
	strb r0, [sp, #0x17]
	ldr r0, [r4, #4]
	cmp r0, r1
	ldreq r0, [r4, #0]
	mov r1, #0x14
	str r1, [sp]
	ldrh r2, [r4, #0x30]
	ldr r1, [r4, #0x2c]
	bl sub_20B59E0
	bl sub_20A0CA4
	add r0, r0, #0x2bc
	str r0, [r4, #0x28]
	mov r0, #0xc
	str r0, [r4, #0x24]
	ldrb r0, [r4, #0x32]
	cmp r0, #0
	movne r0, #1
	strneb r0, [r4, #0x33]
	add sp, sp, #0x1c
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B56E8: .word 0x0211E8B4
	arm_func_end sub_20B55CC

	arm_func_start sub_20B56EC
sub_20B56EC: // 0x020B56EC
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x60
	ldr r7, _020B5924 // =0x0211E8B4
	mov r6, r0
	ldrb r4, [r7, #0]
	ldrb r3, [r7, #1]
	add r5, sp, #4
	mov r2, #2
	strb r4, [r5]
	strb r3, [r5, #1]
	ldrb r4, [r7, #2]
	ldrb r3, [r7, #3]
	mov r1, #0
	mvn r0, #0
	strb r4, [r5, #2]
	strb r3, [r5, #3]
	ldrb r4, [r7, #4]
	ldrb r3, [r7, #5]
	strb r4, [r5, #4]
	strb r3, [r5, #5]
	strb r2, [r5, #6]
	strb r1, [r5, #7]
	ldr r2, [r6, #0xc]
	strb r2, [r5, #0xd]
	ldr r7, [r6, #8]
	mov r3, r7, lsr #0x18
	mov r2, r7, lsr #8
	mov r4, r7, lsl #8
	and r3, r3, #0xff
	and r2, r2, #0xff00
	mov r7, r7, lsl #0x18
	orr r2, r3, r2
	and r4, r4, #0xff0000
	and r3, r7, #0xff000000
	orr r2, r4, r2
	orr r2, r3, r2
	str r2, [r5, #8]
	ldr r2, [r6, #4]
	cmp r2, r0
	movne r1, #1
	strb r1, [r5, #0xe]
	bl sub_20B596C
	mov r7, r0
	bl sub_20B596C
	mov r8, r0
	bl sub_20B596C
	mov r4, r0
	bl sub_20B596C
	mov r2, #0
	mov r1, r7, lsl #0x18
	and r7, r1, #0xff000000
	mov r1, r8, lsl #8
	mov r0, r0, lsr #8
	and r3, r1, #0xff0000
	mov r1, r4, lsr #0x18
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	orr r0, r3, r0
	orr r3, r7, r0
	mov r1, r3, lsr #0x18
	strb r1, [sp, #0x13]
	mov r1, r3, lsr #8
	mov r0, r3, lsr #0x10
	strb r1, [sp, #0x15]
	strb r0, [sp, #0x14]
	ldr r1, _020B5928 // =0x02144D64
	add r0, sp, #0x19
	strb r3, [sp, #0x16]
	strb r2, [sp, #0x17]
	strb r2, [sp, #0x18]
	bl strcpy
	ldr r0, _020B5928 // =0x02144D64
	bl strlen
	ldrb r1, [r5, #0xe]
	add r4, r0, #0x16
	cmp r1, #0
	beq _020B5854
	ldr r0, [r6, #0x14]
	cmp r0, #0
	bne _020B5854
	mov r0, #0
	strb r0, [r5, #0xc]
	str r4, [sp]
	ldr r1, _020B592C // =0x021452C4
	ldr r0, [r6, #4]
	ldr r1, [r1, #0]
	ldr r2, _020B5930 // =0x00006CFD
	mov r3, r5
	bl sub_20B59E0
_020B5854:
	ldr r0, [r6, #0x18]
	cmp r0, #0
	bne _020B5884
	mov r0, #1
	strb r0, [r5, #0xc]
	str r4, [sp]
	ldr r1, _020B592C // =0x021452C4
	ldr r0, [r6, #0]
	ldr r1, [r1, #0]
	ldr r2, _020B5930 // =0x00006CFD
	mov r3, r5
	bl sub_20B59E0
_020B5884:
	ldrb r0, [r5, #0xe]
	cmp r0, #0
	ldrne r8, [r6, #4]
	ldreq r8, [r6, #0]
	cmp r0, #0
	ldrne r0, [r6, #4]
	ldreq r0, [r6, #0]
	bl sub_20B5938
	mov r7, r0
	mov r0, r8
	bl sub_20B5938
	mov r1, r7, asr #8
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
	mov r0, r1, asr #8
	strb r1, [sp, #0x18]
	strb r0, [sp, #0x17]
	ldr r0, [r6, #0x1c]
	cmp r0, #0
	bne _020B5908
	mov r0, #2
	strb r0, [r5, #0xc]
	str r4, [sp]
	ldr r1, _020B5934 // =0x021452C0
	ldr r0, [r6, #0]
	ldr r1, [r1, #0]
	ldr r2, _020B5930 // =0x00006CFD
	mov r3, r5
	bl sub_20B59E0
_020B5908:
	bl sub_20A0CA4
	add r0, r0, #0x1f4
	str r0, [r6, #0x28]
	mov r0, #0x1e
	str r0, [r6, #0x24]
	add sp, sp, #0x60
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020B5924: .word 0x0211E8B4
_020B5928: .word 0x02144D64
_020B592C: .word 0x021452C4
_020B5930: .word 0x00006CFD
_020B5934: .word 0x021452C0
	arm_func_end sub_20B56EC

	arm_func_start sub_20B5938
sub_20B5938: // 0x020B5938
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	mov r3, #8
	add r1, sp, #0
	add r2, sp, #8
	str r3, [sp, #8]
	bl sub_20A05A4
	mvn r1, #0
	cmp r0, r1
	moveq r0, #0
	ldrneh r0, [sp, #2]
	add sp, sp, #0xc
	ldmia sp!, {pc}
	arm_func_end sub_20B5938

	arm_func_start sub_20B596C
sub_20B596C: // 0x020B596C
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, #0
	bl sub_20A08B8
	movs r6, r0
	addeq sp, sp, #4
	moveq r0, r5
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r4, _020B59DC // =0x0100007F
	mov r7, r5
_020B5994:
	ldr r0, [r6, #0xc]
	ldr r0, [r0, r7, lsl #2]
	cmp r0, #0
	beq _020B59D0
	ldr r1, [r0, #0]
	cmp r1, r4
	beq _020B59C8
	mov r5, r1
	bl sub_20A0834
	cmp r0, #0
	addne sp, sp, #4
	movne r0, r5
	ldmneia sp!, {r4, r5, r6, r7, pc}
_020B59C8:
	add r7, r7, #1
	b _020B5994
_020B59D0:
	mov r0, r5
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B59DC: .word 0x0100007F
	arm_func_end sub_20B596C

	arm_func_start sub_20B59E0
sub_20B59E0: // 0x020B59E0
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	mov ip, r2, asr #8
	mov r2, r2, lsl #8
	str r1, [sp, #0xc]
	mov r1, r3
	and r3, ip, #0xff
	and r2, r2, #0xff00
	orr r2, r3, r2
	mov lr, #2
	strh r2, [sp, #0xa]
	add r3, sp, #8
	strb lr, [sp, #9]
	str r3, [sp]
	mov ip, #8
	ldr r2, [sp, #0x18]
	mov r3, #0
	str ip, [sp, #4]
	bl sub_20A061C
	add sp, sp, #0x14
	ldmia sp!, {pc}
	arm_func_end sub_20B59E0

	arm_func_start sub_20B5A34
sub_20B5A34: // 0x020B5A34
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r1, _020B5A5C // =0x0211E8B4
	mov r2, #6
	bl memcmp
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020B5A5C: .word 0x0211E8B4
	arm_func_end sub_20B5A34

	arm_func_start NNFreeNegotiateList
NNFreeNegotiateList: // 0x020B5A60
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020B5A94 // =0x021452C8
	ldr r0, [r0, #0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl ArrayFree
	ldr r0, _020B5A94 // =0x021452C8
	mov r1, #0
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020B5A94: .word 0x021452C8
	arm_func_end NNFreeNegotiateList

	arm_func_start sub_20B5A98
sub_20B5A98: // 0x020B5A98
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _020B5AFC // =0x021452C8
	mov r6, r0
	ldr r0, [r1, #0]
	mov r5, #0
	bl ArrayLength
	cmp r0, #0
	ldmleia sp!, {r4, r5, r6, pc}
	ldr r4, _020B5AFC // =0x021452C8
_020B5ABC:
	ldr r0, [r4, #0]
	mov r1, r5
	bl ArrayNth
	cmp r6, r0
	bne _020B5AE4
	ldr r0, _020B5AFC // =0x021452C8
	mov r1, r5
	ldr r0, [r0, #0]
	bl sub_209F828
	ldmia sp!, {r4, r5, r6, pc}
_020B5AE4:
	ldr r0, [r4, #0]
	add r5, r5, #1
	bl ArrayLength
	cmp r5, r0
	blt _020B5ABC
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B5AFC: .word 0x021452C8
	arm_func_end sub_20B5A98

	arm_func_start sub_20B5B00
sub_20B5B00: // 0x020B5B00
	stmdb sp!, {lr}
	sub sp, sp, #0x44
	mov r0, #0
	add r2, sp, #0
	mov r1, r0
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2!, {r0, r1}
	stmia r2, {r0, r1}
	ldr r0, _020B5B90 // =0x021452C8
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _020B5B5C
	ldr r2, _020B5B94 // =sub_20B5B98
	mov r0, #0x40
	mov r1, #4
	bl sub_209FB2C
	ldr r1, _020B5B90 // =0x021452C8
	str r0, [r1]
_020B5B5C:
	ldr r0, _020B5B90 // =0x021452C8
	add r1, sp, #0
	ldr r0, [r0, #0]
	bl ArrayAppend
	ldr r0, _020B5B90 // =0x021452C8
	ldr r0, [r0, #0]
	bl ArrayLength
	ldr r2, _020B5B90 // =0x021452C8
	sub r1, r0, #1
	ldr r0, [r2, #0]
	bl ArrayNth
	add sp, sp, #0x44
	ldmia sp!, {pc}
	.align 2, 0
_020B5B90: .word 0x021452C8
_020B5B94: .word sub_20B5B98
	arm_func_end sub_20B5B00

	arm_func_start sub_20B5B98
sub_20B5B98: // 0x020B5B98
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0]
	mvn r1, #0
	cmp r0, r1
	beq _020B5BB4
	bl sub_20A07E4
_020B5BB4:
	mvn r0, #0
	str r0, [r4]
	mov r0, #4
	str r0, [r4, #0x10]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B5B98

	arm_func_start sub_20B5BC8
sub_20B5BC8: // 0x020B5BC8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r1, _020B5C2C // =0x021452C8
	mov r6, r0
	ldr r0, [r1, #0]
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r5, #0
	bl ArrayLength
	cmp r0, #0
	ble _020B5C24
	ldr r4, _020B5C2C // =0x021452C8
_020B5BF8:
	ldr r0, [r4, #0]
	mov r1, r5
	bl ArrayNth
	ldr r1, [r0, #8]
	cmp r1, r6
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, [r4, #0]
	add r5, r5, #1
	bl ArrayLength
	cmp r5, r0
	blt _020B5BF8
_020B5C24:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B5C2C: .word 0x021452C8
	arm_func_end sub_20B5BC8

	arm_func_start sub_20B5C30
sub_20B5C30: // 0x020B5C30
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr ip, _020B5E14 // =0x0000082C
	sub sp, sp, ip
	mov r10, r0
	mov r9, r1
	mov r3, #0
	add r0, sp, #0x24
	add r2, r10, #0x84
	mov r1, #3
	str r3, [sp, #0x824]
	bl sub_20B6AC0
	ldr r4, _020B5E18 // =0x021454CC
	mov r8, #0
	ldr r0, [r4, #0]
	cmp r0, #0
	ble _020B5CC4
	ldr r11, _020B5E1C // =aLocalipD
	ldr r5, _020B5E20 // =0x021454D0
	add r7, sp, #0x10
	add r6, sp, #0x24
_020B5C80:
	mov r0, r7
	mov r1, r11
	mov r2, r8
	bl sprintf
	mov r0, r6
	mov r1, r7
	bl qr2_buffer_addA
	add r0, r5, r8, lsl #2
	ldmia r0, {r0}
	bl sub_20BE3D4
	mov r1, r0
	mov r0, r6
	bl qr2_buffer_addA
	add r8, r8, #1
	ldr r0, [r4, #0]
	cmp r8, r0
	blt _020B5C80
_020B5CC4:
	ldr r1, _020B5E24 // =aLocalport
	add r0, sp, #0x24
	bl qr2_buffer_addA
	ldr r1, [r10, #0xc0]
	add r0, sp, #0x24
	bl qr2_buffer_add_int
	ldr r1, _020B5E28 // =aNatneg
	add r0, sp, #0x24
	bl qr2_buffer_addA
	ldr r0, [r10, #0xc8]
	cmp r0, #0
	ldrne r1, _020B5E2C // =0x0211EA30
	add r0, sp, #0x24
	ldreq r1, _020B5E30 // =0x0211EA34
	bl qr2_buffer_addA
	cmp r9, #0
	beq _020B5D20
	ldr r1, _020B5E34 // =aStatechanged
	add r0, sp, #0x24
	bl qr2_buffer_addA
	add r0, sp, #0x24
	mov r1, r9
	bl qr2_buffer_add_int
_020B5D20:
	ldr r1, _020B5E38 // =aGamename_1
	add r0, sp, #0x24
	bl qr2_buffer_addA
	add r0, sp, #0x24
	add r1, r10, #4
	bl qr2_buffer_addA
	ldr r0, [r10, #0xa8]
	cmp r0, #0
	beq _020B5D78
	ldr r1, _020B5E3C // =aPublicip
	add r0, sp, #0x24
	bl qr2_buffer_addA
	ldr r1, [r10, #0x104]
	add r0, sp, #0x24
	bl qr2_buffer_add_int
	ldr r1, _020B5E40 // =aPublicport
	add r0, sp, #0x24
	bl qr2_buffer_addA
	add r0, r10, #0x100
	ldrh r1, [r0, #8]
	add r0, sp, #0x24
	bl qr2_buffer_add_int
_020B5D78:
	cmp r9, #2
	beq _020B5DA8
	mov r2, #0xff
	str r2, [sp]
	mov r3, #0
	str r3, [sp, #4]
	str r2, [sp, #8]
	add r1, sp, #0x24
	mov r0, r10
	str r3, [sp, #0xc]
	bl sub_20B66A8
	b _020B5DC8
_020B5DA8:
	ldr r2, [sp, #0x824]
	rsb r0, r2, #0x800
	cmp r0, #1
	addge r1, r2, #1
	strge r1, [sp, #0x824]
	addge r0, sp, #0x24
	movge r1, #0
	strgeb r1, [r0, r2]
_020B5DC8:
	add r0, r10, #0xcc
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	ldr r0, [r10, #0]
	ldr r2, [sp, #0x824]
	add r1, sp, #0x24
	mov r3, #0
	bl sub_20A061C
	bl sub_20A0CA4
	str r0, [r10, #0xac]
	ldr r0, [r10, #0xac]
	cmp r9, #0
	str r0, [r10, #0xb0]
	movne r0, #0
	strne r0, [r10, #0xb4]
	ldr ip, _020B5E14 // =0x0000082C
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B5E14: .word 0x0000082C
_020B5E18: .word 0x021454CC
_020B5E1C: .word aLocalipD
_020B5E20: .word 0x021454D0
_020B5E24: .word aLocalport
_020B5E28: .word aNatneg
_020B5E2C: .word 0x0211EA30
_020B5E30: .word 0x0211EA34
_020B5E34: .word aStatechanged
_020B5E38: .word aGamename_1
_020B5E3C: .word aPublicip
_020B5E40: .word aPublicport
	arm_func_end sub_20B5C30

	arm_func_start sub_20B5E44
sub_20B5E44: // 0x020B5E44
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x810
	mov r4, r0
	mov r3, #0
	add r0, sp, #8
	add r2, r4, #0x84
	mov r1, #8
	str r3, [sp, #0x808]
	bl sub_20B6AC0
	add r0, r4, #0xcc
	str r0, [sp]
	mov r0, #8
	str r0, [sp, #4]
	ldr r0, [r4, #0]
	ldr r2, [sp, #0x808]
	add r1, sp, #8
	mov r3, #0
	bl sub_20A061C
	bl sub_20A0CA4
	str r0, [r4, #0xb0]
	add sp, sp, #0x810
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B5E44

	arm_func_start sub_20B5E9C
sub_20B5E9C: // 0x020B5E9C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	ldr ip, _020B61F8 // =0x00000814
	sub sp, sp, ip
	movs r8, r0
	mov r0, #0
	str r0, [sp, #0x80c]
	ldreq r0, _020B61FC // =0x0211E8FC
	mov r7, r2
	ldreq r8, [r0, #0]
	ldrsb r0, [r1, #0]
	mov r6, r3
	cmp r0, #0x3b
	bne _020B5F00
	ldr r3, [r8, #0xd4]
	cmp r3, #0
	ldreq ip, _020B61F8 // =0x00000814
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r0, r1
	mov r1, r7
	mov r2, r6
	blx r3
	ldr ip, _020B61F8 // =0x00000814
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B5F00:
	cmp r0, #0x5c
	bne _020B5F40
	add r1, sp, #0xc
	mov r0, r8
	bl sub_20B639C
	str r6, [sp]
	mov r0, #8
	str r0, [sp, #4]
	ldr r0, [r8, #0]
	ldr r2, [sp, #0x80c]
	add r1, sp, #0xc
	mov r3, #0
	bl sub_20A061C
	ldr ip, _020B61F8 // =0x00000814
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B5F40:
	cmp r7, #7
	ldrlt ip, _020B61F8 // =0x00000814
	addlt sp, sp, ip
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, pc}
	and r0, r0, #0xff
	cmp r0, #0xfe
	ldrne ip, _020B61F8 // =0x00000814
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldrb r0, [r1, #1]
	cmp r0, #0xfd
	ldrne ip, _020B61F8 // =0x00000814
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r0, [r8, #0xb8]
	add r5, r1, #3
	cmp r0, #0
	movgt r0, #0
	strgt r0, [r8, #0xb8]
	ldrsb r9, [r1, #2]
	add r4, r1, #7
	add r0, sp, #0xc
	mov r1, r9
	mov r2, r5
	sub r7, r7, #7
	bl sub_20B6AC0
	cmp r9, #8
	addls pc, pc, r9, lsl #2
	b _020B61C0
_020B5FB4: // jump table
	b _020B5FD8 // case 0
	b _020B5FF0 // case 1
	b _020B602C // case 2
	b _020B61C0 // case 3
	b _020B6064 // case 4
	b _020B61C0 // case 5
	b _020B60EC // case 6
	b _020B61C0 // case 7
	b _020B61C0 // case 8
_020B5FD8:
	add r1, sp, #0xc
	mov r0, r8
	mov r2, r4
	mov r3, r7
	bl sub_20B65E4
	b _020B61CC
_020B5FF0:
	cmp r7, #0xd
	blt _020B6014
	ldr r0, [r8, #0xa8]
	cmp r0, #0
	beq _020B6014
	add r1, r4, r7
	mov r0, r8
	sub r1, r1, #0xd
	bl sub_20B6964
_020B6014:
	add r1, sp, #0xc
	mov r0, r8
	mov r2, r4
	mov r3, r7
	bl sub_20B6A20
	b _020B61CC
_020B602C:
	ldr r0, [sp, #0x80c]
	cmp r7, #0x20
	movgt r7, #0x20
	add r3, sp, #0xc
	mov r5, #5
	mov r1, r4
	mov r2, r7
	add r0, r3, r0
	strb r5, [sp, #0xc]
	bl memcpy
	ldr r0, [sp, #0x80c]
	add r0, r0, r7
	str r0, [sp, #0x80c]
	b _020B61CC
_020B6064:
	ldr r1, [r8, #0xb8]
	mvn r0, #0
	cmp r1, r0
	ldreq ip, _020B61F8 // =0x00000814
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r0, #0
	str r0, [sp, #8]
_020B6084:
	ldr r2, [sp, #8]
	add r0, r8, r2
	ldrsb r1, [r5, r2]
	ldrsb r0, [r0, #0x84]
	cmp r1, r0
	ldrne ip, _020B61F8 // =0x00000814
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r0, r2, #1
	str r0, [sp, #8]
	cmp r0, #4
	blt _020B6084
	cmp r7, #2
	ldrlt ip, _020B61F8 // =0x00000814
	addlt sp, sp, ip
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mvn r0, #0
	str r0, [r8, #0xb8]
	ldrsb r0, [r4, #0]
	ldr r2, [r8, #0x10c]
	ldr r3, [r8, #0x9c]
	add r1, r4, #1
	blx r3
	ldr ip, _020B61F8 // =0x00000814
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B60EC:
	mov r0, #0
	str r0, [sp, #8]
_020B60F4:
	ldr r2, [sp, #8]
	add r0, r8, r2
	ldrsb r1, [r5, r2]
	ldrsb r0, [r0, #0x84]
	cmp r1, r0
	ldrne ip, _020B61F8 // =0x00000814
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r0, r2, #1
	str r0, [sp, #8]
	cmp r0, #4
	blt _020B60F4
	cmp r7, #4
	ldrlt ip, _020B61F8 // =0x00000814
	addlt sp, sp, ip
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, pc}
	mov r0, #7
	strb r0, [sp, #0xc]
	ldrb r1, [r4, #0]
	ldrb r0, [r4, #1]
	ldr r2, [sp, #0x80c]
	add r5, sp, #0xc
	strb r1, [r5, r2]
	add r5, r5, r2
	strb r0, [r5, #1]
	ldrb r2, [r4, #2]
	ldrb r1, [r4, #3]
	add r3, sp, #8
	mov r0, r8
	strb r2, [r5, #2]
	strb r1, [r5, #3]
	ldr r1, [sp, #0x80c]
	add r1, r1, #4
	str r1, [sp, #0x80c]
	ldrb r2, [r4, #0]
	ldrb r1, [r4, #1]
	strb r2, [r3]
	strb r1, [r3, #1]
	ldrb r2, [r4, #2]
	ldrb r1, [r4, #3]
	strb r2, [r3, #2]
	strb r1, [r3, #3]
	ldr r1, [sp, #8]
	bl sub_20B6200
	cmp r0, #0
	bne _020B61CC
	mov r0, r8
	add r1, r4, #4
	sub r2, r7, #4
	bl sub_20B6270
	b _020B61CC
_020B61C0:
	ldr ip, _020B61F8 // =0x00000814
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B61CC:
	str r6, [sp]
	mov r0, #8
	str r0, [sp, #4]
	ldr r0, [r8, #0]
	ldr r2, [sp, #0x80c]
	add r1, sp, #0xc
	mov r3, #0
	bl sub_20A061C
	ldr ip, _020B61F8 // =0x00000814
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020B61F8: .word 0x00000814
_020B61FC: .word 0x0211E8FC
	arm_func_end sub_20B5E9C

	arm_func_start sub_20B6200
sub_20B6200: // 0x020B6200
	stmdb sp!, {r4, lr}
	mov r3, #0
_020B6208:
	add r2, r0, r3, lsl #2
	ldr r2, [r2, #0xd8]
	cmp r1, r2
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
	add r3, r3, #1
	cmp r3, #0xa
	blt _020B6208
	ldr r2, [r0, #0x100]
	ldr r3, _020B6268 // =0x66666667
	add lr, r2, #1
	smull r2, r4, r3, lr
	mov r4, r4, asr #2
	mov r2, lr, lsr #0x1f
	ldr ip, _020B626C // =0x0000000A
	add r4, r2, r4
	smull r2, r3, ip, r4
	sub r4, lr, r2
	str r4, [r0, #0x100]
	ldr r2, [r0, #0x100]
	add r0, r0, r2, lsl #2
	str r1, [r0, #0xd8]
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B6268: .word 0x66666667
_020B626C: .word 0x0000000A
	arm_func_end sub_20B6200

	arm_func_start sub_20B6270
sub_20B6270: // 0x020B6270
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0xc
	ldr ip, _020B6398 // =0x0211278C
	mov r3, r0
	ldrb r7, [ip]
	ldrb r6, [ip, #1]
	ldrb r5, [ip, #2]
	ldrb r4, [ip, #3]
	ldrb lr, [ip, #4]
	ldrb r0, [ip, #5]
	strb r5, [sp, #2]
	strb r4, [sp, #3]
	strb r7, [sp]
	strb r6, [sp, #1]
	strb lr, [sp, #4]
	strb r0, [sp, #5]
	cmp r2, #0xa
	add r4, sp, #0
	mov r5, #1
	blt _020B62EC
	mov r6, #0
_020B62C4:
	ldrb ip, [r4]
	ldrb r0, [r1, r6]
	cmp ip, r0
	movne r5, #0
	bne _020B62F0
	add r6, r6, #1
	cmp r6, #6
	add r4, r4, #1
	blt _020B62C4
	b _020B62F0
_020B62EC:
	mov r5, #0
_020B62F0:
	cmp r5, #0
	beq _020B6370
	add r2, r1, #6
	ldrb r1, [r1, #6]
	ldrb r0, [r2, #1]
	add ip, sp, #8
	strb r1, [ip]
	strb r0, [ip, #1]
	ldrb r1, [r2, #2]
	ldrb r0, [r2, #3]
	strb r1, [ip, #2]
	strb r0, [ip, #3]
	ldr r2, [r3, #0xa0]
	cmp r2, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr lr, [sp, #8]
	ldr r1, [r3, #0x10c]
	mov r3, lr, lsr #0x18
	mov r0, lr, lsr #8
	mov ip, lr, lsl #8
	and r3, r3, #0xff
	and r0, r0, #0xff00
	mov lr, lr, lsl #0x18
	orr r0, r3, r0
	and ip, ip, #0xff0000
	and r3, lr, #0xff000000
	orr r0, ip, r0
	orr r0, r3, r0
	blx r2
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
_020B6370:
	ldr ip, [r3, #0xa4]
	cmp ip, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, r1
	mov r1, r2
	ldr r2, [r3, #0x10c]
	blx ip
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B6398: .word 0x0211278C
	arm_func_end sub_20B6270

	arm_func_start sub_20B639C
sub_20B639C: // 0x020B639C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r2, #1
	mov r5, r0
	str r2, [r4, #0x800]
	mov r3, #0x5c
	mov r2, #0
	strb r3, [r4]
	bl sub_20B6408
	mov r0, r5
	mov r1, r4
	mov r2, #1
	bl sub_20B6408
	mov r0, r5
	mov r1, r4
	mov r2, #2
	bl sub_20B6408
	ldr r1, _020B6404 // =aFinalQueryid11
	mov r0, r4
	bl qr2_buffer_addA
	ldr r0, [r4, #0x800]
	sub r0, r0, #1
	str r0, [r4, #0x800]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B6404: .word aFinalQueryid11
	arm_func_end sub_20B639C

	arm_func_start sub_20B6408
sub_20B6408: // 0x020B6408
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x194
	mov r8, r2
	sub r2, r8, #1
	mov r3, #0
	mov r10, r0
	cmp r2, #1
	movhi r0, #1
	mov r9, r1
	str r3, [sp, #0x18c]
	strhi r0, [sp]
	bhi _020B644C
	ldr r1, [r10, #0x10c]
	ldr r2, [r10, #0x98]
	mov r0, r8
	blx r2
	str r0, [sp]
_020B644C:
	ldr r2, [r10, #0x10c]
	ldr r3, [r10, #0x94]
	add r1, sp, #0x8c
	mov r0, r8
	blx r3
	ldr r1, [sp, #0x18c]
	mov r0, #0
	str r0, [sp, #4]
	cmp r1, #0
	addle sp, sp, #0x194
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r6, sp, #0x8c
	str r0, [sp, #8]
	mov r4, #0x5c
_020B6484:
	ldrb r1, [r6, #0]
	ldr r0, _020B65D4 // =0x0211EC44
	ldr r11, [r0, r1, lsl #2]
	cmp r11, #0
	ldreq r11, _020B65D8 // =aUnknown
	cmp r8, #0
	bne _020B64F8
	mov r1, r11
	mov r0, r9
	bl qr2_buffer_addA
	ldr r0, [r9, #0x800]
	mov r1, r9
	sub r0, r0, #1
	strb r4, [r9, r0]
	ldr r5, [r9, #0x800]
	ldrb r0, [r6, #0]
	ldr r2, [r10, #0x10c]
	ldr r3, [r10, #0x88]
	blx r3
	ldr r0, [r9, #0x800]
	cmp r5, r0
	bne _020B64E8
	ldr r1, _020B65DC // =_0211EA88
	mov r0, r9
	bl qr2_buffer_addA
_020B64E8:
	ldr r0, [r9, #0x800]
	sub r0, r0, #1
	strb r4, [r9, r0]
	b _020B65B0
_020B64F8:
	ldr r0, [sp]
	ldr r7, [sp, #8]
	cmp r0, #0
	ble _020B65B0
_020B6508:
	ldr r1, _020B65E0 // =0x0211EA8C
	add r0, sp, #0xc
	mov r2, r11
	mov r3, r7
	bl sprintf
	mov r0, r9
	add r1, sp, #0xc
	bl qr2_buffer_addA
	ldr r0, [r9, #0x800]
	cmp r8, #1
	sub r0, r0, #1
	strb r4, [r9, r0]
	ldr r5, [r9, #0x800]
	bne _020B655C
	ldrb r0, [r6, #0]
	mov r1, r7
	mov r2, r9
	ldr r3, [r10, #0x10c]
	ldr ip, [r10, #0x8c]
	blx ip
	b _020B657C
_020B655C:
	cmp r8, #2
	bne _020B657C
	ldrb r0, [r6, #0]
	mov r1, r7
	mov r2, r9
	ldr r3, [r10, #0x10c]
	ldr ip, [r10, #0x90]
	blx ip
_020B657C:
	ldr r0, [r9, #0x800]
	cmp r5, r0
	bne _020B6594
	ldr r1, _020B65DC // =_0211EA88
	mov r0, r9
	bl qr2_buffer_addA
_020B6594:
	ldr r0, [r9, #0x800]
	add r7, r7, #1
	sub r0, r0, #1
	strb r4, [r9, r0]
	ldr r0, [sp]
	cmp r7, r0
	blt _020B6508
_020B65B0:
	ldr r0, [sp, #4]
	ldr r1, [sp, #0x18c]
	add r0, r0, #1
	add r6, r6, #1
	str r0, [sp, #4]
	cmp r0, r1
	blt _020B6484
	add sp, sp, #0x194
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B65D4: .word 0x0211EC44
_020B65D8: .word aUnknown
_020B65DC: .word _0211EA88
_020B65E0: .word 0x0211EA8C
	arm_func_end sub_20B6408

	arm_func_start sub_20B65E4
sub_20B65E4: // 0x020B65E4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x14
	mov r4, #0
	cmp r3, #3
	addlt sp, sp, #0x14
	mov lr, r4
	mov ip, r4
	ldmltia sp!, {r4, r5, r6, r7, pc}
	ldrb r7, [r2], #1
	sub r3, r3, #1
	cmp r7, #0
	beq _020B6624
	cmp r7, #0xff
	movne r4, r2
	addne r2, r2, r7
	subne r3, r3, r7
_020B6624:
	cmp r3, #2
	addlt sp, sp, #0x14
	ldmltia sp!, {r4, r5, r6, r7, pc}
	ldrb r6, [r2], #1
	sub r3, r3, #1
	cmp r6, #0
	beq _020B6650
	cmp r6, #0xff
	movne lr, r2
	addne r2, r2, r6
	subne r3, r3, r6
_020B6650:
	cmp r3, #1
	addlt sp, sp, #0x14
	ldmltia sp!, {r4, r5, r6, r7, pc}
	ldrb r5, [r2, #0]
	sub r3, r3, #1
	cmp r5, #0
	beq _020B6678
	cmp r5, #0xff
	addne ip, r2, #1
	subne r3, r3, r5
_020B6678:
	cmp r3, #0
	addlt sp, sp, #0x14
	ldmltia sp!, {r4, r5, r6, r7, pc}
	str r6, [sp]
	str lr, [sp, #4]
	str r5, [sp, #8]
	mov r2, r7
	mov r3, r4
	str ip, [sp, #0xc]
	bl sub_20B66A8
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20B65E4

	arm_func_start sub_20B66A8
sub_20B66A8: // 0x020B66A8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	str r3, [sp]
	mov r3, r2
	mov r2, #0
	mov r5, r0
	mov r4, r1
	bl sub_20B6708
	ldr ip, [sp, #0x14]
	ldr r3, [sp, #0x10]
	mov r0, r5
	mov r1, r4
	mov r2, #1
	str ip, [sp]
	bl sub_20B6708
	ldr r0, [sp, #0x1c]
	ldr r3, [sp, #0x18]
	str r0, [sp]
	mov r0, r5
	mov r1, r4
	mov r2, #2
	bl sub_20B6708
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B66A8

	arm_func_start sub_20B6708
sub_20B6708: // 0x020B6708
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x114
	movs r11, r3
	mov r3, #0
	ldr r7, [sp, #0x138]
	str r3, [sp, #0x10c]
	mov r10, r0
	mov r9, r1
	mov r8, r2
	addeq sp, sp, #0x114
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	sub r0, r8, #1
	cmp r0, #1
	bhi _020B67B4
	ldr r0, [r9, #0x800]
	rsb r0, r0, #0x800
	cmp r0, #2
	addlo sp, sp, #0x114
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r10, #0x10c]
	ldr r2, [r10, #0x98]
	mov r0, r8
	blx r2
	str r0, [sp]
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r1, r0, asr #8
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	strh r0, [sp, #8]
	add r0, sp, #8
	ldrb r1, [r0, #0]
	ldr r2, [r9, #0x800]
	ldrb r0, [r0, #1]
	add r3, r9, r2
	strb r1, [r9, r2]
	strb r0, [r3, #1]
	ldr r0, [r9, #0x800]
	add r0, r0, #2
	str r0, [r9, #0x800]
	b _020B67BC
_020B67B4:
	mov r0, #1
	str r0, [sp]
_020B67BC:
	cmp r11, #0xff
	bne _020B6890
	ldr r2, [r10, #0x10c]
	ldr r3, [r10, #0x94]
	add r1, sp, #0xc
	mov r0, r8
	blx r3
	ldr r0, [sp, #0x10c]
	mov r7, #0
	cmp r0, #0
	ble _020B6858
	ldr r11, _020B6958 // =aUnknown
	ldr r4, _020B695C // =0x0211EC44
	add r5, sp, #0xc
_020B67F4:
	ldrb r0, [r5, #0]
	ldr r1, [r4, r0, lsl #2]
	mov r0, r9
	cmp r1, #0
	moveq r1, r11
	bl qr2_buffer_addA
	cmp r8, #0
	bne _020B6844
	ldrb r0, [r5, #0]
	ldr r2, [r10, #0x10c]
	ldr r3, [r10, #0x88]
	mov r1, r9
	ldr r6, [r9, #0x800]
	blx r3
	ldr r0, [r9, #0x800]
	cmp r6, r0
	bne _020B6844
	ldr r1, _020B6960 // =_0211EA88
	mov r0, r9
	bl qr2_buffer_addA
_020B6844:
	ldr r0, [sp, #0x10c]
	add r7, r7, #1
	cmp r7, r0
	add r5, r5, #1
	blt _020B67F4
_020B6858:
	ldr r1, [r9, #0x800]
	rsb r0, r1, #0x800
	cmp r0, #1
	addlt sp, sp, #0x114
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r1, #1
	str r0, [r9, #0x800]
	mov r0, #0
	strb r0, [r9, r1]
	ldr r11, [sp, #0x10c]
	cmp r8, #0
	add r7, sp, #0xc
	addeq sp, sp, #0x114
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020B6890:
	ldr r0, [sp]
	mov r6, #0
	cmp r0, #0
	addle sp, sp, #0x114
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	str r6, [sp, #4]
_020B68A8:
	ldr r5, [sp, #4]
	cmp r11, #0
	ble _020B6940
_020B68B4:
	cmp r8, #0
	ldr r4, [r9, #0x800]
	bne _020B68D8
	ldrb r0, [r7, r5]
	ldr r2, [r10, #0x10c]
	ldr r3, [r10, #0x88]
	mov r1, r9
	blx r3
	b _020B691C
_020B68D8:
	cmp r8, #1
	bne _020B68FC
	ldrb r0, [r7, r5]
	ldr r3, [r10, #0x10c]
	ldr ip, [r10, #0x8c]
	mov r1, r6
	mov r2, r9
	blx ip
	b _020B691C
_020B68FC:
	cmp r8, #2
	bne _020B691C
	ldrb r0, [r7, r5]
	ldr r3, [r10, #0x10c]
	ldr ip, [r10, #0x90]
	mov r1, r6
	mov r2, r9
	blx ip
_020B691C:
	ldr r0, [r9, #0x800]
	cmp r4, r0
	bne _020B6934
	ldr r1, _020B6960 // =_0211EA88
	mov r0, r9
	bl qr2_buffer_addA
_020B6934:
	add r5, r5, #1
	cmp r5, r11
	blt _020B68B4
_020B6940:
	ldr r0, [sp]
	add r6, r6, #1
	cmp r6, r0
	blt _020B68A8
	add sp, sp, #0x114
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B6958: .word aUnknown
_020B695C: .word 0x0211EC44
_020B6960: .word _0211EA88
	arm_func_end sub_20B6708

	arm_func_start sub_20B6964
sub_20B6964: // 0x020B6964
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r0, r1
	ldr r1, _020B6A1C // =a08x04x
	add r2, sp, #0
	add r3, sp, #4
	bl sscanf
	ldr r0, [sp]
	ldr lr, [sp, #4]
	mov r2, r0, lsr #0x18
	mov r1, r0, lsr #8
	mov r3, r0, lsl #8
	mov ip, r0, lsl #0x18
	and r2, r2, #0xff
	and r1, r1, #0xff00
	orr r1, r2, r1
	and r3, r3, #0xff0000
	and r2, ip, #0xff000000
	orr r1, r3, r1
	orrs r2, r2, r1
	mov r0, lr, lsl #0x10
	str r2, [sp]
	addeq sp, sp, #8
	mov r1, r0, lsr #0x10
	ldmeqia sp!, {r4, pc}
	cmp r1, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x104]
	cmp r0, r2
	bne _020B69F8
	add r0, r4, #0x100
	ldrh r0, [r0, #8]
	cmp r0, r1
	addeq sp, sp, #8
	ldmeqia sp!, {r4, pc}
_020B69F8:
	str r2, [r4, #0x104]
	add r0, r4, #0x100
	strh r1, [r0, #8]
	ldr r0, [sp]
	ldr r2, [r4, #0x10c]
	ldr r3, [r4, #0xa8]
	blx r3
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B6A1C: .word a08x04x
	arm_func_end sub_20B6964

	arm_func_start sub_20B6A20
sub_20B6A20: // 0x020B6A20
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x48
	mov r5, r3
	cmp r5, #1
	mov r6, r0
	mov r4, r1
	addlt sp, sp, #0x48
	ldmltia sp!, {r4, r5, r6, pc}
	cmp r5, #0x41
	addgt sp, sp, #0x48
	ldmgtia sp!, {r4, r5, r6, pc}
	sub r0, r5, #1
	ldrsb r0, [r2, r0]
	cmp r0, #0
	addne sp, sp, #0x48
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, sp, #0
	mov r1, r2
	bl strcpy
	add r0, r6, #0x44
	bl strlen
	mov r1, r0
	add r2, sp, #0
	add r0, r6, #0x44
	sub r3, r5, #1
	bl sub_20B6B00
	ldr r2, [r4, #0x800]
	sub r1, r5, #1
	add r0, sp, #0
	add r2, r4, r2
	bl sub_20B6C44
	ldr r0, [r4, #0x800]
	add r0, r4, r0
	bl strlen
	ldr r1, [r4, #0x800]
	add r0, r0, #1
	add r0, r1, r0
	str r0, [r4, #0x800]
	add sp, sp, #0x48
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B6A20

	arm_func_start sub_20B6AC0
sub_20B6AC0: // 0x020B6AC0
	stmdb sp!, {lr}
	sub sp, sp, #4
	strb r1, [r0]
	ldrb ip, [r2]
	ldrb r3, [r2, #1]
	add lr, r0, #1
	mov r1, #5
	strb ip, [r0, #1]
	strb r3, [lr, #1]
	ldrb r3, [r2, #2]
	ldrb r2, [r2, #3]
	strb r3, [lr, #2]
	strb r2, [lr, #3]
	str r1, [r0, #0x800]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20B6AC0

	arm_func_start sub_20B6B00
sub_20B6B00: // 0x020B6B00
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x104
	str r1, [sp]
	add r4, sp, #4
	mov r10, r0
	mov r9, r2
	mov r8, r3
	mov r1, #0
_020B6B20:
	add r0, r1, #1
	mov r0, r0, lsl #0x10
	strb r1, [r4], #1
	mov r1, r0, asr #0x10
	cmp r1, #0x100
	blt _020B6B20
	mov r7, #0
	add r5, sp, #4
	mov r6, r7
	mov r4, r7
	mov r11, r5
_020B6B4C:
	ldrb r3, [r5, #0]
	ldrb r2, [r10, r7]
	ldr r1, [sp]
	add r0, r7, #1
	add r2, r3, r2
	add r2, r6, r2
	mov r3, r2, lsr #0x1f
	rsb r2, r3, r2, lsl #24
	add r2, r3, r2, ror #24
	and r6, r2, #0xff
	bl _s32_div_f
	and r7, r1, #0xff
	mov r0, r5
	add r1, r11, r6
	bl sub_20B6D60
	add r0, r4, #1
	mov r0, r0, lsl #0x10
	mov r4, r0, asr #0x10
	cmp r4, #0x100
	add r5, r5, #1
	blt _020B6B4C
	mov r6, #0
	cmp r8, #0
	mov r5, r6
	mov r7, r6
	addle sp, sp, #0x104
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r4, sp, #4
_020B6BBC:
	ldrb r0, [r9, r7]
	add r0, r6, r0
	add r0, r0, #1
	mov r1, r0, lsr #0x1f
	rsb r0, r1, r0, lsl #24
	add r0, r1, r0, ror #24
	and r6, r0, #0xff
	ldrb r1, [r4, r6]
	add r0, r4, r6
	add r1, r1, r5
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #24
	add r1, r2, r1, ror #24
	and r5, r1, #0xff
	add r1, r4, r5
	bl sub_20B6D60
	ldrb r2, [r4, r6]
	ldrb r1, [r4, r5]
	add r3, r7, #1
	ldrb r0, [r9, r7]
	add r1, r2, r1
	mov r2, r1, lsr #0x1f
	rsb r1, r2, r1, lsl #24
	add r1, r2, r1, ror #24
	and r1, r1, #0xff
	ldrb r2, [r4, r1]
	mov r1, r3, lsl #0x10
	eor r0, r0, r2
	strb r0, [r9, r7]
	mov r7, r1, asr #0x10
	cmp r7, r8
	blt _020B6BBC
	add sp, sp, #0x104
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end sub_20B6B00

	arm_func_start sub_20B6C44
sub_20B6C44: // 0x020B6C44
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r9, r1
	mov r10, r0
	mov r8, r2
	cmp r9, #0
	mov r7, #0
	ble _020B6D04
	mov r4, r7
	str r7, [sp]
	mov r11, r7
_020B6C70:
	mov r2, r11
	add r1, sp, #4
_020B6C78:
	cmp r7, r9
	ldrltb r0, [r10], #1
	add r2, r2, #1
	add r7, r7, #1
	strltb r0, [r1]
	strgeb r4, [r1]
	cmp r2, #2
	add r1, r1, #1
	ble _020B6C78
	ldrb r5, [sp, #4]
	ldrb r3, [sp, #5]
	ldrb r2, [sp, #6]
	and r1, r5, #3
	and r0, r3, #0xf
	mov r5, r5, asr #2
	mov r1, r1, lsl #4
	strb r5, [sp, #7]
	add r3, r1, r3, asr #4
	mov r0, r0, lsl #2
	add r1, r0, r2, asr #6
	and r0, r2, #0x3f
	ldr r5, [sp]
	add r6, sp, #7
	strb r3, [sp, #8]
	strb r1, [sp, #9]
	strb r0, [sp, #0xa]
_020B6CE0:
	ldrb r0, [r6, #0]
	bl sub_20B6D14
	add r5, r5, #1
	cmp r5, #3
	strb r0, [r8], #1
	add r6, r6, #1
	ble _020B6CE0
	cmp r7, r9
	blt _020B6C70
_020B6D04:
	mov r0, #0
	strb r0, [r8]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end sub_20B6C44

	arm_func_start sub_20B6D14
sub_20B6D14: // 0x020B6D14
	cmp r0, #0x1a
	addlo r0, r0, #0x41
	andlo r0, r0, #0xff
	bxlo lr
	cmp r0, #0x34
	addlo r0, r0, #0x47
	andlo r0, r0, #0xff
	bxlo lr
	cmp r0, #0x3e
	sublo r0, r0, #4
	andlo r0, r0, #0xff
	bxlo lr
	cmp r0, #0x3e
	moveq r0, #0x2b
	bxeq lr
	cmp r0, #0x3f
	moveq r0, #0x2f
	movne r0, #0
	bx lr
	arm_func_end sub_20B6D14

	arm_func_start sub_20B6D60
sub_20B6D60: // 0x020B6D60
	ldrb r3, [r0, #0]
	ldrb r2, [r1, #0]
	strb r2, [r0]
	strb r3, [r1]
	bx lr
	arm_func_end sub_20B6D60

	arm_func_start sub_20B6D74
sub_20B6D74: // 0x020B6D74
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #0x10
	mov r4, r1, asr #8
	mov r1, r1, lsl #8
	mov r6, r2
	mov r5, #2
	and r2, r4, #0xff
	and r1, r1, #0xff00
	strb r5, [r6, #1]
	orr r1, r2, r1
	strh r1, [r6, #2]
	mov r4, #0
	movs r7, r0
	mov r5, r3
	streq r4, [r6, #4]
	beq _020B6DC4
	bl sub_20A0580
	str r0, [r6, #4]
_020B6DC4:
	ldr r1, [r6, #4]
	mvn r0, #0
	cmp r1, r0
	bne _020B6E10
	ldr r1, _020B6E24 // =a255255255255
	mov r0, r7
	bl strcmp
	cmp r0, #0
	beq _020B6E10
	mov r0, r7
	bl sub_20BE844
	movs r4, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #0xc]
	ldr r0, [r0, #0]
	ldr r0, [r0, #0]
	str r0, [r6, #4]
_020B6E10:
	cmp r5, #0
	strne r4, [r5]
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B6E24: .word a255255255255
	arm_func_end sub_20B6D74

	arm_func_start sub_20B6E28
sub_20B6E28: // 0x020B6E28
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	bl sub_20A08B8
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, _020B6EAC // =0x021454CC
	mov r2, #0
	str r2, [r1]
	ldr ip, _020B6EB0 // =0x021454D0
_020B6E50:
	ldr r3, [r1, #0]
	ldr r2, [r0, #0xc]
	mov r5, r3, lsl #2
	ldr r4, [r2, r3, lsl #2]
	cmp r4, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldrb r3, [r4, #0]
	ldrb r2, [r4, #1]
	add lr, ip, r5
	strb r3, [ip, r5]
	strb r2, [lr, #1]
	ldrb r3, [r4, #2]
	ldrb r2, [r4, #3]
	strb r3, [lr, #2]
	strb r2, [lr, #3]
	ldr r2, [r1, #0]
	add r2, r2, #1
	str r2, [r1]
	cmp r2, #5
	blt _020B6E50
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B6EAC: .word 0x021454CC
_020B6EB0: .word 0x021454D0
	arm_func_end sub_20B6E28

	arm_func_start qr2_buffer_addA
qr2_buffer_addA: // 0x020B6EB4
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r4, r0
	mov r0, r6
	bl strlen
	ldr r3, [r4, #0x800]
	add r5, r0, #1
	rsb r0, r3, #0x800
	cmp r5, r0
	movgt r5, r0
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r1, r6
	mov r2, r5
	add r0, r4, r3
	bl memcpy
	ldr r0, [r4, #0x800]
	mov r1, #0
	add r0, r0, r5
	str r0, [r4, #0x800]
	ldr r0, [r4, #0x800]
	sub r0, r0, #1
	strb r1, [r4, r0]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end qr2_buffer_addA

	arm_func_start qr2_buffer_add_int
qr2_buffer_add_int: // 0x020B6F14
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r2, r1
	mov r4, r0
	ldr r1, _020B6F44 // =_0211EAB0
	add r0, sp, #0
	bl sprintf
	add r1, sp, #0
	mov r0, r4
	bl qr2_buffer_addA
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B6F44: .word _0211EAB0
	arm_func_end qr2_buffer_add_int

	arm_func_start qr2_keybuffer_add
qr2_keybuffer_add: // 0x020B6F48
	ldr r3, [r0, #0x100]
	cmp r3, #0xfe
	bxge lr
	cmp r1, #1
	bxlt lr
	cmp r1, #0xfe
	bxgt lr
	add r2, r3, #1
	str r2, [r0, #0x100]
	strb r1, [r0, r3]
	bx lr
	arm_func_end qr2_keybuffer_add

	arm_func_start qr2_shutdown
qr2_shutdown: // 0x020B6F74
	stmdb sp!, {r4, lr}
	movs r4, r0
	ldreq r0, _020B6FF4 // =0x0211E8FC
	ldreq r4, [r0, #0]
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	beq _020B6F9C
	mov r0, r4
	mov r1, #2
	bl sub_20B5C30
_020B6F9C:
	ldr r0, [r4, #0]
	mvn r1, #0
	cmp r0, r1
	beq _020B6FBC
	ldr r1, [r4, #0xc4]
	cmp r1, #0
	beq _020B6FBC
	bl sub_20A07E4
_020B6FBC:
	mvn r0, #0
	str r0, [r4]
	mov r0, #0
	str r0, [r4, #0xac]
	ldr r0, [r4, #0xc4]
	cmp r0, #0
	beq _020B6FDC
	bl sub_20A0C90
_020B6FDC:
	ldr r0, _020B6FF8 // =0x0211E900
	cmp r4, r0
	ldmeqia sp!, {r4, pc}
	mov r0, r4
	bl DWCi_GsFree
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B6FF4: .word 0x0211E8FC
_020B6FF8: .word 0x0211E900
	arm_func_end qr2_shutdown

	arm_func_start qr2_send_statechanged
qr2_send_statechanged: // 0x020B6FFC
	stmdb sp!, {r4, lr}
	movs r4, r0
	ldreq r0, _020B7050 // =0x0211E8FC
	ldreq r4, [r0, #0]
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	bl sub_20A0CA4
	ldr r2, [r4, #0xac]
	ldr r1, _020B7054 // =0x00002710
	sub r0, r0, r2
	cmp r0, r1
	movlo r0, #1
	strlo r0, [r4, #0xb4]
	ldmloia sp!, {r4, pc}
	mov r0, r4
	mov r1, #1
	bl sub_20B5C30
	mov r0, #0
	str r0, [r4, #0xb4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B7050: .word 0x0211E8FC
_020B7054: .word 0x00002710
	arm_func_end qr2_send_statechanged

	arm_func_start sub_20B7058
sub_20B7058: // 0x020B7058
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	bl sub_20A0CA4
	ldr r2, [r5, #0]
	mvn r1, #0
	cmp r2, r1
	mov r4, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r2, [r5, #0xb8]
	cmp r2, #0
	ble _020B70E8
	ldr r1, [r5, #0xac]
	ldr r0, _020B7170 // =0x00002710
	sub r1, r4, r1
	cmp r1, r0
	bls _020B70E8
	cmp r2, #4
	blt _020B70CC
	mov r0, #0
	str r0, [r5, #0xb8]
	ldr r2, [r5, #0x10c]
	ldr r3, [r5, #0x9c]
	ldr r1, _020B7174 // =aNoChallengeVal
	mov r0, #5
	blx r3
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
_020B70CC:
	mov r0, r5
	mov r1, #3
	bl sub_20B5C30
	ldr r0, [r5, #0xb8]
	add r0, r0, #1
	str r0, [r5, #0xb8]
	b _020B7148
_020B70E8:
	ldr r0, [r5, #0xb4]
	cmp r0, #0
	beq _020B7118
	ldr r1, [r5, #0xac]
	ldr r0, _020B7170 // =0x00002710
	sub r1, r4, r1
	cmp r1, r0
	bls _020B7118
	mov r0, r5
	mov r1, #1
	bl sub_20B5C30
	b _020B7148
_020B7118:
	ldr r2, [r5, #0xac]
	ldr r0, _020B7178 // =0x0000EA60
	sub r1, r4, r2
	cmp r1, r0
	bhi _020B713C
	cmp r2, #0
	beq _020B713C
	cmp r4, r2
	bhs _020B7148
_020B713C:
	mov r0, r5
	mov r1, #0
	bl sub_20B5C30
_020B7148:
	ldr r1, [r5, #0xb0]
	ldr r0, _020B717C // =0x00004E20
	sub r1, r4, r1
	cmp r1, r0
	addls sp, sp, #4
	ldmlsia sp!, {r4, r5, pc}
	mov r0, r5
	bl sub_20B5E44
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B7170: .word 0x00002710
_020B7174: .word aNoChallengeVal
_020B7178: .word 0x0000EA60
_020B717C: .word 0x00004E20
	arm_func_end sub_20B7058

	arm_func_start sub_20B7180
sub_20B7180: // 0x020B7180
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x18
	mov r1, #8
	mov r4, r0
	str r1, [sp, #0x10]
	ldr r0, [r4, #0xc4]
	cmp r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r0, [r4, #0]
	bl sub_20A0974
	cmp r0, #0
	addeq sp, sp, #0x18
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldr r8, _020B7224 // =0x02145524
	add r10, sp, #8
	add r9, sp, #0x10
	mov r6, #0
	mov r7, #0xff
	mvn r5, #0
_020B71D0:
	str r10, [sp]
	str r9, [sp, #4]
	ldr r0, [r4, #0]
	mov r1, r8
	mov r2, r7
	mov r3, r6
	bl sub_20A0688
	mov r2, r0
	cmp r2, r5
	beq _020B720C
	mov r0, r4
	mov r1, r8
	mov r3, r10
	strb r6, [r8, r2]
	bl sub_20B5E9C
_020B720C:
	ldr r0, [r4, #0]
	bl sub_20A0974
	cmp r0, #0
	bne _020B71D0
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020B7224: .word 0x02145524
	arm_func_end sub_20B7180

	arm_func_start qr2_think
qr2_think: // 0x020B7228
	stmdb sp!, {r4, lr}
	movs r4, r0
	ldreq r0, _020B7258 // =0x0211E8FC
	ldreq r4, [r0, #0]
	ldr r0, [r4, #0xbc]
	cmp r0, #0
	beq _020B724C
	mov r0, r4
	bl sub_20B7058
_020B724C:
	mov r0, r4
	bl sub_20B7180
	ldmia sp!, {r4, pc}
	.align 2, 0
_020B7258: .word 0x0211E8FC
	arm_func_end qr2_think

	arm_func_start sub_20B725C
sub_20B725C: // 0x020B725C
	cmp r0, #0
	ldreq r0, _020B7270 // =0x0211E8FC
	ldreq r0, [r0, #0]
	str r1, [r0, #0xa8]
	bx lr
	.align 2, 0
_020B7270: .word 0x0211E8FC
	arm_func_end sub_20B725C

	arm_func_start sub_20B7274
sub_20B7274: // 0x020B7274
	cmp r0, #0
	ldreq r0, _020B7288 // =0x0211E8FC
	ldreq r0, [r0, #0]
	str r1, [r0, #0xa4]
	bx lr
	.align 2, 0
_020B7288: .word 0x0211E8FC
	arm_func_end sub_20B7274

	arm_func_start sub_20B728C
sub_20B728C: // 0x020B728C
	cmp r0, #0
	ldreq r0, _020B72A0 // =0x0211E8FC
	ldreq r0, [r0, #0]
	str r1, [r0, #0xa0]
	bx lr
	.align 2, 0
_020B72A0: .word 0x0211E8FC
	arm_func_end sub_20B728C

	arm_func_start sub_20B72A4
sub_20B72A4: // 0x020B72A4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x40
	movs r5, r0
	mov r8, r1
	mov r4, r2
	mov r7, r3
	ldreq r5, _020B7454 // =0x0211E900
	beq _020B72D4
	mov r0, #0x110
	bl DWCi_GsMalloc
	str r0, [r5]
	ldr r5, [r5, #0]
_020B72D4:
	bl sub_20A0CA4
	bl srand
	mov r1, r7
	add r0, r5, #4
	bl strcpy
	ldr r1, [sp, #0x58]
	add r0, r5, #0x44
	bl strcpy
	str r4, [r5, #0xc0]
	mov r6, #0
	str r6, [r5, #0xac]
	str r6, [r5, #0xb0]
	str r8, [r5]
	mov r1, #1
	ldr r0, [sp, #0x7c]
	str r1, [r5, #0xb8]
	ldr r1, [sp, #0x64]
	str r0, [r5, #0x10c]
	ldr r0, [sp, #0x68]
	str r1, [r5, #0x88]
	ldr r1, [sp, #0x6c]
	str r0, [r5, #0x8c]
	ldr r0, [sp, #0x70]
	str r1, [r5, #0x90]
	ldr r1, [sp, #0x74]
	str r0, [r5, #0x94]
	ldr r0, [sp, #0x78]
	str r1, [r5, #0x98]
	str r0, [r5, #0x9c]
	str r6, [r5, #0xa0]
	str r6, [r5, #0xa4]
	ldr r0, [sp, #0x5c]
	str r6, [r5, #0xd4]
	str r0, [r5, #0xbc]
	ldr r0, [sp, #0x60]
	str r6, [r5, #0xc4]
	str r0, [r5, #0xc8]
	str r6, [r5, #0x104]
	add r0, r5, #0x100
	strh r6, [r0, #8]
	str r6, [r5, #0xa8]
	str r6, [r5, #0xb4]
	ldr r4, _020B7458 // =0x80808081
	ldr r8, _020B745C // =0x000000FF
_020B7384:
	bl rand
	smull r1, r2, r4, r0
	add r2, r0, r2
	add r3, r5, r6
	add r6, r6, #1
	mov r2, r2, asr #7
	mov r1, r0, lsr #0x1f
	add r2, r1, r2
	smull r1, r2, r8, r2
	sub r2, r0, r1
	strb r2, [r3, #0x84]
	cmp r6, #4
	blt _020B7384
	mov r2, #0
	mvn r1, #0
_020B73C0:
	add r0, r5, r2, lsl #2
	add r2, r2, #1
	str r1, [r0, #0xd8]
	cmp r2, #0xa
	blt _020B73C0
	mov r1, #0
	ldr r0, _020B7460 // =0x021454CC
	str r1, [r5, #0x100]
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _020B73F0
	bl sub_20B6E28
_020B73F0:
	ldr r0, [sp, #0x5c]
	cmp r0, #0
	beq _020B743C
	ldr r0, _020B7464 // =0x021454E4
	ldrsb r4, [r0, #0]
	cmp r4, #0
	bne _020B741C
	ldr r1, _020B7468 // =aSMasterGsNinte
	add r0, sp, #0
	mov r2, r7
	bl sprintf
_020B741C:
	cmp r4, #0
	ldrne r0, _020B7464 // =0x021454E4
	ldr r1, _020B746C // =0x00006CFC
	addeq r0, sp, #0
	add r2, r5, #0xcc
	mov r3, #0
	bl sub_20B6D74
	b _020B7440
_020B743C:
	mov r0, #1
_020B7440:
	cmp r0, #0
	movne r0, #0
	moveq r0, #3
	add sp, sp, #0x40
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020B7454: .word 0x0211E900
_020B7458: .word 0x80808081
_020B745C: .word 0x000000FF
_020B7460: .word 0x021454CC
_020B7464: .word 0x021454E4
_020B7468: .word aSMasterGsNinte
_020B746C: .word 0x00006CFC
	arm_func_end sub_20B72A4

	arm_func_start qr2_register_keyA
qr2_register_keyA: // 0x020B7470
	cmp r0, #0x32
	bxlt lr
	cmp r0, #0xfe
	bxgt lr
	ldr r2, _020B748C // =0x0211EC44
	str r1, [r2, r0, lsl #2]
	bx lr
	.align 2, 0
_020B748C: .word 0x0211EC44
	arm_func_end qr2_register_keyA

	arm_func_start sub_20B7490
sub_20B7490: // 0x020B7490
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r2
	cmp r5, #0
	mov r7, r0
	mov r6, r1
	mov r4, #0
	addle sp, sp, #4
	ldmleia sp!, {r4, r5, r6, r7, pc}
_020B74B4:
	ldrb r1, [r6, r4]
	mov r0, r7
	bl sub_20B74D8
	strb r0, [r6, r4]
	add r4, r4, #1
	cmp r4, r5
	blt _020B74B4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20B7490

	arm_func_start sub_20B74D8
sub_20B74D8: // 0x020B74D8
	stmdb sp!, {r4, lr}
	ldrb r4, [r0, #0x100]
	add r2, r4, #1
	strb r2, [r0, #0x100]
	ldrb r3, [r0, #0x101]
	ldrb r2, [r0, r4]
	add r2, r3, r2
	strb r2, [r0, #0x101]
	ldrb r3, [r0, #0x104]
	ldrb r2, [r0, #0x101]
	ldrb r4, [r0, r3]
	ldrb r2, [r0, r2]
	strb r2, [r0, r3]
	ldrb r3, [r0, #0x103]
	ldrb r2, [r0, #0x101]
	ldrb r3, [r0, r3]
	strb r3, [r0, r2]
	ldrb r3, [r0, #0x100]
	ldrb r2, [r0, #0x103]
	ldrb r3, [r0, r3]
	strb r3, [r0, r2]
	ldrb r2, [r0, #0x100]
	strb r4, [r0, r2]
	ldrb r3, [r0, #0x102]
	ldrb r2, [r0, r4]
	add r2, r3, r2
	strb r2, [r0, #0x102]
	ldrb r3, [r0, #0x103]
	ldrb r2, [r0, #0x104]
	ldrb ip, [r0, #0x101]
	ldrb r4, [r0, #0x102]
	ldrb lr, [r0, #0x100]
	ldrb r3, [r0, r3]
	ldrb r2, [r0, r2]
	ldrb ip, [r0, ip]
	ldrb r4, [r0, r4]
	add r2, r3, r2
	ldrb r3, [r0, lr]
	add r2, ip, r2
	and r2, r2, #0xff
	add r3, r4, r3
	ldrb r2, [r0, r2]
	and r3, r3, #0xff
	ldrb r3, [r0, r3]
	ldrb r2, [r0, r2]
	eor r3, r1, r3
	eor r2, r3, r2
	strb r2, [r0, #0x103]
	strb r1, [r0, #0x104]
	ldrb r0, [r0, #0x103]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B74D8

	arm_func_start sub_20B75A4
sub_20B75A4: // 0x020B75A4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x14
	mov r7, r2
	mov r9, r0
	mov r8, r1
	cmp r7, #1
	bhs _020B75CC
	bl sub_20B766C
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020B75CC:
	mov r0, #0
_020B75D0:
	strb r0, [r9, r0]
	add r0, r0, #1
	cmp r0, #0x100
	blt _020B75D0
	mov r0, #0
	str r0, [sp, #0xc]
	strb r0, [sp, #8]
	mov r6, #0xff
	add r5, sp, #8
	add r4, sp, #0xc
_020B75F8:
	str r5, [sp]
	mov r0, r9
	mov r1, r6
	mov r2, r8
	mov r3, r7
	str r4, [sp, #4]
	bl sub_20B76B4
	ldrb r2, [r9, r6]
	ldrb r1, [r9, r0]
	strb r1, [r9, r6]
	strb r2, [r9, r0]
	subs r6, r6, #1
	bpl _020B75F8
	ldrb r1, [r9, #1]
	mov r0, #0
	strb r1, [r9, #0x100]
	ldrb r1, [r9, #3]
	strb r1, [r9, #0x101]
	ldrb r1, [r9, #5]
	strb r1, [r9, #0x102]
	ldrb r1, [r9, #7]
	strb r1, [r9, #0x103]
	ldrb r1, [sp, #8]
	ldrb r1, [r9, r1]
	strb r1, [r9, #0x104]
	strb r0, [sp, #8]
	str r0, [sp, #0xc]
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end sub_20B75A4

	arm_func_start sub_20B766C
sub_20B766C: // 0x020B766C
	mov r1, #1
	strb r1, [r0, #0x100]
	mov r1, #3
	strb r1, [r0, #0x101]
	mov r1, #5
	strb r1, [r0, #0x102]
	mov r1, #7
	strb r1, [r0, #0x103]
	mov r1, #0xb
	strb r1, [r0, #0x104]
	mov r2, #0
	mov r1, #0xff
_020B769C:
	strb r1, [r0, r2]
	add r2, r2, #1
	cmp r2, #0x100
	sub r1, r1, #1
	blt _020B769C
	bx lr
	arm_func_end sub_20B766C

	arm_func_start sub_20B76B4
sub_20B76B4: // 0x020B76B4
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	ldr r8, [sp, #0x28]
	ldr r7, [sp, #0x2c]
	movs r10, r1
	mov r11, r0
	str r2, [sp]
	mov r9, r3
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r10, #1
	mov r6, #0
	mov r5, #1
	bls _020B7700
_020B76F0:
	mov r0, r5, lsl #1
	add r5, r0, #1
	cmp r5, r10
	blo _020B76F0
_020B7700:
	mov r4, #0
_020B7704:
	ldr r2, [r7, #0]
	add r6, r6, #1
	add r0, r2, #1
	str r0, [r7]
	ldrb r1, [r8, #0]
	ldr r0, [sp]
	ldrb r0, [r0, r2]
	ldrb r1, [r11, r1]
	add r0, r1, r0
	strb r0, [r8]
	ldr r0, [r7, #0]
	cmp r0, r9
	strhs r4, [r7]
	ldrhsb r0, [r8, #0]
	addhs r0, r0, r9
	strhsb r0, [r8]
	ldrb r0, [r8, #0]
	cmp r6, #0xb
	and r0, r5, r0
	bls _020B7760
	mov r1, r10
	bl _u32_div_f
	mov r0, r1
_020B7760:
	cmp r0, r10
	bhi _020B7704
	and r0, r0, #0xff
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end sub_20B76B4

	arm_func_start sub_20B7774
sub_20B7774: // 0x020B7774
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	add r0, r5, #8
	mov r4, r1
	bl sub_20B7FA0
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	mov r1, r4
	add r0, r5, #0x14
	bl sub_20B7FA0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B7774

	arm_func_start sub_20B77AC
sub_20B77AC: // 0x020B77AC
	ldr r3, [r0, #0x40]
	cmp r3, #0x14
	addlt r2, r3, #1
	strlt r2, [r0, #0x40]
	addlt r0, r0, r3
	strltb r1, [r0, #0x2c]
	bx lr
	arm_func_end sub_20B77AC

	arm_func_start sub_20B77C8
sub_20B77C8: // 0x020B77C8
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0x10]
	cmp r1, #0
	ldmeqia sp!, {r4, pc}
	mov r1, #0
	bl sub_20B7908
	mov r0, r4
	bl sub_20B7878
	ldr r0, [r4, #0x1c]
	cmp r0, #0
	ble _020B7800
	mov r0, r4
	bl sub_20B7828
_020B7800:
	ldr r0, [r4, #0x10]
	cmp r0, #0
	ldmneia sp!, {r4, pc}
	ldr r3, [r4, #0x48]
	ldr ip, [r4, #0x44]
	mov r0, r4
	mov r1, #2
	mov r2, #0
	blx ip
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B77C8

	arm_func_start sub_20B7828
sub_20B7828: // 0x020B7828
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	add r4, r5, #0x14
	b _020B7850
_020B783C:
	mov r0, r4
	bl sub_20B800C
	mov r1, r0
	mov r0, r5
	bl sub_20B7DB4
_020B7850:
	ldr r1, [r5, #0x10]
	ldr r0, [r5, #4]
	cmp r1, r0
	addge sp, sp, #4
	ldmgeia sp!, {r4, r5, pc}
	ldr r0, [r5, #0x1c]
	cmp r0, #0
	bgt _020B783C
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B7828

	arm_func_start sub_20B7878
sub_20B7878: // 0x020B7878
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r6, r0
	bl sub_20A0CA4
	ldr r3, [r6, #8]
	mov r5, r0
	cmp r3, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r4, _020B7904 // =0x000009C4
	add r7, r6, #8
	mov r8, #1
_020B78A0:
	ldr r0, [r3, #0x1c]
	add r0, r0, r4
	cmp r5, r0
	ldmlsia sp!, {r4, r5, r6, r7, r8, pc}
	ldrb r2, [r3, #0x15]
	mov r0, r6
	mov r1, r8
	orr r2, r2, #0x10
	strb r2, [r3, #0x15]
	ldr r2, [r6, #8]
	str r4, [r2, #0x1c]
	ldr r3, [r6, #8]
	ldrb r2, [r3, #0x15]
	and r2, r2, #0xd3
	strb r2, [r3, #0x15]
	ldr r2, [r6, #8]
	ldr r3, [r6, #0x48]
	ldr ip, [r6, #0x44]
	blx ip
	mov r0, r7
	bl sub_20B800C
	ldr r3, [r6, #8]
	cmp r3, #0
	bne _020B78A0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020B7904: .word 0x000009C4
	arm_func_end sub_20B7878

	arm_func_start sub_20B7908
sub_20B7908: // 0x020B7908
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr ip, _020B7AA4 // =0x00000814
	sub sp, sp, ip
	movs r9, r1
	mov r1, #8
	mov r10, r0
	str r1, [sp, #0x10]
	ldrne r8, [r10, #0x24]
	ldreq r8, [r10, #0x20]
	mov r0, r8
	bl sub_20A0974
	cmp r0, #0
	ldreq ip, _020B7AA4 // =0x00000814
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r5, sp, #0x14
	add r11, sp, #8
	mov r4, #0
_020B7950:
	ldr r2, _020B7AA8 // =0x000007FF
	str r11, [sp]
	add r6, sp, #0x10
	mov r0, r8
	mov r1, r5
	mov r3, r4
	str r6, [sp, #4]
	bl sub_20A0688
	mov r7, r0
	mvn r0, #0
	cmp r7, r0
	ldreq ip, _020B7AA4 // =0x00000814
	addeq sp, sp, ip
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	strb r4, [r5, r7]
	ldr r6, [r10, #8]
	cmp r6, #0
	beq _020B7A88
_020B7998:
	cmp r9, #0
	beq _020B79BC
	ldrb r0, [r6, #0x15]
	ands r0, r0, #8
	beq _020B79BC
	ldr r1, [r6, #0x10]
	ldr r0, [sp, #0xc]
	cmp r1, r0
	beq _020B7A18
_020B79BC:
	ldr r0, [sp, #0xc]
	ldr r3, [r6, #0]
	cmp r3, r0
	bne _020B79E4
	ldrh r2, [r6, #4]
	ldrh r1, [sp, #0xa]
	cmp r2, r1
	beq _020B7A18
	cmp r9, #0
	bne _020B7A18
_020B79E4:
	ldr r1, [r10, #0x28]
	cmp r3, r1
	bne _020B7A7C
	ldrb r1, [r6, #0x15]
	ands r1, r1, #2
	beq _020B7A7C
	ldr r1, [r6, #8]
	cmp r1, r0
	bne _020B7A7C
	ldrh r1, [r6, #0xc]
	ldrh r0, [sp, #0xa]
	cmp r1, r0
	bne _020B7A7C
_020B7A18:
	cmp r9, #0
	beq _020B7A40
	mov r0, r10
	mov r1, r6
	mov r2, r5
	mov r3, r7
	bl sub_20B7AAC
	cmp r0, #0
	beq _020B7A7C
	b _020B7A88
_020B7A40:
	ldr r0, [r10, #0]
	cmp r0, #1
	bne _020B7A64
	mov r0, r10
	mov r1, r6
	mov r2, r5
	mov r3, r7
	bl sub_20B7B5C
	b _020B7A88
_020B7A64:
	mov r0, r10
	mov r1, r6
	mov r2, r5
	mov r3, r7
	bl sub_20B7AB4
	b _020B7A88
_020B7A7C:
	ldr r6, [r6, #0x20]
	cmp r6, #0
	bne _020B7998
_020B7A88:
	mov r0, r8
	bl sub_20A0974
	cmp r0, #0
	bne _020B7950
	ldr ip, _020B7AA4 // =0x00000814
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B7AA4: .word 0x00000814
_020B7AA8: .word 0x000007FF
	arm_func_end sub_20B7908

	arm_func_start sub_20B7AAC
sub_20B7AAC: // 0x020B7AAC
	mov r0, #1
	bx lr
	arm_func_end sub_20B7AAC

	arm_func_start sub_20B7AB4
sub_20B7AB4: // 0x020B7AB4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r1
	mov r7, r2
	mov r5, r0
	ldr r1, _020B7B58 // =aFinal_6
	mov r0, r7
	bl strstr
	cmp r0, #0
	movne r6, #1
	moveq r6, #0
	mov r0, r4
	mov r1, r7
	bl sub_20B842C
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldrb r0, [r4, #0x14]
	ands r1, r0, #4
	orrne r0, r0, #0x41
	strneb r0, [r4, #0x14]
	orreq r0, r0, #0x42
	streqb r0, [r4, #0x14]
	ldrb r0, [r4, #0x14]
	and r0, r0, #0xf3
	strb r0, [r4, #0x14]
	bl sub_20A0CA4
	ldr r2, [r4, #0x1c]
	mov r1, r4
	sub r0, r0, r2
	str r0, [r4, #0x1c]
	add r0, r5, #8
	bl sub_20B7FA0
	ldr r3, [r5, #0x48]
	ldr ip, [r5, #0x44]
	mov r0, r5
	mov r2, r4
	mov r1, #0
	blx ip
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020B7B58: .word aFinal_6
	arm_func_end sub_20B7AB4

	arm_func_start sub_20B7B5C
sub_20B7B5C: // 0x020B7B5C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r8, r2
	ldrsb r2, [r8, #0]
	mov r10, r0
	mov r9, r1
	mov r7, r3
	cmp r2, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	ldrb r0, [r9, #0x14]
	add r8, r8, #5
	sub r7, r7, #5
	ands r0, r0, #4
	beq _020B7BF8
	ldr r0, [r10, #0x40]
	mov r6, #0
	cmp r0, #0
	ble _020B7BE8
	ldr r4, _020B7C58 // =0x0211EC44
_020B7BA4:
	mov r0, r8
	mov r1, r7
	bl sub_20BB0A8
	movs r5, r0
	bmi _020B7BE8
	add r0, r10, r6
	ldrb r1, [r0, #0x2c]
	mov r0, r9
	mov r2, r8
	ldr r1, [r4, r1, lsl #2]
	bl sub_20B8774
	ldr r0, [r10, #0x40]
	add r6, r6, #1
	cmp r6, r0
	add r8, r8, r5
	sub r7, r7, r5
	blt _020B7BA4
_020B7BE8:
	ldrb r0, [r9, #0x14]
	orr r0, r0, #0x41
	strb r0, [r9, #0x14]
	b _020B7C14
_020B7BF8:
	mov r0, r9
	mov r1, r8
	mov r2, r7
	bl sub_20B8248
	ldrb r0, [r9, #0x14]
	orr r0, r0, #0x43
	strb r0, [r9, #0x14]
_020B7C14:
	ldrb r0, [r9, #0x14]
	and r0, r0, #0xf3
	strb r0, [r9, #0x14]
	bl sub_20A0CA4
	ldr r2, [r9, #0x1c]
	mov r1, r9
	sub r0, r0, r2
	str r0, [r9, #0x1c]
	add r0, r10, #8
	bl sub_20B7FA0
	ldr r3, [r10, #0x48]
	ldr r4, [r10, #0x44]
	mov r0, r10
	mov r2, r9
	mov r1, #0
	blx r4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}
	.align 2, 0
_020B7C58: .word 0x0211EC44
	arm_func_end sub_20B7B5C

	arm_func_start sub_20B7C5C
sub_20B7C5C: // 0x020B7C5C
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrb ip, [r1, #0x14]
	add lr, r1, #0x14
	cmp r3, #0
	and ip, ip, #0xc3
	strb ip, [r1, #0x14]
	ldreqb r3, [lr]
	orreq r3, r3, #4
	streqb r3, [lr]
	beq _020B7CA8
	cmp r3, #1
	ldreqb r3, [lr]
	orreq r3, r3, #8
	streqb r3, [lr]
	beq _020B7CA8
	cmp r3, #2
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
_020B7CA8:
	ldr ip, [r0, #0x10]
	ldr r3, [r0, #4]
	cmp ip, r3
	bge _020B7CC4
	bl sub_20B7DB4
	add sp, sp, #4
	ldmia sp!, {pc}
_020B7CC4:
	cmp r2, #0
	beq _020B7CDC
	add r0, r0, #0x14
	bl sub_20B8044
	add sp, sp, #4
	ldmia sp!, {pc}
_020B7CDC:
	add r0, r0, #0x14
	bl sub_20B806C
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20B7C5C

	arm_func_start sub_20B7CEC
sub_20B7CEC: // 0x020B7CEC
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x20]
	bl sub_20A07E4
	mvn r1, #0
	add r0, r4, #0x14
	str r1, [r4, #0x20]
	bl sub_20B7F88
	add r0, r4, #8
	bl sub_20B7F88
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B7CEC

	arm_func_start sub_20B7D18
sub_20B7D18: // 0x020B7D18
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x14
	bl sub_20B7F88
	add r0, r4, #8
	bl sub_20B7F88
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B7D18

	arm_func_start sub_20B7D34
sub_20B7D34: // 0x020B7D34
	str r1, [r0, #0x28]
	bx lr
	arm_func_end sub_20B7D34

	arm_func_start sub_20B7D3C
sub_20B7D3C: // 0x020B7D3C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	cmp r3, #0
	bne _020B7D64
	ldr r0, _020B7DB0 // =0x02144D20
	ldr r0, [r0, #0]
	cmp r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
_020B7D64:
	bl sub_20A0C94
	str r4, [r6]
	mov r0, #2
	str r5, [r6, #4]
	mov r2, #0
	ldr r3, [sp, #0x10]
	str r2, [r6, #0x40]
	ldr r1, [sp, #0x14]
	str r3, [r6, #0x44]
	str r1, [r6, #0x48]
	mov r1, r0
	str r2, [r6, #0x28]
	bl sub_20A0800
	str r0, [r6, #0x20]
	add r0, r6, #0x14
	bl sub_20B7F88
	add r0, r6, #8
	bl sub_20B7F88
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B7DB0: .word 0x02144D20
	arm_func_end sub_20B7D3C

	arm_func_start sub_20B7DB4
sub_20B7DB4: // 0x020B7DB4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x114
	mov r5, r0
	mov r4, r1
	add r0, r5, #8
	bl sub_20B806C
	bl sub_20A0CA4
	str r0, [r4, #0x1c]
	mov r0, #2
	strb r0, [sp, #9]
	ldrb r1, [r4, #0x14]
	ands r0, r1, #0x20
	addne sp, sp, #0x114
	ldmneia sp!, {r4, r5, pc}
	ldr r0, [r5, #0]
	cmp r0, #1
	bne _020B7EBC
	mov r2, #0xfe
	mov r1, #0xfd
	mov r0, #0
	strb r2, [sp, #0x10]
	strb r1, [sp, #0x11]
	strb r0, [sp, #0x12]
	add r3, r4, #0x1c
	ldrb r2, [r4, #0x1c]
	ldrb r1, [r3, #1]
	add ip, sp, #0x13
	strb r2, [ip]
	strb r1, [ip, #1]
	ldrb r2, [r3, #2]
	ldrb r1, [r3, #3]
	strb r2, [ip, #2]
	strb r1, [ip, #3]
	ldrb r1, [r4, #0x14]
	ands r1, r1, #4
	beq _020B7EA4
	ldr r1, [r5, #0x40]
	strb r1, [sp, #0x17]
	ldr r2, [r5, #0x40]
	cmp r2, #0
	ble _020B7E7C
	add r1, sp, #0x10
_020B7E5C:
	add r2, r5, r0
	ldrb r3, [r2, #0x2c]
	add r2, r0, #8
	add r0, r0, #1
	strb r3, [r1, r2]
	ldr r2, [r5, #0x40]
	cmp r0, r2
	blt _020B7E5C
_020B7E7C:
	add r0, r2, #8
	add r1, sp, #0x10
	mov r2, #0
	strb r2, [r1, r0]
	ldr r0, [r5, #0x40]
	add r0, r0, #9
	strb r2, [r1, r0]
	ldr r0, [r5, #0x40]
	add r2, r0, #0xa
	b _020B7F20
_020B7EA4:
	mov r0, #0xff
	strb r0, [sp, #0x17]
	strb r0, [sp, #0x18]
	strb r0, [sp, #0x19]
	mov r2, #0xa
	b _020B7F20
_020B7EBC:
	ands r0, r1, #4
	beq _020B7EF8
	ldr r3, _020B7F80 // =aBasicInfo
	add ip, sp, #0x10
	mov r2, #6
_020B7ED0:
	ldrb r1, [r3], #1
	ldrb r0, [r3], #1
	subs r2, r2, #1
	strb r1, [ip], #1
	strb r0, [ip], #1
	bne _020B7ED0
	ldrb r0, [r3, #0]
	mov r2, #0xd
	strb r0, [ip]
	b _020B7F20
_020B7EF8:
	ldr r3, _020B7F84 // =aStatus_1
	add ip, sp, #0x10
	mov r2, #4
_020B7F04:
	ldrb r1, [r3], #1
	ldrb r0, [r3], #1
	subs r2, r2, #1
	strb r1, [ip], #1
	strb r0, [ip], #1
	bne _020B7F04
	mov r2, #8
_020B7F20:
	ldr r1, [r4, #0]
	ldr r0, [r5, #0x28]
	cmp r1, r0
	bne _020B7F4C
	ldrb r0, [r4, #0x15]
	ands r0, r0, #2
	ldrne r0, [r4, #8]
	strne r0, [sp, #0xc]
	ldrneh r0, [r4, #0xc]
	strneh r0, [sp, #0xa]
	bne _020B7F58
_020B7F4C:
	str r1, [sp, #0xc]
	ldrh r0, [r4, #4]
	strh r0, [sp, #0xa]
_020B7F58:
	add r1, sp, #8
	str r1, [sp]
	mov r0, #8
	str r0, [sp, #4]
	ldr r0, [r5, #0x20]
	add r1, sp, #0x10
	mov r3, #0
	bl sub_20A061C
	add sp, sp, #0x114
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B7F80: .word aBasicInfo
_020B7F84: .word aStatus_1
	arm_func_end sub_20B7DB4

	arm_func_start sub_20B7F88
sub_20B7F88: // 0x020B7F88
	mov r2, #0
	str r2, [r0, #4]
	ldr r1, [r0, #4]
	str r1, [r0]
	str r2, [r0, #8]
	bx lr
	arm_func_end sub_20B7F88

	arm_func_start sub_20B7FA0
sub_20B7FA0: // 0x020B7FA0
	ldr r3, [r0, #0]
	mov r2, #0
	cmp r3, #0
	beq _020B8004
_020B7FB0:
	cmp r3, r1
	bne _020B7FF4
	cmp r2, #0
	ldrne r1, [r3, #0x20]
	strne r1, [r2, #0x20]
	ldr r1, [r0, #0]
	cmp r1, r3
	ldreq r1, [r3, #0x20]
	streq r1, [r0]
	ldr r1, [r0, #4]
	cmp r1, r3
	streq r2, [r0, #4]
	ldr r1, [r0, #8]
	sub r1, r1, #1
	str r1, [r0, #8]
	mov r0, #1
	bx lr
_020B7FF4:
	mov r2, r3
	ldr r3, [r3, #0x20]
	cmp r3, #0
	bne _020B7FB0
_020B8004:
	mov r0, #0
	bx lr
	arm_func_end sub_20B7FA0

	arm_func_start sub_20B800C
sub_20B800C: // 0x020B800C
	ldr r2, [r0, #0]
	cmp r2, #0
	beq _020B803C
	ldr r1, [r2, #0x20]
	str r1, [r0]
	ldr r1, [r0, #0]
	cmp r1, #0
	moveq r1, #0
	streq r1, [r0, #4]
	ldr r1, [r0, #8]
	sub r1, r1, #1
	str r1, [r0, #8]
_020B803C:
	mov r0, r2
	bx lr
	arm_func_end sub_20B800C

	arm_func_start sub_20B8044
sub_20B8044: // 0x020B8044
	ldr r2, [r0, #0]
	str r2, [r1, #0x20]
	str r1, [r0]
	ldr r2, [r0, #4]
	cmp r2, #0
	streq r1, [r0, #4]
	ldr r1, [r0, #8]
	add r1, r1, #1
	str r1, [r0, #8]
	bx lr
	arm_func_end sub_20B8044

	arm_func_start sub_20B806C
sub_20B806C: // 0x020B806C
	ldr r2, [r0, #4]
	cmp r2, #0
	strne r1, [r2, #0x20]
	str r1, [r0, #4]
	mov r2, #0
	str r2, [r1, #0x20]
	ldr r2, [r0, #0]
	cmp r2, #0
	streq r1, [r0]
	ldr r1, [r0, #8]
	add r1, r1, #1
	str r1, [r0, #8]
	bx lr
	arm_func_end sub_20B806C

	arm_func_start sub_20B80A0
sub_20B80A0: // 0x020B80A0
	ldr r1, _020B80B8 // =0x0214562C
	ldr r1, [r1, #0]
	cmp r0, r1
	moveq r0, #1
	movne r0, #0
	bx lr
	.align 2, 0
_020B80B8: .word 0x0214562C
	arm_func_end sub_20B80A0

	arm_func_start sub_20B80BC
sub_20B80BC: // 0x020B80BC
	ldrb r0, [r0, #0x14]
	bx lr
	arm_func_end sub_20B80BC

	arm_func_start sub_20B80C4
sub_20B80C4: // 0x020B80C4
	strb r1, [r0, #0x14]
	bx lr
	arm_func_end sub_20B80C4

	arm_func_start sub_20B80CC
sub_20B80CC: // 0x020B80CC
	str r1, [r0, #0x10]
	bx lr
	arm_func_end sub_20B80CC

	arm_func_start sub_20B80D4
sub_20B80D4: // 0x020B80D4
	str r1, [r0, #8]
	strh r2, [r0, #0xc]
	bx lr
	arm_func_end sub_20B80D4

	arm_func_start sub_20B80E0
sub_20B80E0: // 0x020B80E0
	strb r1, [r0, #0x15]
	bx lr
	arm_func_end sub_20B80E0

	arm_func_start sub_20B80E8
sub_20B80E8: // 0x020B80E8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r0, #0x24
	mov r6, r1
	mov r5, r2
	bl DWCi_GsMalloc
	movs r4, r0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _020B818C // =sub_20B81A0
	ldr r2, _020B8190 // =sub_20B81C4
	str r0, [sp]
	mov r0, #8
	ldr r3, _020B8194 // =sub_20B81B4
	mov r1, r0
	str r2, [sp, #4]
	mov r2, #4
	bl TableNew2
	str r0, [r4, #0x18]
	ldr r0, [r4, #0x18]
	cmp r0, #0
	bne _020B8158
	mov r0, r4
	bl DWCi_GsFree
	add sp, sp, #8
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
_020B8158:
	mov r1, #0
	strb r1, [r4, #0x14]
	strb r1, [r4, #0x15]
	str r1, [r4, #0x20]
	str r1, [r4, #0x1c]
	str r1, [r4, #0x10]
	str r6, [r4]
	strh r5, [r4, #4]
	str r1, [r4, #8]
	mov r0, r4
	strh r1, [r4, #0xc]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B818C: .word sub_20B81A0
_020B8190: .word sub_20B81C4
_020B8194: .word sub_20B81B4
	arm_func_end sub_20B80E8

	arm_func_start sub_20B8198
sub_20B8198: // 0x020B8198
	ldr r0, [r0, #0x1c]
	bx lr
	arm_func_end sub_20B8198

	arm_func_start sub_20B81A0
sub_20B81A0: // 0x020B81A0
	ldr ip, _020B81B0 // =strcasecmp
	ldr r0, [r0, #0]
	ldr r1, [r1, #0]
	bx ip
	.align 2, 0
_020B81B0: .word strcasecmp
	arm_func_end sub_20B81A0

	arm_func_start sub_20B81B4
sub_20B81B4: // 0x020B81B4
	ldr ip, _020B81C0 // =sub_20B81E8
	ldr r0, [r0, #0]
	bx ip
	.align 2, 0
_020B81C0: .word sub_20B81E8
	arm_func_end sub_20B81B4

	arm_func_start sub_20B81C4
sub_20B81C4: // 0x020B81C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r1, [r4, #0]
	mov r0, #0
	bl sub_20BB0D8
	ldr r1, [r4, #4]
	mov r0, #0
	bl sub_20BB0D8
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B81C4

	arm_func_start sub_20B81E8
sub_20B81E8: // 0x020B81E8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrsb lr, [r0]
	mov ip, #0
	cmp lr, #0
	beq _020B822C
	ldr r3, _020B8240 // =_0211704C
	ldr r2, _020B8244 // =0x9CCF9319
_020B8208:
	cmp lr, #0
	blt _020B821C
	cmp lr, #0x80
	bge _020B821C
	ldrb lr, [r3, lr]
_020B821C:
	mla ip, r2, ip, lr
	ldrsb lr, [r0, #1]!
	cmp lr, #0
	bne _020B8208
_020B822C:
	mov r0, ip
	bl _u32_div_f
	mov r0, r1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020B8240: .word _0211704C
_020B8244: .word 0x9CCF9319
	arm_func_end sub_20B81E8

	arm_func_start sub_20B8248
sub_20B8248: // 0x020B8248
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x9c
	mov r10, r1
	ldrsb r1, [r10, #0]
	mov r11, r0
	mov r9, r2
	cmp r1, #0
	beq _020B82C8
_020B8268:
	mov r0, r10
	mov r1, r9
	bl sub_20BB0A8
	cmp r0, #0
	addlt sp, sp, #0x9c
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r4, r10
	sub r9, r9, r0
	add r10, r10, r0
	mov r0, r10
	mov r1, r9
	bl sub_20BB0A8
	cmp r0, #0
	addlt sp, sp, #0x9c
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r2, r10
	mov r1, r4
	add r10, r10, r0
	sub r9, r9, r0
	mov r0, r11
	bl sub_20B8774
	ldrsb r0, [r10, #0]
	cmp r0, #0
	bne _020B8268
_020B82C8:
	mov r0, #0
	add r10, r10, #1
	sub r9, r9, #1
	str r0, [sp, #4]
	str r0, [sp, #0x10]
	str r0, [sp, #8]
	str r0, [sp, #0xc]
_020B82E4:
	cmp r9, #2
	addlt sp, sp, #0x9c
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r2, [r10, #0]
	ldrb r1, [r10, #1]
	add r0, sp, #0x14
	add r10, r10, #2
	strb r2, [r0]
	strb r1, [r0, #1]
	ldrh r2, [sp, #0x14]
	str r10, [sp]
	ldr r8, [sp, #8]
	mov r0, r2, asr #8
	and r1, r0, #0xff
	mov r0, r2, lsl #8
	and r0, r0, #0xff00
	orr r0, r1, r0
	strh r0, [sp, #0x14]
	ldrsb r0, [r10, #0]
	sub r9, r9, #2
	cmp r0, #0
	beq _020B8374
_020B833C:
	mov r0, r10
	mov r1, r9
	bl sub_20BB0A8
	cmp r0, #0
	addlt sp, sp, #0x9c
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r0, #0x64
	addgt sp, sp, #0x9c
	ldmgtia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrsb r1, [r10, r0]!
	sub r9, r9, r0
	add r8, r8, #1
	cmp r1, #0
	bne _020B833C
_020B8374:
	ldrh r0, [sp, #0x14]
	ldr r7, [sp, #0xc]
	add r10, r10, #1
	cmp r0, #0
	sub r9, r9, #1
	ble _020B840C
_020B838C:
	ldr r5, [sp]
	cmp r8, #0
	ldr r6, [sp, #0x10]
	ble _020B83FC
_020B839C:
	mov r0, r10
	mov r1, r9
	bl sub_20BB0A8
	movs r4, r0
	addmi sp, sp, #0x9c
	ldmmiia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, _020B8428 // =_0211F070
	add r0, sp, #0x16
	mov r2, r5
	mov r3, r7
	bl sprintf
	mov r0, r11
	add r1, sp, #0x16
	mov r2, r10
	bl sub_20B8774
	mov r0, r5
	add r10, r10, r4
	sub r9, r9, r4
	bl strlen
	add r0, r0, #1
	add r6, r6, #1
	add r5, r5, r0
	cmp r6, r8
	blt _020B839C
_020B83FC:
	ldrh r0, [sp, #0x14]
	add r7, r7, #1
	cmp r7, r0
	blt _020B838C
_020B840C:
	ldr r0, [sp, #4]
	add r0, r0, #1
	str r0, [sp, #4]
	cmp r0, #2
	blt _020B82E4
	add sp, sp, #0x9c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B8428: .word _0211F070
	arm_func_end sub_20B8248

	arm_func_start sub_20B842C
sub_20B842C: // 0x020B842C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	add r0, r1, #1
	mov r1, #0x5c
	bl sub_20B84B0
	movs r8, r0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldr r4, _020B84AC // =0x0211F078
	mov r6, #0
	mov r5, #0x5c
_020B845C:
	mov r0, r6
	mov r1, r5
	bl sub_20B84B0
	movs r7, r0
	mov r0, r8
	moveq r7, r4
	bl sub_20B851C
	cmp r0, #0
	beq _020B8490
	mov r0, r9
	mov r1, r8
	mov r2, r7
	bl sub_20B8774
_020B8490:
	mov r0, r6
	mov r1, r5
	bl sub_20B84B0
	movs r8, r0
	bne _020B845C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020B84AC: .word 0x0211F078
	arm_func_end sub_20B842C

	arm_func_start sub_20B84B0
sub_20B84B0: // 0x020B84B0
	cmp r0, #0
	ldrne r2, _020B8518 // =0x02145624
	strne r0, [r2]
	ldr r2, _020B8518 // =0x02145624
	ldr r0, [r2, #0]
	b _020B84D4
_020B84C8:
	ldr r3, [r2, #0]
	add r3, r3, #1
	str r3, [r2]
_020B84D4:
	ldr ip, [r2]
	ldrsb r3, [ip]
	cmp r3, #0
	beq _020B84EC
	cmp r3, r1
	bne _020B84C8
_020B84EC:
	cmp ip, r0
	moveq r0, #0
	cmp r3, #0
	bxeq lr
	ldr r1, _020B8518 // =0x02145624
	mov r2, #0
	ldr r3, [r1, #0]
	add r3, r3, #1
	str r3, [r1]
	strb r2, [ip]
	bx lr
	.align 2, 0
_020B8518: .word 0x02145624
	arm_func_end sub_20B84B0

	arm_func_start sub_20B851C
sub_20B851C: // 0x020B851C
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	ldr r1, _020B8578 // =0x02112794
	add r4, sp, #0
	ldr r2, [r1, #0]
	ldr r1, [r1, #4]
	mov r6, r0
	str r2, [sp]
	str r1, [sp, #4]
	mov r5, #0
_020B8544:
	ldr r1, [r4, r5, lsl #2]
	mov r0, r6
	bl strcmp
	cmp r0, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	add r5, r5, #1
	cmp r5, #2
	blo _020B8544
	mov r0, #1
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B8578: .word 0x02112794
	arm_func_end sub_20B851C

	arm_func_start sub_20B857C
sub_20B857C: // 0x020B857C
	ldr r0, [r0, #0x20]
	bx lr
	arm_func_end sub_20B857C

	arm_func_start sub_20B8584
sub_20B8584: // 0x020B8584
	str r1, [r0, #0x20]
	bx lr
	arm_func_end sub_20B8584

	arm_func_start SBServerGetPrivateQueryPort
SBServerGetPrivateQueryPort: // 0x020B858C
	ldrh r0, [r0, #0xc]
	mov r1, r0, asr #8
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end SBServerGetPrivateQueryPort

	arm_func_start SBServerGetPrivateInetAddress
SBServerGetPrivateInetAddress: // 0x020B85B0
	ldr r0, [r0, #8]
	bx lr
	arm_func_end SBServerGetPrivateInetAddress

	arm_func_start SBServerHasPrivateAddress
SBServerHasPrivateAddress: // 0x020B85B8
	ldrb r0, [r0, #0x15]
	and r0, r0, #2
	cmp r0, #2
	moveq r0, #1
	movne r0, #0
	bx lr
	arm_func_end SBServerHasPrivateAddress

	arm_func_start sub_20B85D0
sub_20B85D0: // 0x020B85D0
	ldrh r0, [r0, #4]
	bx lr
	arm_func_end sub_20B85D0

	arm_func_start SBServerGetPublicQueryPort
SBServerGetPublicQueryPort: // 0x020B85D8
	ldrh r0, [r0, #4]
	mov r1, r0, asr #8
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	bx lr
	arm_func_end SBServerGetPublicQueryPort

	arm_func_start SBServerGetPublicInetAddress
SBServerGetPublicInetAddress: // 0x020B85FC
	ldr r0, [r0, #0]
	bx lr
	arm_func_end SBServerGetPublicInetAddress

	arm_func_start sub_20B8604
sub_20B8604: // 0x020B8604
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r2
	mov r2, #0
	mov r4, r3
	bl SBServerGetStringValueA
	cmp r0, #0
	beq _020B8630
	bl atof
	mov r5, r0
	mov r4, r1
_020B8630:
	mov r0, r5
	mov r1, r4
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B8604

	arm_func_start SBServerGetIntValueA
SBServerGetIntValueA: // 0x020B8640
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	mov r6, r0
	ldr r1, _020B86CC // =0x0211F07C
	mov r0, r5
	mov r4, r2
	bl strcmp
	cmp r0, #0
	bne _020B8670
	mov r0, r6
	bl sub_20B8198
	ldmia sp!, {r4, r5, r6, pc}
_020B8670:
	mov r0, r6
	mov r1, r5
	mov r2, #0
	bl SBServerGetStringValueA
	cmp r0, #0
	beq _020B86BC
	ldrb r2, [r0, #0]
	cmp r2, #0
	blt _020B869C
	cmp r2, #0x80
	blt _020B86A4
_020B869C:
	mov r1, #0
	b _020B86B4
_020B86A4:
	ldr r1, _020B86D0 // =_0211714C
	mov r2, r2, lsl #1
	ldrh r1, [r1, r2]
	and r1, r1, #8
_020B86B4:
	cmp r1, #0
	bne _020B86C4
_020B86BC:
	mov r0, r4
	ldmia sp!, {r4, r5, r6, pc}
_020B86C4:
	bl atoi
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B86CC: .word 0x0211F07C
_020B86D0: .word _0211714C
	arm_func_end SBServerGetIntValueA

	arm_func_start SBServerGetStringValueA
SBServerGetStringValueA: // 0x020B86D4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	movs r6, r0
	mov r5, r1
	mov r4, r2
	bne _020B8700
	ldr r0, _020B8734 // =aServer
	ldr r1, _020B8738 // =aSbServerC
	mov r2, #0
	mov r3, #0x97
	bl __msl_assertion_failed
_020B8700:
	cmp r6, #0
	addeq sp, sp, #8
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	str r5, [sp]
	ldr r0, [r6, #0x18]
	add r1, sp, #0
	bl TableLookup
	cmp r0, #0
	ldrne r4, [r0, #4]
	mov r0, r4
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B8734: .word aServer
_020B8738: .word aSbServerC
	arm_func_end SBServerGetStringValueA

	arm_func_start SBServerAddIntKeyValue
SBServerAddIntKeyValue: // 0x020B873C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0x14
	mov r4, r1
	mov r5, r0
	ldr r1, _020B8770 // =_0211F098
	add r0, sp, #0
	bl sprintf
	add r2, sp, #0
	mov r0, r5
	mov r1, r4
	bl sub_20B8774
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020B8770: .word _0211F098
	arm_func_end SBServerAddIntKeyValue

	arm_func_start sub_20B8774
sub_20B8774: // 0x020B8774
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	mov r4, r2
	mov r0, #0
	bl sub_20BB158
	str r0, [sp]
	mov r1, r4
	mov r0, #0
	bl sub_20BB158
	str r0, [sp, #4]
	ldr r0, [r5, #0x18]
	add r1, sp, #0
	bl TableEnter
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B8774

	arm_func_start sub_20B87B4
sub_20B87B4: // 0x020B87B4
	stmdb sp!, {r4, lr}
	ldr r4, [r0, #0]
	ldr r0, [r4, #0x18]
	bl TableFree
	mov r1, #0
	mov r0, r4
	str r1, [r4, #0x18]
	bl DWCi_GsFree
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B87B4

	arm_func_start sub_20B87D8
sub_20B87D8: // 0x020B87D8
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _020B8824 // =0x02145628
	ldr r0, [r0, #0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	bl TableCount
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {pc}
	ldr r0, _020B8824 // =0x02145628
	ldr r0, [r0, #0]
	bl TableFree
	ldr r0, _020B8824 // =0x02145628
	mov r1, #0
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020B8824: .word 0x02145628
	arm_func_end sub_20B87D8

	arm_func_start sub_20B8828
sub_20B8828: // 0x020B8828
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r0, _020B887C // =0x02145628
	ldr r0, [r0, #0]
	cmp r0, #0
	bne _020B886C
	ldr r0, _020B8880 // =sub_20B889C
	ldr ip, _020B8884 // =sub_20B888C
	str r0, [sp]
	ldr r3, _020B8888 // =sub_20B88B0
	mov r0, #8
	mov r1, #0x64
	mov r2, #2
	str ip, [sp, #4]
	bl TableNew2
	ldr r1, _020B887C // =0x02145628
	str r0, [r1]
_020B886C:
	ldr r0, _020B887C // =0x02145628
	ldr r0, [r0, #0]
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_020B887C: .word 0x02145628
_020B8880: .word sub_20B889C
_020B8884: .word sub_20B888C
_020B8888: .word sub_20B88B0
	arm_func_end sub_20B8828

	arm_func_start sub_20B888C
sub_20B888C: // 0x020B888C
	ldr ip, _020B8898 // =DWCi_GsFree
	ldr r0, [r0, #0]
	bx ip
	.align 2, 0
_020B8898: .word DWCi_GsFree
	arm_func_end sub_20B888C

	arm_func_start sub_20B889C
sub_20B889C: // 0x020B889C
	ldr ip, _020B88AC // =strcasecmp
	ldr r0, [r0, #0]
	ldr r1, [r1, #0]
	bx ip
	.align 2, 0
_020B88AC: .word strcasecmp
	arm_func_end sub_20B889C

	arm_func_start sub_20B88B0
sub_20B88B0: // 0x020B88B0
	ldr ip, _020B88BC // =sub_20B81E8
	ldr r0, [r0, #0]
	bx ip
	.align 2, 0
_020B88BC: .word sub_20B81E8
	arm_func_end sub_20B88B0

	arm_func_start ServerBrowserGetMyPublicIPAddr
ServerBrowserGetMyPublicIPAddr: // 0x020B88C0
	ldr r0, [r0, #0x4ec]
	bx lr
	arm_func_end ServerBrowserGetMyPublicIPAddr

	arm_func_start ServerBrowserSortA
ServerBrowserSortA: // 0x020B88C8
	ldr ip, _020B88D4 // =sub_20BB470
	add r0, r0, #0x4c
	bx ip
	.align 2, 0
_020B88D4: .word sub_20BB470
	arm_func_end ServerBrowserSortA

	arm_func_start ServerBrowserCount
ServerBrowserCount: // 0x020B88D8
	ldr ip, _020B88E4 // =sub_20BB2BC
	add r0, r0, #0x4c
	bx ip
	.align 2, 0
_020B88E4: .word sub_20BB2BC
	arm_func_end ServerBrowserCount

	arm_func_start ServerBrowserGetServer
ServerBrowserGetServer: // 0x020B88E8
	ldr ip, _020B88F4 // =sub_20BB2A0
	add r0, r0, #0x4c
	bx ip
	.align 2, 0
_020B88F4: .word sub_20BB2A0
	arm_func_end ServerBrowserGetServer

	arm_func_start sub_20B88F8
sub_20B88F8: // 0x020B88F8
	ldr r1, [r0, #0x10]
	cmp r1, #0
	movgt r0, #2
	bxgt lr
	ldr r0, [r0, #0x4c]
	cmp r0, #3
	beq _020B891C
	cmp r0, #0
	bne _020B8924
_020B891C:
	mov r0, #1
	bx lr
_020B8924:
	cmp r0, #1
	moveq r0, #0
	movne r0, #3
	bx lr
	arm_func_end sub_20B88F8

	arm_func_start ServerBrowserClear
ServerBrowserClear: // 0x020B8934
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20B894C
	add r0, r4, #0x4c
	bl sub_20BB1EC
	ldmia sp!, {r4, pc}
	arm_func_end ServerBrowserClear

	arm_func_start sub_20B894C
sub_20B894C: // 0x020B894C
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x4c
	bl sub_20BA6C4
	mov r0, r4
	bl sub_20B7D18
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B894C

	arm_func_start ServerBrowserThink
ServerBrowserThink: // 0x020B8968
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20B77C8
	add r0, r4, #0x4c
	bl sub_20B8F2C
	ldmia sp!, {r4, pc}
	arm_func_end ServerBrowserThink

	arm_func_start ServerBrowserRemoveServer
ServerBrowserRemoveServer: // 0x020B8980
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x4c
	bl sub_20BB3D4
	mov r1, r0
	mvn r0, #0
	cmp r1, r0
	ldmeqia sp!, {r4, pc}
	add r0, r4, #0x4c
	bl sub_20BB2CC
	ldmia sp!, {r4, pc}
	arm_func_end ServerBrowserRemoveServer

	arm_func_start ServerBrowserSendNatNegotiateCookieToServerA
ServerBrowserSendNatNegotiateCookieToServerA: // 0x020B89AC
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r0
	mov r6, r2
	mov r0, r1
	mov r4, r3
	bl sub_20A0580
	mov r3, r6, asr #8
	mov r2, r6, lsl #8
	mov r1, r0
	and r3, r3, #0xff
	and r0, r2, #0xff00
	orr r0, r3, r0
	mov r2, r0, lsl #0x10
	mov r3, r4
	add r0, r5, #0x4c
	mov r2, r2, lsr #0x10
	bl sub_20B90B0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ServerBrowserSendNatNegotiateCookieToServerA

	arm_func_start ServerBrowserSendMessageToServerA
ServerBrowserSendMessageToServerA: // 0x020B89F4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r5, r0
	mov r6, r2
	mov r0, r1
	mov r4, r3
	bl sub_20A0580
	mov r3, r6, asr #8
	mov r2, r6, lsl #8
	ldr ip, [sp, #0x18]
	mov r1, r0
	str ip, [sp]
	and r3, r3, #0xff
	and r0, r2, #0xff00
	orr r0, r3, r0
	mov r2, r0, lsl #0x10
	mov r3, r4
	add r0, r5, #0x4c
	mov r2, r2, lsr #0x10
	bl sub_20B9168
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end ServerBrowserSendMessageToServerA

	arm_func_start ServerBrowserLimitUpdateA
ServerBrowserLimitUpdateA: // 0x020B8A4C
	stmdb sp!, {lr}
	sub sp, sp, #0x14
	ldr lr, [sp, #0x18]
	ldr ip, [sp, #0x1c]
	str lr, [sp]
	str ip, [sp, #4]
	mov lr, #0x80
	ldr ip, [sp, #0x20]
	str lr, [sp, #8]
	str ip, [sp, #0xc]
	bl sub_20B8A80
	add sp, sp, #0x14
	ldmia sp!, {pc}
	arm_func_end ServerBrowserLimitUpdateA

	arm_func_start sub_20B8A80
sub_20B8A80: // 0x020B8A80
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x10c
	ldr r8, [sp, #0x130]
	mov r10, r0
	str r1, [sp, #4]
	add r4, sp, #8
	mov r9, r3
	mov r1, #0x40
	mov r0, #0
_020B8AA4:
	strb r0, [r4], #1
	strb r0, [r4], #1
	strb r0, [r4], #1
	strb r0, [r4], #1
	subs r1, r1, #1
	bne _020B8AA4
	mov r7, #0
	str r2, [r10, #0x620]
	mov r6, r7
	str r7, [r10, #0x40]
	cmp r8, #0
	ble _020B8B2C
	ldr r11, _020B8BA8 // =0x0211EC44
_020B8AD8:
	ldrb r0, [r9, r6]
	add r4, r9, r6
	ldr r5, [r11, r0, lsl #2]
	mov r0, r5
	bl strlen
	add r0, r7, r0
	add r0, r0, #1
	cmp r0, #0x100
	bge _020B8B2C
	add r0, sp, #8
	ldr r1, _020B8BAC // =0x0211F09C
	mov r2, r5
	add r0, r0, r7
	bl sprintf
	add r7, r7, r0
	ldrb r1, [r4, #0]
	mov r0, r10
	bl sub_20B77AC
	add r6, r6, #1
	cmp r6, r8
	blt _020B8AD8
_020B8B2C:
	ldr r4, [sp, #0x13c]
	ldr r2, [sp, #0x134]
	ldr r3, [sp, #0x138]
	add r1, sp, #8
	add r0, r10, #0x4c
	str r4, [sp]
	bl sub_20BA7E4
	cmp r0, #0
	addne sp, sp, #0x10c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #4]
	cmp r1, #0
	addne sp, sp, #0x10c
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r4, #0xa
	b _020B8B7C
_020B8B6C:
	mov r0, r4
	bl sub_20A0C98
	mov r0, r10
	bl ServerBrowserThink
_020B8B7C:
	ldr r1, [r10, #0x4c]
	cmp r1, #3
	beq _020B8B6C
	ldr r1, [r10, #0x10]
	cmp r1, #0
	addle sp, sp, #0x10c
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r0, #0
	beq _020B8B6C
	add sp, sp, #0x10c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B8BA8: .word 0x0211EC44
_020B8BAC: .word 0x0211F09C
	arm_func_end sub_20B8A80

	arm_func_start ServerBrowserFree
ServerBrowserFree: // 0x020B8BB0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x4c
	bl sub_20BA68C
	mov r0, r4
	bl sub_20B7CEC
	mov r0, r4
	bl DWCi_GsFree
	ldmia sp!, {r4, pc}
	arm_func_end ServerBrowserFree

	arm_func_start sub_20B8BD4
sub_20B8BD4: // 0x020B8BD4
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	ldr r4, [sp, #0x30]
	mov r8, r0
	mov r7, r1
	mov r6, r2
	mov r5, r3
	cmp r4, #0
	bne _020B8C10
	ldr r0, _020B8C98 // =0x02144D20
	ldr r0, [r0, #0]
	cmp r0, #1
	addne sp, sp, #0x10
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
_020B8C10:
	ldr r0, _020B8C9C // =0x00000638
	bl DWCi_GsMalloc
	movs r4, r0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	ldr r1, [sp, #0x34]
	ldr r0, [sp, #0x38]
	str r1, [r4, #0x630]
	str r0, [r4, #0x634]
	mov r0, #0
	str r0, [r4, #0x624]
	ldr r1, [sp, #0x30]
	str r5, [sp]
	ldr r0, _020B8CA0 // =sub_20B8D58
	str r1, [sp, #4]
	str r0, [sp, #8]
	mov r1, r8
	mov r2, r7
	mov r3, r6
	add r0, r4, #0x4c
	str r4, [sp, #0xc]
	bl sub_20BAF78
	ldr r0, _020B8CA4 // =sub_20B8CA8
	ldr r1, [sp, #0x28]
	str r0, [sp]
	ldr r2, [sp, #0x2c]
	ldr r3, [sp, #0x30]
	mov r0, r4
	str r4, [sp, #4]
	bl sub_20B7D3C
	mov r0, r4
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020B8C98: .word 0x02144D20
_020B8C9C: .word 0x00000638
_020B8CA0: .word sub_20B8D58
_020B8CA4: .word sub_20B8CA8
	arm_func_end sub_20B8BD4

	arm_func_start sub_20B8CA8
sub_20B8CA8: // 0x020B8CA8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r2
	mov r4, r3
	cmp r1, #0
	beq _020B8CEC
	cmp r1, #1
	beq _020B8CD4
	cmp r1, #2
	beq _020B8D04
	b _020B8D18
_020B8CD4:
	ldr r3, [r4, #0x634]
	ldr ip, [r4, #0x630]
	mov r0, r4
	mov r1, #2
	blx ip
	b _020B8D18
_020B8CEC:
	ldr r3, [r4, #0x634]
	ldr ip, [r4, #0x630]
	mov r0, r4
	mov r1, #1
	blx ip
	b _020B8D18
_020B8D04:
	ldr r3, [r4, #0x634]
	ldr ip, [r4, #0x630]
	mov r0, r4
	mov r1, #4
	blx ip
_020B8D18:
	cmp r5, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, [r5, #0]
	ldr r0, [r4, #0x628]
	cmp r1, r0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	add r0, r4, #0x600
	ldrh r1, [r5, #4]
	ldrh r0, [r0, #0x2c]
	cmp r1, r0
	moveq r0, #0
	streq r0, [r4, #0x628]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B8CA8

	arm_func_start sub_20B8D58
sub_20B8D58: // 0x020B8D58
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r2
	mov r4, r3
	cmp r1, #6
	addls pc, pc, r1, lsl #2
	b _020B8EF8
_020B8D74: // jump table
	b _020B8D90 // case 0
	b _020B8E18 // case 1
	b _020B8E54 // case 2
	b _020B8E88 // case 3
	b _020B8EF8 // case 4
	b _020B8ED0 // case 5
	b _020B8EEC // case 6
_020B8D90:
	ldr r3, [r4, #0x634]
	ldr ip, [r4, #0x630]
	mov r0, r4
	mov r1, #0
	blx ip
	ldrb r1, [r5, #0x14]
	ands r0, r1, #3
	beq _020B8DB8
	ands r0, r1, #0x40
	bne _020B8EF8
_020B8DB8:
	ands r0, r1, #0x2c
	bne _020B8EF8
	ldr r0, [r4, #0x624]
	cmp r0, #0
	bne _020B8EF8
	ldrb r0, [r5, #0x15]
	ands r0, r0, #1
	beq _020B8E00
	ldr r0, [r4, #0x4c]
	cmp r0, #0
	beq _020B8DF0
	ldr r0, [r4, #0x40]
	cmp r0, #0
	bne _020B8DF8
_020B8DF0:
	mov r3, #1
	b _020B8E04
_020B8DF8:
	mov r3, #0
	b _020B8E04
_020B8E00:
	mov r3, #2
_020B8E04:
	mov r0, r4
	mov r1, r5
	mov r2, #0
	bl sub_20B7C5C
	b _020B8EF8
_020B8E18:
	ldrb r0, [r5, #0x14]
	ands r0, r0, #0x43
	bne _020B8E3C
	ldr r3, [r4, #0x634]
	ldr ip, [r4, #0x630]
	mov r0, r4
	mov r1, #2
	blx ip
	b _020B8EF8
_020B8E3C:
	ldr r3, [r4, #0x634]
	ldr ip, [r4, #0x630]
	mov r0, r4
	mov r1, #1
	blx ip
	b _020B8EF8
_020B8E54:
	ldrb r0, [r5, #0x14]
	ands r0, r0, #0x2c
	beq _020B8E6C
	mov r0, r4
	mov r1, r5
	bl sub_20B7774
_020B8E6C:
	ldr r3, [r4, #0x634]
	ldr ip, [r4, #0x630]
	mov r0, r4
	mov r2, r5
	mov r1, #3
	blx ip
	b _020B8EF8
_020B8E88:
	ldr r1, [r4, #0x620]
	cmp r1, #0
	beq _020B8E98
	bl sub_20BA6C4
_020B8E98:
	ldr r0, [r6, #4]
	bl ArrayLength
	cmp r0, #0
	beq _020B8EB4
	ldr r0, [r4, #0x10]
	cmp r0, #0
	bne _020B8EF8
_020B8EB4:
	ldr r3, [r4, #0x634]
	ldr ip, [r4, #0x630]
	mov r0, r4
	mov r1, #4
	mov r2, #0
	blx ip
	b _020B8EF8
_020B8ED0:
	ldr r3, [r4, #0x634]
	ldr ip, [r4, #0x630]
	mov r0, r4
	mov r1, #5
	mov r2, #0
	blx ip
	b _020B8EF8
_020B8EEC:
	ldr r1, [r4, #0x4ec]
	mov r0, r4
	bl sub_20B7D34
_020B8EF8:
	cmp r5, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r5, #0]
	ldr r0, [r4, #0x628]
	cmp r1, r0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r4, #0x600
	ldrh r1, [r5, #4]
	ldrh r0, [r0, #0x2c]
	cmp r1, r0
	moveq r0, #0
	streq r0, [r4, #0x628]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20B8D58

	arm_func_start sub_20B8F2C
sub_20B8F2C: // 0x020B8F2C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20BB244
	ldr r0, [r4, #0]
	cmp r0, #3
	addls pc, pc, r0, lsl #2
	b _020B8F70
_020B8F48: // jump table
	b _020B8F64 // case 0
	b _020B8F70 // case 1
	b _020B8F58 // case 2
	b _020B8F58 // case 3
_020B8F58:
	mov r0, r4
	bl sub_20B9290
	ldmia sp!, {r4, pc}
_020B8F64:
	mov r0, r4
	bl sub_20B8F78
	ldmia sp!, {r4, pc}
_020B8F70:
	mov r0, #0
	ldmia sp!, {r4, pc}
	arm_func_end sub_20B8F2C

	arm_func_start sub_20B8F78
sub_20B8F78: // 0x020B8F78
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	ldr ip, _020B90A4 // =0x000005F4
	sub sp, sp, ip
	mov r1, #8
	mov r10, r0
	str r1, [sp, #0x10]
	ldr r0, [r10, #0x4b0]
	bl sub_20A0974
	cmp r0, #0
	beq _020B904C
	add r9, sp, #8
	add r8, sp, #0x10
	add r11, sp, #0x14
	mov r5, #0x11
	mov r7, #0
	mvn r4, #0
_020B8FB8:
	str r9, [sp]
	str r8, [sp, #4]
	ldr r0, [r10, #0x4b0]
	ldr r2, _020B90A8 // =0x000005DB
	mov r1, r11
	mov r3, r7
	bl sub_20A0688
	mvn r1, #0
	cmp r0, r1
	beq _020B903C
	ldrh r2, [sp, #0xa]
	ldr r1, [sp, #0xc]
	mov r0, r10
	bl sub_20BB358
	cmp r0, r4
	bne _020B903C
	ldrh r2, [sp, #0xa]
	ldr r1, [sp, #0xc]
	mov r0, r10
	bl sub_20B80E8
	mov r6, r0
	bl sub_20B80A0
	cmp r0, #0
	ldrne ip, _020B90A4 // =0x000005F4
	movne r0, #5
	addne sp, sp, ip
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r6
	mov r1, r5
	bl sub_20B80E0
	mov r0, r10
	mov r1, r6
	bl sub_20BB434
_020B903C:
	ldr r0, [r10, #0x4b0]
	bl sub_20A0974
	cmp r0, #0
	bne _020B8FB8
_020B904C:
	bl sub_20A0CA4
	ldr r1, [r10, #0x4b4]
	sub r0, r0, r1
	cmp r0, #0x7d0
	bls _020B9094
	ldr r0, [r10, #0x4b0]
	bl sub_20A07E4
	mvn r0, #0
	str r0, [r10, #0x4b0]
	mov r0, #1
	str r0, [r10]
	ldr r0, _020B90AC // =0x0214562C
	ldr r3, [r10, #0x494]
	ldr r2, [r0, #0]
	ldr r4, [r10, #0x488]
	mov r0, r10
	mov r1, #3
	blx r4
_020B9094:
	mov r0, #0
	ldr ip, _020B90A4 // =0x000005F4
	add sp, sp, ip
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B90A4: .word 0x000005F4
_020B90A8: .word 0x000005DB
_020B90AC: .word 0x0214562C
	arm_func_end sub_20B8F78

	arm_func_start sub_20B90B0
sub_20B90B0: // 0x020B90B0
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	sub sp, sp, #0x10
	ldr r3, [sp, #0x3c]
	mov r7, #0xfd
	mov r9, r3, lsr #0x18
	mov r8, r3, lsr #8
	mov r10, r3, lsl #8
	and r9, r9, #0xff
	and r8, r8, #0xff00
	mov r6, #0xfc
	mov r5, #0x1e
	mov r4, #0x66
	mov lr, #0x6a
	mov ip, #0xb2
	strb r7, [sp, #4]
	mov r3, r3, lsl #0x18
	orr r8, r9, r8
	and r10, r10, #0xff0000
	and r9, r3, #0xff000000
	orr r3, r10, r8
	orr r3, r9, r3
	str r3, [sp, #0x3c]
	add r8, sp, #0x3c
	strb r6, [sp, #5]
	strb r5, [sp, #6]
	strb r4, [sp, #7]
	strb lr, [sp, #8]
	strb ip, [sp, #9]
	ldrb r5, [r8, #0]
	ldrb r4, [r8, #1]
	add r7, sp, #0xa
	add r3, sp, #4
	strb r5, [r7]
	strb r4, [r7, #1]
	ldrb r6, [r8, #2]
	ldrb r5, [r8, #3]
	mov r4, #0xa
	strb r6, [r7, #2]
	strb r5, [r7, #3]
	str r4, [sp]
	bl sub_20B9168
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20B90B0

	arm_func_start sub_20B9168
sub_20B9168: // 0x020B9168
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x18
	mov r5, r0
	ldr r1, [r5, #0]
	mov r4, r3
	cmp r1, #1
	bne _020B919C
	mov r1, #0
	mov r2, r1
	mov r3, #2
	str r1, [sp]
	bl sub_20BA7E4
_020B919C:
	ldr r0, [r5, #0]
	cmp r0, #1
	addeq sp, sp, #0x18
	moveq r0, #3
	ldmeqia sp!, {r4, r5, r6, lr}
	addeq sp, sp, #0x10
	bxeq lr
	ldr r0, [sp, #0x38]
	add r1, sp, #4
	add r0, r0, #9
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, r0, asr #8
	mov r0, r0, lsl #8
	and r2, r2, #0xff
	and r0, r0, #0xff00
	orr r0, r2, r0
	strh r0, [sp, #4]
	ldrb r3, [r1, #0]
	ldrb r2, [r1, #1]
	add r1, sp, #6
	mov r0, #2
	strb r3, [r1]
	strb r2, [r1, #1]
	add lr, sp, #0x2c
	strb r0, [sp, #8]
	ldrb r3, [lr]
	ldrb r0, [lr, #1]
	add r6, sp, #9
	add r2, sp, #0x30
	strb r3, [r6]
	strb r0, [r6, #1]
	ldrb ip, [lr, #2]
	ldrb r3, [lr, #3]
	add lr, sp, #0xd
	mov r0, r5
	strb ip, [r6, #2]
	strb r3, [r6, #3]
	ldrb ip, [r2]
	ldrb r3, [r2, #1]
	mov r2, #9
	strb ip, [lr]
	strb r3, [lr, #1]
	bl sub_20BAA58
	cmp r0, #0
	addne sp, sp, #0x18
	ldmneia sp!, {r4, r5, r6, lr}
	addne sp, sp, #0x10
	bxne lr
	ldr r0, [r5, #0x4b0]
	ldr r2, [sp, #0x38]
	mov r1, r4
	mov r3, #0
	bl sub_20A066C
	cmp r0, #0
	movlt r0, #3
	movge r0, #0
	add sp, sp, #0x18
	ldmia sp!, {r4, r5, r6, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20B9168

	arm_func_start sub_20B9290
sub_20B9290: // 0x020B9290
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0x4b0]
	bl sub_20A0974
	cmp r0, #0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r4, [r6, #0x80]
	ldr r1, [r6, #0x7c]
	ldr r0, [r6, #0x4b0]
	add r1, r1, r4
	rsb r2, r4, #0x1000
	mov r3, #0
	bl sub_20A06C0
	add r1, r0, #1
	cmp r1, #1
	bhi _020B92E4
	mov r0, r6
	bl sub_20BAEB4
	mov r0, #3
	ldmia sp!, {r4, r5, r6, pc}
_020B92E4:
	ldr r1, [r6, #0x80]
	mov r5, #0
	add r0, r1, r0
	str r0, [r6, #0x80]
	ldr r0, [r6, #0]
	cmp r0, #2
	beq _020B930C
	ldr r0, [r6, #0x5c8]
	cmp r0, #0
	ble _020B9328
_020B930C:
	ldr r1, [r6, #0x7c]
	ldr r2, [r6, #0x80]
	ldr r0, _020B9378 // =0x000004BC
	add r1, r1, r4
	add r0, r6, r0
	sub r2, r2, r4
	bl sub_20B7490
_020B9328:
	ldr r0, [r6, #0]
	cmp r0, #3
	bne _020B9340
	mov r0, r6
	bl sub_20B9B20
	mov r5, r0
_020B9340:
	cmp r5, #0
	movne r0, r5
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, [r6, #0]
	cmp r0, #2
	bne _020B9370
	ldr r0, [r6, #0x80]
	cmp r0, #0
	ble _020B9370
	mov r0, r6
	bl sub_20B937C
	ldmia sp!, {r4, r5, r6, pc}
_020B9370:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020B9378: .word 0x000004BC
	arm_func_end sub_20B9290

	arm_func_start sub_20B937C
sub_20B937C: // 0x020B937C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r0, [r9, #0x80]
	mov r8, #0
	cmp r0, #3
	blt _020B9530
	ldr r10, _020B954C // =aSlistInbufferl
	ldr r11, _020B9550 // =aSbServerlistC
	add r7, sp, #0
	mov r6, r8
	mov r4, r8
	add r5, r9, #0x80
_020B93B0:
	ldr r0, [r9, #0x7c]
	ldrb r1, [r0, #0]
	ldrb r0, [r0, #1]
	strb r1, [r7]
	strb r0, [r7, #1]
	ldrh r0, [sp]
	mov r1, r0, asr #8
	mov r0, r0, lsl #8
	and r1, r1, #0xff
	and r0, r0, #0xff00
	orr r0, r1, r0
	strh r0, [sp]
	ldrh r2, [sp]
	cmp r2, #0x1000
	movhi r8, #4
	bhi _020B9530
	ldr r0, [r9, #0x80]
	cmp r0, r2
	addlt sp, sp, #4
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r9, #0x7c]
	ldrsb r0, [r1, #2]
	cmp r0, #6
	addls pc, pc, r0, lsl #2
	b _020B94C8
_020B9418: // jump table
	b _020B94C8 // case 0
	b _020B9434 // case 1
	b _020B944C // case 2
	b _020B9464 // case 3
	b _020B9484 // case 4
	b _020B949C // case 5
	b _020B94B4 // case 6
_020B9434:
	mov r0, r9
	add r1, r1, #3
	sub r2, r2, #3
	bl sub_20B9A40
	mov r8, r0
	b _020B94C8
_020B944C:
	mov r0, r9
	add r1, r1, #3
	sub r2, r2, #3
	bl sub_20B9558
	mov r8, r0
	b _020B94C8
_020B9464:
	ldr r0, [r9, #0x4b0]
	mov r3, r6
	bl sub_20A066C
	cmp r0, #0
	bgt _020B94C8
	add sp, sp, #4
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020B9484:
	mov r0, r9
	add r1, r1, #3
	sub r2, r2, #3
	bl sub_20B9650
	mov r8, r0
	b _020B94C8
_020B949C:
	mov r0, r9
	add r1, r1, #3
	sub r2, r2, #3
	bl sub_20B96E0
	mov r8, r0
	b _020B94C8
_020B94B4:
	mov r0, r9
	add r1, r1, #3
	sub r2, r2, #3
	bl sub_20B9870
	mov r8, r0
_020B94C8:
	ldrh r0, [sp]
	ldr r1, [r5, #0]
	sub r0, r1, r0
	str r0, [r5]
	ldr r0, [r9, #0x80]
	cmp r0, #0
	bge _020B94F8
	ldr r3, _020B9554 // =0x000005B4
	mov r0, r10
	mov r1, r11
	mov r2, r4
	bl __msl_assertion_failed
_020B94F8:
	ldr r2, [r9, #0x80]
	cmp r2, #0
	beq _020B951C
	ldr r0, [r9, #0x7c]
	cmp r0, #0
	beq _020B951C
	ldrh r1, [sp]
	add r1, r0, r1
	bl memmove
_020B951C:
	cmp r8, #0
	bne _020B9530
	ldr r0, [r9, #0x80]
	cmp r0, #3
	bge _020B93B0
_020B9530:
	cmp r8, #0
	beq _020B9540
	mov r0, r9
	bl sub_20BAEB4
_020B9540:
	mov r0, r8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020B954C: .word aSlistInbufferl
_020B9550: .word aSbServerlistC
_020B9554: .word 0x000005B4
	arm_func_end sub_20B937C

	arm_func_start sub_20B9558
sub_20B9558: // 0x020B9558
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r6, r2
	cmp r6, #5
	mov r8, r0
	mov r7, r1
	addlt sp, sp, #0x10
	movlt r0, #4
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	add r4, sp, #4
	add r3, sp, #8
	str r4, [sp]
	bl sub_20BA380
	ldrh r2, [sp, #4]
	ldr r1, [sp, #8]
	mov r0, r8
	bl sub_20BB358
	mov r4, r0
	mvn r0, #0
	cmp r4, r0
	bne _020B95D8
	ldrh r2, [sp, #4]
	ldr r1, [sp, #8]
	mov r0, r8
	bl sub_20B80E8
	mov r5, r0
	bl sub_20B80A0
	cmp r0, #0
	beq _020B95E8
	add sp, sp, #0x10
	mov r0, #5
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_020B95D8:
	mov r0, r8
	mov r1, r4
	bl sub_20BB2A0
	mov r5, r0
_020B95E8:
	mov ip, #0
	mov r0, r8
	mov r1, r5
	mov r2, r7
	mov r3, r6
	str ip, [sp]
	bl sub_20BA0A8
	cmp r0, #0
	addlt sp, sp, #0x10
	movlt r0, #4
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	mvn r0, #0
	cmp r4, r0
	bne _020B962C
	mov r0, r8
	mov r1, r5
	bl sub_20BB434
_020B962C:
	ldr r3, [r8, #0x494]
	ldr r4, [r8, #0x488]
	mov r0, r8
	mov r2, r5
	mov r1, #1
	blx r4
	mov r0, #0
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end sub_20B9558

	arm_func_start sub_20B9650
sub_20B9650: // 0x020B9650
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	cmp r2, #6
	mov r4, r0
	addlt sp, sp, #0xc
	movlt r0, #4
	ldmltia sp!, {r4, r5, pc}
	ldrb ip, [r1]
	ldrb r2, [r1, #1]
	add r5, sp, #4
	add r3, r1, #4
	strb ip, [r5]
	strb r2, [r5, #1]
	ldrb lr, [r1, #2]
	ldrb r2, [r1, #3]
	add ip, sp, #0
	strb lr, [r5, #2]
	strb r2, [r5, #3]
	ldrb r2, [r1, #4]
	ldrb r1, [r3, #1]
	strb r2, [ip]
	strb r1, [ip, #1]
	ldrh r2, [sp]
	ldr r1, [sp, #4]
	bl sub_20BB358
	mov r1, r0
	mvn r0, #0
	cmp r1, r0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	mov r0, r4
	bl sub_20BB2CC
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20B9650

	arm_func_start sub_20B96E0
sub_20B96E0: // 0x020B96E0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x54
	mov r8, r2
	cmp r8, #0xb
	mov r10, r0
	mov r9, r1
	addlt sp, sp, #0x54
	movlt r0, #4
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r3, [r9, #0]
	ldrb r2, [r9, #1]
	add r5, sp, #0x10
	add r1, r9, #4
	strb r3, [r5]
	strb r2, [r5, #1]
	ldrb r4, [r9, #2]
	ldrb r2, [r9, #3]
	add r3, sp, #8
	strb r4, [r5, #2]
	strb r2, [r5, #3]
	ldrb r2, [r9, #4]
	ldrb r1, [r1, #1]
	strb r2, [r3]
	strb r1, [r3, #1]
	ldrh r2, [sp, #8]
	ldr r1, [sp, #0x10]
	bl sub_20BB358
	mov r1, r0
	mvn r0, #0
	cmp r1, r0
	addeq sp, sp, #0x54
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r10
	bl sub_20BB2A0
	add r3, r9, #6
	ldrb r2, [r9, #6]
	ldrb r1, [r3, #1]
	add r4, sp, #0xc
	mov r11, r0
	strb r2, [r4]
	strb r1, [r4, #1]
	ldrb r1, [r3, #2]
	ldrb r0, [r3, #3]
	sub r8, r8, #0xb
	mov r6, #0
	strb r1, [r4, #2]
	strb r0, [r4, #3]
	ldr r0, [sp, #0xc]
	add r5, sp, #0x14
	mov r2, r0, lsr #0x18
	mov r1, r0, lsr #8
	mov r3, r0, lsl #8
	and r2, r2, #0xff
	and r1, r1, #0xff00
	mov r0, r0, lsl #0x18
	orr r1, r2, r1
	and r3, r3, #0xff0000
	and r2, r0, #0xff000000
	orr r0, r3, r1
	orr r0, r2, r0
	str r0, [sp, #0xc]
	ldrb r7, [r9, #0xa]
	add r9, r9, #0xb
	mvn r4, #0
	b _020B981C
_020B97E8:
	cmp r8, #1
	blt _020B982C
	mov r0, r9
	mov r1, r8
	bl sub_20BB0A8
	cmp r0, r4
	addeq sp, sp, #0x54
	moveq r0, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	str r9, [r5, r6, lsl #2]
	add r9, r9, r0
	sub r8, r8, r0
	add r6, r6, #1
_020B981C:
	cmp r6, r7
	bge _020B982C
	cmp r6, #0x10
	blt _020B97E8
_020B982C:
	ldr r4, [r10, #0x48c]
	cmp r4, #0
	addeq sp, sp, #0x54
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r1, sp, #0x14
	str r1, [sp]
	ldr r2, [r10, #0x494]
	mov r0, r10
	str r2, [sp, #4]
	ldr r2, [sp, #0xc]
	mov r1, r11
	mov r3, r6
	blx r4
	mov r0, #0
	add sp, sp, #0x54
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end sub_20B96E0

	arm_func_start sub_20B9870
sub_20B9870: // 0x020B9870
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x24
	mov r7, r2
	cmp r7, #2
	mov r9, r0
	mov r8, r1
	addlt sp, sp, #0x24
	movlt r0, #4
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r0, [r8, #1]
	sub r7, r7, #2
	mov r6, #0
	str r0, [sp, #0x10]
	ldrb r0, [r8, #0]
	add r8, r8, #2
	str r0, [sp, #0xc]
	ldr r0, [sp, #0x10]
	cmp r0, #0
	ble _020B9A00
	add r5, sp, #0x18
	add r4, sp, #0x1c
_020B98C4:
	mov r0, r8
	mov r1, r7
	mov r11, r8
	bl sub_20BB0A8
	mvn r1, #0
	cmp r0, r1
	addeq sp, sp, #0x24
	moveq r0, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	sub r2, r7, r0
	cmp r2, #0xb
	add lr, r8, r0
	addlt sp, sp, #0x24
	movlt r0, #4
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r1, [lr]
	ldrb r0, [lr, #1]
	sub r7, r2, #0xa
	add r3, lr, #6
	strb r1, [r5]
	strb r0, [r5, #1]
	ldrb r2, [lr, #2]
	ldrb r1, [lr, #3]
	add r0, lr, #4
	add r8, lr, #0xa
	strb r2, [r5, #2]
	strb r1, [r5, #3]
	ldrb r10, [r0, #1]
	ldrb ip, [lr, #4]
	add r2, sp, #0x14
	mov r0, r8
	strb ip, [r2]
	strb r10, [r2, #1]
	ldrb r10, [lr, #6]
	ldrb r2, [r3, #1]
	mov r1, r7
	strb r10, [r4]
	strb r2, [r4, #1]
	ldrb r10, [r3, #2]
	ldrb r2, [r3, #3]
	strb r10, [r4, #2]
	strb r2, [r4, #3]
	ldr ip, [sp, #0x1c]
	mov r3, ip, lsl #0x18
	mov r2, ip, lsr #0x18
	and r10, r3, #0xff000000
	mov r3, ip, lsl #8
	mov ip, ip, lsr #8
	and r2, r2, #0xff
	and ip, ip, #0xff00
	and r3, r3, #0xff0000
	orr r2, r2, ip
	orr r2, r3, r2
	orr r2, r10, r2
	str r2, [sp, #0x1c]
	bl sub_20BB0A8
	mov r10, r0
	mvn r0, #0
	cmp r10, r0
	addeq sp, sp, #0x24
	moveq r0, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [sp, #0x1c]
	mov r0, r9
	str r1, [sp]
	str r8, [sp, #4]
	ldr r2, [r9, #0x494]
	mov r1, r11
	str r2, [sp, #8]
	ldrh r3, [sp, #0x14]
	ldr r2, [sp, #0x18]
	ldr r11, [r9, #0x490]
	blx r11
	ldr r0, [sp, #0x10]
	add r6, r6, #1
	cmp r6, r0
	add r8, r8, r10
	sub r7, r7, r10
	blt _020B98C4
_020B9A00:
	ldr r0, [sp, #0xc]
	cmp r0, #0
	beq _020B9A34
	mov r1, #0
	str r1, [sp]
	str r1, [sp, #4]
	ldr r2, [r9, #0x494]
	mov r0, r9
	str r2, [sp, #8]
	ldr r4, [r9, #0x490]
	mov r2, r1
	mov r3, r1
	blx r4
_020B9A34:
	mov r0, #0
	add sp, sp, #0x24
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end sub_20B9870

	arm_func_start sub_20B9A40
sub_20B9A40: // 0x020B9A40
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	ldr r3, [r10, #8]
	mov r9, r1
	mov r8, r2
	cmp r3, #0
	sub r8, r8, #1
	ldrb r6, [r9], #1
	beq _020B9A6C
	bl sub_20BA728
_020B9A6C:
	mov r1, r6
	mov r0, #8
	mov r2, #0
	bl sub_209FB2C
	str r0, [r10, #8]
	ldr r0, [r10, #8]
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #5
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r6, #0
	mov r7, #0
	ble _020B9B14
	add r11, sp, #0
	mvn r4, #0
_020B9AA8:
	cmp r8, #2
	addlt sp, sp, #0xc
	movlt r0, #4
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r9, #1
	sub r1, r8, #1
	bl sub_20BB0A8
	mov r5, r0
	cmp r5, r4
	addeq sp, sp, #0xc
	moveq r0, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldrb r2, [r9, #0]
	mov r0, r10
	add r1, r9, #1
	str r2, [sp, #4]
	bl sub_20BB158
	str r0, [sp]
	ldr r0, [r10, #8]
	mov r1, r11
	bl ArrayAppend
	add r0, r5, #1
	add r7, r7, #1
	cmp r7, r6
	add r9, r9, r0
	sub r8, r8, r0
	blt _020B9AA8
_020B9B14:
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end sub_20B9A40

	arm_func_start sub_20B9B20
sub_20B9B20: // 0x020B9B20
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0xc
	mov r8, r0
	ldr r1, [r8, #0x5c8]
	ldr r7, [r8, #0x7c]
	ldr r6, [r8, #0x80]
	cmp r1, #4
	addls pc, pc, r1, lsl #2
	b _020B9F00
_020B9B44: // jump table
	b _020B9B58 // case 0
	b _020B9BB8 // case 1
	b _020B9CC8 // case 2
	b _020B9DBC // case 3
	b _020B9E70 // case 4
_020B9B58:
	cmp r6, #1
	blt _020B9F00
	ldrb r1, [r7, #0]
	eor r1, r1, #0xec
	add r3, r1, #2
	cmp r6, r3
	blt _020B9F00
	sub r1, r3, #1
	ldrb r1, [r7, r1]
	eor r2, r1, #0xea
	add r4, r3, r2
	cmp r6, r4
	blt _020B9F00
	add r1, r7, r3
	bl sub_20BA5E0
	ldr r0, _020B9F54 // =0x000004BC
	add r7, r7, r4
	sub r6, r6, r4
	mov r3, #1
	mov r1, r7
	mov r2, r6
	add r0, r8, r0
	str r3, [r8, #0x5c8]
	bl sub_20B7490
_020B9BB8:
	cmp r6, #6
	blt _020B9F00
	ldrb r1, [r7, #0]
	ldrb r0, [r7, #1]
	add r5, r8, #0x4a0
	ldr r2, _020B9F58 // =0x0214562C
	strb r1, [r8, #0x4a0]
	strb r0, [r5, #1]
	ldrb r4, [r7, #2]
	ldrb r3, [r7, #3]
	mov r0, r8
	mov r1, #6
	strb r4, [r5, #2]
	strb r3, [r5, #3]
	ldr r2, [r2, #0]
	ldr r3, [r8, #0x494]
	ldr r4, [r8, #0x488]
	blx r4
	add r1, r7, #4
	ldr r0, _020B9F5C // =0x000004A8
	ldrb r2, [r7, #4]
	ldrb r1, [r1, #1]
	add r3, r8, r0
	add r0, r8, #0x400
	strb r2, [r8, #0x4a8]
	strb r1, [r3, #1]
	ldrh r1, [r0, #0xa8]
	ldr r0, _020B9F60 // =0x0000FFFF
	cmp r1, r0
	bne _020B9C7C
	add r0, r7, #6
	sub r1, r6, #6
	bl sub_20BB0A8
	mvn r1, #0
	cmp r0, r1
	beq _020B9F00
	mov r0, r8
	add r1, r7, #6
	bl sub_20B9F70
	ldr r0, _020B9F58 // =0x0214562C
	ldr r3, [r8, #0x494]
	ldr r2, [r0, #0]
	ldr r4, [r8, #0x488]
	mov r0, r8
	mov r1, #5
	blx r4
	ldr r0, [r8, #0x7c]
	cmp r0, #0
	beq _020B9F00
_020B9C7C:
	ldr r0, [r8, #0x5c4]
	add r7, r7, #6
	sub r6, r6, #6
	ands r0, r0, #2
	bne _020B9CA4
	add r0, r8, #0x400
	ldrh r1, [r0, #0xa8]
	ldr r0, _020B9F60 // =0x0000FFFF
	cmp r1, r0
	bne _020B9CB8
_020B9CA4:
	mov r0, #5
	str r0, [r8, #0x5c8]
	mov r0, #2
	str r0, [r8]
	b _020B9F00
_020B9CB8:
	mov r0, #2
	str r0, [r8, #0x5c8]
	mvn r0, #0
	str r0, [r8, #0x484]
_020B9CC8:
	ldr r1, [r8, #0x484]
	mvn r0, #0
	cmp r1, r0
	bne _020B9D18
	cmp r6, #1
	blt _020B9F00
	ldrb r1, [r7, #0]
	mov r0, #8
	mov r2, #0
	str r1, [r8, #0x484]
	ldr r1, [r8, #0x484]
	bl sub_209FB2C
	str r0, [r8, #8]
	ldr r0, [r8, #8]
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #5
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r7, r7, #1
	sub r6, r6, #1
_020B9D18:
	ldr r0, [r8, #8]
	bl ArrayLength
	ldr r1, [r8, #0x484]
	cmp r1, r0
	ble _020B9D98
	add r5, sp, #0
	mvn r4, #0
_020B9D34:
	cmp r6, #2
	blt _020B9D98
	add r0, r7, #1
	sub r1, r6, #1
	bl sub_20BB0A8
	mov r9, r0
	cmp r9, r4
	beq _020B9D98
	ldrb r2, [r7, #0]
	mov r0, r8
	add r1, r7, #1
	str r2, [sp, #4]
	bl sub_20BB158
	str r0, [sp]
	ldr r0, [r8, #8]
	mov r1, r5
	bl ArrayAppend
	add r1, r9, #1
	ldr r0, [r8, #8]
	add r7, r7, r1
	sub r6, r6, r1
	bl ArrayLength
	ldr r1, [r8, #0x484]
	cmp r1, r0
	bgt _020B9D34
_020B9D98:
	ldr r0, [r8, #8]
	bl ArrayLength
	ldr r1, [r8, #0x484]
	cmp r1, r0
	bgt _020B9F00
	mov r0, #3
	str r0, [r8, #0x5c8]
	mvn r0, #0
	str r0, [r8, #0x484]
_020B9DBC:
	ldr r1, [r8, #0x484]
	mvn r0, #0
	cmp r1, r0
	bne _020B9DEC
	cmp r6, #1
	blt _020B9F00
	ldrb r1, [r7, #0]
	mov r0, #0
	add r7, r7, #1
	str r1, [r8, #0x484]
	str r0, [r8, #0x480]
	sub r6, r6, #1
_020B9DEC:
	ldr r1, [r8, #0x484]
	ldr r0, [r8, #0x480]
	cmp r1, r0
	ble _020B9E58
	add r4, r8, #0x480
	mvn r9, #0
_020B9E04:
	mov r0, r7
	mov r1, r6
	bl sub_20BB0A8
	mov r5, r0
	cmp r5, r9
	beq _020B9E58
	mov r0, r8
	mov r1, r7
	bl sub_20BB158
	ldr r1, [r4, #0]
	ldr r2, [r8, #0x480]
	add r1, r1, #1
	str r1, [r4]
	add r1, r8, r2, lsl #2
	str r0, [r1, #0x84]
	ldr r1, [r8, #0x484]
	ldr r0, [r8, #0x480]
	add r7, r7, r5
	cmp r1, r0
	sub r6, r6, r5
	bgt _020B9E04
_020B9E58:
	ldr r1, [r8, #0x484]
	ldr r0, [r8, #0x480]
	cmp r1, r0
	bgt _020B9F00
	mov r0, #4
	str r0, [r8, #0x5c8]
_020B9E70:
	cmp r6, #5
	blt _020B9F00
	mov r9, #0
	mvn r4, #0
	mvn r5, #1
_020B9E84:
	mov r0, r8
	mov r1, r7
	mov r2, r6
	bl sub_20B9F78
	cmp r0, r5
	addeq sp, sp, #0xc
	moveq r0, #5
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	cmp r0, r4
	bne _020B9EE4
	mov r0, #5
	str r0, [r8, #0x5c8]
	mov r0, #2
	str r0, [r8]
	ldr r0, _020B9F58 // =0x0214562C
	ldr r3, [r8, #0x494]
	ldr r2, [r0, #0]
	ldr r4, [r8, #0x488]
	mov r0, r8
	mov r1, #3
	sub r6, r6, #5
	add r7, r7, #5
	blx r4
	b _020B9F00
_020B9EE4:
	ldr r1, [r8, #0x7c]
	add r7, r7, r0
	cmp r1, #0
	sub r6, r6, r0
	moveq r0, r9
	cmp r0, #0
	bne _020B9E84
_020B9F00:
	cmp r6, #0
	bge _020B9F1C
	ldr r0, _020B9F64 // =aInlen0
	ldr r1, _020B9F68 // =aSbServerlistC
	ldr r3, _020B9F6C // =0x000004AF
	mov r2, #0
	bl __msl_assertion_failed
_020B9F1C:
	ldr r0, [r8, #0x7c]
	cmp r0, #0
	addeq sp, sp, #0xc
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	cmp r6, #0
	beq _020B9F44
	mov r1, r7
	mov r2, r6
	bl memmove
_020B9F44:
	str r6, [r8, #0x80]
	mov r0, #0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020B9F54: .word 0x000004BC
_020B9F58: .word 0x0214562C
_020B9F5C: .word 0x000004A8
_020B9F60: .word 0x0000FFFF
_020B9F64: .word aInlen0
_020B9F68: .word aSbServerlistC
_020B9F6C: .word 0x000004AF
	arm_func_end sub_20B9B20

	arm_func_start sub_20B9F70
sub_20B9F70: // 0x020B9F70
	str r1, [r0, #0x4ac]
	bx lr
	arm_func_end sub_20B9F70

	arm_func_start sub_20B9F78
sub_20B9F78: // 0x020B9F78
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x10
	mov r4, r2
	cmp r4, #1
	mov r6, r0
	mov r5, r1
	addlt sp, sp, #0x10
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	ldrb r7, [r5, #0]
	mov r0, r7
	bl sub_20BA5B4
	mov r8, r0
	cmp r4, r8
	addlt sp, sp, #0x10
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, r8, pc}
	ands r0, r7, #0x40
	beq _020B9FE4
	mov r0, r6
	add r1, r5, r8
	sub r2, r4, r8
	bl sub_20BA40C
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_020B9FE4:
	ands r0, r7, #0x80
	beq _020BA008
	add r0, r5, r8
	sub r1, r4, r8
	bl sub_20BA51C
	cmp r0, #0
	addeq sp, sp, #0x10
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
_020BA008:
	ldr r1, _020BA0A4 // =0x0211F0E8
	add r0, r5, #1
	mov r2, #4
	bl memcmp
	cmp r0, #0
	addeq sp, sp, #0x10
	mvneq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	add r7, sp, #4
	add r3, sp, #8
	mov r0, r6
	mov r1, r5
	mov r2, r4
	str r7, [sp]
	bl sub_20BA380
	ldrh r2, [sp, #4]
	ldr r1, [sp, #8]
	mov r0, r6
	bl sub_20B80E8
	mov r7, r0
	bl sub_20B80A0
	cmp r0, #0
	addne sp, sp, #0x10
	mvnne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov ip, #1
	mov r0, r6
	mov r1, r7
	mov r2, r5
	mov r3, r4
	str ip, [sp]
	bl sub_20BA0A8
	mov r4, r0
	mov r0, r6
	mov r1, r7
	bl sub_20BB434
	mov r0, r4
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_020BA0A4: .word 0x0211F0E8
	arm_func_end sub_20B9F78

	arm_func_start sub_20BA0A8
sub_20BA0A8: // 0x020BA0A8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r8, r2
	ldrb r2, [r8, #0]
	mov r9, r1
	mov r10, r0
	mov r7, r3
	str r2, [sp, #4]
	mov r0, r9
	mov r1, r2
	str r7, [sp]
	ldr r6, [sp, #0x38]
	bl sub_20B80E0
	ldr r0, [sp, #4]
	add r8, r8, #5
	ands r0, r0, #0x10
	sub r7, r7, #5
	ldr r0, [sp, #4]
	addne r8, r8, #2
	subne r7, r7, #2
	ands r0, r0, #2
	moveq r0, #0
	streq r0, [sp, #0xc]
	beq _020BA134
	ldrb r1, [r8, #0]
	ldrb r0, [r8, #1]
	add r2, sp, #0xc
	sub r7, r7, #4
	strb r1, [r2]
	strb r0, [r2, #1]
	ldrb r1, [r8, #2]
	ldrb r0, [r8, #3]
	add r8, r8, #4
	strb r1, [r2, #2]
	strb r0, [r2, #3]
_020BA134:
	ldr r0, [sp, #4]
	ands r0, r0, #0x20
	addeq r0, r10, #0x400
	ldreqh r0, [r0, #0xa8]
	streqh r0, [sp, #0xa]
	beq _020BA168
	ldrb r1, [r8, #0]
	ldrb r0, [r8, #1]
	add r2, sp, #0xa
	add r8, r8, #2
	strb r1, [r2]
	strb r0, [r2, #1]
	sub r7, r7, #2
_020BA168:
	ldrh r2, [sp, #0xa]
	ldr r1, [sp, #0xc]
	mov r0, r9
	bl sub_20B80D4
	ldr r0, [sp, #4]
	ands r0, r0, #8
	beq _020BA1BC
	ldrb r2, [r8, #0]
	ldrb r1, [r8, #1]
	add r3, sp, #0xc
	mov r0, r9
	strb r2, [r3]
	strb r1, [r3, #1]
	ldrb r2, [r8, #2]
	ldrb r1, [r8, #3]
	add r8, r8, #4
	sub r7, r7, #4
	strb r2, [r3, #2]
	strb r1, [r3, #3]
	ldr r1, [sp, #0xc]
	bl sub_20B80CC
_020BA1BC:
	ldr r0, [sp, #4]
	ands r0, r0, #0x40
	beq _020BA2F4
	ldr r0, [r10, #8]
	bl ArrayLength
	mov r5, r0
	cmp r5, #0
	mov r4, #0
	ble _020BA2DC
	mov r11, #0xff
_020BA1E4:
	ldr r0, [r10, #8]
	mov r1, r4
	bl ArrayNth
	mov r1, r0
	ldr r0, [r1, #4]
	cmp r0, #0
	beq _020BA27C
	cmp r0, #1
	beq _020BA214
	cmp r0, #2
	beq _020BA230
	b _020BA2D0
_020BA214:
	ldrb r2, [r8, #0]
	ldr r1, [r1, #0]
	mov r0, r9
	bl SBServerAddIntKeyValue
	add r8, r8, #1
	sub r7, r7, #1
	b _020BA2D0
_020BA230:
	ldrb ip, [r8]
	ldrb r3, [r8, #1]
	add r2, sp, #8
	mov r0, r9
	strb ip, [r2]
	strb r3, [r2, #1]
	ldrh r3, [sp, #8]
	ldr r1, [r1, #0]
	mov r2, r3, asr #8
	mov r3, r3, lsl #8
	and r2, r2, #0xff
	and r3, r3, #0xff00
	orr r2, r2, r3
	mov r2, r2, lsl #0x10
	mov r2, r2, lsr #0x10
	bl SBServerAddIntKeyValue
	add r8, r8, #2
	sub r7, r7, #2
	b _020BA2D0
_020BA27C:
	cmp r6, #0
	ldrneb r0, [r8], #1
	subne r7, r7, #1
	moveq r0, r11
	cmp r0, #0xff
	bne _020BA2BC
	ldr r1, [r1, #0]
	mov r0, r9
	mov r2, r8
	bl sub_20B8774
	mov r0, r8
	bl strlen
	add r0, r0, #1
	add r8, r8, r0
	sub r7, r7, r0
	b _020BA2D0
_020BA2BC:
	add r0, r10, r0, lsl #2
	ldr r1, [r1, #0]
	ldr r2, [r0, #0x84]
	mov r0, r9
	bl sub_20B8774
_020BA2D0:
	add r4, r4, #1
	cmp r4, r5
	blt _020BA1E4
_020BA2DC:
	mov r0, r9
	bl sub_20B80BC
	orr r1, r0, #1
	mov r0, r9
	and r1, r1, #0xff
	bl sub_20B80C4
_020BA2F4:
	ldr r0, [sp, #4]
	ands r0, r0, #0x80
	beq _020BA370
	b _020BA340
_020BA304:
	mov r0, r8
	mov r4, r8
	bl strlen
	add r3, r0, #1
	add r8, r8, r3
	mov r0, r9
	mov r1, r4
	mov r2, r8
	sub r7, r7, r3
	bl sub_20B8774
	mov r0, r8
	bl strlen
	add r0, r0, #1
	add r8, r8, r0
	sub r7, r7, r0
_020BA340:
	ldrsb r0, [r8, #0]
	cmp r0, #0
	beq _020BA354
	cmp r7, #0
	bgt _020BA304
_020BA354:
	mov r0, r9
	sub r7, r7, #1
	bl sub_20B80BC
	orr r1, r0, #2
	mov r0, r9
	and r1, r1, #0xff
	bl sub_20B80C4
_020BA370:
	ldr r0, [sp]
	sub r0, r0, r7
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end sub_20BA0A8

	arm_func_start sub_20BA380
sub_20BA380: // 0x020BA380
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	cmp r2, #5
	addlt sp, sp, #4
	ldmltia sp!, {r4, r5, pc}
	add r5, r1, #1
	ldrb ip, [r1]
	ldrb r4, [r1, #1]
	ldrb lr, [r5, #1]
	ands ip, ip, #0x10
	strb r4, [r3]
	strb lr, [r3, #1]
	ldrb lr, [r5, #2]
	ldrb ip, [r5, #3]
	strb lr, [r3, #2]
	strb ip, [r3, #3]
	beq _020BA3F4
	sub r0, r2, #5
	cmp r0, #2
	addlt sp, sp, #4
	ldmltia sp!, {r4, r5, pc}
	add r0, r1, #5
	ldrb r1, [r1, #5]
	ldr r2, [sp, #0x10]
	ldrb r0, [r0, #1]
	add sp, sp, #4
	strb r1, [r2]
	strb r0, [r2, #1]
	ldmia sp!, {r4, r5, pc}
_020BA3F4:
	add r0, r0, #0x400
	ldrh r1, [r0, #0xa8]
	ldr r0, [sp, #0x10]
	strh r1, [r0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20BA380

	arm_func_start sub_20BA40C
sub_20BA40C: // 0x020BA40C
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	ldr r0, [r8, #8]
	mov r7, r1
	mov r6, r2
	bl ArrayLength
	mov r5, r0
	cmp r5, #0
	mov r4, #0
	ble _020BA504
	mvn r9, #0
_020BA43C:
	ldr r0, [r8, #8]
	mov r1, r4
	bl ArrayNth
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _020BA480
	cmp r0, #1
	beq _020BA468
	cmp r0, #2
	beq _020BA474
	b _020BA4C8
_020BA468:
	add r7, r7, #1
	sub r6, r6, #1
	b _020BA4E8
_020BA474:
	add r7, r7, #2
	sub r6, r6, #2
	b _020BA4E8
_020BA480:
	cmp r6, #1
	addlt sp, sp, #4
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, pc}
	ldrb r0, [r7], #1
	sub r6, r6, #1
	cmp r0, #0xff
	bne _020BA4E8
	mov r0, r7
	mov r1, r6
	bl sub_20BB0A8
	cmp r0, r9
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r7, r7, r0
	sub r6, r6, r0
	b _020BA4E8
_020BA4C8:
	ldr r0, _020BA510 // =0x0211F0F0
	ldr r1, _020BA514 // =aSbServerlistC
	ldr r3, _020BA518 // =0x00000317
	mov r2, #0
	bl __msl_assertion_failed
	add sp, sp, #4
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020BA4E8:
	cmp r6, #0
	addlt sp, sp, #4
	movlt r0, #0
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, pc}
	add r4, r4, #1
	cmp r4, r5
	blt _020BA43C
_020BA504:
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020BA510: .word 0x0211F0F0
_020BA514: .word aSbServerlistC
_020BA518: .word 0x00000317
	arm_func_end sub_20BA40C

	arm_func_start sub_20BA51C
sub_20BA51C: // 0x020BA51C
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	b _020BA578
_020BA530:
	mov r0, r5
	mov r1, r4
	bl sub_20BB0A8
	cmp r0, #0
	addlt sp, sp, #4
	movlt r0, #0
	ldmltia sp!, {r4, r5, pc}
	sub r4, r4, r0
	add r5, r5, r0
	mov r0, r5
	mov r1, r4
	bl sub_20BB0A8
	cmp r0, #0
	addlt sp, sp, #4
	movlt r0, #0
	ldmltia sp!, {r4, r5, pc}
	add r5, r5, r0
	sub r4, r4, r0
_020BA578:
	cmp r4, #0
	ble _020BA58C
	ldrsb r0, [r5, #0]
	cmp r0, #0
	bne _020BA530
_020BA58C:
	cmp r4, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldrsb r0, [r5, #0]
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20BA51C

	arm_func_start sub_20BA5B4
sub_20BA5B4: // 0x020BA5B4
	mov r2, #5
	ands r1, r0, #2
	addne r2, r2, #4
	ands r1, r0, #8
	addne r2, r2, #4
	ands r1, r0, #0x10
	addne r2, r2, #2
	ands r0, r0, #0x20
	addne r2, r2, #2
	mov r0, r2
	bx lr
	arm_func_end sub_20BA5B4

	arm_func_start sub_20BA5E0
sub_20BA5E0: // 0x020BA5E0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	mov r7, r2
	add r0, r9, #0x54
	mov r8, r1
	bl strlen
	mov r5, r0
	cmp r7, #0
	add r4, r9, #0x54
	mov r6, #0
	ble _020BA66C
_020BA610:
	mov r0, r6
	mov r1, r5
	bl _s32_div_f
	ldrsb r1, [r4, r1]
	mov r2, r6, lsr #0x1f
	rsb r0, r2, r6, lsl #29
	mul r3, r6, r1
	mov r1, r3, lsr #0x1f
	add r2, r2, r0, ror #29
	rsb r0, r1, r3, lsl #29
	add r2, r9, r2
	add r3, r1, r0, ror #29
	ldrsb r0, [r8, r6]
	ldrsb r1, [r2, #0x74]
	add r2, r9, r3
	add r6, r6, #1
	eor r0, r1, r0
	ldrsb r1, [r2, #0x74]
	mov r0, r0, lsl #0x18
	cmp r6, r7
	eor r0, r1, r0, asr #24
	strb r0, [r2, #0x74]
	blt _020BA610
_020BA66C:
	ldr r0, _020BA688 // =0x000004BC
	add r1, r9, #0x74
	add r0, r9, r0
	mov r2, #8
	bl sub_20B75A4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_020BA688: .word 0x000004BC
	arm_func_end sub_20BA5E0

	arm_func_start sub_20BA68C
sub_20BA68C: // 0x020BA68C
	stmdb sp!, {r4, lr}
	mov r4, r0
	bl sub_20BA6C4
	mov r0, r4
	bl sub_20BB1EC
	mov r0, r4
	bl sub_20B87D8
	ldr r0, [r4, #4]
	cmp r0, #0
	beq _020BA6B8
	bl ArrayFree
_020BA6B8:
	mov r0, #0
	str r0, [r4, #4]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20BA68C

	arm_func_start sub_20BA6C4
sub_20BA6C4: // 0x020BA6C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #0x7c]
	cmp r0, #0
	beq _020BA6DC
	bl DWCi_GsFree
_020BA6DC:
	mov r0, #0
	str r0, [r4, #0x7c]
	str r0, [r4, #0x80]
	ldr r0, [r4, #0x4b0]
	mvn r1, #0
	cmp r0, r1
	beq _020BA6FC
	bl sub_20A07E4
_020BA6FC:
	mvn r1, #0
	mov r0, r4
	str r1, [r4, #0x4b0]
	mov r1, #1
	str r1, [r4]
	bl sub_20BA728
	mvn r1, #0
	mov r0, r4
	str r1, [r4, #0x484]
	bl sub_20BA798
	ldmia sp!, {r4, pc}
	arm_func_end sub_20BA6C4

	arm_func_start sub_20BA728
sub_20BA728: // 0x020BA728
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, [r5, #8]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	mov r4, #0
	bl ArrayLength
	cmp r0, #0
	ble _020BA780
_020BA754:
	ldr r0, [r5, #8]
	mov r1, r4
	bl ArrayNth
	ldr r1, [r0, #0]
	mov r0, r5
	bl sub_20BB0D8
	ldr r0, [r5, #8]
	add r4, r4, #1
	bl ArrayLength
	cmp r4, r0
	blt _020BA754
_020BA780:
	ldr r0, [r5, #8]
	bl ArrayFree
	mov r0, #0
	str r0, [r5, #8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20BA728

	arm_func_start sub_20BA798
sub_20BA798: // 0x020BA798
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	ldr r0, [r5, #0x480]
	mov r4, #0
	cmp r0, #0
	ble _020BA7D4
_020BA7B4:
	add r0, r5, r4, lsl #2
	ldr r1, [r0, #0x84]
	mov r0, r5
	bl sub_20BB0D8
	ldr r0, [r5, #0x480]
	add r4, r4, #1
	cmp r4, r0
	blt _020BA7B4
_020BA7D4:
	mov r0, #0
	str r0, [r5, #0x480]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20BA798

	arm_func_start sub_20BA7E4
sub_20BA7E4: // 0x020BA7E4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #0x30c
	mov r5, r0
	ldr r0, [r5, #0]
	mov r7, r1
	mov r6, r2
	mov r4, r3
	cmp r0, #1
	beq _020BA81C
	ldr r0, _020BAA48 // =aSlistStateSlDi
	ldr r1, _020BAA4C // =aSbServerlistC
	ldr r3, _020BAA50 // =0x0000020A
	mov r2, #0
	bl __msl_assertion_failed
_020BA81C:
	cmp r7, #0
	ldreq r7, _020BAA54 // =_0211F114
	cmp r6, #0
	ldreq r6, _020BAA54 // =_0211F114
	mov r0, r7
	bl strlen
	cmp r0, #0x100
	addhi sp, sp, #0x30c
	movhi r0, #6
	ldmhiia sp!, {r4, r5, r6, r7, pc}
	mov r0, r6
	bl strlen
	cmp r0, #0x100
	addhi sp, sp, #0x30c
	movhi r0, #6
	ldmhiia sp!, {r4, r5, r6, r7, pc}
	mov r0, r5
	bl sub_20BAD20
	cmp r0, #0
	addne sp, sp, #0x30c
	ldmneia sp!, {r4, r5, r6, r7, pc}
	mov r0, r5
	str r4, [r5, #0x5c4]
	bl sub_20BAAFC
	add r3, sp, #0xe
	mov ip, #2
	add r0, sp, #8
	add r2, sp, #4
	mov r1, #0
	str ip, [sp, #4]
	str r3, [sp, #8]
	bl sub_20BACA4
	add r0, sp, #8
	add r2, sp, #4
	mov r1, #1
	bl sub_20BACA4
	add r0, sp, #8
	mov r1, #3
	add r2, sp, #4
	bl sub_20BACA4
	ldr r1, [r5, #0x4b8]
	add r0, sp, #8
	add r2, sp, #4
	bl sub_20BAC48
	add r0, sp, #8
	add r1, r5, #0xc
	add r2, sp, #4
	bl sub_20BACC8
	add r0, sp, #8
	add r1, r5, #0x30
	add r2, sp, #4
	bl sub_20BACC8
	add r0, sp, #8
	add r1, r5, #0x74
	mov r2, #8
	add r3, sp, #4
	bl sub_20BAC14
	mov r1, r6
	add r0, sp, #8
	add r2, sp, #4
	bl sub_20BACC8
	mov r1, r7
	add r0, sp, #8
	add r2, sp, #4
	bl sub_20BACC8
	mov r1, r4, lsl #0x18
	and ip, r1, #0xff000000
	mov r1, r4, lsl #8
	and r3, r1, #0xff0000
	mov r1, r4, lsr #0x18
	and r2, r1, #0xff
	mov r1, r4, lsr #8
	and r1, r1, #0xff00
	orr r1, r2, r1
	orr r1, r3, r1
	add r0, sp, #8
	orr r1, ip, r1
	add r2, sp, #4
	bl sub_20BAC48
	ldr r0, [r5, #0x5c4]
	ands r0, r0, #8
	beq _020BA974
	ldr r1, [r5, #0x4a4]
	add r0, sp, #8
	add r2, sp, #4
	bl sub_20BAC48
_020BA974:
	ldr r0, [r5, #0x5c4]
	ands r0, r0, #0x80
	beq _020BA990
	ldr r1, [sp, #0x320]
	add r0, sp, #8
	add r2, sp, #4
	bl sub_20BAC48
_020BA990:
	ldr r0, [sp, #4]
	add r1, sp, #0
	mov r0, r0, lsl #0x10
	mov r0, r0, lsr #0x10
	mov r2, r0, asr #8
	mov r0, r0, lsl #8
	and r2, r2, #0xff
	and r0, r0, #0xff00
	orr r0, r2, r0
	strh r0, [sp]
	ldrb r2, [r1, #0]
	ldrb r0, [r1, #1]
	add r1, sp, #0xc
	mov r3, #0
	strb r2, [r1]
	strb r0, [r1, #1]
	ldr r0, [r5, #0x4b0]
	ldr r2, [sp, #4]
	bl sub_20A066C
	cmp r0, #0
	bgt _020BA9F8
	mov r0, r5
	bl sub_20BA6C4
	add sp, sp, #0x30c
	mov r0, #3
	ldmia sp!, {r4, r5, r6, r7, pc}
_020BA9F8:
	mov r0, #3
	str r0, [r5]
	mov r0, #0
	str r0, [r5, #0x5c8]
	ldr r0, [r5, #0x7c]
	cmp r0, #0
	bne _020BAA3C
	mov r0, #0x1000
	bl DWCi_GsMalloc
	str r0, [r5, #0x7c]
	ldr r0, [r5, #0x7c]
	cmp r0, #0
	addeq sp, sp, #0x30c
	moveq r0, #5
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	mov r0, #0
	str r0, [r5, #0x80]
_020BAA3C:
	mov r0, #0
	add sp, sp, #0x30c
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020BAA48: .word aSlistStateSlDi
_020BAA4C: .word aSbServerlistC
_020BAA50: .word 0x0000020A
_020BAA54: .word _0211F114
	arm_func_end sub_20BA7E4

	arm_func_start sub_20BAA58
sub_20BAA58: // 0x020BAA58
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	mov r9, r1
	mov r8, r2
	mov r6, #1
	mov r5, #0
	mov r4, #2
_020BAA78:
	ldr r0, [r10, #0x4b0]
	mov r1, r9
	mov r2, r8
	mov r3, r5
	sub r6, r6, #1
	bl sub_20A066C
	mov r7, r0
	cmp r7, #0
	bgt _020BAAE8
	cmp r6, #0
	blt _020BAAE8
	mov r0, r10
	bl sub_20BA6C4
	mov r0, r10
	mov r1, r5
	mov r2, r5
	mov r3, r4
	str r5, [sp]
	bl sub_20BA7E4
	movs r11, r0
	beq _020BAAE0
	mov r0, r10
	bl sub_20BAEB4
	add sp, sp, #4
	mov r0, r11
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020BAAE0:
	cmp r6, #0
	bge _020BAA78
_020BAAE8:
	cmp r7, #0
	movle r0, #3
	movgt r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	arm_func_end sub_20BAA58

	arm_func_start sub_20BAAFC
sub_20BAAFC: // 0x020BAAFC
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	bl rand
	ldr r1, _020BAC0C // =0x2C0B02C1
	mov r8, #0
	smull r3, r4, r1, r0
	mov r2, r0, lsr #0x1f
	mov r4, r4, asr #4
	ldr r1, _020BAC10 // =0x0000005D
	add r4, r2, r4
	smull r2, r3, r1, r4
	sub r4, r0, r2
	add r0, r4, #0x21
	mov r9, #1
	strb r0, [r10, #0x74]
	mov r5, r8
	mov r6, r9
	mov r11, r8
	mov r4, r9
_020BAB4C:
	sub r0, r9, #1
	add r0, r10, r0
	ldrsb r2, [r0, #0x74]
	ldrsb r3, [r10, #0x74]
	add r7, r10, r9
	cmp r2, r3
	eor r2, r9, r2
	movlt r0, r6
	and r2, r2, #1
	movge r0, r5
	cmp r3, #0x4f
	movlt r1, r4
	and r3, r3, #1
	eor r2, r8, r2
	movge r1, r11
	eor r2, r3, r2
	eor r1, r2, r1
	eor r8, r1, r0
	bl rand
	ldr r2, _020BAC0C // =0x2C0B02C1
	cmp r8, #0
	smull r3, r1, r2, r0
	mov r1, r1, asr #4
	mov r2, r0, lsr #0x1f
	add r1, r2, r1
	ldr r2, _020BAC10 // =0x0000005D
	smull r1, r3, r2, r1
	sub r1, r0, r1
	add r0, r1, #0x21
	strb r0, [r7, #0x74]
	beq _020BABD4
	ldrsb r0, [r7, #0x74]
	ands r0, r0, #1
	beq _020BABEC
_020BABD4:
	cmp r8, #0
	bne _020BABF8
	ldrsb r0, [r7, #0x74]
	and r0, r0, #1
	cmp r0, #1
	bne _020BABF8
_020BABEC:
	ldrsb r0, [r7, #0x74]
	add r0, r0, #1
	strb r0, [r7, #0x74]
_020BABF8:
	add r9, r9, #1
	cmp r9, #8
	blt _020BAB4C
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_020BAC0C: .word 0x2C0B02C1
_020BAC10: .word 0x0000005D
	arm_func_end sub_20BAAFC

	arm_func_start sub_20BAC14
sub_20BAC14: // 0x020BAC14
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #0]
	mov r4, r3
	mov r5, r2
	bl memcpy
	ldr r0, [r4, #0]
	add r0, r0, r5
	str r0, [r4]
	ldr r0, [r6, #0]
	add r0, r0, r5
	str r0, [r6]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20BAC14

	arm_func_start sub_20BAC48
sub_20BAC48: // 0x020BAC48
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {lr}
	sub sp, sp, #4
	add ip, sp, #0xc
	ldrb r3, [ip]
	ldrb r1, [ip, #1]
	ldr lr, [r0]
	strb r3, [lr]
	strb r1, [lr, #1]
	ldrb r3, [ip, #2]
	ldrb r1, [ip, #3]
	strb r3, [lr, #2]
	strb r1, [lr, #3]
	ldr r1, [r2, #0]
	add r1, r1, #4
	str r1, [r2]
	ldr r1, [r0, #0]
	add r1, r1, #4
	str r1, [r0]
	add sp, sp, #4
	ldmia sp!, {lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20BAC48

	arm_func_start sub_20BACA4
sub_20BACA4: // 0x020BACA4
	ldr r3, [r0, #0]
	strb r1, [r3]
	ldr r1, [r2, #0]
	add r1, r1, #1
	str r1, [r2]
	ldr r1, [r0, #0]
	add r1, r1, #1
	str r1, [r0]
	bx lr
	arm_func_end sub_20BACA4

	arm_func_start sub_20BACC8
sub_20BACC8: // 0x020BACC8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r1
	ldreq r7, _020BAD1C // =_0211F114
	mov r4, r0
	mov r0, r7
	mov r6, r2
	bl strlen
	add r5, r0, #1
	ldr r0, [r4, #0]
	mov r1, r7
	mov r2, r5
	bl memcpy
	ldr r0, [r6, #0]
	add r0, r0, r5
	str r0, [r6]
	ldr r0, [r4, #0]
	add r0, r0, r5
	str r0, [r4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020BAD1C: .word _0211F114
	arm_func_end sub_20BACC8

	arm_func_start sub_20BAD20
sub_20BAD20: // 0x020BAD20
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x88
	mov r4, r0
	add r0, r4, #0xc
	mov r1, #0x14
	bl sub_20BAE54
	ldr r1, _020BAE48 // =0x02145630
	mov r3, r0
	ldr r1, [r1, #0]
	cmp r1, #0
	beq _020BAD58
	add r0, sp, #8
	bl strcpy
	b _020BAD68
_020BAD58:
	ldr r1, _020BAE4C // =aSMsDGsNintendo
	add r0, sp, #8
	add r2, r4, #0xc
	bl sprintf
_020BAD68:
	ldr r1, _020BAE50 // =0x0000EE70
	mov r2, #2
	add r0, sp, #8
	strb r2, [sp, #1]
	strh r1, [sp, #2]
	bl sub_20A0580
	mvn r1, #0
	str r0, [sp, #4]
	cmp r0, r1
	bne _020BADD4
	add r0, sp, #8
	bl sub_20BE844
	cmp r0, #0
	addeq sp, sp, #0x88
	moveq r0, #2
	ldmeqia sp!, {r4, pc}
	ldr r0, [r0, #0xc]
	add r3, sp, #4
	ldr r2, [r0, #0]
	ldrb r1, [r2, #0]
	ldrb r0, [r2, #1]
	strb r1, [r3]
	strb r0, [r3, #1]
	ldrb r1, [r2, #2]
	ldrb r0, [r2, #3]
	strb r1, [r3, #2]
	strb r0, [r3, #3]
_020BADD4:
	ldr r0, [r4, #0x4b0]
	mvn r1, #0
	cmp r0, r1
	bne _020BAE10
	mov r0, #2
	mov r1, #1
	mov r2, #0
	bl sub_20A0800
	str r0, [r4, #0x4b0]
	ldr r0, [r4, #0x4b0]
	mvn r1, #0
	cmp r0, r1
	addeq sp, sp, #0x88
	moveq r0, #1
	ldmeqia sp!, {r4, pc}
_020BAE10:
	add r1, sp, #0
	mov r2, #8
	bl sub_20A072C
	cmp r0, #0
	addeq sp, sp, #0x88
	moveq r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, [r4, #0x4b0]
	bl sub_20A07E4
	mvn r0, #0
	str r0, [r4, #0x4b0]
	mov r0, #3
	add sp, sp, #0x88
	ldmia sp!, {r4, pc}
	.align 2, 0
_020BAE48: .word 0x02145630
_020BAE4C: .word aSMsDGsNintendo
_020BAE50: .word 0x0000EE70
	arm_func_end sub_20BAD20

	arm_func_start sub_20BAE54
sub_20BAE54: // 0x020BAE54
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldrsb lr, [r0]
	mov ip, #0
	cmp lr, #0
	beq _020BAE98
	ldr r3, _020BAEAC // =_0211704C
	ldr r2, _020BAEB0 // =0x9CCF9319
_020BAE74:
	cmp lr, #0
	blt _020BAE88
	cmp lr, #0x80
	bge _020BAE88
	ldrb lr, [r3, lr]
_020BAE88:
	mla ip, r2, ip, lr
	ldrsb lr, [r0, #1]!
	cmp lr, #0
	bne _020BAE74
_020BAE98:
	mov r0, ip
	bl _u32_div_f
	mov r0, r1
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_020BAEAC: .word _0211704C
_020BAEB0: .word 0x9CCF9319
	arm_func_end sub_20BAE54

	arm_func_start sub_20BAEB4
sub_20BAEB4: // 0x020BAEB4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r4, r0
	ldr r5, [r4, #0x80]
	cmp r5, #0
	ble _020BAF44
	ldr r0, _020BAF70 // =0x0211F0A0
	ldr r6, [r0, #0]
	mov r0, r6
	bl strlen
	cmp r5, r0
	bls _020BAF44
	ldr r0, _020BAF70 // =0x0211F0A0
	ldr r7, [r4, #0x7c]
	ldr r5, [r0, #0]
	mov r0, r5
	bl strlen
	mov r2, r0
	mov r0, r7
	mov r1, r5
	bl strncmp
	cmp r0, #0
	bne _020BAF44
	mov r0, r6
	bl strlen
	mov r1, r0
	mov r0, r4
	add r1, r7, r1
	bl sub_20B9F70
	ldr r0, _020BAF74 // =0x0214562C
	ldr r3, [r4, #0x494]
	ldr r2, [r0, #0]
	ldr ip, [r4, #0x488]
	mov r0, r4
	mov r1, #5
	blx ip
_020BAF44:
	ldr r0, _020BAF74 // =0x0214562C
	ldr r3, [r4, #0x494]
	ldr r2, [r0, #0]
	ldr ip, [r4, #0x488]
	mov r0, r4
	mov r1, #4
	blx ip
	mov r0, r4
	bl sub_20BA6C4
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020BAF70: .word 0x0211F0A0
_020BAF74: .word 0x0214562C
	arm_func_end sub_20BAEB4

	arm_func_start sub_20BAF78
sub_20BAF78: // 0x020BAF78
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	movs r7, r0
	mov r6, r1
	mov r5, r2
	mov r4, r3
	bne _020BAFA8
	ldr r0, _020BB090 // =aSlistNull
	ldr r1, _020BB094 // =aSbServerlistC
	mov r2, #0
	mov r3, #0x11c
	bl __msl_assertion_failed
_020BAFA8:
	ldr r0, [sp, #0x1c]
	cmp r0, #0
	bne _020BAFC8
	ldr r0, _020BB098 // =0x02144D20
	ldr r0, [r0, #0]
	cmp r0, #1
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, r6, r7, pc}
_020BAFC8:
	mov r1, #1
	mov r0, r7
	str r1, [r7]
	bl sub_20BB1C4
	mov r0, r7
	bl sub_20B8828
	mov r1, r6
	add r0, r7, #0xc
	bl strcpy
	mov r1, r5
	add r0, r7, #0x30
	bl strcpy
	mov r1, r4
	add r0, r7, #0x54
	bl strcpy
	ldr r0, [sp, #0x20]
	mov r2, #0
	str r0, [r7, #0x488]
	cmp r0, #0
	str r2, [r7, #0x48c]
	bne _020BB02C
	ldr r0, _020BB09C // =aCallbackNull
	ldr r1, _020BB094 // =aSbServerlistC
	ldr r3, _020BB0A0 // =0x00000132
	bl __msl_assertion_failed
_020BB02C:
	ldr r0, [sp, #0x24]
	ldr r1, _020BB0A4 // =_0211F114
	str r0, [r7, #0x494]
	str r1, [r7, #0x498]
	mov r3, #0
	str r3, [r7, #0x4a0]
	mvn r0, #0
	str r0, [r7, #0x4b0]
	str r3, [r7, #0x7c]
	str r3, [r7, #0x80]
	str r3, [r7, #8]
	str r0, [r7, #0x484]
	str r3, [r7, #0x480]
	ldr r2, [sp, #0x18]
	str r3, [r7, #0x4a4]
	mov r0, r7
	str r2, [r7, #0x4b8]
	bl sub_20B9F70
	mov r0, #0
	str r0, [r7, #0x5cc]
	bl sub_20A0CA4
	bl srand
	bl sub_20A0C94
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_020BB090: .word aSlistNull
_020BB094: .word aSbServerlistC
_020BB098: .word 0x02144D20
_020BB09C: .word aCallbackNull
_020BB0A0: .word 0x00000132
_020BB0A4: .word _0211F114
	arm_func_end sub_20BAF78

	arm_func_start sub_20BB0A8
sub_20BB0A8: // 0x020BB0A8
	cmp r1, #0
	mov r3, #0
	ble _020BB0D0
_020BB0B4:
	ldrsb r2, [r0, r3]
	cmp r2, #0
	addeq r0, r3, #1
	bxeq lr
	add r3, r3, #1
	cmp r3, r1
	blt _020BB0B4
_020BB0D0:
	mvn r0, #0
	bx lr
	arm_func_end sub_20BB0A8

	arm_func_start sub_20BB0D8
sub_20BB0D8: // 0x020BB0D8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r5, r0
	str r1, [sp]
	bl sub_20B8828
	add r1, sp, #0
	bl TableLookup
	movs r4, r0
	bne _020BB110
	ldr r0, _020BB150 // =aValNull
	ldr r1, _020BB154 // =aSbServerlistC
	mov r2, #0
	mov r3, #0xf4
	bl __msl_assertion_failed
_020BB110:
	cmp r4, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, [r4, #4]
	sub r0, r0, #1
	str r0, [r4, #4]
	ldr r0, [r4, #4]
	cmp r0, #0
	addne sp, sp, #0xc
	ldmneia sp!, {r4, r5, pc}
	mov r0, r5
	bl sub_20B8828
	add r1, sp, #0
	bl TableRemove
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020BB150: .word aValNull
_020BB154: .word aSbServerlistC
	arm_func_end sub_20BB0D8

	arm_func_start sub_20BB158
sub_20BB158: // 0x020BB158
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	mov r4, r1
	mov r5, r0
	str r4, [sp]
	bl sub_20B8828
	add r1, sp, #0
	bl TableLookup
	cmp r0, #0
	ldrne r1, [r0, #4]
	addne sp, sp, #0xc
	addne r1, r1, #1
	strne r1, [r0, #4]
	ldrne r0, [r0, #0]
	ldmneia sp!, {r4, r5, pc}
	mov r0, r4
	bl sub_20A0C50
	str r0, [sp]
	mov r1, #1
	mov r0, r5
	str r1, [sp, #4]
	bl sub_20B8828
	add r1, sp, #0
	bl TableEnter
	ldr r0, [sp]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20BB158

	arm_func_start sub_20BB1C4
sub_20BB1C4: // 0x020BB1C4
	stmdb sp!, {r4, lr}
	mov r4, r0
	mov r0, #4
	mov r1, #0x64
	mov r2, #0
	bl sub_209FB2C
	str r0, [r4, #4]
	mov r0, #0
	str r0, [r4, #0x5d0]
	ldmia sp!, {r4, pc}
	arm_func_end sub_20BB1C4

	arm_func_start sub_20BB1EC
sub_20BB1EC: // 0x020BB1EC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #4]
	bl ArrayLength
	mov r4, r0
	cmp r4, #0
	mov r5, #0
	ble _020BB230
_020BB20C:
	ldr r0, [r6, #4]
	mov r1, r5
	bl ArrayNth
	ldr r1, [r0, #0]
	mov r0, r6
	bl sub_20BB318
	add r5, r5, #1
	cmp r5, r4
	blt _020BB20C
_020BB230:
	ldr r0, [r6, #4]
	bl sub_209F570
	mov r0, r6
	bl sub_20BB244
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20BB1EC

	arm_func_start sub_20BB244
sub_20BB244: // 0x020BB244
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #8
	mov r6, r0
	ldr r0, [r6, #0x5d0]
	cmp r0, #0
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	str r0, [sp]
	cmp r0, #0
	beq _020BB290
	add r4, sp, #0
_020BB270:
	ldr r0, [sp]
	bl sub_20B857C
	mov r5, r0
	mov r0, r4
	bl sub_20B87B4
	str r5, [sp]
	cmp r5, #0
	bne _020BB270
_020BB290:
	mov r0, #0
	str r0, [r6, #0x5d0]
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20BB244

	arm_func_start sub_20BB2A0
sub_20BB2A0: // 0x020BB2A0
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, [r0, #4]
	bl ArrayNth
	ldr r0, [r0, #0]
	add sp, sp, #4
	ldmia sp!, {pc}
	arm_func_end sub_20BB2A0

	arm_func_start sub_20BB2BC
sub_20BB2BC: // 0x020BB2BC
	ldr ip, _020BB2C8 // =ArrayLength
	ldr r0, [r0, #4]
	bx ip
	.align 2, 0
_020BB2C8: .word ArrayLength
	arm_func_end sub_20BB2BC

	arm_func_start sub_20BB2CC
sub_20BB2CC: // 0x020BB2CC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	ldr r0, [r6, #4]
	mov r5, r1
	bl ArrayNth
	ldr r4, [r0, #0]
	ldr r3, [r6, #0x494]
	ldr ip, [r6, #0x488]
	mov r0, r6
	mov r2, r4
	mov r1, #2
	blx ip
	ldr r0, [r6, #4]
	mov r1, r5
	bl ArrayDeleteAt
	mov r0, r6
	mov r1, r4
	bl sub_20BB318
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_20BB2CC

	arm_func_start sub_20BB318
sub_20BB318: // 0x020BB318
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	mov r5, r0
	mov r4, r1
	ldr r1, [r5, #0x5d0]
	cmp r1, #0
	bne _020BB344
	mov r0, r4
	mov r1, #0
	bl sub_20B8584
	b _020BB34C
_020BB344:
	mov r0, r4
	bl sub_20B8584
_020BB34C:
	str r4, [r5, #0x5d0]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	arm_func_end sub_20BB318

	arm_func_start sub_20BB358
sub_20BB358: // 0x020BB358
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r9, r0
	ldr r0, [r9, #4]
	mov r8, r1
	mov r7, r2
	bl ArrayLength
	mov r6, r0
	cmp r6, #0
	mov r4, #0
	ble _020BB3C8
_020BB384:
	ldr r0, [r9, #4]
	mov r1, r4
	bl ArrayNth
	ldr r5, [r0, #0]
	mov r0, r5
	bl SBServerGetPublicInetAddress
	cmp r8, r0
	bne _020BB3BC
	mov r0, r5
	bl sub_20B85D0
	cmp r7, r0
	addeq sp, sp, #4
	moveq r0, r4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_020BB3BC:
	add r4, r4, #1
	cmp r4, r6
	blt _020BB384
_020BB3C8:
	mvn r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	arm_func_end sub_20BB358

	arm_func_start sub_20BB3D4
sub_20BB3D4: // 0x020BB3D4
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r7, r0
	ldr r0, [r7, #4]
	mov r6, r1
	bl ArrayLength
	mov r5, r0
	cmp r5, #0
	mov r4, #0
	ble _020BB428
_020BB3FC:
	ldr r0, [r7, #4]
	mov r1, r4
	bl ArrayNth
	ldr r0, [r0, #0]
	cmp r6, r0
	addeq sp, sp, #4
	moveq r0, r4
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	add r4, r4, #1
	cmp r4, r5
	blt _020BB3FC
_020BB428:
	mvn r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	arm_func_end sub_20BB3D4

	arm_func_start sub_20BB434
sub_20BB434: // 0x020BB434
	stmdb sp!, {r0, r1, r2, r3}
	stmdb sp!, {r4, lr}
	mov r4, r0
	ldr r0, [r4, #4]
	add r1, sp, #0xc
	bl ArrayAppend
	ldr r2, [sp, #0xc]
	ldr r3, [r4, #0x494]
	ldr ip, [r4, #0x488]
	mov r0, r4
	mov r1, #0
	blx ip
	ldmia sp!, {r4, lr}
	add sp, sp, #0x10
	bx lr
	arm_func_end sub_20BB434

	arm_func_start sub_20BB470
sub_20BB470: // 0x020BB470
	cmp r3, #3
	addls pc, pc, r3, lsl #2
	b _020BB4AC
_020BB47C: // jump table
	b _020BB48C // case 0
	b _020BB494 // case 1
	b _020BB49C // case 2
	b _020BB4A4 // case 3
_020BB48C:
	ldr r3, _020BB4D0 // =IntKeyCompare
	b _020BB4B0
_020BB494:
	ldr r3, _020BB4D4 // =sub_20BB5C8
	b _020BB4B0
_020BB49C:
	ldr r3, _020BB4D8 // =sub_20BB558
	b _020BB4B0
_020BB4A4:
	ldr r3, _020BB4DC // =sub_20BB4E8
	b _020BB4B0
_020BB4AC:
	ldr r3, _020BB4DC // =sub_20BB4E8
_020BB4B0:
	str r2, [r0, #0x498]
	str r1, [r0, #0x49c]
	ldr r2, _020BB4E0 // =0x02145634
	ldr ip, _020BB4E4 // =sub_209F750
	str r0, [r2]
	mov r1, r3
	ldr r0, [r0, #4]
	bx ip
	.align 2, 0
_020BB4D0: .word IntKeyCompare
_020BB4D4: .word sub_20BB5C8
_020BB4D8: .word sub_20BB558
_020BB4DC: .word sub_20BB4E8
_020BB4E0: .word 0x02145634
_020BB4E4: .word sub_209F750
	arm_func_end sub_20BB470

	arm_func_start sub_20BB4E8
sub_20BB4E8: // 0x020BB4E8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r2, _020BB550 // =0x02145634
	mov r5, r1
	ldr r1, [r2, #0]
	ldr r0, [r0, #0]
	ldr r1, [r1, #0x498]
	ldr r2, _020BB554 // =_0211F114
	bl SBServerGetStringValueA
	ldr r1, _020BB550 // =0x02145634
	mov r4, r0
	ldr r1, [r1, #0]
	ldr r0, [r5, #0]
	ldr r1, [r1, #0x498]
	ldr r2, _020BB554 // =_0211F114
	bl SBServerGetStringValueA
	mov r1, r0
	mov r0, r4
	bl strcasecmp
	ldr r1, _020BB550 // =0x02145634
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x49c]
	cmp r1, #0
	rsbeq r0, r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020BB550: .word 0x02145634
_020BB554: .word _0211F114
	arm_func_end sub_20BB4E8

	arm_func_start sub_20BB558
sub_20BB558: // 0x020BB558
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r2, _020BB5C0 // =0x02145634
	mov r5, r1
	ldr r1, [r2, #0]
	ldr r0, [r0, #0]
	ldr r1, [r1, #0x498]
	ldr r2, _020BB5C4 // =_0211F114
	bl SBServerGetStringValueA
	ldr r1, _020BB5C0 // =0x02145634
	mov r4, r0
	ldr r1, [r1, #0]
	ldr r0, [r5, #0]
	ldr r1, [r1, #0x498]
	ldr r2, _020BB5C4 // =_0211F114
	bl SBServerGetStringValueA
	mov r1, r0
	mov r0, r4
	bl strcmp
	ldr r1, _020BB5C0 // =0x02145634
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x49c]
	cmp r1, #0
	rsbeq r0, r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020BB5C0: .word 0x02145634
_020BB5C4: .word _0211F114
	arm_func_end sub_20BB558

	arm_func_start sub_20BB5C8
sub_20BB5C8: // 0x020BB5C8
	stmdb sp!, {r4, r5, r6, lr}
	ldr r3, _020BB6A4 // =0x02145634
	mov r2, #0
	ldr r3, [r3, #0]
	ldr r5, [r1, #0]
	ldr r0, [r0, #0]
	ldr r1, [r3, #0x498]
	mov r3, r2
	bl sub_20B8604
	ldr r3, _020BB6A4 // =0x02145634
	mov r2, #0
	mov r4, r0
	ldr r0, [r3, #0]
	mov r6, r1
	ldr r1, [r0, #0x498]
	mov r0, r5
	mov r3, r2
	bl sub_20B8604
	mov r2, r0
	mov r3, r1
	mov r0, r4
	mov r1, r6
	bl _dsub
	ldr r2, _020BB6A4 // =0x02145634
	mov r4, r0
	ldr r0, [r2, #0]
	mov r5, r1
	ldr r0, [r0, #0x49c]
	cmp r0, #0
	bne _020BB65C
	mov r0, #0
	mov r1, r0
	mov r2, r4
	mov r3, r5
	bl _dsub
	mov r4, r0
	mov r5, r1
_020BB65C:
	mov r0, r4
	mov r1, r5
	bl _d2f
	mov r1, #0
	bl _fgr
	cmp r0, #0
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r4
	mov r1, r5
	bl _d2f
	mov r1, #0
	bl _fls
	cmp r0, #0
	movne r0, #1
	moveq r0, #0
	rsb r0, r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_020BB6A4: .word 0x02145634
	arm_func_end sub_20BB5C8

	arm_func_start IntKeyCompare
IntKeyCompare: // 0x020BB6A8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r2, _020BB708 // =0x02145634
	ldr r0, [r0, #0]
	ldr r2, [r2, #0]
	ldr r5, [r1, #0]
	ldr r1, [r2, #0x498]
	mov r2, #0
	bl SBServerGetIntValueA
	ldr r1, _020BB708 // =0x02145634
	mov r4, r0
	ldr r1, [r1, #0]
	mov r0, r5
	ldr r1, [r1, #0x498]
	mov r2, #0
	bl SBServerGetIntValueA
	ldr r1, _020BB708 // =0x02145634
	sub r0, r4, r0
	ldr r1, [r1, #0]
	ldr r1, [r1, #0x49c]
	cmp r1, #0
	rsbeq r0, r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_020BB708: .word 0x02145634
	arm_func_end IntKeyCompare

	.rodata
	
_02112660:
	.byte 0x5B, 0x5D, 0x5F, 0x00, 0x2D, 0x5F, 0x3D, 0x00, 0x2B, 0x2F, 0x3D, 0x00, 0x25, 0x30, 0x30, 0x00
	
a2147483647: // 0x02112670
	.asciz "2147483647"
	.align 4

_0211267C:
	.byte 0x13, 0x1D, 0x01, 0x04
	.byte 0x00, 0x00, 0x00, 0x28, 0x1F, 0x06, 0x45, 0x34, 0x3F, 0x01, 0x1B, 0x00, 0x5C, 0x00, 0x00, 0x00
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
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFD, 0xFC, 0x1E, 0x66
	.byte 0x6A, 0xB2, 0x00, 0x00, 0x68, 0xF0, 0x11, 0x02, 0x60, 0xF0, 0x11, 0x02, 0xFF, 0xFF, 0xFF, 0xFF
	.byte 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
	.byte 0xFF, 0xFF, 0xFF, 0xFF

	.data

_0211C530:
	.byte 0xFE, 0xFD, 0x09, 0x00
aSAvailableGsNi: // 0x0211C534
	.asciz "%s.available.gs.nintendowifi.net"
_0211C555:
	.byte 0x00, 0x00, 0x00, 0x66, 0x6E, 0x00, 0x00
aDarrayC: // 0x0211C55C
	.asciz "darray.c"
_0211C565:
	.byte 0x00, 0x00, 0x00
aN0NArrayCount: // 0x0211C568
	.asciz "(n >= 0) && (n < array->count)"
_0211C587:
	.byte 0x00
aComparator: // 0x0211C588
	.asciz "comparator"
_0211C593:
	.byte 0x00
aN0NArrayCount_0: // 0x0211C594
	.asciz "(n >= 0) && (n <= array->count)"
aArray: // 0x0211C5B4
	.asciz "array"
_0211C5BA:
	.byte 0x00, 0x00
aElemsize: // 0x0211C5BC
	.asciz "elemSize"
_0211C5C5:
	.byte 0x00, 0x00, 0x00
aArrayList: // 0x0211C5C8
	.asciz "array->list"
_0211C5D4:
	.byte 0x66, 0x6E, 0x00, 0x00
aHashtableC: // 0x0211C5D8
	.asciz "hashtable.c"
aTable: // 0x0211C5E4
	.asciz "table"
_0211C5EA:
	.byte 0x00, 0x00
aHashfn: // 0x0211C5EC
	.asciz "hashFn"
_0211C5F3:
	.byte 0x00
aCompfn: // 0x0211C5F4
	.asciz "compFn"
_0211C5FB:
	.byte 0x00
aElemsize_0: // 0x0211C5FC
	.asciz "elemSize"
_0211C605:
	.byte 0x00, 0x00, 0x00
aNbuckets: // 0x0211C608
	.asciz "nBuckets"
_0211C611:
	.byte 0x00, 0x00, 0x00
aTableBuckets: // 0x0211C614
	.asciz "table->buckets"
_0211C623:
	.byte 0x00, 0x25, 0x30, 0x32, 0x78, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
aOsIstickavaila: // 0x0211C630
	.asciz "OS_IsTickAvailable() == TRUE"
_0211C64D:
	.byte 0x00, 0x00, 0x00
aNonportC: // 0x0211C650
	.asciz "nonport.c"
_0211C65A:
	.byte 0x00, 0x00
aLocalhost: // 0x0211C65C
	.asciz "localhost"
_0211C666:
	.byte 0x00, 0x00
aBufferinNull: // 0x0211C668
	.asciz "bufferIn != NULL"
_0211C679:
	.byte 0x00, 0x00, 0x00
aGhttpbufferC: // 0x0211C67C
	.asciz "ghttpBuffer.c"
_0211C68A:
	.byte 0x00, 0x00
aLenNull: // 0x0211C68C
	.asciz "len != NULL"
aBuffer: // 0x0211C698
	.asciz "buffer"
_0211C69F:
	.byte 0x00
	.byte 0x25, 0x64, 0x00, 0x00, 0x3A, 0x20, 0x00, 0x00, 0x0D, 0x0A, 0x00, 0x00, 0x64, 0x61, 0x74, 0x61
	.byte 0x00, 0x00, 0x00, 0x00
aDatalen0: // 0x0211C6B4
	.asciz "dataLen >= 0"
_0211C6C1:
	.byte 0x00, 0x00, 0x00
aConnectionEncr: // 0x0211C6C4
	.asciz "connection->encryptor.mEngine != GHTTPEncryptionEngine_None"
aConnection_0: // 0x0211C700
	.asciz "connection"
_0211C70B:
	.byte 0x00
aUserbuffer: // 0x0211C70C
	.asciz "userBuffer"
_0211C717:
	.byte 0x00
aSize0: // 0x0211C718
	.asciz "size > 0"
_0211C721:
	.byte 0x00, 0x00, 0x00
aInitialsize0: // 0x0211C724
	.asciz "initialSize > 0"
aSizeincrement0: // 0x0211C734
	.asciz "sizeIncrement > 0"
_0211C746:
	.byte 0x00, 0x00
aConnection_1: // 0x0211C748
	.asciz "connection"
_0211C753:
	.byte 0x00
aGhttpcallbacks: // 0x0211C754
	.asciz "ghttpCallbacks.c"
_0211C765:
	.byte 0x00, 0x00, 0x00, 0xFA, 0x00, 0x00, 0x00, 0x7D, 0x00, 0x00, 0x00
aConnection_2: // 0x0211C770
	.asciz "connection"
_0211C77B:
	.byte 0x00
aGhttpconnectio: // 0x0211C77C
	.asciz "ghttpConnection.c"
_0211C78E:
	.byte 0x00, 0x00
aConnectionRedi: // 0x0211C790
	.asciz "connection->redirectURL"
aRequest0: // 0x0211C7A8
	.asciz "request >= 0"
_0211C7B5:
	.byte 0x00, 0x00, 0x00
aRequestGhiconn: // 0x0211C7B8
	.asciz "request < ghiConnectionsLen"
aConnectionRequ: // 0x0211C7D4
	.asciz "connection->request >= 0"
_0211C7ED:
	.byte 0x00, 0x00, 0x00
aConnectionRequ_0: // 0x0211C7F0
	.asciz "connection->request < ghiConnectionsLen"
aConnectionInus: // 0x0211C818
	.asciz "connection->inUse"
_0211C82A:
	.byte 0x00, 0x00
aGhinumconnecti: // 0x0211C82C
	.asciz "ghiNumConnections == ghiConnectionsLen"
_0211C853:
	.byte 0x00
aGhttpmainC: // 0x0211C854
	.asciz "ghttpMain.c"
aUrlUrl0: // 0x0211C860
	.asciz "URL && URL[0]"
_0211C86E:
	.byte 0x00, 0x00
aBuffersize0: // 0x0211C870
	.asciz "bufferSize >= 0"
aBufferBuffersi: // 0x0211C880
	.asciz "!buffer || bufferSize"
_0211C896:
	.byte 0x00, 0x00
aConnection_3: // 0x0211C898
	.asciz "connection"
_0211C8A3:
	.byte 0x00
aGhirequesttoco: // 0x0211C8A4
	.asciz "ghiRequestToConnection(connection->request) == connection"
_0211C8DE:
	.byte 0x00, 0x00
aConnection_4: // 0x0211C8E0
	.asciz "connection"
_0211C8EB:
	.byte 0x00
aGhttppostC: // 0x0211C8EC
	.asciz "ghttpPost.c"
aConnectionPost: // 0x0211C8F8
	.asciz "connection->post"
_0211C909:
	.byte 0x00, 0x00, 0x00
aConnectionPost_0: // 0x0211C90C
	.asciz "connection->postingState.states"
aArraylengthCon: // 0x0211C92C
	.asciz "ArrayLength(connection->post->data) == ArrayLength(connection->postingState.states)"
aConnectionPost_1: // 0x0211C980
	.asciz "connection->postingState.index >= 0"
aConnectionPost_2: // 0x0211C9A4
	.asciz "connection->postingState.index <= ArrayLength(connection->postingState.states)"
_0211C9F3:
	.byte 0x00
aPoststate: // 0x0211C9F4
	.asciz "postState"
_0211C9FE:
	.byte 0x00, 0x00
aConnectionComp: // 0x0211CA00
	.asciz "connection->completed && connection->result"
aQr4g823s23d7d1: // 0x0211CA2C
	.asciz "\r\n--Qr4G823s23d---<<><><<<>--7d118e0536--\r\n"
aStateDataTypeG: // 0x0211CA58
	.asciz "state->data->type == GHIString"
_0211CA77:
	.byte 0x00, 0x25, 0x73, 0x3D, 0x00, 0x26, 0x25, 0x73, 0x3D
	.byte 0x00, 0x00, 0x00, 0x00
aQr4g823s23d7d1_0: // 0x0211CA84
	.asciz "--Qr4G823s23d---<<><><<<>--7d118e0536\r\n"
aQr4g823s23d7d1_1: // 0x0211CAAC
	.asciz "\r\n--Qr4G823s23d---<<><><<<>--7d118e0536\r\n"
_0211CAD6:
	.byte 0x00, 0x00
aScontentDispos: // 0x0211CAD8
	.asciz "%sContent-Disposition: form-data; name=\"%s\"\r\n\r\n"
aScontentDispos_0: // 0x0211CB08
	.asciz "%sContent-Disposition: form-data; name=\"%s\"; filename=\"%s\"\r\nContent-Type: %s\r\n\r\n"
_0211CB59:
	.byte 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00
aStateDataTypeG_0: // 0x0211CB60
	.asciz "state->data->type == GHIFileMemory"
_0211CB83:
	.byte 0x00
aStatePos0: // 0x0211CB84
	.asciz "state->pos >= 0"
aStatePosStateD: // 0x0211CB94
	.asciz "state->pos < state->data->data.fileMemory.len"
_0211CBC2:
	.byte 0x00, 0x00
aStatePosStateS: // 0x0211CBC4
	.asciz "state->pos < state->state.fileDisk.len"
_0211CBEB:
	.byte 0x00
aStatePosIntFte: // 0x0211CBEC
	.asciz "state->pos == (int)ftell(state->state.fileDisk.file)"
_0211CC21:
	.byte 0x00, 0x00, 0x00
aStatePosStateD_0: // 0x0211CC24
	.asciz "state->pos < state->data->data.string.len"
_0211CC4E:
	.byte 0x00, 0x00
aAbcdefghijklmn: // 0x0211CC50
	.asciz "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_@-.*"
aC1616: // 0x0211CC94
	.asciz "(c / 16) < 16"
_0211CCA2:
	.byte 0x00, 0x00
a0123456789abcd_1: // 0x0211CCA4
	.asciz "0123456789ABCDEF"
_0211CCB5:
	.byte 0x00, 0x00, 0x00, 0x70, 0x6F, 0x73, 0x74, 0x00, 0x00, 0x00, 0x00
aQr4g823s23d7d1_2: // 0x0211CCC0
	.asciz "--Qr4G823s23d---<<><><<<>--7d118e0536"
_0211CCE6:
	.byte 0x00, 0x00
aState: // 0x0211CCE8
	.asciz "state"
_0211CCEE:
	.byte 0x00, 0x00
aDataTypeGhistr: // 0x0211CCF0
	.asciz "data->type == GHIString"
_0211CD08:
	.byte 0x00, 0x00, 0x00, 0x00
aMultipartFormD: // 0x0211CD0C
	.asciz "multipart/form-data; boundary=Qr4G823s23d---<<><><<<>--7d118e0536"
_0211CD4E:
	.byte 0x00, 0x00
aApplicationXWw: // 0x0211CD50
	.asciz "application/x-www-form-urlencoded"
_0211CD72:
	.byte 0x00, 0x00, 0x0D, 0x0A, 0x0D, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x0A, 0x00, 0x00
aLocation: // 0x0211CD80
	.asciz "Location:"
_0211CD8A:
	.byte 0x00, 0x00
aHttpSDS: // 0x0211CD8C
	.asciz "http://%s:%d%s"
_0211CD9B:
	.byte 0x00
aContentLength_1: // 0x0211CD9C
	.asciz "Content-Length:"
aTransferEncodi: // 0x0211CDAC
	.asciz "Transfer-Encoding: chunked"
_0211CDC7:
	.byte 0x00
aConnection_5: // 0x0211CDC8
	.asciz "connection"
_0211CDD3:
	.byte 0x00
aGhttpprocessC: // 0x0211CDD4
	.asciz "ghttpProcess.c"
_0211CDE3:
	.byte 0x00, 0x64, 0x61, 0x74, 0x61, 0x00, 0x00, 0x00, 0x00
aLen0: // 0x0211CDEC
	.asciz "len > 0"
_0211CDF4:
	.byte 0x30, 0x00, 0x00, 0x00
aLen0_0: // 0x0211CDF8
	.asciz "len >= 0"
_0211CE01:
	.byte 0x00, 0x00, 0x00, 0x6C, 0x65, 0x6E, 0x00, 0x25, 0x78, 0x00, 0x00, 0x0D, 0x0A, 0x00, 0x00
aConnectionRecv: // 0x0211CE10
	.asciz "connection->recvBuffer.len > 0"
_0211CE2F:
	.byte 0x00
aHttpDDDN: // 0x0211CE30
	.asciz "HTTP/%d.%d %d%n"
aConnectionComp_0: // 0x0211CE40
	.asciz "connection->completed && connection->result"
aPost_0: // 0x0211CE6C
	.asciz "POST "
_0211CE72:
	.byte 0x00, 0x00
aHead: // 0x0211CE74
	.asciz "HEAD "
_0211CE7A:
	.byte 0x00, 0x00, 0x47, 0x45, 0x54, 0x20
	.byte 0x00, 0x00, 0x00, 0x00
aHttp11: // 0x0211CE84
	.asciz " HTTP/1.1\r\n"
_0211CE90:
	.byte 0x48, 0x6F, 0x73, 0x74, 0x00, 0x00, 0x00, 0x00
aHost_0: // 0x0211CE98
	.asciz "Host: "
_0211CE9F:
	.byte 0x00
aUserAgent_0: // 0x0211CEA0
	.asciz "User-Agent"
_0211CEAB:
	.byte 0x00
aGamespyhttp10: // 0x0211CEAC
	.asciz "GameSpyHTTP/1.0"
aConnection_6: // 0x0211CEBC
	.asciz "Connection"
_0211CEC7:
	.byte 0x00
aKeepAlive: // 0x0211CEC8
	.asciz "Keep-Alive"
_0211CED3:
	.byte 0x00
aClose_0: // 0x0211CED4
	.asciz "close"
_0211CEDA:
	.byte 0x00, 0x00, 0x25, 0x64, 0x00, 0x00
aContentLength_2: // 0x0211CEE0
	.asciz "Content-Length"
_0211CEEF:
	.byte 0x00
aContentType: // 0x0211CEF0
	.asciz "Content-Type"
_0211CEFD:
	.byte 0x00, 0x00, 0x00
aHttps_0: // 0x0211CF00
	.asciz "https://"
_0211CF09:
	.byte 0x00, 0x00, 0x00
aConnectionUrl: // 0x0211CF0C
	.asciz "connection->URL"
aHttp_0: // 0x0211CF1C
	.asciz "http://"
_0211CF24:
	.byte 0x3A, 0x2F, 0x00, 0x00, 0x2F, 0x00, 0x00, 0x00
aTheConnectionH: // 0x0211CF2C
	.asciz "The connection has already been disconnected."
_0211CF5A:
	.byte 0x00, 0x00
aSesskey: // 0x0211CF5C
	.asciz "\\sesskey\\"
_0211CF66:
	.byte 0x00, 0x00
aFinal: // 0x0211CF68
	.asciz "\\final\\"
aNoCallback: // 0x0211CF70
	.asciz "No callback."
_0211CF7D:
	.byte 0x00, 0x00, 0x00
aInvalidMessage: // 0x0211CF80
	.asciz "Invalid message."
_0211CF91:
	.byte 0x00, 0x00, 0x00
aInvalidStatuss: // 0x0211CF94
	.asciz "Invalid statusString."
_0211CFAA:
	.byte 0x00, 0x00
aInvalidLocatio: // 0x0211CFAC
	.asciz "Invalid locationString."
aStatus: // 0x0211CFC4
	.asciz "\\status\\"
_0211CFCD:
	.byte 0x00, 0x00, 0x00
aStatstring: // 0x0211CFD0
	.asciz "\\statstring\\"
_0211CFDD:
	.byte 0x00, 0x00, 0x00
aLocstring: // 0x0211CFE0
	.asciz "\\locstring\\"
aInvalidStatus: // 0x0211CFEC
	.asciz "Invalid status."
aInvalidIndex: // 0x0211CFFC
	.asciz "Invalid index."
_0211D00B:
	.byte 0x00
aBuddystatus: // 0x0211D00C
	.asciz "buddyStatus"
_0211D018:
	.byte 0x67, 0x70, 0x2E, 0x63, 0x00, 0x00, 0x00, 0x00
aInvalidReason: // 0x0211D020
	.asciz "Invalid reason."
aAddbuddy: // 0x0211D030
	.asciz "\\addbuddy\\"
_0211D03B:
	.byte 0x00
aNewprofileid: // 0x0211D03C
	.asciz "\\newprofileid\\"
_0211D04B:
	.byte 0x00
aReason: // 0x0211D04C
	.asciz "\\reason\\"
_0211D055:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
aInvalidFunc: // 0x0211D05C
	.asciz "Invalid func."
_0211D06A:
	.byte 0x00, 0x00
aIconnectionCon: // 0x0211D06C
	.asciz "(iconnection->connectState == GPI_NOT_CONNECTED) || (iconnection->connectState == GPI_CONNECTING) || (iconnection->connectState == GPI_NEGOTIATING) || (iconnection->connectState == GPI_CONNECTED) || (iconnection->connectState == GPI_DISCONNECTED)"
_0211D163:
	.byte 0x00
aGpiC: // 0x0211D164
	.asciz "gpi.c"
_0211D16A:
	.byte 0x00, 0x00, 0x30, 0x00, 0x00, 0x00
	.byte 0x43, 0x4D, 0x00, 0x00
aThereWasAnErro: // 0x0211D174
	.asciz "There was an error reading from the server."
aFinal_0: // 0x0211D1A0
	.asciz "\\final\\"
aCmdS: // 0x0211D1A8
	.asciz "CMD: %s\n"
_0211D1B1:
	.byte 0x00, 0x00, 0x00
aOutOfMemory: // 0x0211D1B4
	.asciz "Out of memory."
_0211D1C3:
	.byte 0x00, 0x5C, 0x69, 0x64, 0x5C, 0x00, 0x00, 0x00, 0x00
aNoMatchingOper: // 0x0211D1CC
	.asciz "No matching operation found for id %d\n"
_0211D1F3:
	.byte 0x00, 0x5C, 0x62, 0x6D, 0x5C, 0x00, 0x00, 0x00, 0x00, 0x5C, 0x6B, 0x61, 0x5C
	.byte 0x00, 0x00, 0x00, 0x00
aReceivedAnUnre: // 0x0211D204
	.asciz "Received an unrecognized, unsolicited message.\n"
aTheServerHasCl: // 0x0211D234
	.asciz "The server has closed the connection."
_0211D25A:
	.byte 0x00, 0x00
aGpiinitialize: // 0x0211D25C
	.asciz "\n\n\n\n\n*************\ngpiInitialize\n"
_0211D27E:
	.byte 0x00, 0x00
aInvalidProfile: // 0x0211D280
	.asciz "Invalid profile."
_0211D291:
	.byte 0x00, 0x00, 0x00
aDelbuddy: // 0x0211D294
	.asciz "\\delbuddy\\"
_0211D29F:
	.byte 0x00
aSesskey_0: // 0x0211D2A0
	.asciz "\\sesskey\\"
_0211D2AA:
	.byte 0x00, 0x00
aDelprofileid: // 0x0211D2AC
	.asciz "\\delprofileid\\"
_0211D2BB:
	.byte 0x00
aFinal_1: // 0x0211D2BC
	.asciz "\\final\\"
aIndex0: // 0x0211D2C4
	.asciz "index >= 0"
_0211D2CF:
	.byte 0x00
aGpibuddyC: // 0x0211D2D0
	.asciz "gpiBuddy.c"
_0211D2DB:
	.byte 0x00
aIconnectionPro: // 0x0211D2DC
	.asciz "iconnection->profileList.numBuddies >= 0"
_0211D305:
	.byte 0x00, 0x00, 0x00, 0x5C, 0x62, 0x6D, 0x5C, 0x00, 0x00, 0x00, 0x00
	.byte 0x5C, 0x74, 0x5C, 0x00
aMsg: // 0x0211D314
	.asciz "\\msg\\"
_0211D31A:
	.byte 0x00, 0x00
aUnexpectedData: // 0x0211D31C
	.asciz "Unexpected data was received from the server."
_0211D34A:
	.byte 0x00, 0x00, 0x5C, 0x66, 0x5C, 0x00
aDate_0: // 0x0211D350
	.asciz "\\date\\"
_0211D357:
	.byte 0x00
aOutOfMemory_0: // 0x0211D358
	.asciz "Out of memory."
_0211D367:
	.byte 0x00
aSigned: // 0x0211D368
	.asciz "|signed|"
_0211D371:
	.byte 0x00, 0x00, 0x00, 0x7C, 0x73, 0x7C, 0x00, 0x7C, 0x73, 0x73, 0x7C, 0x00, 0x00, 0x00, 0x00
	.byte 0x7C, 0x6C, 0x73, 0x7C, 0x00, 0x00, 0x00, 0x00, 0x7C, 0x69, 0x70, 0x7C, 0x00, 0x00, 0x00, 0x00
	.byte 0x7C, 0x70, 0x7C, 0x00, 0x7C, 0x6C, 0x7C, 0x00, 0x31, 0x00, 0x00, 0x00
aAuthadd: // 0x0211D39C
	.asciz "\\authadd\\"
_0211D3A6:
	.byte 0x00, 0x00
aFromprofileid: // 0x0211D3A8
	.asciz "\\fromprofileid\\"
aSig: // 0x0211D3B8
	.asciz "\\sig\\"
_0211D3BE:
	.byte 0x00, 0x00
aMsg_0: // 0x0211D3C0
	.asciz "\\msg\\"
_0211D3C6:
	.byte 0x00, 0x00, 0x5C, 0x6D, 0x5C, 0x00
aLen_0: // 0x0211D3CC
	.asciz "\\len\\"
_0211D3D2:
	.byte 0x00, 0x00
aOutputbufferNu: // 0x0211D3D4
	.asciz "outputBuffer != NULL"
_0211D3E9:
	.byte 0x00, 0x00, 0x00
aGpibufferC: // 0x0211D3EC
	.asciz "gpiBuffer.c"
aLen0_1: // 0x0211D3F8
	.asciz "len >= 0"
_0211D401:
	.byte 0x00, 0x00, 0x00
aPos0: // 0x0211D404
	.asciz "pos >= 0"
_0211D40D:
	.byte 0x00, 0x00, 0x00
aPosLen: // 0x0211D410
	.asciz "pos <= len"
_0211D41B:
	.byte 0x00
aSockInvalidSoc: // 0x0211D41C
	.asciz "sock != INVALID_SOCKET"
_0211D433:
	.byte 0x00
aInputbufferNul: // 0x0211D434
	.asciz "inputBuffer != NULL"
aBytesreadNull: // 0x0211D448
	.asciz "bytesRead != NULL"
_0211D45A:
	.byte 0x00, 0x00
aConnclosedNull: // 0x0211D45C
	.asciz "connClosed != NULL"
_0211D46F:
	.byte 0x00
aOutOfMemory_1: // 0x0211D470
	.asciz "Out of memory."
_0211D47F:
	.byte 0x00
aThereWasAnErro_0: // 0x0211D480
	.asciz "There was an error reading from a socket."
_0211D4AA:
	.byte 0x00, 0x00
aRecvxxxxSConne: // 0x0211D4AC
	.asciz "RECVXXXX(%s): Connection closed\n"
_0211D4CD:
	.byte 0x00, 0x00, 0x00
aRecvtotlSD: // 0x0211D4D0
	.asciz "RECVTOTL(%s): %d\n"
_0211D4E2:
	.byte 0x00, 0x00, 0x25, 0x64, 0x00, 0x00
aPeerOutputbuff: // 0x0211D4E8
	.asciz "peer->outputBuffer.buffer != NULL"
_0211D50A:
	.byte 0x00, 0x00, 0x50, 0x54, 0x00, 0x00
aThereWasAnErro_1: // 0x0211D510
	.asciz "There was an error sending on a socket."
aSendxxxxSConne: // 0x0211D538
	.asciz "SENDXXXX(%s): Connection closed\n"
_0211D559:
	.byte 0x00, 0x00, 0x00
aStringNull: // 0x0211D55C
	.asciz "string != NULL"
_0211D56B:
	.byte 0x00
aStringlen0: // 0x0211D56C
	.asciz "stringLen >= 0"
_0211D57B:
	.byte 0x00
aDataCallbackCa: // 0x0211D57C
	.asciz "data->callback.callback != NULL"
aGpicallbackC: // 0x0211D59C
	.asciz "gpiCallback.c"
_0211D5AA:
	.byte 0x00, 0x00
aDataArgNull: // 0x0211D5AC
	.asciz "data->arg != NULL"
_0211D5BE:
	.byte 0x00, 0x00
aOutOfMemory_2: // 0x0211D5C0
	.asciz "Out of memory."
_0211D5CF:
	.byte 0x00
aIconnectionNul: // 0x0211D5D0
	.asciz "iconnection != NULL"
aResultGpNoErro: // 0x0211D5E4
	.asciz "result != GP_NO_ERROR"
_0211D5FA:
	.byte 0x00, 0x00
aFatalGpFatalFa: // 0x0211D5FC
	.asciz "(fatal == GP_FATAL) || (fatal == GP_NON_FATAL)"
_0211D62B:
	.byte 0x00
aGpcmGsNintendo: // 0x0211D62C
	.asciz "gpcm.gs.nintendowifi.net"
_0211D645:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
aLogoutSesskey: // 0x0211D66C
	.asciz "\\logout\\\\sesskey\\"
_0211D67E:
	.byte 0x00, 0x00
aFinal_2: // 0x0211D680
	.asciz "\\final\\"
_0211D688:
	.byte 0x43, 0x4D, 0x00, 0x00
aTheServerHasRe: // 0x0211D68C
	.asciz "The server has refused the connection."
_0211D6B3:
	.byte 0x00
aStateGpiConnec: // 0x0211D6B4
	.asciz "state == GPI_CONNECTED"
_0211D6CB:
	.byte 0x00
aGpiconnectC: // 0x0211D6CC
	.asciz "gpiConnect.c"
_0211D6D9:
	.byte 0x00, 0x00, 0x00
aPid_0: // 0x0211D6DC
	.asciz "\\pid\\"
_0211D6E2:
	.byte 0x00, 0x00
aFatal: // 0x0211D6E4
	.asciz "\\fatal\\"
aLc1: // 0x0211D6EC
	.asciz "\\lc\\1"
_0211D6F2:
	.byte 0x00, 0x00
aUnexpectedData_0: // 0x0211D6F4
	.asciz "Unexpected data was received from the server."
_0211D722:
	.byte 0x00, 0x00
aChallenge_0: // 0x0211D724
	.asciz "\\challenge\\"
aNur: // 0x0211D730
	.asciz "\\nur\\"
_0211D736:
	.byte 0x00, 0x00
aUserid_0: // 0x0211D738
	.asciz "\\userid\\"
_0211D741:
	.byte 0x00, 0x00, 0x00
aUnexepectedDat: // 0x0211D744
	.asciz "Unexepected data was received from the server."
_0211D773:
	.byte 0x00
aProfileid: // 0x0211D774
	.asciz "\\profileid\\"
aLc2: // 0x0211D780
	.asciz "\\lc\\2"
_0211D786:
	.byte 0x00, 0x00
aSesskey_1: // 0x0211D788
	.asciz "\\sesskey\\"
_0211D792:
	.byte 0x00, 0x00
aUniquenick: // 0x0211D794
	.asciz "\\uniquenick\\"
_0211D7A1:
	.byte 0x00, 0x00, 0x00, 0x5C, 0x6C, 0x74, 0x5C, 0x00, 0x00, 0x00, 0x00
aSS_0: // 0x0211D7AC
	.asciz "%s@%s"
_0211D7B2:
	.byte 0x00, 0x00
aSSSSSS: // 0x0211D7B4
	.asciz "%s%s%s%s%s%s"
_0211D7C1:
	.byte 0x00, 0x00, 0x00
asc_211D7C4: // 0x0211D7C4
	.asciz "                                                "
_0211D7F5:
	.byte 0x00, 0x00, 0x00
aProof: // 0x0211D7F8
	.asciz "\\proof\\"
aCouldNotAuthen: // 0x0211D800
	.asciz "Could not authenticate server."
_0211D81F:
	.byte 0x00
aOutOfMemory_3: // 0x0211D820
	.asciz "Out of memory."
_0211D82F:
	.byte 0x00
aNewuser: // 0x0211D830
	.asciz "\\newuser\\"
_0211D83A:
	.byte 0x00, 0x00
aEmail: // 0x0211D83C
	.asciz "\\email\\"
aNick: // 0x0211D844
	.asciz "\\nick\\"
_0211D84B:
	.byte 0x00
aPasswordenc: // 0x0211D84C
	.asciz "\\passwordenc\\"
_0211D85A:
	.byte 0x00, 0x00
aProductid: // 0x0211D85C
	.asciz "\\productid\\"
aGamename: // 0x0211D868
	.asciz "\\gamename\\"
_0211D873:
	.byte 0x00
aNamespaceid: // 0x0211D874
	.asciz "\\namespaceid\\"
_0211D882:
	.byte 0x00, 0x00
aCdkeyenc: // 0x0211D884
	.asciz "\\cdkeyenc\\"
_0211D88F:
	.byte 0x00
aId1: // 0x0211D890
	.asciz "\\id\\1"
_0211D896:
	.byte 0x00, 0x00
aLogin_0: // 0x0211D898
	.asciz "\\login\\"
aAuthtoken: // 0x0211D8A0
	.asciz "\\authtoken\\"
aUser: // 0x0211D8AC
	.asciz "\\user\\"
_0211D8B3:
	.byte 0x00, 0x40, 0x00, 0x00, 0x00
aResponse: // 0x0211D8B8
	.asciz "\\response\\"
_0211D8C3:
	.byte 0x00
aFirewall1: // 0x0211D8C4
	.asciz "\\firewall\\1"
aPort: // 0x0211D8D0
	.asciz "\\port\\"
_0211D8D7:
	.byte 0x00
aInvalidConnect: // 0x0211D8D8
	.asciz "Invalid connection."
aInvalidFirewal: // 0x0211D8EC
	.asciz "Invalid firewall."
_0211D8FE:
	.byte 0x00, 0x00
aThereWasAnErro_2: // 0x0211D900
	.asciz "There was an error creating a socket."
_0211D926:
	.byte 0x00, 0x00
aThereWasAnErro_3: // 0x0211D928
	.asciz "There was an error making a socket non-blocking."
_0211D959:
	.byte 0x00, 0x00, 0x00
aThereWasAnErro_4: // 0x0211D95C
	.asciz "There was an error binding a socket."
_0211D981:
	.byte 0x00, 0x00, 0x00
aThereWasAnErro_5: // 0x0211D984
	.asciz "There was an error listening on a socket."
_0211D9AE:
	.byte 0x00, 0x00
aThereWasAnErro_6: // 0x0211D9B0
	.asciz "There was an error getting a socket's addres."
_0211D9DE:
	.byte 0x00, 0x00
aCouldNotResolv: // 0x0211D9E0
	.asciz "Could not resolve connection mananger host name."
_0211DA11:
	.byte 0x00, 0x00, 0x00
aAddressSinAddr: // 0x0211DA14
	.asciz "address.sin_addr.s_addr != 0"
_0211DA31:
	.byte 0x00, 0x00, 0x00
aThereWasAnErro_7: // 0x0211DA34
	.asciz "There was an error connecting a socket."
aAbcdefghijklmn_0: // 0x0211DA5C
	.asciz "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
_0211DA9B:
	.byte 0x00
aOutOfMemory_4: // 0x0211DA9C
	.asciz "Out of memory."
_0211DAAB:
	.byte 0x00
aGetprofileSess: // 0x0211DAAC
	.asciz "\\getprofile\\\\sesskey\\"
_0211DAC2:
	.byte 0x00, 0x00
aProfileid_0: // 0x0211DAC4
	.asciz "\\profileid\\"
_0211DAD0:
	.byte 0x5C, 0x69, 0x64, 0x5C, 0x00, 0x00, 0x00, 0x00
aFinal_3: // 0x0211DAD8
	.asciz "\\final\\"
_0211DAE0:
	.byte 0x25, 0x64, 0x00, 0x00
aInvalidInfo: // 0x0211DAE4
	.asciz "Invalid info."
_0211DAF2:
	.byte 0x00, 0x00
aBirthday: // 0x0211DAF4
	.asciz "\\birthday\\"
_0211DAFF:
	.byte 0x00
aInvalidValue: // 0x0211DB00
	.asciz "Invalid value."
_0211DB0F:
	.byte 0x00
aNick_0: // 0x0211DB10
	.asciz "\\nick\\"
_0211DB17:
	.byte 0x00
aUniquenick_0: // 0x0211DB18
	.asciz "\\uniquenick\\"
_0211DB25:
	.byte 0x00, 0x00, 0x00
aEmail_0: // 0x0211DB28
	.asciz "\\email\\"
aPassword: // 0x0211DB30
	.asciz "\\password\\"
_0211DB3B:
	.byte 0x00
aFirstname: // 0x0211DB3C
	.asciz "\\firstname\\"
aLastname: // 0x0211DB48
	.asciz "\\lastname\\"
_0211DB53:
	.byte 0x00
aHomepage: // 0x0211DB54
	.asciz "\\homepage\\"
_0211DB5F:
	.byte 0x00
aZipcode: // 0x0211DB60
	.asciz "\\zipcode\\"
_0211DB6A:
	.byte 0x00, 0x00
aInvalidCountry: // 0x0211DB6C
	.asciz "Invalid countrycode."
_0211DB81:
	.byte 0x00, 0x00, 0x00
aCountrycode: // 0x0211DB84
	.asciz "\\countrycode\\"
_0211DB92:
	.byte 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x31, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00
aSex: // 0x0211DBA0
	.asciz "\\sex\\"
_0211DBA6:
	.byte 0x00, 0x00
aIcquin: // 0x0211DBA8
	.asciz "\\icquin\\"
_0211DBB1:
	.byte 0x00, 0x00, 0x00
aVideocard1stri: // 0x0211DBB4
	.asciz "\\videocard1string\\"
_0211DBC7:
	.byte 0x00
aVideocard2stri: // 0x0211DBC8
	.asciz "\\videocard2string\\"
_0211DBDB:
	.byte 0x00
aOsstring: // 0x0211DBDC
	.asciz "\\osstring\\"
_0211DBE7:
	.byte 0x00
aAim: // 0x0211DBE8
	.asciz "\\aim\\"
_0211DBEE:
	.byte 0x00, 0x00
aPic: // 0x0211DBF0
	.asciz "\\pic\\"
_0211DBF6:
	.byte 0x00, 0x00
aOcc: // 0x0211DBF8
	.asciz "\\occ\\"
_0211DBFE:
	.byte 0x00, 0x00
aInd: // 0x0211DC00
	.asciz "\\ind\\"
_0211DC06:
	.byte 0x00, 0x00
aInc: // 0x0211DC08
	.asciz "\\inc\\"
_0211DC0E:
	.byte 0x00, 0x00
aMar: // 0x0211DC10
	.asciz "\\mar\\"
_0211DC16:
	.byte 0x00, 0x00
aChc: // 0x0211DC18
	.asciz "\\chc\\"
_0211DC1E:
	.byte 0x00, 0x00
	.byte 0x5C, 0x69, 0x31, 0x5C, 0x00, 0x00, 0x00, 0x00
aInvalidZipcode: // 0x0211DC28
	.asciz "Invalid zipcode."
_0211DC39:
	.byte 0x00, 0x00, 0x00
aInvalidSex: // 0x0211DC3C
	.asciz "Invalid sex."
_0211DC49:
	.byte 0x00, 0x00, 0x00
aCpubrandid: // 0x0211DC4C
	.asciz "\\cpubrandid\\"
_0211DC59:
	.byte 0x00, 0x00, 0x00
aCpuspeed: // 0x0211DC5C
	.asciz "\\cpuspeed\\"
_0211DC67:
	.byte 0x00
aMemory: // 0x0211DC68
	.asciz "\\memory\\"
_0211DC71:
	.byte 0x00, 0x00, 0x00
aVideocard1ram: // 0x0211DC74
	.asciz "\\videocard1ram\\"
aVideocard2ram: // 0x0211DC84
	.asciz "\\videocard2ram\\"
aConnectionid: // 0x0211DC94
	.asciz "\\connectionid\\"
_0211DCA3:
	.byte 0x00
aConnectionspee: // 0x0211DCA4
	.asciz "\\connectionspeed\\"
_0211DCB6:
	.byte 0x00, 0x00
aHasnetwork: // 0x0211DCB8
	.asciz "\\hasnetwork\\"
_0211DCC5:
	.byte 0x00, 0x00, 0x00
aUpdateproSessk: // 0x0211DCC8
	.asciz "\\updatepro\\\\sesskey\\"
_0211DCDD:
	.byte 0x00, 0x00, 0x00
aUpdateuiSesske: // 0x0211DCE0
	.asciz "\\updateui\\\\sesskey\\"
_0211DCF4:
	.byte 0x5C, 0x70, 0x69, 0x5C, 0x00, 0x00, 0x00, 0x00
aUnexpectedData_1: // 0x0211DCFC
	.asciz "Unexpected data was received from the server."
_0211DD2A:
	.byte 0x00, 0x00
aProfileid0: // 0x0211DD2C
	.asciz "profileid > 0"
_0211DD3A:
	.byte 0x00, 0x00
aGpiinfoC: // 0x0211DD3C
	.asciz "gpiInfo.c"
_0211DD46:
	.byte 0x00, 0x00
aLon: // 0x0211DD48
	.asciz "\\lon\\"
_0211DD4E:
	.byte 0x00, 0x00
aLat: // 0x0211DD50
	.asciz "\\lat\\"
_0211DD56:
	.byte 0x00, 0x00
aLoc: // 0x0211DD58
	.asciz "\\loc\\"
_0211DD5E:
	.byte 0x00, 0x00
aPmask: // 0x0211DD60
	.asciz "\\pmask\\"
_0211DD68:
	.byte 0x5C, 0x6F, 0x31, 0x5C, 0x00, 0x00, 0x00, 0x00
aConn: // 0x0211DD70
	.asciz "\\conn\\"
_0211DD77:
	.byte 0x00
aSig_0: // 0x0211DD78
	.asciz "\\sig\\"
_0211DD7E:
	.byte 0x00, 0x00
aGpiisvaliddate: // 0x0211DD80
	.asciz "gpiIsValidDate(d, m, y)"
aInvalidDate: // 0x0211DD98
	.asciz "Invalid date."
_0211DDA6:
	.byte 0x00, 0x00
aGpiprocessoper: // 0x0211DDA8
	.asciz "gpiProcessOperation was passed an operation with an invalid type (%d)\n"
_0211DDEF:
	.byte 0x00
	.byte 0x30, 0x00, 0x00, 0x00
aGpioperationC: // 0x0211DDF4
	.asciz "gpiOperation.c"
_0211DE03:
	.byte 0x00
aIconnectionNum: // 0x0211DE04
	.asciz "iconnection->numSearches >= 0"
_0211DE22:
	.byte 0x00, 0x00
aOutOfMemory_5: // 0x0211DE24
	.asciz "Out of memory."
_0211DE33:
	.byte 0x00
aConnectionNull: // 0x0211DE34
	.asciz "connection != NULL"
_0211DE47:
	.byte 0x00
aConnectionNull_0: // 0x0211DE48
	.asciz "*connection != NULL"
aOperationNull: // 0x0211DE5C
	.asciz "operation != NULL"
_0211DE6E:
	.byte 0x00, 0x00
aPeerNull: // 0x0211DE70
	.asciz "peer != NULL"
_0211DE7D:
	.byte 0x00, 0x00, 0x00
aGpipeerC: // 0x0211DE80
	.asciz "gpiPeer.c"
_0211DE8A:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
aLenDMsg: // 0x0211DE90
	.asciz "\\len\\%d\\msg\\\n"
_0211DE9E:
	.byte 0x00, 0x00
aTransferid: // 0x0211DEA0
	.asciz "transferID"
_0211DEAB:
	.byte 0x00
aMDXferDUU: // 0x0211DEAC
	.asciz "\\m\\%d\\xfer\\%d %u %u"
aMessageNull: // 0x0211DEC0
	.asciz "message != NULL"
_0211DED0:
	.byte 0x5C, 0x6D, 0x5C, 0x00
aLen_1: // 0x0211DED4
	.asciz "\\len\\"
_0211DEDA:
	.byte 0x00, 0x00
aMsg_1: // 0x0211DEDC
	.asciz "\\msg\\\n"
_0211DEE3:
	.byte 0x00
aErrorConnectin: // 0x0211DEE4
	.asciz "Error connecting to a peer."
aThereWasAnErro_8: // 0x0211DF00
	.asciz "There was an error creating a socket."
_0211DF26:
	.byte 0x00, 0x00
aThereWasAnErro_9: // 0x0211DF28
	.asciz "There was an error making a socket non-blocking."
_0211DF59:
	.byte 0x00, 0x00, 0x00
aThereWasAnErro_10: // 0x0211DF5C
	.asciz "There was an error connecting a socket."
_0211DF84:
	.byte 0x30, 0x00, 0x00, 0x00
aTriedToRemoveP: // 0x0211DF88
	.asciz "Tried to remove peer not in list."
_0211DFAA:
	.byte 0x00, 0x00
aPeerStateGpiPe: // 0x0211DFAC
	.asciz "peer->state != GPI_PEER_NOT_CONNECTED"
_0211DFD2:
	.byte 0x00, 0x00, 0x50, 0x52, 0x00, 0x00
aOutOfMemory_6: // 0x0211DFD8
	.asciz "Out of memory."
_0211DFE7:
	.byte 0x00, 0x31, 0x00, 0x00, 0x00
aPeerStateGpiPe_0: // 0x0211DFEC
	.asciz "peer->state == GPI_PEER_WAITING"
aFinal_4: // 0x0211E00C
	.asciz "\\final\\"
aAuth: // 0x0211E014
	.asciz "\\auth\\"
_0211E01B:
	.byte 0x00
aPid_1: // 0x0211E01C
	.asciz "\\pid\\"
_0211E022:
	.byte 0x00, 0x00
aNick_1: // 0x0211E024
	.asciz "\\nick\\"
_0211E02B:
	.byte 0x00
aSig_1: // 0x0211E02C
	.asciz "\\sig\\"
_0211E032:
	.byte 0x00, 0x00
aSDD: // 0x0211E034
	.asciz "%s%d%d"
_0211E03B:
	.byte 0x00
aAnack: // 0x0211E03C
	.asciz "\\anack\\"
aAack: // 0x0211E044
	.asciz "\\aack\\"
_0211E04B:
	.byte 0x00
aErrorGettingBu: // 0x0211E04C
	.asciz "Error getting buddy authorization."
_0211E06F:
	.byte 0x00
aErrorParsingBu: // 0x0211E070
	.asciz "Error parsing buddy message."
_0211E08D:
	.byte 0x00, 0x00, 0x00
aId0: // 0x0211E090
	.asciz "id > 0"
_0211E097:
	.byte 0x00
aGpiprofileC: // 0x0211E098
	.asciz "gpiProfile.c"
_0211E0A5:
	.byte 0x00, 0x00, 0x00
aNpr: // 0x0211E0A8
	.asciz "\\npr\\"
_0211E0AE:
	.byte 0x00, 0x00
aUnexpectedData_2: // 0x0211E0B0
	.asciz "Unexpected data was received from the server."
_0211E0DE:
	.byte 0x00, 0x00
aProfileid_1: // 0x0211E0E0
	.asciz "\\profileid\\"
aOutOfMemory_7: // 0x0211E0EC
	.asciz "Out of memory."
_0211E0FB:
	.byte 0x00
aGpspGsNintendo: // 0x0211E0FC
	.asciz "gpsp.gs.nintendowifi.net"
_0211E115:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
aOutOfMemory_8: // 0x0211E13C
	.asciz "Out of memory."
_0211E14B:
	.byte 0x00
aNumIconnection: // 0x0211E14C
	.asciz "num < iconnection->numSearches"
_0211E16B:
	.byte 0x00
aGpisearchC: // 0x0211E16C
	.asciz "gpiSearch.c"
_0211E178:
	.byte 0x53, 0x4D, 0x00, 0x00
aCouldNotConnec: // 0x0211E17C
	.asciz "Could not connect to the search manager."
_0211E1A5:
	.byte 0x00, 0x00, 0x00
aSearch: // 0x0211E1A8
	.asciz "\\search\\"
_0211E1B1:
	.byte 0x00, 0x00, 0x00
aSesskey_2: // 0x0211E1B4
	.asciz "\\sesskey\\"
_0211E1BE:
	.byte 0x00, 0x00
aProfileid_2: // 0x0211E1C0
	.asciz "\\profileid\\"
aNamespaceid_0: // 0x0211E1CC
	.asciz "\\namespaceid\\"
_0211E1DA:
	.byte 0x00, 0x00
aNick_2: // 0x0211E1DC
	.asciz "\\nick\\"
_0211E1E3:
	.byte 0x00
aUniquenick_1: // 0x0211E1E4
	.asciz "\\uniquenick\\"
_0211E1F1:
	.byte 0x00, 0x00, 0x00
aEmail_1: // 0x0211E1F4
	.asciz "\\email\\"
aFirstname_0: // 0x0211E1FC
	.asciz "\\firstname\\"
aLastname_0: // 0x0211E208
	.asciz "\\lastname\\"
_0211E213:
	.byte 0x00
aIcquin_0: // 0x0211E214
	.asciz "\\icquin\\"
_0211E21D:
	.byte 0x00, 0x00, 0x00
aSkip: // 0x0211E220
	.asciz "\\skip\\"
_0211E227:
	.byte 0x00
aValid: // 0x0211E228
	.asciz "\\valid\\"
aNicks: // 0x0211E230
	.asciz "\\nicks\\"
aPass: // 0x0211E238
	.asciz "\\pass\\"
_0211E23F:
	.byte 0x00
aPmatch: // 0x0211E240
	.asciz "\\pmatch\\"
_0211E249:
	.byte 0x00, 0x00, 0x00
aProductid_0: // 0x0211E24C
	.asciz "\\productid\\"
aCheck: // 0x0211E258
	.asciz "\\check\\"
aNewuser_0: // 0x0211E260
	.asciz "\\newuser\\"
_0211E26A:
	.byte 0x00, 0x00
aProductid_1: // 0x0211E26C
	.asciz "\\productID\\"
aCdkey: // 0x0211E278
	.asciz "\\cdkey\\"
aOthers: // 0x0211E280
	.asciz "\\others\\"
_0211E289:
	.byte 0x00, 0x00, 0x00
aUniquesearch: // 0x0211E28C
	.asciz "\\uniquesearch\\"
_0211E29B:
	.byte 0x00
aPreferrednick: // 0x0211E29C
	.asciz "\\preferrednick\\"
_0211E2AC:
	.byte 0x30, 0x00, 0x00, 0x00
aGamename_0: // 0x0211E2B0
	.asciz "\\gamename\\"
_0211E2BB:
	.byte 0x00
aFinal_5: // 0x0211E2BC
	.asciz "\\final\\"
aThereWasAnErro_11: // 0x0211E2C4
	.asciz "There was an error reading from the server."
aBsrdone: // 0x0211E2F0
	.asciz "bsrdone"
_0211E2F8:
	.byte 0x6D, 0x6F, 0x72, 0x65, 0x00, 0x00, 0x00, 0x00
	.byte 0x62, 0x73, 0x72, 0x00, 0x6E, 0x69, 0x63, 0x6B, 0x00, 0x00, 0x00, 0x00
aUniquenick_2: // 0x0211E30C
	.asciz "uniquenick"
_0211E317:
	.byte 0x00
aFirstname_1: // 0x0211E318
	.asciz "firstname"
_0211E322:
	.byte 0x00, 0x00
aLastname_1: // 0x0211E324
	.asciz "lastname"
_0211E32D:
	.byte 0x00, 0x00, 0x00
aEmail_2: // 0x0211E330
	.asciz "email"
_0211E336:
	.byte 0x00, 0x00
aErrorReadingFr: // 0x0211E338
	.asciz "Error reading from the search server."
_0211E35E:
	.byte 0x00, 0x00
	.byte 0x76, 0x72, 0x00, 0x00, 0x6E, 0x72, 0x00, 0x00
aNdone: // 0x0211E368
	.asciz "ndone"
_0211E36E:
	.byte 0x00, 0x00
aPsrdone: // 0x0211E370
	.asciz "psrdone"
_0211E378:
	.byte 0x70, 0x73, 0x72, 0x00
aStatus_0: // 0x0211E37C
	.asciz "status"
_0211E383:
	.byte 0x00
aStatuscode: // 0x0211E384
	.asciz "statuscode"
_0211E38F:
	.byte 0x00
	.byte 0x63, 0x75, 0x72, 0x00
aPid_2: // 0x0211E394
	.asciz "\\pid\\"
_0211E39A:
	.byte 0x00, 0x00, 0x6E, 0x75, 0x72, 0x00
aOthers_0: // 0x0211E3A0
	.asciz "others"
_0211E3A7:
	.byte 0x00
aOdone: // 0x0211E3A8
	.asciz "odone"
_0211E3AE:
	.byte 0x00, 0x00
	.byte 0x6F, 0x00, 0x00, 0x00
aFirst: // 0x0211E3B4
	.asciz "first"
_0211E3BA:
	.byte 0x00, 0x00, 0x6C, 0x61, 0x73, 0x74
	.byte 0x00, 0x00, 0x00, 0x00, 0x75, 0x73, 0x00, 0x00
aUsdone: // 0x0211E3C8
	.asciz "usdone"
_0211E3CF:
	.byte 0x00
aCountArgNumsug: // 0x0211E3D0
	.asciz "count == arg->numSuggestedNicks"
aNoSearchCriter: // 0x0211E3F0
	.asciz "No search criteria."
aThereWasAnErro_12: // 0x0211E404
	.asciz "There was an error creating a socket."
_0211E42A:
	.byte 0x00, 0x00
aThereWasAnErro_13: // 0x0211E42C
	.asciz "There was an error making a socket non-blocking."
_0211E45D:
	.byte 0x00, 0x00, 0x00
aCouldNotResolv_0: // 0x0211E460
	.asciz "Could not resolve search mananger host name."
_0211E48D:
	.byte 0x00, 0x00, 0x00
aAddressSinAddr_0: // 0x0211E490
	.asciz "address.sin_addr.s_addr != 0"
_0211E4AD:
	.byte 0x00, 0x00, 0x00
aThereWasAnErro_14: // 0x0211E4B0
	.asciz "There was an error connecting a socket."
aXfer: // 0x0211E4D8
	.asciz "\\xfer\\"
_0211E4DF:
	.byte 0x00
aDUU: // 0x0211E4E0
	.asciz "%d %u %u"
_0211E4E9:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
aVersionDResult: // 0x0211E4F0
	.asciz "\\version\\%d\\result\\%d"
_0211E506:
	.byte 0x00, 0x00, 0x5C, 0x72, 0x6E, 0x5C, 0x00, 0x00, 0x00, 0x00
aUnexpectedData_3: // 0x0211E510
	.asciz "Unexpected data was received from the server."
_0211E53E:
	.byte 0x00, 0x00
aOutOfMemory_9: // 0x0211E540
	.asciz "Out of memory."
_0211E54F:
	.byte 0x00
aBufferNull: // 0x0211E550
	.asciz "buffer != NULL"
_0211E55F:
	.byte 0x00
aGpiutilityC: // 0x0211E560
	.asciz "gpiUtility.c"
_0211E56D:
	.byte 0x00, 0x00, 0x00
aKeyNull: // 0x0211E570
	.asciz "key != NULL"
aValueNull: // 0x0211E57C
	.asciz "value != NULL"
_0211E58A:
	.byte 0x00, 0x00
aParseError: // 0x0211E58C
	.asciz "Parse Error."
_0211E599:
	.byte 0x00, 0x00, 0x00
aErrorConnectin_0: // 0x0211E59C
	.asciz "Error connecting\n"
_0211E5AE:
	.byte 0x00, 0x00
aThereWasAnErro_15: // 0x0211E5B0
	.asciz "There was an error checking for a completed connection."
aConnectionReje: // 0x0211E5E8
	.asciz "Connection rejected\n"
_0211E5FD:
	.byte 0x00, 0x00, 0x00
aConnectionAcce: // 0x0211E600
	.asciz "Connection accepted\n"
_0211E615:
	.byte 0x00, 0x00, 0x00
aCommandNull: // 0x0211E618
	.asciz "command != NULL"
aLen0_2: // 0x0211E628
	.asciz "len > 0"
aError_0: // 0x0211E630
	.asciz "\\error\\"
aErr: // 0x0211E638
	.asciz "\\err\\"
_0211E63E:
	.byte 0x00, 0x00
aErrmsg: // 0x0211E640
	.asciz "\\errmsg\\"
_0211E649:
	.byte 0x00, 0x00, 0x00
aFatal_0: // 0x0211E64C
	.asciz "\\fatal\\"
aDestNull: // 0x0211E654
	.asciz "dest != NULL"
_0211E661:
	.byte 0x00, 0x00, 0x00
aSrcNull: // 0x0211E664
	.asciz "src != NULL"
_0211E670:
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0x78, 0xE6, 0x11, 0x02, 0x00, 0x61, 0x6D, 0x65
aSpy3d: // 0x0211E67C
	.asciz "Spy3D"
_0211E682:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x72, 0x6F, 0x6A
aEctaphex: // 0x0211E68C
	.asciz "ectAphex"
_0211E695:
	.byte 0x00, 0x00, 0x00
aPauthr: // 0x0211E698
	.asciz "\\pauthr\\"
_0211E6A1:
	.byte 0x00, 0x00, 0x00
aGetpidr: // 0x0211E6A4
	.asciz "\\getpidr\\"
_0211E6AE:
	.byte 0x00, 0x00
aGetpdr: // 0x0211E6B0
	.asciz "\\getpdr\\"
_0211E6B9:
	.byte 0x00, 0x00, 0x00
aSetpdr: // 0x0211E6BC
	.asciz "\\setpdr\\"
_0211E6C5:
	.byte 0x00, 0x00, 0x00
aSetpdr_0: // 0x0211E6C8
	.asciz "setpdr"
_0211E6CF:
	.byte 0x00
	.byte 0x70, 0x69, 0x64, 0x00, 0x6C, 0x69, 0x64, 0x00, 0x6D, 0x6F, 0x64, 0x00
aGetpdr_0: // 0x0211E6DC
	.asciz "getpdr"
_0211E6E3:
	.byte 0x00
aLength: // 0x0211E6E4
	.asciz "length"
_0211E6EB:
	.byte 0x00
aData_3: // 0x0211E6EC
	.asciz "\\data\\"
_0211E6F3:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00
aGetpidr_0: // 0x0211E6F8
	.asciz "getpidr"
aPauthr_0: // 0x0211E700
	.asciz "pauthr"
_0211E707:
	.byte 0x00
aErrmsg_0: // 0x0211E708
	.asciz "errmsg"
_0211E70F:
	.byte 0x00
	.byte 0x5C, 0x00, 0x00, 0x00
a3b8dd8995f7c40: // 0x0211E714
	.asciz "3b8dd8995f7c40a9a5c5b7dd5b481341"
_0211E735:
	.byte 0x00, 0x00, 0x00
aBuffer_0: // 0x0211E738
	.asciz "buffer"
_0211E73F:
	.byte 0x00
aGt2authC: // 0x0211E740
	.asciz "gt2Auth.c"
_0211E74A:
	.byte 0x00, 0x00
aStartBufferLen: // 0x0211E74C
	.asciz "start <= buffer->len"
_0211E761:
	.byte 0x00, 0x00, 0x00
aGt2bufferC: // 0x0211E764
	.asciz "gt2Buffer.c"
aShortenbyBuffe: // 0x0211E770
	.asciz "shortenBy <= (buffer->len - start)"
_0211E793:
	.byte 0x00
aBufferLenLenBu: // 0x0211E794
	.asciz "(buffer->len + len) <= buffer->size"
aBufferLen2Buff: // 0x0211E7B8
	.asciz "(buffer->len + 2) <= buffer->size"
_0211E7DA:
	.byte 0x00, 0x00
aBufferLenBuffe: // 0x0211E7DC
	.asciz "buffer->len < buffer->size"
_0211E7F7:
	.byte 0x00
aSocket: // 0x0211E7F8
	.asciz "socket"
_0211E7FF:
	.byte 0x00
aGt2callbackC: // 0x0211E800
	.asciz "gt2Callback.c"
_0211E80E:
	.byte 0x00, 0x00
aConnection_7: // 0x0211E810
	.asciz "connection"
_0211E81B:
	.byte 0x00
aSocketConnecti: // 0x0211E81C
	.asciz "socket && connection"
_0211E831:
	.byte 0x00, 0x00, 0x00
aConnection_8: // 0x0211E834
	.asciz "connection"
_0211E83F:
	.byte 0x00
aGt2mainC: // 0x0211E840
	.asciz "gt2Main.c"
_0211E84A:
	.byte 0x00, 0x00, 0xFE, 0xFE, 0x00, 0x00
	.byte 0x74, 0x69, 0x6D, 0x65, 0x00, 0x00, 0x00, 0x00
aLen0_3: // 0x0211E858
	.asciz "len > 0"
aGt2messageC: // 0x0211E860
	.asciz "gt2Message.c"
_0211E86D:
	.byte 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00
aLenGti2StackHo: // 0x0211E874
	.asciz "len < GTI2_STACK_HOSTLEN_MAX"
_0211E891:
	.byte 0x00, 0x00, 0x00
aGt2utilityC: // 0x0211E894
	.asciz "gt2Utility.c"
_0211E8A1:
	.byte 0x00, 0x00, 0x00
aSD: // 0x0211E8A4
	.asciz "%s:%d"
_0211E8AA:
	.byte 0x00, 0x00, 0x25, 0x73, 0x00, 0x00
	.byte 0x3A, 0x25, 0x64, 0x00, 0xFD, 0xFC, 0x1E, 0x66, 0x6A, 0xB2, 0x00, 0x00
aNatneg1GsNinte: // 0x0211E8BC
	.asciz "natneg1.gs.nintendowifi.net"
aNatneg2GsNinte: // 0x0211E8D8
	.asciz "natneg2.gs.nintendowifi.net"
aSS_1: // 0x0211E8F4
	.asciz "%s.%s"
_0211E8FA:
	.byte 0x00, 0x00, 0x00, 0xE9, 0x11, 0x02
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
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
aLocalipD: // 0x0211EA10
	.asciz "localip%d"
_0211EA1A:
	.byte 0x00, 0x00
aLocalport: // 0x0211EA1C
	.asciz "localport"
_0211EA26:
	.byte 0x00, 0x00
aNatneg: // 0x0211EA28
	.asciz "natneg"
_0211EA2F:
	.byte 0x00
	.byte 0x31, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00
aStatechanged: // 0x0211EA38
	.asciz "statechanged"
_0211EA45:
	.byte 0x00, 0x00, 0x00
aGamename_1: // 0x0211EA48
	.asciz "gamename"
_0211EA51:
	.byte 0x00, 0x00, 0x00
aPublicip: // 0x0211EA54
	.asciz "publicip"
_0211EA5D:
	.byte 0x00, 0x00, 0x00
aPublicport: // 0x0211EA60
	.asciz "publicport"
_0211EA6B:
	.byte 0x00
aFinalQueryid11: // 0x0211EA6C
	.asciz "final\\\\queryid\\1.1"
_0211EA7F:
	.byte 0x00
aUnknown: // 0x0211EA80
	.asciz "unknown"
_0211EA88:
	.byte 0x00, 0x00, 0x00, 0x00, 0x25, 0x73, 0x25, 0x64
	.byte 0x00, 0x00, 0x00, 0x00
a08x04x: // 0x0211EA94
	.asciz "%08X%04X"
_0211EA9D:
	.byte 0x00, 0x00, 0x00
a255255255255: // 0x0211EAA0
	.asciz "255.255.255.255"
_0211EAB0:
	.byte 0x25, 0x64, 0x00, 0x00
aNoChallengeVal: // 0x0211EAB4
	.asciz "No challenge value was received from the master server."
aSMasterGsNinte: // 0x0211EAEC
	.asciz "%s.master.gs.nintendowifi.net"
_0211EB0A:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x70, 0x69, 0x64, 0x5F, 0x00, 0x00, 0x00, 0x00
aTeam: // 0x0211EB18
	.asciz "team_"
_0211EB1E:
	.byte 0x00, 0x00
aPing_0: // 0x0211EB20
	.asciz "ping_"
_0211EB26:
	.byte 0x00, 0x00
aScore: // 0x0211EB28
	.asciz "score_"
_0211EB2F:
	.byte 0x00
aTeamT: // 0x0211EB30
	.asciz "team_t"
_0211EB37:
	.byte 0x00
aSkill: // 0x0211EB38
	.asciz "skill_"
_0211EB3F:
	.byte 0x00
aMapname: // 0x0211EB40
	.asciz "mapname"
aDeaths: // 0x0211EB48
	.asciz "deaths_"
aGamever: // 0x0211EB50
	.asciz "gamever"
aPlayer: // 0x0211EB58
	.asciz "player_"
aScoreT: // 0x0211EB60
	.asciz "score_t"
aGroupid: // 0x0211EB68
	.asciz "groupid"
aGamename_2: // 0x0211EB70
	.asciz "gamename"
_0211EB79:
	.byte 0x00, 0x00, 0x00
aHostport: // 0x0211EB7C
	.asciz "hostport"
_0211EB85:
	.byte 0x00, 0x00, 0x00
aPassword_0: // 0x0211EB88
	.asciz "password"
_0211EB91:
	.byte 0x00, 0x00, 0x00
aHostname: // 0x0211EB94
	.asciz "hostname"
_0211EB9D:
	.byte 0x00, 0x00, 0x00
aNumteams: // 0x0211EBA0
	.asciz "numteams"
_0211EBA9:
	.byte 0x00, 0x00, 0x00
aGamemode: // 0x0211EBAC
	.asciz "gamemode"
_0211EBB5:
	.byte 0x00, 0x00, 0x00
aTeamplay: // 0x0211EBB8
	.asciz "teamplay"
_0211EBC1:
	.byte 0x00, 0x00, 0x00
aGametype: // 0x0211EBC4
	.asciz "gametype"
_0211EBCD:
	.byte 0x00, 0x00, 0x00
aRoundtime: // 0x0211EBD0
	.asciz "roundtime"
_0211EBDA:
	.byte 0x00, 0x00
aFraglimit: // 0x0211EBDC
	.asciz "fraglimit"
_0211EBE6:
	.byte 0x00, 0x00
aTimelimit: // 0x0211EBE8
	.asciz "timelimit"
_0211EBF2:
	.byte 0x00, 0x00
aNumplayers_0: // 0x0211EBF4
	.asciz "numplayers"
_0211EBFF:
	.byte 0x00
aMaxplayers_0: // 0x0211EC00
	.asciz "maxplayers"
_0211EC0B:
	.byte 0x00
aGamevariant: // 0x0211EC0C
	.asciz "gamevariant"
aTimeelapsed: // 0x0211EC18
	.asciz "timeelapsed"
aRoundelapsed: // 0x0211EC24
	.asciz "roundelapsed"
_0211EC31:
	.byte 0x00, 0x00, 0x00
aTeamfraglimit: // 0x0211EC34
	.asciz "teamfraglimit"
_0211EC42:
	.byte 0x00, 0x00, 0x0C, 0xEB, 0x11, 0x02, 0x94, 0xEB, 0x11, 0x02, 0x70, 0xEB, 0x11, 0x02
	.byte 0x50, 0xEB, 0x11, 0x02, 0x7C, 0xEB, 0x11, 0x02, 0x40, 0xEB, 0x11, 0x02, 0xC4, 0xEB, 0x11, 0x02
	.byte 0x0C, 0xEC, 0x11, 0x02, 0xF4, 0xEB, 0x11, 0x02, 0xA0, 0xEB, 0x11, 0x02, 0x00, 0xEC, 0x11, 0x02
	.byte 0xAC, 0xEB, 0x11, 0x02, 0xB8, 0xEB, 0x11, 0x02, 0xDC, 0xEB, 0x11, 0x02, 0x34, 0xEC, 0x11, 0x02
	.byte 0x18, 0xEC, 0x11, 0x02, 0xE8, 0xEB, 0x11, 0x02, 0xD0, 0xEB, 0x11, 0x02, 0x24, 0xEC, 0x11, 0x02
	.byte 0x88, 0xEB, 0x11, 0x02, 0x68, 0xEB, 0x11, 0x02, 0x58, 0xEB, 0x11, 0x02, 0x28, 0xEB, 0x11, 0x02
	.byte 0x38, 0xEB, 0x11, 0x02, 0x20, 0xEB, 0x11, 0x02, 0x18, 0xEB, 0x11, 0x02, 0x48, 0xEB, 0x11, 0x02
	.byte 0x10, 0xEB, 0x11, 0x02, 0x30, 0xEB, 0x11, 0x02, 0x60, 0xEB, 0x11, 0x02, 0x00, 0x00, 0x00, 0x00
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
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
aFinal_6: // 0x0211F03C
	.asciz "\\final\\"
aBasicInfo: // 0x0211F044
	.asciz "\\basic\\\\info\\"
_0211F052:
	.byte 0x00, 0x00
aStatus_1: // 0x0211F054
	.asciz "\\status\\"
_0211F05D:
	.byte 0x00, 0x00, 0x00
aFinal_7: // 0x0211F060
	.asciz "final"
_0211F066:
	.byte 0x00, 0x00
aQueryid: // 0x0211F068
	.asciz "queryid"
_0211F070:
	.byte 0x25, 0x73, 0x25, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0x69, 0x6E, 0x67
	.byte 0x00, 0x00, 0x00, 0x00
aServer: // 0x0211F084
	.asciz "server"
_0211F08B:
	.byte 0x00
aSbServerC: // 0x0211F08C
	.asciz "sb_server.c"
_0211F098:
	.byte 0x25, 0x64, 0x00, 0x00, 0x5C, 0x25, 0x73, 0x00
	.byte 0xA4, 0xF0, 0x11, 0x02
aQueryError: // 0x0211F0A4
	.asciz "Query Error: "
_0211F0B2:
	.byte 0x00, 0x00
aSlistInbufferl: // 0x0211F0B4
	.asciz "slist->inbufferlen >= 0"
aSbServerlistC: // 0x0211F0CC
	.asciz "sb_serverlist.c"
aInlen0: // 0x0211F0DC
	.asciz "inlen >= 0"
_0211F0E7:
	.byte 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00
	.byte 0x30, 0x00, 0x00, 0x00
aSlistStateSlDi: // 0x0211F0F4
	.asciz "slist->state == sl_disconnected"
_0211F114:
	.byte 0x00, 0x00, 0x00, 0x00
aSMsDGsNintendo: // 0x0211F118
	.asciz "%s.ms%d.gs.nintendowifi.net"
aSlistNull: // 0x0211F134
	.asciz "slist != NULL"
_0211F142:
	.byte 0x00, 0x00
aCallbackNull: // 0x0211F144
	.asciz "callback != NULL"
_0211F155:
	.byte 0x00, 0x00, 0x00
aValNull: // 0x0211F158
	.asciz "val != NULL"
	.align 4

.public _0211F164
_0211F164:
	.byte 0xE6, 0xFF, 0xFF, 0xFF, 0x01, 0x01, 0xC0, 0x05, 0x01, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x08, 0x0C, 0x20, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x66, 0x04, 0x00, 0x00, 0x00, 0x00, 0x61, 0x08, 0x00, 0x00
	.byte 0x00, 0x08, 0x0C, 0x20, 0x00, 0x08, 0x0D, 0x20, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEA, 0x05
	.byte 0x00, 0x00, 0x00, 0x00, 0xEB, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x0D, 0x20
aDDDD: // 0x0211F1B0
	.asciz "%d.%d.%d.%d"
	.align 4

.public _0211F1BC
_0211F1BC:
	.byte 0x10, 0x00, 0x00, 0x00
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00
aNintendods: // 0x0211F1C8
	.asciz "NintendoDS"
_0211F1D3:
	.byte 0x00, 0xAA, 0xAA, 0x03, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x04, 0x00, 0x05, 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x55, 0x04, 0x03, 0x00
	.byte 0x55, 0x08, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x01
	.byte 0x01, 0x00, 0x00, 0x00, 0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x01, 0x04, 0x00, 0x00, 0x00
	.byte 0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x01, 0x05, 0x00, 0x00, 0x00, 0xE4, 0xF1, 0x11, 0x02
	.byte 0xF8, 0xF1, 0x11, 0x02, 0xF0, 0xF1, 0x11, 0x02, 0x04, 0xF2, 0x11, 0x02, 0x10, 0xF2, 0x11, 0x02
	.byte 0xEC, 0xF1, 0x11, 0x02
aSrvr: // 0x0211F234
	.asciz "SRVR"
_0211F239:
	.byte 0x00, 0x00, 0x00
aClnt: // 0x0211F23C
	.asciz "CLNT"
_0211F241:
	.byte 0x00, 0x00, 0x00
aA: // 0x0211F244
	.asciz "A"
_0211F246:
	.byte 0x00, 0x00
aBb: // 0x0211F248
	.asciz "BB"
_0211F24B:
	.byte 0x00
aCcc: // 0x0211F24C
	.asciz "CCC"
byte_211F250: 
	.byte 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 
	.byte 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x01, 0x06, 0x0B, 0x00, 
	.byte 0x05, 0x0A, 0x0F, 0x04, 0x09, 0x0E, 0x03, 0x08, 0x0D, 0x02, 
	.byte 0x07, 0x0C, 0x05, 0x08, 0x0B, 0x0E, 0x01, 0x04, 0x07, 0x0A, 
	.byte 0x0D, 0x00, 0x03, 0x06, 0x09, 0x0C, 0x0F, 0x02, 0x00, 0x07, 
	.byte 0x0E, 0x05, 0x0C, 0x03, 0x0A, 0x01, 0x08, 0x0F, 0x06, 0x0D, 
	.byte 0x04, 0x0B, 0x02, 0x09

.public _0211F290
_0211F290:
	.byte 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

.public _0211F2D0
_0211F2D0:
	.word 0xD76AA478, 0xE8C7B756, 0x242070DB, 0xC1BDCEEE, 0xF57C0FAF
	.word 0x4787C62A, 0xA8304613, 0xFD469501, 0x698098D8, 0x8B44F7AF
	.word 0xFFFF5BB1, 0x895CD7BE, 0x6B901122, 0xFD987193, 0xA679438E
	.word 0x49B40821, 0xF61E2562, 0xC040B340, 0x265E5A51, 0xE9B6C7AA
	.word 0xD62F105D, 0x02441453, 0xD8A1E681, 0xE7D3FBC8, 0x21E1CDE6
	.word 0xC33707D6, 0xF4D50D87, 0x455A14ED, 0xA9E3E905, 0xFCEFA3F8
	.word 0x676F02D9, 0x8D2A4C8A, 0xFFFA3942, 0x8771F681, 0x6D9D6122
	.word 0xFDE5380C, 0xA4BEEA44, 0x4BDECFA9, 0xF6BB4B60, 0xBEBFBC70
	.word 0x289B7EC6, 0xEAA127FA, 0xD4EF3085, 0x04881D05, 0xD9D4D039
	.word 0xE6DB99E5, 0x1FA27CF8, 0xC4AC5665, 0xF4292244, 0x432AFF97
	.word 0xAB9423A7, 0xFC93A039, 0x655B59C3, 0x8F0CCC92, 0xFFEFF47D
	.word 0x85845DD1, 0x6FA87E4F, 0xFE2CE6E0, 0xA3014314, 0x4E0811A1
	.word 0xF7537E82, 0xBD3AF235, 0x2AD7D2BB, 0xEB86D391

_0211F3D0:
	.word 0x80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0