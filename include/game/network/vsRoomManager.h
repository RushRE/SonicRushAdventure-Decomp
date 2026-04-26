#ifndef RUSH_VSROOMMANAGER_H
#define RUSH_VSROOMMANAGER_H

#include <global.h>
#include <game/system/task.h>
#include <game/save/saveGame.h>
#include <game/network/wirelessManager.h>

#ifdef __cplusplus
extern "C"
{
#endif

// --------------------
// CONSTANTS
// --------------------

#define VSROOMMANAGER_ROOM_PLAYER_COUNT 2

#define VSROOMMANAGER_UNKNOWNLIST_COUNT 8

// --------------------
// ENUMS
// --------------------

enum VSRoomManagerMatchType_
{
    VSROOMMANAGER_MATCH_RACE,
    VSROOMMANAGER_MATCH_RING_BATTLE,
    VSROOMMANAGER_MATCH_UNUSED,
    VSROOMMANAGER_MATCH_NONE,
};
typedef u32 VSRoomManagerMatchType;

enum VSRoomManagerNetworkType_
{
    VSROOMMANAGER_NETWORK_0,
    VSROOMMANAGER_NETWORK_1,
    VSROOMMANAGER_NETWORK_2,
    VSROOMMANAGER_NETWORK_3,
    VSROOMMANAGER_NETWORK_4,
};
typedef s32 VSRoomManagerNetworkType;

enum VSRoomManagerMatchStatus_
{
    VSROOMMANAGER_STATUS_0,
    VSROOMMANAGER_STATUS_1,
    VSROOMMANAGER_STATUS_2,
    VSROOMMANAGER_STATUS_3,
    VSROOMMANAGER_STATUS_4,
    VSROOMMANAGER_STATUS_5,
    VSROOMMANAGER_STATUS_6,
    VSROOMMANAGER_STATUS_7,
    VSROOMMANAGER_STATUS_8,
    VSROOMMANAGER_STATUS_9,
    VSROOMMANAGER_STATUS_10,
    VSROOMMANAGER_STATUS_11,
    VSROOMMANAGER_STATUS_12,
    VSROOMMANAGER_STATUS_13,
    VSROOMMANAGER_STATUS_14,
    VSROOMMANAGER_STATUS_15,
    VSROOMMANAGER_STATUS_16,
    VSROOMMANAGER_STATUS_17,
    VSROOMMANAGER_STATUS_18,
    VSROOMMANAGER_STATUS_19,
    VSROOMMANAGER_STATUS_20,
    VSROOMMANAGER_STATUS_21,
    VSROOMMANAGER_STATUS_22,
    VSROOMMANAGER_STATUS_23,
    VSROOMMANAGER_STATUS_24,
    VSROOMMANAGER_STATUS_25,
};
typedef u32 VSRoomManagerMatchStatus;

// --------------------
// STRUCTS
// --------------------

typedef struct DowloadPlayMatchInfo_
{
    const char *key_mode;
    const char *key_score;
    const char *rom;
    const char *iconPalettePath[2];
    const char *iconCharPath[2];
    const char *key_modes[2];
} DowloadPlayMatchInfo;

typedef struct VSRoomManager__SendHeader_
{
    u8 signature;
    u8 heartbeat3;
    u8 heartbeat4;
    u8 heartbeat2;
} VSRoomManager__SendHeader;

typedef struct VSRoomManager__SendBuffer_
{
    VSRoomManager__SendHeader header;
    u8 data[1]; // C-style variable array
} VSRoomManager__SendBuffer;

typedef struct VSRoomManager__PlayerName_
{
    char16 text[SAVEGAME_MAX_NAME_LEN + 1];
    u16 length;
} VSRoomManager__PlayerName;

typedef struct VSRoomManager__PlayerInfo_
{
    VSRoomManager__PlayerName name;
    u8 bssID[6];
    VSRoomManagerMatchType battleMode;
    u32 score;
    DWCAccFriendData friendData;
} VSRoomManager__PlayerInfo;

typedef struct VSRoomManager__Unknown1_
{
    VSRoomManager__SendHeader header;
    VSRoomManager__PlayerInfo field_4;
    s32 field_34;
    s32 field_38;
    s32 field_3C;
} VSRoomManager__Unknown1;

typedef struct VSRoomManager__Unknown_
{
    u32 flags;
    struct
    {
        u16 name[SAVEGAME_MAX_NAME_LEN];
        u16 _padding;
        u16 nameLength;
        VSRoomManagerMatchType battleMode;
    } opponent;

    u8 bssID[6];
    u16 field_22;
    s32 field_24;
} VSRoomManager__Unknown;

typedef struct VSRoomManager__AID_
{
    u16 myAID;
    u16 aidBitmap;
} VSRoomManager__AID;

typedef struct VSRoomManager_
{
    VSRoomManagerNetworkType usingNetwork;
    s32 field_4;
    VSRoomManagerMatchStatus status;
    s32 field_C;
    BOOL isHost;
    VSRoomManager__AID aid;
    struct
    {
        u8 mine;
        u8 other;
    } heartbeat1;
    struct
    {
        u8 mine;
        u8 other;
    } heartbeat2;
    struct
    {
        u8 mine;
        u8 other;
    } heartbeat3;
    struct
    {
        u8 mine;
        u8 other;
    } heartbeat4;
    u32 receiveTimeout;
    u32 field_24;
    BOOL needsRegistryInit;
    s32 field_2C;
    u32 field_30;
    s32 sendBufferSize;
    VSRoomManagerMatchType battleMode;
    char16 opponentName[SAVEGAME_MAX_NAME_LEN];
    u16 opponentNameLength;
    u8 opponentBssID[6];
    s32 opponentScore;
    DWCAccFriendData opponentFriendData;
    VSRoomManager__Unknown unknownList[VSROOMMANAGER_UNKNOWNLIST_COUNT];
    MBGameRegistry gameRegistry;
    char16 gameName[MB_GAME_NAME_LENGTH];
    char16 gameIntroduction[MB_GAME_INTRO_LENGTH];
    s32 score;
    u32 roomSearchTimer;
    u32 transferStatus;
    BOOL hasConnection;
    VSRoomManager__Unknown1 unknown1;
} VSRoomManager;

// --------------------
// FUNCTIONS
// --------------------

void CreateVSRoomManager(void);
void DestroyVSRoomManager(void);
s32 VSRoomManager__GetStatus(void);
VSRoomManagerNetworkType VSRoomManager__GetUsingNetwork(void);
s32 VSRoomManager__IsHost(void);
BOOL VSRoomManager__CheckUsingNetwork_2(void);
BOOL VSRoomManager__IsUsingGlobalRoom(void);
char16 *VSRoomManager__GetOpponentName(void);
u16 VSRoomManager__GetOpponentNameLength(void);
s32 VSRoomManager__GetOpponentScore(void);
VSRoomManagerMatchType VSRoomManager__GetBattleMode(void);
void VSRoomManager__SetBattleMode(VSRoomManagerMatchType mode);
void VSRoomManager__Func_2060E78(void);
void VSRoomManager__Func_2060ECC(void);
void VSRoomManager__Func_2060F04(void);
void VSRoomManager__LoadUnknownListEntries(void);
u16 VSRoomManager__FindAvailableUnknownListSlot(void);
char16 *VSRoomManager__GetUnknownOpponentName(s32 id);
u16 VSRoomManager__GetUnknownOpponentNameLength(s32 id);
VSRoomManagerMatchType VSRoomManager__GetUnknownOpponentBattleMode(s32 id);
u16 VSRoomManager__GetUnknownOpponentUnknown(s32 id);
BOOL VSRoomManager__Func_2061194(void);
BOOL VSRoomManager__Func_20611B0(s32 id);
void VSRoomManager__Func_2061298(void);
void VSRoomManager__Func_20612D4(VSRoomManagerMatchType mode);
void VSRoomManager__Func_2061360(void);
void VSRoomManager__Func_20613BC(void);
void VSRoomManager__Func_20613E4(void);
void VSRoomManager__Func_206147C(void);
void VSRoomManager__Func_206150C(void);
BOOL VSRoomManager__InitNetwork(void);
void VSRoomManager__Func_2061654(void);
void VSRoomManager__Func_20616C4(BOOL useGlobalLobby, VSRoomManagerMatchType battleMode);
void VSRoomManager__Func_2061808(void);
void VSRoomManager__Func_2061824(void);
void VSRoomManager__Func_2061888(BOOL hasConnection);
void VSRoomManager__Func_20618A8(void);
BOOL VSRoomManager__CheckHasProfile(void);
BOOL VSRoomManager__CheckValidConsole(void);
BOOL VSRoomManager__Func_2061918(void);
void VSRoomManager__PrepareSendBuffer(void);
BOOL VSRoomManager__Func_20619B4(void);
BOOL VSRoomManager__Func_2061A24(void);
void VSRoomManager__SendData(void *data, u32 size);
void VSRoomManager__Func_2061B3C(void);
VSRoomManager__PlayerInfo *VSRoomManager__GetUnknown2(void);
void VSRoomManager__Func_2061BF0(BOOL enabled);
BOOL VSRoomManager__Func_2061C20(void);
void VSRoomManager__Func_2061C58(void);
void VSRoomManager__Func_2061C84(VSRoomManager *work);
void VSRoomManager__Func_2061D1C(VSRoomManager *work);
void VSRoomManager__Func_2061E04(VSRoomManager *work);
void VSRoomManager__Func_2061F20(VSRoomManager *work);
void VSRoomManager_Main_Init(void);
void VSRoomManager_Main_Error(void);
void VSRoomManager__Main_InitUnknown0(void);
void VSRoomManager__Main_InitUnknown2(void);
void VSRoomManager__Main_InitUnknown6(void);
void VSRoomManager__Main_InitUnknown1(void);
void VSRoomManager__Main_InitUnknown3(void);
void VSRoomManager__Main_InitUnknown4(void);
void VSRoomManager__Main_InitUnknown5(void);
void VSRoomManager__Main_InitINet(void);
void VSRoomManager__Main_InitMatchManager(void);
void VSRoomManager__Main_InitDataTransferManager(void);
void VSRoomManager__Main_HandleDataTransfer_Wireless(void);
void VSRoomManager__Main_HandleDataTransfer_Network(void);
void VSRoomManager__Main_2062F1C(void);
void VSRoomManager__Main_2062F30(void);
void VSRoomManager__Main_2062F44(void);
void VSRoomManager__Main_2062F68(void);
void VSRoomManager__Main_2062F94(void);
void VSRoomManager__Main_2062FB8(void);
void VSRoomManager__Main_2062FF8(void);
void VSRoomManager__Main_206300C(void);
void VSRoomManager_Destructor(Task *task);
void VSRoomManager__Func_2063024(void);
BOOL VSRoomManager__HandleReceiveBuffers_Wireless(VSRoomManager *work);
BOOL VSRoomManager__Func_206318C(VSRoomManager *work);
void VSRoomManager__Func_20631A0(VSRoomManager *work);
void VSRoomManager__Func_20631BC(VSRoomManager *work);
void VSRoomManager__Func_20631D8(VSRoomManager *work);
void VSRoomManager__Func_2063200(VSRoomManager *work);
void VSRoomManager__Func_206321C(VSRoomManager *work);
BOOL VSRoomManager__HandleReceiveBuffers_Network(VSRoomManager *work);
int VSRoomManager__EvalPlayerCallback_Anybody(int index, void *param);
int VSRoomManager__EvalPlayerCallback_Friends(int index, void *param);
void VSRoomManager__Func_20634D4(VSRoomManager *work);
void VSRoomManager__Func_2063510(VSRoomManager *work);
void VSRoomManager__Func_206354C(VSRoomManager *work);
void VSRoomManager__Func_2063588(VSRoomManager *work);
void VSRoomManager__Func_20635C4(VSRoomManager *work);
void VSRoomManager__SetError(VSRoomManager *work, BOOL hasError);
void VSRoomManager__Func_2063708(VSRoomManager *work);
u16 VSRoomManager__GetOpponentAIDBitmap(u32 aidBitmap, u32 myAid);
BOOL VSRoomManager__CheckBSSMatches(u8 *bss1, u8 *bss2);
void VSRoomManager__GetPlayerName(VSRoomManager__PlayerName *info);
void VSRoomManager__ReadPlayerInfo(VSRoomManager *work, VSRoomManager__PlayerInfo *info);
void VSRoomManager__InitGameRegistry(VSRoomManager *work);
void VSRoomManager__Func_2063994(VSRoomManager *work);
void VSRoomManager__Func_20639D8(VSRoomManager *work);
void VSRoomManager__InitUnknown1(VSRoomManager *work);
void VSRoomManager__Func_2063A2C(VSRoomManager *work);
void VSRoomManager__Func_2063A38(VSRoomManager *work);
BOOL VSRoomManager__Func_2063A4C(VSRoomManager *work);
BOOL VSRoomManager__Func_2063A60(VSRoomManager *work);
void VSRoomManager__SetUsingNetwork(BOOL enabled);
BOOL VSRoomManager__CheckUsingNetwork(void);
void VSRoomManager__SetUsingFriendLobby(BOOL enabled);
BOOL VSRoomManager__UseFriendLobby(void);
void VSRoomManager__SetRaceMatch(BOOL enabled);
BOOL VSRoomManager__IsRaceMatch(void);
void VSRoomManager__Func_2063B58(void);
void VSRoomManager__Func_2063B6C(void);
void VSRoomManager__Func_2063B80(void);
void VSRoomManager__Func_2063B94(void);
void VSRoomManager__Func_2063BA8(void);
WirelessManager_Unknown2068160 *VSRoomManager__Func_2063BBC(void);
WirelessManager_Unknown2067A88 *VSRoomManager__Func_2063BC8(void);
BOOL VSRoomManager__AddFriend(DWCAccFriendData *friend, char16 *name, u16 nameLength);

#ifdef __cplusplus
}
#endif

#endif // RUSH_VSROOMMANAGER_H