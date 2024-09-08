#ifndef RUSH2_OBJ_DRAW_H
#define RUSH2_OBJ_DRAW_H

#include <global.h>

// --------------------
// ENUMS
// --------------------

enum ObjDrawSpriteFlags
{
    OBJDRAW_SPRITE_FLAG_USE_ENGINE_A = 0x400,
    OBJDRAW_SPRITE_FLAG_USE_ENGINE_B = 0x800,
    OBJDRAW_SPRITE_FLAG_1000         = 0x1000,
    OBJDRAW_SPRITE_FLAG_2000         = 0x2000,
    OBJDRAW_SPRITE_FLAG_4000         = 0x4000,
    OBJDRAW_SPRITE_FLAG_8000         = 0x8000,
};

// --------------------
// STRUCTS
// --------------------

typedef struct PaletteTexture_
{
  u16 *palettePtr1;
  u16 *palettePtr2;
  const NNSG3dResTex *texture;
} PaletteTexture;

// --------------------
// VARIABLES
// --------------------

extern GXRgb objDrawPalette1[0x100];
extern GXRgb objDrawPalette2[0x100];

// --------------------
// FUNCTIONS
// --------------------

void ObjDrawInit(void);
void ObjDrawInitRows(void);
void ObjDrawSetManagedRows(u8 managedRowStart, u8 managedRowEnd);
void ObjDrawReleaseSpritePalette(u8 row);
u8 ObjDrawReleaseSprite(u8 a1);
u8 ObjDrawAllocSpritePalette(void *fileData, u16 animID, s16 flags);
void ObjDraw__TintSprite(void *fileData, u16 animID, u8 row, BOOL useEngineB);
GXRgb ObjDraw__TintColor(GXRgb inputColor, s16 iR, s16 iG, s16 iB);
void ObjDraw__TintPaletteRow(u32 row, s16 iR, s16 iG, s16 iB);
void ObjDraw__TintPaletteColors(u32 row, u32 start, u32 end, s16 iR, s16 iG, s16 iB);
void ObjDraw__PaletteTex__Init(NNSG3dResFileHeader *fileData, PaletteTexture *paletteTex);
void ObjDraw__PaletteTex__Release(PaletteTexture *paletteTex);
void ObjDraw__PaletteTex__Process(PaletteTexture *paletteTex, s16 iR, s16 iG, s16 iB);
u8 ObjDrawGetRowForID(u8 id);
GXRgb *ObjDrawGetPaletteForID(u8 id);
GXRgb *ObjDraw__GetHWPaletteRow(u8 id);
void ObjDraw__ChangeColors(GXRgb *colorDst, GXRgb *colorSrc1, GXRgb *colorSrc2, s32 count, u16 tint);
void ObjDraw__TintColorArray(GXRgb *colorDst, GXRgb *colorSrc, s16 iR, s16 iG, s16 iB, s16 count);

#endif // RUSH2_OBJ_DRAW_H
