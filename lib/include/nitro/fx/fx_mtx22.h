#ifndef NITR_FX_FX_MTX22_H
#define NITR_FX_FX_MTX22_H

#include <nitro/types.h>
#include <nitro/fx/fx.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void MTX_Identity22_(register MtxFx22 *pDst);
void MTX_Scale22_(register MtxFx22 *pDst, register fx32 x, register fx32 y);
void MTX_Rot22_(register MtxFx22 *pDst, register fx32 sinVal, register fx32 cosVal);
void MTX_ScaleApply22(const MtxFx22 *pSrc, MtxFx22 *pDst, fx32 x, fx32 y);
void MTX_Concat22(const MtxFx22 *a, const MtxFx22 *b, MtxFx22 *ab);

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE void MTX_Identity22(MtxFx22 *pDst)
{
    MTX_Identity22_(pDst);
}

SDK_INLINE void MTX_Scale22(MtxFx22 *pDst, fx32 x, fx32 y)
{
    MTX_Scale22_(pDst, x, y);
}

SDK_INLINE void MTX_Rot22(MtxFx22 *pDst, fx32 sinVal, fx32 cosVal)
{
    MTX_Rot22_(pDst, sinVal, cosVal);
}

#ifdef __cplusplus
}
#endif

#endif // NITR_FX_FX_MTX22_H
