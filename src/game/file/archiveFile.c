#include <game/file/archiveFile.h>
#include <game/file/binaryBundle.h>

// --------------------
// TEMP
// --------------------

NOT_DECOMPILED void *CompressedFile__Decompress(void *compressedBytes, void *uncompressedMemory, void *buffer);
NOT_DECOMPILED size_t CompressedFile__GetCompressedSize(void *a1);

// --------------------
// STRUCTS
// --------------------

typedef union ArchivePath
{
    char text[64];
    u32 val[64 / 4];
} ArchivePath;

// --------------------
// FUNCTIONS
// --------------------

void *ArchiveFile__Load(const char *path, u32 id, void *destPtr, ArchiveFileFlags flags, ArchiveFile *file)
{
    BOOL useSystemHeap;
    void *memory;

    if (file == NULL)
    {
        if ((flags & ARCHIVEFILE_FLAG_IS_COMPRESSED) != 0)
        {
            useSystemHeap = flags & ARCHIVEFILE_FLAG_USE_SYSTEM_HEAP;

            void *compressedMemory;
            if (useSystemHeap)
            {
                if (destPtr != ARCHIVEFILE_AUTO_ALLOC_TAIL_SYSTEM)
                {
                    compressedMemory = HeapAllocTail(HEAP_SYSTEM, ArchiveFile__GetFileSize(path, id));
                }
                else
                {
                    compressedMemory = HeapAllocHead(HEAP_SYSTEM, ArchiveFile__GetFileSize(path, id));
                }
            }
            else
            {
                if (destPtr != ARCHIVEFILE_AUTO_ALLOC_TAIL_USER)
                {
                    compressedMemory = HeapAllocTail(HEAP_USER, ArchiveFile__GetFileSize(path, id));
                }
                else
                {
                    compressedMemory = HeapAllocHead(HEAP_USER, ArchiveFile__GetFileSize(path, id));
                }
            }

            void *tempMemory = ArchiveFile__ReadFile(path, id, compressedMemory);
            memory           = ArchiveFile__AllocateMemory(destPtr, CompressedFile__GetCompressedSize(tempMemory));
            CompressedFile__Decompress(tempMemory, memory, (void *)-1);
            if (useSystemHeap)
                HeapFree(HEAP_SYSTEM, tempMemory);
            else
                HeapFree(HEAP_USER, tempMemory);
        }
        else
        {
            memory = ArchiveFile__ReadFile(path, id, ArchiveFile__AllocateMemory(destPtr, ArchiveFile__GetFileSize(path, id)));
        }
    }
    else
    {
        ArchiveFile__InitAsync(file, path, id, destPtr, flags);
        memory = ArchiveFile__AllocateMemory(destPtr, 0);
        CreateThreadWorker(&file->thread, (ThreadFunc)ArchiveFile__ThreadFunc, file, 24);
    }

    return memory;
}

void ArchiveFile__Init(ArchiveFile *file)
{
    MI_CpuClear16(file, sizeof(ArchiveFile));
    InitThreadWorker(&file->thread, 0x1000);
    OS_InitMutex(&file->mutex);
}

void ArchiveFile__Release(ArchiveFile *file)
{
    BOOL useSystemHeap = file->flags & ARCHIVEFILE_FLAG_USE_SYSTEM_HEAP;

    OS_LockMutex(&file->mutex);
    ReleaseThreadWorker(&file->thread);

    if (file->compressedBytes != NULL)
    {
        if (useSystemHeap)
            HeapFree(HEAP_SYSTEM, file->compressedBytes);
        else
            HeapFree(HEAP_USER, file->compressedBytes);
    }
    OS_UnlockMutex(&file->mutex);

    MI_CpuClear16(file, sizeof(ArchiveFile));
}

BOOL ArchiveFile__CheckThreadInactive(ArchiveFile *file)
{
    return IsThreadWorkerFinished(&file->thread) != FALSE;
}

void *ArchiveFile__JoinThread(ArchiveFile *file)
{
    JoinThreadWorker(&file->thread);
    return file->memory;
}

