#ifndef NNS_FND_ARCHIVE_H
#define NNS_FND_ARCHIVE_H

#include <nitro/os.h>
#include <nitro/fs.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct
{
    u32 fileTop;
    u32 fileBottom;
} NNSiFndArchiveFatEntry;

typedef struct
{
    u32 blockType;
    u32 blockSize;
    u16 numFiles;
    u16 reserved;
    NNSiFndArchiveFatEntry fatEntries[1];
} NNSiFndArchiveFatData;

typedef struct
{
    u32 signature;
    u16 byteOrder;
    u16 version;
    u32 fileSize;
    u16 headerSize;
    u16 dataBlocks;
} NNSiFndArchiveHeader;

typedef struct
{
    FSArchive fsArchive;
    NNSiFndArchiveHeader *arcBinary;
    NNSiFndArchiveFatData *fatData;
    u32 fileImage;
} NNSFndArchive;

// --------------------
// FUNCTIONS
// --------------------

BOOL NNS_FndMountArchive(NNSFndArchive *archive, const char *arcName, void *arcBinary);
BOOL NNS_FndUnmountArchive(NNSFndArchive *archive);
void *NNS_FndGetArchiveFileByName(const char *path);
void *NNS_FndGetArchiveFileByIndex(NNSFndArchive *archive, u32 index);
BOOL NNS_FndOpenArchiveFileByIndex(FSFile *file, NNSFndArchive *archive, u32 index);

#ifdef __cplusplus
}
#endif

#endif // NNS_FND_ARCHIVE_H
