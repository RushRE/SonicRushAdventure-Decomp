#ifndef RUSH_WIRELESSMANAGER_H
#define RUSH_WIRELESSMANAGER_H

#include <global.h>
#include <game/network/wh.h>
#include <game/network/wfs.h>
#include <game/network/mbp.h>
#include <network/networkHandler.h>
#include <game/save/saveGame.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define WIRELESSMANAGER_GGID_RUSH2 0x400342

// --------------------
// ENUMS
// --------------------

enum WirelessManagerStatus_
{
    WIRELESSMANAGER_STATUS_INACTIVE,
    WIRELESSMANAGER_STATUS_IDLE,
    WIRELESSMANAGER_STATUS_2,
    WIRELESSMANAGER_STATUS_3,
    WIRELESSMANAGER_STATUS_4,
    WIRELESSMANAGER_STATUS_5,
    WIRELESSMANAGER_STATUS_MBP_COMPLETE,
    WIRELESSMANAGER_STATUS_ERROR,
};
typedef s32 WirelessManagerStatus;

enum WirelessManagerMode_
{
    WIRELESSMANAGER_MODE_INVALID,
    WIRELESSMANAGER_MODE_WIRELESS_GUEST,
    WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_GUEST,
    WIRELESSMANAGER_MODE_DOWNLOAD_PLAY_HOST,
};
typedef s32 WirelessManagerMode;

enum WirelessManagerDownloadPlayFlags_
{
    WIRELESSMANAGER_DOWNLOADPLAY_FLAGS_NONE = 0x00,

    WIRELESSMANAGER_DOWNLOADPLAY_FLAGS_NO_JOIN_AFTER_CONNECTED = 1 << 0,
};
typedef s32 WirelessManagerDownloadPlayFlags;

// --------------------
// STRUCTS
// --------------------

typedef struct WirelessManagerRoom_Wireless_
{
    u16 channel;
    u16 bitmap;
    u16 tgid;
    u16 __padding;
} WirelessManagerRoom_Wireless;

typedef struct WirelessManagerRoom_DownloadPlay_
{
    u16 channel;
    u16 bitmap;
    u8 bssID[WM_SIZE_BSSID];
} WirelessManagerRoom_DownloadPlay;

typedef struct WirelessManagerRoomInfo_
{
    WMBssDesc bssDesc;
    u32 timer;
    u16 linkLevel;
} WirelessManagerRoomInfo;

typedef union WirelessManager_SSID_
{
    struct
    {
        char16 text[9];
        u16 length;
    } name;

    u8 data[WM_SIZE_CHILD_SSID];
} WirelessManager_SSID;

typedef struct WirelessManagerConnectableGuestInfo_
{
    u8 macAddress[6];
    WirelessManager_SSID ssid;

} WirelessManagerConnectableGuestInfo;

// --------------------
// FUNCTIONS
// --------------------

void WirelessManager__InitAllocator(NetworkAllocMode whAllocMode, NetworkAllocMode mbpAllocMode);
void WirelessManager__Create_CreateRoom_Wireless(u8 tgidSalt, u16 maxChildCount, u16 packetSize, void *param, u16 paramSize);
void WirelessManager__Create1(WirelessManagerRoom_Wireless *room, s32 a2, u16 packetSize, void *param, u16 paramSize);
void WirelessManager__Create_SearchRooms_Wireless(u8 tgidSalt, u16 maxChildCount, u16 packetSize, void *param, u16 paramSize);
void WirelessManager__Create3(WirelessManagerRoom_DownloadPlay *room, u16 packetSize, void *param, u16 paramSize);
void WirelessManager__Func_206789C(s32 a1);
s32 WirelessManager__GetAvailableRoomCount(void);
WirelessManagerRoomInfo *WirelessManager__GetAvailableRoom(u16 id);
void WirelessManager__RemoveAvailableRoom(u16 id);
void WirelessManager__SetCurrentRoom(u16 id);
WirelessManagerConnectableGuestInfo *WirelessManager__GetConnectedGuest_Wireless(s32 id);
void WirelessManager__GetCurrentRoomConnection_Wireless(WirelessManagerRoom_Wireless *room);
void WirelessManager__GetCurrentRoomConnection_DownloadPlay(WirelessManagerRoom_DownloadPlay *room);
void WirelessManager__Func_2067AE8(BOOL enabled);
void *WirelessManager__GetSendBuffer(void);
void *WirelessManager__GetReceiveBuffer(u32 id);
void WirelessManager__ClearSendBuffer(void);
void WirelessManager__ClearUnknownBuffer(void);
void WirelessManager__Create4(WirelessManagerRoom_Wireless *room, s32 a2, u16 parentPacketSize, u16 childPacketSize, void *param, u16 paramSize);
void WirelessManager__Create5(WirelessManagerRoom_DownloadPlay *room, u16 parentPacketSize, u16 childPacketSize, void *param, u16 paramSize);
void WirelessManager__Func_2067DF4(s32 a1);
void WirelessManager__GetCurrentRoomConnection_Wireless2(WirelessManagerRoom_Wireless *room);
void WirelessManager__GetCurrentRoomConnection_DownloadPlay2(WirelessManagerRoom_DownloadPlay *room);
void WirelessManager__Create_CreateRoom_DownloadPlay(MBGameRegistry *gameRegistry, WirelessManagerDownloadPlayFlags flags);
void WirelessManager__Func_2068060(void);
void WirelessManager__GetCurrentRoomConnection_Wireless3(WirelessManagerRoom_Wireless *room);
MBPChildInfo *WirelessManager__GetConnectedGuest_DownloadPlay(s32 id);
void WirelessManager__Func_20681D0(void);
u32 WirelessManager__GetChildBitmap(void);
u32 WirelessManager__GetChildCount(void);
WirelessManagerMode WirelessManager__GetMode(void);
WirelessManagerStatus WirelessManager__GetStatus(void);
u16 WirelessManager__GetBitmapUserCount(u16 bitmap);
WMLinkLevel WirelessManager__GetLinkLevel(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_WIRELESSMANAGER_H
