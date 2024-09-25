#include <nnsys/g3d/binres/res_struct_accessor.h>

// --------------------
// CONSTANTS
// --------------------

#define NNS_G3D_SIZE_NNSG3DRESJNTANM sizeof(NNSG3dResJntAnm)
#define NNS_G3D_SIZE_ROTMTX3         (3 * sizeof(u16))
#define NNS_G3D_SIZE_ROTMTX5         (5 * sizeof(u16))

// --------------------
// TYPES
// --------------------

typedef fx32 (*FrameIdxValueAccessFuncPtr)(const void *pDataHead, u32 frameIdx, u32 step, u32 offset);

// --------------------
// FUNCTIONS
// --------------------

BOOL NNSi_G3dIsValidAnmRes(const void *pRes)
{
    const NNSG3dResAnmCommon *p = (const NNSG3dResAnmCommon *)pRes;

    if (p->anmHeader.category0 == 'M' || p->anmHeader.category0 == 'J' || p->anmHeader.category0 == 'V')
    {
        if (p->anmHeader.category1 == 'CA' || p->anmHeader.category1 == 'VA' || p->anmHeader.category1 == 'MA' || p->anmHeader.category1 == 'TP' || p->anmHeader.category1 == 'TA')
            return TRUE;
    }

    return FALSE;
}

void *NNS_G3dGetAnmByIdx(const void *pRes, u32 idx)
{
    const NNSG3dResFileHeader *header;
    const NNSG3dResAnmSet *anmSet;
    const NNSG3dResDictAnmSetData *anmSetData;
    u32 *blks;

    header = (const NNSG3dResFileHeader *)pRes;
    blks   = (u32 *)((u8 *)header + header->headerSize);

    anmSet     = (const NNSG3dResAnmSet *)((u8 *)header + blks[0]);
    anmSetData = (const NNSG3dResDictAnmSetData *)NNS_G3dGetResDataByIdx(&anmSet->dict, idx);

    if (anmSetData)
    {
        return (void *)((u8 *)anmSet + anmSetData->offset);
    }

    return NULL;
}

void *NNS_G3dGetAnmByName(const void *pRes, const NNSG3dResName *pName)
{
    const NNSG3dResFileHeader *header;
    const NNSG3dResAnmSet *anmSet;
    const NNSG3dResDictAnmSetData *anmSetData;
    u32 *blks;
    header = (const NNSG3dResFileHeader *)pRes;
    blks   = (u32 *)((u8 *)header + header->headerSize);

    anmSet     = (const NNSG3dResAnmSet *)((u8 *)header + blks[0]);
    anmSetData = (const NNSG3dResDictAnmSetData *)NNS_G3dGetResDataByName(&anmSet->dict, pName);

    if (anmSetData)
    {
        return (void *)((u8 *)anmSet + anmSetData->offset);
    }

    return NULL;
}

const void *NNSi_G3dGetBinaryBlockFromFile(const u8 *pFileHead, u32 fileSignature, u32 blockSignature)
{
    u32 i                              = 0;
    const NNSG3dResFileHeader *pHeader = (const NNSG3dResFileHeader *)&pFileHead[0];

    if (pHeader->sigVal == fileSignature)
    {
        for (i = 0; i < pHeader->dataBlocks; i++)
        {
            const NNSG3dResDataBlockHeader *blk = NNS_G3dGetDataBlockHeaderByIdx(pHeader, i);

            if (blk->kind == blockSignature)
            {
                return (const void *)blk;
            }
        }
    }

    return NULL;
}

static BOOL IsValidAnimHeader(const NNSG3dResAnmHeader *pAnmHeader, u8 cat0, u16 cat1)
{
    return (BOOL)(pAnmHeader && pAnmHeader->category0 == cat0 && pAnmHeader->category1 == cat1);
}

const NNSG3dResVisAnm *NNS_G3dGetVisAnmByIdx(const NNSG3dResVisAnmSet *pAnmSet, u8 idx)
{
    const NNSG3dResDictVisAnmSetData *pSetData = (const NNSG3dResDictVisAnmSetData *)NNS_G3dGetResDataByIdx(&pAnmSet->dict, idx);

    return (const NNSG3dResVisAnm *)((u8 *)pAnmSet + pSetData->offset);
}

const NNSG3dResVisAnmSet *NNS_G3dGetVisAnmSet(const u8 *pFileHead)
{
    const void *pVisBlk = NNSi_G3dGetBinaryBlockFromFile(pFileHead, NNS_G3D_SIGNATURE_NSBVA, NNS_G3D_DATABLK_VIS_ANM);

    return (const NNSG3dResVisAnmSet *)pVisBlk;
}

const NNSG3dResName *NNSi_G3dGetTexPatAnmTexNameByIdx(const NNSG3dResTexPatAnm *pPatAnm, u8 texIdx)
{
    const NNSG3dResName *pNameArray = (const NNSG3dResName *)((const u8 *)pPatAnm + pPatAnm->ofsTexName);

    return &pNameArray[texIdx];
}

const NNSG3dResName *NNSi_G3dGetTexPatAnmPlttNameByIdx(const NNSG3dResTexPatAnm *pPatAnm, u8 plttIdx)
{
    const NNSG3dResName *pNameArray = (const NNSG3dResName *)((const u8 *)pPatAnm + pPatAnm->ofsPlttName);

    return &pNameArray[plttIdx];
}

const NNSG3dResTexPatAnmFV *NNSi_G3dGetTexPatAnmFVByFVIndex(const NNSG3dResTexPatAnm *pPatAnm, u32 idx, u32 fvIdx)
{
    const NNSG3dResDictTexPatAnmData *pAnmData = NNSi_G3dGetTexPatAnmDataByIdx(pPatAnm, idx);

    const NNSG3dResTexPatAnmFV *pfvArray = (const NNSG3dResTexPatAnmFV *)((u8 *)pPatAnm + pAnmData->offset);

    return &pfvArray[fvIdx];
}

