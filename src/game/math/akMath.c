#include <game/math/akMath.h>
#include <game/math/mtMath.h>

// --------------------
// FUNCTIONS
// --------------------

BOOL AkMath__Func_2002C40(NNSG3dRS *rs, s32 num, const NNSG3dResName *name)
{
    s32 targetNode = NNS_G3dGetResDictIdxByName(&rs->pRenderObj->resMdl->nodeInfo.dict, name);
    s32 curNode    = NNS_G3dRSGetCurrentNodeDescID(rs);

    if (targetNode != curNode)
        return FALSE;

    NNS_G3dGeStoreMtx(num);

    return TRUE;
}

void AkMath__Func_2002C98(s32 radiusX, s32 radiusY, fx32 *x, fx32 *y, u16 angle)
{
    *x = MultiplyFX(radiusX, CosFX(angle)) - MultiplyFX(radiusY, SinFX(angle));
    *y = MultiplyFX(radiusX, SinFX(angle)) + MultiplyFX(radiusY, CosFX(angle));
}

NONMATCH_FUNC u16 AkMath__Func_2002D28(u16 angle, u16 targetAngle, s16 percent)
{
    // https://decomp.me/scratch/ay6vo -> 61.11%
#ifdef NON_MATCHING
    if (angle == targetAngle)
        return targetAngle;

    u16 angleDist;
    if (percent >= 0)
        angleDist = targetAngle - angle;
    else
        angleDist = angle - targetAngle;
    
    if (angleDist > MATH_ABS(percent))
    {
        angle += percent;

        targetAngle = angle;
    }
    
    return targetAngle;
#else
    // clang-format off
	cmp r0, r1
	moveq r0, r1
	bxeq lr
	cmp r2, #0
	subge r3, r1, r0
	sublt r3, r0, r1
	mov r3, r3, lsl #0x10
	cmp r2, #0
	rsblt ip, r2, #0
	mov r3, r3, lsr #0x10
	movge ip, r2
	cmp r3, ip
	ble _02002D68
	add r0, r0, r2
	mov r0, r0, lsl #0x10
	mov r1, r0, lsr #0x10
_02002D68:
	mov r0, r1
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC void AkMath__BlendColors(GXRgb *colorPtr, GXRgb inputColor1, GXRgb inputColor2, s32 id, s32 count)
{
    // https://decomp.me/scratch/lajbm -> 33.93%
#ifdef NON_MATCHING
    CP_SetDiv32_32(((inputColor2 & GX_RGB_R_MASK) >> GX_RGB_R_SHIFT) * id + ((inputColor1 & GX_RGB_R_MASK) >> GX_RGB_R_SHIFT) * (count - id), count);
    *colorPtr = (u16)(((u16)CP_GetDivResult32() << GX_RGB_R_SHIFT) & GX_RGB_R_MASK);

    CP_SetDiv32_32(((inputColor2 & GX_RGB_G_MASK) >> GX_RGB_G_SHIFT) * id + ((inputColor1 & GX_RGB_G_MASK) >> GX_RGB_G_SHIFT) * (count - id), count);
    *colorPtr |= (u16)(((u16)CP_GetDivResult32() << GX_RGB_G_SHIFT) & GX_RGB_G_MASK);

    CP_SetDiv32_32(((inputColor2 & GX_RGB_B_MASK) >> GX_RGB_B_SHIFT) * id + ((inputColor1 & GX_RGB_B_MASK) >> GX_RGB_B_SHIFT) * (count - id), count);
    *colorPtr |= (u16)(((u16)CP_GetDivResult32() << GX_RGB_B_SHIFT) & GX_RGB_B_MASK);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
	ldr r6, [sp, #0x20]
	and r4, r2, #0x1f
	mul r8, r4, r6
	and r4, r2, #0x3e0
	mov r4, r4, asr #5
	mul r5, r4, r6
	and r7, r1, #0x3e0
	sub lr, r3, r6
	and r4, r1, #0x1f
	mla r8, r4, lr, r8
	mov r7, r7, asr #5
	mla r4, r7, lr, r5
	ldr ip, =0x04000280
	mov r5, #0
	strh r5, [ip]
	str r8, [ip, #0x10]
	str r3, [ip, #0x18]
	str r5, [ip, #0x1c]
_02002DBC:
	ldrh r7, [ip]
	tst r7, #0x8000
	bne _02002DBC
	and r2, r2, #0x7c00
	mov r2, r2, asr #0xa
	mul r6, r2, r6
	ldr r2, =0x040002A0
	and r1, r1, #0x7c00
	mov r7, r1, asr #0xa
	mla r1, r7, lr, r6
	ldrsh r9, [r2, #0]
	mov r8, #0
	sub r7, r2, #0x20
	strh r8, [ip]
	str r4, [r2, #-0x10]
	sub r4, r2, #8
	mov r6, r9, lsl #0x10
	stmia r4, {r3, r5}
	mov r4, r6, lsr #0x10
_02002E08:
	ldrh r2, [r7, #0]
	tst r2, #0x8000
	bne _02002E08
	ldr lr, =0x040002A0
	mov r2, #0
	ldrsh ip, [lr]
	sub r6, lr, #8
	and r4, r4, #0x1f
	strh r2, [r7]
	str r1, [lr, #-0x10]
	mov r2, ip, lsl #0x10
	mov r1, r2, lsr #0xb
	and r1, r1, #0x3e0
	stmia r6, {r3, r5}
	orr r1, r4, r1
	strh r1, [r0]
	sub r2, lr, #0x20
_02002E4C:
	ldrh r1, [r2, #0]
	tst r1, #0x8000
	bne _02002E4C
	ldr r1, =0x040002A0
	ldrh r2, [r0, #0]
	ldrsh r1, [r1, #0]
	mov r1, r1, lsl #0x10
	mov r1, r1, lsr #6
	and r1, r1, #0x7c00
	mov r1, r1, lsl #0x10
	orr r1, r2, r1, lsr #16
	strh r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, pc}

// clang-format on
#endif
}
