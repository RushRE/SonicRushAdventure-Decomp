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
NOT_DECOMPILED void HubState__Clear(void);
NOT_DECOMPILED void HubState__Func_2152DD4(u8 a1);
NOT_DECOMPILED u8 HubState__Func_2152DE4(void);
NOT_DECOMPILED void HubState__Func_2152DF4(u8 a1);
NOT_DECOMPILED u8 HubState__Func_2152E04(void);
NOT_DECOMPILED void HubState__Func_2152E14(s32 id, VecFx32 *pos, u16 angle);
NOT_DECOMPILED BOOL HubState__Func_2152E74(s32 id);
NOT_DECOMPILED VecFx32 *HubState__GetPlayerInfo(s32 id);
NOT_DECOMPILED u16 HubState__Func_2152EA4(s32 id);
NOT_DECOMPILED void HubState__Func_2152EB8(s32 id, VecFx32 *pos, u16 angle);
NOT_DECOMPILED BOOL HubState__Func_2152F20(s32 id);
NOT_DECOMPILED VecFx32 *HubState__GetNpcInfo(s32 id);
NOT_DECOMPILED s32 HubState__Func_2152F58(s32 id);
NOT_DECOMPILED s32 HubState__Func_2152F70(s32 id);
NOT_DECOMPILED u8 HubState__Func_2152F88(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_HUBSTATE_H