#include <nitro.h>

#define OFFSET(n, a) (((u32)(n)) & ((a)-1))
#define TRUNC(n, a)  (((u32)(n)) & ~((a)-1))
#define ROUND(n, a)  (((u32)(n) + (a)-1) & ~((a)-1))

#define ALIGNMENT  32
#define MINOBJSIZE (HEADERSIZE + ALIGNMENT)
#define HEADERSIZE ROUND(sizeof(Cell), ALIGNMENT)

#define InRange(targ, a, b) ((u32)(a) <= (u32)(targ) && (u32)(targ) < (u32)(b))

#define RangeOverlap(aStart, aEnd, bStart, bEnd) ((u32)(bStart) <= (u32)(aStart) && (u32)(aStart) < (u32)(bEnd) || (u32)(bStart) < (u32)(aEnd) && (u32)(aEnd) <= (u32)(bEnd))

#define RangeSubset(aStart, aEnd, bStart, bEnd) ((u32)(bStart) <= (u32)(aStart) && (u32)(aEnd) <= (u32)(bEnd))

typedef struct Cell Cell;
typedef struct HeapDesc HeapDesc;

struct Cell
{
    Cell *prev;
    Cell *next;
    long size;
};

struct HeapDesc
{
    long size;

    Cell *free;
    Cell *allocated;
};

typedef struct
{

    volatile OSHeapHandle currentHeap;
    int numHeaps;
    void *arenaStart;
    void *arenaEnd;
    HeapDesc *heapArray;
} OSHeapInfo;

void *OSiHeapInfo[OS_ARENA_MAX] = { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL };

static Cell *DLAddFront(Cell *list, Cell *cell)
{
    cell->next = list;
    cell->prev = NULL;
    if (list)
    {
        list->prev = cell;
    }
    return cell;
}

static Cell *DLLookup(Cell *list, Cell *cell)
{
    for (; list; list = list->next)
    {
        if (list == cell)
        {
            return list;
        }
    }
    return NULL;
}

static Cell *DLExtract(Cell *list, Cell *cell)
{
    if (cell->next)
    {
        cell->next->prev = cell->prev;
    }

    if (cell->prev == NULL)
    {
        return cell->next;
    }
    else
    {
        cell->prev->next = cell->next;
        return list;
    }
}

static Cell *DLInsert(Cell *list, Cell *cell)
{
    Cell *prev;
    Cell *next;

    for (next = list, prev = NULL; next; prev = next, next = next->next)
    {
        if (cell <= next)
        {
            break;
        }
    }

    cell->next = next;
    cell->prev = prev;
    if (next)
    {
        next->prev = cell;
        if ((char *)cell + cell->size == (char *)next)
        {

            cell->size += next->size;
            cell->next = next = next->next;
            if (next)
            {
                next->prev = cell;
            }
        }
    }

    if (prev)
    {
        prev->next = cell;
        if ((char *)prev + prev->size == (char *)cell)
        {

            prev->size += cell->size;
            prev->next = next;
            if (next)
            {
                next->prev = prev;
            }
        }
        return list;
    }
    else
    {
        return cell;
    }
}

static BOOL DLOverlap(Cell *list, void *start, void *end)
{
    Cell *cell;

    for (cell = list; cell; cell = cell->next)
    {
        if (RangeOverlap(cell, (char *)cell + cell->size, start, end))
        {
            return TRUE;
        }
    }
    return FALSE;
}

static long DLSize(Cell *list)
{
    Cell *cell;
    long size = 0;

    for (cell = list; cell; cell = cell->next)
    {
        size += cell->size;
    }
    return size;
}

