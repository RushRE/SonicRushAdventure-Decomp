
#include <nitro.h>

#include <nnsys/misc.h>
#include <nnsys/fnd/heapcommon.h>
#include <nnsys/fnd/expheap.h>
#include <nnsys/fnd/frameheap.h>
#include <nnsys/fnd/unitheap.h>
#include <nnsys/fnd/config.h>

#include "include/heapcommoni.h"

// --------------------
// VARIABLES
// --------------------

static NNSFndList sRootList;
static BOOL sRootListInitialized = FALSE;

// --------------------
// FUNCTIONS
// --------------------

static NNSiFndHeapHead *FindContainHeap(NNSFndList *pList, const void *memBlock)
{
    NNSiFndHeapHead *pHeapHd = NULL;
    while (NULL != (pHeapHd = NNS_FndGetNextListObject(pList, pHeapHd)))
    {
        if (NNSiGetUIntPtr(pHeapHd->heapStart) <= NNSiGetUIntPtr(memBlock) && NNSiGetUIntPtr(memBlock) < NNSiGetUIntPtr(pHeapHd->heapEnd))
        {
            NNSiFndHeapHead *pChildHeapHd = FindContainHeap(&pHeapHd->childList, memBlock);
            if (pChildHeapHd)
            {
                return pChildHeapHd;
            }

            return pHeapHd;
        }
    }

    return NULL;
}

static NNSFndList *FindListContainHeap(NNSiFndHeapHead *pHeapHd)
{
    NNSFndList *pList             = &sRootList;
    NNSiFndHeapHead *pContainHeap = FindContainHeap(&sRootList, pHeapHd);

    if (pContainHeap)
    {
        pList = &pContainHeap->childList;
    }

    return pList;
}

static NNS_FND_INLINE void DumpHeapList(void)
{
    return;
}

void NNSi_FndInitHeapHead(NNSiFndHeapHead *pHeapHd, u32 signature, void *heapStart, void *heapEnd, u16 optFlag)
{
    pHeapHd->signature = signature;

    pHeapHd->heapStart = heapStart;
    pHeapHd->heapEnd   = heapEnd;

    pHeapHd->attribute = 0;
    SetOptForHeap(pHeapHd, optFlag);

    FillNoUseMemory(pHeapHd, heapStart, GetOffsetFromPtr(heapStart, heapEnd));

    NNS_FND_INIT_LIST(&pHeapHd->childList, NNSiFndHeapHead, link);

    if (!sRootListInitialized)
    {
        NNS_FND_INIT_LIST(&sRootList, NNSiFndHeapHead, link);
        sRootListInitialized = TRUE;
    }

    NNS_FndAppendListObject(FindListContainHeap(pHeapHd), pHeapHd);
    DumpHeapList();
}

void NNSi_FndFinalizeHeap(NNSiFndHeapHead *pHeapHd)
{
    NNS_FndRemoveListObject(FindListContainHeap(pHeapHd), pHeapHd);
    DumpHeapList();
}

void NNSi_FndDumpHeapHead(NNSiFndHeapHead *pHeapHd)
{
    OS_Printf("[NNS Foundation ");

    switch (pHeapHd->signature)
    {
        case NNSI_EXPHEAP_SIGNATURE:
            OS_Printf("Exp");
            break;

        case NNSI_FRMHEAP_SIGNATURE:
            OS_Printf("Frame");
            break;

        case NNSI_UNTHEAP_SIGNATURE:
            OS_Printf("Unit");
            break;

        default:
            break;
    }

    OS_Printf(" Heap]\n");
    OS_Printf("    whole [%p - %p)\n", pHeapHd, pHeapHd->heapEnd);
}

NNSFndHeapHandle NNS_FndFindContainHeap(const void *memBlock)
{
    return FindContainHeap(&sRootList, memBlock);
}
