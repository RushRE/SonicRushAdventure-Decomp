#include <hub/hubBgCircleEffect.h>
#include <game/system/allocator.h>
#include <game/graphics/drawReqTask.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED fx32 Unknown2051334__Func_20516B8(fx32 start, fx32 end, fx32 duration, fx32 progress);

// --------------------
// CONSTANTS/MACROS
// --------------------

#define EFFECTBGCIRCLE_FRAME_WIDTH  32
#define EFFECTBGCIRCLE_FRAME_HEIGHT 32
#define EFFECTBGCIRCLE_FRAME_SIZE   (EFFECTBGCIRCLE_FRAME_WIDTH * EFFECTBGCIRCLE_FRAME_HEIGHT)

// --------------------
// ENUMS
// --------------------

enum EffectBGCircleFlags
{
    EFFECTBGCIRCLE_FLAG_NONE = 0x00,

    EFFECTBGCIRCLE_FLAG_10000 = 1 << 16,
    EFFECTBGCIRCLE_FLAG_20000 = 1 << 17,
};

// --------------------
// VARIABLES
// --------------------

static const u16 effectBGCircleFrameTable[] = { 0, 1, 2, 3, 4, 5 };

// --------------------
// FUNCTIONS
// --------------------

// HubBGCircleEffect
void InitHubBGCircleEffect(HubBGCircleEffect *work)
{
    MI_CpuClear32(work, sizeof(*work));
}

void LoadHubBGCircleEffect(HubBGCircleEffect *work, void *background, u32 flags, u16 useEngineB, u16 bgID, u16 paletteRow)
{
    ReleaseHubBGCircleEffect(work);

    work->flags          = (u16)flags;
    work->animationTimer = 0;
    work->position.x     = 0;
    work->position.y     = 0;
    work->scale          = FLOAT_TO_FX32(1.0);
    work->percent        = FLOAT_TO_FX32(1.0);
    work->useEngineB     = useEngineB;
    work->bgID           = bgID;
    work->frame          = -1;
    work->mappings       = NULL;
    work->palette        = NULL;
    work->background     = background;
    work->mappings       = HeapAllocHead(HEAP_USER, sizeof(*work->mappings));
    work->palette        = HeapAllocHead(HEAP_USER, 0x10 * sizeof(GXRgb));

    InitHubBGCircleEffectTiles(work->mappings, paletteRow);
    work->flags |= EFFECTBGCIRCLE_FLAG_10000;

    InitHubBGCircleEffectPalette(work->palette, work->background, work->percent);
    work->flags |= EFFECTBGCIRCLE_FLAG_20000;
}

void ReleaseHubBGCircleEffect(HubBGCircleEffect *work)
{
    if (work->palette != NULL)
    {
        HeapFree(HEAP_USER, work->palette);
        work->palette = NULL;
    }

    if (work->mappings != NULL)
    {
        HeapFree(HEAP_USER, work->mappings);
        work->mappings = NULL;
    }

    InitHubBGCircleEffect(work);
}

