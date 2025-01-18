#ifndef RUSH_PALETTE_QUEUE_H
#define RUSH_PALETTE_QUEUE_H

#include <game/system/queue.h>

// --------------------
// ENUMS
// --------------------

enum PaletteMode_
{
    PALETTE_MODE_SPRITE,
    PALETTE_MODE_BG,
    PALETTE_MODE_OBJ,
    PALETTE_MODE_SUB_BG,
    PALETTE_MODE_SUB_OBJ,
    PALETTE_MODE_TEXTURE,
};
typedef u32 PaletteMode;

// --------------------
// FUNCTIONS
// --------------------

// Management
void InitPaletteQueueSystem(void);
void ProcessSpritePaletteQueue(void);
void ProcessTexturePaletteQueue(void);
void ProcessBackgroundPaletteQueue(void);

// Queueing
void QueueUncompressedPalette(void *srcPalettePtr, u16 colorCount, PaletteMode mode, size_t dstPalettePtr);
void LoadUncompressedPalette(void *srcPalettePtr, u16 colorCount, PaletteMode mode, size_t dstPalettePtr);
void QueueCompressedPalette(void *srcPalettePtr, PaletteMode mode, size_t dstPalettePtr);
void LoadCompressedPalette(void *srcPalettePtr, PaletteMode mode, size_t dstPalettePtr);
void ClearPaletteQueue(void);

// Color modification
void BrightenColors(GXRgb *srcColors, GXRgb *dstColors, u16 colorCount, u8 brightness);
void DarkenColors(GXRgb *srcColors, GXRgb *dstColors, u16 colorCount, u8 brightness);
void LerpColors(GXRgb *startColors, GXRgb *targetColors, GXRgb *dstColors, u16 colorCount, u8 speed);

#endif // RUSH_PALETTE_QUEUE_H
