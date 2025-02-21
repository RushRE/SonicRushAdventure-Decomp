#include <game/graphics/drawReqTask.h>
#include <game/graphics/vramSystem.h>
#include <game/graphics/oamSystem.h>
#include <game/graphics/pixelsQueue.h>
#include <game/graphics/mappingsQueue.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/background.h>

// --------------------
// STRUCTS
// --------------------

struct DrawReqTask__StaticVars
{
    Task *drawReqTask;
    Task *cam3DTask;
    u32 field_8;
    u32 field_C;
};

// --------------------
// VARIABLES
// --------------------

static struct DrawReqTask__StaticVars DrawReqTask__sVars;

// --------------------
// FUNCTIONS
// --------------------

// DrawReqTask
void InitDrawReqSystem(void)
{
    DrawReqTask__sVars.drawReqTask = NULL;
    DrawReqTask__sVars.cam3DTask   = NULL;
}

void GetVRAMPaletteConfig(BOOL useEngineB, u8 bgID, PaletteMode *paletteMode, void **palettePtr)
{
    u32 displayControl = *(u32 *)VRAMSystem__DisplayControllers[useEngineB];
    u32 mode           = 0;

    switch (displayControl & REG_GX_DISPCNT_BGMODE_MASK)
    {
        case GX_BGMODE_0:
            mode = 0;
            break;

        case GX_BGMODE_1:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                case BACKGROUND_2:
                    mode = 0;
                    break;

                case BACKGROUND_3:
                    mode = 2;
                    break;
            }
            break;

        case GX_BGMODE_2:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    mode = 0;
                    break;

                case BACKGROUND_2:
                case BACKGROUND_3:
                    mode = 2;
                    break;
            }
            break;

        case GX_BGMODE_3:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                case BACKGROUND_2:
                    mode = 0;
                    break;

                case BACKGROUND_3:
                    mode = 1;
                    break;
            }
            break;

        case GX_BGMODE_4:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    mode = 0;
                    break;

                case BACKGROUND_2:
                    mode = 2;
                    break;

                case BACKGROUND_3:
                    mode = 1;
                    break;
            }
            break;

        case GX_BGMODE_5:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    mode = 0;
                    break;

                case BACKGROUND_2:
                case BACKGROUND_3:
                    mode = 1;
                    break;
            }
            break;
    }

    BOOL use256Colors = FALSE;
    u32 bgControl     = *(u16 *)VRAMSystem__BGControllers[useEngineB][bgID];

    switch (mode)
    {
        case 0:
            if ((bgControl & REG_G2_BG0CNT_COLORMODE_MASK) != 0 && (displayControl & REG_GX_DISPCNT_BG_MASK) != 0)
            {
                use256Colors = TRUE;
            }
            break;

        case 1:
            if ((displayControl & REG_GX_DISPCNT_BG_MASK) != 0 && (bgControl & REG_G2_BG0CNT_COLORMODE_MASK) == 0)
            {
                use256Colors = TRUE;
            }
            break;
    }

    if (use256Colors)
    {
        if (useEngineB == GRAPHICS_ENGINE_A)
            mode = PALETTE_MODE_BG;
        else
            mode = PALETTE_MODE_SUB_BG;

        *paletteMode = mode;
        *palettePtr  = NULL;
        if (bgID == BACKGROUND_0)
        {
            bgControl = *(u16 *)VRAMSystem__BGControllers[useEngineB][BACKGROUND_0];
            *palettePtr += (bgControl & REG_G2_BG0CNT_BGPLTTSLOT_MASK) != 0 ? 0x4000 : 0x0000;
        }
        else if (bgID == BACKGROUND_1)
        {
            bgControl = *(u16 *)VRAMSystem__BGControllers[useEngineB][BACKGROUND_1];
            *palettePtr += (bgControl & REG_G2_BG1CNT_BGPLTTSLOT_MASK) != 0 ? 0x6000 : 0x2000;
        }
        else
        {
            *palettePtr += bgID << 13;
        }
    }
    else
    {
        void *vramPalette = VRAMKEY_TO_ADDR(VRAMSystem__VRAM_PALETTE_BG[useEngineB]);

        *paletteMode = PALETTE_MODE_SPRITE;
        *palettePtr  = vramPalette;
    }
}

void GetVRAMCharacterConfig(BOOL useEngineB, u8 bgID, u16 *characterBaseA, u16 *characterBaseBlock)
{
    *characterBaseA = 0;
    if (!useEngineB)
        *characterBaseA = GX_GetBGCharOffset();

    *characterBaseBlock = (*(u16 *)VRAMSystem__BGControllers[useEngineB][bgID] & REG_G2_BG0CNT_CHARBASE_MASK) >> REG_G2_BG0CNT_CHARBASE_SHIFT;
}

