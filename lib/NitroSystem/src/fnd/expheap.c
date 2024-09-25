#include <stdlib.h>

#include <nitro.h>

#include <nnsys/misc.h>
#include <nnsys/fnd/expheap.h>
#include <nnsys/fnd/config.h>

#include "include/heapcommoni.h"

// --------------------
// CONSTANTS
// --------------------

#define MBLOCK_FREE_SIGNATURE ('FR')
#define MBLOCK_USED_SIGNATURE ('UD')
#define MAX_GROUPID           0xff
#define DEFAULT_GROUPID       0
#define MIN_ALIGNMENT         4
#define DEFAULT_ALLOC_MODE    NNS_FND_EXPHEAP_ALLOC_MODE_FIRST
#define MIN_FREE_BLOCK_SIZE   0 // CHANGE: was 4, now 0

// --------------------
// STRUCTS
// --------------------

typedef struct NNSiMemRegion NNSiMemRegion;

struct NNSiMemRegion
{
    void *start;
    void *end;
};

// --------------------
// INLINE FUNCTIONS
// --------------------

static NNS_FND_INLINE void *MaxPtr(void *a, void *b)
{
    return NNSiGetUIntPtr(a) > NNSiGetUIntPtr(b) ? a : b;
}

static NNS_FND_INLINE BOOL IsValidExpHeapHandle(NNSFndHeapHandle handle)
{
    if (handle == NNS_FND_HEAP_INVALID_HANDLE)
    {
        return FALSE;
    }

    {
        NNSiFndHeapHead *pHeapHd = handle;
        return pHeapHd->signature == NNSI_EXPHEAP_SIGNATURE;
    }
}

static NNS_FND_INLINE NNSiFndExpHeapHead *GetExpHeapHeadPtrFromHeapHead(NNSiFndHeapHead *pHHead)
{
    return AddU32ToPtr(pHHead, sizeof(NNSiFndHeapHead));
}

static NNS_FND_INLINE NNSiFndHeapHead *GetHeapHeadPtrFromExpHeapHead(NNSiFndExpHeapHead *pEHHead)
{
    return SubU32ToPtr(pEHHead, sizeof(NNSiFndHeapHead));
}

static NNS_FND_INLINE NNSiFndExpHeapHead *GetExpHeapHeadPtrFromHandle(NNSFndHeapHandle heap)
{
    return GetExpHeapHeadPtrFromHeapHead(heap);
}

static NNS_FND_INLINE void *GetMemPtrForMBlock(NNSiFndExpHeapMBlockHead *pMBlkHd)
{
    return AddU32ToPtr(pMBlkHd, sizeof(NNSiFndExpHeapMBlockHead));
}

static NNS_FND_INLINE const void *GetMemCPtrForMBlock(const NNSiFndExpHeapMBlockHead *pMBlkHd)
{
    return AddU32ToCPtr(pMBlkHd, sizeof(NNSiFndExpHeapMBlockHead));
}

static NNS_FND_INLINE NNSiFndExpHeapMBlockHead *GetMBlockHeadPtr(void *memBlock)
{
    return SubU32ToPtr(memBlock, sizeof(NNSiFndExpHeapMBlockHead));
}

static NNS_FND_INLINE const NNSiFndExpHeapMBlockHead *GetMBlockHeadCPtr(const void *memBlock)
{
    return SubU32ToCPtr(memBlock, sizeof(NNSiFndExpHeapMBlockHead));
}

static NNS_FND_INLINE void *GetMBlockEndAddr(NNSiFndExpHeapMBlockHead *pMBHead)
{
    return AddU32ToPtr(GetMemPtrForMBlock(pMBHead), pMBHead->blockSize);
}

static NNS_FND_INLINE u16 GetAlignmentForMBlock(const NNSiFndExpHeapMBlockHead *pMBlkHd)
{
    return (u16)NNSi_FndGetBitValue(pMBlkHd->attribute, 8, 7);
}

static NNS_FND_INLINE void SetAlignmentForMBlock(NNSiFndExpHeapMBlockHead *pMBlkHd, u16 alignment)
{
    NNSi_FndSetBitValue(pMBlkHd->attribute, 8, 7, alignment);
}

static NNS_FND_INLINE u16 GetGroupIDForMBlock(const NNSiFndExpHeapMBlockHead *pMBHead)
{
    return (u16)NNSi_FndGetBitValue(pMBHead->attribute, 0, 8);
}

