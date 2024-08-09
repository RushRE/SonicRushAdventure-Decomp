#ifndef NNSG3D_UTIL_INLINE_H
#define NNSG3D_UTIL_INLINE_H

// --------------------
// FUNCTIONS
// --------------------

NNS_G3D_INLINE BOOL NNSi_G3dBitVecCheck(const u32 *vec, u32 idx)
{
    return (BOOL)(vec[idx >> 5] & (1 << (idx & 31)));
}

NNS_G3D_INLINE void NNSi_G3dBitVecSet(u32 *vec, u32 idx)
{
    vec[idx >> 5] |= 1 << (idx & 31);
}

NNS_G3D_INLINE void NNSi_G3dBitVecReset(u32 *vec, u32 idx)
{
    vec[idx >> 5] &= ~(1 << (idx & 31));
}

#endif // NNSG3D_UTIL_INLINE_H
