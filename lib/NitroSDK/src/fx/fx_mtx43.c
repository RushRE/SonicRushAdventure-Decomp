#include <nitro.h>

#ifdef SDK_ARM9

#include <nitro/fx/fx_mtx43.h>

// --------------------
// FUNCTIONS
// --------------------

inline fx32 mul64(fx64 x, fx32 y)
{
    return (fx32)((x * y) >> FX32_SHIFT);
}

#include <nitro/code32.h>

asm void MTX_Identity43_(register MtxFx43 *pDst)
{
    // clang-format off
    mov  r2, #FX_ONE
    mov  r3, #0
    stmia r0!, {r2, r3}
    mov  r1, #0
    stmia r0!, {r1, r3}
    stmia r0!, {r2, r3}
    stmia r0!, {r1, r3}
    stmia r0!, {r2, r3}
    stmia r0!, {r1, r3}

    bx    lr
    // clang-format on
}

asm void MTX_Copy43To44_(register const MtxFx43 *pSrc, register MtxFx44 *pDst)
{
    // clang-format off
    stmfd sp!, {r4}

    mov   r12, #0x0000
    ldmia r0!, {r2-r4}
    stmia r1!, {r2-r4, r12}
    ldmia r0!, {r2-r4}
    stmia r1!, {r2-r4, r12}
    ldmia r0!, {r2-r4}
    stmia r1!, {r2-r4, r12}
    mov   r12, #FX_ONE
    ldmia r0!, {r2-r4}
    stmia r1!, {r2-r4, r12}

    ldmfd sp!, {r4}
    bx    lr
    // clang-format on
}

void MTX_TransApply43(const MtxFx43 *pSrc, MtxFx43 *pDst, fx32 x, fx32 y, fx32 z)
{
    if (pSrc != pDst)
        MI_Copy36B(pSrc, pDst);

    fx64 xx = x;
    fx64 yy = y;
    fx64 zz = z;

    pDst->_30 = pSrc->_30 + (fx32)((xx * pSrc->_00 + yy * pSrc->_10 + zz * pSrc->_20) >> FX32_SHIFT);
    pDst->_31 = pSrc->_31 + (fx32)((xx * pSrc->_01 + yy * pSrc->_11 + zz * pSrc->_21) >> FX32_SHIFT);
    pDst->_32 = pSrc->_32 + (fx32)((xx * pSrc->_02 + yy * pSrc->_12 + zz * pSrc->_22) >> FX32_SHIFT);
}

void MTX_ScaleApply43(const MtxFx43 *pSrc, MtxFx43 *pDst, fx32 x, fx32 y, fx32 z)
{
    MTX_ScaleApply33((const MtxFx33 *)pSrc, (MtxFx33 *)pDst, x, y, z);

    pDst->_30 = pSrc->_30;
    pDst->_31 = pSrc->_31;
    pDst->_32 = pSrc->_32;
}

#include <nitro/code16.h>

