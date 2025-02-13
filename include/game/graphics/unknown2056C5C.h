#ifndef RUSH_UNKNOWN2056C5C_H
#define RUSH_UNKNOWN2056C5C_H

#include <game/graphics/pixelsQueue.h>
#include <game/graphics/paletteQueue.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct Unknown2056C5C_
{
    u16 flags1;
    u16 flags2;
    u16 x1;
    u16 y1;
    u16 x2;
    u16 y2;
    u16 field_C;
    u16 field_E;
    u16 field_10;
    u16 field_12;
    BOOL useEngineB;
    u16 width;
    u16 height;
    void *pixelsPtr;
    PixelMode pixelMode;
    void *dstPixels;
    u16 *palettePtr;
    PaletteMode paletteMode;
    u16 *dstPalette;
    u16 paletteBank;
    u16 paletteEntry;
    u16 colorCount;
    u8 priority;
    u8 order;
    u32 mode;
} Unknown2056C5C;

typedef struct Unknown2056FDC_
{
    Unknown2056C5C work;
    u16 unknownCount;
    u16 field_42;
    Unknown2056C5C *unknownList;
} Unknown2056FDC;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void Unknown2056C5C__Init(Unknown2056C5C *work);
NOT_DECOMPILED void Unknown2056C5C__Func_2056C84(Unknown2056C5C *work);
NOT_DECOMPILED void Unknown2056C5C__Release(Unknown2056C5C *work);
NOT_DECOMPILED void Unknown2056C5C__Func_2056E08(Unknown2056C5C *work);
NOT_DECOMPILED void Unknown2056C5C__Func_2056F78(Unknown2056C5C *work);

NOT_DECOMPILED void Unknown2056FDC__Init(Unknown2056FDC *work);
NOT_DECOMPILED void Unknown2056FDC__Func_2057004(Unknown2056FDC *work);
NOT_DECOMPILED void Unknown2056FDC__Release(Unknown2056FDC *work);
NOT_DECOMPILED void Unknown2056FDC__Func_2057460(Unknown2056FDC *work, BOOL a2, BOOL a3);
NOT_DECOMPILED void Unknown2056FDC__Func_2057484(Unknown2056FDC *work);
NOT_DECOMPILED void Unknown2056FDC__Func_2057614(Unknown2056FDC *work);

NOT_DECOMPILED void Unknown2056C5C__AllocSprite(Unknown2056C5C *work);
NOT_DECOMPILED void Unknown2056C5C__AddSprite1(Unknown2056C5C *work);
NOT_DECOMPILED void Unknown2056C5C__AddSprite2(Unknown2056C5C *work);
NOT_DECOMPILED void Unknown2056C5C__GetSpriteSize(Unknown2056C5C *work);
NOT_DECOMPILED void Unknown2056C5C__AddAffineSprite(Unknown2056C5C *work);

#ifdef __cplusplus
}
#endif

#endif // RUSH_UNKNOWN2056C5C_H