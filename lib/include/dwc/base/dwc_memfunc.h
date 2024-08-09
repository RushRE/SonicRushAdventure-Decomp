#ifndef DWC_MEMFUNC_H
#define DWC_MEMFUNC_H

#include <nitro/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// ENUMS
// --------------------

typedef enum
{
    DWC_ALLOCTYPE_AUTH,
    DWC_ALLOCTYPE_AC,
    DWC_ALLOCTYPE_BM,
    DWC_ALLOCTYPE_UTIL,
    DWC_ALLOCTYPE_BASE,
    DWC_ALLOCTYPE_GS,
    DWC_ALLOCTYPE_ND,
    DWC_ALLOCTYPE_LAST
} DWCAllocType;

// --------------------
// TYPES
// --------------------

typedef void *(*DWCAllocEx)(DWCAllocType name, u32 size, int align);
typedef void (*DWCFreeEx)(DWCAllocType name, void *ptr, u32 size);

// --------------------
// FUNCTIONS
// --------------------

void DWC_SetMemFunc(DWCAllocEx alloc, DWCFreeEx free);
void *DWC_Alloc(DWCAllocType name, u32 size);
void *DWC_AllocEx(DWCAllocType name, u32 size, int align);
void DWC_Free(DWCAllocType name, void *ptr, u32 size);
void *DWC_Realloc(DWCAllocType name, void *ptr, u32 oldsize, u32 newsize);
void *DWC_ReallocEx(DWCAllocType name, void *ptr, u32 oldsize, u32 newsize, int align);

void *DWCi_GsMalloc(size_t size);
void *DWCi_GsRealloc(void *ptr, size_t size);
void DWCi_GsFree(void *ptr);
void *DWCi_GsMemalign(size_t boundary, size_t size);

#ifdef __cplusplus
}
#endif

#endif // DWC_MEMFUNC_H
