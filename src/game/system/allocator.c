#include <game/system/allocator.h>
#include <nitro.h>

// --------------------
// FUNCTION DECLS
// --------------------

// Init
static void CreateHeapSystem(void);
static void CreateHeapUser(void);
static void CreateHeapITCM(void);
static void CreateHeapDTCM(void);

// NitroSystem Callbacks
static void *AllocForHeapSystem(NNSFndAllocator *pAllocator, u32 size);
static void FreeForHeapSystem(NNSFndAllocator *pAllocator, void *memory);
static void *AllocForHeapUser(NNSFndAllocator *pAllocator, u32 size);
static void FreeForHeapUser(NNSFndAllocator *pAllocator, void *memory);
static void *AllocForHeapITCM(NNSFndAllocator *pAllocator, u32 size);
static void FreeForHeapITCM(NNSFndAllocator *pAllocator, void *memory);
static void *AllocForHeapDTCM(NNSFndAllocator *pAllocator, u32 size);
static void FreeForHeapDTCM(NNSFndAllocator *pAllocator, void *memory);

// Internal
static void *HeapAllocInternal(NNSFndHeapHandle heap, u32 size, s32 alignment);
static void HeapFreeInternal(NNSFndHeapHandle heap, void *memory);
static u32 GetHeapUnallocatedSizeInternal(NNSFndHeapHandle heap);
static u32 GetHeapTotalSizeInternal(NNSFndHeapHandle heap);

// --------------------
// VARIABLES
// --------------------

void *heapITCM_EndAddr;
void *heapUser_EndAddr;
void *heapDTCM_EndAddr;
static NNSFndHeapHandle heapDTCM;
static NNSFndHeapHandle heapSystem;
void *heapSystem_StartAddr;
void *heapSystem_EndAddr;
void *heapUser_StartAddr;
void *heapITCM_StartAddr;
static NNSFndHeapHandle heapITCM;
void *heapDTCM_StartAddr;
static NNSFndHeapHandle heapUser;

static NNSFndAllocatorFunc heapUserAllocatorFunc;
static NNSFndAllocatorFunc heapDTCMAllocatorFunc;
static NNSFndAllocatorFunc heapITCMAllocatorFunc;
static NNSFndAllocatorFunc heapSystemAllocatorFunc;

NNSFndAllocator heapSystemAllocator;
NNSFndAllocator heapUserAllocator;
NNSFndAllocator heapITCMAllocator;
NNSFndAllocator heapDTCMAllocator;

// --------------------
// FUNCTIONS
// --------------------

void InitAllocatorSystem(s32 sizeSystem, s32 sizeUser, s32 sizeITCM, s32 sizeDTCM)
{
    // Init addresses for system heap
    if (sizeSystem < 0)
        sizeSystem = -sizeSystem;
    u8 *poolSystem       = (u8 *)OS_GetArenaLo(OS_ARENA_MAIN);
    heapSystem_StartAddr = poolSystem;
    heapSystem_EndAddr   = &poolSystem[sizeSystem];
    OS_SetArenaLo(OS_ARENA_MAIN, &poolSystem[sizeSystem]);
    heapSystem_EndAddr = OS_GetArenaLo(OS_ARENA_MAIN);

    // Init addresses for user heap
    if (sizeUser < 0)
        sizeUser = -sizeUser;
    u8 *poolUser       = (u8 *)OS_GetArenaLo(OS_ARENA_MAIN);
    heapUser_StartAddr = poolUser;
    heapUser_EndAddr   = &poolUser[sizeUser];
    OS_SetArenaLo(OS_ARENA_MAIN, &poolUser[sizeUser]);
    heapUser_EndAddr = OS_GetArenaLo(OS_ARENA_MAIN);

    // Init addresses for itcm heap
    if (sizeITCM < 0)
        sizeITCM = -sizeITCM;
    u8 *poolITCM       = (u8 *)OS_GetArenaLo(OS_ARENA_ITCM);
    heapITCM_StartAddr = poolITCM;
    heapITCM_EndAddr   = &poolITCM[sizeITCM];
    OS_SetArenaLo(OS_ARENA_ITCM, &poolITCM[sizeITCM]);
    heapITCM_EndAddr = OS_GetArenaLo(OS_ARENA_ITCM);

    // Init addresses for dtcm heap
    if (sizeDTCM < 0)
        sizeDTCM = -sizeDTCM;
    u8 *poolDTCM       = (u8 *)OS_GetArenaLo(OS_ARENA_DTCM);
    heapDTCM_StartAddr = poolDTCM;
    heapDTCM_EndAddr   = &poolDTCM[sizeDTCM];
    OS_SetArenaHi(OS_ARENA_DTCM, &poolDTCM[sizeDTCM]);
    OS_SetArenaLo(OS_ARENA_DTCM, heapDTCM_EndAddr);
    heapDTCM_EndAddr = OS_GetArenaLo(OS_ARENA_DTCM);

    // Create heaps
    CreateHeapSystem();
    CreateHeapUser();
    CreateHeapITCM();
    CreateHeapDTCM();
}

