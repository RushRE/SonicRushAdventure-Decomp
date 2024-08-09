// THIS FILE ONLY INCLUDED WHEN SDKS USE GAMESPY MEMORY MANAGER
// THIS FILE IS INTERNAL ONLY, FOR INTERFACE FUNCTIONS SEE NONPORT.H
#ifdef GSI_MEM_MANAGED

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
#ifndef __GSIMEMORY_H__
#define __GSIMEMORY_H__

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
#include "nonport.h"

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
#define BlockFlag_Used  (1 << 0) // block has an allocated object
#define BlockFlag_Final (1 << 1) // block is the final one

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// 128bit block tracker
typedef struct GSIMemoryBlock
{
    gsi_u32 mObjectSize;
    gsi_u32 mFlags;

    // For chaining
    struct GSIMemoryBlock *mNext;
    struct GSIMemoryBlock *mPrev;
} GSIMemoryBlock;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// [internal] Block list management
void gsiMemBlockSetPrev(struct GSIMemoryBlock *pThis, struct GSIMemoryBlock *theBlock);
void gsiMemBlockSetNext(struct GSIMemoryBlock *pThis, struct GSIMemoryBlock *theBlock);
struct GSIMemoryBlock *gsiMemBlockGetPrev(struct GSIMemoryBlock *pThis);
struct GSIMemoryBlock *gsiMemBlockGetNext(struct GSIMemoryBlock *pThis);

// [internal] Return the size of the object memory section of the block
gsi_i32 gsiMemBlockGetObjectSize(struct GSIMemoryBlock *pThis);
void gsiMemBlockSetObjectSize(struct GSIMemoryBlock *pThis, gsi_i32 theSize);

// [internal] Return a ptr to the start of the object memory
void *gsiMemBlockGetObjectPtr(struct GSIMemoryBlock *pThis);

// [internal] Flags
int gsiMemBlockIsFlagged(struct GSIMemoryBlock *pThis, gsi_u32 theFlag);
void gsiMemBlockSetFlag(struct GSIMemoryBlock *pThis, gsi_u32 theFlag);
void gsiMemBlockClearFlag(struct GSIMemoryBlock *pThis, gsi_u32 theFlag);

gsi_i32 gsiMemBlockGetTotalSize(struct GSIMemoryBlock *pThis);

// [internal] Get the next block by address
struct GSIMemoryBlock *gsiMemBlockGetLinearNext(struct GSIMemoryBlock *pThis);

// [internal] Manage block lists
void gsiMemBlockAddToList(struct GSIMemoryBlock *pThis, struct GSIMemoryBlock **theListHead, struct GSIMemoryBlock **theListTail);
void gsiMemBlockRemoveFromList(struct GSIMemoryBlock *pThis, struct GSIMemoryBlock **theListHead, struct GSIMemoryBlock **theListTail);

// [internal] Verify block memory
void gsiMemBlockAssertValid(struct GSIMemoryBlock *pThis);

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
typedef struct GSIMemoryMgr
{
    void *mPoolStart;  // start of the allocation pool
    gsi_i32 mPoolSize; // size of the pool

    // List of used blocks
    struct GSIMemoryBlock *mFirstUsedBlock; // first used
    struct GSIMemoryBlock *mLastUsedBlock;  // last used

    // List of free blocks
    struct GSIMemoryBlock *mFirstFreeBlock;
    struct GSIMemoryBlock *mLastFreeBlock;

    // Diagnostic information
    gsi_i32 mMemUsed; // includes block header size
    gsi_i32 mPeakMemoryUsage;

} GSIMemoryMgr;

static struct GSIMemoryMgr *gMemoryMgr;
static GSICriticalSection gMemCrit;

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// [internal] Obtain free memory block with desired size
struct GSIMemoryBlock *gsiMemMgrGetFreeBlock(struct GSIMemoryMgr *theMemMgr, gsi_i32 theDesiredSize);

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// [internal] Allocator functions
void *gsiManagedMalloc(size_t size);
void *gsiManagedRealloc(void *ptr, size_t size);
void gsiManagedFree(void *ptr);
void *gsiManagedMemAlign(size_t boundary, size_t size);

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
#endif // __GSIMEMORY_H__

#endif // GSI_MEM_MANAGED