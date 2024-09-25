#ifndef NNS_G2D_NCP_LOAD_H
#define NNS_G2D_NCP_LOAD_H

#include <nitro.h>

#include <nnsys/g2d/g2d_config.h>
#include <nnsys/g2d/g2d_Data.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

BOOL NNS_G2dGetUnpackedPaletteData(void *pNclrFile, NNSG2dPaletteData **ppPltData);
BOOL NNS_G2dGetUnpackedPaletteCompressInfo(void *pNclrFile, NNSG2dPaletteCompressInfo **ppPltCmpInfo);

void NNS_G2dUnpackNCL(NNSG2dPaletteData *pPlttData);
void NNSi_G2dUnpackNCLCmpInfo(NNSG2dPaletteCompressInfo *pPlttCmpData);

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_NCP_LOAD_H