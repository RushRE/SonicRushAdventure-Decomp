#ifndef NITRO_G3_UTIL_H
#define NITRO_G3_UTIL_H

#include <nitro/gx/gxcommon.h>
#include <nitro/gx/g3.h>
#include <nitro/fx/fx.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// INTERNAL FUNCTIONS
// --------------------

void G3i_FrustumW_(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, fx32 scaleW, BOOL draw, MtxFx44 *mtx);
void G3i_PerspectiveW_(fx32 fovySin, fx32 fovyCos, fx32 aspect, fx32 n, fx32 f, fx32 scaleW, BOOL draw, MtxFx44 *mtx);
void G3i_OrthoW_(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, fx32 scaleW, BOOL draw, MtxFx44 *mtx);
void G3i_LookAt_(const VecFx32 *camPos, const VecFx32 *camUp, const VecFx32 *target, BOOL draw, MtxFx43 *mtx);

// --------------------
// FUNCTIONS
// --------------------

static inline void G3_Frustum(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, MtxFx44 *mtx)
{
    G3i_FrustumW_(t, b, l, r, n, f, FX32_ONE, TRUE, mtx);
}

static inline void G3_Perspective(fx32 fovySin, fx32 fovyCos, fx32 aspect, fx32 n, fx32 f, MtxFx44 *mtx)
{
    G3i_PerspectiveW_(fovySin, fovyCos, aspect, n, f, FX32_ONE, TRUE, mtx);
}

static inline void G3_Ortho(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, MtxFx44 *mtx)
{
    G3i_OrthoW_(t, b, l, r, n, f, FX32_ONE, TRUE, mtx);
}

static inline void G3_FrustumW(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, fx32 scaleW, MtxFx44 *mtx)
{
    G3i_FrustumW_(t, b, l, r, n, f, scaleW, TRUE, mtx);
}

static inline void G3_PerspectiveW(fx32 fovySin, fx32 fovyCos, fx32 aspect, fx32 n, fx32 f, fx32 scaleW, MtxFx44 *mtx)
{
    G3i_PerspectiveW_(fovySin, fovyCos, aspect, n, f, scaleW, TRUE, mtx);
}

static inline void G3_OrthoW(fx32 t, fx32 b, fx32 l, fx32 r, fx32 n, fx32 f, fx32 scaleW, MtxFx44 *mtx)
{
    G3i_OrthoW_(t, b, l, r, n, f, scaleW, TRUE, mtx);
}

static inline void G3_LookAt(const VecFx32 *camPos, const VecFx32 *camUp, const VecFx32 *target, MtxFx43 *mtx)
{
    G3i_LookAt_(camPos, camUp, target, TRUE, mtx);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_G3_UTIL_H
