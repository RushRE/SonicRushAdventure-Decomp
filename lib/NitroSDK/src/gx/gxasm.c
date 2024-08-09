#include <nitro.h>

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code32.h>
asm void GX_SendFifo48B(register const void *pSrc, register void *pDest)
{
    // clang-format off
    ldmia   r0!, {r2,r3,r12}
    stmia   r1,  {r2,r3,r12}
    ldmia   r0!, {r2,r3,r12}
    stmia   r1,  {r2,r3,r12}
    ldmia   r0!, {r2,r3,r12}
    stmia   r1,  {r2,r3,r12}
    ldmia   r0!, {r2,r3,r12}
    stmia   r1,  {r2,r3,r12}

    bx      lr
    // clang-format on
}

asm void GX_SendFifo64B(register const void *pSrc, register void *pDest)
{
    // clang-format off
    stmfd   sp!, {r4-r8}

    ldmia   r0!, {r2-r8, r12}
    stmia   r1,  {r2-r8, r12}
    ldmia   r0!, {r2-r8, r12}
    stmia   r1,  {r2-r8, r12}

    ldmfd   sp!, {r4-r8}
    bx      lr
    // clang-format on
}

asm void GX_SendFifo128B(register const void *pSrc, register void *pDest)
{
    // clang-format off
    stmfd   sp!, {r4-r8}

    ldmia   r0!, {r2-r8, r12}
    stmia   r1,  {r2-r8, r12}
    ldmia   r0!, {r2-r8, r12}
    stmia   r1,  {r2-r8, r12}
    ldmia   r0!, {r2-r8, r12}
    stmia   r1,  {r2-r8, r12}
    ldmia   r0!, {r2-r8, r12}
    stmia   r1,  {r2-r8, r12}

    ldmfd   sp!, {r4-r8}
    bx      lr
    // clang-format on
}

#include <nitro/codereset.h>