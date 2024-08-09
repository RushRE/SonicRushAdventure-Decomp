#ifndef NITRO_FX_FX_VEC_H
#define NITRO_FX_FX_VEC_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void VEC_Add(const VecFx32 *a, const VecFx32 *b, VecFx32 *ab);
void VEC_Subtract(const VecFx32 *a, const VecFx32 *b, VecFx32 *ab);
fx32 VEC_DotProduct(const VecFx32 *a, const VecFx32 *b);
void VEC_CrossProduct(const VecFx32 *a, const VecFx32 *b, VecFx32 *axb);
fx32 VEC_Mag(const VecFx32 *pSrc);
void VEC_Normalize(const VecFx32 *pSrc, VecFx32 *pDst);
void VEC_MultAdd(fx32 a, const VecFx32 *v1, const VecFx32 *v2, VecFx32 *pDest);
fx32 VEC_Distance(const VecFx32 *v1, const VecFx32 *v2);

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE void VEC_Set(VecFx32 *a, fx32 x, fx32 y, fx32 z)
{
    a->x = x;
    a->y = y;
    a->z = z;
}

SDK_INLINE void VEC_Fx16Set(VecFx16 *a, fx16 x, fx16 y, fx16 z)
{
    a->x = x;
    a->y = y;
    a->z = z;
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_FX_FX_VEC_H
