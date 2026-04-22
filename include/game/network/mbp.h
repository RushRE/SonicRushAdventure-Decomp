#ifndef RUSH_MBP_H
#define RUSH_MBP_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

enum MBPState_
{
    MBP_STATE_STOP        = 0x0,
    MBP_STATE_IDLE        = 0x1,
    MBP_STATE_ENTRY       = 0x2,
    MBP_STATE_DATASENDING = 0x3,
    MBP_STATE_REBOOTING   = 0x4,
    MBP_STATE_COMPLETE    = 0x5,
    MBP_STATE_CANCEL      = 0x6,
    MBP_STATE_ERROR       = 0x7,
    MBP_STATE_NUM         = 0x8,
};
typedef u32 MBPState;

enum MBPBmpType_
{
    MBP_BMPTYPE_CONNECT,
    MBP_BMPTYPE_REQUEST,
    MBP_BMPTYPE_ENTRY,
    MBP_BMPTYPE_DOWNLOADING,
    MBP_BMPTYPE_BOOTABLE,
    MBP_BMPTYPE_REBOOT,
};
typedef u32 MBPBmpType;

enum MBPChildState_
{
    MBP_CHILDSTATE_NONE,
    MBP_CHILDSTATE_CONNECTING,
    MBP_CHILDSTATE_REQUEST,
    MBP_CHILDSTATE_ENTRY,
    MBP_CHILDSTATE_DOWNLOADING,
    MBP_CHILDSTATE_BOOTABLE,
    MBP_CHILDSTATE_REBOOT,
};
typedef u32 MBPChildState;

// --------------------
// STRUCTS
// --------------------

typedef struct MBPChildInfo_
{
    MBUserInfo user;
    u8 macAddress[6];
    u16 playerNo;
} MBPChildInfo;

// --------------------
// FUNCTIONS
// --------------------

NOT_DECOMPILED void MBP_Init(u32 ggid, u16 tgid);
NOT_DECOMPILED void MBP_Start(const MBGameRegistry *gameInfo, u16 channel);
NOT_DECOMPILED void sub_206dd88(void);
NOT_DECOMPILED void MBP_RegistFile(void);
NOT_DECOMPILED void MBP_AcceptChild(u16 child_aid);
NOT_DECOMPILED void MBP_KickChild(u16 child_aid);
NOT_DECOMPILED void MBP_StartDownload(u16 child_aid);
NOT_DECOMPILED void MBP_StartDownloadAll(void);
NOT_DECOMPILED BOOL MBP_IsBootableAll(void);
NOT_DECOMPILED void MBP_StartRebootAll(void);
NOT_DECOMPILED void MBP_Cancel(void);
NOT_DECOMPILED void MBPi_CheckAllReboot(void);
NOT_DECOMPILED void MBPi_ParentStateCallback(void);
NOT_DECOMPILED void MBP_ChangeState(void);
NOT_DECOMPILED u16 MBP_GetState(void);
NOT_DECOMPILED u16 MBP_GetChildBmp(MBPBmpType bmpType);
NOT_DECOMPILED MBPChildState MBP_GetChildState(u16 aid);
NOT_DECOMPILED const MBPChildInfo *MBP_GetChildInfo(u16 child_aid);

#ifdef __cplusplus
}
#endif

#endif // RUSH_MBP_H