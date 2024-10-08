#ifndef NNS_FND_ALLOCATOR_H
#define NNS_FND_ALLOCATOR_H

#include <nnsys/fnd/heapcommon.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// TYPES
// --------------------

typedef struct NNSFndAllocator NNSFndAllocator;

typedef void *(*NNSFndFuncAllocatorAlloc)(NNSFndAllocator *pAllocator, u32 size);
typedef void (*NNSFndFuncAllocatorFree)(NNSFndAllocator *pAllocator, void *memBlock);

// --------------------
// STRUCTS
// --------------------

typedef struct NNSFndAllocatorFunc NNSFndAllocatorFunc;
struct NNSFndAllocatorFunc
{
    NNSFndFuncAllocatorAlloc pfAlloc;
    NNSFndFuncAllocatorFree pfFree;
};

struct NNSFndAllocator
{
    NNSFndAllocatorFunc const *pFunc;
    void *pHeap;
    u32 heapParam1;
    u32 heapParam2;
};

// --------------------
// FUNCTIONS
// --------------------

void *NNS_FndAllocFromAllocator(NNSFndAllocator *pAllocator, u32 size);
void NNS_FndFreeToAllocator(NNSFndAllocator *pAllocator, void *memBlock);
void NNS_FndInitAllocatorForExpHeap(NNSFndAllocator *pAllocator, NNSFndHeapHandle heap, int alignment);
void NNS_FndInitAllocatorForFrmHeap(NNSFndAllocator *pAllocator, NNSFndHeapHandle heap, int alignment);
void NNS_FndInitAllocatorForUnitHeap(NNSFndAllocator *pAllocator, NNSFndHeapHandle heap);
void NNS_FndInitAllocatorForSDKHeap(NNSFndAllocator *pAllocator, OSArenaId id, OSHeapHandle heap);

#ifdef __cplusplus
}
#endif

#endif // NNS_FND_ALLOCATOR_H
