#ifndef NITRO_FX_FX_MTX43_H
#define NITRO_FX_FX_MTX43_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void MTX_Identity43_(register MtxFx43 *pDst);
void MTX_Copy43To44_(register const MtxFx43 *pSrc, register MtxFx44 *pDst);
void MTX_TransApply43(const MtxFx43 *pSrc, MtxFx43 *pDst, fx32 x, fx32 y, fx32 z);
void MTX_ScaleApply43(const MtxFx43 *pSrc, MtxFx43 *pDst, fx32 x, fx32 y, fx32 z);
void MTX_RotY43_(register MtxFx43 *pDst, register fx32 sinVal, register fx32 cosVal);
void MTX_RotZ43_(register MtxFx43 *pDst, register fx32 sinVal, register fx32 cosVal);
int MTX_Inverse43(const MtxFx43 *pSrc, MtxFx43 *pDst);
void MTX_Concat43(const MtxFx43 *a, const MtxFx43 *b, MtxFx43 *ab);
void MTX_MultVec43(const VecFx32 *vec, const MtxFx43 *m, VecFx32 *dst);

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE void MTX_Identity43(MtxFx43 *pDst)
{
    MTX_Identity43_(pDst);
}

SDK_INLINE void MTX_Copy43(const MtxFx43 *pSrc, MtxFx43 *pDst)
{
    MI_Copy48B(pSrc, pDst);
}

SDK_INLINE void MTX_Copy43To33(const MtxFx43 *pSrc, MtxFx33 *pDst)
{
    MI_Copy36B(pSrc, pDst);
}

SDK_INLINE void MTX_Copy43To44(const MtxFx43 *pSrc, MtxFx44 *pDst)
{
    MTX_Copy43To44_(pSrc, pDst);
}

SDK_INLINE void MTX_RotY43(MtxFx43 *pDst, fx32 sinVal, fx32 cosVal)
{
    MTX_RotY43_(pDst, sinVal, cosVal);
}

SDK_INLINE void MTX_RotZ43(MtxFx43 *pDst, fx32 sinVal, fx32 cosVal)
{
    MTX_RotZ43_(pDst, sinVal, cosVal);
}

SDK_INLINE void MTX_LookAt(const VecFx32 *camPos, const VecFx32 *camUp, const VecFx32 *target, MtxFx43 *mtx)
{
    G3i_LookAt_(camPos, camUp, target, FALSE, mtx);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_FX_FX_MTX43_H
