#include <game/file/fsRequest.h>
#include <game/system/allocator.h>

// --------------------
// VARIABLES
// --------------------

static AsyncFileWork *fsReqListEnd;
static AsyncFileWork *fsReqListStart;

static void *fsReqTableStart;
static void *fsReqTableEnd;

static s32 fsReqCount;

static AsyncFileWork *fsRequestQueue[FSREQ_LIST_SIZE];
static AsyncFileWork fsRequestStorage[FSREQ_LIST_SIZE];

// --------------------
// FUNCTION DECLS
// --------------------

static AsyncFileWork *FSRequestAddWork(void);
static AsyncFileWork *GetNextFSRequestWork(void);
static void FSRequestOpenFile(AsyncFileWork *work);
static void FSRequestCloseFile(AsyncFileWork *work);

// --------------------
// FUNCTIONS
// --------------------

void InitFSRequestSystem(size_t tableSize, u32 defaultDMA)
{
    FS_Init(defaultDMA);
    u32 loadedTableSize = FS_GetTableSize();

    // Init Addresses for file heap
    tableSize       = (tableSize + 3) & ~3;
    u8 *poolTable   = (u8 *)OS_GetArenaLo(OS_ARENA_MAIN);
    fsReqTableStart = poolTable;
    fsReqTableEnd   = &poolTable[tableSize];
    OS_SetArenaLo(OS_ARENA_MAIN, &poolTable[tableSize]);
    fsReqTableEnd = OS_GetArenaLo(OS_ARENA_MAIN);

    if (fsReqTableStart < fsReqTableEnd)
        FS_LoadTable(fsReqTableStart, tableSize);

    fsReqCount = 0;
    MI_CpuClear32(fsRequestStorage, sizeof(fsRequestStorage));

    for (s32 i = 0; i < FSREQ_LIST_SIZE; i++)
    {
        fsRequestQueue[i] = &fsRequestStorage[i];
    }

    fsReqListEnd   = FSRequestAddWork();
    fsReqListStart = FSRequestAddWork();

    fsReqListEnd->prev = NULL;
    fsReqListEnd->next = fsReqListStart;

    fsReqListStart->prev = fsReqListEnd;
    fsReqListStart->next = NULL;
}

void ProcessFSRequests(void)
{
    BOOL loop = TRUE;
    while (loop)
    {
        AsyncFileWork *file = GetNextFSRequestWork();
        if (file == NULL)
            break;

        switch (file->status)
        {
            case FSREQ_STATUS_NEEDS_OPEN:
                FSRequestOpenFile(file);
                loop = FALSE;
                break;

            case FSREQ_STATUS_NEEDS_CLOSE:
                FSRequestCloseFile(file);
                if (file->status != FSREQ_STATUS_CLOSED)
                    loop = FALSE;
                break;
        }
    }
}

void *FSRequestFileSync(const char *path, void *memory)
{
    FSFile file;
    BOOL allocated = FALSE;

    FS_InitFile(&file);
    if (FS_OpenFile(&file, path))
    {
        size_t fileSize = FS_GetLength(&file);
        if (memory == FSREQ_AUTO_ALLOC_HEAD)
        {
            allocated = TRUE;
            memory    = HeapAllocHead(HEAP_USER, fileSize);
        }
        else if (memory == FSREQ_AUTO_ALLOC_TAIL)
        {
            allocated = TRUE;
            memory    = HeapAllocTail(HEAP_USER, fileSize);
        }

        if (FS_ReadFile(&file, memory, fileSize) >= 0 && FS_CloseFile(&file))
        {
            DC_StoreRange(memory, fileSize);
            return memory;
        }
    }

    if (allocated)
        HeapFree(HEAP_USER, memory);

    return NULL;
}

AsyncFileWork *FSRequestFileASync(const char *path, void *userData)
{
    AsyncFileWork *file = FSRequestAddWork();
    MI_CpuClear16(file, sizeof(*file));

    file->prev           = fsReqListStart->prev;
    file->next           = fsReqListStart;
    file->prev->next     = file;
    fsReqListStart->prev = file;

    file->status   = FSREQ_STATUS_NEEDS_OPEN;
    file->userData = userData;

    if (FS_ConvertPathToFileID(&file->fileID, path))
        return file;

    ReleaseFSRequestWork(file);
    return NULL;
}

void ReleaseFSRequestWork(AsyncFileWork *file)
{
    file->prev->next = file->next;
    file->next->prev = file->prev;

    u32 id             = fsReqCount - 1;
    fsRequestQueue[id] = file;
    fsReqCount--;

    if ((file->flags & FSREQ_FLAG_ALLOCATED_MEM) != 0 && (file->userData != FSREQ_AUTO_ALLOC_HEAD && file->userData != FSREQ_AUTO_ALLOC_TAIL))
    {
        HeapFree(HEAP_USER, file->userData);
        file->userData = NULL;
    }

    if ((file->flags & FSREQ_FLAG_OPEN) != 0)
        FS_CloseFile(&file->file);
}

size_t FSRequestFileSize(const char *path)
{
    FSFile file;

    FS_InitFile(&file);

    if (!FS_OpenFile(&file, path))
        return 0;

    size_t size = FS_GetLength(&file);

    if (!FS_CloseFile(&file))
        size = 0;

    return size;
}

AsyncFileWork *FSRequestAddWork(void)
{
    if (fsReqCount < FSREQ_LIST_SIZE)
        return fsRequestQueue[fsReqCount++];

    return NULL;
}

AsyncFileWork *GetNextFSRequestWork(void)
{
    AsyncFileWork *work = fsReqListEnd->next;

    if (work != fsReqListStart)
    {
        while (work != fsReqListStart)
        {
            if (work->status > FSREQ_STATUS_ERROR_CANT_READ && (work->status < FSREQ_STATUS_CLOSED || work->status > FSREQ_STATUS_UNKNOWN3))
                return work;

            work = work->next;
        }
    }

    return NULL;
}

void FSRequestOpenFile(AsyncFileWork *work)
{
    FS_InitFile(&work->file);
    if (!FS_OpenFileFast(&work->file, work->fileID))
    {
        work->status = FSREQ_STATUS_ERROR_CANT_OPEN;
        return;
    }

    work->flags |= FSREQ_FLAG_OPEN;
    work->fileSize = FS_GetLength(&work->file);

    if (work->userData == FSREQ_AUTO_ALLOC_HEAD)
    {
        work->userData = HeapAllocHead(HEAP_USER, work->fileSize);
        work->flags |= FSREQ_FLAG_ALLOCATED_MEM;
    }
    else if (work->userData == FSREQ_AUTO_ALLOC_TAIL)
    {
        work->userData = HeapAllocTail(HEAP_USER, work->fileSize);
        work->flags |= FSREQ_FLAG_ALLOCATED_MEM;
    }

    if (work->userData == NULL)
    {
        work->status = FSREQ_STATUS_ERROR_CANT_ALLOC;
        return;
    }

    if (FS_ReadFileAsync(&work->file, work->userData, work->fileSize) == -1)
    {
        work->status = FSREQ_STATUS_ERROR_CANT_READ;
        return;
    }

    work->status = FSREQ_STATUS_NEEDS_CLOSE;
}

void FSRequestCloseFile(AsyncFileWork *work)
{
    if (FS_IsBusy(&work->file))
        return;

    FS_CloseFile(&work->file);
    work->flags &= ~FSREQ_FLAG_OPEN;
    work->status = FSREQ_STATUS_CLOSED;
    DC_StoreRange(work->userData, work->fileSize);
}
