#include <game/graphics/background.h>
#include <game/graphics/renderCore.h>
#include <game/graphics/mappingsQueue.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/pixelsQueue.h>
#include <game/graphics/drawReqTask.h>
#include <game/graphics/vramSystem.h>

// --------------------
// STRUCTS
// --------------------

struct BBGHeader
{
    u32 signature;
    u32 size;
    u32 pixelOffset;
    u32 mappingsOffset;
    u32 paletteOffset;
    u16 colorFormat;
    u16 width;
    u16 height;
    u16 tileOffset;
    u16 paletteRow;
    u16 paletteBank;
};

// --------------------
// HELPER MACROS
// --------------------

#define GetFile(filePtr)              ((struct BBGHeader *)filePtr)
#define GetFileBlock(filePtr, offset) ((u8 *)(filePtr) + (offset))

#define GetFileFromBackground(background)     GetFile((background)->fileData)
#define GetPixelsFromBackground(background)   GetFileBlock((background)->fileData, GetFile((background)->fileData)->pixelOffset)
#define GetMappingsFromBackground(background) GetFileBlock((background)->fileData, GetFile((background)->fileData)->mappingsOffset)
#define GetPaletteFromBackground(background)  GetFileBlock((background)->fileData, GetFile((background)->fileData)->paletteOffset)

// --------------------
// FUNCTION DECLS
// --------------------

static void InitBackgroundPixelsForCharacter(Background *background);
static void InitBackgroundMappings(Background *background, u16 displayWidth, u16 displayHeight);
static void InitBackgroundPalette(Background *background);
static void InitBackgroundPixelsForScreen(Background *background, u16 displayWidth, u16 displayHeight);

// --------------------
// FUNCTIONS
// --------------------

void InitBackgroundSystem(void)
{
    // Nothin
}

void InitBackgroundEx(Background *background, void *fileData, BackgroundFlags flags, BOOL useEngineB, BackgroundID bgID, s32 paletteMode, void *vramPalette, s32 pixelMode,
                      void *vramPixels, s32 mappingsMode, u16 screenBaseA_Mappings, u16 screenBaseBlock, u16 offsetX, u16 offsetY, u16 displayWidth, u16 displayHeight)
{
    MI_CpuClear32(background, sizeof(Background));

    background->flags       = flags;
    background->fileData    = fileData;
    background->bgID        = bgID;
    background->paletteData = (void *)GetBackgroundPalette(fileData);
    background->pixelData   = (void *)GetBackgroundPixels(fileData);
    background->mappingData = (void *)GetBackgroundMappings(fileData);
    background->width       = GetFile(fileData)->width;
    background->height      = GetFile(fileData)->height;
    background->useEngineB  = useEngineB;
    background->paletteMode = paletteMode;
    background->vramPalette = &((u16 *)vramPalette)[16 * GetFile(fileData)->paletteRow];
    background->pixelMode   = pixelMode;

    switch ((BackgroundFormat)(GetFile(fileData)->colorFormat & 0xF))
    {
        case BBG_FORMAT_0:
            background->vramPixels = &((u8 *)vramPixels)[32 * GetFile(fileData)->tileOffset];
            break;

        case BBG_FORMAT_1:
        case BBG_FORMAT_2:
            background->vramPixels = &((u8 *)vramPixels)[64 * GetFile(fileData)->tileOffset];
            break;

        default:
            background->vramPixels = vramPixels;
            break;
    }

    background->mappingsMode         = mappingsMode;
    background->screenBaseA_Mappings = screenBaseA_Mappings;
    background->screenBaseBlock      = screenBaseBlock;
    background->offset.x             = offsetX;
    background->offset.y             = offsetY;
    background->displayWidth         = displayWidth;
    background->displayHeight        = displayHeight;
}

