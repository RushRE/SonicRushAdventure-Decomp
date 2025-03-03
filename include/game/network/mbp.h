#ifndef RUSH_MBP_H
#define RUSH_MBP_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void MBP_Init(void);
NOT_DECOMPILED void MBP_Start(void);
NOT_DECOMPILED void sub_206dd88(void);
NOT_DECOMPILED void MBP_RegistFile(void);
NOT_DECOMPILED void MBP_AcceptChild(void);
NOT_DECOMPILED void MBP_KickChild(void);
NOT_DECOMPILED void MBP_StartDownload(void);
NOT_DECOMPILED void MBP_StartDownloadAll(void);
NOT_DECOMPILED void MBP_IsBootableAll(void);
NOT_DECOMPILED void MBP_StartRebootAll(void);
NOT_DECOMPILED void MBP_Cancel(void);
NOT_DECOMPILED void MBPi_CheckAllReboot(void);
NOT_DECOMPILED void MBPi_ParentStateCallback(void);
NOT_DECOMPILED void MBP_ChangeState(void);
NOT_DECOMPILED void MBP_GetState(void);
NOT_DECOMPILED void MBP_GetChildBmp(void);
NOT_DECOMPILED void MBP_GetChildState(void);
NOT_DECOMPILED void MBP_GetChildInfo(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_MBP_H