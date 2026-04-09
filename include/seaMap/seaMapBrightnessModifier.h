#ifndef RUSH_SEAMAPBRIGHTNESSMODIFIER_H
#define RUSH_SEAMAPBRIGHTNESSMODIFIER_H

#include <seaMap/seaMapView.h>

// --------------------
// ENUMS
// --------------------

enum SeaMapBrightnessModifierMode_
{
    SEAMAPBRIGHTNESSMODIFIER_MODE_IDLE,
    SEAMAPBRIGHTNESSMODIFIER_MODE_DARKEN,
    SEAMAPBRIGHTNESSMODIFIER_MODE_BRIGHTEN,
};
typedef u32 SeaMapBrightnessModifierMode;

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapBrightnessModifier_
{
    GraphicsEngine graphicsEngine;
    SeaMapBrightnessModifierMode mode;
    GXRgb originalPaletteBG[256];
    GXRgb originalPaletteOBJ[256];
    GXRgb activePaletteBG[256];
    GXRgb activePaletteOBJ[256];
    u16 timer;
} SeaMapBrightnessModifier;

// --------------------
// FUNCTIONS
// --------------------

Task *CreateSeaMapBrightnessModifier(SeaMapView *parent);
void DestroySeaMapBrightnessModifier(Task *task);
SeaMapBrightnessModifierMode GetSeaMapBrightnessModifierMode(Task *task);
void SetSeaMapBrightnessModifierMode(Task *task, SeaMapBrightnessModifierMode mode);

#endif // RUSH_SEAMAPBRIGHTNESSMODIFIER_H