#ifndef RUSH2_WATERSURFACE_H
#define RUSH2_WATERSURFACE_H

#include <game/system/task.h>
#include <game/graphics/sprite.h>
#include <game/graphics/paletteAnimation.h>

// --------------------
// STRUCTS
// --------------------

struct WaterSurfaceStaticVars
{
    u32 flags;
    Task *task;
    u16 paletteSize1;
    u16 paletteSize2;
    u16 vAlarmCount[2];
    u16 palette1[256];
    u16 palette2[256];
    u16 altPalette1[256];
    u16 altPalette2[256];
    OSVAlarm vAlarm[2];
    s32 field_860[41];
    AnimatorSprite aniWaterSurface1[2];
    PaletteAnimator *aniPalette;
};

// --------------------
// VARIABLES
// --------------------

NOT_DECOMPILED struct WaterSurfaceStaticVars *WaterSurface__sVars;

// --------------------
// FUNCTIONS
// --------------------

// WaterSurface Management
void WaterSurface__Init(void);
void WaterSurface__Release(void);
void WaterSurface__Process(void);

// WaterSurface
void WaterSurface__Create(void);
void WaterSurface__ReleaseCommon(void);
void WaterSurface__Func_200DF78(void);
void WaterSurface__Main(void);
void WaterSurface__VAlarmCB_200E26C(void *useEngineB);
void WaterSurface__VAlarmCB_200E2CC(void *useEngineB);
void WaterSurface__InitPalette(u16 *palettePtr, u32 count);
void WaterSurface__CopyPalette(BOOL useEngineB);
void WaterSurface__CopyAltPalette(BOOL useEngineB);

#endif // RUSH2_WATERSURFACE_H