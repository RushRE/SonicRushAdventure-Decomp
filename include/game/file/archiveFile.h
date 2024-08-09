#ifndef RUSH2_ARCHIVEFILE_H
#define RUSH2_ARCHIVEFILE_H

#include <global.h>
#include <game/system/threadWorker.h>
#include <game/file/fsRequest.h>

// --------------------
// CONSTANTS
// --------------------

#define ARCHIVEFILE_AUTO_ALLOC_HEAD_USER   ((void *)(size_t)0)
#define ARCHIVEFILE_AUTO_ALLOC_TAIL_USER   ((void *)(size_t)-1)
#define ARCHIVEFILE_AUTO_ALLOC_HEAD_SYSTEM ((void *)(size_t)-2)
#define ARCHIVEFILE_AUTO_ALLOC_TAIL_SYSTEM ((void *)(size_t)-3)

#define ARCHIVEFILE_ID_NONE (-1)

// --------------------
// ENUMS
// --------------------

enum ArchiveFileFlags_
{
    ARCHIVEFILE_FLAG_NONE = 0x00,

    ARCHIVEFILE_FLAG_IS_COMPRESSED = 1 << 0,
    ARCHIVEFILE_FLAG_USE_SYSTEM_HEAP = 1 << 1,
};
typedef u32 ArchiveFileFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct ArchiveFile_
{
    Thread thread;
    char path[0x30];
    u32 id;
    void *memory;
    ArchiveFileFlags flags;
    OSMutex mutex;
    void *compressedBytes;
} ArchiveFile;

// --------------------
// FUNCTIONS
// --------------------

void *ArchiveFile__Load(const char *path, u32 id, void *destPtr, ArchiveFileFlags flags, ArchiveFile *file);
void ArchiveFile__Init(ArchiveFile *file);
void ArchiveFile__Release(ArchiveFile *file);
BOOL ArchiveFile__CheckThreadInactive(ArchiveFile *file);
void *ArchiveFile__JoinThread(ArchiveFile *file);
void *ArchiveFile__AllocateMemory(void *memory, size_t size);
size_t ArchiveFile__GetFileSize(const char *path, u32 id);
void *ArchiveFile__ReadFile(const char *path, u32 id, void *memory);
void ArchiveFile__ThreadFunc(ArchiveFile *file);
void ArchiveFile__InitAsync(ArchiveFile *file, const char *path, u32 id, void *outputPtr, ArchiveFileFlags flags);
void ArchiveFile__LoadFiles(void *archive, va_list args);

#endif // RUSH2_ARCHIVEFILE_H
