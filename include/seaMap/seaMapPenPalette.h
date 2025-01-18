#ifndef RUSH_SEAMAPPENPALETTE_H
#define RUSH_SEAMAPPENPALETTE_H

#include <seaMap/seaMapView.h>

// --------------------
// ENUMS
// --------------------

// --------------------
// STRUCTS
// --------------------

typedef struct SeaMapMenu_
{
    BOOL useEngineB;
    u32 mode;
    GXRgb palette1[256];
    GXRgb palette2[256];
    GXRgb paletteStore1[256];
    GXRgb paletteStore2[256];
    u16 timer;
    u16 field_80C;
    u8 _unused[720];
} SeaMapMenu;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void SeaMapPenPalette__Create(SeaMapView *parent);
NOT_DECOMPILED void SeaMapPenPalette__Destroy(Task *task);
NOT_DECOMPILED u32 SeaMapPenPalette__GetMode(Task *task);
NOT_DECOMPILED void SeaMapPenPalette__SetMode(Task *task, u32 mode);
NOT_DECOMPILED void SeaMapPenPalette__Main(void);
NOT_DECOMPILED void SeaMapPenPalette__Destructor(Task *task);

#endif // RUSH_SEAMAPPENPALETTE_H