void InitBackground(Background *background, void *fileData, BackgroundFlags flags, BOOL useEngineB, BackgroundID bgID, u16 displayWidth, u16 displayHeight)
{
    MI_CpuClear32(background, sizeof(Background));

    background->flags      = flags;
    background->fileData   = fileData;
    background->width      = GetFile(fileData)->width;
    background->height     = GetFile(fileData)->height;
    background->useEngineB = useEngineB;
    background->bgID       = bgID;

    switch (GetBackgroundFormat(fileData))
    {
        case BBG_FORMAT_0:
        case BBG_FORMAT_1:
        case BBG_FORMAT_2:
            InitBackgroundPalette(background);
            InitBackgroundPixelsForCharacter(background);
            InitBackgroundMappings(background, displayWidth, displayHeight);
            break;

        case BBG_FORMAT_3:
            InitBackgroundPalette(background);
            // fallthrough

        case BBG_FORMAT_4:
            InitBackgroundPixelsForScreen(background, displayWidth, displayHeight);
            break;

        default:
            break;
    }
}

void DrawBackground(Background *background)
{
    BOOL colorFormatFlag;
    BOOL isBackground;

    switch (background->pixelMode)
    {
        case PIXEL_MODE_SPRITE:
        case PIXEL_MODE_TEXTURE:
            isBackground = FALSE;
            break;

        default:
            isBackground = TRUE;
            break;
    }

    colorFormatFlag = GetBackgroundFlag(background->fileData);

    if (background->paletteData != NULL)
    {
        if ((background->flags & BACKGROUND_FLAG_DISABLE_PALETTE) == 0)
        {
            if ((background->flags & BACKGROUND_FLAG_LOAD_PALETTE) != 0)
            {
                LoadCompressedPalette(background->paletteData, background->paletteMode, VRAMKEY_TO_KEY(background->vramPalette));
            }
            else
            {
                QueueCompressedPalette(background->paletteData, background->paletteMode, VRAMKEY_TO_KEY(background->vramPalette));
            }
        }
    }

    if (background->pixelData)
    {
        if ((background->flags & BACKGROUND_FLAG_DISABLE_PIXELS) == 0)
        {
            if (isBackground)
            {
                u16 screenBaseBlock;
                GetVRAMPixelConfig(background->useEngineB, background->bgID, &background->pixelMode, &screenBaseBlock);

                if ((background->flags & BACKGROUND_FLAG_LOAD_PIXELS) != 0)
                {
                    int baseBlock = 0x4000 * screenBaseBlock;
                    void *vram    = (void *)((int)(void *)VRAMSystem__VRAM_BG[background->useEngineB] + baseBlock);

                    LoadCompressedBackgroundPixels(background->pixelData, background->position.x, background->position.y, background->width, background->pixelMode,
                                                   (void *)((int)(void *)VRAMSystem__VRAM_BG[background->useEngineB] + baseBlock), background->offset.x, background->offset.y,
                                                   background->displayWidth, background->displayHeight);
                }
                else
                {
                    int baseBlock = 0x4000 * screenBaseBlock;
                    void *vram    = (void *)((int)(void *)VRAMSystem__VRAM_BG[background->useEngineB] + baseBlock);

                    QueueCompressedBackgroundPixels(background->pixelData, background->position.x, background->position.y, background->width, background->pixelMode, vram,
                                                    background->offset.x, background->offset.y, background->displayWidth, background->displayHeight);
                }
            }
            else
            {
                if ((background->flags & BACKGROUND_FLAG_LOAD_PIXELS) != 0)
                {
                    LoadCompressedPixels(background->pixelData, PIXEL_MODE_SPRITE, background->vramPixels);
                }
                else
                {
                    QueueCompressedPixels(background->pixelData, PIXEL_MODE_SPRITE, background->vramPixels);
                }
            }
        }
    }

    if (background->mappingData != NULL)
    {
        if ((background->flags & BACKGROUND_FLAG_DISABLE_MAPPINGS) == 0)
        {
            u16 width  = background->displayWidth;
            u16 height = background->displayHeight;

            if (!isBackground)
            {
                if ((background->flags & BACKGROUND_FLAG_ALIGN_EVEN_WIDTH) != 0)
                {
                    width = (width + 2) & ~1;
                }

                if ((background->flags & BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT) != 0)
                {
                    height = (height + 2) & ~1;
                }
            }

            if ((background->flags & BACKGROUND_FLAG_LOAD_MAPPINGS) != 0)
            {
                Mappings__ReadMappings(background->mappingData, (u16)(background->position.x >> 3), (u16)(background->position.y >> 3), background->width, colorFormatFlag,
                                       background->mappingsMode, background->screenBaseA_Mappings, background->screenBaseBlock, background->offset.x, background->offset.y, width,
                                       height);
            }
            else
            {
                Mappings__ReadMappings2(background->mappingData, (u16)(background->position.x >> 3), (u16)(background->position.y >> 3), background->width, colorFormatFlag,
                                        background->mappingsMode, background->screenBaseA_Mappings, background->screenBaseBlock, background->offset.x, background->offset.y, width,
                                        height);
            }
        }
    }

    if ((background->flags & (BACKGROUND_FLAG_SET_BG_Y | BACKGROUND_FLAG_SET_BG_X)) != 0)
    {
        Vec2U16 *bgPosition = &VRAMSystem__GFXControl[background->useEngineB]->bgPosition[background->bgID];

        if (isBackground)
        {
            if ((background->flags & BACKGROUND_FLAG_SET_BG_X) != 0)
            {
                bgPosition->x = 0;
            }

            if ((background->flags & BACKGROUND_FLAG_SET_BG_Y) != 0)
            {
                bgPosition->y = 0;
            }
        }
        else
        {
            if (colorFormatFlag)
            {
                if ((background->flags & BACKGROUND_FLAG_SET_BG_X) != 0)
                {
                    s32 offset    = 8 * background->offset.x;
                    bgPosition->x = offset + background->position.x;
                }

                if ((background->flags & BACKGROUND_FLAG_SET_BG_Y) != 0)
                {
                    s32 offset    = 8 * background->offset.y;
                    bgPosition->y = offset + background->position.y;
                }
            }
            else
            {
                if ((background->flags & BACKGROUND_FLAG_SET_BG_X) != 0)
                {
                    s32 offset    = 8 * background->offset.x;
                    bgPosition->x = offset + (background->position.x & 7);
                }

                if ((background->flags & BACKGROUND_FLAG_SET_BG_Y) != 0)
                {
                    s32 offset    = 8 * background->offset.y;
                    bgPosition->y = offset + (background->position.y & 7);
                }
            }
        }

        if (!isBackground)
        {
            BOOL applyPosition = FALSE;

            switch (*(u32 *)VRAMSystem__DisplayControllers[background->useEngineB] & 7)
            {
                case GX_BGMODE_1:
                    if (background->bgID == BACKGROUND_3)
                        applyPosition = TRUE;
                    break;

                case GX_BGMODE_2:
                    if (background->bgID == BACKGROUND_2 || background->bgID == BACKGROUND_3)
                        applyPosition = TRUE;
                    break;

                case GX_BGMODE_3:
                    if (background->bgID == BACKGROUND_3)
                        applyPosition = TRUE;
                    break;

                case GX_BGMODE_4:
                    if (background->bgID == BACKGROUND_2 || background->bgID == BACKGROUND_3)
                        applyPosition = TRUE;
                    break;

                case GX_BGMODE_5:
                    if (background->bgID == BACKGROUND_2 || background->bgID == BACKGROUND_3)
                        applyPosition = TRUE;
                    break;

                default:
                    break;
            }

            if (applyPosition)
            {
                if (background->bgID == BACKGROUND_2)
                {
                    if ((background->flags & BACKGROUND_FLAG_SET_BG_X) != 0)
                        VRAMSystem__GFXControl[background->useEngineB]->affineA.x = bgPosition->x;

                    if ((background->flags & BACKGROUND_FLAG_SET_BG_Y) != 0)
                        VRAMSystem__GFXControl[background->useEngineB]->affineA.y = bgPosition->y;
                }
                else
                {
                    if ((background->flags & BACKGROUND_FLAG_SET_BG_X) != 0)
                        VRAMSystem__GFXControl[background->useEngineB]->affineB.x = bgPosition->x;

                    if ((background->flags & BACKGROUND_FLAG_SET_BG_Y) != 0)
                        VRAMSystem__GFXControl[background->useEngineB]->affineB.y = bgPosition->y;
                }
            }
        }
    }
}

