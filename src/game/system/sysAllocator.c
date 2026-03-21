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

void *gHeapITCM_EndAddr;
void *gHeapUser_EndAddr;
void *gHeapDTCM_EndAddr;
static NNSFndHeapHandle sHeapDTCM;
static NNSFndHeapHandle sHeapSystem;
void *gHeapSystem_StartAddr;
void *gHeapSystem_EndAddr;
void *gHeapUser_StartAddr;
void *gHeapITCM_StartAddr;
static NNSFndHeapHandle sHeapITCM;
void *gHeapDTCM_StartAddr;
static NNSFndHeapHandle sHeapUser;

static NNSFndAllocatorFunc sHeapUserAllocatorFunc;
static NNSFndAllocatorFunc sHeapDTCMAllocatorFunc;
static NNSFndAllocatorFunc sHeapITCMAllocatorFunc;
static NNSFndAllocatorFunc sHeapSystemAllocatorFunc;

NNSFndAllocator gHeapSystemAllocator;
NNSFndAllocator gHeapUserAllocator;
NNSFndAllocator gHeapITCMAllocator;
NNSFndAllocator gHeapDTCMAllocator;

// --------------------
// FUNCTIONS
// --------------------

void InitAllocatorSystem(s32 sizeSystem, s32 sizeUser, s32 sizeITCM, s32 sizeDTCM)
{
    // Init addresses for system heap
    if (sizeSystem < 0)
        sizeSystem = -sizeSystem;
    u8 *poolSystem        = (u8 *)OS_GetArenaLo(OS_ARENA_MAIN);
    gHeapSystem_StartAddr = poolSystem;
    gHeapSystem_EndAddr   = &poolSystem[sizeSystem];
    OS_SetArenaLo(OS_ARENA_MAIN, &poolSystem[sizeSystem]);
    gHeapSystem_EndAddr = OS_GetArenaLo(OS_ARENA_MAIN);

    // Init addresses for user heap
    if (sizeUser < 0)
        sizeUser = -sizeUser;
    u8 *poolUser        = (u8 *)OS_GetArenaLo(OS_ARENA_MAIN);
    gHeapUser_StartAddr = poolUser;
    gHeapUser_EndAddr   = &poolUser[sizeUser];
    OS_SetArenaLo(OS_ARENA_MAIN, &poolUser[sizeUser]);
    gHeapUser_EndAddr = OS_GetArenaLo(OS_ARENA_MAIN);

    // Init addresses for itcm heap
    if (sizeITCM < 0)
        sizeITCM = -sizeITCM;
    u8 *poolITCM        = (u8 *)OS_GetArenaLo(OS_ARENA_ITCM);
    gHeapITCM_StartAddr = poolITCM;
    gHeapITCM_EndAddr   = &poolITCM[sizeITCM];
    OS_SetArenaLo(OS_ARENA_ITCM, &poolITCM[sizeITCM]);
    gHeapITCM_EndAddr = OS_GetArenaLo(OS_ARENA_ITCM);

    // Init addresses for dtcm heap
    if (sizeDTCM < 0)
        sizeDTCM = -sizeDTCM;
    u8 *poolDTCM        = (u8 *)OS_GetArenaLo(OS_ARENA_DTCM);
    gHeapDTCM_StartAddr = poolDTCM;
    gHeapDTCM_EndAddr   = &poolDTCM[sizeDTCM];
    OS_SetArenaHi(OS_ARENA_DTCM, &poolDTCM[sizeDTCM]);
    OS_SetArenaLo(OS_ARENA_DTCM, gHeapDTCM_EndAddr);
    gHeapDTCM_EndAddr = OS_GetArenaLo(OS_ARENA_DTCM);

    // Create heaps
    CreateHeapSystem();
    CreateHeapUser();
    CreateHeapITCM();
    CreateHeapDTCM();
}

void CreateHeapSystem(void)
{
    void *endAddr   = gHeapSystem_EndAddr;
    void *startAddr = gHeapSystem_StartAddr;

    if (startAddr < endAddr)
    {
        NNSFndHeapHandle heap = NNS_FndCreateExpHeapEx(startAddr, endAddr - startAddr, 0);
        sHeapSystem           = heap;
        NNS_FndSetAllocModeForExpHeap(heap, 1);

        MI_CpuClear32(&gHeapSystemAllocator, sizeof(gHeapSystemAllocator));
        MI_CpuClear32(&sHeapSystemAllocatorFunc, sizeof(sHeapSystemAllocatorFunc));

        sHeapSystemAllocatorFunc.pfAlloc = AllocForHeapSystem;
        sHeapSystemAllocatorFunc.pfFree  = FreeForHeapSystem;
        gHeapSystemAllocator.pFunc       = &sHeapSystemAllocatorFunc;
        gHeapSystemAllocator.pHeap       = &sHeapSystem;
        gHeapSystemAllocator.heapParam1  = 32;
    }
}

void CreateHeapUser(void)
{
    void *endAddr   = gHeapUser_EndAddr;
    void *startAddr = gHeapUser_StartAddr;

    if (startAddr < endAddr)
    {
        NNSFndHeapHandle heap = NNS_FndCreateExpHeapEx(startAddr, endAddr - startAddr, 0);
        sHeapUser              = heap;
        NNS_FndSetAllocModeForExpHeap(heap, 1);

        MI_CpuClear32(&gHeapUserAllocator, sizeof(gHeapUserAllocator));
        MI_CpuClear32(&sHeapUserAllocatorFunc, sizeof(sHeapUserAllocatorFunc));

        sHeapUserAllocatorFunc.pfAlloc = AllocForHeapUser;
        sHeapUserAllocatorFunc.pfFree  = FreeForHeapUser;
        gHeapUserAllocator.pFunc       = &sHeapUserAllocatorFunc;
        gHeapUserAllocator.pHeap       = &sHeapUser;
        gHeapUserAllocator.heapParam1  = 32;
    }
}

