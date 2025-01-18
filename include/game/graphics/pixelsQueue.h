#ifndef RUSH_PIXELS_QUEUE_H
#define RUSH_PIXELS_QUEUE_H

#include <game/system/queue.h>

// --------------------
// ENUMS
// --------------------

enum PixelMode_
{
    PIXEL_MODE_SPRITE,
    PIXEL_MODE_TEXTURE,
    PIXEL_MODE_BG_TEXT_256x256,
    PIXEL_MODE_BG_TEXT_512x256,
    PIXEL_MODE_BG_TEXT_256x512,
    PIXEL_MODE_BG_TEXT_512x512,
    PIXEL_MODE_BG_LARGEBMP_512x1024,
    PIXEL_MODE_BG_LARGEBMP_1024x512,
    PIXEL_MODE_BG_DCBMP_128x128,
    PIXEL_MODE_BG_DCBMP_256x256,
    PIXEL_MODE_BG_DCBMP_512x256,
    PIXEL_MODE_BG_DCBMP_512x512,

    PIXEL_MODE_COUNT,
};
typedef u32 PixelMode;

// --------------------
// FUNCTIONS
// --------------------

// Management
void InitPixelsQueueSystem(void);

// Queueing
void ProcessSpritePixelQueue(void);
void ProcessTexturePixelQueue(void);
void QueueUncompressedPixels(void *pixels, size_t pixelByteSize, PixelMode mode, void *vramPixels);
void LoadUncompressedPixels(void *pixels, size_t pixelByteSize, PixelMode mode, void *vramPixels);
void QueueCompressedPixels(void *pixels, PixelMode mode, void *vramPixels);
void LoadCompressedPixels(void *pixels, PixelMode mode, void *vramPixels);
void QueueBackgroundPixels(void *pixels, s32 x, s32 y, s32 width, PixelMode mode, void *vramPixels, u16 bgPlaceX, u16 bgPlaceY, u16 displayWidth, u16 displayHeight);
void QueueCompressedBackgroundPixels(void *pixels, u16 x, u16 y, u16 width, PixelMode mode, void *vramPixels, u16 bgPlaceX, u16 bgPlaceY, u16 displayWidth, u16 displayHeight);
void LoadCompressedBackgroundPixels(void *pixels, u16 x, u16 y, u16 width, PixelMode mode, void *vramPixels, u16 bgPlaceX, u16 bgPlaceY, u16 displayWidth, u16 displayHeight);
void ClearPixelsQueue(void);

#endif // RUSH_PIXELS_QUEUE_H
