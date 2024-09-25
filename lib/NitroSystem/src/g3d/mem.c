#include <nnsys/g3d/mem.h>

// --------------------
// FUNCTIONS
// --------------------

NNSG3dRenderObj *NNS_G3dAllocRenderObj(NNSFndAllocator *pAlloc)
{
    return (NNSG3dRenderObj *)NNS_FndAllocFromAllocator(pAlloc, sizeof(NNSG3dRenderObj));
}

void NNS_G3dFreeRenderObj(NNSFndAllocator *pAlloc, NNSG3dRenderObj *pRenderObj)
{
    NNS_FndFreeToAllocator(pAlloc, pRenderObj);
}

NNSG3dAnmObj *NNS_G3dAllocAnmObj(NNSFndAllocator *pAlloc, const void *pAnm, const NNSG3dResMdl *pMdl)
{
    u32 sz;

    sz = NNS_G3dAnmObjCalcSizeRequired(pAnm, pMdl);
    return (NNSG3dAnmObj *)NNS_FndAllocFromAllocator(pAlloc, sz);
}

void NNS_G3dFreeAnmObj(NNSFndAllocator *pAlloc, NNSG3dAnmObj *pAnmObj)
{
    NNS_FndFreeToAllocator(pAlloc, pAnmObj);
}

NNSG3dJntAnmResult *NNS_G3dAllocRecBufferJnt(NNSFndAllocator *pAlloc, const NNSG3dResMdl *pResMdl)
{
    u32 numJnt;

    numJnt = pResMdl->info.numNode;

    return (NNSG3dJntAnmResult *)NNS_FndAllocFromAllocator(pAlloc, NNS_G3D_RENDEROBJ_JNTBUFFER_SIZE(numJnt));
}

void NNS_G3dFreeRecBufferJnt(NNSFndAllocator *pAlloc, NNSG3dJntAnmResult *pRecBuf)
{
    NNS_FndFreeToAllocator(pAlloc, pRecBuf);
}

NNSG3dMatAnmResult *NNS_G3dAllocRecBufferMat(NNSFndAllocator *pAlloc, const NNSG3dResMdl *pResMdl)
{
    u32 numMat;

    numMat = pResMdl->info.numMat;

    return (NNSG3dMatAnmResult *)NNS_FndAllocFromAllocator(pAlloc, NNS_G3D_RENDEROBJ_MATBUFFER_SIZE(numMat));
}

void NNS_G3dFreeRecBufferMat(NNSFndAllocator *pAlloc, NNSG3dMatAnmResult *pRecBuf)
{
    NNS_FndFreeToAllocator(pAlloc, pRecBuf);
}