void GetVRAMTileConfig(BOOL useEngineB, u8 bgID, s32 *mappingsMode, u16 *screenBaseA, u16 *screenBaseBlock)
{
    u16 bgControl = *(u16 *)VRAMSystem__BGControllers[useEngineB][bgID];

    *screenBaseA = GX_BGSCROFFSET_0x00000;
    if (!useEngineB)
        *screenBaseA = (reg_GX_DISPCNT & REG_GX_DISPCNT_BGSCREENOFFSET_MASK) >> REG_GX_DISPCNT_BGSCREENOFFSET_SHIFT; // GX_GetBGScrOffset

    *screenBaseBlock = (bgControl & REG_G2_BG0CNT_SCREENBASE_MASK) >> REG_G2_BG0CNT_SCREENBASE_SHIFT; // G2_GetBG0ScrPtr

    switch (*((u32 *)(size_t)VRAMSystem__DisplayControllers[useEngineB]) & REG_GX_DISPCNT_BGMODE_MASK)
    {
        case GX_BGMODE_0:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                case BACKGROUND_2:
                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;
            }
            break;

        case GX_BGMODE_1:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                case BACKGROUND_2:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;

                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_AFFINE_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_128x128_A : MAPPINGS_MODE_AFFINE_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_256x256_A : MAPPINGS_MODE_AFFINE_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_512x512_A : MAPPINGS_MODE_AFFINE_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_1024x1024_A : MAPPINGS_MODE_AFFINE_1024x1024_B;
                            break;
                    }
                    break;
            }
            break;

        case GX_BGMODE_2:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;

                case BACKGROUND_2:
                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_AFFINE_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_128x128_A : MAPPINGS_MODE_AFFINE_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_256x256_A : MAPPINGS_MODE_AFFINE_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_512x512_A : MAPPINGS_MODE_AFFINE_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_1024x1024_A : MAPPINGS_MODE_AFFINE_1024x1024_B;
                            break;
                    }
                    break;
            }
            break;

        case GX_BGMODE_3:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                case BACKGROUND_2:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;

                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_256x16PLTT_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_128x128_A : MAPPINGS_MODE_256x16PLTT_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_256x256_A : MAPPINGS_MODE_256x16PLTT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_512x512_A : MAPPINGS_MODE_256x16PLTT_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_1024x1024_A : MAPPINGS_MODE_256x16PLTT_1024x1024_B;
                            break;
                    }
                    break;
            }
            break;

        case GX_BGMODE_4:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;

                case BACKGROUND_2:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_AFFINE_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_128x128_A : MAPPINGS_MODE_AFFINE_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_256x256_A : MAPPINGS_MODE_AFFINE_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_512x512_A : MAPPINGS_MODE_AFFINE_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_AFFINE_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_AFFINE_1024x1024_A : MAPPINGS_MODE_AFFINE_1024x1024_B;
                            break;
                    }
                    break;

                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_256x16PLTT_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_128x128_A : MAPPINGS_MODE_256x16PLTT_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_256x256_A : MAPPINGS_MODE_256x16PLTT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_512x512_A : MAPPINGS_MODE_256x16PLTT_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_1024x1024_A : MAPPINGS_MODE_256x16PLTT_1024x1024_B;
                            break;
                    }
                    break;
            }
            break;

        case GX_BGMODE_5:
            switch (bgID)
            {
                case BACKGROUND_0:
                case BACKGROUND_1:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_TEXT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x256_A : MAPPINGS_MODE_TEXT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x256_A : MAPPINGS_MODE_TEXT_512x256_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_256x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_256x512_A : MAPPINGS_MODE_TEXT_256x512_B;
                            break;

                        case GX_BG_SCRSIZE_TEXT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_TEXT_512x512_A : MAPPINGS_MODE_TEXT_512x512_B;
                            break;
                    }
                    break;

                case BACKGROUND_2:
                case BACKGROUND_3:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_256x16PLTT_128x128:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_128x128_A : MAPPINGS_MODE_256x16PLTT_128x128_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_256x256:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_256x256_A : MAPPINGS_MODE_256x16PLTT_256x256_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_512x512:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_512x512_A : MAPPINGS_MODE_256x16PLTT_512x512_B;
                            break;

                        case GX_BG_SCRSIZE_256x16PLTT_1024x1024:
                            *mappingsMode = useEngineB == GRAPHICS_ENGINE_A ? MAPPINGS_MODE_256x16PLTT_1024x1024_A : MAPPINGS_MODE_256x16PLTT_1024x1024_B;
                            break;
                    }
                    break;
            }
            break;
    }
}

void GetVRAMPixelConfig(BOOL useEngineB, u8 bgID, PixelMode *pixelMode, u16 *screenBaseBlock)
{
#define bg3_256ColorChar04000 ((GX_BG_COLORMODE_256 << REG_G2_BG3CNT_COLORMODE_SHIFT) | (GX_BG_CHARBASE_0x04000 << REG_G2_BG3CNT_CHARBASE_SHIFT))

    s32 bgControl = *(u16 *)VRAMSystem__BGControllers[useEngineB][bgID];
    u32 *disp     = (u32 *)VRAMSystem__DisplayControllers[useEngineB];

    *screenBaseBlock = (bgControl & REG_G2_BG0CNT_SCREENBASE_MASK) >> REG_G2_BG0CNT_SCREENBASE_SHIFT; // G2_GetBG0ScrPtr

    switch (*disp & REG_GX_DISPCNT_BGMODE_MASK)
    {
        case GX_BGMODE_3:
        case GX_BGMODE_4:
            switch (bgID)
            {
                case BACKGROUND_3:
                    if ((bgControl & bg3_256ColorChar04000) == bg3_256ColorChar04000)
                    {
                        switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                        {
                            case GX_BG_SCRSIZE_AFFINE_128x128:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_128x128;
                                break;

                            case GX_BG_SCRSIZE_AFFINE_256x256:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_256x256;
                                break;

                            case GX_BG_SCRSIZE_AFFINE_512x512:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_512x256;
                                break;

                            case GX_BG_SCRSIZE_AFFINE_1024x1024:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_512x512;
                                break;

                            default:
                                break;
                        }
                    }
                    else
                    {
                        switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                        {
                            case GX_BG_SCRSIZE_TEXT_256x256:
                                *pixelMode = PIXEL_MODE_BG_TEXT_256x256;
                                break;

                            case GX_BG_SCRSIZE_TEXT_512x256:
                                *pixelMode = PIXEL_MODE_BG_TEXT_512x256;
                                break;

                            case GX_BG_SCRSIZE_TEXT_256x512:
                                *pixelMode = PIXEL_MODE_BG_TEXT_256x512;
                                break;

                            case GX_BG_SCRSIZE_TEXT_512x512:
                                *pixelMode = PIXEL_MODE_BG_TEXT_512x512;
                                break;

                            default:
                                break;
                        }
                    }
                    break;
            }
            break;

        case GX_BGMODE_5:
            switch (bgID)
            {
                case BACKGROUND_2:
                case BACKGROUND_3:
                    if ((bgControl & bg3_256ColorChar04000) == bg3_256ColorChar04000)
                    {
                        switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                        {
                            case GX_BG_SCRSIZE_DCBMP_128x128:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_128x128;
                                break;

                            case GX_BG_SCRSIZE_DCBMP_256x256:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_256x256;
                                break;

                            case GX_BG_SCRSIZE_DCBMP_512x256:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_512x256;
                                break;

                            case GX_BG_SCRSIZE_DCBMP_512x512:
                                *pixelMode = PIXEL_MODE_BG_DCBMP_512x512;
                                break;
                        }
                    }
                    else
                    {
                        switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                        {
                            case GX_BG_SCRSIZE_TEXT_256x256:
                                *pixelMode = PIXEL_MODE_BG_TEXT_256x256;
                                break;

                            case GX_BG_SCRSIZE_TEXT_512x256:
                                *pixelMode = PIXEL_MODE_BG_TEXT_512x256;
                                break;

                            case GX_BG_SCRSIZE_TEXT_256x512:
                                *pixelMode = PIXEL_MODE_BG_TEXT_256x512;
                                break;

                            case GX_BG_SCRSIZE_TEXT_512x512:
                                *pixelMode = PIXEL_MODE_BG_TEXT_512x512;
                                break;
                        }
                    }
                    break;
            }
            break;

        case GX_BGMODE_6:
            switch (bgID)
            {
                case BACKGROUND_2:
                    switch ((bgControl & REG_G2_BG0CNT_SCREENSIZE_MASK) >> REG_G2_BG0CNT_SCREENSIZE_SHIFT)
                    {
                        case GX_BG_SCRSIZE_LARGEBMP_512x1024:
                            *pixelMode = PIXEL_MODE_BG_LARGEBMP_512x1024;
                            break;

                        case GX_BG_SCRSIZE_LARGEBMP_1024x512:
                            *pixelMode = PIXEL_MODE_BG_LARGEBMP_1024x512;
                            break;
                    }
                    break;
            }
            break;
    }

#undef bg3_256ColorChar04000
}