void ProcessHubBGCircleEffect(HubBGCircleEffect *work)
{
    BOOL updatePixels = FALSE;

    u16 frame = effectBGCircleFrameTable[FX_ModS32(FX_DivS32(work->animationTimer, 6), 6)];
    if (frame != work->frame)
    {
        work->frame  = frame;
        updatePixels = TRUE;
    }

    RenderAffineControl *affine;
    if (work->bgID == BACKGROUND_2)
        affine = &VRAMSystem__GFXControl[work->useEngineB]->affineA;
    else
        affine = &VRAMSystem__GFXControl[work->useEngineB]->affineB;
    MTX_Scale22(&affine->matrix, work->scale, work->scale);
    affine->centerX = 32;
    affine->centerY = 32;
    affine->x       = affine->centerX - work->position.x;
    affine->y       = affine->centerY - work->position.y;

    u16 screenBaseA;
    s32 mappingsMode;
    u16 screenBaseBlock;
    u16 characterBaseA;
    u16 characterBaseBlock;
    if (updatePixels && (work->flags & BACKGROUND_FLAG_DISABLE_PALETTE) == 0)
    {
        GetVRAMCharacterConfig(work->useEngineB, work->bgID, &characterBaseA, &characterBaseBlock);

        void *vramPixels = &VRAMSystem__VRAM_BG[work->useEngineB][0x10000 * characterBaseA + 0x4000 * characterBaseBlock];
        void *pixels     = &GetBackgroundPixels(work->background)->data[EFFECTBGCIRCLE_FRAME_SIZE * frame];

        void *circleVramPixels = (u8 *)vramPixels + 64;

        if ((work->flags & BACKGROUND_FLAG_LOAD_PALETTE) != 0)
            LoadUncompressedPixels(pixels, EFFECTBGCIRCLE_FRAME_SIZE, PIXEL_MODE_SPRITE, circleVramPixels);
        else
            QueueUncompressedPixels(pixels, EFFECTBGCIRCLE_FRAME_SIZE, PIXEL_MODE_SPRITE, circleVramPixels);

        MIi_CpuClear32(0, vramPixels, 64);
    }

    if ((work->flags & EFFECTBGCIRCLE_FLAG_10000) != 0 && (work->flags & BACKGROUND_FLAG_DISABLE_PIXELS) == 0)
    {
        GetVRAMTileConfig(work->useEngineB, work->bgID, &mappingsMode, &screenBaseA, &screenBaseBlock);

        if ((work->flags & BACKGROUND_FLAG_LOAD_PIXELS) != 0)
            Mappings__LoadUnknown(work->mappings, 0, 0, 32, TRUE, mappingsMode, screenBaseA, screenBaseBlock, 0, 0, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT_EX);
        else
            Mappings__ReadMappingsCompressed(work->mappings, 0, 0, 32, TRUE, mappingsMode, screenBaseA, screenBaseBlock, 0, 0, BG_DISPLAY_FULL_WIDTH, BG_DISPLAY_SINGLE_HEIGHT_EX);
        work->flags &= ~EFFECTBGCIRCLE_FLAG_10000;
    }

    if ((work->flags & EFFECTBGCIRCLE_FLAG_20000) != 0 && (work->flags & BACKGROUND_FLAG_DISABLE_MAPPINGS) == 0)
    {
        PaletteMode paletteMode;
        VRAMPaletteKey vramPalette;
        GetVRAMPaletteConfig(work->useEngineB, work->bgID, &paletteMode, &vramPalette);

        if ((work->flags & BACKGROUND_FLAG_LOAD_MAPPINGS) != 0)
            LoadUncompressedPalette(work->palette, 16, paletteMode, VRAMKEY_TO_KEY(vramPalette));
        else
            QueueUncompressedPalette(work->palette, 16, paletteMode, VRAMKEY_TO_KEY(vramPalette));
        work->flags &= ~EFFECTBGCIRCLE_FLAG_20000;
    }

    work->animationTimer++;
}

void SetHubBGCircleEffectPosition(HubBGCircleEffect *work, s16 x, s16 y)
{
    work->position.x = x;
    work->position.y = y;
}

void SetHubBGCircleEffectScale(HubBGCircleEffect *work, fx32 scale)
{
    work->scale = FX_Inv(scale);
}

void SetHubBGCircleEffectBrightness(HubBGCircleEffect *work, s16 percent)
{
    if (work->percent != percent)
    {
        work->percent = percent;
        InitHubBGCircleEffectPalette(work->palette, work->background, work->percent);
        work->flags |= EFFECTBGCIRCLE_FLAG_20000;
    }
}

