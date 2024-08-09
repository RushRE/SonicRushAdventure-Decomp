#include <nitro.h>

// -------------------
// INTERNAL FUNCTIONS
// -------------------

static inline int getBGScreenOffset_(void)
{
    return (int)(0x10000 * ((reg_GX_DISPCNT & REG_GX_DISPCNT_BGSCREENOFFSET_MASK) >> REG_GX_DISPCNT_BGSCREENOFFSET_SHIFT));
}

static inline int getBGCharOffset_(void)
{
    return (int)(0x10000 * ((reg_GX_DISPCNT & REG_GX_DISPCNT_BGCHAROFFSET_MASK) >> REG_GX_DISPCNT_BGCHAROFFSET_SHIFT));
}

// -------------------
// FUNCTIONS
// -------------------

void *G2_GetBG0ScrPtr(void)
{
    int baseBlock = 0x800 * ((reg_G2_BG0CNT & REG_G2_BG0CNT_SCREENBASE_MASK) >> REG_G2_BG0CNT_SCREENBASE_SHIFT);

    return (void *)(HW_BG_VRAM + getBGScreenOffset_() + baseBlock);
}

void *G2S_GetBG0ScrPtr(void)
{
    int baseBlock = 0x800 * ((reg_G2S_DB_BG0CNT & REG_G2S_DB_BG0CNT_SCREENBASE_MASK) >> REG_G2S_DB_BG0CNT_SCREENBASE_SHIFT);

    return (void *)(HW_DB_BG_VRAM + baseBlock);
}

void *G2_GetBG1ScrPtr(void)
{
    int baseBlock = 0x800 * ((reg_G2_BG1CNT & REG_G2_BG1CNT_SCREENBASE_MASK) >> REG_G2_BG1CNT_SCREENBASE_SHIFT);

    return (void *)(HW_BG_VRAM + getBGScreenOffset_() + baseBlock);
}

void *G2S_GetBG1ScrPtr(void)
{
    int baseBlock = 0x800 * ((reg_G2S_DB_BG1CNT & REG_G2S_DB_BG1CNT_SCREENBASE_MASK) >> REG_G2S_DB_BG1CNT_SCREENBASE_SHIFT);

    return (void *)(HW_DB_BG_VRAM + baseBlock);
}

#include <nitro/code32.h> // ARM binary is even better in size.
void *G2_GetBG2ScrPtr(void)
{
    GXBGMode bgMode = (GXBGMode)((reg_GX_DISPCNT & REG_GX_DISPCNT_BGMODE_MASK) >> REG_GX_DISPCNT_BGMODE_SHIFT);
    u32 bg          = reg_G2_BG2CNT;
    int offset      = getBGScreenOffset_();
    u32 blockID     = (bg & REG_G2_BG2CNT_SCREENBASE_MASK) >> REG_G2_BG2CNT_SCREENBASE_SHIFT;

    switch (bgMode)
    {
        case GX_BGMODE_0:
        case GX_BGMODE_1:
        case GX_BGMODE_2:
        case GX_BGMODE_3:
        case GX_BGMODE_4:
            // Text or SR BG
            return (void *)(HW_BG_VRAM + offset + 0x800 * blockID);
            break;

        case GX_BGMODE_5:
            // Extended SR BG
            if (bg & REG_G2_BG2CNT_COLORMODE_MASK)
            {
                // Bitmap BG
                return (void *)(HW_BG_VRAM + 0x4000 * blockID);
            }
            else
            {
                // Char BG
                return (void *)(HW_BG_VRAM + offset + 0x800 * blockID);
            }
            break;

        case GX_BGMODE_6:
            // 256 colors large bitmap screen
            return (void *)HW_BG_VRAM;
            break;

        default:
            return NULL;
            break;
    }
}

#include <nitro/codereset.h>