void DrawReqTask__Create(u8 pausePriority, BOOL canDrawA, BOOL canDrawB, BOOL createPauseDrawControl)
{
    Task *task                     = TaskCreate(DrawReqTask__Main, NULL, TASK_FLAG_DISABLE_DESTROY | TASK_FLAG_INACTIVE, 0, TASK_PRIORITY_UPDATE_LIST_END - 0, 254, DrawReqTask);
    DrawReqTask__sVars.drawReqTask = task;

    DrawReqTask *work = TaskGetWork(task, DrawReqTask);
    TaskInitWork16(work);

    work->screenCanDraw[0] = canDrawA;
    work->screenCanDraw[1] = canDrawB;
    StartTaskPause(pausePriority);

    if (Camera3D__GetTask() == NULL)
    {
        if (createPauseDrawControl)
            SysPauseDrawControl__Create(TRUE);
    }
}

void DrawReqTask__Enable(void)
{
    DrawReqTask *work = TaskGetWork(DrawReqTask__sVars.drawReqTask, DrawReqTask);
    work->enabled     = TRUE;

    if (Camera3D__GetTask() == NULL)
        SysPauseDrawControl__Create(FALSE);

    EndTaskPause();
}

BOOL DrawReqTask__GetEnabled(void)
{
    if (DrawReqTask__sVars.drawReqTask == NULL)
        return FALSE;

    DrawReqTask *work = TaskGetWork(DrawReqTask__sVars.drawReqTask, DrawReqTask);
    return work->field_4;
}

