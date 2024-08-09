#ifndef NNSG3D_SBC_INLINE_H
#define NNSG3D_SBC_INLINE_H

// --------------------
// INLINE FUNCTIONS
// --------------------

NNS_G3D_INLINE BOOL NNSi_G3dCallBackCheck_A(NNSG3dRS *rs, u8 cmd, NNSG3dSbcCallBackTiming *pTiming)
{
    *pTiming = NNSi_CheckPossibilityOfCallBack(rs, cmd);
    if (*pTiming == NNS_G3D_SBC_CALLBACK_TIMING_A)
    {
        rs->flag &= ~NNS_G3D_RSFLAG_SKIP;
        (*rs->cbVecFunc[cmd])(rs);

        *pTiming = NNSi_CheckPossibilityOfCallBack(rs, cmd);
        return (BOOL)(rs->flag & NNS_G3D_RSFLAG_SKIP);
    }
    else
    {
        return FALSE;
    }
}

NNS_G3D_INLINE BOOL NNSi_G3dCallBackCheck_B(NNSG3dRS *rs, u8 cmd, NNSG3dSbcCallBackTiming *pTiming)
{
    if (*pTiming == NNS_G3D_SBC_CALLBACK_TIMING_B)
    {
        rs->flag &= ~NNS_G3D_RSFLAG_SKIP;
        (*rs->cbVecFunc[cmd])(rs);

        *pTiming = NNSi_CheckPossibilityOfCallBack(rs, cmd);
        return (BOOL)(rs->flag & NNS_G3D_RSFLAG_SKIP);
    }
    else
    {
        return FALSE;
    }
}

NNS_G3D_INLINE BOOL NNSi_G3dCallBackCheck_C(NNSG3dRS *rs, u8 cmd, NNSG3dSbcCallBackTiming timing)
{
    if (timing == NNS_G3D_SBC_CALLBACK_TIMING_C)
    {
        rs->flag &= ~NNS_G3D_RSFLAG_SKIP;
        (*rs->cbVecFunc[cmd])(rs);
        return (BOOL)(rs->flag & NNS_G3D_RSFLAG_SKIP);
    }
    else
    {
        return FALSE;
    }
}

NNS_G3D_INLINE NNSG3dSbcCallBackTiming NNSi_CheckPossibilityOfCallBack(NNSG3dRS *rs, u8 cmd)
{
    if (rs->cbVecFunc[cmd])
    {
        return (NNSG3dSbcCallBackTiming)rs->cbVecTiming[cmd];
    }
    else
    {
        return NNS_G3D_SBC_CALLBACK_TIMING_NONE;
    }
}

NNS_G3D_INLINE void NNS_G3dRSSetCallBack(NNSG3dRS *rs, NNSG3dSbcCallBackFunc func, u8 cmd, NNSG3dSbcCallBackTiming timing)
{
    rs->cbVecFunc[cmd]   = func;
    rs->cbVecTiming[cmd] = timing;
}

NNS_G3D_INLINE void NNS_G3dRSResetCallBack(NNSG3dRS *rs, u8 cmd)
{
    rs->cbVecFunc[cmd]   = NULL;
    rs->cbVecTiming[cmd] = (u8)NNS_G3D_SBC_CALLBACK_TIMING_NONE;
}

NNS_G3D_INLINE NNSG3dRenderObj *NNS_G3dRSGetRenderObj(NNSG3dRS *rs)
{
    return rs->pRenderObj;
}

NNS_G3D_INLINE NNSG3dMatAnmResult *NNS_G3dRSGetMatAnmResult(NNSG3dRS *rs)
{
    return rs->pMatAnmResult;
}

NNS_G3D_INLINE NNSG3dJntAnmResult *NNS_G3dRSGetJntAnmResult(NNSG3dRS *rs)
{
    return rs->pJntAnmResult;
}

NNS_G3D_INLINE NNSG3dVisAnmResult *NNS_G3dRSGetVisAnmResult(NNSG3dRS *rs)
{
    return rs->pVisAnmResult;
}

NNS_G3D_INLINE u8 *NNS_G3dRSGetSbcPtr(NNSG3dRS *rs)
{
    return rs->c;
}

NNS_G3D_INLINE void NNS_G3dRSSetFlag(NNSG3dRS *rs, NNSG3dRSFlag flag)
{
    rs->flag |= flag;
}

NNS_G3D_INLINE void NNS_G3dRSResetFlag(NNSG3dRS *rs, NNSG3dRSFlag flag)
{
    rs->flag &= ~flag;
}

NNS_G3D_INLINE int NNS_G3dRSGetCurrentMatID(const NNSG3dRS *rs)
{
    if (rs->flag & NNS_G3D_RSFLAG_CURRENT_MAT_VALID)
    {
        return rs->currentMat;
    }
    else
    {
        return -1;
    }
}

NNS_G3D_INLINE int NNS_G3dRSGetCurrentNodeID(const NNSG3dRS *rs)
{
    if (rs->flag & NNS_G3D_RSFLAG_CURRENT_NODE_VALID)
    {
        return rs->currentNode;
    }
    else
    {
        return -1;
    }
}

NNS_G3D_INLINE int NNS_G3dRSGetCurrentNodeDescID(const NNSG3dRS *rs)
{
    if (rs->flag & NNS_G3D_RSFLAG_CURRENT_NODEDESC_VALID)
    {
        return rs->currentNodeDesc;
    }
    else
    {
        return -1;
    }
}

NNS_G3D_INLINE fx32 NNS_G3dRSGetPosScale(const NNSG3dRS *rs)
{
    return rs->posScale;
}

NNS_G3D_INLINE fx32 NNS_G3dRSGetInvPosScale(const NNSG3dRS *rs)
{
    return rs->invPosScale;
}

#endif // NNSG3D_SBC_INLINE_H