void *ArchiveFile__AllocateMemory(void *memory, size_t size)
{
    switch ((size_t)memory)
    {
        case (size_t)ARCHIVEFILE_AUTO_ALLOC_HEAD_USER:
            if (size)
                return HeapAllocHead(HEAP_USER, size);
            else
                return NULL;

        case (size_t)ARCHIVEFILE_AUTO_ALLOC_TAIL_USER:
            if (size)
                return HeapAllocTail(HEAP_USER, size);
            else
                return NULL;

        case (size_t)ARCHIVEFILE_AUTO_ALLOC_HEAD_SYSTEM:
            if (size)
                return HeapAllocHead(HEAP_SYSTEM, size);
            else
                return NULL;

        case (size_t)ARCHIVEFILE_AUTO_ALLOC_TAIL_SYSTEM:
            if (size)
                return HeapAllocTail(HEAP_SYSTEM, size);
            else
                return NULL;
    }

    return memory;
}

size_t ArchiveFile__GetFileSize(const char *path, u32 id)
{
    if (id == ARCHIVEFILE_ID_NONE)
        return FSRequestFileSize(path);
    else
        return GetBundleFileSize(path, id);
}

void *ArchiveFile__ReadFile(const char *path, u32 id, void *memory)
{
    if (id == ARCHIVEFILE_ID_NONE)
        return FSRequestFileSync(path, memory);
    else
        return ReadFileFromBundle(path, id, memory);
}

void ArchiveFile__ThreadFunc(ArchiveFile *file)
{
    u32 flags = file->flags;
    u32 id    = file->id;

    if ((flags & ARCHIVEFILE_FLAG_IS_COMPRESSED) != 0)
    {
        BOOL useSystemHeap = flags & ARCHIVEFILE_FLAG_USE_SYSTEM_HEAP;

        if (useSystemHeap)
        {
            OS_LockMutex(&file->mutex);
            file->compressedBytes = HeapAllocTail(HEAP_SYSTEM, ArchiveFile__GetFileSize(file->path, id));
            OS_UnlockMutex(&file->mutex);
        }
        else
        {
            OS_LockMutex(&file->mutex);
            file->compressedBytes = HeapAllocTail(HEAP_USER, ArchiveFile__GetFileSize(file->path, id));
            OS_UnlockMutex(&file->mutex);
        }

        file->compressedBytes = ArchiveFile__ReadFile(file->path, id, file->compressedBytes);

        OS_LockMutex(&file->mutex);
        file->memory = ArchiveFile__AllocateMemory(file->memory, MI_GetUncompressedSize(file->compressedBytes));
        OS_UnlockMutex(&file->mutex);

        RenderCore_CPUCopyCompressed(file->compressedBytes, file->memory);

        OS_LockMutex(&file->mutex);
        if (useSystemHeap)
            HeapFree(HEAP_SYSTEM, file->compressedBytes);
        else
            HeapFree(HEAP_USER, file->compressedBytes);
        file->compressedBytes = NULL;
        OS_UnlockMutex(&file->mutex);
    }
    else
    {
        OS_LockMutex(&file->mutex);
        file->memory = ArchiveFile__AllocateMemory(file->memory, ArchiveFile__GetFileSize(file->path, id));
        OS_UnlockMutex(&file->mutex);

        file->memory = ArchiveFile__ReadFile(file->path, id, file->memory);
    }
}

void ArchiveFile__InitAsync(ArchiveFile *file, const char *path, u32 id, void *outputPtr, ArchiveFileFlags flags)
{
    STD_CopyString(file->path, path);
    file->id              = id;
    file->compressedBytes = 0;
    file->memory          = outputPtr;
    file->flags           = flags;
}

void ArchiveFile__LoadFiles(void *archive, va_list args)
{
    NNSFndArchive arc;

    NNS_FndMountArchive(&arc, "ERU", archive);

    while (*((void **)args) != NULL)
    {
        void **resource   = va_arg(args, void **);
        size_t identifier = va_arg(args, size_t);

        if (identifier <= 0xFFFF)
        {
            *resource = NNS_FndGetArchiveFileByIndex(&arc, (u16)identifier);
        }
        else
        {
            ArchivePath filePath = { "ERU:" };

            STD_ConcatenateString(filePath.text, (const char *)identifier);
            *resource = NNS_FndGetArchiveFileByName(filePath.text);
        }
    }
    NNS_FndUnmountArchive(&arc);
}

// --------------------
// UNREFERENCED VARS
// --------------------

FORCE_INCLUDE_VARIABLE(ArchivePath, archivePath, { "ERU:" })