static NNS_FND_INLINE void SetGroupIDForMBlock(NNSiFndExpHeapMBlockHead *pMBHead, u16 id)
{
    NNSi_FndSetBitValue(pMBHead->attribute, 0, 8, id);
}

static NNS_FND_INLINE u16 GetAllocDirForMBlock(const NNSiFndExpHeapMBlockHead *pMBHead)
{
    return (u16)NNSi_FndGetBitValue(pMBHead->attribute, 15, 1);
}

static NNS_FND_INLINE void SetAllocDirForMBlock(NNSiFndExpHeapMBlockHead *pMBHead, u16 mode)
{
    NNSi_FndSetBitValue(pMBHead->attribute, 15, 1, mode);
}

static NNS_FND_INLINE u16 GetAllocMode(NNSiFndExpHeapHead *pEHHead)
{
    return (u16)NNSi_FndGetBitValue(pEHHead->feature, 0, 1);
}

static NNS_FND_INLINE void SetAllocMode(NNSiFndExpHeapHead *pEHHead, u16 mode)
{
    NNSi_FndSetBitValue(pEHHead->feature, 0, 1, mode);
}

// --------------------
// FUNCTIONS
// --------------------

static void GetRegionOfMBlock(NNSiMemRegion *region, NNSiFndExpHeapMBlockHead *block)
{
    region->start = SubU32ToPtr(block, GetAlignmentForMBlock(block));
    region->end   = GetMBlockEndAddr(block);
}

static NNSiFndExpHeapMBlockHead *RemoveMBlock(NNSiFndExpMBlockList *list, NNSiFndExpHeapMBlockHead *block)
{
    NNSiFndExpHeapMBlockHead *const prev = block->pMBHeadPrev;
    NNSiFndExpHeapMBlockHead *const next = block->pMBHeadNext;

    if (prev)
    {
        prev->pMBHeadNext = next;
    }
    else
    {
        list->head = next;
    }

    if (next)
    {
        next->pMBHeadPrev = prev;
    }
    else
    {
        list->tail = prev;
    }

    return prev;
}

static NNSiFndExpHeapMBlockHead *InsertMBlock(NNSiFndExpMBlockList *list, NNSiFndExpHeapMBlockHead *target, NNSiFndExpHeapMBlockHead *prev)
{
    NNSiFndExpHeapMBlockHead *next;

    target->pMBHeadPrev = prev;

    if (prev)
    {
        next              = prev->pMBHeadNext;
        prev->pMBHeadNext = target;
    }
    else
    {
        next       = list->head;
        list->head = target;
    }

    target->pMBHeadNext = next;

    if (next)
    {
        next->pMBHeadPrev = target;
    }
    else
    {
        list->tail = target;
    }

    return target;
}

static NNS_FND_INLINE void AppendMBlock(NNSiFndExpMBlockList *list, NNSiFndExpHeapMBlockHead *block)
{
    (void)InsertMBlock(list, block, list->tail);
}

static NNSiFndExpHeapMBlockHead *InitMBlock(const NNSiMemRegion *pRegion, u16 signature)
{
    NNSiFndExpHeapMBlockHead *block = pRegion->start;

    block->signature   = signature;
    block->attribute   = 0;
    block->blockSize   = GetOffsetFromPtr(GetMemPtrForMBlock(block), pRegion->end);
    block->pMBHeadPrev = NULL;
    block->pMBHeadNext = NULL;

    return block;
}

static NNS_FND_INLINE NNSiFndExpHeapMBlockHead *InitFreeMBlock(const NNSiMemRegion *pRegion)
{
    return InitMBlock(pRegion, MBLOCK_FREE_SIGNATURE);
}

static NNSiFndHeapHead *InitExpHeap(void *startAddress, void *endAddress, u16 optFlag)
{
    NNSiFndHeapHead *pHeapHd       = startAddress;
    NNSiFndExpHeapHead *pExpHeapHd = GetExpHeapHeadPtrFromHeapHead(pHeapHd);

    NNSi_FndInitHeapHead(pHeapHd, NNSI_EXPHEAP_SIGNATURE, AddU32ToPtr(pExpHeapHd, sizeof(NNSiFndExpHeapHead)), endAddress, optFlag);

    pExpHeapHd->groupID = DEFAULT_GROUPID;
    pExpHeapHd->feature = 0;
    SetAllocMode(pExpHeapHd, DEFAULT_ALLOC_MODE);

    {
        NNSiFndExpHeapMBlockHead *pMBHead;
        NNSiMemRegion region;

        region.start = pHeapHd->heapStart;
        region.end   = pHeapHd->heapEnd;

        pMBHead = InitFreeMBlock(&region);

        pExpHeapHd->mbFreeList.head = pMBHead;
        pExpHeapHd->mbFreeList.tail = pMBHead;
        pExpHeapHd->mbUsedList.head = NULL;
        pExpHeapHd->mbUsedList.tail = NULL;

        return pHeapHd;
    }
}

