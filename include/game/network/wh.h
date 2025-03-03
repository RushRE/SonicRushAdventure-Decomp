#ifndef RUSH_WH_H
#define RUSH_WH_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void WH_GetWMErrCodeName(void);
NOT_DECOMPILED void WH_GetWMStateCodeName(void);
NOT_DECOMPILED void WH_ChangeSysState(void);
NOT_DECOMPILED void WH_SetError(void);
NOT_DECOMPILED void WH_Alloc(void);
NOT_DECOMPILED void WH_Free(void);
NOT_DECOMPILED void WH_StateInSetParentParam(void);
NOT_DECOMPILED void WH_StateOutSetParentParam(void);
NOT_DECOMPILED void WH_StateInSetParentWEPKey(void);
NOT_DECOMPILED void WH_StateOutSetParentWEPKey(void);
NOT_DECOMPILED void WH_StateInStartParent(void);
NOT_DECOMPILED void WH_StateOutStartParent(void);
NOT_DECOMPILED void WH_StateInStartParentMP(void);
NOT_DECOMPILED void WH_StateOutStartParentMP(void);
NOT_DECOMPILED void WH_StateInStartParentKeyShare(void);
NOT_DECOMPILED void WH_StateInEndParentKeyShare(void);
NOT_DECOMPILED void WH_StateInEndParentMP(void);
NOT_DECOMPILED void WH_StateOutEndParentMP(void);
NOT_DECOMPILED void WH_StateInEndParent(void);
NOT_DECOMPILED void WH_StateOutEndParent(void);
NOT_DECOMPILED void WH_ChildConnectAuto(void);
NOT_DECOMPILED void WH_StartScan(void);
NOT_DECOMPILED void WH_StateInStartScan(void);
NOT_DECOMPILED void WH_StateOutStartScan(void);
NOT_DECOMPILED void WH_EndScan(void);
NOT_DECOMPILED void WH_StateInEndScan(void);
NOT_DECOMPILED void WH_StateOutEndScan(void);
NOT_DECOMPILED void WH_StateInSetChildWEPKey(void);
NOT_DECOMPILED void WH_StateOutSetChildWEPKey(void);
NOT_DECOMPILED void WH_StateInStartChild(void);
NOT_DECOMPILED void WH_StateOutStartChild(void);
NOT_DECOMPILED void WH_StateInStartChildMP(void);
NOT_DECOMPILED void WH_StateOutStartChildMP(void);
NOT_DECOMPILED void WH_StateInStartChildKeyShare(void);
NOT_DECOMPILED void WH_StateInEndChildKeyShare(void);
NOT_DECOMPILED void WH_StateInEndChildMP(void);
NOT_DECOMPILED void WH_StateOutEndChildMP(void);
NOT_DECOMPILED void WH_StateInEndChild(void);
NOT_DECOMPILED void WH_StateOutEndChild(void);
NOT_DECOMPILED void WH_StateInReset(void);
NOT_DECOMPILED void WH_StateOutReset(void);
NOT_DECOMPILED void WH_StateInSetMPData(void);
NOT_DECOMPILED void WH_StateOutSetMPData(void);
NOT_DECOMPILED void WH_PortReceiveCallback(void);
NOT_DECOMPILED void WH_StateOutEnd(void);
NOT_DECOMPILED void WH_SetGgid(void);
NOT_DECOMPILED void WH_SetSsid(void);
NOT_DECOMPILED void WH_SetUserGameInfo(void);
NOT_DECOMPILED void WH_SetMaxChildCount(void);
NOT_DECOMPILED void WH_SetMinDataSize(void);
NOT_DECOMPILED void WH_SetMaxParentChildSize(void);
NOT_DECOMPILED u32 WH_GetConnectBitmap(void);
NOT_DECOMPILED void WH_GetSystemState(void);
NOT_DECOMPILED void WH_GetErrorCode(void);
NOT_DECOMPILED void WH_StartMeasureChannel(void);
NOT_DECOMPILED void WH_StateInMeasureChannel(void);
NOT_DECOMPILED void WH_StateOutMeasureChannel(void);
NOT_DECOMPILED void WHi_MeasureChannel(void);
NOT_DECOMPILED void WH_GetMeasureChannel(void);
NOT_DECOMPILED void WHi_SelectChannel(void);
NOT_DECOMPILED void WH_Initialize(void);
NOT_DECOMPILED void WH_IndicateHandler(void);
NOT_DECOMPILED void sub_206b700(void);
NOT_DECOMPILED void WH_StateInInitialize(void);
NOT_DECOMPILED void WH_StateOutInitialize(void);
NOT_DECOMPILED void WH_ParentConnect(void);
NOT_DECOMPILED void WH_ChildConnect(void);
NOT_DECOMPILED void WH_SetJudgeAcceptFunc(void);
NOT_DECOMPILED void WH_SetReceiver(void);
NOT_DECOMPILED void WH_SendData(void);
NOT_DECOMPILED void WH_GetSharedDataAdr(void);
NOT_DECOMPILED void WH_StepDS(void);
NOT_DECOMPILED void WH_Reset(void);
NOT_DECOMPILED void WH_Finalize(void);
NOT_DECOMPILED void WH_End(void);
NOT_DECOMPILED u8 WH_GetCurrentAid(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_WH_H