void *G2S_GetBG2ScrPtr(void)
{
    GXBGMode bgMode = (GXBGMode)((reg_GXS_DB_DISPCNT & REG_GXS_DB_DISPCNT_BGMODE_MASK) >> REG_GXS_DB_DISPCNT_BGMODE_SHIFT);
    u32 bg          = reg_G2S_DB_BG2CNT;
    u32 blockID     = (bg & REG_G2S_DB_BG2CNT_SCREENBASE_MASK) >> REG_G2S_DB_BG2CNT_SCREENBASE_SHIFT;

    switch (bgMode)
    {
        case GX_BGMODE_0:
        case GX_BGMODE_1:
        case GX_BGMODE_2:
        case GX_BGMODE_3:
        case GX_BGMODE_4:
            // Text or SR BG
            return (void *)(HW_DB_BG_VRAM + 0x800 * blockID);
            break;

        case GX_BGMODE_5:
            // Extended SR BG
            if (bg & REG_G2S_DB_BG2CNT_COLORMODE_MASK)
            {
                // Bitmap BG
                return (void *)(HW_DB_BG_VRAM + 0x4000 * blockID);
            }
            else
            {
                // Char BG
                return (void *)(HW_DB_BG_VRAM + 0x800 * blockID);
            }
            break;

        case GX_BGMODE_6:
            return NULL;
            break;

        default:
            return NULL;
            break;
    }
}

#include <nitro/code32.h> // ARM binary is even better in size.
void *G2_GetBG3ScrPtr(void)
{
    GXBGMode bgMode = (GXBGMode)((reg_GX_DISPCNT & REG_GX_DISPCNT_BGMODE_MASK) >> REG_GX_DISPCNT_BGMODE_SHIFT);
    u32 bg          = reg_G2_BG3CNT;
    int offset      = getBGScreenOffset_();
    u32 blockID     = (bg & REG_G2_BG3CNT_SCREENBASE_MASK) >> REG_G2_BG3CNT_SCREENBASE_SHIFT;

    switch (bgMode)
    {
        case GX_BGMODE_0:
        case GX_BGMODE_1:
        case GX_BGMODE_2:
            // Text or affine BG
            return (void *)(HW_BG_VRAM + offset + 0x800 * blockID);
            break;

        case GX_BGMODE_3:
        case GX_BGMODE_4:
        case GX_BGMODE_5:
            // Extended affine BG
            if (bg & REG_G2_BG3CNT_COLORMODE_MASK)
            {
                // Bitmap BG
                return (void *)(HW_BG_VRAM + 0x4000 * blockID);
            }
            else
            {
                // Char BG
                return (void *)(HW_BG_VRAM + offset + 0x800 * blockID);
            }
            break;

        case GX_BGMODE_6:
            return NULL;
            break;

        default:
            return NULL;
            break;
    }
}

#include <nitro/codereset.h>

void *G2S_GetBG3ScrPtr(void)
{
    GXBGMode bgMode = (GXBGMode)((reg_GXS_DB_DISPCNT & REG_GXS_DB_DISPCNT_BGMODE_MASK) >> REG_GXS_DB_DISPCNT_BGMODE_SHIFT);
    u32 bg          = reg_G2S_DB_BG3CNT;
    u32 blockID     = (bg & REG_G2S_DB_BG3CNT_SCREENBASE_MASK) >> REG_G2S_DB_BG3CNT_SCREENBASE_SHIFT;

    switch (bgMode)
    {
        case GX_BGMODE_0:
        case GX_BGMODE_1:
        case GX_BGMODE_2:
            // Text or affine BG
            return (void *)(HW_DB_BG_VRAM + 0x800 * blockID);
            break;

        case GX_BGMODE_3:
        case GX_BGMODE_4:
        case GX_BGMODE_5:
            // Extended affine BG
            if (bg & REG_G2S_DB_BG3CNT_COLORMODE_MASK)
            {
                // Bitmap BG
                return (void *)(HW_DB_BG_VRAM + 0x4000 * blockID);
            }
            else
            {
                // Char BG
                return (void *)(HW_DB_BG_VRAM + 0x800 * blockID);
            }
            break;

        case GX_BGMODE_6:
            return NULL;
            break;

        default:
            return NULL;
            break;
    }
}

void *G2_GetBG0CharPtr(void)
{
    int baseBlock = 0x4000 * ((reg_G2_BG0CNT & REG_G2_BG0CNT_CHARBASE_MASK) >> REG_G2_BG0CNT_CHARBASE_SHIFT);

    return (void *)(HW_BG_VRAM + getBGCharOffset_() + baseBlock);
}

void *G2S_GetBG0CharPtr(void)
{
    int baseBlock = 0x4000 * ((reg_G2S_DB_BG0CNT & REG_G2S_DB_BG0CNT_CHARBASE_MASK) >> REG_G2S_DB_BG0CNT_CHARBASE_SHIFT);

    return (void *)(HW_DB_BG_VRAM + baseBlock);
}

