	.include "asm/macros.inc"
	.include "global.inc"

	.text

	arm_func_start sub_2089190
sub_2089190: // 0x02089190
	stmdb sp!, {r4, lr}
	ldr r2, _020891D0 // =0x021438E8
	ldr r1, _020891D4 // =0x000013D8
	ldr r2, [r2]
	mov r4, r0
	add r0, r2, r1
	bl OS_LockMutex
	ldr r2, _020891D0 // =0x021438E8
	ldr r1, _020891D4 // =0x000013D8
	ldr r0, [r2]
	add r0, r0, #0x1000
	str r4, [r0, #4]
	ldr r0, [r2]
	add r0, r0, r1
	bl OS_UnlockMutex
	ldmia sp!, {r4, pc}
	.align 2, 0
_020891D0: .word 0x021438E8
_020891D4: .word 0x000013D8
	arm_func_end sub_2089190

	arm_func_start sub_20891D8
sub_20891D8: // 0x020891D8
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x98
	ldr r4, _02089358 // =0x021438EC
	mov r3, #0
	ldr r5, [r4, #4]
	ldr ip, [r4]
	cmp r5, r3
	mov r5, r0
	mov r6, r1
	mov r4, r2
	cmpeq ip, r3
	bne _02089238
	ldr r0, _0208935C // =aAcctcreate
	bl strlen
	mov r3, r0
	ldr r1, _02089360 // =aAction
	ldr r2, _0208935C // =aAcctcreate
	mov r0, r5
	bl sub_208AFE0
	cmp r0, #0
	beq _02089290
	add sp, sp, #0x98
	mov r0, #8
	ldmia sp!, {r4, r5, r6, pc}
_02089238:
	ldr r0, _02089364 // =aLogin
	bl strlen
	mov r3, r0
	ldr r1, _02089360 // =aAction
	ldr r2, _02089364 // =aLogin
	mov r0, r5
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x98
	movne r0, #8
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl strlen
	mov r3, r0
	ldr r1, _02089368 // =aGsbrcd
	mov r0, r5
	mov r2, r6
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x98
	movne r0, #8
	ldmneia sp!, {r4, r5, r6, pc}
_02089290:
	ldr r1, _02089358 // =0x021438EC
	add r0, sp, #0
	bl sub_208A3F0
	cmp r0, #0
	addeq sp, sp, #0x98
	moveq r0, #5
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _0208936C // =0x02143908
	add r1, sp, #0
	ldr r2, [r0]
	mov r0, r5
	bl sub_208A0A4
	cmp r0, #0
	addeq sp, sp, #0x98
	moveq r0, #8
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _02089370 // =0x021438E0
	ldr r0, [r0]
	cmp r0, #1
	bne _0208930C
	ldr r0, _02089374 // =0x0211AEAC
	bl strlen
	mov r3, r0
	ldr r1, _02089378 // =aIswfc
	ldr r2, _02089374 // =0x0211AEAC
	mov r0, r5
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x98
	movne r0, #8
	ldmneia sp!, {r4, r5, r6, pc}
_0208930C:
	mov r0, r4
	bl wcslen
	cmp r0, #0
	beq _0208934C
	mov r0, r4
	bl wcslen
	mov r3, r0
	ldr r1, _0208937C // =aIngamesn
	mov r0, r5
	mov r2, r4
	mov r3, r3, lsl #1
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x98
	movne r0, #8
	ldmneia sp!, {r4, r5, r6, pc}
_0208934C:
	mov r0, #0
	add sp, sp, #0x98
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_02089358: .word 0x021438EC
_0208935C: .word aAcctcreate
_02089360: .word aAction
_02089364: .word aLogin
_02089368: .word aGsbrcd
_0208936C: .word 0x02143908
_02089370: .word 0x021438E0
_02089374: .word 0x0211AEAC
_02089378: .word aIswfc
_0208937C: .word aIngamesn
	arm_func_end sub_20891D8

	arm_func_start sub_2089380
sub_2089380: // 0x02089380
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _02089634 // =0x021438E8
	mov r1, #0
	ldr r0, [r0]
	str r1, [sp]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x314]
	ldr r1, _02089638 // =0x0211AEC4
	bl sub_208A800
	str r0, [sp]
	cmp r0, #0
	beq _020893B8
	bl sub_208CF24
_020893B8:
	ldr r0, _02089634 // =0x021438E8
	mov r2, #0
	ldr r1, [r0]
	ldr r0, _0208963C // =_02152920
	str r2, [sp]
	str r2, [r0]
	add r0, r1, #0x1000
	ldr r0, [r0, #0x314]
	ldr r1, _02089640 // =aHttpresult
	bl sub_208A800
	bl atoi
	ldr r1, _0208963C // =_02152920
	ldr r1, [r1]
	cmp r1, #0x22
	bne _02089414
	ldr r0, _02089634 // =0x021438E8
	ldr r2, _02089644 // =0x00004E85
	ldr r1, [r0]
	add sp, sp, #4
	add r1, r1, #0x1000
	str r2, [r1, #8]
	mov r0, #0xc
	ldmia sp!, {r4, r5, pc}
_02089414:
	cmp r0, #0xc8
	beq _02089440
	ldr r2, _02089634 // =0x021438E8
	ldr r1, _02089648 // =0x000059D8
	ldr r2, [r2]
	add r1, r0, r1
	add r0, r2, #0x1000
	str r1, [r0, #8]
	add sp, sp, #4
	mov r0, #0x12
	ldmia sp!, {r4, r5, pc}
_02089440:
	ldr r0, _02089634 // =0x021438E8
	ldr r2, _0208964C // =0x0000100C
	ldr r3, [r0]
	ldr r1, _02089650 // =aReturncd
	add r0, r3, #0x1000
	ldr r0, [r0, #0x314]
	add r2, r3, r2
	mov r3, #4
	bl sub_208A7AC
	cmp r0, #0
	bgt _0208948C
	ldr r0, _02089634 // =0x021438E8
	ldr r2, _02089644 // =0x00004E85
	ldr r1, [r0]
	add sp, sp, #4
	add r1, r1, #0x1000
	str r2, [r1, #8]
	mov r0, #0xe
	ldmia sp!, {r4, r5, pc}
_0208948C:
	ldr r1, _02089634 // =0x021438E8
	ldr r0, _0208964C // =0x0000100C
	ldr r2, [r1]
	add r1, sp, #0
	add r0, r2, r0
	mov r2, #0xa
	bl strtol
	ldr r2, _02089634 // =0x021438E8
	ldr r1, _0208964C // =0x0000100C
	ldr r5, [r2]
	mov r4, r0
	add r0, r5, r1
	bl strlen
	ldr r1, _0208964C // =0x0000100C
	ldr r2, [sp]
	add r1, r5, r1
	add r0, r1, r0
	cmp r2, r0
	ldrne r1, _02089644 // =0x00004E85
	addne r0, r5, #0x1000
	strne r1, [r0, #8]
	addne sp, sp, #4
	movne r0, #0xc
	ldmneia sp!, {r4, r5, pc}
	ldr r0, _02089654 // =0x00004E20
	add r1, r5, #0x1000
	add r0, r4, r0
	str r0, [r1, #8]
	cmp r4, #0x64
	bge _02089628
	ldr ip, _02089634 // =0x021438E8
	mov r0, #0
	ldr r1, [ip]
	ldr r5, _02089658 // =0x00001052
	add r1, r1, #0x1000
	strb r0, [r1, #0x52]
	ldr r2, [ip]
	ldr r1, _0208965C // =aToken
	add r2, r2, #0x1000
	strb r0, [r2, #0x1f]
	ldr r2, [ip]
	ldr r3, _02089660 // =0x0000012D
	add r2, r2, #0x1000
	strb r0, [r2, #0x17f]
	ldr r2, [ip]
	add r2, r2, #0x1000
	strb r0, [r2, #0x10]
	ldr r2, [ip]
	add r2, r2, #0x1000
	strb r0, [r2, #0x188]
	ldr r2, [ip]
	add r0, r2, #0x1000
	ldr r0, [r0, #0x314]
	add r2, r2, r5
	bl sub_208A7AC
	ldr r0, _02089634 // =0x021438E8
	ldr r2, _02089664 // =0x0000101F
	ldr r3, [r0]
	ldr r1, _02089668 // =aLocator
	add r0, r3, #0x1000
	add r2, r3, r2
	ldr r0, [r0, #0x314]
	mov r3, #0x33
	bl sub_208A7AC
	ldr r0, _02089634 // =0x021438E8
	ldr r2, _0208966C // =0x0000117F
	ldr r3, [r0]
	ldr r1, _02089670 // =aChallenge
	add r0, r3, #0x1000
	add r2, r3, r2
	ldr r0, [r0, #0x314]
	mov r3, #9
	bl sub_208A7AC
	ldr r0, _02089634 // =0x021438E8
	ldr r2, _02089674 // =0x00001010
	ldr r3, [r0]
	ldr r1, _02089678 // =aDatetime
	add r0, r3, #0x1000
	add r2, r3, r2
	ldr r0, [r0, #0x314]
	mov r3, #0xf
	bl sub_208A7AC
	ldr r0, _02089634 // =0x021438E8
	ldr r2, _0208967C // =0x00001188
	ldr r3, [r0]
	ldr r1, _02089680 // =aSetCookie
	add r0, r3, #0x1000
	add r2, r3, r2
	ldr r0, [r0, #0x314]
	mov r3, #0x41
	bl sub_208A76C
	ldr r0, _02089634 // =0x021438E8
	mov r1, #0
	ldr r0, [r0]
	cmp r4, #0x28
	add r0, r0, #0x1000
	strb r1, [r0, #0x1b3]
	ldrne r0, _02089684 // =0x021438E4
	movne r1, #1
	strne r1, [r0]
	ldreq r0, _02089684 // =0x021438E4
	moveq r1, #2
	streq r1, [r0]
_02089628:
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_02089634: .word 0x021438E8
_02089638: .word 0x0211AEC4
_0208963C: .word _02152920
_02089640: .word aHttpresult
_02089644: .word 0x00004E85
_02089648: .word 0x000059D8
_0208964C: .word 0x0000100C
_02089650: .word aReturncd
_02089654: .word 0x00004E20
_02089658: .word 0x00001052
_0208965C: .word aToken
_02089660: .word 0x0000012D
_02089664: .word 0x0000101F
_02089668: .word aLocator
_0208966C: .word 0x0000117F
_02089670: .word aChallenge
_02089674: .word 0x00001010
_02089678: .word aDatetime
_0208967C: .word 0x00001188
_02089680: .word aSetCookie
_02089684: .word 0x021438E4
	arm_func_end sub_2089380

	arm_func_start sub_2089688
sub_2089688: // 0x02089688
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r0, _0208986C // =0x021438E8
	mov r1, #0
	ldr r0, [r0]
	add r2, r0, #0x1000
	ldr r0, [r2, #0x314]
	ldr r5, [r2, #0x20c]
	ldr r4, [r2, #0x210]
	bl sub_208A854
	cmp r0, #1
	beq _020896D8
	ldr r0, _0208986C // =0x021438E8
	ldr r2, _02089870 // =0x00004E84
	ldr r1, [r0]
	add sp, sp, #4
	add r1, r1, #0x1000
	str r2, [r1, #8]
	mov r0, #0xe
	ldmia sp!, {r4, r5, pc}
_020896D8:
	bl sub_2089380
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #0xe
	ldmneia sp!, {r4, r5, pc}
	ldr r0, _0208986C // =0x021438E8
	ldr r1, _02089870 // =0x00004E84
	ldr r0, [r0]
	add r0, r0, #0x1000
	ldr r2, [r0, #8]
	cmp r2, r1
	bge _020897AC
	ldr r0, _02089874 // =0x00004E22
	cmp r2, r0
	bne _020897A0
	ldr r0, _02089878 // =aAllocBmwork
	ldr r1, _0208987C // =0x0000071F
	blx r5
	movs r5, r0
	bne _02089748
	ldr r0, _0208986C // =0x021438E8
	ldr r2, _02089870 // =0x00004E84
	ldr r1, [r0]
	add sp, sp, #4
	add r1, r1, #0x1000
	str r2, [r1, #8]
	mov r0, #2
	ldmia sp!, {r4, r5, pc}
_02089748:
	add r1, r5, #0x1f
	ldr r0, _02089880 // =0x021438EC
	bic r1, r1, #0x1f
	bl sub_208E898
	cmp r0, #1
	beq _02089790
	ldr r0, _02089884 // =aFreeBmwork
	mov r1, r5
	mov r2, #0
	blx r4
	ldr r0, _0208986C // =0x021438E8
	ldr r2, _02089870 // =0x00004E84
	ldr r1, [r0]
	add sp, sp, #4
	add r1, r1, #0x1000
	str r2, [r1, #8]
	mov r0, #0xf
	ldmia sp!, {r4, r5, pc}
_02089790:
	ldr r0, _02089884 // =aFreeBmwork
	mov r1, r5
	mov r2, #0
	blx r4
_020897A0:
	add sp, sp, #4
	mov r0, #0x15
	ldmia sp!, {r4, r5, pc}
_020897AC:
	ldr r0, _02089888 // =0x00004E88
	cmp r2, r0
	beq _020897C8
	ldr r0, _0208988C // =0x00004E8C
	cmp r2, r0
	beq _020897F0
	b _02089860
_020897C8:
	ldr r0, _02089880 // =0x021438EC
	bl sub_208E6F8
	ldr r0, _0208986C // =0x021438E8
	ldr r2, _02089888 // =0x00004E88
	ldr r1, [r0]
	add sp, sp, #4
	add r1, r1, #0x1000
	str r2, [r1, #8]
	mov r0, #0x10
	ldmia sp!, {r4, r5, pc}
_020897F0:
	ldr r0, _02089878 // =aAllocBmwork
	mov r1, #0x700
	blx r5
	movs r5, r0
	bne _02089824
	ldr r0, _0208986C // =0x021438E8
	ldr r2, _0208988C // =0x00004E8C
	ldr r1, [r0]
	add sp, sp, #4
	add r1, r1, #0x1000
	str r2, [r1, #8]
	mov r0, #0x11
	ldmia sp!, {r4, r5, pc}
_02089824:
	add r0, r5, #0x1f
	bic r0, r0, #0x1f
	bl DWCi_AUTH_MakeWiFiID
	ldr r0, _02089884 // =aFreeBmwork
	mov r1, r5
	mov r2, #0
	blx r4
	ldr r0, _0208986C // =0x021438E8
	ldr r2, _0208988C // =0x00004E8C
	ldr r1, [r0]
	add sp, sp, #4
	add r1, r1, #0x1000
	str r2, [r1, #8]
	mov r0, #0x11
	ldmia sp!, {r4, r5, pc}
_02089860:
	mov r0, #0x12
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0208986C: .word 0x021438E8
_02089870: .word 0x00004E84
_02089874: .word 0x00004E22
_02089878: .word aAllocBmwork
_0208987C: .word 0x0000071F
_02089880: .word 0x021438EC
_02089884: .word aFreeBmwork
_02089888: .word 0x00004E88
_0208988C: .word 0x00004E8C
	arm_func_end sub_2089688

	arm_func_start sub_2089890
sub_2089890: // 0x02089890
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	mov r9, #0
	mov r0, #1
	ldr r7, _02089B4C // =0x00001388
	ldr r11, _02089B50 // =0x000082EA
	ldr r5, _02089B54 // =0x021438E8
	ldr r4, _02089B58 // =0x000013D8
	mov r6, r9
	str r9, [sp, #8]
	str r9, [sp, #0xc]
	str r0, [sp, #4]
_020898C0:
	ldr r0, [r5]
	add r0, r0, #0x1000
	ldr r1, [r0, #0x314]
	add r0, r1, #0x1000
	ldr r0, [r0, #0xba4]
	cmp r0, #0
	beq _020898E8
	ldr r0, _02089B5C // =0x00001B38
	add r0, r1, r0
	bl OS_JoinThread
_020898E8:
	ldr r0, [r5]
	add r1, r0, #0x1000
	ldr r0, [r1, #0x314]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x20]
	cmp r0, #8
	beq _02089990
	ldr r0, _02089B60 // =0x00004E84
	str r0, [r1, #8]
	ldr r0, [r5]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x314]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x20]
	cmp r0, #7
	bne _02089938
	mov r0, #0x14
	bl sub_2089190
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02089938:
	cmp r9, #2
	ble _02089980
	cmp r0, #2
	bne _02089958
	mov r0, #9
	bl sub_2089190
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02089958:
	cmp r0, #3
	bne _02089970
	mov r0, #0xb
	bl sub_2089190
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02089970:
	mov r0, #0xd
	bl sub_2089190
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02089980:
	ldr r0, [sp, #4]
	add r9, r9, #1
	str r0, [sp]
	b _02089A10
_02089990:
	bl sub_2089688
	cmp r0, #0x10
	beq _020899BC
	cmp r0, #0x11
	beq _020899E4
	cmp r0, #0x15
	bne _020899F0
	mov r0, #0x15
	bl sub_2089190
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020899BC:
	cmp r9, #2
	ble _020899D4
	mov r0, #0x10
	bl sub_2089190
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020899D4:
	ldr r0, [sp, #8]
	add r9, r9, #1
	str r0, [sp]
	b _02089A10
_020899E4:
	bl sub_2089190
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_020899F0:
	cmp r9, #2
	blt _02089A04
	bl sub_2089190
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02089A04:
	ldr r0, [sp, #4]
	add r9, r9, #1
	str r0, [sp]
_02089A10:
	bl OS_GetTick
	mov r8, r0
	mov r10, r1
	bl OS_GetTick
	subs r2, r0, r8
	sbc r0, r1, r10
	mov r1, r0, lsl #6
	ldr r3, [sp, #0xc]
	orr r1, r1, r2, lsr #26
	mov r0, r2, lsl #6
	mov r2, r11
	bl _ll_udiv
	cmp r1, #0
	cmpeq r0, r7
	bhs _02089AD4
_02089A4C:
	ldr r0, [r5]
	add r0, r0, r4
	bl OS_LockMutex
	ldr r2, [r5]
	add r1, r2, #0x1000
	ldr r0, [r1, #0x3f0]
	cmp r0, #1
	bne _02089A94
	ldr r2, _02089B60 // =0x00004E84
	ldr r0, _02089B58 // =0x000013D8
	str r2, [r1, #8]
	ldr r1, [r5]
	add r0, r1, r0
	bl OS_UnlockMutex
	mov r0, #0x14
	bl sub_2089190
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02089A94:
	add r0, r2, r4
	bl OS_UnlockMutex
	mov r0, r7
	bl OS_Sleep
	bl OS_GetTick
	subs r2, r0, r8
	sbc r0, r1, r10
	mov r1, r0, lsl #6
	orr r1, r1, r2, lsr #26
	mov r0, r2, lsl #6
	mov r2, r11
	mov r3, r6
	bl _ll_udiv
	cmp r1, #0
	cmpeq r0, r7
	blo _02089A4C
_02089AD4:
	ldr r0, [r5]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x314]
	bl sub_208B2C4
	ldr r0, [r5]
	add r0, r0, r4
	bl OS_LockMutex
	ldr r0, [sp]
	bl sub_2089B64
	ldr r1, [r5]
	add r1, r1, #0x1000
	str r0, [r1, #4]
	ldr r2, [r5]
	add r1, r2, #0x1000
	ldr r0, [r1, #4]
	cmp r0, #0
	beq _02089B38
	ldr r2, _02089B60 // =0x00004E84
	ldr r0, _02089B58 // =0x000013D8
	str r2, [r1, #8]
	ldr r1, [r5]
	add r0, r1, r0
	bl OS_UnlockMutex
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_02089B38:
	add r0, r2, r4
	bl OS_UnlockMutex
	b _020898C0
	arm_func_end sub_2089890

	arm_func_start sub_2089B44
sub_2089B44: // 0x02089B44
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_02089B4C: .word 0x00001388
_02089B50: .word 0x000082EA
_02089B54: .word 0x021438E8
_02089B58: .word 0x000013D8
_02089B5C: .word 0x00001B38
_02089B60: .word 0x00004E84
	arm_func_end sub_2089B44

	arm_func_start sub_2089B64
sub_2089B64: // 0x02089B64
	stmdb sp!, {r4, lr}
	ldr r1, _02089C58 // =_0211AE44
	mov r4, r0
	ldr r0, [r1]
	ldr r1, _02089C5C // =aHttpsNasNinten
	bl strcmp
	cmp r0, #0
	ldrne r0, _02089C58 // =_0211AE44
	movne r1, #1
	strne r1, [r0, #0x14]
	ldr r0, _02089C60 // =0x021438E8
	ldr r1, _02089C58 // =_0211AE44
	ldr r0, [r0]
	add r0, r0, #0x1000
	ldr r2, [r0, #0x20c]
	str r2, [r1, #0xc]
	ldr r2, [r0, #0x210]
	str r2, [r1, #0x10]
	ldr r0, [r0, #0x314]
	bl sub_208BA88
	cmp r0, #0
	movne r0, #4
	ldmneia sp!, {r4, pc}
	cmp r4, #1
	bne _02089BD0
	ldr r0, _02089C64 // =0x021438EC
	bl sub_208E050
_02089BD0:
	ldr r0, _02089C60 // =0x021438E8
	ldr r2, _02089C68 // =0x000011CC
	ldr r3, [r0]
	add r0, r3, #0x1000
	ldr r0, [r0, #0x314]
	add r1, r3, #0x1200
	add r2, r3, r2
	bl sub_20891D8
	ldr r2, _02089C60 // =0x021438E8
	ldr r1, [r2]
	add r1, r1, #0x1000
	str r0, [r1, #4]
	ldr r0, [r2]
	add r0, r0, #0x1000
	ldr r1, [r0, #4]
	cmp r1, #0
	movne r0, #4
	ldmneia sp!, {r4, pc}
	ldr r0, [r0, #0x314]
	bl sub_208B9F0
	cmp r0, #0
	movne r0, #4
	ldmneia sp!, {r4, pc}
	ldr r0, _02089C6C // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	bl OS_GetThreadPriority
	ldr r1, _02089C60 // =0x021438E8
	ldr r2, [r1]
	sub r1, r0, #1
	add r0, r2, #0x1000
	ldr r0, [r0, #0x314]
	bl sub_208B924
	mov r0, #0
	ldmia sp!, {r4, pc}
	.align 2, 0
_02089C58: .word _0211AE44
_02089C5C: .word aHttpsNasNinten
_02089C60: .word 0x021438E8
_02089C64: .word 0x021438EC
_02089C68: .word 0x000011CC
_02089C6C: .word OSi_ThreadInfo
	arm_func_end sub_2089B64

	arm_func_start sub_2089C70
sub_2089C70: // 0x02089C70
	stmdb sp!, {r4, lr}
	ldr r1, _02089CEC // =0x021438E8
	mov r4, r0
	ldr r1, [r1]
	cmp r1, #0
	bne _02089C94
	mov r1, #0
	mov r2, #0x1c4
	bl MI_CpuFill8
_02089C94:
	ldr r1, _02089CEC // =0x021438E8
	ldr r0, _02089CF0 // =0x00001008
	ldr r2, [r1]
	mov r1, r4
	add r0, r2, r0
	mov r2, #0x1c4
	bl MI_CpuCopy8
	ldr r1, [r4]
	ldr r0, _02089CF4 // =0x00004E20
	cmp r1, r0
	blt _02089CCC
	ldr r0, _02089CF8 // =0x00007530
	cmp r1, r0
	blt _02089CD4
_02089CCC:
	ldr r0, _02089CFC // =0x00005206
	str r0, [r4]
_02089CD4:
	ldr r1, [r4]
	ldr r0, _02089D00 // =0x00004E84
	cmp r1, r0
	rsbge r0, r1, #0
	strge r0, [r4]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02089CEC: .word 0x021438E8
_02089CF0: .word 0x00001008
_02089CF4: .word 0x00004E20
_02089CF8: .word 0x00007530
_02089CFC: .word 0x00005206
_02089D00: .word 0x00004E84
	arm_func_end sub_2089C70

	arm_func_start sub_2089D04
sub_2089D04: // 0x02089D04
	stmdb sp!, {r4, lr}
	ldr r0, _02089D4C // =0x021438E8
	ldr r1, [r0]
	cmp r1, #0
	moveq r0, #0x16
	ldmeqia sp!, {r4, pc}
	ldr r0, _02089D50 // =0x000013D8
	add r0, r1, r0
	bl OS_LockMutex
	ldr r1, _02089D4C // =0x021438E8
	ldr r0, _02089D50 // =0x000013D8
	ldr r2, [r1]
	add r1, r2, #0x1000
	add r0, r2, r0
	ldr r4, [r1, #4]
	bl OS_UnlockMutex
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_02089D4C: .word 0x021438E8
_02089D50: .word 0x000013D8
	arm_func_end sub_2089D04

	arm_func_start sub_2089D54
sub_2089D54: // 0x02089D54
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02089D8C // =0x021438E8
	ldr r1, [r0]
	add r0, r1, #0x1000
	ldr r0, [r0, #0x384]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _02089D90 // =0x00001318
	add r0, r1, r0
	bl OS_JoinThread
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02089D8C: .word 0x021438E8
_02089D90: .word 0x00001318
	arm_func_end sub_2089D54

	arm_func_start sub_2089D94
sub_2089D94: // 0x02089D94
	stmdb sp!, {r4, lr}
	ldr r0, _02089DE4 // =0x021438E8
	ldr r0, [r0]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r1, r0, #0x1000
	ldr r0, [r1, #0x314]
	ldr r4, [r1, #0x210]
	cmp r0, #0
	beq _02089DC0
	bl sub_208B2C4
_02089DC0:
	ldr r1, _02089DE4 // =0x021438E8
	ldr r0, _02089DE8 // =aFreeDwcauth
	ldr r1, [r1]
	mov r2, #0
	blx r4
	ldr r0, _02089DE4 // =0x021438E8
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_02089DE4: .word 0x021438E8
_02089DE8: .word aFreeDwcauth
	arm_func_end sub_2089D94

	arm_func_start sub_2089DEC
sub_2089DEC: // 0x02089DEC
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _02089E84 // =0x021438E8
	ldr r1, [r0]
	cmp r1, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _02089E88 // =0x000013D8
	add r0, r1, r0
	bl OS_LockMutex
	ldr r2, _02089E84 // =0x021438E8
	mov r3, #1
	ldr r0, [r2]
	ldr r1, _02089E88 // =0x000013D8
	add r0, r0, #0x1000
	str r3, [r0, #0x3f0]
	ldr r0, [r2]
	add r0, r0, r1
	bl OS_UnlockMutex
	ldr r0, _02089E84 // =0x021438E8
	ldr r0, [r0]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x314]
	cmp r0, #0
	beq _02089E54
	bl sub_208B8C0
_02089E54:
	ldr r0, _02089E84 // =0x021438E8
	ldr r1, [r0]
	add r0, r1, #0x1000
	ldr r0, [r0, #0x384]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _02089E8C // =0x00001318
	add r0, r1, r0
	bl OS_JoinThread
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_02089E84: .word 0x021438E8
_02089E88: .word 0x000013D8
_02089E8C: .word 0x00001318
	arm_func_end sub_2089DEC

	arm_func_start sub_2089E90
sub_2089E90: // 0x02089E90
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r1, _02089F34 // =0x021438E8
	ldr r0, _02089F38 // =0x000013D8
	ldr r1, [r1]
	add r0, r1, r0
	bl OS_InitMutex
	ldr r1, _02089F34 // =0x021438E8
	mov r2, #0
	ldr r0, [r1]
	add r0, r0, #0x1000
	str r2, [r0, #0x3f0]
	ldr r1, [r1]
	add r0, r1, #0x1000
	ldr r0, [r0, #0x384]
	cmp r0, #0
	beq _02089EEC
	ldr r0, _02089F3C // =0x00001318
	add r0, r1, r0
	bl OS_IsThreadTerminated
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {pc}
_02089EEC:
	ldr r2, _02089F34 // =0x021438E8
	ldr r0, _02089F3C // =0x00001318
	ldr lr, [r2]
	mov r3, #0x1000
	ldr r1, _02089F40 // =sub_2089890
	str r3, [sp]
	mov ip, #0x10
	add r0, lr, r0
	add r3, lr, #0x1000
	str ip, [sp, #4]
	bl OS_CreateThread
	ldr r1, _02089F34 // =0x021438E8
	ldr r0, _02089F3C // =0x00001318
	ldr r1, [r1]
	add r0, r1, r0
	bl OS_WakeupThreadDirect
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_02089F34: .word 0x021438E8
_02089F38: .word 0x000013D8
_02089F3C: .word 0x00001318
_02089F40: .word sub_2089890
	arm_func_end sub_2089E90

	arm_func_start sub_2089F44
sub_2089F44: // 0x02089F44
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r2, _0208A074 // =0x021438E8
	mov r5, r0
	ldr r0, [r2]
	mov r4, r1
	cmp r0, #0
	addne sp, sp, #4
	ldr r2, [r5, #0x40]
	movne r0, #2
	ldmneia sp!, {r4, r5, pc}
	ldr r0, _0208A078 // =aAllocDwcauth
	ldr r1, _0208A07C // =0x000013F4
	blx r2
	ldr r1, _0208A074 // =0x021438E8
	cmp r0, #0
	str r0, [r1]
	addeq sp, sp, #4
	moveq r0, #2
	ldmeqia sp!, {r4, r5, pc}
	ldr r2, _0208A07C // =0x000013F4
	mov r1, #0
	bl MI_CpuFill8
	ldr r1, _0208A074 // =0x021438E8
	ldr r2, _0208A080 // =0x00001008
	ldr r0, [r1]
	ldr r3, _0208A084 // =0x021438E4
	add r0, r0, #0x1000
	str r4, [r0, #0x314]
	ldr r0, [r1]
	mov r1, #0
	add r0, r0, r2
	mov r2, #0x1c4
	str r1, [r3]
	bl MI_CpuFill8
	ldr r2, _0208A074 // =0x021438E8
	ldr r3, _0208A088 // =0x00004E84
	ldr r0, [r2]
	ldr r1, _0208A08C // =0x000011CC
	add r0, r0, #0x1000
	str r3, [r0, #8]
	ldr lr, [r2]
	mov r4, #4
	add ip, lr, r1
_02089FF4:
	ldmia r5!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	subs r4, r4, #1
	bne _02089FF4
	ldmia r5, {r0, r1}
	stmia ip, {r0, r1}
	add r0, lr, #0x1100
	mov r2, #0
	strh r2, [r0, #0xfe]
	ldr r1, _0208A074 // =0x021438E8
	mov r0, #1
	ldr r1, [r1]
	add r1, r1, #0x1000
	strb r2, [r1, #0x20b]
	bl sub_2089B64
	ldr r2, _0208A074 // =0x021438E8
	ldr r1, [r2]
	add r1, r1, #0x1000
	str r0, [r1, #4]
	ldr r0, [r2]
	add r0, r0, #0x1000
	ldr r0, [r0, #4]
	cmp r0, #0
	addne sp, sp, #4
	ldmneia sp!, {r4, r5, pc}
	ldr r0, _0208A090 // =0x021438E0
	mov r1, #0
	str r1, [r0]
	bl sub_2089E90
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0208A074: .word 0x021438E8
_0208A078: .word aAllocDwcauth
_0208A07C: .word 0x000013F4
_0208A080: .word 0x00001008
_0208A084: .word 0x021438E4
_0208A088: .word 0x00004E84
_0208A08C: .word 0x000011CC
_0208A090: .word 0x021438E0
	arm_func_end sub_2089F44

	arm_func_start sub_208A094
sub_208A094: // 0x0208A094
	ldr r1, _0208A0A0 // =_0211AE44
	str r0, [r1]
	bx lr
	.align 2, 0
_0208A0A0: .word _0211AE44
	arm_func_end sub_208A094

	arm_func_start sub_208A0A4
sub_208A0A4: // 0x0208A0A4
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x28
	mov r4, r2
	mov r6, r0
	mov r5, r1
	mov ip, #3
	ldr r2, _0208A3A8 // =a03d03d
	add r0, sp, #4
	mov r1, #0x21
	mov r3, #1
	str ip, [sp]
	bl OS_SNPrintf
	add r0, sp, #4
	bl strlen
	mov r3, r0
	ldr r1, _0208A3AC // =aSdkver
	mov r0, r6
	add r2, sp, #4
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	mov r0, r5
	bl strlen
	mov r3, r0
	ldr r1, _0208A3B0 // =aUserid
	mov r0, r6
	mov r2, r5
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0xe
	bl strlen
	mov r3, r0
	ldr r1, _0208A3B4 // =aPasswd
	mov r0, r6
	add r2, r5, #0xe
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x41
	bl strlen
	mov r3, r0
	ldr r1, _0208A3B8 // =aBssid
	mov r0, r6
	add r2, r5, #0x41
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x6f
	bl strlen
	mov r3, r0
	ldr r1, _0208A3BC // =aApinfo
	mov r0, r6
	add r2, r5, #0x6f
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x15
	bl strlen
	mov r3, r0
	ldr r1, _0208A3C0 // =aGamecd
	mov r0, r6
	add r2, r5, #0x15
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x1a
	bl strlen
	mov r3, r0
	ldr r1, _0208A3C4 // =aMakercd
	mov r0, r6
	add r2, r5, #0x1a
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x1d
	bl strlen
	mov r3, r0
	ldr r1, _0208A3C8 // =aUnitcd
	mov r0, r6
	add r2, r5, #0x1d
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x1f
	bl strlen
	mov r3, r0
	ldr r1, _0208A3CC // =aMacadr
	mov r0, r6
	add r2, r5, #0x1f
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x2c
	bl strlen
	mov r3, r0
	ldr r1, _0208A3D0 // =0x0211AFC8
	mov r0, r6
	add r2, r5, #0x2c
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x2f
	bl strlen
	mov r3, r0
	ldr r1, _0208A3D4 // =aBirth
	mov r0, r6
	add r2, r5, #0x2f
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x34
	bl strlen
	mov r3, r0
	ldr r1, _0208A3D8 // =aDevtime
	mov r0, r6
	add r2, r5, #0x34
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	add r0, r5, #0x7e
	bl wcslen
	mov r3, r0
	ldr r1, _0208A3DC // =aDevname
	mov r0, r6
	add r2, r5, #0x7e
	mov r3, r3, lsl #1
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	cmp r4, #1
	bne _0208A348
	add r0, r5, #0x4e
	bl strlen
	mov r3, r0
	ldr r1, _0208A3E0 // =_0211AFE8
	mov r0, r6
	add r2, r5, #0x4e
	bl sub_208AFE0
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
_0208A348:
	ldr r2, _0208A3E4 // =aNitroWifiSdkDD
	mov ip, #3
	add r0, sp, #4
	mov r1, #0x21
	mov r3, #1
	str ip, [sp]
	bl OS_SNPrintf
	ldr r1, _0208A3E8 // =aUserAgent
	add r2, sp, #4
	mov r0, r6
	bl sub_208B110
	cmp r0, #0
	addne sp, sp, #0x28
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r1, _0208A3EC // =aHttpXGamecd
	mov r0, r6
	add r2, r5, #0x15
	bl sub_208B110
	cmp r0, #0
	moveq r0, #1
	movne r0, #0
	add sp, sp, #0x28
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0208A3A8: .word a03d03d
_0208A3AC: .word aSdkver
_0208A3B0: .word aUserid
_0208A3B4: .word aPasswd
_0208A3B8: .word aBssid
_0208A3BC: .word aApinfo
_0208A3C0: .word aGamecd
_0208A3C4: .word aMakercd
_0208A3C8: .word aUnitcd
_0208A3CC: .word aMacadr
_0208A3D0: .word 0x0211AFC8
_0208A3D4: .word aBirth
_0208A3D8: .word aDevtime
_0208A3DC: .word aDevname
_0208A3E0: .word _0211AFE8
_0208A3E4: .word aNitroWifiSdkDD
_0208A3E8: .word aUserAgent
_0208A3EC: .word aHttpXGamecd
	arm_func_end sub_208A0A4

	arm_func_start sub_208A3F0
sub_208A3F0: // 0x0208A3F0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #0x8c
	mov r6, r1
	mov r1, #0
	mov r2, #0x94
	mov r4, r0
	bl MI_CpuFill8
	ldr r3, [r6]
	ldr r5, [r6, #4]
	mov r0, #0
	cmp r5, r0
	cmpeq r3, r0
	beq _0208A43C
	ldr r2, _0208A690 // =a013llu
	mov r0, r4
	mov r1, #0xe
	str r5, [sp]
	bl OS_SNPrintf
	b _0208A458
_0208A43C:
	ldr r3, [r6, #8]
	ldr r5, [r6, #0xc]
	ldr r2, _0208A690 // =a013llu
	mov r0, r4
	mov r1, #0xe
	str r5, [sp]
	bl OS_SNPrintf
_0208A458:
	ldrh r3, [r6, #0x10]
	ldr r2, _0208A694 // =_0211B02C
	add r0, r4, #0xe
	mov r1, #7
	bl OS_SNPrintf
	ldr r0, _0208A698 // =0x027FFE0C
	ldrb r0, [r0]
	cmp r0, #0
	bne _0208A480
	bl OS_Terminate
_0208A480:
	ldr r0, _0208A698 // =0x027FFE0C
	add r1, r4, #0x15
	mov r2, #4
	bl MI_CpuCopy8
	ldr r0, _0208A69C // =0x027FFE10
	ldrb r0, [r0]
	cmp r0, #0
	bne _0208A4A4
	bl OS_Terminate
_0208A4A4:
	ldr r0, _0208A69C // =0x027FFE10
	add r1, r4, #0x1a
	mov r2, #2
	bl MI_CpuCopy8
	mov r1, #0x30
	add r0, sp, #0x16
	strb r1, [r4, #0x1d]
	bl OS_GetMacAddress
	ldr r5, _0208A6A0 // =0x0211B034
	add r7, sp, #0x16
	add r6, r4, #0x1f
	mov r8, #0
_0208A4D4:
	ldrb r2, [r7]
	mov r0, r6
	mov r1, r5
	bl OS_SPrintf
	add r8, r8, #1
	cmp r8, #6
	add r7, r7, #1
	add r6, r6, #2
	blt _0208A4D4
	add r0, sp, #0x38
	bl OS_GetOwnerInfo
	ldrb r0, [sp, #0x38]
	ldr r2, _0208A6A0 // =0x0211B034
	mov r1, #3
	cmp r0, #6
	movhi r0, #1
	strhib r0, [sp, #0x38]
	ldrb r3, [sp, #0x38]
	add r0, r4, #0x2c
	bl OS_SNPrintf
	add r0, sp, #0x3c
	add r1, r4, #0x7e
	mov r2, #0x14
	bl MI_CpuCopy8
	ldrb r1, [sp, #0x3b]
	ldr r2, _0208A6A4 // =a02x02x
	add r0, r4, #0x2f
	str r1, [sp]
	ldrb r3, [sp, #0x3a]
	mov r1, #5
	bl OS_SNPrintf
	add r0, sp, #0x1c
	bl RTC_GetDate
	cmp r0, #0
	bne _0208A570
	add r0, sp, #0x2c
	bl RTC_GetTime
	cmp r0, #0
	beq _0208A57C
_0208A570:
	add sp, sp, #0x8c
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_0208A57C:
	ldr r0, [sp, #0x20]
	ldr r2, _0208A6A8 // =a02d02d02d02d02
	str r0, [sp]
	ldr r1, [sp, #0x24]
	add r0, r4, #0x34
	str r1, [sp, #4]
	ldr r3, [sp, #0x2c]
	mov r1, #0xd
	str r3, [sp, #8]
	ldr r3, [sp, #0x30]
	str r3, [sp, #0xc]
	ldr r3, [sp, #0x34]
	str r3, [sp, #0x10]
	ldr r3, [sp, #0x1c]
	bl OS_SNPrintf
	bl OS_DisableInterrupts
	mov r9, r0
	bl sub_20CC8AC
	mov r8, r0
	mov r1, #6
	bl DC_InvalidateRange
	cmp r8, #0
	bne _0208A5EC
	mov r0, r9
	bl OS_RestoreInterrupts
	add sp, sp, #0x8c
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_0208A5EC:
	add r7, r4, #0x41
	mov r6, #0
	ldr r5, _0208A6A0 // =0x0211B034
_0208A5F8:
	ldrb r2, [r8, r6]
	mov r0, r7
	mov r1, r5
	bl OS_SPrintf
	add r6, r6, #1
	cmp r6, #6
	add r7, r7, #2
	blt _0208A5F8
	bl sub_2086594
	mov r3, r0
	ldr r2, _0208A6AC // =a02d000000000
	add r0, r4, #0x6f
	mov r1, #0xe
	bl OS_SNPrintf
	add r0, sp, #0x14
	bl sub_20CC83C
	mov r5, r0
	mov r1, #0x20
	bl DC_InvalidateRange
	cmp r5, #0
	bne _0208A660
	mov r0, r9
	bl OS_RestoreInterrupts
	add sp, sp, #0x8c
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
_0208A660:
	mov r0, r5
	add r1, r4, #0x72
	bl sub_20890E4
	mov r0, r5
	add r1, r4, #0x4e
	mov r2, #0x20
	bl MI_CpuCopy8
	mov r0, r9
	bl OS_RestoreInterrupts
	mov r0, #1
	add sp, sp, #0x8c
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0208A690: .word a013llu
_0208A694: .word _0211B02C
_0208A698: .word 0x027FFE0C
_0208A69C: .word 0x027FFE10
_0208A6A0: .word 0x0211B034
_0208A6A4: .word a02x02x
_0208A6A8: .word a02d02d02d02d02
_0208A6AC: .word a02d000000000
	arm_func_end sub_208A3F0

	arm_func_start sub_208A6B0
sub_208A6B0: // 0x0208A6B0
	stmdb sp!, {r4, lr}
	sub sp, sp, #0x18
	mov r4, r0
	add r0, sp, #0
	bl sub_208E050
	add r1, sp, #0
	mov r0, r4
	bl sub_208A3F0
	add sp, sp, #0x18
	ldmia sp!, {r4, pc}
	arm_func_end sub_208A6B0

	arm_func_start sub_208A6D8
sub_208A6D8: // 0x0208A6D8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	add r0, r0, #0x1000
	mov r9, r2
	cmp r9, #0
	ldr r8, [r0, #0x14]
	mov r10, r1
	mov r7, #0
	addle sp, sp, #4
	ldmleia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r6, r7
	mov r5, r7
	mov r11, r7
	mov r4, r7
_0208A710:
	ldr r1, [r10, r7, lsl #3]
	cmp r1, #0
	beq _0208A72C
	ldr r0, _0208A764 // =aFreeArrayEntry
	mov r2, r6
	blx r8
	str r5, [r10, r7, lsl #3]
_0208A72C:
	add r0, r10, r7, lsl #3
	ldr r1, [r0, #4]
	cmp r1, #0
	beq _0208A750
	ldr r0, _0208A768 // =aFreeArrayEntry_0
	mov r2, r11
	blx r8
	add r0, r10, r7, lsl #3
	str r4, [r0, #4]
_0208A750:
	add r7, r7, #1
	cmp r7, r9
	blt _0208A710
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208A764: .word aFreeArrayEntry
_0208A768: .word aFreeArrayEntry_0
	arm_func_end sub_208A6D8

	arm_func_start sub_208A76C
sub_208A76C: // 0x0208A76C
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r2
	mov r5, r3
	bl sub_208A800
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl strlen
	cmp r0, r5
	movge r0, #0
	ldmgeia sp!, {r4, r5, r6, pc}
	mov r0, r6
	mov r1, r4
	bl strcpy
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_208A76C

	arm_func_start sub_208A7AC
sub_208A7AC: // 0x0208A7AC
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r2
	mov r5, r3
	bl sub_208A800
	movs r4, r0
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, pc}
	bl strlen
	mov r1, r0
	mov r0, r4
	mov r2, r6
	mov r3, r5
	bl sub_208D168
	mvn r1, #0
	cmp r0, r1
	ldmeqia sp!, {r4, r5, r6, pc}
	cmp r0, r5
	ldmhsia sp!, {r4, r5, r6, pc}
	mov r1, #0
	strb r1, [r6, r0]
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_208A7AC

	arm_func_start sub_208A800
sub_208A800: // 0x0208A800
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r0
	mov r5, r1
	mov r4, #0
_0208A810:
	add r0, r6, r4, lsl #3
	add r0, r0, #0x1000
	ldr r1, [r0, #0xa38]
	cmp r1, #0
	beq _0208A84C
	mov r0, r5
	bl strcmp
	cmp r0, #0
	addeq r0, r6, r4, lsl #3
	addeq r0, r0, #0x1000
	ldreq r0, [r0, #0xa3c]
	ldmeqia sp!, {r4, r5, r6, pc}
	add r4, r4, #1
	cmp r4, #0x20
	blt _0208A810
_0208A84C:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, pc}
	arm_func_end sub_208A800

	arm_func_start sub_208A854
sub_208A854: // 0x0208A854
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x14
	ldr r2, _0208AAE0 // =0x00001A38
	mov r11, r0
	add r0, r11, r2
	mov r6, r1
	mov r3, #0x20
	mov r1, #0
	mov r2, #0x100
	str r0, [sp, #8]
	str r3, [sp, #0xc]
	str r1, [sp, #0x10]
	bl MI_CpuFill8
	add r0, r11, #0x1000
	ldr r5, [r0, #0xa08]
	ldr r1, _0208AAE4 // =0x0211B0D8
	mov r0, r5
	bl strstr
	str r0, [sp]
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r0, #4
	bl strlen
	ldr r1, [sp]
	add r1, r1, #4
	add r0, r1, r0
	str r0, [sp, #4]
	ldr r1, _0208AAE8 // =0x0211B0E0
	mov r0, r5
	bl strstr
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r8, r0, #1
	ldrsb r7, [r8, #3]
	ldr r2, _0208AAEC // =aHttpresult_0
	mov r5, #0
	add r1, sp, #8
	mov r0, r11
	mov r3, r8
	strb r5, [r8, #3]
	bl sub_208AB04
	cmp r0, #1
	addne sp, sp, #0x14
	strneb r7, [r8, #3]
	movne r0, r5
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	strb r7, [r8, #3]
	cmp r6, #1
	beq _0208A940
	ldr r1, _0208AAF0 // =0x0211B0F0
	mov r0, r8
	mov r2, #3
	bl strncmp
	cmp r0, #0
	beq _0208A94C
_0208A940:
	add sp, sp, #0x14
	mov r0, #1
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208A94C:
	ldr r1, _0208AAF4 // =0x0211B0F4
	add r0, r8, #4
	bl strstr
	cmp r0, #0
	addeq sp, sp, #0x14
	moveq r0, r5
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r9, r0, #2
	mov r6, r5
	b _0208A9F8
_0208A974:
	ldr r1, _0208AAF8 // =0x0211B0F8
	mov r0, r9
	bl strstr
	movs r7, r0
	beq _0208AA10
	ldrsb r10, [r7]
	add r8, r7, #2
	ldr r1, _0208AAF4 // =0x0211B0F4
	mov r0, r8
	strb r6, [r7]
	bl strstr
	movs r5, r0
	streqb r10, [r7]
	beq _0208AA10
	ldrsb r4, [r5]
	mov r0, r11
	mov r2, r9
	strb r6, [r5]
	add r1, sp, #8
	mov r3, r8
	bl sub_208AB04
	cmp r0, #1
	strneb r10, [r7]
	addne sp, sp, #0x14
	strneb r4, [r5]
	movne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	mov r0, r8
	bl strlen
	strb r10, [r7]
	add r0, r8, r0
	strb r4, [r5]
	add r9, r0, #2
_0208A9F8:
	ldrsb r0, [r9]
	cmp r0, #0xd
	beq _0208AA10
	ldrsb r0, [r9, #1]
	cmp r0, #0xa
	bne _0208A974
_0208AA10:
	ldr r0, [sp]
	add r8, r0, #4
	ldr r0, [sp, #4]
	cmp r8, r0
	bhs _0208AAD4
	mov r5, #0
_0208AA28:
	ldr r1, _0208AAFC // =0x0211B0FC
	mov r0, r8
	bl strstr
	movs r10, r0
	beq _0208AAD4
	ldrsb r7, [r10]
	add r9, r10, #1
	ldr r1, _0208AB00 // =0x0211B100
	mov r0, r9
	strb r5, [r10]
	bl strstr
	movs r6, r0
	bne _0208AA6C
	ldr r1, _0208AAF4 // =0x0211B0F4
	mov r0, r9
	bl strstr
	mov r6, r0
_0208AA6C:
	cmp r6, #0
	ldrnesb r4, [r6]
	mov r0, r11
	mov r2, r8
	add r1, sp, #8
	mov r3, r9
	strneb r5, [r6]
	bl sub_208AB04
	cmp r0, #1
	beq _0208AAAC
	strb r7, [r10]
	cmp r6, #0
	add sp, sp, #0x14
	strneb r4, [r6]
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208AAAC:
	mov r0, r9
	bl strlen
	add r0, r9, r0
	add r8, r0, #1
	ldr r0, [sp, #4]
	strb r7, [r10]
	cmp r6, #0
	strneb r4, [r6]
	cmp r8, r0
	blo _0208AA28
_0208AAD4:
	mov r0, #1
	add sp, sp, #0x14
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208AAE0: .word 0x00001A38
_0208AAE4: .word 0x0211B0D8
_0208AAE8: .word 0x0211B0E0
_0208AAEC: .word aHttpresult_0
_0208AAF0: .word 0x0211B0F0
_0208AAF4: .word 0x0211B0F4
_0208AAF8: .word 0x0211B0F8
_0208AAFC: .word 0x0211B0FC
_0208AB00: .word 0x0211B100
	arm_func_end sub_208A854

	arm_func_start sub_208AB04
sub_208AB04: // 0x0208AB04
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r8, r1
	ldr r4, [r8, #8]
	ldr r1, [r8, #4]
	add r0, r0, #0x1000
	cmp r4, r1
	ldr r5, [r0, #0x10]
	ldr r4, [r0, #0x14]
	mov r7, r2
	mov r6, r3
	movgt r0, #0
	ldmgtia sp!, {r4, r5, r6, r7, r8, pc}
	mov r0, r7
	bl strlen
	mov r1, r0
	ldr r0, _0208AC50 // =aAllocResultEnt
	add r1, r1, #1
	blx r5
	ldr r2, [r8]
	ldr r1, [r8, #8]
	str r0, [r2, r1, lsl #3]
	ldr r3, [r8, #8]
	ldr r2, [r8]
	ldr r0, [r2, r3, lsl #3]
	cmp r0, #0
	beq _0208ABE8
	mov r0, r6
	bl strlen
	mov r1, r0
	ldr r0, _0208AC54 // =aAllocResultEnt_0
	add r1, r1, #1
	blx r5
	ldr r2, [r8]
	ldr r1, [r8, #8]
	add r1, r2, r1, lsl #3
	str r0, [r1, #4]
	ldr r3, [r8, #8]
	ldr r2, [r8]
	mov r1, r3, lsl #3
	add r0, r2, r3, lsl #3
	ldr r0, [r0, #4]
	cmp r0, #0
	beq _0208ABE8
	ldr r0, [r2, r1]
	mov r1, r7
	bl strcpy
	ldr r2, [r8]
	ldr r0, [r8, #8]
	mov r1, r6
	add r0, r2, r0, lsl #3
	ldr r0, [r0, #4]
	bl strcpy
	ldr r1, [r8, #8]
	mov r0, #1
	add r1, r1, #1
	str r1, [r8, #8]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0208ABE8:
	ldr r1, [r2, r3, lsl #3]
	cmp r1, #0
	beq _0208AC10
	ldr r0, _0208AC58 // =aFreeResultEntr
	mov r2, #0
	blx r4
	ldr r1, [r8]
	ldr r0, [r8, #8]
	mov r2, #0
	str r2, [r1, r0, lsl #3]
_0208AC10:
	ldr r1, [r8]
	ldr r0, [r8, #8]
	add r0, r1, r0, lsl #3
	ldr r1, [r0, #4]
	cmp r1, #0
	beq _0208AC48
	ldr r0, _0208AC5C // =aFreeResultEntr_0
	mov r2, #0
	blx r4
	ldr r1, [r8]
	ldr r0, [r8, #8]
	mov r2, #0
	add r0, r1, r0, lsl #3
	str r2, [r0, #4]
_0208AC48:
	mov r0, #0
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0208AC50: .word aAllocResultEnt
_0208AC54: .word aAllocResultEnt_0
_0208AC58: .word aFreeResultEntr
_0208AC5C: .word aFreeResultEntr_0
	arm_func_end sub_208AB04

	arm_func_start sub_208AC60
sub_208AC60: // 0x0208AC60
	stmdb sp!, {r4, r5, r6, lr}
	mov r6, r1
	mov r5, r0
	mov r0, r6
	mov r4, #0
	bl strlen
	cmp r0, #0x100
	movhs r0, r4
	ldmhsia sp!, {r4, r5, r6, pc}
	ldr r0, _0208ADAC // =0x00001024
	mov r1, r6
	add r0, r5, r0
	mov r2, #0x100
	bl strncpy
	mov r0, r6
	bl strlen
	ldr r1, _0208ADAC // =0x00001024
	mov r6, r0
	add r0, r5, r1
	bl strlen
	cmp r6, r0
	movne r0, r4
	ldmneia sp!, {r4, r5, r6, pc}
	ldr r0, _0208ADAC // =0x00001024
	ldr r1, _0208ADB0 // =aHttp
	add r0, r5, r0
	bl strstr
	cmp r0, #0
	beq _0208ACFC
	ldr r0, _0208ADB4 // =0x0000102B
	add r1, r5, #0x1000
	add r0, r5, r0
	str r0, [r1, #0x124]
	mov r0, r4
	str r0, [r1, #0x130]
	add r0, r5, #0x1100
	mov r1, #0x50
	strh r1, [r0, #0x34]
	b _0208AD38
_0208ACFC:
	ldr r0, _0208ADAC // =0x00001024
	ldr r1, _0208ADB8 // =aHttps
	add r0, r5, r0
	bl strstr
	cmp r0, #0
	moveq r0, r4
	ldmeqia sp!, {r4, r5, r6, pc}
	add r1, r0, #8
	add r0, r5, #0x1000
	str r1, [r0, #0x124]
	mov r2, #1
	ldr r1, _0208ADBC // =0x000001BB
	str r2, [r0, #0x130]
	add r0, r5, #0x1100
	strh r1, [r0, #0x34]
_0208AD38:
	add r0, r5, #0x1000
	ldr r0, [r0, #0x124]
	ldr r1, _0208ADC0 // =0x0211B190
	bl strstr
	cmp r0, #0
	movne r1, #0
	strneb r1, [r0]
	addne r4, r0, #1
	add r0, r5, #0x1000
	ldr r0, [r0, #0x124]
	ldr r1, _0208ADC4 // =0x0211B194
	bl strstr
	cmp r0, #0
	addeq r0, r5, #0x1000
	moveq r1, #0
	streq r1, [r0, #0x128]
	movne r1, #0
	strneb r1, [r0]
	addne r1, r0, #1
	addne r0, r5, #0x1000
	strne r1, [r0, #0x128]
	cmp r4, #0
	beq _0208ADA4
	mov r0, r4
	bl atoi
	add r1, r5, #0x1100
	strh r0, [r1, #0x34]
_0208ADA4:
	mov r0, #1
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0208ADAC: .word 0x00001024
_0208ADB0: .word aHttp
_0208ADB4: .word 0x0000102B
_0208ADB8: .word aHttps
_0208ADBC: .word 0x000001BB
_0208ADC0: .word 0x0211B190
_0208ADC4: .word 0x0211B194
	arm_func_end sub_208AC60

	arm_func_start sub_208ADC8
sub_208ADC8: // 0x0208ADC8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	add r0, r0, #0x1000
	mov r5, r2
	cmp r5, #0
	ldr r7, [r0, #0x14]
	ldr r2, [r0, #0x10]
	mov r6, r1
	addle sp, sp, #4
	movle r0, #0
	ldmleia sp!, {r4, r5, r6, r7, pc}
	ldr r1, [r6, #0xc]
	ldr r0, _0208AE80 // =aAllocNewptr
	add r1, r1, r5
	blx r2
	movs r4, r0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r6]
	ldr r2, [r6, #0xc]
	mov r1, r4
	bl MI_CpuCopy8
	ldr r1, [r6]
	ldr r0, _0208AE84 // =aFreeBufBuffer
	mov r2, #0
	blx r7
	cmp r4, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r6]
	ldr r1, [r6, #4]
	sub r0, r4, r0
	add r0, r1, r0
	str r0, [r6, #4]
	ldr r1, [r6, #0xc]
	mov r0, #1
	add r1, r1, r5
	str r1, [r6, #0xc]
	str r4, [r6]
	ldr r1, [r6, #0xc]
	add r1, r4, r1
	str r1, [r6, #8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0208AE80: .word aAllocNewptr
_0208AE84: .word aFreeBufBuffer
	arm_func_end sub_208ADC8

	arm_func_start sub_208AE88
sub_208AE88: // 0x0208AE88
	stmdb sp!, {r4, lr}
	mov r4, r1
	ldr r1, [r4]
	add r0, r0, #0x1000
	cmp r1, #0
	ldr r3, [r0, #0x14]
	beq _0208AEB0
	ldr r0, _0208AEC4 // =aFreeBufBuffer
	mov r2, #0
	blx r3
_0208AEB0:
	mov r0, r4
	mov r1, #0
	mov r2, #0x10
	bl MI_CpuFill8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208AEC4: .word aFreeBufBuffer
	arm_func_end sub_208AE88

	arm_func_start sub_208AEC8
sub_208AEC8: // 0x0208AEC8
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r2
	add r0, r0, #0x1000
	ldr r2, [r0, #0x10]
	mov r4, r1
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	ldr r0, _0208AF34 // =aAllocBufBuffer
	mov r1, r5
	blx r2
	str r0, [r4]
	ldr r0, [r4]
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, pc}
	str r0, [r4, #4]
	str r5, [r4, #0xc]
	ldr r2, [r4]
	ldr r1, [r4, #0xc]
	mov r0, #1
	add r1, r2, r1
	str r1, [r4, #8]
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0208AF34: .word aAllocBufBuffer
	arm_func_end sub_208AEC8

	arm_func_start sub_208AF38
sub_208AF38: // 0x0208AF38
	ands r1, r0, #0x8000
	bicne r0, r0, #0x8000
	bx lr
	arm_func_end sub_208AF38

	arm_func_start sub_208AF44
sub_208AF44: // 0x0208AF44
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	ldr r2, _0208AFD8 // =0x000019F8
	mov r7, r0
	mov r6, r1
	mov r0, r6
	add r4, r7, r2
	bl strlen
	mov r5, r0
	ldr r0, [r4, #4]
	ldr r1, [r4, #8]
	sub r1, r1, r0
	cmp r5, r1
	ble _0208AFAC
	sub r2, r5, r1
	mov r0, r7
	mov r1, r4
	add r2, r2, #1
	bl sub_208ADC8
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, [r4, #4]
	ldr r1, [r4, #8]
	sub r1, r1, r0
_0208AFAC:
	ldr r2, _0208AFDC // =0x0211B1D0
	mov r3, r6
	bl OS_SNPrintf
	cmp r0, r5
	ldreq r1, [r4, #4]
	movne r0, #1
	addeq r0, r1, r0
	streq r0, [r4, #4]
	moveq r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0208AFD8: .word 0x000019F8
_0208AFDC: .word 0x0211B1D0
	arm_func_end sub_208AF44

	arm_func_start sub_208AFE0
sub_208AFE0: // 0x0208AFE0
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	mov r10, r0
	add r0, r10, #0x1000
	ldr r4, [r0, #0x9f4]
	ldr r0, _0208B104 // =0x000019F8
	cmp r4, #0
	ldreq r6, _0208B108 // =0x0211B1D4
	mov r8, r2
	add r5, r10, #0x1000
	add r4, r10, r0
	ldr r0, [r5, #0x9f4]
	mov r7, r3
	add r11, r0, #1
	mov r2, #0
	mov r9, r1
	ldrne r6, _0208B10C // =0x0211B1D8
	mov r0, r8
	mov r1, r7
	mov r3, r2
	str r11, [r5, #0x9f4]
	bl sub_208D2F8
	mov r5, r0
	mov r0, r6
	bl strlen
	mov r11, r0
	mov r0, r9
	bl strlen
	sub r1, r11, #2
	add r2, r1, r0
	ldr r0, [r4, #4]
	ldr r1, [r4, #8]
	add r2, r5, r2
	sub r1, r1, r0
	cmp r2, r1
	ble _0208B0A0
	sub r2, r2, r1
	mov r0, r10
	mov r1, r4
	add r2, r2, #1
	bl sub_208ADC8
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, [r4, #4]
	ldr r1, [r4, #8]
	sub r1, r1, r0
_0208B0A0:
	mov r2, r6
	mov r3, r9
	bl OS_SNPrintf
	ldr r2, [r4, #4]
	mov r1, r7
	add r0, r2, r0
	str r0, [r4, #4]
	ldr r2, [r4, #4]
	ldr r3, [r4, #8]
	mov r0, r8
	sub r3, r3, r2
	sub r3, r3, #1
	bl sub_208D2F8
	cmp r0, #0
	addlt sp, sp, #4
	movlt r0, #1
	ldmltia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r1, [r4, #4]
	mov r0, #0
	add r1, r1, r5
	str r1, [r4, #4]
	ldr r1, [r4, #4]
	strb r0, [r1]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208B104: .word 0x000019F8
_0208B108: .word 0x0211B1D4
_0208B10C: .word 0x0211B1D8
	arm_func_end sub_208AFE0

	arm_func_start sub_208B110
sub_208B110: // 0x0208B110
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r6, r2
	mov r8, r0
	ldr r2, _0208B1F4 // =0x000019F8
	mov r0, r6
	mov r7, r1
	add r5, r8, r2
	bl strlen
	mov r4, r0
	ldr r0, _0208B1F8 // =aSS
	bl strlen
	mov r9, r0
	mov r0, r7
	bl strlen
	sub r1, r9, #4
	add r0, r1, r0
	add r4, r4, r0
	ldr r2, [r5, #8]
	ldr r1, [r5, #4]
	add r0, r4, #1
	sub r1, r2, r1
	cmp r0, r1
	ble _0208B194
	sub r2, r4, r1
	mov r0, r8
	mov r1, r5
	add r2, r2, #1
	bl sub_208ADC8
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, pc}
_0208B194:
	ldr r0, [r5]
	ldr r1, _0208B1FC // =0x0211B0D8
	bl strstr
	add r8, r0, #2
	ldrsb r9, [r0, #2]
	mov r0, r8
	bl strlen
	add r2, r0, #1
	add r0, r8, r4
	mov r1, r8
	bl memmove
	ldr r2, _0208B1F8 // =aSS
	str r6, [sp]
	mov r3, r7
	mov r0, r8
	add r1, r4, #1
	bl OS_SNPrintf
	strb r9, [r8, r0]
	ldr r1, [r5, #4]
	mov r0, #0
	add r1, r1, r4
	str r1, [r5, #4]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, pc}
	.align 2, 0
_0208B1F4: .word 0x000019F8
_0208B1F8: .word aSS
_0208B1FC: .word 0x0211B0D8
	arm_func_end sub_208B110

	arm_func_start sub_208B200
sub_208B200: // 0x0208B200
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	mov r7, r0
	add r0, r7, #0x1000
	ldr r1, [r0, #8]
	ldr r0, _0208B2B8 // =0x000019F8
	cmp r1, #0
	ldreq r6, _0208B2BC // =aPostSHttp10Con
	add r5, r7, r0
	add r0, r7, #0x1000
	ldrne r6, _0208B2C0 // =aGetSHttp10Host
	ldr r0, [r0, #0x124]
	bl strlen
	mov r4, r0
	mov r0, r6
	bl strlen
	add r1, r7, #0x1000
	mov r8, r0
	ldr r0, [r1, #0x128]
	bl strlen
	sub r1, r8, #4
	add r0, r1, r0
	add r1, r4, r0
	ldr r0, _0208B2B8 // =0x000019F8
	add r2, r1, #0x400
	add r1, r7, r0
	mov r0, r7
	bl sub_208AEC8
	cmp r0, #1
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	add r3, r7, #0x1000
	ldr r0, [r3, #0x124]
	mov r2, r6
	str r0, [sp]
	ldr r0, [r5, #4]
	ldr r1, [r5, #0xc]
	ldr r3, [r3, #0x128]
	bl OS_SNPrintf
	ldr r1, [r5, #4]
	add r0, r1, r0
	str r0, [r5, #4]
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0208B2B8: .word 0x000019F8
_0208B2BC: .word aPostSHttp10Con
_0208B2C0: .word aGetSHttp10Host
	arm_func_end sub_208B200

	arm_func_start sub_208B2C4
sub_208B2C4: // 0x0208B2C4
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	movs r5, r0
	add r1, r5, #0x1000
	ldr r4, [r1, #0x14]
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, _0208B378 // =0x00001A38
	mov r2, #0x20
	add r1, r5, r1
	bl sub_208A6D8
	ldr r1, _0208B37C // =0x00001A08
	mov r0, r5
	add r1, r5, r1
	bl sub_208AE88
	ldr r1, _0208B380 // =0x000019F8
	mov r0, r5
	add r1, r5, r1
	bl sub_208AE88
	add r0, r5, #0x1000
	ldr r1, [r0, #0x9cc]
	cmp r1, #0
	beq _0208B338
	ldr r0, _0208B384 // =aFreeHttpLowrec
	mov r2, #0
	blx r4
	add r0, r5, #0x1000
	mov r1, #0
	str r1, [r0, #0x9cc]
_0208B338:
	add r0, r5, #0x1000
	ldr r1, [r0, #0x9d0]
	cmp r1, #0
	beq _0208B360
	ldr r0, _0208B388 // =aFreeHttpLowsen
	mov r2, #0
	blx r4
	add r0, r5, #0x1000
	mov r1, #0
	str r1, [r0, #0x9d0]
_0208B360:
	ldr r2, _0208B38C // =0x00001C14
	mov r0, r5
	mov r1, #0
	bl MI_CpuFill8
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0208B378: .word 0x00001A38
_0208B37C: .word 0x00001A08
_0208B380: .word 0x000019F8
_0208B384: .word aFreeHttpLowrec
_0208B388: .word aFreeHttpLowsen
_0208B38C: .word 0x00001C14
	arm_func_end sub_208B2C4

	arm_func_start sub_208B390
sub_208B390: // 0x0208B390
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	mov r10, r0
	add r0, r10, #0x1000
	ldr r11, [r0, #0x1c]
	ldr r0, _0208B6A4 // =0x00001138
	ldr r1, _0208B6A8 // =0x0000119C
	ldr r2, _0208B6AC // =0x00001A08
	add r8, r10, r0
	cmp r11, #0
	mov r0, r10
	add r6, r10, r1
	add r7, r10, r2
	mov r5, #0
	ldrle r11, _0208B6B0 // =0x0000EA60
	bl sub_208B7DC
	mov r0, r10
	bl sub_208B7C8
	movs r4, r0
	addeq r0, r10, #0x1000
	moveq r1, #2
	streq r1, [r0, #0x20]
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r0, r10, #0x1000
	str r4, [r0, #0x12c]
	bl sub_20C0BA0
	add r0, r10, #0x1000
	ldr r0, [r0, #0x130]
	cmp r0, #1
	bne _0208B448
	mov r0, r6
	mov r1, #0
	mov r2, #0x830
	bl MI_CpuFill8
	ldr r1, _0208B6B4 // =sub_208AF38
	add r0, r10, #0x1000
	str r1, [r6, #0x810]
	ldr r1, [r0, #0x124]
	ldr r0, _0208B6B8 // =_0211B074
	str r1, [r6, #0x800]
	mov r1, #0xb
	str r6, [r8, #0xc]
	bl sub_20C76E4
	mov r0, #1
	bl sub_20C4348
_0208B448:
	add r0, r10, #0x1100
	ldrh r1, [r0, #0x34]
	mov r2, r4
	mov r0, #0
	bl sub_20C0BD4
	bl sub_20C0990
	cmp r0, #0
	beq _0208B484
	add r0, r10, #0x1000
	mov r1, #3
	str r1, [r0, #0x20]
	bl sub_20C0B80
	bl sub_20C0C6C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208B484:
	add r0, r10, #0x1000
	ldr r4, [r0, #0x9f8]
	mov r0, r4
	bl strlen
	mov r1, r0
	mov r0, r4
	bl sub_20C008C
	cmp r0, #0
	str r0, [sp, #8]
	addle r0, r10, #0x1000
	movle r1, #5
	strle r1, [r0, #0x20]
	ble _0208B68C
	bl sub_20BFFA8
	mov r0, r10
	bl sub_208B838
	cmp r0, #0
	addeq r0, r10, #0x1000
	moveq r1, #7
	streq r1, [r0, #0x20]
	beq _0208B68C
	ldr r0, [r7]
	str r0, [r7, #4]
	ldr r1, [r7]
	ldr r0, [r7, #0xc]
	add r0, r1, r0
	str r0, [r7, #8]
	bl OS_GetTick
	mov r6, r0
	mov r0, r11, asr #0x1f
	mov r8, r1
	str r0, [sp, #4]
	mov r4, #0
_0208B508:
	ldr r0, _0208B6BC // =0x0214587C
	ldr r0, [r0]
	cmp r0, #0
	addeq r0, r10, #0x1000
	moveq r1, #5
	streq r1, [r0, #0x20]
	beq _0208B68C
	bl sub_20BFFF8
	str r0, [sp, #8]
	cmp r0, #0
	blt _0208B668
	cmp r0, #0
	ble _0208B5EC
	bl OS_GetTick
	mov r6, r0
	add r0, sp, #8
	mov r8, r1
	bl sub_20C0694
	cmp r0, #0
	beq _0208B668
	ldr r2, [r7, #8]
	ldr r1, [r7, #4]
	sub r2, r2, #1
	ldr r9, [sp, #8]
	sub r2, r2, r1
	cmp r9, r2
	movge r9, r2
	mov r2, r9
	bl MI_CpuCopy8
	ldr r0, [r7, #4]
	cmp r5, #1
	add r0, r0, r9
	str r0, [r7, #4]
	ldr r0, [r7, #4]
	strb r4, [r0]
	bne _0208B5C4
	ldr r0, _0208B6C0 // =0x00001A18
	add r0, r10, r0
	bl OS_LockMutex
	add r1, r10, #0x1000
	ldr r2, [r1, #0xa34]
	ldr r0, _0208B6C0 // =0x00001A18
	add r2, r2, r9
	add r0, r10, r0
	str r2, [r1, #0xa34]
	bl OS_UnlockMutex
	b _0208B5D0
_0208B5C4:
	mov r0, r10
	bl sub_208B6C8
	mov r5, r0
_0208B5D0:
	ldr r0, [sp, #8]
	cmp r0, r9
	bls _0208B5E4
	bl sub_20C0588
	b _0208B668
_0208B5E4:
	mov r0, r9
	bl sub_20C0588
_0208B5EC:
	add r0, r10, #0x1000
	ldr r1, [r0, #0xa30]
	cmp r1, #0
	blt _0208B608
	ldr r0, [r0, #0xa34]
	cmp r0, r1
	bge _0208B668
_0208B608:
	bl OS_GetTick
	subs r2, r0, r6
	sbc r0, r1, r8
	mov r1, r0, lsl #6
	orr r1, r1, r2, lsr #26
	mov r0, r2, lsl #6
	ldr r2, _0208B6C4 // =0x000082EA
	mov r3, r4
	bl _ll_udiv
	ldr r2, [sp, #4]
	cmp r1, r2
	cmpeq r0, r11
	addhi r0, r10, #0x1000
	movhi r1, #6
	strhi r1, [r0, #0x20]
	bhi _0208B68C
	mov r0, r10
	bl sub_208B838
	cmp r0, #0
	bne _0208B508
	add r0, r10, #0x1000
	mov r1, #7
	str r1, [r0, #0x20]
	b _0208B68C
_0208B668:
	bl sub_20C089C
	bl sub_20C0808
	bl sub_20C0B80
	bl sub_20C0C6C
	add r0, r10, #0x1000
	mov r1, #8
	str r1, [r0, #0x20]
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
_0208B68C:
	bl sub_20C089C
	bl sub_20C0808
	bl sub_20C0B80
	bl sub_20C0C6C
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208B6A4: .word 0x00001138
_0208B6A8: .word 0x0000119C
_0208B6AC: .word 0x00001A08
_0208B6B0: .word 0x0000EA60
_0208B6B4: .word sub_208AF38
_0208B6B8: .word _0211B074
_0208B6BC: .word 0x0214587C
_0208B6C0: .word 0x00001A18
_0208B6C4: .word 0x000082EA
	arm_func_end sub_208B390

	arm_func_start sub_208B6C8
sub_208B6C8: // 0x0208B6C8
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r5, r0
	add r0, r5, #0x1000
	ldr r6, [r0, #0xa08]
	ldr r2, _0208B7B4 // =0x00001A08
	ldr r1, _0208B7B8 // =0x0211B0D8
	mov r0, r6
	add r4, r5, r2
	bl strstr
	cmp r0, #0
	addeq sp, sp, #4
	moveq r0, #0
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r1, _0208B7B8 // =0x0211B0D8
	mov r0, r6
	bl strstr
	ldr r1, _0208B7BC // =0x00001A18
	add r6, r0, #4
	add r0, r5, r1
	bl OS_LockMutex
	ldr r0, [r4, #4]
	ldr r1, _0208B7BC // =0x00001A18
	sub r2, r0, r6
	add r0, r5, #0x1000
	str r2, [r0, #0xa34]
	add r0, r5, r1
	bl OS_UnlockMutex
	ldr r0, [r4]
	ldr r1, _0208B7C0 // =aContentLength
	bl strstr
	movs r4, r0
	addeq sp, sp, #4
	moveq r0, #1
	ldmeqia sp!, {r4, r5, r6, r7, pc}
	ldr r0, _0208B7C0 // =aContentLength
	bl strlen
	add r7, r4, r0
	ldr r1, _0208B7C4 // =0x0211B0F4
	mov r0, r7
	bl strstr
	mov r4, r0
	ldr r0, _0208B7BC // =0x00001A18
	ldrsb r6, [r4]
	mov r1, #0
	add r0, r5, r0
	strb r1, [r4]
	bl OS_LockMutex
	mov r0, r7
	bl atoi
	add r1, r5, #0x1000
	ldr r2, _0208B7BC // =0x00001A18
	str r0, [r1, #0xa30]
	add r0, r5, r2
	bl OS_UnlockMutex
	strb r6, [r4]
	mov r0, #1
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, pc}
	.align 2, 0
_0208B7B4: .word 0x00001A08
_0208B7B8: .word 0x0211B0D8
_0208B7BC: .word 0x00001A18
_0208B7C0: .word aContentLength
_0208B7C4: .word 0x0211B0F4
	arm_func_end sub_208B6C8

	arm_func_start sub_208B7C8
sub_208B7C8: // 0x0208B7C8
	ldr ip, _0208B7D8 // =sub_20BEB68
	add r0, r0, #0x1000
	ldr r0, [r0, #0x124]
	bx ip
	.align 2, 0
_0208B7D8: .word sub_20BEB68
	arm_func_end sub_208B7C8

	arm_func_start sub_208B7DC
sub_208B7DC: // 0x0208B7DC
	stmdb sp!, {r4, lr}
	ldr r1, _0208B82C // =0x00001138
	mov r4, r0
	add r0, r4, r1
	mov r1, #0
	mov r2, #0x64
	bl MI_CpuFill8
	ldr r0, _0208B830 // =0x00000B68
	add r1, r4, #0x1000
	str r0, [r1, #0x174]
	ldr r3, [r1, #0x9cc]
	ldr r0, _0208B82C // =0x00001138
	ldr r2, _0208B834 // =0x000005EA
	str r3, [r1, #0x178]
	str r2, [r1, #0x180]
	ldr r2, [r1, #0x9d0]
	add r0, r4, r0
	str r2, [r1, #0x184]
	bl sub_20C0C84
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208B82C: .word 0x00001138
_0208B830: .word 0x00000B68
_0208B834: .word 0x000005EA
	arm_func_end sub_208B7DC

	arm_func_start sub_208B838
sub_208B838: // 0x0208B838
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1000
	ldr r0, [r0, #0x130]
	cmp r0, #1
	bne _0208B86C
	ldr r0, _0208B8B8 // =0x000019D4
	add r0, r4, r0
	bl OS_GetLowEntropyData
	ldr r0, _0208B8B8 // =0x000019D4
	mov r1, #0x20
	add r0, r4, r0
	bl sub_20C53C8
_0208B86C:
	ldr r0, _0208B8BC // =0x00001BF8
	add r0, r4, r0
	bl OS_LockMutex
	add r0, r4, #0x1000
	ldr r0, [r0, #0xc10]
	cmp r0, #1
	bne _0208B89C
	ldr r0, _0208B8BC // =0x00001BF8
	add r0, r4, r0
	bl OS_UnlockMutex
	mov r0, #0
	ldmia sp!, {r4, pc}
_0208B89C:
	ldr r0, _0208B8BC // =0x00001BF8
	add r0, r4, r0
	bl OS_UnlockMutex
	mov r0, #0xa
	bl OS_Sleep
	mov r0, #1
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208B8B8: .word 0x000019D4
_0208B8BC: .word 0x00001BF8
	arm_func_end sub_208B838

	arm_func_start sub_208B8C0
sub_208B8C0: // 0x0208B8C0
	stmdb sp!, {r4, lr}
	mov r4, r0
	add r0, r4, #0x1000
	ldrb r0, [r0]
	cmp r0, #0xff
	ldmneia sp!, {r4, pc}
	ldr r0, _0208B91C // =0x00001BF8
	add r0, r4, r0
	bl OS_LockMutex
	ldr r0, _0208B91C // =0x00001BF8
	add r1, r4, #0x1000
	mov r2, #1
	add r0, r4, r0
	str r2, [r1, #0xc10]
	bl OS_UnlockMutex
	add r0, r4, #0x1000
	ldr r0, [r0, #0xba4]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	ldr r0, _0208B920 // =0x00001B38
	add r0, r4, r0
	bl OS_JoinThread
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208B91C: .word 0x00001BF8
_0208B920: .word 0x00001B38
	arm_func_end sub_208B8C0

	arm_func_start sub_208B924
sub_208B924: // 0x0208B924
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #0xc
	ldr r3, _0208B9DC // =0x00001BF8
	mov r5, r0
	add r2, r5, #0x1000
	mov ip, #0
	add r0, r5, r3
	mov r4, r1
	str ip, [r2, #0xc10]
	bl OS_InitMutex
	ldr r0, _0208B9E0 // =0x00001A18
	add r0, r5, r0
	bl OS_InitMutex
	add r0, r5, #0x1000
	ldr r0, [r0, #0x18]
	cmp r0, #1
	ldreq r0, _0208B9E4 // =0x02143900
	moveq r1, #1
	streq r1, [r0]
	ldrne r0, _0208B9E4 // =0x02143900
	movne r1, #0
	strne r1, [r0]
	add r0, r5, #0x1000
	ldr r0, [r0, #0xba4]
	cmp r0, #0
	beq _0208B9A4
	ldr r0, _0208B9E8 // =0x00001B38
	add r0, r5, r0
	bl OS_IsThreadTerminated
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {r4, r5, pc}
_0208B9A4:
	ldr r0, _0208B9E8 // =0x00001B38
	mov r1, #0x1000
	str r1, [sp]
	ldr r1, _0208B9EC // =sub_208B390
	mov r2, r5
	add r0, r5, r0
	add r3, r5, #0x1000
	str r4, [sp, #4]
	bl OS_CreateThread
	ldr r0, _0208B9E8 // =0x00001B38
	add r0, r5, r0
	bl OS_WakeupThreadDirect
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0208B9DC: .word 0x00001BF8
_0208B9E0: .word 0x00001A18
_0208B9E4: .word 0x02143900
_0208B9E8: .word 0x00001B38
_0208B9EC: .word sub_208B390
	arm_func_end sub_208B924

	arm_func_start sub_208B9F0
sub_208B9F0: // 0x0208B9F0
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r1, _0208BA74 // =aConnection
	ldr r2, _0208BA78 // =aClose
	mov r4, r0
	bl sub_208B110
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, pc}
	add r0, r4, #0x1000
	ldr r0, [r0, #0x9f8]
	ldr r1, _0208BA7C // =0x0211B0D8
	bl strstr
	add r0, r0, #4
	bl strlen
	movs r3, r0
	beq _0208BA68
	ldr r2, _0208BA80 // =0x0211B2B8
	add r0, sp, #0
	mov r1, #7
	bl OS_SNPrintf
	ldr r1, _0208BA84 // =aContentLength_0
	add r2, sp, #0
	mov r0, r4
	bl sub_208B110
	cmp r0, #0
	addne sp, sp, #8
	movne r0, #1
	ldmneia sp!, {r4, pc}
_0208BA68:
	mov r0, #0
	add sp, sp, #8
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208BA74: .word aConnection
_0208BA78: .word aClose
_0208BA7C: .word 0x0211B0D8
_0208BA80: .word 0x0211B2B8
_0208BA84: .word aContentLength_0
	arm_func_end sub_208B9F0

	arm_func_start sub_208BA88
sub_208BA88: // 0x0208BA88
	stmdb sp!, {r4, r5, r6, lr}
	mov r5, r1
	ldr r2, _0208BB94 // =0x00001C14
	mov r6, r0
	ldr r4, [r5, #0xc]
	mov r1, #0
	bl MI_CpuFill8
	ldr r1, _0208BB98 // =0x00001004
	add r0, r6, #0x1000
	mvn r2, #0
	str r2, [r0, #0xa30]
	mov lr, r5
	str r2, [r0, #0xa34]
	add ip, r6, r1
	ldmia lr!, {r0, r1, r2, r3}
	stmia ip!, {r0, r1, r2, r3}
	ldmia lr, {r0, r1, r2}
	stmia ip, {r0, r1, r2}
	ldr r0, _0208BB9C // =aAllocHttpLowre
	ldr r1, _0208BBA0 // =0x00000B68
	blx r4
	add r1, r6, #0x1000
	str r0, [r1, #0x9cc]
	ldr r0, [r1, #0x9cc]
	cmp r0, #0
	moveq r0, #1
	streq r0, [r1, #0x20]
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r0, _0208BBA4 // =aAllocHttpLowse
	ldr r1, _0208BBA8 // =0x000005EA
	blx r4
	add r2, r6, #0x1000
	str r0, [r2, #0x9d0]
	ldr r0, [r2, #0x9d0]
	cmp r0, #0
	moveq r0, #1
	streq r0, [r2, #0x20]
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, _0208BBAC // =0x00001A08
	ldr r2, [r2, #0xc]
	mov r0, r6
	add r1, r6, r1
	bl sub_208AEC8
	cmp r0, #0
	addeq r1, r6, #0x1000
	moveq r0, #1
	streq r0, [r1, #0x20]
	ldmeqia sp!, {r4, r5, r6, pc}
	ldr r1, [r5]
	mov r0, r6
	bl sub_208AC60
	cmp r0, #0
	addeq r1, r6, #0x1000
	moveq r0, #1
	streq r0, [r1, #0x20]
	ldmeqia sp!, {r4, r5, r6, pc}
	mov r0, r6
	bl sub_208B200
	add r1, r6, #0x1000
	str r0, [r1, #0x20]
	ldr r0, [r1, #0x20]
	cmp r0, #0
	moveq r0, #0xff
	streqb r0, [r1]
	add r0, r6, #0x1000
	ldr r0, [r0, #0x20]
	ldmia sp!, {r4, r5, r6, pc}
	.align 2, 0
_0208BB94: .word 0x00001C14
_0208BB98: .word 0x00001004
_0208BB9C: .word aAllocHttpLowre
_0208BBA0: .word 0x00000B68
_0208BBA4: .word aAllocHttpLowse
_0208BBA8: .word 0x000005EA
_0208BBAC: .word 0x00001A08
	arm_func_end sub_208BA88

	arm_func_start sub_208BBB0
sub_208BBB0: // 0x0208BBB0
	stmdb sp!, {r4, lr}
	ldr r2, _0208BBF0 // =0x02143904
	ldr r1, _0208BBF4 // =0x000011DC
	ldr r2, [r2]
	mov r4, r0
	add r0, r2, r1
	bl OS_LockMutex
	ldr r2, _0208BBF0 // =0x02143904
	ldr r1, _0208BBF4 // =0x000011DC
	ldr r0, [r2]
	add r0, r0, #0x1000
	str r4, [r0]
	ldr r0, [r2]
	add r0, r0, r1
	bl OS_UnlockMutex
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208BBF0: .word 0x02143904
_0208BBF4: .word 0x000011DC
	arm_func_end sub_208BBB0

	arm_func_start sub_208BBF8
sub_208BBF8: // 0x0208BBF8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0x2d4
	ldr r5, _0208CB0C // =0x02143904
	mov r0, #0
	str r0, [sp]
	ldr r0, [r5]
	ldr r7, [sp]
	add r0, r0, #0x1000
	ldr r9, [r0, #0x108]
	ldr r8, [r0, #0x10c]
	mov r0, r7
	str r0, [sp, #8]
	str r0, [sp, #0x1c]
	mvn r0, #2
	str r0, [sp, #0x20]
	mov r0, r7
	str r0, [sp, #0x24]
	mvn r0, #3
	str r0, [sp, #0x28]
	mov r0, r7
	str r0, [sp, #0x2c]
	mov r0, #0x1000
	str r0, [sp, #0x14]
	mov r0, #5
	str r0, [sp, #0x30]
	mov r0, r7
	str r0, [sp, #0x34]
	str r0, [sp, #0x38]
	str r0, [sp, #0x3c]
	mov r0, #4
	str r0, [sp, #0x40]
	mov r0, r7
	str r0, [sp, #0x44]
	str r0, [sp, #0x48]
	str r0, [sp, #0x4c]
	str r0, [sp, #0x50]
	str r0, [sp, #0x58]
	str r0, [sp, #0x54]
	mvn r0, #4
	str r0, [sp, #0x5c]
	mov r0, r7
	str r0, [sp, #0x60]
	mvn r0, #1
	ldr r4, _0208CB10 // =0x02143914
	mov r6, #1
	str r0, [sp, #0x18]
_0208BCB0:
	ldr r0, _0208CB14 // =0x02143918
	ldr r1, [sp, #0x14]
	str r6, [r0, #4]
	str r1, [r0, #8]
	ldr r1, _0208CB18 // =0x00004E20
	str r9, [r0, #0xc]
	str r1, [r0, #0x18]
	str r8, [r0, #0x10]
	ldr r0, _0208CB1C // =0x0211B2FC
	ldr r1, [r5]
	ldr r2, [r0]
	ldr r0, _0208CB14 // =0x02143918
	add r1, r1, #0x1000
	str r2, [r0]
	ldr r0, [sp, #0x18]
	str r0, [r1, #4]
	ldr r0, [r4]
	ldr r1, _0208CB14 // =0x02143918
	bl sub_208BA88
	cmp r0, #0
	beq _0208BD1C
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #1
	bl sub_208BBB0
	b _0208CAB0
_0208BD1C:
	ldr r0, [r4]
	bl sub_208B9F0
	cmp r0, #0
	beq _0208BD44
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #1
	bl sub_208BBB0
	b _0208CAB0
_0208BD44:
	ldr r0, _0208CB20 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	bl OS_GetThreadPriority
	sub r1, r0, #1
	ldr r0, [r4]
	bl sub_208B924
	ldr r1, [r4]
	add r0, r1, #0x1000
	ldr r0, [r0, #0xba4]
	cmp r0, #0
	beq _0208BD7C
	ldr r0, _0208CB24 // =0x00001B38
	add r0, r1, r0
	bl OS_JoinThread
_0208BD7C:
	ldr r0, [r4]
	add r1, r0, #0x1000
	ldr r1, [r1, #0x20]
	cmp r1, #2
	beq _0208BD9C
	cmp r1, #8
	beq _0208BDC8
	b _0208BDB0
_0208BD9C:
	ldr r0, _0208CB0C // =0x02143904
	mvn r1, #0
	ldr r0, [r0]
	add r0, r0, #0x1000
	str r1, [r0, #4]
_0208BDB0:
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #3
	bl sub_208BBB0
	b _0208CAB0
_0208BDC8:
	ldr r1, [sp, #0x1c]
	bl sub_208A854
	cmp r0, #1
	beq _0208BDF0
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #2
	bl sub_208BBB0
	b _0208CAB0
_0208BDF0:
	ldr r0, [r4]
	ldr r1, _0208CB28 // =aHttpresult_1
	bl sub_208A800
	bl atoi
	mov r10, r0
	ldr r0, _0208CB2C // =_02152920
	ldr r0, [r0]
	cmp r0, #0x22
	bne _0208BE20
	mov r0, #2
	bl sub_208BBB0
	b _0208CAB0
_0208BE20:
	cmp r10, #0xc8
	beq _0208BE38
	ldr r0, _0208CB30 // =0x0000012E
	cmp r10, r0
	beq _0208BE50
	b _0208C138
_0208BE38:
	ldr r0, [r4]
	add r0, r0, #0x1000
	ldr r1, [r0, #0x12c]
	ldr r0, _0208CB34 // =0x0214390C
	str r1, [r0]
	b _0208C150
_0208BE50:
	ldr r0, _0208CB38 // =0x02143908
	str r6, [r0]
	ldr r0, [r5]
	add r0, r0, #0x1000
	ldr r1, [r0, #0x118]
	cmp r1, #0
	beq _0208C0A8
	ldr r1, _0208CB10 // =0x02143914
	mvn r2, #5
	str r2, [r0, #4]
	ldr r0, [r1]
	bl sub_208B2C4
	ldr r2, _0208CB14 // =0x02143918
	ldr r0, _0208CB3C // =_0211AE44
	ldr r3, _0208CB18 // =0x00004E20
	ldr r0, [r0]
	mov r5, #0
	mov r4, #0x200
	ldr r1, _0208CB40 // =aHttpsNasNinten_0
	str r0, [r2]
	str r5, [r2, #4]
	str r4, [r2, #8]
	str r9, [r2, #0xc]
	str r8, [r2, #0x10]
	str r3, [r2, #0x18]
	bl strcmp
	cmp r0, #0
	ldrne r0, _0208CB14 // =0x02143918
	movne r1, #1
	strne r1, [r0, #0x14]
	ldr r0, _0208CB10 // =0x02143914
	ldr r1, _0208CB14 // =0x02143918
	ldr r0, [r0]
	bl sub_208BA88
	cmp r0, #0
	beq _0208BEF8
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #1
	bl sub_208BBB0
	b _0208CAB0
_0208BEF8:
	add r0, sp, #0x240
	bl sub_208A6B0
	cmp r0, #0
	beq _0208BF24
	ldr r0, _0208CB10 // =0x02143914
	add r1, sp, #0x240
	ldr r0, [r0]
	mov r2, #1
	bl sub_208A0A4
	cmp r0, #0
	bne _0208BF3C
_0208BF24:
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #8
	bl sub_208BBB0
	b _0208CAB0
_0208BF3C:
	ldr r0, _0208CB10 // =0x02143914
	ldr r1, _0208CB44 // =aAction_0
	ldr r0, [r0]
	ldr r2, _0208CB48 // =aMessage
	mov r3, #7
	bl sub_208AFE0
	cmp r0, #0
	bne _0208BF94
	ldr r0, _0208CB0C // =0x02143904
	ldr r0, [r0]
	add r0, r0, #0x1000
	ldr r4, [r0, #0x118]
	mov r0, r4
	bl strlen
	ldr r1, _0208CB10 // =0x02143914
	mov r3, r0
	ldr r0, [r1]
	ldr r1, _0208CB4C // =aHotspotrespons
	mov r2, r4
	bl sub_208AFE0
	cmp r0, #0
	beq _0208BFAC
_0208BF94:
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #8
	bl sub_208BBB0
	b _0208CAB0
_0208BFAC:
	ldr r1, _0208CB0C // =0x02143904
	ldr r0, _0208CB50 // =aFreeDwcnetchec
	ldr r1, [r1]
	mov r2, #0
	add r1, r1, #0x1000
	ldr r1, [r1, #0x118]
	blx r8
	ldr r0, _0208CB0C // =0x02143904
	mov r2, #0
	ldr r0, [r0]
	ldr r1, _0208CB10 // =0x02143914
	add r0, r0, #0x1000
	str r2, [r0, #0x118]
	ldr r0, [r1]
	bl sub_208B9F0
	cmp r0, #0
	beq _0208C008
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #1
	bl sub_208BBB0
	b _0208CAB0
_0208C008:
	ldr r0, _0208CB20 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	bl OS_GetThreadPriority
	ldr r2, _0208CB10 // =0x02143914
	sub r1, r0, #1
	ldr r0, [r2]
	bl sub_208B924
	ldr r0, _0208CB10 // =0x02143914
	ldr r1, [r0]
	add r0, r1, #0x1000
	ldr r0, [r0, #0xba4]
	cmp r0, #0
	beq _0208C048
	ldr r0, _0208CB24 // =0x00001B38
	add r0, r1, r0
	bl OS_JoinThread
_0208C048:
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	add r1, r0, #0x1000
	ldr r1, [r1, #0x20]
	cmp r1, #2
	beq _0208C06C
	cmp r1, #8
	beq _0208C098
	b _0208C080
_0208C06C:
	ldr r0, _0208CB0C // =0x02143904
	mvn r1, #0
	ldr r0, [r0]
	add r0, r0, #0x1000
	str r1, [r0, #4]
_0208C080:
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #3
	bl sub_208BBB0
	b _0208CAB0
_0208C098:
	bl sub_208B2C4
	mov r0, #7
	bl sub_208BBB0
	b _0208CAB0
_0208C0A8:
	ldr r0, [r4]
	add r1, r0, #0x1000
	ldr r11, [r1, #0xa08]
	cmp r11, #0
	bne _0208C0CC
	bl sub_208B2C4
	mov r0, #2
	bl sub_208BBB0
	b _0208CAB0
_0208C0CC:
	mov r0, r11
	bl strlen
	add r1, r0, #1
	ldr r0, _0208CB54 // =aAllocDwcnetche
	blx r9
	ldr r1, [r5]
	add r1, r1, #0x1000
	str r0, [r1, #0x114]
	ldr r0, [r5]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x114]
	str r0, [sp, #0xc]
	cmp r0, #0
	bne _0208C11C
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #4
	bl sub_208BBB0
	b _0208CAB0
_0208C11C:
	mov r0, r11
	bl strlen
	mov r2, r0
	ldr r0, [sp, #0xc]
	mov r1, r11
	bl strncpy
	b _0208C150
_0208C138:
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #0xa
	bl sub_208BBB0
	b _0208CAB0
_0208C150:
	ldr r0, [r4]
	bl sub_208B2C4
	add r0, sp, #0x68
	bl sub_208E050
	ldr r2, [sp, #0x68]
	ldr r1, [sp, #0x6c]
	mov r0, #0
	cmp r1, r0
	cmpeq r2, r0
	bne _0208C288
	ldr r1, [r5]
	ldr r0, _0208CB58 // =0x02143934
	add r2, r1, #0x1000
	ldr r1, [sp, #0x20]
	str r1, [r2, #4]
	ldr r2, [sp, #0x24]
	mov r1, r0
	strh r2, [r1]
	strb r2, [r1, #0x34]
	ldr r2, [r5]
	ldr r1, [r4]
	add r3, r2, #0x1000
	ldr r11, [r3, #0x108]
	mov r2, r0
	str r11, [r2, #0x40]
	ldr r3, [r3, #0x10c]
	str r3, [r2, #0x44]
	bl sub_2089F44
	cmp r0, #0
	beq _0208C1D4
	mov r0, #5
	bl sub_208BBB0
	b _0208CAB0
_0208C1D4:
	bl sub_2089D54
	bl sub_2089D04
	cmp r0, #0x15
	beq _0208C284
	bl sub_2089D04
	cmp r0, #9
	bne _0208C208
	ldr r0, _0208CB0C // =0x02143904
	mvn r1, #0
	ldr r0, [r0]
	add r0, r0, #0x1000
	str r1, [r0, #4]
	b _0208C274
_0208C208:
	add r0, sp, #0x7c
	bl sub_2089C70
	ldr r0, _0208CB5C // =0x02143910
	ldr r0, [r0]
	cmp r0, #1
	bne _0208C260
	ldr r1, [sp, #0x7c]
	ldr r0, _0208CB60 // =0xFFFFA4FA
	cmp r1, r0
	beq _0208C23C
	bl sub_2089D04
	cmp r0, #0xb
	bne _0208C260
_0208C23C:
	ldr r0, _0208CB0C // =0x02143904
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, #0x1000
	str r1, [r0, #4]
	bl sub_2089D94
	mov r0, #0xb
	bl sub_208BBB0
	b _0208CAB0
_0208C260:
	ldr r0, _0208CB0C // =0x02143904
	ldr r1, [sp, #0x7c]
	ldr r0, [r0]
	add r0, r0, #0x1000
	str r1, [r0, #4]
_0208C274:
	bl sub_2089D94
	mov r0, #6
	bl sub_208BBB0
	b _0208CAB0
_0208C284:
	bl sub_2089D94
_0208C288:
	cmp r10, #0xc8
	bne _0208C2B0
	ldr r0, _0208CB0C // =0x02143904
	mov r2, #0
	ldr r1, [r0]
	mov r0, #0xb
	add r1, r1, #0x1000
	str r2, [r1, #4]
	bl sub_208BBB0
	b _0208CAB0
_0208C2B0:
	ldr r0, [r5]
	ldr r1, _0208CB40 // =aHttpsNasNinten_0
	add r2, r0, #0x1000
	ldr r0, [sp, #0x28]
	str r0, [r2, #4]
	ldr r0, _0208CB14 // =0x02143918
	ldr r2, [sp, #0x2c]
	str r9, [r0, #0xc]
	str r2, [r0, #4]
	ldr r2, [sp, #0x14]
	str r8, [r0, #0x10]
	str r2, [r0, #8]
	ldr r2, _0208CB64 // =0x00009C40
	str r2, [r0, #0x18]
	ldr r0, _0208CB3C // =_0211AE44
	ldr r2, _0208CB14 // =0x02143918
	ldr r0, [r0]
	str r0, [r2]
	bl strcmp
	cmp r0, #0
	ldrne r0, _0208CB14 // =0x02143918
	ldr r1, _0208CB14 // =0x02143918
	strne r6, [r0, #0x14]
	ldr r0, [r4]
	bl sub_208BA88
	cmp r0, #0
	beq _0208C334
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #1
	bl sub_208BBB0
	b _0208CAB0
_0208C334:
	add r0, sp, #0x240
	bl sub_208A6B0
	cmp r0, #0
	beq _0208C35C
	ldr r0, [r4]
	add r1, sp, #0x240
	mov r2, r6
	bl sub_208A0A4
	cmp r0, #0
	bne _0208C374
_0208C35C:
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #8
	bl sub_208BBB0
	b _0208CAB0
_0208C374:
	ldr r0, [r4]
	ldr r1, _0208CB44 // =aAction_0
	ldr r2, _0208CB68 // =aParse
	ldr r3, [sp, #0x30]
	bl sub_208AFE0
	cmp r0, #0
	bne _0208C3C0
	ldr r0, [r5]
	add r0, r0, #0x1000
	ldr r10, [r0, #0x114]
	mov r0, r10
	bl strlen
	mov r3, r0
	ldr r0, [r4]
	ldr r1, _0208CB6C // =0x0211B41C
	mov r2, r10
	bl sub_208AFE0
	cmp r0, #0
	beq _0208C3D8
_0208C3C0:
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #8
	bl sub_208BBB0
	b _0208CAB0
_0208C3D8:
	ldr r1, [r5]
	ldr r0, _0208CB70 // =aFreeDwcnetchec_0
	add r1, r1, #0x1000
	ldr r2, [sp, #0x34]
	ldr r1, [r1, #0x114]
	blx r8
	ldr r0, [r5]
	add r1, r0, #0x1000
	ldr r0, [sp, #0x38]
	str r0, [r1, #0x114]
	ldr r0, [r4]
	bl sub_208B9F0
	cmp r0, #0
	beq _0208C428
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #1
	bl sub_208BBB0
	b _0208CAB0
_0208C428:
	ldr r0, _0208CB20 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	bl OS_GetThreadPriority
	sub r1, r0, #1
	ldr r0, [r4]
	bl sub_208B924
	ldr r1, [r4]
	add r0, r1, #0x1000
	ldr r0, [r0, #0xba4]
	cmp r0, #0
	beq _0208C460
	ldr r0, _0208CB24 // =0x00001B38
	add r0, r1, r0
	bl OS_JoinThread
_0208C460:
	ldr r0, [r4]
	add r1, r0, #0x1000
	ldr r1, [r1, #0x20]
	cmp r1, #2
	beq _0208C4C8
	cmp r1, #3
	beq _0208C488
	cmp r1, #8
	beq _0208C4F4
	b _0208C4DC
_0208C488:
	bl sub_208B2C4
	ldr r0, _0208CB5C // =0x02143910
	ldr r0, [r0]
	cmp r0, #1
	bne _0208C4BC
	ldr r0, _0208CB0C // =0x02143904
	mov r2, #0
	ldr r1, [r0]
	mov r0, #0xb
	add r1, r1, #0x1000
	str r2, [r1, #4]
	bl sub_208BBB0
	b _0208CAB0
_0208C4BC:
	mov r0, #3
	bl sub_208BBB0
	b _0208CAB0
_0208C4C8:
	ldr r0, _0208CB0C // =0x02143904
	mvn r1, #0
	ldr r0, [r0]
	add r0, r0, #0x1000
	str r1, [r0, #4]
_0208C4DC:
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #3
	bl sub_208BBB0
	b _0208CAB0
_0208C4F4:
	ldr r1, [sp, #0x3c]
	bl sub_208A854
	cmp r0, #1
	beq _0208C51C
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #2
	bl sub_208BBB0
	b _0208CAB0
_0208C51C:
	ldr r0, [r4]
	ldr r1, _0208CB28 // =aHttpresult_1
	bl sub_208A800
	bl atoi
	mov r10, r0
	ldr r0, _0208CB2C // =_02152920
	ldr r0, [r0]
	cmp r0, #0x22
	bne _0208C558
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #2
	bl sub_208BBB0
	b _0208CAB0
_0208C558:
	cmp r10, #0xc8
	beq _0208C5B4
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	ldr r0, _0208CB5C // =0x02143910
	ldr r0, [r0]
	cmp r0, #1
	bne _0208C5A8
	ldr r0, _0208CB30 // =0x0000012E
	cmp r10, r0
	bne _0208C5A8
	ldr r0, _0208CB0C // =0x02143904
	mov r2, #0
	ldr r1, [r0]
	mov r0, #0xb
	add r1, r1, #0x1000
	str r2, [r1, #4]
	bl sub_208BBB0
	b _0208CAB0
_0208C5A8:
	mov r0, #2
	bl sub_208BBB0
	b _0208CAB0
_0208C5B4:
	ldr r0, [r4]
	ldr r1, _0208CB74 // =aReturncd_0
	ldr r3, [sp, #0x40]
	add r2, sp, #0x64
	bl sub_208A7AC
	cmp r0, #0
	bgt _0208C5E8
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #9
	bl sub_208BBB0
	b _0208CAB0
_0208C5E8:
	add r0, sp, #0x64
	bl atoi
	ldr r1, _0208CB2C // =_02152920
	ldr r1, [r1]
	cmp r1, #0x22
	bne _0208C618
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #9
	bl sub_208BBB0
	b _0208CAB0
_0208C618:
	ldr r1, _0208CB5C // =0x02143910
	ldr r1, [r1]
	cmp r1, #1
	bne _0208C650
	cmp r0, #0x72
	bne _0208C650
	ldr r0, _0208CB0C // =0x02143904
	mov r2, #0
	ldr r1, [r0]
	mov r0, #0xb
	add r1, r1, #0x1000
	str r2, [r1, #4]
	bl sub_208BBB0
	b _0208CAB0
_0208C650:
	cmp r0, #0x64
	blt _0208C670
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #6
	bl sub_208BBB0
	b _0208CAB0
_0208C670:
	ldr r2, [sp, #0x44]
	ldr r0, [r4]
	ldr r1, _0208CB78 // =0x0211B430
	mov r3, r2
	bl sub_208A7AC
	mov r11, r0
	cmp r11, #0
	bgt _0208C6A8
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #9
	bl sub_208BBB0
	b _0208CAB0
_0208C6A8:
	ldr r2, [sp, #0x48]
	ldr r0, [r4]
	ldr r1, _0208CB7C // =0x0211B434
	mov r3, r2
	bl sub_208A7AC
	str r0, [sp, #4]
	cmp r0, #0
	bgt _0208C6E0
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #9
	bl sub_208BBB0
	b _0208CAB0
_0208C6E0:
	ldr r2, [sp, #0x4c]
	ldr r0, [r4]
	ldr r1, _0208CB80 // =0x0211B43C
	mov r3, r2
	bl sub_208A7AC
	mov r10, r0
	ldr r0, _0208CB84 // =aAllocUrl
	add r1, r11, #1
	blx r9
	str r0, [sp]
	cmp r0, #0
	bne _0208C728
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #4
	bl sub_208BBB0
	b _0208CAB0
_0208C728:
	ldr r1, [sp, #4]
	ldr r0, _0208CB88 // =aAllocDataLen
	add r1, r1, #1
	blx r9
	movs r7, r0
	bne _0208C758
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #4
	bl sub_208BBB0
	b _0208CAB0
_0208C758:
	cmp r10, #0
	ble _0208C790
	ldr r0, _0208CB8C // =aAllocWaitLen
	add r1, r10, #1
	blx r9
	str r0, [sp, #8]
	cmp r0, #0
	bne _0208C790
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #4
	bl sub_208BBB0
	b _0208CAB0
_0208C790:
	ldr r0, [r4]
	ldr r1, _0208CB78 // =0x0211B430
	ldr r2, [sp]
	add r3, r11, #1
	bl sub_208A7AC
	cmp r0, #0
	bge _0208C7C4
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #9
	bl sub_208BBB0
	b _0208CAB0
_0208C7C4:
	ldr r1, [sp, #4]
	ldr r2, [sp, #0x50]
	add r3, r1, #1
	ldr r1, [sp]
	strb r2, [r1, r0]
	ldr r0, [r4]
	ldr r1, _0208CB7C // =0x0211B434
	mov r2, r7
	bl sub_208A7AC
	cmp r0, #0
	bge _0208C808
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #9
	bl sub_208BBB0
	b _0208CAB0
_0208C808:
	ldr r1, [sp, #0x54]
	cmp r10, #0
	strb r1, [r7, r0]
	mov r11, r1
	ble _0208C8A0
	ldr r0, [r4]
	ldr r1, _0208CB80 // =0x0211B43C
	ldr r2, [sp, #8]
	add r3, r10, #1
	bl sub_208A7AC
	cmp r0, #0
	bge _0208C850
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #9
	bl sub_208BBB0
	b _0208CAB0
_0208C850:
	ldr r2, [sp, #0x58]
	ldr r1, [sp, #8]
	strb r2, [r1, r0]
	mov r0, r1
	bl atoi
	ldr r1, _0208CB2C // =_02152920
	ldr r1, [r1]
	cmp r1, #0x22
	bne _0208C88C
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #9
	bl sub_208BBB0
	b _0208CAB0
_0208C88C:
	mov r1, #0x3e8
	mul r11, r0, r1
	ldr r0, _0208CB90 // =0x0002BF20
	cmp r11, r0
	movgt r11, r0
_0208C8A0:
	ldr r0, [r4]
	bl sub_208B2C4
	ldr r0, [r5]
	ldr r1, _0208CB14 // =0x02143918
	add r2, r0, #0x1000
	ldr r0, [sp, #0x5c]
	str r0, [r2, #4]
	mov r0, r1
	ldr r2, [sp]
	str r9, [r0, #0xc]
	str r2, [r0]
	ldr r2, [sp, #0x60]
	str r8, [r0, #0x10]
	str r2, [r0, #4]
	ldr r2, [sp, #0x14]
	str r2, [r0, #8]
	ldr r2, _0208CB94 // =0x0001D4C0
	str r2, [r0, #0x18]
	ldr r0, [r4]
	bl sub_208BA88
	cmp r0, #0
	beq _0208C910
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #1
	bl sub_208BBB0
	b _0208CAB0
_0208C910:
	ldr r0, [r4]
	mov r1, r7
	bl sub_208AF44
	cmp r0, #0
	beq _0208C93C
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #8
	bl sub_208BBB0
	b _0208CAB0
_0208C93C:
	ldr r0, [r4]
	bl sub_208B9F0
	cmp r0, #0
	beq _0208C964
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #1
	bl sub_208BBB0
	b _0208CAB0
_0208C964:
	ldr r0, _0208CB20 // =OSi_ThreadInfo
	ldr r0, [r0, #4]
	bl OS_GetThreadPriority
	sub r1, r0, #1
	ldr r0, [r4]
	bl sub_208B924
	ldr r1, [r4]
	add r0, r1, #0x1000
	ldr r0, [r0, #0xba4]
	cmp r0, #0
	beq _0208C99C
	ldr r0, _0208CB24 // =0x00001B38
	add r0, r1, r0
	bl OS_JoinThread
_0208C99C:
	ldr r0, [r4]
	add r1, r0, #0x1000
	ldr r1, [r1, #0x20]
	cmp r1, #2
	beq _0208C9BC
	cmp r1, #8
	beq _0208C9E8
	b _0208C9D0
_0208C9BC:
	ldr r0, _0208CB0C // =0x02143904
	mvn r1, #0
	ldr r0, [r0]
	add r0, r0, #0x1000
	str r1, [r0, #4]
_0208C9D0:
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #3
	bl sub_208BBB0
	b _0208CAB0
_0208C9E8:
	mov r1, r6
	bl sub_208A854
	cmp r0, #1
	beq _0208CA10
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #2
	bl sub_208BBB0
	b _0208CAB0
_0208CA10:
	ldr r0, [r4]
	add r1, r0, #0x1000
	ldr r10, [r1, #0xa08]
	cmp r10, #0
	bne _0208CA34
	bl sub_208B2C4
	mov r0, #2
	bl sub_208BBB0
	b _0208CAB0
_0208CA34:
	mov r0, r10
	bl strlen
	add r1, r0, #1
	ldr r0, _0208CB98 // =aAllocDwcnetche_0
	blx r9
	ldr r1, [r5]
	add r1, r1, #0x1000
	str r0, [r1, #0x118]
	ldr r0, [r5]
	add r0, r0, #0x1000
	ldr r0, [r0, #0x118]
	str r0, [sp, #0x10]
	cmp r0, #0
	bne _0208CA84
	ldr r0, _0208CB10 // =0x02143914
	ldr r0, [r0]
	bl sub_208B2C4
	mov r0, #4
	bl sub_208BBB0
	b _0208CAB0
_0208CA84:
	mov r0, r10
	bl strlen
	mov r2, r0
	ldr r0, [sp, #0x10]
	mov r1, r10
	bl strncpy
	ldr r0, [r4]
	bl sub_208B2C4
	mov r0, r11
	bl OS_Sleep
	b _0208BCB0
_0208CAB0:
	ldr r0, [sp]
	cmp r0, #0
	beq _0208CACC
	ldr r0, _0208CB9C // =aFreeUrl
	ldr r1, [sp]
	mov r2, #0
	blx r8
_0208CACC:
	cmp r7, #0
	beq _0208CAE4
	ldr r0, _0208CBA0 // =aFreeData
	mov r1, r7
	mov r2, #0
	blx r8
_0208CAE4:
	ldr r0, [sp, #8]
	cmp r0, #0
	addeq sp, sp, #0x2d4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	ldr r0, _0208CBA4 // =aFreeWait
	ldr r1, [sp, #8]
	mov r2, #0
	blx r8
	add sp, sp, #0x2d4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208CB0C: .word 0x02143904
_0208CB10: .word 0x02143914
_0208CB14: .word 0x02143918
_0208CB18: .word 0x00004E20
_0208CB1C: .word 0x0211B2FC
_0208CB20: .word OSi_ThreadInfo
_0208CB24: .word 0x00001B38
_0208CB28: .word aHttpresult_1
_0208CB2C: .word _02152920
_0208CB30: .word 0x0000012E
_0208CB34: .word 0x0214390C
_0208CB38: .word 0x02143908
_0208CB3C: .word _0211AE44
_0208CB40: .word aHttpsNasNinten_0
_0208CB44: .word aAction_0
_0208CB48: .word aMessage
_0208CB4C: .word aHotspotrespons
_0208CB50: .word aFreeDwcnetchec
_0208CB54: .word aAllocDwcnetche
_0208CB58: .word 0x02143934
_0208CB5C: .word 0x02143910
_0208CB60: .word 0xFFFFA4FA
_0208CB64: .word 0x00009C40
_0208CB68: .word aParse
_0208CB6C: .word 0x0211B41C
_0208CB70: .word aFreeDwcnetchec_0
_0208CB74: .word aReturncd_0
_0208CB78: .word 0x0211B430
_0208CB7C: .word 0x0211B434
_0208CB80: .word 0x0211B43C
_0208CB84: .word aAllocUrl
_0208CB88: .word aAllocDataLen
_0208CB8C: .word aAllocWaitLen
_0208CB90: .word 0x0002BF20
_0208CB94: .word 0x0001D4C0
_0208CB98: .word aAllocDwcnetche_0
_0208CB9C: .word aFreeUrl
_0208CBA0: .word aFreeData
_0208CBA4: .word aFreeWait
	arm_func_end sub_208BBF8

	arm_func_start sub_208CBA8
sub_208CBA8: // 0x0208CBA8
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r0, _0208CC28 // =0x02143904
	ldr r1, [r0]
	add r0, r1, #0x1000
	ldr r0, [r0, #0x188]
	cmp r0, #0
	beq _0208CBE0
	ldr r0, _0208CC2C // =0x0000111C
	add r0, r1, r0
	bl OS_IsThreadTerminated
	cmp r0, #0
	addeq sp, sp, #0xc
	ldmeqia sp!, {pc}
_0208CBE0:
	ldr r1, _0208CC28 // =0x02143904
	ldr r0, _0208CC2C // =0x0000111C
	ldr r2, [r1]
	mov r3, #0x1000
	ldr r1, _0208CC30 // =sub_208BBF8
	str r3, [sp]
	mov ip, #0x10
	add r0, r2, r0
	add r3, r2, #0x1000
	str ip, [sp, #4]
	bl OS_CreateThread
	ldr r1, _0208CC28 // =0x02143904
	ldr r0, _0208CC2C // =0x0000111C
	ldr r1, [r1]
	add r0, r1, r0
	bl OS_WakeupThreadDirect
	add sp, sp, #0xc
	ldmia sp!, {pc}
	.align 2, 0
_0208CC28: .word 0x02143904
_0208CC2C: .word 0x0000111C
_0208CC30: .word sub_208BBF8
	arm_func_end sub_208CBA8

	arm_func_start sub_208CC34
sub_208CC34: // 0x0208CC34
	ldr r0, _0208CC48 // =0x02143904
	ldr r0, [r0]
	add r0, r0, #0x1000
	ldr r0, [r0, #4]
	bx lr
	.align 2, 0
_0208CC48: .word 0x02143904
	arm_func_end sub_208CC34

	arm_func_start sub_208CC4C
sub_208CC4C: // 0x0208CC4C
	stmdb sp!, {r4, lr}
	ldr r1, _0208CC88 // =0x02143904
	ldr r0, _0208CC8C // =0x000011DC
	ldr r1, [r1]
	add r0, r1, r0
	bl OS_LockMutex
	ldr r1, _0208CC88 // =0x02143904
	ldr r0, _0208CC8C // =0x000011DC
	ldr r2, [r1]
	add r1, r2, #0x1000
	add r0, r2, r0
	ldr r4, [r1]
	bl OS_UnlockMutex
	mov r0, r4
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208CC88: .word 0x02143904
_0208CC8C: .word 0x000011DC
	arm_func_end sub_208CC4C

	arm_func_start sub_208CC90
sub_208CC90: // 0x0208CC90
	stmdb sp!, {lr}
	sub sp, sp, #4
	ldr r0, _0208CD04 // =0x02143904
	ldr r0, [r0]
	cmp r0, #0
	addeq sp, sp, #4
	ldmeqia sp!, {pc}
	ldr r0, _0208CD08 // =0x02143914
	ldr r0, [r0]
	cmp r0, #0
	beq _0208CCC0
	bl sub_208B8C0
_0208CCC0:
	bl sub_2089DEC
	ldr r0, _0208CD04 // =0x02143904
	ldr r1, [r0]
	add r0, r1, #0x1000
	ldr r0, [r0, #0x188]
	cmp r0, #0
	beq _0208CCE8
	ldr r0, _0208CD0C // =0x0000111C
	add r0, r1, r0
	bl OS_JoinThread
_0208CCE8:
	ldr r0, _0208CD04 // =0x02143904
	mvn r1, #6
	ldr r0, [r0]
	add r0, r0, #0x1000
	str r1, [r0, #4]
	add sp, sp, #4
	ldmia sp!, {pc}
	.align 2, 0
_0208CD04: .word 0x02143904
_0208CD08: .word 0x02143914
_0208CD0C: .word 0x0000111C
	arm_func_end sub_208CC90

	arm_func_start sub_208CD10
sub_208CD10: // 0x0208CD10
	stmdb sp!, {r4, lr}
	ldr r1, _0208CDF8 // =0x02143904
	ldr r0, _0208CDFC // =0x02143914
	ldr r1, [r1]
	ldr r0, [r0]
	add r1, r1, #0x1000
	cmp r0, #0
	ldr r4, [r1, #0x10c]
	beq _0208CD58
	bl sub_208B2C4
	ldr r1, _0208CDFC // =0x02143914
	ldr r0, _0208CE00 // =aFreeDwchttp
	ldr r1, [r1]
	mov r2, #0
	blx r4
	ldr r0, _0208CDFC // =0x02143914
	mov r1, #0
	str r1, [r0]
_0208CD58:
	bl sub_2089D94
	ldr r0, _0208CDF8 // =0x02143904
	ldr r0, [r0]
	cmp r0, #0
	ldmeqia sp!, {r4, pc}
	add r0, r0, #0x1000
	ldr r1, [r0, #0x114]
	cmp r1, #0
	beq _0208CD9C
	ldr r0, _0208CE04 // =aFreeDwcnetchec_0
	mov r2, #0
	blx r4
	ldr r0, _0208CDF8 // =0x02143904
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, #0x1000
	str r1, [r0, #0x114]
_0208CD9C:
	ldr r0, _0208CDF8 // =0x02143904
	ldr r0, [r0]
	add r0, r0, #0x1000
	ldr r1, [r0, #0x118]
	cmp r1, #0
	beq _0208CDD4
	ldr r0, _0208CE08 // =aFreeDwcnetchec
	mov r2, #0
	blx r4
	ldr r0, _0208CDF8 // =0x02143904
	mov r1, #0
	ldr r0, [r0]
	add r0, r0, #0x1000
	str r1, [r0, #0x118]
_0208CDD4:
	ldr r1, _0208CDF8 // =0x02143904
	ldr r0, _0208CE0C // =aFreeDwcnetchec_1
	ldr r1, [r1]
	mov r2, #0
	blx r4
	ldr r0, _0208CDF8 // =0x02143904
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r4, pc}
	.align 2, 0
_0208CDF8: .word 0x02143904
_0208CDFC: .word 0x02143914
_0208CE00: .word aFreeDwchttp
_0208CE04: .word aFreeDwcnetchec_0
_0208CE08: .word aFreeDwcnetchec
_0208CE0C: .word aFreeDwcnetchec_1
	arm_func_end sub_208CD10

	arm_func_start sub_208CE10
sub_208CE10: // 0x0208CE10
	stmdb sp!, {r4, r5, lr}
	sub sp, sp, #4
	ldr r1, _0208CEFC // =0x02143904
	mov r5, r0
	ldr r0, [r1]
	ldr r4, [r5]
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #4
	ldmneia sp!, {r4, r5, pc}
	ldr r0, _0208CF00 // =aAllocDwcnetche_1
	ldr r1, _0208CF04 // =0x000011F4
	blx r4
	ldr r1, _0208CEFC // =0x02143904
	cmp r0, #0
	str r0, [r1]
	addeq sp, sp, #4
	moveq r0, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r2, _0208CF04 // =0x000011F4
	mov r1, #0
	bl MI_CpuFill8
	ldr r1, _0208CEFC // =0x02143904
	ldr r2, _0208CF08 // =0xFFFE7961
	ldr r0, [r1]
	ldr r3, _0208CF0C // =0x00001108
	add r0, r0, #0x1000
	str r2, [r0, #4]
	ldr ip, [r1]
	ldmia r5, {r0, r1, r2}
	add r3, ip, r3
	stmia r3, {r0, r1, r2}
	ldr r0, _0208CF10 // =0x02143914
	ldr r0, [r0]
	cmp r0, #0
	addne sp, sp, #4
	movne r0, #4
	ldmneia sp!, {r4, r5, pc}
	ldr r0, _0208CF14 // =aAllocDwchttp
	ldr r1, _0208CF18 // =0x00001C14
	blx r4
	ldr r1, _0208CF10 // =0x02143914
	cmp r0, #0
	str r0, [r1]
	addeq sp, sp, #4
	moveq r0, #4
	ldmeqia sp!, {r4, r5, pc}
	ldr r1, _0208CEFC // =0x02143904
	ldr r0, _0208CF1C // =0x000011DC
	ldr r2, [r1]
	ldr r1, _0208CF20 // =0x02143908
	mov r3, #0
	add r0, r2, r0
	str r3, [r1]
	bl OS_InitMutex
	bl sub_208CBA8
	mov r0, #0
	add sp, sp, #4
	ldmia sp!, {r4, r5, pc}
	.align 2, 0
_0208CEFC: .word 0x02143904
_0208CF00: .word aAllocDwcnetche_1
_0208CF04: .word 0x000011F4
_0208CF08: .word 0xFFFE7961
_0208CF0C: .word 0x00001108
_0208CF10: .word 0x02143914
_0208CF14: .word aAllocDwchttp
_0208CF18: .word 0x00001C14
_0208CF1C: .word 0x000011DC
_0208CF20: .word 0x02143908
	arm_func_end sub_208CE10

	arm_func_start sub_208CF24
sub_208CF24: // 0x0208CF24
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #0x40
	mov r6, r0
	bl strlen
	mov r4, r0
	ldr r0, _0208D154 // =aFri03Mar200601
	bl strlen
	cmp r4, r0
	bne _0208D148
	ldrsb r0, [r6, #7]
	cmp r0, #0x20
	bne _0208D148
	ldrsb r0, [r6, #0xb]
	cmp r0, #0x20
	bne _0208D148
	ldrsb r0, [r6, #0x10]
	cmp r0, #0x20
	bne _0208D148
	ldrsb r0, [r6, #0x13]
	cmp r0, #0x3a
	bne _0208D148
	ldrsb r0, [r6, #0x16]
	cmp r0, #0x3a
	bne _0208D148
	ldrsb r0, [r6, #0x19]
	cmp r0, #0x20
	bne _0208D148
	add r0, sp, #0
	bl RTC_GetDate
	cmp r0, #0
	bne _0208D148
	add r0, sp, #0x10
	bl RTC_GetTime
	cmp r0, #0
	bne _0208D148
	add r0, sp, #0
	add r1, sp, #0x10
	bl RTC_ConvertDateTimeToSecond
	mov r4, r0
	mov r5, r1
	mvn r0, #0
	cmp r5, r0
	cmpeq r4, r0
	beq _0208D148
	add r0, sp, #0x1c
	mov r1, r6
	bl strcpy
	mov r2, #0
	ldr r1, _0208D158 // =_02152920
	add r0, sp, #0x28
	strb r2, [sp, #0x23]
	strb r2, [sp, #0x27]
	strb r2, [sp, #0x2c]
	strb r2, [sp, #0x2f]
	strb r2, [sp, #0x32]
	strb r2, [sp, #0x35]
	str r2, [r1]
	bl atoi
	ldr r1, _0208D158 // =_02152920
	str r0, [sp]
	ldr r1, [r1]
	cmp r1, #0x22
	beq _0208D148
	sub r1, r0, #0x7d0
	mov r0, #0xd
	str r1, [sp]
	str r0, [sp, #4]
	mov r8, #0
	ldr r7, _0208D15C // =0x0211B4E0
	add r6, sp, #0x24
_0208D03C:
	ldr r0, [r7, r8, lsl #2]
	mov r1, r6
	bl strcmp
	cmp r0, #0
	addeq r0, r8, #1
	streq r0, [sp, #4]
	beq _0208D064
	add r8, r8, #1
	cmp r8, #0xc
	blt _0208D03C
_0208D064:
	ldr r0, [sp, #4]
	cmp r0, #0xc
	bhi _0208D148
	ldr r1, _0208D158 // =_02152920
	mov r2, #0
	add r0, sp, #0x21
	str r2, [r1]
	bl atoi
	ldr r1, _0208D158 // =_02152920
	str r0, [sp, #8]
	ldr r0, [r1]
	cmp r0, #0x22
	beq _0208D148
	mov r2, #0
	add r0, sp, #0x2d
	str r2, [r1]
	bl atoi
	ldr r1, _0208D158 // =_02152920
	str r0, [sp, #0x10]
	ldr r0, [r1]
	cmp r0, #0x22
	beq _0208D148
	mov r2, #0
	add r0, sp, #0x30
	str r2, [r1]
	bl atoi
	ldr r1, _0208D158 // =_02152920
	str r0, [sp, #0x14]
	ldr r0, [r1]
	cmp r0, #0x22
	beq _0208D148
	mov r2, #0
	add r0, sp, #0x33
	str r2, [r1]
	bl atoi
	ldr r1, _0208D158 // =_02152920
	str r0, [sp, #0x18]
	ldr r0, [r1]
	cmp r0, #0x22
	beq _0208D148
	add r0, sp, #0
	add r1, sp, #0x10
	bl RTC_ConvertDateTimeToSecond
	mvn r2, #0
	cmp r1, r2
	cmpeq r0, r2
	beq _0208D148
	subs r4, r4, r0
	ldr r2, _0208D160 // =0x02143980
	sbc r3, r5, r1
	ldr r1, _0208D164 // =0x0214397C
	mov r0, #1
	str r3, [r2, #4]
	str r0, [r1]
	add sp, sp, #0x40
	str r4, [r2]
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
_0208D148:
	mov r0, #0
	add sp, sp, #0x40
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	.align 2, 0
_0208D154: .word aFri03Mar200601
_0208D158: .word _02152920
_0208D15C: .word 0x0211B4E0
_0208D160: .word 0x02143980
_0208D164: .word 0x0214397C
	arm_func_end sub_208CF24

	arm_func_start sub_208D168
sub_208D168: // 0x0208D168
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	sub sp, sp, #8
	ands r4, r1, #3
	addne sp, sp, #8
	mvnne r0, #0
	ldmneia sp!, {r4, r5, r6, r7, r8, pc}
	mov r6, #0
	mov r5, r6
	cmp r1, #0
	bls _0208D1A8
_0208D190:
	ldrsb r4, [r0, r5]
	add r5, r5, #1
	cmp r4, #0x2a
	addne r6, r6, #6
	cmp r5, r1
	blo _0208D190
_0208D1A8:
	cmp r2, #0
	moveq r0, r6, asr #2
	addeq r0, r6, r0, lsr #29
	addeq sp, sp, #8
	moveq r0, r0, asr #3
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r4, r6, asr #2
	add r4, r6, r4, lsr #29
	mov r4, r4, asr #3
	cmp r3, r4
	addlo sp, sp, #8
	mvnlo r0, #0
	ldmloia sp!, {r4, r5, r6, r7, r8, pc}
	cmp r1, #0
	moveq r0, #0
	streqb r0, [r2]
	addeq sp, sp, #8
	ldmeqia sp!, {r4, r5, r6, r7, r8, pc}
	mov r6, r2
	add ip, sp, #0
	mov lr, #0
	mov r1, #0x3f
	mov r3, #0x3e
_0208D204:
	mov r8, lr
	mov r5, ip
_0208D20C:
	ldrsb r7, [r0, r8]
	cmp r7, #0x41
	blt _0208D228
	cmp r7, #0x5a
	suble r7, r7, #0x41
	strleb r7, [r5]
	ble _0208D270
_0208D228:
	cmp r7, #0x61
	blt _0208D240
	cmp r7, #0x7a
	suble r7, r7, #0x47
	strleb r7, [r5]
	ble _0208D270
_0208D240:
	cmp r7, #0x30
	blt _0208D258
	cmp r7, #0x39
	addle r7, r7, #4
	strleb r7, [r5]
	ble _0208D270
_0208D258:
	cmp r7, #0x2e
	streqb r3, [r5]
	beq _0208D270
	cmp r7, #0x2d
	streqb r1, [r5]
	strneb lr, [r5]
_0208D270:
	add r8, r8, #1
	cmp r8, #4
	add r5, r5, #1
	blt _0208D20C
	ldrsb r8, [sp]
	ldrsb r7, [sp, #1]
	add r5, r6, #1
	mov r8, r8, lsl #2
	orr r7, r8, r7, asr #4
	sub r5, r5, r2
	strb r7, [r6]
	cmp r5, r4
	add r0, r0, #4
	bge _0208D2EC
	ldrsb r8, [sp, #1]
	ldrsb r7, [sp, #2]
	add r5, r6, #2
	mov r8, r8, lsl #4
	orr r7, r8, r7, asr #2
	sub r5, r5, r2
	strb r7, [r6, #1]
	cmp r5, r4
	bge _0208D2EC
	ldrsb r7, [sp, #2]
	ldrsb r5, [sp, #3]
	orr r5, r5, r7, lsl #6
	strb r5, [r6, #2]
	add r6, r6, #3
	sub r5, r6, r2
	cmp r5, r4
	blt _0208D204
_0208D2EC:
	mov r0, r5
	add sp, sp, #8
	ldmia sp!, {r4, r5, r6, r7, r8, pc}
	arm_func_end sub_208D168

	arm_func_start sub_208D2F8
sub_208D2F8: // 0x0208D2F8
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #0xc
	ldr r4, _0208D498 // =0xAAAAAAAB
	str r2, [sp]
	umull r4, r5, r1, r4
	ldr r6, _0208D49C // =0x00000003
	mov r5, r5, lsr #1
	umull r4, r5, r6, r5
	mov r10, r0
	subs r5, r1, r4
	movne r4, #4
	ldr r2, _0208D498 // =0xAAAAAAAB
	ldr r0, [sp]
	moveq r4, #0
	cmp r0, #0
	umull r0, r2, r1, r2
	mov r2, r2, lsr #1
	addeq sp, sp, #0xc
	add r0, r4, r2, lsl #2
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	cmp r3, r0
	addlo sp, sp, #0xc
	mvnlo r0, #0
	ldmloia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	add r7, r10, r1
	ldr r6, [sp]
	cmp r10, r7
	beq _0208D488
	mov r0, #1
	mov r5, #0
	str r0, [sp, #4]
	mov r11, #3
	mov r4, #0x2a
_0208D37C:
	sub r9, r7, r10
	ldr r1, _0208D4A0 // =0x2AAAAAAB
	mov r0, r9, lsl #3
	smull r2, r3, r1, r0
	ldr r1, _0208D4A4 // =0x00000006
	add r3, r3, r0, lsr #31
	smull r2, r3, r1, r3
	subs r3, r0, r2
	ldr r1, _0208D4A0 // =0x2AAAAAAB
	ldrne r8, [sp, #4]
	smull r2, r3, r1, r0
	moveq r8, r5
	add r3, r3, r0, lsr #31
	cmp r9, #3
	movge r9, r11
	add r0, sp, #8
	mov r1, r5
	mov r2, r11
	add r8, r3, r8
	bl MI_CpuFill8
	mov r0, r10
	add r1, sp, #8
	mov r2, r9
	bl MI_CpuCopy8
	ldr r0, _0208D4A8 // =_0211B530
	cmp r8, #2
	ldr r1, [r0]
	ldrb r0, [sp, #8]
	mov r0, r0, asr #2
	ldrsb r0, [r1, r0]
	strb r0, [r6]
	strltb r4, [r6, #1]
	blt _0208D424
	ldrb r2, [sp, #8]
	ldr r0, _0208D4A8 // =_0211B530
	ldrb r1, [sp, #9]
	mov r2, r2, lsl #4
	and r2, r2, #0x3f
	ldr r0, [r0]
	orr r1, r2, r1, asr #4
	ldrsb r0, [r0, r1]
	strb r0, [r6, #1]
_0208D424:
	cmp r8, #3
	strltb r4, [r6, #2]
	blt _0208D454
	ldrb r2, [sp, #9]
	ldr r0, _0208D4A8 // =_0211B530
	ldrb r1, [sp, #0xa]
	mov r2, r2, lsl #2
	and r2, r2, #0x3f
	ldr r0, [r0]
	orr r1, r2, r1, asr #6
	ldrsb r0, [r0, r1]
	strb r0, [r6, #2]
_0208D454:
	cmp r8, #4
	strltb r4, [r6, #3]
	blt _0208D478
	ldr r0, _0208D4A8 // =_0211B530
	ldrb r1, [sp, #0xa]
	ldr r2, [r0]
	and r0, r1, #0x3f
	ldrsb r0, [r2, r0]
	strb r0, [r6, #3]
_0208D478:
	add r10, r10, r9
	cmp r10, r7
	add r6, r6, #4
	bne _0208D37C
_0208D488:
	ldr r0, [sp]
	sub r0, r6, r0
	add sp, sp, #0xc
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, pc}
	.align 2, 0
_0208D498: .word 0xAAAAAAAB
_0208D49C: .word 0x00000003
_0208D4A0: .word 0x2AAAAAAB
_0208D4A4: .word 0x00000006
_0208D4A8: .word _0211B530
	arm_func_end sub_208D2F8

	.data

.public _0211AE44
_0211AE44: // _0211AE44
	.word aHttpsNasTestNi_0

.public _0211AE48
_0211AE48: // 0x0211AE48
    .word 0

.public _0211AE4C
_0211AE4C: // 0x0211AE4C
    .word 0x1000

.public _0211AE50
_0211AE50: // 0x0211AE50
    .word 0
	
.public _0211AE54
_0211AE54: // 0x0211AE54
    .word 0
	
.public _0211AE58
_0211AE58: // 0x0211AE58
    .word 0
	
.public _0211AE5C
_0211AE5C: // 0x0211AE5C
    .word 0x4E20

aHttpsNasTestNi_0: // 0x0211AE60
	.asciz "https://nas.test.nintendowifi.net/ac"
	.align 4

aAcctcreate: // 0x0211AE88
	.asciz "acctcreate"
	.align 4

aAction: // 0x0211AE94
	.asciz "action"
	.align 4

aLogin: // 0x0211AE9C
	.asciz "login"
	.align 4

aGsbrcd: // 0x0211AEA4
	.asciz "gsbrcd"
	.align 4
	
.public _0211AEAC
_0211AEAC:
	.byte 0x59, 0x00, 0x00, 0x00

aIswfc: // 0x0211AEB0
	.asciz "iswfc"
	.align 4
	
aIngamesn: // 0x0211AEB8
	.asciz "ingamesn"
	.align 4
	
.public _0211AEC4
_0211AEC4:
	.byte 0x44, 0x61, 0x74, 0x65, 0x00, 0x00, 0x00, 0x00

aHttpresult: // 0x0211AECC
	.asciz "httpresult"
	.align 4
	
aReturncd: // 0x0211AED8
	.asciz "returncd"
	.align 4
	
aToken: // 0x0211AEE4
	.asciz "token"
	.align 4
	
aLocator: // 0x0211AEEC
	.asciz "locator"
	.align 4
	
aChallenge: // 0x0211AEF4
	.asciz "challenge"
	.align 4
	
aDatetime: // 0x0211AF00
	.asciz "datetime"
	.align 4
	
aSetCookie: // 0x0211AF0C
	.asciz "Set-Cookie"
	.align 4
	
aAllocBmwork: // 0x0211AF18
	.asciz "ALLOC bmwork"
	.align 4
	
aFreeBmwork: // 0x0211AF28
	.asciz "FREE bmwork"
	.align 4
	
aHttpsNasNinten: // 0x0211AF34
	.asciz "https://nas.nintendowifi.net/ac"
	.align 4
	
aFreeDwcauth: // 0x0211AF54
	.asciz "FREE DWCauth"
	.align 4
	
aAllocDwcauth: // 0x0211AF64
	.asciz "ALLOC DWCauth"
	.align 4
	
a03d03d: // 0x0211AF74
	.asciz "%03d%03d"
	.align 4
	
aSdkver: // 0x0211AF80
	.asciz "sdkver"
	.align 4
	
aUserid: // 0x0211AF88
	.asciz "userid"
	.align 4
	
aPasswd: // 0x0211AF90
	.asciz "passwd"
	.align 4
	
aBssid: // 0x0211AF98
	.asciz "bssid"
	.align 4
	
aApinfo: // 0x0211AFA0
	.asciz "apinfo"
	.align 4
	
aGamecd: // 0x0211AFA8
	.asciz "gamecd"
	.align 4
	
aMakercd: // 0x0211AFB0
	.asciz "makercd"
	.align 4
	
aUnitcd: // 0x0211AFB8
	.asciz "unitcd"
	.align 4
	
aMacadr: // 0x0211AFC0
	.asciz "macadr"
	.align 4
	
.public _0211AFC8
_0211AFC8:
	.byte 0x6C, 0x61, 0x6E, 0x67, 0x00, 0x00, 0x00, 0x00

aBirth: // 0x0211AFD0
	.asciz "birth"
	.align 4
	
aDevtime: // 0x0211AFD8
	.asciz "devtime"
	.align 4
	
aDevname: // 0x0211AFE0
	.asciz "devname"
	.align 4
	
.public _0211AFE8
_0211AFE8:
	.byte 0x73, 0x73, 0x69, 0x64, 0x00, 0x00, 0x00, 0x00

aNitroWifiSdkDD: // 0x0211AFF0
	.asciz "Nitro WiFi SDK/%d.%d"
	.align 4
	
aUserAgent: // 0x0211B008
	.asciz "User-Agent"
	.align 4
	
aHttpXGamecd: // 0x0211B014
	.asciz "HTTP_X_GAMECD"
	.align 4
	
a013llu: // 0x0211B024
	.asciz "%013llu"
	.align 4
	
.public _0211B02C
_0211B02C:
	.byte 0x25, 0x30, 0x33, 0x75
	.byte 0x00, 0x00, 0x00, 0x00, 0x25, 0x30, 0x32, 0x78, 0x00, 0x00, 0x00, 0x00

a02x02x: // 0x0211B03C
	.asciz "%02x%02x"
	.align 4

a02d02d02d02d02: // 0x0211B048
	.asciz "%02d%02d%02d%02d%02d%02d"
	.align 4

a02d000000000: // 0x0211B064
	.asciz "%02d:0000000-00"
	.align 4

.public _0211B074
_0211B074:
	.byte 0x10, 0xBE, 0x11, 0x02, 0xE4, 0xBC, 0x11, 0x02, 0xC4, 0xBF, 0x11, 0x02
	.byte 0xA0, 0xC0, 0x11, 0x02, 0x7C, 0xB5, 0x11, 0x02, 0x18, 0xB8, 0x11, 0x02, 0x00, 0xB9, 0x11, 0x02
	.byte 0xC8, 0xB6, 0x11, 0x02, 0xCC, 0xBB, 0x11, 0x02, 0xAC, 0xBA, 0x11, 0x02, 0xC4, 0xB9, 0x11, 0x02

aFreeArrayEntry: // 0x0211B0A0
	.asciz "FREE array_entry[i].label"
	.align 4

aFreeArrayEntry_0: // 0x0211B0BC
	.asciz "FREE array_entry[i].value"
	.align 4

.public _0211B0D8
_0211B0D8:
	.byte 0x0D, 0x0A, 0x0D, 0x0A, 0x00, 0x00, 0x00, 0x00
	.byte 0x20, 0x00, 0x00, 0x00

aHttpresult_0: // 0x0211B0E4
	.asciz "httpresult"
	.align 4

.public _0211B0F0
_0211B0F0:
	.byte 0x32, 0x30, 0x30, 0x00, 0x0D, 0x0A, 0x00, 0x00, 0x3A, 0x20, 0x00, 0x00, 0x3D, 0x00, 0x00, 0x00
	.byte 0x26, 0x00, 0x00, 0x00

aAllocResultEnt: // 0x0211B104
	.asciz "ALLOC result->entry[i].label"
	.align 4

aAllocResultEnt_0: // 0x0211B124
	.asciz "ALLOC result->entry[i].value"
	.align 4

aFreeResultEntr: // 0x0211B144
	.asciz "FREE result->entry[i].label"
	.align 4

aFreeResultEntr_0: // 0x0211B160
	.asciz "FREE result->entry[i].value"
	.align 4

aHttp: // 0x0211B17C
	.asciz "http://"
	.align 4

aHttps: // 0x0211B184
	.asciz "https://"
	.align 4

.public _0211B190
_0211B190:
	.byte 0x3A, 0x00, 0x00, 0x00, 0x2F, 0x00, 0x00, 0x00

aAllocNewptr: // 0x0211B198
	.asciz "ALLOC newptr"
	.align 4

aFreeBufBuffer: // 0x0211B1A8
	.asciz "FREE buf->buffer"
	.align 4

aAllocBufBuffer: // 0x0211B1BC
	.asciz "ALLOC buf->buffer"
	.align 4

.public _0211B1D0
_0211B1D0:
	.byte 0x25, 0x73, 0x00, 0x00, 0x25, 0x73, 0x3D, 0x00, 0x26, 0x25, 0x73, 0x3D, 0x00, 0x00, 0x00, 0x00

aSS: // 0x0211B1E0
	.asciz "%s: %s\r\n"
	.align 4

aPostSHttp10Con: // 0x0211B1EC
	.asciz "POST /%s HTTP/1.0\r\nContent-type: application/x-www-form-urlencoded\r\nHost: %s\r\n\r\n"
	.align 4

aGetSHttp10Host: // 0x0211B240
	.asciz "GET /%s HTTP/1.0\r\nHost: %s\r\n\r\n"
	.align 4

aFreeHttpLowrec: // 0x0211B260
	.asciz "FREE http->lowrecvbuf"
	.align 4

aFreeHttpLowsen: // 0x0211B278
	.asciz "FREE http->lowsendbuf"
	.align 4

aContentLength: // 0x0211B290
	.asciz "Content-Length: "
	.align 4

aConnection: // 0x0211B2A4
	.asciz "Connection"
	.align 4

aClose: // 0x0211B2B0
	.asciz "close"
	.align 4

.public _0211B2B8
_0211B2B8:
	.byte 0x25, 0x64, 0x00, 0x00

aContentLength_0: // 0x0211B2BC
	.asciz "Content-Length"
	.align 4

aAllocHttpLowre: // 0x0211B2CC
	.asciz "ALLOC http->lowrecvbuf"
	.align 4

aAllocHttpLowse: // 0x0211B2E4
	.asciz "ALLOC http->lowsendbuf"
	.align 4

_0211B2FC:
	.byte 0x00, 0xB3, 0x11, 0x02

aHttpConntestNi: // 0x0211B300
	.asciz "http://conntest.nintendowifi.net/"
	.align 4

aAllocDwcnetche: // 0x0211B324
	.asciz "ALLOC DWCnetcheck->body_302"
	.align 4

aFreeDwcnetchec_0: // 0x0211B340
	.asciz "FREE DWCnetcheck->body_302"
	.align 4

aAllocUrl: // 0x0211B35C
	.asciz "ALLOC url"
	.align 4

aAllocDataLen: // 0x0211B368
	.asciz "ALLOC data_len"
	.align 4

aAllocWaitLen: // 0x0211B378
	.asciz "ALLOC wait_len"
	.align 4

aAllocDwcnetche_0: // 0x0211B388
	.asciz "ALLOC DWCnetcheck->body_wayport"
	.align 4

aHttpresult_1: // 0x0211B3A8
	.asciz "httpresult"
	.align 4

aHttpsNasNinten_0: // 0x0211B3B4
	.asciz "https://nas.nintendowifi.net/ac"
	.align 4

aAction_0: // 0x0211B3D4
	.asciz "action"
	.align 4

aMessage: // 0x0211B3DC
	.asciz "message"
	.align 4

aHotspotrespons: // 0x0211B3E4
	.asciz "HotSpotResponse"
	.align 4

aFreeDwcnetchec: // 0x0211B3F4
	.asciz "FREE DWCnetcheck->body_wayport"
	.align 4

aParse: // 0x0211B414
	.asciz "parse"
	.align 4

.public _0211B41C
_0211B41C:
	.byte 0x48, 0x54, 0x4D, 0x4C
	.byte 0x00, 0x00, 0x00, 0x00

aReturncd_0: // 0x0211B424
	.asciz "returncd"
	.align 4

.public _0211B430
_0211B430:
	.byte 0x75, 0x72, 0x6C, 0x00, 0x64, 0x61, 0x74, 0x61, 0x00, 0x00, 0x00, 0x00, 0x77, 0x61, 0x69, 0x74
	.byte 0x00, 0x00, 0x00, 0x00

aFreeUrl: // 0x0211B444
	.asciz "FREE url"
	.align 4

aFreeData: // 0x0211B450
	.asciz "FREE data"
	.align 4

aFreeWait: // 0x0211B45C
	.asciz "FREE wait"
	.align 4

aFreeDwchttp: // 0x0211B468
	.asciz "FREE DWChttp"
	.align 4

aFreeDwcnetchec_1: // 0x0211B478
	.asciz "FREE DWCnetcheck"
	.align 4

aAllocDwcnetche_1: // 0x0211B48C
	.asciz "ALLOC DWCnetcheck"
	.align 4

aAllocDwchttp: // 0x0211B4A0
	.asciz "ALLOC DWChttp"
	.align 4

.public _0211B4B0
_0211B4B0:
	.byte 0x44, 0x65, 0x63, 0x00, 0x4A, 0x75, 0x6C, 0x00, 0x4F, 0x63, 0x74, 0x00, 0x53, 0x65, 0x70, 0x00
	.byte 0x41, 0x75, 0x67, 0x00, 0x4E, 0x6F, 0x76, 0x00, 0x4A, 0x75, 0x6E, 0x00, 0x4D, 0x61, 0x79, 0x00
	.byte 0x41, 0x70, 0x72, 0x00, 0x4D, 0x61, 0x72, 0x00, 0x46, 0x65, 0x62, 0x00, 0x4A, 0x61, 0x6E, 0x00
	.byte 0xDC, 0xB4, 0x11, 0x02, 0xD8, 0xB4, 0x11, 0x02, 0xD4, 0xB4, 0x11, 0x02, 0xD0, 0xB4, 0x11, 0x02
	.byte 0xCC, 0xB4, 0x11, 0x02, 0xC8, 0xB4, 0x11, 0x02, 0xB4, 0xB4, 0x11, 0x02, 0xC0, 0xB4, 0x11, 0x02
	.byte 0xBC, 0xB4, 0x11, 0x02, 0xB8, 0xB4, 0x11, 0x02, 0xC4, 0xB4, 0x11, 0x02, 0xB0, 0xB4, 0x11, 0x02

aFri03Mar200601: // 0x0211B510
	.asciz "Fri, 03 Mar 2006 01:28:13 GMT"
	.align 4

.public _0211B530
_0211B530:
	.byte 0x34, 0xB5, 0x11, 0x02

aAbcdefghijklmn_1: // 0x0211B534
	.asciz "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.-"
	.align 4

.public _0211B578
_0211B578:
	.byte 0x01, 0x00, 0x01, 0x00, 0x90, 0xB5, 0x11, 0x02
	.byte 0x00, 0x01, 0x00, 0x00, 0xC4, 0xB5, 0x11, 0x02, 0x03, 0x00, 0x00, 0x00, 0x78, 0xB5, 0x11, 0x02

aBeGlobalsignNv: // 0x0211B590
	.asciz "BE, GlobalSign nv-sa, Root CA, GlobalSign Root CA"
	.align 4
	
.public _0211B5C4
_0211B5C4:
	.byte 0xDA, 0x0E, 0xE6, 0x99, 0x8D, 0xCE, 0xA3, 0xE3, 0x4F, 0x8A, 0x7E, 0xFB
	.byte 0xF1, 0x8B, 0x83, 0x25, 0x6B, 0xEA, 0x48, 0x1F, 0xF1, 0x2A, 0xB0, 0xB9, 0x95, 0x11, 0x04, 0xBD
	.byte 0xF0, 0x63, 0xD1, 0xE2, 0x67, 0x66, 0xCF, 0x1C, 0xDD, 0xCF, 0x1B, 0x48, 0x2B, 0xEE, 0x8D, 0x89
	.byte 0x8E, 0x9A, 0xAF, 0x29, 0x80, 0x65, 0xAB, 0xE9, 0xC7, 0x2D, 0x12, 0xCB, 0xAB, 0x1C, 0x4C, 0x70
	.byte 0x07, 0xA1, 0x3D, 0x0A, 0x30, 0xCD, 0x15, 0x8D, 0x4F, 0xF8, 0xDD, 0xD4, 0x8C, 0x50, 0x15, 0x1C
	.byte 0xEF, 0x50, 0xEE, 0xC4, 0x2E, 0xF7, 0xFC, 0xE9, 0x52, 0xF2, 0x91, 0x7D, 0xE0, 0x6D, 0xD5, 0x35
	.byte 0x30, 0x8E, 0x5E, 0x43, 0x73, 0xF2, 0x41, 0xE9, 0xD5, 0x6A, 0xE3, 0xB2, 0x89, 0x3A, 0x56, 0x39
	.byte 0x38, 0x6F, 0x06, 0x3C, 0x88, 0x69, 0x5B, 0x2A, 0x4D, 0xC5, 0xA7, 0x54, 0xB8, 0x6C, 0x89, 0xCC
	.byte 0x9B, 0xF9, 0x3C, 0xCA, 0xE5, 0xFD, 0x89, 0xF5, 0x12, 0x3C, 0x92, 0x78, 0x96, 0xD6, 0xDC, 0x74
	.byte 0x6E, 0x93, 0x44, 0x61, 0xD1, 0x8D, 0xC7, 0x46, 0xB2, 0x75, 0x0E, 0x86, 0xE8, 0x19, 0x8A, 0xD5
	.byte 0x6D, 0x6C, 0xD5, 0x78, 0x16, 0x95, 0xA2, 0xE9, 0xC8, 0x0A, 0x38, 0xEB, 0xF2, 0x24, 0x13, 0x4F
	.byte 0x73, 0x54, 0x93, 0x13, 0x85, 0x3A, 0x1B, 0xBC, 0x1E, 0x34, 0xB5, 0x8B, 0x05, 0x8C, 0xB9, 0x77
	.byte 0x8B, 0xB1, 0xDB, 0x1F, 0x20, 0x91, 0xAB, 0x09, 0x53, 0x6E, 0x90, 0xCE, 0x7B, 0x37, 0x74, 0xB9
	.byte 0x70, 0x47, 0x91, 0x22, 0x51, 0x63, 0x16, 0x79, 0xAE, 0xB1, 0xAE, 0x41, 0x26, 0x08, 0xC8, 0x19
	.byte 0x2B, 0xD1, 0x46, 0xAA, 0x48, 0xD6, 0x64, 0x2A, 0xD7, 0x83, 0x34, 0xFF, 0x2C, 0x2A, 0xC1, 0x6C
	.byte 0x19, 0x43, 0x4A, 0x07, 0x85, 0xE7, 0xD3, 0x7C, 0xF6, 0x21, 0x68, 0xEF, 0xEA, 0xF2, 0x52, 0x9F
	.byte 0x7F, 0x93, 0x90, 0xCF, 0x01, 0x00, 0x01, 0x00, 0xDC, 0xB6, 0x11, 0x02, 0x00, 0x01, 0x00, 0x00
	.byte 0x14, 0xB7, 0x11, 0x02, 0x03, 0x00, 0x00, 0x00, 0xC4, 0xB6, 0x11, 0x02

aIeBaltimoreCyb: // 0x0211B6DC
	.asciz "IE, Baltimore, CyberTrust, Baltimore CyberTrust Root"
	.align 4
	
.public _0211B714
_0211B714:
	.byte 0xA3, 0x04, 0xBB, 0x22, 0xAB, 0x98, 0x3D, 0x57, 0xE8, 0x26, 0x72, 0x9A
	.byte 0xB5, 0x79, 0xD4, 0x29, 0xE2, 0xE1, 0xE8, 0x95, 0x80, 0xB1, 0xB0, 0xE3, 0x5B, 0x8E, 0x2B, 0x29
	.byte 0x9A, 0x64, 0xDF, 0xA1, 0x5D, 0xED, 0xB0, 0x09, 0x05, 0x6D, 0xDB, 0x28, 0x2E, 0xCE, 0x62, 0xA2
	.byte 0x62, 0xFE, 0xB4, 0x88, 0xDA, 0x12, 0xEB, 0x38, 0xEB, 0x21, 0x9D, 0xC0, 0x41, 0x2B, 0x01, 0x52
	.byte 0x7B, 0x88, 0x77, 0xD3, 0x1C, 0x8F, 0xC7, 0xBA, 0xB9, 0x88, 0xB5, 0x6A, 0x09, 0xE7, 0x73, 0xE8
	.byte 0x11, 0x40, 0xA7, 0xD1, 0xCC, 0xCA, 0x62, 0x8D, 0x2D, 0xE5, 0x8F, 0x0B, 0xA6, 0x50, 0xD2, 0xA8
	.byte 0x50, 0xC3, 0x28, 0xEA, 0xF5, 0xAB, 0x25, 0x87, 0x8A, 0x9A, 0x96, 0x1C, 0xA9, 0x67, 0xB8, 0x3F
	.byte 0x0C, 0xD5, 0xF7, 0xF9, 0x52, 0x13, 0x2F, 0xC2, 0x1B, 0xD5, 0x70, 0x70, 0xF0, 0x8F, 0xC0, 0x12
	.byte 0xCA, 0x06, 0xCB, 0x9A, 0xE1, 0xD9, 0xCA, 0x33, 0x7A, 0x77, 0xD6, 0xF8, 0xEC, 0xB9, 0xF1, 0x68
	.byte 0x44, 0x42, 0x48, 0x13, 0xD2, 0xC0, 0xC2, 0xA4, 0xAE, 0x5E, 0x60, 0xFE, 0xB6, 0xA6, 0x05, 0xFC
	.byte 0xB4, 0xDD, 0x07, 0x59, 0x02, 0xD4, 0x59, 0x18, 0x98, 0x63, 0xF5, 0xA5, 0x63, 0xE0, 0x90, 0x0C
	.byte 0x7D, 0x5D, 0xB2, 0x06, 0x7A, 0xF3, 0x85, 0xEA, 0xEB, 0xD4, 0x03, 0xAE, 0x5E, 0x84, 0x3E, 0x5F
	.byte 0xFF, 0x15, 0xED, 0x69, 0xBC, 0xF9, 0x39, 0x36, 0x72, 0x75, 0xCF, 0x77, 0x52, 0x4D, 0xF3, 0xC9
	.byte 0x90, 0x2C, 0xB9, 0x3D, 0xE5, 0xC9, 0x23, 0x53, 0x3F, 0x1F, 0x24, 0x98, 0x21, 0x5C, 0x07, 0x99
	.byte 0x29, 0xBD, 0xC6, 0x3A, 0xEC, 0xE7, 0x6E, 0x86, 0x3A, 0x6B, 0x97, 0x74, 0x63, 0x33, 0xBD, 0x68
	.byte 0x18, 0x31, 0xF0, 0x78, 0x8D, 0x76, 0xBF, 0xFC, 0x9E, 0x8E, 0x5D, 0x2A, 0x86, 0xA7, 0x4D, 0x90
	.byte 0xDC, 0x27, 0x1A, 0x39, 0x01, 0x00, 0x01, 0x00, 0x2C, 0xB8, 0x11, 0x02, 0x80, 0x00, 0x00, 0x00
	.byte 0x7C, 0xB8, 0x11, 0x02, 0x03, 0x00, 0x00, 0x00, 0x14, 0xB8, 0x11, 0x02

aUsGteCorporati: // 0x0211B82C
	.asciz "US, GTE Corporation, GTE CyberTrust Solutions, Inc., GTE CyberTrust Global Root"
	.align 4
	
.public _0211B87C
_0211B87C:
	.byte 0x95, 0x0F, 0xA0, 0xB6
	.byte 0xF0, 0x50, 0x9C, 0xE8, 0x7A, 0xC7, 0x88, 0xCD, 0xDD, 0x17, 0x0E, 0x2E, 0xB0, 0x94, 0xD0, 0x1B
	.byte 0x3D, 0x0E, 0xF6, 0x94, 0xC0, 0x8A, 0x94, 0xC7, 0x06, 0xC8, 0x90, 0x97, 0xC8, 0xB8, 0x64, 0x1A
	.byte 0x7A, 0x7E, 0x6C, 0x3C, 0x53, 0xE1, 0x37, 0x28, 0x73, 0x60, 0x7F, 0xB2, 0x97, 0x53, 0x07, 0x9F
	.byte 0x53, 0xF9, 0x6D, 0x58, 0x94, 0xD2, 0xAF, 0x8D, 0x6D, 0x88, 0x67, 0x80, 0xE6, 0xED, 0xB2, 0x95
	.byte 0xCF, 0x72, 0x31, 0xCA, 0xA5, 0x1C, 0x72, 0xBA, 0x5C, 0x02, 0xE7, 0x64, 0x42, 0xE7, 0xF9, 0xA9
	.byte 0x2C, 0xD6, 0x3A, 0x0D, 0xAC, 0x8D, 0x42, 0xAA, 0x24, 0x01, 0x39, 0xE6, 0x9C, 0x3F, 0x01, 0x85
	.byte 0x57, 0x0D, 0x58, 0x87, 0x45, 0xF8, 0xD3, 0x85, 0xAA, 0x93, 0x69, 0x26, 0x85, 0x70, 0x48, 0x80
	.byte 0x3F, 0x12, 0x15, 0xC7, 0x79, 0xB4, 0x1F, 0x05, 0x2F, 0x3B, 0x62, 0x99, 0x01, 0x00, 0x01, 0x00
	.byte 0x14, 0xB9, 0x11, 0x02, 0x80, 0x00, 0x00, 0x00, 0x40, 0xB9, 0x11, 0x02, 0x03, 0x00, 0x00, 0x00
	.byte 0xFC, 0xB8, 0x11, 0x02

aUsGteCorporati_0: // 0x0211B914
	.asciz "US, GTE Corporation, GTE CyberTrust Root"
	.align 4
	
.public _0211B940
_0211B940:
	.byte 0xB8, 0xE6, 0x4F, 0xBA, 0xDB, 0x98, 0x7C, 0x71, 0x7C, 0xAF, 0x44, 0xB7, 0xD3, 0x0F, 0x46, 0xD9
	.byte 0x64, 0xE5, 0x93, 0xC1, 0x42, 0x8E, 0xC7, 0xBA, 0x49, 0x8D, 0x35, 0x2D, 0x7A, 0xE7, 0x8B, 0xBD
	.byte 0xE5, 0x05, 0x31, 0x59, 0xC6, 0xB1, 0x2F, 0x0A, 0x0C, 0xFB, 0x9F, 0xA7, 0x3F, 0xA2, 0x09, 0x66
	.byte 0x84, 0x56, 0x1E, 0x37, 0x29, 0x1B, 0x87, 0xE9, 0x7E, 0x0C, 0xCA, 0x9A, 0x9F, 0xA5, 0x7F, 0xF5
	.byte 0x15, 0x94, 0xA3, 0xD5, 0xA2, 0x46, 0x82, 0xD8, 0x68, 0x4C, 0xD1, 0x37, 0x15, 0x06, 0x68, 0xAF
	.byte 0xBD, 0xF8, 0xB0, 0xB3, 0xF0, 0x29, 0xF5, 0x95, 0x5A, 0x09, 0x16, 0x61, 0x77, 0x0A, 0x22, 0x25
	.byte 0xD4, 0x4F, 0x45, 0xAA, 0xC7, 0xBD, 0xE5, 0x96, 0xDF, 0xF9, 0xD4, 0xA8, 0x8E, 0x42, 0xCC, 0x24
	.byte 0xC0, 0x1E, 0x91, 0x27, 0x4A, 0xB5, 0x6D, 0x06, 0x80, 0x63, 0x39, 0xC4, 0xA2, 0x5E, 0x38, 0x03
	.byte 0x01, 0x00, 0x01, 0x00, 0xD8, 0xB9, 0x11, 0x02, 0x80, 0x00, 0x00, 0x00, 0x28, 0xBA, 0x11, 0x02
	.byte 0x03, 0x00, 0x00, 0x00, 0xC0, 0xB9, 0x11, 0x02

aUsWashingtonNi: // 0x0211B9D8
	.asciz "US, Washington, Nintendo of America Inc, NOA, Nintendo CA, ca@noa.nintendo.com"
	.align 4
	
.public _0211BA28
_0211BA28:
	.byte 0xB3, 0xCD, 0x79, 0x97, 0x77, 0x5D, 0x8A, 0xAF
	.byte 0x86, 0xA8, 0xE8, 0xD7, 0x73, 0x1C, 0x77, 0xDF, 0x10, 0x90, 0x1F, 0x81, 0xF8, 0x41, 0x9E, 0x21
	.byte 0x55, 0xDF, 0xBC, 0xFC, 0x63, 0xFB, 0x19, 0x43, 0xF1, 0xF6, 0xC4, 0x72, 0x42, 0x49, 0xBD, 0xAD
	.byte 0x44, 0x68, 0x4E, 0xF3, 0xDA, 0x1D, 0xE6, 0x4D, 0xD8, 0xF9, 0x59, 0x88, 0xDC, 0xAE, 0x3E, 0x9B
	.byte 0x38, 0x09, 0xCA, 0x7F, 0xFF, 0xDC, 0x24, 0xA2, 0x44, 0x78, 0x78, 0x49, 0x93, 0xD4, 0x84, 0x40
	.byte 0x10, 0xB8, 0xEC, 0x3E, 0xDB, 0x2D, 0x93, 0xC8, 0x11, 0xC8, 0xFD, 0x78, 0x2D, 0x61, 0xAD, 0x31
	.byte 0xAE, 0x86, 0x26, 0xB0, 0xFD, 0x5A, 0x3F, 0xA1, 0x3D, 0xBF, 0xE2, 0x4B, 0x49, 0xEC, 0xCE, 0x66
	.byte 0x98, 0x58, 0x26, 0x12, 0xC0, 0xFB, 0xF4, 0x77, 0x65, 0x1B, 0xEA, 0xFB, 0xCB, 0x7F, 0xE0, 0x8C
	.byte 0xCB, 0x02, 0xA3, 0x4E, 0x5E, 0x8C, 0xEA, 0x9B, 0x01, 0x00, 0x01, 0x00, 0x40, 0xBB, 0x11, 0x02
	.byte 0x80, 0x00, 0x00, 0x00, 0xC0, 0xBA, 0x11, 0x02, 0x03, 0x00, 0x00, 0x00, 0xA8, 0xBA, 0x11, 0x02
	.byte 0xD2, 0x36, 0x36, 0x6A, 0x8B, 0xD7, 0xC2, 0x5B, 0x9E, 0xDA, 0x81, 0x41, 0x62, 0x8F, 0x38, 0xEE
	.byte 0x49, 0x04, 0x55, 0xD6, 0xD0, 0xEF, 0x1C, 0x1B, 0x95, 0x16, 0x47, 0xEF, 0x18, 0x48, 0x35, 0x3A
	.byte 0x52, 0xF4, 0x2B, 0x6A, 0x06, 0x8F, 0x3B, 0x2F, 0xEA, 0x56, 0xE3, 0xAF, 0x86, 0x8D, 0x9E, 0x17
	.byte 0xF7, 0x9E, 0xB4, 0x65, 0x75, 0x02, 0x4D, 0xEF, 0xCB, 0x09, 0xA2, 0x21, 0x51, 0xD8, 0x9B, 0xD0
	.byte 0x67, 0xD0, 0xBA, 0x0D, 0x92, 0x06, 0x14, 0x73, 0xD4, 0x93, 0xCB, 0x97, 0x2A, 0x00, 0x9C, 0x5C
	.byte 0x4E, 0x0C, 0xBC, 0xFA, 0x15, 0x52, 0xFC, 0xF2, 0x44, 0x6E, 0xDA, 0x11, 0x4A, 0x6E, 0x08, 0x9F
	.byte 0x2F, 0x2D, 0xE3, 0xF9, 0xAA, 0x3A, 0x86, 0x73, 0xB6, 0x46, 0x53, 0x58, 0xC8, 0x89, 0x05, 0xBD
	.byte 0x83, 0x11, 0xB8, 0x73, 0x3F, 0xAA, 0x07, 0x8D, 0xF4, 0x42, 0x4D, 0xE7, 0x40, 0x9D, 0x1C, 0x37

aZaWesternCapeC: // 0x0211BB40
	.asciz "ZA, Western Cape, Cape Town, Thawte Consulting cc, Certification Services Division, Thawte Premium Server CA, premium-server@thawte.com"
	.align 4
	
.public _0211BBC8
_0211BBC8:
	.byte 0x01, 0x00, 0x01, 0x00, 0xE0, 0xBB, 0x11, 0x02
	.byte 0x80, 0x00, 0x00, 0x00, 0x60, 0xBC, 0x11, 0x02, 0x03, 0x00, 0x00, 0x00, 0xC8, 0xBB, 0x11, 0x02

aZaWesternCapeC_0: // 0x0211BBE0
	.asciz "ZA, Western Cape, Cape Town, Thawte Consulting cc, Certification Services Division, Thawte Server CA, server-certs@thawte.com"
	.align 4
	
.public _0211BC60
_0211BC60:
	.byte 0xD3, 0xA4, 0x50, 0x6E, 0xC8, 0xFF, 0x56, 0x6B, 0xE6, 0xCF, 0x5D, 0xB6, 0xEA, 0x0C, 0x68, 0x75
	.byte 0x47, 0xA2, 0xAA, 0xC2, 0xDA, 0x84, 0x25, 0xFC, 0xA8, 0xF4, 0x47, 0x51, 0xDA, 0x85, 0xB5, 0x20
	.byte 0x74, 0x94, 0x86, 0x1E, 0x0F, 0x75, 0xC9, 0xE9, 0x08, 0x61, 0xF5, 0x06, 0x6D, 0x30, 0x6E, 0x15
	.byte 0x19, 0x02, 0xE9, 0x52, 0xC0, 0x62, 0xDB, 0x4D, 0x99, 0x9E, 0xE2, 0x6A, 0x0C, 0x44, 0x38, 0xCD
	.byte 0xFE, 0xBE, 0xE3, 0x64, 0x09, 0x70, 0xC5, 0xFE, 0xB1, 0x6B, 0x29, 0xB6, 0x2F, 0x49, 0xC8, 0x3B
	.byte 0xD4, 0x27, 0x04, 0x25, 0x10, 0x97, 0x2F, 0xE7, 0x90, 0x6D, 0xC0, 0x28, 0x42, 0x99, 0xD7, 0x4C
	.byte 0x43, 0xDE, 0xC3, 0xF5, 0x21, 0x6D, 0x54, 0x9F, 0x5D, 0xC3, 0x58, 0xE1, 0xC0, 0xE4, 0xD9, 0x5B
	.byte 0xB0, 0xB8, 0xDC, 0xB4, 0x7B, 0xDF, 0x36, 0x3A, 0xC2, 0xB5, 0x66, 0x22, 0x12, 0xD6, 0x87, 0x0D
	.byte 0x01, 0x00, 0x01, 0x00, 0x78, 0xBD, 0x11, 0x02, 0x80, 0x00, 0x00, 0x00, 0xF8, 0xBC, 0x11, 0x02
	.byte 0x03, 0x00, 0x00, 0x00, 0xE0, 0xBC, 0x11, 0x02, 0xCC, 0x5E, 0xD1, 0x11, 0x5D, 0x5C, 0x69, 0xD0
	.byte 0xAB, 0xD3, 0xB9, 0x6A, 0x4C, 0x99, 0x1F, 0x59, 0x98, 0x30, 0x8E, 0x16, 0x85, 0x20, 0x46, 0x6D
	.byte 0x47, 0x3F, 0xD4, 0x85, 0x20, 0x84, 0xE1, 0x6D, 0xB3, 0xF8, 0xA4, 0xED, 0x0C, 0xF1, 0x17, 0x0F
	.byte 0x3B, 0xF9, 0xA7, 0xF9, 0x25, 0xD7, 0xC1, 0xCF, 0x84, 0x63, 0xF2, 0x7C, 0x63, 0xCF, 0xA2, 0x47
	.byte 0xF2, 0xC6, 0x5B, 0x33, 0x8E, 0x64, 0x40, 0x04, 0x68, 0xC1, 0x80, 0xB9, 0x64, 0x1C, 0x45, 0x77
	.byte 0xC7, 0xD8, 0x6E, 0xF5, 0x95, 0x29, 0x3C, 0x50, 0xE8, 0x34, 0xD7, 0x78, 0x1F, 0xA8, 0xBA, 0x6D
	.byte 0x43, 0x91, 0x95, 0x8F, 0x45, 0x57, 0x5E, 0x7E, 0xC5, 0xFB, 0xCA, 0xA4, 0x04, 0xEB, 0xEA, 0x97
	.byte 0x37, 0x54, 0x30, 0x6F, 0xBB, 0x01, 0x47, 0x32, 0x33, 0xCD, 0xDC, 0x57, 0x9B, 0x64, 0x69, 0x61
	.byte 0xF8, 0x9B, 0x1D, 0x1C, 0x89, 0x4F, 0x5C, 0x67

aUsVerisignIncC: // 0x0211BD78
	.asciz "US, VeriSign, Inc., Class 3 Public Primary Certification Authority - G2, (c) 1998 VeriSign, Inc. - For authorized use only, VeriSign Trust Network"
	.align 4
	
.public _0211BE0C
_0211BE0C:
	.byte 0x01, 0x00, 0x01, 0x00
	.byte 0x24, 0xBE, 0x11, 0x02, 0x00, 0x01, 0x00, 0x00, 0xC0, 0xBE, 0x11, 0x02, 0x03, 0x00, 0x00, 0x00
	.byte 0x0C, 0xBE, 0x11, 0x02

aUsVerisignIncV: // 0x0211BE24
	.asciz "US, VeriSign, Inc., VeriSign Trust Network, (c) 1999 VeriSign, Inc. - For authorized use only, VeriSign Class 3 Public Primary Certification Authority - G3"
	.align 4
	
.public _0211BEC0
_0211BEC0:
	.byte 0xCB, 0xBA, 0x9C, 0x52, 0xFC, 0x78, 0x1F, 0x1A, 0x1E, 0x6F, 0x1B, 0x37, 0x73, 0xBD, 0xF8, 0xC9
	.byte 0x6B, 0x94, 0x12, 0x30, 0x4F, 0xF0, 0x36, 0x47, 0xF5, 0xD0, 0x91, 0x0A, 0xF5, 0x17, 0xC8, 0xA5
	.byte 0x61, 0xC1, 0x16, 0x40, 0x4D, 0xFB, 0x8A, 0x61, 0x90, 0xE5, 0x76, 0x20, 0xC1, 0x11, 0x06, 0x7D
	.byte 0xAB, 0x2C, 0x6E, 0xA6, 0xF5, 0x11, 0x41, 0x8E, 0xFA, 0x2D, 0xAD, 0x2A, 0x61, 0x59, 0xA4, 0x67
	.byte 0x26, 0x4C, 0xD0, 0xE8, 0xBC, 0x52, 0x5B, 0x70, 0x20, 0x04, 0x58, 0xD1, 0x7A, 0xC9, 0xA4, 0x69
	.byte 0xBC, 0x83, 0x17, 0x64, 0xAD, 0x05, 0x8B, 0xBC, 0xD0, 0x58, 0xCE, 0x8D, 0x8C, 0xF5, 0xEB, 0xF0
	.byte 0x42, 0x49, 0x0B, 0x9D, 0x97, 0x27, 0x67, 0x32, 0x6E, 0xE1, 0xAE, 0x93, 0x15, 0x1C, 0x70, 0xBC
	.byte 0x20, 0x4D, 0x2F, 0x18, 0xDE, 0x92, 0x88, 0xE8, 0x6C, 0x85, 0x57, 0x11, 0x1A, 0xE9, 0x7E, 0xE3
	.byte 0x26, 0x11, 0x54, 0xA2, 0x45, 0x96, 0x55, 0x83, 0xCA, 0x30, 0x89, 0xE8, 0xDC, 0xD8, 0xA3, 0xED
	.byte 0x2A, 0x80, 0x3F, 0x7F, 0x79, 0x65, 0x57, 0x3E, 0x15, 0x20, 0x66, 0x08, 0x2F, 0x95, 0x93, 0xBF
	.byte 0xAA, 0x47, 0x2F, 0xA8, 0x46, 0x97, 0xF0, 0x12, 0xE2, 0xFE, 0xC2, 0x0A, 0x2B, 0x51, 0xE6, 0x76
	.byte 0xE6, 0xB7, 0x46, 0xB7, 0xE2, 0x0D, 0xA6, 0xCC, 0xA8, 0xC3, 0x4C, 0x59, 0x55, 0x89, 0xE6, 0xE8
	.byte 0x53, 0x5C, 0x1C, 0xEA, 0x9D, 0xF0, 0x62, 0x16, 0x0B, 0xA7, 0xC9, 0x5F, 0x0C, 0xF0, 0xDE, 0xC2
	.byte 0x76, 0xCE, 0xAF, 0xF7, 0x6A, 0xF2, 0xFA, 0x41, 0xA6, 0xA2, 0x33, 0x14, 0xC9, 0xE5, 0x7A, 0x63
	.byte 0xD3, 0x9E, 0x62, 0x37, 0xD5, 0x85, 0x65, 0x9E, 0x0E, 0xE6, 0x53, 0x24, 0x74, 0x1B, 0x5E, 0x1D
	.byte 0x12, 0x53, 0x5B, 0xC7, 0x2C, 0xE7, 0x83, 0x49, 0x3B, 0x15, 0xAE, 0x8A, 0x68, 0xB9, 0x57, 0x97
	.byte 0x01, 0x00, 0x01, 0x00, 0xD8, 0xBF, 0x11, 0x02, 0x80, 0x00, 0x00, 0x00, 0x1C, 0xC0, 0x11, 0x02
	.byte 0x03, 0x00, 0x00, 0x00, 0xC0, 0xBF, 0x11, 0x02

aUsVerisignIncC_0: // 0x0211BFD8
	.asciz "US, VeriSign, Inc., Class 3 Public Primary Certification Authority"
	.align 4
	
.public _0211C01C
_0211C01C:
	.byte 0xC9, 0x5C, 0x59, 0x9E
	.byte 0xF2, 0x1B, 0x8A, 0x01, 0x14, 0xB4, 0x10, 0xDF, 0x04, 0x40, 0xDB, 0xE3, 0x57, 0xAF, 0x6A, 0x45
	.byte 0x40, 0x8F, 0x84, 0x0C, 0x0B, 0xD1, 0x33, 0xD9, 0xD9, 0x11, 0xCF, 0xEE, 0x02, 0x58, 0x1F, 0x25
	.byte 0xF7, 0x2A, 0xA8, 0x44, 0x05, 0xAA, 0xEC, 0x03, 0x1F, 0x78, 0x7F, 0x9E, 0x93, 0xB9, 0x9A, 0x00
	.byte 0xAA, 0x23, 0x7D, 0xD6, 0xAC, 0x85, 0xA2, 0x63, 0x45, 0xC7, 0x72, 0x27, 0xCC, 0xF4, 0x4C, 0xC6
	.byte 0x75, 0x71, 0xD2, 0x39, 0xEF, 0x4F, 0x42, 0xF0, 0x75, 0xDF, 0x0A, 0x90, 0xC6, 0x8E, 0x20, 0x6F
	.byte 0x98, 0x0F, 0xF8, 0xAC, 0x23, 0x5F, 0x70, 0x29, 0x36, 0xA4, 0xC9, 0x86, 0xE7, 0xB1, 0x9A, 0x20
	.byte 0xCB, 0x53, 0xA5, 0x85, 0xE7, 0x3D, 0xBE, 0x7D, 0x9A, 0xFE, 0x24, 0x45, 0x33, 0xDC, 0x76, 0x15
	.byte 0xED, 0x0F, 0xA2, 0x71, 0x64, 0x4C, 0x65, 0x2E, 0x81, 0x68, 0x45, 0xA7, 0x01, 0x00, 0x01, 0x00
	.byte 0xB4, 0xC0, 0x11, 0x02, 0x7D, 0x00, 0x00, 0x00, 0xF8, 0xC0, 0x11, 0x02, 0x03, 0x00, 0x00, 0x00
	.byte 0x9C, 0xC0, 0x11, 0x02

aUsRsaDataSecur: // 0x0211C0B4
	.asciz "US, RSA Data Security, Inc., Secure Server Certification Authority"
	.align 4
	
.public _0211C0F8
_0211C0F8:
	.byte 0x92, 0xCE, 0x7A, 0xC1, 0xAE, 0x83, 0x3E, 0x5A
	.byte 0xAA, 0x89, 0x83, 0x57, 0xAC, 0x25, 0x01, 0x76, 0x0C, 0xAD, 0xAE, 0x8E, 0x2C, 0x37, 0xCE, 0xEB
	.byte 0x35, 0x78, 0x64, 0x54, 0x03, 0xE5, 0x84, 0x40, 0x51, 0xC9, 0xBF, 0x8F, 0x08, 0xE2, 0x8A, 0x82
	.byte 0x08, 0xD2, 0x16, 0x86, 0x37, 0x55, 0xE9, 0xB1, 0x21, 0x02, 0xAD, 0x76, 0x68, 0x81, 0x9A, 0x05
	.byte 0xA2, 0x4B, 0xC9, 0x4B, 0x25, 0x66, 0x22, 0x56, 0x6C, 0x88, 0x07, 0x8F, 0xF7, 0x81, 0x59, 0x6D
	.byte 0x84, 0x07, 0x65, 0x70, 0x13, 0x71, 0x76, 0x3E, 0x9B, 0x77, 0x4C, 0xE3, 0x50, 0x89, 0x56, 0x98
	.byte 0x48, 0xB9, 0x1D, 0xA7, 0x29, 0x1A, 0x13, 0x2E, 0x4A, 0x11, 0x59, 0x9C, 0x1E, 0x15, 0xD5, 0x49
	.byte 0x54, 0x2C, 0x73, 0x3A, 0x69, 0x82, 0xB1, 0x97, 0x39, 0x9C, 0x6D, 0x70, 0x67, 0x48, 0xE5, 0xDD
	.byte 0x2D, 0xD6, 0xC8, 0x1E, 0x7B, 0x00, 0x00, 0x00