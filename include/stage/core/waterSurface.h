#ifndef RUSH2_WATERSURFACE_H
#define RUSH2_WATERSURFACE_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>

// --------------------
// ENUMS
// --------------------

enum WaterSurfaceFlags_
{
    WATERSURFACE_FLAG_NONE = 0x00,

    WATERSURFACE_FLAG_HAS_SPRITE_UNDERWATER_PALETTE = 1 << 0,
    WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_1      = 1 << 1,
    WATERSURFACE_FLAG_HAS_UNDERWATER_PALETTE_2      = 1 << 2,
    WATERSURFACE_FLAG_HAS_WATER_SURFACE             = 1 << 3,
    WATERSURFACE_FLAG_10                            = 1 << 4,
    WATERSURFACE_FLAG_20                            = 1 << 5,
    WATERSURFACE_FLAG_40                            = 1 << 6,

    WATERSURFACE_FLAG_10000 = 1 << 16,
    WATERSURFACE_FLAG_20000 = 1 << 17,
};
typedef u32 WaterSurfaceFlags;

// --------------------
// STRUCTS
// --------------------

struct WaterSurfaceWork
{
    WaterSurfaceFlags flags;
    Task *task;
    u16 paletteSize1;
    u16 paletteSize2;
    u16 vAlarmCount[2];
    GXRgb surfacePalette1[256];
    GXRgb surfacePalette2[256];
    GXRgb underwaterPalette1[256];
    GXRgb underwaterPalette2[256];
    OSVAlarm vAlarm[2];
    AnimatorSpriteDS aniUnknown;
    AnimatorSprite aniWaterSurface[2];
    void *controlConfig;
};

// --------------------
// FUNCTIONS
// --------------------

// WaterSurface Management
void InitWaterSurface(void);
void ReleaseWaterSurface(void);
void ProcessWaterSurface(void);

#endif // RUSH2_WATERSURFACE_H