void CreateHeapSystem(void)
{
    void *endAddr   = heapSystem_EndAddr;
    void *startAddr = heapSystem_StartAddr;

    if (startAddr < endAddr)
    {
        NNSFndHeapHandle heap = NNS_FndCreateExpHeapEx(startAddr, endAddr - startAddr, 0);
        heapSystem             = heap;
        NNS_FndSetAllocModeForExpHeap(heap, 1);

        MI_CpuClear32(&heapSystemAllocator, sizeof(heapSystemAllocator));
        MI_CpuClear32(&heapSystemAllocatorFunc, sizeof(heapSystemAllocatorFunc));

        heapSystemAllocatorFunc.pfAlloc = AllocForHeapSystem;
        heapSystemAllocatorFunc.pfFree  = FreeForHeapSystem;
        heapSystemAllocator.pFunc       = &heapSystemAllocatorFunc;
        heapSystemAllocator.pHeap       = &heapSystem;
        heapSystemAllocator.heapParam1  = 32;
    }
}

void CreateHeapUser(void)
{
    void *endAddr   = heapUser_EndAddr;
    void *startAddr = heapUser_StartAddr;

    if (startAddr < endAddr)
    {
        NNSFndHeapHandle heap = NNS_FndCreateExpHeapEx(startAddr, endAddr - startAddr, 0);
        heapUser             = heap;
        NNS_FndSetAllocModeForExpHeap(heap, 1);

        MI_CpuClear32(&heapUserAllocator, sizeof(heapUserAllocator));
        MI_CpuClear32(&heapUserAllocatorFunc, sizeof(heapUserAllocatorFunc));

        heapUserAllocatorFunc.pfAlloc = AllocForHeapUser;
        heapUserAllocatorFunc.pfFree  = FreeForHeapUser;
        heapUserAllocator.pFunc       = &heapUserAllocatorFunc;
        heapUserAllocator.pHeap       = &heapUser;
        heapUserAllocator.heapParam1  = 32;
    }
}

void CreateHeapITCM(void)
{
    void *endAddr   = heapITCM_EndAddr;
    void *startAddr = heapITCM_StartAddr;

    if (startAddr < endAddr)
    {
        NNSFndHeapHandle heap = NNS_FndCreateExpHeapEx(startAddr, endAddr - startAddr, 0);
        heapITCM              = heap;
        NNS_FndSetAllocModeForExpHeap(heap, 1);

        MI_CpuClear32(&heapITCMAllocator, sizeof(heapITCMAllocator));
        MI_CpuClear32(&heapITCMAllocatorFunc, sizeof(heapITCMAllocatorFunc));

        heapITCMAllocatorFunc.pfAlloc = AllocForHeapITCM;
        heapITCMAllocatorFunc.pfFree  = FreeForHeapITCM;
        heapITCMAllocator.pFunc       = &heapITCMAllocatorFunc;
        heapITCMAllocator.pHeap       = &heapITCM;
        heapITCMAllocator.heapParam1  = 4;
    }
}

void CreateHeapDTCM(void)
{
    void *endAddr   = heapDTCM_EndAddr;
    void *startAddr = heapDTCM_StartAddr;

    if (startAddr < endAddr)
    {
        NNSFndHeapHandle heap = NNS_FndCreateExpHeapEx(startAddr, endAddr - startAddr, 0);
        heapDTCM              = heap;
        NNS_FndSetAllocModeForExpHeap(heap, 1);

        MI_CpuClear32(&heapDTCMAllocator, sizeof(heapDTCMAllocator));
        MI_CpuClear32(&heapDTCMAllocatorFunc, sizeof(heapDTCMAllocatorFunc));

        heapDTCMAllocatorFunc.pfAlloc = AllocForHeapDTCM;
        heapDTCMAllocatorFunc.pfFree  = FreeForHeapDTCM;
        heapDTCMAllocator.pFunc       = &heapDTCMAllocatorFunc;
        heapDTCMAllocator.pHeap       = &heapDTCM;
        heapDTCMAllocator.heapParam1  = 4;
    }
}

void *_AllocHeadHEAP_SYSTEM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 32;

    return HeapAllocInternal(heapSystem, allocSize, 32);
}

void *_AllocTailHEAP_SYSTEM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 32;

    return HeapAllocInternal(heapSystem, allocSize, -32);
}

void _FreeHEAP_SYSTEM(void *memory)
{
    if (HeapNull != memory)
    {
        OSIntrMode enable = OS_DisableInterrupts();
        HeapFreeInternal(heapSystem, memory);
        OS_RestoreInterrupts(enable);
    }
}