void CreateHeapITCM(void)
{
    void *endAddr   = gHeapITCM_EndAddr;
    void *startAddr = gHeapITCM_StartAddr;

    if (startAddr < endAddr)
    {
        NNSFndHeapHandle heap = NNS_FndCreateExpHeapEx(startAddr, endAddr - startAddr, 0);
        sHeapITCM             = heap;
        NNS_FndSetAllocModeForExpHeap(heap, 1);

        MI_CpuClear32(&gHeapITCMAllocator, sizeof(gHeapITCMAllocator));
        MI_CpuClear32(&sHeapITCMAllocatorFunc, sizeof(sHeapITCMAllocatorFunc));

        sHeapITCMAllocatorFunc.pfAlloc = AllocForHeapITCM;
        sHeapITCMAllocatorFunc.pfFree  = FreeForHeapITCM;
        gHeapITCMAllocator.pFunc       = &sHeapITCMAllocatorFunc;
        gHeapITCMAllocator.pHeap       = &sHeapITCM;
        gHeapITCMAllocator.heapParam1  = 4;
    }
}

void CreateHeapDTCM(void)
{
    void *endAddr   = gHeapDTCM_EndAddr;
    void *startAddr = gHeapDTCM_StartAddr;

    if (startAddr < endAddr)
    {
        NNSFndHeapHandle heap = NNS_FndCreateExpHeapEx(startAddr, endAddr - startAddr, 0);
        sHeapDTCM             = heap;
        NNS_FndSetAllocModeForExpHeap(heap, 1);

        MI_CpuClear32(&gHeapDTCMAllocator, sizeof(gHeapDTCMAllocator));
        MI_CpuClear32(&sHeapDTCMAllocatorFunc, sizeof(sHeapDTCMAllocatorFunc));

        sHeapDTCMAllocatorFunc.pfAlloc = AllocForHeapDTCM;
        sHeapDTCMAllocatorFunc.pfFree  = FreeForHeapDTCM;
        gHeapDTCMAllocator.pFunc       = &sHeapDTCMAllocatorFunc;
        gHeapDTCMAllocator.pHeap       = &sHeapDTCM;
        gHeapDTCMAllocator.heapParam1  = 4;
    }
}

void *_AllocHeadHEAP_SYSTEM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 32;

    return HeapAllocInternal(sHeapSystem, allocSize, 32);
}

void *_AllocTailHEAP_SYSTEM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 32;

    return HeapAllocInternal(sHeapSystem, allocSize, -32);
}

void _FreeHEAP_SYSTEM(void *memory)
{
    if (HeapNull != memory)
    {
        OSIntrMode enable = OS_DisableInterrupts();
        HeapFreeInternal(sHeapSystem, memory);
        OS_RestoreInterrupts(enable);
    }
}

s32 _GetHeapUnallocatedSizeHEAP_SYSTEM(void)
{
    if (gHeapSystem_StartAddr < gHeapSystem_EndAddr)
        return GetHeapUnallocatedSizeInternal(sHeapSystem);
    else
        return 0;
}

void *_AllocHeadHEAP_USER(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 32;

    return HeapAllocInternal(sHeapUser, allocSize, 32);
}

void *_AllocTailHEAP_USER(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 32;

    return HeapAllocInternal(sHeapUser, allocSize, -32);
}

void _FreeHEAP_USER(void *memory)
{
    if (HeapNull != memory)
    {
        OSIntrMode enable = OS_DisableInterrupts();
        HeapFreeInternal(sHeapUser, memory);
        OS_RestoreInterrupts(enable);
    }
}

s32 _GetHeapTotalSizeHEAP_USER(void)
{
    if (gHeapUser_StartAddr < gHeapUser_EndAddr)
        return GetHeapTotalSizeInternal(sHeapUser);
    else
        return 0;
}

void *_AllocHeadHEAP_ITCM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 4;

    return HeapAllocInternal(sHeapITCM, allocSize, 4);
}

void *_AllocTailHEAP_ITCM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 4;

    return HeapAllocInternal(sHeapITCM, allocSize, -4);
}

void _FreeHEAP_ITCM(void *memory)
{
    if (HeapNull != memory)
    {
        OSIntrMode enable = OS_DisableInterrupts();
        HeapFreeInternal(sHeapITCM, memory);
        OS_RestoreInterrupts(enable);
    }
}

void *_AllocHeadHEAP_DTCM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 4;

    return HeapAllocInternal(sHeapDTCM, allocSize, 4);
}

void *_AllocTailHEAP_DTCM(u32 size)
{
    u32 allocSize = size;
    if (size == 0)
        allocSize = 4;

    return HeapAllocInternal(sHeapDTCM, allocSize, -4);
}

void _FreeHEAP_DTCM(void *memory)
{
    if (HeapNull != memory)
    {
        OSIntrMode enable = OS_DisableInterrupts();
        HeapFreeInternal(sHeapDTCM, memory);
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