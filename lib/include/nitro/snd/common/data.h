#ifndef NITRO_SND_COMMON_DATA_H
#define NITRO_SND_COMMON_DATA_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct SNDBinaryFileHeader
{
    char signature[4];
    u16 byteOrder;
    u16 version;
    u32 fileSize;
    u16 headerSize;
    u16 dataBlocks;
} SNDBinaryFileHeader;

typedef struct SNDBinaryBlockHeader
{
    u32 kind;
    u32 size;
} SNDBinaryBlockHeader;

#ifdef __cplusplus
}
#endif

#endif // NITRO_SND_COMMON_DATA_H
