#ifndef NITRO_CARD_PULLOUT_H
#define NITRO_CARD_PULLOUT_H

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// TYPES
// --------------------

typedef BOOL (*CARDPulledOutCallback)(void);

// --------------------
// FUNCTIONS
// --------------------

void CARD_InitPulledOutCallback(void);

#ifdef SDK_ARM9
void CARD_SetPulledOutCallback(CARDPulledOutCallback callback);
void CARD_TerminateForPulledOut(void);
void CARD_CheckPulledOut(void);
#endif

BOOL CARD_IsPulledOut(void);

#ifdef SDK_ARM7
void CARD_CheckPullOut_Polling(void);
#endif

#ifdef __cplusplus
}
#endif

#endif // NITRO_CARD_PULLOUT_H
