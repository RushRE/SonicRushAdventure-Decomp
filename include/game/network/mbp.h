#ifndef RUSH_MBP_H
#define RUSH_MBP_H

#include <global.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// ENUMS
// --------------------

enum MBPState_
{
    MBP_STATE_STOP,
    MBP_STATE_IDLE,
    MBP_STATE_ENTRY,
    MBP_STATE_DATASENDING,
    MBP_STATE_REBOOTING,
    MBP_STATE_COMPLETE,
    MBP_STATE_CANCEL,
    MBP_STATE_ERROR,

    MBP_STATE_COUNT,
};
typedef u16 MBPState;

enum MBPBmpType_
{
    MBP_BMPTYPE_CONNECT,
    MBP_BMPTYPE_REQUEST,
    MBP_BMPTYPE_ENTRY,
    MBP_BMPTYPE_DOWNLOADING,
    MBP_BMPTYPE_BOOTABLE,
    MBP_BMPTYPE_REBOOT,

    MBP_BMPTYPE_COUNT,
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

void MBP_Init(u32 ggid, u16 tgid);
void MBP_Start(const MBGameRegistry *gameInfo, u16 channel);
void MBP_AcceptChild(u16 childAID);
void MBP_KickChild(u16 childAID);
void MBP_StartDownload(u16 childAID);
void MBP_StartDownloadAll(void);
BOOL MBP_IsBootableAll(void);
void MBP_StartRebootAll(void);
void MBP_Cancel(void);
void MBP_ChangeState(MBPState state);
MBPState MBP_GetState(void);
u16 MBP_GetChildBmp(MBPBmpType bmpType);
const MBPChildInfo *MBP_GetChildInfo(u16 childAID);

#ifdef __cplusplus
}
#endif

#endif // RUSH_MBP_H