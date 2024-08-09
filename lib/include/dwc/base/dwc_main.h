#ifndef DWC_MAIN_H
#define DWC_MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

// --------------------
// CONSTANTS
// --------------------

#define DWC_IGNORE_GP_ERROR_ALREADY_BUDDY

#define DWC_GP_COMMAND_STRING       "GPCM"
#define DWC_GP_COMMAND_MATCH_STRING "MAT"

#define DWC_DNS_ERROR_RETRY_MAX 5
#define DWC_MAX_PLAYER_NAME     26

// --------------------
// TYPES
// --------------------

typedef void (*DWCConnectionClosedCallback)(DWCError error, BOOL isLocal, BOOL isServer, u8 aid, int index, void *param);

// --------------------
// ENUMS
// --------------------

typedef enum
{
    DWC_STATE_INIT = 0,
    DWC_STATE_AVAILABLE_CHECK,
    DWC_STATE_LOGIN,
    DWC_STATE_ONLINE,
    DWC_STATE_UPDATE_SERVERS,
    DWC_STATE_MATCHING,
    DWC_STATE_CONNECTED,
    DWC_STATE_NUM
} DWCState;

// --------------------
// STRUCTS
// --------------------

typedef struct DWCstControl
{
    GT2Socket gt2Socket;
    GT2ConnectionCallbacks gt2Callbacks;
    int gt2SendBufSize;
    int gt2RecvBufSize;

    GPConnection gpObj;
    DWCUserData *userdata;

    DWCState state;
    DWCState lastState;
    u8 aid;
    u8 ownCloseFlag;
    u16 playerName[DWC_MAX_PLAYER_NAME];
    int profileID;
    const char *gameName;
    const char *secretKey;

    DWCLoginCallback loginCallback;
    void *loginParam;
    DWCUpdateServersCallback updateServersCallback;
    void *updateServersParam;
    DWCMatchedCallback matchedCallback;
    void *matchedParam;
    DWCMatchedSCCallback matchedSCCallback;
    void *matchedSCParam;
    DWCConnectionClosedCallback closedCallback;
    void *closedParam;

    DWCLoginControl logcnt;
    DWCFriendControl friendcnt;
    DWCMatchControl matchcnt;
    DWCTransportInfo transinfo;
} DWCFriendsMatchControl;

typedef struct DWCstConnectionInfo
{
    u8 index;
    u8 aid;
    u16 reserve;
    void *param;
} DWCConnectionInfo;

// --------------------
// FUNCTIONS
// --------------------

void DWC_InitFriendsMatch(DWCFriendsMatchControl *dwccnt, DWCUserData *userdata, int productID, const char *gameName, const char *secretKey, int sendBufSize, int recvBufSize,
                                             DWCFriendData friendList[], int friendListLen);
void DWC_ShutdownFriendsMatch(void);
void DWC_ProcessFriendsMatch(void);

BOOL DWC_LoginAsync(const u16 *ingamesn, const char *reserved, DWCLoginCallback callback, void *param);
BOOL DWC_UpdateServersAsync(const char *playerName, DWCUpdateServersCallback updateCallback, void *updateParam, DWCFriendStatusCallback statusCallback, void *statusParam,
                                               DWCDeleteFriendListCallback deleteCallback, void *deleteParam);
BOOL DWC_ConnectToAnybodyAsync(u8 numEntry, const char *addFilter, DWCMatchedCallback matchedCallback, void *matchedParam, DWCEvalPlayerCallback evalCallback, void *evalParam);
BOOL DWC_ConnectToFriendsAsync(const u8 friendIdxList[], int friendIdxListLen, u8 numEntry, BOOL distantFriend, DWCMatchedCallback matchedCallback, void *matchedParam,
                                                  DWCEvalPlayerCallback evalCallback, void *evalParam);
BOOL DWC_SetupGameServer(u8 maxEntry, DWCMatchedSCCallback matchedCallback, void *matchedParam, DWCNewClientCallback newClientCallback, void *newClientParam);
BOOL DWC_ConnectToGameServerAsync(int serverIndex, DWCMatchedSCCallback matchedCallback, void *matchedParam, DWCNewClientCallback newClientCallback, void *newClientParam);
BOOL DWC_SetConnectionClosedCallback(DWCConnectionClosedCallback callback, void *param);
int DWC_CloseAllConnectionsHard(void);
int DWC_CloseConnectionHard(u8 aid);
int DWC_CloseConnectionHardBitmap(u32 *bitmap);
int DWC_GetNumConnectionHost(void);
u8 DWC_GetMyAID(void);
int DWC_GetAIDList(u8 **aidList);
u32 DWC_GetAIDBitmap(void);
BOOL DWC_IsValidAID(u8 aid);
DWCState DWC_GetState(void);
int DWC_GetLastSocketError(void);

int DWC_CloseConnectionsAsync(void);
GT2Result DWCi_GT2Startup(void);
GT2Connection DWCi_GetGT2Connection(u8 aid);
u8 DWCi_GetConnectionAID(GT2Connection connection);
u8 DWCi_GetConnectionIndex(GT2Connection connection);
void *DWCi_GetConnectionUserData(GT2Connection connection);
int DWCi_GT2GetConnectionListIdx(void);
void DWCi_ClearGT2ConnectionList(void);
GT2Connection *DWCi_GetGT2ConnectionByIdx(int index);
GT2Connection *DWCi_GetGT2ConnectionByProfileID(int profileID, int numHost);
DWCConnectionInfo *DWCi_GetConnectionInfoByIdx(int index);
BOOL DWCi_IsValidAID(u8 aid);

#ifdef __cplusplus
}
#endif

#endif // DWC_MAIN_H
