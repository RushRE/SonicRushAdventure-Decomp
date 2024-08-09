#ifndef NNS_GFD_BITARRAYPLTTMAN_H
#define NNS_GFD_BITARRAYPLTTMAN_H

#include <nitro.h>
#include <nnsys/gfd/VramManager/gfd_PlttVramMan_Types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

void NNS_GfdInitBarPlttVramManager(u32 szByte, u32 bytePerOneBlock, u32 *pBitTbl, u32 lengthOfBitTbl, BOOL useAsDefault);
NNSGfdPlttKey NNS_GfdAllocBarPlttVram(u32 szByte, BOOL b4Pltt, u32 bAllocFromLo);
int NNS_GfdFreeBarPlttVram(NNSGfdPlttKey plttKey);
void NNS_GfdResetBarPlttVramState(void);

#ifdef __cplusplus
}
#endif

#endif // NNS_GFD_BITARRAYPLTTMAN_H