#ifndef RUSH_FSREQUEST_H
#define RUSH_FSREQUEST_H

#include <global.h>
#include <game/system/allocator.h>
#include <game/graphics/renderCore.h>

// --------------------
// CONSTANTS
// --------------------

#define FSREQ_HEAP_SIZE 0x0000 // 0kb

#define FSREQ_LIST_SIZE (8)

#define FSREQ_AUTO_ALLOC_HEAD ((void *)(size_t)0)
#define FSREQ_AUTO_ALLOC_TAIL ((void *)(size_t)-1)

// --------------------
// ENUMS
// --------------------

enum FSRequestFlags_
{
    FSREQ_FLAG_NONE = 0,

    FSREQ_FLAG_ALLOCATED_MEM = 1 << 0,
    FSREQ_FLAG_OPEN          = 1 << 1,
};
typedef u32 FSRequestFlags;

enum FSRequestStatus_
{
    FSREQ_STATUS_ERROR_CANT_ALLOC = -3,
    FSREQ_STATUS_ERROR_CANT_OPEN  = -2,
    FSREQ_STATUS_ERROR_CANT_READ  = -1,

    FSREQ_STATUS_NONE = 0,

    FSREQ_STATUS_NEEDS_OPEN  = 1,
    FSREQ_STATUS_UNKNOWN1    = 2,
    FSREQ_STATUS_NEEDS_CLOSE = 3,
    FSREQ_STATUS_UNKNOWN2    = 4,
    FSREQ_STATUS_CLOSED      = 5,
    FSREQ_STATUS_UNKNOWN3    = 6,
};
typedef s32 FSRequestStatus;

// --------------------
// STRUCTS
// --------------------

typedef struct AsyncFileWork_
{
    struct AsyncFileWork_ *prev;
    struct AsyncFileWork_ *next;
    FSRequestStatus status;
    FSRequestFlags flags;
    FSFileID fileID;
    FSFile file;
    void *userData;
    s32 fileSize;
} AsyncFileWork;

// --------------------
// FUNCTIONS
// --------------------

void InitFSRequestSystem(size_t tableSize, u32 defaultDMA);
void ProcessFSRequests(void);
void *FSRequestFileSync(const char *path, void *memory);
AsyncFileWork *FSRequestFileASync(const char *path, void *userData);
void ReleaseFSRequestWork(AsyncFileWork *file);
size_t FSRequestFileSize(const char *path);

// --------------------
// INLINE FUNCTIONS
// --------------------

RUSH_INLINE void FSRequestArchive(const char *path, void **memory, BOOL fromTail)
{
    void *compressedData = FSRequestFileSync(path, fromTail ? FSREQ_AUTO_ALLOC_TAIL : FSREQ_AUTO_ALLOC_HEAD);
    if (fromTail)
    {
        (*memory) = (NNSiFndArchiveHeader *)HeapAllocHead(HEAP_USER, MI_GetUncompressedSize(compressedData));
    }
    else
    {
        (*memory) = (NNSiFndArchiveHeader *)HeapAllocTail(HEAP_USER, MI_GetUncompressedSize(compressedData));
    }
    RenderCore_CPUCopyCompressed(compressedData, (*memory));
    HeapFree(HEAP_USER, compressedData);
}

#endif // RUSH_FSREQUEST_H