void InitHubBGCircleEffectTiles(GXScrText32x32 *mappings, u32 paletteRow)
{
    s32 y;
    s32 x;
    s32 paletteMask;
    u16 tileFlipNone;
    u16 tileFlipX;
    u16 tileFlipY;
    u16 tileFlipXY;

    MI_CpuClearFast(mappings, sizeof(GXScrText32x32));

    paletteMask = paletteRow << GX_SCRFMT_TEXT_COLORPLTT_SHIFT;

    tileFlipNone = paletteMask | ((0 << GX_SCRFMT_TEXT_HF_SHIFT) | (0 << GX_SCRFMT_TEXT_VF_SHIFT));
    tileFlipX    = paletteMask | ((1 << GX_SCRFMT_TEXT_HF_SHIFT) | (0 << GX_SCRFMT_TEXT_VF_SHIFT));
    tileFlipY    = paletteMask | ((0 << GX_SCRFMT_TEXT_HF_SHIFT) | (1 << GX_SCRFMT_TEXT_VF_SHIFT));
    tileFlipXY   = paletteMask | ((1 << GX_SCRFMT_TEXT_HF_SHIFT) | (1 << GX_SCRFMT_TEXT_VF_SHIFT));

    u16 *mappingsPtr;
    u16 tile;
    for (y = 0; y < 4; y++)
    {
        mappingsPtr = &mappings->scr[y][0];
        tile        = (4 * y) + 1;
        for (x = 0; x < 4; x++)
        {
            *mappingsPtr = tile | tileFlipNone;

            mappingsPtr++;
            tile++;
        }

        mappingsPtr = &mappings->scr[y][4];
        tile        = 4 * (y + 1);
        for (x = 0; x < 4; x++)
        {
            *mappingsPtr = tile | tileFlipX;

            mappingsPtr++;
            tile--;
        }
    }

    for (y = 0; y < 4; y++)
    {
        mappingsPtr = &mappings->scr[4 + y][0];
        tile        = 4 * (3 - y) + 1;
        for (x = 0; x < 4; x++)
        {
            *mappingsPtr = tile | tileFlipY;

            mappingsPtr++;
            tile++;
        }

        mappingsPtr = &mappings->scr[4 + y][4];
        tile        = 4 * (4 - y);
        for (x = 0; x < 4; x++)
        {
            *mappingsPtr = tile | tileFlipXY;

            mappingsPtr++;
            tile--;
        }
    }
}

void InitHubBGCircleEffectPalette(GXRgb *colors, void *background, fx32 percent)
{
    GXRgb *bgPalette = (GXRgb *)GetBackgroundPalette(background)->data;
    for (s32 c = 0; c < 0x10; c++)
    {
        s32 color = FX32_TO_WHOLE(Unknown2051334__Func_20516B8(FX32_FROM_WHOLE(bgPalette[c] & 0x1F), FLOAT_TO_FX32(0.0), FLOAT_TO_FX32(1.0), percent));
        colors[c] = GX_RGB(color, color, color);
    }
}

void InitHubConstructionCompletePulse(HubConstructionCompletePulse *work, s32 flags, BOOL useEngineB, u16 bgID, u16 paletteRow)
{
    u16 screenBaseA;
    s32 mappingsMode;
    u16 screenBaseBlock;
    u16 characterBaseA;
    u16 characterBaseBlock;

    work->flags = flags;

    GetVRAMTileConfig(useEngineB, bgID, &mappingsMode, &screenBaseA, &screenBaseBlock);

    const void *vram = VRAMSystem__VRAM_BG[useEngineB];
    MI_CpuFill32((u32 *)&vram[0x10000 * screenBaseA + 0x800 * screenBaseBlock], VRAM_SCRFMT_TEXT(0, FALSE, FALSE, paletteRow), sizeof(GXScrText32x32));

    GetVRAMCharacterConfig(useEngineB, bgID, &characterBaseA, &characterBaseBlock);
    MI_CpuFill32((u32 *)&vram[0x10000 * characterBaseA + 0x4000 * characterBaseBlock], 0x11111111, 0x10 * sizeof(GXRgb));

    work->vramPalette = VRAMKEY_TO_ADDR((0x10 * sizeof(GXRgb)) * paletteRow + 2);
    if (useEngineB != GRAPHICS_ENGINE_A)
    {
        work->vramPalette += VRAMKEY_TO_KEY(VRAM_DB_BG_PLTT);
    }
    else
    {
        work->vramPalette += VRAMKEY_TO_KEY(VRAM_BG_PLTT);
    }
}

void DrawHubConstructionCompletePulse(HubConstructionCompletePulse *work, GXRgb color)
{
    work->color = color;

    if ((work->flags & 1) == 0)
    {
        if ((work->flags & 2) != 0)
            LoadUncompressedPalette(&work->color, 1, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(work->vramPalette));
        else
            QueueUncompressedPalette(&work->color, 1, PALETTE_MODE_SPRITE, VRAMKEY_TO_KEY(work->vramPalette));
    }
}
