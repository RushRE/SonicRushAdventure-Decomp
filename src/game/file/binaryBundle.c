#include <game/file/binaryBundle.h>
#include <game/system/allocator.h>

// --------------------
// FUNCTION DECLS
// --------------------

static void GetBundleFile(FSFile *file, u16 id, BBFile *bbFile);

// --------------------
// FUNCTIONS
// --------------------

void InitBinaryBundleSystem(void)
{
    // Nothin'
}

u32 GetBundleFileSize(const char *path, u16 id)
{
    BBFile bbFile;
    FSFile file;

    FS_InitFile(&file);
    FS_OpenFile(&file, path);
    GetBundleFile(&file, id, &bbFile);
    FS_CloseFile(&file);

    return bbFile.size;
}

void *ReadFileFromBundle(const char *path, u16 id, void *memory)
{
    BBFile bbFile;
    FSFile file;

    FS_InitFile(&file);
    FS_OpenFile(&file, path);
    GetBundleFile(&file, id, &bbFile);

    if (memory == BINARYBUNDLE_AUTO_ALLOC_HEAD)
    {
        memory = HeapAllocHead(HEAP_USER, bbFile.size);
    }
    else if (memory == BINARYBUNDLE_AUTO_ALLOC_TAIL)
    {
        memory = HeapAllocTail(HEAP_USER, bbFile.size);
    }

    FS_SeekFile(&file, bbFile.offset, FS_SEEK_SET);
    FS_ReadFile(&file, memory, bbFile.size);
    FS_CloseFile(&file);
    DC_StoreRange(memory, bbFile.size);

    return memory;
}

void GetBundleFile(FSFile *file, u16 id, BBFile *bbFile)
{
    FS_SeekFile(file, sizeof(BBHeader) + (sizeof(BBFile) * id), FS_SEEK_SET);
    FS_ReadFile(file, bbFile, sizeof(BBFile));
}
