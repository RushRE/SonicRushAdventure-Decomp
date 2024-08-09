#ifndef NNS_GFD_FRAMETEXVRAMMAN_H
#define NNS_GFD_FRAMETEXVRAMMAN_H

#include <nitro.h>
#include <nnsys/gfd/VramManager/gfd_TexVramMan_Types.h>

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// STRUCTS
// --------------------

typedef struct NNSGfdFrmTexVramState
{
    u32 address[10];
} NNSGfdFrmTexVramState;

// --------------------
// TYPES
// --------------------

typedef void (*NNSGfdFrmTexVramDebugDumpCallBack)(int index, u32 startAddr, u32 endAddr, u32 blockMax, BOOL bActive, void *pUserContext);

// --------------------
// FUNCTIONS
// --------------------

void NNSi_GfdSetTexNrmSearchArray(int idx1st, int idx2nd, int idx3rd, int idx4th, int idx5th);
void NNS_GfdInitFrmTexVramManager(u16 numSlot, BOOL useAsDefault);
NNSGfdTexKey NNS_GfdAllocFrmTexVram(u32 szByte, BOOL is4x4comp, u32 opt);
int NNS_GfdFreeFrmTexVram(NNSGfdTexKey memKey);
void NNS_GfdGetFrmTexVramState(NNSGfdFrmTexVramState *pState);
void NNS_GfdSetFrmTexVramState(const NNSGfdFrmTexVramState *pState);
void NNS_GfdResetFrmTexVramState(void);

#ifdef __cplusplus
}
#endif

#endif // NNS_GFD_FRAMETEXVRAMMAN_H
