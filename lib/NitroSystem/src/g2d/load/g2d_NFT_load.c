
#include <nitro.h>

#include <nnsys/g2d/g2d_Load.h>
#include <nnsys/g2d/load/g2d_NFT_load.h>
#include <nnsys/g2d/g2d_config.h>

// --------------------
// FUNCTIONS
// --------------------

BOOL NNSi_G2dGetUnpackedFont(void *pNftrFile, NNSG2dFontInformation **ppRes)
{
#ifdef NNS_G2D_FONT_USE_OLD_RESOURCE
    BOOL isOldVer;
    
    if (NNS_G2dIsBinFileValid(pNftrFile, NNS_G2D_BINFILE_SIG_FONTDATA, NNS_G2D_NFTR_VER))
    {
        isOldVer = FALSE;
    }
    else if (NNS_G2dIsBinFileValid(pNftrFile, NNS_G2D_BINFILE_SIG_FONTDATA, NNS_G2D_NFTR_PREV_VER))
    {
        isOldVer = TRUE;
    }
    else
    {
        OS_Panic("Input file is invalid or obsolete. Please use latest fontcvtr.");
    }
#endif

    {
        NNSG2dBinaryFileHeader *pBinFile = (NNSG2dBinaryFileHeader *)pNftrFile;
        NNSG2dBinaryBlockHeader *pBinBlock;

        NNSi_G2dUnpackNFT(pBinFile);

        pBinBlock = NNS_G2dFindBinaryBlock(pBinFile, NNS_G2D_BINBLK_SIG_FINFDATA);

        if (pBinBlock == NULL)
        {
            *ppRes = NULL;
            return FALSE;
        }

        *ppRes = (NNSG2dFontInformation *)((u8 *)pBinBlock + sizeof(*pBinBlock));
#ifdef NNS_G2D_FONT_USE_OLD_RESOURCE
        if (isOldVer)
        {
            (*ppRes)->encoding               = (u8)(*ppRes)->defaultWidth.charWidth;
            (*ppRes)->defaultWidth.charWidth = 0;
        }
#endif
    }

#ifdef NNS_G2D_FONT_USE_OLD_RESOURCE
    return TRUE + isOldVer;
#else
    return TRUE;
#endif
}

static void NNS_G2D_INLINE ResolveOffset(void **ppOffset, void *pBase)
{
    *ppOffset = (void *)(*(u32 *)ppOffset + (u32)pBase);
}

void NNSi_G2dUnpackNFT(NNSG2dBinaryFileHeader *pHeader)
{
    NNSG2dBinaryBlockHeader *pBlock;
    NNSG2dFontInformation *pInfo = NULL;

    {
        int nBlocks = 0;
        pBlock      = (NNSG2dBinaryBlockHeader *)((u8 *)pHeader + pHeader->headerSize);

        while (nBlocks < pHeader->dataBlocks)
        {
            switch (pBlock->kind)
            {
                case NNS_G2D_BINBLK_SIG_FINFDATA: {
                    pInfo = (NNSG2dFontInformation *)((u8 *)pBlock + sizeof(*pBlock));

                    ResolveOffset((void **)&(pInfo->pGlyph), pHeader);

                    if (pInfo->pWidth != NULL)
                    {
                        ResolveOffset((void **)&(pInfo->pWidth), pHeader);
                    }

                    if (pInfo->pMap != NULL)
                    {
                        ResolveOffset((void **)&(pInfo->pMap), pHeader);
                    }
                }
                break;

                case NNS_G2D_BINBLK_SIG_CGLPDATA:
                    break;

                case NNS_G2D_BINBLK_SIG_CWDHDATA: {
                    NNSG2dFontWidth *pWidth = (NNSG2dFontWidth *)((u8 *)pBlock + sizeof(*pBlock));

                    if (pWidth->pNext != NULL)
                    {
                        ResolveOffset((void **)&(pWidth->pNext), pHeader);
                    }
                }
                break;

                case NNS_G2D_BINBLK_SIG_CMAPDATA: {
                    NNSG2dFontCodeMap *pMap = (NNSG2dFontCodeMap *)((u8 *)pBlock + sizeof(*pBlock));

                    if (pMap->pNext != NULL)
                    {
                        ResolveOffset((void **)&(pMap->pNext), pHeader);
                    }
                }
                break;

                default:
                    break;
            }

            pBlock = (NNSG2dBinaryBlockHeader *)((u8 *)pBlock + pBlock->size);
            nBlocks++;
        }
    }
}