#ifndef RUSH_COMPRESSEDFILE_H
#define RUSH_COMPRESSEDFILE_H

#include <global.h>
#include <game/file/fsRequest.h>

// --------------------
// CONSTANTS
// --------------------

#define COMPRESSEDFILE_AUTO_ALLOC_HEAD ((void *)(size_t)0)
#define COMPRESSEDFILE_AUTO_ALLOC_TAIL ((void *)(size_t) - 1)

// --------------------
// STRUCTS
// --------------------

typedef struct CompressedVISFileHeader_
{
  u32 signature;
  u32 destSize : 24;
  u32 unknownCount : 4;
  u32 unused1 : 4;
  u32 unknownSize : 24;
  u32 unused2 : 8;
  u8 data[1]; // C-style variable array
} CompressedVISFileHeader;


// --------------------
// FUNCTIONS
// --------------------

void *CompressedFile__Decompress(void *src, void *dst, void *buffer);
size_t CompressedFile__GetCompressedSize(void *memory);

#endif // RUSH_COMPRESSEDFILE_H
