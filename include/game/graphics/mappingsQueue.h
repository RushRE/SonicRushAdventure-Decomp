#ifndef RUSH2_MAPPINGS_QUEUE_H
#define RUSH2_MAPPINGS_QUEUE_H

#include <game/system/queue.h>

// --------------------
// FUNCTIONS
// --------------------

enum MappingsMode_
{
    MAPPINGS_MODE_TEXT_256x256_A,
    MAPPINGS_MODE_TEXT_512x256_A,
    MAPPINGS_MODE_TEXT_256x512_A,
    MAPPINGS_MODE_TEXT_512x512_A,
    MAPPINGS_MODE_AFFINE_128x128_A,
    MAPPINGS_MODE_AFFINE_256x256_A,
    MAPPINGS_MODE_AFFINE_512x512_A,
    MAPPINGS_MODE_AFFINE_1024x1024_A,
    MAPPINGS_MODE_256x16PLTT_128x128_A,
    MAPPINGS_MODE_256x16PLTT_256x256_A,
    MAPPINGS_MODE_256x16PLTT_512x512_A,
    MAPPINGS_MODE_256x16PLTT_1024x1024_A,

    MAPPINGS_MODE_TEXT_256x256_B,
    MAPPINGS_MODE_TEXT_512x256_B,
    MAPPINGS_MODE_TEXT_256x512_B,
    MAPPINGS_MODE_TEXT_512x512_B,
    MAPPINGS_MODE_AFFINE_128x128_B,
    MAPPINGS_MODE_AFFINE_256x256_B,
    MAPPINGS_MODE_AFFINE_512x512_B,
    MAPPINGS_MODE_AFFINE_1024x1024_B,
    MAPPINGS_MODE_256x16PLTT_128x128_B,
    MAPPINGS_MODE_256x16PLTT_256x256_B,
    MAPPINGS_MODE_256x16PLTT_512x512_B,
    MAPPINGS_MODE_256x16PLTT_1024x1024_B,
};
typedef u32 MappingsMode;

// --------------------
// FUNCTIONS
// --------------------

// Management
void InitMappingsQueueSystem(void);
void Mappings__ReadList(void);

// Queueing
void Mappings__ReadMappingsCompressed(void *srcMappingsPtr, fx32 x, fx32 y, s32 width, s32 flag, MappingsMode mode, u16 screenBaseA, u16 screenBaseBlock, u16 offsetX, u16 offsetY,
                                      u16 displayWidth, u16 displayHeight);
void Mappings__LoadUnknown(void *srcMappingsPtr, fx32 x, fx32 y, s32 width, s32 flag, MappingsMode mode, u16 screenBaseA, u16 screenBaseBlock, u16 offsetX, u16 offsetY,
                           u16 displayWidth, u16 displayHeight);
void Mappings__ReadMappings2(void *srcMappingsPtr, fx32 x, fx32 y, s32 width, s32 flag, MappingsMode mode, u16 screenBaseA, u16 screenBaseBlock, u16 offsetX, u16 offsetY,
                             u16 displayWidth, u16 displayHeight);
void Mappings__ReadMappings(void *srcMappingsPtr, fx32 x, fx32 y, s32 width, s32 flag, MappingsMode mode, u16 screenBaseA, u16 screenBaseBlock, u16 offsetX, u16 offsetY,
                            u16 displayWidth, u16 displayHeight);
void Mappings__ClearQueue(void);

#endif // RUSH2_MAPPINGS_QUEUE_H
