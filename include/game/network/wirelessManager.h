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

// --------------------
// STRUCTS
// --------------------

typedef struct WirelessManager_Unknown2068160_
{
    u16 channel;
    u16 bitmap;
    u16 tgid;
    u16 __padding;
} WirelessManager_Unknown2068160;

typedef struct WirelessManager_Unknown2067A88_
{
    u16 channel;
    u16 bitmap;
    u8 bssID[WM_SIZE_BSSID];
} WirelessManager_Unknown2067A88;

typedef struct WirelessManager__Unknown_
{
    WMBssDesc bssDesc;
    u32 field_C0;
    u16 field_C4;
    u16 field_C6;
} WirelessManager__Unknown;

typedef union WirelessManager_SSID_
{
    struct
    {
        char16 text[9];
        u16 length;
    } name;

    u8 data[WM_SIZE_CHILD_SSID];
} WirelessManager_SSID;

typedef struct WirelessManager_Unknown2068724_
{
    u8 macAddress[6];
    WirelessManager_SSID ssid;

} WirelessManager_Unknown2068724;

// --------------------
// FUNCTIONS
// --------------------

void WirelessManager__InitAllocator(NetworkAllocMode whAllocMode, NetworkAllocMode mbpAllocMode);
void WirelessManager__Create(u8 a1, u16 a2, u16 a3, void *param, u16 paramSize);
void WirelessManager__Create1(WirelessManager_Unknown2068160 *a1, s32 a2, u16 a3, void *param, u16 paramSize);
void WirelessManager__Create2(u8 a1, u16 a2, u16 a3, void *param, u16 paramSize);
void WirelessManager__Create3(WirelessManager_Unknown2067A88 *a1, u16 a3, void *param, u16 paramSize);
void WirelessManager__Func_206789C(s32 a1);
s32 WirelessManager__GetEntryCount2(void);
WirelessManager__Unknown *WirelessManager__GetEntry2(u16 id);
void WirelessManager__RemoveEntry2(u16 id);
void WirelessManager__Func_20679CC(u16 id);
WirelessManager_Unknown2068724 *WirelessManager__Func_2067A18(s32 id);
void WirelessManager__Func_2067A48(WirelessManager_Unknown2068160 *a1);
void WirelessManager__Func_2067A88(WirelessManager_Unknown2067A88 *a1);
void WirelessManager__Func_2067AE8(BOOL enabled);
void *WirelessManager__GetSendBuffer(void);
void *WirelessManager__GetReceiveBuffer(u32 id);
void WirelessManager__ClearSendBuffer(void);
void WirelessManager__ClearUnknownBuffer(void);
void WirelessManager__Create4(WirelessManager_Unknown2068160 *a1, s32 a2, u16 a3, u16 a4, void *param, u16 paramSize);
void WirelessManager__Create5(WirelessManager_Unknown2067A88 *a1, u16 a2, u16 a3, void *param, u16 paramSize);
void WirelessManager__Func_2067DF4(s32 a1);
void WirelessManager__Func_2067F00(WirelessManager_Unknown2068160 *a1);
void WirelessManager__Func_2067F40(WirelessManager_Unknown2067A88 *a1);
void WirelessManager__Create6(MBGameRegistry *gameRegistry, s32 a2);
void WirelessManager__Func_2068060(void);
void WirelessManager__Func_2068160(WirelessManager_Unknown2068160 *a1);
MBPChildInfo *WirelessManager__GetChildInfo(s32 id);
void WirelessManager__Func_20681D0(void);
u32 WirelessManager__GetChildBitmap(void);
u32 WirelessManager__GetChildCount(void);
u32 WirelessManager__GetField4(void);
s32 WirelessManager__GetStatus(void);
u16 WirelessManager__GetBitmapUserCount(u16 bitmap);
WMLinkLevel WirelessManager__GetLinkLevel(void);

#ifdef __cplusplus
}
#endif

#endif // RUSH_WIRELESSMANAGER_H
