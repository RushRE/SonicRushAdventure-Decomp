#ifndef NITRO_GX_GX_G2_H
#define NITRO_GX_GX_G2_H

#include <nitro/types.h>
#include <nitro/fx/fx.h>
#include <nitro/hw/common/io_reg.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u8 planeMask : 5;
    u8 effect : 1;
    u8 _reserve : 2;
} GXWndPlane;

// --------------------
// ENUMS
// --------------------

typedef enum GXBlendPlaneMask
{
    GX_BLEND_PLANEMASK_NONE = 0x0000,
    GX_BLEND_PLANEMASK_BG0  = 0x0001,
    GX_BLEND_PLANEMASK_BG1  = 0x0002,
    GX_BLEND_PLANEMASK_BG2  = 0x0004,
    GX_BLEND_PLANEMASK_BG3  = 0x0008,
    GX_BLEND_PLANEMASK_OBJ  = 0x0010,
    GX_BLEND_PLANEMASK_BD   = 0x0020
} GXBlendPlaneMask;

typedef enum
{
    GX_WND_PLANEMASK_NONE = 0x0000,
    GX_WND_PLANEMASK_BG0  = 0x0001,
    GX_WND_PLANEMASK_BG1  = 0x0002,
    GX_WND_PLANEMASK_BG2  = 0x0004,
    GX_WND_PLANEMASK_BG3  = 0x0008,
    GX_WND_PLANEMASK_OBJ  = 0x0010
} GXWndPlaneMask;

// --------------------
// INTERNAL FUNCTIONS
// --------------------

void G2x_SetBGyAffine_(u32 addr, const MtxFx22 *mtx, int centerX, int centerY, int x1, int y1);
void G2x_SetBlendBrightness_(u32 addr, int plane, int brightness);
void G2x_SetBlendBrightnessExt_(u32 addr, int plane1, int plane2, int ev1, int ev2, int brightness);
void G2x_ChangeBlendBrightness_(u32 addr, int brightness);

// --------------------
// INLINE FUNCTIONS
// --------------------

static inline void G2_SetWndOutsidePlane(int wnd, BOOL effect)
{
    u32 tmp;

    tmp = ((reg_G2_WINOUT & ~REG_G2_WINOUT_WINOUT_MASK) | ((u32)wnd << REG_G2_WINOUT_WINOUT_SHIFT));

    if (effect)
    {
        tmp |= (0x20 << REG_G2_WINOUT_WINOUT_SHIFT); // EFCT
    }

    reg_G2_WINOUT = (u16)tmp;
}

static inline void G2_SetBG0Offset(int hOffset, int vOffset)
{
    reg_G2_BG0OFS = (u32)(((hOffset << REG_G2_BG0OFS_HOFFSET_SHIFT) & REG_G2_BG0OFS_HOFFSET_MASK) | ((vOffset << REG_G2_BG0OFS_VOFFSET_SHIFT) & REG_G2_BG0OFS_VOFFSET_MASK));
}

static inline void G2_SetBG1Offset(int hOffset, int vOffset)
{
    reg_G2_BG1OFS = (u32)(((hOffset << REG_G2_BG1OFS_HOFFSET_SHIFT) & REG_G2_BG1OFS_HOFFSET_MASK) | ((vOffset << REG_G2_BG1OFS_VOFFSET_SHIFT) & REG_G2_BG1OFS_VOFFSET_MASK));
}

static inline void G2_SetBG2Offset(int hOffset, int vOffset)
{
    reg_G2_BG2OFS = (u32)(((hOffset << REG_G2_BG2OFS_HOFFSET_SHIFT) & REG_G2_BG2OFS_HOFFSET_MASK) | ((vOffset << REG_G2_BG2OFS_VOFFSET_SHIFT) & REG_G2_BG2OFS_VOFFSET_MASK));
}

static inline void G2_SetBG3Offset(int hOffset, int vOffset)
{
    reg_G2_BG3OFS = (u32)(((hOffset << REG_G2_BG3OFS_HOFFSET_SHIFT) & REG_G2_BG3OFS_HOFFSET_MASK) | ((vOffset << REG_G2_BG3OFS_VOFFSET_SHIFT) & REG_G2_BG3OFS_VOFFSET_MASK));
}

