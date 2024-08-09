#include <nitro.h>

#ifdef SDK_ARM9

#include <nitro/fx/fx_mtx22.h>

// --------------------
// FUNCTIONS
// --------------------

inline fx32 mul64(fx64 x, fx32 y)
{
    return (fx32)((x * y) >> FX32_SHIFT);
}

#include <nitro/code32.h>

asm void MTX_Identity22_(register MtxFx22 *pDst)
{
    // clang-format off
    mov  r1, #0
    mov  r2, #FX_ONE
    mov  r3, #0
    stmia r0!, {r2, r3}
    stmia r0!, {r1, r2}

    bx   lr
    // clang-format on
}

#include <nitro/code16.h>

asm void MTX_Scale22_(register MtxFx22 *pDst, register fx32 x, register fx32 y)
{
    // clang-format off
    stmia r0!, {r1}
    mov r1, #0
    str r2, [r0, #8]
    mov r2, #0
    stmia r0!, {r1, r2}

    bx lr
    // clang-format on
}

asm void MTX_Rot22_(register MtxFx22 *pDst, register fx32 sinVal, register fx32 cosVal)
{
    // clang-format off
    str r2, [r0, #0]
    str r1, [r0, #4]
    neg r1, r1
    str r1, [r0, #8]
    str r2, [r0, #12]

    bx lr
    // clang-format on
}

#include <nitro/codereset.h>

void MTX_ScaleApply22(const MtxFx22 *pSrc, MtxFx22 *pDst, fx32 x, fx32 y)
{
    fx64 v;

    v         = (fx64)x;
    pDst->_00 = mul64(v, pSrc->_00);
    pDst->_01 = mul64(v, pSrc->_01);

    v         = (fx64)y;
    pDst->_10 = mul64(v, pSrc->_10);
    pDst->_11 = mul64(v, pSrc->_11);
}

void MTX_Concat22(const MtxFx22 *a, const MtxFx22 *b, MtxFx22 *ab)
{
    MtxFx22 tmp;
    MtxFx22 *p;

    register fx32 x, y;

    if (ab == b)
    {
        p = &tmp;
    }
    else
    {
        p = ab;
    }

    // Row 0
    x = a->_00;
    y = a->_01;

    p->_00 = (fx32)(((fx64)x * b->_00 + (fx64)y * b->_10) >> FX32_SHIFT);
    p->_01 = (fx32)(((fx64)x * b->_01 + (fx64)y * b->_11) >> FX32_SHIFT);

    // Row 1
    x      = a->_10;
    y      = a->_11;
    p->_10 = (fx32)(((fx64)x * b->_00 + (fx64)y * b->_10) >> FX32_SHIFT);
    p->_11 = (fx32)(((fx64)x * b->_01 + (fx64)y * b->_11) >> FX32_SHIFT);

    if (p == &tmp)
        *ab = tmp;
}

#endif