#ifndef NNS_FND_ARCHIVE_BLOCK_H
#define NNS_FND_ARCHIVE_BLOCK_H

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u32 blockType;
    u32 blockSize;
} NNSiFndArchiveBlockHeader;

typedef NNSiFndArchiveBlockHeader NNSiFndArchiveDirBlockHeader;
typedef NNSiFndArchiveBlockHeader NNSiFndArchiveImgBlockHeader;

typedef struct
{
    u32 blockType;
    u32 blockSize;
    u16 numFiles;
    u16 reserved;
} NNSiFndArchiveFatBlockHeader;

#ifdef __cplusplus
}
#endif

#endif // NNS_FND_ARCHIVE_BLOCK_H
