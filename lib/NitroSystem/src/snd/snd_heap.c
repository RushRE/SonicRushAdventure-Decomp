#include <nnsys/snd/heap.h>
#include <nnsys/misc.h>
#include <nnsys/fnd.h>

// --------------------
// CONSTANTS
// --------------------

#define HEAP_ALIGN 32

// --------------------
// MACROS
// --------------------

#define ROUNDUP(value, align) (((u32)(value) + ((align) - 1)) & ~((align) - 1))

// --------------------
// STRUCTS
// --------------------

typedef struct NNSSndHeap
{
    NNSFndHeapHandle handle;
    NNSFndList sectionList;
} NNSSndHeap;

typedef struct NNSSndHeapBlock
{
    NNSFndLink link;
    u32 size;
    NNSSndHeapDisposeCallback callback;
    u32 data1;
    u32 data2;
    u8 padding[0x20 - ((sizeof(NNSFndLink) + sizeof(NNSSndHeapDisposeCallback) + sizeof(u32) * 3) & 0x1f)];
    u32 buffer[0];
} NNSSndHeapBlock;

typedef struct NNSSndHeapSection
{
    NNSFndList blockList;
    NNSFndLink link;
} NNSSndHeapSection;

// --------------------
// FUNCTION DECLS
// --------------------

static void InitHeapSection(NNSSndHeapSection *section);
static BOOL InitHeap(NNSSndHeap *heap, NNSFndHeapHandle handle);
static BOOL NewSection(NNSSndHeap *heap);
static void EraseSync(void);

// --------------------
// FUNCTIONS
// --------------------

NNSSndHeapHandle NNS_SndHeapCreate(void *startAddress, u32 size)
{
    NNSSndHeap *heap;
    void *endAddress;
    NNSFndHeapHandle handle;

    endAddress   = (u8 *)startAddress + size;
    startAddress = (void *)ROUNDUP(startAddress, 4);

    if (startAddress > endAddress)
        return NNS_SND_HEAP_INVALID_HANDLE;

    size = (u32)((u8 *)endAddress - (u8 *)startAddress);
    if (size < sizeof(NNSSndHeap))
        return NNS_SND_HEAP_INVALID_HANDLE;

    size -= sizeof(NNSSndHeap);

    heap         = (NNSSndHeap *)startAddress;
    startAddress = heap + 1;

    handle = NNS_FndCreateFrmHeap(startAddress, size);
    if (handle == NNS_FND_HEAP_INVALID_HANDLE)
    {
        return NULL;
    }

    if (!InitHeap(heap, handle))
    {
        NNS_FndDestroyFrmHeap(handle);
        return NNS_SND_HEAP_INVALID_HANDLE;
    }

    return heap;
}

void NNS_SndHeapDestroy(NNSSndHeapHandle heap)
{
    NNS_SndHeapClear(heap);
    NNS_FndDestroyFrmHeap(heap->handle);
}

void NNS_SndHeapClear(NNSSndHeapHandle heap)
{
    NNSSndHeapSection *section = NULL;
    void *object;
    BOOL result;
    BOOL doCallback = FALSE;

    while ((section = (NNSSndHeapSection *)NNS_FndGetPrevListObject(&heap->sectionList, NULL)) != NULL)
    {

        object = NULL;
        while ((object = NNS_FndGetPrevListObject(&section->blockList, object)) != NULL)
        {
            NNSSndHeapBlock *block = (NNSSndHeapBlock *)object;
            if (block->callback != NULL)
            {
                block->callback(block->buffer, block->size, block->data1, block->data2);
                doCallback = TRUE;
            }
        }

        NNS_FndRemoveListObject(&heap->sectionList, section);
    }

    NNS_FndFreeToFrmHeap(heap->handle, NNS_FND_FRMHEAP_FREE_ALL);

    if (doCallback)
        EraseSync();

    result = NewSection(heap);
}

