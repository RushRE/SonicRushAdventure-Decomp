#ifndef NITRO_FX_FX_MTX44_H
#define NITRO_FX_FX_MTX44_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void MTX_Identity44_(register MtxFx44 *pDst);
void MTX_Copy44To43_(const register MtxFx44 *pSrc, register MtxFx43 *pDst);
void MTX_Concat44(const MtxFx44 *a, const MtxFx44 *b, MtxFx44 *ab);

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE void MTX_Identity44(MtxFx44 *pDst)
{
    MTX_Identity44_(pDst);
}

SDK_INLINE void MTX_Copy44(const MtxFx44 *pSrc, MtxFx44 *pDst)
{
    MI_Copy64B(pSrc, pDst);
}

SDK_INLINE void MTX_Copy44To43(const MtxFx44 *pSrc, MtxFx43 *pDst)
{
    MTX_Copy44To43_(pSrc, pDst);
}

SDK_INLINE void MTX_Frustum(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, MtxFx44 *mtx)
{
    G3i_FrustumW_(t, b, l, r, n, f, FX32_ONE, FALSE, mtx);
}

SDK_INLINE void MTX_Perspective(fx32 fovySin, fx32 fovyCos, fx32 aspect, fx32 n, fx32 f, MtxFx44 *mtx)
{
    G3i_PerspectiveW_(fovySin, fovyCos, aspect, n, f, FX32_ONE, FALSE, mtx);
}

SDK_INLINE void MTX_Ortho(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, MtxFx44 *mtx)
{
    G3i_OrthoW_(t, b, l, r, n, f, FX32_ONE, FALSE, mtx);
}

SDK_INLINE void MTX_FrustumW(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, fx32 scaleW, MtxFx44 *mtx)
{
    G3i_FrustumW_(t, b, l, r, n, f, scaleW, FALSE, mtx);
}

SDK_INLINE void MTX_PerspectiveW(fx32 fovySin, fx32 fovyCos, fx32 aspect, fx32 n, fx32 f, fx32 scaleW, MtxFx44 *mtx)
{
    G3i_PerspectiveW_(fovySin, fovyCos, aspect, n, f, scaleW, FALSE, mtx);
}

SDK_INLINE void MTX_OrthoW(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, fx32 scaleW, MtxFx44 *mtx)
{
    G3i_OrthoW_(t, b, l, r, n, f, scaleW, FALSE, mtx);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_FX_FX_MTX44_H
