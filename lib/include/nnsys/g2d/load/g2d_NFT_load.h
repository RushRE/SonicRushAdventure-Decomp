#ifndef NNS_G2D_NFT_LOAD_H
#define NNS_G2D_NFT_LOAD_H

#include <nitro.h>

#include <nnsys/g2d/g2d_config.h>
#include <nnsys/g2d/g2d_Data.h>
#include <nnsys/g2d/g2d_Font.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

BOOL NNSi_G2dGetUnpackedFont(void *pNftrFile, NNSG2dFontInformation **ppFont);
void NNSi_G2dUnpackNFT(NNSG2dBinaryFileHeader *pHeader);

// --------------------
// INLINE FUNCTIONS
// --------------------

NNS_G2D_INLINE void NNS_G2dPrintFont(const NNSG2dFont *)
{
    return;
}

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_NFT_LOAD_H