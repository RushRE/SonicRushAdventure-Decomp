#include <game/file/compressedFile.h>

// --------------------
// FUNCTIONS
// --------------------

NONMATCH_FUNC void *CompressedFile__Decompress(void *src, void *dst, void *buffer)
{
    // https://decomp.me/scratch/Rl1ZW -> 73.38%
#ifdef NON_MATCHING
    BOOL allocatedBuffer = FALSE;
    u32 count            = 1;

    size_t size  = CompressedFile__GetCompressedSize(src);
    void *memory = CompressedFile__AllocateMemIfNeeded(dst, size);

    size_t ptr[2];
    if (CompressedFile__IsVisAnim(src))
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
        RenderCore_CPUCopy(CompressedFile__GetUnknown2Size(src), memory, size);
    }
    else
    {
        if ((count & 1) != 0)
        {
            CompressedFile__HandleDecompression2(CompressedFile__GetUnknown2Size(src), memory, 2);
            ptr[1] = (size_t)memory;
            ptr[0] = (size_t)buffer;
        }
        else
        {
            CompressedFile__HandleDecompression2(CompressedFile__GetUnknown2Size(src), buffer, 2);
            ptr[1] = (size_t)buffer;
            ptr[0] = (size_t)memory;
        }
    }

    for (u32 i = count - 1; i > 0; i--)
    {
        CompressedFile__HandleDecompression2(CompressedFile__GetUnknown2Size((void *)ptr[1]), (void *)ptr[0], 2);

        XOR_SWAP(ptr[0], ptr[1]);
    }

    if (allocatedBuffer)
        HeapFree(HEAP_USER, buffer);

    DC_StoreRange(memory, size);

    return memory;
#else
    // clang-format off
	stmdb sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}
	sub sp, sp, #8
	mov r4, r0
	mov r10, r1
	mov r9, r2
	mov r7, #0
	mov r8, #1
	bl CompressedFile__GetCompressedSize
	mov r11, r0
	mov r0, r10
	mov r1, r11
	bl CompressedFile__AllocateMemIfNeeded
	mov r10, r0
	mov r0, r4
	bl CompressedFile__IsVisAnim
	cmp r0, #0
	beq _0205B76C
	mov r0, r4
	bl CompressedFile__GetVisCompressCount
	mov r8, r0
	cmp r8, #1
	bls _0205B76C
	cmp r9, #0
	mvnne r0, #0
	cmpne r9, r0
	bne _0205B76C
	mov r0, r4
	bl CompressedFile__GetUnknownSize
	mov r1, r0
	mov r0, r9
	bl CompressedFile__AllocateMemIfNeeded
	mov r9, r0
	mov r7, #1
_0205B76C:
	cmp r8, #0
	bne _0205B78C
	mov r0, r4
	bl CompressedFile__GetUnknown2Size
	mov r1, r10
	mov r2, r11
	bl RenderCore_CPUCopy
	b _0205B7CC
_0205B78C:
	tst r8, #1
	mov r0, r4
	beq _0205B7B4
	bl CompressedFile__GetUnknown2Size
	mov r1, r10
	mov r2, #2
	bl CompressedFile__HandleDecompression2
	str r10, [sp, #4]
	str r9, [sp]
	b _0205B7CC
_0205B7B4:
	bl CompressedFile__GetUnknown2Size
	mov r1, r9
	mov r2, #2
	bl CompressedFile__HandleDecompression2
	str r9, [sp, #4]
	str r10, [sp]
_0205B7CC:
	subs r8, r8, #1
	beq _0205B81C
	ldr r0, [sp, #4]
	mov r6, #2
	add r5, sp, #4
	add r4, sp, #0
_0205B7E4:
	bl CompressedFile__GetUnknown2Size
	ldr r1, [sp]
	mov r2, r6
	bl CompressedFile__HandleDecompression2
	ldr r2, [r5, #0]
	ldr r1, [sp]
	ldr r0, [r4, #0]
	eor r2, r2, r1
	eor r1, r0, r2
	eor r0, r2, r1
	str r1, [r4]
	str r0, [r5]
	subs r8, r8, #1
	bne _0205B7E4
_0205B81C:
	cmp r7, #0
	beq _0205B82C
	mov r0, r9
	bl _FreeHEAP_USER
_0205B82C:
	mov r0, r10
	mov r1, r11
	bl DC_StoreRange
	mov r0, r10
	add sp, sp, #8
	ldmia sp!, {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}

// clang-format on
#endif
}

BOOL CompressedFile__IsVisAnim(void *memory)
{
    return ((NNSG3dResAnmSet *)memory)->header.kind == '\0SIV';
}

u8 CompressedFile__GetVisCompressCount(void *memory)
{
    return (16 * ((NNSG3dResAnmSet *)memory)->header.size) >> 28;
}

size_t CompressedFile__GetCompressedSize(void *memory)
{
    size_t size;

    if (CompressedFile__IsVisAnim(memory))
        size = ((NNSG3dResAnmSet *)memory)->header.size << 8;
    else
        size = *((u32 *)memory);

    return size >> 8;
}

size_t CompressedFile__GetUnknownSize(void *memory)
{
    if (CompressedFile__IsVisAnim(memory))
    {
        // TODO: figure out what struct this is
        u32 size = (*(s32 *)((u8 *)memory + 8)) << 8;

        return size >> 8;
    }

    return 0;
}

void *CompressedFile__GetUnknown2Size(void *memory)
{
    void *ptr = memory;
    if (CompressedFile__IsVisAnim(memory))
    {
        // TODO: figure out what struct this is
        ptr += 12;
    }

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

void CompressedFile__HandleDecompression2(void *src, void *dst, u8 flags)
{
    CompressedFile__HandleDecompression(src, dst, flags);
}

void CompressedFile__HandleDecompression(void *src, void *dst, u8 flags)
{
    switch (MI_GetCompressionType(src))
    {
        case MI_COMPRESSION_LZ:
            if ((flags & 1) != 0)
                MI_UncompressLZ8(src, dst);
            else
                MI_UncompressLZ16(src, dst);
            break;

        case MI_COMPRESSION_HUFFMAN:
            MI_UncompressHuffman(src, dst);
            break;

        case MI_COMPRESSION_RL:
            if ((flags & 1) != 0)
                MI_UncompressRL8(src, dst);
            else
                MI_UncompressRL16(src, dst);
            break;

        case MI_COMPRESSION_DIFF:
            if ((flags & 1) != 0)
                MI_UnfilterDiff8(src, dst);
            else
                MI_UnfilterDiff16(src, dst);
            break;

        default:
            RenderCore_CPUCopy(src + sizeof(MICompressionHeader), dst, MI_GetUncompressedSize(src));
            break;
    }

    if ((flags & 2) == 0)
        DC_StoreRange(dst, MI_GetUncompressedSize(src));
}
