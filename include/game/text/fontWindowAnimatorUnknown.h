
#ifndef RUSH_FONTWINDOWANIMATORUNKNOWN_H
#define RUSH_FONTWINDOWANIMATORUNKNOWN_H

#include <global.h>

// --------------------
// STRUCTS
// --------------------

struct FontWindowTiles
{
    u16 tiles[80][16];
};

typedef struct FontWindowAnimatorUnknown_
{
    u32 flags;
    s16 field_4;
    s16 field_6;
    u16 field_8;
    u16 field_A;
    void *fileData;
    u32 archiveID;
    u32 funcID;
    BOOL useEngineB;
    u16 bgID;
    u16 paletteRow;
    u16 priority;
    u16 flags2;
    u16 flags3;
    u16 dynamicBGTileCount;
    struct FontWindowTiles *dynamicBG;
    u16 *vramPixels;
    s16 field_30;
    s16 field_32;
    u16 field_34;
    u16 field_36;
} FontWindowAnimatorUnknown;

// --------------------
// FUNCTIONS
// --------------------

#endif // RUSH_FONTWINDOWANIMATORUNKNOWN_H
