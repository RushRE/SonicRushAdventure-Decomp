#ifndef NNS_G2D_NSC_LOAD_H
#define NNS_G2D_NSC_LOAD_H

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

BOOL NNS_G2dGetUnpackedScreenData(void *pNscrFile, NNSG2dScreenData **ppScrData);

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_NSC_LOAD_H