void *OS_AllocFromHeap(OSArenaId id, OSHeapHandle heap, u32 size)
{
    OSHeapInfo *heapInfo;
    HeapDesc *hd;
    Cell *cell;
    Cell *newCell;
    long leftoverSize;
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];
    if (!heapInfo)
    {
        (void)OS_RestoreInterrupts(enabled);
        return NULL;
    }

    if (heap < 0)
    {
        heap = heapInfo->currentHeap;
    }

    hd = &heapInfo->heapArray[heap];

    size += HEADERSIZE;
    size = ROUND(size, ALIGNMENT);

    for (cell = hd->free; cell != NULL; cell = cell->next)
    {
        if ((long)size <= cell->size)
        {
            break;
        }
    }

    if (cell == NULL)
    {
        (void)OS_RestoreInterrupts(enabled);
        return NULL;
    }

    leftoverSize = cell->size - (long)size;
    if (leftoverSize < MINOBJSIZE)
    {

        hd->free = DLExtract(hd->free, cell);
    }
    else
    {

        cell->size = (long)size;

        newCell       = (Cell *)((char *)cell + size);
        newCell->size = leftoverSize;

        newCell->prev = cell->prev;
        newCell->next = cell->next;

        if (newCell->next != NULL)
        {
            newCell->next->prev = newCell;
        }

        if (newCell->prev != NULL)
        {
            newCell->prev->next = newCell;
        }
        else
        {
            hd->free = newCell;
        }
    }

    hd->allocated = DLAddFront(hd->allocated, cell);

    (void)OS_RestoreInterrupts(enabled);

    return (void *)((char *)cell + HEADERSIZE);
}

void *OS_AllocFixed(OSArenaId id, void **rstart, void **rend)
{
    OSHeapInfo *heapInfo;
    OSHeapHandle i;
    Cell *cell;
    Cell *newCell;
    HeapDesc *hd;
    void *start        = (void *)TRUNC(*rstart, ALIGNMENT);
    void *end          = (void *)ROUND(*rend, ALIGNMENT);
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];
    for (i = 0; i < heapInfo->numHeaps; i++)
    {
        hd = &heapInfo->heapArray[i];
        if (hd->size < 0)
        {
            continue;
        }

        if (DLOverlap(hd->allocated, start, end))
        {
            (void)OS_RestoreInterrupts(enabled);
            return NULL;
        }
    }

    for (i = 0; i < heapInfo->numHeaps; i++)
    {

        hd = &heapInfo->heapArray[i];

        if (hd->size < 0)
        {
            continue;
        }

        for (cell = hd->free; cell; cell = cell->next)
        {
            void *cellEnd = (char *)cell + cell->size;

            if ((char *)cellEnd <= (char *)start)
            {
                continue;
            }

            if ((char *)end <= (char *)cell)
            {
                break;
            }

            if (InRange(cell, (char *)start - HEADERSIZE, end) && InRange((char *)cellEnd, start, (char *)end + MINOBJSIZE))
            {
                if ((char *)cell < (char *)start)
                    start = (void *)cell;
                if ((char *)end < (char *)cellEnd)
                    end = (void *)cellEnd;

                hd->free = DLExtract(hd->free, cell);
                hd->size -= cell->size;
                continue;
            }

            if (InRange(cell, (char *)start - HEADERSIZE, end))
            {
                if ((char *)cell < (char *)start)
                {
                    start = (void *)cell;
                }

                newCell       = (Cell *)end;
                newCell->size = (char *)cellEnd - (char *)end;
                newCell->next = cell->next;
                if (newCell->next)
                {
                    newCell->next->prev = newCell;
                }
                newCell->prev = cell->prev;
                if (newCell->prev)
                {
                    newCell->prev->next = newCell;
                }
                else
                {
                    hd->free = newCell;
                }
                hd->size -= (char *)end - (char *)cell;
                break;
            }

            if (InRange((char *)cellEnd, start, (char *)end + MINOBJSIZE))
            {
                if ((char *)end < (char *)cellEnd)
                {
                    end = (void *)cellEnd;
                }

                hd->size -= (char *)cellEnd - (char *)start;
                cell->size = (char *)start - (char *)cell;
                continue;
            }

            newCell       = (Cell *)end;
            newCell->size = (char *)cellEnd - (char *)end;
            newCell->next = cell->next;
            if (newCell->next)
            {
                newCell->next->prev = newCell;
            }
            newCell->prev = cell;
            cell->next    = newCell;
            cell->size    = (char *)start - (char *)cell;
            hd->size -= (char *)end - (char *)start;
            break;
        }
    }

    *rstart = start;
    *rend   = end;

    (void)OS_RestoreInterrupts(enabled);
    return *rstart;
}

