#ifndef NNS_G2D_NEN_LOAD_H
#define NNS_G2D_NEN_LOAD_H

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

BOOL NNS_G2dGetUnpackedEntityBank(void *pNenrFile, NNSG2dEntityDataBank **ppEntityBank);
void NNS_G2dUnpackNEN(NNSG2dEntityDataBank *pDataBank);
const NNSG2dEntityData *NNS_G2dGetEntityDataByIdx(const NNSG2dEntityDataBank *pDataBank, u16 idx);

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_NEN_LOAD_H