void InitBackgroundDS(BackgroundDS *background, void *fileData, BackgroundFlags flags, BackgroundID bgID1, BackgroundID bgID2, u16 displayWidth, u16 displayHeight)
{
    MI_CpuClear32(background, sizeof(BackgroundDS));

    InitBackground(&background->work, fileData, flags, FALSE, bgID1, displayWidth, displayHeight);
    background->bgID[0]                 = bgID1;
    background->paletteMode[0]          = background->work.paletteMode;
    background->vramPalette[0]          = background->work.vramPalette;
    background->pixelMode[0]            = background->work.pixelMode;
    background->vramPixels[0]           = background->work.vramPixels;
    background->mappingsMode[0]         = background->work.mappingsMode;
    background->screenBaseA_Mappings[0] = background->work.screenBaseA_Mappings;
    background->screenBaseBlock[0]      = background->work.screenBaseBlock;
    background->offset[0].x             = background->work.offset.x;
    background->offset[0].y             = background->work.offset.y;

    InitBackground(&background->work, fileData, flags, TRUE, bgID2, displayWidth, displayHeight);
    background->bgID[1]                 = bgID2;
    background->paletteMode[1]          = background->work.paletteMode;
    background->vramPalette[1]          = background->work.vramPalette;
    background->pixelMode[1]            = background->work.pixelMode;
    background->vramPixels[1]           = background->work.vramPixels;
    background->mappingsMode[1]         = background->work.mappingsMode;
    background->screenBaseA_Mappings[1] = background->work.screenBaseA_Mappings;
    background->screenBaseBlock[1]      = background->work.screenBaseBlock;
    background->offset[1].x             = background->work.offset.x;
    background->offset[1].y             = background->work.offset.y;
}

