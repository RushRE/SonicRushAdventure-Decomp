#ifndef NITRO_GX_G2_OAM_H
#define NITRO_GX_G2_OAM_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define GX_OAM_ATTR01_Y_SHIFT 0
#define GX_OAM_ATTR01_Y_SIZE  8
#define GX_OAM_ATTR01_Y_MASK  0x000000ff

#define GX_OAM_ATTR01_RSENABLE_SHIFT 8
#define GX_OAM_ATTR01_RSENABLE_SIZE  2
#define GX_OAM_ATTR01_RSENABLE_MASK  0x00000300

#define GX_OAM_ATTR01_MODE_SHIFT 10
#define GX_OAM_ATTR01_MODE_SIZE  2
#define GX_OAM_ATTR01_MODE_MASK  0x00000c00

#define GX_OAM_ATTR01_MOSAIC_SHIFT 12
#define GX_OAM_ATTR01_MOSAIC_SIZE  1
#define GX_OAM_ATTR01_MOSAIC_MASK  0x00001000

#define GX_OAM_ATTR01_CM_SHIFT 13
#define GX_OAM_ATTR01_CM_SIZE  1
#define GX_OAM_ATTR01_CM_MASK  0x00002000

#define GX_OAM_ATTR01_SHAPE_SHIFT 14
#define GX_OAM_ATTR01_SHAPE_SIZE  2
#define GX_OAM_ATTR01_SHAPE_MASK  0x0000c000

#define GX_OAM_ATTR01_X_SHIFT 16
#define GX_OAM_ATTR01_X_SIZE  9
#define GX_OAM_ATTR01_X_MASK  0x01ff0000

#define GX_OAM_ATTR01_RS_SHIFT  25
#define GX_OAM_ATTR01_RS_SIZE   5
#define GX_OAM_ATTR01_RS_MASK   0x3e000000
#define GX_OAM_ATTR01_FLIP_MASK 0x30000000

#define GX_OAM_ATTR01_HF_SHIFT 28
#define GX_OAM_ATTR01_HF_SIZE  1
#define GX_OAM_ATTR01_HF_MASK  0x10000000

#define GX_OAM_ATTR01_VF_SHIFT 29
#define GX_OAM_ATTR01_VF_SIZE  1
#define GX_OAM_ATTR01_VF_MASK  0x20000000

#define GX_OAM_ATTR01_SIZE_SHIFT 30
#define GX_OAM_ATTR01_SIZE_SIZE  2
#define GX_OAM_ATTR01_SIZE_MASK  0xc0000000

#define GX_OAM_ATTR2_NAME_SHIFT 0
#define GX_OAM_ATTR2_NAME_SIZE  10
#define GX_OAM_ATTR2_NAME_MASK  0x03ff

#define GX_OAM_ATTR2_PRIORITY_SHIFT 10
#define GX_OAM_ATTR2_PRIORITY_SIZE  2
#define GX_OAM_ATTR2_PRIORITY_MASK  0x0c00

#define GX_OAM_ATTR2_CPARAM_SHIFT 12
#define GX_OAM_ATTR2_CPARAM_SIZE  4
#define GX_OAM_ATTR2_CPARAM_MASK  0xf000

#define GXOamAttrArray   ((GXOamAttr *)HW_OAM)
#define GXOamAffineArray ((GXOamAffine *)HW_OAM)

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    union
    {
        u32 attr01;
        struct
        {
            u16 attr0;
            u16 attr1;
        };
        struct
        {
            u32 y : 8;
            u32 rsMode : 2;
            u32 objMode : 2;
            u32 mosaic : 1;
            u32 colorMode : 1;
            u32 shape : 2;

            u32 x : 9;
            u32 rsParam : 5;
            u32 size : 2;
        };
        struct
        {
            u32 _0 : 28;
            u32 flipH : 1;
            u32 flipV : 1;
            u32 _1 : 2;
        };
    };
    union
    {
        struct
        {
            u16 attr2;
            u16 _3;
        };
        u32 attr23;
        struct
        {
            u32 charNo : 10;
            u32 priority : 2;
            u32 cParam : 4;
            u32 _2 : 16;
        };
    };
} GXOamAttr;

typedef struct GXOamAffine_
{
    u16 _0;
    u16 _1;
    u16 _2;
    s16 PA;
    u16 _4;
    u16 _5;
    u16 _6;
    s16 PB;
    u16 _8;
    u16 _9;
    u16 _10;
    s16 PC;
    u16 _12;
    u16 _13;
    u16 _14;
    s16 PD;
} GXOamAffine;

// --------------------
// ENUMS
// --------------------