void OS_FreeToHeap(OSArenaId id, OSHeapHandle heap, void *ptr)
{
    OSHeapInfo *heapInfo;
    HeapDesc *hd;
    Cell *cell;

    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    if (heap < 0)
    {
        heap = heapInfo->currentHeap;
    }

    cell = (Cell *)((char *)ptr - HEADERSIZE);
    hd   = &heapInfo->heapArray[heap];

    hd->allocated = DLExtract(hd->allocated, cell);

    hd->free = DLInsert(hd->free, cell);

    (void)OS_RestoreInterrupts(enabled);
}

void OS_FreeAllToHeap(OSArenaId id, OSHeapHandle heap)
{
    OSHeapInfo *heapInfo;
    HeapDesc *hd;
    Cell *cell;

    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    if (heap < 0)
    {
        heap = heapInfo->currentHeap;
    }

    hd = &heapInfo->heapArray[heap];
    while ((cell = hd->allocated) != NULL)
    {
        hd->allocated = DLExtract(hd->allocated, cell);

        hd->free = DLInsert(hd->free, cell);
    }

    (void)OS_RestoreInterrupts(enabled);
}

OSHeapHandle OS_SetCurrentHeap(OSArenaId id, OSHeapHandle heap)
{
    OSHeapInfo *heapInfo;
    OSHeapHandle prev;
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    prev                  = heapInfo->currentHeap;
    heapInfo->currentHeap = heap;

    (void)OS_RestoreInterrupts(enabled);
    return prev;
}

void *OS_InitAlloc(OSArenaId id, void *arenaStart, void *arenaEnd, int maxHeaps)
{
    OSHeapInfo *heapInfo;
    u32 arraySize;
    OSHeapHandle i;
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo        = arenaStart;
    OSiHeapInfo[id] = heapInfo;

    arraySize           = sizeof(HeapDesc) * maxHeaps;
    heapInfo->heapArray = (void *)((u32)arenaStart + sizeof(OSHeapInfo));
    heapInfo->numHeaps  = maxHeaps;

    for (i = 0; i < heapInfo->numHeaps; i++)
    {
        HeapDesc *hd = &heapInfo->heapArray[i];

        hd->size = -1;
        hd->free = hd->allocated = NULL;
    }

    heapInfo->currentHeap = -1;

    arenaStart = (void *)((char *)heapInfo->heapArray + arraySize);
    arenaStart = (void *)ROUND(arenaStart, ALIGNMENT);

    heapInfo->arenaStart = arenaStart;
    heapInfo->arenaEnd   = (void *)TRUNC(arenaEnd, ALIGNMENT);

    (void)OS_RestoreInterrupts(enabled);
    return heapInfo->arenaStart;
}

void OS_ClearAlloc(OSArenaId id)
{
    OSiHeapInfo[id] = NULL;
}

OSHeapHandle OS_CreateHeap(OSArenaId id, void *start, void *end)
{
    OSHeapInfo *heapInfo;
    OSHeapHandle heap;
    HeapDesc *hd;
    Cell *cell;

    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    start = (void *)ROUND(start, ALIGNMENT);
    end   = (void *)TRUNC(end, ALIGNMENT);

    for (heap = 0; heap < heapInfo->numHeaps; heap++)
    {
        hd = &heapInfo->heapArray[heap];
        if (hd->size < 0)
        {
            hd->size = (char *)end - (char *)start;

            cell       = (Cell *)start;
            cell->prev = NULL;
            cell->next = NULL;
            cell->size = hd->size;

            hd->free      = cell;
            hd->allocated = 0;

            (void)OS_RestoreInterrupts(enabled);
            return heap;
        }
    }

    (void)OS_RestoreInterrupts(enabled);
    return -1;
}

