#include <nnsys/g2d/g2d_Load.h>

// --------------------
// FUNCTIONS
// --------------------

NNSG2dBinaryBlockHeader *NNS_G2dFindBinaryBlock(NNSG2dBinaryFileHeader *pBinFileHeader, u32 signature)
{
    NNSG2dBinaryBlockHeader *pCursor = (NNSG2dBinaryBlockHeader *)((u32)pBinFileHeader + (u32)pBinFileHeader->headerSize);

    u16 count = 0;
    while (count < pBinFileHeader->dataBlocks)
    {
        if (pCursor->kind == signature)
        {
            return pCursor;
        }
        pCursor = (NNSG2dBinaryBlockHeader *)((u32)pCursor + pCursor->size);
        count++;
    }

    return NULL;
}

void NNSi_G2dUnpackUserExCellAttrBank(NNSG2dUserExCellAttrBank *pCellAttrBank)
{
    u16 i;

    pCellAttrBank->pCellAttrArray = NNS_G2D_UNPACK_OFFSET_PTR(pCellAttrBank->pCellAttrArray, pCellAttrBank);
    for (i = 0; i < pCellAttrBank->numCells; i++)
    {
        pCellAttrBank->pCellAttrArray[i].pAttr = NNS_G2D_UNPACK_OFFSET_PTR(pCellAttrBank->pCellAttrArray[i].pAttr, pCellAttrBank);
    }
}