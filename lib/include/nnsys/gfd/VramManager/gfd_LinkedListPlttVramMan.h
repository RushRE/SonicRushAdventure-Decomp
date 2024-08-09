#ifndef NNS_GFD_LINKEDLISTPLTTVRAMMAN_H
#define NNS_GFD_LINKEDLISTPLTTVRAMMAN_H

#include <nitro.h>
#include <nnsys/gfd/VramManager/gfd_VramMan.h>
#include <nnsys/gfd/VramManager/gfd_PlttVramMan_Types.h>
#include <nnsys/gfd/VramManager/gfd_LinkedListVramMan.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// FUNCTIONS
// --------------------

u32 NNS_GfdGetLnkPlttVramManagerWorkSize(u32 numMemBlk);
void NNS_GfdInitLnkPlttVramManager(u32 szByte, void *pManagementWork, u32 szByteManagementWork, BOOL useAsDefault);
NNSGfdPlttKey NNS_GfdAllocLnkPlttVram(u32 szByte, BOOL b4Pltt, u32 opt);
int NNS_GfdFreeLnkPlttVram(NNSGfdPlttKey plttKey);
void NNS_GfdResetLnkPlttVramState(void);

#ifdef __cplusplus
}
#endif

#endif // NNS_GFD_LINKEDLISTPLTTVRAMMAN_H