typedef enum
{
    GX_OAM_SHAPE_8x8   = (0 << GX_OAM_ATTR01_SHAPE_SHIFT) | (0 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_16x16 = (0 << GX_OAM_ATTR01_SHAPE_SHIFT) | (1 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_32x32 = (0 << GX_OAM_ATTR01_SHAPE_SHIFT) | (2 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_64x64 = (0 << GX_OAM_ATTR01_SHAPE_SHIFT) | (3 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_16x8  = (1 << GX_OAM_ATTR01_SHAPE_SHIFT) | (0 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_32x8  = (1 << GX_OAM_ATTR01_SHAPE_SHIFT) | (1 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_32x16 = (1 << GX_OAM_ATTR01_SHAPE_SHIFT) | (2 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_64x32 = (1 << GX_OAM_ATTR01_SHAPE_SHIFT) | (3 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_8x16  = (2 << GX_OAM_ATTR01_SHAPE_SHIFT) | (0 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_8x32  = (2 << GX_OAM_ATTR01_SHAPE_SHIFT) | (1 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_16x32 = (2 << GX_OAM_ATTR01_SHAPE_SHIFT) | (2 << GX_OAM_ATTR01_SIZE_SHIFT),
    GX_OAM_SHAPE_32x64 = (2 << GX_OAM_ATTR01_SHAPE_SHIFT) | (3 << GX_OAM_ATTR01_SIZE_SHIFT)
} GXOamShape;

typedef enum
{
    GX_OAM_COLORMODE_16  = 0,
    GX_OAM_COLORMODE_256 = 1
} GXOamColorMode;

typedef enum
{
    GX_OAM_EFFECT_NONE          = (0 << GX_OAM_ATTR01_RSENABLE_SHIFT) | (0 << GX_OAM_ATTR01_HF_SHIFT) | (0 << GX_OAM_ATTR01_VF_SHIFT),
    GX_OAM_EFFECT_FLIP_H        = (0 << GX_OAM_ATTR01_RSENABLE_SHIFT) | (1 << GX_OAM_ATTR01_HF_SHIFT) | (0 << GX_OAM_ATTR01_VF_SHIFT),
    GX_OAM_EFFECT_FLIP_V        = (0 << GX_OAM_ATTR01_RSENABLE_SHIFT) | (0 << GX_OAM_ATTR01_HF_SHIFT) | (1 << GX_OAM_ATTR01_VF_SHIFT),
    GX_OAM_EFFECT_FLIP_HV       = (0 << GX_OAM_ATTR01_RSENABLE_SHIFT) | (1 << GX_OAM_ATTR01_HF_SHIFT) | (1 << GX_OAM_ATTR01_VF_SHIFT),
    GX_OAM_EFFECT_AFFINE        = (1 << GX_OAM_ATTR01_RSENABLE_SHIFT),
    GX_OAM_EFFECT_NODISPLAY     = (2 << GX_OAM_ATTR01_RSENABLE_SHIFT),
    GX_OAM_EFFECT_AFFINE_DOUBLE = (3 << GX_OAM_ATTR01_RSENABLE_SHIFT)
} GXOamEffect;

typedef enum
{
    GX_OAM_MODE_NORMAL    = 0, // no effects mode
    GX_OAM_MODE_XLU       = 1, // transparent mode
    GX_OAM_MODE_OBJWND    = 2, // OBJ window mode
    GX_OAM_MODE_BITMAPOBJ = 3  // bitmap mode
} GXOamMode;

// --------------------
// INLINE FUNCTIONS
// --------------------

SDK_INLINE void G2_SetOBJPosition(GXOamAttr *oam, int x, int y)
{
    oam->attr01 = ((oam->attr01 & ~(GX_OAM_ATTR01_Y_MASK | GX_OAM_ATTR01_X_MASK)) | (y & GX_OAM_ATTR01_Y_MASK)
                   | ((x & (GX_OAM_ATTR01_X_MASK >> GX_OAM_ATTR01_X_SHIFT)) << GX_OAM_ATTR01_X_SHIFT));
}

SDK_INLINE void G2_GetOBJPosition(const GXOamAttr *oam, u32 *x, u32 *y)
{
    *x = (oam->attr01 & GX_OAM_ATTR01_X_MASK) >> GX_OAM_ATTR01_X_SHIFT;
    *y = oam->attr01 & GX_OAM_ATTR01_Y_MASK;
}

SDK_INLINE void G2_SetOBJPriority(GXOamAttr *oam, int priority)
{
    oam->attr2 = (u16)((oam->attr2 & ~GX_OAM_ATTR2_PRIORITY_MASK) | (priority << GX_OAM_ATTR2_PRIORITY_SHIFT));
}

SDK_INLINE int G2_GetOBJPriority(const GXOamAttr *oam)
{
    return (oam->attr2 & GX_OAM_ATTR2_PRIORITY_MASK) >> GX_OAM_ATTR2_PRIORITY_SHIFT;
}

SDK_INLINE void G2_SetOBJMode(GXOamAttr *oam, GXOamMode mode, int cParam)
{
    oam->attr01 = ((oam->attr01 & ~GX_OAM_ATTR01_MODE_MASK) | (mode << GX_OAM_ATTR01_MODE_SHIFT));

    oam->attr2 = (u16)((oam->attr2 & ~GX_OAM_ATTR2_CPARAM_MASK) | (cParam << GX_OAM_ATTR2_CPARAM_SHIFT));
}

SDK_INLINE GXOamMode G2_GetOBJMode(const GXOamAttr *oam)
{
    return (GXOamMode)((oam->attr01 & GX_OAM_ATTR01_MODE_MASK) >> GX_OAM_ATTR01_MODE_SHIFT);
}

SDK_INLINE int G2_GetOBJColorParam(const GXOamAttr *oam)
{
    return (oam->attr2 & GX_OAM_ATTR2_CPARAM_MASK) >> GX_OAM_ATTR2_CPARAM_SHIFT;
}

SDK_INLINE void G2_SetOBJEffect(GXOamAttr *oam, GXOamEffect effect, int rsParam)
{
    if (GX_OAM_EFFECT_AFFINE != effect && GX_OAM_EFFECT_AFFINE_DOUBLE != effect)
    {
        oam->attr01 = ((oam->attr01 & ~(GX_OAM_ATTR01_RSENABLE_MASK | GX_OAM_ATTR01_RS_MASK)) | effect);
    }
    else
    {
        oam->attr01 = ((oam->attr01 & ~(GX_OAM_ATTR01_RSENABLE_MASK | GX_OAM_ATTR01_RS_MASK)) | effect | (rsParam << GX_OAM_ATTR01_RS_SHIFT));
    }
}

SDK_INLINE GXOamEffect G2_GetOBJEffect(const GXOamAttr *oam)
{
    GXOamEffect effect;

    effect = (GXOamEffect)(oam->attr01 & GX_OAM_ATTR01_RSENABLE_MASK);

    if (effect == GX_OAM_EFFECT_AFFINE || effect == GX_OAM_EFFECT_AFFINE_DOUBLE)
    {
        return effect;
    }

    return (GXOamEffect)(effect | (oam->attr01 & GX_OAM_ATTR01_FLIP_MASK));
}

SDK_INLINE void G2_SetOBJShape(GXOamAttr *oam, GXOamShape shape)
{
    oam->attr01 = ((oam->attr01 & ~(GX_OAM_ATTR01_SHAPE_MASK | GX_OAM_ATTR01_SIZE_MASK)) | shape);
}

SDK_INLINE GXOamShape G2_GetOBJShape(const GXOamAttr *oam)
{
    return (GXOamShape)(oam->attr01 & (GX_OAM_ATTR01_SHAPE_MASK | GX_OAM_ATTR01_SIZE_MASK));
}

SDK_INLINE void G2_SetOBJCharName(GXOamAttr *oam, int name)
{
    oam->attr2 = (u16)((oam->attr2 & ~GX_OAM_ATTR2_NAME_MASK) | name);
}

SDK_INLINE int G2_GetOBJCharName(const GXOamAttr *oam)
{
    return oam->attr2 & GX_OAM_ATTR2_NAME_MASK;
}

SDK_INLINE void G2_SetOBJColorMode(GXOamAttr *oam, GXOamColorMode color)
{
    oam->attr01 = ((oam->attr01 & ~GX_OAM_ATTR01_CM_MASK) | (color << GX_OAM_ATTR01_CM_SHIFT));
}

SDK_INLINE GXOamColorMode G2_GetOBJColorMode(const GXOamAttr *oam)
{
    return (GXOamColorMode)((oam->attr01 & GX_OAM_ATTR01_CM_MASK) >> GX_OAM_ATTR01_CM_SHIFT);
}

SDK_INLINE void G2_OBJMosaic(GXOamAttr *oam, BOOL enable)
{
    if (enable)
    {
        oam->attr01 |= (1 << GX_OAM_ATTR01_MOSAIC_SHIFT);
    }
    else
    {
        oam->attr01 &= ~(1 << GX_OAM_ATTR01_MOSAIC_SHIFT);
    }
}

SDK_INLINE void G2_SetOBJAffine(GXOamAffine *oam, const MtxFx22 *mtx)
{
    oam->PA = (s16)(mtx->_00 >> 4);
    oam->PB = (s16)(mtx->_01 >> 4);
    oam->PC = (s16)(mtx->_10 >> 4);
    oam->PD = (s16)(mtx->_11 >> 4);
}

SDK_INLINE void G2_GetOBJAffine(const GXOamAffine *oam, MtxFx22 *mtx)
{

    mtx->_00 = (fx32)(oam->PA << 4);
    mtx->_01 = (fx32)(oam->PB << 4);
    mtx->_10 = (fx32)(oam->PC << 4);
    mtx->_11 = (fx32)(oam->PD << 4);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_GX_G2_OAM_H
