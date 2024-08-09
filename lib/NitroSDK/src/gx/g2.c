#include <nitro.h>

// --------------------
// ENUMS
// --------------------

typedef enum
{
    G2_BLENDTYPE_NONE    = 0x0000,
    G2_BLENDTYPE_ALPHA   = 0x0040,
    G2_BLENDTYPE_FADEIN  = 0x0080,
    G2_BLENDTYPE_FADEOUT = 0x00c0
} G2_BLENDTYPE;

// --------------------
// FUNCTIONS
// --------------------

#include <nitro/code32.h>
void G2x_SetBGyAffine_(u32 addr, const MtxFx22 *mtx, int centerX, int centerY, int x1, int y1)
{
    s32 dx, dy;
    fx32 x2, y2;

    // BGxPA, BGxPB are in s7.8 format
    *((vu32 *)addr + 0) = (u32)((u16)(s16)(mtx->_00 >> 4) | (u16)(s16)(mtx->_01 >> 4) << 16);

    // BGxPC, BGxPC are in s7.8 format
    *((vu32 *)addr + 1) = (u32)((u16)(s16)(mtx->_10 >> 4) | (u16)(s16)(mtx->_11 >> 4) << 16);

    dx = x1 - centerX;
    dy = y1 - centerY;

    // mtx * d + center
    x2 = mtx->_00 * dx + mtx->_01 * dy + (centerX << FX32_SHIFT);
    y2 = mtx->_10 * dx + mtx->_11 * dy + (centerY << FX32_SHIFT);

    // reg_G2m_BGnXY has s19.8 format
    *((vu32 *)addr + 2) = (u32)(x2 >> 4);
    *((vu32 *)addr + 3) = (u32)(y2 >> 4);
}

#include <nitro/codereset.h>

void G2x_SetBlendBrightness_(u32 addr, int plane, int brightness)
{
    if (brightness < 0)
    {
        // BLDCNT
        *((vu16 *)addr + 0) = (u16)(G2_BLENDTYPE_FADEOUT | plane);
        // BLDY
        *((vu16 *)addr + 2) = (u16)-brightness;
    }
    else
    {
        // BLDCNT
        *((vu16 *)addr + 0) = (u16)(G2_BLENDTYPE_FADEIN | plane);
        // BLDY
        *((vu16 *)addr + 2) = (u16)brightness;
    }
}

void G2x_SetBlendBrightnessExt_(u32 addr, int plane1, int plane2, int ev1, int ev2, int brightness)
{
    // BLDALPHA
    *((vu16 *)addr + 1) = (u16)(ev1 | (ev2 << 8));

    if (brightness < 0)
    {
        // BLDCNT
        *((vu16 *)addr + 0) = (u16)(G2_BLENDTYPE_FADEOUT | plane1 | (plane2 << 8));

        // BLDY
        *((vu16 *)addr + 2) = (u16)-brightness;
    }
    else
    {
        // BLDCNT
        *((vu16 *)addr + 0) = (u16)(G2_BLENDTYPE_FADEIN | plane1 | (plane2 << 8));

        // BLDY
        *((vu16 *)addr + 2) = (u16)brightness;
    }
}

void G2x_ChangeBlendBrightness_(u32 addr, int brightness)
{
    u16 tmp;

    // read BLDCNT
    tmp = *((vu16 *)addr + 0);

    if (brightness < 0)
    {
        if (G2_BLENDTYPE_FADEIN == (tmp & REG_G2_BLDCNT_EFFECT_MASK))
        {
            // BLDCNT
            *((vu16 *)addr + 0) = (u16)((tmp & ~REG_G2_BLDCNT_EFFECT_MASK) | G2_BLENDTYPE_FADEOUT);
        }
        // BLDY
        *((vu16 *)addr + 2) = (u16)-brightness;
    }
    else
    {
        if (G2_BLENDTYPE_FADEOUT == (tmp & REG_G2_BLDCNT_EFFECT_MASK))
        {
            // BLDCNT
            *((vu16 *)addr + 0) = (u16)((tmp & ~REG_G2_BLDCNT_EFFECT_MASK) | G2_BLENDTYPE_FADEIN);
        }
        // BLDY
        *((vu16 *)addr + 2) = (u16)brightness;
    }
}