static void *AllocUsedBlockFromFreeBlock(NNSiFndExpHeapHead *pEHHead, NNSiFndExpHeapMBlockHead *pMBHeadFree, void *mblock, u32 size, u16 direction)
{
    NNSiMemRegion freeRgnT;
    NNSiMemRegion freeRgnB;
    NNSiFndExpHeapMBlockHead *pMBHeadFreePrev;

    GetRegionOfMBlock(&freeRgnT, pMBHeadFree);
    freeRgnB.end   = freeRgnT.end;
    freeRgnB.start = AddU32ToPtr(mblock, size);
    freeRgnT.end   = SubU32ToPtr(mblock, sizeof(NNSiFndExpHeapMBlockHead));

    pMBHeadFreePrev = RemoveMBlock(&pEHHead->mbFreeList, pMBHeadFree);

    if (GetOffsetFromPtr(freeRgnT.start, freeRgnT.end) < sizeof(NNSiFndExpHeapMBlockHead) + MIN_FREE_BLOCK_SIZE)
    {
        freeRgnT.end = freeRgnT.start;
    }
    else
    {
        pMBHeadFreePrev = InsertMBlock(&pEHHead->mbFreeList, InitFreeMBlock(&freeRgnT), pMBHeadFreePrev);
    }

    if (GetOffsetFromPtr(freeRgnB.start, freeRgnB.end) < sizeof(NNSiFndExpHeapMBlockHead) + MIN_FREE_BLOCK_SIZE)
    {
        freeRgnB.start = freeRgnB.end;
    }
    else
    {
        (void)InsertMBlock(&pEHHead->mbFreeList, InitFreeMBlock(&freeRgnB), pMBHeadFreePrev);
    }

    FillAllocMemory(GetHeapHeadPtrFromExpHeapHead(pEHHead), freeRgnT.end, GetOffsetFromPtr(freeRgnT.end, freeRgnB.start));

    {
        NNSiFndExpHeapMBlockHead *pMBHeadNewUsed;
        NNSiMemRegion region;

        region.start = SubU32ToPtr(mblock, sizeof(NNSiFndExpHeapMBlockHead));
        region.end   = freeRgnB.start;

        pMBHeadNewUsed = InitMBlock(&region, MBLOCK_USED_SIGNATURE);
        SetAllocDirForMBlock(pMBHeadNewUsed, direction);
        SetAlignmentForMBlock(pMBHeadNewUsed, (u16)GetOffsetFromPtr(freeRgnT.end, pMBHeadNewUsed));
        SetGroupIDForMBlock(pMBHeadNewUsed, pEHHead->groupID);
        AppendMBlock(&pEHHead->mbUsedList, pMBHeadNewUsed);
    }

    return mblock;
}

static void *AllocFromHead(NNSiFndHeapHead *pHeapHd, u32 size, int alignment)
{
    NNSiFndExpHeapHead *pExpHeapHd = GetExpHeapHeadPtrFromHeapHead(pHeapHd);
    const BOOL bAllocFirst         = GetAllocMode(pExpHeapHd) == NNS_FND_EXPHEAP_ALLOC_MODE_FIRST;

    NNSiFndExpHeapMBlockHead *pMBlkHd      = NULL;
    NNSiFndExpHeapMBlockHead *pMBlkHdFound = NULL;
    u32 foundSize                          = 0xffffffff;
    void *foundMBlock                      = NULL;

    for (pMBlkHd = pExpHeapHd->mbFreeList.head; pMBlkHd; pMBlkHd = pMBlkHd->pMBHeadNext)
    {
        void *const mblock    = GetMemPtrForMBlock(pMBlkHd);
        void *const reqMBlock = NNSi_FndRoundUpPtr(mblock, alignment);
        const u32 offset      = GetOffsetFromPtr(mblock, reqMBlock);

        if (pMBlkHd->blockSize >= size + offset && foundSize > pMBlkHd->blockSize)
        {
            pMBlkHdFound = pMBlkHd;
            foundSize    = pMBlkHd->blockSize;
            foundMBlock  = reqMBlock;

            if (bAllocFirst || foundSize == size)
            {
                break;
            }
        }
    }

    if (!pMBlkHdFound)
    {
        return NULL;
    }

    return AllocUsedBlockFromFreeBlock(pExpHeapHd, pMBlkHdFound, foundMBlock, size, NNS_FND_EXPHEAP_ALLOC_DIR_FRONT);
}