asm void MTX_RotY43_(register MtxFx43 *pDst, register fx32 sinVal, register fx32 cosVal)
{
    // clang-format off
    str   r1, [r0, #24]
    mov   r3, #0
    stmia r0!, {r2, r3}
    neg   r1, r1
    stmia r0!, {r1, r3}
    mov   r1, #1
    lsl   r1, r1, #12
    stmia r0!, {r1, r3}
    add   r0, #4
    mov   r1, #0
    stmia r0!, {r1, r2, r3}
    stmia r0!, {r1, r3}

    bx    lr
    // clang-format on
}

asm void MTX_RotZ43_(register MtxFx43 *pDst, register fx32 sinVal, register fx32 cosVal)
{
    // clang-format off
    stmia r0!, {r2}
    mov   r3, #0
    stmia r0!, {r1, r3}
    neg   r1, r1
    stmia r0!, {r1, r2, r3}
    mov   r1, #0
    mov   r2, #0
    mov   r3, #1
    lsl   r3, r3, #12
    stmia r0!, {r1, r2, r3}
    mov   r3, #0
    stmia r0!, {r1, r2, r3}

    bx    lr
    // clang-format on
}

#include <nitro/code32.h>

int MTX_Inverse43(const MtxFx43 *pSrc, MtxFx43 *pDst)
{
    MtxFx43 tmp;
    MtxFx43 *p;
    fx32 det, det00, det10, det20, tmp01, tmp02, tmp11, tmp12, tmp21, tmp22;

    if (pSrc == pDst)
        p = &tmp;
    else
        p = pDst;

    det00 = (fx32)(((fx64)pSrc->_11 * pSrc->_22 - (fx64)pSrc->_12 * pSrc->_21 + (fx64)(FX32_ONE >> 1)) >> FX32_SHIFT);
    det10 = (fx32)(((fx64)pSrc->_10 * pSrc->_22 - (fx64)pSrc->_12 * pSrc->_20 + (fx64)(FX32_ONE >> 1)) >> FX32_SHIFT);
    det20 = (fx32)(((fx64)pSrc->_10 * pSrc->_21 - (fx64)pSrc->_11 * pSrc->_20 + (fx64)(FX32_ONE >> 1)) >> FX32_SHIFT);

    det = (fx32)(((fx64)pSrc->_00 * det00 - (fx64)pSrc->_01 * det10 + (fx64)pSrc->_02 * det20 + (fx64)(FX32_ONE >> 1)) >> FX32_SHIFT);
    if (0 == det)
        return -1;

    FX_InvAsync(det);

    tmp01 = (fx32)(((fx64)pSrc->_01 * pSrc->_22 - (fx64)pSrc->_21 * pSrc->_02) >> FX32_SHIFT);
    tmp02 = (fx32)(((fx64)pSrc->_01 * pSrc->_12 - (fx64)pSrc->_11 * pSrc->_02) >> FX32_SHIFT);
    tmp11 = (fx32)(((fx64)pSrc->_00 * pSrc->_22 - (fx64)pSrc->_20 * pSrc->_02) >> FX32_SHIFT);
    tmp12 = (fx32)(((fx64)pSrc->_00 * pSrc->_12 - (fx64)pSrc->_10 * pSrc->_02) >> FX32_SHIFT);

    det    = FX_GetDivResult();
    p->_00 = (fx32)(((fx64)det * det00) >> FX32_SHIFT);
    p->_01 = -(fx32)(((fx64)det * tmp01) >> FX32_SHIFT);
    p->_02 = (fx32)(((fx64)det * tmp02) >> FX32_SHIFT);

    p->_10 = -(fx32)(((fx64)det * det10) >> FX32_SHIFT);
    p->_11 = (fx32)(((fx64)det * tmp11) >> FX32_SHIFT);
    p->_12 = -(fx32)(((fx64)det * tmp12) >> FX32_SHIFT);

    p->_20 = (fx32)(((fx64)det * det20) >> FX32_SHIFT);

    tmp21  = (fx32)(((fx64)pSrc->_00 * pSrc->_21 - (fx64)pSrc->_20 * pSrc->_01) >> FX32_SHIFT);
    p->_21 = -(fx32)(((fx64)det * tmp21) >> FX32_SHIFT);

    tmp22  = (fx32)(((fx64)pSrc->_00 * pSrc->_11 - (fx64)pSrc->_10 * pSrc->_01) >> FX32_SHIFT);
    p->_22 = (fx32)(((fx64)det * tmp22) >> FX32_SHIFT);

    p->_30 = -(fx32)(((fx64)p->_00 * pSrc->_30 + (fx64)p->_10 * pSrc->_31 + (fx64)p->_20 * pSrc->_32) >> FX32_SHIFT);

    p->_31 = -(fx32)(((fx64)p->_01 * pSrc->_30 + (fx64)p->_11 * pSrc->_31 + (fx64)p->_21 * pSrc->_32) >> FX32_SHIFT);

    p->_32 = -(fx32)(((fx64)p->_02 * pSrc->_30 + (fx64)p->_12 * pSrc->_31 + (fx64)p->_22 * pSrc->_32) >> FX32_SHIFT);

    if (p == &tmp)
        MI_Copy48B(&tmp, pDst);

    return 0;
}

void MTX_Concat43(const MtxFx43 *a, const MtxFx43 *b, MtxFx43 *ab)
{
    MtxFx43 tmp;
    MtxFx43 *p;

    register fx32 x, y, z, xx, yy, zz;

    if (ab == b)
        p = &tmp;
    else
        p = ab;

    // Row 0
    x = a->_00;
    y = a->_01;
    z = a->_02;

    p->_00 = (fx32)(((fx64)x * b->_00 + (fx64)y * b->_10 + (fx64)z * b->_20) >> FX32_SHIFT);
    p->_01 = (fx32)(((fx64)x * b->_01 + (fx64)y * b->_11 + (fx64)z * b->_21) >> FX32_SHIFT);

    xx = b->_02;
    yy = b->_12;
    zz = b->_22;

    p->_02 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz) >> FX32_SHIFT);

    // Row 1
    x = a->_10;
    y = a->_11;
    z = a->_12;

    p->_12 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz) >> FX32_SHIFT);
    p->_11 = (fx32)(((fx64)x * b->_01 + (fx64)y * b->_11 + (fx64)z * b->_21) >> FX32_SHIFT);

    xx = b->_00;
    yy = b->_10;
    zz = b->_20;

    p->_10 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz) >> FX32_SHIFT);

    // Row 2
    x = a->_20;
    y = a->_21;
    z = a->_22;

    p->_20 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz) >> FX32_SHIFT);
    p->_21 = (fx32)(((fx64)x * b->_01 + (fx64)y * b->_11 + (fx64)z * b->_21) >> FX32_SHIFT);
    xx     = b->_02;
    yy     = b->_12;
    zz     = b->_22;

    p->_22 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz) >> FX32_SHIFT);

    // Row 3
    x = a->_30;
    y = a->_31;
    z = a->_32;

    p->_32 = (fx32)((((fx64)x * xx + (fx64)y * yy + (fx64)z * zz) >> FX32_SHIFT) + b->_32);
    p->_31 = (fx32)((((fx64)x * b->_01 + (fx64)y * b->_11 + (fx64)z * b->_21) >> FX32_SHIFT) + b->_31);
    p->_30 = (fx32)((((fx64)x * b->_00 + (fx64)y * b->_10 + (fx64)z * b->_20) >> FX32_SHIFT) + b->_30);

    if (p == &tmp)
        *ab = tmp;
}

void MTX_MultVec43(const VecFx32 *vec, const MtxFx43 *m, VecFx32 *dst)
{
    register fx32 x, y, z;

    x = vec->x;
    y = vec->y;
    z = vec->z;

    dst->x = (fx32)(((fx64)x * m->_00 + (fx64)y * m->_10 + (fx64)z * m->_20) >> FX32_SHIFT);
    dst->x += m->_30;

    dst->y = (fx32)(((fx64)x * m->_01 + (fx64)y * m->_11 + (fx64)z * m->_21) >> FX32_SHIFT);
    dst->y += m->_31;

    dst->z = (fx32)(((fx64)x * m->_02 + (fx64)y * m->_12 + (fx64)z * m->_22) >> FX32_SHIFT);
    dst->z += m->_32;
}

#endif