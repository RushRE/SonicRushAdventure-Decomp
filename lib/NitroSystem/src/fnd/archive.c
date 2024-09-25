#include <string.h>

#include <nnsys/misc.h>
#include <nnsys/fnd/archive.h>

#include "include/archive_block.h"

// --------------------
// FUNCTIONS
// --------------------

static BOOL IsValidArchiveBinary(NNSiFndArchiveHeader *arcBinary)
{
    if (arcBinary->signature != 'CRAN')
        return FALSE;

    if (arcBinary->byteOrder != 0xFFFE)
        return FALSE;

    if (arcBinary->version != 0x0100)
        return FALSE;

    return TRUE;
}

BOOL NNS_FndMountArchive(NNSFndArchive *archive, const char *arcName, void *arcBinary)
{
    NNSiFndArchiveHeader *arc         = (NNSiFndArchiveHeader *)arcBinary;
    NNSiFndArchiveFatBlockHeader *fat = NULL;
    NNSiFndArchiveDirBlockHeader *fnt = NULL;
    NNSiFndArchiveImgBlockHeader *img = NULL;

    if (!IsValidArchiveBinary(arc))
    {
        return FALSE;
    }

    {
        int count;
        NNSiFndArchiveBlockHeader *block = (NNSiFndArchiveBlockHeader *)((u32)arc + arc->headerSize);

        for (count = 0; count < arc->dataBlocks; count++)
        {
            switch (block->blockType)
            {
                case 'FATB':
                    fat = (NNSiFndArchiveFatBlockHeader *)block;
                    break;

                case 'FNTB':
                    fnt = (NNSiFndArchiveDirBlockHeader *)block;
                    break;

                case 'FIMG':
                    img = (NNSiFndArchiveImgBlockHeader *)block;
                    break;
            }
            block = (NNSiFndArchiveBlockHeader *)((u32)block + block->blockSize);
        }

        FS_InitArchive(&archive->fsArchive);
        archive->arcBinary = arc;
        archive->fatData   = (NNSiFndArchiveFatData *)fat;
        archive->fileImage = (u32)(img + 1);

        if (!FS_RegisterArchiveName(&archive->fsArchive, arcName, strlen(arcName)))
        {
            return FALSE;
        }

        if (!FS_LoadArchive(&archive->fsArchive, (u32)(img + 1), (u32)(fat + 1) - (u32)(img + 1), fat->blockSize - sizeof(NNSiFndArchiveFatBlockHeader),
                            (u32)(fnt + 1) - (u32)(img + 1), fnt->blockSize - sizeof(NNSiFndArchiveDirBlockHeader), NULL, NULL))
        {
            FS_ReleaseArchiveName(&archive->fsArchive);
            return FALSE;
        }
    }

    return TRUE;
}

BOOL NNS_FndUnmountArchive(NNSFndArchive *archive)
{
    if (!FS_UnloadArchive(&archive->fsArchive))
    {
        return FALSE;
    }

    FS_ReleaseArchiveName(&archive->fsArchive);
    return TRUE;
}

void *NNS_FndGetArchiveFileByName(const char *path)
{
    void *addr = NULL;
    FSFile file;

    FS_InitFile(&file);

    if (FS_OpenFile(&file, path))
    {
        NNSFndArchive *archive = (NNSFndArchive *)FS_GetAttachedArchive(&file);

        addr = (void *)archive->fileImage;
        addr += FS_GetFileImageTop(&file);

        (void)FS_CloseFile(&file);
    }

    return addr;
}

void *NNS_FndGetArchiveFileByIndex(NNSFndArchive *archive, u32 index)
{
    void *addr = NULL;

    if (index < archive->fatData->numFiles)
    {
        addr = (void *)(archive->fileImage + archive->fatData->fatEntries[index].fileTop);
    }

    return addr;
}

BOOL NNS_FndOpenArchiveFileByIndex(FSFile *file, NNSFndArchive *archive, u32 index)
{
    BOOL result = FALSE;

    if (index < archive->fatData->numFiles)
    {
        FSFileID fileID;

        fileID.arc     = &archive->fsArchive;
        fileID.file_id = index;

        result = FS_OpenFileFast(file, fileID);
    }
    
    return result;
}