s32 _GetHeapUnallocatedSizeHEAP_SYSTEM(void)
{
    if (heapSystem_StartAddr < heapSystem_EndAddr)
        return GetHeapUnallocatedSizeInternal(heapSystem);
    else
        return 0;
}

void *_AllocHeadHEAP_USER(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 32;

    return HeapAllocInternal(heapUser, allocSize, 32);
}

void *_AllocTailHEAP_USER(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 32;

    return HeapAllocInternal(heapUser, allocSize, -32);
}

void _FreeHEAP_USER(void *memory)
{
    if (HeapNull != memory)
    {
        OSIntrMode enable = OS_DisableInterrupts();
        HeapFreeInternal(heapUser, memory);
        OS_RestoreInterrupts(enable);
    }
}

s32 _GetHeapTotalSizeHEAP_USER(void)
{
    if (heapUser_StartAddr < heapUser_EndAddr)
        return GetHeapTotalSizeInternal(heapUser);
    else
        return 0;
}

void *_AllocHeadHEAP_ITCM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 4;

    return HeapAllocInternal(heapITCM, allocSize, 4);
}

void *_AllocTailHEAP_ITCM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 4;

    return HeapAllocInternal(heapITCM, allocSize, -4);
}

void _FreeHEAP_ITCM(void *memory)
{
    if (HeapNull != memory)
    {
        OSIntrMode enable = OS_DisableInterrupts();
        HeapFreeInternal(heapITCM, memory);
        OS_RestoreInterrupts(enable);
    }
}

void *_AllocHeadHEAP_DTCM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 4;

    return HeapAllocInternal(heapDTCM, allocSize, 4);
}

void *_AllocTailHEAP_DTCM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 4;

    return HeapAllocInternal(heapDTCM, allocSize, -4);
}

void _FreeHEAP_DTCM(void *memory)
{
    if (HeapNull != memory)
    {
        OSIntrMode enable = OS_DisableInterrupts();
        HeapFreeInternal(heapDTCM, memory);
        OS_RestoreInterrupts(enable);
    }
}

// NitroSystem Callbacks
void *AllocForHeapSystem(NNSFndAllocator *pAllocator, u32 size)
{
    if ((s32)(pAllocator->heapParam1) >= 0)
        return HeapAllocHead(HEAP_SYSTEM, size);
    else
        return HeapAllocTail(HEAP_SYSTEM, size);
}

void FreeForHeapSystem(NNSFndAllocator *pAllocator, void *memory)
{
    HeapFree(HEAP_SYSTEM, memory);
}

void *AllocForHeapUser(NNSFndAllocator *pAllocator, u32 size)
{
    if ((s32)(pAllocator->heapParam1) >= 0)
        return HeapAllocHead(HEAP_USER, size);
    else
        return HeapAllocTail(HEAP_USER, size);
}

void FreeForHeapUser(NNSFndAllocator *pAllocator, void *memory)
{
    HeapFree(HEAP_USER, memory);
}

void *AllocForHeapITCM(NNSFndAllocator *pAllocator, u32 size)
{
    if ((s32)(pAllocator->heapParam1) >= 0)
        return HeapAllocHead(HEAP_ITCM, size);
    else
        return HeapAllocTail(HEAP_ITCM, size);
}

void FreeForHeapITCM(NNSFndAllocator *pAllocator, void *memory)
{
    HeapFree(HEAP_ITCM, memory);
}

void *AllocForHeapDTCM(NNSFndAllocator *pAllocator, u32 size)
{
    if ((s32)(pAllocator->heapParam1) >= 0)
        return HeapAllocHead(HEAP_DTCM, size);
    else
        return HeapAllocTail(HEAP_DTCM, size);
}

void FreeForHeapDTCM(NNSFndAllocator *pAllocator, void *memory)
{
    HeapFree(HEAP_DTCM, memory);
}

// Internal
void *HeapAllocInternal(NNSFndHeapHandle heap, u32 size, s32 alignment)
{
    OSIntrMode enable = OS_DisableInterrupts();
    void *memory      = NNS_FndAllocFromExpHeapEx(heap, size, alignment);
    OS_RestoreInterrupts(enable);

    if (memory != NULL)
    {
        return memory;
    }
    else
    {
        // ???
        // This matches but man what the heck
        HeapNull;
    }
}

void HeapFreeInternal(NNSFndHeapHandle heap, void *memory)
{
    if (HeapNull != memory)
    {
        OSIntrMode enable = OS_DisableInterrupts();
        NNS_FndFreeToExpHeap(heap, memory);
        OS_RestoreInterrupts(enable);
    }
}

u32 GetHeapUnallocatedSizeInternal(NNSFndHeapHandle heap)
{
    return NNS_FndGetTotalFreeSizeForExpHeap(heap);
}

u32 GetHeapTotalSizeInternal(NNSFndHeapHandle heap)
{
    return NNS_FndGetAllocatableSizeForExpHeapEx(heap, 4);
}