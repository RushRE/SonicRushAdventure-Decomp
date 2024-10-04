#include <game/file/fileUnknown.h>
#include <game/file/fsRequest.h>

// --------------------
// FUNCTIONS
// --------------------

void *ArchiveFileUnknown__LoadFile(const char *path, void *memory)
{
    void *compressedMemory = FSRequestFileSync(path, FSREQ_AUTO_ALLOC_TAIL);

    size_t uncompressedSize = MI_GetUncompressedSize(compressedMemory);
    if (memory == FILEUNKNOWN_AUTO_ALLOC_HEAD)
    {
        memory = HeapAllocHead(HEAP_USER, uncompressedSize);
    }
    else if (memory == FILEUNKNOWN_AUTO_ALLOC_TAIL)
    {
        memory = HeapAllocTail(HEAP_USER, uncompressedSize);
    }

    RenderCore_CPUCopyCompressed(compressedMemory, memory);
    HeapFree(HEAP_USER, compressedMemory);

    return memory;
}

void *ArchiveFileUnknown__LoadFileFromArchive(const char *path, u16 id, void *memory)
{
    void *compressedMemory = FSRequestFileSync(path, FSREQ_AUTO_ALLOC_TAIL);
    void *fileMemory       = ArchiveFileUnknown__GetFileFromMemArchive(compressedMemory, id, memory);
    HeapFree(HEAP_USER, compressedMemory);

    return fileMemory;
}

void *ArchiveFileUnknown__GetFileFromMemArchive(void *archive, u16 id, void *memory)
{
    NNSFndArchive arc;
    FSFile file;

    void *archiveFile = HeapAllocTail(HEAP_USER, MI_GetUncompressedSize(archive));
    RenderCore_CPUCopyCompressed(archive, archiveFile);
    NNS_FndMountArchive(&arc, "aou", archiveFile);

    FS_InitFile(&file);
    NNS_FndOpenArchiveFileByIndex(&file, &arc, id);

    size_t fileSize = FS_GetLength(&file);

    void *fileData;
    if (memory == FILEUNKNOWN_AUTO_ALLOC_HEAD)
    {
        fileData = HeapAllocHead(HEAP_USER, FS_GetLength(&file));
    }
    else if (memory == FILEUNKNOWN_AUTO_ALLOC_TAIL)
    {
        fileData = HeapAllocTail(HEAP_USER, FS_GetLength(&file));
    }
    else
    {
        fileData = memory;
    }

    FS_ReadFile(&file, fileData, fileSize);
    FS_CloseFile(&file);
    NNS_FndUnmountArchive(&arc);

    HeapFree(HEAP_USER, archiveFile);
    DC_StoreRange(memory, fileSize);

    return fileData;
}

void *FileUnknown__GetAOUFile(void *archive, u16 id)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "aou", archive);
    void *fileData = NNS_FndGetArchiveFileByIndex(&arc, id);
    NNS_FndUnmountArchive(&arc);

    return fileData;
}

size_t FileUnknown__GetAOUFileSize(void *archive, u16 id)
{
    NNSFndArchive arc;
    FSFile file;

    NNS_FndMountArchive(&arc, "aou", archive);

    FS_InitFile(&file);
    NNS_FndOpenArchiveFileByIndex(&file, &arc, id);

    size_t fileSize = FS_GetLength(&file);
    
    NNS_FndUnmountArchive(&arc);

    return fileSize;
}