const NNSG3dResTexPatAnmFV *NNSi_G3dGetTexPatAnmFV(const NNSG3dResTexPatAnm *pPatAnm, u32 idx, u32 frame)
{
    const NNSG3dResDictTexPatAnmData *pAnmData = NNSi_G3dGetTexPatAnmDataByIdx(pPatAnm, idx);
    {

        const NNSG3dResTexPatAnmFV *pfvArray = (const NNSG3dResTexPatAnmFV *)((u8 *)pPatAnm + pAnmData->offset);

        const u32 fvIdx = (u32)((fx32)pAnmData->ratioDataFrame * frame >> FX32_SHIFT);

        {
            u32 realFvIdx = fvIdx;

            while (realFvIdx > 0 && pfvArray[realFvIdx].idxFrame >= frame)
            {
                realFvIdx--;
            }

            while (realFvIdx + 1 < pAnmData->numFV && pfvArray[realFvIdx + 1].idxFrame <= frame)
            {
                realFvIdx++;
            }

            return &pfvArray[realFvIdx];
        }
    }
}

const NNSG3dResDictTexPatAnmData *NNSi_G3dGetTexPatAnmDataByIdx(const NNSG3dResTexPatAnm *pPatAnm, u32 idx)
{
    return (const NNSG3dResDictTexPatAnmData *)NNS_G3dGetResDataByIdx(&pPatAnm->dict, idx);
}

const NNSG3dResTexPatAnm *NNS_G3dGetTexPatAnmByIdx(const NNSG3dResTexPatAnmSet *pAnmSet, u8 idx)
{
    const NNSG3dResDictTexPatAnmSetData *pSetData = (const NNSG3dResDictTexPatAnmSetData *)NNS_G3dGetResDataByIdx(&pAnmSet->dict, idx);

    return (const NNSG3dResTexPatAnm *)((u8 *)pAnmSet + pSetData->offset);
}

const NNSG3dResTexPatAnmSet *NNS_G3dGetTexPatAnmSet(const u8 *pFileHead)
{
    const void *pVisBlk = NNSi_G3dGetBinaryBlockFromFile(pFileHead, NNS_G3D_SIGNATURE_NSBTP, NNS_G3D_DATABLK_TEXPAT_ANM);

    return (const NNSG3dResTexPatAnmSet *)pVisBlk;
}

const NNSG3dResTexSRTAnm *NNS_G3dGetTexSRTAnmByIdx(const NNSG3dResTexSRTAnmSet *pTexSRTSet, u8 idx)
{
    const NNSG3dResDictTexSRTAnmSetData *pSetData = (const NNSG3dResDictTexSRTAnmSetData *)NNS_G3dGetResDataByIdx(&pTexSRTSet->dict, idx);

    return (const NNSG3dResTexSRTAnm *)((u8 *)pTexSRTSet + pSetData->offset);
}

const NNSG3dResTexSRTAnmSet *NNS_G3dGetTexSRTAnmSet(const u8 *pFileHead)
{
    const void *pVisBlk = NNSi_G3dGetBinaryBlockFromFile(pFileHead, NNS_G3D_SIGNATURE_NSBTA, NNS_G3D_DATABLK_TEXSRT_ANM);

    return (const NNSG3dResTexSRTAnmSet *)pVisBlk;
}

const NNSG3dResMatCAnm *NNS_G3dGetMatCAnmByIdx(const NNSG3dResMatCAnmSet *pAnmSet, u8 idx)
{
    const NNSG3dResDictMatCAnmSetData *pSetData = (const NNSG3dResDictMatCAnmSetData *)NNS_G3dGetResDataByIdx(&pAnmSet->dict, idx);

    return (const NNSG3dResMatCAnm *)((u8 *)pAnmSet + pSetData->offset);
}

const NNSG3dResMatCAnmSet *NNS_G3dGetMatCAnmSet(const u8 *pFileHead)
{
    const void *pVisBlk = NNSi_G3dGetBinaryBlockFromFile(pFileHead, NNS_G3D_SIGNATURE_NSBMA, NNS_G3D_DATABLK_MATC_ANM);

    return (const NNSG3dResMatCAnmSet *)pVisBlk;
}

const NNSG3dResJntAnmSRTTag *NNS_G3dGetJntAnmSRTTag(const NNSG3dResJntAnm *pJntAnm, int nodeIdx)
{
    const u16 *pTagOffset = (const u16 *)((u8 *)pJntAnm + NNS_G3D_SIZE_NNSG3DRESJNTANM);
    const u16 tagOffset   = pTagOffset[nodeIdx];

    return (const NNSG3dResJntAnmSRTTag *)((u8 *)pJntAnm + tagOffset);
}

const NNSG3dResJntAnm *NNS_G3dGetJntAnmByIdx(const NNSG3dResJntAnmSet *pJntAnmSet, int idx)
{
    const NNSG3dResDictJntAnmSetData *pJntAnmData = (const NNSG3dResDictJntAnmSetData *)NNS_G3dGetResDataByIdx(&pJntAnmSet->dict, (u32)idx);

    return (const NNSG3dResJntAnm *)((u8 *)pJntAnmSet + pJntAnmData->offset);
}

const NNSG3dResJntAnmSet *NNS_G3dGetJntAnmSet(const u8 *pFileHead)
{
    const void *pVisBlk = NNSi_G3dGetBinaryBlockFromFile(pFileHead, NNS_G3D_SIGNATURE_NSBCA, NNS_G3D_DATABLK_JNT_ANM);

    return (const NNSG3dResJntAnmSet *)pVisBlk;
}
