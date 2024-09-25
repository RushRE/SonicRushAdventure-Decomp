#ifndef NNS_G2D_NAN_LOAD_H
#define NNS_G2D_NAN_LOAD_H

#ifdef __cplusplus
extern "C"
{
#endif

#include <nitro.h>

#include <nnsys/g2d/g2d_config.h>
#include <nnsys/g2d/g2d_Data.h>

// --------------------
// FUNCTIONS
// --------------------

BOOL NNS_G2dGetUnpackedAnimBank(void *pNanrFile, NNSG2dAnimBankData **ppAnimBank);
BOOL NNS_G2dGetUnpackedMCAnimBank(void *pNanrFile, NNSG2dAnimBankData **ppAnimBank);

void NNS_G2dUnpackNAN(NNSG2dAnimBankData *pData);

// --------------------
// INLINE FUNCTIONS
// --------------------

NNS_G2D_INLINE u16 NNS_G2dGetNumAnimSequence(const NNSG2dAnimBankData *pAnimBank)
{
    return pAnimBank->numSequences;
}

const NNSG2dAnimSequenceData *NNS_G2dGetAnimSequenceByIdx(const NNSG2dAnimBankData *pAnimBank, u16 idx);

const char *NNS_G2dGetAnimSequenceTypeStr(NNSG2dAnimationType);

#ifdef __cplusplus
}
#endif

#endif // NNS_G2D_NAN_LOAD_H