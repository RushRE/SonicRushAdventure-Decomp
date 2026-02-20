#include <game/file/compressedFile.h>

// --------------------
// ENUMS
// --------------------

enum CompressedFileFlags_
{
    COMPRESSEDFILE_FLAG_NONE = 0x00,

    COMPRESSEDFILE_FLAG_USE_8_BIT_UNITS = 1 << 0,
    COMPRESSEDFILE_FLAG_DO_CACHE_WRITE  = 1 << 1,
};
typedef u8 CompressedFileFlags;

// --------------------
// FUNCTION DECLS
// --------------------

static BOOL CompressedFile__IsVISFile(void *memory);
static u8 CompressedFile__GetVisCompressCount(void *memory);
static size_t CompressedFile__GetUnknownSize(void *memory);
static void *CompressedFile__GetCompressedDataPtr(void *memory);
static void *CompressedFile__AllocateMemIfNeeded(void *memory, size_t size);
static void CompressedFile__HandleDecompression2(void *src, void *dst, CompressedFileFlags flags);
static void CompressedFile__HandleDecompression(void *src, void *dst, CompressedFileFlags flags);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void *PTR_XOR(void **a, void **b)
{
    *(u32 *)a ^= *(u32 *)b;
    *(u32 *)b ^= *(u32 *)a;
    *(u32 *)a = (*(u32 *)a ^ *(u32 *)b);
    return *a;
}

// --------------------
// FUNCTIONS
// --------------------

void *CompressedFile__Decompress(void *src, void *dst, void *buffer)
{
    typedef union SwapBuffer_
    {
        size_t addr[2];
        void *ptr[2];
    } SwapBuffer;

    BOOL allocatedBuffer = FALSE;
    u32 count            = 1;
    SwapBuffer swapBuffer;

    size_t size = CompressedFile__GetCompressedSize(src);
    dst         = CompressedFile__AllocateMemIfNeeded(dst, size);

    if (CompressedFile__IsVISFile(src))
    {
        count = CompressedFile__GetVisCompressCount(src);
        if (count > 1)
        {
            if (buffer == COMPRESSEDFILE_AUTO_ALLOC_HEAD || buffer == COMPRESSEDFILE_AUTO_ALLOC_TAIL)
            {
                buffer          = CompressedFile__AllocateMemIfNeeded(buffer, CompressedFile__GetUnknownSize(src));
                allocatedBuffer = TRUE;
            }
        }
    }

    if (count == 0)
    {
        RenderCore_CPUCopy(CompressedFile__GetCompressedDataPtr(src), dst, size);
    }
    else
    {
        if ((count & 1) != 0)
        {
            CompressedFile__HandleDecompression2(CompressedFile__GetCompressedDataPtr(src), dst, COMPRESSEDFILE_FLAG_DO_CACHE_WRITE);
            swapBuffer.ptr[1] = dst;
            swapBuffer.ptr[0] = buffer;
        }
        else
        {
            CompressedFile__HandleDecompression2(CompressedFile__GetCompressedDataPtr(src), buffer, COMPRESSEDFILE_FLAG_DO_CACHE_WRITE);
            swapBuffer.ptr[1] = buffer;
            swapBuffer.ptr[0] = dst;
        }
    }

    if (--count)
    {
        void *p = swapBuffer.ptr[1];
        do
        {
            CompressedFile__HandleDecompression2(CompressedFile__GetCompressedDataPtr(p), swapBuffer.ptr[0], COMPRESSEDFILE_FLAG_DO_CACHE_WRITE);

            p = PTR_XOR(&swapBuffer.ptr[1], &swapBuffer.ptr[0]);
        } while (--count);
    }

    if (allocatedBuffer)
        HeapFree(HEAP_USER, buffer);

    DC_StoreRange(dst, size);

    return dst;
}

BOOL CompressedFile__IsVISFile(void *memory)
{
    return ((CompressedVISFileHeader *)memory)->signature == '\0SIV';
}

u8 CompressedFile__GetVisCompressCount(void *memory)
{
    return ((CompressedVISFileHeader *)memory)->unknownCount;
}

size_t CompressedFile__GetCompressedSize(void *memory)
{
    if (CompressedFile__IsVISFile(memory))
        return ((CompressedVISFileHeader *)memory)->destSize;

    return ((MICompressionHeader *)memory)->destSize;
}

size_t CompressedFile__GetUnknownSize(void *memory)
{
    if (CompressedFile__IsVISFile(memory))
        return ((CompressedVISFileHeader *)memory)->unknownSize;

    return 0;
}

void *CompressedFile__GetCompressedDataPtr(void *memory)
{
    void *ptr = memory;
    if (CompressedFile__IsVISFile(memory))
        ptr = ((CompressedVISFileHeader *)memory)->data;

    return ptr;
}

void *CompressedFile__AllocateMemIfNeeded(void *memory, size_t size)
{
    switch ((size_t)memory)
    {
        default:
            return memory;

        case (size_t)COMPRESSEDFILE_AUTO_ALLOC_HEAD:
            return HeapAllocHead(HEAP_USER, size);

        case (size_t)COMPRESSEDFILE_AUTO_ALLOC_TAIL:
            return HeapAllocTail(HEAP_USER, size);
    }
}

void CompressedFile__HandleDecompression2(void *src, void *dst, CompressedFileFlags flags)
{
    CompressedFile__HandleDecompression(src, dst, flags);
}

void CompressedFile__HandleDecompression(void *src, void *dst, CompressedFileFlags flags)
{
    switch (MI_GetCompressionType(src))
    {
        case MI_COMPRESSION_LZ:
            if ((flags & COMPRESSEDFILE_FLAG_USE_8_BIT_UNITS) != 0)
                MI_UncompressLZ8(src, dst);
            else
                MI_UncompressLZ16(src, dst);
            break;

        case MI_COMPRESSION_HUFFMAN:
            MI_UncompressHuffman(src, dst);
            break;

        case MI_COMPRESSION_RL:
            if ((flags & COMPRESSEDFILE_FLAG_USE_8_BIT_UNITS) != 0)
                MI_UncompressRL8(src, dst);
            else
                MI_UncompressRL16(src, dst);
            break;

        case MI_COMPRESSION_DIFF:
            if ((flags & COMPRESSEDFILE_FLAG_USE_8_BIT_UNITS) != 0)
                MI_UnfilterDiff8(src, dst);
            else
                MI_UnfilterDiff16(src, dst);
            break;

        default:
            RenderCore_CPUCopy(src + sizeof(MICompressionHeader), dst, MI_GetUncompressedSize(src));
            break;
    }

    if ((flags & COMPRESSEDFILE_FLAG_DO_CACHE_WRITE) == 0)
        DC_StoreRange(dst, MI_GetUncompressedSize(src));
}
