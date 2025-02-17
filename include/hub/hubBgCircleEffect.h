#ifndef RUSH_HUBBGCIRCLEEFFECT_H
#define RUSH_HUBBGCIRCLEEFFECT_H

#include <game/graphics/background.h>
#include <game/graphics/vramSystem.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

typedef struct HubBGCircleEffect_
{
    u32 flags;
    u32 animationTimer;
    Vec2Fx16 position;
    s16 scale;
    s16 percent;
    u16 useEngineB;
    u16 bgID;
    u16 frame;
    GXScrText32x32 *mappings;
    GXRgb *palette;
    void *background;
} HubBGCircleEffect;

typedef struct HubConstructionCompletePulse_
{
    u32 flags;
    VRAMPaletteKey vramPalette;
    GXRgb color;
} HubConstructionCompletePulse;

// --------------------
// FUNCTIONS
// --------------------

// HubBGCircleEffect
void InitHubBGCircleEffect(HubBGCircleEffect *work);
void LoadHubBGCircleEffect(HubBGCircleEffect *work, void *background, u32 flags, u16 useEngineB, u16 bgID, u16 paletteRow);
void ReleaseHubBGCircleEffect(HubBGCircleEffect *work);
void ProcessHubBGCircleEffect(HubBGCircleEffect *work);
void SetHubBGCircleEffectPosition(HubBGCircleEffect *work, s16 x, s16 y);
void SetHubBGCircleEffectScale(HubBGCircleEffect *work, fx32 scale);
void SetHubBGCircleEffectBrightness(HubBGCircleEffect *work, s16 percent);
void InitHubBGCircleEffectTiles(GXScrText32x32 *mappings, u32 paletteRow);
void InitHubBGCircleEffectPalette(GXRgb *colors, void *background, fx32 percent);

// HubConstructionCompletePulse
void InitHubConstructionCompletePulse(HubConstructionCompletePulse *work, s32 flags, BOOL useEngineB, u16 bgID, u16 paletteRow);
void DrawHubConstructionCompletePulse(HubConstructionCompletePulse *work, GXRgb color);

#ifdef __cplusplus
}
#endif

#endif // RUSH_HUBBGCIRCLEEFFECT_H