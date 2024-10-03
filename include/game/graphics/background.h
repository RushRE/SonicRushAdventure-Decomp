#ifndef RUSH2_BACKGROUND_H
#define RUSH2_BACKGROUND_H

#include <global.h>
#include <game/graphics/paletteQueue.h>
#include <game/graphics/mappingsQueue.h>
#include <game/graphics/pixelsQueue.h>
#include <game/math/mtMath.h>

// --------------------
// CONSTANTS
// --------------------

#define BG_DISPLAY_FULL_WIDTH       (HW_LCD_WIDTH / 8)                // cover entire screen horizontally
#define BG_DISPLAY_SINGLE_HEIGHT    (HW_LCD_HEIGHT / 8)               // cover one entire screen vertically
#define BG_DISPLAY_SINGLE_HEIGHT_EX ((HW_LCD_HEIGHT + 64) / 8)        // cover one entire screen vertically + 64 padding pixels
#define BG_DISPLAY_DOUBLE_HEIGHT    (BG_DISPLAY_SINGLE_HEIGHT_EX * 2) // cover both screens vertically

#define BG_DISPLAY_SINGLE_TILE_SIZE (BG_DISPLAY_FULL_WIDTH * BG_DISPLAY_SINGLE_HEIGHT_EX) // amount of tiles needed for single (ex) displays
#define BG_DISPLAY_DOUBLE_TILE_SIZE (BG_DISPLAY_FULL_WIDTH * BG_DISPLAY_DOUBLE_HEIGHT)    // amount of tiles needed for double displays

// --------------------
// ENUMS
// --------------------

enum BackgroundFlags_
{
    BACKGROUND_FLAG_NONE = 0x00,

    BACKGROUND_FLAG_DISABLE_PALETTE   = 1 << 0,
    BACKGROUND_FLAG_DISABLE_PIXELS    = 1 << 1,
    BACKGROUND_FLAG_DISABLE_MAPPINGS  = 1 << 2,
    BACKGROUND_FLAG_LOAD_PALETTE      = 1 << 3, // Load Palette when calling DrawBackground instead of waiting for the next vblank
    BACKGROUND_FLAG_LOAD_PIXELS       = 1 << 4, // Load Pixels when calling DrawBackground instead of waiting for the next vblank
    BACKGROUND_FLAG_LOAD_MAPPINGS     = 1 << 5, // Load Mappings when calling DrawBackground instead of waiting for the next vblank
    BACKGROUND_FLAG_ALIGN_EVEN_WIDTH  = 1 << 6,
    BACKGROUND_FLAG_ALIGN_EVEN_HEIGHT = 1 << 7,
    BACKGROUND_FLAG_SET_BG_X          = 1 << 8,
    BACKGROUND_FLAG_SET_BG_Y          = 1 << 9,

    // helpers

    // Load all graphics data
    BACKGROUND_FLAG_LOAD_MAPPINGS_PALETTE = BACKGROUND_FLAG_LOAD_PALETTE | BACKGROUND_FLAG_LOAD_MAPPINGS,
    BACKGROUND_FLAG_LOAD_MAPPINGS_PIXELS  = BACKGROUND_FLAG_LOAD_PIXELS | BACKGROUND_FLAG_LOAD_MAPPINGS,
    BACKGROUND_FLAG_LOAD_ALL              = BACKGROUND_FLAG_LOAD_PALETTE | BACKGROUND_FLAG_LOAD_PIXELS | BACKGROUND_FLAG_LOAD_MAPPINGS,
};
typedef u32 BackgroundFlags;

enum BackgroundFormat_
{
    BBG_FORMAT_0,
    BBG_FORMAT_1,
    BBG_FORMAT_2,
    BBG_FORMAT_3,
    BBG_FORMAT_4,
    BBG_FORMAT_5,
    BBG_FORMAT_6,
};
typedef u32 BackgroundFormat;

enum BackgroundID_
{
    BACKGROUND_0,
    BACKGROUND_1,
    BACKGROUND_2,
    BACKGROUND_3,
};
typedef u8 BackgroundID;

// --------------------
// STRUCTS
// --------------------

typedef struct Background_
{
    BackgroundFlags flags;
    void *fileData;
    Vec2Fx32 position;
    BOOL useEngineB;
    u8 bgID;
    PaletteMode paletteMode;
    void *vramPalette;
    PixelMode pixelMode;
    void *vramPixels;
    MappingsMode mappingsMode;
    u16 screenBaseA_Mappings;
    u16 screenBaseBlock;
    Vec2U16 offset;
    u16 displayWidth;
    u16 displayHeight;
    void *paletteData;
    void *pixelData;
    void *mappingData;
    u16 width;
    u16 height;
} Background;

typedef struct BackgroundDS_
{
    Background work;

    Vec2Fx32 position[2];
    u8 bgID[2];
    PaletteMode paletteMode[2];
    void *vramPalette[2];
    PixelMode pixelMode[2];
    void *vramPixels[2];
    u32 mappingsMode[2];
    u16 screenBaseA_Mappings[2];
    u16 screenBaseBlock[2];
    Vec2U16 offset[2];
} BackgroundDS;

// --------------------
// FUNCTIONS
// --------------------

void InitBackgroundSystem(void);
void InitBackgroundEx(Background *background, void *fileData, BackgroundFlags flags, BOOL useEngineB, BackgroundID bgID, s32 paletteMode, void *vramPalette, s32 pixelMode,
                      void *vramPixels, s32 mappingsMode, u16 screenBaseA_Mappings, u16 screenBaseBlock, u16 offsetX, u16 offsetY, u16 displayWidth, u16 displayHeight);
void InitBackground(Background *background, void *fileData, BackgroundFlags flags, BOOL useEngineB, BackgroundID bgID, u16 displayWidth, u16 displayHeight);
void DrawBackground(Background *background);
void InitBackgroundDS(BackgroundDS *background, void *fileData, BackgroundFlags flags, BackgroundID bgID1, BackgroundID bgID2, u16 displayWidth, u16 displayHeight);
void DrawBackgroundDS(BackgroundDS *background);
BOOL CheckBackgroundIsValid(void *fileData);
BackgroundFormat GetBackgroundFormat(void *fileData);
u16 GetBackgroundWidth(void *fileData);
u16 GetBackgroundHeight(void *fileData);
BOOL GetBackgroundFlag(void *fileData);
u16 GetBackgroundTileCount(void *fileData);
void *GetBackgroundPalette(void *fileData);
void *GetBackgroundPixels(void *fileData);
void *GetBackgroundMappings(void *fileData);

#endif // RUSH2_BACKGROUND_H