void OS_DestroyHeap(OSArenaId id, OSHeapHandle heap)
{
    OSHeapInfo *heapInfo;
    HeapDesc *hd;
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    hd = &heapInfo->heapArray[heap];

    hd->size = -1;
    hd->free = hd->allocated = NULL;

    (void)OS_RestoreInterrupts(enabled);
}

void OS_AddToHeap(OSArenaId id, OSHeapHandle heap, void *start, void *end)
{
    OSHeapInfo *heapInfo;
    HeapDesc *hd;
    Cell *cell;
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    hd = &heapInfo->heapArray[heap];

    start = (void *)ROUND(start, ALIGNMENT);
    end   = (void *)TRUNC(end, ALIGNMENT);

    cell       = (Cell *)start;
    cell->size = (char *)end - (char *)start;

    hd->size += cell->size;
    hd->free = DLInsert(hd->free, cell);

    (void)OS_RestoreInterrupts(enabled);
}

#define OSi_CHECK(exp)                                                                                                                                                                                 \
    do                                                                                                                                                                                                 \
    {                                                                                                                                                                                                  \
        if (!(exp))                                                                                                                                                                                    \
        {                                                                                                                                                                                              \
            goto exit_OS_CheckHeap;                                                                                                                                                                    \
        }                                                                                                                                                                                              \
    } while (0)

s32 OS_CheckHeap(OSArenaId id, OSHeapHandle heap)
{
    OSHeapInfo *heapInfo;
    HeapDesc *hd;
    Cell *cell;
    long total         = 0;
    long free          = 0;
    long retValue      = -1;
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    if (heap == OS_CURRENT_HEAP_HANDLE)
    {
        heap = heapInfo->currentHeap;
    }

    OSi_CHECK(heapInfo->heapArray);
    OSi_CHECK(0 <= heap && heap < heapInfo->numHeaps);

    hd = &heapInfo->heapArray[heap];
    OSi_CHECK(0 <= hd->size);

    OSi_CHECK(hd->allocated == NULL || hd->allocated->prev == NULL);
    for (cell = hd->allocated; cell; cell = cell->next)
    {
        OSi_CHECK(InRange(cell, heapInfo->arenaStart, heapInfo->arenaEnd));
        OSi_CHECK(OFFSET(cell, ALIGNMENT) == 0);
        OSi_CHECK(cell->next == NULL || cell->next->prev == cell);
        OSi_CHECK(MINOBJSIZE <= cell->size);
        OSi_CHECK(OFFSET(cell->size, ALIGNMENT) == 0);

        total += cell->size;
        OSi_CHECK(0 < total && total <= hd->size);
    }

    OSi_CHECK(hd->free == NULL || hd->free->prev == NULL);
    for (cell = hd->free; cell; cell = cell->next)
    {
        OSi_CHECK(InRange(cell, heapInfo->arenaStart, heapInfo->arenaEnd));
        OSi_CHECK(OFFSET(cell, ALIGNMENT) == 0);
        OSi_CHECK(cell->next == NULL || cell->next->prev == cell);
        OSi_CHECK(MINOBJSIZE <= cell->size);
        OSi_CHECK(OFFSET(cell->size, ALIGNMENT) == 0);
        OSi_CHECK(cell->next == NULL || (char *)cell + cell->size < (char *)cell->next);

        total += cell->size;
        free += cell->size - HEADERSIZE;
        OSi_CHECK(0 < total && total <= hd->size);
    }

    OSi_CHECK(total == hd->size);
    retValue = free;

exit_OS_CheckHeap:
    (void)OS_RestoreInterrupts(enabled);
    return retValue;
}

