#include <nitro.h>

#ifdef SDK_ARM9

#include <nitro/fx/fx_mtx44.h>

// --------------------
// FUNCTIONS
// --------------------

inline fx32 mul64(fx64 x, fx32 y)
{
    return (fx32)((x * y) >> FX32_SHIFT);
}

#include <nitro/code32.h>

asm void MTX_Identity44_(register MtxFx44 *pDst)
{
    // clang-format off
    mov r2, #FX_ONE
    mov r3, #0
    stmia r0!, {r2,r3}
    mov r1, #0
    stmia r0!, {r1,r3}
    stmia r0!, {r1,r2,r3}
    stmia r0!, {r1,r3}
    stmia r0!, {r1,r2,r3}
    stmia r0!, {r1,r3}
    stmia r0!, {r1,r2}

    bx lr
    // clang-format on
}

asm void MTX_Copy44To43_(register const MtxFx44 *pSrc, register MtxFx43 *pDst)
{
    // clang-format off
    ldmia r0!, {r2, r3, ip}
	add r0, r0, #4
	stmia r1!, {r2, r3, ip}

	ldmia r0!, {r2, r3, ip}
	add r0, r0, #4
	stmia r1!, {r2, r3, ip}

	ldmia r0!, {r2, r3, ip}
	add r0, r0, #4
	stmia r1!, {r2, r3, ip}

	ldmia r0!, {r2, r3, ip}
	add r0, r0, #4
	stmia r1!, {r2, r3, ip}

	bx lr
    // clang-format on
}

void MTX_Concat44(const MtxFx44 *a, const MtxFx44 *b, MtxFx44 *ab)
{
    MtxFx44 tmp;
    MtxFx44 *p;

    register fx32 x, y, z, w;
    register fx32 xx, yy, zz, ww;

    if (ab == b)
        p = &tmp;
    else
        p = ab;

    // Row 0
    x = a->_00;
    y = a->_01;
    z = a->_02;
    w = a->_03;

    p->_00 = (fx32)(((fx64)x * b->_00 + (fx64)y * b->_10 + (fx64)z * b->_20 + (fx64)w * b->_30) >> FX32_SHIFT);
    p->_01 = (fx32)(((fx64)x * b->_01 + (fx64)y * b->_11 + (fx64)z * b->_21 + (fx64)w * b->_31) >> FX32_SHIFT);
    p->_03 = (fx32)(((fx64)x * b->_03 + (fx64)y * b->_13 + (fx64)z * b->_23 + (fx64)w * b->_33) >> FX32_SHIFT);

    xx = b->_02;
    yy = b->_12;
    zz = b->_22;
    ww = b->_32;

    p->_02 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz + (fx64)w * ww) >> FX32_SHIFT);

    // Row 1
    x = a->_10;
    y = a->_11;
    z = a->_12;
    w = a->_13;

    p->_12 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz + (fx64)w * ww) >> FX32_SHIFT);
    p->_11 = (fx32)(((fx64)x * b->_01 + (fx64)y * b->_11 + (fx64)z * b->_21 + (fx64)w * b->_31) >> FX32_SHIFT);
    p->_13 = (fx32)(((fx64)x * b->_03 + (fx64)y * b->_13 + (fx64)z * b->_23 + (fx64)w * b->_33) >> FX32_SHIFT);

    xx = b->_00;
    yy = b->_10;
    zz = b->_20;
    ww = b->_30;

    p->_10 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz + (fx64)w * ww) >> FX32_SHIFT);

    // Row 2
    x = a->_20;
    y = a->_21;
    z = a->_22;
    w = a->_23;

    p->_20 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz + (fx64)w * ww) >> FX32_SHIFT);
    p->_21 = (fx32)(((fx64)x * b->_01 + (fx64)y * b->_11 + (fx64)z * b->_21 + (fx64)w * b->_31) >> FX32_SHIFT);
    p->_23 = (fx32)(((fx64)x * b->_03 + (fx64)y * b->_13 + (fx64)z * b->_23 + (fx64)w * b->_33) >> FX32_SHIFT);

    xx = b->_02;
    yy = b->_12;
    zz = b->_22;
    ww = b->_32;

    p->_22 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz + (fx64)w * ww) >> FX32_SHIFT);

    // Row 3
    x = a->_30;
    y = a->_31;
    z = a->_32;
    w = a->_33;

    p->_32 = (fx32)(((fx64)x * xx + (fx64)y * yy + (fx64)z * zz + (fx64)w * ww) >> FX32_SHIFT);
    p->_31 = (fx32)(((fx64)x * b->_01 + (fx64)y * b->_11 + (fx64)z * b->_21 + (fx64)w * b->_31) >> FX32_SHIFT);
    p->_30 = (fx32)(((fx64)x * b->_00 + (fx64)y * b->_10 + (fx64)z * b->_20 + (fx64)w * b->_30) >> FX32_SHIFT);
    p->_33 = (fx32)(((fx64)x * b->_03 + (fx64)y * b->_13 + (fx64)z * b->_23 + (fx64)w * b->_33) >> FX32_SHIFT);

    if (p == &tmp)
        *ab = tmp;
}

#include <nitro/codereset.h>

#endif