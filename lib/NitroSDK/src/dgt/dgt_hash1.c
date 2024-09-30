#include <nitro.h>

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED void *_0211F864;
NOT_DECOMPILED void *_0211F7A4;
NOT_DECOMPILED void *_0211F7A0;

// --------------------
// FUNCTION DECLS
// --------------------

static void DGT_ProcessBlock(DGTHash1Context *ctx);

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void DGT_ProcessBlock(DGTHash1Context *ctx){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #4
	add r3, r0, #0x18
	ldr r5, [r0, #0]
	ldr r4, [r0, #4]
	ldr lr, [r0, #8]
	ldr ip, [r0, #0xc]
	ldr r2, =_0211F864
	mov r8, r3
	mov r7, #0
_020EC2EC:
	mvn r1, r4
	and r6, r4, lr
	and r1, r1, ip
	orr r1, r6, r1
	ldr r6, [r8, #0]
	add r1, r5, r1
	ldr r5, [r2, #0]
	add r1, r6, r1
	add r5, r5, r1
	mov r1, r5, lsl #7
	orr r1, r1, r5, lsr #25
	add r5, r4, r1
	mvn r1, r5
	and r6, r5, r4
	and r1, r1, lr
	orr r1, r6, r1
	ldr r6, [r8, #4]
	add r1, ip, r1
	ldr r9, [r2, #4]
	add r1, r6, r1
	add r6, r9, r1
	mov r1, r6, lsl #0xc
	orr r1, r1, r6, lsr #20
	add ip, r5, r1
	mvn r1, ip
	and r6, ip, r5
	and r1, r1, r4
	orr r6, r6, r1
	add r1, r8, #0xc
	ldr r9, [r8, #8]
	add r6, lr, r6
	add r6, r9, r6
	ldr r9, [r2, #8]
	ldr r1, [r1, #0]
	add r10, r9, r6
	add r6, r2, #0xc
	ldr r6, [r6, #0]
	mov r9, r10, lsl #0x11
	orr r9, r9, r10, lsr #15
	add lr, ip, r9
	add r2, r2, #0x10
	add r8, r8, #0x10
	and r10, lr, ip
	mvn r9, lr
	and r9, r9, r5
	orr r9, r10, r9
	add r4, r4, r9
	add r1, r1, r4
	add r4, r6, r1
	mov r1, r4, lsl #0x16
	orr r1, r1, r4, lsr #10
	add r4, lr, r1
	add r7, r7, #1
	cmp r7, #4
	blt _020EC2EC
	ldr r6, =_0211F7A4
	mov r1, #0
_020EC3D0:
	mvn r7, ip
	ldr r9, [r6, #0]
	and r8, r4, ip
	and r7, lr, r7
	orr r7, r8, r7
	ldr r8, [r3, r9, lsl #2]
	add r5, r5, r7
	ldr r7, [r2, #0]
	add r5, r8, r5
	add r7, r7, r5
	mov r5, r7, lsl #5
	orr r5, r5, r7, lsr #27
	add r5, r4, r5
	mvn r8, lr
	ldr r7, [r6, #4]
	and r9, r5, lr
	and r8, r4, r8
	orr r10, r9, r8
	mvn r8, r4
	ldr r9, [r6, #8]
	ldr r11, [r3, r7, lsl #2]
	add r7, ip, r10
	add r10, r11, r7
	add r7, r6, #0xc
	ldr r9, [r3, r9, lsl #2]
	and r8, r5, r8
	ldr r7, [r7, #0]
	ldr r11, [r2, #4]
	ldr r7, [r3, r7, lsl #2]
	add r11, r11, r10
	mov r10, r11, lsl #9
	orr r10, r10, r11, lsr #23
	add ip, r5, r10
	ldr r10, [r2, #8]
	and r11, ip, r4
	orr r8, r11, r8
	add r8, lr, r8
	add r8, r9, r8
	add r10, r10, r8
	add r8, r2, #0xc
	ldr r8, [r8, #0]
	mov r9, r10, lsl #0xe
	orr r9, r9, r10, lsr #18
	add lr, ip, r9
	add r2, r2, #0x10
	add r6, r6, #0x10
	and r10, lr, r5
	mvn r9, r5
	and r9, ip, r9
	orr r9, r10, r9
	add r4, r4, r9
	add r4, r7, r4
	add r7, r8, r4
	mov r4, r7, lsl #0x14
	orr r4, r4, r7, lsr #12
	add r4, lr, r4
	add r1, r1, #1
	cmp r1, #4
	blt _020EC3D0
	mov r7, #0
_020EC4C0:
	ldr r8, [r6, #0]
	eor r1, r4, lr
	eor r1, ip, r1
	add r1, r5, r1
	ldr r8, [r3, r8, lsl #2]
	ldr r5, [r2, #0]
	add r1, r8, r1
	add r5, r5, r1
	mov r1, r5, lsl #4
	orr r1, r1, r5, lsr #28
	add r5, r4, r1
	ldr r8, [r6, #4]
	eor r1, r5, r4
	eor r1, lr, r1
	ldr r8, [r3, r8, lsl #2]
	add r1, ip, r1
	ldr r9, [r6, #8]
	ldr r10, [r2, #4]
	add r1, r8, r1
	add r8, r10, r1
	mov r1, r8, lsl #0xb
	orr r1, r1, r8, lsr #21
	add ip, r5, r1
	eor r8, ip, r5
	eor r8, r4, r8
	ldr r9, [r3, r9, lsl #2]
	add r8, lr, r8
	add r9, r9, r8
	ldr r10, [r2, #8]
	add r1, r2, #0xc
	ldr r8, [r6, #0xc]
	add r10, r10, r9
	ldr r9, [r3, r8, lsl #2]
	mov r8, r10, lsl #0x10
	orr r8, r8, r10, lsr #16
	add lr, ip, r8
	eor r8, lr, ip
	eor r8, r5, r8
	add r4, r4, r8
	add r7, r7, #1
	ldr r1, [r1, #0]
	add r4, r9, r4
	add r4, r1, r4
	mov r1, r4, lsl #0x17
	orr r1, r1, r4, lsr #9
	add r2, r2, #0x10
	add r6, r6, #0x10
	add r4, lr, r1
	cmp r7, #4
	blt _020EC4C0
	mov r10, #0
_020EC58C:
	mvn r1, ip
	ldr r7, [r6, #0]
	orr r1, r4, r1
	eor r1, lr, r1
	ldr r7, [r3, r7, lsl #2]
	add r1, r5, r1
	ldr r5, [r2, #0]
	add r1, r7, r1
	add r5, r5, r1
	mov r1, r5, lsl #6
	orr r1, r1, r5, lsr #26
	add r5, r4, r1
	mvn r1, lr
	ldr r7, [r6, #4]
	orr r1, r5, r1
	eor r1, r4, r1
	ldr r8, [r6, #8]
	ldr r7, [r3, r7, lsl #2]
	add r1, ip, r1
	ldr r9, [r2, #4]
	add r1, r7, r1
	add r9, r9, r1
	mov r7, r9, lsl #0xa
	add r1, r6, #0xc
	orr r9, r7, r9, lsr #22
	ldr r1, [r1, #0]
	add r7, r2, #0xc
	add ip, r5, r9
	ldr r8, [r3, r8, lsl #2]
	ldr r7, [r7, #0]
	ldr r1, [r3, r1, lsl #2]
	ldr r9, [r2, #8]
	mvn r11, r4
	orr r11, ip, r11
	eor r11, r5, r11
	add r11, lr, r11
	add r8, r8, r11
	add r9, r9, r8
	mov r8, r9, lsl #0xf
	orr r8, r8, r9, lsr #17
	add lr, ip, r8
	add r2, r2, #0x10
	add r6, r6, #0x10
	mvn r8, r5
	orr r8, lr, r8
	eor r8, ip, r8
	add r4, r4, r8
	add r1, r1, r4
	add r4, r7, r1
	mov r1, r4, lsl #0x15
	orr r1, r1, r4, lsr #11
	add r4, lr, r1
	add r10, r10, #1
	cmp r10, #4
	blt _020EC58C
	ldr r1, [r0, #0]
	add r1, r1, r5
	str r1, [r0]
	ldr r1, [r0, #4]
	add r1, r1, r4
	str r1, [r0, #4]
	ldr r1, [r0, #8]
	add r1, r1, lr
	str r1, [r0, #8]
	ldr r1, [r0, #0xc]
	add r1, r1, ip
	str r1, [r0, #0xc]
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, r11, lr}
	bx lr
// clang-format on
#endif
}

NONMATCH_FUNC void DGT_Hash1GetDigest_R(unsigned char digest[16], DGTHash1Context *ctx){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, lr}
	sub sp, sp, #4
	mov r6, r1
	ldr r1, [r6, #0x14]
	ldr r3, [r6, #0x10]
	mov r7, r0
	mov r4, r1, lsl #3
	ldr r1, =_0211F7A0
	mov r0, r6
	mov r2, #1
	orr r4, r4, r3, lsr #29
	mov r5, r3, lsl #3
	bl DGT_Hash1SetSource
	ldr r0, [r6, #0x10]
	mov r1, #0
	and r3, r0, #0x3f
	rsb r2, r3, #0x40
	cmp r2, #8
	bhs _020EC714
	add r0, r6, #0x18
	add r0, r0, r3
	bl MI_CpuFill8
	mov r0, r6
	bl DGT_ProcessBlock
	mov r3, #0
	mov r2, #0x40
_020EC714:
	cmp r2, #8
	bls _020EC730
	add r0, r6, #0x18
	add r0, r0, r3
	sub r2, r2, #8
	mov r1, #0
	bl MI_CpuFill8
_020EC730:
	str r5, [r6, #0x50]
	mov r0, r6
	str r4, [r6, #0x54]
	bl DGT_ProcessBlock
	mov r0, r6
	mov r1, r7
	mov r2, #0x10
	bl MI_CpuCopy8
	mov r0, r6
	mov r1, #0
	mov r2, #0x58
	bl MI_CpuFill8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, lr}
	bx lr
// clang-format on
#endif
}

NONMATCH_FUNC void DGT_Hash1SetSource(DGTHash1Context *ctx, unsigned char *, unsigned long){
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, lr}
	sub sp, sp, #4
	mov r8, r0
	add ip, r8, #0x10
	ldr r4, [r8, #0x10]
	mov r6, r2
	and r3, r4, #0x3f
	ldr r0, [ip, #4]
	adds r4, r4, r6
	str r4, [r8, #0x10]
	adc r0, r0, #0
	rsb r5, r3, #0x40
	mov r7, r1
	str r0, [ip, #4]
	cmp r5, r6
	bls _020EC7DC
	cmp r6, #0
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	add r1, r8, #0x18
	mov r0, r7
	add r1, r1, r3
	bl MI_CpuCopy8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
_020EC7DC:
	add r1, r8, #0x18
	mov r0, r7
	mov r2, r5
	add r1, r1, r3
	bl MI_CpuCopy8
	mov r0, r8
	bl DGT_ProcessBlock
	sub r6, r6, r5
	mov r4, r6, lsr #6
	cmp r4, #0
	add r9, r7, r5
	ble _020EC83C
	add r7, r8, #0x18
	mov r5, #0x40
_020EC814:
	mov r0, r9
	mov r1, r7
	mov r2, r5
	bl MI_CpuCopy8
	mov r0, r8
	add r9, r9, #0x40
	bl DGT_ProcessBlock
	sub r4, r4, #1
	cmp r4, #0
	bgt _020EC814
_020EC83C:
	ands r2, r6, #0x3f
	addeq sp, sp, #4
	ldmeqia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bxeq lr
	mov r0, r9
	add r1, r8, #0x18
	bl MI_CpuCopy8
	add sp, sp, #4
	ldmia sp!, {r4, r5, r6, r7, r8, r9, lr}
	bx lr
// clang-format on
#endif
}

void DGT_Hash1Reset(DGTHash1Context *ctx)
{
    ctx->a      = 0x67452301;
    ctx->b      = 0xEFCDAB89;
    ctx->c      = 0x98BADCFE;
    ctx->d      = 0x10325476;

    ctx->length = 0;
}