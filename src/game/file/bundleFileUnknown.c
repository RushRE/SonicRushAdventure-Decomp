#include <game/file/bundleFileUnknown.h>
#include <game/file/fsRequest.h>
#include <game/file/binaryBundle.h>

// --------------------
// FUNCTIONS
// --------------------

void *BundleFileUnknown__LoadFile(const char *path, void *memory)
{
    void *compressedMemory = FSRequestFileSync(path, FSREQ_AUTO_ALLOC_TAIL);

    if (memory == BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD)
    {
        memory = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(compressedMemory));
    }
    else if (memory == BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL)
    {
        memory = HeapAllocTail(HEAP_USER, MI_GetUncompressedSize(compressedMemory));
    }

    RenderCore_CPUCopyCompressed(compressedMemory, memory);
    HeapFree(HEAP_USER, compressedMemory);

    return memory;
}

void *BundleFileUnknown__LoadFileFromBundle(const char *bundlePath, u16 id, void *memory)
{
    void *compressedMemory = ReadFileFromBundle(bundlePath, id, FSREQ_AUTO_ALLOC_TAIL);

    if (memory == BUNDLEFILEUNKNOWN_AUTO_ALLOC_HEAD)
    {
        memory = HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(compressedMemory));
    }
    else if (memory == BUNDLEFILEUNKNOWN_AUTO_ALLOC_TAIL)
    {
        memory = HeapAllocTail(HEAP_USER, MI_GetUncompressedSize(compressedMemory));
    }

    RenderCore_CPUCopyCompressed(compressedMemory, memory);
    HeapFree(HEAP_USER, compressedMemory);

    return memory;
}