u32 OS_ReferentSize(OSArenaId id, void *ptr)
{
    OSHeapInfo *heapInfo;
    Cell *cell;
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    cell = (Cell *)((char *)ptr - HEADERSIZE);

    (void)OS_RestoreInterrupts(enabled);
    return (u32)(cell->size - HEADERSIZE);
}

void OS_DumpHeap(OSArenaId id, OSHeapHandle heap) {}

void OS_VisitAllocated(OSArenaId id, OSAllocVisitor visitor)
{
    OSHeapInfo *heapInfo;
    u32 heap;
    Cell *cell;

    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    for (heap = 0; heap < heapInfo->numHeaps; heap++)
    {
        if (heapInfo->heapArray[heap].size >= 0)
        {
            for (cell = heapInfo->heapArray[heap].allocated; cell; cell = cell->next)
            {
                visitor((void *)((u8 *)cell + HEADERSIZE), (u32)(cell->size - HEADERSIZE));
            }
        }
    }

    (void)OS_RestoreInterrupts(enabled);
}

u32 OSi_GetTotalAllocSize(OSArenaId id, OSHeapHandle heap, BOOL isHeadInclude)
{
    OSHeapInfo *heapInfo;
    Cell *cell;
    u32 sum            = 0;
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    if (heap < 0)
    {
        heap = heapInfo->currentHeap;
    }

    if (isHeadInclude)
    {
        for (cell = heapInfo->heapArray[heap].allocated; cell; cell = cell->next)
        {
            sum += (u32)(cell->size);
        }
    }
    else
    {
        for (cell = heapInfo->heapArray[heap].allocated; cell; cell = cell->next)
        {
            sum += (u32)(cell->size - HEADERSIZE);
        }
    }

    (void)OS_RestoreInterrupts(enabled);

    return sum;
}

u32 OS_GetTotalFreeSize(OSArenaId id, OSHeapHandle heap)
{
    OSHeapInfo *heapInfo;
    Cell *cell;
    u32 sum            = 0;
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    if (heap < 0)
    {
        heap = heapInfo->currentHeap;
    }

    for (cell = heapInfo->heapArray[heap].free; cell; cell = cell->next)
    {
        sum += (u32)(cell->size - HEADERSIZE);
    }

    (void)OS_RestoreInterrupts(enabled);

    return sum;
}

u32 OS_GetMaxFreeSize(OSArenaId id, OSHeapHandle heap)
{
    OSHeapInfo *heapInfo;
    Cell *cell;
    u32 candidate      = 0;
    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];
    if (heap < 0)
    {
        heap = heapInfo->currentHeap;
    }

    for (cell = heapInfo->heapArray[heap].free; cell; cell = cell->next)
    {
        u32 size = (u32)(cell->size - HEADERSIZE);
        if (size > candidate)
        {
            candidate = size;
        }
    }

    (void)OS_RestoreInterrupts(enabled);

    return candidate;
}

void OS_ClearHeap(OSArenaId id, OSHeapHandle heap, void *start, void *end)
{
    OSHeapInfo *heapInfo;
    HeapDesc *hd;
    Cell *cell;

    OSIntrMode enabled = OS_DisableInterrupts();

    heapInfo = OSiHeapInfo[id];

    start = (void *)ROUND(start, ALIGNMENT);
    end   = (void *)TRUNC(end, ALIGNMENT);

    if (heap < 0)
    {
        heap = heapInfo->currentHeap;
    }

    hd       = &heapInfo->heapArray[heap];
    hd->size = (char *)end - (char *)start;

    cell       = (Cell *)start;
    cell->prev = NULL;
    cell->next = NULL;
    cell->size = hd->size;

    hd->free      = cell;
    hd->allocated = 0;

    (void)OS_RestoreInterrupts(enabled);
}