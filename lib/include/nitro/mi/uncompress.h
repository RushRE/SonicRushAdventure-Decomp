#ifndef NITRO_MI_UNCOMPRESS_H
#define NITRO_MI_UNCOMPRESS_H

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

typedef enum
{
    MI_COMPRESSION_LZ      = 0x10, // LZ77
    MI_COMPRESSION_HUFFMAN = 0x20, // Huffman
    MI_COMPRESSION_RL      = 0x30, // Run Length
    MI_COMPRESSION_DIFF    = 0x80, // Differential filter

    MI_COMPRESSION_TYPE_MASK    = 0xF0,
    MI_COMPRESSION_TYPE_EX_MASK = 0xFF
} MICompressionType;

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u32 compParam : 4;
    u32 compType : 4;
    u32 destSize : 24;
} MICompressionHeader;

typedef struct
{
    u16 srcNum;
    u16 srcBitNum : 8;
    u16 destBitNum : 8;
    u32 destOffset : 31;
    u32 destOffset0_on : 1;
} MIUnpackBitsParam;

// --------------------
// FUNCTIONS
// --------------------

void MI_UncompressLZ8(const void *srcp, void *destp);
void MI_UncompressLZ16(const void *srcp, void *destp);
void MI_UncompressHuffman(const void *srcp, void *destp);
void MI_UncompressRL8(const void *srcp, void *destp);
void MI_UncompressRL16(const void *srcp, void *destp);

void MI_UnfilterDiff8(const void *srcp, void *destp);
void MI_UnfilterDiff16(const void *srcp, void *destp);

// This is in in lib/NitroSDK/src/init/ARM9/crt0.c
void MIi_UncompressBackward(void *bottom);

// --------------------
// INLINE FUNCTIONS
// --------------------

static inline u32 MI_GetUncompressedSize(const void *srcp)
{
    return (*(u32 *)srcp >> 8);
}

static inline MICompressionType MI_GetCompressionType(const void *srcp)
{
    return (MICompressionType)(*(u32 *)srcp & MI_COMPRESSION_TYPE_MASK);
}

#ifdef __cplusplus
}
#endif

#endif // NITRO_MI_UNCOMPRESS_H