void DrawBackgroundDS(BackgroundDS *background)
{
    background->work.useEngineB           = GRAPHICS_ENGINE_A;
    background->work.bgID                 = background->bgID[0];
    background->work.position.x           = background->position[0].x;
    background->work.position.y           = background->position[0].y;
    background->work.paletteMode          = background->paletteMode[0];
    background->work.vramPalette          = background->vramPalette[0];
    background->work.pixelMode            = background->pixelMode[0];
    background->work.vramPixels           = background->vramPixels[0];
    background->work.mappingsMode         = background->mappingsMode[0];
    background->work.screenBaseA_Mappings = background->screenBaseA_Mappings[0];
    background->work.screenBaseBlock      = background->screenBaseBlock[0];
    background->work.offset.x             = background->offset[0].x;
    background->work.offset.y             = background->offset[0].y;
    DrawBackground(&background->work);

    background->work.useEngineB           = GRAPHICS_ENGINE_B;
    background->work.bgID                 = background->bgID[1];
    background->work.position.x           = background->position[1].x;
    background->work.position.y           = background->position[1].y;
    background->work.paletteMode          = background->paletteMode[1];
    background->work.vramPalette          = background->vramPalette[1];
    background->work.pixelMode            = background->pixelMode[1];
    background->work.vramPixels           = background->vramPixels[1];
    background->work.mappingsMode         = background->mappingsMode[1];
    background->work.screenBaseA_Mappings = background->screenBaseA_Mappings[1];
    background->work.screenBaseBlock      = background->screenBaseBlock[1];
    background->work.offset.x             = background->offset[1].x;
    background->work.offset.y             = background->offset[1].y;
    DrawBackground(&background->work);
}

BOOL CheckBackgroundIsValid(void *fileData)
{
    return GetFile(fileData)->signature == '\0GBB';
}

BackgroundFormat GetBackgroundFormat(void *fileData)
{
    return (BackgroundFormat)(GetFile(fileData)->colorFormat & 0xF);
}