static inline void G2S_SetBG0Offset(int hOffset, int vOffset)
{
    reg_G2S_DB_BG0OFS = (u32)(((hOffset << REG_G2S_DB_BG0OFS_HOFFSET_SHIFT) & REG_G2S_DB_BG0OFS_HOFFSET_MASK) | ((vOffset << REG_G2S_DB_BG0OFS_VOFFSET_SHIFT) & REG_G2S_DB_BG0OFS_VOFFSET_MASK));
}

static inline void G2S_SetBG1Offset(int hOffset, int vOffset)
{
    reg_G2S_DB_BG1OFS = (u32)(((hOffset << REG_G2S_DB_BG1OFS_HOFFSET_SHIFT) & REG_G2S_DB_BG1OFS_HOFFSET_MASK) | ((vOffset << REG_G2S_DB_BG1OFS_VOFFSET_SHIFT) & REG_G2S_DB_BG1OFS_VOFFSET_MASK));
}

static inline void G2S_SetBG2Offset(int hOffset, int vOffset)
{
    reg_G2S_DB_BG2OFS = (u32)(((hOffset << REG_G2S_DB_BG2OFS_HOFFSET_SHIFT) & REG_G2S_DB_BG2OFS_HOFFSET_MASK) | ((vOffset << REG_G2S_DB_BG2OFS_VOFFSET_SHIFT) & REG_G2S_DB_BG2OFS_VOFFSET_MASK));
}

static inline void G2S_SetBG3Offset(int hOffset, int vOffset)
{
    reg_G2S_DB_BG3OFS = (u32)(((hOffset << REG_G2S_DB_BG3OFS_HOFFSET_SHIFT) & REG_G2S_DB_BG3OFS_HOFFSET_MASK) | ((vOffset << REG_G2S_DB_BG3OFS_VOFFSET_SHIFT) & REG_G2S_DB_BG3OFS_VOFFSET_MASK));
}

static inline void G2_SetBG2Affine(const MtxFx22 *mtx, int centerX, int centerY, int x1, int y1)
{
    G2x_SetBGyAffine_((u32)&reg_G2_BG2PA, mtx, centerX, centerY, x1, y1);
}

static inline void G2_SetBG3Affine(const MtxFx22 *mtx, int centerX, int centerY, int x1, int y1)
{
    G2x_SetBGyAffine_((u32)&reg_G2_BG3PA, mtx, centerX, centerY, x1, y1);
}

static inline void G2S_SetBG2Affine(const MtxFx22 *mtx, int centerX, int centerY, int x1, int y1)
{
    G2x_SetBGyAffine_((u32)&reg_G2S_DB_BG2PA, mtx, centerX, centerY, x1, y1);
}

static inline void G2S_SetBG3Affine(const MtxFx22 *mtx, int centerX, int centerY, int x1, int y1)
{
    G2x_SetBGyAffine_((u32)&reg_G2S_DB_BG3PA, mtx, centerX, centerY, x1, y1);
}

static inline void G2_BlendNone(void)
{
    reg_G2_BLDCNT = 0;
}

static inline void G2S_BlendNone(void)
{
    reg_G2S_DB_BLDCNT = 0;
}

static inline void G2_SetBlendBrightness(int plane, int brightness)
{
    G2x_SetBlendBrightness_((u32)&reg_G2_BLDCNT, plane, brightness);
}

static inline void G2S_SetBlendBrightness(int plane, int brightness)
{
    G2x_SetBlendBrightness_((u32)&reg_G2S_DB_BLDCNT, plane, brightness);
}

static inline void G2_SetBlendBrightnessExt(int plane1, int plane2, int ev1, int ev2, int brightness)
{
    G2x_SetBlendBrightnessExt_((u32)&reg_G2_BLDCNT, plane1, plane2, ev1, ev2, brightness);
}

static inline void G2S_SetBlendBrightnessExt(int plane1, int plane2, int ev1, int ev2, int brightness)
{
    G2x_SetBlendBrightnessExt_((u32)&reg_G2S_DB_BLDCNT, plane1, plane2, ev1, ev2, brightness);
}

static inline void G2_ChangeBlendBrightness(int brightness)
{
    G2x_ChangeBlendBrightness_((u32)&reg_G2_BLDCNT, brightness);
}

static inline void G2S_ChangeBlendBrightness(int brightness)
{
    G2x_ChangeBlendBrightness_((u32)&reg_G2S_DB_BLDCNT, brightness);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_GX_GX_G2_H
