#ifndef NNS_G2D_NMC_LOAD_H
#define NNS_G2D_NMC_LOAD_H

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

BOOL NNS_G2dGetUnpackedMultiCellBank(void *pNmcrFile, NNSG2dMultiCellDataBank **ppMCBank);
void NNS_G2dUnpackNMC(NNSG2dMultiCellDataBank *pMCellData);
const NNSG2dMultiCellData *NNS_G2dGetMultiCellDataByIdx(const NNSG2dMultiCellDataBank *pDataBank, u16 idx);

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_NMC_LOAD_H