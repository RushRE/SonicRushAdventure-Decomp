#ifndef RUSH2_PALETTE_QUEUE_H
#define RUSH2_PALETTE_QUEUE_H

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

// Unknown
void Palette__UnknownFunc9(u16 *colorPtr, u16 *palettePtr, u32 count, u16 a4);
void Palette__UnknownFunc10(u16 *colorPtr, u16 *palettePtr, u32 count, s32 a4);
void Palette__UnknownFunc11(u16 *result, u16 *colorPtr, u16 *palettePtr, s32 count, u8 a5);

#endif // RUSH2_PALETTE_QUEUE_H
