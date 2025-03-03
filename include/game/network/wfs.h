#ifndef RUSH_WFS_H
#define RUSH_WFS_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void WFSi_ReadRomCallback(void);
NOT_DECOMPILED void WFSi_WriteRomCallback(void);
NOT_DECOMPILED void WFSi_RomArchiveProc(void);
NOT_DECOMPILED void WFSi_LoadTables(void);
NOT_DECOMPILED void WFSi_ReplaceRomArchive(void);
NOT_DECOMPILED void WFSi_OnSendMessageDone(void);
NOT_DECOMPILED void WFSi_SendMessage(void);
NOT_DECOMPILED void WFSi_SendAck(void);
NOT_DECOMPILED void WFSi_SendOpenAck(void);
NOT_DECOMPILED void WFSi_FindAlive(void);
NOT_DECOMPILED void WFSi_FindBusy(void);
NOT_DECOMPILED void WFSi_FindAliveForID(void);
NOT_DECOMPILED void WFSi_MoveList(void);
NOT_DECOMPILED void WFSi_FromFreeToBusy(void);
NOT_DECOMPILED void WFSi_FromBusyToAlive(void);
NOT_DECOMPILED void WFSi_FromAliveToBusy(void);
NOT_DECOMPILED void WFSi_FromBusyToFree(void);
NOT_DECOMPILED void WFSi_ReadRequest(void);
NOT_DECOMPILED void sub_206ca5c(void);
NOT_DECOMPILED void WFSi_SetMPData(void);
NOT_DECOMPILED void WFSi_OnSetMPDataDone(void);
NOT_DECOMPILED void WFSi_PortCallback(void);
NOT_DECOMPILED void WFSi_OnParentSystemCallback(void);
NOT_DECOMPILED void WFSi_ReallocBitmap(void);
NOT_DECOMPILED void WFSi_OnChildSystemCallback(void);
NOT_DECOMPILED void WFSi_InitCommon(void);
NOT_DECOMPILED void WFS_InitParent(void);
NOT_DECOMPILED void WFS_InitChild(void);
NOT_DECOMPILED void WFS_Start(void);
NOT_DECOMPILED void WFS_End(void);
NOT_DECOMPILED s32 WFS_GetStatus(void);
NOT_DECOMPILED void WFS_GetBusyBitmap(void);
NOT_DECOMPILED u32 WFS_Func_206D9B4(void);
NOT_DECOMPILED void WFS_EnableSync(void);
NOT_DECOMPILED void WFS_SetDebugMode(void);
NOT_DECOMPILED void WFSi_NotifyBusy(void);
NOT_DECOMPILED void WFSi_TaskThread(void);
NOT_DECOMPILED void sub_206DB9C(void);
NOT_DECOMPILED void WFSi_CreateTaskThread(void);
NOT_DECOMPILED void WFSi_EndTaskThread(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_WFS_H