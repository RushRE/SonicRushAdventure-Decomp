#ifndef NNS_FND_HEAPCOMMON_H
#define NNS_FND_HEAPCOMMON_H

#include <nitro/types.h>
#include <nnsys/fnd/list.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define NNS_FND_HEAP_INVALID_HANDLE    NULL
#define NNS_FND_HEAP_DEFAULT_ALIGNMENT 4
#define NNSI_EXPHEAP_SIGNATURE         ('EXPH')
#define NNSI_FRMHEAP_SIGNATURE         ('FRMH')
#define NNSI_UNTHEAP_SIGNATURE         ('UNTH')

#define NNS_FND_HEAP_OPT_0_CLEAR    (1 << 0)
#define NNS_FND_HEAP_OPT_DEBUG_FILL (1 << 1)

#define NNS_FND_HEAP_ERROR_PRINT (1 << 0)

// --------------------
// ENUMS
// --------------------

enum
{
    NNS_FND_HEAP_FILL_NOUSE,
    NNS_FND_HEAP_FILL_ALLOC,
    NNS_FND_HEAP_FILL_FREE,

    NNS_FND_HEAP_FILL_MAX
};

// --------------------
// STRUCTS
// --------------------

typedef struct NNSiFndHeapHead NNSiFndHeapHead;
struct NNSiFndHeapHead
{
    u32 signature;

    NNSFndLink link;
    NNSFndList childList;

    void *heapStart;
    void *heapEnd;

    u32 attribute;
};

// --------------------
// TYPES
// --------------------

typedef NNSiFndHeapHead *NNSFndHeapHandle;

// --------------------
// MACROS
// --------------------

#define NNS_FndGetHeapStartAddress(heap) ((void *)(heap))
#define NNS_FndGetHeapEndAddress(heap)   (((NNSiFndHeapHead *)(heap))->heapEnd)

// --------------------
// FUNCTIONS
// --------------------

NNSFndHeapHandle NNS_FndFindContainHeap(const void *memBlock);

#define NNS_FndDumpHeap(heap)               ((void)0)
#define NNS_FndSetFillValForHeap(type, val) (0)
#define NNS_FndGetFillValForHeap(type)      (0)

#ifdef __cplusplus
}
#endif

#endif // NNS_FND_HEAPCOMMON_H