static void *AllocFromTail(NNSiFndHeapHead *pHeapHd, u32 size, int alignment)
{
    NNSiFndExpHeapHead *pExpHeapHd = GetExpHeapHeadPtrFromHeapHead(pHeapHd);
    const BOOL bAllocFirst         = GetAllocMode(pExpHeapHd) == NNS_FND_EXPHEAP_ALLOC_MODE_FIRST;

    NNSiFndExpHeapMBlockHead *pMBlkHd      = NULL;
    NNSiFndExpHeapMBlockHead *pMBlkHdFound = NULL;
    u32 foundSize                          = 0xffffffff;
    void *foundMBlock                      = NULL;

    for (pMBlkHd = pExpHeapHd->mbFreeList.tail; pMBlkHd; pMBlkHd = pMBlkHd->pMBHeadPrev)
    {
        void *const mblock    = GetMemPtrForMBlock(pMBlkHd);
        void *const mblockEnd = AddU32ToPtr(mblock, pMBlkHd->blockSize);
        void *const reqMBlock = NNSi_FndRoundDownPtr(SubU32ToPtr(mblockEnd, size), alignment);

        if (ComparePtr(reqMBlock, mblock) >= 0 && foundSize > pMBlkHd->blockSize)
        {
            pMBlkHdFound = pMBlkHd;
            foundSize    = pMBlkHd->blockSize;
            foundMBlock  = reqMBlock;

            if (bAllocFirst || foundSize == size)
            {
                break;
            }
        }
    }

    if (!pMBlkHdFound)
    {
        return NULL;
    }

    return AllocUsedBlockFromFreeBlock(pExpHeapHd, pMBlkHdFound, foundMBlock, size, NNS_FND_EXPHEAP_ALLOC_DIR_REAR);
}

static BOOL RecycleRegion(NNSiFndExpHeapHead *pEHHead, const NNSiMemRegion *pRegion)
{
    NNSiFndExpHeapMBlockHead *pBlkPrFree = NULL;
    NNSiMemRegion freeRgn                = *pRegion;

    {
        NNSiFndExpHeapMBlockHead *pBlk;

        for (pBlk = pEHHead->mbFreeList.head; pBlk; pBlk = pBlk->pMBHeadNext)
        {
            if (pBlk < pRegion->start)
            {
                pBlkPrFree = pBlk;
                continue;
            }

            if (pBlk == pRegion->end)
            {
                freeRgn.end = GetMBlockEndAddr(pBlk);
                (void)RemoveMBlock(&pEHHead->mbFreeList, pBlk);
                FillNoUseMemory(GetHeapHeadPtrFromExpHeapHead(pEHHead), pBlk, sizeof(NNSiFndExpHeapMBlockHead));
            }
            break;
        }
    }

    if (pBlkPrFree && GetMBlockEndAddr(pBlkPrFree) == pRegion->start)
    {
        freeRgn.start = pBlkPrFree;
        pBlkPrFree    = RemoveMBlock(&pEHHead->mbFreeList, pBlkPrFree);
    }

    if (GetOffsetFromPtr(freeRgn.start, freeRgn.end) < sizeof(NNSiFndExpHeapMBlockHead))
    {
        return FALSE;
    }

    FillFreeMemory(GetHeapHeadPtrFromExpHeapHead(pEHHead), pRegion->start, GetOffsetFromPtr(pRegion->start, pRegion->end));
    (void)InsertMBlock(&pEHHead->mbFreeList, InitFreeMBlock(&freeRgn), pBlkPrFree);

    return TRUE;
}

