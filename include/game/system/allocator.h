#ifndef RUSH_ALLOCATOR_H
#define RUSH_ALLOCATOR_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define ALLOCATOR_SYSTEM_HEAP_SIZE 0x1C000  // ~114kb
#define ALLOCATOR_USER_HEAP_SIZE   0x186000 // ~1.5mb
#define ALLOCATOR_ITCM_HEAP_SIZE   0x4000   // ~16kb
#define ALLOCATOR_DTCM_HEAP_SIZE   0x1000   // ~4kb

// --------------------
// MACROS
// --------------------

// not sure why this is used, but sometimes the code will check against this instead of "NULL"
#define HeapNull OS_GetArenaLo(OS_ARENA_MAIN)

#define HeapAllocHead(heap, size) _AllocHead##heap(size)
#define HeapAllocTail(heap, size) _AllocTail##heap(size)
#define HeapFree(heap, memory)    _Free##heap(memory)

#define GetHeapTotalSize(heap)       _GetHeapTotalSize##heap()
#define GetHeapUnallocatedSize(heap) _GetHeapUnallocatedSize##heap()

// Used for large-scale allocations
#define KiB(num) ((num) * 1024)
#define MiB(num) (KiB(num) * 1024)

#define KB(num) ((num) * 1000)
#define MB(num) (KB(num) * 1000)

// --------------------
// ENUMS
// --------------------

enum AllocatorHeap
{
    HEAP_SYSTEM,
    HEAP_USER,
    HEAP_ITCM,
    HEAP_DTCM,
};

// --------------------
// VARIABLES
// --------------------

extern NNSFndAllocator heapSystemAllocator;
extern NNSFndAllocator heapUserAllocator;
extern NNSFndAllocator heapITCMAllocator;
extern NNSFndAllocator heapDTCMAllocator;

// --------------------
// FUNCTIONS
// --------------------

// Init
void InitAllocatorSystem(s32 sizeSystem, s32 sizeUser, s32 sizeITCM, s32 sizeDTCM);

// Heap functions
// use the HeapAlloc/HeapFree/etc macros instead of calling these functions directly!

// System heap functions
void *_AllocHeadHEAP_SYSTEM(u32 size);
void *_AllocTailHEAP_SYSTEM(u32 size);
void _FreeHEAP_SYSTEM(void *memory);
s32 _GetHeapUnallocatedSizeHEAP_SYSTEM(void);

// User heap functions
void *_AllocHeadHEAP_USER(u32 size);
void *_AllocTailHEAP_USER(u32 size);
void _FreeHEAP_USER(void *memory);
s32 _GetHeapTotalSizeHEAP_USER(void);

// ITCM heap functions
void *_AllocHeadHEAP_ITCM(u32 size);
void *_AllocTailHEAP_ITCM(u32 size);
void _FreeHEAP_ITCM(void *memory);

// DTCM heap functions
void *_AllocHeadHEAP_DTCM(u32 size);
void *_AllocTailHEAP_DTCM(u32 size);
void _FreeHEAP_DTCM(void *memory);

#ifdef __cplusplus
}
#endif

#endif // RUSH_ALLOCATOR_H