u16 GetBackgroundWidth(void *fileData)
{
    return GetFile(fileData)->width;
}

u16 GetBackgroundHeight(void *fileData)
{
    return GetFile(fileData)->height;
}

BOOL GetBackgroundFlag(void *fileData)
{
    return (GetFile(fileData)->colorFormat & 0x10) != 0;
}

u16 GetBackgroundTileCount(void *fileData)
{
    u32 offset = GetFile(fileData)->pixelOffset;
    if (offset == 0)
        return 0;

    switch ((BackgroundFormat)(GetFile(fileData)->colorFormat & 0xF))
    {
        case BBG_FORMAT_0:
            return ((MICompressionHeader *)GetFileBlock(fileData, offset))->destSize / 32; // 4bpp -> 1 byte has 2 colors

        case BBG_FORMAT_1:
        case BBG_FORMAT_2:
            return ((MICompressionHeader *)GetFileBlock(fileData, offset))->destSize / 64; // 8bpp -> 1 byte has 1 color

        case BBG_FORMAT_3:
        case BBG_FORMAT_4:
        case BBG_FORMAT_5:
        case BBG_FORMAT_6:
        default:
            return 0; // no pixel data in these formats
    }
}

BackgroundBlock *GetBackgroundPalette(void *fileData)
{
    u32 offset = GetFile(fileData)->paletteOffset;
    if (offset == 0)
        return NULL;

    return (BackgroundBlock *)GetFileBlock(fileData, offset);
}

BackgroundBlock *GetBackgroundPixels(void *fileData)
{
    u32 offset = GetFile(fileData)->pixelOffset;
    if (offset == 0)
        return NULL;

    return (BackgroundBlock *)GetFileBlock(fileData, offset);
}

BackgroundBlock *GetBackgroundMappings(void *fileData)
{
    u32 offset = GetFile(fileData)->mappingsOffset;
    if (offset == 0)
        return NULL;

    return (BackgroundBlock *)GetFileBlock(fileData, offset);
}

void InitBackgroundPixelsForCharacter(Background *background)
{
    u16 characterBaseA;
    u16 characterBaseBlock;

    background->pixelData = GetPixelsFromBackground(background);
    GetVRAMCharacterConfig(background->useEngineB, background->bgID, &characterBaseA, &characterBaseBlock);
    background->pixelMode  = PIXEL_MODE_SPRITE;
    background->vramPixels = (u32 *)&VRAMSystem__VRAM_BG[background->useEngineB][0x10000 * characterBaseA + 0x4000 * characterBaseBlock];
}

void InitBackgroundMappings(Background *background, u16 displayWidth, u16 displayHeight)
{
    background->mappingData = GetMappingsFromBackground(background);

    GetVRAMTileConfig(background->useEngineB, background->bgID, &background->mappingsMode, &background->screenBaseA_Mappings, &background->screenBaseBlock);
    background->offset.x      = 0;
    background->offset.y      = 0;
    background->displayWidth  = displayWidth;
    background->displayHeight = displayHeight;
}

void InitBackgroundPalette(Background *background)
{
    struct BBGHeader *header = GetFileFromBackground(background);
    background->paletteData  = GetPaletteFromBackground(background);
    GetVRAMPaletteConfig(background->useEngineB, background->bgID, &background->paletteMode, &background->vramPalette);

    background->vramPalette = (header->paletteRow * (sizeof(GXRgb) * 0x10)) + background->vramPalette + (header->paletteBank * (sizeof(GXRgb) * 0x100));
}

void InitBackgroundPixelsForScreen(Background *background, u16 displayWidth, u16 displayHeight)
{
    background->pixelData = GetPixelsFromBackground(background);
    GetVRAMPixelConfig(background->useEngineB, background->bgID, &background->pixelMode, &background->screenBaseBlock);

    int baseBlock             = 0x4000 * background->screenBaseBlock;
    background->vramPixels    = (void *)((int)(void *)VRAMSystem__VRAM_BG[background->useEngineB] + baseBlock);
    background->displayWidth  = displayWidth;
    background->displayHeight = displayHeight;
}