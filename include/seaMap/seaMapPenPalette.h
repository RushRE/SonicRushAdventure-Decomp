#ifndef RUSH_SEAMAPPENPALETTE_H
#define RUSH_SEAMAPPENPALETTE_H

#include <seaMap/seaMapView.h>

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapPenPalette_
{
    BOOL useEngineB;
    u32 mode;
    GXRgb paletteBG[256];
    GXRgb paletteOBJ[256];
    GXRgb paletteStoreBG[256];
    GXRgb paletteStoreOBJ[256];
    u16 timer;
} SeaMapPenPalette;

// --------------------
// FUNCTIONS
// --------------------

Task *CreateSeaMapPenPalette(SeaMapView *parent);
void DestroySeaMapPenPalette(Task *task);
u32 GetSeaMapPenPaletteMode(Task *task);
void SetSeaMapPenPaletteMode(Task *task, u32 mode);

#endif // RUSH_SEAMAPPENPALETTE_H