#ifndef NNS_G2D_NCG_LOAD_H
#define NNS_G2D_NCG_LOAD_H

#include <nitro.h>

#include <nnsys/g2d/g2d_config.h>
#include <nnsys/g2d/g2d_Data.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

BOOL NNS_G2dGetUnpackedCharacterData(void * pNcgrFile, NNSG2dCharacterData ** ppCharData);
void NNS_G2dUnpackNCG(NNSG2dCharacterData * pCharData);
BOOL NNS_G2dGetUnpackedBGCharacterData(void * pNcgrFile, NNSG2dCharacterData ** ppCharData);
void NNS_G2dUnpackBGNCG(NNSG2dCharacterData * pCharData);
BOOL NNS_G2dGetUnpackedCharacterPosInfo(void * pNcgrFile, NNSG2dCharacterPosInfo ** ppCharPosInfo);

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_NCG_LOAD_H