void *NNS_SndHeapAlloc(NNSSndHeapHandle heap, u32 size, NNSSndHeapDisposeCallback callback, u32 data1, u32 data2)
{
    NNSSndHeapSection *section;
    NNSSndHeapBlock *block;

    block = (NNSSndHeapBlock *)NNS_FndAllocFromFrmHeapEx(heap->handle, sizeof(NNSSndHeapBlock) + ROUNDUP(size, HEAP_ALIGN), HEAP_ALIGN);
    if (block == NULL)
        return NULL;

    section = (NNSSndHeapSection *)NNS_FndGetPrevListObject(&heap->sectionList, NULL);

    block->size     = size;
    block->callback = callback;
    block->data1    = data1;
    block->data2    = data2;
    NNS_FndAppendListObject(&section->blockList, block);

    return block->buffer;
}

int NNS_SndHeapSaveState(NNSSndHeapHandle heap)
{
    BOOL result;

    if (!NNS_FndRecordStateForFrmHeap(heap->handle, heap->sectionList.numObjects))
    {
        return -1;
    }

    if (!NewSection(heap))
    {
        result = NNS_FndFreeByStateToFrmHeap(heap->handle, 0);
        return -1;
    }

    return heap->sectionList.numObjects - 1;
}

void NNS_SndHeapLoadState(NNSSndHeapHandle heap, int level)
{
    NNSSndHeapSection *section;
    void *object = NULL;
    BOOL result;
    BOOL doCallback = FALSE;

    if (level == 0)
    {
        NNS_SndHeapClear(heap);
        return;
    }

    while (level < heap->sectionList.numObjects)
    {
        section = (NNSSndHeapSection *)NNS_FndGetPrevListObject(&heap->sectionList, NULL);

        while ((object = NNS_FndGetPrevListObject(&section->blockList, object)) != NULL)
        {
            NNSSndHeapBlock *block = (NNSSndHeapBlock *)object;
            if (block->callback != NULL)
            {
                block->callback(block->buffer, block->size, block->data1, block->data2);
                doCallback = TRUE;
            }
        }

        NNS_FndRemoveListObject(&heap->sectionList, section);
    }

    result = NNS_FndFreeByStateToFrmHeap(heap->handle, (u32)level);

    if (doCallback)
        EraseSync();

    result = NNS_FndRecordStateForFrmHeap(heap->handle, heap->sectionList.numObjects);

    result = NewSection(heap);
}

int NNS_SndHeapGetCurrentLevel(NNSSndHeapHandle heap)
{
    return heap->sectionList.numObjects - 1;
}

u32 NNS_SndHeapGetSize(NNSSndHeapHandle heap)
{
    return (u32)((u8 *)NNS_FndGetHeapEndAddress(heap->handle) - (u8 *)NNS_FndGetHeapStartAddress(heap->handle));
}

u32 NNS_SndHeapGetFreeSize(NNSSndHeapHandle heap)
{
    u32 size;

    size = NNS_FndGetAllocatableSizeForFrmHeapEx(heap->handle, HEAP_ALIGN);

    if (size < sizeof(NNSSndHeapBlock))
        return 0;
    size -= sizeof(NNSSndHeapBlock);

    size &= ~0x1f;

    return size;
}

static void InitHeapSection(NNSSndHeapSection *section)
{
    NNS_FND_INIT_LIST(&section->blockList, NNSSndHeapBlock, link);
}

static BOOL InitHeap(NNSSndHeap *heap, NNSFndHeapHandle handle)
{
    NNS_FND_INIT_LIST(&heap->sectionList, NNSSndHeapSection, link);
    heap->handle = handle;

    if (!NewSection(heap))
        return FALSE;

    return TRUE;
}

static BOOL NewSection(NNSSndHeap *heap)
{
    NNSSndHeapSection *section;

    section = (NNSSndHeapSection *)NNS_FndAllocFromFrmHeap(heap->handle, sizeof(NNSSndHeapSection));
    if (section == NULL)
        return FALSE;

    InitHeapSection(section);

    NNS_FndAppendListObject(&heap->sectionList, section);

    return TRUE;
}

static void EraseSync(void)
{
    u32 commandTag;

    commandTag = SND_GetCurrentCommandTag();
    (void)SND_FlushCommand(SND_COMMAND_BLOCK);
    SND_WaitForCommandProc(commandTag);
}
