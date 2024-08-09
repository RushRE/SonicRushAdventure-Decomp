#ifndef NITRO_GX_GXCOMMON_H
#define NITRO_GX_GXCOMMON_H

#ifdef __cplusplus
extern "C" {
#endif

#ifndef SDK_ASM
typedef u16 GXRgb;
typedef u16 GXRgba;
#endif

// --------------------
// TYPES & MACROS
// --------------------
typedef u32 VecFx10;

#define GX_FX10_SHIFT    9
#define GX_FX10_INT_SIZE 0
#define GX_FX10_DEC_SIZE 9

#define GX_FX10_INT_MASK  0x0000
#define GX_FX10_DEC_MASK  0x01ff
#define GX_FX10_SIGN_MASK 0x0200
#define GX_FX10_MASK      (GX_FX10_INT_MASK | GX_FX10_DEC_MASK | GX_FX10_SIGN_MASK)

#define GX_FX16_FX10_MAX (fx16)(0x0fff)
#define GX_FX16_FX10_MIN (fx16)(0xf000)

#define GX_FX32_FX10_MAX (fx32)(0x00000fff)
#define GX_FX32_FX10_MIN (fx32)(0xfffff000)

#define GX_VEC_FX10_X_SHIFT 0
#define GX_VEC_FX10_Y_SHIFT 10
#define GX_VEC_FX10_Z_SHIFT 20

// --------------------
// MACROS
// --------------------

#define GX_RGB_R_SHIFT (0)
#define GX_RGB_R_MASK  (0x001f)
#define GX_RGB_G_SHIFT (5)
#define GX_RGB_G_MASK  (0x03e0)
#define GX_RGB_B_SHIFT (10)
#define GX_RGB_B_MASK  (0x7c00)
#define GX_RGB_A_SHIFT (15)
#define GX_RGB_A_MASK  (0x8000)

#ifdef SDK_ASM
#define GX_RGB(r, g, b)  ((((r) << GX_RGB_R_SHIFT) | ((g) << GX_RGB_G_SHIFT) | ((b) << GX_RGB_B_SHIFT)))
#define GX_RGBA(r, g, b) ((((r) << GX_RGB_R_SHIFT) | ((g) << GX_RGB_G_SHIFT) | ((b) << GX_RGB_B_SHIFT) | ((a) << GX_RGB_A_SHIFT)))
#else
#define GX_RGB(r, g, b)     ((GXRgb)(((r) << GX_RGB_R_SHIFT) | ((g) << GX_RGB_G_SHIFT) | ((b) << GX_RGB_B_SHIFT)))
#define GX_RGBA(r, g, b, a) ((GXRgba)(((r) << GX_RGB_R_SHIFT) | ((g) << GX_RGB_G_SHIFT) | ((b) << GX_RGB_B_SHIFT) | ((a) << GX_RGB_A_SHIFT)))
#endif

#define GX_VECFX10(x, y, z)                                                                                                                                                                            \
    ((VecFx10)(((((x) >> (FX32_DEC_SIZE - GX_FX10_DEC_SIZE)) & GX_FX10_MASK) << GX_VEC_FX10_X_SHIFT) | ((((y) >> (FX32_DEC_SIZE - GX_FX10_DEC_SIZE)) & GX_FX10_MASK) << GX_VEC_FX10_Y_SHIFT)           \
               | ((((z) >> (FX32_DEC_SIZE - GX_FX10_DEC_SIZE)) & GX_FX10_MASK) << GX_VEC_FX10_Z_SHIFT)))

// --------------------
// CONSTANTS
// --------------------

#define GX_DEFAULT_DMAID (3)
#define GX_DMA_NOT_USE   ((u32)~0)

// --------------------
// VARIABLES
// --------------------

extern u32 GXi_DmaId;

#ifdef __cplusplus
}
#endif

#endif // NITRO_GX_GXCOMMON_H
