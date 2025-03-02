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
// FUNCTIONS
// --------------------

void *CompressedFile__Decompress(void *src, void *dst, void *buffer);
BOOL CompressedFile__IsVisAnim(void *memory);
u8 CompressedFile__GetVisCompressCount(void *memory);
size_t CompressedFile__GetCompressedSize(void *memory);
size_t CompressedFile__GetUnknownSize(void *memory);
void *CompressedFile__GetUnknown2Size(void *memory);
void *CompressedFile__AllocateMemIfNeeded(void *memory, size_t size);
void CompressedFile__HandleDecompression2(void *src, void *dst, u8 flags);
void CompressedFile__HandleDecompression(void *src, void *dst, u8 flags);

#endif // RUSH_COMPRESSEDFILE_H