// Camera3D
NONMATCH_FUNC void Camera3D__Create(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {lr}
	sub sp, sp, #0xc
	ldr r0, =DrawReqTask__sVars
	mov r2, #1
	mov r1, #0
	str r2, [r0, #8]
	str r1, [r0, #0xc]
	rsb r0, r2, #0xf000
	str r0, [sp]
	mov r2, #0xfe
	str r2, [sp, #4]
	mov ip, #0x8c0
	ldr r0, =Camera3D__Main
	mov r3, r1
	mov r2, #3
	str ip, [sp, #8]
	bl TaskCreate_
	ldr r1, =DrawReqTask__sVars
	str r0, [r1, #4]
	bl GetTaskWork_
	mov r1, r0
	mov r0, #0
	mov r2, #0x8c0
	bl MIi_CpuClear16
	mov r0, #1
	bl RenderCore_DisableSwapBuffers
	mov r0, #1
	bl RenderCore_DisableOAMReset
	ldr r0, =Camera3D__VBlankCallback
	bl RenderCore_SetVBlankCallback
	ldr r0, =renderCoreGFXControlB+0x00000028
	bl MTX_Identity22_
	ldr r0, =renderCoreGFXControlB
	mov r1, #0
	strh r1, [r0, #0x3a]
	strh r1, [r0, #0x38]
	strh r1, [r0, #0x3e]
	strh r1, [r0, #0x3c]
	bl Camera3D__ProcessOAMList
	add sp, sp, #0xc
	ldmia sp!, {pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Camera3D__Destroy(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =DrawReqTask__sVars
	ldr r0, [r0, #4]
	cmp r0, #0
	ldmeqia sp!, {r3, pc}
	mov r0, #0
	bl RenderCore_SetVBlankCallback
	ldr r0, =DrawReqTask__sVars
	ldr r2, [r0, #4]
	ldrh r1, [r2, #0x16]
	bic r1, r1, #2
	strh r1, [r2, #0x16]
	ldr r0, [r0, #4]
	bl DestroyTask
	ldr r1, =DrawReqTask__sVars
	mov r0, #0
	str r0, [r1, #4]
	bl RenderCore_DisableSwapBuffers
	mov r0, #0
	bl RenderCore_DisableOAMReset
	mov r0, #1
	bl OAMSystem__GetList2
	mov r1, r0
	mov r0, #0x200
	mov r2, #0x400
	bl MIi_CpuClear16
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

Task *Camera3D__GetTask(void)
{
    return DrawReqTask__sVars.cam3DTask;
}

BOOL Camera3D__UseEngineA(void)
{
    return DrawReqTask__sVars.field_8;
}

Camera3DTask *Camera3D__GetWork(void)
{
    return TaskGetWork(DrawReqTask__sVars.cam3DTask, Camera3DTask);
}

NONMATCH_FUNC void Camera3D__LoadState(Camera3D *camera)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	sub sp, sp, #0x50
	mov r4, r0
	add r5, r4, #0x20
	ldr r3, =NNS_G3dGlb+0x00000240
	ldmia r5, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add lr, r4, #0x38
	ldr r3, =NNS_G3dGlb+0x0000024C
	ldmia lr, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	add ip, r4, #0x2c
	ldr r3, =NNS_G3dGlb+0x00000258
	ldmia ip, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r2, ip
	ldr ip, =NNS_G3dGlb+0x0000004C
	mov r0, r5
	mov r1, lr
	mov r3, #0
	str ip, [sp]
	bl G3i_LookAt_
	ldr r1, =NNS_G3dGlb
	ldr r0, =NNS_G3dGlb+0x0000004C
	ldr r2, [r1, #0xfc]
	mov r3, #0
	bic r2, r2, #0xe8
	str r2, [r1, #0xfc]
	ldr ip, [r0, #0x24]
	ldr r1, [r4, #0x44]
	ldr r2, [r0, #0x28]
	add r1, ip, r1
	str r1, [r0, #0x24]
	ldr r1, [r4, #0x48]
	ldr ip, [r0, #0x2c]
	add r1, r2, r1
	str r1, [r0, #0x28]
	ldr r2, [r4, #0x4c]
	ldr r1, =NNS_G3dGlb+0x00000008
	add r2, ip, r2
	str r2, [r0, #0x2c]
	ldrh ip, [r4]
	ldr r0, [r4, #8]
	ldr r2, =FX_SinCosTable_
	str r0, [sp]
	mov r0, ip, asr #4
	ldr ip, [r4, #0x10]
	mov lr, r0, lsl #1
	str ip, [sp, #4]
	str r3, [sp, #8]
	str r1, [sp, #0xc]
	add r1, lr, #1
	mov r0, lr, lsl #1
	mov r1, r1, lsl #1
	ldrsh r0, [r2, r0]
	ldrsh r1, [r2, r1]
	ldr r2, [r4, #0xc]
	ldr r3, [r4, #4]
	bl G3i_PerspectiveW_
	ldr r1, =NNS_G3dGlb
	ldr r5, =NNS_G3dGlb+0x00000008
	ldr r2, [r1, #0xfc]
	add r0, sp, #0x10
	bic r2, r2, #0x50
	str r2, [r1, #0xfc]
	bl MTX_Identity44_
	add r0, r4, #0x14
	add r3, sp, #0x40
	ldmia r0, {r0, r1, r2}
	stmia r3, {r0, r1, r2}
	mov r0, r5
	mov r2, r5
	add r1, sp, #0x10
	bl MTX_Concat44
	add sp, sp, #0x50
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Camera3D__SetLight(GXLightId lightID, DirLight *light)
{
#ifdef NON_MATCHING
    NNS_G3dGlbLightVector(lightID, MTM_MATH_CLIP(light->dir.x, -0xFFF, 0xFFF), MTM_MATH_CLIP(light->dir.y, -0xFFF, 0xFFF), MTM_MATH_CLIP(light->dir.z, -0xFFF, 0xFFF));
    NNS_G3dGlbLightColor(lightID, light->color);
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	mov r4, r1
	ldrsh r3, [r4, #4]
	mov r1, #0x1000
	rsb r1, r1, #0
	cmp r3, r1
	mov r5, r0
	movlt r3, r1
	blt _0207F600
	cmp r3, r1, lsr #20
	movgt r3, r1, lsr #0x14
_0207F600:
	ldrsh r2, [r4, #2]
	mov r0, #0x1000
	rsb r0, r0, #0
	cmp r2, r0
	movlt r2, r0
	blt _0207F620
	cmp r2, r0, lsr #20
	movgt r2, r0, lsr #0x14
_0207F620:
	ldrsh r1, [r4, #0]
	mov r0, #0x1000
	rsb r0, r0, #0
	cmp r1, r0
	movlt r1, r0
	blt _0207F640
	cmp r1, r0, lsr #20
	movgt r1, r0, lsr #0x14
_0207F640:
	mov r1, r1, lsl #0x10
	mov r2, r2, lsl #0x10
	mov r3, r3, lsl #0x10
	mov r0, r5
	mov r1, r1, asr #0x10
	mov r2, r2, asr #0x10
	mov r3, r3, asr #0x10
	bl NNS_G3dGlbLightVector
	ldrh r1, [r4, #6]
	mov r0, r5
	bl NNS_G3dGlbLightColor
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

void Camera3D__SetMatrixMode(void)
{
    // clang-format off
static const u32 sz = (sizeof(NNS_G3dGlb.cmd1) +
                           sizeof(NNS_G3dGlb.lightVec[0]) * 4 +
                           sizeof(NNS_G3dGlb.cmd2) +
                           sizeof(NNS_G3dGlb.prmMatColor0) +
                           sizeof(NNS_G3dGlb.prmMatColor1) +
                           sizeof(NNS_G3dGlb.prmPolygonAttr) +
                           sizeof(NNS_G3dGlb.prmViewPort) +
                           sizeof(NNS_G3dGlb.cmd3) +
                           sizeof(NNS_G3dGlb.lightColor[0]) * 4) / 4;
    // clang-format on

	// TODO: is this an inlined function call?
	// it seems too "raw" too be game logic?
	// the closest function so far is "NNS_G3dGlbFlushWVP"
	
    NNS_G3dGeBufferData_N((u32 *)&NNS_G3dGlb.cmd1, sz);
    NNS_G3dGeBufferOP_N(G3OP_TEXIMAGE_PARAM, &NNS_G3dGlb.prmTexImageParam, 1);
    NNS_G3dGeMtxMode(GX_MTXMODE_POSITION_VECTOR);
}

NONMATCH_FUNC void Camera3D__FlushP(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =NNS_G3dGlb
	mov r2, #0x1e
	ldr r0, [r1], #4
	bl NNS_G3dGeBufferOP_N
	ldr r0, =0x00001B19
	ldr r1, =NNS_G3dGlb+0x000000BC
	mov r2, #0xf
	bl NNS_G3dGeBufferOP_N
	ldr r0, =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	bic r1, r1, #1
	bic r1, r1, #2
	str r1, [r0, #0xfc]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Camera3D__FlushVP(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =0x00001610
	ldr r1, =NNS_G3dGlb+0x00000004
	mov r2, #0x11
	bl NNS_G3dGeBufferOP_N
	ldr r1, =NNS_G3dGlb+0x0000004C
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	mov r3, #2
	add r1, sp, #0
	mov r0, #0x10
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	ldr r0, =0x00001B17
	ldr r1, =NNS_G3dGlb+0x000000BC
	mov r2, #0xf
	bl NNS_G3dGeBufferOP_N
	ldr r0, =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	bic r1, r1, #1
	orr r1, r1, #2
	str r1, [r0, #0xfc]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Camera3D__FlushWVP(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =0x00001610
	ldr r1, =NNS_G3dGlb+0x00000004
	mov r2, #0x11
	bl NNS_G3dGeBufferOP_N
	ldr r1, =NNS_G3dGlb+0x0000004C
	mov r0, #0x19
	mov r2, #0xc
	bl NNS_G3dGeBufferOP_N
	ldr r0, =0x00001B19
	ldr r1, =NNS_G3dGlb+0x000000BC
	mov r2, #0xf
	bl NNS_G3dGeBufferOP_N
	mov r3, #2
	add r1, sp, #0
	mov r0, #0x10
	mov r2, #1
	str r3, [sp]
	bl NNS_G3dGeBufferOP_N
	mov r1, #0
	mov r2, r1
	mov r0, #0x15
	bl NNS_G3dGeBufferOP_N
	ldr r0, =NNS_G3dGlb
	ldr r1, [r0, #0xfc]
	orr r1, r1, #1
	bic r1, r1, #2
	str r1, [r0, #0xfc]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

void Camera3D__CopyMatrix4x3(const MtxFx43 *src, MtxFx43 *dst)
{
    dst->m[0][0] = src->m[0][0];
    dst->m[0][1] = src->m[1][0];
    dst->m[0][2] = src->m[2][0];
    dst->m[1][0] = src->m[0][1];
    dst->m[1][1] = src->m[1][1];
    dst->m[1][2] = src->m[2][1];
    dst->m[2][0] = src->m[0][2];
    dst->m[2][1] = src->m[1][2];
    dst->m[2][2] = src->m[2][2];
}

void Camera3D__CopyMatrix3x3(const MtxFx33 *src, MtxFx33 *dst)
{
    dst->m[0][0] = src->m[0][0];
    dst->m[0][1] = src->m[1][0];
    dst->m[0][2] = src->m[2][0];
    dst->m[1][0] = FLOAT_TO_FX32(0.0);
    dst->m[1][1] = FLOAT_TO_FX32(1.0);
    dst->m[1][2] = FLOAT_TO_FX32(0.0);
    dst->m[2][0] = src->m[0][2];
    dst->m[2][1] = src->m[1][2];
    dst->m[2][2] = src->m[2][2];
}

// Asset3DSetup
u32 Asset3DSetup__GetTexSize(void *resource)
{
    NNSG3dResTex *tex = NNS_G3dGetTex(resource);
    if (tex != NULL)
        return (void *)tex + tex->texInfo.ofsTex - resource;

    return ((NNSG3dResFileHeader *)resource)->fileSize;
}

void Asset3DSetup__GetTexture(void *resource, void *dest)
{
    u32 size = Asset3DSetup__GetTexSize(resource);
    MI_CpuCopy32(resource, dest, size);
    DC_StoreRange(dest, size);
}

void Asset3DSetup__Create(void *resource)
{
    Task *task = TaskCreate(Asset3DSetup__Main, NULL, TASK_FLAG_NONE, 0, TASK_PRIORITY_RENDER_LIST_START + 0x0001, 254, AssetSetupTask);

    AssetSetupTask *work = TaskGetWork(task, AssetSetupTask);
    work->resource       = resource;
}

NONMATCH_FUNC u32 Asset3DSetup__GetTexPaletteLocation(void *texture, u32 id){
#ifdef NON_MATCHING

#else
    // clang-format off
	ldrh r3, [r0, #0x34]
	ldr r2, [r0, #0x2c]
	add ip, r0, r3
	ldrh r3, [ip, #6]
	mov r0, r2, lsl #0x10
	ldrh r2, [ip, r3]
	add r3, ip, r3
	mla r1, r2, r1, r3
	ldrh r1, [r1, #4]
	add r0, r1, r0, lsr #16
	mov r0, r0, lsl #3
	orr r0, r0, #0x80000000
	bx lr

// clang-format on
#endif
}

NONMATCH_FUNC u32 Asset3DSetup__PaletteFromName(const NNSG3dResTex *tex, const char *name)
{
#ifdef NON_MATCHING
    s32 length = STD_GetStringLength(name);
    if (length > 16)
        length = 16;

    NNSG3dResName resName;
    MI_CpuClear32(&resName, sizeof(resName));
    MI_CpuCopy8(name, &resName.name, length);

    return ((*(u16 *)NNS_G3dGetResDataByName((void *)tex + tex->plttInfo.ofsDict, &resName) + (u16)tex->plttInfo.vramKey) * 8) | VRAMSYSTEM_FLAG_ALLOCATED;
#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, lr}
	sub sp, sp, #0x10
	mov r5, r1
	mov r6, r0
	mov r0, r5
	bl STD_GetStringLength
	mov r4, r0
	cmp r4, #0x10
	movhi r4, #0x10
	add r1, sp, #0
	mov r0, #0
	mov r2, #0x10
	bl MIi_CpuClear32
	add r1, sp, #0
	mov r0, r5
	mov r2, r4
	bl MI_CpuCopy8
	ldrh r0, [r6, #0x34]
	add r1, sp, #0
	add r0, r6, r0
	bl NNS_G3dGetResDataByName
	ldr r2, [r6, #0x2c]
	ldrh r1, [r0, #0]
	mov r0, r2, lsl #0x10
	add r0, r1, r0, lsr #16
	mov r0, r0, lsl #3
	orr r0, r0, #0x80000000
	add sp, sp, #0x10
	ldmia sp!, {r4, r5, r6, pc}

// clang-format on
#endif
}

// DrawReqTask (Part 2)
NONMATCH_FUNC void DrawReqTask__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl Camera3D__GetTask
	cmp r0, #0
	beq _0207FB0C
	ldr r0, =DrawReqTask__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	mov r5, r0
	mov r0, #0
	bl OAMSystem__GetList2
	add r1, r4, #0x10
	mov r2, #0x400
	mov r6, r0
	bl MIi_CpuCopyFast
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _0207FA60
	add r1, r5, #0x800
	add r0, r5, #0xb8
	add r0, r0, #0x400
	ldrh r7, [r1, #0xba]
	ldrh r9, [r1, #0xbe]
	b _0207FA70
_0207FA60:
	add r0, r5, #0x800
	ldrh r7, [r0, #0xb8]
	ldrh r9, [r0, #0xbc]
	add r0, r5, #0xb8
_0207FA70:
	mov r1, r6
	mov r2, #0x400
	bl MIi_CpuCopyFast
	cmp r9, #0
	mov r5, #0
	ble _0207FAB4
	sub r8, r9, #1
	mov r10, #6
_0207FA90:
	sub r0, r8, r5
	rsb r1, r5, #0x7f
	mov r2, r10
	add r0, r6, r0, lsl #3
	add r1, r6, r1, lsl #3
	bl MIi_CpuCopy16
	add r5, r5, #1
	cmp r5, r9
	blt _0207FA90
_0207FAB4:
	cmp r5, #0x80
	bge _0207FAD4
	mov r1, #0x200
_0207FAC0:
	sub r0, r5, r9
	add r5, r5, #1
	str r1, [r6, r0, lsl #3]
	cmp r5, #0x80
	blt _0207FAC0
_0207FAD4:
	add r1, r4, #0x800
	mov r0, #1
	strh r7, [r1, #0x10]
	bl OAMSystem__GetList2
	add r1, r4, #0x410
	mov r2, #0x400
	bl MIi_CpuCopyFast
	mov r0, #1
	bl OAMSystem__GetOAMAffineOffset
	add r1, r4, #0x800
	strh r0, [r1, #0x12]
	mov r0, #1
	bl DrawReqTask__Func_207FC10
	b _0207FB68
_0207FB0C:
	add r5, r4, #0x10
	mov r6, #0
	mov r7, #0x400
_0207FB18:
	add r0, r4, r6, lsl #2
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _0207FB58
	mov r0, r6
	bl OAMSystem__GetList2
	mov r1, r5
	mov r2, r7
	bl MIi_CpuCopyFast
	mov r0, r6
	bl OAMSystem__GetOAMAffineOffset
	add r1, r4, r6, lsl #1
	add r1, r1, #0x800
	strh r0, [r1, #0x10]
	mov r0, r6
	bl DrawReqTask__Func_207FC10
_0207FB58:
	add r6, r6, #1
	cmp r6, #2
	add r5, r5, #0x400
	blt _0207FB18
_0207FB68:
	ldr r0, =DrawReqTask__Main_207FB88
	mov r1, #1
	str r1, [r4, #4]
	bl SetCurrentTaskMainEvent
	bl DrawReqTask__Main_207FB88
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void DrawReqTask__Main_207FB88(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	ldr r0, [r4, #0]
	cmp r0, #0
	ldmeqia sp!, {r3, r4, r5, r6, r7, pc}
	add r6, r4, #0x10
	mov r5, #0
	mov r7, #0x400
_0207FBAC:
	add r0, r4, r5, lsl #2
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _0207FBE8
	mov r0, r5
	bl OAMSystem__GetList2
	mov r1, r0
	mov r0, r6
	mov r2, r7
	bl MIi_CpuCopyFast
	add r0, r4, r5, lsl #1
	add r0, r0, #0x800
	ldrh r1, [r0, #0x10]
	mov r0, r5
	bl OAMSystem__SetOAMAffineOffset
_0207FBE8:
	add r5, r5, #1
	cmp r5, #2
	add r6, r6, #0x400
	blt _0207FBAC
	bl DestroyCurrentTask
	ldr r0, =DrawReqTask__sVars
	mov r1, #0
	str r1, [r0]
	ldmia sp!, {r3, r4, r5, r6, r7, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void DrawReqTask__Func_207FC10(BOOL useEngineB)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, r9, r10, lr}
	mov r7, r0
	bl OAMSystem__GetList3
	mov r5, r0
	mov r0, r7
	bl OAMSystem__GetList2
	mov r4, r0
	mov r0, r7
	bl OAMSystem__GetOAMCount
	rsb r0, r0, #0x7f
	add r6, r4, r0, lsl #3
	ldr r8, =0x0000FFFF
	mov r9, #0
	mov r4, #6
_0207FC48:
	mov r0, r7
	mov r1, r9
	bl OAMSystem__GetListMap
	mov r10, r0
	cmp r10, r8
	beq _0207FC84
_0207FC60:
	mov r1, r6
	mov r2, r4
	add r0, r5, r10, lsl #3
	bl MIi_CpuCopy16
	add r0, r5, r10, lsl #3
	ldrh r10, [r0, #6]
	add r6, r6, #8
	cmp r10, r8
	bne _0207FC60
_0207FC84:
	add r0, r9, #1
	mov r0, r0, lsl #0x10
	mov r9, r0, lsr #0x10
	cmp r9, #0x20
	blo _0207FC48
	mov r0, r7
	bl OAMSystem__GetList2
	mov r5, r0
	mov r0, r7
	bl OAMSystem__GetList1
	mov r4, r0
	mov r0, r7
	mov r6, #0
	bl OAMSystem__GetOAMAffineCount
	cmp r0, #0
	bls _0207FD10
_0207FCC4:
	ldrh r1, [r4, #6]
	add r0, r6, #1
	mov r8, r0, lsl #0x10
	strh r1, [r5, #6]
	ldrh r2, [r4, #0xe]
	add r1, r4, #0x18
	mov r0, r7
	strh r2, [r5, #0xe]
	ldrh r3, [r4, #0x16]
	add r2, r5, #0x18
	add r4, r4, #0x20
	strh r3, [r5, #0x16]
	ldrh r1, [r1, #6]
	add r5, r5, #0x20
	mov r6, r8, lsr #0x10
	strh r1, [r2, #6]
	bl OAMSystem__GetOAMAffineCount
	cmp r0, r8, lsr #16
	bhi _0207FCC4
_0207FD10:
	mov r0, r7
	bl OAMSystem__GetOAMAffineCount
	mov r1, r0
	mov r0, r7
	bl OAMSystem__SetOAMAffineOffset
	ldmia sp!, {r4, r5, r6, r7, r8, r9, r10, pc}

// clang-format on
#endif
}

// SysPauseDrawControl
NONMATCH_FUNC void SysPauseDrawControl__Create(BOOL enabled)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, lr}
	sub sp, sp, #0xc
	ldr r2, =0x0000FFFF
	mov r4, r0
	mov r1, #0
	str r2, [sp]
	mov r2, #0xfe
	ldr r0, =SysPauseDrawControl__Main
	mov r3, r1
	str r2, [sp, #4]
	mov ip, #4
	mov r2, #3
	str ip, [sp, #8]
	bl TaskCreate_
	bl GetTaskWork_
	str r4, [r0]
	add sp, sp, #0xc
	ldmia sp!, {r3, r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void SysPauseDrawControl__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	bl GetCurrentTaskWork_
	ldr r0, [r0, #0]
	bl RenderCore_DisableSwapBuffers
	bl DestroyCurrentTask
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

// Asset3DSetup
void Asset3DSetup__Main(void)
{
    AssetSetupTask *work = TaskGetWorkCurrent(AssetSetupTask);

    NNS_G3dResDefaultSetup(work->resource);
    DestroyCurrentTask();
}

// Camera3D (Part 2)
NONMATCH_FUNC void Camera3D__Main(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, lr}
	bl GetCurrentTaskWork_
	mov r4, r0
	bl Camera3D__UseEngineA
	bl DrawReqTask__GetEnabled
	cmp r0, #0
	beq _0207FDDC
	bl Camera3D__UseEngineA
	cmp r0, #0
	moveq r5, #0
	movne r5, #1
	b _0207FDEC
_0207FDDC:
	bl Camera3D__UseEngineA
	cmp r0, #0
	movne r5, #0
	moveq r5, #1
_0207FDEC:
	mov r2, #0x5c
	mla r0, r5, r2, r4
	ldr r1, =renderCoreGFXControlA
	bl MIi_CpuCopy32
	mov r0, #0
	bl OAMSystem__GetOAMAffineOffset
	add r1, r4, r5, lsl #1
	add r1, r1, #0x800
	strh r0, [r1, #0xb8]
	mov r0, #0
	bl OAMSystem__GetOAMCount
	add r1, r4, r5, lsl #1
	add r1, r1, #0x800
	strh r0, [r1, #0xbc]
	mov r0, #0
	bl OAMSystem__PrepareNewFrame
	mov r0, #1
	bl OAMSystem__PrepareNewFrame
	ldr r1, =0x04000304
	ldr r0, =0x0000020E
	ldrh r1, [r1, #0]
	and r0, r1, r0
	tst r0, #0xc
	ldmeqia sp!, {r3, r4, r5, pc}
	bl DrawReqTask__GetEnabled
	cmp r0, #0
	bne _0207FE70
	ldr r0, =renderCoreSwapBuffer
	ldr r1, =0x04000540
	ldr r2, [r0, #8]
	ldr r0, [r0, #4]
	orr r0, r0, r2, lsl #1
	str r0, [r1]
_0207FE70:
	bl OS_DisableInterrupts
	mov r4, r0
	bl DrawReqTask__GetEnabled
	cmp r0, #0
	moveq r2, #1
	ldr r1, =DrawReqTask__sVars
	mvnne r2, #0
	mov r0, r4
	str r2, [r1, #0xc]
	bl OS_RestoreInterrupts
	ldmia sp!, {r3, r4, r5, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Camera3D__ProcessOAMList(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, r5, r6, r7, r8, lr}
	mov r0, #1
	bl OAMSystem__GetList2
	mov r4, #0
	ldr r1, =0xC0000C00
	mov r5, r4
	mov r6, r4
	mov ip, r4
_0207FED4:
	and r2, r6, #0xff
	mov lr, ip
	mov r7, ip
	orr r8, r2, r1
_0207FEE4:
	mov r3, r7, lsl #0x17
	add r2, r5, lr
	orr r3, r8, r3, lsr #7
	add lr, lr, #8
	str r3, [r0]
	orr r2, r2, #0xf000
	strh r2, [r0, #4]
	cmp lr, #0x20
	add r0, r0, #8
	add r7, r7, #0x40
	blt _0207FEE4
	add r4, r4, #8
	cmp r4, #0x18
	add r5, r5, #0x100
	add r6, r6, #0x40
	blt _0207FED4
	ldmia sp!, {r4, r5, r6, r7, r8, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Camera3D__VBlankCallback(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r4, lr}
	sub sp, sp, #8
	ldr r0, =DrawReqTask__sVars
	ldr r0, [r0, #4]
	bl GetTaskWork_
	ldr r1, =DrawReqTask__sVars
	mov r4, r0
	ldr r0, [r1, #0xc]
	cmp r0, #0
	ble _02080130
	ldr r0, =0x04000006
	ldrh r0, [r0, #0]
	cmp r0, #0xc1
	bgt _0207FF6C
	mov r0, #0x310
	bl OS_SpinWait
_0207FF6C:
	ldr r0, =renderCoreGFXControlA
	mov r1, #0x5c
	bl DC_StoreRange
	ldr r0, =renderCoreGFXControlB
	mov r1, #0x5c
	bl DC_StoreRange
	bl DC_WaitWriteBufferEmpty
	bl Camera3D__UseEngineA
	cmp r0, #0
	beq _0207FFAC
	ldrsh r2, [r4, #0x58]
	ldr r1, =renderCoreGFXControlA
	ldr r0, =renderCoreGFXControlB
	strh r2, [r1, #0x58]
	ldrsh r1, [r4, #0xb4]
	b _0207FFC0
_0207FFAC:
	ldrsh r2, [r4, #0xb4]
	ldr r1, =renderCoreGFXControlA
	ldr r0, =renderCoreGFXControlB
	strh r2, [r1, #0x58]
	ldrsh r1, [r4, #0x58]
_0207FFC0:
	ldr r2, =0x04000600
	strh r1, [r0, #0x58]
	ldr r0, [r2, #0]
	tst r0, #0x8000000
	addne sp, sp, #8
	ldmneia sp!, {r4, pc}
	ldr r0, =renderDmaNo
	ldr r1, =renderCoreGFXControlA
	ldr r0, [r0, #0]
	sub r2, r2, #0x5f0
	mov r3, #0x10
	bl MI_DmaCopy32
	ldr r0, =renderDmaNo
	ldr r1, =renderCoreGFXControlA+0x00000010
	ldr r0, [r0, #0]
	ldr r2, =0x04000040
	mov r3, #0xc
	bl MI_DmaCopy32
	mov r2, #0x4000000
	ldr r0, =renderCoreGFXControlA
	ldr r1, [r2, #0]
	ldr r0, [r0, #0x1c]
	bic r1, r1, #0xe000
	orr r1, r1, r0, lsl #13
	str r1, [r2], #0x50
	ldr r0, =renderDmaNo
	ldr r1, =renderCoreGFXControlA+0x00000020
	ldr r0, [r0, #0]
	mov r3, #6
	bl MI_DmaCopy16
	ldr r3, =renderCoreGFXControlA
	ldr r2, =0x0400004C
	ldrh ip, [r3, #0x5a]
	sub r0, r2, #0x2c
	ldr r1, =renderCoreGFXControlA+0x00000028
	strh ip, [r2]
	ldrsh r2, [r3, #0x3c]
	str r2, [sp]
	ldrsh r2, [r3, #0x3e]
	str r2, [sp, #4]
	ldrsh r2, [r3, #0x38]
	ldrsh r3, [r3, #0x3a]
	bl G2x_SetBGyAffine_
	ldr r3, =renderCoreGFXControlA
	ldr r0, =0x04000030
	ldrsh r2, [r3, #0x54]
	ldr r1, =renderCoreGFXControlA+0x00000040
	str r2, [sp]
	ldrsh r2, [r3, #0x56]
	str r2, [sp, #4]
	ldrsh r2, [r3, #0x50]
	ldrsh r3, [r3, #0x52]
	bl G2x_SetBGyAffine_
	mov r0, #0
	bl OAMSystem__CopyToVRAM
	bl Camera3D__UseEngineA
	cmp r0, #0
	mov r2, #0x400
	beq _020800BC
	add r1, r4, #0xb8
	mov r0, #0x7000000
	bl MIi_CpuCopyFast
	b _020800CC
_020800BC:
	add r0, r4, #0xb8
	add r1, r0, #0x400
	mov r0, #0x7000000
	bl MIi_CpuCopyFast
_020800CC:
	mov r0, #1
	bl OAMSystem__CopyToVRAM
	bl ProcessTexturePaletteQueue
	bl ProcessTexturePixelQueue
	bl ProcessBackgroundPaletteQueue
	bl ProcessSpritePaletteQueue
	bl Mappings__ReadList
	bl ProcessSpritePixelQueue
	ldr r0, =DrawReqTask__sVars
	ldr r0, [r0, #8]
	cmp r0, #0
	beq _02080104
	bl Camera3D__InitMode1
	b _02080108
_02080104:
	bl Camera3D__InitMode2
_02080108:
	ldr r0, =DrawReqTask__sVars
	mov r1, #0
	str r1, [r0, #0xc]
	ldr r0, [r0, #8]
	add sp, sp, #8
	cmp r0, #0
	ldr r0, =DrawReqTask__sVars
	moveq r1, #1
	str r1, [r0, #8]
	ldmia sp!, {r4, pc}
_02080130:
	addge sp, sp, #8
	ldmgeia sp!, {r4, pc}
	ldr r0, =0x04000006
	ldrh r0, [r0, #0]
	cmp r0, #0xc1
	bgt _02080150
	mov r0, #0x310
	bl OS_SpinWait
_02080150:
	bl Camera3D__UseEngineA
	cmp r0, #0
	bne _02080174
	ldrsh r2, [r4, #0x58]
	ldr r1, =renderCoreGFXControlA
	ldr r0, =renderCoreGFXControlB
	strh r2, [r1, #0x58]
	ldrsh r1, [r4, #0xb4]
	b _02080188
_02080174:
	ldrsh r2, [r4, #0xb4]
	ldr r1, =renderCoreGFXControlA
	ldr r0, =renderCoreGFXControlB
	strh r2, [r1, #0x58]
	ldrsh r1, [r4, #0x58]
_02080188:
	ldr r2, =0x04000600
	strh r1, [r0, #0x58]
	ldr r0, [r2, #0]
	tst r0, #0x8000000
	bne _02080268
	ldr r0, =renderDmaNo
	ldr r1, =renderCoreGFXControlA
	ldr r0, [r0, #0]
	sub r2, r2, #0x5f0
	mov r3, #0x10
	bl MI_DmaCopy32
	ldr r0, =renderDmaNo
	ldr r1, =renderCoreGFXControlA+0x00000010
	ldr r0, [r0, #0]
	ldr r2, =0x04000040
	mov r3, #0xc
	bl MI_DmaCopy32
	mov r2, #0x4000000
	ldr r0, =renderCoreGFXControlA
	ldr r1, [r2, #0]
	ldr r0, [r0, #0x1c]
	bic r1, r1, #0xe000
	orr r1, r1, r0, lsl #13
	str r1, [r2], #0x50
	ldr r0, =renderDmaNo
	ldr r1, =renderCoreGFXControlA+0x00000020
	ldr r0, [r0, #0]
	mov r3, #6
	bl MI_DmaCopy16
	ldr r3, =renderCoreGFXControlA
	ldr r2, =0x0400004C
	ldrh r4, [r3, #0x5a]
	sub r0, r2, #0x2c
	ldr r1, =renderCoreGFXControlA+0x00000028
	strh r4, [r2]
	ldrsh r2, [r3, #0x3c]
	str r2, [sp]
	ldrsh r2, [r3, #0x3e]
	str r2, [sp, #4]
	ldrsh r2, [r3, #0x38]
	ldrsh r3, [r3, #0x3a]
	bl G2x_SetBGyAffine_
	ldr r3, =renderCoreGFXControlA
	ldr r0, =0x04000030
	ldrsh r2, [r3, #0x54]
	ldr r1, =renderCoreGFXControlA+0x00000040
	str r2, [sp]
	ldrsh r2, [r3, #0x56]
	str r2, [sp, #4]
	ldrsh r2, [r3, #0x50]
	ldrsh r3, [r3, #0x52]
	bl G2x_SetBGyAffine_
	mov r0, #0
	bl OAMSystem__CopyToVRAM
	mov r0, #1
	bl OAMSystem__CopyToVRAM
_02080268:
	ldr r0, =DrawReqTask__sVars
	mov r1, #0
	str r1, [r0, #0xc]
	add sp, sp, #8
	ldmia sp!, {r4, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Camera3D__InitMode1(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r0, =renderCurrentDisplay
	mov ip, #1
	ldr r3, =0x04000304
	str ip, [r0]
	ldrh r2, [r3, #0]
	mov r0, #0
	ldr r1, =0x00200010
	bic r2, r2, #0x8000
	orr r2, r2, ip, lsl #15
	strh r2, [r3]
	mov r3, r0
	mov r2, #0x20
	str r0, [sp]
	bl VRAMSystem__SetupSubOBJBank
	mov r0, #4
	bl VRAMSystem__SetupSubBGBank
	mov r0, #8
	bl GX_SetBankForLCDC
	ldr r2, =0x80330010
	ldr r1, =0x04000064
	mov r0, #5
	str r2, [r1]
	bl GXS_SetGraphicsMode
	ldr r1, =0x04001000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x400
	str r0, [r1]
	ldrh r0, [r1, #0xc]
	and r0, r0, #0x43
	orr r0, r0, #0x84
	orr r0, r0, #0x4000
	strh r0, [r1, #0xc]
	ldrh r0, [r1, #0xc]
	bic r0, r0, #3
	strh r0, [r1, #0xc]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}

NONMATCH_FUNC void Camera3D__InitMode2(void)
{
#ifdef NON_MATCHING

#else
    // clang-format off
	stmdb sp!, {r3, lr}
	ldr r1, =renderCurrentDisplay
	mov r0, #0
	ldr r2, =0x04000304
	str r0, [r1]
	ldrh r1, [r2, #0]
	bic r1, r1, #0x8000
	orr r1, r1, r0, lsl #15
	strh r1, [r2]
	bl VRAMSystem__SetupSubBGBank
	mov r3, #0
	ldr r1, =0x00200010
	mov r0, #8
	mov r2, #0x20
	str r3, [sp]
	bl VRAMSystem__SetupSubOBJBank
	mov r0, #4
	bl GX_SetBankForLCDC
	ldr r2, =0x80320010
	ldr r1, =0x04000064
	mov r0, #5
	str r2, [r1]
	bl GXS_SetGraphicsMode
	ldr r1, =0x04001000
	ldr r0, [r1, #0]
	bic r0, r0, #0x1f00
	orr r0, r0, #0x1000
	str r0, [r1]
	ldmia sp!, {r3, pc}

// clang-format on
#endif
}