NNSFndHeapHandle NNS_FndCreateExpHeapEx(void *startAddress, u32 size, u16 optFlag)
{
    void *endAddress;

    endAddress   = NNSi_FndRoundDownPtr(AddU32ToPtr(startAddress, size), MIN_ALIGNMENT);
    startAddress = NNSi_FndRoundUpPtr(startAddress, MIN_ALIGNMENT);

    if (NNSiGetUIntPtr(startAddress) > NNSiGetUIntPtr(endAddress)
        || GetOffsetFromPtr(startAddress, endAddress) < sizeof(NNSiFndHeapHead) + sizeof(NNSiFndExpHeapHead) + sizeof(NNSiFndExpHeapMBlockHead) + MIN_ALIGNMENT)
    {
        return NNS_FND_HEAP_INVALID_HANDLE;
    }

    {
        NNSiFndHeapHead *pHeapHd = InitExpHeap(startAddress, endAddress, optFlag);
        return pHeapHd;
    }
}

void NNS_FndDestroyExpHeap(NNSFndHeapHandle heap)
{
    NNSi_FndFinalizeHeap(heap);
}

void *NNS_FndAllocFromExpHeapEx(NNSFndHeapHandle heap, u32 size, int alignment)
{
    void *memory = NULL;

    if (size == 0)
    {
        size = 1;
    }

    size = NNSi_FndRoundUp(size, MIN_ALIGNMENT);

    if (alignment >= 0)
    {
        memory = AllocFromHead(heap, size, alignment);
    }
    else
    {
        memory = AllocFromTail(heap, size, -alignment);
    }

    return memory;
}

u32 NNS_FndResizeForMBlockExpHeap(NNSFndHeapHandle heap, void *memBlock, u32 size)
{
    NNSiFndExpHeapHead *pEHHead;
    NNSiFndExpHeapMBlockHead *pMBHead;

    pEHHead = GetExpHeapHeadPtrFromHandle(heap);
    pMBHead = GetMBlockHeadPtr(memBlock);

    size = NNSi_FndRoundUp(size, MIN_ALIGNMENT);
    if (size == pMBHead->blockSize)
    {
        return size;
    }

    if (size > pMBHead->blockSize)
    {
        void *crUsedEnd = GetMBlockEndAddr(pMBHead);
        NNSiFndExpHeapMBlockHead *block;

        for (block = pEHHead->mbFreeList.head; block; block = block->pMBHeadNext)
        {
            if (block == crUsedEnd)
            {
                break;
            }
        }

        if (!block || size > pMBHead->blockSize + sizeof(NNSiFndExpHeapMBlockHead) + block->blockSize)
        {
            return 0;
        }

        {
            NNSiMemRegion rgnNewFree;
            void *oldFreeStart;
            NNSiFndExpHeapMBlockHead *nextBlockPrev;

            GetRegionOfMBlock(&rgnNewFree, block);
            nextBlockPrev = RemoveMBlock(&pEHHead->mbFreeList, block);

            oldFreeStart     = rgnNewFree.start;
            rgnNewFree.start = AddU32ToPtr(memBlock, size);

            if (GetOffsetFromPtr(rgnNewFree.start, rgnNewFree.end) < sizeof(NNSiFndExpHeapMBlockHead))
            {
                rgnNewFree.start = rgnNewFree.end;
            }

            pMBHead->blockSize = GetOffsetFromPtr(memBlock, rgnNewFree.start);

            if (GetOffsetFromPtr(rgnNewFree.start, rgnNewFree.end) >= sizeof(NNSiFndExpHeapMBlockHead))
            {
                (void)InsertMBlock(&pEHHead->mbFreeList, InitFreeMBlock(&rgnNewFree), nextBlockPrev);
            }

            FillAllocMemory(heap, oldFreeStart, GetOffsetFromPtr(oldFreeStart, rgnNewFree.start));
        }
    }
    else
    {
        NNSiMemRegion rgnNewFree;
        const u32 oldBlockSize = pMBHead->blockSize;

        rgnNewFree.start = AddU32ToPtr(memBlock, size);
        rgnNewFree.end   = GetMBlockEndAddr(pMBHead);

        pMBHead->blockSize = size;

        if (!RecycleRegion(pEHHead, &rgnNewFree))
        {
            pMBHead->blockSize = oldBlockSize;
        }
    }

    return pMBHead->blockSize;
}

void NNS_FndFreeToExpHeap(NNSFndHeapHandle heap, void *memBlock)
{
    NNSiFndHeapHead *pHeapHd          = heap;
    NNSiFndExpHeapHead *pExpHeapHd    = GetExpHeapHeadPtrFromHandle(pHeapHd);
    NNSiFndExpHeapMBlockHead *pMBHead = GetMBlockHeadPtr(memBlock);
    NNSiMemRegion region;

    GetRegionOfMBlock(&region, pMBHead);
    (void)RemoveMBlock(&pExpHeapHd->mbUsedList, pMBHead);
    (void)RecycleRegion(pExpHeapHd, &region);
}

