#include <nitro.h>

#ifdef SDK_ARM9

#include <nitro/fx/fx_vec.h>

// --------------------
// FUNCTIONS
// --------------------

void VEC_Add(const VecFx32 *a, const VecFx32 *b, VecFx32 *ab)
{
    ab->x = a->x + b->x;
    ab->y = a->y + b->y;
    ab->z = a->z + b->z;
}

void VEC_Subtract(const VecFx32 *a, const VecFx32 *b, VecFx32 *ab)
{
    ab->x = a->x - b->x;
    ab->y = a->y - b->y;
    ab->z = a->z - b->z;
}

fx32 VEC_DotProduct(const VecFx32 *a, const VecFx32 *b)
{
    return (fx32)(((fx64)a->x * b->x + (fx64)a->y * b->y + (fx64)a->z * b->z + (1 << (FX64_SHIFT - 1))) >> FX64_SHIFT);
}

void VEC_CrossProduct(const VecFx32 *a, const VecFx32 *b, VecFx32 *axb)
{
    fx32 x, y, z;

    x = (fx32)(((fx64)a->y * b->z - (fx64)a->z * b->y + (1 << (FX64_SHIFT - 1))) >> FX64_SHIFT);
    y = (fx32)(((fx64)a->z * b->x - (fx64)a->x * b->z + (1 << (FX64_SHIFT - 1))) >> FX64_SHIFT);
    z = (fx32)(((fx64)a->x * b->y - (fx64)a->y * b->x + (1 << (FX64_SHIFT - 1))) >> FX32_SHIFT);

    axb->x = x;
    axb->y = y;
    axb->z = z;
}

fx32 VEC_Mag(const VecFx32 *pSrc)
{
    fx64 t, rval;

    t = (fx64)pSrc->x * pSrc->x;
    t += (fx64)pSrc->y * pSrc->y;
    t += (fx64)pSrc->z * pSrc->z;

    t <<= 2;

    CP_SetSqrt64((u64)t);
    rval = ((fx32)CP_GetSqrtResult32() + 1) >> 1;
    return rval;
}

void VEC_Normalize(const VecFx32 *pSrc, VecFx32 *pDst)
{
    fx64 t;
    s32 sqrt;

    t = (fx64)pSrc->x * pSrc->x;
    t += (fx64)pSrc->y * pSrc->y;
    t += (fx64)pSrc->z * pSrc->z;

    CP_SetDiv64_64(1LL << (FX32_SHIFT + FX32_SHIFT + FX64C_SHIFT), (u64)t);
    CP_SetSqrt64((u64)(t << 2));

    sqrt = (s32)CP_GetSqrtResult32();
    t    = CP_GetDivResult64();

    t       = t * sqrt;
    pDst->x = (fx32)((t * pSrc->x + (1LL << (32 + FX32_SHIFT))) >> (32 + FX32_SHIFT + 1));
    pDst->y = (fx32)((t * pSrc->y + (1LL << (32 + FX32_SHIFT))) >> (32 + FX32_SHIFT + 1));
    pDst->z = (fx32)((t * pSrc->z + (1LL << (32 + FX32_SHIFT))) >> (32 + FX32_SHIFT + 1));
}

void VEC_MultAdd(fx32 a, const VecFx32 *v1, const VecFx32 *v2, VecFx32 *pDest)
{
    pDest->x = v2->x + (fx32)(((fx64)a * v1->x) >> FX32_SHIFT);
    pDest->y = v2->y + (fx32)(((fx64)a * v1->y) >> FX32_SHIFT);
    pDest->z = v2->z + (fx32)(((fx64)a * v1->z) >> FX32_SHIFT);
}

fx32 VEC_Distance(const VecFx32 *v1, const VecFx32 *v2)
{
    fx64 tmp, diff;

    diff = v1->x - v2->x;
    tmp  = (fx64)diff * diff;

    diff = v1->y - v2->y;
    tmp += (fx64)diff * diff;

    diff = v1->z - v2->z;
    tmp += (fx64)diff * diff;

    tmp <<= 2;
    CP_SetSqrt64((u64)tmp);

    return ((fx32)CP_GetSqrtResult32() + 1) >> 1;
}

#endif