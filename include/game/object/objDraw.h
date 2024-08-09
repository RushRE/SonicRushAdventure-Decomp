#ifndef RUSH2_OBJ_DRAW_H
#define RUSH2_OBJ_DRAW_H

#include <global.h>

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

extern GXRgb ObjDraw__Palette1[0x100];
extern GXRgb ObjDraw__Palette2[0x100];

// --------------------
// FUNCTIONS
// --------------------

void ObjDrawInit(void);
void ObjDrawFunc_2074F94(void);
void ObjDrawFunc_2074FB0(u8 a1, u8 a2);
void ObjDrawReleaseSpritePalette(u8 a1);
void ObjDrawFunc_2075028(u8 a1);
u8 ObjDrawAllocSpritePalette(void *fileData, u16 animID, s16 flags);
void ObjDraw__TintSprite(void *fileData, u16 animID, u8 row, BOOL useEngineB);
GXRgb ObjDraw__TintColor(GXRgb inputColor, s16 iR, s16 iG, s16 iB);
void ObjDraw__TintPaletteRow(u32 row, s16 iR, s16 iG, s16 iB);
void ObjDraw__TintPaletteColors(u32 row, u32 start, u32 end, s16 iR, s16 iG, s16 iB);
void ObjDraw__PaletteTex__Init(NNSG3dResFileHeader *fileData, PaletteTexture *paletteTex);
void ObjDraw__PaletteTex__Release(PaletteTexture *paletteTex);
void ObjDraw__PaletteTex__Process(PaletteTexture *paletteTex, s16 iR, s16 iG, s16 iB);
void ObjDrawFunc_207568C(s32 a1);
void ObjDrawFunc_2075704(s32 a1);
void ObjDraw__GetHWPaletteRow(u32 a1);
void ObjDraw__ChangeColors(GXRgb *colorDst, GXRgb *colorSrc1, GXRgb *colorSrc2, s32 count, u16 tint);
void ObjDraw__TintColorArray(GXRgb *colorDst, GXRgb *colorSrc, s16 iR, s16 iG, s16 iB, u16 count);

#endif // RUSH2_OBJ_DRAW_H