void *G2_GetBG1CharPtr(void)
{
    int baseBlock = 0x4000 * ((reg_G2_BG1CNT & REG_G2_BG1CNT_CHARBASE_MASK) >> REG_G2_BG1CNT_CHARBASE_SHIFT);

    return (void *)(HW_BG_VRAM + getBGCharOffset_() + baseBlock);
}

void *G2S_GetBG1CharPtr(void)
{
    int baseBlock = 0x4000 * ((reg_G2S_DB_BG1CNT & REG_G2S_DB_BG1CNT_CHARBASE_MASK) >> REG_G2S_DB_BG1CNT_CHARBASE_SHIFT);

    return (void *)(HW_DB_BG_VRAM + baseBlock);
}

void *G2_GetBG2CharPtr(void)
{
    GXBGMode bgMode = (GXBGMode)((reg_GX_DISPCNT & REG_GX_DISPCNT_BGMODE_MASK) >> REG_GX_DISPCNT_BGMODE_SHIFT);
    u32 bg          = reg_G2_BG2CNT;

    if (bgMode < 5 || !(bg & REG_G2_BG2CNT_COLORMODE_MASK))
    {
        // Text BG, affine BG, or extended affine character BG
        int offset  = getBGCharOffset_();
        u32 blockID = (bg & REG_G2_BG2CNT_CHARBASE_MASK) >> REG_G2_BG2CNT_CHARBASE_SHIFT;

        return (void *)(HW_BG_VRAM + offset + 0x4000 * blockID);
    }
    else
    {
        // otherwise
        return NULL;
    }
}

void *G2S_GetBG2CharPtr(void)
{
    GXBGMode bgMode = (GXBGMode)((reg_GXS_DB_DISPCNT & REG_GXS_DB_DISPCNT_BGMODE_MASK) >> REG_GXS_DB_DISPCNT_BGMODE_SHIFT);
    u32 bg          = reg_G2S_DB_BG2CNT;
    if (bgMode < 5 || !(bg & REG_G2S_DB_BG2CNT_COLORMODE_MASK))
    {
        // Text BG, affine BG, or extended affine character BG
        u32 blockID = (bg & REG_G2S_DB_BG2CNT_CHARBASE_MASK) >> REG_G2S_DB_BG2CNT_CHARBASE_SHIFT;

        return (void *)(HW_DB_BG_VRAM + 0x4000 * blockID);
    }
    else
    {
        // otherwise
        return NULL;
    }
}

void *G2_GetBG3CharPtr(void)
{
    GXBGMode bgMode = (GXBGMode)((reg_GX_DISPCNT & REG_GX_DISPCNT_BGMODE_MASK) >> REG_GX_DISPCNT_BGMODE_SHIFT);
    u32 bg          = reg_G2_BG3CNT;
    if (bgMode < 3 || (bgMode < 6 && !(bg & REG_G2_BG2CNT_COLORMODE_MASK)))
    {
        // Text BG, affine BG, or extended affine character BG
        u32 blockID = (bg & REG_G2_BG3CNT_CHARBASE_MASK) >> REG_G2_BG3CNT_CHARBASE_SHIFT;
        int offset  = getBGCharOffset_();

        return (void *)(HW_BG_VRAM + offset + 0x4000 * blockID);
    }
    else
    {
        // otherwise
        return NULL;
    }
}

void *G2S_GetBG3CharPtr(void)
{
    GXBGMode bgMode = (GXBGMode)((reg_GXS_DB_DISPCNT & REG_GXS_DB_DISPCNT_BGMODE_MASK) >> REG_GXS_DB_DISPCNT_BGMODE_SHIFT);
    u32 bg          = reg_G2S_DB_BG3CNT;
    if (bgMode < 3 || (bgMode < 6 && !(bg & REG_G2S_DB_BG2CNT_COLORMODE_MASK)))
    {
        // Text BG, affine BG, or extended affine character BG
        u32 blockID = (bg & REG_G2S_DB_BG3CNT_CHARBASE_MASK) >> REG_G2S_DB_BG3CNT_CHARBASE_SHIFT;

        return (void *)(HW_DB_BG_VRAM + 0x4000 * blockID);
    }
    else
    {
        // otherwise
        return NULL;
    }
}
