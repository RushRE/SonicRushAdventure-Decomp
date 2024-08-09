#ifndef NITRO_FX_FX_TRIG_H
#define NITRO_FX_FX_TRIG_H

#include <nitro/fx/fx.h>
#include <nitro/fx/fx_const.h>
#include <nitro/fx/fx_atan.h>
#include <nitro/fx/fx_atanidx.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// MACROS
// --------------------

// deg must be in fx32/fx16 format
#define FX_DEG_TO_RAD(deg) ((fx32)((FX64C_TWOPI_360 * (deg) + 0x80000000LL) >> 32))
#define FX_DEG_TO_IDX(deg) ((u16)((FX64C_65536_360 * (deg) + 0x80000000000LL) >> 44))

// rad must be in fx32/fx16 format
#define FX_RAD_TO_DEG(rad) ((fx32)((FX64C_360_TWOPI * (rad) + 0x80000000LL) >> 32))
#define FX_RAD_TO_IDX(rad) ((u16)((FX64C_65536_TWOPI * (rad) + 0x80000000000LL) >> 44))

#define FX_IDX_TO_RAD(idx) ((fx32)((FX64C_TWOPI_65536 * (idx) + 0x80000LL) >> 20))
#define FX_IDX_TO_DEG(idx) ((fx32)((FX64C_360_65536 * (idx) + 0x80000LL) >> 20))

extern const fx16 FX_SinCosTable_[];

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE fx16 FX_SinIdx(int idx)
{
    return FX_SinCosTable_[((idx >> 4) << 1)];
}

SDK_INLINE fx16 FX_CosIdx(int idx)
{
    return FX_SinCosTable_[((idx >> 4) << 1) + 1];
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_FX_FX_TRIG_H
