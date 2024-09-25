#ifndef NNS_G2D_NCE_LOAD_H
#define NNS_G2D_NCE_LOAD_H

#include <nitro.h>

#include <nnsys/g2d/g2d_config.h>
#include <nnsys/g2d/g2d_Data.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

BOOL NNS_G2dGetUnpackedCellBank(void * pNcerFile, NNSG2dCellDataBank ** ppCellBank);
void NNS_G2dUnpackNCE(NNSG2dCellDataBank * pCellData);
const NNSG2dCellData * NNS_G2dGetCellDataByIdx(const NNSG2dCellDataBank * pCellData, u16 idx);

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_NCE_LOAD_H