#ifndef NNS_G2D_LOAD_H
#define NNS_G2D_LOAD_H

#include <nitro.h>

#ifdef __cplusplus
extern "C"
{
#endif

#include <nnsys/g2d/load/g2d_NCE_load.h>
#include <nnsys/g2d/load/g2d_NAN_load.h>
#include <nnsys/g2d/load/g2d_NEN_load.h>
#include <nnsys/g2d/load/g2d_NMC_load.h>
#include <nnsys/g2d/load/g2d_NCG_load.h>
#include <nnsys/g2d/load/g2d_NCL_load.h>
#include <nnsys/g2d/load/g2d_NSC_load.h>
#include <nnsys/g2d/load/g2d_NFT_load.h>

// --------------------
// MACROS
// --------------------

#define BIN_FILE_VERSION(EXT) NNS_G2dMakeVersionData(NNS_G2D_##EXT##_MAJOR_VER, NNS_G2D_##EXT##_MINOR_VER)

// --------------------
// FUNCTIONS
// --------------------

NNSG2dBinaryBlockHeader *NNS_G2dFindBinaryBlock(NNSG2dBinaryFileHeader *pBinFileHeader, u32 signature);
void NNSi_G2dUnpackUserExCellAttrBank(NNSG2dUserExCellAttrBank *pCellAttrBank);

// --------------------
// INLINE FUNCTIONS
// --------------------

NNS_G2D_INLINE BOOL NNSi_G2dIsBinFileSignatureValid(const NNSG2dBinaryFileHeader *pBinFile, u32 binFileSig)
{
    if (pBinFile != NULL)
    {
        if ((pBinFile->signature == binFileSig))
        {
            return TRUE;
        }
    }

    return FALSE;
}

NNS_G2D_INLINE BOOL NNSi_G2dIsBinFileVersionValid(const NNSG2dBinaryFileHeader *pBinFile, u16 version)
{
    if (pBinFile != NULL)
    {
        if (pBinFile->version >= version)
        {
            return TRUE;
        }
    }

    return FALSE;
}

NNS_G2D_INLINE BOOL NNS_G2dIsBinFileValid(const NNSG2dBinaryFileHeader *pBinFile, u32 binFileSig, u16 version)
{
    if (pBinFile != NULL)
    {
        return NNSi_G2dIsBinFileSignatureValid(pBinFile, binFileSig) && NNSi_G2dIsBinFileVersionValid(pBinFile, version);
    }

    return FALSE;
}

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_LOAD_H