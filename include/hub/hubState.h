#ifndef RUSH_HUBSTATE_H
#define RUSH_HUBSTATE_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

// HubState
void ResetHubState(void);
void HubState__SetHubType(u8 value);
u8 HubState__GetHubType(void);
void HubState__SetHubArea(u8 value);
u8 HubState__GetHubArea(void);
void HubState__SetPlayerState(s32 id, VecFx32 *pos, u16 angle);
BOOL HubState__CheckHasPlayerState(s32 id);
VecFx32 *HubState__GetPlayerPosition(s32 id);
u16 HubState__GetPlayerAngle(s32 id);
void HubState__SetNpcState(s32 id, VecFx32 *pos, u16 angle);
BOOL HubState__CheckHasNpcState(s32 id);
VecFx32 *HubState__GetNpcPosition(s32 id);
s32 HubState__GetNpcAngle(s32 id);
s32 HubState__GetNpcUnknown(s32 id);
u8 HubState__GetFieldDC(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_HUBSTATE_H