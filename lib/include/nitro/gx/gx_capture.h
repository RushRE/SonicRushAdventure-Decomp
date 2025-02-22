#ifndef NITRO_GX_CAPTURE_H
#define NITRO_GX_CAPTURE_H

#include <nitro/gx/gxcommon.h>
#include <nitro/hw/io_reg.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

typedef enum
{
    GX_CAPTURE_DEST_VRAM_A_0x00000 = 0,
    GX_CAPTURE_DEST_VRAM_B_0x00000 = 1,
    GX_CAPTURE_DEST_VRAM_C_0x00000 = 2,
    GX_CAPTURE_DEST_VRAM_D_0x00000 = 3,

    GX_CAPTURE_DEST_VRAM_A_0x08000 = 4,
    GX_CAPTURE_DEST_VRAM_B_0x08000 = 5,
    GX_CAPTURE_DEST_VRAM_C_0x08000 = 6,
    GX_CAPTURE_DEST_VRAM_D_0x08000 = 7,

    GX_CAPTURE_DEST_VRAM_A_0x10000 = 8,
    GX_CAPTURE_DEST_VRAM_B_0x10000 = 9,
    GX_CAPTURE_DEST_VRAM_C_0x10000 = 10,
    GX_CAPTURE_DEST_VRAM_D_0x10000 = 11,

    GX_CAPTURE_DEST_VRAM_A_0x18000 = 12,
    GX_CAPTURE_DEST_VRAM_B_0x18000 = 13,
    GX_CAPTURE_DEST_VRAM_C_0x18000 = 14,
    GX_CAPTURE_DEST_VRAM_D_0x18000 = 15
} GXCaptureDest;

typedef enum
{
    GX_CAPTURE_SIZE_128x128 = 0,
    GX_CAPTURE_SIZE_256x64  = 1,
    GX_CAPTURE_SIZE_256x128 = 2,
    GX_CAPTURE_SIZE_256x192 = 3
} GXCaptureSize;

typedef enum
{
    GX_CAPTURE_SRCA_2D3D = 0,
    GX_CAPTURE_SRCA_3D   = 1
} GXCaptureSrcA;

typedef enum
{
    GX_CAPTURE_SRCB_VRAM_0x00000 = 0,
    GX_CAPTURE_SRCB_MRAM         = 1,
    GX_CAPTURE_SRCB_VRAM_0x08000 = 2,
    GX_CAPTURE_SRCB_VRAM_0x10000 = 4,
    GX_CAPTURE_SRCB_VRAM_0x18000 = 6
} GXCaptureSrcB;

typedef enum
{
    GX_CAPTURE_MODE_A  = 0,
    GX_CAPTURE_MODE_B  = 1,
    GX_CAPTURE_MODE_AB = 2
} GXCaptureMode;

// --------------------
// INLINE FUNCTIONS
// --------------------

static inline void GX_SetCapture(GXCaptureSize sz, GXCaptureMode mode, GXCaptureSrcA a, GXCaptureSrcB b, GXCaptureDest dest, int eva, int evb)
{
    reg_GX_DISPCAPCNT =
        (REG_GX_DISPCAPCNT_E_MASK | (mode << REG_GX_DISPCAPCNT_MOD_SHIFT) | (b << REG_GX_DISPCAPCNT_SRCB_SHIFT) | (a << REG_GX_DISPCAPCNT_SRCA_SHIFT)
         | (sz << REG_GX_DISPCAPCNT_WSIZE_SHIFT) | (dest << REG_GX_DISPCAPCNT_DEST_SHIFT) | (evb << REG_GX_DISPCAPCNT_EVB_SHIFT) | (eva << REG_GX_DISPCAPCNT_EVA_SHIFT));
}

static inline void GX_ResetCapture(void)
{
    reg_GX_DISPCAPCNT &= ~REG_GX_DISPCAPCNT_E_MASK;
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_GX_CAPTURE_H