u32 NNS_FndGetTotalFreeSizeForExpHeap(NNSFndHeapHandle heap)
{
    u32 sumSize                 = 0;
    NNSiFndExpHeapHead *pEHHead = GetExpHeapHeadPtrFromHandle(heap);
    NNSiFndExpHeapMBlockHead *pMBHead;

    for (pMBHead = pEHHead->mbFreeList.head; pMBHead; pMBHead = pMBHead->pMBHeadNext)
    {
        sumSize += pMBHead->blockSize;
    }

    return sumSize;
}

u32 NNS_FndGetAllocatableSizeForExpHeapEx(NNSFndHeapHandle heap, int alignment)
{
    alignment = abs(alignment);

    {
        NNSiFndExpHeapHead *pEHHead = GetExpHeapHeadPtrFromHandle(heap);
        u32 maxSize                 = 0;
        u32 offsetMin               = 0xFFFFFFFF;
        NNSiFndExpHeapMBlockHead *pMBlkHd;

        for (pMBlkHd = pEHHead->mbFreeList.head; pMBlkHd; pMBlkHd = pMBlkHd->pMBHeadNext)
        {
            void *baseAddress = NNSi_FndRoundUpPtr(GetMemPtrForMBlock(pMBlkHd), alignment);

            if (NNSiGetUIntPtr(baseAddress) < NNSiGetUIntPtr(GetMBlockEndAddr(pMBlkHd)))
            {
                const u32 blockSize = GetOffsetFromPtr(baseAddress, GetMBlockEndAddr(pMBlkHd));
                const u32 offset    = GetOffsetFromPtr(GetMemPtrForMBlock(pMBlkHd), baseAddress);

                if (maxSize < blockSize || (maxSize == blockSize && offsetMin > offset))
                {
                    maxSize   = blockSize;
                    offsetMin = offset;
                }
            }
        }

        return maxSize;
    }
}

u16 NNS_FndSetAllocModeForExpHeap(NNSFndHeapHandle heap, u16 mode)
{
    NNSiFndExpHeapHead *const pEHHead = GetExpHeapHeadPtrFromHandle(heap);
    u16 oldMode                       = GetAllocMode(pEHHead);
    SetAllocMode(pEHHead, mode);

    return oldMode;
}

u16 NNS_FndGetAllocModeForExpHeap(NNSFndHeapHandle heap)
{
    return GetAllocMode(GetExpHeapHeadPtrFromHandle(heap));
}

u16 NNS_FndSetGroupIDForExpHeap(NNSFndHeapHandle heap, u16 groupID)
{
    NNSiFndExpHeapHead *pEHHead = GetExpHeapHeadPtrFromHandle(heap);
    u16 oldGroupID              = pEHHead->groupID;
    pEHHead->groupID            = groupID;

    return oldGroupID;
}

u16 NNS_FndGetGroupIDForExpHeap(NNSFndHeapHandle heap)
{
    return GetExpHeapHeadPtrFromHandle(heap)->groupID;
}

void NNS_FndVisitAllocatedForExpHeap(NNSFndHeapHandle heap, NNSFndHeapVisitor visitor, u32 userParam)
{
    NNSiFndExpHeapMBlockHead *pMBHead = GetExpHeapHeadPtrFromHandle(heap)->mbUsedList.head;

    while (pMBHead)
    {
        NNSiFndExpHeapMBlockHead *pMBHeadNext = pMBHead->pMBHeadNext;
        (*visitor)(GetMemPtrForMBlock(pMBHead), heap, userParam);
        pMBHead = pMBHeadNext;
    }
}

u32 NNS_FndGetSizeForMBlockExpHeap(const void *memBlock)
{
    return GetMBlockHeadCPtr(memBlock)->blockSize;
}

u16 NNS_FndGetGroupIDForMBlockExpHeap(const void *memBlock)
{
    return GetGroupIDForMBlock(GetMBlockHeadCPtr(memBlock));
}

u16 NNS_FndGetAllocDirForMBlockExpHeap(const void *memBlock)
{
    return GetAllocDirForMBlock(GetMBlockHeadCPtr(memBlock));
}
