#ifndef RUSH2_BINARYBUNDLE_H
#define RUSH2_BINARYBUNDLE_H

#include <global.h>
#include <game/system/allocator.h>
#include <game/graphics/renderCore.h>

// --------------------
// CONSTANTS
// --------------------

#define BINARYBUNDLE_AUTO_ALLOC_HEAD ((void *)(size_t)0)
#define BINARYBUNDLE_AUTO_ALLOC_TAIL ((void *)(size_t)-1)

// --------------------
// STRUCTS
// --------------------

typedef struct BBHeader_
{
    u32 signature;
    u32 fileCount;
    // BBFile files[fileCount];
} BBHeader;

typedef struct BBFile_
{
    u32 offset;
    u32 size;
} BBFile;

// --------------------
// FUNCTIONS
// --------------------

void InitBinaryBundleSystem(void);
u32 GetBundleFileSize(const char *path, u16 id);
void *ReadFileFromBundle(const char *path, u16 id, void *memory);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void GetCompressedFileFromBundle(const char *bundlePath, u16 fileID, void **memory, BOOL fromTail)
{
    void *compressedData = ReadFileFromBundle(bundlePath, fileID, fromTail ? BINARYBUNDLE_AUTO_ALLOC_TAIL : BINARYBUNDLE_AUTO_ALLOC_HEAD);
    if (fromTail)
    {
        (*memory) = (NNSiFndArchiveHeader *)HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(compressedData));
    }
    else
    {
        (*memory) = (NNSiFndArchiveHeader *)HeapAllocTail(HEAP_USER, MI_GetUncompressedSize(compressedData));
    }
    RenderCore_CPUCopyCompressed(compressedData, (*memory));
    HeapFree(HEAP_USER, compressedData);
}

#endif // RUSH2_BINARYBUNDLE_H
